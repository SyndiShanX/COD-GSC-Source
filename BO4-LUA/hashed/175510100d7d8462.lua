require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
Lobby.AE = {}
Lobby.AE.ContractStateStatus = {
	REFRESHED_AVAILABLE_CONTRACTS = 0,
	REFRESHED_DAILY_CONTRACTS = 1,
}
Lobby.AE.ContractInfoKeys = {
	REWARD_TYPE = "1",
	REWARD_ID = "2",
	REWARD_AMOUNT = "3",
	REWARD_MODE_XP = "4",
	CONTRACT_ID = "5",
}
Lobby.AE.HandlePlayerSharedAchievementStateReponse = function(f1_arg0)
	local f1_local0 = "Lobby.AE.HandlePlayerSharedAchievementStateReponse"
	local f1_local1 = f1_arg0.controller
	local f1_local2 = f1_arg0.jsonResponseHandle
	local f1_local3 = Engine[@"hash_1A4245AC303B4CD5"]()
	if f1_local3 == nil then
		return Lobby.JSON.ErrorParsing(f1_local3, f1_local0, "failed to create JSON handle.\n")
	elseif f1_local3:beginParseAt("AESharedStateResponse", f1_local2) == false then
		return Lobby.JSON.ErrorParsing(f1_local3, f1_local0, "failed to parse shared state response.\n")
	end
	local f1_local4 = f1_local3:getRoot()
	if f1_local4 == nil then
		return Lobby.JSON.ErrorParsing(f1_local3, f1_local0, "failed to get shared state root JSON handle.\n")
	end
	local f1_local5 = f1_local4:getFieldByKey("wz_contracts")
	if f1_local5 ~= nil then
		Lobby.AE.ValidateWZContractXP(f1_local1, f1_local5)
	end
	local f1_local6 = f1_local4:getFieldByKey("contracts")
	if f1_local6 == nil then
		return Lobby.JSON.ErrorParsing(f1_local3, f1_local0, "failed to find contract state in JSON response.\n")
	elseif Lobby.AE.ShouldParseContractSharedAchievementStateResponse(f1_local1, f1_local6) then
		Lobby.AE.HandleSharedAchievementStateResponse(f1_local1, f1_local6)
	else
		Engine[@"hash_55AF982B4E0C67CC"](f1_local1)
	end
	f1_local3:endParse()
end
Lobby.AE.ShouldParseContractSharedAchievementStateResponse = function(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1:getUInt("version")
	Engine[@"hash_4CBE250CE5CD8C70"](f2_arg0, f2_local0)
	if f2_local0 ~= Dvar[@"hash_34F00ADB7D10075"]:get() then
		return false
	else
		return true
	end
end
Lobby.AE.ParseDailyContracts = function(f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1:getFieldByKey("daily")
	if f3_local0 then
		for f3_local8, f3_local9 in ipairs(f3_local0:getAllKeys()) do
			local f3_local10 = f3_local0:getFieldByKey(f3_local9)
			for f3_local4, f3_local5 in ipairs(f3_local10:getAllKeys()) do
				local f3_local7 = f3_local10:getFieldByKey(f3_local5)
				Engine[@"hash_46E3E7A27D050079"](f3_arg0, f3_local4 - 1, tonumber(f3_local5), 0, 1 << Enum[@"hash_B40A0B507A68068"][@"hash_6F7D0F1F6F551B94"], tonumber(f3_local9), f3_local7:getUInt(Lobby.AE.ContractInfoKeys.REWARD_TYPE), f3_local7:getUInt(Lobby.AE.ContractInfoKeys.REWARD_ID), f3_local7:getUInt(Lobby.AE.ContractInfoKeys.REWARD_AMOUNT), f3_local7:getUInt(Lobby.AE.ContractInfoKeys.REWARD_MODE_XP))
			end
		end
	end
end
Lobby.AE.ParseSelectableContracts = function(f4_arg0, f4_arg1)
	local f4_local0 = {}
	local f4_local1 = f4_arg1:getFieldByKey("pinned")
	for f4_local11, f4_local12 in ipairs(f4_local1:getAllKeys()) do
		local f4_local13 = f4_local1:getFieldByKey(f4_local12)
		for f4_local7, f4_local8 in ipairs(f4_local13:getAllKeys()) do
			local f4_local10 = f4_local13:getFieldByKey(f4_local8)
			if f4_local10 then
				local f4_local5 = f4_local10:getUInt(Lobby.AE.ContractInfoKeys.CONTRACT_ID)
				local f4_local6 = tostring(f4_local10:getInt(Lobby.AE.ContractInfoKeys.CONTRACT_ID))
				if f4_local5 > 0 then
					f4_local0[f4_local6] = f4_local5
					Engine[@"hash_1546E8D0768AAD32"](f4_arg0, tonumber(f4_local8), f4_local5, 0, 1 << Enum[@"hash_B40A0B507A68068"][@"hash_6F7D0F1F6F551B94"], tonumber(f4_local12), f4_local10:getUInt(Lobby.AE.ContractInfoKeys.REWARD_TYPE), f4_local10:getUInt(Lobby.AE.ContractInfoKeys.REWARD_ID), f4_local10:getUInt(Lobby.AE.ContractInfoKeys.REWARD_AMOUNT), f4_local10:getUInt(Lobby.AE.ContractInfoKeys.REWARD_MODE_XP))
				end
			end
		end
	end
	f4_local2 = f4_arg1:getFieldByKey("available")
	for f4_local13, f4_local22 in ipairs(f4_local2:getAllKeys()) do
		local f4_local14 = f4_local2:getFieldByKey(f4_local22)
		for f4_local10, f4_local5 in ipairs(f4_local14:getAllKeys()) do
			local f4_local6 = f4_local14:getFieldByKey(f4_local5)
			local f4_local17 = f4_local6:getUInt(Lobby.AE.ContractInfoKeys.REWARD_TYPE)
			local f4_local18 = f4_local6:getUInt(Lobby.AE.ContractInfoKeys.REWARD_ID)
			local f4_local19 = f4_local6:getUInt(Lobby.AE.ContractInfoKeys.REWARD_AMOUNT)
			local f4_local20 = f4_local6:getUInt(Lobby.AE.ContractInfoKeys.REWARD_MODE_XP)
			local f4_local21 = 0
			local f4_local16 = 0
			if f4_local0[f4_local5] then
				f4_local16 = f4_local16 | 1 << Enum[@"hash_B40A0B507A68068"][@"hash_6F7D0F1F6F551B94"]
			end
			Engine[0xB2FC418558EC1C](f4_arg0, f4_local10 - 1, tonumber(f4_local5), f4_local21, f4_local16, tonumber(f4_local22), f4_local17, f4_local18, f4_local19, f4_local20)
		end
	end
end
Lobby.AE.ParseContractTierRewards = function(f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1:getFieldByKey("tier")
	if f5_local0 then
		local f5_local1 = 0
		if f5_local0:getUInt("daily") > 0 then
			f5_local1 = 1 << CoDShared.LootContracts.StateFlags.LOOT_CONTRACT_DAILY_TIER_SKIP_EARNED
		end
		if f5_local0:getUInt("zm") > 0 then
			f5_local1 = 1 << CoDShared.LootContracts.StateFlags.LOOT_CONTRACT_ZM_TIER_SKIP_EARNED
		end
		Engine[@"hash_2BAB05BDB7A0F0F8"](f5_arg0, f5_local1)
	end
end
Lobby.AE.HandleSharedAchievementStateResponse = function(f6_arg0, f6_arg1)
	local f6_local0 = Engine[@"hash_3727AC3DCA0E2CE5"](f6_arg0)
	if f6_local0 and f6_local0.requested then
		Engine[@"hash_2FB57EC0023D10FA"](f6_arg0)
		local f6_local1 = f6_arg1:getUInt("status")
		if f6_local0.dailyExpiration == 0 or CoDShared.IsBitSet(f6_local1, Lobby.AE.ContractStateStatus.REFRESHED_DAILY_CONTRACTS) then
			Lobby.AE.ParseDailyContracts(f6_arg0, f6_arg1)
		end
		local f6_local2 = f6_arg1:getUInt("d_expiration")
		if f6_local2 then
			Engine[@"hash_4554F366D61F65C8"](f6_arg0, f6_local2)
		end
		if f6_local0.availableExpiration == 0 or CoDShared.IsBitSet(f6_local1, Lobby.AE.ContractStateStatus.REFRESHED_AVAILABLE_CONTRACTS) then
			Lobby.AE.ParseSelectableContracts(f6_arg0, f6_arg1)
		end
		local f6_local3 = f6_arg1:getUInt("a_expiration")
		if f6_local3 then
			Engine[@"hash_CAD5B9887D85BC9"](f6_arg0, f6_local3)
		end
		Lobby.AE.ParseContractTierRewards(f6_arg0, f6_arg1)
		Engine[@"hash_55AF982B4E0C67CC"](f6_arg0)
	end
end
Lobby.AE.ValidateWZContractXP = function(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1:getInt("xp")
	if f7_local0 ~= nil then
		local f7_local1 = Engine[@"getxpcap"](Enum[@"emodes"][@"mode_warzone"])
		local f7_local2 = Engine[@"hash_36CFA8EF5EE3D88F"]()
		f7_local2 = f7_local2[Enum[@"emodes"][@"mode_warzone"]]
		local f7_local3 = Engine[@"storagegetbuffer"](f7_arg0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"])
		if f7_local2 and f7_local3 then
			local f7_local4 = f7_local3[@"playerstatslist"][@"contractxp"][@"statvalue"]
			local f7_local5 = f7_local4:get()
			local f7_local6 = f7_local3[@"playerstatslist"][@"rankxp"][@"statvalue"]
			local f7_local7 = f7_local6:get()
			local f7_local8 = false
			if f7_local5 ~= f7_local0 then
				local f7_local9 = f7_local0 - f7_local5
				Engine[0xDE279ECDDDD966](f7_arg0, @"hash_6560E79F0D119335", {
					[@"user_id"] = Engine[@"getxuid64"](f7_arg0),
					[@"rankxp"] = f7_local7,
					[@"contractxp"] = f7_local5,
					[@"hash_69CEF1E44929E9FE"] = f7_local0,
				})
				f7_local4:set(f7_local0)
				f7_local6:set(math.min(f7_local1, f7_local7 + f7_local9))
				f7_local8 = true
			end
			f7_local7 = f7_local6:get()
			if f7_local1 < f7_local7 then
				f7_local6:set(f7_local1)
				f7_local7 = f7_local1
				f7_local8 = true
			elseif f7_local7 < 0 then
				f7_local6:set(0)
				f7_local7 = 0
				f7_local8 = true
			end
			for f7_local9 = #f7_local2, 0, -1 do
				if f7_local2[f7_local9][@"minxp"] <= f7_local7 then
					local f7_local12 = f7_local3[@"playerstatslist"][@"rank"][@"statvalue"]
					if f7_local12:get() ~= f7_local9 then
						f7_local12:set(f7_local9)
						f7_local8 = true
						break
					end
				end
			end
			if f7_local8 then
				Engine[@"storagewrite"](f7_arg0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"])
			end
		end
	end
end
