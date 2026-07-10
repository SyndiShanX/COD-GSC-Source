
require( "x64:f3c5259f470592d" )
CoD.PrestigeUtility = {}
CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID = 0
CoD.PrestigeUtility.DEFAULT_PARAGON_ICON_ID = 11
CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_TIERS = 10
CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_RANK = 999
CoD.PrestigeUtility.PRESTIGE_MASTER_DISPLAY_RANK_OFFSET = 1
CoD.PrestigeUtility.LEADERBOARD_RESET_FILE_MP = "leaderboards/mp_leaderboards_reset.csv"
CoD.PrestigeUtility.isInPermanentUnlockMenu = false
CoD.PrestigeUtility.previousGameMode = nil
CoD.PrestigeUtility.previousStatsMilestonePath = nil
CoD.PrestigeUtility.DEFAULT_REWARD_LIST_COUNT = 8
CoD.PrestigeUtility.DEFAULT_WZ_REWARD_LIST_COUNT = 8
CoD.PrestigeUtility.LAST_WIDE_LAYOUT_RANK = 7
CoD.PrestigeUtility.WIDE_LAYOUT_ENTRY_COUNT = 2
CoD.PrestigeUtility.STANDARD_LAYOUT_ENTRY_COUNT = 1
CoD.PrestigeUtility.MIN_REWARD_COUNT_STANDARD_LAYOUT = 2
CoD.PrestigeUtility.MIN_REWARD_COUNT_WIDE_LAYOUT = 3
CoD.PrestigeUtility.BASE_MP_PRESTIGE_CALLING_CARD_ID = 300
CoD.PrestigeUtility.BASE_ZM_PRESTIGE_CALLING_CARD_ID = 416
CoD.PrestigeUtility.BASE_WZ_PRESTIGE_CALLING_CARD_ID = 694
CoD.PrestigeUtility.PrestigeStrings = {
	[@"hash_65741301630398C1"] = {
		default = @"hash_44FA6EF886E18DDE",
		zm = @"hash_481131AE361D3EA",
		wz = @"hash_44FA6EF886E18DDE"
	},
	[@"hash_1DBA7AA206A2D3FB"] = {
		default = @"hash_433699A472D82E05",
		zm = @"hash_1C6EB34CDCCE0519",
		wz = @"hash_433699A472D82E05"
	},
	[@"prestige_locked"] = {
		default = @"hash_4C7B58DE94790471",
		zm = @"hash_93DDE94AFD8A4FD",
		wz = @"hash_3A4263C3A9043A6D"
	},
	[@"prestige_description"] = {
		default = @"hash_2E33F151DA53C3B4",
		zm = @"hash_7529973044EE7CC0",
		wz = @"hash_1221B26CFA33C130"
	}
}
CoD.PrestigeUtility.SpecialLoadoutRewards = {
	[@"feature_default_class_1"] = {
		index = 1,
		loadoutList = "defaultloadouts",
		typeName = @"hash_11C9270C1BD7E2BF"
	},
	[@"feature_default_class_2"] = {
		index = 2,
		loadoutList = "defaultloadouts",
		typeName = @"hash_11C9280C1BD7E472"
	},
	[@"feature_default_class_3"] = {
		index = 3,
		loadoutList = "defaultloadouts",
		typeName = @"hash_11C9290C1BD7E625"
	},
	[@"feature_default_class_4"] = {
		index = 4,
		loadoutList = "defaultloadouts",
		typeName = @"hash_11C9220C1BD7DA40"
	},
	[@"feature_default_class_5"] = {
		index = 5,
		loadoutList = "defaultloadouts",
		typeName = @"hash_11C9230C1BD7DBF3"
	},
	[@"feature_default_class_6"] = {
		index = 6,
		loadoutList = "defaultloadouts",
		typeName = @"hash_11C9240C1BD7DDA6"
	},
	[@"feature_custom_class_4"] = {
		index = 4,
		loadoutList = "defaultloadouts",
		typeName = @"hash_28E2607011380146"
	},
	[@"feature_custom_class_5"] = {
		index = 5,
		loadoutList = "defaultloadouts",
		typeName = @"hash_28E26170113802F9"
	},
	[@"feature_custom_class_6"] = {
		index = 6,
		loadoutList = "defaultloadouts",
		typeName = @"hash_28E25E701137FDE0"
	}
}
CoD.PrestigeUtility.RewardEntriesWZ = {
	[19] = true,
	[39] = true,
	[59] = true,
	[79] = true,
	[80] = true
}
CoD.PrestigeUtility.RewardEntriesInfoWZ = {
	{
		rankIndex = 19
	},
	{
		rankIndex = 39
	},
	{
		rankIndex = 59
	},
	{
		rankIndex = 79
	},
	{
		rankIndex = 80
	}
}
CoD.PrestigeUtility.SpecialWZRankRewardImages = {
	[19] = {
		image1 = @"hash_6B079427B08C3B6F",
		image2 = @"ui_icon_callingcards_wz_insigniaechelons_wzlevel20"
	},
	[39] = {
		image1 = @"hash_25B24A0BEC8CAE09",
		image2 = @"ui_icon_callingcards_wz_insigniaechelons_wzlevel40"
	},
	[59] = {
		image1 = @"hash_3CD4B5D66DBEDFE1",
		image2 = @"ui_icon_callingcards_wz_insigniaechelons_wzlevel60"
	},
	[79] = {
		image1 = @"hash_3E41819B543643CA",
		image2 = @"ui_icon_callingcards_wz_insigniaechelons_wzlevel80"
	},
	[80] = {
		image1 = @"hash_4BC54EE3D6BE2B6D",
		image2 = @"hash_27ED38F84B5D585D"
	}
}
CoD.PrestigeUtility.RewardEntriesZM = {
	[26] = true,
	[42] = true
}
CoD.PrestigeUtility.PrestigeOverlayLayouts = LuaEnum.createEnum( "Standard", "NoReward", "FreshStart", "TokenUnlock", "RequestProcessing" )
CoD.PrestigeUtility.GetPrestigeCap = function ( f1_arg0 )
	if not f1_arg0 then
		f1_arg0 = Engine[@"currentsessionmode"]()
	end
	return Engine[@"getprestigecap"]( f1_arg0 )
end
CoD.PrestigeUtility.GetPrestigeGameMode = function ()
	local f2_local0 = Engine[@"currentsessionmode"]()
	if f2_local0 == nil or f2_local0 == Enum[@"emodes"][@"mode_invalid"] then
		f2_local0 = Enum[@"emodes"][@"mode_multiplayer"]
	end
	return f2_local0
end
CoD.PrestigeUtility.GetMaxRankByMode = function ( f3_arg0 )
	return CoD.RankUtility.GetRankCap( f3_arg0 )
end
CoD.PrestigeUtility.GetPrestigeGameModeString = function ()
	if CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_zombies"] then
		return "zm"
	else
		return "mp"
	end
end
CoD.PrestigeUtility.GetStringForMode = function ( f5_arg0 )
	if not CoD.PrestigeUtility.PrestigeStrings[f5_arg0] then
		return 0x0
	elseif CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_zombies"] then
		return CoD.PrestigeUtility.PrestigeStrings[f5_arg0].zm
	elseif CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_warzone"] then
		return CoD.PrestigeUtility.PrestigeStrings[f5_arg0].wz
	else
		return CoD.PrestigeUtility.PrestigeStrings[f5_arg0].default
	end
end
CoD.PrestigeUtility.GetCurrentLevel = function ( f6_arg0, f6_arg1 )
	if not f6_arg1 then
		f6_arg1 = CoD.PrestigeUtility.GetPrestigeGameMode()
	end
	local f6_local0 = Engine[@"getplayerstats"]( f6_arg0, CoD.STATS_LOCATION_NORMAL, f6_arg1 )
	if not f6_local0 or not f6_local0.PlayerStatsList.RANK.statValue:get() then
		local f6_local1 = 0
	end
	if IsGameModeParagonCapable( f6_arg1 ) and CoD.PrestigeUtility.GetPrestigeCap() <= CoD.PrestigeUtility.GetCurrentPLevel( f6_arg0, f6_arg1 ) then
		if f6_local0 then
			local f6_local2 = f6_local0.PlayerStatsList.PARAGON_RANK.statValue:get()
		end
		local f6_local1 = f6_local2 or 0
	end
	return f6_local1
end
CoD.PrestigeUtility.GetCurrentPLevel = function ( f7_arg0, f7_arg1 )
	if not IsLobbyNetworkModeLive() then
		return 0
	elseif not f7_arg1 then
		f7_arg1 = CoD.PrestigeUtility.GetPrestigeGameMode()
	end
	local f7_local0 = Engine[@"getplayerstats"]( f7_arg0, CoD.STATS_LOCATION_NORMAL, f7_arg1 )
	local f7_local1
	if f7_local0 then
		f7_local1 = f7_local0.PlayerStatsList.PLEVEL.StatValue:get()
		if not f7_local1 then
		
		else
			return f7_local1
		end
	end
	f7_local1 = 0
end
CoD.PrestigeUtility.GetBackgroundIdByPLevel = function ( f8_arg0, f8_arg1, f8_arg2 )
	if not f8_arg2 then
		f8_arg2 = CoD.PrestigeUtility.GetPrestigeGameMode()
	end
	if CoD.PrestigeUtility.GetPrestigeCap( f8_arg2 ) < f8_arg1 or f8_arg1 <= 0 then
		return 0
	end
	local f8_local0 = nil
	if f8_arg2 == Enum[@"emodes"][@"mode_multiplayer"] then
		f8_local0 = CoD.PrestigeUtility.BASE_MP_PRESTIGE_CALLING_CARD_ID
	elseif f8_arg2 == Enum[@"emodes"][@"mode_zombies"] then
		f8_local0 = CoD.PrestigeUtility.BASE_ZM_PRESTIGE_CALLING_CARD_ID
	elseif f8_arg2 == Enum[@"emodes"][@"mode_warzone"] then
		f8_local0 = CoD.PrestigeUtility.BASE_WZ_PRESTIGE_CALLING_CARD_ID
	end
	return f8_local0 + f8_arg1 - 1
end
CoD.PrestigeUtility.GetPermanentUnlockMode = function ()
	local f9_local0 = Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "prestigeGameMode" )
	if f9_local0 ~= nil then
		local f9_local1 = Engine[@"getmodelvalue"]( f9_local0 )
		if f9_local1 ~= nil and f9_local1 ~= Enum[@"emodes"][@"mode_invalid"] then
			return f9_local1
		end
	end
	return Engine[@"currentsessionmode"]()
end
CoD.PrestigeUtility.CreatePermanentUnlockTokenModel = function ( f10_arg0 )
	local f10_local0 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f10_arg0 ), "permanentUnlockTokensCount" )
	local f10_local1 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	if Engine[@"islootready"]( f10_arg0 ) then
		Engine[@"setmodelvalue"]( f10_local0, Engine[@"getpermanentunlockcount"]( f10_arg0, f10_local1 ) )
	end
end
CoD.PrestigeUtility.IsPrestigeBackground = function ( f11_arg0 )
	local f11_local0 = Engine[@"getemblembackgroundid"]()
	local f11_local1 = Engine[@"getbackgroundsforcategoryname"]( f11_arg0, "prestige" )
	local f11_local2 = false
	for f11_local6, f11_local7 in pairs( f11_local1 ) do
		if f11_local7.id == f11_local0 then
			f11_local2 = true
			break
		end
	end
	for f11_local7, f11_local8 in pairs( Engine[@"getbackgroundsforcategoryname"]( f11_arg0, "zmprestige" ) ) do
		if f11_local8.id == f11_local0 then
			f11_local2 = true
			break
		end
	end
	return f11_local2
end
CoD.PrestigeUtility.ResetToFirstSelectedCharacterLoadout = function ( f12_arg0, f12_arg1 )
	if 10 <= f12_arg1 then
		f12_arg1 = 0
	end
	Engine[@"execnow"]( f12_arg0, "resetMPCharacterLoadout " .. f12_arg1 )
	Engine[@"setheroforcactype"]( f12_arg0, Enum[@"emodes"][@"mode_multiplayer"], Enum[@"cactype"][@"cac_type_mp_public"], f12_arg1 )
	Engine[@"setfirsttimecomplete"]( f12_arg0, Enum[@"emodes"][@"mode_multiplayer"], true )
end
CoD.PrestigeUtility.EnterPrestigeAction = function ( f13_arg0, f13_arg1, f13_arg2 )
	Engine[@"prestigeplayer"]( f13_arg1, CoD.PrestigeUtility.GetPrestigeGameMode() )
end
CoD.PrestigeUtility.SavePermanentlyUnlockedWeaponVariants = function ( f14_arg0, f14_arg1 )
	local f14_local0 = {}
	if f14_arg1 == Enum[@"emodes"][@"mode_zombies"] then
		local f14_local1 = Engine[@"storagegetbuffer"]( f14_arg0, Enum[@"storagefiletype"][@"storage_zm_stats_online"] )
		local f14_local2 = #f14_local1.prestigeTokens
		for f14_local3 = 0, f14_local2 - 1, 1 do
			local f14_local6 = f14_local1.prestigeTokens[f14_local3]
			if f14_local6.itemUnlocked:get() ~= 0 then
				f14_local0[f14_local6.itemUnlocked:get()] = {}
			end
		end
		local f14_local3 = Engine[@"storagegetbuffer"]( f14_arg0, Enum[@"storagefiletype"][@"storage_zm_loadouts"] )
		f14_local3 = f14_local3.cacLoadouts
		local f14_local4 = #f14_local3.variant
		for f14_local5 = 0, f14_local4 - 1, 1 do
			local f14_local8 = f14_local3.variant[f14_local5]
			local f14_local9 = f14_local0[f14_local8.weaponIndex:get()]
			if f14_local9 then
				f14_local9.variantName = f14_local8.variantName:get()
				f14_local9.attachment = {}
				local f14_local10 = #f14_local8.attachment
				for f14_local11 = 0, f14_local10 - 1, 1 do
					f14_local9.attachment[f14_local11] = f14_local8.attachment[f14_local11]:get()
				end
				f14_local9.reticleIndex = f14_local8.reticleIndex:get()
				f14_local9.camoIndex = f14_local8.camoIndex:get()
				f14_local9.paintjobSlot = f14_local8.paintjobSlot:get()
				f14_local9.weaponIndex = f14_local8.weaponIndex:get()
				f14_local9.variantIndex = f14_local8.variantIndex:get()
				f14_local9.sortIndex = f14_local8.sortIndex:get()
				f14_local9.readOnly = f14_local8.readOnly:get()
				f14_local9.createTime = f14_local8.createTime:get()
			end
		end
	end
	return f14_local0
end
CoD.PrestigeUtility.RestorePermanentlyUnlockedWeaponVariants = function ( f15_arg0, f15_arg1, f15_arg2 )
	if f15_arg1 == Enum[@"emodes"][@"mode_zombies"] then
		local f15_local0 = Engine[@"storagegetbuffer"]( f15_arg0, Enum[@"storagefiletype"][@"storage_zm_loadouts"] )
		f15_local0 = f15_local0.cacLoadouts
		local f15_local1 = 0
		for f15_local6, f15_local7 in pairs( f15_arg2 ) do
			local f15_local8 = f15_local0.variant[f15_local1]
			f15_local8.variantName:set( f15_local7.variantName )
			local f15_local9 = #f15_local7.attachment
			for f15_local5 = 0, f15_local9 - 1, 1 do
				f15_local8.attachment[f15_local5]:set( f15_local7.attachment[f15_local5] )
			end
			f15_local8.reticleIndex:set( f15_local7.reticleIndex )
			f15_local8.camoIndex:set( f15_local7.camoIndex )
			f15_local8.paintjobSlot:set( f15_local7.paintjobSlot )
			f15_local8.weaponIndex:set( f15_local7.weaponIndex )
			f15_local8.variantIndex:set( f15_local7.variantIndex )
			f15_local8.sortIndex:set( f15_local7.sortIndex )
			f15_local8.readOnly:set( f15_local7.readOnly )
			f15_local8.createTime:set( f15_local7.createTime )
		end
	end
end
CoD.PrestigeUtility.GetRankNameWZ = function ( f16_arg0 )
	if CoD.PrestigeUtility.RewardEntriesWZ[f16_arg0] then
		return CoD.GetRankName( f16_arg0, 0, Enum[@"emodes"][@"mode_warzone"] )
	end
	local f16_local0 = 1
	for f16_local4, f16_local5 in ipairs( CoD.PrestigeUtility.RewardEntriesInfoWZ ) do
		f16_local0 = f16_local5.rankIndex
		if f16_arg0 <= f16_local5.rankIndex then
			break
		end
	end
	return CoD.GetRankName( f16_local0, 0, Enum[@"emodes"][@"mode_warzone"] )
end
CoD.PrestigeUtility.DisplayBetaRewardInventoryNotification = function ( f17_arg0, f17_arg1, f17_arg2 )
	local f17_local0 = Engine[@"hash_5352DC095BBB2A45"]( f17_arg1, tostring( Dvar[@"hash_6CB029F7D2D66004"]:get() ) )
	local f17_local1 = Engine[@"storagegetbuffer"]( f17_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"] )
	if f17_local1 then
		if f17_local0 > 0 and f17_local1.betaRewardMessageSeen:get() == 0 then
			f17_local1.betaRewardMessageSeen:set( 1 )
			Engine[@"storagewrite"]( f17_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"] )
			OpenSystemOverlay( f17_arg0, f17_arg2, f17_arg1, "BetaTokenNotification", nil )
		end
	end
end
CoD.PrestigeUtility.FreshStartAction = function ( f18_arg0, f18_arg1, f18_arg2 )
	Engine[@"hash_159790ABB39EC530"]( f18_arg1, CoD.PrestigeUtility.GetPrestigeGameMode() )
end
CoD.PrestigeUtility.ChooseClassSets = {}
CoD.PrestigeUtility.ChooseClassSets.Default = 0
CoD.PrestigeUtility.ChooseClassSets.Custom = 1
CoD.PrestigeUtility.ContentCategory = {}
CoD.PrestigeUtility.ContentCategory.SPECIALISTS = 1
CoD.PrestigeUtility.ContentCategory.WEAPONS = 2
CoD.PrestigeUtility.ContentCategory.LETHAL = 3
CoD.PrestigeUtility.ContentCategory.TACTICAL = 4
CoD.PrestigeUtility.ContentCategory.PERK1 = 5
CoD.PrestigeUtility.ContentCategory.PERK2 = 6
CoD.PrestigeUtility.ContentCategory.PERK3 = 7
CoD.PrestigeUtility.ContentCategory.SCORESTREAKS = 8
CoD.PrestigeUtility.ContentCategory.GOBBLEGUM = 9
CoD.PrestigeUtility.GetContentCategoryData = function ( f19_arg0 )
	if f19_arg0 == CoD.PrestigeUtility.ContentCategory.SPECIALISTS then
		return {
			menuName = "ChooseCharacterLoadout",
			weaponCategory = ""
		}
	elseif f19_arg0 == CoD.PrestigeUtility.ContentCategory.WEAPONS then
		return {
			menuName = "PrimaryWeaponSelect",
			weaponCategory = "primary"
		}
	elseif f19_arg0 == CoD.PrestigeUtility.ContentCategory.PERK1 then
		return {
			menuName = "PerkSelect",
			weaponCategory = "specialty1"
		}
	elseif f19_arg0 == CoD.PrestigeUtility.ContentCategory.PERK2 then
		return {
			menuName = "PerkSelect",
			weaponCategory = "specialty2"
		}
	elseif f19_arg0 == CoD.PrestigeUtility.ContentCategory.PERK3 then
		return {
			menuName = "PerkSelect",
			weaponCategory = "specialty3"
		}
	elseif f19_arg0 == CoD.PrestigeUtility.ContentCategory.SCORESTREAKS then
		return {
			menuName = "Scorestreaks",
			weaponCategory = ""
		}
	elseif f19_arg0 == CoD.PrestigeUtility.ContentCategory.GOBBLEGUM then
		return {
			menuName = "BubblegumBuffSelect",
			weaponCategory = ""
		}
	else
		
	end
end
CoD.PrestigeUtility.AddPrestigeCallingCards = function ( f20_arg0, f20_arg1, f20_arg2 )
	if type( f20_arg2 ) ~= "table" then
		return 
	end
	local f20_local0 = CoD.PrestigeUtility.GetCurrentPLevel( f20_arg0, f20_arg1 )
	local f20_local1 = CoD.PrestigeUtility.GetPrestigeCap( f20_arg1 )
	for f20_local2 = 1, f20_local0, 1 do
		local f20_local5 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_4E2EF437F27777CE", f20_local2 )
		if f20_local2 == f20_local1 then
			break
		end
		local f20_local6 = CoD.PrestigeUtility.GetBackgroundIdByPLevel( f20_arg0, f20_local2, f20_arg1 )
		table.insert( f20_arg2, {
			models = {
				title = GetPrestigeTitleForPLevelAndMode( CoD.ModeToModeString( f20_arg1 ), f20_local2 ),
				description = f20_local5,
				iconId = f20_local6,
				icon = CoD.ChallengesUtility.GetBackgroundByID( f20_local6 ),
				maxTier = 0,
				currentTier = 0,
				statPercent = 1,
				xp = 0,
				percentComplete = 1,
				isLocked = false
			},
			properties = {
				isPrestige = true
			}
		} )
	end
end
CoD.PrestigeUtility.GetMasterPrestigeCard = function ( f21_arg0, f21_arg1 )
	local f21_local0 = CoD.PrestigeUtility.GetCurrentPLevel( f21_arg0, f21_arg1 )
	local f21_local1 = CoD.PrestigeUtility.GetPrestigeCap( f21_arg1 )
	if f21_local0 ~= f21_local1 then
		return nil
	else
		local f21_local2 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_EBE8DFCB123DA37", f21_local1 )
		local f21_local3 = CoD.PrestigeUtility.GetBackgroundIdByPLevel( f21_arg0, f21_local1, f21_arg1 )
		return {
			models = {
				title = GetPrestigeTitleForPLevelAndMode( CoD.ModeToModeString( f21_arg1 ), f21_local1 ),
				description = f21_local2,
				iconId = f21_local3,
				icon = CoD.ChallengesUtility.GetBackgroundByID( f21_local3 ),
				maxTier = 0,
				currentTier = 0,
				statPercent = 1,
				xp = 0,
				percentComplete = 1,
				isLocked = false
			},
			properties = {
				isPrestige = true
			}
		}
	end
end
CoD.PrestigeUtility.InitializePrestigeMenu = function ( f22_arg0, f22_arg1, f22_arg2 )
	local f22_local0 = 1
	CoD.PrestigeUtility.TargetPageList = nil
	local f22_local1 = CoD.PrestigeUtility.GetTargetPageList( f22_arg1 )
	local f22_local2, f22_local3 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer( f22_arg2 )
	for f22_local4 = 2, #f22_local1, 1 do
		if f22_local1[f22_local4].targetIndex <= f22_local2 then
			f22_local0 = f22_local4
		end
	end
	local f22_local4 = DataSources.PrestigeMenuInfo.getModel( f22_arg1 )
	f22_local4.currentTargetPageIndex:set( f22_local0 )
	f22_local4 = DataSources.PrestigeMenuInfo.getModel( f22_arg1 )
	f22_local4.hasPrestiged:set( false )
	f22_local4 = CoD.PrestigeUtility.GetPrestigeGameMode()
	local f22_local5 = f22_local3 + 1
	if CoD.PrestigeUtility.GetPrestigeCap( f22_local4 ) < f22_local5 then
		f22_local5 = f22_local3
	end
	DataSources.PrestigeCallingCard.setModelValues( f22_arg1, @"hash_0", @"hash_0", CoD.PrestigeUtility.GetBackgroundIdByPLevel( f22_arg1, f22_local5, f22_local4 ), 0 )
end
CoD.PrestigeUtility.UpdateCurrentTargetIndex = function ( f23_arg0, f23_arg1, f23_arg2, f23_arg3 )
	local f23_local0 = CoD.PrestigeUtility.GetTargetPageList( f23_arg1 )
	local f23_local1 = DataSources.PrestigeMenuInfo.getModel( f23_arg1 )
	f23_local1 = f23_local1.currentTargetPageIndex
	local f23_local2 = f23_local1:get()
	local f23_local3
	if f23_arg3 then
		f23_local3 = -1
		if not f23_local3 then
		
		else
			f23_local2 = f23_local2 + f23_local3
			if f23_local2 < 1 then
				f23_local2 = 1
			elseif #f23_local0 <= f23_local2 then
				f23_local2 = #f23_local0
			end
			f23_local1:set( f23_local2 )
		end
	end
	f23_local3 = 1
end
CoD.PrestigeUtility.AddEntryForReward = function ( f24_arg0, f24_arg1 )
	local f24_local0 = CoD.PrestigeUtility.GetPrestigeGameMode()
	if f24_local0 == Enum[@"emodes"][@"mode_warzone"] and CoD.PrestigeUtility.GetCurrentPLevel( f24_arg0, f24_local0 ) > 0 and not CoD.PrestigeUtility.UsingWidePermanentUnlockEntry( f24_local0, f24_arg1 ) then
		return false
	else
		return true
	end
end
CoD.PrestigeUtility.SetupTargetPageList = function ( f25_arg0 )
	CoD.PrestigeUtility.TargetPageList = {}
	if IsArenaMode() then
		local f25_local0 = LuaUtils.GetLeaguePlayTierTable()
		local f25_local1 = CoD.PrestigeUtility.DEFAULT_REWARD_LIST_COUNT
		local f25_local2 = 0
		table.insert( CoD.PrestigeUtility.TargetPageList, {
			targetIndex = 0
		} )
		local f25_local3 = 0
		for f25_local4 = 0, f25_local0[@"maxrank"], 1 do
			if f25_local1 <= f25_local2 then
				table.insert( CoD.PrestigeUtility.TargetPageList, {
					targetIndex = f25_local4
				} )
				f25_local3 = f25_local4 + 1
				f25_local2 = 0
			end
			f25_local2 = f25_local2 + CoD.PrestigeUtility.STANDARD_LAYOUT_ENTRY_COUNT
		end
	else
		local f25_local0 = CoD.PrestigeUtility.GetPrestigeGameMode()
		local f25_local1 = CoD.RankUtility.GetRankInfoTable()
		local f25_local2 = f25_local1[f25_local0]
		local f25_local3
		if f25_local0 == Enum[@"emodes"][@"mode_warzone"] then
			f25_local3 = CoD.PrestigeUtility.DEFAULT_WZ_REWARD_LIST_COUNT
			if not f25_local3 then
			
			else
				local f25_local4 = 0
				table.insert( CoD.PrestigeUtility.TargetPageList, {
					targetIndex = 0
				} )
				local f25_local5 = 0
				for f25_local6 = 0, #f25_local2, 1 do
					if CoD.PrestigeUtility.AddEntryForReward( f25_arg0, f25_local6 ) then
						if f25_local3 <= f25_local4 then
							table.insert( CoD.PrestigeUtility.TargetPageList, {
								targetIndex = f25_local6
							} )
							f25_local5 = f25_local6 + 1
							f25_local4 = 0
						end
						local f25_local9
						if CoD.PrestigeUtility.UsingWidePermanentUnlockEntry( f25_local0, f25_local6 ) then
							f25_local9 = CoD.PrestigeUtility.WIDE_LAYOUT_ENTRY_COUNT
							if not f25_local9 then
							
							else
								f25_local4 = f25_local4 + f25_local9
							end
						end
						f25_local9 = CoD.PrestigeUtility.STANDARD_LAYOUT_ENTRY_COUNT
					end
				end
			end
		end
		f25_local3 = CoD.PrestigeUtility.DEFAULT_REWARD_LIST_COUNT
	end
end
CoD.PrestigeUtility.GetTargetPageList = function ( f26_arg0 )
	if CoD.PrestigeUtility.TargetPageList == nil then
		CoD.PrestigeUtility.SetupTargetPageList( f26_arg0 )
	end
	return CoD.PrestigeUtility.TargetPageList
end
CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfo = function ( f27_arg0, f27_arg1, f27_arg2 )
	if CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_warzone"] then
		CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfoStandard( f27_arg0, f27_arg1, f27_arg2 )
	else
		CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfoStandard( f27_arg0, f27_arg1, f27_arg2 )
	end
end
CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfoStandard = function ( f28_arg0, f28_arg1, f28_arg2 )
	local f28_local0 = f28_arg2:getModel()
	local f28_local1 = f28_local0.itemIndex:get()
	local f28_local2, f28_local3, f28_local4, f28_local5, f28_local6 = nil
	local f28_local7 = f28_local0.isPermanentlyUnlocked:get()
	local f28_local8 = f28_local0.useWideLayout:get()
	local f28_local9 = f28_local0.useRewardLayout
	if f28_local9 then
		f28_local9 = f28_local0.useRewardLayout:get()
	end
	local f28_local10 = f28_local0.rewardEarned:get()
	local f28_local11 = f28_local0.rankIndex:get()
	local f28_local12 = f28_local11 + 1
	local f28_local13 = DataSources.PrestigeMenuInfo.getModel( f28_arg1 )
	if f28_local1 < CoD.CACUtility.EmptyItemIndex then
		f28_local2 = f28_local0.displayName:get()
		f28_local3 = f28_local0.image:get()
		f28_local4 = f28_local0.imageLarge:get()
		f28_local5 = 0x0
		f28_local6 = f28_local0.itemGroupName:get()
		local f28_local14 = f28_local0.loadoutReferenceHash:get()
		local f28_local15 = f28_local13.currentHighlightedItem:create( "loadoutReferenceHash" )
		f28_local15:set( f28_local14 )
	else
		f28_local2 = f28_local0.displayName:get()
		f28_local3 = f28_local0.image:get()
		f28_local4 = f28_local0.imageLarge:get()
		f28_local5 = f28_local0.description:get()
		f28_local6 = f28_local0.itemGroupName:get()
		local f28_local14 = f28_local13.currentHighlightedItem:create( "loadoutReferenceHash" )
		f28_local14:set( nil )
	end
	local f28_local14 = f28_local13.currentHighlightedItem:create( "displayName" )
	f28_local14:set( f28_local2 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "description" )
	f28_local14:set( f28_local5 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "image" )
	f28_local14:set( f28_local3 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "imageLarge" )
	f28_local14:set( f28_local4 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "itemGroupName" )
	f28_local14:set( f28_local6 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "isPermanentlyUnlocked" )
	f28_local14:set( f28_local7 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "useWideLayout" )
	f28_local14:set( f28_local8 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "useRewardLayout" )
	f28_local14:set( f28_local9 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "rewardEarned" )
	f28_local14:set( f28_local10 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "rankIndex" )
	f28_local14:set( f28_local11 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "rankDisplay" )
	f28_local14:set( f28_local12 )
	f28_local14 = f28_local13.currentHighlightedItem:create( "itemIndex" )
	f28_local14:set( f28_local1 )
	f28_local14 = f28_local0.icon
	if f28_local14 then
		f28_local14 = f28_local0.icon:get()
	end
	if f28_local14 then
		local f28_local15 = f28_local13.currentHighlightedItem:create( "icon" )
		f28_local15:set( f28_local14 )
	end
end
CoD.PrestigeUtility.OpenPermanentUnlockClassItemDialog = function ( f29_arg0, f29_arg1, f29_arg2 )
	local f29_local0 = f29_arg2:getModel()
	f29_local0 = f29_local0.itemIndex:get()
	local f29_local1 = f29_arg2:getModel()
	CoD.OverlayUtility.CreateOverlay( f29_arg1, f29_arg0, "PermanentUnlockClassItem", f29_arg1, f29_local0, f29_local1.imageLarge:get() )
end
CoD.PrestigeUtility.ResetInformationOnPrestige = function ( f30_arg0, f30_arg1 )
	CoD.PrestigeUtility.CreatePermanentUnlockTokenModel( f30_arg1 )
	CoD.PrestigeUtility.InitializePrestigeMenu( f30_arg0, f30_arg1, f30_arg0 )
	local f30_local0 = DataSources.PrestigeMenuInfo.getModel( f30_arg1 )
	f30_local0.hasPrestiged:set( true )
	DataSources.XPProgressionBar.getModel( f30_arg1 )
	if CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_warzone"] then
		local f30_local1 = DataSources.PrestigeMenuInfo.getModel( f30_arg1 )
		f30_local1.currentHighlightedItem.rankIndex:set( -1 )
	end
end
CoD.PrestigeUtility.OnPrestigeTransactionResultUpdated = function ( f31_arg0, f31_arg1, f31_arg2, f31_arg3 )
	local f31_local0 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f31_arg2 ), "prestigeRoot.prestigeTask" )
	local f31_local1 = f31_local0.success:get()
	if f31_arg3:get() == true then
		CoD.PrestigeUtility.prestigeTransactionActive = true
		CoD.PrestigeUtility.processingOverlay = CoD.OverlayUtility.CreateOverlay( f31_arg2, f31_arg0, "RequestProcessingOverlay", f31_arg2, nil )
	elseif CoD.PrestigeUtility.prestigeTransactionActive then
		CoD.PrestigeUtility.prestigeTransactionActive = false
		if CoD.PrestigeUtility.processingOverlay then
			GoBack( CoD.PrestigeUtility.processingOverlay, f31_arg2 )
			CoD.PrestigeUtility.processingOverlay = nil
		end
		if f31_local1 then
			PlayClip( f31_arg1, "ShowPrestige", f31_arg2 )
			PlaySoundAlias( "uin_prestige_activate" )
			CoD.PrestigeUtility.ResetInformationOnPrestige( f31_arg0, f31_arg2 )
		else
			OpenSystemOverlay( f31_arg0, f31_arg0, f31_arg2, "RequestProcessingFailedOverlay", nil )
		end
	end
end
CoD.PrestigeUtility.OnPrestigeUnlockTransactionResultUpdated = function ( f32_arg0, f32_arg1, f32_arg2 )
	local f32_local0 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f32_arg1 ), "prestigeRoot.unlockTask" )
	local f32_local1 = f32_local0.success:get()
	if f32_arg2:get() == true then
		CoD.PrestigeUtility.prestigeUnlockTransactionActive = true
		CoD.PrestigeUtility.unlockProcessingOverlay = CoD.OverlayUtility.CreateOverlay( f32_arg1, f32_arg0, "RequestProcessingOverlay", f32_arg1, nil )
	elseif CoD.PrestigeUtility.prestigeUnlockTransactionActive then
		CoD.PrestigeUtility.prestigeUnlockTransactionActive = false
		if CoD.PrestigeUtility.unlockProcessingOverlay then
			GoBack( CoD.PrestigeUtility.unlockProcessingOverlay, f32_arg1 )
			CoD.PrestigeUtility.unlockProcessingOverlay = nil
		end
		if f32_local1 then
			OpenSystemOverlay( f32_arg0, f32_arg0, f32_arg1, "PrestigeUnlockRequestProcessingSuccessOverlay", nil )
			CoD.PrestigeUtility.CreatePermanentUnlockTokenModel( f32_arg1 )
		else
			OpenSystemOverlay( f32_arg0, f32_arg0, f32_arg1, "PrestigeUnlockRequestProcessingFailedOverlay", nil )
		end
	end
end
CoD.PrestigeUtility.OnFreshStartTransactionResultUpdated = function ( f33_arg0, f33_arg1, f33_arg2 )
	local f33_local0 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f33_arg1 ), "prestigeRoot.freshStartTask" )
	local f33_local1 = f33_local0.success:get()
	if f33_arg2:get() == true then
		CoD.PrestigeUtility.freshStartTransactionActive = true
		CoD.PrestigeUtility.freshStartProcessingOverlay = CoD.OverlayUtility.CreateOverlay( f33_arg1, f33_arg0, "RequestProcessingOverlayFreshStart", f33_arg1, nil )
	elseif CoD.PrestigeUtility.freshStartTransactionActive then
		CoD.PrestigeUtility.freshStartTransactionActive = false
		if CoD.PrestigeUtility.freshStartProcessingOverlay then
			GoBack( CoD.PrestigeUtility.freshStartProcessingOverlay, f33_arg1 )
			CoD.PrestigeUtility.freshStartProcessingOverlay = nil
		end
		if f33_local1 then
			SetIsInPrestigeMenu( false )
			GoBackToMenu( f33_arg0, f33_arg1, "Director" )
		else
			OpenSystemOverlay( f33_arg0, f33_arg0, f33_arg1, "FreshStartRequestProcessingFailedOverlay", nil )
		end
	end
end
CoD.PrestigeUtility.InitScrollbarForDrag = function ( f34_arg0, f34_arg1, f34_arg2, f34_arg3 )
	if CoD.isPC and f34_arg1.slider.emptyFocusable then
		f34_arg1.slider.emptyFocusable.__startDragX = nil
		local f34_local0 = function ( f35_arg0, f35_arg1, f35_arg2, f35_arg3 )
			f35_arg1.__startDragX = f35_arg2.x
			f35_arg0:CaptureMouseAndLockFocus( f35_arg3, f35_arg1 )
			f35_arg1.__lockedFocus = true
		end
		
		local f34_local1 = function ( f36_arg0, f36_arg1, f36_arg2, f36_arg3 )
			f36_arg1.__startDragX = nil
			if f36_arg1.__lockedFocus then
				f36_arg0:CaptureMouseAndLockFocus( f36_arg3, nil )
				f36_arg1.lockedFocus = false
				SetLoseFocusToSelf( f36_arg1, f36_arg3 )
			end
		end
		
		local f34_local2 = function ( f37_arg0, f37_arg1, f37_arg2, f37_arg3 )
			if f37_arg1.__startDragX ~= nil then
				local f37_local0 = DataSources.PrestigeMenuInfo.getModel( f37_arg3 )
				f37_local0 = f37_local0.currentTargetPageIndex
				local f37_local1 = #CoD.PrestigeUtility.GetTargetPageList( f37_arg3 )
				local f37_local2, f37_local3, f37_local4, f37_local5 = Engine[@"hash_3695399A0E06EC35"]( f37_arg3, CoD.isWarzone and f37_arg0.PCScrollbarWZ or f37_arg0.PCScrollbar )
				local f37_local6 = (f37_local4 - f37_local2) / f37_local1
				local f37_local7 = f37_arg2.x - f37_local2
				local f37_local8 = false
				for f37_local12, f37_local13 in ipairs( CoD.PrestigeUtility.GetTargetPageList( f37_arg3 ) ) do
					if f37_local7 < f37_local6 * f37_local12 then
						f37_local0:set( f37_local12 )
						f37_local8 = true
						break
					end
				end
				if not f37_local8 then
					f37_local0:set( f37_local1 )
				end
			end
		end
		
		local f34_local3 = function ( f38_arg0, f38_arg1, f38_arg2 )
			if f38_arg0.__lockedFocus then
				f38_arg2:CaptureMouseAndLockFocus( f38_arg1, nil )
				f38_arg0.__lockedFocus = false
			end
		end
		
		local f34_local4 = function ( f39_arg0 )
			if f39_arg0.__lockedFocus then
				f39_arg0.__lockedFocus = false
			end
		end
		
		f34_arg1.slider.emptyFocusable:setHandleMouse( true )
		f34_arg1.slider.emptyFocusable:registerEventHandler( "leftmousedrag", function ( element, event )
			f34_local2( f34_arg0, element, event, f34_arg2 )
		end )
		f34_arg1.slider.emptyFocusable:registerEventHandler( "leftmouseup", function ( element, event )
			f34_local1( f34_arg3, element, event, f34_arg2 )
		end )
		f34_arg1.slider.emptyFocusable:registerEventHandler( "leftmousedown", function ( element, event )
			f34_local0( f34_arg3, element, event, f34_arg2 )
		end )
		f34_arg1.slider.emptyFocusable:registerEventHandler( "lose_focus", function ( element, event )
			f34_local3( element, f34_arg2, f34_arg3 )
		end )
		f34_arg1.slider.emptyFocusable:registerEventHandler( "mouse_capture_lost", function ( element, event )
			f34_local4( element )
		end )
		f34_arg1.slider.emptyFocusable.__onSliderClose = function ( f45_arg0, f45_arg1, f45_arg2 )
			if f45_arg0.__lockedFocus then
				f45_arg2:CaptureMouseAndLockFocus( f45_arg1, nil )
				f45_arg0.__lockedFocus = false
			end
		end
		
		LUI.OverrideFunction_CallOriginalSecond( f34_arg1.slider.emptyFocusable, "close", f34_arg1.slider.emptyFocusable.__onSliderClose )
	end
end
CoD.PrestigeUtility.UpdateTargetPageIndexScroll = function ( f46_arg0, f46_arg1, f46_arg2, f46_arg3 )
	local f46_local0 = f46_arg3:get()
	if f46_local0 == nil then
		return 
	end
	local f46_local1 = #CoD.PrestigeUtility.GetTargetPageList( f46_arg2 )
	local f46_local2 = 1
	local f46_local3, f46_local4 = f46_arg1:getLocalSize()
	local f46_local5 = "DefaultState"
	if f46_local1 <= f46_local2 then
		f46_local5 = "AtLeftAndRight"
	elseif f46_local0 == 1 then
		f46_local5 = "AtLeft"
	elseif f46_local1 < f46_local0 + f46_local2 then
		f46_local5 = "AtRight"
	end
	local f46_local6 = {}
	table.insert( f46_local6, f46_arg1 )
	if CoD.isPC then
		local f46_local7 = nil
		if CoD.isWarzone and f46_arg0.PCScrollbarWZ.slider then
			f46_local7 = f46_arg0.PCScrollbarWZ.slider
		elseif IsArenaMode() and f46_arg0.PCScrollbarWL.slider then
			f46_local7 = f46_arg0.PCScrollbarWL.slider
		elseif f46_arg0.PCScrollbar.slider then
			f46_local7 = f46_arg0.PCScrollbar.slider
		end
		table.insert( f46_local6, f46_local7 )
	end
	for f46_local16, f46_local17 in ipairs( f46_local6 ) do
		if f46_local17.slider then
			if f46_local17.sliderWidth == nil then
				local f46_local10, f46_local11, f46_local12, f46_local13 = f46_local17.slider:getLocalRect()
				f46_local17.sliderWidth = f46_local3 - f46_local10 + f46_local12
				f46_local17.sliderLeft = f46_local10
			end
			local f46_local10 = math.min( f46_local2 / f46_local1, 1 )
			local f46_local12 = (f46_local0 - 1) / f46_local1 * f46_local17.sliderWidth
			local f46_local13 = f46_local10 * f46_local17.sliderWidth
			local f46_local14 = f46_local17.sliderLeft + f46_local12
			f46_local17.slider:beginAnimation( "update_position" )
			f46_local17.slider:setLeftRight( true, false, f46_local14, f46_local14 + f46_local13 )
			if CoD.isPC and f46_local17.emptyFocusable then
				f46_local17.emptyFocusable:setLeftRight( true, false, f46_local14, f46_local14 + f46_local13 )
				local f46_local15 = f46_local17:getParent()
				f46_local15:setState( f46_arg2, f46_local5 )
			else
				f46_local17:setState( f46_arg2, f46_local5 )
			end
		end
	end
end
CoD.PrestigeUtility.ClearHasPrestigedStatus = function ( f47_arg0, f47_arg1 )
	local f47_local0 = DataSources.PrestigeMenuInfo.getModel( f47_arg1 )
	f47_local0.hasPrestiged:set( false )
end
CoD.PrestigeUtility.CanCustomizePrestigeIcon = function ( f48_arg0, f48_arg1 )
	if CoD.BaseUtility.IsDvarEnabled( "enable_prestige_icon_customization" ) then
		return IsMaxPrestigeLevelForMode( f48_arg1, CoD.PrestigeUtility.GetPrestigeGameMode() )
	else
		return false
	end
end
CoD.PrestigeUtility.ShouldHidePrestigeButton = function ( f49_arg0 )
	if IsArenaMode() or IsWarzone() and not IsBooleanDvarSet( "ui_enablePrestigeWZ" ) then
		return true
	else
		return false
	end
end
CoD.PrestigeUtility.isMaxRank = function ( f50_arg0 )
	local f50_local0 = CoD.RankUtility.GetRankCap()
	return CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_RANK <= CoD.PlayerStatsUtility.GetCurrentRankAndXPFromMenuStorageBuffer( f50_arg0 )
end
CoD.PrestigeUtility.ShowFreshStart = function ( f51_arg0 )
	if IsWarzone() or IsArenaMode() then
		return false
	else
		return not IsPrestigeLevelAtZero( f51_arg0 )
	end
end
CoD.PrestigeUtility.GetPermanentUnlockInfoString = function ( f52_arg0 )
	if CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_zombies"] then
		return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_598063AE96E7D98" )
	else
		return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_619552171639ADD0" )
	end
end
CoD.PrestigeUtility.GetPrestigeMenuTitleString = function ( f53_arg0 )
	if CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_warzone"] then
		return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_4226E947798C9490" )
	elseif IsArenaMode() then
		return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_24ACCE4091313402" )
	else
		return Engine[@"hash_4F9F1239CFD921FE"]( @"menu/progress_unlocks" )
	end
end
CoD.PrestigeUtility.GetUnlockedIndicatorString = function ( f54_arg0, f54_arg1, f54_arg2 )
	if f54_arg0 ~= nil then
		local f54_local0 = f54_arg0.itemIndex:get()
		local f54_local1 = CoD.PrestigeUtility.GetPrestigeGameMode()
		if f54_local0 > CoD.CACUtility.EmptyItemIndex then
			return Engine[@"hash_4F9F1239CFD921FE"]( CoD.GetUnlockStringForItemIndex( f54_arg1, f54_local0, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f54_local1 ) )
		elseif f54_local0 < CoD.CACUtility.EmptyItemIndex then
			local f54_local2 = f54_arg0.rankIndex:get()
			if f54_local2 ~= nil then
				return Engine[@"hash_4F9F1239CFD921FE"]( @"menu/unlocked_at", CoD.GetRankName( f54_local2, 0, f54_local1 ), f54_local2 + 1 )
			end
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"]( 0x0 )
end
CoD.PrestigeUtility.GetPrestigeMenuRankTitle = function ( f55_arg0, f55_arg1 )
	local f55_local0 = CoD.PrestigeUtility.GetPrestigeGameMode()
	local f55_local1, f55_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer( f55_arg0 )
	return Engine[@"hash_4F9F1239CFD921FE"]( CoD.GetRankName( f55_local1, f55_local2, f55_local0 ) )
end
CoD.PrestigeUtility.LocalizeIfMaxRank = function ( f56_arg0, f56_arg1 )
	if tonumber( CoD.PrestigeUtility.GetMaxRankByMode( CoD.PrestigeUtility.GetPrestigeGameMode() ) ) + 1 <= tonumber( f56_arg1 ) then
		return Engine[@"hash_4F9F1239CFD921FE"]( f56_arg0 )
	else
		return CoD.BaseUtility.LocalizeIfXHash( f56_arg1 )
	end
end
CoD.PrestigeUtility.GetNextLevelText = function ( f57_arg0, f57_arg1, f57_arg2 )
	local f57_local0 = CoD.PlayerStatsUtility.GetCurrentRankAndXPFromMenuStorageBuffer( f57_arg0 )
	local f57_local1 = CoD.RankUtility.GetRankCap()
	if CoD.PlayerStatsUtility.IsPrestigeMasterForMenu( Engine[@"currentsessionmode"](), f57_arg0 ) then
		f57_local0 = CoD.PlayerStatsUtility.HashStorageLookupForMenu( f57_arg0, {
			@"playerstatslist",
			@"paragon_rank"
		} )
		if CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_RANK <= f57_local0 then
			return Engine[@"hash_4F9F1239CFD921FE"]( @"menu/max_level" )
		else
			return ConvertToUpperString( LocalizeIntoString( @"hash_5C10AE96A0B5807E", math.min( f57_local0 + 1, CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_RANK ) + CoD.PrestigeUtility.PRESTIGE_MASTER_DISPLAY_RANK_OFFSET ) )
		end
	elseif IsAtXPCap( f57_arg1 ) then
		if IsWarzone() then
			return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_4F80010008304EC0" )
		else
			return Engine[@"hash_4F9F1239CFD921FE"]( @"menu/max_level" )
		end
	elseif f57_local1 <= f57_local0 then
		return ""
	end
	local f57_local2 = nil
	local f57_local3 = CoD.PlayerStatsUtility.GetNextRank( f57_arg0, nil )
	if IsWarzone() then
		f57_local2 = LocalizeIntoString( @"hash_5F9EBC472F2D8694", f57_local3 )
	else
		f57_local2 = LocalizeIntoString( @"hash_5C10AE96A0B5807E", f57_local3 )
	end
	return ConvertToUpperString( f57_local2 )
end
CoD.PrestigeUtility.GetNextLevelXPText = function ( f58_arg0, f58_arg1, f58_arg2 )
	local f58_local0 = f58_arg2
	local f58_local1 = CoD.PlayerStatsUtility.GetCurrentRankAndXPFromMenuStorageBuffer( f58_arg0 )
	local f58_local2 = CoD.RankUtility.GetRankCap()
	if CoD.PlayerStatsUtility.IsPrestigeMasterForMenu( Engine[@"currentsessionmode"](), f58_arg0 ) then
		if CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_RANK <= f58_local1 then
			return Engine[@"hash_4F9F1239CFD921FE"]( @"menu/max_level" )
		else
			local f58_local3 = math.min( f58_local1 + 1, CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_RANK )
			return ConvertToUpperString( LocalizeIntoString( @"hash_5C10AE96A0B5807E", f58_local0 ) )
		end
	elseif IsAtXPCap( f58_arg1 ) then
		if IsWarzone() then
			return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_4F80010008304EC0" )
		else
			return Engine[@"hash_4F9F1239CFD921FE"]( @"menu/max_level" )
		end
	end
	local f58_local3 = nil
	if IsWarzone() then
		f58_local3 = LocalizeIntoString( @"hash_3B916F8FB1E495C7", f58_local0 )
	else
		f58_local3 = LocalizeIntoString( @"hash_5C10AE96A0B5807E", f58_local0 )
	end
	return ConvertToUpperString( f58_local3 )
end
CoD.PrestigeUtility.HideIfPrestigeMasterOrValueZero = function ( f59_arg0, f59_arg1 )
	if LuaUtils.IsArenaMode() then
		return 0
	elseif f59_arg1 == 0 or IsMaxPrestigeLevel( f59_arg0 ) then
		return 0
	else
		return 1
	end
end
local f0_local0 = {
	SPECIALISTS = {
		displayText = @"hash_6FF94A9EB646C873",
		description = @"hash_840DDF6BE6B0F38",
		image = "t7_icon_pbt_mp_battery_head1_skin1_rwd",
		action = OpenChooseCharacterLoadout,
		param = ""
	},
	WEAPONS = {
		displayText = @"menu/weapons",
		description = @"hash_616FF87A293ECFB1",
		image = "t7_icon_weapon_ar_standard_rwd",
		action = OpenPermanentWeaponUnlockCategoryMenu,
		param = CoD.PrestigeUtility.ContentCategory.WEAPONS
	},
	LETHAL = {
		displayText = @"hash_2DA102A6853690E6",
		description = @"hash_7D3E7D550CC337E3",
		image = "t7_hud_icon_menu_frag_rwd",
		action = OpenPermanentUnlockCategoryMenu,
		param = CoD.PrestigeUtility.ContentCategory.LETHAL
	},
	TACTICAL = {
		displayText = @"menu/tactical",
		description = @"hash_3321848994844FE0",
		image = "t7_hud_icon_menu_concussion_rwd",
		action = OpenPermanentUnlockCategoryMenu,
		param = CoD.PrestigeUtility.ContentCategory.TACTICAL
	},
	PERK1 = {
		displayText = @"mpui/perk1",
		description = @"hash_EA29654F1DC4ACB",
		image = "t7_hud_perk_jetcharge_rwd",
		action = OpenPermanentUnlockCategoryMenu,
		param = CoD.PrestigeUtility.ContentCategory.PERK1
	},
	PERK2 = {
		displayText = @"mpui/perk2",
		description = @"hash_DFED4FA3CF1FC40",
		image = "t7_hud_perk_fasthands_rwd",
		action = OpenPermanentUnlockCategoryMenu,
		param = CoD.PrestigeUtility.ContentCategory.PERK2
	},
	PERK3 = {
		displayText = @"mpui/perk3",
		description = @"hash_445E54E8EAF5FE1D",
		image = "t7_hud_perk_gungho_rwd",
		action = OpenPermanentUnlockCategoryMenu,
		param = CoD.PrestigeUtility.ContentCategory.PERK3
	},
	SCORESTREAKS = {
		displayText = @"menu/scorestreaks",
		description = @"hash_114380F481205521",
		image = "t7_hud_ks_drone_attack_rwd",
		action = OpenScorestreaks,
		param = ""
	},
	GOBBLEGUM = {
		displayText = @"hash_5BFF3DAFD18C7957",
		description = 0x18662525A3E822,
		image = "uie_t7_menu_gobblegum_comsumable",
		action = OpenPermanentUnlockCategoryMenu,
		param = CoD.PrestigeUtility.ContentCategory.GOBBLEGUM
	}
}
local f0_local1 = {
	f0_local0.SPECIALISTS,
	f0_local0.WEAPONS,
	f0_local0.LETHAL,
	f0_local0.TACTICAL,
	f0_local0.PERK1,
	f0_local0.PERK2,
	f0_local0.PERK3,
	f0_local0.SCORESTREAKS
}
local f0_local2 = {
	f0_local0.WEAPONS,
	f0_local0.GOBBLEGUM
}
CoD.PrestigeUtility.PermanentUnlockCategoryListPrepare = function ( f60_arg0 )
	local f60_local0 = {}
	local f60_local1 = f0_local1
	if CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_zombies"] then
		f60_local1 = f0_local2
	end
	for f60_local5, f60_local6 in pairs( f60_local1 ) do
		table.insert( f60_local0, {
			models = {
				displayText = f60_local6.displayText,
				description = f60_local6.description,
				image = f60_local6.image,
				action = f60_local6.action,
				param = f60_local6.param
			}
		} )
	end
	return f60_local0
end
DataSources.PermanentUnlockCategoryList = DataSourceHelpers.ListSetup( "PermanentUnlockCategoryList", CoD.PrestigeUtility.PermanentUnlockCategoryListPrepare, true )
DataSources.PrestigeMenuInfo = {
	getModel = function ( f61_arg0 )
		local f61_local0 = Engine[@"getmodelforcontroller"]( f61_arg0 )
		f61_local0 = f61_local0:create( "PrestigeMenuInfo" )
		f61_local0:create( "currentTargetPageIndex" )
		f61_local0:create( "hasPrestiged" )
		local f61_local1 = f61_local0:create( "currentHighlightedItem" )
		f61_local1:create( "itemIndex" )
		f61_local1:create( "displayName" )
		f61_local1:create( "description" )
		f61_local1:create( "image" )
		f61_local1:create( "imageLarge" )
		f61_local1:create( "icon" )
		f61_local1:create( "itemGroupName" )
		f61_local1:create( "isPermanentlyUnlocked" )
		f61_local1:create( "useWideLayout" )
		f61_local1:create( "rewardEarned" )
		f61_local1:create( "rankIndex" )
		f61_local1:create( "rankDisplay" )
		return f61_local0
	end
}
DataSourceHelpers.PerControllerDataSourceSetup( "PrestigeResult", "prestigeRoot.prestigeTask", function ( f62_arg0, f62_arg1 )
	f62_arg0:create( "inprogress" )
	f62_arg0:create( "success" )
end, false )
DataSourceHelpers.PerControllerDataSourceSetup( "PrestigeUnlockResult", "prestigeRoot.unlockTask", function ( f63_arg0, f63_arg1 )
	f63_arg0:create( "inprogress" )
	f63_arg0:create( "success" )
end, false )
DataSourceHelpers.PerControllerDataSourceSetup( "PrestigeFreshStartResult", "prestigeRoot.freshStartTask", function ( f64_arg0, f64_arg1 )
	f64_arg0:create( "inprogress" )
	f64_arg0:create( "success" )
end, false )
CoD.PrestigeUtility.UsingWidePermanentUnlockEntry = function ( f65_arg0, f65_arg1 )
	if f65_arg0 == Enum[@"emodes"][@"mode_warzone"] then
		return CoD.PrestigeUtility.RewardEntriesWZ[f65_arg1] ~= nil
	elseif f65_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		return CoD.PrestigeUtility.RewardEntriesZM[f65_arg1] ~= nil
	else
		local f65_local0
		if f65_arg0 ~= Enum[@"emodes"][@"mode_multiplayer"] or f65_arg1 > CoD.PrestigeUtility.LAST_WIDE_LAYOUT_RANK then
			f65_local0 = false
		else
			f65_local0 = true
		end
	end
	return f65_local0
end
CoD.PrestigeUtility.GetWLRewardsForRank = function ( f66_arg0, f66_arg1, f66_arg2, f66_arg3 )
	local f66_local0 = {}
	local f66_local1 = @"blacktransparent"
	local f66_local2 = @"blacktransparent"
	local f66_local3 = 0x0
	local f66_local4 = CoD.ArenaLeaguePlayUtility.GetRubyCountForRank( f66_arg2 + 1 )
	local f66_local5 = CoD.ArenaLeaguePlayUtility.GetRankInfoFieldAtRank( f66_arg2 + 1, "rankrewards", nil )
	if f66_local5 then
		if f66_local5[1] then
			f66_local1 = Engine[@"converttoxhash"]( f66_local5[1][@"rewarditem"] )
		end
		if f66_local5[2] then
			f66_local2 = Engine[@"converttoxhash"]( f66_local5[2][@"rewarditem"] )
		end
		f66_local3 = @"menu/rewards"
	else
		local f66_local6 = CoD.ArenaLeaguePlayUtility.GetBestRank( f66_arg0 )
		local f66_local7 = CoD.ArenaLeaguePlayUtility.GetFirstPlaceCount( f66_arg0 )
		local f66_local8, f66_local9, f66_local10, f66_local11, f66_local12 = CoD.ArenaLeaguePlayUtility.GetRankForEachPlacement( f66_arg0 )
		local f66_local13, f66_local14 = CoD.ArenaLeaguePlayUtility.GetRankIconAtRank( f66_arg2 + 1, f66_local8, f66_local9, f66_local10, f66_local11, f66_local12 )
		f66_local1 = f66_local14
		f66_local2 = f66_local1
	end
	local f66_local6 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1EA681B4594ACD02", f66_local4 )
	table.insert( f66_local0, {
		itemIndex = CoD.CACUtility.EmptyItemIndex,
		displayName = Engine[@"hash_4F9F1239CFD921FE"]( f66_local3 ),
		image = f66_local1,
		imageLarge = f66_local2,
		icon = f66_local2,
		itemGroupName = f66_local6,
		description = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/rank_n", f66_arg2 + 1 ),
		loadoutReferenceHash = nil,
		isPermanentlyUnlocked = false,
		useWideLayout = false,
		useRewardLayout = f66_local5 ~= nil,
		rewardEarned = f66_arg3,
		rankIndex = f66_arg2,
		hasRewards = f66_local5 ~= nil
	} )
	while #f66_local0 < CoD.PrestigeUtility.MIN_REWARD_COUNT_WIDE_LAYOUT do
		table.insert( f66_local0, {
			itemIndex = CoD.CACUtility.EmptyItemIndex,
			displayName = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
			description = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
			itemGroupName = f66_local6,
			image = @"blacktransparent",
			loadoutReferenceHash = nil,
			isPermanentlyUnlocked = false,
			useWideLayout = false,
			useRewardLayout = f66_local5 ~= nil,
			rewardEarned = false,
			rankIndex = f66_arg2,
			hasRewards = f66_local5 ~= nil
		} )
	end
	return f66_local0
end
CoD.PrestigeUtility.GetWZRewardsForRank = function ( f67_arg0, f67_arg1, f67_arg2, f67_arg3 )
	local f67_local0 = {}
	local f67_local1 = CoD.RankUtility.GetRankInfoField( f67_arg1, f67_arg2, @"level", 0x0 )
	local f67_local2 = CoD.RankUtility.GetRankInfoField( f67_arg1, f67_arg2, @"iconlarge", @"blacktransparent" )
	local f67_local3 = f67_local2
	if CoD.PrestigeUtility.SpecialWZRankRewardImages[f67_arg2] then
		f67_local2 = CoD.PrestigeUtility.SpecialWZRankRewardImages[f67_arg2].image1
		f67_local3 = CoD.PrestigeUtility.SpecialWZRankRewardImages[f67_arg2].image2
	end
	if CoD.PrestigeUtility.GetCurrentPLevel( f67_arg0 ) > 0 then
		f67_local3 = CoD.RankUtility.GetRankInfoField( f67_arg1, f67_arg2, @"iconlarge", @"blacktransparent" )
	end
	local f67_local4 = CoD.RankUtility.GetRankInfoField( f67_arg1, f67_arg2 - 1, @"maxxp", 0 )
	local f67_local5 = CoD.PrestigeUtility.UsingWidePermanentUnlockEntry( f67_arg1, f67_arg2 )
	local f67_local6 = CoD.PrestigeUtility.GetRankNameWZ( f67_arg2 )
	local f67_local7 = table.insert
	local f67_local8 = f67_local0
	local f67_local9 = {
		itemIndex = CoD.CACUtility.EmptyItemIndex,
		displayName = Engine[@"hash_4F9F1239CFD921FE"]( f67_local6 ),
		image = f67_local2,
		imageLarge = f67_local3,
		icon = f67_local3
	}
	local f67_local10
	if f67_local4 > 0 then
		f67_local10 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_70AA86CA0BD5920", f67_local4 )
		if not f67_local10 then
		
		else
			f67_local9.itemGroupName = f67_local10
			f67_local9.description = 0x0
			f67_local9.loadoutReferenceHash = nil
			f67_local9.isPermanentlyUnlocked = false
			f67_local9.useWideLayout = f67_local5
			f67_local9.rewardEarned = f67_arg3
			f67_local9.rankIndex = f67_arg2
			f67_local7( f67_local8, f67_local9 )
			while #f67_local0 < CoD.PrestigeUtility.MIN_REWARD_COUNT_WIDE_LAYOUT do
				table.insert( f67_local0, {
					itemIndex = CoD.CACUtility.EmptyItemIndex,
					displayName = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
					itemGroupName = "",
					image = @"blacktransparent",
					loadoutReferenceHash = nil,
					isPermanentlyUnlocked = false,
					useWideLayout = f67_local5,
					rewardEarned = false,
					rankIndex = f67_arg2
				} )
			end
			return f67_local0
		end
	end
	f67_local10 = ""
end
CoD.PrestigeUtility.GetRewardsForRank = function ( f68_arg0, f68_arg1, f68_arg2, f68_arg3 )
	local f68_local0 = {}
	local f68_local1 = f68_arg1 == Enum[@"emodes"][@"mode_zombies"]
	if f68_arg1 == Enum[@"emodes"][@"mode_warzone"] then
		return CoD.PrestigeUtility.GetWZRewardsForRank( f68_arg0, f68_arg1, f68_arg2, f68_arg3 )
	elseif IsArenaMode() then
		return CoD.PrestigeUtility.GetWLRewardsForRank( f68_arg0, f68_arg1, f68_arg2, f68_arg3 )
	end
	local f68_local2 = IsMaxPrestigeLevel( f68_arg0 )
	local f68_local3 = CoD.PrestigeUtility.UsingWidePermanentUnlockEntry( f68_arg1, f68_arg2 )
	for f68_local22, f68_local23 in pairs( CoD.RankUtility.GetRankInfoField( f68_arg1, f68_arg2, @"rewards", nil ) ) do
		if #f68_local0 >= CoD.PrestigeUtility.MIN_REWARD_COUNT_WIDE_LAYOUT then
			break
			while #f68_local0 < CoD.PrestigeUtility.MIN_REWARD_COUNT_WIDE_LAYOUT do
				table.insert( f68_local0, {
					itemIndex = CoD.CACUtility.EmptyItemIndex,
					displayName = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
					itemGroupName = "",
					image = @"blacktransparent",
					loadoutReferenceHash = nil,
					isPermanentlyUnlocked = false,
					useWideLayout = false,
					rewardEarned = false,
					rankIndex = f68_arg2
				} )
			end
			return f68_local0
		end
		local f68_local7 = Engine[@"hash_68FF94BB44442412"]( f68_local23.rewardName )
		local f68_local8 = CoD.PrestigeUtility.SpecialLoadoutRewards[f68_local23.rewardName]
		if f68_local8 ~= nil then
			local f68_local9 = f68_local8.index
			if not f68_local1 or not @"zm_default_loadouts" then
				local f68_local10 = LuaUtils.IsArenaMode()
				local f68_local11 = @"mp_arena_default_loadouts"
				local f68_local12 = @"mp_default_loadouts"
			end
			local f68_local13 = Engine[@"hash_2E00B2F29271C60B"]( f68_local10 and f68_local11 or f68_local12 )
			local f68_local14
			if f68_local1 then
				f68_local14 = "defaultcustomloadouts"
				if not f68_local14 then
				
				else
					local f68_local15 = f68_local13[f68_local14][f68_local9]
					local f68_local16 = Engine[@"hash_68FF94BB44442412"]
					local f68_local17
					if f68_local1 then
						f68_local17 = f68_local15[@"herogadget_2"]
						if not f68_local17 then
						
						else
							f68_local7 = f68_local16( f68_local17 )
							f68_local16 = CoD.CACUtility.GetUnlockableItemTable()
							f68_local16 = f68_local16[f68_local7]
							f68_local17 = table.insert
							local f68_local18 = f68_local0
							local f68_local19 = {
								itemIndex = -f68_local8.index
							}
							local f68_local20 = Engine[@"hash_4F9F1239CFD921FE"]
							local f68_local21
							if f68_local1 then
								f68_local21 = f68_local15[@"hash_66FC96C0FA5BFA2C"]
								if not f68_local21 then
								
								else
									f68_local19.displayName = f68_local20( f68_local21 )
									f68_local19.image = CoD.CACUtility.GetPreviewImage( f68_arg1, f68_local16 )
									f68_local19.imageLarge = CoD.CACUtility.GetPreviewImageLarge( f68_arg1, f68_local16 )
									f68_local19.itemGroupName = Engine[@"hash_4F9F1239CFD921FE"]( f68_local8.typeName )
									f68_local19.loadoutReferenceHash = f68_local23.rewardName
									f68_local19.isPermanentlyUnlocked = f68_local2
									f68_local19.useWideLayout = f68_local3
									f68_local19.rewardEarned = f68_arg3
									f68_local19.rankIndex = f68_arg2
									f68_local17( f68_local18, f68_local19 )
									goto basicblock_27:
								end
							end
							f68_local21 = f68_local15[@"customclassname"]
						end
					end
					f68_local17 = f68_local15[@"primary"]
				end
			end
			f68_local14 = f68_local8.loadoutList
		end
		if f68_local7 ~= CoD.CACUtility.EmptyItemIndex then
			local f68_local9 = CoD.CACUtility.GetUnlockableItemTable()
			f68_local9 = f68_local9[f68_local7]
			local f68_local13 = f68_local2 or Engine[@"hash_1D876F030270CB95"]( f68_arg0, f68_arg1, Engine[@"hash_7E12950F85CC3F92"]( f68_arg1, f68_local7 ) )
			if f68_local1 and f68_local9.nameHash == @"pistol_topbreak_t8" then
				f68_local13 = true
			end
			table.insert( f68_local0, {
				itemIndex = f68_local7,
				displayName = Engine[@"hash_4F9F1239CFD921FE"]( f68_local9.displayName ),
				description = f68_local9.description,
				image = CoD.CACUtility.GetPreviewImage( f68_arg1, f68_local9 ),
				imageLarge = CoD.CACUtility.GetPreviewImageLarge( f68_arg1, f68_local9 ),
				itemGroupName = Engine[@"hash_4F9F1239CFD921FE"]( CoD.CACUtility.GetItemGroupDisplayNameFromRef( f68_local9.itemGroup ) ),
				loadoutReferenceHash = nil,
				isPermanentlyUnlocked = f68_local13,
				useWideLayout = f68_local3,
				rewardEarned = f68_arg3,
				rankIndex = f68_arg2
			} )
		end
	end
end
DataSources.PrestigeRankInfo = ListHelper_SetupDataSource( "PrestigeRankInfo", function ( f69_arg0 )
	local f69_local0 = {}
	local f69_local1 = CoD.PrestigeUtility.GetPrestigeGameMode()
	local f69_local2 = CoD.RankUtility.GetRankInfoTable()
	local f69_local3 = f69_local2[f69_local1]
	local f69_local4 = CoD.PrestigeUtility.GetTargetPageList( f69_arg0 )
	local f69_local5 = DataSources.PrestigeMenuInfo.getModel( f69_arg0 )
	local f69_local6 = f69_local5.currentTargetPageIndex
	f69_local5 = f69_local4[f69_local5:get()].targetIndex
	f69_local6 = 0
	local f69_local7
	if f69_local1 == Enum[@"emodes"][@"mode_warzone"] then
		f69_local7 = CoD.PrestigeUtility.DEFAULT_WZ_REWARD_LIST_COUNT
		if not f69_local7 then
		
		else
			local f69_local8 = CoD.PrestigeUtility.GetCurrentLevel( f69_arg0, f69_local1 )
			for f69_local9 = f69_local5, #f69_local3, 1 do
				if #f69_local3 < f69_local9 then
					break
				elseif f69_local7 <= f69_local6 then
					break
				elseif CoD.PrestigeUtility.AddEntryForReward( f69_arg0, f69_local9 ) then
					local f69_local12 = f69_local9 <= f69_local8
					local f69_local13 = CoD.PrestigeUtility.GetRewardsForRank( f69_arg0, f69_local1, f69_local9, f69_local12 )
					local f69_local14 = CoD.PrestigeUtility.UsingWidePermanentUnlockEntry( f69_local1, f69_local9 )
					local f69_local15 = CoD.RankUtility.GetRankInfoField( f69_local1, f69_local9, @"iconlarge", @"blacktransparent" )
					if f69_local1 == Enum[@"emodes"][@"mode_warzone"] and CoD.PrestigeUtility.GetCurrentPLevel( f69_arg0, f69_local1 ) > 0 then
						if CoD.PrestigeUtility.SpecialWZRankRewardImages[f69_local9] then
							f69_local15 = CoD.PrestigeUtility.SpecialWZRankRewardImages[f69_local9].image1
						else
							f69_local15 = @"blacktransparent"
						end
					end
					table.insert( f69_local0, {
						models = {
							displayLevel = CoD.RankUtility.GetRankInfoField( f69_local1, f69_local9, @"level", 0x0 ),
							iconLarge = f69_local15,
							wideLayout = f69_local14,
							rankAchieved = f69_local12,
							reward1 = f69_local13[1],
							reward2 = f69_local13[2],
							reward3 = f69_local13[3]
						},
						properties = {
							selectIndex = f69_local8 == f69_local9
						}
					} )
					local f69_local16
					if f69_local14 then
						f69_local16 = CoD.PrestigeUtility.WIDE_LAYOUT_ENTRY_COUNT
						if not f69_local16 then
						
						else
							f69_local6 = f69_local6 + f69_local16
						end
					end
					f69_local16 = CoD.PrestigeUtility.STANDARD_LAYOUT_ENTRY_COUNT
				end
			end
			return f69_local0
		end
	end
	f69_local7 = CoD.PrestigeUtility.DEFAULT_REWARD_LIST_COUNT
end, true )
DataSources.WorldLeagueRankInfo = ListHelper_SetupDataSource( "WorldLeagueRankInfo", function ( f70_arg0 )
	local f70_local0 = {}
	local f70_local1 = LuaUtils.GetLeaguePlayTierTable()
	if IsArenaMode() then
		local f70_local2 = f70_local1[@"maxrank"]
		local f70_local3 = CoD.PrestigeUtility.GetPrestigeGameMode()
		local f70_local4 = CoD.PrestigeUtility.GetTargetPageList( f70_arg0 )
		local f70_local5 = DataSources.PrestigeMenuInfo.getModel( f70_arg0 )
		local f70_local6 = f70_local5.currentTargetPageIndex
		f70_local5 = f70_local4[f70_local5:get()].targetIndex
		f70_local6 = 0
		local f70_local7 = CoD.PrestigeUtility.DEFAULT_REWARD_LIST_COUNT
		local f70_local8 = CoD.ArenaLeaguePlayUtility.GetPoints( f70_arg0 )
		local f70_local9 = CoD.ArenaLeaguePlayUtility.GetStreak( f70_arg0 )
		local f70_local10, f70_local11, f70_local12 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon( f70_local8, CoD.ArenaLeaguePlayUtility.GetBestRank( f70_arg0 ), CoD.ArenaLeaguePlayUtility.GetFirstPlaceCount( f70_arg0 ) )
		f70_local10 = f70_local10 - 1
		local f70_local13, f70_local14, f70_local15, f70_local16, f70_local17 = CoD.ArenaLeaguePlayUtility.GetRankForEachPlacement( f70_arg0 )
		for f70_local18 = f70_local5, f70_local5 + f70_local7, 1 do
			if f70_local2 <= f70_local18 then
				break
			elseif f70_local7 <= f70_local6 then
				break
			end
			local f70_local21 = f70_local18 <= f70_local10
			local f70_local22 = CoD.PrestigeUtility.GetRewardsForRank( f70_arg0, f70_local3, f70_local18, f70_local21 )
			local f70_local23, f70_local24 = CoD.ArenaLeaguePlayUtility.GetRankIconAtRank( f70_local18 + 1, f70_local13, f70_local14, f70_local15, f70_local16, f70_local17 )
			local f70_local25 = table.insert
			local f70_local26 = f70_local0
			local f70_local27 = {}
			local f70_local28 = {
				displayLevel = f70_local18 + 1,
				iconLarge = f70_local24,
				wideLayout = false
			}
			local f70_local29 = f70_local22[1].hasRewards
			if not f70_local29 then
				f70_local29 = f70_local22[2].hasRewards
				if not f70_local29 then
					f70_local29 = f70_local22[3].hasRewards
				end
			end
			f70_local28.rewardsLayout = f70_local29
			f70_local28.rankAchieved = f70_local21
			f70_local28.reward1 = f70_local22[1]
			f70_local28.reward2 = f70_local22[2]
			f70_local28.reward3 = f70_local22[3]
			f70_local28.leagueRank = f70_local18 + 1
			f70_local28.rubiesUnlocked = CoD.ArenaLeaguePlayUtility.RubiesUnlockedAtRank( f70_local8, f70_local10, f70_local18 )
			f70_local27.models = f70_local28
			f70_local27.properties = {
				selectIndex = f70_local10 == f70_local18
			}
			f70_local25( f70_local26, f70_local27 )
			f70_local6 = f70_local6 + CoD.PrestigeUtility.STANDARD_LAYOUT_ENTRY_COUNT
		end
	end
	return f70_local0
end, true )
DataSources.LevelRewardLoadoutInfo = ListHelper_SetupDataSource( "LevelRewardLoadoutInfo", function ( f71_arg0 )
	local f71_local0 = {}
	local f71_local1 = CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_zombies"]
	local f71_local2 = function ( f72_arg0 )
		local f72_local0 = CoD.CACUtility.GetUnlockableItemTable()
		f72_local0 = f72_local0[f72_arg0]
		if not f72_local0 then
			return 
		elseif not CoD.CACUtility.GetLoadoutSlotStringForRef( f72_local0.loadoutSlot ) then
			local f72_local1 = CoD.CACUtility.GetItemGroupDisplayNameFromRef( f72_local0.itemGroup )
		end
		if f71_local1 and f72_local0.loadoutSlot == "herogadget" then
			local f72_local1 = 0x3377F50B93AB03
		end
		table.insert( f71_local0, {
			models = {
				loadoutEntryCategory = f72_local1,
				loadoutEntryName = f72_local0.displayName
			}
		} )
	end
	
	local f71_local3 = function ( f73_arg0, f73_arg1, f73_arg2 )
		local f73_local0 = CoD.CACUtility.EmptyItemIndex
		if f73_arg0 then
			if type( f73_arg0 ) == "xhash" then
				f73_local0 = Engine[@"hash_2D97229B24C685D5"]( f73_arg0, f73_arg2 )
			elseif type( f73_arg0 ) == "string" then
				f73_local0 = Engine[@"getitemindexfromreference"]( f73_arg0, f73_arg2 )
			end
			f73_local0 = Engine[@"hash_1E8B1E317B9DD6FE"]( f73_local0, f73_arg1, f73_arg2 ) or f73_local0
		end
		if f73_local0 ~= CoD.CACUtility.EmptyItemIndex then
			f71_local2( f73_local0 )
		end
	end
	
	local f71_local4 = DataSources.PrestigeMenuInfo.getModel( f71_arg0 )
	if f71_local4.currentHighlightedItem == nil or not f71_local4.currentHighlightedItem.loadoutReferenceHash then
		return f71_local0
	end
	local f71_local5 = f71_local4.currentHighlightedItem.loadoutReferenceHash:get()
	if f71_local5 == nil then
		return f71_local0
	end
	local f71_local6 = CoD.PrestigeUtility.GetPrestigeGameMode()
	local f71_local7 = CoD.PrestigeUtility.SpecialLoadoutRewards[f71_local5]
	local f71_local8 = f71_local7.index
	if not f71_local1 or not @"zm_default_loadouts" then
		local f71_local9 = LuaUtils.IsArenaMode()
		local f71_local10 = @"mp_arena_default_loadouts"
		local f71_local11 = @"mp_default_loadouts"
	end
	local f71_local12 = Engine[@"hash_2E00B2F29271C60B"]( f71_local9 and f71_local10 or f71_local11 )
	local f71_local13
	if f71_local1 then
		f71_local13 = "defaultcustomloadouts"
		if not f71_local13 then
		
		else
			local f71_local14 = f71_local12[f71_local13][f71_local8]
			if f71_local1 then
				f71_local3( f71_local14[@"herogadget_2"], Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f71_local6 )
				f71_local3( f71_local14[@"primarygrenade_2"], Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f71_local6 )
				if f71_local14.bubblegumbuffs_2 then
					for f71_local18, f71_local19 in ipairs( f71_local14.bubblegumbuffs ) do
						f71_local3( f71_local19[@"bubblegumbuff"], Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f71_local6 )
					end
				end
				if f71_local14.specialties_2 then
					for f71_local18, f71_local19 in ipairs( f71_local14.specialties_2 ) do
						f71_local3( f71_local19[@"specialty"], Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f71_local6 )
					end
				end
			else
				f71_local3( f71_local14[@"primary"], Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f71_local6 )
				f71_local3( f71_local14[@"secondary"], Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f71_local6 )
				f71_local3( f71_local14[@"primarygrenade"], Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f71_local6 )
				f71_local3( f71_local14[@"tacticalgear"], Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"], f71_local6 )
				if f71_local14.talents then
					for f71_local18, f71_local19 in ipairs( f71_local14.talents ) do
						f71_local3( f71_local19[@"talent"], Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"], f71_local6 )
					end
				end
				if f71_local14.bonuscards then
					for f71_local18, f71_local19 in ipairs( f71_local14.bonuscards ) do
						f71_local3( f71_local19[@"bonuscard"], Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"], f71_local6 )
					end
				end
			end
			return f71_local0
		end
	end
	f71_local13 = f71_local7.loadoutList
end, true )
DataSources.PrestigeCallingCard = {
	getModel = function ( f74_arg0 )
		local f74_local0 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f74_arg0 ), "PrestigeCallingCard" )
		if f74_local0 == nil then
			f74_local0 = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f74_arg0 ), "PrestigeCallingCard" )
			f74_local0:create( "title" )
			f74_local0:create( "description" )
			f74_local0:create( "iconId" )
			f74_local0:create( "percentComplete" )
			f74_local0:create( "isLocked" )
		end
		return f74_local0
	end,
	setModelValues = function ( f75_arg0, f75_arg1, f75_arg2, f75_arg3, f75_arg4 )
		local f75_local0 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f75_arg0 ), "PrestigeCallingCard" )
		if f75_local0 == nil then
			f75_local0 = DataSources.PrestigeCallingCard.getModel( f75_arg0 )
		end
		f75_local0.title:set( f75_arg1 )
		f75_local0.description:set( f75_arg2 )
		f75_local0.iconId:set( f75_arg3 )
		f75_local0.percentComplete:set( f75_arg4 )
		f75_local0.isLocked:set( f75_arg4 < 1 )
	end
}
local f0_local3 = {
	true,
	true,
	true,
	true
}
DataSources.PrestigeRewards = ListHelper_SetupDataSource( "PrestigeRewards", function ( f76_arg0 )
	local f76_local0 = {}
	local f76_local1 = function ( f77_arg0, f77_arg1 )
		table.insert( f76_local0, {
			models = {
				rewardImage = f77_arg0,
				rewardText = f77_arg1
			}
		} )
	end
	
	local f76_local2 = CoD.PrestigeUtility.GetPrestigeGameMode()
	local f76_local3 = CoD.PrestigeUtility.GetCurrentPLevel( f76_arg0, f76_local2 ) + 1
	f76_local1( Engine[@"hash_2FC100C7712C1987"]( f76_local3, f76_local2 ), Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1A15D2B49843A6EB", f76_local3 ) )
	if f76_local2 ~= Enum[@"emodes"][@"mode_warzone"] then
		f76_local1( @"ui_icon_prestige_permanenttoken_large", @"hash_7943D0DA9B5CB36E" )
	end
	if f76_local2 == Enum[@"emodes"][@"mode_zombies"] then
		f76_local1( @"ui_icon_nebulium_medium", @"menu/plasma" )
	elseif f76_local2 == Enum[@"emodes"][@"mode_multiplayer"] and f0_local3[f76_local3] then
		f76_local1( @"uie_create_a_class_reward_icon", @"hash_59DC7EEA939C4551" )
	end
	return f76_local0
end, true )
CoD.OverlayUtility.AddSystemOverlay( "EnterPrestigeMode", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = function ( f78_arg0 )
		return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_7E903B367C2A5717", CoD.PrestigeUtility.GetCurrentPLevel( f78_arg0 ) + 1 )
	end,
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_6D4D5A6F9B41B3A6" ),
	prestigeItemName = function ( f79_arg0 )
		return CoD.GetRankName( 0, CoD.PrestigeUtility.GetCurrentPLevel( f79_arg0 ) + 1, CoD.PrestigeUtility.GetPrestigeGameMode() )
	end,
	description = function ()
		return Engine[@"hash_4F9F1239CFD921FE"]( CoD.PrestigeUtility.GetStringForMode( @"prestige_description" ) )
	end,
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.Standard,
	image = function ( f81_arg0 )
		return Engine[@"hash_2FC100C7712C1987"]( CoD.PrestigeUtility.GetCurrentPLevel( f81_arg0 ) + 1, CoD.PrestigeUtility.GetPrestigeGameMode() )
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function ( f82_arg0 )
		DataSources.UnlockTokenMenuList = DataSourceHelpers.ListSetup( "UnlockTokenMenuList", function ( f83_arg0 )
			local f83_local0 = {}
			local f83_local1 = CoD.PrestigeUtility.GetCurrentPLevel( f83_arg0 ) + 1
			local f83_local2 = function ( f84_arg0, f84_arg1, f84_arg2 )
				return {
					models = {
						displayText = f84_arg0
					},
					properties = {
						action = f84_arg1,
						selectIndex = f84_arg2
					}
				}
			end
			
			local f83_local3 = function ( f85_arg0, f85_arg1, f85_arg2, f85_arg3, f85_arg4 )
				if CheckIfFeatureIsBanned( f85_arg2, LuaEnum.FEATURE_BAN.PRESTIGE ) then
					LuaUtils.UI_ShowErrorMessageDialog( f85_arg2, GetFeatureBanInfo( f85_arg2, LuaEnum.FEATURE_BAN.PRESTIGE ) )
					return 
				else
					CoD.PrestigeUtility.EnterPrestigeAction( f85_arg0, f85_arg2, f85_arg4 )
					PlaySoundAlias( "uin_press_generic" )
					GoBack( f85_arg4, f85_arg2 )
				end
			end
			
			local f83_local4 = function ( f86_arg0, f86_arg1, f86_arg2, f86_arg3, f86_arg4 )
				GoBack( f86_arg4, f86_arg2 )
			end
			
			table.insert( f83_local0, f83_local2( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_5E574BBAD7F9CEAE", f83_local1 ), f83_local3, false ) )
			table.insert( f83_local0, f83_local2( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/cancel" ), f83_local4, true ) )
			return f83_local0
		end, true )
		return "UnlockTokenMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "PrestigeFreshStart1", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_499EDC1B272ABA57" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1EA01E48F3DF7660" ),
	prestigeItemName = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_499EDC1B272ABA57" ),
	description = Engine[@"hash_4F9F1239CFD921FE"]( CoD.PrestigeUtility.GetStringForMode( @"hash_65741301630398C1" ) ),
	supportText = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_ECA1FDC726D20ED" ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.FreshStart,
	image = "uie_ui_icon_prestige_freshstart",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function ( f87_arg0 )
		DataSources.UnlockTokenMenuList = DataSourceHelpers.ListSetup( "UnlockTokenMenuList", function ( f88_arg0 )
			local f88_local0 = {}
			local f88_local1 = function ( f89_arg0, f89_arg1, f89_arg2 )
				return {
					models = {
						displayText = f89_arg0
					},
					properties = {
						action = f89_arg1,
						selectIndex = f89_arg2
					}
				}
			end
			
			local f88_local2 = function ( f90_arg0, f90_arg1, f90_arg2, f90_arg3, f90_arg4 )
				OpenSystemOverlay( f90_arg0, GoBack( f90_arg4, f90_arg2 ), f90_arg2, "PrestigeFreshStart2", nil )
			end
			
			local f88_local3 = function ( f91_arg0, f91_arg1, f91_arg2, f91_arg3, f91_arg4 )
				GoBack( f91_arg4, f91_arg2 )
			end
			
			table.insert( f88_local0, f88_local1( @"hash_2395CB6A23357AF6", f88_local2, false ) )
			table.insert( f88_local0, f88_local1( @"menu/cancel", f88_local3, true ) )
			return f88_local0
		end, true )
		return "UnlockTokenMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "PrestigeFreshStart2", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_E600BD476A84DE9" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1EA01E48F3DF7660" ),
	description = Engine[@"hash_4F9F1239CFD921FE"]( CoD.PrestigeUtility.GetStringForMode( @"hash_1DBA7AA206A2D3FB" ) ),
	supportText = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_ECA1CDC726D1BD4" ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.FreshStart,
	image = "uie_ui_icon_prestige_freshstart",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function ( f92_arg0 )
		DataSources.UnlockTokenMenuList = DataSourceHelpers.ListSetup( "UnlockTokenMenuList", function ( f93_arg0 )
			local f93_local0 = {}
			local f93_local1 = function ( f94_arg0, f94_arg1, f94_arg2 )
				return {
					models = {
						displayText = f94_arg0
					},
					properties = {
						action = f94_arg1,
						selectIndex = f94_arg2
					}
				}
			end
			
			local f93_local2 = function ( f95_arg0, f95_arg1, f95_arg2, f95_arg3, f95_arg4 )
				CoD.PrestigeUtility.FreshStartAction( f95_arg0, f95_arg2, f95_arg4 )
				GoBack( f95_arg0, f95_arg2 )
			end
			
			local f93_local3 = function ( f96_arg0, f96_arg1, f96_arg2, f96_arg3, f96_arg4 )
				GoBack( f96_arg4, f96_arg2 )
			end
			
			table.insert( f93_local0, f93_local1( @"hash_2395CB6A23357AF6", f93_local2, false ) )
			table.insert( f93_local0, f93_local1( @"menu/cancel", f93_local3, true ) )
			return f93_local0
		end, true )
		return "UnlockTokenMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "PrestigeMasterNotification", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/prestige_master" ),
	description = function ()
		if CoD.isZombie == true then
			return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_12F1A76D4186CCC5" )
		else
			return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_122E59E4E76F889" )
		end
	end,
	image = function ( f98_arg0 )
		local f98_local0 = Enum[@"emodes"][@"mode_multiplayer"]
		if CoD.isZombie == true then
			f98_local0 = Enum[@"emodes"][@"mode_zombies"]
		end
		return GetRankIconLarge( Engine[@"getrankicon"]( 0, CoD.PrestigeUtility.GetPrestigeCap( f98_local0 ), f98_local0 ) )
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = nil,
	[CoD.OverlayUtility.ContinuePropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "BetaTokenNotification", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_3A833716CBB8F05A" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_7FBF779C0C40B1AF" ),
	prestigeItemName = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_7761785BDEE02A1D" ),
	description = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_58D7FE0562ECF1E" ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.Standard,
	image = "prestige_icon_awards",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function ( f99_arg0 )
		DataSources.UnlockTokenMenuList = DataSourceHelpers.ListSetup( "UnlockTokenMenuList", function ( f100_arg0 )
			local f100_local0 = {}
			local f100_local1 = function ( f101_arg0, f101_arg1, f101_arg2 )
				return {
					models = {
						displayText = f101_arg0
					},
					properties = {
						action = f101_arg1,
						selectIndex = f101_arg2
					}
				}
			end
			
			table.insert( f100_local0, f100_local1( @"menu/redeem", function ( f102_arg0, f102_arg1, f102_arg2, f102_arg3, f102_arg4 )
				GoBack( f102_arg4, f102_arg2 )
			end, true ) )
			return f100_local0
		end, true )
		return "UnlockTokenMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "PermanentUnlockClassItem", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/permanent_unlock" ),
	prestigeItemName = function ( f103_arg0, f103_arg1 )
		return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_287EEF440127A8D9", CoD.CACUtility.GetItemGroupDisplayNameFromRef( Engine[@"getitemgroup"]( f103_arg1 ) ), Engine[@"getitemname"]( f103_arg1, CoD.PrestigeUtility.GetPermanentUnlockMode() ) )
	end,
	description = function ( f104_arg0, f104_arg1 )
		return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_77916417949FD96D", Engine[@"getitemname"]( f104_arg1, CoD.PrestigeUtility.GetPermanentUnlockMode() ) )
	end,
	supportText = function ( f105_arg0, f105_arg1 )
		return Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( f105_arg1, CoD.PrestigeUtility.GetPermanentUnlockMode() ) )
	end,
	image = function ( f106_arg0, f106_arg1, f106_arg2 )
		return f106_arg2
	end,
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.TokenUnlock,
	categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
	listDatasource = function ( f107_arg0, f107_arg1 )
		DataSources.UnlockTokenMenuList = DataSourceHelpers.ListSetup( "UnlockTokenMenuList", function ( f108_arg0 )
			local f108_local0 = {}
			local f108_local1 = function ( f109_arg0, f109_arg1, f109_arg2 )
				return {
					models = {
						displayText = f109_arg0,
						itemIndex = f107_arg1
					},
					properties = {
						action = f109_arg1,
						selectIndex = f109_arg2
					}
				}
			end
			
			local f108_local2 = function ( f110_arg0, f110_arg1, f110_arg2, f110_arg3, f110_arg4 )
				local f110_local0 = CoD.PrestigeUtility.GetPermanentUnlockMode()
				Engine[@"prestigeunlock"]( f110_arg2, f110_local0, Engine[@"hash_7E12950F85CC3F92"]( f110_local0, f107_arg1 ) )
				f110_arg4:dispatchEventToRoot( {
					name = "used_permanent_unlock_token",
					controller = f110_arg2
				} )
				GoBackAndUpdateStateOnPreviousMenu( f110_arg4, f110_arg2 )
			end
			
			local f108_local3 = function ( f111_arg0, f111_arg1, f111_arg2, f111_arg3, f111_arg4 )
				GoBack( f111_arg4, f111_arg2 )
			end
			
			table.insert( f108_local0, f108_local1( @"hash_156A1934FFD3E74D", f108_local2, false ) )
			table.insert( f108_local0, f108_local1( @"menu/cancel", f108_local3, true ) )
			return f108_local0
		end, true )
		return "UnlockTokenMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
DataSources.PrestigeMasterTiers = DataSourceHelpers.ListSetup( "PrestigeMasterTiers", function ( f112_arg0 )
	local f112_local0 = {}
	local f112_local1 = GetPrestigeMasterTierCountFromStorage( f112_arg0, CoD.ModeToModeString( CoD.PrestigeUtility.GetPrestigeGameMode() ), 10 )
	for f112_local2 = 1, CoD.PrestigeUtility.PRESTIGE_MASTER_MAX_TIERS, 1 do
		local f112_local5 = false
		if f112_local2 <= f112_local1 then
			f112_local5 = true
		end
		table.insert( f112_local0, {
			models = {
				tierAchieved = f112_local5
			}
		} )
	end
	return f112_local0
end )
CoD.OverlayUtility.AddSystemOverlay( "RequestProcessingOverlay", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( 0x1FE7F4D169E0A3 ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.RequestProcessing,
	categoryType = CoD.OverlayUtility.OverlayTypes.Unlock
} )
CoD.OverlayUtility.AddSystemOverlay( "RequestProcessingOverlayFreshStart", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_3A5831C2F133D78D" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.RequestProcessing,
	categoryType = CoD.OverlayUtility.OverlayTypes.Unlock
} )
CoD.OverlayUtility.AddSystemOverlay( "RequestProcessingFailedOverlay", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1587F64C89E905D1" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.RequestProcessing,
	categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "PrestigeUnlockRequestProcessingSuccessOverlay", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_34B772E8D26909F7" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.RequestProcessing,
	categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "PrestigeUnlockRequestProcessingFailedOverlay", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_5D6817A5C2D2DA56" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.RequestProcessing,
	categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
CoD.OverlayUtility.AddSystemOverlay( "FreshStartRequestProcessingFailedOverlay", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_Prestige",
	title = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_516B37A167EBED57" ),
	subtitle = Engine[@"hash_4F9F1239CFD921FE"]( 0x0 ),
	prestigeLayout = CoD.PrestigeUtility.PrestigeOverlayLayouts.RequestProcessing,
	categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
} )
