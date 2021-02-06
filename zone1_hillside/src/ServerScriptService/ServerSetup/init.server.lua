for i,v in pairs(game.Workspace.Towers:GetChildren()) do
	if v:FindFirstChild("Winpad") then
		local s = script.Winpad:Clone()
		s.Disabled = false
		s.Parent = v.Winpad
		print(v.Name.." winpad loaded")
	end
end
for i,v in pairs(game.Workspace.Portals:GetChildren()) do
	if v:FindFirstChild("Portal") then
		local s = script.TowerLoad:Clone()
		s.Disabled = false
		s.Parent = v.Portal
		print(v.Name.." portal loaded")
	end
end