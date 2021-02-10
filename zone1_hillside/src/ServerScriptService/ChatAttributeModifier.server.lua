local Players = game:GetService('Players')
local ServerScriptService = game:GetService('ServerScriptService')

local ChatService = require(ServerScriptService:WaitForChild('ChatServiceRunner'):WaitForChild('ChatService'))

ChatService.SpeakerAdded:Connect(function(PlayerName)
	local Speaker = ChatService:GetSpeaker(PlayerName)
	if Players[PlayerName]:GetRankInGroup(7493614) == 255 then 
		--		Speaker:SetExtraData('ChatColor', Color3.fromRGB(204,230,255))
		Speaker:SetExtraData('Tags', {{TagText = 'Owner', TagColor = Color3.fromRGB(128,191,255)}})
	elseif Players[PlayerName]:GetRankInGroup(7493614) == 254 then
		--		Speaker:SetExtraData('ChatColor', Color3.fromRGB(186,169,255))
		Speaker:SetExtraData('Tags', {{TagText = 'Developer', TagColor = Color3.fromRGB(124,110,216)}})
	elseif Players[PlayerName]:GetRankInGroup(7493614) == 110 then
		Speaker:SetExtraData('Tags', {{TagText = 'Contributor', TagColor = Color3.fromRGB(240,66,46)}})
--	elseif Players[PlayerName]:GetRankInGroup(7493614) == 100 then
--		Speaker:SetExtraData('Tags', {{TagText = 'Whitelisted', TagColor = Color3.fromRGB(255,255,255)}})
--		print(PlayerName.." is whitelisted")
	end
end)