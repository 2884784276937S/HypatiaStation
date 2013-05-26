//Cat
/mob/living/simple_animal/cat
	name = "cat"
	desc = "A domesticated, feline pet. Has a tendency to adopt crewmembers."
	icon_state = "cat"
	icon_living = "cat"
	icon_dead = "cat_dead"
	speak = list("Meow!","Esp!","Purr!","HSSSSS", "Meow?", "Grrr!")
	speak_emote = list("purrs", "meows")
	emote_hear = list("meows","mews", "growls", "moans")
	emote_see = list("shakes its head", "shivers", "sticks its tongue out", "pounces", "licks its fur")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "kicks the"
	var/turns_since_scan = 0
	var/mob/living/simple_animal/mouse/movement_target
	min_oxy = 16 //Require atleast 16kPA oxygen
	minbodytemp = 223		//Below -50 Degrees Celcius
	maxbodytemp = 323	//Above 50 Degrees Celcius

/mob/living/simple_animal/cat/Life()
	//MICE!
	if((src.loc) && isturf(src.loc))
		if(!stat && !resting && !buckled)
			for(var/mob/living/simple_animal/mouse/M in view(1,src))
				if(!M.stat)
					M.splat()
					emote(pick("\red splats the [M]!","\red toys with the [M]","worries the [M]"))
					movement_target = null
					stop_automated_movement = 0
					break

	..()

	for(var/mob/living/simple_animal/mouse/snack in oview(src, 3))
		if(prob(15))
			emote(pick("hisses and spits!","mrowls fiercely!","eyes [snack] hungrily."))
		break

	if(!stat && !resting && !buckled)
		turns_since_scan++
		if(turns_since_scan > 5)
			walk_to(src,0)
			turns_since_scan = 0
			if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))
				movement_target = null
				stop_automated_movement = 0
			if( !movement_target || !(movement_target.loc in oview(src, 3)) )
				movement_target = null
				stop_automated_movement = 0
				for(var/mob/living/simple_animal/mouse/snack in oview(src,3))
					if(isturf(snack.loc) && !snack.stat)
						movement_target = snack
						break
			if(movement_target)
				stop_automated_movement = 1
				walk_to(src,movement_target,0,3)

////RUNTIME IS ALIVE! SQUEEEEEEEE~
//HK IS IN THE CODE
/mob/living/simple_animal/cat/HappyKitten
	name = "Happy Kitten"
	desc = "Its fur has the look and feel of velvet, and it's tail quivers occasionally.\n For some reason, staring at it makes the words \"terrible person\" echo in your head."


//PHEAR THE GHOSTKITTEH
/mob/living/simple_animal/cat/ghost
	name = "Ghostly cat"
	desc = "Fear the ghost kitty."
	icon_state = "ghostcat"
	icon_living = "ghostcat"
	response_help  = "tries to pet the"
	response_disarm = "tries to push aside the"
	response_harm   = "tries to kick the"

//OMG ITS A KITTEN!
/mob/living/simple_animal/cat/kitten
	name = "Kitten"
	desc = "It's sooo tiny and cute!"
	icon_state = "kitty"
	icon_living = "kitty"
	icon_dead = "kitty_dead"