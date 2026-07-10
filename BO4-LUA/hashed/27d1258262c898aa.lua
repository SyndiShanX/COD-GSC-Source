require("x64:3050b56bc941c17")
require("x64:2f7767db3f402c")
require("x64:d0f84a2d7d94ca3")
require("x64:4c567275f27616f")
require("x64:127dca51df8f7c7")
require("x64:b370b3af9224bd0")
Lobby.Platform = {}
Lobby.Platform.DISABLE_PLATFORM_SESSIONS = -1
Lobby.Platform.PLATFORM_SESSION_PS4_LOCK_FLAG = {
	LOCKED = 1,
	UNLOCKED = 2,
}
Lobby.Platform.PLATFORM_SESSION_PS4_SESSION_FLAG = {
	PUBLIC = 1,
	PRIVATE = 2,
}
Lobby.Platform.PLATFORM_SESSION_PS4_OPTIONAL_BOOLEAN = {
	notSet = 0,
	setTrue = 1,
	setFalse = 2,
}
Lobby.Platform.PLATFORM_SESSION_XBOX_TEMPLATE = {
	PRIVATE_LOBBY = "PrivateLobbySession",
	GAME_LOBBY = "GameLobbySession",
}
Lobby.Platform.PS4 = {
	updateTime = 0,
	taskInProgress = false,
	sessionFailure = {},
	sessionFailureTime = {},
	sessionId = {},
	lobbyId = {},
	changed = {},
	lastSignedInState = {},
	lockFlag = {},
	sessionTypeFlag = {},
}
Lobby.Platform.XBOX = {
	updateTime = 0,
	taskInProgress = false,
	disabled = {},
	sessionFailure = {},
	sessionFailureTime = {},
	rtaSubscribe = {},
	sessionChangeToken = {},
	subscriptionLostToken = {},
	templateName = {},
	sessionId = {},
	changed = {},
	lastSignedInState = {},
	roundStart = {},
	roundStartSessionId = {},
	roundEnd = {},
	playerSessionId = {},
	roundStartTime = {},
	roundStartCounter = {},
	roundEndCounter = {},
	sessionClosed = {},
	joinRestriction = {},
	visibility = {},
}
Lobby.Platform.S2S = {
	updateTime = 0,
	authTaskInProgress = false,
	nextAuthTokenAttemptTime = 0,
	authTokenAttempts = 0,
	forceServiceTokenRefresh = false,
	forceXstsTokenRefresh = false,
	templateName = "LargeGameSession",
	operationRetriesAtHead = 0,
}
Lobby.Platform.S2S.QueueType = {
	CreateJoin = 0,
	Leave = 1,
	Encounter = 2,
}
Lobby.Platform.PlatformSessionGetPartyPrivacyStatus = function(f1_arg0)
	local f1_local0 = "OPEN"
	if f1_arg0 == Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9] then
		f1_local0 = "OPEN"
	elseif f1_arg0 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] then
		f1_local0 = "FRIENDS ONLY"
	elseif f1_arg0 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] then
		f1_local0 = "INVITE ONLY"
	elseif f1_arg0 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f1_local0 = "CLOSED"
	end
	return f1_local0
end
Lobby.Platform.PlatformSessionOrbisEnabled = function()
	if LuaDefine.isPS4 == false or Engine[0xE39F1F30B306065]() then
		return false
	elseif not Dvar[0x12B11EC2E089C84]:exists() then
		return false
	else
		return Dvar[0x12B11EC2E089C84]:get() > Enum[0xB29F571040F207F][0x42E31EBFC59EA48]
	end
end
Lobby.Platform.PlatformSessionDurangoEnabled = function()
	if LuaDefine.isXbox == false or Engine[0xE39F1F30B306065]() then
		return false
	elseif not Dvar[0x7843C9D23778443]:exists() then
		return false
	else
		return Dvar[0x7843C9D23778443]:get() > Enum[0xB29F571040F207F][0x42E31EBFC59EA48]
	end
end
Lobby.Platform.PlatformSessionDurangoS2SEnabled = function()
	if LuaDefine.isDedicated == false or LuaDefine.isXboxClient == false then
		return false
	elseif false == Engine[0x56B4618D857143D]() then
		return false
	else
		return Dvar[0xBAA63BDAB580CE8]:get()
	end
end
Lobby.Platform.PlatformSessionPCEnabled = function()
	if LuaDefine.isPC == false or Engine[0xE39F1F30B306065]() then
		return false
	else
		return true
	end
end
Lobby.Platform.IsOnlineGame = function()
	if Engine[0xE89628E21B49660]() then
		return true
	else
		return false
	end
end
Lobby.Platform.IsRankedGame = function()
	local f7_local0
	if Lobby.Platform.IsOnlineGame() == true and not Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x5E90ACB801E4A3D]) then
		f7_local0 = not Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x7B5630CD29180CB])
	else
		f7_local0 = false
	end
	return f7_local0
end
Lobby.Platform.IsHost = function()
	return Engine[0x9E5BE3B4BBA4E0E]("sv_running")
end
Lobby.Platform.OnInit = function(f9_arg0)
	if Engine[0x573048F8D3B4E25]() == false then
		Engine[0xB177D654FFB67BE]("platformSessionCreateFailure", 0)
		Engine[0xB177D654FFB67BE]("platformSessionJoinFailure", 0)
		Engine[0xB177D654FFB67BE]("platformSessionLeaveFailure", 0)
		Engine[0xB177D654FFB67BE]("platformSessionSetActivityFailure", 0)
		Engine[0xB177D654FFB67BE]("platformSessionSetPartyPrivacyFailure", 0)
		Engine[0xB177D654FFB67BE]("platformSessionSetSessionClosedFailure", 0)
		Engine[0xB177D654FFB67BE]("platformSessionSetJoinRestrictionFailure", 0)
		Engine[0xB177D654FFB67BE]("platformSessionSetVisibilityFailure", 0)
	end
end
Lobby.Platform.OnSessionStart = function(f10_arg0)
	Lobby.Platform.PlatformSessionDirty(f10_arg0.lobbyType)
end
Lobby.Platform.OnSessionEnd = function(f11_arg0)
	Lobby.Platform.PlatformSessionDirty(f11_arg0.lobbyType)
end
Lobby.Platform.OnMatchStart = function(f12_arg0)
	local f12_local0 = f12_arg0.lobbyModule
	local f12_local1 = f12_arg0.lobbyType
	local f12_local2 = f12_arg0.lobbyMode
	if Lobby.Platform.PlatformSessionDurangoEnabled() then
		for f12_local3 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.XBOX.roundStart[f12_local3] = true
		end
	end
	if LuaDefine.isXbox then
		Engine[0xB177D654FFB67BE]("xblive_rta_enabled", 0)
	end
end
Lobby.Platform.OnMatchEnd = function(f13_arg0)
	local f13_local0 = f13_arg0.lobbyModule
	local f13_local1 = f13_arg0.lobbyType
	local f13_local2 = f13_arg0.lobbyMode
	if LuaDefine.isPS4 == true and f13_arg0.lobbyType == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and Enum[0xC84D3E505F1444][0xE99F41098B71960] == Engine[0xA63E42B2FB6EC02]() then
		for f13_local3 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			local f13_local6 = f13_local3 - 1
			if Engine[0x33A0182C8E1848A] ~= nil then
				Engine[0x33A0182C8E1848A](f13_local6)
			end
		end
	end
	if Lobby.Platform.PlatformSessionDurangoEnabled() then
		for f13_local3 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.XBOX.roundEnd[f13_local3] = true
		end
	end
	if LuaDefine.isXbox then
		Engine[0xB177D654FFB67BE]("xblive_rta_enabled", 1)
	end
end
Lobby.Platform.OnPlatformPlayTogether = function(f14_arg0)
	local f14_local0 = f14_arg0.controller
	if Lobby.Timer.LobbyIsLocked() then
		LuaUtils.UI_ShowErrorMessageDialog(f14_local0, Engine[0xF9F1239CFD921FE](0x1EC124551C8B7E5), Engine[0xF9F1239CFD921FE](0xFA1F1A14BB49273))
		return
	elseif f14_arg0.error == true then
		local f14_local1 = f14_arg0.debugInfo
		return
	end
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.closePopups"))
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
		if not Engine[0x95D8A0296E9E574]() then
			Lobby.Join.OnInGameJoin({
				controller = f14_local0,
				xuid = 0,
				platform = true,
				platformData = f14_arg0,
				playTogether = true,
				migrating = not CoDShared.QuitGame(f14_local0),
			}, true)
			return
		end
		local f14_local1 = Lobby.Platform.PS4ProcessPlayTogetherEvent(f14_arg0)
		if f14_local1 ~= nil then
			local f14_local2 = Lobby.Process.Recover(f14_local0, LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE))
			Lobby.Process.AppendProcess(f14_local2, f14_local1)
			Lobby.ProcessQueue.AddToQueue("OnPlatformPlayTogether", f14_local2)
		end
	end
end
Lobby.Platform.OnPlatformSessionDataUpdate = function(f15_arg0)
	local f15_local0 = f15_arg0.lobbyModule
	local f15_local1 = f15_arg0.lobbyType
	local f15_local2 = f15_arg0.lobbyMode
	local f15_local3 = f15_arg0.gamertag
	local f15_local4 = f15_arg0.sessionId
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "OnPlatformSessionDataUpdate event occurred, sessionId: '" .. f15_local4 .. "', gamertag: " .. f15_local3 .. ".\n")
	elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "OnPlatformSessionDataUpdate event occurred, sessionId: '" .. f15_local4 .. "', gamertag: " .. f15_local3 .. ".\n")
	end
	Lobby.Platform.PlatformSessionDirty(f15_local1)
end
Lobby.Platform.OnPlatformJoinOrbis = function(f16_arg0)
	local f16_local0 = f16_arg0.forController
	local f16_local1 = f16_arg0.forXuid
	local f16_local2 = f16_arg0.forGamertag
	local f16_local3 = f16_arg0.invite
	local f16_local4 = f16_arg0.invitationId
	local f16_local5 = f16_arg0.sessionId
	local f16_local6 = f16_local0
	local f16_local7 = Enum[0xC018C5F55467EB1][0xD4D58772DE8652]
	if not Engine[0x95D8A0296E9E574]() then
		local f16_local8 = {
			controller = f16_local6,
			xuid = 0,
		}
		local f16_local9
		if f16_local3 then
			f16_local9 = Enum[0xC018C5F55467EB1][0xD4D58772DE8652]
			if not f16_local9 then
			else
				f16_local8.joinType = f16_local9
				f16_local8.platform = true
				f16_local8.platformData = f16_arg0
				f16_local8.migrating = not CoDShared.QuitGame(f16_local6)
				Lobby.Join.OnInGameJoin(f16_local8, true)
				return
			end
		end
		f16_local9 = Enum[0xC018C5F55467EB1][0xC21E48130C4B82B]
	else
		if f16_local3 == false then
			f16_local7 = Enum[0xC018C5F55467EB1][0xC21E48130C4B82B]
			f16_local4 = nil
		end
		Lobby.ProcessQueue.AddToQueue("PS4SessionJoin", Lobby.ProcessPlatform.PS4AcceptInvite(f16_local0, f16_local1, f16_local4, f16_local5, f16_local7, LuaEnum.LEAVE_WITH_PARTY.WITHOUT))
	end
end
Lobby.Platform.InGamePlatformJoinOrbis = function(f17_arg0)
	local f17_local0 = f17_arg0.forController
	local f17_local1 = f17_arg0.forXuid
	local f17_local2 = f17_arg0.forGamertag
	local f17_local3 = f17_arg0.invite
	local f17_local4 = f17_arg0.invitationId
	local f17_local5 = f17_arg0.sessionId
	local f17_local6 = f17_local0
	local f17_local7 = Enum[0xC018C5F55467EB1][0xD4D58772DE8652]
	if f17_local3 == false then
		f17_local4 = nil
		f17_local7 = Enum[0xC018C5F55467EB1][0xC21E48130C4B82B]
	end
	return Lobby.ProcessPlatform.PS4AcceptInvite(f17_local0, f17_local1, f17_local4, f17_local5, f17_local7, LuaEnum.LEAVE_WITH_PARTY.WITHOUT)
end
Lobby.Platform.OnPlatformJoinDurango = function(f18_arg0)
	local f18_local0 = f18_arg0.invite
	local f18_local1 = 0
	local f18_local2 = 0
	if f18_local0 == true then
		f18_local2 = f18_arg0.senderXuid
		f18_local1 = Engine[0x852F787399D3F90](f18_arg0.invitedXuid)
	else
		f18_local2 = f18_arg0.joineeXuid
		f18_local1 = Engine[0x852F787399D3F90](f18_arg0.joinerXuid)
	end
	if f18_local1 == LuaDefine.INVALID_CONTROLLER_PORT then
		Engine[0xC28EAD1F7D00AD7](f18_arg0.invitedXuid)
		return nil
	elseif Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], f18_local2) or Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f18_local2) then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyVM: Trying to Join lobby we are already part of.\n")
		Engine[0x7C090837EE00D5E]()
		return nil
	elseif not Engine[0x95D8A0296E9E574]() then
		local f18_local3 = {
			controller = f18_local1,
			xuid = f18_local2,
		}
		local f18_local4
		if f18_local0 then
			f18_local4 = Enum[0xC018C5F55467EB1][0xD4D58772DE8652]
			if not f18_local4 then
			else
				f18_local3.joinType = f18_local4
				f18_local3.platform = true
				f18_local3.platformData = f18_arg0
				f18_local3.migrating = not CoDShared.QuitGame(f18_local1)
				Lobby.Join.OnInGameJoin(f18_local3, true)
				return nil
			end
		end
		f18_local4 = Enum[0xC018C5F55467EB1][0xC21E48130C4B82B]
	elseif f18_arg0.invite == true then
		Lobby.ProcessQueue.AddToQueue("XboxAcceptInvite", Lobby.ProcessPlatform.XboxJoin(Engine[0x852F787399D3F90](f18_arg0.invitedXuid), f18_arg0.senderXuid, Enum[0xC018C5F55467EB1][0xD4D58772DE8652], LuaEnum.LEAVE_WITH_PARTY.WITHOUT))
	else
		Lobby.ProcessQueue.AddToQueue("XboxSessionJoin", Lobby.ProcessPlatform.XboxJoin(Engine[0x852F787399D3F90](f18_arg0.joinerXuid), f18_arg0.joineeXuid, Enum[0xC018C5F55467EB1][0xC21E48130C4B82B], LuaEnum.LEAVE_WITH_PARTY.WITHOUT))
	end
end
Lobby.Platform.InGamePlatformJoinDurango = function(f19_arg0)
	if f19_arg0.invite == true then
		return Lobby.ProcessPlatform.XboxJoin(Engine[0x852F787399D3F90](f19_arg0.invitedXuid), f19_arg0.senderXuid, Enum[0xC018C5F55467EB1][0xD4D58772DE8652], LuaEnum.LEAVE_WITH_PARTY.WITHOUT)
	else
		return Lobby.ProcessPlatform.XboxJoin(Engine[0x852F787399D3F90](f19_arg0.joinerXuid), f19_arg0.joineeXuid, Enum[0xC018C5F55467EB1][0xC21E48130C4B82B], LuaEnum.LEAVE_WITH_PARTY.WITHOUT)
	end
end
Lobby.Platform.OnPlatformJoin = function(f20_arg0)
	if LuaDefine.isPS4 or LuaDefine.isXbox then
		if Lobby.Timer.LobbyIsLocked() then
			LuaUtils.UI_ShowErrorMessageDialog(controller, Engine[0xF9F1239CFD921FE](0x1EC124551C8B7E5), Engine[0xF9F1239CFD921FE](0xFA1F1A14BB49273))
			return
		elseif LuaDefine.isXbox then
			local f20_local0 = f20_arg0.invite
			local f20_local1 = 0
			if f20_local0 == true then
				f20_local1 = f20_arg0.senderXuid
			else
				f20_local1 = f20_arg0.joineeXuid
			end
			if Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], f20_local1) or Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f20_local1) then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyVM: Trying to Join lobby we are already part of.\n")
				Engine[0x7C090837EE00D5E]()
				return
			end
		end
	end
	if f20_arg0.error == true then
		local f20_local0 = f20_arg0.debugInfo
		return
	elseif LuaDefine.isPS4 then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "PlatformSession - OnPlatformJoin, sessionId:" .. f20_arg0.sessionId .. ", invite:" .. tostring(f20_arg0.invite) .. ", invitationId:" .. f20_arg0.invitationId .. ".\n")
	elseif LuaDefine.isXbox then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "PlatformSession - OnPlatformJoin, joinerXuid:" .. tostring(f20_arg0.joinerXuid) .. ", invite:" .. tostring(f20_arg0.invite) .. ", joineeXuid:" .. tostring(f20_arg0.joineeXuid) .. ".\n")
	end
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.closePopups"))
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
		Lobby.Platform.OnPlatformJoinOrbis(f20_arg0)
	elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
		Lobby.Platform.OnPlatformJoinDurango(f20_arg0)
	end
end
Lobby.Platform.PlatformSessionDirty = function(f21_arg0)
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
		if f21_arg0 ~= Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
			return
		end
		for f21_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.PS4.changed[f21_local0] = true
		end
	elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
		for f21_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.XBOX.changed[f21_local0][f21_arg0 + 1] = true
		end
	end
end
Lobby.Platform.TRCPump = function()
	if LuaDefine.isPS4 == false then
		return
	elseif Engine[0x724C6F17E39C2CA]() < 4 then
		return
	elseif Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
		for f22_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			local f22_local3 = f22_local0 - 1
			if Engine[0xF285055A1A895A1](f22_local3) then
				Engine[0x5A5A5714142EAC5](f22_local3)
				Engine[0x71B973F9BD8685D](f22_local3)
				Engine[0xCA1E0DA0A7B2AD8](f22_local3)
			end
		end
	end
end
local f0_local0 = function(f23_arg0, f23_arg1)
	Lobby.Platform.PS4.sessionId[f23_arg0 + 1] = f23_arg1
	Lobby.Platform.PS4.lobbyId[f23_arg0 + 1] = Engine[0x8CB6D1C656D57EE](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	Engine[0x7FA097EC16F2681](f23_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f23_arg1)
end
Lobby.Platform.PS4GetSessionId = function(f24_arg0)
	return Lobby.Platform.PS4.sessionId[f24_arg0 + 1]
end
local f0_local1 = function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
	Lobby.Platform.PS4.sessionFailure[f25_arg0 + 1] = f25_arg2
	Lobby.Platform.PS4.sessionFailureTime[f25_arg0 + 1] = f25_arg3
end
local f0_local2 = function(f26_arg0)
	local f26_local0 = f26_arg0 + 1
	Lobby.Platform.PS4.sessionId[f26_local0] = ""
	Lobby.Platform.PS4.lobbyId[f26_local0] = 0
	Lobby.Platform.PS4.changed[f26_local0] = 0
	Lobby.Platform.PS4.sessionFailure[f26_local0] = false
	Lobby.Platform.PS4.sessionFailureTime[f26_local0] = 0
	Lobby.Platform.PS4.lastSignedInState[f26_local0] = false
	Engine[0x7FA097EC16F2681](f26_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], "")
end
Lobby.Platform.PlatformSessionPS4Error = function(f27_arg0, f27_arg1)
	local f27_local0 = Dvar[0x12B11EC2E089C84]:get()
	Lobby.Platform.PS4.taskInProgress = false
	Engine[0xAF2EDE16C0386FE]()
	if f27_local0 == Enum[0xB29F571040F207F][0x75E6BB927BE46B4] then
		f0_local1(f27_arg0, true, Engine[0xEFF639FB8A1BE0A]() + Engine[0x22EAAB59AA27E9B](Lobby.Platform.DISABLE_PLATFORM_SESSIONS))
	elseif f27_local0 == Enum[0xB29F571040F207F][0xDB75ABE61E9C81F] then
		if Engine[0x7B48C1ABFF0F764]() == true then
			return
		end
		local f27_local1 = LobbyData.GetCurrentMenuTarget()
		if f27_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			return
		end
		local f27_local2 = {
			controller = f27_arg0,
			signoutUsers = false,
		}
		LobbyVM.ExecuteLobbyVMRequest(LuaEnum.LOBBYVM_REQUEST.FORCE_LOCAL_MODE)
		Engine[0xB972AE22481F1]()
		Lobby.ProcessQueue.ClearQueue()
		LobbyVM.OnErrorShutdown(f27_local2)
		LobbyVM.ShutdownCleanup(f27_local2)
		if Dvar[0x9D38D804EC061EB]:get() == true then
			LuaUtils.UI_ShowErrorMessageDialog(f27_arg0, "Platform Session Error: " .. f27_arg1)
		else
			LuaUtils.UI_ShowErrorMessageDialog(f27_arg0, Engine[0xF9F1239CFD921FE](0x95A36FDA596D61E))
		end
		return
	end
end
Lobby.Platform.PlatformSessionPS4GetLockFlag = function(f28_arg0)
	local f28_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_LOCK_FLAG.UNLOCKED
	if f28_arg0 == Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9] then
		f28_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_LOCK_FLAG.UNLOCKED
	elseif f28_arg0 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] then
		f28_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_LOCK_FLAG.UNLOCKED
	elseif f28_arg0 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] then
		f28_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_LOCK_FLAG.UNLOCKED
	elseif f28_arg0 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f28_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_LOCK_FLAG.LOCKED
	end
	return f28_local0
end
Lobby.Platform.PlatformSessionPS4GetSessionTypeFlag = function(f29_arg0)
	local f29_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_SESSION_FLAG.PUBLIC
	if f29_arg0 == Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9] then
		f29_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_SESSION_FLAG.PUBLIC
	elseif f29_arg0 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] then
		f29_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_SESSION_FLAG.PUBLIC
	elseif f29_arg0 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] then
		f29_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_SESSION_FLAG.PRIVATE
	elseif f29_arg0 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f29_local0 = Lobby.Platform.PLATFORM_SESSION_PS4_SESSION_FLAG.PUBLIC
	end
	return f29_local0
end
Lobby.Platform.PlatformSessionPS4CreateComplete = function(f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = f30_arg1.controller
	local f30_local1 = f30_arg2.isError
	local f30_local2 = f30_arg2.returnCode
	local f30_local3 = f30_arg2.returnCodeHex
	if f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4CreateComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f30_local1 == false then
			f0_local0(f30_local0, f30_arg2.sessionId)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4CreateComplete, we have successfully created session id: '" .. Lobby.Platform.PS4GetSessionId(f30_local0) .. "'.\n")
			if f30_local0 == Engine[0xA5B9C0111291A8B]() and Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4CreateComplete, we are host of private session, setting session data.\n")
				Engine[0xDBBD19176041D4B](Enum[0xBF54BE1BB3D618B][0xA1647599284110], Lobby.Platform.PS4GetSessionId(f30_local0))
			end
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Create failed: " .. f30_local3 .. "\n")
		end
	elseif f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Create failed: " .. f30_local3 .. "\n")
		f30_local1 = true
	end
	Lobby.Platform.PS4.taskInProgress = false
	if f30_local1 == true then
		Lobby.Platform.PlatformSessionPS4Error(f30_local0, f30_local3)
	end
	return true
end
Lobby.Platform.PlatformSessionPS4Create = function(f31_arg0, f31_arg1, f31_arg2)
	Lobby.Platform.PS4.taskInProgress = true
	Dvar[0xC97FE4F00531D2C]:set(Engine[0x384B563F1330474](0xCE60C4536B54FF3))
	local f31_local0, f31_local1 = Engine[0x40EC85343E0181F]()
	if f31_local0 == Enum[0x48909109238341F][0xCBD4CF0639724C3] then
		Dvar[0xC97FE4F00531D2C]:set(Engine[0x384B563F1330474](0xC466D0DC2A965FA))
	end
	Dvar[0xC866260CA069A59]:set(" ")
	Dvar[0xE2C2160849F5335]:set("")
	Dvar[0x5D1A8E8BCE18B7E]:set("platform_session.png")
	local f31_local2 = Engine[0xB4EEE57E45369DB]()
	local f31_local3 = Lobby.Platform.PlatformSessionPS4GetLockFlag(f31_local2)
	Lobby.Platform.PS4.lockFlag[f31_arg0 + 1] = f31_local2
	Dvar[0x9280DC8E09F070A]:set(f31_local3)
	local f31_local4 = Lobby.Platform.PlatformSessionPS4GetSessionTypeFlag(f31_local2)
	Lobby.Platform.PS4.sessionTypeFlag[f31_arg0 + 1] = f31_local2
	Dvar[0x715AEDE405E824B]:set(f31_local4)
	local f31_local5 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionPS4CreateComplete, {
		controller = f31_arg0,
		lobbyType = f31_arg1,
		maxSlot = f31_arg2,
	})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Create started.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionCreateFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Create FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f31_local5,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0xE2FB3A90F2AF97D](f31_local5, f31_arg0, f31_arg1, f31_arg2) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Create failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f31_local5,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Platform.PlatformSessionJoinCompletePS4 = function(f32_arg0, f32_arg1, f32_arg2)
	local f32_local0 = f32_arg1.controller
	local f32_local1 = f32_arg2.isError
	local f32_local2 = f32_arg2.returnCode
	local f32_local3 = f32_arg2.returnCodeHex
	if f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionJoinCompletePS4 ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f32_local1 == false then
			if f32_arg2.sessionId ~= nil then
				f0_local0(f32_local0, f32_arg2.sessionId)
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionJoinCompletePS4, we have successfully joined session id: '" .. Lobby.Platform.PS4GetSessionId(f32_local0) .. "'.\n")
			end
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Join failed: " .. f32_local3 .. "\n")
		end
	elseif f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Join failed: " .. f32_local3 .. "\n")
		f32_local1 = true
	end
	Lobby.Platform.PS4.taskInProgress = false
	if f32_local1 == true then
		Lobby.Platform.PlatformSessionPS4Error(f32_local0, f32_local3)
	end
	return true
end
Lobby.Platform.PlatformSessionPS4Join = function(f33_arg0, f33_arg1, f33_arg2)
	Lobby.Platform.PS4.taskInProgress = true
	local f33_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionJoinCompletePS4, {
		controller = f33_arg0,
		lobbyType = f33_arg1,
		sessionId = f33_arg2,
	})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Join started, joining sessionId: '" .. f33_arg2 .. "'.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionJoinFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Join FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f33_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0xB30A30609FE9AB9](f33_local0, f33_arg0, f33_arg1, f33_arg2) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Join failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f33_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Platform.PlatformSessionPS4LeaveComplete = function(f34_arg0, f34_arg1, f34_arg2)
	local f34_local0 = f34_arg1.controller
	local f34_local1 = f34_arg2.isError
	local f34_local2 = f34_arg2.returnCode
	local f34_local3 = f34_arg2.returnCodeHex
	if f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4LeaveComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f34_local1 == false then
			local f34_local4 = Engine[0x810BE2185A15DFF](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4LeaveComplete, we have successfully left session id: '" .. Lobby.Platform.PS4GetSessionId(f34_local0) .. "'.\n")
			if f34_local0 == Engine[0xA5B9C0111291A8B]() and f34_local4.sessionId == Lobby.Platform.PS4GetSessionId(f34_local0) then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4LeaveComplete, we are host of private session, clearing session data.\n")
				Engine[0x64DA6B993A721F2](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			end
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Leave failed: " .. f34_local3 .. "\n")
		end
	elseif f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Leave failed: " .. f34_local3 .. "\n")
		f34_local1 = true
	end
	f0_local0(f34_local0, "")
	Lobby.Platform.PS4.taskInProgress = false
	if f34_local1 == true then
		Lobby.Platform.PlatformSessionPS4Error(f34_local0, f34_local3)
	end
	return true
end
Lobby.Platform.PlatformSessionPS4Leave = function(f35_arg0, f35_arg1, f35_arg2)
	Lobby.Platform.PS4.taskInProgress = true
	local f35_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionPS4LeaveComplete, {
		controller = f35_arg0,
		lobbyType = f35_arg1,
		sessionId = f35_arg2,
	})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Leave started, leaving sessionId: '" .. f35_arg2 .. "'.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionLeaveFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Leave FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f35_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0x402D6CCEE2BA1C0](f35_local0, f35_arg0, f35_arg1, f35_arg2) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4Leave failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f35_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Platform.PlatformSessionPS4SetPartyPrivacyComplete = function(f36_arg0, f36_arg1, f36_arg2)
	local f36_local0 = f36_arg1.controller
	local f36_local1 = f36_arg1.lobbyType
	local f36_local2 = f36_arg2.isError
	local f36_local3 = f36_arg2.returnCode
	local f36_local4 = f36_arg2.returnCodeHex
	if f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4SetPartyPrivacyComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f36_local2 == false then
			local f36_local5 = f36_arg1.partyPrivacy
			Lobby.Platform.PS4.lockFlag[f36_local0 + 1] = f36_local5
			Lobby.Platform.PS4.sessionTypeFlag[f36_local0 + 1] = f36_local5
			Engine[0x7FA097EC16F2681](f36_local0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], "partyPrivacyStatus: " .. Lobby.Platform.PlatformSessionGetPartyPrivacyStatus(f36_local5))
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4SetPartyPrivacyComplete, we have successfully left session.\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4SetPartyPrivacy failed: " .. f36_local4 .. "\n")
		end
	elseif f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4SetPartyPrivacy failed: " .. f36_local4 .. "\n")
		f36_local2 = true
	end
	Lobby.Platform.PS4.taskInProgress = false
	if f36_local2 == true then
		Engine[0x7FA097EC16F2681](f36_local0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], "partyPrivacyStatus: ERROR")
		Lobby.Platform.PlatformSessionPS4Error(f36_local0, f36_local1, f36_local4)
	end
	return true
end
Lobby.Platform.PlatformSessionPS4SetPartyPrivacy = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3)
	local f37_local0 = Lobby.Platform.PlatformSessionPS4GetLockFlag(Lobby.Platform.PS4.lockFlag[f37_arg0 + 1])
	local f37_local1 = Lobby.Platform.PlatformSessionPS4GetLockFlag(f37_arg3)
	local f37_local2 = Lobby.Platform.PlatformSessionPS4GetSessionTypeFlag(Lobby.Platform.PS4.sessionTypeFlag[f37_arg0 + 1])
	local f37_local3 = Lobby.Platform.PlatformSessionPS4GetSessionTypeFlag(f37_arg3)
	if f37_local0 == f37_local1 and f37_local2 == f37_local3 then
		Lobby.Platform.PS4.lockFlag[f37_arg0 + 1] = f37_arg3
		Lobby.Platform.PS4.sessionTypeFlag[f37_arg0 + 1] = f37_arg3
		return
	else
		Lobby.Platform.PS4.taskInProgress = true
		local f37_local4 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionPS4SetPartyPrivacyComplete, {
			controller = f37_arg0,
			lobbyType = f37_arg1,
			sessionId = f37_arg2,
			partyPrivacy = f37_arg3,
		})
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4SetPartyPrivacy started.\n")
		if Engine[0x573048F8D3B4E25]() == false and 1 == Engine[0x22EAAB59AA27E9B]("platformSessionSetPartyPrivacyFailure") then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4SetPartyPrivacy FAILURE TEST.\n")
			LobbyVM.ProcessCompleteFailure({
				actionId = f37_local4,
				isError = true,
				returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
				returnCodeHex = "EVENT START ERROR",
			})
			return
		else
			Dvar[0x9280DC8E09F070A]:set(f37_local1)
			Dvar[0x715AEDE405E824B]:set(f37_local3)
			if Engine[0x78EBBEF5AC089D4](f37_local4, f37_arg0, f37_arg1, f37_arg2) == false then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xE2AF40CBFD5F81D], "PlatformSessionPS4SetPartyPrivacy failed to start.\n")
				LobbyVM.ProcessCompleteFailure({
					actionId = f37_local4,
					isError = true,
					returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
					returnCodeHex = "EVENT START ERROR",
				})
				return
			else
			end
		end
	end
end
Lobby.Platform.PlatformSessionPS4PumpController = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4, f38_arg5, f38_arg6, f38_arg7)
	local f38_local0 = f38_arg0 + 1
	local f38_local1 = Lobby.Platform.PS4GetSessionId(f38_arg0)
	local f38_local2 = Lobby.Platform.PS4.lobbyId[f38_local0]
	local f38_local3 = string.len(f38_local1) > 0
	local f38_local4 = Lobby.Platform.PS4.sessionFailure[f38_local0]
	if f38_arg4 == false then
		if f38_local3 == false and f38_local4 == false then
			return
		elseif f38_local3 == true and f38_local4 == false then
			Lobby.Platform.PlatformSessionPS4Leave(f38_arg0, f38_arg2, f38_local1)
		else
			f0_local0(f38_arg0, "")
			Lobby.Platform.PS4.sessionFailure[f38_local0] = false
		end
		return
	elseif f38_arg5 == false or f38_arg1 == false then
		if f38_local3 == false and f38_local4 == false then
			return
		elseif f38_local3 == true and f38_local4 == false then
			Lobby.Platform.PlatformSessionPS4Leave(f38_arg0, f38_arg2, f38_local1)
		else
			f0_local0(f38_arg0, "")
			Lobby.Platform.PS4.sessionFailure[f38_local0] = false
		end
		return
	elseif Lobby.Platform.PS4.changed[f38_local0] == true then
		local f38_local5 = Engine[0x810BE2185A15DFF](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
		if f38_local3 == true and (f38_local5.sessionId ~= f38_local1 or f38_local2 ~= Engine[0x8CB6D1C656D57EE](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])) then
			Lobby.Platform.PlatformSessionPS4Leave(f38_arg0, f38_arg2, f38_local1)
		end
		Lobby.Platform.PS4.changed[f38_local0] = false
		return
	elseif f38_local4 == false then
		if f38_local3 == true then
			if true == Dvar[0x39176BF65C21B9A]:get() and f38_arg0 == f38_arg7 and f38_arg2 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
				local f38_local5 = Engine[0xB4EEE57E45369DB]()
				if Lobby.Platform.PS4.lockFlag[f38_local0] ~= f38_local5 then
					Lobby.Platform.PlatformSessionPS4SetPartyPrivacy(f38_arg0, f38_arg2, f38_local1, f38_local5)
					return
				end
			end
			return
		elseif f38_arg6 == true and f38_arg0 == f38_arg7 then
			Lobby.Platform.PlatformSessionPS4Create(f38_arg0, f38_arg2, f38_arg3)
			return
		end
		local f38_local5 = Engine[0x810BE2185A15DFF](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
		if f38_local5.sessionId ~= "" then
			Lobby.Platform.PlatformSessionPS4Join(f38_arg0, f38_arg2, f38_local5.sessionId)
		end
		return
	else
	end
end
Lobby.Platform.PlatformSessionPS4Pump = function()
	if Lobby.Platform.PS4.taskInProgress ~= true and true ~= Engine[0x72C6381CF1C22CA]() then
		if Lobby.ProcessQueue.IsQueueEmpty() == false then
			local f39_local0 = Lobby.ProcessQueue.GetQueueHead()
			if f39_local0.nonPSNSessionBlocking ~= true then
				Lobby.Platform.PS4.updateTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x7E9699E9C030C67]:get()
				return
			end
		end
		if Lobby.Platform.PS4.updateTime > Engine[0x9D33D652B9B0F3B]() then
			return
		end
		Lobby.Platform.PS4.updateTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x7E9699E9C030C67]:get()
		local f39_local0 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
		local f39_local1 = 18
		local f39_local2 = Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960]
		local f39_local3 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f39_local0)
		local f39_local4 = Engine[0xEA2BE00F49480D](f39_local0)
		local f39_local5
		if f39_local4 then
			f39_local5 = Engine[0x3797858022DCB59](f39_local0)
			if not f39_local5 then
			else
				for f39_local6 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
					local f39_local9 = f39_local6 - 1
					local f39_local10 = Engine[0xD37197A182D17E1](f39_local9)
					local f39_local11 = Engine[0xF285055A1A895A1](f39_local9)
					if f39_local10 == true then
						Lobby.Platform.PlatformSessionPS4PumpController(f39_local9, f39_local11, f39_local0, f39_local1, f39_local2, f39_local3, f39_local4, f39_local5)
					elseif Lobby.Platform.PS4.lastSignedInState[f39_local6] == true then
						f0_local2(f39_local9)
					end
					Lobby.Platform.PS4.lastSignedInState[f39_local6] = f39_local10
					if Lobby.Platform.PS4.taskInProgress == true then
						return
					end
				end
			end
		end
		f39_local5 = LuaDefine.INVALID_CONTROLLER_PORT
	end
	Lobby.Platform.PS4.updateTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x7E9699E9C030C67]:get()
	return
end
local f0_local3 = function(f40_arg0, f40_arg1, f40_arg2)
	Lobby.Platform.XBOX.templateName[f40_arg0 + 1][f40_arg1 + 1] = f40_arg2
end
local f0_local4 = function(f41_arg0, f41_arg1)
	return Lobby.Platform.XBOX.templateName[f41_arg0 + 1][f41_arg1 + 1]
end
local f0_local5 = function(f42_arg0, f42_arg1, f42_arg2)
	Lobby.Platform.XBOX.sessionId[f42_arg0 + 1][f42_arg1 + 1] = f42_arg2
	Engine[0x7FA097EC16F2681](f42_arg0, f42_arg1, f42_arg2)
end
local f0_local6 = function(f43_arg0, f43_arg1)
	return Lobby.Platform.XBOX.sessionId[f43_arg0 + 1][f43_arg1 + 1]
end
local f0_local7 = function(f44_arg0, f44_arg1, f44_arg2)
	Lobby.Platform.XBOX.changed[f44_arg0 + 1][f44_arg1 + 1] = f44_arg2
end
local f0_local8 = function(f45_arg0, f45_arg1)
	return Lobby.Platform.XBOX.changed[f45_arg0 + 1][f45_arg1 + 1]
end
local f0_local9 = function(f46_arg0, f46_arg1, f46_arg2)
	Lobby.Platform.XBOX.sessionFailure[f46_arg0 + 1] = f46_arg1
	Lobby.Platform.XBOX.sessionFailureTime[f46_arg0 + 1] = f46_arg2
end
local f0_local10 = function(f47_arg0)
	return Lobby.Platform.XBOX.sessionFailure[f47_arg0 + 1]
end
local f0_local11 = function(f48_arg0, f48_arg1)
	return f0_local4(f48_arg0, f48_arg1), f0_local6(f48_arg0, f48_arg1)
end
local f0_local12 = function(f49_arg0, f49_arg1)
	Engine[0x7FA097EC16F2681](f49_arg0, f49_arg1, f0_local6(f49_arg0, f49_arg1), "  start[ " .. tostring(Lobby.Platform.XBOX.roundStartCounter[f49_arg0 + 1]) .. " ], end[ " .. tostring(Lobby.Platform.XBOX.roundEndCounter[f49_arg0 + 1]) .. " ]")
end
local f0_local13 = function(f50_arg0, f50_arg1)
	local f50_local0 = f50_arg0 + 1
	Lobby.Platform.XBOX.disabled[f50_local0] = false
	f0_local9(f50_arg0, false, 0)
	Lobby.Platform.XBOX.lastSignedInState[f50_local0] = false
	for f50_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], 1 do
		f0_local5(f50_arg0, f50_local1, "")
		f0_local7(f50_arg0, f50_local1, false)
		Engine[0x556D44B51D02416](f50_arg0, f50_local1)
	end
	Lobby.Platform.XBOX.roundStart[f50_local0] = false
	Lobby.Platform.XBOX.roundStartSessionId[f50_local0] = ""
	Lobby.Platform.XBOX.roundEnd[f50_local0] = false
	Lobby.Platform.XBOX.playerSessionId[f50_local0] = nil
	Lobby.Platform.XBOX.roundStartTime[f50_local0] = 0
	Lobby.Platform.XBOX.roundStartCounter[f50_local0] = 0
	Lobby.Platform.XBOX.roundEndCounter[f50_local0] = 0
	Lobby.Platform.XBOX.sessionClosed[f50_local0] = Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
	Lobby.Platform.XBOX.joinRestriction[f50_local0] = Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
	Lobby.Platform.XBOX.visibility[f50_local0] = Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
	if f50_arg1 == true then
		Lobby.Platform.XBOX.rtaSubscribe[f50_local0] = false
	end
end
Lobby.Platform.PlatformSessionUpdateErrorCount = function(f51_arg0)
	local f51_local0 = f51_arg0 + 1
	if not Engine[0x351C2A2F9B235FB](f51_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C]) then
		return
	end
	local f51_local1 = Engine[0x8BF970606552F4C](f51_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	if f51_local1 == nil then
		return
	end
	local f51_local2 = f51_local1.demonwareflags[15]:get() + 1
	if f51_local2 > 255 then
		f51_local2 = 255
	end
	f51_local1.demonwareflags[15]:set(f51_local2)
	Lobby.Platform.XBOX.disabled[f51_local0] = nil
end
Lobby.Platform.PlatformSessionXboxError = function(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = Dvar[0x7843C9D23778443]:get()
	Lobby.Platform.XBOX.taskInProgress = false
	Lobby.Platform.PlatformSessionUpdateErrorCount(f52_arg0)
	Engine[0xAF2EDE16C0386FE]()
	if f52_local0 == Enum[0xB29F571040F207F][0x75E6BB927BE46B4] then
		f0_local13(f52_arg0, false)
		f0_local9(f52_arg0, true, Lobby.Platform.DISABLE_PLATFORM_SESSIONS)
	elseif f52_local0 == Enum[0xB29F571040F207F][0xDB75ABE61E9C81F] then
		LobbyVM.ExecuteLobbyVMRequest(LuaEnum.LOBBYVM_REQUEST.FORCE_LOCAL_MODE)
		if Dvar[0x9D38D804EC061EB]:get() == true then
			Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x2FD312C2C06EC11], "Platform Session Error: " .. f52_arg2)
		else
			Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x2FD312C2C06EC11], Engine[0xF9F1239CFD921FE](0x95A36FDA596D61E))
		end
	end
end
Lobby.Platform.PlatformSessionXboxGenerateSessionId = function(f53_arg0)
	local f53_local0 = Engine[0xA33D06620AC0D6B](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f53_arg0)
	if f53_local0 == nil then
		return false, ""
	else
		return true, Engine[0x3D5B539E107F8FD](f53_local0.secId)
	end
end
Lobby.Platform.PlatformSessionXboxCreateComplete = function(f54_arg0, f54_arg1, f54_arg2)
	local f54_local0 = f54_arg1.controller
	local f54_local1 = f54_arg1.lobbyType
	local f54_local2 = f54_arg2.isError
	local f54_local3 = f54_arg2.returnCode
	local f54_local4 = f54_arg2.returnCodeHex
	if f54_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxCreateComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f54_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f54_local2 == false then
			f0_local5(f54_local0, f54_local1, f54_arg2.sessionId)
			Engine[0x9E73F59228A7DCD](Enum[0xBF54BE1BB3D618B][0xA1647599284110], f0_local6(f54_local0, f54_local1), f0_local4(f54_local0, f54_local1))
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxCreateComplete, we have successfully created session id: '" .. f54_arg2.sessionId .. "'.\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxCreate failed: " .. f54_local4 .. "\n")
		end
	elseif f54_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f54_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxCreate failed: " .. f54_local4 .. "\n")
		f54_local2 = true
	end
	Lobby.Platform.XBOX.taskInProgress = false
	if f54_local2 == true then
		Lobby.Platform.PlatformSessionXboxError(f54_local0, f54_local1, f54_local4)
		return true
	elseif f54_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS and f54_local2 == false and f54_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
		Lobby.Platform.PlatformSessionXboxSetActivity(f54_local0, f54_local1)
	end
	return true
end
Lobby.Platform.PlatformSessionXboxCreate = function(f55_arg0, f55_arg1)
	Lobby.Platform.XBOX.taskInProgress = true
	local f55_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionXboxCreateComplete, {
		controller = f55_arg0,
		lobbyType = f55_arg1,
	})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxCreate started.\n")
	local f55_local1 = f0_local4(f55_arg0, f55_arg1)
	local f55_local2, f55_local3 = Lobby.Platform.PlatformSessionXboxGenerateSessionId(f55_arg1)
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionCreateFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxCreate FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f55_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif f55_local2 == false or Engine[0x725E4DF0727049F](f55_local0, f55_arg0, f55_arg1, f55_local1, f55_local3) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxCreate failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f55_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Platform.PlatformSessionXboxSetActivityComplete = function(f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = f56_arg1.controller
	local f56_local1 = f56_arg1.lobbyType
	local f56_local2 = f56_arg1.sessionId
	local f56_local3 = f56_arg2.isError
	local f56_local4 = f56_arg2.returnCode
	local f56_local5 = f56_arg2.returnCodeHex
	if f56_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetActivityComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f56_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f56_local3 == false then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetActivityComplete, we have successfully set sessionId: '" .. f56_local2 .. "' to be the activity session.\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetActivity failed: " .. f56_local5 .. "\n")
		end
	elseif f56_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f56_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetActivity failed: " .. f56_local5 .. "\n")
		f56_local3 = true
	end
	Lobby.Platform.XBOX.taskInProgress = false
	if f56_local3 == true then
		Lobby.Platform.PlatformSessionXboxError(f56_local0, f56_local1, f56_local5)
	end
	return true
end
Lobby.Platform.PlatformSessionXboxSetActivity = function(f57_arg0, f57_arg1)
	Lobby.Platform.XBOX.taskInProgress = true
	local f57_local0, f57_local1 = f0_local11(f57_arg0, f57_arg1)
	local f57_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionXboxSetActivityComplete, {
		controller = f57_arg0,
		lobbyType = f57_arg1,
		sessionId = f57_local1,
	})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetActivity started for sessionId: '" .. f57_local1 .. "'.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionSetActivityFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetActivity FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f57_local2,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0x499DB359DD497E4](f57_local2, f57_arg0, f57_arg1, f57_local0, f57_local1) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetActivity failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f57_local2,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Platform.PlatformSessionXboxLeaveComplete = function(f58_arg0, f58_arg1, f58_arg2)
	local f58_local0 = f58_arg1.controller
	local f58_local1 = f58_arg1.lobbyType
	local f58_local2 = f58_arg2.isError
	local f58_local3 = f58_arg2.returnCode
	local f58_local4 = f58_arg2.returnCodeHex
	if f58_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxLeaveComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f58_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f58_local2 == false then
			local f58_local5 = Engine[0x45FD16626F84E51](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxLeaveComplete, we have successfully left session.\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxLeave failed: " .. f58_local4 .. "\n")
		end
	elseif f58_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f58_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxLeave failed: " .. f58_local4 .. "\n")
		f58_local2 = true
	end
	f0_local5(f58_local0, f58_local1, "")
	Lobby.Platform.XBOX.taskInProgress = false
	if f58_local2 == true then
		Lobby.Platform.PlatformSessionXboxError(f58_local0, f58_local1, f58_local4)
	end
	return true
end
Lobby.Platform.PlatformSessionXboxLeave = function(f59_arg0, f59_arg1, f59_arg2)
	Lobby.Platform.XBOX.taskInProgress = true
	Lobby.Platform.PlatformSessionXboxRoundEnd(f59_arg0, f59_arg1)
	local f59_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionXboxLeaveComplete, {
		controller = f59_arg0,
		lobbyType = f59_arg1,
	})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxLeave started.\n")
	local f59_local1, f59_local2 = f0_local11(f59_arg0, f59_arg1)
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionLeaveFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxLeave FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f59_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0x5EE71E805F47162](f59_local0, f59_arg0, f59_arg1, f59_local1, f59_local2) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxLeave failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f59_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Platform.PlatformSessionXboxSetSessionClosedSetDebugStatus = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3)
	local f60_local0 = "OPEN"
	if f60_arg3 == Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9] then
		f60_local0 = "OPEN"
	elseif f60_arg3 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] then
		f60_local0 = "FRIENDS ONLY"
	elseif f60_arg3 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] then
		f60_local0 = "INVITE ONLY"
	elseif f60_arg3 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f60_local0 = "CLOSED"
	end
	Engine[0x7FA097EC16F2681](f60_arg0, f60_arg1, f60_arg2, f60_local0)
end
Lobby.Platform.PlatformSessionXboxSetSessionClosedComplete = function(f61_arg0, f61_arg1, f61_arg2)
	local f61_local0 = f61_arg1.controller
	local f61_local1 = f61_arg1.lobbyType
	local f61_local2 = f61_arg2.isError
	local f61_local3 = f61_arg2.returnCode
	local f61_local4 = f61_arg2.returnCodeHex
	if f61_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetSessionClosedComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f61_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f61_local2 == false then
			Lobby.Platform.XBOX.sessionClosed[f61_local0 + 1] = f61_arg1.partyPrivacy
			Lobby.Platform.PlatformSessionXboxSetSessionClosedSetDebugStatus(f61_local0, f61_local1, f61_arg1.sessionId, f61_arg1.partyPrivacy)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetSessionClosedComplete, we have successfully left session.\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetSessionClosed failed: " .. f61_local4 .. "\n")
		end
	elseif f61_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f61_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetSessionClosed failed: " .. f61_local4 .. "\n")
		f61_local2 = true
	end
	Lobby.Platform.XBOX.taskInProgress = false
	if f61_local2 == true then
		Engine[0x7FA097EC16F2681](f61_local0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f61_arg1.sessionId, "ERROR")
		Lobby.Platform.PlatformSessionXboxError(f61_local0, f61_local1, f61_local4)
	end
	return true
end
Lobby.Platform.PlatformSessionXboxIsSessionClosed = function(f62_arg0)
	local f62_local0 = false
	if f62_arg0 == Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9] then
		f62_local0 = false
	elseif f62_arg0 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] then
		f62_local0 = false
	elseif f62_arg0 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] then
		f62_local0 = false
	elseif f62_arg0 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f62_local0 = true
	end
	return f62_local0
end
Lobby.Platform.PlatformSessionXboxSetSessionClosed = function(f63_arg0, f63_arg1, f63_arg2, f63_arg3)
	local f63_local0 = Lobby.Platform.PlatformSessionXboxIsSessionClosed(Lobby.Platform.XBOX.sessionClosed[f63_arg0 + 1])
	local f63_local1 = Lobby.Platform.PlatformSessionXboxIsSessionClosed(f63_arg3)
	if f63_local0 == f63_local1 then
		Lobby.Platform.XBOX.sessionClosed[f63_arg0 + 1] = f63_arg3
		Lobby.Platform.PlatformSessionXboxSetSessionClosedSetDebugStatus(f63_arg0, f63_arg1, f63_arg2, f63_arg3)
		return
	else
		Lobby.Platform.XBOX.taskInProgress = true
		local f63_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionXboxSetSessionClosedComplete, {
			controller = f63_arg0,
			lobbyType = f63_arg1,
			sessionId = f63_arg2,
			partyPrivacy = f63_arg3,
		})
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetSessionClosed started.\n")
		if Engine[0x573048F8D3B4E25]() == false and 1 == Engine[0x22EAAB59AA27E9B]("platformSessionSetSessionClosedFailure") then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetSessionClosed FAILURE TEST.\n")
			LobbyVM.ProcessCompleteFailure({
				actionId = f63_local2,
				isError = true,
				returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
				returnCodeHex = "EVENT START ERROR",
			})
			return
		elseif Engine[0x863A13A2C95973](f63_local2, f63_arg0, f63_arg1, f63_local1) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetSessionClosed failed to start.\n")
			LobbyVM.ProcessCompleteFailure({
				actionId = f63_local2,
				isError = true,
				returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
				returnCodeHex = "EVENT START ERROR",
			})
			return
		else
		end
	end
end
Lobby.Platform.PlatformSessionXboxSetJoinRestrictionComplete = function(f64_arg0, f64_arg1, f64_arg2)
	local f64_local0 = f64_arg1.controller
	local f64_local1 = f64_arg1.lobbyType
	local f64_local2 = f64_arg2.isError
	local f64_local3 = f64_arg2.returnCode
	local f64_local4 = f64_arg2.returnCodeHex
	if f64_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetJoinRestrictionComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f64_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f64_local2 == false then
			Lobby.Platform.XBOX.joinRestriction[f64_local0 + 1] = f64_arg1.partyPrivacy
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetJoinRestrictionComplete, we have successfully left session.\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetJoinRestriction failed: " .. f64_local4 .. "\n")
		end
	elseif f64_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f64_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetJoinRestriction failed: " .. f64_local4 .. "\n")
		f64_local2 = true
	end
	Lobby.Platform.XBOX.taskInProgress = false
	if f64_local2 == true then
		Lobby.Platform.PlatformSessionXboxError(f64_local0, f64_local1, f64_local4)
	end
	return true
end
Lobby.Platform.PlatformSessionXboxGetJoinRestriction = function(f65_arg0)
	local f65_local0 = Enum[0xD7CF7A39E18C613][0x50627BF34457EB5]
	if f65_arg0 == Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9] then
		f65_local0 = Enum[0xD7CF7A39E18C613][0x50627BF34457EB5]
	elseif f65_arg0 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] then
		f65_local0 = Enum[0xD7CF7A39E18C613][0x818AA82EE1EA737]
	elseif f65_arg0 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] then
		f65_local0 = Enum[0xD7CF7A39E18C613][0x49A29EB19BE42D2]
	elseif f65_arg0 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f65_local0 = Enum[0xD7CF7A39E18C613][0x49A29EB19BE42D2]
	end
	return f65_local0
end
Lobby.Platform.PlatformSessionXboxSetJoinRestriction = function(f66_arg0, f66_arg1, f66_arg2, f66_arg3)
	local f66_local0 = Lobby.Platform.PlatformSessionXboxGetJoinRestriction(Lobby.Platform.XBOX.joinRestriction[f66_arg0 + 1])
	local f66_local1 = Lobby.Platform.PlatformSessionXboxGetJoinRestriction(f66_arg3)
	if f66_local0 == f66_local1 then
		Lobby.Platform.XBOX.joinRestriction[f66_arg0 + 1] = f66_arg3
		return
	else
		Lobby.Platform.XBOX.taskInProgress = true
		local f66_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionXboxSetJoinRestrictionComplete, {
			controller = f66_arg0,
			lobbyType = f66_arg1,
			sessionId = f66_arg2,
			partyPrivacy = f66_arg3,
			joinRestriction = f66_local1,
		})
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetJoinRestriction started.\n")
		if Engine[0x573048F8D3B4E25]() == false and 1 == Engine[0x22EAAB59AA27E9B]("platformSessionSetJoinRestrictionFailure") then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetJoinRestriction FAILURE TEST.\n")
			LobbyVM.ProcessCompleteFailure({
				actionId = f66_local2,
				isError = true,
				returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
				returnCodeHex = "EVENT START ERROR",
			})
			return
		elseif Engine[0x9662D74EAD22C79](f66_local2, f66_arg0, f66_arg1, f66_local1) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetJoinRestriction failed to start.\n")
			LobbyVM.ProcessCompleteFailure({
				actionId = f66_local2,
				isError = true,
				returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
				returnCodeHex = "EVENT START ERROR",
			})
			return
		else
		end
	end
end
Lobby.Platform.PlatformSessionXboxSetVisibilityComplete = function(f67_arg0, f67_arg1, f67_arg2)
	local f67_local0 = f67_arg1.controller
	local f67_local1 = f67_arg1.lobbyType
	local f67_local2 = f67_arg2.isError
	local f67_local3 = f67_arg2.returnCode
	local f67_local4 = f67_arg2.returnCodeHex
	if f67_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetVisibilityComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f67_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f67_local2 == false then
			Lobby.Platform.XBOX.visibility[f67_local0 + 1] = f67_arg1.partyPrivacy
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetVisibilityComplete, we have successfully left session.\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetVisibility failed: " .. f67_local4 .. "\n")
		end
	elseif f67_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f67_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetVisibility failed: " .. f67_local4 .. "\n")
		f67_local2 = true
	end
	Lobby.Platform.XBOX.taskInProgress = false
	if f67_local2 == true then
		Lobby.Platform.PlatformSessionXboxError(f67_local0, f67_local1, f67_local4)
	end
	return true
end
Lobby.Platform.PlatformSessionXboxSetVisibility = function(f68_arg0, f68_arg1, f68_arg2, f68_arg3)
	Lobby.Platform.XBOX.taskInProgress = true
	local f68_local0 = Enum[0xD8EBB80D2449DEB][0x4C8B7DA24976D4C]
	if f68_arg3 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f68_local0 = Enum[0xD8EBB80D2449DEB][0xE11D4518DDF1207]
	end
	local f68_local1 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionXboxSetVisibilityComplete, {
		controller = f68_arg0,
		lobbyType = f68_arg1,
		sessionId = f68_arg2,
		partyPrivacy = f68_arg3,
		visibility = f68_local0,
	})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetVisibility started.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionSetVisibilityFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetVisibility FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f68_local1,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0xC7CFCAB122CDABB](f68_local1, f68_arg0, f68_arg1, f68_local0) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "PlatformSessionXboxSetVisibility failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f68_local1,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Platform.PlatformSessionXboxRoundStart = function(f69_arg0, f69_arg1)
	local f69_local0 = f69_arg0 + 1
	Lobby.Platform.XBOX.roundStart[f69_local0] = false
	local f69_local1, f69_local2 = f0_local11(f69_arg0, f69_arg1)
	local f69_local3, f69_local4 = Engine[0xD0EDFB76022E2B9](f69_arg0, f69_arg1, f69_local1, f69_local2)
	if f69_local3 == true then
		Lobby.Platform.XBOX.roundStartSessionId[f69_local0] = f69_local2
		Lobby.Platform.XBOX.roundStartTime[f69_local0] = Engine[0x9D33D652B9B0F3B]()
		Lobby.Platform.XBOX.roundStartCounter[f69_local0] = Lobby.Platform.XBOX.roundStartCounter[f69_local0] + 1
		f0_local12(f69_arg0, f69_arg1)
		Lobby.Platform.XBOX.playerSessionId[f69_local0] = f69_local4.guid
	end
end
Lobby.Platform.PlatformSessionXboxRoundEnd = function(f70_arg0, f70_arg1)
	local f70_local0 = f70_arg0 + 1
	Lobby.Platform.XBOX.roundEnd[f70_local0] = false
	local f70_local1 = Lobby.Platform.XBOX.playerSessionId[f70_local0]
	if f70_local1 ~= nil then
		local f70_local2 = Lobby.Platform.XBOX.roundStartTime[f70_local0]
		local f70_local3, f70_local4 = f0_local11(f70_arg0, f70_arg1)
		local f70_local5 = Lobby.Platform.XBOX.roundStartSessionId[f70_local0]
		if f70_local5 == f0_local6(f70_arg0, f70_arg1) then
			Engine[0xA0C5FA577380928](f70_arg0, f70_arg1, f70_local3, f70_local5, f70_local1, f70_local2)
			Lobby.Platform.XBOX.roundEndCounter[f70_local0] = Lobby.Platform.XBOX.roundEndCounter[f70_local0] + 1
			f0_local12(f70_arg0, f70_arg1)
		end
	end
	Lobby.Platform.XBOX.roundStartSessionId[f70_local0] = nil
	Lobby.Platform.XBOX.playerSessionId[f70_local0] = nil
	Lobby.Platform.XBOX.roundStartTime[f70_local0] = 0
end
Lobby.Platform.OnPlatformSessionMultiplayerSessionChanged = function(f71_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "Lobby.Platform.OnPlatformSessionMultiplayerSessionChanged().\n")
end
Lobby.Platform.OnPlatformSessionMultiplayerSubscriptionLost = function(f72_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xEE5ED682C5B1AEF], "Lobby.Platform.OnPlatformSessionMultiplayerSubscriptionLost().\n")
	if Dvar[0x8A4AA20D982B45C]:get() == false then
		for f72_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			f0_local13(f72_local0 - 1, false)
		end
	end
end
Lobby.Platform.OnPlatformSuspend = function(f73_arg0)
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
	elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
		for f73_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.PlatformSessionXboxRoundEnd(f73_local0 - 1, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		end
	end
end
Lobby.Platform.OnPlatformResume = function(f74_arg0)
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA1C4971DA015C84], "OnPlatformResume(), clear all session data.\n")
		Engine[0x64DA6B993A721F2](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
		for f74_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			f0_local0(f74_local0 - 1, "")
		end
	elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
	else
	end
end
Lobby.Platform.PlatformSessionXboxRTASubscription = function(f75_arg0, f75_arg1, f75_arg2, f75_arg3)
	if Dvar[0x8A4AA20D982B45C]:get() == false then
		local f75_local0 = f75_arg0 + 1
		if f75_arg1 == true and Lobby.Platform.XBOX.rtaSubscribe[f75_local0] == false and f75_arg3 == true then
			local f75_local1, f75_local2, f75_local3 = Engine[0x52099BADCE857DD](f75_arg0)
			if f75_local1 == true then
				Lobby.Platform.XBOX.rtaSubscribe[f75_local0] = true
				Lobby.Platform.XBOX.sessionChangeToken[f75_local0] = f75_local2
				Lobby.Platform.XBOX.subscriptionLostToken[f75_local0] = f75_local3
			else
				Lobby.Platform.PlatformSessionXboxError(f75_arg0, f75_arg2, "PlatformSessionXboxEnableRTASubscription")
				return
			end
		end
		if Lobby.Platform.XBOX.rtaSubscribe[f75_local0] == false then
			return
		end
	end
end
Lobby.Platform.PlatformSessionXboxDisabled = function(f76_arg0, f76_arg1, f76_arg2, f76_arg3, f76_arg4)
	local f76_local0 = f76_arg0 + 1
	if LuaUtils.OnlineOnlyDemo() == true and LuaUtils.WarzoneModeAvailable() and Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and f76_arg2 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
		return true
	elseif Lobby.Platform.XBOX.disabled[f76_local0] == true then
		return true
	elseif f76_arg3 == true and Lobby.Platform.XBOX.disabled[f76_local0] == nil and Engine[0x351C2A2F9B235FB](f76_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C]) then
		local f76_local1 = Engine[0x8BF970606552F4C](f76_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
		if f76_local1 then
			Lobby.Platform.XBOX.disabled[f76_local0] = false
			local f76_local2 = Engine[0x22EAAB59AA27E9B]("platformSessionDisableCount")
			if f76_local2 > -1 and f76_local2 <= f76_local1.demonwareflags[15]:get() then
				Lobby.Platform.XBOX.disabled[f76_local0] = true
				return true
			end
		end
	end
	if Lobby.Platform.XBOX.sessionFailure[f76_local0] == true then
		if Lobby.Platform.XBOX.sessionFailureTime[f76_local0] == Lobby.Platform.DISABLE_PLATFORM_SESSIONS then
			return true
		elseif Lobby.Platform.XBOX.sessionFailureTime[f76_local0] < Engine[0xEFF639FB8A1BE0A]() then
			Lobby.Platform.XBOX.sessionFailure[f76_local0] = false
			return false
		end
		return true
	end
end
Lobby.Platform.PlatformSessionXboxPumpController = function(f77_arg0, f77_arg1, f77_arg2, f77_arg3, f77_arg4, f77_arg5, f77_arg6)
	local f77_local0 = f77_arg0 + 1
	Lobby.Platform.PlatformSessionXboxRTASubscription(f77_arg0, f77_arg1, f77_arg2, f77_arg4)
	local f77_local1 = string.len(f0_local6(f77_arg0, f77_arg2)) > 0
	local f77_local2 = f0_local8(f77_arg0, f77_arg2)
	local f77_local3 = Lobby.Platform.XBOX.roundStart[f77_local0]
	local f77_local4 = Lobby.Platform.XBOX.roundEnd[f77_local0]
	if Lobby.Platform.PlatformSessionXboxDisabled(f77_arg0, f77_arg1, f77_arg2, f77_arg3, f77_arg4) then
		return
	elseif f77_arg3 == false then
		if f77_local1 == true then
			Lobby.Platform.PlatformSessionXboxLeave(f77_arg0, f77_arg2)
		end
		return
	elseif f77_local1 == true and (f77_arg4 == false or f77_arg1 == false) then
		Lobby.Platform.PlatformSessionXboxLeave(f77_arg0, f77_arg2)
		return
	elseif f77_arg4 == false or f77_arg1 == false then
		return
	elseif f77_local1 == false and f77_local2 == true then
		f0_local7(f77_arg0, f77_arg2, false)
	end
	if f77_local1 == true then
		if f77_arg2 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
			if f77_local2 == true then
				local f77_local5, f77_local6 = Lobby.Platform.PlatformSessionXboxGenerateSessionId(f77_arg2)
				if f77_local5 == true and f77_local6 ~= f0_local6(f77_arg0, f77_arg2) then
					Lobby.Platform.PlatformSessionXboxLeave(f77_arg0, f77_arg2)
				end
				f0_local7(f77_arg0, f77_arg2, false)
				return
			elseif f77_local4 == true then
				Lobby.Platform.PlatformSessionXboxRoundEnd(f77_arg0, f77_arg2)
				return
			elseif f77_local3 == true then
				Lobby.Platform.PlatformSessionXboxRoundStart(f77_arg0, f77_arg2)
				return
			end
		end
		if true == Dvar[0x39176BF65C21B9A]:get() and f77_arg0 == f77_arg6 and f77_arg2 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
			local f77_local5 = Engine[0xB4EEE57E45369DB]()
			local f77_local6 = f0_local6(f77_arg0, f77_arg2)
			if Lobby.Platform.XBOX.sessionClosed[f77_local0] ~= f77_local5 then
				Lobby.Platform.PlatformSessionXboxSetSessionClosed(f77_arg0, f77_arg2, f77_local6, f77_local5)
				return
			elseif Lobby.Platform.XBOX.joinRestriction[f77_local0] ~= f77_local5 then
				Lobby.Platform.PlatformSessionXboxSetJoinRestriction(f77_arg0, f77_arg2, f77_local6, f77_local5)
				return
			end
			return
		end
		return
	end
	Lobby.Platform.PlatformSessionXboxCreate(f77_arg0, f77_arg2)
end
Lobby.Platform.PlatformSessionXboxPump = function()
	if Lobby.Platform.XBOX.taskInProgress == true or true == Engine[0x72C6381CF1C22CA]() or Lobby.ProcessQueue.IsQueueEmpty() == false or true == Engine[0xD4C591D307905C3]() then
		Lobby.Platform.XBOX.updateTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x1370ED9F96CEC10]:get()
		return
	elseif Lobby.Platform.XBOX.updateTime > Engine[0x9D33D652B9B0F3B]() then
		return
	end
	Lobby.Platform.XBOX.updateTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x1370ED9F96CEC10]:get()
	local f78_local0 = Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960]
	for f78_local1 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
		local f78_local4 = f78_local1 - 1
		local f78_local5 = Engine[0xBE1ABEFA9A14C34](f78_local4)
		local f78_local6 = Engine[0xF285055A1A895A1](f78_local4)
		if f78_local5 == true then
			for f78_local7 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0xBF54BE1BB3D618B][0xA1647599284110], -1 do
				local f78_local10 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f78_local7)
				local f78_local11 = Engine[0xEA2BE00F49480D](f78_local7)
				local f78_local12
				if f78_local11 then
					f78_local12 = Engine[0x3797858022DCB59](f78_local7)
					if not f78_local12 then
					else
						Lobby.Platform.PlatformSessionXboxPumpController(f78_local4, f78_local6, f78_local7, f78_local0, f78_local10, f78_local11, f78_local12)
						if Lobby.Platform.XBOX.taskInProgress == true then
							return
						end
					end
				end
				f78_local12 = LuaDefine.INVALID_CONTROLLER_PORT
			end
		elseif Lobby.Platform.XBOX.lastSignedInState[f78_local1] == true then
			f0_local13(f78_local4, true)
		end
		Lobby.Platform.XBOX.lastSignedInState[f78_local1] = f78_local5
	end
end
local f0_local14 = function(f79_arg0)
	if Dvar[0x41326C48D61869]:get() <= Lobby.Platform.S2S.operationRetriesAtHead then
		return false
	else
		local f79_local0
		if f79_arg0 < 500 or f79_arg0 >= 600 then
			f79_local0 = false
		else
			f79_local0 = true
		end
	end
	return f79_local0
end
local f0_local15 = function(f80_arg0)
	local f80_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionDurangoS2SCreateJoinComplete, {})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerCreateJoinMPSDTask started.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SCreateJoinFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerCreateJoinMPSDTask FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f80_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0x8607CD911589254](f80_local0, f80_arg0.sessionid, Lobby.Platform.S2S.templateName, f80_arg0.xuid, f80_arg0.isRetry) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerCreateJoinMPSDTask FAILED, may have backed up MPSD tasks\n")
		return false
	else
		return true
	end
end
local f0_local16 = function(f81_arg0)
	local f81_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionDurangoS2SEncounterComplete, {})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerEncounterTask started.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SEncounterFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerEncounterTask FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f81_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0xB12D2434F4CA2C5](f81_local0, f81_arg0.sessionid, Lobby.Platform.S2S.templateName, f81_arg0.xuid, f81_arg0.encounterId, f81_arg0.isRetry) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerEncounterTask failed, should not happen. The MPSD task buffer may be overloaded\n")
		return false
	else
		return true
	end
end
local f0_local17 = function(f82_arg0)
	local f82_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionDurangoS2SLeaveComplete, {})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerLeaveMPSDTask started.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SLeaveFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerLeaveMPSDTask FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f82_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0x48055780DCACAFD](f82_local0, f82_arg0.sessionid, Lobby.Platform.S2S.templateName, f82_arg0.xuid, f82_arg0.isRetry) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "TriggerLeaveMPSDTask FAILED, may have backed up MPSD tasks\n")
		return false
	else
		return true
	end
end
Lobby.Platform.PlatformSessionDurangoS2SGenerateSessionId = function(f83_arg0)
	local f83_local0 = Engine[0xA33D06620AC0D6B](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f83_arg0)
	if f83_local0 == nil then
		return false, ""
	else
		return true, Engine[0x3D5B539E107F8FD](f83_local0.secId)
	end
end
Lobby.Platform.PlatformSessionDurangoS2SEncounter = function(f84_arg0)
	if not Lobby.Platform.PlatformSessionDurangoS2SEnabled() then
		return
	else
		local f84_local0, f84_local1 = Lobby.Platform.PlatformSessionDurangoS2SGenerateSessionId(Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		if f84_local0 == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SEncounter SESSIONID was not ready, should not happen.\n")
			return
		else
			f0_local16({
				sessionid = f84_local1,
				xuid = f84_arg0.playerXuid,
				encounterId = f84_arg0.encounterID,
				isRetry = false,
			})
		end
	end
end
Lobby.Platform.PlatformSessionDurangoS2SCreateJoin = function(f85_arg0)
	local f85_local0, f85_local1 = Lobby.Platform.PlatformSessionDurangoS2SGenerateSessionId(Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	if f85_local0 == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SCreateJoin SESSIONID was not ready, should not happen.\n")
		return
	else
		f0_local15({
			xuid = f85_arg0,
			sessionid = f85_local1,
			isRetry = false,
		})
	end
end
Lobby.Platform.PlatformSessionDurangoS2SLeave = function(f86_arg0)
	local f86_local0, f86_local1 = Lobby.Platform.PlatformSessionDurangoS2SGenerateSessionId(Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	if f86_local0 == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SLeave SESSIONID was not ready, should not happen.\n")
		return
	else
		f0_local17({
			xuid = f86_arg0,
			sessionid = f86_local1,
			isRetry = false,
		})
	end
end
Lobby.Platform.PlatformSessionDurangoS2SCreateJoinComplete = function(f87_arg0, f87_arg1, f87_arg2)
	local f87_local0 = f87_arg2.isError
	local f87_local1 = f87_arg2.returnCode
	local f87_local2 = f87_arg2.returnCodeHex
	local f87_local3
	if Engine[0x573048F8D3B4E25]() ~= false or Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SCreateJoinForceRetry") ~= 1 then
		f87_local3 = false
	else
		f87_local3 = true
	end
	if f87_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SCreateJoinComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f87_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f87_local0 == false then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SCreateJoinComplete, client join succeeded\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SCreateJoinComplete failed: " .. f87_local2 .. "\n")
		end
	elseif f87_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f87_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SCreateJoinComplete failed: " .. f87_local2 .. "\n")
		f87_local0 = true
	end
	if f87_local0 == true or f87_local3 == true then
		local f87_local4
		if f0_local14(f87_local1) ~= true and f87_local3 ~= true then
			f87_local4 = false
		else
			f87_local4 = true
		end
		if f87_local4 then
			Lobby.Platform.S2S.operationRetriesAtHead = Lobby.Platform.S2S.operationRetriesAtHead + 1
			f0_local15({
				xuid = f87_arg2.xuid,
				sessionid = f87_arg2.sessionName,
				isRetry = true,
			})
		else
			if f87_local1 == 401 then
				Lobby.Platform.S2S.forceXstsTokenRefresh = true
			end
			Lobby.Platform.S2S.operationRetriesAtHead = 0
		end
	else
		Lobby.Platform.S2S.operationRetriesAtHead = 0
	end
end
Lobby.Platform.PlatformSessionDurangoS2SEncounterComplete = function(f88_arg0, f88_arg1, f88_arg2)
	local f88_local0 = f88_arg2.isError
	local f88_local1 = f88_arg2.returnCode
	local f88_local2 = f88_arg2.returnCodeHex
	local f88_local3
	if Engine[0x573048F8D3B4E25]() ~= false or Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SEncounterForceRetry") ~= 1 then
		f88_local3 = false
	else
		f88_local3 = true
	end
	if f88_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SEncounterComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f88_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f88_local0 == false then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SEncounterComplete, client encounter recorded\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SEncounterComplete failed: " .. f88_local2 .. "\n")
		end
	elseif f88_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f88_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SEncounterComplete failed: " .. f88_local2 .. "\n")
		f88_local0 = true
	end
	if f88_local0 == true or f88_local3 == true then
		local f88_local4
		if f0_local14(f88_local1) ~= true and f88_local3 ~= true then
			f88_local4 = false
		else
			f88_local4 = true
		end
		if f88_local4 then
			Lobby.Platform.S2S.operationRetriesAtHead = Lobby.Platform.S2S.operationRetriesAtHead + 1
			f0_local16({
				sessionid = f88_arg2.sessionName,
				xuid = f88_arg2.xuid,
				encounterId = f88_arg2.payload,
				isRetry = true,
			})
		else
			if f88_local1 == 401 then
				Lobby.Platform.S2S.forceXstsTokenRefresh = true
			end
			Lobby.Platform.S2S.operationRetriesAtHead = 0
		end
	else
		Lobby.Platform.S2S.operationRetriesAtHead = 0
	end
end
Lobby.Platform.PlatformSessionDurangoS2SLeaveComplete = function(f89_arg0, f89_arg1, f89_arg2)
	local f89_local0 = f89_arg2.isError
	local f89_local1 = f89_arg2.returnCode
	local f89_local2 = f89_arg2.returnCodeHex
	local f89_local3
	if Engine[0x573048F8D3B4E25]() ~= false or Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SLeaveForceRetry") ~= 1 then
		f89_local3 = false
	else
		f89_local3 = true
	end
	if f89_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SLeaveComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f89_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f89_local0 == false then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SLeaveComplete, client left the session\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SLeaveComplete failed: " .. f89_local2 .. "\n")
		end
	elseif f89_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f89_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SLeaveComplete failed: " .. f89_local2 .. "\n")
		f89_local0 = true
	end
	if f89_local0 == true or f89_local3 == true then
		local f89_local4
		if f0_local14(f89_local1) ~= true and f89_local3 ~= true then
			f89_local4 = false
		else
			f89_local4 = true
		end
		if f89_local4 then
			Lobby.Platform.S2S.operationRetriesAtHead = Lobby.Platform.S2S.operationRetriesAtHead + 1
			f0_local17({
				xuid = f89_arg2.xuid,
				sessionid = f89_arg2.sessionName,
				isRetry = false,
			})
		else
			if f89_local1 == 401 then
				Lobby.Platform.S2S.forceXstsTokenRefresh = true
			end
			Lobby.Platform.S2S.operationRetriesAtHead = 0
		end
	else
		Lobby.Platform.S2S.operationRetriesAtHead = 0
	end
end
local f0_local18 = function()
	if #Lobby.Platform.S2S.operationsQueue <= 0 then
		return
	end
	data = Lobby.Platform.S2S.operationsQueue[1]
	local f90_local0 = true
	if Lobby.Platform.S2S.QueueType.CreateJoin == data.type then
		f90_local0 = f0_local15(data)
	elseif Lobby.Platform.S2S.QueueType.Leave == data.type then
		f90_local0 = f0_local17(data)
	elseif Lobby.Platform.S2S.QueueType.Encounter == data.type then
		f90_local0 = f0_local16(data)
	end
	if f90_local0 == true then
		table.remove(Lobby.Platform.S2S.operationsQueue, 1)
	end
end
Lobby.Platform.PlatformSessionDurangoS2SGetServiceTokenComplete = function(f91_arg0, f91_arg1, f91_arg2)
	Lobby.Platform.S2S.authTaskInProgress = false
	local f91_local0 = f91_arg2.isError
	local f91_local1 = f91_arg2.returnCode
	local f91_local2 = f91_arg2.returnCodeHex
	if f91_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceTokenComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f91_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f91_local0 == false then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceTokenComplete, Service token acquired\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceTokenComplete failed: " .. f91_local2 .. "\n")
		end
	elseif f91_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f91_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceTokenComplete failed: " .. f91_local2 .. "\n")
		f91_local0 = true
	end
	if f91_local0 == true then
		Lobby.Platform.S2S.nextAuthTokenAttemptTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0xC05F83D5B9BD2C8]:get() ^ Lobby.Platform.S2S.authTokenAttempts * 1000
		Lobby.Platform.S2S.authTokenAttempts = math.min(Lobby.Platform.S2S.authTokenAttempts + 1, 5)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceTokenComplete, backing off attempt " .. Lobby.Platform.S2S.authTokenAttempts .. "\n")
	else
		Lobby.Platform.S2S.authTokenAttempts = 0
	end
end
Lobby.Platform.PlatformSessionDurangoS2SGetXstsTokenComplete = function(f92_arg0, f92_arg1, f92_arg2)
	Lobby.Platform.S2S.authTaskInProgress = false
	local f92_local0 = f92_arg2.isError
	local f92_local1 = f92_arg2.returnCode
	local f92_local2 = f92_arg2.returnCodeHex
	if f92_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetXstsTokenComplete ACTIONSTATE.RUNNING should not happen.\n")
		return false
	elseif f92_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f92_local0 == false then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetXstsTokenComplete, Xsts token acquired\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetXstsTokenComplete failed: " .. f92_local2 .. "\n")
		end
	elseif f92_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f92_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetXstsTokenComplete failed: " .. f92_local2 .. "\n")
		f92_local0 = true
	end
	if f92_local0 == true then
		if f92_local1 == 401 then
			Lobby.Platform.S2S.forceServiceTokenRefresh = true
			Lobby.Platform.S2S.forceXstsTokenRefresh = true
		end
		Lobby.Platform.S2S.nextAuthTokenAttemptTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0xC05F83D5B9BD2C8]:get() ^ Lobby.Platform.S2S.authTokenAttempts * 1000
		Lobby.Platform.S2S.authTokenAttempts = math.min(Lobby.Platform.S2S.authTokenAttempts + 1, 5)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceTokenComplete, backing off attempt " .. Lobby.Platform.S2S.authTokenAttempts .. "\n")
	else
		Lobby.Platform.S2S.authTokenAttempts = 0
	end
end
Lobby.Platform.PlatformSessionDurangoS2SGetServiceToken = function()
	Lobby.Platform.S2S.authTaskInProgress = true
	local f93_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionDurangoS2SGetServiceTokenComplete, {})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceToken started.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SGetServiceTokenFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "platformSessionDurangoS2SGetServiceTokenFailure FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f93_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0x95764175B7C2688](f93_local0) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetServiceToken failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f93_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
		Lobby.Platform.S2S.forceServiceTokenRefresh = false
	end
end
Lobby.Platform.PlatformSessionDurangoS2SGetXstsToken = function()
	Lobby.Platform.S2S.authTaskInProgress = true
	local f94_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.PlatformSessionDurangoS2SGetXstsTokenComplete, {})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetXstsToken started.\n")
	if Engine[0x573048F8D3B4E25]() == false and Engine[0x22EAAB59AA27E9B]("platformSessionDurangoS2SGetXstsTokenFailure") == 1 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetXstsToken FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f94_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[0x88B9D1876723759](f94_local0) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "PlatformSessionDurangoS2SGetXstsToken failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f94_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
		Lobby.Platform.S2S.forceXstsTokenRefresh = false
	end
end
Lobby.Platform.PlatformSessionDurangoS2SPumpAuth = function()
	local f95_local0 = false
	if Lobby.Platform.S2S.authTaskInProgress == true or true == Engine[0x94595E838B11C29]() then
		return f95_local0
	elseif Lobby.Platform.S2S.nextAuthTokenAttemptTime < Engine[0x9D33D652B9B0F3B]() then
		local f95_local1 = Dvar[0x78B302B741D5883]:get()
		local f95_local2 = Engine[0xCDDDCB47F4721AB]()
		if Lobby.Platform.S2S.forceServiceTokenRefresh == true or Engine[0x87D406961CF0E05]() + f95_local1 < f95_local2 then
			Lobby.Platform.PlatformSessionDurangoS2SGetServiceToken()
		elseif Lobby.Platform.S2S.forceXstsTokenRefresh == true or Engine[0x26E2CB008DB050C]() + f95_local1 < f95_local2 then
			Lobby.Platform.PlatformSessionDurangoS2SGetXstsToken()
		else
			f95_local0 = true
		end
	end
	return f95_local0
end
Lobby.Platform.PlatformSessionDurangoS2SPumpMPSD = function()
	if Dvar[0x8827F6EDED32B08]:get() == false then
		return
	else
		Engine[0x9C68FE40887954D]()
	end
end
Lobby.Platform.PlatformSessionDurangoS2SPump = function()
	if Lobby.Platform.S2S.updateTime > Engine[0x9D33D652B9B0F3B]() then
		return
	end
	Lobby.Platform.S2S.updateTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x90F8ADE0618A3B7]:get()
	if Lobby.Platform.PlatformSessionDurangoS2SPumpAuth() then
		Lobby.Platform.PlatformSessionDurangoS2SPumpMPSD()
	end
end
Lobby.Platform.PlatformSessionDurangoS2SBusy = function()
	local f98_local0 = Dvar[0x4DEE876C2922D06]:get()
	if f98_local0 then
		f98_local0 = Lobby.Platform.PlatformSessionDurangoS2SEnabled()
	end
	return f98_local0 and Engine[0x7671281C0E53461]() == true
end
Lobby.Platform.ProcessMoreInvites = function(f99_arg0)
	if f99_arg0.inviteCount <= f99_arg0.currentInvite then
		return
	else
		f99_arg0.currentInvite = f99_arg0.currentInvite + 1
		Lobby.Platform.Invite(f99_arg0)
	end
end
Lobby.Platform.InviteFailed = function(f100_arg0)
	local f100_local0 = f100_arg0.controller
	local f100_local1 = f100_arg0["xuid" .. f100_arg0.currentInvite]
	local f100_local2 = f100_arg0["gamertag" .. f100_arg0.currentInvite]
	if f100_arg0.showToast and f100_arg0.isMultiple then
		Engine[0xE1789115A2356E7]("open_toaster_popup", {
			toastType = "multiple_invites",
			isError = false,
			controller = f100_local0,
			xuid = f100_local1,
			gamertag = f100_local2,
			immediate = true,
		})
	end
	Engine[0xE1789115A2356E7]("open_toaster_popup", {
		toastType = "invite",
		isError = true,
		controller = f100_local0,
		xuid = f100_local1,
		gamertag = f100_local2,
		immediate = true,
	})
	Lobby.Platform.ProcessMoreInvites(f100_arg0)
end
Lobby.Platform.InviteComplete = function(f101_arg0, f101_arg1, f101_arg2)
	local f101_local0 = f101_arg1.controller
	local f101_local1 = f101_arg1["xuid" .. f101_arg1.currentInvite]
	local f101_local2 = f101_arg1["gamertag" .. f101_arg1.currentInvite]
	if f101_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f101_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		if f101_arg1.currentInvite == f101_arg1.inviteCount then
			local f101_local3 = Engine[0xE1789115A2356E7]
			local f101_local4 = "open_toaster_popup"
			local f101_local5 = {}
			local f101_local6
			if f101_arg1.inviteCount > 1 then
				f101_local6 = "multiple_invites"
				if not f101_local6 then
				else
					f101_local5.toastType = f101_local6
					f101_local5.isError = false
					f101_local5.controller = f101_local0
					f101_local5.xuid = f101_local1
					f101_local5.gamertag = f101_local2
					f101_local5.immediate = true
					f101_local3(f101_local4, f101_local5)
				end
			end
			f101_local6 = "invite"
		else
			Lobby.Platform.ProcessMoreInvites(f101_arg1)
		end
	elseif f101_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f101_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		if true == Dvar[0x9D38D804EC061EB]:get() then
			f101_arg1.gamertag = f101_arg1.gamertag .. " - " .. returnCodeHex
		end
		Lobby.Platform.InviteFailed(f101_arg1)
	end
	return true
end
Lobby.Platform.Invite = function(f102_arg0)
	if Lobby.Platform.PlatformSessionOrbisEnabled() == false and Lobby.Platform.PlatformSessionDurangoEnabled() == false then
		return
	end
	local f102_local0 = f102_arg0.controller
	local f102_local1 = f102_arg0.inviteCount
	f102_arg0.currentInvite = f102_arg0.currentInvite or 1
	local f102_local2 = f102_arg0["xuid" .. f102_arg0.currentInvite]
	local f102_local3 = f102_arg0["gamertag" .. f102_arg0.currentInvite]
	local f102_local4 = Engine[0x54689B3A7B3899E](f102_local0)
	local f102_local5 = Engine[0x384B563F1330474](0xECDEEEFDD99A267, f102_local4)
	local f102_local6, f102_local7 = Engine[0x40EC85343E0181F]()
	if f102_local6 == Enum[0x48909109238341F][0xCBD4CF0639724C3] then
		f102_local5 = Engine[0x384B563F1330474](0xD0B67A7783104FE, f102_local4)
	end
	Dvar[0xBE8B8D068E0C551]:set(f102_local5)
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
		if Lobby.Platform.PS4GetSessionId(f102_local0) == "" then
			Lobby.Platform.InviteFailed(f102_arg0)
			return
		end
		local f102_local8 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.InviteComplete, f102_arg0)
		local f102_local9 = {}
		local f102_local10 = math.min(Engine[0x381F1BC277C0663](), f102_arg0.inviteCount - f102_arg0.currentInvite + 1)
		for f102_local11 = 1, f102_local10, 1 do
			f102_local9[f102_local11] = f102_arg0["xuid" .. f102_arg0.currentInvite - 1 + f102_local11]
		end
		f102_arg0.currentInvite = f102_arg0.currentInvite - 1 + f102_local10
		if Engine[0xF62802472E955C9](f102_local8, f102_local0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f102_local9, Lobby.Platform.PS4GetSessionId(f102_local0)) == false then
			Lobby.Platform.InviteFailed(f102_arg0)
			Lobby.ProcessQueue.UnRegisterEventHandler(f102_local8)
		end
	elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
		local f102_local8 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Platform.InviteComplete, f102_arg0)
		if Engine[0x6E46A8D70A1182](f102_local8, f102_local0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f102_local2, f102_local3) == false then
			Lobby.Platform.InviteFailed(f102_arg0)
			Lobby.ProcessQueue.UnRegisterEventHandler(f102_local8)
		end
	end
end
Lobby.Platform.SetModelValue = function(f103_arg0, f103_arg1)
	local f103_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f103_arg0, true)
	if f103_local0 == nil then
		return
	else
		Engine[0x83C9B5DE1D9371](f103_local0, f103_arg1)
	end
end
Lobby.Platform.GetModelValue = function(f104_arg0, f104_arg1)
	local f104_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), f104_arg0)
	if f104_local0 ~= nil then
		local f104_local1 = Engine[0x614D394F6F9A18D](f104_local0, value)
		if f104_local1 ~= nil then
			Engine[0x8C7A8C4C5FD9892](f104_local0)
			return f104_local1
		end
	end
	return f104_arg1
end
Lobby.Platform.SaveState = function()
	if Engine[0xE39F1F30B306065]() == true or true == LuaDefine.isPC then
		return
	elseif true == LuaDefine.isPS4 then
		Lobby.Platform.SetModelValue("platformSession.taskInProgress", Lobby.Platform.PS4.taskInProgress)
		for f105_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.SetModelValue("platformSession.sessionId." .. tostring(f105_local0), Lobby.Platform.PS4.sessionId[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.lobbyId." .. tostring(f105_local0), Lobby.Platform.PS4.lobbyId[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.changed." .. tostring(f105_local0), Lobby.Platform.PS4.changed[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.sessionFailure." .. tostring(f105_local0), Lobby.Platform.PS4.sessionFailure[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.sessionFailureTime." .. tostring(f105_local0), Lobby.Platform.PS4.sessionFailureTime[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.lastSignedInState." .. tostring(f105_local0), Lobby.Platform.PS4.lastSignedInState[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.lockFlag." .. tostring(f105_local0), Lobby.Platform.PS4.lockFlag[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.sessionTypeFlag." .. tostring(f105_local0), Lobby.Platform.PS4.sessionTypeFlag[f105_local0])
		end
	elseif true == LuaDefine.isXbox then
		Lobby.Platform.SetModelValue("platformSession.taskInProgress", Lobby.Platform.XBOX.taskInProgress)
		for f105_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.SetModelValue("platformSession.rtaSubscribe." .. tostring(f105_local0), Lobby.Platform.XBOX.rtaSubscribe[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.sessionChangeToken." .. tostring(f105_local0), Lobby.Platform.XBOX.sessionChangeToken[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.subscriptionLostToken." .. tostring(f105_local0), Lobby.Platform.XBOX.subscriptionLostToken[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.sessionFailure." .. tostring(f105_local0), Lobby.Platform.XBOX.sessionFailure[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.sessionFailureTime." .. tostring(f105_local0), Lobby.Platform.XBOX.sessionFailureTime[f105_local0])
			for f105_local3 = Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], 1 do
				local f105_local6 = f105_local3 + 1
				Lobby.Platform.SetModelValue("platformSession.templateName." .. tostring(f105_local0) .. "." .. tostring(f105_local6), Lobby.Platform.XBOX.templateName[f105_local0][f105_local6])
				Lobby.Platform.SetModelValue("platformSession.sessionId." .. tostring(f105_local0) .. "." .. tostring(f105_local6), Lobby.Platform.XBOX.sessionId[f105_local0][f105_local6])
				Lobby.Platform.SetModelValue("platformSession.changed." .. tostring(f105_local0) .. "." .. tostring(f105_local6), Lobby.Platform.XBOX.changed[f105_local0][f105_local6])
			end
			Lobby.Platform.SetModelValue("platformSession.lastSignedInState." .. tostring(f105_local0), Lobby.Platform.XBOX.lastSignedInState[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.roundStart." .. tostring(f105_local0), Lobby.Platform.XBOX.roundStart[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.roundStartSessionId." .. tostring(f105_local0), Lobby.Platform.XBOX.roundStartSessionId[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.roundEnd." .. tostring(f105_local0), Lobby.Platform.XBOX.roundEnd[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.playerSessionId." .. tostring(f105_local0), Lobby.Platform.XBOX.playerSessionId[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.roundStartTime." .. tostring(f105_local0), Lobby.Platform.XBOX.roundStartTime[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.roundStartCounter." .. tostring(f105_local0), Lobby.Platform.XBOX.roundStartCounter[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.roundEndCounter." .. tostring(f105_local0), Lobby.Platform.XBOX.roundEndCounter[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.sessionClosed." .. tostring(f105_local0), Lobby.Platform.XBOX.sessionClosed[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.joinRestriction." .. tostring(f105_local0), Lobby.Platform.XBOX.joinRestriction[f105_local0])
			Lobby.Platform.SetModelValue("platformSession.visibility." .. tostring(f105_local0), Lobby.Platform.XBOX.visibility[f105_local0])
		end
	end
end
Lobby.Platform.OnComError = function(f106_arg0)
	local f106_local0 = f106_arg0.errorCode
	if f106_arg0.isInCleanup then
		return
	elseif f106_local0 == Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92] then
		Lobby.Platform.SaveState()
	end
end
Lobby.Platform.OnPreExecFFOTD = function()
	Lobby.Platform.SaveState()
end
Lobby.Platform.OnPostExecFFOTD = function() end
Lobby.Platform.Pump = function()
	if Engine[0xE39F1F30B306065]() then
		if Lobby.Platform.PlatformSessionDurangoS2SEnabled() then
			Lobby.Platform.PlatformSessionDurangoS2SPump()
		end
		return
	end
	Lobby.Platform.TRCPump()
	if Lobby.Platform.PlatformSessionOrbisEnabled() then
		Lobby.Platform.PlatformSessionPS4Pump()
	elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
		Lobby.Platform.PlatformSessionXboxPump()
	end
	if not Engine[0xCB675CA7856DA25]() then
		local f109_local0 = nil
		if Engine[0x7D47312EBA41751]() and Engine[0xDF359EF90593DAC] then
			f109_local0 = Engine[0xDF359EF90593DAC]()
		else
			f109_local0 = 100
		end
		local f109_local1 = Engine[0x8DF2E5447F384B9]()
		f109_local1 = f109_local1.lobbyRoot:create("percentInstalled")
		f109_local1:set(f109_local0)
	end
	local f109_local0 = Engine[0x8DF2E5447F384B9]()
	f109_local0 = f109_local0.lobbyRoot:create("owns_MP")
	f109_local0:set(not Engine[0xCB675CA7856DA25]())
	f109_local0 = Engine[0x8DF2E5447F384B9]()
	f109_local0 = f109_local0.lobbyRoot:create("owns_ZM")
	local f109_local1 = f109_local0
	f109_local0 = f109_local0.set
	local f109_local2
	if not Engine[0xCB675CA7856DA25]() then
		f109_local2 = not Engine[0x5405A6484A88367]()
	else
		f109_local2 = false
	end
	f109_local0(f109_local1, f109_local2)
	Lobby.Platform.PS4PlayTogetherPump()
end
Lobby.Platform.Init = function()
	if Engine[0xE39F1F30B306065]() == true or true == LuaDefine.isPC then
		return
	elseif true == LuaDefine.isPS4 then
		Lobby.Platform.PS4.taskInProgress = Lobby.Platform.GetModelValue("platformSession.taskInProgress", false)
		for f110_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			Lobby.Platform.PS4.sessionFailure[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionFailure." .. tostring(f110_local0), false)
			Lobby.Platform.PS4.sessionFailureTime[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionFailureTime." .. tostring(f110_local0), 0)
			Lobby.Platform.PS4.sessionId[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionId." .. tostring(f110_local0), "")
			Lobby.Platform.PS4.lobbyId[f110_local0] = Lobby.Platform.GetModelValue("platformSession.lobbyId." .. tostring(f110_local0), 0)
			Lobby.Platform.PS4.changed[f110_local0] = Lobby.Platform.GetModelValue("platformSession.changed." .. tostring(f110_local0), false)
			Lobby.Platform.PS4.lastSignedInState[f110_local0] = Lobby.Platform.GetModelValue("platformSession.lastSignedInState." .. tostring(f110_local0), false)
			Lobby.Platform.PS4.lockFlag[f110_local0] = Lobby.Platform.GetModelValue("platformSession.lockFlag." .. tostring(f110_local0), Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9])
			Lobby.Platform.PS4.sessionTypeFlag[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionTypeFlag." .. tostring(f110_local0), Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9])
		end
	elseif true == LuaDefine.isXbox then
		Lobby.Platform.XBOX.taskInProgress = Lobby.Platform.GetModelValue("platformSession.taskInProgress", false)
		for f110_local0 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			local f110_local3 = f110_local0 - 1
			Lobby.Platform.XBOX.sessionFailure[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionFailure." .. tostring(f110_local0), false)
			Lobby.Platform.XBOX.sessionFailureTime[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionFailureTime." .. tostring(f110_local0), 0)
			Lobby.Platform.XBOX.rtaSubscribe[f110_local0] = Lobby.Platform.GetModelValue("platformSession.rtaSubscribe." .. tostring(f110_local0), false)
			Lobby.Platform.XBOX.sessionChangeToken[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionChangeToken." .. tostring(f110_local0), nil)
			Lobby.Platform.XBOX.subscriptionLostToken[f110_local0] = Lobby.Platform.GetModelValue("platformSession.subscriptionLostToken." .. tostring(f110_local0), nil)
			Lobby.Platform.XBOX.templateName[f110_local0] = {}
			Lobby.Platform.XBOX.sessionId[f110_local0] = {}
			Lobby.Platform.XBOX.changed[f110_local0] = {}
			Lobby.Platform.XBOX.lastSignedInState[f110_local0] = Lobby.Platform.GetModelValue("platformSession.lastSignedInState." .. tostring(f110_local0), false)
			Lobby.Platform.XBOX.roundStart[f110_local0] = Lobby.Platform.GetModelValue("platformSession.roundStart." .. tostring(f110_local0), false)
			Lobby.Platform.XBOX.roundStartSessionId[f110_local0] = Lobby.Platform.GetModelValue("platformSession.roundStartSessionId." .. tostring(f110_local0), "")
			Lobby.Platform.XBOX.roundEnd[f110_local0] = Lobby.Platform.GetModelValue("platformSession.roundEnd." .. tostring(f110_local0), false)
			Lobby.Platform.XBOX.playerSessionId[f110_local0] = Lobby.Platform.GetModelValue("platformSession.playerSessionId." .. tostring(f110_local0), nil)
			Lobby.Platform.XBOX.roundStartTime[f110_local0] = Lobby.Platform.GetModelValue("platformSession.roundStartTime." .. tostring(f110_local0), 0)
			Lobby.Platform.XBOX.roundStartCounter[f110_local0] = Lobby.Platform.GetModelValue("platformSession.roundStartCounter." .. tostring(f110_local0), 0)
			Lobby.Platform.XBOX.roundEndCounter[f110_local0] = Lobby.Platform.GetModelValue("platformSession.roundEndCounter." .. tostring(f110_local0), 0)
			Lobby.Platform.XBOX.sessionClosed[f110_local0] = Lobby.Platform.GetModelValue("platformSession.sessionClosed." .. tostring(f110_local0), Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9])
			Lobby.Platform.XBOX.joinRestriction[f110_local0] = Lobby.Platform.GetModelValue("platformSession.joinRestriction." .. tostring(f110_local0), Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9])
			Lobby.Platform.XBOX.visibility[f110_local0] = Lobby.Platform.GetModelValue("platformSession.visibility." .. tostring(f110_local0), Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9])
			f0_local3(f110_local3, Enum[0xBF54BE1BB3D618B][0xA1647599284110], Lobby.Platform.GetModelValue("platformSession.templateName." .. tostring(f110_local0) .. "." .. tostring(Enum[0xBF54BE1BB3D618B][0xA1647599284110] + 1), Lobby.Platform.PLATFORM_SESSION_XBOX_TEMPLATE.PRIVATE_LOBBY))
			f0_local3(f110_local3, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Lobby.Platform.GetModelValue("platformSession.templateName." .. tostring(f110_local0) .. "." .. tostring(Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] + 1), Lobby.Platform.PLATFORM_SESSION_XBOX_TEMPLATE.GAME_LOBBY))
			for f110_local4 = Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], 1 do
				local f110_local7 = f110_local4 + 1
				f0_local5(f110_local3, f110_local4, Lobby.Platform.GetModelValue("platformSession.sessionId." .. tostring(f110_local0) .. "." .. tostring(f110_local7), ""))
				f0_local7(f110_local3, f110_local4, Lobby.Platform.GetModelValue("platformSession.changed." .. tostring(f110_local0) .. "." .. tostring(f110_local7), false))
			end
		end
	end
end
Lobby.Platform.playTogether = {}
Lobby.Platform.PS4ProcessPlayTogetherEvent = function(f111_arg0)
	local f111_local0 = f111_arg0.controller
	local f111_local1 = f111_arg0.xuid
	local f111_local2 = f111_arg0.gamertag
	local f111_local3 = Engine[0x9882F293C327557]()
	local f111_local4 = ""
	local f111_local5 = nil
	Lobby.Platform.playTogether.monitor = false
	Lobby.Platform.playTogether.available = true
	Lobby.Platform.playTogether.data = f111_arg0
	if Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
		local f111_local6 = Lobby.Process.ReloadPrivateLobby(f111_local0, Enum[0xC84D3E505F1444][0xE99F41098B71960])
		local f111_local7 = Lobby.ProcessPlatform.PlayTogetherBeginPlay(f111_local0, f111_arg0.playTogetherAccountIdList)
		Lobby.Process.AddActions(f111_local6.tail, f111_local7.head)
		return f111_local6
	elseif f111_local3 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
		Lobby.Platform.playTogether.monitor = true
		Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.beginPlay"), Enum[0xC84D3E505F1444][0xE99F41098B71960])
		return nil
	elseif Engine[0x7B48C1ABFF0F764]() then
		return Lobby.ProcessPlatform.PlayTogetherBeginPlay(f111_local0, f111_arg0.playTogetherAccountIdList)
	else
		return Lobby.ProcessPlatform.PlayTogetherBeginPlay(f111_local0, f111_arg0.playTogetherAccountIdList)
	end
end
Lobby.Platform.PS4PlayTogetherPump = function()
	if Engine[0xE39F1F30B306065]() == true or true ~= LuaDefine.isPS4 then
		return
	elseif true ~= Lobby.Platform.playTogether.monitor then
		return
	end
	local f112_local0 = Lobby.Platform.playTogether.data.controller
	if Engine[0x9882F293C327557]() ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
		if true == Lobby.Platform.PS4.taskInProgress then
			return
		elseif string.len(Lobby.Platform.PS4GetSessionId(f112_local0)) > 0 then
			Lobby.Platform.playTogether.monitor = false
			Lobby.ProcessQueue.AddToQueue("PlayTogetherBeginPlay", Lobby.ProcessPlatform.SendPlayTogetherInvites(f112_local0, Lobby.Platform.playTogether.data.playTogetherAccountIdList))
			Engine[0x38C00A84ACFFD6B]()
		end
	end
	if Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](Lobby.Platform.playTogether.data.controller), "SystemOverlay_MessageDialog.buttonPrompts") ~= nil then
		Lobby.Platform.playTogether.monitor = false
	end
end
Lobby.Platform.Init()
