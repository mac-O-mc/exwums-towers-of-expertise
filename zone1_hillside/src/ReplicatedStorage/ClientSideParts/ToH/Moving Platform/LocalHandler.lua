local LocalHandler = {}
function LocalHandler.Handle()
	script.Parent.Hurt.BodyGyro.CFrame = script.Parent.Hurt.CFrame
	script.Parent.Hurt.BodyPosition.Position = script.Parent.Hurt.Position
	script.Parent.Hurt.Anchored = false
	while script.Parent do
		for i,v in pairs(script.Parent.Positions:GetChildren()) do
			script.Parent.Hurt.BodyPosition.Position = v.Position
			wait(script.Parent:FindFirstChild("Delay") and script.Parent.Delay.Value or 5)
		end
	end
end
return LocalHandler