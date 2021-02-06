game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		local hum = char:WaitForChild("Humanoid")
		hum.Died:Connect(function()
			if plr.CurrentTower ~= "" then
				game.ReplicatedStorage.UnloadTower:FireClient(plr, plr.CurrentTower.Value)
				plr.CurrentTower.Value = ""
				plr.RespawnLocation = workspace.SpawnLocation
			end
		end)
	end)
end)
		