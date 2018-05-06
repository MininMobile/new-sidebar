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
	elseif (command[1] == "task") then
		if (command[2] == "add") then
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
		elseif (command[2] == "remove") then
			settings = SKIN:ReplaceVariables("#@#settings.inc")
			tasks = SKIN:GetVariable("tasks")

			tasklist = splitComma(tasks)
			taskamount = tableLength(tasklist)

			if (tasks == "No Tasks Available") then
				result = "ERROR: No Tasks to Remove"
			elseif (tonumber(command[3]) > taskamount) or (tonumber(command[3]) <= 0) then
				result = "ERROR: Task Doesn't Exist"
			else
				table.remove(tasklist, tonumber(command[3]))
				newtasks = table.concat(tasklist, ",")

				if (newtasks == "") then
					newtasks = "No Tasks Available"
				end

				SKIN:Bang("!WriteKeyValue", "Variables", "tasks", newtasks, settings)

				result = "Removed #" .. command[3] .. " from tasklist"
			end
		elseif (command[2] == "clear") then
			settings = SKIN:ReplaceVariables("#@#settings.inc")
			SKIN:Bang("!WriteKeyValue", "Variables", "tasks", "No Tasks Available", settings)
			result = "Chlorinated the taskpool"
		else
			result = "ERROR: Invalid Argument [" .. command[2] .. "]"
		end		
	else
		result = "ERROR: Invalid Command [" .. command[1] .. "]"
	end

	SKIN:Bang("!SetOption", "output", "text", text .. result)
end

function split(str)
	local t = { }

	for i in string.gmatch(str, "%S+") do
		table.insert( t, i )
	end

	return t
end

function splitComma(str)
	local t = { }

	for i in string.gmatch(str, "([^,]+),?") do
		table.insert( t, i )
	end

	return t
end

function tableLength(t)
	local count = 0

	for _ in pairs(t) do
		count = count + 1
	end

	return count
end