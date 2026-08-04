CoD.BGBUtility = {}
CoD.BGBUtility.NumBuffsPerPack = 4
CoD.BGBUtility.NumPacks = 10
CoD.BGBUtility.ElixirCarouselMaxCount = 4
CoD.BGBUtility.BGBCarouselStates = LuaEnum.createEnum("AVAILABLE", "ACTIVE", "COOLING_DOWN", "ZERO_LOCKED_DOWN")
CoD.BGBUtility.N_SETTING_CRAWLER_STATE_OFF = 0
CoD.BGBUtility.N_ENUM_MBOX_OFF = 0
CoD.BGBUtility.N_SETTING_PACK_OFF = 0
CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON = 1
CoD.BGBUtility.N_SETTING_LAST_STAND_DURATION_OFF = 0
CoD.BGBUtility.ElixirToEnumGameSettingsHash = {
	zm_bgb_crawl_space = {
		{
			hash = "zmcrawlerstate",
			restrictedValue = CoD.BGBUtility.N_SETTING_CRAWLER_STATE_OFF,
		},
	},
	zm_bgb_immolation_liquidation = {
		{
			hash = "zmmysteryboxstate",
			restrictedValue = CoD.BGBUtility.N_ENUM_MBOX_OFF,
		},
	},
	zm_bgb_wall_power = {
		{
			hash = "zmpapenabled",
			restrictedValue = CoD.BGBUtility.N_SETTING_PACK_OFF,
		},
	},
	zm_bgb_conflagration_liquidation = {
		{
			hash = "zmpapenabled",
			restrictedValue = CoD.BGBUtility.N_SETTING_PACK_OFF,
		},
	},
	zm_bgb_alchemical_antithesis = {
		{
			hash = "zmpointsfixed",
			restrictedValue = CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON,
		},
	},
	zm_bgb_extra_credit = {
		{
			hash = "zmpointsfixed",
			restrictedValue = CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON,
		},
	},
	zm_bgb_whos_keeping_score = {
		{
			hash = "zmpointsfixed",
			restrictedValue = CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON,
		},
	},
	zm_bgb_phoenix_up = {
		{
			hash = "zmlaststandduration",
			restrictedValue = CoD.BGBUtility.N_SETTING_LAST_STAND_DURATION_OFF,
		},
	},
}
CoD.BGBUtility.ElixirToBooleanGameSettingsHash = {
	zm_bgb_always_done_swiftly = {
		"zmelixiralwaysdoneswiftly",
	},
	zm_bgb_anywhere_but_here = {
		"zmelixiranywherebuthere",
	},
	zm_bgb_arsenal_accelerator = {
		"zmelixirarsenalaccelerator",
		"zmspecweaponisenabled",
	},
	zm_bgb_danger_closest = {
		"zmelixirdangerclosest",
	},
	zm_bgb_in_plain_sight = {
		"zmelixirinplainsight",
	},
	zm_bgb_newtonian_negation = {
		"zmelixirnewtoniannegation",
	},
	zm_bgb_now_you_see_me = {
		"zmelixirnowyouseeme",
	},
	zm_bgb_stock_option = {
		"zmelixirstockoption",
	},
	zm_bgb_board_games = {
		"zmelixirboardgames",
		"zmbarricadestate",
	},
	zm_bgb_burned_out = {
		"zmelixirburnedout",
	},
	zm_bgb_crawl_space = {
		"zmelixircrawlspace",
	},
	zm_bgb_pop_shocks = {
		"zmelixirpopshocks",
		"zmweaponsmelee",
	},
	zm_bgb_temporal_gift = {
		"zmelixirtemporalgift",
		"zmpowerupsactive",
	},
	zm_bgb_point_drops = {
		"zmelixirpointdrops",
		"zmpowerupchaospoints",
		"zmpowerupsactive",
	},
	zm_bgb_alchemical_antithesis = {
		"zmelixiralchemicalantithesis",
	},
	zm_bgb_sword_flay = {
		"zmelixirswordflay",
		"zmweaponsmelee",
	},
	zm_bgb_dead_of_nuclear_winter = {
		"zmelixirdeadofnuclearwinter",
		"zmpowerupnuke",
		"zmpowerupsactive",
	},
	zm_bgb_licensed_contractor = {
		"zmelixirlicensedcontractor",
		"zmpowerupcarpenter",
		"zmpowerupsactive",
		"zmbarricadestate",
	},
	zm_bgb_undead_man_walking = {
		"zmelixirundeadmanwalking",
	},
	zm_bgb_whos_keeping_score = {
		"zmelixirwhoskeepingscore",
		"zmpowerupdouble",
		"zmpowerupsactive",
	},
	zm_bgb_aftertaste = {
		"zmelixiraftertaste",
	},
	zm_bgb_extra_credit = {
		"zmelixirextracredit",
		"zmpowerupchaospoints",
		"zmpowerupsactive",
	},
	zm_bgb_kill_joy = {
		"zmelixirkilljoy",
		"zmpowerupinstakill",
		"zmpowerupsactive",
	},
	zm_bgb_soda_fountain = {
		"zmelixirsodafountain",
		"zmperksactive",
	},
	zm_bgb_ctrl_z = {
		"zmelixirctrlz",
	},
	zm_bgb_free_fire = {
		"zmelixirfreefire",
	},
	zm_bgb_cache_back = {
		"zmelixircacheback",
		"zmpowerupmaxammo",
		"zmpowerupsactive",
	},
	zm_bgb_immolation_liquidation = {
		"zmelixirimmolationliquidation",
		"zmpowerupfiresale",
		"zmpowerupsactive",
	},
	zm_bgb_phoenix_up = {
		"zmelixirphoenixup",
	},
	zm_bgb_power_keg = {
		"zmelixirpowerkeg",
		"zmspecweaponisenabled",
		"zmpowerupspecialweapon",
		"zmpowerupsactive",
	},
	zm_bgb_blood_debt = {
		"zmelixirblooddebt",
	},
	zm_bgb_near_death_experience = {
		"zmelixirneardeathexperience",
	},
	zm_bgb_perkaholic = {
		"zmelixirperkaholic",
		"zmperksactive",
	},
	zm_bgb_wall_power = {
		"zmelixirwallpower",
		"zmwallbuysenabled",
	},
	zm_bgb_anti_entrapment = {
		"zmelixirantientrapment",
	},
	zm_bgb_equip_mint = {
		"zmelixirequipmint",
		"zmequipmentisenabled",
	},
	zm_bgb_head_scan = {
		"zmelixirheadscan",
	},
	zm_bgb_join_the_party = {
		"zmelixirjointheparty",
	},
	zm_bgb_nowhere_but_there = {
		"zmelixirnowherebutthere",
	},
	zm_bgb_phantom_reload = {
		"zmelixirphantomreload",
	},
	zm_bgb_shields_up = {
		"zmelixirshieldsup",
		"zmshieldisenabled",
	},
	zm_bgb_wall_to_wall_clearance = {
		"zmelixirwalltowall",
		"zmwallbuysenabled",
	},
	zm_bgb_perk_up = {
		"zmelixirperkup",
		"zmperksactive",
	},
	zm_bgb_conflagration_liquidation = {
		"zmelixirconflagrationliquidation",
		"zmpowerupsactive",
	},
	zm_bgb_refresh_mint = {
		"zmelixirrefreshmint",
	},
	zm_bgb_dividend_yield = {
		"zmelixirdividendyield",
	},
	zm_bgb_suit_up = {
		"zmelixirsuitup",
	},
	zm_bgb_talkin_bout_regeneration = {
		"zmelixirtalkinboutregeneration",
	},
	zm_bgb_bullet_boost = {
		"zmelixirbulletboost",
	},
	zm_bgb_quacknarok = {
		"zmelixirquacknarok",
	},
	zm_bgb_shopping_free = {
		"zmelixirshoppingfree",
	},
	zm_bgb_near_death_experience = {
		"zmelixirneardeathexperience",
	},
	zm_bgb_reign_drops = {
		"zmelixirreigndrops",
		"zmpowerupsactive",
	},
	zm_bgb_head_drama = {
		"zmelixirheaddrama",
	},
	zm_bgb_phoenix_up = {
		"zmelixirphoenixup",
	},
	zm_bgb_power_vacuum = {
		"zmelixirpowervacuum",
		"zmpowerupsactive",
	},
	zm_bgb_secret_shopper = {
		"zmelixirsecretshopper",
		"zmwallbuysenabled",
	},
}
DataSources.BGBCarousel = DataSourceHelpers.CustomListSetup(
	"BGBCarousel",
	function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
		local f1_local0 = DataSources.ZMHud.getModel(f1_arg1)
		f1_local0 = f1_local0:create("bgb_carousel")
		local f1_local1 = 1
		for f1_local2 = 0, CoD.BGBUtility.ElixirCarouselMaxCount - 1, 1 do
			local f1_local5 = f1_local0:create(f1_local2)
			local f1_local6 = f1_local5:create("gum_idx")
			local f1_local7 = f1_local5:create("script_idx")
			f1_local7:set(f1_local2)
			f1_local7 = f1_local5:create("selected")
			f1_local7:set(false)
			if f1_local6:get() ~= 0 then
				table.insert(f1_arg3, {
					model = f1_local5,
				})
			end
			if not f1_arg0._carouselSubscription then
				f1_arg0:subscribeToModel(f1_local5:create("gum_idx"), function(model, f2_arg1)
					f2_arg1:updateDataSource()
				end, false)
			end
		end
	end,
	false,
	{
		getModel = function(f3_arg0)
			if not DataSources.BGBCarousel._cachedModels then
				DataSources.BGBCarousel._cachedModels = {}
			end
			if not DataSources.BGBCarousel._cachedModels[f3_arg0] then
				local f3_local0 = DataSources.ZMHud.getModel(f3_arg0)
				DataSources.BGBCarousel._cachedModels[f3_arg0] = f3_local0:create("bgb_carousel")
			end
			return DataSources.BGBCarousel._cachedModels[f3_arg0]
		end,
	}
)
CoD.BGBUtility.CooldownToWideDelta = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	return 1 - f4_arg0, 1, 0, 0
end
CoD.BGBUtility.LimitToRangeWithPlus = function(f5_arg0, f5_arg1, f5_arg2)
	if type(f5_arg2) == "string" then
		f5_arg2 = tonumber(f5_arg2)
	end
	if f5_arg2 < f5_arg0 then
		return f5_arg0
	elseif f5_arg2 <= f5_arg1 then
		return f5_arg2
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A1D8A7F0E7B0EFF", f5_arg1)
	end
end
CoD.BGBUtility.IsBGBConsumableInGame = function(f6_arg0, f6_arg1)
	local f6_local0 = CoD.BaseUtility.GetMenuSessionMode(f6_arg0)
	local f6_local1 = f6_arg1:getModel()
	if f6_local1 and f6_local1.gum_idx then
		local f6_local2 = f6_local1.gum_idx:get()
		if f6_local2 and CoD.CACUtility.EmptyItemIndex < f6_local2 then
			return CoD.CACUtility.IsItemConsumable(f6_local2, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f6_local0)
		end
	end
	return false
end
CoD.BGBUtility.SetupBGBConsumableCounts = function(f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = f7_arg1:getModel()
	local f7_local1 = f7_local0 and f7_local0.gum_idx
	if not f7_local1 then
		return
	else
		local f7_local2 = CoD.CACUtility.GetConsumableCountFromIndex(f7_arg0, f7_arg2, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f7_local1:get())
		local f7_local3 = f7_local0:create("count")
		f7_local3:set(f7_local2)
	end
end
CoD.BGBUtility.UpdateBGBConsumableCounts = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = f8_arg2:getModel()
	local f8_local1 = f8_local0 and f8_local0.gum_idx
	if not f8_local1 then
		return
	end
	local f8_local2 = CoD.GetScriptNotifyData(f8_arg1)
	if f8_local2[1] ~= f8_local1:get() then
		return
	end
	local f8_local3 = f8_local0.count
	if f8_local3 then
		f8_local3 = f8_local0.count:get()
	end
	if not f8_local3 then
		return
	end
	f8_local0.count:set(f8_local3 - 1)
end
CoD.BGBUtility.CreateBGBCarouselModels = function(f9_arg0)
	local f9_local0 = Engine.GetModelForController(f9_arg0)
	for f9_local1 = 0, CoD.BGBUtility.ElixirCarouselMaxCount - 1, 1 do
		f9_local0:create("zmhud.bgb_carousel." .. f9_local1 .. ".count")
	end
end
CoD.BGBUtility.IsBGBDisabled = function(f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1:getModel()
	if f10_local0 and (not (not f10_local0.unavailable or f10_local0.unavailable:get() ~= 1) or f10_local0.state and f10_local0.state:get() == CoD.BGBUtility.BGBCarouselStates.ZERO_LOCKED_DOWN) then
		return true
	else
		return false
	end
end
