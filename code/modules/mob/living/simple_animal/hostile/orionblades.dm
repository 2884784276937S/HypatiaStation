/mob/living/simple_animal/hostile/orionblades
	name = "Orion Blades Shocktrooper"
	desc = "From the shadows we strike."
	icon_state = "obtrooper"
	icon_living = "obtrooper"
	icon_dead = "obtrooper_dead"
	icon_gib = "obtrooper_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = 0
	stop_automated_movement_when_pulled = 0
	maxHealth = 150
	health = 150
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punches"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/orionblades
	ranged = 1
	rapid = 1
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/weapons/laser.ogg'
	var/weapon1 = /obj/item/weapon/gun/energy/gun/nuclear
	var/weapon2
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	speed = 0
	unsuitable_atoms_damage = 15
	wall_smash = 1
	faction = "orionblades"

/mob/living/simple_animal/hostile/orionblades/Die()
	..()
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	if(weapon2)
		new weapon2 (src.loc)
	del src
	return

/mob/living/simple_animal/hostile/orionblades/Process_Spacemove(var/check_drift = 0)
	return