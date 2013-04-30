//wip wip wup
/obj/structure/mirror
	name = "mirror"
	desc = "Mirror mirror on the wall, who's the most robust of them all?"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "mirror"
	density = 0
	anchored = 1
	var/shattered = 0


/obj/structure/mirror/attack_hand(mob/user as mob)
	if(shattered)	return

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/species = "Human"
		if(H.dna.mutantrace) //When Species is checked, it must be properly capitalized. I could think of a better way to do this so blah.
			switch(H.dna.mutantrace)
				if("tajaran")
					species = "Tajaran"
				if("lizard")
					species = "Soghun"
				if("skrell")
					species = "Skrell"
/*				if("plant")
					species = "Fennodi"
				if("slime")
					species = "Slime"
				if("shadow")
					species = "Shadow" //Commented these out due to not having their own hairs, so they'll use Human instead.
				if("golem")
					species = "Golem"
*/
				else
					species = "Human" //Always fall back to Human
		var/userloc = H.loc

		//see code/modules/mob/new_player/preferences.dm at approx line 545 for comments!
		//this is largely copypasted from there.

		//handle facial hair (if necessary)

		var/list/valid_facialhairstyles = list()
		for(var/facialhairstyle in facial_hair_styles_list)
			var/datum/sprite_accessory/S = facial_hair_styles_list[facialhairstyle]
			if(H.gender == MALE && S.gender == FEMALE)
				continue
			if(H.gender == FEMALE && S.gender == MALE)
				continue
			if( !(species in S.species_allowed))
				continue

			valid_facialhairstyles[facialhairstyle] = facial_hair_styles_list[facialhairstyle]

		var/new_f_style = input(user, "Select a facial hair style", "Grooming")  as null|anything in valid_facialhairstyles
		if(userloc != H.loc) return	//no tele-grooming
		if(new_f_style)
			H.f_style = new_f_style

		//handle normal hair

		var/list/valid_hairstyles = list()
		for(var/hairstyle in hair_styles_list)
			var/datum/sprite_accessory/S = hair_styles_list[hairstyle]
			if(H.gender == MALE && S.gender == FEMALE)
				continue
			if(H.gender == FEMALE && S.gender == MALE)
				continue
			if( !(species in S.species_allowed))
				continue

			valid_hairstyles[hairstyle] = hair_styles_list[hairstyle]

		var/new_h_style = input(user, "Select a hair style", "Grooming")  as null|anything in valid_hairstyles
		if(userloc != H.loc) return	//no tele-grooming
		if(new_h_style)
			H.h_style = new_h_style

		H.update_hair()


/obj/structure/mirror/proc/shatter()
	if(shattered)	return
	shattered = 1
	icon_state = "mirror_broke"
	playsound(src, "shatter", 70, 1)
	desc = "Oh no, seven years of bad luck!"


/obj/structure/mirror/bullet_act(var/obj/item/projectile/Proj)
	if(prob(Proj.damage * 2))
		if(!shattered)
			shatter()
		else
			playsound(src, 'sound/effects/hit_on_shattered_glass.ogg', 70, 1)
	..()


/obj/structure/mirror/attackby(obj/item/I as obj, mob/user as mob)
	if(shattered)
		playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, 1)
		return

	if(prob(I.force * 2))
		visible_message("<span class='warning'>[user] smashes [src] with [I]!</span>")
		shatter()
	else
		visible_message("<span class='warning'>[user] hits [src] with [I]!</span>")
		playsound(src.loc, 'sound/effects/Glasshit.ogg', 70, 1)


/obj/structure/mirror/attack_alien(mob/user as mob)
	if(islarva(user)) return
	if(shattered)
		playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, 1)
		return
	user.visible_message("<span class='danger'>[user] smashes [src]!</span>")
	shatter()


/obj/structure/mirror/attack_animal(mob/user as mob)
	if(!isanimal(user)) return
	var/mob/living/simple_animal/M = user
	if(M.melee_damage_upper <= 0) return
	if(shattered)
		playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, 1)
		return
	user.visible_message("<span class='danger'>[user] smashes [src]!</span>")
	shatter()


/obj/structure/mirror/attack_slime(mob/user as mob)
	if(!isslimeadult(user)) return
	if(shattered)
		playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, 1)
		return
	user.visible_message("<span class='danger'>[user] smashes [src]!</span>")
	shatter()