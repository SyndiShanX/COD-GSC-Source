CoD.ZMLoadoutUtility = {}
CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName = "zmStartWeapon"
CoD.ZMLoadoutUtility.ArmoryUberAllocation = 2
CoD.ZMLoadoutUtility.MaxArmoryAttachments = 6
CoD.ZMLoadoutUtility.SpecialWeaponStageNames = {
	@"menu/stage_1",
	@"menu/stage_2",
	@"menu/stage_3",
}
CoD.ZMLoadoutUtility.BGBSlotPositions = {
	up = {
		index = 0,
		name = "Up",
		promptPC = @"hash_1B2EC90916422153",
	},
	right = {
		index = 1,
		name = "Right",
		promptPC = @"hash_1B2ECA0916422306",
	},
	down = {
		index = 2,
		name = "Down",
		promptPC = @"hash_1B2ECB09164224B9",
	},
	left = {
		index = 3,
		name = "Left",
		promptPC = @"hash_1B2ECC091642266C",
	},
}
CoD.ZMLoadoutUtility.ZMStartingWeaponGroupNames = {
	{
		index = 1,
		weapon_category = "weapon_smg",
		name = @"hash_35A1E94F52AC6DAB",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_smg"],
		loadoutType = "primary",
	},
	{
		index = 2,
		weapon_category = "weapon_tactical",
		name = @"hash_1FB38D2633FBBEC7",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_tactical"],
		loadoutType = "primary",
	},
	{
		index = 3,
		weapon_category = "weapon_secondaries",
		name = @"hash_5B00F60446232842",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_pistol"],
		loadoutType = "secondary",
	},
}
CoD.ZMLoadoutUtility.ZMArmoryGroupNames = {
	{
		index = 1,
		weapon_category = "weapon_assault",
		name = @"hash_7FE1B0B2003A6CC1",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_assault"],
		loadoutType = "primary",
	},
	{
		index = 2,
		weapon_category = "weapon_smg",
		name = @"hash_35A1E94F52AC6DAB",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_smg"],
		loadoutType = "primary",
	},
	{
		index = 3,
		weapon_category = "weapon_tactical",
		name = @"hash_1FB38D2633FBBEC7",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_tactical"],
		loadoutType = "primary",
	},
	{
		index = 4,
		weapon_category = "weapon_lmg",
		name = @"hash_6DB6F169E46CD4E4",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_lmg"],
		loadoutType = "primary",
	},
	{
		index = 5,
		weapon_category = "weapon_sniper",
		name = @"hash_2EF865AD574F5FAD",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_sniper"],
		loadoutType = "primary",
	},
	{
		index = 6,
		weapon_category = "weapon_secondaries",
		name = @"hash_5B00F60446232842",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_pistol"],
		loadoutType = "secondary",
	},
}
CoD.ZMLoadoutUtility.ArmoryWeaponAttachmentListTable = {
	primary = {
		weaponRefHash = @"hash_0",
		attachmentList = {},
	},
	secondary = {
		weaponRefHash = @"hash_0",
		attachmentList = {},
	},
}
CoD.ZMLoadoutUtility.PRESTIGE_ATTACHMENT_SLOT = 6
CoD.ZMLoadoutUtility.GetZombieStartWeapons = function()
	if CoD.ZMLoadoutUtility.ZombieStartWeapons then
		return CoD.ZMLoadoutUtility.ZombieStartWeapons
	end
	CoD.ZMLoadoutUtility.ZombieStartWeapons = {}
	local f1_local0 = Engine[@"hash_2E00B2F29271C60B"](@"zmstartweapontable")
	f1_local0 = f1_local0 and f1_local0.zmstartweapons
	if f1_local0 then
		for f1_local7, f1_local8 in ipairs(f1_local0) do
			for f1_local4, f1_local5 in pairs(CoD.CACUtility.GetUnlockableItemTable()) do
				if CoD.BitUtility.IsBitSet(f1_local5.modes, Enum[@"emodes"][@"mode_zombies"]) and f1_local5.nameHash == f1_local8[@"weapon"] and f1_local5[@"hideinmenu"] ~= 1 then
					table.insert(CoD.ZMLoadoutUtility.ZombieStartWeapons, f1_local5)
				end
			end
		end
	end
	return CoD.ZMLoadoutUtility.ZombieStartWeapons
end
CoD.ZMLoadoutUtility.GetZombieStartWeaponsForForCategory = function(f2_arg0, f2_arg1)
	local f2_local0 = CoD.ZMLoadoutUtility.GetZombieStartWeapons()
	local f2_local1 = {}
	local f2_local2 = f2_arg0.__loadoutType
	if f2_local2 == "primary" then
		local f2_local3 = f2_arg0.__itemGroup
		for f2_local7, f2_local8 in ipairs(f2_local0) do
			if f2_local8.itemGroup == f2_local3 and f2_local8[@"hideinmenu"] ~= 1 then
				table.insert(f2_local1, f2_local8)
			end
		end
	elseif f2_local2 == "secondary" then
		for f2_local6, f2_local7 in ipairs(f2_local0) do
			if f2_local7.loadoutSlot == f2_local2 and f2_local7[@"hideinmenu"] ~= 1 then
				table.insert(f2_local1, f2_local7)
			end
		end
	end
	return CoD.CACUtility.SortUnlockableItemsBySortIndex(f2_local1, f2_arg1)
end
CoD.ZMLoadoutUtility.GetZombieStartWeaponsForWeaponCategory = function(f3_arg0, f3_arg1)
	local f3_local0 = CoD.ZMLoadoutUtility.GetZombieStartWeapons()
	local f3_local1 = {}
	if f3_arg1 == "primary" then
		for f3_local5, f3_local6 in ipairs(f3_local0) do
			if f3_local6.itemGroup == f3_arg0 and f3_local6[@"hideinmenu"] ~= 1 then
				table.insert(f3_local1, f3_local6)
			end
		end
	elseif f3_arg1 == "secondary" then
		for f3_local5, f3_local6 in ipairs(f3_local0) do
			if f3_local6.loadoutSlot == f3_arg1 and f3_local6[@"hideinmenu"] ~= 1 then
				table.insert(f3_local1, f3_local6)
			end
		end
	end
	return f3_local1
end
CoD.ZMLoadoutUtility.AnyWeaponsHaveGroupRestriction = function(f4_arg0)
	for f4_local3, f4_local4 in ipairs(f4_arg0) do
		if CoD.CACUtility.IsItemGroupRestricted(f4_local4.itemGroupIndex, false) then
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.AnySecondaryWeaponIsRestricted = function()
	local f5_local0 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(Enum[@"emodes"][@"mode_zombies"], "secondary")
	local f5_local1 = {}
	for f5_local5, f5_local6 in ipairs(f5_local0) do
		if f5_local6.allocation ~= -1 then
			table.insert(f5_local1, f5_local6)
		end
	end
	return CoD.ZMLoadoutUtility.AnyWeaponsHaveGroupRestriction(f5_local1)
end
CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForWeaponIndex = function(f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = CoD.ZMLoadoutUtility.GetEquippedArmoryAttachments(f6_arg0, f6_arg1, f6_arg2)
	local f6_local1 = ""
	for f6_local5, f6_local6 in ipairs(f6_local0.attachmentList) do
		if f6_local6.itemIndex ~= CoD.CACUtility.EmptyItemIndex then
			f6_local1 = LUI.appendStringWithDelimiter(f6_local1, Engine[@"getattachmentref"](f6_arg1, f6_local6.itemIndex, f6_arg2), "+")
		end
	end
	return CoD.ZMLoadoutUtility.AppendEquippedPrestigeAttachment(f6_arg0, f6_arg1, f6_arg2, f6_local1)
end
CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForElement = function(f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = ""
	if f7_arg0.armoryAttachmentTable then
		local f7_local1 = f7_arg0:getModel(f7_arg1, "itemIndex")
		local f7_local2 = f7_local1 and f7_local1:get()
		if f7_local2 then
			for f7_local6, f7_local7 in ipairs(f7_arg0.armoryAttachmentTable) do
				if f7_local7.itemIndex ~= CoD.CACUtility.EmptyItemIndex then
					f7_local0 = LUI.appendStringWithDelimiter(f7_local0, Engine[@"getattachmentref"](f7_local2, f7_local7.itemIndex, f7_arg2), "+")
				end
			end
			f7_local0 = CoD.ZMLoadoutUtility.AppendEquippedPrestigeAttachment(f7_arg1, f7_local2, f7_arg2, f7_local0)
		end
	end
	return f7_local0
end
CoD.ZMLoadoutUtility.GetLoadoutStorageBuffer = function(f8_arg0)
	local f8_local0 = Enum[@"storagefiletype"][@"storage_zm_loadouts_offline"]
	if not IsLocal() then
		if IsCustomLobby() then
			f8_local0 = Enum[@"storagefiletype"][@"hash_33376D9E1C3C8130"]
		else
			f8_local0 = Enum[@"storagefiletype"][@"storage_zm_loadouts"]
		end
	end
	return Engine[@"storagegetbuffer"](f8_arg0, f8_local0)
end
CoD.ZMLoadoutUtility.GetVariantSlot = function(f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = CoD.ZMLoadoutUtility.GetLoadoutStorageBuffer(f9_arg0)
	local f9_local1, f9_local2 = nil
	local f9_local3 = f9_local0.variant
	for f9_local4 = 0, #f9_local3 - 1, 1 do
		local f9_local7 = f9_local3[f9_local4]
		local f9_local8 = f9_local7.itemIndex:get()
		if not f9_local2 and f9_local8 == CoD.CACUtility.EmptyItemIndex then
			f9_local2 = f9_local7
		end
		if f9_local8 == f9_arg1 then
			f9_local1 = f9_local7
			break
		end
	end
	if not f9_local1 and f9_arg2 then
		f9_local1 = f9_local2
		f9_local1.itemIndex:set(f9_arg1)
		f9_local1.paintjobSlot:set(Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"])
	end
	if not f9_local1 then
		return nil
	else
		return f9_local1
	end
end
CoD.ZMLoadoutUtility.SetArmoryVariantStats = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = CoD.ZMLoadoutUtility.GetVariantSlot(f10_arg0, f10_arg1, true)
	for f10_local1 = 0, #f10_local0.attachment - 1, 1 do
		local f10_local4 = f10_arg2[f10_local1 + 1]
		if f10_local4 then
			f10_local0.attachment[f10_local1]:set(f10_local4.itemIndex)
		end
	end
end
CoD.ZMLoadoutUtility.EquipArmoryAttachment = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0 = CoD.BaseUtility.GetMenuSessionMode(f11_arg0)
	local f11_local1 = CoD.CACUtility.IsAttachmentOptic(f11_arg0._weaponItemIndex, f11_arg2, f11_local0)
	f11_arg0._isEditing = true
	for f11_local2 = 1, #f11_arg0._armoryAttachmentTable, 1 do
		if f11_arg0._armoryAttachmentTable[f11_local2].itemIndex == CoD.CACUtility.EmptyItemIndex and f11_arg0._armoryAttachmentTable[f11_local2].isOptic == f11_local1 then
			local f11_local5 = CoD.ZMLoadoutUtility.GetMutuallyExclusiveArmoryAttachments(f11_arg1, f11_arg0._weaponItemIndex, f11_arg2, f11_local0, true)
			for f11_local6 = 1, #f11_local5, 1 do
				local f11_local9 = f11_local5[f11_local6].attachmentIndex
				if CoD.CACUtility.EmptyItemIndex < f11_local9 then
					CoD.ZMLoadoutUtility.RemoveArmoryAttachment(f11_arg1, f11_arg0, f11_local9)
				end
			end
			f11_arg0._armoryAttachmentTable[f11_local2] = {
				itemIndex = f11_arg2,
				isOptic = f11_local1,
				isUberAttachment = f11_arg3,
			}
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.SetArmoryWeaponAccessoryAttachment = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = f12_arg0._model
	if f12_local0 then
		f12_local0 = f12_arg0._model.itemIndex:get()
	end
	local f12_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f12_arg1, f12_local0, true)
	local f12_local2 = CoD.BaseUtility.GetMenuSessionMode(f12_arg0)
	if not f12_local1 then
		return
	end
	for f12_local3 = 0, #f12_local1.attachment - 1, 1 do
		local f12_local6 = f12_local1.attachment[f12_local3]:get()
		if f12_local6 ~= CoD.CACUtility.EmptyItemIndex and not Engine[@"areattachmentscompatible"](f12_local0, f12_arg2, f12_local6, f12_local2) then
			f12_local1.attachment[f12_local3]:set(CoD.CACUtility.EmptyItemIndex)
		end
	end
	local f12_local3 = f12_local1.attachment[CoD.ZMLoadoutUtility.PRESTIGE_ATTACHMENT_SLOT]
	if f12_local3 then
		f12_local3:set(f12_arg2)
		local f12_local4 = Engine[@"getmodelforcontroller"](f12_arg1)
		f12_local4 = f12_local4:create("armoryAttachmentUpdated")
		f12_local4:forceNotifySubscriptions()
	end
end
CoD.ZMLoadoutUtility.SetArmoryCharmItem = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = f13_arg0._model
	if f13_local0 then
		f13_local0 = f13_arg0._model.itemIndex:get()
	end
	local f13_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f13_arg1, f13_local0, true)
	if not f13_local1 then
		return
	elseif f13_local1.charmIndex then
		f13_local1.charmIndex:set(f13_arg2)
	end
end
CoD.ZMLoadoutUtility.GetArmoryCharmItemFromWeapon = function(f14_arg0, f14_arg1)
	local f14_local0 = CoD.ZMLoadoutUtility.GetVariantSlot(f14_arg0, f14_arg1, true)
	if f14_local0 and f14_local0.charmIndex then
		return f14_local0.charmIndex:get()
	else
		return CoD.CACUtility.EmptyItemIndex
	end
end
CoD.ZMLoadoutUtility.GetArmoryCharmItem = function(f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0._model
	if f15_local0 then
		f15_local0 = f15_arg0._model.itemIndex:get()
	end
	return CoD.ZMLoadoutUtility.GetArmoryCharmItemFromWeapon(f15_arg1, f15_local0)
end
CoD.ZMLoadoutUtility.SetArmoryDeathFx = function(f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = f16_arg0._model
	if f16_local0 then
		f16_local0 = f16_arg0._model.itemIndex:get()
	end
	local f16_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f16_arg1, f16_local0, true)
	if not f16_local1 then
		return
	elseif f16_local1.deathFxIndex then
		f16_local1.deathFxIndex:set(f16_arg2)
	end
end
CoD.ZMLoadoutUtility.GetArmoryDeathFx = function(f17_arg0, f17_arg1)
	local f17_local0 = f17_arg0._model
	if f17_local0 then
		f17_local0 = f17_arg0._model.itemIndex:get()
	end
	local f17_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f17_arg1, f17_local0, true)
	if f17_local1 and f17_local1.deathFxIndex then
		return f17_local1.deathFxIndex:get()
	else
		return CoD.CACUtility.EmptyItemIndex
	end
end
CoD.ZMLoadoutUtility.RemoveArmoryAttachment = function(f18_arg0, f18_arg1, f18_arg2)
	f18_arg1._isEditing = true
	for f18_local0 = 1, #f18_arg1._armoryAttachmentTable, 1 do
		if f18_arg1._armoryAttachmentTable[f18_local0].itemIndex == f18_arg2 then
			if f18_local0 == 1 and f18_arg1._weaponItemIndex then
				local f18_local3 = CoD.ZMLoadoutUtility.GetVariantSlot(f18_arg0, f18_arg1._weaponItemIndex, false)
				if f18_local3 then
					f18_local3.reticleIndex:set(CoD.CACUtility.EmptyItemIndex)
				end
			end
			f18_arg1._armoryAttachmentTable[f18_local0] = {
				itemIndex = CoD.CACUtility.EmptyItemIndex,
				isOptic = f18_local0 == 1,
				isUberAttachment = false,
			}
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.IsArmoryAttachmentEquipped = function(f19_arg0, f19_arg1)
	for f19_local3, f19_local4 in ipairs(f19_arg0._armoryAttachmentTable) do
		if f19_local4.itemIndex == f19_arg1 then
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.IsArmoryAttachmentUber = function(f20_arg0, f20_arg1)
	for f20_local3, f20_local4 in ipairs(f20_arg0._armoryAttachmentTable) do
		if f20_local4.isUberAttachment then
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.IsItemPrestigeAttachment = function(f21_arg0)
	local f21_local0
	if f21_arg0 ~= "clantag" and f21_arg0 ~= "killcounter" then
		f21_local0 = false
	else
		f21_local0 = true
	end
	return f21_local0
end
CoD.ZMLoadoutUtility.IsItemAccessoryAttachment = function(f22_arg0)
	local f22_local0
	if f22_arg0 ~= "clantag" and f22_arg0 ~= "killcounter" and f22_arg0 ~= "custom2" then
		f22_local0 = false
	else
		f22_local0 = true
	end
	return f22_local0
end
CoD.ZMLoadoutUtility.UpdateArmoryAttachments = function(f23_arg0, f23_arg1)
	table.sort(f23_arg0._armoryAttachmentTable, CoD.ZMLoadoutUtility.AttachmentTableSort)
	CoD.ZMLoadoutUtility.SetArmoryVariantStats(f23_arg1, f23_arg0._weaponItemIndex, f23_arg0._armoryAttachmentTable)
	if f23_arg0._weaponItemModel and f23_arg0._weaponItemModel.hasOpticEquipped and f23_arg0._weaponItemModel.attachmentsEquippedCount then
		local f23_local0 = CoD.BaseUtility.GetMenuSessionMode(f23_arg0)
		local f23_local1 = false
		local f23_local2 = 0
		local f23_local3 = ""
		for f23_local7, f23_local8 in ipairs(f23_arg0._armoryAttachmentTable) do
			local f23_local9 = Engine[@"getattachmentref"](f23_arg0._weaponItemIndex, f23_local8.itemIndex, f23_local0)
			if f23_local8.itemIndex ~= CoD.CACUtility.EmptyItemIndex and not CoD.ZMLoadoutUtility.IsItemAccessoryAttachment(f23_local9) then
				if f23_local8.isOptic then
					f23_local1 = true
				elseif f23_local8.isUberAttachment then
					f23_local2 = f23_local2 + CoD.ZMLoadoutUtility.ArmoryUberAllocation
				else
					f23_local2 = f23_local2 + 1
				end
				f23_local3 = LUI.appendStringWithDelimiter(f23_local3, f23_local9, "+")
			end
		end
		f23_arg0._weaponItemModel.hasOpticEquipped:set(f23_local1)
		f23_arg0._weaponItemModel.attachmentsEquippedCount:set(f23_local2)
		f23_arg0._weaponAttachmentString = f23_local3
	end
	local f23_local0 = Engine[@"getmodelforcontroller"](f23_arg1)
	f23_local0 = f23_local0:create("armoryAttachmentUpdated")
	f23_local0:forceNotifySubscriptions()
end
CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex = function(f24_arg0, f24_arg1, f24_arg2)
	if not f24_arg1 then
		return CoD.WeaponOptionsUtility.CreateWeaponOptionsTable()
	end
	local f24_local0 = CoD.ZMLoadoutUtility.GetVariantSlot(f24_arg0, f24_arg1, false)
	local f24_local1 = 0
	local f24_local2 = 0
	local f24_local3 = 0
	local f24_local4 = 0
	local f24_local5 = 0
	if f24_local0 then
		f24_local1 = f24_local0.camoIndex:get()
		f24_local2 = f24_local0.reticleIndex:get()
		f24_local4 = f24_local0.weaponModelSlot:get()
		f24_local5 = f24_local0.charmIndex:get()
	end
	if f24_arg2 then
		f24_local4 = f24_arg2
	end
	if IsLive() and f24_local0 then
		local f24_local6 = f24_local0.paintjobSlot:get()
		Engine[@"setuppaintjobdata"](f24_arg0, f24_local6)
		if f24_local6 ~= Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] then
			f24_local3 = 1
		end
	else
		Engine[@"clearpaintjoblayerdata"]()
	end
	return CoD.WeaponOptionsUtility.CreateWeaponOptionsTable(f24_local1, f24_local2, f24_local3, f24_local4, nil, f24_local5)
end
CoD.ZMLoadoutUtility.GetReticleIndexForWeaponIndex = function(f25_arg0, f25_arg1)
	local f25_local0 = CoD.ZMLoadoutUtility.GetVariantSlot(f25_arg0, f25_arg1, false)
	if not f25_local0 then
		return 0
	else
		return f25_local0.reticleIndex:get()
	end
end
CoD.ZMLoadoutUtility.SetWeaponOptionForVariant = function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
	local f26_local0 = f26_arg1:getModel(f26_arg2, "weaponOptionTypeName")
	local f26_local1 = f26_arg1:getModel(f26_arg2, "weaponOptionSubIndex")
	local f26_local2 = f26_arg1:getModel(f26_arg2, "weaponOptionType")
	if f26_local0 and f26_local1 and f26_local2 then
		local f26_local3 = f26_local0:get()
		local f26_local4 = f26_local1:get()
		local f26_local5 = f26_local2:get()
		if f26_arg3._model then
			local f26_local6 = f26_arg3._model.itemIndex:get()
		end
		if f26_local5 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle"] then
			local f26_local6 = f26_arg3._model and f26_arg3._model.weaponIndex:get()
		end
		local f26_local7 = CoD.ZMLoadoutUtility.GetVariantSlot(f26_arg2, f26_local6, true)
		if not f26_local7 then
			return
		elseif f26_local5 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_paintjob"] then
			local f26_local8 = f26_arg1:getModel(f26_arg2, "paintjobSlot")
			f26_local7.paintjobSlot:set(f26_local8:get())
		elseif f26_local5 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle"] then
			f26_local7.reticleIndex:set(f26_local4)
		elseif f26_local5 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_camo"] then
			local f26_local8 = f26_local7.weaponModelSlot:get()
			local f26_local9 = Engine[@"hash_79F0BB7D52A7A978"](CoD.CACUtility.GetUnlockableItemInfoField(f26_local6, Enum[@"emodes"][@"mode_zombies"], "nameHash"))
			if f26_local9[f26_local8 + 1] and not f26_local9[f26_local8 + 1][@"hash_5C2AA73D9F82E9C2"] then
				f26_local7.weaponModelSlot:set(CoD.CACUtility.EmptyItemIndex)
			end
			f26_local7.camoIndex:set(f26_local4)
		end
	end
	CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f26_arg1, f26_arg2)
end
CoD.ZMLoadoutUtility.ClearWeaponOptionForVariant = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
	local f27_local0 = CoD.BaseUtility.GetMenuSessionMode(f27_arg3)
	local f27_local1 = f27_arg3._model
	if f27_local1 then
		f27_local1 = f27_arg3._model.itemIndex:get()
	end
	local f27_local2 = CoD.ZMLoadoutUtility.GetVariantSlot(f27_arg2, f27_local1, true)
	if not f27_local2 then
		return
	end
	local f27_local3 = f27_arg1:getModel(f27_arg2, "weaponOptionType")
	local f27_local4
	if f27_local3 then
		f27_local4 = f27_local3:get()
		if not f27_local4 then
		else
			if f27_local4 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_camo"] then
				f27_local2.camoIndex:set(CoD.CACUtility.EmptyItemIndex)
			elseif f27_local4 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle"] then
				f27_local2.reticleIndex:set(CoD.CACUtility.EmptyItemIndex)
			elseif f27_local4 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_paintjob"] then
				f27_local2.paintjobSlot:set(Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"])
			end
			CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f27_arg1, f27_arg2)
		end
	end
	f27_local4 = Enum[@"eweaponoptiongroup"][@"weaponoption_group_invalid"]
end
CoD.ZMLoadoutUtility.SetSignatureWeaponThemeForVariant = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
	local f28_local0 = CoD.BaseUtility.GetMenuSessionMode(f28_arg3)
	local f28_local1 = f28_arg3._model
	if f28_local1 then
		f28_local1 = f28_arg3._model.itemIndex:get()
	end
	local f28_local2 = CoD.ZMLoadoutUtility.GetVariantSlot(f28_arg2, f28_local1, true)
	if not f28_local2 or not f28_local2.weaponModelSlot or not f28_local2.camoIndex then
		return
	end
	local f28_local3 = f28_arg1:getModel(f28_arg2, "signatureWeaponModelSlot")
	local f28_local4 = f28_arg1:getModel(f28_arg2, "weaponOptionSubIndex")
	if f28_local3 then
		local f28_local5 = f28_local3:get()
		local f28_local6 = CoD.CACUtility.EmptyItemIndex
		if f28_local4 and f28_local4:get() then
			f28_local6 = f28_local4:get()
		end
		f28_local2.weaponModelSlot:set(f28_local5)
		f28_local2.camoIndex:set(f28_local6)
	end
	CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f28_arg1, f28_arg2)
end
CoD.ZMLoadoutUtility.SetSignatureWeapon = function(f29_arg0, f29_arg1, f29_arg2)
	local f29_local0 = f29_arg0:getModel(f29_arg1, "itemIndex")
	local f29_local1 = f29_arg0:getModel(f29_arg1, "weaponModelSlotIndex")
	local f29_local2 = f29_local0 and f29_local0:get()
	local f29_local3 = f29_local2 and CoD.ZMLoadoutUtility.GetVariantSlot(f29_arg1, f29_local2, true)
	if f29_local1 and f29_local3 then
		local f29_local4 = f29_local1:get()
		local f29_local5 = false
		local f29_local6 = f29_local3.weaponModelSlot:get()
		if f29_arg0.mastercraftWeaponModelSlots and #f29_arg0.mastercraftWeaponModelSlots > 0 then
			for f29_local10, f29_local11 in ipairs(f29_arg0.mastercraftWeaponModelSlots) do
				if f29_local6 == f29_local11 then
					f29_local5 = true
					break
				end
			end
		end
		if f29_arg0.equipSound and f29_arg0.equipSound ~= 0x0 then
			Engine[@"hash_498954175CA6A32C"](f29_arg0.equipSound)
		end
		f29_local3.weaponModelSlot:set(f29_local4)
		if CoD.SafeGetModelValue(f29_arg0:getModel(), "isMastercraft") then
			f29_local3.camoIndex:set(CoD.SafeGetModelValue(f29_arg0:getModel(), "weaponOptionSubIndex"))
		elseif f29_local5 then
			f29_local3.camoIndex:set(CoD.CACUtility.EmptyItemIndex)
		end
		local f29_local7 = f29_arg0:getModel(f29_arg1, "unlockableItemModel")
		if f29_local7 and f29_local7:get() then
			local f29_local8 = f29_local7:get()
			if f29_local8.weaponModelSlot then
				f29_local8 = f29_local7:get()
				f29_local8.weaponModelSlot:set(f29_local4)
			end
		end
		return f29_local4
	else
	end
end
CoD.ZMLoadoutUtility.GetWeaponModelSlot = function(f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = f30_arg0 and CoD.ZMLoadoutUtility.GetVariantSlot(f30_arg1, f30_arg0, false)
	if not f30_arg2 then
		f30_arg2 = 0
	end
	if f30_local0 then
		return f30_local0.weaponModelSlot and f30_local0.weaponModelSlot:get() or f30_arg2
	else
		return f30_arg2
	end
end
CoD.ZMLoadoutUtility.GetMutuallyExclusiveArmoryAttachments = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3, f31_arg4)
	local f31_local0 = {}
	local f31_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f31_arg0, f31_arg1, false)
	local f31_local2 = f31_local1 and f31_local1.attachment
	if f31_local2 then
		local f31_local3 = CoD.CACUtility.GetUnlockableItemInfoField(f31_arg1, f31_arg3, @"hash_5665460432375A7")
		local f31_local4 = Engine[@"hash_2B8DE256555CACF5"](f31_arg1, f31_arg2, f31_arg3) == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
		local f31_local5 = nil
		if f31_local3 then
			f31_local5 = LUI.splitString(f31_local3, " ")
		end
		for f31_local6 = 0, #f31_local2 - 1, 1 do
			local f31_local9 = f31_local2[f31_local6]:get()
			if CoD.CACUtility.EmptyItemIndex < f31_local9 and f31_arg2 ~= f31_local9 then
				if not Engine[@"areattachmentscompatible"](f31_arg1, f31_local9, f31_arg2, f31_arg3) and (not Engine[@"isoptic"](f31_arg1, f31_local9) or not Engine[@"isoptic"](f31_arg1, f31_arg2)) then
					table.insert(f31_local0, {
						ref = Engine[@"getattachmentref"](f31_arg1, f31_local9, f31_arg3),
						attachmentIndex = f31_local9,
					})
				end
				if f31_local5 then
					local f31_local10 = Engine[@"getattachmentref"](f31_arg1, f31_local9, f31_arg3)
					local f31_local11 = Engine[@"hash_2B8DE256555CACF5"](f31_arg1, f31_local9, f31_arg3) == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
					local f31_local12 = f31_local9
					if f31_local4 or f31_local11 then
						local f31_local13, f31_local14 = nil
						if f31_local11 then
							if f31_arg4 then
								f31_local13 = f31_local10
								f31_local14 = f31_local12
							end
							f31_local10 = Engine[@"getattachmentref"](f31_arg1, f31_arg2, f31_arg3)
							f31_local12 = f31_arg2
						end
						for f31_local18, f31_local19 in ipairs(f31_local5) do
							if f31_local19 == f31_local10 then
								if f31_local11 and f31_arg4 and f31_local13 and f31_local14 then
									table.insert(f31_local0, {
										ref = f31_local13,
										attachmentIndex = f31_local14,
									})
								else
									table.insert(f31_local0, {
										ref = f31_local10,
										attachmentIndex = f31_local12,
									})
								end
							end
						end
					end
				end
			end
		end
	end
	return f31_local0
end
CoD.ZMLoadoutUtility.GetStageDetailsDataSource = function(f32_arg0, f32_arg1)
	local f32_local0 = "stageDetails_" .. f32_arg0
	if not DataSources[f32_local0] then
		DataSources[f32_local0] = DataSourceHelpers.ListSetup(f32_local0, function(f33_arg0)
			local f33_local0 = {}
			for f33_local5, f33_local6 in ipairs(f32_arg1) do
				local f33_local4 = ""
				if f33_local5 == 1 then
					f33_local4 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_48934ADD8A66BD0D")
				else
					f33_local4 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_16954D4A1A455750")
				end
				table.insert(f33_local0, {
					models = {
						displayName = CoD.ZMLoadoutUtility.SpecialWeaponStageNames[f33_local5] or @"hash_0",
						itemName = f33_local6[@"hash_1359C0F8C26D4C9E"],
						description = f33_local4 .. "\n\n" .. Engine[@"hash_4F9F1239CFD921FE"](f33_local6[@"stagedescription"]),
						itemRefHash = f33_local6[@"hash_6F8FDB4ECF60C2FE"],
					},
				})
			end
			return f33_local0
		end, true)
	end
	return f32_local0
end
CoD.ZMLoadoutUtility.ClearAllAttachments = function(f34_arg0, f34_arg1, f34_arg2)
	local f34_local0 = {}
	local f34_local1 = Engine[@"getnumattachments"](f34_arg1, f34_arg2)
	for f34_local2 = 1, CoD.CACUtility.maxPrimaryAttachments, 1 do
		f34_local0[f34_local2] = {
			itemIndex = CoD.CACUtility.EmptyItemIndex,
			isOptic = f34_local2 == 1,
			isUberAttachment = false,
		}
	end
	local f34_local2 = CoD.ZMLoadoutUtility.GetVariantSlot(f34_arg0, f34_arg1, true)
	for f34_local3 = 0, #f34_local2.attachment - 1, 1 do
		if f34_local0[f34_local3 + 1] then
			f34_local2.attachment[f34_local3]:set(CoD.CACUtility.EmptyItemIndex)
		end
	end
	ForceNotifyControllerModel(f34_arg0, "Unlockables.listUpdate")
	CoD.ZMLoadoutUtility.SetArmoryVariantStats(f34_arg0, f34_arg1, f34_local0)
end
CoD.ZMLoadoutUtility.UpdateEquippedWeaponAttachmentAttributes = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = Enum[@"weaponattributescolumn"][@"weaponattributes_reference"]
	local f35_local1 = Enum[@"weaponattributescolumn"][@"weaponattributes_weapon_name"]
	local f35_local2 = Enum[@"weaponattributescolumn"][@"weaponattributes_damage"]
	local f35_local3 = Enum[@"weaponattributescolumn"][@"weaponattributes_range"]
	local f35_local4 = Enum[@"weaponattributescolumn"][@"weaponattributes_fire_rate"]
	local f35_local5 = Enum[@"weaponattributescolumn"][@"weaponattributes_accuracy"]
	local f35_local6 = Engine[@"hash_7B98952F69D937F9"](f35_arg1, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f35_arg2)
	local f35_local7 = {
		damage = 0,
		range = 0,
		fireRate = 0,
		accuracy = 0,
		magCount = 0,
		magSize = 0,
	}
	local f35_local8 = {}
	for f35_local19, f35_local20 in ipairs(f35_arg0._armoryAttachmentTable) do
		if f35_local20.itemIndex > CoD.CACUtility.EmptyItemIndex then
			local f35_local12 = Engine[@"getattachmentref"](f35_arg1, f35_local20.itemIndex, f35_arg2)
			table.insert(f35_local8, f35_local12)
			local f35_local13 = Engine[@"tablelookup"](CoD.weaponAttributes, f35_local2, f35_local0, f35_local12, f35_local1, f35_local6)
			local f35_local14 = Engine[@"tablelookup"](CoD.weaponAttributes, f35_local3, f35_local0, f35_local12, f35_local1, f35_local6)
			local f35_local15 = Engine[@"tablelookup"](CoD.weaponAttributes, f35_local4, f35_local0, f35_local12, f35_local1, f35_local6)
			local f35_local16 = Engine[@"tablelookup"](CoD.weaponAttributes, f35_local5, f35_local0, f35_local12, f35_local1, f35_local6)
			local f35_local17 = f35_local7.damage
			local f35_local18
			if not f35_local13 then
				f35_local18 = 0
				if not f35_local18 then
				else
					f35_local7.damage = f35_local17 + f35_local18
					f35_local17 = f35_local7.range
					if not f35_local14 then
						f35_local18 = 0
						if not f35_local18 then
						else
							f35_local7.range = f35_local17 + f35_local18
							f35_local17 = f35_local7.fireRate
							if not f35_local15 then
								f35_local18 = 0
								if not f35_local18 then
								else
									f35_local7.fireRate = f35_local17 + f35_local18
									f35_local17 = f35_local7.accuracy
									if not f35_local16 then
										f35_local18 = 0
										if not f35_local18 then
										else
											f35_local7.accuracy = f35_local17 + f35_local18
										end
									end
									f35_local18 = f35_local16
								end
							end
							f35_local18 = f35_local15
						end
					end
					f35_local18 = f35_local14
				end
			end
			f35_local18 = f35_local13
		end
	end
	f35_local7.magCount, f35_local7.magSize = CoD.WeaponAttachmentsUtility.GetClipCountAndSizeForWeapon(f35_local6, f35_local8)
	return f35_local8, f35_local7
end
CoD.ZMLoadoutUtility.GetArmoryWeaponAttachmentList = function(f36_arg0, f36_arg1, f36_arg2, f36_arg3, f36_arg4, f36_arg5)
	local f36_local0 = {}
	local f36_local1 = Engine[@"getunlockableitemkvpinfo"](f36_arg2, f36_arg5)
	local f36_local2 = Engine[@"getnumattachments"](f36_arg2, f36_arg5)
	local f36_local3, f36_local4 = CoD.ZMLoadoutUtility.UpdateEquippedWeaponAttachmentAttributes(f36_arg0, f36_arg2, f36_arg5)
	for f36_local5 = 1, f36_local2 - 1, 1 do
		local f36_local8 = Engine[@"getitemattachment"](f36_arg2, f36_local5, f36_arg5)
		if f36_local8 > CoD.CACUtility.EmptyItemIndex then
			local f36_local9 = Engine[@"getattachmentref"](f36_arg2, f36_local5, f36_arg5)
			if f36_local9 ~= "ir" then
				local f36_local10 = Engine[@"getattachmentname"](f36_arg2, f36_local5, f36_arg5)
				local f36_local11 = Engine[@"getattachmentuniqueimagebyindex"](f36_arg2, f36_local5, f36_arg5)
				local f36_local12 = Engine[@"getattachmentdesc"](f36_arg2, f36_local5, f36_arg5)
				local f36_local13 = Engine[@"hash_61F444BD03EB910E"](f36_arg2, f36_local8, f36_arg5)
				local f36_local14 = Engine[0x37522AE910C327](f36_local8, f36_arg5)
				local f36_local15 = CoD.WeaponAttachmentsUtility.GetWeaponAttachmentAttributes(f36_arg2, f36_local9, f36_arg5, f36_local3, f36_local4)
				local f36_local16 = CoD.CACUtility.EmptyItemIndex
				local f36_local17 = CoD.WeaponAttachmentsUtility.GetBaseAttachmentRef(f36_local1, f36_local9)
				if f36_local17 then
					f36_local16 = CoD.WeaponAttachmentsUtility.GetAttachmentIndexForWeaponAttachmentRef(f36_arg2, f36_local17, f36_arg5)
				end
				local f36_local18 = CoD.CACUtility.EmptyItemIndex
				local f36_local19 = CoD.WeaponAttachmentsUtility.GetUpgradedAttachmentRef(f36_local1, f36_local9)
				if f36_local19 then
					f36_local18 = CoD.WeaponAttachmentsUtility.GetAttachmentIndexForWeaponAttachmentRef(f36_arg2, f36_local19, f36_arg5)
				end
				local f36_local20 = CoD.WeaponAttachmentsUtility.IsAttachmentUpgrade(f36_local1, f36_local9)
				local f36_local21 = f36_local14 == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
				local f36_local22 = nil
				if f36_local20 then
					f36_local22 = CoD.Armory_AttachmentUpgradeSlotContainer
				elseif f36_local21 then
					f36_local22 = CoD.Armory_UberAttachmentSlot
				end
				local f36_local23 = false
				for f36_local27, f36_local28 in ipairs(f36_arg4) do
					if f36_local5 == f36_local28.attachmentIndex then
						f36_local23 = true
						break
					end
				end
				table.insert(f36_local0, {
					models = {
						attachmentRef = f36_local9,
						displayName = f36_local10,
						image = f36_local11,
						itemIndex = f36_local5,
						weaponIndex = f36_arg2,
						attachmentIndex = f36_local8,
						attachmentGroup = f36_local14,
						weaponSlot = f36_arg3,
						weaponIndex = f36_arg2,
						isUpgradedAttachment = f36_local20,
						baseAttachmentItemIndex = f36_local16,
						isUberAttachment = f36_local21,
						upgradedAttachmentIndex = f36_local18,
						weaponAttributes = f36_local15,
						description = Engine[@"hash_4F9F1239CFD921FE"](f36_local12),
						stateLeft = true,
						attachmentInFocus = false,
					},
					properties = {
						baseAttachmentItemIndex = f36_local16,
						equipSound = f36_local13 and f36_local13.equipSound,
						unequipSound = f36_local13 and f36_local13.unequipSound,
						customWidgetOverride = f36_local22,
					},
				})
			end
		end
	end
	return f36_local0
end
CoD.ZMLoadoutUtility.AttachmentTableSort = function(f37_arg0, f37_arg1)
	if f37_arg0.isOptic ~= f37_arg1.isOptic then
		return f37_arg0.isOptic
	elseif f37_arg0.itemIndex == CoD.CACUtility.EmptyItemIndex then
		return false
	elseif f37_arg1.itemIndex == CoD.CACUtility.EmptyItemIndex then
		return true
	else
		return f37_arg0.itemIndex < f37_arg1.itemIndex
	end
end
CoD.ZMLoadoutUtility.AppendEquippedPrestigeAttachment = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3)
	local f38_local0 = CoD.CACUtility.EmptyItemIndex
	if CoD.CACUtility.DoesUnlockableItemHaveAnyAttachments(f38_arg1, f38_arg2) then
		local f38_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f38_arg0, f38_arg1, false)
		local f38_local2 = f38_local1 and f38_local1.attachment
		local f38_local3 = f38_local2 and f38_local2[CoD.ZMLoadoutUtility.PRESTIGE_ATTACHMENT_SLOT]
		if f38_local3 then
			f38_local0 = f38_local3:get()
		end
	end
	if f38_local0 ~= CoD.CACUtility.EmptyItemIndex and f38_arg3 then
		f38_arg3 = LUI.appendStringWithDelimiter(f38_arg3, Engine[@"getattachmentref"](f38_arg1, f38_local0, f38_arg2), "+")
	end
	return f38_arg3
end
CoD.ZMLoadoutUtility.GetEquippedArmoryAttachments = function(f39_arg0, f39_arg1, f39_arg2)
	local f39_local0 = CoD.CACUtility.DoesUnlockableItemHaveAnyAttachments(f39_arg1, f39_arg2)
	local f39_local1 = Engine[@"getnumoptics"](f39_arg1, f39_arg2) > 1
	local f39_local2 = false
	local f39_local3 = 0
	local f39_local4 = {}
	if f39_local0 then
		local f39_local5 = Engine[@"getunlockableitemkvpinfo"](f39_arg1, f39_arg2)
		local f39_local6 = CoD.ZMLoadoutUtility.GetVariantSlot(f39_arg0, f39_arg1, false)
		local f39_local7 = f39_local6 and f39_local6.attachment
		if f39_local7 then
			for f39_local8 = 0, #f39_local7 - 1, 1 do
				local f39_local11 = f39_local7[f39_local8]:get()
				if f39_local11 ~= CoD.CACUtility.EmptyItemIndex then
					local f39_local12 = nil
					local f39_local13 = Engine[@"getattachmentref"](f39_arg1, f39_local11, f39_arg2)
					local f39_local14 = Engine[@"hash_2B8DE256555CACF5"](f39_arg1, f39_local11, f39_arg2)
					local f39_local15 = CoD.WeaponAttachmentsUtility.GetBaseAttachmentRef(f39_local5, f39_local13)
					if f39_local15 then
						f39_local12 = CoD.WeaponAttachmentsUtility.GetAttachmentIndexForWeaponAttachmentRef(f39_arg1, f39_local15, f39_arg2)
					end
					local f39_local16 = CoD.CACUtility.IsAttachmentOptic(f39_arg1, f39_local11, f39_arg2)
					if not f39_local2 then
						f39_local2 = f39_local16
					end
					local f39_local17 = f39_local14 == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
					if not CoD.ZMLoadoutUtility.IsItemAccessoryAttachment(f39_local13) then
						if not f39_local16 then
							if f39_local17 then
								f39_local3 = f39_local3 + CoD.ZMLoadoutUtility.ArmoryUberAllocation
							else
								f39_local3 = f39_local3 + 1
							end
						end
						table.insert(f39_local4, {
							itemIndex = f39_local11,
							baseAttachmentItemIndex = f39_local12,
							isOptic = f39_local16,
							isUberAttachment = f39_local17,
						})
					end
				end
			end
		end
		local f39_local8 = f39_local2
		while #f39_local4 < CoD.CACUtility.maxPrimaryAttachments do
			local f39_local9 = false
			if not f39_local8 then
				f39_local9 = true
				f39_local8 = true
			end
			table.insert(f39_local4, {
				itemIndex = CoD.CACUtility.EmptyItemIndex,
				isOptic = f39_local9,
			})
		end
		table.sort(f39_local4, CoD.ZMLoadoutUtility.AttachmentTableSort)
	end
	return {
		hasAttachmentSlots = f39_local0,
		hasOpticSlot = f39_local1,
		hasOptic = f39_local2,
		attachmentsEquippedCount = f39_local3,
		attachmentList = f39_local4,
	}
end
CoD.ZMLoadoutUtility.AddArmoryAttachmentModelsAndProperties = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	if not f40_arg0 or not f40_arg0.models or not f40_arg0.properties then
		return
	end
	local f40_local0 = CoD.ZMLoadoutUtility.GetEquippedArmoryAttachments(f40_arg1, f40_arg2, f40_arg3)
	local f40_local1 = IsLive()
	if f40_local1 then
		if Dvar.disableZMWeaponPersonalization then
			f40_local1 = not Dvar.disableZMWeaponPersonalization:get()
		else
			f40_local1 = true
		end
	end
	local f40_local2 = f40_arg0.models
	local f40_local3
	if f40_local1 then
		f40_local3 = Engine[@"localize"](@"hash_12EA924A41028AEA")
		if not f40_local3 then
		else
			f40_local2.hintText = f40_local3
			f40_arg0.models.showAttachmentPips = f40_local0.hasAttachmentSlots
			f40_arg0.models.hasOpticSlot = f40_local0.hasOpticSlot
			f40_arg0.models.hasOpticEquipped = f40_local0.hasOptic
			f40_arg0.models.totalSlotsCount = CoD.CACUtility.maxPrimaryAttachments - 1
			f40_arg0.models.attachmentsEquippedCount = f40_local0.attachmentsEquippedCount
			f40_arg0.properties.armoryAttachmentTable = f40_local0.attachmentList
		end
	end
	f40_local3 = ""
end
DataSources.ZMSpecialWeapons = ListHelper_SetupDataSource("ZMSpecialWeapons", function(f41_arg0, f41_arg1)
	local f41_local0 = {}
	local f41_local1 = "herogadget"
	local f41_local2 = CoD.BaseUtility.GetMenuSessionMode(f41_arg1.menu)
	local f41_local3 = CoD.CACUtility.GetItemIndexEquippedInSlot(f41_local1, f41_arg0, CoD.BaseUtility.GetMenuModel(f41_arg1.menu))
	for f41_local7, f41_local8 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f41_local2, f41_local1)) do
		if f41_local8.allocation ~= -1 and CoD.ZMStoryUtility.IsUnlockableItemAvailableInSelectedStory(f41_arg0, f41_local8) then
			table.insert(f41_local0, {
				models = {
					name = f41_local8.name,
					globalItemIndex = f41_local8.globalItemIndex,
					itemIndex = f41_local8.itemIndex,
					displayName = f41_local8.displayName,
					image = CoD.CACUtility.GetPreviewImage(f41_local2, f41_local8),
					description = f41_local8.description,
					equipped = f41_local8.itemIndex == f41_local3,
					stageDetailDatasource = CoD.ZMLoadoutUtility.GetStageDetailsDataSource("stageDetailDatasource_weapon" .. f41_local7, f41_local8.unlockableItemStages),
					disablePersonalization = true,
					isRestricted = CoD.CACUtility.AreSpecialWeaponsRestricted(false),
				},
				properties = {
					equipSound = f41_local8[@"equipsound"],
					unequipSound = f41_local8[@"unequipsound"],
				},
			})
		end
	end
	if f41_arg1._zmStorySubscription == nil then
		f41_local4 = Engine[@"getmodelforcontroller"](f41_arg0)
		f41_arg1._zmStorySubscription = f41_arg1:subscribeToModel(f41_local4.selectedZMStory, function()
			f41_arg1:updateDataSource()
		end, false)
	end
	return f41_local0
end, true)
CoD.ZMLoadoutUtility.SetupBGBLoadout = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
	if f43_arg3 then
		local f43_local0 = f43_arg3:create("tabHasRestrictions")
		f43_local0:set(false)
	end
	for f43_local6, f43_local7 in pairs(CoD.ZMLoadoutUtility.BGBSlotPositions) do
		local f43_local8 = Engine[@"getbubblegumbuff"](f43_arg1, f43_arg2, f43_local7.index)
		local f43_local9 = Engine[@"hash_1E8B1E317B9DD6FE"](f43_local8, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"])
		local f43_local10 = CoD.CACUtility.GetUnlockableItemInfo(f43_local9, Enum[@"emodes"][@"mode_zombies"])
		local f43_local11 = CoD.BGBUtility.ElixirToBooleanGameSettingsHash[f43_local10.nameHash]
		local f43_local12 = CoD.BGBUtility.ElixirToEnumGameSettingsHash[f43_local10.nameHash]
		local f43_local3 = CoD.CACUtility.AreElixirGameSettingsRestricted(f43_local11, f43_local10[@"bgbrarity"], false)
		if not f43_local3 then
			f43_local3 = CoD.CACUtility.AreGameSettingsStateOff(f43_local12, false)
		end
		if f43_arg3 and f43_local3 then
			local f43_local4 = f43_arg3:create("tabHasRestrictions")
			f43_local4:set(true)
		end
		local f43_local4 = f43_arg0:create(f43_local7.name)
		local f43_local5 = f43_local4:create("slotIndex")
		f43_local5:set(f43_local7.index)
		f43_local5 = f43_local4:create("itemIndex")
		f43_local5:set(f43_local8)
		f43_local5 = f43_local4:create("globalItemIndex")
		f43_local5:set(f43_local9)
		f43_local5 = f43_local4:create("displayName")
		f43_local5:set(f43_local10.displayName)
		f43_local5 = f43_local4:create("description")
		f43_local5:set(f43_local10.description)
		f43_local5 = f43_local4:create("image")
		f43_local5:set(f43_local10.previewImage)
		f43_local5 = f43_local4:create("promptPC")
		f43_local5:set(f43_local7.promptPC)
		f43_local5 = f43_local4:create("isRestricted")
		f43_local5:set(f43_local3)
		f43_local4:forceNotifySubscriptions()
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("BGBLoadout", "BGBLoadout", function(f44_arg0, f44_arg1)
	local f44_local0 = f44_arg0:create("selectedIndex")
	if f44_local0:get() == nil then
		f44_local0:set(-1)
	end
	CoD.ZMLoadoutUtility.SetupBGBLoadout(f44_arg0, f44_arg1, Engine[@"getequippedbubblegumpack"](f44_arg1), nil)
	f44_arg0:create("selectedEquippedBGBName")
end)
DataSources.BGBCategories = ListHelper_SetupDataSource("BGBCategories", function(f45_arg0)
	local f45_local0 = Engine[@"getequippedbubblegumpack"](f45_arg0)
	local f45_local1 = DataSources.BGBLoadout.getModel(f45_arg0)
	local f45_local2 = Engine[@"getbubblegumbuff"](f45_arg0, f45_local0, f45_local1.selectedIndex:get())
	local f45_local3 = Engine[@"hash_487395843D470BE2"](f45_local2, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"])
	local f45_local4 = Engine[@"getitemgroup"](f45_local2, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"])
	local f45_local5 = function(f46_arg0, f46_arg1)
		if f45_local4 == f46_arg0 then
			local f46_local0
			if f46_arg1 ~= nil and f45_local3[@"bgbrarity"] ~= f46_arg1 then
				f46_local0 = false
			else
				f46_local0 = true
			end
			return f46_local0
		else
			return false
		end
	end
	local f45_local6 = {}
	table.insert(f45_local6, {
		models = {
			name = @"zmui/classic",
			tabHasRestrictions = CoD.CACUtility.AnyElixirRestrictedForRarity(Enum[@"bgbrarity"][@"bgbrarity_classic"], "bubblegum"),
		},
		properties = {
			filter = "bubblegum",
			selectIndex = f45_local5("bubblegum"),
		},
	})
	if IsLive() then
		table.insert(f45_local6, {
			models = {
				name = @"hash_1E73A287484FA8DE",
				tabHasRestrictions = CoD.CACUtility.AnyElixirRestrictedForRarity(Enum[@"bgbrarity"][@"bgbrarity_common"], "bubblegum_consumable"),
			},
			properties = {
				filter = "bubblegum_consumable",
				rarity = Enum[@"bgbrarity"][@"bgbrarity_common"],
				selectIndex = f45_local5("bubblegum_consumable", Enum[@"bgbrarity"][@"bgbrarity_common"]),
			},
		})
		table.insert(f45_local6, {
			models = {
				name = @"hash_1D14011B788D0CF7",
				tabHasRestrictions = CoD.CACUtility.AnyElixirRestrictedForRarity(Enum[@"bgbrarity"][@"bgbrarity_rare"], "bubblegum_consumable"),
			},
			properties = {
				filter = "bubblegum_consumable",
				rarity = Enum[@"bgbrarity"][@"bgbrarity_rare"],
				selectIndex = f45_local5("bubblegum_consumable", Enum[@"bgbrarity"][@"bgbrarity_rare"]),
			},
		})
		table.insert(f45_local6, {
			models = {
				name = @"hash_499BE3404C6F5504",
				tabHasRestrictions = CoD.CACUtility.AnyElixirRestrictedForRarity(Enum[@"bgbrarity"][@"bgbrarity_legendary"], "bubblegum_consumable"),
			},
			properties = {
				filter = "bubblegum_consumable",
				rarity = Enum[@"bgbrarity"][@"bgbrarity_legendary"],
				selectIndex = f45_local5("bubblegum_consumable", Enum[@"bgbrarity"][@"bgbrarity_legendary"]),
			},
		})
		table.insert(f45_local6, {
			models = {
				name = @"hash_7CC5E57AF2A3CF36",
				tabHasRestrictions = CoD.CACUtility.AnyElixirRestrictedForRarity(Enum[@"bgbrarity"][@"bgbrarity_epic"], "bubblegum_consumable"),
			},
			properties = {
				filter = "bubblegum_consumable",
				rarity = Enum[@"bgbrarity"][@"bgbrarity_epic"],
				selectIndex = f45_local5("bubblegum_consumable", Enum[@"bgbrarity"][@"bgbrarity_epic"]),
			},
		})
	end
	return f45_local6
end, true)
DataSources.ZMStartingWeaponGroups = ListHelper_SetupDataSource("ZMStartingWeaponGroups", function(f47_arg0)
	local f47_local0 = {}
	for f47_local4, f47_local5 in ipairs(CoD.ZMLoadoutUtility.ZMStartingWeaponGroupNames) do
		table.insert(f47_local0, {
			models = {
				name = f47_local5.name,
				tabHasRestrictions = CoD.ZMLoadoutUtility.AnyWeaponsHaveGroupRestriction(CoD.ZMLoadoutUtility.GetZombieStartWeaponsForWeaponCategory(f47_local5.weapon_category, f47_local5.loadoutType)),
			},
			properties = {
				loadoutType = f47_local5.loadoutType,
				category = f47_local5.weapon_category,
				itemGroup = f47_local5.itemGroup,
			},
		})
	end
	return f47_local0
end, true)
DataSources.ArmoryWeaponGroups = ListHelper_SetupDataSource("ArmoryWeaponGroups", function(f48_arg0)
	local f48_local0 = {}
	for f48_local5, f48_local6 in ipairs(CoD.ZMLoadoutUtility.ZMArmoryGroupNames) do
		local f48_local4 = CoD.CACUtility.IsItemGroupRestricted(f48_local6.itemGroup, false)
		if f48_local6.loadoutType == "secondary" then
			f48_local4 = CoD.ZMLoadoutUtility.AnySecondaryWeaponIsRestricted()
		end
		table.insert(f48_local0, {
			models = {
				name = f48_local6.name,
				tabHasRestrictions = f48_local4,
			},
			properties = {
				loadoutType = f48_local6.loadoutType,
				category = f48_local6.weapon_category,
				itemGroup = f48_local6.itemGroup,
			},
		})
	end
	return f48_local0
end, true)
DataSources.ArmoryWeaponAttachments = ListHelper_SetupDataSource(
	"ArmoryWeaponAttachments",
	function(f49_arg0, f49_arg1, f49_arg2)
		local f49_local0, f49_local1, f49_local2, f49_local3, f49_local4, f49_local5 = nil
		if f49_arg1.menu then
			f49_local0 = CoD.BaseUtility.GetMenuSessionMode(f49_arg1.menu)
			f49_local1 = f49_arg1.menu._armoryAttachmentTable
			f49_local2 = CoD.BaseUtility.GetMenuLoadoutSlot(f49_arg1.menu)
			f49_local3 = f49_arg1.menu._weaponItemIndex
			f49_local4 = Engine[@"hash_7B98952F69D937F9"](f49_local3, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f49_local0)
			f49_local5 = f49_arg1.menu._isEditing
		end
		if CoD.ZMLoadoutUtility.ArmoryWeaponAttachmentListTable[f49_local2] then
			if CoD.ZMLoadoutUtility.ArmoryWeaponAttachmentListTable[f49_local2].weaponRefHash == f49_local4 and not f49_local5 then
				return CoD.ZMLoadoutUtility.ArmoryWeaponAttachmentListTable[f49_local2].attachmentList
			else
				CoD.ZMLoadoutUtility.ArmoryWeaponAttachmentListTable[f49_local2].weaponRefHash = f49_local4
				CoD.ZMLoadoutUtility.ArmoryWeaponAttachmentListTable[f49_local2].attachmentList = CoD.ZMLoadoutUtility.GetArmoryWeaponAttachmentList(f49_arg1.menu, f49_arg0, f49_local3, f49_local2, f49_local1, f49_local0)
				return CoD.ZMLoadoutUtility.ArmoryWeaponAttachmentListTable[f49_local2].attachmentList
			end
		else
			DebugPrint("\n ZMLoadoutUtility: Did not get a valid loadoutSlot or weaponRefHash")
			return {}
		end
	end,
	false,
	{
		getModelForAttachmentIndex = function(f50_arg0, f50_arg1)
			local f50_local0 = Engine[@"getmodelforcontroller"](f50_arg0)
			f50_local0 = f50_local0.ArmoryWeaponAttachments
			if f50_local0 and f50_local0[f50_arg1] then
				return f50_local0[f50_arg1]
			else
			end
		end,
	}
)
CoD.ZMLoadoutUtility.SetEquippedBubbleGumPackToSelectedClass = function(f51_arg0, f51_arg1, f51_arg2)
	local f51_local0 = CoD.BaseUtility.GetMenuSessionMode(f51_arg2)
	if f51_local0 == nil and IsZombies() then
		f51_local0 = Enum[@"emodes"][@"mode_zombies"]
	end
	if f51_local0 == Enum[@"emodes"][@"mode_zombies"] then
		local f51_local1 = f51_arg0:getModel()
		Engine[@"equipbubblegumpack"](f51_arg1, f51_local1.classNum:get())
		DataSourceHelperRecreate(f51_arg1, "BGBLoadout")
	end
end
CoD.ZMLoadoutUtility.PreviewBubbleGumPack = function(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = CoD.BaseUtility.GetMenuSessionMode(f52_arg2)
	if f52_local0 == nil and IsZombies() then
		f52_local0 = Enum[@"emodes"][@"mode_zombies"]
	end
	if f52_local0 == Enum[@"emodes"][@"mode_zombies"] then
		local f52_local1 = f52_arg0:getModel()
		f52_local1 = f52_local1.classNum:get()
		local f52_local2 = Engine[@"getmodelforcontroller"](f52_arg1)
		CoD.ZMLoadoutUtility.SetupBGBLoadout(f52_local2:create("BGBLoadout"), f52_arg1, f52_local1, nil)
	end
end
CoD.ZMLoadoutUtility.UpdateBubbleGumPackForCurrentClass = function(f53_arg0, f53_arg1, f53_arg2)
	local f53_local0 = CoD.BaseUtility.GetMenuModel(f53_arg0)
	local f53_local1 = f53_local0.classNum:get()
	local f53_local2 = Engine[@"getmodelforcontroller"](f53_arg2)
	CoD.ZMLoadoutUtility.SetupBGBLoadout(f53_local2:create("BGBLoadout"), f53_arg2, f53_local1, f53_local0)
end
CoD.ZMLoadoutUtility.SetEquippedClass = function(f54_arg0, f54_arg1)
	if IsZombies() then
		local f54_local0 = CoD.ZMLoadoutUtility.GetLoadoutStorageBuffer(f54_arg0)
		if f54_local0 then
			local f54_local1 = f54_local0.cacLoadouts
			if f54_local1 then
				local f54_local2 = f54_local1[Engine[@"hash_6BBE3328FE08B8C7"]()]
				if f54_local2 then
					local f54_local3 = f54_local2[@"hash_78E9CEF0ED273BD"]
					if f54_local3 and f54_local3:get() ~= f54_arg1 then
						f54_local3:set(f54_arg1)
					end
				end
			end
		end
	end
end
CoD.ZMLoadoutUtility.SaveZMLoadoutBuffer = function(f55_arg0)
	local f55_local0 = Enum[@"storagefiletype"][@"storage_zm_loadouts_offline"]
	if not IsLocal() then
		if IsCustomLobby() then
			f55_local0 = Enum[@"storagefiletype"][@"hash_33376D9E1C3C8130"]
		else
			f55_local0 = Enum[@"storagefiletype"][@"storage_zm_loadouts"]
		end
	end
	Engine[@"storagewrite"](f55_arg0, f55_local0)
end
CoD.ZMLoadoutUtility.OpenBGBSelectionMenu = function(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
	CoD.CACUtility.OpenCACOverlay(f56_arg0, f56_arg1, f56_arg2, "BubblegumBuffSelect", f56_arg3, "equippedbubblegumpack")
end
CoD.ZMLoadoutUtility.AddBGBSelectMenuControls = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
	local f57_local0 = function(f58_arg0)
		local f58_local0 = CoD.ZMLoadoutUtility.BGBSlotPositions[f58_arg0]
		if f58_local0 then
			return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f57_arg3, "BGBLoadout", "selectedIndex", f58_local0.index)
		else
			return false
		end
	end
	local f57_local1 = function(f59_arg0)
		local f59_local0 = CoD.ZMLoadoutUtility.BGBSlotPositions[f59_arg0]
		if f59_local0 then
			SetControllerModelValue(f57_arg3, "BGBLoadout.selectedIndex", f59_local0.index)
		end
	end
	if IsFreeCursorActive(f57_arg3) then
		f57_arg0:AddButtonCallbackFunction(f57_arg0, f57_arg3, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
			if IsFreeCursorActive(controller) and IsDpadButton(model) and not f57_local0("left") then
				f57_local1("left")
			end
		end, AlwaysFalse, false)
		f57_arg0:AddButtonCallbackFunction(f57_arg0, f57_arg3, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
			if IsFreeCursorActive(controller) and IsDpadButton(model) and not f57_local0("right") then
				f57_local1("right")
			end
		end, AlwaysFalse, false)
		f57_arg0:AddButtonCallbackFunction(f57_arg0, f57_arg3, Enum[@"luibutton"][@"lui_key_up"], nil, function(element, menu, controller, model)
			if IsFreeCursorActive(controller) and IsDpadButton(model) and not f57_local0("up") then
				f57_local1("up")
			end
		end, AlwaysFalse, false)
		f57_arg0:AddButtonCallbackFunction(f57_arg0, f57_arg3, Enum[@"luibutton"][@"lui_key_down"], nil, function(element, menu, controller, model)
			if IsFreeCursorActive(controller) and IsDpadButton(model) and not f57_local0("down") then
				f57_local1("down")
			end
		end, AlwaysFalse, false)
	end
end
CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots = function(f64_arg0, f64_arg1, f64_arg2)
	local f64_local0 = f64_arg1:getModel()
	if f64_local0 and f64_arg0.ItemInfo then
		f64_arg0.ItemInfo:setModel(f64_local0, f64_arg2)
	end
end
CoD.ZMLoadoutUtility.UpdateBGBEquippedSelectedName = function(f65_arg0, f65_arg1, f65_arg2)
	local f65_local0 = f65_arg1:get()
	local f65_local1 = f65_arg0:getModel()
	if f65_local0 ~= nil and f65_local1 and f65_local1.selectedEquippedBGBName then
		f65_local1.selectedEquippedBGBName:set(f65_local0)
	end
end
CoD.ZMLoadoutUtility.UpdateBGBNameFromSelectedIndex = function(f66_arg0, f66_arg1, f66_arg2, f66_arg3)
	local f66_local0 = f66_arg2:get()
	local f66_local1 = f66_arg1:getModel()
	if f66_local0 ~= nil or f66_local0 >= 0 then
		local f66_local2 = nil
		for f66_local6, f66_local7 in pairs(CoD.ZMLoadoutUtility.BGBSlotPositions) do
			if f66_local7.index == f66_local0 then
				f66_local2 = f66_local7.name
				break
			end
		end
		if f66_local2 and f66_local1 and f66_local1.selectedEquippedBGBName then
			f66_local3 = f66_local1[f66_local2]
			if f66_local3 and f66_local3.displayName and f66_local1 and f66_local1.selectedEquippedBGBName then
				f66_local1.selectedEquippedBGBName:set(f66_local3.displayName:get())
			end
		end
	end
end
CoD.ZMLoadoutUtility.UpdateArmoryWeaponModel = function(f67_arg0, f67_arg1, f67_arg2)
	local f67_local0 = CoD.BaseUtility.GetMenuSessionMode(f67_arg2)
	local f67_local1 = f67_arg2.__loadoutType
	local f67_local2 = 0x0
	local f67_local3 = f67_arg0:getModel()
	local f67_local4 = nil
	if f67_local3 and f67_local3.itemIndex then
		f67_local4 = f67_local3.itemIndex:get()
		f67_local2 = Engine[@"hash_7B98952F69D937F9"](f67_local4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f67_local0)
	end
	local f67_local5 = -1
	if f67_local4 and CoD.CACUtility.EmptyItemIndex < f67_local4 then
		local f67_local6 = CoD.ZMLoadoutUtility.GetVariantSlot(f67_arg1, f67_local4, false)
		if f67_local6 then
			local f67_local7 = f67_local6.camoIndex:get()
			local f67_local8 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], f67_local7)
			if f67_local8 and not CoD.CACUtility.MasteryCamos[f67_local8] then
				local f67_local9 = CoD.CACUtility.AdjustCamoIfSignatureCamo(f67_arg1, f67_local7)
				f67_local5 = CoD.WeaponOptionsUtility.GetRobStageForCamoIndex(f67_local9)
				if f67_local9 ~= f67_local7 then
					f67_local6.camoIndex:set(f67_local9)
				end
			end
		end
	end
	local f67_local6 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForElement(f67_arg0, f67_arg1, f67_local0)
	local f67_local7 = CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex(f67_arg1, f67_local4)
	f67_local7.robStage = f67_local5
	f67_local7 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(f67_local7)
	if f67_local1 and f67_local2 then
		local f67_local8 = Engine[@"sendclientscriptnotify"]
		local f67_local9 = f67_arg1
		local f67_local10 = "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f67_arg1)
		local f67_local11 = {
			base_weapon_slot = f67_local1,
			weapon = f67_local2,
			attachments = f67_local6,
			camera = "select01",
		}
		if f67_local4 then
			local f67_local12 = f67_local7
		end
		f67_local11.options = f67_local12 or CoD.CACUtility.EmptyWeaponOptions()
		f67_local11.is_item_unlocked = true
		f67_local11.is_item_tokenlocked = true
		f67_local8(f67_local9, f67_local10, f67_local11)
	end
end
CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel = function(f68_arg0, f68_arg1, f68_arg2, f68_arg3)
	local f68_local0 = CoD.BaseUtility.GetMenuLoadoutSlot(f68_arg0)
	local f68_local1 = CoD.BaseUtility.GetMenuSessionMode(f68_arg0)
	local f68_local2 = f68_arg1:getModel()
	local f68_local3 = f68_arg0._weaponAttachmentString or ""
	local f68_local4 = ""
	local f68_local5 = CoD.CACUtility.EmptyItemIndex
	local f68_local6 = CoD.CACUtility.EmptyItemIndex
	if f68_local2 then
		if f68_local2.attachmentRef then
			f68_local4 = f68_local2.attachmentRef:get()
		end
		if f68_arg3 then
			if f68_local2.itemIndex then
				f68_local5 = f68_local2.itemIndex:get()
			end
			if f68_local2.baseAttachmentItemIndex then
				f68_local6 = f68_local2.baseAttachmentItemIndex:get()
			end
		end
	end
	local f68_local7 = f68_arg0._weaponItemIndex
	local f68_local8, f68_local9 = CoD.CACUtility.GetWeaponNameHashAndAttachmentsForXcam(f68_arg2, nil, f68_local0, nil, f68_local1, f68_local7, f68_local5)
	if f68_arg3 then
		if f68_local3 == "" then
			f68_local3 = f68_local4
		else
			f68_local3 = f68_local3 .. "+" .. f68_local4
		end
		if CoD.CACUtility.EmptyItemIndex < f68_local6 then
			f68_local3 = f68_local3 .. "+" .. Engine[@"getattachmentref"](f68_local7, f68_local6, f68_local1)
		end
	end
	if not IsInGame() and f68_local8 ~= 0x0 and f68_local7 then
		Engine[@"sendclientscriptnotify"](f68_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f68_arg2), {
			base_weapon_slot = f68_local0,
			weapon = f68_local8,
			attachments = f68_local3,
			camera = "attach",
			options = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex(f68_arg2, f68_local7)),
			is_item_unlocked = true,
			is_item_tokenlocked = false,
		})
	end
end
CoD.ZMLoadoutUtility.OpenArmoryAttachmentOverlay = function(f69_arg0, f69_arg1, f69_arg2, f69_arg3)
	local f69_local0 = CoD.CACUtility.EmptyItemIndex
	local f69_local1 = CoD.BaseUtility.GetMenuSessionMode(f69_arg3)
	local f69_local2 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForElement(f69_arg1, f69_arg2, f69_local1)
	local f69_local3 = f69_arg1:getModel()
	if f69_local3 and f69_local3.itemIndex then
		f69_local0 = f69_local3.itemIndex:get()
		if not f69_arg1.armoryAttachmentTable then
			local f69_local4 = CoD.ZMLoadoutUtility.GetEquippedArmoryAttachments(f69_arg2, f69_local0, f69_local1)
			f69_arg1.armoryAttachmentTable = f69_local4.attachmentList
		end
	end
	OpenOverlay(f69_arg0, "Armory_AttachmentSelect", f69_arg2, {
		_sessionMode = f69_local1,
		_armoryAttachmentTable = f69_arg1.armoryAttachmentTable,
		_loadoutSlot = f69_arg3.__loadoutType,
		_weaponItemIndex = f69_local0,
		_weaponItemModel = f69_local3,
		_weaponAttachmentString = f69_local2,
		_inArmory = true,
	})
end
CoD.ZMLoadoutUtility.SetModelToArmoryWeaponItemModel = function(f70_arg0, f70_arg1, f70_arg2)
	if f70_arg2._weaponItemModel then
		f70_arg0:setModel(f70_arg2._weaponItemModel, f70_arg1)
	end
end
CoD.ZMLoadoutUtility.EquipArmoryElementAttachment = function(f71_arg0, f71_arg1, f71_arg2)
	if f71_arg2._armoryAttachmentTable then
		local f71_local0 = f71_arg0:getModel(f71_arg1, "itemIndex")
		local f71_local1 = f71_arg0:getModel(f71_arg1, "isUberAttachment")
		local f71_local2 = f71_local0 and f71_local0:get()
		if f71_local2 and CoD.ZMLoadoutUtility.EquipArmoryAttachment(f71_arg2, f71_arg1, f71_local2, f71_local1 and f71_local1:get()) then
			CoD.ZMLoadoutUtility.UpdateArmoryAttachments(f71_arg2, f71_arg1)
			if f71_arg0.equipSound and f71_arg0.equipSound ~= 0x0 then
				Engine[@"hash_498954175CA6A32C"](f71_arg0.equipSound)
			end
		end
	end
end
CoD.ZMLoadoutUtility.ToggleArmoryElementAttachment = function(f72_arg0, f72_arg1, f72_arg2)
	if f72_arg2._armoryAttachmentTable then
		local f72_local0 = f72_arg0:getModel(f72_arg1, "itemIndex")
		local f72_local1 = f72_arg0:getModel(f72_arg1, "isUberAttachment")
		local f72_local2 = f72_local0 and f72_local0:get()
		local f72_local3 = f72_local1 and f72_local1:get()
		if not f72_local2 then
			return
		end
		for f72_local4 = 1, #f72_arg2._armoryAttachmentTable, 1 do
			if f72_arg2._armoryAttachmentTable[f72_local4].itemIndex == f72_local2 then
				CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment(f72_arg0, f72_arg1, f72_arg2)
				return
			end
		end
		CoD.ZMLoadoutUtility.EquipArmoryElementAttachment(f72_arg0, f72_arg1, f72_arg2)
	end
end
CoD.ZMLoadoutUtility.ForceEquipArmoryOpticElementAttachment = function(f73_arg0, f73_arg1, f73_arg2)
	if f73_arg2._armoryAttachmentTable then
		local f73_local0 = f73_arg0:getModel(f73_arg1, "itemIndex")
		local f73_local1 = f73_local0 and f73_local0:get()
		local f73_local2 = CoD.CACUtility.IsAttachmentOptic(f73_arg2._weaponItemIndex, f73_local1, CoD.BaseUtility.GetMenuSessionMode(f73_arg2))
		if f73_local2 then
			local f73_local3 = f73_arg0:getModel(f73_arg1, "isUberAttachment")
			local f73_local4 = f73_local3 and f73_local3:get()
			local f73_local5 = nil
			for f73_local6 = 1, #f73_arg2._armoryAttachmentTable, 1 do
				if f73_arg2._armoryAttachmentTable[f73_local6].isOptic == f73_local2 then
					if not f73_local5 then
						f73_local5 = f73_local6
					end
					return false
				end
			end
			if f73_local5 then
				f73_arg2._armoryAttachmentTable[f73_local5] = {
					itemIndex = f73_local1,
					isOptic = f73_local2,
					isUberAttachment = f73_local4,
				}
				CoD.ZMLoadoutUtility.UpdateArmoryAttachments(f73_arg2, f73_arg1)
			end
		end
	end
end
CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment = function(f74_arg0, f74_arg1, f74_arg2)
	if f74_arg2._armoryAttachmentTable then
		local f74_local0 = f74_arg0:getModel(f74_arg1, "itemIndex")
		local f74_local1 = f74_local0 and f74_local0:get()
		if f74_local1 and CoD.ZMLoadoutUtility.RemoveArmoryAttachment(f74_arg1, f74_arg2, f74_local1) then
			local f74_local2 = f74_arg0:getModel(f74_arg1, "upgradedAttachmentIndex")
			local f74_local3 = f74_local2 and f74_local2:get()
			if f74_local3 then
				CoD.ZMLoadoutUtility.RemoveArmoryAttachment(f74_arg1, f74_arg2, f74_local3)
			end
			if f74_arg0.unequipSound and f74_arg0.unequipSound ~= 0x0 then
				Engine[@"hash_498954175CA6A32C"](f74_arg0.unequipSound)
			end
			CoD.ZMLoadoutUtility.UpdateArmoryAttachments(f74_arg2, f74_arg1)
		end
	end
end
CoD.ZMLoadoutUtility.SetShowcaseWeapon = function(f75_arg0, f75_arg1, f75_arg2)
	local f75_local0 = CoD.BaseUtility.GetMenuSessionMode(f75_arg2)
	local f75_local1 = Enum[@"hash_DFC2505E609427C"][@"category_zombies"]
	local f75_local2 = f75_arg0:getModel()
	if f75_local2 and f75_local2.itemIndex then
		local f75_local3 = f75_local2.itemIndex:get()
		Engine[@"setheroshowcaseweaponattribute"](f75_arg1, f75_local0, f75_local1, @"weaponindex", f75_local3)
		local f75_local4 = CoD.ZMLoadoutUtility.GetVariantSlot(f75_arg1, f75_local3, false)
		if f75_local4 then
			Engine[@"setheroshowcaseweaponattribute"](f75_arg1, f75_local0, f75_local1, @"camoindex", f75_local4.camoIndex:get())
			Engine[@"setheroshowcaseweaponattribute"](f75_arg1, f75_local0, f75_local1, @"weaponmodelslot", f75_local4.weaponModelSlot:get())
		end
	end
	if f75_arg0.armoryAttachmentTable then
		for f75_local6, f75_local7 in ipairs(f75_arg0.armoryAttachmentTable) do
			Engine[@"setheroshowcaseweaponattribute"](f75_arg1, f75_local0, f75_local1, @"attachment", f75_local7.itemIndex, f75_local6 - 1)
		end
	end
	CoD.OverlayUtility.ShowToast(nil, Engine[@"hash_4F9F1239CFD921FE"](@"hash_24D7E6B5D2385EE7"), "", "ui_menu_popups_toastnotification_icon_gunrack")
end
CoD.ZMLoadoutUtility.ShowBubblegumBuffModel = function(f76_arg0, f76_arg1, f76_arg2, f76_arg3)
	local f76_local0 = f76_arg2:getModel()
	if f76_local0 then
		local f76_local1 = f76_local0.itemIndex:get()
		local f76_local2 = f76_local0.globalItemIndex:get()
		local f76_local3 = Engine[@"getitemgroup"](f76_local1, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"])
		local f76_local4 = not CoD.ZMLoadoutUtility.IsBGBItemLocked(f76_arg0, f76_arg2, f76_arg3)
		local f76_local5 = "select01"
		local f76_local6 = 0x0
		local f76_local7 = 1
		local f76_local8 = CoD.CACUtility.GetUnlockableItemInfo(f76_local2, Enum[@"emodes"][@"mode_zombies"])
		if f76_local8 then
			f76_local6 = f76_local8[@"previewmodelname"] or 0x0
			f76_local7 = f76_local8[@"previewmodelscale"] or 1
		end
		Engine[@"sendclientscriptnotify"](f76_arg3, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f76_arg3), {
			base_weapon_slot = f76_local3,
			weapon = f76_local6,
			attachments = "",
			camera = f76_local5,
			is_item_unlocked = f76_local4,
			xmodel_scale = f76_local7,
		})
	end
end
CoD.ZMLoadoutUtility.SetBubblegumBuffLoadoutSelectedIndexWithPromptSlot = function(f77_arg0, f77_arg1)
	local f77_local0 = DataSources.BGBLoadout.getModel(f77_arg0)
	f77_local0.selectedIndex:set(CoD.ZMLoadoutUtility.BGBSlotPositions[f77_arg1].index)
end
CoD.ZMLoadoutUtility.EquipBubblegumBuff = function(f78_arg0, f78_arg1, f78_arg2)
	local f78_local0 = Engine[@"getequippedbubblegumpack"](f78_arg2)
	local f78_local1 = CoD.BaseUtility.GetMenuModel(f78_arg0)
	if f78_local1 and f78_local1.classNum then
		f78_local0 = f78_local1.classNum:get()
		local f78_local2 = Engine[@"getmodelforcontroller"](f78_arg2)
		CoD.ZMLoadoutUtility.SetupBGBLoadout(f78_local2:create("BGBLoadout"), f78_arg2, f78_local0, f78_local1)
	end
	local f78_local2 = DataSources.BGBLoadout.getModel(f78_arg2)
	f78_local2 = f78_local2.selectedIndex:get()
	local f78_local3 = f78_arg1:getModel()
	f78_local3 = f78_local3.itemIndex:get()
	local f78_local4 = nil
	if f78_local2 == -1 then
		return
	end
	local f78_local5 = nil
	for f78_local6 = 0, CoD.BGBUtility.NumBuffsPerPack - 1, 1 do
		if Engine[@"getbubblegumbuff"](f78_arg2, f78_local0, f78_local6) == f78_local3 then
			f78_local5 = f78_local6
			f78_local4 = Engine[@"getbubblegumbuff"](f78_arg2, f78_local0, f78_local2)
			break
		end
	end
	Engine[@"setbubblegumbuff"](f78_arg2, f78_local0, f78_local2, f78_local3)
	if f78_local5 then
		Engine[@"setbubblegumbuff"](f78_arg2, f78_local0, f78_local5, f78_local4)
	end
	local f78_local6 = CoD.CACUtility.GetUnlockableItemTable()
	local f78_local7 = f78_arg1:getModel()
	f78_local7 = f78_local7.globalItemIndex
	Engine[@"hash_498954175CA6A32C"](f78_local6[f78_local7.globalItemIndex:get()][@"equipsound"])
	ForceNotifyControllerModel(f78_arg2, "BubbleGumBuffUpdated")
end
CoD.ZMLoadoutUtility.ChangeLoadoutPreviewLinkForPC = function(f79_arg0, f79_arg1, f79_arg2, f79_arg3, f79_arg4)
	f79_arg1:linkToElementModel(f79_arg3[f79_arg4], nil, false, function(model)
		f79_arg1:setModel(model, f79_arg2)
	end)
end
CoD.ZMLoadoutUtility.SetupPreviewPCPip = function(f81_arg0, f81_arg1)
	f81_arg0:appendEventHandler("gain_focus", function(f82_arg0, f82_arg1)
		if IsMouseOrKeyboard(f82_arg1.controller) then
			LUI.GridLayout.setActiveItem(f82_arg0.gridInfoTable.parentGrid, f82_arg0, nil)
		end
	end)
	f81_arg0:appendEventHandler("lose_focus", function(f83_arg0, f83_arg1)
		if IsMouseOrKeyboard(f83_arg1.controller) then
			local f83_local0 = CoD.GetMouseFocus(f81_arg1)
			if f83_local0 == nil or f83_local0:getParent() ~= f83_arg0:getParent() then
				local f83_local1 = Engine[@"getmodelforcontroller"](f81_arg1)
				LUI.GridLayout.setActiveItem(f83_arg0.gridInfoTable.parentGrid, LUI.GridLayout.getItemAtPosition(f83_arg0.gridInfoTable.parentGrid, 1, f83_local1.selectedCustomClass:get() + 1, false), nil)
			end
		end
	end)
end
CoD.ZMLoadoutUtility.AddPreviewBumperNavigationPC = function(f84_arg0, f84_arg1, f84_arg2, f84_arg3)
	CoD.GridAndListUtility.AddGenericNavigationInternal(f84_arg1, f84_arg2, f84_arg3, nil, nil, Enum[@"luibutton"][@"lui_key_lb"], Enum[@"luibutton"][@"lui_key_rb"], "zmQuickEquip", true, function()
		if f84_arg2.activeWidget and not CoD.ZMLoadoutUtility.ShouldHideLoadoutPreviewSelectButton(f84_arg1, f84_arg2, f84_arg3, "selectedCustomClass", "classNum") then
			CoD.ZMLoadoutUtility.SetEquippedBubbleGumPackToSelectedClass(f84_arg2.activeWidget, f84_arg3, f84_arg1)
			CoD.CACUtility.SelectCustomClass(f84_arg3, f84_arg2.activeWidget)
		end
	end)
end
CoD.ZMLoadoutUtility.RemovePreviewBumperNavigationPC = function(f86_arg0, f86_arg1, f86_arg2, f86_arg3)
	CoD.GridAndListUtility.RemoveGridElementFromBumperGridType(f86_arg1, f86_arg2, "zmQuickEquip")
end
CoD.ZMLoadoutUtility.LoadoutPreviewOcclusionWatcherPC = function(f87_arg0, f87_arg1, f87_arg2)
	f87_arg0:appendEventHandler("occlusion_change", function(f88_arg0, f88_arg1)
		if f88_arg1.occluded then
			CoD.DirectorUtility.HideLoadoutPreview(f87_arg2)
		end
	end)
end
CoD.ZMLoadoutUtility.UpdateZMSpecialWeaponStageModel = function(f89_arg0, f89_arg1, f89_arg2)
	local f89_local0 = CoD.BaseUtility.GetMenuSessionMode(f89_arg0)
	local f89_local1 = CoD.BaseUtility.GetMenuLoadoutSlot(f89_arg0)
	local f89_local2 = f89_arg1:getModel()
	if f89_local2 and f89_local2.itemRefHash then
		Engine[@"sendclientscriptnotify"](f89_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f89_arg2), {
			base_weapon_slot = f89_local1,
			weapon = f89_local2.itemRefHash:get(),
			attachments = "",
			camera = "select01",
			is_item_unlocked = true,
		})
	end
end
CoD.ZMLoadoutUtility.UpdateAttachmentListModelForWeaponAttributes = function(f90_arg0, f90_arg1, f90_arg2)
	local f90_local0 = f90_arg1:getModel()
	if f90_arg0.WeaponAttributes and f90_local0 and f90_local0.weaponAttributes then
		f90_arg0.WeaponAttributes:setModel(f90_local0.weaponAttributes, f90_arg2)
	end
end
CoD.ZMLoadoutUtility.ForceSavedActiveIndexToFirstSignatureWeapon = function(f91_arg0)
	if f91_arg0 then
		f91_arg0:findItem(nil, {
			selectIndex = true,
		}, true)
	end
end
CoD.ZMLoadoutUtility.ResetAttachmentListModelForWeaponAttributes = function(f92_arg0, f92_arg1, f92_arg2)
	if not f92_arg0.WeaponAttributes then
		return
	end
	local f92_local0 = CoD.BaseUtility.GetMenuSessionMode(f92_arg0)
	local f92_local1, f92_local2 = CoD.ZMLoadoutUtility.UpdateEquippedWeaponAttachmentAttributes(f92_arg0, f92_arg0._weaponItemIndex, f92_local0)
	local f92_local3 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f92_arg2), "ZMArmoryNoAttachmentAttributesModel"), "weaponAttributes")
	local f92_local4 = CoD.CACUtility.GetUnlockableItemInfo(f92_arg0._weaponItemIndex, f92_local0)
	local f92_local5 = f92_local4.attributesTable
	if f92_local4.attributesTableZM then
		f92_local5 = f92_local4.attributesTableZM
	end
	local f92_local6 = function(f93_arg0)
		local f93_local0 = (f92_local5 and f92_local5[f93_arg0] or 0) + f92_local2[f93_arg0]
		local f93_local1 = Engine[@"createmodel"](f92_local3, f93_arg0)
		f93_local1:set(f92_local5[f93_arg0] .. "," .. f93_local0)
	end
	local f92_local7 = function(f94_arg0)
		local f94_local0 = f92_local2[f94_arg0] - (f92_local5 and f92_local5[f94_arg0] or 0)
		if f94_local0 ~= 0 then
			local f94_local1 = Engine[@"createmodel"](f92_local3, f94_arg0)
			f94_local1:set(f92_local5[f94_arg0] .. "," .. f94_local0)
		else
			local f94_local1 = Engine[@"createmodel"](f92_local3, f94_arg0)
			f94_local1:set(tostring(f92_local5[f94_arg0]))
		end
	end
	f92_local6("damage")
	f92_local6("range")
	f92_local6("fireRate")
	f92_local6("accuracy")
	f92_local7("magCount")
	f92_local7("magSize")
	local f92_local8 = Engine[@"createmodel"](f92_local3, "uberName")
	f92_local8:set(f92_local5.uberName)
	f92_local8 = Engine[@"createmodel"](f92_local3, "uberImage")
	f92_local8:set(f92_local5.uberImage)
	f92_arg0.WeaponAttributes:setModel(f92_local3, f92_arg2)
end
CoD.ZMLoadoutUtility.GetBGBSlotEditingString = function(f95_arg0)
	local f95_local0 = f95_arg0
	local f95_local1 = ""
	for f95_local5, f95_local6 in pairs(CoD.ZMLoadoutUtility.BGBSlotPositions) do
		if f95_local6.index == f95_local0 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_594576D2130B45EE", f95_local6.index + 1)
		end
	end
	return f95_local1
end
CoD.ZMLoadoutUtility.GetUnlockDescriptionForFeature = function(f96_arg0, f96_arg1, f96_arg2)
	local f96_local0 = Enum[@"emodes"][@"mode_zombies"]
	local f96_local1 = f96_arg0:getModel()
	if f96_local1 and f96_local0 and CoD.CACUtility.IsProgressionEnabled(f96_local0) then
		local f96_local2 = CoD.CACUtility.GetClassesUnlockableItemUnlockInfo(f96_local1.classNum:get(), "featureItemIndex")
		if f96_local2 then
			return CoD.GetUnlockStringForItemIndex(f96_arg1, f96_local2, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f96_local0)
		end
	end
	return ""
end
CoD.ZMLoadoutUtility.GetUnlockRankIconLargeForFeature = function(f97_arg0, f97_arg1)
	local f97_local0 = Enum[@"emodes"][@"mode_zombies"]
	local f97_local1 = f97_arg0:getModel()
	if f97_local1 and f97_local0 and CoD.CACUtility.IsProgressionEnabled(f97_local0) then
		local f97_local2 = CoD.CACUtility.GetClassesUnlockableItemUnlockInfo(f97_local1.classNum:get(), "featureItemIndex")
		if f97_local2 then
			return Engine[@"hash_7E1B786B1A765D9E"](Engine[@"getitemunlocklevel"](f97_local2, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f97_local0), f97_local0)
		end
	end
	return 0x0
end
CoD.ZMLoadoutUtility.GetArmoryAttachmentUnlockDescription = function(f98_arg0, f98_arg1, f98_arg2)
	local f98_local0 = f98_arg1
	local f98_local1 = tonumber(f98_arg2)
	local f98_local2 = CoD.BaseUtility.GetMenuSessionMode(f98_arg0)
	local f98_local3 = f98_arg0._weaponItemIndex
	if CoD.CACUtility.IsProgressionEnabled(f98_local2) and f98_local3 and f98_local3 > CoD.CACUtility.EmptyItemIndex then
		local f98_local4 = Engine[@"getitemattachmentrank"](f98_local3, f98_local1, f98_local2)
		if f98_local4 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_1EF33BF324CE24F5", f98_local4 + 2)
		end
	end
	return ""
end
CoD.ZMLoadoutUtility.GetEquippedSignatureWeaponImage = function(f99_arg0, f99_arg1, f99_arg2)
	if f99_arg0.useVariantSlot and f99_arg0.useVariantSlot:get() > 0 then
		return f99_arg0.image:get()
	else
		local f99_local0 = f99_arg2
		local f99_local1 = CoD.ZMLoadoutUtility.GetWeaponModelSlot(f99_local0, f99_arg1)
		if f99_local1 and f99_local1 > 0 then
			local f99_local2 = CoD.CACUtility.GetUnlockableItemInfo(f99_local0, Enum[@"emodes"][@"mode_zombies"])
			local f99_local3 = f99_local2.zmPreviewImage
			local f99_local4 = Engine[@"hash_79F0BB7D52A7A978"](Engine[@"hash_7B98952F69D937F9"](f99_local0, Enum[@"statindexoffset"].STATINDEXOFFSET_WEAPON, Enum[@"emodes"][@"mode_zombies"]))
			local f99_local5 = f99_local4[f99_local1 + 1]
			if f99_local5 and f99_local5[@"hash_5C2AA73D9F82E9C2"] and f99_local5[@"ismark2"] then
				f99_local3 = f99_local5[@"imagezm"] or f99_local3
			end
			return f99_local3
		else
			local f99_local2 = CoD.CACUtility.GetUnlockableItemInfo(f99_local0, Enum[@"emodes"][@"mode_zombies"])
			return f99_local2.zmPreviewImage
		end
	end
end
CoD.ZMLoadoutUtility.GetEquippedSignatureWeaponName = function(f100_arg0, f100_arg1, f100_arg2)
	if f100_arg0.useVariantSlot and f100_arg0.useVariantSlot:get() > 0 then
		return f100_arg0.displayName:get()
	else
		local f100_local0 = f100_arg2
		local f100_local1 = CoD.ZMLoadoutUtility.GetWeaponModelSlot(f100_local0, f100_arg1)
		if f100_local1 and f100_local1 > 0 then
			local f100_local2 = Engine[@"hash_4F9F1239CFD921FE"](Engine[@"getitemname"](f100_local0, Enum[@"statindexoffset"].STATINDEXOFFSET_WEAPON, Enum[@"emodes"][@"mode_zombies"]))
			local f100_local3 = Engine[@"hash_79F0BB7D52A7A978"](Engine[@"hash_7B98952F69D937F9"](f100_local0, Enum[@"statindexoffset"].STATINDEXOFFSET_WEAPON, Enum[@"emodes"][@"mode_zombies"]))
			local f100_local4 = f100_local3[f100_local1 + 1]
			if f100_local4 then
				if f100_local4[@"hash_5C2AA73D9F82E9C2"] and f100_local4[@"ismark2"] then
					if f100_local4[@"displayname"] then
						f100_local2 = Engine[@"hash_4F9F1239CFD921FE"](f100_local4[@"displayname"]) or f100_local2
					end
				else
					f100_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_341954FC612B5845", f100_local2)
				end
			end
			return f100_local2
		else
			local f100_local2 = CoD.CACUtility.GetUnlockableItemInfo(f100_local0, Enum[@"emodes"][@"mode_zombies"])
			return Engine[@"hash_4F9F1239CFD921FE"](f100_local2.displayName)
		end
	end
end
CoD.ZMLoadoutUtility.IsBubbleGumBuffEquippedInCurrentSlot = function(f101_arg0, f101_arg1, f101_arg2)
	local f101_local0 = f101_arg1:getModel()
	if not f101_local0 then
		return false
	end
	local f101_local1 = Engine[@"getmodel"](f101_local0, "itemIndex")
	if not f101_local1 then
		return false
	end
	local f101_local2 = Engine[@"getequippedbubblegumpack"](f101_arg2)
	local f101_local3 = CoD.BaseUtility.GetMenuModel(f101_arg0)
	if f101_local3 and f101_local3.classNum then
		f101_local2 = f101_local3.classNum:get()
		local f101_local4 = Engine[@"getmodelforcontroller"](f101_arg2)
		CoD.ZMLoadoutUtility.SetupBGBLoadout(f101_local4:create("BGBLoadout"), f101_arg2, f101_local2, f101_local3)
	end
	local f101_local4 = Engine[@"getmodelvalue"](f101_local1)
	local f101_local5 = DataSources.BGBLoadout.getModel(f101_arg2)
	if Engine[@"getbubblegumbuff"](f101_arg2, f101_local2, f101_local5.selectedIndex:get()) == f101_local4 then
		return true
	end
	return false
end
CoD.ZMLoadoutUtility.IsBubbleGumBuffEquippedInAnySlot = function(f102_arg0, f102_arg1, f102_arg2)
	local f102_local0 = f102_arg1:getModel()
	if not f102_local0 then
		return false
	end
	local f102_local1 = Engine[@"getmodel"](f102_local0, "itemIndex")
	if not f102_local1 then
		return false
	end
	local f102_local2 = Engine[@"getequippedbubblegumpack"](f102_arg2)
	local f102_local3 = CoD.BaseUtility.GetMenuModel(f102_arg0)
	if f102_local3 and f102_local3.classNum then
		f102_local2 = f102_local3.classNum:get()
		local f102_local4 = Engine[@"getmodelforcontroller"](f102_arg2)
		CoD.ZMLoadoutUtility.SetupBGBLoadout(f102_local4:create("BGBLoadout"), f102_arg2, f102_local2, f102_local3)
	end
	local f102_local4 = Engine[@"getmodelvalue"](f102_local1)
	for f102_local5 = 0, CoD.BGBUtility.NumBuffsPerPack - 1, 1 do
		if Engine[@"getbubblegumbuff"](f102_arg2, f102_local2, f102_local5) == f102_local4 then
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped = function(f103_arg0, f103_arg1, f103_arg2)
	local f103_local0 = f103_arg0:getModel(f103_arg1, "itemIndex")
	local f103_local1 = f103_local0 and f103_local0:get()
	return f103_local1 and CoD.ZMLoadoutUtility.IsArmoryAttachmentEquipped(f103_arg2, f103_local1)
end
CoD.ZMLoadoutUtility.IsArmoryElementBaseAttachmentEquipped = function(f104_arg0, f104_arg1, f104_arg2)
	local f104_local0 = f104_arg0:getModel(f104_arg1, "baseAttachmentItemIndex")
	local f104_local1 = f104_local0 and f104_local0:get()
	return f104_local1 and CoD.ZMLoadoutUtility.IsArmoryAttachmentEquipped(f104_arg2, f104_local1)
end
CoD.ZMLoadoutUtility.IsArmoryAnyOpticAttachmentEquipped = function(f105_arg0, f105_arg1)
	for f105_local3, f105_local4 in ipairs(f105_arg1._armoryAttachmentTable) do
		if f105_local4.isOptic and f105_local4.itemIndex ~= CoD.CACUtility.EmptyItemIndex then
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.CanEquipArmoryAttachment = function(f106_arg0, f106_arg1, f106_arg2, f106_arg3, f106_arg4)
	if not f106_arg2 then
		return false
	end
	local f106_local0 = CoD.ZMLoadoutUtility.ArmoryUberAllocation - 1
	local f106_local1 = 0
	local f106_local2 = 1
	if f106_arg4 then
		f106_local2 = f106_local2 + f106_local0
	end
	local f106_local3 = CoD.ZMLoadoutUtility.WeaponAttachmentHasFourSlots(f106_arg1, f106_arg3)
	for f106_local8, f106_local9 in ipairs(f106_arg2) do
		if not f106_local9.isOptic and f106_local9.itemIndex == CoD.CACUtility.EmptyItemIndex then
			f106_local1 = f106_local1 + 1
		elseif f106_local9.isUberAttachment then
			f106_local2 = f106_local2 + f106_local0
		end
		local f106_local7 = f106_local8 - 1
		if f106_local2 <= f106_local1 and (not f106_local3 or f106_local8 <= 4) then
			if CoD.CACUtility.IsProgressionEnabled(f106_arg1) then
				if not Engine[@"isattachmentslotlocked"](f106_arg0, f106_arg3, f106_local7, f106_arg1) then
					return true
				end
			end
			return true
		end
	end
	return false
end
CoD.ZMLoadoutUtility.CanArmoryElementAttachmentBeEquipped = function(f107_arg0, f107_arg1, f107_arg2)
	local f107_local0 = CoD.BaseUtility.GetMenuSessionMode(f107_arg2)
	local f107_local1 = f107_arg0:getModel()
	local f107_local2 = f107_local1.weaponIndex
	if f107_local2 then
		f107_local2 = f107_local1.weaponIndex:get()
	end
	local f107_local3 = f107_local1.itemindex
	if f107_local3 then
		f107_local3 = f107_local1.itemindex:get()
	end
	local f107_local4 = f107_local1.isUberAttachment
	if f107_local4 then
		f107_local4 = f107_local1.isUberAttachment:get()
	end
	if f107_local3 then
		return CoD.ZMLoadoutUtility.CanEquipArmoryAttachment(f107_arg1, f107_local0, f107_arg2._armoryAttachmentTable, f107_local2, f107_local4)
	else
		return false
	end
end
CoD.ZMLoadoutUtility.IsCACItemBubbleGum = function(f108_arg0, f108_arg1, f108_arg2)
	local f108_local0 = CoD.BaseUtility.GetMenuSessionMode(f108_arg0)
	local f108_local1 = f108_arg1:getModel()
	if f108_local1 and f108_local1.itemIndex then
		local f108_local2 = f108_local1.itemIndex:get()
		if CoD.CACUtility.EmptyItemIndex < f108_local2 then
			local f108_local3 = Engine[@"getitemgroup"](f108_local2, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f108_local0)
			if f108_local3 == "bubblegum" or f108_local3 == "bubblegum_consumable" then
				return true
			end
		end
	end
	return false
end
CoD.ZMLoadoutUtility.IsBGBItemLocked = function(f109_arg0, f109_arg1, f109_arg2)
	if not CoD.CACUtility.IsProgressionEnabled(CoD.BaseUtility.GetMenuSessionMode(f109_arg0)) then
		return false
	else
		local f109_local0 = CoD.SafeGetModelValue(f109_arg1:getModel(), "dlcIndex")
		if not f109_local0 or f109_local0 < Enum[@"dlcindex_t"][@"content_dlc1_index"] then
			return CoD.CACUtility.IsCACItemLocked(f109_arg0, f109_arg1, f109_arg2)
		else
			return not Engine[@"hasentitlement"](f109_arg2, Engine[@"converttoxhash"]("dlc" .. f109_local0 - Enum[@"dlcindex_t"][@"content_dlc0zm_index"]))
		end
	end
end
CoD.ZMLoadoutUtility.ShouldHideLoadoutPreviewSelectButton = function(f110_arg0, f110_arg1, f110_arg2, f110_arg3, f110_arg4)
	local f110_local0 = CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(f110_arg1, f110_arg2, f110_arg3, f110_arg4)
	local f110_local1 = false
	local f110_local2 = f110_arg1:getModel()
	if f110_local2 and f110_local2.classNum then
		f110_local1 = CoD.CACUtility.IsFeatureItemLocked(f110_arg2, CoD.CACUtility.GetClassesUnlockableItemUnlockInfo(f110_local2.classNum:get(), "featureItemIndex"), Enum[@"emodes"][@"mode_zombies"])
	end
	return f110_local0 or f110_local1
end
CoD.ZMLoadoutUtility.IsCurrentPreviewClassLocked = function(f111_arg0, f111_arg1)
	local f111_local0 = Enum[@"emodes"][@"mode_zombies"]
	local f111_local1 = f111_arg0:getModel()
	if f111_local1 and f111_local1.classNum then
		return CoD.CACUtility.IsFeatureItemLocked(f111_arg1, CoD.CACUtility.GetClassesUnlockableItemUnlockInfo(f111_local1.classNum:get(), "featureItemIndex"), f111_local0)
	else
		return false
	end
end
CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked = function(f112_arg0, f112_arg1, f112_arg2)
	local f112_local0 = CoD.BaseUtility.GetMenuSessionMode(f112_arg0)
	if not CoD.CACUtility.IsProgressionEnabled(f112_local0) then
		return false
	end
	local f112_local1 = f112_arg1:getModel()
	local f112_local2 = f112_arg0._weaponItemIndex
	if f112_local1 and f112_local2 and CoD.CACUtility.EmptyItemIndex < f112_local2 then
		local f112_local3 = f112_local1.itemIndex:get()
		if CoD.CACUtility.EmptyItemIndex < f112_local3 then
			return Engine[@"isitemattachmentlocked"](f112_arg2, f112_local2, f112_local3, f112_local0)
		end
	end
	return false
end
CoD.ZMLoadoutUtility.WeaponAttachmentHasFourSlots = function(f113_arg0, f113_arg1)
	local f113_local0 = CoD.CACUtility.GetUnlockableItemInfo(f113_arg1, f113_arg0)
	if f113_local0 and CoD.CACUtility.EmptyItemIndex < f113_arg1 then
		local f113_local1
		if f113_local0.itemGroup ~= "weapon_launcher" and f113_local0.itemGroup ~= "weapon_special" then
			f113_local1 = false
		else
			f113_local1 = true
		end
		return f113_local1
	else
	end
end
CoD.ZMLoadoutUtility.IsWeaponAttachmentPipFourSlots = function(f114_arg0, f114_arg1)
	local f114_local0 = f114_arg1:getModel()
	if f114_local0 and f114_local0.itemIndex then
		return CoD.ZMLoadoutUtility.WeaponAttachmentHasFourSlots(CoD.BaseUtility.GetMenuSessionMode(f114_arg0), f114_local0.itemIndex:get())
	else
		return false
	end
end
CoD.ZMLoadoutUtility.IsAttachmentSlotLocked = function(f115_arg0, f115_arg1, f115_arg2, f115_arg3)
	local f115_local0 = CoD.BaseUtility.GetMenuSessionMode(f115_arg0)
	if not CoD.CACUtility.IsProgressionEnabled(f115_local0) or f115_local0 ~= Enum[@"emodes"][@"mode_zombies"] then
		return false
	end
	local f115_local1 = f115_arg1:getModel()
	if f115_local1 and f115_local1.itemIndex then
		local f115_local2 = f115_local1.itemIndex:get()
		if CoD.CACUtility.EmptyItemIndex < f115_local2 then
			return Engine[@"isattachmentslotlocked"](f115_arg2, f115_local2, f115_arg3, f115_local0)
		end
	end
	return false
end
CoD.ZMLoadoutUtility.IsAttachmentMutuallyExclusiveWithSelection = function(f116_arg0, f116_arg1, f116_arg2)
	local f116_local0 = Enum[@"emodes"][@"mode_zombies"]
	local f116_local1 = f116_arg1:getModel()
	if f116_local1 and f116_local1.itemIndex and f116_local1.weaponIndex then
		local f116_local2 = CoD.ZMLoadoutUtility.GetMutuallyExclusiveArmoryAttachments(f116_arg2, f116_local1.weaponIndex:get(), f116_local1.itemIndex:get(), f116_local0)
		for f116_local3 = 1, #f116_local2, 1 do
			if f116_local2[f116_local3] ~= "" then
				return true
			end
		end
	end
	return false
end
CoD.ZMLoadoutUtility.IsWeaponOptionEquipped = function(f117_arg0, f117_arg1, f117_arg2, f117_arg3)
	if f117_arg0._model then
		local f117_local0 = f117_arg0._model.itemIndex:get()
	end
	if f117_arg3 == "reticleIndex" then
		local f117_local0 = f117_arg0._model and f117_arg0._model.weaponIndex:get()
	end
	local f117_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f117_arg2, f117_local0, false)
	local f117_local2 = f117_arg1:getModel()
	if f117_local2 and f117_local1 and f117_local1[f117_arg3] then
		local f117_local3 = f117_local1[f117_arg3]:get()
		local f117_local4 = f117_local2.weaponOptionSubIndex:get()
		local f117_local5 = f117_local2.weaponOptionType:get()
		if f117_local5 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle"] then
			if CoD.WeaponOptionsUtility.IsReticleItemIndexLoot(f117_local4) then
				local f117_local6 = f117_local2.attachmentRef
				if f117_local6 then
					f117_local6 = f117_local2.attachmentRef:get()
				end
				if f117_local6 then
					return f117_local4 == CoD.WeaponOptionsUtility.GetLootReticleBaseItemIndex(f117_local6, f117_local3)
				end
			else
				return f117_local4 == f117_local3 - f117_local3 % CoD.WeaponOptionsUtility.maxReticleColors
			end
		elseif f117_local5 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_paintjob"] and f117_local2.paintjobSlot then
			local f117_local6 = f117_local2.paintjobSlot:get()
			if f117_local6 ~= Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] then
				return f117_local6 == f117_local3
			end
		end
		return f117_local4 == f117_local3
	else
		return false
	end
end
CoD.ZMLoadoutUtility.IsArmoryPrestigeElementAttachmentEquipped = function(f118_arg0, f118_arg1, f118_arg2)
	local f118_local0 = f118_arg0:getModel(f118_arg1, "itemIndex")
	local f118_local1 = f118_local0 and f118_local0:get()
	local f118_local2 = f118_arg2._model
	if f118_local2 then
		f118_local2 = f118_arg2._model.itemIndex:get()
	end
	local f118_local3 = CoD.ZMLoadoutUtility.GetVariantSlot(f118_arg1, f118_local2, true)
	if not f118_local3 then
		return false
	else
		local f118_local4 = f118_local3.attachment[CoD.ZMLoadoutUtility.PRESTIGE_ATTACHMENT_SLOT]
		if f118_local4 then
			return f118_local1 == f118_local4:get()
		else
			return false
		end
	end
end
CoD.ZMLoadoutUtility.GetArmoryPrestigeAttachmentIndex = function(f119_arg0, f119_arg1)
	local f119_local0 = CoD.BaseUtility.GetMenuModel(f119_arg0)
	local f119_local1 = CoD.ZMLoadoutUtility.GetVariantSlot(f119_arg1, f119_local0.itemIndex:get(), false)
	if f119_local1 and f119_local1.attachment[CoD.ZMLoadoutUtility.PRESTIGE_ATTACHMENT_SLOT] then
		return f119_local1.attachment[CoD.ZMLoadoutUtility.PRESTIGE_ATTACHMENT_SLOT]:get()
	else
		return CoD.CACUtility.EmptyItemIndex
	end
end
CoD.ZMLoadoutUtility.IsArmoryWeaponCharmEquipped = function(f120_arg0, f120_arg1, f120_arg2)
	local f120_local0 = CoD.SafeGetModelValue(f120_arg1:getModel(), "itemIndex")
	local f120_local1 = f120_arg0._model
	if f120_local1 then
		f120_local1 = f120_arg0._model.itemIndex:get()
	end
	local f120_local2 = CoD.ZMLoadoutUtility.GetVariantSlot(f120_arg2, f120_local1, true)
	if not f120_local2 or not f120_local0 then
		return false
	elseif f120_local2.charmIndex then
		return f120_local2.charmIndex:get() == f120_local0
	else
		return false
	end
end
CoD.ZMLoadoutUtility.IsArmoryWeaponDeathFxEquipped = function(f121_arg0, f121_arg1, f121_arg2)
	local f121_local0 = CoD.SafeGetModelValue(f121_arg1:getModel(), "itemIndex")
	local f121_local1 = f121_arg0._model
	if f121_local1 then
		f121_local1 = f121_arg0._model.itemIndex:get()
	end
	local f121_local2 = CoD.ZMLoadoutUtility.GetVariantSlot(f121_arg2, f121_local1, true)
	if not f121_local2 or not f121_local0 then
		return false
	elseif f121_local2.deathFxIndex then
		return f121_local2.deathFxIndex:get() == f121_local0
	else
		return false
	end
end
CoD.ZMLoadoutUtility.SetZMSpecialWeaponStageModel = function(f122_arg0, f122_arg1)
	local f122_local0 = Engine[@"getmodelforcontroller"](f122_arg1)
	f122_local0 = f122_local0:create("ZMSpecialWeaponStage")
	f122_local0 = f122_local0:create("stageModel")
	f122_local0:set(f122_arg0:getModel())
end
CoD.ZMLoadoutUtility.UpdateZMSpecialWeaponActiveStageModel = function(f123_arg0, f123_arg1)
	local f123_local0 = f123_arg0:getModel()
	if f123_local0 then
		local f123_local1 = f123_local0.stageDetailDatasource:get()
		if f123_local1 then
			local f123_local2 = Engine[@"getmodelforcontroller"](f123_arg1)
			if f123_local2[f123_local1] then
				f123_local2 = Engine[@"getmodelforcontroller"](f123_arg1)
				if f123_local2[f123_local1]["1"] then
					f123_local2 = Engine[@"getmodelforcontroller"](f123_arg1)
					f123_local2 = f123_local2:create("ZMSpecialWeaponStage")
					f123_local2 = f123_local2:create("stageModel")
					local f123_local3 = f123_local2
					local f123_local4 = f123_local2.set
					local f123_local5 = Engine[@"getmodelforcontroller"](f123_arg1)
					f123_local4(f123_local3, f123_local5[f123_local1]["1"])
				end
			end
		end
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("ZMSpecialWeaponStage", "ZMSpecialWeaponStage", function(f124_arg0, f124_arg1)
	f124_arg0:create("stageModel")
end)
