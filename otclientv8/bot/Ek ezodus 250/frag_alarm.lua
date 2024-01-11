onTextMessage(function(mode, text)
    if text:lower():find("warning! the murder of") then
	playSound("/sounds/FRAG_WSTAWAJ.ogg")
    end
end)