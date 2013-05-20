/*
Contains most of the procs that are called when a mob is attacked by something

bullet_act
ex_act
meteor_act
emp_act
//OBSIDIAI VERSION
*/

/mob/living/carbon/rock/obsidiai/bullet_act(var/obj/item/projectile/P, var/def_zone)

	if(1 == 1) //I'll get rid of this, ignore it
		if(1 == 1)
			if(1 == 1)
				visible_message("\red <B>The [P.name] gets reflected by \proper[src]\s obsidian body!</B>")

				// Find a turf near or on the original location to bounce to
				if(P.starting)
					var/new_x = P.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/new_y = P.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/turf/curloc = get_turf(src)

					// redirect the projectile
					P.original = locate(new_x, new_y, P.z)
					P.starting = curloc
					P.current = curloc
					P.firer = src
					P.yo = new_y - curloc.y
					P.xo = new_x - curloc.x

				return -1 // complete projectile permutation

	if(check_shields(P.damage, "the [P.name]"))
		P.on_hit(src, 2)
		return 2
	return (..(P , def_zone))

/mob/living/carbon/rock/obsidiai/proc/attacked_by(var/obj/item/I, var/mob/living/user, var/def_zone)
	if(!I || !user)	return 0

	var/target_zone = get_zone_with_miss_chance(user.zone_sel.selecting, src)
	if(!target_zone)
		visible_message("\red <B>[user] misses [src] with \the [I]!")
		return

	var/datum/organ/external/affecting = get_organ(target_zone)
	if (!affecting)
		return
	if(affecting.status & ORGAN_DESTROYED)
		user << "What [affecting.display_name]?"
		return
	var/hit_area = affecting.display_name

	if((user != src) && check_shields(I.force, "the [I.name]"))
		return 0

	if(I.attack_verb.len)
		visible_message("\red <B>\the[user] has attempted to [pick(I.attack_verb)] \proper[src] in the [hit_area] with \the[I.name]!</B>")
	else
		visible_message("\red <B>\the[user] has attempted to attack \proper[src] in the [hit_area] with \the[I.name]!</B>")

	var/armor = run_armor_check(affecting, "melee", "Your obsidian skin has protected your [hit_area].", "Your obsidian skin has softened hit to your [hit_area].")
	if(armor >= 2)	return 0
	if(!I.force)	return 0

	apply_damage(I.force, I.damtype, affecting, armor , I.sharp, I.name)
/*
	var/bloody = 0
	if(((I.damtype == BRUTE) || (I.damtype == HALLOSS)) && prob(25 + (I.force * 2)))
		I.add_blood(src)	//Make the weapon bloody, not the person.
//		if(user.hand)	user.update_inv_l_hand()	//updates the attacker's overlay for the (now bloodied) weapon
//		else			user.update_inv_r_hand()	//removed because weapons don't have on-mob blood overlays
		if(prob(33))
			bloody = 1
			var/turf/location = loc
			if(istype(location, /turf/simulated))
				location.add_blood(src)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				if(get_dist(H, src) > 1) //people with TK won't get smeared with blood
					H.bloody_body(src)
					H.bloody_hands(src)

		switch(hit_area)
			if("head")//Harder to score a stun but if you do it lasts a bit longer
				if(prob(I.force))
					apply_effect(20, PARALYZE, armor)
					visible_message("\red <B>[src] has been knocked unconscious!</B>")
					if(src != user && I.damtype == BRUTE)
						ticker.mode.remove_revolutionary(mind)

				if(bloody)//Apply blood
					if(wear_mask)
						wear_mask.add_blood(src)
						update_inv_wear_mask(0)
					if(head)
						head.add_blood(src)
						update_inv_head(0)
					if(glasses && prob(33))
						glasses.add_blood(src)
						update_inv_glasses(0)

			if("chest")//Easier to score a stun but lasts less time
				if(prob((I.force + 10)))
					apply_effect(5, WEAKEN, armor)
					visible_message("\red <B>[src] has been knocked down!</B>")

				if(bloody)
					bloody_body(src) */