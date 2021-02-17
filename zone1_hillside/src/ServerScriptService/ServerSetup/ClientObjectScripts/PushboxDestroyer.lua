local LocalHandler = {}
function LocalHandler.Handle()
		script.Parent.Touched:Connect(function(t)
		if t.Name == "Pushbox" then
			if script.Parent:FindFirstChild("ColorSpecific") and script.Parent.ColorSpecific.Value then
				if t.Color == script.Parent.Color then t:Destroy() end
			else
				t:Destroy()
			end
		end
	end)
end
return LocalHandler