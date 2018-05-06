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

	if      (command[1] == "echo") then
		table.remove(command, 1);
		result = table.concat(command, " ")
	else if (command[1] == "task" and command[2] == "add") then
		tasks = SKIN:GetVariable("tasks")

		table.remove(command, 1);
		table.remove(command, 1);
		task = table.concat(command, " ")

		if (tasks == "No Tasks Available") then
			settings = SKIN:ReplaceVariables("#@#settings.inc")
			SKIN:Bang("!WriteKeyValue", "Variables", "tasks", task, settings)
		else
			settings = SKIN:ReplaceVariables("#@#settings.inc")
			newtasks = tasks .. "," .. task
			SKIN:Bang("!WriteKeyValue", "Variables", "tasks", newtasks, settings)
		end

		result = "Added [" .. task .. "] to tasklist"
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