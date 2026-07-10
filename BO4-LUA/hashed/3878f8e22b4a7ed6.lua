require("x64:53e8db3768fb02a")
Lobby.Launch = {}
Lobby.Launch.hostLaunch = {}
Lobby.Launch.clientLaunch = {}
Lobby.Launch.printInterval = 5000
Lobby.Launch.IsHostLaunching = function()
	if Lobby.Launch.hostLaunch.startTime ~= nil then
		return true
	elseif Engine[0x9380E261FDE8943] and Engine[0x9380E261FDE8943]() then
		return true
	else
		return false
	end
end
Lobby.Launch.OnHostLaunch = function(f2_arg0)
	if f2_arg0.stage == Enum[0x7AFA704A2443BB1][0xB9EF0D7A2C75AE4] then
		return Lobby.Launch.HostLaunchInit()
	elseif f2_arg0.stage == Enum[0x7AFA704A2443BB1][0x9ED8070AD1A739A] then
		return Lobby.Launch.HostLaunchPump(f2_arg0)
	else
		Engine[0x141E84ACAAE0A4E]()
		return Lobby.Launch.HostLaunchClear()
	end
end
Lobby.Launch.HostLaunchInit = function()
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.closePopups"))
	Lobby.Launch.hostLaunch = {}
	Lobby.Launch.hostLaunch.fadeToBlack = false
	local f3_local0 = Engine[0x9D33D652B9B0F3B]()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hideMenusForGameStart"), 1)
	Lobby.Launch.hostLaunch.startTime = f3_local0
	Lobby.Launch.hostLaunch.printAtTime = f3_local0 + Lobby.Launch.printInterval
	Lobby.Launch.hostLaunch.fadeToBlackTime = f3_local0 + Dvar[0xF6674CAE730AA08]:get()
	Lobby.Launch.hostLaunch.launchTime = f3_local0 + Dvar[0xAC3D72F21D83F1B]:get()
	Lobby.Launch.hostLaunch.waitForClientAckTime = f3_local0 + Dvar[0xE0639684531C4C8]:get()
	Lobby.Timer.ResetUIModel()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), true)
	return true
end
Lobby.Launch.MapImagePreloading = function(f4_arg0)
	local f4_local0 = false
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		if (Engine[0x44FC97037CE42ED](f4_arg0, Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]), Enum[0x575E471C039DBD6][0x92BC25E18D296F]) or 0) <= 1 and Engine[0x69811927938FCD7]() ~= "ztutorial" then
			f4_local0 = false
		else
			f4_local0 = true
		end
	end
	local f4_local1 = Engine[0xC53F8D38DF9042B](Engine[0xE67E7253CC272C9]())
	local f4_local2
	if not f4_local0 then
		f4_local2 = LuaUtils.GetMapsTable()
		f4_local2 = f4_local2[f4_local1]
		if f4_local2 then
			f4_local2 = LuaUtils.GetMapsTable()
			f4_local2 = f4_local2[f4_local1].introMovie
		end
	else
		f4_local2 = false
	end
	if f4_local2 then
		return false
	end
	local f4_local3 = LuaUtils.GetMapsTable()
	f4_local3 = f4_local3[f4_local1]
	if f4_local3 then
		f4_local3 = LuaUtils.GetMapsTable()
		f4_local3 = f4_local3[f4_local1].loadingImage
	end
	if f4_local3 and not Engine[0x8A31148EE1BE3B1](f4_local3) then
		return true
	end
	return false
end
Lobby.Launch.HostLaunchPump = function(f5_arg0)
	local f5_local0 = Engine[0x9882F293C327557]()
	if f5_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) then
		local f5_local1 = false
		local f5_local2 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F])
		if f5_local2 < Dvar[0x500E4DB2F10F5EE]:get() then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Launch.LaunchGameExec: Not enough players (" .. tostring(f5_local2) .. "/" .. tostring(Dvar[0x500E4DB2F10F5EE]:get()) .. "), restart timer.\n")
			f5_local1 = true
		end
		if CoDShared.IsGametypeTeamBased() == true and Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			local f5_local3 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
			if f5_local3 ~= nil then
				local f5_local4 = 0
				local f5_local5 = 0
				for f5_local9, f5_local10 in ipairs(f5_local3.sessionClients) do
					if f5_local10.team == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
						f5_local4 = f5_local4 + 1
					end
					if f5_local10.team == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
						f5_local5 = f5_local5 + 1
					end
				end
				if math.abs(f5_local4 - f5_local5) > 1 then
					Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.Launch.LaunchGameExec: Teams are not balanced (teamAlliesCount: " .. tostring(f5_local4) .. "/teamAxisCount: " .. tostring(f5_local5) .. "), restart timer.\n")
					f5_local1 = true
				end
			end
		end
		if Engine[0x2DA54CF5D6B7F02]() and Engine[0x9E5BE3B4BBA4E0E]("lobby_forceBalanced") == true then
			f5_local1 = false
		end
		if f5_local1 == true then
			Engine[0xB972AE22481F1]()
			Lobby.Launch.HostLaunchClear()
			local f5_local3 = LobbyData.GetLobbyMenuByID(f5_local0)
			Lobby.Timer.HostingLobby({
				controller = Engine[0xA5B9C0111291A8B](),
				lobbyType = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43],
				mainMode = f5_local3[0xEB7DDC7F079D51B],
				lobbyTimerType = f5_local3[0x558B67A321D1120],
				matchEnded = true,
				status = Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED,
			})
			return false
		end
	end
	if Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive")) == false then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), true)
	end
	if not f5_arg0.hasAllClientsGotLatestStateMsg and Engine[0x9D33D652B9B0F3B]() < Lobby.Launch.hostLaunch.waitForClientAckTime then
		return false
	elseif not Engine[0xE39F1F30B306065]() then
		if Lobby.Launch.MapImagePreloading(Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]) then
			return false
		elseif not Engine[0x84EC6E8823F03A9]() then
			local f5_local1 = Engine[0x9D33D652B9B0F3B]()
			if f5_local1 > Lobby.Launch.hostLaunch.printAtTime then
				Lobby.Launch.hostLaunch.printAtTime = f5_local1 + Lobby.Launch.printInterval
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Waiting for common FF \n")
			end
			return false
		end
	end
	if Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		Engine[0xEFF9EC55782EDB](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]))
	end
	return true
end
Lobby.Launch.HostLaunchClear = function()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hideMenusForGameStart"), 0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), false)
	Lobby.Launch.hostLaunch.startTime = nil
	return true
end
Lobby.Launch.OnClientLaunch = function(f7_arg0)
	if f7_arg0.stage == Enum[0x7AFA704A2443BB1][0xB9EF0D7A2C75AE4] then
		return Lobby.Launch.ClientLaunchInit(f7_arg0.justConnected)
	elseif f7_arg0.stage == Enum[0x7AFA704A2443BB1][0x9ED8070AD1A739A] then
		return Lobby.Launch.ClientLaunchPump()
	else
		Engine[0x141E84ACAAE0A4E]()
		return Lobby.Launch.ClientLaunchClear()
	end
end
Lobby.Launch.ClientLaunchInit = function(f8_arg0)
	if not LobbyVM.CanClientLaunch(f8_arg0) then
		return false
	end
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.closePopups"))
	Lobby.Launch.clientLaunch = {}
	Lobby.Launch.clientLaunch.fadeToBlack = false
	local f8_local0 = Dvar[0xF6674CAE730AA08]:get()
	local f8_local1 = Dvar[0xAC3D72F21D83F1B]:get()
	if f8_arg0 then
		f8_local0 = Dvar[0xCD73B6D54F107A5]:get()
		f8_local1 = Dvar[0x8663791C854DEC4]:get()
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hideMenusForGameStart"), 1)
	local f8_local2 = Engine[0x9D33D652B9B0F3B]()
	Lobby.Launch.clientLaunch.startTime = f8_local2
	Lobby.Launch.clientLaunch.fadeToBlackTime = f8_local2 + f8_local0
	Lobby.Launch.clientLaunch.launchTime = f8_local2 + f8_local1
	Lobby.Launch.clientLaunch.printAtTime = f8_local2 + Lobby.Launch.printInterval
	Lobby.Timer.ResetUIModel()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), true)
	return true
end
Lobby.Launch.ClientLaunchPump = function()
	if Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive")) == false then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), true)
	end
	if false == Lobby.Launch.clientLaunch.fadeToBlack and Engine[0x9D33D652B9B0F3B]() > Lobby.Launch.clientLaunch.fadeToBlackTime then
		Lobby.Launch.clientLaunch.fadeToBlack = true
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hideMenusForGameStart"), 1)
	end
	if Lobby.Launch.MapImagePreloading(Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]) then
		return false
	elseif Lobby.Launch.clientLaunch.launchTime ~= nil and Engine[0x9D33D652B9B0F3B]() < Lobby.Launch.clientLaunch.launchTime then
		return false
	elseif not Engine[0x84EC6E8823F03A9]() then
		local f9_local0 = Engine[0x9D33D652B9B0F3B]()
		if f9_local0 > Lobby.Launch.clientLaunch.printAtTime then
			Lobby.Launch.clientLaunch.printAtTime = f9_local0 + Lobby.Launch.printInterval
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Client Waiting for common FF \n")
		end
		return false
	elseif 1 == Dvar[0xF1DE3CEF5A9E0DB]:get() and LuaUtils.IsArenaPublicGame() then
		Engine[0x8587B36B7F8EF5](Engine[0xA5B9C0111291A8B](), Enum[0xDB66542051E7C15][0x8D8FC5F8CDC337F])
	end
	return true
end
Lobby.Launch.ClientLaunchClear = function()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hideMenusForGameStart"), 0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), false)
	return true
end
