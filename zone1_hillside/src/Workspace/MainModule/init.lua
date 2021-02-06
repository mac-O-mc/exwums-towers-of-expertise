return function(mainf, config)
	local scr = script.NewMusicScript
	if config then config:Clone().Parent = scr end
	scr.Parent = game.StarterPlayer.StarterPlayerScripts
	for _, p in pairs(game.Players:GetPlayers()) do --for the times that the player loads in after this script, like in studio
		local sg = Instance.new("SurfaceGui")
		sg.Name = "MusicScriptGui"
		sg.ResetOnSpawn = false
		scr:Clone().Parent = sg
		sg.Parent = p.PlayerGui
	end
	
	local zones = mainf:FindFirstChild"BackgroundMusicZones" or Instance.new("Folder", mainf)
	zones.Name = "BackgroundMusicZones"
	local glob = mainf:FindFirstChild"GlobalBackgroundMusic" or Instance.new("Folder", mainf)
	glob.Name = "GlobalBackgroundMusic"
	
	local musf = Instance.new("Folder")
	musf.Name = "Background Music"
	
	zones.Parent = musf
	glob.Parent = musf
	
	for _, s in pairs(musf:GetDescendants()) do
		if s:IsA"Sound" then
			s.Looped = true
			local nv = Instance.new("NumberValue")
			nv.Name = "OriginalVolume"
			nv.Value = s.Volume
			nv.Parent = s
		end
	end
	
	musf.Parent = game.ReplicatedStorage
end