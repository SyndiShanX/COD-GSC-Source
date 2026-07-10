require("x64:d90671b853a008e")
CoD.ZMTalismanUtility = {}
CoD.ZMTalismanUtility.TalismanTypes = LuaEnum.createEnum("NONE", "PERK1", "PERK2", "PERK3", "PERK4", "HERO_WEAPON", "EQUIPMENT", "START_WEAPON")
CoD.ZMTalismanUtility.TalismanSlotIcons = {
	[CoD.ZMTalismanUtility.TalismanTypes.NONE] = @"blacktransparent",
	[CoD.ZMTalismanUtility.TalismanTypes.PERK1] = @"hash_5621DB435A480979",
	[CoD.ZMTalismanUtility.TalismanTypes.PERK2] = @"hash_5621DB435A480979",
	[CoD.ZMTalismanUtility.TalismanTypes.PERK3] = @"hash_5621DB435A480979",
	[CoD.ZMTalismanUtility.TalismanTypes.PERK4] = @"hash_5621DB435A480979",
	[CoD.ZMTalismanUtility.TalismanTypes.HERO_WEAPON] = @"hash_5621DB435A480979",
	[CoD.ZMTalismanUtility.TalismanTypes.EQUIPMENT] = @"hash_5621DB435A480979",
	[CoD.ZMTalismanUtility.TalismanTypes.START_WEAPON] = @"hash_5621DB435A480979",
}
CoD.ZMTalismanUtility.N_ENUM_MBOX_OFF = 0
CoD.ZMTalismanUtility.N_SETTING_PACK_OFF = 0
CoD.ZMTalismanUtility.N_SETTING_LAST_STAND_DURATION_OFF = 0
CoD.ZMTalismanUtility.TalismanToEnumGameSettingsHash = {
	[@"talisman_box_guarantee_box_only"] = {
		{
			hash = @"zmmysteryboxstate",
			restrictedValue = CoD.ZMTalismanUtility.N_ENUM_MBOX_OFF,
		},
	},
	[@"talisman_box_guarantee_lmg"] = {
		{
			hash = @"zmmysteryboxstate",
			restrictedValue = CoD.ZMTalismanUtility.N_ENUM_MBOX_OFF,
		},
	},
	[@"talisman_weapon_reducepapcost"] = {
		{
			hash = @"zmpapenabled",
			restrictedValue = CoD.ZMTalismanUtility.N_SETTING_PACK_OFF,
		},
	},
	[@"talisman_coagulant"] = {
		{
			hash = @"zmlaststandduration",
			restrictedValue = CoD.ZMTalismanUtility.N_SETTING_LAST_STAND_DURATION_OFF,
		},
	},
}
CoD.ZMTalismanUtility.TalismanToBooleanGameSettingsHash = {
	[@"talisman_box_guarantee_box_only"] = {
		@"zmtalismanboxguaranteeboxonly",
	},
	[@"talisman_box_guarantee_lmg"] = {
		@"zmtalismanboxguaranteelmg",
		@"zmweaponslmg",
	},
	[@"talisman_coagulant"] = {
		@"zmtalismancoagulant",
	},
	[@"talisman_extra_claymore"] = {
		@"zmtalismanextraclaymore",
		@"zmequipmentisenabled",
	},
	[@"talisman_extra_frag"] = {
		@"zmtalismanextrafrag",
		@"zmequipmentisenabled",
	},
	[@"talisman_extra_miniturret"] = {
		@"zmtalismanextraminiturret",
		@"zmequipmentisenabled",
	},
	[@"talisman_extra_molotov"] = {
		@"zmtalismanextramolotov",
		@"zmequipmentisenabled",
	},
	[@"talisman_extra_semtex"] = {
		@"zmtalismanextrasemtex",
		@"zmequipmentisenabled",
	},
	[@"talisman_impatient"] = {
		@"zmtalismanimpatient",
	},
	[@"talisman_perk_mod_single"] = {
		@"zmtalismanperkmodsingle",
		@"zmperksactive",
	},
	[@"talisman_perk_permanent_1"] = {
		@"zmtalismanperkpermanent1",
		@"zmperksactive",
	},
	[@"talisman_perk_permanent_2"] = {
		@"zmtalismanperkpermanent2",
		@"zmperksactive",
	},
	[@"talisman_perk_permanent_3"] = {
		@"zmtalismanperkpermanent3",
		@"zmperksactive",
	},
	[@"talisman_perk_permanent_4"] = {
		@"zmtalismanperkpermanent4",
		@"zmperksactive",
	},
	[@"talisman_perk_reducecost_1"] = {
		@"zmtalismanperkreducecost1",
		@"zmperksactive",
	},
	[@"talisman_perk_reducecost_2"] = {
		@"zmtalismanperkreducecost2",
		@"zmperksactive",
	},
	[@"talisman_perk_reducecost_3"] = {
		@"zmtalismanperkreducecost3",
		@"zmperksactive",
	},
	[@"talisman_perk_reducecost_4"] = {
		@"zmtalismanperkreducecost4",
		@"zmperksactive",
	},
	[@"talisman_perk_start_1"] = {
		@"zmtalismanperkstart1",
		@"zmperksactive",
	},
	[@"talisman_perk_start_2"] = {
		@"zmtalismanperkstart2",
		@"zmperksactive",
	},
	[@"talisman_perk_start_3"] = {
		@"zmtalismanperkstart3",
		@"zmperksactive",
	},
	[@"talisman_perk_start_4"] = {
		@"zmtalismanperkstart4",
		@"zmperksactive",
	},
	[@"talisman_shield_durability_legendary"] = {
		@"zmtalismanshielddurabilitylegendary",
		@"zmshieldisenabled",
	},
	[@"talisman_shield_durability_rare"] = {
		@"zmtalismanshielddurabilityrare",
		@"zmshieldisenabled",
	},
	[@"talisman_shield_price"] = {
		@"zmtalismanshieldprice",
		@"zmshieldisenabled",
	},
	[@"talisman_special_startlv2"] = {
		@"zmtalismanspecialstartlvl2",
		@"zmspecweaponisenabled",
	},
	[@"talisman_special_startlv3"] = {
		@"zmtalismanspecialstartlvl3",
		@"zmspecweaponisenabled",
	},
	[@"talisman_special_xp_rate"] = {
		@"zmtalismanspecialxprate",
		@"zmspecweaponisenabled",
	},
	[@"talisman_start_weapon_ar"] = {
		@"zmtalismanstartweaponar",
		@"zmweaponsar",
	},
	[@"talisman_start_weapon_lmg"] = {
		@"zmtalismanstartweaponlmg",
		@"zmweaponslmg",
	},
	[@"talisman_start_weapon_smg"] = {
		@"zmtalismanstartweaponsmg",
		@"zmweaponssmg",
	},
	[@"talisman_weapon_reducepapcost"] = {
		@"zmtalismanreducepapcost",
	},
	[@"talisman_permanent_heroweap_armor"] = {
		@"zmtalismanpermanentheroweaparmor",
		@"zmspecweaponisenabled",
	},
	[@"talisman_extra_self_revive"] = {
		@"zmtalismanextraselfrevive",
	},
}
DataSources.TalismanCategories = ListHelper_SetupDataSource("TalismanCategories", function(f1_arg0, f1_arg1)
	local f1_local0 = CoD.CACUtility.GetItemEquippedInSlot(CoD.BaseUtility.GetMenuLoadoutSlot(f1_arg1.menu), nil, CoD.BaseUtility.GetMenuModel(f1_arg1.menu))
	local f1_local1 = nil
	if f1_local0 ~= CoD.CACUtility.EmptyItemIndex then
		f1_local1 = Engine[@"hash_487395843D470BE2"](f1_local0, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], Enum[@"emodes"][@"mode_zombies"])
	end
	local f1_local2 = function(f2_arg0)
		return f1_local1 and f1_local1[@"talismanrarity"] == f2_arg0
	end
	local f1_local3 = {}
	table.insert(f1_local3, {
		models = {
			tabName = @"hash_1E73A287484FA8DE",
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[@"talismanrarity"][@"hash_1CAF546022922B9B"]),
		},
		properties = {
			rarity = Enum[@"talismanrarity"][@"hash_1CAF546022922B9B"],
			selectIndex = f1_local2(Enum[@"talismanrarity"][@"hash_1CAF546022922B9B"]),
		},
	})
	table.insert(f1_local3, {
		models = {
			tabName = @"hash_1D14011B788D0CF7",
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[@"talismanrarity"][@"hash_7A113367DDA0F492"]),
		},
		properties = {
			rarity = Enum[@"talismanrarity"][@"hash_7A113367DDA0F492"],
			selectIndex = f1_local2(Enum[@"talismanrarity"][@"hash_7A113367DDA0F492"]),
		},
	})
	table.insert(f1_local3, {
		models = {
			tabName = @"hash_499BE3404C6F5504",
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[@"talismanrarity"][@"hash_596900358670FFE7"]),
		},
		properties = {
			rarity = Enum[@"talismanrarity"][@"hash_596900358670FFE7"],
			selectIndex = f1_local2(Enum[@"talismanrarity"][@"hash_596900358670FFE7"]),
		},
	})
	table.insert(f1_local3, {
		models = {
			tabName = @"hash_7CC5E57AF2A3CF36",
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[@"talismanrarity"][0x9F2E1F9312FF03]),
		},
		properties = {
			rarity = Enum[@"talismanrarity"][0x9F2E1F9312FF03],
			selectIndex = f1_local2(Enum[@"talismanrarity"][0x9F2E1F9312FF03]),
		},
	})
	return f1_local3
end, true)
CoD.ZMTalismanUtility.IsEquippedTalismanOfType = function(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0:getModel(f3_arg1, "itemIndex")
	local f3_local1 = f3_local0 and f3_local0:get()
	if f3_local1 and f3_local1 > CoD.CACUtility.EmptyItemIndex then
		local f3_local2 = Engine[@"hash_487395843D470BE2"](f3_local1, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], Enum[@"emodes"][@"mode_zombies"])
		return f3_local2 and f3_local2[@"talismantype"] == f3_arg2
	else
		return false
	end
end
CoD.ZMTalismanUtility.GetTalismanSlotIcon = function(f4_arg0, f4_arg1)
	return CoD.ZMTalismanUtility.TalismanSlotIcons[f4_arg0] or "blacktransparent"
end
CoD.ZMTalismanUtility.UpdateTalismanModel = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg1:getModel()
	if f5_local0 then
		local f5_local1 = f5_local0.itemIndex:get()
		local f5_local2 = f5_local0.globalItemIndex:get()
		local f5_local3 = Engine[@"getitemgroup"](f5_local1, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], Enum[@"emodes"][@"mode_zombies"])
		local f5_local4 = true
		local f5_local5 = "select01"
		local f5_local6 = 0x0
		local f5_local7 = 1
		local f5_local8 = CoD.CACUtility.GetUnlockableItemInfo(f5_local2, Enum[@"emodes"][@"mode_zombies"])
		if f5_local8 then
			f5_local6 = f5_local8[@"previewmodelname"] or 0x0
			f5_local7 = f5_local8[@"previewmodelscale"] or 1
		end
		Engine[@"sendclientscriptnotify"](f5_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f5_arg2), {
			base_weapon_slot = f5_local3,
			weapon = f5_local6,
			attachments = "",
			camera = f5_local5,
			is_item_unlocked = f5_local4,
			xmodel_scale = f5_local7,
		})
	end
end
CoD.ZMTalismanUtility.UnequipTalisman = function(f6_arg0, f6_arg1, f6_arg2)
	local f6_local0, f6_local1, f6_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f6_arg0)
	if f6_local0 and f6_local2 then
		local f6_local3 = f6_arg1.unequipSound
		if RemoveItemFromClassSlot(f6_local0, f6_local2, f6_arg2, false, f6_local1) then
			CoD.CACUtility.GetCustomClassModel(f6_arg2, f6_local0.classNum:get(), f6_local0, nil, f6_local1)
			CoD.CACUtility.UpdateClassWeaponModel(f6_arg0, f6_arg1, f6_arg2)
			CoD.FreeCursorUtility.UpdateSetupContext(f6_arg1, f6_arg2)
			if f6_local3 and f6_local3 ~= 0x0 then
				Engine[@"hash_498954175CA6A32C"](f6_local3)
			end
		end
	end
end
CoD.ZMTalismanUtility.UpdateEquippedSlot = function(f7_arg0)
	ForceNotifyModel(f7_arg0, "TalismanSelect.Update")
end
CoD.ZMTalismanUtility.IsTalismanEqipped = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0, f8_local1, f8_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f8_arg0)
	local f8_local3 = CoD.SafeGetModelValue(f8_arg1:getModel(), "itemIndex")
	if f8_local0 and f8_local2 and f8_local3 and CoD.CACUtility.EmptyItemIndex < f8_local3 and f8_local0[f8_local2].itemIndex:get() == f8_local3 then
		return true
	else
	end
end
