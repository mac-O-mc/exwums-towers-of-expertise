local LocalHandler = {}
function LocalHandler.Handle()
	script.Parent.Platform.BodyGyro.CFrame = script.Parent.Platform.CFrame
	script.Parent.Platform.BodyPosition.Position = script.Parent.Platform.Position
	script.Parent.Platform.Anchored = false
	while script.Parent do
		for i,v in pairs(script.Parent.Positions:GetChildren()) do
			script.Parent.Platform.BodyPosition.Position = v.Position
			wait(script.Parent:FindFirstChild("Delay") and script.Parent.Delay.Value or 5)
		end
	end
end
return LocalHandler