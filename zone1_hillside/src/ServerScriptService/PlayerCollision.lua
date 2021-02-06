local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
 
local playerCollisionGroupName = "Players"
PhysicsService:CreateCollisionGroup(playerCollisionGroupName)
PhysicsService:CollisionGroupSetCollidable(playerCollisionGroupName, playerCollisionGroupName, false)
 
local previousCollisionGroups = {}
 
local function setCollisionGroup(object)
	if object:IsA("BasePart") then
		previousCollisionGroups[object] = object.CollisionGroupId
		PhysicsService:SetPartCollisionGroup(object, playerCollisionGroupName)
	end
end
 
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(function onCharacterAdded(character)
    	setCollisionGroup(character)
		for _, child in ipairs(object:GetChildren()) do
			setCollisionGroup(child)
		end

		character.DescendantAdded:Connect(setCollisionGroup)
		character.DescendantRemoving:Connect(function resetCollisionGroup(object)
			local previousCollisionGroupId = previousCollisionGroups[object]
			if previousCollisionGroupName ~= nil then 
				local previousCollisionGroupName = PhysicsService:GetCollisionGroupName(previousCollisionGroupId)
				if previousCollisionGroupName ~= nil then
					return false
				end
			else
				return false
			end
		 
			PhysicsService:SetPartCollisionGroup(object, previousCollisionGroupName)
			previousCollisionGroups[object] = nil
		end)
	end)
end
Players.PlayerAdded:Connect(onPlayerAdded)