//switch this out to use a database at some point
//list of ckey/ real_name and item paths
//gives item to specific people when they join if it can
//for multiple items just add mutliple entries, unless i change it to be a listlistlist
//yes, it has to be an item, you can't pick up nonitems
/proc/EquipCustomItems(mob/living/carbon/human/M)
	// load lines
	// SQL in use?
	//requip: //incase DB failed, start again
	if(config.admin_legacy_system)	//I should make this its own variable --Numbers
		removemelater: //To disable the incomplete SQL code, if SQL does get used
		//it justs jumps to the non-sql code
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
					//Handle the holder name thingy, for the permits --Numbers
						var/obj/item/fluff/mechpermit/Z = Item
						for(var/obj/item/fluff/mechpermit/C in M)
							Z.hname = "[M.real_name]"
							Z.name = "[M.real_name]'s Military Exosuit Manufacturing Permit"
					if(istype(Item,/obj/item/weapon/card/id))
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

							//replace old ID
							del(C)
							ok = M.equip_if_possible(I, slot_wear_id, 0)	//if 1, last argument deletes on fail
							break
					else if(istype(M.back,/obj/item/weapon/storage) && M.back:contents.len < M.back:storage_slots) // Try to place it in something on the mob's back
						world.log << "Stuffed into something"
						Item.loc = M.back
						ok = 1

					else
						for(var/obj/item/weapon/storage/S in M.contents) // Try to place it in any item that can store stuff, on the mob.
							if (S.contents.len < S.storage_slots)
								world.log << "It went somewhere... who cares"
								Item.loc = S
								ok = 1
								break

					skip:
					if (ok == 0) // Finally, since everything else failed, place it on the ground
						Item.loc = get_turf(M.loc)
	else
		goto removemelater
		/*
		//Custom Items use SQL
		//This code is incomplete (and there's more, not in here) ignore its mesiness and/or imcomplete/nonworkiness. --Numbers
		//The word.log stuff is tempoary, debugging this - will remove when this code is done --Numbers

		establish_db_connection()
		/*if(!dbcon.IsConnected())  //I should fix this
			world.log << "Failed to connect to database in load_admins(). Reverting to legacy system."
			diary << "Failed to connect to database in load_admins(). Reverting to legacy system."
			config.admin_legacy_system = 1
			goto requip
			return*/

		var/DBQuery/query = dbcon.NewQuery("SELECT id, ckey, name, path FROM erro_items")
		query.Execute()
		world.log << "DB Spawning"
		while(query.NextRow())
			world.log << "Next row spawning"
			//var/id = query.item[1]
			//var/ckey = query.item[2]
			//var/name = query.item[3]
			//var/path = query.item[4]

			// split & clean up
			//if(!ckey || !name || !path)
			//	continue;

			if(query.item[2] == M.ckey && query.item[3] == M.real_name)
				var/ok = 0  // 1 if the item was placed successfully
				world.log << "Now processing:"
				world.log << query.item[1]
				world.log << query.item[2]
				world.log << query.item[3]
				world.log << query.item[4]
				var/path = query.item[3]
				var/obj/item/Item = new path()
				if(istype(Item,/obj/item/weapon/card/id))
					//id card needs to replace the original ID
					world.log << "ID Custom Spawn"
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
						break
				else if(istype(M.back,/obj/item/weapon/storage) && M.back:contents.len < M.back:storage_slots) // Try to place it in something on the mob's back
					Item.loc = M.back
					ok = 1

				else
					for(var/obj/item/weapon/storage/S in M.contents) // Try to place it in any item that can store stuff, on the mob.
						if (S.contents.len < S.storage_slots)
							Item.loc = S
							ok = 1
							break

				skip:
				if (ok == 0) // Finally, since everything else failed, place it on the ground
					Item.loc = get_turf(M.loc)
					world.log << "Successfully spawned an item" */