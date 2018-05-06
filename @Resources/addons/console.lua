function updateOutput(input)
	output = SKIN:GetMeter("output")
	text = output:GetOption("Text", "")

	if (text ~= "") then
		text = text .. "\r\n"
	end

	if (input == "") then
		return
	end

	result = ""
	command = split(input)

	if (command[1] == "echo") then
		table.remove(command, 1);
		result = table.concat(command, " ")
	else
		result = "ERROR: Invalid Command [" .. command[1] .. "]"
	end

	SKIN:Bang("!SetOption", "output", "text", text .. result)
end

function split(str)
	t = { }

	for i in string.gmatch(str, "%S+") do
		table.insert( t, i )
	end

	return t
end