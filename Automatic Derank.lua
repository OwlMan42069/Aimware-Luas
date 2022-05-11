local ref = gui.Reference('Misc', 'General', 'Extra')
local AutoDerank = gui.Checkbox(ref, 'auto.derank', 'Automatic Derank', false)
AutoDerank:SetDescription('Have the rest of your team leave before the match starts.')

local function Derank(e)
    if e:GetName() == 'round_prestart' and AutoDerank:GetValue() or e:GetName() == 'round_start' and AutoDerank:GetValue() then
        client.Command('disconnect', true)
        panorama.RunScript("CompetitiveMatchAPI.ActionReconnectToOngoingMatch()")
    end
end

client.AllowListener('round_prestart')
client.AllowListener('round_start')
callbacks.Register('FireGameEvent', Derank)
