local LocalHandler = {}
function LocalHandler.Handle()
	local plat = script.Parent:FindFirstChildOfClass("Part")
	plat.BodyGyro.CFrame = plat.CFrame
	plat.BodyPosition.Position = plat.Position
	plat.Anchored = false
	while script.Parent do
		for i,v in pairs(script.Parent.Positions:GetChildren()) do
			plat.BodyPosition.Position = v.Position
			wait(script.Parent:FindFirstChild("Delay") and script.Parent.Delay.Value or 5)
		end
	end
end
return LocalHandler