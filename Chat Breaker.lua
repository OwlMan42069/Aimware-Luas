-- Chat Breaker by RetardAlert (https://aimware.net/forum/user/419881)
local ref = gui.Reference("Misc" , "Enhancement", "Appearance")
local chat_breaker = gui.Checkbox(ref, "chat.breaker", "Chat Breaker", false)
chat_breaker:SetDescription("Clears chat when a player sends a message.")

local function ChatBreaker( msg )    
    if msg:GetID() == 6 and chat_breaker:GetValue() == true then
        local index = msg:GetInt( 1 );
        local message = msg:GetString( 4, 1 );
        local breaker = {
        "﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽",
        };
        client.ChatSay( breaker[math.random(#breaker)] )
      end
  end
callbacks.Register( "DispatchUserMessage", "UserMessage", ChatBreaker );
