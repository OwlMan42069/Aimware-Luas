--------Auto Update-------- https://aimware.net/forum/thread/151605
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Hentai%20Killsay%20Deathsay.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Versions/Hentai%20Killsay%20Deathsay%20Version.txt";
local VERSION_NUMBER = "2.4";
local version_check_done = false;
local update_downloaded = false;
local update_available = false;
local up_to_date = false;
local updaterfont1 = draw.CreateFont("Bahnschrift", 18);
local updaterfont2 = draw.CreateFont("Bahnschrift", 14);
local updateframes = 0;
local fadeout = 0;
local spacing = 0;
local fadein = 0;

callbacks.Register( "Draw", "handleUpdates", function()
	if updateframes < 5.5 then
		if up_to_date or updateframes < 0.25 then
			updateframes = updateframes + globals.AbsoluteFrameTime();
			if updateframes > 5 then
				fadeout = ((updateframes - 5) * 510);
			end
			if updateframes > 0.1 and updateframes < 0.25 then
				fadein = (updateframes - 0.1) * 4500;
			end
			if fadein < 0 then fadein = 0 end
			if fadein > 650 then fadein = 650 end
			if fadeout < 0 then fadeout = 0 end
			if fadeout > 255 then fadeout = 255 end
		end
		if updateframes >= 0.25 then fadein = 650 end
		for i = 0, 600 do
			local alpha = 200-i/3 - fadeout;
			if alpha < 0 then alpha = 0 end
			draw.Color(15,15,15,alpha);
			draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30);
			draw.Color(0, 180, 255,alpha);
			draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31);
		end
		draw.SetFont(updaterfont1);
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 - 650 + fadein, 7, "RetardAlert's");
		draw.Color(225,225,225,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's ") - 650 + fadein, 7, "Script");
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's Script  ") - 650 + fadein, 7, "\\");
		spacing = draw.GetTextSize("RetardAlert's Script  \\  ");
		draw.SetFont(updaterfont2);
		draw.Color(225,225,225,255 - fadeout);
	end

    if (update_available and not update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.");
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
	end
	
    if (update_downloaded) and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.");
    end

    if (not version_check_done) then
        version_check_done = true;
		local version = http.Get(VERSION_FILE_ADDR);
		version = string.gsub(version, "\n", "");
		if (version ~= VERSION_NUMBER) then
            update_available = true;
		else 
			up_to_date = true;
		end
	end
	
	if up_to_date and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER);
	end
end)

--------GUI Stuff--------
local misc_ref = gui.Reference("Misc")
local tab = gui.Tab(misc_ref, "RetardAlert", ("ThighHighs.club v" .. VERSION_NUMBER))
local misc_left = gui.Groupbox(tab, "Killsay / Deathsay", 10, 15, 310, 400)
local misc_left2= gui.Groupbox(tab, "Clantags", 10, 160, 310, 400)
local misc_left3 = gui.Groupbox(tab, "Grenade Throwsay", 10, 305, 310, 400)
local misc_right = gui.Groupbox(tab, "Game-Chat", 325, 15, 305, 400)
local misc_right2 = gui.Groupbox(tab, "Misc", 325, 250, 305, 400)

local enable_killsays = gui.Checkbox(misc_left, "enable.killsays", "Enable Killsay Deathsay", true)
local killsay_mode = gui.Combobox(misc_left, "killsay.mode", "Select Killsay Mode", "Hentai", "Lewd", "Apologetic", "Edgy", "EZfrags", "AFK")

local enable_clantags = gui.Checkbox(misc_left2, "enable.clantags", "Enable Premade Clantags", false)
local clantag_mode = gui.Combobox(misc_left2, "clantag.mode", "Select clantag", "Sussy Baka", "UwU Rawr xD!", "Sorry Not Sorry", "No Lives Matter", "EZFrags.co.uk")
local set_clantag = ffi.cast('int(__fastcall*)(const char*, const char*)', mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15"))
local clantagset = 0

local enable_throwsay = gui.Checkbox(misc_left3, "enable.throwsay", "Enable Grenade Throwsay", true)
local grenade_throwsay = gui.Multibox(misc_left3, "Select Grenades")
local enable_hegrenade = gui.Checkbox(grenade_throwsay, "enable.hegrenade", "HE Grenade", true)
local enable_flashbang = gui.Checkbox(grenade_throwsay, "enable.flashbang", "Flashbang", true)
local enable_smokegrenade = gui.Checkbox(grenade_throwsay, "enable.smokegrenade", "Smoke", true)
local enable_molotov = gui.Checkbox(grenade_throwsay, "senable.molotov", "Molotov/Incendiary", true)

local EngineRadar = gui.Checkbox(misc_right2, "engineradar", "Engine Radar", true)
local ForceCrosshair = gui.Checkbox(misc_right2, "forcecrosshair", "Force Crosshair", true)
local RecoilCrosshair = gui.Checkbox(misc_right2, "recoilcrosshair", "Recoil Crosshair", false)
local laffmode = gui.Checkbox(misc_right2, "laffmode", "Laff Mode", true)

local enable_msgevents = gui.Checkbox(misc_right, "enable.msgevents", "Enable Message Events", false)
local msgevents_mode = gui.Combobox(misc_right, "msgevents.mode", "Select Message Mode", "Copy Player Messages", "Chat Breaker")
local enable_chatcmds = gui.Checkbox(misc_right, "enable.chatcmds", "Enable Chat Commands", true)
local chat_commands = gui.Multibox(misc_right, "Select Chat Commands")
local enable_roll = gui.Checkbox(chat_commands, "enable.roll", "!roll", true)
local enable_8ball = gui.Checkbox(chat_commands, "enable.8ball", "!8ball", true)
local enable_gaydar = gui.Checkbox(chat_commands, "enable.gaydar", "!gay", true)
local enable_cf = gui.Checkbox(chat_commands, "enable.cf", "!cf", true)

EngineRadar:SetDescription("Displays enemies on your in-game radar.")
ForceCrosshair:SetDescription("Displays your in-game crosshair while holding snipers.")
RecoilCrosshair:SetDescription("Displays your recoil using your in-game crosshair.")
laffmode:SetDescription("Replaces lol with laff in chat :laff:")


--------Draw Image--------
local function OnUnload()
	client.Command("toggleconsole", true)

	client.Command('echo "⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄"', true)
	client.Command('echo "⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄"', true)
	client.Command('echo "⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄"', true)
	client.Command('echo "⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰"', true)
	client.Command('echo "⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤"', true)
	client.Command('echo "⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗"', true)
	client.Command('echo "⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄"', true)
	client.Command('echo "⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄"', true)
	client.Command('echo "⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄"', true)
	client.Command('echo "⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄"', true)
	client.Command('echo "⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴"', true)
	client.Command('echo "⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿"', true)

	if clantagset == 1 then
		set_clantag("", "")
	end
end

--------Miscellaneous--------
client.Command("+right", true)
client.Command("+left", true)
client.Command("snd_menumusic_volume 0", true)
client.Command("cl_timeout 0 0 0 7", true)

--------Engine Radar--------
callbacks.Register('CreateMove', function()
	local isEngineRadarOn = EngineRadar:GetValue() and 1 or 0

	for _, Player in ipairs(entities.FindByClass('CCSPlayer')) do
		Player:SetProp('m_bSpotted', isEngineRadarOn)
	end
end)

--------Force Crosshair--------
client.AllowListener('item_equip')
callbacks.Register('FireGameEvent', function(e)
	if not ForceCrosshair:GetValue() or e:GetName() ~= 'item_equip' then
		if not client.GetConVar('weapon_debug_spread_show') == '3' then
			client.SetConVar('weapon_debug_spread_show', 0, true)
		end
		return
	end

	local LocalPlayerIndex = client.GetLocalPlayerIndex()
	local PlayerIndex = client.GetPlayerIndexByUserID( e:GetInt('userid') )
	local WeaponType = e:GetInt('weptype')

	if LocalPlayerIndex == PlayerIndex then
		if WeaponType == 5 then
			client.SetConVar('weapon_debug_spread_show', 3, true)
		end
	end
end)

--------Recoil Crosshair--------
local function CrosshairRecoil()
	if RecoilCrosshair:GetValue() and not gui.GetValue("rbot.master") then
		client.SetConVar("cl_crosshair_recoil", 1, true)
	else
		client.SetConVar("cl_crosshair_recoil", 0, true)
	end
end

--------Inventory Unlocker--------
local function UnlockInventory()
	panorama.RunScript('LoadoutAPI.IsLoadoutAllowed = () => true');
end

--------Laff Mode--------
callbacks.Register('SendStringCmd', function(cmd)
	if laffmode:GetValue() and string.find(cmd:Get(), 'say "lol"') then
		cmd:Set('say "laff"')
	end
end)

--------Message Events--------
local numbers = {"1","2","3","4","5","6",}
local responses = {"Yes - definitely.","It is decidedly so.","Without a doubt.","Reply hazy, try again.","Ask again later.","Better not tell you now.","My sources say no.","Outlook not so good.","Very doubtful.",}
local results = {"won the coinflip!","lost the coinflip!",}
local gaydar = {"is gay!","is not gay!",}

local timer = timer or {}
local timers = {}

function timer.Create(name, delay, times, func)
    table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})
end

function timer.Remove(name)
    for k,v in pairs(timers or {}) do
        if (name == v["name"]) then table.remove(timers, k) end
    end
end

callbacks.Register("DispatchUserMessage", function(msg)
    if msg:GetID() == 6 then
        local index = msg:GetInt(1)
		local message = msg:GetString(4,1)
        local message2 = msg:GetString(4,1):lower()
        local m = string.match

        local player_name = client.GetPlayerNameByIndex(index)
        local number = numbers[math.random(#numbers)]
        local response = responses[math.random(#responses)]
        local result = results[math.random(#results)]
        local thingy = gaydar[math.random(#gaydar)]

		if enable_msgevents:GetValue() and msgevents_mode:GetValue() == 0 then
			client.ChatSay(message)
		elseif enable_msgevents:GetValue() and msgevents_mode:GetValue() == 1 then
			client.ChatSay("﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽")
		end

        if m(message2, "!roll") and enable_chatcmds:GetValue() and enable_roll:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s rolled a %s'):format(player_name, number)
                client.ChatSay(msg)
            end)
        end

        if m(message2, "!8ball") and enable_chatcmds:GetValue() and enable_8ball:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                client.ChatSay("❽: " .. response)
            end)
        end

        if m(message2, "!gay") and enable_chatcmds:GetValue() and enable_gaydar:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, thingy)
                client.ChatSay(msg)
            end)
        end

        if m(message2, "!cf") and enable_chatcmds:GetValue() and enable_cf:GetValue() or m(message2, "!flip") and enable_chatcmds:GetValue() and enable_cf:GetValue() or m(message2, "!coin flip") and enable_chatcmds:GetValue() and enable_cf:GetValue() or m(message2, "!coinflip") and enable_chatcmds:GetValue() and enable_cf:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, result)
                client.ChatSay(msg)
            end)
        end
    end
end)

callbacks.Register("Draw", function()
    for k,v in pairs(timers or {}) do
  
        if (v["times"] <= 0) then table.remove(timers, k) end
      
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]()
        end  
    end
end)


--Throwsays
local ThrowSays = {
	hegrenade = {
		'Catch retard!',
		'Heads up!',
		'This is gonna hurt.',
	},

	flashbang = {
		'Look a bird!',
		'Look a plane!',
		'FLASHBANG!',
		'Bang bang bangity bang I said bang bang bangity bang bang bang bang',
	},

	molotov = {
		'Fire hot retard!',
		'BURN BABY BURN!',
	},

	incgrenade = {
		'Fire hot retard!',
		'BURN BABY BURN!',
	},

	smokegrenade = {
		'I am a ninja',
		'Very Sneaky Man',
		'NINJA DEFUSE!',
	},
}

local function for_throwsay(e)
	if not enable_throwsay:GetValue() then
		return
	end

	if e:GetName() ~= 'grenade_thrown' then
		return
	end

	if client.GetPlayerIndexByUserID( e:GetInt('userid') ) ~= client.GetLocalPlayerIndex() then
		return
	end

	local wep = e:GetString('weapon')
	local says = ThrowSays[wep]
	local say_msg =
	   (wep == 'hegrenade' and enable_hegrenade:GetValue()) or 
	   (wep == 'flashbang' and enable_flashbang:GetValue()) or
	   ((wep == 'molotov' or wep == 'incgrenade') and enable_molotov:GetValue()) or
	   (wep == 'smokegrenade' and enable_smokegrenade:GetValue())

	if say_msg then
		client.ChatSay( says[math.random(#says)] )
	end
end


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

-- KillSays
local KillSays = {
	Hentai = {
		Kill = {
			"S-Sorry onii-chan p-please d-do me harder ;w;",
			"Y-You got me all wet now Senpai!",
			"D-Don't t-touch me there Senpai",
			"P-Please l-love me harder oniichan ohh grrh aahhhh~!",
			"Give me all your cum Senpai ahhhhh~",
			"F-Fuck me harder chan!",
			"Oh my god I hate you so much Senpai but please k-keep fucking me harder! ahhh~",
			"D-Do you like my stripped panties getting soaked by you and your hard cock? ehhh master you're so lewd ^0^~",
			"Kun your cute little dick between my pussy lips looks really cute, I'm blushing",
			"M-Master does it feel good when I slide by tits up and down on your cute manly part?",
			"O-Oniichan my t-toes are so warm with your cum all over them uwu~",
			"Lets take this swimsuit off already <3 i'll drink your unknown melty juice",
			"S-Stop Senpai if we keep making these lewd sounds im going to cum~~",
			"You're such a pervert for filling me up with your baby batter Senpai~~",
			"Fill up my baby chamber with your semen kun ^-^",
			"M-Master d-dont spank my petite butt so hard ahhhH~~~ you're getting me so w-wet~",
			"Senpai your cock is already throbbing from my huge tits~",
			"Hey kun, Can I have some semen?",
			"M-My baby chamber is overflowing with your semen M-Master",
			"Fill my throat pussy with your semen kun",
			"It-It's not gay if you're wearing thigh highs M-Master",
			"I-I need somewhere to blow my load. Can i borrow your bussy?",
			"A-ah shit... Y-your cock is big and in my ass -- already~?!",
			"I'll swallow your sticky essence along with you~!",
			"B-Baka please let me be your femboy sissy cum slut!",
			"That's a penis UwU you towd me you wewe a giww!!",
			"Ahhhh... It's like a dream come true... I get to stick my dick inside your ass...!",
			"Hey, who wants a piece of this plump 19-year-old boy-pussy? Single file, boys, come get it while it's hot!",
			"M-Master, if you keep thrusting that hard, my boobs will fall off!",
			"When do you wanna meet up again? I've really taken a liking to your dick! (,,◠∇◠) I want you and only you to slam it into my pussy every day! (≧∇≦)",
			"All I did was crossplay 'cause I felt like it might be fun... But now I'm just a little girl that cums from big dicks!",
			"D-Don't get the wrong idea!!! I don't w-want you to fuck my b-bussy because I l-love you or anything! d-definitely not!",
			"I-I know I said you could be as rough as you want... But surprise fisting wasn't what I had in mind!!",
			"W-Why is it that lately... Y-You haven't been playing with my ass!!?",
		},

		Death = {
			"Hehe don't touch me there Onii-chann UwU",
			"Your cum is all over my wet clit M-Master",
			"It Feels like you're pounding me with the force of a thousand suns Senpai",
			"Y-Yes right there S-Sempai hooyah",
			"P-Please keep filling my baby chamber S-Sempai",
			"O-Onii-chan it felt so good when you punded my bussy",
			"P-Please Onii-chan keep filling my baby chamber with your melty juice",
			"O-Onii-chan you just one shot my baby chamber",
			"I-Im nothing but a f-fucktoy slut for your m-monster fuckmeat!",
			"Dominate my ovaries with your vicious swimmers!",
			"Y-Your meat septer has penetrated my tight boy hole",
			"Mnn FASTER... HARDER! Turn me into your femboy slut~!",
			"Mmmm- soothe me, caress me, Fuck me, breed me!",
			"Probe your thick, wet, throbbing cock deeper and deeper into my boipussy~!!",
			"Hya! Not my ears! Ah... It tickles! Ah!",
			"Kouta... I can't believe how BIG his... Wait! Forget about that!! Is Nyuu-chan really giving him a Tit-Fuck!?",
			"Senpai shove deeper your penis in m-my pussy (>ω<) please",
			"I'm coming fwom you fwuking my asshole mmyyy!",
			"P-Please be gentle, S-Senpai!",
			"D-Don't get the wrong idea!! I didn't give up my viginity to you because I like you or anything!!",
			"Let me taste your futa cock with my pussy~",
		}
	},

	Lewd = {
		Kill = {
			"Oh do you wanna eat? Do you wanna take a bath? Or do you want me!",
			"It's not gay if you swallow the evidence!",
			"That's a penis UwU you towd me you wewe a giww!!",
			"You are cordially invited to fuck my ass!",
			"Grab them, squeeze them, pinch them, pull them, lick them, bite them, suck them!",
			"It feels like your dick is sliding into a slimy pile of macaroni!",
			"This is the cock block police! Hold it right there!",
			"Ohoo, getting creampied made you cum? What a lewd bitch you are!",
			"I've jerked off every single day... Given birth to countless snails... All while fantasizing about the day I'd get to fuck you!",
			"You're looking at porn when you could be using your little sister instead!",
			"Umm... I don't wanna sound rude, but have you had a bath? Your panties look a bit yellow...",
			"Papa you liar! How could you say that while having such a HUGE erection.",
			"I-I just wanna borrow y-your dick...",
			"If a man inserts his hose into another man's black hole, can they make a baby?",
			"I-I had a itch down there... and I-I just needed something to-to stick up in there!",
			"You have some tasty-looking panties there...",
			"You're my personal cum bucket!!",
			"I-I'm cumming, I'm cumming, CUM with me too!",
			"Your resistance only makes my penis harder!",
			"Cum, you naughty cock! Do it! Do it! DO IT!!!",
			"Boys just can't consider themselves an adult... Until they've had a chance to cum with a girl's ampit.",
			"We're both gonna fuck your pussy at the same time!",
			"When everyone's gone home for the day and the class-room's empty you have no choice but to expose yourself and jerk off, right?",
		},

		Death = {
			"Dominate my ovaries with your vicious swimmers!",
			"Impregnate me with your viral stud genes!",
			"M-My body yearns for your sweet dick milk",
			"My nipples are being tantalized",
			"Penetrate me until I bust!",
			"Mmmm- soothe me, caress me, Fuck me, breed me!",
			"I'm your personal cum bucket!!",
			"Can you really blame me for getting a boner after seeing that?",
			"The two of us will cover my sis with our cum!",
			"This... This is almost like... like somehow I'm the one raping him!",
			"You're impregnating my balls!?",
			"If you weren't a pervert, you wouldn't be getting off on having a girl do you in the butt, would you?",
			"Well, well... What a cutie you are! I will claim your virginity!",
			"Oh, yeahh! You wanna fuck?",
			"I'm getting pissed off and hormy right now!",
		}
	},

	Apologetic = {
		Sorry = {"am sorry that","am feeling sad after","am distressed because","am upset with myself because","have been diagnosed with depression because","am broken hearted that","apologize that","would like to apologize because","am quite remorseful because","am ashamed of myself because"},
		Kill = {"killed","destroyed","put an end to","ended","assassinated","terminated","eliminated","executed","slaughtered","butchered","shot and killed"},
		Regret = {":(","Please forgive me","I didn't mean to.","I'm a failure","I will go easy on you next time.","That was my fault","Please excuse my behaviour"}
	},

	Edgy = {
		Kill = {
			"Let my K/D do the talking",
			"mad cuz bad",
			"No Aimware no talk",
			"Config error, user banned, thread locked.",
			"IQ error",
			"I'm the reason your dads gay faggot",
			"How's your mom doin after last night?",
			"Dead people can't talk nn",
			"Warmth, love, and affection. These are the things I have taken away from you.",
			"I’ve made a contract with the devil, so I can’t be friends with a god.",
			"Corpses are good. They don’t babble.",
			"The weak are destined to lie beneath the boots of the strong.",
			"Options -> How to play",
			"The world is better without you",
			"Life is endless suffering...",
			"I'm just killing the spiders to save the butterflies.",
			"Fear is what creates order.",
			"No matter how much you cry I won't stop.",
			"Deleted",
			"*DEAD*",
			"Re_solved",
			"De_stroyed",
			"If G-D wanted you to live he would not have created me.",
			"Earn your damnation",
			"Vengeance is mine",
			"If at first you do not succeed... try, try again.",
			"Watch your head",
			"When you are ready call for me",
			"I have become death destroyer of worlds",
			"Easy come easy go",
			"I stay you go",
			"End of the line for you",
			"Maybe tomorrow.",
			"I'm fucking invincible.",
			"See you in a couple of minutes.",
			"You are strong child, but I am beyond strength",
		},

		Death = {
			"You only killed me because I ran out of health..",
			"I bet dead people are easier to get along with.",
			"The real hell is inside the person.",
			"The ones who kill should be prepared to be killed.",
			"I gave you that one",
			"Congratulations! You're on the scoarboard now.",
			"Emotions are a mental disorder",
			"Carpe Diem",
			"Gone but not forgotten",
			"I'll be back",
			"Deploying the counter measure",
			"There are no ends only new beginnings",
		}
	},

	EZfrags = {
		Kill = {
			"Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
			"Stop being a noob! Get good with www.EZfrags.co.uk",
			"I'm not using www.EZfrags.co.uk, you're just bad",
			"You just got pwned by EZfrags, the #1 CS:GO cheat",
			"If I was cheating, I'd use www.EZfrags.co.uk",
			"Think you could do better? Not without www.EZfrags.co.uk",
		},

		Death = {
			"You only killed me because I'm not using www.EZfrags.co.uk",
			"You're lucky I'm not using www.EZfrags.co.uk",
			"I would have destroyed you if I was using www.EZfrags.co.uk",
			"You only killed me because you're using www.EZfrags.co.uk the finest public & private CS:GO cheat",
		}
	},

    AFK = {
        AfkSorry = {"Sorry",},
        Kill = {"I'm AFK. This is a bot. You died to a ",}, 
        Death = {"You only killed me because I'm AFK.",}
    },
}


local function for_chatsay(e)
	if not enable_killsays:GetValue() then
		return
	end

	if e:GetName() ~= 'player_death' then
		return
	end

	local mode = killsay_mode:GetString()
	local lp = client.GetLocalPlayerIndex()
	local victim = client.GetPlayerIndexByUserID(e:GetInt('userid'))
	local attacker = client.GetPlayerIndexByUserID(e:GetInt('attacker'))
	local say = KillSays[mode]

	if attacker == lp and victim ~= lp then
		local msg = say.Kill[math.random(#say.Kill)]

		if mode == 'Apologetic' then
			local victim_name = client.GetPlayerNameByIndex(victim)

			local sry1 = say.Sorry[ math.random(#say.Sorry) ]
			local sry3 = say.Regret[ math.random(#say.Regret) ]

			msg = ('%s, I %s I %s you. %s'):format(victim_name, sry1, msg, sry3)
		end

        if mode == 'AFK' then
            local victim_name = client.GetPlayerNameByIndex(victim)
            local attacker_weapon = e:GetString('weapon')

            local afk1 = say.AfkSorry[ math.random(#say.AfkSorry) ]

            msg = ('%s %s, %s %s.'):format(afk1, victim_name, msg, attacker_weapon)
        end

		client.ChatSay( msg )
	elseif attacker ~= lp and victim == lp then
		if say.Death then
			client.ChatSay( say.Death[math.random(#say.Death)] )
		end
	end
end


--------Lua Callbacks & Listeners--------
client.AllowListener('player_death')
client.AllowListener('grenade_thrown')
callbacks.Register('FireGameEvent', for_chatsay)
callbacks.Register('FireGameEvent', for_throwsay)
callbacks.Register('Draw', for_clantags)
callbacks.Register("DispatchUserMessage", for_msgevents)
callbacks.Register('CreateMove', CrosshairRecoil)
callbacks.Register("Draw", UnlockInventory)
callbacks.Register("Unload", OnUnload)
