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

local emojitable = {
	Easy = "<:Easy:810747059363774475>",
	Moderate = "<:Moderate:810747075120857092>",
	Hard = "<:Hard:810747092854374401>",
	Difficult = "<:Difficult:810747106431991828>",
	Challenging = "<:Challenging:810747116628213801>",
	Intense = "<:Intense:810747131585101834>",
	Remorseless = "<:Remorseless:810747141068161024>",
	Insane = "<:Insane:810747159381016617>",
	Extreme = "<:Extreme:810747173267832892>",
	Maniacal = "<:Maniacal:810747185934893117>",
	Cataclysmic = "<:Cataclysmic:810747197691789332>"
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

			local webhook = "https://discordapp.com/api/webhooks/89417889138029914/il62xdn-i7j3_wiwipnic2ufzxc3ahi4_vxtoc3agjjics9cglcqrcswv38wdynat15f"
			if sc == true then
				webhook = "https://discord.com/api/webhooks/890891382061966926/ropoeprhgoktndytwylngpeby8pfwoxvckfuu0ewkdxrad1krmt10gg84sqfziabjiss"
			elseif sig == true then
				webhook = "https://discord.com/api/webhooks/808926812196306996/qa0g3wneb9f8yuhvjcx5wawikllp9dqhsd3hkdw-cmlitvz6qdbzjiybedhto-vwzm5c"
			end
			local httpData = ("**"..plr.Name.."** has "..msg.." **"..script.Parent.Parent.TwrName.Value.." [**"..emojitable[script.Parent.Parent.Difficulty.Value].."**]** in `"..clock.."`"..ex)
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
						plr.leaderstats.Spires.Value += 1
					elseif sig == true then
						plr.leaderstats.Towers.Value += 2
					else
						plr.leaderstats.Towers.Value += 1
					end
					PlayerData:SetAsync(plr.UserId, tableforsave)
				end
			else
				error(data)
			end
			
			game.ReplicatedStorage.UnloadTower:FireClient(plr, script.Parent.Parent.Name)
			game.ReplicatedStorage.ClientDataTransfer:FireClient(plr, {script.Parent.Parent.Name})
			
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