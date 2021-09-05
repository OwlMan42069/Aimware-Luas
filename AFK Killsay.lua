local ref = gui.Reference("Misc", "Enhancement", "Appearance")
local Enable_AfkKillsay = gui.Checkbox(ref, "afk.killsay", "AFK Killsay", false)
Enable_AfkKillsay:SetDescription("States you're AFK with the players name and your weapon.")

local function AfkKillsay( Event )
    
    if ( Event:GetName() == 'player_death' ) and Enable_AfkKillsay:GetValue() == true then
	
        local lp = client.GetLocalPlayerIndex()
        local victim = client.GetPlayerIndexByUserID(Event:GetInt('userid'))
        local attacker = client.GetPlayerIndexByUserID(Event:GetInt('attacker'))
        local victim_name = client.GetPlayerNameByIndex(victim)
        local attacker_weapon = Event:GetString('weapon')

        if ( attacker == lp and victim ~= lp ) then
            client.ChatSay("Sorry " .. victim_name  .. ", I'm AFK. This is a bot. You died to a " .. attacker_weapon .. ".")
        end
    end
end

client.AllowListener('player_death')
callbacks.Register('FireGameEvent', 'AWKS', AfkKillsay)