
/obj/item/clothing/glasses //Also defined in clothing.dm. Left alone to keep this update concise.
	name = "glasses"
	icon = 'glasses.dmi'
	//w_class = 2.0
	//flags = GLASSESCOVERSEYES
	//slot_flags = SLOT_EYES
	//var/vision_flags = 0
	//var/darkness_view = 0 //Base human is 2. Added to base human.
	//var/invisa_view = 0 //Trumps disdark due to how darkness works.
	var/prescription = 0
	var/disdark = 0 //Used to define if the glasses should disable darkness entirely or not. Most glasses will not, but most scanners will. Setting this to 1 will lower invisibility.
/*
SEE_SELF 	 // can see self, no matter what
SEE_MOBS  = 4// can see all mobs, no matter what. =4
SEE_OBJS  = 8// can see all objs, no matter what. =8
SEE_TURFS =16// can see all turfs (and areas), no matter what. =16
SEE_PIXELS=32// if an object is located on an unlit area, but some of its pixels are.
        	 // in a lit area (via pixel_x,y or smooth movement), can see those pixels
        	 // This is set on all human mobs and cannot be unset by glasses. =32
BLIND     = 1// can't see anything normally. Handy for making glasses that only let you see specific things.
			 // Do not use to simply blind. Set mob's blinded = 1 instead.
*/

/obj/item/clothing/glasses/meson
	name = "Optical Meson Scanner"
	desc = "Used for seeing walls, floors, and stuff through anything."
	icon_state = "meson"
	item_state = "glasses"
	origin_tech = "magnets=2;engineering=2"
	vision_flags = SEE_TURFS
	disdark = 1

/obj/item/clothing/glasses/meson/prescription
	prescription = 1

/obj/item/clothing/glasses/science
	name = "Science Goggles"
	desc = "nothing"
	icon_state = "purple"
	item_state = "glasses"

/obj/item/clothing/glasses/night
	name = "Night Vision Goggles"
	desc = "You can totally see in the dark now!."
	icon_state = "night"
	item_state = "glasses"
	origin_tech = "magnets=2"
	vision_flags = SEE_TURFS
	darkness_view = 3

/obj/item/clothing/glasses/eyepatch
	name = "eyepatch"
	desc = "Yarr."
	icon_state = "eyepatch"
	item_state = "eyepatch"

/obj/item/clothing/glasses/monocle
	name = "monocle"
	desc = "Such a dapper eyepiece!"
	icon_state = "monocle"
	item_state = "headset" // lol

/obj/item/clothing/glasses/material
	name = "Optical Material Scanner"
	desc = "Very confusing glasses."
	icon_state = "material"
	item_state = "glasses"
	origin_tech = "magnets=3;engineering=3"
	vision_flags = SEE_OBJS
	disdark = 1

/obj/item/clothing/glasses/regular
	name = "Prescription Glasses"
	desc = "Made by Nerd. Co."
	icon_state = "glasses"
	item_state = "glasses"

/obj/item/clothing/glasses/regular/hipster
	name = "Prescription Glasses"
	desc = "Made by Uncool. Co."
	icon_state = "hipster_glasses"
	item_state = "hipster_glasses"

/obj/item/clothing/glasses/gglasses
	name = "Green Glasses"
	desc = "Forest green glasses, like the kind you'd wear when hatching a nasty scheme."
	icon_state = "gglasses"
	item_state = "gglasses"

/obj/item/clothing/glasses/sunglasses
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks many flashes."
	name = "sunglasses"
	icon_state = "sun"
	item_state = "sunglasses"
	darkness_view = -1

/obj/item/clothing/glasses/welding
	name = "welding goggles"
	desc = "Protects the eyes from welders, approved by the mad scientist association."
	icon_state = "welding-g"
	item_state = "welding-g"
	icon_action_button = "action_welding_g"
	var/up = 0

/obj/item/clothing/glasses/welding/attack_self()
	toggle()


/obj/item/clothing/glasses/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding goggles"
	set src in usr

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(src.up)
			src.up = !src.up
			src.flags |= GLASSESCOVERSEYES
			flags_inv |= HIDEEYES
			icon_state = initial(icon_state)
			usr << "You flip the [src] down to protect your eyes."
		else
			src.up = !src.up
			src.flags &= ~HEADCOVERSEYES
			flags_inv &= ~HIDEEYES
			icon_state = "[initial(icon_state)]up"
			usr << "You push the [src] up out of your face."

		usr.update_inv_glasses()

/obj/item/clothing/glasses/sunglasses/blindfold
	name = "blindfold"
	desc = "Covers the eyes, preventing sight."
	icon_state = "blindfold"
	item_state = "blindfold"
	//vision_flags = BLIND //Blindfolds blind via code in life.dm for superior blindness.

/obj/item/clothing/glasses/sunglasses/prescription
	prescription = 1

/obj/item/clothing/glasses/sunglasses/big
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Larger than average enhanced shielding blocks many flashes."
	icon_state = "bigsunglasses"
	item_state = "bigsunglasses"

/obj/item/clothing/glasses/sunglasses/sechud
	name = "HUDSunglasses"
	desc = "Sunglasses with a HUD."
	icon_state = "sunhud"
	var/obj/item/clothing/glasses/hud/security/hud = null

	New()
		..()
		src.hud = new/obj/item/clothing/glasses/hud/security(src)
		return

/obj/item/clothing/glasses/thermal
	name = "Optical Thermal Scanner"
	desc = "Thermals in the shape of glasses."
	icon_state = "thermal"
	item_state = "glasses"
	origin_tech = "magnets=3"
	vision_flags = SEE_MOBS
	invisa_view = SEE_INVISIBLE_LEVEL_ONE
	disdark = 0 //Not checked when invisa_view is non-zero
	darkness_view = 2

	emp_act(severity)
		if(istype(src.loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/M = src.loc
			M << "\red The Optical Thermal Scanner overloads and blinds you!"
			if(M.glasses == src)
				M.eye_blind = 3
				M.eye_blurry = 5
				M.disabilities |= NEARSIGHTED
				spawn(100)
					M.disabilities &= ~NEARSIGHTED
		..()

/obj/item/clothing/glasses/thermal/syndi	//These are now a traitor item, concealed as mesons.	-Pete
	name = "Optical Meson Scanner"
	desc = "Used for seeing walls, floors, and stuff through anything."
	icon_state = "meson"
	origin_tech = "magnets=3;syndicate=4"

/obj/item/clothing/glasses/thermal/monocle
	name = "Thermoncle"
	desc = "A monocle thermal."
	icon_state = "thermoncle"
	flags = null //doesn't protect eyes because it's a monocle, duh

/obj/item/clothing/glasses/thermal/eyepatch
	name = "Optical Thermal Eyepatch"
	desc = "An eyepatch with built-in thermal optics"
	icon_state = "eyepatch"
	item_state = "eyepatch"

/obj/item/clothing/glasses/thermal/jensen
	name = "Optical Thermal Implants"
	desc = "A set of implantable lenses designed to augment your vision"
	icon_state = "thermalimplants"
	item_state = "syringe_kit"