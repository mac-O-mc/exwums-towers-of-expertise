local ts = game:GetService("TweenService")
local ts1 = TweenInfo.new(1)
local p = game.Players.LocalPlayer
local b = script.parent.Button
local buttonplrs
local buttonboxes

local function Deactivate()
	b.Material = Enum.Material.Metal
	b.Activated.Value = false
	for i,v in pairs(b.Parent:GetChildren()) do
		if v.Name ~= "Button" then
			if v:FindFirstChild("Fadeout") then
				local tween = ts:Create(v,ts1,{Transparency = 0})
				tween:Play()
				v.CanCollide = true
			elseif v:FindFirstChild("Fadein") then
				local tween = ts:Create(v,ts1,{Transparency = 0.5})
				tween:Play()
				v.CanCollide = false
			end
		end
	end
end

local function Button(button)
	-- DEFAULT FUNCTION
	for i,v in pairs(button.Parent:GetChildren()) do
		if v.Name ~= "Button" then
			if v:FindFirstChild("Fadeout") then
				local tween = ts:Create(v,ts1,{Transparency = 0.5})
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
	if button:FindFirstChild("Timer") and button.Timer.Value ~= 0 then
		local s = button.Press:Clone()
		s.Name = "Tick"
		s.SoundId = "rbxassetid://12221944"
		s.Parent = button
		local y = button.Press:Clone()
		y.Name = "Revert"
		y.Volume = 0
		y.SoundId = "rbxassetid://12222152"
		y.Parent = button

		local timer = p.PlayerGui.ScreenGui.ButtonTimerFrame.Template.TextLabel:Clone()
		timer.Parent = p.PlayerGui.ScreenGui.ButtonTimerFrame
		timer.Text = tostring(button.Timer.Value)
		timer.TextColor3 = button.Color
		local red = (button.Color.r-1)/-1
		local green = (button.Color.g-1)/-1
		local blue = (button.Color.b-1)/-1
		timer.TextStrokeColor3 = Color3.new(red,green,blue)
		timer.Name = button.BrickColor.Name
		timer.TextTransparency = 0

		for i = button.Timer.Value,1,-1 do
			timer.Text = i
			s:Play()
			wait(1)
		end
		y.Volume = 1
		y:Play()
		timer:Destroy()
		Deactivate()
	end
end
local LocalHandler = {}
function LocalHandler.Handle()
	b.Touched:Connect(function(touc)
		if b:FindFirstChild("SupportPlayers") then
			buttonplrs = b.SupportPlayers.Value
		else
			buttonplrs = true
		end
		if b:FindFirstChild("SupportPushboxes") then
			buttonboxes = b.SupportPushboxes.Value
		else
			buttonboxes = false
		end
		if b.Activated.Value == false and touc.parent.Name == p.Name and buttonplrs == true then
			b.Material = Enum.Material.Neon
			b.Press:Play()
			b.Activated.Value = true
			Button(b)
		elseif b.Activated.Value == false and touc.Name == "Pushbox" and buttonboxes == true and touc.BrickColor.Name == b.BrickColor.Name then
			b.Material = Enum.Material.Neon
			b.Press:Play()
			b.Activated.Value = true
			Button(b)
		end
	end)
	if script.Parent:FindFirstChild("Deactivator") then
		script.Parent.Deactivator.Touched:Connect(function(touc)
			if b.Activated.Value == true and touc.parent.Name == p.Name then
				Deactivate()
			end
		end)
	end
end
return LocalHandler