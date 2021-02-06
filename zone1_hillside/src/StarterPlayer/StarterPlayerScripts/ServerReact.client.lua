game.ReplicatedStorage.SystemMessage.OnClientEvent:Connect(function(message)
	game.StarterGui:SetCore("ChatMakeSystemMessage", message)
end)