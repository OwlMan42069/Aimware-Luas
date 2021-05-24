local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Hentai%20Killsay%20Deathsay.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Versions/Hentai%20Killsay%20Deathsay%20Version.txt";
local VERSION_NUMBER = "1.6";
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
			draw.Color(255, 150, 75,alpha);
			draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31);
		end
		draw.SetFont(updaterfont1);
		draw.Color(255,150,75,255 - fadeout);
		draw.Text(7 - 650 + fadein, 7, "RetardAlert's");
		draw.Color(225,225,225,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's ") - 650 + fadein, 7, "Killsay");
		draw.Color(255,150,75,255 - fadeout);
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

local Kill_String = {
[1] = "S-Sorry onii-chan p-please d-do me harder ;w;",
[2] = "Y-You got me all wet now senpai!",
[3] = "D-Don't t-touch me there senpai",
[4] = "P-Please l-love me harder oniichan ohh grrh aahhhh~!",
[5] = "Give me all your cum senpai ahhhhh~",
[6] = "F-Fuck me harder chan!",
[7] = "Oh my god I hate you so much senpai but please k-keep fucking me harder! ahhh~",
[8] = "D-do you like my stripped panties getting soaked by you and your hard cock? ehhh master you're so lewd ^0^~",
[9] = "kun your cute little dick between my pussy lips looks really cute, I'm blushing",
[10] = "Master does it feel good when I slide by tits up and down on your cute manly part?",
[11] = "oniichan my t-toes are so warm with your cum all over them uwu~",
[12] = "Lets take this swimsuit off already <3 i'll drink your unknown melty juice",
[13] = "S-stop senpai if we keep making these lewd sounds im going to cum~~",
[14] = "You're such a pervert for filling me up with your baby batter senpai~~",
[15] = "Fill up my baby chamber with your semen kun ^-^",
[16] = "M-master d-dont spank my petite butt so hard ahhhH~~~ you're getting me so w-wet~",
[17] = "senpai your cock is already throbbing from my huge tits~",
[18] = "Hey kun, Can I have some semen?",
[19] = "M-my baby chamber is overflowing with your semen M-master",
[20] = "Y-yes M-master right there",
[21] = "Oh do you wanna eat? Do you wanna take a bath? Or do you want me!",
[22] = "it's not gay if you swallow the evidence S-sempai",
[23] = "Fill my throat pussy with your semen kun",
[24] = "It-It's not gay if you're wearing thigh highs M-master",
[25] = "I-I need somewhere to blow my load. Can i borrow your bussy?",
[26] = "A-ah shit... Y-your cock is big and in my ass already~?!",
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
[40] = "Y-you'll break M-my womb M-master",
[41] = "Ohoo, getting creampied made you cum? What a lewd bitch you are!",
[42] = "I've jerked off every single day... Given birth to countless snails... All while fantasizing about the day I'd get to fuck you!",
[43] = "You're looking at porn when you could be using your little sister instead!",
[44] = "Umm... I don't wanna sound rude, but have you had a bath? Your panties look a bit yellow...",
[45] = "H-hey, hey S-sempai... W-wanna cuddle? UwU",
[46] = "F-fuck my bussy M-master!",
[47] = "Hey, who wants a piece of this plump 19-year-old boy-pussy? Single file, boys, come get it while it's hot!",
[48] = "Kouji-Kun, if you keep thrusting that hard, my boobs will fall off!",
[49] = "Papa you liar! How could you say that while having such a HUGE erection.",
[50] = "I-I just wanna borrow y-your dick..."
}

local Death_String = {
[1] = "hehe don't touch me there oni-chann UwU ",
[2] = "Your cum is all over my wet clit M-master",
[3] = "It Feels like you're pounding me with the force of a thousand suns senpai",
[4] = "I like when Y-you fill me with your baby water S-senpai",
[5] = "Y-yes right there S-sempai hooyah",
[6] = "P-please keep filling my baby chamber S-sempai",
[7] = "O-oni-chan it felt so good when you punded my bussy",
[8] = "P-please oni-chan keep filling my baby chamber with your melty juice",
[9] = "O-oni-chan you just one shot my baby chamber",
[10] = "I'im nothing but a F-fucktoy slut for your M-monster fuckmeat!",
[11] = "Dominate my ovaries with your vicious swimmers!",
[12] = "Impregnate me with your viral stud genes!",
[13] = "M-my body yearns for your sweet dick milk",
[14] = "Y-your meat septer has penetrated my tight boy hole",
[15] = "M-my nipples are being tantalized",
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
[29] = "P-please be gentle, Goku-Senpai!",
[30] = "We're both gonna fuck your pussy at the same time!"
 };


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

      random = math.random (1, 50)
      client.ChatSay( ' ' .. tostring( Kill_String[random]));

  elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

      random = math.random (1, 30)
      client.ChatSay( ' ' .. tostring( Death_String[random]));

  end

end

end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );
