--[[
	Purpose: See if the towers have their own portal.
--]]
-- yea its unfinished, fortunately with another lovely dev we can take turn, or I can spare it for tomorrow

local module = {}
-- 
function module.ValidateTowerPortals(reversed)
	local _TOWERS = workspace["Towers"]
	local _PORTALS = workspace["Portals"]

	local PORTALS_NAMES = {}
	local TOWERS_NAMES = {}

	local fromtable = nil
	local totable = nil
	local checktable = TOWERS_NAMES
	if reversed then
		checktable = PORTALS_NAMES
	end
	
	for i = 1, 2 do
		if i == 1 then
			fromtable = _PORTALS:GetChildren()
			totable = PORTALS_NAMES
		else
			fromtable = _TOWERS:GetChildren()
			totable = TOWERS_NAMES
		end
		
		table.foreach(fromtable, function(idx, val)
			if i == 1 then
				if val.ClassName ~= "Model" then
					return
				end
				table.insert(totable, #totable+1, string.split(val.Name, "")[1]) -- In Lua it starts at 1, not 0
			else
				if val.ClassName ~= "Model" then
					return
				end
				table.insert(totable, #totable+1, val.Name) -- In Lua it starts at 1, not 0
			end
		end)
	end
	local gotillegal = false
	-- "array" so we use ipairs
	for idx, val in ipairs(checktable) do
		if table.find(totable, val, idx) == nil then
			warn("ValidateTowerPortals got NIL for "..val)
			print("reversed setting was "..reversed)
			gotillegal = true
		end 
	end
	if not gotillegal then
		print("Towers are fine")
		return true
	else
		return false
	end	
end

--function module.ValidateTowers()
--	local _DIFFICULTYCHART = workspace["Difficulty Chart"]
--	-- These are folders
--	local _PORTALS = workspace["Portals"]
--	local _TOWERS = workspace["Towers"]

--	local DIFFICULTYCHART_NAMES = {}
--	local PORTALS_NAMES = {}
--	local TOWERS_NAMES = {}

--	local fromtable = nil
--	local totable = nil
--	-- Assign all model names
--	for i = 1, 3 do
--		if i == 1 then
--			fromtable = _DIFFICULTYCHART:GetChildren()
--			totable = DIFFICULTYCHART_NAMES
--		elseif i == 2 then
--			fromtable = _PORTALS:GetChildren()
--			totable = PORTALS_NAMES
--		else
--			fromtable = _TOWERS:GetChildren()
--			totable = TOWERS_NAMES
--		end

--		table.foreach(fromtable, function(idx, val)
--			if i == 2 then
--				if val.Name == "Difficulties" or val.ClassName ~= "Model" then
--					return
--				end
--				table.insert(totable, #totable+1, string.split(val.Name, "")[1]) -- In Lua it starts at 1, not 0
--			else
--				if val.Name == "Difficulties" or val.ClassName ~= "Model" then
--					return
--				end
--				table.insert(totable, #totable+1, val.Name) -- In Lua it starts at 1, not 0
--			end
--		end)
--	end
--	-- "array" so we use ipairs
--	for idx, val in ipairs(TOWERS_NAMES) do
--		table.find()
--	end
--end

return module