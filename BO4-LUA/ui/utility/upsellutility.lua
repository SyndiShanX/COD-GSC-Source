CoD.UpsellUtility = {}
local f0_local0 = {
	{
		10050,
	},
	{
		10050,
		10051,
	},
	{
		10050,
		10051,
		10052,
	},
	{
		10050,
		10051,
		10052,
		10053,
		10055,
	},
	{
		10050,
		10051,
		10052,
		10054,
		10055,
	},
}
local f0_local1 = function(f1_arg0)
	return Engine[@"hash_6527869BC50E125D"](f1_arg0)
end
local f0_local2 = function(f2_arg0)
	local f2_local0 = f0_local1(f2_arg0)
	local f2_local1 = {}
	for f2_local5, f2_local6 in pairs(f2_local0) do
		if f2_local6.itemId >= 10000 and f2_local6.itemId < 11000 then
			table.insert(f2_local1, f2_local6.itemId)
		end
	end
	return f2_local1
end
local f0_local3 = function(f3_arg0, f3_arg1)
	for f3_local3, f3_local4 in pairs(f3_arg0) do
		if f3_local4 == f3_arg1 then
			return true
		end
	end
	return false
end
CoD.UpsellUtility.GetProductIDsToUpsell = function(f4_arg0)
	local f4_local0 = f0_local2(f4_arg0)
	local f4_local1 = {}
	if not f0_local3(f4_local0, 10054) then
		if not f0_local3(f4_local0, 10050) then
			table.insert(f4_local1, 34298)
			table.insert(f4_local1, 37868)
			table.insert(f4_local1, 37932)
		elseif f0_local3(f4_local0, 10053) then
			table.insert(f4_local1, 38010)
		elseif f0_local3(f4_local0, 10050) then
			table.insert(f4_local1, 37990)
			table.insert(f4_local1, 38009)
		end
	end
	return f4_local1
end
CoD.UpsellUtility.GetMainProductIDs = function()
	return {
		37932,
		37868,
		34298,
	}
end
local f0_local4 = function(f6_arg0)
	for f6_local3, f6_local4 in ipairs(GetProductIDsToUpsell(f6_arg0)) do
		DebugPrint("Upsell test - we should show product id " .. f6_local4 .. "\n")
	end
end
CoD.UpsellUtility.Test = function(f7_arg0, f7_arg1)
	f0_local4(f7_arg1)
end
