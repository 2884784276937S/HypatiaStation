hi
// Add custom items you give to people here, and put their icons in custom_items.dmi
// Remember to change 'icon = 'custom_items.dmi'' for items not using /obj/item/fluff as a base
// Clothing item_state doesn't use custom_items.dmi. Just add them to the normal clothing files.

/obj/item/fluff // so that they don't spam up the object tree
	icon = 'custom_items.dmi'
	w_class = 1.0

//////////////////////////////////
////////// Fluff Items ///////////
//////////////////////////////////

/obj/item/weapon/paper/fluff/mechpermit
	name = "military exosuit manufacturing permit"
	icon_state = "fingerprint1"
	icon = 'icons/obj/card.dmi'
	var/hname = ""
	info = "<h4><center><b>Military Exosuit Manufacturing Permit</b></center></h4> \
	<br><br> \
	This permit recognizes that the holder of this document, an employee of NanoTrasen, has official Nanotrasen approval for the manafacturing and \
	testing of combat variant, military grade mechanised exosuits. \
	Holders of this permit are held to a higher standard of \
	responsibility due to the to the sensitive nature of military exosuit \
	construction and operations. Permit holders are to follow the terms \
	and conditions of this legally binding contract. A complete list of \
	these terms and conditions can be found on the bottom of the permit. \
	<br> \
	<b>NOTE: Due to forgery issues it is highly recommended that heads of \
	staff contact CentCom to confirm the validity of this contract</b> \
	<br><br> \
	-TERMS AND CONDITIONS- \
	<br><br> \
	This is an in depth list of all terms and conditions of the permit \
	holder. Refusal to follow the guidelines stated below may result in \
	but not limited to: demotion, removal of permit, high fine, and/or \
	incarceration. \
	<br><br> \
	<b>Condition A.: Permit holders are to present this document to any head \
	of staff or security personnel when requested.</b> \
	<br> \
	<b>A.B:</b> Permit holders reserve the right to deny any staff or head of \
	staff access to a constructed military exosuits built by the permit \
	holder. with the exception of (B. Conditions) Permit holders may not use this \
	right to bar access to any military exosuits NOT built by them \
	<br> \
	<b>A.C:</b> Under no circumstances may the military exosuit built by the \
	permit holder be driven freely about the station at any time with the \
	exception of delivering it to a securing zone and/or the transfer \
	shuttle. Another exceptions to this condition is stated in the (B. conditions) \
	<br> \
	<b>A.D:</b> Under no circumstances may the military exosuit built by the \
	permit holder be armed with weaponry designed to kill or incapacitate \
	even while idle, with the exception of (B. conditions) \
	<br> \
	<b>A.E:</b> All military exosuits built by the permit holder MUST be \
	transferred back to centcom at the end of all shifts via the main \
	transfer shuttle and/or emergency pods. Inability to transfer \
	military exosuits may result in the permit holder being put up for review. \
	<br><br> \
	<b>Condition B.: When on a code red alert military exosuits may be armed and operated by the permit holder and/or station security staff to help defend the station and its staff.</b> \
	<br><br> \
	<b>B.B:</b> When on a code red alert any security staff reserve the right to commandeer a military exosuit. The permit holder MUST yeild to security personnel upon request. \
	<br> \
	<b>B.C:</b> Upon return to code blue or green the permit holder has the right to re-commandeer a military exosuit built by them. Security personnel refusing to give control of the exosuit back to the permit holder are to be considered a threat to station order and security and should be reported ASAP. \
	<br> \
	<b>B.D:</b> On code red permit holders operating a military exosuit may not cause reckless damage to the station. Damage reports deemed 'too excessive' for the situation may result in the permit holder being put up for review. \
	<br> \
	<b>B.E:</b> In the event that there is a hostile attack on the station and the security level has not been elevated for whatever reason. The permit holder may use their military exosuit to help defend the station and its staff as needed. Misuse of \this condition WILL result in the permit holder being put up for review. \
	<i>This permit has been stamped with the Office of Military Research and Construction's stamp</i>"

/obj/item/weapon/paper/fluff/mechpermit/attack_self(mob/user as mob)
	for(var/mob/O in viewers(user, null))
		O.show_message(text("[] shows you: \icon[] []: assigned to: [].  You feel your brain melting, just glancing at the legal jargon.", user, src, name, hname), 1)

	src.add_fingerprint(user)
	return
/obj/item/weapon/paper/fluff/mechpermit/proc/update()
	info = "<h4><center><b>Military Exosuit Manufacturing Permit</b></center></h4> \
	<br><br> \
	This permit recognizes that the holder of this document, [src.hname], has official Nanotrasen approval for the manafacturing and \
	testing of combat variant, military grade mechanised exosuits. \
	Holders of this permit are held to a higher standard of \
	responsibility due to the to the sensitive nature of military exosuit \
	construction and operations. Permit holders are to follow the terms \
	and conditions of this legally binding contract. A complete list of \
	these terms and conditions can be found on the bottom of the permit. \
	<br> \
	<b>NOTE: Due to forgery issues it is highly recommended that heads of \
	staff contact CentCom to confirm the validity of this contract</b> \
	<br><br> \
	-TERMS AND CONDITIONS- \
	<br><br> \
	This is an in depth list of all terms and conditions of the permit \
	holder. Refusal to follow the guidelines stated below may result in \
	but not limited to: demotion, removal of permit, high fine, and/or \
	incarceration. \
	<br><br> \
	<b>Condition A.: Permit holders are to present this document to any head \
	of staff or security personnel when requested.</b> \
	<br> \
	<b>A.B:</b> Permit holders reserve the right to deny any staff or head of \
	staff access to a constructed military exosuits built by the permit \
	holder. with the exception of (B. Conditions) Permit holders may not use this \
	right to bar access to any military exosuits NOT built by them \
	<br> \
	<b>A.C:</b> Under no circumstances may the military exosuit built by the \
	permit holder be driven freely about the station at any time with the \
	exception of delivering it to a securing zone and/or the transfer \
	shuttle. Another exceptions to this condition is stated in the (B. conditions) \
	<br> \
	<b>A.D:</b> Under no circumstances may the military exosuit built by the \
	permit holder be armed with weaponry designed to kill or incapacitate \
	even while idle, with the exception of (B. conditions) \
	<br> \
	<b>A.E:</b> All military exosuits built by the permit holder MUST be \
	transferred back to centcom at the end of all shifts via the main \
	transfer shuttle and/or emergency pods. Inability to transfer \
	military exosuits may result in the permit holder being put up for review. \
	<br><br> \
	<b>Condition B.: When on a code red alert military exosuits may be armed and operated by the permit holder and/or station security staff to help defend the station and its staff.</b> \
	<br><br> \
	<b>B.B:</b> When on a code red alert any security staff reserve the right to commandeer a military exosuit. The permit holder MUST yeild to security personnel upon request. \
	<br> \
	<b>B.C:</b> Upon return to code blue or green the permit holder has the right to re-commandeer a military exosuit built by them. Security personnel refusing to give control of the exosuit back to the permit holder are to be considered a threat to station order and security and should be reported ASAP. \
	<br> \
	<b>B.D:</b> On code red permit holders operating a military exosuit may not cause reckless damage to the station. Damage reports deemed 'too excessive' for the situation may result in the permit holder being put up for review. \
	<br> \
	<b>B.E:</b> In the event that there is a hostile attack on the station and the security level has not been elevated for whatever reason. The permit holder may use their military exosuit to help defend the station and its staff as needed. Misuse of \this condition WILL result in the permit holder being put up for review. \
	<i>This permit has been stamped with the Office of Military Research and Construction's stamp</i>"

//////////////////////////////////
////////// Usable Items //////////
//////////////////////////////////



//////////////////////////////////
//////////// Clothing ////////////
//////////////////////////////////


//////////// Gloves ////////////


//////////// Eye Wear ////////////


//////////// Suits ////////////


//////////// Uniforms ////////////


//////////// Masks ////////////


//////////// Shoes ////////////


//////////// Sets ////////////


//////////// Weapons ////////////

