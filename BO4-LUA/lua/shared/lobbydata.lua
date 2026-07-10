require("x64:401e59513e41da9")
require("x64:b5d5f7ffe97a9a7")
require("x64:c6e3b538b3d95e3")
local f0_local0 = {}
local f0_local1 = {}
local f0_local2 = {
	Action = "action",
	LobbyClosed = "uin_lobby_closed",
	ClientsAddedToLobby = "uin_lobby_enter",
	ClientsRemovedFromLobby = "uin_lobby_exit",
	TimerTick = "uin_timer",
	ESportsTimerTick = "uin_timer_esports_beep",
	ESportsTimerTickLast = "uin_timer_esports_last_beep",
}
f0_local0.InitMenusIndexTable = function()
	f0_local1 = {}
	for f1_local8, f1_local9 in pairs({
		0x51BB4F2EDE86F4C,
		0x262C7CA0E318854,
		0x276CBCA0E42382A,
		0x295ACCA0E5CB40C,
		0x2BAB9CA0E7BE660,
		0x41F5DBFEF6844A6,
		0xDAE12D7F3029A24,
		0x9F8B20FBABFED4B,
		0xF4F713EF679C9BC,
	}) do
		local f1_local10 = Engine[0xA7E3CD65E63086F](f1_local9)
		if f1_local10 then
			for f1_local6, f1_local7 in pairs(f1_local10) do
				f0_local1[f1_local7[0x8B72E07B55C3AC0]] = f1_local7[0x4BCADBA8E631B86]
			end
		end
	end
end
f0_local0.InitMenusIndexTable()
f0_local0.InitLobbyNav = function()
	local f2_local0 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.MAIN)
	local f2_local1 = Engine[0x8DF2E5447F384B9]()
	f2_local1 = f2_local1:create("lobbyRoot", true)
	local f2_local2 = f2_local1:create("lobbyNav", true)
	f2_local2:set(f2_local0[0x8B72E07B55C3AC0])
	f2_local2 = f2_local1:create("room", true)
	f2_local2:set(f2_local0[0x355141FF0C48EDA])
	f2_local2 = f2_local1:create("fullscreenBlackCount", true)
	f2_local2:set(0)
	f2_local2 = f2_local1:create("rankMode", true)
	f2_local2:set(Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE])
	f2_local2 = f2_local1:create("theaterDataDownloaded")
	f2_local2:set(false)
	f2_local2 = f2_local1:create("theaterDownloadPercent")
	f2_local2:set(0)
	f2_local2 = f2_local1:create("entitlementsUpdated", true)
	f2_local2:set(false)
	if LUI then
		CoD.MetricsUtility.LobbyInit()
	end
end
f0_local0.GetLobbyNavModel = function()
	return Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav")
end
f0_local0.GetLobbyNav = function()
	return Engine[0x614D394F6F9A18D](f0_local0.GetLobbyNavModel())
end
f0_local0.GetCurrentMenuTarget = function()
	return LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
end
f0_local0.GetLobbyMenuByName = function(f6_arg0)
	if f6_arg0 == "director" then
		return {
			[0x4BCADBA8E631B86] = "director",
			[0x8B72E07B55C3AC0] = 9999,
		}
	else
		return Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f6_arg0))
	end
end
f0_local0.GetLobbyMenuIDByName = function(f7_arg0)
	local f7_local0 = LobbyData.GetLobbyMenuByName(f7_arg0)
	return f7_local0 and f7_local0[0x8B72E07B55C3AC0]
end
f0_local0.GetLobbyMenuByID = function(f8_arg0)
	local f8_local0 = f0_local1[f8_arg0]
	if f8_local0 == nil then
		return nil
	else
		return LobbyData.GetLobbyMenuByName(f8_local0)
	end
end
f0_local0.SetLobbyNav = function(f9_arg0)
	local f9_local0 = f0_local0.GetLobbyNavModel()
	if not f9_local0 then
		f0_local0.InitLobbyNav()
		f9_local0 = f0_local0.GetLobbyNavModel()
	end
	local f9_local1 = Engine[0x614D394F6F9A18D](f9_local0)
	local f9_local2
	if f9_arg0[0x8B72E07B55C3AC0] ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) or f9_local1 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		f9_local2 = false
	else
		f9_local2 = true
	end
	if f9_local2 then
		Lobby.Arena.OnNavToArenaPregame()
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "LobbyData.SetLobbyNav. From: " .. tostring(f9_local1) .. " To: " .. tostring(f9_arg0[0x8B72E07B55C3AC0]) .. "\n")
	Engine[0x83C9B5DE1D9371](f9_local0, f9_arg0[0x8B72E07B55C3AC0])
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyTitle"), f9_arg0[0xA31296C0C1B6029])
	local f9_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerMode")
	local f9_local4 = Engine[0x83C9B5DE1D9371]
	local f9_local5 = f9_local3
	if f9_arg0[0x53DACF8EE94B654] then
		local f9_local6 = f9_arg0[0x53DACF8EE94B654]
		local f9_local7 = Engine[0xF9F1239CFD921FE](f9_arg0[0x53DACF8EE94B654])
	end
	f9_local4(f9_local5, f9_local6 and f9_local7 or "")
	Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerText")
end
f0_local0.GetCurrentLobbySizes = function(f10_arg0)
	local f10_local0 = Engine[0x9882F293C327557]()
	local f10_local1 = LobbyData.GetLobbyMenuByID(f10_local0)
	local f10_local2 = Engine[0x29B25E8DA873863](Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f10_local1[0xBF54BE1BB3D618B]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f10_local1[0xBF54BE1BB3D618B])
	if f10_arg0 == true then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Current Lobby Sizes (" .. f10_local1[0x4BCADBA8E631B86] .. ", ID " .. tostring(f10_local0) .. "):" .. " maxClients(" .. tostring(f10_local1[0xEE71E4EE12BC453]) .. "), maxLaunchClients(" .. tostring(f10_local1[0x4A523F3AE5C68D6]) .. "), maxCoDcasterClients(" .. tostring(f10_local1[0x2BF14968131BE83]) .. "), maxLocalClients(" .. tostring(f10_local1[0x6D8502BDC7A4868]) .. "), maxLocalClientsNetwork(" .. tostring(f10_local1[0xC45968D6338650E]) .. "), maxClientsSession(" .. tostring(f10_local2) .. ").\n")
	end
	return {
		maxClients = f10_local1[0xEE71E4EE12BC453],
		maxLaunchClients = f10_local1[0x4A523F3AE5C68D6],
		maxCoDcasterClients = f10_local1[0x2BF14968131BE83],
		maxLocalClients = f10_local1[0x6D8502BDC7A4868],
		maxLocalClientsNetwork = f10_local1[0xC45968D6338650E],
		maxClientsSession = f10_local2,
	}
end
f0_local0.PartyPrivacyToString = function(f11_arg0)
	local f11_local0 = 0x980DDEA2FD1615B
	if f11_arg0 == Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9] then
		f11_local0 = 0xD7568CAE1BE3F6B
	elseif f11_arg0 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] then
		f11_local0 = 0xD5B11C63C41C427
	elseif f11_arg0 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] then
		f11_local0 = 0x4D4EA9B2703EF9
	elseif f11_arg0 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		f11_local0 = 0x980DDEA2FD1615B
	end
	return Engine[0xF9F1239CFD921FE](f11_local0)
end
f0_local0.ButtonStates_ReevaluateDisabledState = function()
	local f12_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "ButtonStates.ReevaluateDisabledStates")
	if f12_local0 then
		Engine[0x83C9B5DE1D9371](f12_local0, not Engine[0x614D394F6F9A18D](f12_local0))
	end
end
f0_local0.Sounds = LuaReadOnlyTables.ReadOnlyTable(f0_local2)
LobbyData = LuaReadOnlyTables.ReadOnlyTable(f0_local0)
