function Initialize()
	shortvar = SKIN:GetVariable("shortcuts")
	shorts = split(shortvar)
	shortsstring = ""

	for _=1,24 do
		if (shorts[_] ~= nil) then
			if (shorts[_] == "No Shortcuts Available") then
				hideButton(_)
			else
				namepath = splitEx(shorts[_])

				shortsstring = shortsstring .. namepath[1] .. "\r\n\r\n"

				SKIN:Bang("!SetOption", "buttons-" .. _, "LeftMouseUpAction", '"' .. namepath[2] .. '"')
			end
		else
			hideButton(_);
		end
	end

	if (shorts[1] == "No Shortcuts Available") then
		shortsstring = "No Shortcuts Available"
	end
	
	SKIN:Bang("!SetOption", "shortcuts", "Text", shortsstring)
end

function hideButton(i)
	SKIN:Bang("!SetOption", "buttons-" .. i, "Shape", "Rectangle 0,0,0,0")
	SKIN:Bang("!SetOption", "buttons-" .. i, "MouseOverAction", "")
	SKIN:Bang("!SetOption", "buttons-" .. i, "MouseLeaveAction", "")
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