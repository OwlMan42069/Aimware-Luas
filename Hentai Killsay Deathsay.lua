--------Auto Update--------
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/ThighHighs.club.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Versions/ThighHighs.club%20Version.txt";
local VERSION_NUMBER = "1.75";
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
		draw.Text(7 + draw.GetTextSize("RetardAlert's ") - 650 + fadein, 7, "Killsay");
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's Killsay  ") - 650 + fadein, 7, "\\");
		spacing = draw.GetTextSize("RetardAlert's Killsay  \\  ");
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
local ref = gui.Reference("Misc", "Enhancement", "Appearance")
local clantag = gui.Checkbox(ref, "clantag", "Hentai Clantag", false);
clantag:SetDescription("Enables Animated Hentai Clantag.");

--------Clantag Animation--------
local animation = {
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

--------Chat Messages--------
local Kill_String = {
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
[20] = "Y-Yes M-Master right there",
[21] = "Oh do you wanna eat? Do you wanna take a bath? Or do you want me!",
[22] = "It's not gay if you swallow the evidence S-Sempai",
[23] = "Fill my throat pussy with your semen kun",
[24] = "It-It's not gay if you're wearing thigh highs M-Master",
[25] = "I-I need somewhere to blow my load. Can i borrow your bussy?",
[26] = "A-ah shit... Y-your cock is big and in my ass -- already~?!",
[27] = "I-I'm cumming, I'm cumming, CUM with me too!",
[28] = "Drench me and I'll do the same!",
[29] = "I'll swallow your sticky essence along with you~!",
[30] = "You're my personal cum bucket!!",
[31] = "B-baka please let me be your femboy sissy cum slut!",
[32] = "That's a penis UwU you towd me you wewe a giww!!",
[33] = "You are cordially invited to fuck my ass!",
[34] = "Your resistance only makes my penis harder!",
[35] = "Grab them, squeeze them, pinch them, pull them, lick them, bite them, suck them!",
[36] = "It feels like his dick is sliding into a slimy pile of macaroni!",
[37] = "Cum, you naughty cock! Do it! Do it! DO IT!!!",
[38] = "Ahhhh... It's like a dream come true... I get to stick my dick inside Tatsuki Chan's ass...!",
[39] = "This is the cock block police! Hold it right there!",
[40] = "Y-you'll break m-my womb M-Master",
[41] = "Ohoo, getting creampied made you cum? What a lewd bitch you are!",
[42] = "I've jerked off every single day... Given birth to countless snails... All while fantasizing about the day I'd get to fuck you!",
[43] = "You're looking at porn when you could be using your little sister instead!",
[44] = "Umm... I don't wanna sound rude, but have you had a bath? Your panties look a bit yellow...",
[45] = "H-hey, hey S-Sempai... W-wanna cuddle? UwU",
[46] = "F-fuck my bussy M-Master!",
[47] = "Hey, who wants a piece of this plump 19-year-old boy-pussy? Single file, boys, come get it while it's hot!",
[48] = "M-Master, if you keep thrusting that hard, my boobs will fall off!",
[49] = "Papa you liar! How could you say that while having such a HUGE erection.",
[50] = "I-I just wanna borrow y-your dick...",
[51] = "If a man inserts his hose into another man's black hole, can they make a baby?",
[52] = "When do you wanna meet up again? I've really taken a liking to your dick! (,,◠∇◠) I want you and only you to slam it into my pussy every day! (≧∇≦)",
[53] = "All I did was crossplay 'cause I felt like it might be fun... But now I'm just a little girl that cums from big dicks!",
[54] = "Geez! What the fuck!? My juniors are always bullying me... And I keep getting fingers stuck up mu butt!",
[55] = "I-I had a itch down there... and I-I just needed something to-to stick up in there!",
[56] = "D-Don't get the wrong idea!!! I don't w-want you to fuck my b-bussy because I l-love you or anything! d-definitely not!",
[57] = "A-Alright then! Today my cock's an AK-47 with infinite ammo!",
[58] = "I-I know I said you could be as rough as you want... But surprise fisting wasn't what I had in mind!!",
[59] = "W-Why is it that lately... Y-You haven't been playing with my ass!!?",
[60] = "You have some tasty-looking panties there..."
}

local Death_String = {
[1] = "Hehe don't touch me there Onii-chann UwU",
[2] = "Your cum is all over my wet clit M-Master",
[3] = "It Feels like you're pounding me with the force of a thousand suns Senpai",
[4] = "I like when y-you fill me with your baby water S-Senpai",
[5] = "Y-Yes right there S-Sempai hooyah",
[6] = "P-Please keep filling my baby chamber S-Sempai",
[7] = "O-Onii-chan it felt so good when you punded my bussy",
[8] = "P-Please Onii-chan keep filling my baby chamber with your melty juice",
[9] = "O-Onii-chan you just one shot my baby chamber",
[10] = "I-Im nothing but a f-fucktoy slut for your m-monster fuckmeat!",
[11] = "Dominate my ovaries with your vicious swimmers!",
[12] = "Impregnate me with your viral stud genes!",
[13] = "M-My body yearns for your sweet dick milk",
[14] = "Y-Your meat septer has penetrated my tight boy hole",
[15] = "M-My nipples are being tantalized",
[16] = "Mnn FASTER... HARDER! Turn me into your femboy slut~!",
[17] = "Penetrate me until I bust!",
[18] = "Mmmm- soothe me, caress me, Fuck me, breed me!",
[19] = "Probe your thick, wet, throbbing cock deeper and deeper into my boipussy~!!",
[20] = "I'm your personal cum bucket!!",
[21] = "Hya! Not my ears! Ah... It tickles! Ah!",
[22] = "Can you really blame me for getting a boner after seeing that?",
[23] = "The two of us will cover my sis with our cum!",
[24] = "Kouta... I can't believe how BIG his... Wait! Forget about that!! Is Nyuu-chan really giving him a Tit-Fuck!?",
[25] = "Senpai shove deeper your penis in m-my pussy (>ω<) please",
[26] = "This... This is almost like... like somehow I'm the one raping him!",
[27] = "I'm coming fwom you fwuking my asshole mmyyy!",
[28] = "Boys just can't consider themselves an adult... Until they've had a chance to cum with a girl's ampit.",
[29] = "P-Please be gentle, S-Senpai!",
[30] = "We're both gonna fuck your pussy at the same time!",
[31] = "D-Don't get the wrong idea!! I didn't give up my viginity to you because I like you or anything!!",
[32] = "Let me taste your futa cock with my pussy~",
[33] = "You're impregnating my balls!?",
[34] = "If you weren't a pervert, you wouldn't be getting off on having a girl do you in the butt, would you?",
[35] = "Well, well... What a cutie you are! I will claim your virginity!",
[36] = "You're impregnating my balls?!",
[37] = "Do me like the girls in your manga!!",
[38] = "When everyone's gone home for the day and the class-room's empty you have no choice but to expose yourself and jerk off, right?",
[39] = "Oh, yeahh! You wanna fuck?",
[40] = "I'm getting pissed off and hormy right now!"
 };

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

--------Hentai Clantag--------
local clantagset = 0;
clantag:SetDisabled(tradition);

ffi.cdef[[
    typedef int(__fastcall* clantag_t)(const char*, const char*);
]]
local fn_change_clantag = mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15")
local set_clantag = ffi.cast("clantag_t", fn_change_clantag)

local function Clantag()
	if clantag:GetValue() == true then
		local curtime = math.floor(globals.CurTime() * 2.3);
    	if old_time ~= curtime then
    	    set_clantag(animation[curtime % #animation+1], animation[curtime % #animation+1]);
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
function CHAT_KillSay( Event )

if ( Event:GetName() == 'player_death' ) then

  local ME = client.GetLocalPlayerIndex();

  local INT_UID = Event:GetInt( 'userid' );
  local INT_ATTACKER = Event:GetInt( 'attacker' );

  local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
  local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

  local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
  local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

  if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

      random = math.random (1, 60)
      client.ChatSay( ' ' .. tostring( Kill_String[random]));

  elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

      random = math.random (1, 40)
      client.ChatSay( ' ' .. tostring( Death_String[random]));

  end

end

end

--------Lua Callbacks--------
client.AllowListener( 'player_death' );
callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );
callbacks.Register( "Draw", Clantag);
callbacks.Register( "Unload", OnUnload);
