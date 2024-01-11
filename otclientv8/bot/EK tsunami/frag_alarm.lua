onTextMessage(function(mode, text)
    if text:lower():find("warning! the murder of") then
	playSound("/sounds/Mr-producer.ogg")
    end
end)