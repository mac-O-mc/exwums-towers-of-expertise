local cam = workspace.CurrentCamera
local plr = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService") -- stop it
local DS = game:GetService("DataStoreService")
local CoverTS = TweenInfo.new(1)
local CamTS = TweenInfo.new(1,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
repeat
	local try, catch = pcall( function()
		RunService.Heartbeat:Wait()
	end)
	if not try then
		RunService.PostSimulation:Wait()
	end
until game:IsLoaded()
local main = script.Parent.MainGui
local cover = script.Parent.CoverUi
local tpworking = true
local tpinprogress = false

game.ReplicatedStorage.DataDone.OnClientEvent:Wait()

main.Enabled = true
local frametw = TS:Create(cover.Frame, CoverTS, {BackgroundTransparency = 1})
local labeltw1 = TS:Create(cover.Frame.MiddleLabel, CoverTS, {TextTransparency = 1})
local labeltw2 = TS:Create(cover.Frame.LowerLabel, CoverTS, {TextTransparency = 1})
frametw:Play()
labeltw1:Play()
labeltw2:Play()


local camerastring1 = Instance.new("NumberValue")
camerastring1.Name = "playercurrentlevel"
camerastring1.Value = 1
camerastring1.Parent = plr

local camerastring2 = Instance.new("NumberValue")
camerastring2.Name = "playercurrentworld"
camerastring2.Value = 1
camerastring2.Parent = plr


local wrld = plr.playercurrentworld.Value
local zone = plr.playercurrentlevel.Value

local W1Table = {
	{"Valley Hillside", "Zone 1", 0},
	--	{"Forest Marsh", "Zone 2"}
	--	{"Lake", "Zone 3"},
	--	{"Desert", "Zone 4"},
}

local W2Table = {}

-- LOCAL FUNCTIONS
local function TeleportFunctionLoop()
	main.EnterRingLabel.TeleportString.Visible = true
	while tpworking == true do
		tpinprogress = true
		main.EnterRingLabel.TeleportString.Text = "Teleporting."
		wait(1)
		main.EnterRingLabel.TeleportString.Text = "Teleporting.."
		wait(1)
		main.EnterRingLabel.TeleportString.Text = "Teleporting..."
		wait(1)
	end
end

local function ResetDifficultyRangeForZone()
	local vals = wrld..zone
	local expectedfolder = vals.."DifficultyRange" 
	if #main.Left.DRBorder.DifficutlyRange:GetChildren() > 1 then
		for i,v in pairs(main.Left.DRBorder.DifficutlyRange:GetChildren()) do
			if not v:IsA("UIGridLayout") then
				v:Destroy()
			end
		end
	end
	local numInZone = #game.ReplicatedStorage[expectedfolder]:GetChildren()
	main.Left.DRBorder.DifficutlyRange.UIGridLayout.CellSize = UDim2.new(1,0,(1 / numInZone),0)
	for i,v in pairs(game.ReplicatedStorage[expectedfolder]:GetChildren()) do
		local currentdrframe = v:Clone()
		currentdrframe.Parent = main.Left.DRBorder.DifficutlyRange
	end
end

local function PlayerMoveZoneLevelUP()
	local vals = wrld..zone
	local wrt

	if wrld == 1 then
		wrt = W1Table
	elseif wrld == 2 then
		wrt = W2Table
	end

	if zone + 1 <= #wrt then
		local requested = zone + 1
		local reqtable = W1Table[requested]
		local expected = wrld..requested
		local camplay = TS:Create(cam,CamTS,{CFrame = game.Workspace[expected.."CamCFrame"].CFrame})
		camplay:Play()
		main.Left.ZoneExtraName.Text = reqtable[1]
		main.Left.ZoneName.Text = string.upper(reqtable[2])
		zone = zone + 1
	else
		local requested = 1
		local reqtable = W1Table[requested]
		local expected = wrld..requested
		local camplay = TS:Create(cam,CamTS,{CFrame = game.Workspace[expected.."CamCFrame"].CFrame})
		camplay:Play()
		main.Left.ZoneExtraName.Text = reqtable[1]
		main.Left.ZoneName.Text = string.upper(reqtable[2])
		zone = 1
	end
	ResetDifficultyRangeForZone()
end

local function PlayerMoveZoneLevelDOWN()
	local vals = wrld..zone
	if zone - 1 >= 1 then
		local requested = zone - 1
		local reqtable = W1Table[requested]
		local expected = wrld..requested
		local camplay = TS:Create(cam,CamTS,{CFrame = game.Workspace[expected.."CamCFrame"].CFrame})
		camplay:Play()
		main.Left.ZoneExtraName.Text = reqtable[1]
		main.Left.ZoneName.Text = string.upper(reqtable[2])
		zone = zone - 1
	else
		local requested = 1
		local reqtable = W1Table[requested]
		local expected = wrld..requested
		local camplay = TS:Create(cam,CamTS,{CFrame = game.Workspace[expected.."CamCFrame"].CFrame})
		camplay:Play()
		main.Left.ZoneExtraName.Text = reqtable[1]
		main.Left.ZoneName.Text = string.upper(reqtable[2])
		zone = 1
	end
	ResetDifficultyRangeForZone()
end


cam.CameraType = Enum.CameraType.Scriptable
cam.CFrame = workspace["11CamCFrame"].CFrame
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

-- TELEPORT ENTER THIS RING STRINGS
TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
	tpworking = false
	main.EnterRingLabel.TeleportString.TextColor3 = Color3.fromRGB(255,112,112)
	main.EnterRingLabel.TeleportString.Text = "Teleport Failed!"
	wait(2)
	main.EnterRingLabel.TeleportString.Text = "Teleporting..."
	main.EnterRingLabel.TeleportString.TextColor3 = Color3.fromRGB(255,255,255)
	main.EnterRingLabel.TeleportString.Visible = false
	tpworking = true
end)

main.EnterRingLabel.MouseEnter:Connect(function()
	main.EnterRingLabel.TextColor3 = Color3.fromRGB(220,220,220)
end)
main.EnterRingLabel.MouseLeave:Connect(function()
	main.EnterRingLabel.TextColor3 = Color3.fromRGB(255,255,255)
end)
main.EnterRingLabel.LeftButton.MouseEnter:Connect(function()
	main.EnterRingLabel.LeftButton.TextColor3 = Color3.fromRGB(220,220,220)
end)
main.EnterRingLabel.LeftButton.MouseLeave:Connect(function()
	main.EnterRingLabel.LeftButton.TextColor3 = Color3.fromRGB(255,255,255)
end)
main.EnterRingLabel.RightButton.MouseEnter:Connect(function()
	main.EnterRingLabel.RightButton.TextColor3 = Color3.fromRGB(220,220,220)
end)
main.EnterRingLabel.RightButton.MouseLeave:Connect(function()
	main.EnterRingLabel.RightButton.TextColor3 = Color3.fromRGB(255,255,255)
end)

-- MAIN TELEPORT FUNCTION
local function Teleport()
	main.EnterRingLabel.TextColor3 = Color3.fromRGB(150,150,150)
	if wrld == 1 and tpinprogress == false then
		if zone == 1 then
			TeleportService:Teleport(6211627243)
			TeleportFunctionLoop()
		end
	end
end

main.EnterRingLabel.MouseButton1Down:Connect(function()
	Teleport()
end)
main.EnterRingLabel.MouseButton1Up:Connect(function()
	main.EnterRingLabel.TextColor3 = Color3.fromRGB(220,220,220)
end)
main.EnterRingLabel.LeftButton.MouseButton1Down:Connect(function()
	PlayerMoveZoneLevelUP()
end)
main.EnterRingLabel.LeftButton.MouseButton1Up:Connect(function()
	main.EnterRingLabel.LeftButton.TextColor3 = Color3.fromRGB(220,220,220)
end)
main.EnterRingLabel.RightButton.MouseButton1Down:Connect(function()
	PlayerMoveZoneLevelDOWN()
end)
main.EnterRingLabel.RightButton.MouseButton1Up:Connect(function()
	main.EnterRingLabel.RightButton.TextColor3 = Color3.fromRGB(220,220,220)
end)

-- USER INPUT SERVICE

UIS.InputBegan:Connect(function(input, gpev)
	if input.UserInputType == Enum.UserInputType.Keyboard and script.parent.MainGui.Enabled == true and not gpev then
		local KeyPressed = input.KeyCode
		print(KeyPressed)
		if KeyPressed == Enum.KeyCode.D then
			PlayerMoveZoneLevelUP()
		elseif KeyPressed == Enum.KeyCode.A then
			PlayerMoveZoneLevelDOWN()
		elseif KeyPressed == Enum.KeyCode.Return then
			Teleport()
			wait()
			main.EnterRingLabel.TextColor3 = Color3.fromRGB(220,220,220)
		end
	end
end)



ResetDifficultyRangeForZone()