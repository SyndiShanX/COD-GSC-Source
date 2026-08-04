CoD.InspectionUtility = {}
CoD.InspectionUtility.MAX_CALLING_CARD_SLOTS = 3
CoD.InspectionUtility.GetCallingCardInfoForSlot = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = ""
	local f1_local1 = ""
	local f1_local2 = 0
	local f1_local3 = CoD.InspectionUtility.GetShowcaseCategoryForCurrentSessionMode()
	if f1_arg2 ~= nil then
		f1_local2 = Engine[@"hash_75B4B49ECAB6D0E0"](f1_arg2, f1_local3, f1_arg1)
		if f1_local2 > 0 then
			local f1_local4 = Engine.GetChallengeInfoByBackingId(f1_arg0, f1_local2)
			if f1_local4 and #f1_local4 > 0 then
				f1_local0, f1_local1 = CoD.ChallengesUtility.GetLocalizedNameAndDescriptionForChallengeInfo(f1_local4[1])
			else
				local f1_local5 = CoD.BlackMarketTableUtility.LootInfoLookup(f1_arg0, Engine.TableLookup(CoD.backgroundsTable, 3, 1, f1_local2))
				if f1_local5 and f1_local5.isLoot then
					f1_local1 = f1_local5.unlockInfo
				end
				local f1_local6 = 1
				local f1_local7 = 4
				local f1_local8 = Engine.Localize(Engine.TableLookup(CoD.backgroundsTable, 4, 1, f1_local2))
				if f1_local8 then
					f1_local0 = Engine.Localize(f1_local8)
				end
			end
		elseif not CoD.CombatRecordOtherPlayerStats then
			f1_local1 = Engine[@"hash_4F9F1239CFD921FE"]("menu/select_calling_card")
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
	return f3_arg1 ~= Engine.GetXUID64(f3_arg0)
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
	local f6_local0 = Engine.GetGlobalModel()
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
	if f9_local0 and f9_local0 == Engine.GetXUID64(f9_arg1) then
		DebugPrint("^1LUI: ^2CoD.InspectionUtility.OnTrophyShowcaseSelected")
	end
end
CoD.InspectionUtility.GetShowcaseCategoryForCurrentSessionMode = function()
	return Engine[@"hash_74951A60F9129E6E"](Engine.CurrentSessionMode())
end
CoD.InspectionUtility.ClearShowcaseCallingCard = function(f11_arg0, f11_arg1, f11_arg2)
	Engine.SetCombatRecordBackgroundId(f11_arg2, Engine[@"hash_74951A60F9129E6E"](Engine.CurrentSessionMode()), 0, f11_arg1.actionParam)
	local f11_local0 = Engine.GetModel(Engine.GetGlobalModel(), "CallingCardShowcaseUpdated")
	if f11_local0 then
		Engine.ForceNotifyModelSubscriptions(f11_local0)
	end
end
DataSources.InspectionUtilityInfo = {
	getModel = function(f12_arg0)
		local f12_local0 = Engine.GetModelForController(f12_arg0)
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
