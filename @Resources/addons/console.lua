file = ""

function Initialize()
	at = SKIN:GetVariable("@")
	total = ""
	for line in io.lines(at.."console.txt") do
		total = total .. line .. "\r\n"
	end
	SKIN:Bang("!SetOption", "output", "text", total)

	file = io.open(at.."console.txt", "a")
end

function updateOutput(input)
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

				result = "Removed #" .. command[3] .. " from Shortcuts"
			end
		elseif (command[2] == "clear") then
			settings = SKIN:ReplaceVariables("#@#settings.inc")
			SKIN:Bang("!WriteKeyValue", "Variables", "tasks", "No Tasks Available", settings)
			result = "Chlorinated the taskpool"
		else
			result = "ERROR: Invalid Argument [" .. command[2] .. "]"
		end
	elseif (command[1] == "short") then
		if (command[2] == "add") then
			shorts = SKIN:GetVariable("shortcuts")

			short = command[3]
			table.remove(command, 1);
			table.remove(command, 1);
			table.remove(command, 1);
			path = table.concat(command, " ")
	
			if (shorts == "No Shortcuts Available") then
				settings = SKIN:ReplaceVariables("#@#settings.inc")
				SKIN:Bang("!WriteKeyValue", "Variables", "shortcuts", short.."!"..path, settings)
			else
				settings = SKIN:ReplaceVariables("#@#settings.inc")
				newshorts = shorts .. "," .. short.."!"..path
				SKIN:Bang("!WriteKeyValue", "Variables", "shortcuts", newshorts, settings)
			end
	
			result = "Added [" .. short .. "] to Shortcuts"
		elseif (command[2] == "remove") then
			settings = SKIN:ReplaceVariables("#@#settings.inc")
			shorts = SKIN:GetVariable("shortcuts")

			short = command[3]
			shortslist = splitComma(shorts)

			if (shortcuts == "No Tasks Available") then
				result = "ERROR: No Shortcuts to Remove"
			elseif not (string.find(shorts, short)) then
				result = "ERROR: Shortcut Doesn't Exist"
			else
				newshortlist = { }

				for _, i in pairs(shortslist) do
					if not (string.find(i, short)) then
						table.insert(newshortlist, i)
					end
				end

				newshorts = table.concat(newshortlist, ",")

				if (newshorts == "") then
					newshorts = "No Shortcuts Available"
				end

				SKIN:Bang("!WriteKeyValue", "Variables", "shortcuts", newshorts, settings)

				result = "Removed [" .. short .. "] from Shortcuts"
			end
		elseif (command[2] == "clear") then
			settings = SKIN:ReplaceVariables("#@#settings.inc")
			SKIN:Bang("!WriteKeyValue", "Variables", "shortcuts", "No Shortcuts Available", settings)
			result = "Mutilated the Shortcuts"
		else
			result = "ERROR: Invalid Argument [" .. command[2] .. "]"
		end
	elseif (command[1] == "cls") then
		at = SKIN:GetVariable("@")
		file:close()
		file = io.open(at.."console.txt", "w")
		file:close()
		SKIN:Bang("!Refresh")
	else
		result = "ERROR: Invalid Command [" .. command[1] .. "]"
	end

	file:write(result .. "\r\n")
	SKIN:Bang("!Refresh")
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