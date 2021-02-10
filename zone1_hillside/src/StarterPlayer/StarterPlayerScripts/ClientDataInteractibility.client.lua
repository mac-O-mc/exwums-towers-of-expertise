game.ReplicatedStorage.ClientDataTransfer.OnClientEvent:Connect(function(tabl)
	for i,v in pairs(tabl) do
		game.workspace["Difficulty Chart"][v].Line.BrickColor = BrickColor.new("Lime green")
		game.Workspace.Portals[v.." Portal"].Type.SurfaceGui.TextLabel.TextColor3 = Color3.fromRGB(85, 255, 0)
		game.Workspace.Portals[v.." Portal"].Title.SurfaceGui.TextLabel.TextColor3 = Color3.fromRGB(85, 255, 0)
	end
end)