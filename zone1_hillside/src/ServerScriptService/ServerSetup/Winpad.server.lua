local DataStoreService = game:GetService("DataStoreService")
local PlayerData = DataStoreService:GetDataStore("PlayerData")

local HttpService = game:GetService("HttpService")

local ROOT_SCRIPT = game:GetService("ServerScriptService").ServerSetup.Winpad
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
local avatartable = {
	Easy = "https://cdn.discordapp.com/emojis/810747059363774475.png",
	Moderate = "https://cdn.discordapp.com/emojis/810747075120857092.png",
	Hard = "https://cdn.discordapp.com/emojis/810747092854374401.png",
	Difficult = "https://cdn.discordapp.com/emojis/810747106431991828.png",
	Challenging = "https://cdn.discordapp.com/emojis/810747116628213801.png",
	Intense = "https://cdn.discordapp.com/emojis/810747131585101834.png",
	Remorseless = "https://cdn.discordapp.com/emojis/810747141068161024.png",
	Insane = "https://cdn.discordapp.com/emojis/810747159381016617.png",
	Extreme = "https://cdn.discordapp.com/emojis/810747173267832892.png",
	Maniacal = "https://cdn.discordapp.com/emojis/810747185934893117.png",
	Cataclysmic = "https://cdn.discordapp.com/emojis/810747197691789332.png"
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
		local twrname = script.Parent.Parent.Name
		if plr.CurrentTower.Value == twrname and debounce == false then -- plr.AmtCheckpoints.Value == AmountOfCheckpoints
			debounce = true
			plr.CurrentTower.Value = ""
			--{} APPLY ROOTSCRIPT ATTRIBUTES {}--
			if ROOT_SCRIPT:GetAttribute("LastWonTowerName") == nil then
				ROOT_SCRIPT:SetAttribute("LastWonTowerName", twrname)
			elseif ROOT_SCRIPT:GetAttribute("LastWonTowerName") == twrname then
				if ROOT_SCRIPT:GetAttribute("SameWonTowerCount") == nil then
					ROOT_SCRIPT:SetAttribute("SameWonTowerCount", 1)
				else
					ROOT_SCRIPT:SetAttribute("SameWonTowerCount", ROOT_SCRIPT:GetAttribute("SameWonTowerCount")+1)
				end
			else
				ROOT_SCRIPT:SetAttribute("SameWonTowerCount", 0)
			end
			--{} ANNOUNCEMENT EDITS {}-- 
			local exc = "!"
			local win_verb = "beaten"
			local Difficulty = script.Parent.Parent.Difficulty
			-- These difficulties don't seem to exist yet, do we still them tho?
			if Difficulty == "Insane" or Difficulty == "Extreme" or Difficulty == "Maniacal" or Difficulty == "Cataclysmic" then
				exc:rep(3) -- identical to string.rep(exc, 3). ":" is just a shortcut :o
				win_verb = "conquered"
			elseif sig == true then
				exc:rep(3)
				win_verb = "defeated"
			elseif Difficulty == "Remorseless" or Difficulty == "Intense" then
				exc:rep(2)
			end
			--{==} GAMECHAT {==}--
			local clock = game.ReplicatedStorage.InvokeClockInformation:InvokeClient(plr)
			local param = {
				Text = "[SYSTEM]: ["..plr.Name.."] has "..win_verb.." "..twrname.." ("..script.Parent.Parent.TwrName.Value..")".." in "..clock..exc,
				Color = TowerDifficulties[Difficulty.Value],
			}
			game.ReplicatedStorage.SystemMessage:FireAllClients(param)
			--{==} DISCORD {==}--
			---- Switching webhook depending on the cases
			local webhook = "invalid"
			if sc == true then
				webhook = "invalid"
			elseif sig == true then
				webhook = "invalid"
			end
			local httpData = ("🏁 **"..plr.Name.."** has "..win_verb.." **"..twrname.." [**"..emojitable[Difficulty.Value].."**]** in `"..clock.."`"..exc)
			-- The Big Funny Message
			local discordAvatar = avatartable[Difficulty.Value]
			local FLAIR_prefix = ""
			local FLAIR_postfix = ""
			if ROOT_SCRIPT:GetAttribute("SameWonTowerCount") > 5 then
				FLAIR_prefix = "[RUN] "
				FLAIR_postfix = " [RUN]"
				discordAvatar = "https://cdn.discordapp.com/emojis/815426650904854528.png"
			elseif ROOT_SCRIPT:GetAttribute("SameWonTowerCount") > 0 then
				FLAIR_postfix = ROOT_SCRIPT:GetAttribute("SameWonTowerCount")
			end
			local tabledata = {
				["content"] = httpData,
				
				["avatar_url"] = discordAvatar,
				["username"] = FLAIR_prefix..script.Parent.Parent.TwrName.Value..FLAIR_postfix
			}
			tabledata = HttpService:JSONEncode(tabledata)
			HttpService:PostAsync(webhook, tabledata)
			local tableforsave = {}
			local success, data = pcall(function()
				return PlayerData:GetAsync(plr.UserId)
			end)

			if success then
				tableforsave = data
				if tableforsave[twrname] == nil or tableforsave[twrname] == false then
					tableforsave[twrname] = true
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
			
			game.ReplicatedStorage.UnloadTower:FireClient(plr, twrname)
			game.ReplicatedStorage.ClientDataTransfer:FireClient(plr, {twrname})
			
			if script.Parent.Parent:FindFirstChild("Winroom") then
				tch.Parent.Head.CFrame = script.Parent.Parent.Winroom.Landing.Cframe + Vector3.new(0,4,0)
			end
			plr.RespawnLocation = workspace.SpawnLocation
			tch.Parent.Head.CFrame = workspace.SpawnLocation.CFrame + Vector3.new(0, 4, 0)
	--[[	if plr.TowerFolder[twrname].Value == false then
				plr.TowerFolder[twrname].Value = true
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