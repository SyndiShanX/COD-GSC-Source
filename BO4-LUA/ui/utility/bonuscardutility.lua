CoD.BonuscardUtility = {}
CoD.BonuscardUtility.PrimaryGunfighterWildcards = CoDLoadoutsShared.PrimaryGunfighterWildcards
CoD.BonuscardUtility.SecondaryGunfighterWildcards = CoDLoadoutsShared.SecondaryGunfighterWildcards
CoD.BonuscardUtility.GluttonyWildcards = {
	{
		refHash = @"bonuscard_perk_1_gluttony",
		talentFilter = "talent1",
		loadoutSlot = "talent.1",
	},
	{
		refHash = @"bonuscard_perk_2_gluttony",
		talentFilter = "talent2",
		loadoutSlot = "talent.2",
	},
	{
		refHash = @"bonuscard_perk_3_gluttony",
		talentFilter = "talent3",
		loadoutSlot = "talent.3",
	},
}
CoD.BonuscardUtility.OperatorModeWildcards = CoDLoadoutsShared.OperatorModWildcards
CoD.BonuscardUtility.NumBonucardsNeededForAttachmentTable = {
	["primary.attachment.4"] = 1,
	["primary.attachment.5"] = 2,
	["primary.attachment.6"] = 3,
	["secondary.attachment.4"] = 1,
	["secondary.attachment.5"] = 2,
	["secondary.attachment.6"] = 3,
}
CoD.BonuscardUtility.BonuscardNeededForAttachmentSlot = {
	["primary.attachment.5"] = @"bonuscard_primary_operator_mod",
	["secondary.attachment.5"] = @"bonuscard_secondary_operator_mod",
}
CoD.BonuscardUtility.BonuscardNeededForTalentSlot = {
	["talent.4"] = @"bonuscard_perk_1_greed",
	["talent.5"] = @"bonuscard_perk_2_greed",
	["talent.6"] = @"bonuscard_perk_3_greed",
}
CoD.BonuscardUtility.BonuscardModifiedSlotType = LuaEnum.createEnum("NONE", "PRIMARY", "PRIMARY_ATTACHMENT", "PRIMARY_ATTACHMENT_UBER", "SECONDARY", "SECONDARY_ATTACHMENT", "SECONDARY_ATTACHMENT_UBER", "TALENTS", "TALENT_4", "TALENT_5", "TALENT_6")
CoD.BonuscardUtility.BonuscardInfoTable = {
	[@"bonuscard_primary_gunfighter"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT,
	},
	[@"bonuscard_primary_gunfighter_2"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT,
	},
	[@"bonuscard_primary_gunfighter_3"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT,
	},
	[@"bonuscard_primary_operator_mod"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT_UBER,
		unequippableBonuscardsFn = function()
			return CoD.BonuscardUtility.IncompatibleGunfightersForOperatorMod, "primary"
		end,
	},
	[@"bonuscard_secondary_gunfighter"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT,
	},
	[@"bonuscard_secondary_gunfighter_2"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT,
	},
	[@"bonuscard_secondary_gunfighter_3"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT,
	},
	[@"bonuscard_secondary_operator_mod"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT_UBER,
		unequippableBonuscardsFn = function()
			return CoD.BonuscardUtility.IncompatibleGunfightersForOperatorMod, "secondary"
		end,
	},
	[@"bonuscard_perk_1_gluttony"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS,
		unequippableBonuscards = {
			@"bonuscard_perk_2_greed",
			@"bonuscard_perk_3_greed",
		},
	},
	[@"bonuscard_perk_2_gluttony"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS,
		unequippableBonuscards = {
			@"bonuscard_perk_1_greed",
			@"bonuscard_perk_3_greed",
		},
	},
	[@"bonuscard_perk_3_gluttony"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS,
		unequippableBonuscards = {
			@"bonuscard_perk_1_greed",
			@"bonuscard_perk_2_greed",
		},
	},
	[@"bonuscard_perk_1_greed"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_4,
	},
	[@"bonuscard_perk_2_greed"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_5,
	},
	[@"bonuscard_perk_3_greed"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_6,
	},
	[@"bonuscard_overkill"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY,
	},
	[@"bonuscard_underkill"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY,
	},
}
CoD.BonuscardUtility.LoadoutSlotInfoTable = {
	primary = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY,
	},
	secondary = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY,
	},
	["primary.attachment.4"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT,
		contextualBonuscards = {
			@"bonuscard_primary_gunfighter",
			@"bonuscard_primary_gunfighter_2",
			@"bonuscard_primary_gunfighter_3",
			@"bonuscard_primary_operator_mod",
		},
	},
	["primary.attachment.5"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT,
		contextualBonuscards = {
			@"bonuscard_primary_gunfighter",
			@"bonuscard_primary_gunfighter_2",
			@"bonuscard_primary_gunfighter_3",
			@"bonuscard_primary_operator_mod",
		},
	},
	["primary.attachment.6"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT,
		contextualBonuscards = {
			@"bonuscard_primary_gunfighter",
			@"bonuscard_primary_gunfighter_2",
			@"bonuscard_primary_gunfighter_3",
			@"bonuscard_primary_operator_mod",
		},
	},
	["secondary.attachment.4"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT,
		contextualBonuscards = {
			@"bonuscard_secondary_gunfighter",
			@"bonuscard_secondary_gunfighter_2",
			@"bonuscard_secondary_gunfighter_3",
			@"bonuscard_secondary_operator_mod",
		},
	},
	["secondary.attachment.5"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT,
		contextualBonuscards = {
			@"bonuscard_secondary_gunfighter",
			@"bonuscard_secondary_gunfighter_2",
			@"bonuscard_secondary_gunfighter_3",
			@"bonuscard_secondary_operator_mod",
		},
	},
	["secondary.attachment.6"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT,
		contextualBonuscards = {
			@"bonuscard_secondary_gunfighter",
			@"bonuscard_secondary_gunfighter_2",
			@"bonuscard_secondary_gunfighter_3",
			@"bonuscard_secondary_operator_mod",
		},
	},
	["talent.1"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS,
	},
	["talent.2"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS,
	},
	["talent.3"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS,
	},
	["talent.4"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_4,
		contextualBonuscards = {
			@"bonuscard_perk_1_greed",
		},
	},
	["talent.5"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_5,
		contextualBonuscards = {
			@"bonuscard_perk_2_greed",
		},
	},
	["talent.6"] = {
		modifiedSlotEnum = CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_6,
		contextualBonuscards = {
			@"bonuscard_perk_3_greed",
		},
	},
}
CoD.BonuscardUtility.GetGunfighterArrayForSlot = function(f3_arg0)
	if LUI.startswith(f3_arg0, "primary") then
		return CoD.BonuscardUtility.PrimaryGunfighterWildcards
	elseif LUI.startswith(f3_arg0, "secondary") then
		return CoD.BonuscardUtility.SecondaryGunfighterWildcards
	else
		return {}
	end
end
CoD.BonuscardUtility.GetSlotWithEquippedBonuscard = function(f4_arg0, f4_arg1, f4_arg2)
	if f4_arg0 then
		for f4_local3, f4_local4 in ipairs(CoD.CACUtility.BonuscardSlotNameList) do
			local f4_local5 = f4_arg0[f4_local4]
			if f4_local5 and Engine[@"hash_7B98952F69D937F9"](f4_local5.itemIndex:get(), Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], f4_arg2) == f4_arg1 then
				return f4_local4
			end
		end
	end
	return nil
end
CoD.BonuscardUtility.GetSlotsWithEquippedGluttony = function(f5_arg0, f5_arg1)
	local f5_local0 = {}
	if f5_arg0 then
		for f5_local4, f5_local5 in ipairs(CoD.CACUtility.BonuscardSlotNameList) do
			if f5_arg0[f5_local5].itemIndex:get() > CoD.CACUtility.EmptyItemIndex and CoD.BonuscardUtility.IsBonuscardOfTypeList(CoD.BonuscardUtility.GluttonyWildcards, f5_arg0[f5_local5].refHash:get()) then
				table.insert(f5_local0, f5_local5)
			end
		end
	end
	return f5_local0
end
CoD.BonuscardUtility.IsBonuscardEquipped = function(f6_arg0, f6_arg1, f6_arg2)
	if f6_arg0 then
		for f6_local3, f6_local4 in ipairs(CoD.CACUtility.BonuscardSlotNameList) do
			local f6_local5 = f6_arg0[f6_local4]
			if f6_local5 and Engine[@"hash_7B98952F69D937F9"](f6_local5.itemIndex:get(), Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], f6_arg2) == f6_arg1 then
				return true
			end
		end
	end
	return false
end
CoD.BonuscardUtility.IsBonuscardEquippedToStats = function(f7_arg0, f7_arg1, f7_arg2)
	return CoDLoadoutsShared.IsBonuscardEquippedToStats(f7_arg0, f7_arg1, f7_arg2)
end
CoD.BonuscardUtility.GetNextAvailableSlot = function(f8_arg0, f8_arg1)
	for f8_local3, f8_local4 in ipairs(CoD.CACUtility.BonuscardSlotNameList) do
		if not CoD.CACUtility.ItemEquippedInSlot(f8_local4, f8_arg1, f8_arg0) then
			return f8_local4
		end
	end
end
CoD.BonuscardUtility.IsBonuscardOfTypeList = function(f9_arg0, f9_arg1)
	for f9_local3, f9_local4 in ipairs(f9_arg0) do
		if f9_local4.refHash == f9_arg1 then
			return true
		end
	end
	return false
end
CoD.BonuscardUtility.SpecificGunfighterEquippedCount = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = 0
	if f10_arg0 then
		for f10_local4, f10_local5 in ipairs(CoD.CACUtility.BonuscardSlotNameList) do
			if f10_arg0[f10_local5].itemIndex:get() > CoD.CACUtility.EmptyItemIndex and CoD.BonuscardUtility.IsBonuscardOfTypeList(f10_arg1, f10_arg0[f10_local5].refHash:get()) then
				f10_local0 = f10_local0 + 1
			end
		end
	end
	return math.min(math.max(f10_local0, 0), CoD.CACUtility.maxBonusCards)
end
CoD.BonuscardUtility.SpecificGunfighterEquippedCountDDL = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0 = 0
	local f11_local1 = f11_arg1.classNum:get()
	for f11_local5, f11_local6 in ipairs(CoD.CACUtility.BonuscardSlotNameList) do
		local f11_local7 = CoD.CACUtility.GetClassItem(f11_arg0, f11_local1, f11_local6, f11_arg3)
		if f11_local7 > CoD.CACUtility.EmptyItemIndex and CoD.BonuscardUtility.IsBonuscardOfTypeList(f11_arg2, Engine[@"hash_7B98952F69D937F9"](f11_local7, Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], f11_arg3)) then
			f11_local0 = f11_local0 + 1
		end
	end
	return math.min(math.max(f11_local0, 0), CoD.CACUtility.maxBonusCards)
end
CoD.BonuscardUtility.GetTalentInfoForEquippedGluttony = function(f12_arg0, f12_arg1)
	for f12_local3, f12_local4 in ipairs(CoD.BonuscardUtility.GluttonyWildcards) do
		if CoD.BonuscardUtility.IsBonuscardEquipped(f12_arg0, f12_local4.refHash, f12_arg1) then
			return f12_local4
		end
	end
end
CoD.BonuscardUtility.GetInfoForBonuscard = function(f13_arg0, f13_arg1, f13_arg2)
	if CoD.BonuscardUtility.BonuscardInfoTable and f13_arg0.nameHash then
		local f13_local0 = CoD.BonuscardUtility.BonuscardInfoTable[f13_arg0.nameHash]
		local f13_local1
		if f13_local0 then
			f13_local1 = f13_local0[f13_arg1]
			if not f13_local1 then
			else
				return f13_local1
			end
		end
		f13_local1 = f13_arg2
	else
	end
end
CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = CoD.BonuscardUtility.LoadoutSlotInfoTable[f14_arg0]
	local f14_local1
	if f14_local0 then
		f14_local1 = f14_local0[f14_arg1]
		if not f14_local1 then
		else
			return f14_local1
		end
	end
	f14_local1 = f14_arg2
end
CoD.BonuscardUtility.GetGreedForGluttonyBonuscard = function(f15_arg0)
	if not f15_arg0 then
		return nil
	end
	for f15_local3, f15_local4 in ipairs(CoD.BonuscardUtility.GluttonyWildcards) do
		if f15_arg0 == f15_local4.refHash then
			return f15_local4.greedRefHash
		end
	end
end
CoD.BonuscardUtility.CanEquipBonuscard = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4)
	if f16_arg0 then
		for f16_local3, f16_local4 in ipairs(f16_arg0) do
			if f16_local4 == f16_arg1.nameHash then
				return false
			end
		end
	end
	return true
end
CoD.BonuscardUtility.IsOperatorModBonuscardEquipped = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.BonuscardUtility.OperatorModeWildcards[f17_arg1].refHash
	if f17_local0 then
		return CoD.BonuscardUtility.IsBonuscardEquipped(f17_arg0, f17_local0, f17_arg2)
	else
		return false
	end
end
CoD.BonuscardUtility.IsOperatorModBonuscardEquippedToStats = function(f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = CoD.BonuscardUtility.OperatorModeWildcards[f18_arg1].refHash
	if f18_local0 then
		return CoD.BonuscardUtility.IsBonuscardEquippedToStats(f18_arg0, f18_local0, f18_arg2)
	else
		return false
	end
end
CoD.BonuscardUtility.IncompatibleGunfightersForOperatorMod = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = {}
	local f19_local1 = {}
	local f19_local2 = false
	for f19_local6, f19_local7 in ipairs(CoD.BonuscardUtility.GetGunfighterArrayForSlot(f19_arg2)) do
		if not CoD.BonuscardUtility.IsBonuscardEquipped(f19_arg0, f19_local7.refHash, f19_arg1) then
			table.insert(f19_local1, f19_local7.refHash)
		else
			f19_local2 = true
		end
	end
	if f19_local2 then
		for f19_local6, f19_local7 in ipairs(f19_local1) do
			table.insert(f19_local0, f19_local7)
		end
	end
	return f19_local0
end
CoD.BonuscardUtility.GetEquippedIncompatibleBonuscards = function(f20_arg0, f20_arg1)
	local f20_local0 = {}
	if f20_arg0 then
		for f20_local11, f20_local12 in ipairs(CoD.CACUtility.BonuscardSlotNameList) do
			local f20_local13 = f20_arg0[f20_local12].itemIndex:get()
			local f20_local14 = f20_arg0[f20_local12].refHash:get()
			if f20_local13 > CoD.CACUtility.EmptyItemIndex then
				local f20_local4 = CoD.BonuscardUtility.GetInfoForBonuscard({
					nameHash = f20_local14,
				}, "unequippableBonuscards")
				local f20_local5 = CoD.BonuscardUtility.GetInfoForBonuscard({
					nameHash = f20_local14,
				}, "unequippableBonuscardsFn")
				if f20_local4 then
					for f20_local9, f20_local10 in ipairs(f20_local4) do
						table.insert(f20_local0, f20_local10)
					end
				end
				if f20_local5 then
					local f20_local6, f20_local7 = f20_local5()
					if f20_local6 then
						f20_local0 = f20_local6(f20_arg0, f20_local14, f20_arg1, f20_local7)
					end
				end
			end
		end
	end
	return f20_local0
end
CoD.BonuscardUtility.IsAnyGunfighterForSlotLocked = function(f21_arg0, f21_arg1, f21_arg2)
	if not CoD.CACUtility.IsProgressionEnabled(f21_arg2) then
		return false
	end
	local f21_local0 = false
	for f21_local4, f21_local5 in ipairs(CoD.BonuscardUtility.GetGunfighterArrayForSlot(f21_arg1)) do
		local f21_local6 = Engine[@"hash_68FF94BB44442412"](f21_local5.refHash, f21_arg2)
		if f21_local0 then
			f21_local0 = Engine[@"isitemlocked"](f21_arg0, f21_local6, f21_arg2)
		end
	end
	return f21_local0
end
CoD.BonuscardUtility.GetBonucardUnlockHint = function(f22_arg0, f22_arg1)
	local f22_local0 = Engine[@"hash_2D97229B24C685D5"](f22_arg0, f22_arg1)
	return Engine[@"localize"](@"hash_1F8AF6E1799C89BB", Engine[@"getitemname"](f22_local0, Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], f22_arg1), Engine[@"getitemunlocklevel"](f22_local0, Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], f22_arg1) + 1)
end
CoD.BonuscardUtility.IsBonuscardLocked = function(f23_arg0, f23_arg1, f23_arg2)
	if not CoD.CACUtility.IsProgressionEnabled(f23_arg2) then
		return false
	elseif f23_arg1 then
		local f23_local0 = Engine[@"hash_68FF94BB44442412"](f23_arg1, f23_arg2)
		if CoD.CACUtility.EmptyItemIndex < f23_local0 then
			return Engine[@"isitemlocked"](f23_arg0, f23_local0, f23_arg2)
		end
	end
	return false
end
CoD.BonuscardUtility.IsBonuscardPrimary = function(f24_arg0)
	local f24_local0 = CoD.BonuscardUtility.BonuscardInfoTable[f24_arg0]
	if f24_local0 then
		local f24_local1
		if f24_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY and f24_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT and f24_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT_UBER then
			f24_local1 = false
		else
			f24_local1 = true
		end
		return f24_local1
	else
		return false
	end
end
CoD.BonuscardUtility.IsBonuscardSecondary = function(f25_arg0)
	local f25_local0 = CoD.BonuscardUtility.BonuscardInfoTable[f25_arg0]
	if f25_local0 then
		local f25_local1
		if f25_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY and f25_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT and f25_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT_UBER then
			f25_local1 = false
		else
			f25_local1 = true
		end
		return f25_local1
	else
		return false
	end
end
CoD.BonuscardUtility.IsBonuscardPerk = function(f26_arg0)
	local f26_local0 = CoD.BonuscardUtility.BonuscardInfoTable[f26_arg0]
	if f26_local0 then
		local f26_local1
		if f26_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS and f26_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_4 and f26_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_5 and f26_local0.modifiedSlotEnum ~= CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_6 then
			f26_local1 = false
		else
			f26_local1 = true
		end
		return f26_local1
	else
		return false
	end
end
CoD.BonuscardUtility.IsPrereqBonuscardEquippedForSlot = function(f27_arg0, f27_arg1)
	local f27_local0 = CoD.BaseUtility.GetMenuModel(f27_arg0)
	local f27_local1 = CoD.BaseUtility.GetMenuSessionMode(f27_arg0)
	local f27_local2 = f27_arg1:getModel()
	if f27_local0 and f27_local2 then
		local f27_local3 = f27_local2.baseWeaponSlotModel:get()
		local f27_local4 = f27_local3.weaponSlot:get()
		local f27_local5 = f27_local2.numBonuscardNeeded:get() <= (f27_local0[f27_local4].numGunfightersEquipped and f27_local0[f27_local4].numGunfightersEquipped:get() or 0)
		if f27_local2.isUberAttachmentSlot:get() and not f27_local5 then
			local f27_local6 = f27_local2.bonuscardNeeded:get()
			if f27_local6 and f27_local6 ~= 0x0 then
				return CoD.BonuscardUtility.IsBonuscardEquipped(f27_local0, f27_local6, f27_local1)
			end
		end
		return f27_local5
	else
		return false
	end
end
CoD.BonuscardUtility.CanContextualEquipForSlot = function(f28_arg0, f28_arg1)
	local f28_local0 = CoD.BaseUtility.GetMenuModel(f28_arg0)
	local f28_local1 = CoD.BaseUtility.GetMenuSessionMode(f28_arg0)
	local f28_local2 = f28_arg1:getModel()
	if f28_local0 and f28_local2 then
		local f28_local3 = f28_local2.loadoutSlot:get()
		if LUI.startswith(f28_local3, "talent") then
			local f28_local4 = CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot(f28_local3, "contextualBonuscards")
			f28_local4 = f28_local4 and f28_local4[1]
			if f28_local4 then
				local f28_local5 = CoD.BonuscardUtility.GetTalentInfoForEquippedGluttony(f28_local0, f28_local1)
				if f28_local5 and f28_local5.refHash then
					local f28_local6 = CoD.BonuscardUtility.GetInfoForBonuscard({
						nameHash = f28_local5.refHash,
					}, "unequippableBonuscards")
					if f28_local6 then
						for f28_local10, f28_local11 in ipairs(f28_local6) do
							if f28_local4 == f28_local11 then
								return false
							end
						end
					end
				end
			end
		else
			local f28_local4 = f28_local2.baseWeaponSlotModel:get()
			local f28_local5 = f28_local4.weaponSlot:get()
			local f28_local6 = f28_local2.numBonuscardNeeded:get()
			local f28_local7 = f28_local0[f28_local5].numGunfightersEquipped and f28_local0[f28_local5].numGunfightersEquipped:get() or 0
			if f28_local6 > 0 then
				return f28_local6 <= f28_local7 + 1
			end
		end
		return true
	else
		return false
	end
end
CoD.BonuscardUtility.IsNextAvailableAttachmentSlotForGunfighter = function(f29_arg0, f29_arg1)
	local f29_local0 = CoD.BaseUtility.GetMenuModel(f29_arg0)
	local f29_local1 = CoD.BaseUtility.GetMenuSessionMode(f29_arg0)
	local f29_local2 = f29_arg1:getModel()
	if f29_local0 and f29_local2 then
		if f29_local2.isAttachmentSlotAvailable and f29_local2.isAttachmentSlotAvailable:get() == false then
			return false
		end
		local f29_local3 = f29_local2.baseWeaponSlotModel:get()
		if f29_local3 then
			if f29_local3.itemIndex:get() <= CoD.CACUtility.EmptyItemIndex then
				return false
			else
				local f29_local4 = f29_local3.weaponSlot:get()
				return (f29_local0[f29_local4].numGunfightersEquipped and f29_local0[f29_local4].numGunfightersEquipped:get() or 0) + 1 == f29_local2.numBonuscardNeeded:get()
			end
		end
	end
	return false
end
CoD.BonuscardUtility.ShouldDisplayWildcardHighlightForAttachment = function(f30_arg0, f30_arg1)
	local f30_local0 = CoD.BaseUtility.GetMenuModel(f30_arg0)
	local f30_local1 = CoD.BaseUtility.GetMenuSessionMode(f30_arg0)
	local f30_local2 = f30_arg1:getModel()
	if f30_local0 and f30_local2 then
		if f30_local2.isAttachmentSlotAvailable and f30_local2.isAttachmentSlotAvailable:get() == false then
			return false
		end
		local f30_local3 = f30_local2.baseWeaponSlotModel:get()
		if f30_local3 then
			if f30_local3.itemIndex:get() <= CoD.CACUtility.EmptyItemIndex then
				return false
			else
				local f30_local4 = f30_local3.weaponSlot:get()
				return (f30_local0[f30_local4].numGunfightersEquipped and f30_local0[f30_local4].numGunfightersEquipped:get() or 0) + 1 == f30_local2.numBonuscardNeeded:get()
			end
		end
	end
	return false
end
CoD.BonuscardUtility.IsRequiredGreedWildcardEquipped = function(f31_arg0, f31_arg1)
	local f31_local0 = CoD.BaseUtility.GetMenuModel(f31_arg0)
	local f31_local1 = CoD.BaseUtility.GetMenuSessionMode(f31_arg0)
	local f31_local2 = f31_arg1:getModel()
	if f31_local2 then
		local f31_local3 = f31_local2.bonuscardNeeded:get()
		if f31_local3 == 0x0 then
			return true
		else
			return CoD.BonuscardUtility.IsBonuscardEquipped(f31_local0, f31_local3, f31_local1)
		end
	else
		return false
	end
end
CoD.BonuscardUtility.IsBonuscardEquippedInCurrentClass = function(f32_arg0, f32_arg1)
	local f32_local0 = CoD.BaseUtility.GetMenuModel(f32_arg0)
	local f32_local1 = f32_arg1:getModel()
	return CoD.CACUtility.GetEquipSlotForItemIndex(f32_local1.itemIndex:get(), f32_local0, CoD.CACUtility.BonuscardSlotNameList, #CoD.CACUtility.BonuscardSlotNameList) ~= nil
end
CoD.BonuscardUtility.IsBonuscardModifiedEnumPrimary = function(f33_arg0)
	local f33_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f33_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY)
	if not f33_local0 then
		f33_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f33_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT)
		if not f33_local0 then
			f33_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f33_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.PRIMARY_ATTACHMENT_UBER)
		end
	end
	return f33_local0
end
CoD.BonuscardUtility.IsBonuscardModifiedEnumSecondary = function(f34_arg0)
	local f34_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f34_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY)
	if not f34_local0 then
		f34_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f34_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT)
		if not f34_local0 then
			f34_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f34_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.SECONDARY_ATTACHMENT_UBER)
		end
	end
	return f34_local0
end
CoD.BonuscardUtility.IsBonuscardModifiedEnumPerks = function(f35_arg0)
	local f35_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f35_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENTS)
	if not f35_local0 then
		f35_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f35_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_4)
		if not f35_local0 then
			f35_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f35_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_5)
			if not f35_local0 then
				f35_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f35_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.TALENT_6)
			end
		end
	end
	return f35_local0
end
