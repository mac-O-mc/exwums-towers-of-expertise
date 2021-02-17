local ts = game:GetService("TweenService")
local ts1 = TweenInfo.new(5)
local p = game.Players.LocalPlayer
local lighting = game:GetService("Lighting")

local s = Instance.new("Sound")
s.Name = "ClientSound"
s.Parent = workspace
s.SoundId = "rbxassetid://12222030"

local defaults = {
	Ambient = lighting.Ambient,
	Brightness = lighting.Brightness,
	ClockTime = lighting.ClockTime,
	FogColor = lighting.FogColor,
	FogEnd = lighting.FogEnd,
	FogStart = lighting.FogStart,
	OutdoorAmbient = lighting.OutdoorAmbient,
}

script.Parent:WaitForChild("Humanoid").Touched:connect(function(touch,opp)
	if touch.Name == "Hurt" then
		if script.Parent.Humanoid.Health > 0 then
			game.ReplicatedStorage.DamageEvent:FireServer(touch.dmg.Value or 5)
		end
	elseif touch.Name == "Entry" and touch.Parent.Name == "Teleporter" then
		game.ReplicatedStorage.TeleportEvent:FireServer(touch.Parent.Goal.CFrame)
		if game.Workspace:FindFirstChild("ClientSound") then
			if touch.Parent:FindFirstChild("SoundId") and touch.Parent.SoundId.Value ~= "rbxassetid://12222030" then
				s.SoundId = "rbxassetid://"..tostring(touch.Parent.SoundId.Value)
			elseif s.SoundId ~= "rbxassetid://12222030" then
				s.SoundId = "rbxassetid://12222030"
			end
			s:Play()
		end
	elseif touch.Name == "LightingChanger" then
		if touch.RevertToDefault.Value == true then
			local tween = ts:Create(lighting,ts1,defaults)
			tween:Play()
		else
			for i,v in pairs(touch.Configuration:GetChildren()) do
				local tween = ts:Create(lighting,ts1,{[v.Name] = v.Value})
				tween:Play()
			end
		end
	end
end)