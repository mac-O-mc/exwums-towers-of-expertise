local db = false

script.Parent.Touched:Connect(function(int)
	if int.Parent:FindFirstChild("Humanoid") and db == false then
		db = true
		local plr = game.Players:GetPlayerFromCharacter(int.Parent)
		game.ReplicatedStorage.RequestTower:FireClient(plr, script.Parent.Tower.Value)
		plr.CurrentTower.Value = script.Parent.Tower.Value
	--	int.Parent:moveTo(workspace.Towers[script.Parent.Tower.Value].Spawn.Position)
	--	plr.RespawnLocation = workspace.Towers[script.Parent.Tower.Value].Spawn
		
	--	int.Parent:moveTo(workspace[script.Parent.Tower.Value.."Spawn"].Position)
	--	plr.RespawnLocation = workspace[script.Parent.Tower.Value.."Spawn"]
	--	workspace[script.Parent.Tower.Value.."Spawn"].Enabled = true
		
		int.Parent.Head.CFrame = workspace.Towers[script.Parent.Tower.Value].Spawn.CFrame + Vector3.new(0, 4, 0)
		plr.RespawnLocation = workspace.Towers[script.Parent.Tower.Value].Spawn
		wait(5)
		db = false
	end
end)