/mob/new_player/Login()
	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	if(join_motd)
		src << "<div class=\"motd\">[join_motd]</div>"

	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	if(length(newplayer_start))
		loc = pick(newplayer_start)
	else
		loc = locate(1,1,1)
	lastarea = loc

	sight |= SEE_TURFS
	player_list |= src

	if((config.admin_legacy_system) && (src.ckey == "Askarn"))
		src << "<FONT COLOR=RED SIZE=2><B>Owen!  Make the server use SQL-admin-system already...</B></FONT>"
		spawn(50)
		message_admins("Legacy (non-SQL) admin system in use.  Please contact your system administrator to resolve this issue.")
		//Sorry, it was the only way! --Numbers

/*
	var/list/watch_locations = list()
	for(var/obj/effect/landmark/landmark in landmarks_list)
		if(landmark.tag == "landmark*new_player")
			watch_locations += landmark.loc

	if(watch_locations.len>0)
		loc = pick(watch_locations)
*/
	new_player_panel()
	spawn(40)
		if(client)
			handle_privacy_poll()
			client.playtitlemusic()
