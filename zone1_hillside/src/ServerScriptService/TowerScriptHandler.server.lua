-- Rudimentary customization for towers
local TowerRequested = game.ServerStorage.Bindables.TowerRequested
local TowerScripts = game.ServerScriptService

function OnGameplayStart(plr, towername)
	local TScript = TowerScripts:FindFirstChild(towername)
	if TScript then
		if TScript["OnGameplayStart"] then
			TScript.OnGameplayStart(plr, towername)
		end
	end
end
TowerRequested.Event:Connect(OnGameplayStart())