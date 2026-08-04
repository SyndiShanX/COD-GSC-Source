require("lua/shared/luautils")
CoD.CraftUtility = {}
CoD.CraftUtility.Fileshare = {}
CoD.CraftUtility.Gunsmith = {}
CoD.CraftUtility.Gunsmith.CachedVariants = {}
CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS = 8
CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX = 0
CoD.CraftUtility.Gunsmith.CAMO_NONE = 0
CoD.CraftUtility.Gunsmith.RETICLE_NONE = 0
CoD.CraftUtility.PAINTSHOP_GRIDSIZE = 16
CoD.CraftUtility.EMBLEM_GRIDSIZE = 24
CoD.CraftUtility.DEFAULT_READ_ONLY_FLAG = 0
CoD.CraftUtility.INVALID_GROUP_INDEX = -1
CoD.CraftUtility.EMBLEM_INVALID_ID = -1
CoD.CraftUtility.EMBLEM_DECALGROUP_ID = -2
CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE = 255
CoD.CraftUtility.EMBLEM_MAX_GRADIENT_SLIDER_VALUE = 100
CoD.CraftUtility.EMBLEM_CLIPBOARDSTATE = {
	FULL = 0,
	EMPTY = 1,
}
CoD.CraftUtility.EMBLEM_ADDDECAL = {
	REPLACE = 0,
	INSERT = 1,
}
CoD.CraftUtility.USE_STICKER_IN = {
	EMBLEM = 0,
	EMBLEM_EDITOR = 1,
	PAINTJOB = 2,
}
CoD.CraftUtility.COLOR_CONTAINER_STATE = LuaEnum.createEnum("COLOR_SWATCH", "COLOR_MIXER", "COLOR_GRADIENT", "GRADIENT_SWATCH", "GRADIENT_MIXER")
CoD.CraftUtility.PaintshopView = {
	{
		view_name = "left",
		customization_type = Enum.CustomizationType[@"customization_type_paintshop_view_left"],
		view_string_ref = "menu/paintshop_view_left",
		edit_side_ref = "menu/paintshop_edit_layer",
	},
	{
		view_name = "top",
		customization_type = Enum.CustomizationType[@"customization_type_paintshop_view_top"],
		view_string_ref = "menu/paintshop_view_top",
		edit_side_ref = "menu/paintshop_edit_layer",
	},
}
CoD.CraftUtility.EmblemCategoryInvalid = -1
CoD.CraftUtility.EmblemDecalIconsCategory = 1
CoD.CraftUtility.EmblemDecalToolsCategory = 3
CoD.CraftUtility.EmblemBlackMarketDecalCategory = 5
CoD.CraftUtility.EmblemStickerCategory = 6
CoD.CraftUtility.EmblemStickerSetCategory = 7
CoD.CraftUtility.EmblemDefaultStickerCategory = 9
CoD.CraftUtility.EmblemDecalGroupCategory = 100
CoD.CraftUtility.EmblemDefaultGroupCategory = 101
CoD.CraftUtility.EMBLEM_DECALTABS = {
	{
		type = "ICON",
		displayName = "menu/emblem_selector_icons_tab",
		category = CoD.CraftUtility.EmblemDecalIconsCategory,
	},
	{
		type = "STICKER",
		displayName = "menu/stickers_caps",
		category = CoD.CraftUtility.EmblemStickerCategory,
		stickerCategory = CoD.CraftUtility.EmblemStickerCategory,
	},
	{
		type = "STICKERSET",
		displayName = @"hash_17F59D77E1C3A48A",
		category = CoD.CraftUtility.EmblemStickerSetCategory,
		stickerCategory = CoD.CraftUtility.EmblemStickerSetCategory,
	},
	{
		type = "TOOLS",
		displayName = "menu/emblem_selector_tools_tab",
		category = CoD.CraftUtility.EmblemDecalToolsCategory,
	},
	{
		type = "DECALGROUPS",
		displayName = @"hash_7B1B89ED0677CFE7",
		category = CoD.CraftUtility.EmblemDecalGroupCategory,
	},
}
CoD.CraftUtility.DECAL_TOOLBUTTONS = {
	{
		type = "SHAPES",
		displayName = @"hash_3D9E0790DE1F78AE",
		category = CoD.CraftUtility.EmblemDecalToolsCategory,
	},
	{
		type = "PATTERNS",
		displayName = "menu/emblem_selector_patterns_tab",
		category = 2,
	},
	{
		type = "TYPE",
		displayName = "menu/emblem_selector_type_tab",
		category = 4,
	},
	{
		type = "BACKGROUNDS",
		displayName = @"hash_78A505080FDF90ED",
		category = 8,
	},
}
CoD.CraftUtility.DECAL_GROUPSBUTTONS = {
	{
		type = "DECALGROUPS",
		displayName = @"hash_7B1B89ED0677CFE7",
		category = CoD.CraftUtility.EmblemDecalGroupCategory,
	},
	{
		type = "DEFAULTGROUPS",
		displayName = @"hash_65C6C9AF28AB4BDD",
		category = CoD.CraftUtility.EmblemDefaultGroupCategory,
	},
}
CoD.CraftUtility.EmblemBlackMarketEmblemCategory = 3
CoD.CraftUtility.EmblemMaterialCategory = {
	{
		category = 1,
		type = "general",
		name = "menu/emblem_material_general",
	},
	{
		category = 2,
		type = "camo",
		name = "menu/emblem_material_camo",
	},
	{
		category = 3,
		type = "loot",
		name = @"menu/black_market",
	},
}
CoD.CraftUtility.WeaponGroupNames = {
	{
		index = 1,
		weapon_category = "weapon_smg",
		lowercaseName = "mpui/sub_machine_guns",
		name = "mpui/weapon_smg_abbr_caps_with_s",
		loadout_slot = "primary",
		weapon_image = "t7_wpn_build_kit_smg",
	},
	{
		index = 2,
		weapon_category = "weapon_assault",
		lowercaseName = @"hash_6DC19D439D9A9AE4",
		name = "mpui/weapon_assault_caps",
		loadout_slot = "primary",
		weapon_image = "t7_wpn_build_kit_ar",
	},
	{
		index = 3,
		weapon_category = "weapon_cqb",
		lowercaseName = @"mpui/cqbs",
		name = @"hash_247A4BC3A33F5EFC",
		loadout_slot = "primary",
		weapon_image = "t7_wpn_build_kit_shotgun",
	},
	{
		index = 4,
		weapon_category = "weapon_lmg",
		lowercaseName = "mpui/light_machine_guns",
		name = "mpui/weapon_lmg_abbr_caps_with_s",
		loadout_slot = "primary",
		weapon_image = "t7_wpn_build_kit_lmg",
	},
	{
		index = 5,
		weapon_category = "weapon_sniper",
		lowercaseName = "mpui/sniper_rifles",
		name = "mpui/weapon_sniper_caps",
		loadout_slot = "primary",
		weapon_image = "t7_wpn_build_kit_sniper",
	},
	{
		index = 6,
		weapon_category = "secondary",
		lowercaseName = "mpui/weapon_secondaries",
		name = "mpui/weapon_secondaries_caps",
		loadout_slot = "secondary",
		weapon_image = "t7_wpn_build_kit_pistol",
	},
}
CoD.CraftUtility.UnselectedEmblemStorageType = 0
CoD.CraftUtility.CraftSaveToast = function(f1_arg0, f1_arg1)
	CoD.OverlayUtility.ShowToast("CraftSave", f1_arg1)
end
CoD.CraftUtility.GetMaterialCategoryTypeByID = function(f2_arg0)
	for f2_local0 = 1, #CoD.CraftUtility.EmblemMaterialCategory, 1 do
		if f2_arg0 and CoD.CraftUtility.EmblemMaterialCategory[f2_local0].category == f2_arg0 then
			return CoD.CraftUtility.EmblemMaterialCategory[f2_local0].type
		end
	end
	return nil
end
CoD.CraftUtility.GetDecalCategoryTypeByID = function(f3_arg0)
	for f3_local0 = 1, #CoD.CraftUtility.EMBLEM_DECALTABS, 1 do
		if CoD.CraftUtility.EMBLEM_DECALTABS[f3_local0].category == f3_arg0 then
			return CoD.CraftUtility.EMBLEM_DECALTABS[f3_local0].type
		end
	end
	return nil
end
CoD.CraftUtility.InvalidateWCItemRenderAction = function(f4_arg0)
	local f4_local0 = DataSources.SelectedPaintjob.getModel(f4_arg0)
	if f4_local0 then
		local f4_local1 = f4_local0:create("paintjobSlot")
		if f4_local1:get() then
			CoD.CraftUtility.InvalidateWCItemRender(f4_local1:get())
		end
	end
end
CoD.CraftUtility.InvalidateWCItemRender = function(f5_arg0)
	Engine[@"invalidatewcitemrender"](f5_arg0)
end
CoD.CraftUtility.GetUsedSlotsByFileType = function(f6_arg0, f6_arg1)
	local f6_local0 = 0
	if f6_arg1 == Enum.StorageFileType[@"storage_paintjobs"] then
		f6_local0 = CoD.CraftUtility.Paintjobs.GetTotalUsedPaintjobs()
	elseif f6_arg1 == Enum.StorageFileType[@"storage_emblems"] then
		f6_local0 = CoD.CraftUtility.Emblems.GetTotalUsedEmblems(f6_arg0, f6_arg1, CoD.perController[f6_arg0].selectedEmblemTabStickerCategory)
	elseif f6_arg1 == Enum.StorageFileType[@"hash_15DB8C62CF926911"] then
		f6_local0 = CoD.CraftUtility.Groups.GetTotalUsed(f6_arg0, f6_arg1)
	end
	return f6_local0
end
CoD.CraftUtility.GetTotalAllowedSlotsByFileType = function(f7_arg0, f7_arg1)
	local f7_local0 = 0
	if f7_arg1 == Enum.StorageFileType[@"storage_paintjobs"] then
		f7_local0 = CoD.CraftUtility.Paintjobs.GetTotalAllowedPaintjobs(f7_arg0)
	elseif f7_arg1 == Enum.StorageFileType[@"storage_emblems"] then
		f7_local0 = CoD.CraftUtility.Emblems.GetTotalAllowedEmblems(f7_arg0, f7_arg1, CoD.perController[f7_arg0].selectedEmblemTabStickerCategory)
	elseif f7_arg1 == Enum.StorageFileType[@"hash_15DB8C62CF926911"] then
		f7_local0 = CoD.CraftUtility.Groups.GetTotalAllowed(f7_arg0, f7_arg1)
	end
	return f7_local0
end
CoD.CraftUtility.GetGridTypeName = function(f8_arg0)
	local f8_local0 = "paintshop_grid_size"
	if not IsPaintshop(f8_arg0) then
		f8_local0 = "emblem_grid_size"
	end
	return f8_local0
end
CoD.CraftUtility.GetGridSize = function(f9_arg0)
	local f9_local0 = CoD.CraftUtility.PAINTSHOP_GRIDSIZE
	if not IsPaintshop(f9_arg0) then
		f9_local0 = CoD.CraftUtility.EMBLEM_GRIDSIZE
	end
	return f9_local0
end
CoD.CraftUtility.GetDDLRoot = function(f10_arg0, f10_arg1, f10_arg2)
	if f10_arg1 == "cacRoot" then
		return Engine[@"hash_3FC41172469DB251"](f10_arg0)
	elseif f10_arg2 ~= nil then
		return Engine.StorageGetBuffer(f10_arg0, f10_arg1, f10_arg2)
	else
		return Engine.StorageGetBuffer(f10_arg0, f10_arg1)
	end
end
CoD.CraftUtility.UploadBuffer = function(f11_arg0, f11_arg1, f11_arg2)
	if f11_arg1 == "cacRoot" then
		Engine[@"saveloadout"](f11_arg0)
	elseif f11_arg2 ~= nil then
		Engine.StorageWrite(f11_arg0, f11_arg1, f11_arg2)
	else
		Engine.StorageWrite(f11_arg0, f11_arg1)
	end
end
CoD.CraftUtility.UploadAndParseBuffer = function(f12_arg0, f12_arg1, f12_arg2)
	CoD.CraftUtility.UploadBuffer(f12_arg0, f12_arg1, f12_arg2)
	if f12_arg1 == Enum.StorageFileType[@"storage_emblems"] then
		CoD.CraftUtility.Emblems.ParseDDL(f12_arg0, f12_arg1, CoD.perController[f12_arg0].selectedEmblemTabStickerCategory)
	elseif f12_arg1 == Enum.StorageFileType[@"storage_paintjobs"] then
		CoD.CraftUtility.Paintjobs.ParseDDL(f12_arg0, f12_arg1)
	elseif f12_arg1 == Enum.StorageFileType[@"hash_15DB8C62CF926911"] then
		CoD.CraftUtility.Groups.ParseDDL(f12_arg0, f12_arg1)
	end
	MediaManagerMarkDirty(f12_arg0)
end
CoD.CraftUtility.GetModeAbbreviation = function()
	return "_mp"
end
CoD.CraftUtility.GetCraftMode = function()
	return Enum.eModes.mode_multiplayer
end
CoD.CraftUtility.GetLoadoutSlot = function(f15_arg0)
	local f15_local0
	if CoD.GetCustomization(f15_arg0, "category_index") ~= nil then
		f15_local0 = CoD.GetCustomization(f15_arg0, "category_index") - 1
	else
		f15_local0 = 1
	end
	return CoD.CraftUtility.WeaponGroupNames[f15_local0].loadout_slot
end
CoD.CraftUtility.DisplayWeaponInPaintshop = function(f16_arg0, f16_arg1)
	Engine.SendClientScriptNotify(f16_arg0, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f16_arg0), {
		base_weapon_slot = CoD.CraftUtility.GetLoadoutSlot(f16_arg0),
		weapon = Engine[@"hash_7B98952F69D937F9"](CoD.GetCustomization(f16_arg0, "weapon_index"), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer),
		attachments = "",
		camera = f16_arg1,
		options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(0, 0, 1),
	})
end
CoD.CraftUtility.PaintjobClear = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4)
	CoD.OverlayUtility.CreateOverlay(f17_arg2, f17_arg4, "PaintjobClearConfirmationOverlay")
end
CoD.CraftUtility.PaintjobRename = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4)
	ShowKeyboard(f18_arg4, f18_arg1, f18_arg2, "KEYBOARD_TYPE_PAINTJOB")
end
CoD.CraftUtility.OpenPublishPromptPaintjob = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4)
	local f19_local0 = CoD.CraftUtility.GetDDLRoot(f19_arg2, Enum.StorageFileType[@"storage_paintjobs"], Engine.GetModelValue(Engine.GetModel(CoD.perController[f19_arg2].selectedPaintjobModel, "paintjobSlot")))
	local f19_local1 = ""
	if f19_local0 ~= nil then
		local f19_local2 = f19_local0.weaponPaintjob.paintjobName:get()
		if f19_local2 ~= nil then
			f19_local1 = f19_local2
		end
	end
	CoD.FileshareUtility.OpenPublishPrompt(f19_arg4, f19_arg2, "paintjob", f19_local1, "", CoD.CraftUtility.Paintjobs.PublishPaintjob)
end
CoD.CraftUtility.EmblemClear = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3, f20_arg4)
	local f20_local0 = CoD.OverlayUtility.CreateOverlay(f20_arg2, f20_arg4, "EmblemClearConfirmationOverlay")
end
CoD.CraftUtility.EmblemRename = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	ShowKeyboard(f21_arg4, f21_arg1, f21_arg2, "KEYBOARD_TYPE_EMBLEMS")
end
CoD.CraftUtility.OpenPublishPromptEmblem = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	if CheckIfFeatureIsBanned(f22_arg2 + 1, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT) then
		LuaUtils.UI_ShowErrorMessageDialog(f22_arg2, GetFeatureBanInfo(f22_arg2 + 1, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT))
		return
	else
		CoD.FileshareUtility.OpenPublishPrompt(f22_arg4, f22_arg2, "emblem", Engine.GetModelValue(Engine.GetModel(CoD.perController[f22_arg2].selectedEmblemModel, "displayName")), "", CoD.CraftUtility.Emblems.PublishEmblem)
	end
end
CoD.CraftUtility.GetWeaponGroupName = function(f23_arg0)
	local f23_local0 = CoD.GetCustomization(f23_arg0, "weapon_index")
	local f23_local1 = ""
	if f23_local0 then
		f23_local1 = Engine.GetItemGroup(f23_local0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer)
	end
	return f23_local1
end
CoD.CraftUtility.InvalidateAllEmblems = function()
	Engine[@"hash_7A5A65DB03D8E0BA"]()
end
CoD.CraftUtility.Gunsmith.ClearVariantStatType = function(f25_arg0, f25_arg1)
	local f25_local0 = f25_arg0.stats[f25_arg1]
	if f25_local0 then
		f25_local0:set(0)
	end
end
CoD.CraftUtility.Gunsmith.ClearVariantStats = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = f26_arg1 + 1
	local f26_local1 = CoD.CraftUtility.Gunsmith.GetStatsStorageType(f26_arg2)
	local f26_local2 = CoD.CraftUtility.GetDDLRoot(f26_arg0, f26_local1)
	local f26_local3 = f26_local2.VariantStats[f26_local0]
	if f26_local2 and f26_local3 then
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "kills")
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "deaths")
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "deathsDuringUse")
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "shots")
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "hits")
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "headshots")
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "destroyed")
		CoD.CraftUtility.Gunsmith.ClearVariantStatType(f26_local3, "backstabber_kill")
		Engine.StorageWrite(f26_arg0, f26_local1)
	end
end
CoD.CraftUtility.Gunsmith.GetStatsStorageType = function(f27_arg0)
	if f27_arg0 == Enum.eModes.mode_campaign then
		return Enum.StorageFileType[@"storage_cp_stats_online"]
	else
		return Enum.StorageFileType[@"storage_mp_stats_online"]
	end
end
CoD.CraftUtility.Gunsmith.GetSnapshotSessionMode = function()
	local f28_local0 = Engine.GetModel(Engine.GetGlobalModel(), "GunsmithSnapshot.SessionMode")
	local f28_local1 = Enum.eModes.mode_multiplayer
	if f28_local0 then
		f28_local1 = Engine.GetModelValue(f28_local0)
	end
	return f28_local1
end
CoD.CraftUtility.Gunsmith.GetRatio = function(f29_arg0, f29_arg1)
	local f29_local0 = f29_arg0
	if f29_arg1 ~= 0 then
		f29_local0 = f29_arg0 / f29_arg1
	end
	return f29_local0
end
CoD.CraftUtility.Gunsmith.GetVariantStatValue = function(f30_arg0, f30_arg1)
	local f30_local0 = f30_arg0.stats[f30_arg1]
	local f30_local1 = 0
	if f30_local0 then
		f30_local1 = f30_local0:get()
	end
	return f30_local1
end
CoD.CraftUtility.Gunsmith.GetWeaponStatValue = function(f31_arg0, f31_arg1)
	local f31_local0 = f31_arg0.stats[f31_arg1]
	local f31_local1 = 0
	if f31_local0 then
		local f31_local2 = f31_local0.statValue
		if f31_local2 then
			f31_local1 = f31_local2:get()
		end
	end
	return f31_local1
end
CoD.CraftUtility.Gunsmith.GetVariantStats = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
	local f32_local0 = CoD.CraftUtility.GetDDLRoot(f32_arg0, CoD.CraftUtility.Gunsmith.GetStatsStorageType(f32_arg3))
	local f32_local1 = f32_local0.VariantStats[f32_arg2]
	if f32_local0 and f32_local1 then
		if f32_arg1 == "accuracy" then
			return GunsmithAccuracyPercentage(CoD.CraftUtility.Gunsmith.GetRatio(CoD.CraftUtility.Gunsmith.GetVariantStatValue(f32_local1, "hits"), CoD.CraftUtility.Gunsmith.GetVariantStatValue(f32_local1, "shots")))
		elseif f32_arg1 == "kd" then
			return CoD.CraftUtility.Gunsmith.GetRatio(CoD.CraftUtility.Gunsmith.GetVariantStatValue(f32_local1, "kills"), CoD.CraftUtility.Gunsmith.GetVariantStatValue(f32_local1, "deathsDuringUse"))
		else
			return CoD.CraftUtility.Gunsmith.GetVariantStatValue(f32_local1, f32_arg1)
		end
	else
		return 0
	end
end
CoD.CraftUtility.Gunsmith.GetWeaponStats = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3)
	local f33_local0 = CoD.CraftUtility.GetDDLRoot(f33_arg0, CoD.CraftUtility.Gunsmith.GetStatsStorageType(f33_arg3))
	local f33_local1 = f33_local0.ItemStats[f33_arg2]
	if f33_local0 and f33_local1 then
		if f33_arg1 == "accuracy" then
			return GunsmithAccuracyPercentage(CoD.CraftUtility.Gunsmith.GetRatio(CoD.CraftUtility.Gunsmith.GetWeaponStatValue(f33_local1, "hits"), CoD.CraftUtility.Gunsmith.GetWeaponStatValue(f33_local1, "shots")))
		elseif f33_arg1 == "kd" then
			return CoD.CraftUtility.Gunsmith.GetRatio(CoD.CraftUtility.Gunsmith.GetWeaponStatValue(f33_local1, "kills"), CoD.CraftUtility.Gunsmith.GetWeaponStatValue(f33_local1, "deathsDuringUse"))
		elseif f33_arg1 == "backstabber_kill" then
			return 0
		else
			return CoD.CraftUtility.Gunsmith.GetWeaponStatValue(f33_local1, f33_arg1)
		end
	else
	end
end
CoD.CraftUtility.Gunsmith.GetWeaponStatList = function(f34_arg0, f34_arg1, f34_arg2)
	local f34_local0 = {}
	local f34_local1 = Engine.GetItemRef(f34_arg1, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f34_arg2)
	if f34_local1 == "launcher_lockonly" then
		f34_local0 = {
			"destroyed",
		}
	elseif f34_local1 == "launcher_standard" then
		f34_local0 = {
			"kills",
			"destroyed",
		}
	elseif f34_local1 == "knife_loadout" then
		f34_local0 = {
			"kills",
			"backstabber_kill",
			"kd",
		}
	else
		f34_local0 = {
			"kills",
			"headshots",
			"accuracy",
		}
		if f34_arg2 == Enum.eModes.mode_multiplayer then
			table.insert(f34_local0, "kd")
		end
	end
	return f34_local0
end
CoD.CraftUtility.Gunsmith.GetWeaponStatHeader = function(f35_arg0)
	if f35_arg0 == "kills" then
		return "menu/gunsmith_kills_caps"
	elseif f35_arg0 == "headshots" then
		return "menu/gunsmith_headshots_caps"
	elseif f35_arg0 == "accuracy" then
		return "menu/gunsmith_accuracy_caps"
	elseif f35_arg0 == "kd" then
		return "menu/gunsmith_kd_caps"
	elseif f35_arg0 == "destroyed" then
		return "menu/gunsmith_vehicles_destroyed_caps"
	elseif f35_arg0 == "backstabber_kill" then
		return "menu/gunsmith_backstabs_caps"
	else
		return "menu/gunsmith_unknown_caps"
	end
end
CoD.CraftUtility.Gunsmith.WeaponHasNewOptics = function(f36_arg0, f36_arg1)
	if not IsProgressionEnabledT7(f36_arg0) then
		return false
	else
		return Engine.AreAnyOpticsNew(f36_arg0, f36_arg1)
	end
end
CoD.CraftUtility.Gunsmith.WeaponHasNewNonOpticAttachments = function(f37_arg0, f37_arg1)
	if not IsProgressionEnabledT7(f37_arg0) then
		return false
	else
		return Engine.AreAnyNonOpticAttachmentsNew(f37_arg0, f37_arg1)
	end
end
CoD.CraftUtility.Gunsmith.WeaponHasNewCamos = function(f38_arg0, f38_arg1)
	if not IsProgressionEnabledT7(f38_arg0) then
		return false
	end
	for f38_local0 = 0, Engine.GetWeaponOptionsCount(), 1 do
		if Engine.GetWeaponOptionGroupName(f38_local0) == Enum.eWeaponOptionGroup[@"weaponoption_group_camo"] and Engine.IsWeaponOptionNew(f38_arg0, f38_arg1, f38_local0) then
			return true
		end
	end
end
CoD.CraftUtility.Gunsmith.WeaponHasAnyNewItems = function(f39_arg0, f39_arg1)
	if not IsProgressionEnabledT7(f39_arg0) then
		return false
	end
	local f39_local0 = CoD.CraftUtility.Gunsmith.WeaponHasNewOptics(f39_arg0, f39_arg1)
	if not f39_local0 then
		f39_local0 = CoD.CraftUtility.Gunsmith.WeaponHasNewNonOpticAttachments(f39_arg0, f39_arg1)
		if not f39_local0 then
			f39_local0 = CoD.CraftUtility.Gunsmith.WeaponHasNewCamos(f39_arg0, f39_arg1)
		end
	end
	return f39_local0
end
CoD.CraftUtility.Gunsmith.GetBreadcrumbCountForWeaponGroup = function(f40_arg0, f40_arg1)
	if not IsProgressionEnabledT7(f40_arg0) then
		return 0
	end
	local f40_local0 = 0
	local f40_local1 = CoD.CACUtility.GetUnlockableItemTable()
	for f40_local5, f40_local6 in ipairs(f40_local1[f40_arg1]) do
		local f40_local7 = Engine.GetModelValue(Engine.GetModel(f40_local6, "itemIndex"))
		local f40_local8 = CoD.PrestigeUtility.GetPermanentUnlockMode()
		if f40_local7 > CoD.CACUtility.EmptyItemIndex and Engine.IsItemNew(f40_arg0, f40_local7, f40_local8) then
			f40_local0 = f40_local0 + 1
		end
		if not Engine.IsItemLocked(f40_arg0, f40_local7, f40_local8) and CoD.CraftUtility.Gunsmith.WeaponHasAnyNewItems(f40_arg0, f40_local7) then
			f40_local0 = f40_local0 + 1
		end
	end
	return f40_local0
end
CoD.CraftUtility.Gunsmith.AnyNewWeaponsOrAttachmentsForGroup = function(f41_arg0, f41_arg1)
	if not IsProgressionEnabledT7(f41_arg0) then
		return false
	end
	local f41_local0 = CoD.CACUtility.GetUnlockableItemTable()
	for f41_local4, f41_local5 in ipairs(f41_local0[f41_arg1]) do
		local f41_local6 = Engine.GetModelValue(Engine.GetModel(f41_local5, "itemIndex"))
		local f41_local7 = CoD.PrestigeUtility.GetPermanentUnlockMode()
		if f41_local6 > CoD.CACUtility.EmptyItemIndex and Engine.IsItemNew(f41_arg0, f41_local6, f41_local7) then
			return true
		elseif not Engine.IsItemLocked(f41_arg0, f41_local6, f41_local7) and CoD.CraftUtility.Gunsmith.WeaponHasAnyNewItems(f41_arg0, f41_local6) then
			return true
		end
	end
	return false
end
CoD.CraftUtility.Gunsmith.GetSortedAttachmentList = function(f42_arg0, f42_arg1)
	local f42_local0 = {
		baseAttachmentList = {},
	}
	local f42_local1 = 1
	local f42_local2 = 0
	for f42_local3 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
		local f42_local6 = Engine.GetModel(f42_arg1, "attachment" .. f42_local3)
		if f42_local6 then
			local f42_local7 = Engine.GetModelValue(f42_local6)
			if f42_local1 == f42_local3 or f42_local7 ~= CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX then
				table.insert(f42_local0.baseAttachmentList, f42_local7)
				f42_local2 = f42_local2 + 1
			end
		end
	end
	for f42_local3 = f42_local2 + 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
		local f42_local8 = f42_local3
		table.insert(f42_local0.baseAttachmentList, CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX)
	end
	return f42_local0
end
CoD.CraftUtility.Gunsmith.GetAttachmentIconList = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
	return DataSourceHelpers.ListSetup(f43_arg1, function(f44_arg0)
		local f44_local0 = {}
		local f44_local1 = Enum.eModes.mode_multiplayer
		for f44_local6, f44_local7 in ipairs(f43_arg3) do
			if f44_local7 > CoD.CACUtility.EmptyItemIndex then
				local f44_local5 = Engine.GetAttachmentIndexByAttachmentTableIndex(f43_arg2, f44_local7, f44_local1)
				if f44_local5 > CoD.CACUtility.EmptyItemIndex then
					table.insert(f44_local0, {
						models = {
							image = Engine.GetAttachmentImage(f43_arg2, f44_local5, f44_local1) .. "_wv_icon",
						},
					})
				end
			end
		end
		return f44_local0
	end, true)
end
CoD.CraftUtility.Gunsmith.GetTotalAllowedVaraints = function()
	return CoD.CraftUtility.Gunsmith.TotalVariants
end
CoD.CraftUtility.Gunsmith.GetMaxVariantCount = function(f46_arg0, f46_arg1)
	local f46_local0 = CoD.CraftUtility.GetDDLRoot(f46_arg0, f46_arg1)
	return 0
end
CoD.CraftUtility.Gunsmith.GetTotalUsedWeaponVariantsByWeaponGroup = function(f47_arg0)
	local f47_local0 = CoD.CraftUtility.Gunsmith.CachedVariants
	local f47_local1 = 0
	for f47_local2 = 1, #f47_local0, 1 do
		if f47_local0[f47_local2].weaponIndex and Engine.GetWeaponGroup(f47_local0[f47_local2].weaponIndex, Enum.eModes.mode_multiplayer) == tonumber(f47_arg0) then
			f47_local1 = f47_local1 + 1
		end
	end
	return f47_local1
end
CoD.CraftUtility.Gunsmith.GetTotalUsedWeaponVariants = function(f48_arg0)
	local f48_local0 = CoD.CraftUtility.Gunsmith.CachedVariants
	local f48_local1 = 0
	for f48_local2 = 1, #f48_local0, 1 do
		if f48_local0[f48_local2].weaponIndex == f48_arg0 then
			f48_local1 = f48_local1 + 1
		end
	end
	return f48_local1
end
CoD.CraftUtility.Gunsmith.GetTotalUsedVariants = function()
	local f49_local0 = CoD.CraftUtility.Gunsmith.CachedVariants
	local f49_local1 = 0
	for f49_local2 = 1, #f49_local0, 1 do
		if f49_local0[f49_local2].weaponIndex ~= CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX then
			f49_local1 = f49_local1 + 1
		end
	end
	return f49_local1
end
CoD.CraftUtility.Gunsmith.ParseDDL = function(f50_arg0, f50_arg1)
	local f50_local0 = CoD.CraftUtility.GetDDLRoot(f50_arg0, f50_arg1)
	CoD.CraftUtility.Gunsmith.FileType = f50_arg1
	if f50_local0 == nil then
		CoD.CraftUtility.Gunsmith.CachedVariants = {}
		return false
	end
	local f50_local1 = CoD.CraftUtility.Gunsmith.GetMaxVariantCount(f50_arg0, f50_arg1)
	CoD.CraftUtility.Gunsmith.TotalVariants = f50_local1
	for f50_local2 = 0, f50_local1 - 1, 1 do
		local f50_local5 = {}
		local f50_local6 = f50_local0.variant[f50_local2]
		f50_local5.weaponIndex = f50_local6.weaponIndex:get()
		f50_local5.variantIndex = f50_local6.variantIndex:get()
		f50_local5.sortIndex = f50_local6.sortIndex:get()
		f50_local5.readOnly = f50_local6.readOnly:get()
		if f50_local6.createTime ~= nil then
			f50_local5.createTime = Engine.GetLocalizedTimeStr(math.floor(f50_local6.createTime:get()))
		end
		CoD.CraftUtility.Gunsmith.CachedVariants[f50_local2 + 1] = f50_local5
	end
	return true
end
CoD.CraftUtility.Gunsmith.PublishVariant = function(f51_arg0)
	local f51_local0 = CoD.perController[f51_arg0].gunsmithVariantModel
	local f51_local1 = Engine.GetModelValue(Engine.GetModel(f51_local0, "variantIndex"))
	local f51_local2 = Engine.GetModelValue(Engine.GetModel(f51_local0, "paintjobSlot"))
	local f51_local3 = Engine.GetModelValue(Engine.GetModel(f51_local0, "weaponIndex"))
	local f51_local4 = CoD.FileshareUtility.GetPublishName()
	local f51_local5 = CoD.FileshareUtility.GetPublishAllowDownload()
end
CoD.CraftUtility.Gunsmith.GetHighestSortIndexForWeapon = function(f52_arg0)
	local f52_local0 = CoD.CraftUtility.Gunsmith.CachedVariants
	local f52_local1 = CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX
	for f52_local2 = 1, #f52_local0, 1 do
		if f52_local0[f52_local2].weaponIndex == f52_arg0 then
			local f52_local5 = f52_local0[f52_local2].sortIndex
			if f52_local1 < f52_local5 then
				f52_local1 = f52_local5
			end
		end
	end
	return f52_local1
end
CoD.CraftUtility.Gunsmith.GetSortedWeaponVariantList = function(f53_arg0, f53_arg1)
	local f53_local0 = CoD.CraftUtility.Gunsmith.CachedVariants
	local f53_local1 = 0
	local f53_local2 = {}
	local f53_local3 = false
	for f53_local4 = 1, #f53_local0, 1 do
		local f53_local7 = f53_local0[f53_local4]
		if f53_arg1 then
			if not (f53_arg1 ~= "" or f53_local0[f53_local4].weaponIndex == 0) or Engine.GetWeaponGroup(f53_local0[f53_local4].weaponIndex, Enum.eModes.mode_multiplayer) == tonumber(f53_arg1) then
				table.insert(f53_local2, f53_local7)
			end
		end
		if f53_arg0 == nil and f53_local7.weaponIndex ~= 0 then
			table.insert(f53_local2, f53_local7)
		end
		if f53_local0[f53_local4].weaponIndex == CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX and not f53_local3 then
			f53_local7.sortIndex = CoD.CraftUtility.Gunsmith.GetHighestSortIndexForWeapon(f53_arg0) + 1
			f53_local3 = true
			table.insert(f53_local2, f53_local7)
		end
		if f53_local0[f53_local4].weaponIndex == f53_arg0 then
			table.insert(f53_local2, f53_local7)
		end
	end
	table.sort(f53_local2, function(f54_arg0, f54_arg1)
		return f54_arg1.sortIndex < f54_arg0.sortIndex
	end)
	return f53_local2
end
CoD.CraftUtility.Gunsmith.AreMaxVariantSlotsUsed = function()
	local f55_local0 = CoD.CraftUtility.Gunsmith.CachedVariants
	local f55_local1 = true
	for f55_local2 = 1, #f55_local0, 1 do
		if f55_local0[f55_local2].weaponIndex == CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX then
			f55_local1 = false
			break
		end
	end
	return f55_local1
end
CoD.CraftUtility.Gunsmith.GetEmptyTable = function(f56_arg0)
	local f56_local0 = {}
	for f56_local1 = 1, f56_arg0, 1 do
		local f56_local4 = f56_local1
		table.insert(f56_local0, CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX)
	end
	return f56_local0
end
CoD.CraftUtility.Gunsmith.IsVariantIndexOccupied = function(f57_arg0)
	if CoD.CraftUtility.Gunsmith.CachedVariants[f57_arg0 + 1].weaponIndex ~= CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX then
		return true
	else
		return false
	end
end
CoD.CraftUtility.Gunsmith.GetEmptyVariantIndex = function()
	local f58_local0 = CoD.CraftUtility.Gunsmith.CachedVariants
	for f58_local1 = 1, #f58_local0, 1 do
		local f58_local4 = f58_local0[f58_local1]
		if f58_local0[f58_local1].weaponIndex == CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX then
			return f58_local0[f58_local1].variantIndex
		end
	end
end
CoD.CraftUtility.Gunsmith.AddAttachmentToWeapon = function(f59_arg0, f59_arg1)
	if f59_arg1 ~= CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX then
		f59_arg0 = f59_arg0 .. "+" .. Engine.GetAttachmentRefByIndex(f59_arg1)
	end
	return f59_arg0
end
CoD.CraftUtility.Gunsmith.GetWeaponPlusAttachmentsForVariant = function(f60_arg0, f60_arg1)
	local f60_local0 = Engine[@"hash_7B98952F69D937F9"](CoD.GetCustomization(f60_arg0, "weapon_index"), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer)
	local f60_local1 = ""
	if f60_arg1 then
		for f60_local2 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
			f60_local1 = LUI.appendStringWithDelimiter(f60_local1, Engine.GetModelValue(Engine.GetModel(f60_arg1, "attachment" .. f60_local2)), "+")
		end
	end
	return f60_local0, f60_local1
end
CoD.CraftUtility.Gunsmith.GetWeaponAttachmentList = function(f61_arg0, f61_arg1)
	local f61_local0 = CoD.GetCustomization(f61_arg0, "weapon_index")
	local f61_local1 = Engine.GetItemRef(f61_local0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer)
	local f61_local2 = {}
	if f61_arg1 then
		for f61_local3 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
			local f61_local6 = Engine.GetModelValue(Engine.GetModel(f61_arg1, "attachment" .. f61_local3))
			if f61_local6 ~= CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX then
				table.insert(f61_local2, {
					index = Engine.GetAttachmentIndexByAttachmentTableIndex(f61_local0, f61_local6, Enum.eModes.mode_multiplayer),
					ref = Engine.GetAttachmentRefByIndex(f61_local6),
				})
			end
		end
	end
	return f61_local2
end
CoD.CraftUtility.Gunsmith.DisplayBaseWeapon = function(f62_arg0, f62_arg1, f62_arg2)
	local f62_local0 = CoD.GetCustomization(f62_arg2, "weapon_index")
	local f62_local1 = not CoD.SafeGetModelValue(f62_arg1:getModel(), "isBMClassified")
	if f62_local1 and CoD.perController[f62_arg2].editingWeaponBuildKits then
		f62_local1 = not CoD.CACUtility.IsCACItemLocked(f62_arg0, f62_arg1, f62_arg2)
	end
	Engine.SendClientScriptNotify(f62_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f62_arg2), {
		base_weapon_slot = CoD.CraftUtility.GetLoadoutSlot(f62_arg2),
		weapon = Engine[@"hash_7B98952F69D937F9"](f62_local0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer),
		attachments = "",
		camera = CoD.CACUtility.GetCameraNameForAttachments(""),
		options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(0, 0, 0),
		is_item_unlocked = f62_local1,
	})
end
CoD.CraftUtility.Gunsmith.DisplayWeaponWithPaintjob = function(f63_arg0, f63_arg1)
	local f63_local0 = Engine[@"hash_7B98952F69D937F9"](CoD.GetCustomization(f63_arg0, "weapon_index"), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer)
	local f63_local1 = CoD.CraftUtility.GetLoadoutSlot(f63_arg0)
	local f63_local2 = CoD.CACUtility.GetCameraNameForAttachments("")
	Engine.SetupPaintjobData(f63_arg0, f63_arg1)
	Engine.SendClientScriptNotify(f63_arg0, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f63_arg0), {
		base_weapon_slot = f63_local1,
		weapon = f63_local0,
		attachments = "",
		camera = f63_local2,
		options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(0, 0, 1),
	})
end
CoD.CraftUtility.Gunsmith.DisplayWeaponWithVariant = function(f64_arg0, f64_arg1, f64_arg2, f64_arg3, f64_arg4)
	if f64_arg1 then
		local f64_local0 = CoD.CraftUtility.GetLoadoutSlot(f64_arg0)
		local f64_local1, f64_local2 = CoD.CraftUtility.Gunsmith.GetWeaponPlusAttachmentsForVariant(f64_arg0, f64_arg1)
		local f64_local3 = CoD.CACUtility.GetCameraNameForAttachments(f64_local2, f64_arg2)
		if f64_arg4 == nil then
			f64_arg4 = Engine.GetModelValue(Engine.GetModel(f64_arg1, "camoIndex"))
		end
		if f64_arg3 == nil then
			f64_arg3 = Engine.GetModelValue(Engine.GetModel(f64_arg1, "paintjobSlot"))
		end
		Engine.SetupPaintjobData(f64_arg0, f64_arg3)
		Engine.SendClientScriptNotify(f64_arg0, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f64_arg0), {
			base_weapon_slot = f64_local0,
			weapon = f64_local1,
			attachments = f64_local2,
			camera = f64_local3,
			options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(f64_arg4, 0, 1),
		})
	end
end
CoD.CraftUtility.Gunsmith.GetVariantAttachmentList = function(f65_arg0, f65_arg1)
	local f65_local0 = {}
	if f65_arg1 then
		for f65_local1 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
			table.insert(f65_local0, Engine.GetModelValue(Engine.GetModel(f65_arg1, "attachment" .. f65_local1)))
		end
	end
	return f65_local0
end
CoD.CraftUtility.Gunsmith.ClearVariantSlotByAttachmentIndex = function(f66_arg0, f66_arg1, f66_arg2)
	if f66_arg1 then
		for f66_local0 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
			local f66_local3 = Engine.GetModel(f66_arg1, "attachment" .. f66_local0)
			if f66_arg2 == Engine.GetModelValue(f66_local3) then
				Engine.SetModelValue(f66_local3, CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX)
				if f66_local0 == 1 then
					Engine.SetModelValue(Engine.GetModel(f66_arg1, "reticleIndex"), CoD.CraftUtility.Gunsmith.RETICLE_NONE)
				end
			end
		end
	end
end
CoD.CraftUtility.Gunsmith.IsFocusAttachmentEquipped = function(f67_arg0, f67_arg1, f67_arg2)
	if f67_arg1 then
		for f67_local0 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
			if f67_arg2 == Engine.GetModelValue(Engine.GetModel(f67_arg1, "attachment" .. f67_local0)) then
				return true
			end
		end
	end
end
CoD.CraftUtility.Gunsmith.InvalidateRender = function(f68_arg0, f68_arg1)
	CoD.CraftUtility.InvalidateWCItemRender(Engine.GetModelValue(Engine.GetModel(f68_arg1, "paintjobSlot")))
end
CoD.CraftUtility.Groups = {}
CoD.CraftUtility.Groups.CachedGroups = {}
CoD.CraftUtility.Groups.IsDecalGroupSelected = function(f69_arg0)
	local f69_local0
	if f69_arg0 ~= CoD.CraftUtility.EmblemDefaultGroupCategory and f69_arg0 ~= CoD.CraftUtility.EmblemDecalGroupCategory then
		f69_local0 = false
	else
		f69_local0 = true
	end
	return f69_local0
end
CoD.CraftUtility.Groups.GetSelectedStorageFileType = function(f70_arg0)
	local f70_local0 = Enum.StorageFileType[@"hash_15DB8C62CF926911"]
	if CoD.perController[f70_arg0].selectedDecalCategory == CoD.CraftUtility.EmblemDefaultGroupCategory then
		f70_local0 = Enum.StorageFileType[@"hash_562F6DBD58F37089"]
	end
	return f70_local0
end
CoD.CraftUtility.Groups.GetTotalUsed = function(f71_arg0)
	local f71_local0 = CoD.CraftUtility.Groups.GetTotalAllowed(f71_arg0)
	local f71_local1 = 0
	for f71_local2 = 0, f71_local0 - 1, 1 do
		local f71_local5 = CoD.CraftUtility.GetDDLRoot(f71_arg0, CoD.CraftUtility.Groups.GetSelectedStorageFileType(f71_arg0), f71_local2)
		if (f71_local5 and f71_local5.isUsed:get()) == 1 then
			f71_local1 = f71_local1 + 1
		end
	end
	return f71_local1
end
CoD.CraftUtility.Groups.GetTotalAllowed = function(f72_arg0)
	if CoD.CraftUtility.EmblemDefaultGroupCategory == CoD.perController[f72_arg0].selectedDecalCategory then
		local f72_local0 = Engine[@"getstoragefileinfo"](Enum.StorageFileType[@"hash_562F6DBD58F37089"])
		if f72_local0 ~= nil then
			return f72_local0.slots
		end
	end
	local f72_local0 = Engine.MediaManagerGetQuota(f72_arg0, "groups")
	return f72_local0.categoryQuota
end
CoD.CraftUtility.Groups.GetHighestSortIndex = function()
	local f73_local0 = CoD.CraftUtility.Groups.CachedGroups
	local f73_local1 = CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX
	for f73_local2 = 1, #f73_local0, 1 do
		local f73_local5 = f73_local0[f73_local2].sortIndex
		if f73_local1 < f73_local5 then
			f73_local1 = f73_local5
		end
	end
	return f73_local1
end
CoD.CraftUtility.Groups.GetSortedList = function(f74_arg0)
	local f74_local0 = CoD.CraftUtility.Groups.CachedGroups
	local f74_local1 = {}
	local f74_local2 = false
	for f74_local3 = 1, #f74_local0, 1 do
		local f74_local6 = f74_local0[f74_local3]
		if f74_local6.isUsed == 1 then
			table.insert(f74_local1, f74_local6)
		end
	end
	table.sort(f74_local1, function(f75_arg0, f75_arg1)
		return f75_arg1.sortIndex < f75_arg0.sortIndex
	end)
	return f74_local1
end
CoD.CraftUtility.Groups.Rename = function(f76_arg0, f76_arg1, f76_arg2, f76_arg3)
	if 0 <= f76_arg2 then
		local f76_local0 = CoD.CraftUtility.GetDDLRoot(f76_arg1, Enum.StorageFileType[@"hash_15DB8C62CF926911"], f76_arg2)
		f76_local0.emblemName:set(f76_arg3)
		CoD.CraftUtility.UploadAndParseBuffer(f76_arg1, Enum.StorageFileType[@"hash_15DB8C62CF926911"], f76_arg2)
		GoBack(f76_arg0, f76_arg1)
	end
end
CoD.CraftUtility.Groups.Save = function(f77_arg0, f77_arg1)
	CoD.CraftUtility.Groups.Upload(f77_arg1, CoD.perController[f77_arg1].selectedDecalGroupModel)
	CoD.CraftUtility.Groups.ParseDDL(f77_arg1)
	CoD.perController[f77_arg1].selectedDecalGroupModel = nil
	ClearMenuSavedState(GoBack(f77_arg0, f77_arg1), f77_arg1)
end
CoD.CraftUtility.Groups.GetOpenSlot = function(f78_arg0)
	local f78_local0 = CoD.CraftUtility.Groups.GetTotalAllowed(f78_arg0)
	for f78_local1 = 1, f78_local0, 1 do
		if CoD.CraftUtility.Groups.CachedGroups[f78_local1].isUsed == 0 then
			return f78_local1 - 1
		end
	end
	return nil
end
CoD.CraftUtility.Groups.Upload = function(f79_arg0, f79_arg1)
	local f79_local0 = Engine.GetModelValue(Engine.GetModel(f79_arg1, "emblemTextEntry"))
	local f79_local1 = CoD.CraftUtility.Groups.GetOpenSlot(f79_arg0)
	local f79_local2 = CoD.CraftUtility.GetDDLRoot(f79_arg0, Enum.StorageFileType[@"hash_15DB8C62CF926911"], f79_local1)
	local f79_local3 = Engine.GetUsedLayerCount(f79_arg0, Enum.CustomizationType[@"hash_1AB847C1A0E71617"], CoD.perController[f79_arg0].totalLayers)
	if f79_local2 then
		f79_local2.isUsed:set(1)
		f79_local2.sortIndex:set(CoD.CraftUtility.Groups.GetHighestSortIndex() + 1)
		f79_local2.emblemName:set(f79_local0)
		f79_local2.xuid:set(Engine.GetXUID64(f79_arg0))
		f79_local2.layerCount:set(f79_local3)
		f79_local2.createTime:set(Engine.GetCurrentUTCTimeStr())
		Engine[@"hash_36A9513413264177"](f79_arg0, f79_local1)
	end
end
CoD.CraftUtility.Groups.GetName = function(f80_arg0, f80_arg1, f80_arg2)
	if f80_arg2 == Enum.StorageFileType[@"hash_562F6DBD58F37089"] then
		return Engine.Localize("EM/" .. f80_arg1)
	else
		return f80_arg1
	end
end
CoD.CraftUtility.Groups.ParseDDL = function(f81_arg0)
	CoD.CraftUtility.Groups.CachedGroups = {}
	local f81_local0 = CoD.CraftUtility.Groups.GetTotalAllowed(f81_arg0)
	local f81_local1 = CoD.CraftUtility.Groups.GetSelectedStorageFileType(f81_arg0)
	for f81_local2 = 0, f81_local0 - 1, 1 do
		local f81_local5 = {}
		local f81_local6 = CoD.CraftUtility.GetDDLRoot(f81_arg0, f81_local1, f81_local2)
		if f81_local6 then
			f81_local5.emblemIndex = f81_local2
			f81_local5.isUsed = f81_local6.isUsed:get()
			f81_local5.sortIndex = f81_local6.sortIndex:get()
			f81_local5.readOnly = f81_local6.readOnly:get()
			f81_local5.emblemName = CoD.CraftUtility.Groups.GetName(f81_arg0, f81_local6.emblemName:get(), f81_local1)
			f81_local5.layerCount = f81_local6.layerCount:get()
			f81_local5.xuid = Engine[@"hash_690B6BCE69A8E08B"](f81_local6.xuid:get())
			if f81_local6.createTime ~= nil then
				f81_local5.createTime = Engine.GetLocalizedTimeStr(f81_local6.createTime:get())
			end
			CoD.CraftUtility.Groups.CachedGroups[f81_local2 + 1] = f81_local5
		end
	end
	return true
end
CoD.CraftUtility.Groups.Clear = function(f82_arg0, f82_arg1)
	local f82_local0 = Enum.StorageFileType[@"hash_15DB8C62CF926911"]
	local f82_local1 = Enum.CustomizationType[@"hash_1AB847C1A0E71617"]
	if f82_arg1 >= 0 then
		local f82_local2 = CoD.CraftUtility.GetDDLRoot(f82_arg0, f82_local0, f82_arg1)
		if f82_local2 ~= nil then
			f82_local2.emblemName:set("")
			f82_local2.isUsed:set(0)
			f82_local2.sortIndex:set(CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX)
			f82_local2.readOnly:set(CoD.CraftUtility.DEFAULT_READ_ONLY_FLAG)
			Engine[@"hash_53DFB162BEAB9E19"](f82_local1)
		end
	end
end
CoD.CraftUtility.Paintjobs = {}
CoD.CraftUtility.Paintjobs.CachedPaintjobs = {}
CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX = 0
CoD.CraftUtility.Paintjobs.IsEditor = function(f83_arg0)
	return f83_arg0._isPaintjobEditor ~= nil
end
CoD.CraftUtility.Paintjobs.GetPrevViewIndex = function(f84_arg0)
	local f84_local0 = CoD.CraftUtility.GetWeaponGroupName(f84_arg0)
	local f84_local1 = #CoD.CraftUtility.PaintshopView
	if CoD.perController[f84_arg0].viewIndex - 1 == 0 then
		local f84_local2 = f84_local1
	end
	if f84_local0 == "weapon_knife" or Engine.GetItemRef(CoD.GetCustomization(f84_arg0, "weapon_index"), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer) == "special_crossbow" then
		local f84_local2 = CoD.perController[f84_arg0].viewIndex
	end
	return f84_local2
end
CoD.CraftUtility.Paintjobs.GetNextViewIndex = function(f85_arg0)
	local f85_local0 = CoD.CraftUtility.GetWeaponGroupName(f85_arg0)
	local f85_local1 = CoD.perController[f85_arg0].viewIndex % #CoD.CraftUtility.PaintshopView + 1
	if f85_local0 == "weapon_knife" or Engine.GetItemRef(CoD.GetCustomization(f85_arg0, "weapon_index"), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer) == "special_crossbow" then
		f85_local1 = CoD.perController[f85_arg0].viewIndex
	end
	return f85_local1
end
CoD.CraftUtility.Paintjobs.GetTotalWeaponPaintjobs = function(f86_arg0)
	local f86_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f86_local1 = 0
	local f86_local2 = Engine.GetPaintjobSlotInfo()
	local f86_local3 = f86_local2.slot_count
	for f86_local4 = 0, f86_local3 - 1, 1 do
		if f86_local0 then
			local f86_local7 = f86_local0[f86_local4 + 1]
			if f86_local7 and f86_local7.weaponIndex == f86_arg0 then
				f86_local1 = f86_local1 + 1
			end
		end
	end
	return f86_local1
end
CoD.CraftUtility.Paintjobs.GetTotalWeaponPaintjobsByWeaponGroup = function(f87_arg0)
	local f87_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f87_local1 = 0
	local f87_local2 = Engine.GetPaintjobSlotInfo()
	local f87_local3 = f87_local2.slot_count
	for f87_local4 = 0, f87_local3 - 1, 1 do
		if f87_local0 then
			local f87_local7 = f87_local0[f87_local4 + 1]
			if f87_local7 and Engine.GetWeaponGroup(f87_local7.weaponIndex, Enum.eModes.mode_multiplayer) == tonumber(f87_arg0) then
				f87_local1 = f87_local1 + 1
			end
		end
	end
	return f87_local1
end
CoD.CraftUtility.Paintjobs.GetTotalUsedPaintjobs = function()
	local f88_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f88_local1 = 0
	local f88_local2 = Engine.GetPaintjobSlotInfo()
	local f88_local3 = f88_local2.slot_count
	for f88_local4 = 0, f88_local3 - 1, 1 do
		if f88_local0 then
			local f88_local7 = f88_local0[f88_local4 + 1]
			if f88_local7 and f88_local7.weaponIndex ~= CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX then
				f88_local1 = f88_local1 + 1
			end
		end
	end
	return f88_local1
end
CoD.CraftUtility.Paintjobs.TotalPaintjobsForWeaponIndex = function(f89_arg0)
	local f89_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f89_local1 = 0
	local f89_local2 = Engine.GetPaintjobSlotInfo()
	local f89_local3 = f89_local2.slot_count
	for f89_local4 = 0, f89_local3 - 1, 1 do
		if f89_local0 then
			local f89_local7 = f89_local0[f89_local4 + 1]
			if f89_local7 and f89_local7.weaponIndex ~= CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX and f89_local7.weaponIndex == f89_arg0 then
				f89_local1 = f89_local1 + 1
			end
		end
	end
	return f89_local1
end
CoD.CraftUtility.Paintjobs.GetHighestSortIndexForWeapon = function(f90_arg0)
	local f90_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f90_local1 = CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX
	local f90_local2 = Engine.GetPaintjobSlotInfo()
	local f90_local3 = f90_local2.slot_count
	for f90_local4 = 0, f90_local3 - 1, 1 do
		if f90_local0 then
			local f90_local7 = f90_local0[f90_local4 + 1]
			if f90_local7 and f90_local7.weaponIndex == f90_arg0 then
				local f90_local8 = f90_local7.sortIndex
				if f90_local1 < f90_local8 then
					f90_local1 = f90_local8
				end
			end
		end
	end
	return f90_local1
end
CoD.CraftUtility.RefreshPaintjobList = function(f91_arg0)
	if #CoD.CraftUtility.Paintjobs.CachedPaintjobs == 0 then
		CoD.CraftUtility.Paintjobs.ParseDDL(f91_arg0, Enum.StorageFileType[@"storage_paintjobs"])
	end
end
CoD.CraftUtility.Paintjobs.GetCACPaintjobList = function(f92_arg0, f92_arg1)
	CoD.CraftUtility.RefreshPaintjobList(f92_arg0)
	local f92_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f92_local1 = {}
	local f92_local2 = Engine.GetPaintjobSlotInfo()
	local f92_local3 = f92_local2.slot_count
	for f92_local4 = 0, f92_local3 - 1, 1 do
		if f92_local0 then
			local f92_local7 = f92_local0[f92_local4 + 1]
			if f92_local7 and f92_local7.weaponIndex == f92_arg1 then
				table.insert(f92_local1, f92_local7)
			end
		end
	end
	table.sort(f92_local1, function(f93_arg0, f93_arg1)
		return f93_arg1.sortIndex < f93_arg0.sortIndex
	end)
	return f92_local1
end
CoD.CraftUtility.Paintjobs.SortPaintjobList = function(f94_arg0, f94_arg1)
	local f94_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f94_local1 = {}
	local f94_local2 = f94_arg1
	local f94_local3 = Engine.GetPaintjobSlotInfo()
	local f94_local4 = f94_local3.slot_count
	local f94_local5 = CoD.GetCustomization(f94_arg0, "weapon_index")
	for f94_local6 = 0, f94_local4 - 1, 1 do
		if f94_local0 then
			local f94_local9 = f94_local0[f94_local6 + 1]
			if f94_local9 then
				if f94_local9.weaponIndex == CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX then
					if not f94_local2 then
						f94_local2 = true
						f94_local9.sortIndex = CoD.CraftUtility.Paintjobs.GetTotalAllowedPaintjobs(f94_arg0)
						table.insert(f94_local1, f94_local9)
					end
				end
				if f94_local9.weaponIndex == f94_local5 then
					f94_local9.sortIndex = f94_local6
					table.insert(f94_local1, f94_local9)
				end
			end
		end
	end
	table.sort(f94_local1, function(f95_arg0, f95_arg1)
		return f95_arg0.sortIndex < f95_arg1.sortIndex
	end)
	return f94_local1
end
CoD.CraftUtility.Paintjobs.GetSortedWeaponPaintjobList = function(f96_arg0, f96_arg1)
	local f96_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f96_local1 = {}
	local f96_local2 = false
	local f96_local3 = Engine.GetPaintjobSlotInfo()
	local f96_local4 = f96_local3.slot_count
	for f96_local5 = 0, f96_local4 - 1, 1 do
		if f96_local0 then
			local f96_local8 = f96_local0[f96_local5 + 1]
			if f96_local8 then
				if f96_arg1 then
					if not (f96_arg1 ~= "" or f96_local8.weaponIndex == CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX) or Engine.GetWeaponGroup(f96_local8.weaponIndex, Enum.eModes.mode_multiplayer) == tonumber(f96_arg1) then
						table.insert(f96_local1, f96_local8)
					end
				end
				if f96_arg0 == nil and f96_local8.weaponIndex ~= 0 then
					table.insert(f96_local1, f96_local8)
				end
				if f96_local8.weaponIndex == CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX and not f96_local2 then
					f96_local8.sortIndex = CoD.CraftUtility.Paintjobs.GetHighestSortIndexForWeapon(f96_arg0) + 1
					f96_local2 = true
					table.insert(f96_local1, f96_local8)
				end
				if f96_local8.weaponIndex == f96_arg0 then
					table.insert(f96_local1, f96_local8)
				end
			end
		end
	end
	table.sort(f96_local1, function(f97_arg0, f97_arg1)
		return f97_arg1.sortIndex < f97_arg0.sortIndex
	end)
	return f96_local1
end
CoD.CraftUtility.Paintjobs.GetTotalAllowedPaintjobs = function(f98_arg0)
	local f98_local0 = Engine.GetPaintjobSlotInfo()
	local f98_local1 = Engine.MediaManagerGetQuota(f98_arg0, "paintjob")
	return math.min(f98_local0.slot_count, f98_local1.categoryQuota)
end
CoD.CraftUtility.Paintjobs.IsPaintjobIndexOccupied = function(f99_arg0)
	local f99_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs[f99_arg0 + 1]
	if f99_local0 and f99_local0.weaponIndex ~= CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX then
		return true
	else
		return false
	end
end
CoD.CraftUtility.Paintjobs.ParseDDL = function(f100_arg0, f100_arg1)
	local f100_local0 = Engine.GetPaintjobSlotInfo()
	local f100_local1 = f100_local0.slot_count
	local f100_local2 = CoD.CraftUtility.Paintjobs.GetTotalAllowedPaintjobs(f100_arg0)
	if f100_local2 < f100_local1 then
		error("Paintjob DDL: DDL does not support " .. f100_local2 .. " paintjobs.")
		return false
	end
	for f100_local3 = 0, f100_local1 - 1, 1 do
		local f100_local6 = CoD.CraftUtility.GetDDLRoot(f100_arg0, f100_arg1, f100_local3)
		if f100_local6 == nil then
			CoD.CraftUtility.Paintjobs.CachedPaintjobs = {}
			return false
		elseif f100_local2 <= f100_local3 then
			return true
		end
		local f100_local7 = {}
		local f100_local8 = f100_local6.weaponPaintjob
		f100_local7.weaponIndex = f100_local8.weaponIndex:get()
		f100_local7.sortIndex = f100_local8.sortIndex:get()
		f100_local7.paintjobName = f100_local8.paintjobName:get()
		f100_local7.paintjobSlot = f100_local3
		f100_local7.readOnly = f100_local8.readOnly:get()
		f100_local7.createTime = f100_local8.createTime:get()
		f100_local7.xuid = Engine[@"hash_690B6BCE69A8E08B"](f100_local8.xuid:get())
		if f100_local8.createTime ~= nil then
			f100_local7.createTime = Engine.GetLocalizedTimeStr(f100_local8.createTime:get())
		end
		CoD.CraftUtility.Paintjobs.CachedPaintjobs[f100_local3 + 1] = f100_local7
	end
	return true
end
CoD.CraftUtility.Paintjobs.InvalidateRender = function(f101_arg0, f101_arg1)
	CoD.CraftUtility.InvalidateWCItemRender(Engine.GetModelValue(Engine.GetModel(f101_arg1, "paintjobSlot")))
end
CoD.CraftUtility.Paintjobs.UploadPaintjob = function(f102_arg0, f102_arg1)
	local f102_local0 = Engine.GetModelValue(Engine.GetModel(f102_arg1, "paintjobSlot"))
	local f102_local1 = Engine.GetModelValue(Engine.GetModel(f102_arg1, "weaponIndex"))
	local f102_local2 = Engine.GetModelValue(Engine.GetModel(f102_arg1, "sortIndex"))
	local f102_local3 = Engine.GetModelValue(Engine.GetModel(f102_arg1, "paintjobName"))
	if f102_local1 == CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX then
		f102_local1 = CoD.GetCustomization(f102_arg0, "weapon_index")
	end
	local f102_local4 = CoD.CraftUtility.GetDDLRoot(f102_arg0, Enum.StorageFileType[@"storage_paintjobs"], f102_local0)
	if f102_local4 ~= nil then
		local f102_local5 = f102_local4.weaponPaintjob
		f102_local5.weaponIndex:set(f102_local1)
		f102_local5.sortIndex:set(f102_local2)
		f102_local5.paintjobName:set(f102_local3)
		f102_local5.createTime:set(Engine.GetCurrentUTCTimeStr())
		f102_local5.xuid:set(Engine.GetXUID64(f102_arg0))
		Engine.UploadPaintjobData(f102_arg0, f102_local0)
	end
end
CoD.CraftUtility.Paintjobs.GetEmptyPaintjob = function(f103_arg0)
	local f103_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	local f103_local1 = Engine.GetPaintjobSlotInfo()
	local f103_local2 = f103_local1.slot_count
	for f103_local3 = 0, f103_local2 - 1, 1 do
		if f103_local0 then
			local f103_local6 = f103_local0[f103_local3 + 1]
			if f103_local6.weaponIndex == CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX then
				f103_local6.sortIndex = CoD.CraftUtility.Paintjobs.GetHighestSortIndexForWeapon(f103_arg0) + 1
				return f103_local6
			end
		end
	end
end
CoD.CraftUtility.Paintjobs.Copy = function(f104_arg0, f104_arg1)
	local f104_local0 = Engine.GetModelValue(Engine.GetModel(f104_arg1, "paintjobSlot"))
	local f104_local1 = Engine.GetModelValue(Engine.GetModel(f104_arg1, "weaponIndex"))
	local f104_local2 = Engine.GetModelValue(Engine.GetModel(f104_arg1, "paintjobName"))
	local f104_local3 = Engine.GetModelValue(Engine.GetModel(f104_arg1, "xuid"))
	local f104_local4 = CoD.CraftUtility.GetDDLRoot(f104_arg0, Enum.StorageFileType[@"storage_paintjobs"], f104_local0)
	local f104_local5 = CoD.CraftUtility.Paintjobs.GetEmptyPaintjob(f104_local1)
	if f104_local4 ~= nil and f104_local5 ~= nil then
		local f104_local6 = CoD.CraftUtility.GetDDLRoot(f104_arg0, Enum.StorageFileType[@"storage_paintjobs"], f104_local5.paintjobSlot)
		if f104_local6 ~= nil then
			local f104_local7 = f104_local6.weaponPaintjob
			f104_local7.weaponIndex:set(f104_local1)
			f104_local7.sortIndex:set(f104_local5.sortIndex)
			f104_local7.paintjobName:set(f104_local2)
			f104_local7.createTime:set(Engine.GetCurrentUTCTimeStr())
			f104_local7.xuid:set(f104_local3)
			Engine.UploadPaintjobData(f104_arg0, f104_local5.paintjobSlot)
			return f104_local5.paintjobSlot
		end
	end
end
CoD.CraftUtility.Paintjobs.RemovePaintJobFromLoadout = function(f105_arg0, f105_arg1, f105_arg2, f105_arg3)
	local f105_local0 = Engine.StorageGetBuffer(f105_arg0, f105_arg2)
	f105_local0 = f105_local0.cacloadouts
	local f105_local1 = CoD.CACUtility.GetCustomClassCount(f105_arg0, f105_arg3)
	for f105_local2 = 0, f105_local1 - 1, 1 do
		local f105_local5 = f105_local0.customclass[f105_local2].primarypaintjobslot:get()
		local f105_local6 = f105_local0.customclass[f105_local2].secondarypaintjobslot:get()
		if f105_local5 == f105_arg1 then
			f105_local0.customclass[f105_local2].primarypaintjobslot:set(Enum.CustomizationPaintjobInvalidID[@"customization_invalid_paintjob_slot"])
		end
		if f105_local6 == f105_arg1 then
			f105_local0.customclass[f105_local2].secondarypaintjobslot:set(Enum.CustomizationPaintjobInvalidID[@"customization_invalid_paintjob_slot"])
		end
	end
end
CoD.CraftUtility.Paintjobs.RemovePaintJobFromVariantList = function(f106_arg0, f106_arg1, f106_arg2)
	for f106_local0 = 0, f106_arg1 - 1, 1 do
		if f106_arg0.variant[f106_local0].paintjobSlot:get() == f106_arg2 then
			f106_arg0.variant[f106_local0].paintjobSlot:set(Enum.CustomizationPaintjobInvalidID[@"customization_invalid_paintjob_slot"])
		end
	end
end
CoD.CraftUtility.Paintjobs.RemovePaintJobFromZM = function(f107_arg0, f107_arg1)
	local f107_local0 = Engine.StorageGetBuffer(f107_arg0, Enum.StorageFileType[@"storage_zm_loadouts"])
	f107_local0 = f107_local0.cacloadouts
	CoD.CraftUtility.Paintjobs.RemovePaintJobFromVariantList(f107_local0, #f107_local0.variant, f107_arg1)
end
CoD.CraftUtility.Paintjobs.RemovePaintJobFromAllLoadouts = function(f108_arg0, f108_arg1)
	CoD.CraftUtility.Paintjobs.RemovePaintJobFromLoadout(f108_arg0, f108_arg1, Enum.StorageFileType[@"storage_mp_loadouts"], Enum.eModes.mode_multiplayer)
	CoD.CraftUtility.Paintjobs.RemovePaintJobFromZM(f108_arg0, f108_arg1)
end
CoD.CraftUtility.Paintjobs.ClearPaintjob = function(f109_arg0, f109_arg1)
	local f109_local0 = CoD.CraftUtility.GetDDLRoot(f109_arg0, Enum.StorageFileType[@"storage_paintjobs"], f109_arg1)
	if f109_local0 ~= nil then
		local f109_local1 = f109_local0.weaponPaintjob
		f109_local1.paintjobName:set("")
		f109_local1.sortIndex:set(CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX)
		f109_local1.weaponIndex:set(CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX)
		f109_local1.readOnly:set(CoD.CraftUtility.DEFAULT_READ_ONLY_FLAG)
		Engine.ClearPaintjobLayerData()
		Engine.UploadPaintjobData(f109_arg0, f109_arg1)
	end
end
CoD.CraftUtility.Paintjobs.GetPaintjobName = function(f110_arg0, f110_arg1)
	local f110_local0 = CoD.CraftUtility.GetDDLRoot(f110_arg0, Enum.StorageFileType[@"storage_paintjobs"], f110_arg1)
	if f110_local0 ~= nil then
		return f110_local0.weaponPaintjob.paintjobName:get()
	else
		return ""
	end
end
CoD.CraftUtility.Paintjobs.RenamePaintjob = function(f111_arg0, f111_arg1, f111_arg2)
	local f111_local0 = Enum.StorageFileType[@"storage_paintjobs"]
	local f111_local1 = CoD.CraftUtility.GetDDLRoot(f111_arg0, f111_local0, f111_arg1)
	if f111_local1 ~= nil then
		f111_local1.weaponPaintjob.paintjobName:set(f111_arg2)
		CoD.CraftUtility.UploadAndParseBuffer(f111_arg0, f111_local0, f111_arg1)
	end
end
CoD.CraftUtility.Paintjobs.PublishPaintjob = function(f112_arg0)
	local modelValue = Engine.GetModelValue(Engine.GetModel(CoD.perController[f112_arg0].selectedPaintjobModel, "paintjobSlot"))
	local f112_local1 = CoD.CraftUtility.GetDDLRoot(f112_arg0, Enum.StorageFileType[@"storage_paintjobs"], modelValue)
	if f112_local1 ~= nil then
		Engine.PublishPaintjob(f112_arg0, "paintjob", modelValue, f112_local1.weaponPaintjob.weaponIndex:get(), CoD.FileshareUtility.GetPublishName(), CoD.FileshareUtility.GetPublishAllowDownload())
	end
end
CoD.CraftUtility.Paintjobs.GetPaintjobWeaponIndex = function(f113_arg0, f113_arg1)
	local f113_local0 = CoD.CraftUtility.Paintjobs.CachedPaintjobs
	if f113_local0 then
		for f113_local1 = 1, #f113_local0, 1 do
			local f113_local4 = f113_local0[f113_local1]
			if f113_local4 and f113_local4.paintjobSlot == f113_arg1 then
				return f113_local4.weaponIndex
			end
		end
	end
	return CoD.GetCustomization(f113_arg0, "weapon_index")
end
CoD.CraftUtility.Paintjobs.GetOpenSlot = function(f114_arg0)
	local f114_local0 = Engine.GetPaintjobSlotInfo()
	local f114_local1 = f114_local0.slot_count
	for f114_local2 = 1, f114_local1, 1 do
		local f114_local5 = CoD.CraftUtility.Paintjobs.CachedPaintjobs[f114_local2]
		if f114_local5 and f114_local5.weaponIndex == CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX then
			return f114_local2 - 1
		end
	end
	return nil
end
CoD.CraftUtility.Emblems = {}
CoD.CraftUtility.Emblems.CachedEmblems = {}
CoD.CraftUtility.Emblems.INVALID_DEFAULT_EMBLEMINDEX = -1
CoD.CraftUtility.Emblems.INVALID_EMBLEMINDEX = -1
CoD.CraftUtility.Emblems.STICKER_SET_COUNT = 6
CoD.CraftUtility.Emblems.EDITOR_TABS = {
	{
		type = "custom",
		displayName = "menu/emblem_custom_tab",
		category = 1,
		storageType = Enum.StorageFileType[@"storage_emblems"],
		frameWidget = "CoD.EmblemListFrame",
		requiresLive = true,
		requiresUGC = true,
	},
	{
		type = "prebuilt",
		displayName = "menu/emblem_prebuilt_tab",
		category = 2,
		storageType = Enum.StorageFileType[@"storage_default_emblems"],
		frameWidget = "CoD.EmblemListFrame",
		requiresLive = false,
		requiresUGC = true,
	},
}
CoD.CraftUtility.Emblems.SELECT_TABS = {
	{
		type = "sticker",
		displayName = "menu/stickers_caps",
		category = 4,
		storageType = Enum.StorageFileType[@"hash_36A0A3D1062F156F"],
		stickerCategory = CoD.CraftUtility.EmblemStickerCategory,
		frameWidget = "CoD.EmblemListFrame",
		requiresLive = true,
		requiresUGC = true,
	},
	{
		type = "stickerset",
		displayName = @"hash_17F59D77E1C3A48A",
		category = 4,
		storageType = Enum.StorageFileType[@"hash_36A0A3D1062F156F"],
		stickerCategory = CoD.CraftUtility.EmblemStickerSetCategory,
		frameWidget = "CoD.StickerSetFrame",
		requiresLive = true,
		requiresUGC = true,
	},
	{
		type = "prebuilt",
		displayName = "menu/emblem_prebuilt_tab",
		category = 2,
		storageType = Enum.StorageFileType[@"storage_default_emblems"],
		frameWidget = "CoD.EmblemListFrame",
		requiresLive = false,
		requiresUGC = false,
	},
	{
		type = "custom",
		displayName = "menu/emblem_custom_tab",
		category = 1,
		storageType = Enum.StorageFileType[@"storage_emblems"],
		frameWidget = "CoD.EmblemListFrame",
		requiresLive = true,
		requiresUGC = true,
		disableForTrial = true,
	},
}
CoD.CraftUtility.Emblems.IsEditor = function(f115_arg0)
	return f115_arg0._isEditor == "true"
end
CoD.CraftUtility.Emblems.IsClan = function(f116_arg0)
	return f116_arg0._isClan == true
end
CoD.CraftUtility.Emblems.IsStickerFileType = function(f117_arg0)
	return f117_arg0 == Enum.StorageFileType[@"hash_36A0A3D1062F156F"]
end
CoD.CraftUtility.Emblems.GetHighestSortIndex = function()
	local f118_local0 = CoD.CraftUtility.Emblems.CachedEmblems
	local f118_local1 = CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX
	for f118_local2 = 1, #f118_local0, 1 do
		local f118_local5 = f118_local0[f118_local2].sortIndex
		if f118_local1 < f118_local5 then
			f118_local1 = f118_local5
		end
	end
	return f118_local1
end
CoD.CraftUtility.Emblems.ShouldShowStickerSets = function(f119_arg0)
	local f119_local0 = Engine.GetGlobalModel()
	f119_local0 = f119_local0:get("Craft.ownStickerSet")
	if f119_local0 and f119_local0:get() == true then
		return true
	end
	local f119_local1 = false
	local f119_local2 = Engine.EmblemFilterCount(f119_arg0, 0, CoD.CraftUtility.EmblemStickerSetCategory)
	for f119_local3 = 0, f119_local2 - 1, 1 do
		local f119_local6 = CoD.BlackMarketTableUtility.LootInfoLookup(f119_arg0, CoD.BlackMarketUtility.GetLootDecalName(f119_arg0, Engine.EmblemFilterIconID(f119_arg0, 0, CoD.CraftUtility.EmblemStickerSetCategory, f119_local3)))
		if f119_local6.owned or f119_local6.available then
			f119_local1 = true
			break
		end
	end
	local f119_local3 = Engine.GetGlobalModel()
	f119_local3 = f119_local3:create("Craft.ownStickerSet", true)
	f119_local3:set(f119_local1)
	return f119_local1
end
CoD.CraftUtility.Emblems.IsStickerIDUnlocked = function(f120_arg0, f120_arg1)
	local f120_local0 = Engine.EmblemFilterCount(f120_arg0, 0, CoD.CraftUtility.EmblemStickerSetCategory)
	local f120_local1 = CoD.BlackMarketTableUtility.LootInfoLookup(f120_arg0, CoD.BlackMarketUtility.GetLootDecalName(f120_arg0, f120_arg1))
	return f120_local1.owned, f120_local1
end
CoD.CraftUtility.Emblems.GetSetUnlockInfo = function(f121_arg0, f121_arg1, f121_arg2)
	local f121_local0 = {
		unlockedBonus = false,
		setUnlocked = false,
		setName = 0x0,
		ownedCount = 0,
		totalCount = 0,
	}
	for f121_local1 = f121_arg2, f121_arg2 + CoD.CraftUtility.Emblems.STICKER_SET_COUNT - 1, 1 do
		local f121_local4 = f121_arg1[f121_local1]
		local f121_local5 = CoD.BlackMarketTableUtility.LootInfoLookup(f121_arg0, CoD.BlackMarketUtility.GetLootDecalName(f121_arg0, f121_local4.emblemIndex))
		if f121_local5.isLoot then
		else
			f121_local0.setUnlocked = false
			break
		end
		local f121_local6 = CoD.BlackMarketTableUtility.GetLootBonusStringRef(f121_arg0, f121_local5.inSet)
		f121_local4.lootInfo = f121_local5
		f121_local4.setInfo = f121_local6
		if f121_local5.owned and not f121_local5.setMaster then
			f121_local0.ownedCount = f121_local0.ownedCount + 1
		end
		if f121_local5.owned or f121_local5.available then
			f121_local0.setUnlocked = true
		end
		if f121_local5.setMaster and f121_local5.owned then
			f121_local0.unlockedBonus = true
		end
		if not f121_local5.owned and not f121_local5.available then
			f121_local4.emblemName = CoD.BlackMarketUtility.ClassifiedName(true)
		end
		f121_local4.isBonusItem = f121_local5.setMaster
		f121_local4.setName = f121_local6
		f121_local0.setName = f121_local6 or 0x0
		if not f121_local5.setMaster then
			f121_local0.totalCount = f121_local0.totalCount + 1
		end
	end
	if f121_local0.totalCount > 0 then
		local f121_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1587BB89C78FFE9A", f121_local0.setName, f121_local0.ownedCount, f121_local0.totalCount)
		for f121_local2 = f121_arg2, f121_arg2 + CoD.CraftUtility.Emblems.STICKER_SET_COUNT - 1, 1 do
			local f121_local5 = f121_arg1[f121_local2]
			if f121_local5.isBonusItem then
				f121_local5.setInfo = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F4082FA89EBEDBA", f121_local5.setName, Engine[@"hash_4F9F1239CFD921FE"](@"hash_120BF14474EB8696", Engine[@"hash_4F9F1239CFD921FE"](@"hash_684446BBFA84177E")))
			else
				f121_local5.setInfo = f121_local1
			end
		end
	end
	return f121_local0
end
CoD.CraftUtility.Emblems.CopyLootModels = function(f122_arg0, f122_arg1)
	if f122_arg0 and f122_arg1 then
		for f122_local5, f122_local3 in pairs(f122_arg1) do
			if f122_local5 == "rarity" then
				f122_local3 = CoD.BlackMarketUtility.LootIdRarities[f122_arg1.rarity] or Enum.LootRarityType[@"loot_rarity_type_count"]
			end
			local f122_local4 = f122_arg0:create(f122_local5)
			f122_local4:set(f122_local3)
		end
	elseif f122_arg0 then
		local f122_local0 = f122_arg0:create("rarity")
		f122_local0:set(Enum.LootRarityType[@"loot_rarity_type_count"])
		f122_local0 = f122_arg0:create("unlockInfo")
		f122_local0:set("")
		f122_local0 = f122_arg0:create("available")
		f122_local0:set(true)
		f122_local0 = f122_arg0:create("owned")
		f122_local0:set(true)
	end
end
CoD.CraftUtility.Emblems.GetSortedStickersList = function(f123_arg0, f123_arg1)
	local f123_local0 = {}
	local f123_local1 = Engine.EmblemFilterCount(f123_arg0, 0, CoD.CraftUtility.EmblemStickerSetCategory)
	for f123_local2 = 0, f123_local1 - 1, 1 do
		local f123_local5 = Engine.EmblemFilterIconID(f123_arg0, 0, CoD.CraftUtility.EmblemStickerSetCategory, f123_local2)
		f123_local0[f123_local2 + 1] = {
			emblemIndex = f123_local5,
			isUsed = 1,
			sortIndex = Engine[@"hash_22FE7BA4FBFD894B"](f123_local5),
			readOnly = 1,
			emblemName = Engine[@"hash_4F9F1239CFD921FE"](GetEmblemDecalDesc(f123_local5)),
		}
	end
	local f123_local2 = {}
	local f123_local3 = false
	local f123_local4 = 1
	while f123_local4 < #f123_local0 do
		local f123_local6 = CoD.CraftUtility.Emblems.GetSetUnlockInfo(f123_arg0, f123_local0, f123_local4)
		if f123_local6.setUnlocked then
			local f123_local5 = 1
			for f123_local7 = f123_local4, f123_local4 + CoD.CraftUtility.Emblems.STICKER_SET_COUNT - 1, 1 do
				local f123_local10 = f123_local0[f123_local7]
				if f123_local10.isBonusItem then
					f123_local10.setPieceIndex = CoD.CraftUtility.Emblems.STICKER_SET_COUNT
					if f123_local10.lootInfo then
						if f123_local10.lootInfo.owned then
							f123_local10.lootInfo.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_complete")
						else
							f123_local10.lootInfo.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_incomplete")
						end
					end
				else
					f123_local10.setPieceIndex = f123_local5
					f123_local5 = f123_local5 + 1
				end
				local f123_local11 = f123_local10.lootInfo
				if f123_local11 then
					f123_local11 = f123_local10.lootInfo.isLoot
					if f123_local11 then
						f123_local11 = f123_local10.lootInfo.owned
						if f123_local11 then
							f123_local11 = Engine[@"hash_5CB675CA7856DA25"]()
						end
					end
				end
				f123_local10.isTrialLocked = f123_local11
				table.insert(f123_local2, f123_local10)
			end
		end
		f123_local4 = f123_local4 + CoD.CraftUtility.Emblems.STICKER_SET_COUNT
	end
	table.sort(f123_local2, function(f124_arg0, f124_arg1)
		if f124_arg0.lootInfo and f124_arg1.lootInfo and f124_arg0.lootInfo.inSet == f124_arg1.lootInfo.inSet then
			if f124_arg0.isBonusItem then
				return false
			elseif f124_arg1.isBonusItem then
				return true
			end
		end
		return f124_arg0.sortIndex < f124_arg1.sortIndex
	end)
	return f123_local2
end
CoD.CraftUtility.Emblems.GetSortedEmblemsList = function(f125_arg0, f125_arg1, f125_arg2)
	local f125_local0 = CoD.CraftUtility.Emblems.CachedEmblems
	local f125_local1 = {}
	local f125_local2 = false
	for f125_local3 = 1, #f125_local0, 1 do
		local f125_local6 = f125_local0[f125_local3]
		if f125_arg2 and f125_local6.isUsed == 0 and not f125_local2 and f125_arg1 == Enum.StorageFileType[@"storage_emblems"] and not SelectingGroupEmblem(f125_arg0) then
			f125_local6.sortIndex = CoD.CraftUtility.Emblems.GetHighestSortIndex() + 1
			f125_local2 = true
			table.insert(f125_local1, f125_local6)
		end
		if f125_local6.isUsed == 1 then
			local f125_local7 = false
			if (f125_arg1 ~= Enum.StorageFileType[@"storage_emblems_loot"] or not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(CoD.BlackMarketUtility.GetLootEmblemIDName(f125_local6.emblemIndex))) and not f125_local6.hidden then
				local f125_local8 = f125_local6.lootInfo
				if f125_local8 then
					f125_local8 = f125_local6.lootInfo.isLoot
					if f125_local8 then
						f125_local8 = f125_local6.lootInfo.owned
						if f125_local8 then
							f125_local8 = Engine[@"hash_5CB675CA7856DA25"]()
						end
					end
				end
				f125_local6.isTrialLocked = f125_local8
				table.insert(f125_local1, f125_local6)
			end
		end
	end
	table.sort(f125_local1, function(f126_arg0, f126_arg1)
		if f126_arg0.lootInfo and f126_arg1.lootInfo then
			if f126_arg0.lootInfo.owned ~= f126_arg1.lootInfo.owned then
				return f126_arg0.lootInfo.owned == true
			elseif f126_arg0.lootInfo.rarity ~= f126_arg1.lootInfo.rarity then
				local f126_local0 = CoD.BlackMarketUtility.LootIdRarities[f126_arg0.lootInfo.rarity]
				if not f126_local0 then
					f126_local0 = Enum.LootRarityType[@"loot_rarity_type_count"]
				end
				local f126_local1 = CoD.BlackMarketUtility.LootIdRarities[f126_arg1.lootInfo.rarity]
				if not f126_local1 then
					f126_local1 = Enum.LootRarityType[@"loot_rarity_type_count"]
				end
				if f126_local0 == Enum.LootRarityType[@"loot_rarity_type_count"] then
					return false
				elseif f126_local1 == Enum.LootRarityType[@"loot_rarity_type_count"] then
					return true
				else
					return f126_local1 < f126_local0
				end
			end
		elseif f126_arg0.lootInfo then
			return f126_arg0.lootInfo.owned == true
		elseif f126_arg1.lootInfo then
			return not f126_arg1.lootInfo.owned == true
		end
		return f126_arg0.sortIndex < f126_arg1.sortIndex
	end)
	return f125_local1
end
CoD.CraftUtility.Emblems.GetTotalUsedEmblems = function(f127_arg0, f127_arg1, f127_arg2)
	if CoD.CraftUtility.Emblems.IsStickerFileType(f127_arg1) then
		return Engine.EmblemFilterCount(f127_arg0, 0, f127_arg2)
	end
	local f127_local0 = CoD.CraftUtility.Emblems.GetTotalAllowedEmblems(f127_arg0, f127_arg1)
	local f127_local1 = 0
	for f127_local2 = 0, f127_local0 - 1, 1 do
		local f127_local5 = CoD.CraftUtility.GetDDLRoot(f127_arg0, f127_arg1, f127_local2)
		if (f127_local5 and f127_local5.isUsed:get()) == 1 then
			f127_local1 = f127_local1 + 1
		end
	end
	return f127_local1
end
CoD.CraftUtility.Emblems.GetTotalAllowedEmblems = function(f128_arg0, f128_arg1, f128_arg2)
	if CoD.CraftUtility.Emblems.IsStickerFileType(f128_arg1) then
		return Engine.EmblemFilterCount(f128_arg0, 0, f128_arg2)
	elseif f128_arg1 == Enum.StorageFileType[@"storage_default_emblems"] or f128_arg1 == Enum.StorageFileType[@"storage_emblems_loot"] then
		local f128_local0 = Engine[@"getstoragefileinfo"](f128_arg1)
		if f128_local0 ~= nil then
			return f128_local0.slots
		end
	end
	local f128_local0 = Engine.MediaManagerGetQuota(f128_arg0, "emblem")
	return f128_local0.categoryQuota
end
CoD.CraftUtility.Emblems.GetOpenSlot = function(f129_arg0)
	local f129_local0 = CoD.CraftUtility.Emblems.GetTotalAllowedEmblems(f129_arg0, Enum.StorageFileType[@"storage_emblems"], nil)
	for f129_local1 = 1, f129_local0, 1 do
		if CoD.CraftUtility.Emblems.CachedEmblems[f129_local1].isUsed == 0 then
			return f129_local1 - 1
		end
	end
	return nil
end
CoD.CraftUtility.Emblems.GetEmblemName = function(f130_arg0, f130_arg1, f130_arg2)
	if f130_arg2 ~= Enum.StorageFileType[@"storage_emblems"] then
		return Engine.Localize("EM/" .. f130_arg1)
	else
		return f130_arg1
	end
end
CoD.CraftUtility.Emblems.AddStickersToCache = function(f131_arg0, f131_arg1, f131_arg2)
	local f131_local0 = #CoD.CraftUtility.Emblems.CachedEmblems + 1
	local f131_local1 = Engine.EmblemFilterCount(f131_arg0, 0, f131_arg1)
	for f131_local2 = 0, f131_local1 - 1, 1 do
		local f131_local5 = Engine.EmblemFilterIconID(f131_arg0, 0, f131_arg1, f131_local2)
		local f131_local6 = {
			emblemIndex = f131_local5,
			isUsed = 1,
			sortIndex = Engine[@"hash_22FE7BA4FBFD894B"](f131_local5),
			readOnly = 1,
			emblemName = Engine[@"hash_4F9F1239CFD921FE"](GetEmblemDecalDesc(f131_local5)),
			fileType = Enum.StorageFileType[@"hash_36A0A3D1062F156F"],
		}
		if f131_arg2 then
			local f131_local7 = CoD.BlackMarketTableUtility.LootInfoLookup(f131_arg0, CoD.BlackMarketUtility.GetLootDecalName(f131_arg0, f131_local5), CoD.BlackMarketUtility.GetLootDecalEntitlementName(f131_arg0, f131_local5))
			if Engine[@"hash_2D1419DCE072A0B1"](f131_local5) then
				f131_local6.hidden = Engine[@"hash_52EE0A51483D8E7C"](f131_arg0, f131_local5)
				f131_local6.isEntitlement = true
			else
				local f131_local8
				if not f131_local7.owned then
					f131_local8 = not f131_local7.available
				else
					f131_local8 = false
				end
				f131_local6.hidden = f131_local8
				f131_local6.isEntitlement = false
			end
			f131_local6.lootInfo = f131_local7
		end
		CoD.CraftUtility.Emblems.CachedEmblems[f131_local0] = f131_local6
		f131_local0 = f131_local0 + 1
	end
end
CoD.CraftUtility.Emblems.AddStickersToDecalList = function(f132_arg0, f132_arg1, f132_arg2, f132_arg3, f132_arg4)
	local f132_local0 = #f132_arg2 + 1
	local f132_local1 = Engine.EmblemFilterCount(f132_arg0, 0, f132_arg3)
	for f132_local2 = 0, f132_local1 - 1, 1 do
		local f132_local5 = Engine.EmblemFilterIconID(f132_arg0, 0, f132_arg3, f132_local2)
		local f132_local6 = false
		local f132_local7, f132_local8 = false
		if f132_arg4 then
			f132_local8 = CoD.BlackMarketTableUtility.LootInfoLookup(f132_arg0, CoD.BlackMarketUtility.GetLootDecalName(f132_arg0, f132_local5))
			if Engine[@"hash_2D1419DCE072A0B1"](f132_local5) then
				f132_local6 = Engine[@"hash_52EE0A51483D8E7C"](f132_arg0, f132_local5)
				f132_local7 = true
			else
				f132_local6 = not f132_local8.owned
			end
		end
		local f132_local9 = false
		local f132_local10 = @"hash_684446BBFA84177E"
		if f132_arg3 == CoD.CraftUtility.EmblemDecalIconsCategory or f132_arg3 == CoD.CraftUtility.EmblemDecalToolsCategory then
			f132_local10 = @"mpui/decal"
			f132_local9 = true
		end
		if not f132_local6 or f132_local8 and f132_local8.available then
			local f132_local11 = Engine.CreateModel(f132_arg1, "icon_" .. f132_local0)
			local f132_local12 = f132_local11:create("iconID")
			f132_local12:set(f132_local5)
			f132_local12 = f132_local11:create("sortKey")
			f132_local12:set(Engine[@"hash_22FE7BA4FBFD894B"](f132_local5))
			f132_local12 = f132_local11:create("displayName")
			f132_local12:set(Engine[@"hash_4F9F1239CFD921FE"](GetEmblemDecalDesc(f132_local5)))
			f132_local12 = f132_local11:create("category")
			f132_local12:set(f132_local10)
			f132_local12 = f132_local11:create("owned")
			f132_local12:set(true)
			f132_local12 = f132_local11:create("skipDefaultTitle")
			f132_local12:set(f132_local9)
			f132_local12 = f132_local11:create("hideRarity")
			f132_local12:set(f132_local7)
			CoD.CraftUtility.Emblems.CopyLootModels(f132_local11, f132_local8)
			table.insert(f132_arg2, f132_local11)
			f132_local0 = f132_local0 + 1
		end
	end
end
CoD.CraftUtility.Emblems.AddEmblemToCache = function(f133_arg0, f133_arg1)
	local f133_local0 = #CoD.CraftUtility.Emblems.CachedEmblems + 1
	local f133_local1 = CoD.CraftUtility.Emblems.GetTotalAllowedEmblems(f133_arg0, f133_arg1, nil)
	for f133_local2 = 0, f133_local1 - 1, 1 do
		local f133_local5 = {}
		local f133_local6 = CoD.CraftUtility.GetDDLRoot(f133_arg0, f133_arg1, f133_local2)
		if f133_local6 then
			f133_local5.emblemIndex = f133_local2
			f133_local5.isUsed = f133_local6.isUsed:get()
			f133_local5.sortIndex = f133_local6.sortIndex:get()
			f133_local5.readOnly = f133_local6.readOnly:get()
			f133_local5.assetHash = Engine[@"converttoxhash"](f133_local6.emblemName:get())
			f133_local5.emblemName = CoD.CraftUtility.Emblems.GetEmblemName(f133_arg0, f133_local6.emblemName:get(), f133_arg1)
			f133_local5.xuid = Engine[@"hash_690B6BCE69A8E08B"](f133_local6.xuid:get())
			f133_local5.hidden = not CoD.CraftUtility.IsEmblemUnlocked(f133_arg0, f133_local5.assetHash, f133_arg1)
			f133_local5.fileType = f133_arg1
			if f133_local6.createTime ~= nil then
				f133_local5.createTime = Engine.GetLocalizedTimeStr(f133_local6.createTime:get())
			end
			CoD.CraftUtility.Emblems.CachedEmblems[f133_local0] = f133_local5
			f133_local0 = f133_local0 + 1
		end
	end
end
CoD.CraftUtility.Emblems.ParseDDL = function(f134_arg0, f134_arg1, f134_arg2)
	CoD.CraftUtility.Emblems.CachedEmblems = {}
	if CoD.CraftUtility.Emblems.IsStickerFileType(f134_arg1) then
		CoD.CraftUtility.Emblems.AddStickersToCache(f134_arg0, CoD.CraftUtility.EmblemDefaultStickerCategory, false)
		CoD.CraftUtility.Emblems.AddStickersToCache(f134_arg0, f134_arg2, true)
		return true
	end
	CoD.CraftUtility.Emblems.AddEmblemToCache(f134_arg0, f134_arg1)
	if f134_arg1 == Enum.StorageFileType[@"storage_default_emblems"] then
		CoD.CraftUtility.Emblems.AddEmblemToCache(f134_arg0, Enum.StorageFileType[@"storage_emblems_loot"])
	end
	return true
end
CoD.CraftUtility.Emblems.IsEmblemIndexOccupied = function(f135_arg0, f135_arg1)
	local f135_local0 = CoD.CraftUtility.Emblems.CachedEmblems
	for f135_local1 = 1, #f135_local0, 1 do
		local f135_local4 = f135_local0[f135_local1]
		if f135_local4.emblemIndex == f135_arg0 and f135_local4.fileType == f135_arg1 then
			return f135_local4.isUsed == 1
		end
	end
	return false
end
CoD.CraftUtility.Emblems.UploadEmblem = function(f136_arg0, f136_arg1)
	local f136_local0 = Engine.GetModelValue(Engine.GetModel(f136_arg1, "emblemIndex"))
	local f136_local1 = Engine.GetModelValue(Engine.GetModel(f136_arg1, "sortIndex"))
	local f136_local2 = Engine.GetModelValue(Engine.GetModel(f136_arg1, "displayName"))
	local f136_local3 = Engine.GetUsedLayerCount(f136_arg0, CoD.GetCustomization(f136_arg0, "type"), CoD.perController[f136_arg0].totalLayers)
	local f136_local4 = CoD.CraftUtility.GetDDLRoot(f136_arg0, Enum.StorageFileType[@"storage_emblems"], f136_local0)
	if f136_local4 then
		f136_local4.isUsed:set(1)
		f136_local4.sortIndex:set(f136_local1)
		f136_local4.emblemName:set(f136_local2)
		f136_local4.xuid:set(Engine.GetXUID64(f136_arg0))
		f136_local4.createTime:set(Engine.GetCurrentUTCTimeStr())
		f136_local4.layerCount:set(f136_local3)
		Engine.UploadEmblemData(f136_arg0, f136_local0)
	end
end
CoD.CraftUtility.Emblems.RenameEmblem = function(f137_arg0, f137_arg1, f137_arg2)
	local f137_local0 = CoD.perController[f137_arg0].selectedEmblemTabStorageType
	if f137_arg1 >= 0 then
		local f137_local1 = CoD.CraftUtility.GetDDLRoot(f137_arg0, f137_local0, f137_arg1)
		f137_local1.emblemName:set(f137_arg2)
		CoD.CraftUtility.UploadAndParseBuffer(f137_arg0, f137_local0, f137_arg1)
	end
end
CoD.CraftUtility.Emblems.ClearEmblem = function(f138_arg0, f138_arg1)
	local f138_local0 = CoD.perController[f138_arg0].selectedEmblemTabStorageType
	local f138_local1 = Enum.CustomizationType[@"customization_type_emblem"]
	Engine[@"hash_C3742A77E5CD0BE"](f138_arg0, f138_arg1, f138_local0)
	if f138_arg1 >= 0 then
		local f138_local2 = CoD.CraftUtility.GetDDLRoot(f138_arg0, f138_local0, f138_arg1)
		if f138_local2 ~= nil then
			f138_local2.emblemName:set("")
			f138_local2.isUsed:set(0)
			f138_local2.sortIndex:set(CoD.CraftUtility.Gunsmith.EMPTY_ITEM_INDEX)
			f138_local2.readOnly:set(CoD.CraftUtility.DEFAULT_READ_ONLY_FLAG)
			Engine[@"hash_53DFB162BEAB9E19"](f138_local1)
		end
	end
end
CoD.CraftUtility.Emblems.GetEmptyEmblem = function()
	local f139_local0 = CoD.CraftUtility.Emblems.CachedEmblems
	for f139_local1 = 1, #f139_local0, 1 do
		local f139_local4 = f139_local0[f139_local1]
		if f139_local4.isUsed == 0 then
			f139_local4.sortIndex = CoD.CraftUtility.Emblems.GetHighestSortIndex() + 1
			return f139_local4
		end
	end
end
CoD.CraftUtility.Emblems.SaveDefaultAsNew = function(f140_arg0, f140_arg1)
	if f140_arg1 and f140_arg1.emblemIndex:get() >= 0 then
		local f140_local0 = f140_arg1.emblemIndex:get()
		local f140_local1 = CoD.CraftUtility.GetDDLRoot(f140_arg0, storageFileType, f140_local0)
		Engine[@"hash_C3742A77E5CD0BE"](f140_arg0, f140_local0, storageFileType)
		Engine.UploadEmblemData(f140_arg0, f140_local0)
		return newEmblem.emblemIndex
	else
	end
end
CoD.CraftUtility.Emblems.Copy = function(f141_arg0, f141_arg1, f141_arg2)
	local f141_local0 = Engine.GetModelValue(Engine.GetModel(f141_arg1, "emblemIndex"))
	local f141_local1 = Engine.GetModelValue(Engine.GetModel(f141_arg1, "sortIndex"))
	local f141_local2 = Engine.GetModelValue(Engine.GetModel(f141_arg1, "displayName"))
	local f141_local3 = Engine.GetModelValue(Engine.GetModel(f141_arg1, "xuid"))
	local f141_local4 = CoD.CraftUtility.Emblems.GetEmptyEmblem()
	if f141_local0 >= 0 and f141_local4 and f141_local4.emblemIndex >= 0 then
		local f141_local5 = CoD.CraftUtility.GetDDLRoot(f141_arg0, f141_arg2, f141_local4.emblemIndex)
		f141_local5.isUsed:set(1)
		f141_local5.sortIndex:set(f141_local4.sortIndex)
		f141_local5.emblemName:set(f141_local2)
		f141_local5.xuid:set(f141_local3)
		f141_local5.createTime:set(Engine.GetCurrentUTCTimeStr())
		Engine[@"hash_C3742A77E5CD0BE"](f141_arg0, f141_local4.emblemIndex, f141_arg2)
		Engine.UploadEmblemData(f141_arg0, f141_local4.emblemIndex)
		return f141_local4.emblemIndex
	else
	end
end
CoD.CraftUtility.Emblems.PublishEmblem = function(f142_arg0)
	local modelValue = Engine.GetModelValue(Engine.GetModel(CoD.perController[f142_arg0].selectedEmblemModel, "emblemIndex"))
	local f142_local1 = CoD.FileshareUtility.GetPublishName()
	local f142_local2 = CoD.FileshareUtility.GetPublishAllowDownload()
	if modelValue >= 0 then
		Engine.PublishEmblem(f142_arg0, "emblem", modelValue - 1, f142_local1, f142_local2)
	end
end
CoD.CraftUtility.Emblems.FileshareBreadcrumbPaths = {
	[Enum.StorageFileType[@"storage_emblems_loot"]] = "blackMarket",
}
CoD.CraftUtility.Emblems.GetEmblemBreadcrumbRoot = function(f143_arg0, f143_arg1, f143_arg2)
	local f143_local0 = CoD.CraftUtility.Emblems.FileshareBreadcrumbPaths[f143_arg2]
	if f143_local0 then
		local f143_local1 = Engine.StorageGetBuffer(f143_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
		if f143_local1 then
			return f143_local1.emblemBreadcrumbs[f143_local0].markedOld[f143_arg1]
		end
	end
	return nil
end
CoD.CraftUtility.Emblems.IsEmblemNew = function(f144_arg0, f144_arg1, f144_arg2)
	local f144_local0 = CoD.CraftUtility.Emblems.GetEmblemBreadcrumbRoot(f144_arg0, f144_arg1, f144_arg2)
	if f144_local0 then
		return f144_local0:get() == 0
	else
		return false
	end
end
CoD.CraftUtility.Emblems.IsAnyEmblemNew = function(f145_arg0)
	if IsLive() then
		for f145_local5, f145_local6 in pairs(CoD.CraftUtility.Emblems.FileshareBreadcrumbPaths) do
			CoD.CraftUtility.Emblems.ParseDDL(f145_arg0, f145_local5, nil)
			local f145_local7 = CoD.CraftUtility.Emblems.GetTotalUsedEmblems(f145_arg0, f145_local5, nil)
			for f145_local4 = 0, f145_local7 - 1, 1 do
				local f145_local3 = false
				if f145_local5 == Enum.StorageFileType[@"storage_emblems_loot"] then
					f145_local3 = CoD.CraftUtility.Emblems.CachedEmblems[f145_local4 + 1].hidden
				end
				if not f145_local3 and CoD.CraftUtility.Emblems.IsEmblemNew(f145_arg0, f145_local4, f145_local5) then
					return true
				end
			end
		end
	end
	return false
end
CoD.CraftUtility.Emblems.GetEmblemMaterialBreadcrumbRoot = function(f146_arg0, f146_arg1)
	local f146_local0 = Engine.StorageGetBuffer(f146_arg0, Enum.StorageFileType[@"hash_5D5A7695E03A7A90"])
	if f146_local0 then
		return f146_local0.emblemStats.materials[f146_arg1].markedOld
	else
	end
end
CoD.CraftUtility.Emblems.IsMaterialNew = function(f147_arg0, f147_arg1)
	local f147_local0 = CoD.CraftUtility.Emblems.GetEmblemMaterialBreadcrumbRoot(f147_arg0, f147_arg1)
	if f147_local0 then
		return f147_local0:get() == 0
	else
		return false
	end
end
CoD.CraftUtility.Emblems.GetDecalFrameWidget = function(f148_arg0)
	if CoD.CraftUtility.Groups.IsDecalGroupSelected(f148_arg0) then
		return "CoD.DecalGroupsListFrame"
	elseif f148_arg0 == CoD.CraftUtility.EmblemStickerSetCategory then
		return "CoD.DecalStickerSetFrame"
	elseif f148_arg0 == CoD.CraftUtility.EmblemDecalToolsCategory then
		return "CoD.DecalToolsFrame"
	else
		return "CoD.DecalListFrame"
	end
end
CoD.CraftUtility.Fileshare.DisplayWeaponWithPaintjob = function(f149_arg0, f149_arg1, f149_arg2, f149_arg3)
	if f149_arg1 == 0 then
		CoD.CraftUtility.Fileshare.ClearDisplay(f149_arg0)
		return
	else
		Engine.SetupFilesharePaintjobData(f149_arg0, f149_arg2)
		Engine.SendClientScriptNotify(f149_arg0, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f149_arg0), {
			base_weapon_slot = CoD.CraftUtility.GetLoadoutSlot(f149_arg0),
			weapon = Engine[@"hash_7B98952F69D937F9"](f149_arg1),
			attachments = "",
			camera = CoD.CACUtility.GetCameraNameForAttachments("", f149_arg3 == true),
			options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(0, 0, 1),
		})
	end
end
CoD.CraftUtility.Fileshare.GetWeaponsAttachmentsString = function(f150_arg0)
	local f150_local0 = ""
	for f150_local1 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
		local f150_local4 = f150_arg0.attachments[f150_local1 - 1]
		if f150_local4 ~= nil then
			f150_local0 = CoD.CraftUtility.Gunsmith.AddAttachmentToWeapon(f150_local0, f150_local4)
		end
	end
	return f150_local0
end
CoD.CraftUtility.Fileshare.ClearDisplay = function(f151_arg0)
	Engine.SendClientScriptNotify(f151_arg0, "CustomClass_remove" .. CoD.GetLocalClientAdjustedNum(f151_arg0), {})
end
CoD.CraftUtility.Fileshare.DisplayWeaponWithPaintjobUsingModel = function(f152_arg0, f152_arg1)
	local f152_local0 = CoD.CraftUtility.PaintshopView[CoD.perController[f152_arg0].viewIndex].customization_type
	local f152_local1 = Engine.GetModelValue(Engine.GetModel(f152_arg1, "paintjobSlot"))
	local f152_local2 = Engine[@"hash_7B98952F69D937F9"](Engine.GetModelValue(Engine.GetModel(f152_arg1, "weaponIndex")))
	local f152_local3 = CoD.CraftUtility.GetLoadoutSlot(f152_arg0)
	local f152_local4 = CoD.CACUtility.GetCameraNameForAttachments("")
	Engine.SetupPaintjobData(f152_arg0, f152_local1)
	Engine.SendClientScriptNotify(f152_arg0, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f152_arg0), {
		base_weapon_slot = f152_local3,
		weapon = f152_local2,
		attachments = attachments,
		camera = f152_local4,
		options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(0, 0, 1),
	})
end
CoD.CraftUtility.Fileshare.DisplayWeaponWithVariant = function(f153_arg0, f153_arg1, f153_arg2, f153_arg3, f153_arg4)
	if f153_arg1 then
		local f153_local0 = CoD.CraftUtility.GetLoadoutSlot(f153_arg0)
		local f153_local1 = Engine.GetItemRef(Engine.GetModelValue(Engine.GetModel(f153_arg1, "weaponIndex")))
		local f153_local2 = ""
		for f153_local3 = 1, CoD.CraftUtility.Gunsmith.MAX_ATTACHMENTS, 1 do
			f153_local2 = LUI.appendStringWithDelimiter(f153_local2, Engine.GetModelValue(Engine.GetModel(f153_arg1, "attachment" .. f153_local3)), "+")
		end
		local f153_local3 = CoD.CACUtility.GetCameraNameForAttachments(f153_local2, f153_arg2)
		if f153_arg4 == nil then
			f153_arg4 = Engine.GetModelValue(Engine.GetModel(f153_arg1, "camoIndex"))
		end
		if f153_arg3 == nil then
			f153_arg3 = Engine.GetModelValue(Engine.GetModel(f153_arg1, "paintjobSlot"))
		end
		Engine.SetupPaintjobData(f153_arg0, f153_arg3)
		Engine.SendClientScriptNotify(f153_arg0, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f153_arg0), {
			base_weapon_slot = f153_local0,
			weapon = f153_local1,
			attachments = f153_local2,
			camera = f153_local3,
			options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(f153_arg4, 0, 1),
		})
	end
end
CoD.CraftUtility.SetEmblemEditorProperties = function(f154_arg0, f154_arg1, f154_arg2)
	Engine.SetModelValue(Engine.CreateModel(DataSources.EmblemProperties.getModel(f154_arg0), f154_arg2), f154_arg1)
end
CoD.CraftUtility.GetEmblemEditorProperties = function(f155_arg0, f155_arg1)
	return Engine.GetModelValue(Engine.CreateModel(DataSources.EmblemProperties.getModel(f155_arg0), f155_arg1))
end
CoD.CraftUtility.GetSelectedEmblemColor = function(f156_arg0)
	local f156_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f156_arg0, "isGradientMode")
	local f156_local1 = CoD.CraftUtility.GetEmblemEditorProperties(f156_arg0, "colorNum")
	local f156_local2 = nil
	if f156_local1 ~= nil and f156_local0 ~= nil then
		if f156_local0 == 1 and f156_local1 == Enum.CustomizationColorNum[@"customization_color_1"] then
			return Engine.GetSelectedLayerColor1(f156_arg0)
		else
			return Engine.GetSelectedLayerColor(f156_arg0)
		end
	else
		return nil
	end
end
CoD.CraftUtility.SetEmblemNoColorDataModel = function(f157_arg0)
	local f157_local0 = Engine.GetSelectedLayerColor(f157_arg0)
	local f157_local1 = Engine.GetSelectedLayerColor1(f157_arg0)
	CoD.CraftUtility.SetEmblemEditorProperties(f157_arg0, 0, "isColor0NoColor")
	CoD.CraftUtility.SetEmblemEditorProperties(f157_arg0, 0, "isColor1NoColor")
	if f157_local0.alpha == 0 then
		CoD.CraftUtility.SetEmblemEditorProperties(f157_arg0, 1, "isColor0NoColor")
	end
	if f157_local1.alpha == 0 then
		CoD.CraftUtility.SetEmblemEditorProperties(f157_arg0, 1, "isColor1NoColor")
	end
end
CoD.CraftUtility.ClearEmblem = function()
	Engine[@"hash_53DFB162BEAB9E19"](Enum.CustomizationType[@"customization_type_emblem"])
end
CoD.CraftUtility.SetGradientType = function(f159_arg0, f159_arg1)
	Engine[@"hash_7EA0C7FF1B0ACC69"](f159_arg0, f159_arg1)
end
CoD.CraftUtility.IsCustomEmblemTabSelected = function(f160_arg0)
	local f160_local0 = DataSources.SelectedStorageFileType.getModel(f160_arg0)
	return f160_local0.storageFileType:get() == Enum.StorageFileType[@"storage_emblems"]
end
CoD.CraftUtility.SetSelectedStorageFileType = function(f161_arg0, f161_arg1)
	local f161_local0 = DataSources.SelectedStorageFileType.getModel(f161_arg0)
	f161_local0.storageFileType:set(f161_arg1)
end
CoD.CraftUtility.GetStorageFileTypeFromCustomiztionType = function(f162_arg0, f162_arg1)
	local f162_local0 = Enum.StorageFileType[@"storage_paintjobs"]
	if f162_arg1 == Enum.CustomizationType[@"customization_type_emblem"] then
		f162_local0 = Enum.StorageFileType[@"storage_emblems"]
	elseif f162_arg1 == Enum.CustomizationType[@"hash_1AB847C1A0E71617"] then
		f162_local0 = Enum.StorageFileType[@"hash_15DB8C62CF926911"]
	end
	return f162_local0
end
CoD.CraftUtility.GetSlotsUsedHeader = function(f163_arg0, f163_arg1)
	local f163_local0 = DataSources.SlotCustomization.getModel(f163_arg0)
	f163_local0 = f163_local0.type:get()
	if f163_local0 == Enum.CustomizationType[@"customization_type_paintshop_view_left"] then
		return @"hash_45C9C9F185BD647E"
	elseif f163_local0 == Enum.CustomizationType[@"customization_type_emblem"] then
		return @"hash_C0D618EFCE49A6D"
	elseif f163_local0 == Enum.CustomizationType[@"hash_1AB847C1A0E71617"] then
		return @"hash_3E3115328828AA0C"
	else
		return 0x0
	end
end
CoD.CraftUtility.SetSlotCustomizationType = function(f164_arg0, f164_arg1)
	local f164_local0 = DataSources.SlotCustomization.getModel(f164_arg0)
	f164_local0.type:set(f164_arg1)
end
CoD.CraftUtility.UpdateCraftSlots = function(f165_arg0)
	DataSources.CraftSlots.getModel(f165_arg0)
end
CoD.CraftUtility.IsOverLayer = function(f166_arg0, f166_arg1, f166_arg2)
	local f166_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f166_arg1, "selectedLayerIndex")
	if f166_local0 then
		local f166_local1 = f166_arg2:getModel(f166_arg1, "layerIndex")
		f166_local1 = f166_local1:get()
		local f166_local2 = f166_arg2:getModel(f166_arg1, "groupLayerCount")
		f166_local2 = f166_local2:get()
		if f166_local1 and f166_local2 then
			local f166_local3
			if f166_local1 > f166_local0 or f166_local0 > f166_local1 + f166_local2 - 1 then
				f166_local3 = false
			else
				f166_local3 = true
			end
			return f166_local3
		end
	end
	return false
end
CoD.CraftUtility.IsLowOnSlots = function(f167_arg0)
	local f167_local0 = DataSources.SlotCustomization.getModel(f167_arg0)
	local f167_local1 = CoD.CraftUtility.GetStorageFileTypeFromCustomiztionType(f167_arg0, f167_local0.type:get())
	return math.floor(CoD.CraftUtility.GetTotalAllowedSlotsByFileType(f167_arg0, f167_local1) * 0.95) <= CoD.CraftUtility.GetUsedSlotsByFileType(f167_arg0, f167_local1)
end
CoD.CraftUtility.AreSlotsFull = function(f168_arg0)
	local f168_local0 = DataSources.SlotCustomization.getModel(f168_arg0)
	return CraftSlotsFullByStorageType(f168_arg0, CoD.CraftUtility.GetStorageFileTypeFromCustomiztionType(f168_arg0, f168_local0.type:get()))
end
CoD.CraftUtility.IsCraftClassified = function(f169_arg0, f169_arg1)
	if not CoD.ModelUtility.IsSelfModelPathNil(f169_arg0, f169_arg1, "owned") and not CoD.ModelUtility.IsSelfModelPathNil(f169_arg0, f169_arg1, "available") then
		local f169_local0
		if not CoD.ModelUtility.IsSelfModelValueTrue(f169_arg0, f169_arg1, "owned") then
			f169_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(f169_arg0, f169_arg1, "available")
		else
			f169_local0 = false
		end
		return f169_local0
	else
		return false
	end
end
CoD.CraftUtility.IsEmblemEditorPropertyEqualTo = function(f170_arg0, f170_arg1, f170_arg2)
	return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f170_arg0, "EmblemProperties", f170_arg1, f170_arg2)
end
CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum = function(f171_arg0, f171_arg1, f171_arg2)
	return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f171_arg0, "EmblemProperties", f171_arg1, f171_arg2)
end
CoD.CraftUtility.Emblems_CanEnterEmblemEditor = function(f172_arg0, f172_arg1)
	if not CraftSlotsFullByStorageType(f172_arg1, Enum.StorageFileType[@"storage_emblems"]) then
		return true
	elseif not IsPreBuiltEmblemTab(f172_arg1) then
		return true
	else
		return false
	end
end
CoD.CraftUtility.Emblems_NewEmblem = function(f173_arg0)
	local f173_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f173_arg0, "EmblemEditing", "isUsed", 0)
	if not f173_local0 then
		f173_local0 = IsPreBuiltEmblemTab(f173_arg0)
	end
	return f173_local0
end
CoD.CraftUtility.Emblems_HasChanges = function(f174_arg0, f174_arg1)
	if CoD.CraftUtility.IsInEditor(f174_arg1) then
		if IsEmblemEditor(f174_arg1) then
			local f174_local0 = CoD.perController[f174_arg1].selectedEmblemModel
			if f174_local0 and f174_local0.emblemIndex then
				return Engine[@"hash_4E3832EEF7179004"](f174_arg1, f174_local0.emblemIndex:get(), CoD.perController[f174_arg1].selectedEmblemTabStorageType, Enum.CustomizationType[@"customization_type_emblem"])
			end
		end
		local f174_local0 = CoD.perController[f174_arg1].selectedPaintjobModel
		if f174_local0 and f174_local0.paintjobSlot then
			return Engine[@"hash_3A64BA272597771"](f174_arg1, f174_local0.paintjobSlot:get())
		end
	end
	return false
end
CoD.CraftUtility.EmblemEditor_IsEditor = function(f175_arg0, f175_arg1)
	return CoD.CraftUtility.Emblems.IsEditor(f175_arg1)
end
CoD.CraftUtility.EmblemEditor_IsEditingClanEmblem = function(f176_arg0, f176_arg1)
	return CoD.CraftUtility.Emblems.IsClan(f176_arg1)
end
CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste = function(f177_arg0, f177_arg1)
	local f177_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f177_arg1, "layersUsed")
	local f177_local1 = Engine.GetUsedLayerCount(f177_arg1, Enum.CustomizationType[@"hash_52E26F9B152C3962"], CoD.perController[f177_arg1].totalLayers)
	local f177_local2 = DataSources.CraftClipboard.getModel(f177_arg1)
	f177_local2.layerCount:set(f177_local1)
	if f177_local0 + f177_local1 <= CoD.perController[f177_arg1].totalLayers then
		return true
	else
		return false
	end
end
CoD.CraftUtility.EmblemSelect_IsStickerTab = function(f178_arg0, f178_arg1)
	return CoD.CraftUtility.Emblems.IsStickerFileType(CoD.perController[f178_arg1].selectedEmblemTabStorageType)
end
CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining = function(f179_arg0)
	return CoD.CraftUtility.Groups.GetTotalUsed(f179_arg0) < CoD.CraftUtility.Groups.GetTotalAllowed(f179_arg0)
end
CoD.CraftUtility.EmblemEditor_ShowGroupSlotsFull = function(f180_arg0, f180_arg1, f180_arg2)
	if not CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(f180_arg1) then
		return CoD.CraftUtility.Emblem_IsActiveLayerGrouped(f180_arg2, f180_arg1)
	else
		return false
	end
end
CoD.CraftUtility.Emblems_IsDefaultEmblemEquipped = function(f181_arg0, f181_arg1, f181_arg2)
	local f181_local0 = f181_arg1:getModel(f181_arg2, "emblemIndex")
	local f181_local1 = f181_arg1:getModel(f181_arg2, "storageFileType")
	if f181_local0 and f181_local1 then
		if not IsLive() or IsUserContentRestricted(f181_arg2) then
			local f181_local2 = Engine.GetProfileVarInt(f181_arg2, "default_emblem_index")
			if f181_local2 ~= CoD.CraftUtility.Emblems.INVALID_DEFAULT_EMBLEMINDEX and f181_local2 == f181_local0:get() then
				return true
			end
		end
		local f181_local2, f181_local3 = Engine[@"hash_3A2D715B735AA92"](f181_arg2)
		if f181_local0:get() == f181_local3 and f181_local2 == f181_local1:get() then
			return true
		end
	end
	return false
end
CoD.CraftUtility.ValidateEquippedUGC = function(f182_arg0)
	Engine[@"emblemgetprofile"](f182_arg0)
	ValidateEmblemBackground(f182_arg0, Engine.GetEmblemBackgroundId())
	CoD.CraftUtility.ValidateEquippedEmblem(f182_arg0)
end
CoD.CraftUtility.ValidateEquippedEmblem = function(f183_arg0)
	if IsLive() then
		local f183_local0, f183_local1 = Engine[@"hash_3A2D715B735AA92"](f183_arg0)
		if f183_local0 == Enum.StorageFileType[@"hash_36A0A3D1062F156F"] then
			if Engine[@"hash_2D1419DCE072A0B1"](f183_local1) and Engine[@"hash_52EE0A51483D8E7C"](f183_arg0, f183_local1) then
				Engine[@"emblemsetprofile"](f183_arg0, Enum.StorageFileType[@"storage_default_emblems"], 0)
			end
		elseif f183_local0 == Enum.StorageFileType[@"storage_emblems_loot"] then
			local f183_local2 = CoD.CraftUtility.GetDDLRoot(f183_arg0, f183_local0, f183_local1)
			if f183_local2 and f183_local2.emblemName then
				local f183_local3 = f183_local2.emblemName:get()
				if f183_local3 and f183_local3 ~= "" and not CoD.CraftUtility.IsEmblemUnlocked(f183_arg0, Engine[@"converttoxhash"](f183_local2.emblemName:get()), f183_local0) then
					Engine[@"emblemsetprofile"](f183_arg0, Enum.StorageFileType[@"storage_default_emblems"], 0)
				end
			end
		end
	end
end
CoD.CraftUtility.Emblem_IsOccupied = function(f184_arg0, f184_arg1)
	local f184_local0 = f184_arg0:getModel()
	if f184_local0 then
		local f184_local1 = f184_local0.emblemIndex
		local f184_local2 = f184_local0.storageFileType
		if f184_local1 and f184_local2 and CoD.CraftUtility.Emblems.IsEmblemIndexOccupied(f184_local1:get(), f184_local2:get()) then
			return true
		end
	end
	return false
end
CoD.CraftUtility.Emblems_IsEnabled = function(f185_arg0, f185_arg1)
	if IsPlayerAGuest(f185_arg1) then
		return false
	else
		return IsLive()
	end
end
CoD.CraftUtility.Paintjobs_IsEnabled = function(f186_arg0, f186_arg1)
	if IsPlayerAGuest(f186_arg1) then
		return false
	else
		return IsLive()
	end
end
CoD.CraftUtility.CommunityOptionsEnabled = function()
	return false
end
CoD.CraftUtility.Emblems_IsActiveLayerLinked = function(f188_arg0, f188_arg1)
	local f188_local0 = CoD.CraftUtility.GetActiveLayer(f188_arg0, f188_arg1)
	if f188_local0 then
		local f188_local1 = f188_local0:getModel(f188_arg1, "isLinked")
		if f188_local1 then
			return Engine.GetModelValue(f188_local1)
		end
	end
	return false
end
CoD.CraftUtility.Emblem_IsActiveLayerGrouped = function(f189_arg0, f189_arg1)
	local f189_local0 = CoD.CraftUtility.GetActiveLayer(f189_arg0, f189_arg1)
	if f189_local0 then
		local f189_local1 = f189_local0:getModel(f189_arg1, "isGrouped")
		if f189_local1 then
			return Engine.GetModelValue(f189_local1)
		end
	end
	return false
end
CoD.CraftUtility.Emblem_IsActiveLayerASticker = function(f190_arg0, f190_arg1)
	local f190_local0 = CoD.CraftUtility.GetActiveLayer(f190_arg0, f190_arg1)
	if f190_local0 then
		local f190_local1 = f190_local0:getModel(f190_arg1, "iconID")
		if f190_local1 then
			return Engine[@"hash_5628E621034FF132"](f190_local1:get())
		end
	end
	return false
end
CoD.CraftUtility.Emblems_IsLayerASticker = function(f191_arg0, f191_arg1)
	if f191_arg0 then
		local f191_local0 = f191_arg0:getModel(f191_arg1, "iconID")
		if f191_local0 then
			return Engine[@"hash_5628E621034FF132"](f191_local0:get())
		end
	end
	return false
end
CoD.CraftUtility.Emblems_IsLayerLinked = function(f192_arg0, f192_arg1)
	local f192_local0 = f192_arg0:getModel(f192_arg1, "isLinked")
	if f192_local0 then
		return Engine.GetModelValue(f192_local0)
	else
		return false
	end
end
CoD.CraftUtility.Emblem_IsLayerGrouped = function(f193_arg0, f193_arg1)
	local f193_local0 = f193_arg0:getModel(f193_arg1, "isGrouped")
	if f193_local0 then
		return Engine.GetModelValue(f193_local0)
	else
		return false
	end
end
CoD.CraftUtility.Emblems_IsLayerGroupedOrLinked = function(f194_arg0, f194_arg1)
	local f194_local0 = CoD.CraftUtility.Emblems_IsLayerLinked(f194_arg0, f194_arg1)
	if not f194_local0 then
		f194_local0 = CoD.CraftUtility.Emblem_IsLayerGrouped(f194_arg0, f194_arg1)
	end
	return f194_local0
end
CoD.CraftUtility.Emblem_IsLayerGroupedByLayerIndex = function(f195_arg0, f195_arg1)
	local f195_local0 = CoD.GetCustomization(f195_arg1, "type")
	if CoD.perController[f195_arg1].selectedLayerIndex ~= nil then
		local f195_local1 = Engine.GetSelectedLayerData(f195_arg1, CoD.perController[f195_arg1].selectedLayerIndex, f195_local0)
		return f195_local1.isGrouped
	else
		return false
	end
end
CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker = function(f196_arg0, f196_arg1)
	if CoD.CraftUtility.Emblem_IsLayerGrouped(f196_arg0, f196_arg1) then
		local f196_local0 = f196_arg0:getModel(f196_arg1, "layerIndex")
		if f196_local0 then
			local f196_local1 = Engine.GetSelectedLayerData(f196_arg1, f196_local0:get(), CoD.GetCustomization(f196_arg1, "type"))
			return f196_local1.containsSticker
		end
	end
	return false
end
CoD.CraftUtility.Emblem_IsActiveLayerGroupedWithSticker = function(f197_arg0, f197_arg1)
	local f197_local0 = CoD.CraftUtility.GetActiveLayer(f197_arg0, f197_arg1)
	if f197_local0 then
		local f197_local1 = f197_local0:getModel(f197_arg1, "layerIndex")
		if f197_local1 then
			local f197_local2 = Engine.GetSelectedLayerData(f197_arg1, f197_local1:get(), CoD.GetCustomization(f197_arg1, "type"))
			return f197_local2.containsSticker
		end
	end
	return false
end
CoD.CraftUtility.IsEmblemEmpty = function(f198_arg0)
	return Engine.IsEmblemEmpty(f198_arg0, CoD.GetCustomization(f198_arg0, "type"), CoD.perController[f198_arg0].totalLayers)
end
CoD.CraftUtility.IsClanEmblemEmpty = function(f199_arg0)
	return Engine.IsEmblemEmpty(f199_arg0, Enum.CustomizationType[@"customization_type_emblem"], Enum.CustomizationTypeLayerCount[@"customization_type_emblem_max_layers"])
end
CoD.CraftUtility.Emblem_IsAnyLayerEmpty = function(f200_arg0)
	local f200_local0 = CoD.perController[f200_arg0].totalLayers
	if f200_local0 == Engine.GetUsedLayerCount(f200_arg0, CoD.GetCustomization(f200_arg0, "type"), f200_local0) then
		return false
	else
		return true
	end
end
CoD.CraftUtility.IsPaintjobAllSidesEmpty = function(f201_arg0)
	local f201_local0 = Enum.CustomizationTypeLayerCount[@"customization_type_paintshop_max_layers"]
	return Engine.IsEmblemEmpty(f201_arg0, Enum.CustomizationType[@"customization_type_paintshop_view_top"], f201_local0) and Engine.IsEmblemEmpty(f201_arg0, Enum.CustomizationType[@"customization_type_paintshop_view_left"], f201_local0) and Engine.IsEmblemEmpty(f201_arg0, Enum.CustomizationType[@"customization_type_paintshop_view_right"], f201_local0)
end
CoD.CraftUtility.GetActiveLayer = function(f202_arg0, f202_arg1)
	if IsGamepad(f202_arg1) and f202_arg0.layerCarousel ~= nil then
		return f202_arg0.layerCarousel.activeWidget
	elseif f202_arg0.layerGrid ~= nil then
		return f202_arg0.layerGrid.activeWidget
	else
		return nil
	end
end
CoD.CraftUtility.IsActiveLayerEmpty = function(f203_arg0, f203_arg1)
	local f203_local0 = CoD.CraftUtility.GetActiveLayer(f203_arg0, f203_arg1)
	if f203_local0 then
		local f203_local1 = f203_local0:getModel(f203_arg1, "layerIndex")
		if not f203_local1 then
			return true
		elseif Engine.GetSelectedLayerIconID(f203_arg1, Engine.GetModelValue(f203_local1)) == CoD.CraftUtility.EMBLEM_INVALID_ID then
			return true
		else
			return false
		end
	else
		return true
	end
end
CoD.CraftUtility.IsLayerEmpty = function(f204_arg0, f204_arg1, f204_arg2)
	if f204_arg1 then
		local f204_local0 = f204_arg1:getModel(f204_arg2, "layerIndex")
		if not f204_local0 then
			return true
		elseif Engine.GetSelectedLayerIconID(f204_arg2, Engine.GetModelValue(f204_local0)) == CoD.CraftUtility.EMBLEM_INVALID_ID then
			return true
		else
			return false
		end
	else
		return true
	end
end
CoD.CraftUtility.IsEditMode = function(f205_arg0)
	return CoD.CraftUtility.GetEmblemEditorProperties(f205_arg0, "editorMode") == Enum.CustomizationEditorMode[@"customization_editor_mode_edit"]
end
CoD.CraftUtility.IsBrowseMode = function(f206_arg0)
	return CoD.CraftUtility.GetEmblemEditorProperties(f206_arg0, "editorMode") == Enum.CustomizationEditorMode[@"customization_editor_mode_browse"]
end
CoD.CraftUtility.IsInEditor = function(f207_arg0)
	return CoD.CraftUtility.GetEmblemEditorProperties(f207_arg0, "editorMode") ~= Enum.CustomizationEditorMode[@"customization_editor_mode_none"]
end
CoD.CraftUtility.IsClipboardEmpty = function(f208_arg0)
	return CoD.CraftUtility.GetEmblemEditorProperties(f208_arg0, "isClipboardEmpty") == CoD.CraftUtility.EMBLEM_CLIPBOARDSTATE.EMPTY
end
CoD.CraftUtility.IsClipboardEmblemGrouped = function(f209_arg0)
	return Engine.IsClipboardEmblemGrouped()
end
CoD.CraftUtility.Emblem_HideClipboard = function(f210_arg0, f210_arg1)
	if IsMouseOrKeyboard(f210_arg1) and not CoD.CraftUtility.IsClipboardEmpty(f210_arg1) then
		return false
	elseif CoD.CraftUtility.GetEmblemEditorProperties(f210_arg1, "editorMode") == Enum.CustomizationEditorMode[@"customization_editor_mode_edit"] then
		return true
	else
		return false
	end
end
CoD.CraftUtility.Emblem_CanPastFromClipboard = function(f211_arg0, f211_arg1)
	local f211_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f211_arg1, "editorMode")
	local f211_local1 = IsGroupSlotAvailable(f211_arg1)
	local f211_local2 = CoD.CraftUtility.IsClipboardEmblemGrouped(f211_arg1)
	if CoD.CraftUtility.IsClipboardEmpty(f211_arg1) then
		return false
	elseif CoD.isPC then
		if not f211_local2 then
			return true
		elseif f211_local2 and f211_local1 then
			return true
		end
	end
	if f211_local0 == Enum.CustomizationEditorMode[@"customization_editor_mode_browse"] then
		if not f211_local2 then
			return true
		elseif f211_local2 and f211_local1 then
			return true
		end
	end
	return false
end
CoD.CraftUtility.IsSelectedColorEmpty = function(f212_arg0, f212_arg1)
	local f212_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f212_arg1, "colorNum")
	local f212_local1 = CoD.CraftUtility.GetEmblemEditorProperties(f212_arg1, "isColor0NoColor")
	local f212_local2 = CoD.CraftUtility.GetEmblemEditorProperties(f212_arg1, "isColor1NoColor")
	if f212_local0 == Enum.CustomizationColorNum[@"customization_color_0"] and f212_local1 == 1 then
		return true
	elseif f212_local0 == Enum.CustomizationColorNum[@"customization_color_1"] and f212_local2 == 1 then
		return true
	else
		return false
	end
end
CoD.CraftUtility.Emblems_IsIconNew = function(f213_arg0, f213_arg1)
	local f213_local0 = CoD.SafeGetModelValue(f213_arg0:getModel(), "iconID")
	local f213_local1 = CoD.CraftUtility.GetDecalCategoryTypeByID(CoD.perController[f213_arg1].selectedDecalCategory)
	if f213_local0 and f213_local1 and f213_local1 == "BLACKMARKET" then
		return Engine.IsEmblemIconNew(f213_arg1, f213_local0)
	else
		return false
	end
end
CoD.CraftUtility.Emblems_IsAnyEmblemNew = function(f214_arg0)
	return CoD.CraftUtility.Emblems.IsAnyEmblemNew(f214_arg0)
end
CoD.CraftUtility.Emblems_IsEmblemNew = function(f215_arg0, f215_arg1)
	local f215_local0 = CoD.SafeGetModelValue(f215_arg0:getModel(), "emblemIndex")
	local f215_local1 = CoD.SafeGetModelValue(f215_arg0:getModel(), "storageFileType")
	if f215_local0 and f215_local1 then
		return CoD.CraftUtility.Emblems.IsEmblemNew(f215_arg1, f215_local0, f215_local1)
	else
		return false
	end
end
CoD.CraftUtility.Emblems_IsMaterialNew = function(f216_arg0, f216_arg1)
	local f216_local0 = CoD.SafeGetModelValue(f216_arg0:getModel(), "materialID")
	local f216_local1 = CoD.CraftUtility.GetMaterialCategoryTypeByID(CoD.perController[f216_arg1].selectedMaterialCategory)
	if f216_local0 and f216_local1 and f216_local1 ~= "general" then
		return CoD.CraftUtility.Emblems.IsMaterialNew(f216_arg1, f216_local0)
	else
		return false
	end
end
CoD.CraftUtility.EmblemChooseIcon_IsCustomDecalCategorySelected = function(f217_arg0, f217_arg1)
	return CoD.perController[f217_arg1].selectedDecalCategory == CoD.CraftUtility.EmblemDecalGroupCategory
end
CoD.CraftUtility.EmblemChooseIcon_IsDecalGroupCategorySelected = function(f218_arg0, f218_arg1)
	return CoD.CraftUtility.Groups.IsDecalGroupSelected(CoD.perController[f218_arg1].selectedDecalCategory)
end
CoD.CraftUtility.EmblemChooseIcon_IsDecalTypeChanged = function(f219_arg0, f219_arg1, f219_arg2)
	return CoD.perController[f219_arg2].selectedDecalCategory ~= f219_arg1.category
end
CoD.CraftUtility.EmblemChooseIcon_CanFitDecalGroup = function(f220_arg0, f220_arg1, f220_arg2)
	local f220_local0 = f220_arg1:getModel(f220_arg2, "layerCount")
	return CoD.CraftUtility.GetEmblemEditorProperties(f220_arg2, "layersAvailable") - f220_local0:get() >= 0
end
CoD.CraftUtility.EmblemChooseIcon_CanFitSelectedDecalGroup = function(f221_arg0, f221_arg1)
	if CoD.CraftUtility.EmblemChooseIcon_IsDecalGroupCategorySelected(f221_arg0, f221_arg1) then
		return CoD.CraftUtility.GetEmblemEditorProperties(f221_arg1, "layersAvailable") - Engine.GetUsedLayerCount(f221_arg1, Enum.CustomizationType[@"hash_1AB847C1A0E71617"], Enum.CustomizationTypeLayerCount[@"customization_type_emblem_max_layers"]) >= 0
	else
		return true
	end
end
CoD.CraftUtility.EmblemChooseIcon_IsGroupSlotAvailable = function(f222_arg0, f222_arg1)
	if CoD.CraftUtility.EmblemChooseIcon_IsDecalGroupCategorySelected(f222_arg0, f222_arg1) then
		return IsGroupSlotAvailable(f222_arg1)
	else
		return true
	end
end
CoD.CraftUtility.EmblemChooseIcon_IsDecalGroupFocused = function(f223_arg0, f223_arg1)
	return CoD.perController[f223_arg1].selectedDecalGroupModel ~= nil
end
CoD.CraftUtility.Paintshop_ShowPreviewOfRecentlyEdited = function(f224_arg0)
	local f224_local0 = CoD.perController[f224_arg0].selectedPaintjobModel
	local f224_local1 = 0
	if f224_local0 then
		f224_local1 = Engine.GetModelValue(Engine.GetModel(f224_local0, "paintjobSlot"))
	end
	CoD.perController[f224_arg0].viewIndex = 1
	CoD.CraftUtility.Gunsmith.DisplayWeaponWithPaintjob(f224_arg0, f224_local1)
end
CoD.CraftUtility.Paintshop_ChangeViewRightBumper = function(f225_arg0, f225_arg1, f225_arg2)
	local f225_local0 = CoD.CraftUtility.Paintjobs.GetNextViewIndex(f225_arg2)
	CoD.perController[f225_arg2].viewIndex = f225_local0
	local f225_local1 = CoD.CraftUtility.PaintshopView[f225_local0].view_name
	local f225_local2 = CoD.CraftUtility.PaintshopView[f225_local0].customization_type
	local f225_local3 = CoD.CraftUtility.PaintshopView[f225_local0].view_string_ref
	CoD.SetCustomization(f225_arg2, f225_local2, "type")
	CoD.SetCustomization(f225_arg2, f225_local3, "view_string_ref")
	Engine.SetupEmblemEditBuffer(f225_arg2, f225_local2, CoD.GetCustomization(f225_arg2, "weapon_index"))
	SetFocusToSelf(f225_arg0.layerCarousel.activeWidget, f225_arg2)
	f225_arg0.DrawEmblem:setupEmblem(CoD.CraftUtility.PaintshopView[f225_local0].customization_type)
	CoD.CraftUtility.DisplayWeaponInPaintshop(f225_arg2, f225_local1)
	f225_arg0.layerCarousel:updateDataSource()
	if CoD.isPC then
		f225_arg0.DrawEmblem:setupEmblem(CoD.CraftUtility.PaintshopView[f225_local0].customization_type)
		if f225_arg0.layerGrid then
			f225_arg0.layerGrid:updateDataSource(true)
		end
	end
end
CoD.CraftUtility.Paintshop_ChangeViewLeftBumper = function(f226_arg0, f226_arg1, f226_arg2)
	local f226_local0 = CoD.CraftUtility.Paintjobs.GetPrevViewIndex(f226_arg2)
	CoD.perController[f226_arg2].viewIndex = f226_local0
	local f226_local1 = CoD.CraftUtility.PaintshopView[f226_local0].view_name
	local f226_local2 = CoD.CraftUtility.PaintshopView[f226_local0].customization_type
	local f226_local3 = CoD.CraftUtility.PaintshopView[f226_local0].view_string_ref
	CoD.SetCustomization(f226_arg2, f226_local2, "type")
	CoD.SetCustomization(f226_arg2, f226_local3, "view_string_ref")
	Engine.SetupEmblemEditBuffer(f226_arg2, f226_local2, CoD.GetCustomization(f226_arg2, "weapon_index"))
	SetFocusToSelf(f226_arg0.layerCarousel.activeWidget, f226_arg2)
	CoD.CraftUtility.DisplayWeaponInPaintshop(f226_arg2, f226_local1)
	f226_arg0.layerCarousel:updateDataSource()
	if CoD.isPC then
		f226_arg0.DrawEmblem:setupEmblem(CoD.CraftUtility.PaintshopView[f226_local0].customization_type)
		if f226_arg0.layerGrid then
			f226_arg0.layerGrid:updateDataSource(true)
		end
	end
end
CoD.CraftUtility.EmblemEditor_RevertLayerChanges = function(f227_arg0, f227_arg1)
	Engine[@"hash_778F11CA5CD0F84B"]()
end
CoD.CraftUtility.EmblemEditor_SaveLayer = function(f228_arg0, f228_arg1)
	Engine[@"hash_7B307CAD44681700"]()
end
CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode = function(f229_arg0, f229_arg1)
	CoD.CraftUtility.EmblemEditor_StopEdits(f229_arg1)
	return GoBack(f229_arg0, f229_arg1)
end
CoD.CraftUtility.EmblemEditor_StopEdits = function(f230_arg0)
	Engine[@"emblemendedit"](f230_arg0)
	if IsPaintshop(f230_arg0) then
		CoD.SetCustomization(f230_arg0, Enum.CustomizationType[@"customization_type_paintshop_view_left"], "type")
		ForceNotifyModel(f230_arg0, "Paintshop.UpdateDataSource")
	else
		CoD.SetCustomization(f230_arg0, Enum.CustomizationType[@"customization_type_emblem"], "type")
		ForceNotifyModel(f230_arg0, "Emblem.UpdateDataSource")
	end
	CoD.perController[f230_arg0].selectEmblemGroupIndex = nil
	CoD.perController[f230_arg0].selectedLayerIndex = nil
	CoD.perController[f230_arg0].selectedLayerIconID = nil
	CoD.perController[f230_arg0].selectedLayerMaterialID = nil
	CoD.CraftUtility.SetEmblemEditorProperties(f230_arg0, Enum.CustomizationEditorMode[@"customization_editor_mode_none"], "editorMode")
	CoD.CraftUtility.SetEmblemEditorProperties(f230_arg0, Enum.CustomizationColorMode[@"customization_color_mode_none"], "colorMode")
	CoD.CraftUtility.SetEmblemEditorProperties(f230_arg0, CoD.CraftUtility.EMBLEM_CLIPBOARDSTATE.EMPTY, "isClipboardEmpty")
	Engine.CommitProfileChanges(f230_arg0)
	if CoD.perController[f230_arg0].selectedPaintjobModel then
		CoD.CraftUtility.Paintjobs.InvalidateRender(f230_arg0, CoD.perController[f230_arg0].selectedPaintjobModel)
	end
	Engine[@"emblemsetgridsize"](CoD.GetCustomization(f230_arg0, "type"), 0)
end
CoD.CraftUtility.InvalidateSelectedDecalCategory = function(f231_arg0)
	CoD.perController[f231_arg0].selectedDecalCategory = CoD.CraftUtility.EmblemCategoryInvalid
end
CoD.CraftUtility.FindTabIDForCategory = function(f232_arg0, f232_arg1)
	for f232_local3, f232_local4 in ipairs(CoD.CraftUtility.EMBLEM_DECALTABS) do
		if f232_local4.category == f232_arg1 then
			return f232_local3 + 1
		end
	end
end
CoD.CraftUtility.GetSelectedDecalCategory = function(f233_arg0)
	local f233_local0 = CoD.perController[f233_arg0].selectedLayerIconID
	if CoD.CraftUtility.Emblem_IsLayerGroupedByLayerIndex(nil, f233_arg0) then
		return CoD.CraftUtility.EmblemDecalGroupCategory
	elseif f233_local0 and f233_local0 ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
		for f233_local9, f233_local10 in ipairs(CoD.CraftUtility.EMBLEM_DECALTABS) do
			if f233_local10.category ~= CoD.CraftUtility.EmblemDecalGroupCategory then
				if Engine.GetEmblemIconIndexInCategory(f233_arg0, f233_local10.category, f233_local0) ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
					return f233_local10.category
				elseif f233_local10.category == CoD.CraftUtility.EmblemStickerCategory and Engine.GetEmblemIconIndexInCategory(f233_arg0, CoD.CraftUtility.EmblemDefaultStickerCategory, f233_local0) ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
					return f233_local10.category
				elseif f233_local10.category == CoD.CraftUtility.EmblemDecalToolsCategory then
					for f233_local7, f233_local8 in ipairs(CoD.CraftUtility.DECAL_TOOLBUTTONS) do
						if Engine.GetEmblemIconIndexInCategory(f233_arg0, f233_local8.category, f233_local0) ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
							return f233_local10.category
						end
					end
				end
			end
		end
	end
	return CoD.CraftUtility.EMBLEM_DECALTABS[1].category
end
CoD.CraftUtility.EmblemEditor_SetEditMode = function(f234_arg0)
	CoD.CraftUtility.SetEmblemEditorProperties(f234_arg0, Enum.CustomizationEditorMode[@"customization_editor_mode_edit"], "editorMode")
end
CoD.CraftUtility.EmblemEditor_GainDefaultFocus = function(f235_arg0, f235_arg1, f235_arg2)
	f235_arg0.layerCarousel:processEvent({
		name = "gain_focus",
		controller = f235_arg1,
		menu = f235_arg2,
		moveCursor = true,
	})
end
CoD.CraftUtility.EmblemEditor_LayerGainFocus = function(f236_arg0, f236_arg1, f236_arg2, f236_arg3)
	local f236_local0 = f236_arg2:getModel(f236_arg3, "layerIndex")
	local f236_local1 = f236_arg2:getModel(f236_arg3, "layerNumberString")
	local f236_local2 = Engine.GetModelValue(f236_local0)
	CoD.Menu.SetButtonLabel(f236_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], "platform/emblem_edit_done")
	local f236_local3 = Engine.GetSelectedLayerIconID(f236_arg3, f236_local2)
	CoD.perController[f236_arg3].selectedLayerIndex = f236_local2
	CoD.perController[f236_arg3].selectedLayerIconID = f236_local3
	CoD.perController[f236_arg3].selectedLayerMaterialID = Engine.GetSelectedLayerMaterialID(f236_arg3, f236_local2)
	CoD.CraftUtility.EmblemEditor_SetLayerAndGroupCount(f236_arg3)
	local f236_local4 = CoD.GetCustomization(f236_arg3, "type")
	Engine[@"hash_7BB788AA2AFACFF4"](f236_local2, f236_local4)
	if CoD.IsLayerEmpty(f236_arg3, CoD.perController[f236_arg3].selectedLayerIndex) == true then
		CoD.Menu.SetButtonLabel(f236_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "menu/emblem_choose_decal")
	else
		CoD.Menu.SetButtonLabel(f236_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "menu/emblem_edit_layer")
	end
	local f236_local5 = Engine.GetLinkedLayerCount(f236_arg3, f236_local4)
	CoD.CraftUtility.SetEmblemEditorProperties(f236_arg3, f236_local2, "selectedLayerIndex")
	CoD.CraftUtility.SetEmblemEditorProperties(f236_arg3, f236_local5, "linkedLayerCount")
	CoD.CraftUtility.SetEmblemEditorProperties(f236_arg3, f236_local3, "selectedDecalID")
	Engine.ForceNotifyModelSubscriptions(f236_local1)
end
CoD.CraftUtility.EmblemEditor_SetLayerAndGroupCount = function(f237_arg0)
	local f237_local0 = CoD.GetCustomization(f237_arg0, "type")
	local f237_local1 = CoD.perController[f237_arg0].totalLayers
	local f237_local2 = Engine.GetUsedLayerCount(f237_arg0, f237_local0, f237_local1)
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, Engine[@"hash_4F9F1239CFD921FE"]("menu/emblem_layers_used_fraction", f237_local2, f237_local1), "layersUsedFraction")
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, f237_local2, "layersUsed")
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, f237_local1 - f237_local2, "layersAvailable")
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, f237_local1, "totalLayers")
	local f237_local3 = CoD.perController[f237_arg0].totalGroups
	local f237_local4 = Engine.GetUsedGroupCount(f237_arg0, f237_local0)
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, Engine[@"hash_4F9F1239CFD921FE"]("menu/emblem_layers_used_fraction", f237_local4, f237_local3), "groupsUsedFraction")
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, f237_local4, "groupsUsed")
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, f237_local3 - f237_local4, "groupsAvailable")
	CoD.CraftUtility.SetEmblemEditorProperties(f237_arg0, f237_local3, "totalGroups")
end
CoD.CraftUtility.EmblemEditor_UpdateLayerAndGroupCountWithReplace = function(f238_arg0, f238_arg1)
	local f238_local0 = CoD.GetCustomization(f238_arg1, "type")
	local f238_local1 = CoD.perController[f238_arg1].totalLayers
	local f238_local2 = Engine.GetUsedLayerCount(f238_arg1, f238_local0, f238_local1)
	local f238_local3 = Engine[@"hash_6F1628BA0A55D9DE"](f238_local0, CoD.perController[f238_arg1].selectedLayerIndex)
	CoD.CraftUtility.SetEmblemEditorProperties(f238_arg1, f238_local2 - f238_local3, "layersUsed")
	CoD.CraftUtility.SetEmblemEditorProperties(f238_arg1, f238_local1 - f238_local2 + f238_local3, "layersAvailable")
	if f238_local3 > 1 then
		local f238_local4 = CoD.perController[f238_arg1].totalGroups
		local f238_local5 = Engine.GetUsedGroupCount(f238_arg1, f238_local0)
		CoD.CraftUtility.SetEmblemEditorProperties(f238_arg1, f238_local5 - 1, "groupsUsed")
		CoD.CraftUtility.SetEmblemEditorProperties(f238_arg1, f238_local4 - f238_local5 + 1, "groupsAvailable")
		CoD.CraftUtility.SetEmblemEditorProperties(f238_arg1, f238_local4, "totalGroups")
	end
end
CoD.CraftUtility.EmblemEditor_InsertDecalPressed = function(f239_arg0, f239_arg1, f239_arg2)
	local f239_local0 = CoD.GetCustomization(f239_arg2, "type")
	Engine[@"emblemcopylayer"](CoD.perController[f239_arg2].selectedLayerIndex)
	Engine[@"embleminsertlayer"](CoD.perController[f239_arg2].selectedLayerIndex, f239_local0)
	Engine[@"emblemclearlayerbyindex"](CoD.perController[f239_arg2].selectedLayerIndex, f239_local0)
	CoD.CraftUtility.SetEmblemEditorProperties(f239_arg2, CoD.CraftUtility.EMBLEM_ADDDECAL.INSERT, "addDecalMode")
end
CoD.CraftUtility.EmblemEditor_SetEditLayerTitle = function(f240_arg0, f240_arg1)
	if IsPaintshop(f240_arg1) then
		f240_arg0.PaintshopFrame.CommonHeader.subtitle:setText(Engine.Localize(CoD.CraftUtility.PaintshopView[CoD.perController[f240_arg1].viewIndex].edit_side_ref))
	else
		f240_arg0.EmblemEditorFrame.CommonHeader.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/emblem_edit_layer_title"))
	end
end
CoD.CraftUtility.EmblemEditor_EditSelectedLayer = function(f241_arg0, f241_arg1, f241_arg2)
	local f241_local0 = CoD.perController[f241_arg2].selectedLayerIndex
	Engine[@"emblemcopylayer"](f241_local0)
	CoD.CraftUtility.SetEmblemEditorProperties(f241_arg2, CoD.CraftUtility.EMBLEM_CLIPBOARDSTATE.EMPTY, "isClipboardEmpty")
	CoD.CraftUtility.EmblemEditor_SetEditLayerTitle(f241_arg0, f241_arg2)
	if IsGamepad() then
		CoD.SwapFocusableElements(f241_arg2, f241_arg0.layerCarousel, f241_arg0.emptyFocusable)
	end
	CoD.CraftUtility.EmblemEditor_SetEditMode(f241_arg2)
	local f241_local1 = Engine.GetSelectedLayerColor(f241_arg2)
	local f241_local2 = Engine.GetSelectedLayerColor1(f241_arg2)
	Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(f241_arg2), "Emblem.EmblemSelectedLayerProperties.opacity0"), math.floor(f241_local1.alpha * 100))
	Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(f241_arg2), "Emblem.EmblemSelectedLayerProperties.opacity1"), math.floor(f241_local2.alpha * 100))
	Engine[@"emblembeginedit"](f241_arg2)
	CoD.perController[f241_arg2].selectedLayerMaterialID = Engine.GetSelectedLayerMaterialID(f241_arg2, f241_local0)
	EmblemEditor_SetScaleMode(f241_arg2, Enum.CustomizationScaleType[@"customization_scale_type_fixed"])
	EmblemEditor_SetMaterialScaleMode(f241_arg2, Enum.CustomizationScaleType[@"customization_scale_type_fixed"])
end
CoD.CraftUtility.EmblemEditor_SetFocusOnEditSelectedLayerPC = function(f242_arg0, f242_arg1, f242_arg2)
	if not CoD.isPC or not IsGamepad(f242_arg2) then
		return false
	else
		SetFocusToElement(f242_arg0, f242_arg1.id, f242_arg2)
	end
end
CoD.CraftUtility.EmblemEditor_SetNewSelectedLayer = function(f243_arg0, f243_arg1, f243_arg2, f243_arg3)
	CoD.CraftUtility.EmblemEditor_LayerGainFocus(f243_arg0, f243_arg1, f243_arg2, f243_arg3)
	CoD.CraftUtility.EmblemEditor_EditSelectedLayer(f243_arg0, f243_arg2, f243_arg3)
	CoD.CraftUtility.EmblemEditor_UpdateLayerData(f243_arg0, f243_arg3, f243_arg2)
end
CoD.CraftUtility.EmblemEditor_PrepareEmblemListPC = function(f244_arg0, f244_arg1, f244_arg2)
	f244_arg1.emblemLayerListModel = Engine.CreateModel(Engine.GetModelForController(f244_arg0), "Emblem.EmblemLayerList")
	local f244_local0 = CoD.GetCustomization(f244_arg0, "type")
	f244_arg1.totalLayers = math.min(Engine.GetUsedLayerCount(f244_arg0, f244_local0, CoD.perController[f244_arg0].totalLayers) + 1, CoD.perController[f244_arg0].totalLayers)
	f244_arg1.itemInfo = {}
	f244_arg1.selectIndex = 1
	if CoD.perController[f244_arg0].selectedLayerIndex == nil then
		CoD.perController[f244_arg0].selectedLayerIndex = 0
	end
	local f244_local1 = 1
	local f244_local2 = f244_arg1.totalLayers - 1
	while f244_local2 >= 0 do
		local f244_local3 = Engine.GetSelectedLayerData(f244_arg0, f244_local2, f244_local0)
		if f244_local3.isGrouped == true then
			local f244_local4 = DataSources.EmblemLayerList.createGroup(f244_arg0, f244_local2, f244_local3.groupIndex, f244_arg1.totalLayers, f244_local0)
			table.insert(f244_arg1.itemInfo, f244_local4)
			if not CoD.perController[f244_arg0].selectEmblemGroupIndex and CoD.perController[f244_arg0].selectedLayerIndex <= f244_local4.groupEndLayer and f244_local2 <= CoD.perController[f244_arg0].selectedLayerIndex then
				f244_arg1.selectIndex = f244_local1
			end
			f244_local2 = f244_local4.groupStartLayer - 1
		else
			if not CoD.perController[f244_arg0].selectEmblemGroupIndex and CoD.perController[f244_arg0].selectedLayerIndex == f244_local2 then
				f244_arg1.selectIndex = f244_local1
			end
			table.insert(f244_arg1.itemInfo, DataSources.EmblemLayerList.createLayer(f244_local2))
			f244_local2 = f244_local2 - 1
		end
		if f244_local3.groupIndex == CoD.perController[f244_arg0].selectEmblemGroupIndex then
			f244_arg1.selectIndex = #f244_arg1.itemInfo
		end
		f244_local1 = f244_local1 + 1
	end
	CoD.perController[f244_arg0].selectEmblemGroupIndex = nil
end
CoD.CraftUtility.EmblemEditor_MoveLayerLeft = function(f245_arg0, f245_arg1, f245_arg2, f245_arg3, f245_arg4, f245_arg5)
	local f245_local0 = Engine.GetUsedLayerCount(f245_arg2, f245_arg4, CoD.perController[f245_arg2].totalLayers)
	local f245_local1 = Engine.GetModelValue(f245_arg5:getModel(f245_arg2, "groupLayerCount"))
	local f245_local2 = function(f246_arg0, f246_arg1, f246_arg2)
		local f246_local0 = CoD.perController[f245_arg2].totalLayers
		local f246_local1
		if CoD.isPC and f246_arg2 > f246_arg0 + f246_arg1 then
			f246_local1 = false
		else
			f246_local1 = true
		end
		return f246_local1
	end
	if not f245_local2(f245_arg3, f245_local1, f245_local0) or not CoD.isPC and f245_arg3 > 0 then
		Engine[@"emblemmovelayerrelative"](f245_arg2, CoD.isPC and 1 or -1, f245_arg4)
		local f245_local3 = nil
		if IsGamepad(f245_arg2) then
			f245_local3 = f245_arg1.layerCarousel:getItemAtPosition(1, f245_arg5.gridInfoTable.zeroBasedIndex, true)
		else
			f245_local3 = f245_arg5:getPreviousItem()
		end
		if f245_local3 ~= nil then
			local f245_local4 = IsGamepad(f245_arg2) and f245_arg1.layerCarousel or f245_arg1.layerGrid
			if IsGamepad(f245_arg2) then
				local f245_local5 = f245_local3
			end
			local f245_local6 = f245_local5 or f245_arg5:getNextItem()
			if CoD.isPC and IsGamepad(f245_arg2) then
				f245_local6 = f245_arg1.layerCarousel:getItemAtPosition(1, f245_arg5.gridInfoTable.zeroBasedIndex + 2, true) or f245_local6
			end
			DataSources.EmblemLayerList.swapItemInfo(f245_arg2, f245_local4, f245_local6, f245_arg5)
			if IsGamepad(f245_arg2) then
				f245_arg1.layerCarousel:setActiveItem(f245_local3)
				if CoD.isPC then
					CoD.GridAndListUtility.UpdateDataSource(f245_arg1.layerCarousel, true, true, true)
					f245_arg1.layerCarousel:setActiveItem(f245_local3)
				end
			else
				f245_arg1.layerGrid:setActiveItem(f245_local3)
				CoD.GridAndListUtility.UpdateDataSource(f245_arg1.layerGrid, true, true, true)
				f245_arg1.layerGrid:setActiveItem(f245_local3)
			end
			if CoD.isPC then
				CoD.CraftUtility.EmblemEditor_SetNewSelectedLayer(f245_arg1, f245_arg0, f245_local3, f245_arg2)
			end
			EmblemEditor_SetupDrawEmblem(f245_arg2, f245_arg5, f245_local3)
			EmblemEditor_SetSelectedLayerIndex(f245_arg2, f245_local3)
			f245_arg5.arrows:setState(f245_arg2, "DefaultState")
			if CoD.isPC or not CoD.isPC and f245_arg3 > 1 then
				f245_local3.arrows:setState(f245_arg2, "LeftButtonPressed")
			end
		end
	end
end
CoD.CraftUtility.EmblemEditor_MoveLayerRight = function(f247_arg0, f247_arg1, f247_arg2, f247_arg3, f247_arg4, f247_arg5)
	local f247_local0 = Engine.GetUsedLayerCount(f247_arg2, f247_arg4, CoD.perController[f247_arg2].totalLayers)
	local f247_local1 = Engine.GetModelValue(f247_arg5:getModel(f247_arg2, "groupLayerCount"))
	local f247_local2 = function(f248_arg0)
		local f248_local0
		if CoD.isPC and f248_arg0 ~= 0 then
			f248_local0 = false
		else
			f248_local0 = true
		end
		return f248_local0
	end
	if not f247_local2(f247_arg3) or not CoD.isPC and f247_arg3 + f247_local1 < f247_local0 then
		Engine[@"emblemmovelayerrelative"](f247_arg2, CoD.isPC and -1 or 1, f247_arg4)
		local f247_local3 = nil
		if IsGamepad(f247_arg2) then
			f247_local3 = f247_arg1.layerCarousel:getItemAtPosition(1, f247_arg5.gridInfoTable.zeroBasedIndex + 2, true)
		else
			f247_local3 = f247_arg5:getNextItem()
		end
		if f247_local3 ~= nil then
			local f247_local4 = IsGamepad(f247_arg2) and f247_arg1.layerCarousel or f247_arg1.layerGrid
			if IsGamepad(f247_arg2) then
				local f247_local5 = f247_local3
			end
			local f247_local6 = f247_local5 or f247_arg5:getPreviousItem()
			if CoD.isPC and IsGamepad(f247_arg2) then
				f247_local6 = f247_arg1.layerCarousel:getItemAtPosition(1, f247_arg5.gridInfoTable.zeroBasedIndex, true) or f247_local6
			end
			DataSources.EmblemLayerList.swapItemInfo(f247_arg2, f247_local4, f247_arg5, f247_local6)
			EmblemEditor_SetupDrawEmblem(f247_arg2, f247_arg5, f247_local3)
			if IsGamepad(f247_arg2) then
				f247_arg1.layerCarousel:setActiveItem(f247_local3)
				if CoD.isPC then
					CoD.GridAndListUtility.UpdateDataSource(f247_arg1.layerCarousel, true, true, true)
					f247_arg1.layerCarousel:setActiveItem(f247_local3)
				end
			else
				f247_arg1.layerGrid:setActiveItem(f247_local3)
				if not f247_local3:getModel() then
					CoD.GridAndListUtility.UpdateDataSource(f247_arg1.layerGrid, true, true, true)
					f247_arg1.layerGrid:setActiveItem(f247_local3)
				end
			end
			if CoD.isPC then
				CoD.CraftUtility.EmblemEditor_SetNewSelectedLayer(f247_arg1, f247_arg0, f247_local3, f247_arg2)
			end
			EmblemEditor_SetSelectedLayerIndex(f247_arg2, f247_local3)
			f247_arg5.arrows:setState(f247_arg2, "DefaultState")
			if CoD.isPC or not CoD.isPC and f247_arg3 + 2 < f247_local0 then
				f247_local3.arrows:setState(f247_arg2, "RightButtonPressed")
			end
		end
	end
end
CoD.CraftUtility.EmblemEditor_MoveLayer = function(f249_arg0, f249_arg1, f249_arg2, f249_arg3)
	local f249_local0 = CoD.CraftUtility.GetActiveLayer(f249_arg1, f249_arg2)
	if f249_local0 ~= nil then
		if CoD.isPC and IsMouseOrKeyboard(f249_arg2) then
			f249_arg1.layerGrid:setActiveItem(f249_local0)
			f249_arg1.layerGrid:updateDataSource(false, false, false)
			f249_arg1.layerGrid:updateLayout()
			if not f249_local0:getModel() then
				return
			end
		end
		local f249_local1 = Engine.GetModelValue(f249_local0:getModel(f249_arg2, "layerIndex"))
		local f249_local2 = CoD.GetCustomization(f249_arg2, "type")
		if f249_arg3 == "left" then
			CoD.CraftUtility.EmblemEditor_MoveLayerLeft(f249_arg0, f249_arg1, f249_arg2, f249_local1, f249_local2, f249_local0)
		elseif f249_arg3 == "right" then
			CoD.CraftUtility.EmblemEditor_MoveLayerRight(f249_arg0, f249_arg1, f249_arg2, f249_local1, f249_local2, f249_local0)
		end
	end
end
CoD.CraftUtility.EmblemEditor_CopyLayerToClipboard = function(f250_arg0, f250_arg1, f250_arg2)
	Engine[@"emblemcopylayer"](CoD.perController[f250_arg2].selectedLayerIndex)
	CoD.CraftUtility.SetEmblemEditorProperties(f250_arg2, CoD.CraftUtility.EMBLEM_CLIPBOARDSTATE.FULL, "isClipboardEmpty")
	f250_arg0.clipboard:setState(f250_arg2, "Visible")
	if CoD.CraftUtility.IsEditMode(f250_arg2) then
		CoD.CraftUtility.EmblemEditor_HandleBackInEditMode(f250_arg0, f250_arg1, f250_arg2)
	end
end
CoD.CraftUtility.EmblemEditor_EditLayerListActive = function(f251_arg0, f251_arg1, f251_arg2)
	CoD.CraftUtility.EmblemEditor_EditSelectedLayer(f251_arg0, f251_arg2.activeWidget, f251_arg1)
end
CoD.CraftUtility.EmblemEditor_UpdateLayerDataWithListActive = function(f252_arg0, f252_arg1, f252_arg2)
	CoD.CraftUtility.EmblemEditor_UpdateLayerData(f252_arg0, f252_arg1, f252_arg2.activeWidget)
end
CoD.CraftUtility.EmblemEditor_RotateLayer = function(f253_arg0)
	Engine[@"hash_6B84043E521116AD"](f253_arg0)
end
CoD.CraftUtility.EmblemEditor_UpdateLayerData = function(f254_arg0, f254_arg1, f254_arg2)
	local f254_local0 = nil
	if IsMouseOrKeyboard(f254_arg1) then
		f254_local0 = f254_arg2
	else
		f254_local0 = CoD.CraftUtility.GetActiveLayer(f254_arg0, f254_arg1)
	end
	if f254_local0 ~= nil then
		f254_arg0.layerCarousel:updateDataSource(true)
		if CoD.isPC and f254_arg0.layerGrid then
			f254_arg0.layerGrid:updateDataSource(false, false, false)
			f254_arg0.layerGrid:updateLayout()
			f254_arg0.layerGrid:setActiveItem(f254_local0)
		end
	end
	ForceNotifyModel(f254_arg1, "Emblem.EmblemProperties.editorMode")
end
CoD.CraftUtility.EmblemEditor_InsertLayer = function(f255_arg0, f255_arg1, f255_arg2)
	local f255_local0 = CoD.GetCustomization(f255_arg2, "type")
	Engine[@"embleminsertlayer"](CoD.perController[f255_arg2].selectedLayerIndex, f255_local0)
	CoD.CraftUtility.EmblemEditor_SetLayerAndGroupCount(f255_arg2)
	local f255_local1 = Engine.GetSelectedLayerData(f255_arg2, CoD.perController[f255_arg2].selectedLayerIndex, f255_local0)
	if f255_local1.groupIndex ~= CoD.CraftUtility.INVALID_GROUP_INDEX then
		CoD.perController[f255_arg2].selectEmblemGroupIndex = f255_local1.groupIndex
	end
	CoD.perController[f255_arg2].selectedLayerIndex = CoD.perController[f255_arg2].selectedLayerIndex + 1
end
CoD.CraftUtility.EmblemEditor_InsertGroup = function(f256_arg0, f256_arg1, f256_arg2)
	Engine[@"hash_754C286FA1FD349D"](CoD.perController[f256_arg2].selectedLayerIndex, CoD.GetCustomization(f256_arg2, "type"))
	CoD.CraftUtility.EmblemEditor_SetLayerAndGroupCount(f256_arg2)
end
CoD.CraftUtility.EmblemEditor_SetActiveLayer = function(f257_arg0, f257_arg1, f257_arg2)
	local f257_local0 = f257_arg0.layerCarousel:findItem({
		layerIndex = CoD.perController[f257_arg2].selectedLayerIndex,
	}, nil, true, 0)
	if f257_local0 then
		f257_arg0.layerCarousel:setActiveItem(f257_local0)
	end
end
CoD.CraftUtility.EmblemEditor_RefreshDatasource = function(f258_arg0, f258_arg1)
	if f258_arg1 then
		f258_arg1:updateDataSource()
		if CoD.isPC and f258_arg0.layerGrid then
			f258_arg0.layerGrid:updateDataSource()
		end
	end
end
CoD.CraftUtility.EmblemEditor_HandleBackInEditMode = function(f259_arg0, f259_arg1, f259_arg2)
	Engine[@"emblemendedit"](f259_arg2)
	if IsPaintshop(f259_arg2) == true then
		f259_arg0.PaintshopFrame.CommonHeader.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/paintshop_caps"))
	else
		f259_arg0.EmblemEditorFrame.CommonHeader.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/emblem_editor_caps"))
	end
	CoD.CraftUtility.SetEmblemEditorProperties(f259_arg2, Enum.CustomizationEditorMode[@"customization_editor_mode_browse"], "editorMode")
	CoD.SwapFocusableElements(f259_arg2, f259_arg0.emptyFocusable, f259_arg0.layerCarousel)
	if CoD.isPC and f259_arg0.layerGrid.activeWidget then
		f259_arg0.layerGrid.activeWidget:processEvent({
			name = "lose_active",
			controller = f259_arg0.controller,
		})
	end
end
CoD.CraftUtility.EmblemEditor_SetupEditorCarouselBasedOnMode = function(f260_arg0, f260_arg1, f260_arg2)
	if CoD.CraftUtility.IsEditMode(f260_arg2) then
		CoD.CraftUtility.EmblemEditor_EditSelectedLayer(
			f260_arg0,
			f260_arg1:findItem({
				layerIndex = CoD.perController[f260_arg2].selectedLayerIndex,
			}, nil, true, 0),
			f260_arg2
		)
	end
end
CoD.CraftUtility.EmblemEditor_ReturnFromOverlay = function(f261_arg0, f261_arg1)
	if CoD.CraftUtility.IsEditMode(f261_arg1) then
		f261_arg0.layerCarousel:updateDataSource(true)
		if CoD.isPC and f261_arg0.layerGrid then
			f261_arg0.layerGrid:updateDataSource()
		end
		CoD.CraftUtility.EmblemEditor_EditSelectedLayer(f261_arg0, nil, f261_arg1)
		CoD.SwapFocusableElements(f261_arg1, f261_arg0.layerCarousel, f261_arg0.emptyFocusable)
		CoD.CraftUtility.EmblemEditor_SetLayerAndGroupCount(f261_arg1)
	else
		CoD.SwapFocusableElements(f261_arg1, nil, f261_arg0.layerCarousel)
	end
	ForceNotifyModel(f261_arg1, "Emblem.EmblemProperties.editorMode")
end
CoD.CraftUtility.SetupMouseScrollingEmblemScale = function(f262_arg0, f262_arg1)
	if CoD.isPC then
		CoD.Menu.AddButtonCallbackFunction(f262_arg0, f262_arg0, f262_arg1, Enum.LUIButton[@"lui_key_pckey_mwheelup"], "MWHEELUP", function(f263_arg0, f263_arg1, f263_arg2, f263_arg3)
			if not f263_arg1.m_disableNavigation and CoD.CraftUtility.IsEditMode(f263_arg2) then
				Engine[@"hash_6AE71EACC5A3B69C"](0.02, 0.02)
			end
		end)
		CoD.Menu.AddButtonCallbackFunction(f262_arg0, f262_arg0, f262_arg1, Enum.LUIButton[@"lui_key_pckey_mwheeldown"], "MWHEELDOWN", function(f264_arg0, f264_arg1, f264_arg2, f264_arg3)
			if not f264_arg1.m_disableNavigation and CoD.CraftUtility.IsEditMode(f264_arg2) then
				Engine[@"hash_6AE71EACC5A3B69C"](-0.02, -0.02)
			end
		end)
	end
end
CoD.CraftUtility.SetupMouseScrollingEmblemMaterialScale = function(f265_arg0, f265_arg1)
	if CoD.isPC then
		CoD.Menu.AddButtonCallbackFunction(f265_arg0, f265_arg0, f265_arg1, Enum.LUIButton[@"lui_key_pckey_mwheelup"], "MWHEELUP", function(f266_arg0, f266_arg1, f266_arg2, f266_arg3)
			if not f266_arg1.m_disableNavigation and CoD.CraftUtility.IsEditMode(f266_arg2) then
				Engine[@"hash_44950DB3952D39A6"](f266_arg2, 0.02)
				Engine[@"hash_5E6ECCE18819CF89"](f266_arg2, 0.02)
			end
		end)
		CoD.Menu.AddButtonCallbackFunction(f265_arg0, f265_arg0, f265_arg1, Enum.LUIButton[@"lui_key_pckey_mwheeldown"], "MWHEELDOWN", function(f267_arg0, f267_arg1, f267_arg2, f267_arg3)
			if not f267_arg1.m_disableNavigation and CoD.CraftUtility.IsEditMode(f267_arg2) then
				Engine[@"hash_44950DB3952D39A6"](f267_arg2, -0.02)
				Engine[@"hash_5E6ECCE18819CF89"](f267_arg2, -0.02)
			end
		end)
	end
end
CoD.CraftUtility.SetupRightStickEmblemMaterialScale = function(f268_arg0, f268_arg1)
	local f268_local0 = function()
		if f268_arg0.xValue ~= 0 and f268_arg0.yValue ~= 0 and f268_arg0.length ~= 0 then
			local f269_local0 = f268_arg0.length
			if f269_local0 >= 0.5 then
				f269_local0 = (f269_local0 - 0.45) * 2
			elseif f269_local0 >= 0.2 then
				f269_local0 = 0.1
			else
				f269_local0 = 0
			end
			f268_arg0.xValue = f268_arg0.xValue * f269_local0
			f268_arg0.yValue = f268_arg0.yValue * f269_local0
		end
	end
	local f268_local1 = function()
		if f268_arg0.xValue ~= 0 and f268_arg0.yValue ~= 0 then
			local f270_local0 = 0.05
			local f270_local1 = 0
			local f270_local2 = f268_arg0.xValue * f270_local0
			local f270_local3 = f268_arg0.yValue * f270_local0
			if CoD.CraftUtility.GetEmblemEditorProperties(f268_arg1, "materialScaleMode") == Enum.CustomizationScaleType[@"customization_scale_type_fixed"] then
				if f270_local1 < math.abs(f270_local2) then
					Engine[@"hash_44950DB3952D39A6"](f268_arg1, f270_local2)
					Engine[@"hash_5E6ECCE18819CF89"](f268_arg1, f270_local2)
				end
			else
				if f270_local1 < math.abs(f270_local2) then
					Engine[@"hash_44950DB3952D39A6"](f268_arg1, f270_local2)
				end
				if f270_local1 < math.abs(f270_local3) then
					Engine[@"hash_5E6ECCE18819CF89"](f268_arg1, f270_local3)
				end
			end
		end
	end
	f268_arg0:addElement(LUI.UITimer.newElementTimer(100, false, function()
		local f271_local0 = DataSources.RightStick.getModel(f268_arg1)
		if f271_local0 then
			f268_arg0.xValue = Engine.GetModelValue(Engine.GetModel(f271_local0, "X"))
			f268_arg0.yValue = Engine.GetModelValue(Engine.GetModel(f271_local0, "Y"))
			f268_arg0.length = Engine.GetModelValue(Engine.GetModel(f271_local0, "Length"))
			f268_local0()
			f268_local1()
		end
	end))
end
CoD.CraftUtility.InitializeColorPickerProperties = function(f272_arg0)
	local f272_local0 = Engine.GetSelectedLayerColor(f272_arg0)
	local f272_local1 = Engine.GetSelectedLayerColor1(f272_arg0)
	CoD.CraftUtility.SetEmblemNoColorDataModel(f272_arg0)
	if f272_local0.red == f272_local1.red and f272_local0.green == f272_local1.green and f272_local0.blue == f272_local1.blue and f272_local0.alpha == f272_local1.alpha then
		CoD.CraftUtility.SetEmblemEditorProperties(f272_arg0, Enum.CustomizationColorMode[@"customization_color_mode_solid"], "colorMode")
		CoD.CraftUtility.SetEmblemEditorProperties(f272_arg0, 0, "isGradientMode")
		CoD.CraftUtility.SetEmblemEditorProperties(f272_arg0, Enum.CustomizationColorNum[@"customization_color_none"], "colorNum")
		return
	else
		CoD.CraftUtility.SetEmblemEditorProperties(f272_arg0, Enum.CustomizationColorMode[@"customization_color_mode_none"], "colorMode")
		CoD.CraftUtility.SetEmblemEditorProperties(f272_arg0, 1, "isGradientMode")
		CoD.CraftUtility.SetEmblemEditorProperties(f272_arg0, Enum.CustomizationColorNum[@"customization_color_0"], "colorNum")
	end
end
CoD.CraftUtility.EmblemEditor_FlipIcon = function(f273_arg0, f273_arg1, f273_arg2)
	Engine[@"hash_5268A011A247D4BD"]()
end
CoD.CraftUtility.EmblemEditor_ToggleOutline = function(f274_arg0, f274_arg1, f274_arg2)
	Engine[@"hash_780F7EFDE9145DC6"]()
end
CoD.CraftUtility.EmblemEditor_ClipLayer = function(f275_arg0, f275_arg1, f275_arg2)
	Engine[@"hash_1916F60FB6DD7548"]()
end
CoD.CraftUtility.EmblemEditor_EndEdit = function(f276_arg0, f276_arg1, f276_arg2)
	Engine[@"emblemendedit"](f276_arg2)
end
CoD.CraftUtility.EmblemEditor_BeginEdit = function(f277_arg0, f277_arg1, f277_arg2)
	Engine[@"emblembeginedit"](f277_arg2)
end
CoD.CraftUtility.EmblemEditor_CutLayer = function(f278_arg0, f278_arg1, f278_arg2)
	Engine[@"emblemcutlayer"](CoD.GetCustomization(f278_arg2, "type"))
	CoD.CraftUtility.EmblemEditor_SetLayerAndGroupCount(f278_arg2)
	CoD.CraftUtility.SetEmblemEditorProperties(f278_arg2, CoD.CraftUtility.EMBLEM_CLIPBOARDSTATE.FULL, "isClipboardEmpty")
	f278_arg0.clipboard:setState(f278_arg2, "Visible")
	if CoD.CraftUtility.IsEditMode(f278_arg2) then
		CoD.CraftUtility.EmblemEditor_HandleBackInEditMode(f278_arg0, f278_arg1, f278_arg2)
	end
end
CoD.CraftUtility.EmblemEditor_HandleKeyboardComplete = function(f279_arg0, f279_arg1, f279_arg2, f279_arg3)
	local f279_local0 = CoD.perController[f279_arg2].selectedEmblemModel
	local f279_local1 = nil
	if not f279_local0 then
		return
	elseif f279_arg3.type == Enum.KeyboardType[@"keyboard_type_emblems"] then
		f279_local1 = Engine.GetModel(f279_local0, "emblemTextEntry")
		if f279_local1 then
			Engine.SetModelValue(f279_local1, f279_arg3.input)
		end
		local f279_local2 = f279_arg0:getModel(f279_arg2, "inputText")
		if f279_local2 then
			Engine.SetModelValue(f279_local2, f279_arg3.input)
		end
	end
end
CoD.CraftUtility.EmblemEditor_OpenSavePopup = function(f280_arg0, f280_arg1, f280_arg2, f280_arg3, f280_arg4)
	local f280_local0 = f280_arg4
	if IsPaintshop(f280_arg2) then
		CoD.OverlayUtility.CreateOverlay(f280_arg2, f280_arg0, "PaintjobSave", f280_arg2, CoD.perController[f280_arg2].selectedPaintjobModel, f280_local0, nil)
	else
		CoD.OverlayUtility.CreateOverlay(f280_arg2, f280_arg0, "EmblemSave", f280_arg2, CoD.perController[f280_arg2].selectedEmblemModel, f280_local0, nil)
	end
end
CoD.CraftUtility.CraftEditor_OpenEditorOptions = function(f281_arg0, f281_arg1)
	if IsPaintshop(f281_arg1) then
		OpenPopup(f281_arg0, "PaintjobEditorOptions", f281_arg1, nil)
	else
		OpenPopup(f281_arg0, "EmblemEditorOptions", f281_arg1, nil)
	end
end
CoD.CraftUtility.EmblemEditor_OpenSaveGroupPopup = function(f282_arg0, f282_arg1, f282_arg2)
	if not CoD.CraftUtility.EmblemChooseIcon_IsCustomDecalCategorySelected(f282_arg0, f282_arg2) then
		CoD.perController[f282_arg2].selectedDecalCategory = CoD.CraftUtility.EmblemDecalGroupCategory
		CoD.CraftUtility.Groups.ParseDDL(f282_arg2)
	end
	CoD.perController[f282_arg2].selectedDecalGroupModel = Engine.CreateModel(Engine.GetModelForController(f282_arg2), "CraftGroups.selectedDecalGroupModel")
	Engine.SetModelValue(Engine.CreateModel(CoD.perController[f282_arg2].selectedDecalGroupModel, "emblemTextEntry"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_4C73FF737572DAB5", CoD.CraftUtility.Groups.GetTotalUsed(f282_arg2) + 1))
	CoD.OverlayUtility.CreateOverlay(f282_arg2, f282_arg0, "DecalGroupSave", f282_arg2, CoD.perController[f282_arg2].selectedDecalGroupModel)
end
CoD.CraftUtility.DecalGroups_HandleKeyboardComplete = function(f283_arg0, f283_arg1, f283_arg2, f283_arg3)
	local f283_local0 = CoD.perController[f283_arg2].selectedDecalGroupModel
	local f283_local1 = nil
	if not f283_local0 then
		return
	elseif f283_arg3.type == Enum.KeyboardType[@"hash_3FE81C2839DE0D30"] then
		f283_local1 = Engine.GetModel(f283_local0, "emblemTextEntry")
		if f283_local1 then
			Engine.SetModelValue(f283_local1, f283_arg3.input)
		end
		local f283_local2 = f283_arg0:getModel(f283_arg2, "inputText")
		if f283_local2 then
			Engine.SetModelValue(f283_local2, f283_arg3.input)
		end
	end
end
CoD.CraftUtility.EmblemEditor_SaveEmblemAndEdit = function(f284_arg0, f284_arg1, f284_arg2, f284_arg3, f284_arg4)
	local f284_local0 = Engine.GetModelValue(Engine.GetModel(f284_arg3, "emblemTextEntry"))
	if f284_arg4 then
		if IsPreBuiltEmblemTab(f284_arg2) then
			CoD.perController[f284_arg2].selectedEmblemTabStorageType = Enum.StorageFileType[@"storage_emblems"]
			CoD.CraftUtility.Emblems.ParseDDL(f284_arg2, Enum.StorageFileType[@"storage_emblems"], CoD.perController[f284_arg2].selectedEmblemTabStickerCategory)
		end
		local f284_local1 = CoD.CraftUtility.Emblems.GetOpenSlot(f284_arg2)
		local f284_local2 = Engine.GetModel(Engine.GetModel(Engine.GetModelForController(f284_arg2), "Emblem.EmblemList"), "emblem_" .. f284_local1 + 1)
		f284_arg3 = f284_local2
		CoD.perController[f284_arg2].selectedEmblemModel = f284_local2
		Engine.SetModelValue(Engine.GetModel(f284_arg3, "emblemIndex"), f284_local1)
		Engine.SetModelValue(Engine.GetModel(f284_arg3, "isUsed"), 1)
		Engine.SetModelValue(Engine.GetModel(f284_arg3, "storageFileType"), Enum.StorageFileType[@"storage_emblems"])
	end
	local f284_local1 = Engine.GetModel(f284_arg3, "displayName")
	local f284_local3 = Engine.MediaManagerGetQuota(f284_arg2, "emblem")
	Engine.SetModelValue(f284_local1, f284_local0)
	EmblemEditor_RecordMetrics(f284_arg0, f284_arg2, f284_local3.categorySlotsUsed, f284_local3.categoryQuota)
	CoD.CraftUtility.Emblems.UploadEmblem(f284_arg2, f284_arg3)
	CoD.CraftUtility.Emblems.ParseDDL(f284_arg2, Enum.StorageFileType[@"storage_emblems"], CoD.perController[f284_arg2].selectedEmblemTabStickerCategory)
	local f284_local4 = Engine.GetModelValue(Engine.GetModel(f284_arg3, "emblemIndex"))
	Engine[@"hash_C3742A77E5CD0BE"](f284_arg2, f284_local4, Enum.StorageFileType[@"storage_emblems"])
	Engine[@"invalidateemblemcomponent"](f284_arg2)
	Engine.SetupEmblemData(f284_arg2, f284_local4, Enum.StorageFileType[@"storage_emblems"], CoD.GetCustomization(f284_arg2, "type"))
end
CoD.CraftUtility.EmblemEditor_SaveEmblemAndExit = function(f285_arg0, f285_arg1, f285_arg2, f285_arg3, f285_arg4)
	CoD.CraftUtility.EmblemEditor_SaveEmblemAndEdit(f285_arg0, f285_arg1, f285_arg2, f285_arg3, f285_arg4)
	local f285_local0 = GoBack(f285_arg0, f285_arg2)
	local f285_local1 = CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f285_local0, f285_arg2)
	ClearMenuSavedState(f285_local0, f285_arg2)
	return f285_local1
end
CoD.CraftUtility.SavePaintjob = function(f286_arg0, f286_arg1)
	local f286_local0 = CoD.perController[f286_arg1].selectedPaintjobModel
	if not f286_local0 then
		return
	else
		local f286_local1 = Engine.GetModel(f286_local0, "paintjobTextEntry")
		Engine.SetModelValue(Engine.GetModel(f286_local0, "paintjobName"), f286_local1:get())
		CoD.CraftUtility.Paintjobs.UploadPaintjob(f286_arg1, f286_local0)
		CoD.CraftUtility.Paintjobs.ParseDDL(f286_arg1, Enum.StorageFileType[@"storage_paintjobs"])
		CoD.CraftUtility.Paintjobs.InvalidateRender(f286_arg1, f286_local0)
		local f286_local2 = Engine.MediaManagerGetQuota(f286_arg1, "paintjob")
		PaintJobEditor_RecordMetrics(f286_arg0, f286_arg1, f286_local0, "save", f286_local2.categorySlotsUsed, f286_local2.categoryQuota)
		local f286_local3 = Engine.GetModelValue(Engine.GetModel(f286_local0, "paintjobSlot"))
		local f286_local4 = CoD.GetCustomization(f286_arg1, "type")
		local f286_local5 = CoD.GetCustomization(f286_arg1, "weapon_index")
		Engine.SetupPaintjobData(f286_arg1, f286_local3)
		Engine.SetupEmblemEditBuffer(f286_arg1, f286_local4, f286_local5)
	end
end
CoD.CraftUtility.SaveEmblem = function(f287_arg0, f287_arg1)
	local f287_local0 = CoD.perController[f287_arg1].selectedEmblemModel
	if not f287_local0 then
		return
	else
		local f287_local1 = Engine.GetModel(f287_local0, "emblemTextEntry")
		f287_local1 = f287_local1:get()
		local f287_local2 = Engine.GetModel(f287_local0, "displayName")
		local f287_local3 = Engine.MediaManagerGetQuota(f287_arg1, "emblem")
		Engine.SetModelValue(f287_local2, f287_local1)
		EmblemEditor_RecordMetrics(f287_arg0, f287_arg1, f287_local3.categorySlotsUsed, f287_local3.categoryQuota)
		CoD.CraftUtility.Emblems.UploadEmblem(f287_arg1, f287_local0)
		CoD.CraftUtility.Emblems.ParseDDL(f287_arg1, Enum.StorageFileType[@"storage_emblems"])
		local f287_local4 = Engine.GetModelValue(Engine.GetModel(f287_local0, "emblemIndex"))
		Engine[@"hash_C3742A77E5CD0BE"](f287_arg1, f287_local4, Enum.StorageFileType[@"storage_emblems"])
		Engine.SetupEmblemData(f287_arg1, f287_local4, Enum.StorageFileType[@"storage_emblems"], CoD.GetCustomization(f287_arg1, "type"))
	end
end
CoD.CraftUtility.PaintjobEditor_SavePaintjobAndEdit = function(f288_arg0, f288_arg1, f288_arg2, f288_arg3, f288_arg4)
	local f288_local0 = Engine.GetModelValue(Engine.GetModel(f288_arg3, "paintjobTextEntry"))
	local f288_local1 = Engine.GetModelValue(Engine.GetModel(f288_arg3, "weaponIndex"))
	local f288_local2 = Engine.MediaManagerGetQuota(f288_arg2, "paintjob")
	if f288_arg4 then
		local f288_local3 = CoD.CraftUtility.Paintjobs.GetOpenSlot(f288_arg2)
		local f288_local4 = Engine.GetModel(Engine.GetModel(Engine.GetModelForController(f288_arg2), "Paintshop.PaintjobList"), "paintjob_" .. CoD.CraftUtility.Paintjobs.TotalPaintjobsForWeaponIndex(f288_local1) + 1)
		f288_arg3 = f288_local4
		CoD.perController[f288_arg2].selectedPaintjobModel = f288_local4
		Engine.SetModelValue(Engine.GetModel(f288_arg3, "paintjobSlot"), f288_local3)
		Engine.SetModelValue(Engine.GetModel(f288_arg3, "weaponIndex"), f288_local1)
	end
	Engine.SetModelValue(Engine.GetModel(f288_arg3, "paintjobName"), f288_local0)
	CoD.CraftUtility.Paintjobs.UploadPaintjob(f288_arg2, f288_arg3)
	CoD.CraftUtility.Paintjobs.ParseDDL(f288_arg2, Enum.StorageFileType[@"storage_paintjobs"])
	CoD.CraftUtility.Paintjobs.InvalidateRender(f288_arg2, f288_arg3)
	PaintJobEditor_RecordMetrics(f288_arg0, f288_arg2, f288_arg3, "save", f288_local2.categorySlotsUsed, f288_local2.categoryQuota)
	local f288_local5 = Engine.GetModelValue(Engine.GetModel(f288_arg3, "paintjobSlot"))
	local f288_local6 = CoD.GetCustomization(f288_arg2, "type")
	local f288_local4 = CoD.GetCustomization(f288_arg2, "weapon_index")
	Engine.SetupPaintjobData(f288_arg2, f288_local5)
	Engine.SetupEmblemEditBuffer(f288_arg2, f288_local6, f288_local4)
end
CoD.CraftUtility.PaintjobEditor_SavePaintjobAndExit = function(f289_arg0, f289_arg1, f289_arg2, f289_arg3, f289_arg4)
	CoD.CraftUtility.PaintjobEditor_SavePaintjobAndEdit(f289_arg0, f289_arg1, f289_arg2, f289_arg3, f289_arg4)
	local f289_local0 = GoBack(f289_arg0, f289_arg2)
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f289_local0, f289_arg2)
	ClearMenuSavedState(f289_local0, f289_arg2)
end
CoD.CraftUtility.PaintjobEditor_DiscardChanges = function(f290_arg0, f290_arg1, f290_arg2)
	local f290_local0 = GoBack(f290_arg0, f290_arg1)
	PaintJobEditor_RecordMetrics(f290_arg0, f290_arg1, f290_arg2, "discard")
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f290_local0, f290_arg1)
	ClearMenuSavedState(f290_local0, f290_arg1)
end
CoD.CraftUtility.PaintjobEditor_HandleKeyboardComplete = function(f291_arg0, f291_arg1, f291_arg2)
	local f291_local0 = CoD.perController[f291_arg1].selectedPaintjobModel
	local f291_local1 = nil
	if not f291_local0 then
		return
	elseif f291_arg2.type == Enum.KeyboardType[@"keyboard_type_paintjob"] then
		f291_local1 = Engine.GetModel(f291_local0, "paintjobTextEntry")
		if f291_local1 then
			Engine.SetModelValue(f291_local1, f291_arg2.input)
		end
		local f291_local2 = f291_arg0:getModel(f291_arg1, "inputText")
		if f291_local2 then
			Engine.SetModelValue(f291_local2, f291_arg2.input)
		end
	end
end
function PaintjobEditor_SavePaintjob(f292_arg0, f292_arg1, f292_arg2)
	local f292_local0 = Engine.GetModelValue(Engine.GetModel(f292_arg2, "paintjobTextEntry"))
	local f292_local1 = Engine.GetModel(f292_arg2, "paintjobName")
	local f292_local2 = Engine.MediaManagerGetQuota(f292_arg1, "paintjob")
	Engine.SetModelValue(f292_local1, f292_local0)
	CoD.CraftUtility.Paintjobs.UploadPaintjob(f292_arg1, f292_arg2)
	CoD.CraftUtility.Paintjobs.ParseDDL(f292_arg1, Enum.StorageFileType[@"storage_paintjobs"])
	CoD.CraftUtility.Paintjobs.InvalidateRender(f292_arg1, f292_arg2)
	PaintJobEditor_RecordMetrics(f292_arg0, f292_arg1, f292_arg2, "save", f292_local2.categorySlotsUsed, f292_local2.categoryQuota)
	local f292_local3 = GoBack(f292_arg0, f292_arg1)
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f292_local3, f292_arg1)
	ClearMenuSavedState(f292_local3, f292_arg1)
end
CoD.CraftUtility.EmblemEditor_ReturnToSelect = function(f293_arg0, f293_arg1, f293_arg2)
	CoD.CraftUtility.Emblems.ParseDDL(f293_arg2, CoD.perController[f293_arg2].selectedEmblemTabStorageType, CoD.perController[f293_arg2].selectedEmblemTabStickerCategory)
	local f293_local0 = GoBack(f293_arg0, f293_arg2)
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f293_local0, f293_arg2)
	ClearMenuSavedState(f293_local0, f293_arg2)
end
CoD.CraftUtility.PaintjobEditor_ReturnToSelect = function(f294_arg0, f294_arg1, f294_arg2)
	CoD.CraftUtility.Paintjobs.ParseDDL(f294_arg2, Enum.StorageFileType[@"storage_paintjobs"])
	local f294_local0 = GoBack(f294_arg0, f294_arg2)
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f294_local0, f294_arg2)
	ClearMenuSavedState(f294_local0, f294_arg2)
end
CoD.CraftUtility.EmblemEditor_NoChangesAction = function(f295_arg0, f295_arg1)
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(GoBack(f295_arg0, f295_arg1), f295_arg1)
end
CoD.CraftUtility.EmblemEditor_SaveChangesBack = function(f296_arg0, f296_arg1, f296_arg2, f296_arg3)
	local f296_local0 = false
	local f296_local1 = Engine.GetModel(f296_arg3, "emblemIndex")
	local f296_local2 = Engine.GetModel(f296_arg3, "storageFileType")
	if f296_local1 and f296_local2 then
		local f296_local3 = Engine.GetModelValue(f296_local1)
		local f296_local4 = Engine.GetModelValue(f296_local2)
		if CoD.CraftUtility.Emblems.IsEmblemIndexOccupied(f296_local3) then
			f296_local0 = true
		end
	end
	if not f296_local0 then
		Engine.SetModelValue(Engine.GetModel(f296_arg3, "emblemTextEntry"), "Emblem")
	end
end
CoD.CraftUtility.EmblemEditor_ToggleScaleMode = function(f297_arg0, f297_arg1, f297_arg2)
	local f297_local0
	if Engine.GetEmblemScaleMode(f297_arg2) == Enum.CustomizationScaleType[@"customization_scale_type_fixed"] then
		f297_local0 = Enum.CustomizationScaleType[@"customization_scale_type_free"]
	else
		f297_local0 = Enum.CustomizationScaleType[@"customization_scale_type_fixed"]
	end
	CoD.CraftUtility.SetEmblemEditorProperties(f297_arg2, f297_local0, "scaleMode")
	Engine[@"emblemsetscalemode"](f297_local0)
end
CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer = function(f298_arg0, f298_arg1, f298_arg2)
	local f298_local0 = nil
	if IsMouseOrKeyboard(f298_arg1) then
		f298_local0 = f298_arg2
	else
		f298_local0 = CoD.CraftUtility.GetActiveLayer(f298_arg0, f298_arg1)
	end
	local f298_local1 = f298_local0:getModel(f298_arg1, "layerIndex")
	if f298_local1 then
		local f298_local2 = Engine.GetModelValue(f298_local1)
		local f298_local3 = CoD.GetCustomization(f298_arg1, "type")
		local f298_local4 = f298_local0:getModel(f298_arg1, "isLinked")
		local f298_local5 = f298_local0:getModel(f298_arg1, "groupIndex")
		if f298_local4 then
			if Engine.GetModelValue(f298_local4) == true then
				Engine[@"hash_5E3CF8834903981E"](f298_local3)
				Engine.SetModelValue(f298_local4, false)
			else
				Engine[@"hash_69B5A5256AAFB199"](f298_local3)
				Engine.SetModelValue(f298_local4, true)
			end
			local f298_local6 = Engine.GetSelectedLayerData(f298_arg1, f298_local2, f298_local3)
			Engine.SetModelValue(f298_local5, f298_local6.groupIndex)
			CoD.CraftUtility.SetEmblemEditorProperties(f298_arg1, Engine.GetLinkedLayerCount(f298_arg1, f298_local3), "linkedLayerCount")
		end
	end
end
CoD.CraftUtility.EmblemEditor_LinkAllLayers = function(f299_arg0, f299_arg1)
	local f299_local0 = f299_arg0.layerCarousel
	local f299_local1 = CoD.GetCustomization(f299_arg1, "type")
	Engine[@"hash_2D495DB75A304DDC"](f299_local1)
	CoD.CraftUtility.SetEmblemEditorProperties(f299_arg1, Engine.GetLinkedLayerCount(f299_arg1, f299_local1), "linkedLayerCount")
	f299_arg0.layerCarousel:updateDataSource()
	if CoD.isPC and f299_arg0.layerGrid then
		f299_arg0.layerGrid:updateDataSource()
	end
end
CoD.CraftUtility.EmblemEditor_GroupUngroupLayers = function(f300_arg0, f300_arg1, f300_arg2)
	local f300_local0 = nil
	if IsMouseOrKeyboard(f300_arg1) then
		f300_local0 = f300_arg2
	else
		f300_local0 = CoD.CraftUtility.GetActiveLayer(f300_arg0, f300_arg1)
	end
	local f300_local1 = f300_local0:getModel(f300_arg1, "layerIndex")
	if f300_local1 then
		local f300_local2 = Engine.GetModelValue(f300_local1)
		local f300_local3 = CoD.GetCustomization(f300_arg1, "type")
		local f300_local4 = f300_local0:getModel(f300_arg1, "isLinked")
		local f300_local5 = f300_local0:getModel(f300_arg1, "isGrouped")
		local f300_local6 = f300_local0:getModel(f300_arg1, "groupIndex")
		if f300_local4 and f300_local5 then
			local f300_local7 = Engine.GetModelValue(f300_local4)
			local f300_local8 = Engine.GetModelValue(f300_local5)
			local f300_local9 = Engine.GetSelectedLayerData(f300_arg1, f300_local2, f300_local3)
			local f300_local10 = CoD.CraftUtility.GetEmblemEditorProperties(f300_arg1, "linkedLayerCount")
			if f300_local7 == true then
				if f300_local8 == true then
					Engine[@"hash_7676616249C41A59"](f300_local3)
					Engine.SetModelValue(f300_local5, false)
					Engine.SetModelValue(f300_local6, f300_local9.groupIndex)
					CoD.CraftUtility.SetEmblemEditorProperties(f300_arg1, Engine.GetUsedGroupCount(f300_arg1, f300_local3), "groupsUsed")
					f300_arg0.layerCarousel:updateDataSource()
					if CoD.isPC and f300_arg0.layerGrid then
						f300_arg0.layerGrid:updateDataSource()
					end
				elseif f300_local10 >= 2 and IsGroupSlotAvailable(f300_arg1) then
					Engine[@"hash_7CA90FD7DDD3CA04"](f300_local3)
					Engine.SetModelValue(f300_local5, true)
					Engine.SetModelValue(f300_local6, f300_local9.groupIndex)
					CoD.perController[f300_arg1].selectEmblemGroupIndex = f300_local9.groupIndex
					f300_arg0.layerCarousel:updateDataSource()
					if CoD.isPC and f300_arg0.layerGrid then
						f300_arg0.layerGrid:updateDataSource()
					end
					CoD.perController[f300_arg1].selectEmblemGroupIndex = nil
				end
			end
		end
		CoD.CraftUtility.SetEmblemEditorProperties(f300_arg1, Engine.GetLinkedLayerCount(f300_arg1, f300_local3), "linkedLayerCount")
	end
end
CoD.CraftUtility.EmblemEditor_StoreSelectedGroup = function(f301_arg0, f301_arg1)
	Engine[@"hash_435AD8B977F95967"](CoD.perController[f301_arg1].selectedLayerIndex)
end
CoD.CraftUtility.EmblemEditor_StoreSelectedLayer = function(f302_arg0, f302_arg1)
	Engine[@"hash_585A2C014C85AE41"](CoD.GetCustomization(f302_arg1, "type"), CoD.perController[f302_arg1].selectedLayerIndex)
end
CoD.CraftUtility.EmblemEditor_RestoreSelectedLayer = function(f303_arg0, f303_arg1)
	Engine[@"hash_688075F1D6B9FBA4"](CoD.GetCustomization(f303_arg1, "type"), CoD.perController[f303_arg1].selectedLayerIndex)
end
CoD.CraftUtility.EmblemEditor_StoreAllChanges = function(f304_arg0, f304_arg1)
	Engine[@"hash_7E79D91C469D37C8"](CoD.GetCustomization(f304_arg1, "type"))
end
CoD.CraftUtility.EmblemEditor_RevertAllChanges = function(f305_arg0, f305_arg1)
	Engine[@"hash_7ACA6DEA33BD835"](CoD.GetCustomization(f305_arg1, "type"))
end
CoD.CraftUtility.EmblemEditor_SaveSelectedGroup = function(f306_arg0, f306_arg1, f306_arg2, f306_arg3)
	local f306_local0 = Engine.GetModelValue(Engine.GetModel(f306_arg3, "emblemTextEntry"))
	local f306_local1 = Engine.GetModel(f306_arg3, "name")
	CoD.CraftUtility.Groups.Upload(f306_arg2, f306_arg3)
	CoD.CraftUtility.Groups.ParseDDL(f306_arg2)
	local f306_local2 = GoBack(f306_arg0, f306_arg2)
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f306_local2, f306_arg2)
	ClearMenuSavedState(f306_local2, f306_arg2)
end
CoD.CraftUtility.Emblems_SetIconOld = function(f307_arg0, f307_arg1, f307_arg2)
	local f307_local0 = CoD.SafeGetModelValue(f307_arg1:getModel(), "iconID")
	if f307_local0 then
		Engine.SetEmblemIconOld(f307_arg2, f307_local0)
		local f307_local1 = LUI.getTableFromPath("tabList.Tabs.grid.activeWidget", f307_arg0)
		if f307_local1 then
			local f307_local2 = f307_local1:getModel(f307_arg2, "breadcrumbCount")
			if f307_local2 then
				Engine.SetModelValue(f307_local2, math.max(0, Engine.GetModelValue(f307_local2) - 1))
			end
		end
	end
end
CoD.CraftUtility.Emblems_SetEmblemOld = function(f308_arg0, f308_arg1, f308_arg2)
	local f308_local0 = CoD.SafeGetModelValue(f308_arg1:getModel(), "emblemIndex")
	local f308_local1 = CoD.SafeGetModelValue(f308_arg1:getModel(), "storageFileType")
	if f308_local0 and f308_local1 then
		local f308_local2 = CoD.CraftUtility.Emblems.GetEmblemBreadcrumbRoot(f308_arg2, f308_local0, f308_local1)
		if f308_local2 then
			f308_local2:set(1)
			local f308_local3 = LUI.getTableFromPath("tabList.Tabs.grid.activeWidget", f308_arg0)
			if f308_local3 then
				local f308_local4 = f308_local3:getModel(f308_arg2, "breadcrumbCount")
				if f308_local4 then
					Engine.SetModelValue(f308_local4, math.max(0, Engine.GetModelValue(f308_local4) - 1))
				end
			end
		end
	end
end
CoD.CraftUtility.Emblems_SetMaterialOld = function(f309_arg0, f309_arg1, f309_arg2)
	local f309_local0 = CoD.SafeGetModelValue(f309_arg1:getModel(), "materialID")
	if f309_local0 then
		local f309_local1 = CoD.CraftUtility.Emblems.GetEmblemMaterialBreadcrumbRoot(f309_arg2, f309_local0)
		if f309_local1 then
			f309_local1:set(1)
			local f309_local2 = LUI.getTableFromPath("materialSwatch.tabList.Tabs.grid.activeWidget", f309_arg0)
			if f309_local2 then
				local f309_local3 = f309_local2:getModel(f309_arg2, "breadcrumbCount")
				if f309_local3 then
					Engine.SetModelValue(f309_local3, math.max(0, Engine.GetModelValue(f309_local3) - 1))
				end
			end
		end
	end
end
CoD.CraftUtility.EmblemChooseIcon_ClearDecalGroup = function(f310_arg0, f310_arg1, f310_arg2)
	if CoD.perController[f310_arg2].selectedDecalGroupModel then
		local f310_local0 = Engine.GetModelValue(Engine.GetModel(CoD.perController[f310_arg2].selectedDecalGroupModel, "emblemIndex"))
		CoD.CraftUtility.Groups.Clear(f310_arg2, f310_local0)
		Engine[@"hash_36A9513413264177"](f310_arg2, f310_local0)
		CoD.CraftUtility.Groups.ParseDDL(f310_arg2, Enum.StorageFileType[@"hash_15DB8C62CF926911"])
	end
end
CoD.CraftUtility.EmblemChooseIcon_OpenRenameGroupPopup = function(f311_arg0, f311_arg1, f311_arg2)
	CoD.OverlayUtility.CreateOverlay(f311_arg2, f311_arg0, "DecalGroupRename", f311_arg2, CoD.perController[f311_arg2].selectedDecalGroupModel)
end
CoD.CraftUtility.EmblemChooseIcon_RenameDecal = function(f312_arg0, f312_arg1, f312_arg2)
	if CoD.perController[f312_arg2].selectedDecalGroupModel then
		local f312_local0 = CoD.perController[f312_arg2].selectedDecalGroupModel
		local f312_local1 = f312_local0.emblemIndex:get()
		local f312_local2 = f312_local0.emblemTextEntry:get()
		f312_local0.name:set(f312_local2)
		CoD.CraftUtility.Groups.Rename(f312_arg0, f312_arg2, f312_local1, f312_local2)
	end
end
CoD.CraftUtility.EmblemChooseIcon_Cleanup = function(f313_arg0, f313_arg1)
	CoD.perController[f313_arg1].selectedDecalGroupModel = nil
end
CoD.CraftUtility.EmblemChooseIcon_UpdateDecalList = function(f314_arg0)
	local f314_local0 = f314_arg0.decalGroupList:updateDatasource()
end
CoD.CraftUtility.EmblemChooseIcon_UpdateLayerCount = function(f315_arg0, f315_arg1, f315_arg2)
	return f315_arg1.layerNumber:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/craft_layers", Engine.GetUsedLayerCount(f315_arg2, Enum.CustomizationType[@"hash_1AB847C1A0E71617"], Enum.CustomizationTypeLayerCount[@"customization_type_emblem_max_layers"])))
end
CoD.CraftUtility.EmblemChooseIcon_InitLayerCount = function(f316_arg0, f316_arg1, f316_arg2)
	return f316_arg1.layerNumber:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/craft_layers", 0))
end
CoD.CraftUtility.EmblemChooseIcon_PrepareGroupIndex = function(f317_arg0, f317_arg1)
	if CoD.perController[f317_arg1].selectedLayerIndex then
		local f317_local0 = Engine.GetSelectedLayerData(f317_arg1, CoD.perController[f317_arg1].selectedLayerIndex, CoD.GetCustomization(f317_arg1, "type"))
		if f317_local0.isGrouped == true then
			CoD.perController[f317_arg1].selectEmblemGroupIndex = f317_local0.groupIndex
		else
			CoD.perController[f317_arg1].selectEmblemGroupIndex = nil
		end
	end
end
CoD.CraftUtility.EmblemChooseIcon_SelectionRejected = function(f318_arg0, f318_arg1, f318_arg2)
	local f318_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f318_arg2, "addDecalMode")
	local f318_local1 = CoD.GetCustomization(f318_arg2, "type")
	if CoD.perController[f318_arg2].selectedLayerIconID == CoD.CraftUtility.EMBLEM_INVALID_ID then
		Engine[@"hash_6F71ED1E6B331311"](f318_local1)
	elseif f318_local0 == CoD.CraftUtility.EMBLEM_ADDDECAL.INSERT then
		Engine[@"emblemcutlayer"](f318_local1)
	else
		Engine[@"hash_6F71ED1E6B331311"](f318_local1)
		CoD.CraftUtility.EmblemEditor_RestoreSelectedLayer(f318_arg0, f318_arg2)
	end
	CoD.CraftUtility.SetEmblemEditorProperties(f318_arg2, CoD.CraftUtility.EMBLEM_ADDDECAL.REPLACE, "addDecalMode")
	CoD.CraftUtility.SetEmblemEditorProperties(f318_arg2, Enum.CustomizationEditorMode[@"customization_editor_mode_browse"], "editorMode")
end
CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted = function(f319_arg0, f319_arg1, f319_arg2)
	if CoD.CraftUtility.GetEmblemEditorProperties(f319_arg2, "addDecalMode") == CoD.CraftUtility.EMBLEM_ADDDECAL.INSERT and CoD.perController[f319_arg2].selectedLayerIndex + 1 < CoD.perController[f319_arg2].totalLayers then
		local f319_local0 = CoD.GetCustomization(f319_arg2, "type")
	end
	CoD.CraftUtility.SetEmblemEditorProperties(f319_arg2, CoD.CraftUtility.EMBLEM_ADDDECAL.REPLACE, "addDecalMode")
	CoD.CraftUtility.EmblemChooseIcon_PrepareGroupIndex(f319_arg0, f319_arg2)
	local f319_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f319_arg2, "selectedDecalID")
	if f319_local0 and CoD.perController[f319_arg2].selectedEmblemTabStorageType == Enum.StorageFileType[@"hash_36A0A3D1062F156F"] then
		local f319_local1 = CoD.BlackMarketTableUtility.LootInfoLookup(f319_arg2, CoD.BlackMarketUtility.GetLootDecalName(f319_arg2, f319_local0), nil)
		local f319_local2 = CoD.GetCustomization(f319_arg2, "type")
		if f319_local1 and f319_local1.isLoot and f319_local1.itemId and f319_local2 then
			local f319_local3 = Engine[0xDE279ECDDDD966]
			local f319_local4 = f319_arg2
			local f319_local5 = 0x37D117732D0177
			local f319_local6 = {
				loot_id = f319_local1.itemId,
			}
			local f319_local7
			if f319_local2 == Enum.CustomizationType[@"customization_type_emblem"] then
				f319_local7 = CoD.CraftUtility.USE_STICKER_IN.EMBLEM_EDITOR
				if not f319_local7 then
				else
					f319_local6.used_in = f319_local7
					f319_local3(f319_local4, f319_local5, f319_local6)
				end
			end
			f319_local7 = CoD.CraftUtility.USE_STICKER_IN.PAINTJOB_EDITOR
		end
	end
end
CoD.CraftUtility.EmblemChooseIcon_SelectionChanged = function(f320_arg0, f320_arg1, f320_arg2)
	local f320_local0 = CoD.GetCustomization(f320_arg2, "type")
	if CoD.CraftUtility.EmblemChooseIcon_IsDecalGroupCategorySelected(f320_arg0, f320_arg2) then
		if CoD.CraftUtility.EmblemChooseIcon_CanFitSelectedDecalGroup(f320_arg0, f320_arg2) and CoD.CraftUtility.EmblemChooseIcon_IsGroupSlotAvailable(f320_arg0, f320_arg2) then
			Engine[@"hash_754C286FA1FD349D"](CoD.perController[f320_arg2].selectedLayerIndex, f320_local0)
		end
	else
		if CoD.CraftUtility.GetEmblemEditorProperties(f320_arg2, "selectedDecalID") ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
			Engine[@"hash_6F71ED1E6B331311"](f320_local0)
		end
		local f320_local1 = Engine.GetModelValue(f320_arg1:getModel(f320_arg2, "iconID"))
		Engine[@"emblemsetselectedlayericonid"](f320_local1)
		CoD.CraftUtility.SetEmblemEditorProperties(f320_arg2, f320_local1, "selectedDecalID")
	end
end
CoD.CraftUtility.EmblemChooseIcon_SelectedClassified = function(f321_arg0, f321_arg1)
	local f321_local0 = CoD.GetCustomization(f321_arg1, "type")
	if CoD.CraftUtility.GetEmblemEditorProperties(f321_arg1, "selectedDecalID") ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
		Engine[@"hash_6F71ED1E6B331311"](f321_local0)
	end
	local f321_local1 = CoD.CraftUtility.EMBLEM_INVALID_ID
	Engine[@"emblemsetselectedlayericonid"](f321_local1)
	CoD.CraftUtility.SetEmblemEditorProperties(f321_arg1, f321_local1, "selectedDecalID")
end
CoD.CraftUtility.CraftEditor_RestoreDecalCategory = function(f322_arg0, f322_arg1, f322_arg2)
	CoD.perController[f322_arg2].selectedDecalCategory = CoD.CraftUtility.EmblemDecalGroupCategory
end
CoD.CraftUtility.EmblemChooseIcon_TabChanged = function(f323_arg0, f323_arg1, f323_arg2)
	CoD.perController[f323_arg2].selectedDecalCategory = f323_arg1.tabCategory
	if CoD.CraftUtility.Groups.IsDecalGroupSelected(CoD.perController[f323_arg2].selectedDecalCategory) then
		CoD.CraftUtility.Groups.ParseDDL(f323_arg2)
	end
end
CoD.CraftUtility.EmblemChooseIcon_DecalTypeChanged = function(f324_arg0, f324_arg1, f324_arg2)
	CoD.perController[f324_arg2].selectedDecalCategory = f324_arg1.category
	if CoD.CraftUtility.Groups.IsDecalGroupSelected(CoD.perController[f324_arg2].selectedDecalCategory) then
		CoD.CraftUtility.Groups.ParseDDL(f324_arg2)
	end
end
CoD.CraftUtility.EmblemChooseIcon_SetPreviewDecalCamera = function(f325_arg0, f325_arg1, f325_arg2)
	CoD.CraftUtility.DisplayWeaponInPaintshop(f325_arg2, "paintshop_preview_" .. CoD.CraftUtility.PaintshopView[CoD.perController[f325_arg2].viewIndex].view_name)
end
CoD.CraftUtility.EmblemChooseIcon_RevertPreviewDecalCamera = function(f326_arg0, f326_arg1, f326_arg2)
	CoD.CraftUtility.DisplayWeaponInPaintshop(f326_arg2, CoD.CraftUtility.PaintshopView[CoD.perController[f326_arg2].viewIndex].view_name)
end
CoD.CraftUtility.EmblemChooseMaterial_TabChanged = function(f327_arg0, f327_arg1, f327_arg2)
	if CoD.perController[f327_arg2].selectedMaterialCategory == nil then
		CoD.perController[f327_arg2].selectedMaterialCategory = f327_arg1.filter
	elseif CoD.perController[f327_arg2].selectedMaterialCategory ~= f327_arg1.filter then
		CoD.perController[f327_arg2].selectedMaterialCategory = f327_arg1.filter
		f327_arg0.materialSwatch:updateDataSource()
	end
end
CoD.CraftUtility.EmblemChooseMaterial_MaterialsLeft = function(f328_arg0, f328_arg1, f328_arg2)
	if f328_arg0.materialSwatch then
		if f328_arg0.materialSwatch.itemCount < f328_arg0.materialSwatch.hCount then
			return false
		elseif f328_arg0.materialSwatch.itemCount < f328_arg0.materialSwatch.previousStartColumn + f328_arg0.materialSwatch.hCount then
			return false
		end
	end
	return true
end
CoD.CraftUtility.EmblemChooseMaterial_SelectionChanged = function(f329_arg0, f329_arg1, f329_arg2)
	if CoD.ModelUtility.IsSelfModelValueTrue(f329_arg1, f329_arg2, "isBMClassified") then
		return true
	end
	local f329_local0 = f329_arg1:getModel(f329_arg2, "materialID")
	if f329_local0 then
		Engine[@"emblemsetselecteddecalmaterialid"](f329_arg2, Engine.GetModelValue(f329_local0))
	end
end
CoD.CraftUtility.EmblemChooseMaterial_UpdateMaterialAngleByStep = function(f330_arg0, f330_arg1, f330_arg2, f330_arg3)
	Engine[@"hash_711A6E122F4D53CD"](f330_arg3, f330_arg2)
end
CoD.CraftUtility.EmblemChooseMaterial_ToggleScaleMode = function(f331_arg0, f331_arg1, f331_arg2)
	local f331_local0
	if Engine.GetLayerMaterialScaleMode(f331_arg2) == Enum.CustomizationScaleType[@"customization_scale_type_fixed"] then
		f331_local0 = Enum.CustomizationScaleType[@"customization_scale_type_free"]
	else
		f331_local0 = Enum.CustomizationScaleType[@"customization_scale_type_fixed"]
	end
	CoD.CraftUtility.SetEmblemEditorProperties(f331_arg2, f331_local0, "materialScaleMode")
	Engine[@"hash_3BBCA32C957C5A85"](f331_local0)
end
CoD.CraftUtility.EmblemChooseColor_ToggleBlend = function(f332_arg0, f332_arg1, f332_arg2)
	Engine[@"emblemtogglecolorblend"](f332_arg2, CoD.GetCustomization(f332_arg2, "type"))
end
CoD.CraftUtility.EmblemChooseColor_ClearSelectedLayerMaterial = function(f333_arg0, f333_arg1, f333_arg2)
	Engine[@"emblemclearselectedlayermaterialid"]()
end
CoD.CraftUtility.EmblemChooseColor_SelectionChanged = function(f334_arg0, f334_arg1, f334_arg2)
	local f334_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f334_arg2, "isGradientMode")
	local f334_local1 = CoD.CraftUtility.GetEmblemEditorProperties(f334_arg2, "colorNum")
	local f334_local2 = CoD.ColorUtility.NormalizeColor(Engine.GetModelValue(f334_arg1:getModel(f334_arg2, "color")))
	if f334_local0 == 0 then
		Engine[@"emblemsetlayercolor"](Enum.CustomizationColorNum[@"customization_color_none"], f334_local2[1], f334_local2[2], f334_local2[3])
		Engine[@"emblemcleargradient"](f334_arg2)
	elseif f334_local0 == 1 then
		if f334_local1 == Enum.CustomizationColorNum[@"customization_color_0"] then
			Engine[@"emblemsetlayercolor"](f334_local1, f334_local2[1], f334_local2[2], f334_local2[3])
			if PropertyIsTrue(f334_arg0, "isColor1NoColor") then
				Engine[@"emblemsetlayercolor"](Enum.CustomizationColorNum[@"customization_color_1"], f334_local2[1], f334_local2[2], f334_local2[3])
			end
		elseif f334_local1 == Enum.CustomizationColorNum[@"customization_color_1"] then
			Engine[@"emblemsetlayercolor"](f334_local1, f334_local2[1], f334_local2[2], f334_local2[3])
			if PropertyIsTrue(f334_arg0, "isColor0NoColor") then
				Engine[@"emblemsetlayercolor"](Enum.CustomizationColorNum[@"customization_color_0"], f334_local2[1], f334_local2[2], f334_local2[3])
			end
		end
	end
end
CoD.CraftUtility.EmblemChooseColor_SelectNoColor = function(f335_arg0, f335_arg1, f335_arg2)
	local f335_local0 = DataSources.EmblemSelectedLayerNoColor.getModel(f335_arg2)
	if f335_local0 ~= nil then
		local f335_local1 = CoD.ColorUtility.NormalizeColor(Engine.GetModelValue(Engine.GetModel(f335_local0, "color")))
		f335_arg0.opacity0 = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f335_arg2), "Emblem.EmblemSelectedLayerProperties.opacity0")) / 100
		f335_arg0.opacity1 = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f335_arg2), "Emblem.EmblemSelectedLayerProperties.opacity1")) / 100
		local f335_local2 = CoD.CraftUtility.GetEmblemEditorProperties(f335_arg2, "colorNum")
		Engine[@"emblemsetlayercolor"](f335_local2, f335_local1[1], f335_local1[2], f335_local1[3])
		Engine[@"hash_6459D9FB14BA721B"](f335_arg2, f335_local2, -1)
	end
end
CoD.CraftUtility.EmblemChooseColor_NoColorLoseFocus = function(f336_arg0, f336_arg1, f336_arg2)
	local f336_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f336_arg2, "colorNum")
	if not PropertyIsTrue(f336_arg0, "isColor0NoColor") and f336_local0 == Enum.CustomizationColorNum[@"customization_color_0"] then
		if f336_arg0.opacity0 ~= nil and f336_arg0.opacity0 ~= 0 then
			Engine[@"hash_6459D9FB14BA721B"](f336_arg2, f336_local0, f336_arg0.opacity0)
		else
			Engine[@"hash_6459D9FB14BA721B"](f336_arg2, f336_local0, 1)
		end
	elseif not PropertyIsTrue(f336_arg0, "isColor1NoColor") and f336_local0 == Enum.CustomizationColorNum[@"customization_color_1"] then
		if f336_arg0.opacity1 ~= nil and f336_arg0.opacity1 ~= 0 then
			Engine[@"hash_6459D9FB14BA721B"](f336_arg2, f336_local0, f336_arg0.opacity1)
		else
			Engine[@"hash_6459D9FB14BA721B"](f336_arg2, f336_local0, 1)
		end
	end
end
CoD.CraftUtility.EmblemEditor_UpdateContainerStateForMode = function(f337_arg0, f337_arg1, f337_arg2, f337_arg3)
	local f337_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f337_arg1, "colorContainerState")
	if f337_arg3 == 1 then
		CoD.CraftUtility.SetEmblemEditorProperties(f337_arg1, Enum.CustomizationColorMode[@"customization_color_mode_none"], "colorMode")
		if f337_arg2 == Enum.CustomizationColorMode[@"customization_color_mode_solid"] then
			if f337_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_SWATCH then
				CoD.CraftUtility.SetEmblemEditorProperties(f337_arg1, CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_GRADIENT, "colorContainerState")
				CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorSwatchContainer, f337_arg0.colorGradientContainer)
				CoD.CraftUtility.EmblemGradient_SetFocusToLastUsedColor(f337_arg0, f337_arg1)
			elseif f337_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_MIXER then
				CoD.CraftUtility.SetEmblemEditorProperties(f337_arg1, CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_SWATCH, "colorContainerState")
				CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorMixerContainer, f337_arg0.colorGradientSwatchContainer)
				if f337_arg0.colorGradientSwatchContainer then
					CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorGradientSwatchContainer, f337_arg0.colorGradientSwatchContainer.lastSavedColor)
				end
			end
		elseif f337_arg2 == Enum.CustomizationColorMode[@"customization_color_mode_mixer"] then
			if f337_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_MIXER then
				CoD.CraftUtility.SetEmblemEditorProperties(f337_arg1, CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_GRADIENT, "colorContainerState")
				CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorMixerContainer, f337_arg0.colorGradientContainer)
				CoD.CraftUtility.EmblemGradient_SetFocusToLastUsedColor(f337_arg0, f337_arg1)
			elseif f337_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_SWATCH then
				CoD.CraftUtility.SetEmblemEditorProperties(f337_arg1, CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_MIXER, "colorContainerState")
				CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorGradientSwatchContainer, f337_arg0.colorGradientMixerContainer)
			end
		end
	elseif f337_arg2 == Enum.CustomizationColorMode[@"customization_color_mode_solid"] then
		if f337_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_GRADIENT then
			CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorGradientContainer, f337_arg0.colorSwatchContainer)
		else
			CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorSwatchContainer, f337_arg0.colorSwatchContainer)
		end
		if f337_arg0.colorSwatchContainer then
			CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorSwatchContainer, f337_arg0.colorSwatchContainer.lastSavedColor)
		end
		CoD.CraftUtility.SetEmblemEditorProperties(f337_arg1, CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_SWATCH, "colorContainerState")
	elseif f337_arg2 == Enum.CustomizationColorMode[@"customization_color_mode_mixer"] then
		CoD.CraftUtility.SetEmblemEditorProperties(f337_arg1, CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_MIXER, "colorContainerState")
		if f337_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_SWATCH then
			CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorGradientSwatchContainer, f337_arg0.colorMixerContainer)
		else
			CoD.SwapFocusableElements(f337_arg1, f337_arg0.colorSwatchContainer, f337_arg0.colorMixerContainer)
		end
	end
end
CoD.CraftUtility.InitializeColorContainerFromSelection = function(f338_arg0, f338_arg1)
	local f338_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f338_arg1, "isGradientMode")
	CoD.CraftUtility.SetEmblemEditorProperties(f338_arg1, CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_SWATCH, "colorContainerState")
	CoD.CraftUtility.EmblemEditor_UpdateContainerStateForMode(f338_arg0, f338_arg1, Enum.CustomizationColorMode[@"customization_color_mode_solid"], f338_local0)
end
CoD.CraftUtility.EmblemChooseColor_ToggleColorMode = function(f339_arg0, f339_arg1, f339_arg2, f339_arg3)
	local f339_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f339_arg2, "colorMode")
	local f339_local1 = CoD.CraftUtility.GetEmblemEditorProperties(f339_arg2, "isGradientMode")
	local f339_local2 = CoD.CraftUtility.GetSelectedEmblemColor(f339_arg2)
	if f339_local2 ~= nil then
		EmblemChooseColor_SetShaderParams(f339_arg2, EmblemChooseColor_GetColorMixerElement(f339_arg0, f339_arg2, f339_arg3), f339_local2)
	end
	if f339_local0 == Enum.CustomizationColorMode[@"customization_color_mode_mixer"] then
		CoD.CraftUtility.EmblemEditor_UpdateContainerStateForMode(f339_arg3, f339_arg2, Enum.CustomizationColorMode[@"customization_color_mode_solid"], f339_local1)
		CoD.CraftUtility.SetEmblemEditorProperties(f339_arg2, Enum.CustomizationColorMode[@"customization_color_mode_solid"], "colorMode")
	elseif f339_local0 == Enum.CustomizationColorMode[@"customization_color_mode_solid"] then
		CoD.CraftUtility.SetEmblemNoColorDataModel(f339_arg2)
		local f339_local3 = CoD.CraftUtility.GetEmblemEditorProperties(f339_arg2, "isColor0NoColor")
		local f339_local4 = CoD.CraftUtility.GetEmblemEditorProperties(f339_arg2, "isColor1NoColor")
		local f339_local5 = CoD.CraftUtility.GetEmblemEditorProperties(f339_arg2, "colorNum")
		if f339_local3 == 1 and f339_local5 == Enum.CustomizationColorNum[@"customization_color_0"] then
			Engine[@"emblemsetlayercolor"](f339_local5, 1, 1, 1)
			Engine[@"hash_6459D9FB14BA721B"](f339_arg2, f339_local5, 1)
		elseif f339_local4 == 1 and f339_local5 == Enum.CustomizationColorNum[@"customization_color_1"] then
			Engine[@"emblemsetlayercolor"](f339_local5, 1, 1, 1)
			Engine[@"hash_6459D9FB14BA721B"](f339_arg2, f339_local5, 1)
		end
		EmblemChooseColor_SetupSelectedLayerColorModel(f339_arg2)
		CoD.CraftUtility.EmblemEditor_UpdateContainerStateForMode(f339_arg3, f339_arg2, Enum.CustomizationColorMode[@"customization_color_mode_mixer"], f339_local1)
		CoD.CraftUtility.SetEmblemEditorProperties(f339_arg2, Enum.CustomizationColorMode[@"customization_color_mode_mixer"], "colorMode")
	end
	EmblemChooseColor_SetupSelectedLayerColorModel(f339_arg2)
end
CoD.CraftUtility.EmblemChooseColor_ToggleGradientMode = function(f340_arg0, f340_arg1, f340_arg2, f340_arg3)
	local f340_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f340_arg2, "isGradientMode")
	local f340_local1 = CoD.CraftUtility.GetEmblemEditorProperties(f340_arg2, "colorMode")
	f340_arg3.colorGradientContainer:setState(f340_arg2, "DefaultState")
	if f340_local0 == 1 then
		CoD.CraftUtility.SetEmblemEditorProperties(f340_arg2, 0, "isGradientMode")
		CoD.CraftUtility.SetEmblemNoColorDataModel(f340_arg2)
		local f340_local2 = CoD.CraftUtility.GetEmblemEditorProperties(f340_arg2, "isColor0NoColor")
		if f340_local2 ~= nil and f340_local2 == 1 then
			Engine[@"emblemsetlayercolor"](Enum.CustomizationColorNum[@"customization_color_0"], 1, 1, 1)
			Engine[@"hash_6459D9FB14BA721B"](f340_arg2, CoD.CraftUtility.GetEmblemEditorProperties(f340_arg2, "colorNum"), 1)
		end
		EmblemChooseColor_SetupSelectedLayerColorModel(f340_arg2)
		CoD.CraftUtility.SetEmblemEditorProperties(f340_arg2, Enum.CustomizationColorNum[@"customization_color_none"], "colorNum")
		CoD.CraftUtility.SetEmblemEditorProperties(f340_arg2, Enum.CustomizationColorMode[@"customization_color_mode_solid"], "colorMode")
		CoD.CraftUtility.EmblemEditor_UpdateContainerStateForMode(f340_arg3, f340_arg2, Enum.CustomizationColorMode[@"customization_color_mode_solid"], 0)
	elseif f340_local0 == 0 then
		CoD.CraftUtility.SetEmblemEditorProperties(f340_arg2, 1, "isGradientMode")
		Engine[@"hash_6459D9FB14BA721B"](f340_arg2, Enum.CustomizationColorNum[@"customization_color_1"], -1)
		if f340_local1 == Enum.CustomizationColorMode[@"customization_color_mode_mixer"] then
			CoD.CraftUtility.EmblemEditor_UpdateContainerStateForMode(f340_arg3, f340_arg2, Enum.CustomizationColorMode[@"customization_color_mode_mixer"], 1)
		else
			CoD.CraftUtility.EmblemEditor_UpdateContainerStateForMode(f340_arg3, f340_arg2, Enum.CustomizationColorMode[@"customization_color_mode_solid"], 1)
		end
	end
	EmblemChooseColor_SetupSelectedLayerColorModel(f340_arg2)
	CoD.CraftUtility.EmblemGradient_UpdateSliders(f340_arg2, f340_arg3)
end
CoD.CraftUtility.EmblemChooseColor_DecrementColorComponent = function(f341_arg0, f341_arg1, f341_arg2, f341_arg3)
	local f341_local0 = f341_arg1:getModel(f341_arg2, f341_arg3)
	EmblemChooseColor_ModifyColorModelValue(f341_local0, -1)
	EmblemChooseColor_SetBarProperties(f341_arg0, f341_arg1, f341_local0, f341_arg2)
end
CoD.CraftUtility.EmblemChooseColor_IncrementColorComponent = function(f342_arg0, f342_arg1, f342_arg2, f342_arg3)
	local f342_local0 = f342_arg1:getModel(f342_arg2, f342_arg3)
	EmblemChooseColor_ModifyColorModelValue(f342_local0, 1)
	EmblemChooseColor_SetBarProperties(f342_arg0, f342_arg1, f342_local0, f342_arg2)
end
CoD.CraftUtility.EmblemChooseColor_SetColorComponent = function(f343_arg0, f343_arg1, f343_arg2, f343_arg3, f343_arg4)
	local f343_local0 = f343_arg1:getModel(f343_arg2, f343_arg3)
	EmblemChooseColor_SetColorModelValue(f343_local0, f343_arg4)
	EmblemChooseColor_SetBarProperties(f343_arg0, f343_arg1, f343_local0, f343_arg2)
end
CoD.CraftUtility.EmblemChooseColor_UpdateOpacityByStep = function(f344_arg0, f344_arg1, f344_arg2, f344_arg3, f344_arg4)
	if not CoD.CraftUtility.IsSelectedColorEmpty(f344_arg1, f344_arg3) then
		Engine[@"hash_6459D9FB14BA721B"](f344_arg3, CoD.CraftUtility.GetEmblemEditorProperties(f344_arg3, "colorNum"), f344_arg2)
		CoD.CraftUtility.SetEmblemNoColorDataModel(f344_arg3)
		CoD.CraftUtility.EmblemGradient_UpdateSliders(f344_arg3, f344_arg4)
	end
end
CoD.CraftUtility.EmblemChooseColor_SetOpacity = function(f345_arg0, f345_arg1, f345_arg2, f345_arg3, f345_arg4, f345_arg5)
	local f345_local0 = false
	if f345_arg2 == Enum.CustomizationColorNum[@"customization_color_0"] then
		f345_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f345_arg4, "isColor0NoColor") == 1
	elseif f345_arg2 == Enum.CustomizationColorNum[@"customization_color_1"] then
		f345_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f345_arg4, "isColor1NoColor") == 1
	end
	if not f345_local0 then
		Engine[@"hash_26917B85E01FBFC3"](f345_arg4, f345_arg2, f345_arg3)
		CoD.CraftUtility.SetEmblemNoColorDataModel(f345_arg4)
		CoD.CraftUtility.EmblemGradient_UpdateSliders(f345_arg4, f345_arg5)
	end
end
CoD.CraftUtility.EmblemChooseColor_UpdateBothColorOpacity = function(f346_arg0, f346_arg1, f346_arg2, f346_arg3)
	if Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f346_arg3), "Emblem.EmblemSelectedLayerProperties.max_opacity")) + f346_arg2 <= 100 then
		Engine[@"hash_6459D9FB14BA721B"](f346_arg3, Enum.CustomizationColorNum[@"customization_color_none"], f346_arg2)
	end
end
CoD.CraftUtility.EmblemGradient_Color0GainFocus = function(f347_arg0, f347_arg1, f347_arg2)
	if CoD.CraftUtility.GetEmblemEditorProperties(f347_arg2, "colorMode") == Enum.CustomizationColorMode[@"customization_color_mode_none"] then
		CoD.CraftUtility.SetEmblemEditorProperties(f347_arg2, Enum.CustomizationColorNum[@"customization_color_0"], "colorNum")
	end
end
CoD.CraftUtility.EmblemGradient_Color1GainFocus = function(f348_arg0, f348_arg1, f348_arg2)
	if CoD.CraftUtility.GetEmblemEditorProperties(f348_arg2, "colorMode") == Enum.CustomizationColorMode[@"customization_color_mode_none"] then
		CoD.CraftUtility.SetEmblemEditorProperties(f348_arg2, Enum.CustomizationColorNum[@"customization_color_1"], "colorNum")
	end
end
CoD.CraftUtility.EmblemGradient_ColorGradientSliderGainFocus = function(f349_arg0, f349_arg1, f349_arg2)
	if CoD.CraftUtility.GetEmblemEditorProperties(f349_arg2, "colorMode") == Enum.CustomizationColorMode[@"customization_color_mode_none"] then
		CoD.CraftUtility.SetEmblemEditorProperties(f349_arg2, Enum.CustomizationColorNum[@"customization_color_gradient"], "colorNum")
	end
end
CoD.CraftUtility.EmblemGradient_ShowSwatchContainer = function(f350_arg0, f350_arg1, f350_arg2, f350_arg3)
	local f350_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f350_arg3, "isColor0NoColor")
	local f350_local1 = CoD.CraftUtility.GetEmblemEditorProperties(f350_arg3, "isColor1NoColor")
	local f350_local2 = CoD.CraftUtility.GetEmblemEditorProperties(f350_arg3, "colorNum")
	CoD.CraftUtility.SetEmblemEditorProperties(f350_arg3, Enum.CustomizationColorMode[@"customization_color_mode_solid"], "colorMode")
	EmblemGradient_SetupSwatchLastSavedColor(f350_arg0, f350_arg2, f350_arg3)
	local f350_local3 = CoD.CraftUtility.GetEmblemEditorProperties(f350_arg3, "colorContainerState")
	CoD.CraftUtility.SetEmblemEditorProperties(f350_arg3, CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_SWATCH, "colorContainerState")
	CoD.SwapFocusableElements(f350_arg3, f350_arg2.colorGradientContainer, f350_arg2.colorGradientSwatchContainer)
	if f350_local0 == 1 and f350_local2 == Enum.CustomizationColorNum[@"customization_color_0"] then
		CoD.SwapFocusableElements(f350_arg3, f350_arg2.colorGradientSwatchContainer, f350_arg2.colorGradientSwatchContainer.noColor)
	elseif f350_local1 == 1 and f350_local2 == Enum.CustomizationColorNum[@"customization_color_1"] then
		CoD.SwapFocusableElements(f350_arg3, f350_arg2.colorGradientSwatchContainer, f350_arg2.colorGradientSwatchContainer.noColor)
	elseif f350_arg2.colorGradientSwatchContainer then
		CoD.SwapFocusableElements(f350_arg3, f350_arg2.colorGradientSwatchContainer, f350_arg2.colorGradientSwatchContainer.lastSavedColor)
	end
end
CoD.CraftUtility.EmblemGradient_SetFocusToLastUsedColor = function(f351_arg0, f351_arg1)
	if f351_arg0.colorGradientContainer then
		if CoD.CraftUtility.GetEmblemEditorProperties(f351_arg1, "colorNum") == Enum.CustomizationColorNum[@"customization_color_1"] then
			CoD.SwapFocusableElements(f351_arg1, f351_arg0.colorGradientContainer, f351_arg0.colorGradientContainer.gradientColor1)
		else
			CoD.SwapFocusableElements(f351_arg1, f351_arg0.colorGradientContainer, f351_arg0.colorGradientContainer.gradientColor0)
		end
	end
end
CoD.CraftUtility.EmblemGradient_BackFromColorPicker = function(f352_arg0, f352_arg1, f352_arg2, f352_arg3)
	local f352_local0 = CoD.CraftUtility.GetEmblemEditorProperties(f352_arg3, "colorContainerState")
	EmblemChooseColor_SetupSelectedLayerColorModel(f352_arg3)
	if f352_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_SWATCH then
		CoD.CraftUtility.SetEmblemEditorProperties(f352_arg3, CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_GRADIENT, "colorContainerState")
		CoD.SwapFocusableElements(f352_arg3, f352_arg2.colorGradientSwatchContainer, f352_arg2.colorGradientContainer)
	elseif f352_local0 == CoD.CraftUtility.COLOR_CONTAINER_STATE.GRADIENT_MIXER then
		CoD.CraftUtility.SetEmblemEditorProperties(f352_arg3, CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_GRADIENT, "colorContainerState")
		CoD.SwapFocusableElements(f352_arg3, f352_arg2.colorGradientSwatchContainer, f352_arg2.colorGradientContainer)
	end
	CoD.CraftUtility.EmblemGradient_SetFocusToLastUsedColor(f352_arg2, f352_arg3)
	CoD.CraftUtility.SetEmblemEditorProperties(f352_arg3, Enum.CustomizationColorMode[@"customization_color_mode_none"], "colorMode")
	CoD.CraftUtility.EmblemGradient_UpdateSliders(f352_arg3, f352_arg2)
end
CoD.CraftUtility.EmblemGradient_UpdateSliders = function(f353_arg0, f353_arg1)
	local f353_local0 = Engine.GetModelForController(f353_arg0)
	if f353_local0["Emblem.EmblemSelectedLayerProperties.gradient_type"]:get() == Enum.CustomizationGradientType[@"hash_1A7C637A09DA3D16"] then
		local f353_local1 = f353_arg1.colorGradientContainer.gradientSliderWidget.HardnessSlider
		Engine[@"hash_173F93E76ED5920C"](f353_arg0, 0)
		EmblemGradient_UpdateSliderVisuals(f353_arg0, f353_local1, Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f353_arg0), "Emblem.EmblemSelectedLayerProperties.gradient_fill")) / CoD.CraftUtility.EMBLEM_MAX_GRADIENT_SLIDER_VALUE)
		f353_local1 = f353_arg1.colorGradientContainer.gradientSliderWidget.ThicknessSlider
		Engine[@"hash_2DB8171E8EF4D08F"](f353_arg0, 0)
		EmblemGradient_UpdateSliderVisuals(f353_arg0, f353_local1, Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f353_arg0), "Emblem.EmblemSelectedLayerProperties.gradient_thickness")) / CoD.CraftUtility.EMBLEM_MAX_GRADIENT_SLIDER_VALUE)
	else
		local f353_local1 = f353_arg1.colorGradientContainer.gradientSliderWidget.HardnessSlider
		CoD.CraftUtility.EmblemGradient_UpdateGradientFillByStep(f353_local1, f353_local1, 0, f353_arg0)
		EmblemGradient_UpdateGradientVisuals(f353_arg0, f353_local1)
	end
end
CoD.CraftUtility.EmblemGradient_UpdateThicknessByStep = function(f354_arg0, f354_arg1, f354_arg2, f354_arg3)
	Engine[@"hash_2DB8171E8EF4D08F"](f354_arg3, f354_arg2)
	EmblemGradient_UpdateSliderVisuals(f354_arg3, f354_arg1, Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f354_arg3), "Emblem.EmblemSelectedLayerProperties.gradient_thickness")) / CoD.CraftUtility.EMBLEM_MAX_GRADIENT_SLIDER_VALUE)
end
CoD.CraftUtility.EmblemGradient_UpdateAngleByStep = function(f355_arg0, f355_arg1, f355_arg2, f355_arg3)
	Engine[@"hash_61DB8B1C1CA53CB6"](f355_arg3, f355_arg2)
end
CoD.CraftUtility.EmblemGradient_SetAngle = function(f356_arg0, f356_arg1, f356_arg2, f356_arg3)
	Engine[@"emblemsetgradientangle"](f356_arg3, f356_arg2)
end
CoD.CraftUtility.EmblemGradient_ToggleGradientType = function(f357_arg0, f357_arg1, f357_arg2)
	Engine[@"emblemtogglegradienttype"](f357_arg2)
end
CoD.CraftUtility.EmblemGradient_UpdateGradientFillByStep = function(f358_arg0, f358_arg1, f358_arg2, f358_arg3)
	Engine[@"hash_173F93E76ED5920C"](f358_arg3, f358_arg2)
	local f358_local0 = Engine.GetModelForController(f358_arg3)
	if f358_local0["Emblem.EmblemSelectedLayerProperties.gradient_type"]:get() == Enum.CustomizationGradientType[@"hash_1A7C637A09DA3D16"] then
		EmblemGradient_UpdateSliderVisuals(f358_arg3, f358_arg1, Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(f358_arg3), "Emblem.EmblemSelectedLayerProperties.gradient_fill")) / CoD.CraftUtility.EMBLEM_MAX_GRADIENT_SLIDER_VALUE)
	else
		EmblemGradient_UpdateGradientVisuals(f358_arg3, f358_arg1)
	end
end
CoD.CraftUtility.EmblemGradient_SetGradientFill = function(f359_arg0, f359_arg1, f359_arg2, f359_arg3)
	Engine[@"emblemsetgradientfill"](f359_arg3, f359_arg2)
	EmblemGradient_UpdateGradientVisuals(f359_arg3, f359_arg1)
end
CoD.CraftUtility.EmblemGradient_BackFromGradientPicker = function(f360_arg0, f360_arg1, f360_arg2)
	if CoD.CraftUtility.GetEmblemEditorProperties(f360_arg2, "isColor0NoColor") == 1 and CoD.CraftUtility.GetEmblemEditorProperties(f360_arg2, "isColor1NoColor") == 1 then
		Engine[@"emblemsetlayercolor"](Enum.CustomizationColorNum[@"customization_color_none"], 1, 1, 1)
	end
end
CoD.CraftUtility.EmblemSelect_SetTabsToFirstFocusable = function(f361_arg0, f361_arg1, f361_arg2)
	local f361_local0 = f361_arg1.Tabs.grid
	if f361_local0 and focusFirstTab then
		local f361_local1 = f361_local0:getFirstSelectableItem()
		if f361_local1 then
			f361_local0:setActiveItem(f361_local1)
		end
	end
end
CoD.CraftUtility.EmblemSelect_TabChanged = function(f362_arg0, f362_arg1, f362_arg2)
	if CoD.perController[f362_arg2].selectedEmblemTabStorageType ~= f362_arg1.storageType or CoD.perController[f362_arg2].selectedEmblemTabStickerCategory ~= f362_arg1.stickerCategory then
		CoD.CraftUtility.Emblems.CachedEmblems = {}
		CoD.perController[f362_arg2].selectedEmblemTabStorageType = f362_arg1.storageType
		local f362_local0 = DataSources.SelectedStorageFileType.getModel(f362_arg2)
		f362_local0.storageFileType:set(f362_arg1.storageType)
		CoD.perController[f362_arg2].selectedEmblemTabStickerCategory = f362_arg1.stickerCategory
		CoD.CraftUtility.Emblems.ParseDDL(f362_arg2, CoD.perController[f362_arg2].selectedEmblemTabStorageType, CoD.perController[f362_arg2].selectedEmblemTabStickerCategory)
		if CoD.perController[f362_arg2].selectedEmblemTabStickerCategory ~= CoD.CraftUtility.EmblemStickerSetCategory then
			ForceNotifyModel(f362_arg2, "Emblem.UpdateDataSource")
		end
	end
end
CoD.CraftUtility.UpdateSlotCountText = function(f363_arg0, f363_arg1, f363_arg2, f363_arg3)
	return f363_arg1:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/emblem_layers_used_fraction", CoD.CraftUtility.GetUsedSlotsByFileType(f363_arg2, f363_arg3), CoD.CraftUtility.GetTotalAllowedSlotsByFileType(f363_arg2, f363_arg3)))
end
CoD.CraftUtility.UploadPublicProfile = function(f364_arg0, f364_arg1)
	if CoD.perController[f364_arg1].uploadProfile == true then
		CoD.perController[f364_arg1].uploadProfile = false
		Engine.ExecNow(f364_arg1, "uploadprofile")
	end
end
CoD.CraftUtility.BlackMarketSetAsEmblem = function(f365_arg0, f365_arg1, f365_arg2)
	CoD.perController[f365_arg2].selectedEmblemModel = f365_arg1:getModel()
	local f365_local0 = Engine.GetModelValue(f365_arg1:getModel(f365_arg2, "emblem"))
	local f365_local1, f365_local2, f365_local3 = CoD.BlackMarketUtility.GetLootEmblemIndexParams(f365_arg2, f365_local0)
	Engine.SetupEmblemData(f365_local1, f365_local2, f365_local3, Enum.CustomizationType[@"customization_type_emblem"])
	if IsLive() then
		Engine[@"emblemsetprofile"](f365_local1, CoD.perController[f365_local1].selectedEmblemTabStorageType, f365_local0)
		CoD.perController[f365_local1].uploadProfile = true
	else
		Engine.SetProfileVar(f365_local1, "default_emblem_index", f365_local2)
		Engine[@"invalidateemblemcomponent"](f365_local1)
	end
	ForceNotifyControllerModel(f365_local1, "identityBadge.xuid")
end
CoD.CraftUtility.BlackMarketSetCallingCard = function(f366_arg0, f366_arg1, f366_arg2)
	local f366_local0 = Engine.GetModel(f366_arg1:getModel(), "image")
	if f366_local0 ~= nil then
		local f366_local1 = CoD.BlackMarketUtility.GetLootCallingCardIndex(f366_arg2, Engine.GetModelValue(f366_local0))
		if not f366_local1 then
			return
		end
		SetEmblemBackground_Internal(f366_arg2, f366_local1)
	end
	ForceNotifyControllerModel(f366_arg2, "identityBadge.xuid")
end
CoD.CraftUtility.BlackMarketResultsOnClose = function(f367_arg0, f367_arg1, f367_arg2)
	if not IsLive() then
		Engine.CommitProfileChanges(f367_arg2)
	else
		CoD.CraftUtility.UploadPublicProfile(f367_arg0, f367_arg2)
	end
	CoD.perController[f367_arg2].selectedEmblemModel = nil
end
CoD.CraftUtility.CommitProfileChanges = function(f368_arg0)
	Engine.CommitProfileChanges(f368_arg0)
end
CoD.CraftUtility.EmblemSelect_Back = function(f369_arg0, f369_arg1, f369_arg2)
	if not IsLive() then
		Engine.CommitProfileChanges(f369_arg2)
	else
		CoD.CraftUtility.UploadPublicProfile(f369_arg0, f369_arg2)
		CoD.BreadcrumbUtility.UploadBuffer(f369_arg2, Enum.StorageFileType[@"storage_mp_stats_online"])
	end
	CoD.perController[f369_arg2].selectedEmblemModel = nil
	CoD.CraftUtility.Emblems.CachedEmblems = {}
	CoD.perController[f369_arg2].selectedDecalGroupModel = nil
	CoD.CraftUtility.Groups.CachedGroups = {}
	ClearMenuSavedState(f369_arg0, f369_arg2)
	local f369_local0 = Engine.GetModelForController(f369_arg2)
	Engine.UnsubscribeAndFreeModel(f369_local0.Emblem.EmblemList)
	local f369_local1 = Engine.GetModelForController(f369_arg2)
	Engine.UnsubscribeAndFreeModel(f369_local1.Emblem.StickerSetList)
end
CoD.CraftUtility.EditorCloseFromFooter = function(f370_arg0, f370_arg1)
	CoD.CraftUtility.EmblemEditor_StopEdits(f370_arg1)
	if IsLive() then
		CoD.CraftUtility.UploadPublicProfile(f370_arg0, f370_arg1)
	end
	CoD.perController[f370_arg1].selectedEmblemModel = nil
	CoD.CraftUtility.Emblems.CachedEmblems = {}
	CoD.perController[f370_arg1].selectedDecalGroupModel = nil
	CoD.CraftUtility.Groups.CachedGroups = {}
	local f370_local0 = Engine.GetModelForController(f370_arg1)
	Engine.UnsubscribeAndFreeModel(f370_local0.Emblem.EmblemList)
	local f370_local1 = Engine.GetModelForController(f370_arg1)
	Engine.UnsubscribeAndFreeModel(f370_local1.Emblem.StickerSetList)
end
CoD.CraftUtility.EmblemSelect_SetAsEmblem = function(f371_arg0, f371_arg1, f371_arg2)
	if IsLive() and not IsUserContentRestricted(f371_arg2) then
		local f371_local0 = Engine.GetModelValue(f371_arg1:getModel(f371_arg2, "emblemIndex"))
		local f371_local1 = f371_arg1:getModel(f371_arg2, "storageFileType")
		local f371_local2 = f371_local1:get()
		Engine[@"emblemsetprofile"](f371_arg2, f371_local2, f371_local0)
		CoD.perController[f371_arg2].uploadProfile = true
		if f371_local2 == Enum.StorageFileType[@"hash_36A0A3D1062F156F"] then
			local f371_local3 = CoD.BlackMarketTableUtility.LootInfoLookup(f371_arg2, CoD.BlackMarketUtility.GetLootDecalName(f371_arg2, f371_local0), nil)
			if f371_local3 and f371_local3.isLoot and f371_local3.itemId then
				Engine[0xDE279ECDDDD966](f371_arg2, 0x37D117732D0177, {
					loot_id = f371_local3.itemId,
					used_in = CoD.CraftUtility.USE_STICKER_IN.EMBLEM,
				})
			end
		end
	else
		Engine.SetProfileVar(f371_arg2, "default_emblem_index", Engine.GetModelValue(f371_arg1:getModel(f371_arg2, "emblemIndex")))
		Engine[@"invalidateemblemcomponent"](f371_arg2)
	end
end
CoD.CraftUtility.DecalGroup_GainFocus = function(f372_arg0, f372_arg1, f372_arg2)
	CoD.perController[f372_arg2].selectedDecalGroupModel = f372_arg1:getModel()
	local f372_local0 = f372_arg1:getModel(f372_arg2, "emblemIndex")
	local f372_local1 = f372_arg1:getModel(f372_arg2, "storageFileType")
	Engine.SetupEmblemData(f372_arg2, f372_local0:get(), f372_local1:get(), Enum.CustomizationType[@"hash_1AB847C1A0E71617"])
end
CoD.CraftUtility.EmblemSelect_GainFocus = function(f373_arg0, f373_arg1, f373_arg2)
	CoD.perController[f373_arg2].selectedEmblemModel = f373_arg1:getModel()
	Engine.SetupEmblemData(f373_arg2, Engine.GetModelValue(f373_arg1:getModel(f373_arg2, "emblemIndex")), Engine.GetModelValue(f373_arg1:getModel(f373_arg2, "storageFileType")), Enum.CustomizationType[@"customization_type_emblem"])
end
CoD.CraftUtility.EmblemSelect_StickerGainFocus = function(f374_arg0, f374_arg1, f374_arg2)
	CoD.perController[f374_arg2].selectedEmblemModel = f374_arg1:getModel()
	local f374_local0 = Engine.GetModelValue(f374_arg1:getModel(f374_arg2, "emblemIndex"))
end
CoD.CraftUtility.CraftGroupManager_GainFocus = function(f375_arg0, f375_arg1, f375_arg2)
	CoD.perController[f375_arg2].selectedDecalGroupModel = f375_arg1:getModel()
end
CoD.CraftUtility.EmblemSelect_ChooseEmblem = function(f376_arg0, f376_arg1, f376_arg2)
	CoD.perController[f376_arg2].totalLayers = Enum.CustomizationTypeLayerCount[@"customization_type_emblem_max_layers"]
	CoD.perController[f376_arg2].totalGroups = Enum.CustomizationTypeGroupCount[@"customization_type_max_groups"] - 1
	CoD.CraftUtility.SetEmblemEditorProperties(f376_arg2, Enum.CustomizationEditorMode[@"customization_editor_mode_browse"], "editorMode")
	local f376_local0 = Enum.CustomizationType[@"customization_type_emblem"]
	CoD.SetCustomization(f376_arg2, f376_local0, "type")
	Engine.SetupEmblemEditBuffer(f376_arg2, f376_local0, 0)
end
CoD.CraftUtility.EmblemSelect_RenameEmblem = function(f377_arg0, f377_arg1, f377_arg2)
	local f377_local0 = f377_arg0:getModel()
	CoD.CraftUtility.Emblems.RenameEmblem(f377_arg2, Engine.GetModelValue(Engine.GetModel(f377_local0, "emblemIndex")), Engine.GetModelValue(Engine.GetModel(f377_local0, "displayName")))
end
CoD.CraftUtility.EmblemSelect_HandleRenameKeyboardComplete = function(f378_arg0, f378_arg1, f378_arg2, f378_arg3)
	local f378_local0 = f378_arg0:getModel()
	local f378_local1 = nil
	if not f378_local0 then
		return
	elseif f378_arg3.type == Enum.KeyboardType[@"keyboard_type_emblems"] then
		f378_local1 = Engine.GetModel(f378_local0, "displayName")
	end
	if f378_local1 then
		Engine.SetModelValue(f378_local1, f378_arg3.input)
	end
end
CoD.CraftUtility.EmblemSelect_ClearEmblem = function(f379_arg0, f379_arg1)
	local f379_local0 = Engine.GetModelValue(Engine.GetModel(CoD.perController[f379_arg1].selectedEmblemModel, "emblemIndex"))
	CoD.CraftUtility.Emblems.ClearEmblem(f379_arg1, f379_local0)
	Engine.UploadEmblemData(f379_arg1, f379_local0)
	CoD.CraftUtility.Emblems.ParseDDL(f379_arg1, Enum.StorageFileType[@"storage_emblems"], CoD.perController[f379_arg1].selectedEmblemTabStickerCategory)
	local f379_local1 = nil
	if IsMediaManager() == true then
		MediaManagerMarkDirty(f379_arg1)
	end
	ForceNotifyModel(f379_arg1, "Emblem.UpdateDataSource")
end
CoD.CraftUtility.EmblemSelect_CopyEmblem = function(f380_arg0, f380_arg1, f380_arg2, f380_arg3)
	if CoD.CraftUtility.Emblems.Copy(f380_arg2, CoD.perController[f380_arg2].selectedEmblemModel, CoD.perController[f380_arg2].selectedEmblemTabStorageType) then
		CoD.CraftUtility.Emblems.ParseDDL(f380_arg2, Enum.StorageFileType[@"storage_emblems"], CoD.perController[f380_arg2].selectedEmblemTabStickerCategory)
		ForceNotifyModel(f380_arg2, "Emblem.UpdateDataSource")
	end
end
CoD.CraftUtility.Paintshop_SetPaintshopToCACLoadout = function(f381_arg0, f381_arg1)
	local f381_local0 = CoD.perController[f381_arg0].selectedPaintjobModel
	if f381_local0 then
		Engine[@"hash_4522B06AC93E81B"](f381_arg0, Engine.GetModelValue(Engine.GetModel(f381_local0, "paintjobSlot")), f381_arg1)
	end
end
CoD.CraftUtility.ClearEmblemColorList = function()
	CoD.CraftUtility.EmblemColorList = nil
end
CoD.CraftUtility.UpdateWeaponModel = function(f383_arg0, f383_arg1, f383_arg2)
	local f383_local0 = "primary"
	local f383_local1 = Enum.eModes.mode_multiplayer
	local f383_local2 = nil
	local f383_local3 = f383_arg1:getModel()
	if f383_local3 and f383_local3.itemIndex then
		f383_local2 = f383_local3.itemIndex:get()
	end
	local f383_local4 = nil
	if f383_local3 and f383_local3.useVariantSlot and f383_local3.useVariantSlot:get() > 0 then
		f383_local4 = f383_local3.useVariantSlot:get()
	end
	if f383_local2 then
		CoD.CACUtility.UpdateWeaponModelHelper(f383_arg0, f383_arg2, nil, f383_local0, f383_local2, f383_local1, false, f383_local4)
	end
end
CoD.CraftUtility.Paintshop = {}
CoD.CraftUtility.Paintjobs_IsNew = function(f384_arg0)
	return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f384_arg0, "SelectedPaintjob", "weaponIndex", CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX)
end
CoD.CraftUtility.ClearPaintjobCache = function(f385_arg0)
	if f385_arg0 ~= LuaDefine.ZERO_X64 then
		Engine[@"hash_2F3D516679F0B183"](f385_arg0)
	end
end
CoD.CraftUtility.OpenPaintjobWeaponSelection = function(f386_arg0, f386_arg1, f386_arg2, f386_arg3, f386_arg4)
	if Engine.PushAnticheatMessageToUI(f386_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC) then
		DisplayAnticheatMessage(f386_arg4, f386_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC, "Paintshop", "")
		return
	elseif CheckIfFeatureIsBanned(f386_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT) then
		LuaUtils.UI_ShowErrorMessageDialog(f386_arg2, GetFeatureBanInfo(f386_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT))
		return
	else
		CoD.SetCustomization(f386_arg2, Enum.CustomizationType[@"customization_type_paintshop_view_left"], "type")
		OpenOverlay(f386_arg4, "PaintjobWeaponSelect", f386_arg2, {
			_sessionMode = Enum.eModes.mode_multiplayer,
			_storageClientBuffer = f386_arg4._storageClientBuffer,
			_isPaintjobEditor = true,
		})
	end
end
CoD.CraftUtility.OpenPaintjobSelection = function(f387_arg0, f387_arg1, f387_arg2, f387_arg3, f387_arg4)
	Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f387_arg2), "Paintshop.Mode"), Enum.PaintshopMode[@"paintshopmode_weaponlist"])
	CoD.SetCustomization(f387_arg2, Enum.CustomizationType[@"customization_type_paintshop_view_left"], "type")
	CoD.perController[f387_arg2].totalLayers = Enum.CustomizationTypeLayerCount[@"customization_type_paintshop_max_layers"]
	CoD.perController[f387_arg2].totalGroups = Enum.CustomizationTypeGroupCount[@"customization_type_max_groups"] - 1
	local f387_local0 = CoD.CraftUtility.Paintjobs.ParseDDL(f387_arg2, Enum.StorageFileType[@"storage_paintjobs"])
	if f387_local0 then
		f387_local0 = CoD.CraftUtility.Groups.ParseDDL(f387_arg2)
	end
	if f387_local0 then
		if f387_arg3 == "setweapon" then
			local f387_local1 = f387_arg1:getModel()
			CoD.SetCustomization(f387_arg2, f387_local1.itemIndex:get(), "weapon_index")
		end
		OpenOverlay(f387_arg4, "Paintshop", f387_arg2, {
			_sessionMode = Enum.eModes.mode_multiplayer,
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f387_arg2, Enum.eModes.mode_multiplayer),
		})
	end
end
CoD.CraftUtility.SetupPaintjobPersonalization = function(f388_arg0, f388_arg1, f388_arg2)
	CoD.CraftUtility.Paintjobs.ParseDDL(f388_arg2, Enum.StorageFileType[@"storage_paintjobs"])
	CoD.CraftUtility.Groups.ParseDDL(f388_arg2)
	local f388_local0 = f388_arg1:getModel()
	CoD.SetCustomization(f388_arg2, f388_local0.itemIndex:get(), "weapon_index")
	local f388_local1 = CoD.SafeGetModelValue(f388_local0, "refHash")
	if not f388_local1 then
		f388_local1 = CoD.SafeGetModelValue(f388_local0, "weaponNameHash") or 0x0
	end
	CoD.SetCustomization(f388_arg2, f388_local1, "weaponRefHash")
end
CoD.CraftUtility.SetUpOpticPersonalization = function(f389_arg0, f389_arg1)
	local f389_local0 = f389_arg0:getModel()
	local f389_local1 = nil
	if f389_local0.baseWeaponSlotModel then
		local f389_local2 = f389_local0.baseWeaponSlotModel:get()
		f389_local1 = f389_local2.itemIndex:get()
	else
		f389_local1 = f389_local0.weaponIndex:get()
	end
	CoD.SetCustomization(f389_arg1, f389_local1, "weapon_index")
end
CoD.CraftUtility.PaintjobPersonalization_Select = function(f390_arg0, f390_arg1, f390_arg2)
	CoD.perController[f390_arg2].personalPaintjobModel = f390_arg1:getModel()
	CoD.CraftUtility.ClearPaintjobCache(Engine.GetXUID64(f390_arg2))
end
CoD.CraftUtility.PaintjobPersonalization_RestoreSelected = function(f391_arg0, f391_arg1)
	local f391_local0 = CoD.perController[f391_arg1].personalPaintjobModel
	if f391_local0 then
		CoD.perController[f391_arg1].viewIndex = 1
		local f391_local1 = CoD.CraftUtility.PaintshopView[CoD.perController[f391_arg1].viewIndex].customization_type
		CoD.CraftUtility.Gunsmith.DisplayWeaponWithPaintjob(f391_arg1, f391_local0.paintjobSlot:get())
	else
		CoD.CraftUtility.Gunsmith.DisplayWeaponWithPaintjob(f391_arg1, Enum.CustomizationPaintjobInvalidID[@"customization_invalid_paintjob_slot"])
	end
end
CoD.CraftUtility.PaintjobPersonalization_Preview = function(f392_arg0, f392_arg1, f392_arg2)
	CoD.perController[f392_arg2].viewIndex = 1
	local f392_local0 = CoD.CraftUtility.PaintshopView[CoD.perController[f392_arg2].viewIndex].customization_type
	local f392_local1 = f392_arg1:getModel(f392_arg2, "paintjobSlot")
	CoD.CraftUtility.Gunsmith.DisplayWeaponWithPaintjob(f392_arg2, f392_local1:get())
end
CoD.CraftUtility.PreviewWeaponCamo = function(f393_arg0, f393_arg1, f393_arg2, f393_arg3)
	local f393_local0 = CoD.BaseUtility.GetMenuSessionMode(f393_arg3)
	local f393_local1 = CoD.GetCustomization(f393_arg2, "weaponRefHash")
	local f393_local2 = CoD.CraftUtility.GetLoadoutSlot(f393_arg2)
	local f393_local3 = CoD.CACUtility.GetCameraNameForAttachments("")
	local f393_local4 = f393_arg1:getModel(f393_arg2, "weaponOptionSubIndex")
	if f393_local4 then
		local f393_local5 = f393_arg3._baseWeaponModelSlot or 0
		local f393_local6 = f393_local4:get()
		local f393_local7 = CoD.WeaponOptionsUtility.GetRobStageForCamoIndex(f393_local6)
		local f393_local8 = 0
		if f393_local0 == Enum.eModes.mode_zombies then
			f393_local8 = CoD.ZMLoadoutUtility.GetArmoryCharmItemFromWeapon(f393_arg2, CoD.GetCustomization(f393_arg2, "weapon_index"))
		elseif f393_local0 == Enum.eModes.mode_warzone then
			f393_local8 = CoD.WZUtility.GetArmoryCharmItemFromWeapon(f393_arg2, CoD.GetCustomization(f393_arg2, "weapon_index"))
		else
			local f393_local9 = CoD.BaseUtility.GetMenuLoadoutSlot(f393_arg3)
			local f393_local10 = CoD.BaseUtility.GetMenuModel(f393_arg3)
			local f393_local11 = f393_local9 and f393_local10 and f393_local10[f393_local9].charmIndex
			if f393_local11 then
				local f393_local12 = f393_local11:get()
			end
			f393_local8 = f393_local12 or 0
		end
		local f393_local9 = CoD.WeaponOptionsUtility.GetWeaponOptionsString(f393_local6, 0, 1, f393_local5, f393_local7, f393_local8)
		local f393_local10 = ""
		if f393_local0 == Enum.eModes.mode_zombies then
			f393_local10 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForWeaponIndex(f393_arg2, CoD.GetCustomization(f393_arg2, "weapon_index"), f393_local0)
		end
		Engine.SendClientScriptNotify(f393_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f393_arg2), {
			base_weapon_slot = f393_local2,
			weapon = f393_local1,
			attachments = f393_local10,
			camera = f393_local3,
			options = f393_local9,
		})
	end
end
CoD.CraftUtility.SetModelToSelectedEmblemModel = function(f394_arg0, f394_arg1)
	f394_arg0:setModel(CoD.perController[f394_arg1].selectedEmblemModel)
end
CoD.CraftUtility.SetModelToSelectedPaintjobModel = function(f395_arg0, f395_arg1)
	f395_arg0:setModel(CoD.perController[f395_arg1].selectedPaintjobModel)
end
CoD.CraftUtility.PaintshopPreLoad = function(f396_arg0, f396_arg1)
	f396_arg0:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(f396_arg1), "Paintshop.UpdateDataSource"), function(model)
		local f397_local0 = CoD.perController[f396_arg1].selectedPaintjobModel
		if f397_local0 then
			local f397_local1 = Engine.GetModelValue(Engine.GetModel(f397_local0, "paintjobSlot"))
			if f396_arg0.paintjobSelector ~= nil then
				f396_arg0.paintjobSelector.paintjobsList:updateDataSource(true)
				f396_arg0.paintjobSelector.paintjobsList:findItem({
					paintjobSlot = f397_local1,
				}, nil, true, nil)
			end
		end
	end)
end
CoD.CraftUtility.EmblemEntitlements = {
	{
		nameHash = "sku",
		storageFileType = Enum.StorageFileType[@"storage_emblems_loot"],
		entitlementRefs = {
			"blackops_pack",
		},
	},
	{
		nameHash = "endowmentem",
		storageFileType = Enum.StorageFileType[@"storage_emblems_loot"],
		entitlementRefs = {
			@"hash_16D83FD17A87C96B",
		},
	},
}
CoD.CraftUtility.IsEmblemUnlocked = function(f398_arg0, f398_arg1, f398_arg2)
	if f398_arg1 then
		for f398_local0 = 1, #CoD.CraftUtility.EmblemEntitlements, 1 do
			local f398_local3 = CoD.CraftUtility.EmblemEntitlements[f398_local0]
			if f398_arg1 == f398_local3.nameHash and f398_arg2 == f398_local3.storageFileType then
				for f398_local4 = 1, #f398_local3.entitlementRefs, 1 do
					if Engine.HasEntitlement(f398_arg0, f398_local3.entitlementRefs[f398_local4]) then
						return true
					end
				end
				return false
			end
		end
	end
	return true
end
CoD.CraftUtility.GradientTypes = {
	{
		name = "menu/gradient_linear",
		type = Enum.CustomizationGradientType[@"customization_gradient_linear"],
		sliderWidget = "CoD.EmblemEditorLinearRadialSliderFrame",
	},
	{
		name = "menu/gradient_radial",
		type = Enum.CustomizationGradientType[@"customization_gradient_radial"],
		sliderWidget = "CoD.EmblemEditorLinearRadialSliderFrame",
	},
	{
		name = "menu/gradient_contour",
		type = Enum.CustomizationGradientType[@"hash_1A7C637A09DA3D16"],
		sliderWidget = "CoD.EmblemEditorContourSliderFrame",
	},
}
CoD.CraftUtility.IsGradientButtonSelected = function(f399_arg0, f399_arg1, f399_arg2)
	local f399_local0 = Engine.GetModelForController(f399_arg2)
	f399_local0 = f399_local0["Emblem.EmblemSelectedLayerProperties.gradient_type"].get(f399_local0["Emblem.EmblemSelectedLayerProperties.gradient_type"])
	local f399_local1 = f399_arg1:getModel(f399_arg2, "gradientType")
	return f399_local1:get() == f399_local0
end
CoD.CraftUtility.SetGradientTypeAction = function(f400_arg0, f400_arg1, f400_arg2, f400_arg3)
	Engine[@"hash_7EA0C7FF1B0ACC69"](f400_arg2, f400_arg3)
end
DataSources.GradientButtonList = ListHelper_SetupDataSource("GradientButtonList", function(f401_arg0)
	local f401_local0 = {}
	for f401_local4, f401_local5 in ipairs(CoD.CraftUtility.GradientTypes) do
		if f401_local5.type ~= Enum.CustomizationGradientType[@"hash_1A7C637A09DA3D16"] or Dvar[@"hash_470BEDFAD5049E10"]:get() then
			table.insert(f401_local0, {
				models = {
					name = f401_local5.name,
					gradientType = f401_local5.type,
					sliderWidget = f401_local5.sliderWidget,
				},
				properties = {
					action = CoD.CraftUtility.SetGradientTypeAction,
					actionParam = f401_local5.type,
				},
			})
		end
	end
	return f401_local0
end)
CoD.CraftUtility.GetPaintjobEditorTitle = function(f402_arg0, f402_arg1)
	if CoD.CraftUtility.IsEditMode(f402_arg0) then
		return @"hash_54C605091FA75941"
	else
		return "menu/paintshop_caps"
	end
end
CoD.CraftUtility.GetEmblemEditorTitle = function(f403_arg0, f403_arg1)
	if CoD.CraftUtility.IsEditMode(f403_arg0) then
		return @"hash_54C605091FA75941"
	else
		return "menu/emblem_editor_caps"
	end
end
CoD.CraftUtility.EmblemListFramePreLoad = function(f404_arg0, f404_arg1)
	f404_arg0:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(f404_arg1), "Emblem.UpdateDataSource"), function()
		local f405_local0 = 1
		local f405_local1 = CoD.perController[f404_arg1].selectedEmblemModel
		if f405_local1 then
			f405_local0 = Engine.GetModelValue(Engine.GetModel(f405_local1, "emblemIndex"))
		end
		if f404_arg0.emblemList ~= nil then
			f404_arg0.emblemList:updateDataSource(true)
			f404_arg0.emblemList:findItem({
				emblemIndex = f405_local0,
			}, nil, true, nil)
		end
	end)
	CoD.CraftUtility.EmblemColorList = nil
end
