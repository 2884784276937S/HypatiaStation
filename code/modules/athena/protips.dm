var/list/protips										= list(
	"Protip: Adminhelp if you see or are a victim of bad roleplay.",
	"Protip: Don't tell the admins to do things.",
//	"Protip: Roros like being contained by their shields! Use them. Also, remember to feed them.",
	"Protip: Trash goes in the nearest disposal unit: this is a space station, not a homeless shelter.",
	"Protip: When OOC is disabled, don't go (OOC) over the radio.",
	"Protip: Are you an assistant?  Don't make problems, go get a job.",
	"Protip: Listen to your superiors. They probably have a plan.",
	"Protip: Bored with the round or need to go? Go to the dorms, not the nearest airlock.",
	"Protip: Don't know the channels?  Examine your headset.",
	"Protip: Flavor texts can usually give interesting examinations, look at them.",
	"Protip: You the QM?  Don’t order shit just for yourself.",
	"Protip: Stay calm, no need for panic.",
	"Protip: The particle accelerator console arrow needs to point down.",
	"Protip: Don't know the headset channels? Examine the headset.",
	"Protip: Are you an assistant?  Don't make trouble, get a job.",
	"Protip: Adminhelp if you spot bad roleplaying.",
	"Protip: Prayers are IC, Not OOC.",
	"Protip: You the QM?  Don't order things just for yourself, other people use supply points.",
	"Protip: Don't log off when you don't get things your way.",
	"Protip: Doing your job helps everybody, especially yourself.",
	"Protip: Our forums are located at: http://hypatiastation.net/forum - Enjoy your stay here!",
	"Protip: This is a roleplay-oriented server, please keep that in mind.",
	"Protip: This is a roleplay-oriented server, please keep that in mind.",
	"Protip: Read the guide on how to set up the singularity engine before attempting it.",
	"Protip: Griefing earns bans. Plasma bomb griefing gets permabans. Antags are exempt.",
	"Protip: Read your protips. They're capable of saving you from a ban.",
	"Protip: Non-antags causing the engine to lose containment is likely to earn you a ban or job-ban.",
	"Protip: If you bludgeon people over the head 4 no raisin, you will be admin-weakened and your prey granted godmode.",
	"Protip: Minimally violent resolutions are preferred! Talk it out, call security, or disarm someone else. Avoid killing!",
	"Protip: Genetics is there for a reason. Clone someone, chuck them in cryo for a minute or two, then fix any disabilities.",
	"Protip: You must have consent if you want to do any kind of ERP (Erotic RolePlay) with someone. Offenders are permabanned.",
	"Protip: Read the protips.",
	"Protip: Don't have weapons showing when the station is on Code Green. This includes wearing them on your suit.",
	"Protip: If you are working inside Medbay, use rollerbeds to transport people. Not doing so will hurt the patient."
)

proc/protips()
	var/current_protip

	while (TRUE)
		sleep(rand(7500, 10000))

		current_protip	= pick(protips)
		if (current_protip != "")
			world << "<font color=\"#116622\"><b>" + pick(protips) + "</b></font>"