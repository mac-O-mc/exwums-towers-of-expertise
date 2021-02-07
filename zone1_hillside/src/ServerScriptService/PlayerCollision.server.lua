local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local COLLISION_GROUP_PLAYERS = "Players"
PhysicsService:CreateCollisionGroup(COLLISION_GROUP_PLAYERS)
PhysicsService:CollisionGroupSetCollidable(COLLISION_GROUP_PLAYERS, COLLISION_GROUP_PLAYERS, false)
 
local function UsePlayersCollisionGroup(object)
	if object:IsA("BasePart") then
		PhysicsService:SetPartCollisionGroup(object, COLLISION_GROUP_PLAYERS)
	end
end
 
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(function (character)
		UsePlayersCollisionGroup(character)
		for _, child in ipairs(character:GetChildren()) do
			UsePlayersCollisionGroup(child)
		end
		-- uh, I guess we need this for.. something about respawning? I thought CharacterAdded would already do it
		character.DescendantAdded:Connect(UsePlayersCollisionGroup) 
		character.DescendantRemoving:Connect(function (object)
			-- PURPOSE: 'resetCollisionGroup', presumably to default groups
			---- this can go two ways
			-- 1st:
			if object:IsA("BasePart") then
				object.CollisionGroupId = 0 
			end
			-- 2nd:
			--[[local defaultcolgroup = PhysicsService:GetCollisionGroupName(0)
			PhysicsService:SetPartCollisionGroup(object, defaultcolgroup)--]]
			---- It doesn't really matter which one I'll use in this case, tho
		end)
	end)
end
Players.PlayerAdded:Connect(onPlayerAdded)