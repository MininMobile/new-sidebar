function updateOutput(input)
	output = SKIN:GetMeter("output")
	text = output:GetOption("Text", "")

	if (text ~= "") then
		text = text .. "\r\n"
	end

	result = "I peed my pants!"
	SKIN:Bang("!SetOption", "output", "text", text .. result)
end