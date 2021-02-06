local DataStoreService = game:GetService("DataStoreService")
local PlayerData = DataStoreService:GetDataStore("PlayerData")

local defaultdatatable = {
	UniqueTwrs = 0,
	ResetTime = 1,
}

local function GetData(player)

	local success, data = pcall(function()
		return PlayerData:GetAsync(player.UserId)
	end)
	
	local towers = Instance.new("NumberValue")
	towers.Name = "towers"
	towers.Value = 0
	towers.Parent = player
	
	if success then
		if data == nil then
			PlayerData:SetAsync(player.UserId, defaultdatatable)
			print("player is new! setting async to default values")
			towers.Value = 0
		else
			towers.Value = data["UniqueTwrs"]
			for k,v in pairs(defaultdatatable) do -- look to see if player is missing any default values
				local tosave = data
				if data[k] == nil then
					tosave[k] = v
				end
			end
		end
	else 
		error(data)
	end

	game.ReplicatedStorage.DataDone:FireAllClients()
end

game.Players.PlayerAdded:Connect(GetData)