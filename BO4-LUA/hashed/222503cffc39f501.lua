require("x64:53e8db3768fb02a")
require("x64:2f7767db3f402c")
Lobby.PartyPrivacy = {}
Lobby.PartyPrivacy.checkTime = 0
Lobby.PartyPrivacy.ON_SESSION_START_RECHECK_TIME = 500
Lobby.PartyPrivacy.GetGameLobbyPartyPrivacy = function()
	local f1_local0 = Engine[0x9882F293C327557]()
	if f1_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f1_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f1_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) then
		return Engine[0xB72F603CAC75B3A](Engine[0xA5B9C0111291A8B](), "party_privacyStatus")
	elseif Engine[0x293941FE17453F1]() then
	elseif Engine[0x32ABAFDCA93FDF9]() then
		if Engine[0x8BF601ABD141DF9]() and Engine[0xB2BAD8AD577224E](Engine[0x7B3B2B73B53EB34]()) == 1 then
			return Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5]
		elseif LuaUtils.IsArenaMode() then
			if ((Engine[0xDBC2AD5002B261B]("pregameItemVoteEnabled") == 1) or Engine[0xDBC2AD5002B261B]("pregameDraftEnabled") == 1) and Engine[0x8BF601ABD141DF9]() and (not Engine[0x95D8A0296E9E574]() or Engine[0x7B48C1ABFF0F764]() or Lobby.Launch.IsHostLaunching()) then
				return Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5]
			elseif Lobby.Timer.LobbyIsLocked() then
				return Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5]
			end
		end
	elseif Engine[0x8EF5BEFA0AE50FE]() then
		if not Lobby.Launch.IsHostLaunching() and not Engine[0x7B48C1ABFF0F764]() and not Engine[0x95D8A0296E9E574]() then
		end
	elseif Engine[0x56B4618D857143D]() and (Lobby.Launch.IsHostLaunching() or Engine[0x7B48C1ABFF0F764]() or not Engine[0x95D8A0296E9E574]()) then
		return Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5]
	end
	if CoDShared.IsInTheaterLobby() then
		return Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5]
	end
	return Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
end
Lobby.PartyPrivacy.SetPartyPrivacy = function()
	local f2_local0 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	local f2_local1 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	local f2_local2 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f2_local3 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f2_local4 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
	local f2_local5 = Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
	local f2_local6 = Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
	if f2_local0 then
		f2_local5 = Engine[0xB72F603CAC75B3A](Engine[0xA5B9C0111291A8B](), "party_privacyStatus")
		Engine[0x9455799AABED509](Enum[0xBF54BE1BB3D618B][0xA1647599284110], f2_local5)
	elseif f2_local1 then
		f2_local5 = Engine[0x4B4BED5E64B382D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	end
	if f2_local2 then
		f2_local6 = Lobby.PartyPrivacy.GetGameLobbyPartyPrivacy()
		Engine[0x9455799AABED509](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f2_local6)
	elseif f2_local3 then
		f2_local6 = Engine[0x4B4BED5E64B382D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	end
	local f2_local7 = math.max(f2_local5, f2_local6)
	Engine[0x93463CC672F16E7](f2_local7)
	local f2_local8 = LobbyData.PartyPrivacyToString(f2_local7)
	local f2_local9 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "PartyPrivacy")
	if f2_local9 then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f2_local9, "privacy"), f2_local7)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f2_local9, "privacyStatus"), f2_local8)
	end
end
Lobby.PartyPrivacy.IsPrivateGameLobby = function(f3_arg0)
	local f3_local0 = f3_arg0[0x8B72E07B55C3AC0]
	if f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM) then
		return true
	else
		return false
	end
end
Lobby.PartyPrivacy.SetLobbyMaxClients = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f4_arg1)
	local f4_local1 = Dvar[0x4FF45B41C6046F8]:get()
	if f4_arg2 == nil then
		f4_arg2 = LobbyData.GetCurrentMenuTarget()
	end
	if Lobby.PartyPrivacy.IsPrivateGameLobby(f4_arg2) then
		f4_local1 = f4_local0
	end
	local f4_local2 = math.min(math.max(1, f4_local1), f4_local0)
	Dvar[0x4FF45B41C6046F8]:set(f4_local2)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "PartyPrivacy"), "maxPlayers"), f4_local2)
end
Lobby.PartyPrivacy.OnSessionStart = function(f5_arg0)
	local f5_local0 = f5_arg0.lobbyModule
	local f5_local1 = f5_arg0.lobbyType
	local f5_local2 = f5_arg0.lobbyMode
	if Dvar[0xE52CB4B7B32961A]:get() == false then
		return
	elseif Engine[0xE39F1F30B306065]() == true or f5_local0 ~= Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE97D54588ADFFD1] or Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
		return
	end
	local f5_local3 = Engine[0xA5B9C0111291A8B]()
	local f5_local4 = Engine[0xB72F603CAC75B3A](f5_local3, "party_privacyStatus")
	if f5_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and (f5_local2 == Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9] or f5_local2 == Enum[0x8409AA0F01B5DBC][0xD42D003CEEA3F87]) then
		f5_local4 = Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
	else
		Lobby.PartyPrivacy.SetLobbyMaxClients(f5_local3, f5_local1)
	end
	f5_local4 = math.min(math.max(Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9], f5_local4), Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5])
	Engine[0x9455799AABED509](f5_local1, f5_local4)
	local f5_local5 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "PartyPrivacy")
	local f5_local6 = LobbyData.PartyPrivacyToString(f5_local4)
	if f5_local5 then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f5_local5, "privacyStatus"), f5_local6)
	end
	Lobby.PartyPrivacy.checkTime = Lobby.PartyPrivacy.ON_SESSION_START_RECHECK_TIME + Engine[0x9D33D652B9B0F3B]()
end
Lobby.PartyPrivacy.OnJoinPartyPrivacyCheck = function(f6_arg0)
	local f6_local0 = f6_arg0.lobbyType
	local f6_local1 = f6_arg0.joinType
	local f6_local2 = f6_arg0.fromXuid
	if f6_local1 == Enum[0xC018C5F55467EB1][0x9707B48B88781B9] or f6_local1 == Enum[0xC018C5F55467EB1][0x1375971BA46DA71] then
		return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
	else
		local f6_local3 = Engine[0xB4EEE57E45369DB]()
		if f6_local3 == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Rejecting join request from xuid(" .. tostring(f6_local2) .. ") because we are not joinable, session party privacy is closed.\n")
			return Enum[0x2E4144AA1C3ABB8][0x65D30E028BCE71F]
		elseif f6_local3 == Enum[0x70DC6CE53EF2D31][0x2507221A765592F] and f6_local1 ~= Enum[0xC018C5F55467EB1][0xD4D58772DE8652] then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Rejecting join request from xuid(" .. tostring(f6_local2) .. ") because we are not joinable, session party privacy is invite only.\n")
			return Enum[0x2E4144AA1C3ABB8][0x6DCFF2389FEAED5]
		elseif f6_local3 == Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221] and f6_local1 ~= Enum[0xC018C5F55467EB1][0xD4D58772DE8652] then
			if f6_local1 == Enum[0xC018C5F55467EB1][0xC21E48130C4B82B] and Engine[0x3176B986956D1B3](Engine[0xA5B9C0111291A8B](), f6_local2) then
				return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
			else
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Rejecting join request from xuid(" .. tostring(f6_local2) .. ") because we are not joinable, session party privacy is friends only.\n")
				return Enum[0x2E4144AA1C3ABB8][0xBC432169BFCDE7B]
			end
		else
			return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
		end
	end
end
Lobby.PartyPrivacy.OnGametypeSettingsChange = function(f7_arg0)
	local f7_local0 = f7_arg0.lobbyModule
	local f7_local1 = f7_arg0.lobbyType
	local f7_local2 = Engine[0x9882F293C327557]()
	if (f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM)) and f7_arg0.fromUI == true then
		local f7_local3 = Engine[0xDBC2AD5002B261B]("allowSpectating") == 1
		local f7_local4 = LobbyData.GetCurrentLobbySizes()
		local f7_local5 = Engine[0xDBC2AD5002B261B]("maxPlayers")
		if f7_local3 then
			f7_local5 = f7_local5 + f7_local4.maxCoDcasterClients or f7_local5
		end
		Engine[0x41D81D6B58AAF3F](f7_local1, f7_local5)
	end
end
Lobby.PartyPrivacy.Pump = function()
	if Dvar[0xE52CB4B7B32961A]:get() == false or Dvar[0xFF3E7BFBD5CE85C]:get() == false then
		return
	elseif Lobby.PartyPrivacy.checkTime > Engine[0x9D33D652B9B0F3B]() then
		return
	else
		Lobby.PartyPrivacy.checkTime = Dvar[0xC018601EF2EA99A]:get() + Engine[0x9D33D652B9B0F3B]()
		Lobby.PartyPrivacy.SetPartyPrivacy()
	end
end
