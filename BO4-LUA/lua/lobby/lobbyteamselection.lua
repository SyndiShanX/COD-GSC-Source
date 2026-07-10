
require( "x64:53e8db3768fb02a" )
require( "x64:2f7767db3f402c" )
require( "x64:b5d5f7ffe97a9a7" )
Lobby.TeamSelection = {}
Lobby.TeamSelection.DONT_SWITCH = -1
Lobby.TeamSelection.TEAM_SWITCH_DELAY = 1500
Lobby.TeamSelection.LOCAL_CLIENT_COUNT = 4
Lobby.TeamSelection.Clients = {}
Lobby.TeamSelection.lastGameMode = ""
Lobby.TeamSelection.gameSetting = {}
Lobby.TeamSelection.random = math.random()
Lobby.TeamSelection.TeamIdToString = function ( f1_arg0 )
	if f1_arg0 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		return "ALLIES"
	elseif f1_arg0 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		return "AXIS"
	elseif f1_arg0 == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
		return "CASTER"
	else
		return "FREE"
	end
end
Lobby.TeamSelection.ShouldAssignToTeam = function ( f2_arg0 )
	local f2_local0 = f2_arg0.lobbyModule
	local f2_local1 = f2_arg0.lobbyType
	local f2_local2 = f2_arg0.lobbyMode
	local f2_local3 = LobbyData.GetCurrentMenuTarget()
	if not f2_local3 then
		return false
	elseif f2_local3[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0xD5FBB8D74AC6D62] or f2_local0 == Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] then
		return false
	elseif f2_local3[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7B50049993542C0] then
		return true
	elseif f2_local3[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
		return true
	elseif f2_local3[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x79D01499920B292] then
		return true
	elseif f2_local3[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x78C124999125C42] then
		return true
	else
		return false
	end
end
Lobby.TeamSelection.ClearTeam = function ( f3_arg0 )
	Engine[0x860FE74C09F6C9B]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] ), f3_arg0 )
end
Lobby.TeamSelection.AutoAssignPlayers = function ( f4_arg0 )
	local f4_local0 = f4_arg0 ~= nil
	local f4_local1 = LobbyData.GetCurrentMenuTarget()
	local f4_local2 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
	local f4_local3 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f4_local2 )
	local f4_local4 = Engine[0x17B32C04C4BE462]( f4_local2 )
	local f4_local5 = LobbyData.GetCurrentLobbySizes()
	local f4_local6 = Engine[0x44FC97037CE42ED]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f4_local2, Enum[0x575E471C039DBD6][0x8A42AF1547AB4DF] )
	local f4_local7
	if f4_local6 ~= 1 or Engine[0xDBC2AD5002B261B]( "allowSpectating" ) ~= 1 then
		f4_local7 = false
	else
		f4_local7 = true
	end
	if f4_local0 == false then
		Lobby.TeamSelection.StoreGamesetting( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f4_local2, f4_local4 )
		Engine[0x860FE74C09F6C9B]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f4_local2 )
	end
	local f4_local8 = #f4_local3.sessionClients
	local f4_local9 = 0
	local f4_local10 = 0
	local f4_local11 = 0
	local f4_local12 = 0
	for f4_local16, f4_local17 in ipairs( f4_local3.sessionClients ) do
		if f4_local17.team == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f4_local9 = f4_local9 + 1
		end
		if f4_local17.team == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f4_local10 = f4_local10 + 1
		end
		if f4_local17.team == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			f4_local11 = f4_local11 + 1
		end
		if f4_local17.team == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] then
			f4_local12 = f4_local12 + 1
		end
	end
	f4_local13 = {
		currTarget = f4_local1,
		lobbyType = f4_local2,
		session = f4_local3,
		maxClients = f4_local5.maxClients,
		maxLaunchClients = f4_local5.maxLaunchClients,
		maxCoDcasterClients = f4_local5.maxCoDcasterClients,
		maxLocalClients = f4_local5.maxLocalClients,
		maxLocalClientsNetwork = f4_local5.maxLocalClientsNetwork,
		localClientCount = f4_local6,
		codCasterEnabled = f4_local7,
		clientJoining = f4_local0,
		joinedClientXuid = f4_arg0,
		clientCount = f4_local8,
		alliesCount = f4_local9,
		axisCount = f4_local10,
		codcasterCount = f4_local11,
		overflowCount = f4_local12
	}
	if f4_arg0 ~= nil then
		Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.TeamSelection.AutoAssignPlayers for joining client start.\n" )
		Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby List\n" )
		Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------------------\n" )
		for f4_local17, f4_local18 in ipairs( f4_local3.sessionClients ) do
			if f4_local18.xuid ~= xuid then
				Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "(" .. tostring( f4_local17 ) .. ") " .. f4_local18.gamertag .. " - lobbyID(" .. tostring( f4_local18.lobbyID ) .. ") 
			end
		end
		Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------------------\n" )
	end
	if f4_local1[0xEB7DDC7F079D51B] ~= Enum[0x89C1455C5032969][0xD5FBB8D74AC6D62] then
		f4_local14 = {
			[Enum[0x89C1455C5032969][0x7B50049993542C0]] = Lobby.TeamSelection.AutoAssignPlayersCP,
			[Enum[0x89C1455C5032969][0x7E41449995CD57E]] = Lobby.TeamSelection.AutoAssignPlayersMP,
			[Enum[0x89C1455C5032969][0x79D01499920B292]] = Lobby.TeamSelection.AutoAssignPlayersZM,
			[Enum[0x89C1455C5032969][0x78C124999125C42]] = Lobby.TeamSelection.AutoAssignPlayersWZ
		}
		if Dvar[0x4BADE8473F0165F]:get() == true and f4_local4 ~= Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] then
			Lobby.MatchmakingAsync.AssignTeams( f4_local2, true, true )
		else
			f4_local14[f4_local1[0xEB7DDC7F079D51B]]( f4_local13 )
		end
	end
end
Lobby.TeamSelection.AutoAssignPlayersForMode = {}
Lobby.TeamSelection.AutoAssignPlayersCP = function ( f5_arg0 )
	local f5_local0 = f5_arg0.lobbyType
	local f5_local1 = f5_arg0.joinedClientXuid
	if f5_arg0.clientJoining == false then
		for f5_local5, f5_local6 in ipairs( f5_arg0.session.sessionClients ) do
			if f5_local5 <= f5_arg0.maxLaunchClients then
				if f5_local5 % 2 == 1 then
					Engine[0xD506AB0E93540B3]( f5_local0, f5_local6.xuid, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
				else
					Engine[0xD506AB0E93540B3]( f5_local0, f5_local6.xuid, Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
					goto basicblock_10:
				end
			end
			if f5_arg0.codCasterEnabled and f5_local5 <= f5_arg0.maxLaunchClients + f5_arg0.maxCoDcasterClients then
				Engine[0xD506AB0E93540B3]( f5_local0, f5_local6.xuid, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
			end
		end
	elseif f5_arg0.alliesCount + f5_arg0.axisCount < f5_arg0.maxLaunchClients then
		local f5_local2 = Engine[0xD506AB0E93540B3]
		local f5_local3 = f5_local0
		local f5_local4 = f5_local1
		local f5_local5 = f5_arg0.alliesCount
		local f5_local6 = f5_arg0.axisCount
		f5_local2( f5_local3, f5_local4, REG12 and Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
	elseif f5_arg0.codCasterEnabled and f5_arg0.codcasterCount < f5_arg0.maxCoDcasterClients then
		Engine[0xD506AB0E93540B3]( f5_local0, f5_local1, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
	else
		Engine[0xD506AB0E93540B3]( f5_local0, f5_local1, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
	end
end
Lobby.TeamSelection.AutoAssignPlayersMP = function ( f6_arg0 )
	local f6_local0 = f6_arg0.lobbyType
	local f6_local1 = f6_arg0.joinedClientXuid
	if f6_arg0.clientJoining == false then
		if CoDShared.IsGametypeTeamBased() then
			for f6_local5, f6_local6 in ipairs( f6_arg0.session.sessionClients ) do
				if f6_local5 <= f6_arg0.maxLaunchClients then
					if f6_local5 % 2 == 1 then
						Engine[0xD506AB0E93540B3]( f6_local0, f6_local6.xuid, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
					else
						Engine[0xD506AB0E93540B3]( f6_local0, f6_local6.xuid, Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
						goto basicblock_11:
					end
				end
				if f6_arg0.codCasterEnabled and f6_local5 <= f6_arg0.maxLaunchClients + f6_arg0.maxCoDcasterClients then
					Engine[0xD506AB0E93540B3]( f6_local0, f6_local6.xuid, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
				end
			end
		else
			for f6_local5, f6_local6 in ipairs( f6_arg0.session.sessionClients ) do
				if f6_local5 <= f6_arg0.maxLaunchClients then
					Engine[0xD506AB0E93540B3]( f6_local0, f6_local6.xuid, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
				end
				if f6_arg0.codCasterEnabled and f6_local5 <= f6_arg0.maxLaunchClients + f6_arg0.maxCoDcasterClients then
					Engine[0xD506AB0E93540B3]( f6_local0, f6_local6.xuid, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
				end
			end
		end
	elseif f6_arg0.alliesCount + f6_arg0.axisCount < f6_arg0.maxLaunchClients then
		if CoDShared.IsGametypeTeamBased() then
			local f6_local2 = Engine[0xD506AB0E93540B3]
			local f6_local3 = f6_local0
			local f6_local4 = f6_local1
			local f6_local5 = f6_arg0.alliesCount
			local f6_local6 = f6_arg0.axisCount
			f6_local2( f6_local3, f6_local4, REG12 and Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
		else
			Engine[0xD506AB0E93540B3]( f6_local0, f6_local1, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
		end
	elseif f6_arg0.codCasterEnabled and f6_arg0.codcasterCount < f6_arg0.maxCoDcasterClients then
		Engine[0xD506AB0E93540B3]( f6_local0, f6_local1, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
	else
		Engine[0xD506AB0E93540B3]( f6_local0, f6_local1, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
	end
end
Lobby.TeamSelection.AutoAssignPlayersZM = function ( f7_arg0 )
	local f7_local0 = f7_arg0.lobbyType
	local f7_local1 = f7_arg0.joinedClientXuid
	if f7_arg0.clientJoining == false then
		for f7_local5, f7_local6 in ipairs( f7_arg0.session.sessionClients ) do
			if f7_local5 <= f7_arg0.maxLaunchClients then
				Engine[0xD506AB0E93540B3]( f7_local0, f7_local6.xuid, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
			end
			if f7_arg0.codCasterEnabled and f7_local5 <= f7_arg0.maxLaunchClients + f7_arg0.maxCoDcasterClients then
				Engine[0xD506AB0E93540B3]( f7_local0, f7_local6.xuid, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
			end
		end
	elseif f7_arg0.alliesCount < f7_arg0.maxLaunchClients then
		Engine[0xD506AB0E93540B3]( f7_local0, f7_local1, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
	elseif f7_arg0.codCasterEnabled and f7_arg0.codcasterCount < f7_arg0.maxCoDcasterClients then
		Engine[0xD506AB0E93540B3]( f7_local0, f7_local1, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
	else
		Engine[0xD506AB0E93540B3]( f7_local0, f7_local1, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
	end
end
Lobby.TeamSelection.AutoAssignPlayersWZ = function ( f8_arg0 )
	local f8_local0 = f8_arg0.lobbyType
	local f8_local1 = f8_arg0.joinedClientXuid
	local f8_local2 = CoDShared.GetGametypeMaxTeamPlayers()
	local f8_local3 = 1
	if f8_local2 > 0 then
		f8_local3 = math.floor( f8_arg0.maxLaunchClients / f8_local2 )
	end
	if f8_arg0.clientJoining == false then
		for f8_local7, f8_local8 in ipairs( f8_arg0.session.sessionClients ) do
			if f8_local7 <= f8_arg0.maxLaunchClients then
				Engine[0xD506AB0E93540B3]( f8_local0, f8_local8.xuid, (f8_local7 - 1) % f8_local3 + 1 )
			end
		end
	else
		local f8_local4 = {}
		for f8_local5 = 1, f8_local3, 1 do
			f8_local4[f8_local5] = 0
		end
		for f8_local8, f8_local9 in ipairs( f8_arg0.session.sessionClients ) do
			if f8_local4[f8_local9.team] then
				f8_local4[f8_local9.team] = f8_local4[f8_local9.team] + 1
			end
		end
		f8_local5 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
		for f8_local9, f8_local10 in pairs( f8_local4 ) do
			if f8_local10 < f8_local4[f8_local5] then
				f8_local5 = f8_local9
			end
		end
		Engine[0xD506AB0E93540B3]( f8_local0, f8_local1, f8_local5 )
	end
end
Lobby.TeamSelection.StoreGamesetting = function ( f9_arg0, f9_arg1, f9_arg2 )
	local f9_local0 = nil
	if Engine[0x3E68E350BEFE50D]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f9_arg1 ) then
		local f9_local1 = Engine[0xA537E2C09DAA5CD]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110] )
		f9_local0 = f9_local1.gametype
	end
	Lobby.TeamSelection.gameSetting.teamBased = CoDShared.IsGametypeTeamBased( f9_local0 )
	Lobby.TeamSelection.gameSetting.allowSpectating = Engine[0xDBC2AD5002B261B]( "allowSpectating" ) == 1
	Lobby.TeamSelection.gameSetting.teamAssignment = Engine[0xDBC2AD5002B261B]( "teamAssignment" )
end
Lobby.TeamSelection.OnSessionStart = function ( f10_arg0 )
	local f10_local0 = f10_arg0.lobbyModule
	local f10_local1 = f10_arg0.lobbyType
	local f10_local2 = f10_arg0.lobbyMode
	if f10_local1 ~= Engine[0xC3DF042E7492B66]( f10_local0 ) then
		return 
	elseif f10_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] and f10_local2 == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] then
		Lobby.TeamSelection.StoreGamesetting( f10_local0, f10_local1, f10_local2 )
	end
	Lobby.TeamSelection.random = math.random()
end
Lobby.TeamSelection.OnSessionEnd = function ( f11_arg0 )
	local f11_local0 = f11_arg0.lobbyModule
	local f11_local1 = f11_arg0.lobbyType
	local f11_local2 = f11_arg0.lobbyMode
	if f11_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
		return 
	elseif f11_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
		Lobby.TeamSelection.Clear()
	end
	Lobby.TeamSelection.random = math.random()
end
Lobby.TeamSelection.OnClientAdded = function ( f12_arg0 )
	local f12_local0 = f12_arg0.lobbyModule
	local f12_local1 = f12_arg0.lobbyType
	local f12_local2 = f12_arg0.lobbyMode
	local f12_local3 = f12_arg0.xuid
	if not CoDShared.IsTeamsMenu() and f12_local1 == CoDShared.MenuControllingLobbyType() then
		return 
	elseif f12_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] and f12_local1 == Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] ) then
		Lobby.TeamSelection.ClientJoined( f12_arg0 )
	end
	if f12_local1 == Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] ) and f12_local0 == Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] and f12_local2 == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] and Engine[0x41DC2CF4139D7]( f12_local3 ) and Engine[0x9FB56855DFACDAD]() > 1 then
		for f12_local4 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			local f12_local7 = f12_local4 - 1
			local f12_local8 = Engine[0x93B19E01B1FD1C7]( f12_local7 )
			if Engine[0x86E64DD1C270046]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f12_local1, f12_local8 ) and (Engine[0x20826BD382E3A23]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f12_local1, f12_local8 ) == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] or client ~= nil and Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] == client.switchTeam) then
				Engine[0x887353BB976C702]( f12_local7, f12_local1, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
			end
		end
	end
end
Lobby.TeamSelection.OnMatchEnd = function ( f13_arg0 )
	local f13_local0 = f13_arg0.lobbyModule
	local f13_local1 = f13_arg0.lobbyType
	local f13_local2 = f13_arg0.lobbyMode
	if f13_local0 ~= Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or f13_local1 ~= Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] ) then
		return 
	end
	local f13_local3 = LobbyData.GetCurrentMenuTarget()
	if f13_local3[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x79D01499920B292] then
		local f13_local4 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f13_local1 )
		for f13_local8, f13_local9 in ipairs( f13_local4.sessionClients ) do
			Engine[0xD506AB0E93540B3]( f13_local1, f13_local9.xuid, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
		end
	elseif f13_local3[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x78C124999125C42] and f13_local2 == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] then
		
	elseif f13_local3[0xEB7DDC7F079D51B] ~= Enum[0x89C1455C5032969][0x7E41449995CD57E] then
		Lobby.TeamSelection.Clear()
	elseif f13_local2 == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] and Engine[0xDBC2AD5002B261B]( "teamAssignment" ) == LuaEnum.TEAM_ASSIGNMENT.AUTO then
		Lobby.TeamSelection.ClearTeam( Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
		Lobby.TeamSelection.ClearTeam( Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
	elseif f13_local2 == Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9] then
		Lobby.TeamSelection.Clear()
	end
	Lobby.TeamSelection.random = math.random()
end
Lobby.TeamSelection.OnGametypeSettingsChange = function ( f14_arg0 )
	local f14_local0 = f14_arg0.lobbyModule
	local f14_local1 = f14_arg0.lobbyType
	local f14_local2 = f14_arg0.lobbyMode
	if f14_local1 ~= Engine[0xC3DF042E7492B66]( f14_local0 ) then
		return 
	elseif f14_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] then
		Lobby.TeamSelection.GametypeSettingsChange( f14_local0, f14_local1, f14_local2 )
	elseif f14_local0 == Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] and Engine[0x3E68E350BEFE50D]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f14_local1 ) == false then
		Lobby.TeamSelection.GametypeSettingsChange( f14_local0, f14_local1, f14_local2 )
	end
end
Lobby.TeamSelection.GetAllowedTeams = function ( f15_arg0, f15_arg1 )
	local f15_local0 = Engine[0xDBC2AD5002B261B]( "teamAssignment" ) == LuaEnum.TEAM_ASSIGNMENT.AUTO
	local f15_local1 = Engine[0xF3C89E03BE9E740]( Engine[0xC3DF042E7492B66]( f15_arg0 ), f15_arg1 )
	local f15_local2
	if Engine[0xDBC2AD5002B261B]( "allowSpectating" ) == 1 then
		f15_local2 = not f15_local1
	else
		f15_local2 = false
	end
	local f15_local3 = CoDShared.IsGametypeTeamBased()
	local f15_local4 = {}
	if f15_local3 and not f15_local0 then
		table.insert( f15_local4, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
		table.insert( f15_local4, Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
	else
		table.insert( f15_local4, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
	end
	if f15_local2 then
		table.insert( f15_local4, Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
	end
	return f15_local4
end
Lobby.TeamSelection.SwitchTeamClientAssignment = function ( f16_arg0 )
	local f16_local0 = f16_arg0.controller
	local f16_local1 = f16_arg0.requestedTeam
	local f16_local2 = f16_arg0.xuid
	if not f16_local2 or f16_local2 == 0 then
		f16_local2 = Engine[0x93B19E01B1FD1C7]( f16_local0 )
	end
	if Engine[0xEFBAAD12776201D]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] ), f16_local2 ) == LuaDefine.INVALID_CLIENT_INDEX then
		return 
	else
		Engine[0x887353BB976C702]( f16_local0, Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] ), f16_local1 )
	end
end
Lobby.TeamSelection.SwitchTeamHostAssignment = function ( f17_arg0 )
	local f17_local0 = f17_arg0.controller
	local f17_local1 = f17_arg0.selection
	local f17_local2 = f17_arg0.requestedTeam
	local f17_local3 = f17_arg0.swapXuid
	local f17_local4 = f17_arg0.withXuid
	local f17_local5 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
	if Engine[0xEFBAAD12776201D]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f17_local5, f17_local3 ) == LuaDefine.INVALID_CLIENT_INDEX then
		return 
	elseif f17_local4 ~= nil and Engine[0xEFBAAD12776201D]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f17_local5, f17_local4 ) == LuaDefine.INVALID_CLIENT_INDEX then
		return 
	elseif f17_local4 ~= nil then
		local f17_local6 = Engine[0x20826BD382E3A23]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f17_local5, f17_local3 )
		Engine[0xD506AB0E93540B3]( f17_local5, f17_local3, Engine[0x20826BD382E3A23]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f17_local5, f17_local4 ) )
		Engine[0xD506AB0E93540B3]( f17_local5, f17_local4, f17_local6 )
	elseif f17_local2 == Engine[0x20826BD382E3A23]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f17_local5, f17_local3 ) then
		return 
	elseif Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and f17_local2 >= Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] and f17_local2 <= Enum[0x13A4717E5AC547][0x7A0FCED35961F87] then
		Engine[0xD506AB0E93540B3]( f17_local5, f17_local3, f17_local2 )
	elseif CoDShared.IsGametypeTeamBased() and (f17_local2 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or f17_local2 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] or f17_local2 == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556]) then
		Engine[0xD506AB0E93540B3]( f17_local5, f17_local3, f17_local2 )
	elseif f17_local2 == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] or f17_local2 == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
		Engine[0xD506AB0E93540B3]( f17_local5, f17_local3, f17_local2 )
	end
end
Lobby.TeamSelection.SwitchTeamBotAssignment = function ( f18_arg0 )
	local f18_local0 = f18_arg0.controller
	local f18_local1 = f18_arg0.selection
	local f18_local2 = f18_arg0.xuid
	local f18_local3 = Engine[0xEFBAAD12776201D]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] ), f18_local2 )
	if f18_local3 == LuaEnum.INVALID_CLIENT_INDEX then
		return 
	end
	local f18_local4 = Lobby.TeamSelection.Clients[f18_local3 + 1]
	local f18_local5 = CoDShared.IsGametypeTeamBased()
	local f18_local6 = {}
	if f18_local5 then
		table.insert( f18_local6, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
		table.insert( f18_local6, Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
	else
		table.insert( f18_local6, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
	end
	local f18_local7 = 0
	local f18_local8 = 1
	for f18_local9 = 1, #f18_local6, 1 do
		if f18_local4.switchTeam == f18_local6[f18_local9] then
			f18_local7 = f18_local9
			break
		end
	end
	if f18_local1 == 0 then
		if f18_local7 <= 1 then
			f18_local8 = #f18_local6
		else
			f18_local8 = f18_local7 - 1
		end
	elseif #f18_local6 <= f18_local7 then
		f18_local8 = 1
	else
		f18_local8 = f18_local7 + 1
	end
	f18_local4.switchTeamType = LuaEnum.TEAM_ASSIGNMENT.HOST
	f18_local4.controller = f18_local0
	f18_local4.xuid = f18_local2
	f18_local4.switchTeam = f18_local6[f18_local8]
	Engine[0xE1789115A2356E7]( "team_switch", {
		controller = f18_local0,
		switchTeam = f18_local4.switchTeam,
		xuid = f18_local2
	} )
	if f18_local4.team == f18_local4.switchTeam then
		f18_local4.switchTeamTime = Lobby.TeamSelection.DONT_SWITCH
	else
		f18_local4.switchTeamTime = Lobby.TeamSelection.TEAM_SWITCH_DELAY + Engine[0x9D33D652B9B0F3B]()
	end
end
Lobby.TeamSelection.SwitchTeam = function ( f19_arg0 )
	local f19_local0 = Engine[0xDBC2AD5002B261B]( "teamAssignment" )
	local f19_local1
	if f19_arg0.lobbyClientType ~= Enum[0xD7CCD8BF53DC08C][0x5768EF8BA18333F] and f19_arg0.lobbyClientType ~= Enum[0xD7CCD8BF53DC08C][0xEA66E24E2A1A4D9] then
		f19_local1 = false
	else
		f19_local1 = true
	end
	local f19_local2 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
	if f19_local1 and Engine[0xEA2BE00F49480D]( f19_local2 ) then
		Lobby.TeamSelection.SwitchTeamBotAssignment( f19_arg0 )
	elseif f19_local0 == LuaEnum.TEAM_ASSIGNMENT.AUTO then
		Lobby.TeamSelection.SwitchTeamClientAssignment( f19_arg0 )
	elseif (f19_local0 == LuaEnum.TEAM_ASSIGNMENT.HOST or f19_local0 == LuaEnum.TEAM_ASSIGNMENT.CLIENT) and Engine[0xEA2BE00F49480D]( f19_local2 ) then
		Lobby.TeamSelection.SwitchTeamHostAssignment( f19_arg0 )
	end
end
Lobby.TeamSelection.GameLobbyClientDataUpdate = function ( f20_arg0 )
	
end
Lobby.TeamSelection.AddToPrivateLobbyList = function ( f21_arg0, f21_arg1, f21_arg2 )
	for f21_local3, f21_local4 in ipairs( f21_arg2 ) do
		if f21_arg0.lobbyID == f21_local4.lobbyID then
			if LuaUtils.IsArenaMode() then
				f21_local4.lobbySkill = f21_local4.lobbySkill + f21_arg0.arenaPoints
			else
				f21_local4.lobbySkill = f21_local4.lobbySkill + f21_arg0.skillRating
			end
			table.insert( f21_local4.memberList, {
				index = f21_arg1,
				xuid = f21_arg0.xuid,
				skill = f21_arg0.skillRating,
				arenaPoints = f21_arg0.arenaPoints
			} )
			return 
		end
	end
	f21_local0 = {
		lobbyID = f21_arg0.lobbyID
	}
	if LuaUtils.IsArenaMode() then
		f21_local0.lobbySkill = f21_arg0.arenaPoints
	else
		f21_local0.lobbySkill = f21_arg0.skillRating
	end
	f21_local0.memberList = {}
	table.insert( f21_local0.memberList, {
		index = f21_arg1,
		xuid = f21_arg0.xuid,
		skill = f21_arg0.skillRating,
		arenaPoints = f21_arg0.arenaPoints
	} )
	table.insert( f21_arg2, f21_local0 )
end
Lobby.TeamSelection.AddAsIndividualToPrivateLobbyList = function ( f22_arg0, f22_arg1, f22_arg2 )
	local f22_local0 = {
		lobbyID = f22_arg0.lobbyID
	}
	if LuaUtils.IsArenaMode() then
		f22_local0.lobbySkill = f22_arg0.arenaPoints
	else
		f22_local0.lobbySkill = f22_arg0.skillRating
	end
	f22_local0.memberList = {}
	table.insert( f22_local0.memberList, {
		index = f22_arg1,
		xuid = f22_arg0.xuid,
		skill = f22_arg0.skillRating,
		arenaPoints = f22_arg0.arenaPoints
	} )
	table.insert( f22_arg2, f22_local0 )
end
Lobby.TeamSelection.AddDummyToPrivateLobbyList = function ( f23_arg0, f23_arg1 )
	local f23_local0 = {
		lobbyID = -1,
		lobbySkill = 0,
		memberList = {}
	}
	for f23_local1 = 1, f23_arg0, 1 do
		local f23_local4 = f23_local1
		table.insert( f23_local0.memberList, {
			index = -1,
			xuid = 0,
			skill = 0,
			arenaPoints = 0
		} )
	end
	table.insert( f23_arg1, f23_local0 )
end
Lobby.TeamSelection.CanSplitInProgress = function ( f24_arg0, f24_arg1, f24_arg2, f24_arg3 )
	local f24_local0 = 0
	local f24_local1 = 0
	local f24_local2 = 0
	local f24_local3 = 0
	local f24_local4 = 0
	for f24_local8, f24_local9 in ipairs( f24_arg0 ) do
		local f24_local10 = 1
		local f24_local11 = nil
		if f24_local9.team == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f24_local1 = f24_local1 + 1
		end
		if f24_local9.team == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f24_local2 = f24_local2 + 1
		end
		if f24_local9.team == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] then
			f24_local3 = f24_local3 + 1
		else
			f24_local4 = f24_local4 + 1
		end
	end
	f24_local5 = math.floor( (f24_arg2 - f24_local4) / 2 )
	if f24_local2 < f24_local1 then
		f24_local1 = f24_local1 + f24_local3
	else
		f24_local2 = f24_local2 + f24_local3
	end
	table.sort( f24_arg1, function ( f25_arg0, f25_arg1 )
		return f25_arg1 < f25_arg0
	end )
	f24_local7 = math.abs( f24_local1 - f24_local2 )
	for f24_local11, f24_local12 in ipairs( f24_arg1 ) do
		if f24_local1 < f24_local2 then
			f24_local1 = f24_local1 + f24_local12
		else
			f24_local2 = f24_local2 + f24_local12
		end
	end
	if f24_local5 < f24_local1 then
		return false
	elseif f24_local5 < f24_local2 then
		return false
	elseif f24_arg3 == true then
		f24_local8 = math.abs( f24_local1 - f24_local2 )
		if f24_local8 > 1 and f24_local7 < f24_local8 then
			return false
		end
	end
	return true
end
Lobby.TeamSelection.BuildAllocationMap = function ( f26_arg0 )
	local f26_local0 = {
		1,
		2,
		2,
		1
	}
	local f26_local1 = 1
	local f26_local2 = {}
	for f26_local3 = 1, f26_arg0, 1 do
		f26_local2[f26_local3] = f26_local0[f26_local1]
		f26_local1 = f26_local1 + 1
		if #f26_local0 < f26_local1 then
			f26_local1 = 1
		end
	end
	return f26_local2
end
Lobby.TeamSelection.SortBySkill = function ( f27_arg0, f27_arg1 )
	return f27_arg1.lobbySkill < f27_arg0.lobbySkill
end
Lobby.TeamSelection.SortBySizeAndSkill = function ( f28_arg0, f28_arg1 )
	if #f28_arg0.memberList == #f28_arg1.memberList then
		return Lobby.TeamSelection.SortBySkill( f28_arg0, f28_arg1 )
	else
		return #f28_arg1.memberList < #f28_arg0.memberList
	end
end
Lobby.TeamSelection.SwapSolo = function ( f29_arg0, f29_arg1 )
	local f29_local0 = 0
	local f29_local1 = 0
	local f29_local2 = {}
	local f29_local3 = {}
	for f29_local7, f29_local8 in ipairs( f29_arg0 ) do
		f29_local0 = f29_local0 + f29_local8.lobbySkill
		if #f29_local8.memberList == 1 then
			table.insert( f29_local2, f29_local7 )
		end
	end
	for f29_local7, f29_local8 in ipairs( f29_arg1 ) do
		f29_local1 = f29_local1 + f29_local8.lobbySkill
		if #f29_local8.memberList == 1 then
			table.insert( f29_local3, f29_local7 )
		end
	end
	f29_local4 = f29_local0 - f29_local1
	f29_local5 = f29_local4
	f29_local6 = {}
	for f29_local13, f29_local14 in ipairs( f29_local2 ) do
		for f29_local10, f29_local11 in ipairs( f29_local3 ) do
			delta1 = f29_local4 - 2 * (f29_arg0[f29_local14].lobbySkill - f29_arg1[f29_local11].lobbySkill)
			if math.abs( f29_local5 ) > math.abs( delta1 ) then
				f29_local5 = delta1
				f29_local6 = {
					f29_local14,
					f29_local11
				}
			end
		end
	end
	if math.abs( f29_local5 ) < math.abs( f29_local4 ) then
		f29_local7 = table.remove( f29_arg0, f29_local6[1] )
		table.insert( f29_arg0, table.remove( f29_arg1, f29_local6[2] ) )
		table.insert( f29_arg1, f29_local7 )
		return true
	else
		return false
	end
end
Lobby.TeamSelection.VladSplit = function ( f30_arg0, f30_arg1 )
	local f30_local0 = 0
	for f30_local4, f30_local5 in ipairs( f30_arg0 ) do
		f30_local0 = f30_local0 + #f30_local5.memberList
	end
	for f30_local1 = 1, 2, 1 do
		f30_local5 = Lobby.TeamSelection.BuildAllocationMap( f30_local0 )
		if f30_local1 == 1 then
			table.sort( f30_arg0, Lobby.TeamSelection.SortBySkill )
		else
			table.sort( f30_arg0, Lobby.TeamSelection.SortBySizeAndSkill )
		end
		local f30_local6 = 1
		local f30_local7 = {}
		local f30_local8 = {}
		local f30_local9 = 0
		local f30_local10 = 0
		for f30_local20, f30_local21 in ipairs( f30_arg0 ) do
			while f30_local5[f30_local6] == 0 do
				f30_local6 = f30_local6 + 1
			end
			local f30_local14 = f30_local5[f30_local6]
			if f30_local14 == 1 then
				table.insert( f30_local7, f30_local21 )
				f30_local9 = f30_local9 + #f30_local21.memberList
			else
				table.insert( f30_local8, f30_local21 )
				f30_local10 = f30_local10 + #f30_local21.memberList
			end
			local f30_local15 = f30_local6
			for f30_local16 = 0, #f30_local21.memberList - 1, 1 do
				local f30_local19 = f30_local16
			end
			local f30_local19 = f30_local16
		end
		f30_local11 = math.abs( f30_local9 - f30_local10 )
		if f30_arg1 < f30_local9 + f30_local10 then
			return {
				isBalanced = false,
				canBalance = false,
				teams = {
					f30_local7,
					f30_local8
				},
				counts = {
					f30_local9,
					f30_local10
				}
			}
		elseif f30_local11 <= 1 then
			Lobby.TeamSelection.SwapSolo( f30_local7, f30_local8 )
			if Lobby.TeamSelection.random > 0.5 then
				return {
					isBalanced = true,
					canBalance = true,
					teams = {
						f30_local7,
						f30_local8
					},
					counts = {
						f30_local9,
						f30_local10
					}
				}
			else
				return {
					isBalanced = true,
					canBalance = true,
					teams = {
						f30_local8,
						f30_local7
					},
					counts = {
						f30_local10,
						f30_local9
					}
				}
			end
		elseif f30_local1 == 2 then
			return {
				isBalanced = false,
				canBalance = f30_local11 <= f30_arg1 - f30_local9 - f30_local10,
				teams = {
					f30_local7,
					f30_local8
				},
				counts = {
					f30_local9,
					f30_local10
				}
			}
		end
	end
end
Lobby.TeamSelection.VladSplitWithBots = function ( f31_arg0, f31_arg1, f31_arg2 )
	local f31_local0 = 0
	for f31_local4, f31_local5 in ipairs( f31_arg0 ) do
		f31_local0 = f31_local0 + #f31_local5.memberList
	end
	for f31_local1 = 1, 2, 1 do
		f31_local5 = Lobby.TeamSelection.BuildAllocationMap( f31_local0 + #f31_arg2 )
		if f31_local1 == 1 then
			table.sort( f31_arg0, Lobby.TeamSelection.SortBySkill )
		else
			table.sort( f31_arg0, Lobby.TeamSelection.SortBySizeAndSkill )
		end
		local f31_local6 = 1
		local f31_local7 = {}
		local f31_local8 = {}
		local f31_local9 = 0
		local f31_local10 = 0
		for f31_local14, f31_local15 in ipairs( f31_arg2 ) do
			local f31_local16 = {
				lobbyID = "Bot",
				lobbySkill = 0,
				memberList = {
					{
						index = f31_local15.index,
						xuid = f31_local15.client.xuid,
						skill = f31_local15.client.skillRating,
						arenaPoints = f31_local15.client.arenaPoints
					}
				}
			}
			if Dvar[0xE2390D9E82B6369]:get() == true then
				f31_local15.client.team = f31_local14 % 2
			end
			if f31_local15.client.team == 1 then
				table.insert( f31_local7, f31_local16 )
				f31_local9 = f31_local9 + 1
			else
				table.insert( f31_local8, f31_local16 )
				f31_local10 = f31_local10 + 1
			end
		end
		f31_local11 = math.abs( f31_local9 - f31_local10 )
		f31_local12 = true
		if f31_local9 < f31_local10 then
			f31_local12 = false
		end
		for f31_local23, f31_local16 in ipairs( f31_arg0 ) do
			while f31_local5[f31_local6] == 0 do
				f31_local6 = f31_local6 + 1
			end
			local f31_local17 = f31_local5[f31_local6]
			if 0 < f31_local11 then
				if f31_local12 then
					f31_local17 = 2
				else
					f31_local17 = 1
				end
			end
			if f31_local17 == 1 then
				table.insert( f31_local7, f31_local16 )
				f31_local9 = f31_local9 + #f31_local16.memberList
			else
				table.insert( f31_local8, f31_local16 )
				f31_local10 = f31_local10 + #f31_local16.memberList
			end
			local f31_local18 = f31_local6
			for f31_local19 = 0, #f31_local16.memberList - 1, 1 do
				local f31_local22 = f31_local19
			end
			local f31_local22 = f31_local19
		end
		f31_local13 = math.abs( f31_local9 - f31_local10 )
		if f31_arg1 < f31_local9 + f31_local10 then
			return {
				isBalanced = false,
				canBalance = false,
				teams = {
					f31_local7,
					f31_local8
				},
				counts = {
					f31_local9,
					f31_local10
				}
			}
		elseif f31_local13 <= 1 then
			Lobby.TeamSelection.SwapSolo( f31_local7, f31_local8 )
			return {
				isBalanced = true,
				canBalance = true,
				teams = {
					f31_local7,
					f31_local8
				},
				counts = {
					f31_local9,
					f31_local10
				}
			}
		elseif f31_local1 == 2 then
			return {
				isBalanced = false,
				canBalance = f31_local13 <= f31_arg1 - f31_local9 - f31_local10,
				teams = {
					f31_local7,
					f31_local8
				},
				counts = {
					f31_local9,
					f31_local10
				}
			}
		end
	end
end
Lobby.TeamSelection.RemoveCodCaster = function ( f32_arg0 )
	local f32_local0 = 0
	for f32_local1 = #f32_arg0.sessionClients, 1, -1 do
		if f32_arg0.sessionClients[f32_local1].team == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			table.remove( f32_arg0.sessionClients, f32_local1 )
			f32_local0 = f32_local0 + 1
		end
	end
	return f32_local0
end
Lobby.TeamSelection.AutoSplitTeam = function ( f33_arg0, f33_arg1, f33_arg2 )
	if Engine[0x2DA54CF5D6B7F02]() and Engine[0x9E5BE3B4BBA4E0E]( "lobby_forceBalanced" ) == true then
		f33_arg0 = false
	end
	local f33_local0 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
	local f33_local1 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f33_local0 )
	if not CoDShared.IsGametypeTeamBased() then
		for f33_local5, f33_local6 in ipairs( f33_local1.sessionClients ) do
			if f33_local6.team ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
				Engine[0xD506AB0E93540B3]( f33_local0, f33_local6.xuid, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
			end
		end
		return true
	else
		if Lobby.TeamSelection.RemoveCodCaster( f33_local1 ) == Engine[0x44FC97037CE42ED]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f33_local0, Enum[0x575E471C039DBD6][0x92BC25E18D296F] ) then
			return true
		elseif true == Dvar[0x4BADE8473F0165F]:get() and not Dvar[0xE2390D9E82B6369]:get() then
			if Lobby.MMAsync.Info.lobbyBackendDocTable ~= nil then
				return Lobby.MatchmakingAsync.AssignTeams( f33_local0, f33_arg0, f33_arg1, f33_arg2 )
			else
				return false
			end
		end
		botsOnTeam = {}
		for f33_local3 = #f33_local1.sessionClients, 1, -1 do
			local f33_local7 = f33_local1.sessionClients[f33_local3].team
			local f33_local8 = f33_local1.sessionClients[f33_local3].lobbyClientType
			local f33_local9
			if f33_local8 ~= Enum[0xD7CCD8BF53DC08C][0x5768EF8BA18333F] and f33_local8 ~= Enum[0xD7CCD8BF53DC08C][0xEA66E24E2A1A4D9] then
				f33_local9 = false
			else
				f33_local9 = true
			end
			if f33_local9 and f33_local7 ~= Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] then
				table.insert( botsOnTeam, {
					index = f33_local3,
					client = f33_local1.sessionClients[f33_local3]
				} )
				table.remove( f33_local1.sessionClients, f33_local3 )
			end
		end
		local f33_local3 = {}
		local f33_local4 = LobbyData.GetCurrentMenuTarget()
		if f33_local4[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] then
			for f33_local8, f33_local9 in ipairs( f33_local1.sessionClients ) do
				Lobby.TeamSelection.AddAsIndividualToPrivateLobbyList( f33_local9, f33_local8, f33_local3 )
			end
		else
			for f33_local8, f33_local9 in ipairs( f33_local1.sessionClients ) do
				Lobby.TeamSelection.AddToPrivateLobbyList( f33_local9, f33_local8, f33_local3 )
			end
		end
		f33_local5 = Engine[0x29B25E8DA873863]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f33_local0 )
		local f33_local6 = {}
		if #botsOnTeam > 0 then
			f33_local6 = Lobby.TeamSelection.VladSplitWithBots( f33_local3, f33_local5, botsOnTeam )
			f33_local1 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f33_local0 )
			Lobby.TeamSelection.RemoveCodCaster( f33_local1 )
		else
			f33_local6 = Lobby.TeamSelection.VladSplit( f33_local3, f33_local5 )
		end
		if f33_arg1 then
			
		else
			
		end
		if f33_arg1 then
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.TeamSelection.AutoSplitTeam start\n" )
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "gamelobby data:\n" )
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------------------\n" )
			for f33_local10, f33_local11 in ipairs( f33_local1.sessionClients ) do
				Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "(" .. tostring( f33_local10 ) .. ") " .. f33_local11.gamertag .. " - lobbyID(" .. tostring( f33_local11.lobbyID ) .. ") 
			end
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------------------\n" )
		end
		if f33_arg1 then
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Team Assignment:\n" )
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------------------\n" )
		end
		for f33_local10, f33_local11 in ipairs( f33_local6.teams[1] ) do
			local f33_local16 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
			for f33_local12, f33_local13 in ipairs( f33_local11.memberList ) do
				local f33_local15 = f33_local1.sessionClients[f33_local13.index]
				if f33_arg1 then
					Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "(" .. tostring( f33_local10 ) .. ") " .. f33_local15.gamertag .. " - lobbyID(" .. tostring( f33_local15.lobbyID ) .. ") 
				end
				Engine[0xD506AB0E93540B3]( f33_local0, f33_local13.xuid, f33_local16 )
			end
		end
		for f33_local10, f33_local11 in ipairs( f33_local6.teams[2] ) do
			local f33_local16 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
			for f33_local12, f33_local13 in ipairs( f33_local11.memberList ) do
				local f33_local15 = f33_local1.sessionClients[f33_local13.index]
				if f33_arg1 then
					Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "(" .. tostring( f33_local10 ) .. ") " .. f33_local15.gamertag .. " - lobbyID(" .. tostring( f33_local15.lobbyID ) .. ") 
				end
				Engine[0xD506AB0E93540B3]( f33_local0, f33_local13.xuid, f33_local16 )
			end
		end
		if f33_arg1 then
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------------------\n" )
			Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.TeamSelection.AutoSplitTeam end\n" )
		end
		if f33_arg0 == true and f33_local6.isBalanced == false then
			if f33_arg1 then
				Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Could not create balanced teams.\n" )
			end
			return false
		else
			return true
		end
	end
end
Lobby.TeamSelection.CanFitMaxPartySize = function ( f34_arg0, f34_arg1, f34_arg2 )
	local f34_local0 = f34_arg0.probedXuid
	if f34_local0 == nil or f34_local0 == LuaDefine.INVALID_XUID then
		return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
	end
	local f34_local1 = nil
	for f34_local5, f34_local6 in ipairs( f34_arg1.sessionClients ) do
		if f34_local6.xuid == f34_local0 then
			f34_local1 = f34_local6.lobbyID
			break
		end
	end
	if f34_local1 == nil then
		return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
	elseif not Engine[0x7BD94976D01F561] then
		f34_local2 = 0
		for f34_local6, f34_local7 in ipairs( f34_arg1.sessionClients ) do
			if f34_local7.lobbyID == lobbyID then
				f34_local2 = f34_local2 + 1
			end
		end
		if f34_arg2 < f34_local2 + #f34_arg0.members then
			return Enum[0x2E4144AA1C3ABB8][0x9E083F2EA9B6844]
		end
	else
		Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "^5 #gamelobby.sessionClients: " .. tostring( #f34_arg1.sessionClients ) .. ".\n" )
		f34_local2 = Engine[0x9D33D652B9B0F3B]() + Dvar[0x935876169435D5F]:get()
		f34_local3 = 0
		for f34_local7, f34_local8 in ipairs( f34_arg1.sessionClients ) do
			if f34_local8.probedXuid ~= LuaDefine.INVALID_XUID and f34_local8.probedXuidTimestamp < f34_local2 and f34_local8.probedXuid == f34_local0 then
				f34_local3 = f34_local3 + 1
				Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "^6 probedXuid client.xuid: " .. tostring( f34_local8.xuid ) .. "\n" )
			end
			if f34_local8.lobbyID == f34_local1 then
				f34_local3 = f34_local3 + 1
				Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "^6 in lobby client.xuid: " .. tostring( f34_local8.xuid ) .. "\n" )
			end
		end
		f34_local4 = Engine[0x7BD94976D01F561]()
		f34_local5 = 0
		if f34_local4.count > 0 then
			for f34_local9, f34_local10 in ipairs( f34_local4.status ) do
				if f34_local10.probedXuid == f34_local0 then
					f34_local5 = f34_local5 + 1
					Engine[0x8C5711DAACC99F4]( Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "^6 in reserve client.xuid: " .. tostring( f34_local10.xuid ) .. "\n" )
				end
			end
		end
		if f34_arg2 < f34_local5 + f34_local3 + #f34_arg0.members then
			return Enum[0x2E4144AA1C3ABB8][0x9E083F2EA9B6844]
		end
	end
	return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
end
Lobby.TeamSelection.OnCanFitLobbys = function ( f35_arg0 )
	local f35_local0 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
	local f35_local1 = f35_arg0.lobbyHostXuid
	local f35_local2 = LobbyData.GetCurrentMenuTarget()
	local f35_local3 = LobbyData.GetCurrentLobbySizes( true )
	f35_local3.maxClientsSession = Engine[0x29B25E8DA873863]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f35_local0 )
	local f35_local4 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f35_local0 )
	if f35_local1 ~= nil and f35_local1 ~= LuaDefine.INVALID_XUID and f35_local1 == Engine[0x19F19E9171B560D]( f35_local0 ) then
		return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
	elseif f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC then
		local f35_local5 = Engine[0xB2BAD8AD577224E]( Engine[0x7B3B2B73B53EB34]() )
		if Engine[0x32ABAFDCA93FDF9]() then
			local f35_local6 = Lobby.TeamSelection.CanFitMaxPartySize( f35_arg0, f35_local4, f35_local5 )
			if f35_local6 ~= Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657] then
				return f35_local6
			end
		end
		if CoDShared.IsTeamBasedGame() == false or Engine[0x8EF5BEFA0AE50FE]() or Engine[0x293941FE17453F1]() then
			return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
		end
		local f35_local6 = {}
		if Engine[0x7B48C1ABFF0F764]() then
			if Dvar[0x4BADE8473F0165F]:get() == true then
				return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
			end
			local f35_local7 = {}
			for f35_local11, f35_local12 in ipairs( f35_arg0.lobbys ) do
				table.insert( f35_local7, f35_local12 )
			end
			if Lobby.TeamSelection.CanSplitInProgress( f35_local4.sessionClients, f35_local7, f35_local3.maxClientsSession, true ) then
				return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
			end
			return Enum[0x2E4144AA1C3ABB8][0x9BB0AFF5C451740]
		end
		for f35_local10, f35_local11 in ipairs( f35_local4.sessionClients ) do
			Lobby.TeamSelection.AddToPrivateLobbyList( f35_local11, f35_local10, f35_local6 )
		end
		for f35_local10, f35_local11 in ipairs( f35_arg0.lobbys ) do
			Lobby.TeamSelection.AddDummyToPrivateLobbyList( f35_local11, f35_local6 )
		end
		if f35_arg0.members ~= nil and #f35_arg0.members > Dvar[0xA90AF2FA81CF8EA]:get() then
			LuaUtils.LogQoS( "can_fit/result", false )
			return Enum[0x2E4144AA1C3ABB8][0x9BB0AFF5C451740]
		end
		f35_local7 = Lobby.TeamSelection.VladSplit( f35_local6, f35_local3.maxClientsSession )
		f35_local8 = false
		if f35_local7.isBalanced then
			f35_local8 = true
		elseif f35_local7.canBalance then
			f35_local8 = true
		end
		if f35_local8 then
			return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
		end
		return Enum[0x2E4144AA1C3ABB8][0x9BB0AFF5C451740]
	elseif f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_LAN_CP or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_LAN_MP or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_LAN_MP_ARENA or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_LAN_ZM or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC or f35_local2[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC then
		local f35_local13 = Engine[0xDBC2AD5002B261B]( "allowSpectating" ) == 1
		local f35_local5 = #f35_local4.sessionClients
		local f35_local6 = 0
		local f35_local7 = 0
		local f35_local8 = 0
		local f35_local9 = 0
		for f35_local14, f35_local15 in ipairs( f35_local4.sessionClients ) do
			if f35_local15.team == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
				f35_local6 = f35_local6 + 1
			end
			if f35_local15.team == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
				f35_local7 = f35_local7 + 1
			end
			if f35_local15.team == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
				f35_local8 = f35_local8 + 1
			end
			if f35_local15.team == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] then
				f35_local9 = f35_local9 + 1
			end
		end
		if f35_local3.maxLaunchClients <= f35_local6 + f35_local7 then
			if not f35_local13 then
				Engine[0x5DF86CF48135674]( Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Already at max launch clients and we don't allow CoD Casters.\n" )
				return Enum[0x2E4144AA1C3ABB8][0x9BB0AFF5C451740]
			elseif f35_local3.maxCoDcasterClients <= f35_local8 then
				Engine[0x5DF86CF48135674]( Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Already at max launch clients and max CoD Casters.\n" )
				return Enum[0x2E4144AA1C3ABB8][0x9BB0AFF5C451740]
			end
		end
	end
	return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
end
Lobby.TeamSelection.ClientJoined = function ( f36_arg0 )
	if not Lobby.TeamSelection.ShouldAssignToTeam( f36_arg0 ) then
		return 
	else
		local f36_local0 = f36_arg0.xuid
		Lobby.TeamSelection.AutoAssignPlayers( f36_arg0.xuid )
	end
end
Lobby.TeamSelection.GametypeSettingsChange = function ( f37_arg0, f37_arg1 )
	local f37_local0 = nil
	if f37_arg0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] then
		local f37_local1 = Engine[0xA537E2C09DAA5CD]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110] )
		f37_local0 = f37_local1.gametype
	end
	local f37_local1 = CoDShared.IsGametypeTeamBased( f37_local0 )
	local f37_local2 = Engine[0xDBC2AD5002B261B]( "allowSpectating" ) == 1
	local f37_local3 = Engine[0xDBC2AD5002B261B]( "teamAssignment" )
	local f37_local4 = f37_local1 ~= Lobby.TeamSelection.gameSetting.teamBased
	local f37_local5 = f37_local2 ~= Lobby.TeamSelection.gameSetting.allowSpectating
	local f37_local6 = f37_local3 ~= Lobby.TeamSelection.gameSetting.teamAssignment
	local f37_local7 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
	local f37_local8 = Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] == Engine[0x3EAC408F958FF05]()
	if f37_local4 == false and f37_local5 == false and f37_local6 == false and not f37_local8 then
		return 
	end
	Engine[0xE1789115A2356E7]( "update_team_selection_buttons", {} )
	if f37_local4 and not f37_local8 then
		if f37_local1 == false then
			Lobby.TeamSelection.ClearTeam( Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
			Lobby.TeamSelection.ClearTeam( Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
		else
			local f37_local9 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f37_local7 )
			for f37_local13, f37_local14 in ipairs( f37_local9.sessionClients ) do
				if f37_local14.team ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
					if f37_local13 % 2 == 1 then
						Engine[0xD506AB0E93540B3]( f37_local7, f37_local14.xuid, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
					else
						Engine[0xD506AB0E93540B3]( f37_local7, f37_local14.xuid, Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
					end
				end
			end
		end
	end
	if f37_local8 then
		local f37_local9 = LobbyData.GetCurrentLobbySizes()
		local f37_local10 = CoDShared.GetGametypeMaxTeamPlayers()
		local f37_local11 = 1
		if f37_local10 > 0 then
			f37_local11 = math.floor( f37_local9.maxLaunchClients / f37_local10 )
		end
		local f37_local12 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f37_local7 )
		for f37_local16, f37_local17 in ipairs( f37_local12.sessionClients ) do
			if f37_local16 <= f37_local9.maxLaunchClients then
				Engine[0xD506AB0E93540B3]( f37_local7, f37_local17.xuid, (f37_local16 - 1) % f37_local11 + 1 )
			end
		end
	end
	if f37_local5 and f37_local2 == false then
		if f37_local3 == LuaEnum.TEAM_ASSIGNMENT.AUTO then
			Lobby.TeamSelection.ClearTeam( Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] )
		else
			local f37_local9 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f37_local7 )
			for f37_local13, f37_local14 in ipairs( f37_local9.sessionClients ) do
				if f37_local14.team == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
					Engine[0xD506AB0E93540B3]( f37_local7, f37_local14.xuid, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
				end
			end
		end
	end
	if f37_local6 and f37_local1 == true then
		local f37_local9 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f37_local7 )
		if f37_local3 == LuaEnum.TEAM_ASSIGNMENT.AUTO then
			for f37_local13, f37_local14 in ipairs( f37_local9.sessionClients ) do
				if f37_local14.team ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
					Engine[0xD506AB0E93540B3]( f37_local7, f37_local14.xuid, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
				end
			end
		else
			for f37_local13, f37_local14 in ipairs( f37_local9.sessionClients ) do
				if f37_local14.team == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] then
					Engine[0xD506AB0E93540B3]( f37_local7, f37_local14.xuid, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
				end
			end
		end
	end
	if f37_local6 and f37_local1 == true then
		local f37_local9 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f37_local7 )
		if f37_local3 == LuaEnum.TEAM_ASSIGNMENT.AUTO then
			for f37_local13, f37_local14 in ipairs( f37_local9.sessionClients ) do
				if f37_local14.team ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
					Engine[0xD506AB0E93540B3]( f37_local7, f37_local14.xuid, Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
				end
			end
		end
	end
	Lobby.TeamSelection.StoreGamesetting( f37_arg0, f37_local7, lobbyMode )
end
Lobby.TeamSelection.Pump = function ()
	
end
Lobby.TeamSelection.Clear = function ()
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		return 
	end
	local f39_local0 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
	if Engine[0xEA2BE00F49480D]( f39_local0 ) then
		Engine[0x860FE74C09F6C9B]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f39_local0 )
	end
end
Lobby.TeamSelection.Init = function ()
	Lobby.TeamSelection.Clear()
end
function TeamSelectionTest()
	local f41_local0 = {}
	local f41_local1 = function ( f42_arg0, f42_arg1 )
		local f42_local0 = {}
		for f42_local1 = 1, f42_arg0, 1 do
			f42_local0[f42_local1] = 0
		end
		table.insert( f41_local0, {
			lobbySkill = f42_arg1,
			memberList = f42_local0
		} )
	end
	
	f41_local1( 1, 1 )
	f41_local1( 1, 0.5 )
	f41_local1( 1, 0.5 )
	f41_local1( 1, 0.2 )
	f41_local1( 1, -0.2 )
	f41_local1( 1, 0.1 )
	f41_local1( 1, 1.1 )
	f41_local1( 2, 2 )
	f41_local1( 3, 1 )
	local f41_local2 = Lobby.TeamSelection.VladSplit( f41_local0, 12 )
end
