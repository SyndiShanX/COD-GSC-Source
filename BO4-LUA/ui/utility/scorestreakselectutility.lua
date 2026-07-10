CoD.ScorestreakSelectUtility = {}
DataSources.ScorestreaksList = ListHelper_SetupDataSource("ScorestreaksList", function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = {}
	local f1_local1 = function(f2_arg0, f2_arg1)
		return f2_arg0.models.scoreToUnlock < f2_arg1.models.scoreToUnlock
	end
	local f1_local2 = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	for f1_local7, f1_local8 in pairs(Engine[0xCE5D53FB879DE17]("killstreak", f1_local2)) do
		local f1_local9 = CoD.CACUtility.GetUnlockableItemInfo(f1_local8, f1_local2)
		if f1_local9[0x32A46624FFC3379] ~= 1 then
			local f1_local6 = CoD.ScorestreakSelectUtility.BuildItemModelDataFromUnlockableItem(f1_arg0, f1_local9)
			if f1_local6 and f1_local6.models and not f1_local6.models.isRestricted then
				table.insert(f1_local0, f1_local6)
			end
		end
	end
	table.sort(f1_local0, f1_local1)
	return f1_local0
end)
DataSources.EquippedScorestreaks = ListHelper_SetupDataSource("EquippedScorestreaks", function(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = {}
	local f3_local1 = function(f4_arg0, f4_arg1)
		if f4_arg0.models.itemIndex == CoD.CACUtility.EmptyItemIndex then
			return true
		elseif f4_arg1.models.itemIndex == CoD.CACUtility.EmptyItemIndex then
			return false
		else
			return f4_arg1.models.scoreToUnlock < f4_arg0.models.scoreToUnlock
		end
	end
	local f3_local2 = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5)
		table.insert(f3_local0, {
			models = {
				name = f5_arg0,
				itemIndex = f5_arg1,
				icon = f5_arg2,
				scoreToUnlock = f5_arg3,
				equipSound = f5_arg4,
				unequipSound = f5_arg5,
				isRestricted = CoD.CACUtility.IsItemIndexRestricted(f5_arg1),
			},
		})
	end
	local f3_local3 = CoD.BaseUtility.GetMenuSessionMode(f3_arg1.menu)
	local f3_local4 = Engine[0xFC41172469DB251](f3_arg0, f3_local3)
	for f3_local9, f3_local10 in ipairs(CoD.CACUtility.SelectableKillstreakNameList) do
		local f3_local11 = f3_local4[f3_local10]:get()
		if f3_local11 and f3_local11 ~= CoD.CACUtility.EmptyItemIndex then
			local f3_local8 = CoD.CACUtility.GetUnlockableItemInfo(f3_local11, f3_local3)
			f3_local2(f3_local8.displayName, f3_local11, CoD.CACUtility.GetPreviewImageLarge(f3_local3, f3_local8), f3_local8.scoreToUnlock, f3_local8[0x87F8E9A3DEB31D2], f3_local8[0xB608E98BF6A8991])
		else
			f3_local2(0x0, CoD.CACUtility.EmptyItemIndex, RegisterImage(0x7615068F50B3D66), 0, nil, nil)
		end
	end
	table.sort(f3_local0, f3_local1)
	return f3_local0
end)
CoD.ScorestreakSelectUtility.BuildItemModelDataFromUnlockableItem = function(f6_arg0, f6_arg1)
	local f6_local0 = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	return {
		models = {
			name = f6_arg1.displayName,
			itemIndex = f6_arg1.globalItemIndex,
			icon = CoD.CACUtility.GetPreviewImage(f6_local0, f6_arg1),
			iconLarge = CoD.CACUtility.GetPreviewImageLarge(f6_local0, f6_arg1),
			scoreToUnlock = f6_arg1.scoreToUnlock,
			lowScoreToUnlock = f6_arg1.lowestScoreToUnlockAllowed,
			desc = f6_arg1.description,
			equipSound = f6_arg1[0x87F8E9A3DEB31D2],
			unequipSound = f6_arg1[0xB608E98BF6A8991],
			isRestricted = CoD.CACUtility.IsItemIndexRestricted(f6_arg1.globalItemIndex),
		},
		properties = {
			selectIndex = CoD.ScorestreakSelectUtility.GetScorestreakEquipSlot(f6_arg0, f6_arg1.globalItemIndex, f6_local0) ~= nil,
		},
	}
end
CoD.ScorestreakSelectUtility.UpdateEquippedList = function(f7_arg0)
	ForceNotifyModel(f7_arg0, "ScorestreakSelect.UpdateEquipped")
end
CoD.ScorestreakSelectUtility.UpdateOptionsList = function(f8_arg0)
	ForceNotifyModel(f8_arg0, "ScorestreakSelect.UpdateOptions")
end
CoD.ScorestreakSelectUtility.GetScorestreakEquipSlot = function(f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = Engine[0xFC41172469DB251](f9_arg0, f9_arg2)
	for f9_local4, f9_local5 in ipairs(CoD.CACUtility.SelectableKillstreakNameList) do
		if f9_local0[f9_local5]:get() == f9_arg1 then
			return f9_local5
		end
	end
	return nil
end
CoD.ScorestreakSelectUtility.GetEquippedItemIndexForScorestreakSlot = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = Engine[0xFC41172469DB251](f10_arg0, f10_arg2)
	if f10_local0[f10_arg1] then
		return f10_local0[f10_arg1]:get()
	else
		return CoD.CACUtility.EmptyItemIndex
	end
end
CoD.ScorestreakSelectUtility.GetEquippedScorestreaksItemIndexTable = function(f11_arg0)
	local f11_local0 = Engine[0xED2C19E68ED0E2C](f11_arg0, 0)
	local f11_local1 = {}
	for f11_local5, f11_local6 in pairs(f11_local0) do
		if LUI.startswith(f11_local5, "killStreak") then
			f11_local1[f11_local5] = f11_local6
		end
	end
	return f11_local1
end
CoD.ScorestreakSelectUtility.EquipScorestreak = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	local f12_local0 = Engine[0xFC41172469DB251](f12_arg0, f12_arg3)
	if f12_local0[f12_arg1] then
		return f12_local0[f12_arg1]:set(f12_arg2)
	else
	end
end
CoD.ScorestreakSelectUtility.SortScoretreaksByCost = function(f13_arg0, f13_arg1)
	local f13_local0 = Engine[0xFC41172469DB251](f13_arg0, f13_arg1)
	local f13_local1 = function(f14_arg0, f14_arg1)
		if f14_arg0 == CoD.CACUtility.EmptyItemIndex then
			return true
		elseif f14_arg1 == CoD.CACUtility.EmptyItemIndex then
			return false
		else
			local f14_local0 = CoD.CACUtility.GetUnlockableItemInfo(f14_arg0, f13_arg1)
			f14_local0 = f14_local0.scoreToUnlock
			local f14_local1 = CoD.CACUtility.GetUnlockableItemInfo(f14_arg1, f13_arg1)
			return f14_local0 < f14_local1.scoreToUnlock
		end
	end
	local f13_local2 = {}
	for f13_local6, f13_local7 in ipairs(CoD.CACUtility.SelectableKillstreakNameList) do
		if f13_local0[f13_local7]:get() ~= CoD.CACUtility.EmptyItemIndex then
			f13_local2[f13_local6] = f13_local0[f13_local7]:get()
		end
	end
	table.sort(f13_local2, f13_local1)
	for f13_local6, f13_local7 in ipairs(CoD.CACUtility.SelectableKillstreakNameList) do
		if f13_local0[f13_local7]:get() ~= CoD.CACUtility.EmptyItemIndex then
			f13_local0[f13_local7]:set(f13_local2[f13_local6])
		end
	end
end
CoD.ScorestreakSelectUtility.SaveLoadout = function(f15_arg0, f15_arg1)
	local f15_local0 = CoD.BaseUtility.GetMenuSessionMode(f15_arg0)
	if not f15_local0 then
		f15_local0 = Engine[0x3EAC408F958FF05]()
	end
	Engine[0xE6C09FDF6C8D188](f15_arg1, f15_local0)
end
CoD.ScorestreakSelectUtility.SelectScorestreakOption = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
	local f16_local0 = CoD.BaseUtility.GetMenuSessionMode(f16_arg1)
	local f16_local1 = f16_arg0:getModel()
	local f16_local2 = f16_local1.itemIndex:get()
	if CoD.ScorestreakSelectUtility.GetScorestreakEquipSlot(f16_arg2, f16_local2, f16_local0) == nil then
		local f16_local3 = CoD.ScorestreakSelectUtility.GetScorestreakEquipSlot(f16_arg2, CoD.CACUtility.EmptyItemIndex, f16_local0)
		if f16_local3 then
			CoD.ScorestreakSelectUtility.EquipScorestreak(f16_arg2, f16_local3, f16_local2, f16_local0)
			CoD.ScorestreakSelectUtility.SortScoretreaksByCost(f16_arg2, f16_local0)
			CoD.ScorestreakSelectUtility.UpdateEquippedList(f16_arg2)
			local f16_local4 = f16_local1.equipSound:get()
			if f16_local4 and f16_local4 ~= 0x0 then
				Engine[0x98954175CA6A32C](f16_local4)
			end
		else
			f16_arg1:saveState(f16_arg2)
			OpenPopup(f16_arg1, "ScorestreakOverCapacity", f16_arg2, {
				_sessionMode = f16_arg1._sessionMode,
				_model = f16_local1,
			})
		end
	end
end
CoD.ScorestreakSelectUtility.RemoveScorestreakOption = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.BaseUtility.GetMenuSessionMode(f17_arg1)
	local f17_local1 = f17_arg0:getModel()
	local f17_local2 = CoD.ScorestreakSelectUtility.GetScorestreakEquipSlot(f17_arg2, f17_local1.itemIndex:get(), f17_local0)
	if f17_local2 then
		CoD.ScorestreakSelectUtility.EquipScorestreak(f17_arg2, f17_local2, CoD.CACUtility.EmptyItemIndex, f17_local0)
		CoD.ScorestreakSelectUtility.UpdateEquippedList(f17_arg2)
		local f17_local3 = f17_local1.unequipSound:get()
		if f17_local3 and f17_local3 ~= 0x0 then
			Engine[0x98954175CA6A32C](f17_local3)
		end
	end
end
CoD.ScorestreakSelectUtility.RemoveAllScorestreaks = function(f18_arg0, f18_arg1)
	local f18_local0 = CoD.BaseUtility.GetMenuSessionMode(f18_arg0)
	for f18_local4, f18_local5 in ipairs(CoD.CACUtility.SelectableKillstreakNameList) do
		CoD.ScorestreakSelectUtility.EquipScorestreak(f18_arg1, f18_local5, CoD.CACUtility.EmptyItemIndex, f18_local0)
	end
	CoD.ScorestreakSelectUtility.UpdateEquippedList(f18_arg1)
	f18_arg0:playSound("equip_item")
end
CoD.ScorestreakSelectUtility.SwapScorestreaks = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = CoD.BaseUtility.GetMenuSessionMode(f19_arg2)
	local f19_local1 = f19_arg0:getModel()
	local f19_local2 = f19_local1.itemIndex
	if f19_local2 then
		f19_local2 = f19_local1.itemIndex:get()
	end
	local f19_local3 = CoD.BaseUtility.GetMenuModel(f19_arg2)
	local f19_local4 = f19_local3
	local f19_local5 = f19_local3.itemIndex
	if f19_local5 then
		f19_local5 = f19_local4 and f19_local3.itemIndex:get()
	end
	if f19_local2 and f19_local5 then
		local f19_local6 = CoD.ScorestreakSelectUtility.GetScorestreakEquipSlot(f19_arg1, f19_local2, f19_local0)
		if f19_local6 then
			CoD.ScorestreakSelectUtility.EquipScorestreak(f19_arg1, f19_local6, f19_local5, f19_local0)
			CoD.ScorestreakSelectUtility.SortScoretreaksByCost(f19_arg1, f19_local0)
			CoD.ScorestreakSelectUtility.UpdateEquippedList(f19_arg1)
			local f19_local7 = f19_local1.equipSound:get()
			if f19_local7 ~= 0x0 then
				Engine[0x98954175CA6A32C](f19_local7)
			end
		end
	end
end
CoD.ScorestreakSelectUtility.InitScorestreakSelectModels = function(f20_arg0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f20_arg0, "ScorestreakSelect.UpdateEquipped", 0)
end
CoD.ScorestreakSelectUtility.IsScorestreakLocked = function(f21_arg0, f21_arg1, f21_arg2)
	local f21_local0 = CoD.BaseUtility.GetMenuSessionMode(f21_arg1)
	if not CoD.CACUtility.IsProgressionEnabled(f21_local0) then
		return false
	else
		local f21_local1 = f21_arg0:getModel()
		local f21_local2 = f21_local1 and f21_local1.itemIndex:get()
		return f21_local2 and Engine[0x191C1637A229078](f21_arg2, f21_local2, f21_local0)
	end
end
CoD.ScorestreakSelectUtility.IsScorestreakEquipped = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = CoD.BaseUtility.GetMenuSessionMode(f22_arg1)
	local f22_local1 = f22_arg0:getModel()
	return CoD.ScorestreakSelectUtility.GetScorestreakEquipSlot(f22_arg2, f22_local1 and f22_local1.itemIndex:get(), f22_local0) ~= nil
end
CoD.ScorestreakSelectUtility.GetMaxAllowedScorestreaks = function()
	return #CoD.CACUtility.KillstreakNameList
end
CoD.ScorestreakSelectUtility.IsLoadoutSlotValid = function()
	return true
end
CoD.ScorestreakSelectUtility.GetEquippedItemIndexForPreview = function(f25_arg0, f25_arg1)
	local f25_local0 = CoD.BaseUtility.GetMenuSessionMode(f25_arg0)
	local f25_local1 = CoD.ScorestreakSelectUtility.GetEquippedItemIndexForScorestreakSlot(f25_arg1, "killstreak1", f25_local0)
	if f25_local1 == CoD.CACUtility.EmptyItemIndex then
		f25_local1 = CoD.ScorestreakSelectUtility.GetEquippedItemIndexForScorestreakSlot(f25_arg1, "killstreak2", f25_local0)
		if f25_local1 == CoD.CACUtility.EmptyItemIndex then
			f25_local1 = CoD.ScorestreakSelectUtility.GetEquippedItemIndexForScorestreakSlot(f25_arg1, "killstreak3", f25_local0)
		end
	end
	return f25_local1
end
CoD.ScorestreakSelectUtility.UseEquippedItemAsDefaultFocus = function(f26_arg0, f26_arg1, f26_arg2)
	f26_arg2.__defaultFocus = function()
		local f27_local0 = nil
		local f27_local1 = CoD.ScorestreakSelectUtility.GetEquippedItemIndexForPreview(f26_arg0, f26_arg1)
		if CoD.CACUtility.EmptyItemIndex < f27_local1 then
			f27_local0 = f26_arg2:findItem({
				itemIndex = f27_local1,
			}, nil, false, nil)
		end
		if not f27_local0 then
			f27_local0 = f26_arg2:getFirstSelectableItem(false)
		end
		return f27_local0
	end
end
CoD.ScorestreakSelectUtility.SetCurrentPreviewToSelectedScorestreak = function(f28_arg0, f28_arg1, f28_arg2)
	local f28_local0 = CoD.BaseUtility.GetMenuSessionMode(f28_arg1)
	local f28_local1 = CoD.ScorestreakSelectUtility.GetEquippedItemIndexForPreview(f28_arg1, f28_arg2)
	local f28_local2 = nil
	if CoD.CACUtility.EmptyItemIndex < f28_local1 then
		f28_local2 = f28_arg0:findItem({
			itemIndex = f28_local1,
		}, nil, false, nil)
	end
	if f28_local2 or CoD.isPC and not IsKeyboard(f28_arg2) then
		f28_arg0:setActiveItem(f28_local2)
		if not f28_local2 and CoD.isPC then
			local f28_local3 = CoD.ScorestreakSelectUtility.BuildItemModelDataFromUnlockableItem(f28_arg2, CoD.CACUtility.GetUnlockableItemInfo(CoD.CACUtility.EmptyItemIndex, f28_local0))
			local f28_local4 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f28_arg2), "ScorestreakEquippedItem")
			LuaUtils.CreateModelsFromTable(f28_local4, f28_local3.models)
			f28_arg0:setModel(f28_local4, f28_arg2)
		end
	else
		f28_arg0:getFirstSelectableItem(true)
	end
end
CoD.ScorestreakSelectUtility.BlankTextIfNoScorestreakEquipped = function(f29_arg0)
	if f29_arg0 == 0 then
		return 0x0
	else
		return 0x8A0D0BE7383EC9
	end
end
CoD.ScorestreakSelectUtility.ScorestreakPreLoad = function(f30_arg0, f30_arg1)
	local f30_local0 = "KillstreakRewardsList"
	if DataSources[f30_local0] == nil then
		DataSources[f30_local0] = {
			getCount = function(f31_arg0)
				return CoD.ScorestreakSelectUtility.GetMaxAllowedScorestreaks()
			end,
			getItem = function(f32_arg0, f32_arg1, f32_arg2)
				local f32_local0 = CoD.ScorestreakSelectUtility.GetMaxAllowedScorestreaks() - f32_arg2
				local f32_local1 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f32_arg0), "killstreaks.killstreak" .. f32_local0)
				if not f32_local1.arrowState then
					local f32_local2 = f32_local1:create("arrowState")
					f32_local2:set(CoD.ScorestreakInGameUtility.ArrowState.NONE)
				end
				if not f32_local1.bindingKBM then
					local f32_local2 = f32_local1:create("bindingKBM")
					f32_local2:set("[{scorestreak" .. f32_local0 + 1 .. "}]")
				end
				return f32_local1
			end,
			prepare = function() end,
			getWidgetTypeForItem = function(f34_arg0, f34_arg1, f34_arg2)
				if f34_arg2 == 1 then
					return CoD.Support_ExtraButton
				else
					return nil
				end
			end,
		}
	end
	local f30_local1 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f30_arg1), "killstreaks")
	local f30_local2 = Engine[0xA798E4552F5E872](f30_local1, "targetMomentum")
	local f30_local3 = Engine[0xA798E4552F5E872](f30_local1, "momentumPercentage")
	local f30_local4 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f30_arg1), "rewardMomentum")
	if DataSources.KillstreakRewards == nil then
		DataSources.KillstreakRewards = {
			getModel = function(f35_arg0)
				return Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f35_arg0), "killstreaks")
			end,
		}
	end
	local f30_local5 = Engine[0x40E824FE270E174](f30_local1, "killstreak0.momentumCost")
	if f30_local5 == nil then
		f30_local5 = Engine[0xA798E4552F5E872](f30_local1, "killstreak0.momentumCost")
	end
	local f30_local6 = 0
	if Engine[0x614D394F6F9A18D](f30_local5) == nil or Engine[0x614D394F6F9A18D](f30_local5) == 0 then
		f30_arg0:subscribeToModel(f30_local5, function(model)
			local f36_local0 = Engine[0x614D394F6F9A18D](model)
			if f36_local0 ~= nil and Engine[0x614D394F6F9A18D](f30_local4) < f36_local0 then
				f30_local6 = f36_local0
				Engine[0x83C9B5DE1D9371](f30_local2, f36_local0)
			end
		end)
	else
		f30_local6 = Engine[0x614D394F6F9A18D](f30_local5)
		Engine[0x83C9B5DE1D9371](f30_local2, f30_local6 or 0)
	end
	f30_arg0:subscribeToModel(f30_local4, function(model)
		local f37_local0 = Engine[0x614D394F6F9A18D](model)
		if f37_local0 ~= nil then
			local f37_local1 = 0
			if f30_arg0.timer ~= nil then
				f30_arg0.timer:close()
				f30_arg0.timer = nil
			end
			local f37_local2 = CoD.ScorestreakSelectUtility.GetMaxAllowedScorestreaks()
			for f37_local3 = 0, f37_local2 - 1, 1 do
				local f37_local6 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f30_arg1), "killstreaks.killstreak" .. f37_local3 .. ".momentumCost")
				local f37_local7 = Engine[0x614D394F6F9A18D](f37_local6)
				if f37_local6 and f37_local7 and f37_local0 < f37_local7 then
					if f30_local6 ~= f37_local7 and Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f30_arg1), "killstreaks.killstreak" .. f37_local3 + f37_local2 - 1 % f37_local2 .. ".rewardAmmo")) ~= 0 then
					else
						Engine[0x83C9B5DE1D9371](f30_local2, f37_local7 - f37_local0)
						Engine[0x83C9B5DE1D9371](f30_local3, (f37_local0 - f37_local1) / (f37_local7 - f37_local1))
					end
					f30_local6 = f37_local7
					Engine[0x83C9B5DE1D9371](f30_local3, 1)
					Engine[0x83C9B5DE1D9371](f30_local2, 0)
					f30_arg0:registerEventHandler("time_up", function(element, event)
						Engine[0x83C9B5DE1D9371](f30_local3, (f37_local0 - f37_local1) / (f37_local7 - f37_local1))
						Engine[0x83C9B5DE1D9371](f30_local2, f37_local7 - f37_local0)
					end)
					f30_arg0.timer = LUI.UITimer.new(1000, "time_up", true)
					f30_arg0:addElement(f30_arg0.timer)
				end
				f37_local1 = f37_local7
			end
		end
	end)
end
CoD.ScorestreakSelectUtility.ScorestreakMeterPostLoad = function(f39_arg0, f39_arg1)
	local f39_local0 = 0
	local f39_local1, f39_local2, f39_local3, f39_local4 = f39_arg0.CombatEfficiencyPulse:getLocalTopBottom()
	local f39_local5, f39_local6, f39_local7, f39_local8 = f39_arg0:getLocalTopBottom()
	local f39_local9, f39_local10, f39_local11, f39_local12 = f39_arg0.FocusMeterFillWhite:getLocalTopBottom()
	local f39_local13 = f39_local8 + f39_local4 - f39_local3
	f39_arg0.CombatEfficiencyPulse:setTopBottom(true, true, f39_local3 + f39_local13, f39_local4)
	f39_arg0.Fill:setShaderVector(2, 0, 0, 0, 0)
	f39_arg0.FocusMeterFill:setShaderVector(2, 0, 0, 0, 0)
	f39_arg0.Fill:subscribeToGlobalModel(f39_arg1, "KillstreakRewards", "momentumPercentage", function(model)
		local f40_local0 = Engine[0x614D394F6F9A18D](model)
		if f40_local0 ~= nil then
			if f40_local0 < f39_local0 then
				f39_arg0.Fill:setShaderVector(2, 0, 0, 0, 0)
				f39_arg0.FocusMeterFill:setShaderVector(2, 0, 0, 0, 0)
				f39_arg0.CombatEfficiencyPulse:setTopBottom(true, true, f39_local3 + f39_local13, f39_local4)
				f39_arg0.FocusMeterFillWhite:setTopBottom(false, false, f39_local8 / 2 - f39_local8 + 4, f39_local8 / 2 - f39_local8 - 4)
			end
			if IsSpecificGadgetInUse(f39_arg1, f39_arg0, "gadget_combat_efficiency") then
				f39_arg0.CombatEfficiencyPulse:playClip("ScoreAdded")
				f39_arg0.FocusMeterFillWhite:playClip("ScoreAdded")
			end
			f39_arg0.CombatEfficiencyPulse:completeAnimation()
			f39_arg0.CombatEfficiencyPulse:setTopBottom(true, true, f39_local3 + f39_local13 * (1 - f39_local0), f39_local4)
			f39_arg0.CombatEfficiencyPulse:beginAnimation("keyframe", 150, false, true, CoD.TweenType.Linear)
			f39_arg0.CombatEfficiencyPulse:setTopBottom(true, true, f39_local3 + f39_local13 * (1 - f40_local0), f39_local4)
			f39_arg0.FocusMeterFillWhite:beginAnimation("keyframe", 150, false, true, CoD.TweenType.Linear)
			local f40_local1 = f39_local8 / 2 - f39_local8 * f40_local0
			f39_arg0.FocusMeterFillWhite:setTopBottom(false, false, f40_local1 + 4, f40_local1 - 4)
			f39_arg0.Fill:beginAnimation("keyframe", 150, false, true, CoD.TweenType.Linear)
			f39_arg0.Fill:setShaderVector(2, f40_local0, 0, 0, 0)
			f39_arg0.FocusMeterFill:beginAnimation("keyframe", 150, false, true, CoD.TweenType.Linear)
			f39_arg0.FocusMeterFill:setShaderVector(2, f40_local0, 0, 0, 0)
			f39_local0 = f40_local0
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(f39_arg0, "close", function()
		f39_arg0.Fill:close()
	end)
end
