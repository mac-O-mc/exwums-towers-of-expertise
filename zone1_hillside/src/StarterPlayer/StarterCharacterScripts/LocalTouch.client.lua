local ts = game:GetService("TweenService")
local ts1 = TweenInfo.new(1)
local p = game.Players.LocalPlayer
script.Parent:WaitForChild("Humanoid").Touched:connect(function(touch,opp)
	if touch.Name == "Hurt" then
		if script.Parent.Humanoid.Health > 0 then
			game.ReplicatedStorage.DamageEvent:FireServer(touch.dmg.Value)
		end
	elseif touch.Name == "Button" and touch.Activated.Value == false then
		touch.Material = Enum.Material.Neon
		touch.Press:Play()
		touch.Activated.Value = true
		for i,v in pairs(touch.Parent:GetChildren()) do
			if v.Name ~= "Button" then
				if v:FindFirstChild("Fadeout") then
					local tween = ts:Create(v,ts1,{Transparency = 1})
					tween:Play()
					v.CanCollide = false
				elseif v:FindFirstChild("Fadein") then
					local tween = ts:Create(v,ts1,{Transparency = 0})
					tween:Play()
					v.CanCollide = true
				end
			end
		end
	elseif touch.Name == "Entry" and touch.Parent.Name == "Teleporter" then
		game.ReplicatedStorage.TeleportEvent:FireServer(touch.Parent.Goal.CFrame)
		if game.Workspace:FindFirstChild("ClientSound") then
			local s = game.Workspace.ClientSound
			if s.SoundId ~= "rbxassetid://12222030" then
				s.SoundId = "rbxassetid://12222030"
			end
			s:Play()
		end
	end

end)