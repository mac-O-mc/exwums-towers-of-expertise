local goldenmass = 4.8 -- this is the mass in cubic studs
local setmaxforce = true

local LocalHandler = {}
function LocalHandler.Handle()
	script.Parent.End.CanCollide = false
	bounce = false
	
	local totalvolume = (script.Parent.Platform.Size.X * script.Parent.Platform.Size.Y * script.Parent.Platform.Size.Z)

	for _, v in pairs(script.Parent.Platform:GetConnectedParts()) do
		if v ~= script.Parent.Platform then
			v.Massless = true
		end
	end

	script.Parent.Platform.CustomPhysicalProperties = PhysicalProperties.new(
		(1/totalvolume) * goldenmass,
		0.3, 0, --friction and elasticity
		1, 100 --friction and elasticity weights
	)
	script.Parent.Platform.BodyPosition.Position = script.Parent.Platform.Position
	script.Parent.Platform.BodyPosition.MaxForce = setmaxforce and Vector3.new(50000, 1000, 50000) or script.Parent.Platform.BodyPosition.MaxForce
	script.Parent.Platform.BodyPosition.P = setmaxforce and 2000 or script.Parent.Platform.BodyPosition.P
	script.Parent.Platform.Position = script.Parent.Platform.Position - (script.Parent.Platform.CFrame.UpVector * 2)

	script.Parent.Platform.Anchored = false

	spawn(function()
		local oldforce = script.Parent.Platform.BodyPosition.MaxForce
		local oldp = script.Parent.Platform.BodyPosition.P

		script.Parent.Platform.BodyPosition.MaxForce = Vector3.new(math.huge, 5000, math.huge)
		script.Parent.Platform.BodyPosition.P = 2000
		wait(0.5)
		script.Parent.Platform.BodyPosition.MaxForce = oldforce
		script.Parent.Platform.BodyPosition.P = oldp
	end)
	
	script.Parent.End.Touched:Connect(function(hit)
		if hit == script.parent.Platform then
			if bounce ~= true then
				bounce = true
				script.parent.Platform.CanCollide = false
				script.parent.Platform.Transparency = 0.8

				local oldforce = script.parent.Platform.BodyPosition.MaxForce
				local oldp = script.parent.Platform.BodyPosition.P

				script.parent.Platform.BodyPosition.MaxForce = Vector3.new(math.huge, 5000, math.huge)
				script.parent.Platform.BodyPosition.P = 2000

				wait(1.5)

				script.parent.Platform.CanCollide = true
				script.parent.Platform.Transparency = 0

				script.parent.Platform.BodyPosition.MaxForce = oldforce
				script.parent.Platform.BodyPosition.P = oldp
				bounce = false
			end
		end
	end)
end
return LocalHandler