game.Players.PlayerAdded:Connect(function(plr)
	plr.RespawnLocation = game.Workspace.SpawnLocation
	local function ValCreate(name,valtype,parent,val)
		local ins = Instance.new(valtype)
		ins.Name = name
		ins.Parent = parent
		ins.Value = val
	end
	-- Essential Strings
	ValCreate("CurrentTower","StringValue",plr,"")
	ValCreate("AmtCheckpoints","StringValue",plr,0)
	-- Data Strings
	local twrfldr = Instance.new("Folder")
	twrfldr.Name = "TowerFolder"
	twrfldr.Parent = plr
	ValCreate("ToBA","BoolValue",twrfldr,false)
	ValCreate("ToS","BoolValue",twrfldr,false)
	ValCreate("ToH","BoolValue",twrfldr,false)
	ValCreate("ToSE","BoolValue",twrfldr,false)
	ValCreate("SoCO","BoolValue",twrfldr,false)
	ValCreate("ToM","BoolValue",twrfldr,false)
	ValCreate("ToFL","BoolValue",twrfldr,false)
	--- Player Settings
	ValCreate("ResetTime","NumberValue",plr,1)
end)