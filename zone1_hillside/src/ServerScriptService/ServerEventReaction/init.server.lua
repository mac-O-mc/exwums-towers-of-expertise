local DamageEvent = game:GetService("ReplicatedStorage").DamageEvent
local Debounce = false

DamageEvent.OnServerEvent:Connect(function(Player,Damage)
	local char = Player.Character
	if char ~= nil and Debounce ~= true then
		Debounce = true
		if char.Humanoid ~= nil then
			char.Humanoid:TakeDamage(Damage)
		end
		wait(0.10) 
		Debounce = false
	end
end)

local function TeleportPlr(plr,goal)
	plr.Character.Head.CFrame = goal + Vector3.new(0, 4, 0)
end

game.ReplicatedStorage.RequestReset.OnServerEvent:Connect(function(plr, twr)
	if twr ~= "" then
		plr.Character:Destroy()
		plr.CurrentTower.Value = ""
		wait()
		plr:LoadCharacter()
		game.ReplicatedStorage.RequestResetLocal:FireClient(plr)
		plr.CurrentTower.Value = twr
	end
end)

game.ReplicatedStorage.TeleportEvent.OnServerEvent:Connect(TeleportPlr)