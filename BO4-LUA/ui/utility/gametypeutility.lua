CoD.GameTypeUtility = {}
CoD.GameTypeUtility.GameTypeTable = Engine[@"getgdtgametypetable"]()
CoD.GameTypeUtility.GameModes = {}
CoD.GameTypeUtility.StandardGameModes = {}
CoD.GameTypeUtility.LimitedTimeModes = {}
CoD.GameTypeUtility.GetLocalizedGameTypeValue = function(f1_arg0, f1_arg1, f1_arg2)
	f1_arg0 = CoD.GameTypeUtility.ConvertMapNameToXHash(f1_arg0)
	if CoD.GameTypeUtility.GameTypeTable[f1_arg0] ~= nil and CoD.GameTypeUtility.GameTypeTable[f1_arg0][f1_arg1] ~= nil then
		return Engine[@"hash_4F9F1239CFD921FE"](CoD.GameTypeUtility.GameTypeTable[f1_arg0][f1_arg1])
	else
		return f1_arg2
	end
end
CoD.GameTypeUtility.GetGameTypeValue = function(f2_arg0, f2_arg1, f2_arg2)
	f2_arg0 = CoD.GameTypeUtility.ConvertMapNameToXHash(f2_arg0)
	if CoD.GameTypeUtility.GameTypeTable[f2_arg0] ~= nil and CoD.GameTypeUtility.GameTypeTable[f2_arg0][f2_arg1] ~= nil then
		return CoD.GameTypeUtility.GameTypeTable[f2_arg0][f2_arg1]
	else
		return f2_arg2
	end
end
CoD.GameTypeUtility.GetGameTypeValueFromGameTypeId = function(f3_arg0, f3_arg1, f3_arg2)
	if f3_arg0 ~= nil then
		for f3_local3, f3_local4 in pairs(CoD.GameTypeUtility.GameTypeTable) do
			if f3_local4.uniqueID == f3_arg0 then
				return f3_local4[f3_arg1]
			end
		end
	end
	return f3_arg2
end
CoD.GameTypeUtility.GetAllGameModes = function(f4_arg0)
	if CoD.GameTypeUtility.GameModes[f4_arg0] ~= nil then
		return CoD.GameTypeUtility.GameModes[f4_arg0]
	end
	CoD.GameTypeUtility.GameModes[f4_arg0] = {}
	for f4_local7, f4_local8 in pairs(Engine[@"getgametypesbase"](f4_arg0)) do
		local f4_local9 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f4_local8.gametype))
		local f4_local3 = false
		for f4_local4, f4_local5 in pairs(CoD.GameTypeUtility.GameModes[f4_arg0]) do
			if f4_local5 == f4_local9 then
				f4_local3 = true
			end
		end
		if not f4_local3 then
			table.insert(CoD.GameTypeUtility.GameModes[f4_arg0], f4_local9)
		end
	end
	return CoD.GameTypeUtility.GameModes[f4_arg0]
end
CoD.GameTypeUtility.GetStandardGameModes = function(f5_arg0)
	if CoD.GameTypeUtility.StandardGameModes[f5_arg0] ~= nil then
		return CoD.GameTypeUtility.StandardGameModes[f5_arg0]
	end
	CoD.GameTypeUtility.StandardGameModes[f5_arg0] = {}
	for f5_local10, f5_local11 in pairs(Engine[@"getgametypesbase"](f5_arg0)) do
		local f5_local12 = Engine[@"getgametypeinfo"](f5_local11.gametype)
		if f5_local12[@"hash_31EBE909570DCA37"] == 0 then
			local f5_local3 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f5_local11.gametype))
			local f5_local4 = false
			for f5_local8, f5_local9 in pairs(CoD.GameTypeUtility.StandardGameModes[f5_arg0]) do
				if f5_local9 == f5_local3 then
					f5_local4 = true
				end
			end
			if not f5_local4 then
				table.insert(CoD.GameTypeUtility.StandardGameModes[f5_arg0], f5_local3)
			end
		end
	end
	return CoD.GameTypeUtility.StandardGameModes[f5_arg0]
end
CoD.GameTypeUtility.GetLimitedTimeModes = function(f6_arg0)
	if CoD.GameTypeUtility.LimitedTimeModes[f6_arg0] ~= nil then
		return CoD.GameTypeUtility.LimitedTimeModes[f6_arg0]
	end
	CoD.GameTypeUtility.LimitedTimeModes[f6_arg0] = {}
	for f6_local10, f6_local11 in pairs(Engine[@"getgametypesbase"](f6_arg0)) do
		local f6_local12 = Engine[@"getgametypeinfo"](f6_local11.gametype)
		if f6_local12[@"hash_31EBE909570DCA37"] == 1 then
			local f6_local3 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f6_local11.gametype))
			local f6_local4 = false
			for f6_local8, f6_local9 in pairs(CoD.GameTypeUtility.LimitedTimeModes[f6_arg0]) do
				if f6_local9 == f6_local3 then
					f6_local4 = true
				end
			end
			if not f6_local4 then
				table.insert(CoD.GameTypeUtility.LimitedTimeModes[f6_arg0], f6_local3)
			end
		end
	end
	return CoD.GameTypeUtility.LimitedTimeModes[f6_arg0]
end
CoD.GameTypeUtility.CreateGametypeListDatasource = function(f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = "GameTypeList_" .. f7_arg1
	DataSources[f7_local0] = DataSourceHelpers.ListSetup(f7_local0, function(f8_arg0)
		local f8_local0 = {}
		for f8_local5, f8_local6 in ipairs(f7_arg2) do
			local f8_local4
			if f8_local6.isLeagueMode ~= nil then
				f8_local4 = LuaUtils.MPArenaDisabled()
				if not f8_local4 then
					if f8_local6.isLeagueMode ~= LuaUtils.IsArenaCustomGame() then
						f8_local4 = false
					else
						f8_local4 = true
					end
				end
			else
				f8_local4 = true
			end
			if f8_local4 then
				table.insert(f8_local0, {
					models = {
						id = f8_local6.id,
						name = f8_local6.name,
						isOfficial = f8_local6.isOfficial,
					},
					properties = {
						isGameTypeElement = true,
					},
				})
			end
		end
		return f8_local0
	end, true)
	return f7_local0
end
CoD.GameTypeUtility.SetGameTypePreviewToElementGameType = function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:getModel(f9_arg1, "id")
	local f9_local1 = f9_local0 and f9_local0:get()
	if f9_local1 then
		local f9_local2 = DataSources.MapModePreview.getModel(f9_arg1)
		f9_local2.modeName:set(f9_local1)
	end
end
CoD.GameTypeUtility.DoesGameTypeSupportBots = function(f10_arg0)
	if IsArenaMode() then
		return false
	elseif f10_arg0 == "prop" or f10_arg0 == "bounty" or f10_arg0 == "escort" then
		return false
	elseif f10_arg0 == @"prop" or f10_arg0 == @"bounty" or f10_arg0 == @"escort" then
		return false
	else
		return true
	end
end
CoD.GameTypeUtility.ShowRoundPips = function()
	local f11_local0 = Engine[@"getgametypesetting"]("roundWinLimit")
	if f11_local0 ~= nil and f11_local0 > 0 and f11_local0 <= 4 then
		return true
	else
		return false
	end
end
CoD.GameTypeUtility.ShowSmallRoundPips = function()
	local f12_local0 = Engine[@"getgametypesetting"]("roundWinLimit")
	if f12_local0 ~= nil and f12_local0 > 4 and f12_local0 <= 6 then
		return true
	else
		return false
	end
end
CoD.GameTypeUtility.HideFactionScore = function()
	if CoD.HUDUtility.IsGameTypeEqualToString("escort") or CoD.HUDUtility.IsGameTypeEqualToString("ctf") then
		return true
	else
		return false
	end
end
DataSources.GameTypeCategories = DataSourceHelpers.ListSetup("GameTypeCategories", function(f14_arg0, f14_arg1)
	local f14_local0 = {}
	local f14_local1 = 0
	local f14_local2 = function(f15_arg0, f15_arg1)
		if f15_arg0.properties and f15_arg1.properties then
			return f15_arg0.properties.sortIndex < f15_arg1.properties.sortIndex
		else
			return f15_arg0.sortIndex < f15_arg1.sortIndex
		end
	end
	for f14_local9, f14_local10 in pairs(CoD.GameTypeUtility.GameTypeTable) do
		if f14_local10.groupName == "standard" then
			local f14_local6 = f14_local10.baseGameType
			local f14_local7 = false
			if f14_local10[0xEF53F0B666D343] == nil or IsBooleanDvarSet(f14_local10[0xEF53F0B666D343]) then
				f14_local7 = true
			end
			if f14_local7 then
				if f14_local10.isLeagueMode ~= nil then
					local f14_local8 = LuaUtils.MPArenaDisabled()
					if f14_local10.isLeagueMode ~= LuaUtils.IsArenaCustomGame() then
						f14_local7 = false
					else
						f14_local7 = f14_local8 or true
					end
				end
				f14_local7 = f14_local8 or true
			end
			if f14_local7 then
				if not f14_local0[f14_local6] then
					f14_local1 = f14_local1 + 1
					f14_local0[f14_local6] = {
						sortIndex = CoD.GameTypeUtility.GetGameTypeValue(f14_local6, "uniqueID", -1),
						name = CoD.GameTypeUtility.GetLocalizedGameTypeValue(f14_local6, "nameRef", ""),
						gametypeList = {},
					}
				end
				table.insert(f14_local0[f14_local6].gametypeList, {
					id = f14_local10.name,
					name = Engine[@"hash_4F9F1239CFD921FE"](f14_local10.nameRef),
					isOfficial = true,
					sortIndex = f14_local10.uniqueID,
					isLeagueMode = f14_local10.isLeagueMode,
				})
			end
		end
	end
	f14_local3 = {}
	for f14_local10, f14_local6 in pairs(f14_local0) do
		table.sort(f14_local6.gametypeList, f14_local2)
		table.insert(f14_local3, {
			models = {
				name = f14_local6.name,
				gametypeListDatasource = CoD.GameTypeUtility.CreateGametypeListDatasource(f14_arg0, f14_local10, f14_local6.gametypeList),
			},
			properties = {
				sortIndex = f14_local6.sortIndex,
				gametypeList = f14_local6.gametypeList,
			},
		})
	end
	table.sort(f14_local3, f14_local2)
	return f14_local3
end, true)
DataSources.GameTypeListZM = DataSourceHelpers.ListSetup("GameTypeListZM", function(f16_arg0, f16_arg1)
	local f16_local0 = {}
	local f16_local1 = function(f17_arg0, f17_arg1)
		return f17_arg0.properties.sortIndex < f17_arg1.properties.sortIndex
	end
	for f16_local5, f16_local6 in pairs(CoD.GameTypeUtility.GameTypeTable) do
		if f16_local6.groupName == "zclassic" then
			table.insert(f16_local0, {
				models = {
					id = f16_local6.name,
					name = Engine[@"hash_4F9F1239CFD921FE"](f16_local6.nameRef),
					isOfficial = true,
				},
				properties = {
					sortIndex = f16_local6.uniqueID,
					isGameTypeElement = true,
				},
			})
		end
	end
	table.sort(f16_local0, f16_local1)
	return f16_local0
end, true)
DataSources.GameTypeListWZ = DataSourceHelpers.ListSetup("GameTypeListWZ", function(f18_arg0, f18_arg1)
	local f18_local0 = {}
	local f18_local1 = function(f19_arg0, f19_arg1)
		return f19_arg0.properties.sortIndex < f19_arg1.properties.sortIndex
	end
	for f18_local6, f18_local7 in pairs(CoD.GameTypeUtility.GameTypeTable) do
		local f18_local5 = false
		if f18_local7.groupName == "wzstandard" and (f18_local7[0xEF53F0B666D343] == nil or IsBooleanDvarSet(f18_local7[0xEF53F0B666D343])) then
			f18_local5 = true
		end
		if f18_local5 == true then
			table.insert(f18_local0, {
				models = {
					id = f18_local7.name,
					name = Engine[@"hash_4F9F1239CFD921FE"](f18_local7.nameRef),
					isOfficial = true,
				},
				properties = {
					sortIndex = f18_local7.uniqueID,
					isGameTypeElement = true,
				},
			})
		end
	end
	table.sort(f18_local0, f18_local1)
	return f18_local0
end, true)
CoD.GameTypeUtility.ConvertMapNameToXHash = function(f20_arg0)
	if type(f20_arg0) ~= "xhash" then
		f20_arg0 = Engine[@"converttoxhash"](f20_arg0)
	end
	return f20_arg0
end
CoD.GameTypeUtility.ConvertMapNameToLocalizedXHash = function(f21_arg0)
	return CoD.GameTypeUtility.ConvertMapNameToXHash(f21_arg0)
end
CoD.GameTypeUtility.GameTypeToImage = function(f22_arg0)
	return CoD.GameTypeUtility.GetGameTypeValue(f22_arg0, "image", @"blacktransparent")
end
CoD.GameTypeUtility.GameTypeToLocalizeName = function(f23_arg0)
	return CoD.GameTypeUtility.GetLocalizedGameTypeValue(f23_arg0, "nameRef", "")
end
CoD.GameTypeUtility.GameTypeToLocalizeToUpperName = function(f24_arg0)
	return Engine[@"toupper"](CoD.GameTypeUtility.GetLocalizedGameTypeValue(f24_arg0, "nameRef", ""))
end
CoD.GameTypeUtility.GameTypeToLocalizeDesc = function(f25_arg0)
	return CoD.GameTypeUtility.GetLocalizedGameTypeValue(f25_arg0, "descriptionRef", "")
end
CoD.GameTypeUtility.GameTypeXHashToLocalizedGameType = function(f26_arg0)
	if f26_arg0 == nil or f26_arg0 == 0x0 then
		return ""
	else
		local f26_local0 = Engine[@"hash_48D4B2F88BB8D5E7"](f26_arg0)
		if f26_local0.nameRefCaps == nil then
			return ""
		else
			return Engine[@"hash_4F9F1239CFD921FE"](f26_local0.nameRefCaps)
		end
	end
end
CoD.GameTypeUtility.RoundsWonOfRoundsTotal = function(f27_arg0)
	return Engine[@"hash_4F9F1239CFD921FE"](0x3CEC48B933807C, f27_arg0, Engine[@"getgametypesetting"]("roundWinLimit"))
end
