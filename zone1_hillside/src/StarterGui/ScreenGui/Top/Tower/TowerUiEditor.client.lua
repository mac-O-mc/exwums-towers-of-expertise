local index = require(game.ReplicatedStorage.TowerDifficulties)

local function SiftTowerType(val)
	local sift = string.sub(val,1,1)
	if sift == "T" then
		script.Parent.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	elseif sift == "C" then
		script.Parent.TextStrokeColor3 = Color3.fromRGB(86, 36, 36)
	elseif sift == "S" then
		script.Parent.TextStrokeColor3 = Color3.fromRGB(33, 59, 86)
	elseif sift == "M" then
		script.Parent.TextStrokeColor3 = Color3.fromRGB(79, 51, 12)
	end
end
game.Players.LocalPlayer.CurrentTower:GetPropertyChangedSignal("Value"):Connect(function()
	if game.Players.LocalPlayer.CurrentTower.Value == "" then
		script.Parent.Visible = false
		script.Parent.Parent.BackgroundColor3 = Color3.fromRGB(134, 134, 134) -- default
	else
		script.Parent.Visible = true
		script.Parent.Text = game.Players.LocalPlayer.CurrentTower.Value
		SiftTowerType(script.Parent.Text)
		script.Parent.Parent.BackgroundColor3 = index[game.workspace.Towers[game.Players.LocalPlayer.CurrentTower.Value].Difficulty.Value]
	end
end)