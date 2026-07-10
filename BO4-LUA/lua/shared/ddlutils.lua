require("x64:c71b3cf9012e5dd")
DDLUtils = LuaReadOnlyTables.ReadOnlyTable({
	ipairs = function(f1_arg0)
		local f1_local0 = 0
		return function()
			local f2_local0, f2_local1 = nil
			if f1_local0 < #f1_arg0 then
				f2_local0 = f1_local0
				f2_local1 = f1_arg0[f2_local0]
			end
			f1_local0 = f1_local0 + 1
			return f2_local0, f2_local1
		end
	end,
	pairs = function(f3_arg0)
		local f3_local0 = f3_arg0.__keys
		local f3_local1 = 1
		return function()
			local f4_local0, f4_local1 = nil
			if f3_local1 <= #f3_local0 then
				f4_local0 = f3_local0[f3_local1]
				f4_local1 = f3_arg0[f4_local0]
			end
			f3_local1 = f3_local1 + 1
			return f4_local0, f4_local1
		end
	end,
})
