local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


Config = {}

Config.debug = false		-- print a chaque action uniquement pour dev
Config.helpnotif = false	-- notification "Appuyez sur .. pour .... "

Config.Weed = {

	PauseFarm = 8000,
	MiniFlics = 0,
	Recolte = { min = 1, max = 3 },

	Items = {
		feuilles = 'weed',
	},

	Champs = {

		x= 2223.24, 
		y= 5576.459, 
		z= 53.803, 
		taille= 3.0,
		notif = '~INPUT_CONTEXT~ Ceuillir un pied de Marijuana',
		notif2 = 'Vous recoltez de la Marijuana~n~Appuyez sur X pour arreter',
		notif3 = 'Vous arretez la recolte de Marijuana',
		touche = Keys["E"],
		toucheX = Keys["X"],

	},


}

Config.Heroine = {

	PauseFarm = 8000,
	MiniFlics = 0,
	Recolte = { min = 1, max = 2 },

	Items = {
		hero = 'opium_pooch',
	},

	Champs = {

		x= 1005.816, 
		y= -3200.403, 
		z= -38.52, 
		taille= 2.00,
		heading= 174.162,

		notif = '~INPUT_CONTEXT~ Preparer de l\'Heroine',
		notif2 = 'Vous preparer de l\'Heroine~n~Appuyez sur X pour arreter',
		notif3 = 'Vous arretez la production de l\'Heroine',
		touche = Keys["E"],
		toucheX = Keys["X"],

	},


}

Config.Meth = {

	MiniFlics = 0,
	Items = {
		meth = 'meth',
	},

	zone = { 
		x= 1535.952, 
		y= -2122.083, 
		z= 76.862, 
		taille= 300.0,
	},

	vehicule = 'JOURNEY',
	notif = '~INPUT_THROW_GRENADE~ Lancer une Cuisson',
	touche = Keys["G"],

}

Config.Coke = {

	MiniFlics = 0,
	Items = {
		coke = 'coke',
	},

	zone = { 
		x= 1101.842, 
		y= -3194.022, 
		z= -38.994, 
		taille= 2.0,
		heading= 4.0,
	},

	notif = '~INPUT_CONTEXT~ Cuisiner avec de la Farine',
	touche = Keys["E"],

}

Config.Notifs = {

	pochespleines = 'Vous en avez deja plein les poches',
	pochespleinespochons = 'Vous avez deja trop de pochons',
	pasdeflics = 'Les outils ne semblent pas fonctionner',

}

Config.Pochons = {

	PauseFarm = 2500,
	MiniFlics = 0,
	Zones = {
		{ x = -39.32, y = -614.164, z = 35.269, taille = 1.0 },
		{ x = -50.053, y = -1290.063, z = 30.9, taille = 1.0 },
		{ x = 2731.781, y = 4141.564, z = 44.247, taille = 1.0 },
		{ x = 90.646, y = -1989.893, z = 20.415, taille = 1.0 },
	},
	notif = '~INPUT_CONTEXT~ Mettre en sachets',
	notif2 = 'Vous mettez en sachets~n~Appuyez sur X pour arreter',
	notif3 = 'Vous arretez la mise en sachets',
	touche = Keys["E"],
	toucheX = Keys["X"],

}
