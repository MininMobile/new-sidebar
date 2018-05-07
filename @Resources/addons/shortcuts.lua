function Initialize()
	shortvar = SKIN:GetVariable("shortcuts") -- shortcuts=a.b,c.d,e.f
	shorts = split(shortvar)
	shortsstring = ""

	if (shorts[1] == "No Shortcuts Available") then
		shortsstring = "No Shortcuts Available"
	else
		for _, i in pairs(shorts) do
			namepath = splitEx(i)

			shortsstring = shortsstring .. namepath[1] .. "; " .. namepath[2] .. "\r\n\r\n"
		end
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

function splitEx(str)
	t = { }

	for i in string.gmatch(str, "([^!]+)") do
		table.insert(t, i)
	end

	return t
end