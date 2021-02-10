local ts = game:GetService("TweenService")
local ts1 = TweenInfo.new(1)
local p = game.Players.LocalPlayer
local timerui = p.PlayerGui.ScreenGui.ButtonTimerFrame

local function Button(button)
	-- DEFAULT FUNCTION
	for i,v in pairs(button.Parent:GetChildren()) do
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
	-- TIMER FUNCTION
	if button:FindFirstChild("Timer") then
		local s = button.Press:Clone()
		s.Name = "Tick"
		s.SoundId = "rbxassetid://12221944"
		local y = button.Press:Clone()
		y.Name = "Revert"
		y.SoundId = "rbxassetid://12222152"
		
		local timer = timerui.Template.TextLabel:Clone()
		timer.Parent = timerui
		timer.Text = tostring(button.Timer.Value)
		timer.TextColor3 = button.Color
		timer.TextStrokeColor3 = Color3.fromRGB((button.Color.r-255)/-1,(button.Color.g-255)/-1,(button.Color.b-255)/-1)
		timer.Name = button.BrickColor.Name
		timer.TextTransparency = 0
		
		for i = button.Timer.Value,1,-1 do
			timer.Text = i
			s:Play()
			wait(1)
		end
		y:Play()
		timer:Destroy()
		button.Material = Enum.Material.Metal
		button.Activated.Value = false
		for i,v in pairs(button.Parent:GetChildren()) do
			if v.Name ~= "Button" then
				if v:FindFirstChild("Fadeout") then
					local tween = ts:Create(v,ts1,{Transparency = 0})
					tween:Play()
					v.CanCollide = false
				elseif v:FindFirstChild("Fadein") then
					local tween = ts:Create(v,ts1,{Transparency = 1})
					tween:Play()
					v.CanCollide = true
				end
			end
		end
	end
end

script.Parent:WaitForChild("Humanoid").Touched:connect(function(touch,opp)
	if touch.Name == "Hurt" then
		if script.Parent.Humanoid.Health > 0 then
			game.ReplicatedStorage.DamageEvent:FireServer(touch.dmg.Value)
		end
	elseif touch.Name == "Button" and touch.Activated.Value == false then
		touch.Material = Enum.Material.Neon
		touch.Press:Play()
		touch.Activated.Value = true
		Button(touch)
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