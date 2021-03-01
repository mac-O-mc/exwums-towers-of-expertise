local db = false

script.Parent.Touched:Connect(function(int)
	if int.Parent:FindFirstChild("Humanoid") and db == false and not script.Parent.Parent:FindFirstChild("Disabled") then
		db = true
		local plr = game.Players:GetPlayerFromCharacter(int.Parent)
		game.ReplicatedStorage.RequestTower:FireClient(plr, script.Parent.Tower.Value)
		game.ServerStorage.Bindables.TowerRequested:Fire(plr, script.Parent.Tower.Value)
		plr.CurrentTower.Value = script.Parent.Tower.Value
		int.Parent.Head.CFrame = workspace.Towers[script.Parent.Tower.Value].Spawn.CFrame + Vector3.new(0, 4, 0)
		plr.RespawnLocation = workspace.Towers[script.Parent.Tower.Value].Spawn
		wait(3)
		db = false
	end
end)