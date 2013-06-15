// Reports are a way to notify admins of wrongdoings that happened
// while no admin was present. They work a bit similar to news, but
// they can only be read by admins and moderators.

//Modified/Completed by 2884784276937S

// a single admin report
datum/admin_report/var
	ID     // the ID of the report
	body   // the content of the report
	author // key of the author
	date   // date on which this was created
	done   // whether this was handled
	doneby //Who handled it
	donewhen //when it was handled
	logdate //date in a format that can be used to retrieve logs

	offender_key // store the key of the offender
	offender_cid // store the cid of the offender
	offender_name //store the name of the offender's mob

datum/report_topic_handler
	Topic(href,href_list)
		..()
		var/client/C = locate(href_list["client"])
		if(href_list["action"] == "show_reports")
			C.display_admin_reports()
		else if(href_list["action"] == "remove")
			C.mark_report_done(text2num(href_list["ID"]))
		else if(href_list["action"] == "edit")
			C.edit_report(text2num(href_list["ID"]))
		else if(href_list["action"] == "logs")
			var/date = href_list["param"]
			var/type = alert("Which log would you like to view?",,"Attack","Server","HREFs")
			switch(type)
				if("Attack")
					C.view_atk_log_for(date)
				if("Server")
					C.view_txt_log_for(date)
				if("HREFs")
					C.view_href_log_for(date)
				else
					src << "Something weird hapened.  Reverting to Server logs."
					C.view_txt_log_for(date)
		//	C.getserverlog()

var/datum/report_topic_handler/report_topic_handler

world/New()
	..()
	report_topic_handler = new

// add a new news datums
proc/make_report(body, author, okey, cid, oname)
	var/savefile/Reports = new("data/reports.sav")
	var/list/reports
	var/lastID

	Reports["reports"]   >> reports
	Reports["lastID"] >> lastID

	if(!reports) 	reports = list()
	if(!lastID) 	lastID = 0

	var/datum/admin_report/created = new()
	created.ID 		= ++lastID
	created.body 	= body
	created.author 	= author
	created.date    = world.realtime
	created.done    = 0
	created.offender_key = okey
	created.offender_cid = cid
	created.offender_name = oname

	reports.Insert(1, created)

	Reports["reports"]   << reports
	Reports["lastID"] << lastID

// load the reports from disk
proc/load_reports()
	var/savefile/Reports = new("data/reports.sav")
	var/list/reports

	Reports["reports"] >> reports

	if(!reports) reports = list()

	return reports

// check if there are any unhandled reports
client/proc/unhandled_reports()
	if(!src.holder) return 0
	var/list/reports = load_reports()

	for(var/datum/admin_report/N in reports)
		if(N.done)
			continue
		else return 1

	return 0

// checks if the player has an unhandled report against him
client/proc/is_reported()
	var/list/reports = load_reports()

	for(var/datum/admin_report/N in reports) if(!N.done)
		if(N.offender_key == src.key)
			return 1

	return 0

// display only the reports that haven't been handled
client/verb/display_admin_reports()
	set category = "Player"
	set name = "Display Admin Reports"
	if(!src.holder)
		display_player_reports()
		return

	if(alert("Who's reports would you live to view?",,"Mine","Everyone's") != "Everyone's")
		display_player_reports()
		return


	var/list/reports = load_reports()

	var/output = ""
	output += "<B><H3>Admin Reports (Admin-Mode)</H3></B>"
	for(var/datum/admin_report/N in reports)
		output += "<b>Reported player:</b> [N.offender_key]/([N.offender_name]) (CID: [N.offender_cid])<br>"
		output += "<b>Offense:</b>[N.body]<br>"
		output += "<small>Occured at [time2text(N.date,"MM/DD hh:mm:ss")]</small><br>"
		output += "<a href='?src=\ref[report_topic_handler];client=\ref[src];action=logs;param=[N.date]'><small>Retrieve Logs</small></a><br>"
		output += "<small>authored by <i>[N.author]</i></small><br>"
		if(!N.done)
			output += " <a href='?src=\ref[report_topic_handler];client=\ref[src];action=remove;ID=[N.ID]'>Flag as Handled</a>"
			if(N.author == src.ckey)
				output += " <a href='?src=\ref[report_topic_handler];client=\ref[src];action=edit;ID=[N.ID]'>Edit</a>"
		else
			output += "<B>Report Handled by [N.doneby]</B><br>"
			output += "<small>at <B>[time2text(N.donewhen,"MM/DD hh:mm:ss")]</B></small><br>"
		output += "<br>"
		output += "<br>"
	usr << browse(output, "window=news;size=600x400")

client/verb/display_player_reports()
	set category = "Player"
	set name = "Display Your Admin Reports"
	set hidden = 1
	var/list/reports = load_reports()
	var/output = ""

	// load the list of unhandled reports
	output += "<B><H3>Your Admin Reports ([src.holder ? "Admin-Mode" : "Player-Mode"])</H3></B>"
	for(var/datum/admin_report/N in reports)
		if(N.author == src.key)
			output += "<b>Reported player:</b> [N.offender_key]/([N.offender_name]) (CID: [N.offender_cid])<br>"
			output += "<b>Offense:</b>[N.body]<br>"
			output += "<small>Occured at [time2text(N.date,"MM/DD hh:mm:ss")]</small><br>"
			if(src.holder)
				output += "<a href='?src=\ref[report_topic_handler];client=\ref[src];action=logs;param=[N.date]'><small>Retrieve Logs</small></a><br>"
			output += "<small>authored by <i>[N.author]</i></small><br>"
			if(!N.done)
				output += " <a href='?src=\ref[report_topic_handler];client=\ref[src];action=edit;ID=[N.ID]'>Edit</a>"
			else
				output += "<B>Report Handled by [N.doneby]</B><br>"
				output += "<small>at <B>[time2text(N.donewhen,"MM/DD hh:mm:ss")]</B></small><br>"
			output += "<br>"
			output += "<br>"
	usr << browse(output, "window=news;size=600x400")


client/verb/Report(mob/M as mob in world)
	set category = "Player"
	set name = "Create Admin Report"

	var/CID = "Unknown"
	if(M.client)
		CID = M.client.computer_id

	var/body = input(src.mob, "Describe in detail what you're reporting [M] for", "Report") as null|message
	if(!body) return


	make_report(body, key, M.key, CID, M.name)

	spawn(1)
		display_admin_reports()

client/proc/mark_report_done(ID as num)
	if(!src.holder)
		return

	var/savefile/Reports = new("data/reports.sav")
	var/list/reports

	Reports["reports"]   >> reports

	var/datum/admin_report/found
	for(var/datum/admin_report/N in reports)
		if(N.ID == ID)
			found = N
	if(!found) src << "<b>* An error occured, sorry.</b>"

	found.done = 1
	found.doneby = src.ckey
	found.donewhen = world.realtime

	Reports["reports"]   << reports


client/proc/edit_report(ID as num)
//	if(!src.holder)
//		src << "<b>You tried to modify the news, but you're not an admin!"
//		return

	var/savefile/Reports = new("data/reports.sav")
	var/list/reports

	Reports["reports"]   >> reports

	var/datum/admin_report/found
	for(var/datum/admin_report/N in reports)
		if(N.ID == ID)
			found = N
	if(!found) src << "<b>* An error occured, sorry.</b>"

	var/edit = "<BR>Edited at <B>[time2text(world.realtime,"MM/DD hh:mm:ss")]</B><BR>"
	var/body = input(src.mob, "Enter a body for the news", "Body") as null|message
	if(!body) return
	body = edit + body

	found.body = found.body + body

	Reports["reports"]   << reports
