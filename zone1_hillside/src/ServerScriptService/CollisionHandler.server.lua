local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CGROUP_PLAYERS = "Players"
PhysicsService:CreateCollisionGroup(CGROUP_PLAYERS)
PhysicsService:CollisionGroupSetCollidable(CGROUP_PLAYERS, CGROUP_PLAYERS, false)

local function UseCGroup_Players(object)
	if object:IsA("BasePart") then
		if PhysicsService:CollisionGroupContainsPart(CGROUP_PLAYERS, object) ~= nil then
			PhysicsService:SetPartCollisionGroup(object, CGROUP_PLAYERS)
		end
	end
end

Players.PlayerAdded:Connect(function (player)
	player.CharacterAdded:Connect( function (character)
		for _, child in ipairs(character:GetChildren()) do
			UseCGroup_Players(child)
		end
	end)
end)