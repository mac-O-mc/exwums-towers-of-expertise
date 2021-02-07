local DataStoreService = game:GetService("DataStoreService")
local PlayerData = DataStoreService:GetDataStore("PlayerData")

local defaultdatatable = {
	UniqueTwrs = 0,
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
			print("player is returning!")
			towers.Value = data["UniqueTwrs"]
			--[[ maybe later i'll need this but i decided that i don't need a ResetTimer default i can just get the zone to create one of the player wants to change it
			for k,v in pairs(defaultdatatable) do -- look to see if player is missing any default values
				local tosave = data
				if data[k] == nil then
					print("player does not have "..k.." as a valid value! setting async to default key")
					tosave[k] = v
					wait(1)
				end
				PlayerData:SetAsync(player.UserId, tosave)
			end
			]]--
		end
	else 
		error(data)
	end

	game.ReplicatedStorage.DataDone:FireAllClients()
end

game.Players.PlayerAdded:Connect(GetData)