function Initialize()
	shortvar = SKIN:GetVariable("shortcuts")
	shorts = split(shortvar)
	shortsstring = ""

	if (shorts[1] == "No Shortcuts Available") then
		shortsstring = "No Shortcuts Available"
	else
		shortsstring = table.concat(shorts, "\r\n\r\n")
	end
	
	SKIN:Bang("!SetOption", "shortcuts", "Text", shortsstring)
end

function split(str)
	t = { }

	for i in string.gmatch(str, "([^,]+),?") do
		table.insert(t, i)
	end

	return t
end

function splitDot(str)
	t = { }

	for i in string.gmatch(str, "([^.]+)") do
		table.insert(t, i)
	end

	return t
end