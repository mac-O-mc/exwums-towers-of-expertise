local LocalHandler = {}
function LocalHandler.Handle()
	script.Parent.Touched:Connect(function(t)
		if t.Name == "Pushbox" then
			t.Color = script.Parent.Color
		end
	end)
end
return LocalHandler