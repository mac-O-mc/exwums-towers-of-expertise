local function displayTime(diff)
	local label = script.Parent
	local milliseconds =  tonumber(("%.0f"):format((diff % 1) * 1000))
	local seconds =  math.floor(diff % 60)
	local minutes =  math.floor(diff / 60) % 60

	if milliseconds < 1 then
		milliseconds = "000"
	elseif milliseconds < 10 then
		milliseconds = "00"..milliseconds
	elseif milliseconds < 100 then
		milliseconds = "0"..milliseconds
	end

	if seconds < 10 then
		seconds = "0"..seconds
	end
	
	label.Text = (minutes.. ":" .. seconds.. "." ..milliseconds)
end

local function Clock()
	local startTime = time() -- float representing when the timer was started
	wait()
	while game.Players.LocalPlayer.CurrentTower.Value ~= "" do -- run until 'secondsToRun' seconds have passed
		game:GetService("RunService").Heartbeat:Wait() -- this waits until the heartbeat event is triggered, which happens 60 times a second
		local timeSinceStart = time() - startTime
		displayTime(timeSinceStart)
	end
end

game.ReplicatedStorage.RequestTower.OnClientEvent:Connect(Clock)
game.ReplicatedStorage.RequestResetLocal.OnClientEvent:Connect(Clock)
game.ReplicatedStorage.UnloadTower.OnClientEvent:Connect(function()
	script.Parent.Text = "0:00.000"
end)

game.ReplicatedStorage.InvokeClockInformation.OnClientInvoke = (function()
	local clock = script.Parent.Text
	return clock
end)