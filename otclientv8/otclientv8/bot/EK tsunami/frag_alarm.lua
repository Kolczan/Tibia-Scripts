onTextMessage(function(mode, text)
    if text:lower():find("warning! the murder of") then
	playSound("/sounds/koldi.ogg")
    end
end)