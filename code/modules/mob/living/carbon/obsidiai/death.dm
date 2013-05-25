/*
/mob/living/carbon/rock/obsidiai/gib()
	death(1)
	var/atom/movable/overlay/animation = null
	monkeyizing = 1
	canmove = 0
	icon = null
	invisibility = 101

	animation = new(loc)
	animation.icon_state = "blank"
	animation.icon = 'icons/mob/mob.dmi'
	animation.master = src

	flick("gibbed-m", animation)
	gibs(loc, viruses, dna)

	spawn(15)
		if(animation)	del(animation)
		if(src)			del(src)

/mob/living/carbon/monkey/dust()
	death(1)
	var/atom/movable/overlay/animation = null
	monkeyizing = 1
	canmove = 0
	icon = null
	invisibility = 101

	animation = new(loc)
	animation.icon_state = "blank"
	animation.icon = 'icons/mob/mob.dmi'
	animation.master = src

	flick("dust-m", animation)
	new /obj/effect/decal/cleanable/ash(loc)

	spawn(15)
		if(animation)	del(animation)
		if(src)			del(src)
*/

/mob/living/carbon/rock/obsidiai/death(gibbed)
	if(stat == DEAD)	return
	if(healths)			healths.icon_state = "health5"
	stat = DEAD

	if(!gibbed)
		for(var/mob/O in viewers(src, null))
			O.show_message("<b>[name]</b>'s aura extuingishes as it slowly collapses...", 1)
	update_canmove()
	if(blind)	blind.layer = 0

	ticker.mode.check_win()

	return ..(gibbed)