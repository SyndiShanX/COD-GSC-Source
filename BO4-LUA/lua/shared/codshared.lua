
require( "x64:c71b3cf9012e5dd" )
local f0_local0 = {
	GetXUID64StringForController = function ( f1_arg0 )
		return Engine[0x5065E759595C457]( Engine[0x93B19E01B1FD1C7]( f1_arg0 ) )
	end
}
local f0_local1, f0_local2 = nil
f0_local0.IsGametypeTeamBased = function ( f2_arg0 )
	if not f2_arg0 then
		f2_arg0 = Engine[0x69811927938FCD7]()
	end
	if f2_arg0 == f0_local1 then
		return f0_local2
	else
		local f2_local0 = Engine[0xEA74FA7EE46E195]( f2_arg0 )
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
	local f3_local0 = Engine[0x1E32FEF495242B8]()
	return f3_local0 and f3_local0[0x75B6643FCFEB8CA]:get() or 0
end
f0_local0.IsGametypeHidingHudScore = function ( f4_arg0 )
	if not f4_arg0 then
		f4_arg0 = Engine[0x69811927938FCD7]()
	end
	local f4_local0 = Engine[0xEA74FA7EE46E195]( f4_arg0 )
	local f4_local1 = f4_local0.hideHudScore
	if f4_local1 == nil then
		return false
	else
		return f4_local1
	end
end
f0_local0.IsHardcoreGametypeAvailable = function ( f5_arg0 )
	if not f5_arg0 then
		f5_arg0 = Engine[0x69811927938FCD7]()
	end
	local f5_local0 = Engine[0xEA74FA7EE46E195]( f5_arg0 )
	local f5_local1 = f5_local0.isHardcoreAvailable
	if f5_local1 == nil then
		return false
	else
		return f5_local1
	end
end
f0_local0.ChunkAllDownloading = function ()
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and Engine[0x7D47312EBA41751]() then
		return true
	else
		return false
	end
end
f0_local0.ChunkAnyDownloading = function ()
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and Engine[0x7D47312EBA41751]() then
		return true
	else
		return false
	end
end
f0_local0.IsTeamBasedGame = function ()
	if Engine[0xE39F1F30B306065]() then
		return Engine[0xDBC2AD5002B261B]( 0xDA4FB58A54E84D3 ) > 1
	elseif Engine[0x7B48C1ABFF0F764]() then
		return CoDShared.IsGametypeTeamBased()
	else
		return CoDShared.IsGametypeTeamBased( Engine[0x6F8027A8BC75673]() )
	end
end
f0_local0.IsLobbyMode = function ( f9_arg0 )
	local f9_local0 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
	return f9_local0[0x8409AA0F01B5DBC] == f9_arg0
end
f0_local0.IsOnlineGame = function ()
	if Engine[0xE89628E21B49660]() then
		return true
	else
		return false
	end
end
f0_local0.IsRankedGame = function ()
	local f11_local0
	if f0_local0.IsOnlineGame() == true and not Engine[0x994291BF56E485B]( Enum[0xF7AE5746E79F2CE][0x5E90ACB801E4A3D] ) then
		f11_local0 = not Engine[0x994291BF56E485B]( Enum[0xF7AE5746E79F2CE][0x7B5630CD29180CB] )
	else
		f11_local0 = false
	end
	return f11_local0
end
f0_local0.IsHost = function ()
	return Engine[0x9E5BE3B4BBA4E0E]( "com_sv_running" )
end
f0_local0.GetTeamDifference = function ( f13_arg0 )
	if f13_arg0 ~= Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] and f13_arg0 ~= Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		return 0
	end
	local f13_local0 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] )
	local f13_local1 = f13_local0.sessionClients
	local f13_local2 = 0
	local f13_local3 = 0
	for f13_local7, f13_local8 in ipairs( f13_local1 ) do
		if f13_local8.team == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f13_local2 = f13_local2 + 1
		end
		if f13_local8.team == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f13_local3 = f13_local3 + 1
		end
	end
	if f13_arg0 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		return f13_local2 - f13_local3
	end
	return f13_local3 - f13_local2
end
f0_local0.IsTeamOverwhelmed = function ( f14_arg0 )
	local f14_local0 = Engine[0x20826BD382E3A23]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] ), Engine[0x93B19E01B1FD1C7]( f14_arg0 ) )
	local f14_local1 = Dvar[0x70F0BEC873AC2D3]:get() * -1
	if f14_local1 == 0 or f14_local1 < f0_local0.GetTeamDifference( f14_local0 ) then
		return false
	else
		return true
	end
end
f0_local0.QuitGame = function ( f15_arg0, f15_arg1 )
	if Engine[0x95D8A0296E9E574]() then
		return true
	end
	local f15_local0 = Engine[0x44FC97037CE42ED]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F] )
	local f15_local1 = Engine[0x44FC97037CE42ED]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x8A42AF1547AB4DF] )
	local f15_local2 = Engine[0xA33D06620AC0D6B]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] )
	if f15_local2 ~= nil then
		if nil ~= LobbyVM then
			Lobby.Events.EventDispatcher( "OnMatchmakingPriorityQuit", {
				hostSecId = f15_local2.secIdint
			} )
		else
			Engine[0x87AE7E64BA5AD61]( "OnMatchmakingPriorityQuit", {
				hostSecId = f15_local2.secIdint
			} )
		end
	end
	if f0_local0.IsLobbyMode( Enum[0x8409AA0F01B5DBC][0x8B3B066EFD7CD01] ) == true then
		if not Engine[0xEA2BE00F49480D]( Enum[0xBF54BE1BB3D618B][0xA1647599284110] ) then
			Engine[0x17DCA54F4444D11]()
			Engine[0xD4AB56BD02E8D41]()
			Engine[0x7C75E608EA39B5C]( f15_arg0, "disconnect" )
		else
			Engine[0x7C75E608EA39B5C]( f15_arg0, "xpartystopdemo" )
		end
		return true
	end
	local f15_local3 = Engine[0x8DF2E5447F384B9]()
	f15_local3 = f15_local3:create( "lobbyRoot.quitGameFlag", true )
	f15_local3:set( LuaEnum.QUIT_FLAG.MARK_AS_QUIT )
	if not f0_local0.IsHost() then
		if f15_arg1 then
			Engine[0xFCB995D7AE4D31B]( f15_arg0, false )
		else
			Engine[0xF76C2AD29F38701]( f15_arg0, false )
		end
		Engine[0x7C75E608EA39B5C]( f15_arg0, "disconnect" )
	elseif not f0_local0.IsRankedGame() then
		Engine[0xC554A8C36EF7EFF]( f15_arg0, "popup_leavegame", "endround", 0 )
	elseif f0_local0.IsRankedGame() and f0_local0.IsHost() and not Engine[0x19A84D7DD6DC193]() and Engine[0x22EAAB59AA27E9B]( "g_gameEnded" ) ~= 1 then
		Engine[0xF76C2AD29F38701]( f15_arg0, true )
		local f15_local4 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
		local f15_local5 = f15_local4[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE )
		local f15_local6 = 2
		if Enum[0x7F032C2EF103A1A] and Engine[0xDD333420C49E6D0]( f15_arg0, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD] ) then
			f15_local6 = 1
		end
		local f15_local7 = Engine[0x22EAAB59AA27E9B]( "sv_enableZombiesHostMigration" )
		if f15_local7 == 2 then
			f15_local5 = false
		end
		if (not (not Engine[0x32ABAFDCA93FDF9]() and (not Engine[0x8EF5BEFA0AE50FE]() or f15_local7 == 0 or f15_local5 ~= false or f15_local6 > f15_local0 - Engine[0xD1E13D329F1C745]( f15_arg0 ))) or f0_local0.IsGameTypeDOA()) and f15_local0 >= Dvar[0x58BFAAB543C1D66]:get() and f15_local0 ~= f15_local1 then
			Engine[0x7C75E608EA39B5C]( f15_arg0, "hostmigration_start" )
			return false
		end
		Engine[0xC554A8C36EF7EFF]( f15_arg0, "popup_leavegame", "endround", 0 )
	end
	return true
end
f0_local0.UpdateQuitFlag = function ()
	local f16_local0 = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "lobbyRoot.quitGameFlag" )
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
	if Engine[0x69811927938FCD7]() ~= "doa" and (Engine[0xB87231BF773995E]() == nil or Engine[0xB87231BF773995E]() ~= "cp_doa_bo3") then
		f17_local0 = LuaUtils.IsDOATarget( Engine[0x9882F293C327557]() )
	else
		f17_local0 = true
	end
	return f17_local0
end
f0_local0.IsLootHero = function ( f18_arg0 )
	if f18_arg0 ~= nil and f18_arg0.assetName ~= nil and f18_arg0.assetName == 0x6F37765CB5B1F2F then
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
	local f19_local4 = Engine[0x2DCF0973239E909]( f19_local0, f19_local1, f19_local2, f19_arg0 )
	if not f19_local4 and LuaDefine.isPC and Engine[0xE78C83C300F9368]() and Engine[0xA8FBC7AC4C3F3A6]() then
		f19_local4 = Engine[0x2DCF0973239E909]( f19_local0, f19_local1, f19_local3, f19_arg0 )
	end
	return f19_local4
end
f0_local0.GetSetBonusCallingCardIdFromImage = function ( f20_arg0 )
	local f20_local0 = "gamedata/emblems/backgrounds.csv"
	local f20_local1 = 1
	local f20_local2 = 15
	local f20_local3 = 19
	local f20_local4 = Engine[0x2DCF0973239E909]( f20_local0, f20_local1, f20_local2, f20_arg0 )
	if not f20_local4 and LuaDefine.isPC and Engine[0xE78C83C300F9368]() and Engine[0xA8FBC7AC4C3F3A6]() then
		f20_local4 = Engine[0x2DCF0973239E909]( f20_local0, f20_local1, f20_local3, f20_arg0 )
	end
	return f20_local4
end
f0_local0.GetEmblemIdFromImage = function ( f21_arg0 )
	return Engine[0x2DCF0973239E909]( "gamedata/emblems/emblemIcons.csv", 1, 3, f21_arg0 )
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
	local f22_local10 = Engine[0x910CBCCD3C164C9]( f22_local0, f22_local2, f22_arg0 )
	if f22_local10 == nil or #f22_local10 == 0 then
		f22_local10 = Engine[0x910CBCCD3C164C9]( f22_local1, f22_local2, f22_arg0 )
		f22_local9 = f22_local1
		if f22_local10 == nil or #f22_local10 == 0 then
			return nil
		end
	end
	local f22_local11 = f22_local10[1]
	return {
		itemId = Engine[0xC6F8EC444864600]( f22_local9, f22_local11, f22_local3 ),
		nameHash = Engine[0xC6F8EC444864600]( f22_local9, f22_local11, f22_local2 ),
		table = Engine[0xC6F8EC444864600]( f22_local9, f22_local11, f22_local4 ),
		bundles = Engine[0xC6F8EC444864600]( f22_local9, f22_local11, f22_local5 ),
		drop = Engine[0xC6F8EC444864600]( f22_local9, f22_local11, f22_local6 ),
		season = Engine[0xC6F8EC444864600]( f22_local9, f22_local11, f22_local7 ),
		category = Engine[0xC6F8EC444864600]( f22_local9, f22_local11, f22_local8 )
	}
end
f0_local0.IsLootItemDefaultUnlocked = function ( f23_arg0 )
	local f23_local0 = CoDLootShared.GetItemNameHashFromLootId( f23_arg0 )
	if CoDLootShared.DefaultUnlockedLootTable[f23_local0] then
		if #CoDLootShared.DefaultUnlockedLootTable[f23_local0] == 0 then
			return true
		elseif LuaUtils.FindItemInArray( CoDLootShared.DefaultUnlockedLootTable[f23_local0], Engine[0x3EAC408F958FF05]() ) then
			return true
		end
	end
	return false
end
f0_local0.IsLootItemOwned = function ( f24_arg0, f24_arg1, f24_arg2 )
	if Engine[0x9E5BE3B4BBA4E0E]( 0xCDC482A7D159F8 ) then
		return true
	elseif Engine[0x352DC095BBB2A45]( f24_arg0, f24_arg1 ) > 0 then
		return true
	elseif CoDShared.IsLootItemDefaultUnlocked( f24_arg1 ) then
		return true
	elseif f24_arg2 then
		for f24_local3, f24_local4 in ipairs( f24_arg2 ) do
			local f24_local5 = CoDShared.LootIndexInfoLookup( f24_local4 )
			if f24_local5 and f24_local5.itemId and Engine[0x352DC095BBB2A45]( f24_arg0, f24_local5.itemId ) > 0 then
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
	if Engine[0x9E5BE3B4BBA4E0E]( 0xCDC482A7D159F8 ) then
		return true
	elseif Engine[0x352DC095BBB2A45]( f26_arg0, f26_arg1 ) > 0 then
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
	local f29_local6 = Engine[0x910CBCCD3C164C9]( f29_local0, f29_local2, f29_arg1 )
	if f29_local6 == nil or #f29_local6 == 0 then
		f29_local6 = Engine[0x910CBCCD3C164C9]( f29_local1, f29_local2, f29_arg1 )
		f29_local5 = f29_local1
		if f29_local6 == nil or #f29_local6 == 0 then
			return false, false
		end
	end
	local f29_local7 = f29_local6[1]
	return true, CoDShared.IsLootItemOwnedSimple( f29_arg0, Engine[0xC6F8EC444864600]( f29_local5, f29_local7, f29_local3 ), Engine[0xC6F8EC444864600]( f29_local5, f29_local7, f29_local4 ) )
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
	elseif LuaDefine.isPC and Dvar[0xC851E2925BC63E4]:get() == 0 and Dvar[0xC2F09BAD1862417]:get() == 1 then
		return true
	else
		return false
	end
end
f0_local0.IsCurrentTextLanguageEnglish = function ()
	if Dvar[0xA97AE527D90FB24]:get() == Enum[0xAA0EE37DF15F5A8][0xDC77F190F9D7964] then
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
		Dvar[0x7424F822EC880D2]:set( 0 )
		Engine[0x280E4C1191CC53D]( f34_arg0, 0x6390ED5F7AB3601, "1" )
	end
	if Dvar[0x2BE8FB76AD6AEA3]:get() then
		return false
	end
	return Engine[0xB72F603CAC75B3A]( f34_arg0, 0x6390ED5F7AB3601 ) ~= 0
end
f0_local0.IsGameInstalled = function ()
	return not Engine[0x7D47312EBA41751]()
end
f0_local0.IsIntDvarNonZero = function ( f36_arg0 )
	if Engine[0x22EAAB59AA27E9B]( f36_arg0 ) ~= 0 then
		return true
	else
		return false
	end
end
f0_local0.IsInGame = function ()
	return Engine[0x7B48C1ABFF0F764]()
end
f0_local0.IsInTheaterLobby = function ()
	local f38_local0 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
	if f38_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0x8B3B066EFD7CD01] then
		return true
	else
		return false
	end
end
f0_local0.IsTeamsMenu = function ()
	local f39_local0 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
	local f39_local1
	if f39_local0 then
		f39_local1 = f39_local0[0x6A4D0AE48D30CBA]
		if not f39_local1 then
		
		else
			return f39_local1
		end
	end
	f39_local1 = false
end
f0_local0.MenuControllingLobbyType = function ()
	local f40_local0 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
	return f40_local0 and f40_local0[0xBF54BE1BB3D618B]
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
	[Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]] = f0_local0.LoadoutSlotOrderZM,
	[Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]] = f0_local0.LoadoutSlotOrderMP,
	[Enum[0x9C0C2196D8313A0][0x60063C67132EB69]] = f0_local0.LoadoutSlotOrderCP,
	[Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]] = f0_local0.LoadoutSlotOrderMP
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
f0_local0.DefaultSpecialistEquipment = 0x628BB1CC00B3BBD
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
		LuaUtils.ClearDDLKeysAndArrays( f43_arg0, f0_local0.LoadoutPaintjobSlots, Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5] )
	end
end
f0_local0.getAttachmentsList = function ( f44_arg0, f44_arg1, f44_arg2, f44_arg3 )
	local f44_local0 = f0_local0.splitString( f44_arg1[f44_arg2] or "", " " )
	local f44_local1 = {}
	for f44_local5, f44_local6 in ipairs( f44_local0 ) do
		local f44_local7 = Engine[0xB99CB645DEAEB92]( f44_arg3, Engine[0x58B87258E0EBAD0]( f44_local6 ), f44_arg0 )
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
		local f45_local6 = Engine[0xB99CB645DEAEB92]( f45_arg1, Engine[0x58B87258E0EBAD0]( f45_local5[0x73F89AC8D3F248] ), f45_arg0 )
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
		f46_arg1[f46_local3 - 1]:set( f46_local4[f46_arg2] and Engine[0xD97229B24C685D5]( f46_local4[f46_arg2], f46_arg3 ) or f0_local0.EmptyItemIndex )
	end
end
f0_local0.updateItemIndexFromLoadout = function ( f47_arg0, f47_arg1, f47_arg2, f47_arg3 )
	if not f47_arg1 then
		return 
	elseif not f47_arg0 or not Engine[0x81EDAAB868725C9]( f47_arg0, f47_arg2 ) then
		local f47_local0 = f0_local0.EmptyItemIndex
	end
	if f47_arg3 then
		local f47_local0 = Engine[0xD97229B24C685D5]( f0_local0.DefaultSpecialistEquipment, f47_arg2 )
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
			f48_local0 = Engine[0xD97229B24C685D5]( f48_arg0, f48_arg2 )
			if not f48_local0 then
			
			else
				if f48_local0 <= CoDShared.EmptyItemIndex and f48_arg3 then
					f48_local0 = Engine[0xD97229B24C685D5]( f0_local0.DefaultSpecialistEquipment, f48_arg2 )
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
	local f49_local4 = f0_local0.getDefaultAttachmentList( f49_arg2, f0_local0.updateItemIndexFromLoadoutHash( f49_arg1[0xF31137FF783E939], f49_local3.itemIndex, f49_arg2 ), f49_arg1.primaryattachments )
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
	f49_local0 = f0_local0.updateItemIndexFromLoadoutHash( f49_arg1[0x7FBC18FBDAA00D1], f49_local5.itemIndex, f49_arg2 )
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
	local f49_local9 = f49_arg1[0x64BE52A1BDE5211]
	if f49_arg2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f49_local7 = nil
		if f49_local1 > 1 then
			local f49_local8 = 0x64BE52A1BDE5211 .. f49_local2
			if f49_arg1[f49_local8] then
				f49_local9 = f49_arg1[f49_local8]
			end
		end
	end
	f0_local0.updateItemIndexFromLoadoutHash( f49_local9, f49_arg0.primarygrenade, f49_arg2, f49_local7 )
	if f49_arg2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		local f49_local8 = f49_arg1[0x660FDC4273B0C19]
		if f49_local1 > 1 then
			local f49_local11 = 0x660FDC4273B0C19 .. f49_local2
			if f49_arg1[f49_local11] then
				f49_local8 = f49_arg1[f49_local11]
			end
		end
		f0_local0.updateItemIndexFromLoadoutHash( f49_local8, f49_arg0.herogadget, f49_arg2 )
		local f49_local11 = f49_arg1[0x260D593D1AC699D]
		if f49_local1 > 1 then
			local f49_local10 = 0x260D593D1AC699D .. f49_local2
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
		f0_local0.updateSlotList( f49_local10, f49_arg0.specialty, 0x340308F6832282F, f49_arg2 )
		local f49_local12 = f49_arg1[0x647C3A51BFBCEBF]
		if f49_local1 > 1 then
			local f49_local13 = 0x647C3A51BFBCEBF .. f49_local2
			if f49_arg1[f49_local13] then
				f49_local12 = f49_arg1[f49_local13]
			end
		end
		f0_local0.updateItemIndexFromLoadoutHash( f49_local12, f49_local3.itemIndex, f49_arg2 )
	end
	if f49_arg2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f0_local0.updateItemIndexFromLoadoutHash( f49_arg1[0xC76C1E0D1EE45F7], f49_arg0.tacticalgear, f49_arg2 )
		f0_local0.updateSlotList( f49_arg1.talents, f49_arg0.talent, 0x5FB380CEA24A88B, f49_arg2 )
		f0_local0.updateSlotList( f49_arg1.bonuscards, f49_arg0.bonuscard, 0x84B95474A4F22DA, f49_arg2 )
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
		f0_local0.updateSlotList( f50_local5, f50_local1.bubbleGumBuff, 0x1B1C240F43AB29B, f50_arg3 )
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
		f0_local0.updateSlotList( f51_local5, f51_local1.bubbleGumBuff, 0x1B1C240F43AB29B, f51_arg4 )
	end
end
f0_local0.SetDefaultGlobalLoadout = function ( f52_arg0, f52_arg1, f52_arg2 )
	LuaUtils.ClearDDLKeysAndArrays( f52_arg0, f0_local0.LoadoutKillstreaks, f0_local0.EmptyItemIndex )
	if f52_arg1 and f52_arg2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and f52_arg1.killstreaks then
		for f52_local3, f52_local4 in ipairs( f52_arg1.killstreaks ) do
			f0_local0.updateItemIndexFromLoadoutHash( f52_local4[0x3E164CE08D58747], f52_arg0["killstreak" .. f52_local3], f52_arg2 )
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
	local f55_local2 = f55_arg1 - Enum[0x33AC0FF9A1537DE][0xFEA2C4AFF9A65EC]
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
	local f56_local0 = Engine[0x8BF970606552F4C]( f56_arg0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC] )
	if f56_local0 == nil then
		return false
	elseif f56_local0.PlayerStatsList.TIME_PLAYED_TOTAL.StatValue:get() > 0 then
		return true
	else
		return false
	end
end
f0_local0.IsERegEnabled = function ( f57_arg0 )
	if Engine[0xCB675CA7856DA25]() then
		local f57_local0 = CoD.StoreUtility.GetExperimentModifier( f57_arg0, "forceEReg" )
		if f57_local0 and f57_local0 ~= nil and f57_local0 ~= "" and f57_local0 == "1" and not CoDShared.HasPlayedBlackout( f57_arg0 ) then
			return true
		elseif Dvar[0xA63EB34B74263E8]:get() then
			return true
		end
	elseif Dvar[0x8BC2986F499E427]:get() then
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
		if f58_arg2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			f0_local0.updateItemIndexFromLoadoutHash( nil, f58_local1.primarygrenade, f58_arg2, f0_local0.DefaultSpecialistEquipment )
		end
	end
end
f0_local0.GetDefaultLoadoutForCurrentMode = function ()
	local f59_local0 = Engine[0x3EAC408F958FF05]()
	if f59_local0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		return Engine[0xE00B2F29271C60B]( 0x1C53105E8C011C4 )
	elseif f59_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		if LuaUtils.IsArenaMode() then
			return Engine[0xE00B2F29271C60B]( 0x4FF2B60D157BBB2 )
		else
			return Engine[0xE00B2F29271C60B]( 0x705A80062BD09C2 )
		end
	elseif f59_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return Engine[0xE00B2F29271C60B]( 0x9EEE28789FE067A )
	elseif f59_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return Engine[0xE00B2F29271C60B]( 0x5E2F5F439F26596 )
	else
		
	end
end
f0_local0.SetCACRootToDefault = function ( f60_arg0 )
	local f60_local0 = f60_arg0.eMode
	local f60_local1 = f60_arg0.classDDLRoot
	local f60_local2 = Engine[0x3091707D0144833]()
	if f60_local1 then
		if f60_local0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
			local f60_local3 = Engine[0xE00B2F29271C60B]( 0x1C53105E8C011C4 )
			for f60_local4 = 1, #f60_local1.customclass, 1 do
				f0_local0.SetDefaultLoadout( f60_local1, f60_local4, f60_local3, f60_local0, nil )
			end
		elseif f60_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			local f60_local3 = nil
			if f60_arg0.loadout ~= nil and f60_arg0.loadout ~= 0x0 then
				f60_local3 = Engine[0xE00B2F29271C60B]( f60_arg0.loadout )
			else
				f60_local3 = Engine[0xE00B2F29271C60B]( LuaUtils.IsArenaMode() and 0x4FF2B60D157BBB2 or 0x705A80062BD09C2 )
			end
			for f60_local4 = Enum[0x33AC0FF9A1537DE][0xB269FFE65DEF21C] + 1, Enum[0x33AC0FF9A1537DE][0x496B3CCA108698A], 1 do
				f0_local0.SetCustomDefaultLoadout( f60_local1, f60_local4, f60_local3, f60_local0, nil )
			end
			if f60_local2 then
				for f60_local4 = Enum[0x33AC0FF9A1537DE][0xFEA2C4AFF9A65EC] + 1, Enum[0x33AC0FF9A1537DE][0x46004DB4E087522] + 1, 1 do
					f0_local0.SetDefaultLoadout( f60_local1, f60_local4, f60_local3, f60_local0, nil )
				end
			end
			CoDShared.SetDefaultGlobalLoadout( f60_local1, f60_local3, f60_local0 )
		elseif f60_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			local f60_local3 = Engine[0xE00B2F29271C60B]( 0x9EEE28789FE067A )
			local f60_local4 = Engine[0xBBE3328FE08B8C7]()
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
f0_local0.Loot.ContractSlots.SLOT_1 = 0xE455FFF57C32D01
f0_local0.Loot.ContractSlots.SLOT_2 = 0xE455CFF57C327E8
f0_local0.Loot.MasterSeasonTable = 0xFE613834D811EC6
f0_local0.Loot.MasterContractTable = 0x9FA37692BF3254F
f0_local0.Loot.MasterReservesTable = 0x42660E60408E67A
f0_local0.Loot.LastSeasonStartTime = "1569862800"
f0_local0.Loot.SEASON_INFO_NUMBER = 0xDCCDC690358AE80
f0_local0.Loot.SEASON_INFO_MAX_TIERS = 0xDB6B258E890058B
f0_local0.Loot.SEASON_INFO_DROP_VERSIONS = 0x612F26908E35700
f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION = 0x30E13B4E29C0E4A
f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON = 0xABCAB4113C3EBFD
f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG = 0xBAC3D33F590FB73
f0_local0.Loot.SEASON_INFO_TABLENAME = 0xBCB6E85B78CF363
f0_local0.Loot.Cases = {
	0x55E6190E8792FD1
}
f0_local0.Loot.Crates = {
	0x57C19FD441C59FF,
	0x148EA9EC3E2DC60,
	0x4DE2B5257791347,
	0x7D5A898E7F617AA,
	0x91701EF423E11E1
}
f0_local0.Loot.SeasonParams = {
	[0x73355E5E2DBA44D] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 1,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 200,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 1,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0xECEB1CEB2EEA45,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0x45763E4B241D123,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0x627C92BE5FDCDD0
	},
	[0x73352E5E2DB9F34] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 2,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 100,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 3,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0xBC1FDA3602A81B6,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0x7156584833CE8D0,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0x71B16584E35BB31
	},
	[0x73353E5E2DBA0E7] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 3,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 100,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 5,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0x6542ED4168E987,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0xC54B39CE7655BF1,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0xD3EBD52E3A6338A
	},
	[0x73350E5E2DB9BCE] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 4,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 50,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 6,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0x8569D813D145E18,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0xFD3AC1D8D4268E6,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0x7A467206BBDFF3B
	},
	[0x73351E5E2DB9D81] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 5,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 50,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 8,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0x9C937CD580D9C61,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0xF6E98C54AF4B67F,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0x61D002E194284DC
	},
	[0x7334EE5E2DB9868] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 6,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 40,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8,9",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 9,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0x3264C66FE172472,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0x8D889252E3E782C,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0x7424A3B6A94A7BD
	},
	[0x7334FE5E2DB9A1B] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 7,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 60,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8,9,10",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 10,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0xB868A761E54E653,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0xD9BDCC983A0931D,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0xF0E131157E4FC6
	},
	[0x7334CE5E2DB9502] = {
		[f0_local0.Loot.SEASON_INFO_NUMBER] = 8,
		[f0_local0.Loot.SEASON_INFO_MAX_TIERS] = 50,
		[f0_local0.Loot.SEASON_INFO_DROP_VERSIONS] = "1,2,3,4,5,6,7,8,9,10,11",
		[f0_local0.Loot.SEASON_INFO_HIGHEST_DROP_VERSION] = 11,
		[f0_local0.Loot.SEASON_INFO_ASSET_POSTSEASON] = 0x1EA71735DBD7584,
		[f0_local0.Loot.SEASON_INFO_ASSET_ALLRNG] = 0x1DB2EA27F50DA32,
		[f0_local0.Loot.SEASON_INFO_TABLENAME] = 0x3ABDE23DA74CF07
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
		f61_local0 = f61_local0 + Engine[0x352DC095BBB2A45]( f61_arg0, f61_local5.id )
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
	local f63_local1 = Dvar[0xA8A508EBA98A27E]:get()
	if f63_local1 and f63_local1 ~= "" and CoDShared.Loot.GetSeasonInfoParam( f63_arg0, CoDShared.Loot.SEASON_INFO_HIGHEST_DROP_VERSION ) < tonumber( string.match( f63_local1, "%d+" ) ) then
		f63_local0 = f63_local0 .. "," .. f63_local1
	end
	return f63_local0
end
f0_local0.Loot.GetCurrentSeason = function ()
	local f64_local0 = Dvar[0x462D05D73A06ACE]:get()
	if f64_local0 == nil or f64_local0 == "" then
		return 0x0
	else
		return Engine[0xC53F8D38DF9042B]( f64_local0 )
	end
end
f0_local0.Loot.GetNextSeason = function ()
	if Dvar[0xA74F344825B5618] == nil then
		return 0x0
	else
		local f65_local0 = Dvar[0xA74F344825B5618]:get()
		if f65_local0 == nil or f65_local0 == "" then
			return 0x0
		else
			return Engine[0xC53F8D38DF9042B]( f65_local0 )
		end
	end
end
f0_local0.Loot.GetCurrentEventContract = function ()
	local f66_local0 = Dvar[0xA7588CE8BBBC25D]:get()
	if f66_local0 == nil or f66_local0 == "" then
		return 0x0
	else
		return Engine[0xC53F8D38DF9042B]( f66_local0 )
	end
end
f0_local0.Loot.GetContractTable = function ( f67_arg0 )
	return CoDShared.Loot.ContractTables[f67_arg0]
end
f0_local0.Loot.GetSeasonInfo = function ( f68_arg0 )
	local f68_local0 = {}
	local f68_local1 = CoDShared.Loot.MasterSeasonTable
	f68_local0.name = f68_arg0
	f68_local0.id = Engine[0x2DCF0973239E909]( f68_local1, 0, 1, f68_arg0 )
	f68_local0.params = CoDShared.Loot.SeasonParams[f68_arg0]
	return f68_local0
end
f0_local0.Loot.GetContractInfo = function ( f69_arg0, f69_arg1 )
	local f69_local0 = {}
	local f69_local1 = CoDShared.Loot.MasterContractTable
	f69_local0.name = f69_arg1
	f69_local0.id = Engine[0x2DCF0973239E909]( f69_local1, 0, 1, f69_arg1 )
	if f69_local0.id == nil then
		return nil
	else
		f69_local0.rarity = Engine[0x2DCF0973239E909]( f69_local1, 2, 1, f69_arg1 )
		f69_local0.dropNumber = Engine[0x2DCF0973239E909]( f69_local1, 3, 1, f69_arg1 )
		f69_local0.prt = Engine[0x2DCF0973239E909]( f69_local1, 5, 1, f69_arg1 )
		f69_local0.outfit = Engine[0x2DCF0973239E909]( f69_local1, 6, 1, f69_arg1 )
		f69_local0.tierProgress = Engine[0x159D7050715A2C3]( f69_arg0, f69_arg1 )
		return f69_local0
	end
end
f0_local0.Loot.GetStreamName = function ( f70_arg0 )
	local f70_local0 = 0
	local f70_local1 = 1
	local f70_local2 = Engine[0x2DCF0973239E909]( CoDShared.Loot.MasterSeasonTable, f70_local1, f70_local0, f70_arg0 )
	if f70_local2 == nil or f70_local2 == "" then
		f70_local2 = Engine[0x2DCF0973239E909]( CoDShared.Loot.MasterContractTable, f70_local1, f70_local0, f70_arg0 )
	end
	return f70_local2
end
f0_local0.Loot.GetStreamId = function ( f71_arg0 )
	local f71_local0 = 0
	local f71_local1 = 1
	local f71_local2 = Engine[0x2DCF0973239E909]( CoDShared.Loot.MasterSeasonTable, f71_local0, f71_local1, f71_arg0 )
	if f71_local2 == nil or f71_local2 == "" then
		f71_local2 = Engine[0x2DCF0973239E909]( CoDShared.Loot.MasterContractTable, f71_local0, f71_local1, f71_arg0 )
	end
	return f71_local2
end
f0_local0.Loot.GetActiveContractIds = function ( f72_arg0 )
	local f72_local0 = {}
	if f72_arg0 == nil then
		return f72_local0
	end
	local f72_local1 = Engine[0x8BF970606552F4C]( f72_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
	if f72_local1 == nil then
		return f72_local0
	end
	for f72_local7, f72_local8 in pairs( CoDShared.Loot.ContractSlots ) do
		if f72_local8 ~= nil then
			local f72_local5 = f72_local1[0x5951A0A644A98FB][f72_local8]
			if f72_local5 ~= nil then
				local f72_local6 = f72_local5[0x871FFFC5C709FEE]:get()
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
		local f73_local1 = Dvar[0xA8A508EBA98A27E]:get()
		if f73_local1 and f73_local1 ~= "" and f73_local0 < tonumber( string.match( f73_local1, "%d+" ) ) then
			f73_local0 = tonumber( string.match( f73_local1, "%d+" ) )
		end
	end
	local f73_local1 = 0
	local f73_local2 = Engine[0x63FBABD1982143E]( CoDShared.Loot.MasterReservesTable )
	local f73_local3 = 0
	for f73_local4 = 1, f73_local2, 1 do
		local f73_local7 = Engine[0xC6F8EC444864600]( CoDShared.Loot.MasterReservesTable, f73_local4 - 1, 0 )
		local f73_local8 = Engine[0xC6F8EC444864600]( CoDShared.Loot.MasterReservesTable, f73_local4 - 1, 9 )
		if f73_local8 and f73_local0 and f73_local8 <= f73_local0 then
			f73_local3 = f73_local3 + 1
			local f73_local9 = f73_local7 and Engine[0x352DC095BBB2A45]( f73_arg0, f73_local7 ) > 0
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
	local f74_local0 = Engine[0x4DF5CFBC1771947]( f74_arg0 )
	f74_local0 = f74_local0:create( "LootStreamProgress", true )
	if f74_local0 then
		local f74_local1 = not Dvar[0x50FB25F071D6CBB]:get()
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
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		if f75_arg1[0x953B2B12F1D6B1B] == nil then
			return 
		end
		local f75_local0 = Engine[0x8BF970606552F4C]( f75_arg0, Enum[0xBBD4F9E70101BA8][0xD5A7695E03A7A90] )
		if f75_local0[0xE21F66EB3A1F18] then
			for f75_local17, f75_local18 in DDLUtils.pairs( f75_local0[0xE21F66EB3A1F18] ) do
				local f75_local19 = Engine[0x8FF94BB44442412]( f75_local17, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
				if f75_arg1[0x953B2B12F1D6B1B][f75_local17] and f75_arg1[0x953B2B12F1D6B1B][f75_local17][0xAB8B7DF567CD2A] then
					local f75_local4 = Engine[0xA6C26EBACD7322D]( f75_arg0, Enum[0x303F77CADBF82AB][0xF27E237306A62E0], Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
					if f75_local4 then
						local f75_local5 = f75_local4.PlayerStatsList.RANK
						local f75_local6 = f75_local4.PlayerStatsList.RANK.StatValue:get()
					end
					local f75_local7 = (Engine[0x6A28AE1C9C05372]( f75_local19, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) or 0) <= (f75_local5 and f75_local6 or 0) or Engine[0xD876F030270CB95]( f75_arg0, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], f75_local17 )
					local f75_local8 = CoDShared.IsLootItemOwnedByName( f75_arg0, f75_local17 )
					if not f75_local8 then
						for f75_local14, f75_local15 in ipairs( Engine[0x9F0BB7D52A7A978]( f75_local17 ) ) do
							if f75_local15[0x28887F70BF5EBA] ~= 0x0 then
								local f75_local12, f75_local13 = CoDShared.IsLootItemOwnedByNameSimple( f75_arg0, f75_local15[0x28887F70BF5EBA] )
								if f75_local13 then
									f75_local8 = true
									break
								end
							end
						end
					end
					if f75_local8 ~= nil then
						local f75_local16 = f75_arg1[0x953B2B12F1D6B1B][f75_local17][0xAB8B7DF567CD2A]
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
					local f75_local16 = f75_arg1[0x953B2B12F1D6B1B][f75_local17][0xAB8B7DF567CD2A]
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
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		if f75_arg1[0x473319D8A8D9DCF] == nil then
			return 
		elseif f75_arg1[0x473319D8A8D9DCF] then
			for f75_local3, f75_local17 in DDLUtils.pairs( f75_arg1[0x473319D8A8D9DCF] ) do
				local f75_local18 = Engine[0x8FF94BB44442412]( f75_local3, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
				if f75_arg1[0x473319D8A8D9DCF][f75_local3] then
					local f75_local19 = CoDShared.IsLootItemOwnedByName( f75_arg0, f75_local3 )
					if f75_local19 ~= nil then
						local f75_local4 = f75_arg1[0x473319D8A8D9DCF][f75_local3]
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
					f75_arg1[0x473319D8A8D9DCF][f75_local3]:set( 0 )
				end
			end
		end
	end
end
f0_local0.Loot.GetTierBoostItemTotal = function ( f76_arg0 )
	return Engine[0x352DC095BBB2A45]( f76_arg0, Dvar[0xE42EFF14E284E15]:get() ) or 0
end
f0_local0.Loot.GetCurrentTierBoost = function ( f77_arg0 )
	if Engine[0x2DA54CF5D6B7F02]() then
		local f77_local0 = Dvar[0xE9B47B844CE9EC]:get()
		if f77_local0 > 0 then
			return f77_local0
		end
	end
	local f77_local1 = (Engine[0x352DC095BBB2A45]( f77_arg0, Dvar[0xE42EFF14E284E15]:get() ) or 0) * Dvar[0xB23C92E3E72DF30]:get()
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
	if Engine[0x3C915544ECCD34B]( f79_arg0 ) and Dvar[0xA29EB7B0B47996C]:exists() then
		return Dvar[0xA29EB7B0B47996C]:get()
	else
		return 0
	end
end
f0_local0.Loot.GetBOPassPartyTierBoost = function ( f80_arg0 )
	if Engine[0x3C915544ECCD34B]( f80_arg0 ) then
		return 0
	end
	local f80_local0 = Engine[0x80964E6C43E0C4B]()
	local f80_local1 = Engine[0x8DF2E5447F384B9]()
	f80_local1 = f80_local1.lobbyRoot
	if f80_local1 and f80_local1.lobbyMainMode then
		local f80_local2 = f80_local1.lobbyMainMode:get()
	end
	if CoDShared.GetLobbyDLCBits( f80_local2 or -1, Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110] ) & Enum[0xE2A6806BB83D51C][0x39C6503528DB793] > 0 and Dvar[0x362DEDC404612D0]:exists() then
		return Dvar[0x362DEDC404612D0]:get()
	end
	return 0
end
f0_local0.Loot.ClearRNGModels = function ( f81_arg0 )
	local f81_local0 = Engine[0x4DF5CFBC1771947]( f81_arg0 )
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
	Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x8DC984EB9B80F9], "Bribe Payload: " .. f82_local2 .. "\n" )
	return f82_local2
end
f0_local0[0x562F4B21BD0FAB0] = function ( f83_arg0, f83_arg1 )
	if Engine[0x7B48C1ABFF0F764]() then
		return 
	end
	local f83_local0 = Engine[0x8BF970606552F4C]( f83_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882] )
	local f83_local1, f83_local2 = nil
	if f83_local0 then
		if f83_arg1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			f83_local1 = f83_local0[0xD17B4E10FA9C28C]
			local f83_local3 = Engine[0xFC41172469DB251]( f83_arg0 )
			if f83_local3 then
				f83_local2 = f83_local3[0x147738D5CEE9199]
			end
		elseif f83_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			f83_local1 = f83_local0.wzCharacters
			local f83_local3 = Engine[0xFC41172469DB251]( f83_arg0 )
			if f83_local3 then
				f83_local2 = f83_local3[0x147738D5CEE9199]
			end
		elseif f83_arg1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f83_local1 = f83_local0.zmCharacters
			local f83_local3 = Engine[0xFC41172469DB251]( f83_arg0 )
			if f83_local3 then
				f83_local2 = f83_local3[0x147738D5CEE9199]
			end
		end
	end
	if f83_local1 and f83_local2 then
		for f83_local13, f83_local14 in DDLUtils.ipairs( f83_local2 ) do
			local f83_local15 = f83_local1[f83_local13]
			local f83_local16 = f83_local14[0xF7F78E9EBEFCE27]:get()
			f83_local15[0xEFB826D1A3BB80A]:set( f83_local16 )
			local f83_local17 = f83_local14[0xD9FCEAC8FF24CBD]:get()
			f83_local15[0x32308E50B7EEFA8]:set( f83_local17 )
			local f83_local18 = f83_local14[0xE5C77948998E49][f83_local16]
			local f83_local19 = f83_local14[0xE5C77948998E49][f83_local17]
			for f83_local6, f83_local7 in DDLUtils.pairs( f83_local18[0x12BCDFA518CC913] ) do
				if f83_local6 == Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1] then
					f83_local15[0x4DAF419B5CE4B42][f83_local6]:set( f83_local19[f83_local6]:get() )
				else
					f83_local15[0x4DAF419B5CE4B42][f83_local6]:set( f83_local7:get() )
				end
			end
			if f83_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
				if Engine[0x8BF970606552F4C]( f83_arg0, Enum[0xBBD4F9E70101BA8][0xD1A0F784B3C95A0] ) and Engine[0x8BF970606552F4C]( f83_arg0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC] ) then
					f83_local8 = Engine[0xA5B5E7CABA5C3AB]( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
					f83_local6 = true
					for f83_local11, f83_local12 in ipairs( f83_local8 ) do
						if f83_local12.bodyIndex == f83_local13 then
							f83_local6 = not LuaUtils.IsRoleUnlocked( f83_arg0, f83_arg1, f83_local13 )
							break
						end
					end
					f83_local7 = f83_local15[0xA616BDFE454ECB3]
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
			f83_local15[0xA616BDFE454ECB3]:set( 0 )
		end
		Engine[0x28A466EF7723621]( f83_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882] )
	end
end
f0_local0.IsBitSet = function ( f84_arg0, f84_arg1 )
	return f84_arg0 & 1 << f84_arg1 > 0
end
f0_local0.NextReportTime = 0
f0_local0.ReportUser = function ( f85_arg0, f85_arg1, f85_arg2, f85_arg3, f85_arg4, f85_arg5 )
	if f85_arg4 then
		if Engine[0x9D33D652B9B0F3B]() < f0_local0.NextReportTime then
			return 
		end
		f0_local0.NextReportTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x9946E2F81FCDB18]:get() * 1000
	end
	local f85_local0 = ""
	local f85_local1 = LuaDefine.ZERO_X64
	if f85_arg2 == "offensive_emblem" then
		f85_local0, f85_local1 = Engine[0x544B06417DB16AA]( f85_arg1 )
	end
	if f85_arg5 == nil then
		f85_arg5 = ""
	end
	Engine[0xDE279ECDDDD966]( f85_arg0, 0xFCCC6EEEAF0939B, {
		[0xB5C735486FC7CCB] = f85_arg1,
		[0xCF0F333F5033DD1] = f85_arg2,
		[0x9219FBE4AAC71B6] = f85_arg3,
		[0x336E379BA146826] = Engine[0xD52E2360F482280](),
		[0x3E2AC46BE8D2A8] = f85_local0,
		[0xBDAB42C07F19812] = f85_local1,
		[0x46401B5D2A8D2A4] = f85_arg5
	} )
end
f0_local0.IsMapFree = function ( f86_arg0, f86_arg1, f86_arg2 )
	local f86_local0 = LobbyData.GetLobbyMenuByID( f86_arg1 )
	if f86_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9] then
		local f86_local1 = Engine[0x3ACB99DBAD24D55]( f86_arg2 )
		for f86_local5, f86_local6 in ipairs( f86_local1.rotationList ) do
			if f86_local6.map == f86_arg0 then
				return f86_local6.isFree
			end
		end
	end
end
f0_local0.GetLobbyDLCBits = function ( f87_arg0, f87_arg1, f87_arg2 )
	if Dvar[0x32261E3333DC0E9]:exists() and Dvar[0x32261E3333DC0E9]:get() and (f87_arg0 == Enum[0x89C1455C5032969][0x7E41449995CD57E] or f87_arg0 == Enum[0x89C1455C5032969][0x78C124999125C42]) then
		return Engine[0xB892CC772EEDA44]( f87_arg1, f87_arg2 )
	else
		return Engine[0xFD1E02C14853724]()
	end
end
f0_local0.LootContracts = {}
f0_local0.LootContracts.LootContractsTable = 0x222A2B349A0591D
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
	local f88_local0 = Engine[0x2DCF0973239E909]( f0_local0.LootContracts.LootContractsTable, 1, 0, f88_arg0 )
	if f88_local0 ~= nil then
		return f88_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.GetContractsCategoryHash = function ( f89_arg0 )
	local f89_local0 = Engine[0x2DCF0973239E909]( f0_local0.LootContracts.LootContractsTable, 2, 0, f89_arg0 )
	if f89_local0 ~= nil then
		return f89_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.GetContractsProgressTarget = function ( f90_arg0, f90_arg1 )
	return Engine[0x44636E6D3F19799]( f90_arg0, f90_arg1 )
end
f0_local0.LootContracts.GetContractsDifficulty = function ( f91_arg0 )
	local f91_local0 = Engine[0x2DCF0973239E909]( f0_local0.LootContracts.LootContractsTable, 4, 0, f91_arg0 )
	if f91_local0 ~= nil then
		return f91_local0
	else
		return 0
	end
end
f0_local0.LootContracts.GetContractsGameMode = function ( f92_arg0 )
	local f92_local0 = Engine[0x2DCF0973239E909]( f0_local0.LootContracts.LootContractsTable, 5, 0, f92_arg0 )
	if f92_local0 ~= nil then
		return f92_local0
	else
		return Enum[0x1B899F51A938E95][0x8291997DE05302D]
	end
end
f0_local0.LootContracts.GetContractTitle = function ( f93_arg0 )
	local f93_local0 = Engine[0x2DCF0973239E909]( f0_local0.LootContracts.LootContractsTable, 6, 0, f93_arg0 )
	if f93_local0 ~= nil then
		return f93_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.GetContractDescription = function ( f94_arg0 )
	local f94_local0 = Engine[0x2DCF0973239E909]( f0_local0.LootContracts.LootContractsTable, 7, 0, f94_arg0 )
	if f94_local0 ~= nil then
		return f94_local0
	else
		return 0x0
	end
end
f0_local0.LootContracts.IsLootContractTableValid = function ( f95_arg0 )
	local f95_local0 = Engine[0x8FD43DB47D439AE]()
	local f95_local1 = f95_arg0
	local f95_local2
	if f95_arg0.dailyExpiration > 0 and not Engine[0x5DB5D55C0CDC74E]( tostring( f95_arg0.dailyExpiration ), f95_local0 ) and f95_arg0.availableExpiration > 0 then
		f95_local2 = not Engine[0x5DB5D55C0CDC74E]( tostring( f95_arg0.availableExpiration ), f95_local0 )
	else
		f95_local2 = false
	end
	return f95_local2
end
f0_local0.LootContracts.ShouldAddActiveContract = function ( f96_arg0, f96_arg1, f96_arg2 )
	local f96_local0 = f0_local0.IsBitSet( f96_arg0.flags, Enum[0xB40A0B507A68068][0xF7D0F1F6F551B94] )
	if f96_local0 then
		if not f0_local0.IsBitSet( f96_arg0.flags, Enum[0xB40A0B507A68068][0xF26C5D1872ABE11] ) then
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
	local f98_local0 = Engine[0x3EAC408F958FF05]()
	if f98_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		if LuaUtils.IsArenaMode() then
			return Enum[0x1B899F51A938E95][0xEFB62D162F33EC5]
		else
			return Enum[0x1B899F51A938E95][0xF1D72D16310405B]
		end
	elseif f98_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return Enum[0x1B899F51A938E95][0xEEA5DD162E4C313]
	elseif f98_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return Enum[0x1B899F51A938E95][0xEFB6CD162F34FC3]
	else
		return Enum[0x1B899F51A938E95][0x8291997DE05302D]
	end
end
f0_local0.LootContracts.IsEnabled = function ( f99_arg0 )
	return Dvar[0x33765862CEF96C0]:get() and not Engine[0xCB675CA7856DA25]()
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
		if f100_local1 ~= Enum[0x1B899F51A938E95][0x8291997DE05302D] then
			local f100_local2 = Engine[0xDC39182CB1C9BE4]( f100_arg0, f100_local1 )
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
	if f101_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f101_local0 = Dvar[0xA659C21568D7219]:get()
	elseif f101_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f101_local0 = Dvar[0xAAD972156CB1F3D]:get()
	elseif f101_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f101_local0 = Dvar[0xABEA22156D9A521]:get()
	end
	if f101_local0 ~= nil and f101_local0 ~= "" then
		return Engine[0xC53F8D38DF9042B]( f101_local0 )
	else
		return 0x0
	end
end
f0_local0.Playlists.GetLowpopShowcased = function ( f102_arg0 )
	local f102_local0 = nil
	if f102_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f102_local0 = Dvar[0x9D9F4F1877E2CC3]:get()
	elseif f102_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f102_local0 = Dvar[0x9A6EFF18752CAAB]:get()
	elseif f102_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f102_local0 = Dvar[0x981FEF18733C7EB]:get()
	end
	if f102_local0 ~= nil and f102_local0 ~= "" then
		return Engine[0xC53F8D38DF9042B]( f102_local0 )
	else
		return 0x0
	end
end
f0_local0.Playlists.GetFeaturedInternal = function ( f103_arg0 )
	local f103_local0 = {}
	if f103_arg0 ~= nil and f103_arg0 ~= "" then
		for f103_local4 in string.gmatch( f103_arg0, "[^%s;]+" ) do
			if f103_local4 and f103_local4 ~= "" then
				table.insert( f103_local0, Engine[0xC53F8D38DF9042B]( f103_local4 ) )
			end
		end
	end
	return f103_local0
end
f0_local0.Playlists.GetFeatured = function ( f104_arg0 )
	local f104_local0 = nil
	if f104_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f104_local0 = Dvar[0xCAE66D461D6B5D1]:get()
	elseif f104_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f104_local0 = Dvar[0xC8851D461B5C2E5]:get()
	elseif f104_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f104_local0 = Dvar[0xC635CD46196B959]:get()
	end
	return CoDShared.Playlists.GetFeaturedInternal( f104_local0 )
end
f0_local0.Playlists.GetLowpopFeatured = function ( f105_arg0 )
	local f105_local0 = nil
	if f105_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f105_local0 = Dvar[0xC29714B70182EB3]:get()
	elseif f105_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f105_local0 = Dvar[0xC638C4B7049D4DB]:get()
	elseif f105_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f105_local0 = Dvar[0xC3E7B4B702A9BBB]:get()
	end
	return CoDShared.Playlists.GetFeaturedInternal( f105_local0 )
end
f0_local0.Playlists.IsBlacklistedInternal = function ( f106_arg0, f106_arg1 )
	if f106_arg1 ~= nil and f106_arg1 ~= "" then
		for f106_local3 in string.gmatch( f106_arg1, "[^%s;]+" ) do
			if f106_local3 and f106_local3 ~= "" and f106_arg0 == Engine[0xC53F8D38DF9042B]( f106_local3 ) then
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
	return CoDShared.Playlists.IsBlacklistedInternal( f108_arg0, Dvar[0xF9B69E79C09279D]:get() )
end
CoDShared = LuaReadOnlyTables.ReadOnlyTable( f0_local0 )
