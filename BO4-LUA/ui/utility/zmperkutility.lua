require("x64:d90671b853a008e")
CoD.ZMPerkUtility = {}
CoD.ZMPerkUtility.PerkVaporCount = 4
CoD.ZMPerkUtility.ExtraPerkVaporCount = 9
CoD.ZMPerkUtility.PerkSlotNameList = CoD.CACUtility.CreateList("specialty.", 1, CoD.ZMPerkUtility.PerkVaporCount)
CoD.ZMPerkUtility.PerkVaporStates = LuaEnum.createEnum("DEFAULT", "CONSUMED", "COOLING_DOWN", "HIDDEN")
CoD.ZMPerkUtility.PerkVaporAltarNamesPerStory = {
	{
		0x73FDE36F4E19E34,
		0xD3F294208202CC1,
		0x8BC38BA30AECE69,
		0x58E91856722D715,
	},
	{
		0x711D749394A9FFA,
		0x8BBD5E2E6D62625,
		0x401D8F5C70A363D,
		0x4F221A25F8163F8,
	},
}
CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash = {
	[0x259449C59FA169F] = {
		0xA827056D0E273FD,
	},
	[0x9FCF7D746EDEEAF] = {
		0xE9FB2463E6EEE58,
	},
	[0x3548DB163B3A77E] = {
		0xD2A55A87F693582,
	},
	[0xB6804AAAAD14FA1] = {
		0xA15DDCC25D689F6,
	},
	[0x82D5139616F522B] = {
		0x7C5CC2D9B6CA16C,
	},
	[0xE58FF2DF5BFD9B3] = {
		0x31B19618CA4F41,
	},
	[0x52086E4C25A6FE4] = {
		0x690C4DCC61973EC,
	},
	[0xD1DFB82EBCBDB7D] = {
		0xDD9D538CA5BC2D6,
	},
	[0x47297C33B115641] = {
		0x6407356B81A1957,
	},
	[0x20C7FD6609F0966] = {
		0xBDFB5736AD174A3,
	},
	[0xF9EF78EFDDF61F] = {
		0x57E3EDD7FE168C3,
	},
	[0x8C176152188E03F] = {
		0x347FF402123307A,
	},
	[0x3E46074D37D524B] = {
		0x2B9D6529500B72,
	},
	[0x952E08594E632F7] = {
		0x79AE09979E80714,
	},
	[0x2C03EB685B6FE1B] = {
		0x16DB8C2D7FCACFB,
		0x635890F53E8633D,
	},
	[0xFAC30B31B5BEC64] = {
		0x9C28F0B2A623FA5,
	},
	[0x334F2C7E1B57493] = {
		0x75EC38C3F3487D5,
	},
	[0x73D5CE33DD7CDE9] = {
		0x44B157A9FA6573D,
	},
}
DataSources.BleedoutPerkVapors = DataSourceHelpers.CustomListSetup("BleedoutPerkVapors", function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	CoD.CACUtility.GetCustomClassModel(f1_arg1, Engine[0xD2B2D1965173543](f1_arg1), f1_arg2:create("classModel"), nil, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
	local f1_local0 = function(f2_arg0, f2_arg1)
		return f2_arg0.orderIndex < f2_arg1.orderIndex
	end
	for f1_local1 = 0, CoD.ZMPerkUtility.PerkVaporCount - 1, 1 do
		local f1_local4 = DataSources.HUDItems.getModel(f1_arg1)
		f1_local4 = f1_local4:create("perkVapor." .. f1_local1)
		local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
		f1_local5 = f1_local5:create("perkVapor." .. f1_local1)
		if not f1_local4.bleedoutOrderIndex then
			local f1_local6 = f1_local4:create("bleedoutOrderIndex")
			f1_local6:set(0)
		end
		local f1_local6 = f1_local4.bleedoutOrderIndex:get()
		local f1_local7 = f1_local4:create("bleedoutProgress")
		f1_local7:set(1)
		f1_local7 = f1_local4:create("isFirst")
		f1_local7:set(false)
		table.insert(f1_arg3, {
			model = f1_local4,
			orderIndex = f1_local6,
		})
	end
	table.sort(f1_arg3, f1_local0)
	if f1_arg3[1] then
		f1_arg3[1].model.isFirst:set(true)
	end
end)
CoD.ZMPerkUtility.SubscribeForBleedoutPerkModelUpdate = function(f3_arg0, f3_arg1)
	local f3_local0 = DataSources.HUDItems.getModel(f3_arg1)
	f3_local0 = f3_local0:create("perkVapor")
	local f3_local1 = f3_local0:create("bleedoutProgress")
	f3_arg0:subscribeToModel(f3_local1, function()
		local f4_local0 = f3_local1:get()
		if f4_local0 then
			local f4_local1 = {}
			for f4_local2 = 0, CoD.ZMPerkUtility.PerkVaporCount - 1, 1 do
				local f4_local5 = f3_local0:create("" .. f4_local2)
				if not f4_local5.bleedoutOrderIndex then
					local f4_local6 = f4_local5:create("bleedoutOrderIndex")
					f4_local6:set(0)
				end
				table.insert(f4_local1, {
					model = f4_local5,
					orderIndex = f4_local5.bleedoutOrderIndex:get(),
				})
			end
			table.sort(f4_local1, function(f5_arg0, f5_arg1)
				return f5_arg0.orderIndex < f5_arg1.orderIndex
			end)
			for f4_local3 = 0, CoD.ZMPerkUtility.PerkVaporCount - 1, 1 do
				local f4_local6 = f4_local1[f4_local3 + 1].model
				local f4_local8 = f4_local3 / CoD.ZMPerkUtility.PerkVaporCount
				local f4_local9 = (f4_local3 + 1) / CoD.ZMPerkUtility.PerkVaporCount
				local f4_local10 = nil
				if f4_local9 <= f4_local0 then
					f4_local10 = 1
				elseif f4_local0 <= f4_local8 then
					f4_local10 = 0
				else
					f4_local10 = (f4_local0 - f4_local8) * CoD.ZMPerkUtility.PerkVaporCount
				end
				local f4_local11 = f4_local6:create("bleedoutProgress")
				f4_local11:set(f4_local10)
			end
		end
	end, false)
end
CoD.ZMPerkUtility.CustomListSetupForPerkChargesList = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5)
	local f6_local0 = DataSources.HUDItems.getModel(f6_arg1)
	local f6_local1 = false
	local f6_local2 = nil
	for f6_local3 = 0, CoD.ZMPerkUtility.PerkVaporCount - 1, 1 do
		local f6_local6 = f6_local0:create("perkVapor." .. f6_local3)
		f6_local2 = f6_local6:create("chargeCount")
		if not f6_local2:get() then
			f6_local2:set(0)
		end
		local f6_local7 = f6_local2:get()
		if Engine[0xC53F8D38DF9042B](Engine[0xD5D69BA555E016D](f6_local6.itemIndex:get(), Enum[0x6EB546760F890D2][0x9AF82A21BAD026D])) == f6_arg5 then
			f6_local1 = true
			for f6_local8 = 0, f6_local7 - 1, 1 do
				local f6_local11 = f6_local8
				table.insert(f6_arg3, {
					model = f6_local6,
				})
			end
		end
	end
	if f6_local1 then
		if f6_arg0.__chargesSub then
			f6_arg0:removeSubscription(f6_arg0.__chargesSub)
		end
		f6_arg0.__chargesSub = f6_arg0:subscribeToModel(f6_local2, function()
			f6_arg0:updateDataSource()
		end, false)
	end
end
DataSources.PerkVaporsDeadshotCharges = DataSourceHelpers.CustomListSetup("PerkVaporsDeadshotCharges", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	CoD.ZMPerkUtility.CustomListSetupForPerkChargesList(f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, 0x47297C33B115641)
end)
DataSources.PerkVaporsWintersWailCharges = DataSourceHelpers.CustomListSetup("PerkVaporsWintersWailCharges", function(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
	CoD.ZMPerkUtility.CustomListSetupForPerkChargesList(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, 0xF9EF78EFDDF61F)
end)
DataSources.PerkVapors = DataSourceHelpers.CustomListSetup("PerkVapors", function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4)
	CoD.CACUtility.GetCustomClassModel(f10_arg1, Engine[0xD2B2D1965173543](f10_arg1), f10_arg2:create("classModel"), nil, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
	local f10_local0 = CoD.ZMPerkUtility.PerkVaporAltarNamesPerStory[CoD.ZMStoryUtility.GetCurrentMapStory() + 1]
	local f10_local1 = DataSources.HUDItems.getModel(f10_arg1)
	for f10_local2 = 0, CoD.ZMPerkUtility.PerkVaporCount - 1, 1 do
		local f10_local5 = f10_local1:create("perkVapor." .. f10_local2)
		f10_local5:create("state")
		f10_local5:create("itemIndex")
		local f10_local6 = f10_local5:create("altarName")
		f10_local6:set(f10_local0[f10_local2 + 1] or 0x0)
		f10_local6 = f10_local5:create("specialEffectActive")
		f10_local6:set(0)
		f10_local6 = f10_local5:create("isLastAltar")
		f10_local6:set(f10_local2 + 1 == #f10_local0)
		f10_local5:create("modifierActive")
		table.insert(f10_arg3, {
			model = f10_local5,
		})
	end
	f10_arg0._perkVaporSubscriptions = true
end)
DataSources.ExtraPerkVapors = DataSourceHelpers.CustomListSetup("ExtraPerkVapors", function(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4)
	local f11_local0 = DataSources.HUDItems.getModel(f11_arg1)
	for f11_local1 = 0, CoD.ZMPerkUtility.ExtraPerkVaporCount - 1, 1 do
		local f11_local4 = f11_local0:create("extraPerkVapor." .. f11_local1)
		f11_local4:create("state")
		f11_local4:create("itemIndex")
		local f11_local5 = f11_local4:create("altarName")
		f11_local5:set(0x0)
		f11_local4:create("specialEffectActive")
		f11_local5 = f11_local4:create("isLastAltar")
		f11_local5:set(false)
		f11_local4:create("chargeCount")
		f11_local4:create("progress")
		f11_local4:create("timerActive")
		table.insert(f11_arg3, {
			model = f11_local4,
		})
	end
	f11_arg0._perkVaporSubscriptions = true
end)
DataSources.ZMEquippedPerks = {
	prepare = function(f12_arg0, f12_arg1, f12_arg2)
		f12_arg1.models = {}
		f12_arg1.properties = {}
		local f12_local0 = CoD.BaseUtility.GetMenuModel(f12_arg1.menu)
		if not f12_local0 then
			local f12_local1 = f12_arg1:getParent()
			f12_local0 = f12_local1:getModel()
			if not f12_local0 then
				return
			end
		end
		local f12_local1 = Engine[0xE00B2F29271C60B](0xB80048F5443A1D1)
		local f12_local2 = Engine[0x4DF5CFBC1771947](f12_arg0)
		if not f12_local2.selectedZMStory then
			CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory(f12_arg0)
		end
		f12_local2 = Engine[0x4DF5CFBC1771947](f12_arg0)
		f12_local2 = f12_local2.selectedZMStory
		local f12_local3 = f12_local1[f12_local2:get() .. ""]
		for f12_local9, f12_local10 in ipairs(CoD.ZMPerkUtility.PerkSlotNameList) do
			local f12_local11 = f12_local0[f12_local10]
			if f12_local11 then
				local f12_local7 = f12_local11:create("slotIndex")
				f12_local7:set(f12_local10)
				f12_local7 = f12_local11:create("altarName")
				f12_local7:set(f12_local3[f12_local9][0x9CF62F43204110C] or 0x0)
				f12_local7 = f12_local11:create("altarImage")
				f12_local7:set(f12_local3[f12_local9][0xF56F238CE31C394] or 0x0)
				f12_local7 = f12_local11:create("isModifierSlot")
				f12_local7:set(f12_local9 == #CoD.ZMPerkUtility.PerkSlotNameList)
				f12_local7 = nil
				local f12_local8 = Engine[0x4DF5CFBC1771947](f12_arg0)
				f12_local8 = f12_local8:create("ZMEquippedPerks")
				if f12_local8.currentSlot then
					f12_local7 = f12_local8.currentSlot:get()
				end
				f12_arg1.models[f12_local9] = f12_local11
				f12_arg1.properties[f12_local9] = {
					itemSlot = f12_local10,
					selectIndex = f12_local10 == f12_local7,
				}
			end
		end
		if f12_arg1.__storyChangeSub then
			f12_arg1:removeSubscription(f12_arg1.__storyChangeSub)
		end
		f12_arg1.__storyChangeSub = f12_arg1:subscribeToModel(f12_local2, function()
			f12_arg1:updateDataSource()
		end, false)
	end,
	getCount = function(f14_arg0)
		return #f14_arg0.models
	end,
	getCustomPropertiesForItem = function(f15_arg0, f15_arg1)
		return f15_arg0.properties[f15_arg1]
	end,
	getItem = function(f16_arg0, f16_arg1, f16_arg2)
		return f16_arg1.models[f16_arg2]
	end,
	getModel = function(f17_arg0)
		if not DataSources.ZMEquippedPerks.__cachedModel then
			DataSources.ZMEquippedPerks.__cachedModel = {}
		end
		if DataSources.ZMEquippedPerks.__cachedModel[f17_arg0] then
			return DataSources.ZMEquippedPerks.__cachedModel[f17_arg0]
		end
		local f17_local0 = Engine[0x4DF5CFBC1771947](f17_arg0)
		f17_local0 = f17_local0:create("ZMEquippedPerks")
		local f17_local1 = f17_local0:create("currentSlot")
		f17_local1:set(CoD.ZMPerkUtility.PerkSlotNameList[1])
		f17_local0:create("updateEquipped")
		if not f17_local0.inEditMenu then
			f17_local1 = f17_local0:create("inEditMenu")
			f17_local1:set(false)
		end
		DataSources.ZMEquippedPerks.__cachedModel[f17_arg0] = f17_local0
		return f17_local0
	end,
}
DataSources.PerkSelectList = DataSourceHelpers.ListSetup("PerkSelectList", function(f18_arg0, f18_arg1)
	local f18_local0 = {}
	local f18_local1 = "specialty"
	local f18_local2 = CoD.BaseUtility.GetMenuSessionMode(f18_arg1.menu)
	local f18_local3 = CoD.BaseUtility.GetMenuModel(f18_arg1.menu)
	local f18_local4 = DataSources.ZMEquippedPerks.getModel(f18_arg0)
	local f18_local5 = CoD.CACUtility.GetItemEquippedInSlot(f18_local4.currentSlot:get(), nil, f18_local3)
	for f18_local9, f18_local10 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f18_local2, f18_local1)) do
		if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem(f18_local10.nameHash, f18_local2) then
			table.insert(f18_local0, {
				models = {
					name = f18_local10.name,
					globalItemIndex = f18_local10.globalItemIndex,
					itemIndex = f18_local10.itemIndex,
					displayName = f18_local10.displayName,
					image = CoD.CACUtility.GetPreviewImageLarge(f18_local2, f18_local10),
					description = f18_local10.description,
					modifierName = Engine[0xF9F1239CFD921FE](0xEDA68561505E676, f18_local10[0x18FC01EA0DDD81D] or 0x0),
					modifierDesc = f18_local10[0xF3026F8ACAB12DA] or 0x0,
					isRestricted = CoD.CACUtility.IsPerkRestricted(CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false),
				},
				properties = {
					selectIndex = f18_local5 == f18_local10.itemIndex,
					equipSound = f18_local10[0x87F8E9A3DEB31D2] or 0x858B7E73692FF70,
				},
			})
		end
	end
	return f18_local0
end, true)
CoD.ZMPerkUtility.IsPerkEquippedInCurrentSlot = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = CoD.BaseUtility.GetMenuModel(f19_arg2)
	local f19_local1 = DataSources.ZMEquippedPerks.getModel(f19_arg1)
	return CoD.CACUtility.GetItemEquippedInSlot(f19_local1.currentSlot:get(), nil, f19_local0) == CoD.SafeGetModelValue(f19_arg0:getModel(), "itemIndex")
end
CoD.ZMPerkUtility.IsPerkEquipped = function(f20_arg0, f20_arg1, f20_arg2)
	local f20_local0 = CoD.BaseUtility.GetMenuModel(f20_arg2)
	local f20_local1 = f20_arg0:getModel()
	return CoD.CACUtility.IsItemAlreadyEquippedInAnySlot(f20_local0, f20_local1.itemIndex:get(), CoD.ZMPerkUtility.PerkSlotNameList)
end
CoD.ZMPerkUtility.IsPerkLocked = function(f21_arg0, f21_arg1, f21_arg2)
	local f21_local0 = CoD.BaseUtility.GetMenuSessionMode(f21_arg2)
	if not CoD.CACUtility.IsProgressionEnabled(f21_local0) then
		return false
	else
		local f21_local1 = f21_arg0:getModel()
		if f21_local1 and f21_local1.globalItemIndex then
			return Engine[0x191C1637A229078](f21_arg1, f21_local1.globalItemIndex:get(), f21_local0)
		else
		end
	end
end
CoD.ZMPerkUtility.AreAllPerksActive = function(f22_arg0)
	for f22_local0 = 0, CoD.ZMPerkUtility.PerkVaporCount - 1, 1 do
		local f22_local3 = DataSources.HUDItems.getModel(f22_arg0)
		f22_local3 = f22_local3["perkVapor." .. f22_local0]
		if not f22_local3 or not f22_local3.state or f22_local3.state:get() == CoD.ZMPerkUtility.PerkVaporStates.DEFAULT then
			return false
		end
	end
	return true
end
CoD.ZMPerkUtility.IsPerkSpecificItem = function(f23_arg0, f23_arg1, f23_arg2)
	local f23_local0 = f23_arg0:getModel(f23_arg1, "itemIndex")
	local f23_local1 = f23_local0 and f23_local0:get()
	if f23_local1 and f23_local1 > CoD.CACUtility.EmptyItemIndex then
		return Engine[0xC53F8D38DF9042B](Engine[0xD5D69BA555E016D](f23_local1, Enum[0x6EB546760F890D2][0x9AF82A21BAD026D])) == f23_arg2
	else
		return false
	end
end
CoD.ZMPerkUtility.PerkOptionSelected = function(f24_arg0, f24_arg1, f24_arg2)
	local f24_local0 = CoD.BaseUtility.GetMenuModel(f24_arg1)
	local f24_local1 = DataSources.ZMEquippedPerks.getModel(f24_arg2)
	f24_local1 = f24_local1.currentSlot:get()
	local f24_local2 = f24_local0.classNum:get()
	local f24_local3 = f24_arg0:getModel()
	local f24_local4 = f24_local3.itemIndex:get()
	local f24_local5 = Engine[0x87395843D470BE2](f24_local4, Enum[0x6EB546760F890D2][0x9AF82A21BAD026D], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
	local f24_local6 = CoD.CACUtility.GetClassItemOptionEquipSlot(f24_local4, f24_local0, CoD.ZMPerkUtility.PerkSlotNameList, CoD.ZMPerkUtility.PerkVaporCount)
	if not f24_local6 or f24_local6 ~= f24_local1 then
		if f24_local6 and f24_local5[0x2616A8F1602BB4B] ~= 1 then
			CoD.CACUtility.SetClassItem(f24_arg2, f24_local2, f24_local6, CoD.CACUtility.GetItemEquippedInSlot(f24_local1, f24_arg2, f24_local0), nil, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
		end
		CoD.CACUtility.SetClassItem(f24_arg2, f24_local2, f24_local1, f24_local4, nil, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
		CoD.CACUtility.GetCustomClassModel(f24_arg2, f24_local2, f24_local0, nil, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
		local f24_local7 = DataSources.ZMEquippedPerks.getModel(f24_arg2)
		f24_local7.updateEquipped:forceNotifySubscriptions()
	end
end
CoD.ZMPerkUtility.PerkSlotHighlighted = function(f25_arg0, f25_arg1)
	local f25_local0 = DataSources.ZMEquippedPerks.getModel(f25_arg1)
	f25_local0.currentSlot:set(f25_arg0.itemSlot)
end
CoD.ZMPerkUtility.PerkSlotFocused = function(f26_arg0, f26_arg1, f26_arg2)
	if not IsCurrentMenu(f26_arg0, "ZMPerkSelect") then
		return
	end
	local f26_local0 = CoD.BaseUtility.GetMenuSessionMode(f26_arg0)
	local f26_local1 = f26_arg1:getModel()
	if not f26_local1 then
		return
	end
	local f26_local2 = CoD.SafeGetModelValue(f26_local1, "itemIndex")
	if not f26_local2 then
		return
	end
	local f26_local3 = CoD.CACUtility.GetUnlockableItemInfo(Engine[0xE8B1E317B9DD6FE](f26_local2, Enum[0x6EB546760F890D2][0x9AF82A21BAD026D], f26_local0), f26_local0)
	if not f26_local3 then
		return
	end
	local f26_local4 = f26_local3.displayName
	local f26_local5 = f26_local3.description
	local f26_local6 = Engine[0xF9F1239CFD921FE](0xEDA68561505E676, f26_local3[0x18FC01EA0DDD81D] or 0x0)
	local f26_local7 = f26_local3[0xF3026F8ACAB12DA] or 0x0
	if f26_arg0.PerkName and f26_local4 then
		f26_arg0.PerkName:setText(LocalizeToUpperString(f26_local4))
	end
	if f26_arg0.PerkDescription and f26_local5 then
		f26_arg0.PerkDescription:setText(Engine[0xF9F1239CFD921FE](f26_local5))
	end
	if f26_arg0.ModifierInfo then
		f26_arg0.ModifierInfo:setModel(f26_local1, f26_arg2)
		if f26_arg0.ModifierInfo.ModifierName and f26_local6 then
			f26_arg0.ModifierInfo.ModifierName:setText(ConvertToUpperString(f26_local6))
		end
		if f26_arg0.ModifierInfo.ModifierDescription and f26_local7 then
			f26_arg0.ModifierInfo.ModifierDescription:setText(Engine[0xF9F1239CFD921FE](f26_local7))
		end
	end
	if f26_arg0.RestrictedText then
		f26_arg0.RestrictedText:setModel(f26_local1, f26_arg2)
	end
end
CoD.ZMPerkUtility.GetPerkModifierName = function(f27_arg0, f27_arg1)
	local f27_local0 = Engine[0x87395843D470BE2](f27_arg1, Enum[0x6EB546760F890D2][0x9AF82A21BAD026D], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
	if f27_local0 and f27_local0[0x18FC01EA0DDD81D] then
		return Engine[0xF9F1239CFD921FE](0xEDA68561505E676, f27_local0[0x18FC01EA0DDD81D])
	else
		return f27_arg1
	end
end
