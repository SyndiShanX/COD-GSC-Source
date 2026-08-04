require("ui/utility/blackmarkettableutility")
require("ui/utility/overlayutility")
CoD.BlackMarketUtility = {}
CoD.BlackMarketUtility.MyShopResetTime = "1553792400"
CoD.BlackMarketUtility.CostId = "0"
CoD.BlackMarketUtility.CrateId = 0
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
CoD.BlackMarketUtility.FreeBribeSentinelMay2020 = "500503"
DataSourceHelpers.PerControllerDataSourceSetup("LootStreamProgress", "LootStreamProgress", nil)
CoD.BlackMarketUtility.ItemCategories = {
	CALLING_CARD = "calling_card",
	STICKER = "sticker",
	TAG = "tag",
	OUTFIT = "outfit",
	OUTFIT_WARPAINT = @"outfit_warpaint",
	OUTFIT_DECAL = @"outfit_decal",
	OUTFIT_BUNDLE = "outfit_bundle",
	SIGNATURE_WEAPON = "signature_weapon",
	CHARACTER = "character",
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
	COMMON = Enum.LootCrateType[@"loot_crate_type_common"],
	RARE = Enum.LootCrateType[@"loot_crate_type_rare"],
	BRIBE = Enum.LootCrateType[@"loot_crate_type_bribe"],
	LEGENDARY = 3,
	EPIC = 4,
}
CoD.BlackMarketUtility.CrateTypeStrings = {
	[CoD.BlackMarketUtility.DropTypes.COMMON] = @"mpui/bm_common",
	[CoD.BlackMarketUtility.DropTypes.RARE] = @"mpui/bm_rare",
	[CoD.BlackMarketUtility.DropTypes.BRIBE] = "mpui/bm_bribe",
	[CoD.BlackMarketUtility.DropTypes.LEGENDARY] = @"mpui/bm_legendary",
	[CoD.BlackMarketUtility.DropTypes.EPIC] = @"mpui/bm_epic",
}
CoD.BlackMarketUtility.CrateTypeIds = {
	[CoD.BlackMarketUtility.DropTypes.COMMON] = "common",
	[CoD.BlackMarketUtility.DropTypes.RARE] = "rare",
	[CoD.BlackMarketUtility.DropTypes.BRIBE] = "bribe",
	[CoD.BlackMarketUtility.DropTypes.LEGENDARY] = "legendary",
	[CoD.BlackMarketUtility.DropTypes.EPIC] = "epic",
}
CoD.BlackMarketUtility.LootRarityIds = {
	[Enum.LootRarityType[@"loot_rarity_type_common"]] = "common",
	[Enum.LootRarityType[@"loot_rarity_type_rare"]] = "rare",
	[Enum.LootRarityType[@"loot_rarity_type_legendary"]] = "legendary",
	[Enum.LootRarityType[@"loot_rarity_type_epic"]] = "epic",
	[Enum.LootRarityType[@"hash_63006FE890A202D9"]] = "ultra",
	[Enum.LootRarityType[@"loot_rarity_type_count"]] = "invalid",
}
CoD.BlackMarketUtility.LootIdRarities = {}
for f0_local3, f0_local4 in pairs(CoD.BlackMarketUtility.LootRarityIds) do
	CoD.BlackMarketUtility.LootIdRarities[f0_local4] = f0_local3
end
CoD.BlackMarketUtility.LootRarityStrings = {
	[Enum.LootRarityType[@"loot_rarity_type_common"]] = @"mpui/bm_common",
	[Enum.LootRarityType[@"loot_rarity_type_rare"]] = @"mpui/bm_rare",
	[Enum.LootRarityType[@"loot_rarity_type_legendary"]] = @"mpui/bm_legendary",
	[Enum.LootRarityType[@"loot_rarity_type_epic"]] = @"mpui/bm_epic",
	[Enum.LootRarityType[@"hash_63006FE890A202D9"]] = @"mpui/bm_ultra",
}
CoD.BlackMarketUtility.LootRarityColors = {
	[Enum.LootRarityType[@"loot_rarity_type_common"]] = ColorSet.BlackMarketCommon,
	[Enum.LootRarityType[@"loot_rarity_type_rare"]] = ColorSet.BlackMarketRare,
	[Enum.LootRarityType[@"loot_rarity_type_legendary"]] = ColorSet.BlackMarketLegendary,
	[Enum.LootRarityType[@"loot_rarity_type_epic"]] = ColorSet.BlackMarketEpic,
	[Enum.LootRarityType[@"hash_63006FE890A202D9"]] = ColorSet.BlackMarketUltra,
}
CoD.BlackMarketUtility.LootRarityColorsBright = {
	[Enum.LootRarityType[@"loot_rarity_type_common"]] = ColorSet.BlackMarketCommonBright,
	[Enum.LootRarityType[@"loot_rarity_type_rare"]] = ColorSet.BlackMarketRareBright,
	[Enum.LootRarityType[@"loot_rarity_type_legendary"]] = ColorSet.BlackMarketLegendaryBright,
	[Enum.LootRarityType[@"loot_rarity_type_epic"]] = ColorSet.BlackMarketEpicBright,
	[Enum.LootRarityType[@"hash_63006FE890A202D9"]] = ColorSet.BlackMarketUltraBright,
}
CoD.BlackMarketUtility.LootRarityColorsDark = {
	[Enum.LootRarityType[@"loot_rarity_type_common"]] = ColorSet.BlackMarketCommonDark,
	[Enum.LootRarityType[@"loot_rarity_type_rare"]] = ColorSet.BlackMarketRareDark,
	[Enum.LootRarityType[@"loot_rarity_type_legendary"]] = ColorSet.BlackMarketLegendaryDark,
	[Enum.LootRarityType[@"loot_rarity_type_epic"]] = ColorSet.BlackMarketEpicDark,
	[Enum.LootRarityType[@"hash_63006FE890A202D9"]] = ColorSet.BlackMarketUltraDark,
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
	"prt_mp_mercenary",
	"prt_mp_battery",
	"prt_mp_swatpolice",
	"prt_mp_engineer",
	"prt_mp_buffassault",
	"prt_mp_recon",
	"prt_mp_firebreak",
	"prt_mp_trapper",
	"prt_mp_enforcer",
	"prt_mp_technomancer",
	"prt_mp_zero",
	"prt_mp_spectre",
	"prt_mp_reaper",
}
CoD.BlackMarketUtility.ItemNameCharacterPRTTable = {
	[@"hash_3C214F585374E06A"] = "prt_wz_hudson",
}
CoD.BlackMarketUtility.StreamCharacterDescTable = {
	prt_wz_hudson = @"hash_6CDD8929BD48E4E9",
	prt_wz_zero = @"hash_4774DE2FD6C7BE88",
	prt_wz_outrider = @"hash_4774DE2FD6C7BE88",
	prt_wz_nikolai_ofc = @"hash_6CDD8929BD48E4E9",
	prt_wz_dempsey_ofc = @"hash_6CDD8929BD48E4E9",
	prt_wz_replacer = @"hash_6CDD8929BD48E4E9",
	prt_mp_spectre = @"hash_4774DE2FD6C7BE88",
	prt_mp_reaper = @"hash_4774DE2FD6C7BE88",
}
CoD.BlackMarketUtility.PRT_To_PBT_Table = {
	prt_mp_swatpolice = "pbt_mp_swatpolice",
	prt_mp_engineer = "pbt_mp_engineer",
	prt_mp_buffassault = "pbt_mp_buffassault",
	prt_mp_recon = "pbt_mp_recon",
	prt_mp_battery = "pbt_mp_battery",
	prt_mp_firebreak = "pbt_mp_firebreak",
	prt_mp_trapper = "pbt_mp_trapper",
	prt_mp_mercenary = "pbt_mp_mercenary",
	prt_mp_enforcer = "pbt_mp_enforcer",
	prt_mp_technomancer = "pbt_mp_technomancer",
	prt_mp_zero = "pbt_mp_zero",
	prt_mp_spectre = "pbt_mp_spectre",
	prt_mp_reaper = "pbt_mp_reaper",
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
	camo_active_dlc1_masks_wrapper = {
		expKey = "expMaskedReactiveCamoBundle",
		itemRefs = {
			["1"] = "camo_active_dlc1_masks_wrapper",
			["2"] = @"hash_78B5B62ACC867E6",
			["3"] = @"hash_3658E788D9ADF660",
			["4"] = @"hash_6F19E01F158B1AF5",
			["5"] = @"hash_634F3FF44882A3BA",
		},
	},
}
CoD.BlackMarketUtility.Error = function(f1_arg0, f1_arg1)
	if Dvar[@"hash_35B2B7FB4235091B"]:exists() and Dvar[@"hash_35B2B7FB4235091B"]:get() == "1" then
		Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_loot"], "Error: '\n" .. f1_arg1)
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
			local f6_local4 = Engine.GetModelForController(f6_arg0)
			f6_local4 = f6_local4:create("LootRNGResult")
			if f6_local4.successfulExchange and f6_local4.successfulExchange:get() then
				local f6_local5 = Engine[@"hash_6D80580D17461096"](f6_arg0, f6_local10.lootRule)
				if f6_local5 == "0" then
					f6_local5 = CoD.BlackMarketUtility.GetBribeStackWindowStartDate(f6_local10.name)
				end
				local f6_local6 = Engine.GetCurrentUTCTimeStr()
				local f6_local7 = CoD.BlackMarketUtility.GetBribeStackWindowSizeSeconds(f6_arg0, f6_local10.name)
				if Engine[@"hash_5A313AE346776CD8"](f6_arg0, f6_local10.lootRule, Engine[@"hash_4556671B48CC6BFE"](f6_local5, f6_local7, Engine[@"hash_647ACFFF824019CC"](Engine[@"hash_13FB8C7BE7B85704"](f6_local6, f6_local5), f6_local7))) then
					local f6_local8 = f6_local4:create("successfulExchange")
					f6_local8:set(false)
					Engine.StorageWrite(f6_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
				end
			end
		end
	end
end
CoD.BlackMarketUtility.SaveBribeMenuPurchase = function(f7_arg0)
	local f7_local0 = Engine.GetModelForController(f7_arg0)
	f7_local0 = f7_local0:create("LootRNGResult")
	if f7_local0.successfulExchange and f7_local0.successfulExchange:get() then
		local f7_local1 = Engine[@"hash_6D80580D17461096"](f7_arg0, CoD.BlackMarketUtility.BribeMenuLootRule)
		if not f7_local1 or f7_local1 == "0" then
			f7_local1 = CoD.BlackMarketUtility.GetBribeMenuWindowStartDate()
		end
		local f7_local2 = Engine.GetCurrentUTCTimeStr()
		local f7_local3 = CoD.BlackMarketUtility.GetBribeMenuWindowSizeSeconds(f7_arg0)
		if Engine[@"hash_5A313AE346776CD8"](f7_arg0, CoD.BlackMarketUtility.BribeMenuLootRule, Engine[@"hash_4556671B48CC6BFE"](f7_local1, f7_local3, Engine[@"hash_647ACFFF824019CC"](Engine[@"hash_13FB8C7BE7B85704"](f7_local2, f7_local1), f7_local3))) then
			local f7_local4 = f7_local0:create("successfulExchange")
			f7_local4:set(false)
			Engine.StorageWrite(f7_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
		end
	end
end
CoD.BlackMarketUtility.TickBribeStack = function(f8_arg0)
	local f8_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "BribeStackTimer")
	f8_local0:create("cycled")
	local f8_local1 = false
	local f8_local2 = {}
	local f8_local3 = CoD.BlackMarketTableUtility.GetBribeStackInfo(f8_arg0)
	local f8_local4 = tostring(Engine.GetCurrentUTCTimeStr())
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
		local f8_local9 = Engine.GetSecondsRemainingServer(f8_local8)
		if f8_local9 <= 0 then
			if f8_local0[f8_local12.stringName .. "_raw"] and f8_local0[f8_local12.stringName .. "_raw"]:get() > 0 then
				f8_local1 = true
			end
			f8_local9 = Engine.GetSecondsRemainingServer(Engine[@"hash_2C778D3D40E06605"](f8_local8, CoD.BlackMarketUtility.GetBribeStackWindowSizeSeconds(f8_arg0, f8_local12.stringName)))
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
	local f9_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "BribeMenuTimer")
	f9_local0:create("cycled")
	f9_local0:create("countDown")
	local f9_local1 = false
	local f9_local2 = Engine[@"hash_6D80580D17461096"](f9_arg0, CoD.BlackMarketUtility.BribeMenuLootRule)
	if f9_local2 == "0" then
		f9_local2 = CoD.BlackMarketUtility.GetBribeMenuWindowStartDate()
	end
	local f9_local3 = Engine.GetSecondsRemainingServer(f9_local2)
	if f9_local3 <= 0 then
		if f9_local0.bribe_menu_timer_raw and f9_local0.bribe_menu_timer_raw:get() > 0 and f9_local0.countDown:get() == false then
			f9_local1 = true
		end
		if Engine.GetSecondsRemainingServer(Engine[@"hash_2C778D3D40E06605"](f9_local2, CoD.BlackMarketUtility.GetBribeMenuWindowSizeSeconds(f9_arg0))) < 0 then
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
CoD.BlackMarketUtility.IsUnlimitedBribeOfferActive = function()
	local f10_local0
	if Engine[@"getdvarstring"]("loot_bribe_menu_window_size") == "0" then
		f10_local0 = IsBooleanDvarSet("loot_weaponBribeMultiPurchaseActive")
	else
		f10_local0 = false
	end
	return f10_local0
end
CoD.BlackMarketUtility.GetMyShopRotateTime = function()
	return Dvar[@"hash_439E2CD708BA96CF"]:get() or "43200"
end
CoD.BlackMarketUtility.GetMyShopRevealDelay = function()
	return Dvar[@"hash_DC178EB99D98BBA"]:get() or 0.25
end
CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime = function(f13_arg0, f13_arg1)
	local f13_local0 = "loot_itemshop_sunset_rotation_time_slot_" .. f13_arg1
	local f13_local1 = CoD.StoreUtility.GetExperimentModifier(f13_arg0, f13_local0)
	if not f13_local1 or f13_local1 == "" then
		f13_local1 = Engine[@"getdvarstring"](f13_local0)
		if not f13_local1 or f13_local1 == "" then
			f13_local1 = "43200"
		end
	end
	return f13_local1
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
		local f23_local0 = tonumber(Dvar[@"hash_543463271EA85EB"]:get())
		if f23_local0 == nil then
			return 0
		else
			return f23_local0
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
	if Engine.getclientplatform() == "orbis" then
		return "ps4"
	elseif Engine.getclientplatform() == "durango" then
		return "xbox"
	elseif Engine.getclientplatform() == "pc" then
		return "pc"
	else
		Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: Platform not detected.'\n")
		return "unknown"
	end
end
CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex = function(f26_arg0)
	for f26_local3, f26_local4 in pairs(CoD.BlackMarketUtility.BlackjackShopSlotIndex) do
		if f26_local4 == f26_arg0 then
			return f26_local3
		end
	end
	return Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"]
end
CoD.BlackMarketUtility.WasItemCycled = function(f27_arg0, f27_arg1)
	local f27_local0 = f27_arg1:getModel()
	if f27_local0 and f27_local0.hashName and f27_local0.slot then
		local f27_local1 = f27_local0.hashName:get()
		local f27_local2 = f27_local0.slot:get()
		if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
			local f27_local3 = CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex(f27_local2)
			if f27_local3 ~= Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"] then
				local f27_local4 = Engine[@"hash_6F2CB6360236F359"](f27_arg0, f27_local3)
				return CoD.BlackMarketUtility.IsItemShopSunsetSlotItemOld(f27_arg0, f27_local4.reveal_expiration, f27_local4.itemId)
			end
		elseif f27_local2 == 4 then
			local f27_local3 = Engine[@"hash_12C2DB3D3E1B227E"](f27_arg0)
			if f27_local3 ~= nil and not CoD.BlackMarketUtility.IsMyShopItemOld(f27_arg0, f27_local3.timestamp, f27_local3.id) then
				return false
			end
		else
			for f27_local7, f27_local8 in ipairs(CoD.BlackMarketUtility["FeaturedSlot" .. f27_local2 .. "Items"]) do
				if f27_local1 == Engine[@"converttoxhash"](f27_local8.name) then
					return false
				end
			end
		end
	end
	if f27_local0 and not f27_local0.slot then
		return false
	end
	return true
end
CoD.BlackMarketUtility.WasDiscountCycled = function(f28_arg0, f28_arg1)
	local f28_local0 = f28_arg1:getModel()
	if f28_local0 and f28_local0.hashName and f28_local0.discountList then
		local f28_local1 = f28_local0.hashName:get()
		local f28_local2 = f28_local0.discountIndx:get()
		if f28_local2 then
			if f28_local2 == 0 or f28_local2 > 3 then
				return false
			elseif IsBooleanDvarSet(Engine[@"converttoxhash"]("loot_tier_discount" .. f28_local2 .. "_active")) and f28_local1 == Engine[@"converttoxhash"](Dvar["loot_tier_discount" .. f28_local2 .. "_bundle"]:get()) then
				return false
			end
		end
	end
	return true
end
CoD.BlackMarketUtility.TickReserveDeals = function(f29_arg0)
	local f29_local0 = CoD.BlackMarketUtility.GetItemshopPlatform()
	local f29_local1 = Engine.CreateModel(Engine.GetGlobalModel(), "ReserveDealsRotation")
	f29_local1:create("cycled")
	local f29_local2 = false
	local f29_local3 = {}
	local f29_local4 = "gamedata/events/reserve_deals_schedule_" .. f29_local0 .. ".csv"
	local f29_local5 = Engine.GetTableRowCount(f29_local4)
	local f29_local6 = tostring(Engine.GetCurrentUTCTimeStr())
	local f29_local7 = f29_local1:create("currentTime")
	f29_local7:set(f29_local6)
	for f29_local7 = 0, f29_local5 - 1, 1 do
		local f29_local10 = Engine.TableLookupGetColumnValueForRow(f29_local4, f29_local7, 0)
		local f29_local11 = Engine.TableLookupGetColumnValueForRow(f29_local4, f29_local7, 1)
		local f29_local12 = Engine.TableLookupGetColumnValueForRow(f29_local4, f29_local7, 2)
		if Engine.IsInRange(f29_local6, f29_local11, f29_local12) then
			table.insert(f29_local3, {
				name = f29_local10,
				start = f29_local11,
			})
			local f29_local13 = f29_local1:create(f29_local10)
			f29_local13:set(LuaUtils.SecondsToTimeRemainingString(Engine.GetSecondsRemainingServer(f29_local12) + 1))
			f29_local13 = f29_local1:create(f29_local10 .. "_raw")
			f29_local13:set(Engine.GetSecondsRemainingServer(f29_local12) + 1)
			f29_local13 = f29_local1:create(f29_local10 .. "_red")
			f29_local13:set(Engine.GetSecondsRemainingServer(f29_local12) < 300)
		end
	end
	if #f29_local3 ~= #CoD.BlackMarketUtility.ReserveDeals then
		f29_local2 = true
	else
		for f29_local16, f29_local10 in ipairs(f29_local3) do
			local f29_local11 = false
			for f29_local14, f29_local15 in ipairs(CoD.BlackMarketUtility.ReserveDeals) do
				if f29_local10.name == f29_local15.name then
					f29_local11 = true
				end
			end
			if f29_local11 == false then
				f29_local2 = true
			end
		end
	end
	CoD.BlackMarketUtility.ReserveDeals = f29_local3
	if f29_local2 then
		f29_local1.cycled:set(true)
		f29_local1.cycled:forceNotifySubscriptions()
	else
		f29_local1.cycled:set(false)
	end
end
CoD.BlackMarketUtility.TickItemshop = function(f30_arg0)
	if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
		CoD.BlackMarketUtility.TickItemshopSunset(f30_arg0)
		return
	end
	local f30_local0 = CoD.BlackMarketUtility.GetItemshopPlatform()
	local f30_local1 = Engine.CreateModel(Engine.GetGlobalModel(), "ItemshopRotation")
	f30_local1:create("cycled")
	local f30_local2 = false
	for f30_local3 = 1, CoD.BlackMarketUtility.ItemShopSlots, 1 do
		local f30_local6 = {}
		local f30_local7 = "loot_itemshop_slot" .. f30_local3 .. "_timer"
		local f30_local8 = "gamedata/events/itemshop_slot_" .. tostring(f30_local3) .. "_" .. f30_local0 .. ".csv"
		local f30_local9 = Engine.GetTableRowCount(f30_local8)
		local f30_local10 = nil
		local f30_local11 = tostring(Engine.GetCurrentUTCTimeStr())
		for f30_local12 = 0, f30_local9 - 1, 1 do
			local f30_local15 = Engine.TableLookupGetColumnValueForRow(f30_local8, f30_local12, 0)
			local f30_local16 = Engine.TableLookupGetColumnValueForRow(f30_local8, f30_local12, 1)
			local f30_local17 = Engine.IsInRange(f30_local11, f30_local16, Engine.TableLookupGetColumnValueForRow(f30_local8, f30_local12, 2))
			local f30_local18 = CoD.BlackMarketTableUtility.GetItemShopInformation(f30_arg0, f30_local15)
			local f30_local19 = Engine[@"hash_3E78C83C300F9368"]()
			if f30_local19 then
				f30_local19 = f30_local18 and f30_local18.koreaExcluded ~= 0
			end
			if f30_local17 and not f30_local19 then
				table.insert(f30_local6, {
					name = f30_local15,
					start = f30_local16,
				})
			end
			if not f30_local19 and Engine[@"isgreaterthan"](f30_local16, f30_local11) then
				if f30_local10 then
					if Engine[@"isgreaterthan"](f30_local10, f30_local16) then
						f30_local10 = f30_local16
					end
				end
				f30_local10 = f30_local16
			end
		end
		if f30_local10 then
			f30_local12 = f30_local1:create(f30_local7)
			f30_local12:set(LuaUtils.SecondsToTimeRemainingString(Engine.GetSecondsRemainingServer(f30_local10) + 1))
			f30_local12 = f30_local1:create(f30_local7 .. "_raw")
			f30_local12:set(Engine.GetSecondsRemainingServer(f30_local10) + 1)
			f30_local12 = f30_local1:create(f30_local7 .. "_red")
			f30_local12:set(Engine.GetSecondsRemainingServer(f30_local10) < 300)
		else
			local f30_local12 = f30_local1:create(f30_local7)
			f30_local12:set(LuaUtils.SecondsToTimeRemainingString(Engine.GetSecondsRemainingServer(f30_local11) + 1))
			f30_local12 = f30_local1:create(f30_local7 .. "_raw")
			f30_local12:set(Engine.GetSecondsRemainingServer(f30_local11) + 1)
			f30_local12 = f30_local1:create(f30_local7 .. "_red")
			f30_local12:set(Engine.GetSecondsRemainingServer(f30_local11) < 300)
		end
		if #f30_local6 ~= #CoD.BlackMarketUtility["FeaturedSlot" .. f30_local3 .. "Items"] then
			f30_local2 = true
		end
		CoD.BlackMarketUtility["FeaturedSlot" .. f30_local3 .. "Items"] = f30_local6
	end
	local f30_local3 = Engine[@"hash_12C2DB3D3E1B227E"](f30_arg0)
	if f30_local3 ~= nil then
		local f30_local20 = Engine.GetSecondsRemainingServer(Engine[@"hash_2C778D3D40E06605"](f30_local3.timestamp, CoD.BlackMarketUtility.GetMyShopRotateTime()))
		if f30_local20 <= 0 then
			f30_local20 = 0
		end
		local f30_local6 = f30_local1:create("loot_itemshop_slot4_timer_raw")
		if f30_local20 == 0 and f30_local20 ~= f30_local6:get() then
			f30_local2 = true
		end
		local f30_local7 = f30_local1:create("loot_itemshop_slot4_timer")
		f30_local7:set(LuaUtils.SecondsToTimeRemainingString(f30_local20))
		f30_local7 = f30_local1:create("loot_itemshop_slot4_timer_raw")
		f30_local7:set(f30_local20)
		f30_local7 = f30_local1:create("loot_itemshop_slot4_timer_red")
		f30_local7:set(f30_local20 < 300)
	else
		local f30_local4 = f30_local1:create("loot_itemshop_slot4_timer")
		f30_local4:set(LuaUtils.SecondsToTimeRemainingString(0))
		f30_local4 = f30_local1:create("loot_itemshop_slot4_timer_raw")
		f30_local4:set(0)
		f30_local4 = f30_local1:create("loot_itemshop_slot4_timer_red")
		f30_local4:set(0)
	end
	if f30_local2 then
		f30_local1.cycled:set(true)
		f30_local1.cycled:forceNotifySubscriptions()
	else
		f30_local1.cycled:set(false)
	end
end
CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
	local f31_local0 = false
	local f31_local1 = Engine[@"hash_6F2CB6360236F359"](f31_arg0, f31_arg3)
	if f31_local1 then
		local f31_local2 = Engine.GetSecondsRemainingServer(f31_local1.reveal_expiration)
		if f31_local2 <= 0 then
			f31_local2 = 0
		end
		local f31_local3 = f31_arg1:create("loot_itemshop_" .. f31_arg2 .. "_timer_raw")
		if f31_local2 == 0 and f31_local2 ~= f31_local3:get() then
			f31_local0 = true
		end
		local f31_local4 = f31_arg1:create("loot_itemshop_" .. f31_arg2 .. "_timer")
		f31_local4:set(LuaUtils.SecondsToTimeRemainingString(f31_local2))
		f31_local4 = f31_arg1:create("loot_itemshop_" .. f31_arg2 .. "_timer_raw")
		f31_local4:set(f31_local2)
		f31_local4 = f31_arg1:create("loot_itemshop_" .. f31_arg2 .. "_timer_red")
		f31_local4:set(f31_local2 < 300)
	else
		local f31_local5 = f31_arg1:create("loot_itemshop_" .. f31_arg2 .. "_timer")
		f31_local5:set(LuaUtils.SecondsToTimeRemainingString(0))
		f31_local5 = f31_arg1:create("loot_itemshop_" .. f31_arg2 .. "_timer_raw")
		f31_local5:set(0)
		f31_local5 = f31_arg1:create("loot_itemshop_" .. f31_arg2 .. "_timer_red")
		f31_local5:set(0)
	end
	return f31_local0
end
CoD.BlackMarketUtility.TickItemshopSunset = function(f32_arg0)
	local f32_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "ItemshopRotation")
	f32_local0:create("cycled")
	if CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer(f32_arg0, f32_local0, "slot1", Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"]) or CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer(f32_arg0, f32_local0, "slot2", Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"]) or CoD.BlackMarketUtility.UpdateItemShopSunsetSlotTimer(f32_arg0, f32_local0, "slot3", Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]) then
		if not f32_local0.cycled:set(true) then
			f32_local0.cycled:forceNotifySubscriptions()
		end
	else
		f32_local0.cycled:set(false)
	end
end
CoD.BlackMarketUtility.GetEventName = function()
	local f33_local0 = Dvar[@"hash_3A7588CE8BBBC25D"]:get()
	if f33_local0 and f33_local0 ~= "" then
		return Engine[@"converttoxhash"](f33_local0)
	else
		return 0x0
	end
end
CoD.BlackMarketUtility.IsEventActive = function()
	local f34_local0 = Dvar[@"hash_3A7588CE8BBBC25D"]:get()
	if f34_local0 and f34_local0 ~= "" then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.GetCurrentSeasonPostSeasonStat = function()
	local f35_local0 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER)
	if f35_local0 then
		return f35_local0 - 1
	else
		return 0
	end
end
CoD.BlackMarketUtility.GetCurrentAllRNGStat = function()
	local f36_local0 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_HIGHEST_DROP_VERSION)
	if f36_local0 then
		return f36_local0 - 1
	else
		return 0
	end
end
CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers = function()
	local f37_local0 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_MAX_TIERS)
	if not f37_local0 then
		return 0
	else
		return f37_local0
	end
end
CoD.BlackMarketUtility.GetCurrentSeasonTier = function(f38_arg0)
	return Engine[@"hash_6159D7050715A2C3"](f38_arg0, CoDShared.Loot.GetCurrentSeason()) or 0
end
CoD.BlackMarketUtility.GetRarityIDForString = function(f39_arg0)
	for f39_local3, f39_local4 in pairs(CoD.BlackMarketUtility.CrateTypeIds) do
		if f39_local4 == f39_arg0 then
			return f39_local3
		end
	end
	return CoD.BlackMarketUtility.DropTypes.COMMON
end
CoD.BlackMarketUtility.GetLootRarityType = function(f40_arg0)
	for f40_local3, f40_local4 in pairs(CoD.BlackMarketUtility.LootRarityIds) do
		if f40_local4 == f40_arg0 then
			return f40_local3
		end
	end
	return nil
end
CoD.BlackMarketUtility.ConvertToLootDecalIndex = function(f41_arg0)
	local f41_local0 = 0
	for f41_local4 in string.gmatch(f41_arg0, "[^%s_]+") do
		f41_local0 = f41_local0 + 1
		if f41_local0 == 1 and f41_local4 ~= "decal" then
			break
		elseif f41_local0 == 2 then
			return f41_local4
		end
	end
	f41_local3 = Engine.TableLookup(CoD.emblemIconsTable, 1, 3, f41_arg0)
	if f41_local3 and f41_local3 ~= "" then
		return f41_local3
	end
	return nil
end
CoD.BlackMarketUtility.ConvertToLootDecalIndexIfDecal = function(f42_arg0)
	return CoD.BlackMarketUtility.ConvertToLootDecalIndex(f42_arg0) or f42_arg0
end
CoD.BlackMarketUtility.SplitIdIntoTwoValues = function(f43_arg0)
	local f43_local0 = nil
	for f43_local4 in string.gmatch(f43_arg0, "[^%s;]+") do
		if f43_local0 == nil then
			f43_local0 = f43_local4
		end
		return f43_local0, f43_local4
	end
	if f43_local0 ~= nil then
		return f43_local0, ""
	end
	return "", ""
end
CoD.BlackMarketUtility.GetSpecialistThemeType = function(f44_arg0)
	if string.find(f44_arg0, "body") then
		return Enum.CharacterItemType[@"character_item_type_body"]
	else
		return Enum.CharacterItemType[@"character_item_type_helmet"]
	end
end
CoD.BlackMarketUtility.GetItemTypeStringForLootItem = function(f45_arg0, f45_arg1)
	if f45_arg1 == "camo" then
		local f45_local0, f45_local1 = CoD.BlackMarketUtility.SplitIdIntoTwoValues(f45_arg0)
		return Engine[@"hash_4F9F1239CFD921FE"]("mpui/bm_weapon_camo", CoD.CACUtility.GetNameForItemRefString(f45_local1))
	elseif f45_arg1 == "specialist_outfit" then
		local f45_local0, f45_local1 = CoD.BlackMarketUtility.SplitIdIntoTwoValues(f45_arg0)
		local f45_local2 = "menu/specialist_head_theme"
		if CoD.BlackMarketUtility.GetSpecialistThemeType(f45_local0) == Enum.CharacterItemType[@"character_item_type_body"] then
			f45_local2 = "menu/specialist_body_theme"
		end
		return Engine.Localize(f45_local2, CoD.BlackMarketUtility.GetHeroDisplayNameForAssetName(f45_local1))
	elseif f45_arg1 == "reticle" then
		return CoD.BlackMarketUtility.CategoryStrings[f45_arg1]
	else
		return CoD.BlackMarketUtility.CategoryStrings[f45_arg1]
	end
end
CoD.BlackMarketUtility.GetCallingCardSetName = function(f46_arg0)
	return Engine.TableLookup(CoD.BlackMarketUtility.lootTableName, 4, 0, f46_arg0)
end
CoD.BlackMarketUtility.GetNumOwnedAndTotalForCallingCardSet = function(f47_arg0, f47_arg1)
	local f47_local0 = Engine.TableFindRows(CoD.BlackMarketUtility.lootTableName, 4, f47_arg1)
	local f47_local1 = 0
	local f47_local2 = 0
	if not f47_local0 then
		return 0, 0, 0
	end
	for f47_local3 = 1, #f47_local0, 1 do
		local f47_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f47_local0[f47_local3], CoD.BlackMarketUtility.lootNameCol)
		if not CoD.BlackMarketUtility.IsItemLocked(f47_arg0, f47_local6) then
			f47_local1 = f47_local1 + 1
			local f47_local7 = CoD.BlackMarketUtility.GetLootCallingCardIndex(f47_arg0, f47_local6)
			if f47_local7 and Engine.IsEmblemBackgroundNew(f47_arg0, f47_local7) then
				f47_local2 = f47_local2 + 1
			end
		end
	end
	return f47_local1, #f47_local0, f47_local2
end
CoD.BlackMarketUtility.GetSetNumOwnedAndTotalForCallingCard = function(f48_arg0, f48_arg1)
	local f48_local0 = CoD.BlackMarketUtility.GetCallingCardSetName(f48_arg1)
	if f48_local0 == nil or f48_local0 == "" then
		return 0, 0, 0
	else
		return CoD.BlackMarketUtility.GetNumOwnedAndTotalForCallingCardSet(f48_arg0, f48_local0)
	end
end
CoD.BlackMarketUtility.GetRewardAndCategoryForItem = function(f49_arg0)
	local f49_local0 = 0
	local f49_local1 = 2
	local f49_local2 = Engine.TableFindRows(CoD.BlackMarketUtility.lootTableName, 5, f49_arg0)
	if f49_local2 ~= nil then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f49_local2[1], f49_local0), Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f49_local2[1], f49_local1)
	else
		return nil, nil
	end
end
CoD.BlackMarketUtility.IsUnavailableBlackMarketItem = function(f50_arg0, f50_arg1, f50_arg2)
	if f50_arg2 and (not f50_arg1 or f50_arg1.isLoot) then
		f50_arg1 = CoD.BlackMarketTableUtility.LootInfoLookup(f50_arg0, f50_arg2)
	end
	local f50_local0 = f50_arg1
	local f50_local1
	if not f50_arg1.owned then
		f50_local1 = not f50_arg1.available
	else
		f50_local1 = false
	end
	return f50_local1
end
CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem = function(f51_arg0)
	local f51_local0 = 0
	local f51_local1
	if f51_arg0 == nil or f51_arg0 ~= Engine.TableLookup(CoD.BlackMarketUtility.unreleasedLootTableName, f51_local0, f51_local0, f51_arg0) then
		f51_local1 = false
	else
		f51_local1 = true
	end
	return f51_local1
end
CoD.BlackMarketUtility.IsBlackMarketItem = function(f52_arg0)
	local f52_local0 = 0
	return f52_arg0 == Engine.TableLookup(CoD.BlackMarketUtility.lootTableName, f52_local0, f52_local0, f52_arg0)
end
CoD.BlackMarketUtility.IsReleasedBlackMarketItem = function(f53_arg0)
	local f53_local0
	if f53_arg0 ~= nil then
		f53_local0 = CoD.BlackMarketUtility.IsBlackMarketItem(f53_arg0)
		if f53_local0 then
			f53_local0 = not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(f53_arg0)
		end
	else
		f53_local0 = false
	end
	return f53_local0
end
CoD.BlackMarketUtility.GetSafeReward = function(f54_arg0, f54_arg1)
	local f54_local0 = f54_arg0
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and f54_arg1 == "calling_card" then
		local f54_local1 = 3
		local f54_local2 = 19
		f54_local0 = Engine.TableLookup(CoD.backgroundsTable, f54_local2, f54_local1, f54_arg0)
		if not f54_local0 or f54_local0 == 0x0 then
			f54_local0 = Engine.TableLookup(CoD.backgroundsTable, f54_local2, 15, f54_arg0)
		end
		if not f54_local0 or f54_local0 == 0x0 then
			f54_local0 = f54_arg0
		end
	end
	return f54_local0
end
CoD.BlackMarketUtility.GetSafeBonusSetMasterNameHash = function(f55_arg0, f55_arg1)
	local f55_local0 = f55_arg0
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and f55_arg1 == "calling_card" then
		f55_local0 = Engine.TableLookup(CoD.backgroundsTable, 19, 15, f55_arg0)
		if not f55_local0 or f55_local0 == 0x0 then
			f55_local0 = f55_arg0
		end
	end
	return f55_local0
end
CoD.BlackMarketUtility.GetSetPieceStringForLootItem = function(f56_arg0, f56_arg1, f56_arg2)
	if f56_arg2 == "calling_card" then
		local f56_local0, f56_local1 = CoD.BlackMarketUtility.GetSetNumOwnedAndTotalForCallingCard(f56_arg0, f56_arg1)
		if f56_local1 > 0 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FB55139FE22C27D", f56_local0, f56_local1)
		end
	end
	return ""
end
CoD.BlackMarketUtility.GetSetPieceStringForLootSet = function(f57_arg0, f57_arg1, f57_arg2)
	if f57_arg2 == "calling_card" then
		local f57_local0, f57_local1 = CoD.BlackMarketUtility.GetNumOwnedAndTotalForCallingCardSet(f57_arg0, f57_arg1)
		if f57_local1 > 0 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_74DCD63ACA0BFEEE", f57_local0, f57_local1)
		end
	end
	return ""
end
CoD.BlackMarketUtility.GetCurrentRank = function(f58_arg0)
	local f58_local0 = Engine.GetPlayerStats(f58_arg0)
	return f58_local0.PlayerStatsList.RANK.statValue:get()
end
CoD.BlackMarketUtility.GetItemLockedTextAndAvailability = function(f59_arg0, f59_arg1, f59_arg2)
	if f59_arg2 == "camo" then
		local f59_local0 = Enum.eModes.mode_multiplayer
		local f59_local1 = CoD.BlackMarketUtility.GetCurrentRank(f59_arg0)
		local f59_local2, f59_local3 = CoD.BlackMarketUtility.SplitIdIntoTwoValues(f59_arg1)
		local f59_local4 = Engine.GetItemIndexFromReference(f59_local3, f59_local0)
		local f59_local5 = Engine.GetItemUnlockLevel(f59_local4, f59_local0)
		if f59_local1 < f59_local5 then
			return Engine.GetItemName(f59_local4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f59_local0), Engine[@"hash_4F9F1239CFD921FE"]("menu/rank_name_full", CoD.GetRankName(f59_local5, 0, f59_local0), "" .. f59_local5 + 1)
		end
	end
	return nil, nil
end
CoD.BlackMarketUtility.GetLootCallingCardIndex = function(f60_arg0, f60_arg1)
	local f60_local0 = 3
	local f60_local1 = 19
	local f60_local2 = 1
	local f60_local3 = nil
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f60_local3 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f60_local2, f60_local1, f60_arg1)
	end
	if not f60_local3 then
		f60_local3 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f60_local2, f60_local0, f60_arg1)
	end
	return tonumber(f60_local3)
end
CoD.BlackMarketUtility.GetLootEmblemIndexParams = function(f61_arg0, f61_arg1)
	local f61_local0 = 0
	local f61_local1 = 1
	local f61_local2 = 2
	local f61_local3 = Engine.TableFindRows(CoD.BlackMarketUtility.lootEmblemTableName, f61_local0, f61_arg1)
	if f61_local3 then
		return f61_arg0, tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootEmblemTableName, f61_local3[1], f61_local1)), Enum.StorageFileType[Engine[@"converttoxhash"](Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootEmblemTableName, f61_local3[1], f61_local2))]
	else
		return f61_arg0, 0, Enum.StorageFileType[@"storage_default_emblems"]
	end
end
CoD.BlackMarketUtility.GetLootEmblemIDName = function(f62_arg0)
	local f62_local0 = 1
	local f62_local1 = 1
	local f62_local2 = 2
	return Engine.TableLookup(CoD.BlackMarketUtility.lootEmblemTableName, f62_local0, f62_local1, f62_arg0)
end
CoD.BlackMarketUtility.GetLootBackgroundName = function(f63_arg0, f63_arg1)
	return Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, 3, 1, f63_arg1)
end
CoD.BlackMarketUtility.GetLootDecalName = function(f64_arg0, f64_arg1)
	return Engine.TableLookup(CoD.BlackMarketUtility.emblemIconsTableName, 3, 1, f64_arg1)
end
CoD.BlackMarketUtility.GetLootDecalEntitlementName = function(f65_arg0, f65_arg1)
	return Engine.TableLookup(CoD.BlackMarketUtility.emblemIconsTableName, 7, 1, f65_arg1)
end
CoD.BlackMarketUtility.GetStickerNameRef = function(f66_arg0)
	return Engine.TableLookup(CoD.BlackMarketUtility.emblemIconsTableName, 4, 3, f66_arg0)
end
CoD.BlackMarketUtility.GetJumpPackRefs = function(f67_arg0)
	local f67_local0 = 0x0
	local f67_local1 = 0x0
	local f67_local2 = 0x0
	for f67_local6, f67_local7 in ipairs(Engine[@"hash_7A7E3CD65E63086F"]("jumpkits")) do
		if f67_local7.lootid == f67_arg0 then
			f67_local0 = f67_local7.displayname
			if f67_local7[@"preview_image"] then
				f67_local1 = Engine[@"converttoxhash"](f67_local7[@"preview_image"])
			end
			if f67_local7.image then
				f67_local2 = Engine[@"converttoxhash"](f67_local7.image)
			end
			if f67_local2 and f67_local1 == 0x0 then
			elseif f67_local1 and f67_local2 == 0x0 then
				f67_local2 = f67_local1
				break
			end
			f67_local1 = f67_local2
		end
	end
	return f67_local0, f67_local1, f67_local2
end
CoD.BlackMarketUtility.GetParachuteRefs = function(f68_arg0)
	local f68_local0 = 0x0
	local f68_local1 = 0x0
	local f68_local2 = 0x0
	for f68_local8, f68_local9 in ipairs(Engine[@"hash_7A7E3CD65E63086F"]("jumpkits")) do
		if f68_local9.lootid == f68_arg0 then
			f68_local0 = f68_local9.displayname
			local f68_local6 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f68_local9.parachute))
			if f68_local6.icon then
				local f68_local7 = Engine[@"converttoxhash"](f68_local6.icon)
				f68_local1 = f68_local7
				f68_local2 = Engine[@"converttoxhash"](f68_local6.largeicon) or f68_local7
			end
		end
	end
	return f68_local0, f68_local1, f68_local2
end
CoD.BlackMarketUtility.GetWingsuitRefs = function(f69_arg0)
	local f69_local0 = 0x0
	local f69_local1 = 0x0
	local f69_local2 = 0x0
	for f69_local8, f69_local9 in ipairs(Engine[@"hash_7A7E3CD65E63086F"]("jumpkits")) do
		if f69_local9.lootid == f69_arg0 then
			f69_local0 = f69_local9.displayname
			local f69_local6 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f69_local9.wingsuit))
			if f69_local6.icon then
				local f69_local7 = Engine[@"converttoxhash"](f69_local6.icon)
				f69_local1 = f69_local7
				f69_local2 = Engine[@"converttoxhash"](f69_local6.largeicon) or f69_local7
			end
		end
	end
	return f69_local0, f69_local1, f69_local2
end
CoD.BlackMarketUtility.GetTrailRefs = function(f70_arg0)
	local f70_local0 = 0x0
	local f70_local1 = 0x0
	local f70_local2 = 0x0
	for f70_local8, f70_local9 in ipairs(Engine[@"hash_7A7E3CD65E63086F"]("jumpkits")) do
		if f70_local9.lootid == f70_arg0 then
			f70_local0 = f70_local9.displayname
			local f70_local6 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f70_local9.dropfxtrail))
			if f70_local6.icon then
				local f70_local7 = Engine[@"converttoxhash"](f70_local6.icon)
				f70_local1 = f70_local7
				f70_local2 = Engine[@"converttoxhash"](f70_local6.largeicon) or f70_local7
			end
		end
	end
	return f70_local0, f70_local1, f70_local2
end
CoD.BlackMarketUtility.GetDeathFxWeaponRef = function(f71_arg0, f71_arg1, f71_arg2, f71_arg3, f71_arg4)
	local f71_local0 = 0x0
	if f71_arg2 == LuaEnum.LOOT_TYPE.SEASON then
		f71_local0 = CoD.BlackMarketTableUtility.GetSeasonDeathFxWeaponName(f71_arg0, f71_arg1)
	elseif f71_arg2 == LuaEnum.LOOT_TYPE.CONTRACT then
		f71_local0 = CoD.BlackMarketTableUtility.GetContractDeathFxWeaponName(f71_arg0, f71_arg1, f71_arg3)
	elseif f71_arg2 == LuaEnum.LOOT_TYPE.ITEMSHOP then
		f71_local0 = CoD.BlackMarketTableUtility.GetItemShopDeathFxWeaponName(f71_arg0, f71_arg1)
	elseif f71_arg2 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f71_local0 = CoD.BlackMarketTableUtility.GetContrabandDeathFxWeaponName(f71_arg0, f71_arg4)
	elseif f71_arg2 == LuaEnum.LOOT_TYPE.BUNDLE then
		f71_local0 = CoD.BlackMarketTableUtility.GetBundleDeathFxWeaponName(f71_arg0, f71_arg1)
	end
	return f71_local0
end
CoD.BlackMarketUtility.GetDeathFxRefs = function(f72_arg0)
	local f72_local0 = 0x0
	local f72_local1 = 0x0
	local f72_local2 = 0x0
	local f72_local3 = Engine[@"hash_7A7E3CD65E63086F"]("weapondeathfx_list")
	if f72_local3 then
		for f72_local7, f72_local8 in ipairs(f72_local3) do
			if f72_local8.lootid == f72_arg0 then
				f72_local0 = f72_local8.displayname
				f72_local1 = f72_local8[@"previewimage"]
				if f72_local8.image then
					f72_local2 = Engine[@"converttoxhash"](f72_local8.image)
				end
				return f72_local0, f72_local1, f72_local2
			end
		end
	end
	return f72_local0, f72_local1, f72_local2
end
CoD.BlackMarketUtility.GetWeaponCharmRefs = function(f73_arg0)
	local f73_local0 = 0x0
	local f73_local1 = 0x0
	local f73_local2 = 0x0
	local f73_local3 = Engine[@"hash_7A7E3CD65E63086F"]("weaponcharm_list")
	if f73_local3 then
		for f73_local7, f73_local8 in ipairs(f73_local3) do
			if f73_local8.lootid == f73_arg0 then
				f73_local0 = f73_local8.displayname
				f73_local1 = f73_local8[@"previewimage"]
				if f73_local8.image then
					f73_local2 = Engine[@"converttoxhash"](f73_local8.image)
				end
				return f73_local0, f73_local1, f73_local2
			end
		end
	end
	return f73_local0, f73_local1, f73_local2
end
CoD.BlackMarketUtility.GetCallingCardTitleFromImage = function(f74_arg0)
	local f74_local0 = 3
	local f74_local1 = 4
	local f74_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f74_local1, f74_local0, f74_arg0)
	if not f74_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f74_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f74_local1, 19, f74_arg0)
	end
	return f74_local2
end
CoD.BlackMarketUtility.GetCallingCardTitleFromMasterImage = function(f75_arg0)
	local f75_local0 = 15
	local f75_local1 = 4
	local f75_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f75_local1, f75_local0, f75_arg0)
	if not f75_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f75_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f75_local1, 19, f75_arg0)
	end
	return f75_local2
end
CoD.BlackMarketUtility.GetCallingCardIdFromImage = function(f76_arg0)
	local f76_local0 = 3
	local f76_local1 = 1
	local f76_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f76_local1, f76_local0, f76_arg0)
	if not f76_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f76_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f76_local1, 19, f76_arg0)
	end
	return f76_local2
end
CoD.BlackMarketUtility.GetMasterCallingCardIdFromImage = function(f77_arg0)
	local f77_local0 = 15
	local f77_local1 = 1
	local f77_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f77_local1, f77_local0, f77_arg0)
	if not f77_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f77_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f77_local1, 19, f77_arg0)
	end
	return f77_local2
end
CoD.BlackMarketUtility.GetCallingCardSortKeyFromImage = function(f78_arg0)
	local f78_local0 = 3
	local f78_local1 = 2
	local f78_local2 = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f78_local1, f78_local0, f78_arg0)
	if not f78_local2 and CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		cardId = Engine.TableLookup(CoD.BlackMarketUtility.backgroundsTable, f78_local1, 19, f78_arg0)
	end
	return f78_local2
end
CoD.BlackMarketUtility.GetRarityForCallingCardSetFromSetName = function(f79_arg0)
	return CoD.BlackMarketUtility.CrateTypeStrings[CoD.BlackMarketUtility.GetRarityIDForString(Engine.TableLookup(CoD.BlackMarketUtility.lootTableName, 3, 4, f79_arg0))]
end
CoD.BlackMarketUtility.GetRarityTypeForLootItemFromName = function(f80_arg0)
	return Engine.TableLookup(CoD.BlackMarketUtility.lootTableName, 3, 1, f80_arg0)
end
CoD.BlackMarketUtility.GetRarityForLootItemFromName = function(f81_arg0)
	local f81_local0 = CoD.BlackMarketUtility.GetRarityTypeForLootItemFromName(f81_arg0)
	if f81_local0 == "" then
		return ""
	else
		return CoD.BlackMarketUtility.CrateTypeStrings[CoD.BlackMarketUtility.GetRarityIDForString(f81_local0)]
	end
end
CoD.BlackMarketUtility.GetHeroDisplayNameForAssetName = function(f82_arg0)
	for f82_local3, f82_local4 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Enum.eModes.mode_multiplayer)) do
		if f82_local4.assetName == f82_arg0 then
			return f82_local4.displayName
		end
	end
	return f82_arg0
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
CoD.BlackMarketUtility.GetFakeItem = function(f83_arg0)
	return f0_local0[math.random(1, #f0_local0)]
end
CoD.BlackMarketUtility.GetOutfitOptionInfo = function(f84_arg0, f84_arg1)
	local f84_local0 = {}
	local f84_local1 = ""
	local f84_local2 = function(f85_arg0, f85_arg1)
		if f85_arg0 and 0 <= f85_arg0 then
			if f85_arg1 ~= Enum.CharacterItemType[@"hash_4922FE5C41D9EE8B"] then
				table.insert(f84_local0, f85_arg1)
			end
			f84_local1 = f84_local1 .. tostring(f85_arg0) .. ";"
		else
			f84_local1 = f84_local1 .. "0;"
		end
	end
	f84_local2(f84_arg1.armsIndex, Enum.CharacterItemType[@"hash_141B42F0A58AC50F"])
	f84_local2(f84_arg1.decalIndex, Enum.CharacterItemType[@"hash_57852FCB3BFCC8D1"])
	f84_local2(f84_arg1.headIndex, Enum.CharacterItemType[@"hash_37AD40A4111A72FE"])
	f84_local2(f84_arg1.headgearIndex, Enum.CharacterItemType[@"hash_4FF8573E011622F4"])
	f84_local2(f84_arg1.legsIndex, Enum.CharacterItemType[@"hash_283CBB806B732B11"])
	f84_local2(f84_arg1.paletteIndex, Enum.CharacterItemType[@"hash_4922FE5C41D9EE8B"])
	f84_local2(f84_arg1.torsoIndex, Enum.CharacterItemType[@"hash_19DDCEC39BA98B97"])
	f84_local2(f84_arg1.war_paintIndex, Enum.CharacterItemType[@"hash_48E3A65D78229DC1"])
	return f84_local0, f84_local1
end
CoD.BlackMarketUtility.PreviewingCharacterFace = function(f86_arg0, f86_arg1)
	local f86_local0, f86_local1 = CoD.BlackMarketUtility.GetOutfitOptionInfo(f86_arg0, f86_arg1)
	local f86_local2 = false
	local f86_local3 = false
	for f86_local7, f86_local8 in ipairs(f86_local0) do
		if f86_local8 == Enum.CharacterItemType[@"hash_48E3A65D78229DC1"] or f86_local8 == Enum.CharacterItemType[@"hash_37AD40A4111A72FE"] or f86_local8 == Enum.CharacterItemType[@"hash_4FF8573E011622F4"] then
			f86_local2 = true
		else
			f86_local3 = true
		end
	end
	if f86_local2 and not f86_local3 then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.NotifyPreviewOutfit = function(f87_arg0, f87_arg1, f87_arg2)
	local f87_local0, f87_local1 = CoD.BlackMarketUtility.GetOutfitOptionInfo(f87_arg0, f87_arg1)
	Engine.SendClientScriptNotify(f87_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f87_arg0), {
		event_name = f87_arg2,
		mode = f87_arg1.mode,
		character_index = f87_arg1.characterIndex,
		outfit_index = f87_arg1.outfitIndex,
		outfitItems = f87_local1,
	})
	return f87_local0
end
CoD.BlackMarketUtility.NotifyLoadCharacterForGesture = function(f88_arg0, f88_arg1)
	Engine.SendClientScriptNotify(f88_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f88_arg0), {
		event_name = "previewShopGesture",
		mode = f88_arg1.mode,
		character_index = f88_arg1.characterIndex,
	})
end
CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection = function(f89_arg0, f89_arg1, f89_arg2)
	f89_arg2 = f89_arg2.activeWidget or f89_arg2
	local f89_local0 = f89_arg2:getModel()
	local f89_local1 = "default"
	if not f89_local0 then
		f89_arg0._lastState = f89_local1
		SendClientScriptMenuChangeNotifyWithState(f89_arg1, f89_arg0, true, f89_local1)
		return
	elseif f89_arg0._lastState == "gesture" then
		CoD.PlayerRoleUtility.StopGesturePreview(f89_arg0, f89_arg1)
		CoD.PlayerRoleUtility.RefreshAnim(f89_arg1)
	elseif f89_arg0._lastState == "weapon" then
		CoD.BlackMarketUtility.ResetSignatureWeaponState(f89_arg0)
		SendClientScriptMenuChangeNotifyWithState(f89_arg1, f89_arg0, true, "default")
	end
	if (not f89_local0.isWeaponBribeSelect or not f89_local0.isWeaponBribeSelect:get()) and CoD.ModelUtility.IsSelfModelValueNonEmptyString(f89_arg2, f89_arg1, "popupImage") then
		SendClientScriptMenuChangeNotifyWithState(f89_arg1, f89_arg0, true, f89_local1)
		return
	elseif not f89_local0.cameraType or not f89_local0.isContract then
		f89_arg0._lastState = f89_local1
		SendClientScriptMenuChangeNotifyWithState(f89_arg1, f89_arg0, true, f89_local1)
		return
	elseif f89_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.WEAPON then
		local f89_local2 = f89_arg2
		if f89_arg2.contractModels and f89_local0.isContract:get() then
			f89_local2 = f89_arg2.contractModels
		end
		if f89_local0.contractModels and f89_local0.isContract:get() then
			f89_local0 = f89_local0.contractModels
		end
		if f89_local2.signatureWeaponInfo and f89_local0 ~= nil and f89_local2.signatureWeaponInfo.ref == f89_local0.weaponRef:get() then
			f89_local1 = "weapon"
			CoD.BlackMarketUtility.SendSignatureWeaponUpdate(f89_arg0, f89_arg1, f89_local0, f89_local2.signatureWeaponInfo)
		elseif f89_local2.baseWeaponInfo and f89_local0 ~= nil then
			f89_local1 = "weapon"
			CoD.BlackMarketUtility.SendWeaponUpdate(f89_arg0, f89_arg1, f89_local0, f89_local2.baseWeaponInfo, f89_local2.camoRef)
		end
	elseif f89_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.GESTURE then
		if f89_arg2.characterIndex ~= nil then
			f89_local1 = "gesture"
			CoD.BlackMarketUtility.NotifyLoadCharacterForGesture(f89_arg1, f89_arg2)
		end
	elseif f89_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.CHARACTER then
		local f89_local2 = f89_arg2
		if f89_arg2.contractModels and f89_local0.isContract:get() then
			f89_local2 = f89_arg2.contractModels.outfitIndexes
		end
		if f89_local2 ~= nil and f89_local2.characterIndex ~= nil and f89_local2.outfitIndex ~= nil then
			CoD.BlackMarketUtility.NotifyPreviewOutfit(f89_arg1, f89_local2, "previewShop")
			f89_local1 = "character"
		end
	elseif f89_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.WARPAINT then
		local f89_local2 = f89_arg2
		if f89_arg2.contractModels and f89_local0.isContract:get() then
			f89_local2 = f89_arg2.contractModels.outfitIndexes
		end
		if f89_local2 ~= nil and f89_local2.characterIndex ~= nil and f89_local2.outfitIndex ~= nil then
			CoD.BlackMarketUtility.NotifyPreviewOutfit(f89_arg1, f89_local2, "previewShopFace")
			f89_local1 = "character_face"
		end
	elseif f89_local0.cameraType:get() == LuaEnum.LOOT_CAMERA_TYPE.CRATE then
		f89_local1 = "crate"
	end
	f89_arg0._lastState = f89_local1
	SendClientScriptMenuChangeNotifyWithState(f89_arg1, f89_arg0, true, f89_local1)
end
CoD.BlackMarketUtility.GetEmptyInsertItem = function(f90_arg0, f90_arg1)
	return {
		itemName = 0x0,
		name = 0x0,
		desc = "",
		mainExtraText = "",
		subExtraText = 0x0,
		category = 0x0,
		shopCategory = 0x0,
		primaryImage = "blacktransparent",
		popupImage = "blacktransparent",
		detailsImage = "blacktransparent",
		rarity = 0x0,
		character = 0x0,
		outfitIndexes = nil,
		gesture_index = -1,
		signatureWeaponInfo = nil,
		baseWeaponInfo = nil,
		camoRef = nil,
		setBonusImage = 0x0,
		setComplete = false,
		setNumOwned = 0,
		setNumTotal = 0,
		tier = f90_arg0,
		unlocked = f90_arg1,
		dupe = false,
		reroll = false,
		gap = false,
		lootType = LuaEnum.LOOT_TYPE.EMPTY,
		isBundle = false,
		seasonal = false,
		allowFrozenMoment = false,
		price = 0,
		inventoryIcon = "blacktransparent",
		earnedRewardCount = 0,
		totalRewardCount = 0,
		cameraType = LuaEnum.LOOT_CAMERA_TYPE.NONE,
		isContract = false,
		purchased = false,
		movieName = "",
		toolTipText = 0x0,
	}
end
CoD.BlackMarketUtility.ActivateContract = function(f91_arg0, f91_arg1, f91_arg2)
	if f91_arg2 ~= CoDShared.Loot.ContractSlots.SLOT_1 and f91_arg2 ~= CoDShared.Loot.ContractSlots.SLOT_2 then
		return false
	else
		local f91_local0 = CoD.BlackMarketTableUtility.GetContractId(f91_arg1)
		if f91_local0 == nil or f91_local0 == 0 then
			return false
		else
			local f91_local1 = Engine.StorageGetBuffer(f91_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
			if f91_local1 == nil then
				return false
			else
				local f91_local2 = f91_local1.loot_contracts[f91_arg2]
				if f91_local2 ~= nil then
					f91_local2.contractId:set(f91_local0)
					local f91_local3 = CoD.BlackMarketTableUtility.GetContractTierCount(f91_local0) - CoD.BlackMarketUtility.GetContractProgress(f91_arg0, f91_arg1)
					if f91_local3 < 0 then
						f91_local3 = 0
					end
					local f91_local4 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f91_arg0)
					local f91_local5 = 0
					if f91_local4 ~= nil then
						f91_local5 = f91_local4 + f91_local3
					end
					f91_local2.completionTier:set(f91_local5)
					Engine.StorageWrite(f91_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
					Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "Contracts: Contract '" .. f91_local0 .. "' activated for controller " .. f91_arg0 .. ".\n")
					return true
				else
					return false
				end
			end
		end
	end
end
CoD.BlackMarketUtility.GetContractProgress = function(f92_arg0, f92_arg1)
	return Engine[@"hash_6159D7050715A2C3"](f92_arg0, f92_arg1)
end
CoD.BlackMarketUtility.IsContractCompleted = function(f93_arg0, f93_arg1)
	local f93_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f93_arg1)
	return CoD.BlackMarketTableUtility.GetContractTierCount(f93_local0.id) <= CoD.BlackMarketUtility.GetContractProgress(f93_arg0, f93_local0.namehash)
end
CoD.BlackMarketUtility.GetActiveContracts = function(f94_arg0)
	local f94_local0 = Engine.StorageGetBuffer(f94_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
	if f94_local0 == nil then
		return {}
	end
	local f94_local1 = {}
	for f94_local7, f94_local8 in pairs(CoDShared.Loot.ContractSlots) do
		local f94_local9 = f94_local0.loot_contracts[f94_local8]
		if f94_local9 ~= nil then
			local f94_local5 = f94_local9.contractId:get()
			if f94_local5 > 0 then
				local f94_local6 = CoD.BlackMarketTableUtility.GetContractInfo(f94_local5)
				if f94_local6 ~= nil then
					f94_local6.slot = f94_local8
					table.insert(f94_local1, f94_local6)
				end
			end
		end
	end
	return f94_local1
end
CoD.BlackMarketUtility.GetTierItemsForContractTab = function(f95_arg0, f95_arg1, f95_arg2, f95_arg3)
	local f95_local0 = {}
	if Dvar[@"hash_4467C80C4ECD6FC8"]:get() == false then
	else
	end
	local f95_local1 = CoD.BlackMarketTableUtility.GetContractInfo(f95_arg1)
	if f95_local1 == nil then
		return {}
	end
	local f95_local2 = CoD.BlackMarketUtility.GetContractProgress(f95_arg0, f95_local1.namehash)
	for f95_local3 = f95_arg2, f95_arg3, 1 do
		local f95_local6 = f95_local3 <= f95_local2
		local f95_local7 = CoD.BlackMarketTableUtility.GetContractItemsByTier(f95_arg0, f95_arg1, f95_local3, f95_local6)
		local f95_local8 = CoD.BlackMarketUtility.GetEmptyInsertItem(f95_local3, f95_local6)
		if f95_local7 ~= nil and #f95_local7 ~= 0 and f95_local7[1].name ~= nil and f95_local7[1].name ~= 0x0 and f95_local7[1].category ~= nil and f95_local7[1].rarity ~= nil then
			local f95_local9 = {}
			f95_local9 = CoD.BlackMarketUtility.GetItemRefs(f95_arg0, f95_local7[1].name, f95_local7[1].category, f95_local7[1].rarity, f95_local7[1].inSet, f95_arg1, f95_local7[1].lootType, f95_local7[1].refOptic, f95_local7[1].itemId)
			f95_local9.tier = f95_local3
			f95_local9.unlocked = f95_local6
			f95_local9.lootType = f95_local7[1].lootType
			if f95_local7[1].dupe then
				f95_local9.dupe = f95_local7[1].dupe
			else
				f95_local9.dupe = false
			end
			if f95_local7[1].reroll then
				f95_local9.reroll = f95_local7[1].reroll
			else
				f95_local9.reroll = false
			end
			f95_local9.movieName = f95_local7[1].movieName or ""
			if f95_local9.movieName and f95_local9.movieName ~= "" then
				f95_local9.isLooping = true
				f95_local9.isStreamed = false
			end
			f95_local9.gap = true
			f95_local8 = f95_local9
		end
		table.insert(f95_local0, f95_local8)
	end
	return f95_local0
end
CoD.BlackMarketUtility.GetItemProductAndProperties = function(f96_arg0)
	local f96_local0 = f96_arg0
	local f96_local1 = {}
	if f96_local0.signatureWeaponInfo and f96_local0.signatureWeaponInfo.ref then
		f96_local0.weaponRef = f96_local0.signatureWeaponInfo.ref
		f96_local1.signatureWeaponInfo = f96_local0.signatureWeaponInfo
	elseif f96_local0.baseWeaponInfo and f96_local0.baseWeaponInfo.ref then
		f96_local0.weaponRef = f96_local0.baseWeaponInfo.ref
		f96_local1.baseWeaponInfo = f96_local0.baseWeaponInfo
	else
		f96_local0.weaponRef = 0x0
	end
	if f96_local0.camoRef then
		f96_local1.camoRef = f96_local0.camoRef
	end
	if f96_local0.outfitIndexes then
		f96_local1 = f96_local0.outfitIndexes
	end
	f96_local1.gesture_index = f96_local0.gesture_index
	return f96_local0, f96_local1
end
DataSources.ContractTierItems = ListHelper_SetupDataSource("ContractTierItems", function(f97_arg0, f97_arg1)
	local f97_local0 = {}
	local f97_local1 = nil
	local f97_local2 = false
	if f97_arg1.menu then
		local f97_local3 = f97_arg1.menu:getModel(f97_arg0, "contractId")
		f97_local1 = f97_local3 and f97_local3:get()
		local f97_local4 = f97_arg1.menu:getModel(f97_arg0, "purchased")
		f97_local2 = f97_local4 and f97_local4:get()
	end
	if not f97_local1 then
		return f97_local0
	end
	local f97_local3 = CoD.BlackMarketTableUtility.GetContractTierCount(f97_local1)
	local f97_local4 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f97_arg0)
	local f97_local5 = Engine.GetModelForController(f97_arg0)
	f97_local5 = f97_local5.FocusedTier
	local f97_local6
	if f97_local5 then
		f97_local6 = f97_local5:get()
		if not f97_local6 then
		else
			local f97_local7 = CoD.BlackMarketUtility.GetTierItemsForContractTab(f97_arg0, f97_local1, f97_local6, f97_local6 + 4)
			for f97_local8 = 1, #f97_local7, 1 do
				if f97_local7[f97_local8].name ~= 0x0 then
					local f97_local11, f97_local12 = CoD.BlackMarketUtility.GetItemProductAndProperties(f97_local7[f97_local8])
					f97_local11.tierCount = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2447CBFFBA0F8D66", f97_local8 + f97_local6 - 1, f97_local3)
					table.insert(f97_local0, {
						models = f97_local11,
						properties = f97_local12,
					})
				end
			end
			return f97_local0
		end
	end
	f97_local6 = 1
end)
DataSources.BundleItemsList = ListHelper_SetupDataSource("BundleItemsList", function(f98_arg0, f98_arg1)
	local f98_local0 = {}
	local f98_local1 = nil
	if f98_arg1.menu then
		local f98_local2 = f98_arg1.menu:getModel(f98_arg0, "hashName")
		f98_local1 = f98_local2 and f98_local2:get()
	end
	if not f98_local1 then
		return f98_local0
	end
	local f98_local2 = CoD.BlackMarketTableUtility.GetBundlePiecesInformation(f98_arg0, f98_local1)
	if f98_local2 then
		local f98_local3 = 1
		local f98_local4 = Engine.GetModelForController(f98_arg0)
		f98_local4 = f98_local4.FocusedTier
		if f98_local4 then
			f98_local3 = f98_local4:get() or 1
		end
		for f98_local5 = f98_local3, math.min(#f98_local2, f98_local3 + 4), 1 do
			local f98_local8 = f98_local2[f98_local5]
			local f98_local9 = {}
			f98_local9 = CoD.BlackMarketUtility.GetItemRefs(f98_arg0, f98_local8.name, f98_local8.category, f98_local8.rarity, f98_local8.inSet, nil, f98_local8.lootType, f98_local8.refOptic, f98_local8.itemId)
			if IsBooleanDvarSet(@"hash_1A8E4D68B803874") and CoD.BlackMarketUtility.BlackjackShopSunsetOverridePopupImageItems[f98_local8.name] then
				f98_local9.popupImage = f98_local9.primaryImage
			end
			local f98_local10, f98_local11 = CoD.BlackMarketUtility.GetItemProductAndProperties(f98_local9)
			f98_local10.gap = true
			table.insert(f98_local0, {
				models = f98_local10,
				properties = f98_local11,
			})
		end
	end
	return f98_local0
end)
CoD.BlackMarketUtility.GetItemQuantity = function(f99_arg0, f99_arg1)
	return 1
end
CoD.BlackMarketUtility.UnlockedByPrerequisites = function(f100_arg0, f100_arg1)
	if type(f100_arg1) == "string" then
		f100_arg1 = Engine[@"converttoxhash"](f100_arg1)
	end
	return false
end
CoD.BlackMarketUtility.IsItemLocked = function(f101_arg0, f101_arg1)
	if Dvar[@"hash_34D39FCDA04AE7A8"]:get() == "1" then
		return false
	elseif f101_arg1 then
		local f101_local0 = CoD.BlackMarketUtility.GetItemQuantity(f101_arg0, f101_arg1)
		if f101_local0 == nil then
			local f101_local1 = CoD.BlackMarketUtility.UnlockedByPrerequisites(f101_arg0, f101_arg1)
			if f101_local1 ~= nil then
				return not f101_local1
			end
		end
		if f101_local0 == nil or f101_local0 == 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end
CoD.BlackMarketUtility.ClassContainsLockedItems = function(f102_arg0, f102_arg1)
	local f102_local0 = CoD.SafeGetModelValue(f102_arg1, "primary.ref")
	if f102_local0 and f102_local0 ~= "" and CoD.BlackMarketUtility.GetItemQuantity(f102_arg0, Engine[@"converttoxhash"](f102_local0)) == 0 then
		return true
	else
		local f102_local1 = CoD.SafeGetModelValue(f102_arg1, "secondary.ref")
		if f102_local1 and f102_local1 ~= "" and CoD.BlackMarketUtility.GetItemQuantity(f102_arg0, Engine[@"converttoxhash"](f102_local1)) == 0 then
			return true
		else
			return false
		end
	end
end
CoD.BlackMarketUtility.ClassifiedName = function(f103_arg0)
	local f103_local0 = @"menu/classified"
	if f103_arg0 then
		return Engine[@"hash_4F9F1239CFD921FE"](f103_local0)
	else
		return f103_local0
	end
end
CoD.BlackMarketUtility.GetCallingCardSetTable = function(f104_arg0)
	for f104_local3, f104_local4 in ipairs(CoD.BlackMarketUtility.CallingCardsTable) do
		if f104_local4.setRef == f104_arg0 then
			return f104_local4
		end
	end
end
CoD.BlackMarketUtility.GetCallingCardRows = function()
	local f105_local0 = Engine.TableFindRows(CoD.BlackMarketUtility.lootTableName, 2, "calling_card")
	if not f105_local0 then
		return {}
	end
	for f105_local1 = #f105_local0, 1, -1 do
		if CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f105_local0[f105_local1], CoD.BlackMarketUtility.lootNameCol)) then
			table.remove(f105_local0, f105_local1)
		end
	end
	return f105_local0
end
CoD.BlackMarketUtility.GetCallingCardSetCaptstones = function(f106_arg0)
	local f106_local0 = "calling_card"
	local f106_local1 = 0
	local f106_local2 = 1
	local f106_local3 = 2
	local f106_local4 = CoD.BlackMarketTableUtility.LootBonusTable.name
	local f106_local5 = Engine.TableFindRows(f106_local4, f106_local2, f106_local0)
	local f106_local6 = {}
	for f106_local7 = #f106_local5, 1, -1 do
		local f106_local10 = Engine[@"hash_4C6F8EC444864600"](f106_local4, f106_local5[f106_local7], f106_local1)
		if not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(f106_local10) then
			f106_local6[f106_local7] = {}
			f106_local6[f106_local7].name = f106_local10
			f106_local6[f106_local7].setName = Engine[@"hash_4C6F8EC444864600"](f106_local4, f106_local5[f106_local7], f106_local3)
			f106_local6[f106_local7].description = CoD.BlackMarketUtility.GetCallingCardTitleFromImage(f106_local10)
		end
	end
	return f106_local6
end
CoD.BlackMarketUtility.GetLootTypeRows = function(f107_arg0)
	return Engine.TableFindRows(CoD.BlackMarketUtility.lootTableName, 2, f107_arg0)
end
CoD.BlackMarketUtility.CleanupCachedCallingCardData = function(f108_arg0)
	CoD.BlackMarketUtility.CallingCardsTable = {}
	CoD.BlackMarketUtility.CommonCallingCardsTable = {}
end
CoD.BlackMarketUtility.BuildCallingCardSets = function(f109_arg0, f109_arg1)
	CoD.BlackMarketUtility.CallingCardsTable = {}
	CoD.BlackMarketUtility.CommonCallingCardsTable = {}
	local f109_local0 = {}
	local f109_local1 = false
	local f109_local2 = 1
	local f109_local3 = 3
	local f109_local4 = 4
	local f109_local5 = 9
	local f109_local6 = 15
	local f109_local7 = Engine.TableFindRows(CoD.BlackMarketUtility.backgroundsTable, f109_local5, "loot")
	if f109_local7 then
		for f109_local19, f109_local20 in ipairs(f109_local7) do
			local f109_local11 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f109_local20, f109_local3)
			local f109_local21 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f109_local20, f109_local4)
			local f109_local22 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f109_local20, f109_local6)
			local f109_local23 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.backgroundsTable, f109_local20, f109_local2)
			if f109_local22 and f109_local22 ~= 0x0 then
				f109_local11 = f109_local22
			end
			local f109_local12 = CoD.BlackMarketTableUtility.LootInfoLookup(f109_arg0, f109_local11)
			if f109_local12 then
				if not f109_local1 then
					f109_local1 = f109_local12.available == true
				end
				local f109_local13 = nil
				if f109_local12.inSet then
					if not f109_local0[f109_local12.inSet] then
						f109_local0[f109_local12.inSet] = {}
					end
					f109_local13 = f109_local0[f109_local12.inSet]
				elseif f109_local12.owned or f109_local12.available then
					f109_local13 = CoD.BlackMarketUtility.CommonCallingCardsTable
				end
				local f109_local14 = Engine[@"hash_4F9F1239CFD921FE"](f109_local21)
				if f109_local12.isLoot and not f109_local12.available then
					f109_local14 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/classified")
				end
				if f109_local13 then
					local f109_local15 = table.insert
					local f109_local16 = f109_local13
					local f109_local17 = {
						displayName = f109_local14,
					}
					local f109_local18 = CoD.BlackMarketUtility.LootIdRarities[f109_local12.rarity]
					if not f109_local18 then
						f109_local18 = Enum.LootRarityType[@"loot_rarity_type_count"]
					end
					f109_local17.rarity = f109_local18
					f109_local17.iconId = f109_local23
					f109_local17.tier = f109_local12.unlockTier or 0
					f109_local17.season = f109_local12.seasonIndex or 0
					f109_local17.lootInfo = f109_local12
					f109_local15(f109_local16, f109_local17)
				end
			end
		end
	end
	for f109_local19, f109_local20 in pairs(f109_local0) do
		local f109_local11 = 0
		local f109_local21 = 0
		local f109_local22 = #f109_local20
		local f109_local23 = Enum.LootRarityType[@"loot_rarity_type_count"]
		local f109_local12 = 0
		local f109_local13, f109_local14 = nil
		local f109_local15 = 0
		for f109_local24, f109_local25 in ipairs(f109_local20) do
			if f109_local25.lootInfo.setMaster then
				f109_local13 = f109_local25.iconId
				f109_local14 = f109_local25
				f109_local22 = f109_local22 - 1
			else
				if f109_local25.lootInfo.owned or not f109_local25.lootInfo.isLoot then
					f109_local11 = f109_local11 + 1
					f109_local21 = f109_local21 + 1
					f109_local12 = f109_local25.iconId
				elseif f109_local25.lootInfo.available or not f109_local25.lootInfo.isLoot then
					f109_local21 = f109_local21 + 1
				end
				if f109_local25.rarity ~= Enum.LootRarityType[@"loot_rarity_type_count"] and (f109_local23 == Enum.LootRarityType[@"loot_rarity_type_count"] or f109_local23 < f109_local25.rarity) then
					f109_local23 = f109_local25.rarity
				end
			end
			if f109_local25.lootInfo.owned and CoD.BreadcrumbUtility.IsStatCallingCardNew(f109_arg1, f109_arg0, f109_local25.iconId) then
				f109_local15 = f109_local15 + 1
			end
		end
		if f109_local21 > 0 then
			f109_local16 = CoD.BlackMarketTableUtility.GetLootBonusStringRef(f109_arg0, f109_local19)
			f109_local17 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1587BB89C78FFE9A", f109_local16, f109_local11, f109_local22)
			if f109_local14 then
				f109_local14.setInfoString = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F4082FA89EBEDBA", f109_local16, Engine[@"hash_4F9F1239CFD921FE"](@"hash_120BF14474EB8696", Engine[@"hash_4F9F1239CFD921FE"](@"menu/calling_card")))
				if not IsJapaneseSku() and f109_local14.lootInfo.owned then
					f109_local12 = f109_local14.iconId
					f109_local14.lootInfo.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_complete")
				else
					f109_local14.lootInfo.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_incomplete")
				end
			end
			if f109_local12 == 0 then
				f109_local12 = f109_local20[1].iconId
			end
			table.insert(CoD.BlackMarketUtility.CallingCardsTable, {
				setRef = f109_local19,
				setInfoString = f109_local17,
				rarity = f109_local23,
				iconId = f109_local12,
				callingCards = f109_local20,
				numOwned = f109_local11,
				highestTier = f109_local20[f109_local22].tier,
				bonusCardInfo = f109_local14,
				breadcrumbCount = f109_local15,
			})
		end
	end
	table.sort(CoD.BlackMarketUtility.CallingCardsTable, function(f110_arg0, f110_arg1)
		if f110_arg0.rarity ~= f110_arg1.rarity then
			return f110_arg1.rarity < f110_arg0.rarity
		elseif f110_arg0.season ~= f110_arg1.season then
			return f110_arg1.season < f110_arg0.season
		else
			return f110_arg0.highestTier < f110_arg1.highestTier
		end
	end)
	table.sort(CoD.BlackMarketUtility.CommonCallingCardsTable, function(f111_arg0, f111_arg1)
		return f111_arg0.iconId < f111_arg1.iconId
	end)
	return f109_local1
end
CoD.BlackMarketUtility.SortUnlockIconId = function(f112_arg0, f112_arg1)
	if f112_arg0.isSetBMClassified ~= f112_arg1.isSetBMClassified then
		return f112_arg1.isSetBMClassified
	else
		return f112_arg0.iconId < f112_arg1.iconId
	end
end
CoD.BlackMarketUtility.SortUnlocksModelIconId = function(f113_arg0, f113_arg1)
	if f113_arg0.models.isBMClassified ~= f113_arg1.models.isBMClassified then
		return f113_arg1.models.isBMClassified
	else
		return f113_arg0.models.iconId < f113_arg1.models.iconId
	end
end
CoD.BlackMarketUtility.SortUnlocksPropertyIndex = function(f114_arg0, f114_arg1)
	if f114_arg0.models.isBMClassified ~= f114_arg1.models.isBMClassified then
		return f114_arg1.models.isBMClassified
	else
		return f114_arg0.properties.index < f114_arg1.properties.index
	end
end
CoD.BlackMarketUtility.SortUnlocksPropertyVariantIndex = function(f115_arg0, f115_arg1)
	if f115_arg0.models.isBMClassified ~= f115_arg1.models.isBMClassified then
		return f115_arg1.models.isBMClassified
	else
		return f115_arg0.properties.variantIndex < f115_arg1.properties.variantIndex
	end
end
CoD.BlackMarketUtility.SortUnlocksModelEmblemIconID = function(f116_arg0, f116_arg1)
	local f116_local0 = f116_arg0.owned:get()
	local f116_local1 = f116_arg1.owned:get()
	if f116_local0 == true and f116_local1 == false then
		return true
	elseif f116_local0 == false and f116_local1 == true then
		return false
	else
		return f116_arg0.sortKey:get() < f116_arg1.sortKey:get()
	end
end
CoD.BlackMarketUtility.SortUnlocksModelIconID = function(f117_arg0, f117_arg1)
	local f117_local0 = f117_arg0.isBMClassified:get()
	local f117_local1 = f117_arg1.isBMClassified:get()
	if f117_local0 ~= f117_local1 then
		return f117_local1
	else
		return f117_arg0.iconID:get() < f117_arg1.iconID:get()
	end
end
CoD.BlackMarketUtility.SortUnlocksModelWOSubIndex = function(f118_arg0, f118_arg1)
	if f118_arg0.lootData then
		local f118_local0 = f118_arg0.lootData.owned
		local f118_local1 = f118_arg0.lootData.owned:get()
	end
	local f118_local2 = f118_local0 and f118_local1 or false
	if f118_arg1.lootData then
		local f118_local3 = f118_arg1.lootData.owned
		local f118_local4 = f118_arg1.lootData.owned:get()
	end
	local f118_local5 = f118_local3 and f118_local4 or false
	if f118_local2 ~= f118_local5 then
		return f118_local5
	else
		return f118_arg0.weaponOptionSubIndex:get() < f118_arg1.weaponOptionSubIndex:get()
	end
end
CoD.BlackMarketUtility.SortWeaponOptionCamosRarity = function(f119_arg0, f119_arg1)
	local f119_local0 = CoD.SafeGetModelValue(f119_arg0, "isCurrentWeaponReactiveCamo") or false
	if f119_local0 ~= (CoD.SafeGetModelValue(f119_arg1, "isCurrentWeaponReactiveCamo") or false) then
		return f119_local0
	else
		return (CoD.SafeGetModelValue(f119_arg0, "lootData.rarity") or -1) < (CoD.SafeGetModelValue(f119_arg1, "lootData.rarity") or -1)
	end
end
CoD.BlackMarketUtility.GetOufitBundleRef = function(f120_arg0, f120_arg1, f120_arg2, f120_arg3)
	local f120_local0 = CoD.BlackMarketTableUtility.GetOutfitBundleInformation(f120_arg0, f120_arg1)
	if f120_local0 then
		local f120_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f120_local0)
		if f120_local1 ~= nil and f120_local1.characterIndex ~= nil and f120_local1.outfitIndex ~= nil and f120_local1.paletteIndex ~= nil then
			local f120_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f120_local1.mode, f120_local1.characterIndex)
			local f120_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f120_local1.mode, f120_local1.characterIndex)
			local f120_local4 = f120_local3.outfits[f120_local1.outfitIndex + 1]
			local f120_local5, f120_local6 = nil
			if #f120_local4.palettes > 0 then
				f120_local5 = f120_local4.palettes[f120_local1.paletteIndex + 1].outfitImage
				f120_local6 = f120_local4.palettes[f120_local1.paletteIndex + 1].displayName
			end
			if not f120_local5 then
				f120_local5 = f120_local4.presets[f120_local1.presetIndex + 1].icon
				f120_local6 = f120_local4.presets[f120_local1.presetIndex + 1].displayName
			end
			return {
				name = f120_local6,
				desc = Engine[@"hash_4F9F1239CFD921FE"](0x77D62520C77867),
				mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f120_local4.displayName)),
				subExtraText = f120_local2.displayName,
				primaryImage = f120_local5 or "blacktransparent",
				popupImage = 0x0,
				character = f120_local0.prt,
				outfitIndexes = f120_local1,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetWarpaintBundleRef = function(f121_arg0, f121_arg1)
	local f121_local0 = CoD.BlackMarketTableUtility.GetOutfitItemBundleInformation(f121_arg0, f121_arg1)
	if f121_local0 then
		local f121_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f121_local0)
		f121_local1.paletteIndex = 0
		if f121_local1 ~= nil and f121_local1.characterIndex ~= nil and f121_local1.outfitIndex ~= nil and f121_local1.paletteIndex ~= nil then
			local f121_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f121_local1.mode, f121_local1.characterIndex)
			local f121_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f121_local1.mode, f121_local1.characterIndex)
			local f121_local4 = f121_local3.outfits[f121_local1.outfitIndex + 1]
			return {
				name = f121_local4.warPaints[f121_local1.war_paintIndex + 1].displayName,
				desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_562BC3111047BF79"),
				mainExtraText = "",
				subExtraText = 0x0,
				primaryImage = f121_local4.warPaints[f121_local1.war_paintIndex + 1].image or "blacktransparent",
				popupImage = 0x0,
				character = f121_local0.prt,
				outfitIndexes = f121_local1,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetBundleKeyItemRef = function(f122_arg0, f122_arg1, f122_arg2, f122_arg3)
	local f122_local0 = CoD.BlackMarketTableUtility.GetBundlePiecesInformation(f122_arg0, f122_arg1)
	local f122_local1 = 0
	if f122_local0 and #f122_local0 > 0 then
		for f122_local2 = 1, #f122_local0, 1 do
			local f122_local5 = f122_local0[f122_local2]
			if f122_local5.category == f122_arg2 then
				if f122_arg3 == nil or f122_local1 + 1 == f122_arg3 then
					return f122_local5
				end
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetOufitPresetRef = function(f123_arg0, f123_arg1, f123_arg2, f123_arg3)
	local f123_local0 = nil
	if f123_arg3 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f123_local0 = CoD.BlackMarketTableUtility.GetContrabandOutfitInformation(f123_arg0, f123_arg1)
	elseif f123_arg3 == LuaEnum.LOOT_TYPE.CONTRACT then
		f123_local0 = CoD.BlackMarketTableUtility.GetContractOutfitInformation(f123_arg0, f123_arg1, f123_arg2)
	elseif f123_arg3 == LuaEnum.LOOT_TYPE.ITEMSHOP then
		f123_local0 = CoD.BlackMarketTableUtility.GetItemShopOutfitInformation(f123_arg0, f123_arg1)
	elseif f123_arg3 == LuaEnum.LOOT_TYPE.BUNDLE then
		f123_local0 = CoD.BlackMarketTableUtility.GetBundleOutfitInformation(f123_arg0, f123_arg1)
	elseif f123_arg3 == LuaEnum.LOOT_TYPE.SEASON then
		f123_local0 = CoD.BlackMarketTableUtility.GetSeasonOutfitInformation(f123_arg0, f123_arg1)
	end
	if f123_local0 then
		local f123_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f123_local0)
		if f123_local1 ~= nil and f123_local1.characterIndex ~= nil and f123_local1.outfitIndex ~= nil and f123_local1.presetIndex ~= nil then
			local f123_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f123_local1.mode, f123_local1.characterIndex)
			local f123_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f123_local1.mode, f123_local1.characterIndex)
			local f123_local4 = f123_local3.outfits[f123_local1.outfitIndex + 1]
			local f123_local5 = f123_local4.presets[f123_local1.presetIndex + 1]
			local f123_local6 = f123_local5
			local f123_local7
			if f123_local5.matchedWarPaintLootId ~= 0x0 then
				f123_local7 = f123_local5.outfitIcon
			else
				f123_local7 = false
			end
			if f123_local5 then
				local f123_local8 = f123_local5.matchedWarPaintLootId
				local f123_local9 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2225837B50C02D09", f123_local2.displayName)
			end
			local f123_local10 = f123_local8 and f123_local9 or Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FD60E5FA0ADD7CC", f123_local2.displayName)
			if not f123_local7 or f123_local7 == 0x0 then
				f123_local7 = f123_local5 and f123_local5.icon
			end
			if not f123_local7 or f123_local7 == 0x0 then
				f123_local7 = "blacktransparent"
			end
			local f123_local11 = {}
			local f123_local12
			if f123_local5 then
				f123_local12 = f123_local5.displayName
				if not f123_local12 then
				else
					f123_local11.name = f123_local12
					f123_local11.desc = f123_local10
					f123_local11.mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f123_local4.displayName))
					f123_local11.subExtraText = f123_local2.displayName
					f123_local11.primaryImage = f123_local7 or "blacktransparent"
					f123_local11.character = f123_local0.prt
					f123_local11.outfitIndexes = f123_local1
					return f123_local11
				end
			end
			f123_local12 = 0x0
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetOufitWarPaintRef = function(f124_arg0, f124_arg1, f124_arg2, f124_arg3)
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
		if f124_local1 ~= nil and f124_local1.characterIndex ~= nil and f124_local1.outfitIndex ~= nil and f124_local1.war_paintIndex ~= nil and f124_local1.war_paintIndex > -1 then
			local f124_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f124_local1.mode, f124_local1.characterIndex)
			local f124_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f124_local1.mode, f124_local1.characterIndex)
			local f124_local4 = f124_local3.outfits[f124_local1.outfitIndex + 1]
			local f124_local5 = f124_local4.warPaints[f124_local1.war_paintIndex + 1].displayName
			if f124_local1.paletteIndex == nil then
				f124_local1.paletteIndex = CoD.BlackMarketUtility.GetPaletteFromOutfitInfo(f124_local4, f124_local5)
			end
			return {
				name = f124_local5,
				desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C81893A317FA38B", f124_local2.displayName),
				mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f124_local4.displayName)),
				subExtraText = f124_local2.displayName,
				primaryImage = f124_local4.warPaints[f124_local1.war_paintIndex + 1].image or "blacktransparent",
				character = f124_local0.prt,
				outfitIndexes = f124_local1,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetOufitDecalRef = function(f125_arg0, f125_arg1, f125_arg2, f125_arg3)
	local f125_local0 = nil
	if f125_arg3 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f125_local0 = CoD.BlackMarketTableUtility.GetContrabandOutfitInformation(f125_arg0, f125_arg1)
	elseif f125_arg3 == LuaEnum.LOOT_TYPE.CONTRACT then
		f125_local0 = CoD.BlackMarketTableUtility.GetContractOutfitInformation(f125_arg0, f125_arg1, f125_arg2)
	elseif f125_arg3 == LuaEnum.LOOT_TYPE.ITEMSHOP then
	elseif f125_arg3 == LuaEnum.LOOT_TYPE.BUNDLE then
		f125_local0 = CoD.BlackMarketTableUtility.GetBundleOutfitInformation(f125_arg0, f125_arg1)
	end
	if f125_local0 then
		local f125_local1 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f125_local0)
		if f125_local1 ~= nil and f125_local1.characterIndex ~= nil and f125_local1.outfitIndex ~= nil and f125_local1.decalIndex ~= nil and f125_local1.decalIndex > -1 then
			local f125_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f125_local1.mode, f125_local1.characterIndex)
			local f125_local3 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f125_local1.mode, f125_local1.characterIndex)
			local f125_local4 = f125_local3.outfits[f125_local1.outfitIndex + 1]
			return {
				name = f125_local4.decals[f125_local1.decalIndex + 1].displayName,
				desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1216427CCB6734F6", f125_local2.displayName),
				mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", Engine[@"hash_4F9F1239CFD921FE"](f125_local4.displayName)),
				subExtraText = f125_local2.displayName,
				primaryImage = f125_local4.decals[f125_local1.decalIndex + 1].image or "blacktransparent",
				popupImage = f125_local4.decals[f125_local1.decalIndex + 1].image or "blacktransparent",
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetWeaponRef = function(f126_arg0)
	local f126_local0 = Enum.eModes.mode_multiplayer
	local f126_local1 = function()
		local f127_local0, f127_local1, f127_local2, f127_local3, f127_local4 = nil
		for f127_local12, f127_local13 in ipairs({
			"primary",
			"secondary",
		}) do
			for f127_local9, f127_local10 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f126_local0, f127_local13)) do
				if f126_arg0 == f127_local10.nameHash then
					f127_local0 = f127_local13
					f127_local1 = f127_local10.displayName
					f127_local2 = f127_local10.description
					f127_local3 = f127_local10.nameHash
					local f127_local8 = Engine[@"hash_5E1EF2796DE77BCB"](f126_arg0)
					if f127_local8 then
						f127_local4 = f127_local8
					end
					if f127_local10.previewImage then
						f127_local4 = Engine[@"hash_1BF99001028052B9"](f127_local10.previewImage)
					end
				end
			end
		end
		return f127_local0, f127_local1, f127_local2, f127_local3, f127_local4
	end
	local f126_local1, f126_local2, f126_local3, f126_local4, f126_local5 = f126_local1()
	if f126_local4 then
		return {
			name = f126_local2,
			primaryImage = f126_local5,
			displayNameRef = f126_local2,
			displayDescRef = f126_local3,
			weaponInfo = {
				weaponSlot = f126_local1,
				ref = f126_local4,
				displayNameRef = f126_local2,
			},
		}
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetSignatureWeaponRef = function(f128_arg0)
	local f128_local0 = CoD.CACUtility.GetUnlockableItemTable()
	local f128_local1 = Enum.eModes.mode_multiplayer
	local f128_local2 = function()
		local f129_local0, f129_local1, f129_local2, f129_local3 = nil
		local f129_local4 = {}
		for f129_local16, f129_local17 in ipairs({
			"primary",
			"secondary",
		}) do
			for f129_local11, f129_local12 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f128_local1, f129_local17)) do
				for f129_local8, f129_local9 in ipairs(Engine[@"hash_79F0BB7D52A7A978"](f129_local12.nameHash)) do
					if f129_local9.lootid == f128_arg0 then
						if f129_local9[@"hash_5C2AA73D9F82E9C2"] == true then
							f129_local0 = f129_local17
							f129_local1 = f129_local12.displayName
							f129_local2 = f129_local12.nameHash
							f129_local3 = f129_local9
						else
							f129_local4 = f129_local9
						end
					end
				end
			end
		end
		return f129_local0, f129_local1, f129_local2, f129_local3, f129_local4
	end
	local f128_local2, f128_local3, f128_local4, f128_local5, f128_local6 = f128_local2()
	if f128_local4 then
		local f128_local7 = f128_local6[@"hash_1852BDFE9E6B7AB1"]
		if not f128_local7 or f128_local7 == 0x0 or f128_local7 == "blacktransparent" then
			f128_local7 = f128_local5[@"hash_1852BDFE9E6B7AB1"]
		end
		local f128_local8 = {
			ui_icon_weapons_loot_shotgun_semi_sig_01 = "ui_icon_weapons_loot_shotgun_semi_sig_02",
			[@"hash_4C8731A395FE6921"] = "ui_icon_weapons_loot_ar_accurate_sig_02",
			[@"hash_D22965694EF34B5"] = "ui_icon_weapons_loot_smg_accurate_sig_02",
			[@"hash_241DCDBC3E815438"] = @"hash_241DD0BC3E815951",
		}
		return {
			name = f128_local5.displayname,
			primaryImage = f128_local8[f128_local7] or f128_local7,
			displayNameRef = f128_local3,
			mastercraftNameRef = f128_local6.displayname,
			signatureWeaponInfo = {
				weaponSlot = f128_local2,
				ref = f128_local4,
				signatureIndex = f128_local5.index,
				mastercraftIndex = f128_local6.index,
				displayNameRef = f128_local5.displayname,
				mastercraftNameRef = f128_local6.displayname,
			},
		}
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetMastercraftWeaponRef = function(f130_arg0)
	local f130_local0 = CoD.CACUtility.GetUnlockableItemTable()
	local f130_local1 = Enum.eModes.mode_multiplayer
	local f130_local2 = function()
		local f131_local0, f131_local1, f131_local2, f131_local3 = nil
		local f131_local4 = {}
		for f131_local16, f131_local17 in ipairs({
			"primary",
			"secondary",
		}) do
			for f131_local11, f131_local12 in ipairs(CoD.CACUtility.GetUnlockableItemsForLoadoutSlot(f130_local1, f131_local17)) do
				for f131_local8, f131_local9 in ipairs(Engine[@"hash_79F0BB7D52A7A978"](f131_local12.nameHash)) do
					if f131_local9.lootid == f130_arg0 then
						return f131_local17, f131_local12.displayName, f131_local12.nameHash, f131_local9
					end
				end
			end
		end
		return f131_local0, f131_local1, f131_local2, f131_local3
	end
	local f130_local2, f130_local3, f130_local4, f130_local5 = f130_local2()
	if f130_local4 then
		local f130_local6 = f130_local5[@"hash_1852BDFE9E6B7AB1"]
		local f130_local7 = f130_local3
		if f130_local5.displayname then
			f130_local3 = f130_local5.displayname
		end
		return {
			name = f130_local3,
			primaryImage = f130_local6,
			displayNameRef = f130_local7,
			weaponInfo = {
				weaponSlot = f130_local2,
				ref = f130_local4,
				modelIdx = f130_local5.index,
				displayNameRef = f130_local7,
			},
		}
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetGestureRef = function(f132_arg0, f132_arg1, f132_arg2, f132_arg3)
	local f132_local0 = 0x0
	for f132_local12, f132_local13 in ipairs(CoD.BreadcrumbUtility.GetSprayGestureTable()) do
		if f132_local13[@"assetname"] == f132_arg1 then
			local f132_local4 = Enum.eModes.mode_multiplayer
			local f132_local5 = nil
			if f132_arg2 ~= nil and f132_arg3 == LuaEnum.LOOT_TYPE.CONTRACT then
				local f132_local6 = CoD.BlackMarketTableUtility.GetContractOutfitInformation(f132_arg0, f132_arg1, f132_arg2)
				if f132_local6 then
					f132_local5 = f132_local6.prt
				end
			end
			if f132_local5 == nil or f132_local5 == 0x0 then
				local f132_local6 = CoD.BlackMarketUtility.CharacterPRTTable[1]
				local f132_local7 = CoD.BlackMarketTableUtility.LootInfoLookup(f132_arg0, f132_local13[@"assetname"])
				f132_local5 = CoD.BlackMarketUtility.PRT_To_PBT_Table[f132_local6]
				local f132_local8 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum.eModes.mode_multiplayer, Engine[@"hash_284E3CB0C7D8BA11"](Enum.eModes.mode_multiplayer, f132_local6))
				f132_local0 = f132_local8.displayName
			else
				for f132_local6 = 1, #CoD.BlackMarketUtility.CharacterPRTTable, 1 do
					local f132_local10 = CoD.BlackMarketUtility.CharacterPRTTable[f132_local6]
					if CoD.BlackMarketUtility.PRT_To_PBT_Table[f132_local10] == f132_local5 then
						f132_local5 = CoD.BlackMarketUtility.PRT_To_PBT_Table[f132_local10]
						local f132_local11 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum.eModes.mode_multiplayer, Engine[@"hash_284E3CB0C7D8BA11"](Enum.eModes.mode_multiplayer, f132_local10))
						f132_local0 = f132_local11.displayName
						break
					end
				end
			end
			return {
				character = f132_local5,
				outfitIndexes = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId({
					mode = f132_local4,
					prt = f132_local5,
				}),
				primaryImage = f132_local13.icon,
				name = f132_local13.title,
				gesture_index = f132_local12,
				characterDisplayNameRef = f132_local0,
			}
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetTableWeaponRef = function(f133_arg0, f133_arg1, f133_arg2, f133_arg3, f133_arg4)
	local f133_local0 = 0x0
	if f133_arg2 == LuaEnum.LOOT_TYPE.SEASON then
		f133_local0 = CoD.BlackMarketTableUtility.GetSeasonWeaponRefName(f133_arg0, f133_arg1)
	elseif f133_arg2 == LuaEnum.LOOT_TYPE.CONTRACT then
		f133_local0 = CoD.BlackMarketTableUtility.GetContractWeaponRefName(f133_arg0, f133_arg1, f133_arg3)
	elseif f133_arg2 == LuaEnum.LOOT_TYPE.ITEMSHOP then
		f133_local0 = CoD.BlackMarketTableUtility.GetItemShopWeaponRefName(f133_arg0, f133_arg1)
	elseif f133_arg2 == LuaEnum.LOOT_TYPE.CONTRABAND then
		f133_local0 = CoD.BlackMarketTableUtility.GetContrabandWeaponRefName(f133_arg0, f133_arg4)
	elseif f133_arg2 == LuaEnum.LOOT_TYPE.BUNDLE then
		f133_local0 = CoD.BlackMarketTableUtility.GetBundleWeaponRefName(f133_arg0, f133_arg1)
	end
	return f133_local0
end
CoD.BlackMarketUtility.GetSpecialBundleInfo = function(f134_arg0, f134_arg1)
	local f134_local0 = Engine[@"hash_2E00B2F29271C60B"](f134_arg1)
	if not f134_local0 then
		return nil
	end
	local f134_local1 = {}
	for f134_local6, f134_local7 in pairs({
		primaryImage = {
			overrideFieldName = @"previewimage",
			defaultValue = 0x0,
		},
		popupImage = {
			overrideFieldName = @"popupimage",
			defaultValue = 0x0,
		},
		buttonImage = {
			overrideFieldName = @"buttonimage",
			defaultValue = "blacktransparent",
		},
		reservesImage = {
			overrideFieldName = @"reserveimage",
			defaultValue = "blacktransparent",
		},
		category = {
			overrideFieldName = @"categorytext",
			defaultValue = 0x0,
		},
		name = {
			overrideFieldName = @"nametext",
			defaultValue = 0x0,
		},
		toolTip = {
			overrideFieldName = "tooltiptext",
			defaultValue = 0x0,
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
			defaultValue = 0x0,
		},
		specialContractGoalUnit = {
			overrideFieldName = @"hash_1A4ECC2185CC1289",
			defaultValue = 0x0,
		},
		specialContractRewardImage = {
			overrideFieldName = @"hash_5EE2B488845485EF",
			defaultValue = "blacktransparent",
		},
	}) do
		local f134_local5 = f134_local7.defaultValue
		if f134_local0[f134_local7.overrideFieldName] then
			f134_local5 = f134_local0[f134_local7.overrideFieldName]
			if f134_local7.localize then
				f134_local5 = Engine[@"hash_4F9F1239CFD921FE"](f134_local5)
			end
		end
		f134_local1[f134_local6] = f134_local5
	end
	return f134_local1
end
CoD.BlackMarketUtility.GetItemRefs = function(f135_arg0, f135_arg1, f135_arg2, f135_arg3, f135_arg4, f135_arg5, f135_arg6, f135_arg7, f135_arg8)
	local f135_local0 = 0x0
	local f135_local1 = ""
	local f135_local2 = ""
	local f135_local3 = 0x0
	local f135_local4 = 0x0
	local f135_local5 = 0x0
	local f135_local6 = 0x0
	local f135_local7 = 0x0
	local f135_local8 = 0x0
	local f135_local9 = 0x0
	local f135_local10 = 0x0
	local f135_local11 = nil
	local f135_local12 = -1
	local f135_local13, f135_local14, f135_local15 = nil
	local f135_local16 = 0x0
	local f135_local17 = 0x0
	local f135_local18 = false
	local f135_local19 = 0
	local f135_local20 = 0
	local f135_local21 = 0
	local f135_local22 = false
	local f135_local23
	if f135_arg4 == nil or f135_arg4 == 0x0 then
		f135_local23 = false
	else
		f135_local23 = true
	end
	local f135_local24 = false
	local f135_local25 = false
	local f135_local26 = false
	local f135_local27 = false
	local f135_local28 = false
	local f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.NONE
	local f135_local30 = false
	local f135_local31 = Engine[@"isdevelopmentbuild"]()
	local f135_local32 = ""
	local f135_local33 = 0x0
	if f135_arg1 == "contraband" then
		f135_local0 = @"hash_725FC26BF505BC71"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6954DFFAE6AF5CD5")
		f135_local4 = 0x16542A61FD09C0
		f135_local22 = true
		f135_local30 = true
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.CRATE
	elseif f135_arg1 == "case" then
		f135_local0 = @"hash_D004F2913090A"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_45BF036E550C7E0B")
		f135_local4 = 0x16542A61FD09C0
		f135_local6 = "ui_icon_blackmarket_reserves_case_large"
		f135_local22 = true
		f135_local30 = true
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.NONE
	elseif f135_arg1 == "cases_10" then
		f135_local0 = @"mpui/cases"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_ADA96E32A289F35", 10)
		f135_local6 = "ui_icon_blackmarket_reserves_case_x10_large_preview"
		f135_local4 = "ui_icon_blackmarket_reserves_case_x10_preview"
		f135_local30 = true
	elseif f135_arg1 == "tiers_5" then
		f135_local0 = @"mpui/tiers"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_61705D753E6F1661", 5)
		f135_local6 = "ui_icon_blackmarket_reserves_tier_x5_large_square"
		f135_local4 = "ui_icon_blackmarket_reserves_tier_x5_preview"
		f135_local30 = true
	elseif f135_arg1 == "tiers_10" then
		f135_local0 = @"mpui/tiers"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_61705D753E6F1661", 10)
		f135_local6 = "ui_icon_blackmarket_x10tiers_large"
		f135_local4 = "ui_icon_blackmarket_x10tiers_large"
		f135_local30 = true
	elseif f135_arg1 == "crates_2" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 2)
		f135_local6 = "ui_icon_blackmarket_stream_case_x2"
		f135_local4 = "ui_icon_blackmarket_item_shop_reserve_crate_x2_preview"
		f135_local30 = true
	elseif f135_arg1 == "crates_3" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 3)
		f135_local6 = "ui_icon_blackmarket_stream_case_x3"
		f135_local4 = "ui_icon_blackmarket_item_shop_reserve_crate_x3_preview"
		f135_local30 = true
	elseif f135_arg1 == "crates_4" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 4)
		f135_local6 = "ui_icon_blackmarket_stream_case_x4"
		f135_local4 = "ui_icon_blackmarket_item_shop_reserve_crate_x4_preview"
		f135_local30 = true
	elseif f135_arg1 == "crates_5" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 5)
		f135_local6 = "ui_icon_blackmarket_reserves_crate_x5_large_square"
		f135_local4 = "ui_icon_blackmarket_reserves_crate_x5_preview"
		f135_local30 = true
	elseif f135_arg1 == "crates_6" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 6)
		f135_local6 = @"hash_7C32C3FC09A201D0"
		f135_local4 = @"hash_1CFD4511B6E289D1"
		f135_local30 = true
	elseif f135_arg1 == "crates_7" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 7)
		f135_local6 = @"hash_25CBB8132F9331C1"
		f135_local4 = @"hash_2DE5A76EDF945072"
		f135_local30 = true
	elseif f135_arg1 == "crates_8" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 8)
		f135_local6 = "ui_icon_blackmarket_stream_case_x8"
		f135_local4 = "ui_icon_blackmarket_stream_case_x8"
		f135_local30 = true
	elseif f135_arg1 == "crates_10" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 10)
		f135_local6 = "ui_icon_blackmarket_reserves_crate_x10_large_square"
		f135_local4 = "ui_icon_blackmarket_reserves_crate_x10_preview"
		f135_local30 = true
	elseif f135_arg1 == @"hash_47D19B4484A8E441" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 12)
		f135_local6 = "ui_icon_blackmarket_reserves_crate_x10_large_square"
		f135_local4 = "ui_icon_blackmarket_reserves_crate_x10_preview"
		f135_local30 = true
	elseif f135_arg1 == @"hash_47D19C4484A8E5F4" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 15)
		f135_local6 = "ui_icon_blackmarket_reserves_crate_x15_large_square"
		f135_local4 = "ui_icon_blackmarket_reserves_crate_x15_preview"
		f135_local30 = true
	elseif f135_arg1 == @"hash_47C70744849F9440" then
		f135_local0 = @"mpui/crates"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CD7C79409988EEA", 20)
		f135_local6 = "ui_icon_blackmarket_reserves_crate_x20_large_square"
		f135_local4 = "ui_icon_blackmarket_reserves_crate_x20_preview"
		f135_local30 = true
	elseif f135_arg1 == "promo_no_dupe_crate_1" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 1)
		f135_local6 = @"hash_1B3DD6A07BF2BF1E"
		f135_local4 = @"hash_6AD7059EF84C6745"
		f135_local30 = true
	elseif f135_arg1 == "promo_no_dupe_crate_2" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 2)
		f135_local6 = @"hash_594C56B4BDDDCA57"
		f135_local4 = @"hash_6AD7029EF84C622C"
		f135_local30 = true
	elseif f135_arg1 == "promo_no_dupe_crate_3" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 3)
		f135_local6 = 0x8D7D55C5793D94
		f135_local4 = @"hash_6AD7039EF84C63DF"
		f135_local30 = true
	elseif f135_arg1 == "promo_no_dupe_crate_4" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 4)
		f135_local6 = @"hash_668D795994207A5D"
		f135_local4 = @"hash_6AD7009EF84C5EC6"
		f135_local30 = true
	elseif f135_arg1 == "promo_no_dupe_crate_5" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 5)
		f135_local6 = @"hash_FAFB2215A9DD6FA"
		f135_local4 = @"hash_6AD7019EF84C6079"
		f135_local30 = true
	elseif f135_arg1 == "promo_no_dupe_crate_6" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 6)
		f135_local6 = @"hash_2A270193C87FA3B3"
		f135_local4 = @"hash_6AD6FE9EF84C5B60"
		f135_local30 = true
	elseif f135_arg1 == @"hash_687BFC2DBF432B55" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 7)
		f135_local6 = "ui_icon_blackmarket_stream_case_x2"
		f135_local4 = "ui_icon_blackmarket_item_shop_reserve_crate_x2_preview"
		f135_local30 = true
	elseif f135_arg1 == "promo_no_dupe_crate_10" then
		f135_local0 = @"hash_1717FF140F30014C"
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_749349434018253B", 10)
		f135_local6 = @"hash_4AA980299AAEAD68"
		f135_local4 = @"hash_6ADA8A9EF84F7F1B"
		f135_local30 = true
	elseif f135_arg2 == "bribe" then
		local f135_local34 = CoD.BlackMarketUtility.GetBribeAsset(f135_arg0, f135_arg1)
		if f135_local34 then
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local6 = f135_local34.popupImage
			f135_local4 = f135_local34.primaryImage
			f135_local7 = f135_local34.category
			f135_local30 = true
		end
	elseif f135_arg2 == "special_bundle" then
		local f135_local34 = CoD.BlackMarketUtility.GetSpecialBundleInfo(f135_arg0, f135_arg1)
		if f135_local34 then
			f135_local7 = f135_local34.category
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local4 = f135_local34.primaryImage
			f135_local6 = f135_local34.popupImage
		end
		f135_local24 = true
		f135_local30 = true
		f135_local28 = CoD.BlackMarketTableUtility.BundleIncludesTiers(f135_arg0, f135_arg1)
	elseif f135_arg2 == "bribe_bundle" then
		local f135_local34 = CoD.BlackMarketUtility.GetSpecialBundleInfo(f135_arg0, f135_arg1)
		if f135_local34 then
			f135_local7 = f135_local34.category
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local4 = f135_local34.primaryImage
			f135_local6 = f135_local34.popupImage
		end
		f135_local24 = true
		f135_local30 = true
		f135_local28 = CoD.BlackMarketTableUtility.BundleIncludesTiers(f135_arg0, f135_arg1)
	elseif f135_arg2 == "outfit_bundle" then
		f135_local7 = @"hash_10FEC0D6C18D931"
		f135_local8 = @"hash_29F902A4E4F760A0"
		local f135_local34 = CoD.BlackMarketUtility.GetOufitBundleRef(f135_arg0, f135_arg1, f135_arg5, f135_arg6)
		if f135_local34 then
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local2 = f135_local34.mainExtraText
			f135_local3 = f135_local34.subExtraText
			f135_local4 = f135_local34.primaryImage
			f135_local6 = f135_local34.popupImage
			f135_local10 = f135_local34.character
			f135_local11 = f135_local34.outfitIndexes
			f135_local24 = true
			f135_local25 = true
			f135_local26 = true
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	elseif f135_arg2 == "palette" or f135_arg2 == "outfit" then
		f135_arg2 = "palette"
		f135_local7 = @"hash_2402A241E7027A9C"
		f135_local8 = @"hash_5C71CAD2D5CA1139"
		local f135_local34 = CoD.BlackMarketUtility.GetOufitPresetRef(f135_arg0, f135_arg1, f135_arg5, f135_arg6)
		if f135_local34 then
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local2 = f135_local34.mainExtraText
			f135_local3 = f135_local34.subExtraText
			f135_local4 = f135_local34.primaryImage
			f135_local10 = f135_local34.character
			f135_local11 = f135_local34.outfitIndexes
			f135_local25 = true
			f135_local26 = true
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No outfit/palette found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	elseif f135_arg2 == "war_paint" then
		f135_local7 = "heroes/war_paint"
		f135_local8 = "heroes/war_paint"
		local f135_local34 = CoD.BlackMarketUtility.GetOufitWarPaintRef(f135_arg0, f135_arg1, f135_arg5, f135_arg6)
		if f135_local34 then
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local2 = f135_local34.mainExtraText
			f135_local3 = f135_local34.subExtraText
			f135_local4 = f135_local34.primaryImage
			f135_local10 = f135_local34.character
			f135_local11 = f135_local34.outfitIndexes
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No warpaint found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WARPAINT
	elseif f135_arg2 == "war_paint_bundle" then
		f135_local7 = @"hash_3A946B2CDA87A651"
		f135_local8 = @"hash_7E530F8AE1170AEF"
		local f135_local34 = CoD.BlackMarketUtility.GetWarpaintBundleRef(f135_arg0, f135_arg1)
		if f135_local34 then
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local2 = f135_local34.mainExtraText
			f135_local3 = f135_local34.subExtraText
			f135_local4 = f135_local34.primaryImage
			f135_local6 = f135_local34.popupImage
			f135_local10 = f135_local34.character
			f135_local11 = f135_local34.outfitIndexes
			f135_local24 = true
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WARPAINT
	elseif f135_arg2 == "decal" then
		f135_local7 = @"hash_90FDB01723264C2"
		f135_local8 = @"hash_90FDB01723264C2"
		local f135_local34 = CoD.BlackMarketUtility.GetOufitDecalRef(f135_arg0, f135_arg1, f135_arg5, f135_arg6)
		if f135_local34 then
			f135_local0 = f135_local34.name
			f135_local1 = f135_local34.desc
			f135_local2 = f135_local34.mainExtraText
			f135_local3 = f135_local34.subExtraText
			f135_local4 = f135_local34.primaryImage
			f135_local6 = f135_local34.popupImage
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No decal found for '" .. tostring(f135_arg1) .. "'.\n")
		end
	elseif f135_arg2 == "sticker" then
		f135_local7 = @"hash_684446BBFA84177E"
		f135_local8 = @"hash_684446BBFA84177E"
		f135_local0 = CoD.BlackMarketUtility.GetStickerNameRef(f135_arg1)
		if f135_local23 then
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EFBC43F128603C7")
		else
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5A97A7E0BDB92B71")
		end
		f135_local4 = f135_arg1
		f135_local6 = f135_arg1
	elseif f135_arg2 == "jump_kit" then
		f135_local7 = @"hash_23F467595E1530B1"
		f135_local8 = @"hash_23F467595E1530B1"
		f135_local0, f135_local4, f135_local6 = CoD.BlackMarketUtility.GetJumpPackRefs(f135_arg1)
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5CDF03FEF797580B")
		f135_local24 = true
	elseif f135_arg2 == "parachute" then
		f135_local7 = @"hash_16E17CFC64CC82A6"
		f135_local8 = @"hash_16E17CFC64CC82A6"
		f135_local0, f135_local4, f135_local6 = CoD.BlackMarketUtility.GetParachuteRefs(f135_arg1)
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_54F735829F6419D6")
	elseif f135_arg2 == "trail" then
		f135_local7 = @"hash_72F9555D2DB46C29"
		f135_local8 = @"hash_72F9555D2DB46C29"
		f135_local0, f135_local4, f135_local6 = CoD.BlackMarketUtility.GetTrailRefs(f135_arg1)
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_596358359F5E5023")
	elseif f135_arg2 == "wingsuit" then
		f135_local7 = @"hash_1D31D93D47E71A15"
		f135_local8 = @"hash_1D31D93D47E71A15"
		f135_local0, f135_local4, f135_local6 = CoD.BlackMarketUtility.GetWingsuitRefs(f135_arg1)
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_18DF7DAB46723CBF")
	elseif f135_arg2 == "death_fx" or f135_arg2 == "single_death_fx" then
		f135_local7 = @"hash_57B491E0F2A8C286"
		f135_local8 = @"hash_57B491E0F2A8C286"
		f135_local0, f135_local4, f135_local6 = CoD.BlackMarketUtility.GetDeathFxRefs(f135_arg1)
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EB5308AF890B7CA")
		if f135_arg2 == "single_death_fx" then
			local f135_local35 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f135_arg0, f135_arg1, f135_arg6, f135_arg5, f135_arg8))
			if f135_local35 then
				local f135_local36 = Engine[@"hash_4F9F1239CFD921FE"](f135_local35.displayNameRef)
				f135_local14 = f135_local35.weaponInfo
				if f135_local14.displayNameRef then
					f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_547EC21C1E053403", f135_local14.displayNameRef)
					local f135_local37 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
					if f135_local37 then
						f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local37)
						f135_local3 = f135_local14.displayNameRef
					end
				end
			end
		end
	elseif f135_arg2 == "weapon_charm" or f135_arg2 == "single_weapon_charm" then
		f135_local7 = @"hash_5F5E657D5E5ED4E7"
		f135_local8 = @"hash_5F5E657D5E5ED4E7"
		f135_local0, f135_local4, f135_local6 = CoD.BlackMarketUtility.GetWeaponCharmRefs(f135_arg1)
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"]("mpui/weapon_charm_desc")
		if f135_arg2 == "single_weapon_charm" then
			local f135_local35 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f135_arg0, f135_arg1, f135_arg6, f135_arg5, f135_arg8))
			if f135_local35 then
				local f135_local36 = Engine[@"hash_4F9F1239CFD921FE"](f135_local35.displayNameRef)
				f135_local14 = f135_local35.weaponInfo
				if f135_local14.displayNameRef then
					f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6869AF228464E2CC", f135_local14.displayNameRef)
					local f135_local37 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
					if f135_local37 then
						f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local37)
						f135_local3 = f135_local14.displayNameRef
					end
				end
			end
		end
	elseif f135_arg2 == "tag" then
		f135_local7 = @"mpui/bm_tag"
		f135_local8 = @"mpui/bm_tag"
		for f135_local39, f135_local37 in ipairs(CoD.BreadcrumbUtility.GetSprayGestureTable()) do
			if f135_local37[@"assetname"] == f135_arg1 then
				f135_local0 = f135_local37.title
				f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_714B40835B8EFFA6")
				f135_local4 = f135_local37.icon
				f135_local6 = f135_local37.icon
			end
		end
	elseif f135_arg2 == "tag_bundle" then
		f135_local7 = @"hash_659A5D0F134093B2"
		f135_local8 = @"hash_29F902A4E4F760A0"
		local f135_local34 = CoD.BreadcrumbUtility.GetSprayGestureTable()
		local f135_local35 = CoD.BlackMarketTableUtility.GetBonusSetMasterNameHash(f135_arg4)
		for f135_local37, f135_local40 in ipairs(f135_local34) do
			if f135_local40[@"assetname"] == f135_local35 then
				f135_local0 = f135_local40.title
				f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_714B40835B8EFFA6")
				f135_local4 = f135_local40.icon
				f135_local6 = f135_local40.icon
				f135_local16 = f135_local40.icon
				f135_local17 = f135_local40.title
				f135_local24 = true
			end
		end
	elseif f135_arg2 == "calling_card" then
		f135_local7 = "mpui/bm_bribe_callingcard"
		f135_local8 = "mpui/bm_bribe_callingcard"
		if not CoD.BlackMarketUtility.GetCallingCardTitleFromImage(f135_arg1) then
			f135_local0 = CoD.BlackMarketUtility.GetCallingCardTitleFromMasterImage(f135_arg1)
		end
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F54BEF14A6A8825")
		f135_arg1 = CoD.BlackMarketUtility.GetSafeReward(f135_arg1, f135_arg2)
		f135_local4 = f135_arg1
		f135_local6 = f135_arg1
	elseif f135_arg2 == "signature_weapon" then
		f135_local7 = @"hash_1D4314C41E9C9CFC"
		f135_local8 = @"hash_1D4314C41E9C9CFC"
		local f135_local34 = CoD.BlackMarketUtility.GetSignatureWeaponRef(f135_arg1)
		if f135_local34 then
			local f135_local35 = Engine[@"hash_4F9F1239CFD921FE"](f135_local34.displayNameRef)
			f135_local0 = f135_local34.name
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_33C2175CA3B33A90", Engine[@"hash_4F9F1239CFD921FE"](f135_local34.name), Engine[@"hash_4F9F1239CFD921FE"](f135_local34.mastercraftNameRef))
			f135_local4 = f135_local34.primaryImage
			f135_local13 = f135_local34.signatureWeaponInfo
			if f135_local13.ref then
				f135_local25 = true
				local f135_local39 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local13.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
				if f135_local39 then
					f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3272B8D34315D012", Engine[@"hash_4F9F1239CFD921FE"](f135_local39), f135_local35)
				end
			end
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No signature weapon found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "melee_weapon" then
		f135_local7 = "mpui/bm_melee_weapon_caps"
		f135_local8 = "mpui/bm_melee_weapon_caps"
		local f135_local34 = CoD.BlackMarketUtility.GetWeaponRef(f135_arg1)
		if f135_local34 then
			local f135_local35 = Engine[@"hash_4F9F1239CFD921FE"](f135_local34.displayNameRef)
			f135_local0 = f135_local34.name
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](f135_local34.displayDescRef)
			f135_local4 = f135_local34.primaryImage
			f135_local14 = f135_local34.weaponInfo
			f135_local2 = Engine[@"hash_4F9F1239CFD921FE"]("mpui/bm_melee_weapon_caps")
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No melee weapon found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "melee_weapon_bundle" then
		f135_local7 = "mpui/bm_melee_weapon_caps"
		f135_local8 = @"hash_29F902A4E4F760A0"
		local f135_local34 = nil
		local f135_local35 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f135_arg0, f135_arg1, "melee_weapon")
		if f135_local35 then
			f135_local34 = CoD.BlackMarketUtility.GetWeaponRef(f135_local35.name)
		end
		if f135_local34 then
			local f135_local36 = Engine[@"hash_4F9F1239CFD921FE"](f135_local34.displayNameRef)
			f135_local0 = f135_local34.name
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](f135_local34.displayDescRef)
			f135_local4 = f135_local34.primaryImage
			f135_local14 = f135_local34.weaponInfo
			f135_local2 = Engine[@"hash_4F9F1239CFD921FE"]("mpui/bm_melee_weapon_caps")
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No melee weapon found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local24 = true
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "reactive_camo" or f135_arg2 == "single_reactive_camo" then
		f135_local15 = f135_arg1
		f135_local7 = "weapon_options/reactive_camo"
		f135_local8 = "weapon_options/reactive_camo"
		if f135_arg2 == "reactive_camo" then
			f135_local4 = Engine.TableLookup(CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f135_arg1)
		else
			f135_local4 = CoD.BlackMarketTableUtility.GetContrabandSingleCamoImageName(f135_arg0, f135_arg8)
		end
		local f135_local34 = Engine.TableFindRows(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f135_arg1)
		if f135_local34 ~= nil then
			local f135_local35 = f135_local34[1]
			f135_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local35, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"])
			if f135_local4 == nil or f135_local4 == 0x0 then
				f135_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local35, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"])
			end
		end
		local f135_local36 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f135_arg0, f135_arg1, f135_arg6, f135_arg5, f135_arg8))
		if f135_local36 then
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B6921A298FA490B", Engine[@"hash_4F9F1239CFD921FE"](f135_local36.displayNameRef))
			f135_local14 = f135_local36.weaponInfo
			if f135_arg2 == "single_reactive_camo" and f135_local14.displayNameRef then
				f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_73CC9C023A12F461", f135_local14.displayNameRef)
				local f135_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
				if f135_local40 then
					f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local40)
					f135_local3 = f135_local14.displayNameRef
				end
			end
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error("Loot: No reactive camo weapon info found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "reactive_camo_bundle" then
		local f135_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f135_arg0, f135_arg1, "reactive_camo")
		if f135_local34 then
			f135_local15 = f135_local34.name
		else
			f135_local15 = 0x0
		end
		f135_local7 = "weapon_options/reactive_camo"
		f135_local8 = @"hash_29F902A4E4F760A0"
		f135_local4 = Engine.TableLookup(CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f135_local15)
		local f135_local35 = Engine.TableFindRows(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f135_local15)
		if f135_local35 ~= nil then
			local f135_local36 = f135_local35[1]
			f135_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"])
			if f135_local4 == nil or f135_local4 == 0x0 then
				f135_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"])
			end
		end
		local f135_local38 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f135_arg0, f135_arg1, f135_arg6, f135_arg5))
		if f135_local38 then
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B6921A298FA490B", Engine[@"hash_4F9F1239CFD921FE"](f135_local38.displayNameRef))
			f135_local14 = f135_local38.weaponInfo
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No reactive camo weapon info found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local24 = true
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "mastercraft" or f135_arg2 == "mk2" then
		f135_local15 = f135_arg1
		if f135_arg2 == "mastercraft" then
			local f135_local41 = "weapon_options/mastercraft"
		end
		f135_local7 = f135_local41 or @"hash_1D4314C41E9C9CFC"
		f135_local8 = f135_local7
		local f135_local34 = Engine.TableFindRows(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f135_arg1)
		if f135_local34 ~= nil then
			local f135_local35 = f135_local34[1]
			f135_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local35, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"])
			f135_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local35, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"])
		end
		local f135_local35 = CoD.BlackMarketUtility.GetMastercraftWeaponRef(f135_arg1)
		if f135_local35 then
			local f135_local36 = Engine[@"hash_4F9F1239CFD921FE"](f135_local35.displayNameRef)
			if f135_arg2 == "mastercraft" then
				f135_local1 = Engine[@"hash_4F9F1239CFD921FE"]("menu/mastercraft_desc", f135_local36)
			else
				f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/mk2_desc", f135_local36)
				f135_local0 = f135_local35.name
			end
			f135_local4 = f135_local35.primaryImage
			f135_local14 = f135_local35.weaponInfo
			if f135_local14.ref then
				local f135_local37 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
				if f135_local37 then
					f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local37)
					f135_local3 = f135_local14.displayNameRef
				end
			end
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No mastercraft/mk2 weapon info found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "mastercraft_bundle" then
		local f135_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f135_arg0, f135_arg1, "mastercraft")
		if f135_local34 then
			f135_local15 = f135_local34.name
		else
			f135_local15 = 0x0
		end
		f135_local7 = @"hash_4672018B2DF3B222"
		f135_local8 = @"hash_29F902A4E4F760A0"
		f135_local24 = true
		local f135_local35 = Engine.TableFindRows(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f135_local15)
		if f135_local35 ~= nil then
			local f135_local36 = f135_local35[1]
			f135_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"])
			f135_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"])
		end
		local f135_local36 = CoD.BlackMarketUtility.GetMastercraftWeaponRef(f135_local15)
		if f135_local36 then
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"]("menu/mastercraft_desc", Engine[@"hash_4F9F1239CFD921FE"](f135_local36.displayNameRef))
			f135_local4 = f135_local36.primaryImage
			f135_local14 = f135_local36.weaponInfo
			if f135_local14.ref then
				local f135_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
				if f135_local40 then
					f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local40)
					f135_local3 = f135_local14.displayNameRef
				end
			end
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "mk2_bundle" then
		local f135_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f135_arg0, f135_arg1, "mk2")
		if f135_local34 then
			f135_local15 = f135_local34.name
		else
			f135_local15 = 0x0
		end
		f135_local7 = @"hash_28B384C77C6AD378"
		f135_local8 = @"hash_29F902A4E4F760A0"
		f135_local24 = true
		local f135_local35 = Engine.TableFindRows(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f135_local15)
		if f135_local35 ~= nil then
			local f135_local36 = f135_local35[1]
			f135_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"])
			f135_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"])
		end
		local f135_local36 = CoD.BlackMarketUtility.GetMastercraftWeaponRef(f135_local15)
		if f135_local36 then
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/mk2_desc", Engine[@"hash_4F9F1239CFD921FE"](f135_local36.displayNameRef))
			f135_local0 = f135_local36.name
			f135_local4 = f135_local36.primaryImage
			f135_local14 = f135_local36.weaponInfo
			if f135_local14.ref then
				local f135_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
				if f135_local40 then
					f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local40)
					f135_local3 = f135_local14.displayNameRef
				end
			end
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "weapon_camo" or f135_arg2 == "single_camo" then
		f135_local15 = f135_arg1
		f135_local7 = @"menu/weapon_camo"
		f135_local8 = @"menu/weapon_camo"
		if f135_arg2 == "weapon_camo" then
			f135_local4 = Engine.TableLookup(CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f135_arg1)
		elseif IsBooleanDvarSet(@"hash_232A243E731CD14B") then
			f135_local4 = "blacktransparent"
		else
			f135_local4 = CoD.BlackMarketTableUtility.GetContrabandSingleCamoImageName(f135_arg0, f135_arg8)
		end
		local f135_local34 = Engine.TableFindRows(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f135_arg1)
		if f135_local34 ~= nil then
			local f135_local35 = f135_local34[1]
			f135_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local35, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"])
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_380D5B51243387A8")
			if f135_local4 == nil or f135_local4 == 0x0 then
				f135_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local35, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"])
			end
		end
		local f135_local36 = CoD.BlackMarketUtility.GetWeaponRef(CoD.BlackMarketUtility.GetTableWeaponRef(f135_arg0, f135_arg1, f135_arg6, f135_arg5, f135_arg8))
		if f135_local36 then
			local f135_local38 = Engine[@"hash_4F9F1239CFD921FE"](f135_local36.displayNameRef)
			f135_local14 = f135_local36.weaponInfo
			if f135_arg2 == "single_camo" and f135_local14.displayNameRef then
				f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2D32436AD4978A37", f135_local14.displayNameRef)
				local f135_local40 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
				if f135_local40 then
					f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local40)
					f135_local3 = f135_local14.displayNameRef
				end
			end
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "weapon_camo_bundle" or f135_arg2 == @"hash_1FBA128D08C2E117" then
		f135_local15 = f135_arg1
		local f135_local34 = nil
		if f135_arg2 == "weapon_camo_bundle" then
			f135_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f135_arg0, f135_arg1, "weapon_camo")
			if f135_local34 then
				f135_local15 = f135_local34.name
			end
		else
			f135_local34 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f135_arg0, f135_arg1, "single_camo")
			if f135_local34 then
				f135_local15 = f135_local34.name
			end
		end
		f135_local7 = @"menu/weapon_camo"
		f135_local8 = @"hash_29F902A4E4F760A0"
		if f135_arg2 == "weapon_camo_bundle" then
			f135_local4 = Engine.TableLookup(CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_5B3B869AD96B53C"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f135_local15)
		else
			f135_local4 = CoD.BlackMarketTableUtility.GetContrabandSingleCamoImageName(f135_arg0, f135_arg8)
		end
		local f135_local35 = Engine.TableFindRows(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f135_local15)
		if f135_local35 ~= nil then
			local f135_local36 = f135_local35[1]
			f135_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"])
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_380D5B51243387A8")
			if f135_local4 == nil or f135_local4 == 0x0 then
				f135_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f135_local36, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"])
			end
		end
		local f135_local36 = CoD.BlackMarketUtility.GetTableWeaponRef(f135_arg0, f135_local15, f135_arg6, f135_arg5, f135_arg8)
		if not f135_local36 and f135_arg2 == "weapon_camo_bundle" then
			f135_local36 = CoD.BlackMarketUtility.GetTableWeaponRef(f135_arg0, f135_local15, LuaEnum.LOOT_TYPE.BUNDLE, f135_arg5, f135_arg8)
		end
		local f135_local38 = CoD.BlackMarketUtility.GetWeaponRef(f135_local36)
		if f135_local38 then
			local f135_local39 = Engine[@"hash_4F9F1239CFD921FE"](f135_local38.displayNameRef)
			f135_local14 = f135_local38.weaponInfo
			if f135_arg2 == "single_camo" and f135_local14.displayNameRef then
				f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2D32436AD4978A37", f135_local14.displayNameRef)
			end
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
		f135_local24 = true
	elseif f135_arg2 == "range_weapon" then
		f135_local7 = @"hash_27303A43CCBD4D41"
		f135_local8 = @"hash_27303A43CCBD4D41"
		local f135_local34 = CoD.BlackMarketUtility.GetWeaponRef(f135_arg1)
		if f135_local34 then
			local f135_local35 = Engine[@"hash_4F9F1239CFD921FE"](f135_local34.displayNameRef)
			f135_local0 = f135_local34.name
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](f135_local34.displayDescRef)
			f135_local4 = f135_local34.primaryImage
			f135_local14 = f135_local34.weaponInfo
			if f135_local14.ref then
				local f135_local39 = CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine.GetItemGroup(Engine[@"hash_68FF94BB44442412"](f135_local14.ref, Enum.eModes.mode_multiplayer), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum.eModes.mode_multiplayer))
				if f135_local39 then
					f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](f135_local39)
				end
			end
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f135_arg2 == "character" or f135_arg2 == "specialist" then
		local f135_local34 = Enum.eModes.mode_warzone
		if f135_arg2 == "character" then
			f135_local7 = "menu/blackout_character"
			f135_local8 = "menu/blackout_character"
		else
			f135_local7 = @"menu/specialist"
			f135_local8 = @"menu/specialist"
			f135_local34 = Enum.eModes.mode_multiplayer
		end
		local f135_local35 = CoD.PlayerRoleUtility.GetHeroList(f135_local34)
		local f135_local36 = nil
		for f135_local40, f135_local42 in ipairs(f135_local35) do
			local f135_local43 = Engine[@"getpositionrolebundleinfo"](f135_local34, f135_local42.bodyIndex)
			if f135_local43 and f135_arg1 == f135_local43[@"hash_41D6157DBA773DA3"] then
				f135_local36 = Engine[@"hash_682C5756563934AE"](f135_local34, f135_local42.bodyIndex)
				break
			end
		end
		if f135_local36 then
			f135_local38 = Engine[@"hash_284E3CB0C7D8BA11"](f135_local34, f135_local36)
			f135_local39 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f135_local34, f135_local38)
			f135_local37 = f135_local39.displayName
			f135_local40 = {
				mode = f135_local34,
				characterIndex = f135_local38,
				outfitIndex = 0,
				paletteIndex = 0,
			}
			f135_local42 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f135_local40.mode, f135_local40.characterIndex)
			local f135_local43 = f135_local42.outfits[f135_local40.outfitIndex + 1]
			f135_local0 = f135_local37
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.StreamCharacterDescTable[f135_local36] or @"hash_6CDD8929BD48E4E9")
			if f135_local31 and not (Engine[@"hash_5CAD03ACA52D910A"](f135_local40.mode, f135_local40.characterIndex) or f135_local39.positionDraftIcon) then
				local f135_local44 = Engine[@"hash_4F9F1239CFD921FE"](f135_local0)
				if not f135_local44 then
					f135_local44 = "<invalid character>"
				end
				CoD.BlackMarketUtility.Error(f135_arg0, "Loot: character " .. f135_local44 .. " has no loot stream icon in the player body type.\n")
			end
			f135_local10 = f135_local36
			f135_local11 = f135_local40
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No character has loot identifier '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	elseif f135_arg2 == "gesture" then
		f135_local7 = @"menu/gesture"
		f135_local8 = @"menu/gesture"
		local f135_local34 = CoD.BlackMarketUtility.GetGestureRef(f135_arg0, f135_arg1, f135_arg5, f135_arg6)
		if f135_local34 then
			f135_local10 = f135_local34.character
			f135_local11 = f135_local34.outfitIndexes
			f135_local4 = f135_local34.primaryImage
			f135_local0 = f135_local34.name
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6977A1C579497A0A")
			f135_local12 = f135_local34.gesture_index
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No gesture info found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.GESTURE
	elseif f135_arg2 == "gesture_bundle" then
		f135_local7 = @"menu/gesture"
		f135_local8 = @"hash_29F902A4E4F760A0"
		local f135_local34 = 0x0
		local f135_local35 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f135_arg0, f135_arg1, "gesture")
		if f135_local35 then
			f135_local34 = f135_local35.name
		end
		local f135_local36 = CoD.BlackMarketUtility.GetGestureRef(f135_arg0, f135_local34, f135_arg5, f135_arg6)
		if f135_local36 then
			f135_local10 = f135_local36.character
			f135_local11 = f135_local36.outfitIndexes
			f135_local4 = f135_local36.primaryImage
			f135_local0 = f135_local36.name
			f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6977A1C579497A0A")
			f135_local12 = f135_local36.gesture_index
		elseif f135_local31 then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No gesture info found for '" .. tostring(f135_arg1) .. "'.\n")
		end
		f135_local29 = LuaEnum.LOOT_CAMERA_TYPE.GESTURE
		f135_local24 = true
	elseif f135_arg2 == "reticle" then
		f135_local7 = "mpui/reticle_caps"
		f135_local8 = "mpui/reticle_caps"
		local f135_local34, f135_local35, f135_local36 = CoD.WeaponOptionsUtility.GetReticleLootStreamData(f135_arg1, f135_arg7)
		f135_local0 = f135_local34 or 0x0
		if not f135_local36 then
			f135_local36 = 0x0
		end
		f135_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_93B591B40C51B96", f135_local36)
		f135_local4 = f135_local35 or 0x0
		f135_local6 = f135_local35 or 0x0
		f135_local2 = Engine[@"hash_4F9F1239CFD921FE"]("mpui/attachment_group_optic")
		f135_local3 = f135_local36 or 0x0
	end
	if f135_local31 then
		if (not f135_local4 or f135_local4 == 0x0) and not f135_arg6 == LuaEnum.LOOT_TYPE.ITEMSHOP then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No primary image found for '" .. tostring(f135_arg1) .. "' (" .. tostring(f135_arg2) .. ").\n")
		end
		if (not f135_local0 or f135_local0 == 0x0) and not f135_arg6 == LuaEnum.LOOT_TYPE.ITEMSHOP then
			CoD.BlackMarketUtility.Error(f135_arg0, "Loot: No name found for '" .. tostring(f135_arg1) .. "' (" .. tostring(f135_arg2) .. ").\n")
		end
	end
	if f135_local30 then
		f135_local9 = Enum.LootRarityType[@"loot_rarity_type_count"]
	else
		f135_local9 = CoD.BlackMarketUtility.GetLootRarityType(f135_arg3)
	end
	if f135_arg4 ~= nil and f135_arg4 ~= 0x0 then
		if IsJapaneseSku() then
			f135_local17 = 0x0
			f135_local18 = false
		else
			f135_local2 = Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketTableUtility.GetLootBonusStringRef(f135_arg0, f135_arg4))
			if f135_arg2 == "tag_bundle" then
				f135_local3 = 0x0
			else
				f135_local3 = @"hash_1F6BC2AD33480070"
			end
			f135_local16 = CoD.BlackMarketTableUtility.GetBonusSetMasterNameHash(f135_arg4)
			if f135_arg2 ~= "tag" then
			else
			end
			for f135_local39, f135_local37 in ipairs(CoD.BreadcrumbUtility.GetSprayGestureTable()) do
				if f135_local37[@"assetname"] == f135_local16 then
					f135_local16 = f135_local37.icon
					f135_local17 = f135_local37.title
				end
			end
		end
	end
	if f135_local2 == nil then
		f135_local2 = ""
	end
	if f135_local3 == nil then
		f135_local3 = 0x0
	end
	if f135_local5 == 0x0 then
		f135_local5 = f135_local4
	end
	if f135_local14 and not f135_local14.modelIdx then
		f135_local14.modelIdx = 0
	end
	return {
		itemName = f135_arg1,
		name = f135_local0,
		desc = f135_local1,
		mainExtraText = f135_local2,
		subExtraText = f135_local3,
		primaryImage = f135_local4,
		popupImage = f135_local6,
		detailsImage = f135_local5,
		category = f135_local7,
		itemCategory = f135_arg2,
		rarity = f135_local9,
		skipDefaultTitle = true,
		character = f135_local10,
		outfitIndexes = f135_local11,
		gesture_index = f135_local12,
		signatureWeaponInfo = f135_local13,
		baseWeaponInfo = f135_local14,
		camoRef = f135_local15,
		setBonusImage = f135_local16,
		setBonusName = f135_local17,
		setComplete = f135_local18,
		setNumOwned = f135_local19,
		setNumTotal = f135_local21,
		isContrabandCrate = f135_local22,
		isBundle = f135_local24,
		allowTogglePreview = f135_local25,
		allowFrozenMoment = f135_local26,
		shopCategory = f135_local8,
		seasonal = f135_local27,
		includesTiers = f135_local28,
		lootType = f135_arg6,
		cameraType = f135_local29,
		isContract = false,
		movieName = f135_local32,
		toolTipText = f135_local33,
	}
end
CoD.BlackMarketUtility.TierItemsAppendBlank = function(f136_arg0, f136_arg1, f136_arg2, f136_arg3)
	for f136_local0 = f136_arg1, f136_arg2, 1 do
		table.insert(f136_arg0, CoD.BlackMarketUtility.GetEmptyInsertItem(f136_local0, f136_local0 <= f136_arg3))
	end
end
CoD.BlackMarketUtility.TierItemsAppend = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3, f137_arg4, f137_arg5)
	for f137_local0 = f137_arg3, f137_arg4, 1 do
		local f137_local3 = f137_local0 <= f137_arg5
		local f137_local4 = CoD.BlackMarketTableUtility.GetStreamItemsByTier(f137_arg0, f137_arg2, f137_local0)
		local f137_local5 = CoD.BlackMarketUtility.GetEmptyInsertItem(f137_local0, f137_local3)
		if f137_local4 ~= nil and #f137_local4 ~= 0 then
			if f137_local4[1].name ~= nil and f137_local4[1].name ~= 0x0 and f137_local4[1].category ~= nil and f137_local4[1].rarity ~= nil then
				local f137_local6 = {}
				f137_local6 = CoD.BlackMarketUtility.GetItemRefs(f137_arg0, f137_local4[1].name, f137_local4[1].category, f137_local4[1].rarity, f137_local4[1].inSet, f137_arg2, f137_local4[1].lootType, f137_local4[1].refOptic, f137_local4[1].itemId)
				f137_local6.tier = f137_local0
				f137_local6.unlocked = f137_local3
				f137_local6.lootType = f137_local4[1].lootType
				if f137_local4[1].dupe then
					f137_local6.dupe = f137_local4[1].dupe
				else
					f137_local6.dupe = false
				end
				if f137_local4[1].reroll then
					f137_local6.reroll = f137_local4[1].reroll
				else
					f137_local6.reroll = false
				end
				f137_local6.movieName = f137_local4[1].movieName or ""
				if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and (f137_local4[1].itemId == "420487198" or f137_local4[1].itemId == "162635431") then
					f137_local6.movieName = ""
				end
				f137_local6.gap = true
				f137_local5 = f137_local6
			elseif f137_local4[1].name == 0x0 and f137_local4[1].gap then
				f137_local5.gap = true
			end
		end
		table.insert(f137_arg1, f137_local5)
	end
end
CoD.BlackMarketUtility.GetTierItemsForStream = function(f138_arg0, f138_arg1, f138_arg2, f138_arg3, f138_arg4)
	local f138_local0 = {}
	if f138_arg3 and not Engine[@"hash_1BFC6045CA596824"](f138_arg0, CoDShared.Loot.GetCurrentSeason(), f138_arg1) then
		Engine[0x165DC7DAA0794C](f138_arg0, CoDShared.Loot.GetCurrentSeason(), f138_arg1)
	end
	local f138_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f138_arg0)
	local f138_local2 = CoDShared.Loot.GetCurrentSeason()
	if f138_local2 and f138_local2 ~= 0x0 then
		local f138_local3 = CoDShared.Loot.GetSeasonInfo(f138_local2)
		if CoDShared.Loot.GetSeasonInfoParam(f138_local2, CoDShared.Loot.SEASON_INFO_NUMBER) >= 3 then
			for f138_local4 = f138_arg1, f138_arg2, 1 do
				CoD.BlackMarketUtility.TierItemsAppend(f138_arg0, f138_local0, f138_local3.id, f138_local4, f138_local4, f138_local1)
			end
		elseif CoD.SafeGetModelValue(Engine.GetModelForController(f138_arg0), "LootStreamProgress.allRngUnlocked") == true then
			for f138_local4 = f138_arg1, f138_arg2, 1 do
				if f138_local1 < f138_local4 and f138_local4 > CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
					CoD.BlackMarketUtility.TierItemsAppendBlank(f138_local0, f138_local4, f138_local4, f138_local1)
				else
					CoD.BlackMarketUtility.TierItemsAppend(f138_arg0, f138_local0, f138_local3.id, f138_local4, f138_local4, f138_local1)
				end
			end
		else
			CoD.BlackMarketUtility.TierItemsAppend(f138_arg0, f138_local0, f138_local3.id, f138_arg1, f138_arg2, f138_local1)
		end
	end
	local f138_local3 = CoDShared.Loot.GetCurrentEventContract()
	if f138_local3 and f138_local3 ~= 0x0 then
		local f138_local4 = CoDShared.Loot.GetContractInfo(f138_arg0, f138_local3)
		CoD.BlackMarketUtility.TierItemsAppend(f138_arg0, f138_local0, f138_local4.id, f138_arg1, f138_arg2, f138_local1)
	end
	if CoD.BlackMarketUtility.AreContractsEnabled() then
		local f138_local4 = false
		for f138_local9, f138_local10 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f138_arg0)) do
			if f138_local10.id > 0 and (CoD.perController[f138_arg0].haveActiveContractInStream or not CoD.ContractUtility.IsContractComplete(f138_arg0, f138_local10.id) or f138_arg4) then
				CoD.BlackMarketUtility.TierItemsAppend(f138_arg0, f138_local0, f138_local10.id, f138_arg1, f138_arg2, f138_local1)
				f138_local4 = true
			end
		end
		f138_local6 = false
		if not f138_local4 then
			for f138_local11, f138_local12 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
				if not CoD.ContractUtility.IsContractPurchased(f138_arg0, f138_local12) then
					f138_local6 = true
					break
				end
			end
		end
		if not f138_local4 then
			CoD.BlackMarketUtility.TierItemsAppendBlank(f138_local0, f138_arg1, f138_arg2, f138_local1)
		end
	end
	if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_5DC2632EE88877F2"]:exists() then
		local f138_local4 = tonumber(Dvar[@"hash_5DC2632EE88877F2"]:get())
		for f138_local5 = 1, f138_local4, 1 do
			local f138_local8 = f138_local5
			CoD.BlackMarketUtility.TierItemsAppendBlank(f138_local0, f138_arg1, f138_arg2, f138_local1)
		end
	end
	return f138_local0
end
CoD.BlackMarketUtility.GetPaletteFromOutfitInfo = function(f139_arg0, f139_arg1)
	for f139_local3, f139_local4 in ipairs(f139_arg0.palettes) do
		if f139_local4.displayName == f139_arg1 then
			return f139_local3 - 1
		end
	end
	return 0
end
CoD.BlackMarketUtility.FindCharacterDetailsFromLootId = function(f140_arg0)
	local f140_local0 = {
		armsIndex = -1,
		decalIndex = -1,
		headIndex = -1,
		headgearIndex = -1,
		legsIndex = -1,
		paletteIndex = -1,
		torsoIndex = -1,
		war_paintIndex = -1,
		presetIndex = -1,
		mode = f140_arg0.mode,
	}
	local f140_local1 = -1
	if f140_arg0 and f140_arg0.prt then
		f140_local1 = Engine[@"hash_17A27F5596966FEA"](f140_local0.mode, f140_arg0.prt)
	end
	if f140_local1 >= 0 then
		f140_local0.characterIndex = f140_local1
		local f140_local2 = -1
		if f140_arg0.outfit then
			f140_local2 = Engine[@"hash_2DCBEC2E0A9518B7"](f140_local0.mode, f140_local1, f140_arg0.outfit)
			if f140_local2 >= 0 then
				f140_local0.outfitIndex = f140_local2
				local f140_local3 = function(f141_arg0, f141_arg1)
					if f140_arg0[f141_arg0] ~= 0x0 then
						local f141_local0 = Engine[0x1556270BCD75F1](f140_local0.mode, f140_local1, f140_local2, f140_arg0[f141_arg0], f141_arg1)
						if f141_local0 >= 0 then
							return f141_local0
						end
					end
					return -1
				end
				f140_local0.decalIndex = f140_local3("decal", Enum.CharacterItemType[@"hash_57852FCB3BFCC8D1"])
				f140_local0.war_paintIndex = f140_local3("war_paint", Enum.CharacterItemType[@"hash_48E3A65D78229DC1"])
				if f140_arg0.preset and f140_arg0.preset ~= 0x0 then
					local f140_local4, f140_local5 = Engine[@"hash_7E1AA381BC4D0919"](f140_local0.mode, f140_local1, f140_local2, f140_arg0.preset)
					if f140_local4 >= 0 then
						f140_local0.presetIndex = f140_local4
						if f140_local5 then
							f140_local0.armsIndex = f140_local5[Enum.CharacterItemType[@"hash_141B42F0A58AC50F"]] or -1
							f140_local0.headIndex = f140_local5[Enum.CharacterItemType[@"hash_37AD40A4111A72FE"]] or -1
							f140_local0.headgearIndex = f140_local5[Enum.CharacterItemType[@"hash_4FF8573E011622F4"]] or -1
							f140_local0.legsIndex = f140_local5[Enum.CharacterItemType[@"hash_283CBB806B732B11"]] or -1
							f140_local0.paletteIndex = f140_local5[Enum.CharacterItemType[@"hash_4922FE5C41D9EE8B"]] or -1
							f140_local0.torsoIndex = f140_local5[Enum.CharacterItemType[@"hash_19DDCEC39BA98B97"]] or -1
						end
						if f140_local0.war_paintIndex == -1 then
							local f140_local6 = Engine[@"hash_3544F754695D09F5"](f140_local0.mode, f140_local1, f140_local2, f140_arg0.preset)
							if f140_local6 >= 0 then
								f140_local0.war_paintIndex = f140_local6
							end
						end
					end
				elseif f140_local0.war_paintIndex >= -1 then
					local f140_local4 = Engine[@"hash_2D9F74DA4E09BB13"](f140_local0.mode, f140_local1, f140_local2, f140_arg0.war_paint)
					if f140_local4 >= 0 then
						f140_local0.paletteIndex = f140_local4
					end
				end
			end
		end
	end
	return f140_local0
end
CoD.BlackMarketUtility.TEMP_FindCharacterDetailsFromTempProduct = function(f142_arg0)
	return nil, nil, nil
end
DataSources.QuarterMasterCategoryList = ListHelper_SetupDataSource(
	"QuarterMasterCategoryList",
	function(f143_arg0, f143_arg1)
		local f143_local0 = {}
		local f143_local1 = IsBooleanDvarSet(@"hash_1A8E4D68B803874")
		local f143_local2 = f143_arg1 and f143_arg1.menu._tab
		if not f143_local2 or f143_local2 == "" then
			f143_local2 = "itemshop"
		end
		local f143_local3 = function(f144_arg0, f144_arg1, f144_arg2, f144_arg3, f144_arg4)
			table.insert(f143_local0, {
				models = {
					category = f144_arg0,
					name = f144_arg1,
					frameWidget = f144_arg2,
					available = f144_arg3,
					showCaseBreadcrumb = f144_arg4,
				},
				properties = {
					selectIndex = f143_local2 == f144_arg0,
				},
			})
		end
		if CoD.BlackMarketUtility.AreCoDPointsEnabled() then
			local f143_local4 = Dvar[@"hash_76C53836C456EC20"]
			if f143_local4 then
				f143_local4 = Dvar[@"hash_76C53836C456EC20"]:exists()
				if f143_local4 then
					f143_local4 = tonumber(Dvar[@"hash_76C53836C456EC20"]:get()) == 1
				end
			end
			local f143_local5
			if f143_local1 then
				f143_local5 = "CoD.BlackJacksShopFrameSunset"
				if not f143_local5 then
				else
					f143_local3("itemshop", "menu/item_shop", f143_local5, f143_local4 == true, false)
				end
			end
			f143_local5 = "CoD.BlackJacksShopFrame"
		end
		if IsBooleanDvarSet(@"hash_1989C6B82918FBCC") and not Engine[@"hash_5CB675CA7856DA25"]() then
			f143_local3("reserves", @"hash_725FC26BF505BC71", "CoD.BlackjackReserveFrame", true, true)
		end
		f143_local3("supplychain", @"menu/supply_chain", "CoD.SupplyChainFrame", true, false)
		if not Engine[@"hash_5CB675CA7856DA25"]() then
			f143_local3("inventory", @"menu/inventory", "CoD.ItemHistoryFrame", true, false)
		end
		return f143_local0
	end,
	nil,
	nil,
	function(f145_arg0, f145_arg1, f145_arg2)
		if not f145_arg1._quarterMasterCategoryList then
			f145_arg1._quarterMasterCategoryList = true
			f145_arg1._isReservesActive = IsBooleanDvarSet("loot_enable_blackjack_reserves")
			f145_arg1._isSunsetActive = IsBooleanDvarSet(@"hash_1A8E4D68B803874")
			local f145_local0 = f145_arg1
			local f145_local1 = f145_arg1.subscribeToModel
			local f145_local2 = Engine.GetModelForController(f145_arg0)
			f145_local1(f145_local0, f145_local2:create("QuarterMasterTabUpdate"), function()
				f145_arg1:updateDataSource()
			end, false)
			f145_arg1:subscribeToGlobalModel(f145_arg0, "AutoEvents", "cycled", function()
				local f147_local0 = IsBooleanDvarSet("loot_enable_blackjack_reserves")
				local f147_local1 = IsBooleanDvarSet(@"hash_1A8E4D68B803874")
				if f145_arg1._isReservesActive ~= f147_local0 or f145_arg1._isSunsetActive ~= f147_local1 then
					f145_arg1._isReservesActive = f147_local0
					f145_arg1._isSunsetActive = f147_local1
					f145_arg1:updateDataSource()
				end
			end, false)
		end
	end
)
CoD.BlackMarketUtility.SetPropertiesFromItemModel = function(f148_arg0, f148_arg1)
	local f148_local0 = f148_arg1:getModel()
	if f148_local0.outfitIndexes then
		f148_arg1.mode = f148_local0.outfitIndexes.mode:get()
		f148_arg1.characterIndex = f148_local0.outfitIndexes.characterIndex:get()
		if f148_local0.outfitIndexes.outfitIndex then
			f148_arg1.outfitIndex = f148_local0.outfitIndexes.outfitIndex:get()
			f148_arg1.armsIndex = f148_local0.outfitIndexes.armsIndex and f148_local0.outfitIndexes.armsIndex:get() or 0
			f148_arg1.decalIndex = f148_local0.outfitIndexes.decalIndex and f148_local0.outfitIndexes.decalIndex:get() or 0
			f148_arg1.headIndex = f148_local0.outfitIndexes.headIndex and f148_local0.outfitIndexes.headIndex:get() or 0
			f148_arg1.headgearIndex = f148_local0.outfitIndexes.headgearIndex and f148_local0.outfitIndexes.headgearIndex:get() or 0
			f148_arg1.legsIndex = f148_local0.outfitIndexes.legsIndex and f148_local0.outfitIndexes.legsIndex:get() or 0
			f148_arg1.paletteIndex = f148_local0.outfitIndexes.paletteIndex and f148_local0.outfitIndexes.paletteIndex:get() or 0
			f148_arg1.torsoIndex = f148_local0.outfitIndexes.torsoIndex and f148_local0.outfitIndexes.torsoIndex:get() or 0
			f148_arg1.war_paintIndex = f148_local0.outfitIndexes.war_paintIndex and f148_local0.outfitIndexes.war_paintIndex:get() or 0
		end
	end
	if f148_local0.baseWeaponInfo then
		f148_arg1.baseWeaponInfo = {
			weaponSlot = f148_local0.baseWeaponInfo.weaponSlot:get(),
			ref = f148_local0.baseWeaponInfo.ref:get(),
			displayNameRef = f148_local0.baseWeaponInfo.displayNameRef:get(),
			modelIdx = f148_local0.baseWeaponInfo.modelIdx and f148_local0.baseWeaponInfo.modelIdx:get() or 0,
		}
	else
		f148_arg1.baseWeaponInfo = nil
	end
	if f148_local0.signatureWeaponInfo then
		f148_arg1.signatureWeaponInfo = {
			weaponSlot = f148_local0.signatureWeaponInfo.weaponSlot:get(),
			ref = f148_local0.signatureWeaponInfo.ref:get(),
			signatureIndex = f148_local0.signatureWeaponInfo.signatureIndex:get(),
			mastercraftIndex = f148_local0.signatureWeaponInfo.mastercraftIndex:get(),
			displayNameRef = f148_local0.signatureWeaponInfo.displayNameRef:get(),
			mastercraftNameRef = f148_local0.signatureWeaponInfo.mastercraftNameRef:get(),
		}
	else
		f148_arg1.signatureWeaponInfo = nil
	end
	if f148_local0.camoRef then
		f148_arg1.camoRef = f148_local0.camoRef:get()
	end
	if f148_local0.gesture_index then
		f148_arg1.gesture_index = f148_local0.gesture_index:get()
	end
end
CoD.BlackMarketUtility.IsItemPurchased = function(f149_arg0, f149_arg1)
	local f149_local0 = CoDLootShared.GetItemNameHashFromLootId(f149_arg1)
	if f149_local0 then
		if CoDShared.IsLootItemOwnedByName(f149_arg0, f149_local0) then
			return true
		elseif CoD.BlackMarketTableUtility.IsItemLootBundle(f149_arg0, f149_local0) then
			return CoD.BlackMarketTableUtility.AreAllBundleKeyItemsOwned(f149_arg0, f149_local0)
		end
	end
	return Engine[@"hash_5352DC095BBB2A45"](f149_arg0, f149_arg1) > 0
end
CoD.BlackMarketUtility.GetItemShopDatasourceModelValues = function(f150_arg0, f150_arg1)
	local f150_local0 = CoD.BlackMarketUtility.GetItemRefs(f150_arg0, f150_arg1.name, f150_arg1.category, f150_arg1.rarity, f150_arg1.inSet, nil, f150_arg1.lootType, f150_arg1.refOptic, f150_arg1.itemId)
	f150_local0.price = f150_arg1.price
	if f150_local0.itemCategory ~= "signature_weapon" then
		f150_local0.allowTogglePreview = false
	end
	local f150_local1 = Engine[@"hash_2E00B2F29271C60B"](f150_arg1.name .. "_shop")
	if f150_local1 == nil then
		f150_local1 = Engine[@"hash_2E00B2F29271C60B"](f150_arg1.name)
	end
	if f150_local1 then
		f150_local0.lootType = LuaEnum.LOOT_TYPE.ITEMSHOP
		if f150_local1.shopicon then
			f150_local0.primaryImage = f150_local1.shopicon
			f150_local0.detailsImage = f150_local1.shopicon
			if f150_local0.popupImage ~= nil and f150_local0.popupImage ~= 0x0 and f150_local0.itemCategory ~= "jump_kit" then
				f150_local0.popupImage = f150_local1.shopicon
			end
		end
		if f150_local1[@"nametext"] then
			f150_local0.name = f150_local1[@"nametext"]
		end
		if f150_local1[@"categorytext"] then
			f150_local0.category = f150_local1[@"categorytext"]
			f150_local0.shopCategory = f150_local1[@"categorytext"]
		end
		if f150_local1[@"desctext"] then
			if f150_local1[@"hash_5705C4C12FE1D66A"] then
				f150_local0.desc = Engine[@"hash_4F9F1239CFD921FE"](f150_local1[@"desctext"], f150_local1[@"hash_5705C4C12FE1D66A"])
			else
				f150_local0.desc = Engine[@"hash_4F9F1239CFD921FE"](f150_local1[@"desctext"])
			end
		end
		if f150_local1.mainextratext then
			f150_local0.mainExtraText = Engine[@"hash_4F9F1239CFD921FE"](f150_local1.mainextratext)
		end
		if f150_local1[@"hash_4B2638377E03D79A"] then
			f150_local0.subExtraText = f150_local1[@"hash_4B2638377E03D79A"]
		end
		if f150_local1[@"detailsicon"] then
			f150_local0.detailsImage = f150_local1[@"detailsicon"]
		end
	else
		for f150_local5, f150_local6 in pairs(CoD.BlackMarketUtility.ItemShopImageOverrideTable) do
			if f150_local0.primaryImage == f150_local5 then
				f150_local0.primaryImage = f150_local6
				break
			end
		end
	end
	f150_local0.skuID = f150_arg1.itemId
	f150_local0.hashName = f150_arg1.name
	local f150_local2 = f150_arg1.movieName
	if not f150_local2 then
		f150_local2 = ""
	end
	f150_local0.movieName = f150_local2
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() and (f150_arg1.itemId == "420487198" or f150_arg1.itemId == "162635431") then
		f150_local0.movieName = ""
	end
	f150_local0.purchased = CoD.BlackMarketUtility.IsItemPurchased(f150_arg0, f150_arg1.itemId)
	if f150_local0.purchased == false then
		f150_local0.purchased = CoD.BlackMarketTableUtility.AreAllBundleKeyItemsOwned(f150_arg0, f150_local0.hashName)
	end
	f150_local0.totalRewardCount = 1
	f150_local2 = CoD.BlackMarketTableUtility.GetBundlePiecesInformation(f150_arg0, f150_arg1.name)
	if f150_local2 then
		f150_local0.totalRewardCount = #f150_local2
	end
	f150_local0.percentOff = 0
	if f150_local0.movieName and f150_local0.movieName ~= "" then
		f150_local0.isLooping = true
		f150_local0.isStreamed = false
	end
	if f150_local0.movieName == "core_frontend_ar_modular_mk2" then
		f150_local0.isLooping = false
	end
	if IsBooleanDvarSet("loot_enable_discounts") and f150_arg1.discountSkuId and f150_arg1.discountSkuId ~= "" and f150_arg1.discountPrice and f150_arg1.discountPrice > 0 then
		f150_local0.skuID = f150_arg1.discountSkuId
		f150_local0.price = f150_arg1.discountPrice
		f150_local0.percentOff = math.floor((1 - f150_arg1.discountPrice / f150_arg1.price) * 100)
	end
	return f150_local0
end
CoD.BlackMarketUtility.CreateItemShopDatasource = function(f151_arg0, f151_arg1)
	local f151_local0 = {}
	local f151_local1 = {}
	for f151_local5, f151_local6 in ipairs(CoD.BlackMarketUtility["FeaturedSlot" .. f151_arg1 .. "Items"]) do
		if f151_local6 then
			table.insert(f151_local1, f151_local6)
		end
	end
	table.sort(f151_local1, function(f152_arg0, f152_arg1)
		return Engine[@"isgreaterthan"](f152_arg0.start, f152_arg1.start)
	end)
	f151_local2 = {}
	f151_local3 = {}
	for f151_local4 = 1, #f151_local1, 1 do
		local f151_local7 = CoD.BlackMarketTableUtility.GetItemShopInformation(f151_arg0, f151_local1[f151_local4].name)
		if f151_local7 then
			local f151_local8 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f151_arg0, f151_local7)
			if f151_local8.purchased ~= true then
				table.insert(f151_local2, f151_local8)
			else
				table.insert(f151_local3, f151_local8)
			end
		end
	end
	for f151_local9, f151_local7 in ipairs(f151_local3) do
		table.insert(f151_local2, f151_local7)
	end
	for f151_local4 = 1, #f151_local2, 1 do
		local f151_local7, f151_local8 = CoD.BlackMarketUtility.GetItemProductAndProperties(f151_local2[f151_local4])
		f151_local7.stackPosition = f151_local4
		f151_local7.stackTotal = #f151_local2
		f151_local7.storePreview = true
		f151_local7.slot = f151_arg1
		table.insert(f151_local0, {
			models = f151_local7,
			properties = f151_local8,
		})
	end
	return f151_local0
end
CoD.BlackMarketUtility.ForceStreamedStoreImages = {}
CoD.BlackMarketUtility.ForceStreamStoreImages = function(f153_arg0)
	local f153_local0 = {}
	local f153_local1 = {}
	local f153_local2 = CoD.BlackMarketUtility.CreateItemShopDatasource(f153_arg0, 1)
	local f153_local3 = CoD.BlackMarketUtility.CreateItemShopDatasource(f153_arg0, 2)
	for f153_local8, f153_local9 in ipairs(f153_local2) do
		for f153_local5, f153_local6 in ipairs(f153_local9) do
			if f153_local6.models and f153_local6.models.primaryImage then
				CoD.BaseUtility.AddForcedImageToTable(f153_local6.models.primaryImage, f153_local0)
				if f153_local6.models.detailsImage and f153_local6.models.detailsImage ~= f153_local6.models.primaryImage then
					CoD.BaseUtility.AddForcedImageToTable(f153_local6.models.detailsImage, f153_local0)
				end
			end
		end
	end
	for f153_local9, f153_local10 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
		local f153_local11 = CoD.ContractUtility.GetContractListModels(f153_arg0, f153_local10)
		if f153_local11 and f153_local11.previewImage then
			CoD.BaseUtility.AddForcedImageToTable(f153_local11.previewImage, f153_local0)
		end
	end
	CoD.BlackMarketUtility.ForceStreamedStoreImages = CoD.BaseUtility.ForceStreamHelper(CoD.BlackMarketUtility.ForceStreamedStoreImages, f153_local0)
end
CoD.BlackMarketUtility.ForceStreamStoreImagesSunset = function(f154_arg0, f154_arg1)
	local f154_local0 = {}
	local f154_local1 = {}
	f154_arg1._detItemSlot1 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f154_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
	f154_arg1._detItemSlot2 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f154_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
	f154_arg1._rngItemSlot3 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f154_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"])
	table.insert(f154_local1, f154_arg1._detItemSlot1)
	table.insert(f154_local1, f154_arg1._detItemSlot2)
	table.insert(f154_local1, f154_arg1._rngItemSlot3)
	for f154_local8, f154_local9 in ipairs(f154_local1) do
		for f154_local5, f154_local6 in ipairs(f154_local9) do
			if f154_local6.models and f154_local6.models.primaryImage then
				CoD.BaseUtility.AddForcedImageToTable(f154_local6.models.primaryImage, f154_local0)
				if f154_local6.models.detailsImage and f154_local6.models.detailsImage ~= f154_local6.models.primaryImage then
					CoD.BaseUtility.AddForcedImageToTable(f154_local6.models.detailsImage, f154_local0)
				end
			end
		end
	end
	CoD.BlackMarketUtility.ForceStreamedStoreImages = CoD.BaseUtility.ForceStreamHelper(CoD.BlackMarketUtility.ForceStreamedStoreImages, f154_local0)
end
DataSources.ItemShopSlot1List = ListHelper_SetupDataSource("ItemShopSlot1List", function(f155_arg0)
	return CoD.BlackMarketUtility.CreateItemShopDatasource(f155_arg0, 1)
end)
DataSources.ItemShopSlot2List = ListHelper_SetupDataSource("ItemShopSlot2List", function(f156_arg0)
	return CoD.BlackMarketUtility.CreateItemShopDatasource(f156_arg0, 2)
end)
DataSources.ItemShopSlot3List = ListHelper_SetupDataSource("ItemShopSlot3List", function(f157_arg0)
	local f157_local0 = {}
	local f157_local1 = {}
	for f157_local5, f157_local6 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
		local f157_local7 = CoD.ContractUtility.GetContractListModels(f157_arg0, f157_local6)
		CoD.ContractUtility.AppendPurchasableContractSlotModels(f157_arg0, f157_local7, 3)
		f157_local7.storePreview = true
		f157_local7.slot = 3
		if f157_local7.purchased ~= true then
			table.insert(f157_local0, {
				models = f157_local7,
				properties = {
					inPurchasableRow = true,
					contractModels = f157_local7,
				},
			})
		else
			table.insert(f157_local1, {
				models = f157_local7,
				properties = {
					inPurchasableRow = true,
					contractModels = f157_local7,
				},
			})
		end
	end
	for f157_local5, f157_local6 in ipairs(f157_local1) do
		table.insert(f157_local0, f157_local6)
	end
	return f157_local0
end)
CoD.BlackMarketUtility.IsMyShopItemRevealed = function(f158_arg0)
	local f158_local0 = Engine[@"hash_12C2DB3D3E1B227E"](f158_arg0)
	local f158_local1
	if f158_local0 ~= nil then
		f158_local1 = f158_local0.timestamp
		if not f158_local1 then
		else
			if f158_local0 == nil or not CoD.BlackMarketUtility.CanRevealMyShopItem(f158_arg0) or CoD.BlackMarketUtility.IsMyShopItemOld(f158_arg0, f158_local1, f158_local0.itemId) then
				return false
			else
				return true
			end
		end
	end
	f158_local1 = nil
end
DataSources.MyShopItemList = ListHelper_SetupDataSource("MyShopItemList", function(f159_arg0)
	local f159_local0 = {}
	local f159_local1, f159_local2, f159_local3 = nil
	local f159_local4 = "0"
	local f159_local5 = Engine[@"hash_12C2DB3D3E1B227E"](f159_arg0)
	if f159_local5 == nil or not CoD.BlackMarketUtility.CanRevealMyShopItem(f159_arg0) then
		local f159_local6 = CoD.BlackMarketUtility.GetEmptyInsertItem(1, false)
		if f159_local6 then
			local f159_local7, f159_local8 = CoD.BlackMarketUtility.GetItemProductAndProperties(f159_local6)
			f159_local7.revealed = false
			f159_local7.percentOff = 0
			f159_local7.contractId = "0"
			table.insert(f159_local0, {
				models = f159_local7,
				properties = f159_local8,
			})
			return f159_local0
		end
	end
	f159_local4 = f159_local5.timestamp
	f159_local3 = f159_local5.price_point
	if CoD.BlackMarketUtility.IsMyShopItemOld(f159_arg0, f159_local4, f159_local5.itemId) then
		local f159_local6 = CoD.BlackMarketUtility.GetEmptyInsertItem(1, false)
		if f159_local6 then
			local f159_local7, f159_local8 = CoD.BlackMarketUtility.GetItemProductAndProperties(f159_local6)
			f159_local7.revealed = false
			f159_local7.percentOff = 0
			f159_local7.contractId = "0"
			table.insert(f159_local0, {
				models = f159_local7,
				properties = f159_local8,
			})
		end
	else
		f159_local1 = f159_local5.itemId
		f159_local2 = CoD.BlackMarketTableUtility.GetMyShopItemNameFromId(f159_arg0, f159_local1)
		if f159_local2 and f159_local1 then
			local f159_local6 = CoD.BlackMarketTableUtility.GetMyShopItemCategory(f159_arg0, f159_local2)
			local f159_local7 = CoD.BlackMarketTableUtility.GetMyShopSkuAndPrice(f159_arg0, f159_local2, f159_local3)
			if f159_local6 == "special_order" then
				local f159_local8 = CoD.ContractUtility.GetContractListModels(f159_arg0, f159_local1)
				CoD.ContractUtility.AppendPurchasableContractSlotModels(f159_arg0, f159_local8, 4)
				f159_local8.storePreview = true
				f159_local8.revealed = true
				if Dvar[@"hash_1931ECBB3DB3B98E"]:get() and f159_local8.price and f159_local8.price > 0 then
					f159_local8.percentOff = math.floor((1 - f159_local7.price / f159_local8.price) * 100)
				end
				f159_local8.price = f159_local7.price or 0
				f159_local8.skuID = f159_local7.sku or "0"
				f159_local8.slot = 4
				table.insert(f159_local0, {
					models = f159_local8,
					properties = {
						inPurchasableRow = true,
						contractModels = f159_local8,
					},
				})
			else
				local f159_local8 = nil
				if f159_local6 == "loot_stream" then
					f159_local8 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f159_arg0, f159_local1)
				else
					f159_local8 = CoD.BlackMarketTableUtility.GetItemShopInformation(f159_arg0, f159_local2)
				end
				if f159_local8 then
					local f159_local9 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f159_arg0, f159_local8)
					if f159_local9 then
						local f159_local10, f159_local11 = CoD.BlackMarketUtility.GetItemProductAndProperties(f159_local9)
						f159_local10.revealed = true
						if Dvar[@"hash_1931ECBB3DB3B98E"]:get() and f159_local10.price and f159_local10.price > 0 then
							f159_local10.percentOff = math.floor((1 - f159_local7.price / f159_local10.price) * 100)
						end
						f159_local10.price = f159_local7.price
						f159_local10.skuID = f159_local7.sku
						f159_local10.slot = 4
						f159_local10.lootType = LuaEnum.LOOT_TYPE.ITEMSHOP
						f159_local10.storePreview = true
						table.insert(f159_local0, {
							models = f159_local10,
							properties = f159_local11,
						})
					end
				end
			end
		end
	end
	return f159_local0
end)
CoD.BlackMarketUtility.IsMyShopItemOld = function(f160_arg0, f160_arg1, f160_arg2)
	local f160_local0 = Engine[@"hash_2C778D3D40E06605"](f160_arg1, CoD.BlackMarketUtility.GetMyShopRotateTime())
	local f160_local1 = tostring(Engine.GetCurrentUTCTimeStr())
	if Engine[@"isgreaterthan"](f160_local1, CoD.BlackMarketUtility.MyShopResetTime) and Engine[@"isgreaterthan"](Engine[@"hash_2C778D3D40E06605"](CoD.BlackMarketUtility.MyShopResetTime, CoD.BlackMarketUtility.GetMyShopRotateTime()), f160_local0) then
		return true
	elseif not Engine[@"isgreaterthan"](f160_local0, f160_local1) then
		return true
	elseif Dvar[@"hash_34BAB578B077EAF1"]:get() and f160_arg2 and CoD.BlackMarketUtility.IsItemPurchased(f160_arg0, f160_arg2) then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.RevealMyShopItem = function(f161_arg0, f161_arg1)
	local f161_local0 = CoD.BlackMarketUtility.GetMyShopWeightedItem(f161_arg0)
	if not f161_local0 then
		return
	else
		local f161_local1 = f161_local0.pricePoint
		Engine[@"hash_45FDA5F675A65C94"](f161_arg0, f161_local0.itemId, Engine.GetCurrentUTCTimeStr(), f161_local1)
		Engine.StorageWrite(f161_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
		local f161_local2 = CoD.BlackMarketTableUtility.GetMyShopSkuAndPrice(f161_arg0, f161_local0.itemNameHash, f161_local1)
		CoD.MetricsUtility.BlackMarketItemShopEvent(f161_arg0, 4, "revealed", f161_local2.sku, f161_local0.itemNameHash, 0, 0, f161_local2.price, 0)
		f161_arg1._revealTimer = LUI.UITimer.newElementTimer(CoD.BlackMarketUtility.GetMyShopRevealDelay() * 1000, true, function()
			CoD.GridAndListUtility.UpdateDataSource(f161_arg1, true, true, true)
		end)
		f161_arg1:addElement(f161_arg1._revealTimer)
	end
end
CoD.BlackMarketUtility.GetMyShopItems = function(f163_arg0)
	local f163_local0 = CoD.BlackMarketTableUtility.GetAllMyShopItems(f163_arg0)
	if f163_local0 == nil or #f163_local0 == 0 then
		return nil
	end
	local f163_local1 = function(f164_arg0, f164_arg1, f164_arg2, f164_arg3)
		local f164_local0 = {}
		local f164_local1 = Engine[@"hash_12C2DB3D3E1B227E"](f164_arg0)
		for f164_local7, f164_local8 in ipairs(f164_arg1) do
			local f164_local9 = f164_local8.name
			if f164_local8.weight > 0 then
				local f164_local5 = CoD.BlackMarketTableUtility.GetMyShopItemId(f164_arg0, f164_local9)
				if f164_local5 then
					local f164_local6 = CoD.BlackMarketUtility.CheckMyShopExperiment(f164_arg0, {
						itemId = f164_local5,
						itemNameHash = f164_local9,
						weight = f164_local8.weight,
						pricePoint = f164_local8.pricePoint,
					})
					if f164_local6 and not CoD.BlackMarketUtility.IsItemPurchased(f164_arg0, f164_local6.itemId) and (f164_arg2 or not Engine[@"hash_4E972B5D4746712B"](f164_arg0, f164_local6.itemId)) and (f164_arg3 or f164_local1.itemId ~= f164_local6.itemId) then
						table.insert(f164_local0, f164_local6)
					end
				end
			end
		end
		return f164_local0
	end
	local f163_local2 = f163_local1(f163_arg0, f163_local0, false, false)
	if #f163_local2 == 0 then
		f163_local2 = f163_local1(f163_arg0, f163_local0, true, false)
	end
	if #f163_local2 == 0 then
		f163_local2 = f163_local1(f163_arg0, f163_local0, true, true)
	end
	return f163_local2
end
CoD.BlackMarketUtility.CanRevealMyShopItem = function(f165_arg0)
	local f165_local0 = CoD.BlackMarketUtility.GetMyShopItems(f165_arg0)
	return f165_local0 and #f165_local0 > 0
end
CoD.BlackMarketUtility.CheckMyShopExperiment = function(f166_arg0, f166_arg1)
	if CoD.BlackMarketUtility.MyShopExperiments[f166_arg1.itemNameHash] then
		local f166_local0 = CoD.StoreUtility.GetExperimentModifier(f166_arg0, CoD.BlackMarketUtility.MyShopExperiments[f166_arg1.itemNameHash].expKey)
		if f166_local0 then
			f166_arg1.itemNameHash = CoD.BlackMarketUtility.MyShopExperiments[f166_arg1.itemNameHash].itemRefs[f166_local0]
			if not f166_arg1.itemNameHash then
				return nil
			else
				f166_arg1.pricePoint = 1
				f166_arg1.itemId = CoD.BlackMarketTableUtility.GetMyShopItemId(f166_arg0, f166_arg1.itemNameHash)
				return f166_arg1
			end
		else
			return nil
		end
	else
		return f166_arg1
	end
end
CoD.BlackMarketUtility.GetMyShopWeightedItem = function(f167_arg0)
	local f167_local0 = CoD.BlackMarketUtility.GetMyShopItems(f167_arg0)
	if #f167_local0 > 0 then
		local f167_local1 = 0
		for f167_local5, f167_local6 in ipairs(f167_local0) do
			f167_local1 = f167_local1 + f167_local6.weight
			f167_local6.weight = f167_local1
		end
		if f167_local1 == 0 then
			return nil
		end
		f167_local2 = math.random(f167_local1)
		for f167_local6, f167_local7 in ipairs(f167_local0) do
			if f167_local2 <= f167_local7.weight and f167_local7 ~= nil then
				return f167_local7
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.UpdateItemShopSunsetShopCategory = function(f168_arg0)
	if f168_arg0.shopCategory == @"menu/weapon_camo" then
		f168_arg0.shopCategory = @"hash_1E2BD8FAC00570CD"
	elseif f168_arg0.shopCategory == @"hash_5F5E657D5E5ED4E7" then
		f168_arg0.shopCategory = "menu/single_weapon_charm"
	elseif f168_arg0.shopCategory == "heroes/war_paint" then
		f168_arg0.shopCategory = @"menu/single_warpaint"
	elseif f168_arg0.shopCategory == "weapon_options/reactive_camo" then
		f168_arg0.shopCategory = "menu/single_reactive_camo"
	elseif f168_arg0.shopCategory == @"hash_57B491E0F2A8C286" then
		f168_arg0.shopCategory = @"hash_282802065CF60EAA"
	end
end
CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource = function(f169_arg0, f169_arg1)
	local f169_local0 = {}
	local f169_local1, f169_local2, f169_local3, f169_local4, f169_local5 = nil
	local f169_local6 = true
	local f169_local7 = false
	local f169_local8 = Engine[@"hash_6F2CB6360236F359"](f169_arg0, f169_arg1)
	if not f169_local8 then
		f169_local4 = CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem(f169_arg0, f169_arg1)
		f169_local6 = f169_local4 ~= nil
	elseif CoD.BlackMarketUtility.IsItemShopSunsetSlotItemOld(f169_arg0, f169_local8.reveal_expiration, f169_local8.itemId) or Engine[@"hash_5352DC095BBB2A45"](f169_arg0, f169_local8.itemId) > 0 then
		f169_local4 = CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem(f169_arg0, f169_arg1)
		f169_local6 = f169_local4 ~= nil
	end
	local f169_local9 = CoD.BlackMarketUtility.BlackjackShopSlotIndex[f169_arg1]
	local f169_local10 = DataSources.ItemshopRotation.getModel(f169_arg0)
	local f169_local11 = "loot_itemshop_slot"
	f169_local10["loot_itemshop_slot" .. f169_local9 .. "_timer_active"]:set(f169_local6)
	if not f169_local6 then
		f169_local10 = CoD.BlackMarketUtility.GetEmptyInsertItem(1, false)
		if f169_local10 then
			local f169_local11, f169_local12 = CoD.BlackMarketUtility.GetItemProductAndProperties(f169_local10)
			f169_local11.revealed = true
			f169_local11.emptyItem = true
			f169_local11.isInItemShop = true
			f169_local11.percentOff = 0
			f169_local11.contractId = "0"
			table.insert(f169_local0, {
				models = f169_local11,
				properties = f169_local12,
			})
			return f169_local0
		end
	end
	if f169_local4 then
		f169_local1 = f169_local4.itemId
		f169_local3 = f169_local4.pricePoint
		f169_local7 = true
	else
		f169_local1 = f169_local8.itemId
		f169_local3 = f169_local8.price_point
	end
	if Engine[@"isdevelopmentbuild"]() then
		f169_local10 = ""
		if f169_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
			f169_local10 = "slot1"
		elseif f169_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
			f169_local10 = "slot2"
		elseif f169_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
			f169_local10 = "slot3"
		end
		if f169_local10 ~= "" then
			f169_local11 = Engine[@"getdvarstring"]("loot_sunsetShop_" .. f169_local10 .. "_fakeId")
			if f169_local11 and f169_local11 ~= "" then
				f169_local1 = f169_local11
			end
			local f169_local12 = Engine[@"getdvarstring"]("loot_sunsetShop_" .. f169_local10 .. "_fakePricePoint")
			if f169_local12 and f169_local12 ~= "" then
				f169_local3 = tonumber(f169_local12)
			end
		end
	end
	f169_local10 = f169_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]
	if f169_local10 then
		f169_local5 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f169_arg0, f169_local1, 0)
		if f169_local5 then
			f169_local11 = CoD.BlackMarketTableUtility.GetContrabandSkuAndCaseRule(f169_arg0, f169_local1)
			if f169_local11 then
				f169_local5.cpPrice = f169_local11.cpPrice
				f169_local5.cpSku = f169_local11.cpSku
				f169_local5.casePrice = f169_local11.casePrice
				f169_local5.caseRule = f169_local11.caseRule
			end
		end
		f169_local2 = f169_local5 and f169_local5.name
	else
		f169_local2 = CoD.BlackMarketTableUtility.GetDeterministicItemNameFromId(f169_arg0, f169_local1)
	end
	if f169_local2 and f169_local1 then
		f169_local11 = nil
		local f169_local12 = {}
		if f169_local10 then
			f169_local11 = "contraband"
		else
			f169_local11 = CoD.BlackMarketTableUtility.GetDeterministicItemCategory(f169_arg0, f169_local2)
			f169_local12 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f169_arg0, f169_local2, f169_local3)
		end
		if f169_local11 == "special_order" then
			local f169_local13 = CoD.ContractUtility.GetContractListModels(f169_arg0, f169_local1)
			CoD.ContractUtility.AppendPurchasableContractSlotModels(f169_arg0, f169_local13, 4)
			f169_local13.storePreview = true
			f169_local13.revealed = not f169_local7
			f169_local13.emptyItem = false
			f169_local13.isInItemShop = true
			local f169_local14 = f169_local12.cpPrice
			if not f169_local14 then
				f169_local14 = 0
			end
			f169_local13.price = f169_local14
			f169_local14 = f169_local12.cpSku
			if not f169_local14 then
				f169_local14 = "0"
			end
			f169_local13.skuID = f169_local14
			f169_local14 = f169_local12.casePrice
			if not f169_local14 then
				f169_local14 = 0
			end
			f169_local13.casePrice = f169_local14
			f169_local14 = f169_local12.caseRule
			if not f169_local14 then
				f169_local14 = "0"
			end
			f169_local13.caseRule = f169_local14
			f169_local13.slot = f169_local9
			f169_local13.toolTipText = CoD.BlackMarketUtility.BlackjackShopSlotTooltipText[f169_arg1]
			table.insert(f169_local0, {
				models = f169_local13,
				properties = {
					inPurchasableRow = true,
					contractModels = f169_local13,
				},
			})
		else
			local f169_local13 = nil
			local f169_local14 = f169_local12.cpPrice
			if not f169_local14 then
				f169_local14 = 0
			end
			local f169_local15 = f169_local12.cpSku
			if not f169_local15 then
				f169_local15 = "0"
			end
			local f169_local16 = f169_local12.casePrice
			if not f169_local16 then
				f169_local16 = 0
			end
			local f169_local17 = f169_local12.caseRule
			if not f169_local17 then
				f169_local17 = "0"
			end
			if f169_local11 == "loot_stream" then
				f169_local13 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f169_arg0, f169_local1)
			elseif f169_local11 == "contraband" then
				f169_local13 = f169_local5
				f169_local14 = f169_local13.cpPrice or f169_local14
				f169_local15 = f169_local13.cpSku or f169_local15
				f169_local16 = f169_local13.casePrice or f169_local16
				f169_local17 = f169_local13.caseRule or f169_local17
			else
				f169_local13 = CoD.BlackMarketTableUtility.GetItemShopInformation(f169_arg0, f169_local2)
			end
			if f169_local13 then
				local f169_local18 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f169_arg0, f169_local13)
				if f169_local18 then
					if f169_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
						CoD.BlackMarketUtility.UpdateItemShopSunsetShopCategory(f169_local18)
						if f169_local18.subExtraText == @"hash_1F6BC2AD33480070" then
							f169_local18.subExtraText = 0x0
						end
					end
					if CoD.BlackMarketUtility.BlackjackShopSunsetOverridePopupImageItems[f169_local2] then
						f169_local18.popupImage = f169_local18.primaryImage
					end
					local f169_local19, f169_local20 = CoD.BlackMarketUtility.GetItemProductAndProperties(f169_local18)
					f169_local19.revealed = not f169_local7
					f169_local19.emptyItem = false
					f169_local19.isInItemShop = true
					f169_local19.price = f169_local14
					f169_local19.skuID = f169_local15
					f169_local19.casePrice = f169_local16
					f169_local19.caseRule = f169_local17
					f169_local19.slot = f169_local9
					local f169_local21
					if f169_local10 then
						f169_local21 = LuaEnum.LOOT_TYPE.CONTRABAND
						if not f169_local21 then
						else
							f169_local19.lootType = f169_local21
							f169_local19.storePreview = true
							f169_local19.inventoryIcon = "blacktransparent"
							f169_local19.earnedRewardCount = 0
							f169_local19.totalRewardCount = 0
							f169_local19.toolTipText = CoD.BlackMarketUtility.BlackjackShopSlotTooltipText[f169_arg1]
							table.insert(f169_local0, {
								models = f169_local19,
								properties = f169_local20,
							})
						end
					end
					f169_local21 = LuaEnum.LOOT_TYPE.ITEMSHOP
				end
			end
		end
	end
	return f169_local0
end
CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup = function(f170_arg0, f170_arg1, f170_arg2, f170_arg3)
	if not f170_arg1.__sunsetSlotListSubscriptions then
		f170_arg1.__sunsetSlotListSubscriptions = true
		local f170_local0 = Engine.GetModelForController(f170_arg0)
		if not f170_local0.sunsetPurchasedSlot then
			f170_local0 = Engine.GetModelForController(f170_arg0)
			f170_local0 = f170_local0:create("sunsetPurchasedSlot")
			f170_local0:set(Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"])
		end
		local f170_local1 = f170_arg1
		f170_local0 = f170_arg1.subscribeToModel
		local f170_local2 = Engine.GetModelForController(f170_arg0)
		f170_local0(f170_local1, f170_local2.sunsetPurchasedSlot, function(f171_arg0)
			if f171_arg0:get() == f170_arg3 then
				f171_arg0:set(Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"])
				f170_arg1:updateDataSource()
			end
		end)
	end
end
DataSources.DeterministicSlot1List = ListHelper_SetupDataSource(
	"DeterministicSlot1List",
	function(f172_arg0, f172_arg1)
		local f172_local0 = {}
		if f172_arg1.menu and f172_arg1.menu._detItemSlot1 then
			f172_local0 = f172_arg1.menu._detItemSlot1
			f172_arg1.menu._detItemSlot1 = nil
		else
			f172_local0 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f172_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
		end
		return f172_local0
	end,
	nil,
	nil,
	function(f173_arg0, f173_arg1, f173_arg2)
		CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup(f173_arg0, f173_arg1, f173_arg2, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
	end
)
DataSources.DeterministicSlot2List = ListHelper_SetupDataSource(
	"DeterministicSlot2List",
	function(f174_arg0, f174_arg1)
		local f174_local0 = {}
		if f174_arg1.menu and f174_arg1.menu._detItemSlot2 then
			f174_local0 = f174_arg1.menu._detItemSlot2
			f174_arg1.menu._detItemSlot2 = nil
		else
			f174_local0 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f174_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
		end
		return f174_local0
	end,
	nil,
	nil,
	function(f175_arg0, f175_arg1, f175_arg2)
		CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup(f175_arg0, f175_arg1, f175_arg2, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
	end
)
DataSources.RNGSlotList = ListHelper_SetupDataSource(
	"RNGSlotList",
	function(f176_arg0, f176_arg1)
		local f176_local0 = {}
		if f176_arg1.menu and f176_arg1.menu._rngItemSlot3 then
			f176_local0 = f176_arg1.menu._rngItemSlot3
			f176_arg1.menu._rngItemSlot3 = nil
		else
			f176_local0 = CoD.BlackMarketUtility.SetupItemShopSunsetSlotDatasource(f176_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"])
		end
		return f176_local0
	end,
	nil,
	nil,
	function(f177_arg0, f177_arg1, f177_arg2)
		CoD.BlackMarketUtility.ItemShopSunsetSlotCustomSetup(f177_arg0, f177_arg1, f177_arg2, Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"])
	end
)
CoD.BlackMarketUtility.IsItemShopSunsetSlotItemOld = function(f178_arg0, f178_arg1, f178_arg2)
	if not Engine[@"isgreaterthan"](f178_arg1, tostring(Engine.GetCurrentUTCTimeStr())) then
		return true
	elseif f178_arg2 and CoD.BlackMarketUtility.IsItemPurchased(f178_arg0, f178_arg2) then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem = function(f179_arg0, f179_arg1)
	local f179_local0 = nil
	local f179_local1 = 1
	if f179_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
		f179_local0 = CoD.BlackMarketUtility.GetRNGWeightedItem(f179_arg0, f179_arg1)
	else
		f179_local0 = CoD.BlackMarketUtility.GetDeterministicWeightedItem(f179_arg0, f179_arg1)
		f179_local1 = f179_local0 and f179_local0.pricePoint
	end
	if not f179_local0 then
		return
	end
	local f179_local2 = CoD.BlackMarketUtility.BlackjackShopSlotIndex[f179_arg1]
	local f179_local3 = Engine[@"hash_63998C7C8611C743"](f179_arg0, f179_local0.itemId, Engine.GetCurrentUTCTimeStr(), Engine[@"hash_2C778D3D40E06605"](Engine.GetCurrentUTCTimeStr(), CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime(f179_arg0, f179_local2)), f179_local1, f179_arg1)
	Engine.StorageWrite(f179_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
	local f179_local4, f179_local5 = nil
	if f179_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"] then
		f179_local5 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f179_arg0, f179_local0.itemId, 0)
		f179_local4 = f179_local5 and f179_local5.cpSku
	else
		f179_local5 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f179_arg0, f179_local0.itemNameHash, f179_local1)
		f179_local4 = f179_local5 and f179_local5.cpSku
	end
	local f179_local6 = f179_local2
	local f179_local7 = 0
	local f179_local8 = Engine.CreateModel(Engine.GetGlobalModel(), "ItemshopRotation")
	if f179_local8 then
		local f179_local9 = f179_local8:create("loot_itemshop_slot" .. tostring(f179_local6) .. "_timer_raw")
		f179_local7 = f179_local9:get()
	end
	CoD.MetricsUtility.BlackMarketItemShopEvent(f179_arg0, f179_local6 + CoD.BlackMarketUtility.BlackjackShopSlotIndexSunsetOffset, "revealed", f179_local4, f179_local0.itemNameHash, 0, 0, f179_local7, tonumber(CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime(f179_arg0, f179_local2)), f179_local5.cpPrice, f179_local5.casePrice)
	return f179_local0
end
CoD.BlackMarketUtility.GetDeterministicItems = function(f180_arg0, f180_arg1)
	local f180_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f180_arg0, false)
	if f180_local0 == nil or #f180_local0 == 0 then
		return nil
	end
	local f180_local1 = {}
	local f180_local2 = {}
	local f180_local3 = CoD.BlackMarketUtility.GetItemShopSunsetSlotHistoryCount()
	local f180_local4 = function(f181_arg0)
		local f181_local0 = {}
		local f181_local1 = 0
		for f181_local5, f181_local6 in ipairs(f181_arg0) do
			if not f181_local0[f181_local6.name] then
				f181_local0[f181_local6.name] = true
				f181_local1 = f181_local1 + 1
			end
		end
		return f181_local1
	end
	local f180_local5 = function(f182_arg0, f182_arg1, f182_arg2, f182_arg3)
		local f182_local0 = {}
		local f182_local1 = Engine[@"hash_6F2CB6360236F359"](f182_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
		local f182_local2 = Engine[@"hash_6F2CB6360236F359"](f182_arg0, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
		local f182_local3 = -1
		if f182_arg3 then
			f182_local3 = f180_local4(f182_arg1)
		end
		for f182_local10, f182_local11 in ipairs(f182_arg1) do
			local f182_local12 = f182_local11.name
			if f182_local11.weight1 > 0 or f182_local11.weight2 > 0 then
				local f182_local7 = CoD.BlackMarketTableUtility.GetDeterministicItemId(f182_arg0, f182_local12)
				if f182_local7 then
					local f182_local8 = {
						itemId = f182_local7,
						itemNameHash = f182_local12,
						weight1 = f182_local11.weight1,
						weight2 = f182_local11.weight2,
						pricePoint = f182_local11.pricePoint,
					}
					if not CoD.BlackMarketUtility.IsItemPurchased(f182_arg0, f182_local8.itemId) then
						local f182_local9 = true
						if f182_arg2 then
							if not f182_arg3 then
								f182_local9 = not Engine[@"hash_2853265290D721E1"](f182_arg0, f182_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"], f180_local3)
								if f182_local9 then
									f182_local9 = not Engine[@"hash_2853265290D721E1"](f182_arg0, f182_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"], f180_local3)
								end
								if not f182_local9 then
									table.insert(f180_local2, f182_local11)
								end
							end
						else
							f182_local9 = not Engine[@"hash_6C4B83E18D078C98"](f182_arg0, f182_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"])
							if f182_local9 then
								f182_local9 = not Engine[@"hash_6C4B83E18D078C98"](f182_arg0, f182_local8.itemId, Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"])
							end
							if not f182_local9 then
								table.insert(f180_local1, f182_local11)
							end
						end
						if f182_local9 then
							if f182_arg3 and f182_local3 <= 2 then
								if f180_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
									f182_local9 = f182_local8.itemId ~= f182_local2.itemId
								elseif f180_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
									f182_local9 = f182_local8.itemId ~= f182_local1.itemId
								end
							elseif f182_local8.itemId == f182_local1.itemId or f182_local8.itemId == f182_local2.itemId then
								f182_local9 = false
							else
								f182_local9 = true
							end
						end
						if f182_local9 then
							table.insert(f182_local0, f182_local8)
						end
					end
				end
			end
		end
		return f182_local0
	end
	local f180_local6 = f180_local5(f180_arg0, f180_local0, false, false)
	if #f180_local6 == 0 then
		f180_local6 = f180_local5(f180_arg0, f180_local1, true, false)
	end
	if #f180_local6 == 0 then
		f180_local6 = f180_local5(f180_arg0, f180_local2, true, true)
	end
	return f180_local6
end
CoD.BlackMarketUtility.GetRNGItems = function(f183_arg0, f183_arg1)
	local f183_local0 = CoD.BlackMarketTableUtility.GetAllContrabandItem(f183_arg0, false)
	if f183_local0 == nil or #f183_local0 == 0 then
		return nil
	end
	local f183_local1 = {}
	local f183_local2 = {}
	local f183_local3 = CoD.BlackMarketUtility.GetItemShopSunsetSlotHistoryCount()
	local f183_local4 = function(f184_arg0)
		local f184_local0 = {}
		local f184_local1 = 0
		for f184_local5, f184_local6 in ipairs(f184_arg0) do
			if not f184_local0[f184_local6.name] then
				f184_local0[f184_local6.name] = true
				f184_local1 = f184_local1 + 1
			end
		end
		return f184_local1
	end
	local f183_local5 = function(f185_arg0, f185_arg1, f185_arg2, f185_arg3)
		local f185_local0 = {}
		local f185_local1 = Engine[@"hash_6F2CB6360236F359"](f185_arg0, f183_arg1)
		local f185_local2 = -1
		if f185_arg3 then
			f185_local2 = f183_local4(f185_arg1)
		end
		for f185_local8, f185_local9 in ipairs(f185_arg1) do
			if f185_local9.weight > 0 and f185_local9.itemId then
				local f185_local6 = {
					itemId = f185_local9.itemId,
					itemNameHash = f185_local9.name,
					weight = f185_local9.weight,
				}
				if not CoD.BlackMarketUtility.IsItemPurchased(f185_arg0, f185_local6.itemId) then
					local f185_local7 = true
					if f185_arg2 then
						if not f185_arg3 then
							f185_local7 = not Engine[@"hash_2853265290D721E1"](f185_arg0, f185_local6.itemId, f183_arg1, f183_local3)
							if not f185_local7 then
								table.insert(f183_local2, f185_local9)
							end
						end
					else
						f185_local7 = not Engine[@"hash_6C4B83E18D078C98"](f185_arg0, f185_local6.itemId, f183_arg1)
						if not f185_local7 then
							table.insert(f183_local1, f185_local9)
						end
					end
					if f185_local7 and f185_arg3 and f185_local2 > 1 then
						f185_local7 = f185_local6.itemId ~= f185_local1.itemId
					end
					if f185_local7 then
						table.insert(f185_local0, f185_local6)
					end
				end
			end
		end
		return f185_local0
	end
	local f183_local6 = f183_local5(f183_arg0, f183_local0, false, false)
	if #f183_local6 == 0 then
		f183_local6 = f183_local5(f183_arg0, f183_local1, true, false)
	end
	if #f183_local6 == 0 then
		f183_local6 = f183_local5(f183_arg0, f183_local2, true, true)
	end
	return f183_local6
end
CoD.BlackMarketUtility.CanRevealDeterministicItem = function(f186_arg0, f186_arg1)
	local f186_local0 = CoD.BlackMarketUtility.GetDeterministicItems(f186_arg0, f186_arg1)
	return f186_local0 and #f186_local0 > 0
end
CoD.BlackMarketUtility.GetDeterministicWeightedItem = function(f187_arg0, f187_arg1)
	local f187_local0 = CoD.BlackMarketUtility.GetDeterministicItems(f187_arg0, f187_arg1)
	if #f187_local0 > 0 then
		local f187_local1 = 0
		for f187_local5, f187_local6 in ipairs(f187_local0) do
			if f187_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
				f187_local6.weight1 = f187_local1 + f187_local6.weight1
			end
			if f187_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
				f187_local6.weight2 = f187_local1 + f187_local6.weight2
			end
		end
		if f187_local1 == 0 then
			return nil
		end
		f187_local2 = math.random(f187_local1)
		for f187_local6, f187_local8 in ipairs(f187_local0) do
			local f187_local7 = 0
			if f187_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3C21A82386CF"] then
				f187_local7 = f187_local8.weight1
			elseif f187_arg1 == Enum[@"hash_1CF7389DF8F39785"][@"hash_3E2E3D21A8238882"] then
				f187_local7 = f187_local8.weight2
			end
			if f187_local2 <= f187_local7 and f187_local8 ~= nil then
				return f187_local8
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetRNGWeightedItem = function(f188_arg0, f188_arg1)
	local f188_local0 = CoD.BlackMarketUtility.GetRNGItems(f188_arg0, f188_arg1)
	if #f188_local0 > 0 then
		local f188_local1 = 0
		for f188_local5, f188_local6 in ipairs(f188_local0) do
			f188_local1 = f188_local1 + f188_local6.weight
			f188_local6.weight = f188_local1
		end
		if f188_local1 == 0 then
			return nil
		end
		f188_local2 = math.random(f188_local1)
		for f188_local6, f188_local7 in ipairs(f188_local0) do
			if f188_local2 <= f188_local7.weight and f188_local7 ~= nil then
				return f188_local7
			end
		end
	end
	return nil
end
DataSources.WeaponBribeList = ListHelper_SetupDataSource(
	"WeaponBribeList",
	function(f189_arg0)
		local f189_local0 = {}
		for f189_local7, f189_local8 in ipairs(CoD.BlackMarketTableUtility.GetWeaponBribeSelectionBribes(f189_arg0)) do
			local f189_local9 = Engine[@"hash_2E00B2F29271C60B"](f189_local8.assetName)
			if f189_local9 then
				local f189_local4 = {
					itemId = f189_local8.keyItem,
					name = CoDLootShared.GetItemNameHashFromLootId(f189_local8.keyItem),
					rarity = "ultra",
					category = CoDLootShared.GetLootItemCategory(f189_local8.keyItem),
					lootType = CoDLootShared.GetLootItemLootType(f189_local8.keyItem),
				}
				local f189_local5, f189_local6 = CoD.BlackMarketUtility.GetItemProductAndProperties(CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f189_arg0, f189_local4))
				if f189_local4.category == "mastercraft" then
					f189_local5.name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_341954FC612B5845", f189_local9[@"nametext"])
				else
					f189_local5.name = Engine[@"hash_4F9F1239CFD921FE"](f189_local9[@"nametext"])
				end
				f189_local5.desc = f189_local9[@"desctext"] and Engine[@"hash_4F9F1239CFD921FE"](f189_local9[@"desctext"]) or ""
				if f189_local9.popupdescoverride and f189_local9[@"hash_7B2BB983050B1101"] and f189_local9[@"hash_565D6CA191CE39A9"] then
					f189_local5.popupDesc = Engine[@"hash_4F9F1239CFD921FE"](f189_local9.popupdescoverride, f189_local9[@"hash_7B2BB983050B1101"], f189_local9[@"hash_565D6CA191CE39A9"])
				elseif f189_local9.popupdescoverride and f189_local9[@"hash_7B2BB983050B1101"] then
					f189_local5.popupDesc = Engine[@"hash_4F9F1239CFD921FE"](f189_local9.popupdescoverride, f189_local9[@"hash_7B2BB983050B1101"])
				elseif f189_local9.popupdescoverride then
					f189_local5.popupDesc = Engine[@"hash_4F9F1239CFD921FE"](f189_local9.popupdescoverride)
				else
					f189_local5.popupDesc = f189_local5.desc
				end
				f189_local5.categoryText = f189_local9[@"categorytext"]
				f189_local5.image = f189_local9.weapontileimage or "blacktransparent"
				f189_local5.popupImage = f189_local9[@"popupimage"] or "blacktransparent"
				f189_local5.price = f189_local8.price
				f189_local5.casePrice = f189_local8.optionalCost
				f189_local5.lootRule = f189_local8.lootRule
				f189_local5.lootType = LuaEnum.LOOT_TYPE.ITEMSHOP
				f189_local5.allowTogglePreview = false
				f189_local5.isWeaponBribeSelect = true
				f189_local5.bribeStringName = f189_local8.stringName
				f189_local5.slot = 4
				f189_local6.sortIndex = f189_local8.sortIndex or 0
				table.insert(f189_local0, {
					models = f189_local5,
					properties = f189_local6,
				})
			end
		end
		table.sort(f189_local0, function(f190_arg0, f190_arg1)
			return f190_arg0.properties.sortIndex < f190_arg1.properties.sortIndex
		end)
		return f189_local0
	end,
	nil,
	nil,
	function(f191_arg0, f191_arg1, f191_arg2)
		if not f191_arg1.__weaponBribeListSubscriptions then
			f191_arg1.__weaponBribeListSubscriptions = true
			f191_arg1._prevIsHalfOffWeaponBribeActive = CoD.BlackMarketUtility.IsHalfOffPickWeaponBribeActive()
			f191_arg1._prevIsFreeWeaponBribeAvailable = CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f191_arg0)
			f191_arg1:subscribeToGlobalModel(f191_arg0, "AutoEvents", "cycled", function()
				local f192_local0 = CoD.BlackMarketUtility.IsHalfOffPickWeaponBribeActive()
				local f192_local1 = CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f191_arg0)
				if f192_local0 ~= f191_arg1._prevIsHalfOffWeaponBribeActive or f192_local1 ~= f191_arg1._prevIsFreeWeaponBribeAvailable then
					f191_arg1._prevIsHalfOffWeaponBribeActive = f192_local0
					f191_arg1._prevIsFreeWeaponBribeAvailable = f192_local1
					f191_arg1:updateDataSource()
				end
			end)
		end
	end
)
CoD.BlackMarketUtility.WeaponBribeSelectionAvailable = function(f193_arg0)
	return CoD.BlackMarketUtility.IsUnlimitedBribeOfferActive() or Engine.GetSecondsRemainingServer(Engine[@"hash_6D80580D17461096"](f193_arg0, CoD.BlackMarketUtility.BribeMenuLootRule)) <= 0
end
CoD.BlackMarketUtility.CheckForBribePopupDescOverride = function(f194_arg0, f194_arg1)
	local f194_local0 = f194_arg0.popupDesc
	if f194_local0 then
		f194_local0 = f194_arg0.popupDesc:get()
	end
	if f194_local0 and f194_local0 ~= "" and f194_local0 ~= 0x0 then
		return f194_local0
	else
		return f194_arg1
	end
end
DataSources.ItemHistoryCategoryList = ListHelper_SetupDataSource("ItemHistoryCategoryList", function(f195_arg0)
	local f195_local0 = {}
	table.insert(f195_local0, {
		models = {
			category = "specialOrders",
			categoryNameRefXhash = @"menu/contracts",
			imageName = "",
		},
	})
	table.insert(f195_local0, {
		models = {
			category = "reserveHistory",
			categoryNameRefXhash = @"hash_41F507DCE83A87CF",
			imageName = "",
		},
	})
	return f195_local0
end)
DataSources.ItemHistoryList = ListHelper_SetupDataSource("ItemHistoryList", function(f196_arg0, f196_arg1)
	local f196_local0 = {}
	local f196_local1 = "specialOrders"
	local f196_local2 = f196_arg1.menu
	if f196_local2 then
		f196_local1 = f196_local2.category or f196_local1
	end
	local f196_local3 = {}
	if f196_local1 ~= "specialOrders" then
		local f196_local4 = CoD.BlackMarketUtility.FillContrabandDropNumber()
		if f196_local4 ~= 0 then
			local f196_local5 = Engine.GetTableRowCount(CoD.BlackMarketUtility.lootTableName)
			local f196_local6 = 0
			local f196_local7 = 9
			for f196_local8 = 0, f196_local5 - 1, 1 do
				local f196_local11 = tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f196_local8, f196_local7))
				if f196_local11 ~= nil and f196_local11 == f196_local4 then
					table.insert(f196_local3, {
						id = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketUtility.lootTableName, f196_local8, f196_local6),
						modTime = "0",
					})
				end
			end
		else
			f196_local3 = Engine[@"hash_5139E55459401D30"](f196_arg0, CoD.BlackMarketUtility.ItemHistoryCount, 0, CoD.BlackMarketUtility[@"hash_491EF6C1326C6875"], CoD.BlackMarketUtility[@"hash_2BF3E69D05D1B50"], Enum[@"inventorysourcetype"][@"hash_5FB737E1D309F2D5"], CoD.BlackMarketUtility[0xE904580D0E4807], CoD.BlackMarketUtility[@"hash_1D620DA7785ED682"], Enum[@"inventorysourcetype"][@"hash_5FB737E1D309F2D5"])
		end
		for f196_local8, f196_local9 in ipairs(f196_local3) do
			local f196_local10 = 0x0
			local f196_local12 = nil
			f196_local10 = CoD.BlackMarketTableUtility.GetItemShopEntryName(f196_arg0, f196_local9.id)
			if f196_local10 ~= nil and f196_local10 ~= 0x0 then
				local f196_local11 = CoD.BlackMarketTableUtility.GetItemShopInformation(f196_arg0, f196_local10)
				if f196_local11 then
					f196_local12 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f196_arg0, f196_local11)
				end
			else
				local f196_local11 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f196_arg0, f196_local9.id)
				if f196_local11 then
					if Engine[@"isgreaterthan"](CoDShared.Loot.LastSeasonStartTime, f196_local9.modTime) or f196_local11.seasonId == CoD.BlackMarketTableUtility.GetSeasonId(CoDShared.Loot.GetCurrentSeason()) then
						f196_local12 = nil
					else
						f196_local12 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f196_arg0, f196_local11)
						if f196_local12.lootType ~= LuaEnum.LOOT_TYPE.ITEMSHOP then
							f196_local12.lootType = LuaEnum.LOOT_TYPE.CONTRABAND
						end
					end
				end
				if not f196_local12 then
					local f196_local13 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f196_arg0, f196_local9.id, 0)
					if f196_local13 and f196_local13.itemId then
						f196_local12 = CoD.BlackMarketUtility.GetItemRefs(f196_arg0, f196_local13.name, f196_local13.category, f196_local13.rarity, f196_local13.inSet, 0, f196_local13.lootType, f196_local13.refOptic, f196_local13.itemId)
					end
				end
			end
			if f196_local12 then
				local f196_local11, f196_local13 = CoD.BlackMarketUtility.GetItemProductAndProperties(f196_local12)
				if f196_local9.modTime then
					f196_local11.timeStamp = f196_local9.modTime
				else
					f196_local11.timeStamp = 0
				end
				if f196_local12.itemName ~= "triple_play_dec2018" and f196_local12.itemName ~= "triple_play_feb2019" and f196_local12.itemName ~= "starter_pack_season_3" and f196_local12.itemName ~= "ar_galil_t8" then
					table.insert(f196_local0, {
						models = f196_local11,
						properties = f196_local13,
					})
				end
			end
		end
	else
		f196_local0 = CoD.ContractUtility.GetPurchasedContractsModels(f196_arg0, true, true)
	end
	return f196_local0
end)
DataSources.ItemShopConfirmButtonList = ListHelper_SetupDataSource("ItemShopConfirmButtonList", function(f197_arg0)
	local f197_local0 = {}
	local f197_local1 = FileshareIsLocalCategory(f197_arg0)
	table.insert(f197_local0, {
		displayText = @"menu/purchase",
		displayDesc = "menu/clip_publish_desc",
		action = SetWorkingStateAndPurchaseDWSKU,
		params = {
			controller = f197_arg0,
		},
	})
	local f197_local2 = {}
	for f197_local6, f197_local7 in ipairs(f197_local0) do
		table.insert(f197_local2, {
			models = {
				displayText = Engine.Localize(f197_local7.displayText),
			},
			properties = {
				action = f197_local7.action,
				actionParam = f197_local7.params,
			},
		})
	end
	return f197_local2
end)
DataSources.SupplyChainStreams = ListHelper_SetupDataSource(
	"SupplyChainStreams",
	function(f198_arg0)
		local f198_local0 = {}
		local f198_local1 = Engine.GetModelForController(f198_arg0)
		f198_local1:create("LootStreamProgress.playAnimation")
		local f198_local2 = {}
		CoD.perController[f198_arg0].upsellContractRowIndex = 0
		local f198_local3 = CoDShared.Loot.GetCurrentSeason()
		local f198_local4 = @"menu/supply_chain"
		local f198_local5 = Engine[@"hash_2E00B2F29271C60B"](f198_local3)
		if not f198_local5 then
			return {}
		end
		local f198_local6 = false
		local f198_local7 = f198_local5.streamdisplaytitle or f198_local5[@"contracttitle"]
		local f198_local8 = f198_local5[@"hash_474C547BF0F2C029"] or 0x0
		if CoD.BlackMarketUtility.GetCurrentSeasonTier(f198_arg0) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
			f198_local3 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
			f198_local6 = CoD.SafeGetModelValue(Engine.GetModelForController(f198_arg0), "LootStreamProgress.allRngUnlocked") == true
			if f198_local6 then
				f198_local3 = CoD.BlackMarketUtility.GetCurrentPostSeasonAllRNGRef()
			end
			f198_local5 = Engine[@"hash_2E00B2F29271C60B"](f198_local3)
			f198_local4 = @"hash_528A006212176E51"
			f198_local7 = 0x0
			f198_local8 = 0x0
		end
		table.insert(f198_local2, {
			featureTitle = f198_local4,
			streamName = f198_local7,
			streamSubtitle = f198_local8,
			streamImage = f198_local5[@"contracticon"],
			price = 0,
			active = true,
			rarity = Enum.LootRarityType[@"loot_rarity_type_count"],
			timeRemaining = 0,
			category = 0x0,
			isUpsell = false,
			isSpecialEvent = false,
			isContract = false,
			isContractComplete = f198_local6,
			character = 0x0,
			weaponRef = 0x0,
			properties = nil,
			seasonal = false,
		})
		local f198_local9 = CoDShared.Loot.GetCurrentEventContract()
		if f198_local9 ~= 0x0 then
			local f198_local10 = CoDShared.Loot.GetContractInfo(f198_arg0, f198_local9)
			if f198_local10 ~= nil then
				local f198_local11 = CoD.ContractUtility.GetContractListModels(f198_arg0, f198_local10.id)
				table.insert(f198_local2, {
					featureTitle = @"hash_6F385CAA9605AD8C",
					streamName = f198_local11.name,
					streamSubtitle = 0x0,
					streamImage = f198_local11.icon,
					price = 0,
					active = true,
					rarity = Enum.LootRarityType[@"loot_rarity_type_count"],
					timeRemaining = 0,
					isUpsell = false,
					totalRewardCount = CoD.BlackMarketTableUtility.GetContractTierCount(f198_local10.id),
					earnedRewardCount = CoD.BlackMarketUtility.GetContractProgress(f198_arg0, f198_local10.name),
					rewardFractionString = f198_local11.rewardFractionString,
					category = 0x0,
					isSpecialEvent = true,
					isContract = false,
					isContractComplete = f198_local11.purchased,
					character = 0x0,
					weaponRef = 0x0,
					seasonal = false,
				})
			end
		end
		local f198_local10 = nil
		local f198_local11 = 3
		local f198_local12 = false
		if CoD.BlackMarketUtility.AreContractsEnabled() then
			for f198_local16, f198_local17 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
				if not CoD.ContractUtility.IsContractPurchased(f198_arg0, f198_local17) then
					f198_local10 = f198_local17
					break
				end
			end
			f198_local13 = CoD.BlackMarketUtility.GetActiveContracts(f198_arg0)
			for f198_local14 = 1, #f198_local13, 1 do
				local f198_local18 = f198_local13[f198_local14]
				f198_local18.id = tostring(f198_local18.id)
				if f198_local18 ~= nil and f198_local18.id ~= "0" then
					local f198_local19 = CoD.ContractUtility.GetContractListModels(f198_arg0, f198_local18.id)
					if not f198_local19.complete or f198_local19.complete and CoD.perController[f198_arg0].haveActiveContractInStream then
						table.insert(f198_local2, {
							featureTitle = 0x0,
							streamName = f198_local19.name,
							streamSubtitle = 0x0,
							streamImage = f198_local19.icon,
							price = f198_local19.price,
							active = true,
							rarity = f198_local19.rarity,
							timeRemaining = 0,
							isUpsell = false,
							isSpecialEvent = false,
							isContract = true,
							isContractComplete = f198_local19.complete,
							totalRewardCount = f198_local19.totalRewardCount,
							earnedRewardCount = f198_local19.earnedRewardCount,
							rewardFractionString = f198_local19.rewardFractionString,
							category = f198_local19.category,
							character = f198_local19.character,
							weaponRef = f198_local19.weaponRef,
							seasonal = f198_local19.seasonal,
							contractModels = f198_local19,
						})
						CoD.perController[f198_arg0].haveActiveContractInStream = true
						f198_local12 = true
						break
					end
				end
			end
			if f198_local10 and not f198_local12 then
				f198_local14 = CoD.ContractUtility.GetContractListModels(f198_arg0, f198_local10)
				if not f198_local14.purchased then
					CoD.ContractUtility.AppendPurchasableContractSlotModels(f198_arg0, f198_local14, f198_local11)
					f198_local14.movieName = nil
					table.insert(f198_local2, {
						featureTitle = 0x0,
						streamName = f198_local14.name,
						streamSubtitle = 0x0,
						streamImage = f198_local14.icon,
						price = f198_local14.price,
						active = false,
						rarity = f198_local14.rarity,
						category = f198_local14.category,
						timeRemaining = 0,
						contractTimerModel = f198_local14.timerModel,
						isUpsell = true,
						totalRewardCount = 0,
						earnedRewardCount = 0,
						rewardFractionString = "",
						isContract = true,
						isContractComplete = false,
						isSpecialEvent = false,
						character = f198_local14.character,
						weaponRef = f198_local14.weaponRef,
						baseWeaponInfo = f198_local14.baseWeaponInfo,
						cameraType = f198_local14.cameraType,
						seasonal = f198_local14.seasonal,
						contractModels = f198_local14,
						baseWeaponInfo = f198_local14.baseWeaponInfo,
						cameraType = f198_local14.cameraType,
					})
					CoD.perController[f198_arg0].upsellContractRowIndex = #f198_local2
				end
			elseif not f198_local12 then
				f198_local14 = Engine[@"hash_2E00B2F29271C60B"]("loot_contract_completed")
				if f198_local14 then
					f198_local15 = false
					f198_local16 = f198_local14.streamdisplaytitle or f198_local14[@"contracttitle"]
					table.insert(f198_local2, {
						featureTitle = 0x0,
						streamName = 0x0,
						streamSubtitle = 0x0,
						streamImage = f198_local14[@"contracticon"],
						price = 0,
						active = true,
						rarity = Enum.LootRarityType[@"loot_rarity_type_count"],
						timeRemaining = 0,
						category = 0x0,
						contractTimerModel = CoD.ContractUtility.GetSoonestContractTimer(f198_arg0),
						isUpsell = true,
						isSpecialEvent = true,
						isContract = true,
						isContractComplete = f198_local15,
						character = 0x0,
						weaponRef = 0x0,
						seasonal = false,
						properties = nil,
					})
				end
			end
		end
		if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_5DC2632EE88877F2"]:exists() then
			local f198_local20 = tonumber(Dvar[@"hash_5DC2632EE88877F2"]:get())
			for f198_local13 = 1, f198_local20, 1 do
				local f198_local16 = f198_local13
				table.insert(f198_local2, {
					featureTitle = 0x0,
					streamName = 0x0,
					streamSubtitle = 0x0,
					streamImage = "blacktransparent",
					price = 600,
					active = false,
					rarity = Enum.LootRarityType[@"loot_rarity_type_count"],
					category = "mpui/special_order",
					timeRemaining = 0,
					isUpsell = true,
					isSpecialEvent = false,
					isContract = false,
					isContractComplete = false,
					character = 0x0,
					weaponRef = 0x0,
					seasonal = false,
				})
			end
		end
		for f198_local20 = 1, #f198_local2, 1 do
			local f198_local16 = f198_local2[f198_local20]
			table.insert(f198_local0, {
				models = {
					featureTitle = f198_local16.featureTitle,
					streamName = f198_local16.streamName,
					streamSubtitle = f198_local16.streamSubtitle,
					streamImage = f198_local16.streamImage,
					price = f198_local16.price,
					active = f198_local16.active,
					rarity = f198_local16.rarity,
					timeRemaining = f198_local16.timeRemaining,
					contractTimerModel = f198_local16.contractTimerModel,
					isUpsell = f198_local16.isUpsell,
					isSpecialEvent = f198_local16.isSpecialEvent,
					isContract = f198_local16.isContract,
					isContractComplete = f198_local16.isContractComplete,
					totalRewardCount = f198_local16.totalRewardCount,
					earnedRewardCount = f198_local16.earnedRewardCount,
					rewardFractionString = f198_local16.rewardFractionString,
					category = f198_local16.category,
					contractModels = f198_local16.contractModels,
					character = f198_local16.character,
					weaponRef = f198_local16.weaponRef,
					seasonal = f198_local16.seasonal,
					baseWeaponInfo = f198_local16.baseWeaponInfo,
					cameraType = f198_local16.cameraType,
				},
				properties = {
					contractModels = f198_local16.contractModels,
				},
			})
		end
		return f198_local0
	end,
	nil,
	nil,
	function(f199_arg0, f199_arg1, f199_arg2)
		if not f199_arg1.__supplyChainStreamsSubscriptions then
			f199_arg1.__supplyChainStreamsSubscriptions = true
			local f199_local0 = f199_arg1
			local f199_local1 = f199_arg1.subscribeToModel
			local f199_local2 = Engine.GetGlobalModel()
			f199_local1(f199_local0, f199_local2:create("ContractsForceUpdate"), function()
				f199_arg1:updateDataSource()
			end, false)
			f199_arg1.originalSeason = CoDShared.Loot.GetCurrentSeason()
			f199_arg1:subscribeToGlobalModel(f199_arg0, "AutoEvents", "cycled", function()
				if f199_arg1.originalSeason ~= CoDShared.Loot.GetCurrentSeason() then
					f199_arg1.originalSeason = CoDShared.Loot.GetCurrentSeason()
					SetFocusedTierModelValue(f199_arg0, "0", "")
				end
				f199_arg1:updateDataSource()
			end)
		end
	end
)
DataSources.LootTierItems = ListHelper_SetupDataSource(
	"LootTierItems",
	function(f202_arg0, f202_arg1)
		local f202_local0 = {}
		local f202_local1 = Engine.GetModelForController(f202_arg0)
		f202_local1 = f202_local1.FocusedTier
		if f202_local1 then
			local f202_local2 = f202_local1:get() or 0
			local f202_local3 = f202_local2 + 4
			local f202_local4 = {}
			local f202_local5 = CoD.SafeGetModelValue(Engine.GetModelForController(f202_arg0), "LootStreamProgress.playAnimation")
			local f202_local6 = f202_arg1.menu
			if f202_local5 == true and f202_local6 and f202_local6.purchaseTiers then
				f202_local4 = f202_local6.purchaseTiers
			end
			local f202_local7 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f202_arg0)
			for f202_local8 = f202_local2, f202_local3, 1 do
				local f202_local11 = false
				if f202_local8 <= f202_local7 then
					f202_local11 = true
				end
				local f202_local12 = false
				if f202_local4 then
					for f202_local16, f202_local17 in pairs(f202_local4) do
						if f202_local17 == f202_local8 then
							f202_local12 = true
						end
					end
				end
				table.insert(f202_local0, {
					models = {
						tier = f202_local8,
						unlocked = f202_local11,
						toPurchase = false,
						recentlyUnlocked = f202_local12,
						selected = false,
						bottomRow = true,
					},
					properties = {
						customWidgetOverride = CoD.StreamLevel,
					},
				})
			end
			local f202_local8 = CoD.BlackMarketUtility.GetTierItemsForStream(f202_arg0, f202_local2, f202_local3, true, false)
			for f202_local9 = 1, #f202_local8, 1 do
				local f202_local12, f202_local13 = CoD.BlackMarketUtility.GetItemProductAndProperties(f202_local8[f202_local9])
				f202_local12.toPurchase = false
				f202_local12.selected = false
				f202_local12.bottomRow = false
				if #f202_local8 - 5 <= f202_local9 then
					f202_local12.bottomRow = true
				end
				local f202_local14 = false
				if f202_local4 then
					for f202_local19, f202_local20 in pairs(f202_local4) do
						if f202_local20 == f202_local12.tier then
							f202_local14 = true
						end
					end
				end
				if f202_local12.name ~= 0x0 then
					f202_local12.recentlyUnlocked = f202_local14
				else
					f202_local12.recentlyUnlocked = false
				end
				f202_local12.playAnim = false
				if f202_local12.movieName and f202_local12.movieName ~= "" then
					f202_local12.isLooping = true
					f202_local12.isStreamed = false
				end
				if Engine[@"isdevelopmentbuild"]() then
					if IsBooleanDvarSet(@"hash_6B068C6B9B7D7131") and f202_local9 % 5 == 4 then
						f202_local12.dupe = true
					end
					if IsBooleanDvarSet(@"hash_688D793408D6856B") and f202_local9 % 5 == 0 then
						f202_local12.reroll = true
					end
				end
				table.insert(f202_local0, {
					models = f202_local12,
					properties = f202_local13,
				})
			end
		end
		return f202_local0
	end,
	nil,
	nil,
	function(f203_arg0, f203_arg1, f203_arg2)
		if f203_arg1.updateSubscription then
			f203_arg1:removeSubscription(f203_arg1.updateSubscription)
		end
		local f203_local0 = Engine.GetGlobalModel()
		f203_arg1.updateSubscription = f203_arg1:subscribeToModel(f203_local0:create("AutoEvents.cycled"), function()
			f203_arg1:updateDataSource()
		end, false)
	end
)
DataSources.LootTierLighthouseItems = ListHelper_SetupDataSource(
	"LootTierLighthouseItems",
	function(f205_arg0, f205_arg1)
		local f205_local0 = 4
		local f205_local1 = {}
		local f205_local2 = Engine.GetModelForController(f205_arg0)
		f205_local2 = f205_local2.FocusedTier
		if f205_local2 then
			local f205_local3 = f205_local2:get() or 0
			local f205_local4 = f205_local3 + 24
			local f205_local5 = {}
			local f205_local6 = CoDShared.Loot.GetCurrentSeason()
			if f205_local6 and f205_local6 ~= 0x0 then
				local f205_local7 = CoDShared.Loot.GetSeasonInfo(f205_local6)
				table.insert(f205_local5, f205_local7.id)
			end
			local f205_local7 = CoDShared.Loot.GetCurrentEventContract()
			if f205_local7 and f205_local7 ~= 0x0 then
				local f205_local8 = CoDShared.Loot.GetContractInfo(f205_arg0, f205_local7)
				table.insert(f205_local5, f205_local8.id)
			end
			for f205_local12, f205_local13 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f205_arg0)) do
				if f205_local13.id > 0 then
					table.insert(f205_local5, f205_local13.id)
				end
			end
			for f205_local9 = f205_local3, f205_local4, 1 do
				f205_local13 = {}
				for f205_local18, f205_local19 in ipairs(f205_local5) do
					local f205_local20 = CoD.BlackMarketTableUtility.GetStreamItemsByTier(f205_arg0, f205_local19, f205_local9)
					local f205_local17 = f205_local20[1]
					if f205_local17 then
						f205_local17 = CoD.BlackMarketUtility.LootIdRarities[f205_local20[1].rarity]
					end
					if f205_local17 and f205_local17 ~= Enum.LootRarityType[@"loot_rarity_type_count"] and f205_local17 >= Enum.LootRarityType[@"loot_rarity_type_legendary"] then
						table.insert(f205_local13, f205_local17)
					end
				end
				table.insert(f205_local1, f205_local13)
			end
		end
		local f205_local3 = {}
		for f205_local7, f205_local8 in ipairs(f205_local1) do
			local f205_local9 = {}
			local f205_local10 = f205_local0 - #f205_local8
			for f205_local11 = 1, f205_local10, 1 do
				f205_local9["tierLighthousePip" .. f205_local11 .. ".rarity"] = Enum.LootRarityType[@"loot_rarity_type_count"]
			end
			for f205_local14, f205_local15 in ipairs(f205_local8) do
				f205_local9["tierLighthousePip" .. f205_local14 + f205_local10 .. ".rarity"] = f205_local15
			end
			table.insert(f205_local3, {
				models = f205_local9,
			})
		end
		return f205_local3
	end,
	nil,
	nil,
	function(f206_arg0, f206_arg1, f206_arg2)
		if f206_arg1.updateSubscription then
			f206_arg1:removeSubscription(f206_arg1.updateSubscription)
		end
		local f206_local0 = Engine.GetGlobalModel()
		f206_arg1.updateSubscription = f206_arg1:subscribeToModel(f206_local0:create("AutoEvents.cycled"), function()
			f206_arg1:updateDataSource()
		end, false)
	end
)
DataSources.TierPurchase = ListHelper_SetupDataSource("TierPurchase", function(f208_arg0)
	local f208_local0 = CoD.SafeGetModelValue(Engine.GetGlobalModel(), "ItemShop.HighlightedTier")
	local f208_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f208_arg0)
	if f208_local1 + 1 < f208_local0 then
		local f208_local2 = f208_local0 - f208_local1
	end
	local f208_local2 = {}
	for f208_local6, f208_local7 in ipairs(options) do
		table.insert(f208_local2, {
			models = {
				displayText = Engine.Localize(f208_local7.displayText),
				tiersToBuy = f208_local7.tiersToBuy,
				price = f208_local7.price,
			},
			properties = {
				action = f208_local7.action,
				actionParam = f208_local7.params,
			},
		})
	end
	return f208_local2
end)
DataSourceHelpers.PerControllerDataSourceSetup("TierPurchase", "TierPurchase", function(f209_arg0, f209_arg1)
	local f209_local0 = CoD.SafeGetModelValue(Engine.GetGlobalModel(), "ItemShop.HighlightedTier")
	local f209_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f209_arg1)
	local f209_local2 = 1
	if f209_local0 == nil then
		f209_local0 = f209_local1 + 1
	end
	if f209_local1 + 1 < f209_local0 then
		f209_local2 = f209_local0 - f209_local1
	end
	local f209_local3 = f209_arg0:create("NextTier")
	f209_local3:set(f209_local1 + 1)
	f209_local3 = f209_arg0:create("LastTier")
	f209_local3:set(f209_local0)
	f209_local3 = f209_arg0:create("Price")
	f209_local3:set(CoD.BlackMarketUtility.GetPaidTierCpPrice() * f209_local2)
	f209_local3 = f209_arg0:create("CrateCost")
	f209_local3:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"))
	f209_local3 = false
	if not CoD.SafeGetModelValue(Engine.GetModelForController(f209_arg1), "LootStreamProgress.allRngUnlocked") and CoD.BlackMarketUtility.GetCurrentSeasonTier(f209_arg1) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
		local f209_local4 = false
		for f209_local8, f209_local9 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f209_arg1)) do
			if f209_local9.id > 0 and not CoD.ContractUtility.IsContractComplete(f209_arg1, f209_local9.id) then
				f209_local4 = true
			end
		end
		if CoD.BlackMarketUtility.IsEventActive() then
			f209_local5 = CoD.BlackMarketUtility.GetEventName()
			if f209_local5 ~= 0x0 and not CoD.BlackMarketUtility.IsItemPurchased(f209_arg1, CoD.BlackMarketTableUtility.GetContractId(f209_local5)) then
				f209_local4 = true
			end
		end
		if not f209_local4 and IsBooleanDvarSet(@"hash_1989C6B82918FBCC") then
			f209_local3 = true
		end
	end
	local f209_local4 = f209_arg0:create("CratePurchaseTip")
	f209_local4:set(f209_local3)
end, false)
DataSources.TierPurchaseList = ListHelper_SetupDataSource("TierPurchaseList", function(f210_arg0, f210_arg1)
	local f210_local0 = CoD.SafeGetModelValue(Engine.GetGlobalModel(), "ItemShop.HighlightedTier")
	local f210_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f210_arg0)
	local f210_local2 = {}
	local f210_local3 = f210_local0 - f210_local1
	SetPerControllerTableProperty(f210_arg0, "offScreenPurchase", false)
	if f210_local3 > 1 then
		local f210_local4 = CoD.BlackMarketUtility.GetPaidTierCpPrice() * f210_local3
		table.insert(f210_local2, {
			displayText = @"hash_74CEFD5951498C2B",
			action = CoD.BlackMarketUtility.PurchaseTiers,
			tierRef = @"hash_3E874E7281061241",
			params = {
				controller = f210_arg0,
				tiers = f210_local3,
				refocus = false,
			},
			tiersToBuy = f210_local3,
			price = f210_local4,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f210_local4),
		})
	elseif f210_local3 <= 0 then
		f210_local3 = 1
		SetPerControllerTableProperty(f210_arg0, "offScreenPurchase", true)
		local f210_local4 = CoD.BlackMarketUtility.GetPaidTierCpPrice() * f210_local3
		table.insert(f210_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseTiers,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f210_arg0,
				tiers = 1,
				refocus = true,
			},
			tiersToBuy = f210_local1 + 1,
			price = f210_local4,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f210_local4),
		})
	else
		f210_local3 = 1
		local f210_local4 = CoD.BlackMarketUtility.GetPaidTierCpPrice() * f210_local3
		table.insert(f210_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseTiers,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f210_arg0,
				tiers = 1,
				refocus = false,
			},
			tiersToBuy = f210_local1 + 1,
			price = f210_local4,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f210_local4),
		})
	end
	if f210_arg1.menu then
		local f210_local4 = f210_arg1.menu:getModel()
		f210_local4 = f210_local4:create("entryPoint")
		f210_local4:set("stream")
		f210_local4 = f210_arg1.menu:getModel()
		f210_local4 = f210_local4:create("tiers")
		f210_local4:set(f210_local3)
	end
	local f210_local4 = {}
	for f210_local8, f210_local9 in ipairs(f210_local2) do
		table.insert(f210_local4, {
			models = {
				displayText = Engine.Localize(f210_local9.displayText),
				tiersToBuy = f210_local9.tiersToBuy,
				price = f210_local9.price,
				tierRef = f210_local9.tierRef,
				priceRef = f210_local9.priceRef,
			},
			properties = {
				action = f210_local9.action,
				actionParam = f210_local9.params,
			},
		})
	end
	return f210_local4
end)
DataSources.BlackMarketCallingCardMenu = {
	getModel = function(f211_arg0)
		local f211_local0 = "CoD.CallingCards_Stickerbook_Set_BlackMarket"
		if CoD.perController[f211_arg0].isBlackMarketCallingCardNonSet then
			f211_local0 = "CoD.CallingCards_Stickerbook_BlackMarket"
		end
		local f211_local1 = Engine.GetModelForController(f211_arg0)
		f211_local1 = f211_local1:create("BlackMarketCallingCardMenu")
		local f211_local2 = f211_local1:create("frameWidget")
		f211_local2:set(f211_local0)
		return f211_local1
	end,
}
DataSources.ReservesPromoPopup = {
	getModel = function(f212_arg0)
		local f212_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
		local f212_local1 = Engine.GetModelForController(f212_arg0)
		f212_local1 = f212_local1:create("ReservesPromoPopup")
		local f212_local2 = f212_local1:create("title")
		f212_local2:set(f212_local0[@"hash_25174E1CF5A020D4"])
		f212_local2 = f212_local1:create("desc")
		f212_local2:set(f212_local0.promopopupdesc)
		f212_local2 = f212_local1:create("image")
		f212_local2:set(f212_local0.promopopupimage)
		return f212_local1
	end,
}
CoD.BlackMarketUtility.ShowPurchaseTiersPrompt = function(f213_arg0, f213_arg1, f213_arg2)
	if f213_arg1.framedWidget and f213_arg1.framedWidget[f213_arg2] and f213_arg1.framedWidget[f213_arg2]:getAlpha() == 0 then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.GetStreamCount = function(f214_arg0)
	local f214_local0 = 1
	if CoD.BlackMarketUtility.AreContractsEnabled() then
		f214_local0 = f214_local0 + 1
	end
	if CoD.BlackMarketUtility.IsEventActive() then
		f214_local0 = f214_local0 + 1
	end
	if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_5DC2632EE88877F2"]:exists() then
		f214_local0 = f214_local0 + tonumber(Dvar[@"hash_5DC2632EE88877F2"]:get())
	end
	return f214_local0
end
CoD.BlackMarketUtility.MovePurchaseTiersWidget = function(f215_arg0, f215_arg1, f215_arg2)
	local f215_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f215_arg1)
	if not f215_local0 then
		return
	elseif not f215_arg1[f215_arg2] then
		return
	end
	CoD.BlackMarketUtility.MoveColumnHighlightWidget(f215_arg0, f215_arg1)
	local f215_local1 = CoD.BlackMarketUtility.GetStreamCount(f215_arg0)
	local f215_local2 = f215_local1 + 1
	if f215_local1 == 2 then
		f215_arg1[f215_arg2]:setState(f215_arg0, "TwoStream")
	elseif f215_local1 == 3 then
		f215_arg1[f215_arg2]:setState(f215_arg0, "ThreeStream")
	elseif f215_local1 == 4 then
		f215_arg1[f215_arg2]:setState(f215_arg0, "FourStream")
	else
		f215_arg1[f215_arg2]:setState(f215_arg0, "OneStream")
	end
	local f215_local3 = false
	local f215_local4 = 5
	if f215_local0 and f215_local0.activeWidget then
		f215_local4 = f215_local0.activeWidget.gridInfoTable.zeroBasedIndex % 5 + 1
	end
	local f215_local5 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f215_arg0)
	for f215_local6 = 1, 5, 1 do
		local f215_local9 = f215_local0:getItemAtPosition(1, f215_local6, false)
		if f215_local9 then
			local f215_local10 = f215_local9:getModel()
			if f215_local10 then
				f215_arg1[f215_arg2]:setAlpha(1)
				local f215_local11 = not CoD.SafeGetModelValue(f215_local10, "unlocked")
				if not f215_local3 then
					if not (not f215_local11 or f215_local4 > f215_local6) or f215_local6 == 5 then
						if not f215_local11 and f215_local6 == 5 then
							f215_arg1[f215_arg2]:setAlpha(0)
						end
						if f215_local4 < f215_local6 and f215_local11 and CoD.BlackMarketUtility.AreCoDPointsEnabled() and CoD.perController[f215_arg0].allowTierPurchase then
							local f215_local12 = f215_local10:create("toPurchase")
							f215_local12:set(true)
						else
							local f215_local12 = f215_local10:create("toPurchase")
							f215_local12:set(false)
						end
						for f215_local12 = 1, f215_local2, 1 do
							local f215_local15 = f215_local0:getItemAtPosition(f215_local12, f215_local6, false)
							if f215_local15 then
								local f215_local16 = f215_local15:getModel()
								if f215_local16 then
									local f215_local17 = f215_local16:create("toPurchase")
									f215_local17:set(false)
								end
							end
						end
						local f215_local12, f215_local13, f215_local14, f215_local18 = f215_local0:getGlobalLeftRightTopBottom()
						local f215_local15 = f215_arg1[f215_arg2]:getWidth()
						if f215_local15 > 0 then
							local f215_local16 = f215_arg1[f215_arg2]:getHeight()
							local f215_local17, f215_local19, f215_local20, f215_local21 = f215_arg1[f215_arg2]:getLocalLeftRight()
							local f215_local22, f215_local23, f215_local24, f215_local25 = f215_arg1[f215_arg2]:getLocalTopBottom()
							local f215_local26, f215_local27, f215_local28, f215_local29 = f215_local9:getGlobalLeftRightTopBottom()
							local f215_local30 = f215_local26 - (f215_local15 - f215_local9:getWidth()) / 2
							f215_arg1[f215_arg2]:setLeftRight(f215_local17, f215_local19, f215_local30, f215_local30 + f215_local15)
							f215_arg1[f215_arg2]:setTopBottom(f215_local22, f215_local23, f215_local18, f215_local18 + f215_local16)
						end
						local f215_local16 = CoD.SafeGetModelValue(f215_local10, "tier")
						if f215_arg1[f215_arg2].Internal and f215_arg1[f215_arg2].Internal.PurchaseText and f215_arg1[f215_arg2].Internal.TierText then
							if f215_local5 + 1 < f215_local16 then
								f215_arg1[f215_arg2].Internal.PurchaseText:setText(LocalizeToUpperString(@"menu/purchase_tiers"))
								f215_arg1[f215_arg2].Internal.TierText:setText(tostring(f215_local5 + 1) .. "-" .. tostring(f215_local16))
							else
								f215_arg1[f215_arg2].Internal.PurchaseText:setText(LocalizeToUpperString(@"menu/purchase_tier"))
								f215_arg1[f215_arg2].Internal.TierText:setText(tostring(f215_local5 + 1))
							end
						end
						f215_local3 = true
					end
					for f215_local12 = 1, f215_local2, 1 do
						local f215_local15 = f215_local0:getItemAtPosition(f215_local12, f215_local6, false)
						if f215_local15 then
							local f215_local16 = f215_local15:getModel()
							if f215_local16 and CoD.BlackMarketUtility.AreCoDPointsEnabled() and CoD.perController[f215_arg0].allowTierPurchase then
								local f215_local17 = f215_local16:create("toPurchase")
								f215_local17:set(true)
							end
							if not CoD.perController[f215_arg0].allowTierPurchase then
								local f215_local17 = f215_local16:create("toPurchase")
								f215_local17:set(false)
							end
						end
					end
				end
				for f215_local12 = 1, f215_local2, 1 do
					local f215_local15 = f215_local0:getItemAtPosition(f215_local12, f215_local6, false)
					if f215_local15 then
						local f215_local16 = f215_local15:getModel()
						if f215_local16 then
							local f215_local17 = f215_local16:create("toPurchase")
							f215_local17:set(false)
						end
					end
				end
			end
		end
	end
	if f215_arg1:getMenu() then
		local f215_local6 = f215_arg1:getMenu()
		UpdateButtonPromptState(f215_local6, f215_arg1, f215_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"])
		UpdateButtonPromptState(f215_local6, f215_arg1, f215_arg0, Enum.LUIButton[@"lui_key_rstick_pressed"])
	end
	if not CoD.BlackMarketUtility.AreCoDPointsEnabled() then
		f215_arg1[f215_arg2]:setAlpha(0)
	end
	if not CoD.perController[f215_arg0].allowTierPurchase then
		f215_arg1[f215_arg2]:setAlpha(0)
	end
end
CoD.BlackMarketUtility.PlaceCurrentTiersWidget = function(f216_arg0, f216_arg1, f216_arg2)
	local f216_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f216_arg1)
	if not f216_local0 then
		return
	elseif not f216_arg1[f216_arg2] then
		return
	end
	local f216_local1 = CoD.BlackMarketUtility.GetStreamCount(f216_arg0)
	if f216_local1 == 2 then
		f216_arg1[f216_arg2]:setState(f216_arg0, "TwoStream")
	elseif f216_local1 == 3 then
		f216_arg1[f216_arg2]:setState(f216_arg0, "ThreeStream")
	elseif f216_local1 == 4 then
		f216_arg1[f216_arg2]:setState(f216_arg0, "FourStream")
	else
		f216_arg1[f216_arg2]:setState(f216_arg0, "OneStream")
	end
	local f216_local2 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f216_arg0)
	for f216_local3 = 1, 5, 1 do
		local f216_local6 = f216_local0:getItemAtPosition(1, f216_local3, false)
		if f216_local6 then
			local f216_local7 = f216_local6:getModel()
			if f216_local7 and CoD.SafeGetModelValue(f216_local7, "tier") == f216_local2 then
				f216_arg1[f216_arg2]:setAlpha(1)
				local f216_local8, f216_local9, f216_local10, f216_local11 = f216_local0:getGlobalLeftRightTopBottom()
				local f216_local12 = f216_arg1[f216_arg2]:getWidth()
				if f216_local12 > 0 then
					local f216_local13 = f216_arg1[f216_arg2]:getHeight()
					local f216_local14, f216_local15, f216_local16, f216_local17 = f216_arg1[f216_arg2]:getLocalLeftRight()
					local f216_local18, f216_local19, f216_local20, f216_local21 = f216_arg1[f216_arg2]:getLocalTopBottom()
					local f216_local22, f216_local23, f216_local24, f216_local25 = f216_local6:getGlobalLeftRightTopBottom()
					local f216_local26 = f216_local22 - (f216_local12 - f216_local6:getWidth()) / 2
					f216_arg1[f216_arg2]:setLeftRight(f216_local14, f216_local15, f216_local26, f216_local26 + f216_local12)
					f216_arg1[f216_arg2]:setTopBottom(f216_local18, f216_local19, f216_local11, f216_local11 + f216_local13)
				end
				return
			end
		end
	end
	f216_arg1[f216_arg2]:setAlpha(0)
end
CoD.BlackMarketUtility.RegisterCurrentTiersWidget = function(f217_arg0, f217_arg1, f217_arg2)
	if not f217_arg1._currentTiersWidgets then
		f217_arg1._currentTiersWidgets = {}
		f217_arg1:appendEventHandler("update_safe_area", function(f218_arg0, f218_arg1)
			for f218_local3, f218_local4 in ipairs(f217_arg1._currentTiersWidgets) do
				CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f217_arg0, f217_arg1, f218_local4)
			end
		end)
	end
	table.insert(f217_arg1._currentTiersWidgets, f217_arg2)
end
CoD.BlackMarketUtility.RegisterPurchaseTiersWidget = function(f219_arg0, f219_arg1, f219_arg2)
	if not f219_arg1._purchaseTiersWidgets then
		f219_arg1._purchaseTiersWidgets = {}
		f219_arg1:appendEventHandler("update_safe_area", function(f220_arg0, f220_arg1)
			for f220_local3, f220_local4 in ipairs(f219_arg1._purchaseTiersWidgets) do
				CoD.BlackMarketUtility.MovePurchaseTiersWidget(f219_arg0, f219_arg1, f220_local4)
			end
		end)
	end
	table.insert(f219_arg1._purchaseTiersWidgets, f219_arg2)
end
CoD.BlackMarketUtility.InitTiersWidgetNextFrame = function(f221_arg0, f221_arg1, f221_arg2)
	if CoD.isPC then
		f221_arg2._timer = LUI.UITimer.newElementTimer(0, true, function()
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f221_arg0, f221_arg1, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f221_arg0, f221_arg1, "CurrentTier")
		end)
		f221_arg2:addElement(f221_arg2._timer)
	end
end
CoD.BlackMarketUtility.MoveColumnHighlightWidget = function(f223_arg0, f223_arg1)
	local f223_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f223_arg1)
	if not f223_local0 then
		return
	elseif not f223_arg1 then
		return
	end
	local f223_local1 = CoD.BlackMarketUtility.GetActiveContracts(f223_arg0)
	local f223_local2 = CoD.BlackMarketUtility.GetStreamCount(f223_arg0) + 1
	local f223_local3 = 5
	if f223_local0.activeWidget then
		f223_local3 = f223_local0.activeWidget.gridInfoTable.zeroBasedIndex % 5 + 1
	end
	for f223_local4 = 1, 5, 1 do
		for f223_local7 = 1, f223_local2, 1 do
			local f223_local10 = f223_local0:getItemAtPosition(f223_local7, f223_local4, false)
			if f223_local10 then
				local f223_local11 = f223_local10:getModel()
				if f223_local11 then
					if f223_local4 == f223_local3 then
						local f223_local12 = f223_local11:create("selected")
						f223_local12:set(true)
					end
					local f223_local12 = f223_local11:create("selected")
					if CoD.SafeGetModelValue(f223_local11, "selected") == true then
						local f223_local13 = f223_local11:create("recentlyUnlocked")
						f223_local13:set(false)
						f223_local13 = CoD.SafeGetModelValue(f223_local11, "tier")
						local f223_local14 = f223_arg1:getMenu()
						if f223_local14 and f223_local14.purchaseTiers then
							local f223_local15 = 0
							for f223_local19, f223_local20 in pairs(f223_local14.purchaseTiers) do
								if f223_local20 == f223_local13 then
									f223_local15 = f223_local19
								end
							end
							if f223_local15 > 0 then
								table.remove(f223_local14.purchaseTiers, f223_local15)
							end
						end
					end
					f223_local12:set(false)
				end
			end
		end
	end
end
CoD.BlackMarketUtility.CacheContrabandRevealTier = function(f224_arg0, f224_arg1)
	if CoD.SafeGetModelValue(Engine.GetModelForController(f224_arg1), "LootStreamProgress.playAnimation") == true then
		f224_arg0._currentTier = CoD.SafeGetModelValue(f224_arg0:getModel(), "tier")
	end
end
CoD.BlackMarketUtility.GoBackAndOpenBribeMenu = function(f225_arg0, f225_arg1)
	OpenOverlay(GoBack(f225_arg1, f225_arg0), "WeaponBribeSelection", f225_arg0)
end
CoD.BlackMarketUtility.TriggerRevealAnimation = function(f226_arg0, f226_arg1)
	if CoD.SafeGetModelValue(Engine.GetModelForController(f226_arg0), "LootStreamProgress.playAnimation") == true then
		local f226_local0 = Engine.GetModelForController(f226_arg0)
		f226_local0 = f226_local0:create("LootStreamProgress", true)
		if f226_local0 and f226_local0.itemsEarned then
			if f226_local0.itemsEarned:get() == 1 then
				CoD.OverlayUtility.ShowToast("BlackMarketLoot", Engine[@"hash_4F9F1239CFD921FE"]("mpui/item_unlocked", f226_local0.itemsEarned:get()), "", nil)
			else
				CoD.OverlayUtility.ShowToast("BlackMarketLoot", Engine[@"hash_4F9F1239CFD921FE"](@"hash_7D45D6D1C927E427", f226_local0.itemsEarned:get()), "", nil)
			end
		end
		local f226_local1 = CoD.BlackMarketUtility.GetStreamCount(f226_arg0) + 1
		for f226_local2 = 1, 5, 1 do
			for f226_local5 = 1, f226_local1, 1 do
				local f226_local8 = f226_arg1:getItemAtPosition(f226_local5, f226_local2, false)
				if f226_local8 then
					local f226_local9 = f226_local8:getModel()
					if f226_local9 then
						local f226_local10 = CoD.SafeGetModelValue(f226_local9, "recentlyUnlocked")
						local f226_local11 = CoD.SafeGetModelValue(f226_local9, "tier")
						if (f226_local10 or f226_local11 and f226_local11 == CoD.BlackMarketUtility.GetCurrentSeasonTier(f226_arg0)) and CoD.SafeGetModelValue(f226_local9, "name") ~= 0x0 then
							local f226_local12 = f226_local9:create("playAnim")
							f226_local12:set(true)
						end
					end
				end
			end
		end
	end
end
CoD.BlackMarketUtility.TriggerItemShopRevealAnimation = function(f227_arg0, f227_arg1)
	local f227_local0 = Engine.GetModelForController(f227_arg0)
	if CoD.SafeGetModelValue(f227_local0, "LootStreamProgress.playAnimation") == true then
		local f227_local1 = CoD.SafeGetModelValue(f227_local0, "LootStreamProgress.skuPurchased")
		for f227_local2 = 1, 2, 1 do
			for f227_local5 = 1, 2, 1 do
				local f227_local8 = f227_arg1:getItemAtPosition(f227_local5, f227_local2, false)
				if f227_local8 then
					local f227_local9 = f227_local8:getModel()
					if f227_local9 and tostring(CoD.SafeGetModelValue(f227_local9, "skuID")) == f227_local1 then
						DelayedPlayClip(f227_local8, 550, "Animation")
						DelayedPlaySoundAlias(f227_local8, 550, "uin_mtx_item_purchased_stamp")
						local f227_local10 = f227_local0:create("LootStreamProgress.playAnimation")
						f227_local10:set(false)
						f227_local10 = f227_local0:create("LootStreamProgress.skuPurchased")
						f227_local10:set("")
					end
				end
			end
		end
	end
end
CoD.BlackMarketUtility.TriggerSkuVO = function(f228_arg0, f228_arg1, f228_arg2, f228_arg3)
	if not IsPerControllerTablePropertyValue(f228_arg0, "inBlackMarket", true) then
		return
	elseif f228_arg2._isContract then
		CoD.SoundUtility.PlayVO(f228_arg1, "vox_blac_buy_conf_spec_ord")
	else
		local f228_local0 = f228_arg3 and CoD.SafeGetModelValue(f228_arg3:getModel(), "rarity")
		if f228_local0 == Enum.LootRarityType[@"hash_63006FE890A202D9"] or f228_local0 == Enum.LootRarityType[@"loot_rarity_type_epic"] then
			CoD.SoundUtility.PlayVO(f228_arg1, "vox_blac_buy_conf_prem")
		else
			CoD.SoundUtility.PlayVO(f228_arg1, "vox_blac_buy_conf_reg")
		end
	end
end
CoD.BlackMarketUtility.TriggerGreetingVO = function(f229_arg0, f229_arg1)
	f229_arg0:addElement(LUI.UITimer.newElementTimer(0, true, function()
		if CoD.BlackMarketUtility.IsMyShopItemRevealed(f229_arg1) and math.random(1, 3) == 1 then
			CoD.SoundUtility.PlayVO(f229_arg0, "vox_blac_greet_my_shop", true)
		else
			CoD.SoundUtility.PlayVO(f229_arg0, "vox_blac_greet_store", true)
		end
	end))
end
CoD.BlackMarketUtility.TriggerContrabandReveal = function(f231_arg0, f231_arg1, f231_arg2)
	f231_arg1 = f231_arg1.activeWidget or f231_arg1
	if CoD.SafeGetModelValue(Engine.GetModelForController(f231_arg0), "LootStreamProgress.playAnimation") == true and CoD.ModelUtility.IsSelfModelValueTrue(f231_arg1, f231_arg0, "unlocked") then
		local f231_local0 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f231_arg0)
		local f231_local1 = f231_arg1:getModel()
		if f231_local0 == f231_local1.tier:get() then
			f231_local0 = f231_arg1:getModel()
			f231_local0 = f231_local0.rarity:get()
			f231_local1 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(f231_arg1, f231_arg0, "character")
			local f231_local2 = f231_arg1
			if f231_arg1.contractModels then
				f231_local2 = f231_arg1.contractModels.outfitIndexes
			end
			local f231_local3 = Engine[@"getdvarstring"]("mtx_seasonal_exploder")
			if f231_local0 == Enum.LootRarityType[@"loot_rarity_type_rare"] then
				if f231_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f231_arg0, f231_local2) then
					Engine[@"playexploder"](f231_arg0, @"hash_7D480C2D5305097B" .. f231_local3)
				else
					Engine[@"playexploder"](f231_arg0, @"hash_3E760A958C41B737" .. f231_local3)
				end
				f231_arg2:playClip("reveal_rare")
			elseif f231_local0 == Enum.LootRarityType[@"loot_rarity_type_legendary"] then
				if f231_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f231_arg0, f231_local2) then
					Engine[@"playexploder"](f231_arg0, @"hash_71CC0807B9AC076A" .. f231_local3)
				else
					Engine[@"playexploder"](f231_arg0, @"hash_66D545ECBC1139A6" .. f231_local3)
				end
				f231_arg2:playClip("reveal_legend")
			elseif f231_local0 == Enum.LootRarityType[@"loot_rarity_type_epic"] then
				if f231_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f231_arg0, f231_local2) then
					Engine[@"playexploder"](f231_arg0, @"hash_723265939DC5CEFA" .. f231_local3)
				else
					Engine[@"playexploder"](f231_arg0, @"hash_47A1EEF9EE557176" .. f231_local3)
				end
				f231_arg2:playClip("reveal_epic")
			elseif f231_local0 == Enum.LootRarityType[@"hash_63006FE890A202D9"] then
				if f231_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f231_arg0, f231_local2) then
					Engine[@"playexploder"](f231_arg0, @"hash_3E0CC6CB594E8FA3" .. f231_local3)
				else
					Engine[@"playexploder"](f231_arg0, @"hash_760368DA99C9910F" .. f231_local3)
				end
				f231_arg2:playClip("reveal_ultra")
			else
				if f231_local1 and CoD.BlackMarketUtility.PreviewingCharacterFace(f231_arg0, f231_local2) then
					Engine[@"playexploder"](f231_arg0, 0x911A5844D0B572 .. f231_local3)
				else
					Engine[@"playexploder"](f231_arg0, @"hash_74CB8DF6F9281B1E" .. f231_local3)
				end
				f231_arg2:playClip("reveal_common")
			end
		end
	end
end
CoD.BlackMarketUtility.HidePurchaseTiersWidget = function(f232_arg0)
	f232_arg0:setAlpha(0)
end
CoD.BlackMarketUtility.CanPurchaseTiers = function(f233_arg0)
	local f233_local0 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f233_arg0)
	local f233_local1 = CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers()
	local f233_local2 = CoD.SafeGetModelValue(Engine.GetModelForController(f233_arg0), "LootStreamProgress.allRngUnlocked")
	local f233_local3 = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER)
	if f233_local2 and f233_local1 <= f233_local0 then
		local f233_local4 = false
		for f233_local8, f233_local9 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f233_arg0)) do
			if f233_local9.id > 0 and not CoD.ContractUtility.IsContractComplete(f233_arg0, f233_local9.id) then
				f233_local4 = true
			end
		end
		if CoD.BlackMarketUtility.IsEventActive() then
			f233_local5 = CoD.BlackMarketUtility.GetEventName()
			if f233_local5 ~= 0x0 and not CoD.BlackMarketUtility.IsItemPurchased(f233_arg0, CoD.BlackMarketTableUtility.GetContractId(f233_local5)) then
				f233_local4 = true
			end
		end
		if not f233_local4 then
			return false
		end
	end
	return true
end
CoD.BlackMarketUtility.PurchaseTiers = function(f234_arg0, f234_arg1, f234_arg2, f234_arg3)
	if f234_arg0.currentState ~= "DefaultState" then
		return
	elseif not CanPurchaseItem(f234_arg2, f234_arg1) then
		OpenPopup(f234_arg0, "PurchaseCodPoints", f234_arg2, f234_arg1:getModel())
		return
	elseif not CoD.BlackMarketUtility.CanPurchaseTiers(f234_arg2) then
		f234_arg0:setState(f234_arg2, "ErrorState")
		return
	elseif Engine[0x2E671B86427DC1](f234_arg2) ~= 0 then
		f234_arg0:setState(f234_arg2, "ErrorState")
		return
	end
	f234_arg0:setState(f234_arg2, "WorkingState")
	local f234_local0 = f234_arg0:getMenu()
	if f234_local0 then
		UpdateButtonPromptState(f234_local0, f234_arg0, f234_arg2, Enum.LUIButton[@"lui_key_xba_pscross"])
		if f234_local0.CratePurchaseTip then
			f234_local0.CratePurchaseTip:setAlpha(0)
		end
	end
	local f234_local1 = function()
		local f235_local0 = f234_arg0:getMenu()
		if f235_local0 then
			UpdateButtonPromptState(f235_local0, f234_arg0, f234_arg2, Enum.LUIButton[@"lui_key_xbb_pscircle"])
		end
		local f235_local1 = Engine.GetModelForController(f234_arg2)
		f235_local1 = f235_local1:create("LootStreamProgress", true)
		if f235_local1 then
			local f235_local2 = f235_local1:create("itemsEarned", true)
			f235_local2:set(0)
		end
		Engine[@"hash_29EF65378FF2525E"](f234_arg2, CoD.BlackMarketUtility.GetPaidTierSku(), f234_arg3.tiers)
		local f235_local2 = Engine.GetModelForController(f234_arg2)
		f235_local2 = f235_local2:create("LootStreamProgress", true)
		local f235_local3 = nil
		if f235_local2 then
			f235_local3 = f235_local2:create("lastPurchaseSeason", true)
			if f235_local3 then
				local f235_local4 = CoDShared.Loot.GetCurrentSeason()
				if f235_local4 ~= nil then
					f235_local3:set(f235_local4)
				else
					f235_local3:set(0x0)
				end
			end
		end
		if not f234_arg0.purchaseTimer then
			f234_arg0.purchaseTimer = LUI.UITimer.newElementTimer(500, false, function()
				if not Engine.IsInventoryBusy(f234_arg2) and Engine.GetPurchaseDWSKUResult(f234_arg2) ~= Enum.InventoryPurchaseResult[@"inventory_purchase_result_inprogress"] then
					if Engine.GetPurchaseDWSKUResult(f234_arg2) == Enum.InventoryPurchaseResult[@"inventory_purchase_result_success"] then
						f234_arg0:setState(f234_arg2, "FinishedState")
						CoD.MetricsUtility.BlackMarketTierPurchasedEvent(f234_arg2, "stream", true, f234_arg3.tiers)
						local f236_local0 = f234_arg0:getMenu()
						f236_local0:setState(f234_arg2, "UnlockingTiers")
						UpdateButtonPromptState(f236_local0, f234_arg0, f234_arg2, Enum.LUIButton[@"lui_key_xbb_pscircle"])
						local f236_local1 = f236_local0:getModel()
						local f236_local2 = Engine[0x2E671B86427DC1](f234_arg2)
						if f236_local1 then
							local f236_local3 = f236_local1:create("tiersLeft")
							f236_local3:set(f236_local2)
						end
						f234_arg0.redeemTiersTimer = LUI.UITimer.newElementTimer(500, false, function()
							local f237_local0 = f234_arg0:getMenu()
							local f237_local1 = f237_local0:getModel()
							local f237_local2 = Engine[0x2E671B86427DC1](f234_arg2)
							if f237_local2 >= 0 then
								if f237_local1 then
									local f237_local3 = f237_local1:create("tiersLeft")
									f237_local3:set(f237_local2)
								end
								if f237_local2 == 0 and not Engine[@"hash_65B26799D9CD0B8"]() then
									if f234_arg3.refocus then
										SetFocusedTierModelValue(f234_arg2, "0", "")
									end
									f234_arg0.redeemTiersTimer:close()
									f234_arg0.redeemTiersTimer = nil
									local f237_local3 = Engine.GetModelForController(f234_arg2)
									local f237_local4 = f237_local3:create("LootStreamProgress.playAnimation")
									f237_local4:set(true)
									CoD.BlackMarketUtility.UpdateAllRngUnlockedModel(f234_arg2)
									if not CoD.BlackMarketUtility.ShowPostseasonPopup(f237_local0, f234_arg2) and not CoD.BlackMarketUtility.ShowAllRNGPopup(f237_local0, f234_arg2) then
										GoBack(f237_local0, f234_arg2)
									end
								end
							end
						end)
						f234_arg0:addElement(f234_arg0.redeemTiersTimer)
					else
						if f235_local3 then
							f235_local3:set(0x0)
						end
						f234_arg0:setState(f234_arg2, "ErrorState")
					end
					f234_arg0.purchaseTimer:close()
					f234_arg0.purchaseTimer = nil
				end
			end)
			f234_arg0:addElement(f234_arg0.purchaseTimer)
		end
	end
	if CoD.isPC then
		CoD.PCUtility.DisplayPrePurchasePopup(f234_local1, f234_arg0, f234_arg2, {
			tiersElement = f234_arg1,
			tiers = f234_arg3.tiers,
		}, function(f238_arg0)
			f234_arg0:setState(f238_arg0, "DefaultState")
		end)
	else
		f234_local1()
	end
end
CoD.BlackMarketUtility.CanExchangeLootCases = function(f239_arg0, f239_arg1)
	local f239_local0 = tonumber(CoD.SafeGetModelValue(f239_arg1:getModel(), "casePrice"))
	if f239_local0 then
		return f239_local0 <= CoDShared.Loot.GetLootCaseOwnedCount(f239_arg0)
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowShopReserveItem = function(f240_arg0, f240_arg1)
	if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
		local f240_local0 = f240_arg1:getModel()
		if f240_local0 and f240_local0.lootType and f240_local0.lootType:get() == LuaEnum.LOOT_TYPE.CONTRABAND then
			return f240_local0.isInItemShop and f240_local0.isInItemShop:get() == true
		end
	end
	return false
end
CoD.BlackMarketUtility.ShowReservesMeter = function(f241_arg0)
	local f241_local0 = IsBooleanDvarSet(@"hash_150FB25F071D6CBB")
	if f241_local0 then
		f241_local0 = IsJapaneseSku()
		if not f241_local0 then
			f241_local0 = IsBooleanDvarSet(@"hash_495BE2A950EE9E73")
		end
	end
	return f241_local0
end
CoD.BlackMarketUtility.UpdateSunsetPurchasedSlotModel = function(f242_arg0, f242_arg1)
	local f242_local0 = Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"]
	if f242_arg1:getModel() then
		local f242_local1 = f242_arg1:getModel()
		if f242_local1.slot then
			f242_local1 = CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex
			local f242_local2 = f242_arg1:getModel()
			f242_local0 = f242_local1(f242_local2.slot:get())
		end
	end
	local f242_local1 = Engine.GetModelForController(f242_arg0)
	f242_local1 = f242_local1:create("sunsetPurchasedSlot")
	f242_local1:set(f242_local0)
end
CoD.BlackMarketUtility.RevealItemShopSunsetItem = function(f243_arg0, f243_arg1, f243_arg2)
	if not f243_arg0._itemShopRevealCount then
		f243_arg0._itemShopRevealCount = 0
	end
	if not f243_arg0._itemShopRevealElementTable then
		f243_arg0._itemShopRevealElementTable = {}
	end
	if not f243_arg2 then
		f243_arg2 = 0
	end
	local f243_local0 = function(f244_arg0, f244_arg1)
		return f244_arg0.sortIndex < f244_arg1.sortIndex
	end
	local f243_local1 = function()
		if f243_arg0._itemShopRevealDelay then
			f243_arg0._itemShopRevealDelay:close()
			f243_arg0._itemShopRevealDelay = nil
		end
		table.sort(f243_arg0._itemShopRevealElementTable, f243_local0)
		for f245_local3, f245_local4 in ipairs(f243_arg0._itemShopRevealElementTable) do
			local f245_local5 = f245_local4.element
			f243_arg0._itemShopRevealCount = f243_arg0._itemShopRevealCount + 1
			f245_local5.revealTimer = LUI.UITimer.newElementTimer(f245_local4.timeDelay * f243_arg0._itemShopRevealCount, true, function()
				if f245_local5.revealTimer then
					f245_local5.revealTimer:close()
					f245_local5.revealTimer = nil
				end
				f243_arg0._itemShopRevealCount = f243_arg0._itemShopRevealCount - 1
				local f246_local0 = f245_local5:getModel()
				f246_local0.revealed:set(true)
			end)
			f245_local5:addElement(f245_local5.revealTimer)
		end
		f243_arg0._itemShopRevealElementTable = {}
	end
	local f243_local2 = f243_arg1:getModel()
	if not f243_local2 then
		return
	end
	local f243_local3 = 0
	if f243_local2.slot then
		f243_local3 = f243_local2.slot:get()
	end
	if f243_local2.revealed then
		table.insert(f243_arg0._itemShopRevealElementTable, {
			element = f243_arg1,
			sortIndex = f243_local3,
			timeDelay = f243_arg2,
		})
		if not f243_arg0._itemShopRevealDelay then
			f243_arg0._itemShopRevealDelay = LUI.UITimer.newElementTimer(16, true, f243_local1)
			f243_arg0:addElement(f243_arg0._itemShopRevealDelay)
		end
	end
end
CoD.BlackMarketUtility.ItemShopSunsetDelayCloseAndGoBack = function(f247_arg0, f247_arg1, f247_arg2, f247_arg3)
	if not f247_arg3 then
		f247_arg3 = 0
	end
	f247_arg0:addElement(LUI.UITimer.newElementTimer(f247_arg3, true, function()
		CoD.BlackMarketUtility.UpdateSunsetPurchasedSlotModel(f247_arg2, f247_arg1)
		GoBack(GoBack(f247_arg0, f247_arg2), f247_arg2)
	end))
end
CoD.BlackMarketUtility.SetWorkingStateAndExchangeLootCases = function(f249_arg0, f249_arg1, f249_arg2)
	if f249_arg0.currentState ~= "DefaultState" then
		return
	end
	local f249_local0 = CoD.SafeGetModelValue(f249_arg1:getModel(), "caseRule")
	if not f249_local0 then
		return
	end
	f249_arg0:setState(f249_arg2, "WorkingState")
	Engine[@"hash_5B9859F8695DAB71"](f249_arg2, f249_local0)
	if not f249_arg0.exchangeTimer then
		f249_arg0.exchangeTimer = LUI.UITimer.newElementTimer(500, false, function()
			if not Engine.IsInventoryBusy(f249_arg2) and Engine[@"hash_525090566AF670C"](f249_arg2) ~= Enum[@"hash_198BB5B1F9A186F6"][@"hash_41A1F8568C1B8A5D"] then
				if Engine[@"hash_525090566AF670C"](f249_arg2) == Enum[@"hash_198BB5B1F9A186F6"][@"hash_19180C0E9D90CC4"] then
					f249_arg0:setState(f249_arg2, "FinishedState")
					local f250_local0 = f249_arg0:getModel()
					if f250_local0 and f250_local0.purchased then
						f250_local0.purchased:set(true)
					end
					local f250_local1 = f249_arg0:getMenu()
					CoD.BlackMarketUtility.SendItemShopViewEvent(f249_arg2, f250_local1, "exchange")
					if f250_local1._isContract then
						CoD.ContractUtility.OnContractPurchased(f250_local1, f249_arg2)
					else
						CoD.BlackMarketUtility.ItemShopSunsetDelayCloseAndGoBack(f250_local1, f249_arg0, f249_arg2, 750)
					end
					CoD.BlackMarketUtility.TriggerSkuVO(f249_arg2, f249_arg0, f250_local1, f249_arg1)
					CoD.BlackMarketUtility.UpdateReservesItemCounts(f249_arg2)
				else
					f249_arg0:setState(f249_arg2, "ErrorState")
				end
				f249_arg0.exchangeTimer:close()
				f249_arg0.exchangeTimer = nil
			end
		end)
		f249_arg0:addElement(f249_arg0.exchangeTimer)
	end
end
CoD.BlackMarketUtility.SetElementWorkingStateAndExchangeLootCases = function(f251_arg0, f251_arg1)
	CoD.BlackMarketUtility.SetWorkingStateAndExchangeLootCases(f251_arg0, f251_arg0, f251_arg1, false)
end
CoD.BlackMarketUtility.SetActiveOnFirstSupplyChainElement = function(f252_arg0, f252_arg1, f252_arg2)
	if CoD.isPC then
		LUI.OverrideFunction_CallOriginalFirst(f252_arg1, "updateDataSource", function(element)
			if not f252_arg2._isFirstElementActive then
				LUI.GridLayout.setActiveItem(element, element:getFirstSelectableItem(true), nil)
				f252_arg2._isFirstElementActive = true
			end
		end)
	end
end
CoD.BlackMarketUtility.SetHighlightedPurchaseTierFromItemList = function(f254_arg0, f254_arg1)
	local f254_local0 = Engine.GetGlobalModel()
	f254_local0 = f254_local0:create("ItemShop")
	local f254_local1 = f254_local0:create("HighlightedTier")
	local f254_local2 = CoD.SafeGetModelValue(f254_arg1:getModel(), "tier") or 0
	f254_local1:set(f254_local2)
	local f254_local3 = Engine.GetModelForController(f254_arg0)
	if CoD.SafeGetModelValue(f254_local3, "LootStreamProgress.playAnimation") == true then
		local f254_local4 = f254_local3:create("LootStreamProgress.playAnimation")
		f254_local4:set(false)
	end
	local f254_local4 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f254_arg0)
	local f254_local5 = {}
	for f254_local6 = f254_local4 + 1, f254_local2, 1 do
		table.insert(f254_local5, f254_local6)
	end
	if #f254_local5 == 0 then
		table.insert(f254_local5, f254_local4 + 1)
	end
	if f254_arg1:getMenu() then
		local f254_local6 = f254_arg1:getMenu()
		f254_local6.purchaseTiers = f254_local5
	end
end
CoD.BlackMarketUtility.SetHighlightedPurchaseTier = function(f255_arg0, f255_arg1)
	local f255_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain(f255_arg1)
	if f255_local0 ~= nil then
		CoD.BlackMarketUtility.SetHighlightedPurchaseTierFromItemList(f255_arg0, f255_local0)
	end
end
CoD.BlackMarketUtility.PCOpenPurchaseTiersConfirmation = function(f256_arg0, f256_arg1, f256_arg2, f256_arg3)
	local f256_local0 = f256_arg3:getModel()
	f256_local0 = f256_local0:create("entryPoint")
	f256_local0:set("stream")
	OpenPopup(f256_arg0, f256_arg1, f256_arg2, {
		_model = f256_arg3:getModel(),
	})
end
CoD.BlackMarketUtility.ItemUses3DPreview = function(f257_arg0, f257_arg1)
	local f257_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(f257_arg0, f257_arg1, "character")
	if not f257_local0 then
		f257_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(f257_arg0, f257_arg1, "weaponRef")
	end
	return f257_local0
end
CoD.BlackMarketUtility.LootRarityToString = function(f258_arg0)
	return CoD.BlackMarketUtility.LootRarityStrings[f258_arg0] or 0x0
end
CoD.BlackMarketUtility.LootRarityToColor = function(f259_arg0)
	local f259_local0 = CoD.BlackMarketUtility.LootRarityColors[f259_arg0]
	if f259_local0 then
		return f259_local0.r, f259_local0.g, f259_local0.b
	else
		return 0, 0, 0
	end
end
CoD.BlackMarketUtility.LootRarityToColorBright = function(f260_arg0)
	local f260_local0 = CoD.BlackMarketUtility.LootRarityColorsBright[f260_arg0]
	if f260_local0 then
		return f260_local0.r, f260_local0.g, f260_local0.b
	else
		return 0, 0, 0
	end
end
CoD.BlackMarketUtility.LootRarityToColorDark = function(f261_arg0)
	local f261_local0 = CoD.BlackMarketUtility.LootRarityColorsDark[f261_arg0]
	if f261_local0 then
		return f261_local0.r, f261_local0.g, f261_local0.b
	else
		return 0, 0, 0
	end
end
CoD.BlackMarketUtility.GetLootCategoryString = function(f262_arg0, f262_arg1)
	local f262_local0 = f262_arg0
	local f262_local1 = f262_arg0.rarity
	if f262_local1 then
		f262_local1 = f262_local0 and f262_arg0.rarity:get()
	end
	local f262_local2 = f262_arg0
	local f262_local3 = f262_arg0.skipDefaultTitle
	if f262_local3 then
		f262_local3 = f262_local2 and f262_arg0.skipDefaultTitle:get()
	end
	if not f262_local3 and f262_local1 == Enum.LootRarityType[@"loot_rarity_type_count"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_6841EB1B2292EDB8", Engine[@"hash_4F9F1239CFD921FE"](f262_arg1))
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f262_arg1)
	end
end
CoD.BlackMarketUtility.BonusSetText = function(f263_arg0, f263_arg1, f263_arg2)
	if CoD.SafeGetModelValue(f263_arg0, "setName") and nextTier then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3E874E7281061241")
	else
		return ""
	end
end
CoD.BlackMarketUtility.SetPurchaseTiersText = function(f264_arg0, f264_arg1)
	if CoD.SafeGetModelValue(Engine.GetModelForController(f264_arg0), "LootStreamProgress.allRngUnlocked") then
		return @"hash_674A2FF363803E3B"
	else
		return f264_arg1
	end
end
CoD.BlackMarketUtility.GetSeasonCompleteImage = function(f265_arg0)
	local f265_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f265_local0 then
		local f265_local1 = Engine[@"hash_2E00B2F29271C60B"](f265_local0)
		if f265_local1 and f265_local1.postseasonpopupimage then
			return f265_local1.postseasonpopupimage
		end
	end
	return "blacktransparent"
end
CoD.BlackMarketUtility.GetSeasonCompleteTitle = function(f266_arg0)
	local f266_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f266_local0 then
		local f266_local1 = Engine[@"hash_2E00B2F29271C60B"](f266_local0)
		if f266_local1 and f266_local1.postseasonpopuptitle then
			return f266_local1.postseasonpopuptitle
		end
	end
	return f266_arg0
end
CoD.BlackMarketUtility.GetSeasonCompleteMessage = function(f267_arg0)
	local f267_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f267_local0 then
		local f267_local1 = Engine[@"hash_2E00B2F29271C60B"](f267_local0)
		if f267_local1 and f267_local1.postseasonpopupmessage then
			return f267_local1.postseasonpopupmessage
		end
	end
	return 0x0
end
CoD.BlackMarketUtility.GetSeasonCompleteMessageColor = function(f268_arg0)
	local f268_local0 = CoD.BlackMarketUtility.GetCurrentPostSeasonRef()
	if f268_local0 then
		local f268_local1 = Engine[@"hash_2E00B2F29271C60B"](f268_local0)
		if f268_local1 and f268_local1[@"hash_69014841451A5872"] == "black" then
			return 0, 0, 0
		end
	end
	return CoD.ColorUtility.ExplodeColor(ColorSet.T8__OFF__WHITE)
end
CoD.BlackMarketUtility.SetupPageStreamHoldActionReadyCheck = function(f269_arg0, f269_arg1, f269_arg2, f269_arg3)
	if f269_arg0.__pageStreamHoldCheckSet then
		return
	end
	local f269_local0 = {
		1000,
		200,
	}
	f269_arg0.__pageStreamHoldActionReady = true
	f269_arg0.__pageStreamHoldCurrentButton = nil
	f269_arg0.__pageStreamHoldTimeElapse = 0
	f269_arg0.__pageStreamHoldDelayCount = 0
	f269_arg0.__pageStreamHoldBackButtonHeld = false
	f269_arg0.__pageStreamHoldForwardButtonHeld = false
	local f269_local1 = function()
		f269_arg0.__pageStreamHoldActionReady = true
		f269_arg0.__pageStreamHoldCurrentButton = nil
		f269_arg0.__pageStreamHoldTimeElapse = 0
		f269_arg0.__pageStreamHoldDelayCount = 0
	end
	if not f269_arg0.preserveLuiButton then
		f269_arg0.preserveLuiButton = {}
	end
	f269_arg0.preserveLuiButton[f269_arg2] = true
	f269_arg0.preserveLuiButton[f269_arg3] = true
	local f269_local2 = Engine.GetModelForController(f269_arg1)
	f269_local2 = f269_local2.ButtonBits
	f269_arg0:subscribeToModel(f269_local2[f269_arg2], function(model)
		local f271_local0 = model and model:get()
		f269_arg0.__pageStreamHoldBackButtonHeld = f271_local0 and CoD.BitUtility.IsBitwiseAndNonZero(f271_local0, Enum.LUIButtonFlags[@"flag_down"])
		if f269_arg0.__pageStreamHoldBackButtonHeld and not f269_arg0.__pageStreamHoldCurrentButton then
			f269_arg0.__pageStreamHoldCurrentButton = f269_arg2
		elseif not f269_arg0.__pageStreamHoldBackButtonHeld and f269_arg0.__pageStreamHoldCurrentButton == f269_arg2 then
			if f269_arg0.__pageStreamHoldForwardButtonHeld then
				f269_arg0.__pageStreamHoldCurrentButton = f269_arg3
			end
			f269_local1()
		end
	end, false)
	f269_arg0:subscribeToModel(f269_local2[f269_arg3], function(model)
		local f272_local0 = model and model:get()
		f269_arg0.__pageStreamHoldForwardButtonHeld = f272_local0 and CoD.BitUtility.IsBitwiseAndNonZero(f272_local0, Enum.LUIButtonFlags[@"flag_down"])
		if f269_arg0.__pageStreamHoldForwardButtonHeld and not f269_arg0.__pageStreamHoldCurrentButton then
			f269_arg0.__pageStreamHoldCurrentButton = f269_arg3
		elseif not f269_arg0.__pageStreamHoldForwardButtonHeld and f269_arg0.__pageStreamHoldCurrentButton == f269_arg3 then
			if f269_arg0.__pageStreamHoldBackButtonHeld then
				f269_arg0.__pageStreamHoldCurrentButton = f269_arg2
			end
			f269_local1()
		end
	end, false)
	f269_arg0.__pageStreamHoldTimer = LUI.UITimer.newElementTimer(16, false, function(f273_arg0)
		if f269_arg0.__pageStreamHoldCurrentButton and f269_arg0.__pageStreamHoldDelayCount > 0 then
			if #f269_local0 < f269_arg0.__pageStreamHoldDelayCount then
				f269_arg0.__pageStreamHoldDelayCount = #f269_local0
			end
			if not f269_arg0.__pageStreamHoldActionReady and f269_local0[f269_arg0.__pageStreamHoldDelayCount] <= f269_arg0.__pageStreamHoldTimeElapse then
				f269_arg0.__pageStreamHoldActionReady = true
			else
				f269_arg0.__pageStreamHoldTimeElapse = f269_arg0.__pageStreamHoldTimeElapse + f273_arg0.timeElapsed
			end
		end
	end)
	f269_arg0:addElement(f269_arg0.__pageStreamHoldTimer)
	f269_arg0.__pageStreamHoldCheckSet = true
end
CoD.BlackMarketUtility.PageStreamHoldUpdateAction = function(f274_arg0)
	f274_arg0.__pageStreamHoldActionReady = false
	f274_arg0.__pageStreamHoldTimeElapse = 0
	f274_arg0.__pageStreamHoldDelayCount = f274_arg0.__pageStreamHoldDelayCount + 1
end
CoD.BlackMarketUtility.IsPageStreamHoldActionReady = function(f275_arg0, f275_arg1)
	if f275_arg1 == f275_arg0.__pageStreamHoldCurrentButton then
		return f275_arg0.__pageStreamHoldActionReady == true
	else
		return false
	end
end
CoD.BlackMarketUtility.PlayGesture = function(f276_arg0, f276_arg1, f276_arg2)
	local f276_local0 = false
	local f276_local1 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f276_arg1)
	if f276_local1 == nil then
		f276_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f276_arg1)
		if f276_local1 then
			f276_local0 = true
		else
			f276_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDaily(f276_arg1)
			if f276_local1 == nil then
				f276_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopFeatured(f276_arg1)
				if f276_local1 == nil then
					f276_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f276_arg1)
					if f276_local1 == nil then
						f276_local1 = f276_arg1
					end
				end
			end
		end
	end
	if f276_local1 ~= nil then
		local f276_local2 = f276_local1.gesture_index
		if f276_local2 ~= nil and f276_local2 >= 0 then
			local f276_local3 = f276_arg0.SupplyChainDetails
			local f276_local4 = f276_arg0
			if not f276_local0 then
				f276_local3 = f276_arg1.framedWidget and f276_arg1.framedWidget.SupplyChainDetails
				f276_local4 = f276_arg1.framedWidget
			end
			if f276_local3 and f276_local4 then
				f276_local3:setState(f276_arg2, "Hidden")
				if f276_local4.gestureTimer == nil then
					f276_local4.gestureTimer = LUI.UITimer.newElementTimer(10000, false, function()
						f276_local4.gestureTimer:close()
						f276_local4.gestureTimer = nil
						UpdateSelfState(f276_local3, f276_arg2)
					end)
					f276_local4:addElement(f276_local4.gestureTimer)
				else
					LUI.UITimer.Reset(f276_local4.gestureTimer)
				end
			end
			Engine.SendClientScriptNotify(f276_arg2, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f276_arg2), {
				event_name = "previewGesture",
				gesture_index = f276_local2 - 1,
				replay_if_already_playing = false,
				ignore_if_already_playing = false,
				wait_until_model_steam_ends = false,
			})
		end
	end
end
CoD.BlackMarketUtility.AutoPlayGestureIfApplicable = function(f278_arg0, f278_arg1, f278_arg2)
	local f278_local0 = f278_arg1:getModel()
	local f278_local1 = f278_local0 and f278_local0.gesture_index
	local f278_local2 = f278_local1 and f278_local1:get()
	if f278_local2 and f278_local2 >= 0 then
		f278_local2 = f278_local2 - 1
		if not f278_arg1.autoGestureTimer then
			f278_arg1.autoGestureTimer = LUI.UITimer.newElementTimer(0, true, function()
				f278_arg1.autoGestureTimer:close()
				f278_arg1.autoGestureTimer = nil
				Engine.SendClientScriptNotify(f278_arg2, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f278_arg2), {
					event_name = "previewGesture",
					gesture_index = f278_local2,
					replay_if_already_playing = true,
					ignore_if_already_playing = false,
					wait_until_model_steam_ends = true,
				})
			end)
			f278_arg1:addElement(f278_arg1.autoGestureTimer)
		else
			f278_arg1.autoGestureTimer:reset()
		end
	end
end
CoD.BlackMarketUtility.ToggleCharacterModelCamera = function(f280_arg0, f280_arg1, f280_arg2)
	local f280_local0 = f280_arg0.SupplyChainDetails
	if not f280_local0 then
		f280_local0 = f280_arg1.framedWidget
		if f280_local0 then
			f280_local0 = f280_arg1.framedWidget.SupplyChainDetails
		end
	end
	if f280_local0 then
		local f280_local1 = nil
		if f280_local0.currentState == "Hidden" then
			UpdateSelfState(f280_local0, f280_arg2)
			f280_local1 = "character"
		else
			f280_local0:setState(f280_arg2, "Hidden")
			f280_local1 = "character_full"
		end
		f280_arg0._lastState = f280_local1
		SendClientScriptMenuChangeNotifyWithState(f280_arg2, f280_arg0, true, f280_local1)
	end
end
CoD.BlackMarketUtility.ResetSignatureWeaponState = function(f281_arg0)
	f281_arg0._showingMastercraft = true
end
CoD.BlackMarketUtility.SendWeaponUpdate = function(f282_arg0, f282_arg1, f282_arg2, f282_arg3, f282_arg4)
	if f282_arg3 ~= nil then
		local f282_local0 = 0
		local f282_local1 = 0
		local f282_local2 = 0
		if f282_arg4 then
			f282_local1 = Engine.TableLookup(CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f282_arg4)
			if f282_arg2.itemCategory:get() == "reactive_camo" or f282_arg2.itemCategory:get() == "single_reactive_camo" or f282_arg2.itemCategory:get() == "reactive_camo_bundle" then
				f282_local2 = tonumber(CoD.CACUtility.AdjustCamoIfSignatureCamo(f282_arg1, tostring(f282_local1), true))
			end
		end
		if f282_arg3.modelIdx then
			f282_local0 = f282_arg3.modelIdx
		end
		if f282_local0 then
			if f282_arg2.itemCategory:get() == "weapon_camo" or f282_arg2.itemCategory:get() == "single_camo" or f282_arg2.itemCategory:get() == "weapon_camo_bundle" or f282_arg2.itemCategory:get() == @"hash_1FBA128D08C2E117" then
				Engine.SendClientScriptNotify(f282_arg1, "QMWeaponUpdate", {
					weapon_ref = f282_arg3.ref,
					model_idx = f282_local0,
					activeCamoIndex = nil,
					camoIndex = f282_local1,
				})
			elseif f282_arg2.itemCategory:get() == "reactive_camo" or f282_arg2.itemCategory:get() == "single_reactive_camo" or f282_arg2.itemCategory:get() == "reactive_camo_bundle" then
				Engine.SendClientScriptNotify(f282_arg1, "QMWeaponUpdate", {
					weapon_ref = f282_arg3.ref,
					model_idx = f282_local0,
					activeCamoIndex = f282_local2,
					camoIndex = f282_local1,
				})
			elseif f282_arg2.itemCategory:get() == "mastercraft" or f282_arg2.itemCategory:get() == "mastercraft_bundle" or f282_arg2.itemCategory:get() == "mk2" then
				Engine.SendClientScriptNotify(f282_arg1, "QMWeaponUpdate", {
					weapon_ref = f282_arg3.ref,
					model_idx = f282_local0,
					activeCamoIndex = f282_local1,
					camoIndex = nil,
				})
			else
				Engine.SendClientScriptNotify(f282_arg1, "QMWeaponUpdate", {
					weapon_ref = f282_arg3.ref,
					model_idx = f282_local0,
					activeCamoIndex = nil,
					camoIndex = 0,
				})
			end
		end
	end
end
CoD.BlackMarketUtility.SendSignatureWeaponUpdate = function(f283_arg0, f283_arg1, f283_arg2, f283_arg3)
	if f283_arg3 ~= nil then
		local f283_local0, f283_local1 = nil
		if not f283_arg0._showingMastercraft then
			f283_local0 = f283_arg3.signatureIndex
			if not f283_arg0._skipSignatureWeaponStringOverride then
				f283_arg2.category:set(@"hash_1D4314C41E9C9CFC")
				if f283_arg2.isContract == nil or f283_arg2.isContract:get() == false then
					f283_arg2.name:set(f283_arg3.displayNameRef)
				end
			end
		else
			f283_local0 = f283_arg3.mastercraftIndex
			if not f283_arg0._skipSignatureWeaponStringOverride then
				f283_arg2.category:set("weapon_options/mastercraft")
				if f283_arg2.isContract == nil or f283_arg2.isContract:get() == false then
					f283_arg2.name:set(f283_arg3.mastercraftNameRef)
				end
			end
			local f283_local2 = Engine.TableLookup(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], Enum.attachmentTableColumn_e[@"hash_2BE9816FAD8AD2D2"], "theme", Enum.attachmentTableColumn_e[@"hash_726CA7CCFF2886B5"], f283_arg3.mastercraftIndex, Enum.attachmentTableColumn_e[@"hash_9A2FFE632B9ED93"], f283_arg3.ref)
			if f283_local2 then
				f283_local1 = Engine.TableLookup(CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f283_local2)
			end
		end
		if f283_local0 then
			Engine.SendClientScriptNotify(f283_arg1, "QMWeaponUpdate", {
				weapon_ref = f283_arg3.ref,
				model_idx = f283_local0,
				activeCamoIndex = f283_local1,
				camoIndex = nil,
			})
		end
	end
end
CoD.BlackMarketUtility.ToggleSignatureWeapon = function(f284_arg0, f284_arg1, f284_arg2)
	local f284_local0 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f284_arg2)
	if f284_local0 == nil then
		f284_local0 = CoD.BlackMarketUtility.GetContractFrameDetailInfo(f284_arg2)
		if f284_local0 == nil then
			f284_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f284_arg2)
			if f284_local0 == nil then
				f284_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromWeaponBribeSelection(f284_arg2)
				if f284_local0 == nil then
					f284_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f284_arg2)
				end
			end
		end
	end
	if f284_local0 ~= nil then
		f284_arg0._showingMastercraft = not f284_arg0._showingMastercraft
		local f284_local1 = f284_local0
		local f284_local2 = f284_local0:getModel()
		if f284_local0.contractModels then
			f284_local1 = f284_local0.contractModels
			local f284_local3 = f284_local0:getModel()
			f284_local2 = f284_local3.contractModels
		end
		CoD.BlackMarketUtility.SendSignatureWeaponUpdate(f284_arg0, f284_arg1, f284_local2, f284_local1.signatureWeaponInfo)
	end
end
CoD.BlackMarketUtility.QuarterMasterFrameChangeActions = function(f285_arg0, f285_arg1, f285_arg2)
	local f285_local0 = function()
		CoD.PlayerRoleUtility.StopGesturePreview(f285_arg1, f285_arg2)
		UpdateButtonPromptState(f285_arg0, f285_arg1, f285_arg2, Enum.LUIButton[@"lui_key_rstick_pressed"])
	end
	if not f285_arg1.__hasEndGesturePreviewCallback then
		f285_arg1.__hasEndGesturePreviewCallback = true
		LUI.OverrideFunction_CallOriginalFirst(f285_arg1, "createFrameWidget", f285_local0)
		LUI.OverrideFunction_CallOriginalFirst(f285_arg1, "changeFrameWidget", f285_local0)
	end
end
CoD.BlackMarketUtility.GetSupplyChainActiveWidget = function(f287_arg0)
	local f287_local0 = "SupplyChainDetails"
	if f287_arg0.framedWidget and f287_arg0.framedWidget[f287_local0] then
		local f287_local1 = CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain(f287_arg0)
		if f287_local1 and f287_local1:getModel() == f287_arg0.framedWidget[f287_local0]:getModel() then
			return f287_local1
		end
		local f287_local2 = CoD.BlackMarketUtility.GetActiveWidgetFromStreams(f287_arg0)
		if f287_local2 then
			local f287_local3 = f287_local2:getModel()
			if f287_local3.contractModels == f287_arg0.framedWidget[f287_local0]:getModel() then
				return f287_local2
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetActiveWidgetFromStreams = function(f288_arg0)
	local f288_local0 = "StreamList"
	if f288_arg0.framedWidget and f288_arg0.framedWidget[f288_local0] and f288_arg0.framedWidget[f288_local0].activeWidget then
		return f288_arg0.framedWidget[f288_local0].activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetSupplyChainItemList = function(f289_arg0)
	local f289_local0 = "ItemList"
	if f289_arg0[f289_local0] then
		return f289_arg0[f289_local0]
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain = function(f290_arg0)
	if not f290_arg0 or not f290_arg0.framedWidget then
		return nil
	else
		local f290_local0 = CoD.BlackMarketUtility.GetSupplyChainItemList(f290_arg0.framedWidget)
		if f290_local0 and f290_local0.activeWidget then
			return f290_local0.activeWidget
		else
			return nil
		end
	end
end
CoD.BlackMarketUtility.GetContractFrameDetailInfo = function(f291_arg0)
	if f291_arg0.framedWidget and f291_arg0.framedWidget.PurchasableContractList then
		local f291_local0 = f291_arg0.framedWidget.PurchasableContractList
		if f291_local0.ContractInfoPanel then
			return f291_local0.ContractInfoPanel
		end
	end
	return nil
end
CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails = function(f292_arg0)
	if f292_arg0.ContractInfoPanel and f292_arg0.ContractInfoPanel.currentState ~= "Hidden" then
		return f292_arg0.ContractInfoPanel
	elseif CoD.isPC and f292_arg0.RewardGridPC then
		return f292_arg0.RewardGridPC.activeWidget
	elseif f292_arg0.RewardList then
		return f292_arg0.RewardList.activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails = function(f293_arg0)
	if f293_arg0.SupplyChainDetails and f293_arg0.SupplyChainDetails.currentState ~= "Hidden" then
		return f293_arg0
	elseif CoD.isPC and f293_arg0.RewardGridPC then
		return f293_arg0.RewardGridPC.activeWidget
	elseif f293_arg0.RewardList then
		return f293_arg0.RewardList.activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromWeaponBribeSelection = function(f294_arg0)
	if f294_arg0.WeaponBribes then
		return f294_arg0.WeaponBribes.activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDaily = function(f295_arg0)
	local f295_local0 = "DailyItems"
	if f295_arg0.framedWidget and f295_arg0.framedWidget[f295_local0] and f295_arg0.framedWidget[f295_local0].activeWidget then
		return f295_arg0.framedWidget[f295_local0].activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.GetActiveWidgetFromItemShopFeatured = function(f296_arg0)
	local f296_local0 = "FeaturedItems"
	if f296_arg0.framedWidget and f296_arg0.framedWidget[f296_local0] and f296_arg0.framedWidget[f296_local0].activeWidget then
		return f296_arg0.framedWidget[f296_local0].activeWidget
	else
		return nil
	end
end
CoD.BlackMarketUtility.OpenPurchaseTiersConfirmation = function(f297_arg0, f297_arg1, f297_arg2)
	local f297_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromSupplyChain(f297_arg2)
	if f297_local0 ~= nil then
		local f297_local1 = f297_local0:getModel()
		f297_local1 = f297_local1:create("entryPoint")
		f297_local1:set("button")
		OpenPopup(f297_arg2.framedWidget, "PurchaseTiersConfirmation", f297_arg0, {
			_model = f297_local0:getModel(),
		})
	end
end
CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget = function(f298_arg0)
	local f298_local0 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f298_arg0)
	if f298_local0 == nil then
		f298_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f298_arg0)
		if f298_local0 == nil then
			f298_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDaily(f298_arg0)
			if f298_local0 == nil then
				f298_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopFeatured(f298_arg0)
				if f298_local0 == nil then
					f298_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f298_arg0)
					if f298_local0 == nil then
						f298_local0 = f298_arg0
					end
				end
			end
		end
	end
	return f298_local0
end
CoD.BlackMarketUtility.CanPlayGesture = function(f299_arg0)
	local f299_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f299_arg0)
	if f299_local0 ~= nil then
		local f299_local1 = f299_local0.gesture_index
		if f299_local1 ~= nil and f299_local1 >= 0 then
			return true
		end
	end
	return false
end
CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil = function(f300_arg0, f300_arg1, f300_arg2)
	local f300_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f300_arg0)
	if f300_local0 then
		return CoD.ModelUtility.IsSelfModelValueNil(f300_local0, f300_arg1, f300_arg2)
	else
		return false
	end
end
CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo = function(f301_arg0, f301_arg1, f301_arg2, f301_arg3)
	local f301_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f301_arg0)
	if f301_local0 then
		return CoD.ModelUtility.IsSelfModelValueEqualTo(f301_local0, f301_arg1, f301_arg2, f301_arg3)
	else
		return false
	end
end
CoD.BlackMarketUtility.CanToggleSignatureWeapon = function(f302_arg0)
	local f302_local0 = CoD.BlackMarketUtility.GetSupplyChainActiveWidget(f302_arg0)
	if f302_local0 == nil then
		f302_local0 = CoD.BlackMarketUtility.GetContractFrameDetailInfo(f302_arg0)
		if f302_local0 == nil then
			f302_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromContractDetails(f302_arg0)
			if f302_local0 == nil then
				f302_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromWeaponBribeSelection(f302_arg0)
				if f302_local0 == nil then
					f302_local0 = CoD.BlackMarketUtility.GetActiveWidgetFromItemShopDetails(f302_arg0)
				end
			end
		end
	end
	if f302_local0 ~= nil then
		local f302_local1 = CoD.SafeGetModelValue(f302_local0:getModel(), "weaponRef")
		return f302_local1 and f302_local1 ~= 0x0
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowSupplyChainDetailsButtonPrompts = function(f303_arg0, f303_arg1)
	if not CoD.ModelUtility.IsSelfModelValueEqualTo(f303_arg0, f303_arg1, "gesture_index", -1) then
		return true
	elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(f303_arg0, f303_arg1, "movieName") then
		return true
	elseif CoD.ModelUtility.IsSelfModelValueTrue(f303_arg0, f303_arg1, "allowTogglePreview") then
		return true
	elseif CoD.ModelUtility.IsSelfModelValueTrue(f303_arg0, f303_arg1, "allowFrozenMoment") then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.IsTierItemInUpsellRow = function(f304_arg0, f304_arg1)
	local f304_local0 = CoD.perController[f304_arg0].upsellContractRowIndex or 0
	if f304_local0 > 0 then
		return CoD.GridAndListUtility.IsElementAtRowIndex(f304_arg1, f304_local0 + 1)
	else
		return false
	end
end
CoD.BlackMarketUtility.EnableLiveCountDownTimer = function(f305_arg0)
	f305_arg0:registerEventHandler("bm_autoevents_tick", function(element, event)
		Engine.SetDvar("live_autoEventPumpTime", 0)
	end)
	f305_arg0:addElement(LUI.UITimer.new(100, "bm_autoevents_tick", false, f305_arg0))
end
CoD.BlackMarketUtility.SetupSupplyChainMovie = function(f307_arg0, f307_arg1, f307_arg2)
	local f307_local0 = CoD.BlackMarketUtility.GetQuarterMasterMenuActiveWidget(f307_arg0)
	if f307_local0 then
		CoD.VideoStreamingUtility.SetupVoDMovie(f307_arg1, f307_local0, f307_arg2)
	end
end
CoD.BlackMarketUtility.SetupReservesMovie = function(f308_arg0)
	local f308_local0 = "core_frontend_rng_reserve"
	local f308_local1 = false
	local f308_local2 = true
	local f308_local3 = Enum[@"hash_6C47FC1BD2E5CCEE"][@"hash_390B07394D69C5F4"]
	local f308_local4 = DataSources.VoDViewer.getModel(f308_arg0)
	f308_local4.stream:set(CoD.VideoStreamingUtility.GetMoviePlayerParams(f308_local3, f308_local0, f308_local1, f308_local2))
end
DataSourceHelpers.GlobalDataSourceSetup("ItemshopRotation", "ItemshopRotation", function(f309_arg0)
	f309_arg0:create("cycled")
	f309_arg0:create("loot_itemshop_slot1_timer")
	f309_arg0:create("loot_itemshop_slot1_timer_active")
	f309_arg0:create("loot_itemshop_slot2_timer")
	f309_arg0:create("loot_itemshop_slot2_timer_active")
	f309_arg0:create("loot_itemshop_slot3_timer")
	f309_arg0:create("loot_itemshop_slot3_timer_active")
	f309_arg0:create("loot_itemshop_slot4_timer")
	f309_arg0:create("loot_itemshop_slot4_timer_active")
	f309_arg0:create("loot_itemshop_slot5_timer")
	f309_arg0:create("loot_itemshop_slot5_timer_active")
	f309_arg0:create("loot_itemshop_slot6_timer")
	f309_arg0:create("loot_itemshop_slot6_timer_active")
end, false)
DataSourceHelpers.GlobalDataSourceSetup("ReserveDealsRotation", "ReserveDealsRotation", function(f310_arg0)
	f310_arg0:create("cycled")
	f310_arg0:create("currentTime")
end, false)
DataSourceHelpers.GlobalDataSourceSetup("BribeStackTimer", "BribeStackTimer", function(f311_arg0)
	f311_arg0:create("cycled")
	f311_arg0:create("currentTime")
end, false)
DataSourceHelpers.GlobalDataSourceSetup("BribeMenuTimer", "BribeMenuTimer", function(f312_arg0)
	f312_arg0:create("cycled")
	local f312_local0 = f312_arg0:create("countDown")
	f312_local0:set(false)
	f312_arg0:create("bribe_menu_timer")
end, false)
CoD.BlackMarketUtility.EnableItemshopTick = function(f313_arg0, f313_arg1)
	f313_arg1:registerEventHandler("bm_itemshop_tick", function(element, event)
		CoD.BlackMarketUtility.TickItemshop(f313_arg0)
	end)
	local f313_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "ItemshopRotation")
	if f313_local0 then
		for f313_local1 = 1, CoD.BlackMarketUtility.ItemShopSlots, 1 do
			local f313_local4 = "loot_itemshop_slot" .. f313_local1 .. "_timer"
			local f313_local5 = Engine.CreateModel(f313_local0, f313_local4)
			local f313_local6 = Engine.CreateModel(f313_local0, f313_local4 .. "_raw")
			local f313_local7 = Engine.CreateModel(f313_local0, f313_local4 .. "_red")
		end
	end
	CoD.BlackMarketUtility.TickItemshop(f313_arg0)
	f313_arg1:addElement(LUI.UITimer.new(100, "bm_itemshop_tick", false, f313_arg1))
end
CoD.BlackMarketUtility.EnableReserveDealsTick = function(f315_arg0, f315_arg1)
	f315_arg1:registerEventHandler("bm_reservedeals_tick", function(element, event)
		CoD.BlackMarketUtility.TickReserveDeals(f315_arg0)
	end)
	CoD.BlackMarketUtility.TickReserveDeals(f315_arg0)
	f315_arg1:addElement(LUI.UITimer.new(100, "bm_reservedeals_tick", false, f315_arg1))
end
CoD.BlackMarketUtility.EnableBribeStackTick = function(f317_arg0, f317_arg1)
	f317_arg1:registerEventHandler("bm_bribestack_tick", function(element, event)
		CoD.BlackMarketUtility.TickBribeStack(f317_arg0)
	end)
	CoD.BlackMarketUtility.TickBribeStack(f317_arg0)
	f317_arg1:addElement(LUI.UITimer.new(100, "bm_bribestack_tick", false, f317_arg1))
end
CoD.BlackMarketUtility.EnableBribeMenuTick = function(f319_arg0, f319_arg1)
	f319_arg1:registerEventHandler("bm_bribemenu_tick", function(element, event)
		CoD.BlackMarketUtility.TickBribeMenu(f319_arg0)
	end)
	CoD.BlackMarketUtility.TickBribeMenu(f319_arg0)
	f319_arg1:addElement(LUI.UITimer.new(100, "bm_bribemenu_tick", false, f319_arg1))
end
DataSourceHelpers.GlobalDataSourceSetup("AutoEvents", "AutoEvents", function(f321_arg0)
	f321_arg0:create("cycled")
	f321_arg0:create("autoevent_timer_black_market")
	f321_arg0:create("autoevent_contract1_timer")
	f321_arg0:create("autoevent_contract2_timer")
	f321_arg0:create("loot_event_stream_timer")
	f321_arg0:create("loot_season_stream_timer")
	f321_arg0:create("autoevent_discount1_timer")
	f321_arg0:create("autoevent_discount2_timer")
	f321_arg0:create("autoevent_discount3_timer")
	f321_arg0:create("autoevent_special_contract_timer")
	f321_arg0:create("autoevent_half_off_crate_timer")
	f321_arg0:create("bribe_menu_half_off_timer")
	f321_arg0:create("zm_daily_callings_timer")
end, false)
CoD.BlackMarketUtility.ScaleWidgetToGridList = function(f322_arg0, f322_arg1, f322_arg2)
	local f322_local0, f322_local1, f322_local2, f322_local3 = f322_arg0:getLocalLeftRight()
	local f322_local4, f322_local5 = f322_arg1:getLocalSize()
	local f322_local6 = (f322_local3 + f322_local2) / 2
	local f322_local7 = f322_local4 + f322_arg2 * 2
	f322_arg0:setLeftRight(f322_local0, f322_local1, f322_local6 - f322_local7 / 2, f322_local6 + f322_local7 / 2)
end
CoD.BlackMarketUtility.SetupTierSkipSegmentResize = function(f323_arg0, f323_arg1)
	LUI.OverrideFunction_CallOriginalFirst(f323_arg1, "updateLayout", function(element)
		CoD.BlackMarketUtility.ScaleWidgetToGridList(f323_arg0, f323_arg1, 5)
	end)
end
CoD.BlackMarketUtility.CreateTierSkipSegmentDataSource = function(f325_arg0, f325_arg1, f325_arg2, f325_arg3)
	DataSources[f325_arg0] = DataSourceHelpers.ListSetup(f325_arg0, function(f326_arg0, f326_arg1)
		local f326_local0 = {}
		for f326_local1 = 1, f325_arg2, 1 do
			table.insert(f326_local0, {
				models = {
					index = f325_arg3 + f326_local1,
				},
			})
		end
		return f326_local0
	end, true)
	return f325_arg0
end
DataSources.TierSkipRewardProgress = ListHelper_SetupDataSource("TierSkipRewardProgress", function(f327_arg0, f327_arg1)
	local f327_local0 = {}
	local f327_local1 = math.random(3, 5)
	local f327_local2 = 0
	for f327_local3 = 1, f327_local1, 1 do
		local f327_local6 = math.random(2, 5)
		table.insert(f327_local0, {
			models = {
				tierSkipSegmentDatasource = CoD.BlackMarketUtility.CreateTierSkipSegmentDataSource("TierSkipSegment_" .. f327_local3, f327_local3, f327_local6, f327_local2),
			},
			properties = {
				_useLocalSize = true,
			},
		})
		f327_local2 = f327_local2 + f327_local6
	end
	return f327_local0
end, true)
DataSources.TierSkip = {
	getModel = function(f328_arg0)
		return CoD.BlackMarketUtility.GetTierSkipRootModel(f328_arg0)
	end,
}
CoD.BlackMarketUtility.GetTierSkipRootModel = function(f329_arg0)
	local f329_local0 = Engine.GetModelForController(f329_arg0)
	return f329_local0:create("TierSkip")
end
CoD.BlackMarketUtility.GetTierSkipNotifyVisModel = function(f330_arg0)
	local f330_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f330_arg0)
	return f330_local0:create("notifyVisible")
end
CoD.BlackMarketUtility.SetupTierSkipModels = function(f331_arg0, f331_arg1)
	local f331_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f331_arg0)
	local f331_local1 = f331_local0:create("remainingTimeString")
	f331_local1:set("")
	f331_local1 = CoD.BlackMarketUtility.GetTierSkipNotifyVisModel(f331_arg0)
	f331_local1:set(false)
end
CoD.BlackMarketUtility.ShowTierSkipNotification = function(f332_arg0, f332_arg1, f332_arg2)
	if not CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled") or IsLAN() then
		return
	end
	local f332_local0 = f332_arg1:getModel()
	local f332_local1 = f332_local0.mode
	if f332_local1 then
		f332_local1 = f332_local0.mode:get()
	end
	if LuaUtils.GetEModeForLobbyMainMode(f332_local1) ~= Enum.eModes.mode_campaign then
		if f332_arg2._tierSkipNotifyTimer then
			f332_arg2._tierSkipNotifyTimer:close()
			f332_arg2._tierSkipNotifyTimer = nil
		end
		f332_arg2._tierSkipNotifyTimer = LUI.UITimer.newElementTimer(20, true, function(f333_arg0)
			local f333_local0 = CoD.BlackMarketUtility.GetTierSkipNotifyVisModel(f332_arg0)
			f333_local0:set(true)
		end)
		f332_arg2:addElement(f332_arg2._tierSkipNotifyTimer)
	end
end
CoD.BlackMarketUtility.HideTierSkipNotification = function(f334_arg0, f334_arg1, f334_arg2)
	local f334_local0 = CoD.BlackMarketUtility.GetTierSkipNotifyVisModel(f334_arg0)
	f334_local0:set(false)
end
CoD.BlackMarketUtility.RefetchTierSkipStatus = function(f335_arg0)
	Engine.ExecNow(f335_arg0, "queueGameEvent tier_skip 0")
	Engine.ExecNow(f335_arg0, "flushgameevents")
end
CoD.BlackMarketUtility.GetContractTierSkipStatus = function(f336_arg0)
	local f336_local0 = CoD.BlackMarketUtility.GetContractStateTable(f336_arg0)
	if f336_local0 then
		local f336_local1 = f336_local0.dailyExpirationStr
		local f336_local2 = f336_local0.flags
		return f336_local1, CoD.BitUtility.IsBitSet(f336_local2, CoDShared.LootContracts.StateFlags.LOOT_CONTRACT_DAILY_TIER_SKIP_EARNED), CoD.BitUtility.IsBitSet(f336_local2, CoDShared.LootContracts.StateFlags.LOOT_CONTRACT_ZM_TIER_SKIP_EARNED)
	else
		return "0", 0, 0
	end
end
CoD.BlackMarketUtility.IsDailyTierSkipAvailable = function(f337_arg0, f337_arg1)
	if CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled") then
		if CoD.BaseUtility.IsDvarEnabled("lootcontracts_daily_tier_skip") then
			local f337_local0, f337_local1, f337_local2 = CoD.BlackMarketUtility.GetContractTierSkipStatus(f337_arg0)
			if not f337_local1 then
				if f337_arg1._refreshTimer then
					f337_arg1._refreshTimer:close()
					f337_arg1._refreshTimer = nil
				end
				return true
			end
		end
		local f337_local0 = Engine[@"hash_1F3EC54007D2233C"](f337_arg0)
		if f337_local0 and f337_local0.fetched then
			if f337_local0.nextActivationTime then
				if Engine.GetSecondsRemainingServer(f337_local0.nextActivationTime) < 0 and f337_local0.achieved then
					if not f337_arg1._hasRefetchedStatus then
						Engine.PrintInfo(Enum[@"consolelabel_e"][@"hash_7F6819CEB0970CFD"], "Timer expired, refetching tier skip status.\n")
						CoD.BlackMarketUtility.RefetchTierSkipStatus(f337_arg0)
						f337_arg1._hasRefetchedStatus = true
					end
				elseif f337_arg1._hasRefetchedStatus then
					f337_arg1._hasRefetchedStatus = false
				end
			end
			if not f337_local0.achieved then
				if f337_arg1._refreshTimer then
					f337_arg1._refreshTimer:close()
					f337_arg1._refreshTimer = nil
				end
				return true
			end
		end
	end
	return false
end
CoD.BlackMarketUtility.IsDailyTierSkipComplete = function(f338_arg0, f338_arg1)
	if CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled") then
		if CoD.BaseUtility.IsDvarEnabled("lootcontracts_daily_tier_skip") then
			local f338_local0, f338_local1, f338_local2 = CoD.BlackMarketUtility.GetContractTierSkipStatus(f338_arg0)
			if f338_local1 then
				f338_arg1._nextActivationTime = f338_local0
				if f338_arg1._refreshTimer then
					f338_arg1._refreshTimer:close()
					f338_arg1._refreshTimer = nil
				end
				f338_arg1._refreshTimer = LUI.UITimer.newElementTimer(500, false, function(f339_arg0)
					local f339_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f338_arg0)
					local f339_local1 = f339_local0.remainingTimeString
					if Engine.GetSecondsRemainingServer(f338_arg1._nextActivationTime) > 0 then
						f339_local1:set(LuaUtils.SecondsToTimeRemainingString(Engine.GetSecondsRemainingServer(f338_arg1._nextActivationTime)))
					else
						f339_local1:set("")
						UpdateState(f338_arg1, {
							name = "update_state",
							controller = f338_arg0,
						})
					end
				end)
				f338_arg1:addElement(f338_arg1._refreshTimer)
				return true
			end
		end
		local f338_local0 = Engine[@"hash_1F3EC54007D2233C"](f338_arg0)
		if f338_local0 and f338_local0.fetched and f338_local0.achieved then
			f338_arg1._nextActivationTime = f338_local0.nextActivationTime
			if f338_arg1._refreshTimer then
				f338_arg1._refreshTimer:close()
				f338_arg1._refreshTimer = nil
			end
			f338_arg1._refreshTimer = LUI.UITimer.newElementTimer(500, false, function(f340_arg0)
				local f340_local0 = CoD.BlackMarketUtility.GetTierSkipRootModel(f338_arg0)
				local f340_local1 = f340_local0.remainingTimeString
				if Engine.GetSecondsRemainingServer(f338_arg1._nextActivationTime) > 0 then
					f340_local1:set(LuaUtils.SecondsToTimeRemainingString(Engine.GetSecondsRemainingServer(f338_arg1._nextActivationTime)))
				else
					f340_local1:set("")
					UpdateState(f338_arg1, {
						name = "update_state",
						controller = f338_arg0,
					})
				end
			end)
			f338_arg1:addElement(f338_arg1._refreshTimer)
			return true
		end
	end
	return false
end
CoD.BlackMarketUtility.HasFocusedTierValue = function(f341_arg0, f341_arg1)
	if Engine[@"isdevelopmentbuild"]() and (CoD.BlackMarketUtility.FillBackfill() or CoD.BlackMarketUtility.FillContrabandDropNumber() > 0 or IsBooleanDvarSet(@"hash_DDC9E66934FFDAB")) then
		return true
	end
	local f341_local0 = Engine.GetModelForController(f341_arg0)
	f341_local0 = f341_local0.FocusedTier
	if f341_local0 then
		local f341_local1 = f341_local0:get() or 0
		local f341_local2 = f341_local1 + 4
		local f341_local3 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f341_arg0)
		if CoD.BlackMarketUtility.IsEventActive() then
			local f341_local4 = CoD.BlackMarketUtility.GetEventName()
			if f341_local4 ~= 0x0 and not Engine[@"hash_7D2AC9EFD614FC94"](f341_arg0, f341_local4, 1) then
				Engine[0x165DC7DAA0794C](f341_arg0, f341_local4, 1)
				return false
			end
		end
		if f341_local3 < f341_local1 then
			return true
		end
		for f341_local4 = f341_local1, f341_local2, 1 do
			if f341_local4 <= f341_local3 and not Engine[@"hash_7D2AC9EFD614FC94"](f341_arg0, CoDShared.Loot.GetCurrentSeason(), f341_local4) then
				Engine[0x165DC7DAA0794C](f341_arg0, CoDShared.Loot.GetCurrentSeason(), f341_local1)
				return false
			end
		end
	end
	local f341_local1 = Engine.GetModelForController(f341_arg0)
	f341_local1 = f341_local1:create("LootStreamProgress", true)
	if f341_local1 then
		local f341_local2 = f341_local1:create("pagedRequestStatus", true)
		f341_local2:set("Valid")
	end
	return true
end
CoD.BlackMarketUtility.GetFocusedTierValue = function(f342_arg0, f342_arg1)
	if Engine[@"isdevelopmentbuild"]() and (CoD.BlackMarketUtility.FillBackfill() or CoD.BlackMarketUtility.FillContrabandDropNumber() > 0 or IsBooleanDvarSet(@"hash_DDC9E66934FFDAB")) then
		return
	end
	local f342_local0 = Engine.GetModelForController(f342_arg0)
	f342_local0 = f342_local0.FocusedTier
	if f342_local0 then
		local f342_local1 = f342_local0:get() or 0
		local f342_local2 = f342_local1 + 4
		local f342_local3 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f342_arg0)
		if CoD.BlackMarketUtility.IsEventActive() then
			local f342_local4 = CoD.BlackMarketUtility.GetEventName()
			if f342_local4 ~= 0x0 and not Engine[@"hash_7D2AC9EFD614FC94"](f342_arg0, f342_local4, 1) then
				Engine[0x165DC7DAA0794C](f342_arg0, f342_local4, 1)
				return
			end
		end
		if f342_local3 < f342_local1 then
			return
		end
		for f342_local4 = f342_local1, f342_local2, 1 do
			if f342_local4 <= f342_local3 and not Engine[@"hash_7D2AC9EFD614FC94"](f342_arg0, CoDShared.Loot.GetCurrentSeason(), f342_local4) then
				Engine[0x165DC7DAA0794C](f342_arg0, CoDShared.Loot.GetCurrentSeason(), f342_local1)
				return
			end
		end
	end
end
CoD.BlackMarketUtility.InitializeLootStreamTier = function(f343_arg0, f343_arg1)
	local f343_local0 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f343_arg0)
	local f343_local1 = CoDShared.Loot.GetCurrentSeason()
	if not Engine[@"hash_7D2AC9EFD614FC94"](f343_arg0, f343_local1, f343_local0) then
		Engine[0x165DC7DAA0794C](f343_arg0, f343_local1, f343_local0)
	end
end
CoD.BlackMarketUtility.UpdateSupplyChainFocus = function(f344_arg0, f344_arg1)
	if CoD.perController[f344_arg0].ignoreResetFocusToFirstSelectable then
		CoD.perController[f344_arg0].ignoreResetFocusToFirstSelectable = false
		return
	else
		f344_arg1:getFirstSelectableItem(true)
	end
end
CoD.BlackMarketUtility.GetCurrentBlackMarketSeasonName = function(f345_arg0)
	local f345_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	local f345_local1
	if f345_local0 then
		f345_local1 = f345_local0[@"contracttitle"]
		if not f345_local1 then
		else
			return f345_local1
		end
	end
	f345_local1 = 0x0
end
CoD.BlackMarketUtility.IsCurrentLootSeasonAtLeast = function(f346_arg0)
	return f346_arg0 <= (CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER) or 0)
end
CoD.BlackMarketUtility.AppendCurrentSeasonTier = function(f347_arg0)
	local f347_local0 = f347_arg0
	if 0 < f347_local0 then
		return ConvertToUpperString(Engine[@"hash_4F9F1239CFD921FE"](@"menu/tier", tostring(f347_local0)))
	else
		return LocalizeToUpperString(@"menu/tier_single")
	end
end
CoD.BlackMarketUtility.GetCurrentBlackMarketSeasonIconSmall = function(f348_arg0)
	local f348_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	local f348_local1
	if f348_local0 then
		f348_local1 = f348_local0.contracticonsmall
		if not f348_local1 then
		else
			return f348_local1
		end
	end
	f348_local1 = 0x0
end
CoD.BlackMarketUtility.GetCurrentBlackMarketBannerImage = function(f349_arg0)
	local f349_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	local f349_local1
	if f349_local0 then
		f349_local1 = f349_local0[@"bannerimage"]
		if not f349_local1 then
		else
			return f349_local1
		end
	end
	f349_local1 = 0x0
end
CoD.BlackMarketUtility.GetHalloweenBannerText = function(f350_arg0)
	if Engine[@"converttoxhash"](Dvar[@"hash_3A7588CE8BBBC25D"]:get()) == "loot_contract_halloween" then
		return @"hash_2B81B691A5FAA21D"
	else
		return 0x0
	end
end
CoD.BlackMarketUtility.GetCurrentBlackMarketBannerString = function(f351_arg0)
	if f351_arg0 == 0x0 or f351_arg0 == "" then
		local f351_local0 = CoD.ContractUtility.GetPurchasableContractHashes()
		if f351_local0 and #f351_local0 > 0 then
			return LocalizeToUpperString(@"menu/contracts") .. "\n" .. LocalizeToUpperString(CoD.ContractUtility.GetContractDisplayNameRef(f351_local0[1]))
		else
			return ""
		end
	end
	local f351_local0 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
	if not f351_local0 then
		return ""
	end
	local f351_local1 = Engine[@"hash_4F9F1239CFD921FE"](f351_local0[@"bannerstring"] or 0x0)
	if f351_local0[@"hash_121909CA2BFCBE53"] and f351_local0[@"hash_121909CA2BFCBE53"] ~= 0x0 then
		f351_local1 = f351_local1 .. "\n" .. Engine[@"hash_4F9F1239CFD921FE"](f351_local0[@"hash_121909CA2BFCBE53"])
	end
	return f351_local1
end
CoD.BlackMarketUtility.GetSeasonTimerString = function(f352_arg0, f352_arg1)
	if f352_arg1 == "" then
		return ""
	elseif CoDShared.Loot.GetSeasonInfoParam("loot_season_8", CoDShared.Loot.SEASON_INFO_NUMBER) <= CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER) then
		return ""
	elseif CoD.BlackMarketUtility.GetCurrentSeasonTier(f352_arg0) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_8ED6F54FD6EE676", f352_arg1)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0CE2452CF87DB1", f352_arg1)
	end
end
CoD.BlackMarketUtility.AdjustColorIfTierBoost = function(f353_arg0, f353_arg1, f353_arg2, f353_arg3)
	if not IsTierBoostActive(f353_arg0) then
		return f353_arg1, f353_arg2, f353_arg3
	else
		return 0.56, 0.32, 0.91
	end
end
CoD.BlackMarketUtility.GetSpecialDealConfirmationTitle = function(f354_arg0)
	local f354_local0 = tonumber(f354_arg0)
	if f354_local0 and f354_local0 > 0 then
		return @"hash_44789CA9E60FD91D"
	else
		return @"hash_68CCB8B7EF76929B"
	end
end
CoD.BlackMarketUtility.ShowPostseasonPopup = function(f355_arg0, f355_arg1, f355_arg2)
	local f355_local0 = Engine.StorageGetBuffer(f355_arg1, Enum.StorageFileType[@"storage_mp_stats_online"])
	if CoD.BlackMarketUtility.GetCurrentSeasonTier(f355_arg1) >= CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers() and f355_local0 and f355_local0.loot_seasonCompletedPopup and f355_local0.loot_seasonCompletedPopup[CoD.BlackMarketUtility.GetCurrentSeasonPostSeasonStat()]:get() == 0 then
		OpenOverlay(f355_arg0, "PostSeasonPopup", f355_arg1, f355_arg2)
		f355_local0.loot_seasonCompletedPopup[CoD.BlackMarketUtility.GetCurrentSeasonPostSeasonStat()]:set(1)
		Engine.StorageWrite(f355_arg1, Enum.StorageFileType[@"storage_mp_stats_online"])
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowAllRNGPopup = function(f356_arg0, f356_arg1, f356_arg2)
	local f356_local0 = Engine.StorageGetBuffer(f356_arg1, Enum.StorageFileType[@"storage_mp_stats_online"])
	if CoD.SafeGetModelValue(Engine.GetModelForController(f356_arg1), "LootStreamProgress.allRngUnlocked") == true then
		local f356_local1 = CoDShared.Loot.GetCurrentSeason()
		if f356_local0 and f356_local0.loot_allRNGPopup then
			local f356_local2 = f356_local0.loot_allRNGPopup[CoD.BlackMarketUtility.GetCurrentAllRNGStat()]
			if f356_local2 and f356_local2:get() == 0 then
				OpenOverlay(f356_arg0, "AllRNGPopup", f356_arg1)
				f356_local2:set(1)
				Engine.StorageWrite(f356_arg1, Enum.StorageFileType[@"storage_mp_stats_online"])
				return true
			end
		end
	end
	return false
end
CoD.BlackMarketUtility.CreatePersistentPagedRequestModel = function(f357_arg0)
	local f357_local0 = Engine.GetModelForController(f357_arg0)
	f357_local0 = f357_local0:create("LootStreamProgress", true)
	if f357_local0 then
		f357_local0:create("pagedRequestStatus", true)
		CoD.BlackMarketUtility.UpdateAllRngUnlockedModel(f357_arg0)
	end
end
CoD.BlackMarketUtility.UpdateAllRngUnlockedModel = function(f358_arg0)
	CoDShared.Loot.UpdateAllRNGUnlockedModel(f358_arg0)
end
CoD.BlackMarketUtility.PlayBlackMarketFrontendMusic = function(f359_arg0, f359_arg1)
	CoD.PlayFrontendMusic("menu_bm")
	LUI.OverrideFunction_CallOriginalSecond(f359_arg0, "close", function(element)
		local f360_local0 = CoD.SafeGetModelValue(Engine.GetGlobalModel(), "lobbyRoot.lobbyNav")
		if f360_local0 then
			CoD.PlayFrontendMusicForLobby(f360_local0)
		end
	end)
end
CoD.BlackMarketUtility.PlayItemShopSelectSound = function(f361_arg0, f361_arg1)
	local f361_local0 = CoD.SafeGetModelValue(f361_arg0:getModel(), "rarity")
	if f361_local0 == Enum.LootRarityType[@"loot_rarity_type_rare"] then
		f361_arg0:playSound("focus_rare", f361_arg1)
	elseif f361_local0 == Enum.LootRarityType[@"loot_rarity_type_legendary"] then
		f361_arg0:playSound("focus_legendary", f361_arg1)
	elseif f361_local0 == Enum.LootRarityType[@"loot_rarity_type_epic"] then
		f361_arg0:playSound("focus_epic", f361_arg1)
	elseif f361_local0 == Enum.LootRarityType[@"hash_63006FE890A202D9"] then
		f361_arg0:playSound("focus_ultra", f361_arg1)
	else
		f361_arg0:playSound("focus_common", f361_arg1)
	end
end
CoD.BlackMarketUtility.CopySignatureWeaponProperty = function(f362_arg0, f362_arg1, f362_arg2)
	if f362_arg1.contractModels and f362_arg1.contractModels.signatureWeaponInfo then
		f362_arg2.signatureWeaponInfo = f362_arg1.contractModels.signatureWeaponInfo
	else
		f362_arg2.signatureWeaponInfo = nil
	end
end
CoD.BlackMarketUtility.SpecialDealTitle = function(f363_arg0, f363_arg1)
	local f363_local0 = Engine[@"getdvarstring"]("ui_specialDealTitle")
	if f363_local0 then
		return Engine.Localize(f363_local0)
	else
		return ""
	end
end
CoD.BlackMarketUtility.SpecialDealDesc = function(f364_arg0, f364_arg1)
	local f364_local0 = Engine[@"getdvarstring"]("ui_specialDealDesc")
	if f364_local0 then
		return Engine.Localize(f364_local0)
	else
		return ""
	end
end
CoD.BlackMarketUtility.SpecialDealImage = function(f365_arg0)
	local f365_local0 = Engine[@"getdvarstring"]("ui_specialDealImage")
	if f365_local0 then
		return f365_local0
	else
		return "blacktransparent"
	end
end
CoD.BlackMarketUtility.IsMenuOccluded = function(f366_arg0)
	return f366_arg0.occludedBy ~= nil
end
CoD.BlackMarketUtility.SetHighlightedPurchaseTierForSpecialDeal = function(f367_arg0, f367_arg1, f367_arg2)
	local f367_local0 = Engine.GetGlobalModel()
	f367_local0 = f367_local0:create("ItemShop")
	local f367_local1 = Engine.GetModelForController(f367_arg0)
	if CoD.SafeGetModelValue(f367_local1, "LootStreamProgress.playAnimation") == true then
		local f367_local2 = f367_local1:create("LootStreamProgress.playAnimation")
		f367_local2:set(false)
	end
	local f367_local2 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f367_arg0)
	local f367_local3 = f367_arg2:getModel()
	f367_local3 = f367_local2 + f367_local3.tiers:get() or 0
	local f367_local4 = f367_local0:create("HighlightedTier")
	f367_local4:set(f367_local3)
	local f367_local5 = {}
	for f367_local6 = f367_local2 + 1, f367_local3, 1 do
		table.insert(f367_local5, f367_local6)
	end
	if #f367_local5 == 0 then
		table.insert(f367_local5, f367_local2 + 1)
	end
	f367_arg1.purchaseTiers = f367_local5
end
CoD.BlackMarketUtility.SpecialDealAction = function(f368_arg0, f368_arg1, f368_arg2, f368_arg3)
	CoD.BlackMarketUtility.SetHighlightedPurchaseTierForSpecialDeal(f368_arg2, f368_arg3, f368_arg1)
	local f368_local0 = f368_arg1:getModel()
	f368_local0 = f368_local0:create("entryPoint")
	f368_local0:set("button")
	OpenPopup(f368_arg3.Frame.framedWidget, "SpecialDealConfirmation", f368_arg2, {
		_model = f368_arg1:getModel(),
	})
end
DataSources.SpecialDealPurchaseList = ListHelper_SetupDataSource("SpecialDealPurchaseList", function(f369_arg0, f369_arg1)
	local f369_local0 = Engine.GetGlobalModel()
	local f369_local1 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f369_arg0)
	local f369_local2 = {}
	local f369_local3 = 0
	local f369_local4 = "0"
	local f369_local5 = 0
	local f369_local6 = f369_arg1.menu
	if f369_local6 then
		local f369_local7 = f369_local6:getModel()
		if f369_local7 then
			f369_local3 = f369_local7.tiers:get()
			f369_local4 = f369_local7.skuID:get()
			f369_local5 = f369_local7.price:get()
		end
	end
	if f369_local3 > 1 then
		table.insert(f369_local2, {
			displayText = @"hash_74CEFD5951498C2B",
			action = CoD.BlackMarketUtility.PurchaseSpecialDeal,
			tierRef = @"hash_3E874E7281061241",
			params = {
				controller = f369_arg0,
				tiers = f369_local3,
				refocus = false,
				skuID = f369_local4,
			},
			tiersToBuy = f369_local3,
			price = f369_local5,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f369_local5),
		})
	elseif f369_local3 <= 0 then
		f369_local3 = 1
		table.insert(f369_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseSpecialDeal,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f369_arg0,
				tiers = 1,
				refocus = true,
				skuID = f369_local4,
			},
			tiersToBuy = f369_local1 + 1,
			price = f369_local5,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f369_local5),
		})
	else
		f369_local3 = 1
		table.insert(f369_local2, {
			displayText = @"hash_157138D494A114A2",
			action = CoD.BlackMarketUtility.PurchaseSpecialDeal,
			tierRef = @"hash_544F1ACF71037F65",
			params = {
				controller = f369_arg0,
				tiers = 1,
				refocus = false,
				skuID = CoD.BlackMarketUtility.GetPaidTierSku(),
			},
			tiersToBuy = f369_local1 + 1,
			price = f369_local5,
			priceRef = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f369_local5),
		})
	end
	local f369_local7 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f369_arg0)
	InitDataSourceModel(f369_arg0, "TierPurchase")
	local f369_local8 = {}
	for f369_local12, f369_local13 in ipairs(f369_local2) do
		table.insert(f369_local8, {
			models = {
				displayText = Engine.Localize(f369_local13.displayText),
				tiersToBuy = f369_local13.tiersToBuy,
				price = f369_local13.price,
				tierRef = f369_local13.tierRef,
				priceRef = f369_local13.priceRef,
			},
			properties = {
				action = f369_local13.action,
				actionParam = f369_local13.params,
			},
		})
	end
	return f369_local8
end)
CoD.BlackMarketUtility.OpenSpecialDealBribeCrate = function(f370_arg0, f370_arg1, f370_arg2, f370_arg3)
	local f370_local0 = function()
		local f371_local0 = GoBack(f370_arg2, f370_arg1)
		if f371_local0.id == "Menu.ItemShopDetails" then
			f371_local0 = GoBack(f371_local0, f370_arg1)
		end
		f371_local0._tab = "reserves"
		local f371_local1 = Engine.ForceNotifyModelSubscriptions
		local f371_local2 = Engine.GetModelForController(f370_arg1)
		f371_local1(f371_local2:create("QuarterMasterTabUpdate"))
		CoD.BlackMarketUtility.TriggerOpenBribeSequence(f370_arg1, f371_local0, f370_arg3)
	end
	if CoD.isPC then
		CoD.PCUtility.DisplayPrePurchasePopup(f370_local0, f370_arg0, f370_arg1, {
			dwSKUElement = f370_arg0,
		}, function(f372_arg0)
			f370_arg0:setState(f372_arg0, "DefaultState")
		end)
	else
		f370_local0()
	end
end
CoD.BlackMarketUtility.TriggerOpenBribeSequence = function(f373_arg0, f373_arg1, f373_arg2)
	if CoD.BlackMarketUtility.OpenBribe(f373_arg0, tonumber(f373_arg2.crateType)) then
		OpenOverlay(f373_arg1, "BlackjackReserveReveal", f373_arg0, {
			_model = nil,
		})
	end
end
CoD.BlackMarketUtility.OpenNonCPBribe = function(f374_arg0, f374_arg1)
	local f374_local0 = GoBack(f374_arg1, f374_arg0)
	if f374_arg1._isOtherBlackMarketTab then
		f374_local0._tab = "reserves"
		local f374_local1 = Engine.ForceNotifyModelSubscriptions
		local f374_local2 = Engine.GetModelForController(f374_arg0)
		f374_local1(f374_local2:create("QuarterMasterTabUpdate"))
	end
	CoDShared.Loot.ClearRNGModels(f374_arg0)
	CoD.BlackMarketUtility.RedeemNonCPLootBribe(f374_arg0, f374_arg1._bribeName)
	local f374_local1 = DataSources.ReservesLootPurchaseCase.getModel(f374_arg0)
	for f374_local5, f374_local6 in ipairs(CoDShared.Loot.Crates) do
		if f374_arg1._bribeName == f374_local6 and f374_local6 ~= "no_dupe_crate" then
			f374_local1 = DataSources.ReservesLootBundleCrate.getModel(f374_arg0)
		end
	end
	if f374_arg1._isReservesRevealMenu then
		f374_local2 = Engine.GetModelForController(f374_arg0)
		f374_local2 = f374_local2:create("reservesRevealComplete")
		f374_local2:set(false)
		if f374_local0:getModel() ~= f374_local1 then
			f374_local0:setModel(f374_local1, f374_arg0)
		end
	else
		OpenOverlay(f374_local0, "BlackjackReserveReveal", f374_arg0, {
			_model = f374_local1,
		})
	end
end
CoD.BlackMarketUtility.GetBribeAsset = function(f375_arg0, f375_arg1)
	local f375_local0 = 0x0
	local f375_local1 = 0x0
	local f375_local2 = 0x0
	local f375_local3 = 0x0
	local f375_local4 = 0x0
	local f375_local5 = 0x0
	local f375_local6 = 0x0
	local f375_local7 = ""
	local f375_local8 = Engine[@"hash_2E00B2F29271C60B"](f375_arg1)
	if f375_local8 then
		if f375_local8[@"previewimage"] then
			f375_local0 = f375_local8[@"previewimage"]
		end
		if f375_local8[@"popupimage"] then
			f375_local1 = f375_local8[@"popupimage"]
		end
		if f375_local8[@"buttonimage"] then
			f375_local2 = f375_local8[@"buttonimage"]
		end
		if f375_local8[@"stackimage"] then
			f375_local3 = f375_local8[@"stackimage"]
		end
		if f375_local8.stacktallimage then
			f375_local4 = f375_local8.stacktallimage
		end
		if f375_local8[@"nametext"] then
			f375_local6 = f375_local8[@"nametext"]
		end
		if f375_local8[@"desctext"] then
			f375_local7 = Engine[@"hash_4F9F1239CFD921FE"](f375_local8[@"desctext"])
		end
		return {
			primaryImage = f375_local0,
			popupImage = f375_local1,
			buttonImage = f375_local2,
			stackImage = f375_local3,
			stackTallImage = f375_local4,
			name = f375_local6,
			desc = f375_local7,
			category = "mpui/bm_bribe",
		}
	else
		return nil
	end
end
DataSources.BribeListItem = ListHelper_SetupDataSource("BribeListItem", function(f376_arg0, f376_arg1)
	local f376_local0 = {}
	for f376_local5, f376_local6 in ipairs(CoD.BlackMarketTableUtility.GetAllBribes(f376_arg0)) do
		local f376_local7 = CoD.BlackMarketUtility.GetBribeAsset(f376_arg0, f376_local6)
		if f376_local7 then
			local f376_local4 = CoD.BlackMarketTableUtility.GetBribeInformation(f376_arg0, f376_local6)
			if f376_local4 and f376_local4.canPurchase then
				f376_local7.crateType = f376_local4.lootRule
				f376_local7.canPurchase = f376_local4.canPurchase
				f376_local7.price = f376_local4.price
				table.insert(f376_local0, {
					models = f376_local7,
				})
			end
		end
	end
	return f376_local0
end)
CoD.BlackMarketUtility.PurchaseSpecialDeal = function(f377_arg0, f377_arg1, f377_arg2, f377_arg3)
	if f377_arg0.FullscreenPopupTemplate then
		if f377_arg0.FullscreenPopupTemplate.currentState ~= "DefaultState" then
			return
		end
	elseif f377_arg0.currentState ~= "DefaultState" then
		return
	end
	if not CanPurchaseItem(f377_arg2, f377_arg1) then
		OpenPopup(f377_arg0, "PurchaseCodPoints", f377_arg2, f377_arg1:getModel())
		return
	elseif CoD.SafeGetModelValue(Engine.GetModelForController(f377_arg2), "LootStreamProgress.allRngUnlocked") then
		local f377_local0 = false
		for f377_local4, f377_local5 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f377_arg2)) do
			if f377_local5.id > 0 and not CoD.ContractUtility.IsContractComplete(f377_arg2, f377_local5.id) then
				f377_local0 = true
			end
		end
		if not f377_local0 and not f377_arg3.triplePlay then
			f377_arg0:setState(f377_arg2, "ErrorState")
			return
		end
	end
	if Engine[0x2E671B86427DC1](f377_arg2) ~= 0 then
		if f377_arg0.FullscreenPopupTemplate then
			f377_arg0.FullscreenPopupTemplate:setState(f377_arg2, "ErrorState")
		else
			f377_arg0:setState(f377_arg2, "ErrorState")
		end
		return
	elseif f377_arg0.FullscreenPopupTemplate then
		f377_arg0.FullscreenPopupTemplate:setState(f377_arg2, "WorkingState")
	else
		f377_arg0:setState(f377_arg2, "WorkingState")
	end
	local f377_local6 = f377_arg0:getMenu()
	if f377_local6 then
		UpdateButtonPromptState(f377_local6, f377_arg0, f377_arg2, Enum.LUIButton[@"lui_key_xba_pscross"])
		if f377_local6.CratePurchaseTip then
			f377_local6.CratePurchaseTip:setAlpha(0)
		end
	end
	local f377_local1 = function()
		local f378_local0 = f377_arg0:getMenu()
		if f378_local0 then
			UpdateButtonPromptState(f378_local0, f377_arg0, f377_arg2, Enum.LUIButton[@"lui_key_xbb_pscircle"])
		end
		local f378_local1 = Engine.GetModelForController(f377_arg2)
		f378_local1 = f378_local1:create("LootStreamProgress", true)
		if f378_local1 then
			local f378_local2 = f378_local1:create("itemsEarned", true)
			f378_local2:set(0)
		end
		Engine[@"hash_29EF65378FF2525E"](f377_arg2, f377_arg3.skuID)
		if not f377_arg0.purchaseTimer then
			f377_arg0.purchaseTimer = LUI.UITimer.newElementTimer(500, false, function()
				if not Engine.IsInventoryBusy(f377_arg2) and Engine.GetPurchaseDWSKUResult(f377_arg2) ~= Enum.InventoryPurchaseResult[@"inventory_purchase_result_inprogress"] then
					if Engine.GetPurchaseDWSKUResult(f377_arg2) == Enum.InventoryPurchaseResult[@"inventory_purchase_result_success"] then
						if f377_arg0.FullscreenPopupTemplate then
							f377_arg0.FullscreenPopupTemplate:setState(f377_arg2, "FinishedState")
						else
							f377_arg0:setState(f377_arg2, "FinishedState")
						end
						if not f377_arg3.triplePlay then
							CoD.MetricsUtility.BlackMarketTierPurchasedEvent(f377_arg2, "button", true, 1)
						end
						local f379_local0 = f377_arg0:getMenu()
						f379_local0:setState(f377_arg2, "UnlockingTiers")
						UpdateButtonPromptState(f379_local0, f377_arg0, f377_arg2, Enum.LUIButton[@"lui_key_xbb_pscircle"])
						local f379_local1 = f379_local0:getModel()
						local f379_local2 = Engine[0x2E671B86427DC1](f377_arg2)
						if f379_local1 then
							local f379_local3 = f379_local1:create("tiersLeft")
							f379_local3:set(f379_local2)
						end
						f377_arg0.redeemTiersTimer = LUI.UITimer.newElementTimer(500, false, function()
							local f380_local0 = f377_arg0:getMenu()
							local f380_local1 = f380_local0:getModel()
							local f380_local2 = Engine[0x2E671B86427DC1](f377_arg2)
							if f380_local2 >= 0 then
								if f380_local1 then
									local f380_local3 = f380_local1:create("tiersLeft")
									f380_local3:set(f380_local2)
								end
								if f380_local2 == 0 and not Engine[@"hash_65B26799D9CD0B8"]() then
									if f377_arg3.refocus then
										SetFocusedTierModelValue(f377_arg2, "0", "")
									end
									f377_arg0.redeemTiersTimer:close()
									f377_arg0.redeemTiersTimer = nil
									SetFocusedTierModelValue(f377_arg2, "0", "")
									local f380_local3 = Engine.GetModelForController(f377_arg2)
									local f380_local4 = f380_local3:create("LootStreamProgress.playAnimation")
									f380_local4:set(true)
									CoD.BlackMarketUtility.UpdateAllRngUnlockedModel(f377_arg2)
									if f377_arg3.triplePlay then
										SetPerControllerTableProperty(f377_arg2, "redeemingTierBundleItem", true)
									end
									f380_local4 = f380_local0
									if f377_arg3.goBackMultiple then
										f380_local4 = GoBack(f380_local4, f377_arg2)
									end
									if not CoD.BlackMarketUtility.ShowPostseasonPopup(f380_local4, f377_arg2, f377_arg3) and not CoD.BlackMarketUtility.ShowAllRNGPopup(f380_local4, f377_arg2, f377_arg3) then
										ClearMenuSavedState(f380_local4.occludedMenu)
										f380_local4 = GoBack(f380_local4, f377_arg2)
										if f380_local4 then
											if f380_local4._currentTab ~= "supplychain" then
												f380_local4._tab = "supplychain"
												local f380_local5 = Engine.ForceNotifyModelSubscriptions
												local f380_local6 = Engine.GetModelForController(f377_arg2)
												f380_local5(f380_local6:create("QuarterMasterTabUpdate"))
											end
											f380_local4._purchaseSpecialDealDelayTimer = LUI.UITimer.newElementTimer(0, true, function()
												if f380_local4._purchaseSpecialDealDelayTimer then
													f380_local4._purchaseSpecialDealDelayTimer:close()
													f380_local4._purchaseSpecialDealDelayTimer = nil
												end
												local f381_local0 = f380_local4.Frame
												if f381_local0 then
													local f381_local1 = CoD.BlackMarketUtility.GetSupplyChainItemList(f381_local0.framedWidget)
													local f381_local2 = f381_local1:getFirstSelectableItem(true)
													if f381_local2 then
														f381_local2:centerFreeCursorOnElement(f377_arg2)
														local f381_local3 = f381_local2:getModel()
														if not f381_local3.playAnim:set(true) then
															f381_local3 = f381_local2:getModel()
															f381_local3.playAnim:forceNotifySubscriptions()
														end
													end
													SetElementModelToFocusedElementModel(f377_arg2, f381_local0.framedWidget, f381_local1, "SupplyChainDetails")
												end
												if f377_arg3.triplePlay then
													SetPerControllerTableProperty(f377_arg2, "redeemingTierBundleItem", false)
													if f380_local3.playContrabandReveal then
														f380_local3.playContrabandReveal:set(true)
													end
												end
											end)
											f380_local4:addElement(f380_local4._purchaseSpecialDealDelayTimer)
										end
									end
								end
							end
						end)
						f377_arg0:addElement(f377_arg0.redeemTiersTimer)
					else
						f377_arg0:setState(f377_arg2, "ErrorState")
					end
					f377_arg0.purchaseTimer:close()
					f377_arg0.purchaseTimer = nil
				end
			end)
			f377_arg0:addElement(f377_arg0.purchaseTimer)
		end
	end
	if CoD.isPC then
		local f377_local2 = function(f382_arg0)
			if f377_arg0.FullscreenPopupTemplate then
				f377_arg0.FullscreenPopupTemplate:setState(f382_arg0, "DefaultState")
			else
				f377_arg0:setState(f382_arg0, "DefaultState")
			end
		end
		if f377_local6.id == "Menu.SpecialDealConfirmation" then
			local f377_local7 = f377_local6
		end
		CoD.PCUtility.DisplayPrePurchasePopup(f377_local1, f377_arg0, f377_arg2, {
			dwSKUElement = f377_local7 or f377_arg0,
		}, f377_local2)
	else
		f377_local1()
	end
end
CoD.BlackMarketUtility.UpdateReservesItemCounts = function(f383_arg0)
	if DataSources.ReservesItemCounts then
		DataSources.ReservesItemCounts.getModel(f383_arg0)
	end
end
CoD.BlackMarketUtility.SetQuarterMasterMenuCurrentTab = function(f384_arg0, f384_arg1, f384_arg2)
	local f384_local0 = f384_arg0:getModel(f384_arg1, "category")
	local f384_local1 = f384_local0 and f384_local0:get()
	if f384_local1 then
		f384_arg2._currentTab = f384_local1
	end
end
DataSources.ReserveDealsList = ListHelper_SetupDataSource(
	"ReserveDealsList",
	function(f385_arg0, f385_arg1)
		local f385_local0 = {}
		if not CoD.BlackMarketUtility.AreCoDPointsEnabled() then
			return f385_local0
		end
		local f385_local1 = CoD.BlackMarketUtility.ReserveDeals
		table.sort(f385_local1, function(f386_arg0, f386_arg1)
			return Engine[@"isgreaterthan"](f386_arg0.start, f386_arg1.start)
		end)
		local f385_local2 = {}
		local f385_local3 = {}
		for f385_local13, f385_local14 in ipairs(f385_local1) do
			local f385_local15 = Engine[@"converttoxhash"](f385_local14.name)
			local f385_local16 = CoDShared.LootIndexInfoLookup(f385_local15)
			local f385_local7 = nil
			local f385_local17 = CoD.BlackMarketTableUtility.GetItemShopInformation(f385_arg0, f385_local14.name)
			if f385_local17 and f385_local16 then
				f385_local7 = CoD.BlackMarketUtility.GetItemShopDatasourceModelValues(f385_arg0, f385_local17)
				if f385_local7 then
					if f385_local16.category == "bribe" then
						for f385_local11, f385_local12 in pairs(CoD.BlackMarketUtility.GetBribeAsset(f385_arg0, f385_local15)) do
							f385_local7[f385_local11] = f385_local12
						end
						f385_local7.discountList = true
					elseif f385_local16.category == "special_bundle" then
						for f385_local11, f385_local12 in pairs(CoD.BlackMarketUtility.GetSpecialBundleInfo(f385_arg0, f385_local15)) do
							f385_local7[f385_local11] = f385_local12
						end
						f385_local7.discountList = true
					end
					f385_local7.stringName = f385_local14.name
					if f385_local7.purchased ~= true then
						table.insert(f385_local2, f385_local7)
					else
						table.insert(f385_local3, f385_local7)
					end
				end
			end
		end
		for f385_local13, f385_local14 in ipairs(f385_local3) do
			table.insert(f385_local2, f385_local14)
		end
		f385_local4 = Engine.CreateModel(Engine.GetGlobalModel(), "ReserveDealsRotation")
		for f385_local5 = 1, #f385_local2, 1 do
			local f385_local15, f385_local16 = CoD.BlackMarketUtility.GetItemProductAndProperties(f385_local2[f385_local5])
			f385_local15.stackPosition = f385_local5
			f385_local15.stackTotal = #f385_local2
			f385_local15.timer = f385_local2[f385_local5].stringName
			table.insert(f385_local0, {
				models = f385_local15,
				properties = f385_local16,
			})
		end
		if #f385_local0 > 0 then
			f385_local5 = Engine.GetModelForController(f385_arg0)
			f385_local5 = f385_local5:create("reservesSpecialOfferAvailable")
			f385_local5:set(true)
		end
		return f385_local0
	end,
	nil,
	nil,
	function(f387_arg0, f387_arg1, f387_arg2)
		if not f387_arg1.__discountListSubscriptions then
			f387_arg1.__discountListSubscriptions = true
			f387_arg1:subscribeToGlobalModel(f387_arg0, "ReserveDealsRotation", "cycled", function()
				f387_arg1:updateDataSource()
			end)
		end
	end
)
CoD.BlackMarketUtility.GetTimerModelValue = function(f389_arg0, f389_arg1)
	local f389_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "ReserveDealsRotation")
	if f389_arg0 then
		local f389_local1 = f389_arg0.timer
		local f389_local2 = f389_arg0.timer
		local f389_local3 = f389_local0[f389_arg0.timer:get()]:get()
	end
	return f389_local1 and f389_local3 or ""
end
CoD.BlackMarketUtility.GetBribeStackTimerModelValue = function(f390_arg0, f390_arg1)
	local f390_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "BribeStackTimer")
	if f390_arg0 then
		local f390_local1 = f390_arg0.timer
		local f390_local2 = f390_arg0.timer
		local f390_local3 = f390_local0[f390_arg0.timer:get()]:get()
	end
	return f390_local1 and f390_local3 or ""
end
CoD.BlackMarketUtility.GetBribeMenuTimerModelValue = function(f391_arg0, f391_arg1)
	local f391_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "BribeMenuTimer")
	if f391_arg0 then
		local f391_local1 = f391_arg0.timer
		local f391_local2 = f391_arg0.timer
		local f391_local3 = f391_local0[f391_arg0.timer:get()]:get()
	end
	return f391_local1 and f391_local3 or ""
end
DataSources.DiscountList = ListHelper_SetupDataSource(
	"DiscountList",
	function(f392_arg0, f392_arg1)
		local f392_local0 = {}
		if not CoD.BlackMarketUtility.AreCoDPointsEnabled() then
			return f392_local0
		end
		local f392_local1 = f392_arg1.menu._currentTab == "supplychain"
		if not (f392_arg1.menu._currentTab == "reserves") and IsBooleanDvarSet(@"hash_1989C6B82918FBCC") then
			if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
				local f392_local2 = CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues
				table.insert(f392_local0, {
					models = {
						name = f392_local2.name,
						tiers = 0,
						price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7") / 2,
						popupImage = f392_local2.popupImage,
						skuID = "0",
						percentOff = f392_local2.percentOff,
						bundle = "",
						timerModel = 0,
						reservesButton = true,
						purchaseReservesItem = true,
						isCrateItem = true,
						desc = Engine[@"hash_4F9F1239CFD921FE"](f392_local2.desc),
						categoryString = 0x0,
						mainExtraText = "",
						subExtraText = 0x0,
						discountIndx = 0,
						openCrate = 0,
						bundleTitleRef = f392_local2.name,
						bundleImage = f392_local2.buttonImage,
						toolTipText = 0x0,
					},
				})
			else
				local f392_local2 = CoD.BlackMarketUtility.LootPurchaseCrateModelValues
				table.insert(f392_local0, {
					models = {
						name = f392_local2.name,
						tiers = 0,
						price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"),
						popupImage = f392_local2.popupImage,
						skuID = "0",
						percentOff = f392_local2.percentOff,
						bundle = "",
						timerModel = 0,
						reservesButton = true,
						purchaseReservesItem = true,
						isCrateItem = true,
						desc = Engine[@"hash_4F9F1239CFD921FE"](f392_local2.desc),
						categoryString = 0x0,
						mainExtraText = "",
						subExtraText = 0x0,
						discountIndx = 0,
						openCrate = 0,
						bundleTitleRef = f392_local2.name,
						bundleImage = f392_local2.buttonImage,
						toolTipText = 0x0,
					},
				})
			end
		end
		return f392_local0
	end,
	nil,
	nil,
	function(f393_arg0, f393_arg1, f393_arg2)
		if not f393_arg1.__discountListSubscriptions then
			f393_arg1.__discountListSubscriptions = true
			f393_arg1:subscribeToGlobalModel(f393_arg0, "AutoEvents", "cycled", function()
				f393_arg1:updateDataSource()
			end)
		end
	end
)
CoD.BlackMarketUtility.ShowFreeBundlePopupIfNeeded = function(f395_arg0, f395_arg1)
	local f395_local0 = IsBooleanDvarSet(@"hash_220494C24B5CE9B0")
	if f395_local0 then
		f395_local0 = Dvar.loot_tier_discount_free_skuID:get() and not CoD.BlackMarketUtility.IsItemPurchased(f395_arg1, Dvar.loot_tier_discount_free_skuID:get())
	end
	if f395_local0 then
		InitDataSourceModel(f395_arg1, "FreeBundle")
		local f395_local1 = DataSources.FreeBundle.recreate(f395_arg1)
		local f395_local2 = {
			_closeAndGoBack = false,
		}
		if f395_local1 then
			DelayOpenOverlay(f395_arg0, "ItemShopConfirmation", f395_arg1, {
				_model = f395_local1,
				_properties = f395_local2,
			})
			local f395_local3 = Engine.GetModelForController(f395_arg1)
			local f395_local4 = f395_local3:create("LootStreamProgress.playAnimation")
			f395_local4:set(false)
		end
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("FreeBundle", "FreeBundle", function(f396_arg0, f396_arg1)
	if IsBooleanDvarSet(@"hash_220494C24B5CE9B0") then
		local f396_local0 = Engine[@"converttoxhash"](Dvar.loot_tier_discount_free_bundle:get())
		local f396_local1 = CoD.BlackMarketUtility.GetSpecialBundleInfo(f396_arg1, f396_local0)
		if f396_local1 then
			local f396_local2 = f396_arg0:create("name")
			f396_local2:set(f396_local1.name)
			f396_local2 = f396_arg0:create("desc")
			f396_local2:set(f396_local1.desc)
			f396_local2 = f396_arg0:create("primaryImage")
			f396_local2:set(f396_local1.primaryImage)
			f396_local2 = f396_arg0:create("itemCategory")
			f396_local2:set("special_bundle")
			f396_local2 = f396_arg0:create("skuID")
			f396_local2:set(Dvar[@"hash_13CC625DF35C3B6"]:get() or "0")
			f396_local2 = f396_arg0:create("percentOff")
			f396_local2:set(0)
			f396_local2 = f396_arg0:create("hashName")
			f396_local2:set(f396_local0)
			f396_local2 = f396_arg0:create("purchased")
			f396_local2:set(false)
			f396_local2 = f396_arg0:create("totalRewardCount")
			f396_local2:set(1)
			f396_local2 = f396_arg0:create("includesTiers")
			f396_local2:set(false)
			f396_local2 = f396_arg0:create("openCrate")
			f396_local2:set(tonumber(Dvar[@"hash_A404E7DECECAA0A"]:get()) or 0)
		end
	end
end, false)
CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount = function(f397_arg0)
	local f397_local0 = 0
	for f397_local4, f397_local5 in pairs(CoDShared.Loot.CrateCosts) do
		f397_local0 = f397_local0 + Engine[@"hash_5352DC095BBB2A45"](f397_arg0, f397_local5.id)
	end
	return f397_local0
end
CoD.BlackMarketUtility.GetLootBribeOwnedCount = function(f398_arg0)
	local f398_local0 = 0
	for f398_local10, f398_local11 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f398_arg0)) do
		if CoD.BlackMarketUtility.GetBribeAsset(f398_arg0, f398_local11.name) then
			local f398_local4 = true
			for f398_local8, f398_local9 in ipairs(CoDShared.Loot.Cases) do
				if f398_local11.name == f398_local9 then
					f398_local4 = false
				end
			end
			for f398_local8, f398_local9 in ipairs(CoDShared.Loot.Crates) do
				if f398_local11.name == f398_local9 then
					f398_local4 = false
				end
			end
			if f398_local4 then
				f398_local0 = f398_local0 + f398_local11.nonCpQuantity
			end
		end
	end
	return f398_local0
end
CoD.BlackMarketUtility.OpenCrateByCurrency = function(f399_arg0, f399_arg1)
	local f399_local0 = 0
	local f399_local1 = Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") and "half_off_crate" or "crate"
	for f399_local6, f399_local7 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableCPBribes(f399_arg0)) do
		if f399_local7.name == f399_local1 then
			f399_local0 = f399_local7.lootRule
			local f399_local5 = Engine[@"hash_26C232D7031CE1CF"](f399_arg0, f399_local0, CoDShared.Loot.GetBribePayload(f399_arg0, f399_local7.currency, f399_local0))
			Engine.SendClientScriptNotify(f399_arg0, "BlackJackReserve", {
				status = "OpenCrate",
				crateId = "1001",
				result = f399_local5,
			})
			return f399_local5 == 1
		end
	end
	return false
end
CoD.BlackMarketUtility.OpenNoDupeCrateWithCases = function(f400_arg0)
	local f400_local0 = 0
	for f400_local5, f400_local6 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f400_arg0)) do
		if f400_local6.name == "no_dupe_crate" then
			f400_local0 = f400_local6.lootRule
			local f400_local4 = Engine[@"hash_26C232D7031CE1CF"](f400_arg0, f400_local0, CoDShared.Loot.GetBribePayload(f400_arg0, f400_local6.currency, f400_local0))
			Engine.SendClientScriptNotify(f400_arg0, "BlackJackReserve", {
				status = "OpenCrate",
				crateId = "1001",
				result = f400_local4,
			})
			return f400_local4 == 1
		end
	end
	return false
end
CoD.BlackMarketUtility.OpenBribe = function(f401_arg0, f401_arg1, f401_arg2)
	local f401_local0 = Engine[@"hash_26C232D7031CE1CF"](f401_arg0, f401_arg1, CoDShared.Loot.GetBribePayload(f401_arg0, f401_arg2, f401_arg1))
	Engine.SendClientScriptNotify(f401_arg0, "BlackJackReserve", {
		status = "OpenCrate",
		crateId = "1001",
		result = f401_local0,
	})
	return f401_local0 == 1
end
CoD.BlackMarketUtility.OpenBlackjackReservesAndItemPurchaseOverlay = function(f402_arg0, f402_arg1, f402_arg2, f402_arg3, f402_arg4)
	if not Engine.IsUserGuest(f402_arg2) then
		OpenOverlay(f402_arg4, "QuarterMasterMenu", f402_arg2, {
			_tab = "reserves",
			_itemPurchaseId = f402_arg3,
		})
	end
end
CoD.BlackMarketUtility.LootPurchaseCaseModelValues = {
	name = 0x0,
	price = 0,
	desc = 0x0,
	isBundleCrate = false,
	isCrateItem = false,
	primaryImage = "blacktransparent",
	popupImage = "blacktransparent",
}
CoD.BlackMarketUtility.LootPurchaseCrateModelValues = {
	name = @"hash_683A7EF42505FCE5",
	desc = 0x439483603981EF,
	isCrateItem = true,
	image = "ui_icon_blackmarket_reserves_crate_large_square",
	primaryImage = "uie_ui_menu_blackmarket_blackjack_single_crate",
	popupImage = "ui_icon_blackmarket_reserves_crate_large",
	buttonImage = @"hash_2703EE51FECA8823",
	percentOff = 0,
}
CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues = {
	name = @"hash_683A7EF42505FCE5",
	desc = 0x439483603981EF,
	isCrateItem = true,
	image = "ui_icon_blackmarket_reserves_crate_large_square",
	primaryImage = @"hash_2C9248138678C017",
	popupImage = "ui_icon_blackmarket_reserves_crate_large",
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
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
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
		primaryImage = "ui_icon_blackmarket_reserves_bundle_crates_5",
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_5_confirm",
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
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
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
		primaryImage = "ui_icon_blackmarket_reserves_bundle_crates_10",
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
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
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
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
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
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
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_5_confirm",
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
		popupImage = "ui_icon_blackmarket_reserves_bundle_crates_10_confirm",
		isCrateItem = false,
		isReservesLootPurchaseCrateBundle = true,
		skuId = 500410,
		price = 2000,
		percentOff = 0,
	},
}
DataSources.ReservesItemCounts = {
	subscriptions = {},
	getModel = function(f403_arg0)
		local f403_local0 = Engine.GetModelForController(f403_arg0)
		local f403_local1 = f403_local0:create("ReservesItemCounts")
		local f403_local2 = IsLootReady(f403_arg0)
		local f403_local3
		if f403_local2 then
			f403_local3 = CoDShared.Loot.GetLootCaseOwnedCount(f403_arg0)
			if not f403_local3 then
			else
				local f403_local4 = f403_local1:create("lootCaseCount")
				f403_local4:set(f403_local3)
				local f403_local5
				if f403_local2 then
					f403_local5 = CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f403_arg0)
					if not f403_local5 then
					else
						local f403_local6 = f403_local1:create("lootBundleCrateCount")
						f403_local6:set(f403_local5)
						if f403_local2 then
							f403_local6 = CoD.BlackMarketUtility.GetLootBribeOwnedCount(f403_arg0)
							if not f403_local6 then
							else
								local f403_local7 = f403_local1:create("lootBribeCount")
								f403_local7:set(f403_local6)
								if not DataSources.ReservesItemCounts.subscriptions[f403_arg0] then
									DataSources.ReservesItemCounts.subscriptions[f403_arg0] = LUI.UIElement.new()
									f403_local7 = f403_local0.LootStreamProgress
									if f403_local7 then
										f403_local7 = f403_local0.LootStreamProgress.currentTier
									end
									if f403_local7 then
										DataSources.ReservesItemCounts.subscriptions[f403_arg0]:subscribeToModel(f403_local7, function(model)
											Engine.ForceNotifyModelSubscriptions(f403_local4)
										end, false)
									end
								end
								return f403_local1
							end
						end
						f403_local6 = -1
					end
				end
				f403_local5 = -1
			end
		end
		f403_local3 = -1
	end,
}
DataSources.SpecialOrderTierBoostAlpha = {
	getModel = function(f405_arg0)
		local f405_local0 = Engine.GetModelForController(f405_arg0)
		f405_local0 = f405_local0:create("SpecialOrderTierBoostAlpha")
		local f405_local1 = 0
		if CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent(f405_arg0, nil) then
			f405_local1 = 100
		end
		local f405_local2 = f405_local0:create("alpha")
		f405_local2:set(f405_local1)
		return f405_local0
	end,
}
DataSources.TierBoostPercent = {
	getModel = function(f406_arg0)
		local f406_local0 = Engine.GetModelForController(f406_arg0)
		f406_local0 = f406_local0:create("TierBoostPercent")
		local f406_local1 = CoDShared.Loot.GetCurrentTierBoost(f406_arg0) or 0
		local f406_local2 = f406_local0:create("boost_amount")
		f406_local2:set(f406_local1)
		f406_local2 = Dvar[@"hash_5B23C92E3E72DF30"]:get()
		local f406_local3 = f406_local0:create("specialorder_boost_amount")
		f406_local3:set(f406_local2)
		return f406_local0
	end,
}
DataSources.ReservesLootPurchaseCase = {
	prepare = function(f407_arg0)
		local f407_local0 = Engine.GetModelForController(f407_arg0)
		f407_local0 = f407_local0:create("ReservesLootPurchaseCase")
		for f407_local4, f407_local5 in pairs(CoD.BlackMarketUtility.LootPurchaseCaseModelValues) do
			local f407_local6 = f407_local0:create(f407_local4)
			f407_local6:set(f407_local5)
		end
		return f407_local0
	end,
	getModel = function(f408_arg0)
		local f408_local0 = Engine.GetModelForController(f408_arg0)
		f408_local0 = f408_local0.ReservesLootPurchaseCase
		if not f408_local0 then
			f408_local0 = DataSources.ReservesLootPurchaseCase.prepare(f408_arg0)
		end
		return f408_local0
	end,
}
CoD.BlackMarketUtility.NoDupePriceString = function(f409_arg0, f409_arg1)
	local f409_local0 = tonumber(CoD.SafeGetModelValue(f409_arg0, "currency"))
	if f409_local0 and f409_local0 == CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID then
		return LocalizeIntoString(@"hash_79CBD79D3C8A2BED", f409_arg1)
	else
		return LocalizeIntoString(@"hash_27AD54B6F8C27799", f409_arg1)
	end
end
CoD.BlackMarketUtility.NoDupeTitleString = function(f410_arg0, f410_arg1, f410_arg2)
	if CoD.BlackMarketUtility.CanPurchaseNoDupeCrate(f410_arg1, f410_arg0) then
		return LocalizeIntoString(@"hash_663FCD1B0849669E", f410_arg2)
	else
		return LocalizeIntoString(@"hash_16F86EB73F5E0A4C", f410_arg2)
	end
end
CoD.BlackMarketUtility.CanPurchaseNoDupeCrate = function(f411_arg0, f411_arg1)
	local f411_local0 = tonumber(CoD.SafeGetModelValue(f411_arg1:getModel(), "casePrice"))
	local f411_local1 = tonumber(CoD.SafeGetModelValue(f411_arg1:getModel(), "currency"))
	if f411_local0 and f411_local1 and f411_local1 ~= CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID then
		return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f411_arg0, "ReservesItemCounts", "lootCaseCount", f411_local0)
	else
		return false
	end
end
CoD.BlackMarketUtility.AttemptPurchaseNoDupeCrate = function(f412_arg0, f412_arg1, f412_arg2, f412_arg3)
	local f412_local0 = GoBack(f412_arg3, f412_arg2)
	if f412_arg3._isOtherBlackMarketTab then
		f412_local0._tab = "reserves"
		local f412_local1 = Engine.ForceNotifyModelSubscriptions
		local f412_local2 = Engine.GetModelForController(f412_arg2)
		f412_local1(f412_local2:create("QuarterMasterTabUpdate"))
	end
	CoD.BlackMarketUtility.OpenNoDupeCrateWithCases(f412_arg2)
	CoDShared.Loot.ClearRNGModels(f412_arg2)
	if f412_arg3._isReservesRevealMenu then
		local f412_local1 = Engine.GetModelForController(f412_arg2)
		f412_local1 = f412_local1:create("reservesRevealComplete")
		f412_local1:set(false)
		if f412_local0:getModel() ~= DataSources.ReservesNoDupesCrate.getModel(f412_arg2) then
			f412_local0:setModel(DataSources.ReservesNoDupesCrate.getModel(f412_arg2), f412_arg2)
		end
	else
		OpenOverlay(f412_local0, "BlackjackReserveReveal", f412_arg2, {
			_model = DataSources.ReservesNoDupesCrate.getModel(f412_arg2),
		})
	end
end
CoD.BlackMarketUtility.AttemptPurchaseBribeStack = function(f413_arg0, f413_arg1, f413_arg2, f413_arg3)
	local f413_local0 = GoBack(f413_arg3, f413_arg2)
	if f413_arg3._isOtherBlackMarketTab then
		f413_local0._tab = "reserves"
		local f413_local1 = Engine.ForceNotifyModelSubscriptions
		local f413_local2 = Engine.GetModelForController(f413_arg2)
		f413_local1(f413_local2:create("QuarterMasterTabUpdate"))
	end
	CoD.BlackMarketUtility.OpenNoDupeCrateWithCases(f413_arg2)
	CoDShared.Loot.ClearRNGModels(f413_arg2)
	if f413_arg3._isReservesRevealMenu then
		local f413_local1 = Engine.GetModelForController(f413_arg2)
		f413_local1 = f413_local1:create("reservesRevealComplete")
		f413_local1:set(false)
		if f413_local0:getModel() ~= DataSources.ReservesNoDupesCrate.getModel(f413_arg2) then
			f413_local0:setModel(DataSources.ReservesNoDupesCrate.getModel(f413_arg2), f413_arg2)
		end
	else
		OpenOverlay(f413_local0, "BlackjackReserveReveal", f413_arg2, {
			_model = DataSources.ReservesNoDupesCrate.getModel(f413_arg2),
		})
	end
end
DataSources.ReservesNoDupesCrate = {
	prepare = function(f414_arg0)
		local f414_local0 = Engine.GetModelForController(f414_arg0)
		f414_local0 = f414_local0:create("ReservesNoDupesCrate")
		local f414_local1 = CoD.BlackMarketUtility.GetBribeAsset(f414_arg0, "no_dupe_crate")
		if f414_local1 then
			local f414_local2 = f414_local0:create("name")
			f414_local2:set(f414_local1.name or 0x0)
			f414_local2 = f414_local0:create("desc")
			f414_local2:set(f414_local1.desc or 0x0)
			f414_local2 = f414_local0:create("popupImage")
			f414_local2:set(f414_local1.popupImage or "blacktransparent")
			f414_local2 = f414_local0:create("primaryImage")
			f414_local2:set(f414_local1.primaryImage or "blacktransparent")
			f414_local2 = CoD.BlackMarketTableUtility.GetBribeInformation(f414_arg0, "no_dupe_crate")
			if f414_local2 then
				local f414_local3 = f414_local0:create("price")
				f414_local3:set(f414_local2.price or 0)
				f414_local3 = f414_local0:create("currency")
				local f414_local4 = f414_local3
				f414_local3 = f414_local3.set
				local f414_local5 = f414_local2.currency
				if not f414_local5 then
					f414_local5 = CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID
				end
				f414_local3(f414_local4, f414_local5)
				f414_local3 = f414_local0:create("canPurchase")
				f414_local3:set(f414_local2.canPurchase or false)
			end
		end
		local f414_local2 = f414_local0:create("isBundleCrate")
		f414_local2:set(false)
		f414_local2 = f414_local0:create("isCrateItem")
		f414_local2:set(false)
		return f414_local0
	end,
	getModel = function(f415_arg0)
		local f415_local0 = Engine.GetModelForController(f415_arg0)
		f415_local0 = f415_local0.ReservesNoDupesCrate
		if not f415_local0 then
			f415_local0 = DataSources.ReservesNoDupesCrate.prepare(f415_arg0)
		end
		return f415_local0
	end,
}
DataSources.ReservesLootPurchaseCrate = {
	prepare = function(f416_arg0)
		local f416_local0 = Engine.GetModelForController(f416_arg0)
		f416_local0 = f416_local0:create("ReservesLootPurchaseCrate")
		if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
			for f416_local4, f416_local5 in pairs(CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues) do
				local f416_local6 = f416_local0:create(f416_local4)
				f416_local6:set(f416_local5)
			end
		else
			for f416_local4, f416_local5 in pairs(CoD.BlackMarketUtility.LootPurchaseCrateModelValues) do
				local f416_local6 = f416_local0:create(f416_local4)
				f416_local6:set(f416_local5)
			end
		end
		local f416_local1 = f416_local0:create("price")
		f416_local1:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"))
		f416_local1 = f416_local0:create("isBundleCrate")
		f416_local1:set(false)
		return f416_local0
	end,
	getModel = function(f417_arg0)
		local f417_local0 = Engine.GetModelForController(f417_arg0)
		f417_local0 = f417_local0.ReservesLootPurchaseCrate
		if not f417_local0 then
			f417_local0 = DataSources.ReservesLootPurchaseCrate.prepare(f417_arg0)
		end
		return f417_local0
	end,
}
DataSources.ReservesLootBundleCrate = {
	subscriptions = {},
	prepare = function(f418_arg0)
		local f418_local0 = Engine.GetModelForController(f418_arg0)
		f418_local0 = f418_local0:create("ReservesLootBundleCrate")
		if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
			for f418_local4, f418_local5 in pairs(CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues) do
				local f418_local6 = f418_local0:create(f418_local4)
				f418_local6:set(f418_local5)
			end
			f418_local1 = f418_local0:create("price")
			f418_local1:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7") / 2)
		else
			for f418_local4, f418_local5 in pairs(CoD.BlackMarketUtility.LootPurchaseCrateModelValues) do
				local f418_local6 = f418_local0:create(f418_local4)
				f418_local6:set(f418_local5)
			end
			f418_local1 = f418_local0:create("price")
			f418_local1:set(Engine[@"getdvarint"](@"hash_6278F2B45A6906E7"))
		end
		local f418_local1 = f418_local0:create("isBundleCrate")
		f418_local1:set(true)
		return f418_local0
	end,
	getModel = function(f419_arg0)
		local f419_local0 = Engine.GetModelForController(f419_arg0)
		f419_local0 = f419_local0.ReservesLootBundleCrate
		if not f419_local0 then
			f419_local0 = DataSources.ReservesLootBundleCrate.prepare(f419_arg0)
		end
		if not DataSources.ReservesLootBundleCrate.subscriptions[f419_arg0] then
			DataSources.ReservesLootBundleCrate.subscriptions[f419_arg0] = LUI.UIElement.new()
			DataSources.ReservesLootBundleCrate.subscriptions[f419_arg0]:subscribeToGlobalModel(f419_arg0, "AutoEvents", "cycled", function()
				DataSources.ReservesLootBundleCrate.prepare(f419_arg0)
			end)
		end
		return f419_local0
	end,
}
DataSourceHelpers.PerControllerDataSourceSetup("ReservesLootPurchaseCrateBundle", "ReservesLootPurchaseCrateBundle", function(f421_arg0, f421_arg1)
	if IsBooleanDvarSet(@"hash_396CDD0567DE073F") then
		local f421_local0 = Engine[@"getdvarint"](@"hash_3D6C52B2CB5555BD")
		local f421_local1 = Engine[@"getdvarint"](@"hash_7E517CFF26DEE76")
		local f421_local2 = Engine[@"getdvarint"](@"hash_71C4FD1471CC7CC7")
		local f421_local3 = Engine[@"getdvarint"](@"hash_25DC3754B06C6C01")
		local f421_local4 = Engine[@"getdvarstring"]("loot_crateBundleImage")
		local f421_local5 = Engine[@"converttoxhash"](Engine[@"getdvarstring"]("loot_crateBundlePopupImage"))
		local f421_local6 = f421_arg0:create("name")
		f421_local6:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1808C02A0C0BB64D", f421_local0, f421_local1))
		f421_local6 = f421_arg0:create("desc")
		f421_local6:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_630D04B9A9BC6DCC", f421_local0, f421_local1))
		f421_local6 = f421_arg0:create("image")
		local f421_local7 = f421_local6
		f421_local6 = f421_local6.set
		local f421_local8
		if f421_local4 then
			f421_local8 = Engine[@"converttoxhash"](f421_local4)
			if not f421_local8 then
			else
				f421_local6(f421_local7, f421_local8)
				f421_local6 = f421_arg0:create("popupImage")
				f421_local6:set(f421_local5)
				f421_local6 = f421_arg0:create("crateBaseCount")
				f421_local6:set(f421_local0)
				f421_local6 = f421_arg0:create("crateExtraCount")
				f421_local6:set(f421_local1)
				f421_local6 = f421_arg0:create("price")
				f421_local6:set(f421_local2)
				f421_local6 = f421_arg0:create("skuID")
				f421_local6:set(f421_local3)
				f421_local6 = f421_arg0:create("isBundleCrate")
				f421_local6:set(true)
				f421_local6 = f421_arg0:create("isReservesLootPurchaseCrateBundle")
				f421_local6:set(true)
			end
		end
		f421_local8 = nil
	end
end, false)
DataSources.ReservesLootPurchaseItems = ListHelper_SetupDataSource(
	"ReservesLootPurchaseItems",
	function(f422_arg0, f422_arg1)
		local f422_local0 = {}
		for f422_local5, f422_local6 in ipairs(CoD.BlackMarketUtility.CrateBundles) do
			local f422_local4 = IsBooleanDvarSet(f422_local6.dvar)
			if not f422_local4 and f422_local6.expKey and CoD.StoreUtility.GetExperimentModifier(f422_arg0, f422_local6.expKey) == "1" then
				f422_local4 = true
			end
			if f422_local4 and f422_local6.maxQuantity and f422_local6.maxQuantity <= Engine[@"hash_5352DC095BBB2A45"](f422_arg0, f422_local6.skuId) then
				f422_local4 = false
			end
			if f422_local4 then
				table.insert(f422_local0, {
					models = f422_local6,
					properties = {
						itemPurchaseId = "crate",
					},
				})
			end
		end
		if not Engine[@"getdvarbool"](@"hash_1539A350E73051B8") then
			if Engine[@"getdvarbool"](@"hash_59524BBFBADB78CE") then
				f422_local1 = LUI.ShallowCopy(CoD.BlackMarketUtility.HalfOffLootPurchaseCrateModelValues)
				f422_local1.price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7") / 2
				f422_local1.isBundleCrate = false
				f422_local1.name = Engine[@"hash_4F9F1239CFD921FE"](f422_local1.name)
				f422_local1.desc = Engine[@"hash_4F9F1239CFD921FE"](f422_local1.desc)
				table.insert(f422_local0, {
					models = f422_local1,
					properties = {
						itemPurchaseId = "crate",
					},
				})
			else
				f422_local1 = LUI.ShallowCopy(CoD.BlackMarketUtility.LootPurchaseCrateModelValues)
				f422_local1.price = Engine[@"getdvarint"](@"hash_6278F2B45A6906E7")
				f422_local1.isBundleCrate = false
				f422_local1.name = Engine[@"hash_4F9F1239CFD921FE"](f422_local1.name)
				f422_local1.desc = Engine[@"hash_4F9F1239CFD921FE"](f422_local1.desc)
				table.insert(f422_local0, {
					models = f422_local1,
					properties = {
						itemPurchaseId = "crate",
					},
				})
			end
		end
		for f422_local5, f422_local6 in ipairs(CoD.BlackMarketUtility.CrateBundles) do
			if not IsBooleanDvarSet(f422_local6.dvar) and f422_local6.expKey and (f422_local6.expKey == "convenienceBundleOn" or f422_local6.expKey == "exp10And2BundleOn") then
				local f422_local4 = CoD.StoreUtility.GetExperimentModifier(f422_arg0, f422_local6.expKey)
				if f422_local4 == "2" then
					table.insert(f422_local0, 1, {
						models = f422_local6,
						properties = {
							itemPurchaseId = "crate",
						},
					})
				end
				if f422_local4 == "3" then
					table.insert(f422_local0, {
						models = f422_local6,
						properties = {
							itemPurchaseId = "crate",
						},
					})
				end
			end
		end
		return f422_local0
	end,
	nil,
	nil,
	function(f423_arg0, f423_arg1, f423_arg2)
		if not f423_arg1.__crateBundleSubscriptions then
			f423_arg1.__crateBundleSubscriptions = true
			f423_arg1:subscribeToGlobalModel(f423_arg0, "AutoEvents", "cycled", function()
				f423_arg1:updateDataSource()
			end, false)
		end
	end
)
DataSources.PurchaseReservesItemButtons = ListHelper_SetupDataSource("PurchaseReservesItemButtons", function(f425_arg0, f425_arg1)
	local f425_local0 = ""
	local f425_local1 = 0
	local f425_local2 = "blacktransparent"
	local f425_local3 = "0"
	local f425_local4 = false
	local f425_local5 = false
	local f425_local6 = false
	local f425_local7 = false
	if f425_arg1.menu and f425_arg1.menu.FullscreenPopupTemplate then
		f425_local7 = f425_arg1.menu.FullscreenPopupTemplate.currentState == "FinishedState"
	end
	local f425_local8 = f425_arg1.menu
	if f425_local8 then
		f425_local8 = f425_arg1.menu:getModel()
	end
	if f425_local8 then
		if f425_local8.name then
			f425_local0 = f425_local8.name:get() or f425_local0
		end
		if f425_local8.price then
			f425_local1 = f425_local8.price:get() or f425_local1
		end
		if f425_local8.popupImage then
			f425_local2 = f425_local8.popupImage:get() or f425_local2
		end
		if f425_local8.skuID then
			f425_local3 = f425_local8.skuID:get() or f425_local3
		end
		if f425_local8.isCrateItem then
			f425_local4 = f425_local8.isCrateItem:get() or f425_local4
		end
		if f425_local8.isReservesLootPurchaseCrateBundle then
			local f425_local9 = f425_local8.isReservesLootPurchaseCrateBundle:get()
		end
		f425_local5 = f425_local9 or f425_local8.itemIsReservesLootPurchaseCrateBundle
	end
	local f425_local10 = function(f426_arg0, f426_arg1, f426_arg2, f426_arg3, f426_arg4)
		local f426_local0 = f426_arg3 or {}
		local f426_local1 = function()
			if not f425_local7 and f425_local3 ~= "0" and not f426_local0.isCrateItem and not f426_local0.isReservesLootPurchaseCrateBundle then
				SetWorkingStateAndPurchaseDWSKU(f426_arg0, f426_arg1, f426_arg2, f425_local6)
			else
				local f427_local0 = GoBack(f426_arg4, f426_arg2)
				if f427_local0 and f427_local0._currentTab then
					CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f426_arg2, f427_local0._currentTab, true)
				else
					CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f426_arg2, "quickPurchase", true)
				end
				if f426_arg4._isOtherBlackMarketTab then
					f427_local0._tab = "reserves"
					local f427_local1 = Engine.ForceNotifyModelSubscriptions
					local f427_local2 = Engine.GetModelForController(f426_arg2)
					f427_local1(f427_local2:create("QuarterMasterTabUpdate"))
				end
				CoDShared.Loot.ClearRNGModels(f426_arg2)
				if f426_local0.isBundleCrate then
					CoD.BlackMarketUtility.RedeemLootBundleCrate(f426_arg2)
					f425_local8 = DataSources.ReservesLootBundleCrate.getModel(f426_arg2)
				elseif f426_local0.isCrateItem then
					CoD.BlackMarketUtility.PurchaseLootCrate(f426_arg2)
				end
				if f426_arg4._isReservesRevealMenu then
					local f427_local1 = Engine.GetModelForController(f426_arg2)
					f427_local1 = f427_local1:create("reservesRevealComplete")
					f427_local1:set(false)
					if f427_local0:getModel() ~= f425_local8 then
						f427_local0:setModel(f425_local8, f426_arg2)
					end
				else
					OpenOverlay(f427_local0, "BlackjackReserveReveal", f426_arg2, {
						_model = f425_local8,
					})
				end
			end
		end
		if CoD.isPC then
			CoD.PCUtility.DisplayPrePurchasePopup(f426_local1, f426_arg4, f426_arg2, {
				lootCrateElement = f426_arg1,
			}, function(f428_arg0)
				f426_arg0:setState(f428_arg0, "DefaultState")
			end)
			f425_local6 = true
		else
			f426_local1()
		end
	end
	local f425_local11 = function(f429_arg0, f429_arg1, f429_arg2, f429_arg3, f429_arg4)
		CoD.BlackMarketUtility.SendPurchaseReservesEvent(f429_arg2, f429_arg4)
		GoBack(f429_arg4, f429_arg2)
	end
	local f425_local12 = false
	local f425_local13 = {}
	if not f425_local7 then
		table.insert(f425_local13, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4D7958D4F60AF758", f425_local1),
			action = f425_local10,
			params = {
				isCrateItem = f425_local4,
			},
			selectIndex = false,
		})
	end
	local f425_local14 = CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f425_arg0)
	if f425_local14 > 0 then
		local f425_local15 = false
		if f425_local7 then
			f425_local15 = true
			f425_local12 = true
		end
		table.insert(f425_local13, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_BD06AD4757160DF", f425_local14),
			action = f425_local10,
			params = {
				isBundleCrate = true,
				isReservesLootPurchaseCrateBundle = f425_local5,
			},
			selectIndex = f425_local15,
		})
	end
	if not CoD.isPC then
		table.insert(f425_local13, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/cancel"),
			action = f425_local11,
			selectIndex = not f425_local12,
		})
		f425_local12 = true
	end
	local f425_local15 = {}
	for f425_local19, f425_local20 in ipairs(f425_local13) do
		table.insert(f425_local15, {
			models = {
				displayText = f425_local20.displayText,
				itemName = f425_local0,
				itemPrice = f425_local1,
				itemImage = f425_local2,
			},
			properties = {
				action = f425_local20.action,
				actionParam = f425_local20.params,
				selectIndex = f425_local20.selectIndex,
			},
		})
	end
	return f425_local15
end, true)
DataSources.PurchaseBribeStackButtons = ListHelper_SetupDataSource("PurchaseBribeStackButtons", function(f430_arg0, f430_arg1)
	local f430_local0 = ""
	local f430_local1 = 0
	local f430_local2 = 0
	local f430_local3 = "blacktransparent"
	local f430_local4 = "0"
	local f430_local5 = 0
	local f430_local6 = false
	local f430_local7 = false
	local f430_local8 = 0x0
	local f430_local9 = false
	local f430_local10 = false
	if f430_arg1.menu and f430_arg1.menu.FullscreenPopupTemplate then
		f430_local10 = f430_arg1.menu.FullscreenPopupTemplate.currentState == "FinishedState"
	end
	local f430_local11 = f430_arg1.menu
	if f430_local11 then
		f430_local11 = f430_arg1.menu:getModel()
	end
	if f430_local11 then
		if f430_local11.name then
			f430_local0 = f430_local11.name:get() or f430_local0
		end
		if f430_local11.price then
			f430_local1 = f430_local11.price:get() or f430_local1
		end
		if f430_local11.casePrice then
			f430_local2 = f430_local11.casePrice:get() or f430_local2
		end
		if f430_local11.popupImage then
			f430_local3 = f430_local11.popupImage:get() or f430_local3
		end
		if f430_local11.lootRule then
			f430_local5 = f430_local11.lootRule:get() or f430_local5
		end
		if f430_local11.isReservesLootPurchaseCrateBundle then
			local f430_local12 = f430_local11.isReservesLootPurchaseCrateBundle:get()
		end
		f430_local6 = f430_local12 or f430_local11.itemIsReservesLootPurchaseCrateBundle
		if f430_local11.hashName then
			f430_local8 = f430_local11.hashName:get() or f430_local8
		end
		if f430_local11.isWeaponBribeSelect then
			f430_local9 = f430_local11.isWeaponBribeSelect:get() or f430_local9
		end
	end
	local f430_local13 = function(f431_arg0, f431_arg1, f431_arg2, f431_arg3, f431_arg4)
		local f431_local0 = f431_arg3 or {}
		local f431_local1 = function()
			if CoD.BlackMarketUtility.CrateId == 0 then
				GoBack(f431_arg4, f431_arg2)
				return
			end
			local f432_local0 = CoD.BlackMarketUtility.CrateId
			local f432_local1 = CoD.BlackMarketUtility.CostId
			CoD.BlackMarketUtility.CostId = "0"
			CoD.BlackMarketUtility.CrateId = 0
			if f432_local1 == tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) then
				CoD.BlackMarketUtility.SendItemShopViewEvent(f431_arg2, f431_arg4, "purchased")
			else
				CoD.BlackMarketUtility.SendItemShopViewEvent(f431_arg2, f431_arg4, "exchange")
			end
			local f432_local2 = GoBack(f431_arg4, f431_arg2)
			if f431_arg4._isWeaponBribeSelect then
				f432_local2 = GoBack(f432_local2, f431_arg2)
			end
			if f431_arg4._isOtherBlackMarketTab or f431_arg4._isWeaponBribeSelect then
				f432_local2._tab = "reserves"
				local f432_local3 = Engine.ForceNotifyModelSubscriptions
				local f432_local4 = Engine.GetModelForController(f431_arg2)
				f432_local3(f432_local4:create("QuarterMasterTabUpdate"))
			end
			CoDShared.Loot.ClearRNGModels(f431_arg2)
			CoD.BlackMarketUtility.OpenBribe(f431_arg2, f432_local0, f432_local1)
			if f431_arg4._isReservesRevealMenu then
				local f432_local3 = Engine.GetModelForController(f431_arg2)
				f432_local3 = f432_local3:create("reservesRevealComplete")
				f432_local3:set(false)
				if f432_local2:getModel() ~= f430_local11 then
					f432_local2:setModel(f430_local11, f431_arg2)
				end
			else
				OpenOverlay(f432_local2, "BlackjackReserveReveal", f431_arg2, {
					_model = f430_local11,
				})
			end
		end
		CoD.BlackMarketUtility.CrateId = f431_local0.crateId
		CoD.BlackMarketUtility.CostId = f431_local0.costId
		if CoD.isPC then
			CoD.PCUtility.DisplayPrePurchasePopup(f431_local1, f431_arg4, f431_arg2, {
				lootCrateElement = f431_arg1,
			}, function(f433_arg0)
				f431_arg0:setState(f433_arg0, "DefaultState")
			end)
			f430_local7 = true
		else
			f431_local1()
		end
	end
	local f430_local14 = function(f434_arg0, f434_arg1, f434_arg2, f434_arg3, f434_arg4)
		local f434_local0 = f434_arg3 or {}
		local f434_local1 = f434_arg4:getModel()
		local f434_local2 = GoBack(f434_arg4, f434_arg2)
		if f434_local2 and f434_local2._currentTab then
			CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f434_arg2, f434_local2._currentTab, true)
		else
			CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f434_arg2, "quickPurchase", true)
		end
		OpenPopup(f434_local2, "PurchaseCodPoints", f434_arg2, f434_local1)
	end
	local f430_local15 = function(f435_arg0, f435_arg1, f435_arg2, f435_arg3, f435_arg4)
		CoD.BlackMarketUtility.SendItemShopViewEvent(f435_arg2, f435_arg4, "")
		GoBack(f435_arg4, f435_arg2)
	end
	local f430_local16 = false
	local f430_local17 = {}
	local f430_local18 = function(f436_arg0, f436_arg1, f436_arg2, f436_arg3, f436_arg4)
		if Engine[@"hash_2F40679B550DCCA2"](f436_arg2, CoD.Currencies.COD_POINTS) < f430_local1 then
			f430_local14(f436_arg0, f436_arg1, f436_arg2, f436_arg3, f436_arg4)
		else
			f430_local13(f436_arg0, f436_arg1, f436_arg2, f436_arg3, f436_arg4)
		end
	end
	local f430_local19 = f430_local9 and CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f430_arg0)
	if f430_local19 then
		table.insert(f430_local17, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](0x5284B21C0457567),
			action = f430_local18,
			params = {
				crateId = f430_local5,
				costId = tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID),
			},
			selectIndex = false,
			canPurchase = true,
		})
	end
	if not f430_local19 and f430_local1 > 0 then
		table.insert(f430_local17, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4D7958D4F60AF758", f430_local1),
			action = f430_local18,
			params = {
				crateId = f430_local5,
				costId = tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID),
			},
			selectIndex = false,
			canPurchase = true,
		})
	end
	local f430_local20 = false
	if f430_local2 <= Engine[@"hash_5352DC095BBB2A45"](f430_arg0, tostring(CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID)) then
		f430_local20 = true
	end
	if not f430_local19 and f430_local2 > 0 then
		local f430_local21 = table.insert
		local f430_local22 = f430_local17
		local f430_local23 = {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_126434B8DF70C716", f430_local2),
		}
		if f430_local20 then
			local f430_local24 = f430_local13
		end
		f430_local23.action = f430_local24 or nil
		f430_local23.params = {
			crateId = f430_local5,
			costId = tostring(CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID),
		}
		f430_local23.selectIndex = false
		f430_local23.canPurchase = f430_local20
		f430_local21(f430_local22, f430_local23)
	end
	if not CoD.isPC then
		table.insert(f430_local17, {
			displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/cancel"),
			action = f430_local15,
			selectIndex = not f430_local16,
			canPurchase = true,
		})
		f430_local16 = true
	end
	local f430_local21 = {}
	for f430_local26, f430_local27 in ipairs(f430_local17) do
		table.insert(f430_local21, {
			models = {
				displayText = f430_local27.displayText,
				itemName = f430_local0,
				itemPrice = f430_local1,
				itemImage = f430_local3,
				canPurchase = f430_local27.canPurchase,
			},
			properties = {
				action = f430_local27.action,
				actionParam = f430_local27.params,
				selectIndex = f430_local27.selectIndex,
			},
		})
	end
	return f430_local21
end, true)
DataSources.ReservesSpecialContract = {
	subscriptions = {},
	prepare = function(f437_arg0)
		local f437_local0 = Engine.GetModelForController(f437_arg0)
		f437_local0 = f437_local0:create("ReservesSpecialContract")
		local f437_local1 = false
		local f437_local2 = false
		local f437_local3 = 0x0
		local f437_local4 = 0x0
		local f437_local5 = ""
		local f437_local6 = ""
		local f437_local7 = 0x0
		local f437_local8 = 0x0
		local f437_local9 = "blacktransparent"
		local f437_local10 = 0
		local f437_local11 = ""
		local f437_local12 = ""
		local f437_local13 = ""
		local f437_local14 = "blacktransparent"
		local f437_local15 = Dvar.loot_special_contract_bundle:get()
		local f437_local16 = f437_local15 and Engine[@"converttoxhash"](f437_local15)
		local f437_local17 = f437_local16 and CoD.BlackMarketUtility.GetSpecialBundleInfo(f437_arg0, f437_local16)
		if f437_local17 then
			f437_local1 = true
			f437_local3 = f437_local17.category
			f437_local4 = f437_local17.name
			f437_local5 = f437_local17.desc
			f437_local8 = f437_local17.toolTip
			f437_local6 = f437_local17.specialContractDesc
			f437_local7 = f437_local17.specialContractGoalType
			f437_local14 = f437_local17.specialContractRewardImage
			if f437_local17.reservesImage ~= 0x0 then
				f437_local9 = f437_local17.reservesImage
			end
			local f437_local18 = Engine[@"hash_391AEA655912B0E8"](f437_arg0, f437_local16)
			if f437_local18 and f437_local18.multiProgress then
				for f437_local24, f437_local25 in ipairs(f437_local18.multiProgress) do
					if not (not IsOrbis() or f437_local25.multiProgressName ~= @"hash_53DA67CF93B503F2") or not IsOrbis() and f437_local25.multiProgressName == @"hash_6B607F41F8B8A540" then
						f437_local11 = f437_local25.multiProgress
						f437_local12 = f437_local25.multiProgressTarget
						local f437_local22 = Engine[@"hash_690B6BCE69A8E08B"](f437_local11)
						local f437_local23 = Engine[@"hash_690B6BCE69A8E08B"](f437_local12)
						if f437_local23 <= f437_local22 then
							f437_local11 = f437_local12
							f437_local10 = 1
							f437_local2 = true
							break
						elseif f437_local22 < 0 then
							f437_local11 = "0"
							f437_local10 = 0
							break
						end
						f437_local10 = Engine[@"hash_2431E7E8CD45CA6D"](f437_local22, f437_local23)
					end
				end
			end
			if f437_local17.specialContractGoalUnit ~= 0x0 then
				f437_local13 = Engine[@"hash_4F9F1239CFD921FE"](f437_local17.specialContractGoalUnit, f437_local12)
			end
		end
		local f437_local18 = f437_local0:create("active")
		f437_local18:set(f437_local1)
		f437_local18 = f437_local0:create("complete")
		f437_local18:set(f437_local2)
		f437_local18 = f437_local0:create("categoryString")
		f437_local18:set(f437_local3)
		f437_local18 = f437_local0:create("rewardName")
		f437_local18:set(f437_local4)
		f437_local18 = f437_local0:create("description")
		f437_local18:set(f437_local5)
		f437_local18 = f437_local0:create("toolTip")
		f437_local18:set(f437_local8)
		f437_local18 = f437_local0:create("bundleReservesImage")
		f437_local18:set(f437_local9)
		f437_local18 = f437_local0:create("progress")
		f437_local18:set(f437_local10)
		f437_local18 = f437_local0:create("detailsMenuDesc")
		f437_local18:set(f437_local6)
		f437_local18 = f437_local0:create("detailsMenuGoalType")
		f437_local18:set(f437_local7)
		f437_local18 = f437_local0:create("currentValue")
		f437_local18:set(f437_local11)
		f437_local18 = f437_local0:create("endValue")
		f437_local18:set(Engine[@"hash_BA51654DAB171D"](f437_local12))
		f437_local18 = f437_local0:create("endValuePlusUnits")
		f437_local18:set(f437_local13)
		f437_local18 = f437_local0:create("detailsMenuRewardImage")
		f437_local18:set(f437_local14)
		return f437_local0
	end,
	getModel = function(f438_arg0)
		local f438_local0 = Engine.GetModelForController(f438_arg0)
		f438_local0 = f438_local0.ReservesSpecialContract
		if not f438_local0 then
			f438_local0 = DataSources.ReservesSpecialContract.prepare(f438_arg0)
		end
		if not DataSources.ReservesSpecialContract.subscriptions[f438_arg0] then
			DataSources.ReservesSpecialContract.subscriptions[f438_arg0] = LUI.UIElement.new()
			DataSources.ReservesSpecialContract.subscriptions[f438_arg0]:subscribeToGlobalModel(f438_arg0, "AutoEvents", "cycled", function()
				DataSources.ReservesSpecialContract.prepare(f438_arg0)
			end)
			local f438_local1 = DataSources.ReservesSpecialContract.subscriptions[f438_arg0]
			local f438_local2 = f438_local1
			f438_local1 = f438_local1.subscribeToModel
			local f438_local3 = Engine.GetModelForController(f438_arg0)
			f438_local1(f438_local2, f438_local3:create("achievementStateUpdate"), function()
				DataSources.ReservesSpecialContract.prepare(f438_arg0)
			end)
		end
		return f438_local0
	end,
}
DataSources.DupeMeterPulse = {
	prepare = function(f441_arg0)
		local f441_local0 = Engine.GetModelForController(f441_arg0)
		f441_local0 = f441_local0:create("DupeMeterPulse")
		local f441_local1 = f441_local0:create("pulseDupeIcon")
		f441_local1:set(false)
		f441_local1 = f441_local0:create("pulseRerollIcon")
		f441_local1:set(false)
		return f441_local0
	end,
	getModel = function(f442_arg0)
		local f442_local0 = Engine.GetModelForController(f442_arg0)
		f442_local0 = f442_local0.DupeMeterPulse
		if not f442_local0 then
			f442_local0 = DataSources.DupeMeterPulse.prepare(f442_arg0)
		end
		return f442_local0
	end,
}
CoD.BlackMarketUtility.ReservesSpecialContractAppendCompletion = function(f443_arg0, f443_arg1)
	if f443_arg0.complete and f443_arg0.complete:get() then
		return Engine[@"hash_4F9F1239CFD921FE"]("menu/special_contract_complete", f443_arg1)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_247E99E2B20180F0", f443_arg1)
	end
end
CoD.BlackMarketUtility.SendPurchaseReservesEvent = function(f444_arg0, f444_arg1)
	local f444_local0 = f444_arg1.occludedMenu
	if f444_local0 and f444_local0._currentTab then
		CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f444_arg0, f444_local0._currentTab, false)
	else
		CoD.MetricsUtility.BlackMarketCratePurchasedEvent(f444_arg0, "quickPurchase", false)
	end
end
CoD.BlackMarketUtility.SendPurchaseTiersEvent = function(f445_arg0, f445_arg1)
	local f445_local0 = f445_arg1:getModel()
	if f445_local0 then
		CoD.MetricsUtility.BlackMarketTierPurchasedEvent(f445_arg0, f445_local0.entryPoint and f445_local0.entryPoint:get() or "", false, f445_local0.tiers and f445_local0.tiers:get() or 1)
	end
end
CoD.BlackMarketUtility.SendItemShopViewEvent = function(f446_arg0, f446_arg1, f446_arg2)
	local f446_local0 = f446_arg1.occludedMenu
	if f446_local0.id ~= "Menu.QuarterMasterMenu" then
		f446_local0 = f446_local0.occludedMenu
	end
	local f446_local1 = f446_arg1:getModel()
	if f446_local0 and (f446_local0._currentTab == "itemshop" or f446_local0._currentTab == "supplychain" or f446_local0._currentTab == "reserves") and f446_local1 then
		local f446_local2 = f446_local1.slot and f446_local1.slot:get() or 0
		local f446_local3 = f446_local1.skuId and f446_local1.skuId:get() or 0
		local f446_local4 = f446_local1.price and f446_local1.price:get() or 0
		local f446_local5 = f446_local1.casePrice and f446_local1.casePrice:get() or 0
		local f446_local6 = f446_local1.hashName and f446_local1.hashName:get() or 0x0
		local f446_local7 = f446_arg2
		if f446_local7 == "" then
			f446_local7 = "viewed"
		end
		if f446_local1.purchased and f446_local1.purchased:get() or false and f446_local7 == "viewed" then
			f446_local7 = "owned"
		end
		local f446_local8 = f446_local1.stackPosition and f446_local1.stackPosition:get() or 0
		local f446_local9 = f446_local1.stackTotal and f446_local1.stackTotal:get() or 0
		local f446_local10 = 0
		local f446_local11 = 0
		if IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
			local f446_local12 = Engine.CreateModel(Engine.GetGlobalModel(), "ItemshopRotation")
			if f446_local12 then
				local f446_local13 = f446_local12:create("loot_itemshop_slot" .. tostring(f446_local2) .. "_timer_raw")
				f446_local10 = f446_local13:get()
				f446_local11 = tonumber(CoD.BlackMarketUtility.GetItemShopSunsetSlotRotateTime(f446_arg0, f446_local2))
			end
			f446_local2 = f446_local2 + CoD.BlackMarketUtility.BlackjackShopSlotIndexSunsetOffset
			if not f446_local10 then
				f446_local11 = 0
				local f446_local13 = CoD.BlackMarketTableUtility.GetBribeInformation(f446_arg0, f446_local6)
				if f446_local13 then
					local f446_local14 = Engine.CreateModel(Engine.GetGlobalModel(), "BribeStackTimer")
					if f446_local14 and f446_local14[f446_local13.stringName .. "_raw"] then
						f446_local10 = f446_local14[f446_local13.stringName .. "_raw"]:get()
						f446_local11 = tonumber(CoD.BlackMarketUtility.GetBribeStackWindowSizeSeconds(f446_arg0, f446_local13.stringName))
					end
				else
					local f446_local14 = f446_local1.bribeStringName and f446_local1.bribeStringName:get() or ""
					if CoD.BlackMarketTableUtility.IsBribeMenu(f446_arg0, f446_local14) then
						local f446_local15 = Engine.CreateModel(Engine.GetGlobalModel(), "BribeMenuTimer")
						if f446_local15 and f446_local15.bribe_menu_timer_raw then
							f446_local10 = f446_local15.bribe_menu_timer_raw:get()
							f446_local11 = tonumber(CoD.BlackMarketUtility.GetBribeMenuWindowSizeSeconds(f446_arg0))
							f446_local6 = Engine[@"converttoxhash"](f446_local14)
						end
					end
				end
			end
			if f446_local0._currentTab == "reserves" then
				f446_local2 = f446_local2 + 1
			end
		end
		CoD.MetricsUtility.BlackMarketItemShopEvent(f446_arg0, f446_local2, f446_local7, f446_local3, f446_local6, f446_local8, f446_local9, f446_local10, f446_local11, f446_local4, f446_local5)
	end
end
CoD.BlackMarketUtility.MarkTabAsSeen = function(f447_arg0, f447_arg1)
	if not f447_arg1._entrypoint then
		local f447_local0 = Engine.CurrentSessionMode()
		if f447_local0 == Enum.eModes.mode_zombies then
			f447_arg1._entrypoint = "zombies"
		elseif f447_local0 == Enum.eModes.mode_multiplayer then
			if LuaUtils.IsArenaMode() then
				f447_arg1._entrypoint = "arena"
			else
				f447_arg1._entrypoint = "multiplayer"
			end
		elseif f447_local0 == Enum.eModes.mode_warzone then
			f447_arg1._entrypoint = "warzone"
		else
			f447_arg1._entrypoint = "director"
		end
	end
	if f447_arg1._currentTab then
		if f447_arg1._currentTab == "itemshop" then
			f447_arg1._shop = true
		elseif f447_arg1._currentTab == "reserves" then
			f447_arg1._reserves = true
		elseif f447_arg1._currentTab == "supplychain" then
			f447_arg1._contraband = true
		elseif f447_arg1._currentTab == "inventory" then
			f447_arg1._inventory = true
		end
	end
end
CoD.BlackMarketUtility.GetReservesRevealBlankItemValues = function()
	return {
		name = 0x0,
		desc = "",
		mainExtraText = "",
		subExtraText = 0x0,
		primaryImage = 0x0,
		popupImage = 0x0,
		detailsImage = 0x0,
		category = 0x0,
		shopCategory = 0x0,
		rarity = Enum.LootRarityType[@"loot_rarity_type_count"],
		character = 0x0,
		gesture_index = -1,
		setBonusImage = 0x0,
		setBonusName = 0x0,
		setComplete = false,
		setNumOwned = 0,
		setNumAvailable = 0,
		setNumTotal = 0,
		isContrabandCrate = false,
		isInSet = false,
		isBundle = false,
		itemCategory = 0x0,
		allowTogglePreview = false,
		allowFrozenMoment = false,
		seasonal = false,
		includesTiers = false,
		dupe = false,
		reroll = false,
		revealed = false,
		hasRerolled = false,
		weaponRef = 0x0,
		toolTipText = 0x0,
	}
end
CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn = function(f449_arg0, f449_arg1)
	for f449_local4, f449_local5 in pairs(f449_arg1) do
		if type(f449_local5) == "table" then
			if not f449_arg0[f449_local4] then
				f449_arg0:create(f449_local4)
			end
			CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn(f449_arg0[f449_local4], f449_local5)
		end
		if f449_arg0[f449_local4] then
			f449_arg0[f449_local4]:set(f449_local5)
		else
			local f449_local3 = f449_arg0:create(f449_local4)
			f449_local3:set(f449_local5)
		end
	end
end
CoD.BlackMarketUtility.BlackjackReserveRevealOnCompleteFn = function(f450_arg0, f450_arg1)
	local f450_local0 = Enum.LootRarityType[@"loot_rarity_type_common"]
	local f450_local1 = DataSources.BlackjackReserveRevealList.getCount(f450_arg1)
	for f450_local2 = 1, f450_local1, 1 do
		local f450_local5 = DataSources.BlackjackReserveRevealList.getItem(f450_arg0, f450_arg1, f450_local2)
		local f450_local6 = f450_local5.rarity:get()
		if f450_local0 < f450_local6 then
			f450_local0 = f450_local6
		end
	end
	if f450_local0 == Enum.LootRarityType[@"loot_rarity_type_common"] or f450_local0 == Enum.LootRarityType[@"loot_rarity_type_rare"] then
		PlaySoundAlias("vox_blac_crate_cmmn_rare")
	elseif f450_local0 == Enum.LootRarityType[@"loot_rarity_type_legendary"] then
		PlaySoundAlias("vox_blac_crate_legend")
	elseif f450_local0 == Enum.LootRarityType[@"loot_rarity_type_epic"] then
		PlaySoundAlias("vox_blac_crate_epic")
	elseif f450_local0 == Enum.LootRarityType[@"hash_63006FE890A202D9"] then
		PlaySoundAlias("vox_blac_crate_ult")
	end
	local f450_local2 = Engine.GetModelForController(f450_arg0)
	f450_local2 = f450_local2:create("reservesRevealComplete")
	f450_local2:set(true)
	f450_local2 = DataSources.DupeMeterPulse.getModel(f450_arg0)
	if not f450_local2.pulseDupeIcon:set(f450_arg1._revealDupeCount > 0) then
		Engine.ForceNotifyModelSubscriptions(f450_local2.pulseDupeIcon)
	end
	if not f450_local2.pulseRerollIcon:set(f450_arg1._revealRerollCount > 0) then
		Engine.ForceNotifyModelSubscriptions(f450_local2.pulseRerollIcon)
	end
end
CoD.BlackMarketUtility.BlackjackReserveRevealListCustomSetupFn = function(f451_arg0, f451_arg1, f451_arg2)
	local f451_local0 = f451_arg1.menu
	local f451_local1 = Engine.GetModelForController(f451_arg0)
	local f451_local2 = f451_local1.LootRNGResult.ready
	if not f451_arg1.__reserveRevealListSubscriptions then
		f451_arg1.__reserveRevealListSubscriptions = true
		f451_arg1:subscribeToModel(f451_local2, function(model)
			f451_arg1:updateDataSource()
		end)
	end
	if f451_local2:get() then
		if f451_local0._reservesRevealTimers then
			for f451_local6, f451_local7 in pairs(f451_local0._reservesRevealTimers) do
				if f451_local7 then
					f451_local7:close()
				end
			end
		end
		f451_local0._reservesRevealTimers = {}
		local f451_local3 = CoD.BlackMarketUtility.LootItemRevealInitialDelayMS
		local f451_local4 = CoD.BlackMarketUtility.LootItemRevealPerItemDelayMS
		local f451_local5 = CoD.BlackMarketUtility.LootItemRevealPreRerollDelayMS
		local f451_local6 = CoD.BlackMarketUtility.LootItemRevealRerollDelayMS
		local f451_local7 = CoD.BlackMarketUtility.LootItemRevealFinalDelayMS
		if Engine[@"isdevelopmentbuild"]() then
			if Dvar[@"hash_1F7E25209ABEC8D2"]:exists() then
				f451_local3 = Dvar[@"hash_1F7E25209ABEC8D2"]:get() or f451_local3
			end
			if Dvar[@"hash_73FDC833491511A"]:exists() then
				f451_local4 = Dvar[@"hash_73FDC833491511A"]:get() or f451_local4
			end
			if Dvar[@"hash_76F16E6502004BC3"]:exists() then
				f451_local5 = Dvar[@"hash_76F16E6502004BC3"]:get() or f451_local5
			end
			if Dvar[@"hash_539A0F9D4C50018A"]:exists() then
				f451_local6 = Dvar[@"hash_539A0F9D4C50018A"]:get() or f451_local6
			end
			if Dvar[@"hash_3F722D1F6B7FE27E"]:exists() then
				f451_local7 = Dvar[@"hash_3F722D1F6B7FE27E"]:get() or f451_local7
			end
		end
		if f451_local0._reservesRevealIntroDelayTimeMS then
			f451_local3 = f451_local3 + f451_local0._reservesRevealIntroDelayTimeMS
		end
		local f451_local8 = 0
		local f451_local9 = DataSources.BlackjackReserveRevealList.getCount(f451_arg1)
		for f451_local10 = 1, f451_local9, 1 do
			local f451_local13 = f451_local10
			f451_local0._reservesRevealTimers["listRevealTimer" .. f451_local13] = LUI.UITimer.newElementTimer(f451_local3 + f451_local4 * (f451_local13 - 1) + (f451_local5 + f451_local6) * f451_local8, true, function(f453_arg0)
				local f453_local0 = DataSources.BlackjackReserveRevealList.getItem(f451_arg0, f451_arg1, f451_local13)
				local f453_local1 = f453_local0 and f453_local0.revealed
				if f453_local1 then
					f453_local1:set(true)
				end
			end)
			f451_local0:addElement(f451_local0._reservesRevealTimers["listRevealTimer" .. f451_local13])
			local f451_local14 = DataSources.BlackjackReserveRevealList.getCustomPropertiesForItem(f451_arg1, f451_local13)
			if f451_local14 and f451_local14.rerollItemId then
				f451_local8 = f451_local8 + 1
				f451_local0._reservesRevealTimers.rerollDupeItemTimer = LUI.UITimer.newElementTimer(f451_local3 + f451_local4 * (f451_local13 - 1) + f451_local5 * f451_local8, true, function(f454_arg0)
					local f454_local0 = DataSources.BlackjackReserveRevealList.getItem(f451_arg0, f451_arg1, f451_local13)
					f454_local0.hasRerolled:set(true)
					f454_local0.revealed:set(false)
				end)
				f451_local0._reservesRevealTimers.rerollRevealTimer = LUI.UITimer.newElementTimer(f451_local3 + f451_local4 * (f451_local13 - 1) + (f451_local5 + f451_local6) * f451_local8, true, function(f455_arg0)
					local f455_local0 = DataSources.BlackjackReserveRevealList.getItem(f451_arg0, f451_arg1, f451_local13)
					local f455_local1 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f451_arg0, f451_local14.rerollItemId, 0)
					local f455_local2 = f455_local1 and CoD.BlackMarketUtility.GetItemRefs(f451_arg0, f455_local1.name, f455_local1.category, f455_local1.rarity, f455_local1.inSet, 0, f455_local1.lootType, f455_local1.refOptic, f455_local1.itemId)
					if f455_local2 then
						local f455_local3, f455_local4 = CoD.BlackMarketUtility.GetItemProductAndProperties(f455_local2)
						CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn(f455_local0, f455_local3)
					end
					f455_local0.dupe:set(false)
					f455_local0.reroll:set(true)
					f455_local0.revealed:set(true)
				end)
				f451_local0:addElement(f451_local0._reservesRevealTimers.rerollDupeItemTimer)
				f451_local0:addElement(f451_local0._reservesRevealTimers.rerollRevealTimer)
			end
		end
		f451_local0._reservesRevealTimers.revealCompleteTimer = LUI.UITimer.newElementTimer(f451_local3 + f451_local4 * (f451_local9 - 1) + (f451_local5 + f451_local6) * f451_local8 + f451_local7, true, function(f456_arg0)
			CoD.BlackMarketUtility.BlackjackReserveRevealOnCompleteFn(f451_arg0, f451_arg1)
		end)
		f451_local0:addElement(f451_local0._reservesRevealTimers.revealCompleteTimer)
		local f451_local11 = Engine.GetModelForController(f451_arg0)
		if f451_local11.LootRNGResult.streamId:get() == CoD.BlackMarketUtility.CrateStreams.CASE then
			CoD.BlackMarketUtility.UpdateLootCaseBreadcrumbStatValue(f451_arg0)
			local f451_local12 = DataSources.ReservesItemCounts.getModel(f451_arg0)
			Engine.ForceNotifyModelSubscriptions(f451_local12.lootCaseCount)
		else
		end
	end
end
CoD.BlackMarketUtility.GetEmptyReserveRevealCount = function(f457_arg0)
	local f457_local0 = CoD.BlackMarketUtility.LootItemCountCrate
	local f457_local1 = Engine.GetModelForController(f457_arg0)
	f457_local1 = f457_local1.LootRNGResult.streamId:get()
	if f457_local1 == CoD.BlackMarketUtility.CrateStreams.CASE then
		f457_local0 = CoD.BlackMarketUtility.LootItemCountCase
	elseif CoD.BlackMarketUtility.IsBribeStream(f457_arg0) then
		local f457_local2 = CoD.BlackMarketTableUtility.GetBribeInformation(f457_arg0, f457_local1 and Engine[@"converttoxhash"](f457_local1))
		if f457_local2 and f457_local2.isSingleItem then
			f457_local0 = CoD.BlackMarketUtility.LootItemCountCase
		end
	end
	return f457_local0
end
DataSources.BlackjackReserveRevealList = ListHelper_SetupDataSource("BlackjackReserveRevealList", function(f458_arg0, f458_arg1)
	local f458_local0 = {}
	local f458_local1 = nil
	f458_arg1._revealDupeCount = 0
	f458_arg1._revealRerollCount = 0
	local f458_local2 = Engine.GetModelForController(f458_arg0)
	f458_local2 = f458_local2.LootRNGResult
	if f458_local2 then
		if not f458_local2.ready:get() then
			local f458_local3 = {}
			local f458_local4 = CoD.BlackMarketUtility.GetReservesRevealBlankItemValues()
			local f458_local5 = CoD.BlackMarketUtility.GetEmptyReserveRevealCount(f458_arg0)
			for f458_local6 = 1, f458_local5, 1 do
				local f458_local9 = f458_local6
				table.insert(f458_local3, {
					models = f458_local4,
				})
			end
			return f458_local3
		else
			if Engine[@"isdevelopmentbuild"]() then
				local f458_local3 = Engine[@"getdvarstring"]("loot_fakeRarity")
				if f458_local3 then
					if f458_local3 == "common" then
						f458_local1 = CoD.BlackMarketUtility[@"hash_28F1DEAFDA8DC0BC"]
					elseif f458_local3 == "rare" then
						f458_local1 = CoD.BlackMarketUtility[@"hash_5484A50BE5ADB35"]
					elseif f458_local3 == "legendary" then
						f458_local1 = CoD.BlackMarketUtility[@"hash_6F1C1A8D4B68B502"]
					elseif f458_local3 == "epic" then
						f458_local1 = CoD.BlackMarketUtility[@"hash_61F6439D530101F0"]
					elseif f458_local3 == "ultra" then
						f458_local1 = CoD.BlackMarketUtility[@"hash_6687ECDB5754642D"]
					end
				end
			end
			local f458_local3 = 0
			local f458_local4 = false
			local f458_local5 = f458_local2.itemsEarned and f458_local2.itemsEarned:get() or 0
			for f458_local6 = 1, f458_local5, 1 do
				local f458_local10 = f458_local2["item" .. f458_local6]
				local f458_local11 = f458_local10.itemId:get()
				local f458_local12 = f458_local10.isRerollReplaced:get()
				if Engine[@"isdevelopmentbuild"]() and not f458_local12 then
					f458_local3 = f458_local3 + 1
					if f458_local1 then
						f458_local11 = f458_local1[f458_local3] or f458_local11
					end
					local f458_local13 = Dvar[Engine[@"converttoxhash"]("loot_fakeItem" .. f458_local3)]:get()
					if f458_local13 then
						f458_local11 = tostring(f458_local13) or f458_local11
					end
				end
				if f458_local10 then
					local f458_local14 = f458_local10.rollType:get()
					local f458_local13 = f458_local14 == LuaEnum.LOOT_FLAGS.DUPE
					local f458_local15 = f458_local14 == LuaEnum.LOOT_FLAGS.REROLL
					if f458_local13 then
						f458_arg1._revealDupeCount = f458_arg1._revealDupeCount + 1
					end
					if f458_local15 then
						f458_arg1._revealRerollCount = f458_arg1._revealRerollCount + 1
					end
					if f458_local4 then
						f458_local4 = false
						if #f458_local0 > 0 then
							f458_local0[#f458_local0].properties.rerollItemId = f458_local11
						end
					end
					if f458_local12 then
						f458_local4 = true
					end
					local f458_local16 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f458_arg0, f458_local11, 0)
					if not f458_local16 then
						f458_local16 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f458_arg0, f458_local11)
						if not f458_local16 then
							f458_local16 = CoD.BlackMarketTableUtility.GetContractItemInfoFromId(f458_arg0, f458_local11)
						end
					end
					local f458_local17 = f458_local16 and CoD.BlackMarketUtility.GetItemRefs(f458_arg0, f458_local16.name, f458_local16.category, f458_local16.rarity, f458_local16.inSet, 0, f458_local16.lootType, f458_local16.refOptic, f458_local16.itemId)
					if f458_local17 then
						local f458_local18, f458_local19 = CoD.BlackMarketUtility.GetItemProductAndProperties(f458_local17)
						f458_local18.dupe = f458_local13
						f458_local18.reroll = f458_local15
						f458_local18.revealed = false
						f458_local18.hasRerolled = false
						table.insert(f458_local0, {
							models = f458_local18,
							properties = f458_local19,
						})
					end
				end
			end
		end
	end
	return f458_local0
end, true, nil, CoD.BlackMarketUtility.BlackjackReserveRevealListCustomSetupFn)
CoD.BlackMarketUtility.ClearRNGModels = function(f459_arg0)
	CoDShared.Loot.ClearRNGModels(f459_arg0)
end
CoD.BlackMarketUtility.ClearDupeMeterPulseModels = function(f460_arg0)
	local f460_local0 = DataSources.DupeMeterPulse.getModel(f460_arg0)
	f460_local0.pulseDupeIcon:set(false)
	f460_local0.pulseRerollIcon:set(false)
end
CoD.BlackMarketUtility.UpdateLootCaseCountWidget = function(f461_arg0, f461_arg1, f461_arg2)
	if not f461_arg0._lastSeenCaseCount then
		f461_arg0._lastSeenCaseCount = f461_arg2
		return
	elseif f461_arg0._lastSeenCaseCount < f461_arg2 then
		f461_arg0:playClip("GetCase")
	end
	f461_arg0._lastSeenCaseCount = f461_arg2
end
CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify = function(f462_arg0, f462_arg1)
	if f462_arg1 and not IsBooleanDvarSet("loot_sunsetBlackjackShopActive") and CoD.FTUEUtility.ShouldShowFTUESequence(f462_arg0, "BlackjackReservesIntroduction") then
		return
	end
	local f462_local0 = CoDShared.Loot.GetLootCaseOwnedCount(f462_arg0)
	local f462_local1 = CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f462_arg0)
	local f462_local2 = CoD.BlackMarketUtility.GetLootBribeOwnedCount(f462_arg0)
	if f462_local0 > 0 or f462_local1 > 0 or f462_local2 > 0 or CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f462_arg0, "LootStreamProgress.codPoints", 100) then
		if false == true then
			Engine.SendClientScriptNotify(f462_arg0, "BlackJackReserve", {
				open = f462_arg1,
				status = "welcome_case_special",
			})
		elseif f462_local0 >= 5 or f462_local1 >= 5 or f462_local2 >= 5 then
			Engine.SendClientScriptNotify(f462_arg0, "BlackJackReserve", {
				open = f462_arg1,
				status = "welcome_case_multi",
			})
		elseif f462_local0 > 0 or f462_local1 > 0 or f462_local2 > 0 then
			Engine.SendClientScriptNotify(f462_arg0, "BlackJackReserve", {
				open = f462_arg1,
				status = "welcome_case_avail",
			})
		else
			Engine.SendClientScriptNotify(f462_arg0, "BlackJackReserve", {
				open = f462_arg1,
				status = "welcome_case_notavail",
			})
		end
	else
		Engine.SendClientScriptNotify(f462_arg0, "BlackJackReserve", {
			open = f462_arg1,
			status = "welcome_empty",
		})
	end
end
CoD.BlackMarketUtility.PurchaseLootCrate = function(f463_arg0)
	CoD.BlackMarketUtility.OpenCrateByCurrency(f463_arg0, CoD.BlackMarketUtility.CrateStreams.THREE_PACK)
end
CoD.BlackMarketUtility.RedeemLootBundleCrate = function(f464_arg0)
	CoD.BlackMarketUtility.RedeemNonCPLootBribe(f464_arg0, CoD.BlackMarketUtility.GetFirstBribeNameByType(f464_arg0, LuaEnum.BRIBE_TYPES.CRATE))
end
CoD.BlackMarketUtility.GetBribeNameFromMenuProperty = function(f465_arg0, f465_arg1, f465_arg2)
	local f465_local0 = f465_arg1._bribeName
	if f465_local0 then
		local f465_local1 = CoD.BlackMarketUtility.GetBribeAsset(f465_arg0, f465_local0)
		if f465_local1 then
			return f465_local1.name
		end
	end
	return 0x0
end
CoD.BlackMarketUtility.GetBribeDescFromMenuProperty = function(f466_arg0, f466_arg1, f466_arg2)
	local f466_local0 = f466_arg1._bribeName
	if f466_local0 then
		local f466_local1 = CoD.BlackMarketUtility.GetBribeAsset(f466_arg0, f466_local0)
		if f466_local1 then
			return f466_local1.desc
		end
	end
	return 0x0
end
CoD.BlackMarketUtility.GetBribeImageFromMenuProperty = function(f467_arg0, f467_arg1, f467_arg2)
	local f467_local0 = f467_arg1._bribeName
	if f467_local0 then
		local f467_local1 = CoD.BlackMarketUtility.GetBribeAsset(f467_arg0, f467_local0)
		if f467_local1 then
			return f467_local1.popupImage
		end
	end
	return "blacktransparent"
end
CoD.BlackMarketUtility.RedeemNonCPLootBribe = function(f468_arg0, f468_arg1)
	if f468_arg1 then
		local f468_local0 = CoD.BlackMarketTableUtility.GetBribeInformation(f468_arg0, f468_arg1)
		if f468_local0.nonCpQuantity > 0 and f468_local0.name ~= "no_dupe_crate" then
			local f468_local1 = f468_local0.currency
			if f468_local1 == "20" then
				f468_local1 = f468_local0.optionalCurrency
			end
			CoD.BlackMarketUtility.OpenBribe(f468_arg0, f468_local0.lootRule, f468_local1)
		end
	end
end
CoD.BlackMarketUtility.GetFirstBribeNameByType = function(f469_arg0, f469_arg1)
	for f469_local9, f469_local10 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f469_arg0)) do
		if CoD.BlackMarketUtility.GetBribeAsset(f469_arg0, f469_local10.name) then
			if f469_arg1 == LuaEnum.BRIBE_TYPES.CASE then
				for f469_local6, f469_local7 in ipairs(CoDShared.Loot.Cases) do
					if f469_local10.name == f469_local7 and f469_local10.nonCpQuantity > 0 then
						return f469_local10.name
					end
				end
			end
			if f469_arg1 == LuaEnum.BRIBE_TYPES.CRATE then
				for f469_local6, f469_local7 in ipairs(CoDShared.Loot.Crates) do
					if f469_local10.name == f469_local7 and f469_local10.nonCpQuantity > 0 and f469_local7 ~= "no_dupe_crate" then
						return f469_local10.name
					end
				end
			end
			if f469_arg1 == LuaEnum.BRIBE_TYPES.BRIBE then
				local f469_local3 = true
				for f469_local7, f469_local8 in ipairs(CoDShared.Loot.Cases) do
					if f469_local10.name == f469_local8 then
						f469_local3 = false
					end
				end
				for f469_local7, f469_local8 in ipairs(CoDShared.Loot.Crates) do
					if f469_local10.name == f469_local8 then
						f469_local3 = false
					end
				end
				if f469_local3 and f469_local10.nonCpQuantity > 0 then
					return f469_local10.name
				end
			end
		end
	end
	return nil
end
CoD.BlackMarketUtility.SetBribeNamePropertyByType = function(f470_arg0, f470_arg1)
	local f470_local0 = LuaEnum.BRIBE_TYPES.CASE
	if f470_arg1 and f470_arg1._bribeType then
		f470_local0 = f470_arg1._bribeType
	end
	f470_arg1._bribeName = CoD.BlackMarketUtility.GetFirstBribeNameByType(f470_arg0, f470_local0)
end
CoD.BlackMarketUtility.RedeemNoDupeCrateBribe = function(f471_arg0)
	for f471_local3, f471_local4 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(f471_arg0)) do
		if f471_local4.nonCpQuantity > 0 and f471_local4.name == "no_dupe_crate" then
			CoD.BlackMarketUtility.OpenNoDupeCrateWithCases(f471_arg0)
			return
		end
	end
end
CoD.BlackMarketUtility.ReservesRevealIntroDelay = function(f472_arg0, f472_arg1, f472_arg2)
	if not f472_arg1._reservesRevealIntroTimer then
		f472_arg1._reservesRevealIntroDelayTimeMS = f472_arg2
		f472_arg1._reservesRevealIntroTimer = LUI.UITimer.newElementTimer(f472_arg2, true, function(f473_arg0)
			if f472_arg1._reservesRevealIntroTimer then
				f472_arg1._reservesRevealIntroTimer:close()
				f472_arg1._reservesRevealIntroTimer = false
			end
			f472_arg1._reservesRevealIntroComplete = true
			f472_arg1._reservesRevealIntroDelayTimeMS = 0
			UpdateSelfState(f472_arg1, f472_arg0)
		end)
		f472_arg1:addElement(f472_arg1._reservesRevealIntroTimer)
	end
end
CoD.BlackMarketUtility.SkipReservesRevealAnimation = function(f474_arg0, f474_arg1, f474_arg2)
	local f474_local0 = Engine.GetModelForController(f474_arg0)
	if f474_local0.LootRNGResult.ready:get() then
		if f474_arg1._reservesRevealIntroTimer then
			f474_arg1._reservesRevealIntroTimer:close()
			f474_arg1._reservesRevealIntroTimer = false
			f474_arg1._reservesRevealIntroComplete = true
			f474_arg1._reservesRevealIntroDelayTimeMS = 0
			UpdateSelfState(f474_arg1, f474_arg0)
		end
		if f474_arg1._reservesRevealTimers then
			for f474_local4, f474_local5 in pairs(f474_arg1._reservesRevealTimers) do
				f474_local5:close()
			end
			f474_arg1._reservesRevealTimers = nil
		end
		local f474_local1 = DataSources.BlackjackReserveRevealList.getCount(f474_arg2)
		for f474_local2 = 1, f474_local1, 1 do
			local f474_local6 = DataSources.BlackjackReserveRevealList.getItem(f474_arg0, f474_arg2, f474_local2)
			local f474_local7 = DataSources.BlackjackReserveRevealList.getCustomPropertiesForItem(f474_arg2, f474_local2)
			if f474_local7 and f474_local7.rerollItemId and not f474_local6.reroll:get() then
				local f474_local8 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f474_arg0, f474_local7.rerollItemId, 0)
				local f474_local9 = f474_local8 and CoD.BlackMarketUtility.GetItemRefs(f474_arg0, f474_local8.name, f474_local8.category, f474_local8.rarity, f474_local8.inSet, 0, f474_local8.lootType, f474_local8.refOptic, f474_local8.itemId)
				if f474_local9 then
					local f474_local10, f474_local11 = CoD.BlackMarketUtility.GetItemProductAndProperties(f474_local9)
					CoD.BlackMarketUtility.BlackjackReserveChangeRevealListItemModelsFn(f474_local6, f474_local10)
				end
				f474_local6.dupe:set(false)
				f474_local6.reroll:set(true)
			end
			f474_local6.revealed:set(true)
		end
		CoD.BlackMarketUtility.BlackjackReserveRevealOnCompleteFn(f474_arg0, f474_arg2)
	end
end
CoD.BlackMarketUtility.AutoOpenItemPurchasePopup = function(f475_arg0, f475_arg1, f475_arg2)
	if f475_arg2._itemPurchaseId then
		local f475_local0 = f475_arg2._itemPurchaseId
		f475_arg2._itemPurchaseId = nil
		if f475_arg0.itemPurchaseId == f475_local0 and CanPurchaseItem(f475_arg1, f475_arg0) then
			OpenOverlay(f475_arg2, "PurchaseReservesItem", f475_arg1, {
				_model = f475_arg0:getModel(),
			})
		end
	end
end
CoD.BlackMarketUtility.SetupReservesRevealFailsafe = function(f476_arg0, f476_arg1, f476_arg2)
	if not f476_arg1._reservesRevealFailsafeTimer then
		f476_arg1._reservesRevealFailsafeTimer = LUI.UITimer.newElementTimer(f476_arg2 * 1000, true, function(f477_arg0)
			GoBack(f476_arg1, f476_arg0)
			local f477_local0 = 0
			local f477_local1 = Engine.GetModelForController(f476_arg0)
			f477_local1 = f477_local1:create("LootRNGResult")
			if f477_local1 and f477_local1.error_code then
				f477_local0 = f477_local1.error_code:get()
			end
			LuaUtils.UI_ShowErrorMessageDialog(f476_arg0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_78E11EA16D61A059", f477_local0), @"hash_4BDB5C4152F448EE")
		end)
		f476_arg1:addElement(f476_arg1._reservesRevealFailsafeTimer)
		if not f476_arg1._hasLootRNGResultSubscriptions then
			f476_arg1._hasLootRNGResultSubscriptions = true
			local f476_local0 = Engine.GetModelForController(f476_arg0)
			f476_arg1:subscribeToModel(f476_local0.LootRNGResult.ready, function(model)
				if f476_arg1._reservesRevealFailsafeTimer and model:get() then
					f476_arg1._reservesRevealFailsafeTimer:close()
					f476_arg1._reservesRevealFailsafeTimer = nil
				end
			end, false)
		end
	end
end
CoD.BlackMarketUtility.SetupReservesRevealSkipDelay = function(f479_arg0, f479_arg1, f479_arg2, f479_arg3)
	if not f479_arg1._reservesRevealSkipDelayTimer then
		local f479_local0 = Engine.GetModelForController(f479_arg0)
		f479_local0 = f479_local0:create("reservesRevealSkipAvailable")
		f479_local0:set(false)
		local f479_local1 = f479_arg2
		if f479_arg2 < f479_arg3 then
			f479_local1 = math.random(f479_arg2, f479_arg3)
		end
		f479_arg1._reservesRevealSkipDelayTimer = LUI.UITimer.newElementTimer(f479_local1, true, function(f480_arg0)
			if f479_arg1._reservesRevealSkipDelayTimer then
				f479_arg1._reservesRevealSkipDelayTimer:close()
				f479_arg1._reservesRevealSkipDelayTimer = nil
			end
			f479_local0:set(true)
		end)
		f479_arg1:addElement(f479_arg1._reservesRevealSkipDelayTimer)
	end
end
CoD.BlackMarketUtility.ShowBribeNotSpentNotification = function(f481_arg0)
	LuaUtils.UI_ShowInfoMessageDialog(f481_arg0, @"hash_1BB23B4A698BB414", @"hash_240E20A908411465")
end
CoD.BlackMarketUtility.UpdateLootCaseBreadcrumbStatValue = function(f482_arg0)
	local f482_local0 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f482_arg0, Enum.eModes.mode_multiplayer)
	if f482_local0 and f482_local0.lastLootCaseCountSeen then
		local f482_local1 = f482_local0.lastLootCaseCountSeen:get()
		local f482_local2 = CoDShared.Loot.GetLootCaseOwnedCount(f482_arg0)
		if f482_local2 ~= f482_local1 and f482_local2 > -1 then
			f482_local0.lastLootCaseCountSeen:set(f482_local2)
			Engine.StorageWrite(f482_arg0, Enum.StorageFileType[@"storage_mp_stats_online"])
		end
	end
end
CoD.BlackMarketUtility.PlayReservesPreviewVideo = function(f483_arg0, f483_arg1, f483_arg2, f483_arg3)
	if not CoD.BlackMarketUtility.CanShowReservesPreview(f483_arg0) then
		return
	end
	local f483_local0 = Enum[@"hash_6C47FC1BD2E5CCEE"][@"hash_390B07394D69C5F4"]
	local f483_local1 = "core_frontend_rng_reserve"
	local f483_local2 = false
	local f483_local3 = false
	local f483_local4 = "VoDViewer"
	if f483_arg2 then
		f483_local4 = "SkippableVoDViewer"
	end
	local f483_local5 = DataSources.VoDViewer.getModel(f483_arg0)
	f483_local5.stream:set(CoD.VideoStreamingUtility.GetMoviePlayerParams(f483_local0, f483_local1, f483_local2, f483_local3))
	f483_arg1:addElement(LUI.UITimer.newElementTimer(80, true, function()
		LUI.OverrideFunction_CallOriginalFirst(
			OpenOverlay(f483_arg1, f483_local4, f483_arg0, {
				fullscreen = true,
			}),
			"close",
			function()
				if f483_arg3 then
					CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f483_arg0, true)
				end
			end
		)
	end))
end
CoD.BlackMarketUtility.ItemShopDetailsClientScriptMenuCloseNotify = function(f486_arg0, f486_arg1)
	SendClientScriptMenuChangeNotify(f486_arg0, f486_arg1, false)
	if f486_arg1.occludedMenu and f486_arg1.occludedMenu._currentTab == "reserves" then
		CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f486_arg0, true)
	end
end
CoD.BlackMarketUtility.ShowReservesReRollButton = function(f487_arg0, f487_arg1)
	local f487_local0 = Engine.GetModelForController(f487_arg0)
	f487_local0 = f487_local0.LootRNGResult.streamId:get()
	local f487_local1 = f487_arg1:getModel()
	local f487_local2 = f487_local1 and f487_local1.name
	if f487_local2 and f487_local2:get() == @"hash_1717FF140F30014C" then
		return true
	elseif f487_local0 == CoD.BlackMarketUtility.CrateStreams.CASE then
		return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f487_arg0, "ReservesItemCounts", "lootCaseCount", 0)
	elseif f487_local0 == CoD.BlackMarketUtility.CrateStreams.THREE_PACK then
		if f487_local1 and f487_local1.isBundleCrate and f487_local1.isBundleCrate:get() then
			return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f487_arg0, "ReservesItemCounts", "lootBundleCrateCount", 0)
		else
			return true
		end
	elseif CoD.BlackMarketUtility.IsBribeStackStream(f487_arg0) then
		return false
	elseif CoD.BlackMarketUtility.IsBribeMenuStream(f487_arg0) then
		if IsBooleanDvarSet(@"hash_78794D44313B8D66") then
			return true
		else
			return false
		end
	elseif CoD.BlackMarketUtility.IsBribeStream(f487_arg0) then
		return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f487_arg0, "ReservesItemCounts", "lootBribeCount", 0)
	else
		return false
	end
end
CoD.BlackMarketUtility.IsBribeStream = function(f488_arg0)
	local f488_local0 = Engine.GetModelForController(f488_arg0)
	f488_local0 = f488_local0.LootRNGResult.streamId:get()
	local f488_local1 = f488_local0 and Engine[@"converttoxhash"](f488_local0)
	if f488_local1 then
		return Engine.TableFindRows(CoD.BlackMarketTableUtility.BribeTable.name, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH, f488_local1) ~= nil
	else
		return false
	end
end
CoD.BlackMarketUtility.IsBribeMenuOrBribeStackStream = function(f489_arg0)
	if CoD.BlackMarketUtility.IsBribeStackStream(f489_arg0) then
		return true
	elseif CoD.BlackMarketUtility.IsBribeMenuStream(f489_arg0) then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.IsBribeStackStream = function(f490_arg0)
	local f490_local0 = Engine.GetModelForController(f490_arg0)
	f490_local0 = f490_local0.LootRNGResult.streamId:get()
	for f490_local4, f490_local5 in ipairs(CoD.BlackMarketUtility.BribeStack) do
		if f490_local5.name == f490_local0 then
			CoD.BlackMarketUtility.SaveBribe(f490_arg0, f490_local0)
			return true
		end
	end
	return false
end
CoD.BlackMarketUtility.IsBribeMenuStream = function(f491_arg0)
	local f491_local0 = Engine.GetModelForController(f491_arg0)
	f491_local0 = f491_local0.LootRNGResult.streamId:get()
	if CoD.BlackMarketTableUtility.IsBribeMenu(f491_arg0, f491_local0) then
		CoD.BlackMarketUtility.SaveBribeMenuPurchase(f491_arg0, f491_local0)
		local f491_local1 = Engine.CreateModel(Engine.GetGlobalModel(), "BribeMenuTimer")
		if f491_local1 and f491_local1.cycled then
			f491_local1.cycled:set(true)
			f491_local1.cycled:forceNotifySubscriptions()
		end
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.CanSkipReservesRevealAnimation = function(f492_arg0)
	local f492_local0 = Engine.GetModelForController(f492_arg0)
	local f492_local1 = f492_local0.LootRNGResult.ready:get()
	if f492_local1 then
		if not f492_local0.LootRNGResult.allBribeItemsOwned:get() then
			f492_local1 = f492_local0.reservesRevealSkipAvailable:get()
			if f492_local1 then
				f492_local1 = not f492_local0.reservesRevealComplete:get()
			end
		else
			f492_local1 = false
		end
	end
	return f492_local1
end
CoD.BlackMarketUtility.ShowTierBoostPercent = function(f493_arg0, f493_arg1)
	if (Engine[@"getdvarint"](@"hash_E1CE7247C220196") or 0) == 0 then
		return false
	elseif (CoDShared.Loot.GetCurrentTierBoost(f493_arg0) or 0) > 0 then
		return true
	else
		return false
	end
end
CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent = function(f494_arg0, f494_arg1)
	if (Engine[@"getdvarint"](@"hash_E1CE7247C220196") or 0) == 0 then
		return false
	elseif (CoDShared.Loot.GetCurrentTierBoost(f494_arg0) or 0) >= CoDShared.Loot.GetMaxTierBoost() then
		return false
	else
		return true
	end
end
CoD.BlackMarketUtility.ShouldShowLootCaseBreadcrumb = function(f495_arg0)
	local f495_local0 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f495_arg0, Enum.eModes.mode_multiplayer)
	if f495_local0 and f495_local0.lastLootCaseCountSeen then
		return f495_local0.lastLootCaseCountSeen:get() < CoDShared.Loot.GetLootCaseOwnedCount(f495_arg0)
	else
		return false
	end
end
CoD.BlackMarketUtility.CanShowReservesPreview = function(f496_arg0)
	if CoD.isPC and not CoD.PCKoreaUtility.IsSeasonPromoVideoSafe() then
		return false
	else
		return not IsBooleanDvarSet(@"hash_671B81E101B4A9DB")
	end
end
CoD.BlackMarketUtility.GetRerollButtonString = function(f497_arg0, f497_arg1, f497_arg2)
	local f497_local0 = Engine.GetModelForController(f497_arg0)
	if f497_local0.LootRNGResult.streamId:get() == CoD.BlackMarketUtility.CrateStreams.CASE then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E98D63EA5A0BD3")
	elseif f497_arg1 and f497_arg1.isBundleCrate and f497_arg1.isBundleCrate:get() and CoD.BlackMarketUtility.GetLootBundleCrateOwnedCount(f497_arg0) > 0 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E98D63EA5A0BD3")
	elseif CoD.BlackMarketUtility.IsBribeStream(f497_arg0) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E98D63EA5A0BD3")
	elseif f497_arg1 and f497_arg1.name and f497_arg1.name:get() == @"hash_1717FF140F30014C" then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_C2B10DCD9D6E876")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_27AD54B6F8C27799", f497_arg2)
	end
end
CoD.BlackMarketUtility.GetTierBoostPercentString = function(f498_arg0, f498_arg1)
	return "+" .. f498_arg1 .. "% " .. Engine[@"hash_4F9F1239CFD921FE"](@"menu/tier_boost")
end
CoD.BlackMarketUtility.FreePromptTitleIfPriceIsZero = function(f499_arg0, f499_arg1)
	if f499_arg0 and not f499_arg0.price then
		return ConvertToUpperString(Engine[@"hash_4F9F1239CFD921FE"](f499_arg0.name:get()))
	else
		return ConvertToUpperString(f499_arg1)
	end
end
CoD.BlackMarketUtility.FreePromptDescIfPriceIsZero = function(f500_arg0, f500_arg1)
	if f500_arg0 and not f500_arg0.price then
		return f500_arg0.desc:get()
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f500_arg1)
	end
end
CoD.BlackMarketUtility.GetCrateBundleBonusString = function(f501_arg0)
	if f501_arg0 == 1 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_38A5D1F6E24A1926")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_38A59AF6E249BBB1", f501_arg0)
	end
end
CoD.BlackMarketUtility.GetMPItemPreviewImage = function(f502_arg0)
	local f502_local0 = Enum.eModes.mode_multiplayer
	local f502_local1 = Engine[@"hash_2D97229B24C685D5"](f502_arg0, f502_local0)
	if not f502_local1 then
		f502_local1 = shared.EmptyItemIndex
	end
	local f502_local2 = CoD.CACUtility.GetUnlockableItemInfoField(f502_local1, f502_local0, "previewImage", nil)
	if not f502_local2 then
		return RegisterImage("blacktransparent")
	else
		return f502_local2
	end
end
CoD.BlackMarketUtility.GetMPItemPreviewImageLarge = function(f503_arg0)
	local f503_local0 = Enum.eModes.mode_multiplayer
	local f503_local1 = Engine[@"hash_2D97229B24C685D5"](f503_arg0, f503_local0)
	if not f503_local1 then
		f503_local1 = shared.EmptyItemIndex
	end
	local f503_local2 = CoD.CACUtility.GetUnlockableItemInfoField(f503_local1, f503_local0, "previewImageLarge", nil)
	if not f503_local2 then
		return RegisterImage("blacktransparent")
	else
		return f503_local2
	end
end
CoD.BlackMarketUtility.InitialHideScrollPrompts = function(f504_arg0, f504_arg1, f504_arg2)
	if f504_arg2._initialHideComplete then
		return
	elseif f504_arg2.horizontalCounter then
		f504_arg2.updateHorizontalCounter = CoD.BlackMarketUtility.updateHorizontalCounter
		f504_arg2._initialHideComplete = true
	end
	if CoD.isPC then
		LUI.OverrideFunction_CallOriginalFirst(f504_arg0, "setState", function(element, controller, f505_arg2, f505_arg3, f505_arg4)
			f504_arg2:updateCounters()
		end)
	end
end
CoD.BlackMarketUtility.updateHorizontalCounter = function(f506_arg0, f506_arg1)
	if f506_arg1 then
		local f506_local0 = CoD.isPC and "DefaultState" or "NoPrompts"
		if f506_arg0.requestedColumnCount <= f506_arg0.hCount then
			f506_local0 = "AtLeftAndRight"
		elseif f506_arg0.hasListFocus then
			f506_local0 = "DefaultState"
		end
		if f506_arg1.currentItem then
			local f506_local1 = 1
			if f506_arg0.activeWidget then
				f506_local1 = f506_arg0.activeWidget.gridInfoTable.zeroBasedIndex + 1
			end
			f506_arg1.currentItem:setText(f506_local1)
		end
		if f506_arg1.count then
			local f506_local1 = f506_arg0.itemCount
			if not f506_local1 then
				f506_local1 = 0
			end
			f506_arg1.count:setText(f506_local1)
			if f506_local1 == 0 and f506_arg1.__clipsPerState and f506_arg1.__clipsPerState.NoItems then
				f506_local0 = "NoItems"
			end
		end
		f506_arg1:setState(f506_arg0.controller, f506_local0)
	end
end
CoD.BlackMarketUtility.ShopCycleThroughItems = function(f507_arg0, f507_arg1, f507_arg2, f507_arg3)
	f507_arg2._cycleTimer = LUI.UITimer.newElementTimer(CoD.BlackMarketUtility.GetBlackJacksShopCycleTime() * 1000, false, function(f508_arg0)
		if not f507_arg2._disableAutoScrolling then
			if f507_arg2.requestedColumnCount < 2 then
			elseif f507_arg2._skipNextAutoCycle then
				f507_arg2._skipNextAutoCycle = nil
			else
				if f507_arg2.activeWidget == nil then
					f507_arg2.activeWidget = f507_arg2:getItemAtPosition(1, 1, false)
				end
				if f507_arg2.activeWidget then
					f507_arg2.activeWidget:playClip("FadeOut")
					f507_arg2.activeWidget._fadeOutTimer = LUI.UITimer.newElementTimer(f507_arg3 * 1000, true, function(f509_arg0)
						if f507_arg2._disableAutoScrolling then
						elseif f507_arg2._skipNextAutoCycle then
							f507_arg2._skipNextAutoCycle = nil
						else
							f507_arg2:navigateItemRight(nil, true)
							f507_arg2:addElement(LUI.UITimer.newElementTimer(30, true, function(f510_arg0)
								CoD.FreeCursorUtility.RetriggerCursorPosition(f507_arg0, f507_arg1)
							end))
						end
					end)
					f507_arg2.activeWidget:addElement(f507_arg2.activeWidget._fadeOutTimer)
				else
					f507_arg2:navigateItemRight(nil, true)
					f507_arg2:addElement(LUI.UITimer.newElementTimer(30, true, function(f511_arg0)
						CoD.FreeCursorUtility.RetriggerCursorPosition(f507_arg0, f507_arg1)
					end))
				end
			end
		end
	end)
	f507_arg2._disableAutoScrolling = false
	f507_arg2:addElement(f507_arg2._cycleTimer)
end
CoD.BlackMarketUtility.IsShopListInFocus = function(f512_arg0, f512_arg1)
	if f512_arg1 and f512_arg1.activeWidget then
		return f512_arg1.activeWidget.__hasChildFocus
	else
		return false
	end
end
CoD.BlackMarketUtility.SetupBlackJackFrameContextualMenus = function(f513_arg0, f513_arg1)
	if not CoD.isPC then
		return
	elseif IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
		CoD.PCWidgetUtility.SetupContextualMenu(f513_arg0.DeterministicItemSlot1, f513_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f513_arg0.DeterministicItemSlot2, f513_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f513_arg0.RNGItemSlot, f513_arg1, "name", "", "")
	else
		CoD.PCWidgetUtility.SetupContextualMenu(f513_arg0.FeaturedSlot2, f513_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f513_arg0.FeaturedSlot1, f513_arg1, "name", "", "")
		CoD.PCWidgetUtility.SetupContextualMenu(f513_arg0.SpecialOrders, f513_arg1, "name", "", "")
	end
end
CoD.BlackMarketUtility.OnQuitBlackMarketCustomFunction = function(f514_arg0, f514_arg1)
	if not CoD.isPC or not f514_arg0._tab or not f514_arg0._tab.__onQuit then
		return
	else
		f514_arg0._tab.__onQuit()
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
CoD.BlackMarketUtility.OpenAllReservesOwnedDialog = function(f516_arg0, f516_arg1)
	CoD.OverlayUtility.CreateOverlay(f516_arg1, f516_arg0, "AllReservesOwned")
end
DataSources.BlackMarketAvailableContractModes = ListHelper_SetupDataSource("BlackMarketAvailableContractModes", function(f517_arg0, f517_arg1)
	local f517_local0 = {}
	table.insert(f517_local0, {
		models = {
			name = "MENU/MULTIPLAYER",
		},
		properties = {
			_mode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP,
		},
	})
	table.insert(f517_local0, {
		models = {
			name = "MENU/WARZONE",
		},
		properties = {
			_mode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ,
		},
	})
	table.insert(f517_local0, {
		models = {
			name = "MENU/ZOMBIES",
		},
		properties = {
			_mode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM,
		},
	})
	return f517_local0
end, true)
DataSources.Contracts = {
	getModel = function(f518_arg0)
		return CoD.BlackMarketUtility.GetContractsRootModel(f518_arg0)
	end,
}
CoD.BlackMarketUtility.GetContractsRootModel = function(f519_arg0)
	local f519_local0 = Engine.GetModelForController(f519_arg0)
	return f519_local0:create("Contracts")
end
CoD.BlackMarketUtility.GetCurrentContractGameMode = function(f520_arg0)
	local f520_local0 = CoD.BlackMarketUtility.GetContractModeOverride(f520_arg0)
	if f520_local0 then
		return f520_local0
	end
	local f520_local1 = {
		[Enum.eModes.mode_multiplayer] = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP,
		[Enum.eModes.mode_warzone] = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ,
		[Enum.eModes.mode_zombies] = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM,
	}
	local f520_local2 = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID
	if IsArenaMode() then
		f520_local2 = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WL
	else
		f520_local2 = f520_local1[Engine.CurrentSessionMode()] or CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID
	end
	return f520_local2
end
CoD.BlackMarketUtility.GetContractStateTable = function(f521_arg0, f521_arg1)
	if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
		local f521_local0 = "gamedata/lootcontracts/lootcontracts.csv"
		local f521_local1 = Engine.GetTableRowCount(f521_local0)
		local f521_local2 = {}
		for f521_local3 = 1, f521_local1, 1 do
			local f521_local6 = f521_local3
			table.insert(f521_local2, Engine[@"hash_4C6F8EC444864600"](f521_local0, math.random(0, f521_local1 - 1), 0))
		end
		local f521_local3 = {
			version = 1,
			flags = 0,
			dailyExpiration = Engine[@"hash_2786FFC9E621CAB7"]() + 3600000,
			availableExpiration = Engine[@"hash_2786FFC9E621CAB7"]() + 3600000,
		}
		local f521_local4 = function()
			return {
				id = f521_local2[math.random(1, #f521_local2)],
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
		local f521_local5 = 1
		local f521_local6 = 3
		local f521_local7 = 6
		f521_local3.dailyContracts = {}
		f521_local3.pinnedContracts = {}
		f521_local3.availableContracts = {}
		if f521_arg1 then
			for f521_local8 = 1, f521_local5, 1 do
				f521_local3.dailyContracts[f521_local8] = f521_local4()
			end
			for f521_local8 = 1, f521_local6, 1 do
				f521_local3.pinnedContracts[f521_local8] = f521_local4()
			end
			for f521_local8 = 1, f521_local7, 1 do
				f521_local3.availableContracts[f521_local8] = f521_local4()
			end
		else
			for f521_local8 = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP, CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ, 1 do
				f521_local3.dailyContracts[f521_local8] = {}
				for f521_local11 = 1, f521_local5, 1 do
					f521_local3.dailyContracts[f521_local8][f521_local11] = f521_local4()
				end
				f521_local3.pinnedContracts[f521_local8] = {}
				for f521_local11 = 1, f521_local6, 1 do
					f521_local3.pinnedContracts[f521_local8][f521_local11] = f521_local4()
				end
				f521_local3.availableContracts[f521_local8] = {}
				for f521_local11 = 1, f521_local7, 1 do
					f521_local3.availableContracts[f521_local8][f521_local11] = f521_local4()
				end
			end
		end
		return f521_local3
	elseif f521_arg1 then
		return Engine[@"hash_1DC39182CB1C9BE4"](f521_arg0, f521_arg1)
	else
		return Engine[@"hash_292C69F543736D04"](f521_arg0)
	end
end
DataSources.BlackMarketAvailableContracts = ListHelper_SetupDataSource("BlackMarketAvailableContracts", function(f523_arg0, f523_arg1)
	local f523_local0 = {}
	if CoDShared.LootContracts.IsEnabled(f523_arg0) then
		local f523_local1 = f523_arg1._mode
		if not f523_local1 then
			f523_local1 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f523_arg0)
		end
		local f523_local2 = CoD.BlackMarketUtility.GetContractStateTable(f523_arg0, f523_local1)
		if CoDShared.LootContracts.IsLootContractTableValid(f523_local2) then
			local f523_local3 = f523_local2.availableContracts
			if f523_local3 then
				for f523_local8, f523_local9 in ipairs(f523_local3) do
					if (CoDShared.IsBitSet(f523_local9.flags, Enum[@"hash_B40A0B507A68068"][@"hash_F26C5D1872ABE11"]) or CoD.BaseUtility.IsDvarEnabled("lootContracts_forceReady")) and f523_local1 == CoDShared.LootContracts.GetContractsGameMode(f523_local9.id) then
						local f523_local7 = CoD.BlackMarketUtility.GetContractModelsForContractInfo(f523_local9)
						if f523_local7 then
							if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
								f523_local7.progress = math.random(0, f523_local7.target)
								f523_local7.progressRatio = f523_local7.progress / f523_local7.target
								f523_local7.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"]("blackmarket/x_of_y", f523_local7.progress, f523_local7.target)
							end
							if CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f523_arg0) then
								f523_local7.xpReward = f523_local7.xpReward * 2
							end
							table.insert(f523_local0, {
								models = f523_local7,
							})
						end
					end
				end
				table.sort(f523_local0, function(f524_arg0, f524_arg1)
					return f524_arg0.models.difficulty < f524_arg1.models.difficulty
				end)
			end
		end
	end
	return f523_local0
end, true)
DataSources.BlackMarketActiveContracts = ListHelper_SetupDataSource("BlackMarketActiveContracts", function(f525_arg0, f525_arg1)
	local f525_local0 = {}
	if CoDShared.LootContracts.IsEnabled(f525_arg0) then
		local f525_local1 = f525_arg1._mode
		if not f525_local1 then
			f525_local1 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f525_arg0)
		end
		local f525_local2 = CoD.BlackMarketUtility.GetContractStateTable(f525_arg0, f525_local1)
		if CoDShared.LootContracts.IsLootContractTableValid(f525_local2) then
			local f525_local3 = function(f526_arg0)
				local f526_local0 = CoD.BlackMarketUtility.GetContractModelsForContractInfo(f526_arg0)
				if f526_local0 then
					if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
						f526_local0.progress = math.random(0, f526_local0.target)
						f526_local0.progressRatio = f526_local0.progress / f526_local0.target
						f526_local0.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"]("blackmarket/x_of_y", f526_local0.progress, f526_local0.target)
					end
					if CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f525_arg0) then
						f526_local0.xpReward = f526_local0.xpReward * 2
					end
					table.insert(f525_local0, {
						models = f526_local0,
					})
				end
			end
			local f525_local4 = f525_local2.dailyContracts
			if f525_local4 then
				f525_local3(f525_local4[1])
			end
			local f525_local5 = f525_local2.pinnedContracts
			if f525_local5 then
				for f525_local9, f525_local10 in ipairs(f525_local5) do
					if CoDShared.IsBitSet(f525_local10.flags, Enum[@"hash_B40A0B507A68068"][@"hash_F26C5D1872ABE11"]) or CoD.BaseUtility.IsDvarEnabled("lootContracts_forceReady") then
						f525_local3(f525_local10)
					end
				end
				f525_local6 = 2 - #f525_local5
				for f525_local7 = 1, f525_local6, 1 do
					f525_local10 = f525_local7
					table.insert(f525_local0, {
						models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
					})
				end
			end
		else
			for f525_local3 = 1, 3, 1 do
				local f525_local6 = f525_local3
				table.insert(f525_local0, {
					models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
				})
			end
		end
	end
	return f525_local0
end, true)
CoD.BlackMarketUtility.GetContractsModelTable = function(f527_arg0, f527_arg1)
	local f527_local0 = {}
	if CoDShared.LootContracts.IsEnabled(f527_arg0) then
		local f527_local1 = CoD.BlackMarketUtility.GetContractsRootModel(f527_arg0)
		local f527_local2 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f527_arg0)
		local f527_local3 = CoD.BlackMarketUtility.GetContractStateTable(f527_arg0, f527_local2)
		if CoDShared.LootContracts.IsLootContractTableValid(f527_local3) then
			local f527_local4 = f527_local3[f527_arg1]
			if f527_local4 then
				for f527_local9, f527_local10 in ipairs(f527_local4) do
					if CoDShared.IsBitSet(f527_local10.flags, Enum[@"hash_B40A0B507A68068"][@"hash_F26C5D1872ABE11"]) or CoD.BaseUtility.IsDvarEnabled("lootContracts_forceReady") then
						local f527_local8 = CoD.BlackMarketUtility.GetContractModelsForContractInfo(f527_local10)
						if f527_local8 then
							if CoD.BaseUtility.IsDvarEnabled("ui_fakeContracts") then
								f527_local8.progress = math.random(0, f527_local8.target)
								f527_local8.progressRatio = f527_local8.progress / f527_local8.target
								f527_local8.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"]("blackmarket/x_of_y", f527_local8.progress, f527_local8.target)
							end
							if f527_arg1 == "dailyContracts" and f527_local2 == CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM then
								f527_local8.isDailyZombies = true
							end
							if CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f527_arg0) then
								f527_local8.xpReward = f527_local8.xpReward * 2
							end
							table.insert(f527_local0, {
								models = f527_local8,
							})
						end
					end
					table.insert(f527_local0, {
						models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
					})
				end
			end
			local f527_local5 = f527_local1:create("contractsAvailable")
			f527_local5:set(true)
		else
			local f527_local4 = {
				dailyContracts = 1,
				pinnedContracts = 2,
				availableContracts = 6,
			}
			local f527_local5 = f527_local4[f527_arg1]
			if not f527_local5 then
				f527_local5 = 1
			end
			for f527_local6 = 1, f527_local5, 1 do
				local f527_local10 = f527_local6
				table.insert(f527_local0, {
					models = CoD.BlackMarketUtility.GetEmptyContractModelsTable(),
				})
			end
			local f527_local6 = f527_local1:create("contractsAvailable")
			f527_local6:set(false)
		end
	end
	return f527_local0
end
CoD.BlackMarketUtility.GetEmptyContractModelsTable = function()
	return {
		id = 0,
		contractMode = CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID,
		displayName = 0x0,
		description = "",
		contractIcon = "blacktransparent",
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
		rewardIcon = "blacktransparent",
		rewardDisplay = "",
		isDailyZombies = false,
		active = false,
		completed = false,
	}
end
CoD.BlackMarketUtility.GetContractModelsForContractInfo = function(f529_arg0)
	if f529_arg0.id == 0 then
		return CoD.BlackMarketUtility.GetEmptyContractModelsTable()
	end
	local f529_local0 = {
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP] = "menu/multiplayer",
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WL] = "menu/arena",
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ] = "menu/warzone",
		[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM] = "menu/zombies",
	}
	local f529_local1 = f529_arg0.id
	local f529_local2 = CoDShared.LootContracts.GetContractsGameMode(f529_local1)
	if f529_local2 == CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID then
		return CoD.BlackMarketUtility.GetEmptyContractModelsTable()
	end
	local f529_local3 = CoDShared.LootContracts.GetContractsDifficulty(f529_local1)
	local f529_local4 = f529_arg0.target
	local f529_local5 = CoDShared.LootContracts.GetContractDescription(f529_local1)
	local f529_local6 = CoDShared.LootContracts.GetContractsCategoryHash(f529_local1)
	local f529_local7 = f529_arg0.xpAmount
	local f529_local8 = f529_arg0.reward.amount
	local f529_local9 = f529_arg0.reward.type
	local f529_local10 = f529_arg0.reward.id
	local f529_local11 = f529_arg0.progress
	local f529_local12 = f529_local0[f529_local2] or 0x0
	local f529_local13 = "blacktransparent"
	local f529_local14 = ""
	if f529_local9 == 1 then
		if f529_local8 and f529_local8 > 0 then
			f529_local13 = "ui_icon_blackmarket_reserves_case_small"
			local f529_local15
			if f529_local8 > 1 then
				f529_local15 = @"hash_8FD4B5379066B7A"
				if not f529_local15 then
				else
					f529_local14 = Engine[@"hash_4F9F1239CFD921FE"](f529_local15, f529_local8)
				end
			end
			f529_local15 = @"hash_2C18D8F7DBC9D643"
		end
	elseif f529_local9 == 3 and f529_local10 == "21" and f529_local8 and f529_local8 > 0 then
		f529_local13 = "ui_icon_nebulium_medium"
		f529_local14 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F251843889153EE", f529_local8)
	end
	local f529_local15 = "blacktransparent"
	if f529_local6 == "play" then
		f529_local15 = CoD.ContractUtility.GetLootContractIcon(f529_local6, f529_local2)
	else
		f529_local15 = CoD.ContractUtility.GetLootContractIcon(f529_local6, f529_local3)
	end
	return {
		id = f529_local1,
		contractMode = f529_local2,
		displayName = CoDShared.LootContracts.GetContractTitle(f529_local1),
		description = Engine[@"hash_4F9F1239CFD921FE"](f529_local5, f529_local4),
		contractIcon = f529_local15,
		displayMode = f529_local12,
		difficulty = f529_local3,
		target = f529_local4,
		progress = f529_local11,
		progressRatio = f529_local11 / f529_local4,
		progressRatioIngame = 0,
		progressRatioText = Engine[@"hash_4F9F1239CFD921FE"]("blackmarket/x_of_y", f529_local11, f529_local4),
		xpReward = f529_local7,
		rewardType = f529_local9,
		rewardAmount = f529_local8,
		rewardIcon = f529_local13,
		rewardDisplay = f529_local14,
		isDailyZombies = false,
		active = CoDShared.IsBitSet(f529_arg0.flags, Enum[@"hash_B40A0B507A68068"][@"hash_6F7D0F1F6F551B94"]),
		completed = f529_local4 <= f529_local11,
	}
end
CoD.BlackMarketUtility.UpdateActiveContractSlotsModels = function(f530_arg0, f530_arg1)
	local f530_local0 = CoD.BlackMarketUtility.GetContractsRootModel(f530_arg0)
	local f530_local1 = function(f531_arg0, f531_arg1)
		local f531_local0 = f530_local0:create(f531_arg0)
		if f531_arg1 and f531_arg1.models then
			local f531_local1 = f531_arg1.models
			if f530_arg1 then
				local f531_local2 = CoD.BlackMarketUtility.GetContractsInGameModelRoot(f530_arg0)
				local f531_local3 = f531_local2[f531_arg0]
				if f531_local3 and f531_local3.id and f531_local3.progressStart and f531_local3.progressEnd and f531_local3.id:get() == f531_local1.id then
					local f531_local4 = f531_local3.progressStart:get()
					local f531_local5 = f531_local3.progressEnd:get()
					local f531_local6 = f531_local1.target
					f531_local1.progress = f531_local4
					f531_local1.progressRatio = f531_local4 / f531_local6
					f531_local1.progressRatioIngame = f531_local5 / f531_local6
					f531_local1.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"]("blackmarket/x_of_y", f531_local5, f531_local6)
					f531_local1.completed = f531_local6 <= f531_local5
				end
			end
			LuaUtils.CreateModelsFromTable(f531_local0, f531_local1)
		else
			LuaUtils.CreateModelsFromTable(f531_local0, CoD.BlackMarketUtility.GetEmptyContractModelsTable())
		end
	end
	local f530_local2 = CoD.BlackMarketUtility.GetContractsModelTable(f530_arg0, "dailyContracts")
	f530_local1("dailyActive", f530_local2[1])
	local f530_local3 = CoD.BlackMarketUtility.GetContractsModelTable(f530_arg0, "pinnedContracts")
	f530_local1("contractSlot1", f530_local3[1])
	f530_local1("contractSlot2", f530_local3[2])
end
CoD.BlackMarketUtility.UpdateActiveContractSlotModelsForAAR = function(f532_arg0)
	local f532_local0 = CoD.BlackMarketUtility.GetContractsRootModel(f532_arg0)
	local f532_local1 = function(f533_arg0, f533_arg1)
		local f533_local0 = f532_local0:create(f533_arg0)
		if f533_arg1 and f533_arg1.models then
			local f533_local1 = f533_arg1.models
			local f533_local2 = CoD.BlackMarketUtility.GetContractsInGameModelRoot(f532_arg0)
			local f533_local3 = f533_local2[f533_arg0]
			if f533_local3 and f533_local3.id and f533_local3.progressStart and f533_local3.progressEnd and f533_local3.id:get() == f533_local1.id then
				local f533_local4 = f533_local3.progressStart:get()
				local f533_local5 = f533_local3.progressEnd:get()
				local f533_local6 = f533_local1.target
				f533_local1.progress = f533_local4
				f533_local1.progressRatio = f533_local4 / f533_local6
				f533_local1.progressRatioIngame = f533_local5 / f533_local6
				f533_local1.progressRatioText = Engine[@"hash_4F9F1239CFD921FE"]("blackmarket/x_of_y", f533_local5, f533_local6)
				f533_local1.completed = f533_local6 <= f533_local5
			end
			LuaUtils.CreateModelsFromTable(f533_local0, f533_local1)
			if not CoD.BlackMarketUtility.ContractAARModels[f533_arg0] then
				CoD.BlackMarketUtility.ContractAARModels[f533_arg0] = f533_arg1
			end
		else
			local f533_local1 = CoD.BlackMarketUtility.GetEmptyContractModelsTable()
			LuaUtils.CreateModelsFromTable(f533_local0, f533_local1)
			if not CoD.BlackMarketUtility.ContractAARModels[f533_arg0] then
				CoD.BlackMarketUtility.ContractAARModels[f533_arg0] = {
					models = f533_local1,
				}
			end
		end
	end
	if not CoD.BlackMarketUtility.ContractAARModels then
		CoD.BlackMarketUtility.ContractAARModels = {}
		local f532_local2 = CoD.BlackMarketUtility.GetContractsModelTable(f532_arg0, "dailyContracts")
		f532_local1("dailyActive", f532_local2[1])
		local f532_local3 = CoD.BlackMarketUtility.GetContractsModelTable(f532_arg0, "pinnedContracts")
		f532_local1("contractSlot1", f532_local3[1])
		f532_local1("contractSlot2", f532_local3[2])
	else
		f532_local1("dailyActive", CoD.BlackMarketUtility.ContractAARModels.dailyActive)
		f532_local1("contractSlot1", CoD.BlackMarketUtility.ContractAARModels.contractSlot1)
		f532_local1("contractSlot2", CoD.BlackMarketUtility.ContractAARModels.contractSlot2)
	end
end
CoD.BlackMarketUtility.PinContract = function(f534_arg0, f534_arg1, f534_arg2, f534_arg3)
	local f534_local0 = f534_arg2._contractSlot
	local f534_local1 = f534_arg3 or f534_arg1:getModel()
	if f534_local0 and f534_local1 then
		local f534_local2 = f534_local1.id:get()
		local f534_local3 = f534_local1.contractMode:get()
		if f534_local2 and f534_local3 then
			CoD.LootContractsUtility.UpdatePinnedContracts(f534_arg0, f534_local3, f534_local0, f534_local2)
		end
	end
end
CoD.BlackMarketUtility.SetupContractAvailabilityTimers = function(f535_arg0, f535_arg1)
	local f535_local0 = CoD.BlackMarketUtility.GetCurrentContractGameMode(f535_arg0)
	local f535_local1 = CoD.BlackMarketUtility.GetContractsRootModel(f535_arg0)
	local f535_local2 = f535_local1:create("dailyContractsExpired")
	local f535_local3 = f535_local1:create("availableContractsExpired")
	f535_local2:set(false)
	f535_local3:set(false)
	local f535_local4 = CoD.BlackMarketUtility.GetContractStateTable(f535_arg0, f535_local0)
	if f535_local4 then
		local f535_local5 = f535_local1:create("dailyExpirationTime")
		local f535_local6 = f535_local1:create("availableExpirationTime")
		if f535_arg1._availabilityTimer then
			f535_arg1._availabilityTimer:close()
			f535_arg1._availabilityTimer = nil
		end
		if Engine.GetSecondsRemainingServer(f535_local4.dailyExpirationStr or 0) > 0 and Engine.GetSecondsRemainingServer(f535_local4.availableExpirationStr or 0) > 0 then
			f535_arg1._availabilityTimer = LUI.UITimer.newElementTimer(500, false, function(f536_arg0)
				local f536_local0 = Engine.GetSecondsRemainingServer(f535_local4.dailyExpirationStr or 0)
				local f536_local1 = Engine.GetSecondsRemainingServer(f535_local4.availableExpirationStr or 0)
				if f536_local0 > 0 then
					f535_local5:set(LuaUtils.SecondsToTimeRemainingString(f536_local0))
				else
					f535_local2:set(true)
					CoD.OverlayUtility.ShowToast("Content", Engine[@"hash_4F9F1239CFD921FE"](0xA340B260A01392), "")
					Engine.playsound("uin_points_confirmed")
					CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f535_arg0, f535_arg1)
				end
				if f536_local1 > 0 then
					f535_local6:set(LuaUtils.SecondsToTimeRemainingString(f536_local1))
				else
					f535_local3:set(true)
					CoD.OverlayUtility.ShowToast("Content", Engine[@"hash_4F9F1239CFD921FE"](@"hash_73ADF7B901A76D85"), "")
					Engine.playsound("uin_points_confirmed")
					CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f535_arg0, f535_arg1)
				end
			end)
		else
			f535_arg1._availabilityTimer = LUI.UITimer.newElementTimer(1000, false, function(f537_arg0)
				f535_local5:set("")
				f535_local6:set("")
				CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f535_arg0, f535_arg1)
			end)
		end
		f535_arg1:addElement(f535_arg1._availabilityTimer)
	end
end
CoD.BlackMarketUtility.SetupDailyContractTimer = function(f538_arg0, f538_arg1)
	local f538_local0 = CoD.BlackMarketUtility.GetContractsRootModel(f538_arg0)
	local f538_local1 = CoD.BlackMarketUtility.GetContractStateTable(f538_arg0, CoD.BlackMarketUtility.GetCurrentContractGameMode(f538_arg0))
	if f538_local1 then
		local f538_local2 = f538_local0:create("dailyExpirationTime")
		if f538_arg1._dailyContractTimer then
			f538_arg1._dailyContractTimer:close()
			f538_arg1._dailyContractTimer = nil
		end
		if Engine.GetSecondsRemainingServer(f538_local1.dailyExpirationStr or 0) > 0 then
			f538_arg1._dailyContractTimer = LUI.UITimer.newElementTimer(500, false, function(f539_arg0)
				local f539_local0 = Engine.GetSecondsRemainingServer(f538_local1.dailyExpirationStr or 0)
				if f539_local0 > 0 then
					f538_local2:set(LuaUtils.SecondsToTimeRemainingString(f539_local0))
				else
					CoD.BlackMarketUtility.SetupDailyContractTimer(f538_arg0, f538_arg1)
				end
			end)
			if InFrontend() then
				CoD.BlackMarketUtility.UpdateActiveContractSlotModelsForAAR(f538_arg0)
			else
				CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f538_arg0, true)
			end
		else
			f538_arg1._dailyContractTimer = LUI.UITimer.newElementTimer(1000, false, function(f540_arg0)
				f538_local2:set("")
				CoD.BlackMarketUtility.SetupDailyContractTimer(f538_arg0, f538_arg1)
			end)
		end
		f538_arg1:addElement(f538_arg1._dailyContractTimer)
	end
end
CoD.BlackMarketUtility.ClearContractRetryTimer = function(f541_arg0, f541_arg1)
	if f541_arg1._contractRetryTimer then
		f541_arg1._contractRetryTimer:close()
		f541_arg1._contractRetryTimer = nil
	end
end
CoD.BlackMarketUtility.SetupContractRetryTimer = function(f542_arg0, f542_arg1)
	CoD.BlackMarketUtility.ClearContractRetryTimer(f542_arg0, f542_arg1)
	f542_arg1._contractRetryTimer = LUI.UITimer.newElementTimer(3000, false, function(f543_arg0)
		CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f542_arg0, false)
	end)
	f542_arg1:addElement(f542_arg1._contractRetryTimer)
end
CoD.BlackMarketUtility.GetContractHeaderStringFromLobbyMainMode = function(f544_arg0, f544_arg1)
	local f544_local0 = ""
	local f544_local1 = CoD.BlackMarketUtility.GetContractModeOverride(f544_arg0)
	if f544_local1 then
		local f544_local2 = {
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_MP] = "menu/multiplayer",
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WL] = "menu/arena",
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ] = "menu/warzone",
			[CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_ZM] = "menu/zombies",
		}
		local f544_local3 = f544_local2[f544_local1]
		if f544_local3 then
			f544_local0 = LocalizeIntoStringIfNotEmpty(@"hash_5AD22176FB154E74", f544_local3)
		end
		return ToUpper(f544_local0)
	elseif LuaUtils.IsArenaMode() then
		f544_local0 = LocalizeIntoStringIfNotEmpty(@"hash_5AD22176FB154E74", "menu/arena")
	else
		f544_local0 = LocalizeIntoStringIfNotEmpty(@"hash_5AD22176FB154E74", CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f544_arg1))
	end
	return ToUpper(f544_local0)
end
CoD.BlackMarketUtility.GetContractModeOverride = function(f545_arg0)
	return f545_local0.modeOverride and f545_local1 and f545_local0.modeOverride:get()
end
CoD.BlackMarketUtility.ClearContractModeOverride = function(f546_arg0)
	local f546_local0 = DataSources.LootContracts.getModel(f546_arg0)
	if f546_local0 and f546_local0.modeOverride then
		Engine.UnsubscribeAndFreeModel(f546_local0.modeOverride)
	end
end
CoD.BlackMarketUtility.IsActiveContractAvailable = function(f547_arg0, f547_arg1, f547_arg2)
	local f547_local0 = f547_arg2._contractSlot
	if f547_local0 then
		local f547_local1 = CoD.BlackMarketUtility.GetContractsModelTable(f547_arg0, "pinnedContracts")
		local f547_local2 = f547_local1[f547_local0]
		local f547_local3
		if f547_local2 then
			f547_local3 = f547_local2.models.id
			if not f547_local3 then
			else
				if f547_local3 == 0 then
					return true
				end
				for f547_local7, f547_local8 in ipairs(CoD.BlackMarketUtility.GetContractsModelTable(f547_arg0, "availableContracts")) do
					if f547_local8.models.id == f547_local3 then
						return true
					end
				end
			end
		end
		f547_local3 = 0
	end
	return false
end
CoD.BlackMarketUtility.IsActiveContractCompleted = function(f548_arg0, f548_arg1, f548_arg2)
	local f548_local0 = f548_arg2._contractSlot
	if f548_local0 then
		return f548_local2.models and f548_local3 and f548_local2.models.completed
	else
		return false
	end
end
CoD.BlackMarketUtility.ClearCompletedActiveContracts = function(f549_arg0, f549_arg1)
	f549_arg1._clearContractTimer = LUI.UITimer.newElementTimer(4000, true, function(f550_arg0)
		for f550_local4, f550_local5 in ipairs(CoD.BlackMarketUtility.GetContractsModelTable(f549_arg0, "pinnedContracts")) do
			local f550_local6 = f550_local5 and f550_local5.models
			if f550_local6 and f550_local6.completed then
				local f550_local3 = f550_local6.contractMode
				if f550_local3 then
					CoD.LootContractsUtility.UpdatePinnedContracts(f549_arg0, f550_local3, f550_local4, 0)
				end
			end
		end
	end)
	f549_arg1:addElement(f549_arg1._clearContractTimer)
end
DataSources.ContractReplacementOptions = ListHelper_SetupDataSource("ContractReplacementOptions", function(f551_arg0, f551_arg1)
	local f551_local0 = {}
	table.insert(f551_local0, {
		models = {
			displayText = Engine.Localize(@"menu/contract_activate"),
		},
		properties = {
			action = function(f552_arg0, f552_arg1, f552_arg2, f552_arg3)
				CoD.BlackMarketUtility.PinContract(f552_arg2, f552_arg1, f551_arg1.menu, f551_arg1.menu._selectedModel)
				GoBackToMenu(f551_arg1.menu, f552_arg2, "BlackMarketContracts")
			end,
		},
	})
	if not CoD.isPC then
		table.insert(f551_local0, {
			models = {
				displayText = Engine.Localize(@"menu/cancel"),
			},
			properties = {
				action = function(f553_arg0, f553_arg1, f553_arg2, f553_arg3)
					GoBack(f551_arg1.menu, f553_arg2)
				end,
			},
		})
	end
	return f551_local0
end)
CoD.BlackMarketUtility.GetContractsInGameModelRoot = function(f554_arg0)
	local f554_local0 = Engine.GetModelForController(f554_arg0)
	return f554_local0:create("ContractsInGame", true)
end
CoD.BlackMarketUtility.InitInGameContractRecord = function(f555_arg0, f555_arg1)
	local f555_local0 = CoD.BlackMarketUtility.GetContractsInGameModelRoot(f555_arg0)
	f555_arg1._activeContracts = {}
	local f555_local1 = function(f556_arg0, f556_arg1)
		local f556_local0 = f555_local0:create(f556_arg0, true)
		if f556_arg1 and f556_arg1.models then
			local f556_local1 = f556_arg1.models
			local f556_local2 = f556_local1.id
			local f556_local3 = f556_local1.progress
			local f556_local4 = f556_local0:create("id", true)
			f556_local4:set(f556_local2)
			f556_local4 = f556_local0:create("progressStart", true)
			f556_local4:set(f556_local3)
			f556_local4 = f556_local0:create("progressEnd", true)
			f556_local4:set(f556_local3)
			f556_local4 = f556_local0:create("completed", true)
			f556_local4:set(false)
			f555_arg1._activeContracts[f556_local1.id] = f556_local0
		else
			local f556_local1 = f556_local0:create("id", true)
			f556_local1:set(0)
			f556_local1 = f556_local0:create("progressStart", true)
			f556_local1:set(0)
			f556_local1 = f556_local0:create("progressEnd", true)
			f556_local1:set(0)
			f556_local1 = f556_local0:create("completed", true)
			f556_local1:set(false)
		end
	end
	local f555_local2 = CoD.BlackMarketUtility.GetContractsModelTable(f555_arg0, "dailyContracts")
	f555_local1("dailyActive", f555_local2[1])
	local f555_local3 = CoD.BlackMarketUtility.GetContractsModelTable(f555_arg0, "pinnedContracts")
	f555_local1("contractSlot1", f555_local3[1])
	f555_local1("contractSlot2", f555_local3[2])
end
CoD.BlackMarketUtility.UpdateInGameContractRecord = function(f557_arg0, f557_arg1, f557_arg2)
	local f557_local0 = CoD.GetScriptNotifyData(f557_arg1)
	local f557_local1 = f557_local0[1]
	local f557_local2 = f557_local0[2]
	local f557_local3 = f557_arg2._activeContracts
	if f557_local3 then
		local f557_local4 = f557_local3[f557_local1]
		if f557_local4 then
			local f557_local5 = f557_local4:create("progressEnd", true)
			f557_local5:set(f557_local2)
		end
	end
	CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f557_arg0, true)
end
CoD.BlackMarketUtility.RecordCompletedContractInGame = function(f558_arg0, f558_arg1, f558_arg2)
	local f558_local0 = CoD.GetScriptNotifyData(f558_arg1)
	local f558_local1 = f558_local0[1]
	local f558_local2 = f558_arg2._activeContracts
	if f558_local2 then
		local f558_local3 = f558_local2[f558_local1]
		if f558_local3 then
			local f558_local4 = f558_local3:create("completed", true)
			f558_local4:set(true)
		end
	end
end
CoD.BlackMarketUtility.DelayedContractReveal = function(f559_arg0, f559_arg1)
	if f559_arg1._revealTimer then
		f559_arg1._revealTimer:close()
		f559_arg1._revaalTimer = nil
	end
	f559_arg1._revealTimer = LUI.UITimer.newElementTimer(250, true, function(f560_arg0)
		PlayClipOnElement(f559_arg1, {
			elementName = "BMContractReveal",
			clipName = "New",
		}, f559_arg0)
	end)
	f559_arg1:addElement(f559_arg1._revealTimer)
end
CoD.BlackMarketUtility.ShowFreePickWeaponBribeFTUEIfNeeded = function(f561_arg0, f561_arg1)
	if CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f561_arg1) then
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(f561_arg0, f561_arg1, "FreePickWeaponBribe")
	end
end
CoD.BlackMarketUtility.IsHalfOffPickWeaponBribeActive = function()
	return IsBooleanDvarSet(0xA3BEC37CA7ABDA9)
end
CoD.BlackMarketUtility.IsFreePickWeaponBribeActive = function()
	return IsBooleanDvarSet(0xED6058A5D5D8309)
end
CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable = function(f564_arg0)
	if CoD.BlackMarketUtility.IsFreePickWeaponBribeActive() then
		if Engine[@"hash_5352DC095BBB2A45"](f564_arg0, CoD.BlackMarketUtility.FreeBribeSentinelMay2020) > 0 then
			return false
		else
			return CoD.BlackMarketTableUtility.PlayerHasUnownedWeaponBribe(f564_arg0)
		end
	else
		return false
	end
end
CoD.BlackMarketUtility.ShouldShowWeaponBribeTimer = function(f565_arg0)
	local f565_local0
	if not IsBooleanDvarSet(@"hash_78794D44313B8D66") and not IsBooleanDvarSet(0xA3BEC37CA7ABDA9) then
		f565_local0 = not CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f565_arg0)
	else
		f565_local0 = false
	end
	return f565_local0
end
CoD.BlackMarketUtility.ShouldShowWeaponBribeHalfOffTimer = function(f566_arg0)
	return IsBooleanDvarSet(0xA3BEC37CA7ABDA9) and not CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f566_arg0)
end
DataSources.BribeStackList = ListHelper_SetupDataSource(
	"BribeStackList",
	function(f567_arg0)
		local f567_local0 = {}
		for f567_local4, f567_local5 in ipairs(CoD.BlackMarketUtility.BribeStack) do
			local f567_local6 = CoD.BlackMarketUtility.GetBribeAsset(f567_arg0, f567_local5.hashName)
			local f567_local7 = CoD.BlackMarketTableUtility.GetBribeCPAndCasePrice(f567_arg0, f567_local5.hashName)
			local f567_local8 = Engine.GetSecondsRemainingServer(f567_local5.nextAvailableTime) > 0
			if f567_local7 and f567_local6 then
				table.insert(f567_local0, {
					models = {
						name = f567_local6.name,
						desc = f567_local6.desc,
						price = f567_local7.price,
						casePrice = f567_local7.casePrice,
						popupImage = f567_local6.popupImage,
						stackImage = f567_local6.stackImage,
						stackTallImage = f567_local6.stackTallImage,
						lootRule = f567_local5.lootRule,
						timer = f567_local5.name,
						purchased = f567_local8,
						hashName = f567_local5.hashName,
						slot = 4,
						percentOff = 0,
					},
				})
			end
		end
		return f567_local0
	end,
	nil,
	nil,
	function(f568_arg0, f568_arg1, f568_arg2)
		if not f568_arg1.__bribeStackSubscriptions then
			f568_arg1.__bribeStackSubscriptions = true
			f568_arg1:subscribeToGlobalModel(f568_arg0, "BribeStackTimer", "cycled", function()
				f568_arg1:updateDataSource()
			end)
		end
	end
)
DataSources.BribeMenuList = ListHelper_SetupDataSource(
	"BribeMenuList",
	function(f570_arg0)
		local f570_local0 = {}
		local f570_local1 = "bribe_menu_asset"
		local f570_local2 = CoD.BlackMarketUtility.GetBribeAsset(f570_arg0, f570_local1)
		local f570_local3 = CoD.BlackMarketTableUtility.GetWeaponBribeSelectionBribes(f570_arg0)
		local f570_local4 = f570_local3[1]
		local f570_local5 = not CoD.BlackMarketUtility.WeaponBribeSelectionAvailable(f570_arg0)
		local f570_local6 = CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f570_arg0)
		local f570_local7
		if not f570_local6 then
			f570_local7 = CoD.BlackMarketUtility.IsHalfOffPickWeaponBribeActive()
		else
			f570_local7 = false
		end
		local f570_local8
		if f570_local7 then
			f570_local8 = 50
			if not f570_local8 then
			else
				if f570_local4 and f570_local2 and IsBooleanDvarSet(@"hash_437458347055B83") then
					table.insert(f570_local0, {
						models = {
							name = f570_local2.name,
							desc = f570_local2.desc,
							price = f570_local4.price,
							casePrice = f570_local4.optionalCost,
							popupImage = f570_local2.popupImage,
							stackImage = f570_local2.stackImage,
							stackTallImage = f570_local2.stackTallImage,
							lootRule = CoD.BlackMarketUtility.BribeMenuLootRule,
							timer = "bribe_menu_timer",
							purchased = f570_local5,
							hashName = f570_local1,
							isFreePickWeaponBribeAvailable = f570_local6,
							isHalfOffPickWeaponBribe = f570_local7,
							slot = 4,
							percentOff = f570_local8,
						},
					})
				end
				return f570_local0
			end
		end
		f570_local8 = 0
	end,
	nil,
	nil,
	function(f571_arg0, f571_arg1, f571_arg2)
		if not f571_arg1.__bribeMenuSubscriptions then
			f571_arg1.__bribeMenuSubscriptions = true
			f571_arg1:subscribeToGlobalModel(f571_arg0, "BribeMenuTimer", "cycled", function()
				f571_arg1:updateDataSource()
			end)
			f571_arg1._prevIsHalfOffWeaponBribeActive = CoD.BlackMarketUtility.IsHalfOffPickWeaponBribeActive()
			f571_arg1._prevIsFreeWeaponBribeAvailable = CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f571_arg0)
			f571_arg1:subscribeToGlobalModel(f571_arg0, "AutoEvents", "cycled", function()
				local f573_local0 = CoD.BlackMarketUtility.IsHalfOffPickWeaponBribeActive()
				local f573_local1 = CoD.BlackMarketUtility.IsFreePickWeaponBribeAvailable(f571_arg0)
				if f573_local0 ~= f571_arg1._prevIsHalfOffWeaponBribeActive or f573_local1 ~= f571_arg1._prevIsFreeWeaponBribeAvailable then
					f571_arg1._prevIsHalfOffWeaponBribeActive = f573_local0
					f571_arg1._prevIsFreeWeaponBribeAvailable = f573_local1
					f571_arg1:updateDataSource()
				end
			end)
		end
	end
)
DataSources.NoDupeBribeStack = ListHelper_SetupDataSource(
	"NoDupeBribeStack",
	function(f574_arg0)
		local f574_local0 = {}
		local f574_local1 = "no_dupe_crate"
		local f574_local2 = 0
		if IsBooleanDvarSet(@"hash_648522A533967154") then
			f574_local1 = "half_off_no_dupe_crate"
			f574_local2 = 50
		end
		local f574_local3 = CoD.BlackMarketTableUtility.GetBribeInformation(f574_arg0, f574_local1)
		if f574_local3 then
			local f574_local4 = CoD.BlackMarketUtility.GetBribeAsset(f574_arg0, f574_local1)
			local f574_local5 = CoD.BlackMarketTableUtility.GetBribeCPAndCasePrice(f574_arg0, f574_local1)
			local f574_local6 = false
			if f574_local5 and f574_local4 then
				if not IsBooleanDvarSet(@"hash_1539A350E73051B8") then
					f574_local5.price = 0
				end
				table.insert(f574_local0, {
					models = {
						name = f574_local4.name,
						desc = f574_local4.desc,
						price = f574_local5.price,
						casePrice = f574_local5.casePrice,
						popupImage = f574_local4.popupImage,
						stackImage = f574_local4.stackImage,
						stackTallImage = f574_local4.stackTallImage,
						lootRule = f574_local3.lootRule,
						timer = nil,
						purchased = f574_local6,
						hashName = f574_local3.name,
						isCrateItem = true,
						slot = 5,
						percentOff = f574_local2,
					},
				})
			end
		end
		return f574_local0
	end,
	nil,
	nil,
	function(f575_arg0, f575_arg1, f575_arg2)
		if not f575_arg1.__noDupeBribeStackSubscriptions then
			f575_arg1.__noDupeBribeStackSubscriptions = true
			f575_arg1:subscribeToGlobalModel(f575_arg0, "AutoEvents", "cycled", function()
				f575_arg1:updateDataSource()
			end)
		end
	end
)
CoD.BlackMarketUtility.TestMyShopItem = function(f577_arg0, f577_arg1)
	if Engine[@"isdevelopmentbuild"]() then
		Engine[@"hash_45FDA5F675A65C94"](0, CoD.BlackMarketTableUtility.GetMyShopItemId(0, Engine[@"converttoxhash"](f577_arg0)), Engine.GetCurrentUTCTimeStr(), tonumber(f577_arg1))
		Engine.StorageWrite(0, Enum.StorageFileType[@"storage_mp_stats_online"])
		Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "MyShop: '" .. f577_arg0 .. "' at price point: " .. f577_arg1 .. " has been activated.\n")
	end
end
CoD.BlackMarketUtility.PurchaseAtPricePoint = function(f578_arg0, f578_arg1, f578_arg2, f578_arg3, f578_arg4)
	if Engine[@"isdevelopmentbuild"]() then
		local f578_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f578_arg0, false)
		local f578_local1 = #f578_local0
		if f578_arg1 <= f578_local1 then
			local f578_local2 = nil
			local f578_local3 = false
			while not f578_local3 do
				f578_local2 = f578_local0[f578_arg1]
				if f578_local2.pricePoint == f578_arg2 then
					f578_local3 = true
					f578_arg3 = f578_arg3 + 1
				end
			end
			local f578_local4 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f578_arg0, f578_local2.name, f578_arg2)
			if f578_local4 and f578_local4.cpSku and f578_arg4 == true then
				Engine.exec(f578_arg0, "purchaseSKU " .. f578_local4.cpSku .. " 1")
				LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
					if not Engine.IsInventoryBusy(f578_arg0) and Engine.GetPurchaseDWSKUResult(f578_arg0) ~= Enum.InventoryPurchaseResult[@"inventory_purchase_result_inprogress"] then
						LUI.roots.UIRootFull._testTimer:close()
						LUI.roots.UIRootFull._testTimer = nil
						local f579_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f578_arg0, false)
						local f579_local1 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f578_arg0, f579_local0[f578_arg1].name, f578_arg2)
						if Engine.GetPurchaseDWSKUResult(f578_arg0) == Enum.InventoryPurchaseResult[@"inventory_purchase_result_success"] then
							Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f578_arg3 .. " purchase success for sku: " .. f579_local1.cpSku .. "\n")
						else
							Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f578_arg3 .. " purchase failed for sku: " .. f579_local1.cpSku .. "\n")
						end
						CoD.BlackMarketUtility.PurchaseAtPricePoint(f578_arg0, f578_arg1, f578_arg2, f578_arg3, f578_arg4)
					end
				end)
				LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
			end
			if f578_local4 and f578_local4.caseRule and f578_arg4 == false then
				Engine.exec(f578_arg0, "applyConversion " .. f578_local4.caseRule)
				LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
					if not Engine.IsInventoryBusy(f578_arg0) and Engine[@"hash_525090566AF670C"](f578_arg0) ~= Enum[@"hash_198BB5B1F9A186F6"][@"hash_41A1F8568C1B8A5D"] then
						LUI.roots.UIRootFull._testTimer:close()
						LUI.roots.UIRootFull._testTimer = nil
						local f580_local0 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f578_arg0, false)
						local f580_local1 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f578_arg0, f580_local0[f578_arg1].name, f578_arg2)
						if Engine[@"hash_525090566AF670C"](f578_arg0) == Enum[@"hash_198BB5B1F9A186F6"][@"hash_19180C0E9D90CC4"] then
							Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f578_arg3 .. " exchange success for rule: " .. f580_local1.caseRule .. "\n")
						else
							Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_loot"], "Item " .. f578_arg3 .. " exchange failed for rule: " .. f580_local1.caseRule .. "\n")
						end
						CoD.BlackMarketUtility.PurchaseAtPricePoint(f578_arg0, f578_arg1, f578_arg2, f578_arg3, f578_arg4)
					end
				end)
				LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
			else
			end
			f578_arg1 = f578_arg1 + 1
			if f578_local1 < f578_arg1 then
				Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "Purchases for pricepoint " .. f578_arg2 .. " completed with total " .. f578_arg3 .. " transactions. \n")
				return
			end
		end
	end
end
CoD.BlackMarketUtility.TestPurchaseDeterministicItemSkus = function(f581_arg0)
	local f581_local0 = 0
	if Engine[@"isdevelopmentbuild"]() then
		local f581_local1 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f581_local0, true)
		CoD.BlackMarketUtility.PurchaseAtPricePoint(f581_local0, 1, f581_arg0, 0, true)
	end
end
CoD.BlackMarketUtility.TestPurchaseDeterministicItemExchanges = function(f582_arg0)
	local f582_local0 = 0
	if Engine[@"isdevelopmentbuild"]() then
		local f582_local1 = CoD.BlackMarketTableUtility.GetAllDeterministicItem(f582_local0, true)
		CoD.BlackMarketUtility.PurchaseAtPricePoint(f582_local0, 1, f582_arg0, 0, false)
	end
end
CoD.BlackMarketUtility.TestPurchaseItem = function(f583_arg0, f583_arg1, f583_arg2, f583_arg3, f583_arg4)
	if Engine[@"isdevelopmentbuild"]() then
		local f583_local0 = f583_arg3 == Enum[@"hash_1CF7389DF8F39785"][@"hash_2AD9FB648E0B9A55"]
		local f583_local1 = nil
		local f583_local2 = 0
		local f583_local3, f583_local4 = nil
		local f583_local5 = false
		if f583_arg1 and f583_arg1._currentTab == "itemshop" then
			local f583_local6 = Engine[@"hash_6F2CB6360236F359"](f583_arg0, f583_arg3)
			f583_local3 = f583_local6.itemId
			f583_local5 = CoD.BlackMarketUtility.IsItemPurchased(f583_arg0, f583_local3)
			if not f583_local5 then
				if f583_local0 then
					f583_local4 = CoD.BlackMarketTableUtility.GetContrabandXHashFromItemID(f583_arg0, f583_local3)
				else
					f583_local2 = f583_local6.price_point
					f583_local4 = CoD.BlackMarketTableUtility.GetDeterministicItemNameFromId(f583_arg0, f583_local3)
				end
			end
		else
			local f583_local6 = CoD.BlackMarketUtility.RevealItemShopSunsetSlotItem(f583_arg0, f583_arg3)
			if f583_local6 then
				f583_local3 = f583_local6.itemId
				f583_local4 = f583_local6.itemNameHash
				f583_local2 = f583_local6.pricePoint
			else
				f583_local5 = true
			end
		end
		if f583_local5 then
			Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "Purchase completed. No more items to reveal in this slot. \n")
			return
		elseif f583_local0 then
			f583_local1 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f583_arg0, f583_local3, 0)
		else
			f583_local1 = CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices(f583_arg0, f583_local4, f583_local2)
		end
		if f583_local1 and f583_local1.caseRule and f583_arg4 == false then
			Engine.exec(f583_arg0, "applyConversion " .. f583_local1.caseRule)
			LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
				if not Engine.IsInventoryBusy(f583_arg0) and Engine[@"hash_525090566AF670C"](f583_arg0) ~= Enum[@"hash_198BB5B1F9A186F6"][@"hash_41A1F8568C1B8A5D"] then
					LUI.roots.UIRootFull._testTimer:close()
					LUI.roots.UIRootFull._testTimer = nil
					if Engine[@"hash_525090566AF670C"](f583_arg0) == Enum[@"hash_198BB5B1F9A186F6"][@"hash_19180C0E9D90CC4"] then
						Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], f583_arg2 .. ". Item exchange success for rule: " .. f583_local1.caseRule .. ", Price " .. f583_local1.casePrice .. " Cases, Price Point " .. f583_local2 .. ". Item ID: " .. f583_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f583_local4) .. " \n")
					else
						Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_loot"], f583_arg2 .. ". Item exchange failed for rule: " .. f583_local1.caseRule .. ", Price " .. f583_local1.casePrice .. " Cases, Price Point " .. f583_local2 .. ". Item ID: " .. f583_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f583_local4) .. " \n")
					end
					f583_arg2 = f583_arg2 - 1
					if f583_arg2 <= 0 then
						Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "Purchase completed. \n")
						return
					end
					CoD.BlackMarketUtility.TestPurchaseItem(f583_arg0, f583_arg1, f583_arg2, f583_arg3, f583_arg4)
				end
			end)
			LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
		end
		if f583_local1 and f583_local1.cpSku and f583_arg4 == true then
			Engine.exec(f583_arg0, "purchaseSKU " .. f583_local1.cpSku .. " 1")
			LUI.roots.UIRootFull._testTimer = LUI.UITimer.newElementTimer(1000, false, function()
				if not Engine.IsInventoryBusy(f583_arg0) and Engine.GetPurchaseDWSKUResult(f583_arg0) ~= Enum.InventoryPurchaseResult[@"inventory_purchase_result_inprogress"] then
					LUI.roots.UIRootFull._testTimer:close()
					LUI.roots.UIRootFull._testTimer = nil
					if Engine.GetPurchaseDWSKUResult(f583_arg0) == Enum.InventoryPurchaseResult[@"inventory_purchase_result_success"] then
						Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], f583_arg2 .. ". Item purchase success for sku: " .. f583_local1.cpSku .. ", Price " .. f583_local1.cpPrice .. " CP, Price Point " .. f583_local2 .. ". Item ID: " .. f583_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f583_local4) .. " \n")
					else
						Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_loot"], f583_arg2 .. ". Item purchase failed for sku: " .. f583_local1.cpSku .. ", Price " .. f583_local1.cpPrice .. " CP, Price Point " .. f583_local2 .. ". Item ID: " .. f583_local3 .. ", Item Name " .. LUI.DEV.GetElementNameStringFromHash(f583_local4) .. " \n")
					end
					f583_arg2 = f583_arg2 - 1
					if f583_arg2 <= 0 then
						Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_loot"], "Purchase completed. \n")
						return
					end
					CoD.BlackMarketUtility.TestPurchaseItem(f583_arg0, f583_arg1, f583_arg2, f583_arg3, f583_arg4)
				end
			end)
			LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull._testTimer)
		end
	end
end
CoD.BlackMarketUtility.TestRevealAndPurchaseBySlot = function(f586_arg0, f586_arg1, f586_arg2)
	local f586_local0 = 0
	local f586_local1 = CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex(f586_arg0)
	if Engine[@"isdevelopmentbuild"]() then
		if CoD.BlackMarketUtility.GetBJShopSlotEnumForSlotIndex(f586_arg0) ~= Enum[@"hash_1CF7389DF8F39785"][@"hash_2663480BB5520C59"] then
			CoD.BlackMarketUtility.TestPurchaseItem(f586_local0, CoD.perController[f586_local0].blackMarketTestMenu, f586_arg1, f586_local1, f586_arg2)
		else
			Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_loot"], "Incorrect slot number passed to the test function. Allowed slot numbers are: <1,2,3> \n")
		end
	end
end
CoD.BlackMarketUtility.TestOpenCrateByCurrency = function()
	CoD.BlackMarketUtility.OpenCrateByCurrency(0, CoD.BlackMarketUtility.CrateStreams.THREE_PACK)
end
CoD.BlackMarketUtility.TestOpenNoDupeCrate = function()
	local f588_local0 = 0
	for f588_local5, f588_local6 in ipairs(CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes(0)) do
		if f588_local6.name == "no_dupe_crate" then
			f588_local0 = f588_local6.lootRule
			local f588_local4 = Engine[@"hash_26C232D7031CE1CF"](0, f588_local0, CoDShared.Loot.GetBribePayload(controller, nil, f588_local0))
			Engine.SendClientScriptNotify(0, "BlackJackReserve", {
				status = "OpenCrate",
				crateId = "1001",
				result = f588_local4,
			})
			return f588_local4 == 1
		end
	end
end
CoD.BlackMarketUtility.SetBlackMarketMenuForTest = function(f589_arg0, f589_arg1)
	if not Engine[@"isdevelopmentbuild"]() then
		return
	else
		CoD.perController[f589_arg0].blackMarketTestMenu = f589_arg1
	end
end
CoD.BlackMarketUtility.ClearBlackMarketMenuForTest = function(f590_arg0)
	if not Engine[@"isdevelopmentbuild"]() then
		return
	else
		CoD.perController[f590_arg0].blackMarketTestMenu = nil
	end
end
