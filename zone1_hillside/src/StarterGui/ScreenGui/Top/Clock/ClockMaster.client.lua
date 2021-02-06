local function displayTime(diff)
	local label = script.Parent
	local milliseconds =  ("%.2s"):format(tostring((diff % 1) * 1000))
	local seconds =  math.floor(diff % 60)
	local minutes =  math.floor(diff / 60) % 60

	if seconds < 10 then
		seconds = "0" .. tostring(seconds)
	end
	
	label.Text = (minutes.. ":" .. seconds.. "." ..milliseconds)
end

local function Clock()
	local startTime = tick() -- float representing when the timer was started
	wait()
	while game.Players.LocalPlayer.CurrentTower.Value ~= "" do -- run until 'secondsToRun' seconds have passed
		game:GetService("RunService").Heartbeat:Wait() -- this waits until the heartbeat event is triggered, which happens 60 times a second
		local timeSinceStart = tick() - startTime
		displayTime(timeSinceStart)
	end
end



game.ReplicatedStorage.RequestTower.OnClientEvent:Connect(Clock)
game.ReplicatedStorage.RequestResetLocal.OnClientEvent:Connect(Clock)
game.ReplicatedStorage.UnloadTower.OnClientEvent:Connect(function()
	script.Parent.Text = "0:00:00"
end)

game.ReplicatedStorage.InvokeClockInformation.OnClientInvoke = (function()
	local clock = script.Parent.Text
	return clock
end)