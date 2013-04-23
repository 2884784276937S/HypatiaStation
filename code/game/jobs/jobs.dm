
var/const/ENGSEC			=(1<<0)

var/const/CAPTAIN			=(1<<0)
var/const/HOS				=(1<<1)
var/const/WARDEN			=(1<<2)
var/const/DETECTIVE			=(1<<3)
var/const/OFFICER			=(1<<4)
var/const/PARAMEDIC			=(1<<5)
var/const/CHIEF				=(1<<6)
var/const/ENGINEER			=(1<<7)
var/const/ATMOSTECH			=(1<<8)
var/const/ROBOTICIST		=(1<<9)
var/const/AI				=(1<<10)
var/const/CYBORG			=(1<<11)


var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CHEMIST			=(1<<2)
var/const/CMO				=(1<<3)
var/const/DOCTOR			=(1<<4)
var/const/GENETICIST		=(1<<5)
var/const/VIROLOGIST		=(1<<6)


var/const/CIVILIAN			=(1<<2)

var/const/HOP				=(1<<0)
var/const/MAGISTRATE		=(1<<1)
var/const/BARTENDER			=(1<<2)
var/const/BOTANIST			=(1<<3)
var/const/CHEF				=(1<<4)
var/const/JANITOR			=(1<<5)
var/const/LIBRARIAN			=(1<<6)
var/const/QUARTERMASTER		=(1<<7)
var/const/CARGOTECH			=(1<<8)
var/const/MINER				=(1<<9)
var/const/MINEFORE			=(1<<10)
var/const/LAWYER			=(1<<11)
var/const/CHAPLAIN			=(1<<12)
var/const/CLOWN				=(1<<13)
var/const/MIME				=(1<<14)
var/const/ASSISTANT			=(1<<15)


var/list/assistant_occupations = list(
	"Assistant",
	"Atmospheric Technician",
	"Cargo Technician",
	"Chaplain",
	"Lawyer",
	"Librarian"
)


var/list/command_positions = list(
	"Captain",
	"Head of Personnel",
	"Head of Security",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer",
	"Magistrate",
	"Quartermaster"
)


var/list/engineering_positions = list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician",
)


var/list/medical_positions = list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Virologist",
	"Chemist"
)


var/list/science_positions = list(
	"Research Director",
	"Scientist",
	"Geneticist",	//Part of both medical and science
	"Roboticist"	//Part of both engineering and science
)

//BS12 EDIT
var/list/civilian_positions = list(
	"Head of Personnel",
	"Magistrate",
	"Bartender",
	"Botanist",
	"Chef",
	"Janitor",
	"Librarian",
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner",
	"Mining Foreman",
	"Lawyer",
	"Chaplain",
	"Assistant"
)


var/list/security_positions = list(
	"Head of Security",
	"Warden",
	"Detective",
	"Security Officer",
	"Security Paramedic"
)


var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI"
)


/proc/guest_jobbans(var/job)
	return ((job in command_positions) || (job in nonhuman_positions) || (job in security_positions))
