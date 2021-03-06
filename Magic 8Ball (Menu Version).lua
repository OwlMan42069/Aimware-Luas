-- Magic 8Ball by RetardAlert https://aimware.net/forum/user/419881/reputation/add
local c_hud_chat =
    ffi.cast("unsigned long(__thiscall*)(void*, const char*)", mem.FindPattern("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28"))(
    ffi.cast("unsigned long**", ffi.cast("uintptr_t", mem.FindPattern("client.dll", "B9 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B 5D 08")) + 1)[0],
    "CHudChat"
)

local ffi_print_chat = ffi.cast("void(__cdecl*)(int, int, int, const char*, ...)", ffi.cast("void***", c_hud_chat)[0][27])

function client.PrintChat(msg)
    ffi_print_chat(c_hud_chat, 0, 0, " " .. msg)
end

-- GUI
local ref = gui.Reference("Misc", "Enhancement", "Appearance")
local magic_8ball = gui.Editbox(ref, "magicballz", "Insert Cringy Question Here")


-- Phrases & Colors
local notice1 = {"You must ask the ball a question for a response.",}
local question1 = {"Question:",}
local answer1 = {"Answer:",}
local prefix1 = {"\01[\03Magic 8Ball\01]",}
local w1 = {"\01",}
local r1 = {"\07",}
local g1 = {"\06",}
local b1 = {"\11",}
local y1 = {"\09",}

local responses = {
    "Yes - definitely.",
    "It is decidedly so.",
    "Without a doubt.",
    "Reply hazy, try again.",
    "Ask again later.",
    "Better not tell you now.",
    "My sources say no.",
    "Outlook not so good.",
    "Very doubtful.",
}

-- Magic 8Ball
gui.Button(ref, "Shake Magic 8Ball", function() magic_8ball:GetValue()
    local notice = notice1[math.random(#notice1)]
    local question = question1[math.random(#question1)]
    local answer = answer1[math.random(#answer1)]
    local prefix = prefix1[math.random(#prefix1)]
    local w = w1[math.random(#w1)]
    local r = r1[math.random(#r1)]
    local g = g1[math.random(#g1)]
    local b = b1[math.random(#b1)]
    local y = y1[math.random(#y1)]
    local response = responses[math.random(#responses)]
    if string.len(magic_8ball:GetValue()) > 3 then
        msg = ('%s %s %s %s %s %s - %s %s %s %s'):format(prefix, g, question, y, magic_8ball:GetValue(), w, r, answer, b, response)
        client.PrintChat(msg)
    else
        msg2 = ('%s %s %s'):format(prefix, r, notice)
        client.PrintChat(msg2)
    end
end)
