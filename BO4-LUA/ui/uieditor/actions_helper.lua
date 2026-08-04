function SendClientScriptMenuChangeNotifyHelper(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local f1_local0 = "closed"
	if f1_arg2 then
		f1_local0 = "opened"
	end
	Engine.SendClientScriptNotify(f1_arg0, "menu_change" .. CoD.GetLocalClientAdjustedNum(f1_arg0), {
		menu = f1_arg1,
		status = f1_local0,
		state = f1_arg3,
		mode = f1_arg4,
	})
end
function CloseAllOccludingMenus(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.occludedBy
	while f2_local0 ~= nil do
		if f2_local0.occludedBy ~= nil or f2_local0.ignoreForcedClose then
			f2_local0 = f2_local0.occludedBy
		end
		local f2_local1 = f2_local0
		while f2_local1 ~= f2_arg0 do
			f2_local1 = GoBackToMenu(f2_local1, f2_arg1, f2_arg0.menuName)
		end
		return
	end
end
function GetSessionModeFromPresenceActivity(f3_arg0)
	if f3_arg0 == Enum.PresenceActivity[@"presence_activity_offline"] then
		return Enum.eModes.mode_invalid
	elseif Enum.PresenceActivity[@"presence_activity_menu_inlobby"] <= f3_arg0 and f3_arg0 <= Enum.PresenceActivity[@"presence_activity_menu_last"] then
		return Enum.eModes.mode_invalid
	elseif Enum.PresenceActivity[@"presence_activity_cp_first"] <= f3_arg0 and f3_arg0 <= Enum.PresenceActivity[@"presence_activity_cp_last"] then
		return Enum.eModes.mode_campaign
	elseif Enum.PresenceActivity[@"presence_activity_mp_first"] <= f3_arg0 and f3_arg0 <= Enum.PresenceActivity[@"presence_activity_mp_last"] then
		return Enum.eModes.mode_multiplayer
	elseif Enum.PresenceActivity[@"presence_activity_zm_first"] <= f3_arg0 and f3_arg0 <= Enum.PresenceActivity[@"presence_activity_zm_last"] then
		return Enum.eModes.mode_zombies
	else
	end
end
function SetFocusToLoadoutWidgetAfterSetItem(f4_arg0)
	if f4_arg0.weaponSlotTable and f4_arg0.currentActiveSlot and f4_arg0.weaponSlotTable[f4_arg0.currentActiveSlot] then
		local f4_local0 = f4_arg0.weaponSlotTable[f4_arg0.currentActiveSlot]
		if f4_local0 then
			if f4_local0.widget then
				f4_local0.widget:processEvent({
					name = "gain_focus",
					skipGainFocus = true,
				})
			else
				f4_local0:dispatchEventToParent({
					name = "gain_focus",
					skipGainFocus = true,
				})
			end
		end
	end
end
function GetListItem(f5_arg0, f5_arg1)
	local f5_local0 = {}
	while f5_arg1 and f5_arg1 ~= f5_arg0 do
		table.insert(f5_local0, f5_arg1)
		f5_arg1 = f5_arg1:getParent()
	end
	if #f5_local0 >= 1 then
		return f5_local0[#f5_local0]
	else
		return initialElement
	end
end
function RemoveItemFromClassSlot(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	local f6_local0 = f6_arg0.classNum:get()
	local f6_local1 = f6_arg0[f6_arg1]
	local f6_local2 = CoD.SafeGetModelValue(f6_local1, "itemIndex")
	if not f6_local2 then
		f6_local2 = f6_local1 and f6_local1:get()
	end
	if f6_local2 and f6_local2 > CoD.CACUtility.EmptyItemIndex then
		if f6_arg1 == "primarygrenade" then
			CoD.CACUtility.SetClassItem(f6_arg2, f6_local0, f6_arg1, CoD.CACUtility.GetSpecialIssueEquipmentItemIndex(), nil, f6_arg4)
		else
			CoD.CACUtility.SetClassItem(f6_arg2, f6_local0, f6_arg1, CoD.CACUtility.EmptyItemIndex, nil, f6_arg4)
		end
		if f6_arg1 == "primary" or f6_arg1 == "secondary" then
			for f6_local6, f6_local7 in ipairs(CoD.CACUtility.GetAttachmentListForSlot(f6_arg1, true)) do
				RemoveItemFromClassSlot(f6_arg0, f6_local7, f6_arg2, f6_arg3, f6_arg4)
			end
			CoD.CACUtility.ClearWeaponOptionsForClass(f6_arg2, f6_arg0, f6_arg1)
			CoD.CACUtility.SetClassItem(f6_arg2, f6_local0, f6_arg1 .. "paintjobslot", Enum.CustomizationPaintjobInvalidID[@"customization_invalid_paintjob_slot"], nil, f6_arg4)
			CoD.CACUtility.SetClassItem(f6_arg2, f6_local0, f6_arg1 .. "." .. CoD.CACUtility[f6_arg1 .. "WeaponPrestigeSlot"], CoD.CACUtility.EmptyItemIndex, nil, f6_arg4)
			CoD.CACUtility.SetClassItem(f6_arg2, f6_local0, f6_arg1 .. ".charmIndex", CoD.CACUtility.EmptyItemIndex, nil, f6_arg4)
			CoD.CACUtility.SetClassItem(f6_arg2, f6_local0, f6_arg1 .. ".deathFxIndex", CoD.CACUtility.EmptyItemIndex, nil, f6_arg4)
		elseif LUI.startswith(f6_arg1, "primary.attachment") or LUI.startswith(f6_arg1, "secondary.attachment") then
			local f6_local8 = "primary"
			if LUI.startswith(f6_arg1, "secondary") then
				f6_local8 = "secondary"
			end
			local f6_local3 = f6_arg0[f6_local8]
			if f6_local3 then
				local f6_local5 = Engine.GetAttachmentRef(f6_local3.itemIndex:get(), f6_local2, f6_arg4)
				if f6_local5 and CoD.CACUtility.AttachmentHasCustomReticle(f6_local5) then
					local f6_local6 = f6_local8 .. ".reticleIndex"
					if f6_arg0[f6_local6] then
						CoD.CACUtility.SetClassItem(f6_arg2, f6_local0, f6_local6, CoD.CACUtility.EmptyItemIndex, nil, f6_arg4)
					end
				end
			end
		elseif f6_arg1 == "primarygrenade" then
			RemoveItemFromClassSlot(f6_arg0, "primarygrenadecount", f6_arg2, f6_arg3, f6_arg4)
		elseif LUI.startswith(f6_arg1, "bonuscard") then
			local f6_local3 = Engine[@"hash_7B98952F69D937F9"](f6_local2, CoD.CACUtility.GetStatIndexOffsetForLoadoutSlot(f6_arg1, f6_arg4), f6_arg4)
			if f6_local3 == "bonuscard_perk_1_greed" and not f6_arg3 then
				RemoveItemFromClassSlot(f6_arg0, "talent.4", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_perk_2_greed" and not f6_arg3 then
				RemoveItemFromClassSlot(f6_arg0, "talent.5", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_perk_3_greed" and not f6_arg3 then
				RemoveItemFromClassSlot(f6_arg0, "talent.6", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_perk_1_gluttony" then
				RemoveItemFromClassSlot(f6_arg0, "talent.2", f6_arg2, f6_arg3, f6_arg4)
				RemoveItemFromClassSlot(f6_arg0, "talent.3", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_perk_2_gluttony" then
				RemoveItemFromClassSlot(f6_arg0, "talent.1", f6_arg2, f6_arg3, f6_arg4)
				RemoveItemFromClassSlot(f6_arg0, "talent.3", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_perk_3_gluttony" then
				RemoveItemFromClassSlot(f6_arg0, "talent.1", f6_arg2, f6_arg3, f6_arg4)
				RemoveItemFromClassSlot(f6_arg0, "talent.2", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_overkill" then
				RemoveItemFromClassSlot(f6_arg0, "secondary", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_underkill" then
				RemoveItemFromClassSlot(f6_arg0, "primary", f6_arg2, f6_arg3, f6_arg4)
			elseif CoD.BonuscardUtility.IsBonuscardOfTypeList(CoD.BonuscardUtility.PrimaryGunfighterWildcards, f6_local3) then
				local f6_local4 = CoD.BonuscardUtility.SpecificGunfighterEquippedCountDDL(f6_arg2, f6_arg0, CoD.BonuscardUtility.PrimaryGunfighterWildcards, f6_arg4)
				local f6_local5 = CoD.BonuscardUtility.IsOperatorModBonuscardEquipped(f6_arg0, "primary", f6_arg4)
				RemoveItemFromClassSlot(f6_arg0, "primary.attachment.6", f6_arg2, f6_arg3, f6_arg4)
				if f6_local4 < 2 then
					if not f6_local5 then
						RemoveItemFromClassSlot(f6_arg0, "primary.attachment.5", f6_arg2, f6_arg3, f6_arg4)
					end
					if f6_local4 < 1 then
						RemoveItemFromClassSlot(f6_arg0, "primary.attachment.4", f6_arg2, f6_arg3, f6_arg4)
					end
				end
				CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadoutHelper(f6_arg2, f6_arg0, "primary", f6_arg4)
			elseif CoD.BonuscardUtility.IsBonuscardOfTypeList(CoD.BonuscardUtility.SecondaryGunfighterWildcards, f6_local3) then
				local f6_local4 = CoD.BonuscardUtility.SpecificGunfighterEquippedCountDDL(f6_arg2, f6_arg0, CoD.BonuscardUtility.SecondaryGunfighterWildcards, f6_arg4)
				local f6_local5 = CoD.BonuscardUtility.IsOperatorModBonuscardEquipped(f6_arg0, "secondary", f6_arg4)
				RemoveItemFromClassSlot(f6_arg0, "secondary.attachment.6", f6_arg2, f6_arg3, f6_arg4)
				if f6_local4 < 2 then
					if not f6_local5 then
						RemoveItemFromClassSlot(f6_arg0, "secondary.attachment.5", f6_arg2, f6_arg3, f6_arg4)
					end
					if f6_local4 < 1 then
						RemoveItemFromClassSlot(f6_arg0, "secondary.attachment.4", f6_arg2, f6_arg3, f6_arg4)
					end
				end
				CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadoutHelper(f6_arg2, f6_arg0, "secondary", f6_arg4)
			elseif f6_local3 == "bonuscard_primary_operator_mod" then
				RemoveItemFromClassSlot(f6_arg0, "primary.attachment.5", f6_arg2, f6_arg3, f6_arg4)
			elseif f6_local3 == "bonuscard_secondary_operator_mod" then
				RemoveItemFromClassSlot(f6_arg0, "secondary.attachment.5", f6_arg2, f6_arg3, f6_arg4)
			end
		end
		return true
	else
		return false
	end
end
function AttemptAttachItem(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5, f7_arg6, f7_arg7)
	local f7_local0 = f7_arg3.classNum:get()
	local f7_local1, f7_local2 = false
	local f7_local3 = false
	local f7_local4 = LUI.startswith(f7_arg4, "primary.attachment")
	if not f7_local4 then
		f7_local4 = LUI.startswith(f7_arg4, "secondary.attachment")
	end
	local f7_local5 = false
	CoD.perController[f7_arg1].overCapacityItemIndex = nil
	CoD.perController[f7_arg1].overCapacityItemRefHash = nil
	CoD.perController[f7_arg1].overCapacityIsUberAttachment = nil
	local f7_local6 = CoD.CACUtility.GetStatIndexOffsetForLoadoutSlot(f7_arg4, f7_arg2)
	local f7_local7 = nil
	if f7_local4 then
		local f7_local8 = LUI.splitString(f7_arg4, ".")
		f7_local8 = f7_local8[1]
		if f7_local8 and f7_arg3[f7_local8] then
			local f7_local9 = Engine.GetItemAttachment(f7_arg3[f7_local8].itemIndex:get(), f7_arg5, f7_arg2)
			f7_local7 = Engine[@"converttoxhash"](Engine.GetAttachmentRefByIndex(f7_local9))
			f7_local5 = Engine[0x37522AE910C327](f7_local9, f7_arg2) == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
		end
	end
	if not f7_local7 or f7_local7 == 0x0 then
		f7_local7 = Engine[@"hash_7B98952F69D937F9"](f7_arg5, f7_local6, f7_arg2)
	end
	local f7_local8 = CoD.CACUtility.GetMutuallyExclusiveSlotName(f7_arg1, f7_arg3, f7_arg4, f7_arg5, f7_local7, f7_arg2)
	for f7_local10 = 1, #f7_local8, 1 do
		local f7_local12 = f7_local8[f7_local10]
		if f7_local12 ~= "" and (not f7_local2 or f7_local2 ~= mutuallyExclusiveItemSlot) then
			RemoveItemFromClassSlot(f7_arg3, f7_local12, f7_arg1, f7_local3, f7_arg2)
		end
	end
	local f7_local10 = CoD.CACUtility.GetClassItem(f7_arg1, f7_local0, f7_arg4, f7_arg2)
	local f7_local9 = CoD.CACUtility.GetLoadoutListForSlot(f7_arg4)
	f7_local2 = CoD.CACUtility.GetClassItemOptionEquipSlot(f7_arg5, f7_arg3, f7_local9, #f7_local9)
	local f7_local11 = 0
	if f7_local4 then
		local f7_local13 = LUI.splitString(f7_arg4, ".")
		f7_local13 = f7_local13[1]
		if f7_local13 and f7_arg3[f7_local13] then
			f7_local11 = Engine.GetAttachmentAllocationCost(Engine.GetItemAttachment(f7_arg3[f7_local13].itemIndex:get(), f7_arg5, f7_arg2))
		end
	else
		f7_local11 = Engine.GetItemAllocationCost(f7_local10, f7_local6, f7_arg2)
	end
	if not (f7_local10 <= CoD.CACUtility.EmptyItemIndex or f7_local11 <= 0) or f7_local2 then
		f7_local3 = true
		if not f7_local2 then
			f7_local2 = f7_arg4
		end
		local f7_local13 = Engine[@"hash_7B98952F69D937F9"](f7_local10, f7_local6, f7_arg2)
		if f7_local13 == "bonuscard_perk_1_greed" then
			RemoveItemFromClassSlot(f7_arg3, "talent.4", f7_arg1, f7_local3, f7_arg2)
		elseif f7_local13 == "bonuscard_perk_2_greed" then
			RemoveItemFromClassSlot(f7_arg3, "talent.5", f7_arg1, f7_local3, f7_arg2)
		elseif f7_local13 == "bonuscard_perk_3_greed" then
			RemoveItemFromClassSlot(f7_arg3, "talent.6", f7_arg1, f7_local3, f7_arg2)
		end
		RemoveItemFromClassSlot(f7_arg3, f7_local2, f7_arg1, f7_local3, f7_arg2)
		RemoveItemFromClassSlot(f7_arg3, f7_arg4, f7_arg1, false, f7_arg2)
		f7_local1 = true
	end
	if not f7_local3 then
		local f7_local13 = CoD.CACUtility.GetMaxAllocation(f7_arg1)
		local f7_local12 = CoD.CACUtility.GetUsedAllocation(f7_arg1, f7_local0, f7_arg2)
		local f7_local14 = Engine.GetItemAllocationCost(f7_arg5, f7_local6, f7_arg2)
		if f7_local4 then
			local f7_local15 = LUI.splitString(f7_arg4, ".")
			f7_local15 = f7_local15[1]
			if f7_local15 and f7_arg3[f7_local15] then
				f7_local14 = Engine.GetAttachmentAllocationCost(Engine.GetItemAttachment(f7_arg3[f7_local15].itemIndex:get(), f7_arg5, f7_arg2))
			else
				f7_local14 = 1
			end
		elseif f7_arg4 == "primarygrenadecount" then
			f7_local14 = 1
		end
		local f7_local15 = f7_local12 + f7_local14 - f7_local13
		local f7_local16 = Engine.GetModelForController(f7_arg1)
		f7_local16["CACMenu.numItemsToRemove"].set(f7_local16["CACMenu.numItemsToRemove"], f7_local15)
		if f7_arg2 == Enum.eModes.mode_zombies or f7_local12 + f7_local14 <= f7_local13 or f7_local14 == 0 and not LUI.startswith(f7_arg4, "primary.attachment") and not LUI.startswith(f7_arg4, "secondary.attachment") and f7_arg4 ~= "primarygrenadecount" then
			f7_local1 = true
		else
			CoD.perController[f7_arg1].overCapacityItemIndex = f7_arg5
			CoD.perController[f7_arg1].overCapacityItemRefHash = f7_local7
			CoD.perController[f7_arg1].overCapacityIsUberAttachment = f7_local5
			local f7_local17 = CoD.CACUtility.OpenCACOverCapacityOverlay(f7_arg0, f7_arg1, f7_arg2, "OverCapacity", f7_arg3, f7_arg4)
			assert(f7_local17.itemList ~= nil)
			f7_local17.itemList.acceptData = {
				classNum = f7_local0,
				slotName = f7_arg4,
				itemIndex = f7_arg5,
			}
			return false
		end
	end
	if f7_local1 and f7_arg5 > CoD.CACUtility.EmptyItemIndex then
		if f7_local7 == "bonuscard_overkill" then
			RemoveItemFromClassSlot(f7_arg3, "secondary", f7_arg1, f7_local3, f7_arg2)
		elseif f7_local7 == "bonuscard_underkill" then
			RemoveItemFromClassSlot(f7_arg3, "primary", f7_arg1, f7_local3, f7_arg2)
		end
		CoD.CACUtility.SetClassItem(f7_arg1, f7_local0, f7_arg4, f7_arg5, f7_arg6, f7_arg2)
	end
	if not f7_arg7 then
		CoD.CACUtility.GetCustomClassModel(f7_arg1, f7_local0, f7_arg3, nil, f7_arg2)
	end
	return f7_local1
end
function SetConfirmationInfoInternal(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = Engine.GetModelValue(f8_arg2)
	local f8_local1 = Engine.GetModel(Engine.GetModelForController(f8_arg1), "UnlockTokenInfo")
	Engine.SetModelValue(Engine.GetModel(f8_local1, "itemIndex"), f8_local0)
	local f8_local2 = Engine.GetModel(f8_local1, "xpBarInfo")
	if f8_local2 then
		local f8_local3 = CoD.GetPlayerStats(f8_arg1)
		local f8_local4 = f8_local3.PlayerStatsList.RANKXP.statValue:get()
		local f8_local5 = f8_local3.PlayerStatsList.RANK.statValue:get()
		local f8_local6 = f8_local3.PlayerStatsList.PLEVEL.statValue:get()
		local f8_local7, f8_local8 = CoD.AARUtility.GetMinMaxXPForRank(f8_local5, f8_arg1)
		if not f8_local8 then
			f8_local8 = f8_local4
		end
		local f8_local9, f8_local10 = CoD.AARUtility.GetLevelAndLevelIconForRank(f8_local5, f8_local6)
		local f8_local11, f8_local12 = CoD.AARUtility.GetLevelAndLevelIconForRank(f8_local5 + 1, f8_local6)
		if IsInParagonCapableGameMode() and f8_local6 == CoD.RankUtility.GetPrestigeCap() then
			f8_local4 = f8_local3.PlayerStatsList.PARAGON_RANKXP.statValue:get()
			f8_local5 = f8_local3.PlayerStatsList.PARAGON_RANK.statValue:get()
			f8_local7, f8_local8 = CoD.AARUtility.GetMinMaxXPForParagonRank(f8_local5, f8_arg1)
			if not f8_local8 then
				f8_local8 = f8_local4
			end
			f8_local9 = Engine.GetParagonRankDisplayLevel(f8_local5)
			f8_local11 = Engine.GetParagonRankDisplayLevel(f8_local5 + 1)
			local f8_local13 = f8_local3.PlayerStatsList.PARAGON_ICON_ID.StatValue:get()
			if f8_local13 ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
				f8_local10 = Engine.GetParagonIconById(f8_local13)
				f8_local12 = f8_local10
			end
		end
		Engine.SetModelValue(Engine.GetModel(f8_local2, "rankXP"), f8_local4)
		Engine.SetModelValue(Engine.GetModel(f8_local2, "xpEarned"), 0)
		Engine.SetModelValue(Engine.GetModel(f8_local2, "xpNeeded"), f8_local8 - f8_local4)
		Engine.SetModelValue(Engine.GetModel(f8_local2, "currLevel"), f8_local9)
		Engine.SetModelValue(Engine.GetModel(f8_local2, "currLevelIcon"), f8_local10)
		Engine.SetModelValue(Engine.GetModel(f8_local2, "nextLevel"), f8_local11)
		Engine.SetModelValue(Engine.GetModel(f8_local2, "nextLevelIcon"), f8_local12)
	end
	CoD.perController[f8_arg1].UnlockTokenInfo = f8_local1
end
function SetWeaponOptionAsOldInternal(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = f9_arg1:getModel(f9_arg2, "weaponOptionSubIndex")
	local f9_local1 = f9_arg1:getModel(f9_arg2, "weaponOptionType")
	local f9_local2 = f9_arg1:getModel(f9_arg2, "unlockSessionMode")
	if f9_local0 and f9_local1 and f9_local2 then
		local f9_local3 = Engine.GetModelValue(f9_local0)
		local f9_local4 = Engine.GetModelValue(f9_local1)
		local f9_local5 = Engine.GetModelValue(f9_local2)
		if f9_local4 ~= Enum.eWeaponOptionGroup[@"weaponoption_group_paintjob"] and f9_local4 ~= Enum.eWeaponOptionGroup[@"weaponoption_group_invalid"] and f9_local3 > CoD.CACUtility.EmptyItemIndex then
			Engine.SetWeaponOptionAsOld(f9_arg2, f9_arg3, Engine.GetWeaponOptionGroupIndex(f9_local3, f9_local4), f9_local5)
			if f9_arg0.categoryTabs and f9_arg0.categoryTabs.Tabs.grid then
				local f9_local6 = f9_arg0.categoryTabs.Tabs.grid:getItemAt(f9_arg0.categoryTabs.Tabs.grid.savedActiveIndex + 1)
				if f9_local6 then
					local f9_local7 = f9_local6:getModel(f9_arg2, "breadcrumbCount")
					if f9_local7 then
						local f9_local8 = 0
						if f9_local6.filterEnum < Enum.WeaponOptionFilter[@"weaponoption_filter_mode_count"] then
							f9_local8 = Engine.WeaponOptionNewItemCount(f9_arg2, f9_arg3, f9_local4, f9_local6.filterEnum)
						else
							f9_local8 = Engine.WeaponOptionNewModeAgnosticItemCount(f9_arg2, f9_arg3, f9_local4, f9_local6.filterEnum)
						end
						Engine.SetModelValue(f9_local7, f9_local8)
					end
				end
			end
		end
	end
end
function GetCPDifficulty(f10_arg0, f10_arg1)
	local f10_local0 = Engine.GetProfileVarInt(f10_arg0, f10_arg1)
	if f10_local0 ~= 0 then
		return f10_local0 - 1
	else
	end
end
function SetCPDifficulty(f11_arg0, f11_arg1, f11_arg2)
	Engine.SetProfileVar(f11_arg0, f11_arg1, f11_arg2 + 1)
end
function SetHeroCardStateToDefault(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	local f12_local0 = GetListItem(f12_arg1, f12_arg2)
	local f12_local1 = f12_local0.activeWidget
	f12_arg2:setState(f12_arg3, "DefaultState", true)
	if f12_local1 then
		f12_local0:setActiveItem(f12_local1)
	end
end
function SetBrowseMode(f13_arg0)
	CoD.CraftUtility.SetEmblemEditorProperties(f13_arg0, Enum.CustomizationEditorMode[@"customization_editor_mode_browse"], "editorMode")
end
function EmblemEditor_SetScaleMode(f14_arg0, f14_arg1)
	CoD.CraftUtility.SetEmblemEditorProperties(f14_arg0, f14_arg1, "scaleMode")
	Engine[@"emblemsetscalemode"](f14_arg1)
end
function EmblemEditor_SetMaterialScaleMode(f15_arg0, f15_arg1)
	CoD.CraftUtility.SetEmblemEditorProperties(f15_arg0, f15_arg1, "materialScaleMode")
	Engine[@"hash_3BBCA32C957C5A85"](f15_arg1)
end
function EmblemEditor_GetLayerAndGroupIndex(f16_arg0, f16_arg1)
	return Engine.GetModelValue(f16_arg0:getModel(f16_arg1, "layerIndex")) .. " " .. Engine.GetModelValue(f16_arg0:getModel(f16_arg1, "groupIndex"))
end
function EmblemEditor_SetupDrawEmblem(f17_arg0, f17_arg1, f17_arg2)
	f17_arg1.emblemLayer.layerIcon.layerIcon:setupDrawEmblemLayer(GetEmblemLayerAndGroupIndex(f17_arg0, EmblemEditor_GetLayerAndGroupIndex(f17_arg1, f17_arg0)))
	f17_arg2.emblemLayer.layerIcon.layerIcon:setupDrawEmblemLayer(GetEmblemLayerAndGroupIndex(f17_arg0, EmblemEditor_GetLayerAndGroupIndex(f17_arg2, f17_arg0)))
end
function EmblemEditor_SetSelectedLayerIndex(f18_arg0, f18_arg1)
	local f18_local0 = f18_arg1:getModel(f18_arg0, "layerIndex")
	if f18_local0 then
		CoD.perController[f18_arg0].selectedLayerIndex = Engine.GetModelValue(f18_local0)
	end
end
function EmblemEditor_RecordMetrics(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	local f19_local0 = 0
	if f19_arg0.occludedMenu and f19_arg0.occludedMenu.openTime then
		f19_local0 = Engine[@"milliseconds"]() - f19_arg0.occludedMenu.openTime
	end
	CoD.MetricsUtility.EmblemEvent(f19_arg1, f19_local0, Engine.GetEmblemSummaryString(), f19_arg2, f19_arg3)
end
function EmblemChooseColor_SetupSelectedLayerColorModel(f20_arg0)
	local f20_local0 = Engine.GetModelForController(f20_arg0)
	local f20_local1 = Engine.GetSelectedLayerColor(f20_arg0)
	local f20_local2 = CoD.ColorUtility.ConvertColor(f20_local1.red, f20_local1.green, f20_local1.blue)
	local f20_local3 = Engine.GetModel(f20_local0, "Emblem.EmblemSelectedLayerColor")
	Engine.SetModelValue(Engine.GetModel(f20_local3, "color"), f20_local2)
	Engine.SetModelValue(Engine.GetModel(f20_local3, "red"), f20_local1.red * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE)
	Engine.SetModelValue(Engine.GetModel(f20_local3, "green"), f20_local1.green * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE)
	Engine.SetModelValue(Engine.GetModel(f20_local3, "blue"), f20_local1.blue * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE)
	local f20_local4 = Engine.GetSelectedLayerColor1(f20_arg0)
	local f20_local5 = CoD.ColorUtility.ConvertColor(f20_local4.red, f20_local4.green, f20_local4.blue)
	local f20_local6 = Engine.GetModel(f20_local0, "Emblem.EmblemSelectedLayerColor1")
	Engine.SetModelValue(Engine.GetModel(f20_local6, "color"), f20_local5)
	Engine.SetModelValue(Engine.GetModel(f20_local6, "red"), f20_local4.red * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE)
	Engine.SetModelValue(Engine.GetModel(f20_local6, "green"), f20_local4.green * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE)
	Engine.SetModelValue(Engine.GetModel(f20_local6, "blue"), f20_local4.blue * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE)
	CoD.CraftUtility.SetEmblemNoColorDataModel(f20_arg0)
end
function EmblemChooseColor_SetPointerPosition(f21_arg0, f21_arg1)
	local f21_local0, f21_local1 = f21_arg0:getLocalSize()
	local f21_local2 = f21_local0 * f21_arg1
	f21_arg0.pointer:setLeftRight(true, false, f21_local2, f21_local2 + 2)
end
function EmblemChooseColor_SetShaderParams(f22_arg0, f22_arg1)
	local f22_local0 = CoD.CraftUtility.GetSelectedEmblemColor(f22_arg0)
	if f22_local0 ~= nil then
		f22_arg1.redBar.bar:setShaderVector(0, 0, f22_local0.green, f22_local0.blue, 1)
		f22_arg1.redBar.bar:setShaderVector(1, 1, f22_local0.green, f22_local0.blue, 1)
		EmblemChooseColor_SetPointerPosition(f22_arg1.redBar, f22_local0.red)
		f22_arg1.greenBar.bar:setShaderVector(0, f22_local0.red, 0, f22_local0.blue, 1)
		f22_arg1.greenBar.bar:setShaderVector(1, f22_local0.red, 1, f22_local0.blue, 1)
		EmblemChooseColor_SetPointerPosition(f22_arg1.greenBar, f22_local0.green)
		f22_arg1.blueBar.bar:setShaderVector(0, f22_local0.red, f22_local0.green, 0, 1)
		f22_arg1.blueBar.bar:setShaderVector(1, f22_local0.red, f22_local0.green, 1, 1)
		EmblemChooseColor_SetPointerPosition(f22_arg1.blueBar, f22_local0.blue)
	end
end
function EmblemChooseColor_GetColorMixerElement(f23_arg0, f23_arg1, f23_arg2)
	if CoD.CraftUtility.GetEmblemEditorProperties(f23_arg1, "isGradientMode") == 0 then
		return f23_arg2.colorMixerContainer.colorMixer
	else
		return f23_arg2.colorGradientMixerContainer.colorMixer
	end
end
function EmblemChooseColor_GetGradientSliderElement(f24_arg0, f24_arg1)
	return f24_arg1.colorGradientContainer.gradientSlider
end
function EmblemChooseColor_ModifyColorModelValue(f25_arg0, f25_arg1)
	Engine.SetModelValue(f25_arg0, CoD.ColorUtility.ClampColor(Engine.GetModelValue(f25_arg0) + f25_arg1, 0, 255))
end
function EmblemChooseColor_SetColorModelValue(f26_arg0, f26_arg1)
	Engine.SetModelValue(f26_arg0, CoD.ColorUtility.ClampColor(f26_arg1, 0, 255))
end
function EmblemChooseColor_SetLayerColor(f27_arg0, f27_arg1)
	local f27_local0 = Engine.GetModelValue(f27_arg0:getModel(f27_arg1, "red"))
	local f27_local1 = Engine.GetModelValue(f27_arg0:getModel(f27_arg1, "green"))
	local f27_local2 = Engine.GetModelValue(f27_arg0:getModel(f27_arg1, "blue"))
	local f27_local3 = 1 / CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE
	Engine[@"emblemsetlayercolor"](CoD.CraftUtility.GetEmblemEditorProperties(f27_arg1, "colorNum"), f27_local0 * f27_local3, f27_local1 * f27_local3, f27_local2 * f27_local3)
end
function EmblemChooseColor_SetPreviewColorModel(f28_arg0, f28_arg1)
	local f28_local0 = Engine.GetModelForController(f28_arg1)
	local f28_local1 = CoD.CraftUtility.GetSelectedEmblemColor(f28_arg1)
	if f28_local1 ~= nil then
		Engine.SetModelValue(f28_arg0:getModel(f28_arg1, "color"), CoD.ColorUtility.ConvertColor(f28_local1.red, f28_local1.green, f28_local1.blue))
	end
end
function EmblemChooseColor_SetBarProperties(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
	EmblemChooseColor_SetLayerColor(f29_arg1, f29_arg3)
	EmblemChooseColor_SetPreviewColorModel(f29_arg1, f29_arg3)
	EmblemChooseColor_SetShaderParams(f29_arg3, f29_arg0)
end
function EmblemGradient_SetupSwatchLastSavedColor(f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = DataSources.EmblemSelectedLayerEdittingColor.getModel(f30_arg2)
	f30_arg1.colorGradientSwatchContainer:setModel(f30_local0, f30_arg2)
	f30_arg1.colorGradientMixerContainer.colorMixer:setModel(f30_local0, f30_arg2)
end
function EmblemGradient_UpdateGradientVisuals(f31_arg0, f31_arg1)
	local f31_local0 = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f31_arg0), "Emblem.EmblemSelectedLayerProperties.gradient_fill")) / CoD.CraftUtility.EMBLEM_MAX_GRADIENT_SLIDER_VALUE
	local f31_local1 = Engine.GetSelectedLayerColor(f31_arg0)
	local f31_local2 = Engine.GetSelectedLayerColor1(f31_arg0)
	EmblemChooseColor_SetPointerPosition(f31_arg1, f31_local0)
	if f31_local1 ~= nil and f31_local2 ~= nil then
		f31_arg1.bar:setShaderVector(0, f31_local1.red, f31_local1.green, f31_local1.blue, f31_local1.alpha)
		f31_arg1.bar:setShaderVector(1, f31_local2.red, f31_local2.green, f31_local2.blue, f31_local2.alpha)
		f31_arg1.bar:setShaderVector(2, f31_local0, 0, 0, 0)
	end
end
function EmblemGradient_UpdateSliderVisuals(f32_arg0, f32_arg1, f32_arg2)
	EmblemChooseColor_SetPointerPosition(f32_arg1, f32_arg2)
	f32_arg1.bar:setShaderVector(0, 0.01, 0.01, 0.01, 1)
	f32_arg1.bar:setShaderVector(1, 0.01, 0.01, 0.01, 1)
	f32_arg1.bar:setShaderVector(2, f32_arg2, 0, 0, 0)
end
function PaintJobEditor_RecordMetrics(f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4, f33_arg5)
	local f33_local0 = 0
	if f33_arg0.occludedMenu and f33_arg0.occludedMenu.openTime then
		f33_local0 = Engine[@"milliseconds"]() - f33_arg0.occludedMenu.openTime
	end
	CoD.MetricsUtility.PaintshopEvent(f33_arg1, f33_arg3, f33_local0, Engine.GetModelValue(Engine.GetModel(f33_arg2, "weaponIndex")), Engine.GetModelValue(Engine.GetModel(f33_arg2, "paintjobName")), Engine.GetPaintshopSummaryString(), f33_arg4, f33_arg5)
end
function SetGroupsNotifyInformation(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
	local f34_local0 = Engine.GetModelForController(f34_arg0)
	Engine.SetModelValue(Engine.GetModel(f34_local0, "groups.notificationTitle"), f34_arg1)
	Engine.SetModelValue(Engine.GetModel(f34_local0, "groups.notificationMessage"), f34_arg2)
	Engine.SetModelValue(Engine.GetModel(f34_local0, "groups.notificationError"), f34_arg3)
end
function ValidateCreateGroupInformation(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = Engine.GetModelForController(f35_arg2)
	local f35_local1 = Engine.GetModelValue(Engine.GetModel(f35_local0, "groups.createGroup.name"))
	local f35_local2 = Engine.GetModelValue(Engine.GetModel(f35_local0, "groups.createGroup.description"))
	if f35_local1 == "" then
		OpenGenericSmallPopup(f35_arg0, f35_arg2, "groups/missing_group_name_title", "groups/missing_group_name_text", nil, @"menu/ok")
		return false
	else
		return true
	end
end
function Gunsmith_ClearItemName(f36_arg0)
	Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f36_arg0), "Gunsmith.GunsmithSelectedItemProperties.itemName"), "")
end
function Store_UpdatePSStoreIconCount(f37_arg0, f37_arg1)
	if CoD.perController[f37_arg0].psStoreIconCount == nil then
		CoD.perController[f37_arg0].psStoreIconCount = 0
	end
	CoD.perController[f37_arg0].psStoreIconCount = math.max(CoD.perController[f37_arg0].psStoreIconCount + f37_arg1, 0)
end
function SetEmblemBackground_Internal(f38_arg0, f38_arg1)
	CoD.LobbyUtility.SetEmblemBackground_Internal(f38_arg0, f38_arg1)
end
function IsCursorInsideAny(f39_arg0, f39_arg1, f39_arg2)
	for f39_local3, f39_local4 in ipairs(f39_arg1) do
		if f39_local4:IsMouseEventInsideElement(f39_arg2) then
			return true
		end
	end
	return false
end
