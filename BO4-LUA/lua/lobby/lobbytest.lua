require("x64:53e8db3768fb02a")
require("x64:d0f84a2d7d94ca3")
require("x64:b5d5f7ffe97a9a7")
require("x64:b370b3af9224bd0")
Lobby.Test = {}
Lobby.Test.STATE = {
	NOT_STARTED = 0,
	INITIALIZED = 1,
	IN_PROGRESS = 2,
	FINIHSED = 3,
	ERROR = -1,
}
Lobby.Test.currentTest = {
	name = "",
	startTarget = "",
	stopTarget = "",
	event = {
		name = "",
		data = {
			from = "",
			to = "",
		},
	},
	state = Lobby.Test.STATE.NOT_STARTED,
}
Lobby.Test.gameTimeout = -1
Lobby.Test.gameTimeoutDeadline = -1
Lobby.Test.tests = {}
Lobby.Test.tests.director_online = {
	name = "director_online",
	startTarget = "main",
	events = {
		{
			name = "OnGoForward",
			data = {
				from = "main",
				next = "director",
				to = "director_online",
			},
			stop = true,
		},
	},
}
Lobby.Test.tests.wz_solo = {
	name = "wz_solo",
	startTarget = LuaDefine.isPC and "director_online" or "main",
	gameTimeout = 90,
	events = {
		{
			name = "OnGoForward",
			data = {
				from = "main",
				next = "director",
				to = "director_online",
			},
		},
		{
			name = "OnGoForward",
			data = {
				from = "director_online",
				to = "director_online_wz_public",
				settings = {
					playlistID = 103,
				},
			},
		},
		{
			name = "OnLobbyAsyncMatchmakerStart",
			data = {
				from = "director_online_wz_public",
				to = "director_online_wz_public",
			},
			stop = true,
		},
	},
}
Lobby.Test.tests.mp_public = {
	name = "mp_public",
	startTarget = LuaDefine.isPC and "director_online" or "main",
	events = {
		{
			name = "OnGoForward",
			data = {
				from = "main",
				next = "director",
				to = "director_online",
			},
		},
		{
			name = "OnGoForward",
			data = {
				from = "director_online",
				to = "director_online_mp_public",
				settings = {
					playlistID = 1,
				},
			},
			stop = true,
		},
	},
}
Lobby.Test.PreTargetSettings = function(f1_arg0)
	if f1_arg0.playlistID ~= nil then
		Engine[0xCE25A90DC553200](f1_arg0.playlistID)
	end
end
Lobby.Test.ProcessFunction = function()
	if not Lobby.ProcessQueue.IsQueueEmpty() then
		return
	end
	local f2_local0 = LobbyData.GetCurrentMenuTarget()
	local f2_local1 = f2_local0[0x4BCADBA8E631B86]
	local f2_local2 = Engine[0x9882F293C327557]()
	if Lobby.Test.currentTest.state == Lobby.Test.STATE.NOT_STARTED then
		local f2_local3 = Lobby.Test.tests[Dvar[0x8C6C20B615F01FD]:get()]
		if f2_local3 == nil then
			assert(false)
			Dvar[0x8C6C20B615F01FD]:set("")
			Lobby.Test.currentTest.state = Lobby.Test.STATE.ERROR
			return
		end
		local f2_local4 = 0
		for f2_local8, f2_local9 in ipairs(f2_local3.events) do
			if f2_local3.startTarget == f2_local9.data.from then
				f2_local4 = f2_local8
				break
			end
		end
		if f2_local4 == 0 then
			assert(false)
			Lobby.Test.currentTest.state = Lobby.Test.STATE.ERROR
			return
		end
		f2_local5 = nil
		for f2_local9, f2_local10 in ipairs(f2_local3.events) do
			if f2_local10.stop == true then
				f2_local5 = f2_local10.data.to
				break
			end
		end
		if f2_local5 == nil then
			assert(false)
			Lobby.Test.currentTest.state = Lobby.Test.STATE.ERROR
			return
		elseif f2_local3.gameTimeout == nil then
			Lobby.Test.gameTimeout = -1
			Lobby.Test.gameTimeoutDeadline = -1
		else
			Lobby.Test.gameTimeout = f2_local3.gameTimeout
			Lobby.Test.gameTimeoutDeadline = Engine[0x9D33D652B9B0F3B]() + f2_local3.gameTimeout * 1000
		end
		Lobby.Test.currentTest.name = f2_local3.name
		Lobby.Test.currentTest.startTarget = f2_local3.startTarget
		Lobby.Test.currentTest.stopTarget = nil
		Lobby.Test.currentTest.event = {
			event = "",
			data = {
				from = "",
				to = "",
			},
		}
		Lobby.Test.currentTest.state = Lobby.Test.STATE.INITIALIZED
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyTest '" .. Lobby.Test.currentTest.name .. "' INITIALIZED, start target is '" .. Lobby.Test.currentTest.startTarget .. "', stop target is '" .. f2_local5 .. "' \n")
	end
	if Lobby.Test.currentTest.state == Lobby.Test.STATE.INITIALIZED then
		local f2_local11 = Lobby.Test.tests[Lobby.Test.currentTest.name]
		if f2_local0[0x4BCADBA8E631B86] == Lobby.Test.currentTest.startTarget then
			Lobby.Test.currentTest.state = Lobby.Test.STATE.IN_PROGRESS
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyTest '" .. Lobby.Test.currentTest.name .. "' IN_PROGRESS\n")
		end
	end
	if Lobby.Test.currentTest.state == Lobby.Test.STATE.IN_PROGRESS then
		if f2_local1 == Lobby.Test.currentTest.stopTarget then
			Lobby.Test.currentTest.state = Lobby.Test.STATE.FINISHED
		else
			local f2_local11 = Lobby.Test.tests[Lobby.Test.currentTest.name]
			if f2_local1 == Lobby.Test.currentTest.event.data.from then
			elseif f2_local1 == f2_local11.startTarget or f2_local1 == Lobby.Test.currentTest.event.data.to then
				for f2_local6, f2_local7 in ipairs(f2_local11.events) do
					if f2_local1 == f2_local7.data.from then
						Lobby.Test.currentTest.event = f2_local7
						if f2_local7.stop == true then
							Lobby.Test.currentTest.stopTarget = f2_local7.data.to
						end
						if f2_local7.name == "OnGoForward" then
						else
							if f2_local7.name == "OnLobbyAsyncMatchmakerStart" then
								LobbyVM.OnLobbyAsyncMatchmakerStart({
									controller = 0,
								})
								Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyTest '" .. Lobby.Test.currentTest.name .. "' IN_PROGRESS, starting async mathcmaking from target '" .. f2_local7.data.from .. "' on playlis id '" .. Engine[0x7B3B2B73B53EB34]() .. "'\n")
							end
							Lobby.Test.currentTest.state = Lobby.Test.STATE.IN_PROGRESS
						end
						if f2_local7.data.settings ~= nil then
							Lobby.Test.PreTargetSettings(f2_local7.data.settings)
						end
						local f2_local8 = Lobby.Test.currentTest.event.data.to
						if f2_local7.data.next ~= nil then
							f2_local8 = f2_local7.data.next
						end
						LobbyVM.OnGoForward({
							controller = 0,
							navToMenu = f2_local8,
						})
						Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyTest '" .. Lobby.Test.currentTest.name .. "' IN_PROGRESS, going from target '" .. f2_local7.data.from .. " to target '" .. f2_local7.data.to .. "'\n")
					end
				end
			end
		end
	end
	if Lobby.Test.currentTest.state == Lobby.Test.STATE.FINISHED then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyTest '" .. Lobby.Test.currentTest.name .. "' FINISHED at target '" .. Lobby.Test.currentTest.stopTarget .. "'\n")
		Lobby.Test.currentTest.state = Lobby.Test.STATE.NOT_STARTED
	end
	if Lobby.Test.currentTest.state == Lobby.Test.STATE.ERROR then
		Dvar[0x8C6C20B615F01FD]:set("")
	end
end
Lobby.Test.Pump = function()
	if Engine[0xE39F1F30B306065]() then
		return
	elseif not Engine[0x3CD0351DA0D371](0) then
		return
	elseif not Dvar[0x8C6C20B615F01FD]:exists() or Dvar[0x8C6C20B615F01FD]:get() == "" then
		return
	end
	Lobby.Test.ProcessFunction()
	if Lobby.Test.gameTimeout ~= -1 then
		if Engine[0x7B48C1ABFF0F764]() then
			Lobby.Test.gameTimeoutDeadline = Engine[0x9D33D652B9B0F3B]() + Lobby.Test.gameTimeout * 1000
		elseif Engine[0x9D33D652B9B0F3B]() > Lobby.Test.gameTimeoutDeadline then
			Lobby.Test.currentTest.state = Lobby.Test.STATE.NOT_STARTED
			Lobby.Test.gameTimeout = -1
			Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x2FD312C2C06EC11], "Not in a game for longer than timeout.")
		end
	end
end
Lobby.Test.OnInit = function() end
