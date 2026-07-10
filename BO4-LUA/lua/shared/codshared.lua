
require( "x64:c71b3cf9012e5dd" )
local f0_local0 = {
	GetXUID64StringForController = function ( f1_arg0 )
		return Engine[@"xuidtostring"]( Engine[@"getxuid64"]( f1_arg0 ) )
	end
}
local f0_local1, f0_local2 = nil
f0_local0.IsGametypeTeamBased = function ( f2_arg0 )
	if not f2_arg0 then
		f2_arg0 = Engine[@"lobbygetgametype"]()
	end
	if f2_arg0 == f0_local1 then
		return f0_local2
	else
		local f2_local0 = Engine[@"getgametypeinfo"]( f2_arg0 )
		local f2_local1 = f2_local0.isTeamBased
		if f2_local1 == nil then
			return false
		else
			f0_local1 = f2_arg0
			f0_local2 = f2_local1
			return f2_local1
		end
	end
end
f0_local0.GetGametypeMaxTeamPlayers = function ()
	local f3_local0 = Engine[@"getgametypesettings"]()
	return f3_local0 and f3_local0[@"maxteamplayers"]:get() or 0
end
f0_local0.IsGametypeHidingHudScore = function ( f4_arg0 )
	if not f4_arg0 then
		f4_arg0 = Engine[@"lobbygetgametype"]()
	end
	local f4_local0 = Engine[@"getgametypeinfo"]( f4_arg0 )
	local f4_local1 = f4_local0.hideHudScore
	if f4_local1 == nil then
		return false
	else
		return f4_local1
	end
end
f0_local0.IsHardcoreGametypeAvailable = function ( f5_arg0 )
	if not f5_arg0 then
		f5_arg0 = Engine[@"lobbygetgametype"]()
	end
	local f5_local0 = Engine[@"getgametypeinfo"]( f5_arg0 )
	local f5_local1 = f5_local0.isHardcoreAvailable
	if f5_local1 == nil then
		return false
	else
		return f5_local1
	end
end
f0_local0.ChunkAllDownloading = function ()
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and Engine[@"hash_77D47312EBA41751"]() then
		return true
	else
		return false
	end
end
f0_local0.ChunkAnyDownloading = function ()
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and Engine[@"hash_77D47312EBA41751"]() then
		return true
	else
		return false
	end
end
f0_local0.IsTeamBasedGame = function ()
	if Engine[@"isdedicatedserver"]() then
		return Engine[@"getgametypesetting"]( @"teamcount" ) > 1
	elseif Engine[@"isingame"]() then
		return CoDShared.IsGametypeTeamBased()
	else
		return CoDShared.IsGametypeTeamBased( Engine[@"hash_36F8027A8BC75673"]() )
	end
end
f0_local0.IsLobbyMode = function ( f9_arg0 )
	local f9_local0 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	return f9_local0[@"lobbymode"] == f9_arg0
end
f0_local0.IsOnlineGame = function ()
	if Engine[@"sessionmode_isonlinegame"]() then
		return true
	else
		return false
	end
end
f0_local0.IsRankedGame = function ()
	local f11_local0
	if f0_local0.IsOnlineGame() == true and not Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"mode_game_matchmaking_manual"] ) then
		f11_local0 = not Engine[@"gamemodeismode"]( Enum[@"egamemodes"][@"hash_27B5630CD29180CB"] )
	else
		f11_local0 = false
	end
	return f11_local0
end
f0_local0.IsHost = function ()
	return Engine[@"getdvarbool"]( "com_sv_running" )
end
f0_local0.GetTeamDifference = function ( f13_arg0 )
	if f13_arg0 ~= Enum[@"team_t"][@"team_allies"] and f13_arg0 ~= Enum[@"team_t"][@"team_axis"] then
		return 0
	end
	local f13_local0 = Engine[@"lobbygetsessionclients"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	local f13_local1 = f13_local0.sessionClients
	local f13_local2 = 0
	local f13_local3 = 0
	for f13_local7, f13_local8 in ipairs( f13_local1 ) do
		if f13_local8.team == Enum[@"team_t"][@"team_allies"] then
			f13_local2 = f13_local2 + 1
		end
		if f13_local8.team == Enum[@"team_t"][@"team_axis"] then
			f13_local3 = f13_local3 + 1
		end
	end
	if f13_arg0 == Enum[@"team_t"][@"team_allies"] then
		return f13_local2 - f13_local3
	end
	return f13_local3 - f13_local2
end
f0_local0.IsTeamOverwhelmed = function ( f14_arg0 )
	local f14_local0 = Engine[@"getteamforxuid"]( Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] ), Engine[@"getxuid64"]( f14_arg0 ) )
	local f14_local1 = Dvar[@"arena_unfairteamgap"]:get() * -1
	if f14_local1 == 0 or f14_local1 < f0_local0.GetTeamDifference( f14_local0 ) then
		return false
	else
		return true
	end
end
f0_local0.QuitGame = function ( f15_arg0, f15_arg1 )
	if Engine[@"isrunninguilevel"]() then
		return true
	end
	local f15_local0 = Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] )
	local f15_local1 = Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_local"] )
	local f15_local2 = Engine[@"getlobbyhostinfo"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	if f15_local2 ~= nil then
		if nil ~= LobbyVM then
			Lobby.Events.EventDispatcher( "OnMatchmakingPriorityQuit", {
				hostSecId = f15_local2.secIdint
			} )
		else
			Engine[@"lobbyevent"]( "OnMatchmakingPriorityQuit", {
				hostSecId = f15_local2.secIdint
			} )
		end
	end
	if f0_local0.IsLobbyMode( Enum[@"lobbymode"][@"lobby_mode_theater"] ) == true then
		if not Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] ) then
			Engine[@"gamemoderesetmodes"]()
			Engine[@"sessionmoderesetmodes"]()
			Engine[@"exec"]( f15_arg0, "disconnect" )
		else
			Engine[@"exec"]( f15_arg0, "xpartystopdemo" )
		end
		return true
	end
	local f15_local3 = Engine[@"getglobalmodel"]()
	f15_local3 = f15_local3:create( "lobbyRoot.quitGameFlag", true )
	f15_local3:set( LuaEnum.QUIT_FLAG.MARK_AS_QUIT )
	if not f0_local0.IsHost() then
		if f15_arg1 then
			Engine[@"updatestatsforquitunbalancedteam"]( f15_arg0, false )
		else
			Engine[@"updatestatsforquit"]( f15_arg0, false )
		end
		Engine[@"exec"]( f15_arg0, "disconnect" )
	elseif not f0_local0.IsRankedGame() then
		Engine[@"sendmenuresponse"]( f15_arg0, "popup_leavegame", "endround", 0 )
	elseif f0_local0.IsRankedGame() and f0_local0.IsHost() and not Engine[@"hostmigrationwaitingforplayers"]() and Engine[@"getdvarint"]( "g_gameEnded" ) ~= 1 then
		Engine[@"updatestatsforquit"]( f15_arg0, true )
		local f15_local4 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
		local f15_local5 = f15_local4[@"id"] == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE )
		local f15_local6 = 2
		if Enum[@"uivisibilitybit"] and Engine[@"isvisibilitybitset"]( f15_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"] ) then
			f15_local6 = 1
		end
		local f15_local7 = Engine[@"getdvarint"]( "sv_enableZombiesHostMigration" )
		if f15_local7 == 2 then
			f15_local5 = false
		end
		if (not (not Engine[@"ismultiplayergame"]() and (not Engine[@"iszombiesgame"]() or f15_local7 == 0 or f15_local5 ~= false or f15_local6 > f15_local0 - Engine[@"hash_4D1E13D329F1C745"]( f15_arg0 ))) or f0_local0.IsGameTypeDOA()) and f15_local0 >= Dvar[@"migration_minclientcount"]:get() and f15_local0 ~= f15_local1 then
			Engine[@"exec"]( f15_arg0, "hostmigration_start" )
			return false
		end
		Engine[@"sendmenuresponse"]( f15_arg0, "popup_leavegame", "endround", 0 )
	end
	return true
end
f0_local0.UpdateQuitFlag = function ()
	local f16_local0 = Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "lobbyRoot.quitGameFlag" )
	if f16_local0 then
		local f16_local1 = f16_local0:get()
		if f16_local1 == LuaEnum.QUIT_FLAG.MARK_AS_QUIT then
			f16_local0:set( LuaEnum.QUIT_FLAG.QUIT_PREVIOUS_GAME )
		elseif f16_local1 == LuaEnum.QUIT_FLAG.QUIT_PREVIOUS_GAME then
			f16_local0:set( LuaEnum.QUIT_FLAG.HAS_NOT_QUIT )
		end
	end
end
f0_local0.IsGameTypeDOA = function ()
	local f17_local0
	if Engine[@"lobbygetgametype"]() ~= "doa" and (Engine[@"getcurrentmap"]() == nil or Engine[@"getcurrentmap"]() ~= "cp_doa_bo3") then
		f17_local0 = LuaUtils.IsDOATarget( Engine[@"getlobbyuiscreen"]() )
	else
		f17_local0 = true
	end
	return f17_local0
end
f0_local0.IsLootHero = function ( f18_arg0 )
	if f18_arg0 ~= nil and f18_arg0.assetName ~= nil and f18_arg0.assetName == @"hash_36F37765CB5B1F2F" then
		return true
	else
		return false
	end
end
f0_local0.GetCallingCardIdFromImage = function ( f19_arg0 )
	local f19_local0 = "gamedata/emblems/backgrounds.csv"
	local f19_local1 = 1
	local f19_local2 = 3
	local f19_local3 = 19
	local f19_local4 = Engine[@"tablelookup"]( f19_local0, f19_local1, f19_local2, f19_arg0 )
	if not f19_local4 and LuaDefine.isPC and Engine[@"hash_3E78C83C300F9368"]() and Engine[@"hash_3A8FBC7AC4C3F3A6"]() then
		f19_local4 = Engine[@"tablelookup"]( f19_local0, f19_local1, f19_local3, f19_arg0 )
	end
	return f19_local4
end
f0_local0.GetSetBonusCallingCardIdFromImage = function ( f20_arg0 )
	local f20_local0 = "gamedata/emblems/backgrounds.csv"
	local f20_local1 = 1
	local f20_local2 = 15
	local f20_local3 = 19
	local f20_local4 = Engine[@"tablelookup"]( f20_local0, f20_local1, f20_local2, f20_arg0 )
	if not f20_local4 and LuaDefine.isPC and Engine[@"hash_3E78C83C300F9368"]() and Engine[@"hash_3A8FBC7AC4C3F3A6"]() then
		f20_local4 = Engine[@"tablelookup"]( f20_local0, f20_local1, f20_local3, f20_arg0 )
	end
	return f20_local4
end
f0_local0.GetEmblemIdFromImage = function ( f21_arg0 )
	return Engine[@"tablelookup"]( "gamedata/emblems/emblemIcons.csv", 1, 3, f21_arg0 )
end
f0_local0.LootIndexInfoLookup = function ( f22_arg0, f22_arg1 )
	local f22_local0 = "gamedata/loot/loot_index.csv"
	local f22_local1 = "gamedata/loot/loot_index_2.csv"
	local f22_local2 = 0
	local f22_local3 = 1
	local f22_local4 = 2
	local f22_local5 = 3
	local f22_local6 = 4
	local f22_local7 = 5
	local f22_local8 = 6
	local f22_local9 = f22_local0
	local f22_local10 = Engine[@"tablefindrows"]( f22_local0, f22_local2, f22_arg0 )
	if f22_local10 == nil or #f22_local10 == 0 then
		f22_local10 = Engine[@"tablefindrows"]( f22_local1, f22_local2, f22_arg0 )
		f22_local9 = f22_local1
		if f22_local10 == nil or #f22_local10 == 0 then
			return nil
		end
	end
	local f22_local11 = f22_local10[1]
	return {
		itemId = Engine[@"hash_4C6F8EC444864600"]( f22_local9, f22_local11, f22_local3 ),
		nameHash = Engine[@"hash_4C6F8EC444864600"]( f22_local9, f22_local11, f22_local2 ),
		table = Engine[@"hash_4C6F8EC444864600"]( f22_local9, f22_local11, f22_local4 ),
		bundles = Engine[@"hash_4C6F8EC444864600"]( f22_local9, f22_local11, f22_local5 ),
		drop = Engine[@"hash_4C6F8EC444864600"]( f22_local9, f22_local11, f22_local6 ),
		season = Engine[@"hash_4C6F8EC444864600"]( f22_local9, f22_local11, f22_local7 ),
		category = Engine[@"hash_4C6F8EC444864600"]( f22_local9, f22_local11, f22_local8 )
	}
end
f0_local0.IsLootItemDefaultUnlocked = function ( f23_arg0 )
	local f23_local0 = CoDLootShared.GetItemNameHashFromLootId( f23_arg0 )
	if CoDLootShared.DefaultUnlockedLootTable[f23_local0] then
		if #CoDLootShared.DefaultUnlockedLootTable[f23_local0] == 0 then
			return true
		elseif LuaUtils.FindItemInArray( CoDLootShared.DefaultUnlockedLootTable[f23_local0], Engine[@"currentsessionmode"]() ) then
			return true
		end
	end
	return false
end
f0_local0.IsLootItemOwned = function ( f24_arg0, f24_arg1, f24_arg2 )
	if Engine[@"getdvarbool"]( @"loot_fakeall" ) then
		return true
	elseif Engine[@"hash_5352DC095BBB2A45"]( f24_arg0, f24_arg1 ) > 0 then
		return true
	elseif CoDShared.IsLootItemDefaultUnlocked( f24_arg1 ) then
		return true
	elseif f24_arg2 then
		for f24_local3, f24_local4 in ipairs( f24_arg2 ) do
			local f24_local5 = CoDShared.LootIndexInfoLookup( f24_local4 )
			if f24_local5 and f24_local5.itemId and Engine[@"hash_5352DC095BBB2A45"]( f24_arg0, f24_local5.itemId ) > 0 then
				return true
			end
		end
	end
	return false
end
f0_local0.IsLootItemOwnedByName = function ( f25_arg0, f25_arg1 )
	if not f25_arg1 then
		return false
	else
		local f25_local0 = CoDShared.LootIndexInfoLookup( f25_arg1 )
		return f25_local0 and CoDShared.IsLootItemOwned( f25_arg0, f25_local0.itemId, f25_local0.bundles )
	end
end
f0_local0.IsLootItemOwnedSimple = function ( f26_arg0, f26_arg1, f26_arg2 )
	if Engine[@"getdvarbool"]( @"loot_fakeall" ) then
		return true
	elseif Engine[@"hash_5352DC095BBB2A45"]( f26_arg0, f26_arg1 ) > 0 then
		return true
	elseif CoDShared.IsLootItemDefaultUnlocked( f26_arg1 ) then
		return true
	elseif f26_arg2 then
		for f26_local3, f26_local4 in ipairs( f26_arg2 ) do
			local f26_local5, f26_local6 = CoDShared.IsLootItemOwnedByNameSimple( f26_arg0, f26_local4 )
			if f26_local5 and f26_local6 then
				return true
			end
		end
	end
	return false
end
f0_local0.GetLootItemCategory = function ( f27_arg0 )
	local f27_local0 = "gamedata/loot/loot_index.csv"
	local f27_local1 = "gamedata/loot/loot_index_2.csv"
	local f27_local2 = 1
	local f27_local3 = 6
	local f27_local4 = Engine[0x6ED59F41A5B1CC]( f27_local0, f27_local3, f27_local2, f27_arg0 )
	if not f27_local4 then
		f27_local4 = Engine[0x6ED59F41A5B1CC]( f27_local1, f27_local3, f27_local2, f27_arg0 )
	end
	return f27_local4
end
f0_local0.GetItemNameHashFromId = function ( f28_arg0, f28_arg1 )
	local f28_local0 = "gamedata/loot/loot_index.csv"
	local f28_local1 = "gamedata/loot/loot_index_2.csv"
	local f28_local2 = 0
	local f28_local3 = 1
	local f28_local4 = Engine[0x6ED59F41A5B1CC]( f28_local0, f28_local2, f28_local3, f28_arg1 )
	if not f28_local4 then
		f28_local4 = Engine[0x6ED59F41A5B1CC]( f28_local1, f28_local2, f28_local3, f28_arg1 )
	end
	return f28_local4
end
f0_local0.IsLootItemOwnedByNameSimple = function ( f29_arg0, f29_arg1 )
	local f29_local0 = "gamedata/loot/loot_index.csv"
	local f29_local1 = "gamedata/loot/loot_index_2.csv"
	local f29_local2 = 0
	local f29_local3 = 1
	local f29_local4 = 3
	local f29_local5 = f29_local0
	local f29_local6 = Engine[@"tablefindrows"]( f29_local0, f29_local2, f29_arg1 )
	if f29_local6 == nil or #f29_local6 == 0 then
		f29_local6 = Engine[@"tablefindrows"]( f29_local1, f29_local2, f29_arg1 )
		f29_local5 = f29_local1
		if f29_local6 == nil or #f29_local6 == 0 then
			return false, false
		end
	end
	local f29_local7 = f29_local6[1]
	return true, CoDShared.IsLootItemOwnedSimple( f29_arg0, Engine[@"hash_4C6F8EC444864600"]( f29_local5, f29_local7, f29_local3 ), Engine[@"hash_4C6F8EC444864600"]( f29_local5, f29_local7, f29_local4 ) )
end
f0_local0.IsNotLootItemOrIsOwnedById = function ( f30_arg0, f30_arg1 )
	if not f30_arg1 then
		return true
	end
	local f30_local0 = CoDShared.LootIndexInfoLookup( f30_arg1 )
	local f30_local1
	if f30_local0 then
		f30_local1 = CoDShared.IsLootItemOwned( f30_arg0, f30_local0.itemId, f30_local0.bundles )
	else
		f30_local1 = true
	end
	return f30_local1
end
f0_local0.IsInExperiment = function ( f31_arg0, f31_arg1 )
	return true
end
f0_local0.ForceOffline = function ()
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and LuaUtils.IsSkuOfflineOnly() then
		return true
	elseif LuaDefine.isPC and Dvar[@"live_connect_mode"]:get() == 0 and Dvar[@"nodw"]:get() == 1 then
		return true
	else
		return false
	end
end
f0_local0.IsCurrentTextLanguageEnglish = function ()
	if Dvar[@"loc_language"]:get() == Enum[@"language_t"][@"language_english"] then
		return true
	else
		return false
	end
end
f0_local0.IsMainFirstTimeSetup = function ( f34_arg0 )
	if f0_local0.IsInGame() then
		return false
	elseif f34_arg0 > 0 then
		return false
	elseif f0_local0.IsIntDvarNonZero( "ui_forceFirstTime" ) then
		Dvar[@"hash_67424F822EC880D2"]:set( 0 )
		Engine[@"setprofilevar"]( f34_arg0, @"com_first_time", "1" )
	end
	if Dvar[@"livestats_skipfirsttime"]:get() then
		return false
	end
	return Engine[@"getprofilevarint"]( f34_arg0, @"com_first_time" ) ~= 0
end
f0_local0.IsGameInstalled = function ()
	return not Engine[@"hash_77D47312EBA41751"]()
end
f0_local0.IsIntDvarNonZero = function ( f36_arg0 )
	if Engine[@"getdvarint"]( f36_arg0 ) ~= 0 then
		return true
	else
		return false
	end
end
f0_local0.IsInGame = function ()
	return Engine[@"isingame"]()
end
f0_local0.IsInTheaterLobby = function ()
	local f38_local0 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	if f38_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_theater"] then
		return true
	else
		return false
	end
end
f0_local0.IsTeamsMenu = function ()
	local f39_local0 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	local f39_local1
	if f39_local0 then
		f39_local1 = f39_local0[@"showteams"]
		if not f39_local1 then
		
		else
			return f39_local1
		end
	end
	f39_local1 = false
end
f0_local0.MenuControllingLobbyType = function ()
	local f40_local0 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	return f40_local0 and f40_local0[@"lobbytype"]
end
f0_local0.LoadoutWeapons = {
	primary = {
		keys = {
			"itemIndex",
			"camoIndex",
			"reticleIndex",
			"paintjobSlot",
			"weaponModelSlot",
			"charmIndex",
			"deathFxIndex"
		},
		arrays = {
			"attachment"
		}
	},
	secondary = {
		keys = {
			"itemIndex",
			"camoIndex",
			"reticleIndex",
			"paintjobSlot",
			"weaponModelSlot",
			"charmIndex",
			"deathFxIndex"
		},
		arrays = {
			"attachment"
		}
	}
}
f0_local0.LoadoutKillstreaks = {
	keys = {
		"killstreak1",
		"killstreak2",
		"killstreak3",
		"killstreak4"
	}
}
f0_local0.LoadoutSlotOrderZM = {
	keys = {
		"primarygrenade",
		"herogadget",
		"talisman1"
	},
	arrays = {
		"specialty"
	},
	structs = f0_local0.LoadoutWeapons
}
f0_local0.LoadoutSlotOrderMP = {
	keys = {
		"primarygrenade",
		"primarygrenadecount",
		"tacticalgear"
	},
	arrays = {
		"talent",
		"bonuscard"
	},
	structs = f0_local0.LoadoutWeapons
}
f0_local0.LoadoutSlotOrderCP = {
	keys = {
		"primarygrenade",
		"herogadget"
	},
	structs = f0_local0.LoadoutWeapons
}
f0_local0.LoadoutSlotOrder = {
	[Enum[@"emodes"][@"mode_zombies"]] = f0_local0.LoadoutSlotOrderZM,
	[Enum[@"emodes"][@"mode_multiplayer"]] = f0_local0.LoadoutSlotOrderMP,
	[Enum[@"emodes"][@"mode_campaign"]] = f0_local0.LoadoutSlotOrderCP,
	[Enum[@"emodes"][@"mode_warzone"]] = f0_local0.LoadoutSlotOrderMP
}
f0_local0.LoadoutPaintjobSlots = {
	structs = {
		primary = {
			keys = {
				"paintjobSlot"
			}
		},
		secondary = {
			keys = {
				"paintjobSlot"
			}
		}
	}
}
f0_local0.EmptyItemIndex = 0
f0_local0.DefaultSpecialistEquipment = @"default_specialist_equipment"
f0_local0.splitString = function ( f41_arg0, f41_arg1 )
	local f41_local0 = {}
	string.gsub( f41_arg0, "([^" .. f41_arg1 .. "]+)", function ( f42_arg0 )
		table.insert( f41_local0, f42_arg0 )
	end )
	return f41_local0
end
f0_local0.ClearAllLoadoutSlots = function ( f43_arg0, f43_arg1 )
	if f43_arg0 then
		LuaUtils.ClearDDLKeysAndArrays( f43_arg0, f0_local0.LoadoutSlotOrder[f43_arg1], f0_local0.EmptyItemIndex )
		LuaUtils.ClearDDLKeysAndArrays( f43_arg0, f0_local0.LoadoutPaintjobSlots, Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] )
	end
end
f0_local0.getAttachmentsList = function ( f44_arg0, f44_arg1, f44_arg2, f44_arg3 )
	local f44_local0 = f0_local0.splitString( f44_arg1[f44_arg2] or "", " " )
	local f44_local1 = {}
	for f44_local5, f44_local6 in ipairs( f44_local0 ) do
		local f44_local7 = Engine[@"getattachmentindexbyattachmenttableindex"]( f44_arg3, Engine[@"getattachmentindexbyref"]( f44_local6 ), f44_arg0 )
		if f0_local0.EmptyItemIndex < f44_local7 then
			f44_local1[#f44_local1 + 1] = f44_local7
		end
	end
	return f44_local1
end
f0_local0.getDefaultAttachmentList = function ( f45_arg0, f45_arg1, f45_arg2 )
	if f45_arg1 <= f0_local0.EmptyItemIndex or not f45_arg2 then
		return 
	end
	local f45_local0 = {}
	for f45_local4, f45_local5 in ipairs( f45_arg2 ) do
		local f45_local6 = Engine[@"getattachmentindexbyattachmenttableindex"]( f45_arg1, Engine[@"getattachmentindexbyref"]( f45_local5[@"attachment"] ), f45_arg0 )
		if f0_local0.EmptyItemIndex <= f45_local6 then
			f45_local0[#f45_local0 + 1] = f45_local6
		end
	end
	return f45_local0
end
f0_local0.updateSlotList = function ( f46_arg0, f46_arg1, f46_arg2, f46_arg3 )
	if not f46_arg1 or not f46_arg0 then
		return 
	end
	for f46_local3, f46_local4 in ipairs( f46_arg0 ) do
		f46_arg1[f46_local3 - 1]:set( f46_local4[f46_arg2] and Engine[@"hash_2D97229B24C685D5"]( f46_local4[f46_arg2], f46_arg3 ) or f0_local0.EmptyItemIndex )
	end
end
f0_local0.updateItemIndexFromLoadout = function ( f47_arg0, f47_arg1, f47_arg2, f47_arg3 )
	if not f47_arg1 then
		return 
	elseif not f47_arg0 or not Engine[@"getitemindexfromreference"]( f47_arg0, f47_arg2 ) then
		local f47_local0 = f0_local0.EmptyItemIndex
	end
	if f47_arg3 then
		local f47_local0 = Engine[@"hash_2D97229B24C685D5"]( f0_local0.DefaultSpecialistEquipment, f47_arg2 )
	end
	f47_arg1:set( f47_local0 )
	return f47_local0
end
f0_local0.updateItemIndexFromLoadoutHash = function ( f48_arg0, f48_arg1, f48_arg2, f48_arg3 )
	if not f48_arg1 then
		return 
	else
		local f48_local0
		if f48_arg0 then
			f48_local0 = Engine[@"hash_2D97229B24C685D5"]( f48_arg0, f48_arg2 )
			if not f48_local0 then
			
			else
				if f48_local0 <= CoDShared.EmptyItemIndex and f48_arg3 then
					f48_local0 = Engine[@"hash_2D97229B24C685D5"]( f0_local0.DefaultSpecialistEquipment, f48_arg2 )
				end
				f48_arg1:set( f48_local0 )
				return f48_local0
			end
		end
	end
	f48_local0 = f0_local0.EmptyItemIndex
end
f0_local0.SetDefaultLoadoutItems = function ( f49_arg0, f49_arg1, f49_arg2, f49_arg3 )
	local f49_local0 = CoDShared.EmptyItemIndex
	local f49_local1 = nil
	local f49_local2 = ""
	if f49_arg3 then
		f49_local1 = f49_arg3 + 1
		f49_local2 = "_" .. f49_local1
	end
	local f49_local3 = f49_arg0.primary
	local f49_local4 = f0_local0.getDefaultAttachmentList( f49_arg2, f0_local0.updateItemIndexFromLoadoutHash( f49_arg1[@"primary"], f49_local3.itemIndex, f49_arg2 ), f49_arg1.primaryattachments )
	if f49_local4 then
		for f49_local5 = 1, #f49_local3.attachment, 1 do
			local f49_local8 = f49_local4[f49_local5]
			if not f49_local8 then
				f49_local8 = f0_local0.EmptyItemIndex
			end
			f49_local3.attachment[f49_local5 - 1]:set( f49_local8 )
		end
	end
	local f49_local5 = f49_arg0.secondary
	f49_local0 = f0_local0.updateItemIndexFromLoadoutHash( f49_arg1[@"secondary"], f49_local5.itemIndex, f49_arg2 )
	f49_local5.itemIndex:set( f49_local0 )
	local f49_local6 = f0_local0.getDefaultAttachmentList( f49_arg2, f49_local0, f49_arg1.secondaryattachments )
	if f49_local6 then
		for f49_local7 = 1, #f49_local5.attachment, 1 do
			local f49_local10 = f49_local6[f49_local7]
			if not f49_local10 then
				f49_local10 = f0_local0.EmptyItemIndex
			end
			f49_local5.attachment[f49_local7 - 1]:set( f49_local10 )
		end
	end
	local f49_local7 = f0_local0.DefaultSpecialistEquipment
	local f49_local9 = f49_arg1[@"primarygrenade"]
	if f49_arg2 == Enum[@"emodes"][@"mode_zombies"] then
		f49_local7 = nil
		if f49_local1 > 1 then
			local f49_local8 = @"primarygrenade" .. f49_local2
			if f49_arg1[f49_local8] then
				f49_local9 = f49_arg1[f49_local8]
			end
		end
	end
	f0_local0.updateItemIndexFromLoadoutHash( f49_local9, f49_arg0.primarygrenade, f49_arg2, f49_local7 )
	if f49_arg2 == Enum[@"emodes"][@"mode_zombies"] then
		local f49_local8 = f49_arg1[@"herogadget"]
		if f49_local1 > 1 then
			local f49_local11 = @"herogadget" .. f49_local2
			if f49_arg1[f49_local11] then
				f49_local8 = f49_arg1[f49_local11]
			end
		end
		f0_local0.updateItemIndexFromLoadoutHash( f49_local8, f49_arg0.herogadget, f49_arg2 )
		local f49_local11 = f49_arg1[@"talisman1"]
		if f49_local1 > 1 then
			local f49_local10 = @"talisman1" .. f49_local2
			if f49_arg1[f49_local10] then
				f49_local11 = f49_arg1[f49_local10]
			end
		end
		f0_local0.updateItemIndexFromLoadoutHash( f49_local11, f49_arg0.talisman1, f49_arg2 )
		local f49_local10 = f49_arg1.specialties
		if f49_local1 > 1 then
			local f49_local12 = "specialties" .. f49_local2
			if f49_arg1[f49_local12] then
				f49_local10 = f49_arg1[f49_local12]
			end
		end
		f0_local0.updateSlotList( f49_local10, f49_arg0.specialty, @"specialty", f49_arg2 )
		local f49_local12 = f49_arg1[@"startweapon"]
		if f49_local1 > 1 then
			local f49_local13 = @"startweapon" .. f49_local2
			if f49_arg1[f49_local13] then
				f49_local12 = f49_arg1[f49_local13]
			end
		end
		f0_local0.updateItemIndexFromLoadoutHash( f49_local12, f49_local3.itemIndex, f49_arg2 )
	end
	if f49_arg2 == Enum[@"emodes"][@"mode_multiplayer"] then
		f0_local0.updateItemIndexFromLoadoutHash( f49_arg1[@"tacticalgear"], f49_arg0.tacticalgear, f49_arg2 )
		f0_local0.updateSlotList( f49_arg1.talents, f49_arg0.talent, @"talent", f49_arg2 )
		f0_local0.updateSlotList( f49_arg1.bonuscards, f49_arg0.bonuscard, @"bonuscard", f49_arg2 )
	end
end
f0_local0.SetDefaultBubbleGumBuffs = function ( f50_arg0, f50_arg1, f50_arg2, f50_arg3, f50_arg4 )
	local f50_local0 = f50_arg0.bubbleGumPack
	if not f50_local0 then
		return 
	end
	local f50_local1 = f50_local0[f50_arg1 - 1]
	if not f50_local1 then
		return 
	elseif f50_arg2 and f50_arg2.defaultcustomloadouts and f50_arg2.defaultcustomloadouts[f50_arg1] then
		local f50_local2 = f50_arg4 + 1
		local f50_local3 = "_" .. f50_local2
		local f50_local4 = f50_arg2.defaultcustomloadouts[f50_arg1]
		local f50_local5 = f50_local4.bubblegumbuffs
		if f50_local2 > 1 then
			local f50_local6 = "bubblegumbuffs" .. f50_local3
			if f50_local4[f50_local6] then
				f50_local5 = f50_local4[f50_local6]
			end
		end
		f0_local0.updateSlotList( f50_local5, f50_local1.bubbleGumBuff, @"bubblegumbuff", f50_arg3 )
	end
end
f0_local0.SetDefaultBubbleGumBuffsForClass = function ( f51_arg0, f51_arg1, f51_arg2, f51_arg3, f51_arg4, f51_arg5 )
	local f51_local0 = f51_arg0.bubbleGumPack
	if not f51_local0 then
		return 
	end
	local f51_local1 = f51_local0[f51_arg1 - 1]
	if not f51_local1 then
		return 
	elseif f51_arg3 and f51_arg3.defaultcustomloadouts and f51_arg3.defaultcustomloadouts[f51_arg2] then
		local f51_local2 = f51_arg5 + 1
		local f51_local3 = "_" .. f51_local2
		local f51_local4 = f51_arg3.defaultcustomloadouts[f51_arg2]
		local f51_local5 = f51_local4.bubblegumbuffs
		if f51_local2 > 1 then
			local f51_local6 = "bubblegumbuffs" .. f51_local3
			if f51_local4[f51_local6] then
				f51_local5 = f51_local4[f51_local6]
			end
		end
		f0_local0.updateSlotList( f51_local5, f51_local1.bubbleGumBuff, @"bubblegumbuff", f51_arg4 )
	end
end
f0_local0.SetDefaultGlobalLoadout = function ( f52_arg0, f52_arg1, f52_arg2 )
	LuaUtils.ClearDDLKeysAndArrays( f52_arg0, f0_local0.LoadoutKillstreaks, f0_local0.EmptyItemIndex )
	if f52_arg1 and f52_arg2 == Enum[@"emodes"][@"mode_multiplayer"] and f52_arg1.killstreaks then
		for f52_local3, f52_local4 in ipairs( f52_arg1.killstreaks ) do
			f0_local0.updateItemIndexFromLoadoutHash( f52_local4[@"killstreak"], f52_arg0["killstreak" .. f52_local3], f52_arg2 )
		end
	end
end
f0_local0.SetCustomDefaultLoadout = function ( f53_arg0, f53_arg1, f53_arg2, f53_arg3, f53_arg4 )
	local f53_local0 = f53_arg0.customclass
	if not f53_local0 then
		return 
	end
	local f53_local1 = f53_local0[f53_arg1 - 1]
	if not f53_local1 then
		return 
	end
	f0_local0.ClearAllLoadoutSlots( f53_local1, f53_arg3 )
	if f53_arg2 and f53_arg2.defaultcustomloadouts and f53_arg2.defaultcustomloadouts[f53_arg1] then
		local f53_local2 = f53_arg2.defaultcustomloadouts[f53_arg1]
		local f53_local3 = f53_arg1 - 1
		if f53_arg0.customClassName then
			f53_arg0.customClassName[f53_local3]:set( "" )
		end
		f0_local0.SetDefaultLoadoutItems( f53_local1, f53_local2, f53_arg3, f53_arg4 )
	end
end
f0_local0.SetDefaultLoadoutForClass = function ( f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4, f54_arg5 )
	local f54_local0 = f54_arg0.customclass
	if not f54_local0 then
		return 
	end
	local f54_local1 = f54_local0[f54_arg1 - 1]
	if not f54_local1 then
		return 
	end
	f0_local0.ClearAllLoadoutSlots( f54_local1, f54_arg4 )
	if f54_arg3 and f54_arg3.defaultcustomloadouts and f54_arg3.defaultcustomloadouts[f54_arg2] then
		local f54_local2 = f54_arg3.defaultcustomloadouts[f54_arg2]
		local f54_local3 = f54_arg1 - 1
		f0_local0.SetDefaultLoadoutItems( f54_local1, f54_local2, f54_arg4, f54_arg5 )
		f54_arg0.customClassName[f54_local3]:set( "" )
	end
end
f0_local0.SetDefaultLoadout = function ( f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4 )
	local f55_local0 = f55_arg0.customclass
	if not f55_local0 then
		return 
	end
	local f55_local1 = f55_local0[f55_arg1 - 1]
	if not f55_local1 then
		return 
	end
	f0_local0.ClearAllLoadoutSlots( f55_local1, f55_arg3 )
	local f55_local2 = f55_arg1 - Enum[@"loadoutclass_t"][@"default_class_first"]
	if f55_arg2 and f55_arg2.defaultloadouts and f55_arg2.defaultloadouts[f55_local2] then
		local f55_local3 = f55_arg2.defaultloadouts[f55_local2]
		local f55_local4 = f55_arg1 - 1
		if f55_arg0.customClassName then
			f55_arg0.customClassName[f55_local4]:set( "" )
		end
		f0_local0.SetDefaultLoadoutItems( f55_local1, f55_local3, f55_arg3, f55_arg4 )
	end
end
f0_local0.HasPlayedBlackout = function ( f56_arg0 )
	local f56_local0 = Engine[@"storagegetbuffer"]( f56_arg0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"] )
	if f56_local0 == nil then
		return false
	elseif f56_local0.PlayerStatsList.TIME_PLAYED_TOTAL.StatValue:get() > 0 then
		return true
	else
		return false
	end
end
f0_local0.IsERegEnabled = function ( f57_arg0 )
	if Engine[@"hash_5CB675CA7856DA25"]() then
		local f57_local0 = CoD.StoreUtility.GetExperimentModifier( f57_arg0, "forceEReg" )
		if f57_local0 and f57_local0 ~= nil and f57_local0 ~= "" and f57_local0 == "1" and not CoDShared.HasPlayedBlackout( f57_arg0 ) then
			return true
		elseif Dvar[@"hash_2A63EB34B74263E8"]:get() then
			return true
		end
	elseif Dvar[@"hash_38BC2986F499E427"]:get() then
		return true
	end
	return false
end
f0_local0.ClearLoadoutForClassIndex = function ( f58_arg0, f58_arg1, f58_arg2 )
	local f58_local0 = f58_arg0.customclass
	if not f58_local0 then
		return 
	end
	local f58_local1 = f58_local0[f58_arg1 - 1]
	if f58_local1 then
		f0_local0.ClearAllLoadoutSlots( f58_local1, f58_arg2 )
		if f58_arg2 == Enum[@"emodes"][@"mode_multiplayer"] then
			f0_local0.updateItemIndexFromLoadoutHash( nil, f58_local1.primarygrenade, f58_arg2, f0_local0.DefaultSpecialistEquipment )
		end
	end
end
f0_local0.GetDefaultLoadoutForCurrentMode = function ()
	local f59_local0 = Engine[@"currentsessionmode"]()
	if f59_local0 == Enum[@"emodes"][@"mode_campaign"] then
		return Engine[@"hash_2E00B2F29271C60B"]( @"cp_default_loadouts" )
	elseif f59_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		if LuaUtils.IsArenaMode() then
			return Engine[@"hash_2E00B2F29271C60B"]( @"mp_arena_default_loadouts" )
		else
			return Engine[@"hash_2E00B2F29271C60B"]( @"mp_default_loadouts" )
		end
	elseif f59_local0 == Enum[@"emodes"][@"mode_zombies"] then
		return Engine[@"hash_2E00B2F29271C60B"]( @"zm_default_loadouts" )
	elseif f59_local0 == Enum[@"emodes"][@"mode_warzone"] then
		return Engine[@"hash_2E00B2F29271C60B"]( @"wz_default_loadouts" )
	else
		
	end
end
f0_local0.SetCACRootToDefault = function ( f60_arg0 )
	local f60_local0 = f60_arg0.eMode
	local f60_local1 = f60_arg0.classDDLRoot
	local f60_local2 = Engine[@"hash_3091707D0144833"]()
	if f60_local1 then
		if f60_local0 == Enum[@"emodes"][@"mode_campaign"] then
			local f60_local3 = Engine[@"hash_2E00B2F29271C60B"]( @"cp_default_loadouts" )
			for f60_local4 = 1, #f60_local1.customclass, 1 do
				f0_local0.SetDefaultLoadout( f60_local1, f60_local4, f60_local3, f60_local0, nil )
			end
		elseif f60_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
			local f60_local3 = nil
			if f60_arg0.loadout ~= nil and f60_arg0.loadout ~= 0x0 then
				f60_local3 = Engine[@"hash_2E00B2F29271C60B"]( f60_arg0.loadout )
			else
				f60_local3 = Engine[@"hash_2E00B2F29271C60B"]( LuaUtils.IsArenaMode() and @"mp_arena_default_loadouts" or @"mp_default_loadouts" )
			end
			for f60_local4 = Enum[@"loadoutclass_t"][@"custom_class_first"] + 1, Enum[@"loadoutclass_t"][@"basic_custom_class_count"], 1 do
				f0_local0.SetCustomDefaultLoadout( f60_local1, f60_local4, f60_local3, f60_local0, nil )
			end
			if f60_local2 then
				for f60_local4 = Enum[@"loadoutclass_t"][@"default_class_first"] + 1, Enum[@"loadoutclass_t"][@"default_class_last"] + 1, 1 do
					f0_local0.SetDefaultLoadout( f60_local1, f60_local4, f60_local3, f60_local0, nil )
				end
			end
			CoDShared.SetDefaultGlobalLoadout( f60_local1, f60_local3, f60_local0 )
		elseif f60_local0 == Enum[@"emodes"][@"mode_zombies"] then
			local f60_local3 = Engine[@"hash_2E00B2F29271C60B"]( @"zm_default_loadouts" )
			local f60_local4 = Engine[@"hash_6BBE3328FE08B8C7"]()
			if f60_local2 then
				for f60_local5 = 1, #f60_local1.customclass, 1 do
					f0_local0.SetCustomDefaultLoadout( f60_local1, f60_local5, f60_local3, f60_local0, f60_local4 )
				end
			end
			for f60_local5 = 1, #f60_local1.bubbleGumPack, 1 do
				f0_local0.SetDefaultBubbleGumBuffs( f60_local1, f60_local5, f60_local3, f60_local0, f60_local4 )
			end
		end
	end
end
f0_local0.Loot = {}
f0_local0.Loot.CaseMarkerId = "599996"
f0_local0.Loot.ContractSlots = {}
f0_local0.Loot.ContractSlots.SLOT_1 = @"slot_1"
f0_local0.Loot.ContractSlots.SLOT_2 = @"slot_2"
f0_local0.Loot.MasterSeasonTable = 0xFE613834D811EC6
f0_local0.Loot.MasterContractTable = @"hash_69FA37692BF3254F"
f0_local0.Loot.MasterReservesTable = 0x42660E60408E67A
f0_local0.Loot.LastSeasonStartTime = "1569862800"
f0_local0.Loot.SEASON_INFO_NUMBER = @"season_number"
f0_local0.Loot.SEASON_INFO_MAX_TIERS = @"max_tiers"
f0_local0.Loot.SEASON_INFO_DROP_VERSIONS = @"hash_5612F26908E35700"
f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION = @"hash_530E13B4E29C0E4A"
f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON = @"hash_5ABCAB4113C3EBFD"
f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG = @"hash_BAC3D33F590FB73"
f0_local0.Loot.SEASON_INFO_TABLENAME = @"table_name"
f0_local0.Loot.Cases = {
	@"case"
}
f0_local0.Loot.Crates = {
	@"promo_no_dupe_crate",
	@"crate",
	@"no_dupe_crate",
	@"half_off_crate",
	@"half_off_no_dupe_crate"
}
f0_local0.Loot.SeasonParams = {
	[@"loot_season_1"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 1,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 200,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 1,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_1_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_1_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = @"hash_4627C92BE5FDCDD0"
	},
	[@"loot_season_2"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 2,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 100,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 3,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_2_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_2_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = @"hash_571B16584E35BB31"
	},
	[@"loot_season_3"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 3,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 100,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 5,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_3_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_3_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = @"hash_5D3EBD52E3A6338A"
	},
	[@"loot_season_4"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 4,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 50,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 6,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_4_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_4_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = @"hash_47A467206BBDFF3B"
	},
	[@"loot_season_5"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 5,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 50,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 8,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_5_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_5_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = @"hash_761D002E194284DC"
	},
	[@"loot_season_6"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 6,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 40,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8,9",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 9,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_6_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_6_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = @"hash_37424A3B6A94A7BD"
	},
	[@"loot_season_7"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 7,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 60,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8,9,10",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 10,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_7_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_7_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0xF0E131157E4FC6
	},
	[@"loot_season_8"] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 8,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 50,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8,9,10,11",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 11,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = @"loot_season_8_postseason",
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = @"loot_season_8_postseason_all_rng",
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = @"hash_23ABDE23DA74CF07"
	}
}
f0_local0.Loot.CaseCosts = {
	PROMOTIONAL_CASE = {
		season = 99,
		id = "500163"
	}
}
f0_local0.Loot.CrateCosts = {
	THREE_PACK_TOKEN = {
		season = 99,
		id = "500161"
	},
	PROMO_NO_DUPE_PACK = {
		season = 99,
		id = "500165"
	}
}
f0_local0.Loot.GetLootCaseOwnedCount = function ( f61_arg0 )
	local f61_local0 = 0
	for f61_local4, f61_local5 in pairs( f0_local0.Loot.CaseCosts ) do
		f61_local0 = f61_local0 + Engine[@"hash_5352DC095BBB2A45"]( f61_arg0, f61_local5.id )
	end
	return f61_local0
end
f0_local0.Loot.GetSeasonInfoParam = function ( f62_arg0, f62_arg1 )
	local f62_local0 = CoDShared.Loot.SeasonParams[f62_arg0]
	if f62_local0 then
		return f62_local0[f62_arg1]
	else
		return nil
	end
end
f0_local0.Loot.GetSeasonDropVersions = function ( f63_arg0 )
	local f63_local0 = CoDShared.Loot.GetSeasonInfoParam( f63_arg0, CoDShared.Loot.SEASON_INFO_DROP_VERSIONS )
	if f63_local0 == nil or f63_local0 == 0x0 then
		return ""
	end
	local f63_local1 = Dvar[@"hash_4A8A508EBA98A27E"]:get()
	if f63_local1 and f63_local1 ~= "" and CoDShared.Loot.GetSeasonInfoParam( f63_arg0, CoDShared.Loot.SEASON_INFO_HIGHEST_DROP_VERSION ) < tonumber( string.match( f63_local1, "%d+" ) ) then
		f63_local0 = f63_local0 .. "," .. f63_local1
	end
	return f63_local0
end
f0_local0.Loot.GetCurrentSeason = function ()
	local f64_local0 = Dvar[@"hash_7462D05D73A06ACE"]:get()
	if f64_local0 == nil or f64_local0 == "" then
		return 0x0
	else
		return Engine[@"converttoxhash"]( f64_local0 )
	end
end
f0_local0.Loot.GetNextSeason = function ()
	if Dvar[@"hash_7A74F344825B5618"] == nil then
		return 0x0
	else
		local f65_local0 = Dvar[@"hash_7A74F344825B5618"]:get()
		if f65_local0 == nil or f65_local0 == "" then
			return 0x0
		else
			return Engine[@"converttoxhash"]( f65_local0 )
		end
	end
end
f0_local0.Loot.GetCurrentEventContract = function ()
	local f66_local0 = Dvar[@"hash_3A7588CE8BBBC25D"]:get()
	if f66_local0 == nil or f66_local0 == "" then
		return 0x0
	else
		return Engine[@"converttoxhash"]( f66_local0 )
	end
end
f0_local0.Loot.GetContractTable = function ( f67_arg0 )
	return CoDShared.Loot.ContractTables[f67_arg0]
end
f0_local0.Loot.GetSeasonInfo = function ( f68_arg0 )
	local f68_local0 = {}
	local f68_local1 = CoDShared.Loot.MasterSeasonTable
	f68_local0.name = f68_arg0
	f68_local0.id = Engine[@"tablelookup"]( f68_local1, 0, 1, f68_arg0 )
	f68_local0.params = CoDShared.Loot.SeasonParams[f68_arg0]
	return f68_local0
end
f0_local0.Loot.GetContractInfo = function ( f69_arg0, f69_arg1 )
	local f69_local0 = {}
	local f69_local1 = CoDShared.Loot.MasterContractTable
	f69_local0.name = f69_arg1
	f69_local0.id = Engine[@"tablelookup"]( f69_local1, 0, 1, f69_arg1 )
	if f69_local0.id == nil then
		return nil
	else
		f69_local0.rarity = Engine[@"tablelookup"]( f69_local1, 2, 1, f69_arg1 )
		f69_local0.dropNumber = Engine[@"tablelookup"]( f69_local1, 3, 1, f69_arg1 )
		f69_local0.prt = Engine[@"tablelookup"]( f69_local1, 5, 1, f69_arg1 )
		f69_local0.outfit = Engine[@"tablelookup"]( f69_local1, 6, 1, f69_arg1 )
		f69_local0.tierProgress = Engine[@"hash_6159D7050715A2C3"]( f69_arg0, f69_arg1 )
		return f69_local0
	end
end
f0_local0.Loot.GetStreamName = function ( f70_arg0 )
	local f70_local0 = 0
	local f70_local1 = 1
	local f70_local2 = Engine[@"tablelookup"]( CoDShared.Loot.MasterSeasonTable, f70_local1, f70_local0, f70_arg0 )
	if f70_local2 == nil or f70_local2 == "" then
		f70_local2 = Engine[@"tablelookup"]( CoDShared.Loot.MasterContractTable, f70_local1, f70_local0, f70_arg0 )
	end
	return f70_local2
end
f0_local0.Loot.GetStreamId = function ( f71_arg0 )
	local f71_local0 = 0
	local f71_local1 = 1
	local f71_local2 = Engine[@"tablelookup"]( CoDShared.Loot.MasterSeasonTable, f71_local0, f71_local1, f71_arg0 )
	if f71_local2 == nil or f71_local2 == "" then
		f71_local2 = Engine[@"tablelookup"]( CoDShared.Loot.MasterContractTable, f71_local0, f71_local1, f71_arg0 )
	end
	return f71_local2
end
f0_local0.Loot.GetActiveContractIds = function ( f72_arg0 )
	local f72_local0 = {}
	if f72_arg0 == nil then
		return f72_local0
	end
	local f72_local1 = Engine[@"storagegetbuffer"]( f72_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"] )
	if f72_local1 == nil then
		return f72_local0
	end
	for f72_local7, f72_local8 in pairs( CoDShared.Loot.ContractSlots ) do
		if f72_local8 ~= nil then
			local f72_local5 = f72_local1[@"loot_contracts"][f72_local8]
			if f72_local5 ~= nil then
				local f72_local6 = f72_local5[@"contractid"]:get()
				if f72_local6 > 0 then
					table.insert( f72_local0, f72_local6 )
				end
			end
		end
	end
	return f72_local0
end
f0_local0.Loot.RNGPercentUnlocked = function ( f73_arg0, f73_arg1, f73_arg2 )
	local f73_local0 = CoDShared.Loot.GetSeasonInfoParam( f73_arg1, CoDShared.Loot.SEASON_INFO_HIGHEST_DROP_VERSION )
	if f73_arg1 == CoDShared.Loot.GetCurrentSeason() then
		local f73_local1 = Dvar[@"hash_4A8A508EBA98A27E"]:get()
		if f73_local1 and f73_local1 ~= "" and f73_local0 < tonumber( string.match( f73_local1, "%d+" ) ) then
			f73_local0 = tonumber( string.match( f73_local1, "%d+" ) )
		end
	end
	local f73_local1 = 0
	local f73_local2 = Engine[@"gettablerowcount"]( CoDShared.Loot.MasterReservesTable )
	local f73_local3 = 0
	for f73_local4 = 1, f73_local2, 1 do
		local f73_local7 = Engine[@"hash_4C6F8EC444864600"]( CoDShared.Loot.MasterReservesTable, f73_local4 - 1, 0 )
		local f73_local8 = Engine[@"hash_4C6F8EC444864600"]( CoDShared.Loot.MasterReservesTable, f73_local4 - 1, 9 )
		if f73_local8 and f73_local0 and f73_local8 <= f73_local0 then
			f73_local3 = f73_local3 + 1
			local f73_local9 = f73_local7 and Engine[@"hash_5352DC095BBB2A45"]( f73_arg0, f73_local7 ) > 0
			if not f73_local9 and f73_arg2 then
				return 0
			elseif f73_local9 then
				f73_local1 = f73_local1 + 1
			end
		end
	end
	if f73_arg2 then
		return 1
	end
	return f73_local1 / f73_local3
end
f0_local0.Loot.UpdateAllRNGUnlockedModel = function ( f74_arg0 )
	local f74_local0 = Engine[@"getmodelforcontroller"]( f74_arg0 )
	f74_local0 = f74_local0:create( "LootStreamProgress", true )
	if f74_local0 then
		local f74_local1 = not Dvar[@"hash_150FB25F071D6CBB"]:get()
		local f74_local2 = CoDShared.Loot.RNGPercentUnlocked( f74_arg0, CoDShared.Loot.GetCurrentSeason(), f74_local1 )
		if f74_local2 == 1 then
			local f74_local3 = f74_local0:create( "allRngUnlocked", true )
			f74_local3:set( true )
		else
			local f74_local3 = f74_local0:create( "allRngUnlocked", true )
			f74_local3:set( false )
		end
		if not f74_local1 then
			if f74_local2 < 0.01 and not f74_local2 == 0 then
				f74_local2 = 0.01
			end
			local f74_local3 = f74_local0:create( "reservesRngPercentage", true )
			f74_local3:set( f74_local2 )
		end
	end
end
f0_local0.Loot.GetWeaponPurchasedData = function ( f75_arg0, f75_arg1 )
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_multiplayer"] then
		if f75_arg1[@"hash_4953B2B12F1D6B1B"] == nil then
			return 
		end
		local f75_local0 = Engine[@"storagegetbuffer"]( f75_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"] )
		if f75_local0[@"ranked_item_stats"] then
			for f75_local17, f75_local18 in DDLUtils.pairs( f75_local0[@"ranked_item_stats"] ) do
				local f75_local19 = Engine[@"hash_68FF94BB44442412"]( f75_local17, Enum[@"emodes"][@"mode_multiplayer"] )
				if f75_arg1[@"hash_4953B2B12F1D6B1B"][f75_local17] and f75_arg1[@"hash_4953B2B12F1D6B1B"][f75_local17][0xAB8B7DF567CD2A] then
					local f75_local4 = Engine[@"getplayerstats"]( f75_arg0, Enum[@"statslocation"][@"stats_location_normal"], Enum[@"emodes"][@"mode_multiplayer"] )
					if f75_local4 then
						local f75_local5 = f75_local4.PlayerStatsList.RANK
						local f75_local6 = f75_local4.PlayerStatsList.RANK.StatValue:get()
					end
					local f75_local7 = (Engine[@"getitemunlocklevel"]( f75_local19, Enum[@"emodes"][@"mode_multiplayer"] ) or 0) <= (f75_local5 and f75_local6 or 0) or Engine[@"hash_1D876F030270CB95"]( f75_arg0, Enum[@"emodes"][@"mode_multiplayer"], f75_local17 )
					local f75_local8 = CoDShared.IsLootItemOwnedByName( f75_arg0, f75_local17 )
					if not f75_local8 then
						for f75_local14, f75_local15 in ipairs( Engine[@"hash_79F0BB7D52A7A978"]( f75_local17 ) ) do
							if f75_local15[@"lootid"] ~= 0x0 then
								local f75_local12, f75_local13 = CoDShared.IsLootItemOwnedByNameSimple( f75_arg0, f75_local15[@"lootid"] )
								if f75_local13 then
									f75_local8 = true
									break
								end
							end
						end
					end
					if f75_local8 ~= nil then
						local f75_local16 = f75_arg1[@"hash_4953B2B12F1D6B1B"][f75_local17][0xAB8B7DF567CD2A]
						local f75_local9 = f75_local16
						f75_local16 = f75_local16.set
						local f75_local10
						if f75_local8 then
							f75_local10 = 1
							if not f75_local10 then
							
							else
								f75_local16( f75_local9, f75_local10 )
								goto basicblock_26:
							end
						end
						f75_local10 = 0
					end
					local f75_local16 = f75_arg1[@"hash_4953B2B12F1D6B1B"][f75_local17][0xAB8B7DF567CD2A]
					local f75_local9 = f75_local16
					f75_local16 = f75_local16.set
					local f75_local10
					if f75_local7 then
						f75_local10 = 1
						if not f75_local10 then
						
						else
							f75_local16( f75_local9, f75_local10 )
						end
					end
					f75_local10 = 0
				end
			end
		end
	end
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		if f75_arg1[@"hash_4473319D8A8D9DCF"] == nil then
			return 
		elseif f75_arg1[@"hash_4473319D8A8D9DCF"] then
			for f75_local3, f75_local17 in DDLUtils.pairs( f75_arg1[@"hash_4473319D8A8D9DCF"] ) do
				local f75_local18 = Engine[@"hash_68FF94BB44442412"]( f75_local3, Enum[@"emodes"][@"mode_multiplayer"] )
				if f75_arg1[@"hash_4473319D8A8D9DCF"][f75_local3] then
					local f75_local19 = CoDShared.IsLootItemOwnedByName( f75_arg0, f75_local3 )
					if f75_local19 ~= nil then
						local f75_local4 = f75_arg1[@"hash_4473319D8A8D9DCF"][f75_local3]
						local f75_local20 = f75_local4
						f75_local4 = f75_local4.set
						local f75_local21
						if f75_local19 then
							f75_local21 = 1
							if not f75_local21 then
							
							else
								f75_local4( f75_local20, f75_local21 )
								goto basicblock_40:
							end
						end
						f75_local21 = 0
					end
					f75_arg1[@"hash_4473319D8A8D9DCF"][f75_local3]:set( 0 )
				end
			end
		end
	end
end
f0_local0.Loot.GetTierBoostItemTotal = function ( f76_arg0 )
	return Engine[@"hash_5352DC095BBB2A45"]( f76_arg0, Dvar[@"hash_E42EFF14E284E15"]:get() ) or 0
end
f0_local0.Loot.GetCurrentTierBoost = function ( f77_arg0 )
	if Engine[@"isdevelopmentbuild"]() then
		local f77_local0 = Dvar[0xE9B47B844CE9EC]:get()
		if f77_local0 > 0 then
			return f77_local0
		end
	end
	local f77_local1 = (Engine[@"hash_5352DC095BBB2A45"]( f77_arg0, Dvar[@"hash_E42EFF14E284E15"]:get() ) or 0) * Dvar[@"hash_5B23C92E3E72DF30"]:get()
	local f77_local2 = CoDShared.Loot.GetMaxTierBoost() or 0
	if f77_local2 < f77_local1 then
		return f77_local2
	end
	return f77_local1
end
f0_local0.Loot.GetMaxTierBoost = function ()
	return Dvar[0x997C814ED4B7ED]:get()
end
f0_local0.Loot.GetBOPassTierBoost = function ( f79_arg0 )
	if Engine[@"ownseasonpass"]( f79_arg0 ) and Dvar[@"hash_6A29EB7B0B47996C"]:exists() then
		return Dvar[@"hash_6A29EB7B0B47996C"]:get()
	else
		return 0
	end
end
f0_local0.Loot.GetBOPassPartyTierBoost = function ( f80_arg0 )
	if Engine[@"ownseasonpass"]( f80_arg0 ) then
		return 0
	end
	local f80_local0 = Engine[@"getlobbymainmode"]()
	local f80_local1 = Engine[@"getglobalmodel"]()
	f80_local1 = f80_local1.lobbyRoot
	if f80_local1 and f80_local1.lobbyMainMode then
		local f80_local2 = f80_local1.lobbyMainMode:get()
	end
	if CoDShared.GetLobbyDLCBits( f80_local2 or -1, Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"] ) & Enum[@"contentflagbits"][@"hash_739C6503528DB793"] > 0 and Dvar[@"hash_6362DEDC404612D0"]:exists() then
		return Dvar[@"hash_6362DEDC404612D0"]:get()
	end
	return 0
end
f0_local0.Loot.ClearRNGModels = function ( f81_arg0 )
	local f81_local0 = Engine[@"getmodelforcontroller"]( f81_arg0 )
	f81_local0 = f81_local0:create( "LootRNGResult" )
	local f81_local1 = f81_local0:create( "ready" )
	f81_local1:set( false )
	f81_local1 = f81_local0:create( "itemsEarned" )
	f81_local1:set( 0 )
	f81_local1 = f81_local0:create( "streamId" )
	f81_local1:set( "" )
	f81_local1 = f81_local0:create( "allBribeItemsOwned" )
	f81_local1:set( false )
	f81_local1 = f81_local0:create( "successfulExchange" )
	f81_local1:set( false )
	f81_local1 = f81_local0:create( "error_code" )
	f81_local1:set( "0" )
end
f0_local0.Loot.GetBribePayload = function ( f82_arg0, f82_arg1, f82_arg2 )
	local f82_local0 = CoDShared.Loot.GetSeasonDropVersions( CoDShared.Loot.GetCurrentSeason() )
	local f82_local1 = CoD.BlackMarketTableUtility.GetAdditionalDrop( f82_arg0, f82_arg2 )
	if f82_local1 and f82_local1 > 0 then
		f82_local0 = f82_local0 .. "," .. f82_local1
	end
	local f82_local2 = string.format( "{\"drop_versions\":[%s], \"active_streams\":[] }", f82_local0 )
	if f82_arg1 then
		local f82_local3 = "cost_currencies"
		if f82_arg1 ~= "20" then
			f82_local3 = "cost_items"
		end
		f82_local2 = string.format( "{\"drop_versions\":[%s], \"active_streams\":[], \"" .. f82_local3 .. "\": [%s]  }", f82_local0, f82_arg1 )
	end
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_loot"], "Bribe Payload: " .. f82_local2 .. "\n" )
	return f82_local2
end
f0_local0[@"hash_3562F4B21BD0FAB0"] = function ( f83_arg0, f83_arg1 )
	if Engine[@"isingame"]() then
		return 
	end
	local f83_local0 = Engine[@"storagegetbuffer"]( f83_arg0, Enum[@"storagefiletype"][@"storage_common_settings"] )
	local f83_local1, f83_local2 = nil
	if f83_local0 then
		if f83_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
			f83_local1 = f83_local0[@"hash_D17B4E10FA9C28C"]
			local f83_local3 = Engine[@"hash_3FC41172469DB251"]( f83_arg0 )
			if f83_local3 then
				f83_local2 = f83_local3[@"characters"]
			end
		elseif f83_arg1 == Enum[@"emodes"][@"mode_warzone"] then
			f83_local1 = f83_local0.wzCharacters
			local f83_local3 = Engine[@"hash_3FC41172469DB251"]( f83_arg0 )
			if f83_local3 then
				f83_local2 = f83_local3[@"characters"]
			end
		elseif f83_arg1 == Enum[@"emodes"][@"mode_zombies"] then
			f83_local1 = f83_local0.zmCharacters
			local f83_local3 = Engine[@"hash_3FC41172469DB251"]( f83_arg0 )
			if f83_local3 then
				f83_local2 = f83_local3[@"characters"]
			end
		end
	end
	if f83_local1 and f83_local2 then
		for f83_local13, f83_local14 in DDLUtils.ipairs( f83_local2 ) do
			local f83_local15 = f83_local1[f83_local13]
			local f83_local16 = f83_local14[@"selectedoutfit"]:get()
			f83_local15[@"outfitindex"]:set( f83_local16 )
			local f83_local17 = f83_local14[@"hash_4D9FCEAC8FF24CBD"]:get()
			f83_local15[@"warpaintoutfitindex"]:set( f83_local17 )
			local f83_local18 = f83_local14[@"hash_E5C77948998E49"][f83_local16]
			local f83_local19 = f83_local14[@"hash_E5C77948998E49"][f83_local17]
			for f83_local6, f83_local7 in DDLUtils.pairs( f83_local18[@"hash_212BCDFA518CC913"] ) do
				if f83_local6 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
					f83_local15[@"outfititems"][f83_local6]:set( f83_local19[f83_local6]:get() )
				else
					f83_local15[@"outfititems"][f83_local6]:set( f83_local7:get() )
				end
			end
			if f83_arg1 == Enum[@"emodes"][@"mode_warzone"] then
				if Engine[@"storagegetbuffer"]( f83_arg0, Enum[@"storagefiletype"][@"storage_wz_stats_online"] ) and Engine[@"storagegetbuffer"]( f83_arg0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"] ) then
					f83_local8 = Engine[@"getherolist"]( Enum[@"emodes"][@"mode_warzone"] )
					f83_local6 = true
					for f83_local11, f83_local12 in ipairs( f83_local8 ) do
						if f83_local12.bodyIndex == f83_local13 then
							f83_local6 = not LuaUtils.IsRoleUnlocked( f83_arg0, f83_arg1, f83_local13 )
							break
						end
					end
					f83_local7 = f83_local15[@"locked"]
					f83_local9 = f83_local7
					f83_local7 = f83_local7.set
					if f83_local6 then
						f83_local10 = 1
						if not f83_local10 then
						
						else
							f83_local7( f83_local9, f83_local10 )
							goto basicblock_35:
						end
					end
					f83_local10 = 0
				end
			end
			f83_local15[@"locked"]:set( 0 )
		end
		Engine[@"storagewrite"]( f83_arg0, Enum[@"storagefiletype"][@"storage_common_settings"] )
	end
end
f0_local0.IsBitSet = function ( f84_arg0, f84_arg1 )
	return f84_arg0 & 1 << f84_arg1 > 0
end
f0_local0.NextReportTime = 0
f0_local0.ReportUser = function ( f85_arg0, f85_arg1, f85_arg2, f85_arg3, f85_arg4, f85_arg5 )
	if f85_arg4 then
		if Engine[@"milliseconds"]() < f0_local0.NextReportTime then
			return 
		end
		f0_local0.NextReportTime = Engine[@"milliseconds"]() + Dvar[@"hash_59946E2F81FCDB18"]:get() * 1000
	end
	local f85_local0 = ""
	local f85_local1 = LuaDefine.ZERO_X64
	if f85_arg2 == "offensive_emblem" then
		f85_local0, f85_local1 = Engine[@"hash_1544B06417DB16AA"]( f85_arg1 )
	end
	if f85_arg5 == nil then
		f85_arg5 = ""
	end
	Engine[0xDE279ECDDDD966]( f85_arg0, @"hash_FCCC6EEEAF0939B", {
		[@"xuid"] = f85_arg1,
		[@"offense"] = f85_arg2,
		[@"penalty"] = f85_arg3,
		[@"match_id"] = Engine[@"hash_6D52E2360F482280"](),
		[@"filename"] = f85_local0,
		[@"object_id"] = f85_local1,
		[@"message"] = f85_arg5
	} )
end
f0_local0.IsMapFree = function ( f86_arg0, f86_arg1, f86_arg2 )
	local f86_local0 = LobbyData.GetLobbyMenuByID( f86_arg1 )
	if f86_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_public"] then
		local f86_local1 = Engine[@"getplaylistinfobyid"]( f86_arg2 )
		for f86_local5, f86_local6 in ipairs( f86_local1.rotationList ) do
			if f86_local6.map == f86_arg0 then
				return f86_local6.isFree
			end
		end
	end
end
f0_local0.GetLobbyDLCBits = function ( f87_arg0, f87_arg1, f87_arg2 )
	if Dvar[@"hash_632261E3333DC0E9"]:exists() and Dvar[@"hash_632261E3333DC0E9"]:get() and (f87_arg0 == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] or f87_arg0 == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"]) then
		return Engine[@"hash_5B892CC772EEDA44"]( f87_arg1, f87_arg2 )
	else
		return Engine[@"getdlcbits"]()
	end
end
f0_local0.LootContracts = {}
f0_local0.LootContracts.LootContractsTable = @"hash_7222A2B349A0591D"
f0_local0.LootContracts.MaxActiveContracts = 2
f0_local0.LootContracts.MaxDailyContracts = 1
f0_local0.LootContracts.ContractGameMode = {
	LOOT_CONTRACT_GAME_MODE_INVALID = 0,
	LOOT_CONTRACT_GAME_MODE_MP = 1,
	LOOT_CONTRACT_GAME_MODE_WL = 2,
	LOOT_CONTRACT_GAME_MODE_ZM = 3,
	LOOT_CONTRACT_GAME_MODE_WZ = 4,
	LOOT_CONTRACT_GAME_MODE_GLOBAL = 5
}
f0_local0.LootContracts.StateFlags = {
	LOOT_CONTRACT_DAILY_TIER_SKIP_EARNED = 0,
	LOOT_CONTRACT_ZM_TIER_SKIP_EARNED = 1
}
f0_local0.LootContracts.GetContractsNameHash = function ( f88_arg0 )
	local f88_local0 = Engine[@"tablelookup"]( f0_local0.LootContracts.LootContractsTable, 1, 0, f88_arg0 )
	if f88_local0 ~= nil then
		return f88_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.GetContractsCategoryHash = function ( f89_arg0 )
	local f89_local0 = Engine[@"tablelookup"]( f0_local0.LootContracts.LootContractsTable, 2, 0, f89_arg0 )
	if f89_local0 ~= nil then
		return f89_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.GetContractsProgressTarget = function ( f90_arg0, f90_arg1 )
	return Engine[@"hash_444636E6D3F19799"]( f90_arg0, f90_arg1 )
end
f0_local0.LootContracts.GetContractsDifficulty = function ( f91_arg0 )
	local f91_local0 = Engine[@"tablelookup"]( f0_local0.LootContracts.LootContractsTable, 4, 0, f91_arg0 )
	if f91_local0 ~= nil then
		return f91_local0
	else
		return 0
	end
end
f0_local0.LootContracts.GetContractsGameMode = function ( f92_arg0 )
	local f92_local0 = Engine[@"tablelookup"]( f0_local0.LootContracts.LootContractsTable, 5, 0, f92_arg0 )
	if f92_local0 ~= nil then
		return f92_local0
	else
		return Enum[@"hash_41B899F51A938E95"][@"hash_28291997DE05302D"]
	end
end
f0_local0.LootContracts.GetContractTitle = function ( f93_arg0 )
	local f93_local0 = Engine[@"tablelookup"]( f0_local0.LootContracts.LootContractsTable, 6, 0, f93_arg0 )
	if f93_local0 ~= nil then
		return f93_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.GetContractDescription = function ( f94_arg0 )
	local f94_local0 = Engine[@"tablelookup"]( f0_local0.LootContracts.LootContractsTable, 7, 0, f94_arg0 )
	if f94_local0 ~= nil then
		return f94_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.IsLootContractTableValid = function ( f95_arg0 )
	local f95_local0 = Engine[@"getcurrentutctimestr"]()
	local f95_local1 = f95_arg0
	local f95_local2
	if f95_arg0.dailyExpiration > 0 and not Engine[@"isgreaterthan"]( tostring( f95_arg0.dailyExpiration ), f95_local0 ) and f95_arg0.availableExpiration > 0 then
		f95_local2 = not Engine[@"isgreaterthan"]( tostring( f95_arg0.availableExpiration ), f95_local0 )
	else
		f95_local2 = false
	end
	return f95_local2
end
f0_local0.LootContracts.ShouldAddActiveContract = function ( f96_arg0, f96_arg1, f96_arg2 )
	local f96_local0 = f0_local0.IsBitSet( f96_arg0.flags, Enum[@"hash_B40A0B507A68068"][@"hash_6F7D0F1F6F551B94"] )
	if f96_local0 then
		if not f0_local0.IsBitSet( f96_arg0.flags, Enum[@"hash_B40A0B507A68068"][@"hash_F26C5D1872ABE11"] ) then
			f96_local0 = Dvar.lootContracts_forceReady:get()
			if f96_local0 then
			
			else
				return f96_local0
			end
		end
		f96_local0 = f96_arg1 < f96_arg2
	end
	return f96_local0
end
f0_local0.LootContracts.AddActiveContract = function ( f97_arg0, f97_arg1, f97_arg2 )
	f97_arg0.loot_contracts[f97_arg2].contractID:set( f97_arg1.id )
	f97_arg0.loot_contracts[f97_arg2].contractHash:set( f0_local0.LootContracts.GetContractsNameHash( f97_arg1.id ) )
	f97_arg0.loot_contracts[f97_arg2].target:set( f97_arg1.target )
	f97_arg0.loot_contracts[f97_arg2].contractGameMode:set( f0_local0.LootContracts.GetContractsGameMode( f97_arg1.id ) )
	f97_arg0.loot_contracts[f97_arg2].progress:set( f97_arg1.progress )
	f97_arg0.loot_contracts[f97_arg2].xp:set( f97_arg1.xpAmount )
end
f0_local0.LootContracts.GetCurrentContractGameMode = function ()
	local f98_local0 = Engine[@"currentsessionmode"]()
	if f98_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		if LuaUtils.IsArenaMode() then
			return Enum[@"hash_41B899F51A938E95"][@"hash_6EFB62D162F33EC5"]
		else
			return Enum[@"hash_41B899F51A938E95"][@"hash_6F1D72D16310405B"]
		end
	elseif f98_local0 == Enum[@"emodes"][@"mode_zombies"] then
		return Enum[@"hash_41B899F51A938E95"][@"hash_6EEA5DD162E4C313"]
	elseif f98_local0 == Enum[@"emodes"][@"mode_warzone"] then
		return Enum[@"hash_41B899F51A938E95"][@"hash_6EFB6CD162F34FC3"]
	else
		return Enum[@"hash_41B899F51A938E95"][@"hash_28291997DE05302D"]
	end
end
f0_local0.LootContracts.IsEnabled = function ( f99_arg0 )
	return Dvar[@"hash_333765862CEF96C0"]:get() and not Engine[@"hash_5CB675CA7856DA25"]()
end
f0_local0.LootContracts.GetActiveContracts = function ( f100_arg0, f100_arg1 )
	if f0_local0.LootContracts.IsEnabled( f100_arg0 ) then
		local f100_local0 = math.min( #f100_arg1.loot_contracts, f0_local0.LootContracts.MaxActiveContracts + f0_local0.LootContracts.MaxDailyContracts )
		for f100_local1 = 0, f100_local0 - 1, 1 do
			f100_arg1.loot_contracts[f100_local1].contractID:set( 0 )
			f100_arg1.loot_contracts[f100_local1].contractHash:set( LuaDefine.ZERO_X64 )
			f100_arg1.loot_contracts[f100_local1].progress:set( LuaDefine.ZERO_X64 )
			f100_arg1.loot_contracts[f100_local1].target:set( LuaDefine.ZERO_X64 )
			f100_arg1.loot_contracts[f100_local1].contractGameMode:set( f0_local0.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_INVALID )
		end
		local f100_local1 = f0_local0.LootContracts.GetCurrentContractGameMode()
		if f100_local1 ~= Enum[@"hash_41B899F51A938E95"][@"hash_28291997DE05302D"] then
			local f100_local2 = Engine[@"hash_1DC39182CB1C9BE4"]( f100_arg0, f100_local1 )
			if f0_local0.LootContracts.IsLootContractTableValid( f100_local2 ) then
				local f100_local3 = 0
				for f100_local7, f100_local8 in ipairs( f100_local2.pinnedContracts ) do
					if f0_local0.LootContracts.ShouldAddActiveContract( f100_local8, f100_local3, f100_local0 ) then
						f0_local0.LootContracts.AddActiveContract( f100_arg1, f100_local8, f100_local3 )
						f100_local3 = f100_local3 + 1
					end
				end
				for f100_local7, f100_local8 in ipairs( f100_local2.dailyContracts ) do
					if f0_local0.LootContracts.ShouldAddActiveContract( f100_local8, f100_local3, f100_local0 ) then
						f0_local0.LootContracts.AddActiveContract( f100_arg1, f100_local8, f100_local3 )
						f100_local3 = f100_local3 + 1
					end
				end
			end
		end
	end
end
f0_local0.Playlists = {}
f0_local0.Playlists.GetShowcased = function ( f101_arg0 )
	local f101_local0 = nil
	if f101_arg0 == Enum[@"emodes"][@"mode_multiplayer"] then
		f101_local0 = Dvar[@"hash_7A659C21568D7219"]:get()
	elseif f101_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		f101_local0 = Dvar[@"hash_7AAD972156CB1F3D"]:get()
	elseif f101_arg0 == Enum[@"emodes"][@"mode_warzone"] then
		f101_local0 = Dvar[@"hash_7ABEA22156D9A521"]:get()
	end
	if f101_local0 ~= nil and f101_local0 ~= "" then
		return Engine[@"converttoxhash"]( f101_local0 )
	else
		return 0x0
	end
end
f0_local0.Playlists.GetLowpopShowcased = function ( f102_arg0 )
	local f102_local0 = nil
	if f102_arg0 == Enum[@"emodes"][@"mode_multiplayer"] then
		f102_local0 = Dvar[@"hash_49D9F4F1877E2CC3"]:get()
	elseif f102_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		f102_local0 = Dvar[@"hash_49A6EFF18752CAAB"]:get()
	elseif f102_arg0 == Enum[@"emodes"][@"mode_warzone"] then
		f102_local0 = Dvar[@"hash_4981FEF18733C7EB"]:get()
	end
	if f102_local0 ~= nil and f102_local0 ~= "" then
		return Engine[@"converttoxhash"]( f102_local0 )
	else
		return 0x0
	end
end
f0_local0.Playlists.GetFeaturedInternal = function ( f103_arg0 )
	local f103_local0 = {}
	if f103_arg0 ~= nil and f103_arg0 ~= "" then
		for f103_local4 in string.gmatch( f103_arg0, "[^%s;]+" ) do
			if f103_local4 and f103_local4 ~= "" then
				table.insert( f103_local0, Engine[@"converttoxhash"]( f103_local4 ) )
			end
		end
	end
	return f103_local0
end
f0_local0.Playlists.GetFeatured = function ( f104_arg0 )
	local f104_local0 = nil
	if f104_arg0 == Enum[@"emodes"][@"mode_multiplayer"] then
		f104_local0 = Dvar[@"hash_3CAE66D461D6B5D1"]:get()
	elseif f104_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		f104_local0 = Dvar[@"hash_3C8851D461B5C2E5"]:get()
	elseif f104_arg0 == Enum[@"emodes"][@"mode_warzone"] then
		f104_local0 = Dvar[@"hash_3C635CD46196B959"]:get()
	end
	return CoDShared.Playlists.GetFeaturedInternal( f104_local0 )
end
f0_local0.Playlists.GetLowpopFeatured = function ( f105_arg0 )
	local f105_local0 = nil
	if f105_arg0 == Enum[@"emodes"][@"mode_multiplayer"] then
		f105_local0 = Dvar[@"hash_C29714B70182EB3"]:get()
	elseif f105_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		f105_local0 = Dvar[@"hash_C638C4B7049D4DB"]:get()
	elseif f105_arg0 == Enum[@"emodes"][@"mode_warzone"] then
		f105_local0 = Dvar[@"hash_C3E7B4B702A9BBB"]:get()
	end
	return CoDShared.Playlists.GetFeaturedInternal( f105_local0 )
end
f0_local0.Playlists.IsBlacklistedInternal = function ( f106_arg0, f106_arg1 )
	if f106_arg1 ~= nil and f106_arg1 ~= "" then
		for f106_local3 in string.gmatch( f106_arg1, "[^%s;]+" ) do
			if f106_local3 and f106_local3 ~= "" and f106_arg0 == Engine[@"converttoxhash"]( f106_local3 ) then
				return true
			end
		end
	end
	return false
end
f0_local0.Playlists.IsBlacklisted = function ( f107_arg0 )
	return CoDShared.Playlists.IsBlacklistedInternal( f107_arg0, Dvar[0x27BDF887A5A587]:get() )
end
f0_local0.Playlists.IsLowpopBlacklisted = function ( f108_arg0 )
	return CoDShared.Playlists.IsBlacklistedInternal( f108_arg0, Dvar[@"hash_1F9B69E79C09279D"]:get() )
end
CoDShared = LuaReadOnlyTables.ReadOnlyTable( f0_local0 )
