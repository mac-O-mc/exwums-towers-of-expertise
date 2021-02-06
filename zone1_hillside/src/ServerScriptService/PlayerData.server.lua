local DataStoreService = game:GetService("DataStoreService")
local MainStore = DataStoreService:GetDataStore("PlayerMain")

local playerdata = {}

local function WriteData(player)
	MainStore:SetAsync(player.UserId, playerdata[player.UserId])
end

local function GetData(player)
	local key = player.UserId
	local ls = Instance.new("Folder")
	ls.Parent = player
	ls.Name = "leaderstats"
	local total = Instance.new("NumberValue")
	total.Parent = ls
	total.Name = "Towers"
	total.Value = 0

	local y, net = pcall(function()
		return MainStore:GetAsync(key) -- gather player data from main
	end)

	if y then
		if net then
			total.Value = net["PlayerTowers"]
			playerdata[player.UserId]["Towers"] = net["PlayerTowers"]
		else
			playerdata[player.UserId] = {
				Towers = 0
			}
		end
	else
		local peram = {
			Text = "The server was unable to load your data. Please be cautious while playing in this server as your data will not be saved.",
			Color = Color3.fromRGB(255, 0, 0)
		}
		game.ReplicatedStorage.SystemMessage:FireClient(player,peram)
		local check = Instance.new("BoolValue")
		check.Name = "PlrNoSave"
		check.Parent = player
	end
end

game.Players.PlayerAdded:Connect(GetData)
game.Players.PlayerRemoving:Connect(WriteData)