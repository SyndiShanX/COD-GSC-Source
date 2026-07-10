local f0_local0 = {
	ReadOnlyTable = function(f1_arg0)
		local f1_local0 = {
			_originalTable = f1_arg0,
		}
		setmetatable(f1_local0, {
			__index = f1_arg0,
			__newindex = function(f2_arg0, f2_arg1, f2_arg2)
				error("Attempt to modify a value in a readonly table.")
			end,
		})
		return f1_local0
	end,
	ConvertToReadOnlyTable = function(f3_arg0)
		local f3_local0 = {}
		for f3_local4, f3_local5 in pairs(f3_arg0) do
			if type(f3_local4) == "table" then
				LuaReadOnlyTables.ConvertToReadOnlyTable(f3_local4)
			end
			if type(f3_local5) == "table" then
				LuaReadOnlyTables.ConvertToReadOnlyTable(f3_local5)
			end
			f3_local0[f3_local4] = f3_local5
		end
		for f3_local4, f3_local5 in pairs(f3_local0) do
			f3_arg0[f3_local4] = nil
		end
		f3_arg0._originalTable = f3_local0
		setmetatable(f3_arg0, {
			__index = f3_local0,
			__newindex = function(f4_arg0, f4_arg1, f4_arg2)
				error("Attempt to modify a value in a readonly table.")
			end,
		})
	end,
}
LuaReadOnlyTables = f0_local0:ReadOnlyTable()
