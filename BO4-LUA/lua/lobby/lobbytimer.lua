require("x64:53e8db3768fb02a")
require("x64:3050b56bc941c17")
require("x64:2f7767db3f402c")
require("x64:fce63782cae60aa")
require("x64:9adb55ef4325b4b")
require("x64:b370b3af9224bd0")
require("x64:b5d5f7ffe97a9a7")
Lobby.Timer = {}
Lobby.Timer.MATCH_START_INVALID = -1
Lobby.Timer.LOBBY_STATUS = {
	NOT_RUNNING = -1,
	IDLE = 0,
	WAIT_FOR_LOBBY_LOCK = 1,
	VOTING = 2,
	BEGIN = 3,
	RESET_TO_NEED = 4,
	NEED_PLAYERS = 5,
	NEED_BALANCE = 6,
	NEED_READYUP = 7,
	STARTING = 8,
	POST_GAME = 9,
	FIND_NEW_LOBBY = 10,
	FIND_DEDICATED_SERVER = 11,
	MATCH_END_DEDICATED = 12,
	INTERMISSION = 13,
	PRELOADING = 14,
}
Lobby.Timer.LOBBY_STATUS_STRING = {
	[Lobby.Timer.LOBBY_STATUS.NOT_RUNNING] = "NOT RUNNING",
	[Lobby.Timer.LOBBY_STATUS.IDLE] = "IDLE",
	[Lobby.Timer.LOBBY_STATUS.WAIT_FOR_LOBBY_LOCK] = "WAIT FOR LOBBY LOCK",
	[Lobby.Timer.LOBBY_STATUS.VOTING] = "VOTING",
	[Lobby.Timer.LOBBY_STATUS.BEGIN] = "BEGIN",
	[Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED] = "RESET TO NEED",
	[Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS] = "NEED PLAYERS",
	[Lobby.Timer.LOBBY_STATUS.NEED_BALANCE] = "NEED BALANCE",
	[Lobby.Timer.LOBBY_STATUS.NEED_READYUP] = "NEED READYUP",
	[Lobby.Timer.LOBBY_STATUS.STARTING] = "STARTING",
	[Lobby.Timer.LOBBY_STATUS.POST_GAME] = "POST GAME",
	[Lobby.Timer.LOBBY_STATUS.FIND_NEW_LOBBY] = "FIND NEW LOBBY",
	[Lobby.Timer.LOBBY_STATUS.FIND_DEDICATED_SERVER] = "FIND DEDICATED SERVER",
	[Lobby.Timer.LOBBY_STATUS.MATCH_END_DEDICATED] = "MATCH_END_DEDICATED",
	[Lobby.Timer.LOBBY_STATUS.INTERMISSION] = "INTERMISSION",
	[Lobby.Timer.LOBBY_STATUS.PRELOADING] = "PRELOADING",
}
Lobby.Timer.lastValue = 0
Lobby.Timer.lobbyTimer = nil
Lobby.Timer.LOBBY_DEDICATED_CMD = {
	INVALID_CMD = -1,
	START_COUNTDOWN = 0,
	REMOVE_ALL_CLIENTS = 1,
	CONTINUE = 2,
	INTERMISSION = 3,
	END = 4,
}
Lobby.Timer.LOBBY_CMD_STRING = {
	[Lobby.Timer.LOBBY_DEDICATED_CMD.INVALID_CMD] = "INVALID COMMAND",
	[Lobby.Timer.LOBBY_DEDICATED_CMD.START_COUNTDOWN] = "START COUNTDOWN",
	[Lobby.Timer.LOBBY_DEDICATED_CMD.REMOVE_ALL_CLIENTS] = "REMOVE ALL CLIENTS",
	[Lobby.Timer.LOBBY_DEDICATED_CMD.CONTINUE] = "CONTINUE",
	[Lobby.Timer.LOBBY_DEDICATED_CMD.INTERMISSION] = "INTERMISSION",
	[Lobby.Timer.LOBBY_DEDICATED_CMD.END] = "END",
}
Lobby.Timer.DedicatedSpecialCMD = Lobby.Timer.LOBBY_DEDICATED_CMD.INVALID_CMD
Lobby.Timer.ResetUIModel = function()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining"), 0)
end
Lobby.Timer.OnSessionStart = function(f2_arg0)
	local f2_local0 = f2_arg0.lobbyModule
	local f2_local1 = f2_arg0.lobbyType
	local f2_local2 = f2_arg0.lobbyMode
	if f2_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus"), "")
	end
end
Lobby.Timer.OnSessionEnd = function(f3_arg0)
	Lobby.Timer.ResetUIModel()
end
Lobby.Timer.OnMatchStart = function(f4_arg0)
	local f4_local0 = f4_arg0.lobbyModule
	local f4_local1 = f4_arg0.lobbyType
	local f4_local2 = f4_arg0.lobbyMode
	Lobby.Timer.Clear(true)
	Lobby.Pregame.OnMatchStart(f4_arg0)
end
Lobby.Timer.OnMatchEnd = function(f5_arg0)
	local f5_local0 = f5_arg0.lobbyModule
	local f5_local1 = f5_arg0.lobbyType
	local f5_local2 = f5_arg0.lobbyMode
	if f5_local0 ~= Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or f5_local1 ~= Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]) or not Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f5_local1) then
		return
	end
	local f5_local3 = Engine[0x3797858022DCB59](f5_local1)
	if f5_local3 == -1 then
		f5_local3 = 0
	end
	local f5_local4 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.MatchEnd: Game must have ended, start host timer.\n")
	local f5_local5 = {
		controller = f5_local3,
		lobbyType = f5_local1,
		mainMode = f5_local4[0xEB7DDC7F079D51B],
		lobbyTimerType = f5_local4[0x558B67A321D1120],
		matchEnded = true,
	}
	Lobby.Timer.HostingLobby(f5_local5)
	Lobby.Pregame.OnMatchEnd(f5_local5)
end
Lobby.Timer.OnClientRemoved = function(f6_arg0)
	if Lobby.Timer.lobbyTimer == nil then
		return
	elseif LuaUtils.IsArenaPublicGame() then
		local f6_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
		if Engine[0xEA2BE00F49480D](f6_local0) and Lobby.Timer.lobbyTimer.status <= Lobby.Timer.LOBBY_STATUS.STARTING then
			Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.IDLE
			Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
			Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f6_local0, Lobby.Timer.lobbyTimer.status, 0)
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
			Lobby.MatchmakingAsync.ToggleAsyncMatchmaking({
				advertise = true,
			})
		end
	end
end
Lobby.Timer.LockInLobby = function(f7_arg0)
	if LuaUtils.IsArenaMode() then
		if not Lobby.Timer.LobbyIsLocked() and Engine[0x9E5BE3B4BBA4E0E]("probation_league_enabled") then
			Engine[0xBFFA2858E10C77A](f7_arg0)
		end
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot"), "lobbyLockedIn"), true)
	end
end
Lobby.Timer.LobbyIsLocked = function()
	if LuaUtils.IsArenaMode() then
		return LuaUtils.LobbyIsLocked()
	else
		return false
	end
end
Lobby.Timer.UnlockLobby = function(f9_arg0, f9_arg1)
	if Lobby.Timer.LobbyIsLocked() and f9_arg1 == true and Engine[0x9E5BE3B4BBA4E0E]("probation_league_enabled") then
		Engine[0x95C0F5CE13D8F64](f9_arg0)
	end
	LuaUtils.UnlockLobby()
end
Lobby.Timer.UpdateAdvertising = function(f10_arg0)
	if Engine[0x9E5BE3B4BBA4E0E]("lobbyAdvertiseShowInMatchmaking") == f10_arg0 then
		return
	elseif f10_arg0 then
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[0x805C82C8BA1B3C9][0xC7A6E94E122CDB2], true)
	else
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[0x805C82C8BA1B3C9][0xA0CDA037E1925A5], true)
	end
end
Lobby.Timer.Clear = function(f11_arg0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus"), "")
	local f11_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	if Lobby.Timer.lobbyTimer and (Lobby.Timer.lobbyTimer.lobbyTimerType == LuaEnum.TIMER_TYPE.AUTO_ZM or Lobby.Timer.lobbyTimer.lobbyTimerType == LuaEnum.TIMER_TYPE.AUTO_CP) then
		Engine[0x56AF7C608992594](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f11_local0)
	end
	Lobby.Timer.ResetUIModel()
	if f11_arg0 == true and f11_local0 ~= nil then
		Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f11_local0, Lobby.Timer.LOBBY_STATUS.IDLE, 0)
	end
	Lobby.Timer.lastValue = 0
	Lobby.Timer.lobbyTimer = nil
end
Lobby.Timer.GetTimerType = function()
	if Lobby.Timer.lobbyTimer == nil then
		return LuaEnum.TIMER_TYPE.INVALID
	else
		return Lobby.Timer.lobbyTimer.lobbyTimerType
	end
end
Lobby.Timer.GetTimerStatus = function()
	if Lobby.Timer.lobbyTimer == nil then
		return Lobby.Timer.LOBBY_STATUS.NOT_RUNNING
	else
		return Lobby.Timer.lobbyTimer.status
	end
end
Lobby.Timer.HostPlaySoundAndUpdateTime = function(f14_arg0, f14_arg1)
	if f14_arg0 ~= Lobby.Timer.lastValue then
		Lobby.Timer.lastValue = f14_arg0
		if f14_arg0 <= 5 then
			Engine[0xC4146BA76D0F982](LobbyData.Sounds.TimerTick)
		end
		if f14_arg1 then
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote.timerActive"), 1)
		end
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Time Left: " .. f14_arg0 .. "\n")
	end
end
Lobby.Timer.ClientPlaySoundAndUpdateTime = function(f15_arg0)
	if f15_arg0 ~= Lobby.Timer.lastValue then
		Lobby.Timer.lastValue = f15_arg0
		if f15_arg0 <= 5 then
			Engine[0xC4146BA76D0F982](LobbyData.Sounds.TimerTick)
		end
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xD48A9770CD84BB6], "Client Time Left: " .. f15_arg0 .. "\n")
	end
end
Lobby.Timer.AutoCPPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f16_local0 = Lobby.Timer.lobbyTimer.controller
	local f16_local1 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	local f16_local2 = Lobby.Timer.lobbyTimer.status
	local f16_local3 = Lobby.Timer.lobbyTimer.endTime
	local f16_local4 = 0
	local f16_local5 = 0
	local f16_local6 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f16_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f16_local7 = f16_local6 == 0
	Lobby.MapVote.ShowLockedIn()
	local f16_local8 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote.timerActive")
	local f16_local9 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f16_local10 = 0
	local f16_local11 = Dvar[0x500E4DB2F10F5EE]:get()
	local f16_local12 = 0
	local f16_local13 = f16_local6
	local f16_local14 = Engine[0xA537E2C09DAA5CD](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f16_local1)
	for f16_local18, f16_local19 in pairs(f16_local14.clients) do
		if f16_local19.readyUp == true then
			f16_local12 = f16_local12 + 1
		end
	end
	if f16_local13 < f16_local11 then
		f16_local13 = f16_local11
	end
	f16_local15 = math.floor(math.ceil(Dvar[0x8A2424003E8E98A]:get() * f16_local13) - f16_local12)
	f16_local16 = Engine[0x69811927938FCD7]() == "doa"
	if f16_local7 then
		f16_local2 = Lobby.Timer.LOBBY_STATUS.IDLE
		f16_local3 = Lobby.Timer.MATCH_START_INVALID
	elseif f16_local3 == Lobby.Timer.MATCH_START_INVALID then
		f16_local3 = Engine[0x9D33D652B9B0F3B]() + Dvar[0x4832F85F8B2FA6A]:get()
	elseif f16_local2 == Lobby.Timer.LOBBY_STATUS.NEED_READYUP then
		if 0 < Dvar[0x8A2424003E8E98A]:get() then
			if f16_local15 > 0 then
				f16_local17 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
				if f16_local15 == 1 then
					Engine[0x83C9B5DE1D9371](f16_local17, Engine[0xF9F1239CFD921FE](0x231FC751DC50156))
				else
					Engine[0x83C9B5DE1D9371](f16_local17, Engine[0xF9F1239CFD921FE](0x96C7DC086052CF, f16_local15))
				end
				f16_local4 = f16_local15
			else
				f16_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
				f16_local3 = Engine[0x9D33D652B9B0F3B]() + Dvar[0x4832F85F8B2FA6A]:get()
			end
		else
			f16_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
		end
	elseif f16_local3 ~= Lobby.Timer.MATCH_START_INVALID then
		f16_local17 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
		f16_local5 = math.floor((f16_local3 - Engine[0x9D33D652B9B0F3B]()) / 1000)
		f16_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
		if f16_local5 > 0 then
			Engine[0x83C9B5DE1D9371](f16_local17, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f16_local5))
			f16_local10 = f16_local5
		else
			Engine[0x83C9B5DE1D9371](f16_local17, "")
		end
		if f16_local16 == true and 0 < Dvar[0x8A2424003E8E98A]:get() and f16_local15 > 0 then
			f16_local2 = Lobby.Timer.LOBBY_STATUS.NEED_READYUP
			f16_local4 = Lobby.Timer.MATCH_START_INVALID
		end
		Lobby.Timer.HostPlaySoundAndUpdateTime(f16_local5, true)
		if Lobby.ProcessQueue.IsQueueEmpty() and Engine[0x5B4EB7919738C02](f16_local1) == false and f16_local5 <= 0 and LobbyVM.LaunchGameExec(f16_local0, f16_local1) == true then
			Engine[0x83C9B5DE1D9371](f16_local17, "")
			f16_local3 = Lobby.Timer.MATCH_START_INVALID
			Lobby.Timer.Clear(true)
			return
		end
		f16_local4 = math.max(f16_local5, 0)
	else
		Lobby.Timer.lastValue = 0
		Engine[0x83C9B5DE1D9371](f16_local8, 0)
	end
	Engine[0x83C9B5DE1D9371](f16_local9, f16_local10)
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f16_local1, f16_local2, f16_local4)
	Lobby.Timer.lobbyTimer.status = f16_local2
	Lobby.Timer.lobbyTimer.endTime = f16_local3
end
Lobby.Timer.AutoCPPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return true
	else
		Lobby.MapVote.Hide()
		Lobby.Timer.Clear(false)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoCPPumpEnd: Kill lobby timer.\n")
		return true
	end
end
Lobby.Timer.AutoCPPumpClient = function(f18_arg0)
	local f18_local0 = f18_arg0.controller
	local f18_local1 = f18_arg0.lobbyType
	local f18_local2 = f18_arg0.status
	local f18_local3 = f18_arg0.statusValue
	local f18_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f18_local5 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f18_local6 = 0
	if f18_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	Lobby.MapVote.ShowLockedIn()
	if f18_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Engine[0x83C9B5DE1D9371](f18_local4, "")
	elseif f18_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		if f18_local3 > 0 then
			Engine[0x83C9B5DE1D9371](f18_local4, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f18_local3))
			f18_local6 = f18_local3
		else
			Engine[0x83C9B5DE1D9371](f18_local4, "")
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f18_local3)
	elseif f18_local2 == Lobby.Timer.LOBBY_STATUS.NEED_READYUP then
		local f18_local7 = f18_local3
		if f18_local7 == 1 then
			Engine[0x83C9B5DE1D9371](f18_local4, Engine[0xF9F1239CFD921FE](0x231FC751DC50156))
		else
			Engine[0x83C9B5DE1D9371](f18_local4, Engine[0xF9F1239CFD921FE](0x96C7DC086052CF, f18_local7))
		end
	end
	Engine[0x83C9B5DE1D9371](f18_local5, f18_local6)
end
Lobby.Timer.AutoMPPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f19_local0 = Lobby.Timer.lobbyTimer.controller
	local f19_local1 = Lobby.Timer.lobbyTimer.lobbyType
	local f19_local2 = Lobby.Timer.lobbyTimer.mainMode
	local f19_local3 = Lobby.Timer.lobbyTimer.lobbyTimerType
	local f19_local4 = Lobby.Timer.lobbyTimer.status
	local f19_local5 = 0
	local f19_local6 = Lobby.Timer.lobbyTimer.endTime
	local f19_local7 = 0
	local f19_local8 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f19_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f19_local9 = math.max(0, Dvar[0x500E4DB2F10F5EE]:get() - f19_local8)
	local f19_local10 = f19_local8 == 0
	if f19_local10 and Lobby.MMAsync.lobbyCreateTime > Engine[0x9D33D652B9B0F3B]() then
		f19_local10 = false
	end
	local f19_local11 = Engine[0xA537E2C09DAA5CD](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f19_local1)
	local f19_local12 = f19_local11.preloadPercentage / 100
	local f19_local13 = {
		preloadPercentage = f19_local12,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
	}
	local f19_local14 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f19_local15 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f19_local16 = 0
	local f19_local17 = 0
	LobbyVM.CheckSpecialPlaylistRules(f19_local0)
	if f19_local6 ~= Lobby.Timer.MATCH_START_INVALID then
		f19_local7 = math.floor(math.max(0, f19_local6 - Engine[0x9D33D652B9B0F3B]()) / 1000)
	end
	if f19_local4 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	f19_local5 = f19_local7
	if f19_local10 or f19_local4 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Lobby.MapVote.Hide()
		f19_local4 = Lobby.Timer.LOBBY_STATUS.VOTING
		f19_local6 = Lobby.Timer.MATCH_START_INVALID
		f19_local14:set("")
	elseif f19_local4 == Lobby.Timer.LOBBY_STATUS.VOTING then
		Lobby.MapVote.ShowVote()
		if f19_local6 == Lobby.Timer.MATCH_START_INVALID then
			f19_local6 = Engine[0x9D33D652B9B0F3B]() + Dvar[0xA0A01C39967B404]:get()
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
		else
			Engine[0x83C9B5DE1D9371](f19_local14, Engine[0xF9F1239CFD921FE](0x8E27051A1C44827) .. ": " .. f19_local7)
			Lobby.Matchmaking.UpdatePublicLobby({
				stage = LuaEnum.PUBLIC_LOBBY.INTERMISSION,
				intermissionTime = f19_local7,
			})
			if math.max(0, f19_local6 - Engine[0x9D33D652B9B0F3B]()) == 0 then
				f19_local6 = Lobby.Timer.MATCH_START_INVALID
				f19_local4 = Lobby.Timer.LOBBY_STATUS.POST_GAME
				Lobby.MapVote.LockedInVote()
				Lobby.MapVote.UpdateMapVoteInfo()
			end
		end
	elseif f19_local4 == Lobby.Timer.LOBBY_STATUS.WAIT_FOR_LOBBY_LOCK then
		if f19_local7 <= 0 then
			f19_local4 = Lobby.Timer.LOBBY_STATUS.IDLE
			f19_local6 = Lobby.Timer.MATCH_START_INVALID
			if Engine[0xE39F1F30B306065]() == true then
				Engine[0xE7E0FF664B7D7BF](Engine[0xEC040B95C0BF471](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]))
			end
			Engine[0xCB6D7D39AF67BC1](Engine[0xA5B9C0111291A8B](), Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		end
	elseif f19_local4 == Lobby.Timer.LOBBY_STATUS.POST_GAME then
		Lobby.MapVote.ShowLockedIn()
		if f19_local6 == Lobby.Timer.MATCH_START_INVALID then
			f19_local6 = Engine[0x9D33D652B9B0F3B]() + Dvar[0xF28A3041BBCDF83]:get()
		else
			f19_local14:set(Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f19_local7))
			if f19_local7 <= Dvar[0xAEDDAFEB3887F37]:get() / 1000 then
				f19_local6 = Lobby.Timer.MATCH_START_INVALID
				f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
				Lobby.MapVote.LockedInVote()
			end
		end
	elseif f19_local4 == Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED then
		f19_local6 = Lobby.Timer.MATCH_START_INVALID
		f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
		f19_local14:set("")
	elseif f19_local4 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
		Lobby.MapVote.ShowLockedIn()
		if f19_local9 > 0 then
			if f19_local9 == 1 then
				f19_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f19_local13.stageTitle = 0xC4D2D56E3932FAB
				f19_local13.stageDetails = Engine[0xF9F1239CFD921FE](0x5A08D09755BAA8E)
				f19_local13.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f19_local13)
				f19_local16 = f19_local7
			else
				f19_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f19_local13.stageTitle = 0xC4D2D56E3932FAB
				f19_local13.stageDetails = Engine[0xF9F1239CFD921FE](0x46A0BCA90BC2137, f19_local9)
				f19_local13.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f19_local13)
			end
			f19_local6 = Lobby.Timer.MATCH_START_INVALID
			f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			f19_local5 = f19_local9
			Lobby.MatchmakingAsync.StartBlockedWaitingForPlayers()
		else
			f19_local6 = Lobby.Timer.MATCH_START_INVALID
			f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_BALANCE
			Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
			Lobby.MatchmakingAsync.StopBlockedWaitingForPlayers()
		end
		f19_local14:set("")
	elseif f19_local4 == Lobby.Timer.LOBBY_STATUS.NEED_BALANCE then
		Lobby.MapVote.ShowLockedIn()
		if f19_local9 > 0 then
			f19_local6 = Lobby.Timer.MATCH_START_INVALID
			f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
		else
			local f19_local18 = false
			if Engine[0x9D33D652B9B0F3B]() - Lobby.Timer.lobbyTimer.balanceStartTime > 10000 then
				f19_local18 = true
				Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			end
			if Lobby.TeamSelection.AutoSplitTeam(true, f19_local18, true) then
				f19_local6 = Lobby.Timer.MATCH_START_INVALID
				f19_local4 = Lobby.Timer.LOBBY_STATUS.STARTING
				Lobby.MatchmakingAsync.LockTeams()
				f19_local13.preloadPercentage = 1
				Lobby.Matchmaking.UpdatePublicLobby(f19_local13)
				newStage = "starting stage"
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Team Ballanced going to " .. newStage .. "\n")
				if Dvar[0x7255714A6A48B0A]:get() == true and Dvar[0x4BADE8473F0165F]:get() == false then
					Engine[0xC6664E11A641F01](f19_local0)
				end
			else
				f19_local6 = Lobby.Timer.MATCH_START_INVALID
				f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_BALANCE
				f19_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f19_local13.stageTitle = 0xC4D2D56E3932FAB
				f19_local13.stageDetails = Engine[0xF9F1239CFD921FE](0xD562EA62A296CB6)
				Lobby.Matchmaking.UpdatePublicLobby(f19_local13)
			end
			f19_local14:set("")
		end
	elseif f19_local4 == Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.MapVote.ShowLockedIn()
		if f19_local9 > 0 then
			f19_local6 = Lobby.Timer.MATCH_START_INVALID
			f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
			Lobby.MatchmakingAsync.UnLockTeams()
		elseif Lobby.TeamSelection.AutoSplitTeam(true, true) == false then
			f19_local6 = Lobby.Timer.MATCH_START_INVALID
			f19_local4 = Lobby.Timer.LOBBY_STATUS.NEED_BALANCE
			Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			Lobby.MatchmakingAsync.UnLockTeams()
		else
			f19_local4 = Lobby.Timer.LOBBY_STATUS.STARTING
			if f19_local6 == Lobby.Timer.MATCH_START_INVALID then
				f19_local6 = Engine[0x9D33D652B9B0F3B]() + Dvar[0xAEDDAFEB3887F37]:get()
			else
				if f19_local7 > 0 then
					Lobby.Matchmaking.UpdatePublicLobby({
						preloadPercentage = f19_local12,
						stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
						startTime = f19_local7,
					})
					f19_local16 = f19_local7
					Engine[0x3B9F1AA6A523204](Engine[0x20826BD382E3A23](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f19_local1, Engine[0x93B19E01B1FD1C7](f19_local0)))
					f19_local14:set(Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f19_local7))
				else
					f19_local14:set("")
				end
				Lobby.Timer.HostPlaySoundAndUpdateTime(f19_local7)
				if Lobby.ProcessQueue.IsQueueEmpty() and Engine[0x5B4EB7919738C02](f19_local1) == false and f19_local7 <= 0 and LobbyVM.LaunchGameExec(f19_local0, f19_local1) == true then
					Lobby.Timer.lobbyTimer.endFunc()
					Lobby.Timer.Clear(true)
					Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
					return
				end
			end
		end
	end
	if Lobby.Timer.lobbyTimer.status ~= f19_local4 then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoMPPump status update: " .. Lobby.Timer.LOBBY_STATUS_STRING[f19_local4] .. ".\n")
	end
	Lobby.Timer.lobbyTimer.status = f19_local4
	Lobby.Timer.lobbyTimer.endTime = f19_local6
	Engine[0x83C9B5DE1D9371](f19_local15, f19_local16)
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f19_local1, Lobby.Timer.lobbyTimer.status, f19_local5)
end
Lobby.Timer.AutoMPPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return true
	else
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote", true), 0)
		Lobby.Timer.Clear(false)
		Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoMPPumpEnd: Kill lobby timer.\n")
		return true
	end
end
Lobby.Timer.AutoMPPumpClient = function(f21_arg0)
	local f21_local0 = f21_arg0.controller
	local f21_local1 = f21_arg0.lobbyType
	local f21_local2 = f21_arg0.status
	local f21_local3 = f21_arg0.statusValue
	local f21_local4 = f21_arg0.statusValue
	local f21_local5 = f21_arg0.preloadPercentage / 100
	if Engine[0xEA2BE00F49480D](f21_local1) then
		return
	end
	local f21_local6 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f21_local7 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f21_local8 = {
		preloadPercentage = f21_local5,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
		stageDetails = Engine[0xF9F1239CFD921FE](LuaEnum.SEARCH_DESCRIPTION_STRING[LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_4_DESCRIPTION_1]),
	}
	local f21_local9 = 0
	if f21_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	if f21_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Lobby.MapVote.Hide()
		Lobby.Matchmaking.UpdatePublicLobby({})
		Engine[0x83C9B5DE1D9371](f21_local6, "")
	elseif f21_local2 == Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED then
		Lobby.MapVote.ShowLockedIn()
		Lobby.Timer.UnlockLobby(f21_local0, true)
	elseif f21_local2 == Lobby.Timer.LOBBY_STATUS.VOTING then
		Lobby.MapVote.ShowVote()
		Engine[0x83C9B5DE1D9371](f21_local6, Engine[0xF9F1239CFD921FE](0x8E27051A1C44827) .. ": " .. f21_local3)
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.INTERMISSION,
			intermissionTime = f21_local3,
		})
	elseif f21_local2 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
		Lobby.MapVote.ShowLockedIn()
		f21_local8.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
		f21_local8.stageTitle = 0xC4D2D56E3932FAB
		local f21_local10
		if f21_local4 > 1 then
			f21_local10 = Engine[0xF9F1239CFD921FE](0x46A0BCA90BC2137, f21_local4)
			if not f21_local10 then
			else
				f21_local8.stageDetails = f21_local10
				f21_local8.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f21_local8)
				Engine[0x83C9B5DE1D9371](f21_local6, "")
			end
		end
		f21_local10 = Engine[0xF9F1239CFD921FE](0x5A08D09755BAA8E)
	elseif f21_local2 == Lobby.Timer.LOBBY_STATUS.NEED_BALANCE then
		Lobby.MapVote.ShowLockedIn()
		f21_local8.stageDetails = Engine[0xF9F1239CFD921FE](0xD562EA62A296CB6)
		f21_local8.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
		f21_local8.stageTitle = 0xC4D2D56E3932FAB
		Lobby.Matchmaking.UpdatePublicLobby(f21_local8)
		Engine[0x83C9B5DE1D9371](f21_local6, "")
	elseif f21_local2 == Lobby.Timer.LOBBY_STATUS.POST_GAME then
		Lobby.MapVote.ShowLockedIn()
		Engine[0x83C9B5DE1D9371](f21_local6, Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f21_local3))
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
			startTime = f21_local3,
			stageDetails = Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f21_local3),
		})
		f21_local9 = f21_local3
	elseif f21_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.MapVote.ShowLockedIn()
		if f21_local3 > 0 then
			Engine[0x83C9B5DE1D9371](f21_local6, Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f21_local3))
			Lobby.Matchmaking.UpdatePublicLobby({
				stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
				startTime = f21_local3,
				stageDetails = Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f21_local3),
			})
			f21_local9 = f21_local3
			Engine[0x3B9F1AA6A523204](Engine[0x20826BD382E3A23](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f21_local1, Engine[0x93B19E01B1FD1C7](f21_local0)))
		else
			Engine[0x83C9B5DE1D9371](f21_local6, "")
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f21_local3)
	end
	Engine[0x83C9B5DE1D9371](f21_local7, f21_local9)
end
Lobby.Timer.AutoMPArenaPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f22_local0 = Lobby.Timer.lobbyTimer.controller
	local f22_local1 = Lobby.Timer.lobbyTimer.lobbyType
	local f22_local2 = Lobby.Timer.lobbyTimer.mainMode
	local f22_local3 = Lobby.Timer.lobbyTimer.lobbyTimerType
	local f22_local4 = Lobby.Timer.lobbyTimer.status
	local f22_local5 = 0
	local f22_local6 = Lobby.Timer.lobbyTimer.endTime
	local f22_local7 = 0
	local f22_local8 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f22_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f22_local9 = math.max(0, Dvar[0x500E4DB2F10F5EE]:get() - f22_local8)
	local f22_local10 = f22_local8 == 0
	if f22_local10 and Lobby.MMAsync.lobbyCreateTime > Engine[0x9D33D652B9B0F3B]() then
		f22_local10 = false
	end
	local f22_local11 = Engine[0xA537E2C09DAA5CD](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f22_local1)
	local f22_local12 = f22_local11.preloadPercentage / 100
	local f22_local13 = {
		preloadPercentage = f22_local12,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
	}
	local f22_local14 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f22_local15 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f22_local16 = Lobby.Timer.lobbyTimer.arenaStatsAjusted
	local f22_local17 = 0
	local f22_local18 = 0
	LobbyVM.CheckSpecialPlaylistRules(f22_local0)
	if f22_local6 ~= Lobby.Timer.MATCH_START_INVALID then
		f22_local7 = math.floor(math.max(0, f22_local6 - Engine[0x9D33D652B9B0F3B]()) / 1000)
	end
	if f22_local4 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	f22_local5 = f22_local7
	if f22_local10 or f22_local4 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Lobby.MapVote.Hide()
		f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
		f22_local6 = Lobby.Timer.MATCH_START_INVALID
		f22_local14:set("")
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.VOTING then
		Lobby.MapVote.ShowVote()
		if f22_local6 == Lobby.Timer.MATCH_START_INVALID then
			f22_local6 = Engine[0x9D33D652B9B0F3B]() + Dvar[0xA0A01C39967B404]:get()
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
		else
			Engine[0x83C9B5DE1D9371](f22_local14, Engine[0xF9F1239CFD921FE](0x8E27051A1C44827) .. ": " .. f22_local7)
			Lobby.Matchmaking.UpdatePublicLobby({
				stage = LuaEnum.PUBLIC_LOBBY.INTERMISSION,
				intermissionTime = f22_local7,
			})
			if math.max(0, f22_local6 - Engine[0x9D33D652B9B0F3B]()) == 0 then
				f22_local6 = Lobby.Timer.MATCH_START_INVALID
				f22_local4 = Lobby.Timer.LOBBY_STATUS.POST_GAME
				Lobby.MapVote.LockedInVote()
				Lobby.MapVote.UpdateMapVoteInfo()
			end
		end
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.WAIT_FOR_LOBBY_LOCK then
		if f22_local7 <= 0 then
			f22_local4 = Lobby.Timer.LOBBY_STATUS.IDLE
			f22_local6 = Lobby.Timer.MATCH_START_INVALID
			Engine[0xCB6D7D39AF67BC1](Engine[0xA5B9C0111291A8B](), Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		end
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.POST_GAME then
		if f22_local6 == Lobby.Timer.MATCH_START_INVALID then
			f22_local6 = Engine[0x9D33D652B9B0F3B]() + Dvar[0xAEDDAFEB3887F37]:get() + 40000
			Lobby.Timer.lastValue = 0
		elseif f22_local7 <= 0 then
			f22_local4 = Lobby.Timer.LOBBY_STATUS.MATCH_END_DEDICATED
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.DISBAND_LOBBY
			local f22_local19 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME)
			Lobby.ProcessQueue.AddToQueue("LobbyArenaMatchEnded", Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f22_local0, f22_local19, f22_local19, LuaEnum.LEAVE_WITH_PARTY.WITH))
		end
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.MATCH_END_DEDICATED then
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED then
		f22_local6 = Lobby.Timer.MATCH_START_INVALID
		f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
		f22_local14:set("")
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
		Lobby.MapVote.ShowLockedIn()
		if f22_local9 > 0 then
			if f22_local9 == 1 then
				f22_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f22_local13.stageTitle = 0xC4D2D56E3932FAB
				f22_local13.stageDetails = Engine[0xF9F1239CFD921FE](0x5A08D09755BAA8E)
				f22_local13.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f22_local13)
				f22_local17 = f22_local7
			else
				f22_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f22_local13.stageTitle = 0xC4D2D56E3932FAB
				f22_local13.stageDetails = Engine[0xF9F1239CFD921FE](0x46A0BCA90BC2137, f22_local9)
				f22_local13.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f22_local13)
			end
			f22_local6 = Lobby.Timer.MATCH_START_INVALID
			f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			f22_local5 = f22_local9
			Lobby.MatchmakingAsync.StartBlockedWaitingForPlayers()
		else
			f22_local6 = Lobby.Timer.MATCH_START_INVALID
			f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_BALANCE
			Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
			Lobby.MatchmakingAsync.StopBlockedWaitingForPlayers()
		end
		f22_local14:set("")
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.NEED_BALANCE then
		Lobby.MapVote.ShowLockedIn()
		if f22_local9 > 0 then
			f22_local6 = Lobby.Timer.MATCH_START_INVALID
			f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
		else
			local f22_local19 = false
			if Engine[0x9D33D652B9B0F3B]() - Lobby.Timer.lobbyTimer.balanceStartTime > 10000 then
				f22_local19 = true
				Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			end
			if Lobby.TeamSelection.AutoSplitTeam(true, f22_local19, true) then
				f22_local6 = Lobby.Timer.MATCH_START_INVALID
				f22_local4 = Lobby.Timer.LOBBY_STATUS.STARTING
				Lobby.MatchmakingAsync.LockTeams()
				f22_local13.preloadPercentage = 1
				Lobby.Matchmaking.UpdatePublicLobby(f22_local13)
				newStage = "starting stage"
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Team Ballanced going to " .. newStage .. "\n")
				if Dvar[0x7255714A6A48B0A]:get() == true and Dvar[0x4BADE8473F0165F]:get() == false then
					Engine[0xC6664E11A641F01](f22_local0)
				end
			else
				f22_local6 = Lobby.Timer.MATCH_START_INVALID
				f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_BALANCE
				f22_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f22_local13.stageTitle = 0xC4D2D56E3932FAB
				f22_local13.stageDetails = Engine[0xF9F1239CFD921FE](0xD562EA62A296CB6)
				Lobby.Matchmaking.UpdatePublicLobby(f22_local13)
			end
			f22_local14:set("")
		end
	elseif f22_local4 == Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.MapVote.ShowLockedIn()
		if f22_local9 > 0 then
			f22_local6 = Lobby.Timer.MATCH_START_INVALID
			f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
			Lobby.MatchmakingAsync.UnLockTeams()
			Lobby.MatchmakingAsync.ToggleAsyncMatchmaking({
				advertise = true,
			})
			if f22_local16 then
				f22_local16 = nil
			end
		elseif Lobby.TeamSelection.AutoSplitTeam(true, true) == false then
			f22_local6 = Lobby.Timer.MATCH_START_INVALID
			f22_local4 = Lobby.Timer.LOBBY_STATUS.NEED_BALANCE
			Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			Lobby.MatchmakingAsync.UnLockTeams()
			Lobby.MatchmakingAsync.ToggleAsyncMatchmaking({
				advertise = true,
			})
			if f22_local16 then
				f22_local16 = nil
			end
		else
			f22_local4 = Lobby.Timer.LOBBY_STATUS.STARTING
			if f22_local6 == Lobby.Timer.MATCH_START_INVALID then
				Lobby.MatchmakingAsync.ToggleAsyncMatchmaking({
					advertise = false,
				})
				f22_local6 = Engine[0x9D33D652B9B0F3B]() + Dvar[0xAEDDAFEB3887F37]:get()
			else
				if f22_local7 > 0 then
					Lobby.Matchmaking.UpdatePublicLobby({
						preloadPercentage = f22_local12,
						stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
						startTime = f22_local7,
					})
					f22_local17 = f22_local7
					Engine[0x3B9F1AA6A523204](Engine[0x20826BD382E3A23](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f22_local1, Engine[0x93B19E01B1FD1C7](f22_local0)))
					f22_local14:set(Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f22_local7))
				else
					f22_local14:set("")
				end
				if f22_local16 == nil then
					f22_local16 = true
				end
				Lobby.Timer.HostPlaySoundAndUpdateTime(f22_local7)
				if Lobby.ProcessQueue.IsQueueEmpty() and Engine[0x5B4EB7919738C02](f22_local1) == false and f22_local7 <= 0 and LobbyVM.LaunchGameExec(f22_local0, f22_local1) == true then
					Lobby.Timer.lobbyTimer.endFunc()
					Lobby.Timer.Clear(true)
					Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
					return
				end
			end
		end
	end
	if Lobby.Timer.lobbyTimer.status ~= f22_local4 then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoMPArenaPump status update: " .. Lobby.Timer.LOBBY_STATUS_STRING[f22_local4] .. ".  Old Status " .. Lobby.Timer.LOBBY_STATUS_STRING[Lobby.Timer.lobbyTimer.status] .. "\n")
	end
	Lobby.Timer.lobbyTimer.status = f22_local4
	Lobby.Timer.lobbyTimer.endTime = f22_local6
	Engine[0x83C9B5DE1D9371](f22_local15, f22_local17)
	Lobby.Timer.lobbyTimer.arenaStatsAjusted = f22_local16
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f22_local1, Lobby.Timer.lobbyTimer.status, f22_local5)
end
Lobby.Timer.AutoMPArenaPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return true
	else
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote", true), 0)
		Lobby.Timer.Clear(false)
		Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoMPPumpEnd: Kill lobby timer.\n")
		return true
	end
end
Lobby.Timer.AutoMPArenaPumpClient = function(f24_arg0)
	local f24_local0 = f24_arg0.controller
	local f24_local1 = f24_arg0.lobbyType
	local f24_local2 = f24_arg0.status
	local f24_local3 = f24_arg0.statusValue
	local f24_local4 = f24_arg0.statusValue
	local f24_local5 = f24_arg0.preloadPercentage / 100
	if Engine[0xEA2BE00F49480D](f24_local1) then
		return
	end
	local f24_local6 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f24_local7 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f24_local8 = {
		preloadPercentage = f24_local5,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
		stageDetails = Engine[0xF9F1239CFD921FE](LuaEnum.SEARCH_DESCRIPTION_STRING[LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_4_DESCRIPTION_1]),
	}
	local f24_local9 = 0
	local f24_local10 = Lobby.Timer.arenaStatsAjusted
	if f24_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	if f24_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Lobby.MapVote.Hide()
		Lobby.Matchmaking.UpdatePublicLobby({})
		Engine[0x83C9B5DE1D9371](f24_local6, "")
	elseif f24_local2 == Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED then
		Lobby.MapVote.ShowLockedIn()
		Lobby.Timer.UnlockLobby(f24_local0, true)
	elseif f24_local2 == Lobby.Timer.LOBBY_STATUS.VOTING then
		Lobby.MapVote.ShowVote()
		Engine[0x83C9B5DE1D9371](f24_local6, Engine[0xF9F1239CFD921FE](0x8E27051A1C44827) .. ": " .. f24_local3)
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.INTERMISSION,
			intermissionTime = f24_local3,
		})
	elseif f24_local2 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
		if f24_local10 then
			Engine[0xE3A697F60E031C6](f24_local0)
			f24_local10 = nil
		end
		f24_local8.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
		f24_local8.stageTitle = 0xC4D2D56E3932FAB
		local f24_local11
		if f24_local4 > 1 then
			f24_local11 = Engine[0xF9F1239CFD921FE](0x46A0BCA90BC2137, f24_local4)
			if not f24_local11 then
			else
				f24_local8.stageDetails = f24_local11
				f24_local8.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f24_local8)
				Engine[0x83C9B5DE1D9371](f24_local6, "")
			end
		end
		f24_local11 = Engine[0xF9F1239CFD921FE](0x5A08D09755BAA8E)
	elseif f24_local2 == Lobby.Timer.LOBBY_STATUS.NEED_BALANCE then
		Lobby.MapVote.ShowLockedIn()
		f24_local8.stageDetails = Engine[0xF9F1239CFD921FE](0xD562EA62A296CB6)
		f24_local8.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
		f24_local8.stageTitle = 0xC4D2D56E3932FAB
		Lobby.Matchmaking.UpdatePublicLobby(f24_local8)
		Engine[0x83C9B5DE1D9371](f24_local6, "")
		if f24_local10 then
			Engine[0xE3A697F60E031C6](f24_local0)
			f24_local10 = nil
		end
	elseif f24_local2 == Lobby.Timer.LOBBY_STATUS.POST_GAME then
		if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) == true then
			local f24_local11 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME)
			Lobby.ProcessQueue.AddToQueue("LobbyArenaMatchEnded", Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f24_local0, f24_local11, f24_local11, LuaEnum.LEAVE_WITH_PARTY.WITH))
		end
	elseif f24_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.MapVote.ShowLockedIn()
		if f24_local3 > 0 then
			Engine[0x83C9B5DE1D9371](f24_local6, Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f24_local3))
			Lobby.Matchmaking.UpdatePublicLobby({
				stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
				startTime = f24_local3,
				stageDetails = Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f24_local3),
			})
			f24_local9 = f24_local3
			Engine[0x3B9F1AA6A523204](Engine[0x20826BD382E3A23](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f24_local1, Engine[0x93B19E01B1FD1C7](f24_local0)))
		else
			Engine[0x83C9B5DE1D9371](f24_local6, "")
		end
		if f24_local10 == nil then
			if Dvar[0xF1DE3CEF5A9E0DB]:get() == 2 then
				Engine[0xBFFA2858E10C77A](f24_local0)
			end
			f24_local10 = true
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f24_local3)
	end
	Engine[0x83C9B5DE1D9371](f24_local7, f24_local9)
	Lobby.Timer.arenaStatsAjusted = f24_local10
end
Lobby.Timer.autoZMPumpIsOneMap = false
Lobby.Timer.AutoZMPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f25_local0 = Lobby.Timer.lobbyTimer.controller
	local f25_local1 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	local f25_local2 = Lobby.Timer.lobbyTimer.status
	local f25_local3 = 0
	local f25_local4 = Lobby.Timer.lobbyTimer.endTime
	local f25_local5 = 0
	local f25_local6 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f25_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f25_local7 = Dvar[0x500E4DB2F10F5EE]:get()
	local f25_local8 = math.max(0, f25_local7 - f25_local6)
	local f25_local9 = f25_local6 == 0
	local f25_local10
	if Dvar[0x4264944AA415EC0]:get() ~= true or Lobby.Timer.autoZMPumpIsOneMap ~= false then
		f25_local10 = false
	else
		f25_local10 = true
	end
	if not f25_local10 then
		Lobby.MapVote.ShowLockedIn()
	end
	local f25_local11 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f25_local12 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote.timerActive")
	local f25_local13 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f25_local14 = Engine[0xA537E2C09DAA5CD](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f25_local1)
	local f25_local15 = f25_local14.preloadPercentage
	local f25_local16 = {
		preloadPercentage = f25_local15,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
	}
	local f25_local17 = 0
	local f25_local18 = Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f25_local1)
	local f25_local19 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f25_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f25_local20 = 0
	local f25_local21 = f25_local19
	for f25_local25, f25_local26 in pairs(f25_local14.clients) do
		if f25_local26.readyUp == true then
			f25_local20 = f25_local20 + 1
		end
	end
	if f25_local21 < f25_local7 then
		f25_local21 = f25_local7
	end
	f25_local22 = math.floor(math.ceil(Dvar[0x8A2424003E8E98A]:get() * f25_local21) - f25_local20)
	if f25_local9 then
		if f25_local10 then
			Lobby.MapVote.Hide()
		end
		f25_local2 = Lobby.Timer.LOBBY_STATUS.IDLE
		f25_local3 = Lobby.Timer.MATCH_START_INVALID
	elseif f25_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		if f25_local10 then
			Lobby.MapVote.Hide()
		end
		f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
		f25_local3 = Lobby.Timer.MATCH_START_INVALID
	elseif f25_local2 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
		if f25_local10 and Lobby.MapVote.GetMapVoteStatus() ~= LuaEnum.MAP_VOTE_STATE.LOCKEDIN then
			Lobby.MapVote.ShowVote()
		end
		if f25_local8 > 0 then
			if f25_local8 == 1 then
				f25_local16.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f25_local16.stageTitle = 0xC4D2D56E3932FAB
				f25_local16.stageDetails = Engine[0xF9F1239CFD921FE](0x5A08D09755BAA8E)
				Lobby.Matchmaking.UpdatePublicLobby(f25_local16)
				f25_local17 = f25_local5
			else
				f25_local16.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f25_local16.stageTitle = 0xC4D2D56E3932FAB
				f25_local16.stageDetails = Engine[0xF9F1239CFD921FE](0x46A0BCA90BC2137, f25_local8)
				Lobby.Matchmaking.UpdatePublicLobby(f25_local16)
			end
			f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			f25_local3 = Lobby.Timer.MATCH_START_INVALID
			f25_local3 = f25_local8
		else
			f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_READYUP
		end
	elseif f25_local2 == Lobby.Timer.LOBBY_STATUS.NEED_READYUP then
		if f25_local10 and Lobby.MapVote.GetMapVoteStatus() ~= LuaEnum.MAP_VOTE_STATE.LOCKEDIN then
			Lobby.MapVote.ShowVote()
		end
		if 0 < Dvar[0x8A2424003E8E98A]:get() then
			if f25_local8 > 0 then
				f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
				f25_local3 = Lobby.Timer.MATCH_START_INVALID
			elseif f25_local22 > 0 then
				if f25_local22 == 1 then
					f25_local16.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
					f25_local16.stageTitle = 0xC4D2D56E3932FAB
					f25_local16.stageDetails = Engine[0xF9F1239CFD921FE](0x231FC751DC50156)
					Lobby.Matchmaking.UpdatePublicLobby(f25_local16)
				else
					f25_local16.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
					f25_local16.stageTitle = 0xC4D2D56E3932FAB
					f25_local16.stageDetails = Engine[0xF9F1239CFD921FE](0x96C7DC086052CF, f25_local22)
					Lobby.Matchmaking.UpdatePublicLobby(f25_local16)
				end
				f25_local3 = f25_local22
			else
				if f25_local10 then
					Lobby.MapVote.LockedInVote()
				end
				f25_local23 = LobbyData.GetCurrentMenuTarget()
				if f25_local21 == 1 and f25_local23[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) then
					f25_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
					f25_local4 = Engine[0x9D33D652B9B0F3B]() + Dvar[0x1458BE78EBED7B]:get()
				else
					f25_local2 = Lobby.Timer.LOBBY_STATUS.PRELOADING
					f25_local4 = Lobby.Timer.MATCH_START_INVALID
					Lobby.Timer.startTime = Engine[0x9D33D652B9B0F3B]()
				end
			end
		else
			if f25_local10 then
				Lobby.MapVote.LockedInVote()
			end
			f25_local2 = Lobby.Timer.LOBBY_STATUS.PRELOADING
			f25_local4 = Lobby.Timer.MATCH_START_INVALID
			Lobby.Timer.startTime = Engine[0x9D33D652B9B0F3B]()
		end
	elseif f25_local2 == Lobby.Timer.LOBBY_STATUS.PRELOADING then
		if f25_local8 > 0 then
			f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			f25_local3 = Lobby.Timer.MATCH_START_INVALID
		elseif 0 < Dvar[0x8A2424003E8E98A]:get() and f25_local22 > 0 then
			f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_READYUP
			f25_local3 = Lobby.Timer.MATCH_START_INVALID
		else
			if Lobby.Timer.lastValue ~= f25_local15 then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Current Preload Precentage " .. f25_local15 .. "\n")
				Lobby.Timer.lastValue = f25_local15
			end
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus"), Engine[0xF9F1239CFD921FE](0xA395ECFCBED4975, f25_local15))
			f25_local25 = 75
			if Dvar[0x46363E3FF24B1CF]:exists() then
				f25_local25 = Dvar[0x46363E3FF24B1CF]:get()
			end
			if f25_local25 <= f25_local15 then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Preload Done! \n")
				f25_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
				f25_local26 = 0
				local f25_local27 = LobbyData.GetCurrentMenuTarget()
				if f25_local21 == 1 and f25_local27[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) then
					f25_local26 = Dvar[0x1458BE78EBED7B]:get()
				else
					f25_local26 = Dvar[0x676A47FE42DA15A]:get()
				end
				if Lobby.Timer.startTime ~= nil then
					if Lobby.Timer.startTime + f25_local26 < Engine[0x9D33D652B9B0F3B]() then
						f25_local4 = Engine[0x9D33D652B9B0F3B]()
					end
				else
					f25_local4 = Engine[0x9D33D652B9B0F3B]() + f25_local26
				end
				Lobby.Timer.lastValue = 0
				f25_local17 = 100
			else
				if f25_local15 == 0 then
					f25_local15 = 1
				end
				f25_local17 = f25_local15
			end
		end
	elseif f25_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		if f25_local10 then
			Lobby.MapVote.ShowLockedIn()
		end
		if f25_local8 > 0 then
			f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			f25_local3 = Lobby.Timer.MATCH_START_INVALID
		elseif 0 < Dvar[0x8A2424003E8E98A]:get() and f25_local22 > 0 then
			f25_local2 = Lobby.Timer.LOBBY_STATUS.NEED_READYUP
			f25_local3 = Lobby.Timer.MATCH_START_INVALID
		else
			f25_local5 = math.floor((f25_local4 - Engine[0x9D33D652B9B0F3B]()) / 1000)
			if f25_local5 > 0 then
				Engine[0x83C9B5DE1D9371](f25_local11, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f25_local5))
				Lobby.Matchmaking.UpdatePublicLobby({
					stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
					startTime = f25_local5,
					stageDetails = Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f25_local5),
				})
				f25_local17 = f25_local5
			else
				Engine[0x83C9B5DE1D9371](f25_local11, "")
				Lobby.Matchmaking.UpdatePublicLobby({})
			end
			Lobby.Timer.HostPlaySoundAndUpdateTime(f25_local5, true)
			if Lobby.ProcessQueue.IsQueueEmpty() and Engine[0x5B4EB7919738C02](f25_local1) == false and f25_local5 <= 0 then
				if 1 == LuaUtils.MatchmakingTest() then
					f25_local2 = Lobby.Timer.LOBBY_STATUS.IDLE
					f25_local3 = Lobby.Timer.MATCH_START_INVALID
					f25_local4 = Lobby.Timer.MATCH_START_INVALID
					return
				elseif LobbyVM.LaunchGameExec(f25_local0, f25_local1) == true then
					Lobby.Join.ZMAllowJoin = true
					Engine[0x83C9B5DE1D9371](f25_local11, "")
					f25_local4 = Lobby.Timer.MATCH_START_INVALID
					Lobby.Timer.Clear(true)
					return
				end
			end
			f25_local3 = math.max(f25_local5, 0)
		end
	else
		if f25_local10 then
			Lobby.MapVote.Hide()
		end
		Lobby.Timer.lastValue = 0
		Engine[0x83C9B5DE1D9371](f25_local12, 0)
	end
	Lobby.Timer.lobbyTimer.status = f25_local2
	Lobby.Timer.lobbyTimer.endTime = f25_local4
	f25_local23 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f25_local1)
	f25_local24 = 100
	for f25_local30, f25_local31 in ipairs(f25_local23.sessionClients) do
		local f25_local29 = f25_local31.preloadPercentage
		local f25_local32 = f25_local31.lobbyClientType
		local f25_local28
		if f25_local32 ~= Enum[0xD7CCD8BF53DC08C][0x5768EF8BA18333F] and f25_local32 ~= Enum[0xD7CCD8BF53DC08C][0xEA66E24E2A1A4D9] then
			f25_local28 = false
		else
			f25_local28 = true
		end
		if f25_local28 then
			f25_local29 = 100
		end
		if f25_local29 < f25_local24 then
			f25_local24 = f25_local29
		end
	end
	Engine[0x16F0F60DCF60C1B](f25_local1, f25_local24)
	Engine[0x83C9B5DE1D9371](f25_local13, f25_local17)
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f25_local1, f25_local2, f25_local3)
end
Lobby.Timer.AutoZMPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return true
	else
		Lobby.MapVote.Hide()
		Lobby.Timer.Clear(false)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoZMPumpEnd: Kill lobby timer.\n")
		return true
	end
end
Lobby.Timer.AutoZMPumpClient = function(f27_arg0)
	local f27_local0 = f27_arg0.controller
	local f27_local1 = f27_arg0.lobbyType
	local f27_local2 = f27_arg0.status
	local f27_local3 = f27_arg0.statusValue
	local f27_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f27_local5 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f27_local6 = Dvar[0x4264944AA415EC0]:get() == true
	local f27_local7 = {
		preloadPercentage = preloadPercentage,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
	}
	local f27_local8 = 0
	if f27_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	if not f27_local6 then
		Lobby.MapVote.ShowLockedIn()
	end
	if f27_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		if f27_local6 then
			Lobby.MapVote.Hide()
		end
		Lobby.Matchmaking.UpdatePublicLobby({})
		Engine[0x83C9B5DE1D9371](f27_local4, "")
	elseif f27_local2 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
		if f27_local6 then
			Lobby.MapVote.ShowVote()
		end
		local f27_local9 = f27_local3
		f27_local7.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
		f27_local7.stageTitle = 0xC4D2D56E3932FAB
		local f27_local10
		if f27_local9 > 1 then
			f27_local10 = Engine[0xF9F1239CFD921FE](0x46A0BCA90BC2137, f27_local9)
			if not f27_local10 then
			else
				f27_local7.stageDetails = f27_local10
				Lobby.Matchmaking.UpdatePublicLobby(f27_local7)
			end
		end
		f27_local10 = Engine[0xF9F1239CFD921FE](0x5A08D09755BAA8E)
	elseif f27_local2 == Lobby.Timer.LOBBY_STATUS.NEED_READYUP then
		if f27_local6 then
			Lobby.MapVote.ShowVote()
		end
		local f27_local9 = f27_local3
		f27_local7.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
		f27_local7.stageTitle = 0xC4D2D56E3932FAB
		local f27_local10
		if f27_local9 > 1 then
			f27_local10 = Engine[0xF9F1239CFD921FE](0x96C7DC086052CF, f27_local9)
			if not f27_local10 then
			else
				f27_local7.stageDetails = f27_local10
				Lobby.Matchmaking.UpdatePublicLobby(f27_local7)
			end
		end
		f27_local10 = Engine[0xF9F1239CFD921FE](0x231FC751DC50156)
	elseif f27_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		if f27_local6 then
			Lobby.MapVote.ShowLockedIn()
		end
		local f27_local9 = f27_local3
		if f27_local9 > 0 then
			Lobby.Matchmaking.UpdatePublicLobby({
				stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
				startTime = f27_local9,
				stageDetails = Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f27_local9),
			})
			f27_local8 = f27_local9
		else
			Lobby.Matchmaking.UpdatePublicLobby({})
			Engine[0x83C9B5DE1D9371](f27_local4, "")
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f27_local9)
	end
	Engine[0x83C9B5DE1D9371](f27_local5, f27_local8)
end
Lobby.Timer.SetManualStatusTo = function(f28_arg0)
	if Lobby.Timer.lobbyTimer == nil then
		return
	elseif Lobby.Timer.lobbyTimer.lobbyTimerType == LuaEnum.TIMER_TYPE.MANUAL and Lobby.Timer.lobbyTimer.lobbyTimerType == LuaEnum.TIMER_TYPE.MANUAL_CP then
		Lobby.Timer.lobbyTimer.status = f28_arg0
	end
end
Lobby.Timer.SetDedicatedDelayedCMD = function(f29_arg0)
	Lobby.Timer.DedicatedSpecialCMD = f29_arg0
end
Lobby.Timer.ManualPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f30_local0 = Lobby.Timer.lobbyTimer.controller
	local f30_local1 = Lobby.Timer.lobbyTimer.lobbyType
	local f30_local2 = Lobby.Timer.LOBBY_STATUS.IDLE
	local f30_local3 = 0
	local f30_local4 = 0
	local f30_local5 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f30_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f30_local6 = f30_local5 == 0
	Lobby.MapVote.ShowLockedIn()
	local f30_local7 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote.timerActive")
	local f30_local8 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f30_local9 = 0
	local f30_local10 = Engine[0xA537E2C09DAA5CD](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f30_local1)
	local f30_local11 = f30_local10.preloadPercentage
	if f30_local6 then
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.IDLE
		Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
	elseif Engine[0xE39F1F30B306065]() and Lobby.Timer.lobbyTimer.status == Lobby.Timer.LOBBY_STATUS.IDLE and Lobby.Timer.DedicatedSpecialCMD == Lobby.Timer.LOBBY_DEDICATED_CMD.INVALID_CMD and (not Dvar[0xB852BA138B9853A]:exists() or not Dvar[0xB852BA138B9853A]:get() or f30_local5 >= Dvar[0x500E4DB2F10F5EE]:get()) then
		Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x1A227834B17E155]:get()
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.STARTING
	elseif Engine[0xE39F1F30B306065]() and Lobby.Timer.DedicatedSpecialCMD == Lobby.Timer.LOBBY_DEDICATED_CMD.REMOVE_ALL_CLIENTS then
		Lobby.Timer.DedicatedSpecialCMD = Lobby.Timer.LOBBY_DEDICATED_CMD.END
		local f30_local12 = Engine[0x861CBECCE713707](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		local f30_local13 = {
			f30_local12.sessionLeader.xuid,
		}
		local f30_local14 = Engine[0xE42CF04B7DDD5DE](LobbyMsg.EncodeToLobbyMsgType(LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_SERVER_REQUEST_LEAVEWITHPARTY), Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		LobbyMsg.PackageKickLobbyLeader(f30_local14, f30_local12.sessionLeader.xuid)
		f30_local14:sendToClients(f30_local0, f30_local13)
		f30_local14:free()
	elseif Lobby.Timer.lobbyTimer.status == Lobby.Timer.LOBBY_STATUS.FIND_DEDICATED_SERVER then
		Lobby.ProcessQueue.AddToQueue("UnparkCustomServer", Lobby.Process.UnParkAndJoinCustomDedicatedServer(f30_local0))
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.lobbyTimer.FIND_NEW_LOBBY
		Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x1A227834B17E155]:get()
	elseif Lobby.Timer.lobbyTimer.status == Lobby.Timer.LOBBY_STATUS.FIND_NEW_LOBBY then
	elseif Lobby.Timer.lobbyTimer.status == Lobby.Timer.LOBBY_STATUS.PRELOADING then
		endTime = Lobby.Timer.MATCH_START_INVALID
		f30_local2 = Lobby.Timer.lobbyTimer.status
		if Lobby.Timer.lastValue ~= f30_local11 then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Current Preload Precentage " .. f30_local11 .. "\n")
			Lobby.Timer.lastValue = f30_local11
		end
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus"), Engine[0xF9F1239CFD921FE](0xA395ECFCBED4975, f30_local11))
		local f30_local14 = 75
		if Dvar[0x46363E3FF24B1CF]:exists() then
			f30_local14 = Dvar[0x46363E3FF24B1CF]:get()
		end
		if f30_local14 <= f30_local11 then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Preload Done! \n")
			Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x1A227834B17E155]:get()
			Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.STARTING
			Lobby.Timer.lastValue = 0
			f30_local9 = 100
		else
			if f30_local11 == 0 then
				f30_local11 = 1
			end
			f30_local9 = f30_local11
		end
	elseif Lobby.Timer.lobbyTimer.endTime ~= Lobby.Timer.MATCH_START_INVALID then
		f30_local4 = math.floor((Lobby.Timer.lobbyTimer.endTime - Engine[0x9D33D652B9B0F3B]()) / 1000)
		f30_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
		Lobby.Timer.lobbyTimer.status = f30_local2
		local f30_local13 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
		if f30_local4 > 0 then
			Engine[0x83C9B5DE1D9371](f30_local13, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f30_local4))
			f30_local9 = f30_local4
		else
			Engine[0x83C9B5DE1D9371](f30_local13, "")
		end
		Lobby.Timer.HostPlaySoundAndUpdateTime(f30_local4, true)
		if (Engine[0xE39F1F30B306065]() or not CoDShared.IsLobbyMode(Enum[0x8409AA0F01B5DBC][0x8B3B066EFD7CD01]) and not LuaUtils.AllClientsSpectating()) and (Engine[0xDBC2AD5002B261B](Lobby.Pregame.Settings.VOTE_ENABLED) == 1 or Engine[0xDBC2AD5002B261B](Lobby.Pregame.Settings.DRAFT_ENABLED) == 1) and f30_local4 <= 0 then
			Lobby.Pregame.Start()
			Lobby.Timer.Clear(false)
			return
		end
		if Lobby.ProcessQueue.IsQueueEmpty() and Engine[0x5B4EB7919738C02](f30_local1) == false and f30_local4 <= 0 then
			if Lobby.Timer.GetTimerType() == LuaEnum.TIMER_TYPE.THEATER then
				Engine[0x83C9B5DE1D9371](f30_local13, "")
				Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
				LobbyVM.LaunchDemoExec(f30_local0, f30_local1)
				return
			elseif LobbyVM.LaunchGameExec(f30_local0, f30_local1) == true then
				Engine[0x83C9B5DE1D9371](f30_local13, "")
				Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
				return
			end
		end
		f30_local3 = math.max(f30_local4, 0)
	else
		Lobby.Timer.lastValue = 0
		Engine[0x83C9B5DE1D9371](f30_local7, 0)
	end
	local f30_local12 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f30_local1)
	local f30_local13 = 100
	for f30_local19, f30_local20 in ipairs(f30_local12.sessionClients) do
		local f30_local18 = f30_local20.preloadPercentage
		local f30_local21 = f30_local20.lobbyClientType
		local f30_local17
		if f30_local21 ~= Enum[0xD7CCD8BF53DC08C][0x5768EF8BA18333F] and f30_local21 ~= Enum[0xD7CCD8BF53DC08C][0xEA66E24E2A1A4D9] then
			f30_local17 = false
		else
			f30_local17 = true
		end
		if f30_local17 then
			f30_local18 = 100
		end
		if f30_local18 < f30_local13 then
			f30_local13 = f30_local18
		end
	end
	Engine[0x16F0F60DCF60C1B](f30_local1, f30_local13)
	Engine[0x83C9B5DE1D9371](f30_local8, f30_local9)
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f30_local1, f30_local2, f30_local3)
end
Lobby.Timer.ManualPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	else
		Lobby.MapVote.ShowLockedIn()
		if Lobby.Timer.lobbyTimer.endTime ~= Lobby.Timer.MATCH_START_INVALID or Lobby.Timer.lobbyTimer.status == Lobby.Timer.LOBBY_STATUS.PRELOADING then
			Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
			Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.IDLE
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus"), "")
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.ManualPumpEnd: Stop lobby timer.\n")
			return false
		else
			Lobby.Timer.Clear(false)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.ManualPumpEnd: Kill lobby timer.\n")
			return true
		end
	end
end
Lobby.Timer.ManualPumpClient = function(f32_arg0)
	local f32_local0 = f32_arg0.controller
	local f32_local1 = f32_arg0.lobbyType
	local f32_local2 = f32_arg0.status
	local f32_local3 = f32_arg0.statusValue
	local f32_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f32_local5 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f32_local6 = 0
	if f32_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	Lobby.MapVote.ShowLockedIn()
	if f32_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Engine[0x83C9B5DE1D9371](f32_local4, "")
	elseif f32_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		if f32_local3 > 0 then
			Engine[0x83C9B5DE1D9371](f32_local4, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f32_local3))
			f32_local6 = f32_local3
		else
			Engine[0x83C9B5DE1D9371](f32_local4, "")
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f32_local3)
	end
	Engine[0x83C9B5DE1D9371](f32_local5, f32_local6)
end
Lobby.Timer.ManualCPPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f33_local0 = Lobby.Timer.lobbyTimer.controller
	local f33_local1 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	local f33_local2 = Lobby.Timer.LOBBY_STATUS.IDLE
	local f33_local3 = 0
	local f33_local4 = 0
	local f33_local5 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f33_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f33_local6 = f33_local5 == 0
	Lobby.MapVote.ShowLockedIn()
	local f33_local7 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote.timerActive")
	local f33_local8 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f33_local9 = 0
	if f33_local6 then
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.IDLE
		Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
	elseif Lobby.Timer.lobbyTimer.endTime ~= Lobby.Timer.MATCH_START_INVALID then
		local f33_local10 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
		if f33_local5 == 1 then
			Engine[0x83C9B5DE1D9371](f33_local10, "")
			Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
			LobbyVM.LaunchGameExec(f33_local0, f33_local1)
		else
			f33_local4 = math.floor((Lobby.Timer.lobbyTimer.endTime - Engine[0x9D33D652B9B0F3B]()) / 1000)
			f33_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
			if f33_local4 > 0 then
				Engine[0x83C9B5DE1D9371](f33_local10, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f33_local4))
				f33_local9 = f33_local4
			else
				Engine[0x83C9B5DE1D9371](f33_local10, "")
			end
			Lobby.Timer.HostPlaySoundAndUpdateTime(f33_local4, true)
			if Lobby.ProcessQueue.IsQueueEmpty() and Engine[0x5B4EB7919738C02](f33_local1) == false and f33_local4 <= 0 and LobbyVM.LaunchGameExec(f33_local0, f33_local1) == true then
				Engine[0x83C9B5DE1D9371](f33_local10, "")
				Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
				return
			end
			f33_local3 = math.max(f33_local4, 0)
		end
	else
		Lobby.Timer.lastValue = 0
		Engine[0x83C9B5DE1D9371](f33_local7, 0)
	end
	Engine[0x83C9B5DE1D9371](f33_local8, f33_local9)
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f33_local1, f33_local2, f33_local3)
end
Lobby.Timer.ManualCPPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	else
		Lobby.MapVote.ShowLockedIn()
		if Lobby.Timer.lobbyTimer.endTime ~= Lobby.Timer.MATCH_START_INVALID then
			Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus"), "")
			if Engine[0xDBC2AD5002B261B]("teamAssignment") == LuaEnum.TEAM_ASSIGNMENT.AUTO then
				Lobby.TeamSelection.Clear()
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.ManualPumpEnd: Stop lobby timer.\n")
			return false
		else
			Lobby.Timer.Clear(false)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.ManualPumpEnd: Kill lobby timer.\n")
			return true
		end
	end
end
Lobby.Timer.ManualCPPumpClient = function(f35_arg0)
	local f35_local0 = f35_arg0.controller
	local f35_local1 = f35_arg0.lobbyType
	local f35_local2 = f35_arg0.status
	local f35_local3 = f35_arg0.statusValue
	local f35_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f35_local5 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f35_local6 = 0
	if f35_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	Lobby.MapVote.ShowLockedIn()
	if f35_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Engine[0x83C9B5DE1D9371](f35_local4, "")
	elseif f35_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		if f35_local3 > 0 then
			Engine[0x83C9B5DE1D9371](f35_local4, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f35_local3))
			f35_local6 = f35_local3
		else
			Engine[0x83C9B5DE1D9371](f35_local4, "")
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f35_local3)
	end
	Engine[0x83C9B5DE1D9371](f35_local5, f35_local6)
end
Lobby.Timer.AutoWZPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f36_local0 = Lobby.Timer.lobbyTimer.controller
	local f36_local1 = Lobby.Timer.lobbyTimer.lobbyType
	local f36_local2 = Lobby.Timer.lobbyTimer.mainMode
	local f36_local3 = Lobby.Timer.lobbyTimer.lobbyTimerType
	local f36_local4 = Lobby.Timer.lobbyTimer.status
	local f36_local5 = 0
	local f36_local6 = Lobby.Timer.lobbyTimer.endTime
	local f36_local7 = 0
	local f36_local8 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f36_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f36_local9 = math.max(0, Dvar[0x500E4DB2F10F5EE]:get() - f36_local8)
	local f36_local10 = f36_local8 == 0
	if f36_local10 and Lobby.MMAsync.lobbyCreateTime > Engine[0x9D33D652B9B0F3B]() then
		f36_local10 = false
	end
	local f36_local11 = Engine[0xA537E2C09DAA5CD](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f36_local1)
	local f36_local12 = f36_local11.preloadPercentage / 100
	local f36_local13 = {
		preloadPercentage = f36_local12,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
	}
	local f36_local14 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f36_local15 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f36_local16 = 0
	local f36_local17 = 0
	LobbyVM.CheckSpecialPlaylistRules(f36_local0)
	if f36_local6 ~= Lobby.Timer.MATCH_START_INVALID then
		f36_local7 = math.floor(math.max(0, f36_local6 - Engine[0x9D33D652B9B0F3B]()) / 1000)
	end
	if f36_local4 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	f36_local5 = f36_local7
	if f36_local10 or f36_local4 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Lobby.MapVote.Hide()
		f36_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
		f36_local6 = Lobby.Timer.MATCH_START_INVALID
		f36_local14:set("")
	elseif f36_local4 == Lobby.Timer.LOBBY_STATUS.POST_GAME then
		if f36_local6 == Lobby.Timer.MATCH_START_INVALID then
			f36_local6 = Engine[0x9D33D652B9B0F3B]() + Dvar[0xAEDDAFEB3887F37]:get()
			Lobby.Timer.lastValue = 0
		elseif f36_local7 <= 0 then
			f36_local4 = Lobby.Timer.LOBBY_STATUS.MATCH_END_DEDICATED
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.DISBAND_LOBBY
		end
	elseif f36_local4 == Lobby.Timer.LOBBY_STATUS.MATCH_END_DEDICATED then
	elseif f36_local4 == Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED then
		f36_local6 = Lobby.Timer.MATCH_START_INVALID
		f36_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
		f36_local14:set("")
	elseif f36_local4 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
		Lobby.MapVote.ShowLockedIn()
		if f36_local9 > 0 then
			if f36_local9 == 1 then
				f36_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f36_local13.stageTitle = 0xC4D2D56E3932FAB
				f36_local13.stageDetails = Engine[0xF9F1239CFD921FE](0x5A08D09755BAA8E)
				f36_local13.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f36_local13)
				f36_local16 = f36_local7
			else
				f36_local13.stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3
				f36_local13.stageTitle = 0xC4D2D56E3932FAB
				f36_local13.stageDetails = Engine[0xF9F1239CFD921FE](0x46A0BCA90BC2137, f36_local9)
				f36_local13.showWaitingWidget = true
				Lobby.Matchmaking.UpdatePublicLobby(f36_local13)
			end
			f36_local6 = Lobby.Timer.MATCH_START_INVALID
			f36_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			f36_local5 = f36_local9
			Lobby.MatchmakingAsync.StartBlockedWaitingForPlayers()
		else
			f36_local6 = Lobby.Timer.MATCH_START_INVALID
			f36_local4 = Lobby.Timer.LOBBY_STATUS.STARTING
			Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
			Lobby.MatchmakingAsync.StopBlockedWaitingForPlayers()
		end
		f36_local14:set("")
	elseif f36_local4 == Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.MapVote.ShowLockedIn()
		if f36_local9 > 0 then
			f36_local6 = Lobby.Timer.MATCH_START_INVALID
			f36_local4 = Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS
			Lobby.TeamSelection.ClearTeam(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
			Lobby.MatchmakingAsync.UnLockTeams()
		elseif Lobby.TeamSelection.AutoSplitTeam(true, true) == false then
			f36_local6 = Lobby.Timer.MATCH_START_INVALID
			f36_local4 = Lobby.Timer.LOBBY_STATUS.NEED_BALANCE
			Lobby.Timer.lobbyTimer.balanceStartTime = Engine[0x9D33D652B9B0F3B]()
			Lobby.MatchmakingAsync.UnLockTeams()
		else
			f36_local4 = Lobby.Timer.LOBBY_STATUS.STARTING
			if f36_local6 == Lobby.Timer.MATCH_START_INVALID then
				f36_local6 = Engine[0x9D33D652B9B0F3B]()
			else
				if f36_local7 > 0 then
					Lobby.Matchmaking.UpdatePublicLobby({
						preloadPercentage = f36_local12,
						stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
						startTime = f36_local7,
					})
					f36_local16 = f36_local7
					Engine[0x3B9F1AA6A523204](Engine[0x20826BD382E3A23](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f36_local1, Engine[0x93B19E01B1FD1C7](f36_local0)))
					f36_local14:set(Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f36_local7))
				else
					f36_local14:set("")
				end
				Lobby.Timer.HostPlaySoundAndUpdateTime(f36_local7)
				if Lobby.ProcessQueue.IsQueueEmpty() and Engine[0x5B4EB7919738C02](f36_local1) == false and f36_local7 <= 0 and LobbyVM.LaunchGameExec(f36_local0, f36_local1) == true then
					Lobby.Timer.lobbyTimer.endFunc()
					Lobby.Timer.Clear(true)
					Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
					return
				end
			end
		end
	end
	if Lobby.Timer.lobbyTimer.status ~= f36_local4 then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoWZPump status update: " .. Lobby.Timer.LOBBY_STATUS_STRING[f36_local4] .. ".\n")
	end
	Lobby.Timer.lobbyTimer.status = f36_local4
	Lobby.Timer.lobbyTimer.endTime = f36_local6
	Engine[0x83C9B5DE1D9371](f36_local15, f36_local16)
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f36_local1, Lobby.Timer.lobbyTimer.status, f36_local5)
end
Lobby.Timer.AutoWZPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return true
	else
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote", true), 0)
		Lobby.Timer.Clear(false)
		Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.AutoWZPumpEnd: Kill lobby timer.\n")
		return true
	end
end
Lobby.Timer.AutoWZPumpClient = function(f38_arg0)
	local f38_local0 = f38_arg0.controller
	local f38_local1 = f38_arg0.lobbyType
	local f38_local2 = f38_arg0.status
	local f38_local3 = f38_arg0.statusValue
	local f38_local4 = f38_arg0.statusValue
	local f38_local5 = f38_arg0.preloadPercentage / 100
	if Engine[0xEA2BE00F49480D](f38_local1) then
		return
	end
	local f38_local6 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f38_local7 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f38_local8 = {
		preloadPercentage = f38_local5,
		stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
		stageTitle = 0xD62495C7EEE7626,
		stageDetails = Engine[0xF9F1239CFD921FE](LuaEnum.SEARCH_DESCRIPTION_STRING[LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_4_DESCRIPTION_1]),
	}
	local f38_local9 = 0
	if f38_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	if f38_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Lobby.MapVote.Hide()
		Lobby.Matchmaking.UpdatePublicLobby({})
		Engine[0x83C9B5DE1D9371](f38_local6, "")
	elseif f38_local2 == Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED then
		Lobby.MapVote.ShowLockedIn()
		Lobby.Timer.UnlockLobby(f38_local0, true)
	elseif f38_local2 == Lobby.Timer.LOBBY_STATUS.NEED_PLAYERS then
	elseif f38_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.MapVote.ShowLockedIn()
		if f38_local3 > 0 then
			Engine[0x83C9B5DE1D9371](f38_local6, Engine[0xF9F1239CFD921FE](0x262BF3A0D778C5C, f38_local3))
			Lobby.Matchmaking.UpdatePublicLobby({
				stage = LuaEnum.PUBLIC_LOBBY.START_MATCH,
				startTime = f38_local3,
				stageDetails = Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f38_local3),
			})
			f38_local9 = f38_local3
			Engine[0x3B9F1AA6A523204](Engine[0x20826BD382E3A23](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f38_local1, Engine[0x93B19E01B1FD1C7](f38_local0)))
		else
			Engine[0x83C9B5DE1D9371](f38_local6, "")
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f38_local3)
	elseif f38_local2 == Lobby.Timer.LOBBY_STATUS.POST_GAME then
		local f38_local10 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
		Lobby.ProcessQueue.AddToQueue("WZLobbyClientLeft", Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f38_local0, f38_local10, f38_local10, LuaEnum.LEAVE_WITH_PARTY.WITH, true))
	end
	Engine[0x83C9B5DE1D9371](f38_local7, f38_local9)
end
Lobby.Timer.TestingPump = function()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f39_local0 = Lobby.Timer.lobbyTimer.controller
	local f39_local1 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	local f39_local2 = Lobby.Timer.LOBBY_STATUS.IDLE
	local f39_local3 = 0
	local f39_local4 = 0
	local f39_local5 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f39_local1, Enum[0x575E471C039DBD6][0x92BC25E18D296F]) == 0
	Lobby.MapVote.ShowLockedIn()
	local f39_local6 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MapVote.timerActive")
	local f39_local7 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f39_local8 = 0
	if f39_local5 then
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.IDLE
		Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
	elseif Lobby.Timer.lobbyTimer.endTime == Lobby.Timer.MATCH_START_INVALID then
		Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + 30000
	elseif Lobby.Timer.lobbyTimer.endTime ~= Lobby.Timer.MATCH_START_INVALID then
		local f39_local9 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
		f39_local4 = math.floor((Lobby.Timer.lobbyTimer.endTime - Engine[0x9D33D652B9B0F3B]()) / 1000)
		f39_local2 = Lobby.Timer.LOBBY_STATUS.STARTING
		if f39_local4 > 0 then
			Engine[0x83C9B5DE1D9371](f39_local9, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f39_local4))
			f39_local8 = f39_local4
		else
			Engine[0x83C9B5DE1D9371](f39_local9, "")
		end
		Lobby.Timer.HostPlaySoundAndUpdateTime(f39_local4, true)
		if f39_local4 <= 0 then
			Engine[0x83C9B5DE1D9371](f39_local9, "")
			Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
			LobbyVM.LaunchGameExec(f39_local0, f39_local1)
			Lobby.Timer.Clear(true)
			return
		end
		f39_local3 = f39_local4
	else
		Lobby.Timer.lastValue = 0
		Engine[0x83C9B5DE1D9371](f39_local6, 0)
	end
	Engine[0x83C9B5DE1D9371](f39_local7, f39_local8)
	Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f39_local1, f39_local2, f39_local3)
end
Lobby.Timer.TestingPumpEnd = function()
	if Lobby.Timer.lobbyTimer == nil then
		return true
	else
		Lobby.MapVote.Hide()
		Lobby.Timer.Clear(false)
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.TestingPumpEnd: Kill lobby timer.\n")
		return true
	end
end
Lobby.Timer.TestingPumpClient = function(f41_arg0)
	local f41_local0 = f41_arg0.controller
	local f41_local1 = f41_arg0.lobbyType
	local f41_local2 = f41_arg0.status
	local f41_local3 = f41_arg0.statusValue
	local f41_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus")
	local f41_local5 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTimeRemaining")
	local f41_local6 = 0
	if f41_local2 ~= Lobby.Timer.LOBBY_STATUS.STARTING then
		Lobby.Timer.lastValue = 0
	end
	Lobby.MapVote.ShowLockedIn()
	if f41_local2 == Lobby.Timer.LOBBY_STATUS.IDLE then
		Engine[0x83C9B5DE1D9371](f41_local4, "")
	elseif f41_local2 == Lobby.Timer.LOBBY_STATUS.STARTING then
		if f41_local3 > 0 then
			Engine[0x83C9B5DE1D9371](f41_local4, Engine[0xF9F1239CFD921FE](0x3938FD7959AB087, f41_local3))
			f41_local6 = f41_local3
		else
			Engine[0x83C9B5DE1D9371](f41_local4, "")
		end
		Lobby.Timer.ClientPlaySoundAndUpdateTime(f41_local3)
	end
	Engine[0x83C9B5DE1D9371](f41_local5, f41_local6)
end
Lobby.Timer.NonePump = function() end
Lobby.Timer.NonePumpEnd = function()
	Lobby.Timer.Clear(false)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.NonePumpEnd: Kill lobby timer.\n")
	return true
end
Lobby.Timer.NonePumpClient = function(f44_arg0) end
Lobby.Timer.UpdateLobbyStatusInfo = function(f45_arg0)
	local f45_local0 = f45_arg0.controller
	local f45_local1 = f45_arg0.lobbyType
	local f45_local2 = f45_arg0.status
	local f45_local3 = f45_arg0.statusValue
	local f45_local4 = f45_arg0.statusValue
	if Engine[0xEA2BE00F49480D](f45_local1) then
		return
	end
	local f45_local5 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
	local f45_local6 = f45_local5[0x558B67A321D1120]
	if f45_local6 == LuaEnum.TIMER_TYPE.NONE then
	elseif f45_local6 == LuaEnum.TIMER_TYPE.AUTO_CP then
		Lobby.Timer.AutoCPPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.AUTO_MP then
		Lobby.Timer.AutoMPPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.AUTO_ZM then
		Lobby.Timer.AutoZMPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.MANUAL then
		Lobby.Timer.ManualPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.MANUAL_CP then
		Lobby.Timer.ManualCPPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.READYUP then
		Lobby.Timer.ManualPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.THEATER then
		Lobby.Timer.ManualPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.AUTO_WZ then
		Lobby.Timer.AutoWZPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.AUTO_MP_ARENA then
		Lobby.Timer.AutoMPArenaPumpClient(f45_arg0)
	elseif f45_local6 == LuaEnum.TIMER_TYPE.TESTING then
		Lobby.Timer.TestingPumpClient(f45_arg0)
	end
end
Lobby.Timer.HostingLobby = function(f46_arg0)
	local f46_local0 = f46_arg0.controller
	local f46_local1 = f46_arg0.lobbyType
	local f46_local2 = f46_arg0.mainMode
	local f46_local3 = f46_arg0.lobbyTimerType
	local f46_local4 = f46_arg0.matchEnded
	if f46_local1 ~= Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]) then
		return false
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.HostingLobby: Creating a lobby timer.\n")
	Lobby.Pregame.Shutdown(f46_local0)
	Lobby.Timer.Clear(true)
	Lobby.Timer.lobbyTimer = {}
	Lobby.Timer.lobbyTimer.controller = f46_local0
	Lobby.Timer.lobbyTimer.lobbyType = f46_local1
	Lobby.Timer.lobbyTimer.mainMode = f46_local2
	Lobby.Timer.lobbyTimer.lobbyTimerType = f46_local3
	if LuaUtils.IsArenaPublicGame() and f46_local4 then
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.POST_GAME
	elseif Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and f46_local4 then
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.POST_GAME
	else
		Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.IDLE
	end
	Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
	Lobby.Timer.lobbyTimer.balanceStartTime = 0
	if f46_arg0.status ~= nil then
		if f46_arg0.status == Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED then
			Lobby.Timer.lobbyTimer.status = f46_arg0.status
			Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f46_local1, f46_arg0.status, 0)
		elseif (f46_local3 == LuaEnum.TIMER_TYPE.AUTO_MP or f46_local3 == LuaEnum.TIMER_TYPE.AUTO_MP_ARENA) and f46_arg0.status == Lobby.Timer.LOBBY_STATUS.WAIT_FOR_LOBBY_LOCK then
			local f46_local5 = Dvar[0xDE6892CD84059A5]:get()
			if f46_local3 == LuaEnum.TIMER_TYPE.AUTO_MP and Dvar[0x6F561FFF5826217]:exists() then
				f46_local5 = Dvar[0x6F561FFF5826217]:get()
			end
			Lobby.Timer.lobbyTimer.status = f46_arg0.status
			Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + f46_local5
		elseif f46_arg0.status ~= Lobby.Timer.LOBBY_STATUS.IDLE and f46_arg0.status ~= Lobby.Timer.LOBBY_STATUS.WAIT_FOR_LOBBY_LOCK then
			Lobby.Timer.lobbyTimer.status = f46_arg0.status
			if f46_arg0.status == Lobby.Timer.LOBBY_STATUS.STARTING and f46_arg0.statusValue < 5 then
				f46_arg0.statusValue = Dvar[0xAEDDAFEB3887F37]:get() / 1000
			end
			Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + f46_arg0.statusValue * 1000
			Engine[0x321357761DC3249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f46_local1, f46_arg0.status, f46_arg0.statusValue)
		end
	end
	if f46_local3 == LuaEnum.TIMER_TYPE.NONE then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.NonePump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.NonePumpEnd
	elseif f46_local3 == LuaEnum.TIMER_TYPE.AUTO_CP then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.AutoCPPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.AutoCPPumpEnd
	elseif f46_local3 == LuaEnum.TIMER_TYPE.AUTO_MP then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.AutoMPPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.AutoMPPumpEnd
	elseif f46_local3 == LuaEnum.TIMER_TYPE.AUTO_ZM then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.AutoZMPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.AutoZMPumpEnd
		local f46_local6 = Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]())
		Lobby.Timer.autoZMPumpIsOneMap = true
		if f46_local6 then
			Lobby.Timer.autoZMPumpIsOneMap = #f46_local6.rotationList == 1
		end
		local f46_local7
		if Dvar[0x4264944AA415EC0]:get() ~= true or Lobby.Timer.autoZMPumpIsOneMap ~= false then
			f46_local7 = false
		else
			f46_local7 = true
		end
		if not f46_local7 then
			Lobby.MapVote.ShowLockedIn()
		end
	elseif f46_local3 == LuaEnum.TIMER_TYPE.MANUAL or f46_local3 == LuaEnum.TIMER_TYPE.READYUP or f46_local3 == LuaEnum.TIMER_TYPE.THEATER then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.ManualPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.ManualPumpEnd
	elseif f46_local3 == LuaEnum.TIMER_TYPE.MANUAL_CP then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.ManualCPPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.ManualCPPumpEnd
	elseif f46_local3 == LuaEnum.TIMER_TYPE.AUTO_WZ then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.AutoWZPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.AutoWZPumpEnd
	elseif f46_local3 == LuaEnum.TIMER_TYPE.AUTO_MP_ARENA then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.AutoMPArenaPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.AutoMPArenaPumpEnd
	elseif f46_local3 == LuaEnum.TIMER_TYPE.TESTING then
		Lobby.Timer.lobbyTimer.pumpFunc = Lobby.Timer.TestingPump
		Lobby.Timer.lobbyTimer.endFunc = Lobby.Timer.TestingPumpEnd
	end
	return true
end
Lobby.Timer.HostingLobbyEnd = function(f47_arg0)
	local f47_local0 = f47_arg0.lobbyType
	if Lobby.Timer.lobbyTimer == nil then
		return true
	elseif f47_local0 ~= Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]) then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.HostingLobbyEnd: ending lobby timer. LobbyType: " .. f47_local0 .. " \n")
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatus"), "")
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hideMenusForGameStart"), 0)
	if Lobby.Timer.lobbyTimer.endFunc ~= nil then
		return Lobby.Timer.lobbyTimer.endFunc()
	end
	Lobby.Timer.lobbyTimer.lobbyType = nil
	return true
end
Lobby.Timer.LaunchGame = function(f48_arg0)
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f48_local0 = Lobby.Timer.lobbyTimer.controller
	local f48_local1 = Lobby.Timer.lobbyTimer.lobbyType
	local f48_local2 = Lobby.Timer.lobbyTimer.lobbyTimerType
	Lobby.Timer.lobbyTimer.data = f48_arg0
	if f48_local2 == LuaEnum.TIMER_TYPE.MANUAL or f48_local2 == LuaEnum.TIMER_TYPE.READYUP or f48_local2 == LuaEnum.TIMER_TYPE.THEATER then
		if Lobby.Timer.lobbyTimer.endTime == Lobby.Timer.MATCH_START_INVALID then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Launch Game: setting game timer.\n")
			if Dvar[0x47E7067AF5AA263]:get() and Engine[0x31C19A6AF221CC9](Engine[0x3EAC408F958FF05]()) ~= 0 then
				Lobby.Timer.lobbyTimer.status = Lobby.Timer.LOBBY_STATUS.FIND_DEDICATED_SERVER
				Lobby.Timer.lobbyTimer.endTime = Lobby.Timer.MATCH_START_INVALID
			else
				Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x1A227834B17E155]:get() / 2
			end
			if LuaEnum.TEAM_ASSIGNMENT.AUTO == Engine[0xDBC2AD5002B261B]("teamAssignment") and not LuaUtils.IsArenaMode() and f48_local2 ~= LuaEnum.TIMER_TYPE.THEATER then
				Lobby.TeamSelection.AutoSplitTeam(false)
			end
		end
	elseif f48_local2 == LuaEnum.TIMER_TYPE.MANUAL_CP then
		if Lobby.Timer.lobbyTimer.endTime == Lobby.Timer.MATCH_START_INVALID then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Launch Game: setting CP game timer.\n")
			Lobby.Timer.lobbyTimer.endTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x4832F85F8B2FA6A]:get()
		end
	elseif f48_local2 == LuaEnum.TIMER_TYPE.NONE then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Launch Game: starting game.\n")
		LobbyVM.LaunchGameExec(f48_local0, f48_local1)
		Lobby.Timer.Clear(true)
		Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
	end
end
Lobby.Timer.Pump = function()
	LobbyVM.IngameMonitor()
	if Lobby.Timer.lobbyTimer == nil then
		return
	end
	local f49_local0 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	if not f49_local0 then
		f49_local0 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		if not f49_local0 then
			f49_local0 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			if not f49_local0 then
				f49_local0 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			end
		end
	end
	if Lobby.Timer.lobbyTimer.pumpFunc == nil or Lobby.Timer.lobbyTimer.endFunc == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Timer.Pump: (Lobby.Timer.lobbyTimer.pumpFunc == nil) == " .. LuaUtils.IsNil(Lobby.Timer.lobbyTimer.pumpFunc) .. ", (Lobby.Timer.lobbyTimer.endFunc == nil) == " .. LuaUtils.IsNil(Lobby.Timer.lobbyTimer.endFunc) .. ".\n")
		Lobby.Timer.lobbyTimer.pumpFunc = LuaUtils.IsNil(Lobby.Timer.lobbyTimer.pumpFunc)
		Lobby.Timer.lobbyTimer.endFunc = LuaUtils.IsNil(Lobby.Timer.lobbyTimer.endFunc)
		Lobby.Timer.Clear(true)
		Lobby.Timer.UnlockLobby(Engine[0xA5B9C0111291A8B](), false)
		return
	elseif f49_local0 then
		if Lobby.Timer.lobbyTimer.pumpFunc ~= nil then
			Lobby.Timer.lobbyTimer.pumpFunc()
		end
	elseif Lobby.Timer.lobbyTimer.endFunc ~= nil then
		Lobby.Timer.lobbyTimer.endFunc()
	end
end
