script.Parent.Touched:Connect(function(int)
	if int.Parent.Humanoid == true then
		local plr = game.Players:GetPlayerFromCharacter(int.Parent)
		game.ReplicatedStorage.RequestTower:FireClient(plr, script.Parent.Tower.Value)
		plr.CurrentTower.Value = script.Parent.Tower.Value
		int.Parent.HumanoidRootPart.Position = CFrame.new(workspace.Towers[script.Parent.Tower.Value].Spawn.Position)
	end
end)