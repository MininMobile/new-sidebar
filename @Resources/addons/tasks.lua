function Initialize()
	taskvar = SKIN:GetVariable("tasks")
	tasks = split(taskvar)
	taskstring = ""

	if (tasks[1] == "1. No Tasks Available") then
		taskstring = "No Tasks Available"
	else
		taskstring = table.concat(tasks, "\r\n\r\n")
	end
	
	SKIN:Bang("!SetOption", "tasks", "Text", taskstring)
end

function split(str)
	t = { }

	x = 0
	for i in string.gmatch(str, "([^,]+),?") do
		x = x + 1
		table.insert(t, x .. ". " .. i)
	end

	return t
end