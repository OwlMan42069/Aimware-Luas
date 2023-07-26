local misc_ref = gui.Reference("Misc", "Enhancement", "Appearance")
local enable_clantags = gui.Checkbox(misc_ref, "enable.clantags", "Enable Premade Clantags", false)
local clantag_mode = gui.Combobox(misc_ref, "clantag.mode", "Select clantag", "Sussy Baka", "UwU Rawr xD!", "Sorry Not Sorry", "No Lives Matter", "EZFrags.co.uk")
local set_clantag = ffi.cast('int(__fastcall*)(const char*, const char*)', mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15"))
local clantagset = 0

--ClanTags
local ClanTags = {
	['Sussy Baka'] = {
		"                  ",
		"S                 ",
		"S^                ",
		"Su                ",
		"Su|               ",
		"Su                ",
		"Sus               ",
		"Suss              ",
		"Suss(>ω<)         ",
		"Sussy             ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy B           ",
		"Sussy B@          ",
		"Sussy Ba          ",
		"Sussy Ba(>ω<)     ",
		"Sussy Bak         ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Bak         ",
		"Sussy Ba^         ",
		"Sussy Ba          ",
		"Sussy B@          ",
		"Sussy B           ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy|            ",
		"Sussy             ",
		"Suss(>ω<)         ",
		"Suss              ",
		"Sus|              ",
		"Sus               ",
		"Su                ",
		"S^                ",
		"S|                ",
		"S                 ",
		"|                 "
	},

	['UwU Rawr xD!'] = {
		"                  ",
		"U                 ",
		"Uw                ",
		"UwU               ",
		"(>ω<)             ",
		"UwU R             ",
		"UwU Ra            ",
		"UwU Raw           ",
		"UwU Rawr          ",
		"UwU Rawr x        ",
		"UwU Rawr xD       ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD       ",
		"UwU Rawr x        ",
		"UwU Rawr          ",
		"UwU Raw           ",
		"UwU Ra            ",
		"UwU R             ",
		"(>ω<)             ",
		"UwU               ",
		"Uw                ",
		"U                 ",
		"                  ",
		"                  "
	},

	['Sorry Not Sorry'] = {
		"                  ",
		"$                 ",
		"S                 ",
		"So                ",
		"Sor               ",
		"Sorr              ",
		"Sorry             ",
		"Sorry N           ",
		"Sorry No          ",
		"Sorry No^         ",
		"Sorry Not         ",
		"Sorry Not $       ",
		"Sorry Not S@      ",
		"Sorry Not So      ",
		"Sorry Not Sor     ",
		"Sorry Not Sorr    ",
		"Sorry Not Sorr^   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorry   ",
		"$@rry Not $@rry   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorr^   ",
		"Sorry Not Sorr    ",
		"Sorry Not Sor     ",
		"Sorry Not So      ",
		"Sorry Not S@      ",
		"Sorry Not $       ",
		"Sorry Not         ",
		"Sorry No^         ",
		"Sorry No          ",
		"Sorry N           ",
		"Sorry             ",
		"Sorr              ",
		"Sor               ",
		"So                ",
		"S                 ",
		"$                 ",
		"                  "
	},

	['No Lives Matter'] = {
		"                  ",
		"N                 ",
		"No                ",
		"No L              ",
		"No Li             ",
		"No Liv            ",
		"No Live           ",
		"No Lives          ",
		"No Lives M        ",
		"No Lives Ma       ",
		"No Lives Mat      ",
		"No Lives Matt     ",
		"No Lives Matte    ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"o Lives Matter    ",
		"Lives Matter      ",
		"ives Matter       ",
		"ves Matter        ",
		"es Matter         ",
		"s Matter          ",
		"Matter            ",
		"atter             ",
		"tter              ",
		"ter               ",
		"er                ",
		"r                 ",
		"                  "
	},

	['EZFrags.co.uk'] = {
		"                  ",
		"E                 ",
		"EZ                ",
		"EZf               ",
		"EZfr              ",
		"EZfra             ",
		"EZfrag            ",
		"EZfrags           ",
		"EZfrags.          ",
		"EZfrags.c         ",
		"EZfrags.co        ",
		"EZfrags.co.       ",
		"EZfrags.co.u      ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.u      ",
		"EZfrags.co.       ",
		"EZfrags.co.       ",
		"EZfrags.co        ",
		"EZfrags.c         ",
		"EZfrags.          ",
		"EZfrags           ",
		"EZfrag            ",
		"EZfra             ",
		"EZfr              ",
		"EZf               ",
		"EZ                ",
		"E                 ",
		"                  "
	},
}


local function for_clantags()
	if not enable_clantags:GetValue() then
		if clantagset == 1 then
			set_clantag("", "")
			clantagset = 0
		end

		return
	end

	local mode = clantag_mode:GetString()
	local tag = ClanTags[mode]
	local curtime = math.floor(globals.CurTime() * 2.3)

	if old_time ~= curtime then
		local t = tag[curtime % #tag+1]
		set_clantag(t, t)
	end

	old_time = curtime
	clantagset = 1
end

callbacks.Register('Draw', for_clantags)