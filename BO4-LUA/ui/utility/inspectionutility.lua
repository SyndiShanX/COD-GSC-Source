CoD.InspectionUtility = {}
CoD.InspectionUtility.MAX_CALLING_CARD_SLOTS = 3
CoD.InspectionUtility.GetCallingCardInfoForSlot = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = ""
	local f1_local1 = ""
	local f1_local2 = 0
	local f1_local3 = CoD.InspectionUtility.GetShowcaseCategoryForCurrentSessionMode()
	if f1_arg2 ~= nil then
		f1_local2 = Engine[0x5B4B49ECAB6D0E0](f1_arg2, f1_local3, f1_arg1)
		if f1_local2 > 0 then
			local f1_local4 = Engine[0x835AAEBF4D8F37F](f1_arg0, f1_local2)
			if f1_local4 and #f1_local4 > 0 then
				f1_local0, f1_local1 = CoD.ChallengesUtility.GetLocalizedNameAndDescriptionForChallengeInfo(f1_local4[1])
			else
				local f1_local5 = CoD.BlackMarketTableUtility.LootInfoLookup(f1_arg0, Engine[0x2DCF0973239E909](CoD.backgroundsTable, 3, 1, f1_local2))
				if f1_local5 and f1_local5.isLoot then
					f1_local1 = f1_local5.unlockInfo
				end
				local f1_local6 = 1
				local f1_local7 = 4
				local f1_local8 = Engine[0xED84C33EC5F01EA](Engine[0x2DCF0973239E909](CoD.backgroundsTable, 4, 1, f1_local2))
				if f1_local8 then
					f1_local0 = Engine[0xED84C33EC5F01EA](f1_local8)
				end
			end
		elseif not CoD.CombatRecordOtherPlayerStats then
			f1_local1 = Engine[0xF9F1239CFD921FE](0xE07CA35BF6DA1AF)
		end
	end
	return {
		iconId = f1_local2,
		title = f1_local0,
		description = f1_local1,
	}
end
CoD.InspectionUtility.GetXUIDForMenu = function(f2_arg0)
	local f2_local0 = nil
	local f2_local1 = f2_arg0.InspectionWidget
	if f2_local1 ~= nil then
		local f2_local2 = f2_local1:getModel()
		if f2_local2 then
			f2_local0 = f2_local2.xuid:get()
		end
	end
	return f2_local0
end
CoD.InspectionUtility.IsCallingCardButtonDisabled = function(f3_arg0, f3_arg1)
	return f3_arg1 ~= Engine[0x93B19E01B1FD1C7](f3_arg0)
end
CoD.InspectionUtility.GetCallingCardDescription = function(f4_arg0)
	local f4_local0 = f4_arg0:getModel()
	local f4_local1 = ""
	if f4_local0 and f4_local0.callingCard and f4_local0.callingCard.description then
		f4_local1 = f4_local0.callingCard.description:get()
	end
	return f4_local1
end
CoD.InspectionUtility.OnCallingCardFocusChange = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = DataSources.InspectionUtilityInfo.getModel(f5_arg1)
	f5_local0.callingCardDescriptionText:set(CoD.InspectionUtility.GetCallingCardDescription(f5_arg2))
end
CoD.InspectionUtility.SubscribeToCallingCardUpdateModels = function(f6_arg0, f6_arg1)
	local f6_local0 = Engine[0x8DF2E5447F384B9]()
	f6_local0 = f6_local0:create("CallingCardShowcaseUpdated")
	if f6_arg1.updateSubscription then
		f6_arg1:removeSubscription(f6_arg1.updateSubscription)
	end
	f6_arg1.updateSubscription = f6_arg1:subscribeToModel(f6_local0, function()
		f6_arg1:updateDataSource()
	end, false)
end
CoD.InspectionUtility.UpdateCallingCardShowcaseList = function(f8_arg0, f8_arg1)
	if f8_arg1 then
		f8_arg1:updateDataSource()
	end
end
CoD.InspectionUtility.OnTrophyShowcaseSelected = function(f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = CoD.InspectionUtility.GetXUIDForMenu(f9_arg0)
	if f9_local0 and f9_local0 == Engine[0x93B19E01B1FD1C7](f9_arg1) then
		DebugPrint("^1LUI: ^2CoD.InspectionUtility.OnTrophyShowcaseSelected")
	end
end
CoD.InspectionUtility.GetShowcaseCategoryForCurrentSessionMode = function()
	return Engine[0x4951A60F9129E6E](Engine[0x3EAC408F958FF05]())
end
CoD.InspectionUtility.ClearShowcaseCallingCard = function(f11_arg0, f11_arg1, f11_arg2)
	Engine[0x24E359C3015685F](f11_arg2, Engine[0x4951A60F9129E6E](Engine[0x3EAC408F958FF05]()), 0, f11_arg1.actionParam)
	local f11_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "CallingCardShowcaseUpdated")
	if f11_local0 then
		Engine[0x6A489878620F3BC](f11_local0)
	end
end
DataSources.InspectionUtilityInfo = {
	getModel = function(f12_arg0)
		local f12_local0 = Engine[0x4DF5CFBC1771947](f12_arg0)
		f12_local0 = f12_local0:create("InspectionUtilityInfo")
		f12_local0:create("callingCardDescriptionText")
		return f12_local0
	end,
}
DataSources.InspectionUtilityCallingCardOptions = ListHelper_SetupDataSource("InspectionUtilityCallingCardOptions", function(f13_arg0, f13_arg1)
	local f13_local0 = {}
	local f13_local1 = CoD.InspectionUtility.GetXUIDForMenu(f13_arg1.menu)
	if f13_local1 then
		local f13_local2 = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4)
			OpenCallingCards(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4)
		end
		local f13_local3 = CoD.InspectionUtility.IsCallingCardButtonDisabled(f13_arg0, f13_local1)
		for f13_local4 = 1, CoD.InspectionUtility.MAX_CALLING_CARD_SLOTS, 1 do
			local f13_local7 = f13_local4 - 1
			table.insert(f13_local0, {
				models = {
					callingCard = CoD.InspectionUtility.GetCallingCardInfoForSlot(f13_arg0, f13_local7, f13_local1),
				},
				properties = {
					action = f13_local2,
					actionParam = f13_local7,
					disabled = f13_local3,
				},
			})
		end
	end
	return f13_local0
end, true)
DataSourceHelpers.PerControllerDataSourceSetup("InspectionWeapon", "InspectionWeapon", function(f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0:create("weaponIndex")
	f15_local0:set(CoD.CACUtility.EmptyItemIndex)
	f15_local0 = f15_arg0:create("camoIndex")
	f15_local0:set(0)
end, false)
