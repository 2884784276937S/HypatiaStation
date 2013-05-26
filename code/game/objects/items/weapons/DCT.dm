/obj/item/weapon/dct
	name = "door-configuration-tool (DCT)"
	desc = "A device used to configure airlocks."
	icon = 'icons/obj/items.dmi'
	icon_state = "rcd"
	opacity = 0
	density = 0
	anchored = 0.0
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 10.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = 3.0
	m_amt = 50000
	origin_tech = "engineering=6;materials=3"
	var/datum/effect/effect/system/spark_spread/spark_system
	var/working = 0
	var/mode = 1
	var/disabled = 0

	New()
		src.spark_system = new /datum/effect/effect/system/spark_spread
		spark_system.set_up(5, 0, src)
		spark_system.attach(src)
		return

	attack_self(mob/user)
		//Change the mode
		playsound(src.loc, 'sound/effects/pop.ogg', 50, 0)
		switch(mode)
			if(1)
				mode = 2
				user << "<span class='notice'>Changed mode to 'Type'</span>"
				if(prob(20))
					src.spark_system.start()
				return
			if(2)
				mode = 3
				user << "<span class='notice'>Changed mode to 'Bolt'</span>"
				if(prob(20))
					src.spark_system.start()
				return
			if(3)
				mode = 4
				user << "<span class='notice'>Changed mode to 'Access'</span>"
				if(prob(20))
					src.spark_system.start()
				return

			if(4)
				mode = 5
				user << "<span class='notice'>Changed mode to 'Open'</span>"
				if(prob(20))
					src.spark_system.start()
				return
			if(5)
				mode = 1
				user << "<span class='notice'>Changed mode to 'Repair'</span>"
				if(prob(20))
					src.spark_system.start()
				return


	proc/activate()
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)

	afterattack(atom/A, mob/user)
		if(disabled && !isrobot(user))
			return 0
		if(istype(A,/area/shuttle)||istype(A,/turf/space/transit))
			return 0
		if(!(istype(A, /turf) || istype(A, /obj/machinery/door/airlock)))
			return 0

		switch(mode)
			if(2)
				if(istype(A, /obj/machinery/door/airlock))
					var/obj/machinery/door/airlock/B = A
					B.locked = 1
					B.close()
					user << "Chaning Airlock Type..."
					activate()
					changecolour(A)
					del(A)
					return 1

			if(3)
				if(istype(A, /obj/machinery/door/airlock))
					user << "Changing Airlock Lock State..."
					playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
					var/obj/machinery/door/airlock/B = A
					B.locked = !B.locked
					B.update_icon()
					if(!B.locked)
						B.open()
					return 1

			if(4)
				if(istype(A, /obj/machinery/door/airlock))
					user << "Changing Airlock Access..."
					playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
					//access(user, A)
					spawn(50)
					user << "ERROR: FUNCTIONALITY UNSUPPORTED"
					return 1

			if(4)
				if(istype(A, /obj/machinery/door/airlock))
					user << "Reparing Airlock..."
					playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
					var/obj/machinery/door/airlock/Q = new /obj/machinery/door/airlock
					var/obj/machinery/door/airlock/B = A
					Q.name = B.name
					Q.icon = B.icon
					Q.desc = B.desc
					del(A)
					return 1

			if(1)
				if(istype(A, /obj/machinery/door/airlock))
					user << "Forcefully opening airlock..."
					playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
					//access(user, A)
					var/obj/machinery/door/airlock/B = A
					var/lock = B.locked
					B.locked = 0
					B.open()
					spawn(100)
					B.locked = lock
					return 1

			else
				user << "ERROR: RCD in MODE: [mode] attempted use by [user]. Send this text #coderbus or an admin."
				return 0

/obj/item/weapon/dct/proc/changecolour(var/obj/machinery/door/airlock/D as obj)
	var/type = input("Please select door type:","Door Type") as null|anything in list("Atmospherics", "Command", "Engineering", "External", "Freezer", "Hatch", "Normal", "Maintenance", "Medical", "Mining", "Morgue", "Research", "Science", "Security", "High-Tech Security", "Vault", "Cancel")
	var/door = lowertext(type)
	if(D.glass)
		door = "glass_[door]"
	if(door == "High-Tech Security")
		door = "highsecurity"
	door = "/obj/machinery/door/airlock/[door]"
	var/obj/machinery/door/airlock/E = D
	var/obj/machinery/door/airlock/N = new door
	N.loc = E.loc
	N.fingerprintshidden = E.fingerprintshidden
	N.fingerprints = E.fingerprints
	N.req_access = E.req_access
	N.req_access_txt = E.req_access_txt
	N.locked = E.locked
	N.lockdownbyai = E.lockdownbyai
	N.closeOther = E.closeOther
	N.closeOtherId = E.closeOtherId
	N.dir = E.dir
	N.electronics = E.electronics
	N.safe = E.safe
	N.aiControlDisabled = E.aiControlDisabled
	N.aiDisabledIdScanner = E.aiDisabledIdScanner
	N.aiHacking = E.aiHacking
	del(E)
	del(D)
	return


/*

/obj/item/weapon/dct/proc/access(mob/user as mob, var/obj/machinery/door/A as obj)

	req_access = list(access_engine)

	var/list/conf_access = null
	var/last_configurator = null

	if (!ishuman(user))
		return ..(user)


	var/t1 = text("<B>Access control</B><br>\n")


	if (last_configurator)
		t1 += "Operator: [last_configurator]<br>"


	t1 += "<a href='?src=\ref[src];logout=1'>Block</a><hr>"


	t1 += conf_access == null ? "<font color=red>All</font><br>" : "<a href='?src=\ref[src];access=all'>All</a><br>"

	t1 += "<br>"

	var/list/accesses = get_all_accesses()
	for (var/acc in accesses)
		var/aname = get_access_desc(acc)

		if (!conf_access || !conf_access.len || !(acc in conf_access))
			t1 += "<a href='?src=\ref[src];access=[acc]'>[aname]</a><br>"
		else
			t1 += "<a style='color: red' href='?src=\ref[src];access=[acc]'>[aname]</a><br>"

	t1 += text("<p><a href='?src=\ref[];close=1'>Close</a></p>\n", src)

	user << browse(t1, "window=airlock_electronics")
	onclose(user, "airlock")

*/

