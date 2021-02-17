-- winpad load
for i,v in pairs(game.Workspace.Towers:GetChildren()) do
	if v:FindFirstChild("Winpad") and not v.Winpad:FindFirstChild("Disabled") then
		local s = script.Winpad:Clone()
		s.Disabled = false
		s.Parent = v.Winpad
		print(v.Name.." winpad loaded")
	end
end

-- portal load
for i,v in pairs(game.Workspace.Portals:GetChildren()) do
	if v:FindFirstChild("Portal") then
		local s = script.TowerLoad:Clone()
		s.Disabled = false
		s.Parent = v.Portal
		print(v.Name.." portal loaded")
	end
end

-- client object load
for i,v in pairs(game.ReplicatedStorage.ClientSideParts:GetChildren()) do
	print(v.Name.." client object loading in progress")
	for i,v in pairs(v:GetChildren()) do
		if script.ClientObjectScripts:FindFirstChild(v.Name) then
			local cl = script.ClientObjectScripts[v.Name]:Clone()
			cl.Parent = v
			cl.Name = "LocalHandler"
		end
	end
	print(v.Name.." client object loading complete")
end