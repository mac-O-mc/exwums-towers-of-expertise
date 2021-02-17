local Players = game:GetService("Players")
local player = Players.LocalPlayer

local button = script.Parent:WaitForChild("Button")
local pushBox = script.Parent:WaitForChild("Pushbox")

local currentBox

local function spawnBox()
	if currentBox then
		currentBox:Destroy()
	end
	local box = pushBox:Clone()
	box.Parent = script.Parent
	currentBox = box
	if box:IsA("BasePart") then
		box.Anchored = false
	end
	for _,bc in pairs(box:GetDescendants()) do
		if bc:IsA("ModuleScript") and bc.Name == ("PushboxScript") then
			spawn(function()
				require(bc)()
			end)
		end
	end
end
local LocalHandler = {}
function LocalHandler.Handle()
	button.Touched:Connect(function(touch)
		if Players:GetPlayerFromCharacter(touch.Parent) == player then
			spawnBox()
		end
	end)
	pushBox.Parent = nil
	if not script.Parent:FindFirstChild("DontSpawnFirst") then spawnBox() end
end
return LocalHandler