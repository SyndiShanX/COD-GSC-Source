CoD.ModelUtility = {}
CoD.ModelUtility.GetSelfModelPath = function(f1_arg0, f1_arg1)
	local f1_local0 = f1_arg0:getModel()
	if f1_arg1 ~= "" then
		local f1_local1 = LUI.splitString(f1_arg1, "->")
		for f1_local2 = 1, #f1_local1 - 1, 1 do
			if f1_local0 then
				f1_local0 = f1_local0[f1_local1[f1_local2]] and f1_local0[f1_local1[f1_local2]]:get()
			end
		end
		if f1_local0 then
			f1_local0 = f1_local0[f1_local1[#f1_local1]]
		end
	end
	return f1_local0
end
CoD.ModelUtility.GetSelfModelPathValue = function(f2_arg0, f2_arg1)
	local f2_local0 = CoD.ModelUtility.GetSelfModelPath(f2_arg0, f2_arg1)
	return f2_local0 and Engine.GetModelValue(f2_local0)
end
CoD.ModelUtility.IsParamModelEqualTo = function(f3_arg0, f3_arg1)
	return f3_arg0 and f3_arg0:get() == f3_arg1
end
CoD.ModelUtility.IsParamModelGreaterThanOrEqualTo = function(f4_arg0, f4_arg1)
	return f4_arg0 and f4_arg1 <= f4_arg0:get()
end
CoD.ModelUtility.IsParamModelEqualToString = function(f5_arg0, f5_arg1)
	return f5_arg0 and f5_arg0:get() == f5_arg1
end
CoD.ModelUtility.IsParamModelEqualToHashString = function(f6_arg0, f6_arg1)
	return f6_arg0 and f6_arg0:get() == f6_arg1
end
CoD.ModelUtility.IsParamModelEqualToEnum = function(f7_arg0, f7_arg1)
	return f7_arg0 and f7_arg0:get() == f7_arg1
end
CoD.ModelUtility.IsScriptNotifyDataArgEqualTo = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = f8_arg0 and CoD.GetScriptNotifyData(f8_arg0)
	return f8_local0 and f8_local0[f8_arg1] == f8_arg2
end
CoD.ModelUtility.IsModelValueNonEmptyString = function(f9_arg0, f9_arg1)
	local f9_local0 = Engine.GetModel(Engine.GetModelForController(f9_arg0), f9_arg1)
	local f9_local1 = f9_local0 and Engine.GetModelValue(f9_local0)
	local f9_local2
	if f9_local1 == nil or f9_local1 == "" or f9_local1 == 0x0 then
		f9_local2 = false
	else
		f9_local2 = true
	end
	return f9_local2
end
CoD.ModelUtility.IsModelValueTrue = function(f10_arg0, f10_arg1)
	local f10_local0 = Engine.GetModel(Engine.GetModelForController(f10_arg0), f10_arg1)
	local f10_local1 = f10_local0 and Engine.GetModelValue(f10_local0)
	local f10_local2
	if f10_local1 == nil or f10_local1 ~= true then
		f10_local2 = false
	else
		f10_local2 = true
	end
	return f10_local2
end
CoD.ModelUtility.IsModelValueGreaterThan = function(f11_arg0, f11_arg1, f11_arg2)
	local f11_local0 = Engine.GetModel(Engine.GetModelForController(f11_arg0), f11_arg1)
	local f11_local1 = f11_local0 and Engine.GetModelValue(f11_local0)
	local f11_local2
	if f11_local1 == nil or f11_arg2 >= f11_local1 then
		f11_local2 = false
	else
		f11_local2 = true
	end
	return f11_local2
end
CoD.ModelUtility.IsModelValueLessThan = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = Engine.GetModel(Engine.GetModelForController(f12_arg0), f12_arg1)
	local f12_local1 = f12_local0 and Engine.GetModelValue(f12_local0)
	local f12_local2
	if f12_local1 == nil or f12_local1 >= f12_arg2 then
		f12_local2 = false
	else
		f12_local2 = true
	end
	return f12_local2
end
CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = Engine.GetModel(Engine.GetModelForController(f13_arg0), f13_arg1)
	local f13_local1 = f13_local0 and Engine.GetModelValue(f13_local0)
	local f13_local2
	if f13_local1 == nil or f13_arg2 > f13_local1 then
		f13_local2 = false
	else
		f13_local2 = true
	end
	return f13_local2
end
CoD.ModelUtility.IsModelValueLessThanOrEqualTo = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = Engine.GetModel(Engine.GetModelForController(f14_arg0), f14_arg1)
	local f14_local1 = f14_local0 and Engine.GetModelValue(f14_local0)
	local f14_local2
	if f14_local1 == nil or f14_local1 > f14_arg2 then
		f14_local2 = false
	else
		f14_local2 = true
	end
	return f14_local2
end
CoD.ModelUtility.IsModelValueEqualTo = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = Engine.GetModel(Engine.GetModelForController(f15_arg0), f15_arg1)
	local f15_local1 = f15_local0 and Engine.GetModelValue(f15_local0)
	local f15_local2
	if f15_local1 == nil or tostring(f15_local1) ~= tostring(f15_arg2) then
		f15_local2 = false
	else
		f15_local2 = true
	end
	return f15_local2
end
CoD.ModelUtility.IsModelValueEqualToEitherValue = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
	local f16_local0 = Engine.GetModel(Engine.GetModelForController(f16_arg0), f16_arg1)
	local f16_local1 = f16_local0 and Engine.GetModelValue(f16_local0)
	local f16_local2
	if f16_local1 == nil or f16_local1 ~= f16_arg2 and f16_local1 ~= f16_arg3 then
		f16_local2 = false
	else
		f16_local2 = true
	end
	return f16_local2
end
CoD.ModelUtility.IsModelValueEqualToEnum = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = Engine.GetModel(Engine.GetModelForController(f17_arg0), f17_arg1)
	local f17_local1 = f17_local0 and Engine.GetModelValue(f17_local0)
	local f17_local2
	if f17_local1 == nil or f17_local1 ~= f17_arg2 then
		f17_local2 = false
	else
		f17_local2 = true
	end
	return f17_local2
end
CoD.ModelUtility.IsModelValueEqualToEitherEnum = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	local f18_local0 = Engine.GetModel(Engine.GetModelForController(f18_arg0), f18_arg1)
	local f18_local1 = f18_local0 and Engine.GetModelValue(f18_local0)
	local f18_local2
	if f18_local1 == nil or f18_local1 ~= f18_arg2 and f18_local1 ~= f18_arg3 then
		f18_local2 = false
	else
		f18_local2 = true
	end
	return f18_local2
end
CoD.ModelUtility.IsModelValueEnumBitSet = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = Engine.GetModel(Engine.GetModelForController(f19_arg0), f19_arg1)
	local f19_local1 = f19_local0 and Engine.GetModelValue(f19_local0)
	local f19_local2
	if f19_local1 ~= nil then
		f19_local2 = CoD.BitUtility.IsBitSet(f19_local1, f19_arg2)
	else
		f19_local2 = false
	end
	return f19_local2
end
CoD.ModelUtility.IsButtonModelValueEqualTo = function(f20_arg0, f20_arg1, f20_arg2)
	local f20_local0 = Engine.GetModel(Engine.GetModelForController(f20_arg0), "ButtonBits." .. f20_arg1)
	local f20_local1 = f20_local0 and Engine.GetModelValue(f20_local0)
	local f20_local2
	if f20_local1 == nil or f20_local1 ~= f20_arg2 then
		f20_local2 = false
	else
		f20_local2 = true
	end
	return f20_local2
end
CoD.ModelUtility.AreButtonModelValueBitsSet = function(f21_arg0, f21_arg1, f21_arg2)
	local f21_local0 = Engine.GetModel(Engine.GetModelForController(f21_arg0), "ButtonBits." .. f21_arg1)
	local f21_local1 = f21_local0 and Engine.GetModelValue(f21_local0)
	local f21_local2
	if f21_local1 == nil or f21_local1 & f21_arg2 ~= f21_arg2 then
		f21_local2 = false
	else
		f21_local2 = true
	end
	return f21_local2
end
CoD.ModelUtility.AreKeyModelValueBitsSet = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = Engine.GetModel(Engine.GetModelForController(f22_arg0), "KeyPressBits." .. f22_arg1)
	local f22_local1 = f22_local0 and Engine.GetModelValue(f22_local0)
	local f22_local2
	if f22_local1 == nil or f22_local1 & f22_arg2 ~= f22_arg2 then
		f22_local2 = false
	else
		f22_local2 = true
	end
	return f22_local2
end
CoD.ModelUtility.ModelValueStartsWith = function(f23_arg0, f23_arg1, f23_arg2)
	local f23_local0 = Engine.GetModel(Engine.GetModelForController(f23_arg0), f23_arg1)
	local f23_local1 = f23_local0 and Engine.GetModelValue(f23_local0)
	local f23_local2
	if f23_local1 ~= nil then
		f23_local2 = LUI.startswith(f23_local1, f23_arg2)
	else
		f23_local2 = false
	end
	return f23_local2
end
CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
	if not f24_arg0:getModel() then
		return false
	else
		local f24_local0 = Engine.GetModel(Engine.GetModelForController(f24_arg1), f24_arg2)
		if not f24_local0 then
			return false
		else
			local f24_local1 = Engine.GetModel(f24_arg0:getModel(), f24_arg3)
			if not f24_local1 then
				return false
			else
				return Engine.GetModelValue(f24_local0) == Engine.GetModelValue(f24_local1)
			end
		end
	end
end
local f0_local0 = nil
local f0_local1 = function(f25_arg0, f25_arg1, f25_arg2)
	local f25_local0 = Engine.GetModel(Engine.GetModelForController(f25_arg1), f25_arg2)
	if not f25_local0 then
		return false
	end
	local f25_local1 = tonumber(string.match(f25_arg0.id, "(%d+)"))
	local f25_local2 = Engine.GetModelValue(f25_local0)
	if not f0_local0 then
		f0_local0 = {}
		local f25_local3 = 3
		local f25_local4 = 10
		local f25_local5 = 0
		for f25_local6 = 1, f25_local4, 1 do
			for f25_local9 = 1, f25_local3, 1 do
				f0_local0[f25_local5] = f25_local6 + (f25_local9 - 1) * f25_local4
				f25_local5 = f25_local5 + 1
			end
		end
	end
	return f0_local0[f25_local1], f25_local2
end
CoD.ModelUtility.IsZmTrialTabGridChildIdNumEqualToControllerModelValue = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0, f26_local1 = f0_local1(f26_arg0, f26_arg1, f26_arg2)
	return f26_local0 == f26_local1
end
CoD.ModelUtility.IsZmTrialTabGridChildIdNumGreaterThanOrEqualToControllerModelValue = function(f27_arg0, f27_arg1, f27_arg2)
	local f27_local0, f27_local1 = f0_local1(f27_arg0, f27_arg1, f27_arg2)
	return f27_local1 <= f27_local0
end
CoD.ModelUtility.IsZmTrialTabGridChildIdNumLessThanOrEqualToControllerModelValue = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
	local f28_local0, f28_local1 = f0_local1(f28_arg0, f28_arg1, f28_arg2)
	if f28_local0 <= f28_local1 then
		return true
	elseif f28_arg3 and f28_arg3 ~= "" then
		local f28_local2, f28_local3 = f0_local1(f28_arg0, f28_arg1, f28_arg3)
		return f28_local2 < f28_local3
	else
		return false
	end
end
CoD.ModelUtility.IsControllerModelValueGreaterThanOrEqualToSelfModelValue = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
	if not f29_arg0:getModel() then
		return false
	else
		local f29_local0 = Engine.GetModel(Engine.GetModelForController(f29_arg1), f29_arg2)
		if not f29_local0 then
			return false
		else
			local f29_local1 = Engine.GetModel(f29_arg0:getModel(), f29_arg3)
			if not f29_local1 then
				return false
			else
				return Engine.GetModelValue(f29_local1) <= Engine.GetModelValue(f29_local0)
			end
		end
	end
end
CoD.ModelUtility.IsControllerModelValueNonEmptyString = function(f30_arg0, f30_arg1)
	local f30_local0 = Engine.GetModel(Engine.GetModelForController(f30_arg0), f30_arg1)
	if not f30_local0 then
		return false
	end
	local f30_local1 = Engine.GetModelValue(f30_local0)
	local f30_local2
	if f30_local1 == nil or f30_local1 == "" or f30_local1 == 0x0 then
		f30_local2 = false
	else
		f30_local2 = true
	end
	return f30_local2
end
CoD.ModelUtility.IsControllerModelValueTrue = function(f31_arg0, f31_arg1)
	local f31_local0 = Engine.GetModel(Engine.GetModelForController(f31_arg0), f31_arg1)
	if not f31_local0 then
		return false
	end
	local f31_local1 = Engine.GetModelValue(f31_local0)
	local f31_local2
	if f31_local1 == nil or f31_local1 ~= true then
		f31_local2 = false
	else
		f31_local2 = true
	end
	return f31_local2
end
CoD.ModelUtility.IsClientModelValueNonEmptyString = function(f32_arg0, f32_arg1)
	local f32_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f32_arg0)), f32_arg1)
	local f32_local1 = f32_local0 and Engine.GetModelValue(f32_local0)
	local f32_local2
	if f32_local1 == nil or f32_local1 == "" or f32_local1 == 0x0 then
		f32_local2 = false
	else
		f32_local2 = true
	end
	return f32_local2
end
CoD.ModelUtility.IsClientModelValueTrue = function(f33_arg0, f33_arg1)
	local f33_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f33_arg0)), f33_arg1)
	local f33_local1 = f33_local0 and Engine.GetModelValue(f33_local0)
	local f33_local2
	if f33_local1 == nil or f33_local1 ~= true then
		f33_local2 = false
	else
		f33_local2 = true
	end
	return f33_local2
end
CoD.ModelUtility.IsClientModelValueGreaterThan = function(f34_arg0, f34_arg1, f34_arg2)
	local f34_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f34_arg0)), f34_arg1)
	local f34_local1 = f34_local0 and Engine.GetModelValue(f34_local0)
	local f34_local2
	if f34_local1 == nil or f34_arg2 >= f34_local1 then
		f34_local2 = false
	else
		f34_local2 = true
	end
	return f34_local2
end
CoD.ModelUtility.IsClientModelValueLessThan = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f35_arg0)), f35_arg1)
	local f35_local1 = f35_local0 and Engine.GetModelValue(f35_local0)
	local f35_local2
	if f35_local1 == nil or f35_local1 >= f35_arg2 then
		f35_local2 = false
	else
		f35_local2 = true
	end
	return f35_local2
end
CoD.ModelUtility.IsClientModelValueGreaterThanOrEqualTo = function(f36_arg0, f36_arg1, f36_arg2)
	local f36_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f36_arg0)), f36_arg1)
	local f36_local1 = f36_local0 and Engine.GetModelValue(f36_local0)
	local f36_local2
	if f36_local1 == nil or f36_arg2 > f36_local1 then
		f36_local2 = false
	else
		f36_local2 = true
	end
	return f36_local2
end
CoD.ModelUtility.IsClientModelValueLessThanOrEqualTo = function(f37_arg0, f37_arg1, f37_arg2)
	local f37_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f37_arg0)), f37_arg1)
	local f37_local1 = f37_local0 and Engine.GetModelValue(f37_local0)
	local f37_local2
	if f37_local1 == nil or f37_local1 > f37_arg2 then
		f37_local2 = false
	else
		f37_local2 = true
	end
	return f37_local2
end
CoD.ModelUtility.IsClientModelValueEqualTo = function(f38_arg0, f38_arg1, f38_arg2)
	local f38_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f38_arg0)), f38_arg1)
	local f38_local1 = f38_local0 and Engine.GetModelValue(f38_local0)
	local f38_local2
	if f38_local1 == nil or f38_local1 ~= f38_arg2 then
		f38_local2 = false
	else
		f38_local2 = true
	end
	return f38_local2
end
CoD.ModelUtility.IsClientModelValueEqualToEitherValue = function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
	local f39_local0 = Engine.GetModel(Engine[@"getmodelforclient"](Engine.GetClientNum(f39_arg0)), f39_arg1)
	local f39_local1 = f39_local0 and Engine.GetModelValue(f39_local0)
	local f39_local2
	if f39_local1 == nil or f39_local1 ~= f39_arg2 and f39_local1 ~= f39_arg3 then
		f39_local2 = false
	else
		f39_local2 = true
	end
	return f39_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToClientModelValue = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	local f40_local0 = f40_arg1:getModel()
	f40_local0 = f40_local0 and f40_local0[f40_arg2]
	if f40_local0 then
		f40_local0 = f40_local0:get()
	end
	local f40_local1 = Engine[@"getmodelforclient"](Engine.GetClientNum(f40_arg0))
	f40_local1 = f40_local1[f40_arg3]
	if f40_local1 then
		f40_local1 = f40_local1:get()
	end
	local f40_local2
	if f40_local1 == nil or f40_local0 ~= f40_local1 then
		f40_local2 = false
	else
		f40_local2 = true
	end
	return f40_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToClientModelValuePlusValue = function(f41_arg0, f41_arg1, f41_arg2, f41_arg3, f41_arg4)
	local f41_local0 = f41_arg1:getModel()
	f41_local0 = f41_local0 and f41_local0[f41_arg2]
	if f41_local0 then
		f41_local0 = f41_local0:get()
	end
	local f41_local1 = Engine[@"getmodelforclient"](Engine.GetClientNum(f41_arg0))
	f41_local1 = f41_local1[f41_arg3]
	if f41_local1 then
		f41_local1 = f41_local1:get()
	end
	local f41_local2
	if f41_local1 == nil or f41_local0 ~= f41_local1 + f41_arg4 then
		f41_local2 = false
	else
		f41_local2 = true
	end
	return f41_local2
end
CoD.ModelUtility.IsSelfModelValueLessThanClientModelValuePlusValue = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4)
	local f42_local0 = f42_arg1:getModel()
	f42_local0 = f42_local0 and f42_local0[f42_arg2]
	if f42_local0 then
		f42_local0 = f42_local0:get()
	end
	local f42_local1 = Engine[@"getmodelforclient"](Engine.GetClientNum(f42_arg0))
	f42_local1 = f42_local1[f42_arg3]
	if f42_local1 then
		f42_local1 = f42_local1:get()
	end
	local f42_local2
	if f42_local1 == nil or f42_local0 == nil or f42_local0 >= f42_local1 + f42_arg4 then
		f42_local2 = false
	else
		f42_local2 = true
	end
	return f42_local2
end
CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue = function(f43_arg0, f43_arg1, f43_arg2)
	if not f43_arg0:getModel() then
		return false
	else
		local f43_local0 = Engine.GetModel(Engine.GetGlobalModel(), f43_arg1)
		if not f43_local0 then
			return false
		else
			local f43_local1 = Engine.GetModel(f43_arg0:getModel(), f43_arg2)
			if not f43_local1 then
				return false
			else
				return Engine.GetModelValue(f43_local0) == Engine.GetModelValue(f43_local1)
			end
		end
	end
end
CoD.ModelUtility.IsSelfModelValueEqualToHashString = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
	local f44_local0 = f44_arg1:getModel()
	f44_local0 = f44_local0 and f44_local0[f44_arg2]
	if f44_local0 then
		f44_local0 = f44_local0:get()
	end
	return f44_local0 == f44_arg3
end
CoD.ModelUtility.IsGlobalModelValueLessThanSelfModelValue = function(f45_arg0, f45_arg1, f45_arg2)
	if not f45_arg0:getModel() then
		return false
	else
		local f45_local0 = Engine.GetModel(Engine.GetGlobalModel(), f45_arg1)
		if not f45_local0 then
			return false
		else
			local f45_local1 = Engine.GetModel(f45_arg0:getModel(), f45_arg2)
			if not f45_local1 then
				return false
			else
				return Engine.GetModelValue(f45_local0) < Engine.GetModelValue(f45_local1)
			end
		end
	end
end
CoD.ModelUtility.IsGlobalModelValueGreaterThanSelfModelValue = function(f46_arg0, f46_arg1, f46_arg2)
	if not f46_arg0:getModel() then
		return false
	else
		local f46_local0 = Engine.GetModel(Engine.GetGlobalModel(), f46_arg1)
		if not f46_local0 then
			return false
		else
			local f46_local1 = Engine.GetModel(f46_arg0:getModel(), f46_arg2)
			if not f46_local1 then
				return false
			else
				return Engine.GetModelValue(f46_local1) < Engine.GetModelValue(f46_local0)
			end
		end
	end
end
CoD.ModelUtility.IsGlobalModelValueEqualToSelfTeam = function(f47_arg0, f47_arg1)
	local f47_local0 = CoD.TeamUtility.GetTeamID(f47_arg0)
	if f47_local0 == Enum.team_t[@"team_spectator"] then
		if CoD.ShoutcasterProfileVarBool(f47_arg0, "shoutcaster_ds_flip_scorepanel") then
			f47_local0 = Enum.team_t[@"team_axis"]
		else
			f47_local0 = Enum.team_t[@"team_allies"]
		end
	end
	return CoD.ModelUtility.IsGlobalModelValueEqualTo(f47_arg1, f47_local0)
end
CoD.ModelUtility.IsSelfNil = function(f48_arg0, f48_arg1)
	if f48_arg0 == nil then
		return true
	else
	end
end
CoD.ModelUtility.IsSelfModelNil = function(f49_arg0, f49_arg1)
	if f49_arg0:getModel() == nil then
		return true
	else
	end
end
CoD.ModelUtility.IsSelfModelPathNil = function(f50_arg0, f50_arg1, f50_arg2)
	local f50_local0 = f50_arg0:getModel()
	if f50_arg2 ~= "" and f50_local0 then
		f50_local0 = Engine.GetModel(f50_local0, f50_arg2)
	end
	return f50_local0 == nil
end
CoD.ModelUtility.IsSelfModelValueNil = function(f51_arg0, f51_arg1, f51_arg2)
	local f51_local0 = f51_arg0:getModel()
	if f51_arg2 ~= "" and f51_local0 then
		f51_local0 = Engine.GetModel(f51_local0, f51_arg2)
	end
	local f51_local1
	if f51_local0 ~= nil and f51_local0:get() ~= nil then
		f51_local1 = false
	else
		f51_local1 = true
	end
	return f51_local1
end
CoD.ModelUtility.IsSelfModelValueNilOrZero = function(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = f52_arg0:getModel()
	if f52_arg2 ~= "" and f52_local0 then
		f52_local0 = Engine.GetModel(f52_local0, f52_arg2)
	end
	local f52_local1 = f52_local0 and Engine.GetModelValue(f52_local0)
	local f52_local2
	if f52_local0 ~= nil and f52_local1 ~= nil and f52_local1 ~= 0 then
		f52_local2 = false
	else
		f52_local2 = true
	end
	return f52_local2
end
CoD.ModelUtility.IsSelfModelValueNilOrTrue = function(f53_arg0, f53_arg1, f53_arg2)
	local f53_local0 = f53_arg0:getModel()
	if f53_arg2 ~= "" and f53_local0 then
		f53_local0 = Engine.GetModel(f53_local0, f53_arg2)
	end
	local f53_local1 = f53_local0 and Engine.GetModelValue(f53_local0)
	local f53_local2
	if f53_local0 ~= nil and f53_local1 ~= nil and f53_local1 ~= true then
		f53_local2 = false
	else
		f53_local2 = true
	end
	return f53_local2
end
CoD.ModelUtility.IsSelfModelValueNonEmptyString = function(f54_arg0, f54_arg1, f54_arg2)
	local f54_local0 = f54_arg0:getModel()
	if f54_arg2 ~= "" and f54_local0 then
		f54_local0 = Engine.GetModel(f54_local0, f54_arg2)
	end
	local f54_local1 = f54_local0 and Engine.GetModelValue(f54_local0)
	local f54_local2
	if f54_local1 == nil or f54_local1 == "" or f54_local1 == 0x0 then
		f54_local2 = false
	else
		f54_local2 = true
	end
	return f54_local2
end
CoD.ModelUtility.IsSelfModelValueTrue = function(f55_arg0, f55_arg1, f55_arg2)
	local f55_local0 = f55_arg0:getModel()
	if f55_arg2 ~= "" and f55_local0 then
		f55_local0 = Engine.GetModel(f55_local0, f55_arg2)
	end
	local f55_local1 = f55_local0 and Engine.GetModelValue(f55_local0)
	local f55_local2
	if f55_local1 == nil or f55_local1 ~= true then
		f55_local2 = false
	else
		f55_local2 = true
	end
	return f55_local2
end
CoD.ModelUtility.IsSelfEnumModelValueTrue = function(f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = f56_arg0:getModel()
	if f56_arg2 ~= "" and f56_local0 then
		f56_local0 = Engine.GetModel(f56_local0, f56_arg2)
	end
	local f56_local1 = f56_local0 and Engine.GetModelValue(f56_local0)
	local f56_local2
	if f56_local1 == nil or f56_local1 ~= true then
		f56_local2 = false
	else
		f56_local2 = true
	end
	return f56_local2
end
CoD.ModelUtility.IsSelfEnumModelValueEqualTo = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
	local f57_local0 = f57_arg0:getModel()
	if f57_arg2 ~= "" and f57_local0 then
		f57_local0 = Engine.GetModel(f57_local0, f57_arg2)
	end
	local f57_local1 = f57_local0 and Engine.GetModelValue(f57_local0)
	local f57_local2
	if f57_local1 == nil or f57_local1 ~= f57_arg3 then
		f57_local2 = false
	else
		f57_local2 = true
	end
	return f57_local2
end
CoD.ModelUtility.IsSelfModelValueGreaterThan = function(f58_arg0, f58_arg1, f58_arg2, f58_arg3)
	local f58_local0 = f58_arg0:getModel()
	if f58_arg2 ~= "" and f58_local0 then
		f58_local0 = Engine.GetModel(f58_local0, f58_arg2)
	end
	local f58_local1 = f58_local0 and Engine.GetModelValue(f58_local0)
	local f58_local2
	if f58_local1 == nil or f58_arg3 >= f58_local1 then
		f58_local2 = false
	else
		f58_local2 = true
	end
	return f58_local2
end
CoD.ModelUtility.IsSelfModelPathValueGreaterThan = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
	local f59_local0 = CoD.ModelUtility.GetSelfModelPathValue(f59_arg0, f59_arg2)
	local f59_local1
	if f59_local0 == nil or f59_arg3 >= f59_local0 then
		f59_local1 = false
	else
		f59_local1 = true
	end
	return f59_local1
end
CoD.ModelUtility.IsSelfModelValueLessThan = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3)
	local f60_local0 = f60_arg0:getModel()
	if f60_arg2 ~= "" and f60_local0 then
		f60_local0 = Engine.GetModel(f60_local0, f60_arg2)
	end
	local f60_local1 = f60_local0 and Engine.GetModelValue(f60_local0)
	local f60_local2
	if f60_local1 == nil or f60_local1 >= f60_arg3 then
		f60_local2 = false
	else
		f60_local2 = true
	end
	return f60_local2
end
CoD.ModelUtility.IsSelfModelPathValueLessThan = function(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
	local f61_local0 = CoD.ModelUtility.GetSelfModelPathValue(f61_arg0, f61_arg2)
	local f61_local1
	if f61_local0 == nil or f61_local0 >= f61_arg3 then
		f61_local1 = false
	else
		f61_local1 = true
	end
	return f61_local1
end
CoD.ModelUtility.IsSelfModelPathValueEqualTo = function(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
	return CoD.ModelUtility.GetSelfModelPathValue(f62_arg0, f62_arg2) == f62_arg3
end
CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo = function(f63_arg0, f63_arg1, f63_arg2, f63_arg3)
	local f63_local0 = f63_arg0:getModel()
	if f63_arg2 ~= "" and f63_local0 then
		f63_local0 = Engine.GetModel(f63_local0, f63_arg2)
	end
	local f63_local1 = f63_local0 and Engine.GetModelValue(f63_local0)
	local f63_local2
	if f63_local1 == nil or f63_arg3 > f63_local1 then
		f63_local2 = false
	else
		f63_local2 = true
	end
	return f63_local2
end
CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo = function(f64_arg0, f64_arg1, f64_arg2, f64_arg3)
	local f64_local0 = f64_arg0:getModel()
	if f64_arg2 ~= "" and f64_local0 then
		f64_local0 = Engine.GetModel(f64_local0, f64_arg2)
	end
	local f64_local1 = f64_local0 and Engine.GetModelValue(f64_local0)
	local f64_local2
	if f64_local1 == nil or f64_local1 > f64_arg3 then
		f64_local2 = false
	else
		f64_local2 = true
	end
	return f64_local2
end
CoD.ModelUtility.IsSelfModelValueEqualTo = function(f65_arg0, f65_arg1, f65_arg2, f65_arg3)
	local f65_local0 = f65_arg0:getModel()
	if f65_arg2 ~= "" and f65_local0 then
		f65_local0 = Engine.GetModel(f65_local0, f65_arg2)
	end
	local f65_local1 = f65_local0 and Engine.GetModelValue(f65_local0)
	local f65_local2
	if f65_local1 == nil or f65_local1 ~= f65_arg3 then
		f65_local2 = false
	else
		f65_local2 = true
	end
	return f65_local2
end
CoD.ModelUtility.IsSelfModelValueInRange = function(f66_arg0, f66_arg1, f66_arg2, f66_arg3, f66_arg4)
	local f66_local0 = f66_arg0:getModel()
	if f66_arg2 ~= "" and f66_local0 then
		f66_local0 = Engine.GetModel(f66_local0, f66_arg2)
	end
	local f66_local1 = f66_local0 and Engine.GetModelValue(f66_local0)
	local f66_local2
	if f66_local1 == nil or tonumber(f66_arg3) > f66_local1 or f66_local1 > tonumber(f66_arg4) then
		f66_local2 = false
	else
		f66_local2 = true
	end
	return f66_local2
end
CoD.ModelUtility.IsSelfModelValueBetween = function(f67_arg0, f67_arg1, f67_arg2, f67_arg3, f67_arg4)
	local f67_local0 = f67_arg0:getModel()
	if f67_arg2 ~= "" and f67_local0 then
		f67_local0 = Engine.GetModel(f67_local0, f67_arg2)
	end
	local f67_local1 = f67_local0 and Engine.GetModelValue(f67_local0)
	local f67_local2
	if f67_local1 == nil or tonumber(f67_arg3) >= f67_local1 or f67_local1 >= tonumber(f67_arg4) then
		f67_local2 = false
	else
		f67_local2 = true
	end
	return f67_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToEitherValue = function(f68_arg0, f68_arg1, f68_arg2, f68_arg3, f68_arg4)
	local f68_local0 = f68_arg0:getModel()
	if f68_arg2 ~= "" and f68_local0 then
		f68_local0 = Engine.GetModel(f68_local0, f68_arg2)
	end
	local f68_local1 = f68_local0 and Engine.GetModelValue(f68_local0)
	local f68_local2
	if f68_local1 == nil or f68_local1 ~= f68_arg3 and f68_local1 ~= f68_arg4 then
		f68_local2 = false
	else
		f68_local2 = true
	end
	return f68_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToAnyValue = function(f69_arg0, f69_arg1, f69_arg2, f69_arg3, f69_arg4, f69_arg5)
	local f69_local0 = f69_arg0:getModel()
	if f69_arg2 ~= "" and f69_local0 then
		f69_local0 = Engine.GetModel(f69_local0, f69_arg2)
	end
	local f69_local1 = f69_local0 and Engine.GetModelValue(f69_local0)
	local f69_local2
	if f69_local1 == nil or f69_local1 ~= f69_arg3 and f69_local1 ~= f69_arg4 and f69_local1 ~= f69_arg5 then
		f69_local2 = false
	else
		f69_local2 = true
	end
	return f69_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToAnyValue4 = function(f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4, f70_arg5, f70_arg6)
	local f70_local0 = f70_arg0:getModel()
	if f70_arg2 ~= "" and f70_local0 then
		f70_local0 = Engine.GetModel(f70_local0, f70_arg2)
	end
	local f70_local1 = f70_local0 and Engine.GetModelValue(f70_local0)
	local f70_local2
	if f70_local1 == nil or f70_local1 ~= f70_arg3 and f70_local1 ~= f70_arg4 and f70_local1 ~= f70_arg5 and f70_local1 ~= f70_arg6 then
		f70_local2 = false
	else
		f70_local2 = true
	end
	return f70_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToAnyValue5 = function(f71_arg0, f71_arg1, f71_arg2, f71_arg3, f71_arg4, f71_arg5, f71_arg6, f71_arg7)
	local f71_local0 = f71_arg0:getModel()
	if f71_arg2 ~= "" and f71_local0 then
		f71_local0 = Engine.GetModel(f71_local0, f71_arg2)
	end
	local f71_local1 = f71_local0 and Engine.GetModelValue(f71_local0)
	local f71_local2
	if f71_local1 == nil or f71_local1 ~= f71_arg3 and f71_local1 ~= f71_arg4 and f71_local1 ~= f71_arg5 and f71_local1 ~= f71_arg6 and f71_local1 ~= f71_arg7 then
		f71_local2 = false
	else
		f71_local2 = true
	end
	return f71_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToEnum = function(f72_arg0, f72_arg1, f72_arg2, f72_arg3)
	local f72_local0 = f72_arg0:getModel()
	if f72_arg2 ~= "" and f72_local0 then
		f72_local0 = Engine.GetModel(f72_local0, f72_arg2)
	end
	local f72_local1 = f72_local0 and Engine.GetModelValue(f72_local0)
	local f72_local2
	if f72_local1 == nil or f72_local1 ~= f72_arg3 then
		f72_local2 = false
	else
		f72_local2 = true
	end
	return f72_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue = function(f73_arg0, f73_arg1, f73_arg2, f73_arg3, f73_arg4)
	local f73_local0 = f73_arg0:getModel()
	if f73_arg2 ~= "" and f73_local0 then
		f73_local0 = Engine.GetModel(f73_local0, f73_arg2)
	end
	local f73_local1 = f73_local0 and Engine.GetModelValue(f73_local0)
	local f73_local2
	if f73_local1 == nil or f73_local1 ~= f73_arg3 and f73_local1 ~= f73_arg4 then
		f73_local2 = false
	else
		f73_local2 = true
	end
	return f73_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToEnumAnyValue = function(f74_arg0, f74_arg1, f74_arg2, f74_arg3, f74_arg4, f74_arg5)
	local f74_local0 = f74_arg0:getModel()
	if f74_arg2 ~= "" and f74_local0 then
		f74_local0 = Engine.GetModel(f74_local0, f74_arg2)
	end
	local f74_local1 = f74_local0 and Engine.GetModelValue(f74_local0)
	local f74_local2
	if f74_local1 == nil or f74_local1 ~= f74_arg3 and f74_local1 ~= f74_arg4 and f74_local1 ~= f74_arg5 then
		f74_local2 = false
	else
		f74_local2 = true
	end
	return f74_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToEnumOrSelfModelNil = function(f75_arg0, f75_arg1, f75_arg2, f75_arg3)
	if f75_arg0:getModel() == nil then
		return true
	else
		return CoD.ModelUtility.IsSelfModelValueEqualToEnum(f75_arg0, f75_arg1, f75_arg2, f75_arg3)
	end
end
CoD.ModelUtility.IsSelfModelValueEqualToPropertyValue = function(f76_arg0, f76_arg1, f76_arg2, f76_arg3)
	local f76_local0 = f76_arg0:getModel()
	if f76_arg2 ~= "" and f76_local0 then
		f76_local0 = Engine.GetModel(f76_local0, f76_arg2)
	end
	local f76_local1 = f76_local0 and Engine.GetModelValue(f76_local0)
	local f76_local2
	if f76_local1 == nil or f76_local1 ~= f76_arg0[f76_arg3] then
		f76_local2 = false
	else
		f76_local2 = true
	end
	return f76_local2
end
CoD.ModelUtility.IsSelfModelValueEqualToSelfTeam = function(f77_arg0, f77_arg1, f77_arg2)
	local f77_local0 = CoD.TeamUtility.GetTeamID(f77_arg1)
	local f77_local1 = DataSources.Factions.getModel(f77_arg1)
	f77_local1 = f77_local1.actualTeam:get()
	if f77_local1 then
		f77_local0 = f77_local1
	end
	if f77_local0 == Enum.team_t[@"team_spectator"] then
		if CoD.ShoutcasterProfileVarBool(f77_arg1, "shoutcaster_ds_flip_scorepanel") then
			f77_local0 = Enum.team_t[@"team_axis"]
		else
			f77_local0 = Enum.team_t[@"team_allies"]
		end
	end
	return CoD.ModelUtility.IsSelfModelValueEqualTo(f77_arg0, f77_arg1, f77_arg2, f77_local0)
end
CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString = function(f78_arg0, f78_arg1, f78_arg2)
	local f78_local0 = DataSources[f78_arg1]
	if f78_local0 then
		f78_local0 = DataSources[f78_arg1].getModel
		if f78_local0 then
			f78_local0 = DataSources[f78_arg1].getModel(f78_arg0)
		end
	end
	local f78_local1 = f78_local0 and f78_local0[f78_arg2]
	local f78_local2 = f78_local1 and Engine.GetModelValue(f78_local1)
	local f78_local3
	if f78_local2 == nil or f78_local2 == "" or f78_local2 == 0x0 then
		f78_local3 = false
	else
		f78_local3 = true
	end
	return f78_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueTrue = function(f79_arg0, f79_arg1, f79_arg2)
	local f79_local0 = DataSources[f79_arg1]
	if f79_local0 then
		f79_local0 = DataSources[f79_arg1].getModel
		if f79_local0 then
			f79_local0 = DataSources[f79_arg1].getModel(f79_arg0)
		end
	end
	local f79_local1 = f79_local0 and f79_local0[f79_arg2]
	local f79_local2 = f79_local1 and Engine.GetModelValue(f79_local1)
	local f79_local3
	if f79_local2 == nil or f79_local2 ~= true then
		f79_local3 = false
	else
		f79_local3 = true
	end
	return f79_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
	local f80_local0 = DataSources[f80_arg1]
	if f80_local0 then
		f80_local0 = DataSources[f80_arg1].getModel
		if f80_local0 then
			f80_local0 = DataSources[f80_arg1].getModel(f80_arg0)
		end
	end
	local f80_local1 = f80_local0 and f80_local0[f80_arg2]
	local f80_local2 = f80_local1 and Engine.GetModelValue(f80_local1)
	local f80_local3
	if f80_local2 == nil or f80_local2 ~= f80_arg3 then
		f80_local3 = false
	else
		f80_local3 = true
	end
	return f80_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum = function(f81_arg0, f81_arg1, f81_arg2, f81_arg3)
	local f81_local0 = DataSources[f81_arg1]
	if f81_local0 then
		f81_local0 = DataSources[f81_arg1].getModel
		if f81_local0 then
			f81_local0 = DataSources[f81_arg1].getModel(f81_arg0)
		end
	end
	local f81_local1 = f81_local0 and f81_local0[f81_arg2]
	local f81_local2 = f81_local1 and Engine.GetModelValue(f81_local1)
	local f81_local3
	if f81_local2 == nil or f81_local2 ~= f81_arg3 then
		f81_local3 = false
	else
		f81_local3 = true
	end
	return f81_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan = function(f82_arg0, f82_arg1, f82_arg2, f82_arg3)
	local f82_local0 = DataSources[f82_arg1]
	if f82_local0 then
		f82_local0 = DataSources[f82_arg1].getModel
		if f82_local0 then
			f82_local0 = DataSources[f82_arg1].getModel(f82_arg0)
		end
	end
	local f82_local1 = f82_local0 and f82_local0[f82_arg2]
	local f82_local2 = f82_local1 and Engine.GetModelValue(f82_local1)
	local f82_local3
	if f82_local2 == nil or f82_arg3 >= tonumber(f82_local2) then
		f82_local3 = false
	else
		f82_local3 = true
	end
	return f82_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo = function(f83_arg0, f83_arg1, f83_arg2, f83_arg3)
	local f83_local0 = DataSources[f83_arg1]
	if f83_local0 then
		f83_local0 = DataSources[f83_arg1].getModel
		if f83_local0 then
			f83_local0 = DataSources[f83_arg1].getModel(f83_arg0)
		end
	end
	local f83_local1 = f83_local0 and f83_local0[f83_arg2]
	local f83_local2 = f83_local1 and Engine.GetModelValue(f83_local1)
	local f83_local3
	if f83_local2 == nil or f83_arg3 > tonumber(f83_local2) then
		f83_local3 = false
	else
		f83_local3 = true
	end
	return f83_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan = function(f84_arg0, f84_arg1, f84_arg2, f84_arg3)
	local f84_local0 = DataSources[f84_arg1]
	if f84_local0 then
		f84_local0 = DataSources[f84_arg1].getModel
		if f84_local0 then
			f84_local0 = DataSources[f84_arg1].getModel(f84_arg0)
		end
	end
	local f84_local1 = f84_local0 and f84_local0[f84_arg2]
	local f84_local2 = f84_local1 and Engine.GetModelValue(f84_local1)
	local f84_local3
	if f84_local2 == nil or tonumber(f84_local2) >= f84_arg3 then
		f84_local3 = false
	else
		f84_local3 = true
	end
	return f84_local3
end
CoD.ModelUtility.GlobalDataSourceModelValueStartsWith = function(f85_arg0, f85_arg1, f85_arg2, f85_arg3)
	local f85_local0 = DataSources[f85_arg1]
	if f85_local0 then
		f85_local0 = DataSources[f85_arg1].getModel
		if f85_local0 then
			f85_local0 = DataSources[f85_arg1].getModel(f85_arg0)
		end
	end
	local f85_local1 = f85_local0 and f85_local0[f85_arg2]
	local f85_local2 = f85_local1 and f85_local1:get()
	local f85_local3
	if f85_local2 ~= nil then
		f85_local3 = LUI.startswith(f85_local2, f85_arg3)
	else
		f85_local3 = false
	end
	return f85_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet = function(f86_arg0, f86_arg1, f86_arg2, f86_arg3)
	local f86_local0 = DataSources[f86_arg1]
	if f86_local0 then
		f86_local0 = DataSources[f86_arg1].getModel
		if f86_local0 then
			f86_local0 = DataSources[f86_arg1].getModel(f86_arg0)
		end
	end
	local f86_local1 = f86_local0 and f86_local0[f86_arg2]
	local f86_local2 = f86_local1 and f86_local1:get()
	local f86_local3
	if f86_local2 ~= nil then
		f86_local3 = CoD.BitUtility.IsBitSet(f86_local2, f86_arg3)
	else
		f86_local3 = false
	end
	return f86_local3
end
CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue = function(f87_arg0, f87_arg1, f87_arg2, f87_arg3, f87_arg4)
	local f87_local0 = DataSources[f87_arg2]
	if f87_local0 then
		f87_local0 = DataSources[f87_arg2].getModel
		if f87_local0 then
			f87_local0 = DataSources[f87_arg2].getModel(f87_arg1)
		end
	end
	if f87_local0 then
		f87_local0 = f87_local0[f87_arg3]
	end
	local f87_local1 = f87_arg0:getModel()
	f87_local1 = f87_local1 and f87_local1[f87_arg4]
	return f87_local1 and f87_local0 and f87_local0:get() == f87_local1:get()
end
CoD.ModelUtility.IsGlobalDataSourceModelValueLessThanSelfModelValue = function(f88_arg0, f88_arg1, f88_arg2, f88_arg3, f88_arg4)
	local f88_local0 = DataSources[f88_arg2]
	if f88_local0 then
		f88_local0 = DataSources[f88_arg2].getModel
		if f88_local0 then
			f88_local0 = DataSources[f88_arg2].getModel(f88_arg1)
		end
	end
	if f88_local0 then
		f88_local0 = f88_local0[f88_arg3]
	end
	local f88_local1 = f88_arg0:getModel()
	f88_local1 = f88_local1 and f88_local1[f88_arg4]
	return f88_local1 and f88_local0 and f88_local0:get() < f88_local1:get()
end
CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanSelfModelValue = function(f89_arg0, f89_arg1, f89_arg2, f89_arg3, f89_arg4)
	local f89_local0 = DataSources[f89_arg2]
	if f89_local0 then
		f89_local0 = DataSources[f89_arg2].getModel
		if f89_local0 then
			f89_local0 = DataSources[f89_arg2].getModel(f89_arg1)
		end
	end
	if f89_local0 then
		f89_local0 = f89_local0[f89_arg3]
	end
	local f89_local1 = f89_arg0:getModel()
	f89_local1 = f89_local1 and f89_local1[f89_arg4]
	return f89_local1 and f89_local0 and f89_local1:get() < f89_local0:get()
end
CoD.ModelUtility.IsGlobalDataSourceModelValueNil = function(f90_arg0, f90_arg1, f90_arg2)
	local f90_local0 = DataSources[f90_arg1]
	if f90_local0 then
		f90_local0 = DataSources[f90_arg1].getModel
		if f90_local0 then
			f90_local0 = DataSources[f90_arg1].getModel(f90_arg0)
		end
	end
	local f90_local1 = f90_local0 and f90_local0[f90_arg2]
	local f90_local2
	if f90_local1 ~= nil and (f90_local1 and Engine.GetModelValue(f90_local1)) ~= nil then
		f90_local2 = false
	else
		f90_local2 = true
	end
	return f90_local2
end
CoD.ModelUtility.IsGlobalModelValueNonEmptyString = function(f91_arg0)
	local f91_local0 = Engine.GetModel(Engine.GetGlobalModel(), f91_arg0)
	local f91_local1 = f91_local0 and Engine.GetModelValue(f91_local0)
	local f91_local2
	if f91_local1 == nil or f91_local1 == "" or f91_local1 == 0x0 then
		f91_local2 = false
	else
		f91_local2 = true
	end
	return f91_local2
end
CoD.ModelUtility.IsGlobalModelValueTrue = function(f92_arg0)
	local f92_local0 = Engine.GetModel(Engine.GetGlobalModel(), f92_arg0)
	local f92_local1 = f92_local0 and Engine.GetModelValue(f92_local0)
	local f92_local2
	if f92_local1 == nil or f92_local1 ~= true then
		f92_local2 = false
	else
		f92_local2 = true
	end
	return f92_local2
end
CoD.ModelUtility.IsGlobalModelValueEqualTo = function(f93_arg0, f93_arg1)
	local f93_local0 = Engine.GetModel(Engine.GetGlobalModel(), f93_arg0)
	local f93_local1 = f93_local0 and Engine.GetModelValue(f93_local0)
	local f93_local2
	if f93_local1 == nil or f93_local1 ~= f93_arg1 then
		f93_local2 = false
	else
		f93_local2 = true
	end
	return f93_local2
end
CoD.ModelUtility.IsGlobalModelValueEqualToEnum = function(f94_arg0, f94_arg1)
	local f94_local0 = Engine.GetModel(Engine.GetGlobalModel(), f94_arg0)
	local f94_local1 = f94_local0 and Engine.GetModelValue(f94_local0)
	local f94_local2
	if f94_local1 == nil or f94_local1 ~= f94_arg1 then
		f94_local2 = false
	else
		f94_local2 = true
	end
	return f94_local2
end
CoD.ModelUtility.IsGlobalModelValueLessThanOrEqualToEnum = function(f95_arg0, f95_arg1, f95_arg2)
	local f95_local0 = Engine.GetModel(Engine.GetGlobalModel(), f95_arg1)
	local f95_local1 = f95_local0 and Engine.GetModelValue(f95_local0)
	local f95_local2
	if f95_local1 == nil or f95_local1 > f95_arg2 then
		f95_local2 = false
	else
		f95_local2 = true
	end
	return f95_local2
end
CoD.ModelUtility.IsGlobalModelValueGreaterThanEnum = function(f96_arg0, f96_arg1, f96_arg2)
	local f96_local0 = Engine.GetModel(Engine.GetGlobalModel(), f96_arg1)
	local f96_local1 = f96_local0 and Engine.GetModelValue(f96_local0)
	local f96_local2
	if f96_local1 == nil or f96_arg2 >= f96_local1 then
		f96_local2 = false
	else
		f96_local2 = true
	end
	return f96_local2
end
CoD.ModelUtility.IsGlobalModelValueGreaterThan = function(f97_arg0, f97_arg1)
	local f97_local0 = Engine.GetModel(Engine.GetGlobalModel(), f97_arg0)
	local f97_local1 = f97_local0 and Engine.GetModelValue(f97_local0)
	local f97_local2
	if f97_local1 == nil or f97_arg1 >= tonumber(f97_local1) then
		f97_local2 = false
	else
		f97_local2 = true
	end
	return f97_local2
end
CoD.ModelUtility.IsGlobalModelValueLessThan = function(f98_arg0, f98_arg1)
	local f98_local0 = Engine.GetModel(Engine.GetGlobalModel(), f98_arg0)
	local f98_local1 = f98_local0 and Engine.GetModelValue(f98_local0)
	local f98_local2
	if f98_local1 == nil or tonumber(f98_local1) >= f98_arg1 then
		f98_local2 = false
	else
		f98_local2 = true
	end
	return f98_local2
end
CoD.ModelUtility.IsSelfModelValueBitSet = function(f99_arg0, f99_arg1, f99_arg2, f99_arg3)
	local f99_local0 = f99_arg0:getModel()
	if f99_arg2 ~= "" and f99_local0 then
		f99_local0 = Engine.GetModel(f99_local0, f99_arg2)
	end
	local f99_local1 = f99_local0 and Engine.GetModelValue(f99_local0)
	local f99_local2
	if f99_local1 ~= nil then
		f99_local2 = CoD.BitUtility.IsBitSet(f99_local1, f99_arg3)
	else
		f99_local2 = false
	end
	return f99_local2
end
CoD.ModelUtility.IsSelfModelValueEnumBitSet = function(f100_arg0, f100_arg1, f100_arg2, f100_arg3)
	local f100_local0 = f100_arg0:getModel()
	if f100_arg2 ~= "" and f100_local0 then
		f100_local0 = Engine.GetModel(f100_local0, f100_arg2)
	end
	local f100_local1 = f100_local0 and Engine.GetModelValue(f100_local0)
	local f100_local2
	if f100_local1 ~= nil then
		f100_local2 = CoD.BitUtility.IsBitSet(f100_local1, f100_arg3)
	else
		f100_local2 = false
	end
	return f100_local2
end
CoD.ModelUtility.IsSelfModelValueEnumFlagSet = function(f101_arg0, f101_arg1, f101_arg2, f101_arg3)
	local f101_local0 = f101_arg0:getModel()
	if f101_arg2 ~= "" and f101_local0 then
		f101_local0 = Engine.GetModel(f101_local0, f101_arg2)
	end
	local f101_local1 = f101_local0 and Engine.GetModelValue(f101_local0)
	local f101_local2
	if f101_local1 == nil or f101_local1 & f101_arg3 == 0 then
		f101_local2 = false
	else
		f101_local2 = true
	end
	return f101_local2
end
CoD.ModelUtility.IsSelfModelValueMyXuid = function(f102_arg0, f102_arg1, f102_arg2)
	local f102_local0 = f102_arg0:getModel()
	if f102_local0 then
		f102_local0 = Engine.GetModel(f102_local0, f102_arg2)
	end
	local f102_local1 = f102_local0 and Engine.GetModelValue(f102_local0)
	local f102_local2
	if f102_local1 == nil or f102_local1 ~= Engine.GetXUID64(f102_arg1) then
		f102_local2 = false
	else
		f102_local2 = true
	end
	return f102_local2
end
CoD.ModelUtility.IsSelfModelValueMyXuidOrAnyLocalPlayerOnGameOver = function(f103_arg0, f103_arg1, f103_arg2)
	local f103_local0 = CoD.SafeGetModelValue(f103_arg0:getModel(), f103_arg2)
	local f103_local1 = f103_arg1
	local f103_local2 = f103_arg1
	if IsInGame() and Engine.IsVisibilityBitSet(f103_arg1, Enum.UIVisibilityBit[@"bit_game_ended"]) then
		f103_local1 = 0
		f103_local2 = Engine.GetMaxControllerCount() - 1
	end
	for f103_local3 = f103_local1, f103_local2, 1 do
		if Engine.IsControllerBeingUsed(f103_local3) and f103_local0 == Engine.GetXUID64(f103_local3) then
			return true
		end
	end
	return false
end
CoD.ModelUtility.SetScriptNotifyDataArg = function(f104_arg0, f104_arg1, f104_arg2)
	local f104_local0 = f104_arg0 and CoD.GetScriptNotifyData(f104_arg0)
	if f104_local0 and f104_local0[f104_arg1] and f104_arg0["arg" .. f104_arg1] then
		f104_arg0["arg" .. f104_arg1]:set(f104_arg2)
	end
end
CoD.ModelUtility.SetTextIfNotNilAndNotEmptyString = function(f105_arg0, f105_arg1)
	local f105_local0 = f105_arg1:get()
	if f105_local0 ~= nil and f105_local0 ~= "" then
		f105_arg0:setText(f105_local0)
	end
end
CoD.ModelUtility.SetControllerModelValueToEnum = function(f106_arg0, f106_arg1, f106_arg2)
	local f106_local0 = Engine.GetModelForController(f106_arg0)
	f106_local0 = f106_local0:create(f106_arg1)
	f106_local0:set(f106_arg2)
end
CoD.ModelUtility.SetGlobalDatasourceModelValue = function(f107_arg0, f107_arg1, f107_arg2, f107_arg3)
	local f107_local0 = DataSources[f107_arg1]
	if f107_local0 then
		f107_local0 = DataSources[f107_arg1].getModel
		if f107_local0 then
			f107_local0 = DataSources[f107_arg1].getModel(f107_arg0)
		end
	end
	local f107_local1 = f107_local0 and f107_local0[f107_arg2]
	if f107_local1 then
		f107_local1:set(f107_arg3)
	end
end
CoD.ModelUtility.SetGlobalDatasourceModelValueToEnum = function(f108_arg0, f108_arg1, f108_arg2, f108_arg3)
	local f108_local0 = DataSources[f108_arg1]
	if f108_local0 then
		f108_local0 = DataSources[f108_arg1].getModel
		if f108_local0 then
			f108_local0 = DataSources[f108_arg1].getModel(f108_arg0)
		end
	end
	local f108_local1 = f108_local0 and f108_local0[f108_arg2]
	if f108_local1 then
		f108_local1:set(f108_arg3)
	end
end
CoD.ModelUtility.InitDataSourceModelIfNotSet = function(f109_arg0, f109_arg1, f109_arg2, f109_arg3)
	local f109_local0 = DataSources[f109_arg1]
	if f109_local0 then
		f109_local0 = DataSources[f109_arg1].getModel(f109_arg0)
	end
	if f109_local0 then
		local f109_local1 = f109_local0:create(f109_arg2)
		f109_local1:set(f109_arg3)
	end
end
CoD.ModelUtility.SetFromVec2 = function(f110_arg0, f110_arg1, f110_arg2, f110_arg3, f110_arg4)
	local f110_local0, f110_local1 = f110_arg0:get()
	return f110_local0 or 0, f110_local1 or 0, f110_arg3, f110_arg4
end
