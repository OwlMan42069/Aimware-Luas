-- No More Menu Music for new accounts by RetardAlert! Make sure to set the lua as autorun.
callbacks.Register('Draw', function()
    client.Command("snd_menumusic_volume 0", true);
end)