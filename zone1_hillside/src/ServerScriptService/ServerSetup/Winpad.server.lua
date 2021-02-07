local DataStoreService = game:GetService("DataStoreService")
local PlayerData = DataStoreService:GetDataStore("PlayerData")

local HttpService = game:GetService("HttpService")

local sc = script.Parent.Parent.SoulCrushing.Value
local sig = script.Parent.Parent.Signifigant.Value

local debounce = false

local Materials = Enum.Material:GetEnumItems()
local IgnoreMaterials = {
	Enum.Material.Air; Enum.Material.Water;
	Enum.Material.Rock; Enum.Material.Asphalt;
	Enum.Material.Snow; Enum.Material.Glacier;
	Enum.Material.Sandstone; Enum.Material.Mud;
	Enum.Material.Basalt; Enum.Material.Ground;
	Enum.Material.CrackedLava; Enum.Material.Salt;
	Enum.Material.LeafyGrass; Enum.Material.Limestone;
	Enum.Material.Pavement; Enum.Material.ForceField
}

--[[
local TowerDifficulties = {
	Easy = Color3.fromRGB(76, 255, 76),
	Moderate = Color3.fromRGB(255, 240, 64),
	Hard = Color3.fromRGB(255, 128, 0),
	Difficult = Color3.fromRGB(203, 27, 27),
	Challenging = Color3.fromRGB(117, 0, 0),
	Intense = Color3.fromRGB(35, 55, 70),
	Remoreless = Color3.fromRGB(200, 34, 255),
	Insane = Color3.fromRGB(0, 0, 209),
	Extreme = Color3.fromRGB(13, 105, 172),
	Terrifyiing = Color3.fromRGB(119, 174, 255),
	Cataclysmic = Color3.fromRGB(248, 248, 248)
}
]]--

local TowerDifficulties = require(game.ReplicatedStorage.TowerDifficulties)

for _, material in next, IgnoreMaterials do
	table.remove(Materials, table.find(Materials, material))
end


script.Parent.Touched:Connect(function(tch)
	if tch.Parent:FindFirstChild("Humanoid") then
		local plr = game.Players:GetPlayerFromCharacter(tch.Parent)
		if plr.CurrentTower.Value == script.Parent.Parent.Name and  debounce == false then -- plr.AmtCheckpoints.Value == AmountOfCheckpoints
			debounce = true
			local ex
			local msg = "beaten"
			if sc == true then
				ex = "!!!"
				msg = "conquered"
			elseif sig == true then
				ex = "!!!"
				msg = "defeated"
			elseif script.Parent.Parent.Difficulty == "Remoreless" or script.Parent.Parent.Difficulty == "Intense" then
				ex = "!!"
			else
				ex = "!"
			end
			plr.CurrentTower.Value = ""
			local clock = game.ReplicatedStorage.InvokeClockInformation:InvokeClient(plr)
			local peram = {
				Text = "[SYSTEM]: ["..plr.Name.."] has "..msg.." "..script.Parent.Parent.TwrName.Value.." in "..clock..ex,
				Color = TowerDifficulties[script.Parent.Parent.Difficulty.Value],
			}
			game.ReplicatedStorage.SystemMessage:FireAllClients(peram)

			local webhook = "https://discordapp.com/api/webhooks/798411924073087006/217jAVC_-TIcvG23lcJI8N3rilOF_HiDsQjiS3w39cfccXiXzyw6nAAtxd4Gc5WwInup"
			if sc == true then
				webhook = "https://discord.com/api/webhooks/802563683800186911/Gm9FwD6YEHqtECA8AiljhVPJqdkisDiwvZm5YwvdzBClwLb3k-U0x-9z3OHQd5TbhNwC"
			end
			local httpData = ("**"..plr.Name.."** has "..msg.." **"..script.Parent.Parent.TwrName.Value.." ["..script.Parent.Parent.Difficulty.Value.."]** in `"..clock.."`"..ex)
			local tabledata = {
				["content"] = httpData
			}
			tabledata = HttpService:JSONEncode(tabledata)
			HttpService:PostAsync(webhook, tabledata)
			local tableforsave = {}
			local success, data = pcall(function()
				return PlayerData:GetAsync(plr.UserId)
			end)

			if success then
				tableforsave = data
				if tableforsave[script.Parent.Parent.Name] == nil or tableforsave[script.Parent.Parent.Name] == false then
					tableforsave[script.Parent.Parent.Name] = true
					if script.Parent.Parent:FindFirstChild("Spire") then
						plr.leaderstats.Spire.Value += 1
					else
						plr.leaderstats.Towers.Value += 1
					end
					PlayerData:SetAsync(plr.UserId, tableforsave)
				end
			else
				error(data)
			end
			
			game.ReplicatedStorage.UnloadTower:FireClient(plr, script.Parent.Parent.Name)
			if script.Parent.Parent:FindFirstChild("Winroom") then
				tch.Parent.Head.CFrame = script.Parent.Parent.Winroom.Landing.Cframe + Vector3.new(0,4,0)
			end
			plr.RespawnLocation = workspace.SpawnLocation
			tch.Parent.Head.CFrame = workspace.SpawnLocation.CFrame + Vector3.new(0, 4, 0)
	--[[	if plr.TowerFolder[script.Parent.Parent.Name].Value == false then
				plr.TowerFolder[script.Parent.Parent.Name].Value = true
				plr.leaderstats.Towers.Value = plr.leaderstats.Towers.Value + 1
			end ]]
			wait(1)
			debounce = false
		end
	end
end)


while true do
	script.Parent.BrickColor = BrickColor.Random()
	script.Parent.Material = Materials[math.random(#Materials)]
	wait(0.2)
end