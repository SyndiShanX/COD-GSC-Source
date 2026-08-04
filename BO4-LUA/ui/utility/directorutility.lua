CoD.DirectorUtility = {}
require( "ui/utility/overlayutility" )
CoD.DirectorUtility.Filters = nil
CoD.DirectorUtility.FocusFeaturedFiltered = Engine.CurrentSessionMode() == Enum.eModes.mode_invalid
DataSources.DirectorFilters = DataSourceHelpers.ListSetup( "DirectorFilters", function ( f1_arg0, f1_arg1 )
	local f1_local0 = {}
	local f1_local1
	if not CoD.DirectorUtility.FocusFeaturedFiltered then
		f1_local1 = Engine[@"getplaylistid"]()
	else
		f1_local1 = false
	end
	for f1_local11, f1_local12 in ipairs( CoD.DirectorUtility.Filters ) do
		local f1_local8 = false
		if f1_local12.id ~= "Featured" then
			for f1_local9, f1_local10 in ipairs( f1_local12.cards ) do
				if f1_local10.playlist == f1_local1 then
					f1_local8 = true
					break
				end
			end
		end
		table.insert( f1_local0, {
			models = {
				name = f1_local12.name,
				dataSource = "DirectorCardList_" .. f1_local12.id,
				icon = f1_local12.icon,
				mainMode = f1_local12.mainMode,
				available = f1_local12.available
			},
			properties = {
				tabId = f1_local12.id,
				action = f1_local12.action,
				param = f1_local12,
				selectIndex = f1_local8
			}
		} )
	end
	if IsArenaMode() then
		table.insert( f1_local0, {
			models = {
				name = @"hash_13E0FB9041E49A72",
				dataSource = "DirectorCardList_ArenaNews",
				available = true
			},
			properties = {
				tabId = "news"
			}
		} )
	end
	return f1_local0
end, true )
CoD.DirectorUtility.MultiplePlaylistTabsAvailable = function ( f2_arg0 )
	local f2_local0 = CoD.DirectorUtility.Filters
	if f2_local0 then
		f2_local0 = #CoD.DirectorUtility.Filters
		if f2_local0 then
			f2_local0 = #CoD.DirectorUtility.Filters > 1
		end
	end
	return f2_local0
end
DataSources.ServerBrowserFilters = DataSourceHelpers.ListSetup( "ServerBrowserFilters", function ( f3_arg0, f3_arg1 )
	local f3_local0 = {
		{
			models = {
				name = "menu/all_caps",
				filter = Enum.LobbyMainMode[@"lobby_mainmode_invalid"]
			}
		}
	}
	for f3_local4, f3_local5 in ipairs( {
		Enum.LobbyMainMode[@"lobby_mainmode_mp"],
		Enum.LobbyMainMode[@"lobby_mainmode_zm"],
		Enum.LobbyMainMode[@"lobby_mainmode_wz"],
		Enum.LobbyMainMode[@"lobby_mainmode_cp"]
	} ) do
		local f3_local6 = LuaUtils.GetDisplayNameForLobbyMainMode( f3_local5 )
		if f3_local6 ~= 0x0 then
			table.insert( f3_local0, {
				models = {
					name = f3_local6,
					filter = f3_local5
				}
			} )
		end
	end
	return f3_local0
end, true )
CoD.DirectorUtility.CreateCardListDataSource = function ( f4_arg0, f4_arg1, f4_arg2, f4_arg3 )
	local f4_local0 = {}
	if f4_arg3.cards then
		local f4_local1 = 0
		local f4_local2
		if not CoD.DirectorUtility.FocusFeaturedFiltered then
			f4_local2 = Engine[@"getplaylistid"]()
		else
			f4_local2 = false
		end
		for f4_local10, f4_local11 in ipairs( f4_arg3.cards ) do
			if f4_local11.mode == nil or LuaUtils.GetDisplayNameForLobbyMainMode( f4_local11.mode ) ~= 0x0 then
				local f4_local6 = f4_local11.featured and 2 or 1
				local f4_local7 = {
					models = f4_local11
				}
				local f4_local8 = {
					param = f4_local11,
					rowSpan = f4_local6
				}
				local f4_local9
				if f4_arg0._hasSetDefault or f4_local11.playlist ~= f4_local2 then
					f4_local9 = false
				else
					f4_local9 = true
				end
				f4_local8.selectIndex = f4_local9
				f4_local7.properties = f4_local8
				if f4_local11.featured then
					f4_local1 = f4_local1 + 1
					if f4_local11.isQuickplayCard then
						table.insert( f4_local0, 1, f4_local7 )
					else
						table.insert( f4_local0, f4_local1, f4_local7 )
						goto basicblock_21:
					end
				end
				if not CoD.DirectorUtility.RegionOnlyAllowsFeaturedPlaylistForMode( f4_arg1, f4_local11.mode ) or f4_local11.playlist == Engine[@"getplaylistid"]() or f4_local11.lowPopPlaylist then
					table.insert( f4_local0, f4_local7 )
				end
			end
		end
	end
	f4_arg0._hasSetDefault = true
	CoD.DirectorUtility.FocusFeaturedFiltered = false
	return f4_local0
end
DataSources.DirectorTextModes = DataSourceHelpers.ListSetup( "DirectorTextModes", function ( f5_arg0, f5_arg1 )
	local f5_local0 = {}
	table.insert( f5_local0, {
		models = {
			available = true,
			mode = Enum.eModes.mode_multiplayer
		},
		properties = {
			selectIndex = true
		}
	} )
	table.insert( f5_local0, {
		models = {
			available = true,
			mode = Enum.eModes.mode_zombies
		}
	} )
	table.insert( f5_local0, {
		models = {
			available = true,
			mode = Enum.eModes.mode_warzone
		}
	} )
	for f5_local4, f5_local5 in ipairs( f5_local0 ) do
		f5_local5.models.name = LuaUtils.GetDisplayNameForEMode( f5_local5.models.mode )
	end
	if f5_arg1.menu:getSessionMode() == Enum.eModes.mode_invalid then
		f5_arg1.menu:setSessionMode( Enum.eModes.mode_multiplayer )
	end
	return f5_local0
end, true )
CoD.DirectorUtility.ClientListFlags = {
	SHOW_EXPANDED = 1,
	FIRST_EMPTY = 2
}
CoD.DirectorUtility.DirectorPartyListUpdateClientInfo = function ( f6_arg0, f6_arg1, f6_arg2 )
	local f6_local0 = 1
	if f6_arg1.rankIcon == nil then
		f6_local0 = 0
		f6_arg1.rankIcon = "blacktransparent"
	end
	f6_arg1.displayRank = "0"
	f6_arg1.rankTitle = ""
	local f6_local1 = ""
	f6_arg1.highlightDisplayRankString = false
	if f6_arg1.rank then
		local f6_local2 = Engine.CurrentSessionMode()
		if LuaUtils.GameModeAvailable( f6_local2 ) then
			if IsArenaMode() then
				f6_arg1.rankTitle = CoD.ArenaUtility.SetArenaDisplayRankAndIcon( f6_arg1 )
			else
				f6_arg1.displayRank = Engine.GetRankDisplayLevel( f6_arg1.rank )
				if LuaUtils.IsGameModeParagonCapable( f6_local2 ) and f6_arg1.paragonRank and f6_arg1.prestige == CoD.PrestigeUtility.GetPrestigeCap() then
					f6_arg1.displayRank = Engine.GetParagonRankDisplayLevel( f6_arg1.paragonRank )
				end
				if f6_local2 == Enum.eModes.mode_warzone then
					f6_local1 = CoD.WZUtility.GetDecoratedStringForRank( f6_arg1.wzRank, f6_arg1.wzParagonRank, f6_arg1.wzPrestige )
				else
					f6_local1 = tostring( f6_arg1.displayRank )
				end
				if IsGameModeParagonCapable( f6_local2 ) and Engine.GetPrestigeCap( f6_local2 ) <= f6_arg1.prestige then
					f6_arg1.highlightDisplayRankString = true
				end
				if f6_arg1.prestige then
					f6_arg1.rankTitle = CoD.GetRankName( f6_arg1.rank, f6_arg1.prestige )
				else
					f6_arg1.rankTitle = CoD.GetRankName( f6_arg1.rank, 0 )
				end
			end
		end
	end
	local f6_local2 = f6_arg1.team
	if not f6_local2 then
		f6_local2 = 0
	end
	local f6_local3 = f6_arg2[f6_local2]
	if not f6_local3 then
		f6_local3 = 0
	end
	f6_arg2[f6_local2] = f6_local3 + 1
	if f6_arg1.isMemberLeader and f6_arg1.isMemberLeader ~= 0 and 1 < f6_arg0 then
		f6_local3 = 1
		if not f6_local3 then
		
		else
			f6_arg1.isMemberLeader = f6_local3
			if f6_arg1.isMember and f6_arg1.isMember ~= 0 and 1 < f6_arg0 then
				f6_local3 = 1
				if not f6_local3 then
				
				else
					if f6_arg1.isOtherMember then
						local f6_local4 = f6_arg1.isOtherMember
						local f6_local5 = 1
					end
					local f6_local6 = f6_local4 and f6_local5 or 0
					local f6_local7 = Enum.PresenceActivity[@"presence_activity_menu_inlobby"]
					if Engine[@"getlobbynetworkmode"]() ~= Enum.LobbyNetworkMode[@"lobby_networkmode_live"] then
						f6_arg1.isMemberLeader = 0
						f6_arg1.isOtherMember = 0
					end
					if 0 < Dvar[@"ui_lobbydebugvis"]:get() then
						local f6_local8 = f6_arg1.skillRating
						if f6_local8 > 10 then
							f6_local8 = 10
						elseif f6_local8 < -10 then
							f6_local8 = -10
						end
						f6_arg1.gamertag = "s" .. math.floor( f6_local8 * 100 ) .. " " .. f6_arg1.gamertag
					end
					local f6_local8 = ""
					if string.len( f6_arg1.clantag ) > 0 then
						f6_local8 = "[" .. f6_arg1.clantag .. "]"
					end
					local f6_local9, f6_local10 = CoD.ArenaLeaguePlayUtility.GetRubies( f6_arg1.arenaLeaguePlayPoints )
					if IsArenaMode() and (f6_local3 == nil or f6_local3 == 0) and not CoD.ModelUtility.IsGlobalModelValueTrue( "lobbyRoot.lobbyLockedIn" ) and not CoD.LobbyUtility.MapVoteInState( LuaEnum.MAP_VOTE_STATE.RESULT ) then
						Engine[@"restrictvoicechatforclient"]( Enum.LobbyType[@"lobby_type_game"], f6_arg1.xuid )
					end
				end
			end
			f6_local3 = 0
		end
	end
	f6_local3 = 0
end
CoD.DirectorUtility.DirectorPartyListEntryForXUID = function ( f7_arg0, f7_arg1, f7_arg2 )
	local f7_local0 = {}
	local f7_local1 = {}
	local f7_local2 = Engine.GetGlobalModel()
	f7_local1.info = f7_local2.LobbyClients:create( Engine[@"xuidtostring"]( f7_arg1 ) )
	f7_local1.team = f7_arg2
	f7_local1.xuid = f7_arg1
	f7_local1.clientListFlags = 0
	f7_local0.models = f7_local1
	f7_local0.properties = {
		selectIndex = f7_arg0 == f7_arg1
	}
	return f7_local0
end
CoD.DirectorUtility.IsPartyBarTopOrMiddle = function ( f8_arg0 )
	local f8_local0 = f8_arg0:getModel()
	if f8_local0 then
		local f8_local1 = CoD.SafeGetModelValue( f8_local0, "isPartyMemberTopOrMiddle" )
		if not f8_local1 then
			f8_local1 = CoD.SafeGetModelValue( f8_local0, "isOtherMemberTopOrMiddle" )
		end
		return f8_local1
	else
		
	end
end
CoD.DirectorUtility.MaxLobbyPoseMembers = 6
DataSourceHelpers.GlobalDataSourceSetup( "DirectorLobbyPoseMembers", "lobbyRoot.lobbyPoseMembers", function ( f9_arg0, f9_arg1 )
	if not DataSources.DirectorLobbyPoseMembers.__callbackElement then
		local f9_local0 = {}
		for f9_local1 = 1, CoD.DirectorUtility.MaxLobbyPoseMembers, 1 do
			local f9_local4 = f9_arg0:create( "lobbyPoseMember" .. f9_local1 )
			f9_local4:create( "gamertag" )
			f9_local4:create( "clantag" )
			table.insert( f9_local0, f9_local4 )
		end
		local f9_local1 = function ()
			local f10_local0 = Enum.LobbyModule[@"lobby_module_client"]
			local f10_local1 = Engine[@"lobbygetcontrollinglobbysession"]( f10_local0 )
			local f10_local2 = Engine[@"lobbygetsessionclients"]( f10_local0, f10_local1 )
			local f10_local3 = Engine.GetClientNum( Engine.GetPrimaryController() )
			local f10_local4 = {}
			local f10_local5 = CoD.TeamUtility.GetTeam( Engine.GetPrimaryController() )
			for f10_local9, f10_local10 in ipairs( f10_local2.sessionClients ) do
				if f10_local1 ~= Enum.LobbyType[@"lobby_type_game"] or f10_local5 == f10_local10.team then
					if f10_local10.clientNum == f10_local3 then
						table.insert( f10_local4, 1, f10_local10 )
					else
						table.insert( f10_local4, f10_local10 )
					end
				end
			end
			for f10_local9, f10_local10 in ipairs( f9_local0 ) do
				if f10_local9 <= #f10_local4 then
					f10_local10.gamertag:set( f10_local4[f10_local9].gamertag )
					f10_local10.clantag:set( f10_local4[f10_local9].clantag )
				else
					f10_local10.gamertag:set( "" )
					f10_local10.clantag:set( "" )
				end
			end
		end
		
		local f9_local2 = Engine.GetGlobalModel()
		f9_local2 = f9_local2.lobbyRoot
		local self = LUI.UIElement.new()
		DataSources.DirectorLobbyPoseMembers.__callbackElement = self
		self:subscribeToModel( f9_local2.privateClient.update, f9_local1, false )
		self:subscribeToModel( f9_local2.gameClient.update, f9_local1, false )
		self:subscribeToModel( f9_local2.lobbyNav, f9_local1, false )
	end
end )
CoD.DirectorUtility.UpdateLobbyClientInfo = function ( f11_arg0, f11_arg1 )
	DataSources.DirectorPartyList.ClientList = CoD.LobbyUtility.GetClientList()
	DataSources.DirectorPartyList.TeamCounts = {}
	if CoD.isWarzone then
		DataSources.DirectorPartyList.TeamCounts = {
			[Enum.team_t[@"team_allies"]] = 0,
			[Enum.team_t[@"team_axis"]] = 0,
			[Enum.team_t.team_three] = 0,
			[Enum.team_t.team_four] = 0,
			[Enum.team_t.team_five] = 0,
			[Enum.team_t.team_six] = 0
		}
	elseif CoDShared.IsGametypeTeamBased() then
		DataSources.DirectorPartyList.TeamCounts = {
			[Enum.team_t[@"team_spectator"]] = 0,
			[Enum.team_t[@"team_allies"]] = 0,
			[Enum.team_t[@"team_axis"]] = 0
		}
	else
		DataSources.DirectorPartyList.TeamCounts = {
			[Enum.team_t[@"team_spectator"]] = 0,
			[Enum.team_t[@"team_free"]] = 0
		}
	end
	local f11_local0 = f11_arg0:create( "lobbyList" )
	local f11_local1 = f11_local0:create( "playerCount" )
	f11_local1:set( #DataSources.DirectorPartyList.ClientList )
	local f11_local2 = Enum.LobbyModule[@"lobby_module_client"]
	local f11_local3 = Engine[@"getlobbyclientnumbyxuid"]( f11_local2, Engine[@"lobbygetcontrollinglobbysession"]( f11_local2 ), Engine.GetXUID64( Engine.GetPrimaryController() ) )
	if f11_local3 == LuaDefine.INVALID_CLIENT_INDEX then
		f11_local3 = Engine.GetClientNum( Engine.GetPrimaryController() )
	end
	local f11_local4 = {}
	local f11_local5 = Engine[@"getlobbyteamid"]( f11_local2, f11_local3 )
	if IsCodCaster( Engine.GetPrimaryController() ) then
		f11_local5 = CoD.ShoutcasterProfileVarValue( Engine.GetPrimaryController(), "shoutcaster_team" )
	end
	for f11_local9, f11_local10 in ipairs( DataSources.DirectorPartyList.ClientList ) do
		table.insert( f11_local4, f11_local10 )
	end
	f11_local6 = Engine.GetGlobalModel()
	f11_local6 = f11_local6.PartyPrivacy.privacy:get() == Enum.PartyPrivacy[@"party_privacy_closed"]
	f11_local7 = DataSources.LobbyClients.getModel()
	f11_local8 = f11_local7:create( Engine[@"xuidtostring"]( LuaDefine.INVALID_XUID_X64 ) )
	f11_local9 = {}
	for f11_local10 = 1, CoD.PlayerRoleUtility.MAX_SUPPORTED_LOBBY_CLIENTS, 1 do
		local f11_local13 = {
			info = f11_local8,
			xuid = LuaDefine.INVALID_XUID_X64,
			visible = false
		}
		local f11_local14
		if f11_local10 <= f11_arg1 then
			f11_local14 = not f11_local6
		else
			f11_local14 = false
		end
		f11_local13.available = f11_local14
		f11_local9[f11_local10] = f11_local13
	end
	f11_local10 = function ( f12_arg0 )
		local f12_local0 = Engine.GetGlobalModel()
		f12_local0 = f12_local0.LobbyClientPose
		if f12_local0 then
			for f12_local1 = 0, CoD.PlayerRoleUtility.MAX_SUPPORTED_LOBBY_CLIENTS - 1, 1 do
				if f12_local0[f12_local1] and f12_arg0 == f12_local0[f12_local1]:get() then
					return f12_local1 + 1
				end
			end
		end
		return nil
	end
	
	for f11_local13, f11_local14 in ipairs( f11_local4 ) do
		local f11_local20 = Engine[@"xuidtostring"]( f11_local14.xuid )
		local f11_local21 = f11_local10( f11_local20 )
		CoD.DirectorUtility.DirectorPartyListUpdateClientInfo( #f11_local4, f11_local14, DataSources.DirectorPartyList.TeamCounts )
		local f11_local22 = Engine.GetGlobalModel()
		f11_local22 = f11_local22.LobbyClients:create( f11_local20 )
		local f11_local16
		if f11_local14.isMember and f11_local14.isMember ~= 0 and #f11_local4 > 1 then
			f11_local16 = 1
			if not f11_local16 then
			
			else
				local f11_local17 = f11_local22:create( "clantag" )
				f11_local17:set( f11_local14.clantag )
				f11_local17 = f11_local22:create( "isInAParty" )
				f11_local17:set( f11_local14.isInAParty )
				f11_local17 = f11_local22:create( "isLeader" )
				local f11_local18 = f11_local17
				f11_local17 = f11_local17.set
				local f11_local19
				if f11_local14.isLeader == 1 and f11_local16 == 1 then
					f11_local19 = 1
					if not f11_local19 then
					
					else
						f11_local17( f11_local18, f11_local19 )
						f11_local17 = f11_local22:create( "isMemberLeader" )
						f11_local17:set( f11_local14.isMemberLeader )
						f11_local17 = f11_local22:create( "isPartyMember" )
						f11_local17:set( f11_local14.isMember == 1 )
						f11_local17 = f11_local22:create( "isPartyMemberTopOrMiddle" )
						f11_local17:set( f11_local14.isMemberTopOrMiddle == 1 )
						f11_local17 = f11_local22:create( "team" )
						f11_local17:set( f11_local14.team )
						f11_local17 = f11_local22:create( "arenaLeaguePlayFirstSubdivisionRankStreak" )
						f11_local17:set( f11_local14.arenaLeaguePlayFirstSubdivisionRankStreak )
						f11_local17 = f11_local22:create( "arenaLeaguePlayPoints" )
						f11_local17:set( f11_local14.arenaLeaguePlayPoints )
						f11_local17 = CoD.RankUtility.GetCurrentRankMode()
						if f11_local17 == CoD.RankUtility.RankMode.Multiplayer then
							CoD.RankUtility.UpdateMPRankForClient( f11_local14.xuid, f11_local14.displayRank, f11_local14.mpRankIcon, f11_local14.rankTitle, f11_local14.highlightDisplayRankString, true )
						elseif f11_local17 == CoD.RankUtility.RankMode.Warzone then
							CoD.RankUtility.UpdateWZRankForClient( f11_local14.xuid, CoD.WZUtility.GetDecoratedStringForRank( f11_local14.wzRank, f11_local14.wzParagonRank, f11_local14.wzPrestige ), f11_local14.wzRankIcon, f11_local14.rankTitle, f11_local14.highlightDisplayRankString, true )
						elseif f11_local17 == CoD.RankUtility.RankMode.Zombies then
							CoD.RankUtility.UpdateZMRankForClient( f11_local14.xuid, f11_local14.displayRank, f11_local14.zmRankIcon, f11_local14.rankTitle, f11_local14.highlightDisplayRankString, true )
						elseif f11_local17 == CoD.RankUtility.RankMode.Arena then
							CoD.RankUtility.UpdateArenaRankForClient( f11_local14.xuid, f11_local14.displayRank, f11_local14.rankIcon, f11_local14.rankTitle, f11_local14.highlightDisplayRankString, f11_local14.arenaLeaguePlayBestFirstSubdivisionRankStreak, f11_local14.arenaLeaguePlayFirstSubdivisionRankStreak, f11_local14.arenaLeaguePlayPoints, CoD.ArenaLeaguePlayUtility.GetClientSkillDivisionIconSmall( f11_local14.xuid ), true )
						end
						f11_local18 = CoD.RankUtility.GetClientRankInfoModel( f11_local14.xuid )
						f11_local19 = f11_local22:create( "rankInfo" )
						f11_local19:set( f11_local18 )
						if f11_local21 and f11_local7[f11_local21] then
							f11_local9[f11_local21] = {
								info = f11_local22,
								xuid = f11_local14.xuid,
								visible = true,
								available = true
							}
						end
					end
				end
				f11_local19 = 0
			end
		end
		f11_local16 = 0
	end
	for f11_local13, f11_local14 in ipairs( f11_local9 ) do
		local f11_local20 = f11_local7[f11_local13]
		for f11_local17, f11_local18 in pairs( f11_local14 ) do
			f11_local20[f11_local17]:set( f11_local18 )
		end
	end
end
CoD.DirectorUtility.InitLobbyListsOnce = function ( f13_arg0, f13_arg1 )
	if not DataSources.DirectorPartyList._subscriptionElement then
		CoD.DirectorUtility.UpdateLobbyClientInfo( f13_arg0, f13_arg1 )
		DataSources.DirectorPartyList._subscriptionElement = LUI.UIElement.new()
		local f13_local0 = {}
		local f13_local1 = f13_arg0.privateClient.update
		local f13_local2 = f13_arg0.privateClient.count
		local f13_local3 = f13_arg0.gameClient.update
		local f13_local4 = f13_arg0.lobbyNav
		local f13_local5 = f13_arg0.publicLobby.stage
		local f13_local6 = Engine.GetGlobalModel()
		f13_local6 = f13_local6:create( "LobbyClientPose" )
		local f13_local7 = Engine.GetGlobalModel()
		f13_local7 = f13_local7.PartyPrivacy.privacy
		f13_local0[1] = f13_local1
		f13_local0[2] = f13_local2
		f13_local0[3] = f13_local3
		f13_local0[4] = f13_local4
		f13_local0[5] = f13_local5
		f13_local0[6] = f13_local6
		f13_local0[7] = f13_local7
		DataSources.DirectorPartyList._listsToUpdate = {}
		DataSources.DirectorPartyList.OnSubListClose = function ( f14_arg0 )
			if DataSources.DirectorPartyList._listsToUpdate then
				table.remove( DataSources.DirectorPartyList._listsToUpdate, LuaUtils.FindItemInArray( DataSources.DirectorPartyList._listsToUpdate, f14_arg0 ) )
			end
		end
		
		DataSources.DirectorPartyList.OnSubscriptionNotified = function ( f15_arg0 )
			if f15_arg0 == f13_arg0.privateClient.update and (f13_arg0.lobbyMode:get() ~= Enum.LobbyMode[@"lobby_mode_custom"] or Enum.eModes.mode_zombies == Engine.CurrentSessionMode()) then
				return 
			end
			CoD.DirectorUtility.UpdateLobbyClientInfo( f13_arg0, f13_arg1 )
			local f15_local0 = {}
			for f15_local9, f15_local10 in ipairs( DataSources.DirectorPartyList._listsToUpdate or {} ) do
				if f15_local0[f15_local10.customDataSourceHelper] then
					f15_local10[f15_local10.customDataSourceHelper] = f15_local0[f15_local10.customDataSourceHelper]
				end
				local f15_local4 = f15_local10
				local f15_local5 = f15_local10.updateDataSource
				local f15_local6 = nil
				local f15_local7 = true
				local f15_local8
				if not f15_local10._isCustom then
					f15_local8 = f15_local0[f15_local10.customDataSourceHelper]
				else
					f15_local8 = false
				end
				f15_local5( f15_local4, f15_local6, f15_local7, f15_local8 )
				if not f15_local0[f15_local10.customDataSourceHelper] then
					f15_local0[f15_local10.customDataSourceHelper] = f15_local10[f15_local10.customDataSourceHelper]
				end
			end
		end
		
		for f13_local4, f13_local5 in ipairs( f13_local0 ) do
			DataSources.DirectorPartyList._subscriptionElement:subscribeToModel( f13_local5, DataSources.DirectorPartyList.OnSubscriptionNotified, false )
		end
		f13_local1 = f13_arg0.lobbyMode
		f13_local2 = f13_arg0.lobbyMainMode
		DataSources.DirectorPartyList._subscriptionElement:subscribeToModel( f13_local1, function ()
			CoD.RankUtility.UpdateRankModeModel( f13_local1:get(), f13_local2:get() )
		end, false )
		DataSources.DirectorPartyList._subscriptionElement:subscribeToModel( f13_local2, function ()
			CoD.RankUtility.UpdateRankModeModel( f13_local1:get(), f13_local2:get() )
		end )
	end
end
CoD.DirectorUtility.DirectorPartyAndCustomListHelper = function ( f18_arg0, f18_arg1, f18_arg2 )
	local f18_local0 = CoD.BitUtility.IsBitwiseAndNonZero( f18_arg2, CoD.DirectorUtility.DirectorListFlags.IS_CUSTOM )
	local f18_local1 = CoD.BitUtility.IsBitwiseAndNonZero( f18_arg2, CoD.DirectorUtility.DirectorListFlags.SHOW_PARTY )
	local f18_local2 = CoD.BitUtility.IsBitwiseAndNonZero( f18_arg2, CoD.DirectorUtility.DirectorListFlags.SHOW_NON_PARTY )
	local f18_local3 = CoD.BitUtility.IsBitwiseAndNonZero( f18_arg2, CoD.DirectorUtility.DirectorListFlags.SHOW_EMPTY )
	local f18_local4 = CoD.BitUtility.IsBitwiseAndNonZero( f18_arg2, CoD.DirectorUtility.DirectorListFlags.SHOW_FIRST_EMPTY )
	if f18_local4 then
		if not IsLobbyNetworkModeLAN() then
			f18_local4 = not CoD.DirectorUtility.IsMatchmakingInProgress( f18_arg0 )
		else
			f18_local4 = false
		end
	end
	local f18_local5 = Engine.GetGlobalModel()
	f18_arg1.lobbyRootModel = f18_local5.lobbyRoot
	f18_local5 = Engine.GetGlobalModel()
	f18_local5 = f18_local5.LobbyClients:create( Engine[@"xuidtostring"]( LuaDefine.INVALID_XUID_X64 ) )
	if not f18_local5.rank then
		f18_local5:create( "clantag" )
		f18_local5:create( "isInAParty" )
		f18_local5:create( "isLeader" )
		f18_local5:create( "isMemberLeader" )
		f18_local5:create( "isPartyMember" )
		f18_local5:create( "isPartyMemberTopOrMiddle" )
		f18_local5:create( "team" )
		f18_local5:create( "arenaLeaguePlayFirstSubdivisionRankStreak" )
		f18_local5:create( "arenaLeaguePlayPoints" )
	end
	local f18_local6 = CoD.LobbyUtility.GetMaxClientCount()
	CoD.DirectorUtility.InitLobbyListsOnce( f18_arg1.lobbyRootModel, f18_local6 )
	local f18_local7 = DataSources.DirectorPartyList.ClientList
	local f18_local8 = CoDShared.IsGametypeTeamBased()
	local f18_local9 = f18_arg1.lobbyRootModel:create( "localClientTeam" )
	local f18_local10 = f18_arg1.lobbyRootModel:create( "lobbyList" )
	local f18_local11 = f18_local10:create( "maxPlayers" )
	f18_local11:set( f18_local6 )
	f18_arg1._isCustom = f18_local0
	if LuaUtils.FindItemInArray( DataSources.DirectorPartyList._listsToUpdate, f18_arg1 ) == nil then
		table.insert( DataSources.DirectorPartyList._listsToUpdate, f18_arg1 )
		LUI.OverrideFunction_CallOriginalSecond( f18_arg1, "close", DataSources.DirectorPartyList.OnSubListClose )
	end
	local f18_local12 = {}
	local f18_local13 = LobbyData.GetCurrentMenuTarget()
	local f18_local14 = 0
	if f18_local13.name ~= LuaEnum.UI.DIRECTOR_ONLINE and f18_local13.name ~= LuaEnum.UI.DIRECTOR_LAN and f18_local13.name ~= LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC then
		for f18_local18, f18_local19 in ipairs( f18_local7 ) do
			if f18_local19.isMember == 1 then
				f18_local14 = f18_local14 + 1
			end
			if not (not f18_local1 or f18_local19.isMember ~= 1) or f18_local2 and f18_local19.isMember == 0 then
				table.insert( f18_local12, CoD.DirectorUtility.DirectorPartyListEntryForXUID( f18_arg1.menu.selectXUID, f18_local19.xuid, f18_local19.team ) )
				if f18_local19.isLocal == 1 then
					f18_local9:set( f18_local19.team )
				end
			end
		end
	else
		local f18_local15 = -1
		for f18_local19, f18_local20 in ipairs( f18_local7 ) do
			if f18_local20.isMember == 1 then
				f18_local14 = f18_local14 + 1
			end
			if f18_local20.isLocal == 1 then
				f18_local15 = f18_local15 + 1
				f18_local9:set( f18_local20.team )
			end
		end
		for f18_local16 = 0, f18_local15, 1 do
			for f18_local23, f18_local24 in ipairs( f18_local7 ) do
				if f18_local24.isLocal == 1 and f18_local24.localController == f18_local16 and f18_local1 then
					table.insert( f18_local12, CoD.DirectorUtility.DirectorPartyListEntryForXUID( f18_arg1.menu.selectXUID, f18_local24.xuid, f18_local24.team ) )
				end
			end
		end
		for f18_local19, f18_local20 in ipairs( f18_local7 ) do
			if f18_local20.isLocal == 0 and (f18_local13.name ~= LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC or f18_local20.isMember == 1) and f18_local1 then
				table.insert( f18_local12, CoD.DirectorUtility.DirectorPartyListEntryForXUID( f18_arg1.menu.selectXUID, f18_local20.xuid, f18_local20.team ) )
			end
		end
	end
	local f18_local15 = Engine.GetGlobalModel()
	f18_local15 = f18_local15.PartyPrivacy.privacy:get() == Enum.PartyPrivacy[@"party_privacy_closed"]
	if Engine.CurrentSessionMode() == Enum.eModes.mode_warzone or Engine.CurrentSessionMode() == Enum.eModes.mode_zombies then
		Engine.SendClientScriptNotify( f18_arg0, "PositionDraft_Update", {
			localClientNum = Engine.GetLocalClientNum( f18_arg0 )
		} )
	end
	local f18_local16 = {}
	if CoD.isWarzone then
		local f18_local17 = 1
		local f18_local18 = 1
		if IsMaxTeamPlayersEqualTo( 4 ) then
			f18_local17 = 4
			f18_local18 = 0
		elseif IsMaxTeamPlayersEqualTo( 2 ) then
			f18_local17 = 2
			f18_local18 = 2
		end
		f18_local16 = {
			[Enum.team_t[@"team_allies"]] = f18_local17,
			[Enum.team_t[@"team_axis"]] = f18_local17,
			[Enum.team_t.team_three] = f18_local17,
			[Enum.team_t.team_four] = f18_local18,
			[Enum.team_t.team_five] = f18_local18,
			[Enum.team_t.team_six] = f18_local18
		}
	elseif f18_local8 then
		f18_local16 = {
			[Enum.team_t[@"team_spectator"]] = 2,
			[Enum.team_t[@"team_allies"]] = 6,
			[Enum.team_t[@"team_axis"]] = 6
		}
	else
		f18_local16 = {
			[Enum.team_t[@"team_spectator"]] = 2,
			[Enum.team_t[@"team_free"]] = 12
		}
	end
	local f18_local17 = nil
	if f18_local0 or not Engine.SessionModeIsMode( Enum[@"enetworkmodes"][@"mode_network_online"] ) then
		f18_local17 = Engine[@"getlobbymaxclients"]( Enum.LobbyModule[@"lobby_module_client"], Enum.LobbyType[@"lobby_type_private"] )
	else
		local f18_local18 = Engine[@"getplaylistinfobyid"]( Engine[@"getplaylistid"]() )
		f18_local17 = f18_local18.maxPlayers
	end
	local f18_local18 = 0
	for f18_local22, f18_local23 in pairs( DataSources.DirectorPartyList.TeamCounts ) do
		f18_local18 = f18_local18 + f18_local23
	end
	f18_local19 = true
	if (f18_local3 or f18_local4) and f18_local1 and f18_local18 < f18_local6 and not f18_local15 then
		for f18_local23, f18_local24 in pairs( DataSources.DirectorPartyList.TeamCounts ) do
			if f18_local4 and not f18_local19 then
				break
			elseif f18_local8 or f18_local23 == Enum.team_t[@"team_spectator"] or f18_local23 == Enum.team_t[@"team_free"] then
				local f18_local25 = f18_local16[f18_local23]
				if not f18_local25 then
					f18_local25 = 0
				end
				if f18_local24 < f18_local25 then
					table.insert( f18_local12, {
						models = {
							info = f18_local5,
							team = f18_local23,
							xuid = LuaDefine.INVALID_XUID_X64,
							clientListFlags = CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY
						}
					} )
					f18_local19 = false
					f18_local18 = f18_local18 + 1
				end
			end
		end
	end
	if f18_local3 and f18_local0 and f18_local1 then
	
	else
		if f18_local3 and not f18_local1 then
			if f18_local17 > 12 then
				f18_local17 = 12
			end
			f18_local18 = #f18_local7
			while f18_local18 < f18_local17 do
				f18_local20 = table.insert
				f18_local21 = f18_local12
				f18_local22 = {}
				f18_local23 = {
					info = f18_local5,
					team = 0,
					xuid = LuaDefine.INVALID_XUID_X64
				}
				local f18_local24
				if f18_local19 then
					f18_local24 = CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY
					if not f18_local24 then
					
					else
						f18_local23.clientListFlags = f18_local24
						f18_local22.models = f18_local23
						f18_local20( f18_local21, f18_local22 )
						f18_local18 = f18_local18 + 1
					end
				end
				f18_local24 = 0
			end
		end
		f18_arg1.menu.selectXUID = nil
		if #f18_local12 == 1 or #f18_local12 == 2 and CoD.BitUtility.IsBitwiseAndNonZero( f18_local12[2].models.clientListFlags, CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY ) then
			f18_local12[1].models.clientListFlags = CoD.DirectorUtility.ClientListFlags.SHOW_EXPANDED
		end
		return f18_local12
	end
	while f18_local18 < f18_local17 do
		f18_local20 = table.insert
		f18_local21 = f18_local12
		f18_local22 = {}
		f18_local23 = {
			info = f18_local5,
			team = 0,
			xuid = LuaDefine.INVALID_XUID_X64
		}
		local f18_local24
		if f18_local19 then
			f18_local24 = CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY
			if not f18_local24 then
			
			else
				f18_local23.clientListFlags = f18_local24
				f18_local22.models = f18_local23
				f18_local20( f18_local21, f18_local22 )
				f18_local18 = f18_local18 + 1
			end
		end
		f18_local24 = 0
	end
	if f18_local3 and not f18_local1 then
		if f18_local17 > 12 then
			f18_local17 = 12
		end
		f18_local18 = #f18_local7
		while f18_local18 < f18_local17 do
			f18_local20 = table.insert
			f18_local21 = f18_local12
			f18_local22 = {}
			f18_local23 = {
				info = f18_local5,
				team = 0,
				xuid = LuaDefine.INVALID_XUID_X64
			}
			local f18_local24
			if f18_local19 then
				f18_local24 = CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY
				if not f18_local24 then
				
				else
					f18_local23.clientListFlags = f18_local24
					f18_local22.models = f18_local23
					f18_local20( f18_local21, f18_local22 )
					f18_local18 = f18_local18 + 1
				end
			end
			f18_local24 = 0
		end
	end
	f18_arg1.menu.selectXUID = nil
	if #f18_local12 == 1 or #f18_local12 == 2 and CoD.BitUtility.IsBitwiseAndNonZero( f18_local12[2].models.clientListFlags, CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY ) then
		f18_local12[1].models.clientListFlags = CoD.DirectorUtility.ClientListFlags.SHOW_EXPANDED
	end
	return f18_local12
end
CoD.DirectorUtility.DirectorListFlags = LuaEnum.createBitFieldEnum( "IS_CUSTOM", "SHOW_PARTY", "SHOW_NON_PARTY", "SHOW_EMPTY", "SHOW_FIRST_EMPTY" )
DataSources.DirectorPartyList = DataSourceHelpers.ListSetup( "DirectorPartyList", function ( f19_arg0, f19_arg1 )
	return CoD.DirectorUtility.DirectorPartyAndCustomListHelper( f19_arg0, f19_arg1, CoD.DirectorUtility.DirectorListFlags.SHOW_PARTY )
end, true )
DataSources.DirectorPartyListWithEmpty = DataSourceHelpers.ListSetup( "DirectorPartyListWithEmpty", function ( f20_arg0, f20_arg1 )
	return CoD.DirectorUtility.DirectorPartyAndCustomListHelper( f20_arg0, f20_arg1, CoD.DirectorUtility.DirectorListFlags.SHOW_PARTY | CoD.DirectorUtility.DirectorListFlags.SHOW_EMPTY )
end, true )
DataSources.DirectorPartyListWithFirstEmpty = DataSourceHelpers.ListSetup( "DirectorPartyListWithFirstEmpty", function ( f21_arg0, f21_arg1 )
	return CoD.DirectorUtility.DirectorPartyAndCustomListHelper( f21_arg0, f21_arg1, CoD.DirectorUtility.DirectorListFlags.SHOW_PARTY | CoD.DirectorUtility.DirectorListFlags.SHOW_FIRST_EMPTY )
end, true )
DataSources.DirectorPartyListHorizontal = DataSourceHelpers.ListSetup( "DirectorPartyListHorizontal", function ( f22_arg0, f22_arg1 )
	return CoD.DirectorUtility.DirectorPartyAndCustomListHelper( f22_arg0, f22_arg1, CoD.DirectorUtility.DirectorListFlags.SHOW_PARTY | CoD.DirectorUtility.DirectorListFlags.SHOW_FIRST_EMPTY )
end, true, {
	getWidgetTypeForItem = function ( f23_arg0, f23_arg1, f23_arg2 )
		if f23_arg2 == 1 then
			return CoD.DirectorLobbyMember
		else
			return CoD.DirectorLobbyMemberNeverExpand
		end
	end
} )
DataSources.DirectorPartyListCustom = DataSourceHelpers.ListSetup( "DirectorPartyListCustom", function ( f24_arg0, f24_arg1 )
	return CoD.DirectorUtility.DirectorPartyAndCustomListHelper( f24_arg0, f24_arg1, CoD.DirectorUtility.DirectorListFlags.IS_CUSTOM | CoD.DirectorUtility.DirectorListFlags.SHOW_PARTY | CoD.DirectorUtility.DirectorListFlags.SHOW_NON_PARTY | CoD.DirectorUtility.DirectorListFlags.SHOW_EMPTY )
end, true, nil, function ( f25_arg0, f25_arg1, f25_arg2 )
	if not f25_arg1.__directorPartyListCustomSubscriptions then
		f25_arg1.__directorPartyListCustomSubscriptions = true
		local f25_local0 = f25_arg1
		local f25_local1 = f25_arg1.subscribeToModel
		local f25_local2 = Engine.GetGlobalModel()
		f25_local1( f25_local0, f25_local2.MapVote.mapVoteGameModeNext, function ( f26_arg0 )
			f25_arg1:updateDataSource( false, false )
		end )
	end
end )
DataSources.DirectorLobbyNonPartyList = DataSourceHelpers.ListSetup( "DirectorLobbyNonPartyList", function ( f27_arg0, f27_arg1 )
	return CoD.DirectorUtility.DirectorPartyAndCustomListHelper( f27_arg0, f27_arg1, CoD.DirectorUtility.DirectorListFlags.SHOW_NON_PARTY | CoD.DirectorUtility.DirectorListFlags.SHOW_EMPTY )
end, true )
DataSources.DirectorLobbyListAll = DataSourceHelpers.ListSetup( "DirectorLobbyListAll", function ( f28_arg0, f28_arg1 )
	return CoD.DirectorUtility.DirectorPartyAndCustomListHelper( f28_arg0, f28_arg1, CoD.DirectorUtility.DirectorListFlags.SHOW_PARTY | CoD.DirectorUtility.DirectorListFlags.SHOW_NON_PARTY )
end, true )
CoD.DirectorUtility.PlaylistIDToPlaylistName = function ( f29_arg0 )
	if not IsLobbyNetworkModeLive() then
		return 0x0
	end
	local f29_local0 = Engine[@"getplaylistinfobyid"]( f29_arg0 )
	local f29_local1
	if f29_local0 then
		f29_local1 = f29_local0.name
		if not f29_local1 then
		
		else
			return f29_local1
		end
	end
	f29_local1 = 0x0
end
CoD.DirectorUtility.PlaylistIDToPlaylistIcon = function ( f30_arg0 )
	if not IsLobbyNetworkModeLive() then
		return "blacktransparent"
	end
	local f30_local0 = Engine[@"getplaylistinfobyid"]( f30_arg0 )
	local f30_local1
	if f30_local0 then
		f30_local1 = f30_local0.image
		if not f30_local1 then
		
		else
			return f30_local1
		end
	end
	f30_local1 = "blacktransparent"
end
CoD.DirectorUtility.PlaylistIDToPlaylistImage = function ( f31_arg0 )
	if not IsLobbyNetworkModeLive() then
		return "blacktransparent"
	end
	local f31_local0 = Engine[@"getplaylistinfobyid"]( f31_arg0 )
	local f31_local1
	if f31_local0 then
		f31_local1 = f31_local0.imageBackground
		if not f31_local1 then
		
		else
			return f31_local1
		end
	end
	f31_local1 = "blacktransparent"
end
CoD.DirectorUtility.PlaylistIDToPlaylistImageTileSideInfo = function ( f32_arg0 )
	if not IsLobbyNetworkModeLive() then
		return "blacktransparent"
	else
		local f32_local0 = Engine[@"getplaylistinfobyid"]( f32_arg0 )
		if f32_local0 then
			local f32_local1 = f32_local0.imageTileSideInfo
			if not f32_local1 then
				f32_local1 = f32_local0.imageBackground or "blacktransparent"
			end
			return f32_local1
		else
			return "blacktransparent"
		end
	end
end
CoD.DirectorUtility.PlaylistIDToPlaylistImageTileSmall = function ( f33_arg0 )
	if not IsLobbyNetworkModeLive() then
		return "blacktransparent"
	else
		local f33_local0 = Engine[@"getplaylistinfobyid"]( f33_arg0 )
		if f33_local0 then
			local f33_local1 = f33_local0.imageTileSmall
			if not f33_local1 then
				f33_local1 = f33_local0.imageBackground or "blacktransparent"
			end
			return f33_local1
		else
			return "blacktransparent"
		end
	end
end
CoD.DirectorUtility.IsPlaylistGametype = function ( f34_arg0, f34_arg1 )
	if not IsLobbyNetworkModeLive() then
		return false
	elseif #f34_arg0.rotationList > 0 then
		local f34_local0 = Engine[@"hash_1F2CD89B3C345FD3"]( f34_arg0.rotationList[1].gametype )
		if f34_local0 then
			return f34_local0.gametype == f34_arg1
		end
	end
	return false
end
CoD.DirectorUtility.PlaylistIDToZMPlaylistImage = function ( f35_arg0 )
	if not IsLobbyNetworkModeLive() then
		return "blacktransparent"
	else
		local f35_local0 = Engine[@"getplaylistinfobyid"]( f35_arg0 )
		if f35_local0 then
			if f35_local0.isQuickplayCard then
				return f35_local0.imageTileLarge or "blacktransparent"
			elseif f35_local0.featured then
				local f35_local1 = f35_local0.imageTileSideInfo
				if not f35_local1 then
					f35_local1 = f35_local0.imageBackground or "blacktransparent"
				end
				return f35_local1
			elseif not f35_local0.excludePublicLobby or CoD.DirectorUtility.IsPlaylistGametype( f35_local0, "ztutorial" ) then
				return f35_local0.imageTileLarge or "blacktransparent"
			else
				return f35_local0.imageTileSmall or "blacktransparent"
			end
		else
			return "blacktransparent"
		end
	end
end
CoD.DirectorUtility.PlaylistIDToZMPlaylistName = function ( f36_arg0 )
	if not IsLobbyNetworkModeLive() then
		return 0x0
	end
	local f36_local0 = Engine[@"getplaylistinfobyid"]( f36_arg0 )
	if f36_local0 then
		if not f36_local0.excludePublicLobby or #f36_local0.rotationList > 1 or CoD.DirectorUtility.IsPlaylistGametype( f36_local0, "ztutorial" ) then
			return f36_local0.name or 0x0
		elseif #f36_local0.rotationList > 0 then
			local f36_local1 = f36_local0.rotationList[1].map
			if CoD.DirectorUtility.IsPlaylistGametype( f36_local0, "ztrials" ) then
				return CoD.MapUtility.GetMapValue( f36_local1, CoD.ZombieUtility.GetTrialMapNameFieldName( CoD.ZombieUtility.GetZMPlaylistTrialVariant( f36_local0 ) ), 0x0 )
			else
				return CoD.MapUtility.GetMapValue( f36_local1, "mapName", 0x0 )
			end
		end
	end
	return 0x0
end
CoD.DirectorUtility.PlaylistIDToZMPlaylistSubtitle = function ( f37_arg0 )
	if not IsLobbyNetworkModeLive() then
		return 0x0
	end
	local f37_local0 = Engine[@"getplaylistinfobyid"]( f37_arg0 )
	if f37_local0 and f37_local0.excludePublicLobby and not CoD.DirectorUtility.IsPlaylistGametype( f37_local0, "ztutorial" ) then
		local f37_local1 = Engine[@"hash_1F2CD89B3C345FD3"]( f37_local0.rotationList[1].gametype )
		if f37_local1 then
			return CoD.GameTypeUtility.GameTypeToLocalizeToUpperName( f37_local1.gametype )
		end
	end
	return 0x0
end
CoD.DirectorUtility.PlaylistIDToZMPlaylistDifficulty = function ( f38_arg0 )
	if not IsLobbyNetworkModeLive() then
		return "blacktransparent"
	else
		local f38_local0 = Engine[@"getplaylistinfobyid"]( f38_arg0 )
		if f38_local0 and f38_local0.excludePublicLobby and CoD.DirectorUtility.IsPlaylistGametype( f38_local0, "zclassic" ) and CoD.ZombieUtility then
			local f38_local1 = {
				"ui_icon_difficulty_zm_casual_large",
				"ui_icon_difficulty_zm_normal_large",
				"ui_icon_difficulty_zm_hardcore_large",
				"ui_icon_difficulty_zm_realistic_large"
			}
			return f38_local1[CoD.ZombieUtility.GetZMPlaylistDifficulty( f38_local0 ) + 1]
		else
			return "blacktransparent"
		end
	end
end
CoD.DirectorUtility.PlaylistIDToPlaylistDesc = function ( f39_arg0 )
	if not IsLobbyNetworkModeLive() then
		return ""
	end
	local f39_local0 = Engine[@"getplaylistinfobyid"]( f39_arg0 )
	local f39_local1
	if f39_local0 then
		f39_local1 = f39_local0.description
		if not f39_local1 then
		
		else
			return f39_local1
		end
	end
	f39_local1 = ""
end
CoD.DirectorUtility.SetPlaylist = function ( f40_arg0, f40_arg1 )
	Engine[@"setplaylistid"]( f40_arg1.playlistID )
	LuaUtils.SetQuickplayPlaylistID( f40_arg1.playlistID )
	CoD.DirectorUtility.SaveCurrentPlaylistForMainMode( f40_arg0 )
end
CoD.DirectorUtility.UpdateChosenPlaylist = function ( f41_arg0 )
	Engine[@"lobbyevent"]( "OnGameLobbyGameServerDataUpdate", {} )
end
CoD.DirectorUtility.DifficultyToLocalizedDifficultyName = function ( f42_arg0 )
	if f42_arg0 == -1 then
		return 0x0
	else
		return Engine.ToUpper( CoD.ZombieUtility.GetDifficultyText( f42_arg0 ) )
	end
end
CoD.DirectorUtility.GetCustomGamesName = function ( f43_arg0 )
	if IsZombies() then
		return "menu/custom_mutations"
	else
		return f43_arg0
	end
end
CoD.DirectorUtility.TrialsMapEnabledDvars = {
	zm_orange = @"hash_23B9C106CFCDE18B"
}
DataSources.DirectorMapList = DataSourceHelpers.ListSetup( "DirectorMapList", function ( f44_arg0, f44_arg1 )
	local f44_local0 = {}
	local f44_local1 = LobbyData.GetCurrentMenuTarget()
	CoD.perController[f44_arg0].mapCategory = 0
	local f44_local2 = {}
	local f44_local3 = {
		zclassic = @"hash_4B1B381DE2ADC014",
		ztrials = @"hash_37EEA154A1D4F3C1",
		zgrief = 0x4F1EA0CA4EC9E3,
		zstandard = @"hash_5154C514171FEE9",
		ztcm = @"hash_D126B224D84608C",
		ztutorial = @"hash_674923AD245EF8BE"
	}
	local f44_local4 = function ( f45_arg0 )
		return f44_local2[f45_arg0] ~= nil
	end
	
	local f44_local5 = nil
	f44_local5 = function ( f46_arg0, f46_arg1 )
		return CoD.MapUtility.MapsTable[f46_arg0].uniqueID < CoD.MapUtility.MapsTable[f46_arg1].uniqueID
	end
	
	local f44_local6 = function ( f47_arg0 )
		if CoD.gameModeEnum ~= CoD.MapUtility.MapsTable[f47_arg0].session_mode then
			return false
		elseif not Engine.IsMapValid( f47_arg0 ) then
			return false
		end
		local f47_local0 = Engine.GetGlobalModel()
		f47_local0 = f47_local0:create( "lobbyRoot.selectedGameType" )
		f47_local0 = f47_local0:get()
		if CoD.MapUtility.MapsTable[f47_arg0][f44_local3[f47_local0]] == 1 then
			if f47_local0 == "ztrials" then
				local f47_local1 = CoD.DirectorUtility.TrialsMapEnabledDvars[f47_arg0]
				if not f47_local1 or not IsBooleanDvarSet( f47_local1 ) then
					return false
				end
			else
				return false
			end
		end
		local f47_local1 = false
		local f47_local2 = LobbyData.GetCurrentMenuTarget()
		if f47_local2.name == LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY then
			f47_local1 = CoD.MapUtility.MapsTable[f47_arg0].dlc_pack == 4
		else
			f47_local1 = CoD.MapUtility.MapsTable[f47_arg0].dlc_pack > -1
		end
		if Dvar[@"ui_execdemo"]:get() and f47_local1 then
			f47_local1 = isMapInDemo( f47_arg0 )
		end
		if Engine[@"hash_77D47312EBA41751"]() and f47_local1 then
			f47_local1 = f44_local4( f47_arg0 )
		end
		if f47_local2.LobbyMode == Enum.LobbyMode[@"hash_3B3A1BBF18C0B176"] and CoD.MapUtility.MapsTable[f47_arg0][@"combattrainingenabled"] ~= 1 then
			return false
		elseif CoD.MapUtility.MapsTable[f47_arg0].isSubLevel then
			return false
		end
		return f47_local1
	end
	
	local f44_local7 = Engine.SessionModeIsMode( Enum[@"enetworkmodes"][@"mode_network_offline"] )
	local f44_local8 = 1
	local f44_local9 = Engine[@"converttoxhash"]( Engine[@"lobbygetmap"]() )
	if f44_local7 == false then
		local f44_local10 = false
		for f44_local26, f44_local27 in LUI.IterateTableBySortedKeys( CoD.MapUtility.MapsTable, f44_local5, f44_local6 ) do
			if f44_local27.mapName == nil then
				LuaUtils.UI_ShowErrorMessageDialog( f44_arg0, "Map Name field for " .. f44_local26 .. " cannot be empty" )
			end
			local f44_local14 = f44_local26 == f44_local9
			if not f44_local10 then
				f44_local10 = f44_local14
			end
			local f44_local15 = f44_local27.mapDescription and CoD.StoreUtility.AddUpsellToDescriptionIfNeeded( f44_arg0, f44_local26, Engine[@"hash_4F9F1239CFD921FE"]( f44_local27.mapDescription ) ) or ""
			if CoD.DirectorUtility.IsOfflineOnlyDemo() then
				f44_local15 = nil
			end
			local f44_local16 = Engine.GetGlobalModel()
			f44_local16 = f44_local16:create( "lobbyRoot.selectedGameType" )
			local f44_local17 = 0
			if f44_local16 and f44_local16:get() == "ztrials" then
				local f44_local18 = CoD.MapUtility.GetMapValue( f44_local26, @"hash_4C3A04783CB1D6BE", 0x0 )
				if f44_local18 ~= 0x0 then
					f44_local17 = Engine[@"getdvarint"]( f44_local18 ) or 0
				end
				f44_local17 = math.min( f44_local17, CoD.MapUtility.GetMapValue( f44_local26, @"hash_64D5E4CA4AC8AFEB", 0 ) )
			end
			for f44_local18 = 0, f44_local17, 1 do
				if f44_local16 and f44_local16:get() == "ztrials" then
					local f44_local21 = Engine.GetGlobalModel()
					f44_local21 = f44_local21:create( "localZMTrialVariant" )
					if f44_local14 then
						local f44_local22 = f44_local21:get()
						if not f44_local22 then
							f44_local22 = 0
						end
						f44_local14 = f44_local18 == f44_local22
					end
					if not f44_local10 then
						f44_local10 = f44_local14
					end
				end
				local f44_local21 = table.insert
				local f44_local22 = f44_local0
				local f44_local23 = {
					models = {
						id = f44_local26,
						name = 0x0,
						text = Engine.Localize( f44_local27.mapName ),
						buttonText = Engine.Localize( CoD.StoreUtility.PrependPurchaseIconIfNeeded( f44_arg0, f44_local26, f44_local27.mapName ) ),
						image = f44_local27.previewImage,
						difficulty = 1,
						trialVariant = f44_local18
					}
				}
				local f44_local24 = {
					mapName = f44_local26,
					selectIndex = f44_local14
				}
				local f44_local25 = Engine[@"hash_77D47312EBA41751"]()
				if not f44_local25 then
					f44_local25 = Engine[@"hash_5CB675CA7856DA25"]()
				end
				f44_local24.disabled = f44_local25
				f44_local24.purchasable = not Engine.IsMapValid( f44_local26 )
				f44_local23.properties = f44_local24
				f44_local21( f44_local22, f44_local23 )
				if f44_local14 then
					Engine.SetGametypeSetting( "zmTrialsVariant", f44_local18 )
					CoD.ZombieUtility.SetLocalZMTrialVariantModel( f44_local18 )
					f44_local21 = Engine[@"lobbygetcontrollinglobbysession"]( Enum.LobbyModule[@"lobby_module_host"] )
					Engine[@"lobbyevent"]( "OnGametypeSettingsChange", {
						lobbyModule = Enum.LobbyModule[@"lobby_module_host"],
						lobbyType = f44_local21,
						fromUI = true
					} )
					Engine[@"lobbyhostsessionsetdirty"]( f44_local21, Enum.SessionDirty[@"session_dirty_state"] )
				end
			end
		end
		if not f44_local10 and #f44_local0 > 0 then
			SetMap( f44_arg0, CoD.MapUtility.MapsTable[f44_local0[1].properties.mapName].mapToLoad, false )
			f44_local0[1].properties.selectIndex = true
			Engine.SetGametypeSetting( "zmTrialsVariant", f44_local0[1].models.trialVariant )
			CoD.ZombieUtility.SetLocalZMTrialVariantModel( f44_local0[1].models.trialVariant )
			f44_local11 = Engine[@"lobbygetcontrollinglobbysession"]( Enum.LobbyModule[@"lobby_module_host"] )
			Engine[@"lobbyevent"]( "OnGametypeSettingsChange", {
				lobbyModule = Enum.LobbyModule[@"lobby_module_host"],
				lobbyType = f44_local11,
				fromUI = true
			} )
			Engine[@"lobbyhostsessionsetdirty"]( f44_local11, Enum.SessionDirty[@"session_dirty_state"] )
		end
	end
	local f44_local10 = Engine.GetGlobalModel()
	f44_local10 = f44_local10:create( "lobbyRoot.selectedGameType" )
	if f44_local10 and f44_local10:get() == "ztutorial" then
		local f44_local11 = {}
		local f44_local12 = Engine.GetGametypeSetting( "zmdifficulty" )
		local f44_local13 = {
			@"hash_364122F25F791280",
			@"hash_C9580DAB628ED90"
		}
		local f44_local26 = false
		for f44_local27 = 1, #f44_local0, 1 do
			local f44_local17 = f44_local0[f44_local27]
			for f44_local18 = 0, 1, 1 do
				local f44_local21
				if f44_local17.models.id ~= f44_local9 or f44_local18 ~= f44_local12 then
					f44_local21 = false
				else
					f44_local21 = true
				end
				if not f44_local26 then
					f44_local26 = f44_local21
				end
				table.insert( f44_local11, {
					models = {
						id = f44_local17.models.id,
						name = f44_local13[f44_local18 + 1],
						text = f44_local17.models.text,
						buttonText = f44_local17.models.buttonText,
						image = f44_local17.models.image,
						difficulty = f44_local18
					},
					properties = {
						mapName = f44_local17.properties.mapName,
						selectIndex = f44_local21,
						disabled = f44_local17.properties.disabled,
						purchasable = f44_local17.properties.purchasable
					}
				} )
			end
		end
		if not f44_local26 then
			f44_local11[1].properties.selectIndex = true
		end
		f44_local0 = f44_local11
	end
	return f44_local0
end, true )
DataSources.CustomGamesMapModeTabs = DataSourceHelpers.ListSetup( "CustomGamesMapModeTabs", function ( f48_arg0, f48_arg1 )
	local f48_local0 = "CoD.DirectorChooseGameTypeFrame"
	if IsZombies() then
		f48_local0 = "CoD.DirectorChooseGameTypeFrameZM"
	elseif IsWarzone() then
		f48_local0 = "CoD.DirectorChooseGameTypeFrameWZ"
	end
	local f48_local1 = {}
	table.insert( f48_local1, {
		models = {
			tabName = "mpui/gamemode_caps",
			frameWidget = f48_local0
		}
	} )
	if not IsWarzone() then
		table.insert( f48_local1, {
			models = {
				tabName = @"hash_357456FA52303FCB",
				frameWidget = "CoD.DirectorChooseMapFrame"
			}
		} )
	end
	return f48_local1
end, true )
DataSourceHelpers.PerControllerDataSourceSetup( "MapModePreview", "MapModePreview", function ( f49_arg0, f49_arg1 )
	local f49_local0 = f49_arg0:create( "mapName" )
	f49_local0:set( Engine[@"converttoxhash"]( Engine[@"lobbygetmap"]() ) )
	f49_local0 = f49_arg0:create( "modeName" )
	f49_local0:set( Dvar.g_gametype:get() )
end, true )
CoD.DirectorUtility.CombatTrainingGameTypes = {
	"ct_recon",
	"ct_ruin",
	"ct_firebreak",
	"ct_nomad",
	"ct_battery",
	"ct_prophet",
	"ct_seraph",
	"ct_crash",
	"ct_torque",
	"ct_ajax"
}
CoD.DirectorUtility.IsGameTypeCombatTraining = function ( f50_arg0 )
	for f50_local3, f50_local4 in ipairs( CoD.DirectorUtility.CombatTrainingGameTypes ) do
		if f50_local4 == f50_arg0 then
			return true
		end
	end
	return false
end
DataSources.DirectorGameTypeList = DataSourceHelpers.ListSetup( "DirectorGameTypeList", function ( f51_arg0, f51_arg1 )
	local f51_local0 = {}
	local f51_local1 = Engine.CreateModel( Engine.CreateModel( Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot" ), "lobbyList" ), "playerCount" )
	local f51_local2 = Engine.GetModelValue( f51_local1 ) or 0
	local f51_local3 = LobbyData.GetCurrentMenuTarget()
	local f51_local4 = Engine.GetGametypesBase()
	local f51_local5 = Engine[@"lobbygetgametype"]()
	if f51_local3.LobbyMode == Enum.LobbyMode[@"hash_3B3A1BBF18C0B176"] then
		for f51_local9, f51_local10 in ipairs( CoD.DirectorUtility.CombatTrainingGameTypes ) do
			local f51_local11 = Engine[@"getgametypeinfo"]( f51_local10 )
			table.insert( f51_local0, {
				models = {
					id = f51_local10,
					name = f51_local11.name,
					detailedDesc = f51_local11.descriptionRef and Engine[@"hash_4F9F1239CFD921FE"]( f51_local11.descriptionRef ) or "",
					tooltipArchetype = CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE,
					available = true
				},
				properties = {
					selectIndex = f51_local10 == f51_local5
				}
			} )
		end
	else
		local f51_local6 = function ( f52_arg0, f52_arg1 )
			local f52_local0 = {}
			if f52_arg0 == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
				f52_local0 = {
					"zclassic",
					"zstandard",
					"ztrials",
					"ztcm",
					"ztutorial"
				}
			end
			for f52_local4, f52_local5 in ipairs( f52_local0 ) do
				if f52_local5 == f52_arg1 then
					return f52_local4
				end
			end
			return #f52_local0 + 1
		end
		
		for f51_local10, f51_local11 in pairs( f51_local4 ) do
			if f51_local11.category == "standard" or f51_local3[@"mainmode"] == Enum.LobbyMainMode[@"lobby_mainmode_cp"] or f51_local3[@"mainmode"] == Enum.LobbyMainMode[@"lobby_mainmode_zm"] and f51_local11.category ~= "hidden" then
				local f51_local12 = Engine[@"getgametypeinfo"]( f51_local11.gametype )
				local f51_local13 = Engine[@"converttoxhash"]( f51_local11.gametype )
				local f51_local14 = Engine[@"converttoxhash"]( f51_local12.groupName )
				if f51_local3.LobbyMode ~= Enum.LobbyMode[@"lobby_mode_custom"] or f51_local3[@"mainmode"] ~= Enum.LobbyMainMode[@"lobby_mainmode_zm"] or f51_local13 == "zclassic" or IsLobbyNetworkModeLAN() and not CoD.DirectorUtility.IsOfflineScreenStateCustomGame() then
					if f51_local14 ~= "ztcm" and (f51_local13 ~= "ztrials" or not IsBooleanDvarSet( 0x431CAAEFB37761 ) and f51_local13 == "ztrials") and (f51_local13 ~= "ztutorial" or f51_local13 == "ztutorial" and f51_local2 == 1) then
						table.insert( f51_local0, {
							models = {
								id = f51_local11.gametype,
								name = f51_local11.name,
								detailedDesc = f51_local12.descriptionRef and Engine[@"hash_4F9F1239CFD921FE"]( f51_local12.descriptionRef ) or "",
								tooltipArchetype = CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE,
								available = true
							},
							properties = {
								selectIndex = f51_local11.gametype == f51_local5,
								sortIndex = f51_local6( f51_local3[@"mainmode"], f51_local13 )
							}
						} )
					end
				end
			end
		end
		table.sort( f51_local0, function ( f53_arg0, f53_arg1 )
			if not f53_arg0.properties.sortIndex or not f53_arg1.properties.sortIndex then
				return not f53_arg1.properties.sortIndex
			else
				return f53_arg0.properties.sortIndex < f53_arg1.properties.sortIndex
			end
		end )
	end
	if f51_arg1.playerCountSubscription == nil then
		f51_arg1.playerCountSubscription = f51_arg1:subscribeToModel( f51_local1, function ()
			f51_arg1:updateDataSource()
		end, false )
	end
	return f51_local0
end, true )
CoD.DirectorUtility.GetCombatTrainingMapIterator = function ()
	return LUI.IterateTableBySortedKeys( CoD.mapsTable, function ( f56_arg0, f56_arg1 )
		return CoD.mapsTable[f56_arg0].uniqueID < CoD.mapsTable[f56_arg1].uniqueID
	end
	, function ( f57_arg0 )
		local f57_local0
		if CoD.mapsTable[f57_arg0].session_mode ~= Enum.eModes.mode_multiplayer or CoD.mapsTable[f57_arg0][@"combattrainingenabled"] ~= 1 then
			f57_local0 = false
		else
			f57_local0 = true
		end
		return f57_local0
	end
	 )
end
DataSources.DirectorSuggestedActivities = DataSourceHelpers.ListSetup( "DirectorSuggestedActivities", function ( f58_arg0, f58_arg1 )
	local f58_local0 = Engine.GetGlobalModel()
	f58_local0 = f58_local0.LobbyClients
	if not f58_arg1._lobbyMembersChangedSubscription then
		f58_arg1._lobbyMembersChangedSubscription = f58_arg1:subscribeToModel( f58_local0.membersChanged, function ()
			f58_arg1:updateDataSource()
		end, false )
	end
	if f58_arg1._lobbyMembersSuggestionSubscriptions ~= nil and #f58_arg1._lobbyMembersSuggestionSubscriptions > 0 then
		for f58_local4, f58_local5 in ipairs( f58_arg1._lobbyMembersSuggestionSubscriptions ) do
			f58_arg1:removeSubscription( f58_local5 )
		end
	end
	f58_arg1._lobbyMembersSuggestionSubscriptions = {}
	local f58_local1 = Engine[@"hash_38020859DF7AAF7B"]( Enum.LobbyModule[@"lobby_module_client"], Enum.LobbyType[@"lobby_type_private"] )
	local f58_local2 = {}
	for f58_local6, f58_local7 in ipairs( f58_local1 ) do
		local f58_local8 = f58_local0[Engine[@"xuidtostring"]( f58_local7 )].playerSuggestion
		table.insert( f58_arg1._lobbyMembersSuggestionSubscriptions, f58_arg1:subscribeToModel( f58_local8, function ()
			f58_arg1:updateDataSource()
		end, false ) )
		local f58_local9 = f58_local8:get()
		if f58_local9 ~= nil and f58_local9 ~= 0 then
			if f58_local2[f58_local9] == nil then
				f58_local2[f58_local9] = {
					f58_local7
				}
			else
				table.insert( f58_local2[f58_local9], f58_local7 )
			end
		end
	end
	f58_local3 = {}
	f58_local4 = 1
	for f58_local8, f58_local9 in pairs( f58_local2 ) do
		local f58_local10 = "DirectorSuggestedActivities_" .. f58_local4
		DataSources[f58_local10] = DataSourceHelpers.ListSetup( f58_local10, function ( f61_arg0, f61_arg1 )
			local f61_local0 = {}
			for f61_local4, f61_local5 in ipairs( f58_local9 ) do
				table.insert( f61_local0, {
					models = {
						xuid = f61_local5
					}
				} )
			end
			return f61_local0
		end )
		local f58_local11 = Engine[@"getplaylistinfobyid"]( f58_local8 )
		table.insert( f58_local3, {
			models = {
				icon = f58_local11.image,
				mode = f58_local11.mainMode,
				name = f58_local11.name,
				playlist = f58_local8,
				detailedDescription = Engine.Localize( @"hash_AA599434213FFE3", f58_local11.description ),
				tooltipArchetype = CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE,
				xuidDataSource = f58_local10,
				playerListDataSource = f58_local10,
				action = CoD.DirectorUtility.CardNavigateToLobby,
				secondaryAction = CoD.ArenaUtility.CardDisplayDetails
			},
			properties = {
				param = {
					mode = f58_local11.mainMode,
					playlist = f58_local8
				}
			}
		} )
		f58_local4 = f58_local4 + 1
	end
	f58_local0.SuggestedActivityCount:set( #f58_local3 )
	return f58_local3
end, true )
DataSources.PlayerListDataSourceDefault = DataSourceHelpers.ListSetup( "PlayerListDataSourceDefault", function ( f62_arg0, f62_arg1 )
	return {}
end, true )
CoD.DirectorUtility.DirectorSelectTabValues = {
	Home = 1,
	Play = 2
}
CoD.DirectorUtility.AddLobbyNavSubscriptionOnce = function ( f63_arg0 )
	if not f63_arg0._hasLobbyNavSubscription then
		f63_arg0._hasLobbyNavSubscription = true
		f63_arg0:subscribeToModel( Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" ), function ()
			f63_arg0:updateDataSource( false, false )
		end, false )
		local f63_local0 = f63_arg0
		local f63_local1 = f63_arg0.subscribeToModel
		local f63_local2 = Engine.GetGlobalModel()
		f63_local1( f63_local0, f63_local2.lobbyRoot.privateClient.count, function ()
			f63_arg0:updateDataSource( false, false )
		end, false )
	end
end
CoD.DirectorUtility.AddInstallSubscriptionOnce = function ( f66_arg0 )
	if not f66_arg0._hasInstallSubscription then
		f66_arg0._hasInstallSubscription = true
		local f66_local0 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.percentInstalled" )
		local f66_local1 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.owns_MP" )
		local f66_local2 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.owns_ZM" )
		local f66_local3 = function ()
			f66_arg0:updateDataSource( false, false )
		end
		
		f66_arg0:subscribeToModel( f66_local0, f66_local3, false )
		f66_arg0:subscribeToModel( f66_local1, f66_local3, false )
		f66_arg0:subscribeToModel( f66_local2, f66_local3, false )
	end
end
DataSources.DirectorSelectTabs = ListHelper_SetupDataSource( "DirectorSelectTabs", function ( f68_arg0, f68_arg1 )
	local f68_local0 = {}
	if not IsLobbyNetworkModeLAN() and not CoD.DirectorUtility.DisableForCurrentMilestone( f68_arg0 ) then
		table.insert( f68_local0, {
			models = {
				name = Engine[@"hash_4F9F1239CFD921FE"]( "director/home" ),
				activeTab = CoD.DirectorUtility.DirectorSelectTabValues.Home,
				available = true
			}
		} )
	end
	table.insert( f68_local0, {
		models = {
			name = Engine[@"hash_4F9F1239CFD921FE"]( "director/play" ),
			activeTab = CoD.DirectorUtility.DirectorSelectTabValues.Play,
			available = true
		},
		properties = {
			selectIndex = true
		}
	} )
	CoD.DirectorUtility.AddLobbyNavSubscriptionOnce( f68_arg1 )
	return f68_local0
end )
CoD.DirectorUtility.GetPlaylists = function ()
	if IsLobbyNetworkModeLive() and Engine[@"getplaylistchecksum"]() ~= Engine.DefaultID64Value() then
		return LuaUtils.GetOnlinePlaylists()
	else
		return LuaUtils.GetOfflinePlaylists()
	end
end
CoD.DirectorUtility.IsPlaylistRankRestrictedForPlayer = function ( f70_arg0, f70_arg1, f70_arg2 )
	local f70_local0 = f70_arg0.locked
	for f70_local1 = 1, #f70_arg0.rules, 1 do
		local f70_local4 = f70_arg0.rules[f70_local1]
		if f70_local4.name == "scr_max_rank" then
			local f70_local5 = tonumber( f70_local4.value )
			local f70_local6 = Engine.GetPlayerStats( f70_arg2, CoD.STATS_LOCATION_NORMAL, f70_arg1 )
			return f70_local5 <= (f70_local6.PlayerStatsList.RANK and f70_local6.PlayerStatsList.RANK.StatValue:get() or 0)
		end
	end
	return false
end
CoD.DirectorUtility.CreateFeatureCardsFromPlaylists = function ( f71_arg0, f71_arg1 )
	CoD.DirectorUtility.Filters = {}
	local f71_local0 = CoD.DirectorUtility.GetPlaylists()
	local f71_local1 = #f71_local0
	local f71_local2 = nil
	local f71_local3 = 1
	for f71_local4 = 1, f71_local1, 1 do
		local f71_local7 = f71_local0[f71_local4]
		if f71_local7.hidden ~= true then
			local f71_local8 = LuaUtils.GetEModeForLobbyMainMode( f71_local7.lobbyMainMode )
			if f71_local8 == nil or CoD.DirectorUtility.IsSessionModeAvailable( f71_arg1, f71_local8 ) then
				local f71_local9 = CoD.DirectorUtility.CreateFilter( f71_arg1, f71_local7.lobbyMainMode, "Grp" .. f71_local3, f71_local7.nameRef, f71_local7.icon, f71_local7.entries, nil, nil )
				if #f71_local9.cards > 0 then
					for f71_local14, f71_local15 in ipairs( f71_local9.cards ) do
						if f71_local15.featured and (f71_local15.mode == nil or LuaUtils.GetDisplayNameForLobbyMainMode( f71_local15.mode ) ~= 0x0) then
							local f71_local13 = f71_local15.detailedDesc
							f71_local15.detailedDesc = nil
							f71_local15.descriptionText = f71_local13
							f71_local15.subtitle = 0x0
							table.insert( f71_arg0, {
								models = f71_local15,
								properties = {
									param = f71_local15
								}
							} )
						end
					end
				end
			end
		end
		f71_local3 = f71_local3 + 1
	end
end
CoD.DirectorUtility.GetFirstOrFeaturedPlaylistEntry = function ( f72_arg0, f72_arg1, f72_arg2, f72_arg3, f72_arg4 )
	local f72_local0 = nil
	local f72_local1 = f72_arg2.mainMode
	local f72_local2 = f72_arg2.arena
	local f72_local3 = 1
	local f72_local4, f72_local5 = nil
	local f72_local6 = false
	local f72_local7 = LuaUtils.GetEModeForLobbyMainMode( f72_local1 )
	if f72_local7 ~= nil and not f72_arg2.isVisible() then
		f72_arg1 = LuaUtils.GetOfflinePlaylists()
		f72_local6 = true
	end
	if not f72_arg3 and not f72_local6 then
		f72_local6 = CoD.DirectorUtility.IsMainModeLocked( f72_arg0, f72_arg2 )
	end
	local f72_local8 = LuaUtils.GetSelectDescriptionForEMode( f72_local7 )
	local f72_local9 = nil
	if f72_local2 then
		if IsLobbyNetworkModeLAN() then
			for f72_local13, f72_local14 in ipairs( f72_arg1 ) do
				if f72_local14.nameHash == "arena" and #f72_local14.entries > 0 then
					f72_local9 = f72_local14.entries[1].id
				end
			end
		else
			local f72_local10 = LuaUtils.GetCurrentEventEntry()
			if f72_local10 then
				local f72_local11 = LuaUtils.GetArenaEventEntryPlaylistByName( f72_local10 )
				f72_local9 = f72_local11.id
			end
		end
	end
	for f72_local13, f72_local14 in ipairs( f72_arg1 ) do
		if f72_local14.lobbyMainMode == f72_local1 or f72_local14.lobbyMainMode == Enum.LobbyMainMode[@"lobby_mainmode_invalid"] then
			local f72_local15
			if f72_local14.nameHash ~= "arena" and f72_local14.nameHash ~= "arenadev" then
				f72_local15 = false
			else
				f72_local15 = true
			end
			if f72_local2 == f72_local15 then
				f72_local15 = CoD.DirectorUtility.CreateFilter( f72_arg0, f72_local14.lobbyMainMode, "Grp" .. f72_local3, f72_local14.nameRef, f72_local14.icon, f72_local14.entries, f72_local1, nil )
				if #f72_local15.cards > 0 then
					for f72_local20, f72_local21 in ipairs( f72_local15.cards ) do
						local f72_local22 = f72_local21.locked or f72_local6
						if not f72_arg4 or not f72_local22 then
							if f72_local21.featured then
								local f72_local19 = f72_local21.detailedDesc
								f72_local21.detailedDesc = nil
								f72_local21.descriptionText = f72_local19
								f72_local21.subtitle = 0x0
								f72_local21.locked = f72_local22
								f72_local21.description = f72_local8
								if f72_local21.isQuickplayCard then
									f72_local19 = Dvar[@"ui_prioritizequickplayforshowcase"]:exists() and Dvar[@"ui_prioritizequickplayforshowcase"]:get() or -1
									if f72_local19 < 0 and f72_local4 == nil then
										f72_local4 = {
											models = f72_local21,
											properties = {
												param = f72_local21
											}
										}
									elseif f72_local19 == 0 and f72_local5 == nil then
										f72_local5 = {
											models = f72_local21,
											properties = {
												param = f72_local21
											}
										}
									elseif f72_local19 > 0 then
										return {
											models = f72_local21,
											properties = {
												param = f72_local21
											}
										}
									end
								elseif f72_local5 == nil then
									f72_local5 = {
										models = f72_local21,
										properties = {
											param = f72_local21
										}
									}
								end
							elseif not f72_local2 then
								if f72_local4 == nil then
									f72_local21.subtitle = 0x0
									f72_local21.locked = f72_local22
									f72_local4 = {
										models = f72_local21,
										properties = {
											param = f72_local21
										}
									}
								end
							elseif f72_local21.playlist == f72_local9 then
								f72_local21.subtitle = 0x0
								f72_local21.locked = f72_local22
								f72_local4 = {
									models = f72_local21,
									properties = {
										param = f72_local21
									}
								}
							end
							if not f72_local21.iconBackground then
								f72_local21.iconBackground = "blacktransparent"
							end
							if not f72_local21.iconBackgroundFocus then
								f72_local21.iconBackgroundFocus = "blacktransparent"
							end
						end
					end
				end
			end
		end
		f72_local3 = f72_local3 + 1
	end
	return f72_local5 or f72_local4 and f72_local8
end
CoD.DirectorUtility.HasZombie = function ()
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.HasArena = function ()
	if Dvar[@"hash_1C1B99856528FDF9"]:exists() and Dvar[@"hash_1C1B99856528FDF9"]:get() == 0 then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.DisableArenaMainMode = function ( f75_arg0, f75_arg1 )
	if not f75_arg1.arena then
		return false
	elseif IsBooleanDvarSet( @"hash_7D0DEAAF76B222DB" ) then
		return true
	elseif not IsLobbyNetworkModeLAN() and not LuaUtils.GetArenaSeason() then
		return true
	else
		return false
	end
end
CoD.DirectorUtility.IsWZFeatureCardVisible = function ()
	if CoD.BaseUtility.IsDvarEnabled( "ui_showWZCustomGameOption" ) then
		return true
	elseif IsLobbyNetworkModeLAN() then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.MainScreenModes = {
	{
		arena = false,
		mainMode = Enum.LobbyMainMode[@"lobby_mainmode_mp"],
		stringIfLocked = "menu/multiplayer",
		lockedOffline = false,
		isVisible = AlwaysTrue,
		trialDisable = true
	},
	{
		arena = true,
		mainMode = Enum.LobbyMainMode[@"lobby_mainmode_mp"],
		stringIfLocked = "menu/arena",
		lockedOffline = false,
		isVisible = CoD.DirectorUtility.HasArena,
		trialDisable = true
	},
	{
		arena = false,
		mainMode = Enum.LobbyMainMode[@"lobby_mainmode_wz"],
		stringIfLocked = "menu/warzone",
		lockedOffline = false,
		isVisible = CoD.DirectorUtility.IsWZFeatureCardVisible,
		trialDisable = false
	},
	{
		arena = false,
		mainMode = Enum.LobbyMainMode[@"lobby_mainmode_zm"],
		stringIfLocked = "menu/zombies",
		lockedOffline = false,
		isVisible = CoD.DirectorUtility.HasZombie,
		trialDisable = true
	}
}
CoD.DirectorUtility.IsMainModeLocked = function ( f77_arg0, f77_arg1 )
	if f77_arg1.arena and LuaUtils.MPArenaDisabled() then
		return true
	elseif IsLobbyNetworkModeLAN() and f77_arg1.lockedOffline then
		return true
	elseif CoD.DirectorUtility.DisableForCurrentMilestone() and f77_arg1.mainMode == Enum.LobbyMainMode[@"lobby_mainmode_zm"] and LuaUtils.MatchmakingTest() ~= 1 then
		return true
	elseif CoD.DirectorUtility.DisableArenaMainMode( f77_arg0, f77_arg1 ) then
		return true
	else
		return LuaUtils.GetDisplayNameForLobbyMainMode( f77_arg1.mainMode ) == 0x0
	end
end
DataSources.DirectorFeaturedButtons = ListHelper_SetupDataSource( "DirectorFeaturedButtons", function ( f78_arg0, f78_arg1 )
	local f78_local0 = {}
	local f78_local1 = CoD.DirectorUtility.GetPlaylists()
	for f78_local9, f78_local10 in ipairs( CoD.DirectorUtility.MainScreenModes ) do
		if f78_local10.isVisible() then
			local f78_local5 = LuaUtils.LobbyMainModeData[f78_local10.mainMode]
			local f78_local6 = CoD.DirectorUtility.GetFirstOrFeaturedPlaylistEntry( f78_arg0, f78_local1, f78_local10 )
			if f78_local6 then
				local f78_local7 = f78_local6.models
				local f78_local8 = f78_local10.trialDisable
				if f78_local8 then
					f78_local8 = Engine[@"hash_5CB675CA7856DA25"]()
				end
				f78_local7.trialLocked = f78_local8
				f78_local6.properties.lockedAction = CoD.DirectorUtility.DirectorSelectLockedAction
				f78_local7 = f78_local6.properties
				if f78_local5 then
					f78_local8 = f78_local5.PregameMenu
					if not f78_local8 then
					
					else
						f78_local7.actionParam = f78_local8
						table.insert( f78_local0, f78_local6 )
					end
				end
				f78_local8 = nil
			end
		end
	end
	if not f78_arg1._hasSubscriptions then
		f78_arg1._hasSubscriptions = true
		f78_arg1:subscribeToModel( Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNetworkMode" ), function ()
			f78_arg1:updateDataSource( false, false )
		end, false )
		f78_local4 = f78_arg1
		f78_local3 = f78_arg1.subscribeToModel
		f78_local9 = Engine.GetGlobalModel()
		f78_local3( f78_local4, f78_local9.lobbyRoot.privateClient.count, function ()
			f78_arg1:updateDataSource( false, false )
		end, false )
	end
	CoD.DirectorUtility.AddInstallSubscriptionOnce( f78_arg1 )
	if f78_arg1._entitlementUpdateSubscription == nil then
		f78_local2 = Engine.GetGlobalModel()
		f78_arg1._entitlementUpdateSubscription = f78_arg1:subscribeToModel( f78_local2.lobbyRoot.entitlementsUpdated, function ()
			f78_arg1:updateDataSource()
		end, false )
	end
	return f78_local0
end )
DataSources.DirectorHomeButtons = ListHelper_SetupDataSource( "DirectorHomeButtons", function ( f82_arg0, f82_arg1 )
	local f82_local0 = {}
	if not f82_arg1._lobbyNetworkModeSubscription then
		f82_arg1._lobbyNetworkModeSubscription = true
		local f82_local1 = f82_arg1
		local f82_local2 = f82_arg1.subscribeToModel
		local f82_local3 = Engine.GetGlobalModel()
		f82_local2( f82_local1, f82_local3.lobbyRoot.lobbyNetworkMode, function ( f83_arg0 )
			f82_arg1:updateDataSource( true )
		end, false )
	end
	if CoD.DirectorUtility.ShouldHideCRMFeatureList( nil, f82_arg0 ) then
		return f82_local0
	elseif IsGameTrial() then
		CoD.WZUtility.CreateMOTDWZTrialCard( f82_local0, f82_arg0 )
	end
	CoD.VideoStreamingUtility.CreateLEVFeaturedCard( f82_local0, f82_arg0 )
	CoD.MOTDUtility.CreateMOTDFeatureCard( f82_local0, f82_arg0 )
	CoD.MOTDUtility.FeatureCard_AddFeatureCards( f82_local0, f82_arg0 )
	CoD.MOTDUtility.MOTD_AddMOTDCards( f82_local0, f82_arg0 )
	return f82_local0
end )
CoD.DirectorUtility.DirectorNavigateToSpecialistHeadquarters = function ( f84_arg0, f84_arg1, f84_arg2, f84_arg3, f84_arg4 )
	CoD.FTUEUtility.ShouldBlockMPFTUE = true
	CoD.CTUtility.SetNavMethodFrontend( f84_arg2 )
	CoD.LobbyUtility.NavigateToLobby( f84_arg4, LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING, false, f84_arg2 )
end
DataSources.DirectorExtraHomeButtons = ListHelper_SetupDataSource( "DirectorExtraHomeButtons", function ( f85_arg0, f85_arg1 )
	local f85_local0 = {}
	local f85_local1 = IsLobbyNetworkModeLAN()
	local f85_local2
	if Engine[@"hash_77D47312EBA41751"]() or LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING ) == nil then
		f85_local2 = false
	else
		f85_local2 = true
	end
	local f85_local3 = false
	local f85_local4 = false
	local f85_local5 = Engine.GetGlobalModel()
	f85_local5 = f85_local5:create( CoD.LobbyUtility.LobbyNavigationActionModel )
	f85_local5 = f85_local5:get()
	if f85_local5 == LuaEnum.UI.DIRECTOR_LAN_SELECT then
		f85_local3 = true
	elseif f85_local5 == LuaEnum.UI.DIRECTOR_ONLINE then
		f85_local4 = true
	end
	if f85_local1 then
		if not LuaUtils.OfflineOnlyDemo() then
			table.insert( f85_local0, {
				models = {
					subtitle = @"menu/play_online",
					iconBackground = "blacktransparent",
					iconBackgroundFocus = "blacktransparent",
					showOnLeft = true,
					small = true,
					locked = false
				},
				properties = {
					action = CoD.DirectorUtility.DirectorSelectAction,
					actionParam = LuaEnum.UI.DIRECTOR_ONLINE,
					selectIndex = f85_local3
				}
			} )
		end
		table.insert( f85_local0, {
			models = {
				subtitle = @"hash_5D7DF8AD7167B198",
				iconBackground = "blacktransparent",
				iconBackgroundFocus = "blacktransparent",
				showOnLeft = true,
				small = true,
				locked = false
			},
			properties = {
				action = CoD.DirectorUtility.DirectorSelectOpenPopup,
				actionParam = "LobbyServerBrowserOverlay"
			}
		} )
	else
		if f85_local2 then
			table.insert( f85_local0, {
				models = {
					showOnLeft = true,
					small = false,
					locked = false,
					trialLocked = Engine[@"hash_5CB675CA7856DA25"](),
					iconBackground = "ui_icon_director_ct_tile",
					iconBackgroundFocus = "ui_icon_director_ct_tile_focus",
					subtitle = @"hash_5AA1920F2AF31A03",
					showForAllClients = false
				},
				properties = {
					action = CoD.DirectorUtility.DirectorNavigateToSpecialistHeadquarters
				}
			} )
		end
		table.insert( f85_local0, {
			models = {
				subtitle = @"menu/theater",
				iconBackground = "blacktransparent",
				iconBackgroundFocus = "blacktransparent",
				showOnLeft = true,
				small = true,
				locked = CoD.DirectorUtility.DisableForCurrentMilestone( f85_arg0 ) and not CoD.BaseUtility.IsDvarEnabled( "ui_showTheater" ),
				trialLocked = Engine[@"hash_5CB675CA7856DA25"]()
			},
			properties = {
				action = CoD.DirectorUtility.DirectorSelectTheater,
				actionParam = LuaEnum.UI.DIRECTOR_ONLINE_THEATER
			}
		} )
		local f85_local6 = "ui_icon_blackmarket_store_tile_default_01"
		local f85_local7 = "ui_icon_blackmarket_store_tile_focus_01"
		if IsBooleanDvarSet( "loot_enableblackmarket" ) then
			local f85_local8 = Engine[@"hash_2E00B2F29271C60B"]( CoDShared.Loot.GetCurrentSeason() )
			local f85_local9
			if f85_local8 then
				f85_local9 = f85_local8[@"squareimage"]
				if not f85_local9 then
				
				else
					local f85_local10
					if f85_local8 then
						f85_local10 = f85_local8.squareimagefocus
						if not f85_local10 then
						
						else
							if f85_local8 then
								f85_local6 = f85_local8[@"hash_751E7101B70C8A6C"] or f85_local6
							end
							if f85_local8 then
								f85_local7 = f85_local8[@"hash_170243CFDCD07174"] or f85_local7
							end
							table.insert( f85_local0, {
								models = {
									showOnLeft = false,
									locked = false,
									iconBackground = f85_local9,
									iconBackgroundFocus = f85_local10,
									subtitle = @"menu/black_market",
									small = false,
									showForAllClients = true
								},
								properties = {
									action = OpenQuarterMaster
								}
							} )
						end
					end
					f85_local10 = "ui_icon_blackmarket_store_tile_focus"
				end
			end
			f85_local9 = "ui_icon_blackmarket_store_tile_default"
		end
		if IsCommerceEnabledOnPC() then
			table.insert( f85_local0, {
				models = {
					showOnLeft = not IsBooleanDvarSet( "loot_enableblackmarket" ),
					iconBackground = f85_local6,
					iconBackgroundFocus = f85_local7,
					locked = false,
					subtitle = "menu/store_caps",
					small = false,
					showForAllClients = true
				},
				properties = {
					action = OpenStore,
					actionParam = "DirectorPlayButton"
				}
			} )
		end
		if not CoD.isPC then
			table.insert( f85_local0, {
				models = {
					subtitle = @"menu/play_local",
					iconBackground = "blacktransparent",
					iconBackgroundFocus = "blacktransparent",
					showOnLeft = true,
					small = true,
					locked = LuaUtils.OnlineOnlyDemo(),
					trialLocked = Engine[@"hash_5CB675CA7856DA25"]()
				},
				properties = {
					action = CoD.DirectorUtility.DirectorSelectAction,
					actionParam = LuaEnum.UI.DIRECTOR_LAN_SELECT,
					selectIndex = f85_local4
				}
			} )
		end
	end
	CoD.DirectorUtility.AddLobbyNavSubscriptionOnce( f85_arg1 )
	CoD.DirectorUtility.AddInstallSubscriptionOnce( f85_arg1 )
	if not f85_arg1._hasAutoEventSubscription then
		local f85_local11 = f85_arg1
		local f85_local12 = f85_arg1.subscribeToModel
		local f85_local6 = Engine.GetGlobalModel()
		f85_local6 = f85_local6:create( "AutoEvents" )
		f85_local12( f85_local11, f85_local6:create( "cycled" ), function ()
			f85_arg1:updateDataSource()
		end, false )
		f85_arg1._hasAutoEventSubscription = true
	end
	return f85_local0
end )
CoD.DirectorUtility.DirectorOpenVodAction = function ( f87_arg0, f87_arg1, f87_arg2, f87_arg3, f87_arg4 )
	CoD.VideoStreamingUtility.SetupVoDMovie( f87_arg2, f87_arg1, f87_arg3 )
	DelayOpenOverlay( f87_arg4, "VoDViewer", f87_arg2, nil )
end
CoD.DirectorUtility.AddBlackoutVODFeaturedCard = function ( f88_arg0, f88_arg1 )
	table.insert( f88_arg0, {
		models = {
			locked = false,
			name = Engine[@"hash_4F9F1239CFD921FE"]( "menu/warzone" ),
			iconBackground = @"hash_7722D4EEEAD86C3A",
			iconBackgroundFocus = @"hash_7722D4EEEAD86C3A",
			descriptionText = @"hash_36CF46BE979E096B",
			action = CoD.DirectorUtility.DirectorOpenVodAction,
			param = "vod",
			vod = {
				movieName = "wz_teaser_trailer"
			},
			showForAllClients = true,
			hasDoubleXP = false,
			hasDoubleWeaponXP = false
		}
	} )
end
CoD.DirectorUtility.DirectorSelectAction = function ( f89_arg0, f89_arg1, f89_arg2, f89_arg3, f89_arg4 )
	local f89_local0 = f89_arg3
	CoD.DirectorUtility.NavigateToLobby( f89_arg4, f89_arg2, f89_local0 )
	local f89_local1 = LobbyData.GetLobbyMenuByName( f89_local0 )
	local f89_local2 = f89_local1[@"mainmode"]
	local f89_local3 = f89_local1.LobbyMode == Enum.LobbyMode[@"lobby_mode_arena"]
	if IsLobbyNetworkModeLive() then
		CoD.DirectorUtility.LoadPreferredPlaylist( f89_arg2, f89_local2, f89_local3 )
	end
	PlaySoundSetSound( f89_arg0, "toggle" )
end
CoD.DirectorUtility.DirectorSelectLockedAction = function ( f90_arg0, f90_arg1, f90_arg2, f90_arg3, f90_arg4 )
	local f90_local0 = LobbyData.GetLobbyMenuByName( f90_arg3 )
	local f90_local1 = f90_local0[@"mainmode"]
	local f90_local2 = false
	if CoD.isPC and (CoD.DirectorUtility.ZombieLimitedShouldOpenStore( f90_local1 ) or Engine[@"hash_5CB675CA7856DA25"]()) then
		OpenStore( f90_arg0, f90_arg1, f90_arg2, "", f90_arg4 )
		f90_local2 = true
	end
	if f90_local2 then
		PlaySoundSetSound( f90_arg0, "toggle" )
	end
end
CoD.DirectorUtility.DirectorSelectTheater = function ( f91_arg0, f91_arg1, f91_arg2, f91_arg3, f91_arg4 )
	CoD.FileshareUtility.InitModels()
	CoD.DirectorUtility.DirectorSelectAction( f91_arg0, f91_arg1, f91_arg2, f91_arg3, f91_arg4 )
	CoD.FileshareUtility.SetupFileshareForTheater( f91_arg2 )
end
CoD.DirectorUtility.DirectorTheaterOpenSelectFilm = function ( f92_arg0, f92_arg1, f92_arg2, f92_arg3, f92_arg4 )
	if not CoDShared.IsInTheaterLobby() then
		return 
	elseif f92_arg3 ~= Enum.eModes.mode_invalid then
		CoD.FileshareUtility.SetCurrentFilter( Enum[@"fileshareprimarytags_e"][@"hash_7309C4BC434A44FC"], Engine[@"numbertouint64"]( f92_arg3 ) )
	end
	CoD.LobbyUtility.OpenTheaterSelectFilm( f92_arg4, f92_arg2 )
end
CoD.DirectorUtility.DirectorTheaterLaunchDemo = function ( f93_arg0, f93_arg1, f93_arg2 )
	local f93_local0 = Engine[@"lobbygetdemoinformation"]( Enum.LobbyModule[@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"]( Enum.LobbyModule[@"lobby_module_client"] ) )
	if not f93_local0 then
		return 
	elseif f93_arg2 == nil then
		f93_arg2 = ""
	end
	f93_local0.map = Engine[@"lobbygetmap"]()
	f93_local0.gametype = Engine[@"lobbygetgametype"]()
	f93_local0.controller = f93_arg1
	f93_local0.demoMode = f93_arg2
	Engine[@"lobbyupdatedemoinformation"]( Enum.LobbyModule[@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"]( Enum.LobbyModule[@"lobby_module_host"] ), f93_local0 )
	CoD.MetricsUtility.WatchVideoEvent( f93_arg1, f93_local0 )
	CoD.LobbyUtility.LaunchDemo( f93_arg0, f93_arg1, Enum.LobbyType[@"lobby_type_game"] )
	CoD.FileshareUtility.SetAutoStart( false )
end
CoD.DirectorUtility.IsQuickplayAvailableForMode = function ( f94_arg0 )
	if Dvar[@"lobbymultiplaylistsearchenabled"]:exists() and Dvar[@"lobbymultiplaylistsearchenabled"]:get() then
		if f94_arg0 == Enum.LobbyMainMode[@"lobby_mainmode_mp"] then
			return Dvar[@"hash_3A7864B7F74641C9"]:exists() and Dvar[@"hash_3A7864B7F74641C9"]:get()
		elseif f94_arg0 == Enum.LobbyMainMode[@"lobby_mainmode_wz"] then
			return Dvar[@"hash_3A646AB7F735A2F1"]:exists() and Dvar[@"hash_3A646AB7F735A2F1"]:get()
		elseif f94_arg0 == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
			return Dvar[@"ui_showquickplayinplaylistszm"]:exists() and Dvar[@"ui_showquickplayinplaylistszm"]:get()
		end
	end
	return false
end
CoD.DirectorUtility.GetQuickplayPlaylistsForCurrentMode = function ( f95_arg0, f95_arg1 )
	local f95_local0 = {}
	local f95_local1 = Engine.GetGlobalModel()
	f95_local1 = f95_local1.lobbyRoot.lobbyMainMode:get()
	if f95_local1 == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
		f95_local0 = CoD.ZombieUtility.GetQuickplayPlaylists( f95_arg0, f95_arg1 )
	else
		local f95_local2 = Engine.GetGlobalModel()
		f95_local2 = f95_local2.lobbyRoot.lobbyList.playerCount:get()
		for f95_local11, f95_local12 in ipairs( CoD.DirectorUtility.GetDirectorFiltersCardsForMode( f95_arg0, f95_arg1, f95_local1, true ) ) do
			if f95_local12.cards then
				for f95_local9, f95_local10 in ipairs( f95_local12.cards ) do
					if f95_local10.canQuickplay and f95_local2 <= f95_local10.maxPartySize then
						table.insert( f95_local0, f95_local10.playlist )
					end
				end
			end
		end
	end
	return f95_local0
end
CoD.DirectorUtility.PrepareSearchPlaylistModels = function ( f96_arg0, f96_arg1 )
	local f96_local0 = true
	if Dvar[@"lobbymultiplaylistsearchenabled"]:exists() and Dvar[@"lobbymultiplaylistsearchenabled"]:get() then
		local f96_local1 = Engine.GetGlobalModel()
		local f96_local2 = f96_local1.lobbyRoot:create( "searchPlaylistIDs" )
		local f96_local3 = 0
		local f96_local4 = Engine[@"getplaylistid"]()
		local f96_local5 = Engine[@"getplaylistinfobyid"]( f96_local4 )
		if f96_local5.isQuickplayCard then
			for f96_local9, f96_local10 in ipairs( CoD.DirectorUtility.GetQuickplayPlaylistsForCurrentMode( f96_arg0, f96_arg1 ) ) do
				f96_local3 = f96_local3 + 1
				local f96_local11 = f96_local2:create( f96_local3 )
				f96_local11:set( f96_local10 )
			end
			if f96_local3 == 0 then
				f96_local0 = false
			end
		end
		if f96_local3 == 0 then
			f96_local3 = 1
			local f96_local12 = f96_local2:create( f96_local3 )
			f96_local12:set( f96_local4 )
		end
		local f96_local12 = f96_local2:create( "count" )
		f96_local12:set( f96_local3 )
	end
	return f96_local0
end
CoD.DirectorUtility.NavigateToPublicLobbyForCurrentMenuMode = function ( f97_arg0, f97_arg1 )
	local f97_local0 = Engine.GetGlobalModel()
	f97_local0 = f97_local0.lobbyRoot.lobbyMainMode:get()
	if LuaUtils.LobbyMainModeData[f97_local0] then
		if CoD.DirectorUtility.PrepareSearchPlaylistModels( f97_arg0, f97_arg1 ) then
			CoD.DirectorUtility.NavigateToLobby( f97_arg0, f97_arg1, LuaUtils.LobbyMainModeData[f97_local0].PublicMenu )
		end
	elseif LUI.DEV then
		error( "LuaUtils.LobbyMainModeData[ mainMode ] is nil for mode " .. (f97_local0 or "nil") )
	end
end
CoD.DirectorUtility.DirectorSelectOpenPopup = function ( f98_arg0, f98_arg1, f98_arg2, f98_arg3, f98_arg4 )
	OpenPopup( f98_arg0, f98_arg3, f98_arg2, "", "" )
end
CoD.DirectorUtility.DirectorOpenOverlayWithMenuSessionMode = function ( f99_arg0, f99_arg1, f99_arg2, f99_arg3, f99_arg4 )
	OpenOverlay( f99_arg0, f99_arg3.menuName, f99_arg2, {
		_sessionMode = f99_arg3.eMode
	} )
end
CoD.DirectorUtility.OpenCACWithMenuSessionMode = function ( f100_arg0, f100_arg1, f100_arg2, f100_arg3, f100_arg4 )
	if CoD.DirectorUtility.ShouldShowAppLoadoutAvailable( f100_arg4, f100_arg2 ) then
		CoD.OverlayUtility.CreateOverlay( f100_arg2, f100_arg4, "AppLoadoutConfirmLoadout", f100_arg2, nil )
		return 
	end
	local f100_local0 = f100_arg3.eMode
	local f100_local1 = "MPCustomizeClassMenu"
	if f100_local0 == Enum.eModes.mode_zombies then
		f100_local1 = "ZMCustomizeClassMenu"
		if CoD.DirectorUtility.IsLoadoutPreviewWidgetShown( f100_arg2 ) then
			CoD.DirectorUtility.HideLoadoutPreview( f100_arg2 )
		end
	end
	OpenOverlay( f100_arg0, f100_local1, f100_arg2, {
		_sessionMode = f100_local0
	} )
end
CoD.DirectorUtility.OpenArmoryMenu = function ( f101_arg0, f101_arg1, f101_arg2, f101_arg3, f101_arg4 )
	OpenOverlay( f101_arg0, "Armory", f101_arg2, f101_arg3 )
end
CoD.DirectorUtility.OpenWZPersonalizeWeaponMenu = function ( f102_arg0, f102_arg1, f102_arg2, f102_arg3, f102_arg4 )
	OpenOverlay( f102_arg0, "WZPersonalizeWeapon", f102_arg2, f102_arg3 )
end
CoD.DirectorUtility.NavigateToCustomGames = function ( f103_arg0, f103_arg1, f103_arg2, f103_arg3, f103_arg4 )
	CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode( f103_arg4, f103_arg2 )
end
CoD.DirectorUtility.OpenDirectorChangeCharacterMenu = function ( f104_arg0, f104_arg1, f104_arg2, f104_arg3, f104_arg4 )
	if f104_arg3 and f104_arg3._sessionMode == Enum.eModes.mode_multiplayer then
		OpenOverlay( f104_arg0, "DirectorPersonalizeCharacterMP", f104_arg2, f104_arg3 )
	elseif f104_arg3 and f104_arg3._sessionMode == Enum.eModes.mode_zombies then
		OpenOverlay( f104_arg0, "ZMPersonalizeCharacterMain", f104_arg2, f104_arg3 )
	elseif f104_arg3 and f104_arg3._sessionMode == Enum.eModes.mode_warzone then
		OpenOverlay( f104_arg0, "DirectorChangeCharacter", f104_arg2, f104_arg3 )
	end
end
CoD.DirectorUtility.OpenDirectorPersonalizationMenu = function ( f105_arg0, f105_arg1, f105_arg2, f105_arg3, f105_arg4 )
	OpenOverlay( f105_arg4, "MPSpecialistHUBBindWheel", f105_arg2, f105_arg3 )
end
CoD.DirectorUtility.DirectorOpenOverlayWithCurrentMenuMode = function ( f106_arg0, f106_arg1, f106_arg2 )
	local f106_local0 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyMainMode" )
	f106_local0 = f106_local0:get()
	OpenOverlay( f106_arg0, f106_arg2, f106_arg1, {
		_mainMode = f106_local0,
		_sessionMode = LuaUtils.GetEModeForLobbyMainMode( f106_local0 )
	} )
end
DataSources.DirectorPlayButtons = ListHelper_SetupDataSource( "DirectorPlayButtons", function ( f107_arg0, f107_arg1 )
	local f107_local0 = {}
	local f107_local1 = IsLobbyNetworkModeLAN()
	for f107_local16, f107_local17 in ipairs( CoD.DirectorUtility.MainScreenModes ) do
		if f107_local17.isVisible() then
			local f107_local5 = LuaUtils.LobbyMainModeData[f107_local17.mainMode]
			local f107_local6 = f107_local5 and LuaUtils.GetDisplayNameForEMode( f107_local5.eMode )
			local f107_local7 = f107_local5 and LuaUtils.GetSelectDescriptionForEMode( f107_local5.eMode )
			local f107_local8 = CoD.DirectorUtility.IsMainModeLocked( f107_arg0, f107_local17 )
			if not f107_local5 or (not f107_local1 or not f107_local5.LanMenu) and not f107_local5.PregameMenu then
				local f107_local9 = nil
			end
			if f107_local8 then
				f107_local6 = f107_local17.stringIfLocked
				f107_local7 = 0x0
			end
			local f107_local9
			if f107_local17.arena then
				f107_local6 = "menu/arena"
				f107_local7 = @"menu/arena_desc"
				if f107_local1 then
					f107_local9 = LuaEnum.UI.DIRECTOR_LAN_MP_ARENA
				else
					f107_local9 = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME
				end
			end
			if f107_local1 and f107_local17.lockedOffline then
				f107_local8 = true
			end
			local f107_local10
			if f107_local5 then
				f107_local10 = f107_local5.eMode
				if not f107_local10 then
				
				else
					local f107_local11 = table.insert
					local f107_local12 = f107_local0
					local f107_local13 = {}
					local f107_local14 = {
						subtitle = f107_local6,
						description = f107_local7,
						mode = f107_local10,
						small = false,
						locked = f107_local8
					}
					local f107_local15 = f107_local17.trialDisable
					if f107_local15 then
						f107_local15 = Engine[@"hash_5CB675CA7856DA25"]()
					end
					f107_local14.trialLocked = f107_local15
					f107_local13.models = f107_local14
					f107_local13.properties = {
						action = CoD.DirectorUtility.DirectorSelectAction,
						actionParam = f107_local9,
						lockedAction = CoD.DirectorUtility.DirectorSelectLockedAction
					}
					f107_local11( f107_local12, f107_local13 )
				end
			end
			f107_local10 = -1
		end
	end
	CoD.DirectorUtility.AddLobbyNavSubscriptionOnce( f107_arg1 )
	CoD.DirectorUtility.AddInstallSubscriptionOnce( f107_arg1 )
	return f107_local0
end )
CoD.DirectorUtility.GameModeData = {
	[Enum.eModes.mode_multiplayer] = {
		theaterButtonImage = "ui_icon_theater_tile_mp"
	},
	[Enum.eModes.mode_zombies] = {
		theaterButtonImage = "ui_icon_theater_tile_zm"
	},
	[Enum.eModes.mode_warzone] = {
		theaterButtonImage = "ui_icon_theater_tile_wz"
	}
}
DataSources.DirectorTheaterLandingPageModes = ListHelper_SetupDataSource( "DirectorTheaterLandingPageModes", function ( f108_arg0, f108_arg1 )
	local f108_local0 = {}
	for f108_local11, f108_local12 in ipairs( CoD.DirectorUtility.MainScreenModes ) do
		if f108_local12.isVisible() then
			local f108_local4 = LuaUtils.LobbyMainModeData[f108_local12.mainMode]
			local f108_local5 = f108_local4 and LuaUtils.GetDisplayNameForEMode( f108_local4.eMode )
			if f108_local4 then
				local f108_local6 = CoD.DirectorUtility.GameModeData[f108_local4.eMode]
				local f108_local7 = CoD.DirectorUtility.GameModeData[f108_local4.eMode].theaterButtonImage
			end
			local f108_local8 = f108_local6 and f108_local7 or "blacktransparent"
			local f108_local9 = CoD.isPC
			if f108_local9 then
				f108_local9 = CoD.DirectorUtility.IsMainModeLocked( f108_arg0, f108_local12 )
			end
			if not f108_local12.arena then
				local f108_local10
				if f108_local4 then
					f108_local10 = f108_local4.eMode
					if not f108_local10 then
					
					else
						table.insert( f108_local0, {
							models = {
								subtitle = f108_local5,
								buttonImage = f108_local8,
								mode = f108_local10,
								small = false,
								locked = f108_local9
							},
							properties = {
								action = CoD.DirectorUtility.DirectorTheaterOpenSelectFilm,
								actionParam = f108_local10
							}
						} )
					end
				end
				f108_local10 = -1
			end
		end
	end
	table.insert( f108_local0, {
		models = {
			subtitle = "menu/all_caps",
			mode = Enum.eModes.mode_invalid,
			small = true,
			locked = false
		},
		properties = {
			action = CoD.DirectorUtility.DirectorTheaterOpenSelectFilm,
			actionParam = Enum.eModes.mode_invalid
		}
	} )
	return f108_local0
end )
CoD.DirectorUtility.CreateFilter = function ( f109_arg0, f109_arg1, f109_arg2, f109_arg3, f109_arg4, f109_arg5, f109_arg6, f109_arg7, f109_arg8, f109_arg9 )
	local f109_local0 = {
		mainMode = f109_arg1,
		id = f109_arg2,
		name = f109_arg3,
		icon = f109_arg4,
		available = true,
		cards = {}
	}
	if f109_arg7 then
		CoD.ArenaUtility.CreateArenaCards( f109_local0, f109_arg0, f109_arg2, f109_arg5 )
	else
		CoD.DirectorUtility.CreateFilterCards( f109_local0, f109_arg0, f109_arg2, f109_arg5, f109_arg6, f109_arg7, f109_arg8, f109_arg9 )
	end
	return f109_local0
end
CoD.DirectorUtility.ShouldFeaturedAlternativeEntry = function ( f110_arg0, f110_arg1 )
	return false
end
CoD.DirectorUtility.IsAutoFeatured = function ( f111_arg0, f111_arg1, f111_arg2 )
	local f111_local0 = nil
	if CoD.DirectorUtility.RegionOnlyAllowsFeaturedPlaylistForMode( f111_arg0, f111_arg1 ) then
		f111_local0 = CoDShared.Playlists.GetLowpopFeatured( f111_arg1 )
	else
		f111_local0 = CoDShared.Playlists.GetFeatured( f111_arg1 )
	end
	if f111_local0 ~= nil then
		for f111_local4, f111_local5 in pairs( f111_local0 ) do
			if f111_arg2.uniqueName == f111_local5 then
				return true
			end
		end
	end
	return false
end
CoD.DirectorUtility.IsAutoShowcased = function ( f112_arg0, f112_arg1, f112_arg2 )
	local f112_local0 = nil
	if CoD.DirectorUtility.RegionOnlyAllowsFeaturedPlaylistForMode( f112_arg0, f112_arg1 ) then
		f112_local0 = CoDShared.Playlists.GetLowpopShowcased( f112_arg1 )
	else
		f112_local0 = CoDShared.Playlists.GetShowcased( f112_arg1 )
	end
	if f112_local0 ~= nil and f112_local0 ~= 0x0 and f112_arg2.uniqueName == f112_local0 then
		return true
	else
		return false
	end
end
CoD.DirectorUtility.CreateFilterCards = function ( f113_arg0, f113_arg1, f113_arg2, f113_arg3, f113_arg4, f113_arg5, f113_arg6, f113_arg7 )
	local f113_local0 = 1
	for f113_local1 = 1, #f113_arg3, 1 do
		local f113_local4 = f113_arg3[f113_local1]
		if f113_local4 ~= nil then
			local f113_local5 = CoD.DirectorUtility.CardNavigateToLobby
			local f113_local6 = f113_local4.id
			local f113_local7 = f113_local4.name
			if f113_local4.isNewGameOrResumeGame == true then
				f113_local5 = CoD.DirectorUtility.CPOnlineNewGame
				f113_local6 = 0
			end
			local f113_local8 = false
			local f113_local9 = Engine.GetUserTier( f113_arg1 )
			local f113_local10 = Engine[@"hash_514ECF96E169F000"]( f113_arg1, f113_local6 )
			local f113_local11 = false
			local f113_local12 = false
			local f113_local13 = false
			local f113_local14 = false
			if CoD.DirectorUtility.DisableForCurrentMilestone( f113_arg1 ) then
				local f113_local15 = Engine.GetXPScale( f113_arg1 )
				f113_local11 = f113_local15 and f113_local15 >= 2
				local f113_local16 = Engine.GetGunXPScale( f113_arg1 )
				f113_local12 = f113_local16 and f113_local16 >= 2
			else
				f113_local11 = LuaUtils.PlaylistRulesIncludes( f113_local4.rules, "scr_xpscalemp", "2" )
				f113_local12 = LuaUtils.PlaylistRulesIncludes( f113_local4.rules, @"scr_gunxpscalemp", "2" )
				f113_local13 = LuaUtils.PlaylistRulesIncludes( f113_local4.rules, "scr_credit_scale", "2" )
				f113_local14 = CoD.ZombieUtility.IsDoubleNP( f113_arg1 ) and f113_local4.mainMode == Enum.LobbyMainMode[@"lobby_mainmode_zm"]
			end
			if not (f113_local4.minUserTier == Enum[@"eusertier"][@"user_tier_none"] or f113_local9 >= f113_local4.minUserTier) or f113_local4.maxUserTier ~= Enum[@"eusertier"][@"user_tier_none"] and f113_local4.maxUserTier < f113_local9 then
				f113_local8 = true
			end
			if f113_local10 == Enum[@"playlistlockstate"][@"hash_5B469AFA64270B7E"] then
				f113_local8 = true
			end
			if f113_arg4 ~= nil and f113_arg4 ~= f113_local4.mainMode then
				f113_local8 = true
			end
			if f113_arg5 ~= nil and f113_arg5 ~= f113_local4.arenaSlot >= 0 then
				f113_local8 = true
			end
			if f113_local4.hidden == true and f113_arg7 ~= true then
				f113_local8 = true
			end
			if f113_arg6 ~= nil then
				if true == Dvar.tu17_playlist_autoschedule:get() then
					if f113_arg6 ~= CoD.DirectorUtility.IsAutoFeatured( f113_arg1, f113_arg4, f113_local4 ) then
						f113_local8 = true
					end
				elseif f113_arg6 ~= f113_local4.featuredCategory then
					f113_local8 = true
				end
			end
			local f113_local15 = {}
			local f113_local16 = {}
			local f113_local17 = {}
			local f113_local18 = {}
			for f113_local22, f113_local23 in ipairs( f113_local4.rotationList ) do
				if not f113_local16[f113_local23.map] then
					f113_local16[f113_local23.map] = true
					table.insert( f113_local15, f113_local23.map )
				end
				if not f113_local18[f113_local23.gametype] then
					f113_local18[f113_local23.gametype] = true
					table.insert( f113_local17, f113_local23.gametype )
				end
			end
			f113_local19, f113_local20 = nil
			for f113_local25, f113_local26 in ipairs( f113_local15 ) do
				local f113_local27 = Engine[@"hash_4F9F1239CFD921FE"]( CoD.BaseUtility.GetMapValue( f113_local26, "mapName", 0x0 ) )
				if CoD.MapUtility.IsDLCMapFromName( f113_local26 ) then
					local f113_local24
					if f113_local20 then
						f113_local24 = f113_local20 .. ", "
						if not f113_local24 then
						
						else
							f113_local20 = f113_local24 .. f113_local27
							goto basicblock_49:
						end
					end
					f113_local24 = ""
				end
				local f113_local24
				if f113_local19 then
					f113_local24 = f113_local19 .. ", "
					if not f113_local24 then
					
					else
						f113_local19 = f113_local24 .. f113_local27
					end
				end
				f113_local24 = ""
			end
			if f113_local20 then
				if f113_local19 then
					f113_local21 = f113_local19 .. "\n\n"
					if not f113_local21 then
					
					else
						f113_local19 = f113_local21 .. Engine[@"hash_4F9F1239CFD921FE"]( @"hash_16407D1BFF6842DA", f113_local20 )
					end
				end
				f113_local21 = ""
			end
			if IsBooleanDvarSet( "ui_freeMPDLC" ) then
				if f113_local19 then
					f113_local21 = f113_local19 .. "\n\n"
					if not f113_local21 then
					
					else
						f113_local19 = f113_local21 .. Engine[@"hash_4F9F1239CFD921FE"]( @"hash_4C83606D26B21D6E" )
					end
				end
				f113_local21 = ""
			end
			f113_local21 = nil
			for f113_local26, f113_local27 in ipairs( f113_local17 ) do
				local f113_local24 = Engine[@"hash_4F9F1239CFD921FE"]
				local f113_local28 = Engine[@"hash_1F2CD89B3C345FD3"]( f113_local27 )
				f113_local24 = f113_local24( f113_local28.nameRef )
				if f113_local21 then
					f113_local28 = f113_local21 .. ", "
					if not f113_local28 then
					
					else
						f113_local21 = f113_local28 .. f113_local24
					end
				end
				f113_local28 = ""
			end
			f113_local22 = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/player_range", f113_local4.minPlayers, f113_local4.maxPlayers )
			if f113_local4.isQuickplayCard then
				if not CoD.DirectorUtility.IsQuickplayAvailableForMode( f113_local4.mainMode ) then
					f113_local8 = true
				end
				f113_local19 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_323ED5097167B286" )
				f113_local21 = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_323ED5097167B286" )
				f113_local22 = Engine[@"hash_4F9F1239CFD921FE"]( 0x7AE56507881BD6 )
			end
			if true == Dvar.tu17_playlist_autoschedule:get() and CoDShared.Playlists.IsBlacklisted( f113_local4.uniqueName ) then
				f113_local8 = true
			end
			if CoD.isPC and CoD.PCKoreaUtility.IsPlaylistEntryBlacklisted( f113_local4 ) then
				f113_local8 = true
			end
			if f113_local8 ~= true then
				f113_local23 = false
				if CoD.DirectorUtility.ShouldFeaturedAlternativeEntry( f113_arg1, f113_local4.mainMode ) then
					f113_local23 = f113_local4.featuredAlt == true
				else
					f113_local23 = f113_local4.featured == true
				end
				if CoD.DirectorUtility.RegionOnlyAllowsFeaturedPlaylistForMode( f113_arg1, f113_local4.mainMode ) and Dvar.ui_wzFeaturedOnlyCountriesPlaylistEntryID:exists() and 0 ~= tonumber( Dvar.ui_wzFeaturedOnlyCountriesPlaylistEntryID:get() ) then
					if f113_local6 == tonumber( Dvar.ui_wzFeaturedOnlyCountriesPlaylistEntryID:get() ) then
						f113_local23 = true
					else
						f113_local23 = false
					end
				end
				if true == Dvar.tu17_playlist_autoschedule:get() then
					if CoD.DirectorUtility.IsAutoShowcased( f113_arg1, f113_arg4, f113_local4 ) then
						f113_local23 = true
					else
						f113_local23 = false
					end
				end
				f113_arg0.cards[f113_local0] = {
					id = f113_arg2 .. "Ent" .. f113_local0,
					playlist = f113_local6,
					name = Engine[@"hash_4F9F1239CFD921FE"]( f113_local7 ),
					playlistDesc = Engine[@"hash_632A860841DBD025"]( f113_arg1, f113_local6 ),
					mapsString = f113_local19,
					modesString = f113_local21,
					playersString = f113_local22,
					icon = f113_local4.image,
					iconBackground = f113_local4.imageBackground,
					iconBackgroundFocus = f113_local4.imageBackgroundFocus,
					action = f113_local5,
					mode = f113_local4.mainMode,
					locked = Engine[@"isplaylistlocked"]( f113_arg1, f113_local6 ),
					lockState = f113_local10,
					featured = f113_local23,
					isQuickplayCard = f113_local4.isQuickplayCard,
					canQuickplay = f113_local4.canQuickplay,
					lowPopPlaylist = f113_local4.lowPopPlaylist,
					maxPartySize = f113_local4.maxPartySize,
					hasDoubleXP = f113_local11,
					hasDoubleWeaponXP = f113_local12,
					hasTierBoost = f113_local13,
					hasDoubleNP = f113_local14,
					showForAllClients = false
				}
				f113_local0 = f113_local0 + 1
			end
		end
	end
end
CoD.DirectorUtility.HideCustomizationGametypes = {
	bounty = true,
	gun = true,
	infect = true,
	oic = true,
	prop = true
}
CoD.DirectorUtility.HideCustomizationPlaylistGametypes = {
	[@"hash_2BF17621068CE209"] = true,
	[@"hash_534D54D59EAE90F4"] = true,
	[@"hash_4202A359A02FC4E8"] = true,
	[@"hash_3B415F2EBD0C392F"] = true,
	[@"hash_31664269E7867977"] = true,
	[@"hash_5C6EFE9D61260D1B"] = true,
	[0x2B3EDD06160A9] = true,
	[@"hash_7D75A75AC73396CB"] = true,
	[@"hash_4601861FF493F249"] = true,
	[@"hash_7D8367413C4EA3DC"] = true
}
CoD.DirectorUtility.ShowCustomGameButtonForCurrentLobby = function ( f114_arg0 )
	if CoD.DirectorUtility.ShowDirectorPregame( f114_arg0 ) and not CoD.DirectorUtility.DisableForCurrentMilestone( f114_arg0 ) then
		return true
	elseif IsZombies() and IsLobbyNetworkModeLAN() then
		return true
	else
		return false
	end
end
DataSources.DirectorPregameButtons = ListHelper_SetupDataSource( "DirectorPregameButtons", function ( f115_arg0, f115_arg1 )
	local f115_local0 = {}
	local f115_local1 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyMainMode" )
	f115_local1 = f115_local1:get()
	local f115_local2 = LuaUtils.GetEModeForLobbyMainMode( f115_local1 )
	local f115_local3 = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer( f115_arg0, f115_local2 )
	local f115_local4 = function ( f116_arg0, f116_arg1 )
		local f116_local0 = {}
		local f116_local1 = f116_arg0.hintText
		local f116_local2 = false
		local f116_local3 = false
		if not f116_local1 and f116_arg0.featureItemIndex then
			f116_local1 = nil
			if CoD.CACUtility.IsFeatureItemLocked( f115_arg0, f116_arg0.featureItemIndex, f115_local2 ) then
				f116_local1 = CoD.GetUnlockStringForItemIndex( f115_arg0, f116_arg0.featureItemIndex, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f115_local2 )
			end
		end
		if f116_arg0.newBreadcrumbFunc then
			f116_local2 = f116_arg0.newBreadcrumbFunc( nil, f115_arg0, f115_local2 )
		end
		if f116_arg0.hasRestrictionsEquippedFunc then
			f116_local3 = f116_arg0.hasRestrictionsEquippedFunc( f115_arg0 )
		end
		local f116_local4 = table.insert
		local f116_local5 = f115_local0
		local f116_local6 = {}
		local f116_local7 = {
			name = f116_arg0.name,
			subtitle = f116_arg0.subtitle,
			iconBackground = f116_arg0.iconBackground,
			featureItemIndex = f116_arg0.featureItemIndex or -1,
			showPregameButton = f116_arg0.showPregameButton,
			hintText = f116_local1 or "",
			hasBreadcrumb = f116_local2,
			isRestricted = f116_local3,
			trialLocked = f116_arg0.trialLocked or false
		}
		local f116_local8 = f116_arg0.breadcrumbModel
		if not f116_local8 then
			f116_local8 = Engine.GetGlobalModel()
		end
		f116_local7.breadcrumbModel = f116_local8
		f116_local6.models = f116_local7
		f116_local6.properties = {
			action = f116_arg1.action,
			actionParam = f116_arg1.actionParam,
			selectIndex = f116_arg1.selectIndex
		}
		f116_local4( f116_local5, f116_local6 )
	end
	
	if f115_local1 == Enum.LobbyMainMode[@"lobby_mainmode_mp"] then
		local f115_local5 = Engine.GetGlobalModel()
		f115_local5 = f115_local5["lobbyRoot.selectedGameType"]
		local f115_local6 = true
		if f115_arg1:getParent() then
			local f115_local7 = f115_arg1:getParent()
			if f115_local7._preGameType == "custom" and CoD.DirectorUtility.HideCustomizationGametypes[f115_local5:get()] then
				f115_local6 = false
			end
		end
		if f115_arg1:getParent() then
			local f115_local7 = f115_arg1:getParent()
			if f115_local7._preGameType == "public" then
				f115_local7 = Engine.GetGlobalModel()
				f115_local7 = f115_local7["lobbyRoot.playlistId"]
				if f115_local7 and f115_local7:get() then
					local f115_local8 = IsLobbyNetworkModeLive()
					if f115_local8 then
						f115_local8 = Engine[@"getplaylistinfobyid"]( f115_local7:get() )
					end
					if f115_local8 and #f115_local8.rotationList > 0 then
						f115_local6 = not CoD.DirectorUtility.HideCustomizationPlaylistGametypes[f115_local8.rotationList[1].gametype]
					end
				end
			end
		end
		if not CoDShared.IsInTheaterLobby() then
			if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[@"hash_5CB675CA7856DA25"]()) then
				f115_local4( {
					name = @"menu/depot",
					subtitle = @"menu/depot",
					iconBackground = "$blacktransparent",
					showPregameButton = true,
					breadcrumbModel = DataSources.DepotBreadcrumbs.getModel( f115_arg0 )
				}, {
					action = CoD.DirectorUtility.OpenDirectorPersonalizationMenu,
					actionParam = {
						_sessionMode = f115_local2,
						_storageLoadoutBuffer = f115_local3,
						_allowsQuickSelect = true
					}
				} )
				f115_local4( {
					name = "menu/specialists",
					subtitle = "menu/specialists",
					iconBackground = "$blacktransparent",
					showPregameButton = true,
					breadcrumbModel = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded( f115_arg0, f115_local2 )
				}, {
					action = CoD.DirectorUtility.OpenDirectorChangeCharacterMenu,
					actionParam = {
						_sessionMode = f115_local2,
						_storageLoadoutBuffer = f115_local3,
						_selectIndex = 1
					}
				} )
			end
			f115_local4( {
				name = @"menu/change",
				subtitle = "menu/score_streaks",
				iconBackground = "$blacktransparent",
				showPregameButton = f115_local6,
				newBreadcrumbFunc = CoD.BreadcrumbUtility.IsAnyScorestreaksNew,
				hasRestrictionsEquippedFunc = CoD.CACUtility.AnyEquippedScorestreaksBanned
			}, {
				action = CoD.DirectorUtility.DirectorOpenOverlayWithMenuSessionMode,
				actionParam = {
					menuName = "SupportSelection",
					eMode = f115_local2
				}
			} )
			f115_local4( {
				name = @"menu/edit",
				subtitle = "feature/create_a_class",
				iconBackground = "$blacktransparent",
				featureItemIndex = CoD.CACUtility.GetFeatureCACItemIndex(),
				showPregameButton = f115_local6,
				newBreadcrumbFunc = CoD.BreadcrumbUtility.IsAnythingInCACNew,
				hasRestrictionsEquippedFunc = CoD.CACUtility.AnyClassContainsRestrictedItems
			}, {
				action = CoD.DirectorUtility.OpenCACWithMenuSessionMode,
				actionParam = {
					eMode = f115_local2
				},
				selectIndex = true
			} )
		end
	end
	if f115_local1 == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
		if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[@"hash_5CB675CA7856DA25"]()) then
			f115_local4( {
				name = @"menu/characters",
				subtitle = @"menu/characters",
				iconBackground = "$blacktransparent",
				showPregameButton = true,
				breadcrumbModel = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded( f115_arg0, f115_local2 )
			}, {
				action = CoD.DirectorUtility.OpenDirectorChangeCharacterMenu,
				actionParam = {
					_sessionMode = f115_local2,
					_storageLoadoutBuffer = f115_local3,
					_selectIndex = 1
				}
			} )
		end
		f115_local4( {
			name = @"menu/armory",
			subtitle = @"menu/armory",
			iconBackground = "$blacktransparent",
			showPregameButton = true
		}, {
			action = CoD.DirectorUtility.OpenArmoryMenu,
			actionParam = {
				_sessionMode = f115_local2,
				_loadoutSlot = "armory"
			}
		} )
		f115_local4( {
			name = @"menu/edit",
			subtitle = "feature/loadouts",
			iconBackground = "$blacktransparent",
			showPregameButton = true
		}, {
			action = CoD.DirectorUtility.OpenCACWithMenuSessionMode,
			actionParam = {
				eMode = f115_local2
			},
			selectIndex = true
		} )
	end
	if f115_local1 == Enum.LobbyMainMode[@"lobby_mainmode_wz"] then
		if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[@"hash_5CB675CA7856DA25"]()) then
			f115_local4( {
				name = @"menu/depot",
				subtitle = @"menu/depot",
				iconBackground = "$blacktransparent",
				showPregameButton = true,
				breadcrumbModel = DataSources.DepotBreadcrumbs.getModel( f115_arg0 )
			}, {
				action = CoD.DirectorUtility.OpenDirectorPersonalizationMenu,
				actionParam = {
					_sessionMode = f115_local2,
					_storageLoadoutBuffer = f115_local3,
					_allowsQuickSelect = true
				}
			} )
		end
		f115_local4( {
			name = @"menu/characters",
			subtitle = @"menu/characters",
			iconBackground = "$blacktransparent",
			showPregameButton = true,
			breadcrumbModel = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded( f115_arg0, f115_local2 )
		}, {
			action = CoD.DirectorUtility.OpenDirectorChangeCharacterMenu,
			actionParam = {
				_sessionMode = f115_local2,
				_storageLoadoutBuffer = f115_local3
			}
		} )
		f115_local4( {
			name = @"menu/armory",
			subtitle = @"menu/armory",
			iconBackground = "$blacktransparent",
			showPregameButton = true,
			trialLocked = IsGameTrial()
		}, {
			action = CoD.DirectorUtility.OpenWZPersonalizeWeaponMenu,
			actionParam = {
				_sessionMode = f115_local2,
				_loadoutSlot = "wzpersonalize"
			},
			selectIndex = true
		} )
	end
	local f115_local5 = CoD.DirectorUtility.CreateOfflineScreenState()
	if f115_arg1.offlineScreenStateSubscription == nil then
		f115_arg1.offlineScreenStateSubscription = f115_arg1:subscribeToModel( f115_local5, function ()
			f115_arg1:updateDataSource()
		end, false )
	end
	if not f115_arg1.occlusionChangeSubscription then
		f115_arg1.occlusionChangeSubscription = true
		f115_arg1.menu:appendEventHandler( "occlusion_change", function ( f118_arg0, f118_arg1 )
			if not f118_arg1.occluded then
				f115_arg1:updateDataSource()
			end
		end )
	end
	CoD.DirectorUtility.AddLobbyNavSubscriptionOnce( f115_arg1 )
	return f115_local0
end )
CoD.DirectorUtility.IsLobbyMenu = function ( f119_arg0, f119_arg1 )
	local f119_local0 = LobbyData.GetCurrentMenuTarget()
	return f119_local0.name == f119_arg1
end
CoD.DirectorUtility.IsMainMode = function ( f120_arg0, f120_arg1 )
	local f120_local0 = LobbyData.GetCurrentMenuTarget()
	return f120_local0[@"mainmode"] == f120_arg1
end
CoD.DirectorUtility.ShowDirectorSelect = function ( f121_arg0 )
	local f121_local0 = LobbyData.GetCurrentMenuTarget()
	local f121_local1 = Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.showSelect" )
	local f121_local2
	if f121_local0.name == LuaEnum.UI.DIRECTOR_ONLINE then
		f121_local2 = f121_local1:get()
		if not f121_local2 then
		
		else
			return f121_local2
		end
	end
	f121_local2 = f121_local0.name == LuaEnum.UI.DIRECTOR_LAN_SELECT
end
CoD.DirectorUtility.ShowDirectorMain = function ( f122_arg0, f122_arg1 )
	local f122_local0 = CoD.ModelUtility.IsSelfModelValueNilOrTrue( f122_arg0, f122_arg1, "available" )
	local f122_local1 = LobbyData.GetCurrentMenuTarget()
	local f122_local2 = Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.showSelect" )
	local f122_local3
	if not (f122_local1.name ~= LuaEnum.UI.DIRECTOR_ONLINE or f122_local2:get()) or f122_local1.name == LuaEnum.UI.DIRECTOR_LAN then
		f122_local3 = f122_local0
	else
		f122_local3 = false
	end
	return f122_local3
end
CoD.DirectorUtility.ShowDirectorPregame = function ( f123_arg0 )
	local f123_local0 = LobbyData.GetCurrentMenuTarget()
	local f123_local1
	if f123_local0.name ~= LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME and f123_local0.name ~= LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME and f123_local0.name ~= LuaEnum.UI.DIRECTOR_ONLINE_WZ_PREGAME then
		f123_local1 = false
	else
		f123_local1 = true
	end
	return f123_local1
end
CoD.DirectorUtility.ShowDirectorPublic = function ( f124_arg0 )
	local f124_local0 = LobbyData.GetCurrentMenuTarget()
	local f124_local1
	if f124_local0.LobbyMode ~= Enum.LobbyMode[@"lobby_mode_public"] or f124_local0[@"isadvertised"] == 0 then
		f124_local1 = false
	else
		f124_local1 = true
	end
	return f124_local1
end
CoD.DirectorUtility.ShowDirectorCustom = function ( f125_arg0, f125_arg1 )
	if not CoD.ModelUtility.IsSelfModelValueNilOrTrue( f125_arg0, f125_arg1, "available" ) then
		return false
	else
		local f125_local0 = LobbyData.GetCurrentMenuTarget()
		return f125_local0.LobbyMode == Enum.LobbyMode[@"lobby_mode_custom"]
	end
end
CoD.DirectorUtility.ShowDirectorPrivate = function ( f126_arg0, f126_arg1 )
	local f126_local0 = LobbyData.GetCurrentMenuTarget()
	local f126_local1
	if f126_local0.LobbyMode ~= Enum.LobbyMode[@"lobby_mode_public"] or f126_local0[@"isadvertised"] ~= 0 then
		f126_local1 = false
	else
		f126_local1 = true
	end
	return f126_local1
end
CoD.DirectorUtility.ShowDirectorTraining = function ( f127_arg0 )
	local f127_local0 = LobbyData.GetCurrentMenuTarget()
	return f127_local0.LobbyMode == Enum.LobbyMode[@"hash_3B3A1BBF18C0B176"]
end
CoD.DirectorUtility.ShowDirectorArena = function ( f128_arg0 )
	local f128_local0 = LobbyData.GetCurrentMenuTarget()
	local f128_local1
	if f128_local0.LobbyMode ~= Enum.LobbyMode[@"lobby_mode_arena"] or f128_local0.LobbyType ~= Enum.LobbyType[@"lobby_type_private"] then
		f128_local1 = false
	else
		f128_local1 = true
	end
	return f128_local1
end
CoD.DirectorUtility.ShowDirectorArenaMatchmaking = function ( f129_arg0 )
	local f129_local0 = LobbyData.GetCurrentMenuTarget()
	local f129_local1
	if f129_local0.LobbyMode ~= Enum.LobbyMode[@"lobby_mode_arena"] or f129_local0.LobbyType ~= Enum.LobbyType[@"lobby_type_game"] then
		f129_local1 = false
	else
		f129_local1 = true
	end
	return f129_local1
end
CoD.DirectorUtility.IsMatchmakingInProgress = function ( f130_arg0 )
	local f130_local0 = LobbyData.GetCurrentMenuTarget()
	if f130_local0.LobbyMode == Enum.LobbyMode[@"lobby_mode_arena"] and f130_local0.LobbyType == Enum.LobbyType[@"lobby_type_game"] then
		return true
	elseif not CoD.ModelUtility.IsGlobalModelValueEqualToEnum( "lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID ) and not CoD.DirectorUtility.ShowDirectorPrivate( nil, f130_arg0 ) then
		return true
	else
		return false
	end
end
CoD.DirectorUtility.ShowDirectorLobbyList = function ( f131_arg0 )
	local f131_local0 = CoD.DirectorUtility.IsMatchmakingInProgress( f131_arg0 )
	if f131_local0 then
		if not CoD.DirectorUtility.IsMainMode( f131_arg0, Enum.eModes.mode_warzone ) then
			f131_local0 = not CoD.DirectorUtility.ShowDirectorPrivate( nil, f131_arg0 )
		else
			f131_local0 = false
		end
	end
	return f131_local0
end
CoD.DirectorUtility.ShowDirectorCustomMatchCoDCasterList = function ( f132_arg0 )
	local f132_local0 = LobbyData.GetCurrentMenuTarget()
	if f132_local0.name == LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY then
		return false
	elseif Engine[@"getlobbyclientcount"]( Enum.LobbyModule[@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"]( Enum.LobbyModule[@"lobby_module_client"] ), Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_local"] ) == 1 and Engine.GetGametypeSetting( "allowspectating" ) == 1 then
		return true
	else
		return false
	end
end
CoD.DirectorUtility[@"hash_61E20A632CB63092"] = function ( f133_arg0 )
	local f133_local0 = LobbyData.GetCurrentMenuTarget()
	local f133_local1 = Engine[@"converttoxhash"]( f133_local0[@"room"] )
	local f133_local2
	if f133_local1 ~= "lobby_pose" and f133_local1 ~= "warzone" and f133_local1 ~= "arena_pose" and f133_local1 ~= "private_lobby_pose" then
		f133_local2 = false
	else
		f133_local2 = true
	end
	return f133_local2
end
CoD.DirectorUtility.ForceNotifyPrivateClientUpdate = function ()
	local f134_local0 = Engine.GetGlobalModel()
	f134_local0.lobbyRoot.privateClient.update:forceNotifySubscriptions()
end
CoD.DirectorUtility.ShowDirectorCustomMatchPartyOverflowList = function ( f135_arg0 )
	local f135_local0 = LobbyData.GetCurrentMenuTarget()
	if f135_local0.name == LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY then
		return false
	end
	local f135_local1 = Engine[@"getteams"]( Enum.LobbyModule[@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"]( Enum.LobbyModule[@"lobby_module_client"] ) )
	for f135_local5, f135_local6 in pairs( f135_local1.clientTeams ) do
		if f135_local6.team == Enum.team_t[@"team_free"] then
			return true
		end
	end
	return false
end
CoD.DirectorUtility.ShowDirectorCustomMatchBotButtons = function ( f136_arg0 )
	local f136_local0 = LobbyData.GetCurrentMenuTarget()
	if Dvar[@"lobby_hostbots"]:get() == true and f136_local0.name ~= LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY then
		local f136_local1 = Engine.GetGlobalModel()
		f136_local1 = f136_local1.MapVote.mapVoteGameModeNext
		if f136_local1 and CoD.GameTypeUtility.DoesGameTypeSupportBots( f136_local1:get() ) then
			return true
		end
	end
	return false
end
CoD.DirectorUtility.ShowDirectorCustomMatchStartButton = function ( f137_arg0 )
	local f137_local0 = LobbyData.GetCurrentMenuTarget()
	if f137_local0.name ~= LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM and f137_local0.name ~= LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM then
		return false
	else
		return Engine[@"islobbyhost"]( Enum.LobbyType[@"lobby_type_private"] )
	end
end
CoD.DirectorUtility.ShowDirectorTheater = function ( f138_arg0 )
	local f138_local0 = LobbyData.GetCurrentMenuTarget()
	return f138_local0.LobbyMode == Enum.LobbyMode[@"lobby_mode_theater"]
end
CoD.DirectorUtility.ShouldShowFillSquadButton = function ()
	local f139_local0 = Engine.GetGlobalModel()
	f139_local0 = f139_local0.lobbyRoot
	if f139_local0.lobbyMainMode:get() ~= Enum.LobbyMainMode[@"lobby_mainmode_wz"] then
		return false
	elseif f139_local0.publicLobby.stage:get() ~= LuaEnum.PUBLIC_LOBBY.INVALID then
		return false
	elseif IsPrivateLobbyFull() then
		return false
	elseif CoD.DirectorUtility.DisableForCurrentMilestone() then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.IsLobbyReadyUp = function ( f140_arg0, f140_arg1 )
	local f140_local0 = Engine.GetGlobalModel()
	local f140_local1 = LobbyData.GetLobbyMenuByID( f140_local0.lobbyRoot.lobbyNav:get() )
	if f140_local1 == nil then
		return false
	else
		local f140_local2
		if f140_local1.id ~= LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE ) and f140_local1.id ~= LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC ) then
			f140_local2 = false
		else
			f140_local2 = true
		end
	end
	return f140_local2
end
CoD.DirectorUtility.WaitingForMorePlayers = function ()
	return (Engine.GetModelValue( Engine.CreateModel( Engine.CreateModel( Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot" ), "lobbyList" ), "playerCount" ) ) or 0) < LuaUtils.GetMinPlayersToStart()
end
CoD.DirectorUtility.IsDirectorButtonOptionLocked = function ( f142_arg0, f142_arg1, f142_arg2 )
	local f142_local0 = f142_arg1
	local f142_local1 = f142_arg1.actionParam
	if f142_local1 then
		if type( f142_arg1.actionParam ) == "table" then
			f142_local1 = f142_arg1.actionParam.eMode
		else
			f142_local1 = false
		end
	end
	if not f142_local1 then
		local f142_local2 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyMainMode" )
		f142_local1 = LuaUtils.GetEModeForLobbyMainMode( f142_local2:get() )
	end
	if CoD.SafeGetModelValue( f142_arg1:getModel(), "locked" ) then
		return true
	elseif not f142_local1 then
		return false
	elseif CoD.CACUtility.IsProgressionEnabled( f142_local1 ) then
		local f142_local3 = f142_arg1:getModel()
		if f142_local3 and f142_local3.featureItemIndex then
			local f142_local4 = f142_local3.featureItemIndex:get()
			if CoD.CACUtility.GetUnlockableItemInfo( f142_local4, f142_local1 ) then
				return Engine.IsItemLocked( f142_arg2, f142_local4, f142_local1 )
			end
		end
	end
	return false
end
CoD.DirectorUtility.ShowForAllClients = function ( f143_arg0, f143_arg1 )
	local f143_local0 = IsLobbyHostOfCurrentMenu()
	local f143_local1 = CoD.ModelUtility.IsSelfModelValueTrue( f143_arg0, f143_arg1, "showForAllClients" )
	local f143_local2 = f143_local0
	local f143_local3
	if not f143_local0 then
		f143_local3 = f143_local1
	else
		f143_local3 = false
	end
	return f143_local3
end
CoD.DirectorUtility.ShouldHideCRMFeatureList = function ( f144_arg0, f144_arg1 )
	if IsGameTrial() and IsBooleanDvarSet( @"hash_31C389A5A38BA7C" ) then
		return false
	end
	local f144_local0 = CoD.MOTDUtility.MOTD_ShouldShowMOTD( f144_arg1 )
	if not f144_local0 then
		f144_local0 = CoD.MOTDUtility.HasMessageAtLocation( f144_arg1, "crm_featured" )
	end
	local f144_local1 = CoD.VideoStreamingUtility.HasLiveEvent( f144_arg1 )
	if f144_local1 then
		f144_local1 = CoD.VideoStreamingUtility.IsLEVFeaturedCardEnabled()
	end
	local f144_local2
	if f144_local0 or f144_local1 then
		f144_local2 = IsLobbyNetworkModeLAN()
	else
		f144_local2 = true
	end
	return f144_local2
end
CoD.DirectorUtility.IsElementMapOrGameTypeSelected = function ( f145_arg0, f145_arg1 )
	local f145_local0 = nil
	local f145_local1 = false
	local f145_local2 = {}
	if f145_arg0.isMapElement or f145_arg0.mapList then
		f145_local0 = Engine[@"converttoxhash"]( Engine[@"lobbygetmap"]() )
		f145_local2 = f145_arg0.mapList or {}
	elseif f145_arg0.isGameTypeElement or f145_arg0.gametypeList then
		f145_local1 = true
		local f145_local3 = DataSources.MapVote.getModel( f145_arg1 )
		if f145_local3.mapVoteGameModeNext then
			f145_local0 = f145_local3.mapVoteGameModeNext:get()
		end
		f145_local2 = f145_arg0.gametypeList or {}
	end
	if f145_local0 then
		local f145_local3 = f145_arg0:getModel( f145_arg1, "id" )
		local f145_local4 = f145_local3 and f145_local3:get()
		if f145_local1 and type( f145_local4 ) == "string" then
			f145_local4 = Engine[@"converttoxhash"]( f145_local4 )
		end
		if f145_local4 == f145_local0 then
			return true
		end
		for f145_local9, f145_local10 in ipairs( f145_local2 ) do
			local f145_local8 = f145_local10.id
			if f145_local1 and type( f145_local8 ) == "string" then
				f145_local8 = Engine[@"converttoxhash"]( f145_local8 )
			end
			if f145_local8 == f145_local0 then
				return true
			end
		end
	end
	return false
end
CoD.DirectorUtility.LobbyListPlayerCountAndMax = function ( f146_arg0 )
	local f146_local0 = Engine.CreateModel( Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot" ), "lobbyList" )
	local f146_local1 = Engine.CreateModel( f146_local0, "playerCount" )
	local f146_local2 = Engine.CreateModel( f146_local0, "maxPlayers" )
	local f146_local3 = Engine.GetModelValue( f146_local1 ) or 0
	local f146_local4 = Engine.GetModelValue( f146_local2 ) or 0
	local f146_local5
	if f146_local3 > 1 then
		f146_local5 = @"hash_A8276D01F6CFB14"
		if not f146_local5 then
		
		else
			return Engine[@"hash_4F9F1239CFD921FE"]( f146_local5, f146_local3, f146_local4 )
		end
	end
	f146_local5 = @"hash_1733142924212699"
end
CoD.DirectorUtility.PrivateLobbyListPlayerCountAndMax = function ( f147_arg0 )
	local f147_local0 = Engine[@"getlobbyclientcount"]( Enum.LobbyModule[@"lobby_module_client"], Enum.LobbyType[@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] )
	local f147_local1 = Engine[@"getlobbymaxclients"]( Enum.LobbyModule[@"lobby_module_client"], Enum.LobbyType[@"lobby_type_private"] )
	local f147_local2
	if f147_local0 > 1 then
		f147_local2 = @"hash_A8276D01F6CFB14"
		if not f147_local2 then
		
		else
			return Engine[@"hash_4F9F1239CFD921FE"]( f147_local2, f147_local0, f147_local1 )
		end
	end
	f147_local2 = @"hash_1733142924212699"
end
CoD.DirectorUtility.TimeRemainingForMatchStart = function ( f148_arg0 )
	if not CoD.isPC and f148_arg0 > 10 then
		return "10+"
	else
		return f148_arg0
	end
end
local f0_local0 = function ( f149_arg0, f149_arg1, f149_arg2 )
	if not CoD.isZombie and IsFirstTimeSetup( f149_arg1, Enum.eModes.mode_multiplayer ) and (not Engine.IsCampaignGame() or not IsFirstTimeSetup( f149_arg1, Enum.eModes.mode_campaign )) then
		return 
	end
	local f149_local0 = f149_arg0.occludedBy
	while f149_local0 ~= nil do
		if f149_local0.occludedBy ~= nil then
			f149_local0 = f149_local0.occludedBy
		end
		if f149_arg2 == true and f149_local0.disableLeaderChangePopupShutdown ~= nil then
			return 
		end
		while f149_local0 and f149_local0.menuName ~= "Director" do
			f149_local0 = GoBack( f149_local0, f149_arg1 )
		end
		Engine.SendClientScriptNotify( f149_arg1, "menu_change" .. Engine.GetLocalClientNum( f149_arg1 ), {
			menu = "Main",
			status = "closeToMenu"
		} )
		LuaUtils.MessageDialogForceSubscriptionFire()
		return 
	end
end
CoD.DirectorUtility.GetDirectorFiltersCardsForMode = function ( f150_arg0, f150_arg1, f150_arg2, f150_arg3 )
	local f150_local0 = {}
	local f150_local1 = CoD.DirectorUtility.GetPlaylists()
	local f150_local2 = #f150_local1
	local f150_local3 = nil
	local f150_local4 = Enum.LobbyMainMode[@"lobby_mainmode_mp"]
	if CoD.DirectorUtility.IsMainMode( f150_arg1, f150_local4 ) then
		for f150_local5 = 1, f150_local2, 1 do
			local f150_local8 = f150_local1[f150_local5]
			if f150_local4 == f150_local8.lobbyMainMode then
				local f150_local9 = CoD.DirectorUtility.CreateFilter( f150_arg1, f150_local8.lobbyMainMode, "Featured", @"menu/featured", @"hash_4F713C5F8E1A479C", f150_local8.entries, f150_arg0._mainMode, IsArenaMode(), true, f150_arg3 )
				if f150_local3 == nil then
					f150_local3 = f150_local9
				end
				for f150_local10 = 1, #f150_local9.cards, 1 do
					table.insert( f150_local3.cards, f150_local9.cards[f150_local10] )
				end
			end
		end
	end
	if f150_local3 and #f150_local3.cards > 0 then
		f150_local0[#f150_local0 + 1] = {}
		f150_local0[#f150_local0] = f150_local3
	end
	local f150_local5 = 1
	for f150_local6 = 1, f150_local2, 1 do
		local f150_local9 = f150_local1[f150_local6]
		if f150_local9.hidden ~= true then
			local f150_local10 = LuaUtils.GetEModeForLobbyMainMode( f150_local9.lobbyMainMode )
			if f150_local10 == nil or LuaUtils.GetDisplayNameForEMode( f150_local10 ) ~= 0x0 then
				local f150_local11 = CoD.DirectorUtility.CreateFilter( f150_arg1, f150_local9.lobbyMainMode, "Grp" .. f150_local5, f150_local9.nameRef, f150_local9.icon, f150_local9.entries, f150_arg2, IsArenaMode(), nil, f150_arg3 )
				if f150_local3 and #f150_local3.cards > 0 then
					for f150_local12 = 1, #f150_local11.cards, 1 do
						if f150_local11.cards[f150_local12] then
							f150_local11.cards[f150_local12].featured = false
						end
					end
				end
				if #f150_local11.cards > 0 then
					f150_local0[#f150_local0 + 1] = {}
					f150_local0[#f150_local0] = f150_local11
				end
			end
			f150_local5 = f150_local5 + 1
		end
	end
	return f150_local0
end
CoD.DirectorUtility.SetupDirectorFiltersCardsForMode = function ( f151_arg0, f151_arg1, f151_arg2 )
	CoD.DirectorUtility.Filters = {}
	CoD.DirectorUtility.Filters = CoD.DirectorUtility.GetDirectorFiltersCardsForMode( f151_arg0, f151_arg1, f151_arg2, false )
	for f151_local3, f151_local4 in ipairs( CoD.DirectorUtility.Filters ) do
		DataSources["DirectorCardList_" .. f151_local4.id] = DataSourceHelpers.ListSetup( "DirectorCardList_" .. f151_local4.id, function ( f152_arg0, f152_arg1 )
			if not f152_arg1.__hasGameUpdateSubscription then
				f152_arg1.__hasGameUpdateSubscription = true
				local f152_local0 = f152_arg1
				local f152_local1 = f152_arg1.subscribeToModel
				local f152_local2 = Engine.GetGlobalModel()
				f152_local1( f152_local0, f152_local2:create( "lobbyRoot.privateClient.update" ), function ()
					f152_arg1:updateDataSource( true )
				end, false )
			end
			return CoD.DirectorUtility.CreateCardListDataSource( f152_arg1, f152_arg0, f151_local4.id, f151_local4 )
		end, true )
	end
	if IsArenaMode() then
		DataSources.DirectorCardList_ArenaNews = DataSourceHelpers.ListSetup( "DirectorCardList_ArenaNews", function ( f154_arg0, f154_arg1 )
			return {}
		end, true )
	end
end
CoD.DirectorUtility.SetupDirectorFiltersCards = function ( f155_arg0, f155_arg1, f155_arg2 )
	CoD.DirectorUtility.SetupDirectorFiltersCardsForMode( f155_arg0, f155_arg1, f155_arg0._mainMode )
end
CoD.DirectorUtility.IsPlaylistShown = function ( f156_arg0 )
	local f156_local0 = IsLobbyNetworkModeLive()
	if f156_local0 then
		f156_local0 = CoD.DirectorUtility.GetPlaylists()
	end
	for f156_local7, f156_local8 in ipairs( f156_local0 or {} ) do
		for f156_local4, f156_local5 in ipairs( f156_local8.entries or {} ) do
			if f156_local5.id == f156_arg0 then
				return not f156_local8.hidden
			end
		end
	end
	return false
end
CoD.DirectorUtility.RegionOnlyAllowsFeaturedPlaylistForMode = function ( f157_arg0, f157_arg1 )
	if f157_arg1 ~= Enum.LobbyMainMode[@"lobby_mainmode_wz"] then
		return false
	end
	local f157_local0 = Dvar[@"ui_wzfeaturedonlycountries"]:get()
	if not f157_local0 then
		return false
	end
	local f157_local1 = ""
	if Dvar[0xA227017683285B]:exists() == true and Dvar[0xA227017683285B]:get() == true then
		Engine.PrintInfo( Enum[@"consolelabel_e"][@"con_label_live"], "RegionOnlyAllowsFeaturedPlaylistForMode: Using geoip\n" )
		local f157_local2 = Engine[@"hash_36D9D7474CDD485B"]()
		if f157_local2 ~= nil then
			local f157_local3, f157_local4 = string.match( f157_local2, "(%a+)-(%a+)" )
			f157_local1 = string.lower( f157_local4 )
		else
			Engine.PrintWarning( Enum[@"consolelabel_e"][@"con_label_live"], "RegionOnlyAllowsFeaturedPlaylistForMode: Couldn't get country code\n" )
		end
	else
		local f157_local2 = Engine[@"hash_56BA9980BA648FB3"]( f157_arg0 )
		f157_local1 = f157_local2.Country
	end
	Engine.PrintInfo( Enum[@"consolelabel_e"][@"con_label_live"], "RegionOnlyAllowsFeaturedPlaylistForMode: Country is " .. f157_local1 .. "\n" )
	for f157_local5 in string.gmatch( f157_local0, "([^,]+)" ) do
		if f157_local5 == f157_local1 then
			return true
		end
	end
	return false
end
CoD.DirectorUtility.IsInLowPopRegion = function ( f158_arg0 )
	local f158_local0 = Dvar[@"hash_19FECDADF7181E65"]:get()
	if not f158_local0 then
		return false
	end
	local f158_local1 = ""
	if Dvar[0xA227017683285B]:exists() == true and Dvar[0xA227017683285B]:get() == true then
		Engine.PrintInfo( Enum[@"consolelabel_e"][@"con_label_live"], "IsInLowPopRegion: Using geoip\n" )
		local f158_local2 = Engine[@"hash_36D9D7474CDD485B"]()
		if f158_local2 ~= nil then
			local f158_local3, f158_local4 = string.match( f158_local2, "(%a+)-(%a+)" )
			f158_local1 = string.lower( f158_local4 )
		else
			Engine.PrintWarning( Enum[@"consolelabel_e"][@"con_label_live"], "IsInLowPopRegion: Couldn't get country code\n" )
		end
	else
		local f158_local2 = Engine[@"hash_56BA9980BA648FB3"]( f158_arg0 )
		f158_local1 = f158_local2.Country
	end
	Engine.PrintInfo( Enum[@"consolelabel_e"][@"con_label_live"], "IsInLowPopRegion: Country is " .. f158_local1 .. "\n" )
	for f158_local5 in string.gmatch( f158_local0, "([^,]+)" ) do
		if f158_local5 == f158_local1 then
			return true
		end
	end
	return false
end
CoD.DirectorUtility.GetPreferredPlaylistForMainMode = function ( f159_arg0, f159_arg1, f159_arg2 )
	local f159_local0 = CoD.LobbyUtility.GetClientList()
	local f159_local1 = LuaUtils.GetAbbreviationForMainMode( f159_arg1 )
	local f159_local2
	if f159_arg2 then
		f159_local2 = "playlist_arena"
		if not f159_local2 then
		
		else
			local f159_local3 = Engine.GetProfileVarInt( f159_arg0, f159_local2 )
			local f159_local4 = Engine[@"getplaylistinfobyid"]( f159_local3 )
			if f159_local4 and f159_local4.mainMode == f159_arg1 and CoD.DirectorUtility.AllMembersHaveAMapInPlaylist( f159_local0, f159_local4 ) and not f159_arg2 and CoD.DirectorUtility.IsPlaylistShown( f159_local3 ) and not CoD.DirectorUtility.RegionOnlyAllowsFeaturedPlaylistForMode( f159_arg0, f159_arg1 ) and (not f159_local4.isQuickplayCard or CoD.DirectorUtility.IsQuickplayAvailableForMode( f159_arg1 )) and (not CoD.isPC or not CoD.PCKoreaUtility.IsPlaylistEntryBlacklisted( f159_local4 )) then
				return f159_local3
			end
			local f159_local5 = IsLobbyNetworkModeLive()
			if f159_local5 then
				f159_local5 = CoD.DirectorUtility.GetPlaylists()
			end
			if f159_local5 then
				for f159_local9, f159_local10 in ipairs( CoD.DirectorUtility.MainScreenModes ) do
					if f159_local10.isVisible() and f159_local10.mainMode == f159_arg1 and f159_local10.arena == f159_arg2 then
						f159_local4 = CoD.DirectorUtility.GetFirstOrFeaturedPlaylistEntry( f159_arg0, f159_local5, f159_local10, false, true )
						if f159_local4 and f159_local4.properties then
							return f159_local4.properties.param.playlist
						end
					end
				end
			end
		end
	end
	f159_local2 = "playlist_" .. f159_local1
end
CoD.DirectorUtility.SetPreferredPlaylistForMainMode = function ( f160_arg0, f160_arg1, f160_arg2, f160_arg3 )
	local f160_local0 = LuaUtils.GetAbbreviationForMainMode( f160_arg1 )
	local f160_local1
	if f160_arg3 then
		f160_local1 = "playlist_arena"
		if not f160_local1 then
		
		else
			Engine.SetProfileVar( f160_arg0, f160_local1, f160_arg2 )
		end
	end
	f160_local1 = "playlist_" .. f160_local0
end
CoD.DirectorUtility.LoadPreferredPlaylist = function ( f161_arg0, f161_arg1, f161_arg2 )
	if f161_arg1 ~= Enum.LobbyMainMode[@"lobby_mainmode_invalid"] then
		local f161_local0 = CoD.DirectorUtility.GetPreferredPlaylistForMainMode( f161_arg0, f161_arg1, f161_arg2 )
		if f161_local0 then
			Engine[@"setplaylistid"]( f161_local0 )
			LuaUtils.SetQuickplayPlaylistID( f161_local0 )
			Engine[@"lobbyevent"]( "OnGameLobbyGameServerDataUpdate", {} )
		end
	end
end
CoD.DirectorUtility.SaveCurrentPlaylistForMainMode = function ( f162_arg0, f162_arg1, f162_arg2 )
	local f162_local0 = Engine.GetGlobalModel()
	f162_local0 = f162_local0.lobbyRoot.lobbyMainMode:get()
	if f162_local0 ~= Enum.LobbyMainMode[@"lobby_mainmode_invalid"] or f162_arg1 ~= nil then
		local f162_local1 = Engine.GetGlobalModel()
		f162_local1 = f162_local1.lobbyRoot.playlistId:get()
		if Engine[@"getplaylistinfobyid"]( f162_local1 ) then
			if f162_local0 ~= Enum.LobbyMainMode[@"lobby_mainmode_invalid"] then
				local f162_local2 = f162_local0
			end
			local f162_local3 = f162_local2 or f162_arg1
			if f162_arg2 then
				local f162_local4 = f162_arg2
			end
			CoD.DirectorUtility.SetPreferredPlaylistForMainMode( f162_arg0, f162_local3, f162_local1, f162_local4 or IsArenaMode() )
		end
	end
end
CoD.DirectorUtility.SetupDirectorStateDefaultFocusCallbacks = function ( f163_arg0, f163_arg1 )
	f163_arg0._stateFocusMap = {}
	f163_arg0._customLobbySavedState = {}
	f163_arg0._updateDefaultFocus = function ()
		f163_arg0:ChangeFocusedElement( f163_arg1, nil, true )
		if f163_arg0:restoreState( f163_arg1 ) then
			
		elseif f163_arg0._stateFocusMap[f163_arg0.currentState] and IsGamepadOrKeyboardNavigation( f163_arg1 ) then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus( f163_arg0, f163_arg0._stateFocusMap[f163_arg0.currentState], f163_arg1 )
		end
	end
	
	LUI.OverrideFunction_CallOriginalFirst( f163_arg0, "setState", f163_arg0._updateDefaultFocus )
	f163_arg0.restoreState = function ( f165_arg0, f165_arg1 )
		if f165_arg0._customLobbySavedState[f165_arg0.currentState] then
			local f165_local0 = LUI.savedMenuStates[f165_arg0.id]
			LUI.savedMenuStates[f165_arg0.id] = f165_arg0._customLobbySavedState[f165_arg0.currentState]
			if CoD.Menu.restoreState( f165_arg0, f165_arg1 ) then
				return true
			else
				LUI.savedMenuStates[f165_arg0.id] = f165_local0
				return CoD.Menu.restoreState( f165_arg0, f165_arg1 )
			end
		else
			return false
		end
	end
	
	f163_arg0.saveState = function ( f166_arg0, f166_arg1 )
		if f166_arg0.currentState then
			f166_arg0._customLobbySavedState[f166_arg0.currentState] = f166_arg0:getSaveStateTable( f166_arg1 )
		end
	end
	
	f163_arg0.clearSavedState = function ( f167_arg0, f167_arg1 )
		if f167_arg0.currentState then
			f167_arg0._customLobbySavedState[f167_arg0.currentState] = nil
		end
	end
	
end
CoD.DirectorUtility.RegisterDirectorStateDefaultFocus = function ( f168_arg0, f168_arg1, f168_arg2 )
	f168_arg0._stateFocusMap[f168_arg2] = f168_arg1
	if f168_arg2 == f168_arg0.currentState then
		f168_arg0.__defaultFocus = f168_arg1
	end
end
CoD.DirectorUtility.ForceStreamedPlaylistImages = {}
CoD.DirectorUtility.ForceStreamPlaylistImages = function ( f169_arg0 )
	local f169_local0 = {}
	for f169_local7, f169_local8 in pairs( CoD.DirectorUtility.GetPlaylists() ) do
		for f169_local4, f169_local5 in ipairs( f169_local8.entries ) do
			if f169_arg0 == Enum.eModes.mode_invalid or f169_arg0 == LuaUtils.GetEModeForLobbyMainMode( f169_local5.mainMode ) then
				CoD.BaseUtility.AddForcedImageToTable( f169_local5.image, f169_local0 )
			end
		end
	end
	CoD.DirectorUtility.ForceStreamedPlaylistImages = CoD.BaseUtility.ForceStreamHelper( CoD.DirectorUtility.ForceStreamedPlaylistImages, f169_local0 )
end
CoD.DirectorUtility.ForceStreamDirectorImagesForMode = function ( f170_arg0, f170_arg1 )
	CoD.CACUtility.ForceStreamCACImages( f170_arg0, f170_arg1 )
	CoD.MapUtility.ForceStreamMapAndGameTypeImages( f170_arg1 )
	CoD.RankUtility.ForceStreamRankIcons( f170_arg1 )
	CoD.DirectorUtility.ForceStreamPlaylistImages( f170_arg1 )
	if CoD.DirectorUtility.PostponingForceStreamedImages then
		CoD.DirectorUtility.PostponeForceStreamedImages( f170_arg0 )
	end
end
CoD.DirectorUtility.PostponingForceStreamedImages = false
CoD.DirectorUtility.PostponeForceStreamedImages = function ( f171_arg0 )
	CoD.BaseUtility.ForceStreamHelper( CoD.CACUtility.ForceStreamedImages, {} )
	CoD.BaseUtility.ForceStreamHelper( CoD.MapUtility.ForceStreamedImages, {} )
	CoD.BaseUtility.ForceStreamHelper( CoD.RankUtility.ForceStreamedRankIcons, {} )
	CoD.BaseUtility.ForceStreamHelper( CoD.DirectorUtility.ForceStreamedPlaylistImages, {} )
	CoD.DirectorUtility.PostponingForceStreamedImages = true
end
CoD.DirectorUtility.ResumeForceStreamedImages = function ( f172_arg0 )
	CoD.BaseUtility.ForceStreamHelper( {}, CoD.CACUtility.ForceStreamedImages )
	CoD.BaseUtility.ForceStreamHelper( {}, CoD.MapUtility.ForceStreamedImages )
	CoD.BaseUtility.ForceStreamHelper( {}, CoD.RankUtility.ForceStreamedRankIcons )
	CoD.BaseUtility.ForceStreamHelper( {}, CoD.DirectorUtility.ForceStreamedPlaylistImages )
	CoD.DirectorUtility.PostponingForceStreamedImages = false
end
CoD.DirectorUtility.GameTypeAllowsBots = function ()
	return CoD.ZombieUtility and CoD.ZombieUtility.GameTypeAllowsBots()
end
CoD.DirectorUtility.IsOfflineScreenStateCustomGame = function ()
	return CoD.ZombieUtility and CoD.ZombieUtility.IsZMOfflineScreenStateCustomGame() or false
end
CoD.DirectorUtility.OfflineNavigateToCustomGames = function ( f175_arg0, f175_arg1 )
	if CoD.ZombieUtility ~= nil then
		CoD.ZombieUtility.ZMOfflineNavigateToCustomGames( f175_arg1 )
	end
end
CoD.DirectorUtility.CreateOfflineScreenState = function ()
	local f176_local0 = Engine.GetGlobalModel()
	return f176_local0:create( "offlineScreenState", true )
end
CoD.DirectorUtility.SetDefaultGameTypeDifficulty = function ( f177_arg0, f177_arg1 )
	if CoD.ZombieUtility and IsZombies() then
		CoD.ZombieUtility.SetDefaultGameTypeZMDifficulty( CoD.SafeGetModelValue( f177_arg1:getModel(), "id" ) )
	end
end
DataSourceHelpers.GlobalDataSourceSetup( "ZMLobbyExclusions", "ZMLobbyExclusions", function ( f178_arg0 )
	local f178_local0 = f178_arg0:create( "PublicMatchExcluded" )
	f178_local0:set( false )
	f178_local0 = f178_arg0:create( "PrivateMatchExcluded" )
	f178_local0:set( false )
	f178_local0 = f178_arg0:create( "PrivateMatchName" )
	f178_local0:set( true )
	f178_local0 = f178_arg0:create( "ZMPrivateDifficulty" )
	f178_local0:set( 1 )
	f178_local0 = f178_arg0:create( "ZMPlaylistTab" )
	f178_local0:set( 1 )
	f178_local0 = f178_arg0:create( "PlaylistMapsString" )
	f178_local0:set( "" )
	f178_local0 = f178_arg0:create( "PlaylistGamemodesString" )
	f178_local0:set( "" )
end, false )
CoD.DirectorUtility.IsMPFirstTimeComplete = function ( f179_arg0 )
	local f179_local0 = Engine.StorageGetBuffer( f179_arg0, Enum.StorageFileType[@"hash_5D5A7695E03A7A90"] )
	local f179_local1 = Engine.StorageGetBuffer( f179_arg0, Enum.StorageFileType[@"storage_mp_stats_online"] )
	if not f179_local0 or not f179_local1 then
		return true
	else
		local f179_local2 = f179_local0.PlayerStatsList.time_played_total.statValue:get()
		local f179_local3 = f179_local1.completedFirstTimeFlow:get()
		if f179_local3 == 0 and f179_local2 > 0 then
			CoD.DirectorUtility.SetMPFirstTimeComplete( f179_arg0, true )
			return true
		elseif f179_local3 == 1 then
			return true
		else
			return false
		end
	end
end
CoD.DirectorUtility.SetMPFirstTimeComplete = function ( f180_arg0, f180_arg1 )
	local f180_local0 = Engine.StorageGetBuffer( f180_arg0, Enum.StorageFileType[@"storage_mp_stats_online"] )
	if f180_local0 then
		local f180_local1 = f180_local0.completedFirstTimeFlow
		if f180_arg1 then
			f180_local1:set( 1 )
			Engine.StorageWrite( f180_arg0, Enum.StorageFileType[@"storage_mp_stats_online"] )
		else
			f180_local1:set( 0 )
		end
	end
end
CoD.DirectorUtility.PostLoad = function ( f181_arg0, f181_arg1 )
	CoD.LobbyUtility.RegisterEventHandlers( f181_arg1 )
	f181_arg1:addMenuOpenedCallback( function ()
		if Engine.CurrentSessionMode() == Enum.eModes.mode_invalid and not f181_arg1._openedEntitlementPopups then
			f181_arg1:registerEventHandler( "entitlement_popups_all_done", function ( element, event )
				if IsKoreaBonusXPSpecialEventActive( f181_arg0 ) then
					CoD.FTUEUtility.ShowFTUESequence( element, f181_arg0, "KoreaSpecialEvent" )
				end
			end )
			f181_arg1._openedEntitlementPopups = true
			CoD.EntitlementUtility.OpenEntitlementPopups( f181_arg0, f181_arg1 )
		end
	end )
	local f181_local0 = DataSources.FreeCursor.getModel( f181_arg0 )
	f181_local0 = f181_local0.hidden
	local f181_local1 = DataSources.FreeCursor.getModel( f181_arg0 )
	f181_local1 = f181_local1.ignoreNextMenuHides
	if f181_local1 and f181_local1:get() then
		f181_local1:set( false )
		f181_local0:set( f181_local0:get() - 1 )
	end
	local f181_local2 = Engine.CurrentSessionMode()
	if f181_local2 ~= Enum.eModes.mode_invalid and f181_local2 ~= Engine.GetMostRecentPlayedMode( f181_arg0 ) then
		Engine.SetMostRecentPlayedMode( f181_local2 )
		Engine.CommitProfileChanges( f181_arg0 )
	end
	local f181_local3 = Engine.GetGlobalModel()
	f181_local3 = f181_local3:create( "lobbyRoot" )
	local f181_local4 = f181_local3:create( "lobbyList" )
	f181_local4 = f181_local4:create( "playerCount" )
	local f181_local5 = f181_local3:create( "playlistID" )
	local f181_local6 = IsLobbyNetworkModeLive()
	if f181_local6 then
		f181_local6 = CoD.DirectorUtility.GetPlaylists()
	end
	if f181_local6 then
		for f181_local13, f181_local14 in ipairs( CoD.DirectorUtility.MainScreenModes ) do
			if f181_local14.isVisible() then
				local f181_local10 = CoD.DirectorUtility.GetPreferredPlaylistForMainMode( f181_arg0, f181_local14.mainMode, f181_local14.arena )
				if not f181_local10 then
					local f181_local11 = CoD.DirectorUtility.GetFirstOrFeaturedPlaylistEntry( f181_arg0, f181_local6, f181_local14 )
					if f181_local11 and f181_local11.properties then
						local f181_local12 = f181_local11.properties.param.playlist
						if Engine[@"getplaylistinfobyid"]( f181_local12 ) then
							CoD.DirectorUtility.SetPreferredPlaylistForMainMode( f181_arg0, f181_local14.mainMode, f181_local12, f181_local14.arena )
						end
					end
				end
				if f181_local14.arena then
					CoD.DirectorUtility.SetPreferredPlaylistForMainMode( f181_arg0, f181_local14.mainMode, f181_local10, f181_local14.arena )
				end
			end
		end
	end
	local f181_local7 = Engine[@"getplaylistinfobyid"]( Engine[@"getplaylistid"]() )
	if f181_local7.hidden then
		Engine[@"setplaylistid"]( CoD.DirectorUtility.GetPreferredPlaylistForMainMode( f181_arg0, Engine[@"getlobbymainmode"](), LuaUtils.IsArenaMode() ) )
	end
	local f181_local8 = Engine[@"hash_632F6BF9B0A31ED5"]()
	if Engine[@"hash_23ADF2C70B61E0EF"]( f181_local8 ) then
		Engine[@"setplaylistid"]( f181_local8 )
	end
	local f181_local9 = {}
	local f181_local13 = f181_local3:create( "lobbyNav" )
	f181_arg1:subscribeToModel( f181_local13, function ( model )
		local modelValue = Engine.GetModelValue( model )
		if modelValue == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.MAIN ) then
			local f184_local1 = CoD.Menu.safeCreateMenu( "Main", f181_arg0 )
			local f184_local2 = f181_arg1:getParent()
			f184_local2:addElement( f184_local1 )
			f181_arg1:close()
			f184_local1:menuOpened( f181_arg0, f184_local1 )
			return 
		end
		DisableAllMenuInput( f181_arg1, false )
		Engine.ForceNotifyModelSubscriptions( Engine.CreateModel( Engine.GetGlobalModel(), "pubstorageFilesChanged" ) )
		CoD.PlayFrontendMusicForLobby( modelValue )
		local f184_local2 = LobbyData.GetLobbyMenuByID( modelValue )
		local f184_local3 = LuaUtils.GetEModeForLobbyMainMode( f184_local2[@"mainmode"] )
		if f184_local3 ~= nil then
			if f184_local3 == Enum.eModes.mode_multiplayer and f184_local2.id == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING ) then
				CoD.FTUEUtility.ShouldBlockMPFTUE = false
			elseif f184_local3 == Enum.eModes.mode_multiplayer and CoD.FTUEUtility.ShouldBlockMPFTUE then
				CoD.FTUEUtility.ShouldBlockMPFTUE = false
			elseif f181_arg1:getParent() then
				if f184_local3 == Enum.eModes.mode_multiplayer then
					if f184_local2.LobbyMode == Enum.LobbyMode[@"lobby_mode_arena"] then
						if not CoD.FTUEUtility.ShowFTUESequenceIfNotSeen( f181_arg1, f181_arg0, "LeaguePlayIntroduction" ) then
							CoD.FTUEUtility.ShowFTUESequenceIfNotSeen( f181_arg1, f181_arg0, "GestureChanges" )
						end
					elseif not CoD.DirectorUtility.IsMPFirstTimeComplete( f181_arg0 ) and CoD.FTUEUtility.SetCurrentSequenceThroughMode( f181_arg1, f181_arg0, f184_local3 ) then
						OpenOverlay( f181_arg1, "FTUEInfoScreen", f181_arg0, nil )
						CoD.DirectorUtility.SetMPFirstTimeComplete( f181_arg0, true )
					else
						CoD.FTUEUtility.ShowFTUESequenceIfNotSeen( f181_arg1, f181_arg0, "GestureChanges" )
					end
				elseif not Engine.IsFirstTimeComplete( f181_arg0, f184_local3 ) and CoD.FTUEUtility.SetCurrentSequenceThroughMode( f181_arg1, f181_arg0, f184_local3 ) then
					OpenOverlay( f181_arg1, "FTUEInfoScreen", f181_arg0, nil )
					Engine.SetFirstTimeComplete( f181_arg0, f184_local3, true )
				elseif f184_local3 == Enum.eModes.mode_warzone then
					CoD.FTUEUtility.ShowFTUESequenceIfNotSeen( f181_arg1, f181_arg0, "GestureChanges" )
				elseif f184_local3 == Enum.eModes.mode_zombies then
					CoD.FTUEUtility.ShowFTUESequenceIfNotSeen( f181_arg1, f181_arg0, "ZMGestureChanges" )
				end
			end
			if f184_local3 ~= Enum.eModes.mode_invalid then
				local f184_local4
				if modelValue ~= LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC ) and modelValue ~= LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING ) then
					f184_local4 = false
				else
					f184_local4 = true
				end
				for f184_local5 = 0, Engine.GetMaxControllerCount() - 1, 1 do
					if Engine.IsControllerBeingUsed( f184_local5 ) then
						CoD.PlayerRoleUtility[@"hash_12B307D12327547E"]( f184_local5 )
						CoD.PlayerRoleUtility[@"hash_4D150AB859D3C2D7"]( f184_local5 )
						CoD.PlayerRoleUtility[@"hash_718E8191AD006E3E"]( f184_local5 )
						CoD.CACUtility[@"hash_5E6E8B9715ECC201"]( f184_local5, f184_local4 )
					end
				end
			end
		end
	end, true )
	local f181_local14, f181_local10, f181_local11 = nil
	local f181_local12 = function ()
		local f185_local0 = Engine.GetGlobalModel()
		f185_local0 = f185_local0:create( "MapVote.mapVoteMapNext" )
		local f185_local1 = f185_local0 and f185_local0:get()
		if not f185_local1 or f185_local1 == 0x0 then
			local f185_local2 = Engine.GetGlobalModel()
			f185_local2 = f185_local2.lobbyRoot.selectedMapId
			f185_local1 = f185_local2 and f185_local2:get()
		end
		local f185_local2 = Engine.GetGlobalModel()
		f185_local2 = f185_local2.lobbyRoot.lobbyNav:get()
		if f185_local2 then
			local f185_local3 = LobbyData.GetLobbyMenuByID( f185_local2 )
			if f185_local3 then
				local f185_local4 = LuaUtils.GetEModeForLobbyMainMode( f185_local3[@"mainmode"] )
				if f185_local4 ~= nil and f185_local4 ~= f181_local14 then
					if f185_local3.LobbyMode ~= Enum.LobbyMode[@"hash_3B3A1BBF18C0B176"] then
						CoD.DirectorUtility.ForceStreamDirectorImagesForMode( f181_arg0, f185_local4 )
						if CoD.DirectorUtility.IsGameTypeCombatTraining( Dvar.g_gametype:get() ) then
							local f185_local5 = LuaUtils.EModeData[f185_local4]
							if f185_local5 then
								SetMap( f181_arg0, f185_local5.DefaultMap, false )
								SetGameType( f181_arg0, f185_local5.DefaultGameType )
							end
						end
					end
				elseif f185_local3[@"mainmode"] == Enum.LobbyMainMode[@"lobby_mainmode_invalid"] then
					CoD.DirectorUtility.ForceStreamDirectorImagesForMode( f181_arg0, Enum.eModes.mode_invalid )
				elseif CoD.DirectorUtility.IsLobbyMenu( f181_arg0, LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME ) and CoD.HUDUtility.IsGameTypeBareBones() then
					SetGameType( f181_arg0, LuaUtils.EModeData[f185_local4].DefaultGameType )
				end
				f181_local14 = f185_local4
				if f185_local4 ~= nil and f185_local4 ~= Enum.eModes.mode_invalid and (f181_local10 ~= f185_local3.name == LuaUtils.LobbyMainModeData[f185_local3[@"mainmode"]].OnlineCustomMenu or f181_local11 ~= f185_local3.name == LuaUtils.LobbyMainModeData[f185_local3[@"mainmode"]].OnlineArenaCustomMenu) then
					if f181_local10 or f181_local11 then
						local f185_local6 = Engine.GetGlobalModel()
						f185_local6 = f185_local6.lobbyRoot:create( "closePopups" )
						f185_local6:forceNotifySubscriptions()
					end
					f181_local10 = f185_local3.name == LuaUtils.LobbyMainModeData[f185_local3[@"mainmode"]].OnlineCustomMenu
					f181_local11 = f185_local3.name == LuaUtils.LobbyMainModeData[f185_local3[@"mainmode"]].OnlineArenaCustomMenu
				end
			end
			if f185_local1 and CoD.mapsTable[f185_local1] then
				if f185_local2 == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM ) and (IsBooleanDvarSet( "use_wz_escape" ) or IsBooleanDvarSet( "use_wz_escape_alt" ) or IsBooleanDvarSet( "use_wz_alt" )) then
					if IsBooleanDvarSet( "use_wz_escape" ) or IsBooleanDvarSet( "use_wz_escape_alt" ) then
						if IsBooleanDvarSet( "use_wz_escape_alt" ) then
							SetMap( f181_arg0, "wz_escape_alt", false )
						else
							SetMap( f181_arg0, "wz_escape", false )
						end
						SetGameType( f181_arg0, "warzone_duo" )
						Engine.SetGametypeSetting( "killcamHistorySeconds", 1800 )
						Engine.SetGametypeSetting( "allowKillcam", 1 )
						Engine.SetGametypeSetting( "maxTeamPlayers", 4 )
						Engine.SetGametypeSetting( "wzPlayerInsertionTypeIndex", 1 )
						Engine.SetGametypeSetting( "wzAIZones", 0 )
						Engine.SetGametypeSetting( "wzZombies", 0 )
					else
						SetMap( f181_arg0, @"wz_open_skyscrapers_alt", false )
					end
				elseif not Engine.IsMapValid( f185_local1 ) and not CoD.LobbyUtility.isMapFree( f185_local1 ) then
					local f185_local4 = LuaUtils.GetDefaultMap( f185_local3 )
					if f185_local4 then
						f185_local4 = Engine[@"converttoxhash"]( f185_local4 )
						if f185_local4 ~= 0x0 and CoD.mapsTable[f185_local4] then
							SetMap( f181_arg0, f185_local4, false )
						end
					end
				end
				if f185_local3[@"mainmode"] == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
					CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory( f181_arg0 )
				end
			end
		end
	end
	
	local f181_local15 = function ()
		if IsLobbyNetworkModeLive() then
			local f186_local0 = f181_local5:get()
			if f186_local0 ~= nil then
				local f186_local1 = Engine[@"getplaylistinfobyid"]( f186_local0 )
				if f186_local1 then
					local f186_local2 = f181_local4:get()
					local f186_local3 = DataSources.ZMLobbyExclusions.getModel()
					local f186_local4 = f186_local3:create( "PublicMatchExcluded" )
					f186_local4:set( f186_local1.excludePublicLobby )
					if f186_local2 ~= 1 then
						f186_local4 = f186_local3:create( "PrivateMatchName" )
						f186_local4:set( true )
					else
						f186_local4 = f186_local3:create( "PrivateMatchName" )
						f186_local4:set( false )
					end
					f186_local4 = Engine[@"getplaylistinfobyid"]( f186_local0 )
					local f186_local5 = f186_local3:create( "PrivateMatchExcluded" )
					local f186_local6 = f186_local5
					f186_local5 = f186_local5.set
					local f186_local7
					if #f186_local4.rotationList <= 1 then
						f186_local7 = not f186_local1.excludePublicLobby
					else
						f186_local7 = true
					end
					f186_local5( f186_local6, f186_local7 )
				end
			end
		end
	end
	
	local f181_local16 = function ()
		if IsLobbyNetworkModeLive() and IsZombies() then
			CoD.DirectorUtility.InitQuickPlayModel( f181_arg0 )
		end
	end
	
	local f181_local17 = function ()
		CoD.DirectorUtility.HideLoadoutPreview( f181_arg0 )
	end
	
	f181_arg1:subscribeToModel( f181_local4, f181_local15, true )
	f181_arg1:subscribeToModel( f181_local5, f181_local15, true )
	f181_arg1:subscribeToModel( f181_local13, f181_local16, true )
	f181_arg1:subscribeToModel( f181_local13, f181_local17, true )
	f181_arg1:subscribeToModel( f181_local13, f181_local12, true )
	local f181_local18 = f181_local3:create( "selectedMapId" )
	local f181_local19 = Engine.GetGlobalModel()
	f181_local19 = f181_local19:create( "MapVote.mapVoteMapNext" )
	f181_arg1:subscribeToModel( f181_local18, f181_local12, true )
	f181_arg1:subscribeToModel( f181_local19, f181_local12, true )
	f181_arg1:subscribeToModel( f181_local3:create( "lobbyMainMode" ), function ( model )
		f0_local0( f181_arg1, f181_arg0, true )
		Engine[@"markpsdatadirty"]( f181_arg0, true )
		if model:get() == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
			Engine.SetDvar( "tu13_enableMPRankedItemPurchasedCheck", 0 )
		else
			Engine.SetDvar( "tu13_enableMPRankedItemPurchasedCheck", 1 )
		end
	end, false )
	f181_arg1:subscribeToModel( f181_local3.privateClient.count, function ( model )
		LuaUtils.ReloadOnlinePlaylists()
	end, false )
	f181_arg1:subscribeToModel( f181_local3:create( "closePopups" ), function ( model )
		f0_local0( f181_arg1, f181_arg0, false )
	end, false )
	f181_arg1.occluded = false
	f181_arg1:subscribeToModel( Engine.CreateModel( Engine.GetGlobalModel(), "pubstorageFilesChanged" ), function ( model )
		if Engine[@"islobbyactive"]( Enum.LobbyModule[@"lobby_module_client"], Enum.LobbyType[@"lobby_type_game"] ) then
			return 
		elseif Engine.GetModelValue( model ) == true and f181_arg1.occluded ~= nil and f181_arg1.occluded == false then
			CoD.OverlayUtility.OpenPublisherFilesChangedOverlay( f181_arg0, f181_arg1 )
		end
	end, false )
	f181_arg1:registerEventHandler( "occlusion_change", function ( element, event )
		element.occluded = event.occluded
		if event.occluded == false then
			Engine.ForceNotifyModelSubscriptions( Engine.CreateModel( Engine.GetGlobalModel(), "pubstorageFilesChanged" ) )
		end
		local f193_local0 = f181_local3:create( "lobbyMenuOccluded" )
		f193_local0:set( event.occluded )
		CoD.DirectorUtility.ClearSelectedClient( event.controller )
		element:OcclusionChange( event )
	end )
	f181_arg1:subscribeToModel( Engine.CreateModel( Engine.GetGlobalModel(), "lobbyDebug.debugEnabled" ), function ( model )
		if Engine.GetModelValue( model ) then
			if not f181_arg1.LobbyDebugyOverlay then
				local f194_local0 = CoD.LobbyDebugOverlay.new( f181_arg1, f181_arg0, 0, 0, 0, CoD.LobbyDebugOverlay.__defaultWidth, 0, 0, 0, CoD.LobbyDebugOverlay.__defaultHeight )
				f194_local0:setLeftRight( true, true, 0, 0 )
				f194_local0:setTopBottom( true, true, 0, 0 )
				f181_arg1:addElement( f194_local0 )
				f181_arg1:sendInitializationEvents( f181_arg0, f194_local0 )
				f181_arg1.LobbyDebugOverlay = f194_local0
			end
		elseif f181_arg1.LobbyDebugOverlay then
			f181_arg1.LobbyDebugOverlay:close()
		end
	end )
	CoD.OptionsUtility.SetGameSettingValidateFunction( "maxPlayers", CoD.DirectorUtility.ValidateMaxPlayers )
	if CoD.isPC then
		CoD.PCUtility.SetupUIMenuShortcuts( f181_arg1, f181_arg0 )
	end
	if Engine.CurrentSessionMode() == Enum.eModes.mode_invalid then
		Engine.ExecNow( f181_arg0, "exec gamedata/configs/common/frontend_gametype_settings.cfg" )
		if IsLobbyNetworkModeLive() and Dvar[@"hash_65ACE5F4E5F09824"]:exists() then
			local f181_local20 = Dvar[@"hash_65ACE5F4E5F09824"]:get()
			if IsGameTrial() then
				Engine[@"setclanname"]( f181_arg0, f181_local20 )
			elseif string.lower( Engine.GetClanName( f181_arg0 ) ) == string.lower( f181_local20 ) then
				Engine[@"hash_267D4F08B41BB4DD"]( f181_arg0 )
			end
		end
	end
	if Engine[@"isdevelopmentbuild"]() then
		CoD.AARUtility.InitAARDevgui( f181_arg1, f181_arg0 )
	end
end
CoD.DirectorUtility.OnDirectorClose = function ( f195_arg0 )
	if DataSources.DirectorPartyList._subscriptionElement then
		DataSources.DirectorPartyList._subscriptionElement:close()
		DataSources.DirectorPartyList._subscriptionElement = nil
	end
	DataSources.DirectorPartyList.OnSubListClose = nil
	DataSources.DirectorPartyList.OnSubscriptionNotified = nil
end
CoD.DirectorUtility.ValidateMaxPlayers = function ( f196_arg0 )
	local f196_local0 = LobbyData.GetCurrentLobbySizes()
	if f196_arg0 >= Engine[@"getlobbyclientcount"]( Enum.LobbyModule[@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"]( Enum.LobbyModule[@"lobby_module_host"] ), Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] ) and f196_arg0 <= f196_local0.maxClients - f196_local0.maxCoDcasterClients then
		return true
	else
		return false
	end
end
CoD.DirectorUtility.TryOpenFreshRestartPopup = function ( f197_arg0, f197_arg1 )
	if not CoD.DirectorUtility.OpenedFreshRestartPopup then
		local f197_local0 = Engine.GetGlobalModel()
		f197_local0 = f197_local0:create( "FreshRestartOccurred", true )
		if f197_local0:get() then
			CoD.DirectorUtility.OpenedFreshRestartPopup = true
			LuaUtils.UI_ShowInfoMessageDialog( f197_arg1, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_776C832471BA98BA" ), Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1C6A9AEDD55F909C" ) )
		end
	end
end
CoD.DirectorUtility.CardNavigateToLobby = function ( f198_arg0, f198_arg1, f198_arg2, f198_arg3, f198_arg4 )
	local f198_local0 = LobbyData.GetCurrentMenuTarget()
	local f198_local1 = f198_arg1:getModel()
	local f198_local2 = f198_local1
	local f198_local3 = f198_local1.mode
	if f198_local3 then
		f198_local3 = f198_local2 and f198_local1.mode:get()
	end
	if not f198_local1 or f198_local3 == Enum.LobbyMainMode[@"lobby_mainmode_invalid"] then
		return 
	end
	local f198_local4 = f198_local1.playlist
	if f198_local4 then
		f198_local4 = f198_local1.playlist:get()
	end
	if IsLobbyNetworkModeLive() then
		if f198_local0.eGameModes == Enum.eGameModes[@"mode_game_theater"] then
			if f198_local0.name ~= LuaEnum.UI.DIRECTOR_ONLINE_THEATER then
				CoD.LobbyUtility.NavigateToLobby( f198_arg4, theaterMenuForMode, false, f198_arg2 )
			end
		elseif f198_local4 > LuaDefine.INVALID_PLAYLIST_ID then
			if f198_local3 == Enum.LobbyMainMode[@"lobby_mainmode_cp"] then
				local f198_local5 = Engine[@"getplaylistinfobyid"]( f198_local4 )
				Dvar[@"cp_queued_level"]:set( f198_local5.rotationList[1].map )
			else
				if f198_local3 == Enum.LobbyMainMode[@"lobby_mainmode_wz"] then
					local f198_local5 = Engine.GetGlobalModel()
					f198_local5 = f198_local5.lobbyRoot.lobbyList.playerCount:get()
					local f198_local6 = Engine[@"getplaylistinfobyid"]( f198_local4 )
					if not f198_local6 or f198_local5 > f198_local6.maxPartySize then
						return 
					end
				end
				if f198_local3 == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
					Engine[@"lobbyevent"]( "OnGameLobbyGameServerDataUpdate", {} )
				end
			end
			if IsArenaMode() then
				Engine[@"runplaylistrules"]( f198_arg2 )
				CoD.ArenaUtility.UpdateArenaOnLobbyNav()
				GoBack( f198_arg0, f198_arg2 )
			else
				local f198_local5 = LuaUtils.LobbyMainModeData[f198_local3].QuickPlaylistTarget
				local f198_local6 = LuaUtils.IsArenaPlaylist( f198_local4 )
				if f198_local6 then
					f198_local5 = LuaUtils.LobbyMainModeData[f198_local3].QuickPlaylistArenaTarget
				end
				Engine[@"setplaylistid"]( f198_local4 )
				LuaUtils.SetQuickplayPlaylistID( f198_local4 )
				if f198_local0.name ~= f198_local5 then
					CoD.LobbyUtility.NavigateToLobby( f198_arg4, f198_local5, false, f198_arg2, f198_local4 )
				else
					CoD.DirectorUtility.SaveCurrentPlaylistForMainMode( f198_arg2, f198_local3, f198_local6 )
					if f198_local3 == Enum.LobbyMainMode[@"lobby_mainmode_wz"] then
						Engine[@"lobbyevent"]( "OnGameLobbyGameServerDataUpdate", {} )
					end
				end
			end
		else
			if f198_local3 == Enum.LobbyMainMode[@"lobby_mainmode_cp"] then
				Dvar[@"cp_queued_level"]:set( Engine.GetSavedMapQueuedMap() )
			end
			local f198_local5 = LuaUtils.LobbyMainModeData[f198_local3].OnlineCustomMenu
			if IsArenaMode() then
				customArenaMenuForMode = LuaUtils.LobbyMainModeData[f198_local3].OnlineArenaCustomMenu
			end
			if f198_local0.name ~= f198_local5 then
				CoD.LobbyUtility.NavigateToLobby( f198_arg4, f198_local5, false, f198_arg2 )
			end
		end
	else
		local f198_local5 = LuaUtils.LobbyMainModeData[f198_local3].LanMenu
		if IsArenaMode() then
			f198_local5 = LuaUtils.LobbyMainModeData[f198_local3].LanArenaMenu
		end
		if f198_local0.name ~= f198_local5 then
			CoD.LobbyUtility.NavigateToLobby( f198_arg4, f198_local5, false, f198_arg2 )
		end
	end
end
CoD.DirectorUtility.NavigateToLobby = function ( f199_arg0, f199_arg1, f199_arg2 )
	CoD.LobbyUtility.NavigateToLobby( f199_arg0, f199_arg2, false, f199_arg1 )
end
CoD.DirectorUtility.NavigateToCustomLobbyForMode = function ( f200_arg0, f200_arg1, f200_arg2, f200_arg3, f200_arg4 )
	local f200_local0 = f200_arg3:getParent()
	f200_local0 = f200_local0:getModel()
	local f200_local1 = f200_arg4
	if f200_local0 and f200_local0.mainMode then
		f200_local1 = f200_local0.mainMode:get()
	end
	if IsLobbyNetworkModeLive() then
		if IsArenaMode() then
			CoD.LobbyUtility.NavigateToLobby( f200_arg1, LuaUtils.LobbyMainModeData[f200_local1].OnlineArenaCustomMenu, false, f200_arg2 )
		else
			CoD.LobbyUtility.NavigateToLobby( f200_arg1, LuaUtils.LobbyMainModeData[f200_local1].OnlineCustomMenu, false, f200_arg2 )
		end
	elseif IsArenaMode() then
		CoD.LobbyUtility.NavigateToLobby( f200_arg1, LuaUtils.LobbyMainModeData[f200_local1].LanArenaMenu, false, f200_arg2 )
	else
		CoD.LobbyUtility.NavigateToLobby( f200_arg1, LuaUtils.LobbyMainModeData[f200_local1].LanMenu, false, f200_arg2 )
	end
end
CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode = function ( f201_arg0, f201_arg1 )
	local f201_local0 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" )
	local f201_local1 = LobbyData.GetLobbyMenuByID( f201_local0:get() )
	local f201_local2 = f201_local1[@"mainmode"]
	if f201_local2 then
		if IsLobbyNetworkModeLive() then
			if IsArenaMode() then
				CoD.LobbyUtility.NavigateToLobby( f201_arg0, LuaUtils.LobbyMainModeData[f201_local2].OnlineArenaCustomMenu, false, f201_arg1 )
			else
				Engine[@"hash_1A3312DC8E11989"]( f201_arg1 )
				CoD.LobbyUtility.NavigateToLobby( f201_arg0, LuaUtils.LobbyMainModeData[f201_local2].OnlineCustomMenu, false, f201_arg1 )
			end
		elseif IsArenaMode() then
			CoD.LobbyUtility.NavigateToLobby( f201_arg0, LuaUtils.LobbyMainModeData[f201_local2].LanArenaMenu, false, f201_arg1 )
		else
			CoD.LobbyUtility.NavigateToLobby( f201_arg0, LuaUtils.LobbyMainModeData[f201_local2].LanMenu, false, f201_arg1 )
		end
	end
end
CoD.DirectorUtility.NavigateToCustomLobby = function ( f202_arg0, f202_arg1, f202_arg2, f202_arg3 )
	CoD.DirectorUtility.NavigateToCustomLobbyForMode( f202_arg0, f202_arg1, f202_arg2, f202_arg3, Enum.LobbyMainMode[@"lobby_mainmode_mp"] )
end
CoD.DirectorUtility.NavigateToPrivateLobbyForCurrentMode = function ( f203_arg0, f203_arg1 )
	local f203_local0 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" )
	local f203_local1 = LobbyData.GetLobbyMenuByID( f203_local0:get() )
	local f203_local2 = f203_local1[@"mainmode"]
	if f203_local2 and IsLobbyNetworkModeLive() then
		CoD.LobbyUtility.NavigateToLobby( f203_arg0, LuaUtils.LobbyMainModeData[f203_local2].PrivateMenu, false, f203_arg1 )
	end
end
CoD.DirectorUtility.IsSessionModeAvailable = function ( f204_arg0, f204_arg1 )
	if Engine[@"hash_77D47312EBA41751"]() or Engine[@"hash_5CB675CA7856DA25"]() then
		return f204_arg1 == Enum.eModes.mode_warzone
	else
		return LuaUtils.GetDisplayNameForEMode( f204_arg1 ) ~= 0x0
	end
end
DataSourceHelpers.GlobalDataSourceSetup( "WarzoneTrialInfo", "WarzoneTrialInfo", function ( f205_arg0 )
	f205_arg0:create( "countdown_timer" )
	CoD.DirectorUtility.TickTrialCountdown()
end, false )
CoD.DirectorUtility.GetTrialEndDate = function ()
	return Dvar[@"trialendtimestamp"]:get()
end
CoD.DirectorUtility.TickTrialCountdown = function ()
	local f207_local0 = Engine.GetGlobalModel()
	f207_local0 = f207_local0:create( "WarzoneTrialInfo" )
	f207_local0 = f207_local0:create( "countdown_timer" )
	local f207_local1 = Engine.GetSecondsRemainingServer( string.format( "%.0f", CoD.DirectorUtility.GetTrialEndDate() ) ) + 1
	if f207_local1 < 0 then
		f207_local1 = 0
	end
	f207_local0:set( LuaUtils.SecondsToTimeRemainingString( f207_local1 ) )
end
CoD.DirectorUtility.EnableTrialTick = function ( f208_arg0 )
	f208_arg0:registerEventHandler( "trial_countdown_tick", function ( element, event )
		CoD.DirectorUtility.TickTrialCountdown()
	end )
	f208_arg0:addElement( LUI.UITimer.new( 1, "trial_countdown_tick", false, f208_arg0 ) )
end
CoD.DirectorUtility.NavigateToArenaLobby = function ( f210_arg0, f210_arg1, f210_arg2, f210_arg3 )
	local f210_local0 = f210_arg3:getParent()
	f210_local0 = f210_local0:getModel()
	local f210_local1 = Enum.LobbyMainMode[@"lobby_mainmode_mp"]
	if f210_local0 and f210_local0.mainMode then
		f210_local1 = f210_local0.mainMode:get()
	end
	if IsLobbyNetworkModeLive() then
		CoD.LobbyUtility.NavigateToLobby( f210_arg1, LuaUtils.LobbyMainModeData[f210_local1].OnlineArenaMenuPregame, false, f210_arg2 )
	end
end
CoD.DirectorUtility.NavigateToArenaMatchmakingLobby = function ( f211_arg0, f211_arg1, f211_arg2, f211_arg3 )
	local f211_local0 = f211_arg3:getParent()
	f211_local0 = f211_local0:getModel()
	local f211_local1 = Enum.LobbyMainMode[@"lobby_mainmode_mp"]
	if f211_local0 and f211_local0.mainMode then
		f211_local1 = f211_local0.mainMode:get()
	end
	if IsLobbyNetworkModeLive() and CoD.DirectorUtility.PrepareSearchPlaylistModels( f211_arg1, f211_arg2 ) then
		CoD.LobbyUtility.NavigateToLobby( f211_arg1, LuaUtils.LobbyMainModeData[f211_local1].OnlineArenaMenuMatchmaking, false, f211_arg2 )
	end
end
CoD.DirectorUtility.SetPrivatePartySuggestion = function ( f212_arg0, f212_arg1 )
	local f212_local0 = Engine[@"hash_91B6247B44FCAFE"]
	local f212_local1 = f212_arg0
	local f212_local2 = Enum.LobbyType[@"lobby_type_private"]
	local f212_local3 = f212_arg1:getModel()
	f212_local0( f212_local1, f212_local2, f212_local3.playlist:get() )
end
CoD.DirectorUtility.ClearPrivatePartySuggestion = function ( f213_arg0, f213_arg1 )
	Engine[@"hash_91B6247B44FCAFE"]( f213_arg0, Enum.LobbyType[@"lobby_type_private"], LuaDefine.INVALID_PLAYLIST_ID )
end
CoD.DirectorUtility.IsPlaylistSuggestedBySelf = function ( f214_arg0, f214_arg1 )
	local f214_local0 = f214_arg1:getModel()
	f214_local0 = f214_local0.playlist:get()
	local f214_local1 = Engine.GetXUID64( f214_arg0 )
	local f214_local2 = Engine.GetGlobalModel()
	return f214_local2.LobbyClients[Engine[@"xuidtostring"]( f214_local1 )].playerSuggestion:get() == f214_local0
end
CoD.DirectorUtility.IsPlaylistCardRestricted = function ( f215_arg0, f215_arg1 )
	local f215_local0 = false
	local f215_local1 = f215_arg1:getModel()
	if f215_local1 and f215_local1.playlist then
		local f215_local2 = f215_local1.playlist:get()
		local f215_local3 = Engine[@"getplaylistminpartysize"]( f215_local2 )
		local f215_local4 = Engine[@"getplaylistmaxpartysize"]( f215_local2 )
		local f215_local5 = Engine.GetPlayerInfo( f215_arg0, Engine.GetXUID64( f215_arg0 ) )
		local f215_local6 = f215_local5.info.partySize
		if f215_local6 >= f215_local3 and f215_local4 >= f215_local6 then
			f215_local0 = false
		else
			f215_local0 = true
		end
	end
	return f215_local0
end
CoD.DirectorUtility.NavigateToTheaterLobby = function ( f216_arg0, f216_arg1, f216_arg2, f216_arg3 )
	if IsLobbyNetworkModeLive() then
		CoD.LobbyUtility.NavigateToLobby( f216_arg1, LuaEnum.UI.DIRECTOR_ONLINE_THEATER, false, f216_arg2 )
	end
end
CoD.DirectorUtility.GetSelectedXuidModel = function ()
	local f217_local0 = DataSources.LobbyRoot.getModel()
	return f217_local0.selectedXuid
end
CoD.DirectorUtility.GetSelectedXuidTeamModel = function ()
	local f218_local0 = DataSources.LobbyRoot.getModel()
	return f218_local0.selectedXuidTeam
end
CoD.DirectorUtility.HasSelectedClient = function ( f219_arg0 )
	local f219_local0 = CoD.DirectorUtility.GetSelectedXuidModel()
	f219_local0 = f219_local0:get()
	local f219_local1
	if f219_local0 == nil or f219_local0 == LuaDefine.INVALID_XUID_X64 then
		f219_local1 = false
	else
		f219_local1 = true
	end
	return f219_local1
end
CoD.DirectorUtility.ClearSelectedClient = function ( f220_arg0 )
	local f220_local0 = CoD.DirectorUtility.GetSelectedXuidModel()
	f220_local0:set( LuaDefine.INVALID_XUID_X64 )
	f220_local0 = CoD.DirectorUtility.GetSelectedXuidTeamModel()
	f220_local0:set( Enum.team_t[@"team_free"] )
end
CoD.DirectorUtility.MoveClient_Internal = function ( f221_arg0, f221_arg1, f221_arg2 )
	local f221_local0 = CoD.DirectorUtility.GetSelectedXuidModel()
	local f221_local1 = {
		controller = f221_arg0,
		requestedTeam = f221_arg1,
		swapXuid = f221_local0:get(),
		lobbyClientType = Enum.LobbyClientType[@"lobby_client_type_normal"]
	}
	if f221_arg2 ~= LuaDefine.INVALID_XUID_X64 then
		f221_local1.withXuid = f221_arg2
	end
	Engine[@"lobbyevent"]( "OnSwitchTeam", f221_local1 )
	f221_local0:set( LuaDefine.INVALID_XUID_X64 )
	local f221_local2 = CoD.DirectorUtility.GetSelectedXuidTeamModel()
	f221_local2:set( Enum.team_t[@"team_free"] )
end
CoD.DirectorUtility.IsClientEmpty = function ( f222_arg0, f222_arg1 )
	local f222_local0 = CoD.SafeGetModelValue( f222_arg1:getModel(), "xuid" )
	local f222_local1
	if f222_local0 and f222_local0 ~= LuaDefine.INVALID_XUID_X64 then
		f222_local1 = false
	else
		f222_local1 = true
	end
	return f222_local1
end
CoD.DirectorUtility.CanSelectClient = function ( f223_arg0, f223_arg1 )
	local f223_local0 = CoD.SafeGetModelValue( f223_arg1:getModel(), "xuid" )
	local f223_local1 = CoD.SafeGetModelValue( f223_arg1:getModel(), "team" )
	local f223_local2 = CoD.DirectorUtility.GetSelectedXuidModel()
	f223_local2 = f223_local2:get()
	if not f223_local0 or not f223_local1 then
		return false
	elseif f223_local2 ~= LuaDefine.INVALID_XUID_X64 then
		return false
	elseif f223_local2 == LuaDefine.INVALID_XUID_X64 and f223_local0 == LuaDefine.INVALID_XUID_X64 then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.SelectClient = function ( f224_arg0, f224_arg1 )
	if not CoD.DirectorUtility.CanSelectClient( f224_arg0, f224_arg1 ) then
		return 
	else
		local f224_local0 = CoD.SafeGetModelValue( f224_arg1:getModel(), "xuid" )
		local f224_local1 = CoD.SafeGetModelValue( f224_arg1:getModel(), "team" )
		local f224_local2 = CoD.DirectorUtility.GetSelectedXuidModel()
		f224_local2:set( f224_local0 )
		f224_local2 = CoD.DirectorUtility.GetSelectedXuidTeamModel()
		f224_local2:set( f224_local1 )
	end
end
CoD.DirectorUtility.CanSwapWithSelectedClient = function ( f225_arg0, f225_arg1 )
	local f225_local0 = CoD.SafeGetModelValue( f225_arg1:getModel(), "xuid" )
	local f225_local1 = CoD.SafeGetModelValue( f225_arg1:getModel(), "team" )
	local f225_local2 = CoD.DirectorUtility.GetSelectedXuidModel()
	f225_local2 = f225_local2:get()
	local f225_local3 = CoD.DirectorUtility.GetSelectedXuidTeamModel()
	f225_local3 = f225_local3:get()
	if not f225_local0 or not f225_local1 then
		return false
	elseif f225_local2 == LuaDefine.INVALID_XUID_X64 or f225_local1 == f225_local3 then
		return false
	elseif f225_local2 == f225_local0 then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.ShouldClientBeActionable = function ( f226_arg0, f226_arg1 )
	local f226_local0 = CoD.DirectorUtility.CanSelectClient( f226_arg0, f226_arg1 )
	if not f226_local0 then
		f226_local0 = CoD.DirectorUtility.CanSwapWithSelectedClient( f226_arg0, f226_arg1 )
	end
	return f226_local0
end
CoD.DirectorUtility.SwapWithSelectedClient = function ( f227_arg0, f227_arg1 )
	if not CoD.DirectorUtility.CanSwapWithSelectedClient( f227_arg0, f227_arg1 ) then
		return 
	else
		CoD.DirectorUtility.MoveClient_Internal( f227_arg0, CoD.SafeGetModelValue( f227_arg1:getModel(), "team" ), CoD.SafeGetModelValue( f227_arg1:getModel(), "xuid" ) )
	end
end
CoD.DirectorUtility.CanMoveSelectedClientToTeam = function ( f228_arg0, f228_arg1 )
	local f228_local0 = CoD.DirectorUtility.GetSelectedXuidModel()
	f228_local0 = f228_local0:get()
	local f228_local1 = CoD.DirectorUtility.GetSelectedXuidTeamModel()
	f228_local1 = f228_local1:get()
	if f228_local0 == LuaDefine.INVALID_XUID_X64 then
		return false
	elseif f228_local0 ~= LuaDefine.INVALID_XUID_X64 and f228_local1 == f228_arg1 then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.MoveSelectedClientToTeam = function ( f229_arg0, f229_arg1 )
	if not CoD.DirectorUtility.CanMoveSelectedClientToTeam( f229_arg0, f229_arg1 ) then
		return 
	else
		CoD.DirectorUtility.MoveClient_Internal( f229_arg0, f229_arg1, LuaDefine.INVALID_XUID_X64 )
	end
end
CoD.DirectorUtility.InitPublicLobbyModels = function ( f230_arg0, f230_arg1, f230_arg2 )
	local f230_local0 = Engine.GetGlobalModel()
	f230_local0 = f230_local0:create( "lobbyRoot.publicLobby" )
	local f230_local1 = f230_local0:create( "stage" )
	f230_local1:set( LuaEnum.PUBLIC_LOBBY.INVALID )
	f230_local1 = f230_local0:create( "stageTitle" )
	f230_local1:set( 0x0 )
	f230_local1 = f230_local0:create( "stageDetails" )
	f230_local1:set( "" )
	f230_local1 = f230_local0:create( "stageLoadedFraction" )
	f230_local1:set( 0 )
	f230_local1 = f230_local0:create( "matchmakingEstimatedTime" )
	f230_local1:set( 35 )
	f230_local1 = f230_local0:create( "matchmakingElapsedTime" )
	f230_local1:set( 0 )
	f230_local1 = f230_local0:create( "matchmakingStartTime" )
	f230_local1:set( 5 )
	f230_local1 = f230_local0:create( "matchmakingIntermissionTime" )
	f230_local1:set( Dvar[@"lobbytimerstatusvotinginterval"]:get() / 1000 )
	f230_local1 = f230_local0:create( "waitingAnimation" )
	f230_local1:set( false )
end
CoD.DirectorUtility.GetMatchmakingEstimatedTimeString = function ( f231_arg0 )
	return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_477D6F0B08C5E000", f231_arg0 )
end
CoD.DirectorUtility.GetMatchmakingElapsedTimeString = function ( f232_arg0 )
	return Engine[@"hash_4F9F1239CFD921FE"]( @"hash_2498E6569F77AEBA", f232_arg0 )
end
CoD.DirectorUtility.GetMatchMakingMatchStartTimeString = function ( f233_arg0 )
	return Engine[@"hash_4F9F1239CFD921FE"]( @"menu/timeremaining_s", f233_arg0 )
end
CoD.DirectorUtility.ConvertLobbyMainModeToModeString = function ( f234_arg0 )
	return LuaUtils.GetDisplayNameForLobbyMainMode( f234_arg0 )
end
CoD.DirectorUtility.ConvertLobbyMainModeToModeOrArenaString = function ( f235_arg0 )
	local f235_local0 = f235_arg0
	if f235_local0 == Enum.eModes.mode_multiplayer and LuaUtils.IsArenaMode() then
		return 0x7D527CD96A3419
	else
		return LuaUtils.GetDisplayNameForLobbyMainMode( f235_local0 )
	end
end
CoD.DirectorUtility.ConvertEModeToModeString = function ( f236_arg0 )
	return LuaUtils.GetDisplayNameForEMode( f236_arg0 )
end
CoD.DirectorUtility.GetModeDisplayName = function ( f237_arg0, f237_arg1 )
	return LuaUtils.GetDisplayNameForEMode( f237_arg0 )
end
CoD.DirectorUtility.LobbyPlayerColorByXUID = function ( f238_arg0 )
	return CoD.ColorUtility.ConvertTableToRGB( Engine[@"islocalclient"]( f238_arg0 ) and ColorSet.PlayerYellow or ColorSet.T8__OFF__GRAY )
end
CoD.DirectorUtility.IsPrimaryLocalClientByXUID = function ( f239_arg0, f239_arg1, f239_arg2 )
	local f239_local0 = f239_arg0:getModel()
	if f239_arg2 ~= "" and f239_local0 then
		f239_local0 = Engine.GetModel( f239_local0, f239_arg2 )
	end
	local f239_local1 = f239_local0 and Engine.GetModelValue( f239_local0 )
	local f239_local2 = Engine.GetXUID64( Engine.GetPrimaryController() )
	local f239_local3
	if f239_local1 == nil or f239_local2 == nil or f239_local2 ~= f239_local1 then
		f239_local3 = false
	else
		f239_local3 = true
	end
	return f239_local3
end
CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel = function ( f240_arg0, f240_arg1, f240_arg2, f240_arg3, f240_arg4 )
	if f240_arg0 then
		local f240_local0 = f240_arg0:create( f240_arg1 )
		local f240_local1 = f240_local0:get()
		if f240_local1 ~= nil and Engine[@"islocalclient"]( f240_local1 ) then
			return CoD.ColorUtility.ConvertTableToRGB( ColorSet.PlayerYellow )
		end
	end
	return f240_arg2, f240_arg3, f240_arg4
end
CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultControllerModel = function ( f241_arg0, f241_arg1, f241_arg2, f241_arg3, f241_arg4 )
	local f241_local0 = Engine.GetModelForController( f241_arg0 )
	local f241_local1 = f241_local0:create( f241_arg1 )
	local f241_local2 = f241_local1:get()
	if f241_local2 and Engine[@"islocalclient"]( f241_local2 ) then
		return CoD.ColorUtility.ConvertTableToRGB( ColorSet.PlayerYellow )
	else
		return f241_arg2, f241_arg3, f241_arg4
	end
end
CoD.DirectorUtility.PartyExceedsPlaylistMax = function ( f242_arg0 )
	local f242_local0 = Engine.GetGlobalModel()
	f242_local0 = f242_local0.lobbyRoot.lobbyList.playerCount:get() or 0
	local f242_local1 = f242_arg0:getModel()
	return (f242_local1.maxPartySize:get() or 0) < f242_local0
end
CoD.DirectorUtility.LobbyMaxPartySizeWarningText = function ( f243_arg0 )
	local f243_local0 = f243_arg0
	local f243_local1 = Engine.GetGlobalModel()
	if f243_local1.lobbyRoot.lobbyList.playerCount:get() <= f243_local0 then
		return ""
	else
		return Engine[@"hash_4F9F1239CFD921FE"]( "menu/too_many_clients_for_game", f243_local0 )
	end
end
CoD.DirectorUtility.ShouldHideMatchmakingEstimatedTime = function ()
	local f244_local0 = Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.publicLobby.matchmakingElapsedTime" )
	local f244_local1 = Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.publicLobby.matchmakingEstimatedTime" )
	if f244_local0 and f244_local1 then
		return Engine.GetModelValue( f244_local1 ) <= Engine.GetModelValue( f244_local0 )
	else
		return false
	end
end
CoD.DirectorUtility.CPOnlineNewGame = function ( f245_arg0, f245_arg1, f245_arg2, f245_arg3 )
	Engine.SwitchCampaignMode( Enum.CampaignMode[0xBC3515387CDAB7] )
	Engine.ResetCampaign()
	local f245_local0 = LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY
	CoD.LobbyUtility.NavigateToLobby( f245_arg1, f245_local0, false, f245_arg2 )
	SetMap( f245_arg2, LuaUtils.GetDefaultMap( LobbyData.GetLobbyMenuByName( f245_local0 ) ), false )
	Engine.SetDvar( "cp_queued_level", "" )
	Engine.SetDvar( "ui_useloadingmovie", "1" )
	Engine.SetDvar( "skipto", "" )
	Engine.SetDvar( "sv_saveGameSkipto", "" )
	Engine.SetDvar( "ui_blocksaves", "0" )
	Engine.SetFirstTimeComplete( f245_arg2, Enum.eModes.mode_campaign, false )
	Engine.SetModelValue( Engine.CreateModel( Engine.GetGlobalModel(), "firstTimeFlowCPConfirm" ), false )
	OpenOverlay( f245_arg1, "ChooseFace", f245_arg2, "", "" )
end
CoD.DirectorUtility.CPOnlineResumeGame = function ( f246_arg0, f246_arg1, f246_arg2, f246_arg3 )
	CoD.LobbyUtility.NavigateToLobby( f246_arg1, LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY, false, f246_arg2 )
end
CoD.DirectorUtility.PlayFrozenMomentForPartyMember = function ( f247_arg0, f247_arg1, f247_arg2, f247_arg3 )
	local f247_local0 = f247_arg3:getModel()
	if f247_local0 then
		f247_local0 = f247_local0.info and f247_local0.info:get()
	end
	if f247_local0 then
		f247_local0 = f247_local0.selectedCharacterType
	end
	if f247_local0 then
		Engine.SendClientScriptNotify( f247_arg2, "update_frozen_moment_character", {
			index = f247_local0:get()
		} )
	end
end
CoD.DirectorUtility.PlayFrozenMomentForLocalClient = function ( f248_arg0 )
	Engine.SendClientScriptNotify( f248_arg0, "update_frozen_moment_character", {
		index = -1
	} )
end
CoD.DirectorUtility.ShowDirectorCustomLobbyModeNav = function ( f249_arg0, f249_arg1 )
	local f249_local0 = LobbyData.GetCurrentMenuTarget()
	if f249_local0.name == f249_arg1 then
		return false
	elseif LobbyConnectedToDedicatedHost() then
		return false
	else
		return Engine[@"islobbyhost"]( f249_local0.LobbyType )
	end
end
CoD.DirectorUtility.AllowShortPressToGoBack = function ( f250_arg0, f250_arg1 )
	if CoD.DirectorUtility.ShowDirectorTheater( f250_arg0, f250_arg1 ) or CoD.DirectorUtility.ShowDirectorPublic( f250_arg0, f250_arg1 ) or CoD.DirectorUtility.ShowDirectorArenaMatchmaking( f250_arg1 ) then
		return false
	elseif CoD.DirectorUtility.ShowDirectorCustom( f250_arg0, f250_arg1 ) and not CoD.DirectorUtility.ShowDirectorPregame( f250_arg0, f250_arg1 ) and not CoD.DirectorUtility.ShowDirectorArena( f250_arg1 ) and (not CoD.ModelUtility.IsGlobalModelValueGreaterThan( "lobbyRoot.lobbyTimeRemaining", 0 ) or not IsLobbyHostOfCurrentMenu()) then
		return false
	elseif CoD.isPC and CoD.DirectorUtility.ShowDirectorSelect( f250_arg0, f250_arg1 ) then
		return false
	else
		return true
	end
end
CoD.DirectorUtility.IsSocialButtonDisabledForDemo = function ( f251_arg0 )
	if not CoD.DirectorUtility.IsOfflineDemo() then
		return false
	else
		return not IsLobbyPrivateHost()
	end
end
CoD.DirectorUtility.DisableForCurrentMilestone = function ( f252_arg0 )
	local f252_local0 = LuaUtils.OnlineOnlyDemo()
	if not f252_local0 then
		f252_local0 = CoD.DirectorUtility.IsOfflineDemo()
	end
	return f252_local0
end
CoD.DirectorUtility.DisableForCurrentMilestoneOrUserContentRestricted = function ( f253_arg0 )
	local f253_local0 = CoD.DirectorUtility.DisableForCurrentMilestone( f253_arg0 )
	if not f253_local0 then
		f253_local0 = Engine.IsUserContentRestricted( f253_arg0 )
	end
	return f253_local0
end
CoD.DirectorUtility.IsDevelopmentOnlyTargetVersion = function ( f254_arg0 )
	if f254_arg0.arena then
		return false
	else
		return CoD.WZUtility.AllowWZOffline()
	end
end
CoD.DirectorUtility.ZombieLimitedShouldOpenStore = function ( f255_arg0 )
	local f255_local0
	if f255_arg0 == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
		f255_local0 = Engine[@"hash_45405A6484A88367"]()
		if f255_local0 then
			f255_local0 = IsCommerceEnabledOnPC()
			if f255_local0 then
				f255_local0 = CoD.BaseUtility.IsDvarEnabled( "loot_enableIGS" )
			end
		end
	else
		f255_local0 = false
	end
	return f255_local0
end
CoD.DirectorUtility.ModifyAmplitudeBasedOnVoipStatus = function ( f256_arg0, f256_arg1, f256_arg2, f256_arg3 )
	f256_arg1:linkToElementModel( f256_arg0, "voipStatus", true, function ( model )
		local f257_local0 = model:get()
		local f257_local1 = 0
		if f257_local0 == Enum[@"hash_6B5FD9E48749F3BC"][@"hash_73BCCB00011FC920"] or f257_local0 == Enum[@"hash_6B5FD9E48749F3BC"][@"hash_DBA2B10D2AEAC8A"] then
			f257_local1 = 1
		end
		if f256_arg1._previousValue <= f257_local1 then
			f256_arg1:beginAnimation( f256_arg3, Enum[@"luitween"][@"luitween_ease_out"] )
		else
			f256_arg1:beginAnimation( f256_arg2, Enum[@"luitween"][@"luitween_ease_out"] )
		end
		f256_arg1:setShaderVector( 0, f257_local1, 0, 0, 0 )
		f256_arg1._previousValue = f257_local1
	end )
	f256_arg1._previousValue = 1
	f256_arg1:setShaderVector( 0, 1, 0, 0, 0 )
end
CoD.DirectorUtility.UpdateVOIPStatusForModel = function ( f258_arg0, f258_arg1, f258_arg2 )
	if not f258_arg1 then
		return 
	end
	local f258_local0 = f258_arg1[f258_arg2]
	if f258_local0 then
		f258_local0 = f258_arg1[f258_arg2]:get()
	end
	if not f258_local0 then
		return 
	end
	local f258_local1 = f258_arg1:create( "voipStatus" )
	f258_arg0:setupVoipWidget( f258_local0 )
end
CoD.DirectorUtility.NeedsWatermark = function ()
	local f259_local0
	if not CoD.isPC then
		f259_local0 = CoD.DirectorUtility.IsOnlineOnlyDemo()
	else
		f259_local0 = false
	end
	return f259_local0
end
CoD.DirectorUtility.IsOfflineOnlyDemo = function ()
	local f260_local0
	if not CoD.isPC then
		f260_local0 = LuaUtils.OfflineOnlyDemo()
	else
		f260_local0 = false
	end
	return f260_local0
end
CoD.DirectorUtility.IsOfflineDemo = function ()
	local f261_local0
	if not CoD.isPC and LuaUtils.GetDisplayNameForLobbyMainMode( Enum.LobbyMainMode[@"lobby_mainmode_zm"] ) == 0x0 and not LuaUtils.OnlineOnlyDemo() then
		f261_local0 = not Engine[@"hash_5CB675CA7856DA25"]()
	else
		f261_local0 = false
	end
	return f261_local0
end
CoD.DirectorUtility.IsOnlineOnlyDemo = function ()
	local f262_local0
	if not CoD.isPC then
		f262_local0 = LuaUtils.OnlineOnlyDemo()
	else
		f262_local0 = false
	end
	return f262_local0
end
CoD.DirectorUtility.DisableLeaderChangeShutdown = function ( f263_arg0 )
	f263_arg0.disableLeaderChangePopupShutdown = true
end
CoD.DirectorUtility.IsNumClientsExceeded = function ( f264_arg0 )
	if IsLobbyNetworkModeLive() then
		local f264_local0 = Engine.GetGlobalModel()
		f264_local0 = f264_local0:create( "lobbyRoot.playlistId" )
		local f264_local1 = Engine[@"getplaylistinfobyid"]( f264_local0:get() )
		local f264_local2 = Engine.GetGlobalModel()
		if f264_local1 and f264_local2.lobbyRoot.lobbyMainMode:get() == f264_local1.mainMode then
			local f264_local3 = Engine.GetGlobalModel()
			f264_local3 = f264_local3:create( "lobbyRoot.lobbyList.playerCount" )
			if f264_local1.maxPartySize < f264_local3:get() then
				return true
			end
		end
	end
	return false
end
CoD.DirectorUtility.OpenTooManyClientsPopup = function ( f265_arg0, f265_arg1 )
	if IsLobbyNetworkModeLive() then
		local f265_local0 = Engine.GetGlobalModel()
		f265_local0 = f265_local0:create( "lobbyRoot.playlistId" )
		local f265_local1 = Engine[@"getplaylistinfobyid"]( f265_local0:get() )
		OpenGenericSmallPopup( f265_arg0, f265_arg1, Engine[@"hash_4F9F1239CFD921FE"]( @"menu/warning" ), Engine[@"hash_4F9F1239CFD921FE"]( "menu/too_many_clients_for_game", f265_local1.maxPartySize ), nil, CoD.isPC and Engine[@"hash_4F9F1239CFD921FE"]( @"menu/ok" ) or nil )
	end
end
CoD.DirectorUtility.AllClientsOwnDLCForPlaylist = function ( f266_arg0 )
	local f266_local0 = CoD.LobbyUtility.GetClientList()
	if IsLobbyNetworkModeLive() then
		local f266_local1 = Engine.GetGlobalModel()
		f266_local1 = f266_local1:create( "lobbyRoot.playlistId" )
		local f266_local2 = Engine[@"getplaylistinfobyid"]( f266_local1:get() )
		local f266_local3 = Engine.GetGlobalModel()
		if f266_local2 and f266_local3.lobbyRoot.lobbyMainMode:get() == f266_local2.mainMode then
			return CoD.DirectorUtility.AllMembersHaveAMapInPlaylist( f266_local0, f266_local2 )
		end
	end
	return false
end
CoD.DirectorUtility.AllClientsOwnDLCForMap = function ( f267_arg0 )
	local f267_local0 = CoD.LobbyUtility.GetClientList()
	local f267_local1 = Engine.GetGlobalModel()
	f267_local1 = f267_local1:create( "lobbyRoot.selectedMapId" )
	return CoD.MapUtility.AllMembersHaveDLCMap( f267_local0, f267_local1:get() )
end
CoD.DirectorUtility.OpenMapsNotEnabledPopup = function ( f268_arg0, f268_arg1 )
	OpenGenericSmallPopup( f268_arg0, f268_arg1, Engine[@"hash_4F9F1239CFD921FE"]( @"menu/warning" ), Engine[@"hash_4F9F1239CFD921FE"]( @"hash_1C103184D0E20B3B" ), nil, CoD.isPC and Engine[@"hash_4F9F1239CFD921FE"]( @"menu/ok" ) or nil )
end
CoD.DirectorUtility.AllMembersHaveAMapInPlaylist = function ( f269_arg0, f269_arg1 )
	if f269_arg1.rotationList and #f269_arg1.rotationList > 0 then
		for f269_local3, f269_local4 in ipairs( f269_arg1.rotationList ) do
			if CoD.MapUtility.AllMembersHaveDLCMap( f269_arg0, f269_local4.map ) then
				return true
			end
		end
	end
	return false
end
CoD.DirectorUtility.SetLocalClientsReady = function ()
	local f270_local0 = 0
	local f270_local1 = Engine.GetMaxLocalControllers() - 1
	local f270_local2 = LobbyData.GetCurrentMenuTarget()
	local f270_local3 = f270_local2.LobbyType
	for f270_local4 = f270_local0, f270_local1, 1 do
		Engine[@"setreadyup"]( f270_local4, f270_local3, not Engine[@"getreadyup"]( Engine[@"islobbyhost"]( f270_local3 ) and Enum.LobbyModule[@"lobby_module_host"] or Enum.LobbyModule[@"lobby_module_client"], f270_local3, f270_local4 ) )
	end
end
CoD.DirectorUtility.SetPlayerReady = function ( f271_arg0 )
	local f271_local0 = LobbyData.GetCurrentMenuTarget()
	local f271_local1 = f271_local0.LobbyType
	local f271_local2 = Engine[@"getreadyup"]( Engine[@"islobbyhost"]( f271_local1 ) and Enum.LobbyModule[@"lobby_module_host"] or Enum.LobbyModule[@"lobby_module_client"], f271_local1, f271_arg0 )
	local f271_local3 = 0
	local f271_local4 = Engine.GetMaxLocalControllers() - 1
	for f271_local5 = f271_local3, f271_local4, 1 do
		if Engine.IsControllerBeingUsed( f271_local5 ) then
			Engine[@"setreadyup"]( f271_local5, f271_local1, not f271_local2 )
		end
	end
end
CoD.DirectorUtility.GetPlayerReady = function ( f272_arg0 )
	local f272_local0 = LobbyData.GetCurrentMenuTarget()
	local f272_local1 = f272_local0.LobbyType
	return Engine[@"getreadyup"]( Engine[@"islobbyhost"]( f272_local1 ) and Enum.LobbyModule[@"lobby_module_host"] or Enum.LobbyModule[@"lobby_module_client"], f272_local1, f272_arg0 )
end
CoD.DirectorUtility.CanReadyUp = function ( f273_arg0 )
	local f273_local0 = LobbyData.GetCurrentMenuTarget()
	local f273_local1 = f273_local0.LobbyType
	local f273_local2
	if not Engine[@"getreadyup"]( Engine[@"islobbyhost"]( f273_local1 ) and Enum.LobbyModule[@"lobby_module_host"] or Enum.LobbyModule[@"lobby_module_client"], f273_local1, f273_arg0 ) then
		f273_local2 = CoD.DirectorUtility.InReadyStage( f273_arg0 )
	else
		f273_local2 = false
	end
	return f273_local2
end
CoD.DirectorUtility.CanReadyDown = function ( f274_arg0 )
	local f274_local0 = LobbyData.GetCurrentMenuTarget()
	local f274_local1 = f274_local0.LobbyType
	return Engine[@"getreadyup"]( Engine[@"islobbyhost"]( f274_local1 ) and Enum.LobbyModule[@"lobby_module_host"] or Enum.LobbyModule[@"lobby_module_client"], f274_local1, f274_arg0 ) and CoD.DirectorUtility.InReadyStage( f274_arg0 )
end
CoD.DirectorUtility.InReadyStage = function ( f275_arg0 )
	local modelValue = Engine.GetModelValue( Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" ) )
	local f275_local1 = modelValue == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE )
	local f275_local2 = modelValue == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC )
	if f275_local1 then
		return true
	elseif f275_local2 then
		local f275_local3 = Engine.GetGlobalModel()
		f275_local3 = f275_local3:create( "lobbyRoot.publicLobby" )
		local f275_local4 = f275_local3:create( "stage" )
		f275_local4 = f275_local4:get()
		local f275_local5
		if f275_local4 == nil or f275_local4 ~= LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3 and f275_local4 ~= LuaEnum.PUBLIC_LOBBY.START_MATCH then
			f275_local5 = false
		else
			f275_local5 = true
		end
		return f275_local5
	else
		return false
	end
end
CoD.DirectorUtility.GetPrivateMatchName = function ( f276_arg0 )
	if f276_arg0 then
		return @"menu/private_match"
	else
		return @"menu/solo_match"
	end
end
CoD.DirectorUtility.UsingLobbyPoses = function ( f277_arg0 )
	if IsLobbyNetworkModeLAN() then
		return false
	end
	local f277_local0 = DataSources.LobbyRoot.getModel( f277_arg0 )
	f277_local0 = f277_local0.room:get()
	local f277_local1
	if f277_local0 ~= "lobby_pose" and f277_local0 ~= "arena_pose" and f277_local0 ~= "private_lobby_pose" then
		f277_local1 = false
	else
		f277_local1 = true
	end
	return f277_local1
end
CoD.DirectorUtility.AddFeaturedWidgetListAction = function ( f278_arg0, f278_arg1, f278_arg2 )
	f278_arg0:AddButtonCallbackFunction( f278_arg0, f278_arg2, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, function ( f279_arg0, f279_arg1, f279_arg2, f279_arg3 )
		if CoD.DirectorUtility.ShowDirectorSelect( f279_arg2 ) and f278_arg1.activeWidget and not f278_arg1.m_disableNavigation then
			ProcessListAction( f278_arg1, f278_arg1.activeWidget, f279_arg2, f279_arg1 )
		end
		return true
	end )
end
CoD.DirectorUtility.SubscribeForSoloMatchLobbyTitle = function ( f280_arg0 )
	if CoD.ZombieUtility ~= nil then
		CoD.ZombieUtility.SubscribeForSoloMatchLobbyTitle( f280_arg0 )
	end
end
CoD.DirectorUtility.GetMainModeByLobbyNav = function ()
	local f281_local0 = Engine.GetGlobalModel()
	local f281_local1 = LobbyData.GetLobbyMenuByID( f281_local0.lobbyRoot.lobbyNav:get() )
	if f281_local1 then
		return f281_local1[@"mainmode"]
	else
		return Enum.LobbyMainMode[@"lobby_mainmode_invalid"]
	end
end
CoD.DirectorUtility.HideLoadoutPreview = function ( f282_arg0 )
	if CoD.ZombieUtility then
		CoD.ZombieUtility.HideZMLoadoutPreview( f282_arg0 )
	else
		local f282_local0 = DataSources.DirectorZMLoadoutPreview.getModel( f282_arg0 )
	end
end
CoD.DirectorUtility.IsLoadoutPreviewWidgetShown = function ( f283_arg0 )
	return CoD.ZombieUtility and CoD.ZombieUtility.IsZMLoadoutPreviewWidgetShown( f283_arg0 )
end
CoD.DirectorUtility.InitQuickPlayModel = function ( f284_arg0 )
	if CoD.ZombieUtility then
		CoD.ZombieUtility.InitTutorialQuickPlayModel( f284_arg0 )
	end
end
DataSourceHelpers.PerControllerDataSourceSetup( "DirectorZMLoadoutPreview", "DirectorZMLoadoutPreview", function ( f285_arg0, f285_arg1 )
	local f285_local0 = f285_arg0:create( "ZMLoadoutPreviewWidgetPrivate" )
	f285_local0:set( "CoD.NOTHING" )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewWidgetPublic" )
	f285_local0:set( "CoD.NOTHING" )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewWidgetCustom" )
	f285_local0:set( "CoD.NOTHING" )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewWidgetShown" )
	f285_local0:set( false )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewInfoShown" )
	f285_local0:set( false )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewItemName" )
	f285_local0:set( "" )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewItemDesc" )
	f285_local0:set( 0x0 )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewItemImage" )
	f285_local0:set( 0x0 )
	f285_local0 = f285_arg0:create( "ZMLoadoutPreviewItemIsRestricted" )
	f285_local0:set( false )
end, false )
DataSourceHelpers.GlobalDataSourceSetup( "DirectorCharacterButtonZMList", "DirectorCharacterButtonZMList", function ( f286_arg0, f286_arg1 )
	local f286_local0 = {}
	local f286_local1 = DataSources.LobbyClients.getModel( f286_arg1 )
	for f286_local2 = 1, CoD.PlayerRoleUtility.MAX_SUPPORTED_LOBBY_CLIENTS, 1 do
		local f286_local5 = {
			model = f286_local1[f286_local2]
		}
		if IsZombies() and CoD.ZombieUtility then
			local f286_local6 = f286_local5.model.xuid
			if f286_local6 and f286_local6:get() then
				local f286_local7 = CoD.ZombieUtility.GetPositionDraftClient( f286_arg1, f286_local6:get() )
				if f286_local7 then
					local f286_local8 = f286_local7.characterIndex
					if f286_local8 then
						f286_local8 = f286_local7.characterIndex:get()
					end
					if f286_local8 then
						local f286_local9 = Engine.GetHeroBundleInfo( Enum.eModes.mode_zombies, f286_local8 )
						if f286_local9 and f286_local9 ~= 0 then
							f286_local5.bundle = f286_local9
						end
					end
				end
			end
		end
		table.insert( f286_local0, f286_local5 )
	end
	if IsZombies() and CoD.ZombieUtility then
		f286_local0 = CoD.ZombieUtility.OrderCharacterButtonZMList( f286_arg0, f286_arg1, f286_local0 )
	end
	for f286_local2 = 1, #f286_local0, 1 do
		local f286_local5 = f286_arg0:create( f286_local2 )
		f286_local5:set( f286_local0[f286_local2].model )
	end
end, false )
CoD.DirectorUtility.IsBotByXuid = function ( f287_arg0, f287_arg1 )
	local f287_local0 = CoD.SafeGetModelValue( f287_arg0:getModel(), f287_arg1 )
	return f287_local0 and Engine[@"hash_65CB8E6B7FBBFFD5"]( f287_local0 )
end
CoD.DirectorUtility.UpdateDescriptionTextFromSelectMenu = function ( f288_arg0, f288_arg1 )
	local f288_local0 = 0x0
	if f288_arg1 then
		f288_local0 = CoD.SafeGetModelValue( f288_arg1:getModel(), "description" ) or 0x0
	end
	local f288_local1 = DataSources.LobbyRoot.getModel( f288_arg0 )
	f288_local1.selectScreenDescription:set( f288_local0 )
end
CoD.DirectorUtility.IsInvalidLobbyClientInfo = function ( f289_arg0, f289_arg1 )
	local f289_local0 = CoD.SafeGetModelValue( f289_arg0:getModel(), f289_arg1 )
	local f289_local1 = Engine.GetGlobalModel()
	local f289_local2
	if f289_local0 ~= nil and f289_local0 ~= f289_local1.LobbyClients:create( Engine[@"xuidtostring"]( LuaDefine.INVALID_XUID_X64 ) ) then
		f289_local2 = false
	else
		f289_local2 = true
	end
	return f289_local2
end
CoD.DirectorUtility.IsHostOfLobbyType = function ( f290_arg0 )
	return Engine[@"islobbyhost"]( f290_arg0 )
end
CoD.DirectorUtility.ShouldLockFindMatchButton = function ( f291_arg0 )
	if IsZombies() then
		return true
	else
		return CoD.SocialUtility.IsPartyMissingRequiredDLCForSelectedPlaylist( f291_arg0 )
	end
end
CoD.DirectorUtility.ShouldShowFindMatchError = function ( f292_arg0 )
	if IsMultiplayer() then
		return CoD.SocialUtility.IsPartyMissingRequiredDLCForSelectedPlaylist( f292_arg0 )
	else
		return false
	end
end
CoD.DirectorUtility.LoadPlaylistFileFromLPC = function ()
	Engine[@"hash_1348A01BF0F3BCCE"]( 0 )
end
CoD.DirectorUtility.LoadFFOTDFileFromLPC = function ()
	Engine[@"hash_1348A01BF0F3BCCE"]( 1 )
end
CoD.DirectorUtility.GetColorForDisplayRankText = function ( f295_arg0 )
	if f295_arg0 then
		return CoD.ColorUtility.ConvertTableToRGB( ColorSet.PlayerParagonOrange )
	else
		return CoD.ColorUtility.ConvertTableToRGB( ColorSet.T8__BEIGE__HEADER )
	end
end
CoD.DirectorUtility.GetRankColorForPLevel = function ( f296_arg0 )
	local f296_local0 = Engine.CreateModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyMainMode" )
	local f296_local1 = LuaUtils.GetEModeForLobbyMainMode( f296_local0:get() )
	if IsGameModeParagonCapable( f296_local1 ) and Engine.GetPrestigeCap( f296_local1 ) <= f296_arg0 then
		return CoD.ColorUtility.ConvertTableToRGB( ColorSet.PlayerParagonOrange )
	else
		return CoD.ColorUtility.ConvertTableToRGB( ColorSet.T8__OFF__GRAY )
	end
end
CoD.OverlayUtility.AddAutoDetectOverlay( "AppLoadoutConfirmLoadout", {
	menuName = "SystemOverlay_Compact",
	title = @"hash_685E4E247DA8817C",
	description = @"hash_275346BBB59A1D8B",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	options = function ()
		local f297_local0 = function ( f298_arg0, f298_arg1 )
			CoD.OverlayUtility.ShowToast( nil, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_367B78DCFF483B23" ), "" )
			CoD.DirectorUtility.AcceptAppLoadout( f298_arg1, Enum.eModes.mode_multiplayer )
			Engine[@"hash_45217EA14A38494C"]( f298_arg1 )
			OpenOverlay( GoBack( f298_arg0, f298_arg1 ), "MPCustomizeClassMenu", f298_arg1, {
				_sessionMode = Enum.eModes.mode_multiplayer
			} )
		end
		
		local f297_local1 = function ( f299_arg0, f299_arg1 )
			CoD.OverlayUtility.ShowToast( nil, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_3C263BC8DC1F47D0" ), "" )
			Engine[@"hash_45217EA14A38494C"]( f299_arg1 )
			OpenOverlay( GoBack( f299_arg0, f299_arg1 ), "MPCustomizeClassMenu", f299_arg1, {
				_sessionMode = Enum.eModes.mode_multiplayer
			} )
		end
		
		local f297_local2 = {}
		table.insert( f297_local2, {
			text = @"menu/accept",
			action = f297_local0
		} )
		table.insert( f297_local2, {
			text = @"menu/decline",
			action = f297_local1
		} )
		return f297_local2
	end
} )
CoD.DirectorUtility.IsCompanionAppEnabled = function ()
	return CoD.BaseUtility.IsDvarEnabled( "live_use_companion_app" ) and CoD.BaseUtility.IsDvarEnabled( "live_companion_app_loadouts" )
end
CoD.DirectorUtility.AppLoadoutReady = function ( f301_arg0 )
	if CoD.BaseUtility.IsDvarEnabled( "ui_debugAppLoadout" ) then
		return true
	elseif Engine.StorageIsFileReady( f301_arg0, Enum.StorageFileType[@"hash_5492E24872A65D74"] ) then
		local f301_local0 = Engine.StorageGetBuffer( f301_arg0, Enum.StorageFileType[@"hash_5492E24872A65D74"] )
		if f301_local0 and f301_local0.loadoutVersion:get() == Dvar[@"loadoutversionmp"]:get() then
			return true
		end
	end
	return false
end
CoD.DirectorUtility.InitCompanionApp = function ( f302_arg0, f302_arg1 )
	local f302_local0 = Engine.GetModelForController( f302_arg1 )
	local f302_local1 = f302_local0:create( "extLoadoutReady" )
	f302_local1:set( false )
	f302_arg0:subscribeToModel( f302_local1, function ( model )
		if CoD.DirectorUtility.AppLoadoutReady( f302_arg1 ) then
			CoD.OverlayUtility.ShowToast( "ContentLarge", Engine[@"hash_4F9F1239CFD921FE"]( @"hash_48152CCDA4092F26" ), Engine[@"hash_4F9F1239CFD921FE"]( @"hash_5F38CEC3ADA4E7C1" ) )
		end
	end, false )
end
CoD.DirectorUtility.ShouldShowAppLoadoutAvailable = function ( f304_arg0, f304_arg1 )
	local f304_local0 = CoD.DirectorUtility.IsCompanionAppEnabled()
	local f304_local1
	if Engine.CurrentSessionMode() == Enum.eModes.mode_multiplayer then
		f304_local1 = not LuaUtils.IsArenaMode()
	else
		f304_local1 = false
	end
	return f304_local1 and CoD.DirectorUtility.AppLoadoutReady( f304_arg1 ) and f304_local0 and Engine.SessionMode_IsPublicOnlineGame()
end
CoD.DirectorUtility.AcceptAppLoadout = function ( f305_arg0, f305_arg1 )
	if f305_arg1 ~= Enum.eModes.mode_multiplayer then
		return 
	end
	local f305_local0 = Engine.StorageGetBuffer( f305_arg0, Enum.StorageFileType[@"storage_mp_loadouts"] )
	local f305_local1 = Engine.StorageGetBuffer( f305_arg0, Enum.StorageFileType[@"hash_5492E24872A65D74"] )
	if f305_local0 and f305_local1 then
		local f305_local2 = f305_local0.cacLoadouts
		if f305_local2 then
			f305_local2 = f305_local0.cacLoadouts.customClass
		end
		local f305_local3 = f305_local1.cacLoadouts
		if f305_local3 then
			f305_local3 = f305_local1.cacLoadouts.customClass
		end
		local f305_local4 = f305_local0.cacLoadouts
		if f305_local4 then
			f305_local4 = f305_local0.cacLoadouts.customClassName
		end
		local f305_local5 = f305_local1.cacLoadouts
		if f305_local5 then
			f305_local5 = f305_local1.cacLoadouts.customClassName
		end
		if f305_local2 and f305_local3 then
			for f305_local6 = Enum[@"loadoutclass_t"][@"custom_class_first"], Enum[@"loadoutclass_t"][@"custom_class_count"] - 1, 1 do
				CoDLoadoutsShared.CopyClassLoadout( f305_local2[f305_local6], f305_local3[f305_local6], f305_arg1 )
				f305_local4[f305_local6]:set( f305_local5[f305_local6]:get() )
			end
			Engine[@"saveloadout"]( f305_arg0, f305_arg1 )
		end
	end
end
CoD.DirectorUtility.CreditsPostLoad = function ( f306_arg0, f306_arg1 )
	if CursorInputEnabledForBuild() then
		f306_arg0:setHandleMouse( true )
		f306_arg0.ImageWithButtonPrompt:setHandleMouse( true )
	end
	f306_arg0.__disableAutoButtonCallback = true
	f306_arg0.Credit0:setupCredit( f306_arg1 )
	local f306_local0 = function ()
		return false
	end
	
	f306_arg0.sticksDown = 0
	local f306_local1 = function ()
		SetProperty( f306_arg0, "showPrompt", true )
		PlayClipOnElement( f306_arg0, {
			elementName = "skipPrompt",
			clipName = "Show"
		}, f306_arg1 )
		PlayClipOnElement( f306_arg0, {
			elementName = "speedUpPrompt",
			clipName = "Show"
		}, f306_arg1 )
	end
	
	local f306_local2 = function ()
		SetProperty( f306_arg0, "showPrompt", false )
		PlayClipOnElement( f306_arg0, {
			elementName = "skipPrompt",
			clipName = "Hide"
		}, f306_arg1 )
		PlayClipOnElement( f306_arg0, {
			elementName = "speedUpPrompt",
			clipName = "Hide"
		}, f306_arg1 )
		if f306_arg0.skipHideTimer then
			f306_arg0.skipHideTimer:close()
			f306_arg0.skipHideTimer = nil
		end
	end
	
	local f306_local3 = function ()
		f306_arg0.skipHideTimer = LUI.UITimer.newElementTimer( 5000, true, f306_local2 )
		f306_arg0:addElement( f306_arg0.skipHideTimer )
	end
	
	local f306_local4 = function ( f311_arg0, f311_arg1, f311_arg2, f311_arg3 )
		if f306_arg0.sticksDown == 0 then
			if f306_arg0.skipHideTimer then
				f306_arg0.skipHideTimer:reset()
			else
				f306_local1()
				f306_local3()
			end
		end
	end
	
	local f306_local5 = function ( f312_arg0, f312_arg1, f312_arg2, f312_arg3 )
		if PropertyIsTrue( f306_arg0, "showPrompt" ) then
			Engine.playsound( "uin_paint_decal_nav" )
			if InFrontend() then
				GoBack( f312_arg1, f312_arg2 )
			else
				SendOwnMenuResponse( f312_arg1, f312_arg2, "skip" )
			end
		else
			f306_local4( f312_arg0, f312_arg1, f312_arg2, f312_arg3 )
		end
		return true
	end
	
	local f306_local6 = function ( f313_arg0, f313_arg1, f313_arg2, f313_arg3 )
		if IsDpadButton( f313_arg3 ) then
			f306_local4( f313_arg0, f313_arg1, f313_arg2, f313_arg3 )
		end
	end
	
	local f306_local7 = function ()
		if f306_arg0.skipHideTimer then
			f306_arg0.skipHideTimer:close()
			f306_arg0.skipHideTimer = nil
		else
			f306_local1()
			f306_local3()
		end
	end
	
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_left"], nil, f306_local6, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_up"], nil, f306_local6, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_right"], nil, f306_local6, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_down"], nil, f306_local6, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ESCAPE", f306_local5, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], nil, f306_local4, f306_local0, false )
	if LUI.DEV == nil then
		f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_back"], nil, f306_local4, f306_local0, false )
	end
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_start"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_lb"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_rb"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_ltrig"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_rtrig"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_lstick_pressed"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_rstick_pressed"], nil, f306_local4, f306_local0, false )
	f306_arg0:AddButtonCallbackFunction( f306_arg0, f306_arg1, Enum.LUIButton[@"lui_key_none"], "SPACE", f306_local7, false, false )
	local f306_local8 = {
		x = false,
		y = false
	}
	local f306_local9 = function ( f315_arg0, f315_arg1, f315_arg2 )
		local f315_local0 = Engine.GetModelValue( f315_arg1 )
		local f315_local1 = f315_local0 and math.abs( f315_local0 ) > 0.2
		if f315_local1 and not f306_local8[f315_arg2] then
			if f306_arg0.skipHideTimer then
				f306_arg0.skipHideTimer:close()
				f306_arg0.skipHideTimer = nil
			elseif f306_arg0.sticksDown == 0 then
				f306_local1()
			end
			f306_arg0.sticksDown = f306_arg0.sticksDown + 1
		elseif not f315_local1 and f306_local8[f315_arg2] then
			f306_arg0.sticksDown = f306_arg0.sticksDown - 1
			if f306_arg0.sticksDown == 0 then
				f306_local3()
			end
		end
		f306_local8[f315_arg2] = f315_local1
	end
	
	f306_arg0:subscribeToGlobalModel( f306_arg1, "RightStick", "X", function ( model )
		f306_local9( f306_arg1, model, "x" )
	end )
	f306_arg0:subscribeToGlobalModel( f306_arg1, "RightStick", "Y", function ( model )
		f306_local9( f306_arg1, model, "y" )
	end )
end
CoD.DirectorUtility.LiveEventViewerPreLoad = function ( f318_arg0, f318_arg1 )
	f318_arg0:setOwner( f318_arg1 )
	f318_arg0.buttonModel = Engine.CreateModel( Engine.GetModelForController( f318_arg1 ), "LiveEventViewer.buttonPrompts" )
	if CoD.isPC then
		f318_arg0:setHandleMouse( true )
		f318_arg0.ImageWithButtonPrompt:setHandleMouse( true )
	end
	local f318_local0 = function ()
		return false
	end
	
	local f318_local1 = function ()
		return true
	end
	
	local f318_local2 = function ()
		SetProperty( f318_arg0, "showPrompt", true )
		f318_arg0:setState( f318_arg1, "ShowPrompts" )
	end
	
	local f318_local3 = function ()
		SetProperty( f318_arg0, "showPrompt", false )
		f318_arg0:setState( f318_arg1, "DefaultState" )
		if f318_arg0.skipHideTimer then
			f318_arg0.skipHideTimer:close()
			f318_arg0.skipHideTimer = nil
		end
	end
	
	local f318_local4 = function ()
		f318_arg0.skipHideTimer = LUI.UITimer.newElementTimer( 5000, true, f318_local3 )
		f318_arg0:addElement( f318_arg0.skipHideTimer )
	end
	
	local f318_local5 = function ( f324_arg0, f324_arg1, f324_arg2, f324_arg3 )
		if f318_arg0.skipHideTimer then
			f318_arg0.skipHideTimer:reset()
		else
			f318_local2()
			f318_local4()
		end
	end
	
	local f318_local6 = function ( f325_arg0, f325_arg1, f325_arg2, f325_arg3 )
		if PropertyIsTrue( f318_arg0, "showPrompt" ) then
			GoBack( f325_arg1, f325_arg2 )
		else
			f318_local5( f325_arg0, f325_arg1, f325_arg2, f325_arg3 )
		end
		return true
	end
	
	local f318_local7 = AlwaysFalse()
	if f318_local7 then
		local f318_local8 = function ( f326_arg0, f326_arg1, f326_arg2, f326_arg3 )
			if PropertyIsTrue( f318_arg0, "showPrompt" ) and CoD.VideoStreamingUtility.IsMLGStream( f326_arg2 ) then
				OpenPopup( f326_arg1, "LiveEventViewerQualities", f326_arg2 )
				f318_local3()
			else
				f318_local5( f326_arg0, f326_arg1, f326_arg2, f326_arg3 )
			end
			return true
		end
		
	end
	local f318_local8 = function ( f327_arg0, f327_arg1, f327_arg2, f327_arg3 )
		if PropertyIsTrue( f318_arg0, "showPrompt" ) then
			if IsChildElementInState( f327_arg1, "LiveEventViewerMovieAndBackground", "Windowed" ) then
				SetElementStateByElementName( f327_arg1, "LiveEventViewerMovieAndBackground", f327_arg2, "DefaultState" )
				CoD.Menu.UpdateButtonShownState( f327_arg0, f327_arg1, f327_arg2, Enum.LUIButton[@"lui_key_xby_pstriangle"] )
				return true
			else
				SetElementStateByElementName( f327_arg1, "LiveEventViewerMovieAndBackground", f327_arg2, "Windowed" )
				CoD.Menu.UpdateButtonShownState( f327_arg0, f327_arg1, f327_arg2, Enum.LUIButton[@"lui_key_xby_pstriangle"] )
				return true
			end
		else
			f318_local5( f327_arg0, f327_arg1, f327_arg2, f327_arg3 )
		end
	end
	
	local f318_local9 = function ( f328_arg0, f328_arg1, f328_arg2, f328_arg3 )
		if IsDpadButton( f328_arg3 ) then
			f318_local5( f328_arg0, f328_arg1, f328_arg2, f328_arg3 )
		end
	end
	
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_left"], nil, f318_local9, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_up"], nil, f318_local9, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_right"], nil, f318_local9, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_down"], nil, f318_local9, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, f318_local5, f318_local0, false )
	if LUI.DEV == nil then
		f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_back"], nil, f318_local5, f318_local0, false )
	end
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_start"], nil, f318_local5, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_lb"], nil, f318_local5, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_rb"], nil, f318_local5, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_ltrig"], nil, f318_local5, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_rtrig"], nil, f318_local5, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_lstick_pressed"], nil, f318_local5, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_rstick_pressed"], nil, f318_local5, f318_local0, false )
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, f318_local6, function ( f329_arg0, f329_arg1, f329_arg2 )
		CoD.Menu.SetButtonLabel( f329_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], "menu/exit_live_event_viewer" )
		return true
	end, false )
	if f318_local7 then
		f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, squareButtonPress, function ( f330_arg0, f330_arg1, f330_arg2 )
			CoD.Menu.SetButtonLabel( f330_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], "menu/mlg_current_quality" )
			if CoD.VideoStreamingUtility.IsMLGStream( f330_arg2 ) then
				return true
			else
				return true
			end
		end, false )
	end
	f318_arg0:AddButtonCallbackFunction( f318_arg0, f318_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], nil, f318_local8, function ( f331_arg0, f331_arg1, f331_arg2 )
		if f331_arg1.LiveEventViewerMovieAndBackground and IsChildElementInState( f331_arg1, "LiveEventViewerMovieAndBackground", "Windowed" ) then
			CoD.Menu.SetButtonLabel( f331_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], @"menu/fullscreen" )
			return true
		else
			CoD.Menu.SetButtonLabel( f331_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], "menu/windowed" )
			return true
		end
	end, false )
end
CoD.DirectorUtility.LiveEventViewerPostLoad = function ( f332_arg0, f332_arg1 )
	CoD.PlayFrontendMusic( "" )
	Dvar[@"ui_liveeventvieweropen"]:set( true )
	LUI.OverrideFunction_CallOriginalSecond( f332_arg0, "close", function ( element )
		Dvar[@"ui_liveeventvieweropen"]:set( false )
		local f333_local0 = CoD.SafeGetModelValue( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" )
		if f333_local0 then
			CoD.PlayFrontendMusicForLobby( f333_local0 )
		end
	end )
end
CoD.DirectorUtility.ShowBonusForYourBOPass = function ( f334_arg0 )
	return CoDShared.Loot.GetBOPassTierBoost( f334_arg0 ) ~= 0
end
CoD.DirectorUtility.ShowBonusForPartyMemberBOPass = function ( f335_arg0 )
	return CoDShared.Loot.GetBOPassPartyTierBoost( f335_arg0 ) ~= 0
end
