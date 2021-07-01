--------Auto Update-------- https://aimware.net/forum/thread/151605
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Hentai%20Killsay%20Deathsay.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Versions/Hentai%20Killsay%20Deathsay%20Version.txt";
local VERSION_NUMBER = "2.13";
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
local misc_ref = gui.Reference("Misc");
local tab = gui.Tab(misc_ref, "RetardAlert", ("ThighHighs.club v" .. VERSION_NUMBER));
local misc_left = gui.Groupbox(tab, "Killsay / Deathsay", 10, 15, 310, 400);
local misc_left2= gui.Groupbox(tab, "Clantags", 10, 160, 310, 400);
local misc_left3 = gui.Groupbox(tab, "Grenade Throwsay", 10, 305, 310, 400);
local misc_right = gui.Groupbox(tab, "Misc", 325, 15, 305, 400);

local enable_killsays = gui.Checkbox(misc_left, "enable.killsays", "Enable Killsay Deathsay", true)
local killsay_mode = gui.Combobox(misc_left, "killsay.mode", "Select Killsay Mode", "Hentai", "Lewd", "Apologetic", "Edgy", "EZfrags")

local enable_clantags = gui.Checkbox(misc_left2, "enable.clantags", "Enable Premade Clantags", false)
local clantag_mode = gui.Combobox(misc_left2, "clantag.mode", "Select Clantag Mode", "UwU Rawr xD!", "Sussy Baka", "Sorry Not Sorry", "EZFrags.co.uk")

local enable_throwsay = gui.Checkbox(misc_left3, "enable.throwsay", "Enable Grenade Throwsay", false)
local grenade_throwsay = gui.Multibox(misc_left3, "Select Grenades")
local enable_hegrenade = gui.Checkbox(grenade_throwsay, "enable.hegrenade", "HE Grenade", true)
local enable_flashbang = gui.Checkbox(grenade_throwsay, "enable.flashbang", "Flashbang", true)
local enable_smokegrenade = gui.Checkbox(grenade_throwsay, "enable.smokegrenade", "Smoke", true)
local enable_molotov = gui.Checkbox(grenade_throwsay, "senable.molotov", "Molotov/Incendiary", true)

local EngineRadar = gui.Checkbox(misc_right, "engineradar", "Engine Radar", true)
local ForceCrosshair = gui.Checkbox(misc_right, "forcecrosshair", "Force Crosshair", true)
local laffmode = gui.Checkbox(misc_right, "laffmode", "Laff Mode", true)
local copy_chat = gui.Checkbox(misc_right, "chat.copy", "Copy Chat Messages", false)
local chat_breaker = gui.Checkbox(misc_right, "chat.breaker", "Chat Breaker", false)

EngineRadar:SetDescription("Display enemies on your in-game radar.")
ForceCrosshair:SetDescription("Display your in-game crosshair while holding snipers.")
laffmode:SetDescription("Replaces lol with laff in chat :laff:")
copy_chat:SetDescription("Repeats player messages.")
chat_breaker:SetDescription("Clears chat when a player types.")

--------Hentai Clantag Animation--------
local hentai_animation = {
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
}

--------Baka Clantag Animation--------
local baka_animation = {
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
}

--------Apologetic Clantag Animation--------
local sorry_animation = {
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
}

--------EZfrags Clantag Animation--------
local ezfrags_animation = {
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
}

--------Anti AFK + No Startup Music--------
	client.Command("+right", true);
	client.Command("+left", true);
	client.Command("snd_menumusic_volume 0", true);

--------Engine Radar--------
callbacks.Register('Draw', function()
	if EngineRadar:GetValue() == true then
		isEngineRadarOn = 1
	else
		isEngineRadarOn = 0
	end

	for index, Player in pairs(entities.FindByClass('CCSPlayer')) do
        Player:SetProp('m_bSpotted', isEngineRadarOn)
	end
end)

--------Force Crosshair--------
client.AllowListener('item_equip')
callbacks.Register('FireGameEvent', function(Event)
	if not ForceCrosshair:GetValue() == true or Event:GetName() ~= 'item_equip' then
		if not ForceCrosshair:GetValue() == true and client.GetConVar('weapon_debug_spread_show') == '3' then
			client.SetConVar('weapon_debug_spread_show', 0, true)
			return
		end
		return
	end

	local LocalPlayerIndex = client.GetLocalPlayerIndex()
	local PlayerIndex = client.GetPlayerIndexByUserID( Event:GetInt('userid') )
	local WeaponType = Event:GetInt('weptype')

	if LocalPlayerIndex == PlayerIndex then
		if WeaponType == 5 then
			client.SetConVar('weapon_debug_spread_show', 3, true)
		else
			client.SetConVar('weapon_debug_spread_show', 0, true)
		end	
	end
end)

--------Inventory Unlocker--------
local function UnlockInventory()
    panorama.RunScript([[ LoadoutAPI.IsLoadoutAllowed = () => { return true; }; ]]);
end

--------Laff Mode--------
callbacks.Register( "SendStringCmd", function( cmd )
  if string.find( cmd:Get(), "say \"lol\"" ) == 1 and laffmode:GetValue() == true then
      cmd:Set( "say \"laff\"" );
  end

end)

--------Copy Chat Messages--------
local function CopyMessages( msg )    
  if msg:GetID() == 6 and copy_chat:GetValue() == true then
      local index = msg:GetInt( 1 );
      local message = msg:GetString( 4, 1 );
      local name = client.GetPlayerNameByIndex( index );
      client.ChatSay(message);
    end    
end

--------Chat Breaker--------
local function ChatBreaker( msg )    
  if msg:GetID() == 6 and chat_breaker:GetValue() == true then
      local index = msg:GetInt( 1 );
      local message = msg:GetString( 4, 1 );
      local name = client.GetPlayerNameByIndex( index );
      local breaker = {
      "﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽",
      };
      client.ChatSay( breaker[math.random(#breaker)] )
    end
end

--------Grenade Throwsay--------
local hegrenade_phrases = {
  hegrenade = {
      'Catch retard!',
      'Heads up!',
      'This is gonna hurt.',
  },
}

local flashbang_phrases  = {
  flashbang = {
      'Look a bird!',
      'Look a plane!',
      'FLASHBANG!',
  },
}

local molotov_phrases  = {
  molotov = {
      'Fire hot retard!',
      'BURN BABY BURN!',
  },

  incgrenade = {
      'Fire hot retard!',
      'BURN BABY BURN!',
  }
}

local smokegrenade_phrases  = {
  smokegrenade = {
      'I am a ninja',
      'Very Sneaky Man',
      'NINJA DEFUSE!',
  },
}

local function hegrenade_throwsay(event)
  if event:GetName() ~= 'grenade_thrown' then
      return
  end

  if client.GetPlayerIndexByUserID(event:GetInt('userid')) ~= client.GetLocalPlayerIndex() then
      return
  end

  local he_says = hegrenade_phrases [event:GetString('weapon')]
  if enable_throwsay:GetValue() == true and enable_hegrenade:GetValue() == true then
  client.ChatSay( he_says[math.random(#he_says)] )
  end
end

  local function flashbang_throwsay(event)
      if event:GetName() ~= 'grenade_thrown' then
          return
      end
    
      if client.GetPlayerIndexByUserID(event:GetInt('userid')) ~= client.GetLocalPlayerIndex() then
          return
      end

  local flash_says = flashbang_phrases [event:GetString('weapon')]
  if enable_throwsay:GetValue() == true and enable_flashbang:GetValue() == true then
  client.ChatSay( flash_says[math.random(#flash_says)] )
  end
end

  local function molotov_throwsay(event)
      if event:GetName() ~= 'grenade_thrown' then
          return
      end
    
      if client.GetPlayerIndexByUserID(event:GetInt('userid')) ~= client.GetLocalPlayerIndex() then
          return
      end

  local molotov_says = molotov_phrases [event:GetString('weapon')]
  if enable_throwsay:GetValue() == true and enable_molotov:GetValue() == true then
  client.ChatSay( molotov_says[math.random(#molotov_says)] )
  end
end

  local function smokegrenade_throwsay(event)
      if event:GetName() ~= 'grenade_thrown' then
          return
      end
    
      if client.GetPlayerIndexByUserID(event:GetInt('userid')) ~= client.GetLocalPlayerIndex() then
          return
      end

  local smoke_says = smokegrenade_phrases [event:GetString('weapon')]
  if enable_throwsay:GetValue() == true and enable_smokegrenade:GetValue() == true then
  client.ChatSay( smoke_says[math.random(#smoke_says)] )
  end
end

--------Hentai Clantag--------
local clantagset = 0;
clantag_mode:SetDisabled(tradition);

ffi.cdef[[
    typedef int(__fastcall* clantag_t)(const char*, const char*);
]]
local fn_change_clantag = mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15")
local set_clantag = ffi.cast("clantag_t", fn_change_clantag)

local function Hentai_Clantag()
	if enable_clantags:GetValue() == true and clantag_mode:GetValue() == 0 then
		local curtime = math.floor(globals.CurTime() * 2.3);
    	if old_time ~= curtime then
    	    set_clantag(hentai_animation[curtime % #hentai_animation+1], hentai_animation[curtime % #hentai_animation+1]);
    	end
    	old_time = curtime;
		clantagset = 1;
	else
		if clantagset == 1 then
            clantagset = 0;
            set_clantag("", "");
        end
	end
end

--------Sussy Baka Clantag--------
local clantagset = 0;

local function Baka_Clantag()
	if enable_clantags:GetValue() == true and clantag_mode:GetValue() == 1 then
		local curtime = math.floor(globals.CurTime() * 2.3);
    	if old_time ~= curtime then
    	    set_clantag(baka_animation[curtime % #baka_animation+1], baka_animation[curtime % #baka_animation+1]);
    	end
    	old_time = curtime;
		        clantagset = 1;
	else
		if clantagset == 1 then
            clantagset = 0;
            set_clantag("", "");
        end
	end
end

--------Apologetic Clantag--------
local clantagset = 0;

local function Apologetic_Clantag()
	if enable_clantags:GetValue() == true and clantag_mode:GetValue() == 2 then
		local curtime = math.floor(globals.CurTime() * 2.3);
    	if old_time ~= curtime then
    	    set_clantag(sorry_animation[curtime % #sorry_animation+1], sorry_animation[curtime % #sorry_animation+1]);
    	end
    	old_time = curtime;
		        clantagset = 1;
	else
		if clantagset == 1 then
            clantagset = 0;
            set_clantag("", "");
        end
	end
end

--------EZfrags Clantag--------
local clantagset = 0;

local function EZfrags_Clantag()
	if enable_clantags:GetValue() == true and clantag_mode:GetValue() == 3 then
		local curtime = math.floor(globals.CurTime() * 2.3);
    	if old_time ~= curtime then
    	    set_clantag(ezfrags_animation[curtime % #ezfrags_animation+1], ezfrags_animation[curtime % #ezfrags_animation+1]);
    	end
    	old_time = curtime;
		        clantagset = 1;
	else
		if clantagset == 1 then
            clantagset = 0;
            set_clantag("", "");
        end
	end
end

--------Hentai Killsay Deathsay--------
local Hentai_Kill = {
  [1] = "S-Sorry onii-chan p-please d-do me harder ;w;",
  [2] = "Y-You got me all wet now Senpai!",
  [3] = "D-Don't t-touch me there Senpai",
  [4] = "P-Please l-love me harder oniichan ohh grrh aahhhh~!",
  [5] = "Give me all your cum Senpai ahhhhh~",
  [6] = "F-Fuck me harder chan!",
  [7] = "Oh my god I hate you so much Senpai but please k-keep fucking me harder! ahhh~",
  [8] = "D-Do you like my stripped panties getting soaked by you and your hard cock? ehhh master you're so lewd ^0^~",
  [9] = "Kun your cute little dick between my pussy lips looks really cute, I'm blushing",
  [10] = "M-Master does it feel good when I slide by tits up and down on your cute manly part?",
  [11] = "O-Oniichan my t-toes are so warm with your cum all over them uwu~",
  [12] = "Lets take this swimsuit off already <3 i'll drink your unknown melty juice",
  [13] = "S-Stop Senpai if we keep making these lewd sounds im going to cum~~",
  [14] = "You're such a pervert for filling me up with your baby batter Senpai~~",
  [15] = "Fill up my baby chamber with your semen kun ^-^",
  [16] = "M-Master d-dont spank my petite butt so hard ahhhH~~~ you're getting me so w-wet~",
  [17] = "Senpai your cock is already throbbing from my huge tits~",
  [18] = "Hey kun, Can I have some semen?",
  [19] = "M-My baby chamber is overflowing with your semen M-Master",
  [20] = "Fill my throat pussy with your semen kun",
  [21] = "It-It's not gay if you're wearing thigh highs M-Master",
  [22] = "I-I need somewhere to blow my load. Can i borrow your bussy?",
  [23] = "A-ah shit... Y-your cock is big and in my ass -- already~?!",
  [24] = "I'll swallow your sticky essence along with you~!",
  [25] = "B-Baka please let me be your femboy sissy cum slut!",
  [26] = "That's a penis UwU you towd me you wewe a giww!!",
  [27] = "Ahhhh... It's like a dream come true... I get to stick my dick inside your ass...!",
  [28] = "Hey, who wants a piece of this plump 19-year-old boy-pussy? Single file, boys, come get it while it's hot!",
  [29] = "M-Master, if you keep thrusting that hard, my boobs will fall off!",
  [30] = "When do you wanna meet up again? I've really taken a liking to your dick! (,,◠∇◠) I want you and only you to slam it into my pussy every day! (≧∇≦)",
  [31] = "All I did was crossplay 'cause I felt like it might be fun... But now I'm just a little girl that cums from big dicks!",
  [32] = "D-Don't get the wrong idea!!! I don't w-want you to fuck my b-bussy because I l-love you or anything! d-definitely not!",
  [33] = "I-I know I said you could be as rough as you want... But surprise fisting wasn't what I had in mind!!",
  [34] = "W-Why is it that lately... Y-You haven't been playing with my ass!!?",
  }
  
  local Hentai_Death = {
  [1] = "Hehe don't touch me there Onii-chann UwU",
  [2] = "Your cum is all over my wet clit M-Master",
  [3] = "It Feels like you're pounding me with the force of a thousand suns Senpai",
  [5] = "Y-Yes right there S-Sempai hooyah",
  [6] = "P-Please keep filling my baby chamber S-Sempai",
  [7] = "O-Onii-chan it felt so good when you punded my bussy",
  [8] = "P-Please Onii-chan keep filling my baby chamber with your melty juice",
  [9] = "O-Onii-chan you just one shot my baby chamber",
  [10] = "I-Im nothing but a f-fucktoy slut for your m-monster fuckmeat!",
  [11] = "Dominate my ovaries with your vicious swimmers!",
  [12] = "Y-Your meat septer has penetrated my tight boy hole",
  [13] = "Mnn FASTER... HARDER! Turn me into your femboy slut~!",
  [14] = "Mmmm- soothe me, caress me, Fuck me, breed me!",
  [15] = "Probe your thick, wet, throbbing cock deeper and deeper into my boipussy~!!",
  [16] = "Hya! Not my ears! Ah... It tickles! Ah!",
  [17] = "Kouta... I can't believe how BIG his... Wait! Forget about that!! Is Nyuu-chan really giving him a Tit-Fuck!?",
  [18] = "Senpai shove deeper your penis in m-my pussy (>ω<) please",
  [19] = "I'm coming fwom you fwuking my asshole mmyyy!",
  [20] = "P-Please be gentle, S-Senpai!",
  [21] = "D-Don't get the wrong idea!! I didn't give up my viginity to you because I like you or anything!!",
  [22] = "Let me taste your futa cock with my pussy~",
   };

function Hentai_Killsay( Event )

if ( Event:GetName() == 'player_death' ) and enable_killsays:GetValue() == true and killsay_mode:GetValue() == 0 then

  local ME = client.GetLocalPlayerIndex();

  local INT_UID = Event:GetInt( 'userid' );
  local INT_ATTACKER = Event:GetInt( 'attacker' );

  local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
  local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

  local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
  local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

  if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

      random = math.random (1, 34)
      client.ChatSay( ' ' .. tostring( Hentai_Kill[random]));

  elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

      random = math.random (1, 22)
      client.ChatSay( ' ' .. tostring( Hentai_Death[random]));

  end

end

end

--------Lewd Killsay Deathsay--------
local Lewd_Kill = {
  [1] = "Oh do you wanna eat? Do you wanna take a bath? Or do you want me!",
  [2] = "It's not gay if you swallow the evidence!",
  [3] = "That's a penis UwU you towd me you wewe a giww!!",
  [4] = "You are cordially invited to fuck my ass!",
  [5] = "Grab them, squeeze them, pinch them, pull them, lick them, bite them, suck them!",
  [6] = "It feels like your dick is sliding into a slimy pile of macaroni!",
  [7] = "This is the cock block police! Hold it right there!",
  [8] = "Ohoo, getting creampied made you cum? What a lewd bitch you are!",
  [9] = "I've jerked off every single day... Given birth to countless snails... All while fantasizing about the day I'd get to fuck you!",
  [10] = "You're looking at porn when you could be using your little sister instead!",
  [11] = "Umm... I don't wanna sound rude, but have you had a bath? Your panties look a bit yellow...",
  [12] = "Papa you liar! How could you say that while having such a HUGE erection.",
  [13] = "I-I just wanna borrow y-your dick...",
  [14] = "If a man inserts his hose into another man's black hole, can they make a baby?",
  [15] = "I-I had a itch down there... and I-I just needed something to-to stick up in there!",
  [16] = "You have some tasty-looking panties there...",
  [17] = "You're my personal cum bucket!!",
  [18] = "I-I'm cumming, I'm cumming, CUM with me too!",
  [19] = "Your resistance only makes my penis harder!",
  [20] = "Cum, you naughty cock! Do it! Do it! DO IT!!!",
  [21] = "Boys just can't consider themselves an adult... Until they've had a chance to cum with a girl's ampit.",
  [22] = "We're both gonna fuck your pussy at the same time!",
  [23] = "When everyone's gone home for the day and the class-room's empty you have no choice but to expose yourself and jerk off, right?",
  }
  
  local Lewd_Death = {
  [1] = "Dominate my ovaries with your vicious swimmers!",
  [2] = "Impregnate me with your viral stud genes!",
  [3] = "M-My body yearns for your sweet dick milk",
  [4] = "My nipples are being tantalized",
  [5] = "Penetrate me until I bust!",
  [6] = "Mmmm- soothe me, caress me, Fuck me, breed me!",
  [7] = "I'm your personal cum bucket!!",
  [8] = "Can you really blame me for getting a boner after seeing that?",
  [9] = "The two of us will cover my sis with our cum!",
  [10] = "This... This is almost like... like somehow I'm the one raping him!",
  [11] = "You're impregnating my balls!?",
  [12] = "If you weren't a pervert, you wouldn't be getting off on having a girl do you in the butt, would you?",
  [13] = "Well, well... What a cutie you are! I will claim your virginity!",
  [14] = "Oh, yeahh! You wanna fuck?",
  [15] = "I'm getting pissed off and hormy right now!",
   };

function Lewd_Killsay( Event )

  if ( Event:GetName() == 'player_death' ) and enable_killsays:GetValue() == true and killsay_mode:GetValue() == 1 then
  
    local ME = client.GetLocalPlayerIndex();
  
    local INT_UID = Event:GetInt( 'userid' );
    local INT_ATTACKER = Event:GetInt( 'attacker' );
  
    local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
    local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
  
    local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
    local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
  
    if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
  
        random = math.random (1, 23)
        client.ChatSay( ' ' .. tostring( Lewd_Kill[random]));
  
    elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then
  
        random = math.random (1, 15)
        client.ChatSay( ' ' .. tostring( Lewd_Death[random]));
  
    end
  
  end
  
  end

--------Apologetic Killsay Deathsay--------
local apologetic = {"am sorry that","am feeling sad after","am distressed because","am upset with myself because","have been diagnosed with depression because","am broken hearted that","apologize that","would like to apologize because","am quite remorseful because","am ashamed of myself because"};
local kill_method = {"killed","destroyed","put an end to","ended","assassinated","terminated","eliminated","executed","slaughtered","butchered","shot and killed", "annihilated"};
local regret = {":(","Please forgive me","I didn't mean to.","I'm a failure","I will go easy on you next time.","That was my fault","Please excuse my behaviour", "I bring dishonor to my household"};

local function Sorry_KillSay( Event )

   if ( Event:GetName() == 'player_death' ) and enable_killsays:GetValue() == true and killsay_mode:GetValue() == 2 then

       local ME = client.GetLocalPlayerIndex();

       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );

       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

           client.ChatSay(NAME_Victim  .. ", I " .. apologetic[math.random( #apologetic )] .. " I " .. kill_method[math.random( #kill_method )] .. " you. " .. regret[math.random( #regret )]);

       end

   end

end

--------Edgy Killsay Deathsay--------
local Edgy_Kill = {
  [1] = "Let my K/D do the talking",
  [2] = "mad cuz bad",
  [3] = "No Aimware no talk",
  [4] = "Config error, user banned, thread locked.",
  [5] = "IQ error",
  [6] = "I'm the reason your dads gay faggot",
  [7] = "How's your mom doin after last night?",
  [8] = "Dead people can't talk nn",
  [9] = "Warmth, love, and affection. These are the things I have taken away from you.",
  [10] = "I’ve made a contract with the devil, so I can’t be friends with a god.",
  [11] = "Corpses are good. They don’t babble.",
  [12] = "The weak are destined to lie beneath the boots of the strong.",
  [13] = "Options -> How to play",
  [14] = "The world is better without you",
  [15] = "Life is endless suffering...",
  [16] = "I'm just killing the spiders to save the butterflies.",
  [17] = "Fear is what creates order.",
  [18] = "No matter how much you cry I won't stop.",
  [19] = "Deleted",
  [20] = "*DEAD*",
  [21] = "Re_solved",
  [22] = "De_stroyed",
  [23] = "If G-D wanted you to live he would not have created me.",
  [24] = "Earn your damnation",
  [25] = "Vengeance is mine",
  [26] = "If at first you do not succeed... try, try again.",
  [27] = "Watch your head",
  [28] = "When you are ready call for me",
  [29] = "I have become death destroyer of worlds",
  [30] = "Easy come easy go",
  [31] = "I stay you go",
  [32] = "End of the line for you",
  [33] = "Maybe tomorrow.",
  [34] = "I'm fucking invincible.",
  [35] = "See you in a couple of minutes.",
  [36] = "You are strong child, but I am beyond strength",
  }
  
  local Edgy_Death = {
  [1] = "You only killed me because I ran out of health..",
  [2] = "I bet dead people are easier to get along with.",
  [3] = "The real hell is inside the person.",
  [4] = "The ones who kill should be prepared to be killed.",
  [5] = "I gave you that one",
  [6] = "Congratulations! You're on the scoarboard now.",
  [7] = "Emotions are a mental disorder",
  [8] = "Carpe Diem",
  [9] = "Gone but not forgotten",
  [10] = "I'll be back",
  [11] = "Deploying the counter measure",
  [12] = "There are no ends only new beginnings",
   };

function Edgy_Killsay( Event )

  if ( Event:GetName() == 'player_death' ) and enable_killsays:GetValue() == true and killsay_mode:GetValue() == 3 then
  
    local ME = client.GetLocalPlayerIndex();
  
    local INT_UID = Event:GetInt( 'userid' );
    local INT_ATTACKER = Event:GetInt( 'attacker' );
  
    local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
    local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
  
    local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
    local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
  
    if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
  
        random = math.random (1, 36)
        client.ChatSay( ' ' .. tostring( Edgy_Kill[random]));
  
    elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then
  
        random = math.random (1, 12)
        client.ChatSay( ' ' .. tostring( Edgy_Death[random]));
  
    end
  
  end
  
  end

--------EzFrags Killsay--------
local ezfrags_killsays = {
  [1] = "Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
  [2] = "Stop being a noob! Get good with www.EZfrags.co.uk",
  [3] = "I'm not using www.EZfrags.co.uk, you're just bad",
  [4] = "You just got pwned by EZfrags, the #1 CS:GO cheat",
  [5] = "If I was cheating, I'd use www.EZfrags.co.uk",
  [6] = "Think you could do better? Not without www.EZfrags.co.uk",
}

local ezfrags_deathsays = {
  [1] = "You only killed me because I'm not using www.EZfrags.co.uk",
  [2] = "You're lucky I'm not using www.EZfrags.co.uk",
  [3] = "I would have destroyed you if I was using www.EZfrags.co.uk",
  [4] = "You only killed me because you're using www.EZfrags.co.uk the finest public & private CS:GO cheat",
   };

local function ezfrags_KillSay( Event )
  
 if ( Event:GetName() == 'player_death' ) and enable_killsays:GetValue() == true and killsay_mode:GetValue() == 4 then
      
     local ME = client.GetLocalPlayerIndex();
     
     local INT_UID = Event:GetInt( 'userid' );
     local INT_ATTACKER = Event:GetInt( 'attacker' );
     
     local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
     local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
     
     local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
     local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
      
     if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
  
      random = math.random (1, 6)
      client.ChatSay( ' ' .. tostring( ezfrags_killsays[random]));

  elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

      random = math.random (1, 4)
      client.ChatSay( ' ' .. tostring( ezfrags_deathsays[random]));

  end

end

end

--------Draw Image--------
local function OnUnload()
	client.Command("toggleconsole", true);
	client.Command("echo \"⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄\"", true);
	client.Command("echo \" ⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄\"", true);
	client.Command("echo \"⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄\"", true);
	client.Command("echo \"⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄\"", true);
	client.Command("echo \"⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰\"", true);
	client.Command("echo \"⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤\"", true);
	client.Command("echo \"⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗\"", true);
	client.Command("echo \"⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄\"", true);
	client.Command("echo \"⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄\"", true);
	client.Command("echo \"⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄\"", true);
	client.Command("echo \"⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄\"", true);
	client.Command("echo \"⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄\"", true);
	client.Command("echo \"⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄\"", true);
	client.Command("echo \"⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴\"", true);
	client.Command("echo \"⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿\"", true);
	set_clantag("", "");
end

--------Lua Callbacks--------
client.AllowListener( 'player_death' );
client.AllowListener('grenade_thrown')
callbacks.Register( 'FireGameEvent', 'AWKS', Hentai_Killsay );
callbacks.Register( 'FireGameEvent', 'AWKS', Lewd_Killsay );
callbacks.Register( 'FireGameEvent', 'AWKS', Sorry_KillSay );
callbacks.Register( 'FireGameEvent', 'AWKS', Edgy_Killsay );
callbacks.Register( 'FireGameEvent', 'AWKS', ezfrags_KillSay );
callbacks.Register( "Draw", Hentai_Clantag);
callbacks.Register( "Draw", Baka_Clantag);
callbacks.Register( "Draw", Apologetic_Clantag);
callbacks.Register( "Draw", EZfrags_Clantag);
callbacks.Register( "Draw", UnlockInventory);
callbacks.Register( "DispatchUserMessage", "UserMessage", CopyMessages );
callbacks.Register( "DispatchUserMessage", "UserMessage", ChatBreaker );
callbacks.Register('FireGameEvent', hegrenade_throwsay)
callbacks.Register('FireGameEvent', flashbang_throwsay)
callbacks.Register('FireGameEvent', molotov_throwsay)
callbacks.Register('FireGameEvent', smokegrenade_throwsay)
callbacks.Register( "Unload", OnUnload);
