
require( "x64:f3c5259f470592d" )
CoD.CACUtility = {}
CoD.CACUtility.MAX_UNLOCKABLE_ITEMS = 1024
CoD.CACUtility.slotContainerAlpha = 0.04
CoD.CACUtility.defaultCustomClassCount = 5
CoD.CACUtility.maxCustomClass = 5
CoD.CACUtility.maxSpecialtySlots = 6
CoD.CACUtility.maxTalentsSlots = 6
CoD.CACUtility.maxPerks = 12
CoD.CACUtility.maxSelectableScorestreaks = 3
CoD.CACUtility.maxScorestreaks = CoD.CACUtility.maxSelectableScorestreaks + 1
CoD.CACUtility.maxPrimaryAttachments = 6
CoD.CACUtility.maxSecondaryAttachments = 6
CoD.CACUtility.maxPerkCategories = 3
CoD.CACUtility.maxPerksInEachCategory = 2
CoD.CACUtility.maxBonusCards = CoDLoadoutsShared.MaxBonusCards
CoD.CACUtility.maxDefaultClass = 5
CoD.CACUtility.maxPrimaryGunfighters = 3
CoD.CACUtility.maxSecondaryGunfighters = 3
CoD.CACUtility.maxTalismans = 1
CoD.CACUtility.maxWeaponPrestige = 2
CoD.CACUtility.maxAttachments = {
	primary = CoD.CACUtility.maxPrimaryAttachments,
	secondary = CoD.CACUtility.maxSecondaryAttachments
}
CoD.CACUtility.maxAllocation = CoDLoadoutsShared.MaxAllocation
CoD.CACUtility.mpPrestigeAttachments = {
	{
		ref = "clantag",
		itemIndex = 4,
		plevel = 1,
		name = @"hash_217EEF154FE86377",
		image = @"cac_mods_clan_tag",
		unlockDescRef = @"hash_766658F1A18557C1"
	},
	{
		ref = "killcounter",
		itemIndex = 34,
		plevel = 2,
		name = @"mpui/killcounter",
		image = @"cac_mods_kill_counter",
		unlockDescRef = @"hash_C8CDEE70D07873D"
	}
}
CoD.CACUtility.primaryWeaponPrestigeSlot = "attachment." .. CoD.CACUtility.maxPrimaryAttachments + 1
CoD.CACUtility.secondaryWeaponPrestigeSlot = "attachment." .. CoD.CACUtility.maxSecondaryAttachments + 1
CoD.CACUtility.WeaponCharmAttachment = {
	ref = "custom2",
	itemIndex = 6,
	pathName = "charmIndex"
}
CoD.CACUtility.talentGreedStartSlot = 4
CoD.CACUtility.ButtonGridLockImageSize = 40
CoD.CACUtility.LockImageMaterial = "menu_mp_lobby_locked"
CoD.CACUtility.ButtonGridBigLockImageSize = 64
CoD.CACUtility.ButtonGridNewImageWidth = 64
CoD.CACUtility.ButtonGridNewImageHeight = 32
CoD.CACUtility.ButtonGridNewImageRightAlignWidth = 32
CoD.CACUtility.LockImageBigMaterial = "menu_mp_lobby_locked_big"
CoD.CACUtility.NewImageMaterial = "menu_mp_lobby_new"
CoD.CACUtility.DefaultLoadoutImage = "blacktransparent"
CoD.CACUtility.DefaultClassItemImage = "menu_mp_lobby_none_selected"
CoD.CACUtility.removeSFX = "cac_cmn_item_remove"
CoD.CACUtility.denySFX = "cac_cmn_deny"
CoD.CACUtility.carouselLRSFX = "cac_slide_nav_lr"
CoD.CACUtility.carouselUpSFX = "cac_slide_nav_up"
CoD.CACUtility.carouselDownSFX = "cac_slide_nav_down"
CoD.CACUtility.carouselEquipSFX = "cac_slide_equip_item"
CoD.CACUtility.GainFocusSFX = "cac_loadout_nav"
CoD.CACUtility.WildcardGainFocusSFX = "cac_loadout_wildcard_nav"
CoD.CACUtility.UpdateSpecialistEventNotify = "updateSpecialistCustomization"
CoD.CACUtility.classModels = {}
CoD.CACUtility.unlockTokenModel = {}
CoD.CACUtility.EXTRA_SLOTS_COD_POINTS_COST = 300
CoD.CACUtility.loadoutSlotDDLNames = CoDShared.LoadoutSlotOrder
CoD.CACUtility.overCapacityLoadoutSlotOrder = {
	"primary",
	"primary.attachment.1",
	"primary.attachment.2",
	"primary.attachment.3",
	"primary.attachment.4",
	"primary.attachment.5",
	"primary.attachment.6",
	"secondary",
	"secondary.attachment.1",
	"secondary.attachment.2",
	"secondary.attachment.3",
	"secondary.attachment.4",
	"secondary.attachment.5",
	"secondary.attachment.6",
	"tacticalgear",
	"primarygrenade",
	"primarygrenadecount",
	"talent.1",
	"talent.4",
	"talent.2",
	"talent.5",
	"talent.3",
	"talent.6",
	"bonuscard.1",
	"bonuscard.2",
	"bonuscard.3"
}
CoD.CACUtility.LootMeleeWeapons = {
	"melee_knuckles",
	"melee_butterfly",
	"melee_wrench",
	"melee_crowbar",
	"melee_sword"
}
CoD.CACUtility.WeaponsWithNoCPCamos = {
	bowie_knife = true,
	knife_loadout = true,
	melee_knuckles = true,
	melee_butterfly = true,
	melee_wrench = true,
	pistol_shotgun = true,
	melee_crowbar = true,
	melee_sword = true,
	ar_garand = true,
	special_crossbow = true
}
CoD.CACUtility.WeaponsWithNoMPCamos = {
	bowie_knife = true,
	launcher_standard_df = true
}
CoD.CACUtility.WeaponsWithNoZMCamos = {
	pistol_standard = true,
	knife_loadout = true,
	launcher_lockonly = true,
	smg_longrange = true,
	ar_fastburst = true,
	sniper_chargeshot = true,
	launcher_standard_df = true,
	melee_knuckles = true,
	melee_butterfly = true,
	melee_wrench = true,
	pistol_shotgun = true,
	melee_crowbar = true,
	melee_sword = true,
	ar_garand = true,
	special_crossbow = true
}
CoD.CACUtility.PregameLoadoutFilters = {
	{
		filters = {
			primary = true,
			secondary = true
		},
		title = @"hash_2E8E97B711AC8F24"
	},
	{
		filters = {
			attachment = true
		},
		title = @"hash_56E6F15BA89EEED"
	},
	{
		filters = {
			herogadget = true
		},
		title = @"hash_3D12E79149B2165D"
	},
	{
		filters = {
			specialty1 = true,
			specialty2 = true,
			specialty3 = true
		},
		title = @"hash_28BDD7F912E1E764"
	},
	{
		filters = {
			killstreak1 = true,
			killstreak2 = true,
			killstreak3 = true
		},
		title = @"hash_2D17CC7D16033AEA"
	}
}
CoD.CACUtility.CreateList = function ( f1_arg0, f1_arg1, f1_arg2 )
	local f1_local0 = {}
	for f1_local1 = f1_arg1, f1_arg2, 1 do
		table.insert( f1_local0, f1_arg0 .. f1_local1 )
	end
	return f1_local0
end
CoD.CACUtility.PrimaryWeaponSlotNameList = {
	"primary"
}
CoD.CACUtility.PrimaryAttachmentSlotNameList = CoD.CACUtility.CreateList( "primary.attachment.", 1, CoD.CACUtility.maxPrimaryAttachments )
table.insert( CoD.CACUtility.PrimaryAttachmentSlotNameList, "primary." .. CoD.CACUtility.primaryWeaponPrestigeSlot )
CoD.CACUtility.SecondaryWeaponSlotNameList = {
	"secondary"
}
CoD.CACUtility.SecondaryAttachmentSlotNameList = CoD.CACUtility.CreateList( "secondary.attachment.", 1, CoD.CACUtility.maxSecondaryAttachments )
table.insert( CoD.CACUtility.SecondaryAttachmentSlotNameList, "secondary." .. CoD.CACUtility.secondaryWeaponPrestigeSlot )
CoD.CACUtility.AttachmentArrays = {
	attachment = {
		size = 5,
		ddlPath = "attachment"
	}
}
CoD.CACUtility.PrimaryGrenadeWeaponSlotNameList = {
	"primarygrenade"
}
CoD.CACUtility.SpecialGrenadeWeaponSlotNameList = {
	"specialgrenade"
}
CoD.CACUtility.CompletePerkSlotNameList = CoD.CACUtility.CreateList( "specialty", 1, CoD.CACUtility.maxPerkCategories * CoD.CACUtility.maxPerksInEachCategory )
CoD.CACUtility.SelectableKillstreakNameList = CoD.CACUtility.CreateList( "killstreak", 1, CoD.CACUtility.maxSelectableScorestreaks )
CoD.CACUtility.KillstreakNameList = CoD.CACUtility.CreateList( "killstreak", 1, CoD.CACUtility.maxScorestreaks )
CoD.CACUtility.HeroWeaponList = {
	"heroweapon"
}
CoD.CACUtility.HeroAbilityList = {
	"herogadget"
}
CoD.CACUtility.TalentSlotNameList = CoD.CACUtility.CreateList( "talent.", 1, CoD.CACUtility.maxTalentsSlots )
CoD.CACUtility.BonuscardSlotNameList = CoDLoadoutsShared.BonuscardSlotNameList
CoD.CACUtility.TacticalGearSlotNameList = {
	"tacticalgear"
}
CoD.CACUtility.TalismanSlotNameList = {}
CoD.CACUtility.TalismanSlotNameList = CoD.CACUtility.CreateList( "talisman", 1, CoD.CACUtility.maxTalismans )
CoD.CACUtility.SlotLists = {
	CoD.CACUtility.PrimaryWeaponSlotNameList,
	CoD.CACUtility.PrimaryAttachmentSlotNameList,
	CoD.CACUtility.SecondaryWeaponSlotNameList,
	CoD.CACUtility.SecondaryAttachmentSlotNameList,
	CoD.CACUtility.PrimaryGrenadeWeaponSlotNameList,
	CoD.CACUtility.SpecialGrenadeWeaponSlotNameList,
	CoD.CACUtility.SelectableKillstreakNameList,
	CoD.CACUtility.CompletePerkSlotNameList,
	CoD.CACUtility.HeroWeaponList,
	CoD.CACUtility.HeroAbilityList,
	CoD.CACUtility.TalentSlotNameList,
	CoD.CACUtility.TacticalGearSlotNameList,
	CoD.CACUtility.BonuscardSlotNameList,
	CoD.CACUtility.TalismanSlotNameList
}
CoD.CACUtility.EmptyItemIndex = CoDShared.EmptyItemIndex
CoD.CACUtility.OpticSlotIndex = 1
CoD.CACUtility.AttachmentSlotIndexStart = 2
CoD.CACUtility.AttachmentSlotIndexEnd = 6
CoD.CACUtility.UberIndexSlot = 5
CoD.CACUtility.HiddenSlotIndexForUber = 6
CoD.CACUtility.talismanItemGroup = "invalidGroup"
CoD.CACUtility.talismanItemGroupName = 0x0
CoD.CACUtility.talismanItemGroup = "talisman"
CoD.CACUtility.talismanItemGroupName = @"hash_79DFC3F74D959FCF"
CoD.CACUtility.ItemGroupInfo = {
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_smg"],
		itemGroup = "weapon_smg",
		name = @"hash_1E9B2FF3482C8EA1"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_assault"],
		itemGroup = "weapon_assault",
		name = 0x263912D4D64BFF
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_tactical"],
		itemGroup = "weapon_tactical",
		name = @"hash_65ADE1A7D645B04D"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_cqb"],
		itemGroup = "weapon_cqb",
		name = @"hash_27C39AF395743C5E"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_lmg"],
		itemGroup = "weapon_lmg",
		name = @"hash_774A30F3C2F15054"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_sniper"],
		itemGroup = "weapon_sniper",
		name = @"hash_724E0A3718D6D7BB"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_pistol"],
		itemGroup = "weapon_pistol",
		name = @"hash_5EEF32CF83BA78B7"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_launcher"],
		itemGroup = "weapon_launcher",
		name = @"hash_767CE9DB33F369C0"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_knife"],
		itemGroup = "weapon_knife",
		name = @"hash_43FA68FFF58A9A11"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_special"],
		itemGroup = "weapon_special",
		name = 0xA10CE7D326D52B
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_grenade"],
		itemGroup = "weapon_grenade",
		name = @"hash_419925BCDA35F9BE"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_masterkey"],
		itemGroup = "weapon_masterkey",
		name = @"hash_469F815EDB5DE8CD"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_grenadelauncher"],
		itemGroup = "weapon_grenadelauncher",
		name = @"hash_4D630705EA8B45D2"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_flamethrower"],
		itemGroup = "weapon_flamethrower",
		name = @"hash_6F38A8FD02924F86"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_specialty"],
		itemGroup = "specialty",
		name = @"menu/perks"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_talisman"],
		itemGroup = CoD.CACUtility.talismanItemGroup,
		name = CoD.CACUtility.talismanItemGroupName
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_specialgrenade"],
		itemGroup = "specialgrenade",
		name = @"hash_7D69F54EAF20DCFF"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_miscweapon"],
		itemGroup = "miscweapon",
		name = @"hash_32555CAB998C64C0"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_feature"],
		itemGroup = "feature",
		name = @"hash_47C2C9F4B09224A6"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_bonuscard"],
		itemGroup = "bonuscard",
		name = @"hash_415A61D25BFBC0C5"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_killstreak"],
		itemGroup = "killstreak",
		name = @"hash_576B878474B7118E"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_hero"],
		itemGroup = "hero",
		name = @"hash_3247ABAAC425E94C"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_talent"],
		itemGroup = "talent",
		name = @"hash_77090E9AC325856A"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"itemgroup_bubblegum"],
		itemGroup = "bubblegum",
		name = @"hash_F7823CCF486C039"
	},
	{
		itemGroupEnum = Enum[@"itemgroup_t"][@"hash_5222CEB2EEB25384"],
		itemGroup = "bubblegum_consumable",
		name = @"hash_32B979AF4577D926"
	}
}
CoD.CACUtility.PrimaryWeaponGroupNames = {
	{
		index = 1,
		weapon_category = "weapon_assault",
		name = @"hash_7FE1B0B2003A6CC1",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_assault"]
	},
	{
		index = 2,
		weapon_category = "weapon_smg",
		name = @"hash_35A1E94F52AC6DAB",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_smg"]
	},
	{
		index = 3,
		weapon_category = "weapon_tactical",
		name = @"hash_1FB38D2633FBBEC7",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_tactical"]
	},
	{
		index = 4,
		weapon_category = "weapon_lmg",
		name = @"hash_6DB6F169E46CD4E4",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_lmg"]
	},
	{
		index = 5,
		weapon_category = "weapon_sniper",
		name = @"hash_2EF865AD574F5FAD",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_sniper"]
	}
}
CoD.CACUtility.SecondaryWeaponGroupNames = {
	{
		index = 6,
		weapon_category = "weapon_pistol",
		name = @"hash_31F931942007CAB9",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_pistol"]
	},
	{
		index = 7,
		weapon_category = "weapon_cqb",
		name = @"hash_72584C59DF32630E",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_cqb"]
	},
	{
		index = 8,
		weapon_category = "weapon_launcher",
		name = @"hash_3FB45C2314396720",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_launcher"]
	},
	{
		index = 9,
		weapon_category = "weapon_knife",
		name = @"hash_28180FA72D55F45B",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_knife"]
	},
	{
		index = 10,
		weapon_category = "weapon_special",
		name = @"hash_63A21A8AF3E42CDD",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_special"]
	}
}
CoD.CACUtility.WeaponGroupDvarShown = {
	weapon_special = @"hash_54A800EDD0C9BDE2"
}
CoD.CACUtility.GetWeaponGroupsNames = function ( f2_arg0 )
	local f2_local0 = {}
	local f2_local1 = nil
	if f2_arg0 == "primary" then
		f2_local1 = CoD.CACUtility.PrimaryWeaponGroupNames
	elseif f2_arg0 == "secondary" then
		f2_local1 = CoD.CACUtility.SecondaryWeaponGroupNames
	end
	if f2_local1 then
		for f2_local5, f2_local6 in ipairs( f2_local1 ) do
			if not CoD.CACUtility.WeaponGroupDvarShown[f2_local6.weapon_category] or IsBooleanDvarSet( CoD.CACUtility.WeaponGroupDvarShown[f2_local6.weapon_category] ) then
				table.insert( f2_local0, f2_local6 )
			end
		end
	end
	return f2_local0
end
CoD.CACUtility.talismanLoadoutSlot = "invalidGroup"
CoD.CACUtility.talismanLoadoutSlotName = 0x0
CoD.CACUtility.talismanLoadoutSlot = "talisman"
CoD.CACUtility.talismanLoadoutSlotName = @"hash_3A6D130CF0A0B9B0"
CoD.CACUtility.loadoutSlotInfo = {
	{
		index = 1,
		loadoutSlot = "primary",
		name = @"hash_7B484D92443361D8",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_primary_weapon"]
	},
	{
		index = 2,
		loadoutSlot = "secondary",
		name = @"hash_6BB44C71D0F6B5C8",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_secondary_weapon"]
	},
	{
		index = 3,
		loadoutSlot = "primarygrenade",
		name = @"hash_2DA102A6853690E6",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_primary_grenade"]
	},
	{
		index = 4,
		loadoutSlot = "herogadget",
		name = 0xA0BC550C54BD42,
		zmName = 0x3377F50B93AB03,
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_hero_gadget"]
	},
	{
		index = 5,
		loadoutSlot = "specialty",
		name = @"hash_79A2653A123A01FD",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_specialty1"]
	},
	{
		index = 6,
		loadoutSlot = CoD.CACUtility.talismanLoadoutSlot,
		name = CoD.CACUtility.talismanLoadoutSlotName,
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_talisman1"]
	},
	{
		index = 7,
		loadoutSlot = "tacticalgear",
		name = @"hash_305E03714EE77FC",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"hash_22BC73D8834F0281"]
	},
	{
		index = 8,
		loadoutSlot = "talent",
		name = @"hash_114FA585889B518B",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_talent1"]
	},
	{
		index = 9,
		loadoutSlot = "bonuscard",
		name = @"hash_38DEB3201AB34D8E",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_bonuscard1"]
	},
	{
		index = 10,
		loadoutSlot = "killstreak",
		name = @"hash_4B476D101217A723",
		loadoutSlotEnum = Enum[@"loadoutslot_t"][@"loadoutslot_killstreak1"]
	}
}
CoD.CACUtility.weaponOptionGroupNames = {
	[Enum[@"eweaponoptiongroup"][@"weaponoption_group_camo"]] = "camo",
	[Enum[@"eweaponoptiongroup"][@"weaponoption_group_tag"]] = "tag",
	[Enum[@"eweaponoptiongroup"][@"weaponoption_group_emblem"]] = "emblem",
	[Enum[@"eweaponoptiongroup"][@"weaponoption_group_paintjob"]] = "paintjob",
	[Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle"]] = "reticle",
	[Enum[@"eweaponoptiongroup"][@"weaponoption_group_lens"]] = "lens",
	[Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle_color"]] = "reticle_color"
}
CoD.CACUtility.maxWeaponCustomizationCategories = 3
CoD.CACUtility.attachmentsWithCustReticle = {
	acog = true,
	dualoptic = true,
	elo = true,
	holo = true,
	mms = true,
	reflex = true
}
CoD.CACUtility.CACFeatureUnlockableItem = @"feature_cac"
CoD.CACUtility.ClassesUnlockableItemInfo = {
	prepared = false,
	classNum_3 = {
		featureItemRef = @"feature_custom_class_4",
		featureItemIndex = CoDShared.EmptyItemIndex
	},
	classNum_4 = {
		featureItemRef = @"feature_custom_class_5",
		featureItemIndex = CoDShared.EmptyItemIndex
	},
	classNum_5 = {
		featureItemRef = @"feature_custom_class_6",
		featureItemIndex = CoDShared.EmptyItemIndex
	},
	classNum_15 = {
		featureItemRef = @"feature_default_class_4",
		featureItemIndex = CoDShared.EmptyItemIndex
	},
	classNum_16 = {
		featureItemRef = @"feature_default_class_5",
		featureItemIndex = CoDShared.EmptyItemIndex
	},
	classNum_17 = {
		featureItemRef = @"feature_default_class_6",
		featureItemIndex = CoDShared.EmptyItemIndex
	}
}
CoD.CACUtility.CustomClass_LastClassNum = 0
CoD.CACUtility.CustomClass_LastSelection = "primary"
CoD.CACUtility.CustomClass_PerClassLastSelection = {}
CoD.CACUtility.CACStatusAvailable = LuaEnum.createEnum( "NOT_AVAILABLE", "REQUIRES_WILDCARD", "AVAILABLE" )
CoD.CACUtility.CamoOptionsTable = "gamedata/weapons/common/camoOptions.csv"
CoD.CACUtility.ValidateMPClasses = function ( f3_arg0 )
	CoD.CraftUtility.ValidateEquippedUGC( f3_arg0 )
end
CoD.CACUtility.MasteryCamos = {
	[@"camo_gold"] = true,
	[@"camo_diamond"] = true,
	[@"camo_darkmatter"] = true
}
CoD.CACUtility[@"hash_5E6E8B9715ECC201"] = function ( f4_arg0, f4_arg1 )
	local f4_local0 = Engine[@"currentsessionmode"]()
	if f4_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		local f4_local1 = CoD.CACUtility.GetCustomClassCount( f4_arg0 )
		for f4_local2 = 1, f4_local1, 1 do
			local f4_local5 = Engine[@"getcustomclasscacroot"]( f4_arg0, f4_local2 - 1, f4_local0 )
			if f4_local5 then
				for f4_local17, f4_local18 in ipairs( {
					@"primary",
					@"secondary"
				} ) do
					local f4_local19 = f4_local5[f4_local18]
					if f4_local19 then
						local f4_local9 = f4_local19[@"itemindex"]:get()
						local f4_local10 = f4_local19[@"weaponmodelslot"]:get()
						if f4_local9 ~= CoDShared.EmptyItemIndex then
							local f4_local11 = Engine[@"hash_7B98952F69D937F9"]( f4_local9 )
							if f4_local11 ~= 0x0 then
								local f4_local12 = Engine[@"hash_79F0BB7D52A7A978"]( f4_local11 )
								local f4_local13 = f4_local12[f4_local10 + 1]
								if not f4_local13 or not CoD.CACUtility.FilterSignatureWeapon( f4_arg0, f4_local13, false, true ) then
									f4_local19[@"weaponmodelslot"]:set( 0 )
								else
									local f4_local14 = f4_local19[@"camoindex"]:get()
									if f4_local14 ~= 0 then
										local f4_local15 = Engine[@"tablelookup"]( CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], f4_local14 )
										if f4_local15 and not CoD.CACUtility.MasteryCamos[f4_local15] then
											local f4_local16 = CoD.CACUtility.AdjustCamoIfSignatureCamo( f4_arg0, f4_local14 )
											if f4_local16 ~= f4_local14 then
												f4_local19[@"camoindex"]:set( f4_local16 )
											end
										end
									end
								end
							end
						end
						local f4_local11 = f4_local19[@"camoindex"]:get()
						if f4_local9 ~= CoDShared.EmptyItemIndex and f4_local11 > 0 then
							local f4_local12 = CoD.WeaponOptionsUtility.GetCamoWeaponOptionIndexFromCamoOptionsIndex( f4_local11 )
							if Engine[@"hash_6F1FD722970FDBA3"]( f4_arg0, f4_local9, f4_local12, f4_local0 ) and not CoD.WeaponOptionsUtility.IsCamoWeaponOptionIndexActiveCamo( f4_local12 ) and f4_arg1 then
								f4_local19[@"camoindex"]:set( 0 )
								CoDShared.ReportUser( f4_arg0, Engine[@"getxuid64"]( f4_arg0 ), "cheater_masterycamo_3", 1, true )
							end
						end
					end
				end
				f4_local6 = f4_local5[@"primarygrenade"]
				if f4_local6 and f4_local6:get() == 0 then
					f4_local6:set( Engine[@"hash_2D97229B24C685D5"]( CoDShared.DefaultSpecialistEquipment, f4_local0 ) )
				end
			end
		end
		CoDLoadoutsShared[@"validatemploadouts"]( f4_arg0, f4_arg1 )
	elseif f4_local0 == Enum[@"emodes"][@"mode_zombies"] and not IsLive() then
		local f4_local1 = Engine[@"hash_6BBE3328FE08B8C7"]()
		local f4_local2 = CoD.CACUtility.GetCustomClassCount( f4_arg0 )
		for f4_local3 = 0, CoD.ZMStoryUtility.StoryIndex.STORY_INDEX_COUNT - 1, 1 do
			Engine[@"hash_337129162C820FB"]( f4_local3 )
			for f4_local5 = 1, f4_local2, 1 do
				local f4_local18 = Engine[@"getcustomclasscacroot"]( f4_arg0, f4_local5 - 1, f4_local0 )
				if f4_local18 then
					local f4_local19 = f4_local18[@"talisman1"]
					if f4_local19 then
						f4_local19:set( CoD.CACUtility.EmptyItemIndex )
					end
				end
			end
		end
		Engine[@"hash_337129162C820FB"]( f4_local1 )
	end
end
CoD.CACUtility[@"hash_2D1AA40064EFC4B7"] = function ( f5_arg0, f5_arg1, f5_arg2 )
	local f5_local0 = f5_arg1[@"hash_7A37A6E2D302839E" .. f5_arg2]
	if f5_local0 and f5_local0 ~= 0x0 then
		return LuaUtils.FindItemInArray( f5_arg0, f5_local0, function ( f6_arg0, f6_arg1 )
			return f6_arg1[@"assetname"] == f6_arg0
		end
		 )
	else
		
	end
end
CoD.CACUtility[@"hash_1347CC8D49FF3E49"] = function ( f7_arg0, f7_arg1 )
	local f7_local0 = Engine[@"hash_2B2E4CCC119597B0"]()
	if not f7_local0 then
		return 
	end
	for f7_local4, f7_local5 in DDLUtils.ipairs( f7_arg0[0xD6751CB2F9CA09] ) do
		local f7_local6 = CoD.CACUtility[@"hash_2D1AA40064EFC4B7"]( f7_local0, f7_arg1, f7_local4 )
		if f7_local6 then
			f7_local5:set( f7_local6 )
		end
	end
end
CoD.CACUtility.SetDefaultLoadouts = function ( f8_arg0 )
	local f8_local0 = f8_arg0.controller
	local f8_local1 = f8_arg0.storageFileType
	local f8_local2 = f8_arg0.statsNetworkType
	local f8_local3 = Engine[@"hash_3091707D0144833"]()
	if f8_local1 == Enum[@"storagefiletype"][@"storage_cp_loadouts"] or f8_local1 == Enum[@"storagefiletype"][@"storage_cp_loadouts_offline"] then
		local f8_local4 = Engine[@"storagegetbuffer"]( f8_local0, f8_local1 )
		if not f8_local4 then
			return 
		end
		local f8_local5 = f8_local4.cacLoadouts
		if f8_local5 then
			local f8_local6 = Enum[@"emodes"][@"mode_campaign"]
			local f8_local7 = Engine[@"hash_2E00B2F29271C60B"]( @"cp_default_loadouts" )
			for f8_local8 = 1, #f8_local5.customclass, 1 do
				CoDShared.SetCustomDefaultLoadout( f8_local5, f8_local8, f8_local7, f8_local6, nil )
			end
			Engine[@"saveloadout"]( f8_local0, f8_local6 )
		end
	elseif f8_local1 == Enum[@"storagefiletype"][@"storage_mp_loadouts"] or f8_local1 == Enum[@"storagefiletype"][@"storage_mp_loadouts_custom"] or f8_local1 == Enum[@"storagefiletype"][@"storage_mp_loadouts_offline"] or f8_local1 == Enum[@"storagefiletype"][0x67DF1879D992E] or f8_local1 == Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"] or f8_local1 == Enum[@"storagefiletype"][@"hash_D062FA7B47FC13A"] then
		local f8_local4 = Engine[@"storagegetbuffer"]( f8_local0, f8_local1 )
		if not f8_local4 then
			return 
		end
		local f8_local5 = f8_local4.cacLoadouts
		if f8_local5 then
			local f8_local6 = Enum[@"emodes"][@"mode_multiplayer"]
			local f8_local7 = nil
			if f8_arg0.loadout ~= nil and f8_arg0.loadout ~= 0x0 then
				f8_local7 = Engine[@"hash_2E00B2F29271C60B"]( f8_arg0.loadout )
			elseif f8_local1 == Enum[@"storagefiletype"][0x67DF1879D992E] or f8_local1 == Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"] or f8_local1 == Enum[@"storagefiletype"][@"hash_D062FA7B47FC13A"] then
				f8_local7 = Engine[@"hash_2E00B2F29271C60B"]( @"mp_arena_default_loadouts" )
			else
				f8_local7 = Engine[@"hash_2E00B2F29271C60B"]( @"mp_default_loadouts" )
			end
			if not f8_local7 then
				return 
			end
			for f8_local8 = Enum[@"loadoutclass_t"][@"custom_class_first"] + 1, Enum[@"loadoutclass_t"][@"basic_custom_class_count"], 1 do
				CoDShared.SetCustomDefaultLoadout( f8_local5, f8_local8, f8_local7, f8_local6, nil )
				CoDShared.SetDefaultLoadoutForClass( f8_local5, f8_local8 + Enum[@"loadoutclass_t"][@"basic_custom_class_count"], f8_local8, f8_local7, f8_local6, nil )
			end
			if f8_local3 then
				for f8_local8 = Enum[@"loadoutclass_t"][@"default_class_first"] + 1, Enum[@"loadoutclass_t"][@"default_class_last"] + 1, 1 do
					CoDShared.SetDefaultLoadout( f8_local5, f8_local8, f8_local7, f8_local6, nil )
				end
			end
			CoDShared.SetDefaultGlobalLoadout( f8_local5, f8_local7, f8_local6 )
			if f8_local1 == Enum[@"storagefiletype"][@"storage_mp_loadouts"] then
				CoD.CACUtility[@"hash_1347CC8D49FF3E49"]( f8_local5, f8_local7 )
			end
			Engine[@"saveloadout"]( f8_local0, f8_local6 )
		end
	elseif f8_local1 == Enum[@"storagefiletype"][@"storage_zm_loadouts"] or f8_local1 == Enum[@"storagefiletype"][@"hash_33376D9E1C3C8130"] or f8_local1 == Enum[@"storagefiletype"][@"storage_zm_loadouts_offline"] then
		local f8_local4 = Engine[@"storagegetbuffer"]( f8_local0, f8_local1 )
		if not f8_local4 then
			return 
		end
		local f8_local5 = f8_local4.cacLoadouts
		if f8_local5 then
			local f8_local6 = Enum[@"emodes"][@"mode_zombies"]
			local f8_local7 = Engine[@"hash_2E00B2F29271C60B"]( @"zm_default_loadouts" )
			for f8_local8 = 0, #f8_local5 - 1, 1 do
				local f8_local11 = f8_local5[f8_local8]
				for f8_local12 = 1, #f8_local11.customclass, 1 do
					CoDShared.SetCustomDefaultLoadout( f8_local11, f8_local12, f8_local7, f8_local6, f8_local8 )
				end
				for f8_local12 = 1, #f8_local11.bubbleGumPack, 1 do
					CoDShared.SetDefaultBubbleGumBuffs( f8_local11, f8_local12, f8_local7, f8_local6, f8_local8 )
				end
			end
			Engine[@"saveloadout"]( f8_local0, f8_local6 )
		end
	elseif f8_local1 == Enum[@"storagefiletype"][@"storage_wz_loadouts"] then
		local f8_local4 = Engine[@"storagegetbuffer"]( f8_local0, f8_local1 )
		if not f8_local4 then
			return 
		end
		local f8_local5 = Enum[@"emodes"][@"mode_warzone"]
		local f8_local6 = CoD.PlayerRoleUtility.GetHeroList( f8_local5 )
		local f8_local7 = Engine[@"hash_2E00B2F29271C60B"]( @"wz_default_loadouts" )
		local f8_local8 = {}
		for f8_local11, f8_local12 in ipairs( f8_local6 ) do
			local f8_local13 = f8_local12.bodyIndex
			local f8_local14 = Engine[@"getpositionrolebundleinfo"]( f8_local5, f8_local13 )
			if f8_local14[@"isdefaultcharacter"] == 1 then
				table.insert( f8_local8, f8_local13 )
			end
		end
		if #f8_local8 > 0 then
			f8_local4[@"cacloadouts"][@"hash_6A8BD5071BCB463C"]:set( f8_local8[math.random( #f8_local8 )] )
		end
		CoD.CACUtility[@"hash_1347CC8D49FF3E49"]( f8_local4[@"cacloadouts"], f8_local7 )
		Engine[@"saveloadout"]( f8_local0, f8_local5 )
	end
end
CoD.CACUtility.ValidateMPBlackMarketAttachments = function ( f9_arg0 )
	local f9_local0 = function ( f10_arg0 )
		if not f10_arg0 then
			return 
		end
		local f10_local0 = {
			{
				slotName = "primary",
				attachments = CoD.CACUtility.PrimaryAttachmentSlotNameList
			},
			{
				slotName = "secondary",
				attachments = CoD.CACUtility.SecondaryAttachmentSlotNameList
			}
		}
		for f10_local4, f10_local5 in ipairs( {
			{
				slotName = "primaryreticle",
				attachmentIndex = CoD.SafeGetDDL( f10_arg0, "primaryattachment1" )
			},
			{
				slotName = "secondaryreticle",
				attachmentIndex = CoD.SafeGetDDL( f10_arg0, "secondaryattachment1" )
			}
		} ) do
			local f10_local6 = CoD.SafeGetDDL( f10_arg0, f10_local5.slotName )
			if f10_local6 and Engine[@"isweaponoptionlockedentitlement"]( f9_arg0, f10_local5.attachmentIndex, Engine[@"tablelookup"]( CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_index"], Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_reference"], "reticle_" .. f10_local6 ) ) then
				f10_arg0[f10_local5.slotName]:set( 0 )
			end
		end
		for f10_local5, f10_local6 in ipairs( {
			{
				slotName = "primarycamo",
				attachmentIndex = Enum[@"eattachment"][@"attachment_none"]
			},
			{
				slotName = "secondarycamo",
				attachmentIndex = Enum[@"eattachment"][@"attachment_none"]
			}
		} ) do
			local f10_local7 = CoD.SafeGetDDL( f10_arg0, f10_local6.slotName )
			if f10_local7 and Engine[@"isweaponoptionlockedentitlement"]( f9_arg0, f10_local6.attachmentIndex, f10_local7 ) then
				f10_arg0[f10_local6.slotName]:set( 0 )
			end
		end
	end
	
	local f9_local1 = {}
	local f9_local2 = Engine[@"storagegetbuffer"]( f9_arg0, Enum[@"storagefiletype"][0x67DF1879D992E] )
	local f9_local3 = Engine[@"storagegetbuffer"]( f9_arg0, Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"] )
	local f9_local4 = Engine[@"storagegetbuffer"]( f9_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts_custom"] )
	local f9_local5 = Engine[@"storagegetbuffer"]( f9_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts"] )
	f9_local1 = f9_local2
	for f9_local2 = 1, #f9_local1, 1 do
		local f9_local6 = f9_local1[f9_local2]
		if f9_local6 then
			for f9_local7 = 0, 9, 1 do
				f9_local0( f9_local6.cacLoadouts[f9_local7] )
			end
		end
	end
	f9_local2 = Engine[@"storagegetbuffer"]( f9_arg0, Enum[@"storagefiletype"][@"storage_mp_class_sets"] )
	if f9_local2 then
		for f9_local7, f9_local8 in ipairs( {
			"publicMatchClassSets",
			"customMatchClassSets"
		} ) do
			local f9_local9 = f9_local2[f9_local8]
			if f9_local9 then
				for f9_local10 = 0, 9, 1 do
					for f9_local13 = 0, 9, 1 do
						f9_local0( f9_local9[f9_local10].customclass[f9_local13] )
					end
				end
			end
		end
	end
end
CoD.CACUtility.ValidateMPLootWeapons = function ( f11_arg0 )
	local f11_local0 = function ( f12_arg0, f12_arg1 )
		local f12_local0 = 0
		local f12_local1 = false
		for f12_local6, f12_local7 in ipairs( f12_arg0 ) do
			local f12_local8 = Engine[@"hash_4C6F8EC444864600"]( CoD.BlackMarketUtility.lootTableName, f12_local7, f12_local0 )
			local f12_local9 = Engine[@"getitemindexfromreference"]( f12_local8, Enum[@"emodes"][@"mode_multiplayer"] )
			local f12_local10 = CoD.BlackMarketUtility.GetItemQuantity( f11_arg0, f12_local8 )
			local f12_local11 = "itemstats." .. f12_local9 .. ".purchased"
			if f12_local10 == 0 then
				local f12_local5 = LUI.getTableFromPath( f12_local11, f12_arg1 )
				if f12_local5 and f12_local5:get() ~= 0 then
					f12_local5:set( 0 )
					f12_local1 = true
				end
			end
			local f12_local5 = LUI.getTableFromPath( f12_local11, f12_arg1 )
			if f12_local5 and f12_local5:get() == 0 then
				f12_local5:set( 1 )
				f12_local1 = true
			end
		end
		return f12_local1
	end
	
	local f11_local1 = Engine[@"storagegetbuffer"]( f11_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"] )
	if f11_local1 then
		local f11_local2 = false
		if f11_local0( CoD.BlackMarketUtility.GetLootTypeRows( "weapon" ), f11_local1 ) or f11_local0( CoD.BlackMarketUtility.GetLootTypeRows( "melee_weapon" ), f11_local1 ) then
			UploadStats( nil, f11_arg0 )
		end
	end
end
CoD.CACUtility.ValidateZMBGBEntitlement = function ( f13_arg0 )
	for f13_local0 = 0, 9, 1 do
		for f13_local3 = 0, 4, 1 do
			local f13_local6 = Engine[@"getdlcnameforitem"]( Engine[@"getbubblegumbuff"]( f13_arg0, f13_local0, f13_local3 ), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] )
			if f13_local6 and f13_local6 ~= "" and not Engine[@"hasentitlement"]( f13_arg0, Engine[@"converttoxhash"]( f13_local6 ) ) then
				Engine[@"exec"]( f13_arg0, "resetBubbleGumPackOnline " .. f13_local0 .. " MENU_BGB_PACK_" .. f13_local0 + 1 )
			end
		end
	end
end
CoD.OverlayUtility.AddSystemOverlay( "PrestigeWeapon", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Full_BasicFrame_Prestige",
	title = function ( f14_arg0, f14_arg1 )
		return Engine[@"toupper"]( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_73FDEFB5DBDDE6EF", CoD.CACUtility.GetWeaponPLevel( f14_arg0, Engine[@"getmodelvalue"]( f14_arg1 ) ) + 1 ) )
	end,
	description = function ( f15_arg0, f15_arg1 )
		local f15_local0 = {
			@"hash_6A5174662FAC1979",
			@"hash_6A5171662FAC1460"
		}
		return Engine[@"hash_4F9F1239CFD921FE"]( f15_local0[CoD.CACUtility.GetWeaponPLevel( f15_arg0, Engine[@"getmodelvalue"]( f15_arg1 ) ) + 1], Engine[@"getitemname"]( Engine[@"getmodelvalue"]( f15_arg1 ) ) )
	end,
	weaponName = function ( f16_arg0, f16_arg1 )
		return Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( Engine[@"getmodelvalue"]( f16_arg1 ) ) )
	end,
	weaponImage = function ( f17_arg0, f17_arg1 )
		return Engine[@"getitemimage"]( Engine[@"getmodelvalue"]( f17_arg1 ) )
	end,
	weaponPrestigeReward = function ( f18_arg0, f18_arg1 )
		local f18_local0 = {
			@"hash_87AD82563AAAC53",
			@"mpui/killcounter"
		}
		return Engine[@"hash_4F9F1239CFD921FE"]( f18_local0[CoD.CACUtility.GetWeaponPLevel( f18_arg0, Engine[@"getmodelvalue"]( f18_arg1 ) ) + 1] )
	end,
	weaponPrestigeRewardIcon = function ( f19_arg0, f19_arg1 )
		local f19_local0 = {
			@"cac_mods_clan_tag",
			@"cac_mods_kill_counter"
		}
		return f19_local0[CoD.CACUtility.GetWeaponPLevel( f19_arg0, Engine[@"getmodelvalue"]( f19_arg1 ) ) + 1]
	end,
	weaponPrestigeRewardPreview = function ( f20_arg0, f20_arg1 )
		if CoD.CACUtility.GetWeaponPLevel( f20_arg0, Engine[@"getmodelvalue"]( f20_arg1 ) ) + 1 == CoD.CACUtility.maxWeaponPrestige then
			local f20_local0 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer( f20_arg0 )
			local f20_local1 = 0
			if f20_local0 then
				local f20_local2 = CoD.CACUtility.GetUnlockableItemInfo( Engine[@"getmodelvalue"]( f20_arg1 ), Engine[@"currentsessionmode"]() )
				f20_local1 = f20_local0.item_stats[f20_local2.nameHash].kills.statValue:get()
			end
			return f20_local1
		end
		local f20_local0 = ""
		local f20_local3 = Engine[@"getplayerinfo"]( f20_arg0, Engine[@"getxuid64"]( f20_arg0 ) )
		if f20_local3 then
			f20_local0 = f20_local3.info.clantag
		end
		return f20_local0
	end,
	weaponPrestigeLevel = function ( f21_arg0, f21_arg1 )
		return CoD.CACUtility.GetWeaponPLevel( f21_arg0, Engine[@"getmodelvalue"]( f21_arg1 ) ) + 1
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function ( f22_arg0, f22_arg1 )
		DataSources.PrestigeWeaponOptionsList = DataSourceHelpers.ListSetup( "PrestigeWeaponOptionsList", function ( f23_arg0 )
			local f23_local0 = {}
			local f23_local1 = function ( f24_arg0, f24_arg1, f24_arg2 )
				return {
					models = {
						displayText = f24_arg0
					},
					properties = {
						action = f24_arg1,
						selectIndex = f24_arg2
					}
				}
			end
			
			local f23_local2 = function ( f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4 )
				local f25_local0 = CoD.CACUtility.GetCustomClassCount( f25_arg2 )
				local f25_local1 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f25_arg2 ), "CustomClassList" )
				local f25_local2 = Engine[@"getmodelvalue"]( f22_arg1 )
				local f25_local3 = Engine[@"currentsessionmode"]()
				for f25_local4 = 1, f25_local0, 1 do
					local f25_local7 = Engine[@"getmodel"]( f25_local1, "class" .. f25_local4 )
					local f25_local8 = f25_local4 - 1
					if CoD.SafeGetModelValue( f25_local7, "primary.itemIndex" ) == f25_local2 then
						local f25_local9 = nil
						f25_local9 = CoD.CACUtility.PrimaryAttachmentSlotNameList
						if f25_local9 and f25_local7 then
							for f25_local13, f25_local14 in ipairs( f25_local9 ) do
								f25_local7[f25_local14].itemIndex:set( CoD.CACUtility.EmptyItemIndex )
							end
						end
						for f25_local10 = 1, CoD.CACUtility.maxPrimaryAttachments, 1 do
							Engine[@"setclassitem"]( f25_arg2, f25_local8, "primaryattachment" .. f25_local10, CoD.CACUtility.EmptyItemIndex )
						end
					end
					if CoD.SafeGetModelValue( f25_local7, "secondary.itemIndex" ) == f25_local2 then
						local f25_local9 = nil
						f25_local9 = CoD.CACUtility.SecondaryAttachmentSlotNameList
						if f25_local9 and f25_local7 then
							for f25_local13, f25_local14 in ipairs( f25_local9 ) do
								f25_local7[f25_local14].itemIndex:set( CoD.CACUtility.EmptyItemIndex )
							end
						end
						for f25_local10 = 1, CoD.CACUtility.maxSecondaryAttachments, 1 do
							Engine[@"setclassitem"]( f25_arg2, f25_local8, "secondaryattachment" .. f25_local10, CoD.CACUtility.EmptyItemIndex )
						end
					end
				end
				local f25_local4 = Engine[@"getnumberofclasssetsowned"]( f25_arg2 )
				for f25_local5 = 1, f25_local4, 1 do
					local f25_local8 = f25_local5 - 1
					for f25_local9 = 1, f25_local0, 1 do
						local f25_local13 = f25_local9 - 1
						local f25_local14 = Engine[@"getclasssetitem"]( f25_arg2, f25_local8, f25_local13, "primary" )
						local f25_local16 = Engine[@"getclasssetitem"]( f25_arg2, f25_local8, f25_local13, "secondary" )
						if f25_local14 == f25_local2 then
							for f25_local17 = 1, CoD.CACUtility.maxPrimaryAttachments, 1 do
								Engine[@"setclasssetitem"]( f25_arg2, f25_local8, f25_local13, "primaryattachment" .. f25_local17, CoD.CACUtility.EmptyItemIndex )
							end
						end
						if f25_local16 == f25_local2 then
							for f25_local17 = 1, CoD.CACUtility.maxPrimaryAttachments, 1 do
								Engine[@"setclasssetitem"]( f25_arg2, f25_local8, f25_local13, "secondaryattachment" .. f25_local17, CoD.CACUtility.EmptyItemIndex )
							end
						end
					end
				end
				local f25_local5 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer( f25_arg2 )
				if f25_local5 then
					local f25_local6 = Engine[@"getmodelvalue"]( f22_arg1 )
					local f25_local15 = CoD.CACUtility.GetUnlockableItemInfo( f25_local6, f25_local3 )
					local f25_local8 = f25_local5.ranked_item_stats[f25_local15.nameHash]
					f25_local8.pLevel:set( math.min( f25_local8.pLevel:get() + 1, CoD.CACUtility.maxWeaponPrestige ) )
					f25_local8.xp:set( 0 )
					Engine[@"playsound"]( "uin_prestige_activate" )
					CoD.OverlayUtility.ShowToast( "Content", Engine[@"hash_4F9F1239CFD921FE"]( @"hash_146ECE54C3471D89" ), Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( f25_local6 ) ), @"blacktransparent", nil, nil, nil, nil )
					Engine[@"storagewrite"]( f25_arg2, CoD.PlayerStatsUtility.GetStorageBufferEnumForPlayer( f25_arg2 ) )
					ForceNotifyControllerModel( f25_arg2, "Unlockables.listUpdate" )
				end
				UploadStats( f25_arg4, f25_arg2 )
				SaveLoadout( f25_arg4, f25_arg2 )
				for f25_local6 = 1, f25_local0, 1 do
					local f25_local9 = Engine[@"getmodel"]( f25_local1, "class" .. f25_local6 )
					local f25_local10 = Engine[@"getmodel"]( f25_local9, "primary.itemIndex" )
					local f25_local11 = Engine[@"getmodel"]( f25_local9, "secondary.itemIndex" )
					Engine[@"forcenotifymodelsubscriptions"]( f25_local10 )
					Engine[@"forcenotifymodelsubscriptions"]( f25_local11 )
				end
				Engine[@"forcenotifymodelsubscriptions"]( f22_arg1 )
				CoD.CACUtility.ValidateMPClasses( f25_arg2 )
				GoBack( f25_arg4, f25_arg2 )
			end
			
			local f23_local3 = function ( f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4 )
				local f26_local0 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer( f26_arg2 )
				local f26_local1 = Engine[@"currentsessionmode"]()
				local f26_local2 = Engine[@"getmodelvalue"]( f22_arg1 )
				if f26_local0 then
					local f26_local3 = CoD.CACUtility.GetUnlockableItemInfo( f26_local2, f26_local1 )
					local f26_local4 = f26_local0.ranked_item_stats[f26_local3.nameHash]
					f26_local4.pLevel:set( math.min( f26_local4.pLevel:get() + 1, CoD.CACUtility.maxWeaponPrestige ) )
					f26_local4.xp:set( 0 )
					Engine[@"storagewrite"]( f26_arg2, CoD.PlayerStatsUtility.GetStorageBufferEnumForPlayer( f26_arg2 ) )
					Engine[@"playsound"]( "uin_prestige_activate" )
					CoD.OverlayUtility.ShowToast( "Content", Engine[@"hash_4F9F1239CFD921FE"]( @"hash_146ECE54C3471D89" ), Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( f26_local2 ) ), @"blacktransparent", nil, nil, nil, nil )
					ForceNotifyControllerModel( f26_arg2, "Unlockables.listUpdate" )
				end
				UploadStats( f26_arg4, f26_arg2 )
				SaveLoadout( f26_arg4, f26_arg2 )
				Engine[@"forcenotifymodelsubscriptions"]( f22_arg1 )
				CoD.ZMLoadoutUtility.ClearAllAttachments( f26_arg2, f26_local2, f26_local1 )
				GoBack( f26_arg4, f26_arg2 )
			end
			
			local f23_local4 = function ( f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4 )
				GoBack( f27_arg4, f27_arg2 )
			end
			
			local f23_local5 = Engine[@"currentsessionmode"]()
			if f23_local5 == Enum[@"emodes"][@"mode_zombies"] then
				table.insert( f23_local0, f23_local1( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_CEB637ACD703940" ), f23_local3, false ) )
			elseif f23_local5 == Enum[@"emodes"][@"mode_multiplayer"] then
				table.insert( f23_local0, f23_local1( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_CEB637ACD703940" ), f23_local2, false ) )
			end
			table.insert( f23_local0, f23_local1( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/cancel" ), f23_local4, true ) )
			return f23_local0
		end, true )
		return "PrestigeWeaponOptionsList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.CACUtility.GetCameraNameForAttachments = function ( f28_arg0, f28_arg1 )
	local f28_local0 = 0
	local f28_local1 = 0
	for f28_local5 in string.gmatch( f28_arg0, "[^+]+" ) do
		if f28_local5 == "suppressed" then
			f28_local0 = 1
		end
		if f28_local5 == "extbarrel" then
			f28_local1 = 1
		end
	end
	f28_local2 = "select"
	if f28_arg1 ~= nil and f28_arg1 then
		f28_local2 = "gunsmith"
	end
	f28_local3 = ""
	if f28_local0 == 1 then
		if f28_local1 == 1 then
			f28_local3 = "_extbarrel_suppressor"
		else
			f28_local3 = "_suppressor"
		end
	elseif f28_local1 == 1 then
		f28_local3 = "_extbarrel"
	else
		f28_local3 = "01"
	end
	return f28_local2 .. f28_local3
end
CoD.CACUtility.GetImageForItemRefString = function ( f29_arg0 )
	return Engine[@"getitemimage"]( Engine[@"getitemindexfromreference"]( f29_arg0 ) )
end
CoD.CACUtility.GetNameForItemRefString = function ( f30_arg0 )
	return Engine[@"getitemname"]( Engine[@"getitemindexfromreference"]( f30_arg0 ) )
end
CoD.CACUtility.IsSlotNameInList = function ( f31_arg0, f31_arg1 )
	for f31_local3, f31_local4 in ipairs( f31_arg0 ) do
		if LUI.startswith( f31_local4, f31_arg1 ) then
			return true
		end
	end
	return false
end
CoD.CACUtility.GetSlotListWithSlot = function ( f32_arg0 )
	for f32_local3, f32_local4 in ipairs( CoD.CACUtility.SlotLists ) do
		if CoD.CACUtility.IsSlotNameInList( f32_local4, f32_arg0 ) then
			return f32_local4
		end
	end
	return {}
end
CoD.CACUtility.GetClassAttachments = function ( f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4 )
	local f33_local0 = Engine[@"getcustomclasscacroot"]( f33_arg0, f33_arg2, f33_arg1 )
	local f33_local1 = f33_local0[f33_arg3][f33_arg4 - 1]
	local f33_local2 = {}
	if f33_local1 ~= nil then
		local f33_local3 = f33_local1.attachment
		for f33_local4 = 1, #f33_local3, 1 do
			local f33_local7 = f33_local3[f33_local4 - 1]:get()
			if f33_local7 ~= CoD.CACUtility.EmptyItemIndex then
				f33_local2[#f33_local2 + 1] = f33_local7
			end
		end
	end
	return f33_local2
end
CoD.CACUtility.GetWeaponSlotForAttachmentSlot = function ( f34_arg0 )
	if CoD.CACUtility.IsSlotNameInList( CoD.CACUtility.SecondaryAttachmentSlotNameList, f34_arg0 ) then
		return CoD.CACUtility.loadoutCategoryNames.secondaryWeapon
	else
		return CoD.CACUtility.loadoutCategoryNames.primaryWeapon
	end
end
CoD.CACUtility.GetAttachmentListForSlot = function ( f35_arg0 )
	if LUI.startswith( f35_arg0, "primary" ) then
		return CoD.CACUtility.PrimaryAttachmentSlotNameList
	elseif LUI.startswith( f35_arg0, "secondary" ) then
		return CoD.CACUtility.SecondaryAttachmentSlotNameList
	else
		return {}
	end
end
CoD.CACUtility.GetWeaponGroupNamesForSlot = function ( f36_arg0 )
	if LUI.startswith( f36_arg0, "primary" ) then
		return CoD.CACUtility.GetWeaponGroupsNames( "primary" )
	elseif LUI.startswith( f36_arg0, "secondary" ) then
		return CoD.CACUtility.GetWeaponGroupsNames( "secondary" )
	else
		return {}
	end
end
CoD.CACUtility.CACRewardComparisonFunction = function ( f37_arg0, f37_arg1 )
	local f37_local0 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	local f37_local1 = Engine[@"getitemallocationcost"]( f37_arg0, f37_local0 )
	local f37_local2 = Engine[@"getitemallocationcost"]( f37_arg1, f37_local0 )
	if f37_local1 == f37_local2 then
		return Engine[@"getitemmomentumcost"]( f37_arg0, f37_local0 ) < Engine[@"getitemmomentumcost"]( f37_arg1, f37_local0 )
	else
		return f37_local1 < f37_local2
	end
end
CoD.CACUtility.GetLoadoutsMPOffline = function ( f38_arg0 )
	local f38_local0 = Engine[@"storagegetbuffer"]( f38_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts_offline"] )
	return f38_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsMPOnlinePublic = function ( f39_arg0 )
	local f39_local0 = Engine[@"storagegetbuffer"]( f39_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts"] )
	return f39_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsMPOnlineCustom = function ( f40_arg0 )
	local f40_local0 = Engine[@"storagegetbuffer"]( f40_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts_custom"] )
	return f40_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsMPOnlineArenaPublic = function ( f41_arg0 )
	local f41_local0 = Engine[@"storagegetbuffer"]( f41_arg0, Enum[@"storagefiletype"][0x67DF1879D992E] )
	return f41_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsMPOnlineArenaCustom = function ( f42_arg0 )
	local f42_local0 = Engine[@"storagegetbuffer"]( f42_arg0, Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"] )
	return f42_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsMPArenaOffline = function ( f43_arg0 )
	local f43_local0 = Engine[@"storagegetbuffer"]( f43_arg0, Enum[@"storagefiletype"][@"hash_D062FA7B47FC13A"] )
	return f43_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsCPOffline = function ( f44_arg0 )
	local f44_local0 = Engine[@"storagegetbuffer"]( f44_arg0, Enum[@"storagefiletype"][@"storage_cp_loadouts_offline"] )
	return f44_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsCPOnline = function ( f45_arg0 )
	local f45_local0 = Engine[@"storagegetbuffer"]( f45_arg0, Enum[@"storagefiletype"][@"storage_cp_loadouts"] )
	return f45_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsZMOffline = function ( f46_arg0 )
	local f46_local0 = Engine[@"storagegetbuffer"]( f46_arg0, Enum[@"storagefiletype"][@"storage_zm_loadouts_offline"] )
	return f46_local0.cacLoadouts
end
CoD.CACUtility.GetLoadoutsZMOnline = function ( f47_arg0 )
	local f47_local0 = Engine[@"storagegetbuffer"]( f47_arg0, Enum[@"storagefiletype"][@"storage_zm_loadouts"] )
	return f47_local0.cacLoadouts
end
CoD.CACUtility.SetDefaultCACRoot = function ( f48_arg0 )
	local f48_local0 = nil
	if CoD.isOnlineGame() ~= true then
		if Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"hash_27B5630CD29180CB"] ) then
			f48_local0 = CoD.CPMPZM( nil, CoD.CACUtility.GetLoadoutsMPArenaOffline, nil )
		else
			f48_local0 = CoD.CPMPZM( CoD.CACUtility.GetLoadoutsCPOffline, CoD.CACUtility.GetLoadoutsMPOffline, CoD.CACUtility.GetLoadoutsZMOffline )
		end
	elseif Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_league"] ) then
		f48_local0 = CoD.CPMPZM( nil, CoD.CACUtility.GetLoadoutsMPOnlineArenaPublic, nil )
	elseif Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"hash_27B5630CD29180CB"] ) then
		f48_local0 = CoD.CPMPZM( nil, CoD.CACUtility.GetLoadoutsMPOnlineArenaCustom, nil )
	elseif Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_matchmaking_manual"] ) then
		f48_local0 = CoD.CPMPZM( CoD.CACUtility.GetLoadoutsCPOnline, CoD.CACUtility.GetLoadoutsMPOnlineCustom, CoD.CACUtility.GetLoadoutsZMOnline )
	else
		f48_local0 = CoD.CPMPZM( CoD.CACUtility.GetLoadoutsCPOnline, CoD.CACUtility.GetLoadoutsMPOnlinePublic, CoD.CACUtility.GetLoadoutsZMOnline )
	end
	if f48_local0 ~= nil then
		CoD.perController[f48_arg0].cacRoot = f48_local0( f48_arg0 )
	else
		error( "LUI Error: could not set up loadout root - no valid game mode set" )
	end
end
CoD.CACUtility.SetGametypeSettingsCACRoot = function ( f49_arg0, f49_arg1 )
	local f49_local0 = nil
	if f49_arg1 == Enum[@"team_t"][@"team_free"] then
		f49_local0 = 0
	else
		f49_local0 = f49_arg1 - Enum[@"team_t"][@"team_first_playing_team"] + 1
	end
	local f49_local1 = CoD.perController[f49_arg0]
	local f49_local2 = Engine[@"getgametypesettings"]()
	f49_local1.cacRoot = f49_local2.cacLoadouts[f49_local0]
end
CoD.CACUtility.GetLoadoutSlotForAttachmentName = function ( f50_arg0, f50_arg1, f50_arg2 )
	local f50_local0 = CoD.CACUtility.PrimaryAttachmentSlotNameList
	if LUI.startswith( f50_arg1, "secondary" ) then
		f50_local0 = CoD.CACUtility.SecondaryAttachmentSlotNameList
	end
	for f50_local5, f50_local6 in ipairs( f50_local0 ) do
		local f50_local7 = Engine[@"getmodel"]( f50_arg0, f50_local6 )
		if f50_local7 then
			local f50_local4 = Engine[@"getmodel"]( f50_local7, "ref" )
			if f50_local4 and Engine[@"getmodelvalue"]( f50_local4 ) == f50_arg2 then
				return f50_local6
			end
		end
	end
	return nil
end
CoD.CACUtility.IsAttachmentRefWeaponOption = function ( f51_arg0 )
	for f51_local0 = 0, #CoD.CACUtility.weaponOptionGroupNames - 1, 1 do
		if CoD.CACUtility.weaponOptionGroupNames[f51_local0] == f51_arg0 then
			return true
		end
	end
	return false
end
CoD.CACUtility.GetWeaponOptionTypeForName = function ( f52_arg0 )
	for f52_local0 = 0, #CoD.CACUtility.weaponOptionGroupNames - 1, 1 do
		if CoD.CACUtility.weaponOptionGroupNames[f52_local0] == f52_arg0 then
			return f52_local0
		end
	end
	return nil
end
CoD.CACUtility.IsAttachmentOptic = function ( f53_arg0, f53_arg1, f53_arg2 )
	return Engine[@"isoptic"]( f53_arg0, f53_arg1, f53_arg2 )
end
CoD.CACUtility.GetAttachedItemSlot = function ( f54_arg0, f54_arg1, f54_arg2 )
	if not f54_arg2 then
		return nil
	end
	for f54_local3, f54_local4 in ipairs( f54_arg2 ) do
		local f54_local5 = f54_arg0[f54_local4]
		if f54_local5 and f54_arg1 == CoD.SafeGetModelValue( f54_local5, "itemIndex" ) then
			return f54_local4
		end
	end
	return nil
end
CoD.CACUtility.FindFirstEmptySlotInList = function ( f55_arg0, f55_arg1 )
	for f55_local4, f55_local5 in ipairs( f55_arg1 ) do
		local f55_local6 = Engine[@"getmodel"]( f55_arg0, f55_local5 )
		if f55_local6 then
			local f55_local3 = Engine[@"getmodel"]( f55_local6, "itemIndex" )
			if f55_local3 and Engine[@"getmodelvalue"]( f55_local3 ) <= CoD.CACUtility.EmptyItemIndex then
				return f55_local5
			end
		end
	end
	return nil
end
CoD.CACUtility.GetItemIndexEquippedInSlot = function ( f56_arg0, f56_arg1, f56_arg2 )
	local f56_local0 = f56_arg2 or CoD.perController[f56_arg1].classModel
	if f56_local0 then
		return CoD.SafeGetModelValue( f56_local0, f56_arg0 .. ".itemIndex" )
	else
		
	end
end
CoD.CACUtility.GetItemRefEquippedInSlot = function ( f57_arg0, f57_arg1, f57_arg2 )
	local f57_local0 = f57_arg2 or CoD.perController[f57_arg1].classModel
	if f57_local0 then
		return CoD.SafeGetModelValue( f57_local0, f57_arg0 .. ".ref" )
	else
		
	end
end
CoD.CACUtility.GetItemRefHashEquippedInSlot = function ( f58_arg0, f58_arg1, f58_arg2 )
	local f58_local0 = f58_arg2 or CoD.perController[f58_arg1].classModel
	if f58_local0 then
		return CoD.SafeGetModelValue( f58_local0, f58_arg0 .. ".refHash" )
	else
		
	end
end
CoD.CACUtility.GetItemWeaponModelSlotIndexEquippedInSlot = function ( f59_arg0, f59_arg1, f59_arg2 )
	local f59_local0 = f59_arg2 or CoD.perController[f59_arg1].classModel
	if f59_local0 then
		return CoD.SafeGetModelValue( f59_local0, f59_arg0 .. ".weaponModelSlot" )
	else
		
	end
end
CoD.CACUtility.IsItemEquippedInAnySlot = function ( f60_arg0, f60_arg1 )
	for f60_local3, f60_local4 in ipairs( f60_arg1 ) do
		if CoD.CACUtility.ItemEquippedInSlot( f60_local4, nil, f60_arg0 ) then
			return true
		end
	end
	return false
end
CoD.CACUtility.IsItemAlreadyEquippedInAnySlot = function ( f61_arg0, f61_arg1, f61_arg2 )
	for f61_local3, f61_local4 in ipairs( f61_arg2 ) do
		if CoD.CACUtility.GetItemEquippedInSlot( f61_local4, nil, f61_arg0 ) == f61_arg1 then
			return f61_local4
		end
	end
	return false
end
CoD.CACUtility.GetItemEquippedInSlot = function ( f62_arg0, f62_arg1, f62_arg2 )
	local f62_local0 = f62_arg2
	if not f62_local0 and f62_arg1 then
		f62_local0 = CoD.perController[f62_arg1].classModel
	end
	if f62_local0 then
		local f62_local1 = f62_local0[f62_arg0]
		if f62_local1 then
			return CoD.SafeGetModelValue( f62_local1, "itemIndex" )
		end
	end
	return CoD.CACUtility.EmptyItemIndex
end
CoD.CACUtility.ItemEquippedInSlot = function ( f63_arg0, f63_arg1, f63_arg2 )
	return CoD.CACUtility.EmptyItemIndex < CoD.CACUtility.GetItemEquippedInSlot( f63_arg0, f63_arg1, f63_arg2 )
end
CoD.CACUtility.GetWeaponCategoryForSlot = function ( f64_arg0, f64_arg1 )
	local f64_local0 = CoD.perController[f64_arg1].classModel
	local f64_local1 = CoD.perController[f64_arg1].weaponCategory or f64_arg0.weaponCategory
	local f64_local2 = f64_arg0.attachmentSlotName
	if not f64_local2 then
		f64_local2 = CoD.perController[f64_arg1].attachmentSlot
	end
	if f64_local2 and (LUI.startswith( f64_local1, "primary" ) or LUI.startswith( f64_local1, "secondary" )) then
		f64_local1 = f64_local1 .. f64_local2
	end
	return f64_local1
end
CoD.CACUtility.DoesWeaponHaveDWInSlot = function ( f65_arg0, f65_arg1, f65_arg2 )
	if f65_arg0 ~= "primary" and f65_arg0 ~= "secondary" then
		return false
	end
	local f65_local0 = Engine[@"getmodel"]( f65_arg2, f65_arg0 )
	if f65_local0 then
		local f65_local1 = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f65_local0, "itemIndex" ) )
		if f65_local1 > CoD.CACUtility.EmptyItemIndex then
			for f65_local6, f65_local7 in ipairs( CoD.CACUtility.GetAttachmentListForSlot( f65_arg0 ) ) do
				local f65_local8 = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f65_arg2, f65_local7 .. ".itemIndex" ) )
				if f65_local8 > CoD.CACUtility.EmptyItemIndex then
					local f65_local5 = Engine[@"getattachmentref"]( f65_local1, f65_local8 )
					if f65_local5 and f65_local5 == "dw" then
						return true
					end
				end
			end
		end
	end
	return false
end
CoD.CACUtility.DoesUnlockableItemHaveAnyAttachments = function ( f66_arg0, f66_arg1 )
	if CoD.CACUtility.EmptyItemIndex < f66_arg0 then
		if CoD.CACUtility.DvarUnlockableItemHasNoAttachments( Engine[@"hash_7B98952F69D937F9"]( f66_arg0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f66_arg1 ), f66_arg1 ) then
			return false
		elseif Engine[@"getnumattachments"]( f66_arg0, f66_arg1 ) > 1 then
			return true
		end
	end
	return false
end
CoD.CACUtility.GetItemName = function ( f67_arg0, f67_arg1, f67_arg2 )
	local f67_local0 = f67_arg2
	if not f67_local0 and f67_arg1 then
		f67_local0 = CoD.perController[f67_arg1].classModel
	end
	if f67_local0 then
		local f67_local1 = Engine[@"getmodel"]( f67_local0, f67_arg0 )
		if f67_local1 then
			local f67_local2 = Engine[@"getmodel"]( f67_local1, "name" )
			if f67_local2 then
				return Engine[@"getmodelvalue"]( f67_local2 )
			end
		end
	end
	return ""
end
CoD.CACUtility.GetItemReferenceName = function ( f68_arg0, f68_arg1 )
	local f68_local0 = Engine[@"getmodel"]( f68_arg0, "itemIndex" )
	if f68_local0 then
		return Engine[@"getitemref"]( Engine[@"getmodelvalue"]( f68_local0 ) )
	else
		return ""
	end
end
CoD.CACUtility.GetMutuallyExclusiveSlotName = function ( f69_arg0, f69_arg1, f69_arg2, f69_arg3, f69_arg4, f69_arg5 )
	local f69_local0 = {}
	local f69_local1 = function ( f70_arg0 )
		local f70_local0 = {}
		for f70_local4, f70_local5 in ipairs( CoD.BonuscardUtility.GetGunfighterArrayForSlot( f70_arg0 ) ) do
			if CoD.BonuscardUtility.IsBonuscardEquipped( f69_arg1, f70_local5.refHash, f69_arg5 ) then
				table.insert( f70_local0, f70_local5.refHash )
			end
		end
		if #f70_local0 > 1 then
			table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, f70_local0[#f70_local0], f69_arg5 ) )
		end
	end
	
	if LUI.startswith( f69_arg2, "bonuscard" ) then
		if f69_arg4 == @"bonuscard_overkill" then
			table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_underkill", f69_arg5 ) )
		elseif f69_arg4 == @"bonuscard_underkill" then
			table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_overkill", f69_arg5 ) )
		elseif f69_arg4 == @"bonuscard_primary_operator_mod" then
			table.insert( f69_local0, "primary.attachment.5" )
			table.insert( f69_local0, "primary.attachment.6" )
			f69_local1( "primary" )
		elseif f69_arg4 == @"bonuscard_secondary_operator_mod" then
			table.insert( f69_local0, "secondary.attachment.5" )
			table.insert( f69_local0, "secondary.attachment.6" )
			f69_local1( "secondary" )
		elseif CoD.BonuscardUtility.IsBonuscardOfTypeList( CoD.BonuscardUtility.GluttonyWildcards, f69_arg4 ) then
			for f69_local5, f69_local6 in ipairs( CoD.BonuscardUtility.GetSlotsWithEquippedGluttony( f69_arg1, f69_arg5 ) ) do
				table.insert( f69_local0, f69_local6 )
			end
			if f69_arg4 == @"bonuscard_perk_1_gluttony" then
				if CoD.TalentSelectUtility.GetTalentFilterForEquippedSlot( f69_arg1, "talent.1", f69_arg5 ) ~= "talent1" then
					table.insert( f69_local0, "talent.1" )
				end
				table.insert( f69_local0, "talent.2" )
				table.insert( f69_local0, "talent.3" )
				table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_perk_2_greed", f69_arg5 ) )
				table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_perk_3_greed", f69_arg5 ) )
			elseif f69_arg4 == @"bonuscard_perk_2_gluttony" then
				if CoD.TalentSelectUtility.GetTalentFilterForEquippedSlot( f69_arg1, "talent.2", f69_arg5 ) ~= "talent2" then
					table.insert( f69_local0, "talent.2" )
				end
				table.insert( f69_local0, "talent.1" )
				table.insert( f69_local0, "talent.3" )
				table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_perk_1_greed", f69_arg5 ) )
				table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_perk_3_greed", f69_arg5 ) )
			elseif f69_arg4 == @"bonuscard_perk_3_gluttony" then
				if CoD.TalentSelectUtility.GetTalentFilterForEquippedSlot( f69_arg1, "talent.3", f69_arg5 ) ~= "talent3" then
					table.insert( f69_local0, "talent.3" )
				end
				table.insert( f69_local0, "talent.1" )
				table.insert( f69_local0, "talent.2" )
				table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_perk_1_greed", f69_arg5 ) )
				table.insert( f69_local0, CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f69_arg1, @"bonuscard_perk_2_greed", f69_arg5 ) )
			end
		end
	elseif f69_arg2 == "primarygrenade" then
		if f69_arg5 == Enum[@"emodes"][@"mode_multiplayer"] then
			table.insert( f69_local0, "primarygrenadecount" )
		end
	elseif CoD.CACUtility.IsSlotNameInList( CoD.CACUtility.PrimaryAttachmentSlotNameList, f69_arg2 ) or CoD.CACUtility.IsSlotNameInList( CoD.CACUtility.SecondaryAttachmentSlotNameList, f69_arg2 ) then
		local f69_local7 = CoD.CACUtility.GetAttachmentListForSlot( f69_arg2 )
		local f69_local2 = "primary"
		if LUI.startswith( f69_arg2, "secondary" ) then
			f69_local2 = "secondary"
		end
		local f69_local3 = CoD.CACUtility.GetItemEquippedInSlot( f69_local2, f69_arg0, f69_arg1 )
		local f69_local4 = CoD.CACUtility.GetUnlockableItemInfoField( f69_local3, f69_arg5, @"hash_5665460432375A7" )
		local f69_local5 = Engine[@"hash_2B8DE256555CACF5"]( f69_local3, f69_arg3, f69_arg5 ) == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
		local f69_local6 = nil
		if f69_local4 then
			f69_local6 = LUI.splitString( f69_local4, " " )
		end
		for f69_local18, f69_local19 in ipairs( f69_local7 ) do
			local f69_local20 = CoD.CACUtility.GetItemEquippedInSlot( f69_local19, f69_arg0, f69_arg1 )
			if f69_local20 > CoD.CACUtility.EmptyItemIndex and f69_local20 ~= f69_arg3 then
				if not Engine[@"areattachmentscompatible"]( f69_local3, f69_local20, f69_arg3, f69_arg5 ) and (not Engine[@"isoptic"]( f69_local3, f69_local20 ) or not Engine[@"isoptic"]( f69_local3, f69_arg3 )) then
					table.insert( f69_local0, f69_local19 )
				end
				if f69_local6 then
					local f69_local11 = Engine[@"getattachmentref"]( f69_local3, f69_local20, f69_arg5 )
					local f69_local12 = Engine[@"hash_2B8DE256555CACF5"]( f69_local3, f69_local20, f69_arg5 ) == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
					if f69_local5 or f69_local12 then
						if f69_local12 or not f69_local5 and not f69_arg4 then
							f69_local11 = Engine[@"getattachmentref"]( f69_local3, f69_arg3, f69_arg5 )
						end
						for f69_local16, f69_local17 in ipairs( f69_local6 ) do
							if f69_local17 == f69_local11 then
								table.insert( f69_local0, f69_local19 )
							end
						end
					end
				end
			end
		end
	end
	if CoD.BonuscardUtility.IsBonuscardEquipped( f69_arg1, @"bonuscard_overkill", f69_arg5 ) then
		if f69_arg2 == "secondary" and CoD.CACUtility.GetItemEquippedInSlot( "primary", f69_arg0, f69_arg1 ) == f69_arg3 then
			table.insert( f69_local0, "primary" )
		elseif f69_arg2 == "primary" and CoD.CACUtility.GetItemEquippedInSlot( "secondary", f69_arg0, f69_arg1 ) == f69_arg3 then
			table.insert( f69_local0, "secondary" )
		end
	end
	if CoD.BonuscardUtility.IsBonuscardEquipped( f69_arg1, @"bonuscard_underkill", f69_arg5 ) then
		if f69_arg2 == "primary" and CoD.CACUtility.GetItemEquippedInSlot( "secondary", f69_arg0, f69_arg1 ) == f69_arg3 then
			table.insert( f69_local0, "secondary" )
		elseif f69_arg2 == "secondary" and CoD.CACUtility.GetItemEquippedInSlot( "primary", f69_arg0, f69_arg1 ) == f69_arg3 then
			table.insert( f69_local0, "primary" )
		end
	end
	return f69_local0
end
CoD.CACUtility.AttachmentHasCustomReticle = function ( f71_arg0 )
	return CoD.CACUtility.attachmentsWithCustReticle[f71_arg0] ~= nil
end
CoD.CACUtility.GetWeaponOptionId = function ( f72_arg0 )
	return Engine[@"tablelookup"]( CoD.attachmentTable, 4, 0, f72_arg0 )
end
CoD.CACUtility.SelectedClassIndex = {}
CoD.CACUtility.IsOnlineGame = function ()
	if Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_default"] ) == false and not Engine[@"sessionmode_issystemlinkgame"]() then
		return true
	else
		return false
	end
end
CoD.CACUtility.SetProfileLoadoutChoice = function ( f74_arg0, f74_arg1 )
	local f74_local0 = "lastLoadoutSystemlink"
	if CoD.CACUtility.IsOnlineGame() == true then
		if Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_league"] ) then
			f74_local0 = "lastLoadoutLeague"
		else
			f74_local0 = "lastLoadoutOnline"
		end
	end
	Engine[@"setprofilevar"]( f74_arg0, f74_local0, f74_arg1 )
	Engine[@"commitprofilechanges"]( f74_arg0 )
	CoD.CACUtility.SelectedClassIndex[f74_arg0] = f74_arg1
end
CoD.CACUtility.GetCACSlotStatus = function ( f75_arg0, f75_arg1, f75_arg2, f75_arg3 )
	local f75_local0 = CoD.CACUtility.CACStatusAvailable.AVAILABLE
	local f75_local1 = false
	local f75_local2 = 0x0
	local f75_local3 = nil
	if CoD.CACUtility.ItemEquippedInSlot( f75_arg2, f75_arg0, f75_arg1 ) then
		f75_local1 = true
		if f75_arg2 == "primary" or f75_arg2 == "secondary" then
			if IsLive() then
				f75_local2 = @"hash_32315E97C5F6E412"
			end
		elseif LUI.startswith( f75_arg2, "primaryattachment" ) or LUI.startswith( f75_arg2, "secondaryattachment" ) then
			if (f75_arg2 == "primaryattachment1" or f75_arg2 == "secondaryattachment1") and CoD.CACUtility.attachmentsWithCustReticle[CoD.CACUtility.GetItemRefHashEquippedInSlot( f75_arg2, f75_arg0, f75_arg1 )] and IsLive() then
				f75_local2 = @"hash_32315E97C5F6E412"
			end
		elseif f75_arg1[f75_arg2] and f75_arg1[f75_arg2].name then
			f75_local2 = f75_arg1[f75_arg2].name:get()
		end
	elseif f75_arg2 == "primary" or f75_arg2 == "secondary" then
		f75_local2 = @"hash_7255295BBBE277A2"
	elseif LUI.startswith( f75_arg2, "talent" ) then
		f75_local2 = 0xBFA59372F2ACBE
		if f75_arg2 == "talent.4" then
			if CoD.BonuscardUtility.IsBonuscardLocked( f75_arg0, @"bonuscard_perk_1_greed", f75_arg3 ) then
				f75_local2 = CoD.BonuscardUtility.GetBonucardUnlockHint( @"bonuscard_perk_1_greed", f75_arg3 )
				f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			elseif not CoD.BonuscardUtility.IsBonuscardEquipped( f75_arg1, @"bonuscard_perk_1_greed", f75_arg3 ) then
				f75_local2 = @"hash_5FE29AAA15234DF6"
				f75_local0 = CoD.CACUtility.CACStatusAvailable.REQUIRES_WILDCARD
			end
		elseif f75_arg2 == "talent.5" then
			if CoD.BonuscardUtility.IsBonuscardLocked( f75_arg0, @"bonuscard_perk_2_greed", f75_arg3 ) then
				f75_local2 = CoD.BonuscardUtility.GetBonucardUnlockHint( @"bonuscard_perk_2_greed", f75_arg3 )
				f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			elseif not CoD.BonuscardUtility.IsBonuscardEquipped( f75_arg1, @"bonuscard_perk_2_greed", f75_arg3 ) then
				f75_local2 = @"hash_95A3F78FC71190B"
				f75_local0 = CoD.CACUtility.CACStatusAvailable.REQUIRES_WILDCARD
			end
		elseif f75_arg2 == "talent.6" then
			if CoD.BonuscardUtility.IsBonuscardLocked( f75_arg0, @"bonuscard_perk_3_greed", f75_arg3 ) then
				f75_local2 = CoD.BonuscardUtility.GetBonucardUnlockHint( @"bonuscard_perk_3_greed", f75_arg3 )
				f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			elseif not CoD.BonuscardUtility.IsBonuscardEquipped( f75_arg1, @"bonuscard_perk_2_greed", f75_arg3 ) then
				f75_local2 = @"hash_31FF205BA14CD3F0"
				f75_local0 = CoD.CACUtility.CACStatusAvailable.REQUIRES_WILDCARD
			end
		end
	elseif LUI.startswith( f75_arg2, "primary.attachment" ) then
		local f75_local4 = CoD.CACUtility.GetItemEquippedInSlot( "primary", f75_arg0, f75_arg1 )
		local f75_local5 = Engine[@"getnumattachments"]( f75_local4, f75_arg3 )
		local f75_local6 = CoD.BonuscardUtility.IsOperatorModBonuscardEquipped( f75_arg1, "primary", f75_arg3 )
		if f75_arg2 == "primary.attachment.1" then
			f75_local2 = @"hash_49F5DC4A26E57427"
		elseif f75_arg2 == "primary.attachment.5" and f75_local6 then
			f75_local2 = @"hash_39F327BD38D330A6"
		else
			f75_local2 = @"hash_55A98A0F0014797F"
		end
		if f75_local4 <= CoD.CACUtility.EmptyItemIndex then
			f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			if f75_arg2 == "primary.attachment.1" then
				f75_local2 = @"hash_16968EFB9D8CC09F"
			else
				f75_local2 = @"hash_277480FA0F47B62D"
			end
		elseif f75_arg2 == "primary.attachment.1" and Engine[@"getnumoptics"]( f75_local4, f75_arg3 ) <= 1 then
			f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			f75_local2 = @"hash_16968EFB9D8CC09F"
		elseif (f75_arg2 == "primary.attachment.2" or f75_arg2 == "primary.attachment.3") and f75_local5 <= 1 then
			f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			f75_local2 = @"hash_277480FA0F47B62D"
		elseif f75_arg2 == "primary.attachment.4" or f75_arg2 == "primary.attachment.5" or f75_arg2 == "primary.attachment.6" then
			if f75_local5 <= 1 then
				f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
				f75_local2 = @"hash_277480FA0F47B62D"
			elseif CoD.BonuscardUtility.IsAnyGunfighterForSlotLocked( f75_arg0, "primary", f75_arg3 ) then
				f75_local2 = CoD.BonuscardUtility.GetBonucardUnlockHint( @"bonuscard_primary_gunfighter", f75_arg3 )
				f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			else
				local f75_local7 = CoD.BonuscardUtility.SpecificGunfighterEquippedCount( f75_arg1, CoD.BonuscardUtility.PrimaryGunfighterWildcards, f75_arg3 )
				if not (f75_arg2 ~= "primary.attachment.4" or f75_local7 >= 1) or not (f75_arg2 ~= "primary.attachment.5" or f75_local7 >= 2 or f75_local6) or f75_arg2 == "primary.attachment.6" and f75_local7 < 3 then
					f75_local2 = @"hash_CF12521CB1F1028"
					f75_local0 = CoD.CACUtility.CACStatusAvailable.REQUIRES_WILDCARD
				end
			end
		end
	elseif LUI.startswith( f75_arg2, "secondary.attachment" ) then
		local f75_local4 = CoD.CACUtility.GetItemEquippedInSlot( "secondary", f75_arg0, f75_arg1 )
		local f75_local5 = Engine[@"getnumattachments"]( f75_local4, f75_arg3 )
		if f75_arg2 == "secondary.attachment.1" then
			f75_local2 = @"hash_49F5DC4A26E57427"
		else
			f75_local2 = @"hash_55A98A0F0014797F"
		end
		if f75_local4 <= CoD.CACUtility.EmptyItemIndex then
			f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			if f75_arg2 == "secondary.attachment.1" then
				f75_local2 = @"hash_16968EFB9D8CC09F"
			else
				f75_local2 = @"hash_277480FA0F47B62D"
			end
		elseif f75_arg2 == "secondary.attachment.1" and Engine[@"getnumoptics"]( f75_local4, f75_arg3 ) <= 1 then
			f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			f75_local2 = @"hash_16968EFB9D8CC09F"
		elseif (f75_arg2 == "secondary.attachment.2" or f75_arg2 == "secondary.attachment.3") and f75_local5 <= 1 then
			f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			f75_local2 = @"hash_277480FA0F47B62D"
		elseif f75_arg2 == "secondary.attachment.4" or f75_arg2 == "secondary.attachment.5" or f75_arg2 == "secondary.attachment.6" then
			if f75_local5 <= 1 then
				f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
				f75_local2 = @"hash_277480FA0F47B62D"
			elseif CoD.BonuscardUtility.IsAnyGunfighterForSlotLocked( f75_arg0, "secondary", f75_arg3 ) then
				f75_local2 = CoD.BonuscardUtility.GetBonucardUnlockHint( @"bonuscard_secondary_gunfighter", f75_arg3 )
				f75_local0 = CoD.CACUtility.CACStatusAvailable.NOT_AVAILABLE
			else
				local f75_local6 = CoD.BonuscardUtility.SpecificGunfighterEquippedCount( f75_arg1, CoD.BonuscardUtility.SecondaryGunfighterWildcards, f75_arg3 )
				if not (f75_arg2 ~= "secondary.attachment.4" or f75_local6 >= 1) or not (f75_arg2 ~= "secondary.attachment.5" or f75_local6 >= 2) or f75_arg2 == "secondary.attachment.6" and f75_local6 < 3 then
					f75_local2 = @"hash_59C2D08EF8830FEC"
					f75_local0 = CoD.CACUtility.CACStatusAvailable.REQUIRES_WILDCARD
				end
			end
		end
	elseif f75_arg2 == "primarygrenadecount" then
		if CoD.CACUtility.EmptyItemIndex < f75_arg1.primarygrenade.itemIndex:get() and f75_arg1.canTakeTwo:get() then
			f75_local3 = f75_arg1.primarygrenade.name:get()
		end
		f75_local2 = @"hash_151AE669EEB81040"
	elseif f75_arg2 == "tacticalgear" then
		f75_local2 = @"hash_33684B3BA88B8D30"
	elseif LUI.startswith( f75_arg2, "bonuscard" ) then
		f75_local2 = @"hash_29B69F69ABFD6250"
	end
	return f75_local0, f75_local1, f75_local2, f75_local3
end
CoD.CACUtility.SortUnlockableItemsBySortIndex = function ( f76_arg0, f76_arg1 )
	return CoDLoadoutsShared.SortUnlockableItemsBySortIndex( f76_arg0, f76_arg1 )
end
CoD.CACUtility.GetUnlockableItemsForItemGroup = function ( f77_arg0, f77_arg1, f77_arg2, f77_arg3 )
	local f77_local0 = {}
	for f77_local5, f77_local6 in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
		local f77_local7 = f77_local6
		if CoD.BitUtility.IsBitSet( f77_local7.modes, f77_arg1 ) and f77_local7.itemGroup == f77_arg2 and f77_local7[@"hideinmenu"] ~= 1 and not CoD.CACUtility.DvarHideUnlockableItem( f77_local7.nameHash, f77_arg1 ) then
			local f77_local4 = CoD.BlackMarketTableUtility.LootInfoLookup( f77_arg0, f77_local7.nameHash )
			if not f77_local4 or not f77_local4.isLoot or f77_local4.available then
				table.insert( f77_local0, f77_local7 )
			end
			if f77_local7.nameHash == @"ar_galil_t8" then
				table.insert( f77_local0, f77_local7 )
			end
			if f77_arg1 == Enum[@"emodes"][@"mode_warzone"] and CoD.WZUtility.WZDLC1WeaponNames and CoD.WZUtility.ArrayContains( CoD.WZUtility.WZDLC1WeaponNames, f77_local7.nameHash ) then
				table.insert( f77_local0, f77_local7 )
			end
		end
	end
	if f77_arg3 then
		return f77_local0
	else
		return CoD.CACUtility.SortUnlockableItemsBySortIndex( f77_local0, f77_arg1 )
	end
end
CoD.CACUtility.GetUnlockableItemsForLoadoutSlot = function ( f78_arg0, f78_arg1, f78_arg2, f78_arg3 )
	return CoDLoadoutsShared.GetUnlockableItemsForLoadoutSlot( f78_arg0, f78_arg1, f78_arg2, f78_arg3 )
end
CoD.CACUtility.GetUnlockableItemsForLoadoutSlotExact = function ( f79_arg0, f79_arg1 )
	local f79_local0 = {}
	for f79_local4, f79_local5 in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
		if CoD.BitUtility.IsBitSet( f79_local5.modes, f79_arg0 ) and f79_local5.loadoutSlot == f79_arg1 and f79_local5[@"hideinmenu"] ~= 1 then
			table.insert( f79_local0, f79_local5 )
		end
	end
	return CoD.CACUtility.SortUnlockableItemsBySortIndex( f79_local0, f79_arg0 )
end
CoD.CACUtility.GetUnlockableBGBItemsForItemGroupAndRarity = function ( f80_arg0, f80_arg1, f80_arg2 )
	local f80_local0 = {}
	for f80_local4, f80_local5 in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
		if CoD.BitUtility.IsBitSet( f80_local5.modes, f80_arg0 ) and f80_local5.itemGroup == f80_arg1 and f80_local5[@"hideinmenu"] ~= 1 and not CoD.CACUtility.DvarHideUnlockableItem( f80_local5.nameHash, f80_arg0 ) and (f80_arg2 == nil or f80_local5[@"bgbrarity"] == f80_arg2) then
			table.insert( f80_local0, f80_local5 )
		end
	end
	return CoD.CACUtility.SortUnlockableItemsBySortIndex( f80_local0, f80_arg0 )
end
CoD.CACUtility.GetUnlockableTalismanItemsForRarity = function ( f81_arg0, f81_arg1 )
	local f81_local0 = {}
	for f81_local4, f81_local5 in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
		if CoD.BitUtility.IsBitSet( f81_local5.modes, f81_arg0 ) and f81_local5.itemGroup == CoD.CACUtility.talismanItemGroup and f81_local5[@"hideinmenu"] ~= 1 and not CoD.CACUtility.DvarHideUnlockableItem( f81_local5.nameHash, f81_arg0 ) and f81_local5[@"talismanrarity"] == f81_arg1 then
			table.insert( f81_local0, f81_local5 )
		end
	end
	return CoD.CACUtility.SortUnlockableItemsBySortIndex( f81_local0, f81_arg0 )
end
CoD.CACUtility.AnyTalismanRestrictedInTable = function ( f82_arg0 )
	if f82_arg0 then
		for f82_local3, f82_local4 in ipairs( f82_arg0 ) do
			if CoD.CACUtility.AreTalismanGameSettingsRestricted( CoD.ZMTalismanUtility.TalismanToBooleanGameSettingsHash[f82_local4.nameHash], f82_local4[@"talismanrarity"], false ) or CoD.CACUtility.AreGameSettingsStateOff( CoD.ZMTalismanUtility.TalismanToEnumGameSettingsHash[f82_local4.nameHash], false ) then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.AnyTalismanRestrictedForRarity = function ( f83_arg0 )
	if CoD.CACUtility.AnyTalismanRestrictedInTable( CoD.CACUtility.GetUnlockableTalismanItemsForRarity( Enum[@"emodes"][@"mode_zombies"], f83_arg0 ) ) then
		return true
	else
		return false
	end
end
CoD.CACUtility.GetUnlockableItemInfo = function ( f84_arg0, f84_arg1 )
	local f84_local0 = CoD.CACUtility.GetUnlockableItemTable()
	f84_local0 = f84_local0[f84_arg0]
	if f84_local0 ~= nil and CoD.BitUtility.IsBitSet( f84_local0.modes, f84_arg1 ) then
		return f84_local0
	else
		return nil
	end
end
CoD.CACUtility.GetUnlockableItemInfoField = function ( f85_arg0, f85_arg1, f85_arg2, f85_arg3 )
	local f85_local0 = CoD.CACUtility.GetUnlockableItemInfo( f85_arg0, f85_arg1 )
	local f85_local1
	if f85_local0 then
		f85_local1 = f85_local0[f85_arg2]
		if not f85_local1 then
		
		else
			return f85_local1
		end
	end
	f85_local1 = f85_arg3
end
CoD.CACUtility.GetUnlockableItemInfoByAssetHash = function ( f86_arg0, f86_arg1 )
	for f86_local3, f86_local4 in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
		if Engine[@"converttoxhash"]( f86_local4.name ) == f86_arg0 or f86_local4.nameHash == f86_arg0 then
			if CoD.BitUtility.IsBitSet( f86_local4.modes, f86_arg1 ) then
				return f86_local4
			end
			return nil
		end
	end
end
CoD.CACUtility.GetUnlockableItemInfoByModeSuffixedAssetHash = function ( f87_arg0, f87_arg1 )
	local f87_local0 = CoD.CACUtility.GetUnlockableItemTable()
	local f87_local1 = "_" .. Engine[@"getabbreviationformode"]( f87_arg1 )
	for f87_local5, f87_local6 in pairs( f87_local0 ) do
		if Engine[@"converttoxhash"]( f87_local6.name .. f87_local1 ) == f87_arg0 or f87_local6.nameHash .. f87_local1 == f87_arg0 then
			if CoD.BitUtility.IsBitSet( f87_local6.modes, f87_arg1 ) then
				return f87_local6
			end
			return nil
		end
	end
end
CoD.CACUtility.GetStatIndexOffsetForLoadoutSlot = function ( f88_arg0, f88_arg1 )
	return CoDLoadoutsShared.GetStatIndexOffsetForLoadoutSlot( f88_arg0, f88_arg1 )
end
CoD.CACUtility.BuildItemModelDataFromUnlockableItem = function ( f89_arg0, f89_arg1, f89_arg2, f89_arg3, f89_arg4, f89_arg5, f89_arg6 )
	local f89_local0, f89_local1, f89_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f89_arg0 )
	local f89_local3 = 0
	local f89_local4 = 0
	local f89_local5, f89_local6 = nil
	local f89_local7 = false
	local f89_local8 = false
	local f89_local9 = 0
	if f89_arg2.itemGroup == "bonuscard" then
		f89_local4 = 79
		if f89_arg2.nameHash == @"bonuscard_primary_operator_mod" or f89_arg2.nameHash == @"bonuscard_secondary_operator_mod" then
			f89_local3 = 44
		end
		f89_local5 = CoD.BonuscardUtility.GetInfoForBonuscard( f89_arg2, "modifiedSlotEnum" )
		if CoD.BaseUtility.IsMenuContextualEquipping( f89_arg0 ) then
			if not CoD.BonuscardUtility.CanEquipBonuscard( f89_arg5, f89_arg2 ) then
				f89_local6 = not CoD.BonuscardUtility.IsBonuscardEquipped( f89_local0, f89_arg2.nameHash, f89_local1 )
			else
				f89_local6 = false
			end
			f89_local7 = f89_local6 and f89_arg6 == f89_arg2.itemIndex
		else
			f89_local6 = CoD.BonuscardUtility.CanEquipBonuscard( f89_arg4, f89_arg2 )
		end
	elseif f89_local1 == Enum[@"emodes"][@"mode_multiplayer"] and f89_arg2.itemGroup == "weapon_grenade" then
		if f89_arg2.nameHash == CoDShared.DefaultSpecialistEquipment then
			f89_local3 = 75
		end
	elseif f89_arg2.itemGroup == "bubblegum_consumable" or f89_arg2.itemGroup == "bubblegum" then
		local f89_local10 = Engine[@"getequippedbubblegumpack"]( f89_arg1 )
		local f89_local11 = DataSources.BGBLoadout.getModel( f89_arg1 )
		local f89_local12 = Engine[@"getbubblegumbuff"]( f89_arg1, f89_local10, f89_local11.selectedIndex:get() )
		local f89_local13 = CoD.BGBUtility.ElixirToBooleanGameSettingsHash[f89_arg2.nameHash]
		local f89_local14 = CoD.BGBUtility.ElixirToEnumGameSettingsHash[f89_arg2.nameHash]
		if not CoD.DirectorUtility.ShowDirectorPregame( f89_arg1 ) then
			local f89_local15 = CoD.CACUtility.AreElixirGameSettingsRestricted( f89_local13, f89_arg2[@"bgbrarity"], false )
			f89_local8 = CoD.CACUtility.AreGameSettingsStateOff( f89_local14, false )
		else
			f89_local8 = false
		end
		f89_local7 = f89_arg2.itemIndex == f89_local12
	elseif f89_arg2.itemGroup == CoD.CACUtility.talismanItemGroup then
		local f89_local10 = CoD.ZMTalismanUtility.TalismanToBooleanGameSettingsHash[f89_arg2.nameHash]
		local f89_local11 = CoD.ZMTalismanUtility.TalismanToEnumGameSettingsHash[f89_arg2.nameHash]
		if not CoD.DirectorUtility.ShowDirectorPregame( f89_arg1 ) then
			local f89_local16 = CoD.CACUtility.AreTalismanGameSettingsRestricted( f89_local10, f89_arg2[@"talismanrarity"], false )
			f89_local8 = CoD.CACUtility.AreGameSettingsStateOff( f89_local11, false )
		else
			f89_local8 = false
		end
	elseif f89_local1 == Enum[@"emodes"][@"mode_zombies"] and f89_arg2.loadoutSlot == "primarygrenade" then
		f89_local8 = CoD.CACUtility.AreEquipmentsRestricted( false )
	elseif f89_arg0._loadoutSlot == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
		f89_local7 = f89_arg2.itemIndex == CoD.CACUtility.GetEquippedItemIndex( f89_arg0, f89_arg1 )
		f89_local8 = CoD.CACUtility.IsItemGroupRestricted( f89_arg2.itemGroupIndex, false )
	elseif f89_arg2.loadoutSlot == "primary" or f89_arg2.loadoutSlot == "secondary" then
		if f89_local1 == Enum[@"emodes"][@"mode_zombies"] then
			f89_local8 = CoD.CACUtility.IsItemGroupRestricted( f89_arg2.itemGroupIndex, false )
		end
		local f89_local11 = {
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f89_arg1, f89_local1 ),
			_sessionMode = f89_local1
		}
		f89_local9 = CoD.BreadcrumbUtility.GetAccessoryNewCountForWeapon( f89_local11, f89_arg1, f89_arg2.nameHash ) + CoD.BreadcrumbUtility.GetDeathFxNewCountForWeapon( f89_local11, f89_arg1, f89_arg2.nameHash ) + CoD.BreadcrumbUtility.GetTotalCamoNewCountForWeapon( f89_local11, f89_arg1, f89_arg2.nameHash )
	end
	local f89_local10 = ""
	local f89_local11 = {}
	local f89_local12 = "damage"
	local f89_local13 = "range"
	local f89_local14 = "fireRate"
	local f89_local17 = "accuracy"
	local f89_local18 = "magCount"
	local f89_local19 = "magSize"
	f89_local11.uberName = 0x0
	f89_local11.uberImage = 0x0
	f89_local11[1] = f89_local12
	f89_local11[2] = f89_local13
	f89_local11[3] = f89_local14
	f89_local11[4] = f89_local17
	f89_local11[5] = f89_local18
	f89_local11[6] = f89_local19
	if f89_arg2.attributesTable or f89_arg2.attributesTableZM and f89_local1 == Enum[@"emodes"][@"mode_zombies"] then
		f89_local12 = f89_arg2.attributesTable
		if f89_arg2.attributesTableZM and f89_local1 == Enum[@"emodes"][@"mode_zombies"] then
			f89_local12 = f89_arg2.attributesTableZM
		end
		if f89_local12 then
			f89_local11 = {
				damage = f89_local12.damage,
				range = f89_local12.range,
				fireRate = f89_local12.fireRate,
				accuracy = f89_local12.accuracy,
				magCount = f89_local12.magCount,
				magSize = f89_local12.magSize,
				uberName = f89_local12.uberName,
				uberImage = f89_local12.uberImage
			}
		end
		if f89_local1 ~= Enum[@"emodes"][@"mode_zombies"] and not IsCustomLobby() and CoD.CACUtility.IsWeaponLevelMax( f89_arg1, f89_arg2.itemIndex, f89_local1 ) and not CoD.CACUtility.IsWeaponPrestigeLevelMax( f89_arg1, f89_arg2.itemIndex, f89_local1 ) then
			f89_local10 = Engine[@"localize"]( @"hash_6DEEE55C412CA473" )
		end
	end
	f89_local12 = Engine[@"getglobalmodel"]()
	f89_local13 = nil
	if f89_local2 == "primary" or f89_local2 == "secondary" then
		f89_local14 = DataSources.LoadoutBreadcrumbs.getModel( f89_arg1 )
		f89_local12 = f89_local14.signature[f89_arg2.itemIndex] or Engine[@"getglobalmodel"]()
		f89_local13 = 0
	end
	if f89_local1 == Enum[@"emodes"][@"mode_multiplayer"] then
		f89_local8 = CoD.CACUtility.IsItemIndexRestricted( f89_arg2.globalItemIndex )
	end
	f89_local14 = CoD.BlackMarketTableUtility.LootInfoLookup( f89_arg1, f89_arg2.nameHash )
	f89_local17 = {}
	f89_local18 = {
		name = f89_arg2.name,
		refHash = f89_arg2.nameHash,
		globalItemIndex = f89_arg2.globalItemIndex,
		itemIndex = f89_arg2.itemIndex,
		displayName = Engine[@"hash_4F9F1239CFD921FE"]( f89_arg2.displayName ),
		baseWeaponName = f89_arg2.displayName,
		displayNameShort = f89_arg2.displayNameShort,
		image = CoD.CACUtility.GetPreviewImage( f89_local1, f89_arg2 ),
		imageLarge = CoD.CACUtility.GetPreviewImageLarge( f89_local1, f89_arg2 ),
		description = CoD.CACUtility.GetDescription( f89_local1, f89_arg2 ),
		equipped = f89_arg2.itemIndex == f89_arg3,
		bonuscardModifiedSlotEnum = f89_local5,
		canEquipBonuscard = f89_local6,
		hintText = f89_local10,
		isRestricted = f89_local8,
		useVariantSlot = f89_local13,
		weaponModelSlot = 0,
		weaponAttributes = {
			damage = f89_local11.damage,
			range = f89_local11.range,
			fireRate = f89_local11.fireRate,
			accuracy = f89_local11.accuracy,
			magCount = f89_local11.magCount,
			magSize = f89_local11.magSize,
			uberName = f89_local11.uberName,
			uberImage = f89_local11.uberImage
		},
		signatureBreadcrumb = f89_local12,
		breadcrumbCount = f89_local9
	}
	f89_local19 = {
		owned = f89_local14.owned,
		hideRarity = false
	}
	local f89_local20 = CoD.BlackMarketUtility.LootIdRarities[f89_local14.rarity]
	if not f89_local20 then
		f89_local20 = Enum[@"lootraritytype"][@"loot_rarity_type_count"]
	end
	f89_local19.rarity = f89_local20
	f89_local20 = f89_local14.unlockInfo
	if not f89_local20 then
		f89_local20 = ""
	end
	f89_local19.unlockInfo = f89_local20
	f89_local19.isLoot = f89_local14.isLoot
	f89_local18.lootData = f89_local19
	f89_local18.isMastercraft = false
	f89_local18.signatureVariantName = 0x0
	f89_local17.models = f89_local18
	f89_local17.properties = {
		selectIndex = f89_local7,
		equipSound = f89_arg2[@"equipsound"],
		unequipSound = f89_arg2[@"unequipsound"],
		vSpacing = f89_local3,
		hSpacing = f89_local4,
		_useVariantSlot = f89_local13
	}
	f89_local18 = function ( f90_arg0, f90_arg1, f90_arg2, f90_arg3 )
		local f90_local0 = CoD.CACUtility.VariantWeaponLoadoutListPrepareHelper
		local f90_local1 = f89_arg1
		local f90_local2 = f89_local0
		local f90_local3 = f89_local2
		local f90_local4 = f89_local0
		if f90_local4 then
			f90_local4 = f89_local0:create( "classNum" )
			f90_local4 = f90_local4:get()
		end
		f90_arg3.variantList = f90_local0( f90_local1, f90_local2, f90_local3, f90_local4, f89_local1, f90_arg0 )
		if not f90_arg2 or f90_arg2 <= 0 then
			return false
		else
			f90_local0 = Engine[@"hash_79F0BB7D52A7A978"]( f90_arg1 )
			f90_local1 = f90_local0[f90_arg2 + 1]
			if f90_local1 then
				if f90_local1[@"hash_5C2AA73D9F82E9C2"] and f90_local1[@"ismark2"] then
					f90_arg3.displayName = Engine[@"hash_4F9F1239CFD921FE"]( f90_local1[@"displayname"] )
				else
					f90_arg3.displayName = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_341954FC612B5845", f90_arg3.displayName )
					f90_arg3.isMastercraft = true
					f90_arg3.signatureVariantName = f90_local1[@"displayname"]
				end
				if f89_local1 == Enum[@"emodes"][@"mode_zombies"] then
					f90_arg3.image = f90_local1[@"imagezm"]
				else
					f90_arg3.image = f90_local1[@"image"]
				end
				return true
			else
				return false
			end
		end
	end
	
	f89_local19 = f89_local17.models
	f89_local20 = f89_local14.useVariantSlot
	if not f89_local20 then
		f89_local20 = 0
	end
	f89_local19.weaponModelSlot = f89_local20
	if CoD.ZMLoadoutUtility and (f89_local2 == "armory" or f89_local2 == "zmStartWeapon") then
		if f89_local2 == "armory" then
			CoD.ZMLoadoutUtility.AddArmoryAttachmentModelsAndProperties( f89_local17, f89_arg1, f89_arg2.itemIndex, f89_local1 )
		end
		f89_local19 = f89_local14.useVariantSlot
		if not f89_local19 then
			f89_local19 = 0
		end
		f89_local20 = CoD.ZMLoadoutUtility.GetWeaponModelSlot( f89_arg2.itemIndex, f89_arg1, f89_local19 )
		if f89_local19 > 0 and f89_local20 == 0 then
			local f89_local21, f89_local22 = CoD.BlackMarketTableUtility.SimpleLootLookup( f89_arg1, f89_arg2.nameHash )
			if f89_local22 == false then
				f89_local20 = f89_local19
			end
		end
		f89_local17.models.weaponModelSlot = f89_local20
		if f89_local20 and f89_local20 > 0 then
			local f89_local21 = CoD.ZMLoadoutUtility.GetVariantSlot( f89_arg1, f89_arg2.itemIndex, true )
			f89_local21.weaponModelSlot:set( f89_local20 )
		end
	end
	if CoD.WZUtility and f89_local2 == "wzpersonalize" then
		f89_local19 = f89_local14.useVariantSlot
		if not f89_local19 then
			f89_local19 = 0
		end
		f89_local20 = CoD.WZUtility.GetWeaponModelSlot( f89_arg2.itemIndex, f89_arg1, f89_local19 )
		if f89_local19 > 0 and f89_local20 == 0 then
			local f89_local21, f89_local22 = CoD.BlackMarketTableUtility.SimpleLootLookup( f89_arg1, f89_arg2.nameHash )
			if f89_local22 == false then
				f89_local20 = f89_local19
			end
		end
		f89_local17.models.weaponModelSlot = f89_local20
		if f89_local20 and f89_local20 > 0 then
			local f89_local21 = CoD.WZUtility.GetVariantSlot( f89_arg1, f89_arg2.itemIndex, true )
			f89_local21.weaponModelSlot:set( f89_local20 )
		end
	end
	if f89_local1 == Enum[@"emodes"][@"mode_multiplayer"] and f89_local17.models.equipped and (f89_local2 == "primary" or f89_local2 == "secondary") then
		f89_local19 = f89_local17.models
		f89_local20 = CoD.CACUtility.GetItemWeaponModelSlotIndexEquippedInSlot( f89_local2, f89_arg1, f89_local0 )
		if not f89_local20 then
			f89_local20 = 0
		end
		f89_local19.weaponModelSlot = f89_local20
	end
	if f89_local18( f89_arg2.itemIndex, f89_arg2.nameHash, f89_local17.models.weaponModelSlot, f89_local17.models ) then
		f89_local17.models.useVariantSlot = f89_local17.models.weaponModelSlot
		f89_local17.properties._useVariantSlot = f89_local17.models.weaponModelSlot
	end
	return f89_local17
end
CoD.CACUtility.UpdateCustomClassModelsFromDDL = function ( f91_arg0, f91_arg1, f91_arg2 )
	local f91_local0 = function ( f92_arg0, f92_arg1, f92_arg2, f92_arg3 )
		if f92_arg1.keys ~= nil then
			for f92_local5, f92_local6 in ipairs( f92_arg1.keys ) do
				local f92_local7 = f92_arg0[f92_local6]
				if f92_local7 then
					local f92_local3 = f92_local7:get()
					if f92_arg3 and (f92_arg3 == "primary" or f92_arg3 == "secondary") then
						local f92_local4 = f92_arg2:create( f92_local6 )
						f92_local4:set( f92_local3 )
					else
						local f92_local4 = f92_arg2:create( f92_local6 )
						f92_local4 = f92_local4:create( "itemIndex" )
						f92_local4:set( f92_local3 )
						goto basicblock_12:
					end
				end
				if f92_arg2 and f92_arg2[f92_local6] then
					f92_arg2[f92_local6].itemIndex:set( CoD.CACUtility.EmptyItemIndex )
				end
			end
		end
		if f92_arg1.arrays ~= nil then
			for f92_local5, f92_local6 in ipairs( f92_arg1.arrays ) do
				local f92_local7 = f92_arg0[f92_local6]
				if f92_local7 then
					for f92_local3 = 1, #f92_local7, 1 do
						local f92_local9 = f92_local7[f92_local3 - 1]:get()
						if f92_local6 ~= "attachment" then
							local f92_local10 = f92_arg2:create( f92_local6 .. "." .. f92_local3 )
							f92_local10 = f92_local10:create( "itemIndex" )
							f92_local10:set( f92_local9 )
						end
					end
				end
			end
		end
		if f92_arg1.structArrays ~= nil then
			for f92_local5, f92_local6 in pairs( f92_arg1.structArrays ) do
				local f92_local7 = f92_arg0[f92_local5]
				if f92_local7 then
					local f92_local3 = f92_arg2:create( f92_local5 )
					for f92_local4 = 1, #f92_local7, 1 do
						REG3( f92_local7[f92_local4 - 1], f92_local6, f92_local3, f92_local5 )
					end
				end
			end
		end
		if f92_arg1.structs ~= nil then
			for f92_local5, f92_local6 in pairs( f92_arg1.structs ) do
				local f92_local7 = f92_arg0[f92_local5]
				if f92_local7 then
					REG3( f92_local7, f92_local6, f92_arg2:create( f92_local5 ), f92_local5 )
				end
			end
		end
	end
	
	f91_local0( f91_arg0, f91_arg1, f91_arg2 )
end
CoD.CACUtility.GetDefaultCustomClassNameForGametype = function ()
	local f93_local0 = Engine[@"lobbygetgametype"]()
	if f93_local0 then
		local f93_local1 = CoD.GameTypeUtility.GameTypeTable[Engine[@"converttoxhash"]( f93_local0 )]
		if f93_local1 and f93_local1.loadout and f93_local1.loadout ~= 0x0 then
			return Engine[@"hash_2E00B2F29271C60B"]( f93_local1.loadout )
		end
	end
end
CoD.CACUtility.GetDefaultCustomClassName = function ( f94_arg0, f94_arg1 )
	local f94_local0 = CoD.BaseUtility.GetLocStringListEntry( @"lsl_class_sets", f94_arg0 )
	if f94_arg1 == Enum[@"emodes"][@"mode_zombies"] or f94_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
		local f94_local1 = nil
		local f94_local2 = "defaultcustomloadouts"
		if f94_arg1 == Enum[@"emodes"][@"mode_zombies"] then
			f94_local1 = Engine[@"hash_2E00B2F29271C60B"]( @"zm_default_loadouts" )
		else
			f94_local1 = Engine[@"hash_2E00B2F29271C60B"]( LuaUtils.IsArenaMode() and @"mp_arena_default_loadouts" or @"mp_default_loadouts" )
			local f94_local3 = CoD.CACUtility.GetDefaultCustomClassNameForGametype()
			if f94_local3 then
				f94_local1 = f94_local3
			end
			if f94_arg0 > Enum[@"loadoutclass_t"][@"custom_class_count"] then
				f94_arg0 = f94_arg0 - Enum[@"loadoutclass_t"][@"custom_class_count"]
				f94_local2 = "defaultloadouts"
			end
		end
		local f94_local3 = f94_local1[f94_local2]
		if f94_local3 then
			f94_local3 = f94_local1[f94_local2][f94_arg0]
		end
		if f94_local3 == nil then
			return f94_local0
		end
		f94_local0 = f94_local3[@"customclassname"]
		if f94_arg1 == Enum[@"emodes"][@"mode_zombies"] then
			local f94_local4 = Engine[@"hash_6BBE3328FE08B8C7"]()
			local f94_local5 = ""
			if f94_local4 then
				f94_local4 = f94_local4 + 1
				f94_local5 = "_" .. f94_local4
			end
			if f94_local4 > 1 then
				local f94_local6 = @"customclassname" .. f94_local5
				if f94_local3[f94_local6] then
					f94_local0 = f94_local3[f94_local6]
				end
			end
		end
	end
	return f94_local0
end
CoD.CACUtility.GetCustomClassModel = function ( f95_arg0, f95_arg1, f95_arg2, f95_arg3, f95_arg4 )
	if not f95_arg4 then
		f95_arg4 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	end
	if f95_arg4 == Enum[@"emodes"][@"mode_warzone"] then
		return 
	end
	local f95_local0 = Engine[@"getcustomclasscacroot"]( f95_arg0, f95_arg1, f95_arg4, f95_arg3 )
	if not f95_local0 then
		return 
	end
	local f95_local1 = f95_arg2:create( "classNum" )
	f95_local1:set( f95_arg1 )
	f95_local1 = 0
	CoD.CACUtility.UpdateCustomClassModelsFromDDL( f95_local0, CoD.CACUtility.loadoutSlotDDLNames[f95_arg4], f95_arg2 )
	local f95_local2 = Engine[@"hash_E5BD7B646B44027"]( f95_arg0, f95_arg1, f95_arg4, f95_arg3 )
	if f95_local2 == "" then
		f95_local2 = CoD.CACUtility.GetDefaultCustomClassName( f95_arg1 + 1, f95_arg4 )
		if f95_local2 then
			f95_local2 = Engine[@"hash_4F9F1239CFD921FE"]( f95_local2 )
		end
	end
	if CoD.perController[f95_arg0].isPreset == true then
		f95_local2 = Engine[@"localize"]( f95_local2 )
	end
	local f95_local3 = f95_arg2:create( "customClassName" )
	f95_local3:set( f95_local2 )
	f95_local3 = f95_arg2:create( "tabHasRestrictions" )
	f95_local3:set( false )
	if f95_arg1 >= Enum[@"loadoutclass_t"][@"custom_class_count"] then
		f95_local3 = f95_arg2:create( "defaultClassName" )
		f95_local3:set( Engine[@"getdefaultclassname"]( f95_arg1 - Enum[@"loadoutclass_t"][@"custom_class_count"] ) )
	end
	f95_local3 = function ( f96_arg0 )
		local f96_local0 = f95_arg2[f96_arg0]
		if f96_local0 and f96_local0.itemIndex then
			local f96_local1 = f96_local0.itemIndex:get()
			local f96_local2 = LUI.splitString( f96_arg0, "." )
			f96_local2 = f96_local2[1]
			if f96_local2 and f96_local2 ~= "" then
				local f96_local3 = CoD.BaseUtility.GetLocStringListEntry( @"lsl_loadout_slots", f96_local2 )
				local f96_local4 = f96_local0:create( "headerName" )
				f96_local4:set( f96_local3 )
			else
				local f96_local3 = f96_local0:create( "headerName" )
				f96_local3:set( 0x0 )
			end
			if f96_local1 ~= CoDShared.EmptyItemIndex then
				local f96_local3 = CoD.CACUtility.GetUnlockableItemInfoField( f96_local1, f95_arg4, "itemGroup", Enum[@"itemgroup_t"][@"itemgroup_invalid"] )
				if f96_local3 ~= Enum[@"itemgroup_t"][@"itemgroup_invalid"] then
					for f96_local8, f96_local9 in ipairs( CoD.CACUtility.ItemGroupInfo ) do
						if f96_local9.itemGroup == f96_local3 then
							local f96_local7 = f96_local0:create( "itemGroupName" )
							f96_local7:set( f96_local9.name )
							break
						end
					end
				end
			end
			if CoD.isPC and f95_arg4 == Enum[@"emodes"][@"mode_multiplayer"] and f96_local1 == CoD.CACUtility.EmptyItemIndex then
				local f96_local3 = f96_local0:create( "tooltipArchetype" )
				f96_local3:set( CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT )
			end
		end
	end
	
	for f95_local7, f95_local8 in pairs( CoDLoadoutsShared.loadoutSlotNames[f95_arg4] ) do
		f95_local3( f95_local8.name )
	end
	f95_local4 = function ( f97_arg0, f97_arg1 )
		if f95_arg4 == Enum[@"emodes"][@"mode_multiplayer"] then
			f95_local1 = f95_local1 + Engine[@"getitemallocationcost"]( f97_arg0, f97_arg1, f95_arg4 )
		end
	end
	
	f95_local5 = function ( f98_arg0, f98_arg1, f98_arg2 )
		local f98_local0 = f95_arg2[f98_arg0]
		if not f98_local0 then
			return 
		end
		local f98_local1 = f98_local0.itemIndex:get()
		local f98_local2 = Engine[@"hash_1E8B1E317B9DD6FE"]( f98_local1, f98_arg1, f95_arg4 ) or f98_local1
		local f98_local3 = false
		if f98_local1 > CoD.CACUtility.EmptyItemIndex then
			local f98_local4 = Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( f98_local1, f98_arg1, f95_arg4 ) )
			local f98_local5 = Engine[@"hash_1B59BB374490E3AD"]( f98_local1, f98_arg1, f95_arg4 )
			local f98_local6 = Engine[@"getitemimage"]( f98_local1, f98_arg1, f95_arg4 )
			local f98_local7 = CoD.CACUtility.GetUnlockableItemInfoField( f98_local2, f95_arg4, "previewImageLarge" )
			local f98_local8 = Engine[@"hash_7B98952F69D937F9"]( f98_local1, f98_arg1, f95_arg4 )
			local f98_local9 = f95_arg2[f98_arg0].weaponModelSlot
			local f98_local10 = false
			local f98_local11 = 0x0
			local f98_local12 = 0
			if f98_local9 and f98_local8 then
				local f98_local13 = {
					_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f95_arg0, f95_arg4 ),
					_sessionMode = f95_arg4
				}
				local f98_local14 = CoD.BreadcrumbUtility.GetAccessoryNewCountForWeapon( f98_local13, f95_arg0, f98_local8 ) + CoD.BreadcrumbUtility.GetDeathFxNewCountForWeapon( f98_local13, f95_arg0, f98_local8 ) + CoD.BreadcrumbUtility.GetTotalCamoNewCountForWeapon( f98_local13, f95_arg0, f98_local8 )
				local f98_local15 = f98_local0:create( "breadcrumbCount" )
				f98_local15:set( f98_local14 )
				f98_local15 = f98_local9:get()
				if f98_local15 > 0 then
					local f98_local16 = Engine[@"hash_79F0BB7D52A7A978"]( f98_local8 )
					local f98_local17 = f98_local16[f98_local15 + 1]
					if f98_local17 then
						if f98_local17[@"hash_5C2AA73D9F82E9C2"] and f98_local17[@"ismark2"] then
							if f98_local17[@"displayname"] then
								f98_local4 = Engine[@"hash_4F9F1239CFD921FE"]( f98_local17[@"displayname"] ) or f98_local4
							end
						else
							f98_local4 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_341954FC612B5845", f98_local4 )
							f98_local10 = true
							f98_local11 = f98_local17[@"displayname"] or 0x0
						end
						if f95_arg4 ~= Enum[@"emodes"][@"mode_zombies"] then
							f98_local6 = f98_local17[@"imageref"] or f98_local6
							f98_local7 = f98_local17[@"image"] or f98_local7
						end
					end
				end
			end
			CoD.CACUtility.GetUnlockableItemInfoField( f98_local2, f95_arg4, "previewImageLarge" )
			local f98_local18 = f98_local0:create( "name" )
			f98_local18:set( f98_local4 )
			f98_local18 = f98_local0:create( "signatureVariantName" )
			f98_local18:set( f98_local11 )
			f98_local18 = f98_local0:create( "displayNameShort" )
			f98_local18:set( f98_local5 )
			f98_local18 = f98_local0:create( "image" )
			f98_local18:set( f98_local6 )
			f98_local18 = f98_local0:create( "imageLarge" )
			f98_local18:set( f98_local7 )
			f98_local18 = f98_local0:create( "detailedDesc" )
			f98_local18:set( Engine[@"getitemdesc"]( f98_local1, f98_arg1, f95_arg4 ) )
			f98_local18 = f98_local0:create( "unequipSound" )
			f98_local18:set( CoD.CACUtility.GetUnlockableItemInfoField( f98_local2, f95_arg4, @"unequipsound", 0x0 ) )
			if CoD.isPC and f95_arg4 == Enum[@"emodes"][@"mode_multiplayer"] then
				f98_local18 = f98_local0:create( "tooltipArchetype" )
				f98_local18:set( CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE )
			end
			if f98_arg0 == "primary" or f98_arg0 == "secondary" then
				f98_local18 = f98_local0:create( "variantList" )
				f98_local18:set( CoD.CACUtility.VariantWeaponLoadoutListPrepareHelper( f95_arg0, f95_arg2, f98_arg0, f95_arg1, f95_arg4, f98_local1, true ) )
				f98_local18 = f98_local0:create( "isMastercraft" )
				f98_local18:set( f98_local10 )
				if f95_arg4 == Enum[@"emodes"][@"mode_zombies"] then
					f98_local12 = CoD.ZMLoadoutUtility.GetArmoryCharmItemFromWeapon( f95_arg0, f98_local1 )
				elseif f95_arg4 == Enum[@"emodes"][@"mode_multiplayer"] then
					f98_local12 = CoD.CACUtility.GetClassItem( f95_arg0, f95_arg1, f98_arg0 .. "." .. CoD.CACUtility.WeaponCharmAttachment.pathName, f95_arg4 )
				end
				f98_local18 = f98_local0:create( "charmIndex" )
				f98_local18:set( f98_local12 )
			end
		else
			if not f98_arg2 then
				f98_arg2 = @"menu/empty"
			end
			local f98_local4 = f98_local0:create( "name" )
			f98_local4:set( Engine[@"hash_4F9F1239CFD921FE"]( f98_arg2 ) )
			f98_local4 = f98_local0:create( "signatureVariantName" )
			f98_local4:set( 0x0 )
			f98_local4 = f98_local0:create( "displayNameShort" )
			f98_local4:set( 0x0 )
			f98_local4 = f98_local0:create( "image" )
			f98_local4:set( @"blacktransparent" )
			f98_local4 = f98_local0:create( "imageLarge" )
			f98_local4:set( RegisterImage( @"blacktransparent" ) )
			f98_local4 = f98_local0:create( "detailedDesc" )
			f98_local4:set( 0x0 )
			f98_local4 = f98_local0:create( "unequipSound" )
			f98_local4:set( 0x0 )
			if f98_arg0 == "primary" or f98_arg0 == "secondary" then
				f98_local4 = f98_local0:create( "variantList" )
				f98_local4:set( CoD.CACUtility.VariantWeaponLoadoutListPrepareHelper( f95_arg0, f95_arg2, f98_arg0, f95_arg1, f95_arg4, f98_local1, true ) )
				f98_local4 = f98_local0:create( "isMastercraft" )
				f98_local4:set( false )
				f98_local4 = f98_local0:create( "charmIndex" )
				f98_local4:set( 0 )
			end
		end
		local f98_local4 = f98_local0:create( "ref" )
		f98_local4:set( Engine[@"getitemref"]( f98_local1, f98_arg1, f95_arg4 ) )
		f98_local4 = f98_local0:create( "refHash" )
		f98_local4:set( Engine[@"hash_7B98952F69D937F9"]( f98_local1, f98_arg1, f95_arg4 ) )
		f98_local4 = f98_local0:create( "weaponSlot" )
		f98_local4:set( f98_arg0 )
		if f95_arg4 == Enum[@"emodes"][@"mode_multiplayer"] then
			f98_local3 = CoD.CACUtility.IsItemIndexRestricted( f98_local2 )
		elseif f95_arg4 == Enum[@"emodes"][@"mode_zombies"] then
			if f98_arg1 == Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"] then
				f98_local3 = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f98_local0.refHash:get()], false )
			elseif f98_arg1 == Enum[@"statindexoffset"][@"hash_15544C104CD15F10"] then
				f98_local4 = CoD.CACUtility.GetUnlockableItemInfo( f98_local2, f95_arg4 )
				f98_local3 = CoD.CACUtility.AreTalismanGameSettingsRestricted( CoD.ZMTalismanUtility.TalismanToBooleanGameSettingsHash[f98_local0.refHash:get()], f98_local4[@"talismanrarity"], false ) or CoD.CACUtility.AreGameSettingsStateOff( CoD.ZMTalismanUtility.TalismanToEnumGameSettingsHash[f98_local0.refHash:get()], false )
			elseif f98_arg0 == "herogadget" then
				f98_local3 = CoD.CACUtility.AreSpecialWeaponsRestricted( false )
			elseif f98_arg0 == "primarygrenade" then
				f98_local3 = CoD.CACUtility.AreEquipmentsRestricted( false )
			elseif f98_arg0 == "primary" then
				f98_local4 = CoD.CACUtility.GetUnlockableItemInfo( f98_local2, f95_arg4 )
				f98_local3 = CoD.CACUtility.IsItemGroupRestricted( f98_local4.itemGroupIndex, false )
			end
		end
		f98_local4 = f98_local0:create( "isRestricted" )
		f98_local4:set( f98_local3 )
		if f98_local3 then
			f98_local4 = f95_arg2:create( "tabHasRestrictions" )
			f98_local4:set( true )
		end
		f98_local4 = f98_local0:create( "bonuscardModifier" )
		f98_local4:set( CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot( f98_arg0, "modifiedSlotEnum" ) )
		f95_local4( f98_local1, f98_arg1 )
	end
	
	f95_local5( "primary", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"] )
	f95_local5( "secondary", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"] )
	f95_local6 = function ( f99_arg0 )
		local f99_local0 = f95_arg2[f99_arg0].itemIndex:get()
		local f99_local1 = f95_local0[f99_arg0]
		local f99_local2 = function ( f100_arg0 )
			local f100_local0 = f95_arg2[f99_arg0]:create( f100_arg0 )
			for f100_local1 = 1, #f99_local1[f100_arg0], 1 do
				local f100_local4 = f99_local1[f100_arg0][f100_local1 - 1]:get()
				local f100_local5 = f100_local0:create( "" .. f100_local1 )
				local f100_local6 = f99_arg0 .. "." .. f100_arg0 .. "." .. f100_local1
				local f100_local7 = Engine[@"getitemattachment"]( f99_local0, f100_local4, f95_arg4 )
				local f100_local8
				if f100_local7 > CoD.CACUtility.EmptyItemIndex then
					f100_local8 = Engine[@"hash_61F444BD03EB910E"]( f99_local0, f100_local7, f95_arg4 )
				else
					f100_local8 = false
				end
				local f100_local9 = f100_local5:create( "itemIndex" )
				f100_local9:set( f100_local4 )
				f100_local9 = f100_local5:create( "weaponIndex" )
				f100_local9:set( f99_local0 )
				f100_local9 = f100_local5:create( "attachmentIndex" )
				f100_local9:set( f100_local7 )
				if f100_local7 > CoD.CACUtility.EmptyItemIndex then
					f100_local9 = f100_local5:create( "image" )
					f100_local9:set( Engine[@"getattachmentuniqueimagebyindex"]( f99_local0, f100_local4, f95_arg4 ) )
					f100_local9 = f100_local5:create( "name" )
					f100_local9:set( Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getattachmentname"]( f99_local0, f100_local4, f95_arg4 ) ) )
					f100_local9 = f100_local5:create( "displayNameShort" )
					f100_local9:set( Engine[@"getattachmentnameshort"]( f99_local0, f100_local4, f95_arg4 ) )
					f100_local9 = f100_local5:create( "detailedDesc" )
					f100_local9:set( Engine[@"getattachmentdescbyattachmentindex"]( f100_local7, f95_arg4 ) )
				else
					f100_local9 = f100_local5:create( "image" )
					f100_local9:set( @"blacktransparent" )
					f100_local9 = f100_local5:create( "name" )
					f100_local9:set( "" )
					f100_local9 = f100_local5:create( "displayNameShort" )
					f100_local9:set( 0x0 )
					f100_local9 = f100_local5:create( "detailedDesc" )
					f100_local9:set( 0x0 )
				end
				f100_local9 = Engine[@"getattachmentrefbyindex"]( f100_local7 )
				local f100_local10 = f100_local5:create( "ref" )
				f100_local10:set( f100_local9 )
				f100_local10 = f100_local5:create( "weaponSlot" )
				f100_local10:set( f100_local6 )
				f100_local10 = @"hash_220862A4CA76A9E2"
				if f100_local8 and f100_local8.unequipSound ~= 0x0 then
					f100_local10 = f100_local8.unequipSound
				end
				local f100_local11 = f100_local5:create( "unequipSound" )
				f100_local11:set( f100_local10 )
				f95_local1 = f95_local1 + Engine[@"getattachmentallocationcost"]( f100_local7 )
			end
		end
		
		f99_local2( "attachment" )
	end
	
	f95_local6( "primary" )
	f95_local6( "secondary" )
	f95_local7 = f95_arg2:create( "primaryattachments" )
	f95_local7:set( CoD.CACUtility.AttachmentLoadoutListPrepareHelper( f95_arg0, f95_arg2, "primary", f95_arg1, f95_arg4 ) )
	f95_local7 = f95_arg2:create( "secondaryattachments" )
	f95_local7:set( CoD.CACUtility.AttachmentLoadoutListPrepareHelper( f95_arg0, f95_arg2, "secondary", f95_arg1, f95_arg4 ) )
	f95_local5( "primarygrenade", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], 0x0 )
	f95_local5( "tacticalgear", Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"], 0x0 )
	if f95_arg4 == Enum[@"emodes"][@"mode_zombies"] then
		f95_local5( "herogadget", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"] )
		for f95_local10, f95_local11 in ipairs( CoD.ZMPerkUtility.PerkSlotNameList ) do
			f95_local5( f95_local11, Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"] )
		end
		for f95_local10, f95_local11 in ipairs( CoD.CACUtility.TalismanSlotNameList ) do
			f95_local5( f95_local11, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"] )
		end
		f95_local7 = Engine[@"getmodelforcontroller"]( f95_arg0 )
		CoD.ZMLoadoutUtility.SetupBGBLoadout( f95_local7:create( "BGBLoadout" ), f95_arg0, f95_arg1, f95_arg2 )
	end
	if f95_arg4 == Enum[@"emodes"][@"mode_multiplayer"] then
		f95_local7 = f95_arg2.primarygrenade
		f95_local8 = f95_local7.itemIndex:get()
		local f95_local9 = f95_arg2.primarygrenadecount
		local f95_local10 = f95_local9:create( "weaponSlot" )
		f95_local10:set( "primarygrenadecount" )
		f95_local10 = false
		if CoD.CACUtility.EmptyItemIndex < f95_local8 then
			local f95_local11 = Engine[@"getunlockableitemkvpinfo"]( f95_local8, f95_arg4 )
			if f95_local11 then
				f95_local10 = f95_local11[@"hash_1B451B56A0EE77E5"] == 1
			end
		end
		local f95_local11 = f95_arg2:create( "canTakeTwo" )
		f95_local11:set( f95_local10 )
		if CoD.CACUtility.EmptyItemIndex < f95_local9.itemIndex:get() then
			f95_local11 = f95_local9:create( "name" )
			f95_local11:set( Engine[@"hash_4F9F1239CFD921FE"]( f95_local7.name:get() ) )
			f95_local11 = f95_local9:create( "image" )
			f95_local11:set( f95_local7.image:get() )
			f95_local11 = f95_local9:create( "imageLarge" )
			f95_local11:set( f95_local7.imageLarge:get() )
			f95_local11 = f95_local9:create( "detailedDesc" )
			f95_local11:set( f95_local7.detailedDesc:get() )
			f95_local11 = f95_local9:create( "ref" )
			f95_local11:set( f95_local7.refHash:get() )
			f95_local11 = f95_local9:create( "unequipSound" )
			f95_local11:set( f95_local7.unequipSound:get() )
			f95_local11 = f95_local9:create( "isRestricted" )
			f95_local11:set( f95_local7.isRestricted:get() )
			if CoD.isPC then
				f95_local11 = f95_local9:create( "tooltipArchetype" )
				f95_local11:set( CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE )
			end
			f95_local1 = f95_local1 + 1
		else
			f95_local11 = f95_local9:create( "name" )
			f95_local11:set( "" )
			f95_local11 = f95_local9:create( "image" )
			f95_local11:set( @"blacktransparent" )
			f95_local11 = f95_local9:create( "imageLarge" )
			f95_local11:set( RegisterImage( @"blacktransparent" ) )
			f95_local11 = f95_local9:create( "detailedDesc" )
			f95_local11:set( 0x0 )
			f95_local11 = f95_local9:create( "ref" )
			f95_local11:set( 0x0 )
			f95_local11 = f95_local9:create( "unequipSound" )
			f95_local11:set( 0x0 )
			f95_local11 = f95_local9:create( "isRestricted" )
			f95_local11:set( false )
			if CoD.isPC then
				f95_local11 = f95_local9:create( "tooltipArchetype" )
				f95_local11:set( CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT )
			end
		end
		for f95_local14, f95_local15 in ipairs( CoD.CACUtility.TalentSlotNameList ) do
			f95_local5( f95_local15, Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"], 0x0 )
		end
		f95_local11 = f95_arg2:create( "talents" )
		f95_local11:set( CoD.CACUtility.TalentsLoadoutListPrepareHelper( f95_arg0, f95_arg2, "talent", f95_arg1, f95_arg4 ) )
		f95_local11 = f95_arg2:create( "talentsMiniPreview" )
		f95_local11:set( CoD.CACUtility.TalentsLoadoutListPrepareHelper( f95_arg0, f95_arg2, "talentMiniPreview", f95_arg1, f95_arg4 ) )
		for f95_local14, f95_local15 in ipairs( CoD.CACUtility.BonuscardSlotNameList ) do
			f95_local5( f95_local15, Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], 0x0 )
		end
		f95_local11 = f95_arg2:create( "bonuscards" )
		f95_local11:set( CoD.CACUtility.BonuscardsLoadoutListPrepareHelper( f95_arg0, f95_arg2, f95_arg1, f95_arg4 ) )
		f95_local11 = f95_arg2.primary:create( "numGunfightersEquipped" )
		f95_local11:set( CoD.BonuscardUtility.SpecificGunfighterEquippedCount( f95_arg2, CoD.BonuscardUtility.PrimaryGunfighterWildcards, f95_arg4 ) )
		f95_local11 = f95_arg2.secondary:create( "numGunfightersEquipped" )
		f95_local11:set( CoD.BonuscardUtility.SpecificGunfighterEquippedCount( f95_arg2, CoD.BonuscardUtility.SecondaryGunfighterWildcards, f95_arg4 ) )
		f95_local11 = f95_arg2:create( "talent1Header" )
		f95_local11:set( Engine[@"hash_4F9F1239CFD921FE"]( @"mpui/perk1" ) )
		f95_local11 = f95_arg2:create( "talent2Header" )
		f95_local11:set( Engine[@"hash_4F9F1239CFD921FE"]( @"mpui/perk2" ) )
		f95_local11 = f95_arg2:create( "talent3Header" )
		f95_local11:set( Engine[@"hash_4F9F1239CFD921FE"]( @"mpui/perk3" ) )
		f95_local11 = CoD.BonuscardUtility.GetTalentInfoForEquippedGluttony( f95_arg2, f95_arg4 )
		if f95_local11 then
			f95_local12 = CoD.BonuscardUtility.GetSlotWithEquippedBonuscard( f95_arg2, f95_local11.refHash, f95_arg4 )
			if f95_local12 then
				f95_local13 = f95_arg2[f95_local12].name:get()
				f95_local14 = f95_arg2:create( "talent1Header" )
				f95_local14:set( f95_local13 )
				f95_local14 = f95_arg2:create( "talent2Header" )
				f95_local14:set( "" )
				f95_local14 = f95_arg2:create( "talent3Header" )
				f95_local14:set( "" )
			end
		end
	end
	f95_local7 = f95_arg2:create( "allocationSpent" )
	f95_local7:set( f95_local1 )
	if not f95_arg2.tempLargeImageForModel then
		f95_local7 = f95_arg2:create( "tempLargeImageForModel" )
		f95_local7:set( RegisterImage( @"blacktransparent" ) )
	end
	if not f95_arg2.showSpecialistEquipmentWidgetModel then
		f95_local7 = f95_arg2:create( "showSpecialistEquipmentWidgetModel" )
		f95_local7:set( false )
	end
	if not f95_arg2.isRestricted then
		f95_local7 = f95_arg2:create( "isRestricted" )
		f95_local7:set( false )
	end
	for f95_local10, f95_local11 in ipairs( CoDLoadoutsShared.loadoutSlotNames[f95_arg4] ) do
		local f95_local12 = f95_arg2[f95_local11.name]
		if f95_local12 then
			local f95_local13 = f95_local12:create( "hintText" )
			if f95_local13 then
				local f95_local14, f95_local15, f95_local16, f95_local17 = CoD.CACUtility.GetCACSlotStatus( f95_arg0, f95_arg2, f95_local11.name, f95_arg4 )
				if not f95_local16 or f95_local16 == 0x0 then
					f95_local13:set( "" )
				end
				if f95_local17 ~= nil then
					f95_local13:set( Engine[@"localize"]( f95_local16, f95_local17 ) )
				else
					f95_local13:set( Engine[@"localize"]( f95_local16 ) )
				end
			end
		end
	end
	Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f95_arg2, "disabled" ), CoD.BlackMarketUtility.ClassContainsLockedItems( f95_arg0, f95_arg2 ) )
end
CoD.CACUtility.AttachmentLoadoutListPrepareHelper = function ( f101_arg0, f101_arg1, f101_arg2, f101_arg3, f101_arg4 )
	local f101_local0 = "CACAttachmentSlot_" .. f101_arg0 .. "_" .. f101_arg2 .. "_" .. f101_arg3
	DataSources[f101_local0] = DataSourceHelpers.ListSetup( f101_local0, function ( f102_arg0, f102_arg1 )
		local f102_local0 = {}
		local f102_local1 = f101_arg1[f101_arg2].itemIndex:get()
		local f102_local2 = CoD.CACUtility.DoesUnlockableItemHaveAnyAttachments( f102_local1, f101_arg4 )
		local f102_local3 = CoD.CACUtility.GetAttachmentListForSlot( f101_arg2 )
		local f102_local4 = Engine[@"getunlockableitemkvpinfo"]( f102_local1, f101_arg4 )
		local f102_local5 = CoD.CACUtility.maxAttachments[f101_arg2]
		if not f102_local5 then
			f102_local5 = CoD.CACUtility.maxPrimaryAttachments
		end
		if f101_arg1 then
			for f102_local6 = 1, f102_local5, 1 do
				local f102_local9 = f102_local3[f102_local6]
				local f102_local10 = f101_arg1[f102_local9]
				local f102_local11 = f102_local10.ref and f102_local10.ref:get() or "none"
				local f102_local12 = CoD.BonuscardUtility.NumBonucardsNeededForAttachmentTable[f102_local9] or 0
				local f102_local13
				if f102_local6 == CoD.CACUtility.UberIndexSlot then
					f102_local13 = CoD.BonuscardUtility.IsOperatorModBonuscardEquipped( f101_arg1, f101_arg2, f101_arg4 )
				else
					f102_local13 = false
				end
				local f102_local14, f102_local15 = nil
				if f102_local13 then
					f102_local14 = CoD.AttachmentUberLoadoutClassListItem
				end
				local f102_local16, f102_local17, f102_local18, f102_local19 = CoD.CACUtility.GetCACSlotStatus( f102_arg0, f101_arg1, f102_local9, f101_arg4 )
				local f102_local20 = ""
				if f102_local18 then
					f102_local20 = Engine[@"hash_4F9F1239CFD921FE"]( f102_local18 )
				end
				local f102_local21 = Engine[@"hash_793ABA160B5D7323"]( f102_local1, Engine[@"getattachmentindexbyref"]( f102_local11 ), false )
				local f102_local22 = {}
				local f102_local23 = {
					loadoutListItem = f102_local10,
					loadoutSlot = f102_local9,
					attachmentSlotIndex = f102_local6,
					baseWeaponSlotModel = f101_arg1[f101_arg2],
					isAttachmentSlotAvailable = f102_local2,
					bonuscardNeeded = CoD.BonuscardUtility.BonuscardNeededForAttachmentSlot[f102_local9] or @"hash_0",
					numBonuscardNeeded = f102_local12,
					isUberAttachmentSlot = f102_local13,
					tierType = CoD.WeaponAttachmentsUtility.GetAttachmentTierType( f102_local4, f102_local11 ),
					bonuscardModifier = CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot( f102_local9, "modifiedSlotEnum" ),
					ref = f102_local11,
					hintText = f102_local20
				}
				local f102_local24
				if CoD.isPC and f101_arg4 == Enum[@"emodes"][@"mode_multiplayer"] and f102_local17 then
					f102_local24 = CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE
					if not f102_local24 then
					
					else
						f102_local23.tooltipArchetype = f102_local24
						if CoD.isPC and f102_local17 then
							local f102_local25 = f102_local18
						end
						f102_local23.freeCursorTitle = f102_local25 or nil
						f102_local23.isRestricted = f102_local21
						f102_local22.models = f102_local23
						f102_local22.properties = {
							customWidgetOverride = f102_local14
						}
						table.insert( f102_local0, f102_local22 )
					end
				end
				f102_local24 = CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT
			end
		end
		if f102_arg1.weaponChangedSubscription then
			f102_arg1:removeSubscription( f102_arg1.weaponChangedSubscription )
		end
		f102_arg1.weaponChangedSubscription = f102_arg1:subscribeToModel( f101_arg1[f101_arg2].itemIndex, function ()
			f102_arg1:updateDataSource( true, true )
		end, false )
		if f102_arg1.equippedItemsChanged then
			f102_arg1:removeSubscription( f102_arg1.equippedItemsChanged )
		end
		local f102_local7 = f102_arg1
		local f102_local6 = f102_arg1.subscribeToModel
		local f102_local8 = Engine[@"getmodelforcontroller"]( f102_arg0 )
		f102_arg1.equippedItemsChanged = f102_local6( f102_local7, f102_local8["CustomClassList.equippedItemsChanged"], function ()
			f102_arg1:updateDataSource( false, true )
		end, false )
		return f102_local0
	end )
	return f101_local0
end
CoD.CACUtility.TalentsLoadoutListPrepareHelper = function ( f105_arg0, f105_arg1, f105_arg2, f105_arg3, f105_arg4 )
	local f105_local0 = "CACTalentLoadout_" .. f105_arg0 .. "_" .. f105_arg2 .. "_" .. f105_arg3
	DataSources[f105_local0] = DataSourceHelpers.ListSetup( f105_local0, function ( f106_arg0, f106_arg1 )
		local f106_local0 = {}
		if f105_arg1 then
			for f106_local16, f106_local17 in ipairs( CoD.CACUtility.TalentSlotNameList ) do
				local f106_local18 = f105_arg1[f106_local17]
				if not f106_arg1._ignoreEmptyPerks or f106_local18 and f106_local18.itemIndex and f106_local18.itemIndex:get() ~= CoD.CACUtility.EmptyItemIndex then
					local f106_local4 = f105_arg2 .. f106_local16 - 1 % CoD.CACUtility.maxPerkCategories + 1
					local f106_local5 = f106_local16 <= 3
					local f106_local6, f106_local7, f106_local8, f106_local9 = CoD.CACUtility.GetCACSlotStatus( f106_arg0, f105_arg1, f106_local17, f105_arg4 )
					local f106_local10 = ""
					if f106_local8 then
						f106_local10 = Engine[@"hash_4F9F1239CFD921FE"]( f106_local8 )
					end
					local f106_local11 = Engine[@"hash_1E8B1E317B9DD6FE"]( f106_local18.itemIndex:get(), CoD.CACUtility.GetStatIndexOffsetForLoadoutSlot( f106_local17, f105_arg4 ), f105_arg4 )
					if not f106_local11 then
						f106_local11 = CoD.CACUtility.EmptyItemIndex
					end
					local f106_local12 = {}
					local f106_local13 = {
						loadoutListItem = f106_local18,
						loadoutSlot = f106_local17,
						talentFilter = f106_local4,
						isTalentSlotAvailable = f106_local5,
						bonuscardNeeded = CoD.BonuscardUtility.BonuscardNeededForTalentSlot[f106_local17] or @"hash_0",
						bonuscardModifier = CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot( f106_local17, "modifiedSlotEnum" ),
						hintText = f106_local10
					}
					local f106_local14
					if CoD.isPC and f105_arg4 == Enum[@"emodes"][@"mode_multiplayer"] and f106_local7 then
						f106_local14 = CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE
						if not f106_local14 then
						
						else
							f106_local13.tooltipArchetype = f106_local14
							if CoD.isPC and f105_arg4 == Enum[@"emodes"][@"mode_multiplayer"] and f106_local7 then
								local f106_local15 = f106_local8
							end
							f106_local13.freeCursorTitle = f106_local15 or nil
							f106_local13.isRestricted = CoD.CACUtility.IsItemIndexRestricted( f106_local11 )
							f106_local12.models = f106_local13
							table.insert( f106_local0, f106_local12 )
						end
					end
					f106_local14 = CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT
				end
			end
		end
		if f106_arg1.equippedItemsChanged then
			f106_arg1:removeSubscription( f106_arg1.equippedItemsChanged )
		end
		local f106_local2 = f106_arg1
		local f106_local1 = f106_arg1.subscribeToModel
		local f106_local3 = Engine[@"getmodelforcontroller"]( f106_arg0 )
		f106_arg1.equippedItemsChanged = f106_local1( f106_local2, f106_local3["CustomClassList.equippedItemsChanged"], function ()
			f106_arg1:updateDataSource( true, true )
		end, false )
		return f106_local0
	end )
	return f105_local0
end
CoD.CACUtility.BonuscardsLoadoutListPrepareHelper = function ( f108_arg0, f108_arg1, f108_arg2, f108_arg3 )
	local f108_local0 = "CACBonuscardLoadout_" .. f108_arg0 .. "_" .. "bonuscard" .. "_" .. f108_arg2
	DataSources[f108_local0] = DataSourceHelpers.ListSetup( f108_local0, function ( f109_arg0, f109_arg1 )
		local f109_local0 = {}
		if f108_arg1 then
			for f109_local10, f109_local11 in ipairs( CoD.CACUtility.BonuscardSlotNameList ) do
				local f109_local12 = f108_arg1[f109_local11]
				local f109_local13, f109_local14, f109_local15, f109_local16 = CoD.CACUtility.GetCACSlotStatus( f109_arg0, f108_arg1, f109_local11, f108_arg3 )
				local f109_local4 = ""
				if f109_local15 then
					f109_local4 = Engine[@"hash_4F9F1239CFD921FE"]( f109_local15 )
				end
				local f109_local5 = Engine[@"hash_1E8B1E317B9DD6FE"]( f109_local12.itemIndex:get(), CoD.CACUtility.GetStatIndexOffsetForLoadoutSlot( f109_local11, f108_arg3 ), f108_arg3 )
				if not f109_local5 then
					f109_local5 = CoD.CACUtility.EmptyItemIndex
				end
				local f109_local6 = {}
				local f109_local7 = {
					loadoutListItem = f109_local12,
					loadoutSlot = f109_local11,
					hintText = f109_local4
				}
				local f109_local8
				if CoD.isPC and f108_arg3 == Enum[@"emodes"][@"mode_multiplayer"] and f109_local14 then
					f109_local8 = CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE
					if not f109_local8 then
					
					else
						f109_local7.tooltipArchetype = f109_local8
						if CoD.isPC and f108_arg3 == Enum[@"emodes"][@"mode_multiplayer"] and f109_local14 then
							local f109_local9 = f109_local15
						end
						f109_local7.freeCursorTitle = f109_local9 or nil
						f109_local7.isRestricted = CoD.CACUtility.IsItemIndexRestricted( f109_local5 )
						f109_local6.models = f109_local7
						table.insert( f109_local0, f109_local6 )
					end
				end
				f109_local8 = CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT
			end
		end
		if f109_arg1.equippedItemsChanged then
			f109_arg1:removeSubscription( f109_arg1.equippedItemsChanged )
		end
		local f109_local2 = f109_arg1
		local f109_local1 = f109_arg1.subscribeToModel
		local f109_local3 = Engine[@"getmodelforcontroller"]( f109_arg0 )
		f109_arg1.equippedItemsChanged = f109_local1( f109_local2, f109_local3["CustomClassList.equippedItemsChanged"], function ()
			f109_arg1:updateDataSource( true, true )
		end, false )
		return f109_local0
	end )
	return f108_local0
end
CoD.CACUtility.GetSignatureWeaponsListInternal = function ( f111_arg0, f111_arg1, f111_arg2, f111_arg3, f111_arg4, f111_arg5, f111_arg6, f111_arg7, f111_arg8 )
	local f111_local0 = {}
	local f111_local1 = {}
	local f111_local2 = {}
	local f111_local3 = CoD.CACUtility.GetUnlockableItemInfo( f111_arg6, f111_arg7 )
	local f111_local4 = f111_local3 and f111_local3.nameHash
	if f111_local4 and CoD.CACUtility.EmptyItemIndex < f111_arg6 then
		for f111_local25, f111_local26 in CoD.CACUtility.ForAvailableSignatureWeapons( f111_arg0, f111_local4, not IsCurrentMenu( f111_arg2, "PaintjobWeaponSelect" ) ) do
			local f111_local8 = Engine[@"hash_4F9F1239CFD921FE"]( f111_local26[@"displayname"] )
			local f111_local10 = f111_local26[@"image"]
			local f111_local11 = f111_local26[@"image"]
			local f111_local27 = f111_local26[@"hash_5C2AA73D9F82E9C2"]
			local f111_local28 = f111_local26[@"ismark2"]
			local f111_local9 = f111_local3.displayName
			local f111_local12 = CoD.BlackMarketTableUtility.LootInfoLookup( f111_arg0, f111_local26[@"lootid"] )
			local f111_local14 = 0x0
			local f111_local15 = false
			local f111_local20 = 0x0
			local f111_local21 = 0x0
			local f111_local29 = "theme"
			local f111_local13 = 0x0
			local f111_local22 = 0
			if f111_local26[@"index"] == 0 then
				f111_local8 = Engine[@"hash_4F9F1239CFD921FE"]( f111_local3.displayName )
				f111_local9 = 0x0
				f111_local10 = f111_local3.previewImage
				f111_local11 = f111_local3.previewImage
				f111_local12 = CoD.BlackMarketTableUtility.LootInfoLookup( f111_arg0, f111_local4 )
			elseif not f111_local27 or not f111_local28 then
				f111_local8 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_341954FC612B5845", Engine[@"hash_4F9F1239CFD921FE"]( f111_local3.displayName ) )
				f111_local13 = f111_local26[@"displayname"]
				f111_local14 = @"hash_DFBA506E7EAFCB9"
				f111_local15 = true
				local f111_local16 = Engine[@"tablefindrows"]( CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2BE9816FAD8AD2D2"], f111_local29, Enum[@"attachmenttablecolumn_e"][@"hash_9A2FFE632B9ED93"], f111_local4 )
				if f111_local16 and #f111_local16 > 0 then
					for f111_local23, f111_local24 in ipairs( f111_local16 ) do
						if tonumber( Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, f111_local24, Enum[@"attachmenttablecolumn_e"][@"hash_726CA7CCFF2886B5"] ) ) == f111_local26[@"index"] then
							f111_local20 = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, f111_local24, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"] )
							f111_local21 = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, f111_local24, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"] )
							f111_local22 = CoD.CACUtility.AdjustCamoIfSignatureCamo( f111_arg0, Engine[@"tablelookup"]( CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f111_local20 ) )
							break
						end
					end
				end
			end
			if f111_arg7 == Enum[@"emodes"][@"mode_zombies"] then
				if f111_local3.zmPreviewImage then
					f111_local11 = f111_local3.zmPreviewImage
					f111_local10 = f111_local3.zmPreviewImage
				end
				if f111_local26[@"imagezm"] and f111_local27 then
					f111_local11 = f111_local26[@"imagezm"]
				end
			end
			local f111_local16 = {}
			if f111_arg8 then
				local f111_local17 = {
					displayName = f111_local8,
					name = f111_local8,
					itemIndex = f111_arg6,
					previewImage = f111_local10,
					image = f111_local21,
					displayImage = f111_local11,
					weaponModelSlotIndex = f111_local26[@"index"],
					isBaseSignatureWeapon = f111_local27,
					lootID = f111_local26[@"lootid"]
				}
				local f111_local18 = {
					owned = f111_local12.owned,
					hideRarity = false
				}
				local f111_local19 = CoD.BlackMarketUtility.LootIdRarities[f111_local12.rarity]
				if not f111_local19 then
					f111_local19 = Enum[@"lootraritytype"][@"loot_rarity_type_count"]
				end
				f111_local18.rarity = f111_local19
				f111_local18.unlockInfo = f111_local12.unlockInfo or ""
				f111_local18.isLoot = f111_local12.isLoot
				f111_local17.lootData = f111_local18
				if f111_local12.isLoot then
					f111_local18 = f111_local12.owned
				else
					f111_local18 = true
				end
				f111_local17.owned = f111_local18
				f111_local17.baseWeaponName = f111_local9
				f111_local17.weaponNameHash = f111_local4
				f111_local17.selected = false
				f111_local17.loadoutSlot = f111_arg5
				f111_local17.isMark2 = f111_local28
				f111_local17.description = f111_local14
				f111_local17.isMastercraft = f111_local15
				f111_local17.ref = f111_local20
				f111_local17.weaponOptionCategory = f111_local29
				f111_local17.signatureWeaponModelSlot = f111_local26[@"index"]
				f111_local17.signatureVariantName = f111_local13
				f111_local17.weaponOptionSubIndex = f111_local22
				f111_local16 = f111_local17
			else
				local f111_local17 = {
					displayName = f111_local8,
					weaponModelSlotIndex = f111_local26[@"index"],
					isMark2 = f111_local28,
					selected = false
				}
				local f111_local18
				if f111_local12.isLoot then
					f111_local18 = f111_local12.owned
				else
					f111_local18 = true
				end
				f111_local17.owned = f111_local18
				f111_local16 = f111_local17
			end
			local f111_local17 = {
				equipSound = f111_local3[@"equipsound"],
				unequipSound = f111_local3[@"unequipsound"],
				selectIndex = false
			}
			if f111_arg7 == Enum[@"emodes"][@"mode_multiplayer"] then
				local f111_local18 = CoD.CACUtility.GetItemIndexEquippedInSlot( f111_arg5, f111_arg0, f111_arg3 ) or 0
				if f111_local18 ~= CoD.CACUtility.EmptyItemIndex and f111_local18 == f111_arg6 and (CoD.CACUtility.GetItemWeaponModelSlotIndexEquippedInSlot( f111_arg5, f111_arg0, f111_arg3 ) or 0) == f111_local16.weaponModelSlotIndex then
					f111_local16.selected = true
				end
			end
			if f111_arg7 == Enum[@"emodes"][@"mode_zombies"] then
				f111_local16.unlockableItemModel = f111_arg4
				if f111_arg5 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
					f111_local16.unlockableItemModel = f111_arg3 and f111_arg3.primary
				end
				f111_local16.selected = CoD.ZMLoadoutUtility.GetWeaponModelSlot( f111_arg6, f111_arg0 ) == f111_local26[@"index"]
				if f111_local16.selected and f111_arg5 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
					f111_local16.selected = f111_arg6 == CoD.CACUtility.GetEquippedItemIndex( f111_arg2, f111_arg0 )
				end
				local f111_local18 = CoD.ZMLoadoutUtility.GetEquippedArmoryAttachments( f111_arg0, f111_arg6, f111_arg7 )
				f111_local17.armoryAttachmentTable = f111_local18.attachmentList
			end
			if f111_arg7 == Enum[@"emodes"][@"mode_warzone"] then
				f111_local16.unlockableItemModel = f111_arg4
				f111_local16.selected = CoD.WZUtility.GetWeaponModelSlot( f111_arg6, f111_arg0 ) == f111_local26[@"index"]
			end
			if f111_local26[@"lootid"] == 0x0 then
				table.insert( f111_local0, {
					models = f111_local16,
					properties = f111_local17
				} )
			end
			if not CoD.CACUtility.DvarHideUnlockableItem( f111_local26[@"lootid"], f111_arg7 ) then
				if f111_local16.isMark2 then
					table.insert( f111_local1, {
						models = f111_local16,
						properties = f111_local17
					} )
				else
					table.insert( f111_local2, {
						models = f111_local16,
						properties = f111_local17
					} )
				end
			end
		end
	end
	local f111_local5 = function ( f112_arg0, f112_arg1 )
		if not f112_arg0 or not f112_arg0.models or not f112_arg1 or not f112_arg1.models then
			return false
		else
			return (f112_arg0.models.weaponModelSlotIndex or 0) < (f112_arg1.models.weaponModelSlotIndex or 0)
		end
	end
	
	local f111_local6, f111_local7 = CoD.BlackMarketTableUtility.SimpleLootLookup( f111_arg0, f111_local4 )
	if f111_local6 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"] and not f111_local7 then
		f111_local0 = {}
	end
	local f111_local25 = {}
	for f111_local11, f111_local27 in ipairs( {
		f111_local0,
		f111_local1,
		f111_local2
	} ) do
		table.sort( f111_local27, f111_local5 )
		for f111_local14, f111_local15 in ipairs( f111_local27 ) do
			table.insert( f111_local25, f111_local15 )
		end
	end
	if #f111_local25 < 2 then
		f111_local25 = {}
	end
	if #f111_local25 > 0 and f111_local2 and #f111_local2 > 0 then
		f111_arg1.mastercraftWeaponModelSlots = {}
		for f111_local11, f111_local27 in ipairs( f111_local2 ) do
			table.insert( f111_arg1.mastercraftWeaponModelSlots, f111_local27.models.weaponModelSlotIndex )
		end
		for f111_local11, f111_local27 in ipairs( f111_local25 ) do
			f111_local27.properties.mastercraftWeaponModelSlots = {}
			for f111_local14, f111_local15 in ipairs( f111_local2 ) do
				table.insert( f111_local27.properties.mastercraftWeaponModelSlots, f111_local15.models.weaponModelSlotIndex )
			end
		end
	end
	f111_local26 = false
	for f111_local27, f111_local28 in ipairs( f111_local25 ) do
		if f111_local28.models.selected then
			f111_local28.properties.selectIndex = true
			f111_local26 = true
		end
	end
	if not f111_local26 and #f111_local25 > 0 then
		f111_local25[1].models.selected = true
		f111_local25[1].properties.selectIndex = true
	end
	return f111_local25
end
CoD.CACUtility.VariantWeaponLoadoutListPrepareHelper = function ( f113_arg0, f113_arg1, f113_arg2, f113_arg3, f113_arg4, f113_arg5, f113_arg6 )
	local f113_local0 = "CACVariantWeaponLoadout_" .. f113_arg0 .. "_" .. (f113_arg2 or "paintshop") .. "_" .. (f113_arg3 or 0) .. "_" .. f113_arg5
	DataSources[f113_local0] = DataSourceHelpers.ListSetup( f113_local0, function ( f114_arg0, f114_arg1 )
		local f114_local0 = {}
		local f114_local1 = f113_arg1
		if f114_local1 then
			f114_local1 = f113_arg1[f113_arg2]
		end
		for f114_local5, f114_local6 in ipairs( CoD.CACUtility.GetSignatureWeaponsListInternal( f114_arg0, f114_arg1, f114_arg1.menu, f113_arg1, f114_local1, f113_arg2, f113_arg5, f113_arg4, f113_arg6 ) ) do
			if f114_local6.models.owned then
				table.insert( f114_local0, f114_local6 )
			end
		end
		if f114_arg1.equippedItemsChanged then
			f114_arg1:removeSubscription( f114_arg1.equippedItemsChanged )
		end
		f114_local3 = f114_arg1
		f114_local2 = f114_arg1.subscribeToModel
		f114_local4 = Engine[@"getmodelforcontroller"]( f114_arg0 )
		f114_local4 = f114_local4:create( "CustomClassList" )
		f114_arg1.equippedItemsChanged = f114_local2( f114_local3, f114_local4:create( "equippedItemsChanged" ), function ()
			f114_arg1:updateDataSource( true, true )
		end, false )
		if f114_arg1.weaponPersonalizationUpdate then
			f114_arg1:removeSubscription( f114_arg1.weaponPersonalizationUpdate )
		end
		f114_local3 = f114_arg1
		f114_local2 = f114_arg1.subscribeToModel
		f114_local4 = DataSources.WeaponPersonalization.getModel( f114_arg0 )
		f114_arg1.weaponPersonalizationUpdate = f114_local2( f114_local3, f114_local4.listUpdate, function ()
			f114_arg1:updateDataSource( true, true )
		end, false )
		return f114_local0
	end )
	return f113_local0
end
CoD.CACUtility.UpdateAllClasses = function ( f117_arg0, f117_arg1 )
	local f117_local0 = CoD.CACUtility.GetCustomClassCount( f117_arg0 )
	local f117_local1 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f117_arg0 ), "CustomClassList" )
	for f117_local2 = 1, f117_local0, 1 do
		CoD.CACUtility.GetCustomClassModel( f117_arg0, f117_local2 - 1, f117_local1["class" .. f117_local2], nil, f117_arg1 )
	end
end
CoD.CACUtility.DefaultStageForActiveCamoNotInList = 1
CoD.CACUtility.BaseUnwrappedStageForActiveCamo = 2
CoD.CACUtility.MastercraftCamoStartStage = 1
CoD.CACUtility.MasteryCamoStartStage = 1
CoD.CACUtility.GetHighestPermanentlyCompletedActiveCamoStage = function ( f118_arg0, f118_arg1, f118_arg2 )
	local f118_local0 = 1
	local f118_local1 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer( f118_arg0 )
	f118_local1 = f118_local1 and f118_local1[@"playerstatslist"]
	if not f118_local1 then
		return f118_local0
	elseif f118_arg2 then
		for f118_local2 = 1, #f118_arg1.stages, 1 do
			if f118_arg1.stages[f118_local2][@"disabled"] == 1 then
				return f118_local0
			end
			f118_local0 = f118_local2
		end
		return f118_local0
	elseif Dvar.allItemsUnlocked:get() and #f118_arg1.stages >= CoD.CACUtility.BaseUnwrappedStageForActiveCamo then
		return CoD.CACUtility.BaseUnwrappedStageForActiveCamo
	end
	for f118_local6, f118_local7 in ipairs( f118_arg1.stages ) do
		local f118_local8 = f118_local7[@"permanentstatname"]
		local f118_local9 = f118_local7[@"hash_5181D2404B77545F"]
		if f118_local8 and f118_local9 then
			local f118_local5 = f118_local1[f118_local8]
			if f118_local5 then
				f118_local5 = f118_local1[f118_local8][@"challengevalue"]:get()
			end
			if f118_local5 and f118_local9 <= f118_local5 then
				f118_local0 = f118_local6 + 1
			end
		end
	end
	return f118_local0
end
CoD.CACUtility.DefaultStageForActiveCamo = {
	[@"activecamoinfo_t8_darkmatter"] = 0,
	[@"activecamoinfo_t8_diamond"] = 0,
	[@"activecamoinfo_t8_gold"] = 0,
	[@"activecamoinfo_t8_ar_accurate"] = 0,
	[@"activecamoinfo_t8_ar_fastfire"] = 0,
	[@"activecamoinfo_t8_lmg_standard"] = 0,
	[@"activecamoinfo_t8_pistol_standard"] = 0,
	[@"activecamoinfo_t8_shotgun_semiauto"] = 0,
	[@"activecamoinfo_t8_smg_accurate"] = 0,
	[@"activecamoinfo_t8_smg_standard"] = 0,
	[@"activecamoinfo_t8_sig_tr_midburst_bomber"] = 0,
	[@"activecamoinfo_t8_sig_smg_handling_hunter"] = 0,
	[@"activecamoinfo_t8_sig_sniper_powerbolt_viking"] = 0,
	[@"activecamoinfo_t8_sig_pistol_revolver_cyberpunk"] = 0,
	[@"activecamoinfo_t8_sig_ar_stealth_vampire"] = 0,
	[@"activecamoinfo_t8_sig_ar_modular_porcelain"] = 0,
	[@"activecamoinfo_t8_sig_shotgun_pump_police"] = 0,
	[@"activecamoinfo_t8_sig_smg_capacity_spaceshuttle"] = 0,
	[@"activecamoinfo_t8_sig_sniper_fastrechamber_western"] = 0,
	[@"activecamoinfo_t8_sig_tr_powersemi_rustymech"] = 0,
	[@"activecamoinfo_t8_sig_sniper_powersemi_vietnam"] = 0,
	[@"activecamoinfo_t8_sig_pistol_burst_raven"] = 0
}
CoD.CACUtility.AdjustCamoIfSignatureCamo = function ( f119_arg0, f119_arg1, f119_arg2 )
	local f119_local0 = f119_arg1
	local f119_local1 = CoD.WeaponOptionsUtility.GetActiveCamoRefForBaseCamoIndex( Engine[@"currentsessionmode"](), f119_arg1 )
	if f119_local1 and f119_local1 ~= 0x0 then
		local f119_local2 = Engine[@"hash_2E00B2F29271C60B"]( f119_local1 )
		if f119_local2 and f119_local2.stages then
			local f119_local3 = f119_local2.stages[CoD.CACUtility.GetHighestPermanentlyCompletedActiveCamoStage( f119_arg0, f119_local2, f119_arg2 )]
			if f119_local3 then
				local f119_local4 = Engine[@"tablelookup"]( CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f119_local3[@"camooption"] )
				if f119_local4 ~= nil and f119_local4 ~= "" then
					f119_local0 = f119_local4
				end
			end
		end
	end
	return f119_local0
end
CoD.CACUtility.GetWeaponOptionsFromClass = function ( f120_arg0, f120_arg1, f120_arg2 )
	if not f120_arg1 then
		f120_arg1 = CoD.perController[f120_arg0].classModel
		if not f120_arg1 then
			return CoD.CACUtility.EmptyWeaponOptions()
		end
	end
	local f120_local0 = f120_arg1[f120_arg2].camoIndex
	local f120_local1 = f120_arg1[f120_arg2].reticleIndex
	local f120_local2 = f120_arg1[f120_arg2].paintjobSlot
	local f120_local3 = f120_arg1[f120_arg2].weaponModelSlot
	local f120_local4 = f120_arg1[f120_arg2].charmIndex
	local f120_local5 = 0
	local f120_local6 = 0
	local f120_local7 = 0
	local f120_local8 = 0
	local f120_local9 = 0
	if f120_local0 then
		f120_local5 = f120_local0:get()
	end
	if f120_local1 then
		f120_local6 = f120_local1:get()
	end
	if f120_local3 then
		f120_local8 = f120_local3:get()
	end
	if f120_local4 then
		f120_local9 = f120_local4:get()
	end
	if IsLive() then
		if f120_local2 then
			local f120_local10 = f120_local2:get()
			Engine[@"setuppaintjobdata"]( f120_arg0, f120_local10 )
			if f120_local10 ~= Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] then
				f120_local7 = 1
			end
		end
	else
		Engine[@"clearpaintjoblayerdata"]()
	end
	return CoD.WeaponOptionsUtility.GetWeaponOptionsString( f120_local5, f120_local6, f120_local7, f120_local8, CoD.WeaponOptionsUtility.GetRobStageForCamoIndex( f120_local5 ), f120_local9 )
end
CoD.CACUtility.ClearWeaponOptionsForClass = function ( f121_arg0, f121_arg1, f121_arg2 )
	if not f121_arg1 then
		f121_arg1 = CoD.perController[f121_arg0].classModel
		if not f121_arg1 then
			return 
		end
	end
	local f121_local0 = f121_arg1.classNum:get()
	local f121_local1 = CoD.CACUtility.GetBaseWeaponLoadoutSlotName( f121_arg2 )
	local f121_local2 = f121_arg1[f121_arg2].camoIndex
	local f121_local3 = f121_arg1[f121_arg2].reticleIndex
	local f121_local4 = f121_arg1[f121_arg2].weaponModelSlot
	local f121_local5 = f121_arg1[f121_arg2].paintjobSlot
	if f121_local2 then
		f121_local2:set( CoD.CACUtility.EmptyItemIndex )
		CoD.CACUtility.SetClassItem( f121_arg0, f121_local0, f121_local1 .. ".camoIndex", CoD.CACUtility.EmptyItemIndex )
	end
	if f121_local3 then
		f121_local3:set( CoD.CACUtility.EmptyItemIndex )
		CoD.CACUtility.SetClassItem( f121_arg0, f121_local0, f121_local1 .. ".reticleIndex", CoD.CACUtility.EmptyItemIndex )
	end
	if f121_local4 then
		f121_local4:set( CoD.CACUtility.EmptyItemIndex )
		CoD.CACUtility.SetClassItem( f121_arg0, f121_local0, f121_local1 .. ".weaponModelSlot", CoD.CACUtility.EmptyItemIndex )
	end
	if f121_local5 then
		f121_local5:set( Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] )
		CoD.CACUtility.SetClassItem( f121_arg0, f121_local0, f121_local1 .. ".paintjobSlot", Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] )
	end
end
CoD.CACUtility.EmptyWeaponOptions = function ()
	return CoD.WeaponOptionsUtility.GetWeaponOptionsString()
end
CoD.CACUtility.GetBaseWeaponLoadoutSlotName = function ( f123_arg0 )
	local f123_local0 = nil
	if f123_arg0 == "primary" or f123_arg0 == "secondary" or f123_arg0 == "primarygrenade" or f123_arg0 == "specialgrenade" or f123_arg0 == "heroweapon" or f123_arg0 == "herogadget" or LUI.startswith( f123_arg0, "killstreak" ) or LUI.startswith( f123_arg0, "specialty" ) then
		f123_local0 = f123_arg0
	elseif LUI.startswith( f123_arg0, "primaryattachment" ) then
		f123_local0 = "primary"
	elseif LUI.startswith( f123_arg0, "secondaryattachment" ) then
		f123_local0 = "secondary"
	end
	return f123_local0
end
CoD.CACUtility.GetGunLevelWeaponIndex = function ( f124_arg0, f124_arg1 )
	local f124_local0 = f124_arg1:getModel()
	if f124_local0 then
		if f124_local0.itemIndex then
			return f124_local0.itemIndex:get()
		elseif f124_local0.weaponIndex then
			return f124_local0.weaponIndex:get()
		end
	end
	return CoD.CACUtility.EmptyItemIndex
end
CoD.CACUtility.AttachmentEquippedInCACSlot = function ( f125_arg0, f125_arg1, f125_arg2 )
	local f125_local0 = CoD.perController[f125_arg0].classModel
	local f125_local1 = CoD.CACUtility.PrimaryAttachmentSlotNameList
	if f125_arg1 == "secondary" then
		f125_local1 = CoD.CACUtility.SecondaryAttachmentSlotNameList
	end
	for f125_local5, f125_local6 in ipairs( f125_local1 ) do
		if Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f125_local0, f125_local6 .. ".itemIndex" ) ) == f125_arg2 then
			return f125_local5
		end
	end
end
CoD.CACUtility.CreateUnlockTokenModels = function ( f126_arg0 )
	if not CoD.CACUtility.unlockTokenModel[f126_arg0] then
		CoD.CACUtility.unlockTokenModel[f126_arg0] = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f126_arg0 ), "UnlockTokenInfo" )
		Engine[@"createmodel"]( CoD.CACUtility.unlockTokenModel[f126_arg0], "itemIndex" )
		local f126_local0 = Engine[@"createmodel"]( CoD.CACUtility.unlockTokenModel[f126_arg0], "xpBarInfo" )
		Engine[@"createmodel"]( f126_local0, "rankXP" )
		Engine[@"createmodel"]( f126_local0, "xpEarned" )
		Engine[@"createmodel"]( f126_local0, "xpNeeded" )
		Engine[@"createmodel"]( f126_local0, "currLevel" )
		Engine[@"createmodel"]( f126_local0, "currLevelIcon" )
		Engine[@"createmodel"]( f126_local0, "nextLevel" )
		Engine[@"createmodel"]( f126_local0, "nextLevelIcon" )
	end
	local f126_local0 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f126_arg0 ), "unlockTokensCount" )
	local f126_local1 = "weapon_smg"
	local f126_local2 = CoD.PlayerRoleUtility.customizationMode
	if not f126_local2 then
		f126_local2 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	end
	Engine[@"setmodelvalue"]( f126_local0, Engine[@"getcurrenttokens"]( f126_arg0, f126_local1, f126_local2 ) )
end
CoD.CACUtility.GetAllItems = function ( f127_arg0, f127_arg1 )
	if f127_arg0 ~= true and CoD.CACUtility.Items then
		return unpack( CoD.CACUtility.Items )
	end
	local f127_local0 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	local f127_local1 = {}
	for f127_local2 = 0, 43, 1 do
		f127_local1[f127_local2] = {
			index = f127_local2,
			desc = Engine[@"getattachmentdescbyattachmentindex"]( f127_local2, f127_local0 ),
			name = Engine[@"getattachmentnamebyindex"]( f127_local2 ),
			image = Engine[@"getattachmentimagebyindex"]( f127_local2 ),
			isOptic = Engine[@"isopticbyattachmentindex"]( f127_local2 ),
			restrictionState = Enum[@"itemrestrictionstate"][@"item_restriction_state_none"],
			items = {}
		}
	end
	local f127_local2 = {}
	for f127_local3 = 0, 255, 1 do
		if Engine[@"itemindexvalid"]( f127_local3, f127_local0 ) and not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem( Engine[@"getitemref"]( f127_local3 ) ) then
			local f127_local6 = Engine[@"getunlockableinfobyindex"]( f127_local3, f127_local0 )
			if f127_local6.allocation >= 0 then
				local f127_local7 = {
					index = f127_local3,
					name = f127_local6.name,
					image = f127_local6.image,
					groupIndex = f127_local6.groupIndex,
					groupName = f127_local6.group,
					loadoutSlot = f127_local6.loadoutSlot,
					loadoutSlotIndex = f127_local6.loadoutSlotIndex,
					unlockLevel = f127_local6.unlockLevel,
					momentum = f127_local6.momentum,
					restrictionState = f127_local6.restrictionState,
					allocation = f127_local6.allocation
				}
				if LuaUtils.StartsWith( f127_local7.loadoutSlot, "hero" ) then
					f127_local7.image = f127_local6.image .. "_large"
				end
				if LuaUtils.StartsWith( f127_local7.loadoutSlot, "killstreak" ) then
					f127_local7.image = f127_local6.image .. "_menu"
				end
				if f127_local7.loadoutSlot == "primary" or f127_local7.loadoutSlot == "secondary" then
					local f127_local8 = Engine[@"getnumattachments"]( f127_local3 )
					if f127_local8 > 0 then
						f127_local7.attachments = {}
						for f127_local9 = 0, f127_local8 - 1, 1 do
							local f127_local12 = Engine[@"getitemattachment"]( f127_local3, f127_local9 )
							if f127_local12 > CoD.CACUtility.EmptyItemIndex then
								f127_local7.attachments[f127_local12] = {
									attachmentIndex = f127_local12,
									restrictionState = Engine[@"hash_793ABA160B5D7323"]( f127_local3, f127_local12, false )
								}
								table.insert( f127_local1[f127_local12].items, {
									itemIndex = f127_local3
								} )
							end
						end
					end
				end
				f127_local2[f127_local3] = f127_local7
			end
		end
	end
	if f127_arg1 == true then
		local f127_local3 = function ( f128_arg0, f128_arg1 )
			if f127_local1[f128_arg0].isOptic and f127_local1[f128_arg1].isOptic then
				return Engine[@"localize"]( f127_local1[f128_arg0].name ) < Engine[@"localize"]( f127_local1[f128_arg1].name )
			elseif f127_local1[f128_arg0].isOptic ~= f127_local1[f128_arg1].isOptic then
				return f127_local1[f128_arg0].isOptic
			else
				return Engine[@"localize"]( f127_local1[f128_arg0].name ) < Engine[@"localize"]( f127_local1[f128_arg1].name )
			end
		end
		
		local f127_local4 = {}
		for f127_local6, f127_local7 in LUI.IterateTableBySortedKeys( f127_local1, f127_local3, nil ) do
			f127_local4[f127_local7.index] = f127_local7
		end
		f127_local5 = function ( f129_arg0, f129_arg1 )
			if LUI.startswith( f127_local2[f129_arg0].loadoutSlot, "killstreak" ) or LUI.startswith( f127_local2[f129_arg1].loadoutSlot, "killstreak" ) then
				return f127_local2[f129_arg0].momentum < f127_local2[f129_arg1].momentum
			elseif f127_local2[f129_arg0].groupIndex ~= f127_local2[f129_arg1].groupIndex then
				return f127_local2[f129_arg0].groupIndex < f127_local2[f129_arg1].groupIndex
			elseif f127_local2[f129_arg0].loadoutSlot == f127_local2[f129_arg1].loadoutSlot then
				return Engine[@"localize"]( f127_local2[f129_arg0].name ) < Engine[@"localize"]( f127_local2[f129_arg1].name )
			else
				return Engine[@"localize"]( f127_local2[f129_arg0].loadoutSlot ) < Engine[@"localize"]( f127_local2[f129_arg1].loadoutSlot )
			end
		end
		
		f127_local13 = {}
		for f127_local8, f127_local9 in LUI.IterateTableBySortedKeys( f127_local2, f127_local5, nil ) do
			f127_local13[f127_local8] = f127_local9
		end
		CoD.CACUtility.Items = {
			f127_local13,
			f127_local4
		}
		return unpack( CoD.CACUtility.Items )
	end
	CoD.CACUtility.Items = {
		f127_local2,
		f127_local1
	}
	return unpack( CoD.CACUtility.Items )
end
CoD.CACUtility.GetLoadout = function ( f130_arg0, f130_arg1 )
	local f130_local0 = {
		weapons = {},
		primaryAttachments = {},
		secondaryAttachments = {},
		equipment = {},
		perks = {},
		talents = {},
		bonuscards = {},
		streaks = {}
	}
	local f130_local1 = Engine[@"getcustomclass"]( f130_arg0, f130_arg1 )
	local f130_local2 = Engine[@"currentsessionmode"]()
	for f130_local6, f130_local7 in pairs( f130_local1 ) do
		if LUI.startswith( f130_local6, "primaryattachment" ) and f130_local1.primary then
			table.insert( f130_local0.primaryAttachments, Engine[@"getitemattachment"]( f130_local1.primary, f130_local7, f130_local2 ) )
		end
		if LUI.startswith( f130_local6, "secondaryattachment" ) and f130_local1.secondary then
			table.insert( f130_local0.secondaryAttachments, Engine[@"getitemattachment"]( f130_local1.secondary, f130_local7, f130_local2 ) )
		end
		if LUI.startswith( f130_local6, "killStreak" ) then
			f130_local0.streaks[f130_local6] = f130_local7
		end
		if LUI.startswith( f130_local6, "hero" ) then
			f130_local0.heroItem = f130_local7
		end
		if LUI.startswith( f130_local6, "specialty" ) then
			f130_local0.perks[f130_local6] = f130_local7
		end
		if LUI.startswith( f130_local6, "talent" ) or LUI.startswith( f130_local6, "tacticalgear" ) then
			f130_local0.talents[f130_local6] = Engine[@"hash_1E8B1E317B9DD6FE"]( f130_local7, Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"], f130_local2 ) or f130_local7
		end
		if LUI.startswith( f130_local6, "bonuscard" ) then
			f130_local0.bonuscards[f130_local6] = Engine[@"hash_1E8B1E317B9DD6FE"]( f130_local7, Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], f130_local2 ) or f130_local7
		end
		if LUI.startswith( f130_local6, "primarygrenade" ) then
			f130_local0.primaryGrenade = f130_local7
		end
		if f130_local6 == "primary" or f130_local6 == "secondary" then
			f130_local0.weapons[f130_local6] = f130_local7
		end
	end
	return f130_local0
end
CoD.CACUtility.GetFullLoadout = function ( f131_arg0 )
	local f131_local0 = {
		classes = {}
	}
	local f131_local1 = CoD.CACUtility.GetCustomClassCount( f131_arg0 )
	for f131_local2 = 0, f131_local1 - 1, 1 do
		local f131_local5 = CoD.CACUtility.GetLoadout( f131_arg0, f131_local2 )
		if f131_local0.streaks == nil then
			f131_local0.streaks = f131_local5.streaks
		end
		if f131_local0.heroItem == nil then
			f131_local0.heroItem = f131_local5.heroItem
		end
		table.insert( f131_local0.classes, f131_local5 )
	end
	return f131_local0
end
CoD.CACUtility.SetShowcaseWeaponToClassPrimary = function ( f132_arg0, f132_arg1 )
	local f132_local0 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	local f132_local1 = Engine[@"getmodel"]( Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f132_arg0 ), "CustomClassList" ), "class" .. f132_arg1 + 1 )
	local f132_local2 = CoD.InspectionUtility.GetShowcaseCategoryForCurrentSessionMode()
	local f132_local3 = Engine[@"getmodel"]( Engine[@"getmodel"]( f132_local1, "primary" ), "variantName" )
	if f132_local3 then
		Engine[@"setheroshowcaseweaponvariantname"]( f132_arg0, f132_local0, f132_local2, Engine[@"getmodelvalue"]( f132_local3 ) )
	end
	local f132_local4 = CoD.CACUtility.GetItemEquippedInSlot( "primary", f132_arg0, f132_local1 )
	if CoD.CACUtility.EmptyItemIndex < f132_local4 then
		Engine[@"setheroshowcaseweaponattribute"]( f132_arg0, f132_local0, f132_local2, @"weaponindex", f132_local4 )
	end
	for f132_local5 = 1, CoD.CACUtility.maxPrimaryAttachments, 1 do
		local f132_local8 = CoD.CACUtility.GetItemEquippedInSlot( "primaryattachment" .. f132_local5, f132_arg0, f132_local1 )
		if CoD.CACUtility.EmptyItemIndex < f132_local8 then
			Engine[@"setheroshowcaseweaponattribute"]( f132_arg0, f132_local0, f132_local2, @"attachment", f132_local8, f132_local5 - 1 )
		end
	end
	Engine[@"setheroshowcaseweaponattribute"]( f132_arg0, f132_local0, f132_local2, @"camoindex", CoD.CACUtility.GetItemEquippedInSlot( "primaryCamo", f132_arg0, f132_local1 ) )
	Engine[@"setheroshowcaseweaponattribute"]( f132_arg0, f132_local0, f132_local2, @"paintjobslot", CoD.CACUtility.GetItemEquippedInSlot( "primarypaintjobslot", f132_arg0, f132_local1 ) )
	MarkCACPaintshopDataDirty( nil, f132_arg0 )
end
CoD.CACUtility.SetShowcaseWeapon = function ( f133_arg0, f133_arg1, f133_arg2 )
	if IsCustomLobby() or IsLocal() then
		return 
	end
	local f133_local0 = Engine[@"currentsessionmode"]()
	local f133_local1 = CoD.BaseUtility.GetMenuSessionMode( f133_arg0 )
	local f133_local2 = CoD.BaseUtility.GetMenuModel( f133_arg0 )
	local f133_local3 = f133_arg2:getModel()
	local f133_local4 = f133_local3.weaponSlot:get()
	local f133_local5 = f133_local2[f133_local4].camoIndex
	local f133_local6 = f133_local2[f133_local4].paintjobSlot
	local f133_local7 = f133_local2[f133_local4].weaponModelSlot
	if f133_local0 ~= Enum[@"emodes"][@"mode_invalid"] and (f133_local4 == "primary" or f133_local4 == "secondary") then
		local f133_local8 = nil
		if f133_local3.itemIndex then
			f133_local8 = f133_local3.itemIndex:get()
		end
		if f133_local8 and f133_local8 > CoD.CACUtility.EmptyItemIndex and f133_local5 and f133_local5:get() and f133_local6 and f133_local6:get() then
			local f133_local9 = CoD.InspectionUtility.GetShowcaseCategoryForCurrentSessionMode()
			local f133_local10, f133_local11 = CoD.CACUtility.GetWeaponNameHashAndAttachmentsForXcam( f133_arg1, f133_local2, f133_local4, nil, f133_local1, f133_local8, nil )
			local f133_local12 = Engine[@"getmodel"]( Engine[@"getmodel"]( f133_local2, f133_local4 ), "variantName" )
			if f133_local12 then
				Engine[@"setheroshowcaseweaponvariantname"]( f133_arg1, f133_local1, f133_local9, Engine[@"getmodelvalue"]( f133_local12 ) )
			end
			if f133_local8 > CoD.CACUtility.EmptyItemIndex then
				Engine[@"setheroshowcaseweaponattribute"]( f133_arg1, f133_local1, f133_local9, @"weaponindex", f133_local8 )
			end
			for f133_local16, f133_local17 in ipairs( CoD.CACUtility.GetAttachmentListForSlot( f133_local4 ) ) do
				Engine[@"setheroshowcaseweaponattribute"]( f133_arg1, f133_local1, f133_local9, @"attachment", Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f133_local2, f133_local17 .. ".itemIndex" ) ), f133_local16 - 1 )
			end
			Engine[@"setheroshowcaseweaponattribute"]( f133_arg1, f133_local1, f133_local9, @"camoindex", f133_local5:get() )
			Engine[@"setheroshowcaseweaponattribute"]( f133_arg1, f133_local1, f133_local9, @"paintjobslot", f133_local6:get() )
			Engine[@"setheroshowcaseweaponattribute"]( f133_arg1, f133_local1, f133_local9, @"weaponmodelslot", f133_local7:get() )
			CoD.OverlayUtility.ShowToast( nil, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_24D7E6B5D2385EE7" ), "", "ui_menu_popups_toastnotification_icon_gunrack" )
		end
	end
end
CoD.CACUtility.AnyItemBanned = function ( f134_arg0 )
	for f134_local3, f134_local4 in pairs( f134_arg0 ) do
		if Engine[@"isitemindexrestricted"]( f134_local4, false ) then
			return true
		end
	end
	return false
end
CoD.CACUtility.AnyUnlockableItemBanned = function ( f135_arg0 )
	for f135_local3, f135_local4 in pairs( f135_arg0 ) do
		if Engine[@"isitemindexrestricted"]( f135_local4.globalItemIndex, false ) then
			return true
		end
	end
	return false
end
CoD.CACUtility.AllUnlockableItemsBanned = function ( f136_arg0 )
	for f136_local3, f136_local4 in pairs( f136_arg0 ) do
		if not Engine[@"isitemindexrestricted"]( f136_local4.globalItemIndex, false ) then
			return false
		end
	end
	return true
end
CoD.CACUtility.AnyAttachmentBanned = function ( f137_arg0, f137_arg1 )
	for f137_local3, f137_local4 in ipairs( f137_arg1 ) do
		if Engine[@"isattachmentrestricted"]( f137_local4, false ) == true then
			return true
		end
	end
	return false
end
CoD.CACUtility.IsItemGroupRestricted = function ( f138_arg0, f138_arg1 )
	return Engine[@"hash_3EAC75D44860D28"]( f138_arg0, f138_arg1 )
end
CoD.CACUtility.IsItemIndexRestricted = function ( f139_arg0 )
	return Engine[@"isitemindexrestricted"]( f139_arg0, false )
end
CoD.CACUtility.AreEquipmentsRestricted = function ( f140_arg0 )
	return Engine[@"hash_5B143C4D6107325"]( f140_arg0 )
end
CoD.CACUtility.AreSpecialWeaponsRestricted = function ( f141_arg0 )
	return Engine[@"hash_3345773EA5D5E534"]( f141_arg0 )
end
CoD.CACUtility.AreTalismanGameSettingsRestricted = function ( f142_arg0, f142_arg1, f142_arg2 )
	if f142_arg0 and f142_arg1 then
		for f142_local3, f142_local4 in ipairs( f142_arg0 ) do
			if f142_local4 and Engine[0x353582D64CB2FF]( f142_local4, f142_arg1, f142_arg2 ) then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.IsPerkRestricted = function ( f143_arg0, f143_arg1 )
	if f143_arg0 then
		for f143_local3, f143_local4 in ipairs( f143_arg0 ) do
			if f143_local4 and Engine[@"hash_58CA09BCB6594784"]( f143_local4, f143_arg1 ) then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.AreElixirGameSettingsRestricted = function ( f144_arg0, f144_arg1, f144_arg2 )
	if f144_arg0 and f144_arg1 then
		for f144_local3, f144_local4 in ipairs( f144_arg0 ) do
			if f144_local4 and Engine[@"hash_2ADF576B569F75B3"]( f144_local4, f144_arg1, f144_arg2 ) then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.AnyElixirRestrictedInTable = function ( f145_arg0 )
	if f145_arg0 then
		for f145_local3, f145_local4 in ipairs( f145_arg0 ) do
			if CoD.CACUtility.AreElixirGameSettingsRestricted( CoD.BGBUtility.ElixirToBooleanGameSettingsHash[f145_local4.nameHash], f145_local4[@"bgbrarity"], false ) or CoD.CACUtility.AreGameSettingsStateOff( CoD.BGBUtility.ElixirToEnumGameSettingsHash[f145_local4.nameHash], false ) then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.AnyElixirRestrictedForRarity = function ( f146_arg0, f146_arg1 )
	if CoD.CACUtility.AnyElixirRestrictedInTable( CoD.CACUtility.GetUnlockableBGBItemsForItemGroupAndRarity( Enum[@"emodes"][@"mode_zombies"], f146_arg1, f146_arg0 ) ) then
		return true
	else
		return false
	end
end
CoD.CACUtility.AreGameSettingsStateOff = function ( f147_arg0, f147_arg1 )
	if f147_arg0 then
		for f147_local3, f147_local4 in ipairs( f147_arg0 ) do
			if f147_local4 and Engine[@"getgametypesetting"]( f147_local4.hash, f147_arg1 ) == f147_local4.restrictedValue then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.AnyClassContainsRestrictedItems = function ( f148_arg0 )
	local f148_local0 = CoD.CACUtility.GetCustomClassCount( f148_arg0 )
	for f148_local1 = 0, f148_local0 - 1, 1 do
		if CoD.CACUtility.ClassContainsRestrictedItems( f148_arg0, f148_local1 ) then
			return true
		end
	end
	return false
end
CoD.CACUtility.AnyEquippedScorestreaksBanned = function ( f149_arg0 )
	return CoD.CACUtility.AnyItemBanned( CoD.ScorestreakSelectUtility.GetEquippedScorestreaksItemIndexTable( f149_arg0 ) )
end
CoD.CACUtility.ClassContainsRestrictedItems = function ( f150_arg0, f150_arg1 )
	local f150_local0 = CoD.CACUtility.GetLoadout( f150_arg0, f150_arg1 )
	if CoD.CACUtility.AnyItemBanned( f150_local0.weapons ) or CoD.CACUtility.AnyItemBanned( f150_local0.equipment ) or CoD.CACUtility.AnyItemBanned( f150_local0.perks ) or CoD.CACUtility.AnyItemBanned( f150_local0.talents ) or CoD.CACUtility.AnyItemBanned( f150_local0.bonuscards ) then
		return true
	elseif f150_local0.primaryGrenade ~= nil and Engine[@"isitemindexrestricted"]( f150_local0.primaryGrenade, false ) then
		return true
	elseif f150_local0.weapons.primary ~= nil and CoD.CACUtility.AnyAttachmentBanned( f150_local0.weapons.primary, f150_local0.primaryAttachments ) then
		return true
	elseif f150_local0.weapons.secondary ~= nil and CoD.CACUtility.AnyAttachmentBanned( f150_local0.weapons.secondary, f150_local0.secondaryAttachments ) then
		return true
	else
		return false
	end
end
CoD.CACUtility.GetAllRestrictedItems = function ()
	local f151_local0 = Engine[@"lobbygetsessionclients"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	local f151_local1 = f151_local0.sessionClients
	local f151_local2 = {}
	local f151_local3, f151_local4 = CoD.CACUtility.GetAllItems( true, true )
	for f151_local8, f151_local9 in pairs( f151_local3 ) do
		if Engine[@"isitemindexrestricted"]( f151_local9.index, false ) == true then
			table.insert( f151_local2, {
				globalVoteIndex = -1,
				itemType = Enum[@"voteitemtype"][@"vote_item_type_item"],
				itemIndex = f151_local9.index,
				itemGroup = -1,
				attachmentIndex = -1,
				voteType = Enum[@"votetype"][@"vote_type_ban"]
			} )
		end
	end
	for f151_local8, f151_local9 in pairs( f151_local4 ) do
		if Engine[@"isattachmentrestricted"]( f151_local9.index ) == true then
			table.insert( f151_local2, {
				globalVoteIndex = -1,
				itemType = Enum[@"voteitemtype"][@"vote_item_type_attachment"],
				itemIndex = f151_local9.index,
				itemGroup = -1,
				attachmentIndex = -1,
				voteType = Enum[@"votetype"][@"vote_type_ban"]
			} )
		end
	end
	return f151_local2
end
CoD.CACUtility.AnyCACItemsBanned = function ()
	for f152_local4, f152_local5 in ipairs( CoD.CACUtility.GetAllRestrictedItems() ) do
		if f152_local5.voteType == Enum[@"votetype"][@"vote_type_ban"] then
			if f152_local5.itemType == Enum[@"voteitemtype"][@"vote_item_type_item"] then
				local f152_local3 = Engine[@"getunlockableinfobyindex"]( f152_local5.itemIndex )
				if not LuaUtils.StartsWith( f152_local3.loadoutSlot, "hero" ) and not LuaUtils.StartsWith( f152_local3.loadoutSlot, "killstreak" ) then
					return true
				end
			end
			if f152_local5.itemType == Enum[@"voteitemtype"][@"vote_item_type_attachment"] then
				return true
			elseif f152_local5.itemType == Enum[@"voteitemtype"][@"vote_item_type_item_attachment"] then
				return true
			elseif f152_local5.itemType == Enum[@"voteitemtype"][@"vote_item_type_attachment_group"] then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.AnyStreaksBanned = function ()
	for f153_local4, f153_local5 in ipairs( CoD.CACUtility.GetAllRestrictedItems() ) do
		if f153_local5.voteType == Enum[@"votetype"][@"vote_type_ban"] and f153_local5.itemType == Enum[@"voteitemtype"][@"vote_item_type_item"] then
			local f153_local3 = Engine[@"getunlockableinfobyindex"]( f153_local5.itemIndex )
			if LUI.startswith( f153_local3.loadoutSlot, "killstreak" ) then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.AnySpecialistBanned = function ()
	local f154_local0, f154_local1 = CoD.CACUtility.GetAllItems( false, true )
	for f154_local5, f154_local6 in pairs( f154_local0 ) do
		if LuaUtils.StartsWith( f154_local6.loadoutSlot, "hero" ) and Engine[@"isitemindexrestricted"]( f154_local6.index, false ) then
			return true
		end
	end
	return false
end
CoD.CACUtility.EquippedSpecialistBanned = function ( f155_arg0 )
	local f155_local0 = CoD.CACUtility.GetFullLoadout( f155_arg0 )
	if f155_local0.heroItem then
		return Engine[@"isitemindexrestricted"]( f155_local0.heroItem, false )
	else
		return false
	end
end
CoD.CACUtility.GetItemInfoFromElementModel = function ( f156_arg0, f156_arg1 )
	if f156_arg1 then
		local f156_local0 = {}
		local f156_local1 = Engine[@"getmodel"]( f156_arg1, "itemType" )
		if f156_local1 then
			f156_local0.itemType = Engine[@"getmodelvalue"]( f156_local1 )
			local f156_local2 = Engine[@"getmodel"]( f156_arg1, "itemIndex" )
			if f156_local2 then
				f156_local0.itemIndex = Engine[@"getmodelvalue"]( f156_local2 )
			end
			local f156_local3 = Engine[@"getmodel"]( f156_arg1, "weaponIndex" )
			if f156_local3 then
				local f156_local4 = Engine[@"getmodelvalue"]( f156_local3 )
				if f156_local4 > 0 then
					f156_local0.itemIndex = f156_local4
				end
			end
			local f156_local4 = Engine[@"getmodel"]( f156_arg1, "attachmentIndex" )
			if f156_local4 then
				f156_local0.attachmentIndex = Engine[@"getmodelvalue"]( f156_local4 )
			end
			local f156_local5 = Engine[@"getmodel"]( f156_arg1, "itemGroup" )
			if f156_local5 then
				f156_local0.itemGroup = Engine[@"getmodelvalue"]( f156_local5 )
			end
			local f156_local6 = Engine[@"getmodel"]( f156_arg1, "weaponSlot" )
			if f156_local6 then
				f156_local0.weaponSlot = Engine[@"getmodelvalue"]( f156_local6 )
			end
			local f156_local7 = Engine[@"getmodel"]( f156_arg1, "loadoutSlot" )
			if f156_local7 then
				f156_local0.loadoutSlot = Engine[@"getmodelvalue"]( f156_local7 )
			end
			local f156_local8 = Engine[@"getmodel"]( f156_arg1, "restrictionState" )
			if f156_local8 then
				f156_local0.restrictionState = Engine[@"getmodelvalue"]( f156_local8 )
			end
			return f156_local0
		end
	end
end
CoD.CACUtility.ResetCPCustomClasses = function ( f157_arg0 )
	if CoD.isCampaign then
		local f157_local0 = Engine[@"getmodelforcontroller"]( f157_arg0 )
		local f157_local1 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f157_arg0 ), "CustomClassList.prepared" )
		if f157_local1 then
			Engine[@"unsubscribeandfreemodel"]( f157_local1 )
		end
		local f157_local2 = Engine[@"getmodel"]( f157_local0, "CustomClassList" )
		if f157_local2 then
			for f157_local3 = 1, 6, 1 do
				local f157_local6 = Engine[@"getmodel"]( f157_local2, "class" .. f157_local3 )
				if f157_local6 ~= nil then
					Engine[@"unsubscribeandfreemodel"]( f157_local6 )
				end
			end
		end
	end
end
CoD.CACUtility.GetItemVotedBy = function ( f158_arg0 )
	local f158_local0 = Engine[@"lobbygetsessionclients"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	local f158_local1 = f158_local0.sessionClients
	local f158_local2 = {}
	for f158_local11, f158_local12 in ipairs( f158_local1 ) do
		if f158_local12.voteCount > 0 then
			for f158_local9, f158_local10 in ipairs( f158_local12.votes ) do
				if f158_local10.itemType == Enum[@"voteitemtype"][@"vote_item_type_item"] and f158_arg0.itemType == Enum[@"voteitemtype"][@"vote_item_type_item"] then
					if f158_local10.itemIndex == f158_arg0.itemIndex then
						return f158_local12.gamertag
					end
				end
				if f158_local10.itemType == Enum[@"voteitemtype"][@"vote_item_type_attachment"] and f158_arg0.itemType == Enum[@"voteitemtype"][@"vote_item_type_attachment"] then
					if f158_local10.attachmentIndex == f158_arg0.attachmentIndex then
						return f158_local12.gamertag
					end
				end
				if f158_local10.itemType == Enum[@"voteitemtype"][@"vote_item_type_item_attachment"] and f158_arg0.itemType == Enum[@"voteitemtype"][@"vote_item_type_item_attachment"] then
					if f158_local10.itemIndex == f158_arg0.itemIndex and f158_local10.attachmentIndex == f158_arg0.attachmentIndex then
						return f158_local12.gamertag
					end
				end
				if f158_local10.itemType == Enum[@"voteitemtype"][@"vote_item_type_attachment_group"] and f158_arg0.itemType == Enum[@"voteitemtype"][@"vote_item_type_attachment_group"] and f158_local10.itemGroup == f158_arg0.itemGroup then
					return f158_local12.gamertag
				end
			end
		end
	end
	return ""
end
CoD.CACUtility.GetItemInfoFromElement = function ( f159_arg0, f159_arg1 )
	return CoD.CACUtility.GetItemInfoFromElementModel( f159_arg0, f159_arg1:getModel() )
end
CoD.CACUtility.IsItemConsumable = function ( f160_arg0, f160_arg1, f160_arg2 )
	if f160_arg2 == Enum[@"emodes"][@"mode_invalid"] then
		return false
	end
	local f160_local0 = Engine[@"getitemgroup"]( f160_arg0, f160_arg1, f160_arg2 )
	local f160_local1
	if f160_local0 ~= "bubblegum_consumable" and f160_local0 ~= "talisman" then
		f160_local1 = false
	else
		f160_local1 = true
	end
	return f160_local1
end
CoD.CACUtility.GetCurrentWeaponXP = function ( f161_arg0, f161_arg1, f161_arg2 )
	local f161_local0 = Engine[@"getplayerstats"]( f161_arg0.CoD.STATS_LOCATION_NORMAL, Enum[@"emodes"][@"mode_multiplayer"] )
	if f161_local0 ~= nil then
		local f161_local1 = f161_local0.ranked_item_stats[Engine[@"hash_7E12950F85CC3F92"]( f161_arg2, f161_arg1 )]
		if f161_local1 ~= nil then
			return f161_local1.xp
		end
	end
	return nil
end
CoD.CACUtility.GetWeaponPLevel = function ( f162_arg0, f162_arg1 )
	local f162_local0 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer( f162_arg0 )
	if f162_local0 then
		return f162_local0.ranked_item_stats[Engine[@"hash_7B98952F69D937F9"]( f162_arg1 )].pLevel:get()
	else
		
	end
end
CoD.CACUtility.GetExtraSlotCODPointCost = function ()
	if not AreCodPointsEnabled( 0 ) then
		return 0
	else
		return CoD.CACUtility.EXTRA_SLOTS_COD_POINTS_COST
	end
end
CoD.CACUtility.ChangeClassMenuName = "ChooseClass_InGame"
CoD.CACUtility.PositionDraftMenuName = "PositionDraft"
CoD.CACUtility.UnlockablesTable = nil
CoD.CACUtility.UnlockableItemsTable = nil
CoD.CACUtility.WeaponListSessionMode = nil
CoD.CACUtility.GetUnlockableItemTable = function ()
	return CoDLoadoutsShared.GetUnlockableItemTable()
end
CoD.CACUtility.GetPreviewImage = function ( f165_arg0, f165_arg1 )
	local f165_local0
	if f165_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		f165_local0 = f165_arg1.zmPreviewImage
		if not f165_local0 then
			if f165_arg0 == Enum[@"emodes"][@"mode_warzone"] then
				f165_local0 = f165_arg1.wzPreviewImage
				if not f165_local0 then
				
				else
					return f165_local0
				end
			end
			f165_local0 = f165_arg1.previewImage
		end
	else
		if f165_arg0 == Enum[@"emodes"][@"mode_warzone"] then
			f165_local0 = f165_arg1.wzPreviewImage
			if not f165_local0 then
			
			else
				return f165_local0
			end
		end
		f165_local0 = f165_arg1.previewImage
	end
	return f165_local0
end
CoD.CACUtility.GetPreviewImageLarge = function ( f166_arg0, f166_arg1 )
	local f166_local0
	if f166_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		f166_local0 = f166_arg1.zmPreviewImageLarge
		if not f166_local0 then
			if f166_arg0 == Enum[@"emodes"][@"mode_warzone"] then
				f166_local0 = f166_arg1.wzPreviewImageLarge
				if not f166_local0 then
				
				else
					return f166_local0
				end
			end
			f166_local0 = f166_arg1.previewImageLarge
		end
	else
		if f166_arg0 == Enum[@"emodes"][@"mode_warzone"] then
			f166_local0 = f166_arg1.wzPreviewImageLarge
			if not f166_local0 then
			
			else
				return f166_local0
			end
		end
		f166_local0 = f166_arg1.previewImageLarge
	end
	return f166_local0
end
CoD.CACUtility.GetDescription = function ( f167_arg0, f167_arg1 )
	if f167_arg0 ~= Enum[@"emodes"][@"mode_zombies"] or f167_arg1.zmDescription == 0x0 or not f167_arg1.zmDescription then
		if f167_arg0 == Enum[@"emodes"][@"mode_warzone"] then
			local f167_local0 = f167_arg1.wzDescription
			local f167_local1 = f167_arg1.wzDescription
		end
		local f167_local2 = f167_arg1.description
	end
	return f167_local0 and f167_local1 or f167_local2
end
CoD.CACUtility.GetSpecialIssueEquipmentItemIndex = function ()
	return CoDLoadoutsShared.GetSpecialIssueEquipmentItemIndex()
end
CoD.CACUtility.GetFeatureCACItemIndex = function ()
	if CoD.CACUtility.CACFeatureItemIndex == nil or CoD.CACUtility.CACFeatureItemIndex == CoD.CACUtility.EmptyItemIndex then
		CoD.CACUtility.CACFeatureItemIndex = Engine[@"hash_2D97229B24C685D5"]( CoD.CACUtility.CACFeatureUnlockableItem, Enum[@"emodes"][@"mode_multiplayer"] )
	end
	return CoD.CACUtility.CACFeatureItemIndex or 0
end
CoD.CACUtility.GetClassesUnlockableItemUnlockInfo = function ( f170_arg0, f170_arg1, f170_arg2 )
	if not CoD.CACUtility.ClassesUnlockableItemInfo.prepared then
		for f170_local3, f170_local4 in pairs( CoD.CACUtility.ClassesUnlockableItemInfo ) do
			if LUI.startswith( f170_local3, "classNum" ) and f170_local4.featureItemRef then
				f170_local4.featureItemIndex = Engine[@"hash_2D97229B24C685D5"]( f170_local4.featureItemRef )
			end
		end
		CoD.CACUtility.ClassesUnlockableItemInfo.prepared = true
	end
	if CoD.CACUtility.ClassesUnlockableItemInfo and f170_arg0 then
		local f170_local1 = CoD.CACUtility.ClassesUnlockableItemInfo["classNum_" .. f170_arg0]
		local f170_local2
		if f170_local1 then
			f170_local2 = f170_local1[f170_arg1]
			if not f170_local2 then
			
			else
				return f170_local2
			end
		end
		f170_local2 = f170_arg2
	else
		
	end
end
CoD.CACUtility.UpdateUnlockableTableBMItems = function ( f171_arg0, f171_arg1 )
	local f171_local0 = {}
	for f171_local13, f171_local14 in pairs( f171_arg1 ) do
		local f171_local9 = false
		for f171_local10, f171_local11 in ipairs( f171_local14 ) do
			if f171_local0[f171_local11] == nil then
				f171_local0[f171_local11] = false
				if CoD.SafeGetModelValue( f171_local11, "isBMItem" ) then
					local f171_local4 = CoD.SafeGetModelValue( f171_local11, "itemIndex" )
					local f171_local5 = false
					if f171_local4 then
						f171_local5 = CoD.BlackMarketUtility.IsItemLocked( f171_arg0, Engine[@"getitemref"]( f171_local4 ) )
					end
					local f171_local6 = Engine[@"createmodel"]( f171_local11, "isBMClassified" )
					if Engine[@"getmodelvalue"]( f171_local6 ) ~= f171_local5 then
						f171_local0[f171_local11] = true
						Engine[@"setmodelvalue"]( f171_local6, f171_local5 )
						local f171_local7 = Engine[@"createmodel"]( f171_local11, "name" )
						local f171_local8 = Engine[@"createmodel"]( f171_local11, "description" )
						if f171_local5 then
							Engine[@"setmodelvalue"]( f171_local7, CoD.BlackMarketUtility.ClassifiedName( false ) )
							Engine[@"setmodelvalue"]( f171_local8, "" )
						else
							Engine[@"setmodelvalue"]( f171_local7, Engine[@"getitemname"]( f171_local4 ) )
							Engine[@"setmodelvalue"]( f171_local8, Engine[@"getitemdesc"]( f171_local4 ) )
						end
						f171_local9 = true
					end
				end
			end
			if f171_local0[f171_local11] then
				f171_local9 = true
			end
		end
		if f171_local9 then
			table.sort( f171_local14, CoD.UnlockablesDataSourceComparisonFunction )
		end
	end
end
CoD.CACUtility.GetCraftWeaponListTable = function ( f172_arg0, f172_arg1 )
	local f172_local0 = CoD.CACUtility.GetUnlockableItemTable()
	CoD.CACUtility.UpdateUnlockableTableBMItems( f172_arg0, f172_local0 )
	return f172_local0
end
CoD.CACUtility.GetEmblemColorList = function ( f173_arg0 )
	local f173_local0 = {}
	local f173_local1 = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f173_arg0 ), "Emblem.EmblemColorList" )
	local f173_local2 = Enum[@"customizationcolorswatch"][@"customization_color_swatch_rows"]
	local f173_local3 = Enum[@"customizationcolorswatch"][@"customization_color_swatch_columns"]
	local f173_local4 = f173_local2 * f173_local3
	for f173_local5 = 0, f173_local4 - 1, 1 do
		local f173_local8, f173_local9, f173_local10 = Engine[@"getemblemswatchcolor"]( f173_local5 / f173_local3, f173_local5 % f173_local3 )
		local f173_local11 = Engine[@"createmodel"]( f173_local1, "color_" .. f173_local5 )
		Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f173_local11, "color" ), string.format( "%d %d %d", f173_local8, f173_local9, f173_local10 ) )
		table.insert( f173_local0, f173_local11 )
	end
	return f173_local0
end
CoD.CACUtility.GunsmithWeaponOptionsTable = nil
CoD.CACUtility.GetGunsmithWeaponOptionsTable = function ( f174_arg0, f174_arg1, f174_arg2 )
	return CoD.WeaponOptionsUtility.GetWeaponOptionsTableForCategory( f174_arg1.menu, f174_arg0, Enum[@"eweaponoptiongroup"][@"weaponoption_group_camo"], CoD.GetCustomization( f174_arg0, "weapon_index" ), 0, false )
end
CoD.CACUtility.OpenCACMenu = function ( f175_arg0, f175_arg1 )
	CoD.perController[f175_arg1].enableClassOptions = true
	return OpenOverlay( f175_arg0, "chooseClass", f175_arg1 )
end
CoD.CACUtility.OpenCACMenuEditClass = function ( f176_arg0, f176_arg1 )
	CoD.perController[f176_arg1].enableClassOptions = false
	return OpenOverlay( f176_arg0, "chooseClass", f176_arg1 )
end
CoD.CACUtility.GetAttachments = function ( f177_arg0 )
	local f177_local0 = Engine[@"getnumattachments"]( f177_arg0 )
	if f177_local0 == nil then
		return nil
	end
	local f177_local1 = {}
	for f177_local2 = 1, f177_local0 - 1, 1 do
		table.insert( f177_local1, {
			weaponItemIndex = f177_arg0,
			attachmentIndex = f177_local2
		} )
	end
	return f177_local1
end
CoD.CACUtility.GetClassItem = function ( f178_arg0, f178_arg1, f178_arg2, f178_arg3 )
	if not f178_arg3 then
		f178_arg3 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	end
	local f178_local0 = Engine[@"getcustomclasscacroot"]( f178_arg0, f178_arg1, f178_arg3 )
	if f178_local0 then
		local f178_local1 = LUI.getTableFromPath( CoD.CACUtility.GetDDLPathForModelPath( f178_local0, f178_arg2 ), f178_local0 )
		return f178_local1:get()
	else
		
	end
end
CoD.CACUtility.GetDDLPathForModelPath = function ( f179_arg0, f179_arg1 )
	if f179_arg1 == "primary" or f179_arg1 == "secondary" then
		return f179_arg1 .. ".itemIndex"
	else
		local f179_local0 = LUI.splitString( f179_arg1, "." )
		if #f179_local0 >= 3 then
			if (f179_local0[1] == "primary" or f179_local0[1] == "secondary") and LUI.endswith( f179_local0[2], "attachment" ) then
				return f179_local0[1] .. "." .. f179_local0[2] .. "." .. tonumber( f179_local0[3] ) - 1
			else
				
			end
		elseif #f179_local0 >= 2 then
			if f179_local0[1] == "primary" or f179_local0[1] == "secondary" then
				return f179_arg1
			else
				return f179_local0[1] .. "." .. tonumber( f179_local0[2] ) - 1
			end
		else
			return f179_arg1
		end
	end
end
CoD.CACUtility.SetClassItem = function ( f180_arg0, f180_arg1, f180_arg2, f180_arg3, f180_arg4, f180_arg5 )
	if not f180_arg5 then
		f180_arg5 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	end
	local f180_local0 = Engine[@"getcustomclasscacroot"]( f180_arg0, f180_arg1, f180_arg5 )
	local f180_local1 = CoD.CACUtility.GetDDLPathForModelPath( f180_local0, f180_arg2 )
	local f180_local2 = LUI.getTableFromPath( f180_local1, f180_local0 )
	if not f180_local2 then
		return false
	end
	f180_local2:set( f180_arg3 )
	if f180_arg4 and f180_local0[f180_local1 .. "count"] then
		f180_local0[f180_local1 .. "count"]:set( f180_arg4 )
	end
	return true
end
CoD.CACUtility.HowManyInClassSlot = function ( f181_arg0, f181_arg1 )
	for f181_local3, f181_local4 in pairs( f181_arg1 ) do
		if f181_local4.itemIndex == f181_arg0 then
			if f181_local4.count == nil then
				return 1
			end
			return f181_local4.count
		end
	end
	return 0
end
CoD.CACUtility.PrepareOverCapactiyList = function ( f182_arg0, f182_arg1 )
	local f182_local0 = {}
	local f182_local1 = 20
	local f182_local2 = -2
	local f182_local3, f182_local4, f182_local5 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f182_arg1.menu )
	local f182_local6 = CoD.perController[f182_arg0].overCapacityItemIndex
	local f182_local7 = CoD.perController[f182_arg0].overCapacityItemRefHash
	local f182_local8 = CoD.perController[f182_arg0].overCapacityIsUberAttachment
	local f182_local9 = function ( f183_arg0, f183_arg1, f183_arg2, f183_arg3 )
		local f183_local0 = 0x0
		local f183_local1 = f183_arg1
		local f183_local2 = nil
		if LUI.startswith( f183_arg0, "primary.attachment" ) then
			f183_local1 = f182_local3.primary
			f183_local2 = "primary"
		elseif LUI.startswith( f183_arg0, "secondary.attachment" ) then
			f183_local1 = f182_local3.secondary
			f183_local2 = "secondary"
		end
		if f183_arg3 then
			f183_local0 = f183_local1.headerName:get()
		end
		return {
			models = {
				headerName = f183_local0,
				name = f183_arg1.name:get(),
				image = f183_arg1.image:get() or "blacktransparent",
				loadoutSlot = f183_arg0
			},
			properties = {
				itemRef = f183_arg1.ref:get(),
				spacing = f183_arg2 or f182_local2,
				weaponSlot = f183_local2
			}
		}
	end
	
	local f182_local10 = false
	local f182_local11 = false
	local f182_local12 = nil
	local f182_local13 = false
	if LUI.startswith( f182_local5, "primary.attachment" ) or LUI.startswith( f182_local5, "secondary.attachment" ) then
		local f182_local14 = LUI.splitString( f182_local5, "." )
		local f182_local15 = f182_local3[f182_local14[1]].itemIndex:get()
		local f182_local16 = Engine[@"getattachmentref"]( f182_local15, f182_local6, f182_local4 )
		local f182_local17 = Engine[@"getunlockableitemkvpinfo"]( f182_local15, f182_local4 )
		if CoD.WeaponAttachmentsUtility.IsAttachmentUpgrade( f182_local17, f182_local16 ) then
			if f182_local14[1] == "primary" then
				f182_local10 = true
			else
				f182_local11 = true
			end
			f182_local12 = Engine[@"getattachmentindexbyattachmenttableindex"]( f182_local15, Engine[@"getattachmentindexbyref"]( CoD.WeaponAttachmentsUtility.GetBaseAttachmentRef( f182_local17, f182_local16 ) ), f182_local4 )
			f182_local13 = CoD.BonuscardUtility.LoadoutSlotInfoTable[CoD.CACUtility.GetAttachedItemSlot( f182_local3, f182_local12, CoD.CACUtility.GetAttachmentListForSlot( f182_local14[1] ) )] ~= nil
		end
	end
	if f182_local3 then
		local f182_local14 = false
		for f182_local26, f182_local27 in ipairs( CoD.CACUtility.overCapacityLoadoutSlotOrder ) do
			local f182_local28 = f182_local3[f182_local27]
			if f182_local28 then
				local f182_local18 = f182_local1
				local f182_local19 = #f182_local0
				local f182_local20, f182_local21 = nil
				local f182_local22 = true
				local f182_local23 = f182_local28.itemIndex:get()
				local f182_local24 = f182_local28.refHash
				if f182_local24 then
					f182_local24 = f182_local28.refHash:get()
				end
				local f182_local25 = f182_local28.weaponSlot
				if f182_local25 then
					f182_local25 = f182_local28.weaponSlot:get()
				end
				if LUI.startswith( f182_local25, "primary.attachment" ) or LUI.startswith( f182_local25, "secondary.attachment" ) or Engine[@"getitemallocationcost"]( f182_local23, CoD.CACUtility.GetStatIndexOffsetForLoadoutSlot( f182_local25, f182_local4 ), f182_local4 ) > 0 then
					if f182_local19 > 0 then
						f182_local21 = f182_local0[f182_local19].models.loadoutSlot
					end
					if LUI.startswith( f182_local5, "primary.attachment" ) and f182_local27 == "primary" then
						
					end
					if LUI.startswith( f182_local5, "secondary.attachment" ) and f182_local27 == "secondary" then
						f182_local14 = true
					end
					if f182_local12 == f182_local23 then
						if not f182_local11 or not LUI.startswith( f182_local27, "secondary.attachment" ) then
							if f182_local10 and LUI.startswith( f182_local27, "primary.attachment" ) then
								
							end
						end
					end
					if f182_local10 and f182_local13 and CoD.BonuscardUtility.IsBonuscardOfTypeList( CoD.BonuscardUtility.PrimaryGunfighterWildcards, f182_local24 ) then
						
					end
					if f182_local11 and f182_local13 and CoD.BonuscardUtility.IsBonuscardOfTypeList( CoD.BonuscardUtility.SecondaryGunfighterWildcards, f182_local24 ) then
						
					end
					if f182_local5 == "primarygrenadecount" and f182_local27 == "primarygrenade" then
						
					end
					if CoD.BonuscardUtility.IsBonuscardOfTypeList( CoD.BonuscardUtility.PrimaryGunfighterWildcards, f182_local7 ) then
						if f182_local27 ~= "primary" then
							if LUI.startswith( f182_local27, "primary.attachment" ) then
								
							end
						end
					end
					if CoD.BonuscardUtility.IsBonuscardOfTypeList( CoD.BonuscardUtility.SecondaryGunfighterWildcards, f182_local7 ) then
						if f182_local27 ~= "secondary" then
							if LUI.startswith( f182_local27, "secondary.attachment" ) then
								
							end
						end
					end
					if f182_local5 == "talent.4" and f182_local24 == @"bonuscard_perk_1_greed" then
						
					end
					if f182_local5 == "talent.5" and f182_local24 == @"bonuscard_perk_2_greed" then
						
					end
					if f182_local5 == "talent.6" and f182_local24 == @"bonuscard_perk_3_greed" then
						
					end
					if (f182_local5 == "talent.2" or f182_local5 == "talent.3") and f182_local24 == @"bonuscard_perk_1_gluttony" then
						
					end
					if (f182_local5 == "talent.1" or f182_local5 == "talent.3") and f182_local24 == @"bonuscard_perk_2_gluttony" then
						
					end
					if (f182_local5 == "talent.1" or f182_local5 == "talent.2") and f182_local24 == @"bonuscard_perk_3_gluttony" then
						
					end
					if LUI.startswith( f182_local5, "primary" ) and f182_local24 == @"bonuscard_underkill" then
						
					end
					if LUI.startswith( f182_local5, "secondary" ) and f182_local24 == @"bonuscard_overkill" then
						
					end
					if (f182_local5 == "primary.attachment.4" or f182_local5 == "primary.attachment.5" or f182_local5 == "primary.attachment.6") and CoD.BonuscardUtility.IsBonuscardOfTypeList( CoD.BonuscardUtility.PrimaryGunfighterWildcards, f182_local24 ) then
						
					end
					if (f182_local5 == "secondary.attachment.4" or f182_local5 == "secondary.attachment.5" or f182_local5 == "secondary.attachment.6") and CoD.BonuscardUtility.IsBonuscardOfTypeList( CoD.BonuscardUtility.SecondaryGunfighterWildcards, f182_local24 ) then
						
					end
					if f182_local5 == "primary.attachment.5" and f182_local24 == @"bonuscard_primary_operator_mod" and f182_local8 then
						
					end
					if f182_local5 == "secondary.attachment.5" and f182_local24 == @"bonuscard_secondary_operator_mod" and f182_local8 then
						
					end
					if f182_local23 > CoD.CACUtility.EmptyItemIndex then
						if f182_local27 == "primarygrenadecount" then
							if f182_local21 == "primarygrenade" then
								f182_local0[f182_local19].properties.spacing = f182_local2
								f182_local22 = false
							end
							table.insert( f182_local0, f182_local9( f182_local27, f182_local28, f182_local1, f182_local22 ) )
						end
						if f182_local21 and (not (not LUI.startswith( f182_local27, "primary.attachment" ) and (f182_local14 or not LUI.startswith( f182_local27, "secondary.attachment" ))) or not (not LUI.startswith( f182_local21, "talent" ) or not LUI.startswith( f182_local27, "talent" )) or LUI.startswith( f182_local21, "bonuscard" ) and LUI.startswith( f182_local27, "bonuscard" )) then
							f182_local0[f182_local19].properties.spacing = f182_local2
							f182_local22 = false
						end
						if f182_local14 and LUI.startswith( f182_local27, "secondary.attachment" ) then
							f182_local14 = false
						end
						table.insert( f182_local0, f182_local9( f182_local27, f182_local28, f182_local18, f182_local22 ) )
					end
				end
			end
		end
	end
	return f182_local0
end
local f0_local0 = {
	getSpacerAfterColumn = function ( f184_arg0, f184_arg1 )
		local f184_local0 = f184_arg0[f184_arg0.dataSourceName]
		if f184_local0[f184_arg1] then
			return f184_local0[f184_arg1].properties.spacing
		else
			return -2
		end
	end
}
CoD.CACUtility.RemoveItemFromClassList = function ( f185_arg0 )
	local f185_local0 = CoD.perController[f185_arg0].weaponCategory
	local f185_local1 = CoD.CACUtility.PrepareOverCapactiyList( f185_arg0 )
	local f185_local2 = nil
	for f185_local3 = #f185_local1, 1, -1 do
		local f185_local6 = f185_local1[f185_local3].models.itemSlot
		if f185_local0 == f185_local6 or LUI.startswith( f185_local6, f185_local0 .. "attachment" ) then
			table.remove( f185_local1, f185_local3 )
		end
	end
	return f185_local1
end
DataSources.RemoveItemFromClassList = DataSourceHelpers.ListSetup( "RemoveItemFromClassList", CoD.CACUtility.RemoveItemFromClassList, true, f0_local0 )
DataSources.OverCapacityList = DataSourceHelpers.ListSetup( "OverCapacityList", CoD.CACUtility.PrepareOverCapactiyList, true, f0_local0 )
CoD.CACUtility.PrepareWildcardOverCapactiyList = function ( f186_arg0, f186_arg1 )
	local f186_local0 = {}
	local f186_local1 = CoD.BaseUtility.GetMenuModel( f186_arg1.menu )
	local f186_local2 = function ( f187_arg0 )
		local f187_local0 = f186_local1[f187_arg0]
		return {
			models = {
				name = f187_local0.name:get(),
				image = f187_local0.image:get() or "blacktransparent",
				loadoutSlot = f187_arg0
			},
			properties = {
				itemIndex = f187_local0.itemIndex:get()
			}
		}
	end
	
	for f186_local6, f186_local7 in ipairs( CoD.CACUtility.BonuscardSlotNameList ) do
		table.insert( f186_local0, f186_local2( f186_local7 ) )
	end
	return f186_local0
end
DataSources.WildcardOvercapacityList = DataSourceHelpers.ListSetup( "WildcardOvercapacityList", CoD.CACUtility.PrepareWildcardOverCapactiyList, true )
CoD.CACUtility.GetNonZeroNumberOfAttachment = function ( f188_arg0 )
	local f188_local0 = 0
	for f188_local4, f188_local5 in ipairs( f188_arg0 ) do
		if f188_local5 > CoD.CACUtility.EmptyItemIndex then
			f188_local0 = f188_local0 + 1
		end
	end
	return f188_local0
end
CoD.CACUtility.GetWeaponAndAttachments = function ( f189_arg0, f189_arg1 )
	local f189_local0 = 0
	local f189_local1 = false
	local f189_local2 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f189_arg1 ), "currentWeapon" )
	if f189_local2 == nil then
		return f189_local0, f189_local1
	end
	for f189_local3 = 1, 4, 1 do
		local f189_local6 = Engine[@"getmodel"]( f189_local2, "attachmentName" .. f189_local3 )
		local f189_local7 = Engine[@"getmodelvalue"]( f189_local6 )
		if f189_local6 and f189_local7 ~= "" then
			f189_local0 = f189_local0 + 1
		end
		if f189_arg0["currentAttachment" .. f189_local3] ~= f189_local7 then
			f189_arg0["currentAttachment" .. f189_local3] = f189_local7
			f189_local1 = true
		end
	end
	f189_arg0.currentWeapon = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f189_local2, "weaponName" ) )
	return f189_local0, f189_local1
end
CoD.CACUtility.GetLocalizedAttachmentsString = function ( f190_arg0 )
	local f190_local0 = ""
	if f190_arg0.currentAttachment1 ~= nil and f190_arg0.currentAttachment1 ~= "" then
		f190_local0 = Engine[@"localize"]( f190_arg0.currentAttachment1 )
	end
	if f190_arg0.currentAttachment2 ~= nil and f190_arg0.currentAttachment2 ~= "" then
		f190_local0 = f190_local0 .. " + " .. Engine[@"localize"]( f190_arg0.currentAttachment2 )
	end
	if f190_arg0.currentAttachment3 ~= nil and f190_arg0.currentAttachment3 ~= "" then
		f190_local0 = f190_local0 .. " + " .. Engine[@"localize"]( f190_arg0.currentAttachment3 )
	end
	return f190_local0
end
CoD.CACUtility.ForceStreamedImages = {}
CoD.CACUtility.AddToTableIfNotEmpty = function ( f191_arg0, f191_arg1 )
	if f191_arg1 ~= 0x0 then
		f191_arg0[f191_arg1] = true
	end
end
CoD.CACUtility.ForceStreamCACImages = function ( f192_arg0, f192_arg1 )
	local f192_local0 = {}
	for f192_local4, f192_local5 in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
		if CoD.BitUtility.IsBitSet( f192_local5.modes, f192_arg1 ) and f192_local5[@"hideinmenu"] ~= 1 then
			CoD.CACUtility.AddToTableIfNotEmpty( f192_local0, Engine[@"hash_1BF99001028052B9"]( CoD.CACUtility.GetPreviewImageLarge( f192_arg1, f192_local5 ) ) )
			CoD.CACUtility.AddToTableIfNotEmpty( f192_local0, Engine[@"hash_1BF99001028052B9"]( CoD.CACUtility.GetPreviewImage( f192_arg1, f192_local5 ) ) )
		end
	end
	CoD.CACUtility.ForceStreamedImages = CoD.BaseUtility.ForceStreamHelper( CoD.CACUtility.ForceStreamedImages, f192_local0 )
	if Engine[@"currentsessionmode"]() ~= Enum[@"emodes"][@"mode_invalid"] then
		Engine[@"streamsetcustomclass"]( f192_arg0, CoD.CACUtility.GetSelectedCustomClass( f192_arg0, f192_arg1 ) )
	end
end
CoD.CACUtility.ForceStreamedImagesInGame = {}
CoD.CACUtility.ForceStreamCACImagesInGame = function ( f193_arg0, f193_arg1 )
	local f193_local0 = {}
	if not CoD.CACUtility.ForceStreamedImagesInGame[f193_arg0] then
		CoD.CACUtility.ForceStreamedImagesInGame[f193_arg0] = {}
	end
	for f193_local14, f193_local15 in ipairs( f193_arg1 ) do
		local f193_local16 = f193_local15.models
		for f193_local4, f193_local5 in ipairs( {
			"primary",
			"secondary",
			"tacticalgear"
		} ) do
			if f193_local16[f193_local5] then
				CoD.CACUtility.AddToTableIfNotEmpty( f193_local0, f193_local16[f193_local5].image:get() )
				CoD.CACUtility.AddToTableIfNotEmpty( f193_local0, Engine[@"hash_1BF99001028052B9"]( f193_local16[f193_local5].imageLarge:get() ) )
			end
		end
		for f193_local4, f193_local5 in ipairs( {
			CoD.CACUtility.PrimaryAttachmentSlotNameList,
			CoD.CACUtility.SecondaryAttachmentSlotNameList
		} ) do
			for f193_local9, f193_local10 in ipairs( f193_local5 ) do
				CoD.CACUtility.AddToTableIfNotEmpty( f193_local0, f193_local16[f193_local10].image:get() )
			end
		end
	end
	CoD.CACUtility.ForceStreamedImagesInGame[f193_arg0] = CoD.BaseUtility.ForceStreamHelper( CoD.CACUtility.ForceStreamedImagesInGame[f193_arg0], f193_local0 )
end
CoD.WGSV_Category = {}
CoD.WGSV_Category.WEAPON = 1
CoD.WGSV_Category.GUNSMITH_VARIANT = 2
DataSources.WGSV_Category = Engine[@"createmodel"]( Engine[@"getglobalmodel"](), "WGSV_Category" )
DataSourceHelpers.PerControllerDataSourceSetup( "AttachmentMenu", "AttachmentMenu", function ( f194_arg0, f194_arg1 )
	local f194_local0 = CoD.perController[f194_arg1].classModel
	local f194_local1 = CoD.perController[f194_arg1].weaponCategory
	if f194_local0 and f194_local1 and f194_local0[f194_local1] then
		local f194_local2 = f194_arg0:create( "weapon" )
		f194_local2:set( f194_local0[f194_local1] )
		f194_local2 = f194_arg0:create( "weaponName" )
		f194_local2:set( f194_local0[f194_local1].name:get() )
		f194_local2 = f194_arg0:create( "activeAttachmentSlotIndex" )
		f194_local2:set( 1 )
		f194_arg0:create( "activeAttachmentSlotModel" )
	end
end, true )
CoD.CACUtility.GetWeaponNameHashAndAttachmentsForXcam = function ( f195_arg0, f195_arg1, f195_arg2, f195_arg3, f195_arg4, f195_arg5, f195_arg6 )
	local f195_local0 = f195_arg1
	local f195_local1 = f195_arg1[f195_arg2]
	if f195_local1 then
		f195_local1 = f195_local0 and f195_arg1[f195_arg2].itemIndex
	end
	if f195_local1 or f195_arg5 then
		local f195_local2 = f195_arg5 or f195_local1:get()
		if f195_local2 == CoD.CACUtility.EmptyItemIndex then
			return @"hash_0", ""
		end
		local f195_local3 = Engine[@"hash_7B98952F69D937F9"]( f195_local2, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f195_arg4 )
		local f195_local4 = Engine[@"getunlockableitemkvpinfo"]( f195_local2, f195_arg4 )
		local f195_local5 = nil
		if f195_arg2 == "primary" then
			f195_local5 = CoD.CACUtility.PrimaryAttachmentSlotNameList
		elseif f195_arg2 == "secondary" then
			f195_local5 = CoD.CACUtility.SecondaryAttachmentSlotNameList
		end
		local f195_local6, f195_local7 = nil
		if f195_arg3 and f195_arg1[f195_arg3] then
			f195_local6 = f195_arg1[f195_arg3].itemIndex:get()
			f195_local7 = f195_arg1[f195_arg3].ref:get()
		end
		local f195_local8 = CoD.WeaponAttachmentsUtility.DoesAttachmentHaveUpgrade( f195_local4, f195_local7 )
		local f195_local9 = ""
		local f195_local10 = {}
		if f195_local5 and f195_arg1 then
			for f195_local14, f195_local15 in ipairs( f195_local5 ) do
				local f195_local16 = f195_arg1[f195_local15].itemIndex:get()
				if f195_local16 > CoD.CACUtility.EmptyItemIndex and (f195_local16 ~= f195_local6 or not f195_local8) then
					table.insert( f195_local10, {
						itemIndex = f195_local16,
						ref = Engine[@"getattachmentref"]( f195_local2, f195_local16, f195_arg4 )
					} )
				end
			end
			for f195_local14, f195_local15 in ipairs( f195_local10 ) do
				if f195_arg6 == nil or Engine[@"areattachmentscompatible"]( f195_local2, f195_arg6, f195_local15.itemIndex ) then
					f195_local9 = LUI.appendStringWithDelimiter( f195_local9, f195_local15.ref, "+" )
				end
			end
		end
		return f195_local3, f195_local9
	else
		
	end
end
CoD.CACUtility.UnequipIncompatibleAttachments = function ( f196_arg0, f196_arg1, f196_arg2, f196_arg3, f196_arg4 )
	local f196_local0 = Engine[@"getcustomclasscacroot"]( f196_arg0, f196_arg1, f196_arg4 )
	local f196_local1 = f196_arg2
	local f196_local2 = false
	local f196_local3 = LUI.splitString( f196_local1, "." )
	if #f196_local3 > 1 then
		local f196_local4 = f196_local0[f196_local3[1]].itemIndex:get()
		local f196_local5 = LUI.getTableFromFieldList( f196_local3, f196_local0 )
		if f196_local5 then
			for f196_local6 = 0, #f196_local5 - 1, 1 do
				if not Engine[@"areattachmentscompatible"]( f196_local4, f196_arg3, f196_local5[f196_local6]:get(), f196_arg4 ) then
					f196_local2 = true
					f196_local5[f196_local6]:set( CoD.CACUtility.EmptyItemIndex )
				end
			end
		end
	end
	return f196_local2
end
CoD.CACUtility.AreAnyAttachmentsIncompatible = function ( f197_arg0, f197_arg1, f197_arg2, f197_arg3, f197_arg4 )
	local f197_local0 = Engine[@"getcustomclasscacroot"]( f197_arg0, f197_arg1, f197_arg4 )
	local f197_local1 = LUI.splitString( CoD.CACUtility.GetDDLPathForModelPath( f197_local0, f197_arg2 ), "." )
	if #f197_local1 > 1 then
		local f197_local2 = f197_local0[f197_local1[1]].itemIndex:get()
		local f197_local3 = LUI.getTableFromFieldList( f197_local1, f197_local0 )
		if f197_local3 then
			for f197_local4 = 0, #f197_local3 - 1, 1 do
				if not Engine[@"areattachmentscompatible"]( f197_local2, f197_arg3, f197_local3[f197_local4]:get(), f197_arg4 ) then
					return true
				end
			end
		end
	end
	return false
end
CoD.CACUtility.GetAttachmentIndexForSlotOrList = function ( f198_arg0 )
	local f198_local0 = CoD.SafeGetModelValue( f198_arg0:getModel(), "itemIndex" )
	if not f198_local0 then
		local f198_local1 = CoD.SafeGetModelValue( f198_arg0:getModel(), "itemIndexModel" )
		f198_local0 = f198_local1 and f198_local1:get()
		if not f198_local0 then
			local f198_local2 = CoD.SafeGetModelValue( f198_arg0:getModel(), "activeAttachmentSlotModel" )
			f198_local0 = f198_local2 and f198_local2.itemIndex:get()
		end
	end
	return f198_local0
end
CoD.CACUtility.GetAtachmentGroupForModel = function ( f199_arg0, f199_arg1 )
	if f199_arg0 then
		return Engine[@"hash_2B8DE256555CACF5"]( f199_arg0.weaponIndex:get(), f199_arg0.itemIndex:get(), f199_arg1 )
	else
		
	end
end
CoD.CACUtility.GetAttachmentGroupForSlotOrList = function ( f200_arg0, f200_arg1 )
	local f200_local0 = f200_arg0.attachmentGroup
	if not f200_local0 then
		return CoD.CACUtility.GetAtachmentGroupForModel( CoD.SafeGetModelValue( f200_arg0:getModel(), "attachmentSlot" ), f200_arg1 )
	else
		return f200_local0
	end
end
CoD.CACUtility.GetWeaponIndexFromAttachmentSlot = function ( f201_arg0 )
	local f201_local0 = f201_arg0:getModel()
	if f201_local0 then
		f201_local0 = f201_arg0:getModel()
		f201_local0 = f201_local0.attachmentSlot:get()
	end
	if f201_local0 then
		return f201_local0.weaponIndex and f201_local0.weaponIndex:get()
	else
		
	end
end
CoD.CACUtility.RemoveAttachmentFromClassHelper = function ( f202_arg0, f202_arg1, f202_arg2, f202_arg3, f202_arg4 )
	local f202_local0 = false
	local f202_local1 = CoD.CACUtility.GetAttachedItemSlot( f202_arg1, f202_arg2, f202_arg3 )
	if f202_local1 and RemoveItemFromClassSlot( f202_arg1, f202_local1, f202_arg0, false, f202_arg4 ) then
		local f202_local2 = LUI.splitString( f202_local1, "." )
		CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadoutHelper( f202_arg0, f202_arg1, f202_local2[1], f202_arg4 )
		f202_local0 = true
	end
	return f202_local0
end
CoD.CACUtility.GetMutuallyExclusiveAttachments = function ( f203_arg0, f203_arg1, f203_arg2, f203_arg3, f203_arg4 )
	local f203_local0 = Engine[@"getcustomclasscacroot"]( f203_arg0, f203_arg1, f203_arg4 )
	local f203_local1 = LUI.splitString( CoD.CACUtility.GetDDLPathForModelPath( f203_local0, f203_arg2 ), "." )
	if #f203_local1 > 1 then
		local f203_local2 = tonumber( f203_local1[#f203_local1] )
		f203_local1[#f203_local1] = nil
		local f203_local3 = f203_local0[f203_local1[1]].itemIndex:get()
		local f203_local4 = LUI.getTableFromFieldList( f203_local1, f203_local0 )
		local f203_local5 = {}
		local f203_local6 = CoD.CACUtility.GetUnlockableItemInfoField( f203_local3, f203_arg4, @"hash_5665460432375A7" )
		local f203_local7 = Engine[@"hash_2B8DE256555CACF5"]( f203_local3, f203_arg3, f203_arg4 ) == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
		local f203_local8 = nil
		if f203_local6 then
			f203_local8 = LUI.splitString( f203_local6, " " )
		end
		if f203_local4 then
			for f203_local9 = 0, #f203_local4 - 1, 1 do
				local f203_local12 = f203_local4[f203_local9]:get()
				if f203_local12 > CoD.CACUtility.EmptyItemIndex and f203_local12 ~= f203_arg3 then
					if not Engine[@"areattachmentscompatible"]( f203_local3, f203_arg3, f203_local12, f203_arg4 ) then
						table.insert( f203_local5, {
							ref = Engine[@"getattachmentref"]( f203_local3, f203_local12, f203_arg4 ),
							attachmentIndex = f203_local12
						} )
					end
					if f203_local6 then
						local f203_local13 = Engine[@"getattachmentref"]( f203_local3, f203_local12, f203_arg4 )
						local f203_local14 = Engine[@"hash_2B8DE256555CACF5"]( f203_local3, f203_local12, f203_arg4 ) == Enum[@"eattachmentgroup"][@"hash_26EE211053211305"]
						local f203_local15 = f203_local12
						if f203_local7 or f203_local14 then
							if f203_local14 then
								f203_local13 = Engine[@"getattachmentref"]( f203_local3, f203_arg3, f203_arg4 )
								f203_local15 = f203_arg3
							end
							for f203_local19, f203_local20 in ipairs( f203_local8 ) do
								if f203_local20 == f203_local13 then
									table.insert( f203_local5, {
										ref = f203_local13,
										attachmentIndex = f203_local15
									} )
								end
							end
						end
					end
				end
			end
		end
		return f203_local5
	else
		
	end
end
CoD.CACUtility.GetUsedAllocation = function ( f204_arg0, f204_arg1, f204_arg2 )
	local f204_local0 = 0
	local f204_local1 = Engine[@"getcustomclasscacroot"]( f204_arg0, f204_arg1, f204_arg2 )
	for f204_local7, f204_local8 in ipairs( CoDLoadoutsShared.loadoutSlotNames[f204_arg2] ) do
		local f204_local5 = nil
		local f204_local9 = LUI.splitString( f204_local8.name, "." )
		if #f204_local9 >= 2 then
			f204_local5 = f204_local1[f204_local9[1]][f204_local9[2] - 1]
		else
			f204_local5 = f204_local1[f204_local8.name]
		end
		if f204_local5 then
			local f204_local6 = CoD.CACUtility.EmptyItemIndex
			if f204_local5.itemIndex then
				f204_local6 = f204_local5.itemIndex:get()
			else
				f204_local6 = f204_local5:get()
			end
			if f204_local8.quantityType then
				if f204_local6 > CoD.CACUtility.EmptyItemIndex then
					f204_local0 = f204_local0 + 1
				end
			end
			f204_local0 = f204_local0 + Engine[@"getitemallocationcost"]( f204_local6, f204_local8.statIndexOffset, f204_arg2 )
		end
	end
	f204_local2 = function ( f205_arg0 )
		local f205_local0 = f204_local1[f205_arg0]
		local f205_local1 = f205_local0.itemIndex:get()
		for f205_local2 = 1, #f205_local0.attachment, 1 do
			f204_local0 = f204_local0 + Engine[@"getattachmentallocationcost"]( Engine[@"getitemattachment"]( f205_local1, f205_local0.attachment[f205_local2 - 1]:get(), f204_arg2 ) )
		end
	end
	
	f204_local2( "primary" )
	f204_local2( "secondary" )
	return f204_local0
end
CoD.CACUtility.GetMaxAllocation = function ( f206_arg0 )
	local f206_local0 = Engine[@"getmaxallocation"]( f206_arg0 )
	if f206_local0 > CoDLoadoutsShared.MaxAllocation and not IsCustomLobby() then
		f206_local0 = CoDLoadoutsShared.MaxAllocation
	end
	return f206_local0
end
CoD.CACUtility.GetLastSelectedLoadoutState = function ( f207_arg0, f207_arg1 )
	local f207_local0 = Engine[@"storagegetbuffer"]( f207_arg0, Enum[@"storagefiletype"][@"storage_common_settings"] )
	if f207_local0 then
		if IsLobbyNetworkModeLAN() then
			if f207_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
				return f207_local0[@"hash_3DB455FA658B331D"]
			elseif f207_arg1 == Enum[@"emodes"][@"mode_zombies"] then
				return f207_local0[@"hash_5969FE3983970BC9"][Engine[@"hash_6BBE3328FE08B8C7"]()]
			end
		elseif f207_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
			if Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_matchmaking_playlist"] ) then
				return f207_local0[@"hash_2E2485ECD868DC8C"]
			elseif Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_matchmaking_manual"] ) then
				return f207_local0[@"hash_7CBB56AD27125D0A"]
			else
				return f207_local0[@"hash_22ECD45414EE94FC"]
			end
		elseif f207_arg1 == Enum[@"emodes"][@"mode_zombies"] then
			if Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_matchmaking_playlist"] ) then
				return f207_local0[@"hash_4E39A74D8939A41D"][Engine[@"hash_6BBE3328FE08B8C7"]()]
			else
				return f207_local0[@"hash_7592D7220605B41D"][Engine[@"hash_6BBE3328FE08B8C7"]()]
			end
		end
	end
	return nil
end
CoD.CACUtility.SetSelectedCustomClass = function ( f208_arg0, f208_arg1, f208_arg2 )
	local f208_local0 = CoD.CACUtility.GetLastSelectedLoadoutState( f208_arg0, f208_arg1 )
	if f208_local0 then
		f208_local0:set( f208_arg2 )
	end
	local f208_local1 = Engine[@"getmodelforcontroller"]( f208_arg0 )
	local f208_local2 = f208_local1:create( "selectedCustomClass" )
	f208_local2:set( f208_arg2 )
	if f208_arg1 == Enum[@"emodes"][@"mode_zombies"] and CoD.ZMLoadoutUtility then
		CoD.ZMLoadoutUtility.SetEquippedClass( f208_arg0, f208_arg2 )
	end
end
CoD.CACUtility.UpdateLastSelectLoadoutState = function ( f209_arg0 )
	local f209_local0 = Engine[@"currentsessionmode"]()
	if f209_local0 == Enum[@"emodes"][@"mode_zombies"] then
		local f209_local1 = CoD.CACUtility.GetLastSelectedLoadoutState( f209_arg0, f209_local0 )
		if f209_local1 then
			local f209_local2 = CoD.ZMLoadoutUtility.GetLoadoutStorageBuffer( f209_arg0 )
			if f209_local2 then
				local f209_local3 = f209_local2.cacLoadouts
				if f209_local3 then
					local f209_local4 = f209_local3[Engine[@"hash_6BBE3328FE08B8C7"]()]
					if f209_local4 then
						local f209_local5 = f209_local4[@"hash_78E9CEF0ED273BD"]
						if f209_local5 then
							f209_local1:set( f209_local5:get() )
						end
					end
				end
			end
		end
	end
end
CoD.CACUtility.GetSelectedCustomClass = function ( f210_arg0, f210_arg1 )
	local f210_local0 = CoD.CACUtility.GetLastSelectedLoadoutState( f210_arg0, f210_arg1 )
	if f210_local0 then
		return f210_local0:get()
	else
		return 0
	end
end
CoD.CACUtility.GetCustomClassCount = function ( f211_arg0, f211_arg1 )
	if (Dvar[@"hash_4B2B2EC13351CADB"]:get() == true or Dvar[@"hash_4B2B2EC13351CADB"]:get() == 1) and IsArenaMode() then
		return Enum[@"loadoutclass_t"][@"custom_class_count"]
	else
		return Engine[@"getcustomclasscount"]( f211_arg0, f211_arg1 )
	end
end
CoD.CACUtility.SelectCustomClass = function ( f212_arg0, f212_arg1 )
	local f212_local0 = f212_arg1:getModel()
	f212_local0 = f212_local0.classNum:get()
	CoD.CACUtility.SetSelectedCustomClass( f212_arg0, Engine[@"currentsessionmode"](), f212_local0 )
	Engine[@"streamsetcustomclass"]( f212_arg0, f212_local0 )
end
CoD.CACUtility.InitSelectedCustomClassModel = function ( f213_arg0 )
	CoD.CACUtility.UpdateLastSelectLoadoutState( f213_arg0 )
	local f213_local0 = CoD.CACUtility.GetSelectedCustomClass( f213_arg0, Engine[@"currentsessionmode"]() )
	local f213_local1 = Engine[@"getmodelforcontroller"]( f213_arg0 )
	local f213_local2 = f213_local1:create( "selectedCustomClass" )
	f213_local2:set( f213_local0 )
end
CoD.CACUtility.GetItemGroupDisplayNameFromEnum = function ( f214_arg0 )
	for f214_local3, f214_local4 in ipairs( CoD.CACUtility.ItemGroupInfo ) do
		if f214_local4.itemGroupEnum == f214_arg0 then
			return f214_local4.name
		end
	end
end
CoD.CACUtility.GetItemGroupDisplayNameFromRef = function ( f215_arg0 )
	for f215_local3, f215_local4 in ipairs( CoD.CACUtility.ItemGroupInfo ) do
		if f215_local4.itemGroup == f215_arg0 then
			return f215_local4.name
		end
	end
end
CoD.CACUtility.GetLoadoutSlotIndexForRef = function ( f216_arg0 )
	for f216_local3, f216_local4 in ipairs( CoD.CACUtility.loadoutSlotInfo ) do
		if f216_local4.loadoutSlot == f216_arg0 then
			return f216_local4.loadoutSlotEnum
		end
	end
end
CoD.CACUtility.GetLoadoutSlotStringForRef = function ( f217_arg0 )
	for f217_local3, f217_local4 in ipairs( CoD.CACUtility.loadoutSlotInfo ) do
		if f217_local4.loadoutSlot == f217_arg0 then
			return f217_local4.name
		end
	end
end
CoD.CACUtility.IsProgressionEnabled = function ( f218_arg0 )
	if (f218_arg0 == Enum[@"emodes"][@"mode_multiplayer"] or f218_arg0 == Enum[@"emodes"][@"mode_zombies"]) and IsLive() and not Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_matchmaking_manual"] ) and not Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"hash_27B5630CD29180CB"] ) then
		return true
	else
		return false
	end
end
CoD.CACUtility.IsProgressionWithWarzoneEnabled = function ( f219_arg0 )
	if (f219_arg0 == Enum[@"emodes"][@"mode_multiplayer"] or f219_arg0 == Enum[@"emodes"][@"mode_zombies"] or f219_arg0 == Enum[@"emodes"][@"mode_warzone"]) and IsLive() and not Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_matchmaking_manual"] ) and not Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"hash_27B5630CD29180CB"] ) then
		return true
	else
		return false
	end
end
CoD.CACUtility.GetLoadoutListForSlot = function ( f220_arg0 )
	if LUI.startswith( f220_arg0, "primary.attachment" ) then
		return CoD.CACUtility.PrimaryAttachmentSlotNameList
	elseif LUI.startswith( f220_arg0, "secondary.attachment" ) then
		return CoD.CACUtility.SecondaryAttachmentSlotNameList
	elseif LUI.startswith( f220_arg0, "talent" ) then
		return CoD.CACUtility.TalentSlotNameList
	elseif LUI.startswith( f220_arg0, "bonuscard" ) then
		return CoD.CACUtility.BonuscardSlotNameList
	elseif LUI.startswith( f220_arg0, CoD.CACUtility.talismanLoadoutSlot ) then
		return CoD.CACUtility.TalismanSlotNameList
	else
		return {}
	end
end
CoD.CACUtility.GetSpecialistEquipmentForSpecialistIndex = function ( f221_arg0, f221_arg1 )
	local f221_local0 = Engine[@"getmodelforcontroller"]( f221_arg0 )
	f221_local0 = f221_local0.PositionLoadoutList
	local f221_local1 = CoD.PlayerRoleUtility.GetFirstHeroFromHeroListForMode( f221_arg1 )
	if f221_local0 and f221_local0.SelectedCharacterIndex then
		f221_local1 = f221_local0.SelectedCharacterIndex:get()
	end
	if f221_local1 then
		local f221_local2 = Engine[@"getpositionroledefaultloadout"]( f221_arg1, f221_local1 )
		return f221_local2.primarygrenade and f221_local2.primarygrenade.refHash or 0x0
	else
		
	end
end
CoD.CACUtility.GetLoadoutListItemUnequipSound = function ( f222_arg0 )
	local f222_local0 = f222_arg0:getModel()
	local f222_local1 = nil
	if f222_local0 and f222_local0.loadoutListItem then
		local f222_local2 = f222_local0.loadoutListItem:get()
		if f222_local2 and f222_local2.unequipSound then
			f222_local1 = f222_local2.unequipSound:get()
		end
	end
	return f222_local1
end
CoD.CACUtility.GetTalentGearXModel = function ( f223_arg0, f223_arg1 )
	if CoD.CACUtility.EmptyItemIndex < f223_arg0 then
		return Engine[@"converttoxhash"]( "c_t8_mp_spe_cac_" .. Engine[@"getitemref"]( f223_arg0, Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"], f223_arg1 ) )
	else
		return 0x0
	end
end
CoD.CACUtility.GetPerkTalentXModel = function ( f224_arg0, f224_arg1 )
	return 0x0
end
CoD.CACUtility.GetBonuscardXModel = function ( f225_arg0, f225_arg1 )
	return 0x0
end
CoD.CACUtility.WeaponPersonalizationUpdated = function ( f226_arg0 )
	local f226_local0 = Engine[@"getmodelforcontroller"]( f226_arg0 )
	f226_local0["CustomClassList.weaponPersonalizationUpdated"].set( f226_local0["CustomClassList.weaponPersonalizationUpdated"], true )
end
CoD.CACUtility.UpdateCustomClassModelIfModified = function ( f227_arg0, f227_arg1 )
	local f227_local0 = CoD.BaseUtility.GetMenuSessionMode( f227_arg0 )
	if f227_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		local f227_local1 = Engine[@"getmodelforcontroller"]( f227_arg1 )
		f227_local1 = f227_local1["CustomClassList.weaponPersonalizationUpdated"]
		if f227_local1 and f227_local1:get() then
			f227_local1:set( false )
			local f227_local2 = CoD.BaseUtility.GetMenuModel( f227_arg0 )
			if f227_local2 then
				CoD.CACUtility.GetCustomClassModel( f227_arg1, f227_local2.classNum:get(), f227_local2, nil, f227_local0 )
			end
		end
	end
end
CoD.CACUtility.UpdateTempLargeImage = function ( f228_arg0, f228_arg1, f228_arg2 )
	if f228_arg1 then
		if f228_arg2 == "primarygrenade" and f228_arg1[f228_arg2].refHash:get() == CoDShared.DefaultSpecialistEquipment then
			f228_arg1.showSpecialistEquipmentWidgetModel:set( true )
		else
			f228_arg1.showSpecialistEquipmentWidgetModel:set( false )
		end
		if f228_arg1.tempLargeImageForModel then
			local f228_local0 = nil
			if LUI.startswith( f228_arg2, "talent" ) or LUI.startswith( f228_arg2, "bonuscard" ) then
				f228_local0 = f228_arg1[f228_arg2].imageLarge and f228_arg1[f228_arg2].imageLarge:get()
			end
			if not f228_local0 then
				f228_local0 = RegisterImage( @"blacktransparent" )
			end
			f228_arg1.tempLargeImageForModel:set( f228_local0 )
			f228_arg1.tempLargeImageForModel:forceNotifySubscriptions()
		end
	end
end
CoD.CACUtility.UpdateWeaponModelHelper = function ( f229_arg0, f229_arg1, f229_arg2, f229_arg3, f229_arg4, f229_arg5, f229_arg6, f229_arg7 )
	local f229_local0, f229_local1 = nil
	local f229_local2 = ""
	local f229_local3 = 1
	if f229_arg3 == "primary" or f229_arg3 == "secondary" then
		f229_local0, f229_local2 = CoD.CACUtility.GetWeaponNameHashAndAttachmentsForXcam( f229_arg1, f229_arg2, f229_arg3, nil, f229_arg5, f229_arg4, nil )
		if f229_arg6 == false then
			f229_local2 = ""
		end
	elseif LUI.startswith( f229_arg3, "primarygrenade" ) then
		if f229_arg3 == "primarygrenadecount" and f229_arg4 > CoD.CACUtility.EmptyItemIndex then
			f229_arg4 = f229_arg2.primarygrenade.itemIndex:get()
		end
		f229_local0 = Engine[@"hash_7B98952F69D937F9"]( f229_arg4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f229_arg5 )
		if f229_arg5 == Enum[@"emodes"][@"mode_multiplayer"] then
			if f229_local0 == CoDShared.DefaultSpecialistEquipment then
				f229_local0 = 0x0
				if IsCurrentMenu( f229_arg0, "SpecialistEquipmentSelect" ) then
					f229_local0 = CoD.CACUtility.GetSpecialistEquipmentForSpecialistIndex( f229_arg1, f229_arg5 )
				end
			end
		elseif f229_arg5 == Enum[@"emodes"][@"mode_zombies"] then
			local f229_local4 = CoD.CACUtility.GetUnlockableItemInfo( f229_arg4, f229_arg5 )
			if f229_local4 and f229_local4[@"hash_5550F6A3B55C35"] then
				f229_local1 = f229_local4[@"hash_5550F6A3B55C35"]
				f229_local3 = f229_local4[@"previewmodelscale"] or 1
			end
		end
	elseif f229_arg3 == "herogadget" then
		f229_local0 = Engine[@"hash_7B98952F69D937F9"]( f229_arg4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f229_arg5 )
	elseif f229_arg3 == "tacticalgear" then
		f229_local0 = CoD.CACUtility.GetTalentGearXModel( f229_arg4, f229_arg5 )
	elseif LUI.startswith( f229_arg3, "talent" ) then
		f229_local0 = CoD.CACUtility.GetPerkTalentXModel( f229_arg4, f229_arg5 )
	elseif LUI.startswith( f229_arg3, "bonuscard" ) then
		f229_local0 = CoD.CACUtility.GetBonuscardXModel( f229_arg4, f229_arg5 )
	end
	if not IsInGame() and f229_local0 then
		local f229_local4 = CoD.CACUtility.EmptyWeaponOptions()
		if f229_arg6 then
			if f229_arg5 ~= Enum[@"emodes"][@"mode_zombies"] then
				f229_local4 = CoD.CACUtility.GetWeaponOptionsFromClass( f229_arg1, f229_arg2, f229_arg3 )
			else
				f229_local4 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable( CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex( f229_arg1, f229_arg4 ) )
			end
		elseif f229_arg7 then
			f229_local4 = CoD.CACUtility.GetSignatureWeaponOptionsHelper( f229_arg1, f229_arg7, f229_arg4, f229_arg5 )
		end
		if IsBooleanDvarSet( "ui_enableCACScene" ) then
			CoD.CACUtility.SendCACSceneWeaponUpdate( f229_arg1, f229_arg3, f229_local0, f229_local2 )
		else
			Engine[@"sendclientscriptnotify"]( f229_arg1, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum( f229_arg1 ), {
				base_weapon_slot = f229_arg3,
				weapon = f229_local0,
				attachments = f229_local2,
				camera = "select01",
				options = f229_local4,
				xmodel_name = f229_local1,
				xmodel_scale = f229_local3
			} )
		end
	end
	CoD.CACUtility.UpdateTempLargeImage( f229_arg0, f229_arg2, f229_arg3 )
end
CoD.CACUtility.UpdateWeaponModel = function ( f230_arg0, f230_arg1, f230_arg2 )
	local f230_local0 = CoD.BaseUtility.GetMenuLoadoutSlot( f230_arg0 )
	local f230_local1 = CoD.BaseUtility.GetMenuModel( f230_arg0 )
	local f230_local2 = CoD.BaseUtility.GetMenuSessionMode( f230_arg0 )
	if not f230_local1 or LUI.startswith( f230_local0, "bonuscard" ) then
		return 
	elseif CoD.ZMLoadoutUtility and f230_local0 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
		f230_local0 = "primary"
	end
	local f230_local3 = nil
	local f230_local4 = f230_arg1:getModel()
	if f230_local4 and f230_local4.itemIndex then
		f230_local3 = f230_local4.itemIndex:get()
	end
	if not f230_local3 then
		local f230_local5 = f230_local1[f230_local0].itemIndex
		if f230_local5 then
			local f230_local6 = f230_local5:get()
		end
		f230_local3 = f230_local6 or CoD.CACUtility.EmptyItemIndex
	end
	local f230_local5 = nil
	if f230_local4 and f230_local4.useVariantSlot and f230_local4.useVariantSlot:get() > 0 then
		f230_local5 = f230_local4.useVariantSlot:get()
	end
	if f230_local4 and f230_local4.weaponModelSlot and f230_local4.weaponModelSlot:get() > 0 then
		f230_local5 = f230_local4.weaponModelSlot:get()
	end
	CoD.CACUtility.UpdateWeaponModelHelper( f230_arg0, f230_arg2, f230_local1, f230_local0, f230_local3, f230_local2, false, f230_local5 )
end
CoD.CACUtility.GetSlotAndItemIndexFromModel = function ( f231_arg0 )
	local f231_local0, f231_local1 = nil
	if f231_arg0 then
		if f231_arg0.baseWeaponSlotModel then
			local f231_local2 = f231_arg0.baseWeaponSlotModel:get()
			f231_local0 = f231_local2.weaponSlot:get()
			f231_local1 = f231_local2.itemIndex:get()
		elseif f231_arg0.loadoutListItem then
			local f231_local2 = f231_arg0.loadoutListItem:get()
			f231_local0 = f231_local2.weaponSlot:get()
			f231_local1 = f231_local2.itemIndex:get()
		elseif f231_arg0.weaponSlot then
			f231_local0 = f231_arg0.weaponSlot:get()
			f231_local1 = f231_arg0.itemIndex:get()
		end
	end
	return f231_local0, f231_local1
end
CoD.CACUtility.GetClassWeaponModelDefaultSlotAndItemIndex = function ( f232_arg0 )
	local f232_local0, f232_local1 = nil
	if f232_arg0 then
		f232_local0 = "primary"
		f232_local1 = f232_arg0[f232_local0].itemIndex:get()
		if f232_local1 == CoD.CACUtility.EmptyItemIndex then
			f232_local0 = "secondary"
			f232_local1 = f232_arg0[f232_local0].itemIndex:get()
		end
	end
	return f232_local0, f232_local1
end
CoD.CACUtility.UpdateClassWeaponModel = function ( f233_arg0, f233_arg1, f233_arg2 )
	if CoD.BaseUtility.IsMenuSessionModeEqualTo( f233_arg0, Enum[@"emodes"][@"mode_zombies"] ) then
		return 
	end
	local f233_local0, f233_local1, f233_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f233_arg0 )
	local f233_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f233_arg0 )
	local f233_local4 = f233_arg1:getModel()
	local f233_local5 = nil
	local f233_local6 = 0x0
	local f233_local7 = ""
	local f233_local8 = nil
	f233_local5, f233_local8 = CoD.CACUtility.GetSlotAndItemIndexFromModel( f233_local4 )
	if not f233_local5 then
		if f233_local2 and f233_local0[f233_local2] and f233_local0[f233_local2].itemIndex then
			f233_local5 = f233_local2
			f233_local8 = f233_local0[f233_local5].itemIndex:get()
		elseif f233_local3 and f233_local0[f233_local3] and f233_local0[f233_local3].itemIndex then
			f233_local5 = f233_local3
			f233_local8 = f233_local0[f233_local5].itemIndex:get()
		end
	end
	if not f233_local5 and CoD.GetMouseFocus( f233_arg2 ) and CoD.isPC then
		local f233_local9 = CoD.GetMouseFocus( f233_arg2 )
		f233_local5, f233_local8 = CoD.CACUtility.GetSlotAndItemIndexFromModel( f233_local9:getModel() )
	end
	if not f233_local5 then
		if CoD.isPC then
			f233_local5, f233_local8 = CoD.CACUtility.GetClassWeaponModelDefaultSlotAndItemIndex( f233_local0 )
		else
			f233_local5 = f233_arg0.__lastUpdateWeaponModelSlot
			if f233_local0[f233_local5] then
				local f233_local10 = f233_local0[f233_local5].itemIndex:get()
			end
			f233_local8 = f233_local10 or CoD.CACUtility.EmptyItemIndex
		end
	end
	if f233_local5 and f233_local5 ~= "" then
		f233_arg0.__lastUpdateWeaponModelSlot = f233_local5
	end
	if f233_arg0.__classWeaponModelTimer then
		f233_arg0.__classWeaponModelTimer:close()
		f233_arg0.__classWeaponModelTimer = nil
	end
	if f233_local4 then
		local f233_local9 = f233_local0.isRestricted
		local f233_local11 = f233_local9
		f233_local9 = f233_local9.set
		if f233_local4 then
			local f233_local12 = f233_local4.isRestricted
			local f233_local13 = f233_local4.isRestricted:get()
		end
		f233_local9( f233_local11, f233_local12 and f233_local13 or false )
	end
	CoD.CACUtility.UpdateWeaponModelHelper( f233_arg0, f233_arg2, f233_local0, f233_local5, f233_local8, f233_local1, true )
end
CoD.CACUtility.DelayedUpdateClassWeaponModel = function ( f234_arg0, f234_arg1, f234_arg2, f234_arg3 )
	if f234_arg0.__classWeaponModelTimer then
		f234_arg0.__classWeaponModelTimer:close()
	end
	f234_arg0.__classWeaponModelTimer = LUI.UITimer.newElementTimer( f234_arg3, true, function ()
		f234_arg0:removeElement( f234_arg0.__classWeaponModelTimer )
		f234_arg0.__classWeaponModelTimer = nil
		CoD.CACUtility.UpdateClassWeaponModel( f234_arg0, f234_arg1, f234_arg2 )
	end )
	f234_arg0:addElement( f234_arg0.__classWeaponModelTimer )
end
CoD.CACUtility.ClearClassWeaponModel = function ( f236_arg0, f236_arg1 )
	local f236_local0 = CoD.BaseUtility.GetMenuLoadoutSlot( f236_arg0 )
	if not IsInGame() and f236_local0 then
		Engine[@"sendclientscriptnotify"]( f236_arg1, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum( f236_arg1 ), {
			base_weapon_slot = f236_local0,
			weapon = @"hash_0",
			attachments = "",
			camera = "select01",
			options = CoD.CACUtility.EmptyWeaponOptions(),
			is_item_unlocked = true,
			is_item_tokenlocked = false
		} )
	end
end
CoD.CACUtility.SetClassWeaponModelToDefault = function ( f237_arg0, f237_arg1 )
	if CoD.BaseUtility.IsMenuSessionModeEqualTo( f237_arg0, Enum[@"emodes"][@"mode_zombies"] ) then
		return 
	end
	local f237_local0, f237_local1, f237_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f237_arg0 )
	if f237_local0 then
		if f237_arg0.__classWeaponModelTimer then
			f237_arg0.__classWeaponModelTimer:close()
			f237_arg0.__classWeaponModelTimer = nil
		end
		local f237_local3, f237_local4 = CoD.CACUtility.GetClassWeaponModelDefaultSlotAndItemIndex( f237_local0 )
		f237_local0.isRestricted:set( CoD.CACUtility.IsItemIndexRestricted( f237_local4 ) )
		CoD.CACUtility.UpdateWeaponModelHelper( f237_arg0, f237_arg1, f237_local0, f237_local3, f237_local4, f237_local1, true )
	end
end
CoD.CACUtility.DelayedSetClassWeaponModelToDefault = function ( f238_arg0, f238_arg1, f238_arg2 )
	if f238_arg0.__classWeaponModelTimer then
		f238_arg0.__classWeaponModelTimer:close()
	end
	f238_arg0.__classWeaponModelTimer = LUI.UITimer.newElementTimer( f238_arg2, true, function ()
		f238_arg0:removeElement( f238_arg0.__classWeaponModelTimer )
		f238_arg0.__classWeaponModelTimer = nil
		CoD.CACUtility.SetClassWeaponModelToDefault( f238_arg0, f238_arg1 )
	end )
	f238_arg0:addElement( f238_arg0.__classWeaponModelTimer )
end
CoD.CACUtility.UpdateWeaponAttachmentModel = function ( f240_arg0, f240_arg1, f240_arg2, f240_arg3 )
	local f240_local0, f240_local1, f240_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f240_arg0 )
	local f240_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f240_arg0 )
	local f240_local4 = f240_arg1:getModel()
	local f240_local5 = LUI.splitString( f240_local2, "." )
	if f240_local5[1] and (f240_local5[1] == "primary" or f240_local5[1] == "secondary") then
		f240_local2 = f240_local5[1]
	end
	local f240_local6 = ""
	local f240_local7 = CoD.CACUtility.EmptyItemIndex
	local f240_local8 = CoD.CACUtility.EmptyItemIndex
	if f240_local4 then
		if f240_local4.attachmentRef then
			f240_local6 = f240_local4.attachmentRef:get()
		end
		if f240_arg3 then
			if f240_local4.itemIndex then
				f240_local7 = f240_local4.itemIndex:get()
			end
			if f240_local4.baseAttachmentItemIndex then
				f240_local8 = f240_local4.baseAttachmentItemIndex:get()
			end
		end
	end
	local f240_local9, f240_local10 = CoD.CACUtility.GetWeaponNameHashAndAttachmentsForXcam( f240_arg2, f240_local0, f240_local2, f240_local3, f240_local1, nil, f240_local7 )
	if f240_arg3 then
		if f240_local10 == "" then
			f240_local10 = f240_local6
		else
			f240_local10 = f240_local10 .. "+" .. f240_local6
		end
		if CoD.CACUtility.EmptyItemIndex < f240_local8 then
			f240_local10 = f240_local10 .. "+" .. Engine[@"getattachmentref"]( f240_local0[f240_local2].itemIndex:get(), f240_local8, f240_local1 )
		end
	end
	if not IsInGame() and f240_local9 ~= 0x0 then
		Engine[@"sendclientscriptnotify"]( f240_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum( f240_arg2 ), {
			base_weapon_slot = f240_local2,
			weapon = f240_local9,
			attachments = f240_local10,
			camera = "attach",
			options = CoD.CACUtility.GetWeaponOptionsFromClass( f240_arg2, f240_local0, f240_local2 ),
			is_item_unlocked = true,
			is_item_tokenlocked = false
		} )
	end
end
CoD.CACUtility.UpdateEquipmentModelFromPositionList = function ( f241_arg0, f241_arg1, f241_arg2 )
	local f241_local0 = CoD.BaseUtility.GetMenuLoadoutSlot( f241_arg0 )
	local f241_local1 = CoD.BaseUtility.GetMenuModel( f241_arg0 )
	local f241_local2 = nil
	local f241_local3 = ""
	local f241_local4 = f241_arg1:getModel()
	if f241_local4 and f241_local4.equipment then
		f241_local2 = f241_local4.equipment.refHash:get()
	end
	if not IsInGame() and f241_local2 and f241_local2 ~= 0x0 then
		local f241_local5 = CoD.CACUtility.GetWeaponOptionsFromClass( f241_arg2, f241_local1, f241_local0 )
		local f241_local6 = true
		local f241_local7 = false
		if IsBooleanDvarSet( "ui_enableCACScene" ) then
			CoD.CACUtility.SendCACSceneWeaponUpdate( f241_arg2, f241_local0, f241_local2, f241_local3 )
		else
			Engine[@"sendclientscriptnotify"]( f241_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum( f241_arg2 ), {
				base_weapon_slot = f241_local0,
				weapon = f241_local2,
				attachments = f241_local3,
				camera = "select01",
				options = f241_local5,
				is_item_unlocked = f241_local6,
				is_item_tokenlocked = f241_local7
			} )
		end
	end
end
CoD.CACUtility.AddSpecialistEquipmentBumperNavigation = function ( f242_arg0, f242_arg1, f242_arg2 )
	CoD.GridAndListUtility.AddBumperNavigationInternal( f242_arg0, f242_arg1, f242_arg2, nil, function ()
		return f242_arg1 and f242_arg1:isVisible()
	end )
end
CoD.CACUtility.SetWeaponCategory = function ( f244_arg0, f244_arg1 )
	local f244_local0 = GetWeaponSlotModel( f244_arg0, f244_arg1 )
	if f244_local0 then
		CoD.perController[f244_arg1].weaponCategory = f244_local0
	end
end
CoD.CACUtility.SetWeaponAttachmentItem = function ( f245_arg0, f245_arg1, f245_arg2, f245_arg3, f245_arg4 )
	local f245_local0, f245_local1, f245_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f245_arg0 )
	local f245_local3 = f245_local0.classNum:get()
	if AttemptAttachItem( f245_arg0, f245_arg3, f245_local1, f245_local0, CoD.BaseUtility.GetMenuLoadoutListItemSlot( f245_arg0 ), CoD.SafeGetModelValue( f245_arg2:getModel(), "itemIndex" ), nil ) then
		if f245_arg2.equipSound then
			Engine[@"hash_498954175CA6A32C"]( f245_arg2.equipSound )
		end
		CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadout( f245_arg0, f245_arg3, "" )
		CoD.CACUtility.EquippedItemsChanged( f245_arg0, f245_arg3 )
		if f245_arg4 then
			GoBack( f245_arg0, f245_arg3 )
		end
	end
end
CoD.CACUtility.RemoveAttachmentFromClass = function ( f246_arg0, f246_arg1, f246_arg2, f246_arg3 )
	local f246_local0 = CoD.BaseUtility.GetMenuSessionMode( f246_arg1 )
	local f246_local1 = CoD.BaseUtility.GetMenuModel( f246_arg1 )
	local f246_local2 = f246_local1.classNum:get()
	local f246_local3 = f246_arg0:getModel()
	local f246_local4 = CoD.CACUtility.EmptyItemIndex
	local f246_local5 = CoD.CACUtility.GetAttachmentListForSlot( f246_arg3 )
	if f246_local3 and f246_local3.loadoutListItem then
		local f246_local6 = f246_local3.loadoutListItem:get()
		if f246_local6 and f246_local6.itemIndex then
			f246_local4 = f246_local6.itemIndex:get()
		end
	end
	local f246_local6 = CoD.CACUtility.GetLoadoutListItemUnequipSound( f246_arg0 )
	if CoD.CACUtility.RemoveAttachmentFromClassHelper( f246_arg2, f246_local1, f246_local4, f246_local5, f246_local0 ) then
		if f246_local6 then
			Engine[@"hash_498954175CA6A32C"]( f246_local6 )
		end
		CoD.CACUtility.GetCustomClassModel( f246_arg2, f246_local2, f246_local1, nil, f246_local0 )
		CoD.CACUtility.EquippedItemsChanged( f246_arg1, f246_arg2 )
	end
end
CoD.CACUtility.RemoveAttachmentFromClassForMenuWeaponSlot = function ( f247_arg0, f247_arg1, f247_arg2 )
	local f247_local0 = CoD.BaseUtility.GetMenuLoadoutSlot( f247_arg1 )
	local f247_local1 = CoD.BaseUtility.GetMenuModel( f247_arg1 )
	local f247_local2 = f247_local1.classNum:get()
	local f247_local3 = CoD.BaseUtility.GetMenuSessionMode( f247_arg1 )
	if CoD.CACUtility.RemoveAttachmentFromClassHelper( f247_arg2, f247_local1, CoD.SafeGetModelValue( f247_arg0:getModel(), "itemIndex" ), CoD.CACUtility.GetAttachmentListForSlot( f247_local0 ), f247_local3 ) then
		f247_arg0:playSound( "unequip_item" )
		CoD.CACUtility.GetCustomClassModel( f247_arg2, f247_local2, f247_local1, nil, f247_local3 )
	end
end
CoD.CACUtility.RemoveAllAttachmentsHelper = function ( f248_arg0, f248_arg1, f248_arg2, f248_arg3 )
	local f248_local0 = {}
	if f248_arg2 == "primary" then
		f248_local0 = CoD.CACUtility.PrimaryAttachmentSlotNameList
	elseif f248_arg2 == "secondary" then
		f248_local0 = CoD.CACUtility.SecondaryAttachmentSlotNameList
	end
	for f248_local4, f248_local5 in ipairs( f248_local0 ) do
		CoD.CACUtility.SetClassItem( f248_arg0, f248_arg1, f248_local5, CoD.CACUtility.EmptyItemIndex, nil, f248_arg3 )
	end
end
CoD.CACUtility.RemoveAllAttachmentsFromClass = function ( f249_arg0, f249_arg1 )
	local f249_local0 = CoD.BaseUtility.GetMenuModel( f249_arg0 )
	local f249_local1 = f249_local0.classNum:get()
	local f249_local2 = CoD.BaseUtility.GetMenuLoadoutSlot( f249_arg0 )
	local f249_local3 = CoD.BaseUtility.GetMenuSessionMode( f249_arg0 )
	CoD.CACUtility.RemoveAllAttachmentsHelper( f249_arg1, f249_local1, f249_local2, f249_local3 )
	CoD.CACUtility.GetCustomClassModel( f249_arg1, f249_local1, f249_local0, nil, f249_local3 )
	CoD.CACUtility.EquippedItemsChanged( f249_arg0, f249_arg1 )
end
CoD.CACUtility.EquippedItemsChanged = function ( f250_arg0, f250_arg1 )
	local f250_local0 = Engine[@"getmodelforcontroller"]( f250_arg1 )
	local f250_local1 = f250_local0:create( "CustomClassList.equippedItemsChanged" )
	f250_local1:forceNotifySubscriptions()
end
CoD.CACUtility.UpdateClassAttachmentsForItemChanged = function ( f251_arg0, f251_arg1 )
	local f251_local0 = CoD.BaseUtility.GetMenuModel( f251_arg0 )
	local f251_local1 = CoD.BaseUtility.GetMenuLoadoutSlot( f251_arg0 )
	if f251_local0 and (f251_local1 == "primary" or f251_local1 == "secondary") then
		f251_local0[f251_local1].equippedItemsChanged:forceNotifySubscriptions()
	end
end
CoD.CACUtility.SetPerControllerClassNumFromCharacterIndex = function ( f252_arg0 )
	CoD.perController[f252_arg0].classNum = Engine[@"getpositionrolecustomclassindex"]( Engine[@"currentsessionmode"](), Engine[@"getcharacterindexforclientnum"]( f252_arg0, Engine[@"getclientnum"]( f252_arg0 ) ) )
end
CoD.CACUtility.UpdateActiveAttachmentSlot = function ( f253_arg0, f253_arg1, f253_arg2, f253_arg3 )
	SetPerControllerTableProperty( f253_arg3, "attachmentSlot", f253_arg2.attachmentSlotName )
	local f253_local0 = Engine[@"getmodelforcontroller"]( f253_arg3 )
	f253_local0 = f253_local0:create( "focusSlotGunfighterType" )
	f253_local0:set( f253_arg2.gunfighterType )
	f253_local0 = f253_arg0:getModel()
	if f253_local0 and f253_arg2.slotIndex then
		if f253_local0.activeAttachmentSlotIndex then
			f253_local0.activeAttachmentSlotIndex:set( f253_arg2.slotIndex )
		end
		local f253_local1 = CoD.SafeGetModelValue( f253_arg2:getModel(), "attachmentSlot" )
		if f253_local0.activeAttachmentSlotModel and f253_local1 then
			f253_local0.activeAttachmentSlotModel:set( f253_local1 )
		end
	end
end
CoD.CACUtility.UpdateButtonPromptStatesForListSlots = function ( f254_arg0, f254_arg1, f254_arg2 )
	UpdateButtonPromptState( f254_arg0, f254_arg1, f254_arg2, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
	UpdateButtonPromptState( f254_arg0, f254_arg1, f254_arg2, Enum[@"luibutton"][@"lui_key_xbx_pssquare"] )
	if CoD.isPC then
		UpdateButtonPromptState( f254_arg0, f254_arg1, f254_arg2, Enum[@"luibutton"][@"lui_key_ltrig"] )
	end
end
CoD.CACUtility.UpdateItemListSlotSetupContext = function ( f255_arg0, f255_arg1 )
	local f255_local0 = f255_arg0:getModel()
	if f255_local0 and f255_local0.contextWidgetModel then
		DataSources.FreeCursor.setupContext( f255_arg1, f255_local0.contextWidgetModel:get() )
	end
	if CoD.isPC then
		local f255_local1 = DataSources.FreeCursor.getModel( f255_arg1 )
		CoD.FreeCursorUtility.UpdateSetupContext( f255_arg0, f255_arg1 )
	end
end
CoD.CACUtility.UpdateClassModelWeaponIfPrimary = function ( f256_arg0, f256_arg1 )
	local f256_local0 = f256_arg0:getModel( f256_arg1, "weapon" )
	if f256_local0 then
		f256_local0 = f256_local0:get()
	end
	if f256_local0 and f256_local0.itemIndex then
		local f256_local1 = f256_local0.weaponSlot
		if f256_local1 and f256_local1:get() == "primary" then
			Engine[@"forcenotifymodelsubscriptions"]( f256_local0.itemIndex )
		end
	end
end
CoD.CACUtility.SetActiveListItemToSelectedClass = function ( f257_arg0, f257_arg1, f257_arg2 )
	local f257_local0 = CoD.BaseUtility.GetMenuSessionMode( f257_arg1 )
	if not f257_local0 then
		f257_local0 = Engine[@"currentsessionmode"]()
	end
	local f257_local1 = CoD.CACUtility.GetSelectedCustomClass( f257_arg0, f257_local0 )
	if f257_local1 then
		f257_arg2:findItem( {
			classNum = f257_local1
		}, nil, true, false )
	end
end
CoD.CACUtility.SendCACSceneWeaponUpdate = function ( f258_arg0, f258_arg1, f258_arg2, f258_arg3 )
	if IsBooleanDvarSet( "ui_enableCACScene" ) then
		Engine[@"sendclientscriptnotify"]( f258_arg0, "cac_scene_update", {
			type = "update_weapon",
			slot = f258_arg1,
			weaponNameHash = f258_arg2,
			attachments = f258_arg3
		} )
	end
end
CoD.CACUtility.SendCACSceneUpdatePrimaryWeapon = function ( f259_arg0, f259_arg1, f259_arg2 )
	local f259_local0 = f259_arg1[@"itemindex"]:get()
	local f259_local1 = Engine[@"hash_7B98952F69D937F9"]( f259_local0 )
	local f259_local2 = ""
	if f259_local0 ~= 0 then
		for f259_local6, f259_local7 in DDLUtils.ipairs( f259_arg1.attachment ) do
			local f259_local8 = f259_local7:get()
			if f259_local8 ~= 0 then
				if f259_local2 ~= "" then
					f259_local2 = f259_local2 .. "+"
				end
				f259_local2 = f259_local2 .. Engine[@"getattachmentref"]( f259_local0, f259_local8, f259_arg2 )
			end
		end
	end
	CoD.CACUtility.SendCACSceneWeaponUpdate( f259_arg0, "primary", f259_local1, f259_local2 )
end
CoD.CACUtility.SendCACSceneUpdateSecondaryWeapon = function ( f260_arg0, f260_arg1, f260_arg2 )
	local f260_local0 = f260_arg1[@"itemindex"]:get()
	local f260_local1 = Engine[@"hash_7B98952F69D937F9"]( f260_local0 )
	local f260_local2 = ""
	if f260_local0 ~= 0 then
		for f260_local6, f260_local7 in DDLUtils.ipairs( f260_arg1.attachment ) do
			local f260_local8 = f260_local7:get()
			if f260_local8 ~= 0 then
				if f260_local2 ~= "" then
					f260_local2 = f260_local2 .. "+"
				end
				f260_local2 = f260_local2 .. Engine[@"getattachmentref"]( f260_local0, f260_local8, f260_arg2 )
			end
		end
	end
	CoD.CACUtility.SendCACSceneWeaponUpdate( f260_arg0, "secondary", f260_local1, f260_local2 )
end
CoD.CACUtility.UpdateSelectedCustomClass = function ( f261_arg0, f261_arg1, f261_arg2 )
	local f261_local0 = CoD.BaseUtility.GetMenuSessionMode( f261_arg0 )
	local f261_local1 = f261_arg2:getModel()
	f261_local1 = f261_local1.classNum:get()
	CoD.CACUtility.SetSelectedCustomClass( f261_arg1, f261_local0, f261_local1 )
	CoD.CACUtility.UpdateCACSceneForMode( f261_arg1, f261_arg0 )
	Engine[@"streamsetcustomclass"]( f261_arg1, f261_local1 )
end
CoD.CACUtility.UpdateLockedStateForCustomClass = function ( f262_arg0, f262_arg1 )
	if CoD.CACUtility.IsCurrentClassLocked( f262_arg0, f262_arg1 ) then
		MenuHidesFreeCursor( f262_arg0, f262_arg1 )
		if not CoD.isPC or not IsKeyboard( f262_arg1 ) then
			ClearRecordedFocus( f262_arg0, f262_arg1 )
		end
		f262_arg0.m_disableNavigation = true
		if f262_arg0.ChooseClassWidget and f262_arg0.ChooseClassWidget.__defaultFocus then
			DisableDefaultGainFocus( f262_arg0.ChooseClassWidget, f262_arg1 )
		end
	else
		MenuUnhideFreeCursor( f262_arg0, f262_arg1 )
		f262_arg0.m_disableNavigation = false
		if f262_arg0.ChooseClassWidget then
			CoD.FreeCursorUtility.RetriggerCursorPosition( f262_arg0.ChooseClassWidget, f262_arg1 )
		end
	end
end
CoD.CACUtility.UpdateCACSceneForMode = function ( f263_arg0, f263_arg1 )
	if IsBooleanDvarSet( "ui_enableCACScene" ) then
		local f263_local0 = CoD.BaseUtility.GetMenuSessionMode( f263_arg1 )
		if f263_local0 ~= Enum[@"emodes"][@"mode_invalid"] then
			local f263_local1 = Engine[@"getplayerstats"]( f263_arg0, nil, f263_local0 )
			if f263_local1[@"selectedcustomclass"] then
				local f263_local2 = Engine[@"getcustomclasscacroot"]( f263_arg0, f263_local1[@"selectedcustomclass"]:get(), f263_local0 )
				CoD.CACUtility.SendCACSceneUpdatePrimaryWeapon( f263_arg0, f263_local2.primary, f263_local0 )
				CoD.CACUtility.SendCACSceneUpdateSecondaryWeapon( f263_arg0, f263_local2.secondary, f263_local0 )
			end
		end
	end
end
CoD.CACUtility.SetListModelToSelectedClass = function ( f264_arg0, f264_arg1 )
	local f264_local0 = CoD.CACUtility.GetSelectedCustomClass( f264_arg0, Engine[@"currentsessionmode"]() )
	if f264_local0 then
		local f264_local1 = f264_arg1:getItemAtPosition( f264_local0 + 1, 1 )
		if f264_local1 then
			f264_arg1.activeWidget = f264_local1
			f264_arg1:setModel( f264_local1:getModel(), f264_arg0 )
		end
	end
end
CoD.CACUtility.OpenCACOverlay = function ( f265_arg0, f265_arg1, f265_arg2, f265_arg3, f265_arg4, f265_arg5 )
	local f265_local0 = CoD.BaseUtility.GetMenuSessionMode( f265_arg1 )
	local f265_local1 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f265_arg2, f265_local0 )
	local f265_local2 = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer( f265_arg2, f265_local0 )
	if not f265_arg5 or f265_arg5 == "" then
		f265_arg5 = CoD.BaseUtility.GetMenuLoadoutSlot( f265_arg1 ) or "primary"
	end
	return OpenOverlay( f265_arg0, f265_arg3, f265_arg2, {
		_sessionMode = f265_local0,
		_model = f265_arg4:getModel(),
		_loadoutSlot = f265_arg5,
		_storageClientBuffer = f265_local1,
		_storageLoadoutBuffer = f265_local2
	} )
end
CoD.CACUtility.OpenWeaponPersonalizationOverlay = function ( f266_arg0, f266_arg1, f266_arg2, f266_arg3, f266_arg4, f266_arg5 )
	local f266_local0 = "WeaponPersonalization"
	if CoD.SafeGetModelValue( f266_arg4:getModel(), "isMastercraft" ) then
		f266_local0 = "WeaponTabbedAccessoriesSelect"
	end
	CoD.CACUtility.OpenCACOverlay( f266_arg0, f266_arg1, f266_arg2, f266_local0, f266_arg3, f266_arg5 )
end
CoD.CACUtility.OpenCACAttachmentOverlay = function ( f267_arg0, f267_arg1, f267_arg2, f267_arg3, f267_arg4, f267_arg5, f267_arg6 )
	local f267_local0 = CoD.BaseUtility.GetMenuModel( f267_arg2 )
	local f267_local1 = CoD.BaseUtility.GetMenuSessionMode( f267_arg2 )
	local f267_local2 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f267_arg3, f267_local1 )
	local f267_local3 = f267_arg1:getModel()
	local f267_local4 = "attachment"
	local f267_local5 = CoD.SafeGetModelValue( f267_local3, "loadoutSlot" )
	if f267_local1 == Enum[@"emodes"][@"mode_multiplayer"] then
		local f267_local6 = CoD.SafeGetModelValue( f267_local3, "attachmentSlotIndex" )
		local f267_local7 = f267_arg6 and f267_local0 and CoD.BonuscardUtility.IsOperatorModBonuscardEquipped( f267_local0, f267_arg6, f267_local1 )
		if f267_local6 == CoD.CACUtility.OpticSlotIndex then
			f267_local4 = "optic"
		elseif f267_local6 == CoD.CACUtility.UberIndexSlot and f267_local7 then
			f267_local4 = "uber"
		end
	else
		local f267_local6 = f267_local3.attachmentGroup
		if f267_local6 then
			f267_local6 = f267_local3.attachmentGroup:get()
		end
		if f267_local6 == Enum[@"eattachmentgroup"][@"attachment_group_optic"] then
			f267_local4 = "optic"
		end
	end
	return OpenOverlay( f267_arg0, f267_arg4, f267_arg3, {
		_sessionMode = f267_arg2._sessionMode,
		_model = f267_arg5:getModel(),
		_loadoutSlot = f267_arg6,
		_loadoutListItemSlot = f267_local5,
		_attachmentFilter = f267_local4,
		_storageClientBuffer = f267_local2
	} )
end
CoD.CACUtility.PlayChooseScreenIntro = function ( f268_arg0, f268_arg1, f268_arg2, f268_arg3, f268_arg4 )
	MenuHidesFreeCursor( f268_arg0, f268_arg1 )
	f268_arg0._playingIntro = true
	f268_arg0:appendEventHandler( "clip_over", function ()
		if f268_arg0._playingIntro then
			if f268_arg4 then
				MenuUnhideFreeCursor( f268_arg0, f268_arg1 )
			end
			f268_arg0._playingIntro = false
			if not IsMouseOrKeyboard( f268_arg1 ) and f268_arg0.__defaultFocus then
				f268_arg0.__defaultFocus:processEvent( {
					name = "gain_focus",
					controller = f268_arg1,
					menu = f268_arg0,
					moveCursor = true
				} )
			end
		end
	end )
	DelayedPlayClip( f268_arg0, f268_arg2, f268_arg3 )
end
CoD.CACUtility.PlayChooseScreenOutro = function ( f270_arg0, f270_arg1, f270_arg2 )
	MenuHidesFreeCursor( f270_arg0, f270_arg1 )
	PlayClip( f270_arg0, f270_arg2, f270_arg1 )
end
CoD.CACUtility.OpenPerkTalentOverlay = function ( f271_arg0, f271_arg1, f271_arg2, f271_arg3, f271_arg4, f271_arg5, f271_arg6 )
	local f271_local0 = f271_arg1:getModel()
	f271_local0 = f271_local0.loadoutSlot:get()
	local f271_local1 = CoD.BaseUtility.GetMenuModel( f271_arg2 )
	local f271_local2 = CoD.BaseUtility.GetMenuSessionMode( f271_arg2 )
	local f271_local3 = f271_arg1:getModel()
	f271_local3 = f271_local3.talentFilter:get()
	local f271_local4 = CoD.BonuscardUtility.GetTalentInfoForEquippedGluttony( f271_local1, f271_local2 )
	if f271_local3 then
		local f271_local5 = LUI.splitString( f271_local0, "." )
		local f271_local6 = tonumber( f271_local5[2] )
		if f271_local4 and f271_local6 and f271_local6 < CoD.CACUtility.talentGreedStartSlot then
			f271_local3 = f271_local4.talentFilter
		end
	end
	return OpenOverlay( f271_arg0, f271_arg4, f271_arg3, {
		_sessionMode = f271_arg2._sessionMode,
		_model = f271_arg5:getModel(),
		_loadoutSlot = f271_arg6,
		_loadoutListItemSlot = f271_local0,
		_talentFilter = f271_local3
	} )
end
CoD.CACUtility.OpenWildcardPopup = function ( f272_arg0, f272_arg1, f272_arg2, f272_arg3, f272_arg4, f272_arg5, f272_arg6, f272_arg7 )
	local f272_local0 = CoD.BaseUtility.GetMenuModel( f272_arg2 )
	local f272_local1 = CoD.BaseUtility.GetMenuSessionMode( f272_arg2 )
	local f272_local2 = f272_arg1:getModel()
	f272_local2 = f272_local2.loadoutSlot:get()
	local f272_local3 = f272_local2
	if f272_arg7 then
		f272_local2 = CoD.BonuscardUtility.GetNextAvailableSlot( f272_local0, f272_arg3 )
	end
	if f272_local2 then
		return OpenPopup( f272_arg0, f272_arg4, f272_arg3, {
			_sessionMode = f272_arg2._sessionMode,
			_model = f272_arg5:getModel(),
			_loadoutSlot = f272_arg6,
			_loadoutListItemSlot = f272_local2,
			_isContextualEquipping = f272_arg7,
			_contextualEquipSlot = f272_local3
		} )
	else
		return OpenOverlay( f272_arg0, "WildcardCapacity", f272_arg3, {
			_sessionMode = f272_local1,
			_model = f272_arg5:getModel(),
			_loadoutSlot = f272_arg6,
			_contextualEquipSlot = f272_local3
		} )
	end
end
CoD.CACUtility.OpenCACOverCapacityOverlay = function ( f273_arg0, f273_arg1, f273_arg2, f273_arg3, f273_arg4, f273_arg5 )
	return OpenOverlay( f273_arg0, f273_arg3, f273_arg1, {
		_sessionMode = f273_arg2,
		_model = f273_arg4,
		_loadoutSlot = f273_arg5
	} )
end
CoD.CACUtility.EquipWeapon = function ( f274_arg0, f274_arg1, f274_arg2, f274_arg3, f274_arg4 )
	local f274_local0, f274_local1, f274_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f274_arg2 )
	local f274_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f274_arg2 )
	local f274_local4 = f274_arg1:getModel()
	if f274_local4 then
		local f274_local5 = f274_local4.itemIndex:get()
		if CoD.ZMLoadoutUtility and f274_local2 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
			f274_local2 = "primary"
		end
		if f274_local3 then
			f274_local2 = f274_local3
		end
		if AttemptAttachItem( f274_arg0, f274_arg3, f274_local1, f274_local0, f274_local2, f274_local5, nil, true ) then
			if f274_arg1.equipSound and f274_arg1.equipSound ~= 0x0 then
				Engine[@"hash_498954175CA6A32C"]( f274_arg1.equipSound )
			end
			local f274_local6 = f274_local0.classNum:get()
			local f274_local7 = f274_local4.useVariantSlot
			if f274_local7 then
				f274_local7 = f274_local4.useVariantSlot:get()
			end
			if f274_local7 then
				CoD.CACUtility.SetClassItem( f274_arg3, f274_local6, f274_local2 .. ".weaponModelSlot", f274_local7 )
			end
			CoD.CACUtility.GetCustomClassModel( f274_arg3, f274_local6, f274_local0 )
			if f274_arg4 then
				GoBack( f274_arg0, f274_arg3 )
			end
		end
	end
end
CoD.CACUtility.EquipLoadoutListItem = function ( f275_arg0, f275_arg1, f275_arg2, f275_arg3 )
	local f275_local0, f275_local1, f275_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f275_arg1 )
	local f275_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f275_arg1 )
	local f275_local4 = CoD.BaseUtility.IsMenuContextualEquipping( f275_arg1 )
	local f275_local5 = f275_arg0:getModel()
	if f275_local5 and AttemptAttachItem( f275_arg1, f275_arg2, f275_local1, f275_local0, f275_local3, f275_local5.itemIndex:get() ) then
		if f275_arg0.equipSound and f275_arg0.equipSound ~= 0x0 then
			Engine[@"hash_498954175CA6A32C"]( f275_arg0.equipSound )
		end
		if f275_arg3 then
			GoBack( f275_arg1, f275_arg2 )
		end
	end
end
CoD.CACUtility.PlayElementXHashSound = function ( f276_arg0, f276_arg1 )
	local f276_local0 = f276_arg0[f276_arg1]
	if f276_local0 and f276_local0 ~= 0x0 then
		Engine[@"hash_498954175CA6A32C"]( f276_local0 )
	end
end
CoD.CACUtility.EquipSpecialIssueItem = function ( f277_arg0, f277_arg1, f277_arg2 )
	local f277_local0 = CoD.BaseUtility.GetMenuSessionMode( f277_arg1 )
	local f277_local1 = CoD.BaseUtility.GetMenuModel( f277_arg1 )
	local f277_local2 = f277_arg2:getModel()
	local f277_local3 = f277_local2.weaponSlot:get()
	local f277_local4 = f277_local2.unequipSound:get()
	if AttemptAttachItem( f277_arg1, f277_arg0, f277_local0, f277_local1, f277_local3, CoD.CACUtility.GetSpecialIssueEquipmentItemIndex() ) then
		CoD.CACUtility.UpdateClassWeaponModel( f277_arg1, f277_arg2, f277_arg0 )
		CoD.FreeCursorUtility.UpdateSetupContext( f277_arg2, f277_arg0 )
		CoD.FreeCursorUtility.RetriggerCursorPositionNoDelay( f277_arg2, f277_arg0 )
		if f277_local4 and f277_local4 ~= 0x0 then
			Engine[@"hash_498954175CA6A32C"]( f277_local4 )
		end
	end
end
CoD.CACUtility.UnequipItem = function ( f278_arg0, f278_arg1, f278_arg2 )
	local f278_local0 = CoD.BaseUtility.GetMenuSessionMode( f278_arg1 )
	local f278_local1 = CoD.BaseUtility.GetMenuModel( f278_arg1 )
	local f278_local2 = f278_arg2:getModel()
	local f278_local3 = f278_local2.weaponSlot:get()
	local f278_local4 = f278_local2.unequipSound:get()
	if RemoveItemFromClassSlot( f278_local1, f278_local3, f278_arg0, false, f278_local0 ) then
		CoD.CACUtility.GetCustomClassModel( f278_arg0, f278_local1.classNum:get(), f278_local1, nil, f278_local0 )
		CoD.CACUtility.UpdateClassWeaponModel( f278_arg1, f278_arg2, f278_arg0 )
		CoD.FreeCursorUtility.UpdateSetupContext( f278_arg2, f278_arg0 )
		if f278_local4 and f278_local4 ~= 0x0 then
			Engine[@"hash_498954175CA6A32C"]( f278_local4 )
		end
	end
end
CoD.CACUtility.UnequipLoadoutListItem = function ( f279_arg0, f279_arg1, f279_arg2 )
	local f279_local0 = CoD.BaseUtility.GetMenuSessionMode( f279_arg1 )
	local f279_local1 = CoD.BaseUtility.GetMenuModel( f279_arg1 )
	local f279_local2 = f279_arg0:getModel()
	if f279_local2 and f279_local2.loadoutSlot then
		local f279_local3 = CoD.CACUtility.GetLoadoutListItemUnequipSound( f279_arg0 )
		if RemoveItemFromClassSlot( f279_local1, f279_local2.loadoutSlot:get(), f279_arg2, false, f279_local0 ) then
			CoD.CACUtility.GetCustomClassModel( f279_arg2, f279_local1.classNum:get(), f279_local1, nil, f279_local0 )
			CoD.CACUtility.EquippedItemsChanged( f279_arg1, f279_arg2 )
			if f279_local3 and f279_local3 ~= 0x0 then
				Engine[@"hash_498954175CA6A32C"]( f279_local3 )
			end
		end
	end
end
CoD.CACUtility.UpdateLoadoutSlotDataSourceFilter = function ( f280_arg0, f280_arg1 )
	f280_arg0:setFilter( function ( f281_arg0 )
		return f281_arg0.loadoutSlot:get() == f280_arg1
	end )
end
CoD.CACUtility.WeaponGroupTabChange = function ( f282_arg0, f282_arg1, f282_arg2 )
	DataSources.Unlockables.setCurrentFilterItem( f282_arg1.category )
	f282_arg0.weaponList:updateDataSource( true, nil, true )
end
CoD.CACUtility.SetActiveListItemToFirstSelectableItem = function ( f283_arg0, f283_arg1 )
	f283_arg0:getFirstSelectableItem( true )
end
CoD.CACUtility.GetEquippedItemIndex = function ( f284_arg0, f284_arg1 )
	local f284_local0 = nil
	local f284_local1, f284_local2, f284_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f284_arg0 )
	local f284_local4 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f284_arg0 )
	if CoD.ZMLoadoutUtility and f284_local3 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
		f284_local3 = "primary"
	end
	if f284_local1 then
		if f284_local4 then
			f284_local0 = f284_local1[f284_local4].itemIndex:get()
		elseif f284_local3 then
			if f284_local1[f284_local3].itemIndex then
				local f284_local5 = f284_local1[f284_local3].itemIndex:get()
			end
			f284_local0 = f284_local5 or nil
		end
	end
	return f284_local0
end
CoD.CACUtility.GetEquippedItem = function ( f285_arg0, f285_arg1, f285_arg2 )
	local f285_local0 = nil
	local f285_local1 = CoD.CACUtility.GetEquippedItemIndex( f285_arg0, f285_arg1 )
	if f285_local1 and CoD.CACUtility.EmptyItemIndex < f285_local1 then
		f285_local0 = f285_arg2:findItem( {
			itemIndex = f285_local1
		}, nil, false, nil )
	end
	return f285_local0
end
CoD.CACUtility.UseEquippedItemAsDefaultFocus = function ( f286_arg0, f286_arg1, f286_arg2 )
	f286_arg2.getDefaultFocus = function ()
		local f287_local0 = CoD.CACUtility.GetEquippedItem( f286_arg0, f286_arg1, f286_arg2 )
		if not f287_local0 then
			f287_local0 = f286_arg2:getFirstSelectableItem( true )
		end
		return f287_local0
	end
	
end
CoD.CACUtility.IsCurrentGameTypeBarebones = function ()
	local f288_local0
	if string.match( Engine[@"lobbygetgametype"](), "_bb" ) then
		f288_local0 = true
	else
		f288_local0 = false
	end
	return f288_local0
end
CoD.CACUtility.SetActiveListItemToEquippedItem = function ( f289_arg0, f289_arg1, f289_arg2 )
	local f289_local0 = CoD.CACUtility.GetEquippedItem( f289_arg0, f289_arg1, f289_arg2 )
	if f289_local0 or CoD.isPC and not IsKeyboard( f289_arg1 ) then
		f289_arg2:setActiveItem( f289_local0 )
		if not f289_local0 and CoD.isPC then
			local f289_local1 = CoD.CACUtility.GetEquippedItemIndex( f289_arg0, f289_arg1 )
			if f289_local1 then
				local f289_local2 = CoD.CACUtility.GetUnlockableItemTable()
				f289_local2 = f289_local2[f289_local1]
				if f289_local2 then
					local f289_local3 = CoD.CACUtility.BuildItemModelDataFromUnlockableItem( f289_arg0, f289_arg1, f289_local2, nil, nil, nil, nil )
					local f289_local4 = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f289_arg1 ), "CACEquippedItem" )
					LuaUtils.CreateModelsFromTable( f289_local4, f289_local3.models )
					f289_arg2:setModel( f289_local4, f289_arg1 )
				end
			end
		end
	elseif not CoD.BaseUtility.IsMenuContextualEquipping( f289_arg0 ) then
		f289_arg2:getFirstSelectableItem( true )
	end
end
CoD.CACUtility.SetActiveListItemToEquippedAttachmentPC = function ( f290_arg0, f290_arg1, f290_arg2 )
	local f290_local0, f290_local1, f290_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f290_arg0 )
	local f290_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f290_arg0 )
	if f290_local0 then
		local f290_local4 = nil
		if f290_local3 then
			f290_local4 = f290_local0[f290_local3].itemIndex:get()
		elseif f290_local2 then
			f290_local4 = f290_local0[f290_local2].itemIndex:get()
		end
		if CoD.CACUtility.EmptyItemIndex < f290_local4 then
			local f290_local5 = f290_arg2:findItem( {
				itemIndex = f290_local4
			}, nil, false, nil )
			if f290_local5 then
				ForceCheckDefaultPCFocus( f290_local5, f290_arg0, f290_arg1, 50 )
			end
		else
			f290_arg2:getFirstSelectableItem( true )
		end
	end
end
CoD.CACUtility.SetActiveListItemToElementItem = function ( f291_arg0, f291_arg1, f291_arg2, f291_arg3 )
	local f291_local0 = nil
	local f291_local1 = f291_arg3:getModel()
	if f291_local1 and f291_local1.itemIndex then
		f291_local0 = f291_local1.itemIndex:get()
	end
	if f291_local0 then
		f291_arg2:findItem( {
			itemIndex = f291_local0
		}, nil, true, nil )
	else
		f291_arg2:getFirstSelectableItem( true )
	end
end
CoD.CACUtility.SetActiveListItemForWeaponGroup = function ( f292_arg0, f292_arg1, f292_arg2 )
	local f292_local0, f292_local1, f292_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f292_arg0 )
	local f292_local3 = CoD.CACUtility.GetItemIndexEquippedInSlot( f292_local2, f292_arg1, f292_local0 )
	local f292_local4 = f292_arg2.Tabs
	if f292_local4 then
		f292_local4 = f292_arg2.Tabs.grid
	end
	if f292_local2 == "primary" or f292_local2 == "secondary" then
		if CoD.CACUtility.EmptyItemIndex < f292_local3 then
			local f292_local5 = Engine[@"getitemgroup"]( f292_local3, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f292_local1 )
			if f292_local4 and f292_local4:findItem( nil, {
				category = f292_local5
			}, true, nil ) then
				f292_arg0.__itemGroup = f292_local5
			end
		else
			local f292_local5 = CoD.BonuscardUtility.IsBonuscardEquipped( f292_local0, @"bonuscard_overkill", f292_local1 )
			local f292_local6 = CoD.BonuscardUtility.IsBonuscardEquipped( f292_local0, @"bonuscard_underkill", f292_local1 )
			local f292_local7 = f292_local2
			if not (f292_local2 ~= "primary" or f292_local6) or f292_local5 then
				f292_local7 = "primary"
			elseif not (f292_local2 ~= "secondary" or f292_local5) or f292_local6 then
				f292_local7 = "secondary"
			end
			local f292_local8 = CoD.CACUtility.GetWeaponGroupNamesForSlot( f292_local7 )
			f292_arg0.__itemGroup = f292_local8[1].weapon_category
		end
	elseif CoD.ZMLoadoutUtility and f292_local2 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
		f292_local3 = CoD.CACUtility.GetItemIndexEquippedInSlot( "primary", f292_arg1, f292_local0 )
		if CoD.CACUtility.EmptyItemIndex < f292_local3 then
			local f292_local5 = Engine[@"getitemgroup"]( f292_local3, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f292_local1 )
			if f292_local5 == "weapon_pistol" or f292_local5 == "weapon_cqb" then
				f292_local5 = "weapon_secondaries"
			end
			if f292_local4 and f292_local4:findItem( nil, {
				category = f292_local5
			}, true, nil ) then
				f292_arg0.__itemGroup = f292_local5
			end
		end
	end
end
CoD.CACUtility.AnimatedMenuClose = function ( f293_arg0, f293_arg1, f293_arg2, f293_arg3, f293_arg4 )
	PlayClip( f293_arg0, f293_arg2, f293_arg1 )
	DelayGoBack( f293_arg0, f293_arg1, f293_arg3 )
	PlaySoundAlias( f293_arg4 )
end
CoD.CACUtility.OpenClassOptions = function ( f294_arg0, f294_arg1, f294_arg2, f294_arg3 )
	local f294_local0 = CoD.BaseUtility.GetMenuModel( f294_arg1 )
	local f294_local1 = OpenPopup( f294_arg0, f294_arg3, f294_arg2, {
		_sessionMode = f294_arg1._sessionMode,
		_model = f294_local0
	} )
	local f294_local2 = DataSources.CACClassOptions.getModel( f294_arg2 )
	if f294_local2 and f294_local2.customClassName then
		local f294_local3 = f294_local0.customClassName:get()
		f294_local2.customClassName:set( f294_local3 )
		f294_local2.currentClassName:set( f294_local3 )
		local f294_local4 = Engine[@"getmodelforcontroller"]( f294_arg2 )
		f294_local4 = f294_local4.RenameClassText
		if f294_local4 then
			f294_local4:set( "" )
		end
	end
end
CoD.CACUtility.SetCustomClassFromButtonPrompt = function ( f295_arg0, f295_arg1, f295_arg2, f295_arg3 )
	CoD.CACUtility.SetSelectedCustomClass( f295_arg1, CoD.BaseUtility.GetMenuSessionMode( f295_arg0 ), f295_arg3 )
end
CoD.CACUtility.UpdateAdditionalEquipment = function ( f296_arg0, f296_arg1, f296_arg2, f296_arg3 )
	local f296_local0 = CoD.BaseUtility.GetMenuSessionMode( f296_arg0 )
	local f296_local1 = CoD.BaseUtility.GetMenuModel( f296_arg0 )
	local f296_local2 = f296_arg2:getModel()
	if AttemptAttachItem( f296_arg0, f296_arg1, f296_local0, f296_local1, f296_local2 and f296_local2.weaponSlot:get(), f296_arg3, nil ) then
		CoD.FreeCursorUtility.UpdateSetupContext( f296_arg2, f296_arg1 )
		f296_arg2:playSound( "equip_item" )
	end
end
CoD.CACUtility.EquipAdditionalEquipment = function ( f297_arg0, f297_arg1, f297_arg2 )
	CoD.CACUtility.UpdateAdditionalEquipment( f297_arg0, f297_arg1, f297_arg2, 1 )
end
CoD.CACUtility.RemoveAdditionalEquipment = function ( f298_arg0, f298_arg1, f298_arg2 )
	local f298_local0 = CoD.BaseUtility.GetMenuSessionMode( f298_arg0 )
	local f298_local1 = CoD.BaseUtility.GetMenuModel( f298_arg0 )
	local f298_local2 = f298_arg2:getModel()
	if RemoveItemFromClassSlot( f298_local1, f298_local2 and f298_local2.weaponSlot:get(), f298_arg1, false, f298_local0 ) then
		CoD.CACUtility.GetCustomClassModel( f298_arg1, f298_local1.classNum:get(), f298_local1, nil, f298_local0 )
		CoD.FreeCursorUtility.UpdateSetupContext( f298_arg2, f298_arg1 )
		f298_arg2:playSound( "unequip_item" )
	end
end
CoD.CACUtility.RenameCustomClass = function ( f299_arg0, f299_arg1, f299_arg2 )
	local f299_local0 = Engine[@"getmodelforcontroller"]( f299_arg2 )
	f299_local0 = f299_local0.RenameClassText:get()
	if not Engine[@"hash_E3FC4BECF450A06"]( f299_arg2, f299_local0, Enum[@"keyboardtype"][@"keyboard_type_custom_class"] ) then
		local f299_local1 = CoD.BaseUtility.GetMenuSessionMode( f299_arg1 )
		local f299_local2 = CoD.BaseUtility.GetMenuModel( f299_arg1 )
		local f299_local3 = f299_local2.classNum:get()
		if f299_local0 and f299_local0 ~= "" then
			local f299_local4 = Engine[@"getcacroot"]( f299_arg2, f299_local3, f299_local1 )
			if f299_local4 and f299_local4.customClassName and f299_local4.customClassName[f299_local3] then
				f299_local2.customClassName:set( f299_local0 )
				f299_local4.customClassName[f299_local3]:set( f299_local0 )
				SaveLoadoutGeneric( f299_arg2 )
			end
		end
	end
end
CoD.CACUtility.GetSignatureWeaponOptionsHelper = function ( f300_arg0, f300_arg1, f300_arg2, f300_arg3, f300_arg4 )
	local f300_local0 = CoD.WeaponOptionsUtility.GetWeaponOptionsString( 0, 0, 1, f300_arg1 )
	if IsPaintshop( f300_arg0 ) then
		f300_local0 = CoD.WeaponOptionsUtility.GetWeaponOptionsString( 0, 0, 0, f300_arg1 )
	end
	local f300_local1 = ""
	local f300_local2 = CoD.CACUtility.GetUnlockableItemInfo( f300_arg2, f300_arg3 )
	local f300_local3 = f300_local2.nameHash
	if f300_arg3 == Enum[@"emodes"][@"mode_zombies"] and f300_arg4 then
		local f300_local4 = CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex( f300_arg0, f300_arg2, f300_arg1 )
		if CoD.SafeGetModelValue( f300_arg4:getModel(), "isMastercraft" ) then
			f300_local4.camoIndex = 0
		end
		f300_local0 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable( f300_local4 )
		f300_local1 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForElement( f300_arg4, f300_arg0, f300_arg3 )
	end
	if f300_arg3 == Enum[@"emodes"][@"mode_warzone"] then
		local f300_local4 = CoD.WZUtility.GetWeaponOptionsTableForIndex( f300_arg0, f300_arg2, f300_arg1 )
		if f300_arg4 and CoD.SafeGetModelValue( f300_arg4:getModel(), "isMastercraft" ) then
			f300_local4.camoIndex = 0
		end
		f300_local0 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable( f300_local4 )
	end
	return f300_local0, f300_local3, f300_local1
end
CoD.CACUtility.PreviewSignatureWeapon = function ( f301_arg0, f301_arg1, f301_arg2 )
	local f301_local0 = CoD.CraftUtility.GetLoadoutSlot( f301_arg2 )
	local f301_local1 = "select01"
	local f301_local2 = f301_arg0:getModel( f301_arg2, "itemIndex" )
	local f301_local3 = f301_arg0:getModel( f301_arg2, "weaponModelSlotIndex" )
	if f301_local3 and f301_local2 then
		local f301_local4, f301_local5, f301_local6 = CoD.CACUtility.GetSignatureWeaponOptionsHelper( f301_arg2, f301_local3:get(), f301_local2:get(), CoD.BaseUtility.GetMenuSessionMode( f301_arg1 ), f301_arg0 )
		Engine[@"sendclientscriptnotify"]( f301_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum( f301_arg2 ), {
			base_weapon_slot = f301_local0,
			weapon = f301_local5,
			attachments = f301_local6,
			camera = f301_local1,
			options = f301_local4
		} )
	end
end
CoD.CACUtility.SetSignatureWeaponMPInternal = function ( f302_arg0, f302_arg1, f302_arg2, f302_arg3, f302_arg4, f302_arg5, f302_arg6 )
	local f302_local0 = f302_arg3.classNum:get()
	local f302_local1 = CoD.CACUtility.GetBaseWeaponLoadoutSlotName( f302_arg5 )
	local f302_local2 = f302_arg0:getModel( f302_arg1, "itemIndex" )
	local f302_local3 = f302_arg0:getModel( f302_arg1, "weaponModelSlotIndex" )
	if f302_local3 then
		local f302_local4 = f302_local3:get()
		local f302_local5 = CoD.BaseUtility.GetMenuSessionMode( f302_arg2 )
		local f302_local6 = f302_local2:get()
		if not f302_arg6 or AttemptAttachItem( f302_arg0, f302_arg1, f302_local5, f302_arg3, f302_arg5, f302_local6 ) then
			if f302_arg0.equipSound and f302_arg0.equipSound ~= 0x0 then
				Engine[@"hash_498954175CA6A32C"]( f302_arg0.equipSound )
			end
			local f302_local7 = f302_local1 .. ".weaponModelSlot"
			local f302_local8 = false
			local f302_local9 = CoD.CACUtility.GetClassItem( f302_arg1, f302_local0, f302_local7 )
			if f302_arg0.mastercraftWeaponModelSlots and #f302_arg0.mastercraftWeaponModelSlots > 0 then
				for f302_local13, f302_local14 in ipairs( f302_arg0.mastercraftWeaponModelSlots ) do
					if f302_local9 == f302_local14 then
						f302_local8 = true
						break
					end
				end
			end
			CoD.CACUtility.SetClassItem( f302_arg1, f302_local0, f302_local7, f302_local4 )
			if CoD.SafeGetModelValue( f302_arg0:getModel(), "isMastercraft" ) then
				CoD.CACUtility.SetClassItem( f302_arg1, f302_local0, f302_local1 .. ".camoIndex", CoD.SafeGetModelValue( f302_arg0:getModel(), "weaponOptionSubIndex" ) )
			elseif f302_local8 then
				CoD.CACUtility.SetClassItem( f302_arg1, f302_local0, f302_local1 .. ".camoIndex", CoD.CACUtility.EmptyItemIndex )
			end
			f302_arg3[f302_arg5].weaponModelSlot:set( f302_local4 )
			local f302_local11 = f302_arg0 and f302_arg0:getModel()
			local f302_local12 = CoD.CACUtility.IsItemIndexRestricted( f302_local6 )
			local f302_local13 = f302_local11:create( "isRestricted" )
			f302_local13:set( f302_local12 )
			if f302_arg5 == "primary" or f302_arg5 == "secondary" then
				CoD.CACUtility.GetCustomClassModel( f302_arg1, f302_local0, f302_arg3 )
				CoD.CACUtility.UpdateClassWeaponModel( f302_arg2, f302_arg0, f302_arg1 )
				CoD.WeaponOptionsUtility.UpdateWeaponOptionLists( f302_arg0, f302_arg1 )
			end
		end
	end
end
CoD.CACUtility.SetSignatureWeapon = function ( f303_arg0, f303_arg1, f303_arg2 )
	local f303_local0, f303_local1, f303_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f303_arg2 )
	if f303_local1 == Enum[@"emodes"][@"mode_zombies"] then
		local f303_local3 = CoD.ZMLoadoutUtility.SetSignatureWeapon( f303_arg0, f303_arg1, f303_arg2 )
		CoD.WeaponOptionsUtility.UpdateWeaponOptionLists( f303_arg0, f303_arg1 )
		if f303_local2 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
			local f303_local4 = f303_local0.classNum:get()
			if f303_local3 then
				CoD.CACUtility.SetClassItem( f303_arg1, f303_local4, "primary.weaponModelSlot", f303_local3 )
			end
			CoD.CACUtility.GetCustomClassModel( f303_arg1, f303_local4, f303_local0 )
		end
		return 
	elseif f303_local1 == Enum[@"emodes"][@"mode_warzone"] then
		CoD.WZUtility.SetSignatureWeapon( f303_arg0, f303_arg1, f303_arg2 )
		CoD.WeaponOptionsUtility.UpdateWeaponOptionLists( f303_arg0, f303_arg1 )
		return 
	end
	local f303_local3 = true
	local f303_local4 = f303_local2 and f303_local0 and f303_local0[f303_local2]
	local f303_local5 = f303_local4.itemIndex
	if f303_local5 then
		f303_local5 = f303_local4.itemIndex:get()
	end
	local f303_local6 = CoD.SafeGetModelValue( f303_arg0:getModel(), "itemIndex" )
	if f303_local5 and f303_local6 and f303_local5 == f303_local6 then
		f303_local3 = false
	end
	CoD.CACUtility.SetSignatureWeaponMPInternal( f303_arg0, f303_arg1, f303_arg2, f303_local0, f303_local1, f303_local2, f303_local3 )
end
CoD.CACUtility.SetSignatureWeaponFromCAC = function ( f304_arg0, f304_arg1, f304_arg2 )
	local f304_local0, f304_local1, f304_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f304_arg2 )
	f304_local2 = CoD.SafeGetModelValue( f304_arg0:getModel(), "loadoutSlot" )
	if f304_local1 == Enum[@"emodes"][@"mode_zombies"] then
		CoD.ZMLoadoutUtility.SetSignatureWeapon( f304_arg0, f304_arg1, f304_arg2 )
		CoD.WeaponOptionsUtility.UpdateWeaponOptionLists( f304_arg0, f304_arg1 )
		return 
	elseif f304_local1 == Enum[@"emodes"][@"mode_warzone"] then
		CoD.WZUtility.SetSignatureWeapon( f304_arg0, f304_arg1, f304_arg2 )
		CoD.WeaponOptionsUtility.UpdateWeaponOptionLists( f304_arg0, f304_arg1 )
		return 
	elseif f304_local2 then
		CoD.CACUtility.SetSignatureWeaponMPInternal( f304_arg0, f304_arg1, f304_arg2, f304_local0, f304_local1, f304_local2, false )
	end
end
CoD.CACUtility.UpdateWeaponNameInfoModel = function ( f305_arg0, f305_arg1, f305_arg2 )
	if f305_arg0.ItemInfo then
		local f305_local0 = f305_arg1:getModel()
		if f305_local0 then
			f305_arg0.ItemInfo:setModel( f305_local0, f305_arg2 )
		end
	end
end
CoD.CACUtility.UpdateWeaponCharmModel = function ( f306_arg0, f306_arg1, f306_arg2 )
	CoD.CACUtility.UpdateWeaponCharmModelInternal( f306_arg2, CoD.SafeGetModelValue( f306_arg1:getModel(), "frontendModel" ) or 0x0 )
end
CoD.CACUtility.ShowEmptyWeaponCharmModel = function ( f307_arg0, f307_arg1 )
	CoD.CACUtility.UpdateWeaponCharmModelInternal( f307_arg1, 0x0 )
end
CoD.CACUtility.UpdateWeaponCharmModelInternal = function ( f308_arg0, f308_arg1 )
	Engine[@"sendclientscriptnotify"]( f308_arg0, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum( f308_arg0 ), {
		base_weapon_slot = "charm",
		weapon = @"hash_0",
		attachments = "",
		camera = "select01",
		xmodel_name = f308_arg1,
		xmodel_scale = 7
	} )
end
CoD.CACUtility.IsWeaponCustomizationCurrentlyAllowed = function ( f309_arg0, f309_arg1 )
	if IsInGame() and not IsInPrematchPeriod( f309_arg1 ) then
		return false
	else
		return true
	end
end
CoD.CACUtility.DoesWeaponHaveAttachments = function ( f310_arg0, f310_arg1 )
	local f310_local0 = f310_arg0:getModel()
	local f310_local1 = CoD.CACUtility.EmptyItemIndex
	local f310_local2 = CoD.PlayerRoleUtility.customizationMode
	if not f310_local2 then
		f310_local2 = Engine[@"currentsessionmode"]()
	end
	if f310_local0 and f310_local0.itemIndex then
		f310_local1 = f310_local0.itemIndex:get()
	end
	return CoD.CACUtility.DoesUnlockableItemHaveAnyAttachments( f310_local1, f310_local2 )
end
CoD.CACUtility.IsItemEquippedInCurrentSlot = function ( f311_arg0, f311_arg1, f311_arg2 )
	local f311_local0 = CoD.CACUtility.GetAttachmentIndexForSlotOrList( f311_arg1 )
	local f311_local1 = CoD.BaseUtility.GetMenuLoadoutSlot( f311_arg0 )
	local f311_local2 = CoD.BaseUtility.GetMenuModel( f311_arg0 )
	if not f311_local1 then
		f311_local1 = CoD.CACUtility.GetWeaponCategoryForSlot( f311_arg1, f311_arg2 )
	end
	if CoD.ZMLoadoutUtility and f311_local1 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
		f311_local1 = "primary"
	end
	if f311_local2 and f311_local0 and f311_local0 ~= CoD.CACUtility.EmptyItemIndex and f311_local2[f311_local1].itemIndex:get() == f311_local0 then
		return true
	else
		return false
	end
end
CoD.CACUtility.IsBaseSignatureWeapon = function ( f312_arg0, f312_arg1, f312_arg2 )
	local f312_local0, f312_local1, f312_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f312_arg0 )
	local f312_local3 = f312_arg1:getModel()
	local f312_local4 = f312_local3.weaponItemIndex:get()
	if f312_local0 and f312_local2 and f312_local1 and f312_local4 then
		local f312_local5 = Engine[@"hash_79F0BB7D52A7A978"]( Engine[@"hash_7B98952F69D937F9"]( f312_local4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f312_local1 ) )
		local f312_local6
		if f312_local1 ~= Enum[@"emodes"][@"mode_zombies"] then
			f312_local6 = f312_local0[f312_local2].weaponModelSlot:get() + 1
			if not f312_local6 then
			
			elseif f312_local5 and f312_local6 then
				return f312_local5[f312_local6][@"hash_5C2AA73D9F82E9C2"]
			end
		end
		f312_local6 = CoD.ZMLoadoutUtility.GetWeaponModelSlot( f312_local4, f312_arg2 ) + 1
	end
	return false
end
CoD.CACUtility.IsMark2WeaponInternal = function ( f313_arg0, f313_arg1 )
	if f313_arg1 and f313_arg1.itemIndex then
		local f313_local0 = nil
		if f313_arg1.weaponModelSlot then
			f313_local0 = f313_arg1.weaponModelSlot:get()
		elseif f313_arg1.weaponModelSlotIndex then
			f313_local0 = f313_arg1.weaponModelSlotIndex:get()
		elseif f313_arg1.useVariantSlot and f313_arg1.useVariantSlot:get() then
			f313_local0 = f313_arg1.useVariantSlot:get()
		end
		if not f313_local0 then
			return false
		end
		return f313_local1[f313_local0 + 1] and f313_local1[f313_local0 + 1][@"ismark2"]
	else
		return false
	end
end
CoD.CACUtility.IsMark2Weapon = function ( f314_arg0, f314_arg1 )
	return CoD.CACUtility.IsMark2WeaponInternal( f314_arg0, f314_arg1:getModel() )
end
CoD.CACUtility.IsMastercraft = function ( f315_arg0, f315_arg1 )
	local f315_local0 = f315_arg1:getModel()
	if f315_local0 and f315_local0.itemIndex then
		local f315_local1 = nil
		if f315_local0.weaponModelSlot then
			f315_local1 = f315_local0.weaponModelSlot:get()
		elseif f315_local0.weaponModelSlotIndex then
			f315_local1 = f315_local0.weaponModelSlotIndex:get()
		elseif f315_local0.useVariantSlot and f315_local0.useVariantSlot:get() then
			f315_local1 = f315_local0.useVariantSlot:get()
		end
		if not f315_local1 then
			return false
		end
		local f315_local2 = Engine[@"hash_79F0BB7D52A7A978"]( Engine[@"hash_7B98952F69D937F9"]( f315_local0.itemIndex:get() ) )
		local f315_local3 = f315_local2[f315_local1 + 1]
		if f315_local3 then
			if f315_local2[f315_local1 + 1][@"index"] > 0 then
				f315_local3 = not f315_local2[f315_local1 + 1][@"ismark2"]
			else
				f315_local3 = false
			end
		end
		return f315_local3
	else
		return false
	end
end
CoD.CACUtility.GetEquipSlotForItemIndex = function ( f316_arg0, f316_arg1, f316_arg2, f316_arg3 )
	for f316_local0 = 1, f316_arg3, 1 do
		local f316_local3 = f316_arg2[f316_local0]
		if f316_arg1[f316_local3].itemIndex:get() == f316_arg0 then
			return f316_local3
		end
	end
	return nil
end
CoD.CACUtility.GetAttachmentEquipSlot = function ( f317_arg0, f317_arg1, f317_arg2 )
	local f317_local0 = CoD.CACUtility.GetAttachmentListForSlot( f317_arg2 )
	return CoD.CACUtility.GetEquipSlotForItemIndex( f317_arg0, f317_arg1, f317_local0, #f317_local0 )
end
CoD.CACUtility.IsAttachmentEquippedInCurrentClass = function ( f318_arg0, f318_arg1 )
	if f318_arg1 and f318_arg1 ~= CoD.CACUtility.EmptyItemIndex then
		local f318_local0 = CoD.BaseUtility.GetMenuLoadoutSlot( f318_arg0 )
		local f318_local1 = CoD.BaseUtility.GetMenuModel( f318_arg0 )
		if f318_local1 and CoD.CACUtility.GetAttachmentEquipSlot( f318_arg1, f318_local1, f318_local0 ) ~= nil then
			return true
		end
	end
	return false
end
CoD.CACUtility.IsElementAttachmentEquippedInCurrentClass = function ( f319_arg0, f319_arg1, f319_arg2 )
	return CoD.CACUtility.IsAttachmentEquippedInCurrentClass( f319_arg0, CoD.SafeGetModelValue( f319_arg1:getModel(), "itemIndex" ) )
end
CoD.CACUtility.IsAttachmentEquippedForIngamePipVisibility = function ( f320_arg0, f320_arg1, f320_arg2, f320_arg3 )
	local f320_local0 = f320_arg2:getModel()
	local f320_local1, f320_local2, f320_local3 = nil
	if f320_local0 then
		f320_local1 = f320_local0.loadoutListItem:get()
		if f320_local1 and f320_local1.itemIndex then
			f320_local3 = f320_local1.itemIndex:get()
		end
	end
	if f320_local3 and f320_local3 > CoD.CACUtility.EmptyItemIndex then
		local f320_local4 = f320_arg1:getModel()
		local f320_local5 = f320_local1.weaponSlot
		if f320_local5 then
			f320_local5 = f320_local1.weaponSlot:get()
		end
		if f320_local4 and CoD.CACUtility.GetAttachmentEquipSlot( f320_local3, f320_local4, f320_local5 ) ~= nil then
			return true
		end
	end
	return false
end
CoD.CACUtility.IsItemEquippedInCurrentLoadout = function ( f321_arg0, f321_arg1, f321_arg2 )
	local f321_local0 = CoD.CACUtility.GetAttachmentIndexForSlotOrList( f321_arg1 )
	if f321_local0 and CoD.CACUtility.IsItemAlreadyEquippedInAnySlot( CoD.BaseUtility.GetMenuModel( f321_arg0 ), f321_local0, CoD.CACUtility.GetSlotListWithSlot( CoD.BaseUtility.GetMenuLoadoutSlot( f321_arg0 ) ) ) then
		return true
	else
		return false
	end
end
CoD.CACUtility.EquippingFocusedItemWouldRemoveThisItem = function ( f322_arg0, f322_arg1, f322_arg2 )
	local f322_local0 = CoD.SafeGetModelValue( f322_arg1:getModel(), "itemIndex" )
	if not CoD.CACUtility.IsItemEquippedInCurrentLoadout( f322_arg0, f322_arg1, f322_arg2 ) then
		return false
	elseif CoD.CACUtility.IsItemEquippedInCurrentSlot( f322_arg0, f322_arg1, f322_arg2 ) then
		return false
	elseif f322_local0 ~= nil then
		local f322_local1 = Engine[@"getmodelforcontroller"]( f322_arg2 )
		f322_local1 = f322_local1.focusedAttachmentIndex:get()
		local f322_local2 = Engine[@"getcustomclasscacroot"]( f322_arg2, classNum, Engine[@"currentsessionmode"]() )
		if f322_local0 ~= f322_local1 and not Engine[@"areattachmentscompatible"]( f322_local2[CoD.perController[f322_arg2].weaponCategory].itemIndex:get(), f322_local0, f322_local1 ) then
			return true
		end
	end
end
CoD.CACUtility.IsAttachmentInSlotReplaceable = function ( f323_arg0, f323_arg1, f323_arg2 )
	local f323_local0 = CoD.CACUtility.GetAttachmentIndexForSlotOrList( f323_arg1 )
	local f323_local1 = Engine[@"getmodelforcontroller"]( f323_arg2 )
	if f323_arg0.slotIndex and CoD.CACUtility.EmptyItemIndex < f323_local1.focusedAttachmentIndex:get() and not CoD.ModelUtility.IsModelValueEqualTo( f323_arg2, "AttachmentMenu.activeAttachmentSlotIndex", f323_arg0.slotIndex ) then
		return true
	else
		return false
	end
end
CoD.CACUtility.IsLoadoutEquipped = function ( f324_arg0, f324_arg1, f324_arg2 )
	local f324_local0 = CoD.BaseUtility.GetMenuSessionMode( f324_arg0 )
	if not f324_local0 then
		f324_local0 = Engine[@"currentsessionmode"]()
	end
	return CoD.CACUtility.GetSelectedCustomClass( f324_arg2, f324_local0 ) == CoD.SafeGetModelValue( f324_arg1:getModel(), "classNumber" )
end
CoD.CACUtility.IsLoadoutLocked = function ( f325_arg0, f325_arg1, f325_arg2 )
	local f325_local0 = CoD.BaseUtility.GetMenuSessionMode( f325_arg0 )
	if not f325_local0 then
		f325_local0 = Engine[@"currentsessionmode"]()
	end
	return CoD.CACUtility.IsFeatureItemLocked( f325_arg2, CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( CoD.SafeGetModelValue( f325_arg1:getModel(), "classNumber" ), "featureItemIndex" ), f325_local0 )
end
CoD.CACUtility.IsOverCapacityItemSmall = function ( f326_arg0 )
	local f326_local0 = f326_arg0:getModel()
	if f326_local0 then
		local f326_local1 = f326_local0.loadoutSlot
		if f326_local1 then
			f326_local1 = f326_local0.loadoutSlot:get()
		end
		if f326_local1 == "primary" or f326_local1 == "secondary" then
			return false
		end
	end
	return true
end
CoD.CACUtility.IsOverCapacityItemWildcard = function ( f327_arg0 )
	local f327_local0 = f327_arg0:getModel()
	if f327_local0 then
		local f327_local1 = f327_local0.loadoutSlot
		if f327_local1 then
			f327_local1 = f327_local0.loadoutSlot:get()
		end
		if LUI.startswith( f327_local1, "bonuscard" ) then
			return true
		end
	end
	return false
end
CoD.CACUtility.IsItemSlotNotAvailable = function ( f328_arg0 )
	local f328_local0 = f328_arg0:getModel()
	local f328_local1 = nil
	if f328_local0 then
		f328_local1 = f328_local0.prevSlotModel and f328_local0.prevSlotModel:get()
		if f328_local1 then
			local f328_local2 = f328_local1.itemIndex
			if f328_local2 then
				f328_local2 = f328_local1.itemIndex:get()
			end
			if f328_local2 then
				return f328_local2 <= CoD.CACUtility.EmptyItemIndex
			end
		end
	end
	return false
end
CoD.CACUtility.IsAttachmentSlotValid = function ( f329_arg0, f329_arg1, f329_arg2 )
	local f329_local0 = CoD.BaseUtility.GetMenuModel( f329_arg0 )
	local f329_local1 = CoD.BaseUtility.GetMenuSessionMode( f329_arg0 )
	local f329_local2 = f329_arg2:getModel()
	if CoD.ModelUtility.IsSelfModelValueTrue( f329_arg2, f329_arg1, "isAttachmentSlotAvailable" ) and f329_local0 and f329_local2 and f329_local2.loadoutSlot then
		local f329_local3 = LUI.splitString( f329_local2.loadoutSlot:get(), "." )
		if #f329_local3 == 3 then
			local f329_local4
			if CoD.BonuscardUtility.IsOperatorModBonuscardEquipped( f329_local0, f329_local3[1], f329_local1 ) and tonumber( f329_local3[3] ) == CoD.CACUtility.HiddenSlotIndexForUber then
				f329_local4 = false
			else
				f329_local4 = true
			end
			return f329_local4
		end
	end
	return false
end
CoD.CACUtility.IsProgressionEnabledForMenu = function ( f330_arg0 )
	return CoD.CACUtility.IsProgressionEnabled( CoD.BaseUtility.GetMenuSessionMode( f330_arg0 ) )
end
CoD.CACUtility.IsProgressionWithWarzoneEnabledForMenu = function ( f331_arg0 )
	return CoD.CACUtility.IsProgressionWithWarzoneEnabled( CoD.BaseUtility.GetMenuSessionMode( f331_arg0 ) )
end
CoD.CACUtility.IsWeaponLevelMax = function ( f332_arg0, f332_arg1, f332_arg2 )
	if f332_arg1 <= CoD.CACUtility.EmptyItemIndex then
		return false
	end
	local f332_local0
	if Engine[@"getguncurrentrank"]( f332_arg0, f332_arg1, f332_arg2 ) ~= Engine[@"getgunnextrank"]( f332_arg0, f332_arg1, f332_arg2 ) or Engine[@"hash_7FF3DA2744A0F3A3"]( f332_arg0, f332_arg1, f332_arg2 ) > Engine[@"getguncurrentrankxp"]( f332_arg0, f332_arg1, f332_arg2 ) then
		f332_local0 = false
	else
		f332_local0 = true
	end
	return f332_local0
end
CoD.CACUtility.WeaponHasLevels = function ( f333_arg0, f333_arg1, f333_arg2 )
	return Engine[@"getgunnextrank"]( f333_arg0, f333_arg1, f333_arg2 ) > 0
end
CoD.CACUtility.IsWeaponPrestigeLevelMax = function ( f334_arg0, f334_arg1, f334_arg2 )
	local f334_local0 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer( f334_arg0 )
	local f334_local1 = 0
	if f334_local0 then
		local f334_local2 = Engine[@"hash_7B98952F69D937F9"]( f334_arg1 )
		if f334_local2 ~= 0x0 and f334_local0.ranked_item_stats[f334_local2] then
			f334_local1 = f334_local0.ranked_item_stats[f334_local2].pLevel:get()
		end
	end
	return f334_local1 == CoD.CACUtility.maxWeaponPrestige
end
CoD.CACUtility.IsCACGunLevelMax = function ( f335_arg0, f335_arg1, f335_arg2 )
	local f335_local0 = CoD.BaseUtility.GetMenuSessionMode( f335_arg0 )
	local f335_local1 = CoD.CACUtility.GetGunLevelWeaponIndex( f335_arg2, f335_arg1 )
	if f335_local1 == CoD.CACUtility.EmptyItemIndex then
		return false
	else
		return CoD.CACUtility.IsWeaponLevelMax( f335_arg2, f335_local1, f335_local0 )
	end
end
CoD.CACUtility.IsCACGunPrestigeLevelMax = function ( f336_arg0, f336_arg1, f336_arg2 )
	local f336_local0 = CoD.BaseUtility.GetMenuSessionMode( f336_arg0 )
	local f336_local1 = CoD.CACUtility.GetGunLevelWeaponIndex( f336_arg2, f336_arg1 )
	if f336_local1 == CoD.CACUtility.EmptyItemIndex then
		return false
	else
		return CoD.CACUtility.IsWeaponPrestigeLevelMax( f336_arg2, f336_local1, f336_local0 )
	end
end
CoD.CACUtility.IsCACGunPrestigeLevelOne = function ( f337_arg0, f337_arg1, f337_arg2 )
	local f337_local0 = CoD.BaseUtility.GetMenuSessionMode( f337_arg0 )
	local f337_local1 = CoD.CACUtility.GetGunLevelWeaponIndex( f337_arg2, f337_arg1 )
	if f337_local1 == CoD.CACUtility.EmptyItemIndex then
		return false
	end
	local f337_local2 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer( f337_arg2 )
	local f337_local3 = 0
	if f337_local2 then
		local f337_local4 = Engine[@"hash_7B98952F69D937F9"]( f337_local1 )
		if f337_local4 ~= 0x0 then
			f337_local3 = f337_local2.ranked_item_stats[f337_local4] and f337_local2.ranked_item_stats[f337_local4].pLevel:get()
		end
	end
	return f337_local3 == 1
end
CoD.CACUtility.IsCACGunLevelExists = function ( f338_arg0, f338_arg1, f338_arg2 )
	local f338_local0 = CoD.BaseUtility.GetMenuSessionMode( f338_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f338_local0 ) then
		return false
	else
		local f338_local1 = CoD.CACUtility.GetGunLevelWeaponIndex( f338_arg2, f338_arg1 )
		if f338_local1 == CoD.CACUtility.EmptyItemIndex then
			return false
		else
			return CoD.CACUtility.WeaponHasLevels( f338_arg2, f338_local1, f338_local0 )
		end
	end
end
CoD.CACUtility.IsItemRefLocked = function ( f339_arg0, f339_arg1, f339_arg2 )
	if not f339_arg2 then
		f339_arg2 = Engine[@"currentsessionmode"]()
	end
	if not CoD.CACUtility.IsProgressionEnabled( f339_arg2 ) then
		return false
	else
		local f339_local0 = Engine[@"hash_2D97229B24C685D5"]( f339_arg1, f339_arg2 )
		if f339_local0 > CoD.CACUtility.EmptyItemIndex then
			return Engine[@"isitemlocked"]( f339_arg0, f339_local0, f339_arg2 )
		else
			return false
		end
	end
end
CoD.CACUtility.IsCACItemLocked = function ( f340_arg0, f340_arg1, f340_arg2 )
	local f340_local0 = CoD.BaseUtility.GetMenuSessionMode( f340_arg0 )
	if CoD.CraftUtility.Paintjobs.IsEditor( f340_arg0 ) then
		return false
	elseif not CoD.CACUtility.IsProgressionEnabled( f340_local0 ) then
		return false
	else
		local f340_local1 = f340_arg1:getModel()
		if f340_local1 and f340_local1.globalItemIndex then
			return Engine[@"isitemlocked"]( f340_arg2, f340_local1.globalItemIndex:get(), f340_local0 )
		else
			return false
		end
	end
end
CoD.CACUtility.IsCACBlackMarketItemLocked = function ( f341_arg0, f341_arg1, f341_arg2 )
	local f341_local0 = f341_arg1:getModel( f341_arg2, "refHash" )
	local f341_local1 = f341_local0 and f341_local0:get()
	if f341_local1 then
		local f341_local2, f341_local3 = CoD.BlackMarketTableUtility.SimpleLootLookup( f341_arg2, f341_local1 )
		if f341_local2 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"] then
			local f341_local4
			if not f341_local3 and not CoD.CACUtility.IsMark2Weapon( f341_arg2, f341_arg1 ) then
				f341_local4 = not CoD.CACUtility.IsMastercraft( f341_arg2, f341_arg1 )
			else
				f341_local4 = false
			end
			return f341_local4
		end
	end
	return false
end
CoD.CACUtility.IsSignatureWeaponLockedByProgression = function ( f342_arg0, f342_arg1, f342_arg2 )
	local f342_local0 = CoD.BaseUtility.GetMenuSessionMode( f342_arg0 )
	if CoD.CraftUtility.Paintjobs.IsEditor( f342_arg0 ) then
		return false
	elseif not CoD.CACUtility.IsProgressionEnabled( f342_local0 ) then
		return false
	else
		local f342_local1 = f342_arg1:getModel()
		if f342_local1 and f342_local1.itemIndex then
			return Engine[@"isitemlocked"]( f342_arg2, f342_local1.itemIndex:get(), f342_local0 )
		else
			return false
		end
	end
end
CoD.CACUtility.IsCACAttachmentItemLocked = function ( f343_arg0, f343_arg1, f343_arg2 )
	local f343_local0, f343_local1, f343_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f343_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f343_local1 ) then
		return false
	elseif LuaUtils.IsArenaMode() then
		return false
	else
		local f343_local3 = f343_arg1:getModel()
		if f343_local0 and f343_local2 and f343_local3 then
			return Engine[@"isitemattachmentlocked"]( f343_arg2, f343_local0[f343_local2].itemIndex:get(), f343_local3.itemIndex:get(), f343_local1 )
		else
			return false
		end
	end
end
CoD.CACUtility.ShouldHideItemNameText = function ( f344_arg0, f344_arg1 )
	local f344_local0 = IsElementPropertyValue( f344_arg0, "_hideItemName", true )
	if not f344_local0 then
		if not IsElementPropertyValue( f344_arg0, "_showItemNameOnButtonHold", true ) or CoD.ModelUtility.AreButtonModelValueBitsSet( f344_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibuttonflags"][@"flag_down"] ) then
			f344_local0 = CoD.ModelUtility.AreButtonModelValueBitsSet( f344_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibuttonflags"][@"flag_down"] )
			if f344_local0 then
				if f344_arg0.occludedBy == nil then
					f344_local0 = false
				else
					f344_local0 = true
				end
			else
				return f344_local0
			end
		end
		f344_local0 = true
	end
	return f344_local0
end
CoD.CACUtility.IsFeatureItemLocked = function ( f345_arg0, f345_arg1, f345_arg2 )
	if CoD.CACUtility.IsProgressionEnabled( f345_arg2 ) then
		return f345_arg1 and Engine[@"isitemlocked"]( f345_arg0, f345_arg1, f345_arg2 )
	else
		return false
	end
end
CoD.CACUtility.IsCurrentClassLocked = function ( f346_arg0, f346_arg1 )
	local f346_local0 = CoD.BaseUtility.GetMenuModel( f346_arg0 )
	local f346_local1 = CoD.BaseUtility.GetMenuSessionMode( f346_arg0 )
	if f346_local0 then
		return CoD.CACUtility.IsFeatureItemLocked( f346_arg1, CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f346_local0.classNum:get(), "featureItemIndex" ), f346_local1 )
	else
		return false
	end
end
CoD.CACUtility.IsClassLocked = function ( f347_arg0, f347_arg1 )
	if not CoD.isFrontend then
		return CoD.CACUtility.IsFeatureItemLocked( f347_arg0, CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f347_arg1, "featureItemIndex" ), Engine[@"currentsessionmode"]() )
	else
		return true
	end
end
CoD.CACUtility.IsCurrentElementClassLocked = function ( f348_arg0, f348_arg1, f348_arg2 )
	local f348_local0 = CoD.BaseUtility.GetMenuSessionMode( f348_arg0 )
	local f348_local1 = f348_arg1:getModel()
	if f348_local1 and f348_local1.classNum then
		return CoD.CACUtility.IsFeatureItemLocked( f348_arg2, CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f348_local1.classNum:get(), "featureItemIndex" ), f348_local0 )
	else
		return false
	end
end
CoD.CACUtility.IsCACItemConsumable = function ( f349_arg0, f349_arg1, f349_arg2 )
	local f349_local0 = CoD.BaseUtility.GetMenuSessionMode( f349_arg0 )
	local f349_local1 = f349_arg1:getModel()
	if f349_local1 and f349_local1.itemIndex then
		local f349_local2 = f349_local1.itemIndex:get()
		if f349_local2 and CoD.CACUtility.EmptyItemIndex < f349_local2 then
			return CoD.CACUtility.IsItemConsumable( f349_local2, f349_arg2, f349_local0 )
		end
	end
	return false
end
CoD.CACUtility.DoesCACItemHaveConsumablesRemaining = function ( f350_arg0, f350_arg1, f350_arg2, f350_arg3 )
	if not CoD.CACUtility.IsCACItemConsumable( f350_arg0, f350_arg1, f350_arg3 ) then
		return true
	end
	local f350_local0 = f350_arg1:getModel()
	if f350_local0 and f350_local0.itemIndex then
		local f350_local1 = f350_local0.itemIndex:get()
		if f350_local1 and CoD.CACUtility.EmptyItemIndex < f350_local1 then
			return CoD.CACUtility.GetConsumableCountFromIndex( f350_arg2, f350_arg0, f350_arg3, f350_local1 ) > 0
		end
	end
	return false
end
CoD.CACUtility.IsCACItemMutuallyExclusiveWithSelection = function ( f351_arg0, f351_arg1, f351_arg2 )
	local f351_local0 = CoD.BaseUtility.GetMenuModel( f351_arg0 )
	local f351_local1 = CoD.BaseUtility.GetMenuSessionMode( f351_arg0 )
	local f351_local2 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f351_arg0 )
	local f351_local3 = f351_arg1:getModel()
	if f351_local2 and f351_local3 and f351_local3.itemIndex then
		local f351_local4 = CoD.CACUtility.GetMutuallyExclusiveSlotName( f351_arg2, f351_local0, f351_local2, f351_local3.itemIndex:get(), nil, f351_local1 )
		for f351_local5 = 1, #f351_local4, 1 do
			if f351_local4[f351_local5] ~= "" then
				return true
			end
		end
	end
	return false
end
CoD.CACUtility.HasSignatureWeapons = function ( f352_arg0, f352_arg1, f352_arg2 )
	local f352_local0 = f352_arg1:getModel()
	local f352_local1 = 0
	local f352_local2 = CoD.BaseUtility.GetMenuSessionMode( f352_arg0 )
	if f352_local0 and f352_local0.itemIndex then
		local f352_local3 = CoD.CACUtility.GetUnlockableItemInfo( f352_local0.itemIndex:get(), f352_local2 )
		local f352_local4 = f352_local3.nameHash
		for f352_local8, f352_local9 in CoD.CACUtility.ForAvailableSignatureWeapons( f352_arg2, f352_local4, not IsCurrentMenu( f352_arg0, "PaintjobWeaponSelect" ) ) do
			f352_local1 = f352_local1 + 1
		end
		f352_local5 = CoD.BlackMarketTableUtility.LootInfoLookup( f352_arg2, f352_local4 )
		if f352_local5 and f352_local5.useVariantSlot then
			f352_local1 = f352_local1 - 1
		end
	end
	return f352_local1 > 1
end
CoD.CACUtility.IsAttachmentWithCustomReticle = function ( f353_arg0, f353_arg1 )
	local f353_local0 = f353_arg1:getModel()
	local f353_local1 = nil
	if f353_local0 and f353_local0.ref then
		f353_local1 = f353_local0.ref:get()
	elseif f353_local0 and f353_local0.attachmentRef then
		f353_local1 = f353_local0.attachmentRef:get()
	end
	if f353_local1 then
		return CoD.CACUtility.AttachmentHasCustomReticle( f353_local1 )
	else
		return false
	end
end
CoD.CACUtility.GetHeaderNameForLoadoutSlot = function ( f354_arg0, f354_arg1 )
	local f354_local0 = nil
	if f354_arg0 then
		f354_local0 = CoD.BaseUtility.GetMenuLoadoutSlot( f354_arg0 )
	end
	if f354_local0 then
		for f354_local4, f354_local5 in ipairs( CoD.CACUtility.loadoutSlotInfo ) do
			if f354_local5.loadoutSlot == f354_local0 then
				if f354_local5.zmName and CoD.BaseUtility.IsMenuSessionModeEqualTo( f354_arg0, Enum[@"emodes"][@"mode_zombies"] ) then
					return f354_local5.zmName
				end
				return f354_local5.name
			end
		end
	end
	return f354_arg1
end
CoD.CACUtility.GetItemImageFromIndex = function ( f355_arg0, f355_arg1, f355_arg2 )
	local f355_local0 = CoD.BaseUtility.GetMenuSessionMode( f355_arg0 )
	if not f355_arg1 then
		f355_arg1 = Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"]
	end
	return Engine[@"getitemimage"]( f355_arg2, f355_arg1, f355_local0 )
end
CoD.CACUtility.GetItemNameFromIndex = function ( f356_arg0, f356_arg1, f356_arg2 )
	local f356_local0 = CoD.BaseUtility.GetMenuSessionMode( f356_arg0 )
	if not f356_arg1 then
		f356_arg1 = Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"]
	end
	return Engine[@"getitemname"]( f356_arg2, f356_arg1, f356_local0 )
end
CoD.CACUtility.GetItemDescriptionFromIndex = function ( f357_arg0, f357_arg1, f357_arg2 )
	local f357_local0 = CoD.BaseUtility.GetMenuSessionMode( f357_arg0 )
	if not f357_arg1 then
		f357_arg1 = Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"]
	end
	return Engine[@"getitemdesc"]( f357_arg2, f357_arg1, f357_local0 )
end
CoD.CACUtility.GetCurrentWeaponLevel = function ( f358_arg0, f358_arg1, f358_arg2 )
	local f358_local0 = f358_arg1
	local f358_local1 = CoD.BaseUtility.GetMenuSessionMode( f358_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f358_local1 ) then
		return 1
	else
		local f358_local2 = tonumber( f358_arg2 )
		if f358_local2 <= CoD.CACUtility.EmptyItemIndex then
			return 1
		else
			local f358_local3 = Engine[@"getguncurrentrank"]( f358_local0, f358_local2, f358_local1 )
			if CoD.CACUtility.IsWeaponLevelMax( f358_local0, f358_local2, f358_local1 ) then
				return Engine[@"hash_4F9F1239CFD921FE"]( 0x4EF66575DDB929 )
			else
				return f358_local3 + 1
			end
		end
	end
end
CoD.CACUtility.LocalizeCurrentWeaponLevelIntoString = function ( f359_arg0, f359_arg1, f359_arg2, f359_arg3 )
	return Engine[@"hash_4F9F1239CFD921FE"]( f359_arg1, CoD.CACUtility.GetCurrentWeaponLevel( f359_arg0, f359_arg2, f359_arg3 ) )
end
CoD.CACUtility.GetNextWeaponLevel = function ( f360_arg0, f360_arg1, f360_arg2 )
	local f360_local0 = f360_arg1
	local f360_local1 = CoD.BaseUtility.GetMenuSessionMode( f360_arg0 )
	local f360_local2 = tonumber( f360_arg2 )
	if f360_local2 <= CoD.CACUtility.EmptyItemIndex then
		return 1
	else
		return Engine[@"getguncurrentrank"]( f360_local0, f360_local2, f360_local1 ) + 2
	end
end
CoD.CACUtility.GetCurrentWeaponXP = function ( f361_arg0, f361_arg1, f361_arg2, f361_arg3, f361_arg4, f361_arg5 )
	local f361_local0 = f361_arg1
	local f361_local1 = CoD.BaseUtility.GetMenuSessionMode( f361_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f361_local1 ) then
		return 0, f361_arg3, f361_arg4, f361_arg5
	else
		local f361_local2 = tonumber( f361_arg2 )
		if f361_local2 <= CoD.CACUtility.EmptyItemIndex then
			return 0, f361_arg3, f361_arg4, f361_arg5
		else
			local f361_local3 = Engine[@"getgunprevrankxp"]( f361_local0, f361_local2, f361_local1 )
			return (Engine[@"getguncurrentrankxp"]( f361_local0, f361_local2, f361_local1 ) - f361_local3) / (Engine[@"hash_7FF3DA2744A0F3A3"]( f361_local0, f361_local2, f361_local1 ) - f361_local3), f361_arg3, f361_arg4, f361_arg5
		end
	end
end
CoD.CACUtility.GetAttachmentUnlockDescription = function ( f362_arg0, f362_arg1, f362_arg2 )
	local f362_local0 = f362_arg1
	local f362_local1 = tonumber( f362_arg2 )
	local f362_local2, f362_local3, f362_local4 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f362_arg0 )
	if CoD.CACUtility.IsProgressionEnabled( f362_local3 ) and f362_local2 and f362_local2[f362_local4] then
		local f362_local5 = CoD.SafeGetModelValue( f362_local2[f362_local4], "itemIndex" )
		if f362_local5 and f362_local5 > CoD.CACUtility.EmptyItemIndex then
			local f362_local6 = Engine[@"getitemattachmentrank"]( f362_local5, f362_local1, f362_local3 )
			if f362_local6 then
				return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1EF33BF324CE24F5", f362_local6 + 2 )
			end
		end
	end
	return 0x0
end
CoD.CACUtility.GetUnlockDescription = function ( f363_arg0, f363_arg1, f363_arg2 )
	local f363_local0 = f363_arg1
	local f363_local1 = tonumber( f363_arg2 )
	local f363_local2 = CoD.BaseUtility.GetMenuSessionMode( f363_arg0 )
	local f363_local3 = CoD.CACUtility.GetStatIndexOffsetForLoadoutSlot( CoD.BaseUtility.GetMenuLoadoutSlot( f363_arg0 ), f363_local2 )
	if CoD.CACUtility.IsProgressionEnabled( f363_local2 ) and f363_local2 and f363_local3 and f363_local1 and f363_local1 > CoD.CACUtility.EmptyItemIndex then
		return CoD.GetUnlockStringForItemIndex( f363_local0, f363_local1, f363_local3, f363_local2 )
	else
		return ""
	end
end
CoD.CACUtility.GetUnlockDescriptionForFeature = function ( f364_arg0, f364_arg1, f364_arg2 )
	local f364_local0 = f364_arg1
	local f364_local1 = CoD.BaseUtility.GetMenuSessionMode( f364_arg0 )
	local f364_local2 = CoD.BaseUtility.GetMenuModel( f364_arg0 )
	if f364_local2 and f364_local1 and CoD.CACUtility.IsProgressionEnabled( f364_local1 ) then
		local f364_local3 = CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f364_local2.classNum:get(), "featureItemIndex" )
		if f364_local3 then
			return CoD.GetUnlockStringForItemIndex( f364_local0, f364_local3, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f364_local1 )
		end
	end
	return ""
end
CoD.CACUtility.GetUnlockRankIconLargeForFeature = function ( f365_arg0, f365_arg1 )
	local f365_local0 = CoD.BaseUtility.GetMenuSessionMode( f365_arg0 )
	local f365_local1 = CoD.BaseUtility.GetMenuModel( f365_arg0 )
	if f365_local1 and f365_local0 and CoD.CACUtility.IsProgressionEnabled( f365_local0 ) then
		local f365_local2 = CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f365_local1.classNum:get(), "featureItemIndex" )
		if f365_local2 then
			return Engine[@"hash_7E1B786B1A765D9E"]( Engine[@"getitemunlocklevel"]( f365_local2, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f365_local0 ), f365_local0 )
		end
	end
	return 0x0
end
CoD.CACUtility.GetRemoveItemString = function ( f366_arg0, f366_arg1, f366_arg2 )
	local f366_local0 = f366_arg1
	local f366_local1 = Engine[@"getmodelforcontroller"]( f366_arg0 )
	local f366_local2 = f366_local1.CACMenu.numItemsToRemove:get()
	if f366_local2 > 1 then
		f366_local0 = f366_arg2
	end
	return Engine[@"hash_4F9F1239CFD921FE"]( f366_local0, f366_local2 )
end
CoD.CACUtility.GetRemoveItemTitle = function ( f367_arg0, f367_arg1 )
	return GetRemoveItemString( f367_arg0, @"hash_5893950C8EC6797B", @"hash_BEC830810F92DDE" )
end
CoD.CACUtility.GetRemoveItemDescription = function ( f368_arg0, f368_arg1 )
	return CoD.CACUtility.GetRemoveItemString( f368_arg0, @"hash_3F7843044F0AE6D", 0x4362982FF996EE )
end
CoD.CACUtility.RemoveEmptyString = function ( f369_arg0 )
	if f369_arg0 == @"menu/empty" then
		return 0x0
	elseif type( f369_arg0 ) == "string" and Engine[@"hash_4F9F1239CFD921FE"]( @"menu/empty" ) == f369_arg0 then
		return ""
	else
		return f369_arg0
	end
end
CoD.CACUtility.FilterSignatureWeapon = function ( f370_arg0, f370_arg1, f370_arg2, f370_arg3 )
	if f370_arg2 then
		local f370_local0 = f370_arg1[@"hash_5C2AA73D9F82E9C2"]
		if not f370_local0 and f370_arg1[@"index"] ~= 0 then
			return f370_local0
		end
	end
	if CoD.CACUtility.DvarHideUnlockableItem( f370_arg1[@"lootid"] ) then
		return false
	end
	local f370_local0 = CoD.BlackMarketTableUtility.LootInfoLookup( f370_arg0, f370_arg1[@"lootid"] )
	if f370_local0.isLoot then
		if f370_arg3 then
			if not f370_local0.owned then
				return false
			end
			return true
		elseif not f370_local0.available then
			return false
		end
		return true
	elseif f370_arg1[@"entitlement"] ~= 0x0 and Engine[@"hasentitlement"]( f370_arg0, f370_arg1[@"entitlement"] ) then
		return true
	end
	return f370_arg1[@"index"] == 0
end
CoD.CACUtility.ForAvailableSignatureWeapons = function ( f371_arg0, f371_arg1, f371_arg2, f371_arg3 )
	return LuaUtils.IterateFilteredArray( Engine[@"hash_79F0BB7D52A7A978"]( f371_arg1 ), function ( f372_arg0, f372_arg1 )
		return CoD.CACUtility.FilterSignatureWeapon( f371_arg0, f372_arg1, not f371_arg2, f371_arg3 )
	end
	 )
end
CoD.CACUtility.GetConsumableCountFromIndex = function ( f373_arg0, f373_arg1, f373_arg2, f373_arg3 )
	local f373_local0 = f373_arg0
	local f373_local1 = CoD.BaseUtility.GetMenuSessionMode( f373_arg1 )
	if not f373_local1 then
		f373_local1 = Engine[@"currentsessionmode"]()
	end
	local f373_local2 = Engine[@"hash_3475AAFCBC9AF822"]( f373_local0, Engine[@"hash_7B98952F69D937F9"]( f373_arg3, f373_arg2, f373_local1 ), f373_local1 )
	if not f373_local2 then
		return 0
	else
		return math.min( 999, math.max( f373_local2, 0 ) )
	end
end
CoD.CACUtility.SetBaseWeaponNameAlpha = function ( f374_arg0, f374_arg1, f374_arg2, f374_arg3, f374_arg4 )
	local f374_local0 = 0
	local f374_local1, f374_local2, f374_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f374_arg1 )
	local f374_local4 = f374_arg4
	if f374_local1 and f374_arg3 and f374_local2 and f374_local4 then
		local f374_local5 = Engine[@"hash_79F0BB7D52A7A978"]( Engine[@"hash_7B98952F69D937F9"]( f374_local4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f374_local2 ) )
		local f374_local6
		if f374_local2 ~= Enum[@"emodes"][@"mode_zombies"] then
			f374_local6 = f374_local1[f374_arg3].weaponModelSlot:get() + 1
			if not f374_local6 then
			
			elseif f374_local5 and f374_local6 and f374_local5[f374_local6] and f374_local5[f374_local6][@"hash_5C2AA73D9F82E9C2"] then
				f374_local0 = 1
			end
		end
		f374_local6 = CoD.ZMLoadoutUtility.GetWeaponModelSlot( f374_local4, controller ) + 1
	end
	return f374_local0
end
CoD.CACUtility.EquipClassItemOptionSlot = function ( f375_arg0, f375_arg1, f375_arg2, f375_arg3, f375_arg4, f375_arg5, f375_arg6 )
	AttemptAttachItem( f375_arg0, f375_arg1, f375_arg6, f375_arg5, f375_arg3, f375_arg4, nil )
end
CoD.CACUtility.GetClassItemOptionEquipSlot = function ( f376_arg0, f376_arg1, f376_arg2, f376_arg3 )
	for f376_local0 = 1, f376_arg3, 1 do
		local f376_local3 = f376_arg2[f376_local0]
		if f376_arg1[f376_local3].itemIndex:get() == f376_arg0 then
			return f376_local3
		end
	end
	return nil
end
CoD.CACUtility.SelectClassItemOption = function ( f377_arg0, f377_arg1, f377_arg2, f377_arg3, f377_arg4 )
	local f377_local0 = CoD.BaseUtility.GetMenuModel( f377_arg1 )
	local f377_local1 = CoD.BaseUtility.GetMenuSessionMode( f377_arg1 )
	if CoD.CACUtility.GetClassItemOptionEquipSlot( f377_arg0, f377_local0, f377_arg3, f377_arg4 ) == nil then
		local f377_local2 = CoD.CACUtility.GetClassItemOptionEquipSlot( 0, f377_local0, f377_arg3, f377_arg4 )
		if f377_local2 then
			CoD.CACUtility.EquipClassItemOptionSlot( f377_arg1, f377_arg2, f377_local2, f377_arg0, f377_local0, f377_local1 )
		end
	end
end
CoD.CACUtility.UnequipClassItemOption = function ( f378_arg0, f378_arg1, f378_arg2, f378_arg3, f378_arg4, f378_arg5, f378_arg6, f378_arg7 )
	local f378_local0 = f378_arg3.classNum:get()
	local f378_local1 = CoD.CACUtility.GetClassItemOptionEquipSlot( f378_arg4, f378_arg3, f378_arg5, f378_arg6 )
	if f378_local1 == nil then
		return 
	end
	local f378_local2 = LuaUtils.FindItemInArray( f378_arg5, f378_local1 )
	local f378_local3 = f378_arg6
	local f378_local4 = f378_local2 + 1
	while f378_local2 <= f378_local3 do
		CoD.CACUtility.EquipClassItemOptionSlot( f378_arg0, f378_arg1, f378_arg5[f378_local2], CoD.CACUtility.EmptyItemIndex, f378_arg3, f378_arg2 )
		local f378_local5 = nil
		if f378_local4 <= f378_local3 then
			f378_local5 = CoD.CACUtility.GetClassItem( f378_arg1, f378_local0, f378_arg5[f378_local4], f378_arg2 )
			while not f378_arg7( f378_arg1, f378_arg3, f378_local5, f378_local4, f378_arg2 ) do
				f378_local4 = f378_local4 + 1
				if f378_local3 < f378_local4 then
					break
				end
				f378_local5 = CoD.CACUtility.GetClassItem( f378_arg1, f378_local0, f378_arg5[f378_local4], f378_arg2 )
			end
		end
		if f378_local4 <= f378_local3 then
			CoD.CACUtility.EquipClassItemOptionSlot( f378_arg0, f378_arg1, f378_arg5[f378_local2], f378_local5, f378_arg3, f378_arg2 )
			f378_local4 = f378_local4 + 1
		end
		f378_local2 = f378_local2 + 1
	end
end
CoD.CACUtility.IsClassOptionEquipped = function ( f379_arg0, f379_arg1, f379_arg2, f379_arg3 )
	local f379_local0 = CoD.BaseUtility.GetMenuModel( f379_arg0 )
	local f379_local1 = f379_arg1:getModel()
	return CoD.CACUtility.GetClassItemOptionEquipSlot( f379_local1.itemIndex:get(), f379_local0, f379_arg2, f379_arg3 ) ~= nil
end
CoD.CACUtility.IsClassOptionEquippedByIndex = function ( f380_arg0, f380_arg1, f380_arg2, f380_arg3 )
	return CoD.CACUtility.GetClassItemOptionEquipSlot( f380_arg1, CoD.BaseUtility.GetMenuModel( f380_arg0 ), f380_arg2, f380_arg3 ) ~= nil
end
CoD.CACUtility.ChangeClass = function ( f381_arg0, f381_arg1, f381_arg2 )
	local f381_local0 = f381_arg1
	local f381_local1 = ""
	if f381_arg2 ~= nil then
		f381_local1 = string.lower( f381_arg2 )
		f381_arg1 = Engine[@"getclassindexfromname"]( f381_arg2 )
	else
		f381_local1 = "custom" .. f381_arg1
	end
	local f381_local2 = CoD.gameModeEnum
	if f381_local2 == Enum[@"emodes"][@"mode_campaign"] and CoD.perController[f381_arg0].fieldOpsKitClassNum ~= f381_arg1 + 1 then
		CoD.CACUtility.SetShowcaseWeaponToClassPrimary( f381_arg0, f381_arg1 )
		SaveLoadoutGeneric( f381_arg0 )
	end
	if f381_local2 == Enum[@"emodes"][@"mode_campaign"] or f381_local2 == Enum[@"emodes"][@"mode_multiplayer"] then
		CoD.CACUtility.SetSelectedCustomClass( f381_arg0, f381_local2, f381_arg1 )
	end
	if IsMultiplayer() then
		Engine[@"sendmenuresponse"]( f381_arg0, CoD.CACUtility.PositionDraftMenuName, f381_local1, 0 )
	end
	CoD.CACUtility.SetProfileLoadoutChoice( f381_arg0, f381_arg1 )
	if IsInGame() then
		if not IsCampaign() then
			HUD_IngameMenuClosed()
		end
		Engine[@"streamsetcustomclass"]( f381_arg0, f381_local0 )
	end
end
CoD.CACUtility.AddGlobalRightStickSingleItemControlForSessionMode = function ( f382_arg0, f382_arg1, f382_arg2, f382_arg3, f382_arg4 )
	if not f382_arg0._perModeGridOrList then
		f382_arg0._perModeGridOrList = {}
	end
	f382_arg0._perModeGridOrList[f382_arg3] = f382_arg1
	if IsFreeCursorActive( f382_arg2 ) then
		f382_arg0:AddButtonCallbackFunction( f382_arg0, f382_arg2, Enum[@"luibutton"][@"lui_key_left"], nil, function ( element, menu, controller, model )
			local f383_local0 = menu._perModeGridOrList[CoD.BaseUtility.GetMenuSessionMode( menu )]
			if f383_local0 and IsFreeCursorActive( controller ) and not IsDpadButton( model ) and not PropertyIsTrue( f383_local0, "m_disableNavigation" ) then
				f383_local0:navigateItemLeft()
				if ScoreboardVisible( controller ) then
					BlockGameFromKeyEvent( controller )
				end
			end
		end, AlwaysFalse, false )
		f382_arg0:AddButtonCallbackFunction( f382_arg0, f382_arg2, Enum[@"luibutton"][@"lui_key_right"], nil, function ( element, menu, controller, model )
			local f384_local0 = menu._perModeGridOrList[CoD.BaseUtility.GetMenuSessionMode( menu )]
			if f384_local0 and IsFreeCursorActive( controller ) and not IsDpadButton( model ) and not PropertyIsTrue( f384_local0, "m_disableNavigation" ) then
				f384_local0:navigateItemRight()
				if ScoreboardVisible( controller ) then
					BlockGameFromKeyEvent( controller )
				end
			end
		end, AlwaysFalse, false )
		f382_arg0:AddButtonCallbackFunction( f382_arg0, f382_arg2, Enum[@"luibutton"][@"lui_key_up"], nil, function ( element, menu, controller, model )
			local f385_local0 = menu._perModeGridOrList[CoD.BaseUtility.GetMenuSessionMode( menu )]
			if f385_local0 and IsFreeCursorActive( controller ) and not IsDpadButton( model ) and not PropertyIsTrue( f385_local0, "m_disableNavigation" ) then
				f385_local0:navigateItemUp()
				if ScoreboardVisible( controller ) then
					BlockGameFromKeyEvent( controller )
				end
			end
		end, AlwaysFalse, false )
		f382_arg0:AddButtonCallbackFunction( f382_arg0, f382_arg2, Enum[@"luibutton"][@"lui_key_down"], nil, function ( element, menu, controller, model )
			local f386_local0 = menu._perModeGridOrList[CoD.BaseUtility.GetMenuSessionMode( menu )]
			if f386_local0 and IsFreeCursorActive( controller ) and not IsDpadButton( model ) and not PropertyIsTrue( f386_local0, "m_disableNavigation" ) then
				f386_local0:navigateItemDown()
				if ScoreboardVisible( controller ) then
					BlockGameFromKeyEvent( controller )
				end
			end
		end, AlwaysFalse, false )
	end
	if f382_arg4 and IsPC() then
		CoD.GridAndListUtility.AddBumperNavigationInternal( f382_arg0, f382_arg1, f382_arg2, nil )
	end
end
CoD.CACUtility.MenuUsesAltWatermarkLocation = function ( f387_arg0 )
	local f387_local0 = Engine[@"getglobalmodel"]()
	f387_local0 = f387_local0.showPreAlphaText
	local f387_local1 = f387_local0 and f387_local0:get()
	if f387_local1 ~= nil and f387_local1 ~= 0 then
		f387_local0:set( 2 )
		LUI.OverrideFunction_CallOriginalSecond( f387_arg0, "close", function ()
			f387_local0:set( f387_local1 )
		end )
	end
end
CoD.CACUtility.WeaponSelectUpdateSigListIfInFocus = function ( f389_arg0, f389_arg1, f389_arg2, f389_arg3 )
	local f389_local0 = false
	if IsElementInFocus( f389_arg2 ) then
		f389_arg2:processEvent( {
			name = "lose_focus",
			controller = f389_arg1
		} )
		f389_local0 = true
	elseif IsElementInFocus( f389_arg3 ) then
		f389_arg3:processEvent( {
			name = "lose_focus",
			controller = f389_arg1
		} )
		f389_local0 = true
	end
	HideWidget( f389_arg3 )
	ShowWidget( f389_arg2 )
	if f389_local0 then
		local f389_local1 = Engine[@"getmodelforcontroller"]( f389_arg1 )
		f389_local1 = f389_local1.weaponSelectItemIndex
		local f389_local2 = f389_local1
		f389_local1 = f389_local1.set
		local f389_local3 = f389_arg0:getModel()
		f389_local1( f389_local2, f389_local3.itemIndex:get() )
		f389_arg2:processEvent( {
			name = "gain_focus",
			controller = f389_arg1
		} )
		CoD.GridAndListUtility.UpdateDataSource( f389_arg3, true, false, true )
	end
end
CoD.CACUtility.UpdateCACCurrentActiveTabIndexValue = function ( f390_arg0, f390_arg1 )
	if f390_arg1.activeWidget then
		local f390_local0 = Engine[@"getglobalmodel"]()
		f390_local0.CACCurrentActiveTabIndex:set( f390_arg1.activeWidget.gridInfoTable.gridColIndex )
	end
end
CoD.CACUtility.IsFirstCACTabInRowActive = function ( f391_arg0 )
	local f391_local0 = Engine[@"getglobalmodel"]()
	return f391_local0.CACCurrentActiveTabIndex:get() == 1
end
CoD.CACUtility.IsLastCACTabInRowActive = function ( f392_arg0, f392_arg1 )
	local f392_local0 = Engine[@"getglobalmodel"]()
	f392_local0 = f392_local0.CACCurrentActiveTabIndex:get()
	local f392_local1 = f392_arg1.itemCount
	local f392_local2
	if f392_local1 <= 1 or f392_local0 ~= f392_local1 then
		f392_local2 = false
	else
		f392_local2 = true
	end
	return f392_local2
end
CoD.CACUtility.UpdateCommonCurrentActiveTabIndexValue = function ( f393_arg0, f393_arg1 )
	if f393_arg1.Tabs and f393_arg1.Tabs.grid and f393_arg1.Tabs.grid.activeWidget then
		local f393_local0 = Engine[@"getglobalmodel"]()
		f393_local0.CommonCurrentActiveTabIndex:set( f393_arg1.Tabs.grid.activeWidget.gridInfoTable.gridColIndex )
	end
end
CoD.CACUtility.IsFirstCommonTabInRowActive = function ( f394_arg0 )
	local f394_local0 = Engine[@"getglobalmodel"]()
	return f394_local0.CommonCurrentActiveTabIndex:get() == 1
end
CoD.CACUtility.IsLastCommonTabInRowActive = function ( f395_arg0, f395_arg1 )
	local f395_local0 = Engine[@"getglobalmodel"]()
	f395_local0 = f395_local0.CommonCurrentActiveTabIndex:get()
	local f395_local1 = f395_arg1.grid.itemCount
	local f395_local2
	if f395_local1 <= 1 or f395_local0 ~= f395_local1 then
		f395_local2 = false
	else
		f395_local2 = true
	end
	return f395_local2
end
CoD.CACUtility.UpdateArmoryArrowState = function ( f396_arg0, f396_arg1, f396_arg2 )
	local f396_local0 = "CommonCurrentActiveTabIndex"
	local f396_local1 = Engine[@"getglobalmodel"]()
	f396_arg0:updateElementState( f396_arg2, {
		name = "model_validation",
		menu = f396_arg0,
		controller = f396_arg1,
		modelValue = f396_local1.CommonCurrentActiveTabIndex:get(),
		modelName = f396_local0
	} )
end
CoD.CACUtility.DvarHiddenUnlockableItems = {
	[@"hash_6B5FC66B55968364"] = {
		[@"zm_bgb_conflagration_liquidation"] = {},
		[@"zm_bgb_refresh_mint"] = {},
		[@"zm_bgb_perk_up"] = {}
	}
}
CoD.CACUtility.UnlockableItemsHiddenByDvar = {}
for f0_local7, f0_local8 in pairs( CoD.CACUtility.DvarHiddenUnlockableItems ) do
	for f0_local4, f0_local5 in pairs( f0_local8 ) do
		CoD.CACUtility.UnlockableItemsHiddenByDvar[f0_local4] = {}
		CoD.CACUtility.UnlockableItemsHiddenByDvar[f0_local4].dvar = f0_local7
		CoD.CACUtility.UnlockableItemsHiddenByDvar[f0_local4].modes = f0_local5
	end
end
CoD.CACUtility.DvarShownUnlockableItems = {
	[@"hash_65BDF5CF34DD4A2D"] = {
		[@"smg_folding_t8"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"shotgun_fullauto_t8"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_54A35A9A09159E10"] = {
		[@"loot_pistol_fullauto_mk2"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"loot_smg_burst_mk2"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"loot_ar_standard_mk2"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_49EF5478510B5AF3"] = {
		[@"perk_zombshell"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_37C3EBC11793A175"] = {
		[@"zm_bgb_suit_up"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_dividend_yield"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_talkin_bout_regeneration"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_bullet_boost"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_quacknarok"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_4686ED971E896201"] = {
		[@"talisman_permanent_heroweap_armor"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"talisman_extra_self_revive"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_5715F2013B7512B0"] = {
		[@"lmg_stealth_t8"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[0x956C9A593B283C] = {
		[@"loot_dlc_full_autoshotgun_mk2"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"loot_dlc_breifcase_smg_mk2"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"loot_ar_stealth_mk2"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"loot_smg_fastfire_mk2"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_3323F1A0F6C70ED0"] = {
		[@"sniper_mini14_t8"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_1E30B8B2F3629DA3"] = {
		[@"zm_bgb_perkaholic"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_near_death_experience"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_shopping_free"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_reign_drops"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_5BFA5BDA576BE7C4"] = {
		[@"zm_bgb_head_drama"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_phoenix_up"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_21232038A2928EDD"] = {
		[@"zm_bgb_power_vacuum"] = {
			Enum[@"emodes"][@"mode_zombies"]
		},
		[@"zm_bgb_secret_shopper"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_4E1190045EF3588B"] = {
		[@"perk_wolf_protector"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	},
	[@"hash_1C1A8ED8D0BF271C"] = {
		[@"perk_death_dash"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	}
}
CoD.CACUtility.DvarUnlockableItemsHasAttachments = {
	[@"hash_7DC2E4C6EDDB0062"] = {
		[@"ar_galil_t8"] = {
			Enum[@"emodes"][@"mode_zombies"]
		}
	}
}
CoD.CACUtility.UnlockableItemsShownByDvar = {}
for f0_local7, f0_local8 in pairs( CoD.CACUtility.DvarShownUnlockableItems ) do
	for f0_local4, f0_local5 in pairs( f0_local8 ) do
		CoD.CACUtility.UnlockableItemsShownByDvar[f0_local4] = {}
		CoD.CACUtility.UnlockableItemsShownByDvar[f0_local4].dvar = f0_local7
		CoD.CACUtility.UnlockableItemsShownByDvar[f0_local4].modes = f0_local5
	end
end
CoD.CACUtility.DvarHideUnlockableItem = function ( f397_arg0, f397_arg1 )
	local f397_local0 = function ( f398_arg0, f398_arg1 )
		if #f398_arg1.modes == 0 then
			return true
		end
		for f398_local3, f398_local4 in ipairs( f398_arg1.modes ) do
			if f398_local4 == f398_arg0 then
				return true
			end
		end
		return false
	end
	
	if f397_arg1 == nil then
		f397_arg1 = Engine[@"currentsessionmode"]()
	end
	local f397_local1 = CoD.CACUtility.UnlockableItemsShownByDvar[f397_arg0]
	if f397_local1 and f397_local0( f397_arg1, f397_local1 ) and f397_local1.dvar ~= nil then
		return not IsBooleanDvarSet( f397_local1.dvar )
	else
		f397_local1 = CoD.CACUtility.UnlockableItemsHiddenByDvar[f397_arg0]
		if f397_local1 and f397_local0( f397_arg1, f397_local1 ) and f397_local1.dvar ~= nil then
			return IsBooleanDvarSet( f397_local1.dvar )
		else
			return false
		end
	end
end
CoD.CACUtility.UnlockableItemsHaveAttachmentsByDvar = {}
for f0_local7, f0_local8 in pairs( CoD.CACUtility.DvarUnlockableItemsHasAttachments ) do
	for f0_local4, f0_local5 in pairs( f0_local8 ) do
		CoD.CACUtility.UnlockableItemsHaveAttachmentsByDvar[f0_local4] = {}
		CoD.CACUtility.UnlockableItemsHaveAttachmentsByDvar[f0_local4].dvar = f0_local7
		CoD.CACUtility.UnlockableItemsHaveAttachmentsByDvar[f0_local4].modes = f0_local5
	end
end
CoD.CACUtility.DvarUnlockableItemHasNoAttachments = function ( f399_arg0, f399_arg1 )
	local f399_local0 = function ( f400_arg0, f400_arg1 )
		if #f400_arg1.modes == 0 then
			return true
		end
		for f400_local3, f400_local4 in ipairs( f400_arg1.modes ) do
			if f400_local4 == f400_arg0 then
				return true
			end
		end
		return false
	end
	
	if f399_arg1 == nil then
		f399_arg1 = Engine[@"currentsessionmode"]()
	end
	local f399_local1 = CoD.CACUtility.UnlockableItemsHaveAttachmentsByDvar[f399_arg0]
	if f399_local1 and f399_local0( f399_arg1, f399_local1 ) and f399_local1.dvar ~= nil then
		return not IsBooleanDvarSet( f399_local1.dvar )
	else
		return false
	end
end
DataSources.Unlockables = ListHelper_SetupDataSource( "Unlockables", function ( f401_arg0, f401_arg1 )
	local f401_local0 = {}
	local f401_local1, f401_local2, f401_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f401_arg1.menu )
	local f401_local4 = CoD.CACUtility.GetItemIndexEquippedInSlot( f401_local3, f401_arg0, f401_local1 )
	local f401_local5, f401_local6, f401_local7, f401_local8 = nil
	if f401_local3 == "primary" or f401_local3 == "secondary" then
		f401_local8 = CoD.CACUtility.GetUnlockableItemsForItemGroup( f401_arg0, f401_local2, f401_arg1.menu.__itemGroup )
	elseif f401_local3 == "equippedbubblegumpack" then
		f401_local8 = CoD.CACUtility.GetUnlockableBGBItemsForItemGroupAndRarity( f401_local2, f401_arg1.menu.__itemGroup, f401_arg1.menu.__rarity )
	elseif CoD.ZMLoadoutUtility and f401_local3 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
		f401_local8 = CoD.ZMLoadoutUtility.GetZombieStartWeaponsForForCategory( f401_arg1.menu, f401_local2 )
	elseif f401_local3 == "talent" then
		f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_arg1.menu._talentFilter )
	elseif f401_local3 == "talisman1" then
		f401_local8 = CoD.CACUtility.GetUnlockableTalismanItemsForRarity( f401_local2, f401_arg1.menu.__rarity )
	elseif f401_local3 == "armory" then
		local f401_local9 = f401_arg1.menu.__loadoutType
		if f401_local9 == "primary" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForItemGroup( f401_arg0, f401_local2, f401_arg1.menu.__itemGroup )
		elseif f401_local9 == "secondary" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local9, f401_arg0, true )
		else
			f401_local8 = {}
		end
	elseif f401_local3 == "wzpersonalize" then
		f401_local8 = CoD.WZUtility.GetPersonalizeItemsForItemGroup( f401_arg0, f401_arg1.menu.__loadoutType, f401_arg1.menu.__itemGroup )
	elseif f401_local3 == "bonuscard" then
		f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local3 )
		f401_local5 = CoD.BonuscardUtility.GetEquippedIncompatibleBonuscards( f401_local1, f401_local2 )
		f401_local6 = CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot( CoD.BaseUtility.GetMenuContextualEquipSlot( f401_arg1.menu ), "contextualBonuscards" )
		if f401_local6 then
			for f401_local13, f401_local14 in ipairs( f401_local6 ) do
				if not CoD.BonuscardUtility.IsBonuscardEquipped( f401_local1, f401_local14, f401_local2 ) then
					f401_local7 = Engine[@"hash_2D97229B24C685D5"]( f401_local14, f401_local2 )
				end
			end
		end
	else
		f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local3 )
	end
	local f401_local9 = f401_arg1.menu.__ignoreUnlockablesDefaultSelectIndex
	for f401_local13, f401_local14 in ipairs( f401_local8 ) do
		if f401_local14.allocation ~= -1 then
			local f401_local15 = CoD.CACUtility.BuildItemModelDataFromUnlockableItem( f401_arg1.menu, f401_arg0, f401_local14, f401_local4, f401_local5, f401_local6, f401_local7 )
			if f401_local15 then
				if not f401_local9 and f401_local15.properties and f401_local15.properties.selectIndex then
					f401_local9 = true
				end
				if f401_local15.models and (f401_local2 == Enum[@"emodes"][@"mode_zombies"] or not f401_local15.models.isRestricted) then
					table.insert( f401_local0, f401_local15 )
				end
			end
		end
	end
	if not f401_local9 and #f401_local0 > 0 then
		f401_local0[1].properties.selectIndex = true
	end
	return f401_local0
end, true, {
	getSpacerAfterColumn = function ( f402_arg0, f402_arg1, f402_arg2 )
		local f402_local0 = f402_arg0[f402_arg0.dataSourceName]
		if f402_local0[f402_arg1] then
			return f402_local0[f402_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getSpacerAfterRow = function ( f403_arg0, f403_arg1, f403_arg2 )
		local f403_local0 = f403_arg0[f403_arg0.dataSourceName]
		if f403_local0[f403_arg1] then
			return f403_local0[f403_arg1].properties.hSpacing or 0
		else
			return 0
		end
	end
} )
DataSources.SignatureWeapons = ListHelper_SetupDataSource( "SignatureWeapons", function ( f404_arg0, f404_arg1 )
	local f404_local0 = {}
	local f404_local1 = CoD.BaseUtility.GetMenuSessionMode( f404_arg1.menu )
	local f404_local2 = f404_arg1:getParent()
	local f404_local3 = Engine[@"getmodelforcontroller"]( f404_arg0 )
	local f404_local4 = CoD.BaseUtility.GetMenuModel( f404_arg1.menu )
	local f404_local5 = CoD.BaseUtility.GetMenuLoadoutSlot( f404_arg1.menu )
	local f404_local6 = f404_local2:getModel()
	local f404_local7 = f404_local6 and f404_local6:create( "itemIndex" )
	local f404_local8 = CoD.CACUtility.GetSignatureWeaponsListInternal
	local f404_local9 = f404_arg0
	local f404_local10 = f404_arg1
	local f404_local11 = f404_arg1.menu
	local f404_local12 = f404_local4
	local f404_local13 = f404_local6
	local f404_local14 = f404_local5
	local f404_local15
	if f404_local7 then
		f404_local15 = f404_local7:get()
		if not f404_local15 then
		
		else
			f404_local0 = f404_local8( f404_local9, f404_local10, f404_local11, f404_local12, f404_local13, f404_local14, f404_local15, f404_local1, true )
			if f404_arg1.itemIndexModelSubscription then
				f404_arg1:removeSubscription( f404_arg1.itemIndexModelSubscription )
			end
			if f404_local7 then
				f404_arg1.itemIndexModelSubscription = f404_arg1:subscribeToModel( f404_local7, function ()
					f404_arg1:updateDataSource( true, true )
				end, false )
			end
			if not f404_arg1.weaponPersonalizationUpdateSubscription then
				f404_local9 = f404_arg1
				f404_local8 = f404_arg1.subscribeToModel
				f404_local10 = Engine[@"getmodelforcontroller"]( f404_arg0 )
				f404_arg1.weaponPersonalizationUpdateSubscription = f404_local8( f404_local9, f404_local10:create( "WeaponPersonalization.listUpdate" ), function ()
					f404_arg1:updateDataSource( true, true )
				end, false )
			end
			return f404_local0
		end
	end
	f404_local15 = CoD.CACUtility.EmptyItemIndex
end, true )
CoD.CACUtility.HideWeaponVariantList = function ( f407_arg0, f407_arg1 )
	if not f407_arg0._showWeaponVariantList then
		return 
	end
	local f407_local0, f407_local1 = nil
	if f407_arg0._variantListWidget then
		f407_local0 = f407_arg0._variantListWidget
		f407_local1 = f407_local0:getParent()
		f407_arg0._variantListWidget = nil
	end
	if f407_local1 then
		local f407_local2 = f407_local1:getFirstChild()
		if f407_local2 then
		
		elseif f407_local1.__oldDefaultFocus then
			CoD.BaseUtility.SetDefaultFocusToElement( f407_local1, f407_local1.__oldDefaultFocus )
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus( f407_arg0, f407_arg0, f407_arg1 )
		end
		while f407_local2 ~= nil do
			local f407_local3 = f407_local2:getNextSibling()
			ShowWidget( f407_local2 )
			f407_local2 = f407_local3
		end
		elseif f407_local1.__oldDefaultFocus then
			CoD.BaseUtility.SetDefaultFocusToElement( f407_local1, f407_local1.__oldDefaultFocus )
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus( f407_arg0, f407_arg0, f407_arg1 )
	end
	if f407_local0 then
		HideWidget( f407_local0 )
	end
	CoD.BaseUtility.EnableMenuGridNavigation( f407_arg0 )
	f407_arg0._showWeaponVariantList = nil
	local f407_local2 = Engine[@"getmodelforcontroller"]( f407_arg1 )
	Engine[@"forcenotifymodelsubscriptions"]( f407_local2:create( "VariantListShownUpdate" ) )
end
CoD.CACUtility.ShowWeaponVariantList = function ( f408_arg0, f408_arg1, f408_arg2 )
	if f408_arg0._showWeaponVariantList then
		return 
	end
	local f408_local0 = f408_arg2:getParent()
	if f408_local0 then
		local f408_local1 = f408_local0:getFirstChild()
		if f408_local1 then
		
		else
			f408_local0.__oldDefaultFocus = f408_local0.__defaultFocus
			CoD.BaseUtility.SetDefaultFocusToElement( f408_local0, f408_arg2 )
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus( f408_arg0, f408_arg0, f408_arg1 )
		end
		while f408_local1 ~= nil do
			local f408_local2 = f408_local1:getNextSibling()
			HideWidget( f408_local1 )
			f408_local1 = f408_local2
		end
		f408_local0.__oldDefaultFocus = f408_local0.__defaultFocus
		CoD.BaseUtility.SetDefaultFocusToElement( f408_local0, f408_arg2 )
		CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus( f408_arg0, f408_arg0, f408_arg1 )
	end
	ShowWidget( f408_arg2 )
	f408_arg0._variantListWidget = f408_arg2
	CoD.BaseUtility.DisableMenuGridNavigation( f408_arg0 )
	f408_arg0._showWeaponVariantList = true
	local f408_local1 = Engine[@"getmodelforcontroller"]( f408_arg1 )
	Engine[@"forcenotifymodelsubscriptions"]( f408_local1:create( "VariantListShownUpdate" ) )
end
