require("x64:53e8db3768fb02a")
Lobby.Hopper = {}
Lobby.Hopper.lobbyHopper = nil
Lobby.Hopper.HOPPER_STATE = {
	PARKED = 0,
	UNPARKED = 1,
}
Lobby.Hopper.hopperState = Lobby.Hopper.HOPPER_STATE.UNPARKED
Lobby.Hopper.UpdateLobbyData = function(f1_arg0, f1_arg1)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return 1
	end
	local f1_local0 = 1
	local f1_local1 = LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC
	local f1_local2 = Engine[0x31C19A6AF221CC9](Engine[0x3EAC408F958FF05]())
	if f1_local2 == f1_arg0 then
		f1_local1 = LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM
	end
	local f1_local3 = LobbyData.GetLobbyMenuByName(f1_local1)
	if f1_local2 == f1_arg0 then
		if f1_arg1 ~= nil then
			Engine[0xDC3983C70B75088](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f1_arg1)
		end
		Lobby.Timer.SetDedicatedDelayedCMD(Lobby.Timer.LOBBY_DEDICATED_CMD.INVALID_CMD)
		f1_local0 = 2
	end
	Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Updating Lobby Data for Target: " .. f1_local3[0x4BCADBA8E631B86] .. "\n")
	LobbyVM.OnLobbySettings({
		toTarget = f1_local3,
		skipSwitchMode = true,
		isDevMap = false,
	})
	LobbyVM.OnUpdateUI({
		toTarget = f1_local3,
	})
	local f1_local4 = 0
	if f1_arg0 then
		Lobby.Timer.HostingLobby({
			controller = f1_local4,
			lobbyType = f1_local3[0xBF54BE1BB3D618B],
			mainMode = f1_local3[0xEB7DDC7F079D51B],
			lobbyTimerType = f1_local3[0x558B67A321D1120],
		})
	else
		Lobby.Timer.HostingLobbyEnd({
			lobbyType = f1_local3[0xBF54BE1BB3D618B],
		})
		Lobby.Pregame.Clear()
	end
	return f1_local0
end
Lobby.Hopper.OnClientJoin = function(f2_arg0)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return 1
	elseif Engine[0xE39F1F30B306065]() == false then
		return 1
	end
	local f2_local0 = f2_arg0.clientPlaylist
	if f2_local0 == 255 then
		return 1
	end
	local f2_local1 = Engine[0x6D46FF33D97B908](f2_local0)
	local f2_local2 = Engine[0x7B3B2B73B53EB34]()
	local f2_local3 = 1
	if Lobby.Hopper.HOPPER_STATE.PARKED == Lobby.Hopper.hopperState then
		if f2_local2 ~= f2_local1 then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Rejecting client because they want playlist " .. f2_local1 .. " but we're on parkingplaylist " .. f2_local2 .. " for playlist " .. f2_local2 .. "\n")
			f2_local3 = 0
		else
			f2_local3 = Lobby.Hopper.UpdateLobbyData(f2_local0, f2_arg0.leaderXuid)
			Lobby.Launch.HostLaunchClear()
			Engine[0xE7E0FF664B7D7BF](f2_arg0.dlcBits)
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Unparking onto playlist " .. f2_local0 .. "\n")
			Engine[0x3933ED935F64F94](f2_local0)
			Lobby.Matchmaking.UpdateLatencyBand()
			Engine[0xCE25A90DC553200](f2_local0)
			LuaUtils.SetQuickplayPlaylistID(f2_local0)
			Dvar[0x5B789559A59177]:set(f2_local0)
			Dvar[0xA96CE8EF5319D80]:set(Lobby.Matchmaking.GetMapPackBits(f2_arg0.dlcBits, f2_local0))
			Engine[0x41D81D6B58AAF3F](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Dvar[0x96545C72F0E4FE4]:get())
			Lobby.Matchmaking.SetSkillWeight(0.01)
			Lobby.Matchmaking.UpdateAdvertising(" hopper unpark ")
			Lobby.Hopper.hopperState = Lobby.Hopper.HOPPER_STATE.UNPARKED
		end
	elseif Lobby.Hopper.HOPPER_STATE.UNPARKED == Lobby.Hopper.hopperState and f2_local0 ~= 255 and f2_local0 ~= f2_local2 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Rejecting client because they want playlist " .. f2_local0 .. " but we're unparked on playlist " .. f2_local2 .. "\n")
		f2_local3 = 0
	end
	return f2_local3
end
Lobby.Hopper.OnSessionEnd = function(f3_arg0)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return
	end
	local f3_local0 = f3_arg0.lobbyModule
	local f3_local1 = f3_arg0.lobbyType
	local f3_local2 = f3_arg0.lobbyMode
	if f3_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
		Engine[0xBBB5B39E4BA37EB]("old", true)
	end
end
Lobby.Hopper.Pump = function()
	if Engine[0xE39F1F30B306065]() == false then
		return
	elseif false == Dvar[0x8827F6EDED32B08]:get() then
		return
	elseif Dvar[0x4BADE8473F0165F]:get() == true then
		return
	elseif Dvar[0xB852BA138B9853A]:exists() == true and Dvar[0xB852BA138B9853A]:get() == true then
		return
	elseif Dvar[0xE2390D9E82B6369]:get() == true and Dvar[0x4CE6DE7EC1A56FE]:get() == true then
		return
	elseif Lobby.Hopper.HOPPER_STATE.UNPARKED == Lobby.Hopper.hopperState then
		if Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F]) == 0 and not Engine[0xDFE2D4D623AD782](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) and false == Dvar[0x4A8CF2E4D0E6736]:get() and Dvar[0xDD6A5A551E5E17E]:get() == 0 then
			local f4_local0 = Engine[0x7B3B2B73B53EB34]()
			local f4_local1 = Engine[0x6D46FF33D97B908](f4_local0)
			if f4_local1 ~= 0 then
				Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "No clients left and we're currently on playlist " .. f4_local0 .. " - parking on playlist " .. f4_local1 .. "\n")
				Lobby.Hopper.hopperState = Lobby.Hopper.HOPPER_STATE.PARKED
				Lobby.Hopper.UpdateLobbyData()
				Dvar[0x686027EBE0C93F5]:set(0)
				Dvar[0x5B789559A59177]:set(f4_local1)
				Dvar[0xA96CE8EF5319D80]:set(Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS)
				Dvar[0xE5350E8F7BD556]:set(1)
				Lobby.Matchmaking.UpdateAdvertising("hopper park")
				Engine[0x3933ED935F64F94](f4_local1)
				Engine[0xCE25A90DC553200](f4_local1)
				LuaUtils.SetQuickplayPlaylistID(f4_local1)
				if Dvar[0xE2390D9E82B6369]:get() == true then
					Dvar[0x4CE6DE7EC1A56FE]:set(true)
				end
			end
		end
	elseif Lobby.Hopper.HOPPER_STATE.PARKED == Lobby.Hopper.hopperState then
	else
	end
end
Lobby.Hopper.OnIsParked = function()
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return false
	else
		return Lobby.Hopper.HOPPER_STATE.PARKED == Lobby.Hopper.hopperState
	end
end
