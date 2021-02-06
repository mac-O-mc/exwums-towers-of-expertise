local index = require(game.ReplicatedStorage.TowerDifficulties)
-- script.Parent.Parent.BackgroundColor3 = index[game.workspace.Towers[game.Players.LocalPlayer.CurrentTower.Value].Difficulty.Value]
local frame = script.Parent.Parent.Parent.Parent.SpectateFrame
local uis = game:GetService("UserInputService")
local cam = workspace.CurrentCamera
local current
local playerList = {}

local function updatePlayerList(removed)
	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= removed and not table.find(playerList,v) then
			table.insert(playerList, v)
		elseif v == removed then
			table.remove(playerList, v)
		end
	end
end

local function camera(player)
	frame.PlayerName.Text = tostring(player)
	if player.CurrentTower.Value == "" then
		frame.TextLabel.Text = ""
		frame.PlayerName.BackgroundColor3 = Color3.fromRGB(134, 134, 134)
		frame.PlayerName.LeftButton.TextColor3 = Color3.fromRGB(134, 134, 134)
		frame.PlayerName.RightButton.TextColor3 = Color3.fromRGB(134, 134, 134)
	else
		frame.TextLabel.Text = player.CurrentTower.Value
		frame.PlayerName.BackgroundColor3 = index[game.workspace.Towers[player.CurrentTower.Value].Difficulty.Value]
		frame.PlayerName.LeftButton.TextColor3 = index[game.workspace.Towers[player.CurrentTower.Value].Difficulty.Value]
		frame.PlayerName.RightButton.TextColor3 = index[game.workspace.Towers[player.CurrentTower.Value].Difficulty.Value]
	end
	cam.CameraSubject = player.Character
end

updatePlayerList()
game.Players.PlayerAdded:Connect(function()
	updatePlayerList()
end)
game.Players.PlayerRemoving:Connect(function(player)
	updatePlayerList(player)
end)

frame.parent.SideFrame.MenuButton.SpectateButton.MouseButton1Click:Connect(function()
	if frame.Visible == false then
		frame.Visible = true
		current = 1 
		camera(playerList[1])
	else
		frame.Visible = false
		camera(game.Players.LocalPlayer)
	end
end)

frame.PlayerName.LeftButton.MouseButton1Click:Connect(function()
	current = current - 1
	if current < 1 then
		current = #playerList
	end
	camera(playerList[current])
end)

frame.PlayerName.RightButton.MouseButton1Click:Connect(function()
	current = current + 1
	if current > #playerList then
		current = 1
	end
	camera(playerList[current])
end)

uis.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard and frame.Visible == true then
		local KeyPressed = input.KeyCode
		if KeyPressed == Enum.KeyCode.Q then
			current = current - 1
			if current < 1 then
				current = #playerList
			end
			camera(playerList[current])
		elseif KeyPressed == Enum.KeyCode.E then
			current = current + 1
			if current > #playerList then
				current = 1
			end
			camera(playerList[current])
		end
	end
end)