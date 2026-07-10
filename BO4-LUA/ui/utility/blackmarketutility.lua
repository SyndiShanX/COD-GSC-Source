require("x64:13bf102cb2353b4")
require("x64:f3c5259f470592d")
CoD.BlackMarketUtility = {}
CoD.BlackMarketUtility.MyShopResetTime = "1553792400"
CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID = 20
CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID = 500163
CoD.BlackMarketUtility.RESERVER_CASE_BRIBE_ID = "500862"
CoD.BlackMarketUtility[@"hash_491EF6C1326C6875"] = "100000000"
CoD.BlackMarketUtility[@"hash_42521DB9F18C114C"] = "199999999"
CoD.BlackMarketUtility[@"hash_F6715E447BF9B1"] = "200000000"
CoD.BlackMarketUtility[@"hash_2BF3E69D05D1B50"] = "299999999"
CoD.BlackMarketUtility[@"hash_5419C2BCB9BF5542"] = "300000000"
CoD.BlackMarketUtility[@"hash_240F9EEE60FE2E67"] = "399999999"
CoD.BlackMarketUtility[0xE904580D0E4807] = "400000000"
CoD.BlackMarketUtility[@"hash_1D620DA7785ED682"] = "499999999"
CoD.BlackMarketUtility.ItemHistoryCount = 300
CoD.BlackMarketUtility.PaidTierSKU = "500100"
CoD.BlackMarketUtility.PaidTierCpPrice = 100
CoD.BlackMarketUtility.PaidTierHalfOffSKU = "500104"
CoD.BlackMarketUtility.PaidTierHalfOffCpPrice = 50
CoD.BlackMarketUtility.SupplyChainMaxTiers = 100000
CoD.BlackMarketUtility.SupplyChainPeekTiers = 25
CoD.BlackMarketUtility.ItemShopSlots = 3
CoD.BlackMarketUtility.FeaturedSlot1Items = {}
CoD.BlackMarketUtility.FeaturedSlot2Items = {}
CoD.BlackMarketUtility.FeaturedSlot3Items = {}
CoD.BlackMarketUtility.ReserveDeals = {}
CoD.BlackMarketUtility.MyShopList = {}
CoD.BlackMarketUtility.BribeStack = {}
CoD.BlackMarketUtility.BribeMenuLootRule = 49
CoD.BlackMarketUtility.BlackOpsPassId = 10055
CoD.BlackMarketUtility.BlackOpsPassFreeTiers = 50
CoD.BlackMarketUtility.BlackOpsPassFreeTiersProduct = 0
CoD.BlackMarketUtility.LootItemCountCase = 1
CoD.BlackMarketUtility.LootItemCountCrate = 3
CoD.BlackMarketUtility.LootItemRevealInitialDelayMS = 1500
CoD.BlackMarketUtility.LootItemRevealPerItemDelayMS = 1000
CoD.BlackMarketUtility.LootItemRevealPreRerollDelayMS = 1000
CoD.BlackMarketUtility.LootItemRevealRerollDelayMS = 1000
CoD.BlackMarketUtility.LootItemRevealFinalDelayMS = 1250
DataSourceHelpers.PerControllerDataSourceSetup("LootStreamProgress", "LootStreamProgress", nil)
CoD.BlackMarketUtility.ItemCategories = {
	CALLING_CARD = @"calling_card",
	STICKER = @"sticker",
	TAG = @"tag",
	OUTFIT = @"outfit",
	OUTFIT_WARPAINT = @"outfit_warpaint",
	OUTFIT_DECAL = @"outfit_decal",
	OUTFIT_BUNDLE = @"outfit_bundle",
	SIGNATURE_WEAPON = @"signature_weapon",
	CHARACTER = @"character",
}
CoD.BlackMarketUtility.ItemCategoryStrings = {
	[CoD.BlackMarketUtility.ItemCategories.CALLING_CARD] = @"menu/calling_card",
	[CoD.BlackMarketUtility.ItemCategories.STICKER] = @"hash_684446BBFA84177E",
	[CoD.BlackMarketUtility.ItemCategories.OUTFIT] = @"hash_3902540279D3297C",
	[CoD.BlackMarketUtility.ItemCategories.OUTFIT_WARPAINT] = @"hash_6C6DA1503405E36F",
	[CoD.BlackMarketUtility.ItemCategories.OUTFIT_DECAL] = @"hash_90FDB01723264C2",
	[CoD.BlackMarketUtility.ItemCategories.OUTFIT_BUNDLE] = @"hash_10FEC0D6C18D931",
	[CoD.BlackMarketUtility.ItemCategories.SIGNATURE_WEAPON] = @"hash_2568FD7857ADA7B1",
	[CoD.BlackMarketUtility.ItemCategories.CHARACTER] = @"hash_4A2DF1D1E83E0922",
}
CoD.BlackMarketUtility.DropTypes = {
	COMMON = Enum[@"lootcratetype"][@"loot_crate_type_common"],
	RARE = Enum[@"lootcratetype"][@"loot_crate_type_rare"],
	BRIBE = Enum[@"lootcratetype"][@"loot_crate_type_bribe"],
	LEGENDARY = 3,
	EPIC = 4,
}
CoD.BlackMarketUtility.CrateTypeStrings = {
	[CoD.BlackMarketUtility.DropTypes.COMMON] = @"mpui/bm_common",
	[CoD.BlackMarketUtility.DropTypes.RARE] = @"mpui/bm_rare",
	[CoD.BlackMarketUtility.DropTypes.BRIBE] = @"mpui/bm_bribe",
	[CoD.BlackMarketUtility.DropTypes.LEGENDARY] = @"mpui/bm_legendary",
	[CoD.BlackMarketUtility.DropTypes.EPIC] = @"mpui/bm_epic",
}
CoD.BlackMarketUtility.CrateTypeIds = {
	[CoD.BlackMarketUtility.DropTypes.COMMON] = @"common",
	[CoD.BlackMarketUtility.DropTypes.RARE] = @"rare",
	[CoD.BlackMarketUtility.DropTypes.BRIBE] = @"bribe",
	[CoD.BlackMarketUtility.DropTypes.LEGENDARY] = @"legendary",
	[CoD.BlackMarketUtility.DropTypes.EPIC] = @"epic",
}
CoD.BlackMarketUtility.LootRarityIds = {
	[Enum[@"lootraritytype"][@"loot_rarity_type_common"]] = @"common",
	[Enum[@"lootraritytype"][@"loot_rarity_type_rare"]] = @"rare",
	[Enum[@"lootraritytype"][@"loot_rarity_type_legendary"]] = @"legendary",
	[Enum[@"lootraritytype"][@"loot_rarity_type_epic"]] = @"epic",
	[Enum[@"lootraritytype"][@"hash_63006FE890A202D9"]] = @"ultra",
	[Enum[@"lootraritytype"][@"loot_rarity_type_count"]] = @"invalid",
}
CoD.BlackMarketUtility.LootIdRarities = {}
for f0_local3, f0_local4 in pairs(CoD.BlackMarketUtility.LootRarityIds) do
	CoD.BlackMarketUtility.LootIdRarities[f0_local4] = f0_local3
end
CoD.BlackMarketUtility.LootRarityStrings = {
	[Enum[@"lootraritytype"][@"loot_rarity_type_common"]] = @"mpui/bm_common",
	[Enum[@"lootraritytype"][@"loot_rarity_type_rare"]] = @"mpui/bm_rare",
	[Enum[@"lootraritytype"][@"loot_rarity_type_legendary"]] = @"mpui/bm_legendary",
	[Enum[@"lootraritytype"][@"loot_rarity_type_epic"]] = @"mpui/bm_epic",
	[Enum[@"lootraritytype"][@"hash_63006FE890A202D9"]] = @"mpui/bm_ultra",
}
CoD.BlackMarketUtility.LootRarityColors = {
	[Enum[@"lootraritytype"][@"loot_rarity_type_common"]] = ColorSet.BlackMarketCommon,
	[Enum[@"lootraritytype"][@"loot_rarity_type_rare"]] = ColorSet.BlackMarketRare,
	[Enum[@"lootraritytype"][@"loot_rarity_type_legendary"]] = ColorSet.BlackMarketLegendary,
	[Enum[@"lootraritytype"][@"loot_rarity_type_epic"]] = ColorSet.BlackMarketEpic,
	[Enum[@"lootraritytype"][@"hash_63006FE890A202D9"]] = ColorSet.BlackMarketUltra,
}
CoD.BlackMarketUtility.LootRarityColorsBright = {
	[Enum[@"lootraritytype"][@"loot_rarity_type_common"]] = ColorSet.BlackMarketCommonBright,
	[Enum[@"lootraritytype"][@"loot_rarity_type_rare"]] = ColorSet.BlackMarketRareBright,
	[Enum[@"lootraritytype"][@"loot_rarity_type_legendary"]] = ColorSet.BlackMarketLegendaryBright,
	[Enum[@"lootraritytype"][@"loot_rarity_type_epic"]] = ColorSet.BlackMarketEpicBright,
	[Enum[@"lootraritytype"][@"hash_63006FE890A202D9"]] = ColorSet.BlackMarketUltraBright,
}
CoD.BlackMarketUtility.LootRarityColorsDark = {
	[Enum[@"lootraritytype"][@"loot_rarity_type_common"]] = ColorSet.BlackMarketCommonDark,
	[Enum[@"lootraritytype"][@"loot_rarity_type_rare"]] = ColorSet.BlackMarketRareDark,
	[Enum[@"lootraritytype"][@"loot_rarity_type_legendary"]] = ColorSet.BlackMarketLegendaryDark,
	[Enum[@"lootraritytype"][@"loot_rarity_type_epic"]] = ColorSet.BlackMarketEpicDark,
	[Enum[@"lootraritytype"][@"hash_63006FE890A202D9"]] = ColorSet.BlackMarketUltraDark,
}
CoD.BlackMarketUtility.BlackjackShopSlotIndex = {
	[Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"]] = 1,
	[Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"]] = 2,
	[Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]] = 3,
}
CoD.BlackMarketUtility.BlackjackShopSlotTooltipText = {
	[Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"]] = @"hash_6E28C8FEE7AC0DC",
	[Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"]] = @"hash_28B455496D32762D",
	[Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]] = 0x91065020541472,
}
CoD.BlackMarketUtility.BlackjackShopSlotIndexSunsetOffset = 4
CoD.BlackMarketUtility.BlackjackShopSunsetOverridePopupImageItems = {
	[0xE1A56F09B9E089] = true,
	[@"hash_78E63C0503639F94"] = true,
	[@"hash_5B932A56FC6002C6"] = true,
	[@"hash_7393BC4CF76F2578"] = true,
	[@"hash_71394A9379B38E9F"] = true,
	[@"hash_7EA964D9CC64652"] = true,
	[@"hash_51639D05B36745EB"] = true,
	[@"hash_53EFCFFCA2DFFA52"] = true,
	[@"hash_62E278E11A6AA5EB"] = true,
}
CoD.BlackMarketUtility.CharacterPRTTable = {
	@"prt_mp_mercenary",
	@"prt_mp_battery",
	@"prt_mp_swatpolice",
	@"prt_mp_engineer",
	@"prt_mp_buffassault",
	@"prt_mp_recon",
	@"prt_mp_firebreak",
	@"prt_mp_trapper",
	@"prt_mp_enforcer",
	@"prt_mp_technomancer",
	@"hash_6E7BEFEFF487BA9A",
	@"hash_4A011DFFEC0DD650",
	@"hash_5517568F2FB8127",
}
CoD.BlackMarketUtility.ItemNameCharacterPRTTable = {
	[@"hash_3C214F585374E06A"] = @"prt_wz_hudson",
}
CoD.BlackMarketUtility.StreamCharacterDescTable = {
	[@"prt_wz_hudson"] = @"hash_6CDD8929BD48E4E9",
	[0x3D7717027A0F92] = @"hash_4774DE2FD6C7BE88",
	[@"hash_1DC888EECACF65D4"] = @"hash_4774DE2FD6C7BE88",
	[@"hash_4CAFB9E3D2FC01C6"] = @"hash_6CDD8929BD48E4E9",
	[@"hash_6E3E592BC081A2F4"] = @"hash_6CDD8929BD48E4E9",
	[@"hash_2CA0BA1DC951406E"] = @"hash_6CDD8929BD48E4E9",
	[@"hash_4A011DFFEC0DD650"] = @"hash_4774DE2FD6C7BE88",
	[@"hash_5517568F2FB8127"] = @"hash_4774DE2FD6C7BE88",
}
CoD.BlackMarketUtility.PRT_To_PBT_Table = {
	[@"prt_mp_swatpolice"] = @"hash_641D42086962443D",
	[@"prt_mp_engineer"] = @"hash_34C5E1C04823489D",
	[@"prt_mp_buffassault"] = @"hash_271546989F2B39C0",
	[@"prt_mp_recon"] = @"hash_265A8BFE9E6A3A8F",
	[@"prt_mp_battery"] = @"hash_25D901B2845AFFB5",
	[@"prt_mp_firebreak"] = @"hash_17C8471AD085983B",
	[@"prt_mp_trapper"] = @"hash_BAC19A8A93F750A",
	[@"prt_mp_mercenary"] = @"hash_215EFCE6AF8D9A10",
	[@"prt_mp_enforcer"] = @"hash_35ABB557417D97BC",
	[@"prt_mp_technomancer"] = @"hash_74A7B1F09EB77129",
	[@"hash_6E7BEFEFF487BA9A"] = @"hash_4AE753FD800CB78A",
	[@"hash_4A011DFFEC0DD650"] = @"hash_4C0746FA548D2220",
	[@"hash_5517568F2FB8127"] = @"hash_906E794EC705237",
}
CoD.BlackMarketUtility.ItemShopImageOverrideTable = {}
CoD.BlackMarketUtility[@"hash_28F1DEAFDA8DC0BC"] = {
	"211244496",
	"263720229",
	"221228152",
}
CoD.BlackMarketUtility[@"hash_5484A50BE5ADB35"] = {
	"261932147",
	"287289967",
	"223153007",
}
CoD.BlackMarketUtility[@"hash_6F1C1A8D4B68B502"] = {
	"217806636",
	"261472603",
	"265954742",
}
CoD.BlackMarketUtility[@"hash_61F6439D530101F0"] = {
	"295032537",
	"291484684",
	"250886049",
}
CoD.BlackMarketUtility[@"hash_6687ECDB5754642D"] = {
	"208854822",
	"270337117",
	"229095075",
}
CoD.BlackMarketUtility.lootEmblemTableName = "gamedata/loot/mplootemblems.csv"
CoD.BlackMarketUtility.lootTableName = "gamedata/loot/loot_contraband.csv"
CoD.BlackMarketUtility.emblemMaterialsTableName = "gamedata/emblems/emblemMaterials.csv"
CoD.BlackMarketUtility.emblemIconsTableName = "gamedata/emblems/emblemIcons.csv"
CoD.BlackMarketUtility.backgroundsTable = "gamedata/emblems/backgrounds.csv"
CoD.BlackMarketUtility.unreleasedLootTableName = "gamedata/loot/mpUnreleasedLoot.csv"
CoD.BlackMarketUtility.lootNameCol = 1
CoD.BlackMarketUtility.parsedEmblemDDLs = {}
CoD.BlackMarketUtility.CallingCardsTable = {}
CoD.BlackMarketUtility.CommonCallingCardsTable = {}
CoD.BlackMarketUtility.WeaponsWithNoBMCamos = {
	launcher_standard_df = true,
	bowie_knife = true,
	melee_knuckles = true,
	melee_butterfly = true,
	melee_wrench = true,
	pistol_shotgun = true,
	melee_crowbar = true,
	melee_sword = true,
	ar_garand = true,
	special_crossbow = true,
}
CoD.BlackMarketUtility.CrateStreams = {
	CASE = "1000",
	THREE_PACK = "1001",
}
CoD.BlackMarketUtility.MyShopExperiments = {
	[@"camo_active_dlc1_masks_wrapper"] = {
		expKey = "expMaskedReactiveCamoBundle",
		itemRefs = {
			["1"] = @"camo_active_dlc1_masks_wrapper",
			["2"] = @"hash_78B5B62ACC867E6",
			["3"] = @"hash_3658E788D9ADF660",
			["4"] = @"hash_6F19E01F158B1AF5",
			["5"] = @"hash_634F3FF44882A3BA",
		},
	},
}
CoD.BlackMarketUtility.Error = function(f1_arg0, f1_arg1)
	if Dvar[@"hash_35B2B7FB4235091B"]:exists() and Dvar[@"hash_35B2B7FB4235091B"]:get() == "1" then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_loot"], "Error: '\n" .. f1_arg1)
	else
		LuaUtils.UI_ShowErrorMessageDialog(f1_arg0, f1_arg1, "")
	end
end
CoD.BlackMarketUtility.GetBribeStackWindowStartDate = function(f2_arg0)
	local f2_local0 = Engine[@"getdvarstring"](f2_arg0 .. "_start")
	if not f2_local0 or f2_local0 == "" then
		f2_local0 = "1573754400"
	end
	return f2_local0
end
CoD.BlackMarketUtility.GetBribeMenuWindowStartDate = function()
	local f3_local0 = Engine[@"getdvarstring"]("loot_bribe_menu_start")
	if not f3_local0 or f3_local0 == "" then
		f3_local0 = "1573754400"
	end
	return f3_local0
end
CoD.BlackMarketUtility.GetBribeStackWindowSizeSeconds = function(f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1 .. "_window_size"
	local f4_local1 = CoD.StoreUtility.GetExperimentModifier(f4_arg0, f4_local0)
	if not f4_local1 or f4_local1 == "" then
		f4_local1 = Engine[@"getdvarstring"](f4_local0)
		if not f4_local1 or f4_local1 == "" then
			f4_local1 = "2419200"
		end
	end
	return f4_local1
end
CoD.BlackMarketUtility.GetBribeMenuWindowSizeSeconds = function(f5_arg0)
	local f5_local0 = "loot_bribe_menu_window_size"
	local f5_local1 = nil
	if f5_local1 then
		f5_local1 = CoD.StoreUtility.GetExperimentModifier(f5_arg0, f5_local0)
	end
	if not f5_local1 or f5_local1 == "" then
		f5_local1 = Engine[@"getdvarstring"](f5_local0)
		if not f5_local1 or f5_local1 == "" then
			f5_local1 = "2419200"
		end
	end
	return f5_local1
end
CoD.BlackMarketUtility.SaveBribe = function(f6_arg0, f6_arg1)
	local f6_local0 = nil
	for f6_local9, f6_local10 in ipairs(CoD.BlackMarketUtility.BribeStack) do
		if f6_arg1 == f6_local10.name then
			local f6_local4 = Engine[@"getmodelforcontroller"](f6_arg0)
			f6_local4 = f6_local4:create("LootRNGResult")
			if f6_local4.successfulExchange and f6_local4.successfulExchange:get() then
				local f6_local5 = Engine[@"hash_6D80580D17461096"](f6_arg0, f6_local10.lootRule)
				if f6_local5 == "0" then
					f6_local5 = CoD.BlackMarketUtility.GetBribeStackWindowStartDate(f6_local10.name)
				end
				local f6_local6 = Engine[@"getcurrentutctimestr"]()
				local f6_local7 = CoD.BlackMarketUtility.GetBribeStackWindowSizeSeconds(f6_arg0, f6_local10.name)
				if Engine[@"hash_5A313AE346776CD8"](f6_arg0, f6_local10.lootRule, Engine[@"hash_4556671B48CC6BFE"](f6_local5, f6_local7, Engine[@"hash_647ACFFF824019CC"](Engine[@"hash_13FB8C7BE7B85704"](f6_local6, f6_local5), f6_local7))) then
					local f6_local8 = f6_local4:create("successfulExchange")
					f6_local8:set(false)
					Engine[@"storagewrite"](f6_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
				end
			end
		end
	end
end
CoD.BlackMarketUtility.SaveBribeMenuPurchase = function(f7_arg0)
	local f7_local0 = Engine[@"getmodelforcontroller"](f7_arg0)
	f7_local0 = f7_local0:create("LootRNGResult")
	if f7_local0.successfulExchange and f7_local0.successfulExchange:get() then
		local f7_local1 = Engine[@"hash_6D80580D17461096"](f7_arg0, CoD.BlackMarketUtility.BribeMenuLootRule)
		if not f7_local1 or f7_local1 == "0" then
			f7_local1 = CoD.BlackMarketUtility.GetBribeMenuWindowStartDate()
		end
		local f7_local2 = Engine[@"getcurrentutctimestr"]()
		local f7_local3 = CoD.BlackMarketUtility.GetBribeMenuWindowSizeSeconds(f7_arg0)
		if Engine[@"hash_5A313AE346776CD8"](f7_arg0, CoD.BlackMarketUtility.BribeMenuLootRule, Engine[@"hash_4556671B48CC6BFE"](f7_local1, f7_local3, Engine[@"hash_647ACFFF824019CC"](Engine[@"hash_13FB8C7BE7B85704"](f7_local2, f7_local1), f7_local3))) then
			local f7_local4 = f7_local0:create("successfulExchange")
			f7_local4:set(false)
			Engine[@"storagewrite"](f7_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		end
	end
end
CoD.BlackMarketUtility.TickBribeStack = function(f8_arg0)
	local f8_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "BribeStackTimer")
	f8_local0:create("cycled")
	local f8_local1 = false
	local f8_local2 = {}
	local f8_local3 = CoD.BlackMarketTableUtility.GetBribeStackInfo(f8_arg0)
	local f8_local4 = tostring(Engine[@"getcurrentutctimestr"]())
	local f8_local5 = f8_local0:create("currentTime")
	f8_local5:set(f8_local4)
	for f8_local11, f8_local12 in ipairs(f8_local3) do
		local f8_local8 = Engine[@"hash_6D80580D17461096"](f8_arg0, f8_local12.lootRule)
		if f8_local8 == "0" then
			f8_local8 = CoD.BlackMarketUtility.GetBribeStackWindowStartDate(f8_local12.stringName)
		end
		table.insert(f8_local2, {
			name = f8_local12.stringName,
			nextAvailableTime = f8_local8,
			lootRule = f8_local12.lootRule,
			hashName = f8_local12.bribeName,
		})
		local f8_local9 = Engine[@"getsecondsremainingserver"](f8_local8)
		if f8_local9 <= 0 then
			if f8_local0[f8_local12.stringName .. "_raw"] and f8_local0[f8_local12.stringName .. "_raw"]:get() > 0 then
				f8_local1 = true
			end
			f8_local9 = Engine[@"getsecondsremainingserver"](Engine[@"hash_2C778D3D40E06605"](f8_local8, CoD.BlackMarketUtility.GetBribeStackWindowSizeSeconds(f8_arg0, f8_local12.stringName)))
		elseif f8_local0[f8_local12.stringName .. "_raw"] and f8_local0[f8_local12.stringName .. "_raw"]:get() == 0 then
			f8_local1 = true
		end
		local f8_local10 = f8_local0:create(f8_local12.stringName)
		f8_local10:set(LuaUtils.SecondsToTimeRemainingString(f8_local9))
		f8_local10 = f8_local0:create(f8_local12.stringName .. "_raw")
		f8_local10:set(f8_local9)
		f8_local10 = f8_local0:create(f8_local12.stringName .. "_red")
		f8_local10:set(f8_local9 < 300)
	end
	if #f8_local2 ~= #CoD.BlackMarketUtility.BribeStack then
		f8_local1 = true
	else
		for f8_local11, f8_local12 in ipairs(f8_local2) do
			local f8_local8 = false
			for f8_local13, f8_local14 in ipairs(CoD.BlackMarketUtility.BribeStack) do
				if f8_local12.name == f8_local14.name then
					f8_local8 = true
				end
			end
			if f8_local8 == false then
				f8_local1 = true
			end
		end
	end
	CoD.BlackMarketUtility.BribeStack = f8_local2
	if f8_local1 then
		f8_local0.cycled:set(true)
		f8_local0.cycled:forceNotifySubscriptions()
	else
		f8_local0.cycled:set(false)
	end
end
CoD.BlackMarketUtility.TickBribeMenu = function(f9_arg0)
	local f9_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "BribeMenuTimer")
	f9_local0:create("cycled")
	f9_local0:create("countDown")
	local f9_local1 = false
	local f9_local2 = Engine[@"hash_6D80580D17461096"](f9_arg0, CoD.BlackMarketUtility.BribeMenuLootRule)
	if f9_local2 == "0" then
		f9_local2 = CoD.BlackMarketUtility.GetBribeMenuWindowStartDate()
	end
	local f9_local3 = Engine[@"getsecondsremainingserver"](f9_local2)
	if f9_local3 <= 0 then
		if f9_local0.bribe_menu_timer_raw and f9_local0.bribe_menu_timer_raw:get() > 0 and f9_local0.countDown:get() == false then
			f9_local1 = true
		end
		if Engine[@"getsecondsremainingserver"](Engine[@"hash_2C778D3D40E06605"](f9_local2, CoD.BlackMarketUtility.GetBribeMenuWindowSizeSeconds(f9_arg0))) < 0 then
			f9_local3 = 0
		end
		f9_local0.countDown:set(true)
	else
		if f9_local0.bribe_menu_timer_raw and f9_local0.bribe_menu_timer_raw:get() == 0 then
			f9_local1 = true
		end
		f9_local0.countDown:set(false)
	end
	local f9_local4 = f9_local0:create("bribe_menu_timer")
	f9_local4:set(LuaUtils.SecondsToTimeRemainingString(f9_local3))
	f9_local4 = f9_local0:create("bribe_menu_timer_raw")
	f9_local4:set(f9_local3)
	f9_local4 = f9_local0:create("bribe_menu_timer_red")
	f9_local4:set(f9_local3 < 300)
	if f9_local1 then
		f9_local0.cycled:set(true)
		f9_local0.cycled:forceNotifySubscriptions()
	else
		f9_local0.cycled:set(false)
	end
end
CoD.BlackMarketUtility.GetMyShopRotateTime = function()
	return Dvar[@"hash_439E2CD708BA96CF"]:get() or "43200"
end
CoD.BlackMarketUtility.GetMyShopRevealDelay = function()
	return Dvar[@"hash_DC178EB99D98BBA"]:get() or 0.25
end
CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime = function(f12_arg0, f12_arg1)
	local f12_local0 = "loot_itemshop_sunset_rotation_time_slot_" .. f12_arg1
	local f12_local1 = CoD.StoreUtility.GetExperimentModifier(f12_arg0, f12_local0)
	if not f12_local1 or f12_local1 == "" then
		f12_local1 = Engine[@"getdvarstring"](f12_local0)
		if not f12_local1 or f12_local1 == "" then
			f12_local1 = "43200"
		end
	end
	return f12_local1
end
CoD.BlackMarketUtility.GetItemShopSunsetSlotHistoryCount = function()
	return Dvar[@"hash_19773AE69A52FCB9"]:get() or 5
end
CoD.BlackMarketUtility.GetBlackJacksShopCycleTime = function()
	return Dvar[@"hash_4111196EBBD5D97"]:get() or 5
end
CoD.BlackMarketUtility.GetCurrentPostSeasonRef = function()
	return CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_ASSET_POSTSEASON)
end
CoD.BlackMarketUtility.GetCurrentPostSeasonAllRNGRef = function()
	return CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_ASSET_ALLRNG)
end
CoD.BlackMarketUtility.IsHalfOffTiers = function()
	return IsBooleanDvarSet(@"hash_49BEACE608DBF96A")
end
CoD.BlackMarketUtility.GetPaidTierCpPrice = function()
	if CoD.BlackMarketUtility.IsHalfOffTiers() then
		return CoD.BlackMarketUtility.PaidTierHalfOffCpPrice
	else
		return CoD.BlackMarketUtility.PaidTierCpPrice
	end
end
CoD.BlackMarketUtility.GetPaidTierSku = function()
	if CoD.BlackMarketUtility.IsHalfOffTiers() then
		return CoD.BlackMarketUtility.PaidTierHalfOffSKU
	else
		return CoD.BlackMarketUtility.PaidTierSKU
	end
end
CoD.BlackMarketUtility.AreContractsEnabled = function()
	if not CoD.BlackMarketUtility.AreCoDPointsEnabled() then
		return false
	elseif not Dvar[@"hash_FF90D457426F6B2"] or not Dvar[@"hash_FF90D457426F6B2"]:exists() then
		return false
	elseif not IsBooleanDvarSet(@"hash_FF90D457426F6B2") then
		return false
	else
		return true
	end
end
CoD.BlackMarketUtility.AreCoDPointsEnabled = function()
	if IsBooleanDvarSet(@"tu4_enablecodpoints") and not Engine[@"hash_5CB675CA7856DA25"]() then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.FillContrabandDropNumber = function()
	if Dvar[@"hash_543463271EA85EB"] then
		local f22_local0 = tonumber(Dvar[@"hash_543463271EA85EB"]:get())
		if f22_local0 == nil then
			return 0
		else
			return f22_local0
		end
	else
		return 0
	end
end
CoD.BlackMarketUtility.FillBackfill = function()
	if Dvar[@"hash_3462C66BD900924F"]:get() and tonumber(Dvar[@"hash_3462C66BD900924F"]:get()) > 0 then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.GetItemshopPlatform = function()
	if Engine[@"hash_25AE97B58D7132F3"]() == "orbis" then
		return "ps4"
	elseif Engine[@"hash_25AE97B58D7132F3"]() == "durango" then
		return "xbox"
	elseif Engine[@"hash_25AE97B58D7132F3"]() == "pc" then
		return "pc"
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: Platform not detected.'\n")
		return "unknown"
	end
end
CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex = function(f25_arg0)
	for f25_local3, f25_local4 in pairs(CoD.BlackMarketUtility.BlackjackShopSlotIndex) do
		if f25_local4 == f25_arg0 then
			return f25_local3
		end
	end
	return Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"]
end
CoD.BlackMarketUtility.WasItemCycled = function(f26_arg0, f26_arg1)
	local f26_local0 = f26_arg1:getModel()
	if f26_local0 and f26_local0.hashName and f26_local0.slot then
		local f26_local1 = f26_local0.hashName:get()
		local f26_local2 = f26_local0.slot:get()
		if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
			local f26_local3 = CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex(f26_local2)
			if f26_local3 ~= Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"] then
				local f26_local4 = Engine[@"hash_6F2CB6360236F359"](f26_arg0, f26_local3)
				return CoD.BlackMarketUtility.IsItemShopSunsetSlotItemOld(f26_arg0, f26_local4.reveal_expiration, f26_local4.itemId)
			end
		elseif f26_local2 == 4 then
			local f26_local3 = Engine[@"hash_12C2DB3D3E1B227E"](f26_arg0)
			if f26_local3 ~= nil and not CoD.BlackMarketUtility.IsMyShopItemOld(f26_arg0, f26_local3.timestamp, f26_local3.id) then
				return false
			end
		else
			for f26_local7, f26_local8 in ipairs(CoD.BlackMarketUtility["FeaturedSlot" .. f26_local2 .. "Items"]) do
				if f26_local1 == Engine[@"converttoxhash"](f26_local8.name) then
					return false
				end
			end
		end
	end
	if f26_local0 and not f26_local0.slot then
		return false
	end
	return true
end
CoD.BlackMarketUtility.WasDiscountCycled = function(f27_arg0, f27_arg1)
	local f27_local0 = f27_arg1:getModel()
	if f27_local0 and f27_local0.hashName and f27_local0.discountList then
		local f27_local1 = f27_local0.hashName:get()
		local f27_local2 = f27_local0.discountIndx:get()
		if f27_local2 then
			if f27_local2 == 0 or f27_local2 > 3 then
				return false
			elseif IsBooleanDvarSet(Engine[@"converttoxhash"]("loot_tier_discount" .. f27_local2 .. "_active")) and f27_local1 == Engine[@"converttoxhash"](Dvar["loot_tier_discount" .. f27_local2 .. "_bundle"]:get()) then
				return false
			end
		end
	end
	return true
end
CoD.BlackMarketUtility.TickReserveDeals = function(f28_arg0)
	local f28_local0 = CoD.BlackMarketUtility.GetItemshopPlatform()
	local f28_local1 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ReserveDealsRotation")
	f28_local1:create("cycled")
	local f28_local2 = false
	local f28_local3 = {}
	local f28_local4 = "gamedata/events/reserve_deals_schedule_" .. f28_local0 .. ".csv"
	local f28_local5 = Engine[@"gettablerowcount"](f28_local4)
	local f28_local6 = tostring(Engine[@"getcurrentutctimestr"]())
	local f28_local7 = f28_local1:create("currentTime")
	f28_local7:set(f28_local6)
	for f28_local7 = 0, f28_local5 - 1, 1 do
		local f28_local10 = Engine[@"tablelookupgetcolumnvalueforrow"](f28_local4, f28_local7, 0)
		local f28_local11 = Engine[@"tablelookupgetcolumnvalueforrow"](f28_local4, f28_local7, 1)
		local f28_local12 = Engine[@"tablelookupgetcolumnvalueforrow"](f28_local4, f28_local7, 2)
		if Engine[@"isinrange"](f28_local6, f28_local11, f28_local12) then
			table.insert(f28_local3, {
				name = f28_local10,
				start = f28_local11,
			})
			local f28_local13 = f28_local1:create(f28_local10)
			f28_local13:set(LuaUtils.SecondsToTimeRemainingString(Engine[@"getsecondsremainingserver"](f28_local12) + 1))
			f28_local13 = f28_local1:create(f28_local10 .. "_raw")
			f28_local13:set(Engine[@"getsecondsremainingserver"](f28_local12) + 1)
			f28_local13 = f28_local1:create(f28_local10 .. "_red")
			f28_local13:set(Engine[@"getsecondsremainingserver"](f28_local12) < 300)
		end
	end
	if #f28_local3 ~= #CoD.BlackMarketUtility.ReserveDeals then
		f28_local2 = true
	else
		for f28_local16, f28_local10 in ipairs(f28_local3) do
			local f28_local11 = false
			for f28_local14, f28_local15 in ipairs(CoD.BlackMarketUtility.ReserveDeals) do
				if f28_local10.name == f28_local15.name then
					f28_local11 = true
				end
			end
			if f28_local11 == false then
				f28_local2 = true
			end
		end
	end
	CoD.BlackMarketUtility.ReserveDeals = f28_local3
	if f28_local2 then
		f28_local1.cycled:set(true)
		f28_local1.cycled:forceNotifySubscriptions()
	else
		f28_local1.cycled:set(false)
	end
end
CoD.BlackMarketUtility.TickItemshop = function(f29_arg0)
	if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
		CoD.BlackMarketUtility.TickItemshopSunset(f29_arg0)
		return
	end
	local f29_local0 = CoD.BlackMarketUtility.GetItemshopPlatform()
	local f29_local1 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ItemshopRotation")
	f29_local1:create("cycled")
	local f29_local2 = false
	for f29_local3 = 1, CoD.BlackMarketUtility.ItemShopSlots, 1 do
		local f29_local6 = {}
		local f29_local7 = "loot_itemshop_slot" .. f29_local3 .. "_timer"
		local f29_local8 = "gamedata/events/itemshop_slot_" .. tostring(f29_local3) .. "_" .. f29_local0 .. ".csv"
		local f29_local9 = Engine[@"gettablerowcount"](f29_local8)
		local f29_local10 = nil
		local f29_local11 = tostring(Engine[@"getcurrentutctimestr"]())
		for f29_local12 = 0, f29_local9 - 1, 1 do
			local f29_local15 = Engine[@"tablelookupgetcolumnvalueforrow"](f29_local8, f29_local12, 0)
			local f29_local16 = Engine[@"tablelookupgetcolumnvalueforrow"](f29_local8, f29_local12, 1)
			local f29_local17 = Engine[@"isinrange"](f29_local11, f29_local16, Engine[@"tablelookupgetcolumnvalueforrow"](f29_local8, f29_local12, 2))
			local f29_local18 = CoD.BlackMarketTableUtility.GetItemShopInformation(f29_arg0, f29_local15)
			local f29_local19 = Engine[@"hash_3E78C83C300F9368"]()
			if f29_local19 then
				f29_local19 = f29_local18 and f29_local18.koreaExcluded ~= 0
			end
			if f29_local17 and not f29_local19 then
				table.insert(f29_local6, {
					name = f29_local15,
					start = f29_local16,
				})
			end
			if not f29_local19 and Engine[@"isgreaterthan"](f29_local16, f29_local11) then
				if f29_local10 then
					if Engine[@"isgreaterthan"](f29_local10, f29_local16) then
						f29_local10 = f29_local16
					end
				end
				f29_local10 = f29_local16
			end
		end
		if f29_local10 then
			f29_local12 = f29_local1:create(f29_local7)
			f29_local12:set(LuaUtils.SecondsToTimeRemainingString(Engine[@"getsecondsremainingserver"](f29_local10) + 1))
			f29_local12 = f29_local1:create(f29_local7 .. "_raw")
			f29_local12:set(Engine[@"getsecondsremainingserver"](f29_local10) + 1)
			f29_local12 = f29_local1:create(f29_local7 .. "_red")
			f29_local12:set(Engine[@"getsecondsremainingserver"](f29_local10) < 300)
		else
			local f29_local12 = f29_local1:create(f29_local7)
			f29_local12:set(LuaUtils.SecondsToTimeRemainingString(Engine[@"getsecondsremainingserver"](f29_local11) + 1))
			f29_local12 = f29_local1:create(f29_local7 .. "_raw")
			f29_local12:set(Engine[@"getsecondsremainingserver"](f29_local11) + 1)
			f29_local12 = f29_local1:create(f29_local7 .. "_red")
			f29_local12:set(Engine[@"getsecondsremainingserver"](f29_local11) < 300)
		end
		if #f29_local6 ~= #CoD.BlackMarketUtility["FeaturedSlot" .. f29_local3 .. "Items"] then
			f29_local2 = true
		end
		CoD.BlackMarketUtility["FeaturedSlot" .. f29_local3 .. "Items"] = f29_local6
	end
	local f29_local3 = Engine[@"hash_12C2DB3D3E1B227E"](f29_arg0)
	if f29_local3 ~= nil then
		local f29_local20 = Engine[@"getsecondsremainingserver"](Engine[@"hash_2C778D3D40E06605"](f29_local3.timestamp, CoD.BlackMarketUtility.GetMyShopRotateTime()))
		if f29_local20 <= 0 then
			f29_local20 = 0
		end
		local f29_local6 = f29_local1:create("loot_itemshop_slot4_timer_raw")
		if f29_local20 == 0 and f29_local20 ~= f29_local6:get() then
			f29_local2 = true
		end
		local f29_local7 = f29_local1:create("loot_itemshop_slot4_timer")
		f29_local7:set(LuaUtils.SecondsToTimeRemainingString(f29_local20))
		f29_local7 = f29_local1:create("loot_itemshop_slot4_timer_raw")
		f29_local7:set(f29_local20)
		f29_local7 = f29_local1:create("loot_itemshop_slot4_timer_red")
		f29_local7:set(f29_local20 < 300)
	else
		local f29_local4 = f29_local1:create("loot_itemshop_slot4_timer")
		f29_local4:set(LuaUtils.SecondsToTimeRemainingString(0))
		f29_local4 = f29_local1:create("loot_itemshop_slot4_timer_raw")
		f29_local4:set(0)
		f29_local4 = f29_local1:create("loot_itemshop_slot4_timer_red")
		f29_local4:set(0)
	end
	if f29_local2 then
		f29_local1.cycled:set(true)
		f29_local1.cycled:forceNotifySubscriptions()
	else
		f29_local1.cycled:set(false)
	end
end
CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
	local f30_local0 = false
	local f30_local1 = Engine[@"hash_6F2CB6360236F359"](f30_arg0, f30_arg3)
	if f30_local1 then
		local f30_local2 = Engine[@"getsecondsremainingserver"](f30_local1.reveal_expiration)
		if f30_local2 <= 0 then
			f30_local2 = 0
		end
		local f30_local3 = f30_arg1:create("loot_itemshop_" .. f30_arg2 .. "_timer_raw")
		if f30_local2 == 0 and f30_local2 ~= f30_local3:get() then
			f30_local0 = true
		end
		local f30_local4 = f30_arg1:create("loot_itemshop_" .. f30_arg2 .. "_timer")
		f30_local4:set(LuaUtils.SecondsToTimeRemainingString(f30_local2))
		f30_local4 = f30_arg1:create("loot_itemshop_" .. f30_arg2 .. "_timer_raw")
		f30_local4:set(f30_local2)
		f30_local4 = f30_arg1:create("loot_itemshop_" .. f30_arg2 .. "_timer_red")
		f30_local4:set(f30_local2 < 300)
	else
		local f30_local5 = f30_arg1:create("loot_itemshop_" .. f30_arg2 .. "_timer")
		f30_local5:set(LuaUtils.SecondsToTimeRemainingString(0))
		f30_local5 = f30_arg1:create("loot_itemshop_" .. f30_arg2 .. "_timer_raw")
		f30_local5:set(0)
		f30_local5 = f30_arg1:create("loot_itemshop_" .. f30_arg2 .. "_timer_red")
		f30_local5:set(0)
	end
	return f30_local0
end
CoD.BlackMarketUtility.TickItemshopSunset = function(f31_arg0)
	local f31_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ItemshopRotation")
	f31_local0:create("cycled")
	if CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer(f31_arg0, f31_local0, "slot1", Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"]) or CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer(f31_arg0, f31_local0, "slot2", Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"]) or CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer(f31_arg0, f31_local0, "slot3", Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]) then
		if not f31_local0.cycled:set(true) then
			f31_local0.cycled:forceNotifySubscriptions()
		end
	else
		f31_local0.cycled:set(false)
	end
end
CoD.BlackMarketUtility.GetEventName = function()
	local f32_local0 = Dvar[@"hash_3A7588CE8BBBC25D"]:get()
	if f32_local0 and f32_local0 ~= "" then
		return Engine[@"converttoxhash"](f32_local0)
	else
		return 0x0
	end
end
CoD.BlackMarketUtility.IsEventActive = function()
	local f33_local0 = Dvar[@"hash_3A7588CE8BBBC25D"]:get()
	if f33_local0 and f33_local0 ~= "" then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.GetCurrentSeasonPostSeasonStat = function()
	local f34_local0 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER)
	if f34_local0 then
		return f34_local0 - 1
	else
		return 0
	end
end
CoD.BlackMarketUtility.GetCurrentAllRNGStat = function()
	local f35_local0 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_HIGHEST_DROP_VERSION)
	if f35_local0 then
		return f35_local0 - 1
	else
		return 0
	end
end
CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers = function()
	local f36_local0 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_MAX_TIERS)
	if not f36_local0 then
		return 0
	else
		return f36_local0
	end
end
CoD.BlackMarketUtility.GetCurrentSeasonTier = function(f37_arg0)
	return Engine[@"hash_6159D7050715A2C3"](f37_arg0, CoDShared.Loot.GetCurrentSeason()) or 0
end
CoD.BlackMarketUtility.GetRarityIDForString = function(f38_arg0)
	for f38_local3, f38_local4 in pairs(CoD.BlackMarketUtility.CrateTypeIds) do
		if f38_local4 == f38_arg0 then
			return f38_local3
		end
	end
	return CoD.BlackMarketUtility.DropTypes.COMMON
end
CoD.BlackMarketUtility.GetLootRarityType = function(f39_arg0)
	for f39_local3, f39_local4 in pairs(CoD.BlackMarketUtility.LootRarityIds) do
		if f39_local4 == f39_arg0 then
			return f39_local3
		end
	end
	return nil
end
CoD.BlackMarketUtility.ConvertToLootDecalIndex = function(f40_arg0)
	local f40_local0 = 0
	for f40_local4 in string.gmatch(f40_arg0, "[^%s_]+") do
		f40_local0 = f40_local0 + 1
		if f40_local0 == 1 and f40_local4 ~= "decal" then
			break
		elseif f40_local0 == 2 then
			return f40_local4
		end
	end
	f40_local3 = Engine[@"tablelookup"](CoD.emblemIconsTable, 1, 3, f40_arg0)
	if f40_local3 and f40_local3 ~= "" then
		return f40_local3
	end
	return nil
end
CoD.BlackMarketUtility.ConvertToLootDecalIndexIfDecal = function(f41_arg0)
	return CoD.BlackMarketUtility.ConvertToLootDecalIndex(f41_arg0) or f41_arg0
end
CoD.BlackMarketUtility.SplitIdIntoTwoValues = function(f42_arg0)
	local f42_local0 = nil
	for f42_local4 in string.gmatch(f42_arg0, "[^%s;]+") do
		if f42_local0 == nil then
			f42_local0 = f42_local4
		end
		return f42_local0, f42_local4
	end
	if f42_local0 ~= nil then
		return f42_local0, ""
	end
	return "", ""
end
CoD.BlackMarketUtility.GetSpecialistThemeType = function(f43_arg0)
	if string.find(f43_arg0, "body") then
		return Enum[@"characteritemtype"][@"character_item_type_body"]
	else
		return Enum[@"characteritemtype"][@"character_item_type_helmet"]
	end
end
CoD.BlackMarketUtility.GetItemTypeStringForLootItem = function(f44_arg0, f44_arg1)
	if f44_arg1 == "camo" then
		local f44_local0, f44_local1 = CoD.BlackMarketUtility.SplitIdIntoTwoValues(f44_arg0)
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7207454DDA175F4", CoD.CACUtility.GetNameForItemRefString(f44_local1))
	elseif f44_arg1 == "specialist_outfit" then
		local f44_local0, f44_local1 = CoD.BlackMarketUtility.SplitIdIntoTwoValues(f44_arg0)
		local f44_local2 = @"hash_703EE7F32CB036F"
		if CoD.BlackMarketUtility.GetSpecialistThemeType(f44_local0) == Enum[@"characteritemtype"][@"character_item_type_body"] then
			f44_local2 = @"hash_2A8D47EEB89C4455"
		end
		return Engine[@"localize"](f44_local2, CoD.BlackMarketUtility.GetHeroDisplayNameForAssetName(f44_local1))
	elseif f44_arg1 == "reticle" then
		return CoD.BlackMarketUtility.CategoryStrings[f44_arg1]
	else
		return CoD.BlackMarketUtility.CategoryStrings[f44_arg1]
	end
end
CoD.BlackMarketUtility.GetCallingCardSetName = function(f45_arg0)
	return Engine[@"tablelookup"](CoD.BlackMarketUtility.lootTableName, 4, 0, f45_arg0)
end
CoD.BlackMarketUtility.GetNumOwnedAndTotalForCallingCardSet = function(f46_arg0, f46_arg1)
	local f46_local0 = Engine[@"tablefindrows"](CoD.BlackMarketUtility.lootTableName, 4, f46_arg1)
	local f46_local1 = 0
	local f46_local2 = 0
	if not f46_local0 then
		return 0, 0, 0
	end
	for f46_local3 = 1, #f46_local0, 1 do
		local f46_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f46_local0[f46_local3], CoD.BlackMarketUtility.lootNameCol)
		if not CoD.BlackMarketUtility.IsItemLocked(f46_arg0, f46_local6) then
			f46_local1 = f46_local1 + 1
			local f46_local7 = CoD.BlackMarketUtility.GetLootCallingCardIndex(f46_arg0, f46_local6)
			if f46_local7 and Engine[@"isemblembackgroundnew"](f46_arg0, f46_local7) then
				f46_local2 = f46_local2 + 1
			end
		end
	end
	return f46_local1, #f46_local0, f46_local2
end
CoD.BlackMarketUtility.GetSetNumOwnedAndTotalForCallingCard = function(f47_arg0, f47_arg1)
	local f47_local0 = CoD.BlackMarketUtility.GetCallingCardSetName(f47_arg1)
	if f47_local0 == nil or f47_local0 == "" then
		return 0, 0, 0
	else
		return CoD.BlackMarketUtility.GetNumOwnedAndTotalForCallingCardSet(f47_arg0, f47_local0)
	end
end
CoD.BlackMarketUtility.GetRewardAndCategoryForItem = function(f48_arg0)
	local f48_local0 = 0
	local f48_local1 = 2
	local f48_local2 = Engine[@"tablefindrows"](CoD.BlackMarketUtility.lootTableName, 5, f48_arg0)
	if f48_local2 ~= nil then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f48_local2[1], f48_local0), Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f48_local2[1], f48_local1)
	else
		return nil, nil
	end
end
CoD.BlackMarketUtility.IsUnavailableBlackMarketItem = function(f49_arg0, f49_arg1, f49_arg2)
	if f49_arg2 and (not f49_arg1 or f49_arg1.isLoot) then
		f49_arg1 = CoD.BlackMarketTableUtility.LootInfoLookup(f49_arg0, f49_arg2)
	end
	local f49_local0 = f49_arg1
	local f49_local1
	if not f49_arg1.owned then
		f49_local1 = not f49_arg1.available
	else
		f49_local1 = false
	end
	return f49_local1
end
CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem = function(f50_arg0)
	local f50_local0 = 0
	local f50_local1
	if f50_arg0 == nil or f50_arg0 ~= Engine[@"tablelookup"](CoD.BlackMarketUtility.unreleasedLootTableName, f50_local0, f50_local0, f50_arg0) then
		f50_local1 = false
	else
		f50_local1 = true
	end
	return f50_local1
end
CoD.BlackMarketUtility.IsBlackMarketItem = function(f51_arg0)
	local f51_local0 = 0
	return f51_arg0 == Engine[@"tablelookup"](CoD.BlackMarketUtility.lootTableName, f51_local0, f51_local0, f51_arg0)
end
CoD.BlackMarketUtility.IsReleasedBlackMarketItem = function(f52_arg0)
	local f52_local0
	if f52_arg0 ~= nil then
		f52_local0 = CoD.BlackMarketUtility.IsBlackMarketItem(f52_arg0)
		if f52_local0 then
			f52_local0 = not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(f52_arg0)
		end
	else
		f52_local0 = false
	end
	return f52_local0
end
CoD.BlackMarketUtility.GetSafeReward = function(f53_arg0, f53_arg1)
	local f53_local0 = f53_arg0
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and f53_arg1 == @"calling_card" then
		local f53_local1 = 3
		local f53_local2 = 19
		f53_local0 = Engine[@"tablelookup"](CoD.backgroundsTable, f53_local2, f53_local1, f53_arg0)
		if not f53_local0 or f53_local0 == 0x0 then
			f53_local0 = Engine[@"tablelookup"](CoD.backgroundsTable, f53_local2, 15, f53_arg0)
		end
		if not f53_local0 or f53_local0 == 0x0 then
			f53_local0 = f53_arg0
		end
	end
	return f53_local0
end
CoD.BlackMarketUtility.GetSafeBonusSetMasterNameHash = function(f54_arg0, f54_arg1)
	local f54_local0 = f54_arg0
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and f54_arg1 == @"calling_card" then
		f54_local0 = Engine[@"tablelookup"](CoD.backgroundsTable, 19, 15, f54_arg0)
		if not f54_local0 or f54_local0 == 0x0 then
			f54_local0 = f54_arg0
		end
	end
	return f54_local0
end
CoD.BlackMarketUtility.GetSetPieceStringForLootItem = function(f55_arg0, f55_arg1, f55_arg2)
	if f55_arg2 == "calling_card" then
		local f55_local0, f55_local1 = CoD.BlackMarketUtility.GetSetNumOwnedAndTotalForCallingCard(f55_arg0, f55_arg1)
		if f55_local1 > 0 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FB55139FE22C27D", f55_local0, f55_local1)
		end
	end
	return ""
end
CoD.BlackMarketUtility.GetSetPieceStringForLootSet = function(f56_arg0, f56_arg1, f56_arg2)
	if f56_arg2 == "calling_card" then
		local f56_local0, f56_local1 = CoD.BlackMarketUtility.GetNumOwnedAndTotalForCallingCardSet(f56_arg0, f56_arg1)
		if f56_local1 > 0 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_74DCD63ACA0BFEEE", f56_local0, f56_local1)
		end
	end
	return ""
end
CoD.BlackMarketUtility.GetCurrentRank = function(f57_arg0)
	local f57_local0 = Engine[@"getplayerstats"](f57_arg0)
	return f57_local0.PlayerStatsList.RANK.statValue:get()
end
CoD.BlackMarketUtility.GetItemLockedTextAndAvailability = function(f58_arg0, f58_arg1, f58_arg2)
	if f58_arg2 == "camo" then
		local f58_local0 = Enum[@"emodes"][@"mode_multiplayer"]
		local f58_local1 = CoD.BlackMarketUtility.GetCurrentRank(f58_arg0)
		local f58_local2, f58_local3 = CoD.BlackMarketUtility.SplitIdIntoTwoValues(f58_arg1)
		local f58_local4 = Engine[@"getitemindexfromreference"](f58_local3, f58_local0)
		local f58_local5 = Engine[@"getitemunlocklevel"](f58_local4, f58_local0)
		if f58_local1 < f58_local5 then
			return Engine[@"getitemname"](f58_local4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f58_local0), Engine[@"hash_4F9F1239CFD921FE"](@"hash_4330A21A2C49C8A7", CoD.GetRankName(f58_local5, 0, f58_local0), "" .. f58_local5 + 1)
		end
	end
	return nil, nil
end
CoD.BlackMarketUtility.GetLootCallingCardIndex = function(f59_arg0, f59_arg1)
	local f59_local0 = 3
	local f59_local1 = 19
	local f59_local2 = 1
	local f59_local3 = nil
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f59_local3 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f59_local2, f59_local1, f59_arg1)
	end
	if not f59_local3 then
		f59_local3 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f59_local2, f59_local0, f59_arg1)
	end
	return tonumber(f59_local3)
end
CoD.BlackMarketUtility.GetLootEmblemIndexParams = function(f60_arg0, f60_arg1)
	local f60_local0 = 0
	local f60_local1 = 1
	local f60_local2 = 2
	local f60_local3 = Engine[@"tablefindrows"](CoD.BlackMarketUtility.lootEmblemTableName, f60_local0, f60_arg1)
	if f60_local3 then
		return f60_arg0, tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootEmblemTableName, f60_local3[1], f60_local1)), Enum[@"storagefiletype"][Engine[@"converttoxhash"](Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootEmblemTableName, f60_local3[1], f60_local2))]
	else
		return f60_arg0, 0, Enum[@"storagefiletype"][@"storage_default_emblems"]
	end
end
CoD.BlackMarketUtility.GetLootEmblemIDName = function(f61_arg0)
	local f61_local0 = 1
	local f61_local1 = 1
	local f61_local2 = 2
	return Engine[@"tablelookup"](CoD.BlackMarketUtility.lootEmblemTableName, f61_local0, f61_local1, f61_arg0)
end
CoD.BlackMarketUtility.GetLootBackgroundName = function(f62_arg0, f62_arg1)
	return Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, 3, 1, f62_arg1)
end
CoD.BlackMarketUtility.GetLootDecalName = function(f63_arg0, f63_arg1)
	return Engine[@"tablelookup"](CoD.BlackMarketUtility.emblemIconsTableName, 3, 1, f63_arg1)
end
CoD.BlackMarketUtility.GetLootDecalEntitlementName = function(f64_arg0, f64_arg1)
	return Engine[@"tablelookup"](CoD.BlackMarketUtility.emblemIconsTableName, 7, 1, f64_arg1)
end
CoD.BlackMarketUtility.GetStickerNameRef = function(f65_arg0)
	return Engine[@"tablelookup"](CoD.BlackMarketUtility.emblemIconsTableName, 4, 3, f65_arg0)
end
CoD.BlackMarketUtility.GetJumpPackRefs = function(f66_arg0)
	local f66_local0 = 0x0
	local f66_local1 = 0x0
	local f66_local2 = 0x0
	for f66_local6, f66_local7 in ipairs(Engine[@"hash_7A7E3CD65E63086F"](@"jumpkits")) do
		if f66_local7[@"lootid"] == f66_arg0 then
			f66_local0 = f66_local7[@"displayname"]
			if f66_local7[@"preview_image"] then
				f66_local1 = Engine[@"converttoxhash"](f66_local7[@"preview_image"])
			end
			if f66_local7[@"image"] then
				f66_local2 = Engine[@"converttoxhash"](f66_local7[@"image"])
			end
			if f66_local2 and f66_local1 == 0x0 then
			elseif f66_local1 and f66_local2 == 0x0 then
				f66_local2 = f66_local1
				break
			end
			f66_local1 = f66_local2
		end
	end
	return f66_local0, f66_local1, f66_local2
end
CoD.BlackMarketUtility.GetParachuteRefs = function(f67_arg0)
	local f67_local0 = 0x0
	local f67_local1 = 0x0
	local f67_local2 = 0x0
	for f67_local8, f67_local9 in ipairs(Engine[@"hash_7A7E3CD65E63086F"](@"jumpkits")) do
		if f67_local9[@"lootid"] == f67_arg0 then
			f67_local0 = f67_local9[@"displayname"]
			local f67_local6 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f67_local9[@"parachute"]))
			if f67_local6[@"icon"] then
				local f67_local7 = Engine[@"converttoxhash"](f67_local6[@"icon"])
				f67_local1 = f67_local7
				f67_local2 = Engine[@"converttoxhash"](f67_local6[@"largeicon"]) or f67_local7
			end
		end
	end
	return f67_local0, f67_local1, f67_local2
end
CoD.BlackMarketUtility.GetWingsuitRefs = function(f68_arg0)
	local f68_local0 = 0x0
	local f68_local1 = 0x0
	local f68_local2 = 0x0
	for f68_local8, f68_local9 in ipairs(Engine[@"hash_7A7E3CD65E63086F"](@"jumpkits")) do
		if f68_local9[@"lootid"] == f68_arg0 then
			f68_local0 = f68_local9[@"displayname"]
			local f68_local6 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f68_local9[@"wingsuit"]))
			if f68_local6[@"icon"] then
				local f68_local7 = Engine[@"converttoxhash"](f68_local6[@"icon"])
				f68_local1 = f68_local7
				f68_local2 = Engine[@"converttoxhash"](f68_local6[@"largeicon"]) or f68_local7
			end
		end
	end
	return f68_local0, f68_local1, f68_local2
end
CoD.BlackMarketUtility.GetTrailRefs = function(f69_arg0)
	local f69_local0 = 0x0
	local f69_local1 = 0x0
	local f69_local2 = 0x0
	for f69_local8, f69_local9 in ipairs(Engine[@"hash_7A7E3CD65E63086F"](@"jumpkits")) do
		if f69_local9[@"lootid"] == f69_arg0 then
			f69_local0 = f69_local9[@"displayname"]
			local f69_local6 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f69_local9[@"hash_4F69520E335E1DC6"]))
			if f69_local6[@"icon"] then
				local f69_local7 = Engine[@"converttoxhash"](f69_local6[@"icon"])
				f69_local1 = f69_local7
				f69_local2 = Engine[@"converttoxhash"](f69_local6[@"largeicon"]) or f69_local7
			end
		end
	end
	return f69_local0, f69_local1, f69_local2
end
CoD.BlackMarketUtility.GetDeathFxWeaponRef = function(f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4)
	local f70_local0 = 0x0
	if f70_arg2 == LuaEnum.LOOT_TYPE.SEASON then
		f70_local0 = CoD.BlackMarketTableUtility.GetSeasonDeathFxWeaponName(f70_arg0, f70_arg1)
	elseif f70_arg2 == LuaEnum.LOOT_TYPE.CONTRACT then
		f70_local0 = CoD.BlackMarketTableUtility.GetContractDeathFxWeaponName(f70_arg0, f70_arg1, f70_arg3)
	elseif f70_arg2 == LuaEnum.LOOT_TYPE.ITEMSHOP then
		f70_local0 = CoD.BlackMarketTableUtility.GetItemShopDeathFxWeaponName(f70_arg0, f70_arg1)
	elseif f70_arg2 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f70_local0 = CoD.BlackMarketTableUtility.GetContrabandDeathFxWeaponName(f70_arg0, f70_arg4)
	elseif f70_arg2 == LuaEnum.LOOT_TYPE.BUNDLE then
		f70_local0 = CoD.BlackMarketTableUtility.GetBundleDeathFxWeaponName(f70_arg0, f70_arg1)
	end
	return f70_local0
end
CoD.BlackMarketUtility.GetDeathFxRefs = function(f71_arg0)
	local f71_local0 = 0x0
	local f71_local1 = 0x0
	local f71_local2 = 0x0
	local f71_local3 = Engine[@"hash_7A7E3CD65E63086F"](@"hash_A8F031F7C7B2ED8")
	if f71_local3 then
		for f71_local7, f71_local8 in ipairs(f71_local3) do
			if f71_local8[@"lootid"] == f71_arg0 then
				f71_local0 = f71_local8[@"displayname"]
				f71_local1 = f71_local8[@"previewimage"]
				if f71_local8[@"image"] then
					f71_local2 = Engine[@"converttoxhash"](f71_local8[@"image"])
				end
				return f71_local0, f71_local1, f71_local2
			end
		end
	end
	return f71_local0, f71_local1, f71_local2
end
CoD.BlackMarketUtility.GetWeaponCharmRefs = function(f72_arg0)
	local f72_local0 = 0x0
	local f72_local1 = 0x0
	local f72_local2 = 0x0
	local f72_local3 = Engine[@"hash_7A7E3CD65E63086F"](@"hash_5F2DC7A2FE7EEDC5")
	if f72_local3 then
		for f72_local7, f72_local8 in ipairs(f72_local3) do
			if f72_local8[@"lootid"] == f72_arg0 then
				f72_local0 = f72_local8[@"displayname"]
				f72_local1 = f72_local8[@"previewimage"]
				if f72_local8[@"image"] then
					f72_local2 = Engine[@"converttoxhash"](f72_local8[@"image"])
				end
				return f72_local0, f72_local1, f72_local2
			end
		end
	end
	return f72_local0, f72_local1, f72_local2
end
CoD.BlackMarketUtility.GetCallingCardTitleFromImage = function(f73_arg0)
	local f73_local0 = 3
	local f73_local1 = 4
	local f73_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f73_local1, f73_local0, f73_arg0)
	if not f73_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f73_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f73_local1, 19, f73_arg0)
	end
	return f73_local2
end
CoD.BlackMarketUtility.GetCallingCardTitleFromMasterImage = function(f74_arg0)
	local f74_local0 = 15
	local f74_local1 = 4
	local f74_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f74_local1, f74_local0, f74_arg0)
	if not f74_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f74_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f74_local1, 19, f74_arg0)
	end
	return f74_local2
end
CoD.BlackMarketUtility.GetCallingCardIdFromImage = function(f75_arg0)
	local f75_local0 = 3
	local f75_local1 = 1
	local f75_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f75_local1, f75_local0, f75_arg0)
	if not f75_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f75_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f75_local1, 19, f75_arg0)
	end
	return f75_local2
end
CoD.BlackMarketUtility.GetMasterCallingCardIdFromImage = function(f76_arg0)
	local f76_local0 = 15
	local f76_local1 = 1
	local f76_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f76_local1, f76_local0, f76_arg0)
	if not f76_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f76_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f76_local1, 19, f76_arg0)
	end
	return f76_local2
end
CoD.BlackMarketUtility.GetCallingCardSortKeyFromImage = function(f77_arg0)
	local f77_local0 = 3
	local f77_local1 = 2
	local f77_local2 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f77_local1, f77_local0, f77_arg0)
	if not f77_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		cardId = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, f77_local1, 19, f77_arg0)
	end
	return f77_local2
end
CoD.BlackMarketUtility.GetRarityForCallingCardSetFromSetName = function(f78_arg0)
	return CoD.BlackMarketUtility.CrateTypeStrings[CoD.BlackMarketUtility.GetRarityIDForString(Engine[@"tablelookup"](CoD.BlackMarketUtility.lootTableName, 3, 4, f78_arg0))]
end
CoD.BlackMarketUtility.GetRarityTypeForLootItemFromName = function(f79_arg0)
	return Engine[@"tablelookup"](CoD.BlackMarketUtility.lootTableName, 3, 1, f79_arg0)
end
CoD.BlackMarketUtility.GetRarityForLootItemFromName = function(f80_arg0)
	local f80_local0 = CoD.BlackMarketUtility.GetRarityTypeForLootItemFromName(f80_arg0)
	if f80_local0 == "" then
		return ""
	else
		return CoD.BlackMarketUtility.CrateTypeStrings[CoD.BlackMarketUtility.GetRarityIDForString(f80_local0)]
	end
end
CoD.BlackMarketUtility.GetHeroDisplayNameForAssetName = function(f81_arg0)
	for f81_local3, f81_local4 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Enum[@"emodes"][@"mode_multiplayer"])) do
		if f81_local4.assetName == f81_arg0 then
			return f81_local4.displayName
		end
	end
	return f81_arg0
end
f0_local0 = {
	{
		"camo_ce_bo3;ar_damage",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;ar_fastburst",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;ar_longburst",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;ar_marksman",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;lmg_cqb",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;lmg_heavy",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;lmg_light",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;lmg_slowfire",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;sniper_fastbolt",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;sniper_fastsemi",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;sniper_powerbolt",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;sniper_chargeshot",
		"camo",
		"common",
	},
	{
		"camo_ce_bo3;shotgun_fullauto",
		"camo",
		"rare",
	},
	{
		"camo_ce_bo3;shotgun_precision",
		"camo",
		"epic",
	},
	{
		"t7_loot_callingcard_dinosaurs_05",
		"calling_card",
		"rare",
	},
	{
		"t7_loot_callingcard_luchalibre_06",
		"calling_card",
		"legendary",
	},
	{
		"t7_loot_callingcard_space_airbrush_04",
		"calling_card",
		"rare",
	},
	{
		"t7_loot_callingcard_tiki",
		"calling_card",
		"common",
	},
	{
		"t7_loot_callingcard_spyposter",
		"calling_card",
		"common",
	},
	{
		"t7_loot_callingcard_twistedcircus_ringmaster",
		"calling_card",
		"rare",
	},
	{
		"t7_loot_callingcard_stylizedtanks",
		"calling_card",
		"common",
	},
	{
		"t7_loot_callingcard_epicspacebattle_6",
		"calling_card",
		"legendary",
	},
	{
		"t7_loot_callingcard_folkheroes",
		"calling_card",
		"common",
	},
	{
		"t7_loot_callingcard_manga_cockpit",
		"calling_card",
		"rare",
	},
	{
		"t7_loot_callingcard_epicspacebattle_12",
		"calling_card",
		"legendary",
	},
	{
		"t7_loot_callingcard_deepsea_f",
		"calling_card",
		"legendary",
	},
	{
		"t7_loot_callingcard_girlpower_01",
		"calling_card",
		"legendary",
	},
	{
		"t7_loot_callingcard_tomb",
		"calling_card",
		"common",
	},
	{
		"t7_loot_callingcard_legendaryanimals_centaur",
		"calling_card",
		"rare",
	},
	{
		"t7_loot_callingcard_space_airbrush_08",
		"calling_card",
		"rare",
	},
}
CoD.BlackMarketUtility.GetFakeItem = function(f82_arg0)
	return f0_local0[math.random(1, #f0_local0)]
end
CoD.BlackMarketUtility.GetOutfitOptionInfo = function(f83_arg0, f83_arg1)
	local f83_local0 = {}
	local f83_local1 = ""
	local f83_local2 = function(f84_arg0, f84_arg1)
		if f84_arg0 and 0 <= f84_arg0 then
			if f84_arg1 ~= Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
				table.insert(f83_local0, f84_arg1)
			end
			f83_local1 = f83_local1 .. tostring(f84_arg0) .. ";"
		else
			f83_local1 = f83_local1 .. "0;"
		end
	end
	f83_local2(f83_arg1.armsIndex, Enum[@"characteritemtype"][@"hash_141B42F0A58AC50F"])
	f83_local2(f83_arg1.decalIndex, Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"])
	f83_local2(f83_arg1.headIndex, Enum[@"characteritemtype"][@"hash_37AD40A4111A72FE"])
	f83_local2(f83_arg1.headgearIndex, Enum[@"characteritemtype"][@"hash_4FF8573E011622F4"])
	f83_local2(f83_arg1.legsIndex, Enum[@"characteritemtype"][@"hash_283CBB806B732B11"])
	f83_local2(f83_arg1.paletteIndex, Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"])
	f83_local2(f83_arg1.torsoIndex, Enum[@"characteritemtype"][@"hash_19DDCEC39BA98B97"])
	f83_local2(f83_arg1.war_paintIndex, Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"])
	return f83_local0, f83_local1
end
CoD.BlackMarketUtility.PreviewingCharacterFace = function(f85_arg0, f85_arg1)
	local f85_local0, f85_local1 = CoD.BlackMarketUtility.GetOutfitOptionInfo(f85_arg0, f85_arg1)
	local f85_local2 = false
	local f85_local3 = false
	for f85_local7, f85_local8 in ipairs(f85_local0) do
		if f85_local8 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] or f85_local8 == Enum[@"characteritemtype"][@"hash_37AD40A4111A72FE"] or f85_local8 == Enum[@"characteritemtype"][@"hash_4FF8573E011622F4"] then
			f85_local2 = true
		else
			f85_local3 = true
		end
	end
	if f85_local2 and not f85_local3 then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.NotifyPreviewOutfit = function(f86_arg0, f86_arg1, f86_arg2)
	local f86_local0, f86_local1 = CoD.BlackMarketUtility.GetOutfitOptionInfo(f86_arg0, f86_arg1)
	Engine[@"sendclientscriptnotify"](f86_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f86_arg0), {
		event_name = f86_arg2,
		mode = f86_arg1.mode,
		character_index = f86_arg1.characterIndex,
		outfit_index = f86_arg1.outfitIndex,
		outfitItems = f86_local1,
	})
	return f86_local0
end
CoD.BlackMarketUtility.NotifyLoadCharacterForGesture = function(f87_arg0, f87_arg1)
	Engine[@"sendclientscriptnotify"](f87_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f87_arg0), {
		event_name = "previewShopGesture",
		mode = f87_arg1.mode,
		character_index = f87_arg1.characterIndex,
	})
end
CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection = function(f88_arg0, f88_arg1, f88_arg2)
	f88_arg2 = f88_arg2.activeWidget or f88_arg2
	local f88_local0 = f88_arg2:getModel()
	local f88_local1 = "default"
	if not f88_local0 then
		f88_arg0._lastState = f88_local1
		SendClientScriptMenuChangeNotifyWithState(f88_arg1, f88_arg0, true, f88_local1)
		return
	elseif f88_arg0._lastState == "gesture" then
		CoD.PlayerRoleUtility.StopGesturePreview(f88_arg0, f88_arg1)
		CoD.PlayerRoleUtility.RefreshAnim(f88_arg1)
	elseif f88_arg0._lastState == "weapon" then
		CoD.BlackMarketUtility.ResetSignatureWeaponState(f88_arg0)
		SendClientScriptMenuChangeNotifyWithState(f88_arg1, f88_arg0, true, "default")
	end
	if (not f88_local0.isWeaponBribeSelect or not f88_local0.isWeaponBribeSelect:get()) and CoD.ModelUtility.IsSelfModelValueNonEmptyString(f88_arg2, f88_arg1, "popupImage") then
		SendClientScriptMenuChangeNotifyWithState(f88_arg1, f88_arg0, true, f88_local1)
		return
	elseif not f88_local0.cameraType or not f88_local0.isContract then
		f88_arg0._lastState = f88_local1
		SendClientScriptMenuChangeNotifyWithState(f88_arg1, f88_arg0, true, f88_local1)
		return
	elseif f88_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.WEAPON then
		local f88_local2 = f88_arg2
		if f88_arg2.contractModels and f88_local0.isContract:get() then
			f88_local2 = f88_arg2.contractModels
		end
		if f88_local0.contractModels and f88_local0.isContract:get() then
			f88_local0 = f88_local0.contractModels
		end
		if f88_local2.signatureWeaponInfo and f88_local0 ~= nil and f88_local2.signatureWeaponInfo.ref == f88_local0.weaponRef:get() then
			f88_local1 = "weapon"
			CoD.BlackMarketUtility.SendSignatureWeaponUpdate(f88_arg0, f88_arg1, f88_local0, f88_local2.signatureWeaponInfo)
		elseif f88_local2.baseWeaponInfo and f88_local0 ~= nil then
			f88_local1 = "weapon"
			CoD.BlackMarketUtility.SendWeaponUpdate(f88_arg0, f88_arg1, f88_local0, f88_local2.baseWeaponInfo, f88_local2.camoRef)
		end
	elseif f88_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.GESTURE then
		if f88_arg2.characterIndex ~= nil then
			f88_local1 = "gesture"
			CoD.BlackMarketUtility.NotifyLoadCharacterForGesture(f88_arg1, f88_arg2)
		end
	elseif f88_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.CHARACTER then
		local f88_local2 = f88_arg2
		if f88_arg2.contractModels and f88_local0.isContract:get() then
			f88_local2 = f88_arg2.contractModels.outfitIndexes
		end
		if f88_local2 ~= nil and f88_local2.characterIndex ~= nil and f88_local2.outfitIndex ~= nil then
			CoD.BlackMarketUtility.NotifyPreviewOutfit(f88_arg1, f88_local2, "previewShop")
			f88_local1 = "character"
		end
	elseif f88_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.WARPAINT then
		local f88_local2 = f88_arg2
		if f88_arg2.contractModels and f88_local0.isContract:get() then
			f88_local2 = f88_arg2.contractModels.outfitIndexes
		end
		if f88_local2 ~= nil and f88_local2.characterIndex ~= nil and f88_local2.outfitIndex ~= nil then
			CoD.BlackMarketUtility.NotifyPreviewOutfit(f88_arg1, f88_local2, "previewShopFace")
			f88_local1 = "character_face"
		end
	elseif f88_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.CRATE then
		f88_local1 = "crate"
	end
	f88_arg0._lastState = f88_local1
	SendClientScriptMenuChangeNotifyWithState(f88_arg1, f88_arg0, true, f88_local1)
end
CoD.BlackMarketUtility.GetEmptyInsertItem = function(f89_arg0, f89_arg1)
	return {
		itemName = @"hash_0",
		name = @"hash_0",
		desc = "",
		mainExtraText = "",
		subExtraText = @"hash_0",
		category = @"hash_0",
		shopCategory = @"hash_0",
		primaryImage = @"blacktransparent",
		popupImage = @"blacktransparent",
		detailsImage = @"blacktransparent",
		rarity = @"hash_0",
		character = @"hash_0",
		outfitIndexes = nil,
		gesture_index = -1,
		signatureWeaponInfo = nil,
		baseWeaponInfo = nil,
		camoRef = nil,
		setBonusImage = @"hash_0",
		setComplete = false,
		setNumOwned = 0,
		setNumTotal = 0,
		tier = f89_arg0,
		unlocked = f89_arg1,
		dupe = false,
		reroll = false,
		gap = false,
		lootType = LuaEnum.LOOT_TYPE.EMPTY,
		isBundle = false,
		seasonal = false,
		allowFrozenMoment = false,
		price = 0,
		inventoryIcon = @"blacktransparent",
		earnedRewardCount = 0,
		totalRewardCount = 0,
		cameraType = LuaEnum.LOOT_CAMERA_TYPE.NONE,
		isContract = false,
		purchased = false,
		movieName = "",
		toolTipText = @"hash_0",
	}
end
CoD.BlackMarketUtility.ActivateContract = function(f90_arg0, f90_arg1, f90_arg2)
	if f90_arg2 ~= CoDShared.Loot.ContractSlots.SLOT_1 and f90_arg2 ~= CoDShared.Loot.ContractSlots.SLOT_2 then
		return false
	else
		local f90_local0 = CoD.BlackMarketTableUtility.GetContractId(f90_arg1)
		if f90_local0 == nil or f90_local0 == 0 then
			return false
		else
			local f90_local1 = Engine[@"storagegetbuffer"](f90_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
			if f90_local1 == nil then
				return false
			else
				local f90_local2 = f90_local1[@"loot_contracts"][f90_arg2]
				if f90_local2 ~= nil then
					f90_local2.contractId:set(f90_local0)
					local f90_local3 = CoD.BlackMarketTableUtility.GetContractTierCount(f90_local0) - CoD.BlackMarketUtility.GetContractProgress(f90_arg0, f90_arg1)
					if f90_local3 < 0 then
						f90_local3 = 0
					end
					local f90_local4 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f90_arg0)
					local f90_local5 = 0
					if f90_local4 ~= nil then
						f90_local5 = f90_local4 + f90_local3
					end
					f90_local2.completionTier:set(f90_local5)
					Engine[@"storagewrite"](f90_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
					Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Contracts: Contract '" .. f90_local0 .. "' activated for controller " .. f90_arg0 .. ".\n")
					return true
				else
					return false
				end
			end
		end
	end
end
CoD.BlackMarketUtility.GetContractProgress = function(f91_arg0, f91_arg1)
	return Engine[@"hash_6159D7050715A2C3"](f91_arg0, f91_arg1)
end
CoD.BlackMarketUtility.IsContractCompleted = function(f92_arg0, f92_arg1)
	local f92_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f92_arg1)
	return CoD.BlackMarketTableUtility.GetContractTierCount(f92_local0.id) <= CoD.BlackMarketUtility.GetContractProgress(f92_arg0, f92_local0.namehash)
end
CoD.BlackMarketUtility.GetActiveContracts = function(f93_arg0)
	local f93_local0 = Engine[@"storagegetbuffer"](f93_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	if f93_local0 == nil then
		return {}
	end
	local f93_local1 = {}
	for f93_local7, f93_local8 in pairs(CoDShared.Loot.ContractSlots) do
		local f93_local9 = f93_local0[@"loot_contracts"][f93_local8]
		if f93_local9 ~= nil then
			local f93_local5 = f93_local9.contractId:get()
			if f93_local5 > 0 then
				local f93_local6 = CoD.BlackMarketTableUtility.GetContractInfo(f93_local5)
				if f93_local6 ~= nil then
					f93_local6.slot = f93_local8
					table.insert(f93_local1, f93_local6)
				end
			end
		end
	end
	return f93_local1
end
CoD.BlackMarketUtility.GetTierItemsForContractTab = function(f94_arg0, f94_arg1, f94_arg2, f94_arg3)
	local f94_local0 = {}
	if Dvar[@"hash_4467C80C4ECD6FC8"]:get() == false then
	else
	end
	local f94_local1 = CoD.BlackMarketTableUtility.GetContractInfo(f94_arg1)
	if f94_local1 == nil then
		return {}
	end
	local f94_local2 = CoD.BlackMarketUtility.GetContractProgress(f94_arg0, f94_local1.namehash)
	for f94_local3 = f94_arg2, f94_arg3, 1 do
		local f94_local6 = f94_local3 <= f94_local2
		local f94_local7 = CoD.BlackMarketTableUtility.GetContractItemsByTier(f94_arg0, f94_arg1, f94_local3, f94_local6)
		local f94_local8 = CoD.BlackMarketUtility.GetEmptyInsertItem(f94_local3, f94_local6)
		if f94_local7 ~= nil and #f94_local7 ~= 0 and f94_local7[1].name ~= nil and f94_local7[1].name ~= 0x0 and f94_local7[1].category ~= nil and f94_local7[1].rarity ~= nil then
			local f94_local9 = {}
			f94_local9 = CoD.BlackMarketUtility.GetItemRefs(f94_arg0, f94_local7[1].name, f94_local7[1].category, f94_local7[1].rarity, f94_local7[1].inSet, f94_arg1, f94_local7[1].lootType, f94_local7[1].refOptic, f94_local7[1].itemId)
			f94_local9.tier = f94_local3
			f94_local9.unlocked = f94_local6
			f94_local9.lootType = f94_local7[1].lootType
			if f94_local7[1].dupe then
				f94_local9.dupe = f94_local7[1].dupe
			else
				f94_local9.dupe = false
			end
			if f94_local7[1].reroll then
				f94_local9.reroll = f94_local7[1].reroll
			else
				f94_local9.reroll = false
			end
			f94_local9.movieName = f94_local7[1].movieName or ""
			if f94_local9.movieName and f94_local9.movieName ~= "" then
				f94_local9.isLooping = true
				f94_local9.isStreamed = false
			end
			f94_local9.gap = true
			f94_local8 = f94_local9
		end
		table.insert(f94_local0, f94_local8)
	end
	return f94_local0
end
CoD.BlackMarketUtility.GetItemProductAndProperties = function(f95_arg0)
	local f95_local0 = f95_arg0
	local f95_local1 = {}
	if f95_local0.signatureWeaponInfo and f95_local0.signatureWeaponInfo.ref then
		f95_local0.weaponRef = f95_local0.signatureWeaponInfo.ref
		f95_local1.signatureWeaponInfo = f95_local0.signatureWeaponInfo
	elseif f95_local0.baseWeaponInfo and f95_local0.baseWeaponInfo.ref then
		f95_local0.weaponRef = f95_local0.baseWeaponInfo.ref
		f95_local1.baseWeaponInfo = f95_local0.baseWeaponInfo
	else
		f95_local0.weaponRef = 0x0
	end
	if f95_local0.camoRef then
		f95_local1.camoRef = f95_local0.camoRef
	end
	if f95_local0.outfitIndexes then
		f95_local1 = f95_local0.outfitIndexes
	end
	f95_local1.gesture_index = f95_local0.gesture_index
	return f95_local0, f95_local1
end
DataSources.ContractTierItems = ListHelper_SetupDataSource("ContractTierItems", function(f96_arg0, f96_arg1)
	local f96_local0 = {}
	local f96_local1 = nil
	local f96_local2 = false
	if f96_arg1.menu then
		local f96_local3 = f96_arg1.menu:getModel(f96_arg0, "contractId")
		f96_local1 = f96_local3 and f96_local3:get()
		local f96_local4 = f96_arg1.menu:getModel(f96_arg0, "purchased")
		f96_local2 = f96_local4 and f96_local4:get()
	end
	if not f96_local1 then
		return f96_local0
	end
	local f96_local3 = CoD.BlackMarketTableUtility.GetContractTierCount(f96_local1)
	local f96_local4 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f96_arg0)
	local f96_local5 = Engine[@"getmodelforcontroller"](f96_arg0)
	f96_local5 = f96_local5.FocusedTier
	local f96_local6
	if f96_local5 then
		f96_local6 = f96_local5:get()
		if not f96_local6 then
		else
			local f96_local7 = CoD.BlackMarketUtility.GetTierItemsForContractTab(f96_arg0, f96_local1, f96_local6, f96_local6 + 4)
			for f96_local8 = 1, #f96_local7, 1 do
				if f96_local7[f96_local8].name ~= 0x0 then
					local f96_local11, f96_local12 = CoD.BlackMarketUtility.GetItemProductAndProperties(f96_local7[f96_local8])
					f96_local11.tierCount = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2447CBFFBA0F8D66", f96_local8 + f96_local6 - 1, f96_local3)
					table.insert(f96_local0, {
						models = f96_local11,
						properties = f96_local12,
					})
				end
			end
			return f96_local0
		end
	end
	f96_local6 = 1
end)
DataSources.BundleItemsList = ListHelper_SetupDataSource("BundleItemsList", function(f97_arg0, f97_arg1)
	local f97_local0 = {}
	local f97_local1 = nil
	if f97_arg1.menu then
		local f97_local2 = f97_arg1.menu:getModel(f97_arg0, "hashName")
		f97_local1 = f97_local2 and f97_local2:get()
	end
	if not f97_local1 then
		return f97_local0
	end
	local f97_local2 = CoD.BlackMarketTableUtility.GetBundlePiecesInformation(f97_arg0, f97_local1)
	if f97_local2 then
		local f97_local3 = 1
		local f97_local4 = Engine[@"getmodelforcontroller"](f97_arg0)
		f97_local4 = f97_local4.FocusedTier
		if f97_local4 then
			f97_local3 = f97_local4:get() or 1
		end
		for f97_local5 = f97_local3, math.min(#f97_local2, f97_local3 + 4), 1 do
			local f97_local8 = f97_local2[f97_local5]
			local f97_local9 = {}
			f97_local9 = CoD.BlackMarketUtility.GetItemRefs(f97_arg0, f97_local8.name, f97_local8.category, f97_local8.rarity, f97_local8.inSet, nil, f97_local8.lootType, f97_local8.refOptic, f97_local8.itemId)
			if IsBooleanDvarSet(@"hash_1A8E4D68B803874") and CoD.BlackMarketUtility.BlackjackShopSunsetOverridePopupImageItems[f97_local8.name] then
				f97_local9.popupImage = f97_local9.primaryImage
			end
			local f97_local10, f97_local11 = CoD.BlackMarketUtility.GetItemProductAndProperties(f97_local9)
			f97_local10.gap = true
			table.insert(f97_local0, {
				models = f97_local10,
				properties = f97_local11,
			})
		end
	end
	return f97_local0
end)
CoD.BlackMarketUtility.GetItemQuantity = function(f98_arg0, f98_arg1)
	return 1
end
CoD.BlackMarketUtility.UnlockedByPrerequisites = function(f99_arg0, f99_arg1)
	if type(f99_arg1) == "string" then
		f99_arg1 = Engine[@"converttoxhash"](f99_arg1)
	end
	return false
end
CoD.BlackMarketUtility.IsItemLocked = function(f100_arg0, f100_arg1)
	if Dvar[@"hash_34D39FCDA04AE7A8"]:get() == "1" then
		return false
	elseif f100_arg1 then
		local f100_local0 = CoD.BlackMarketUtility.GetItemQuantity(f100_arg0, f100_arg1)
		if f100_local0 == nil then
			local f100_local1 = CoD.BlackMarketUtility.UnlockedByPrerequisites(f100_arg0, f100_arg1)
			if f100_local1 ~= nil then
				return not f100_local1
			end
		end
		if f100_local0 == nil or f100_local0 == 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end
CoD.BlackMarketUtility.ClassContainsLockedItems = function(f101_arg0, f101_arg1)
	local f101_local0 = CoD.SafeGetModelValue(f101_arg1, "primary.ref")
	if f101_local0 and f101_local0 ~= "" and CoD.BlackMarketUtility.GetItemQuantity(f101_arg0, Engine[@"converttoxhash"](f101_local0)) == 0 then
		return true
	else
		local f101_local1 = CoD.SafeGetModelValue(f101_arg1, "secondary.ref")
		if f101_local1 and f101_local1 ~= "" and CoD.BlackMarketUtility.GetItemQuantity(f101_arg0, Engine[@"converttoxhash"](f101_local1)) == 0 then
			return true
		else
			return false
		end
	end
end
CoD.BlackMarketUtility.ClassifiedName = function(f102_arg0)
	local f102_local0 = @"menu/classified"
	if f102_arg0 then
		return Engine[@"hash_4F9F1239CFD921FE"](f102_local0)
	else
		return f102_local0
	end
end
CoD.BlackMarketUtility.GetCallingCardSetTable = function(f103_arg0)
	for f103_local3, f103_local4 in ipairs(CoD.BlackMarketUtility.CallingCardsTable) do
		if f103_local4.setRef == f103_arg0 then
			return f103_local4
		end
	end
end
CoD.BlackMarketUtility.GetCallingCardRows = function()
	local f104_local0 = Engine[@"tablefindrows"](CoD.BlackMarketUtility.lootTableName, 2, @"calling_card")
	if not f104_local0 then
		return {}
	end
	for f104_local1 = #f104_local0, 1, -1 do
		if CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f104_local0[f104_local1], CoD.BlackMarketUtility.lootNameCol)) then
			table.remove(f104_local0, f104_local1)
		end
	end
	return f104_local0
end
CoD.BlackMarketUtility.GetCallingCardSetCaptstones = function(f105_arg0)
	local f105_local0 = @"calling_card"
	local f105_local1 = 0
	local f105_local2 = 1
	local f105_local3 = 2
	local f105_local4 = CoD.BlackMarketTableUtility.LootBonusTable.name
	local f105_local5 = Engine[@"tablefindrows"](f105_local4, f105_local2, f105_local0)
	local f105_local6 = {}
	for f105_local7 = #f105_local5, 1, -1 do
		local f105_local10 = Engine[@"hash_4C6F8EC444864600"](f105_local4, f105_local5[f105_local7], f105_local1)
		if not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(f105_local10) then
			f105_local6[f105_local7] = {}
			f105_local6[f105_local7].name = f105_local10
			f105_local6[f105_local7].setName = Engine[@"hash_4C6F8EC444864600"](f105_local4, f105_local5[f105_local7], f105_local3)
			f105_local6[f105_local7].description = CoD.BlackMarketUtility.GetCallingCardTitleFromImage(f105_local10)
		end
	end
	return f105_local6
end
CoD.BlackMarketUtility.GetLootTypeRows = function(f106_arg0)
	return Engine[@"tablefindrows"](CoD.BlackMarketUtility.lootTableName, 2, f106_arg0)
end
CoD.BlackMarketUtility.CleanupCachedCallingCardData = function(f107_arg0)
	CoD.BlackMarketUtility.CallingCardsTable = {}
	CoD.BlackMarketUtility.CommonCallingCardsTable = {}
end
CoD.BlackMarketUtility.BuildCallingCardSets = function(f108_arg0, f108_arg1)
	CoD.BlackMarketUtility.CallingCardsTable = {}
	CoD.BlackMarketUtility.CommonCallingCardsTable = {}
	local f108_local0 = {}
	local f108_local1 = false
	local f108_local2 = 1
	local f108_local3 = 3
	local f108_local4 = 4
	local f108_local5 = 9
	local f108_local6 = 15
	local f108_local7 = Engine[@"tablefindrows"](CoD.BlackMarketUtility.backgroundsTable, f108_local5, @"loot")
	if f108_local7 then
		for f108_local19, f108_local20 in ipairs(f108_local7) do
			local f108_local11 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f108_local20, f108_local3)
			local f108_local21 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f108_local20, f108_local4)
			local f108_local22 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f108_local20, f108_local6)
			local f108_local23 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f108_local20, f108_local2)
			if f108_local22 and f108_local22 ~= 0x0 then
				f108_local11 = f108_local22
			end
			local f108_local12 = CoD.BlackMarketTableUtility.LootInfoLookup(f108_arg0, f108_local11)
			if f108_local12 then
				if not f108_local1 then
					f108_local1 = f108_local12.available == true
				end
				local f108_local13 = nil
				if f108_local12.inSet then
					if not f108_local0[f108_local12.inSet] then
						f108_local0[f108_local12.inSet] = {}
					end
					f108_local13 = f108_local0[f108_local12.inSet]
				elseif f108_local12.owned or f108_local12.available then
					f108_local13 = CoD.BlackMarketUtility.CommonCallingCardsTable
				end
				local f108_local14 = Engine[@"hash_4F9F1239CFD921FE"](f108_local21)
				if f108_local12.isLoot and not f108_local12.available then
					f108_local14 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/classified")
				end
				if f108_local13 then
					local f108_local15 = table.insert
					local f108_local16 = f108_local13
					local f108_local17 = {
						displayName = f108_local14,
					}
					local f108_local18 = CoD.BlackMarketUtility.LootIdRarities[f108_local12.rarity]
					if not f108_local18 then
						f108_local18 = Enum[@"lootraritytype"][@"loot_rarity_type_count"]
					end
					f108_local17.rarity = f108_local18
					f108_local17.iconId = f108_local23
					f108_local17.tier = f108_local12.unlockTier or 0
					f108_local17.season = f108_local12.seasonIndex or 0
					f108_local17.lootInfo = f108_local12
					f108_local15(f108_local16, f108_local17)
				end
			end
		end
	end
	for f108_local19, f108_local20 in pairs(f108_local0) do
		local f108_local11 = 0
		local f108_local21 = 0
		local f108_local22 = #f108_local20
		local f108_local23 = Enum[@"lootraritytype"][@"loot_rarity_type_count"]
		local f108_local12 = 0
		local f108_local13, f108_local14 = nil
		local f108_local15 = 0
		for f108_local24, f108_local25 in ipairs(f108_local20) do
			if f108_local25.lootInfo.setMaster then
				f108_local13 = f108_local25.iconId
				f108_local14 = f108_local25
				f108_local22 = f108_local22 - 1
			else
				if f108_local25.lootInfo.owned or not f108_local25.lootInfo.isLoot then
					f108_local11 = f108_local11 + 1
					f108_local21 = f108_local21 + 1
					f108_local12 = f108_local25.iconId
				elseif f108_local25.lootInfo.available or not f108_local25.lootInfo.isLoot then
					f108_local21 = f108_local21 + 1
				end
				if f108_local25.rarity ~= Enum[@"lootraritytype"][@"loot_rarity_type_count"] and (f108_local23 == Enum[@"lootraritytype"][@"loot_rarity_type_count"] or f108_local23 < f108_local25.rarity) then
					f108_local23 = f108_local25.rarity
				end
			end
			if f108_local25.lootInfo.owned and CoD.BreadcrumbUtility.IsStatCallingCardNew(f108_arg1, f108_arg0, f108_local25.iconId) then
				f108_local15 = f108_local15 + 1
			end
		end
		if f108_local21 > 0 then
			f108_local16 = CoD.BlackMarketTableUtility.GetLootBonusStringRef(f108_arg0, f108_local19)
			f108_local17 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1587BB89C78FFE9A", f108_local16, f108_local11, f108_local22)
			if f108_local14 then
				f108_local14.setInfoString = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F4082FA89EBEDBA", f108_local16, Engine[@"hash_4F9F1239CFD921FE"](@"hash_120BF14474EB8696", Engine[@"hash_4F9F1239CFD921FE"](@"menu/calling_card")))
				if not IsJapaneseSku() and f108_local14.lootInfo.owned then
					f108_local12 = f108_local14.iconId
					f108_local14.lootInfo.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_complete")
				else
					f108_local14.lootInfo.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_incomplete")
				end
			end
			if f108_local12 == 0 then
				f108_local12 = f108_local20[1].iconId
			end
			table.insert(CoD.BlackMarketUtility.CallingCardsTable, {
				setRef = f108_local19,
				setInfoString = f108_local17,
				rarity = f108_local23,
				iconId = f108_local12,
				callingCards = f108_local20,
				numOwned = f108_local11,
				highestTier = f108_local20[f108_local22].tier,
				bonusCardInfo = f108_local14,
				breadcrumbCount = f108_local15,
			})
		end
	end
	table.sort(CoD.BlackMarketUtility.CallingCardsTable, function(f109_arg0, f109_arg1)
		if f109_arg0.rarity ~= f109_arg1.rarity then
			return f109_arg1.rarity < f109_arg0.rarity
		elseif f109_arg0.season ~= f109_arg1.season then
			return f109_arg1.season < f109_arg0.season
		else
			return f109_arg0.highestTier < f109_arg1.highestTier
		end
	end)
	table.sort(CoD.BlackMarketUtility.CommonCallingCardsTable, function(f110_arg0, f110_arg1)
		return f110_arg0.iconId < f110_arg1.iconId
	end)
	return f108_local1
end
CoD.BlackMarketUtility.SortUnlockIconId = function(f111_arg0, f111_arg1)
	if f111_arg0.isSetBMClassified ~= f111_arg1.isSetBMClassified then
		return f111_arg1.isSetBMClassified
	else
		return f111_arg0.iconId < f111_arg1.iconId
	end
end
CoD.BlackMarketUtility.SortUnlocksModelIconId = function(f112_arg0, f112_arg1)
	if f112_arg0.models.isBMClassified ~= f112_arg1.models.isBMClassified then
		return f112_arg1.models.isBMClassified
	else
		return f112_arg0.models.iconId < f112_arg1.models.iconId
	end
end
CoD.BlackMarketUtility.SortUnlocksPropertyIndex = function(f113_arg0, f113_arg1)
	if f113_arg0.models.isBMClassified ~= f113_arg1.models.isBMClassified then
		return f113_arg1.models.isBMClassified
	else
		return f113_arg0.properties.index < f113_arg1.properties.index
	end
end
CoD.BlackMarketUtility.SortUnlocksPropertyVariantIndex = function(f114_arg0, f114_arg1)
	if f114_arg0.models.isBMClassified ~= f114_arg1.models.isBMClassified then
		return f114_arg1.models.isBMClassified
	else
		return f114_arg0.properties.variantIndex < f114_arg1.properties.variantIndex
	end
end
CoD.BlackMarketUtility.SortUnlocksModelEmblemIconID = function(f115_arg0, f115_arg1)
	local f115_local0 = f115_arg0.owned:get()
	local f115_local1 = f115_arg1.owned:get()
	if f115_local0 == true and f115_local1 == false then
		return true
	elseif f115_local0 == false and f115_local1 == true then
		return false
	else
		return f115_arg0.sortKey:get() < f115_arg1.sortKey:get()
	end
end
CoD.BlackMarketUtility.SortUnlocksModelIconID = function(f116_arg0, f116_arg1)
	local f116_local0 = f116_arg0.isBMClassified:get()
	local f116_local1 = f116_arg1.isBMClassified:get()
	if f116_local0 ~= f116_local1 then
		return f116_local1
	else
		return f116_arg0.iconID:get() < f116_arg1.iconID:get()
	end
end
CoD.BlackMarketUtility.SortUnlocksModelWOSubIndex = function(f117_arg0, f117_arg1)
	if f117_arg0.lootData then
		local f117_local0 = f117_arg0.lootData.owned
		local f117_local1 = f117_arg0.lootData.owned:get()
	end
	local f117_local2 = f117_local0 and f117_local1 or false
	if f117_arg1.lootData then
		local f117_local3 = f117_arg1.lootData.owned
		local f117_local4 = f117_arg1.lootData.owned:get()
	end
	local f117_local5 = f117_local3 and f117_local4 or false
	if f117_local2 ~= f117_local5 then
		return f117_local5
	else
		return f117_arg0.weaponOptionSubIndex:get() < f117_arg1.weaponOptionSubIndex:get()
	end
end
CoD.BlackMarketUtility.SortWeaponOptionCamosRarity = function(f118_arg0, f118_arg1)
	local f118_local0 = CoD.SafeGetModelValue(f118_arg0, "isCurrentWeaponReactiveCamo") or false
	if f118_local0 ~= (CoD.SafeGetModelValue(f118_arg1, "isCurrentWeaponReactiveCamo") or false) then
		return f118_local0
	else
		return (CoD.SafeGetModelValue(f118_arg0, "lootData.rarity") or -1) < (CoD.SafeGetModelValue(f118_arg1, "lootData.rarity") or -1)
	end
end
CoD.BlackMarketUtility.GetOufitBundleRef = function(f119_arg0, f119_arg1, f119_arg2, f119_arg3)
	local f119_local0 = CoD.BlackMarketTableUtility.GetOutfitBundleInformation(f119_arg0, f119_arg1)
	if f119_local0 then
		local f119_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f119_local0)
		if f119_local1 ~= nil and f119_local1.characterIndex ~= nil and f119_local1.outfitIndex ~= nil and f119_local1.paletteIndex ~= nil then
			local f119_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f119_local1.mode, f119_local1.characterIndex)
			local f119_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f119_local1.mode, f119_local1.characterIndex)
			local f119_local4 = f119_local3.outfits[f119_local1.outfitIndex + 1]
			local f119_local5, f119_local6 = nil
			if #f119_local4.palettes > 0 then
				f119_local5 = f119_local4.palettes[f119_local1.paletteIndex + 1].outfitImage
				f119_local6 = f119_local4.palettes[f119_local1.paletteIndex + 1].displayName
			end
			if not f119_local5 then
				f119_local5 = f119_local4.presets[f119_local1.presetIndex + 1].icon
				f119_local6 = f119_local4.presets[f119_local1.presetIndex + 1].displayName
			end
			return {
				name = f119_local6,
				desc = Engine[@"hash_4F9F1239CFD921FE"](0x77D62520C77867),
				mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f119_local4.displayName)),
				subExtraText = f119_local2.displayName,
				primaryImage = f119_local5 or @"blacktransparent",
				popupImage = @"hash_0",
				character = f119_local0.prt,
				outfitIndexes = f119_local1,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetWarpaintBundleRef = function(f120_arg0, f120_arg1)
	local f120_local0 = CoD.BlackMarketTableUtility.GetOutfitItemBundleInformation(f120_arg0, f120_arg1)
	if f120_local0 then
		local f120_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f120_local0)
		f120_local1.paletteIndex = 0
		if f120_local1 ~= nil and f120_local1.characterIndex ~= nil and f120_local1.outfitIndex ~= nil and f120_local1.paletteIndex ~= nil then
			local f120_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f120_local1.mode, f120_local1.characterIndex)
			local f120_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f120_local1.mode, f120_local1.characterIndex)
			local f120_local4 = f120_local3.outfits[f120_local1.outfitIndex + 1]
			return {
				name = f120_local4.warPaints[f120_local1.war_paintIndex + 1].displayName,
				desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_562BC3111047BF79"),
				mainExtraText = "",
				subExtraText = @"hash_0",
				primaryImage = f120_local4.warPaints[f120_local1.war_paintIndex + 1].image or @"blacktransparent",
				popupImage = @"hash_0",
				character = f120_local0.prt,
				outfitIndexes = f120_local1,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetBundleKeyItemRef = function(f121_arg0, f121_arg1, f121_arg2, f121_arg3)
	local f121_local0 = CoD.BlackMarketTableUtility.GetBundlePiecesInformation(f121_arg0, f121_arg1)
	local f121_local1 = 0
	if f121_local0 and #f121_local0 > 0 then
		for f121_local2 = 1, #f121_local0, 1 do
			local f121_local5 = f121_local0[f121_local2]
			if f121_local5.category == f121_arg2 then
				if f121_arg3 == nil or f121_local1 + 1 == f121_arg3 then
					return f121_local5
				end
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetOufitPresetRef = function(f122_arg0, f122_arg1, f122_arg2, f122_arg3)
	local f122_local0 = nil
	if f122_arg3 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f122_local0 = CoD.BlackMarketTableUtility.GetContrabandOutfitInformation(f122_arg0, f122_arg1)
	elseif f122_arg3 == LuaEnum.LOOT_TYPE.CONTRACT then
		f122_local0 = CoD.BlackMarketTableUtility.GetContractOutfitInformation(f122_arg0, f122_arg1, f122_arg2)
	elseif f122_arg3 == LuaEnum.LOOT_TYPE.ITEMSHOP then
		f122_local0 = CoD.BlackMarketTableUtility.GetItemShopOutfitInformation(f122_arg0, f122_arg1)
	elseif f122_arg3 == LuaEnum.LOOT_TYPE.BUNDLE then
		f122_local0 = CoD.BlackMarketTableUtility.GetBundleOutfitInformation(f122_arg0, f122_arg1)
	elseif f122_arg3 == LuaEnum.LOOT_TYPE.SEASON then
		f122_local0 = CoD.BlackMarketTableUtility.GetSeasonOutfitInformation(f122_arg0, f122_arg1)
	end
	if f122_local0 then
		local f122_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f122_local0)
		if f122_local1 ~= nil and f122_local1.characterIndex ~= nil and f122_local1.outfitIndex ~= nil and f122_local1.presetIndex ~= nil then
			local f122_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f122_local1.mode, f122_local1.characterIndex)
			local f122_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f122_local1.mode, f122_local1.characterIndex)
			local f122_local4 = f122_local3.outfits[f122_local1.outfitIndex + 1]
			local f122_local5 = f122_local4.presets[f122_local1.presetIndex + 1]
			local f122_local6 = f122_local5
			local f122_local7
			if f122_local5.matchedWarPaintLootId ~= 0x0 then
				f122_local7 = f122_local5.outfitIcon
			else
				f122_local7 = false
			end
			if f122_local5 then
				local f122_local8 = f122_local5.matchedWarPaintLootId
				local f122_local9 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2225837B50C02D09", f122_local2.displayName)
			end
			local f122_local10 = f122_local8 and f122_local9 or Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FD60E5FA0ADD7CC", f122_local2.displayName)
			if not f122_local7 or f122_local7 == 0x0 then
				f122_local7 = f122_local5 and f122_local5.icon
			end
			if not f122_local7 or f122_local7 == 0x0 then
				f122_local7 = @"blacktransparent"
			end
			local f122_local11 = {}
			local f122_local12
			if f122_local5 then
				f122_local12 = f122_local5.displayName
				if not f122_local12 then
				else
					f122_local11.name = f122_local12
					f122_local11.desc = f122_local10
					f122_local11.mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f122_local4.displayName))
					f122_local11.subExtraText = f122_local2.displayName
					f122_local11.primaryImage = f122_local7 or @"blacktransparent"
					f122_local11.character = f122_local0.prt
					f122_local11.outfitIndexes = f122_local1
					return f122_local11
				end
			end
			f122_local12 = 0x0
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetOufitWarPaintRef = function(f123_arg0, f123_arg1, f123_arg2, f123_arg3)
	local f123_local0 = nil
	if f123_arg3 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f123_local0 = CoD.BlackMarketTableUtility.GetContrabandOutfitInformation(f123_arg0, f123_arg1)
	elseif f123_arg3 == LuaEnum.LOOT_TYPE.CONTRACT then
		f123_local0 = CoD.BlackMarketTableUtility.GetContractOutfitInformation(f123_arg0, f123_arg1, f123_arg2)
	elseif f123_arg3 == LuaEnum.LOOT_TYPE.ITEMSHOP then
	elseif f123_arg3 == LuaEnum.LOOT_TYPE.BUNDLE then
		f123_local0 = CoD.BlackMarketTableUtility.GetBundleOutfitInformation(f123_arg0, f123_arg1)
	end
	if f123_local0 then
		local f123_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f123_local0)
		if f123_local1 ~= nil and f123_local1.characterIndex ~= nil and f123_local1.outfitIndex ~= nil and f123_local1.war_paintIndex ~= nil and f123_local1.war_paintIndex > -1 then
			local f123_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f123_local1.mode, f123_local1.characterIndex)
			local f123_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f123_local1.mode, f123_local1.characterIndex)
			local f123_local4 = f123_local3.outfits[f123_local1.outfitIndex + 1]
			local f123_local5 = f123_local4.warPaints[f123_local1.war_paintIndex + 1].displayName
			if f123_local1.paletteIndex == nil then
				f123_local1.paletteIndex = CoD.BlackMarketUtility.GetPaletteFromOutfitInfo(f123_local4, f123_local5)
			end
			return {
				name = f123_local5,
				desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C81893A317FA38B", f123_local2.displayName),
				mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f123_local4.displayName)),
				subExtraText = f123_local2.displayName,
				primaryImage = f123_local4.warPaints[f123_local1.war_paintIndex + 1].image or @"blacktransparent",
				character = f123_local0.prt,
				outfitIndexes = f123_local1,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetOufitDecalRef = function(f124_arg0, f124_arg1, f124_arg2, f124_arg3)
	local f124_local0 = nil
	if f124_arg3 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f124_local0 = CoD.BlackMarketTableUtility.GetContrabandOutfitInformation(f124_arg0, f124_arg1)
	elseif f124_arg3 == LuaEnum.LOOT_TYPE.CONTRACT then
		f124_local0 = CoD.BlackMarketTableUtility.GetContractOutfitInformation(f124_arg0, f124_arg1, f124_arg2)
	elseif f124_arg3 == LuaEnum.LOOT_TYPE.ITEMSHOP then
	elseif f124_arg3 == LuaEnum.LOOT_TYPE.BUNDLE then
		f124_local0 = CoD.BlackMarketTableUtility.GetBundleOutfitInformation(f124_arg0, f124_arg1)
	end
	if f124_local0 then
		local f124_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f124_local0)
		if f124_local1 ~= nil and f124_local1.characterIndex ~= nil and f124_local1.outfitIndex ~= nil and f124_local1.decalIndex ~= nil and f124_local1.decalIndex > -1 then
			local f124_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f124_local1.mode, f124_local1.characterIndex)
			local f124_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f124_local1.mode, f124_local1.characterIndex)
			local f124_local4 = f124_local3.outfits[f124_local1.outfitIndex + 1]
			return {
				name = f124_local4.decals[f124_local1.decalIndex + 1].displayName,
				desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1216427CCB6734F6", f124_local2.displayName),
				mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f124_local4.displayName)),
				subExtraText = f124_local2.displayName,
				primaryImage = f124_local4.decals[f124_local1.decalIndex + 1].image or @"blacktransparent",
				popupImage = f124_local4.decals[f124_local1.decalIndex + 1].image or @"blacktransparent",
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetWeaponRef = function(f125_arg0)
	local f125_local0 = Enum[@"emodes"][@"mode_multiplayer"]
	local f125_local1 = function()
		local f126_local0, f126_local1, f126_local2, f126_local3, f126_local4 = nil
		for f126_local12, f126_local13 in ipairs({
			"primary",
			"secondary",
		}) do
			for f126_local9, f126_local10 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f125_local0, f126_local13)) do
				if f125_arg0 == f126_local10.nameHash then
					f126_local0 = f126_local13
					f126_local1 = f126_local10.displayName
					f126_local2 = f126_local10.description
					f126_local3 = f126_local10.nameHash
					local f126_local8 = Engine[@"hash_5E1EF2796DE77BCB"](f125_arg0)
					if f126_local8 then
						f126_local4 = f126_local8
					end
					if f126_local10.previewImage then
						f126_local4 = Engine[@"hash_1BF99001028052B9"](f126_local10.previewImage)
					end
				end
			end
		end
		return f126_local0, f126_local1, f126_local2, f126_local3, f126_local4
	end
	local f125_local1, f125_local2, f125_local3, f125_local4, f125_local5 = f125_local1()
	if f125_local4 then
		return {
			name = f125_local2,
			primaryImage = f125_local5,
			displayNameRef = f125_local2,
			displayDescRef = f125_local3,
			weaponInfo = {
				weaponSlot = f125_local1,
				ref = f125_local4,
				displayNameRef = f125_local2,
			},
		}
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetSignatureWeaponRef = function(f127_arg0)
	local f127_local0 = CoD.CACUtility.GetUnlockableItemTable()
	local f127_local1 = Enum[@"emodes"][@"mode_multiplayer"]
	local f127_local2 = function()
		local f128_local0, f128_local1, f128_local2, f128_local3 = nil
		local f128_local4 = {}
		for f128_local16, f128_local17 in ipairs({
			"primary",
			"secondary",
		}) do
			for f128_local11, f128_local12 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f127_local1, f128_local17)) do
				for f128_local8, f128_local9 in ipairs(Engine[@"hash_79F0BB7D52A7A978"](f128_local12.nameHash)) do
					if f128_local9[@"lootid"] == f127_arg0 then
						if f128_local9[@"hash_5C2AA73D9F82E9C2"] == true then
							f128_local0 = f128_local17
							f128_local1 = f128_local12.displayName
							f128_local2 = f128_local12.nameHash
							f128_local3 = f128_local9
						else
							f128_local4 = f128_local9
						end
					end
				end
			end
		end
		return f128_local0, f128_local1, f128_local2, f128_local3, f128_local4
	end
	local f127_local2, f127_local3, f127_local4, f127_local5, f127_local6 = f127_local2()
	if f127_local4 then
		local f127_local7 = f127_local6[@"hash_1852BDFE9E6B7AB1"]
		if not f127_local7 or f127_local7 == 0x0 or f127_local7 == @"blacktransparent" then
			f127_local7 = f127_local5[@"hash_1852BDFE9E6B7AB1"]
		end
		local f127_local8 = {
			[@"ui_icon_weapons_loot_shotgun_semi_sig_01"] = @"ui_icon_weapons_loot_shotgun_semi_sig_02",
			[@"hash_4C8731A395FE6921"] = @"ui_icon_weapons_loot_ar_accurate_sig_02",
			[@"hash_D22965694EF34B5"] = @"ui_icon_weapons_loot_smg_accurate_sig_02",
			[@"hash_241DCDBC3E815438"] = @"hash_241DD0BC3E815951",
		}
		return {
			name = f127_local5[@"displayname"],
			primaryImage = f127_local8[f127_local7] or f127_local7,
			displayNameRef = f127_local3,
			mastercraftNameRef = f127_local6[@"displayname"],
			signatureWeaponInfo = {
				weaponSlot = f127_local2,
				ref = f127_local4,
				signatureIndex = f127_local5[@"index"],
				mastercraftIndex = f127_local6[@"index"],
				displayNameRef = f127_local5[@"displayname"],
				mastercraftNameRef = f127_local6[@"displayname"],
			},
		}
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetMastercraftWeaponRef = function(f129_arg0)
	local f129_local0 = CoD.CACUtility.GetUnlockableItemTable()
	local f129_local1 = Enum[@"emodes"][@"mode_multiplayer"]
	local f129_local2 = function()
		local f130_local0, f130_local1, f130_local2, f130_local3 = nil
		local f130_local4 = {}
		for f130_local16, f130_local17 in ipairs({
			"primary",
			"secondary",
		}) do
			for f130_local11, f130_local12 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f129_local1, f130_local17)) do
				for f130_local8, f130_local9 in ipairs(Engine[@"hash_79F0BB7D52A7A978"](f130_local12.nameHash)) do
					if f130_local9[@"lootid"] == f129_arg0 then
						return f130_local17, f130_local12.displayName, f130_local12.nameHash, f130_local9
					end
				end
			end
		end
		return f130_local0, f130_local1, f130_local2, f130_local3
	end
	local f129_local2, f129_local3, f129_local4, f129_local5 = f129_local2()
	if f129_local4 then
		local f129_local6 = f129_local5[@"hash_1852BDFE9E6B7AB1"]
		local f129_local7 = f129_local3
		if f129_local5[@"displayname"] then
			f129_local3 = f129_local5[@"displayname"]
		end
		return {
			name = f129_local3,
			primaryImage = f129_local6,
			displayNameRef = f129_local7,
			weaponInfo = {
				weaponSlot = f129_local2,
				ref = f129_local4,
				modelIdx = f129_local5[@"index"],
				displayNameRef = f129_local7,
			},
		}
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetGestureRef = function(f131_arg0, f131_arg1, f131_arg2, f131_arg3)
	local f131_local0 = 0x0
	for f131_local12, f131_local13 in ipairs(CoD.BreadcrumbUtility.GetSprayGestureTable()) do
		if f131_local13[@"assetname"] == f131_arg1 then
			local f131_local4 = Enum[@"emodes"][@"mode_multiplayer"]
			local f131_local5 = nil
			if f131_arg2 ~= nil and f131_arg3 == LuaEnum.LOOT_TYPE.CONTRACT then
				local f131_local6 = CoD.BlackMarketTableUtility.GetContractOutfitInformation(f131_arg0, f131_arg1, f131_arg2)
				if f131_local6 then
					f131_local5 = f131_local6.prt
				end
			end
			if f131_local5 == nil or f131_local5 == 0x0 then
				local f131_local6 = CoD.BlackMarketUtility.CharacterPRTTable[1]
				local f131_local7 = CoD.BlackMarketTableUtility.LootInfoLookup(f131_arg0, f131_local13[@"assetname"])
				f131_local5 = CoD.BlackMarketUtility.PRT_To_PBT_Table[f131_local6]
				local f131_local8 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum[@"emodes"][@"mode_multiplayer"], Engine[@"hash_284E3CB0C7D8BA11"](Enum[@"emodes"][@"mode_multiplayer"], f131_local6))
				f131_local0 = f131_local8.displayName
			else
				for f131_local6 = 1, #CoD.BlackMarketUtility.CharacterPRTTable, 1 do
					local f131_local10 = CoD.BlackMarketUtility.CharacterPRTTable[f131_local6]
					if CoD.BlackMarketUtility.PRT_To_PBT_Table[f131_local10] == f131_local5 then
						f131_local5 = CoD.BlackMarketUtility.PRT_To_PBT_Table[f131_local10]
						local f131_local11 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum[@"emodes"][@"mode_multiplayer"], Engine[@"hash_284E3CB0C7D8BA11"](Enum[@"emodes"][@"mode_multiplayer"], f131_local10))
						f131_local0 = f131_local11.displayName
						break
					end
				end
			end
			return {
				character = f131_local5,
				outfitIndexes = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId({
					mode = f131_local4,
					prt = f131_local5,
				}),
				primaryImage = f131_local13[@"icon"],
				name = f131_local13[@"title"],
				gesture_index = f131_local12,
				characterDisplayNameRef = f131_local0,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetTableWeaponRef = function(f132_arg0, f132_arg1, f132_arg2, f132_arg3, f132_arg4)
	local f132_local0 = 0x0
	if f132_arg2 == LuaEnum.LOOT_TYPE.SEASON then
		f132_local0 = CoD.BlackMarketTableUtility.GetSeasonWeaponRefName(f132_arg0, f132_arg1)
	elseif f132_arg2 == LuaEnum.LOOT_TYPE.CONTRACT then
		f132_local0 = CoD.BlackMarketTableUtility.GetContractWeaponRefName(f132_arg0, f132_arg1, f132_arg3)
	elseif f132_arg2 == LuaEnum.LOOT_TYPE.ITEMSHOP then
		f132_local0 = CoD.BlackMarketTableUtility.GetItemShopWeaponRefName(f132_arg0, f132_arg1)
	elseif f132_arg2 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f132_local0 = CoD.BlackMarketTableUtility.GetContrabandWeaponRefName(f132_arg0, f132_arg4)
	elseif f132_arg2 == LuaEnum.LOOT_TYPE.BUNDLE then
		f132_local0 = CoD.BlackMarketTableUtility.GetBundleWeaponRefName(f132_arg0, f132_arg1)
	end
	return f132_local0
end
CoD.BlackMarketUtility.GetSpecialBundleInfo = function(f133_arg0, f133_arg1)
	local f133_local0 = Engine[@"hash_2E00B2F29271C60B"](f133_arg1)
	if not f133_local0 then
		return nil
	end
	local f133_local1 = {}
	for f133_local6, f133_local7 in pairs({
		primaryImage = {
			overrideFieldName = @"previewimage",
			defaultValue = @"hash_0",
		},
		popupImage = {
			overrideFieldName = @"popupimage",
			defaultValue = @"hash_0",
		},
		buttonImage = {
			overrideFieldName = @"buttonimage",
			defaultValue = @"blacktransparent",
		},
		reservesImage = {
			overrideFieldName = @"reserveimage",
			defaultValue = @"blacktransparent",
		},
		category = {
			overrideFieldName = @"categorytext",
			defaultValue = @"hash_0",
		},
		name = {
			overrideFieldName = @"nametext",
			defaultValue = @"hash_0",
		},
		toolTip = {
			overrideFieldName = @"hash_26464C3356A42E07",
			defaultValue = @"hash_0",
		},
		desc = {
			overrideFieldName = @"desctext",
			defaultValue = "",
			localize = true,
		},
		specialContractDesc = {
			overrideFieldName = @"hash_41D77C4235B42A0",
			defaultValue = "",
			localize = true,
		},
		specialContractGoalType = {
			overrideFieldName = @"hash_3DA64DD8398150B7",
			defaultValue = @"hash_0",
		},
		specialContractGoalUnit = {
			overrideFieldName = @"hash_1A4ECC2185CC1289",
			defaultValue = @"hash_0",
		},
		specialContractRewardImage = {
			overrideFieldName = @"hash_5EE2B488845485EF",
			defaultValue = @"blacktransparent",
		},
	}) do
		local f133_local5 = f133_local7.defaultValue
		if f133_local0[f133_local7.overrideFieldName] then
			f133_local5 = f133_local0[f133_local7.overrideFieldName]
			if f133_local7.localize then
				f133_local5 = Engine[@"hash_4F9F1239CFD921FE"](f133_local5)
			end
		end
		f133_local1[f133_local6] = f133_local5
	end
	return f133_local1
end
CoD.BlackMarketUtility.GetItemRefs = function(f134_arg0, f134_arg1, f134_arg2, f134_arg3, f134_arg4, f134_arg5, f134_arg6, f134_arg7, f134_arg8)
	local f134_local0 = 0x0
	local f134_local1 = ""
	local f134_local2 = ""
	local f134_local3 = 0x0
	local f134_local4 = 0x0
	local f134_local5 = 0x0
	local f134_local6 = 0x0
	local f134_local7 = 0x0
	local f134_local8 = 0x0
	local f134_local9 = 0x0
	local f134_local10 = 0x0
	local f134_local11 = nil
	local f134_local12 = -1
	local f134_local13, f134_local14, f134_local15 = nil
	local f134_local16 = 0x0
	local f134_local17 = 0x0
	local f134_local18 = false
	local f134_local19 = 0
	local f134_local20 = 0
	local f134_local21 = 0
	local f134_local22 = false
	local f134_local23
	if f134_arg4 == nil or f134_arg4 == 0x0 then
		f134_local23 = false
	else
		f134_local23 = true
	end
	local f134_local24 = false
	local f134_local25 = false
	local f134_local26 = false
	local f134_local27 = false
	local f134_local28 = false
	local f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.NONE
	local f134_local30 = false
	local f134_local31 = Engine[@"isdevelopmentbuild"]()
	local f134_local32 = ""
	local f134_local33 = 0x0
	if f134_arg1 == @"contraband" then
		f134_local0 = @"hash_725FC26BF505BC71"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6954DFFAE6AF5CD5")
		f134_local4 = 0x16542A61FD09C0
		f134_local22 = true
		f134_local30 = true
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.CRATE
	elseif f134_arg1 == @"case" then
		f134_local0 = @"hash_D004F2913090A"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_45BF036E550C7E0B")
		f134_local4 = 0x16542A61FD09C0
		f134_local6 = @"ui_icon_blackmarket_reserves_case_large"
		f134_local22 = true
		f134_local30 = true
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.NONE
	elseif f134_arg1 == @"cases_10" then
		f134_local0 = @"mpui/cases"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_ADA96E32A289F35", 10)
		f134_local6 = @"ui_icon_blackmarket_reserves_case_x10_large_preview"
		f134_local4 = @"ui_icon_blackmarket_reserves_case_x10_preview"
		f134_local30 = true
	elseif f134_arg1 == @"tiers_5" then
		f134_local0 = @"mpui/tiers"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_61705D753E6F1661", 5)
		f134_local6 = @"ui_icon_blackmarket_reserves_tier_x5_large_square"
		f134_local4 = @"ui_icon_blackmarket_reserves_tier_x5_preview"
		f134_local30 = true
	elseif f134_arg1 == @"tiers_10" then
		f134_local0 = @"mpui/tiers"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_61705D753E6F1661", 10)
		f134_local6 = @"ui_icon_blackmarket_x10tiers_large"
		f134_local4 = @"ui_icon_blackmarket_x10tiers_large"
		f134_local30 = true
	elseif f134_arg1 == @"hash_746B488CCF757AF0" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 2)
		f134_local6 = @"ui_icon_blackmarket_stream_case_x2"
		f134_local4 = @"ui_icon_blackmarket_item_shop_reserve_crate_x2_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_746B498CCF757CA3" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 3)
		f134_local6 = @"ui_icon_blackmarket_stream_case_x3"
		f134_local4 = @"ui_icon_blackmarket_item_shop_reserve_crate_x3_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_746B4E8CCF758522" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 4)
		f134_local6 = @"ui_icon_blackmarket_stream_case_x4"
		f134_local4 = @"ui_icon_blackmarket_item_shop_reserve_crate_x4_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_746B4F8CCF7586D5" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 5)
		f134_local6 = @"ui_icon_blackmarket_reserves_crate_x5_large_square"
		f134_local4 = @"ui_icon_blackmarket_reserves_crate_x5_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_746B4C8CCF7581BC" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 6)
		f134_local6 = @"hash_7C32C3FC09A201D0"
		f134_local4 = @"hash_1CFD4511B6E289D1"
		f134_local30 = true
	elseif f134_arg1 == @"hash_746B4D8CCF75836F" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 7)
		f134_local6 = @"hash_25CBB8132F9331C1"
		f134_local4 = @"hash_2DE5A76EDF945072"
		f134_local30 = true
	elseif f134_arg1 == @"hash_746B528CCF758BEE" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 8)
		f134_local6 = @"ui_icon_blackmarket_stream_case_x8"
		f134_local4 = @"ui_icon_blackmarket_stream_case_x8"
		f134_local30 = true
	elseif f134_arg1 == @"hash_47D1994484A8E0DB" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 10)
		f134_local6 = @"ui_icon_blackmarket_reserves_crate_x10_large_square"
		f134_local4 = @"ui_icon_blackmarket_reserves_crate_x10_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_47D19B4484A8E441" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 12)
		f134_local6 = @"ui_icon_blackmarket_reserves_crate_x10_large_square"
		f134_local4 = @"ui_icon_blackmarket_reserves_crate_x10_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_47D19C4484A8E5F4" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 15)
		f134_local6 = @"ui_icon_blackmarket_reserves_crate_x15_large_square"
		f134_local4 = @"ui_icon_blackmarket_reserves_crate_x15_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_47C70744849F9440" then
		f134_local0 = @"mpui/crates"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 20)
		f134_local6 = @"ui_icon_blackmarket_reserves_crate_x20_large_square"
		f134_local4 = @"ui_icon_blackmarket_reserves_crate_x20_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_687BF62DBF432123" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 1)
		f134_local6 = @"hash_1B3DD6A07BF2BF1E"
		f134_local4 = @"hash_6AD7059EF84C6745"
		f134_local30 = true
	elseif f134_arg1 == @"hash_687BF72DBF4322D6" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 2)
		f134_local6 = @"hash_594C56B4BDDDCA57"
		f134_local4 = @"hash_6AD7029EF84C622C"
		f134_local30 = true
	elseif f134_arg1 == @"hash_687BF82DBF432489" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 3)
		f134_local6 = 0x8D7D55C5793D94
		f134_local4 = @"hash_6AD7039EF84C63DF"
		f134_local30 = true
	elseif f134_arg1 == @"hash_687BF92DBF43263C" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 4)
		f134_local6 = @"hash_668D795994207A5D"
		f134_local4 = @"hash_6AD7009EF84C5EC6"
		f134_local30 = true
	elseif f134_arg1 == @"hash_687BFA2DBF4327EF" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 5)
		f134_local6 = @"hash_FAFB2215A9DD6FA"
		f134_local4 = @"hash_6AD7019EF84C6079"
		f134_local30 = true
	elseif f134_arg1 == @"hash_687BFB2DBF4329A2" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 6)
		f134_local6 = @"hash_2A270193C87FA3B3"
		f134_local4 = @"hash_6AD6FE9EF84C5B60"
		f134_local30 = true
	elseif f134_arg1 == @"hash_687BFC2DBF432B55" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 7)
		f134_local6 = @"ui_icon_blackmarket_stream_case_x2"
		f134_local4 = @"ui_icon_blackmarket_item_shop_reserve_crate_x2_preview"
		f134_local30 = true
	elseif f134_arg1 == @"hash_4DC462BBFF113349" then
		f134_local0 = @"hash_1717FF140F30014C"
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 10)
		f134_local6 = @"hash_4AA980299AAEAD68"
		f134_local4 = @"hash_6ADA8A9EF84F7F1B"
		f134_local30 = true
	elseif f134_arg2 == @"bribe" then
		local f134_local34 = CoD.BlackMarketUtility.GetBribeAsset(f134_arg0, f134_arg1)
		if f134_local34 then
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local6 = f134_local34.popupImage
			f134_local4 = f134_local34.primaryImage
			f134_local7 = f134_local34.category
			f134_local30 = true
		end
	elseif f134_arg2 == @"special_bundle" then
		local f134_local34 = CoD.BlackMarketUtility.GetSpecialBundleInfo(f134_arg0, f134_arg1)
		if f134_local34 then
			f134_local7 = f134_local34.category
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local4 = f134_local34.primaryImage
			f134_local6 = f134_local34.popupImage
		end
		f134_local24 = true
		f134_local30 = true
		f134_local28 = CoD.BlackMarketTableUtility.BundleIncludesTiers(f134_arg0, f134_arg1)
	elseif f134_arg2 == @"hash_51A672B497989ACE" then
		local f134_local34 = CoD.BlackMarketUtility.GetSpecialBundleInfo(f134_arg0, f134_arg1)
		if f134_local34 then
			f134_local7 = f134_local34.category
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local4 = f134_local34.primaryImage
			f134_local6 = f134_local34.popupImage
		end
		f134_local24 = true
		f134_local30 = true
		f134_local28 = CoD.BlackMarketTableUtility.BundleIncludesTiers(f134_arg0, f134_arg1)
	elseif f134_arg2 == @"outfit_bundle" then
		f134_local7 = @"hash_10FEC0D6C18D931"
		f134_local8 = @"hash_29F902A4E4F760A0"
		local f134_local34 = CoD.BlackMarketUtility.GetOufitBundleRef(f134_arg0, f134_arg1, f134_arg5, f134_arg6)
		if f134_local34 then
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local2 = f134_local34.mainExtraText
			f134_local3 = f134_local34.subExtraText
			f134_local4 = f134_local34.primaryImage
			f134_local6 = f134_local34.popupImage
			f134_local10 = f134_local34.character
			f134_local11 = f134_local34.outfitIndexes
			f134_local24 = true
			f134_local25 = true
			f134_local26 = true
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	elseif f134_arg2 == @"palette" or f134_arg2 == @"outfit" then
		f134_arg2 = @"palette"
		f134_local7 = @"hash_2402A241E7027A9C"
		f134_local8 = @"hash_5C71CAD2D5CA1139"
		local f134_local34 = CoD.BlackMarketUtility.GetOufitPresetRef(f134_arg0, f134_arg1, f134_arg5, f134_arg6)
		if f134_local34 then
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local2 = f134_local34.mainExtraText
			f134_local3 = f134_local34.subExtraText
			f134_local4 = f134_local34.primaryImage
			f134_local10 = f134_local34.character
			f134_local11 = f134_local34.outfitIndexes
			f134_local25 = true
			f134_local26 = true
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No outfit/palette found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	elseif f134_arg2 == @"war_paint" then
		f134_local7 = @"hash_1ADD4C3535DC47"
		f134_local8 = @"hash_1ADD4C3535DC47"
		local f134_local34 = CoD.BlackMarketUtility.GetOufitWarPaintRef(f134_arg0, f134_arg1, f134_arg5, f134_arg6)
		if f134_local34 then
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local2 = f134_local34.mainExtraText
			f134_local3 = f134_local34.subExtraText
			f134_local4 = f134_local34.primaryImage
			f134_local10 = f134_local34.character
			f134_local11 = f134_local34.outfitIndexes
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No warpaint found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WARPAINT
	elseif f134_arg2 == @"hash_248B82A2276A1CAF" then
		f134_local7 = @"hash_3A946B2CDA87A651"
		f134_local8 = @"hash_7E530F8AE1170AEF"
		local f134_local34 = CoD.BlackMarketUtility.GetWarpaintBundleRef(f134_arg0, f134_arg1)
		if f134_local34 then
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local2 = f134_local34.mainExtraText
			f134_local3 = f134_local34.subExtraText
			f134_local4 = f134_local34.primaryImage
			f134_local6 = f134_local34.popupImage
			f134_local10 = f134_local34.character
			f134_local11 = f134_local34.outfitIndexes
			f134_local24 = true
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WARPAINT
	elseif f134_arg2 == @"decal" then
		f134_local7 = @"hash_90FDB01723264C2"
		f134_local8 = @"hash_90FDB01723264C2"
		local f134_local34 = CoD.BlackMarketUtility.GetOufitDecalRef(f134_arg0, f134_arg1, f134_arg5, f134_arg6)
		if f134_local34 then
			f134_local0 = f134_local34.name
			f134_local1 = f134_local34.desc
			f134_local2 = f134_local34.mainExtraText
			f134_local3 = f134_local34.subExtraText
			f134_local4 = f134_local34.primaryImage
			f134_local6 = f134_local34.popupImage
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No decal found for '" .. tostring(f134_arg1) .. "'.\n")
		end
	elseif f134_arg2 == @"sticker" then
		f134_local7 = @"hash_684446BBFA84177E"
		f134_local8 = @"hash_684446BBFA84177E"
		f134_local0 = CoD.BlackMarketUtility.GetStickerNameRef(f134_arg1)
		if f134_local23 then
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EFBC43F128603C7")
		else
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5A97A7E0BDB92B71")
		end
		f134_local4 = f134_arg1
		f134_local6 = f134_arg1
	elseif f134_arg2 == @"jump_kit" then
		f134_local7 = @"hash_23F467595E1530B1"
		f134_local8 = @"hash_23F467595E1530B1"
		f134_local0, f134_local4, f134_local6 = CoD.BlackMarketUtility.GetJumpPackRefs(f134_arg1)
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5CDF03FEF797580B")
		f134_local24 = true
	elseif f134_arg2 == @"parachute" then
		f134_local7 = @"hash_16E17CFC64CC82A6"
		f134_local8 = @"hash_16E17CFC64CC82A6"
		f134_local0, f134_local4, f134_local6 = CoD.BlackMarketUtility.GetParachuteRefs(f134_arg1)
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_54F735829F6419D6")
	elseif f134_arg2 == @"trail" then
		f134_local7 = @"hash_72F9555D2DB46C29"
		f134_local8 = @"hash_72F9555D2DB46C29"
		f134_local0, f134_local4, f134_local6 = CoD.BlackMarketUtility.GetTrailRefs(f134_arg1)
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_596358359F5E5023")
	elseif f134_arg2 == @"wingsuit" then
		f134_local7 = @"hash_1D31D93D47E71A15"
		f134_local8 = @"hash_1D31D93D47E71A15"
		f134_local0, f134_local4, f134_local6 = CoD.BlackMarketUtility.GetWingsuitRefs(f134_arg1)
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_18DF7DAB46723CBF")
	elseif f134_arg2 == @"death_fx" or f134_arg2 == @"hash_1AD68520D53FDBFB" then
		f134_local7 = @"hash_57B491E0F2A8C286"
		f134_local8 = @"hash_57B491E0F2A8C286"
		f134_local0, f134_local4, f134_local6 = CoD.BlackMarketUtility.GetDeathFxRefs(f134_arg1)
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EB5308AF890B7CA")
		if f134_arg2 == @"hash_1AD68520D53FDBFB" then
			local f134_local35 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f134_arg0, f134_arg1, f134_arg6, f134_arg5, f134_arg8))
			if f134_local35 then
				local f134_local36 = Engine[@"hash_4F9F1239CFD921FE"](f134_local35.displayNameRef)
				f134_local14 = f134_local35.weaponInfo
				if f134_local14.displayNameRef then
					f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_547EC21C1E053403", f134_local14.displayNameRef)
					local f134_local37 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
					if f134_local37 then
						f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local37)
						f134_local3 = f134_local14.displayNameRef
					end
				end
			end
		end
	elseif f134_arg2 == @"weapon_charm" or f134_arg2 == @"single_weapon_charm" then
		f134_local7 = @"hash_5F5E657D5E5ED4E7"
		f134_local8 = @"hash_5F5E657D5E5ED4E7"
		f134_local0, f134_local4, f134_local6 = CoD.BlackMarketUtility.GetWeaponCharmRefs(f134_arg1)
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](0x2BC87FDDA42C65)
		if f134_arg2 == @"single_weapon_charm" then
			local f134_local35 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f134_arg0, f134_arg1, f134_arg6, f134_arg5, f134_arg8))
			if f134_local35 then
				local f134_local36 = Engine[@"hash_4F9F1239CFD921FE"](f134_local35.displayNameRef)
				f134_local14 = f134_local35.weaponInfo
				if f134_local14.displayNameRef then
					f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6869AF228464E2CC", f134_local14.displayNameRef)
					local f134_local37 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
					if f134_local37 then
						f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local37)
						f134_local3 = f134_local14.displayNameRef
					end
				end
			end
		end
	elseif f134_arg2 == @"tag" then
		f134_local7 = @"mpui/bm_tag"
		f134_local8 = @"mpui/bm_tag"
		for f134_local39, f134_local37 in ipairs(CoD.BreadcrumbUtility.GetSprayGestureTable()) do
			if f134_local37[@"assetname"] == f134_arg1 then
				f134_local0 = f134_local37[@"title"]
				f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_714B40835B8EFFA6")
				f134_local4 = f134_local37[@"icon"]
				f134_local6 = f134_local37[@"icon"]
			end
		end
	elseif f134_arg2 == @"tag_bundle" then
		f134_local7 = @"hash_659A5D0F134093B2"
		f134_local8 = @"hash_29F902A4E4F760A0"
		local f134_local34 = CoD.BreadcrumbUtility.GetSprayGestureTable()
		local f134_local35 = CoD.BlackMarketTableUtility.GetBonusSetMasterNameHash(f134_arg4)
		for f134_local37, f134_local40 in ipairs(f134_local34) do
			if f134_local40[@"assetname"] == f134_local35 then
				f134_local0 = f134_local40[@"title"]
				f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_714B40835B8EFFA6")
				f134_local4 = f134_local40[@"icon"]
				f134_local6 = f134_local40[@"icon"]
				f134_local16 = f134_local40[@"icon"]
				f134_local17 = f134_local40[@"title"]
				f134_local24 = true
			end
		end
	elseif f134_arg2 == @"calling_card" then
		f134_local7 = @"hash_5A1163B4DB78960A"
		f134_local8 = @"hash_5A1163B4DB78960A"
		if not CoD.BlackMarketUtility.GetCallingCardTitleFromImage(f134_arg1) then
			f134_local0 = CoD.BlackMarketUtility.GetCallingCardTitleFromMasterImage(f134_arg1)
		end
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F54BEF14A6A8825")
		f134_arg1 = CoD.BlackMarketUtility.GetSafeReward(f134_arg1, f134_arg2)
		f134_local4 = f134_arg1
		f134_local6 = f134_arg1
	elseif f134_arg2 == @"signature_weapon" then
		f134_local7 = @"hash_1D4314C41E9C9CFC"
		f134_local8 = @"hash_1D4314C41E9C9CFC"
		local f134_local34 = CoD.BlackMarketUtility.GetSignatureWeaponRef(f134_arg1)
		if f134_local34 then
			local f134_local35 = Engine[@"hash_4F9F1239CFD921FE"](f134_local34.displayNameRef)
			f134_local0 = f134_local34.name
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_33C2175CA3B33A90", Engine[@"hash_4F9F1239CFD921FE"](f134_local34.name), Engine[@"hash_4F9F1239CFD921FE"](f134_local34.mastercraftNameRef))
			f134_local4 = f134_local34.primaryImage
			f134_local13 = f134_local34.signatureWeaponInfo
			if f134_local13.ref then
				f134_local25 = true
				local f134_local39 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local13.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
				if f134_local39 then
					f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3272B8D34315D012", Engine[@"hash_4F9F1239CFD921FE"](f134_local39), f134_local35)
				end
			end
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No signature weapon found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"melee_weapon" then
		f134_local7 = @"hash_586BD6B0420B77FE"
		f134_local8 = @"hash_586BD6B0420B77FE"
		local f134_local34 = CoD.BlackMarketUtility.GetWeaponRef(f134_arg1)
		if f134_local34 then
			local f134_local35 = Engine[@"hash_4F9F1239CFD921FE"](f134_local34.displayNameRef)
			f134_local0 = f134_local34.name
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](f134_local34.displayDescRef)
			f134_local4 = f134_local34.primaryImage
			f134_local14 = f134_local34.weaponInfo
			f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_586BD6B0420B77FE")
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No melee weapon found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"hash_6722B8AE0C9D0F9D" then
		f134_local7 = @"hash_586BD6B0420B77FE"
		f134_local8 = @"hash_29F902A4E4F760A0"
		local f134_local34 = nil
		local f134_local35 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f134_arg0, f134_arg1, @"melee_weapon")
		if f134_local35 then
			f134_local34 = CoD.BlackMarketUtility.GetWeaponRef(f134_local35.name)
		end
		if f134_local34 then
			local f134_local36 = Engine[@"hash_4F9F1239CFD921FE"](f134_local34.displayNameRef)
			f134_local0 = f134_local34.name
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](f134_local34.displayDescRef)
			f134_local4 = f134_local34.primaryImage
			f134_local14 = f134_local34.weaponInfo
			f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_586BD6B0420B77FE")
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No melee weapon found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local24 = true
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"reactive_camo" or f134_arg2 == @"single_reactive_camo" then
		f134_local15 = f134_arg1
		f134_local7 = @"hash_52EEF729B41D6347"
		f134_local8 = @"hash_52EEF729B41D6347"
		if f134_arg2 == @"reactive_camo" then
			f134_local4 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f134_arg1)
		else
			f134_local4 = CoD.BlackMarketTableUtility.GetContrabandSingleCamoImageName(f134_arg0, f134_arg8)
		end
		local f134_local34 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f134_arg1)
		if f134_local34 ~= nil then
			local f134_local35 = f134_local34[1]
			f134_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local35, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
			if f134_local4 == nil or f134_local4 == 0x0 then
				f134_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local35, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"])
			end
		end
		local f134_local36 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f134_arg0, f134_arg1, f134_arg6, f134_arg5, f134_arg8))
		if f134_local36 then
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B6921A298FA490B", Engine[@"hash_4F9F1239CFD921FE"](f134_local36.displayNameRef))
			f134_local14 = f134_local36.weaponInfo
			if f134_arg2 == @"single_reactive_camo" and f134_local14.displayNameRef then
				f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_73CC9C023A12F461", f134_local14.displayNameRef)
				local f134_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
				if f134_local40 then
					f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local40)
					f134_local3 = f134_local14.displayNameRef
				end
			end
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error("Loot: No reactive camo weapon info found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"hash_5A72AF2C19CEFB8C" then
		local f134_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f134_arg0, f134_arg1, @"reactive_camo")
		if f134_local34 then
			f134_local15 = f134_local34.name
		else
			f134_local15 = 0x0
		end
		f134_local7 = @"hash_52EEF729B41D6347"
		f134_local8 = @"hash_29F902A4E4F760A0"
		f134_local4 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f134_local15)
		local f134_local35 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f134_local15)
		if f134_local35 ~= nil then
			local f134_local36 = f134_local35[1]
			f134_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
			if f134_local4 == nil or f134_local4 == 0x0 then
				f134_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"])
			end
		end
		local f134_local38 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f134_arg0, f134_arg1, f134_arg6, f134_arg5))
		if f134_local38 then
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B6921A298FA490B", Engine[@"hash_4F9F1239CFD921FE"](f134_local38.displayNameRef))
			f134_local14 = f134_local38.weaponInfo
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No reactive camo weapon info found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local24 = true
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"mastercraft" or f134_arg2 == @"mk2" then
		f134_local15 = f134_arg1
		if f134_arg2 == @"mastercraft" then
			local f134_local41 = 0x81782ED786B4A3
		end
		f134_local7 = f134_local41 or @"hash_1D4314C41E9C9CFC"
		f134_local8 = f134_local7
		local f134_local34 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f134_arg1)
		if f134_local34 ~= nil then
			local f134_local35 = f134_local34[1]
			f134_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local35, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
			f134_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local35, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"])
		end
		local f134_local35 = CoD.BlackMarketUtility.GetMastercraftWeaponRef(f134_arg1)
		if f134_local35 then
			local f134_local36 = Engine[@"hash_4F9F1239CFD921FE"](f134_local35.displayNameRef)
			if f134_arg2 == @"mastercraft" then
				f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6DDD1554BFF1E20B", f134_local36)
			else
				f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/mk2_desc", f134_local36)
				f134_local0 = f134_local35.name
			end
			f134_local4 = f134_local35.primaryImage
			f134_local14 = f134_local35.weaponInfo
			if f134_local14.ref then
				local f134_local37 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
				if f134_local37 then
					f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local37)
					f134_local3 = f134_local14.displayNameRef
				end
			end
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No mastercraft/mk2 weapon info found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == 0x44036371584190 then
		local f134_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f134_arg0, f134_arg1, @"mastercraft")
		if f134_local34 then
			f134_local15 = f134_local34.name
		else
			f134_local15 = 0x0
		end
		f134_local7 = @"hash_4672018B2DF3B222"
		f134_local8 = @"hash_29F902A4E4F760A0"
		f134_local24 = true
		local f134_local35 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f134_local15)
		if f134_local35 ~= nil then
			local f134_local36 = f134_local35[1]
			f134_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
			f134_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"])
		end
		local f134_local36 = CoD.BlackMarketUtility.GetMastercraftWeaponRef(f134_local15)
		if f134_local36 then
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6DDD1554BFF1E20B", Engine[@"hash_4F9F1239CFD921FE"](f134_local36.displayNameRef))
			f134_local4 = f134_local36.primaryImage
			f134_local14 = f134_local36.weaponInfo
			if f134_local14.ref then
				local f134_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
				if f134_local40 then
					f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local40)
					f134_local3 = f134_local14.displayNameRef
				end
			end
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"mk2_bundle" then
		local f134_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f134_arg0, f134_arg1, @"mk2")
		if f134_local34 then
			f134_local15 = f134_local34.name
		else
			f134_local15 = 0x0
		end
		f134_local7 = @"hash_28B384C77C6AD378"
		f134_local8 = @"hash_29F902A4E4F760A0"
		f134_local24 = true
		local f134_local35 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f134_local15)
		if f134_local35 ~= nil then
			local f134_local36 = f134_local35[1]
			f134_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
			f134_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"])
		end
		local f134_local36 = CoD.BlackMarketUtility.GetMastercraftWeaponRef(f134_local15)
		if f134_local36 then
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/mk2_desc", Engine[@"hash_4F9F1239CFD921FE"](f134_local36.displayNameRef))
			f134_local0 = f134_local36.name
			f134_local4 = f134_local36.primaryImage
			f134_local14 = f134_local36.weaponInfo
			if f134_local14.ref then
				local f134_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
				if f134_local40 then
					f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local40)
					f134_local3 = f134_local14.displayNameRef
				end
			end
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"weapon_camo" or f134_arg2 == @"single_camo" then
		f134_local15 = f134_arg1
		f134_local7 = @"menu/weapon_camo"
		f134_local8 = @"menu/weapon_camo"
		if f134_arg2 == @"weapon_camo" then
			f134_local4 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f134_arg1)
		elseif IsBooleanDvarSet(@"hash_232A243E731CD14B") then
			f134_local4 = @"blacktransparent"
		else
			f134_local4 = CoD.BlackMarketTableUtility.GetContrabandSingleCamoImageName(f134_arg0, f134_arg8)
		end
		local f134_local34 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f134_arg1)
		if f134_local34 ~= nil then
			local f134_local35 = f134_local34[1]
			f134_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local35, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_380D5B51243387A8")
			if f134_local4 == nil or f134_local4 == 0x0 then
				f134_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local35, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"])
			end
		end
		local f134_local36 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f134_arg0, f134_arg1, f134_arg6, f134_arg5, f134_arg8))
		if f134_local36 then
			local f134_local38 = Engine[@"hash_4F9F1239CFD921FE"](f134_local36.displayNameRef)
			f134_local14 = f134_local36.weaponInfo
			if f134_arg2 == @"single_camo" and f134_local14.displayNameRef then
				f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2D32436AD4978A37", f134_local14.displayNameRef)
				local f134_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
				if f134_local40 then
					f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local40)
					f134_local3 = f134_local14.displayNameRef
				end
			end
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"weapon_camo_bundle" or f134_arg2 == @"hash_1FBA128D08C2E117" then
		f134_local15 = f134_arg1
		local f134_local34 = nil
		if f134_arg2 == @"weapon_camo_bundle" then
			f134_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f134_arg0, f134_arg1, @"weapon_camo")
			if f134_local34 then
				f134_local15 = f134_local34.name
			end
		else
			f134_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f134_arg0, f134_arg1, @"single_camo")
			if f134_local34 then
				f134_local15 = f134_local34.name
			end
		end
		f134_local7 = @"menu/weapon_camo"
		f134_local8 = @"hash_29F902A4E4F760A0"
		if f134_arg2 == @"weapon_camo_bundle" then
			f134_local4 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f134_local15)
		else
			f134_local4 = CoD.BlackMarketTableUtility.GetContrabandSingleCamoImageName(f134_arg0, f134_arg8)
		end
		local f134_local35 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f134_local15)
		if f134_local35 ~= nil then
			local f134_local36 = f134_local35[1]
			f134_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_380D5B51243387A8")
			if f134_local4 == nil or f134_local4 == 0x0 then
				f134_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f134_local36, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"])
			end
		end
		local f134_local36 = CoD.BlackMarketUtility.GetTableWeaponRef(f134_arg0, f134_local15, f134_arg6, f134_arg5, f134_arg8)
		if not f134_local36 and f134_arg2 == @"weapon_camo_bundle" then
			f134_local36 = CoD.BlackMarketUtility.GetTableWeaponRef(f134_arg0, f134_local15, LuaEnum.LOOT_TYPE.BUNDLE, f134_arg5, f134_arg8)
		end
		local f134_local38 = CoD.BlackMarketUtility.GetWeaponRef(f134_local36)
		if f134_local38 then
			local f134_local39 = Engine[@"hash_4F9F1239CFD921FE"](f134_local38.displayNameRef)
			f134_local14 = f134_local38.weaponInfo
			if f134_arg2 == @"single_camo" and f134_local14.displayNameRef then
				f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2D32436AD4978A37", f134_local14.displayNameRef)
			end
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
		f134_local24 = true
	elseif f134_arg2 == @"range_weapon" then
		f134_local7 = @"hash_27303A43CCBD4D41"
		f134_local8 = @"hash_27303A43CCBD4D41"
		local f134_local34 = CoD.BlackMarketUtility.GetWeaponRef(f134_arg1)
		if f134_local34 then
			local f134_local35 = Engine[@"hash_4F9F1239CFD921FE"](f134_local34.displayNameRef)
			f134_local0 = f134_local34.name
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](f134_local34.displayDescRef)
			f134_local4 = f134_local34.primaryImage
			f134_local14 = f134_local34.weaponInfo
			if f134_local14.ref then
				local f134_local39 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f134_local14.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"]))
				if f134_local39 then
					f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](f134_local39)
				end
			end
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f134_arg2 == @"character" or f134_arg2 == @"specialist" then
		local f134_local34 = Enum[@"emodes"][@"mode_warzone"]
		if f134_arg2 == @"character" then
			f134_local7 = @"menu/blackout_character"
			f134_local8 = @"menu/blackout_character"
		else
			f134_local7 = @"menu/specialist"
			f134_local8 = @"menu/specialist"
			f134_local34 = Enum[@"emodes"][@"mode_multiplayer"]
		end
		local f134_local35 = CoD.PlayerRoleUtility.GetHeroList(f134_local34)
		local f134_local36 = nil
		for f134_local40, f134_local42 in ipairs(f134_local35) do
			local f134_local43 = Engine[@"getpositionrolebundleinfo"](f134_local34, f134_local42.bodyIndex)
			if f134_local43 and f134_arg1 == f134_local43[@"hash_41D6157DBA773DA3"] then
				f134_local36 = Engine[@"hash_682C5756563934AE"](f134_local34, f134_local42.bodyIndex)
				break
			end
		end
		if f134_local36 then
			f134_local38 = Engine[@"hash_284E3CB0C7D8BA11"](f134_local34, f134_local36)
			f134_local39 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f134_local34, f134_local38)
			f134_local37 = f134_local39.displayName
			f134_local40 = {
				mode = f134_local34,
				characterIndex = f134_local38,
				outfitIndex = 0,
				paletteIndex = 0,
			}
			f134_local42 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f134_local40.mode, f134_local40.characterIndex)
			local f134_local43 = f134_local42.outfits[f134_local40.outfitIndex + 1]
			f134_local0 = f134_local37
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.StreamCharacterDescTable[f134_local36] or @"hash_6CDD8929BD48E4E9")
			if f134_local31 and not (Engine[@"hash_5CAD03ACA52D910A"](f134_local40.mode, f134_local40.characterIndex) or f134_local39.positionDraftIcon) then
				local f134_local44 = Engine[@"hash_4F9F1239CFD921FE"](f134_local0)
				if not f134_local44 then
					f134_local44 = "<invalid character>"
				end
				CoD.BlackMarketUtility.Error(f134_arg0, "Loot: character " .. f134_local44 .. " has no loot stream icon in the player body type.\n")
			end
			f134_local10 = f134_local36
			f134_local11 = f134_local40
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No character has loot identifier '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	elseif f134_arg2 == @"gesture" then
		f134_local7 = @"menu/gesture"
		f134_local8 = @"menu/gesture"
		local f134_local34 = CoD.BlackMarketUtility.GetGestureRef(f134_arg0, f134_arg1, f134_arg5, f134_arg6)
		if f134_local34 then
			f134_local10 = f134_local34.character
			f134_local11 = f134_local34.outfitIndexes
			f134_local4 = f134_local34.primaryImage
			f134_local0 = f134_local34.name
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6977A1C579497A0A")
			f134_local12 = f134_local34.gesture_index
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No gesture info found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.GESTURE
	elseif f134_arg2 == @"gesture_bundle" then
		f134_local7 = @"menu/gesture"
		f134_local8 = @"hash_29F902A4E4F760A0"
		local f134_local34 = 0x0
		local f134_local35 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f134_arg0, f134_arg1, @"gesture")
		if f134_local35 then
			f134_local34 = f134_local35.name
		end
		local f134_local36 = CoD.BlackMarketUtility.GetGestureRef(f134_arg0, f134_local34, f134_arg5, f134_arg6)
		if f134_local36 then
			f134_local10 = f134_local36.character
			f134_local11 = f134_local36.outfitIndexes
			f134_local4 = f134_local36.primaryImage
			f134_local0 = f134_local36.name
			f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6977A1C579497A0A")
			f134_local12 = f134_local36.gesture_index
		elseif f134_local31 then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No gesture info found for '" .. tostring(f134_arg1) .. "'.\n")
		end
		f134_local29 = LuaEnum.LOOT_CAMERA_TYPE.GESTURE
		f134_local24 = true
	elseif f134_arg2 == @"reticle" then
		f134_local7 = @"hash_964C211767BBA0F"
		f134_local8 = @"hash_964C211767BBA0F"
		local f134_local34, f134_local35, f134_local36 = CoD.WeaponOptionsUtility.GetReticleLootStreamData(f134_arg1, f134_arg7)
		f134_local0 = f134_local34 or 0x0
		if not f134_local36 then
			f134_local36 = 0x0
		end
		f134_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_93B591B40C51B96", f134_local36)
		f134_local4 = f134_local35 or 0x0
		f134_local6 = f134_local35 or 0x0
		f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_313BE4995FD8DBF8")
		f134_local3 = f134_local36 or 0x0
	end
	if f134_local31 then
		if (not f134_local4 or f134_local4 == 0x0) and not f134_arg6 == LuaEnum.LOOT_TYPE.ITEMSHOP then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No primary image found for '" .. tostring(f134_arg1) .. "' (" .. tostring(f134_arg2) .. ").\n")
		end
		if (not f134_local0 or f134_local0 == 0x0) and not f134_arg6 == LuaEnum.LOOT_TYPE.ITEMSHOP then
			CoD.BlackMarketUtility.Error(f134_arg0, "Loot: No name found for '" .. tostring(f134_arg1) .. "' (" .. tostring(f134_arg2) .. ").\n")
		end
	end
	if f134_local30 then
		f134_local9 = Enum[@"lootraritytype"][@"loot_rarity_type_count"]
	else
		f134_local9 = CoD.BlackMarketUtility.GetLootRarityType(f134_arg3)
	end
	if f134_arg4 ~= nil and f134_arg4 ~= 0x0 then
		if IsJapaneseSku() then
			f134_local17 = 0x0
			f134_local18 = false
		else
			f134_local2 = Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketTableUtility.GetLootBonusStringRef(f134_arg0, f134_arg4))
			if f134_arg2 == @"tag_bundle" then
				f134_local3 = 0x0
			else
				f134_local3 = @"hash_1F6BC2AD33480070"
			end
			f134_local16 = CoD.BlackMarketTableUtility.GetBonusSetMasterNameHash(f134_arg4)
			if f134_arg2 ~= @"tag" then
			else
			end
			for f134_local39, f134_local37 in ipairs(CoD.BreadcrumbUtility.GetSprayGestureTable()) do
				if f134_local37[@"assetname"] == f134_local16 then
					f134_local16 = f134_local37[@"icon"]
					f134_local17 = f134_local37[@"title"]
				end
			end
		end
	end
	if f134_local2 == nil then
		f134_local2 = ""
	end
	if f134_local3 == nil then
		f134_local3 = 0x0
	end
	if f134_local5 == 0x0 then
		f134_local5 = f134_local4
	end
	if f134_local14 and not f134_local14.modelIdx then
		f134_local14.modelIdx = 0
	end
	return {
		itemName = f134_arg1,
		name = f134_local0,
		desc = f134_local1,
		mainExtraText = f134_local2,
		subExtraText = f134_local3,
		primaryImage = f134_local4,
		popupImage = f134_local6,
		detailsImage = f134_local5,
		category = f134_local7,
		itemCategory = f134_arg2,
		rarity = f134_local9,
		skipDefaultTitle = true,
		character = f134_local10,
		outfitIndexes = f134_local11,
		gesture_index = f134_local12,
		signatureWeaponInfo = f134_local13,
		baseWeaponInfo = f134_local14,
		camoRef = f134_local15,
		setBonusImage = f134_local16,
		setBonusName = f134_local17,
		setComplete = f134_local18,
		setNumOwned = f134_local19,
		setNumTotal = f134_local21,
		isContrabandCrate = f134_local22,
		isBundle = f134_local24,
		allowTogglePreview = f134_local25,
		allowFrozenMoment = f134_local26,
		shopCategory = f134_local8,
		seasonal = f134_local27,
		includesTiers = f134_local28,
		lootType = f134_arg6,
		cameraType = f134_local29,
		isContract = false,
		movieName = f134_local32,
		toolTipText = f134_local33,
	}
end
CoD.BlackMarketUtility.TierItemsAppendBlank = function(f135_arg0, f135_arg1, f135_arg2, f135_arg3)
	for f135_local0 = f135_arg1, f135_arg2, 1 do
		table.insert(f135_arg0, CoD.BlackMarketUtility.GetEmptyInsertItem(f135_local0, f135_local0 <= f135_arg3))
	end
end
CoD.BlackMarketUtility.TierItemsAppend = function(f136_arg0, f136_arg1, f136_arg2, f136_arg3, f136_arg4, f136_arg5)
	for f136_local0 = f136_arg3, f136_arg4, 1 do
		local f136_local3 = f136_local0 <= f136_arg5
		local f136_local4 = CoD.BlackMarketTableUtility.GetStreamItemsByTier(f136_arg0, f136_arg2, f136_local0)
		local f136_local5 = CoD.BlackMarketUtility.GetEmptyInsertItem(f136_local0, f136_local3)
		if f136_local4 ~= nil and #f136_local4 ~= 0 then
			if f136_local4[1].name ~= nil and f136_local4[1].name ~= 0x0 and f136_local4[1].category ~= nil and f136_local4[1].rarity ~= nil then
				local f136_local6 = {}
				f136_local6 = CoD.BlackMarketUtility.GetItemRefs(f136_arg0, f136_local4[1].name, f136_local4[1].category, f136_local4[1].rarity, f136_local4[1].inSet, f136_arg2, f136_local4[1].lootType, f136_local4[1].refOptic, f136_local4[1].itemId)
				f136_local6.tier = f136_local0
				f136_local6.unlocked = f136_local3
				f136_local6.lootType = f136_local4[1].lootType
				if f136_local4[1].dupe then
					f136_local6.dupe = f136_local4[1].dupe
				else
					f136_local6.dupe = false
				end
				if f136_local4[1].reroll then
					f136_local6.reroll = f136_local4[1].reroll
				else
					f136_local6.reroll = false
				end
				f136_local6.movieName = f136_local4[1].movieName or ""
				if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and (f136_local4[1].itemId == "420487198" or f136_local4[1].itemId == "162635431") then
					f136_local6.movieName = ""
				end
				f136_local6.gap = true
				f136_local5 = f136_local6
			elseif f136_local4[1].name == 0x0 and f136_local4[1].gap then
				f136_local5.gap = true
			end
		end
		table.insert(f136_arg1, f136_local5)
	end
end
CoD.BlackMarketUtility.GetTierItemsForStream = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3, f137_arg4)
	local f137_local0 = {}
	if f137_arg3 and not Engine[@"hash_1BFC6045CA596824"](f137_arg0, CoDShared.Loot.GetCurrentSeason(), f137_arg1) then
		Engine[0x165DC7DAA0794C](f137_arg0, CoDShared.Loot.GetCurrentSeason(), f137_arg1)
	end
	local f137_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f137_arg0)
	local f137_local2 = CoDShared.Loot.GetCurrentSeason()
	if f137_local2 and f137_local2 ~= 0x0 then
		local f137_local3 = CoDShared.Loot.GetSeasonInfo(f137_local2)
		if CoDShared.Loot.GetSeasonInfoParam(f137_local2, CoDShared.Loot.SEASON_INFO_NUMBER) >= 3 then
			for f137_local4 = f137_arg1, f137_arg2, 1 do
				CoD.BlackMarketUtility.TierItemsAppend(f137_arg0, f137_local0, f137_local3.id, f137_local4, f137_local4, f137_local1)
			end
		elseif CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f137_arg0), "LootStreamProgress.allRngUnlocked") == true then
			for f137_local4 = f137_arg1, f137_arg2, 1 do
				if f137_local1 < f137_local4 and f137_local4 > CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
					CoD.BlackMarketUtility.TierItemsAppendBlank(f137_local0, f137_local4, f137_local4, f137_local1)
				else
					CoD.BlackMarketUtility.TierItemsAppend(f137_arg0, f137_local0, f137_local3.id, f137_local4, f137_local4, f137_local1)
				end
			end
		else
			CoD.BlackMarketUtility.TierItemsAppend(f137_arg0, f137_local0, f137_local3.id, f137_arg1, f137_arg2, f137_local1)
		end
	end
	local f137_local3 = CoDShared.Loot.GetCurrentEventContract()
	if f137_local3 and f137_local3 ~= 0x0 then
		local f137_local4 = CoDShared.Loot.GetContractInfo(f137_arg0, f137_local3)
		CoD.BlackMarketUtility.TierItemsAppend(f137_arg0, f137_local0, f137_local4.id, f137_arg1, f137_arg2, f137_local1)
	end
	if CoD.BlackMarketUtility.AreContractsEnabled() then
		local f137_local4 = false
		for f137_local9, f137_local10 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f137_arg0)) do
			if f137_local10.id > 0 and (CoD.perController[f137_arg0].haveActiveContractInStream or not CoD.ContractUtility.IsContractComplete(f137_arg0, f137_local10.id) or f137_arg4) then
				CoD.BlackMarketUtility.TierItemsAppend(f137_arg0, f137_local0, f137_local10.id, f137_arg1, f137_arg2, f137_local1)
				f137_local4 = true
			end
		end
		f137_local6 = false
		if not f137_local4 then
			for f137_local11, f137_local12 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
				if not CoD.ContractUtility.IsContractPurchased(f137_arg0, f137_local12) then
					f137_local6 = true
					break
				end
			end
		end
		if not f137_local4 then
			CoD.BlackMarketUtility.TierItemsAppendBlank(f137_local0, f137_arg1, f137_arg2, f137_local1)
		end
	end
	if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_5DC2632EE88877F2"]:exists() then
		local f137_local4 = tonumber(Dvar[@"hash_5DC2632EE88877F2"]:get())
		for f137_local5 = 1, f137_local4, 1 do
			local f137_local8 = f137_local5
			CoD.BlackMarketUtility.TierItemsAppendBlank(f137_local0, f137_arg1, f137_arg2, f137_local1)
		end
	end
	return f137_local0
end
CoD.BlackMarketUtility.GetPaletteFromOutfitInfo = function(f138_arg0, f138_arg1)
	for f138_local3, f138_local4 in ipairs(f138_arg0.palettes) do
		if f138_local4.displayName == f138_arg1 then
			return f138_local3 - 1
		end
	end
	return 0
end
CoD.BlackMarketUtility.FindCharacterDetailsFromLootId = function(f139_arg0)
	local f139_local0 = {
		armsIndex = -1,
		decalIndex = -1,
		headIndex = -1,
		headgearIndex = -1,
		legsIndex = -1,
		paletteIndex = -1,
		torsoIndex = -1,
		war_paintIndex = -1,
		presetIndex = -1,
		mode = f139_arg0.mode,
	}
	local f139_local1 = -1
	if f139_arg0 and f139_arg0.prt then
		f139_local1 = Engine[@"hash_17A27F5596966FEA"](f139_local0.mode, f139_arg0.prt)
	end
	if f139_local1 >= 0 then
		f139_local0.characterIndex = f139_local1
		local f139_local2 = -1
		if f139_arg0.outfit then
			f139_local2 = Engine[@"hash_2DCBEC2E0A9518B7"](f139_local0.mode, f139_local1, f139_arg0.outfit)
			if f139_local2 >= 0 then
				f139_local0.outfitIndex = f139_local2
				local f139_local3 = function(f140_arg0, f140_arg1)
					if f139_arg0[f140_arg0] ~= 0x0 then
						local f140_local0 = Engine[0x1556270BCD75F1](f139_local0.mode, f139_local1, f139_local2, f139_arg0[f140_arg0], f140_arg1)
						if f140_local0 >= 0 then
							return f140_local0
						end
					end
					return -1
				end
				f139_local0.decalIndex = f139_local3("decal", Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"])
				f139_local0.war_paintIndex = f139_local3("war_paint", Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"])
				if f139_arg0.preset and f139_arg0.preset ~= 0x0 then
					local f139_local4, f139_local5 = Engine[@"hash_7E1AA381BC4D0919"](f139_local0.mode, f139_local1, f139_local2, f139_arg0.preset)
					if f139_local4 >= 0 then
						f139_local0.presetIndex = f139_local4
						if f139_local5 then
							f139_local0.armsIndex = f139_local5[Enum[@"characteritemtype"][@"hash_141B42F0A58AC50F"]] or -1
							f139_local0.headIndex = f139_local5[Enum[@"characteritemtype"][@"hash_37AD40A4111A72FE"]] or -1
							f139_local0.headgearIndex = f139_local5[Enum[@"characteritemtype"][@"hash_4FF8573E011622F4"]] or -1
							f139_local0.legsIndex = f139_local5[Enum[@"characteritemtype"][@"hash_283CBB806B732B11"]] or -1
							f139_local0.paletteIndex = f139_local5[Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"]] or -1
							f139_local0.torsoIndex = f139_local5[Enum[@"characteritemtype"][@"hash_19DDCEC39BA98B97"]] or -1
						end
						if f139_local0.war_paintIndex == -1 then
							local f139_local6 = Engine[@"hash_3544F754695D09F5"](f139_local0.mode, f139_local1, f139_local2, f139_arg0.preset)
							if f139_local6 >= 0 then
								f139_local0.war_paintIndex = f139_local6
							end
						end
					end
				elseif f139_local0.war_paintIndex >= -1 then
					local f139_local4 = Engine[@"hash_2D9F74DA4E09BB13"](f139_local0.mode, f139_local1, f139_local2, f139_arg0.war_paint)
					if f139_local4 >= 0 then
						f139_local0.paletteIndex = f139_local4
					end
				end
			end
		end
	end
	return f139_local0
end
CoD.BlackMarketUtility.TEMP_FindCharacterDetailsFromTempProduct = function(f141_arg0)
	return nil, nil, nil
end
DataSources.QuarterMasterCategoryList = ListHelper_SetupDataSource(
	"QuarterMasterCategoryList",
	function(f142_arg0, f142_arg1)
		local f142_local0 = {}
		local f142_local1 = IsBooleanDvarSet(@"hash_1A8E4D68B803874")
		local f142_local2 = f142_arg1 and f142_arg1.menu._tab
		if not f142_local2 or f142_local2 == "" then
			f142_local2 = "itemshop"
		end
		local f142_local3 = function(f143_arg0, f143_arg1, f143_arg2, f143_arg3, f143_arg4)
			table.insert(f142_local0, {
				models = {
					category = f143_arg0,
					name = f143_arg1,
					frameWidget = f143_arg2,
					available = f143_arg3,
					showCaseBreadcrumb = f143_arg4,
				},
				properties = {
					selectIndex = f142_local2 == f143_arg0,
				},
			})
		end
		if CoD.BlackMarketUtility.AreCoDPointsEnabled() then
			local f142_local4 = Dvar[@"hash_76C53836C456EC20"]
			if f142_local4 then
				f142_local4 = Dvar[@"hash_76C53836C456EC20"]:exists()
				if f142_local4 then
					f142_local4 = tonumber(Dvar[@"hash_76C53836C456EC20"]:get()) == 1
				end
			end
			local f142_local5
			if f142_local1 then
				f142_local5 = "CoD.BlackJacksShopFrameSunset"
				if not f142_local5 then
				else
					f142_local3("itemshop", @"hash_790379DA9EEC8DB9", f142_local5, f142_local4 == true, false)
				end
			end
			f142_local5 = "CoD.BlackJacksShopFrame"
		end
		if IsBooleanDvarSet(@"hash_1989C6B82918FBCC") and not Engine[@"hash_5CB675CA7856DA25"]() then
			f142_local3("reserves", @"hash_725FC26BF505BC71", "CoD.BlackjackReserveFrame", true, true)
		end
		f142_local3("supplychain", @"menu/supply_chain", "CoD.SupplyChainFrame", true, false)
		if not Engine[@"hash_5CB675CA7856DA25"]() then
			f142_local3("inventory", @"menu/inventory", "CoD.ItemHistoryFrame", true, false)
		end
		return f142_local0
	end,
	nil,
	nil,
	function(f144_arg0, f144_arg1, f144_arg2)
		if not f144_arg1._quarterMasterCategoryList then
			f144_arg1._quarterMasterCategoryList = true
			f144_arg1._isReservesActive = IsBooleanDvarSet("loot_enable_blackjack_reserves")
			f144_arg1._isSunsetActive = IsBooleanDvarSet(@"hash_1A8E4D68B803874")
			local f144_local0 = f144_arg1
			local f144_local1 = f144_arg1.subscribeToModel
			local f144_local2 = Engine[@"getmodelforcontroller"](f144_arg0)
			f144_local1(f144_local0, f144_local2:create("QuarterMasterTabUpdate"), function()
				f144_arg1:updateDataSource()
			end, false)
			f144_arg1:subscribeToGlobalModel(f144_arg0, "AutoEvents", "cycled", function()
				local f146_local0 = IsBooleanDvarSet("loot_enable_blackjack_reserves")
				local f146_local1 = IsBooleanDvarSet(@"hash_1A8E4D68B803874")
				if f144_arg1._isReservesActive ~= f146_local0 or f144_arg1._isSunsetActive ~= f146_local1 then
					f144_arg1._isReservesActive = f146_local0
					f144_arg1._isSunsetActive = f146_local1
					f144_arg1:updateDataSource()
				end
			end, false)
		end
	end
)
CoD.BlackMarketUtility.SetPropertiesFromItemModel = function(f147_arg0, f147_arg1)
	local f147_local0 = f147_arg1:getModel()
	if f147_local0.outfitIndexes then
		f147_arg1.mode = f147_local0.outfitIndexes.mode:get()
		f147_arg1.characterIndex = f147_local0.outfitIndexes.characterIndex:get()
		if f147_local0.outfitIndexes.outfitIndex then
			f147_arg1.outfitIndex = f147_local0.outfitIndexes.outfitIndex:get()
			f147_arg1.armsIndex = f147_local0.outfitIndexes.armsIndex and f147_local0.outfitIndexes.armsIndex:get() or 0
			f147_arg1.decalIndex = f147_local0.outfitIndexes.decalIndex and f147_local0.outfitIndexes.decalIndex:get() or 0
			f147_arg1.headIndex = f147_local0.outfitIndexes.headIndex and f147_local0.outfitIndexes.headIndex:get() or 0
			f147_arg1.headgearIndex = f147_local0.outfitIndexes.headgearIndex and f147_local0.outfitIndexes.headgearIndex:get() or 0
			f147_arg1.legsIndex = f147_local0.outfitIndexes.legsIndex and f147_local0.outfitIndexes.legsIndex:get() or 0
			f147_arg1.paletteIndex = f147_local0.outfitIndexes.paletteIndex and f147_local0.outfitIndexes.paletteIndex:get() or 0
			f147_arg1.torsoIndex = f147_local0.outfitIndexes.torsoIndex and f147_local0.outfitIndexes.torsoIndex:get() or 0
			f147_arg1.war_paintIndex = f147_local0.outfitIndexes.war_paintIndex and f147_local0.outfitIndexes.war_paintIndex:get() or 0
		end
	end
	if f147_local0.baseWeaponInfo then
		f147_arg1.baseWeaponInfo = {
			weaponSlot = f147_local0.baseWeaponInfo.weaponSlot:get(),
			ref = f147_local0.baseWeaponInfo.ref:get(),
			displayNameRef = f147_local0.baseWeaponInfo.displayNameRef:get(),
			modelIdx = f147_local0.baseWeaponInfo.modelIdx and f147_local0.baseWeaponInfo.modelIdx:get() or 0,
		}
	else
		f147_arg1.baseWeaponInfo = nil
	end
	if f147_local0.signatureWeaponInfo then
		f147_arg1.signatureWeaponInfo = {
			weaponSlot = f147_local0.signatureWeaponInfo.weaponSlot:get(),
			ref = f147_local0.signatureWeaponInfo.ref:get(),
			signatureIndex = f147_local0.signatureWeaponInfo.signatureIndex:get(),
			mastercraftIndex = f147_local0.signatureWeaponInfo.mastercraftIndex:get(),
			displayNameRef = f147_local0.signatureWeaponInfo.displayNameRef:get(),
			mastercraftNameRef = f147_local0.signatureWeaponInfo.mastercraftNameRef:get(),
		}
	else
		f147_arg1.signatureWeaponInfo = nil
	end
	if f147_local0.camoRef then
		f147_arg1.camoRef = f147_local0.camoRef:get()
	end
	if f147_local0.gesture_index then
		f147_arg1.gesture_index = f147_local0.gesture_index:get()
	end
end
CoD.BlackMarketUtility.IsItemPurchased = function(f148_arg0, f148_arg1)
	local f148_local0 = CoDLootShared.GetItemNameHashFromLootId(f148_arg1)
	if f148_local0 and CoD.BlackMarketTableUtility.IsItemLootBundle(f148_arg0, f148_local0) and Engine[@"hash_5352DC095BBB2A45"](f148_arg0, f148_arg1) == 0 then
		return CoD.BlackMarketTableUtility.AreAllBundleKeyItemsOwned(f148_arg0, f148_local0)
	else
		return Engine[@"hash_5352DC095BBB2A45"](f148_arg0, f148_arg1) > 0
	end
end
CoD.BlackMarketUtility.GetItemShopDatasourceModelValues = function(f149_arg0, f149_arg1)
	local f149_local0 = CoD.BlackMarketUtility.GetItemRefs(f149_arg0, f149_arg1.name, f149_arg1.category, f149_arg1.rarity, f149_arg1.inSet, nil, f149_arg1.lootType, f149_arg1.refOptic, f149_arg1.itemId)
	f149_local0.price = f149_arg1.price
	if f149_local0.itemCategory ~= @"signature_weapon" then
		f149_local0.allowTogglePreview = false
	end
	local f149_local1 = Engine[@"hash_2E00B2F29271C60B"](f149_arg1.name .. "_shop")
	if f149_local1 == nil then
		f149_local1 = Engine[@"hash_2E00B2F29271C60B"](f149_arg1.name)
	end
	if f149_local1 then
		f149_local0.lootType = LuaEnum.LOOT_TYPE.ITEMSHOP
		if f149_local1[@"hash_3884A61F286BB7C4"] then
			f149_local0.primaryImage = f149_local1[@"hash_3884A61F286BB7C4"]
			f149_local0.detailsImage = f149_local1[@"hash_3884A61F286BB7C4"]
			if f149_local0.popupImage ~= nil and f149_local0.popupImage ~= 0x0 and f149_local0.itemCategory ~= @"jump_kit" then
				f149_local0.popupImage = f149_local1[@"hash_3884A61F286BB7C4"]
			end
		end
		if f149_local1[@"nametext"] then
			f149_local0.name = f149_local1[@"nametext"]
		end
		if f149_local1[@"categorytext"] then
			f149_local0.category = f149_local1[@"categorytext"]
			f149_local0.shopCategory = f149_local1[@"categorytext"]
		end
		if f149_local1[@"desctext"] then
			if f149_local1[@"hash_5705C4C12FE1D66A"] then
				f149_local0.desc = Engine[@"hash_4F9F1239CFD921FE"](f149_local1[@"desctext"], f149_local1[@"hash_5705C4C12FE1D66A"])
			else
				f149_local0.desc = Engine[@"hash_4F9F1239CFD921FE"](f149_local1[@"desctext"])
			end
		end
		if f149_local1[@"hash_3C3F1121EF65852D"] then
			f149_local0.mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](f149_local1[@"hash_3C3F1121EF65852D"])
		end
		if f149_local1[@"hash_4B2638377E03D79A"] then
			f149_local0.subExtraText = f149_local1[@"hash_4B2638377E03D79A"]
		end
		if f149_local1[@"detailsicon"] then
			f149_local0.detailsImage = f149_local1[@"detailsicon"]
		end
	else
		for f149_local5, f149_local6 in pairs(CoD.BlackMarketUtility.ItemShopImageOverrideTable) do
			if f149_local0.primaryImage == f149_local5 then
				f149_local0.primaryImage = f149_local6
				break
			end
		end
	end
	f149_local0.skuID = f149_arg1.itemId
	f149_local0.hashName = f149_arg1.name
	local f149_local2 = f149_arg1.movieName
	if not f149_local2 then
		f149_local2 = ""
	end
	f149_local0.movieName = f149_local2
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and (f149_arg1.itemId == "420487198" or f149_arg1.itemId == "162635431") then
		f149_local0.movieName = ""
	end
	f149_local0.purchased = CoD.BlackMarketUtility.IsItemPurchased(f149_arg0, f149_arg1.itemId)
	if f149_local0.purchased == false then
		f149_local0.purchased = CoD.BlackMarketTableUtility.AreAllBundleKeyItemsOwned(f149_arg0, f149_local0.hashName)
	end
	f149_local0.totalRewardCount = 1
	f149_local2 = CoD.BlackMarketTableUtility.GetBundlePiecesInformation(f149_arg0, f149_arg1.name)
	if f149_local2 then
		f149_local0.totalRewardCount = #f149_local2
	end
	f149_local0.percentOff = 0
	if f149_local0.movieName and f149_local0.movieName ~= "" then
		f149_local0.isLooping = true
		f149_local0.isStreamed = false
	end
	if f149_local0.movieName == "core_frontend_ar_modular_mk2" then
		f149_local0.isLooping = false
	end
	if IsBooleanDvarSet("loot_enable_discounts") and f149_arg1.discountSkuId and f149_arg1.discountSkuId ~= "" and f149_arg1.discountPrice and f149_arg1.discountPrice > 0 then
		f149_local0.skuID = f149_arg1.discountSkuId
		f149_local0.price = f149_arg1.discountPrice
		f149_local0.percentOff = math.floor((1 - f149_arg1.discountPrice / f149_arg1.price) * 100)
	end
	return f149_local0
end
CoD.BlackMarketUtility.CreateItemShopDatasource = function(f150_arg0, f150_arg1)
	local f150_local0 = {}
	local f150_local1 = {}
	for f150_local5, f150_local6 in ipairs(CoD.BlackMarketUtility["FeaturedSlot" .. f150_arg1 .. "Items"]) do
		if f150_local6 then
			table.insert(f150_local1, f150_local6)
		end
	end
	table.sort(f150_local1, function(f151_arg0, f151_arg1)
		return Engine[@"isgreaterthan"](f151_arg0.start, f151_arg1.start)
	end)
	f150_local2 = {}
	f150_local3 = {}
	for f150_local4 = 1, #f150_local1, 1 do
		local f150_local7 = CoD.BlackMarketTableUtility.GetItemShopInformation(f150_arg0, f150_local1[f150_local4].name)
		if f150_local7 then
			local f150_local8 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f150_arg0, f150_local7)
			if f150_local8.purchased ~= true then
				table.insert(f150_local2, f150_local8)
			else
				table.insert(f150_local3, f150_local8)
			end
		end
	end
	for f150_local9, f150_local7 in ipairs(f150_local3) do
		table.insert(f150_local2, f150_local7)
	end
	for f150_local4 = 1, #f150_local2, 1 do
		local f150_local7, f150_local8 = CoD.BlackMarketUtility.GetItemProductAndProperties(f150_local2[f150_local4])
		f150_local7.stackPosition = f150_local4
		f150_local7.stackTotal = #f150_local2
		f150_local7.storePreview = true
		f150_local7.slot = f150_arg1
		table.insert(f150_local0, {
			models = f150_local7,
			properties = f150_local8,
		})
	end
	return f150_local0
end
CoD.BlackMarketUtility.ForceStreamedStoreImages = {}
CoD.BlackMarketUtility.ForceStreamStoreImages = function(f152_arg0)
	local f152_local0 = {}
	local f152_local1 = {}
	local f152_local2 = CoD.BlackMarketUtility.CreateItemShopDatasource(f152_arg0, 1)
	local f152_local3 = CoD.BlackMarketUtility.CreateItemShopDatasource(f152_arg0, 2)
	for f152_local8, f152_local9 in ipairs(f152_local2) do
		for f152_local5, f152_local6 in ipairs(f152_local9) do
			if f152_local6.models and f152_local6.models.primaryImage then
				CoD.BaseUtility.AddForcedImageToTable(f152_local6.models.primaryImage, f152_local0)
				if f152_local6.models.detailsImage and f152_local6.models.detailsImage ~= f152_local6.models.primaryImage then
					CoD.BaseUtility.AddForcedImageToTable(f152_local6.models.detailsImage, f152_local0)
				end
			end
		end
	end
	for f152_local9, f152_local10 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
		local f152_local11 = CoD.ContractUtility.GetContractListModels(f152_arg0, f152_local10)
		if f152_local11 and f152_local11.previewImage then
			CoD.BaseUtility.AddForcedImageToTable(f152_local11.previewImage, f152_local0)
		end
	end
	CoD.BlackMarketUtility.ForceStreamedStoreImages = CoD.BaseUtility.ForceStreamHelper(CoD.BlackMarketUtility.ForceStreamedStoreImages, f152_local0)
end
CoD.BlackMarketUtility.ForceStreamStoreImagesSunset = function(f153_arg0, f153_arg1)
	local f153_local0 = {}
	local f153_local1 = {}
	f153_arg1._detItemSlot1 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f153_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
	f153_arg1._detItemSlot2 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f153_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
	f153_arg1._rngItemSlot3 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f153_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"])
	table.insert(f153_local1, f153_arg1._detItemSlot1)
	table.insert(f153_local1, f153_arg1._detItemSlot2)
	table.insert(f153_local1, f153_arg1._rngItemSlot3)
	for f153_local8, f153_local9 in ipairs(f153_local1) do
		for f153_local5, f153_local6 in ipairs(f153_local9) do
			if f153_local6.models and f153_local6.models.primaryImage then
				CoD.BaseUtility.AddForcedImageToTable(f153_local6.models.primaryImage, f153_local0)
				if f153_local6.models.detailsImage and f153_local6.models.detailsImage ~= f153_local6.models.primaryImage then
					CoD.BaseUtility.AddForcedImageToTable(f153_local6.models.detailsImage, f153_local0)
				end
			end
		end
	end
	CoD.BlackMarketUtility.ForceStreamedStoreImages = CoD.BaseUtility.ForceStreamHelper(CoD.BlackMarketUtility.ForceStreamedStoreImages, f153_local0)
end
DataSources.ItemShopSlot1List = ListHelper_SetupDataSource("ItemShopSlot1List", function(f154_arg0)
	return CoD.BlackMarketUtility.CreateItemShopDatasource(f154_arg0, 1)
end)
DataSources.ItemShopSlot2List = ListHelper_SetupDataSource("ItemShopSlot2List", function(f155_arg0)
	return CoD.BlackMarketUtility.CreateItemShopDatasource(f155_arg0, 2)
end)
DataSources.ItemShopSlot3List = ListHelper_SetupDataSource("ItemShopSlot3List", function(f156_arg0)
	local f156_local0 = {}
	local f156_local1 = {}
	for f156_local5, f156_local6 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
		local f156_local7 = CoD.ContractUtility.GetContractListModels(f156_arg0, f156_local6)
		CoD.ContractUtility.AppendPurchasableContractSlotModels(f156_arg0, f156_local7, 3)
		f156_local7.storePreview = true
		f156_local7.slot = 3
		if f156_local7.purchased ~= true then
			table.insert(f156_local0, {
				models = f156_local7,
				properties = {
					inPurchasableRow = true,
					contractModels = f156_local7,
				},
			})
		else
			table.insert(f156_local1, {
				models = f156_local7,
				properties = {
					inPurchasableRow = true,
					contractModels = f156_local7,
				},
			})
		end
	end
	for f156_local5, f156_local6 in ipairs(f156_local1) do
		table.insert(f156_local0, f156_local6)
	end
	return f156_local0
end)
CoD.BlackMarketUtility.IsMyShopItemRevealed = function(f157_arg0)
	local f157_local0 = Engine[@"hash_12C2DB3D3E1B227E"](f157_arg0)
	local f157_local1
	if f157_local0 ~= nil then
		f157_local1 = f157_local0.timestamp
		if not f157_local1 then
		else
			if f157_local0 == nil or not CoD.BlackMarketUtility.CanRevealMyShopItem(f157_arg0) or CoD.BlackMarketUtility.IsMyShopItemOld(f157_arg0, f157_local1, f157_local0.itemId) then
				return false
			else
				return true
			end
		end
	end
	f157_local1 = nil
end
DataSources.MyShopItemList = ListHelper_SetupDataSource("MyShopItemList", function(f158_arg0)
	local f158_local0 = {}
	local f158_local1, f158_local2, f158_local3 = nil
	local f158_local4 = "0"
	local f158_local5 = Engine[@"hash_12C2DB3D3E1B227E"](f158_arg0)
	if f158_local5 == nil or not CoD.BlackMarketUtility.CanRevealMyShopItem(f158_arg0) then
		local f158_local6 = CoD.BlackMarketUtility.GetEmptyInsertItem(1, false)
		if f158_local6 then
			local f158_local7, f158_local8 = CoD.BlackMarketUtility.GetItemProductAndProperties(f158_local6)
			f158_local7.revealed = false
			f158_local7.percentOff = 0
			f158_local7.contractId = "0"
			table.insert(f158_local0, {
				models = f158_local7,
				properties = f158_local8,
			})
			return f158_local0
		end
	end
	f158_local4 = f158_local5.timestamp
	f158_local3 = f158_local5.price_point
	if CoD.BlackMarketUtility.IsMyShopItemOld(f158_arg0, f158_local4, f158_local5.itemId) then
		local f158_local6 = CoD.BlackMarketUtility.GetEmptyInsertItem(1, false)
		if f158_local6 then
			local f158_local7, f158_local8 = CoD.BlackMarketUtility.GetItemProductAndProperties(f158_local6)
			f158_local7.revealed = false
			f158_local7.percentOff = 0
			f158_local7.contractId = "0"
			table.insert(f158_local0, {
				models = f158_local7,
				properties = f158_local8,
			})
		end
	else
		f158_local1 = f158_local5.itemId
		f158_local2 = CoD.BlackMarketTableUtility.GetMyShopItemNameFromId(f158_arg0, f158_local1)
		if f158_local2 and f158_local1 then
			local f158_local6 = CoD.BlackMarketTableUtility.GetMyShopItemCategory(f158_arg0, f158_local2)
			local f158_local7 = CoD.BlackMarketTableUtility.GetMyShopSkuAndPrice(f158_arg0, f158_local2, f158_local3)
			if f158_local6 == @"special_order" then
				local f158_local8 = CoD.ContractUtility.GetContractListModels(f158_arg0, f158_local1)
				CoD.ContractUtility.AppendPurchasableContractSlotModels(f158_arg0, f158_local8, 4)
				f158_local8.storePreview = true
				f158_local8.revealed = true
				if Dvar[@"hash_1931ECBB3DB3B98E"]:get() and f158_local8.price and f158_local8.price > 0 then
					f158_local8.percentOff = math.floor((1 - f158_local7.price / f158_local8.price) * 100)
				end
				f158_local8.price = f158_local7.price or 0
				f158_local8.skuID = f158_local7.sku or "0"
				f158_local8.slot = 4
				table.insert(f158_local0, {
					models = f158_local8,
					properties = {
						inPurchasableRow = true,
						contractModels = f158_local8,
					},
				})
			else
				local f158_local8 = nil
				if f158_local6 == @"loot_stream" then
					f158_local8 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f158_arg0, f158_local1)
				else
					f158_local8 = CoD.BlackMarketTableUtility.GetItemShopInformation(f158_arg0, f158_local2)
				end
				if f158_local8 then
					local f158_local9 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f158_arg0, f158_local8)
					if f158_local9 then
						local f158_local10, f158_local11 = CoD.BlackMarketUtility.GetItemProductAndProperties(f158_local9)
						f158_local10.revealed = true
						if Dvar[@"hash_1931ECBB3DB3B98E"]:get() and f158_local10.price and f158_local10.price > 0 then
							f158_local10.percentOff = math.floor((1 - f158_local7.price / f158_local10.price) * 100)
						end
						f158_local10.price = f158_local7.price
						f158_local10.skuID = f158_local7.sku
						f158_local10.slot = 4
						f158_local10.lootType = LuaEnum.LOOT_TYPE.ITEMSHOP
						f158_local10.storePreview = true
						table.insert(f158_local0, {
							models = f158_local10,
							properties = f158_local11,
						})
					end
				end
			end
		end
	end
	return f158_local0
end)
CoD.BlackMarketUtility.IsMyShopItemOld = function(f159_arg0, f159_arg1, f159_arg2)
	local f159_local0 = Engine[@"hash_2C778D3D40E06605"](f159_arg1, CoD.BlackMarketUtility.GetMyShopRotateTime())
	local f159_local1 = tostring(Engine[@"getcurrentutctimestr"]())
	if Engine[@"isgreaterthan"](f159_local1, CoD.BlackMarketUtility.MyShopResetTime) and Engine[@"isgreaterthan"](Engine[@"hash_2C778D3D40E06605"](CoD.BlackMarketUtility.MyShopResetTime, CoD.BlackMarketUtility.GetMyShopRotateTime()), f159_local0) then
		return true
	elseif not Engine[@"isgreaterthan"](f159_local0, f159_local1) then
		return true
	elseif Dvar[@"hash_34BAB578B077EAF1"]:get() and f159_arg2 and CoD.BlackMarketUtility.IsItemPurchased(f159_arg0, f159_arg2) then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.RevealMyShopItem = function(f160_arg0, f160_arg1)
	local f160_local0 = CoD.BlackMarketUtility.GetMyShopWeightedItem(f160_arg0)
	if not f160_local0 then
		return
	else
		local f160_local1 = f160_local0.pricePoint
		Engine[@"hash_45FDA5F675A65C94"](f160_arg0, f160_local0.itemId, Engine[@"getcurrentutctimestr"](), f160_local1)
		Engine[@"storagewrite"](f160_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		local f160_local2 = CoD.BlackMarketTableUtility.GetMyShopSkuAndPrice(f160_arg0, f160_local0.itemNameHash, f160_local1)
		CoD.MetricsUtility.BlackMarketItemShopEvent(f160_arg0, 4, "revealed", f160_local2.sku, f160_local0.itemNameHash, 0, 0, f160_local2.price, 0)
		f160_arg1._revealTimer = LUI.UITimer.newElementTimer(CoD.BlackMarketUtility.GetMyShopRevealDelay() * 1000, true, function()
			CoD.GridAndListUtility.UpdateDataSource(f160_arg1, true, true, true)
		end)
		f160_arg1:addElement(f160_arg1._revealTimer)
	end
end
CoD.BlackMarketUtility.GetMyShopItems = function(f162_arg0)
	local f162_local0 = CoD.BlackMarketTableUtility.GetAllMyShopItems(f162_arg0)
	if f162_local0 == nil or #f162_local0 == 0 then
		return nil
	end
	local f162_local1 = function(f163_arg0, f163_arg1, f163_arg2, f163_arg3)
		local f163_local0 = {}
		local f163_local1 = Engine[@"hash_12C2DB3D3E1B227E"](f163_arg0)
		for f163_local7, f163_local8 in ipairs(f163_arg1) do
			local f163_local9 = f163_local8.name
			if f163_local8.weight > 0 then
				local f163_local5 = CoD.BlackMarketTableUtility.GetMyShopItemId(f163_arg0, f163_local9)
				if f163_local5 then
					local f163_local6 = CoD.BlackMarketUtility.CheckMyShopExperiment(f163_arg0, {
						itemId = f163_local5,
						itemNameHash = f163_local9,
						weight = f163_local8.weight,
						pricePoint = f163_local8.pricePoint,
					})
					if f163_local6 and not CoD.BlackMarketUtility.IsItemPurchased(f163_arg0, f163_local6.itemId) and (f163_arg2 or not Engine[@"hash_4E972B5D4746712B"](f163_arg0, f163_local6.itemId)) and (f163_arg3 or f163_local1.itemId ~= f163_local6.itemId) then
						table.insert(f163_local0, f163_local6)
					end
				end
			end
		end
		return f163_local0
	end
	local f162_local2 = f162_local1(f162_arg0, f162_local0, false, false)
	if #f162_local2 == 0 then
		f162_local2 = f162_local1(f162_arg0, f162_local0, true, false)
	end
	if #f162_local2 == 0 then
		f162_local2 = f162_local1(f162_arg0, f162_local0, true, true)
	end
	return f162_local2
end
CoD.BlackMarketUtility.CanRevealMyShopItem = function(f164_arg0)
	local f164_local0 = CoD.BlackMarketUtility.GetMyShopItems(f164_arg0)
	return f164_local0 and #f164_local0 > 0
end
CoD.BlackMarketUtility.CheckMyShopExperiment = function(f165_arg0, f165_arg1)
	if CoD.BlackMarketUtility.MyShopExperiments[f165_arg1.itemNameHash] then
		local f165_local0 = CoD.StoreUtility.GetExperimentModifier(f165_arg0, CoD.BlackMarketUtility.MyShopExperiments[f165_arg1.itemNameHash].expKey)
		if f165_local0 then
			f165_arg1.itemNameHash = CoD.BlackMarketUtility.MyShopExperiments[f165_arg1.itemNameHash].itemRefs[f165_local0]
			if not f165_arg1.itemNameHash then
				return nil
			else
				f165_arg1.pricePoint = 1
				f165_arg1.itemId = CoD.BlackMarketTableUtility.GetMyShopItemId(f165_arg0, f165_arg1.itemNameHash)
				return f165_arg1
			end
		else
			return nil
		end
	else
		return f165_arg1
	end
end
CoD.BlackMarketUtility.GetMyShopWeightedItem = function(f166_arg0)
	local f166_local0 = CoD.BlackMarketUtility.GetMyShopItems(f166_arg0)
	if #f166_local0 > 0 then
		local f166_local1 = 0
		for f166_local5, f166_local6 in ipairs(f166_local0) do
			f166_local1 = f166_local1 + f166_local6.weight
			f166_local6.weight = f166_local1
		end
		if f166_local1 == 0 then
			return nil
		end
		f166_local2 = math.random(f166_local1)
		for f166_local6, f166_local7 in ipairs(f166_local0) do
			if f166_local2 <= f166_local7.weight and f166_local7 ~= nil then
				return f166_local7
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.UpdateItemShopSunsetShopCategory = function(f167_arg0)
	if f167_arg0.shopCategory == @"menu/weapon_camo" then
		f167_arg0.shopCategory = @"hash_1E2BD8FAC00570CD"
	elseif f167_arg0.shopCategory == @"hash_5F5E657D5E5ED4E7" then
		f167_arg0.shopCategory = @"hash_75A209CBF7E80864"
	elseif f167_arg0.shopCategory == @"hash_1ADD4C3535DC47" then
		f167_arg0.shopCategory = @"menu/single_warpaint"
	elseif f167_arg0.shopCategory == @"hash_52EEF729B41D6347" then
		f167_arg0.shopCategory = @"hash_135C59EF56FA3EC4"
	elseif f167_arg0.shopCategory == @"hash_57B491E0F2A8C286" then
		f167_arg0.shopCategory = @"hash_282802065CF60EAA"
	end
end
CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource = function(f168_arg0, f168_arg1)
	local f168_local0 = {}
	local f168_local1, f168_local2, f168_local3, f168_local4, f168_local5 = nil
	local f168_local6 = true
	local f168_local7 = false
	local f168_local8 = Engine[@"hash_6F2CB6360236F359"](f168_arg0, f168_arg1)
	if not f168_local8 then
		f168_local4 = CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem(f168_arg0, f168_arg1)
		f168_local6 = f168_local4 ~= nil
	elseif CoD.BlackMarketUtility.IsItemShopSunsetSlotItemOld(f168_arg0, f168_local8.reveal_expiration, f168_local8.itemId) or Engine[@"hash_5352DC095BBB2A45"](f168_arg0, f168_local8.itemId) > 0 then
		f168_local4 = CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem(f168_arg0, f168_arg1)
		f168_local6 = f168_local4 ~= nil
	end
	local f168_local9 = CoD.BlackMarketUtility.BlackjackShopSlotIndex[f168_arg1]
	local f168_local10 = DataSources.ItemshopRotation.getModel(f168_arg0)
	local f168_local11 = "loot_itemshop_slot"
	f168_local10["loot_itemshop_slot" .. f168_local9 .. "_timer_active"]:set(f168_local6)
	if not f168_local6 then
		f168_local10 = CoD.BlackMarketUtility.GetEmptyInsertItem(1, false)
		if f168_local10 then
			local f168_local11, f168_local12 = CoD.BlackMarketUtility.GetItemProductAndProperties(f168_local10)
			f168_local11.revealed = true
			f168_local11.emptyItem = true
			f168_local11.isInItemShop = true
			f168_local11.percentOff = 0
			f168_local11.contractId = "0"
			table.insert(f168_local0, {
				models = f168_local11,
				properties = f168_local12,
			})
			return f168_local0
		end
	end
	if f168_local4 then
		f168_local1 = f168_local4.itemId
		f168_local3 = f168_local4.pricePoint
		f168_local7 = true
	else
		f168_local1 = f168_local8.itemId
		f168_local3 = f168_local8.price_point
	end
	if Engine[@"isdevelopmentbuild"]() then
		f168_local10 = ""
		if f168_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
			f168_local10 = "slot1"
		elseif f168_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
			f168_local10 = "slot2"
		elseif f168_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
			f168_local10 = "slot3"
		end
		if f168_local10 ~= "" then
			f168_local11 = Engine[@"getdvarstring"]("loot_sunsetShop_" .. f168_local10 .. "_fakeId")
			if f168_local11 and f168_local11 ~= "" then
				f168_local1 = f168_local11
			end
			local f168_local12 = Engine[@"getdvarstring"]("loot_sunsetShop_" .. f168_local10 .. "_fakePricePoint")
			if f168_local12 and f168_local12 ~= "" then
				f168_local3 = tonumber(f168_local12)
			end
		end
	end
	f168_local10 = f168_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]
	if f168_local10 then
		f168_local5 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f168_arg0, f168_local1, 0)
		f168_local2 = f168_local5 and f168_local5.name
	else
		f168_local2 = CoD.BlackMarketTableUtility.GetDeterministicItemNameFromId(f168_arg0, f168_local1)
	end
	if f168_local2 and f168_local1 then
		f168_local11 = nil
		local f168_local12 = {}
		if f168_local10 then
			f168_local11 = @"contraband"
		else
			f168_local11 = CoD.BlackMarketTableUtility.GetDeterministicItemCategory(f168_arg0, f168_local2)
			f168_local12 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f168_arg0, f168_local2, f168_local3)
		end
		if f168_local11 == @"special_order" then
			local f168_local13 = CoD.ContractUtility.GetContractListModels(f168_arg0, f168_local1)
			CoD.ContractUtility.AppendPurchasableContractSlotModels(f168_arg0, f168_local13, 4)
			f168_local13.storePreview = true
			f168_local13.revealed = not f168_local7
			f168_local13.emptyItem = false
			f168_local13.isInItemShop = true
			local f168_local14 = f168_local12.cpPrice
			if not f168_local14 then
				f168_local14 = 0
			end
			f168_local13.price = f168_local14
			f168_local14 = f168_local12.cpSku
			if not f168_local14 then
				f168_local14 = "0"
			end
			f168_local13.skuID = f168_local14
			f168_local14 = f168_local12.casePrice
			if not f168_local14 then
				f168_local14 = 0
			end
			f168_local13.casePrice = f168_local14
			f168_local14 = f168_local12.caseRule
			if not f168_local14 then
				f168_local14 = "0"
			end
			f168_local13.caseRule = f168_local14
			f168_local13.slot = f168_local9
			f168_local13.toolTipText = CoD.BlackMarketUtility.BlackjackShopSlotTooltipText[f168_arg1]
			table.insert(f168_local0, {
				models = f168_local13,
				properties = {
					inPurchasableRow = true,
					contractModels = f168_local13,
				},
			})
		else
			local f168_local13 = nil
			local f168_local14 = f168_local12.cpPrice
			if not f168_local14 then
				f168_local14 = 0
			end
			local f168_local15 = f168_local12.cpSku
			if not f168_local15 then
				f168_local15 = "0"
			end
			local f168_local16 = f168_local12.casePrice
			if not f168_local16 then
				f168_local16 = 0
			end
			local f168_local17 = f168_local12.caseRule
			if not f168_local17 then
				f168_local17 = "0"
			end
			if f168_local11 == @"loot_stream" then
				f168_local13 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f168_arg0, f168_local1)
			elseif f168_local11 == @"contraband" then
				f168_local13 = f168_local5
				f168_local14 = f168_local13.cpPrice or f168_local14
				f168_local15 = f168_local13.cpSku or f168_local15
				f168_local16 = f168_local13.casePrice or f168_local16
				f168_local17 = f168_local13.caseRule or f168_local17
			else
				f168_local13 = CoD.BlackMarketTableUtility.GetItemShopInformation(f168_arg0, f168_local2)
			end
			if f168_local13 then
				local f168_local18 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f168_arg0, f168_local13)
				if f168_local18 then
					if f168_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
						CoD.BlackMarketUtility.UpdateItemShopSunsetShopCategory(f168_local18)
						if f168_local18.subExtraText == @"hash_1F6BC2AD33480070" then
							f168_local18.subExtraText = 0x0
						end
					end
					if CoD.BlackMarketUtility.BlackjackShopSunsetOverridePopupImageItems[f168_local2] then
						f168_local18.popupImage = f168_local18.primaryImage
					end
					local f168_local19, f168_local20 = CoD.BlackMarketUtility.GetItemProductAndProperties(f168_local18)
					f168_local19.revealed = not f168_local7
					f168_local19.emptyItem = false
					f168_local19.isInItemShop = true
					f168_local19.price = f168_local14
					f168_local19.skuID = f168_local15
					f168_local19.casePrice = f168_local16
					f168_local19.caseRule = f168_local17
					f168_local19.slot = f168_local9
					local f168_local21
					if f168_local10 then
						f168_local21 = LuaEnum.LOOT_TYPE.CONTRABAND
						if not f168_local21 then
						else
							f168_local19.lootType = f168_local21
							f168_local19.storePreview = true
							f168_local19.inventoryIcon = @"blacktransparent"
							f168_local19.earnedRewardCount = 0
							f168_local19.totalRewardCount = 0
							f168_local19.toolTipText = CoD.BlackMarketUtility.BlackjackShopSlotTooltipText[f168_arg1]
							table.insert(f168_local0, {
								models = f168_local19,
								properties = f168_local20,
							})
						end
					end
					f168_local21 = LuaEnum.LOOT_TYPE.ITEMSHOP
				end
			end
		end
	end
	return f168_local0
end
CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup = function(f169_arg0, f169_arg1, f169_arg2, f169_arg3)
	if not f169_arg1.__sunsetSlotListSubscriptions then
		f169_arg1.__sunsetSlotListSubscriptions = true
		local f169_local0 = Engine[@"getmodelforcontroller"](f169_arg0)
		if not f169_local0.sunsetPurchasedSlot then
			f169_local0 = Engine[@"getmodelforcontroller"](f169_arg0)
			f169_local0 = f169_local0:create("sunsetPurchasedSlot")
			f169_local0:set(Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"])
		end
		local f169_local1 = f169_arg1
		f169_local0 = f169_arg1.subscribeToModel
		local f169_local2 = Engine[@"getmodelforcontroller"](f169_arg0)
		f169_local0(f169_local1, f169_local2.sunsetPurchasedSlot, function(f170_arg0)
			if f170_arg0:get() == f169_arg3 then
				f170_arg0:set(Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"])
				f169_arg1:updateDataSource()
			end
		end)
	end
end
DataSources.DeterministicSlot1List = ListHelper_SetupDataSource(
	"DeterministicSlot1List",
	function(f171_arg0, f171_arg1)
		local f171_local0 = {}
		if f171_arg1.menu and f171_arg1.menu._detItemSlot1 then
			f171_local0 = f171_arg1.menu._detItemSlot1
			f171_arg1.menu._detItemSlot1 = nil
		else
			f171_local0 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f171_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
		end
		return f171_local0
	end,
	nil,
	nil,
	function(f172_arg0, f172_arg1, f172_arg2)
		CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup(f172_arg0, f172_arg1, f172_arg2, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
	end
)
DataSources.DeterministicSlot2List = ListHelper_SetupDataSource(
	"DeterministicSlot2List",
	function(f173_arg0, f173_arg1)
		local f173_local0 = {}
		if f173_arg1.menu and f173_arg1.menu._detItemSlot2 then
			f173_local0 = f173_arg1.menu._detItemSlot2
			f173_arg1.menu._detItemSlot2 = nil
		else
			f173_local0 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f173_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
		end
		return f173_local0
	end,
	nil,
	nil,
	function(f174_arg0, f174_arg1, f174_arg2)
		CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup(f174_arg0, f174_arg1, f174_arg2, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
	end
)
DataSources.RNGSlotList = ListHelper_SetupDataSource(
	"RNGSlotList",
	function(f175_arg0, f175_arg1)
		local f175_local0 = {}
		if f175_arg1.menu and f175_arg1.menu._rngItemSlot3 then
			f175_local0 = f175_arg1.menu._rngItemSlot3
			f175_arg1.menu._rngItemSlot3 = nil
		else
			f175_local0 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f175_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"])
		end
		return f175_local0
	end,
	nil,
	nil,
	function(f176_arg0, f176_arg1, f176_arg2)
		CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup(f176_arg0, f176_arg1, f176_arg2, Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"])
	end
)
CoD.BlackMarketUtility.IsItemShopSunsetSlotItemOld = function(f177_arg0, f177_arg1, f177_arg2)
	if not Engine[@"isgreaterthan"](f177_arg1, tostring(Engine[@"getcurrentutctimestr"]())) then
		return true
	elseif f177_arg2 and CoD.BlackMarketUtility.IsItemPurchased(f177_arg0, f177_arg2) then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem = function(f178_arg0, f178_arg1)
	local f178_local0 = nil
	local f178_local1 = 1
	if f178_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
		f178_local0 = CoD.BlackMarketUtility.GetRNGWeightedItem(f178_arg0, f178_arg1)
	else
		f178_local0 = CoD.BlackMarketUtility.GetDeterministicWeightedItem(f178_arg0, f178_arg1)
		f178_local1 = f178_local0 and f178_local0.pricePoint
	end
	if not f178_local0 then
		return
	end
	local f178_local2 = CoD.BlackMarketUtility.BlackjackShopSlotIndex[f178_arg1]
	local f178_local3 = Engine[@"hash_63998C7C8611C743"](f178_arg0, f178_local0.itemId, Engine[@"getcurrentutctimestr"](), Engine[@"hash_2C778D3D40E06605"](Engine[@"getcurrentutctimestr"](), CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime(f178_arg0, f178_local2)), f178_local1, f178_arg1)
	Engine[@"storagewrite"](f178_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	local f178_local4, f178_local5 = nil
	if f178_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
		f178_local5 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f178_arg0, f178_local0.itemId, 0)
		f178_local4 = f178_local5 and f178_local5.cpSku
	else
		f178_local5 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f178_arg0, f178_local0.itemNameHash, f178_local1)
		f178_local4 = f178_local5 and f178_local5.cpSku
	end
	local f178_local6 = f178_local2
	local f178_local7 = 0
	local f178_local8 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ItemshopRotation")
	if f178_local8 then
		local f178_local9 = f178_local8:create("loot_itemshop_slot" .. tostring(f178_local6) .. "_timer_raw")
		f178_local7 = f178_local9:get()
	end
	CoD.MetricsUtility.BlackMarketItemShopEvent(f178_arg0, f178_local6 + CoD.BlackMarketUtility.BlackjackShopSlotIndexSunsetOffset, "revealed", f178_local4, f178_local0.itemNameHash, 0, 0, f178_local7, tonumber(CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime(f178_arg0, f178_local2)), f178_local5.cpPrice, f178_local5.casePrice)
	return f178_local0
end
CoD.BlackMarketUtility.GetDeterministicItems = function(f179_arg0, f179_arg1)
	local f179_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f179_arg0, false)
	if f179_local0 == nil or #f179_local0 == 0 then
		return nil
	end
	local f179_local1 = {}
	local f179_local2 = {}
	local f179_local3 = CoD.BlackMarketUtility.GetItemShopSunsetSlotHistoryCount()
	local f179_local4 = function(f180_arg0)
		local f180_local0 = {}
		local f180_local1 = 0
		for f180_local5, f180_local6 in ipairs(f180_arg0) do
			if not f180_local0[f180_local6.name] then
				f180_local0[f180_local6.name] = true
				f180_local1 = f180_local1 + 1
			end
		end
		return f180_local1
	end
	local f179_local5 = function(f181_arg0, f181_arg1, f181_arg2, f181_arg3)
		local f181_local0 = {}
		local f181_local1 = Engine[@"hash_6F2CB6360236F359"](f181_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
		local f181_local2 = Engine[@"hash_6F2CB6360236F359"](f181_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
		local f181_local3 = -1
		if f181_arg3 then
			f181_local3 = f179_local4(f181_arg1)
		end
		for f181_local10, f181_local11 in ipairs(f181_arg1) do
			local f181_local12 = f181_local11.name
			if f181_local11.weight1 > 0 or f181_local11.weight2 > 0 then
				local f181_local7 = CoD.BlackMarketTableUtility.GetDeterministicItemId(f181_arg0, f181_local12)
				if f181_local7 then
					local f181_local8 = {
						itemId = f181_local7,
						itemNameHash = f181_local12,
						weight1 = f181_local11.weight1,
						weight2 = f181_local11.weight2,
						pricePoint = f181_local11.pricePoint,
					}
					if not CoD.BlackMarketUtility.IsItemPurchased(f181_arg0, f181_local8.itemId) then
						local f181_local9 = true
						if f181_arg2 then
							if not f181_arg3 then
								f181_local9 = not Engine[@"hash_2853265290D721E1"](f181_arg0, f181_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"], f179_local3)
								if f181_local9 then
									f181_local9 = not Engine[@"hash_2853265290D721E1"](f181_arg0, f181_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"], f179_local3)
								end
								if not f181_local9 then
									table.insert(f179_local2, f181_local11)
								end
							end
						else
							f181_local9 = not Engine[@"hash_6C4B83E18D078C98"](f181_arg0, f181_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
							if f181_local9 then
								f181_local9 = not Engine[@"hash_6C4B83E18D078C98"](f181_arg0, f181_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
							end
							if not f181_local9 then
								table.insert(f179_local1, f181_local11)
							end
						end
						if f181_local9 then
							if f181_arg3 and f181_local3 <= 2 then
								if f179_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
									f181_local9 = f181_local8.itemId ~= f181_local2.itemId
								elseif f179_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
									f181_local9 = f181_local8.itemId ~= f181_local1.itemId
								end
							elseif f181_local8.itemId == f181_local1.itemId or f181_local8.itemId == f181_local2.itemId then
								f181_local9 = false
							else
								f181_local9 = true
							end
						end
						if f181_local9 then
							table.insert(f181_local0, f181_local8)
						end
					end
				end
			end
		end
		return f181_local0
	end
	local f179_local6 = f179_local5(f179_arg0, f179_local0, false, false)
	if #f179_local6 == 0 then
		f179_local6 = f179_local5(f179_arg0, f179_local1, true, false)
	end
	if #f179_local6 == 0 then
		f179_local6 = f179_local5(f179_arg0, f179_local2, true, true)
	end
	return f179_local6
end
CoD.BlackMarketUtility.GetRNGItems = function(f182_arg0, f182_arg1)
	local f182_local0 = CoD.BlackMarketTableUtility.GetAllContrabandItem(f182_arg0, false)
	if f182_local0 == nil or #f182_local0 == 0 then
		return nil
	end
	local f182_local1 = {}
	local f182_local2 = {}
	local f182_local3 = CoD.BlackMarketUtility.GetItemShopSunsetSlotHistoryCount()
	local f182_local4 = function(f183_arg0)
		local f183_local0 = {}
		local f183_local1 = 0
		for f183_local5, f183_local6 in ipairs(f183_arg0) do
			if not f183_local0[f183_local6.name] then
				f183_local0[f183_local6.name] = true
				f183_local1 = f183_local1 + 1
			end
		end
		return f183_local1
	end
	local f182_local5 = function(f184_arg0, f184_arg1, f184_arg2, f184_arg3)
		local f184_local0 = {}
		local f184_local1 = Engine[@"hash_6F2CB6360236F359"](f184_arg0, f182_arg1)
		local f184_local2 = -1
		if f184_arg3 then
			f184_local2 = f182_local4(f184_arg1)
		end
		for f184_local8, f184_local9 in ipairs(f184_arg1) do
			if f184_local9.weight > 0 and f184_local9.itemId then
				local f184_local6 = {
					itemId = f184_local9.itemId,
					itemNameHash = f184_local9.name,
					weight = f184_local9.weight,
				}
				if not CoD.BlackMarketUtility.IsItemPurchased(f184_arg0, f184_local6.itemId) then
					local f184_local7 = true
					if f184_arg2 then
						if not f184_arg3 then
							f184_local7 = not Engine[@"hash_2853265290D721E1"](f184_arg0, f184_local6.itemId, f182_arg1, f182_local3)
							if not f184_local7 then
								table.insert(f182_local2, f184_local9)
							end
						end
					else
						f184_local7 = not Engine[@"hash_6C4B83E18D078C98"](f184_arg0, f184_local6.itemId, f182_arg1)
						if not f184_local7 then
							table.insert(f182_local1, f184_local9)
						end
					end
					if f184_local7 and f184_arg3 and f184_local2 > 1 then
						f184_local7 = f184_local6.itemId ~= f184_local1.itemId
					end
					if f184_local7 then
						table.insert(f184_local0, f184_local6)
					end
				end
			end
		end
		return f184_local0
	end
	local f182_local6 = f182_local5(f182_arg0, f182_local0, false, false)
	if #f182_local6 == 0 then
		f182_local6 = f182_local5(f182_arg0, f182_local1, true, false)
	end
	if #f182_local6 == 0 then
		f182_local6 = f182_local5(f182_arg0, f182_local2, true, true)
	end
	return f182_local6
end
CoD.BlackMarketUtility.CanRevealDeterministicItem = function(f185_arg0, f185_arg1)
	local f185_local0 = CoD.BlackMarketUtility.GetDeterministicItems(f185_arg0, f185_arg1)
	return f185_local0 and #f185_local0 > 0
end
CoD.BlackMarketUtility.GetDeterministicWeightedItem = function(f186_arg0, f186_arg1)
	local f186_local0 = CoD.BlackMarketUtility.GetDeterministicItems(f186_arg0, f186_arg1)
	if #f186_local0 > 0 then
		local f186_local1 = 0
		for f186_local5, f186_local6 in ipairs(f186_local0) do
			if f186_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
				f186_local6.weight1 = f186_local1 + f186_local6.weight1
			end
			if f186_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
				f186_local6.weight2 = f186_local1 + f186_local6.weight2
			end
		end
		if f186_local1 == 0 then
			return nil
		end
		f186_local2 = math.random(f186_local1)
		for f186_local6, f186_local8 in ipairs(f186_local0) do
			local f186_local7 = 0
			if f186_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
				f186_local7 = f186_local8.weight1
			elseif f186_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
				f186_local7 = f186_local8.weight2
			end
			if f186_local2 <= f186_local7 and f186_local8 ~= nil then
				return f186_local8
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetRNGWeightedItem = function(f187_arg0, f187_arg1)
	local f187_local0 = CoD.BlackMarketUtility.GetRNGItems(f187_arg0, f187_arg1)
	if #f187_local0 > 0 then
		local f187_local1 = 0
		for f187_local5, f187_local6 in ipairs(f187_local0) do
			f187_local1 = f187_local1 + f187_local6.weight
			f187_local6.weight = f187_local1
		end
		if f187_local1 == 0 then
			return nil
		end
		f187_local2 = math.random(f187_local1)
		for f187_local6, f187_local7 in ipairs(f187_local0) do
			if f187_local2 <= f187_local7.weight and f187_local7 ~= nil then
				return f187_local7
			end
		end
	end
	return nil
end
DataSources.WeaponBribeList = ListHelper_SetupDataSource("WeaponBribeList", function(f188_arg0)
	local f188_local0 = {}
	for f188_local7, f188_local8 in ipairs(CoD.BlackMarketTableUtility.GetWeaponBribeSelectionBribes(f188_arg0)) do
		local f188_local9 = Engine[@"hash_2E00B2F29271C60B"](f188_local8.name)
		if f188_local9 then
			local f188_local4 = {
				itemId = f188_local8.keyItem,
				name = CoDLootShared.GetItemNameHashFromLootId(f188_local8.keyItem),
				rarity = @"ultra",
				category = CoDLootShared.GetLootItemCategory(f188_local8.keyItem),
				lootType = CoDLootShared.GetLootItemLootType(f188_local8.keyItem),
			}
			local f188_local5, f188_local6 = CoD.BlackMarketUtility.GetItemProductAndProperties(CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f188_arg0, f188_local4))
			if f188_local4.category == @"mastercraft" then
				f188_local5.name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_341954FC612B5845", f188_local9[@"nametext"])
			else
				f188_local5.name = Engine[@"hash_4F9F1239CFD921FE"](f188_local9[@"nametext"])
			end
			f188_local5.desc = f188_local9[@"desctext"] and Engine[@"hash_4F9F1239CFD921FE"](f188_local9[@"desctext"]) or ""
			if f188_local9[@"hash_C25093DE08D3AC8"] and f188_local9[@"hash_7B2BB983050B1101"] and f188_local9[@"hash_565D6CA191CE39A9"] then
				f188_local5.popupDesc = Engine[@"hash_4F9F1239CFD921FE"](f188_local9[@"hash_C25093DE08D3AC8"], f188_local9[@"hash_7B2BB983050B1101"], f188_local9[@"hash_565D6CA191CE39A9"])
			elseif f188_local9[@"hash_C25093DE08D3AC8"] and f188_local9[@"hash_7B2BB983050B1101"] then
				f188_local5.popupDesc = Engine[@"hash_4F9F1239CFD921FE"](f188_local9[@"hash_C25093DE08D3AC8"], f188_local9[@"hash_7B2BB983050B1101"])
			elseif f188_local9[@"hash_C25093DE08D3AC8"] then
				f188_local5.popupDesc = Engine[@"hash_4F9F1239CFD921FE"](f188_local9[@"hash_C25093DE08D3AC8"])
			else
				f188_local5.popupDesc = f188_local5.desc
			end
			f188_local5.categoryText = f188_local9[@"categorytext"]
			f188_local5.image = f188_local9[@"hash_2B47C2D1A4104152"] or @"blacktransparent"
			f188_local5.popupImage = f188_local9[@"popupimage"] or @"blacktransparent"
			f188_local5.price = f188_local8.price
			f188_local5.casePrice = f188_local8.optionalCost
			f188_local5.lootRule = f188_local8.lootRule
			f188_local5.lootType = LuaEnum.LOOT_TYPE.ITEMSHOP
			f188_local5.allowTogglePreview = false
			f188_local5.isWeaponBribeSelect = true
			f188_local5.bribeStringName = f188_local8.stringName
			f188_local5.slot = 4
			f188_local6.sortIndex = f188_local8.sortIndex or 0
			table.insert(f188_local0, {
				models = f188_local5,
				properties = f188_local6,
			})
		end
	end
	table.sort(f188_local0, function(f189_arg0, f189_arg1)
		return f189_arg0.properties.sortIndex < f189_arg1.properties.sortIndex
	end)
	return f188_local0
end)
CoD.BlackMarketUtility.WeaponBribeSelectionAvailable = function(f190_arg0)
	return Engine[@"getsecondsremainingserver"](Engine[@"hash_6D80580D17461096"](f190_arg0, CoD.BlackMarketUtility.BribeMenuLootRule)) <= 0
end
CoD.BlackMarketUtility.CheckForBribePopupDescOverride = function(f191_arg0, f191_arg1)
	local f191_local0 = f191_arg0.popupDesc
	if f191_local0 then
		f191_local0 = f191_arg0.popupDesc:get()
	end
	if f191_local0 and f191_local0 ~= "" and f191_local0 ~= 0x0 then
		return f191_local0
	else
		return f191_arg1
	end
end
DataSources.ItemHistoryCategoryList = ListHelper_SetupDataSource("ItemHistoryCategoryList", function(f192_arg0)
	local f192_local0 = {}
	table.insert(f192_local0, {
		models = {
			category = "specialOrders",
			categoryNameRefXhash = @"menu/contracts",
			imageName = "",
		},
	})
	table.insert(f192_local0, {
		models = {
			category = "reserveHistory",
			categoryNameRefXhash = @"hash_41F507DCE83A87CF",
			imageName = "",
		},
	})
	return f192_local0
end)
DataSources.ItemHistoryList = ListHelper_SetupDataSource("ItemHistoryList", function(f193_arg0, f193_arg1)
	local f193_local0 = {}
	local f193_local1 = "specialOrders"
	local f193_local2 = f193_arg1.menu
	if f193_local2 then
		f193_local1 = f193_local2.category or f193_local1
	end
	local f193_local3 = {}
	if f193_local1 ~= "specialOrders" then
		local f193_local4 = CoD.BlackMarketUtility.FillContrabandDropNumber()
		if f193_local4 ~= 0 then
			local f193_local5 = Engine[@"gettablerowcount"](CoD.BlackMarketUtility.lootTableName)
			local f193_local6 = 0
			local f193_local7 = 9
			for f193_local8 = 0, f193_local5 - 1, 1 do
				local f193_local11 = tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f193_local8, f193_local7))
				if f193_local11 ~= nil and f193_local11 == f193_local4 then
					table.insert(f193_local3, {
						id = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f193_local8, f193_local6),
						modTime = "0",
					})
				end
			end
		else
			f193_local3 = Engine[@"hash_5139E55459401D30"](f193_arg0, CoD.BlackMarketUtility.ItemHistoryCount, 0, CoD.BlackMarketUtility[@"hash_491EF6C1326C6875"], CoD.BlackMarketUtility[@"hash_2BF3E69D05D1B50"], Enum[@"inventorysourcetype"][@"hash_5FB737E1D309F2D5"], CoD.BlackMarketUtility[0xE904580D0E4807], CoD.BlackMarketUtility[@"hash_1D620DA7785ED682"], Enum[@"inventorysourcetype"][@"hash_5FB737E1D309F2D5"])
		end
		for f193_local8, f193_local9 in ipairs(f193_local3) do
			local f193_local10 = 0x0
			local f193_local12 = nil
			f193_local10 = CoD.BlackMarketTableUtility.GetItemShopEntryName(f193_arg0, f193_local9.id)
			if f193_local10 ~= nil and f193_local10 ~= 0x0 then
				local f193_local11 = CoD.BlackMarketTableUtility.GetItemShopInformation(f193_arg0, f193_local10)
				if f193_local11 then
					f193_local12 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f193_arg0, f193_local11)
				end
			else
				local f193_local11 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f193_arg0, f193_local9.id)
				if f193_local11 then
					if Engine[@"isgreaterthan"](CoDShared.Loot.LastSeasonStartTime, f193_local9.modTime) or f193_local11.seasonId == CoD.BlackMarketTableUtility.GetSeasonId(CoDShared.Loot.GetCurrentSeason()) then
						f193_local12 = nil
					else
						f193_local12 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f193_arg0, f193_local11)
						if f193_local12.lootType ~= LuaEnum.LOOT_TYPE.ITEMSHOP then
							f193_local12.lootType = LuaEnum.LOOT_TYPE.CONTRABAND
						end
					end
				end
				if not f193_local12 then
					local f193_local13 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f193_arg0, f193_local9.id, 0)
					if f193_local13 and f193_local13.itemId then
						f193_local12 = CoD.BlackMarketUtility.GetItemRefs(f193_arg0, f193_local13.name, f193_local13.category, f193_local13.rarity, f193_local13.inSet, 0, f193_local13.lootType, f193_local13.refOptic, f193_local13.itemId)
					end
				end
			end
			if f193_local12 then
				local f193_local11, f193_local13 = CoD.BlackMarketUtility.GetItemProductAndProperties(f193_local12)
				if f193_local9.modTime then
					f193_local11.timeStamp = f193_local9.modTime
				else
					f193_local11.timeStamp = 0
				end
				if f193_local12.itemName ~= @"triple_play_dec2018" and f193_local12.itemName ~= @"triple_play_feb2019" and f193_local12.itemName ~= @"starter_pack_season_3" and f193_local12.itemName ~= @"ar_galil_t8" then
					table.insert(f193_local0, {
						models = f193_local11,
						properties = f193_local13,
					})
				end
			end
		end
	else
		f193_local0 = CoD.ContractUtility.GetPurchasedContractsModels(f193_arg0, true, true)
	end
	return f193_local0
end)
DataSources.ItemShopConfirmButtonList = ListHelper_SetupDataSource("ItemShopConfirmButtonList", function(f194_arg0)
	local f194_local0 = {}
	local f194_local1 = FileshareIsLocalCategory(f194_arg0)
	table.insert(f194_local0, {
		displayText = @"menu/purchase",
		displayDesc = @"hash_61A0434D7EFB5F33",
		action = SetWorkingStateAndPurchaseDWSKU,
		params = {
			controller = f194_arg0,
		},
	})
	local f194_local2 = {}
	for f194_local6, f194_local7 in ipairs(f194_local0) do
		table.insert(f194_local2, {
			models = {
				displayText = Engine[@"localize"](f194_local7.displayText),
			},
			properties = {
				action = f194_local7.action,
				actionParam = f194_local7.params,
			},
		})
	end
	return f194_local2
end)
DataSources.SupplyChainStreams = ListHelper_SetupDataSource(
	"SupplyChainStreams",
	function(f195_arg0)
		local f195_local0 = {}
		local f195_local1 = Engine[@"getmodelforcontroller"](f195_arg0)
		f195_local1:create("LootStreamProgress.playAnimation")
		local f195_local2 = {}
		CoD.perController[f195_arg0].upsellContractRowIndex = 0
		local f195_local3 = CoDShared.Loot.GetCurrentSeason()
		local f195_local4 = @"menu/supply_chain"
		local f195_local5 = Engine[@"hash_2E00B2F29271C60B"](f195_local3)
		if not f195_local5 then
			return {}
		end
		local f195_local6 = false
		local f195_local7 = f195_local5[@"hash_333645EBD6764BD9"] or f195_local5[@"contracttitle"]
		local f195_local8 = f195_local5[@"hash_474C547BF0F2C029"] or 0x0
		if CoD.BlackMarketUtility.GetCurrentSeasonTier(f195_arg0) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
			f195_local3 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
			f195_local6 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f195_arg0), "LootStreamProgress.allRngUnlocked") == true
			if f195_local6 then
				f195_local3 = CoD.BlackMarketUtility.GetCurrentPostSeasonAllRNGRef()
			end
			f195_local5 = Engine[@"hash_2E00B2F29271C60B"](f195_local3)
			f195_local4 = @"hash_528A006212176E51"
			f195_local7 = 0x0
			f195_local8 = 0x0
		end
		table.insert(f195_local2, {
			featureTitle = f195_local4,
			streamName = f195_local7,
			streamSubtitle = f195_local8,
			streamImage = f195_local5[@"contracticon"],
			price = 0,
			active = true,
			rarity = Enum[@"lootraritytype"][@"loot_rarity_type_count"],
			timeRemaining = 0,
			category = @"hash_0",
			isUpsell = false,
			isSpecialEvent = false,
			isContract = false,
			isContractComplete = f195_local6,
			character = @"hash_0",
			weaponRef = @"hash_0",
			properties = nil,
			seasonal = false,
		})
		local f195_local9 = CoDShared.Loot.GetCurrentEventContract()
		if f195_local9 ~= 0x0 then
			local f195_local10 = CoDShared.Loot.GetContractInfo(f195_arg0, f195_local9)
			if f195_local10 ~= nil then
				local f195_local11 = CoD.ContractUtility.GetContractListModels(f195_arg0, f195_local10.id)
				table.insert(f195_local2, {
					featureTitle = @"hash_6F385CAA9605AD8C",
					streamName = f195_local11.name,
					streamSubtitle = @"hash_0",
					streamImage = f195_local11.icon,
					price = 0,
					active = true,
					rarity = Enum[@"lootraritytype"][@"loot_rarity_type_count"],
					timeRemaining = 0,
					isUpsell = false,
					totalRewardCount = CoD.BlackMarketTableUtility.GetContractTierCount(f195_local10.id),
					earnedRewardCount = CoD.BlackMarketUtility.GetContractProgress(f195_arg0, f195_local10.name),
					rewardFractionString = f195_local11.rewardFractionString,
					category = @"hash_0",
					isSpecialEvent = true,
					isContract = false,
					isContractComplete = f195_local11.purchased,
					character = @"hash_0",
					weaponRef = @"hash_0",
					seasonal = false,
				})
			end
		end
		local f195_local10 = nil
		local f195_local11 = 3
		local f195_local12 = false
		if CoD.BlackMarketUtility.AreContractsEnabled() then
			for f195_local16, f195_local17 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
				if not CoD.ContractUtility.IsContractPurchased(f195_arg0, f195_local17) then
					f195_local10 = f195_local17
					break
				end
			end
			f195_local13 = CoD.BlackMarketUtility.GetActiveContracts(f195_arg0)
			for f195_local14 = 1, #f195_local13, 1 do
				local f195_local18 = f195_local13[f195_local14]
				f195_local18.id = tostring(f195_local18.id)
				if f195_local18 ~= nil and f195_local18.id ~= "0" then
					local f195_local19 = CoD.ContractUtility.GetContractListModels(f195_arg0, f195_local18.id)
					if not f195_local19.complete or f195_local19.complete and CoD.perController[f195_arg0].haveActiveContractInStream then
						table.insert(f195_local2, {
							featureTitle = @"hash_0",
							streamName = f195_local19.name,
							streamSubtitle = @"hash_0",
							streamImage = f195_local19.icon,
							price = f195_local19.price,
							active = true,
							rarity = f195_local19.rarity,
							timeRemaining = 0,
							isUpsell = false,
							isSpecialEvent = false,
							isContract = true,
							isContractComplete = f195_local19.complete,
							totalRewardCount = f195_local19.totalRewardCount,
							earnedRewardCount = f195_local19.earnedRewardCount,
							rewardFractionString = f195_local19.rewardFractionString,
							category = f195_local19.category,
							character = f195_local19.character,
							weaponRef = f195_local19.weaponRef,
							seasonal = f195_local19.seasonal,
							contractModels = f195_local19,
						})
						CoD.perController[f195_arg0].haveActiveContractInStream = true
						f195_local12 = true
						break
					end
				end
			end
			if f195_local10 and not f195_local12 then
				f195_local14 = CoD.ContractUtility.GetContractListModels(f195_arg0, f195_local10)
				if not f195_local14.purchased then
					CoD.ContractUtility.AppendPurchasableContractSlotModels(f195_arg0, f195_local14, f195_local11)
					f195_local14.movieName = nil
					table.insert(f195_local2, {
						featureTitle = @"hash_0",
						streamName = f195_local14.name,
						streamSubtitle = @"hash_0",
						streamImage = f195_local14.icon,
						price = f195_local14.price,
						active = false,
						rarity = f195_local14.rarity,
						category = f195_local14.category,
						timeRemaining = 0,
						contractTimerModel = f195_local14.timerModel,
						isUpsell = true,
						totalRewardCount = 0,
						earnedRewardCount = 0,
						rewardFractionString = "",
						isContract = true,
						isContractComplete = false,
						isSpecialEvent = false,
						character = f195_local14.character,
						weaponRef = f195_local14.weaponRef,
						baseWeaponInfo = f195_local14.baseWeaponInfo,
						cameraType = f195_local14.cameraType,
						seasonal = f195_local14.seasonal,
						contractModels = f195_local14,
						baseWeaponInfo = f195_local14.baseWeaponInfo,
						cameraType = f195_local14.cameraType,
					})
					CoD.perController[f195_arg0].upsellContractRowIndex = #f195_local2
				end
			elseif not f195_local12 then
				f195_local14 = Engine[@"hash_2E00B2F29271C60B"](@"loot_contract_completed")
				if f195_local14 then
					f195_local15 = false
					f195_local16 = f195_local14[@"hash_333645EBD6764BD9"] or f195_local14[@"contracttitle"]
					table.insert(f195_local2, {
						featureTitle = @"hash_0",
						streamName = @"hash_0",
						streamSubtitle = @"hash_0",
						streamImage = f195_local14[@"contracticon"],
						price = 0,
						active = true,
						rarity = Enum[@"lootraritytype"][@"loot_rarity_type_count"],
						timeRemaining = 0,
						category = @"hash_0",
						contractTimerModel = CoD.ContractUtility.GetSoonestContractTimer(f195_arg0),
						isUpsell = true,
						isSpecialEvent = true,
						isContract = true,
						isContractComplete = f195_local15,
						character = @"hash_0",
						weaponRef = @"hash_0",
						seasonal = false,
						properties = nil,
					})
				end
			end
		end
		if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_5DC2632EE88877F2"]:exists() then
			local f195_local20 = tonumber(Dvar[@"hash_5DC2632EE88877F2"]:get())
			for f195_local13 = 1, f195_local20, 1 do
				local f195_local16 = f195_local13
				table.insert(f195_local2, {
					featureTitle = @"hash_0",
					streamName = @"hash_0",
					streamSubtitle = @"hash_0",
					streamImage = @"blacktransparent",
					price = 600,
					active = false,
					rarity = Enum[@"lootraritytype"][@"loot_rarity_type_count"],
					category = @"hash_26A56A15E86A84F5",
					timeRemaining = 0,
					isUpsell = true,
					isSpecialEvent = false,
					isContract = false,
					isContractComplete = false,
					character = @"hash_0",
					weaponRef = @"hash_0",
					seasonal = false,
				})
			end
		end
		for f195_local20 = 1, #f195_local2, 1 do
			local f195_local16 = f195_local2[f195_local20]
			table.insert(f195_local0, {
				models = {
					featureTitle = f195_local16.featureTitle,
					streamName = f195_local16.streamName,
					streamSubtitle = f195_local16.streamSubtitle,
					streamImage = f195_local16.streamImage,
					price = f195_local16.price,
					active = f195_local16.active,
					rarity = f195_local16.rarity,
					timeRemaining = f195_local16.timeRemaining,
					contractTimerModel = f195_local16.contractTimerModel,
					isUpsell = f195_local16.isUpsell,
					isSpecialEvent = f195_local16.isSpecialEvent,
					isContract = f195_local16.isContract,
					isContractComplete = f195_local16.isContractComplete,
					totalRewardCount = f195_local16.totalRewardCount,
					earnedRewardCount = f195_local16.earnedRewardCount,
					rewardFractionString = f195_local16.rewardFractionString,
					category = f195_local16.category,
					contractModels = f195_local16.contractModels,
					character = f195_local16.character,
					weaponRef = f195_local16.weaponRef,
					seasonal = f195_local16.seasonal,
					baseWeaponInfo = f195_local16.baseWeaponInfo,
					cameraType = f195_local16.cameraType,
				},
				properties = {
					contractModels = f195_local16.contractModels,
				},
			})
		end
		return f195_local0
	end,
	nil,
	nil,
	function(f196_arg0, f196_arg1, f196_arg2)
		if not f196_arg1.__supplyChainStreamsSubscriptions then
			f196_arg1.__supplyChainStreamsSubscriptions = true
			local f196_local0 = f196_arg1
			local f196_local1 = f196_arg1.subscribeToModel
			local f196_local2 = Engine[@"getglobalmodel"]()
			f196_local1(f196_local0, f196_local2:create("ContractsForceUpdate"), function()
				f196_arg1:updateDataSource()
			end, false)
			f196_arg1.originalSeason = CoDShared.Loot.GetCurrentSeason()
			f196_arg1:subscribeToGlobalModel(f196_arg0, "AutoEvents", "cycled", function()
				if f196_arg1.originalSeason ~= CoDShared.Loot.GetCurrentSeason() then
					f196_arg1.originalSeason = CoDShared.Loot.GetCurrentSeason()
					SetFocusedTierModelValue(f196_arg0, "0", "")
				end
				f196_arg1:updateDataSource()
			end)
		end
	end
)
DataSources.LootTierItems = ListHelper_SetupDataSource(
	"LootTierItems",
	function(f199_arg0, f199_arg1)
		local f199_local0 = {}
		local f199_local1 = Engine[@"getmodelforcontroller"](f199_arg0)
		f199_local1 = f199_local1.FocusedTier
		if f199_local1 then
			local f199_local2 = f199_local1:get() or 0
			local f199_local3 = f199_local2 + 4
			local f199_local4 = {}
			local f199_local5 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f199_arg0), "LootStreamProgress.playAnimation")
			local f199_local6 = f199_arg1.menu
			if f199_local5 == true and f199_local6 and f199_local6.purchaseTiers then
				f199_local4 = f199_local6.purchaseTiers
			end
			local f199_local7 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f199_arg0)
			for f199_local8 = f199_local2, f199_local3, 1 do
				local f199_local11 = false
				if f199_local8 <= f199_local7 then
					f199_local11 = true
				end
				local f199_local12 = false
				if f199_local4 then
					for f199_local16, f199_local17 in pairs(f199_local4) do
						if f199_local17 == f199_local8 then
							f199_local12 = true
						end
					end
				end
				table.insert(f199_local0, {
					models = {
						tier = f199_local8,
						unlocked = f199_local11,
						toPurchase = false,
						recentlyUnlocked = f199_local12,
						selected = false,
						bottomRow = true,
					},
					properties = {
						customWidgetOverride = CoD.StreamLevel,
					},
				})
			end
			local f199_local8 = CoD.BlackMarketUtility.GetTierItemsForStream(f199_arg0, f199_local2, f199_local3, true, false)
			for f199_local9 = 1, #f199_local8, 1 do
				local f199_local12, f199_local13 = CoD.BlackMarketUtility.GetItemProductAndProperties(f199_local8[f199_local9])
				f199_local12.toPurchase = false
				f199_local12.selected = false
				f199_local12.bottomRow = false
				if #f199_local8 - 5 <= f199_local9 then
					f199_local12.bottomRow = true
				end
				local f199_local14 = false
				if f199_local4 then
					for f199_local19, f199_local20 in pairs(f199_local4) do
						if f199_local20 == f199_local12.tier then
							f199_local14 = true
						end
					end
				end
				if f199_local12.name ~= 0x0 then
					f199_local12.recentlyUnlocked = f199_local14
				else
					f199_local12.recentlyUnlocked = false
				end
				f199_local12.playAnim = false
				if f199_local12.movieName and f199_local12.movieName ~= "" then
					f199_local12.isLooping = true
					f199_local12.isStreamed = false
				end
				if Engine[@"isdevelopmentbuild"]() then
					if IsBooleanDvarSet(@"hash_6B068C6B9B7D7131") and f199_local9 % 5 == 4 then
						f199_local12.dupe = true
					end
					if IsBooleanDvarSet(@"hash_688D793408D6856B") and f199_local9 % 5 == 0 then
						f199_local12.reroll = true
					end
				end
				table.insert(f199_local0, {
					models = f199_local12,
					properties = f199_local13,
				})
			end
		end
		return f199_local0
	end,
	nil,
	nil,
	function(f200_arg0, f200_arg1, f200_arg2)
		if f200_arg1.updateSubscription then
			f200_arg1:removeSubscription(f200_arg1.updateSubscription)
		end
		local f200_local0 = Engine[@"getglobalmodel"]()
		f200_arg1.updateSubscription = f200_arg1:subscribeToModel(f200_local0:create("AutoEvents.cycled"), function()
			f200_arg1:updateDataSource()
		end, false)
	end
)
DataSources.LootTierLighthouseItems = ListHelper_SetupDataSource(
	"LootTierLighthouseItems",
	function(f202_arg0, f202_arg1)
		local f202_local0 = 4
		local f202_local1 = {}
		local f202_local2 = Engine[@"getmodelforcontroller"](f202_arg0)
		f202_local2 = f202_local2.FocusedTier
		if f202_local2 then
			local f202_local3 = f202_local2:get() or 0
			local f202_local4 = f202_local3 + 24
			local f202_local5 = {}
			local f202_local6 = CoDShared.Loot.GetCurrentSeason()
			if f202_local6 and f202_local6 ~= 0x0 then
				local f202_local7 = CoDShared.Loot.GetSeasonInfo(f202_local6)
				table.insert(f202_local5, f202_local7.id)
			end
			local f202_local7 = CoDShared.Loot.GetCurrentEventContract()
			if f202_local7 and f202_local7 ~= 0x0 then
				local f202_local8 = CoDShared.Loot.GetContractInfo(f202_arg0, f202_local7)
				table.insert(f202_local5, f202_local8.id)
			end
			for f202_local12, f202_local13 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f202_arg0)) do
				if f202_local13.id > 0 then
					table.insert(f202_local5, f202_local13.id)
				end
			end
			for f202_local9 = f202_local3, f202_local4, 1 do
				f202_local13 = {}
				for f202_local18, f202_local19 in ipairs(f202_local5) do
					local f202_local20 = CoD.BlackMarketTableUtility.GetStreamItemsByTier(f202_arg0, f202_local19, f202_local9)
					local f202_local17 = f202_local20[1]
					if f202_local17 then
						f202_local17 = CoD.BlackMarketUtility.LootIdRarities[f202_local20[1].rarity]
					end
					if f202_local17 and f202_local17 ~= Enum[@"lootraritytype"][@"loot_rarity_type_count"] and f202_local17 >= Enum[@"lootraritytype"][@"loot_rarity_type_legendary"] then
						table.insert(f202_local13, f202_local17)
					end
				end
				table.insert(f202_local1, f202_local13)
			end
		end
		local f202_local3 = {}
		for f202_local7, f202_local8 in ipairs(f202_local1) do
			local f202_local9 = {}
			local f202_local10 = f202_local0 - #f202_local8
			for f202_local11 = 1, f202_local10, 1 do
				f202_local9["tierLighthousePip" .. f202_local11 .. ".rarity"] = Enum[@"lootraritytype"][@"loot_rarity_type_count"]
			end
			for f202_local14, f202_local15 in ipairs(f202_local8) do
				f202_local9["tierLighthousePip" .. f202_local14 + f202_local10 .. ".rarity"] = f202_local15
			end
			table.insert(f202_local3, {
				models = f202_local9,
			})
		end
		return f202_local3
	end,
	nil,
	nil,
	function(f203_arg0, f203_arg1, f203_arg2)
		if f203_arg1.updateSubscription then
			f203_arg1:removeSubscription(f203_arg1.updateSubscription)
		end
		local f203_local0 = Engine[@"getglobalmodel"]()
		f203_arg1.updateSubscription = f203_arg1:subscribeToModel(f203_local0:create("AutoEvents.cycled"), function()
			f203_arg1:updateDataSource()
		end, false)
	end
)
DataSources.TierPurchase = ListHelper_SetupDataSource("TierPurchase", function(f205_arg0)
	local f205_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "ItemShop.HighlightedTier")
	local f205_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f205_arg0)
	if f205_local1 + 1 < f205_local0 then
		local f205_local2 = f205_local0 - f205_local1
	end
	local f205_local2 = {}
	for f205_local6, f205_local7 in ipairs(options) do
		table.insert(f205_local2, {
			models = {
				displayText = Engine[@"localize"](f205_local7.displayText),
				tiersToBuy = f205_local7.tiersToBuy,
				price = f205_local7.price,
			},
			properties = {
				action = f205_local7.action,
				actionParam = f205_local7.params,
			},
		})
	end
	return f205_local2
end)
DataSourceHelpers.PerControllerDataSourceSetup("TierPurchase", "TierPurchase", function(f206_arg0, f206_arg1)
	local f206_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "ItemShop.HighlightedTier")
	local f206_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f206_arg1)
	local f206_local2 = 1
	if f206_local0 == nil then
		f206_local0 = f206_local1 + 1
	end
	if f206_local1 + 1 < f206_local0 then
		f206_local2 = f206_local0 - f206_local1
	end
	local f206_local3 = f206_arg0:create("NextTier")
	f206_local3:set(f206_local1 + 1)
	f206_local3 = f206_arg0:create("LastTier")
	f206_local3:set(f206_local0)
	f206_local3 = f206_arg0:create("Price")
	f206_local3:set(CoD.BlackMarketUtility.GetPaidTierCpPrice() * f206_local2)
	f206_local3 = f206_arg0:create("CrateCost")
	f206_local3:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"))
	f206_local3 = false
	if not CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f206_arg1), "LootStreamProgress.allRngUnlocked") and CoD.BlackMarketUtility.GetCurrentSeasonTier(f206_arg1) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
		local f206_local4 = false
		for f206_local8, f206_local9 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f206_arg1)) do
			if f206_local9.id > 0 and not CoD.ContractUtility.IsContractComplete(f206_arg1, f206_local9.id) then
				f206_local4 = true
			end
		end
		if CoD.BlackMarketUtility.IsEventActive() then
			f206_local5 = CoD.BlackMarketUtility.GetEventName()
			if f206_local5 ~= 0x0 and not CoD.BlackMarketUtility.IsItemPurchased(f206_arg1, CoD.BlackMarketTableUtility.GetContractId(f206_local5)) then
				f206_local4 = true
			end
		end
		if not f206_local4 and IsBooleanDvarSet(@"hash_1989C6B82918FBCC") then
			f206_local3 = true
		end
	end
	local f206_local4 = f206_arg0:create("CratePurchaseTip")
	f206_local4:set(f206_local3)
end, false)
DataSources.TierPurchaseList = ListHelper_SetupDataSource("TierPurchaseList", function(f207_arg0, f207_arg1)
	local f207_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "ItemShop.HighlightedTier")
	local f207_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f207_arg0)
	local f207_local2 = {}
	local f207_local3 = f207_local0 - f207_local1
	SetPerControllerTableProperty(f207_arg0, "offScreenPurchase", false)
	if f207_local3 > 1 then
		local f207_local4 = CoD.BlackMarketUtility.GetPaidTierCpPrice() * f207_local3
		table.insert(f207_local2, {
			displayText = @"hash_74CEFD5951498C2B",
			action = CoD.BlackMarketUtility.PurchaseTiers,
			tierRef = @"hash_3E874E7281061241",
			params = {
				controller = f207_arg0,
				tiers = f207_local3,
				refocus = false,
			},
			tiersToBuy = f207_local3,
			price = f207_local4,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f207_local4),
		})
	elseif f207_local3 <= 0 then
		f207_local3 = 1
		SetPerControllerTableProperty(f207_arg0, "offScreenPurchase", true)
		local f207_local4 = CoD.BlackMarketUtility.GetPaidTierCpPrice() * f207_local3
		table.insert(f207_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseTiers,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f207_arg0,
				tiers = 1,
				refocus = true,
			},
			tiersToBuy = f207_local1 + 1,
			price = f207_local4,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f207_local4),
		})
	else
		f207_local3 = 1
		local f207_local4 = CoD.BlackMarketUtility.GetPaidTierCpPrice() * f207_local3
		table.insert(f207_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseTiers,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f207_arg0,
				tiers = 1,
				refocus = false,
			},
			tiersToBuy = f207_local1 + 1,
			price = f207_local4,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f207_local4),
		})
	end
	if f207_arg1.menu then
		local f207_local4 = f207_arg1.menu:getModel()
		f207_local4 = f207_local4:create("entryPoint")
		f207_local4:set("stream")
		f207_local4 = f207_arg1.menu:getModel()
		f207_local4 = f207_local4:create("tiers")
		f207_local4:set(f207_local3)
	end
	local f207_local4 = {}
	for f207_local8, f207_local9 in ipairs(f207_local2) do
		table.insert(f207_local4, {
			models = {
				displayText = Engine[@"localize"](f207_local9.displayText),
				tiersToBuy = f207_local9.tiersToBuy,
				price = f207_local9.price,
				tierRef = f207_local9.tierRef,
				priceRef = f207_local9.priceRef,
			},
			properties = {
				action = f207_local9.action,
				actionParam = f207_local9.params,
			},
		})
	end
	return f207_local4
end)
DataSources.BlackMarketCallingCardMenu = {
	getModel = function(f208_arg0)
		local f208_local0 = "CoD.CallingCards_Stickerbook_Set_BlackMarket"
		if CoD.perController[f208_arg0].isBlackMarketCallingCardNonSet then
			f208_local0 = "CoD.CallingCards_Stickerbook_BlackMarket"
		end
		local f208_local1 = Engine[@"getmodelforcontroller"](f208_arg0)
		f208_local1 = f208_local1:create("BlackMarketCallingCardMenu")
		local f208_local2 = f208_local1:create("frameWidget")
		f208_local2:set(f208_local0)
		return f208_local1
	end,
}
DataSources.ReservesPromoPopup = {
	getModel = function(f209_arg0)
		local f209_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
		local f209_local1 = Engine[@"getmodelforcontroller"](f209_arg0)
		f209_local1 = f209_local1:create("ReservesPromoPopup")
		local f209_local2 = f209_local1:create("title")
		f209_local2:set(f209_local0[@"hash_25174E1CF5A020D4"])
		f209_local2 = f209_local1:create("desc")
		f209_local2:set(f209_local0[@"hash_49B676C473E74B53"])
		f209_local2 = f209_local1:create("image")
		f209_local2:set(f209_local0[@"hash_1CF52BD71B42A517"])
		return f209_local1
	end,
}
CoD.BlackMarketUtility.ShowPurchaseTiersPrompt = function(f210_arg0, f210_arg1, f210_arg2)
	if f210_arg1.framedWidget and f210_arg1.framedWidget[f210_arg2] and f210_arg1.framedWidget[f210_arg2]:getAlpha() == 0 then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.GetStreamCount = function(f211_arg0)
	local f211_local0 = 1
	if CoD.BlackMarketUtility.AreContractsEnabled() then
		f211_local0 = f211_local0 + 1
	end
	if CoD.BlackMarketUtility.IsEventActive() then
		f211_local0 = f211_local0 + 1
	end
	if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_5DC2632EE88877F2"]:exists() then
		f211_local0 = f211_local0 + tonumber(Dvar[@"hash_5DC2632EE88877F2"]:get())
	end
	return f211_local0
end
CoD.BlackMarketUtility.MovePurchaseTiersWidget = function(f212_arg0, f212_arg1, f212_arg2)
	local f212_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f212_arg1)
	if not f212_local0 then
		return
	elseif not f212_arg1[f212_arg2] then
		return
	end
	CoD.BlackMarketUtility.MoveColumnHighlightWidget(f212_arg0, f212_arg1)
	local f212_local1 = CoD.BlackMarketUtility.GetStreamCount(f212_arg0)
	local f212_local2 = f212_local1 + 1
	if f212_local1 == 2 then
		f212_arg1[f212_arg2]:setState(f212_arg0, "TwoStream")
	elseif f212_local1 == 3 then
		f212_arg1[f212_arg2]:setState(f212_arg0, "ThreeStream")
	elseif f212_local1 == 4 then
		f212_arg1[f212_arg2]:setState(f212_arg0, "FourStream")
	else
		f212_arg1[f212_arg2]:setState(f212_arg0, "OneStream")
	end
	local f212_local3 = false
	local f212_local4 = 5
	if f212_local0 and f212_local0.activeWidget then
		f212_local4 = f212_local0.activeWidget.gridInfoTable.zeroBasedIndex % 5 + 1
	end
	local f212_local5 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f212_arg0)
	for f212_local6 = 1, 5, 1 do
		local f212_local9 = f212_local0:getItemAtPosition(1, f212_local6, false)
		if f212_local9 then
			local f212_local10 = f212_local9:getModel()
			if f212_local10 then
				f212_arg1[f212_arg2]:setAlpha(1)
				local f212_local11 = not CoD.SafeGetModelValue(f212_local10, "unlocked")
				if not f212_local3 then
					if not (not f212_local11 or f212_local4 > f212_local6) or f212_local6 == 5 then
						if not f212_local11 and f212_local6 == 5 then
							f212_arg1[f212_arg2]:setAlpha(0)
						end
						if f212_local4 < f212_local6 and f212_local11 and CoD.BlackMarketUtility.AreCoDPointsEnabled() and CoD.perController[f212_arg0].allowTierPurchase then
							local f212_local12 = f212_local10:create("toPurchase")
							f212_local12:set(true)
						else
							local f212_local12 = f212_local10:create("toPurchase")
							f212_local12:set(false)
						end
						for f212_local12 = 1, f212_local2, 1 do
							local f212_local15 = f212_local0:getItemAtPosition(f212_local12, f212_local6, false)
							if f212_local15 then
								local f212_local16 = f212_local15:getModel()
								if f212_local16 then
									local f212_local17 = f212_local16:create("toPurchase")
									f212_local17:set(false)
								end
							end
						end
						local f212_local12, f212_local13, f212_local14, f212_local18 = f212_local0:getGlobalLeftRightTopBottom()
						local f212_local15 = f212_arg1[f212_arg2]:getWidth()
						if f212_local15 > 0 then
							local f212_local16 = f212_arg1[f212_arg2]:getHeight()
							local f212_local17, f212_local19, f212_local20, f212_local21 = f212_arg1[f212_arg2]:getLocalLeftRight()
							local f212_local22, f212_local23, f212_local24, f212_local25 = f212_arg1[f212_arg2]:getLocalTopBottom()
							local f212_local26, f212_local27, f212_local28, f212_local29 = f212_local9:getGlobalLeftRightTopBottom()
							local f212_local30 = f212_local26 - (f212_local15 - f212_local9:getWidth()) / 2
							f212_arg1[f212_arg2]:setLeftRight(f212_local17, f212_local19, f212_local30, f212_local30 + f212_local15)
							f212_arg1[f212_arg2]:setTopBottom(f212_local22, f212_local23, f212_local18, f212_local18 + f212_local16)
						end
						local f212_local16 = CoD.SafeGetModelValue(f212_local10, "tier")
						if f212_arg1[f212_arg2].Internal and f212_arg1[f212_arg2].Internal.PurchaseText and f212_arg1[f212_arg2].Internal.TierText then
							if f212_local5 + 1 < f212_local16 then
								f212_arg1[f212_arg2].Internal.PurchaseText:setText(LocalizeToUpperString(@"menu/purchase_tiers"))
								f212_arg1[f212_arg2].Internal.TierText:setText(tostring(f212_local5 + 1) .. "-" .. tostring(f212_local16))
							else
								f212_arg1[f212_arg2].Internal.PurchaseText:setText(LocalizeToUpperString(@"menu/purchase_tier"))
								f212_arg1[f212_arg2].Internal.TierText:setText(tostring(f212_local5 + 1))
							end
						end
						f212_local3 = true
					end
					for f212_local12 = 1, f212_local2, 1 do
						local f212_local15 = f212_local0:getItemAtPosition(f212_local12, f212_local6, false)
						if f212_local15 then
							local f212_local16 = f212_local15:getModel()
							if f212_local16 and CoD.BlackMarketUtility.AreCoDPointsEnabled() and CoD.perController[f212_arg0].allowTierPurchase then
								local f212_local17 = f212_local16:create("toPurchase")
								f212_local17:set(true)
							end
							if not CoD.perController[f212_arg0].allowTierPurchase then
								local f212_local17 = f212_local16:create("toPurchase")
								f212_local17:set(false)
							end
						end
					end
				end
				for f212_local12 = 1, f212_local2, 1 do
					local f212_local15 = f212_local0:getItemAtPosition(f212_local12, f212_local6, false)
					if f212_local15 then
						local f212_local16 = f212_local15:getModel()
						if f212_local16 then
							local f212_local17 = f212_local16:create("toPurchase")
							f212_local17:set(false)
						end
					end
				end
			end
		end
	end
	if f212_arg1:getMenu() then
		local f212_local6 = f212_arg1:getMenu()
		UpdateButtonPromptState(f212_local6, f212_arg1, f212_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		UpdateButtonPromptState(f212_local6, f212_arg1, f212_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
	end
	if not CoD.BlackMarketUtility.AreCoDPointsEnabled() then
		f212_arg1[f212_arg2]:setAlpha(0)
	end
	if not CoD.perController[f212_arg0].allowTierPurchase then
		f212_arg1[f212_arg2]:setAlpha(0)
	end
end
CoD.BlackMarketUtility.PlaceCurrentTiersWidget = function(f213_arg0, f213_arg1, f213_arg2)
	local f213_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f213_arg1)
	if not f213_local0 then
		return
	elseif not f213_arg1[f213_arg2] then
		return
	end
	local f213_local1 = CoD.BlackMarketUtility.GetStreamCount(f213_arg0)
	if f213_local1 == 2 then
		f213_arg1[f213_arg2]:setState(f213_arg0, "TwoStream")
	elseif f213_local1 == 3 then
		f213_arg1[f213_arg2]:setState(f213_arg0, "ThreeStream")
	elseif f213_local1 == 4 then
		f213_arg1[f213_arg2]:setState(f213_arg0, "FourStream")
	else
		f213_arg1[f213_arg2]:setState(f213_arg0, "OneStream")
	end
	local f213_local2 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f213_arg0)
	for f213_local3 = 1, 5, 1 do
		local f213_local6 = f213_local0:getItemAtPosition(1, f213_local3, false)
		if f213_local6 then
			local f213_local7 = f213_local6:getModel()
			if f213_local7 and CoD.SafeGetModelValue(f213_local7, "tier") == f213_local2 then
				f213_arg1[f213_arg2]:setAlpha(1)
				local f213_local8, f213_local9, f213_local10, f213_local11 = f213_local0:getGlobalLeftRightTopBottom()
				local f213_local12 = f213_arg1[f213_arg2]:getWidth()
				if f213_local12 > 0 then
					local f213_local13 = f213_arg1[f213_arg2]:getHeight()
					local f213_local14, f213_local15, f213_local16, f213_local17 = f213_arg1[f213_arg2]:getLocalLeftRight()
					local f213_local18, f213_local19, f213_local20, f213_local21 = f213_arg1[f213_arg2]:getLocalTopBottom()
					local f213_local22, f213_local23, f213_local24, f213_local25 = f213_local6:getGlobalLeftRightTopBottom()
					local f213_local26 = f213_local22 - (f213_local12 - f213_local6:getWidth()) / 2
					f213_arg1[f213_arg2]:setLeftRight(f213_local14, f213_local15, f213_local26, f213_local26 + f213_local12)
					f213_arg1[f213_arg2]:setTopBottom(f213_local18, f213_local19, f213_local11, f213_local11 + f213_local13)
				end
				return
			end
		end
	end
	f213_arg1[f213_arg2]:setAlpha(0)
end
CoD.BlackMarketUtility.RegisterCurrentTiersWidget = function(f214_arg0, f214_arg1, f214_arg2)
	if not f214_arg1._currentTiersWidgets then
		f214_arg1._currentTiersWidgets = {}
		f214_arg1:appendEventHandler("update_safe_area", function(f215_arg0, f215_arg1)
			for f215_local3, f215_local4 in ipairs(f214_arg1._currentTiersWidgets) do
				CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f214_arg0, f214_arg1, f215_local4)
			end
		end)
	end
	table.insert(f214_arg1._currentTiersWidgets, f214_arg2)
end
CoD.BlackMarketUtility.RegisterPurchaseTiersWidget = function(f216_arg0, f216_arg1, f216_arg2)
	if not f216_arg1._purchaseTiersWidgets then
		f216_arg1._purchaseTiersWidgets = {}
		f216_arg1:appendEventHandler("update_safe_area", function(f217_arg0, f217_arg1)
			for f217_local3, f217_local4 in ipairs(f216_arg1._purchaseTiersWidgets) do
				CoD.BlackMarketUtility.MovePurchaseTiersWidget(f216_arg0, f216_arg1, f217_local4)
			end
		end)
	end
	table.insert(f216_arg1._purchaseTiersWidgets, f216_arg2)
end
CoD.BlackMarketUtility.InitTiersWidgetNextFrame = function(f218_arg0, f218_arg1, f218_arg2)
	if CoD.isPC then
		f218_arg2._timer = LUI.UITimer.newElementTimer(0, true, function()
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f218_arg0, f218_arg1, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f218_arg0, f218_arg1, "CurrentTier")
		end)
		f218_arg2:addElement(f218_arg2._timer)
	end
end
CoD.BlackMarketUtility.MoveColumnHighlightWidget = function(f220_arg0, f220_arg1)
	local f220_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f220_arg1)
	if not f220_local0 then
		return
	elseif not f220_arg1 then
		return
	end
	local f220_local1 = CoD.BlackMarketUtility.GetActiveContracts(f220_arg0)
	local f220_local2 = CoD.BlackMarketUtility.GetStreamCount(f220_arg0) + 1
	local f220_local3 = 5
	if f220_local0.activeWidget then
		f220_local3 = f220_local0.activeWidget.gridInfoTable.zeroBasedIndex % 5 + 1
	end
	for f220_local4 = 1, 5, 1 do
		for f220_local7 = 1, f220_local2, 1 do
			local f220_local10 = f220_local0:getItemAtPosition(f220_local7, f220_local4, false)
			if f220_local10 then
				local f220_local11 = f220_local10:getModel()
				if f220_local11 then
					if f220_local4 == f220_local3 then
						local f220_local12 = f220_local11:create("selected")
						f220_local12:set(true)
					end
					local f220_local12 = f220_local11:create("selected")
					if CoD.SafeGetModelValue(f220_local11, "selected") == true then
						local f220_local13 = f220_local11:create("recentlyUnlocked")
						f220_local13:set(false)
						f220_local13 = CoD.SafeGetModelValue(f220_local11, "tier")
						local f220_local14 = f220_arg1:getMenu()
						if f220_local14 and f220_local14.purchaseTiers then
							local f220_local15 = 0
							for f220_local19, f220_local20 in pairs(f220_local14.purchaseTiers) do
								if f220_local20 == f220_local13 then
									f220_local15 = f220_local19
								end
							end
							if f220_local15 > 0 then
								table.remove(f220_local14.purchaseTiers, f220_local15)
							end
						end
					end
					f220_local12:set(false)
				end
			end
		end
	end
end
CoD.BlackMarketUtility.CacheContrabandRevealTier = function(f221_arg0, f221_arg1)
	if CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f221_arg1), "LootStreamProgress.playAnimation") == true then
		f221_arg0._currentTier = CoD.SafeGetModelValue(f221_arg0:getModel(), "tier")
	end
end
CoD.BlackMarketUtility.GoBackAndOpenBribeMenu = function(f222_arg0, f222_arg1)
	OpenOverlay(GoBack(f222_arg1, f222_arg0), "WeaponBribeSelection", f222_arg0)
end
CoD.BlackMarketUtility.TriggerRevealAnimation = function(f223_arg0, f223_arg1)
	if CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f223_arg0), "LootStreamProgress.playAnimation") == true then
		local f223_local0 = Engine[@"getmodelforcontroller"](f223_arg0)
		f223_local0 = f223_local0:create("LootStreamProgress", true)
		if f223_local0 and f223_local0.itemsEarned then
			if f223_local0.itemsEarned:get() == 1 then
				CoD.OverlayUtility.ShowToast("BlackMarketLoot", Engine[@"hash_4F9F1239CFD921FE"](@"hash_4908038B5F16904C", f223_local0.itemsEarned:get()), "", nil)
			else
				CoD.OverlayUtility.ShowToast("BlackMarketLoot", Engine[@"hash_4F9F1239CFD921FE"](@"hash_7D45D6D1C927E427", f223_local0.itemsEarned:get()), "", nil)
			end
		end
		local f223_local1 = CoD.BlackMarketUtility.GetStreamCount(f223_arg0) + 1
		for f223_local2 = 1, 5, 1 do
			for f223_local5 = 1, f223_local1, 1 do
				local f223_local8 = f223_arg1:getItemAtPosition(f223_local5, f223_local2, false)
				if f223_local8 then
					local f223_local9 = f223_local8:getModel()
					if f223_local9 then
						local f223_local10 = CoD.SafeGetModelValue(f223_local9, "recentlyUnlocked")
						local f223_local11 = CoD.SafeGetModelValue(f223_local9, "tier")
						if (f223_local10 or f223_local11 and f223_local11 == CoD.BlackMarketUtility.GetCurrentSeasonTier(f223_arg0)) and CoD.SafeGetModelValue(f223_local9, "name") ~= 0x0 then
							local f223_local12 = f223_local9:create("playAnim")
							f223_local12:set(true)
						end
					end
				end
			end
		end
	end
end
CoD.BlackMarketUtility.TriggerItemShopRevealAnimation = function(f224_arg0, f224_arg1)
	local f224_local0 = Engine[@"getmodelforcontroller"](f224_arg0)
	if CoD.SafeGetModelValue(f224_local0, "LootStreamProgress.playAnimation") == true then
		local f224_local1 = CoD.SafeGetModelValue(f224_local0, "LootStreamProgress.skuPurchased")
		for f224_local2 = 1, 2, 1 do
			for f224_local5 = 1, 2, 1 do
				local f224_local8 = f224_arg1:getItemAtPosition(f224_local5, f224_local2, false)
				if f224_local8 then
					local f224_local9 = f224_local8:getModel()
					if f224_local9 and tostring(CoD.SafeGetModelValue(f224_local9, "skuID")) == f224_local1 then
						DelayedPlayClip(f224_local8, 550, "Animation")
						DelayedPlaySoundAlias(f224_local8, 550, "uin_mtx_item_purchased_stamp")
						local f224_local10 = f224_local0:create("LootStreamProgress.playAnimation")
						f224_local10:set(false)
						f224_local10 = f224_local0:create("LootStreamProgress.skuPurchased")
						f224_local10:set("")
					end
				end
			end
		end
	end
end
CoD.BlackMarketUtility.TriggerSkuVO = function(f225_arg0, f225_arg1, f225_arg2, f225_arg3)
	if not IsPerControllerTablePropertyValue(f225_arg0, "inBlackMarket", true) then
		return
	elseif f225_arg2._isContract then
		CoD.SoundUtility.PlayVO(f225_arg1, "vox_blac_buy_conf_spec_ord")
	else
		local f225_local0 = f225_arg3 and CoD.SafeGetModelValue(f225_arg3:getModel(), "rarity")
		if f225_local0 == Enum[@"lootraritytype"][@"hash_63006FE890A202D9"] or f225_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_epic"] then
			CoD.SoundUtility.PlayVO(f225_arg1, "vox_blac_buy_conf_prem")
		else
			CoD.SoundUtility.PlayVO(f225_arg1, "vox_blac_buy_conf_reg")
		end
	end
end
CoD.BlackMarketUtility.TriggerGreetingVO = function(f226_arg0, f226_arg1)
	f226_arg0:addElement(LUI.UITimer.newElementTimer(0, true, function()
		if CoD.BlackMarketUtility.IsMyShopItemRevealed(f226_arg1) and math.random(1, 3) == 1 then
			CoD.SoundUtility.PlayVO(f226_arg0, "vox_blac_greet_my_shop", true)
		else
			CoD.SoundUtility.PlayVO(f226_arg0, "vox_blac_greet_store", true)
		end
	end))
end
CoD.BlackMarketUtility.TriggerContrabandReveal = function(f228_arg0, f228_arg1, f228_arg2)
	f228_arg1 = f228_arg1.activeWidget or f228_arg1
	if CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f228_arg0), "LootStreamProgress.playAnimation") == true and CoD.ModelUtility.IsSelfModelValueTrue(f228_arg1, f228_arg0, "unlocked") then
		local f228_local0 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f228_arg0)
		local f228_local1 = f228_arg1:getModel()
		if f228_local0 == f228_local1.tier:get() then
			f228_local0 = f228_arg1:getModel()
			f228_local0 = f228_local0.rarity:get()
			f228_local1 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(f228_arg1, f228_arg0, "character")
			local f228_local2 = f228_arg1
			if f228_arg1.contractModels then
				f228_local2 = f228_arg1.contractModels.outfitIndexes
			end
			local f228_local3 = Engine[@"getdvarstring"]("mtx_seasonal_exploder")
			if f228_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_rare"] then
				if f228_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f228_arg0, f228_local2) then
					Engine[@"playexploder"](f228_arg0, @"hash_7D480C2D5305097B" .. f228_local3)
				else
					Engine[@"playexploder"](f228_arg0, @"hash_3E760A958C41B737" .. f228_local3)
				end
				f228_arg2:playClip("reveal_rare")
			elseif f228_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_legendary"] then
				if f228_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f228_arg0, f228_local2) then
					Engine[@"playexploder"](f228_arg0, @"hash_71CC0807B9AC076A" .. f228_local3)
				else
					Engine[@"playexploder"](f228_arg0, @"hash_66D545ECBC1139A6" .. f228_local3)
				end
				f228_arg2:playClip("reveal_legend")
			elseif f228_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_epic"] then
				if f228_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f228_arg0, f228_local2) then
					Engine[@"playexploder"](f228_arg0, @"hash_723265939DC5CEFA" .. f228_local3)
				else
					Engine[@"playexploder"](f228_arg0, @"hash_47A1EEF9EE557176" .. f228_local3)
				end
				f228_arg2:playClip("reveal_epic")
			elseif f228_local0 == Enum[@"lootraritytype"][@"hash_63006FE890A202D9"] then
				if f228_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f228_arg0, f228_local2) then
					Engine[@"playexploder"](f228_arg0, @"hash_3E0CC6CB594E8FA3" .. f228_local3)
				else
					Engine[@"playexploder"](f228_arg0, @"hash_760368DA99C9910F" .. f228_local3)
				end
				f228_arg2:playClip("reveal_ultra")
			else
				if f228_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f228_arg0, f228_local2) then
					Engine[@"playexploder"](f228_arg0, 0x911A5844D0B572 .. f228_local3)
				else
					Engine[@"playexploder"](f228_arg0, @"hash_74CB8DF6F9281B1E" .. f228_local3)
				end
				f228_arg2:playClip("reveal_common")
			end
		end
	end
end
CoD.BlackMarketUtility.HidePurchaseTiersWidget = function(f229_arg0)
	f229_arg0:setAlpha(0)
end
CoD.BlackMarketUtility.CanPurchaseTiers = function(f230_arg0)
	local f230_local0 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f230_arg0)
	local f230_local1 = CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers()
	local f230_local2 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f230_arg0), "LootStreamProgress.allRngUnlocked")
	local f230_local3 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER)
	if f230_local2 and f230_local1 <= f230_local0 then
		local f230_local4 = false
		for f230_local8, f230_local9 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f230_arg0)) do
			if f230_local9.id > 0 and not CoD.ContractUtility.IsContractComplete(f230_arg0, f230_local9.id) then
				f230_local4 = true
			end
		end
		if CoD.BlackMarketUtility.IsEventActive() then
			f230_local5 = CoD.BlackMarketUtility.GetEventName()
			if f230_local5 ~= 0x0 and not CoD.BlackMarketUtility.IsItemPurchased(f230_arg0, CoD.BlackMarketTableUtility.GetContractId(f230_local5)) then
				f230_local4 = true
			end
		end
		if not f230_local4 then
			return false
		end
	end
	return true
end
CoD.BlackMarketUtility.PurchaseTiers = function(f231_arg0, f231_arg1, f231_arg2, f231_arg3)
	if f231_arg0.currentState ~= "DefaultState" then
		return
	elseif not CanPurchaseItem(f231_arg2, f231_arg1) then
		OpenPopup(f231_arg0, "PurchaseCodPoints", f231_arg2, f231_arg1:getModel())
		return
	elseif not CoD.BlackMarketUtility.CanPurchaseTiers(f231_arg2) then
		f231_arg0:setState(f231_arg2, "ErrorState")
		return
	elseif Engine[0x2E671B86427DC1](f231_arg2) ~= 0 then
		f231_arg0:setState(f231_arg2, "ErrorState")
		return
	end
	f231_arg0:setState(f231_arg2, "WorkingState")
	local f231_local0 = f231_arg0:getMenu()
	if f231_local0 then
		UpdateButtonPromptState(f231_local0, f231_arg0, f231_arg2, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		if f231_local0.CratePurchaseTip then
			f231_local0.CratePurchaseTip:setAlpha(0)
		end
	end
	local f231_local1 = function()
		local f232_local0 = f231_arg0:getMenu()
		if f232_local0 then
			UpdateButtonPromptState(f232_local0, f231_arg0, f231_arg2, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		end
		local f232_local1 = Engine[@"getmodelforcontroller"](f231_arg2)
		f232_local1 = f232_local1:create("LootStreamProgress", true)
		if f232_local1 then
			local f232_local2 = f232_local1:create("itemsEarned", true)
			f232_local2:set(0)
		end
		Engine[@"hash_29EF65378FF2525E"](f231_arg2, CoD.BlackMarketUtility.GetPaidTierSku(), f231_arg3.tiers)
		local f232_local2 = Engine[@"getmodelforcontroller"](f231_arg2)
		f232_local2 = f232_local2:create("LootStreamProgress", true)
		local f232_local3 = nil
		if f232_local2 then
			f232_local3 = f232_local2:create("lastPurchaseSeason", true)
			if f232_local3 then
				local f232_local4 = CoDShared.Loot.GetCurrentSeason()
				if f232_local4 ~= nil then
					f232_local3:set(f232_local4)
				else
					f232_local3:set(0x0)
				end
			end
		end
		if not f231_arg0.purchaseTimer then
			f231_arg0.purchaseTimer = LUI.UITimer.newElementTimer(500, false, function()
				if not Engine[@"isinventorybusy"](f231_arg2) and Engine[@"getpurchasedwskuresult"](f231_arg2) ~= Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_inprogress"] then
					if Engine[@"getpurchasedwskuresult"](f231_arg2) == Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_success"] then
						f231_arg0:setState(f231_arg2, "FinishedState")
						CoD.MetricsUtility.BlackMarketTierPurchasedEvent(f231_arg2, "stream", true, f231_arg3.tiers)
						local f233_local0 = f231_arg0:getMenu()
						f233_local0:setState(f231_arg2, "UnlockingTiers")
						UpdateButtonPromptState(f233_local0, f231_arg0, f231_arg2, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
						local f233_local1 = f233_local0:getModel()
						local f233_local2 = Engine[0x2E671B86427DC1](f231_arg2)
						if f233_local1 then
							local f233_local3 = f233_local1:create("tiersLeft")
							f233_local3:set(f233_local2)
						end
						f231_arg0.redeemTiersTimer = LUI.UITimer.newElementTimer(500, false, function()
							local f234_local0 = f231_arg0:getMenu()
							local f234_local1 = f234_local0:getModel()
							local f234_local2 = Engine[0x2E671B86427DC1](f231_arg2)
							if f234_local2 >= 0 then
								if f234_local1 then
									local f234_local3 = f234_local1:create("tiersLeft")
									f234_local3:set(f234_local2)
								end
								if f234_local2 == 0 and not Engine[@"hash_65B26799D9CD0B8"]() then
									if f231_arg3.refocus then
										SetFocusedTierModelValue(f231_arg2, "0", "")
									end
									f231_arg0.redeemTiersTimer:close()
									f231_arg0.redeemTiersTimer = nil
									local f234_local3 = Engine[@"getmodelforcontroller"](f231_arg2)
									local f234_local4 = f234_local3:create("LootStreamProgress.playAnimation")
									f234_local4:set(true)
									CoD.BlackMarketUtility.UpdateAllRngUnlockedModel(f231_arg2)
									if not CoD.BlackMarketUtility.ShowPostseasonPopup(f234_local0, f231_arg2) and not CoD.BlackMarketUtility.ShowAllRNGPopup(f234_local0, f231_arg2) then
										GoBack(f234_local0, f231_arg2)
									end
								end
							end
						end)
						f231_arg0:addElement(f231_arg0.redeemTiersTimer)
					else
						if f232_local3 then
							f232_local3:set(0x0)
						end
						f231_arg0:setState(f231_arg2, "ErrorState")
					end
					f231_arg0.purchaseTimer:close()
					f231_arg0.purchaseTimer = nil
				end
			end)
			f231_arg0:addElement(f231_arg0.purchaseTimer)
		end
	end
	if CoD.isPC then
		CoD.PCUtility.DisplayPrePurchasePopup(f231_local1, f231_arg0, f231_arg2, {
			tiersElement = f231_arg1,
			tiers = f231_arg3.tiers,
		}, function(f235_arg0)
			f231_arg0:setState(f235_arg0, "DefaultState")
		end)
	else
		f231_local1()
	end
end
CoD.BlackMarketUtility.CanExchangeLootCases = function(f236_arg0, f236_arg1)
	local f236_local0 = tonumber(CoD.SafeGetModelValue(f236_arg1:getModel(), "casePrice"))
	if f236_local0 then
		return f236_local0 <= CoDShared.Loot.GetLootCaseOwnedCount(f236_arg0)
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowShopReserveItem = function(f237_arg0, f237_arg1)
	if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
		local f237_local0 = f237_arg1:getModel()
		if f237_local0 and f237_local0.lootType and f237_local0.lootType:get() == LuaEnum.LOOT_TYPE.CONTRABAND then
			return f237_local0.isInItemShop and f237_local0.isInItemShop:get() == true
		end
	end
	return false
end
CoD.BlackMarketUtility.ShowReservesMeter = function(f238_arg0)
	local f238_local0 = IsBooleanDvarSet(@"hash_150FB25F071D6CBB")
	if f238_local0 then
		f238_local0 = IsJapaneseSku()
		if not f238_local0 then
			f238_local0 = IsBooleanDvarSet(@"hash_495BE2A950EE9E73")
		end
	end
	return f238_local0
end
CoD.BlackMarketUtility.UpdateSunsetPurchasedSlotModel = function(f239_arg0, f239_arg1)
	local f239_local0 = Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"]
	if f239_arg1:getModel() then
		local f239_local1 = f239_arg1:getModel()
		if f239_local1.slot then
			f239_local1 = CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex
			local f239_local2 = f239_arg1:getModel()
			f239_local0 = f239_local1(f239_local2.slot:get())
		end
	end
	local f239_local1 = Engine[@"getmodelforcontroller"](f239_arg0)
	f239_local1 = f239_local1:create("sunsetPurchasedSlot")
	f239_local1:set(f239_local0)
end
CoD.BlackMarketUtility.RevealItemShopSunsetItem = function(f240_arg0, f240_arg1, f240_arg2)
	if not f240_arg0._itemShopRevealCount then
		f240_arg0._itemShopRevealCount = 0
	end
	if not f240_arg0._itemShopRevealElementTable then
		f240_arg0._itemShopRevealElementTable = {}
	end
	if not f240_arg2 then
		f240_arg2 = 0
	end
	local f240_local0 = function(f241_arg0, f241_arg1)
		return f241_arg0.sortIndex < f241_arg1.sortIndex
	end
	local f240_local1 = function()
		if f240_arg0._itemShopRevealDelay then
			f240_arg0._itemShopRevealDelay:close()
			f240_arg0._itemShopRevealDelay = nil
		end
		table.sort(f240_arg0._itemShopRevealElementTable, f240_local0)
		for f242_local3, f242_local4 in ipairs(f240_arg0._itemShopRevealElementTable) do
			local f242_local5 = f242_local4.element
			f240_arg0._itemShopRevealCount = f240_arg0._itemShopRevealCount + 1
			f242_local5.revealTimer = LUI.UITimer.newElementTimer(f242_local4.timeDelay * f240_arg0._itemShopRevealCount, true, function()
				if f242_local5.revealTimer then
					f242_local5.revealTimer:close()
					f242_local5.revealTimer = nil
				end
				f240_arg0._itemShopRevealCount = f240_arg0._itemShopRevealCount - 1
				local f243_local0 = f242_local5:getModel()
				f243_local0.revealed:set(true)
			end)
			f242_local5:addElement(f242_local5.revealTimer)
		end
		f240_arg0._itemShopRevealElementTable = {}
	end
	local f240_local2 = f240_arg1:getModel()
	if not f240_local2 then
		return
	end
	local f240_local3 = 0
	if f240_local2.slot then
		f240_local3 = f240_local2.slot:get()
	end
	if f240_local2.revealed then
		table.insert(f240_arg0._itemShopRevealElementTable, {
			element = f240_arg1,
			sortIndex = f240_local3,
			timeDelay = f240_arg2,
		})
		if not f240_arg0._itemShopRevealDelay then
			f240_arg0._itemShopRevealDelay = LUI.UITimer.newElementTimer(16, true, f240_local1)
			f240_arg0:addElement(f240_arg0._itemShopRevealDelay)
		end
	end
end
CoD.BlackMarketUtility.ItemShopSunsetDelayCloseAndGoBack = function(f244_arg0, f244_arg1, f244_arg2, f244_arg3)
	if not f244_arg3 then
		f244_arg3 = 0
	end
	f244_arg0:addElement(LUI.UITimer.newElementTimer(f244_arg3, true, function()
		CoD.BlackMarketUtility.UpdateSunsetPurchasedSlotModel(f244_arg2, f244_arg1)
		GoBack(GoBack(f244_arg0, f244_arg2), f244_arg2)
	end))
end
CoD.BlackMarketUtility.SetWorkingStateAndExchangeLootCases = function(f246_arg0, f246_arg1, f246_arg2)
	if f246_arg0.currentState ~= "DefaultState" then
		return
	end
	local f246_local0 = CoD.SafeGetModelValue(f246_arg1:getModel(), "caseRule")
	if not f246_local0 then
		return
	end
	f246_arg0:setState(f246_arg2, "WorkingState")
	Engine[@"hash_5B9859F8695DAB71"](f246_arg2, f246_local0)
	if not f246_arg0.exchangeTimer then
		f246_arg0.exchangeTimer = LUI.UITimer.newElementTimer(500, false, function()
			if not Engine[@"isinventorybusy"](f246_arg2) and Engine[@"hash_525090566AF670C"](f246_arg2) ~= Enum[@"hash_198BB5B1F9A186F6"][@"hash_41A1F8568C1B8A5D"] then
				if Engine[@"hash_525090566AF670C"](f246_arg2) == Enum[@"hash_198BB5B1F9A186F6"][@"hash_19180C0E9D90CC4"] then
					f246_arg0:setState(f246_arg2, "FinishedState")
					local f247_local0 = f246_arg0:getModel()
					if f247_local0 and f247_local0.purchased then
						f247_local0.purchased:set(true)
					end
					local f247_local1 = f246_arg0:getMenu()
					CoD.BlackMarketUtility.SendItemShopViewEvent(f246_arg2, f247_local1, "exchange")
					if f247_local1._isContract then
						CoD.ContractUtility.OnContractPurchased(f247_local1, f246_arg2)
					else
						CoD.BlackMarketUtility.ItemShopSunsetDelayCloseAndGoBack(f247_local1, f246_arg0, f246_arg2, 750)
					end
					CoD.BlackMarketUtility.TriggerSkuVO(f246_arg2, f246_arg0, f247_local1, f246_arg1)
					CoD.BlackMarketUtility.UpdateReservesItemCounts(f246_arg2)
				else
					f246_arg0:setState(f246_arg2, "ErrorState")
				end
				f246_arg0.exchangeTimer:close()
				f246_arg0.exchangeTimer = nil
			end
		end)
		f246_arg0:addElement(f246_arg0.exchangeTimer)
	end
end
CoD.BlackMarketUtility.SetElementWorkingStateAndExchangeLootCases = function(f248_arg0, f248_arg1)
	CoD.BlackMarketUtility.SetWorkingStateAndExchangeLootCases(f248_arg0, f248_arg0, f248_arg1, false)
end
CoD.BlackMarketUtility.SetActiveOnFirstSupplyChainElement = function(f249_arg0, f249_arg1, f249_arg2)
	if CoD.isPC then
		LUI.OverrideFunction_CallOriginalFirst(f249_arg1, "updateDataSource", function(element)
			if not f249_arg2._isFirstElementActive then
				LUI.GridLayout.setActiveItem(element, element:getFirstSelectableItem(true), nil)
				f249_arg2._isFirstElementActive = true
			end
		end)
	end
end
CoD.BlackMarketUtility.SetHighlightedPurchaseTierFromItemList = function(f251_arg0, f251_arg1)
	local f251_local0 = Engine[@"getglobalmodel"]()
	f251_local0 = f251_local0:create("ItemShop")
	local f251_local1 = f251_local0:create("HighlightedTier")
	local f251_local2 = CoD.SafeGetModelValue(f251_arg1:getModel(), "tier") or 0
	f251_local1:set(f251_local2)
	local f251_local3 = Engine[@"getmodelforcontroller"](f251_arg0)
	if CoD.SafeGetModelValue(f251_local3, "LootStreamProgress.playAnimation") == true then
		local f251_local4 = f251_local3:create("LootStreamProgress.playAnimation")
		f251_local4:set(false)
	end
	local f251_local4 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f251_arg0)
	local f251_local5 = {}
	for f251_local6 = f251_local4 + 1, f251_local2, 1 do
		table.insert(f251_local5, f251_local6)
	end
	if #f251_local5 == 0 then
		table.insert(f251_local5, f251_local4 + 1)
	end
	if f251_arg1:getMenu() then
		local f251_local6 = f251_arg1:getMenu()
		f251_local6.purchaseTiers = f251_local5
	end
end
CoD.BlackMarketUtility.SetHighlightedPurchaseTier = function(f252_arg0, f252_arg1)
	local f252_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain(f252_arg1)
	if f252_local0 ~= nil then
		CoD.BlackMarketUtility.SetHighlightedPurchaseTierFromItemList(f252_arg0, f252_local0)
	end
end
CoD.BlackMarketUtility.PCOpenPurchaseTiersConfirmation = function(f253_arg0, f253_arg1, f253_arg2, f253_arg3)
	local f253_local0 = f253_arg3:getModel()
	f253_local0 = f253_local0:create("entryPoint")
	f253_local0:set("stream")
	OpenPopup(f253_arg0, f253_arg1, f253_arg2, {
		_model = f253_arg3:getModel(),
	})
end
CoD.BlackMarketUtility.ItemUses3DPreview = function(f254_arg0, f254_arg1)
	local f254_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(f254_arg0, f254_arg1, "character")
	if not f254_local0 then
		f254_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(f254_arg0, f254_arg1, "weaponRef")
	end
	return f254_local0
end
CoD.BlackMarketUtility.LootRarityToString = function(f255_arg0)
	return CoD.BlackMarketUtility.LootRarityStrings[f255_arg0] or 0x0
end
CoD.BlackMarketUtility.LootRarityToColor = function(f256_arg0)
	local f256_local0 = CoD.BlackMarketUtility.LootRarityColors[f256_arg0]
	if f256_local0 then
		return f256_local0.r, f256_local0.g, f256_local0.b
	else
		return 0, 0, 0
	end
end
CoD.BlackMarketUtility.LootRarityToColorBright = function(f257_arg0)
	local f257_local0 = CoD.BlackMarketUtility.LootRarityColorsBright[f257_arg0]
	if f257_local0 then
		return f257_local0.r, f257_local0.g, f257_local0.b
	else
		return 0, 0, 0
	end
end
CoD.BlackMarketUtility.LootRarityToColorDark = function(f258_arg0)
	local f258_local0 = CoD.BlackMarketUtility.LootRarityColorsDark[f258_arg0]
	if f258_local0 then
		return f258_local0.r, f258_local0.g, f258_local0.b
	else
		return 0, 0, 0
	end
end
CoD.BlackMarketUtility.GetLootCategoryString = function(f259_arg0, f259_arg1)
	local f259_local0 = f259_arg0
	local f259_local1 = f259_arg0.rarity
	if f259_local1 then
		f259_local1 = f259_local0 and f259_arg0.rarity:get()
	end
	local f259_local2 = f259_arg0
	local f259_local3 = f259_arg0.skipDefaultTitle
	if f259_local3 then
		f259_local3 = f259_local2 and f259_arg0.skipDefaultTitle:get()
	end
	if not f259_local3 and f259_local1 == Enum[@"lootraritytype"][@"loot_rarity_type_count"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_6841EB1B2292EDB8", Engine[@"hash_4F9F1239CFD921FE"](f259_arg1))
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f259_arg1)
	end
end
CoD.BlackMarketUtility.BonusSetText = function(f260_arg0, f260_arg1, f260_arg2)
	if CoD.SafeGetModelValue(f260_arg0, "setName") and nextTier then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3E874E7281061241")
	else
		return ""
	end
end
CoD.BlackMarketUtility.SetPurchaseTiersText = function(f261_arg0, f261_arg1)
	if CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f261_arg0), "LootStreamProgress.allRngUnlocked") then
		return @"hash_674A2FF363803E3B"
	else
		return f261_arg1
	end
end
CoD.BlackMarketUtility.GetSeasonCompleteImage = function(f262_arg0)
	local f262_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f262_local0 then
		local f262_local1 = Engine[@"hash_2E00B2F29271C60B"](f262_local0)
		if f262_local1 and f262_local1[@"hash_322C49BD38F7A781"] then
			return f262_local1[@"hash_322C49BD38F7A781"]
		end
	end
	return @"blacktransparent"
end
CoD.BlackMarketUtility.GetSeasonCompleteTitle = function(f263_arg0)
	local f263_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f263_local0 then
		local f263_local1 = Engine[@"hash_2E00B2F29271C60B"](f263_local0)
		if f263_local1 and f263_local1[@"hash_78CF2B49497D8762"] then
			return f263_local1[@"hash_78CF2B49497D8762"]
		end
	end
	return f263_arg0
end
CoD.BlackMarketUtility.GetSeasonCompleteMessage = function(f264_arg0)
	local f264_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f264_local0 then
		local f264_local1 = Engine[@"hash_2E00B2F29271C60B"](f264_local0)
		if f264_local1 and f264_local1[@"hash_36339D994438CA53"] then
			return f264_local1[@"hash_36339D994438CA53"]
		end
	end
	return 0x0
end
CoD.BlackMarketUtility.GetSeasonCompleteMessageColor = function(f265_arg0)
	local f265_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f265_local0 then
		local f265_local1 = Engine[@"hash_2E00B2F29271C60B"](f265_local0)
		if f265_local1 and f265_local1[@"hash_69014841451A5872"] == @"black" then
			return 0, 0, 0
		end
	end
	return CoD.ColorUtility.ExplodeColor(ColorSet.T8__OFF__WHITE)
end
CoD.BlackMarketUtility.SetupPageStreamHoldActionReadyCheck = function(f266_arg0, f266_arg1, f266_arg2, f266_arg3)
	if f266_arg0.__pageStreamHoldCheckSet then
		return
	end
	local f266_local0 = {
		1000,
		200,
	}
	f266_arg0.__pageStreamHoldActionReady = true
	f266_arg0.__pageStreamHoldCurrentButton = nil
	f266_arg0.__pageStreamHoldTimeElapse = 0
	f266_arg0.__pageStreamHoldDelayCount = 0
	f266_arg0.__pageStreamHoldBackButtonHeld = false
	f266_arg0.__pageStreamHoldForwardButtonHeld = false
	local f266_local1 = function()
		f266_arg0.__pageStreamHoldActionReady = true
		f266_arg0.__pageStreamHoldCurrentButton = nil
		f266_arg0.__pageStreamHoldTimeElapse = 0
		f266_arg0.__pageStreamHoldDelayCount = 0
	end
	if not f266_arg0.preserveLuiButton then
		f266_arg0.preserveLuiButton = {}
	end
	f266_arg0.preserveLuiButton[f266_arg2] = true
	f266_arg0.preserveLuiButton[f266_arg3] = true
	local f266_local2 = Engine[@"getmodelforcontroller"](f266_arg1)
	f266_local2 = f266_local2.ButtonBits
	f266_arg0:subscribeToModel(f266_local2[f266_arg2], function(model)
		local f268_local0 = model and model:get()
		f266_arg0.__pageStreamHoldBackButtonHeld = f268_local0 and CoD.BitUtility.IsBitwiseAndNonZero(f268_local0, Enum[@"luibuttonflags"][@"flag_down"])
		if f266_arg0.__pageStreamHoldBackButtonHeld and not f266_arg0.__pageStreamHoldCurrentButton then
			f266_arg0.__pageStreamHoldCurrentButton = f266_arg2
		elseif not f266_arg0.__pageStreamHoldBackButtonHeld and f266_arg0.__pageStreamHoldCurrentButton == f266_arg2 then
			if f266_arg0.__pageStreamHoldForwardButtonHeld then
				f266_arg0.__pageStreamHoldCurrentButton = f266_arg3
			end
			f266_local1()
		end
	end, false)
	f266_arg0:subscribeToModel(f266_local2[f266_arg3], function(model)
		local f269_local0 = model and model:get()
		f266_arg0.__pageStreamHoldForwardButtonHeld = f269_local0 and CoD.BitUtility.IsBitwiseAndNonZero(f269_local0, Enum[@"luibuttonflags"][@"flag_down"])
		if f266_arg0.__pageStreamHoldForwardButtonHeld and not f266_arg0.__pageStreamHoldCurrentButton then
			f266_arg0.__pageStreamHoldCurrentButton = f266_arg3
		elseif not f266_arg0.__pageStreamHoldForwardButtonHeld and f266_arg0.__pageStreamHoldCurrentButton == f266_arg3 then
			if f266_arg0.__pageStreamHoldBackButtonHeld then
				f266_arg0.__pageStreamHoldCurrentButton = f266_arg2
			end
			f266_local1()
		end
	end, false)
	f266_arg0.__pageStreamHoldTimer = LUI.UITimer.newElementTimer(16, false, function(f270_arg0)
		if f266_arg0.__pageStreamHoldCurrentButton and f266_arg0.__pageStreamHoldDelayCount > 0 then
			if #f266_local0 < f266_arg0.__pageStreamHoldDelayCount then
				f266_arg0.__pageStreamHoldDelayCount = #f266_local0
			end
			if not f266_arg0.__pageStreamHoldActionReady and f266_local0[f266_arg0.__pageStreamHoldDelayCount] <= f266_arg0.__pageStreamHoldTimeElapse then
				f266_arg0.__pageStreamHoldActionReady = true
			else
				f266_arg0.__pageStreamHoldTimeElapse = f266_arg0.__pageStreamHoldTimeElapse + f270_arg0.timeElapsed
			end
		end
	end)
	f266_arg0:addElement(f266_arg0.__pageStreamHoldTimer)
	f266_arg0.__pageStreamHoldCheckSet = true
end
CoD.BlackMarketUtility.PageStreamHoldUpdateAction = function(f271_arg0)
	f271_arg0.__pageStreamHoldActionReady = false
	f271_arg0.__pageStreamHoldTimeElapse = 0
	f271_arg0.__pageStreamHoldDelayCount = f271_arg0.__pageStreamHoldDelayCount + 1
end
CoD.BlackMarketUtility.IsPageStreamHoldActionReady = function(f272_arg0, f272_arg1)
	if f272_arg1 == f272_arg0.__pageStreamHoldCurrentButton then
		return f272_arg0.__pageStreamHoldActionReady == true
	else
		return false
	end
end
CoD.BlackMarketUtility.PlayGesture = function(f273_arg0, f273_arg1, f273_arg2)
	local f273_local0 = false
	local f273_local1 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f273_arg1)
	if f273_local1 == nil then
		f273_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f273_arg1)
		if f273_local1 then
			f273_local0 = true
		else
			f273_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDaily(f273_arg1)
			if f273_local1 == nil then
				f273_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopFeatured(f273_arg1)
				if f273_local1 == nil then
					f273_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f273_arg1)
					if f273_local1 == nil then
						f273_local1 = f273_arg1
					end
				end
			end
		end
	end
	if f273_local1 ~= nil then
		local f273_local2 = f273_local1.gesture_index
		if f273_local2 ~= nil and f273_local2 >= 0 then
			local f273_local3 = f273_arg0.SupplyChainDetails
			local f273_local4 = f273_arg0
			if not f273_local0 then
				f273_local3 = f273_arg1.framedWidget and f273_arg1.framedWidget.SupplyChainDetails
				f273_local4 = f273_arg1.framedWidget
			end
			if f273_local3 and f273_local4 then
				f273_local3:setState(f273_arg2, "Hidden")
				if f273_local4.gestureTimer == nil then
					f273_local4.gestureTimer = LUI.UITimer.newElementTimer(10000, false, function()
						f273_local4.gestureTimer:close()
						f273_local4.gestureTimer = nil
						UpdateSelfState(f273_local3, f273_arg2)
					end)
					f273_local4:addElement(f273_local4.gestureTimer)
				else
					LUI.UITimer.Reset(f273_local4.gestureTimer)
				end
			end
			Engine[@"sendclientscriptnotify"](f273_arg2, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f273_arg2), {
				event_name = "previewGesture",
				gesture_index = f273_local2 - 1,
				replay_if_already_playing = false,
				ignore_if_already_playing = false,
				wait_until_model_steam_ends = false,
			})
		end
	end
end
CoD.BlackMarketUtility.AutoPlayGestureIfApplicable = function(f275_arg0, f275_arg1, f275_arg2)
	local f275_local0 = f275_arg1:getModel()
	local f275_local1 = f275_local0 and f275_local0.gesture_index
	local f275_local2 = f275_local1 and f275_local1:get()
	if f275_local2 and f275_local2 >= 0 then
		f275_local2 = f275_local2 - 1
		if not f275_arg1.autoGestureTimer then
			f275_arg1.autoGestureTimer = LUI.UITimer.newElementTimer(0, true, function()
				f275_arg1.autoGestureTimer:close()
				f275_arg1.autoGestureTimer = nil
				Engine[@"sendclientscriptnotify"](f275_arg2, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f275_arg2), {
					event_name = "previewGesture",
					gesture_index = f275_local2,
					replay_if_already_playing = true,
					ignore_if_already_playing = false,
					wait_until_model_steam_ends = true,
				})
			end)
			f275_arg1:addElement(f275_arg1.autoGestureTimer)
		else
			f275_arg1.autoGestureTimer:reset()
		end
	end
end
CoD.BlackMarketUtility.ToggleCharacterModelCamera = function(f277_arg0, f277_arg1, f277_arg2)
	local f277_local0 = f277_arg0.SupplyChainDetails
	if not f277_local0 then
		f277_local0 = f277_arg1.framedWidget
		if f277_local0 then
			f277_local0 = f277_arg1.framedWidget.SupplyChainDetails
		end
	end
	if f277_local0 then
		local f277_local1 = nil
		if f277_local0.currentState == "Hidden" then
			UpdateSelfState(f277_local0, f277_arg2)
			f277_local1 = "character"
		else
			f277_local0:setState(f277_arg2, "Hidden")
			f277_local1 = "character_full"
		end
		f277_arg0._lastState = f277_local1
		SendClientScriptMenuChangeNotifyWithState(f277_arg2, f277_arg0, true, f277_local1)
	end
end
CoD.BlackMarketUtility.ResetSignatureWeaponState = function(f278_arg0)
	f278_arg0._showingMastercraft = true
end
CoD.BlackMarketUtility.SendWeaponUpdate = function(f279_arg0, f279_arg1, f279_arg2, f279_arg3, f279_arg4)
	if f279_arg3 ~= nil then
		local f279_local0 = 0
		local f279_local1 = 0
		local f279_local2 = 0
		if f279_arg4 then
			f279_local1 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f279_arg4)
			if f279_arg2.itemCategory:get() == @"reactive_camo" or f279_arg2.itemCategory:get() == @"single_reactive_camo" or f279_arg2.itemCategory:get() == @"hash_5A72AF2C19CEFB8C" then
				f279_local2 = tonumber(CoD.CACUtility.AdjustCamoIfSignatureCamo(f279_arg1, tostring(f279_local1), true))
			end
		end
		if f279_arg3.modelIdx then
			f279_local0 = f279_arg3.modelIdx
		end
		if f279_local0 then
			if f279_arg2.itemCategory:get() == @"weapon_camo" or f279_arg2.itemCategory:get() == @"single_camo" or f279_arg2.itemCategory:get() == @"weapon_camo_bundle" or f279_arg2.itemCategory:get() == @"hash_1FBA128D08C2E117" then
				Engine[@"sendclientscriptnotify"](f279_arg1, "QMWeaponUpdate", {
					weapon_ref = f279_arg3.ref,
					model_idx = f279_local0,
					activeCamoIndex = nil,
					camoIndex = f279_local1,
				})
			elseif f279_arg2.itemCategory:get() == @"reactive_camo" or f279_arg2.itemCategory:get() == @"single_reactive_camo" or f279_arg2.itemCategory:get() == @"hash_5A72AF2C19CEFB8C" then
				Engine[@"sendclientscriptnotify"](f279_arg1, "QMWeaponUpdate", {
					weapon_ref = f279_arg3.ref,
					model_idx = f279_local0,
					activeCamoIndex = f279_local2,
					camoIndex = f279_local1,
				})
			elseif f279_arg2.itemCategory:get() == @"mastercraft" or f279_arg2.itemCategory:get() == 0x44036371584190 or f279_arg2.itemCategory:get() == @"mk2" then
				Engine[@"sendclientscriptnotify"](f279_arg1, "QMWeaponUpdate", {
					weapon_ref = f279_arg3.ref,
					model_idx = f279_local0,
					activeCamoIndex = f279_local1,
					camoIndex = nil,
				})
			else
				Engine[@"sendclientscriptnotify"](f279_arg1, "QMWeaponUpdate", {
					weapon_ref = f279_arg3.ref,
					model_idx = f279_local0,
					activeCamoIndex = nil,
					camoIndex = 0,
				})
			end
		end
	end
end
CoD.BlackMarketUtility.SendSignatureWeaponUpdate = function(f280_arg0, f280_arg1, f280_arg2, f280_arg3)
	if f280_arg3 ~= nil then
		local f280_local0, f280_local1 = nil
		if not f280_arg0._showingMastercraft then
			f280_local0 = f280_arg3.signatureIndex
			if not f280_arg0._skipSignatureWeaponStringOverride then
				f280_arg2.category:set(@"hash_1D4314C41E9C9CFC")
				if f280_arg2.isContract == nil or f280_arg2.isContract:get() == false then
					f280_arg2.name:set(f280_arg3.displayNameRef)
				end
			end
		else
			f280_local0 = f280_arg3.mastercraftIndex
			if not f280_arg0._skipSignatureWeaponStringOverride then
				f280_arg2.category:set(0x81782ED786B4A3)
				if f280_arg2.isContract == nil or f280_arg2.isContract:get() == false then
					f280_arg2.name:set(f280_arg3.mastercraftNameRef)
				end
			end
			local f280_local2 = Engine[@"tablelookup"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], Enum[@"attachmenttablecolumn_e"][@"hash_2BE9816FAD8AD2D2"], "theme", Enum[@"attachmenttablecolumn_e"][@"hash_726CA7CCFF2886B5"], f280_arg3.mastercraftIndex, Enum[@"attachmenttablecolumn_e"][@"hash_9A2FFE632B9ED93"], f280_arg3.ref)
			if f280_local2 then
				f280_local1 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f280_local2)
			end
		end
		if f280_local0 then
			Engine[@"sendclientscriptnotify"](f280_arg1, "QMWeaponUpdate", {
				weapon_ref = f280_arg3.ref,
				model_idx = f280_local0,
				activeCamoIndex = f280_local1,
				camoIndex = nil,
			})
		end
	end
end
CoD.BlackMarketUtility.ToggleSignatureWeapon = function(f281_arg0, f281_arg1, f281_arg2)
	local f281_local0 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f281_arg2)
	if f281_local0 == nil then
		f281_local0 = CoD.BlackMarketUtility.GetContractFrameDetailInfo(f281_arg2)
		if f281_local0 == nil then
			f281_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f281_arg2)
			if f281_local0 == nil then
				f281_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromWeaponBribeSelection(f281_arg2)
				if f281_local0 == nil then
					f281_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f281_arg2)
				end
			end
		end
	end
	if f281_local0 ~= nil then
		f281_arg0._showingMastercraft = not f281_arg0._showingMastercraft
		local f281_local1 = f281_local0
		local f281_local2 = f281_local0:getModel()
		if f281_local0.contractModels then
			f281_local1 = f281_local0.contractModels
			local f281_local3 = f281_local0:getModel()
			f281_local2 = f281_local3.contractModels
		end
		CoD.BlackMarketUtility.SendSignatureWeaponUpdate(f281_arg0, f281_arg1, f281_local2, f281_local1.signatureWeaponInfo)
	end
end
CoD.BlackMarketUtility.QuarterMasterFrameChangeActions = function(f282_arg0, f282_arg1, f282_arg2)
	local f282_local0 = function()
		CoD.PlayerRoleUtility.StopGesturePreview(f282_arg1, f282_arg2)
		UpdateButtonPromptState(f282_arg0, f282_arg1, f282_arg2, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
	end
	if not f282_arg1.__hasEndGesturePreviewCallback then
		f282_arg1.__hasEndGesturePreviewCallback = true
		LUI.OverrideFunction_CallOriginalFirst(f282_arg1, "createFrameWidget", f282_local0)
		LUI.OverrideFunction_CallOriginalFirst(f282_arg1, "changeFrameWidget", f282_local0)
	end
end
CoD.BlackMarketUtility.GetSupplyChainActiveWidget = function(f284_arg0)
	local f284_local0 = "SupplyChainDetails"
	if f284_arg0.framedWidget and f284_arg0.framedWidget[f284_local0] then
		local f284_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain(f284_arg0)
		if f284_local1 and f284_local1:getModel() == f284_arg0.framedWidget[f284_local0]:getModel() then
			return f284_local1
		end
		local f284_local2 = CoD.BlackMarketUtility.GetActiveWidgetFromStreams(f284_arg0)
		if f284_local2 then
			local f284_local3 = f284_local2:getModel()
			if f284_local3.contractModels == f284_arg0.framedWidget[f284_local0]:getModel() then
				return f284_local2
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetActiveWidgetFromStreams = function(f285_arg0)
	local f285_local0 = "StreamList"
	if f285_arg0.framedWidget and f285_arg0.framedWidget[f285_local0] and f285_arg0.framedWidget[f285_local0].activeWidget then
		return f285_arg0.framedWidget[f285_local0].activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetSupplyChainItemList = function(f286_arg0)
	local f286_local0 = "ItemList"
	if f286_arg0[f286_local0] then
		return f286_arg0[f286_local0]
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain = function(f287_arg0)
	if not f287_arg0 or not f287_arg0.framedWidget then
		return nil
	else
		local f287_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f287_arg0.framedWidget)
		if f287_local0 and f287_local0.activeWidget then
			return f287_local0.activeWidget
		else
			return nil
		end
	end
end
CoD.BlackMarketUtility.GetContractFrameDetailInfo = function(f288_arg0)
	if f288_arg0.framedWidget and f288_arg0.framedWidget.PurchasableContractList then
		local f288_local0 = f288_arg0.framedWidget.PurchasableContractList
		if f288_local0.ContractInfoPanel then
			return f288_local0.ContractInfoPanel
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails = function(f289_arg0)
	if f289_arg0.ContractInfoPanel and f289_arg0.ContractInfoPanel.currentState ~= "Hidden" then
		return f289_arg0.ContractInfoPanel
	elseif CoD.isPC and f289_arg0.RewardGridPC then
		return f289_arg0.RewardGridPC.activeWidget
	elseif f289_arg0.RewardList then
		return f289_arg0.RewardList.activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails = function(f290_arg0)
	if f290_arg0.SupplyChainDetails and f290_arg0.SupplyChainDetails.currentState ~= "Hidden" then
		return f290_arg0
	elseif CoD.isPC and f290_arg0.RewardGridPC then
		return f290_arg0.RewardGridPC.activeWidget
	elseif f290_arg0.RewardList then
		return f290_arg0.RewardList.activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromWeaponBribeSelection = function(f291_arg0)
	if f291_arg0.WeaponBribes then
		return f291_arg0.WeaponBribes.activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDaily = function(f292_arg0)
	local f292_local0 = "DailyItems"
	if f292_arg0.framedWidget and f292_arg0.framedWidget[f292_local0] and f292_arg0.framedWidget[f292_local0].activeWidget then
		return f292_arg0.framedWidget[f292_local0].activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromItemShopFeatured = function(f293_arg0)
	local f293_local0 = "FeaturedItems"
	if f293_arg0.framedWidget and f293_arg0.framedWidget[f293_local0] and f293_arg0.framedWidget[f293_local0].activeWidget then
		return f293_arg0.framedWidget[f293_local0].activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.OpenPurchaseTiersConfirmation = function(f294_arg0, f294_arg1, f294_arg2)
	local f294_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain(f294_arg2)
	if f294_local0 ~= nil then
		local f294_local1 = f294_local0:getModel()
		f294_local1 = f294_local1:create("entryPoint")
		f294_local1:set("button")
		OpenPopup(f294_arg2.framedWidget, "PurchaseTiersConfirmation", f294_arg0, {
			_model = f294_local0:getModel(),
		})
	end
end
CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget = function(f295_arg0)
	local f295_local0 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f295_arg0)
	if f295_local0 == nil then
		f295_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f295_arg0)
		if f295_local0 == nil then
			f295_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDaily(f295_arg0)
			if f295_local0 == nil then
				f295_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopFeatured(f295_arg0)
				if f295_local0 == nil then
					f295_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f295_arg0)
					if f295_local0 == nil then
						f295_local0 = f295_arg0
					end
				end
			end
		end
	end
	return f295_local0
end
CoD.BlackMarketUtility.CanPlayGesture = function(f296_arg0)
	local f296_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f296_arg0)
	if f296_local0 ~= nil then
		local f296_local1 = f296_local0.gesture_index
		if f296_local1 ~= nil and f296_local1 >= 0 then
			return true
		end
	end
	return false
end
CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil = function(f297_arg0, f297_arg1, f297_arg2)
	local f297_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f297_arg0)
	if f297_local0 then
		return CoD.ModelUtility.IsSelfModelValueNil(f297_local0, f297_arg1, f297_arg2)
	else
		return false
	end
end
CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo = function(f298_arg0, f298_arg1, f298_arg2, f298_arg3)
	local f298_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f298_arg0)
	if f298_local0 then
		return CoD.ModelUtility.IsSelfModelValueEqualTo(f298_local0, f298_arg1, f298_arg2, f298_arg3)
	else
		return false
	end
end
CoD.BlackMarketUtility.CanToggleSignatureWeapon = function(f299_arg0)
	local f299_local0 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f299_arg0)
	if f299_local0 == nil then
		f299_local0 = CoD.BlackMarketUtility.GetContractFrameDetailInfo(f299_arg0)
		if f299_local0 == nil then
			f299_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f299_arg0)
			if f299_local0 == nil then
				f299_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromWeaponBribeSelection(f299_arg0)
				if f299_local0 == nil then
					f299_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f299_arg0)
				end
			end
		end
	end
	if f299_local0 ~= nil then
		local f299_local1 = CoD.SafeGetModelValue(f299_local0:getModel(), "weaponRef")
		return f299_local1 and f299_local1 ~= 0x0
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowSupplyChainDetailsButtonPrompts = function(f300_arg0, f300_arg1)
	if not CoD.ModelUtility.IsSelfModelValueEqualTo(f300_arg0, f300_arg1, "gesture_index", -1) then
		return true
	elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(f300_arg0, f300_arg1, "movieName") then
		return true
	elseif CoD.ModelUtility.IsSelfModelValueTrue(f300_arg0, f300_arg1, "allowTogglePreview") then
		return true
	elseif CoD.ModelUtility.IsSelfModelValueTrue(f300_arg0, f300_arg1, "allowFrozenMoment") then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.IsTierItemInUpsellRow = function(f301_arg0, f301_arg1)
	local f301_local0 = CoD.perController[f301_arg0].upsellContractRowIndex or 0
	if f301_local0 > 0 then
		return CoD.GridAndListUtility.IsElementAtRowIndex(f301_arg1, f301_local0 + 1)
	else
		return false
	end
end
CoD.BlackMarketUtility.EnableLiveCountDownTimer = function(f302_arg0)
	f302_arg0:registerEventHandler("bm_autoevents_tick", function(element, event)
		Engine[@"setdvar"]("live_autoEventPumpTime", 0)
	end)
	f302_arg0:addElement(LUI.UITimer.new(100, "bm_autoevents_tick", false, f302_arg0))
end
CoD.BlackMarketUtility.SetupSupplyChainMovie = function(f304_arg0, f304_arg1, f304_arg2)
	local f304_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f304_arg0)
	if f304_local0 then
		CoD.VideoStreamingUtility.SetupVoDMovie(f304_arg1, f304_local0, f304_arg2)
	end
end
CoD.BlackMarketUtility.SetupReservesMovie = function(f305_arg0)
	local f305_local0 = "core_frontend_rng_reserve"
	local f305_local1 = false
	local f305_local2 = true
	local f305_local3 = Enum[@"hash_6C47FC1BD2E5CCEE"][@"hash_390B07394D69C5F4"]
	local f305_local4 = DataSources.VoDViewer.getModel(f305_arg0)
	f305_local4.stream:set(CoD.VideoStreamingUtility.GetMoviePlayerParams(f305_local3, f305_local0, f305_local1, f305_local2))
end
DataSourceHelpers.GlobalDataSourceSetup("ItemshopRotation", "ItemshopRotation", function(f306_arg0)
	f306_arg0:create("cycled")
	f306_arg0:create("loot_itemshop_slot1_timer")
	f306_arg0:create("loot_itemshop_slot1_timer_active")
	f306_arg0:create("loot_itemshop_slot2_timer")
	f306_arg0:create("loot_itemshop_slot2_timer_active")
	f306_arg0:create("loot_itemshop_slot3_timer")
	f306_arg0:create("loot_itemshop_slot3_timer_active")
	f306_arg0:create("loot_itemshop_slot4_timer")
	f306_arg0:create("loot_itemshop_slot4_timer_active")
	f306_arg0:create("loot_itemshop_slot5_timer")
	f306_arg0:create("loot_itemshop_slot5_timer_active")
	f306_arg0:create("loot_itemshop_slot6_timer")
	f306_arg0:create("loot_itemshop_slot6_timer_active")
end, false)
DataSourceHelpers.GlobalDataSourceSetup("ReserveDealsRotation", "ReserveDealsRotation", function(f307_arg0)
	f307_arg0:create("cycled")
	f307_arg0:create("currentTime")
end, false)
DataSourceHelpers.GlobalDataSourceSetup("BribeStackTimer", "BribeStackTimer", function(f308_arg0)
	f308_arg0:create("cycled")
	f308_arg0:create("currentTime")
end, false)
DataSourceHelpers.GlobalDataSourceSetup("BribeMenuTimer", "BribeMenuTimer", function(f309_arg0)
	f309_arg0:create("cycled")
	local f309_local0 = f309_arg0:create("countDown")
	f309_local0:set(false)
	f309_arg0:create("bribe_menu_timer")
end, false)
CoD.BlackMarketUtility.EnableItemshopTick = function(f310_arg0, f310_arg1)
	f310_arg1:registerEventHandler("bm_itemshop_tick", function(element, event)
		CoD.BlackMarketUtility.TickItemshop(f310_arg0)
	end)
	local f310_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ItemshopRotation")
	if f310_local0 then
		for f310_local1 = 1, CoD.BlackMarketUtility.ItemShopSlots, 1 do
			local f310_local4 = "loot_itemshop_slot" .. f310_local1 .. "_timer"
			local f310_local5 = Engine[@"createmodel"](f310_local0, f310_local4)
			local f310_local6 = Engine[@"createmodel"](f310_local0, f310_local4 .. "_raw")
			local f310_local7 = Engine[@"createmodel"](f310_local0, f310_local4 .. "_red")
		end
	end
	CoD.BlackMarketUtility.TickItemshop(f310_arg0)
	f310_arg1:addElement(LUI.UITimer.new(100, "bm_itemshop_tick", false, f310_arg1))
end
CoD.BlackMarketUtility.EnableReserveDealsTick = function(f312_arg0, f312_arg1)
	f312_arg1:registerEventHandler("bm_reservedeals_tick", function(element, event)
		CoD.BlackMarketUtility.TickReserveDeals(f312_arg0)
	end)
	CoD.BlackMarketUtility.TickReserveDeals(f312_arg0)
	f312_arg1:addElement(LUI.UITimer.new(100, "bm_reservedeals_tick", false, f312_arg1))
end
CoD.BlackMarketUtility.EnableBribeStackTick = function(f314_arg0, f314_arg1)
	f314_arg1:registerEventHandler("bm_bribestack_tick", function(element, event)
		CoD.BlackMarketUtility.TickBribeStack(f314_arg0)
	end)
	CoD.BlackMarketUtility.TickBribeStack(f314_arg0)
	f314_arg1:addElement(LUI.UITimer.new(100, "bm_bribestack_tick", false, f314_arg1))
end
CoD.BlackMarketUtility.EnableBribeMenuTick = function(f316_arg0, f316_arg1)
	f316_arg1:registerEventHandler("bm_bribemenu_tick", function(element, event)
		CoD.BlackMarketUtility.TickBribeMenu(f316_arg0)
	end)
	CoD.BlackMarketUtility.TickBribeMenu(f316_arg0)
	f316_arg1:addElement(LUI.UITimer.new(100, "bm_bribemenu_tick", false, f316_arg1))
end
DataSourceHelpers.GlobalDataSourceSetup("AutoEvents", "AutoEvents", function(f318_arg0)
	f318_arg0:create("cycled")
	f318_arg0:create("autoevent_timer_black_market")
	f318_arg0:create("autoevent_contract1_timer")
	f318_arg0:create("autoevent_contract2_timer")
	f318_arg0:create("loot_event_stream_timer")
	f318_arg0:create("loot_season_stream_timer")
	f318_arg0:create("autoevent_discount1_timer")
	f318_arg0:create("autoevent_discount2_timer")
	f318_arg0:create("autoevent_discount3_timer")
	f318_arg0:create("autoevent_special_contract_timer")
	f318_arg0:create("autoevent_half_off_crate_timer")
	f318_arg0:create("zm_daily_callings_timer")
end, false)
CoD.BlackMarketUtility.ScaleWidgetToGridList = function(f319_arg0, f319_arg1, f319_arg2)
	local f319_local0, f319_local1, f319_local2, f319_local3 = f319_arg0:getLocalLeftRight()
	local f319_local4, f319_local5 = f319_arg1:getLocalSize()
	local f319_local6 = (f319_local3 + f319_local2) / 2
	local f319_local7 = f319_local4 + f319_arg2 * 2
	f319_arg0:setLeftRight(f319_local0, f319_local1, f319_local6 - f319_local7 / 2, f319_local6 + f319_local7 / 2)
end
CoD.BlackMarketUtility.SetupTierSkipSegmentResize = function(f320_arg0, f320_arg1)
	LUI.OverrideFunction_CallOriginalFirst(f320_arg1, "updateLayout", function(element)
		CoD.BlackMarketUtility.ScaleWidgetToGridList(f320_arg0, f320_arg1, 5)
	end)
end
CoD.BlackMarketUtility.CreateTierSkipSegmentDataSource = function(f322_arg0, f322_arg1, f322_arg2, f322_arg3)
	DataSources[f322_arg0] = DataSourceHelpers.ListSetup(f322_arg0, function(f323_arg0, f323_arg1)
		local f323_local0 = {}
		for f323_local1 = 1, f322_arg2, 1 do
			table.insert(f323_local0, {
				models = {
					index = f322_arg3 + f323_local1,
				},
			})
		end
		return f323_local0
	end, true)
	return f322_arg0
end
DataSources.TierSkipRewardProgress = ListHelper_SetupDataSource("TierSkipRewardProgress", function(f324_arg0, f324_arg1)
	local f324_local0 = {}
	local f324_local1 = math.random(3, 5)
	local f324_local2 = 0
	for f324_local3 = 1, f324_local1, 1 do
		local f324_local6 = math.random(2, 5)
		table.insert(f324_local0, {
			models = {
				tierSkipSegmentDatasource = CoD.BlackMarketUtility.CreateTierSkipSegmentDataSource("TierSkipSegment_" .. f324_local3, f324_local3, f324_local6, f324_local2),
			},
			properties = {
				_useLocalSize = true,
			},
		})
		f324_local2 = f324_local2 + f324_local6
	end
	return f324_local0
end, true)
DataSources.TierSkip = {
	getModel = function(f325_arg0)
		return CoD.BlackMarketUtility.GetTierSkipRootModel(f325_arg0)
	end,
}
CoD.BlackMarketUtility.GetTierSkipRootModel = function(f326_arg0)
	local f326_local0 = Engine[@"getmodelforcontroller"](f326_arg0)
	return f326_local0:create("TierSkip")
end
CoD.BlackMarketUtility.GetTierSkipNotifyVisModel = function(f327_arg0)
	local f327_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f327_arg0)
	return f327_local0:create("notifyVisible")
end
CoD.BlackMarketUtility.SetupTierSkipModels = function(f328_arg0, f328_arg1)
	local f328_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f328_arg0)
	local f328_local1 = f328_local0:create("remainingTimeString")
	f328_local1:set("")
	f328_local1 = CoD.BlackMarketUtility.GetTierSkipNotifyVisModel(f328_arg0)
	f328_local1:set(false)
end
CoD.BlackMarketUtility.ShowTierSkipNotification = function(f329_arg0, f329_arg1, f329_arg2)
	if not CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled") or IsLAN() then
		return
	end
	local f329_local0 = f329_arg1:getModel()
	local f329_local1 = f329_local0.mode
	if f329_local1 then
		f329_local1 = f329_local0.mode:get()
	end
	if LuaUtils.GetEModeForLobbyMainMode(f329_local1) ~= Enum[@"emodes"][@"mode_campaign"] then
		if f329_arg2._tierSkipNotifyTimer then
			f329_arg2._tierSkipNotifyTimer:close()
			f329_arg2._tierSkipNotifyTimer = nil
		end
		f329_arg2._tierSkipNotifyTimer = LUI.UITimer.newElementTimer(20, true, function(f330_arg0)
			local f330_local0 = CoD.BlackMarketUtility.GetTierSkipNotifyVisModel(f329_arg0)
			f330_local0:set(true)
		end)
		f329_arg2:addElement(f329_arg2._tierSkipNotifyTimer)
	end
end
CoD.BlackMarketUtility.HideTierSkipNotification = function(f331_arg0, f331_arg1, f331_arg2)
	local f331_local0 = CoD.BlackMarketUtility.GetTierSkipNotifyVisModel(f331_arg0)
	f331_local0:set(false)
end
CoD.BlackMarketUtility.RefetchTierSkipStatus = function(f332_arg0)
	Engine[@"execnow"](f332_arg0, "queueGameEvent tier_skip 0")
	Engine[@"execnow"](f332_arg0, "flushgameevents")
end
CoD.BlackMarketUtility.GetContractTierSkipStatus = function(f333_arg0)
	local f333_local0 = CoD.BlackMarketUtility.GetContractStateTable(f333_arg0)
	if f333_local0 then
		local f333_local1 = f333_local0.dailyExpirationStr
		local f333_local2 = f333_local0.flags
		return f333_local1, CoD.BitUtility.IsBitSet(f333_local2, CoDShared.LootContracts.StateFlags.LOOT_CONTRACT_DAILY_TIER_SKIP_EARNED), CoD.BitUtility.IsBitSet(f333_local2, CoDShared.LootContracts.StateFlags.LOOT_CONTRACT_ZM_TIER_SKIP_EARNED)
	else
		return "0", 0, 0
	end
end
CoD.BlackMarketUtility.IsDailyTierSkipAvailable = function(f334_arg0, f334_arg1)
	if CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled") then
		if CoD.BaseUtility.IsDvarEnabled("lootcontracts_daily_tier_skip") then
			local f334_local0, f334_local1, f334_local2 = CoD.BlackMarketUtility.GetContractTierSkipStatus(f334_arg0)
			if not f334_local1 then
				if f334_arg1._refreshTimer then
					f334_arg1._refreshTimer:close()
					f334_arg1._refreshTimer = nil
				end
				return true
			end
		end
		local f334_local0 = Engine[@"hash_1F3EC54007D2233C"](f334_arg0)
		if f334_local0 and f334_local0.fetched then
			if f334_local0.nextActivationTime then
				if Engine[@"getsecondsremainingserver"](f334_local0.nextActivationTime) < 0 and f334_local0.achieved then
					if not f334_arg1._hasRefetchedStatus then
						Engine[@"printinfo"](Enum[@"consolelabel_e"][@"hash_7F6819CEB0970CFD"], "Timer expired, refetching tier skip status.\n")
						CoD.BlackMarketUtility.RefetchTierSkipStatus(f334_arg0)
						f334_arg1._hasRefetchedStatus = true
					end
				elseif f334_arg1._hasRefetchedStatus then
					f334_arg1._hasRefetchedStatus = false
				end
			end
			if not f334_local0.achieved then
				if f334_arg1._refreshTimer then
					f334_arg1._refreshTimer:close()
					f334_arg1._refreshTimer = nil
				end
				return true
			end
		end
	end
	return false
end
CoD.BlackMarketUtility.IsDailyTierSkipComplete = function(f335_arg0, f335_arg1)
	if CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled") then
		if CoD.BaseUtility.IsDvarEnabled("lootcontracts_daily_tier_skip") then
			local f335_local0, f335_local1, f335_local2 = CoD.BlackMarketUtility.GetContractTierSkipStatus(f335_arg0)
			if f335_local1 then
				f335_arg1._nextActivationTime = f335_local0
				if f335_arg1._refreshTimer then
					f335_arg1._refreshTimer:close()
					f335_arg1._refreshTimer = nil
				end
				f335_arg1._refreshTimer = LUI.UITimer.newElementTimer(500, false, function(f336_arg0)
					local f336_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f335_arg0)
					local f336_local1 = f336_local0.remainingTimeString
					if Engine[@"getsecondsremainingserver"](f335_arg1._nextActivationTime) > 0 then
						f336_local1:set(LuaUtils.SecondsToTimeRemainingString(Engine[@"getsecondsremainingserver"](f335_arg1._nextActivationTime)))
					else
						f336_local1:set("")
						UpdateState(f335_arg1, {
							name = "update_state",
							controller = f335_arg0,
						})
					end
				end)
				f335_arg1:addElement(f335_arg1._refreshTimer)
				return true
			end
		end
		local f335_local0 = Engine[@"hash_1F3EC54007D2233C"](f335_arg0)
		if f335_local0 and f335_local0.fetched and f335_local0.achieved then
			f335_arg1._nextActivationTime = f335_local0.nextActivationTime
			if f335_arg1._refreshTimer then
				f335_arg1._refreshTimer:close()
				f335_arg1._refreshTimer = nil
			end
			f335_arg1._refreshTimer = LUI.UITimer.newElementTimer(500, false, function(f337_arg0)
				local f337_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f335_arg0)
				local f337_local1 = f337_local0.remainingTimeString
				if Engine[@"getsecondsremainingserver"](f335_arg1._nextActivationTime) > 0 then
					f337_local1:set(LuaUtils.SecondsToTimeRemainingString(Engine[@"getsecondsremainingserver"](f335_arg1._nextActivationTime)))
				else
					f337_local1:set("")
					UpdateState(f335_arg1, {
						name = "update_state",
						controller = f335_arg0,
					})
				end
			end)
			f335_arg1:addElement(f335_arg1._refreshTimer)
			return true
		end
	end
	return false
end
CoD.BlackMarketUtility.HasFocusedTierValue = function(f338_arg0, f338_arg1)
	if Engine[@"isdevelopmentbuild"]() and (CoD.BlackMarketUtility.FillBackfill() or CoD.BlackMarketUtility.FillContrabandDropNumber() > 0 or IsBooleanDvarSet(@"hash_DDC9E66934FFDAB")) then
		return true
	end
	local f338_local0 = Engine[@"getmodelforcontroller"](f338_arg0)
	f338_local0 = f338_local0.FocusedTier
	if f338_local0 then
		local f338_local1 = f338_local0:get() or 0
		local f338_local2 = f338_local1 + 4
		local f338_local3 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f338_arg0)
		if CoD.BlackMarketUtility.IsEventActive() then
			local f338_local4 = CoD.BlackMarketUtility.GetEventName()
			if f338_local4 ~= 0x0 and not Engine[@"hash_7D2AC9EFD614FC94"](f338_arg0, f338_local4, 1) then
				Engine[0x165DC7DAA0794C](f338_arg0, f338_local4, 1)
				return false
			end
		end
		if f338_local3 < f338_local1 then
			return true
		end
		for f338_local4 = f338_local1, f338_local2, 1 do
			if f338_local4 <= f338_local3 and not Engine[@"hash_7D2AC9EFD614FC94"](f338_arg0, CoDShared.Loot.GetCurrentSeason(), f338_local4) then
				Engine[0x165DC7DAA0794C](f338_arg0, CoDShared.Loot.GetCurrentSeason(), f338_local1)
				return false
			end
		end
	end
	local f338_local1 = Engine[@"getmodelforcontroller"](f338_arg0)
	f338_local1 = f338_local1:create("LootStreamProgress", true)
	if f338_local1 then
		local f338_local2 = f338_local1:create("pagedRequestStatus", true)
		f338_local2:set("Valid")
	end
	return true
end
CoD.BlackMarketUtility.GetFocusedTierValue = function(f339_arg0, f339_arg1)
	if Engine[@"isdevelopmentbuild"]() and (CoD.BlackMarketUtility.FillBackfill() or CoD.BlackMarketUtility.FillContrabandDropNumber() > 0 or IsBooleanDvarSet(@"hash_DDC9E66934FFDAB")) then
		return
	end
	local f339_local0 = Engine[@"getmodelforcontroller"](f339_arg0)
	f339_local0 = f339_local0.FocusedTier
	if f339_local0 then
		local f339_local1 = f339_local0:get() or 0
		local f339_local2 = f339_local1 + 4
		local f339_local3 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f339_arg0)
		if CoD.BlackMarketUtility.IsEventActive() then
			local f339_local4 = CoD.BlackMarketUtility.GetEventName()
			if f339_local4 ~= 0x0 and not Engine[@"hash_7D2AC9EFD614FC94"](f339_arg0, f339_local4, 1) then
				Engine[0x165DC7DAA0794C](f339_arg0, f339_local4, 1)
				return
			end
		end
		if f339_local3 < f339_local1 then
			return
		end
		for f339_local4 = f339_local1, f339_local2, 1 do
			if f339_local4 <= f339_local3 and not Engine[@"hash_7D2AC9EFD614FC94"](f339_arg0, CoDShared.Loot.GetCurrentSeason(), f339_local4) then
				Engine[0x165DC7DAA0794C](f339_arg0, CoDShared.Loot.GetCurrentSeason(), f339_local1)
				return
			end
		end
	end
end
CoD.BlackMarketUtility.InitializeLootStreamTier = function(f340_arg0, f340_arg1)
	local f340_local0 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f340_arg0)
	local f340_local1 = CoDShared.Loot.GetCurrentSeason()
	if not Engine[@"hash_7D2AC9EFD614FC94"](f340_arg0, f340_local1, f340_local0) then
		Engine[0x165DC7DAA0794C](f340_arg0, f340_local1, f340_local0)
	end
end
CoD.BlackMarketUtility.UpdateSupplyChainFocus = function(f341_arg0, f341_arg1)
	if CoD.perController[f341_arg0].ignoreResetFocusToFirstSelectable then
		CoD.perController[f341_arg0].ignoreResetFocusToFirstSelectable = false
		return
	else
		f341_arg1:getFirstSelectableItem(true)
	end
end
CoD.BlackMarketUtility.GetCurrentBlackMarketSeasonName = function(f342_arg0)
	local f342_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	local f342_local1
	if f342_local0 then
		f342_local1 = f342_local0[@"contracttitle"]
		if not f342_local1 then
		else
			return f342_local1
		end
	end
	f342_local1 = 0x0
end
CoD.BlackMarketUtility.IsCurrentLootSeasonAtLeast = function(f343_arg0)
	return f343_arg0 <= (CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER) or 0)
end
CoD.BlackMarketUtility.AppendCurrentSeasonTier = function(f344_arg0)
	local f344_local0 = f344_arg0
	if 0 < f344_local0 then
		return ConvertToUpperString(Engine[@"hash_4F9F1239CFD921FE"](@"menu/tier", tostring(f344_local0)))
	else
		return LocalizeToUpperString(@"menu/tier_single")
	end
end
CoD.BlackMarketUtility.GetCurrentBlackMarketSeasonIconSmall = function(f345_arg0)
	local f345_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	local f345_local1
	if f345_local0 then
		f345_local1 = f345_local0[@"hash_1B87A822F3633BF1"]
		if not f345_local1 then
		else
			return f345_local1
		end
	end
	f345_local1 = 0x0
end
CoD.BlackMarketUtility.GetCurrentBlackMarketBannerImage = function(f346_arg0)
	local f346_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	local f346_local1
	if f346_local0 then
		f346_local1 = f346_local0[@"bannerimage"]
		if not f346_local1 then
		else
			return f346_local1
		end
	end
	f346_local1 = 0x0
end
CoD.BlackMarketUtility.GetHalloweenBannerText = function(f347_arg0)
	if Engine[@"converttoxhash"](Dvar[@"hash_3A7588CE8BBBC25D"]:get()) == @"loot_contract_halloween" then
		return @"hash_2B81B691A5FAA21D"
	else
		return 0x0
	end
end
CoD.BlackMarketUtility.GetCurrentBlackMarketBannerString = function(f348_arg0)
	if f348_arg0 == 0x0 or f348_arg0 == "" then
		local f348_local0 = CoD.ContractUtility.GetPurchasableContractHashes()
		if f348_local0 and #f348_local0 > 0 then
			return LocalizeToUpperString(@"menu/contracts") .. "\n" .. LocalizeToUpperString(CoD.ContractUtility.GetContractDisplayNameRef(f348_local0[1]))
		else
			return ""
		end
	end
	local f348_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	if not f348_local0 then
		return ""
	end
	local f348_local1 = Engine[@"hash_4F9F1239CFD921FE"](f348_local0[@"bannerstring"] or 0x0)
	if f348_local0[@"hash_121909CA2BFCBE53"] and f348_local0[@"hash_121909CA2BFCBE53"] ~= 0x0 then
		f348_local1 = f348_local1 .. "\n" .. Engine[@"hash_4F9F1239CFD921FE"](f348_local0[@"hash_121909CA2BFCBE53"])
	end
	return f348_local1
end
CoD.BlackMarketUtility.GetSeasonTimerString = function(f349_arg0, f349_arg1)
	if f349_arg1 == "" then
		return ""
	elseif CoDShared.Loot.GetSeasonInfoParam(@"loot_season_8", CoDShared.Loot.SEASON_INFO_NUMBER) <= CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER) then
		return ""
	elseif CoD.BlackMarketUtility.GetCurrentSeasonTier(f349_arg0) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_8ED6F54FD6EE676", f349_arg1)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0CE2452CF87DB1", f349_arg1)
	end
end
CoD.BlackMarketUtility.AdjustColorIfTierBoost = function(f350_arg0, f350_arg1, f350_arg2, f350_arg3)
	if not IsTierBoostActive(f350_arg0) then
		return f350_arg1, f350_arg2, f350_arg3
	else
		return 0.56, 0.32, 0.91
	end
end
CoD.BlackMarketUtility.GetSpecialDealConfirmationTitle = function(f351_arg0)
	local f351_local0 = tonumber(f351_arg0)
	if f351_local0 and f351_local0 > 0 then
		return @"hash_44789CA9E60FD91D"
	else
		return @"hash_68CCB8B7EF76929B"
	end
end
CoD.BlackMarketUtility.ShowPostseasonPopup = function(f352_arg0, f352_arg1, f352_arg2)
	local f352_local0 = Engine[@"storagegetbuffer"](f352_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	if CoD.BlackMarketUtility.GetCurrentSeasonTier(f352_arg1) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() and f352_local0 and f352_local0.loot_seasonCompletedPopup and f352_local0.loot_seasonCompletedPopup[CoD.BlackMarketUtility.GetCurrentSeasonPostSeasonStat()]:get() == 0 then
		OpenOverlay(f352_arg0, "PostSeasonPopup", f352_arg1, f352_arg2)
		f352_local0.loot_seasonCompletedPopup[CoD.BlackMarketUtility.GetCurrentSeasonPostSeasonStat()]:set(1)
		Engine[@"storagewrite"](f352_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowAllRNGPopup = function(f353_arg0, f353_arg1, f353_arg2)
	local f353_local0 = Engine[@"storagegetbuffer"](f353_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	if CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f353_arg1), "LootStreamProgress.allRngUnlocked") == true then
		local f353_local1 = CoDShared.Loot.GetCurrentSeason()
		if f353_local0 and f353_local0.loot_allRNGPopup then
			local f353_local2 = f353_local0.loot_allRNGPopup[CoD.BlackMarketUtility.GetCurrentAllRNGStat()]
			if f353_local2 and f353_local2:get() == 0 then
				OpenOverlay(f353_arg0, "AllRNGPopup", f353_arg1)
				f353_local2:set(1)
				Engine[@"storagewrite"](f353_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
				return true
			end
		end
	end
	return false
end
CoD.BlackMarketUtility.CreatePersistentPagedRequestModel = function(f354_arg0)
	local f354_local0 = Engine[@"getmodelforcontroller"](f354_arg0)
	f354_local0 = f354_local0:create("LootStreamProgress", true)
	if f354_local0 then
		f354_local0:create("pagedRequestStatus", true)
		CoD.BlackMarketUtility.UpdateAllRngUnlockedModel(f354_arg0)
	end
end
CoD.BlackMarketUtility.UpdateAllRngUnlockedModel = function(f355_arg0)
	CoDShared.Loot.UpdateAllRNGUnlockedModel(f355_arg0)
end
CoD.BlackMarketUtility.PlayBlackMarketFrontendMusic = function(f356_arg0, f356_arg1)
	CoD.PlayFrontendMusic("menu_bm")
	LUI.OverrideFunction_CallOriginalSecond(f356_arg0, "close", function(element)
		local f357_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav")
		if f357_local0 then
			CoD.PlayFrontendMusicForLobby(f357_local0)
		end
	end)
end
CoD.BlackMarketUtility.PlayItemShopSelectSound = function(f358_arg0, f358_arg1)
	local f358_local0 = CoD.SafeGetModelValue(f358_arg0:getModel(), "rarity")
	if f358_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_rare"] then
		f358_arg0:playSound("focus_rare", f358_arg1)
	elseif f358_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_legendary"] then
		f358_arg0:playSound("focus_legendary", f358_arg1)
	elseif f358_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_epic"] then
		f358_arg0:playSound("focus_epic", f358_arg1)
	elseif f358_local0 == Enum[@"lootraritytype"][@"hash_63006FE890A202D9"] then
		f358_arg0:playSound("focus_ultra", f358_arg1)
	else
		f358_arg0:playSound("focus_common", f358_arg1)
	end
end
CoD.BlackMarketUtility.CopySignatureWeaponProperty = function(f359_arg0, f359_arg1, f359_arg2)
	if f359_arg1.contractModels and f359_arg1.contractModels.signatureWeaponInfo then
		f359_arg2.signatureWeaponInfo = f359_arg1.contractModels.signatureWeaponInfo
	else
		f359_arg2.signatureWeaponInfo = nil
	end
end
CoD.BlackMarketUtility.SpecialDealTitle = function(f360_arg0, f360_arg1)
	local f360_local0 = Engine[@"getdvarstring"]("ui_specialDealTitle")
	if f360_local0 then
		return Engine[@"localize"](f360_local0)
	else
		return ""
	end
end
CoD.BlackMarketUtility.SpecialDealDesc = function(f361_arg0, f361_arg1)
	local f361_local0 = Engine[@"getdvarstring"]("ui_specialDealDesc")
	if f361_local0 then
		return Engine[@"localize"](f361_local0)
	else
		return ""
	end
end
CoD.BlackMarketUtility.SpecialDealImage = function(f362_arg0)
	local f362_local0 = Engine[@"getdvarstring"]("ui_specialDealImage")
	if f362_local0 then
		return f362_local0
	else
		return "blacktransparent"
	end
end
CoD.BlackMarketUtility.IsMenuOccluded = function(f363_arg0)
	return f363_arg0.occludedBy ~= nil
end
CoD.BlackMarketUtility.SetHighlightedPurchaseTierForSpecialDeal = function(f364_arg0, f364_arg1, f364_arg2)
	local f364_local0 = Engine[@"getglobalmodel"]()
	f364_local0 = f364_local0:create("ItemShop")
	local f364_local1 = Engine[@"getmodelforcontroller"](f364_arg0)
	if CoD.SafeGetModelValue(f364_local1, "LootStreamProgress.playAnimation") == true then
		local f364_local2 = f364_local1:create("LootStreamProgress.playAnimation")
		f364_local2:set(false)
	end
	local f364_local2 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f364_arg0)
	local f364_local3 = f364_arg2:getModel()
	f364_local3 = f364_local2 + f364_local3.tiers:get() or 0
	local f364_local4 = f364_local0:create("HighlightedTier")
	f364_local4:set(f364_local3)
	local f364_local5 = {}
	for f364_local6 = f364_local2 + 1, f364_local3, 1 do
		table.insert(f364_local5, f364_local6)
	end
	if #f364_local5 == 0 then
		table.insert(f364_local5, f364_local2 + 1)
	end
	f364_arg1.purchaseTiers = f364_local5
end
CoD.BlackMarketUtility.SpecialDealAction = function(f365_arg0, f365_arg1, f365_arg2, f365_arg3)
	CoD.BlackMarketUtility.SetHighlightedPurchaseTierForSpecialDeal(f365_arg2, f365_arg3, f365_arg1)
	local f365_local0 = f365_arg1:getModel()
	f365_local0 = f365_local0:create("entryPoint")
	f365_local0:set("button")
	OpenPopup(f365_arg3.Frame.framedWidget, "SpecialDealConfirmation", f365_arg2, {
		_model = f365_arg1:getModel(),
	})
end
DataSources.SpecialDealPurchaseList = ListHelper_SetupDataSource("SpecialDealPurchaseList", function(f366_arg0, f366_arg1)
	local f366_local0 = Engine[@"getglobalmodel"]()
	local f366_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f366_arg0)
	local f366_local2 = {}
	local f366_local3 = 0
	local f366_local4 = "0"
	local f366_local5 = 0
	local f366_local6 = f366_arg1.menu
	if f366_local6 then
		local f366_local7 = f366_local6:getModel()
		if f366_local7 then
			f366_local3 = f366_local7.tiers:get()
			f366_local4 = f366_local7.skuID:get()
			f366_local5 = f366_local7.price:get()
		end
	end
	if f366_local3 > 1 then
		table.insert(f366_local2, {
			displayText = @"hash_74CEFD5951498C2B",
			action = CoD.BlackMarketUtility.PurchaseSpecialDeal,
			tierRef = @"hash_3E874E7281061241",
			params = {
				controller = f366_arg0,
				tiers = f366_local3,
				refocus = false,
				skuID = f366_local4,
			},
			tiersToBuy = f366_local3,
			price = f366_local5,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f366_local5),
		})
	elseif f366_local3 <= 0 then
		f366_local3 = 1
		table.insert(f366_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseSpecialDeal,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f366_arg0,
				tiers = 1,
				refocus = true,
				skuID = f366_local4,
			},
			tiersToBuy = f366_local1 + 1,
			price = f366_local5,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f366_local5),
		})
	else
		f366_local3 = 1
		table.insert(f366_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseSpecialDeal,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f366_arg0,
				tiers = 1,
				refocus = false,
				skuID = CoD.BlackMarketUtility.GetPaidTierSku(),
			},
			tiersToBuy = f366_local1 + 1,
			price = f366_local5,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f366_local5),
		})
	end
	local f366_local7 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f366_arg0)
	InitDataSourceModel(f366_arg0, "TierPurchase")
	local f366_local8 = {}
	for f366_local12, f366_local13 in ipairs(f366_local2) do
		table.insert(f366_local8, {
			models = {
				displayText = Engine[@"localize"](f366_local13.displayText),
				tiersToBuy = f366_local13.tiersToBuy,
				price = f366_local13.price,
				tierRef = f366_local13.tierRef,
				priceRef = f366_local13.priceRef,
			},
			properties = {
				action = f366_local13.action,
				actionParam = f366_local13.params,
			},
		})
	end
	return f366_local8
end)
CoD.BlackMarketUtility.OpenSpecialDealBribeCrate = function(f367_arg0, f367_arg1, f367_arg2, f367_arg3)
	local f367_local0 = function()
		local f368_local0 = GoBack(f367_arg2, f367_arg1)
		if f368_local0.id == "Menu.ItemShopDetails" then
			f368_local0 = GoBack(f368_local0, f367_arg1)
		end
		f368_local0._tab = "reserves"
		local f368_local1 = Engine[@"forcenotifymodelsubscriptions"]
		local f368_local2 = Engine[@"getmodelforcontroller"](f367_arg1)
		f368_local1(f368_local2:create("QuarterMasterTabUpdate"))
		CoD.BlackMarketUtility.TriggerOpenBribeSequence(f367_arg1, f368_local0, f367_arg3)
	end
	if CoD.isPC then
		CoD.PCUtility.DisplayPrePurchasePopup(f367_local0, f367_arg0, f367_arg1, {
			dwSKUElement = f367_arg0,
		}, function(f369_arg0)
			f367_arg0:setState(f369_arg0, "DefaultState")
		end)
	else
		f367_local0()
	end
end
CoD.BlackMarketUtility.TriggerOpenBribeSequence = function(f370_arg0, f370_arg1, f370_arg2)
	if CoD.BlackMarketUtility.OpenBribe(f370_arg0, tonumber(f370_arg2.crateType)) then
		OpenOverlay(f370_arg1, "BlackjackReserveReveal", f370_arg0, {
			_model = nil,
		})
	end
end
CoD.BlackMarketUtility.OpenNonCPBribe = function(f371_arg0, f371_arg1)
	local f371_local0 = GoBack(f371_arg1, f371_arg0)
	if f371_arg1._isOtherBlackMarketTab then
		f371_local0._tab = "reserves"
		local f371_local1 = Engine[@"forcenotifymodelsubscriptions"]
		local f371_local2 = Engine[@"getmodelforcontroller"](f371_arg0)
		f371_local1(f371_local2:create("QuarterMasterTabUpdate"))
	end
	CoDShared.Loot.ClearRNGModels(f371_arg0)
	CoD.BlackMarketUtility.RedeemNonCPLootBribe(f371_arg0, f371_arg1._bribeName)
	local f371_local1 = DataSources.ReservesLootPurchaseCase.getModel(f371_arg0)
	for f371_local5, f371_local6 in ipairs(CoDShared.Loot.Crates) do
		if f371_arg1._bribeName == f371_local6 and f371_local6 ~= @"no_dupe_crate" then
			f371_local1 = DataSources.ReservesLootBundleCrate.getModel(f371_arg0)
		end
	end
	if f371_arg1._isReservesRevealMenu then
		f371_local2 = Engine[@"getmodelforcontroller"](f371_arg0)
		f371_local2 = f371_local2:create("reservesRevealComplete")
		f371_local2:set(false)
		if f371_local0:getModel() ~= f371_local1 then
			f371_local0:setModel(f371_local1, f371_arg0)
		end
	else
		OpenOverlay(f371_local0, "BlackjackReserveReveal", f371_arg0, {
			_model = f371_local1,
		})
	end
end
CoD.BlackMarketUtility.GetBribeAsset = function(f372_arg0, f372_arg1)
	local f372_local0 = 0x0
	local f372_local1 = 0x0
	local f372_local2 = 0x0
	local f372_local3 = 0x0
	local f372_local4 = 0x0
	local f372_local5 = 0x0
	local f372_local6 = 0x0
	local f372_local7 = ""
	local f372_local8 = Engine[@"hash_2E00B2F29271C60B"](f372_arg1)
	if f372_local8 then
		if f372_local8[@"previewimage"] then
			f372_local0 = f372_local8[@"previewimage"]
		end
		if f372_local8[@"popupimage"] then
			f372_local1 = f372_local8[@"popupimage"]
		end
		if f372_local8[@"buttonimage"] then
			f372_local2 = f372_local8[@"buttonimage"]
		end
		if f372_local8[@"stackimage"] then
			f372_local3 = f372_local8[@"stackimage"]
		end
		if f372_local8[@"hash_6E9E2E7DDFE988B5"] then
			f372_local4 = f372_local8[@"hash_6E9E2E7DDFE988B5"]
		end
		if f372_local8[@"nametext"] then
			f372_local6 = f372_local8[@"nametext"]
		end
		if f372_local8[@"desctext"] then
			f372_local7 = Engine[@"hash_4F9F1239CFD921FE"](f372_local8[@"desctext"])
		end
		return {
			primaryImage = f372_local0,
			popupImage = f372_local1,
			buttonImage = f372_local2,
			stackImage = f372_local3,
			stackTallImage = f372_local4,
			name = f372_local6,
			desc = f372_local7,
			category = @"mpui/bm_bribe",
		}
	else
		return nil
	end
end
DataSources.BribeListItem = ListHelper_SetupDataSource("BribeListItem", function(f373_arg0, f373_arg1)
	local f373_local0 = {}
	for f373_local5, f373_local6 in ipairs(CoD.BlackMarketTableUtility.GetAllBribes(f373_arg0)) do
		local f373_local7 = CoD.BlackMarketUtility.GetBribeAsset(f373_arg0, f373_local6)
		if f373_local7 then
			local f373_local4 = CoD.BlackMarketTableUtility.GetBribeInformation(f373_arg0, f373_local6)
			if f373_local4 and f373_local4.canPurchase then
				f373_local7.crateType = f373_local4.lootRule
				f373_local7.canPurchase = f373_local4.canPurchase
				f373_local7.price = f373_local4.price
				table.insert(f373_local0, {
					models = f373_local7,
				})
			end
		end
	end
	return f373_local0
end)
CoD.BlackMarketUtility.PurchaseSpecialDeal = function(f374_arg0, f374_arg1, f374_arg2, f374_arg3)
	if f374_arg0.FullscreenPopupTemplate then
		if f374_arg0.FullscreenPopupTemplate.currentState ~= "DefaultState" then
			return
		end
	elseif f374_arg0.currentState ~= "DefaultState" then
		return
	end
	if not CanPurchaseItem(f374_arg2, f374_arg1) then
		OpenPopup(f374_arg0, "PurchaseCodPoints", f374_arg2, f374_arg1:getModel())
		return
	elseif CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f374_arg2), "LootStreamProgress.allRngUnlocked") then
		local f374_local0 = false
		for f374_local4, f374_local5 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f374_arg2)) do
			if f374_local5.id > 0 and not CoD.ContractUtility.IsContractComplete(f374_arg2, f374_local5.id) then
				f374_local0 = true
			end
		end
		if not f374_local0 and not f374_arg3.triplePlay then
			f374_arg0:setState(f374_arg2, "ErrorState")
			return
		end
	end
	if Engine[0x2E671B86427DC1](f374_arg2) ~= 0 then
		if f374_arg0.FullscreenPopupTemplate then
			f374_arg0.FullscreenPopupTemplate:setState(f374_arg2, "ErrorState")
		else
			f374_arg0:setState(f374_arg2, "ErrorState")
		end
		return
	elseif f374_arg0.FullscreenPopupTemplate then
		f374_arg0.FullscreenPopupTemplate:setState(f374_arg2, "WorkingState")
	else
		f374_arg0:setState(f374_arg2, "WorkingState")
	end
	local f374_local6 = f374_arg0:getMenu()
	if f374_local6 then
		UpdateButtonPromptState(f374_local6, f374_arg0, f374_arg2, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		if f374_local6.CratePurchaseTip then
			f374_local6.CratePurchaseTip:setAlpha(0)
		end
	end
	local f374_local1 = function()
		local f375_local0 = f374_arg0:getMenu()
		if f375_local0 then
			UpdateButtonPromptState(f375_local0, f374_arg0, f374_arg2, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		end
		local f375_local1 = Engine[@"getmodelforcontroller"](f374_arg2)
		f375_local1 = f375_local1:create("LootStreamProgress", true)
		if f375_local1 then
			local f375_local2 = f375_local1:create("itemsEarned", true)
			f375_local2:set(0)
		end
		Engine[@"hash_29EF65378FF2525E"](f374_arg2, f374_arg3.skuID)
		if not f374_arg0.purchaseTimer then
			f374_arg0.purchaseTimer = LUI.UITimer.newElementTimer(500, false, function()
				if not Engine[@"isinventorybusy"](f374_arg2) and Engine[@"getpurchasedwskuresult"](f374_arg2) ~= Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_inprogress"] then
					if Engine[@"getpurchasedwskuresult"](f374_arg2) == Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_success"] then
						if f374_arg0.FullscreenPopupTemplate then
							f374_arg0.FullscreenPopupTemplate:setState(f374_arg2, "FinishedState")
						else
							f374_arg0:setState(f374_arg2, "FinishedState")
						end
						if not f374_arg3.triplePlay then
							CoD.MetricsUtility.BlackMarketTierPurchasedEvent(f374_arg2, "button", true, 1)
						end
						local f376_local0 = f374_arg0:getMenu()
						f376_local0:setState(f374_arg2, "UnlockingTiers")
						UpdateButtonPromptState(f376_local0, f374_arg0, f374_arg2, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
						local f376_local1 = f376_local0:getModel()
						local f376_local2 = Engine[0x2E671B86427DC1](f374_arg2)
						if f376_local1 then
							local f376_local3 = f376_local1:create("tiersLeft")
							f376_local3:set(f376_local2)
						end
						f374_arg0.redeemTiersTimer = LUI.UITimer.newElementTimer(500, false, function()
							local f377_local0 = f374_arg0:getMenu()
							local f377_local1 = f377_local0:getModel()
							local f377_local2 = Engine[0x2E671B86427DC1](f374_arg2)
							if f377_local2 >= 0 then
								if f377_local1 then
									local f377_local3 = f377_local1:create("tiersLeft")
									f377_local3:set(f377_local2)
								end
								if f377_local2 == 0 and not Engine[@"hash_65B26799D9CD0B8"]() then
									if f374_arg3.refocus then
										SetFocusedTierModelValue(f374_arg2, "0", "")
									end
									f374_arg0.redeemTiersTimer:close()
									f374_arg0.redeemTiersTimer = nil
									SetFocusedTierModelValue(f374_arg2, "0", "")
									local f377_local3 = Engine[@"getmodelforcontroller"](f374_arg2)
									local f377_local4 = f377_local3:create("LootStreamProgress.playAnimation")
									f377_local4:set(true)
									CoD.BlackMarketUtility.UpdateAllRngUnlockedModel(f374_arg2)
									if f374_arg3.triplePlay then
										SetPerControllerTableProperty(f374_arg2, "redeemingTierBundleItem", true)
									end
									f377_local4 = f377_local0
									if f374_arg3.goBackMultiple then
										f377_local4 = GoBack(f377_local4, f374_arg2)
									end
									if not CoD.BlackMarketUtility.ShowPostseasonPopup(f377_local4, f374_arg2, f374_arg3) and not CoD.BlackMarketUtility.ShowAllRNGPopup(f377_local4, f374_arg2, f374_arg3) then
										ClearMenuSavedState(f377_local4.occludedMenu)
										f377_local4 = GoBack(f377_local4, f374_arg2)
										if f377_local4 then
											if f377_local4._currentTab ~= "supplychain" then
												f377_local4._tab = "supplychain"
												local f377_local5 = Engine[@"forcenotifymodelsubscriptions"]
												local f377_local6 = Engine[@"getmodelforcontroller"](f374_arg2)
												f377_local5(f377_local6:create("QuarterMasterTabUpdate"))
											end
											f377_local4._purchaseSpecialDealDelayTimer = LUI.UITimer.newElementTimer(0, true, function()
												if f377_local4._purchaseSpecialDealDelayTimer then
													f377_local4._purchaseSpecialDealDelayTimer:close()
													f377_local4._purchaseSpecialDealDelayTimer = nil
												end
												local f378_local0 = f377_local4.Frame
												if f378_local0 then
													local f378_local1 = CoD.BlackMarketUtility.GetSupplyChainItemList(f378_local0.framedWidget)
													local f378_local2 = f378_local1:getFirstSelectableItem(true)
													if f378_local2 then
														f378_local2:centerFreeCursorOnElement(f374_arg2)
														local f378_local3 = f378_local2:getModel()
														if not f378_local3.playAnim:set(true) then
															f378_local3 = f378_local2:getModel()
															f378_local3.playAnim:forceNotifySubscriptions()
														end
													end
													SetElementModelToFocusedElementModel(f374_arg2, f378_local0.framedWidget, f378_local1, "SupplyChainDetails")
												end
												if f374_arg3.triplePlay then
													SetPerControllerTableProperty(f374_arg2, "redeemingTierBundleItem", false)
													if f377_local3.playContrabandReveal then
														f377_local3.playContrabandReveal:set(true)
													end
												end
											end)
											f377_local4:addElement(f377_local4._purchaseSpecialDealDelayTimer)
										end
									end
								end
							end
						end)
						f374_arg0:addElement(f374_arg0.redeemTiersTimer)
					else
						f374_arg0:setState(f374_arg2, "ErrorState")
					end
					f374_arg0.purchaseTimer:close()
					f374_arg0.purchaseTimer = nil
				end
			end)
			f374_arg0:addElement(f374_arg0.purchaseTimer)
		end
	end
	if CoD.isPC then
		local f374_local2 = function(f379_arg0)
			if f374_arg0.FullscreenPopupTemplate then
				f374_arg0.FullscreenPopupTemplate:setState(f379_arg0, "DefaultState")
			else
				f374_arg0:setState(f379_arg0, "DefaultState")
			end
		end
		if f374_local6.id == "Menu.SpecialDealConfirmation" then
			local f374_local7 = f374_local6
		end
		CoD.PCUtility.DisplayPrePurchasePopup(f374_local1, f374_arg0, f374_arg2, {
			dwSKUElement = f374_local7 or f374_arg0,
		}, f374_local2)
	else
		f374_local1()
	end
end
CoD.BlackMarketUtility.UpdateReservesItemCounts = function(f380_arg0)
	if DataSources.ReservesItemCounts then
		DataSources.ReservesItemCounts.getModel(f380_arg0)
	end
end
CoD.BlackMarketUtility.SetQuarterMasterMenuCurrentTab = function(f381_arg0, f381_arg1, f381_arg2)
	local f381_local0 = f381_arg0:getModel(f381_arg1, "category")
	local f381_local1 = f381_local0 and f381_local0:get()
	if f381_local1 then
		f381_arg2._currentTab = f381_local1
	end
end
DataSources.ReserveDealsList = ListHelper_SetupDataSource(
	"ReserveDealsList",
	function(f382_arg0, f382_arg1)
		local f382_local0 = {}
		if not CoD.BlackMarketUtility.AreCoDPointsEnabled() then
			return f382_local0
		end
		local f382_local1 = CoD.BlackMarketUtility.ReserveDeals
		table.sort(f382_local1, function(f383_arg0, f383_arg1)
			return Engine[@"isgreaterthan"](f383_arg0.start, f383_arg1.start)
		end)
		local f382_local2 = {}
		local f382_local3 = {}
		for f382_local13, f382_local14 in ipairs(f382_local1) do
			local f382_local15 = Engine[@"converttoxhash"](f382_local14.name)
			local f382_local16 = CoDShared.LootIndexInfoLookup(f382_local15)
			local f382_local7 = nil
			local f382_local17 = CoD.BlackMarketTableUtility.GetItemShopInformation(f382_arg0, f382_local14.name)
			if f382_local17 and f382_local16 then
				f382_local7 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f382_arg0, f382_local17)
				if f382_local7 then
					if f382_local16.category == @"bribe" then
						for f382_local11, f382_local12 in pairs(CoD.BlackMarketUtility.GetBribeAsset(f382_arg0, f382_local15)) do
							f382_local7[f382_local11] = f382_local12
						end
						f382_local7.discountList = true
					elseif f382_local16.category == @"special_bundle" then
						for f382_local11, f382_local12 in pairs(CoD.BlackMarketUtility.GetSpecialBundleInfo(f382_arg0, f382_local15)) do
							f382_local7[f382_local11] = f382_local12
						end
						f382_local7.discountList = true
					end
					f382_local7.stringName = f382_local14.name
					if f382_local7.purchased ~= true then
						table.insert(f382_local2, f382_local7)
					else
						table.insert(f382_local3, f382_local7)
					end
				end
			end
		end
		for f382_local13, f382_local14 in ipairs(f382_local3) do
			table.insert(f382_local2, f382_local14)
		end
		f382_local4 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ReserveDealsRotation")
		for f382_local5 = 1, #f382_local2, 1 do
			local f382_local15, f382_local16 = CoD.BlackMarketUtility.GetItemProductAndProperties(f382_local2[f382_local5])
			f382_local15.stackPosition = f382_local5
			f382_local15.stackTotal = #f382_local2
			f382_local15.timer = f382_local2[f382_local5].stringName
			table.insert(f382_local0, {
				models = f382_local15,
				properties = f382_local16,
			})
		end
		if #f382_local0 > 0 then
			f382_local5 = Engine[@"getmodelforcontroller"](f382_arg0)
			f382_local5 = f382_local5:create("reservesSpecialOfferAvailable")
			f382_local5:set(true)
		end
		return f382_local0
	end,
	nil,
	nil,
	function(f384_arg0, f384_arg1, f384_arg2)
		if not f384_arg1.__discountListSubscriptions then
			f384_arg1.__discountListSubscriptions = true
			f384_arg1:subscribeToGlobalModel(f384_arg0, "ReserveDealsRotation", "cycled", function()
				f384_arg1:updateDataSource()
			end)
		end
	end
)
CoD.BlackMarketUtility.GetTimerModelValue = function(f386_arg0, f386_arg1)
	local f386_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ReserveDealsRotation")
	if f386_arg0 then
		local f386_local1 = f386_arg0.timer
		local f386_local2 = f386_arg0.timer
		local f386_local3 = f386_local0[f386_arg0.timer:get()]:get()
	end
	return f386_local1 and f386_local3 or ""
end
CoD.BlackMarketUtility.GetBribeStackTimerModelValue = function(f387_arg0, f387_arg1)
	local f387_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "BribeStackTimer")
	if f387_arg0 then
		local f387_local1 = f387_arg0.timer
		local f387_local2 = f387_arg0.timer
		local f387_local3 = f387_local0[f387_arg0.timer:get()]:get()
	end
	return f387_local1 and f387_local3 or ""
end
CoD.BlackMarketUtility.GetBribeMenuTimerModelValue = function(f388_arg0, f388_arg1)
	local f388_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "BribeMenuTimer")
	if f388_arg0 then
		local f388_local1 = f388_arg0.timer
		local f388_local2 = f388_arg0.timer
		local f388_local3 = f388_local0[f388_arg0.timer:get()]:get()
	end
	return f388_local1 and f388_local3 or ""
end
DataSources.DiscountList = ListHelper_SetupDataSource(
	"DiscountList",
	function(f389_arg0, f389_arg1)
		local f389_local0 = {}
		if not CoD.BlackMarketUtility.AreCoDPointsEnabled() then
			return f389_local0
		end
		local f389_local1 = f389_arg1.menu._currentTab == "supplychain"
		if not (f389_arg1.menu._currentTab == "reserves") and IsBooleanDvarSet(@"hash_1989C6B82918FBCC") then
			if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
				local f389_local2 = CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues
				table.insert(f389_local0, {
					models = {
						name = f389_local2.name,
						tiers = 0,
						price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7") / 2,
						popupImage = f389_local2.popupImage,
						skuID = "0",
						percentOff = f389_local2.percentOff,
						bundle = "",
						timerModel = 0,
						reservesButton = true,
						purchaseReservesItem = true,
						isCrateItem = true,
						desc = Engine[@"hash_4F9F1239CFD921FE"](f389_local2.desc),
						categoryString = @"hash_0",
						mainExtraText = "",
						subExtraText = @"hash_0",
						discountIndx = 0,
						openCrate = 0,
						bundleTitleRef = f389_local2.name,
						bundleImage = f389_local2.buttonImage,
						toolTipText = @"hash_0",
					},
				})
			else
				local f389_local2 = CoD.BlackMarketUtility.LootPurchaseCrateModelValues
				table.insert(f389_local0, {
					models = {
						name = f389_local2.name,
						tiers = 0,
						price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"),
						popupImage = f389_local2.popupImage,
						skuID = "0",
						percentOff = f389_local2.percentOff,
						bundle = "",
						timerModel = 0,
						reservesButton = true,
						purchaseReservesItem = true,
						isCrateItem = true,
						desc = Engine[@"hash_4F9F1239CFD921FE"](f389_local2.desc),
						categoryString = @"hash_0",
						mainExtraText = "",
						subExtraText = @"hash_0",
						discountIndx = 0,
						openCrate = 0,
						bundleTitleRef = f389_local2.name,
						bundleImage = f389_local2.buttonImage,
						toolTipText = @"hash_0",
					},
				})
			end
		end
		return f389_local0
	end,
	nil,
	nil,
	function(f390_arg0, f390_arg1, f390_arg2)
		if not f390_arg1.__discountListSubscriptions then
			f390_arg1.__discountListSubscriptions = true
			f390_arg1:subscribeToGlobalModel(f390_arg0, "AutoEvents", "cycled", function()
				f390_arg1:updateDataSource()
			end)
		end
	end
)
CoD.BlackMarketUtility.ShowFreeBundlePopupIfNeeded = function(f392_arg0, f392_arg1)
	local f392_local0 = IsBooleanDvarSet(@"hash_220494C24B5CE9B0")
	if f392_local0 then
		f392_local0 = Dvar.loot_tier_discount_free_skuID:get() and not CoD.BlackMarketUtility.IsItemPurchased(f392_arg1, Dvar.loot_tier_discount_free_skuID:get())
	end
	if f392_local0 then
		InitDataSourceModel(f392_arg1, "FreeBundle")
		local f392_local1 = DataSources.FreeBundle.recreate(f392_arg1)
		local f392_local2 = {
			_closeAndGoBack = false,
		}
		if f392_local1 then
			DelayOpenOverlay(f392_arg0, "ItemShopConfirmation", f392_arg1, {
				_model = f392_local1,
				_properties = f392_local2,
			})
			local f392_local3 = Engine[@"getmodelforcontroller"](f392_arg1)
			local f392_local4 = f392_local3:create("LootStreamProgress.playAnimation")
			f392_local4:set(false)
		end
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("FreeBundle", "FreeBundle", function(f393_arg0, f393_arg1)
	if IsBooleanDvarSet(@"hash_220494C24B5CE9B0") then
		local f393_local0 = Engine[@"converttoxhash"](Dvar.loot_tier_discount_free_bundle:get())
		local f393_local1 = CoD.BlackMarketUtility.GetSpecialBundleInfo(f393_arg1, f393_local0)
		if f393_local1 then
			local f393_local2 = f393_arg0:create("name")
			f393_local2:set(f393_local1.name)
			f393_local2 = f393_arg0:create("desc")
			f393_local2:set(f393_local1.desc)
			f393_local2 = f393_arg0:create("primaryImage")
			f393_local2:set(f393_local1.primaryImage)
			f393_local2 = f393_arg0:create("itemCategory")
			f393_local2:set(@"special_bundle")
			f393_local2 = f393_arg0:create("skuID")
			f393_local2:set(Dvar[@"hash_13CC625DF35C3B6"]:get() or "0")
			f393_local2 = f393_arg0:create("percentOff")
			f393_local2:set(0)
			f393_local2 = f393_arg0:create("hashName")
			f393_local2:set(f393_local0)
			f393_local2 = f393_arg0:create("purchased")
			f393_local2:set(false)
			f393_local2 = f393_arg0:create("totalRewardCount")
			f393_local2:set(1)
			f393_local2 = f393_arg0:create("includesTiers")
			f393_local2:set(false)
			f393_local2 = f393_arg0:create("openCrate")
			f393_local2:set(tonumber(Dvar[@"hash_A404E7DECECAA0A"]:get()) or 0)
		end
	end
end, false)
CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount = function(f394_arg0)
	local f394_local0 = 0
	for f394_local4, f394_local5 in pairs(CoDShared.Loot.CrateCosts) do
		f394_local0 = f394_local0 + Engine[@"hash_5352DC095BBB2A45"](f394_arg0, f394_local5.id)
	end
	return f394_local0
end
CoD.BlackMarketUtility.GetLootBribeOwnedCount = function(f395_arg0)
	local f395_local0 = 0
	for f395_local10, f395_local11 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f395_arg0)) do
		if CoD.BlackMarketUtility.GetBribeAsset(f395_arg0, f395_local11.name) then
			local f395_local4 = true
			for f395_local8, f395_local9 in ipairs(CoDShared.Loot.Cases) do
				if f395_local11.name == f395_local9 then
					f395_local4 = false
				end
			end
			for f395_local8, f395_local9 in ipairs(CoDShared.Loot.Crates) do
				if f395_local11.name == f395_local9 then
					f395_local4 = false
				end
			end
			if f395_local4 then
				f395_local0 = f395_local0 + f395_local11.nonCpQuantity
			end
		end
	end
	return f395_local0
end
CoD.BlackMarketUtility.OpenCrateByCurrency = function(f396_arg0, f396_arg1)
	local f396_local0 = 0
	local f396_local1 = Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") and @"half_off_crate" or @"crate"
	for f396_local6, f396_local7 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableCPBribes(f396_arg0)) do
		if f396_local7.name == f396_local1 then
			f396_local0 = f396_local7.lootRule
			local f396_local5 = Engine[@"hash_26C232D7031CE1CF"](f396_arg0, f396_local0, CoDShared.Loot.GetBribePayload(f396_arg0, f396_local7.currency, f396_local0))
			Engine[@"sendclientscriptnotify"](f396_arg0, "BlackJackReserve", {
				status = "OpenCrate",
				crateId = "1001",
				result = f396_local5,
			})
			return f396_local5 == 1
		end
	end
	return false
end
CoD.BlackMarketUtility.OpenNoDupeCrateWithCases = function(f397_arg0)
	local f397_local0 = 0
	for f397_local5, f397_local6 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f397_arg0)) do
		if f397_local6.name == @"no_dupe_crate" then
			f397_local0 = f397_local6.lootRule
			local f397_local4 = Engine[@"hash_26C232D7031CE1CF"](f397_arg0, f397_local0, CoDShared.Loot.GetBribePayload(f397_arg0, f397_local6.currency, f397_local0))
			Engine[@"sendclientscriptnotify"](f397_arg0, "BlackJackReserve", {
				status = "OpenCrate",
				crateId = "1001",
				result = f397_local4,
			})
			return f397_local4 == 1
		end
	end
	return false
end
CoD.BlackMarketUtility.OpenBribe = function(f398_arg0, f398_arg1, f398_arg2)
	local f398_local0 = Engine[@"hash_26C232D7031CE1CF"](f398_arg0, f398_arg1, CoDShared.Loot.GetBribePayload(f398_arg0, f398_arg2, f398_arg1))
	Engine[@"sendclientscriptnotify"](f398_arg0, "BlackJackReserve", {
		status = "OpenCrate",
		crateId = "1001",
		result = f398_local0,
	})
	return f398_local0 == 1
end
CoD.BlackMarketUtility.OpenBlackjackReservesAndItemPurchaseOverlay = function(f399_arg0, f399_arg1, f399_arg2, f399_arg3, f399_arg4)
	if not Engine[@"isuserguest"](f399_arg2) then
		OpenOverlay(f399_arg4, "QuarterMasterMenu", f399_arg2, {
			_tab = "reserves",
			_itemPurchaseId = f399_arg3,
		})
	end
end
CoD.BlackMarketUtility.LootPurchaseCaseModelValues = {
	name = @"hash_0",
	price = 0,
	desc = @"hash_0",
	isBundleCrate = false,
	isCrateItem = false,
	primaryImage = @"blacktransparent",
	popupImage = @"blacktransparent",
}
CoD.BlackMarketUtility.LootPurchaseCrateModelValues = {
	name = @"hash_683A7EF42505FCE5",
	desc = 0x439483603981EF,
	isCrateItem = true,
	image = @"ui_icon_blackmarket_reserves_crate_large_square",
	primaryImage = @"uie_ui_menu_blackmarket_blackjack_single_crate",
	popupImage = @"ui_icon_blackmarket_reserves_crate_large",
	buttonImage = @"hash_2703EE51FECA8823",
	percentOff = 0,
}
CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues = {
	name = @"hash_683A7EF42505FCE5",
	desc = 0x439483603981EF,
	isCrateItem = true,
	image = @"ui_icon_blackmarket_reserves_crate_large_square",
	primaryImage = @"hash_2C9248138678C017",
	popupImage = @"ui_icon_blackmarket_reserves_crate_large",
	buttonImage = 0x9789792C2B80FF,
	percentOff = 50,
}
CoD.BlackMarketUtility.CrateBundles = {
	{
		dvar = @"hash_E354B31C00CCA30",
		expKey = "exp10And2BundleOn",
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1808C02A0C0BB64D", 10, 2),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_630D04B9A9BC6DCC", 10, 2),
		primaryImage = @"hash_31D3F93B1DD00AA9",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500401,
		price = 2000,
		percentOff = 0,
	},
	{
		dvar = @"hash_31E792E2BD77172F",
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1808C02A0C0BB64D", 5, 1),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_630D04B9A9BC6DCC", 5, 1),
		primaryImage = @"ui_icon_blackmarket_reserves_bundle_crates_5",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_5_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500400,
		price = 1000,
		percentOff = 0,
	},
	{
		dvar = @"hash_3163578955C48A9B",
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1808C02A0C0BB64D", 10, 10),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5301B8AB07202897", 10, 10, 5),
		primaryImage = @"hash_7B310673A8798EE0",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500406,
		price = 2000,
		maxQuantity = 5,
		percentOff = 0,
	},
	{
		dvar = @"hash_36C1E5C082205C",
		expKey = "convenienceBundleOn",
		name = Engine[@"hash_4F9F1239CFD921FE"](0x41EC0C908CFFDA, 10),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_41C1D12890A8F3FD", 10),
		primaryImage = @"ui_icon_blackmarket_reserves_bundle_crates_10",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500404,
		price = 2000,
		percentOff = 0,
	},
	{
		dvar = @"hash_33422D2E8F226B22",
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_391C3D56DC3A34AC", 10),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3B3B24D245052AFB", 10),
		primaryImage = @"hash_1B5F4CE08C5B0187",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500407,
		price = 2400,
		percentOff = 0,
	},
	{
		dvar = @"hash_3BDDD81D377BEF96",
		name = Engine[@"hash_4F9F1239CFD921FE"](0x41EC0C908CFFDA, 100),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_41C1D12890A8F3FD", 100),
		primaryImage = @"hash_4DDCC687468DAB70",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500408,
		price = 5000,
		percentOff = 0,
	},
	{
		dvar = 0xFB1611BBD20C8,
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B8CE1EFC822B9D9", 5, 5),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3D09745D293A1FB0", 5, 5),
		primaryImage = @"hash_6F1DFF8758FEB5C4",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_5_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500409,
		price = 1000,
		percentOff = 0,
	},
	{
		dvar = @"hash_E2193834F14DB57",
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B8CE1EFC822B9D9", 10, 20),
		desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3D09745D293A1FB0", 10, 20),
		primaryImage = @"hash_2B7BDD54EFBD8B27",
		popupImage = @"ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500410,
		price = 2000,
		percentOff = 0,
	},
}
DataSources.ReservesItemCounts = {
	subscriptions = {},
	getModel = function(f400_arg0)
		local f400_local0 = Engine[@"getmodelforcontroller"](f400_arg0)
		local f400_local1 = f400_local0:create("ReservesItemCounts")
		local f400_local2 = IsLootReady(f400_arg0)
		local f400_local3
		if f400_local2 then
			f400_local3 = CoDShared.Loot.GetLootCaseOwnedCount(f400_arg0)
			if not f400_local3 then
			else
				local f400_local4 = f400_local1:create("lootCaseCount")
				f400_local4:set(f400_local3)
				local f400_local5
				if f400_local2 then
					f400_local5 = CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f400_arg0)
					if not f400_local5 then
					else
						local f400_local6 = f400_local1:create("lootBundleCrateCount")
						f400_local6:set(f400_local5)
						if f400_local2 then
							f400_local6 = CoD.BlackMarketUtility.GetLootBribeOwnedCount(f400_arg0)
							if not f400_local6 then
							else
								local f400_local7 = f400_local1:create("lootBribeCount")
								f400_local7:set(f400_local6)
								if not DataSources.ReservesItemCounts.subscriptions[f400_arg0] then
									DataSources.ReservesItemCounts.subscriptions[f400_arg0] = LUI.UIElement.new()
									f400_local7 = f400_local0.LootStreamProgress
									if f400_local7 then
										f400_local7 = f400_local0.LootStreamProgress.currentTier
									end
									if f400_local7 then
										DataSources.ReservesItemCounts.subscriptions[f400_arg0]:subscribeToModel(f400_local7, function(model)
											Engine[@"forcenotifymodelsubscriptions"](f400_local4)
										end, false)
									end
								end
								return f400_local1
							end
						end
						f400_local6 = -1
					end
				end
				f400_local5 = -1
			end
		end
		f400_local3 = -1
	end,
}
DataSources.SpecialOrderTierBoostAlpha = {
	getModel = function(f402_arg0)
		local f402_local0 = Engine[@"getmodelforcontroller"](f402_arg0)
		f402_local0 = f402_local0:create("SpecialOrderTierBoostAlpha")
		local f402_local1 = 0
		if CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent(f402_arg0, nil) then
			f402_local1 = 100
		end
		local f402_local2 = f402_local0:create("alpha")
		f402_local2:set(f402_local1)
		return f402_local0
	end,
}
DataSources.TierBoostPercent = {
	getModel = function(f403_arg0)
		local f403_local0 = Engine[@"getmodelforcontroller"](f403_arg0)
		f403_local0 = f403_local0:create("TierBoostPercent")
		local f403_local1 = CoDShared.Loot.GetCurrentTierBoost(f403_arg0) or 0
		local f403_local2 = f403_local0:create("boost_amount")
		f403_local2:set(f403_local1)
		f403_local2 = Dvar[@"hash_5B23C92E3E72DF30"]:get()
		local f403_local3 = f403_local0:create("specialorder_boost_amount")
		f403_local3:set(f403_local2)
		return f403_local0
	end,
}
DataSources.ReservesLootPurchaseCase = {
	prepare = function(f404_arg0)
		local f404_local0 = Engine[@"getmodelforcontroller"](f404_arg0)
		f404_local0 = f404_local0:create("ReservesLootPurchaseCase")
		for f404_local4, f404_local5 in pairs(CoD.BlackMarketUtility.LootPurchaseCaseModelValues) do
			local f404_local6 = f404_local0:create(f404_local4)
			f404_local6:set(f404_local5)
		end
		return f404_local0
	end,
	getModel = function(f405_arg0)
		local f405_local0 = Engine[@"getmodelforcontroller"](f405_arg0)
		f405_local0 = f405_local0.ReservesLootPurchaseCase
		if not f405_local0 then
			f405_local0 = DataSources.ReservesLootPurchaseCase.prepare(f405_arg0)
		end
		return f405_local0
	end,
}
CoD.BlackMarketUtility.NoDupePriceString = function(f406_arg0, f406_arg1)
	local f406_local0 = tonumber(CoD.SafeGetModelValue(f406_arg0, "currency"))
	if f406_local0 and f406_local0 == CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID then
		return LocalizeIntoString(@"hash_79CBD79D3C8A2BED", f406_arg1)
	else
		return LocalizeIntoString(@"hash_27AD54B6F8C27799", f406_arg1)
	end
end
CoD.BlackMarketUtility.NoDupeTitleString = function(f407_arg0, f407_arg1, f407_arg2)
	if CoD.BlackMarketUtility.CanPurchaseNoDupeCrate(f407_arg1, f407_arg0) then
		return LocalizeIntoString(@"hash_663FCD1B0849669E", f407_arg2)
	else
		return LocalizeIntoString(@"hash_16F86EB73F5E0A4C", f407_arg2)
	end
end
CoD.BlackMarketUtility.CanPurchaseNoDupeCrate = function(f408_arg0, f408_arg1)
	local f408_local0 = tonumber(CoD.SafeGetModelValue(f408_arg1:getModel(), "casePrice"))
	local f408_local1 = tonumber(CoD.SafeGetModelValue(f408_arg1:getModel(), "currency"))
	if f408_local0 and f408_local1 and f408_local1 ~= CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID then
		return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f408_arg0, "ReservesItemCounts", "lootCaseCount", f408_local0)
	else
		return false
	end
end
CoD.BlackMarketUtility.AttemptPurchaseNoDupeCrate = function(f409_arg0, f409_arg1, f409_arg2, f409_arg3)
	local f409_local0 = GoBack(f409_arg3, f409_arg2)
	if f409_arg3._isOtherBlackMarketTab then
		f409_local0._tab = "reserves"
		local f409_local1 = Engine[@"forcenotifymodelsubscriptions"]
		local f409_local2 = Engine[@"getmodelforcontroller"](f409_arg2)
		f409_local1(f409_local2:create("QuarterMasterTabUpdate"))
	end
	CoD.BlackMarketUtility.OpenNoDupeCrateWithCases(f409_arg2)
	CoDShared.Loot.ClearRNGModels(f409_arg2)
	if f409_arg3._isReservesRevealMenu then
		local f409_local1 = Engine[@"getmodelforcontroller"](f409_arg2)
		f409_local1 = f409_local1:create("reservesRevealComplete")
		f409_local1:set(false)
		if f409_local0:getModel() ~= DataSources.ReservesNoDupesCrate.getModel(f409_arg2) then
			f409_local0:setModel(DataSources.ReservesNoDupesCrate.getModel(f409_arg2), f409_arg2)
		end
	else
		OpenOverlay(f409_local0, "BlackjackReserveReveal", f409_arg2, {
			_model = DataSources.ReservesNoDupesCrate.getModel(f409_arg2),
		})
	end
end
CoD.BlackMarketUtility.AttemptPurchaseBribeStack = function(f410_arg0, f410_arg1, f410_arg2, f410_arg3)
	local f410_local0 = GoBack(f410_arg3, f410_arg2)
	if f410_arg3._isOtherBlackMarketTab then
		f410_local0._tab = "reserves"
		local f410_local1 = Engine[@"forcenotifymodelsubscriptions"]
		local f410_local2 = Engine[@"getmodelforcontroller"](f410_arg2)
		f410_local1(f410_local2:create("QuarterMasterTabUpdate"))
	end
	CoD.BlackMarketUtility.OpenNoDupeCrateWithCases(f410_arg2)
	CoDShared.Loot.ClearRNGModels(f410_arg2)
	if f410_arg3._isReservesRevealMenu then
		local f410_local1 = Engine[@"getmodelforcontroller"](f410_arg2)
		f410_local1 = f410_local1:create("reservesRevealComplete")
		f410_local1:set(false)
		if f410_local0:getModel() ~= DataSources.ReservesNoDupesCrate.getModel(f410_arg2) then
			f410_local0:setModel(DataSources.ReservesNoDupesCrate.getModel(f410_arg2), f410_arg2)
		end
	else
		OpenOverlay(f410_local0, "BlackjackReserveReveal", f410_arg2, {
			_model = DataSources.ReservesNoDupesCrate.getModel(f410_arg2),
		})
	end
end
DataSources.ReservesNoDupesCrate = {
	prepare = function(f411_arg0)
		local f411_local0 = Engine[@"getmodelforcontroller"](f411_arg0)
		f411_local0 = f411_local0:create("ReservesNoDupesCrate")
		local f411_local1 = CoD.BlackMarketUtility.GetBribeAsset(f411_arg0, @"no_dupe_crate")
		if f411_local1 then
			local f411_local2 = f411_local0:create("name")
			f411_local2:set(f411_local1.name or 0x0)
			f411_local2 = f411_local0:create("desc")
			f411_local2:set(f411_local1.desc or 0x0)
			f411_local2 = f411_local0:create("popupImage")
			f411_local2:set(f411_local1.popupImage or @"blacktransparent")
			f411_local2 = f411_local0:create("primaryImage")
			f411_local2:set(f411_local1.primaryImage or @"blacktransparent")
			f411_local2 = CoD.BlackMarketTableUtility.GetBribeInformation(f411_arg0, @"no_dupe_crate")
			if f411_local2 then
				local f411_local3 = f411_local0:create("price")
				f411_local3:set(f411_local2.price or 0)
				f411_local3 = f411_local0:create("currency")
				local f411_local4 = f411_local3
				f411_local3 = f411_local3.set
				local f411_local5 = f411_local2.currency
				if not f411_local5 then
					f411_local5 = CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID
				end
				f411_local3(f411_local4, f411_local5)
				f411_local3 = f411_local0:create("canPurchase")
				f411_local3:set(f411_local2.canPurchase or false)
			end
		end
		local f411_local2 = f411_local0:create("isBundleCrate")
		f411_local2:set(false)
		f411_local2 = f411_local0:create("isCrateItem")
		f411_local2:set(false)
		return f411_local0
	end,
	getModel = function(f412_arg0)
		local f412_local0 = Engine[@"getmodelforcontroller"](f412_arg0)
		f412_local0 = f412_local0.ReservesNoDupesCrate
		if not f412_local0 then
			f412_local0 = DataSources.ReservesNoDupesCrate.prepare(f412_arg0)
		end
		return f412_local0
	end,
}
DataSources.ReservesLootPurchaseCrate = {
	prepare = function(f413_arg0)
		local f413_local0 = Engine[@"getmodelforcontroller"](f413_arg0)
		f413_local0 = f413_local0:create("ReservesLootPurchaseCrate")
		if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
			for f413_local4, f413_local5 in pairs(CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues) do
				local f413_local6 = f413_local0:create(f413_local4)
				f413_local6:set(f413_local5)
			end
		else
			for f413_local4, f413_local5 in pairs(CoD.BlackMarketUtility.LootPurchaseCrateModelValues) do
				local f413_local6 = f413_local0:create(f413_local4)
				f413_local6:set(f413_local5)
			end
		end
		local f413_local1 = f413_local0:create("price")
		f413_local1:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"))
		f413_local1 = f413_local0:create("isBundleCrate")
		f413_local1:set(false)
		return f413_local0
	end,
	getModel = function(f414_arg0)
		local f414_local0 = Engine[@"getmodelforcontroller"](f414_arg0)
		f414_local0 = f414_local0.ReservesLootPurchaseCrate
		if not f414_local0 then
			f414_local0 = DataSources.ReservesLootPurchaseCrate.prepare(f414_arg0)
		end
		return f414_local0
	end,
}
DataSources.ReservesLootBundleCrate = {
	subscriptions = {},
	prepare = function(f415_arg0)
		local f415_local0 = Engine[@"getmodelforcontroller"](f415_arg0)
		f415_local0 = f415_local0:create("ReservesLootBundleCrate")
		if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
			for f415_local4, f415_local5 in pairs(CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues) do
				local f415_local6 = f415_local0:create(f415_local4)
				f415_local6:set(f415_local5)
			end
			f415_local1 = f415_local0:create("price")
			f415_local1:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7") / 2)
		else
			for f415_local4, f415_local5 in pairs(CoD.BlackMarketUtility.LootPurchaseCrateModelValues) do
				local f415_local6 = f415_local0:create(f415_local4)
				f415_local6:set(f415_local5)
			end
			f415_local1 = f415_local0:create("price")
			f415_local1:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"))
		end
		local f415_local1 = f415_local0:create("isBundleCrate")
		f415_local1:set(true)
		return f415_local0
	end,
	getModel = function(f416_arg0)
		local f416_local0 = Engine[@"getmodelforcontroller"](f416_arg0)
		f416_local0 = f416_local0.ReservesLootBundleCrate
		if not f416_local0 then
			f416_local0 = DataSources.ReservesLootBundleCrate.prepare(f416_arg0)
		end
		if not DataSources.ReservesLootBundleCrate.subscriptions[f416_arg0] then
			DataSources.ReservesLootBundleCrate.subscriptions[f416_arg0] = LUI.UIElement.new()
			DataSources.ReservesLootBundleCrate.subscriptions[f416_arg0]:subscribeToGlobalModel(f416_arg0, "AutoEvents", "cycled", function()
				DataSources.ReservesLootBundleCrate.prepare(f416_arg0)
			end)
		end
		return f416_local0
	end,
}
DataSourceHelpers.PerControllerDataSourceSetup("ReservesLootPurchaseCrateBundle", "ReservesLootPurchaseCrateBundle", function(f418_arg0, f418_arg1)
	if IsBooleanDvarSet(@"hash_396CDD0567DE073F") then
		local f418_local0 = Engine[@"getdvarint"](@"hash_3D6C52B2CB5555BD")
		local f418_local1 = Engine[@"getdvarint"](@"hash_7E517CFF26DEE76")
		local f418_local2 = Engine[@"getdvarint"](@"hash_71C4FD1471CC7CC7")
		local f418_local3 = Engine[@"getdvarint"](@"hash_25DC3754B06C6C01")
		local f418_local4 = Engine[@"getdvarstring"]("loot_crateBundleImage")
		local f418_local5 = Engine[@"converttoxhash"](Engine[@"getdvarstring"]("loot_crateBundlePopupImage"))
		local f418_local6 = f418_arg0:create("name")
		f418_local6:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1808C02A0C0BB64D", f418_local0, f418_local1))
		f418_local6 = f418_arg0:create("desc")
		f418_local6:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_630D04B9A9BC6DCC", f418_local0, f418_local1))
		f418_local6 = f418_arg0:create("image")
		local f418_local7 = f418_local6
		f418_local6 = f418_local6.set
		local f418_local8
		if f418_local4 then
			f418_local8 = Engine[@"converttoxhash"](f418_local4)
			if not f418_local8 then
			else
				f418_local6(f418_local7, f418_local8)
				f418_local6 = f418_arg0:create("popupImage")
				f418_local6:set(f418_local5)
				f418_local6 = f418_arg0:create("crateBaseCount")
				f418_local6:set(f418_local0)
				f418_local6 = f418_arg0:create("crateExtraCount")
				f418_local6:set(f418_local1)
				f418_local6 = f418_arg0:create("price")
				f418_local6:set(f418_local2)
				f418_local6 = f418_arg0:create("skuID")
				f418_local6:set(f418_local3)
				f418_local6 = f418_arg0:create("isBundleCrate")
				f418_local6:set(true)
				f418_local6 = f418_arg0:create("isReservesLootPurchaseCrateBundle")
				f418_local6:set(true)
			end
		end
		f418_local8 = nil
	end
end, false)
DataSources.ReservesLootPurchaseItems = ListHelper_SetupDataSource(
	"ReservesLootPurchaseItems",
	function(f419_arg0, f419_arg1)
		local f419_local0 = {}
		for f419_local5, f419_local6 in ipairs(CoD.BlackMarketUtility.CrateBundles) do
			local f419_local4 = IsBooleanDvarSet(f419_local6.dvar)
			if not f419_local4 and f419_local6.expKey and CoD.StoreUtility.GetExperimentModifier(f419_arg0, f419_local6.expKey) == "1" then
				f419_local4 = true
			end
			if f419_local4 and f419_local6.maxQuantity and f419_local6.maxQuantity <= Engine[@"hash_5352DC095BBB2A45"](f419_arg0, f419_local6.skuId) then
				f419_local4 = false
			end
			if f419_local4 then
				table.insert(f419_local0, {
					models = f419_local6,
					properties = {
						itemPurchaseId = "crate",
					},
				})
			end
		end
		if not Engine[@"getdvarbool"](@"hash_1539A350E73051B8") then
			if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
				f419_local1 = LUI.ShallowCopy(CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues)
				f419_local1.price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7") / 2
				f419_local1.isBundleCrate = false
				f419_local1.name = Engine[@"hash_4F9F1239CFD921FE"](f419_local1.name)
				f419_local1.desc = Engine[@"hash_4F9F1239CFD921FE"](f419_local1.desc)
				table.insert(f419_local0, {
					models = f419_local1,
					properties = {
						itemPurchaseId = "crate",
					},
				})
			else
				f419_local1 = LUI.ShallowCopy(CoD.BlackMarketUtility.LootPurchaseCrateModelValues)
				f419_local1.price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7")
				f419_local1.isBundleCrate = false
				f419_local1.name = Engine[@"hash_4F9F1239CFD921FE"](f419_local1.name)
				f419_local1.desc = Engine[@"hash_4F9F1239CFD921FE"](f419_local1.desc)
				table.insert(f419_local0, {
					models = f419_local1,
					properties = {
						itemPurchaseId = "crate",
					},
				})
			end
		end
		for f419_local5, f419_local6 in ipairs(CoD.BlackMarketUtility.CrateBundles) do
			if not IsBooleanDvarSet(f419_local6.dvar) and f419_local6.expKey and (f419_local6.expKey == "convenienceBundleOn" or f419_local6.expKey == "exp10And2BundleOn") then
				local f419_local4 = CoD.StoreUtility.GetExperimentModifier(f419_arg0, f419_local6.expKey)
				if f419_local4 == "2" then
					table.insert(f419_local0, 1, {
						models = f419_local6,
						properties = {
							itemPurchaseId = "crate",
						},
					})
				end
				if f419_local4 == "3" then
					table.insert(f419_local0, {
						models = f419_local6,
						properties = {
							itemPurchaseId = "crate",
						},
					})
				end
			end
		end
		return f419_local0
	end,
	nil,
	nil,
	function(f420_arg0, f420_arg1, f420_arg2)
		if not f420_arg1.__crateBundleSubscriptions then
			f420_arg1.__crateBundleSubscriptions = true
			f420_arg1:subscribeToGlobalModel(f420_arg0, "AutoEvents", "cycled", function()
				f420_arg1:updateDataSource()
			end, false)
		end
	end
)
DataSources.PurchaseReservesItemButtons = ListHelper_SetupDataSource("PurchaseReservesItemButtons", function(f422_arg0, f422_arg1)
	local f422_local0 = ""
	local f422_local1 = 0
	local f422_local2 = @"blacktransparent"
	local f422_local3 = "0"
	local f422_local4 = false
	local f422_local5 = false
	local f422_local6 = false
	local f422_local7 = false
	if f422_arg1.menu and f422_arg1.menu.FullscreenPopupTemplate then
		f422_local7 = f422_arg1.menu.FullscreenPopupTemplate.currentState == "FinishedState"
	end
	local f422_local8 = f422_arg1.menu
	if f422_local8 then
		f422_local8 = f422_arg1.menu:getModel()
	end
	if f422_local8 then
		if f422_local8.name then
			f422_local0 = f422_local8.name:get() or f422_local0
		end
		if f422_local8.price then
			f422_local1 = f422_local8.price:get() or f422_local1
		end
		if f422_local8.popupImage then
			f422_local2 = f422_local8.popupImage:get() or f422_local2
		end
		if f422_local8.skuID then
			f422_local3 = f422_local8.skuID:get() or f422_local3
		end
		if f422_local8.isCrateItem then
			f422_local4 = f422_local8.isCrateItem:get() or f422_local4
		end
		if f422_local8.isReservesLootPurchaseCrateBundle then
			local f422_local9 = f422_local8.isReservesLootPurchaseCrateBundle:get()
		end
		f422_local5 = f422_local9 or f422_local8.itemIsReservesLootPurchaseCrateBundle
	end
	local f422_local10 = function(f423_arg0, f423_arg1, f423_arg2, f423_arg3, f423_arg4)
		local f423_local0 = f423_arg3 or {}
		local f423_local1 = function()
			if not f422_local7 and f422_local3 ~= "0" and not f423_local0.isCrateItem and not f423_local0.isReservesLootPurchaseCrateBundle then
				SetWorkingStateAndPurchaseDWSKU(f423_arg0, f423_arg1, f423_arg2, f422_local6)
			else
				local f424_local0 = GoBack(f423_arg4, f423_arg2)
				if f424_local0 and f424_local0._currentTab then
					CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f423_arg2, f424_local0._currentTab, true)
				else
					CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f423_arg2, "quickPurchase", true)
				end
				if f423_arg4._isOtherBlackMarketTab then
					f424_local0._tab = "reserves"
					local f424_local1 = Engine[@"forcenotifymodelsubscriptions"]
					local f424_local2 = Engine[@"getmodelforcontroller"](f423_arg2)
					f424_local1(f424_local2:create("QuarterMasterTabUpdate"))
				end
				CoDShared.Loot.ClearRNGModels(f423_arg2)
				if f423_local0.isBundleCrate then
					CoD.BlackMarketUtility.RedeemLootBundleCrate(f423_arg2)
					f422_local8 = DataSources.ReservesLootBundleCrate.getModel(f423_arg2)
				elseif f423_local0.isCrateItem then
					CoD.BlackMarketUtility.PurchaseLootCrate(f423_arg2)
				end
				if f423_arg4._isReservesRevealMenu then
					local f424_local1 = Engine[@"getmodelforcontroller"](f423_arg2)
					f424_local1 = f424_local1:create("reservesRevealComplete")
					f424_local1:set(false)
					if f424_local0:getModel() ~= f422_local8 then
						f424_local0:setModel(f422_local8, f423_arg2)
					end
				else
					OpenOverlay(f424_local0, "BlackjackReserveReveal", f423_arg2, {
						_model = f422_local8,
					})
				end
			end
		end
		if CoD.isPC then
			CoD.PCUtility.DisplayPrePurchasePopup(f423_local1, f423_arg4, f423_arg2, {
				lootCrateElement = f423_arg1,
			}, function(f425_arg0)
				f423_arg0:setState(f425_arg0, "DefaultState")
			end)
			f422_local6 = true
		else
			f423_local1()
		end
	end
	local f422_local11 = function(f426_arg0, f426_arg1, f426_arg2, f426_arg3, f426_arg4)
		CoD.BlackMarketUtility.SendPurchaseReservesEvent(f426_arg2, f426_arg4)
		GoBack(f426_arg4, f426_arg2)
	end
	local f422_local12 = false
	local f422_local13 = {}
	if not f422_local7 then
		table.insert(f422_local13, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FA071A53508DC6E", f422_local0, f422_local1),
			action = f422_local10,
			params = {
				isCrateItem = f422_local4,
			},
			selectIndex = false,
		})
	end
	local f422_local14 = CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f422_arg0)
	if f422_local14 > 0 then
		local f422_local15 = false
		if f422_local7 then
			f422_local15 = true
			f422_local12 = true
		end
		table.insert(f422_local13, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_BD06AD4757160DF", f422_local14),
			action = f422_local10,
			params = {
				isBundleCrate = true,
				isReservesLootPurchaseCrateBundle = f422_local5,
			},
			selectIndex = f422_local15,
		})
	end
	if not CoD.isPC then
		table.insert(f422_local13, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/cancel"),
			action = f422_local11,
			selectIndex = not f422_local12,
		})
		f422_local12 = true
	end
	local f422_local15 = {}
	for f422_local19, f422_local20 in ipairs(f422_local13) do
		table.insert(f422_local15, {
			models = {
				displayText = f422_local20.displayText,
				itemName = f422_local0,
				itemPrice = f422_local1,
				itemImage = f422_local2,
			},
			properties = {
				action = f422_local20.action,
				actionParam = f422_local20.params,
				selectIndex = f422_local20.selectIndex,
			},
		})
	end
	return f422_local15
end, true)
DataSources.PurchaseBribeStackButtons = ListHelper_SetupDataSource("PurchaseBribeStackButtons", function(f427_arg0, f427_arg1)
	local f427_local0 = ""
	local f427_local1 = 0
	local f427_local2 = 0
	local f427_local3 = @"blacktransparent"
	local f427_local4 = "0"
	local f427_local5 = 0
	local f427_local6 = false
	local f427_local7 = false
	local f427_local8 = 0x0
	local f427_local9 = false
	if f427_arg1.menu and f427_arg1.menu.FullscreenPopupTemplate then
		f427_local9 = f427_arg1.menu.FullscreenPopupTemplate.currentState == "FinishedState"
	end
	local f427_local10 = f427_arg1.menu
	if f427_local10 then
		f427_local10 = f427_arg1.menu:getModel()
	end
	if f427_local10 then
		if f427_local10.name then
			f427_local0 = f427_local10.name:get() or f427_local0
		end
		if f427_local10.price then
			f427_local1 = f427_local10.price:get() or f427_local1
		end
		if f427_local10.casePrice then
			f427_local2 = f427_local10.casePrice:get() or f427_local2
		end
		if f427_local10.popupImage then
			f427_local3 = f427_local10.popupImage:get() or f427_local3
		end
		if f427_local10.lootRule then
			f427_local5 = f427_local10.lootRule:get() or f427_local5
		end
		if f427_local10.isReservesLootPurchaseCrateBundle then
			local f427_local11 = f427_local10.isReservesLootPurchaseCrateBundle:get()
		end
		f427_local6 = f427_local11 or f427_local10.itemIsReservesLootPurchaseCrateBundle
		if f427_local10.hashName then
			f427_local8 = f427_local10.hashName:get() or f427_local8
		end
	end
	local f427_local12 = function(f428_arg0, f428_arg1, f428_arg2, f428_arg3, f428_arg4)
		local f428_local0 = f428_arg3 or {}
		local f428_local1 = function(f429_arg0, f429_arg1)
			if f429_arg1 == tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) then
				CoD.BlackMarketUtility.SendItemShopViewEvent(f428_arg2, f428_arg4, "purchased")
			else
				CoD.BlackMarketUtility.SendItemShopViewEvent(f428_arg2, f428_arg4, "exchange")
			end
			local f429_local0 = GoBack(f428_arg4, f428_arg2)
			if f428_arg4._isWeaponBribeSelect then
				f429_local0 = GoBack(f429_local0, f428_arg2)
			end
			if f428_arg4._isOtherBlackMarketTab or f428_arg4._isWeaponBribeSelect then
				f429_local0._tab = "reserves"
				local f429_local1 = Engine[@"forcenotifymodelsubscriptions"]
				local f429_local2 = Engine[@"getmodelforcontroller"](f428_arg2)
				f429_local1(f429_local2:create("QuarterMasterTabUpdate"))
			end
			CoDShared.Loot.ClearRNGModels(f428_arg2)
			CoD.BlackMarketUtility.OpenBribe(f428_arg2, f429_arg0, f429_arg1)
			if f428_arg4._isReservesRevealMenu then
				local f429_local1 = Engine[@"getmodelforcontroller"](f428_arg2)
				f429_local1 = f429_local1:create("reservesRevealComplete")
				f429_local1:set(false)
				if f429_local0:getModel() ~= f427_local10 then
					f429_local0:setModel(f427_local10, f428_arg2)
				end
			else
				OpenOverlay(f429_local0, "BlackjackReserveReveal", f428_arg2, {
					_model = f427_local10,
				})
			end
		end
		if CoD.isPC then
			CoD.PCUtility.DisplayPrePurchasePopup(f428_local1, f428_arg4, f428_arg2, {
				lootCrateElement = f428_arg1,
			}, function(f430_arg0)
				f428_arg0:setState(f430_arg0, "DefaultState")
			end)
			f427_local7 = true
		else
			f428_local1(f428_local0.crateId, f428_local0.costId)
		end
	end
	local f427_local13 = function(f431_arg0, f431_arg1, f431_arg2, f431_arg3, f431_arg4)
		local f431_local0 = f431_arg3 or {}
		local f431_local1 = f431_arg4:getModel()
		local f431_local2 = GoBack(f431_arg4, f431_arg2)
		if f431_local2 and f431_local2._currentTab then
			CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f431_arg2, f431_local2._currentTab, true)
		else
			CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f431_arg2, "quickPurchase", true)
		end
		OpenPopup(f431_local2, "PurchaseCodPoints", f431_arg2, f431_local1)
	end
	local f427_local14 = function(f432_arg0, f432_arg1, f432_arg2, f432_arg3, f432_arg4)
		CoD.BlackMarketUtility.SendItemShopViewEvent(f432_arg2, f432_arg4, "")
		GoBack(f432_arg4, f432_arg2)
	end
	local f427_local15 = false
	local f427_local16 = {}
	local f427_local17 = function(f433_arg0, f433_arg1, f433_arg2, f433_arg3, f433_arg4)
		if Engine[@"hash_2F40679B550DCCA2"](f433_arg2, CoD.Currencies.COD_POINTS) < f427_local1 then
			f427_local13(f433_arg0, f433_arg1, f433_arg2, f433_arg3, f433_arg4)
		else
			f427_local12(f433_arg0, f433_arg1, f433_arg2, f433_arg3, f433_arg4)
		end
	end
	if f427_local1 > 0 then
		table.insert(f427_local16, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4D7958D4F60AF758", f427_local1),
			action = f427_local17,
			params = {
				crateId = f427_local5,
				costId = tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID),
			},
			selectIndex = false,
			canPurchase = true,
		})
	end
	local f427_local18 = false
	if f427_local2 <= Engine[@"hash_5352DC095BBB2A45"](f427_arg0, tostring(CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID)) then
		f427_local18 = true
	end
	if f427_local2 > 0 then
		local f427_local19 = table.insert
		local f427_local20 = f427_local16
		local f427_local21 = {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_126434B8DF70C716", f427_local2),
		}
		if f427_local18 then
			local f427_local22 = f427_local12
		end
		f427_local21.action = f427_local22 or nil
		f427_local21.params = {
			crateId = f427_local5,
			costId = tostring(CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID),
		}
		f427_local21.selectIndex = false
		f427_local21.canPurchase = f427_local18
		f427_local19(f427_local20, f427_local21)
	end
	if not CoD.isPC then
		table.insert(f427_local16, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/cancel"),
			action = f427_local14,
			selectIndex = not f427_local15,
			canPurchase = true,
		})
		f427_local15 = true
	end
	local f427_local19 = {}
	for f427_local24, f427_local25 in ipairs(f427_local16) do
		table.insert(f427_local19, {
			models = {
				displayText = f427_local25.displayText,
				itemName = f427_local0,
				itemPrice = f427_local1,
				itemImage = f427_local3,
				canPurchase = f427_local25.canPurchase,
			},
			properties = {
				action = f427_local25.action,
				actionParam = f427_local25.params,
				selectIndex = f427_local25.selectIndex,
			},
		})
	end
	return f427_local19
end, true)
DataSources.ReservesSpecialContract = {
	subscriptions = {},
	prepare = function(f434_arg0)
		local f434_local0 = Engine[@"getmodelforcontroller"](f434_arg0)
		f434_local0 = f434_local0:create("ReservesSpecialContract")
		local f434_local1 = false
		local f434_local2 = false
		local f434_local3 = 0x0
		local f434_local4 = 0x0
		local f434_local5 = ""
		local f434_local6 = ""
		local f434_local7 = 0x0
		local f434_local8 = 0x0
		local f434_local9 = @"blacktransparent"
		local f434_local10 = 0
		local f434_local11 = ""
		local f434_local12 = ""
		local f434_local13 = ""
		local f434_local14 = @"blacktransparent"
		local f434_local15 = Dvar.loot_special_contract_bundle:get()
		local f434_local16 = f434_local15 and Engine[@"converttoxhash"](f434_local15)
		local f434_local17 = f434_local16 and CoD.BlackMarketUtility.GetSpecialBundleInfo(f434_arg0, f434_local16)
		if f434_local17 then
			f434_local1 = true
			f434_local3 = f434_local17.category
			f434_local4 = f434_local17.name
			f434_local5 = f434_local17.desc
			f434_local8 = f434_local17.toolTip
			f434_local6 = f434_local17.specialContractDesc
			f434_local7 = f434_local17.specialContractGoalType
			f434_local14 = f434_local17.specialContractRewardImage
			if f434_local17.reservesImage ~= 0x0 then
				f434_local9 = f434_local17.reservesImage
			end
			local f434_local18 = Engine[@"hash_391AEA655912B0E8"](f434_arg0, f434_local16)
			if f434_local18 and f434_local18.multiProgress then
				for f434_local24, f434_local25 in ipairs(f434_local18.multiProgress) do
					if not (not IsOrbis() or f434_local25.multiProgressName ~= @"hash_53DA67CF93B503F2") or not IsOrbis() and f434_local25.multiProgressName == @"hash_6B607F41F8B8A540" then
						f434_local11 = f434_local25.multiProgress
						f434_local12 = f434_local25.multiProgressTarget
						local f434_local22 = Engine[@"hash_690B6BCE69A8E08B"](f434_local11)
						local f434_local23 = Engine[@"hash_690B6BCE69A8E08B"](f434_local12)
						if f434_local23 <= f434_local22 then
							f434_local11 = f434_local12
							f434_local10 = 1
							f434_local2 = true
							break
						elseif f434_local22 < 0 then
							f434_local11 = "0"
							f434_local10 = 0
							break
						end
						f434_local10 = Engine[@"hash_2431E7E8CD45CA6D"](f434_local22, f434_local23)
					end
				end
			end
			if f434_local17.specialContractGoalUnit ~= 0x0 then
				f434_local13 = Engine[@"hash_4F9F1239CFD921FE"](f434_local17.specialContractGoalUnit, f434_local12)
			end
		end
		local f434_local18 = f434_local0:create("active")
		f434_local18:set(f434_local1)
		f434_local18 = f434_local0:create("complete")
		f434_local18:set(f434_local2)
		f434_local18 = f434_local0:create("categoryString")
		f434_local18:set(f434_local3)
		f434_local18 = f434_local0:create("rewardName")
		f434_local18:set(f434_local4)
		f434_local18 = f434_local0:create("description")
		f434_local18:set(f434_local5)
		f434_local18 = f434_local0:create("toolTip")
		f434_local18:set(f434_local8)
		f434_local18 = f434_local0:create("bundleReservesImage")
		f434_local18:set(f434_local9)
		f434_local18 = f434_local0:create("progress")
		f434_local18:set(f434_local10)
		f434_local18 = f434_local0:create("detailsMenuDesc")
		f434_local18:set(f434_local6)
		f434_local18 = f434_local0:create("detailsMenuGoalType")
		f434_local18:set(f434_local7)
		f434_local18 = f434_local0:create("currentValue")
		f434_local18:set(f434_local11)
		f434_local18 = f434_local0:create("endValue")
		f434_local18:set(Engine[@"hash_BA51654DAB171D"](f434_local12))
		f434_local18 = f434_local0:create("endValuePlusUnits")
		f434_local18:set(f434_local13)
		f434_local18 = f434_local0:create("detailsMenuRewardImage")
		f434_local18:set(f434_local14)
		return f434_local0
	end,
	getModel = function(f435_arg0)
		local f435_local0 = Engine[@"getmodelforcontroller"](f435_arg0)
		f435_local0 = f435_local0.ReservesSpecialContract
		if not f435_local0 then
			f435_local0 = DataSources.ReservesSpecialContract.prepare(f435_arg0)
		end
		if not DataSources.ReservesSpecialContract.subscriptions[f435_arg0] then
			DataSources.ReservesSpecialContract.subscriptions[f435_arg0] = LUI.UIElement.new()
			DataSources.ReservesSpecialContract.subscriptions[f435_arg0]:subscribeToGlobalModel(f435_arg0, "AutoEvents", "cycled", function()
				DataSources.ReservesSpecialContract.prepare(f435_arg0)
			end)
			local f435_local1 = DataSources.ReservesSpecialContract.subscriptions[f435_arg0]
			local f435_local2 = f435_local1
			f435_local1 = f435_local1.subscribeToModel
			local f435_local3 = Engine[@"getmodelforcontroller"](f435_arg0)
			f435_local1(f435_local2, f435_local3:create("achievementStateUpdate"), function()
				DataSources.ReservesSpecialContract.prepare(f435_arg0)
			end)
		end
		return f435_local0
	end,
}
DataSources.DupeMeterPulse = {
	prepare = function(f438_arg0)
		local f438_local0 = Engine[@"getmodelforcontroller"](f438_arg0)
		f438_local0 = f438_local0:create("DupeMeterPulse")
		local f438_local1 = f438_local0:create("pulseDupeIcon")
		f438_local1:set(false)
		f438_local1 = f438_local0:create("pulseRerollIcon")
		f438_local1:set(false)
		return f438_local0
	end,
	getModel = function(f439_arg0)
		local f439_local0 = Engine[@"getmodelforcontroller"](f439_arg0)
		f439_local0 = f439_local0.DupeMeterPulse
		if not f439_local0 then
			f439_local0 = DataSources.DupeMeterPulse.prepare(f439_arg0)
		end
		return f439_local0
	end,
}
CoD.BlackMarketUtility.ReservesSpecialContractAppendCompletion = function(f440_arg0, f440_arg1)
	if f440_arg0.complete and f440_arg0.complete:get() then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_6CB33332BE6053BD", f440_arg1)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_247E99E2B20180F0", f440_arg1)
	end
end
CoD.BlackMarketUtility.SendPurchaseReservesEvent = function(f441_arg0, f441_arg1)
	local f441_local0 = f441_arg1.occludedMenu
	if f441_local0 and f441_local0._currentTab then
		CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f441_arg0, f441_local0._currentTab, false)
	else
		CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f441_arg0, "quickPurchase", false)
	end
end
CoD.BlackMarketUtility.SendPurchaseTiersEvent = function(f442_arg0, f442_arg1)
	local f442_local0 = f442_arg1:getModel()
	if f442_local0 then
		CoD.MetricsUtility.BlackMarketTierPurchasedEvent(f442_arg0, f442_local0.entryPoint and f442_local0.entryPoint:get() or "", false, f442_local0.tiers and f442_local0.tiers:get() or 1)
	end
end
CoD.BlackMarketUtility.SendItemShopViewEvent = function(f443_arg0, f443_arg1, f443_arg2)
	local f443_local0 = f443_arg1.occludedMenu
	if f443_local0.id ~= "Menu.QuarterMasterMenu" then
		f443_local0 = f443_local0.occludedMenu
	end
	local f443_local1 = f443_arg1:getModel()
	if f443_local0 and (f443_local0._currentTab == "itemshop" or f443_local0._currentTab == "supplychain" or f443_local0._currentTab == "reserves") and f443_local1 then
		local f443_local2 = f443_local1.slot and f443_local1.slot:get() or 0
		local f443_local3 = f443_local1.skuId and f443_local1.skuId:get() or 0
		local f443_local4 = f443_local1.price and f443_local1.price:get() or 0
		local f443_local5 = f443_local1.casePrice and f443_local1.casePrice:get() or 0
		local f443_local6 = f443_local1.hashName and f443_local1.hashName:get() or 0x0
		local f443_local7 = f443_arg2
		if f443_local7 == "" then
			f443_local7 = "viewed"
		end
		if f443_local1.purchased and f443_local1.purchased:get() or false and f443_local7 == "viewed" then
			f443_local7 = "owned"
		end
		local f443_local8 = f443_local1.stackPosition and f443_local1.stackPosition:get() or 0
		local f443_local9 = f443_local1.stackTotal and f443_local1.stackTotal:get() or 0
		local f443_local10 = 0
		local f443_local11 = 0
		if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
			local f443_local12 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ItemshopRotation")
			if f443_local12 then
				local f443_local13 = f443_local12:create("loot_itemshop_slot" .. tostring(f443_local2) .. "_timer_raw")
				f443_local10 = f443_local13:get()
				f443_local11 = tonumber(CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime(f443_arg0, f443_local2))
			end
			f443_local2 = f443_local2 + CoD.BlackMarketUtility.BlackjackShopSlotIndexSunsetOffset
			if not f443_local10 then
				f443_local11 = 0
				local f443_local13 = CoD.BlackMarketTableUtility.GetBribeInformation(f443_arg0, f443_local6)
				if f443_local13 then
					local f443_local14 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "BribeStackTimer")
					if f443_local14 and f443_local14[f443_local13.stringName .. "_raw"] then
						f443_local10 = f443_local14[f443_local13.stringName .. "_raw"]:get()
						f443_local11 = tonumber(CoD.BlackMarketUtility.GetBribeStackWindowSizeSeconds(f443_arg0, f443_local13.stringName))
					end
				else
					local f443_local14 = f443_local1.bribeStringName and f443_local1.bribeStringName:get() or ""
					if CoD.BlackMarketTableUtility.IsBribeMenu(f443_arg0, f443_local14) then
						local f443_local15 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "BribeMenuTimer")
						if f443_local15 and f443_local15.bribe_menu_timer_raw then
							f443_local10 = f443_local15.bribe_menu_timer_raw:get()
							f443_local11 = tonumber(CoD.BlackMarketUtility.GetBribeMenuWindowSizeSeconds(f443_arg0))
							f443_local6 = Engine[@"converttoxhash"](f443_local14)
						end
					end
				end
			end
			if f443_local0._currentTab == "reserves" then
				f443_local2 = f443_local2 + 1
			end
		end
		CoD.MetricsUtility.BlackMarketItemShopEvent(f443_arg0, f443_local2, f443_local7, f443_local3, f443_local6, f443_local8, f443_local9, f443_local10, f443_local11, f443_local4, f443_local5)
	end
end
CoD.BlackMarketUtility.MarkTabAsSeen = function(f444_arg0, f444_arg1)
	if not f444_arg1._entrypoint then
		local f444_local0 = Engine[@"currentsessionmode"]()
		if f444_local0 == Enum[@"emodes"][@"mode_zombies"] then
			f444_arg1._entrypoint = "zombies"
		elseif f444_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
			if LuaUtils.IsArenaMode() then
				f444_arg1._entrypoint = "arena"
			else
				f444_arg1._entrypoint = "multiplayer"
			end
		elseif f444_local0 == Enum[@"emodes"][@"mode_warzone"] then
			f444_arg1._entrypoint = "warzone"
		else
			f444_arg1._entrypoint = "director"
		end
	end
	if f444_arg1._currentTab then
		if f444_arg1._currentTab == "itemshop" then
			f444_arg1._shop = true
		elseif f444_arg1._currentTab == "reserves" then
			f444_arg1._reserves = true
		elseif f444_arg1._currentTab == "supplychain" then
			f444_arg1._contraband = true
		elseif f444_arg1._currentTab == "inventory" then
			f444_arg1._inventory = true
		end
	end
end
CoD.BlackMarketUtility.GetReservesRevealBlankItemValues = function()
	return {
		name = @"hash_0",
		desc = "",
		mainExtraText = "",
		subExtraText = @"hash_0",
		primaryImage = @"hash_0",
		popupImage = @"hash_0",
		detailsImage = @"hash_0",
		category = @"hash_0",
		shopCategory = @"hash_0",
		rarity = Enum[@"lootraritytype"][@"loot_rarity_type_count"],
		character = @"hash_0",
		gesture_index = -1,
		setBonusImage = @"hash_0",
		setBonusName = @"hash_0",
		setComplete = false,
		setNumOwned = 0,
		setNumAvailable = 0,
		setNumTotal = 0,
		isContrabandCrate = false,
		isInSet = false,
		isBundle = false,
		itemCategory = @"hash_0",
		allowTogglePreview = false,
		allowFrozenMoment = false,
		seasonal = false,
		includesTiers = false,
		dupe = false,
		reroll = false,
		revealed = false,
		hasRerolled = false,
		weaponRef = @"hash_0",
		toolTipText = @"hash_0",
	}
end
CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn = function(f446_arg0, f446_arg1)
	for f446_local4, f446_local5 in pairs(f446_arg1) do
		if type(f446_local5) == "table" then
			if not f446_arg0[f446_local4] then
				f446_arg0:create(f446_local4)
			end
			CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn(f446_arg0[f446_local4], f446_local5)
		end
		if f446_arg0[f446_local4] then
			f446_arg0[f446_local4]:set(f446_local5)
		else
			local f446_local3 = f446_arg0:create(f446_local4)
			f446_local3:set(f446_local5)
		end
	end
end
CoD.BlackMarketUtility.BlackjackReserveRevealOnCompleteFn = function(f447_arg0, f447_arg1)
	local f447_local0 = Enum[@"lootraritytype"][@"loot_rarity_type_common"]
	local f447_local1 = DataSources.BlackjackReserveRevealList.getCount(f447_arg1)
	for f447_local2 = 1, f447_local1, 1 do
		local f447_local5 = DataSources.BlackjackReserveRevealList.getItem(f447_arg0, f447_arg1, f447_local2)
		local f447_local6 = f447_local5.rarity:get()
		if f447_local0 < f447_local6 then
			f447_local0 = f447_local6
		end
	end
	if f447_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_common"] or f447_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_rare"] then
		PlaySoundAlias("vox_blac_crate_cmmn_rare")
	elseif f447_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_legendary"] then
		PlaySoundAlias("vox_blac_crate_legend")
	elseif f447_local0 == Enum[@"lootraritytype"][@"loot_rarity_type_epic"] then
		PlaySoundAlias("vox_blac_crate_epic")
	elseif f447_local0 == Enum[@"lootraritytype"][@"hash_63006FE890A202D9"] then
		PlaySoundAlias("vox_blac_crate_ult")
	end
	local f447_local2 = Engine[@"getmodelforcontroller"](f447_arg0)
	f447_local2 = f447_local2:create("reservesRevealComplete")
	f447_local2:set(true)
	f447_local2 = DataSources.DupeMeterPulse.getModel(f447_arg0)
	if not f447_local2.pulseDupeIcon:set(f447_arg1._revealDupeCount > 0) then
		Engine[@"forcenotifymodelsubscriptions"](f447_local2.pulseDupeIcon)
	end
	if not f447_local2.pulseRerollIcon:set(f447_arg1._revealRerollCount > 0) then
		Engine[@"forcenotifymodelsubscriptions"](f447_local2.pulseRerollIcon)
	end
end
CoD.BlackMarketUtility.BlackjackReserveRevealListCustomSetupFn = function(f448_arg0, f448_arg1, f448_arg2)
	local f448_local0 = f448_arg1.menu
	local f448_local1 = Engine[@"getmodelforcontroller"](f448_arg0)
	local f448_local2 = f448_local1.LootRNGResult.ready
	if not f448_arg1.__reserveRevealListSubscriptions then
		f448_arg1.__reserveRevealListSubscriptions = true
		f448_arg1:subscribeToModel(f448_local2, function(model)
			f448_arg1:updateDataSource()
		end)
	end
	if f448_local2:get() then
		if f448_local0._reservesRevealTimers then
			for f448_local6, f448_local7 in pairs(f448_local0._reservesRevealTimers) do
				if f448_local7 then
					f448_local7:close()
				end
			end
		end
		f448_local0._reservesRevealTimers = {}
		local f448_local3 = CoD.BlackMarketUtility.LootItemRevealInitialDelayMS
		local f448_local4 = CoD.BlackMarketUtility.LootItemRevealPerItemDelayMS
		local f448_local5 = CoD.BlackMarketUtility.LootItemRevealPreRerollDelayMS
		local f448_local6 = CoD.BlackMarketUtility.LootItemRevealRerollDelayMS
		local f448_local7 = CoD.BlackMarketUtility.LootItemRevealFinalDelayMS
		if Engine[@"isdevelopmentbuild"]() then
			if Dvar[@"hash_1F7E25209ABEC8D2"]:exists() then
				f448_local3 = Dvar[@"hash_1F7E25209ABEC8D2"]:get() or f448_local3
			end
			if Dvar[@"hash_73FDC833491511A"]:exists() then
				f448_local4 = Dvar[@"hash_73FDC833491511A"]:get() or f448_local4
			end
			if Dvar[@"hash_76F16E6502004BC3"]:exists() then
				f448_local5 = Dvar[@"hash_76F16E6502004BC3"]:get() or f448_local5
			end
			if Dvar[@"hash_539A0F9D4C50018A"]:exists() then
				f448_local6 = Dvar[@"hash_539A0F9D4C50018A"]:get() or f448_local6
			end
			if Dvar[@"hash_3F722D1F6B7FE27E"]:exists() then
				f448_local7 = Dvar[@"hash_3F722D1F6B7FE27E"]:get() or f448_local7
			end
		end
		if f448_local0._reservesRevealIntroDelayTimeMS then
			f448_local3 = f448_local3 + f448_local0._reservesRevealIntroDelayTimeMS
		end
		local f448_local8 = 0
		local f448_local9 = DataSources.BlackjackReserveRevealList.getCount(f448_arg1)
		for f448_local10 = 1, f448_local9, 1 do
			local f448_local13 = f448_local10
			f448_local0._reservesRevealTimers["listRevealTimer" .. f448_local13] = LUI.UITimer.newElementTimer(f448_local3 + f448_local4 * (f448_local13 - 1) + (f448_local5 + f448_local6) * f448_local8, true, function(f450_arg0)
				local f450_local0 = DataSources.BlackjackReserveRevealList.getItem(f448_arg0, f448_arg1, f448_local13)
				local f450_local1 = f450_local0 and f450_local0.revealed
				if f450_local1 then
					f450_local1:set(true)
				end
			end)
			f448_local0:addElement(f448_local0._reservesRevealTimers["listRevealTimer" .. f448_local13])
			local f448_local14 = DataSources.BlackjackReserveRevealList.getCustomPropertiesForItem(f448_arg1, f448_local13)
			if f448_local14 and f448_local14.rerollItemId then
				f448_local8 = f448_local8 + 1
				f448_local0._reservesRevealTimers.rerollDupeItemTimer = LUI.UITimer.newElementTimer(f448_local3 + f448_local4 * (f448_local13 - 1) + f448_local5 * f448_local8, true, function(f451_arg0)
					local f451_local0 = DataSources.BlackjackReserveRevealList.getItem(f448_arg0, f448_arg1, f448_local13)
					f451_local0.hasRerolled:set(true)
					f451_local0.revealed:set(false)
				end)
				f448_local0._reservesRevealTimers.rerollRevealTimer = LUI.UITimer.newElementTimer(f448_local3 + f448_local4 * (f448_local13 - 1) + (f448_local5 + f448_local6) * f448_local8, true, function(f452_arg0)
					local f452_local0 = DataSources.BlackjackReserveRevealList.getItem(f448_arg0, f448_arg1, f448_local13)
					local f452_local1 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f448_arg0, f448_local14.rerollItemId, 0)
					local f452_local2 = f452_local1 and CoD.BlackMarketUtility.GetItemRefs(f448_arg0, f452_local1.name, f452_local1.category, f452_local1.rarity, f452_local1.inSet, 0, f452_local1.lootType, f452_local1.refOptic, f452_local1.itemId)
					if f452_local2 then
						local f452_local3, f452_local4 = CoD.BlackMarketUtility.GetItemProductAndProperties(f452_local2)
						CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn(f452_local0, f452_local3)
					end
					f452_local0.dupe:set(false)
					f452_local0.reroll:set(true)
					f452_local0.revealed:set(true)
				end)
				f448_local0:addElement(f448_local0._reservesRevealTimers.rerollDupeItemTimer)
				f448_local0:addElement(f448_local0._reservesRevealTimers.rerollRevealTimer)
			end
		end
		f448_local0._reservesRevealTimers.revealCompleteTimer = LUI.UITimer.newElementTimer(f448_local3 + f448_local4 * (f448_local9 - 1) + (f448_local5 + f448_local6) * f448_local8 + f448_local7, true, function(f453_arg0)
			CoD.BlackMarketUtility.BlackjackReserveRevealOnCompleteFn(f448_arg0, f448_arg1)
		end)
		f448_local0:addElement(f448_local0._reservesRevealTimers.revealCompleteTimer)
		local f448_local11 = Engine[@"getmodelforcontroller"](f448_arg0)
		if f448_local11.LootRNGResult.streamId:get() == CoD.BlackMarketUtility.CrateStreams.CASE then
			CoD.BlackMarketUtility.UpdateLootCaseBreadcrumbStatValue(f448_arg0)
			local f448_local12 = DataSources.ReservesItemCounts.getModel(f448_arg0)
			Engine[@"forcenotifymodelsubscriptions"](f448_local12.lootCaseCount)
		else
		end
	end
end
CoD.BlackMarketUtility.GetEmptyReserveRevealCount = function(f454_arg0)
	local f454_local0 = CoD.BlackMarketUtility.LootItemCountCrate
	local f454_local1 = Engine[@"getmodelforcontroller"](f454_arg0)
	f454_local1 = f454_local1.LootRNGResult.streamId:get()
	if f454_local1 == CoD.BlackMarketUtility.CrateStreams.CASE then
		f454_local0 = CoD.BlackMarketUtility.LootItemCountCase
	elseif CoD.BlackMarketUtility.IsBribeStream(f454_arg0) then
		local f454_local2 = CoD.BlackMarketTableUtility.GetBribeInformation(f454_arg0, f454_local1 and Engine[@"converttoxhash"](f454_local1))
		if f454_local2 and f454_local2.isSingleItem then
			f454_local0 = CoD.BlackMarketUtility.LootItemCountCase
		end
	end
	return f454_local0
end
DataSources.BlackjackReserveRevealList = ListHelper_SetupDataSource("BlackjackReserveRevealList", function(f455_arg0, f455_arg1)
	local f455_local0 = {}
	local f455_local1 = nil
	f455_arg1._revealDupeCount = 0
	f455_arg1._revealRerollCount = 0
	local f455_local2 = Engine[@"getmodelforcontroller"](f455_arg0)
	f455_local2 = f455_local2.LootRNGResult
	if f455_local2 then
		if not f455_local2.ready:get() then
			local f455_local3 = {}
			local f455_local4 = CoD.BlackMarketUtility.GetReservesRevealBlankItemValues()
			local f455_local5 = CoD.BlackMarketUtility.GetEmptyReserveRevealCount(f455_arg0)
			for f455_local6 = 1, f455_local5, 1 do
				local f455_local9 = f455_local6
				table.insert(f455_local3, {
					models = f455_local4,
				})
			end
			return f455_local3
		else
			if Engine[@"isdevelopmentbuild"]() then
				local f455_local3 = Engine[@"getdvarstring"]("loot_fakeRarity")
				if f455_local3 then
					if f455_local3 == "common" then
						f455_local1 = CoD.BlackMarketUtility[@"hash_28F1DEAFDA8DC0BC"]
					elseif f455_local3 == "rare" then
						f455_local1 = CoD.BlackMarketUtility[@"hash_5484A50BE5ADB35"]
					elseif f455_local3 == "legendary" then
						f455_local1 = CoD.BlackMarketUtility[@"hash_6F1C1A8D4B68B502"]
					elseif f455_local3 == "epic" then
						f455_local1 = CoD.BlackMarketUtility[@"hash_61F6439D530101F0"]
					elseif f455_local3 == "ultra" then
						f455_local1 = CoD.BlackMarketUtility[@"hash_6687ECDB5754642D"]
					end
				end
			end
			local f455_local3 = 0
			local f455_local4 = false
			local f455_local5 = f455_local2.itemsEarned and f455_local2.itemsEarned:get() or 0
			for f455_local6 = 1, f455_local5, 1 do
				local f455_local10 = f455_local2["item" .. f455_local6]
				local f455_local11 = f455_local10.itemId:get()
				local f455_local12 = f455_local10.isRerollReplaced:get()
				if Engine[@"isdevelopmentbuild"]() and not f455_local12 then
					f455_local3 = f455_local3 + 1
					if f455_local1 then
						f455_local11 = f455_local1[f455_local3] or f455_local11
					end
					local f455_local13 = Dvar[Engine[@"converttoxhash"]("loot_fakeItem" .. f455_local3)]:get()
					if f455_local13 then
						f455_local11 = tostring(f455_local13) or f455_local11
					end
				end
				if f455_local10 then
					local f455_local14 = f455_local10.rollType:get()
					local f455_local13 = f455_local14 == LuaEnum.LOOT_FLAGS.DUPE
					local f455_local15 = f455_local14 == LuaEnum.LOOT_FLAGS.REROLL
					if f455_local13 then
						f455_arg1._revealDupeCount = f455_arg1._revealDupeCount + 1
					end
					if f455_local15 then
						f455_arg1._revealRerollCount = f455_arg1._revealRerollCount + 1
					end
					if f455_local4 then
						f455_local4 = false
						if #f455_local0 > 0 then
							f455_local0[#f455_local0].properties.rerollItemId = f455_local11
						end
					end
					if f455_local12 then
						f455_local4 = true
					end
					local f455_local16 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f455_arg0, f455_local11, 0)
					if not f455_local16 then
						f455_local16 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f455_arg0, f455_local11)
						if not f455_local16 then
							f455_local16 = CoD.BlackMarketTableUtility.GetContractItemInfoFromId(f455_arg0, f455_local11)
						end
					end
					local f455_local17 = f455_local16 and CoD.BlackMarketUtility.GetItemRefs(f455_arg0, f455_local16.name, f455_local16.category, f455_local16.rarity, f455_local16.inSet, 0, f455_local16.lootType, f455_local16.refOptic, f455_local16.itemId)
					if f455_local17 then
						local f455_local18, f455_local19 = CoD.BlackMarketUtility.GetItemProductAndProperties(f455_local17)
						f455_local18.dupe = f455_local13
						f455_local18.reroll = f455_local15
						f455_local18.revealed = false
						f455_local18.hasRerolled = false
						table.insert(f455_local0, {
							models = f455_local18,
							properties = f455_local19,
						})
					end
				end
			end
		end
	end
	return f455_local0
end, true, nil, CoD.BlackMarketUtility.BlackjackReserveRevealListCustomSetupFn)
CoD.BlackMarketUtility.ClearRNGModels = function(f456_arg0)
	CoDShared.Loot.ClearRNGModels(f456_arg0)
end
CoD.BlackMarketUtility.ClearDupeMeterPulseModels = function(f457_arg0)
	local f457_local0 = DataSources.DupeMeterPulse.getModel(f457_arg0)
	f457_local0.pulseDupeIcon:set(false)
	f457_local0.pulseRerollIcon:set(false)
end
CoD.BlackMarketUtility.UpdateLootCaseCountWidget = function(f458_arg0, f458_arg1, f458_arg2)
	if not f458_arg0._lastSeenCaseCount then
		f458_arg0._lastSeenCaseCount = f458_arg2
		return
	elseif f458_arg0._lastSeenCaseCount < f458_arg2 then
		f458_arg0:playClip("GetCase")
	end
	f458_arg0._lastSeenCaseCount = f458_arg2
end
CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify = function(f459_arg0, f459_arg1)
	if f459_arg1 and not IsBooleanDvarSet("loot_sunsetBlackjackShopActive") and CoD.FTUEUtility.ShouldShowFTUESequence(f459_arg0, "BlackjackReservesIntroduction") then
		return
	end
	local f459_local0 = CoDShared.Loot.GetLootCaseOwnedCount(f459_arg0)
	local f459_local1 = CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f459_arg0)
	local f459_local2 = CoD.BlackMarketUtility.GetLootBribeOwnedCount(f459_arg0)
	if f459_local0 > 0 or f459_local1 > 0 or f459_local2 > 0 or CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f459_arg0, "LootStreamProgress.codPoints", 100) then
		if false == true then
			Engine[@"sendclientscriptnotify"](f459_arg0, "BlackJackReserve", {
				open = f459_arg1,
				status = "welcome_case_special",
			})
		elseif f459_local0 >= 5 or f459_local1 >= 5 or f459_local2 >= 5 then
			Engine[@"sendclientscriptnotify"](f459_arg0, "BlackJackReserve", {
				open = f459_arg1,
				status = "welcome_case_multi",
			})
		elseif f459_local0 > 0 or f459_local1 > 0 or f459_local2 > 0 then
			Engine[@"sendclientscriptnotify"](f459_arg0, "BlackJackReserve", {
				open = f459_arg1,
				status = "welcome_case_avail",
			})
		else
			Engine[@"sendclientscriptnotify"](f459_arg0, "BlackJackReserve", {
				open = f459_arg1,
				status = "welcome_case_notavail",
			})
		end
	else
		Engine[@"sendclientscriptnotify"](f459_arg0, "BlackJackReserve", {
			open = f459_arg1,
			status = "welcome_empty",
		})
	end
end
CoD.BlackMarketUtility.PurchaseLootCrate = function(f460_arg0)
	CoD.BlackMarketUtility.OpenCrateByCurrency(f460_arg0, CoD.BlackMarketUtility.CrateStreams.THREE_PACK)
end
CoD.BlackMarketUtility.RedeemLootBundleCrate = function(f461_arg0)
	CoD.BlackMarketUtility.RedeemNonCPLootBribe(f461_arg0, CoD.BlackMarketUtility.GetFirstBribeNameByType(f461_arg0, LuaEnum.BRIBE_TYPES.CRATE))
end
CoD.BlackMarketUtility.GetBribeNameFromMenuProperty = function(f462_arg0, f462_arg1, f462_arg2)
	local f462_local0 = f462_arg1._bribeName
	if f462_local0 then
		local f462_local1 = CoD.BlackMarketUtility.GetBribeAsset(f462_arg0, f462_local0)
		if f462_local1 then
			return f462_local1.name
		end
	end
	return 0x0
end
CoD.BlackMarketUtility.GetBribeDescFromMenuProperty = function(f463_arg0, f463_arg1, f463_arg2)
	local f463_local0 = f463_arg1._bribeName
	if f463_local0 then
		local f463_local1 = CoD.BlackMarketUtility.GetBribeAsset(f463_arg0, f463_local0)
		if f463_local1 then
			return f463_local1.desc
		end
	end
	return 0x0
end
CoD.BlackMarketUtility.GetBribeImageFromMenuProperty = function(f464_arg0, f464_arg1, f464_arg2)
	local f464_local0 = f464_arg1._bribeName
	if f464_local0 then
		local f464_local1 = CoD.BlackMarketUtility.GetBribeAsset(f464_arg0, f464_local0)
		if f464_local1 then
			return f464_local1.popupImage
		end
	end
	return @"blacktransparent"
end
CoD.BlackMarketUtility.RedeemNonCPLootBribe = function(f465_arg0, f465_arg1)
	if f465_arg1 then
		local f465_local0 = CoD.BlackMarketTableUtility.GetBribeInformation(f465_arg0, f465_arg1)
		if f465_local0.nonCpQuantity > 0 and f465_local0.name ~= @"no_dupe_crate" then
			local f465_local1 = f465_local0.currency
			if f465_local1 == "20" then
				f465_local1 = f465_local0.optionalCurrency
			end
			CoD.BlackMarketUtility.OpenBribe(f465_arg0, f465_local0.lootRule, f465_local1)
		end
	end
end
CoD.BlackMarketUtility.GetFirstBribeNameByType = function(f466_arg0, f466_arg1)
	for f466_local9, f466_local10 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f466_arg0)) do
		if CoD.BlackMarketUtility.GetBribeAsset(f466_arg0, f466_local10.name) then
			if f466_arg1 == LuaEnum.BRIBE_TYPES.CASE then
				for f466_local6, f466_local7 in ipairs(CoDShared.Loot.Cases) do
					if f466_local10.name == f466_local7 and f466_local10.nonCpQuantity > 0 then
						return f466_local10.name
					end
				end
			end
			if f466_arg1 == LuaEnum.BRIBE_TYPES.CRATE then
				for f466_local6, f466_local7 in ipairs(CoDShared.Loot.Crates) do
					if f466_local10.name == f466_local7 and f466_local10.nonCpQuantity > 0 and f466_local7 ~= @"no_dupe_crate" then
						return f466_local10.name
					end
				end
			end
			if f466_arg1 == LuaEnum.BRIBE_TYPES.BRIBE then
				local f466_local3 = true
				for f466_local7, f466_local8 in ipairs(CoDShared.Loot.Cases) do
					if f466_local10.name == f466_local8 then
						f466_local3 = false
					end
				end
				for f466_local7, f466_local8 in ipairs(CoDShared.Loot.Crates) do
					if f466_local10.name == f466_local8 then
						f466_local3 = false
					end
				end
				if f466_local3 and f466_local10.nonCpQuantity > 0 then
					return f466_local10.name
				end
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.SetBribeNamePropertyByType = function(f467_arg0, f467_arg1)
	local f467_local0 = LuaEnum.BRIBE_TYPES.CASE
	if f467_arg1 and f467_arg1._bribeType then
		f467_local0 = f467_arg1._bribeType
	end
	f467_arg1._bribeName = CoD.BlackMarketUtility.GetFirstBribeNameByType(f467_arg0, f467_local0)
end
CoD.BlackMarketUtility.RedeemNoDupeCrateBribe = function(f468_arg0)
	for f468_local3, f468_local4 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f468_arg0)) do
		if f468_local4.nonCpQuantity > 0 and f468_local4.name == @"no_dupe_crate" then
			CoD.BlackMarketUtility.OpenNoDupeCrateWithCases(f468_arg0)
			return
		end
	end
end
CoD.BlackMarketUtility.ReservesRevealIntroDelay = function(f469_arg0, f469_arg1, f469_arg2)
	if not f469_arg1._reservesRevealIntroTimer then
		f469_arg1._reservesRevealIntroDelayTimeMS = f469_arg2
		f469_arg1._reservesRevealIntroTimer = LUI.UITimer.newElementTimer(f469_arg2, true, function(f470_arg0)
			if f469_arg1._reservesRevealIntroTimer then
				f469_arg1._reservesRevealIntroTimer:close()
				f469_arg1._reservesRevealIntroTimer = false
			end
			f469_arg1._reservesRevealIntroComplete = true
			f469_arg1._reservesRevealIntroDelayTimeMS = 0
			UpdateSelfState(f469_arg1, f469_arg0)
		end)
		f469_arg1:addElement(f469_arg1._reservesRevealIntroTimer)
	end
end
CoD.BlackMarketUtility.SkipReservesRevealAnimation = function(f471_arg0, f471_arg1, f471_arg2)
	local f471_local0 = Engine[@"getmodelforcontroller"](f471_arg0)
	if f471_local0.LootRNGResult.ready:get() then
		if f471_arg1._reservesRevealIntroTimer then
			f471_arg1._reservesRevealIntroTimer:close()
			f471_arg1._reservesRevealIntroTimer = false
			f471_arg1._reservesRevealIntroComplete = true
			f471_arg1._reservesRevealIntroDelayTimeMS = 0
			UpdateSelfState(f471_arg1, f471_arg0)
		end
		if f471_arg1._reservesRevealTimers then
			for f471_local4, f471_local5 in pairs(f471_arg1._reservesRevealTimers) do
				f471_local5:close()
			end
			f471_arg1._reservesRevealTimers = nil
		end
		local f471_local1 = DataSources.BlackjackReserveRevealList.getCount(f471_arg2)
		for f471_local2 = 1, f471_local1, 1 do
			local f471_local6 = DataSources.BlackjackReserveRevealList.getItem(f471_arg0, f471_arg2, f471_local2)
			local f471_local7 = DataSources.BlackjackReserveRevealList.getCustomPropertiesForItem(f471_arg2, f471_local2)
			if f471_local7 and f471_local7.rerollItemId and not f471_local6.reroll:get() then
				local f471_local8 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f471_arg0, f471_local7.rerollItemId, 0)
				local f471_local9 = f471_local8 and CoD.BlackMarketUtility.GetItemRefs(f471_arg0, f471_local8.name, f471_local8.category, f471_local8.rarity, f471_local8.inSet, 0, f471_local8.lootType, f471_local8.refOptic, f471_local8.itemId)
				if f471_local9 then
					local f471_local10, f471_local11 = CoD.BlackMarketUtility.GetItemProductAndProperties(f471_local9)
					CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn(f471_local6, f471_local10)
				end
				f471_local6.dupe:set(false)
				f471_local6.reroll:set(true)
			end
			f471_local6.revealed:set(true)
		end
		CoD.BlackMarketUtility.BlackjackReserveRevealOnCompleteFn(f471_arg0, f471_arg2)
	end
end
CoD.BlackMarketUtility.AutoOpenItemPurchasePopup = function(f472_arg0, f472_arg1, f472_arg2)
	if f472_arg2._itemPurchaseId then
		local f472_local0 = f472_arg2._itemPurchaseId
		f472_arg2._itemPurchaseId = nil
		if f472_arg0.itemPurchaseId == f472_local0 and CanPurchaseItem(f472_arg1, f472_arg0) then
			OpenOverlay(f472_arg2, "PurchaseReservesItem", f472_arg1, {
				_model = f472_arg0:getModel(),
			})
		end
	end
end
CoD.BlackMarketUtility.SetupReservesRevealFailsafe = function(f473_arg0, f473_arg1, f473_arg2)
	if not f473_arg1._reservesRevealFailsafeTimer then
		f473_arg1._reservesRevealFailsafeTimer = LUI.UITimer.newElementTimer(f473_arg2 * 1000, true, function(f474_arg0)
			GoBack(f473_arg1, f473_arg0)
			local f474_local0 = 0
			local f474_local1 = Engine[@"getmodelforcontroller"](f473_arg0)
			f474_local1 = f474_local1:create("LootRNGResult")
			if f474_local1 and f474_local1.error_code then
				f474_local0 = f474_local1.error_code:get()
			end
			LuaUtils.UI_ShowErrorMessageDialog(f473_arg0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_78E11EA16D61A059", f474_local0), @"hash_4BDB5C4152F448EE")
		end)
		f473_arg1:addElement(f473_arg1._reservesRevealFailsafeTimer)
		if not f473_arg1._hasLootRNGResultSubscriptions then
			f473_arg1._hasLootRNGResultSubscriptions = true
			local f473_local0 = Engine[@"getmodelforcontroller"](f473_arg0)
			f473_arg1:subscribeToModel(f473_local0.LootRNGResult.ready, function(model)
				if f473_arg1._reservesRevealFailsafeTimer and model:get() then
					f473_arg1._reservesRevealFailsafeTimer:close()
					f473_arg1._reservesRevealFailsafeTimer = nil
				end
			end, false)
		end
	end
end
CoD.BlackMarketUtility.SetupReservesRevealSkipDelay = function(f476_arg0, f476_arg1, f476_arg2, f476_arg3)
	if not f476_arg1._reservesRevealSkipDelayTimer then
		local f476_local0 = Engine[@"getmodelforcontroller"](f476_arg0)
		f476_local0 = f476_local0:create("reservesRevealSkipAvailable")
		f476_local0:set(false)
		local f476_local1 = f476_arg2
		if f476_arg2 < f476_arg3 then
			f476_local1 = math.random(f476_arg2, f476_arg3)
		end
		f476_arg1._reservesRevealSkipDelayTimer = LUI.UITimer.newElementTimer(f476_local1, true, function(f477_arg0)
			if f476_arg1._reservesRevealSkipDelayTimer then
				f476_arg1._reservesRevealSkipDelayTimer:close()
				f476_arg1._reservesRevealSkipDelayTimer = nil
			end
			f476_local0:set(true)
		end)
		f476_arg1:addElement(f476_arg1._reservesRevealSkipDelayTimer)
	end
end
CoD.BlackMarketUtility.ShowBribeNotSpentNotification = function(f478_arg0)
	LuaUtils.UI_ShowInfoMessageDialog(f478_arg0, @"hash_1BB23B4A698BB414", @"hash_240E20A908411465")
end
CoD.BlackMarketUtility.UpdateLootCaseBreadcrumbStatValue = function(f479_arg0)
	local f479_local0 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f479_arg0, Enum[@"emodes"][@"mode_multiplayer"])
	if f479_local0 and f479_local0.lastLootCaseCountSeen then
		local f479_local1 = f479_local0.lastLootCaseCountSeen:get()
		local f479_local2 = CoDShared.Loot.GetLootCaseOwnedCount(f479_arg0)
		if f479_local2 ~= f479_local1 and f479_local2 > -1 then
			f479_local0.lastLootCaseCountSeen:set(f479_local2)
			Engine[@"storagewrite"](f479_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		end
	end
end
CoD.BlackMarketUtility.PlayReservesPreviewVideo = function(f480_arg0, f480_arg1, f480_arg2, f480_arg3)
	if not CoD.BlackMarketUtility.CanShowReservesPreview(f480_arg0) then
		return
	end
	local f480_local0 = Enum[@"hash_6C47FC1BD2E5CCEE"][@"hash_390B07394D69C5F4"]
	local f480_local1 = "core_frontend_rng_reserve"
	local f480_local2 = false
	local f480_local3 = false
	local f480_local4 = "VoDViewer"
	if f480_arg2 then
		f480_local4 = "SkippableVoDViewer"
	end
	local f480_local5 = DataSources.VoDViewer.getModel(f480_arg0)
	f480_local5.stream:set(CoD.VideoStreamingUtility.GetMoviePlayerParams(f480_local0, f480_local1, f480_local2, f480_local3))
	f480_arg1:addElement(LUI.UITimer.newElementTimer(80, true, function()
		LUI.OverrideFunction_CallOriginalFirst(
			OpenOverlay(f480_arg1, f480_local4, f480_arg0, {
				fullscreen = true,
			}),
			"close",
			function()
				if f480_arg3 then
					CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f480_arg0, true)
				end
			end
		)
	end))
end
CoD.BlackMarketUtility.ItemShopDetailsClientScriptMenuCloseNotify = function(f483_arg0, f483_arg1)
	SendClientScriptMenuChangeNotify(f483_arg0, f483_arg1, false)
	if f483_arg1.occludedMenu and f483_arg1.occludedMenu._currentTab == "reserves" then
		CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f483_arg0, true)
	end
end
CoD.BlackMarketUtility.ShowReservesReRollButton = function(f484_arg0, f484_arg1)
	local f484_local0 = Engine[@"getmodelforcontroller"](f484_arg0)
	f484_local0 = f484_local0.LootRNGResult.streamId:get()
	local f484_local1 = f484_arg1:getModel()
	local f484_local2 = f484_local1 and f484_local1.name
	if f484_local2 and f484_local2:get() == @"hash_1717FF140F30014C" then
		return true
	elseif f484_local0 == CoD.BlackMarketUtility.CrateStreams.CASE then
		return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f484_arg0, "ReservesItemCounts", "lootCaseCount", 0)
	elseif f484_local0 == CoD.BlackMarketUtility.CrateStreams.THREE_PACK then
		if f484_local1 and f484_local1.isBundleCrate and f484_local1.isBundleCrate:get() then
			return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f484_arg0, "ReservesItemCounts", "lootBundleCrateCount", 0)
		else
			return true
		end
	elseif CoD.BlackMarketUtility.IsBribeStackStream(f484_arg0) then
		return false
	elseif CoD.BlackMarketUtility.IsBribeMenuStream(f484_arg0) then
		if IsBooleanDvarSet(@"hash_78794D44313B8D66") then
			return true
		else
			return false
		end
	elseif CoD.BlackMarketUtility.IsBribeStream(f484_arg0) then
		return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f484_arg0, "ReservesItemCounts", "lootBribeCount", 0)
	else
		return false
	end
end
CoD.BlackMarketUtility.IsBribeStream = function(f485_arg0)
	local f485_local0 = Engine[@"getmodelforcontroller"](f485_arg0)
	f485_local0 = f485_local0.LootRNGResult.streamId:get()
	local f485_local1 = f485_local0 and Engine[@"converttoxhash"](f485_local0)
	if f485_local1 then
		return Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BribeTable.name, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH, f485_local1) ~= nil
	else
		return false
	end
end
CoD.BlackMarketUtility.IsBribeMenuOrBribeStackStream = function(f486_arg0)
	if CoD.BlackMarketUtility.IsBribeStackStream(f486_arg0) then
		return true
	elseif CoD.BlackMarketUtility.IsBribeMenuStream(f486_arg0) then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.IsBribeStackStream = function(f487_arg0)
	local f487_local0 = Engine[@"getmodelforcontroller"](f487_arg0)
	f487_local0 = f487_local0.LootRNGResult.streamId:get()
	for f487_local4, f487_local5 in ipairs(CoD.BlackMarketUtility.BribeStack) do
		if f487_local5.name == f487_local0 then
			CoD.BlackMarketUtility.SaveBribe(f487_arg0, f487_local0)
			return true
		end
	end
	return false
end
CoD.BlackMarketUtility.IsBribeMenuStream = function(f488_arg0)
	local f488_local0 = Engine[@"getmodelforcontroller"](f488_arg0)
	f488_local0 = f488_local0.LootRNGResult.streamId:get()
	if CoD.BlackMarketTableUtility.IsBribeMenu(f488_arg0, f488_local0) then
		CoD.BlackMarketUtility.SaveBribeMenuPurchase(f488_arg0, f488_local0)
		local f488_local1 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "BribeMenuTimer")
		if f488_local1 and f488_local1.cycled then
			f488_local1.cycled:set(true)
			f488_local1.cycled:forceNotifySubscriptions()
		end
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.CanSkipReservesRevealAnimation = function(f489_arg0)
	local f489_local0 = Engine[@"getmodelforcontroller"](f489_arg0)
	local f489_local1 = f489_local0.LootRNGResult.ready:get()
	if f489_local1 then
		if not f489_local0.LootRNGResult.allBribeItemsOwned:get() then
			f489_local1 = f489_local0.reservesRevealSkipAvailable:get()
			if f489_local1 then
				f489_local1 = not f489_local0.reservesRevealComplete:get()
			end
		else
			f489_local1 = false
		end
	end
	return f489_local1
end
CoD.BlackMarketUtility.ShowTierBoostPercent = function(f490_arg0, f490_arg1)
	if (Engine[@"getdvarint"](@"hash_E1CE7247C220196") or 0) == 0 then
		return false
	elseif (CoDShared.Loot.GetCurrentTierBoost(f490_arg0) or 0) > 0 then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent = function(f491_arg0, f491_arg1)
	if (Engine[@"getdvarint"](@"hash_E1CE7247C220196") or 0) == 0 then
		return false
	elseif (CoDShared.Loot.GetCurrentTierBoost(f491_arg0) or 0) >= CoDShared.Loot.GetMaxTierBoost() then
		return false
	else
		return true
	end
end
CoD.BlackMarketUtility.ShouldShowLootCaseBreadcrumb = function(f492_arg0)
	local f492_local0 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f492_arg0, Enum[@"emodes"][@"mode_multiplayer"])
	if f492_local0 and f492_local0.lastLootCaseCountSeen then
		return f492_local0.lastLootCaseCountSeen:get() < CoDShared.Loot.GetLootCaseOwnedCount(f492_arg0)
	else
		return false
	end
end
CoD.BlackMarketUtility.CanShowReservesPreview = function(f493_arg0)
	if CoD.isPC and not CoD.PCKoreaUtility.IsSeasonPromoVideoSafe() then
		return false
	else
		return not IsBooleanDvarSet(@"hash_671B81E101B4A9DB")
	end
end
CoD.BlackMarketUtility.GetRerollButtonString = function(f494_arg0, f494_arg1, f494_arg2)
	local f494_local0 = Engine[@"getmodelforcontroller"](f494_arg0)
	if f494_local0.LootRNGResult.streamId:get() == CoD.BlackMarketUtility.CrateStreams.CASE then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E98D63EA5A0BD3")
	elseif f494_arg1 and f494_arg1.isBundleCrate and f494_arg1.isBundleCrate:get() and CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f494_arg0) > 0 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E98D63EA5A0BD3")
	elseif CoD.BlackMarketUtility.IsBribeStream(f494_arg0) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E98D63EA5A0BD3")
	elseif f494_arg1 and f494_arg1.name and f494_arg1.name:get() == @"hash_1717FF140F30014C" then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_C2B10DCD9D6E876")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f494_arg2)
	end
end
CoD.BlackMarketUtility.GetTierBoostPercentString = function(f495_arg0, f495_arg1)
	return "+" .. f495_arg1 .. "% " .. Engine[@"hash_4F9F1239CFD921FE"](@"menu/tier_boost")
end
CoD.BlackMarketUtility.FreePromptTitleIfPriceIsZero = function(f496_arg0, f496_arg1)
	if f496_arg0 and not f496_arg0.price then
		return ConvertToUpperString(Engine[@"hash_4F9F1239CFD921FE"](f496_arg0.name:get()))
	else
		return ConvertToUpperString(f496_arg1)
	end
end
CoD.BlackMarketUtility.FreePromptDescIfPriceIsZero = function(f497_arg0, f497_arg1)
	if f497_arg0 and not f497_arg0.price then
		return f497_arg0.desc:get()
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f497_arg1)
	end
end
CoD.BlackMarketUtility.GetCrateBundleBonusString = function(f498_arg0)
	if f498_arg0 == 1 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_38A5D1F6E24A1926")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_38A59AF6E249BBB1", f498_arg0)
	end
end
CoD.BlackMarketUtility.GetMPItemPreviewImage = function(f499_arg0)
	local f499_local0 = Enum[@"emodes"][@"mode_multiplayer"]
	local f499_local1 = Engine[@"hash_2D97229B24C685D5"](f499_arg0, f499_local0)
	if not f499_local1 then
		f499_local1 = shared.EmptyItemIndex
	end
	local f499_local2 = CoD.CACUtility.GetUnlockableItemInfoField(f499_local1, f499_local0, "previewImage", nil)
	if not f499_local2 then
		return RegisterImage(@"blacktransparent")
	else
		return f499_local2
	end
end
CoD.BlackMarketUtility.GetMPItemPreviewImageLarge = function(f500_arg0)
	local f500_local0 = Enum[@"emodes"][@"mode_multiplayer"]
	local f500_local1 = Engine[@"hash_2D97229B24C685D5"](f500_arg0, f500_local0)
	if not f500_local1 then
		f500_local1 = shared.EmptyItemIndex
	end
	local f500_local2 = CoD.CACUtility.GetUnlockableItemInfoField(f500_local1, f500_local0, "previewImageLarge", nil)
	if not f500_local2 then
		return RegisterImage(@"blacktransparent")
	else
		return f500_local2
	end
end
CoD.BlackMarketUtility.InitialHideScrollPrompts = function(f501_arg0, f501_arg1, f501_arg2)
	if f501_arg2._initialHideComplete then
		return
	elseif f501_arg2.horizontalCounter then
		f501_arg2.updateHorizontalCounter = CoD.BlackMarketUtility.updateHorizontalCounter
		f501_arg2._initialHideComplete = true
	end
	if CoD.isPC then
		LUI.OverrideFunction_CallOriginalFirst(f501_arg0, "setState", function(element, controller, f502_arg2, f502_arg3, f502_arg4)
			f501_arg2:updateCounters()
		end)
	end
end
CoD.BlackMarketUtility.updateHorizontalCounter = function(f503_arg0, f503_arg1)
	if f503_arg1 then
		local f503_local0 = CoD.isPC and "DefaultState" or "NoPrompts"
		if f503_arg0.requestedColumnCount <= f503_arg0.hCount then
			f503_local0 = "AtLeftAndRight"
		elseif f503_arg0.hasListFocus then
			f503_local0 = "DefaultState"
		end
		if f503_arg1.currentItem then
			local f503_local1 = 1
			if f503_arg0.activeWidget then
				f503_local1 = f503_arg0.activeWidget.gridInfoTable.zeroBasedIndex + 1
			end
			f503_arg1.currentItem:setText(f503_local1)
		end
		if f503_arg1.count then
			local f503_local1 = f503_arg0.itemCount
			if not f503_local1 then
				f503_local1 = 0
			end
			f503_arg1.count:setText(f503_local1)
			if f503_local1 == 0 and f503_arg1.__clipsPerState and f503_arg1.__clipsPerState.NoItems then
				f503_local0 = "NoItems"
			end
		end
		f503_arg1:setState(f503_arg0.controller, f503_local0)
	end
end
CoD.BlackMarketUtility.ShopCycleThroughItems = function(f504_arg0, f504_arg1, f504_arg2, f504_arg3)
	f504_arg2._cycleTimer = LUI.UITimer.newElementTimer(CoD.BlackMarketUtility.GetBlackJacksShopCycleTime() * 1000, false, function(f505_arg0)
		if not f504_arg2._disableAutoScrolling then
			if f504_arg2.requestedColumnCount < 2 then
			elseif f504_arg2._skipNextAutoCycle then
				f504_arg2._skipNextAutoCycle = nil
			else
				if f504_arg2.activeWidget == nil then
					f504_arg2.activeWidget = f504_arg2:getItemAtPosition(1, 1, false)
				end
				if f504_arg2.activeWidget then
					f504_arg2.activeWidget:playClip("FadeOut")
					f504_arg2.activeWidget._fadeOutTimer = LUI.UITimer.newElementTimer(f504_arg3 * 1000, true, function(f506_arg0)
						if f504_arg2._disableAutoScrolling then
						elseif f504_arg2._skipNextAutoCycle then
							f504_arg2._skipNextAutoCycle = nil
						else
							f504_arg2:navigateItemRight(nil, true)
							f504_arg2:addElement(LUI.UITimer.newElementTimer(30, true, function(f507_arg0)
								CoD.FreeCursorUtility.RetriggerCursorPosition(f504_arg0, f504_arg1)
							end))
						end
					end)
					f504_arg2.activeWidget:addElement(f504_arg2.activeWidget._fadeOutTimer)
				else
					f504_arg2:navigateItemRight(nil, true)
					f504_arg2:addElement(LUI.UITimer.newElementTimer(30, true, function(f508_arg0)
						CoD.FreeCursorUtility.RetriggerCursorPosition(f504_arg0, f504_arg1)
					end))
				end
			end
		end
	end)
	f504_arg2._disableAutoScrolling = false
	f504_arg2:addElement(f504_arg2._cycleTimer)
end
CoD.BlackMarketUtility.IsShopListInFocus = function(f509_arg0, f509_arg1)
	if f509_arg1 and f509_arg1.activeWidget then
		return f509_arg1.activeWidget.__hasChildFocus
	else
		return false
	end
end
CoD.BlackMarketUtility.SetupBlackJackFrameContextualMenus = function(f510_arg0, f510_arg1)
	if not CoD.isPC then
		return
	elseif IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
		CoD.PCWidgetUtility.SetupContextualMenu(f510_arg0.DeterministicItemSlot1, f510_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f510_arg0.DeterministicItemSlot2, f510_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f510_arg0.RNGItemSlot, f510_arg1, "name", "", "")
	else
		CoD.PCWidgetUtility.SetupContextualMenu(f510_arg0.FeaturedSlot2, f510_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f510_arg0.FeaturedSlot1, f510_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f510_arg0.SpecialOrders, f510_arg1, "name", "", "")
	end
end
CoD.BlackMarketUtility.OnQuitBlackMarketCustomFunction = function(f511_arg0, f511_arg1)
	if not CoD.isPC or not f511_arg0._tab or not f511_arg0._tab.__onQuit then
		return
	else
		f511_arg0._tab.__onQuit()
	end
end
CoD.OverlayUtility.AddAutoDetectOverlay("AllReservesOwned", {
	title = @"hash_16FC360C6D9E776A",
	description = @"hash_DFECB316904F24D",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	options = function()
		return {
			{
				action = GoBack,
				text = @"menu/ok",
			},
		}
	end,
})
CoD.BlackMarketUtility.OpenAllReservesOwnedDialog = function(f513_arg0, f513_arg1)
	CoD.OverlayUtility.CreateOverlay(f513_arg1, f513_arg0, "AllReservesOwned")
end
DataSources.BlackMarketAvailableContractModes = ListHelper_SetupDataSource("BlackMarketAvailableContractModes", function(f514_arg0, f514_arg1)
	local f514_local0 = {}
	table.insert(f514_local0, {
		models = {
			name = "MENU/MULTIPLAYER",
		},
		properties = {
			_mode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP,
		},
	})
	table.insert(f514_local0, {
		models = {
			name = "MENU/WARZONE",
		},
		properties = {
			_mode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ,
		},
	})
	table.insert(f514_local0, {
		models = {
			name = "MENU/ZOMBIES",
		},
		properties = {
			_mode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM,
		},
	})
	return f514_local0
end, true)
DataSources.Contracts = {
	getModel = function(f515_arg0)
		return CoD.BlackMarketUtility.GetContractsRootModel(f515_arg0)
	end,
}
CoD.BlackMarketUtility.GetContractsRootModel = function(f516_arg0)
	local f516_local0 = Engine[@"getmodelforcontroller"](f516_arg0)
	return f516_local0:create("Contracts")
end
CoD.BlackMarketUtility.GetCurrentContractGameMode = function(f517_arg0)
	local f517_local0 = CoD.BlackMarketUtility.GetContractModeOverride(f517_arg0)
	if f517_local0 then
		return f517_local0
	end
	local f517_local1 = {
		[Enum[@"emodes"][@"mode_multiplayer"]] = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP,
		[Enum[@"emodes"][@"mode_warzone"]] = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ,
		[Enum[@"emodes"][@"mode_zombies"]] = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM,
	}
	local f517_local2 = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID
	if IsArenaMode() then
		f517_local2 = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WL
	else
		f517_local2 = f517_local1[Engine[@"currentsessionmode"]()] or CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID
	end
	return f517_local2
end
CoD.BlackMarketUtility.GetContractStateTable = function(f518_arg0, f518_arg1)
	if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
		local f518_local0 = @"hash_7222A2B349A0591D"
		local f518_local1 = Engine[@"gettablerowcount"](f518_local0)
		local f518_local2 = {}
		for f518_local3 = 1, f518_local1, 1 do
			local f518_local6 = f518_local3
			table.insert(f518_local2, Engine[@"hash_4C6F8EC444864600"](f518_local0, math.random(0, f518_local1 - 1), 0))
		end
		local f518_local3 = {
			version = 1,
			flags = 0,
			dailyExpiration = Engine[@"hash_2786FFC9E621CAB7"]() + 3600000,
			availableExpiration = Engine[@"hash_2786FFC9E621CAB7"]() + 3600000,
		}
		local f518_local4 = function()
			return {
				id = f518_local2[math.random(1, #f518_local2)],
				progress = math.random(0, 50),
				target = math.random(0, 50),
				flags = 0,
				xpAmount = math.random(1, 25) * 100,
				reward = {
					id = 0,
					type = 1,
					amount = 1,
				},
			}
		end
		local f518_local5 = 1
		local f518_local6 = 3
		local f518_local7 = 6
		f518_local3.dailyContracts = {}
		f518_local3.pinnedContracts = {}
		f518_local3.availableContracts = {}
		if f518_arg1 then
			for f518_local8 = 1, f518_local5, 1 do
				f518_local3.dailyContracts[f518_local8] = f518_local4()
			end
			for f518_local8 = 1, f518_local6, 1 do
				f518_local3.pinnedContracts[f518_local8] = f518_local4()
			end
			for f518_local8 = 1, f518_local7, 1 do
				f518_local3.availableContracts[f518_local8] = f518_local4()
			end
		else
			for f518_local8 = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP, CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ, 1 do
				f518_local3.dailyContracts[f518_local8] = {}
				for f518_local11 = 1, f518_local5, 1 do
					f518_local3.dailyContracts[f518_local8][f518_local11] = f518_local4()
				end
				f518_local3.pinnedContracts[f518_local8] = {}
				for f518_local11 = 1, f518_local6, 1 do
					f518_local3.pinnedContracts[f518_local8][f518_local11] = f518_local4()
				end
				f518_local3.availableContracts[f518_local8] = {}
				for f518_local11 = 1, f518_local7, 1 do
					f518_local3.availableContracts[f518_local8][f518_local11] = f518_local4()
				end
			end
		end
		return f518_local3
	elseif f518_arg1 then
		return Engine[@"hash_1DC39182CB1C9BE4"](f518_arg0, f518_arg1)
	else
		return Engine[@"hash_292C69F543736D04"](f518_arg0)
	end
end
DataSources.BlackMarketAvailableContracts = ListHelper_SetupDataSource("BlackMarketAvailableContracts", function(f520_arg0, f520_arg1)
	local f520_local0 = {}
	if CoDShared.LootContracts.IsEnabled(f520_arg0) then
		local f520_local1 = f520_arg1._mode
		if not f520_local1 then
			f520_local1 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f520_arg0)
		end
		local f520_local2 = CoD.BlackMarketUtility.GetContractStateTable(f520_arg0, f520_local1)
		if CoDShared.LootContracts.IsLootContractTableValid(f520_local2) then
			local f520_local3 = f520_local2.availableContracts
			if f520_local3 then
				for f520_local8, f520_local9 in ipairs(f520_local3) do
					if (CoDShared.IsBitSet(f520_local9.flags, Enum[@"hash_B40A0B507A68068"][@"hash_F26C5D1872ABE11"]) or CoD.BaseUtility.IsDvarEnabled("lootContracts_forceReady")) and f520_local1 == CoDShared.LootContracts.GetContractsGameMode(f520_local9.id) then
						local f520_local7 = CoD.BlackMarketUtility.GetContractModelsForContractInfo(f520_local9)
						if f520_local7 then
							if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
								f520_local7.progress = math.random(0, f520_local7.target)
								f520_local7.progressRatio = f520_local7.progress / f520_local7.target
								f520_local7.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E002923E581C57D", f520_local7.progress, f520_local7.target)
							end
							if CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f520_arg0) then
								f520_local7.xpReward = f520_local7.xpReward * 2
							end
							table.insert(f520_local0, {
								models = f520_local7,
							})
						end
					end
				end
				table.sort(f520_local0, function(f521_arg0, f521_arg1)
					return f521_arg0.models.difficulty < f521_arg1.models.difficulty
				end)
			end
		end
	end
	return f520_local0
end, true)
DataSources.BlackMarketActiveContracts = ListHelper_SetupDataSource("BlackMarketActiveContracts", function(f522_arg0, f522_arg1)
	local f522_local0 = {}
	if CoDShared.LootContracts.IsEnabled(f522_arg0) then
		local f522_local1 = f522_arg1._mode
		if not f522_local1 then
			f522_local1 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f522_arg0)
		end
		local f522_local2 = CoD.BlackMarketUtility.GetContractStateTable(f522_arg0, f522_local1)
		if CoDShared.LootContracts.IsLootContractTableValid(f522_local2) then
			local f522_local3 = function(f523_arg0)
				local f523_local0 = CoD.BlackMarketUtility.GetContractModelsForContractInfo(f523_arg0)
				if f523_local0 then
					if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
						f523_local0.progress = math.random(0, f523_local0.target)
						f523_local0.progressRatio = f523_local0.progress / f523_local0.target
						f523_local0.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E002923E581C57D", f523_local0.progress, f523_local0.target)
					end
					if CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f522_arg0) then
						f523_local0.xpReward = f523_local0.xpReward * 2
					end
					table.insert(f522_local0, {
						models = f523_local0,
					})
				end
			end
			local f522_local4 = f522_local2.dailyContracts
			if f522_local4 then
				f522_local3(f522_local4[1])
			end
			local f522_local5 = f522_local2.pinnedContracts
			if f522_local5 then
				for f522_local9, f522_local10 in ipairs(f522_local5) do
					if CoDShared.IsBitSet(f522_local10.flags, Enum[@"hash_B40A0B507A68068"][@"hash_F26C5D1872ABE11"]) or CoD.BaseUtility.IsDvarEnabled("lootContracts_forceReady") then
						f522_local3(f522_local10)
					end
				end
				f522_local6 = 2 - #f522_local5
				for f522_local7 = 1, f522_local6, 1 do
					f522_local10 = f522_local7
					table.insert(f522_local0, {
						models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
					})
				end
			end
		else
			for f522_local3 = 1, 3, 1 do
				local f522_local6 = f522_local3
				table.insert(f522_local0, {
					models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
				})
			end
		end
	end
	return f522_local0
end, true)
CoD.BlackMarketUtility.GetContractsModelTable = function(f524_arg0, f524_arg1)
	local f524_local0 = {}
	if CoDShared.LootContracts.IsEnabled(f524_arg0) then
		local f524_local1 = CoD.BlackMarketUtility.GetContractsRootModel(f524_arg0)
		local f524_local2 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f524_arg0)
		local f524_local3 = CoD.BlackMarketUtility.GetContractStateTable(f524_arg0, f524_local2)
		if CoDShared.LootContracts.IsLootContractTableValid(f524_local3) then
			local f524_local4 = f524_local3[f524_arg1]
			if f524_local4 then
				for f524_local9, f524_local10 in ipairs(f524_local4) do
					if CoDShared.IsBitSet(f524_local10.flags, Enum[@"hash_B40A0B507A68068"][@"hash_F26C5D1872ABE11"]) or CoD.BaseUtility.IsDvarEnabled("lootContracts_forceReady") then
						local f524_local8 = CoD.BlackMarketUtility.GetContractModelsForContractInfo(f524_local10)
						if f524_local8 then
							if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
								f524_local8.progress = math.random(0, f524_local8.target)
								f524_local8.progressRatio = f524_local8.progress / f524_local8.target
								f524_local8.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E002923E581C57D", f524_local8.progress, f524_local8.target)
							end
							if f524_arg1 == "dailyContracts" and f524_local2 == CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM then
								f524_local8.isDailyZombies = true
							end
							if CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f524_arg0) then
								f524_local8.xpReward = f524_local8.xpReward * 2
							end
							table.insert(f524_local0, {
								models = f524_local8,
							})
						end
					end
					table.insert(f524_local0, {
						models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
					})
				end
			end
			local f524_local5 = f524_local1:create("contractsAvailable")
			f524_local5:set(true)
		else
			local f524_local4 = {
				dailyContracts = 1,
				pinnedContracts = 2,
				availableContracts = 6,
			}
			local f524_local5 = f524_local4[f524_arg1]
			if not f524_local5 then
				f524_local5 = 1
			end
			for f524_local6 = 1, f524_local5, 1 do
				local f524_local10 = f524_local6
				table.insert(f524_local0, {
					models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
				})
			end
			local f524_local6 = f524_local1:create("contractsAvailable")
			f524_local6:set(false)
		end
	end
	return f524_local0
end
CoD.BlackMarketUtility.GetEmptyContractModelsTable = function()
	return {
		id = 0,
		contractMode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID,
		displayName = @"hash_0",
		description = "",
		contractIcon = @"blacktransparent",
		displayMode = 0,
		difficulty = 0,
		target = 0,
		progress = 0,
		progressRatio = 0,
		progressRatioIngame = 0,
		progressRatioText = "",
		xpReward = 0,
		rewardType = 0,
		rewardAmount = 0,
		rewardIcon = @"blacktransparent",
		rewardDisplay = "",
		isDailyZombies = false,
		active = false,
		completed = false,
	}
end
CoD.BlackMarketUtility.GetContractModelsForContractInfo = function(f526_arg0)
	if f526_arg0.id == 0 then
		return CoD.BlackMarketUtility.GetEmptyContractModelsTable()
	end
	local f526_local0 = {
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP] = @"menu/multiplayer",
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WL] = @"menu/arena",
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ] = @"menu/warzone",
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM] = @"menu/zombies",
	}
	local f526_local1 = f526_arg0.id
	local f526_local2 = CoDShared.LootContracts.GetContractsGameMode(f526_local1)
	if f526_local2 == CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID then
		return CoD.BlackMarketUtility.GetEmptyContractModelsTable()
	end
	local f526_local3 = CoDShared.LootContracts.GetContractsDifficulty(f526_local1)
	local f526_local4 = f526_arg0.target
	local f526_local5 = CoDShared.LootContracts.GetContractDescription(f526_local1)
	local f526_local6 = CoDShared.LootContracts.GetContractsCategoryHash(f526_local1)
	local f526_local7 = f526_arg0.xpAmount
	local f526_local8 = f526_arg0.reward.amount
	local f526_local9 = f526_arg0.reward.type
	local f526_local10 = f526_arg0.reward.id
	local f526_local11 = f526_arg0.progress
	local f526_local12 = f526_local0[f526_local2] or 0x0
	local f526_local13 = @"blacktransparent"
	local f526_local14 = ""
	if f526_local9 == 1 then
		if f526_local8 and f526_local8 > 0 then
			f526_local13 = @"ui_icon_blackmarket_reserves_case_small"
			local f526_local15
			if f526_local8 > 1 then
				f526_local15 = @"hash_8FD4B5379066B7A"
				if not f526_local15 then
				else
					f526_local14 = Engine[@"hash_4F9F1239CFD921FE"](f526_local15, f526_local8)
				end
			end
			f526_local15 = @"hash_2C18D8F7DBC9D643"
		end
	elseif f526_local9 == 3 and f526_local10 == "21" and f526_local8 and f526_local8 > 0 then
		f526_local13 = @"ui_icon_nebulium_medium"
		f526_local14 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F251843889153EE", f526_local8)
	end
	local f526_local15 = @"blacktransparent"
	if f526_local6 == @"play" then
		f526_local15 = CoD.ContractUtility.GetLootContractIcon(f526_local6, f526_local2)
	else
		f526_local15 = CoD.ContractUtility.GetLootContractIcon(f526_local6, f526_local3)
	end
	return {
		id = f526_local1,
		contractMode = f526_local2,
		displayName = CoDShared.LootContracts.GetContractTitle(f526_local1),
		description = Engine[@"hash_4F9F1239CFD921FE"](f526_local5, f526_local4),
		contractIcon = f526_local15,
		displayMode = f526_local12,
		difficulty = f526_local3,
		target = f526_local4,
		progress = f526_local11,
		progressRatio = f526_local11 / f526_local4,
		progressRatioIngame = 0,
		progressRatioText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E002923E581C57D", f526_local11, f526_local4),
		xpReward = f526_local7,
		rewardType = f526_local9,
		rewardAmount = f526_local8,
		rewardIcon = f526_local13,
		rewardDisplay = f526_local14,
		isDailyZombies = false,
		active = CoDShared.IsBitSet(f526_arg0.flags, Enum[@"hash_B40A0B507A68068"][@"hash_6F7D0F1F6F551B94"]),
		completed = f526_local4 <= f526_local11,
	}
end
CoD.BlackMarketUtility.UpdateActiveContractSlotsModels = function(f527_arg0, f527_arg1)
	local f527_local0 = CoD.BlackMarketUtility.GetContractsRootModel(f527_arg0)
	local f527_local1 = function(f528_arg0, f528_arg1)
		local f528_local0 = f527_local0:create(f528_arg0)
		if f528_arg1 and f528_arg1.models then
			local f528_local1 = f528_arg1.models
			if f527_arg1 then
				local f528_local2 = CoD.BlackMarketUtility.GetContractsInGameModelRoot(f527_arg0)
				local f528_local3 = f528_local2[f528_arg0]
				if f528_local3 and f528_local3.id and f528_local3.progressStart and f528_local3.progressEnd and f528_local3.id:get() == f528_local1.id then
					local f528_local4 = f528_local3.progressStart:get()
					local f528_local5 = f528_local3.progressEnd:get()
					local f528_local6 = f528_local1.target
					f528_local1.progress = f528_local4
					f528_local1.progressRatio = f528_local4 / f528_local6
					f528_local1.progressRatioIngame = f528_local5 / f528_local6
					f528_local1.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E002923E581C57D", f528_local5, f528_local6)
					f528_local1.completed = f528_local6 <= f528_local5
				end
			end
			LuaUtils.CreateModelsFromTable(f528_local0, f528_local1)
		else
			LuaUtils.CreateModelsFromTable(f528_local0, CoD.BlackMarketUtility.GetEmptyContractModelsTable())
		end
	end
	local f527_local2 = CoD.BlackMarketUtility.GetContractsModelTable(f527_arg0, "dailyContracts")
	f527_local1("dailyActive", f527_local2[1])
	local f527_local3 = CoD.BlackMarketUtility.GetContractsModelTable(f527_arg0, "pinnedContracts")
	f527_local1("contractSlot1", f527_local3[1])
	f527_local1("contractSlot2", f527_local3[2])
end
CoD.BlackMarketUtility.UpdateActiveContractSlotModelsForAAR = function(f529_arg0)
	local f529_local0 = CoD.BlackMarketUtility.GetContractsRootModel(f529_arg0)
	local f529_local1 = function(f530_arg0, f530_arg1)
		local f530_local0 = f529_local0:create(f530_arg0)
		if f530_arg1 and f530_arg1.models then
			local f530_local1 = f530_arg1.models
			local f530_local2 = CoD.BlackMarketUtility.GetContractsInGameModelRoot(f529_arg0)
			local f530_local3 = f530_local2[f530_arg0]
			if f530_local3 and f530_local3.id and f530_local3.progressStart and f530_local3.progressEnd and f530_local3.id:get() == f530_local1.id then
				local f530_local4 = f530_local3.progressStart:get()
				local f530_local5 = f530_local3.progressEnd:get()
				local f530_local6 = f530_local1.target
				f530_local1.progress = f530_local4
				f530_local1.progressRatio = f530_local4 / f530_local6
				f530_local1.progressRatioIngame = f530_local5 / f530_local6
				f530_local1.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E002923E581C57D", f530_local5, f530_local6)
				f530_local1.completed = f530_local6 <= f530_local5
			end
			LuaUtils.CreateModelsFromTable(f530_local0, f530_local1)
			if not CoD.BlackMarketUtility.ContractAARModels[f530_arg0] then
				CoD.BlackMarketUtility.ContractAARModels[f530_arg0] = f530_arg1
			end
		else
			local f530_local1 = CoD.BlackMarketUtility.GetEmptyContractModelsTable()
			LuaUtils.CreateModelsFromTable(f530_local0, f530_local1)
			if not CoD.BlackMarketUtility.ContractAARModels[f530_arg0] then
				CoD.BlackMarketUtility.ContractAARModels[f530_arg0] = {
					models = f530_local1,
				}
			end
		end
	end
	if not CoD.BlackMarketUtility.ContractAARModels then
		CoD.BlackMarketUtility.ContractAARModels = {}
		local f529_local2 = CoD.BlackMarketUtility.GetContractsModelTable(f529_arg0, "dailyContracts")
		f529_local1("dailyActive", f529_local2[1])
		local f529_local3 = CoD.BlackMarketUtility.GetContractsModelTable(f529_arg0, "pinnedContracts")
		f529_local1("contractSlot1", f529_local3[1])
		f529_local1("contractSlot2", f529_local3[2])
	else
		f529_local1("dailyActive", CoD.BlackMarketUtility.ContractAARModels.dailyActive)
		f529_local1("contractSlot1", CoD.BlackMarketUtility.ContractAARModels.contractSlot1)
		f529_local1("contractSlot2", CoD.BlackMarketUtility.ContractAARModels.contractSlot2)
	end
end
CoD.BlackMarketUtility.PinContract = function(f531_arg0, f531_arg1, f531_arg2, f531_arg3)
	local f531_local0 = f531_arg2._contractSlot
	local f531_local1 = f531_arg3 or f531_arg1:getModel()
	if f531_local0 and f531_local1 then
		local f531_local2 = f531_local1.id:get()
		local f531_local3 = f531_local1.contractMode:get()
		if f531_local2 and f531_local3 then
			CoD.LootContractsUtility.UpdatePinnedContracts(f531_arg0, f531_local3, f531_local0, f531_local2)
		end
	end
end
CoD.BlackMarketUtility.SetupContractAvailabilityTimers = function(f532_arg0, f532_arg1)
	local f532_local0 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f532_arg0)
	local f532_local1 = CoD.BlackMarketUtility.GetContractsRootModel(f532_arg0)
	local f532_local2 = f532_local1:create("dailyContractsExpired")
	local f532_local3 = f532_local1:create("availableContractsExpired")
	f532_local2:set(false)
	f532_local3:set(false)
	local f532_local4 = CoD.BlackMarketUtility.GetContractStateTable(f532_arg0, f532_local0)
	if f532_local4 then
		local f532_local5 = f532_local1:create("dailyExpirationTime")
		local f532_local6 = f532_local1:create("availableExpirationTime")
		if f532_arg1._availabilityTimer then
			f532_arg1._availabilityTimer:close()
			f532_arg1._availabilityTimer = nil
		end
		if Engine[@"getsecondsremainingserver"](f532_local4.dailyExpirationStr or 0) > 0 and Engine[@"getsecondsremainingserver"](f532_local4.availableExpirationStr or 0) > 0 then
			f532_arg1._availabilityTimer = LUI.UITimer.newElementTimer(500, false, function(f533_arg0)
				local f533_local0 = Engine[@"getsecondsremainingserver"](f532_local4.dailyExpirationStr or 0)
				local f533_local1 = Engine[@"getsecondsremainingserver"](f532_local4.availableExpirationStr or 0)
				if f533_local0 > 0 then
					f532_local5:set(LuaUtils.SecondsToTimeRemainingString(f533_local0))
				else
					f532_local2:set(true)
					CoD.OverlayUtility.ShowToast("Content", Engine[@"hash_4F9F1239CFD921FE"](0xA340B260A01392), "")
					Engine[@"playsound"]("uin_points_confirmed")
					CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f532_arg0, f532_arg1)
				end
				if f533_local1 > 0 then
					f532_local6:set(LuaUtils.SecondsToTimeRemainingString(f533_local1))
				else
					f532_local3:set(true)
					CoD.OverlayUtility.ShowToast("Content", Engine[@"hash_4F9F1239CFD921FE"](@"hash_73ADF7B901A76D85"), "")
					Engine[@"playsound"]("uin_points_confirmed")
					CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f532_arg0, f532_arg1)
				end
			end)
		else
			f532_arg1._availabilityTimer = LUI.UITimer.newElementTimer(1000, false, function(f534_arg0)
				f532_local5:set("")
				f532_local6:set("")
				CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f532_arg0, f532_arg1)
			end)
		end
		f532_arg1:addElement(f532_arg1._availabilityTimer)
	end
end
CoD.BlackMarketUtility.SetupDailyContractTimer = function(f535_arg0, f535_arg1)
	local f535_local0 = CoD.BlackMarketUtility.GetContractsRootModel(f535_arg0)
	local f535_local1 = CoD.BlackMarketUtility.GetContractStateTable(f535_arg0, CoD.BlackMarketUtility.GetCurrentContractGameMode(f535_arg0))
	if f535_local1 then
		local f535_local2 = f535_local0:create("dailyExpirationTime")
		if f535_arg1._dailyContractTimer then
			f535_arg1._dailyContractTimer:close()
			f535_arg1._dailyContractTimer = nil
		end
		if Engine[@"getsecondsremainingserver"](f535_local1.dailyExpirationStr or 0) > 0 then
			f535_arg1._dailyContractTimer = LUI.UITimer.newElementTimer(500, false, function(f536_arg0)
				local f536_local0 = Engine[@"getsecondsremainingserver"](f535_local1.dailyExpirationStr or 0)
				if f536_local0 > 0 then
					f535_local2:set(LuaUtils.SecondsToTimeRemainingString(f536_local0))
				else
					CoD.BlackMarketUtility.SetupDailyContractTimer(f535_arg0, f535_arg1)
				end
			end)
			if InFrontend() then
				CoD.BlackMarketUtility.UpdateActiveContractSlotModelsForAAR(f535_arg0)
			else
				CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f535_arg0, true)
			end
		else
			f535_arg1._dailyContractTimer = LUI.UITimer.newElementTimer(1000, false, function(f537_arg0)
				f535_local2:set("")
				CoD.BlackMarketUtility.SetupDailyContractTimer(f535_arg0, f535_arg1)
			end)
		end
		f535_arg1:addElement(f535_arg1._dailyContractTimer)
	end
end
CoD.BlackMarketUtility.ClearContractRetryTimer = function(f538_arg0, f538_arg1)
	if f538_arg1._contractRetryTimer then
		f538_arg1._contractRetryTimer:close()
		f538_arg1._contractRetryTimer = nil
	end
end
CoD.BlackMarketUtility.SetupContractRetryTimer = function(f539_arg0, f539_arg1)
	CoD.BlackMarketUtility.ClearContractRetryTimer(f539_arg0, f539_arg1)
	f539_arg1._contractRetryTimer = LUI.UITimer.newElementTimer(3000, false, function(f540_arg0)
		CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f539_arg0, false)
	end)
	f539_arg1:addElement(f539_arg1._contractRetryTimer)
end
CoD.BlackMarketUtility.GetContractHeaderStringFromLobbyMainMode = function(f541_arg0, f541_arg1)
	local f541_local0 = ""
	local f541_local1 = CoD.BlackMarketUtility.GetContractModeOverride(f541_arg0)
	if f541_local1 then
		local f541_local2 = {
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP] = @"menu/multiplayer",
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WL] = @"menu/arena",
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ] = @"menu/warzone",
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM] = @"menu/zombies",
		}
		local f541_local3 = f541_local2[f541_local1]
		if f541_local3 then
			f541_local0 = LocalizeIntoStringIfNotEmpty(@"hash_5AD22176FB154E74", f541_local3)
		end
		return ToUpper(f541_local0)
	elseif LuaUtils.IsArenaMode() then
		f541_local0 = LocalizeIntoStringIfNotEmpty(@"hash_5AD22176FB154E74", @"menu/arena")
	else
		f541_local0 = LocalizeIntoStringIfNotEmpty(@"hash_5AD22176FB154E74", CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f541_arg1))
	end
	return ToUpper(f541_local0)
end
CoD.BlackMarketUtility.GetContractModeOverride = function(f542_arg0)
	return f542_local0.modeOverride and f542_local1 and f542_local0.modeOverride:get()
end
CoD.BlackMarketUtility.ClearContractModeOverride = function(f543_arg0)
	local f543_local0 = DataSources.LootContracts.getModel(f543_arg0)
	if f543_local0 and f543_local0.modeOverride then
		Engine[@"unsubscribeandfreemodel"](f543_local0.modeOverride)
	end
end
CoD.BlackMarketUtility.IsActiveContractAvailable = function(f544_arg0, f544_arg1, f544_arg2)
	local f544_local0 = f544_arg2._contractSlot
	if f544_local0 then
		local f544_local1 = CoD.BlackMarketUtility.GetContractsModelTable(f544_arg0, "pinnedContracts")
		local f544_local2 = f544_local1[f544_local0]
		local f544_local3
		if f544_local2 then
			f544_local3 = f544_local2.models.id
			if not f544_local3 then
			else
				if f544_local3 == 0 then
					return true
				end
				for f544_local7, f544_local8 in ipairs(CoD.BlackMarketUtility.GetContractsModelTable(f544_arg0, "availableContracts")) do
					if f544_local8.models.id == f544_local3 then
						return true
					end
				end
			end
		end
		f544_local3 = 0
	end
	return false
end
CoD.BlackMarketUtility.IsActiveContractCompleted = function(f545_arg0, f545_arg1, f545_arg2)
	local f545_local0 = f545_arg2._contractSlot
	if f545_local0 then
		return f545_local2.models and f545_local3 and f545_local2.models.completed
	else
		return false
	end
end
CoD.BlackMarketUtility.ClearCompletedActiveContracts = function(f546_arg0, f546_arg1)
	f546_arg1._clearContractTimer = LUI.UITimer.newElementTimer(4000, true, function(f547_arg0)
		for f547_local4, f547_local5 in ipairs(CoD.BlackMarketUtility.GetContractsModelTable(f546_arg0, "pinnedContracts")) do
			local f547_local6 = f547_local5 and f547_local5.models
			if f547_local6 and f547_local6.completed then
				local f547_local3 = f547_local6.contractMode
				if f547_local3 then
					CoD.LootContractsUtility.UpdatePinnedContracts(f546_arg0, f547_local3, f547_local4, 0)
				end
			end
		end
	end)
	f546_arg1:addElement(f546_arg1._clearContractTimer)
end
DataSources.ContractReplacementOptions = ListHelper_SetupDataSource("ContractReplacementOptions", function(f548_arg0, f548_arg1)
	local f548_local0 = {}
	table.insert(f548_local0, {
		models = {
			displayText = Engine[@"localize"](@"menu/contract_activate"),
		},
		properties = {
			action = function(f549_arg0, f549_arg1, f549_arg2, f549_arg3)
				CoD.BlackMarketUtility.PinContract(f549_arg2, f549_arg1, f548_arg1.menu, f548_arg1.menu._selectedModel)
				GoBackToMenu(f548_arg1.menu, f549_arg2, "BlackMarketContracts")
			end,
		},
	})
	if not CoD.isPC then
		table.insert(f548_local0, {
			models = {
				displayText = Engine[@"localize"](@"menu/cancel"),
			},
			properties = {
				action = function(f550_arg0, f550_arg1, f550_arg2, f550_arg3)
					GoBack(f548_arg1.menu, f550_arg2)
				end,
			},
		})
	end
	return f548_local0
end)
CoD.BlackMarketUtility.GetContractsInGameModelRoot = function(f551_arg0)
	local f551_local0 = Engine[@"getmodelforcontroller"](f551_arg0)
	return f551_local0:create("ContractsInGame", true)
end
CoD.BlackMarketUtility.InitInGameContractRecord = function(f552_arg0, f552_arg1)
	local f552_local0 = CoD.BlackMarketUtility.GetContractsInGameModelRoot(f552_arg0)
	f552_arg1._activeContracts = {}
	local f552_local1 = function(f553_arg0, f553_arg1)
		local f553_local0 = f552_local0:create(f553_arg0, true)
		if f553_arg1 and f553_arg1.models then
			local f553_local1 = f553_arg1.models
			local f553_local2 = f553_local1.id
			local f553_local3 = f553_local1.progress
			local f553_local4 = f553_local0:create("id", true)
			f553_local4:set(f553_local2)
			f553_local4 = f553_local0:create("progressStart", true)
			f553_local4:set(f553_local3)
			f553_local4 = f553_local0:create("progressEnd", true)
			f553_local4:set(f553_local3)
			f553_local4 = f553_local0:create("completed", true)
			f553_local4:set(false)
			f552_arg1._activeContracts[f553_local1.id] = f553_local0
		else
			local f553_local1 = f553_local0:create("id", true)
			f553_local1:set(0)
			f553_local1 = f553_local0:create("progressStart", true)
			f553_local1:set(0)
			f553_local1 = f553_local0:create("progressEnd", true)
			f553_local1:set(0)
			f553_local1 = f553_local0:create("completed", true)
			f553_local1:set(false)
		end
	end
	local f552_local2 = CoD.BlackMarketUtility.GetContractsModelTable(f552_arg0, "dailyContracts")
	f552_local1("dailyActive", f552_local2[1])
	local f552_local3 = CoD.BlackMarketUtility.GetContractsModelTable(f552_arg0, "pinnedContracts")
	f552_local1("contractSlot1", f552_local3[1])
	f552_local1("contractSlot2", f552_local3[2])
end
CoD.BlackMarketUtility.UpdateInGameContractRecord = function(f554_arg0, f554_arg1, f554_arg2)
	local f554_local0 = CoD.GetScriptNotifyData(f554_arg1)
	local f554_local1 = f554_local0[1]
	local f554_local2 = f554_local0[2]
	local f554_local3 = f554_arg2._activeContracts
	if f554_local3 then
		local f554_local4 = f554_local3[f554_local1]
		if f554_local4 then
			local f554_local5 = f554_local4:create("progressEnd", true)
			f554_local5:set(f554_local2)
		end
	end
	CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f554_arg0, true)
end
CoD.BlackMarketUtility.RecordCompletedContractInGame = function(f555_arg0, f555_arg1, f555_arg2)
	local f555_local0 = CoD.GetScriptNotifyData(f555_arg1)
	local f555_local1 = f555_local0[1]
	local f555_local2 = f555_arg2._activeContracts
	if f555_local2 then
		local f555_local3 = f555_local2[f555_local1]
		if f555_local3 then
			local f555_local4 = f555_local3:create("completed", true)
			f555_local4:set(true)
		end
	end
end
CoD.BlackMarketUtility.DelayedContractReveal = function(f556_arg0, f556_arg1)
	if f556_arg1._revealTimer then
		f556_arg1._revealTimer:close()
		f556_arg1._revaalTimer = nil
	end
	f556_arg1._revealTimer = LUI.UITimer.newElementTimer(250, true, function(f557_arg0)
		PlayClipOnElement(f556_arg1, {
			elementName = "BMContractReveal",
			clipName = "New",
		}, f556_arg0)
	end)
	f556_arg1:addElement(f556_arg1._revealTimer)
end
DataSources.BribeStackList = ListHelper_SetupDataSource(
	"BribeStackList",
	function(f558_arg0)
		local f558_local0 = {}
		for f558_local4, f558_local5 in ipairs(CoD.BlackMarketUtility.BribeStack) do
			local f558_local6 = CoD.BlackMarketUtility.GetBribeAsset(f558_arg0, f558_local5.hashName)
			local f558_local7 = CoD.BlackMarketTableUtility.GetBribeCPAndCasePrice(f558_arg0, f558_local5.hashName)
			local f558_local8 = Engine[@"getsecondsremainingserver"](f558_local5.nextAvailableTime) > 0
			if f558_local7 and f558_local6 then
				table.insert(f558_local0, {
					models = {
						name = f558_local6.name,
						desc = f558_local6.desc,
						price = f558_local7.price,
						casePrice = f558_local7.casePrice,
						popupImage = f558_local6.popupImage,
						stackImage = f558_local6.stackImage,
						stackTallImage = f558_local6.stackTallImage,
						lootRule = f558_local5.lootRule,
						timer = f558_local5.name,
						purchased = f558_local8,
						hashName = f558_local5.hashName,
						slot = 4,
						percentOff = 0,
					},
				})
			end
		end
		return f558_local0
	end,
	nil,
	nil,
	function(f559_arg0, f559_arg1, f559_arg2)
		if not f559_arg1.__bribeStackSubscriptions then
			f559_arg1.__bribeStackSubscriptions = true
			f559_arg1:subscribeToGlobalModel(f559_arg0, "BribeStackTimer", "cycled", function()
				f559_arg1:updateDataSource()
			end)
		end
	end
)
DataSources.BribeMenuList = ListHelper_SetupDataSource(
	"BribeMenuList",
	function(f561_arg0)
		local f561_local0 = {}
		local f561_local1 = @"bribe_menu_asset"
		local f561_local2 = CoD.BlackMarketUtility.GetBribeAsset(f561_arg0, f561_local1)
		local f561_local3 = CoD.BlackMarketTableUtility.GetWeaponBribeSelectionBribes(f561_arg0)
		local f561_local4 = f561_local3[1]
		local f561_local5 = Engine[@"getsecondsremainingserver"](Engine[@"hash_6D80580D17461096"](f561_arg0, CoD.BlackMarketUtility.BribeMenuLootRule)) > 0
		if f561_local4 and f561_local2 and IsBooleanDvarSet(@"hash_437458347055B83") then
			table.insert(f561_local0, {
				models = {
					name = f561_local2.name,
					desc = f561_local2.desc,
					price = f561_local4.price,
					casePrice = f561_local4.optionalCost,
					popupImage = f561_local2.popupImage,
					stackImage = f561_local2.stackImage,
					stackTallImage = f561_local2.stackTallImage,
					lootRule = CoD.BlackMarketUtility.BribeMenuLootRule,
					timer = "bribe_menu_timer",
					purchased = f561_local5,
					hashName = f561_local1,
					slot = 4,
				},
			})
		end
		return f561_local0
	end,
	nil,
	nil,
	function(f562_arg0, f562_arg1, f562_arg2)
		if not f562_arg1.__bribeMenuSubscriptions then
			f562_arg1.__bribeMenuSubscriptions = true
			f562_arg1:subscribeToGlobalModel(f562_arg0, "BribeMenuTimer", "cycled", function()
				f562_arg1:updateDataSource()
			end)
		end
	end
)
DataSources.NoDupeBribeStack = ListHelper_SetupDataSource(
	"NoDupeBribeStack",
	function(f564_arg0)
		local f564_local0 = {}
		local f564_local1 = @"no_dupe_crate"
		local f564_local2 = 0
		if IsBooleanDvarSet(@"hash_648522A533967154") then
			f564_local1 = @"half_off_no_dupe_crate"
			f564_local2 = 50
		end
		local f564_local3 = CoD.BlackMarketTableUtility.GetBribeInformation(f564_arg0, f564_local1)
		if f564_local3 then
			local f564_local4 = CoD.BlackMarketUtility.GetBribeAsset(f564_arg0, f564_local1)
			local f564_local5 = CoD.BlackMarketTableUtility.GetBribeCPAndCasePrice(f564_arg0, f564_local1)
			local f564_local6 = false
			if f564_local5 and f564_local4 then
				if not IsBooleanDvarSet(@"hash_1539A350E73051B8") then
					f564_local5.price = 0
				end
				table.insert(f564_local0, {
					models = {
						name = f564_local4.name,
						desc = f564_local4.desc,
						price = f564_local5.price,
						casePrice = f564_local5.casePrice,
						popupImage = f564_local4.popupImage,
						stackImage = f564_local4.stackImage,
						stackTallImage = f564_local4.stackTallImage,
						lootRule = f564_local3.lootRule,
						timer = nil,
						purchased = f564_local6,
						hashName = f564_local3.name,
						isCrateItem = true,
						slot = 5,
						percentOff = f564_local2,
					},
				})
			end
		end
		return f564_local0
	end,
	nil,
	nil,
	function(f565_arg0, f565_arg1, f565_arg2)
		if not f565_arg1.__noDupeBribeStackSubscriptions then
			f565_arg1.__noDupeBribeStackSubscriptions = true
			f565_arg1:subscribeToGlobalModel(f565_arg0, "AutoEvents", "cycled", function()
				f565_arg1:updateDataSource()
			end)
		end
	end
)
CoD.BlackMarketUtility.TestMyShopItem = function(f567_arg0, f567_arg1)
	if Engine[@"isdevelopmentbuild"]() then
		Engine[@"hash_45FDA5F675A65C94"](0, CoD.BlackMarketTableUtility.GetMyShopItemId(0, Engine[@"converttoxhash"](f567_arg0)), Engine[@"getcurrentutctimestr"](), tonumber(f567_arg1))
		Engine[@"storagewrite"](0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "MyShop: '" .. f567_arg0 .. "' at price point: " .. f567_arg1 .. " has been activated.\n")
	end
end
CoD.BlackMarketUtility.PurchaseAtPricePoint = function(f568_arg0, f568_arg1, f568_arg2, f568_arg3, f568_arg4)
	if Engine[@"isdevelopmentbuild"]() then
		local f568_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f568_arg0, false)
		local f568_local1 = #f568_local0
		if f568_arg1 <= f568_local1 then
			local f568_local2 = nil
			local f568_local3 = false
			while not f568_local3 do
				f568_local2 = f568_local0[f568_arg1]
				if f568_local2.pricePoint == f568_arg2 then
					f568_local3 = true
					f568_arg3 = f568_arg3 + 1
				end
			end
			local f568_local4 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f568_arg0, f568_local2.name, f568_arg2)
			if f568_local4 and f568_local4.cpSku and f568_arg4 == true then
				Engine[@"exec"](f568_arg0, "purchaseSKU " .. f568_local4.cpSku .. " 1")
				LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
					if not Engine[@"isinventorybusy"](f568_arg0) and Engine[@"getpurchasedwskuresult"](f568_arg0) ~= Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_inprogress"] then
						LUI.roots.UIRootFull._testTimer:close()
						LUI.roots.UIRootFull._testTimer = nil
						local f569_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f568_arg0, false)
						local f569_local1 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f568_arg0, f569_local0[f568_arg1].name, f568_arg2)
						if Engine[@"getpurchasedwskuresult"](f568_arg0) == Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_success"] then
							Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f568_arg3 .. " purchase success for sku: " .. f569_local1.cpSku .. "\n")
						else
							Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f568_arg3 .. " purchase failed for sku: " .. f569_local1.cpSku .. "\n")
						end
						CoD.BlackMarketUtility.PurchaseAtPricePoint(f568_arg0, f568_arg1, f568_arg2, f568_arg3, f568_arg4)
					end
				end)
				LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
			end
			if f568_local4 and f568_local4.caseRule and f568_arg4 == false then
				Engine[@"exec"](f568_arg0, "applyConversion " .. f568_local4.caseRule)
				LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
					if not Engine[@"isinventorybusy"](f568_arg0) and Engine[@"hash_525090566AF670C"](f568_arg0) ~= Enum[@"hash_198BB5B1F9A186F6"][@"hash_41A1F8568C1B8A5D"] then
						LUI.roots.UIRootFull._testTimer:close()
						LUI.roots.UIRootFull._testTimer = nil
						local f570_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f568_arg0, false)
						local f570_local1 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f568_arg0, f570_local0[f568_arg1].name, f568_arg2)
						if Engine[@"hash_525090566AF670C"](f568_arg0) == Enum[@"hash_198BB5B1F9A186F6"][@"hash_19180C0E9D90CC4"] then
							Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f568_arg3 .. " exchange success for rule: " .. f570_local1.caseRule .. "\n")
						else
							Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f568_arg3 .. " exchange failed for rule: " .. f570_local1.caseRule .. "\n")
						end
						CoD.BlackMarketUtility.PurchaseAtPricePoint(f568_arg0, f568_arg1, f568_arg2, f568_arg3, f568_arg4)
					end
				end)
				LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
			else
			end
			f568_arg1 = f568_arg1 + 1
			if f568_local1 < f568_arg1 then
				Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Purchases for pricepoint " .. f568_arg2 .. " completed with total " .. f568_arg3 .. " transactions. \n")
				return
			end
		end
	end
end
CoD.BlackMarketUtility.TestPurchaseDeterministicItemSkus = function(f571_arg0)
	local f571_local0 = 0
	if Engine[@"isdevelopmentbuild"]() then
		local f571_local1 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f571_local0, true)
		CoD.BlackMarketUtility.PurchaseAtPricePoint(f571_local0, 1, f571_arg0, 0, true)
	end
end
CoD.BlackMarketUtility.TestPurchaseDeterministicItemExchanges = function(f572_arg0)
	local f572_local0 = 0
	if Engine[@"isdevelopmentbuild"]() then
		local f572_local1 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f572_local0, true)
		CoD.BlackMarketUtility.PurchaseAtPricePoint(f572_local0, 1, f572_arg0, 0, false)
	end
end
CoD.BlackMarketUtility.TestPurchaseItem = function(f573_arg0, f573_arg1, f573_arg2, f573_arg3, f573_arg4)
	if Engine[@"isdevelopmentbuild"]() then
		local f573_local0 = f573_arg3 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]
		local f573_local1 = nil
		local f573_local2 = 0
		local f573_local3, f573_local4 = nil
		local f573_local5 = false
		if f573_arg1 and f573_arg1._currentTab == "itemshop" then
			local f573_local6 = Engine[@"hash_6F2CB6360236F359"](f573_arg0, f573_arg3)
			f573_local3 = f573_local6.itemId
			f573_local5 = CoD.BlackMarketUtility.IsItemPurchased(f573_arg0, f573_local3)
			if not f573_local5 then
				if f573_local0 then
					f573_local4 = CoD.BlackMarketTableUtility.GetContrabandXHashFromItemID(f573_arg0, f573_local3)
				else
					f573_local2 = f573_local6.price_point
					f573_local4 = CoD.BlackMarketTableUtility.GetDeterministicItemNameFromId(f573_arg0, f573_local3)
				end
			end
		else
			local f573_local6 = CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem(f573_arg0, f573_arg3)
			if f573_local6 then
				f573_local3 = f573_local6.itemId
				f573_local4 = f573_local6.itemNameHash
				f573_local2 = f573_local6.pricePoint
			else
				f573_local5 = true
			end
		end
		if f573_local5 then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Purchase completed. No more items to reveal in this slot. \n")
			return
		elseif f573_local0 then
			f573_local1 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f573_arg0, f573_local3, 0)
		else
			f573_local1 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f573_arg0, f573_local4, f573_local2)
		end
		if f573_local1 and f573_local1.caseRule and f573_arg4 == false then
			Engine[@"exec"](f573_arg0, "applyConversion " .. f573_local1.caseRule)
			LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
				if not Engine[@"isinventorybusy"](f573_arg0) and Engine[@"hash_525090566AF670C"](f573_arg0) ~= Enum[@"hash_198BB5B1F9A186F6"][@"hash_41A1F8568C1B8A5D"] then
					LUI.roots.UIRootFull._testTimer:close()
					LUI.roots.UIRootFull._testTimer = nil
					if Engine[@"hash_525090566AF670C"](f573_arg0) == Enum[@"hash_198BB5B1F9A186F6"][@"hash_19180C0E9D90CC4"] then
						Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], f573_arg2 .. ". Item exchange success for rule: " .. f573_local1.caseRule .. ", Price " .. f573_local1.casePrice .. " Cases, Price Point " .. f573_local2 .. ". Item ID: " .. f573_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f573_local4) .. " \n")
					else
						Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_loot"], f573_arg2 .. ". Item exchange failed for rule: " .. f573_local1.caseRule .. ", Price " .. f573_local1.casePrice .. " Cases, Price Point " .. f573_local2 .. ". Item ID: " .. f573_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f573_local4) .. " \n")
					end
					f573_arg2 = f573_arg2 - 1
					if f573_arg2 <= 0 then
						Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Purchase completed. \n")
						return
					end
					CoD.BlackMarketUtility.TestPurchaseItem(f573_arg0, f573_arg1, f573_arg2, f573_arg3, f573_arg4)
				end
			end)
			LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
		end
		if f573_local1 and f573_local1.cpSku and f573_arg4 == true then
			Engine[@"exec"](f573_arg0, "purchaseSKU " .. f573_local1.cpSku .. " 1")
			LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
				if not Engine[@"isinventorybusy"](f573_arg0) and Engine[@"getpurchasedwskuresult"](f573_arg0) ~= Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_inprogress"] then
					LUI.roots.UIRootFull._testTimer:close()
					LUI.roots.UIRootFull._testTimer = nil
					if Engine[@"getpurchasedwskuresult"](f573_arg0) == Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_success"] then
						Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], f573_arg2 .. ". Item purchase success for sku: " .. f573_local1.cpSku .. ", Price " .. f573_local1.cpPrice .. " CP, Price Point " .. f573_local2 .. ". Item ID: " .. f573_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f573_local4) .. " \n")
					else
						Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_loot"], f573_arg2 .. ". Item purchase failed for sku: " .. f573_local1.cpSku .. ", Price " .. f573_local1.cpPrice .. " CP, Price Point " .. f573_local2 .. ". Item ID: " .. f573_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f573_local4) .. " \n")
					end
					f573_arg2 = f573_arg2 - 1
					if f573_arg2 <= 0 then
						Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Purchase completed. \n")
						return
					end
					CoD.BlackMarketUtility.TestPurchaseItem(f573_arg0, f573_arg1, f573_arg2, f573_arg3, f573_arg4)
				end
			end)
			LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
		end
	end
end
CoD.BlackMarketUtility.TestRevealAndPurchaseBySlot = function(f576_arg0, f576_arg1, f576_arg2)
	local f576_local0 = 0
	local f576_local1 = CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex(f576_arg0)
	if Engine[@"isdevelopmentbuild"]() then
		if CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex(f576_arg0) ~= Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"] then
			CoD.BlackMarketUtility.TestPurchaseItem(f576_local0, CoD.perController[f576_local0].blackMarketTestMenu, f576_arg1, f576_local1, f576_arg2)
		else
			Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_loot"], "Incorrect slot number passed to the test function. Allowed slot numbers are: <1,2,3> \n")
		end
	end
end
CoD.BlackMarketUtility.TestOpenCrateByCurrency = function()
	CoD.BlackMarketUtility.OpenCrateByCurrency(0, CoD.BlackMarketUtility.CrateStreams.THREE_PACK)
end
CoD.BlackMarketUtility.TestOpenNoDupeCrate = function()
	local f578_local0 = 0
	for f578_local5, f578_local6 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(0)) do
		if f578_local6.name == @"no_dupe_crate" then
			f578_local0 = f578_local6.lootRule
			local f578_local4 = Engine[@"hash_26C232D7031CE1CF"](0, f578_local0, CoDShared.Loot.GetBribePayload(controller, nil, f578_local0))
			Engine[@"sendclientscriptnotify"](0, "BlackJackReserve", {
				status = "OpenCrate",
				crateId = "1001",
				result = f578_local4,
			})
			return f578_local4 == 1
		end
	end
end
CoD.BlackMarketUtility.SetBlackMarketMenuForTest = function(f579_arg0, f579_arg1)
	if not Engine[@"isdevelopmentbuild"]() then
		return
	else
		CoD.perController[f579_arg0].blackMarketTestMenu = f579_arg1
	end
end
CoD.BlackMarketUtility.ClearBlackMarketMenuForTest = function(f580_arg0)
	if not Engine[@"isdevelopmentbuild"]() then
		return
	else
		CoD.perController[f580_arg0].blackMarketTestMenu = nil
	end
end
