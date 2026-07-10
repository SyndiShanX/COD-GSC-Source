CoD.MapUtility = {}
CoD.MapUtility.MapsTable = Engine[@"getgdtmapstable"]()
CoD.MapUtility.GetLocalizedMapValue = function(f1_arg0, f1_arg1, f1_arg2)
	f1_arg0 = CoD.MapUtility.ConvertMapNameToXHash(f1_arg0)
	if CoD.MapUtility.MapsTable[f1_arg0] ~= nil and CoD.MapUtility.MapsTable[f1_arg0][f1_arg1] ~= nil then
		return Engine[@"hash_4F9F1239CFD921FE"](CoD.MapUtility.MapsTable[f1_arg0][f1_arg1])
	else
		return f1_arg2
	end
end
CoD.MapUtility.GetMapValue = function(f2_arg0, f2_arg1, f2_arg2)
	f2_arg0 = CoD.MapUtility.ConvertMapNameToXHash(f2_arg0)
	if CoD.MapUtility.MapsTable[f2_arg0] ~= nil and CoD.MapUtility.MapsTable[f2_arg0][f2_arg1] ~= nil then
		return CoD.MapUtility.MapsTable[f2_arg0][f2_arg1]
	else
		return f2_arg2
	end
end
CoD.MapUtility.GetMapValueFromMapId = function(f3_arg0, f3_arg1, f3_arg2)
	if f3_arg0 ~= nil then
		for f3_local3, f3_local4 in pairs(CoD.MapUtility.MapsTable) do
			if f3_local4.uniqueID == f3_arg0 then
				return f3_local4[f3_arg1]
			end
		end
	end
	return f3_arg2
end
CoD.MapUtility.ForceStreamedImages = {}
CoD.MapUtility.ForceStreamMapAndGameTypeImages = function(f4_arg0)
	local f4_local0 = {}
	if f4_arg0 == Enum[@"emodes"][@"mode_invalid"] then
		return
	end
	for f4_local4, f4_local5 in pairs(Engine[@"getgametypesbase"](f4_arg0)) do
		if f4_local5.category == "standard" then
			f4_local0[GameTypeToImage(f4_local5.gametype)] = true
		end
	end
	for f4_local4, f4_local5 in pairs(CoD.mapsTable) do
		if f4_local5.session_mode == f4_arg0 then
			local f4_local6 = MapNameToMapImage(f4_local4)
			if type(f4_local6) == type(0x0) then
				f4_local0[f4_local6] = true
			end
		end
	end
	CoD.MapUtility.ForceStreamedImages = CoD.BaseUtility.ForceStreamHelper(CoD.MapUtility.ForceStreamedImages, f4_local0)
end
CoD.MapUtility.AllMembersHaveDLCMask = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg2 == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"]
	local f5_local1 = f5_local0
	local f5_local2 = Dvar[@"hash_632261E3333DC0E9"]:exists()
	if f5_local2 then
		f5_local2 = f5_local1 and Dvar[@"hash_632261E3333DC0E9"]:get()
	end
	for f5_local7, f5_local8 in ipairs(f5_arg0) do
		if f5_local2 then
			local f5_local6 = Engine[@"hash_5B892CC772EEDA44"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
			if f5_local6 & f5_arg1 ~= f5_arg1 and not CoD.BitUtility.IsBitwiseAndNonZero(f5_local6, Enum[@"contentflagbits"][@"hash_739C6503528DB793"]) then
				return false
			end
		end
		if f5_local8.dlcBits and f5_local8.dlcBits & f5_arg1 ~= f5_arg1 and (not f5_local0 or not CoD.BitUtility.IsBitwiseAndNonZero(f5_local8.dlcBits, Enum[@"contentflagbits"][@"hash_739C6503528DB793"])) then
			return false
		end
	end
	return true
end
CoD.MapUtility.AllMembersHaveDLCMap = function(f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1 and Engine[@"getdlcbitformapname"](f6_arg1)
	if f6_local0 then
		return CoD.MapUtility.AllMembersHaveDLCMask(f6_arg0, f6_local0, Engine[@"getlobbymainmode"]())
	else
		return true
	end
end
CoD.MapUtility.IsDLCMap = function(f7_arg0)
	local f7_local0 = f7_arg0 and CoD.BaseUtility.GetMapDataFromMapID(f7_arg0)
	local f7_local1 = f7_local0 and f7_local0.dlc_pack
	local f7_local2 = f7_local1
	local f7_local3
	if f7_local1 == Enum[@"dlcindex_t"][@"content_dev_map_index"] or f7_local1 == Enum[@"dlcindex_t"][@"content_original_map_index"] then
		f7_local3 = false
	else
		f7_local3 = f7_local2 and true
	end
	return f7_local3
end
CoD.MapUtility.IsDLCMapFromName = function(f8_arg0)
	local f8_local0 = f8_arg0 and CoD.MapUtility.GetMapValue(f8_arg0, "dlc_pack", Enum[@"dlcindex_t"][@"content_original_map_index"])
	local f8_local1 = f8_local0
	local f8_local2
	if f8_local0 == Enum[@"dlcindex_t"][@"content_dev_map_index"] or f8_local0 == Enum[@"dlcindex_t"][@"content_original_map_index"] then
		f8_local2 = false
	else
		f8_local2 = f8_local1 and true
	end
	return f8_local2
end
CoD.MapUtility.LobbyHasMap = function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0 and CoD.BaseUtility.GetMapDataFromMapID(f9_arg0)
	local f9_local1 = f9_local0 and f9_local0.dlc_pack
	if f9_local1 and f9_local1 ~= Enum[@"dlcindex_t"][@"content_dev_map_index"] and f9_local1 ~= Enum[@"dlcindex_t"][@"content_original_map_index"] then
		if not f9_arg1 then
			f9_arg1 = CoDShared.GetLobbyDLCBits(Engine[@"getlobbymainmode"](), Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
		end
		return f9_arg1 & Engine[@"getdlcbitfordlcindex"](f9_local1) == Engine[@"getdlcbitfordlcindex"](f9_local1)
	else
		return true
	end
end
CoD.MapUtility.CreateMapListDatasource = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = "MapList_" .. f10_arg1
	DataSources[f10_local0] = DataSourceHelpers.ListSetup(f10_local0, function(f11_arg0)
		local f11_local0 = {}
		local f11_local1 = CoD.LobbyUtility.GetClientList()
		local f11_local2 = function(f12_arg0)
			if CoD.BaseUtility.IsDvarEnabled("ui_remove_mp_jungle2_alt") and f12_arg0.id == @"mp_jungle2_alt" then
				return false
			else
				return true
			end
		end
		for f11_local6, f11_local7 in ipairs(f10_arg2) do
			if CoD.MapUtility.AllMembersHaveDLCMap(f11_local1, f11_local7.id) and f11_local2(f11_local7) then
				table.insert(f11_local0, {
					models = {
						name = f11_local7.name,
						id = f11_local7.id,
					},
					properties = {
						isMapElement = true,
						purchasable = false,
					},
				})
			end
			if ShowPurchasableMap(f11_arg0, f11_local7.id) and f11_local2(f11_local7) then
				table.insert(f11_local0, {
					models = {
						name = Engine[@"localize"](CoD.StoreUtility.PrependPurchaseIconIfNeeded(f11_arg0, f11_local7.id, f11_local7.name)),
						id = f11_local7.id,
					},
					properties = {
						isMapElement = true,
						purchasable = not Engine[@"ismapvalid"](f11_local7.id),
					},
				})
			end
		end
		return f11_local0
	end, true)
	return f10_local0
end
CoD.MapUtility.PlayMapLoadingMusic = function()
	Engine[@"playmenumusic"](CoD.MapUtility.GetMapValue(Engine[@"getcurrentmap"](), @"hash_63C3C4A322DD1A2E", ""))
	if CoD.isWarzone then
		Dvar[@"cg_minimappadding"]:set(22)
	else
		Dvar[@"cg_minimappadding"]:set(14)
	end
end
CoD.MapUtility.UpdateSelectedGametypeModel = function(f14_arg0)
	local f14_local0 = Engine[@"getglobalmodel"]()
	f14_local0 = f14_local0:create("lobbyRoot.selectedGameType")
	local f14_local1 = DataSources.MapVote.getModel(f14_arg0)
	if f14_local1.mapVoteGameModeNext then
		f14_local0:set(f14_local1.mapVoteGameModeNext:get())
	end
end
CoD.MapUtility.SelectElementMap = function(f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0:getModel(f15_arg1, "id")
	local f15_local1 = f15_local0 and f15_local0:get()
	if f15_local1 then
		SetMap(f15_arg1, f15_local1, false)
	end
end
CoD.MapUtility.SetMapPreviewToElementMap = function(f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0:getModel(f16_arg1, "id")
	local f16_local1 = f16_local0 and f16_local0:get()
	if f16_local1 then
		local f16_local2 = DataSources.MapModePreview.getModel(f16_arg1)
		f16_local2.mapName:set(f16_local1)
	end
end
DataSources.MapCategories = DataSourceHelpers.ListSetup("MapCategories", function(f17_arg0, f17_arg1)
	local f17_local0 = function(f18_arg0, f18_arg1)
		return f18_arg0.sortId < f18_arg1.sortId
	end
	local f17_local1 = {
		standard = {},
		dlc = {},
		bonus = {},
		league = {},
	}
	for f17_local6, f17_local7 in pairs(CoD.MapUtility.MapsTable) do
		if f17_local7.session_mode == CoD.gameModeEnum and f17_local7.dlc_pack > -1 then
			local f17_local5 = {
				name = Engine[@"hash_4F9F1239CFD921FE"](f17_local7.mapName),
				id = f17_local6,
				sortId = f17_local7.uniqueID or f17_local7.unique_id,
			}
			if f17_local7[0xEF53F0B666D343] == nil or IsBooleanDvarSet(f17_local7[0xEF53F0B666D343]) then
				if LuaUtils.IsArenaCustomGame() then
					if f17_local7[@"hash_6C4CE10DD7ABEB76"] == 1 then
						table.insert(f17_local1.league, f17_local5)
					end
				end
				if f17_local7[@"hash_19272D0E220CFAFA"] == 1 then
					table.insert(f17_local1.bonus, f17_local5)
				end
				if f17_local7.dlc_pack == 0 then
					table.insert(f17_local1.standard, f17_local5)
				else
					table.insert(f17_local1.dlc, f17_local5)
				end
			end
		end
	end
	table.sort(f17_local1.standard, f17_local0)
	table.sort(f17_local1.dlc, f17_local0)
	table.sort(f17_local1.bonus, f17_local0)
	table.sort(f17_local1.league, f17_local0)
	f17_local2 = {}
	if LuaUtils.IsArenaCustomGame() then
		if #f17_local1.league > 0 then
			table.insert(f17_local2, {
				models = {
					name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_545D73ABE2746471"),
					mapListDatasource = CoD.MapUtility.CreateMapListDatasource(f17_arg0, "league", f17_local1.league),
				},
				properties = {
					mapList = f17_local1.league,
				},
			})
		end
	else
		if #f17_local1.standard > 0 then
			table.insert(f17_local2, {
				models = {
					name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_38C2126F4B5F4049"),
					mapListDatasource = CoD.MapUtility.CreateMapListDatasource(f17_arg0, "standard", f17_local1.standard),
				},
				properties = {
					mapList = f17_local1.standard,
				},
			})
		end
		if #f17_local1.dlc > 0 then
			table.insert(f17_local2, {
				models = {
					name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_29E3D9BFC0C7C105"),
					mapListDatasource = CoD.MapUtility.CreateMapListDatasource(f17_arg0, "dlc", f17_local1.dlc),
				},
				properties = {
					mapList = f17_local1.dlc,
				},
			})
		end
		if #f17_local1.bonus > 0 then
			table.insert(f17_local2, {
				models = {
					name = Engine[@"hash_4F9F1239CFD921FE"](0xCD7217889FE44B),
					mapListDatasource = CoD.MapUtility.CreateMapListDatasource(f17_arg0, "bonus", f17_local1.bonus),
				},
				properties = {
					mapList = f17_local1.bonus,
				},
			})
		end
	end
	return f17_local2
end, true)
CoD.MapUtility.ConvertMapNameToXHash = function(f19_arg0)
	if type(f19_arg0) ~= "xhash" then
		f19_arg0 = Engine[@"converttoxhash"](f19_arg0)
	end
	return f19_arg0
end
CoD.MapUtility.ConvertMapNameToLocalizedXHash = function(f20_arg0)
	return CoD.MapUtility.ConvertMapNameToXHash(f20_arg0)
end
CoD.MapUtility.MapNameToMapImage = function(f21_arg0)
	return CoD.MapUtility.GetMapValue(f21_arg0, "previewImage", "$black")
end
CoD.MapUtility.MapNameToLargestAvailableMapImage = function(f22_arg0)
	return CoD.MapUtility.GetMapValue(f22_arg0, CoD.isWarzone and "previewImage" or "loadingImage", "$black")
end
CoD.MapUtility.MapNameToMapAARImage = function(f23_arg0)
	return CoD.MapUtility.GetMapValue(f23_arg0, Engine[@"converttoxhash"]("bigPreviewImage"), "$black")
end
CoD.MapUtility.MapNameToMapLoadingImage = function(f24_arg0, f24_arg1)
	if IsCampaign() then
		return CoD.BaseUtility.GetMapValue(f24_arg1, "loadingImage_" .. Engine[@"getfactionforteam"](CoD.CPUtility.GetFactionFromStatsByController(f24_arg0)), CoD.BaseUtility.GetMapValue(f24_arg1, "loadingImage", "$black"))
	else
		return CoD.BaseUtility.GetMapValue(f24_arg1, "loadingImage", "$black")
	end
end
CoD.MapUtility.MapNameToLocalizedName = function(f25_arg0)
	return CoD.MapUtility.GetLocalizedMapValue(f25_arg0, "mapName", "")
end
CoD.MapUtility.MapNameToLocalizedToUpperName = function(f26_arg0)
	return Engine[@"toupper"](CoD.MapUtility.GetLocalizedMapValue(f26_arg0, "mapName", ""))
end
CoD.MapUtility.MapNameToLocalizedToUpperNameShort = function(f27_arg0)
	local f27_local0 = CoD.MapUtility.GetMapValue(f27_arg0, "mapNameShort", 0x0)
	if f27_local0 ~= 0x0 then
		return Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](f27_local0))
	else
		return CoD.MapUtility.MapNameToLocalizedToUpperName(f27_arg0)
	end
end
CoD.MapUtility.GetMapTeamNameFromMapID = function(f28_arg0)
	local f28_local0 = CoD.TeamUtility.TeamDevStringToEnum(CoD.MapUtility.GetMapValue(f28_arg0, @"playerteam", ""))
	local f28_local1
	if f28_local0 == Enum[@"team_t"][@"team_bad"] then
		f28_local1 = 0x0
		if not f28_local1 then
		else
			return f28_local1
		end
	end
	f28_local1 = CoD.TeamUtility.GetDefaultTeamShortName(f28_local0)
end
CoD.MapUtility.GetInGameLocalizedMapName = function(f29_arg0)
	local f29_local0 = 0x0
	if Engine[@"isingame"]() then
		return CoD.MapUtility.MapNameToLocalizedName(Engine[@"getcurrentmapname"]())
	else
		return ""
	end
end
