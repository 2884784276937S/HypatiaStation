//switch this out to use a database at some point
//list of ckey/ real_name and item paths
//gives item to specific people when they join if it can
//for multiple items just add mutliple entries, unless i change it to be a listlistlist
//yes, it has to be an item, you can't pick up nonitems
//Lazy people, Numbers made this use DB

/proc/EquipCustomItemsDB(mob/living/carbon/human/M)
	establish_round_db_connection()
	if(!dbcon_round.IsConnected())
		world.log << "Failed to connect to database in custom_items(). Reverting to legacy system."
		diary << "Failed to connect to database in custom_items(). Reverting to legacy system."
		EquipCustomItems(M)
		return
	var/DBQuery/query = dbcon.NewQuery("SELECT ckey, character, item FROM custom_items")
	query.Execute()
	while(query.NextRow())
		var/ckey = query.item[1]
		var/char = query.item[2]
		var/path_list = query.item[3]
	/*	if(istext(path))
			path = text2path(path)	*/
		if(ckey == M.ckey && char == M.real_name)
			var/list/Paths = text2list(path_list, ",")
			for(var/P in Paths)
				var/ok = 0
				P = trim(P) //What?
				var/path = text2path(P)
				var/obj/item/Item = new path()
				//Begining item code, i.e. if is a permit, apply real_name to document
				if(istype(Item,/obj/item/weapon/paper/fluff/mechpermit))
					var/obj/item/weapon/paper/fluff/mechpermit/Q = Item
					for(Q in M)
						Q.hname = M.real_name
						Q.update()
				else if(istype(M.back,/obj/item/weapon/storage) && M.back:contents.len < M.back:storage_slots) // Try to place it in something on the mob's back
					Item.loc = M.back
					M << "\blue <B>You feel your [M.back] suddenly get heavier.</B>"
					ok = 1
					break
				else
					for(var/obj/item/weapon/storage/S in M.contents) // Try to place it in any item that can store stuff, on the mob.
						if (S.contents.len < S.storage_slots)
							Item.loc = S
							M << "\blue <B>You feel your [S] suddenly get heavier.</B>"
							ok = 1
							break
				skip:
				if (ok == 0) // Finally, since everything else failed, place it on the ground
					Item.loc = get_turf(M.loc)
	return



/proc/EquipCustomItems(mob/living/carbon/human/M)
	// load lines
	var/file = file2text("config/custom_items.txt")
	var/lines = text2list(file, "\n")

	for(var/line in lines)
		// split & clean up
		var/list/Entry = text2list(line, ":")
		for(var/i = 1 to Entry.len)
			Entry[i] = trim(Entry[i])

		if(Entry.len < 3)
			continue;

		if(Entry[1] == M.ckey && Entry[2] == M.real_name)
			var/list/Paths = text2list(Entry[3], ",")
			for(var/P in Paths)
				var/ok = 0  // 1 if the item was placed successfully
				P = trim(P)
				var/path = text2path(P)
				var/obj/item/Item = new path()
				if(istype(Item,/obj/item/weapon/paper/fluff/mechpermit))
					var/obj/item/weapon/paper/fluff/mechpermit/Q = Item
					for(Q in M)
						Q.hname = M.real_name
						Q.update()
				else if(istype(M.back,/obj/item/weapon/storage) && M.back:contents.len < M.back:storage_slots) // Try to place it in something on the mob's back
					Item.loc = M.back
					M << "\blue <B>You feel your backpack suddenly get heavier.</B>"
					ok = 1

				else
					for(var/obj/item/weapon/storage/S in M.contents) // Try to place it in any item that can store stuff, on the mob.
						if (S.contents.len < S.storage_slots)
							Item.loc = S
							M << "\blue <B>You feel your [S] suddenly get heavier.</B>"
							ok = 1
							break


				skip:
				if (ok == 0) // Finally, since everything else failed, place it on the ground
					Item.loc = get_turf(M.loc)
	return














/*if(istype(Item,/obj/item/weapon/card/id))
					//id card needs to replace the original ID
					if(M.ckey == "nerezza" && M.real_name == "Asher Spock" && M.mind.role_alt_title && M.mind.role_alt_title != "Emergency Physician")
						//only spawn ID if asher is joining as an emergency physician
						ok = 1
						del(Item)
						goto skip
					var/obj/item/weapon/card/id/I = Item
					for(var/obj/item/weapon/card/id/C in M)
						//default settings
						I.name = "[M.real_name]'s ID Card ([M.mind.role_alt_title ? M.mind.role_alt_title : M.mind.assigned_role])"
						I.registered_name = M.real_name
						I.access = C.access
						I.assignment = C.assignment
						I.blood_type = C.blood_type
						I.dna_hash = C.dna_hash
						I.fingerprint_hash = C.fingerprint_hash
						//I.pin = C.pin

						//custom stuff
						if(M.ckey == "fastler" && M.real_name == "Fastler Greay") //This is a Lifetime ID
							I.name = "[M.real_name]'s Lifetime ID Card ([M.mind.role_alt_title ? M.mind.role_alt_title : M.mind.assigned_role])"
						else if(M.ckey == "nerezza" && M.real_name == "Asher Spock") //This is an Odysseus Specialist ID
							I.name = "[M.real_name]'s Odysseus Specialist ID Card ([M.mind.role_alt_title ? M.mind.role_alt_title : M.mind.assigned_role])"
							I.access += list(access_robotics) //Station-based mecha pilots need this to access the recharge bay.
						else if(M.ckey == "roaper" && M.real_name == "Ian Colm") //This is a Technician ID
							I.name = "[M.real_name]'s Technician ID ([M.mind.role_alt_title ? M.mind.role_alt_title : M.mind.assigned_role])"

						//replace old ID
						del(C)
						ok = M.equip_if_possible(I, slot_wear_id, 0)	//if 1, last argument deletes on fail
						break*/