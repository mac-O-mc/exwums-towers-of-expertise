local DataStoreService = game:GetService("DataStoreService")
local PlayerData = DataStoreService:GetDataStore("PlayerData")
local ClientTransfer = game.ReplicatedStorage.ClientDataTransfer

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
	local ls = Instance.new("Folder")
	ls.Parent = plr
	ls.Name = "leaderstats"
	ValCreate("Towers","NumberValue",ls,0)
	ValCreate("Spires","NumberValue",ls,0)
	--- Player Settings
	local settng = Instance.new("Configuration")
	settng.Name = "PlrSettings"
	settng.Parent = plr
	ValCreate("ResetTime","NumberValue",settng,1)
	
	local success, data = pcall(function()
		return PlayerData:GetAsync(plr.UserId)
	end)

	if success then
		if data["ResetTime"] == nil then
			settng.ResetTime.Value = 1
		else
			settng.ResetTime.Value = data["ResetTime"]
		end
		if data["UniqueSpires"] == nil then
			ls.Spires.Value = 0
		else
			ls.Spires.Value = data["UniqueSpires"]
		end
		ls.Towers.Value = data["UniqueTwrs"]
		local alltw = {}
		for i,v in pairs(game.Workspace["Difficulty Chart"]:GetChildren()) do
			if data[v.Name] ~= nil then
				table.insert(alltw,v.Name)
			end
		end
		ClientTransfer:FireClient(plr, alltw)
	else
		error(data)
	end
	
end)

game.Players.PlayerRemoving:Connect(function(plr)
	local success, data = pcall(function()
		return PlayerData:GetAsync(plr.UserId)
	end)

	if success then
		local datasave = data
		datasave["ResetTime"] = plr.PlrSettings.ResetTime.Value
		datasave["UniqueTwrs"] = plr.leaderstats.Towers.Value
		datasave["UniqueSpires"] = plr.leaderstats.Spires.Value
		PlayerData:SetAsync(plr.UserId, datasave)
	else
		error(data)
	end
end)