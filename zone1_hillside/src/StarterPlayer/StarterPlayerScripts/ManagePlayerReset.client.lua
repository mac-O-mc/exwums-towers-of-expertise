local uis = game:GetService("UserInputService")
local towerMemory
local plrresettime = game.Players.LocalPlayer:WaitForChild("PlrSettings").ResetTime.Value

local ts = game:GetService("TweenService")
local ts1 = TweenInfo.new(plrresettime)

local s = Instance.new("Sound")
s.Name = "ClientSound"
s.Parent = workspace
s.SoundId = "rbxassetid://12222030"

local function DestroyForClient(twr)
	if game.Workspace[twr] ~= nil then
		game.Workspace[twr]:Destroy()
	end
end

local function RefreshClient(twr)
	if game.Workspace:FindFirstChild(twr) then
		DestroyForClient(twr)
	end
	local replicate = game.ReplicatedStorage.ClientSideParts[twr]:Clone()
	replicate.Parent = workspace
	for i,v in pairs(replicate:GetChildren()) do
		if v:FindFirstChild("LocalHandler") then
			local m = require(v.LocalHandler)
			m.Handle()
		end
	end
end

uis.InputBegan:Connect(function(input, gpev)
	if input.UserInputType == Enum.UserInputType.Keyboard and not gpev then
		local KeyPressed = input.KeyCode
		if KeyPressed == Enum.KeyCode.R and game.Players.LocalPlayer.CurrentTower.Value ~= "" then
			local restartgui = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Top.RestartText
			local startgoal = {
				TextColor3 = Color3.fromRGB(255,0,0),
				TextTransparency = 0
			}
			local lossgoal = {
				TextColor3 = Color3.fromRGB(0,0,0),
				TextTransparency = 1
			}
			local starttween = ts:Create(restartgui,ts1,startgoal)
			local losstween = ts:Create(restartgui,ts1,lossgoal)
			local held = true
			losstween:Cancel()
			starttween:Play()
			local con
			con = input.Changed:Connect(function(prop)
				if prop == "UserInputState" then
					con:Disconnect() -- prevent spam
					starttween:Cancel()
					losstween:Play()
					held = false
				end
			end)
			wait(plrresettime)
			if held == true then
				towerMemory = game.Players.LocalPlayer.CurrentTower.Value
				game.ReplicatedStorage.RequestReset:FireServer(towerMemory)
				RefreshClient(towerMemory)
			end
		end
	end
end)


game.ReplicatedStorage.RequestTower.OnClientEvent:Connect(RefreshClient)
game.ReplicatedStorage.UnloadTower.OnClientEvent:Connect(DestroyForClient)