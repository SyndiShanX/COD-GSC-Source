require("x64:c71b3cf9012e5dd")
require("x64:b370b3af9224bd0")
require("x64:127dca51df8f7c7")
require("x64:85d6d26960f9bae")
require("x64:75e553bec904d39")
local f0_local0 = {}
local f0_local1 = {}
f0_local0.GetMapsTable = function()
	if not f0_local0.mapsTable then
		f0_local0.mapsTable = Engine[0xF21A889CC4B74F9]()
	end
	return f0_local0.mapsTable
end
f0_local0.IsNil = function(f2_arg0)
	if f2_arg0 == nil then
		return "true"
	else
		return "false"
	end
end
f0_local0.MessageDialogForceSubscriptionFire = function(f3_arg0)
	local f3_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "messageDialog")
	if f3_local0 == nil then
		return
	else
		local f3_local1 = Engine[0xA798E4552F5E872](f3_local0, "messagePending")
		local f3_local2 = Engine[0x614D394F6F9A18D](f3_local1)
		if not f3_arg0 and f3_local2 == 0 then
			return
		else
			Engine[0x83C9B5DE1D9371](f3_local1, f3_local2 + 1)
		end
	end
end
f0_local0.ShowMessageDialog = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	if f4_arg2 == nil then
		error("Invalid message dialog message")
		return
	end
	local f4_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "messageDialog")
	if f4_local0 == nil then
		return
	end
	local f4_local1 = Engine[0xA798E4552F5E872](f4_local0, "messagePending")
	local f4_local2 = Engine[0xA798E4552F5E872](f4_local0, "messageType")
	local f4_local3 = Engine[0xA798E4552F5E872](f4_local0, "message")
	local f4_local4 = Engine[0xA798E4552F5E872](f4_local0, "controller")
	local f4_local5 = Engine[0xA798E4552F5E872](f4_local0, "anyControllerAllowed")
	if f4_local1 == nil or f4_local2 == nil or f4_local3 == nil or f4_local4 == nil or f4_local5 == nil then
		return
	end
	local f4_local6 = Engine[0x614D394F6F9A18D](f4_local1) + 1
	Engine[0x83C9B5DE1D9371](f4_local4, 0)
	Engine[0x83C9B5DE1D9371](f4_local5, true)
	local f4_local7 = false
	if f4_arg3 ~= nil then
		local f4_local8 = f4_arg3
		if type(f4_arg3) == "xhash" then
			f4_local8 = Engine[0xF9F1239CFD921FE](f4_arg3)
		end
		f4_local7 = Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f4_local0, "messageTitle"), f4_local8)
	end
	Engine[0x83C9B5DE1D9371](f4_local2, f4_arg1)
	if f4_arg2 ~= nil then
		local f4_local8 = f4_arg2
		if type(f4_arg2) == "xhash" then
			f4_local8 = Engine[0xF9F1239CFD921FE](f4_arg2)
		end
		if f4_arg3 == "" and not f4_local7 and f4_local6 > 1 then
			f4_local8 = f4_local3:get() .. "\n" .. f4_local8
		end
		Engine[0x83C9B5DE1D9371](f4_local3, f4_local8)
	end
	Engine[0x83C9B5DE1D9371](f4_local1, f4_local6)
end
f0_local0.UI_ShowInfoMessageDialog = function(f5_arg0, f5_arg1, f5_arg2)
	if f5_arg1 ~= nil then
		if type(f5_arg1) == "xhash" then
			local f5_local0 = Engine[0xF9F1239CFD921FE](f5_arg1)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Info Message Dialog: (" .. f5_local0 .. ") - " .. f5_local0 .. ".\n")
		else
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Info Message Dialog: (" .. f5_arg1 .. ") - " .. f5_arg1 .. ".\n")
		end
	end
	f0_local0.ShowMessageDialog(f5_arg0, Enum[0xEE23F7D18EF525C][0x296CBAC6039D717], f5_arg1, f5_arg2)
end
f0_local0.UI_ShowWarningMessageDialog = function(f6_arg0, f6_arg1, f6_arg2)
	if f6_arg1 ~= nil then
		if type(f6_arg1) == "xhash" then
			local f6_local0 = Engine[0xF9F1239CFD921FE](f6_arg1)
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Warning Message Dialog: (" .. f6_local0 .. ") - " .. f6_local0 .. ".\n")
		else
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Warning Message Dialog: (" .. f6_arg1 .. ") - " .. f6_arg1 .. ".\n")
		end
	end
	f0_local0.ShowMessageDialog(f6_arg0, Enum[0xEE23F7D18EF525C][0x8D00D07404A3DE5], f6_arg1, f6_arg2)
end
f0_local0.UI_ShowErrorMessageDialog = function(f7_arg0, f7_arg1, f7_arg2)
	if f7_arg1 ~= nil then
		if type(f7_arg1) == "xhash" then
			local f7_local0 = Engine[0xF9F1239CFD921FE](f7_arg1)
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Error Message Dialog: (" .. f7_local0 .. ") - " .. f7_local0 .. ".\n")
		else
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Error Message Dialog: (" .. f7_arg1 .. ") - " .. f7_arg1 .. ".\n")
		end
	end
	if f7_arg1 ~= "" then
		f0_local0.ShowMessageDialog(f7_arg0, Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B], f7_arg1, f7_arg2)
	end
end
f0_local0.UI_SetSignedInGamertagModel = function(f8_arg0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "durango.signedInGamertag", true), f8_arg0)
end
f0_local0.UI_ClearErrorMessageDialog = function()
	local f9_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "messageDialog")
	if f9_local0 ~= nil then
		local f9_local1 = Engine[0x40E824FE270E174](f9_local0, "messagePending")
		if f9_local1 ~= nil and Engine[0x614D394F6F9A18D](f9_local1) > 0 then
			Engine[0x83C9B5DE1D9371](f9_local1, 0)
		end
		local f9_local2 = Engine[0x40E824FE270E174](f9_local0, "messageTitle")
		if f9_local2 ~= nil then
			Engine[0x83C9B5DE1D9371](f9_local2, "")
		end
	end
	Engine[0x4DC6ECADB3DAA44]()
end
f0_local0.IsDOATarget = function(f10_arg0)
	return false
end
f0_local0.StartsWith = function(f11_arg0, f11_arg1)
	return string.sub(f11_arg0, 1, string.len(f11_arg1)) == f11_arg1
end
f0_local0.EndsWith = function(f12_arg0, f12_arg1)
	return string.sub(f12_arg0, -string.len(f12_arg1)) == f12_arg1
end
f0_local0.IsTableEmpty = function(f13_arg0)
	if not f13_arg0 then
		return true
	else
		return not next(f13_arg0)
	end
end
f0_local0.TableClear = function(f14_arg0)
	for f14_local0 = 1, #f14_arg0, 1 do
		table.remove(f14_arg0, f14_local0)
	end
end
f0_local0.ReturnCodeToHEX = function(f15_arg0)
	if f15_arg0 == 0 then
		return false, ""
	elseif f15_arg0 == Lobby.ProcessQueue.EVENT_START_ERROR then
		return true, "EVENT START ERROR"
	else
		return true, string.format("0x%x", f15_arg0)
	end
end
f0_local0.ValueToHex = function(f16_arg0)
	return string.format("0x%x", f16_arg0)
end
f0_local0.LobbyProcessQueueEmpty = function()
	local f17_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot")
	if not f17_local0 then
		return true
	else
		local f17_local1 = Engine[0x40E824FE270E174](f17_local0, "queueEmpty")
		if not f17_local1 then
			return true
		else
			return Engine[0x614D394F6F9A18D](f17_local1)
		end
	end
end
f0_local0.ForceLobbyButtonUpdate = function()
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyButtonUpdate"))
end
f0_local0.IsGamescomBuild = function()
	if Dvar[0xF52444CC548D39F]:get() then
		return true
	elseif Dvar[0x4AEFFF49B0FCC12]:get() then
		return true
	else
		return false
	end
end
f0_local0.IsBetaBuild = function()
	if Dvar[0x42A6A3568FF9F81]:get() then
		return true
	else
		return false
	end
end
f0_local0.AllClientsSpectating = function()
	local f21_local0 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	for f21_local4, f21_local5 in pairs(f21_local0.sessionClients) do
		if f21_local5.team ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			return false
		end
	end
	return true
end
f0_local0.LobbyMainModeData = {
	[Enum[0x89C1455C5032969][0x7E41449995CD57E]] = {
		eMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		OnlineCustomMenu = LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM,
		OnlineTrainingMenu = LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING,
		OnlineArenaMenuPregame = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME,
		OnlineArenaMenuMatchmaking = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING,
		OnlineArenaCustomMenu = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM,
		PregameMenu = LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME,
		PublicMenu = LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC,
		QuickPlaylistTarget = LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME,
		QuickPlaylistArenaTarget = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME,
		LanMenu = LuaEnum.UI.DIRECTOR_LAN_MP,
		TrainingMenu = LuaEnum.UI.DIRECTOR_LAN_MP_TRAINING,
	},
	[Enum[0x89C1455C5032969][0x79D01499920B292]] = {
		eMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		OnlineCustomMenu = LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM,
		PregameMenu = LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME,
		PrivateMenu = LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE,
		PublicMenu = LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC,
		QuickPlaylistTarget = LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME,
		LanMenu = LuaEnum.UI.DIRECTOR_LAN_ZM,
	},
	[Enum[0x89C1455C5032969][0x78C124999125C42]] = {
		eMode = Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
		OnlineCustomMenu = LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM,
		PregameMenu = LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC,
		PublicMenu = LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC,
		QuickPlaylistTarget = LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC,
		LanMenu = LuaEnum.UI.DIRECTOR_LAN_WZ,
	},
}
f0_local0.EModeData = {
	[Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]] = {
		assetName = 0x9E82E6A2962DD60,
	},
	[Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]] = {
		assetName = 0x9CA2B6A2949DAB8,
	},
	[Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]] = {
		assetName = 0x9D4406A295252EC,
	},
}
f0_local0.ShouldShowWarzone = function()
	local f22_local0 = LuaUtils.WarzoneModeAvailable()
	if not f22_local0 then
		f22_local0 = not LuaUtils.OnlineOnlyDemo()
	end
	return f22_local0
end
f0_local0.ShouldShowZombies = function()
	local f23_local0 = LuaUtils.ZombiesModeAvailable()
	if f23_local0 then
		if not Dvar[0x75D40FD034432A4]:exists() or tonumber(Dvar[0x75D40FD034432A4]:get()) <= 0 then
			f23_local0 = not LuaUtils.OnlineOnlyDemo()
		else
			f23_local0 = true
		end
	end
	return f23_local0
end
f0_local0.ShouldShowMultiplayer = function()
	return LuaUtils.MultiplayerModeAvailable()
end
for f0_local5, f0_local6 in pairs(f0_local0.EModeData) do
	local f0_local7 = Engine[0xE00B2F29271C60B](f0_local6.assetName)
	if f0_local7 ~= nil then
		f0_local6.Abbreviation = f0_local7[0x89A29113F5105C1]
		f0_local6.DefaultGameType = f0_local7[0xA64CB8DCAF6BBDC]
		f0_local6.DefaultMap = f0_local7[0xCBD34C8AF30CC98]
		f0_local6.PresenceIcon = 0xC4CF58835C4A472
		f0_local6.DisplayName = f0_local7[0x55F116BF695C8F6]
		f0_local6.SelectDescription = f0_local7[0x51DF77834F55EE1]
		f0_local6.DefaultArenaGameType = f0_local7[0xF431A55A6F5F2CB]
		f0_local6.DefaultArenaMap = f0_local7[0x7B49743C623CFB5]
	end
end
f0_local0.GetEModeForLobbyMainMode = function(f25_arg0)
	local f25_local0 = f0_local0.LobbyMainModeData[f25_arg0]
	local f25_local1
	if f25_local0 then
		f25_local1 = f25_local0.eMode
		if not f25_local1 then
		else
			return f25_local1
		end
	end
	f25_local1 = nil
end
f0_local0.GetDisplayNameForEMode = function(f26_arg0)
	if f26_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and not f0_local0.ShouldShowWarzone() then
		return 0x0
	elseif f26_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and not f0_local0.ShouldShowZombies() then
		return 0x0
	elseif f26_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and not f0_local0.ShouldShowMultiplayer() then
		return 0x0
	elseif f26_arg0 then
		local f26_local0 = f0_local0.EModeData[f26_arg0]
		local f26_local1 = f0_local0.EModeData[f26_arg0].DisplayName
	end
	return f26_local0 and f26_local1 or 0x0
end
f0_local0.GetSelectDescriptionForEMode = function(f27_arg0)
	if f27_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and not f0_local0.ShouldShowWarzone() then
		return 0x0
	elseif f27_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and not f0_local0.ShouldShowZombies() then
		return 0x0
	elseif f27_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and not f0_local0.ShouldShowMultiplayer() then
		return 0x0
	elseif f27_arg0 then
		local f27_local0 = f0_local0.EModeData[f27_arg0]
		local f27_local1 = f0_local0.EModeData[f27_arg0].SelectDescription
	end
	return f27_local0 and f27_local1 or 0x0
end
f0_local0.GetPresenceImageForEMode = function(f28_arg0)
	if f28_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and not f0_local0.ShouldShowWarzone() then
		return 0x0
	elseif f28_arg0 then
		local f28_local0 = f0_local0.EModeData[f28_arg0]
		local f28_local1 = f0_local0.EModeData[f28_arg0].PresenceIcon
	end
	return f28_local0 and f28_local1 or 0x214ECBA8C04D44C
end
f0_local0.GetDisplayNameForLobbyMainMode = function(f29_arg0)
	local f29_local0 = f0_local0.LobbyMainModeData[f29_arg0]
	return f0_local0.GetDisplayNameForEMode(f29_local0 and f29_local0.eMode)
end
f0_local0.GetDefaultMap = function(f30_arg0)
	local f30_local0 = f0_local0.LobbyMainModeData[f30_arg0[0xEB7DDC7F079D51B]]
	local f30_local1 = f30_local0 and f30_local0.eMode
	if f30_arg0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x7B5630CD29180CB] then
		if f30_local1 then
			local f30_local2 = f0_local0.EModeData[f30_local1]
			local f30_local3 = f0_local0.EModeData[f30_local1].DefaultArenaMap
		end
		return f30_local2 and f30_local3 or ""
	elseif f30_local1 then
		local f30_local4 = f0_local0.EModeData[f30_local1]
		local f30_local5 = f0_local0.EModeData[f30_local1].DefaultMap
	end
	return f30_local4 and f30_local5 or ""
end
f0_local0.GetDefaultGameType = function(f31_arg0)
	local f31_local0 = f0_local0.LobbyMainModeData[f31_arg0[0xEB7DDC7F079D51B]]
	local f31_local1 = f31_local0 and f31_local0.eMode
	if f31_arg0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x7B5630CD29180CB] or f31_arg0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F] then
		if f31_local1 then
			local f31_local2 = f0_local0.EModeData[f31_local1]
			local f31_local3 = f0_local0.EModeData[f31_local1].DefaultArenaGameType
		end
		return f31_local2 and f31_local3 or ""
	elseif f31_local1 then
		local f31_local4 = f0_local0.EModeData[f31_local1]
		local f31_local5 = f0_local0.EModeData[f31_local1].DefaultGameType
	end
	return f31_local4 and f31_local5 or ""
end
f0_local0.GetAbbreviationForMainMode = function(f32_arg0)
	local f32_local0 = f0_local0.LobbyMainModeData[f32_arg0]
	local f32_local1 = f32_local0 and f32_local0.eMode
	if f32_local1 then
		local f32_local2 = f0_local0.EModeData[f32_local1]
		local f32_local3 = f0_local0.EModeData[f32_local1].Abbreviation
	end
	return f32_local2 and f32_local3 or ""
end
f0_local0.SkuMatch = function(f33_arg0, f33_arg1, f33_arg2)
	if f33_arg0.region ~= f33_arg2 then
		return false
	elseif #f33_arg0.langs ~= #f33_arg1 then
		return false
	end
	for f33_local3, f33_local4 in ipairs(f33_arg0.langs) do
		if f33_local4 ~= f33_arg1[f33_local3] then
			return false
		end
	end
	return true
end
f0_local0.GetSkuName = function()
	local f34_local0 = Dvar[0x46B5D9C4A7CE4C0]:get()
	local f34_local1 = {}
	if LuaDefine.isPS4 then
		for f34_local5 in string.gmatch(f34_local0, "([^_]+)") do
			table.insert(f34_local1, f34_local5)
		end
	else
		for f34_local5 in string.gmatch(f34_local0, "([^,]+)") do
			table.insert(f34_local1, f34_local5)
		end
	end
	table.sort(f34_local1)
	local f34_local2 = 0
	for f34_local7, f34_local8 in ipairs({}) do
		if LuaUtils.SkuMatch(f34_local8, f34_local1, f34_local2) then
			return f34_local8.name
		end
	end
	return nil
end
f0_local0.IsSkuOfflineOnly = function()
	if not Dvar[0x624D67C5B31ACC9]:exists() or Dvar[0x624D67C5B31ACC9]:get() == "0" then
		return false
	else
		local f35_local0 = LuaUtils.GetSkuName()
		if f35_local0 == nil then
			return true
		else
			local f35_local1 = "skuOnline" .. f35_local0
			if not Dvar[f35_local1]:exists() then
				return true
			elseif Dvar[f35_local1]:get() == "1" then
				return false
			else
				return true
			end
		end
	end
end
f0_local0.GetOnlinePlaylists = function()
	if f0_local1.onlinePlaylistChecksum == nil or f0_local1.onlinePlaylistChecksum ~= Engine[0x4E58F1E46816B6]() then
		f0_local1.onlinePlaylistChecksum = Engine[0x4E58F1E46816B6]()
		f0_local1.onlinePlaylists = Engine[0x37A1CA9E92F5696]()
	end
	return f0_local1.onlinePlaylists
end
f0_local0.ReloadOnlinePlaylists = function()
	f0_local1.onlinePlaylistChecksum = Engine[0x4E58F1E46816B6]()
	f0_local1.onlinePlaylists = Engine[0x37A1CA9E92F5696]()
end
f0_local0.GetOfflinePlaylists = function()
	return Engine[0x37A1CA9E92F5696]("playlists_offline")
end
f0_local0.IsArenaMode = function()
	local f39_local0 = LuaUtils.IsArenaPublicGame()
	if not f39_local0 then
		f39_local0 = LuaUtils.IsArenaCustomGame()
	end
	return f39_local0
end
f0_local0.IsArenaPublicGame = function()
	return Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F])
end
f0_local0.IsArenaCustomGame = function()
	return Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x7B5630CD29180CB])
end
f0_local0.GetArenaPlaylistInfo = function()
	local f42_local0 = {}
	local f42_local1 = LuaUtils.GetOnlinePlaylists()
	local f42_local2 = {}
	for f42_local11, f42_local12 in ipairs(f42_local1) do
		if f42_local12.nameHash == 0x5D8D7B6A4C553C8 or f42_local12.nameHash == 0x98A15D908A3089F then
			for f42_local9, f42_local10 in pairs(f42_local12.entries) do
				table.insert(f42_local2, f42_local10)
			end
		end
	end
	return f42_local2
end
f0_local0.IsArenaPlaylist = function(f43_arg0)
	for f43_local3, f43_local4 in ipairs(LuaUtils.GetArenaPlaylistInfo()) do
		if f43_local4.id == f43_arg0 then
			return true
		end
	end
	return false
end
f0_local0.GetArenaPowerRating = function(f44_arg0)
	return math.max(0, math.floor(f44_arg0 * 1000 + 5000))
end
f0_local0.GetLeaguePlayTierTable = function()
	if not f0_local0.LeaguePlayTierList then
		f0_local0.LeaguePlayTierList = Engine[0xE00B2F29271C60B](0x5FB9081FBDA10BD)
	end
	return f0_local0.LeaguePlayTierList
end
f0_local0.GetLeaguePlacementTierForPosition = function(f46_arg0)
	if 0 < f46_arg0 then
		local f46_local0 = f0_local0.GetLeaguePlayTierTable()
		if f46_local0 then
			for f46_local4, f46_local5 in ipairs(f46_local0.tierlist) do
				if f46_arg0 <= f46_local5[0x8A3024830754A20] then
					return f46_local4
				end
			end
		end
	end
	return nil
end
f0_local0.GetPositionForLeaguePlacementTier = function(f47_arg0)
	local f47_local0 = f0_local0.GetLeaguePlayTierTable()
	if f47_local0 and f47_arg0 <= #f47_local0.tierlist then
		return f47_local0.tierlist[f47_arg0][0x8A3024830754A20]
	else
		return nil
	end
end
f0_local0.GetRubiesForLeaguePlacementTier = function(f48_arg0)
	local f48_local0 = f0_local0.GetLeaguePlayTierTable()
	if f48_local0 and f48_arg0 <= #f48_local0.tierlist then
		return f48_local0.tierlist[f48_arg0][0x4CC5373745DAE62]
	else
		return 0
	end
end
f0_local0.GetRubiesForPosition = function(f49_arg0)
	if 0 < f49_arg0 then
		local f49_local0 = f0_local0.GetLeaguePlayTierTable()
		if f49_local0 then
			for f49_local4, f49_local5 in ipairs(f49_local0.tierlist) do
				if f49_arg0 <= f49_local5[0x8A3024830754A20] then
					return f49_local5[0x4CC5373745DAE62]
				end
			end
		end
	end
	return 0
end
f0_local0.LobbyIsLocked = function()
	if f0_local0.IsArenaMode() then
		local f50_local0 = Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot"), "lobbyLockedIn")
		if f50_local0 then
			return Engine[0x614D394F6F9A18D](f50_local0)
		end
	end
	return false
end
f0_local0.UnlockLobby = function()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot"), "lobbyLockedIn"), false)
end
f0_local0.GetBanMessageForFeature = function(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = Engine[0x54689B3A7B3899E](f52_arg0)
	local f52_local1 = Engine[0xF9F1239CFD921FE](0x3B1ABD297FF1711)
	if f52_arg1 == LuaEnum.FEATURE_BAN.LIVE_MP then
		local f52_local2 = Engine[0xF9F1239CFD921FE]
		local f52_local3
		if f52_arg2 == true then
			f52_local3 = 0xC3D51874550E4CF
			if not f52_local3 then
			else
				return f52_local2(f52_local3, f52_local0, f52_local1)
			end
		end
		f52_local3 = 0xEBAE48C17D1FCB
	elseif f52_arg1 == LuaEnum.FEATURE_BAN.LIVE_ZM then
		local f52_local2 = Engine[0xF9F1239CFD921FE]
		local f52_local3
		if f52_arg2 == true then
			f52_local3 = 0xC3D51874550E4CF
			if not f52_local3 then
			else
				return f52_local2(f52_local3, f52_local0, f52_local1)
			end
		end
		f52_local3 = 0xEBAE48C17D1FCB
	elseif f52_arg1 == LuaEnum.FEATURE_BAN.LIVE_CP then
		local f52_local2 = Engine[0xF9F1239CFD921FE]
		local f52_local3
		if f52_arg2 == true then
			f52_local3 = 0xC3D51874550E4CF
			if not f52_local3 then
			else
				return f52_local2(f52_local3, f52_local0, f52_local1)
			end
		end
		f52_local3 = 0xEBAE48C17D1FCB
	elseif f52_arg1 == LuaEnum.FEATURE_BAN.LIVE_WZ then
		local f52_local2 = Engine[0xF9F1239CFD921FE]
		local f52_local3
		if f52_arg2 == true then
			f52_local3 = 0xC3D51874550E4CF
			if not f52_local3 then
			else
				return f52_local2(f52_local3, f52_local0, f52_local1)
			end
		end
		f52_local3 = 0xEBAE48C17D1FCB
	elseif f52_arg1 == LuaEnum.FEATURE_BAN.LEADERBOARD_WRITE_MP then
		local f52_local2 = Engine[0xF9F1239CFD921FE]
		local f52_local3
		if f52_arg2 == true then
			f52_local3 = 0xB21A4EAF3F42E24
			if not f52_local3 then
			else
				return f52_local2(f52_local3, f52_local0, f52_local1)
			end
		end
		f52_local3 = 0x581D0E7448BC8F4
	elseif f52_arg1 == LuaEnum.FEATURE_BAN.LEADERBOARD_WRITE_ZM then
		local f52_local2 = Engine[0xF9F1239CFD921FE]
		local f52_local3
		if f52_arg2 == true then
			f52_local3 = 0xB21A4EAF3F42E24
			if not f52_local3 then
			else
				return f52_local2(f52_local3, f52_local0, f52_local1)
			end
		end
		f52_local3 = 0x581D0E7448BC8F4
	elseif f52_arg1 == LuaEnum.FEATURE_BAN.LEADERBOARD_WRITE_CP then
		local f52_local2 = Engine[0xF9F1239CFD921FE]
		local f52_local3
		if f52_arg2 == true then
			f52_local3 = 0xB21A4EAF3F42E24
			if not f52_local3 then
			else
				return f52_local2(f52_local3, f52_local0, f52_local1)
			end
		end
		f52_local3 = 0x581D0E7448BC8F4
	else
		if f52_arg1 == LuaEnum.FEATURE_BAN.HOSTING then
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.MP_HOSTING then
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.ZM_HOSTING then
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.CP_HOSTING then
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.MP_SPLIT_SCREEN then
			local f52_local2 = Engine[0xF9F1239CFD921FE]
			local f52_local3
			if f52_arg2 == true then
				f52_local3 = 0xB21A4EAF3F42E24
				if not f52_local3 then
				else
					return f52_local2(f52_local3, f52_local0, f52_local1)
				end
			end
			f52_local3 = 0x581D0E7448BC8F4
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.ZM_SPLIT_SCREEN then
			local f52_local2 = Engine[0xF9F1239CFD921FE]
			local f52_local3
			if f52_arg2 == true then
				f52_local3 = 0xB21A4EAF3F42E24
				if not f52_local3 then
				else
					return f52_local2(f52_local3, f52_local0, f52_local1)
				end
			end
			f52_local3 = 0x581D0E7448BC8F4
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.CP_SPLIT_SCREEN then
			local f52_local2 = Engine[0xF9F1239CFD921FE]
			local f52_local3
			if f52_arg2 == true then
				f52_local3 = 0xB21A4EAF3F42E24
				if not f52_local3 then
				else
					return f52_local2(f52_local3, f52_local0, f52_local1)
				end
			end
			f52_local3 = 0x581D0E7448BC8F4
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.ARENA_GAMEPLAY then
			local f52_local2 = Engine[0xF9F1239CFD921FE]
			local f52_local3
			if f52_arg2 == true then
				f52_local3 = 0xB21A4EAF3F42E24
				if not f52_local3 then
				else
					return f52_local2(f52_local3, f52_local0, f52_local1)
				end
			end
			f52_local3 = 0x581D0E7448BC8F4
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT then
			local f52_local2 = Engine[0xF9F1239CFD921FE]
			local f52_local3
			if f52_arg2 == true then
				f52_local3 = 0xB21A4EAF3F42E24
				if not f52_local3 then
				else
					return f52_local2(f52_local3, f52_local0, f52_local1)
				end
			end
			f52_local3 = 0x581D0E7448BC8F4
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.PRESTIGE then
			local f52_local2 = Engine[0xF9F1239CFD921FE]
			local f52_local3
			if f52_arg2 == true then
				f52_local3 = 0xB21A4EAF3F42E24
				if not f52_local3 then
				else
					return f52_local2(f52_local3, f52_local0, f52_local1)
				end
			end
			f52_local3 = 0x581D0E7448BC8F4
		elseif f52_arg1 == LuaEnum.FEATURE_BAN.WZ_DUOQUAD then
			local f52_local2 = Engine[0xF9F1239CFD921FE]
			local f52_local3
			if f52_arg2 == true then
				f52_local3 = 0xB21A4EAF3F42E24
				if not f52_local3 then
				else
					return f52_local2(f52_local3, f52_local0, f52_local1)
				end
			end
			f52_local3 = 0x581D0E7448BC8F4
		else
			return Engine[0xF9F1239CFD921FE](0x632F97C36A01BD6)
		end
	end
end
f0_local0.SafeComError = function(f53_arg0, f53_arg1)
	local f53_local0 = nil
	if type(f53_arg1) == "xhash" then
		f53_local0 = Engine[0xF9F1239CFD921FE](f53_arg1)
	else
		f53_local0 = f53_arg1
	end
	if not Engine[0x1B09567078C4A6F]() then
		Engine[0xBC42C678E40DBE8](f53_arg0, f53_local0)
	end
	Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "**DOUBLE COM_ERROR** prevented: LuaUtils.SafeComError(" .. tostring(f53_arg0) .. ", " .. f53_arg1 .. ") - " .. f53_local0 .. ".\n")
end
f0_local0.GetPlaylistIDForSelectedCPMission = function(f54_arg0)
	local f54_local0 = LuaUtils.GetMapsTable()
	f54_local0 = f54_local0[f54_arg0]
	for f54_local10, f54_local11 in ipairs(nil) do
		if f54_local11.ref == "cp_public" then
			local f54_local4 = f54_local11.playlists
			if f54_local4 then
				for f54_local8, f54_local9 in ipairs(f54_local4) do
					if string.find(f54_local9.name, f54_arg0) ~= nil then
						return f54_local9.index
					end
				end
			end
		end
	end
	return nil
end
f0_local0.GetBSPNameFromAsset = function(f55_arg0)
	local f55_local0 = LuaUtils.GetMapsTable()
	f55_local0 = f55_local0[f55_arg0]
	if f55_local0 ~= nil and f55_local0.mapToLoad ~= nil then
		return f55_local0.mapToLoad
	else
		return f55_arg0
	end
end
f0_local0.IsGameModeParagonCapable = function(f56_arg0)
	if f56_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return Engine[0x9E5BE3B4BBA4E0E]("live_supports_paragon_wz")
	else
		local f56_local0
		if f56_arg0 ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and f56_arg0 ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f56_local0 = false
		else
			f56_local0 = true
		end
	end
	return f56_local0
end
f0_local0.ConvertToPrestigeMerged = function(f57_arg0, f57_arg1, f57_arg2)
	return f57_arg1 * 10000 + f57_arg2 * 100 + f57_arg0
end
f0_local0.ConvertFromPrestigeMerged = function(f58_arg0)
	local f58_local0 = math.floor(f58_arg0 / 10000)
	local f58_local1 = f58_arg0 - f58_local0 * 10000
	local f58_local2 = math.floor(f58_local1 / 100)
	return f58_local1 - f58_local2 * 100, f58_local0, f58_local2
end
f0_local0.OverrideTable = function(f59_arg0, f59_arg1)
	local f59_local0 = {}
	if f59_arg0 then
		for f59_local4, f59_local5 in pairs(f59_arg0) do
			f59_local0[f59_local4] = f59_local5
		end
	end
	if f59_arg1 then
		for f59_local4, f59_local5 in pairs(f59_arg1) do
			f59_local0[f59_local4] = f59_local5
		end
	end
	return f59_local0
end
f0_local0.MergeArrays = function(f60_arg0, f60_arg1)
	local f60_local0 = {}
	for f60_local4, f60_local5 in ipairs(f60_arg0) do
		table.insert(f60_local0, f60_local5)
	end
	for f60_local4, f60_local5 in ipairs(f60_arg1) do
		table.insert(f60_local0, f60_local5)
	end
	return f60_local0
end
f0_local0.VerifyIndexForArray = function(f61_arg0, f61_arg1)
	if 0 < f61_arg1 and f61_arg1 < #f61_arg0 then
		return f61_arg1
	else
		return nil
	end
end
f0_local0.GetIndexInArray = function(f62_arg0, f62_arg1)
	if 0 < f62_arg1 and f62_arg1 < #f62_arg0 then
		return f62_arg0[f62_arg1]
	else
		return nil
	end
end
f0_local0.FindItemInArray = function(f63_arg0, f63_arg1, f63_arg2)
	for f63_local3, f63_local4 in ipairs(f63_arg0) do
		if not (not f63_arg2 or not f63_arg2(f63_arg1, f63_local4)) or f63_local4 == f63_arg1 then
			return f63_local3
		end
	end
	return nil
end
f0_local0.FindItemInArrayTable = function(f64_arg0, f64_arg1, f64_arg2, f64_arg3)
	for f64_local3, f64_local4 in ipairs(f64_arg0) do
		if not (not f64_arg2 or not f64_arg2(f64_arg1, f64_local4)) or f64_local4 == f64_arg1 then
			return f64_local4[f64_arg3]
		end
	end
	return nil
end
f0_local0.FindItemInArrayTable = function(f65_arg0, f65_arg1, f65_arg2)
	for f65_local3, f65_local4 in ipairs(f65_arg0) do
		if f65_local4[f65_arg1] == f65_arg2 then
			return f65_local4
		end
	end
	return nil
end
f0_local0.GetTableKeyForElement = function(f66_arg0, f66_arg1)
	for f66_local3, f66_local4 in pairs(f66_arg0) do
		if f66_local4 == f66_arg1 then
			return f66_local3
		end
	end
	return nil
end
f0_local0.IterateFilteredArray = function(f67_arg0, f67_arg1)
	local f67_local0 = 0
	local f67_local1 = #f67_arg0
	return function()
		while f67_local0 < f67_local1 do
			f67_local0 = f67_local0 + 1
			if f67_arg1(f67_local0, f67_arg0[f67_local0]) then
				return f67_local0, f67_arg0[f67_local0]
			end
		end
		return nil
	end
end
f0_local0.IsHashTableEmpty = function(f69_arg0)
	local f69_local0, f69_local1, f69_local2 = pairs(f69_arg0)
	local f69_local3, f69_local4 = f69_local0(f69_local1, f69_local2)
	if f69_local3 ~= nil then
		f69_local2 = f69_local3
		return false
	else
		return true
	end
end
f0_local0.StringJoinArray = function(f70_arg0, f70_arg1)
	if not f70_arg1 then
		f70_arg1 = ""
	end
	local f70_local0 = ""
	for f70_local4, f70_local5 in ipairs(f70_arg0) do
		if f70_local4 ~= 0 then
			f70_local0 = f70_local0 .. f70_arg1 .. f70_local5
		else
			f70_local0 = f70_local0 .. f70_local5
		end
	end
	return f70_local0
end
f0_local0.swap = function(f71_arg0, f71_arg1, f71_arg2)
	local f71_local0 = f71_arg0[f71_arg2]
	f71_arg0[f71_arg2] = f71_arg0[f71_arg1]
	f71_arg0[f71_arg1] = f71_local0
end
f0_local0.shuffle = function(f72_arg0)
	local f72_local0 = #f72_arg0
	while 1 < f72_local0 do
		f0_local0.swap(f72_arg0, math.random(f72_local0), f72_local0)
		f72_local0 = f72_local0 - 1
	end
end
f0_local0.SecondsToTimeRemainingString = function(f73_arg0)
	local f73_local0 = math.floor(f73_arg0 / 86400)
	f73_arg0 = f73_arg0 - f73_local0 * 86400
	local f73_local1 = math.floor(f73_arg0 / 3600)
	f73_arg0 = f73_arg0 - f73_local1 * 3600
	local f73_local2 = math.floor(f73_arg0 / 60)
	local f73_local3 = f73_arg0 - f73_local2 * 60
	if f73_local1 < 10 then
		f73_local1 = "0" .. f73_local1
	end
	if f73_local2 < 10 then
		f73_local2 = "0" .. f73_local2
	end
	if f73_local3 < 10 then
		f73_local3 = "0" .. f73_local3
	end
	if f73_local0 > 7 then
		return Engine[0xF9F1239CFD921FE](0xBB5B34BDC891135, f73_local0)
	elseif f73_local0 > 0 then
		return Engine[0xF9F1239CFD921FE](0xF15651DBC75A77F, f73_local0, f73_local1, f73_local2, f73_local3)
	else
		return Engine[0xF9F1239CFD921FE](0x432FE3538638B68, f73_local1, f73_local2, f73_local3)
	end
end
f0_local0.UpdateContract = function(f74_arg0, f74_arg1)
	if f74_arg0.index:get() ~= f74_arg1.id then
		f74_arg0.index:set(f74_arg1.id)
		f74_arg0.progress:set(0)
		f74_arg0.award_given:set(0)
		f74_arg0.active:set(1)
		return true
	else
		return false
	end
end
f0_local0.SetAARContractStats = function(f75_arg0, f75_arg1)
	f75_arg1.index:set(f75_arg0.index:get())
	f75_arg1.progress:set(f75_arg0.progress:get())
	f75_arg1.award_given:set(f75_arg0.award_given:get())
	f75_arg1.active:set(f75_arg0.active:get())
end
f0_local0.BMContracts = {
	weeklyContractIndex1 = 0,
	weeklyContractIndex2 = 1,
	dailyContractIndex = 2,
	specialContractIndex = 3,
}
f0_local0.CycleContracts = function()
	local f76_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "contractWeeklyAIndex")
	local f76_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "contractWeeklyBIndex")
	local f76_local2 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "contractDailyIndex")
	local f76_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "contractWeeklyRemaining")
	local f76_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "contractDailyRemaining")
	if not Engine[0x9E5BE3B4BBA4E0E]("contracts_enabled_mp") then
		return
	end
	local f76_local5 = Engine[0xBD7BC359E582086]()
	if not Engine[0xE89628E21B49660]() or f76_local5 == nil or f76_local5[f0_local0.BMContracts.weeklyContractIndex1 + 1] == nil or f76_local5[f0_local0.BMContracts.weeklyContractIndex2 + 1] == nil or f76_local5[f0_local0.BMContracts.dailyContractIndex + 1] == nil then
		return
	elseif not Engine[0x9E5BE3B4BBA4E0E]("contracts_disable_schedule") then
		for f76_local6 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
			local f76_local9 = false
			if Engine[0xC7D35487C7E276D](f76_local6) then
				local f76_local10 = Engine[0x8BF970606552F4C](f76_local6, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
				if f76_local10 ~= nil then
					for f76_local14, f76_local15 in pairs(f0_local0.BMContracts) do
						if f76_local5[f76_local15 + 1] ~= nil and LuaUtils.UpdateContract(f76_local10.contracts[f76_local15], f76_local5[f76_local15 + 1]) == true then
							f76_local9 = true
							Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Updated contract slot " .. f76_local15 .. " to " .. f76_local5[f76_local15 + 1].id .. " " .. f76_local5[f76_local15 + 1].name .. " for controller " .. f76_local6 .. "\n")
							Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "New slot index in stats: " .. f76_local10.contracts[f76_local15].index:get() .. "\n")
							if f76_local15 == LuaUtils.BMContracts.dailyContractIndex then
								f76_local10.ui_seen_daily_congrats:set(0)
							else
								f76_local10.ui_seen_weekly_congrats:set(0)
							end
						end
					end
				end
			end
			if f76_local9 == true then
				Engine[0x28A466EF7723621](f76_local6, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
			end
		end
	end
	Engine[0x83C9B5DE1D9371](f76_local0, f76_local5[f0_local0.BMContracts.weeklyContractIndex1 + 1].id)
	Engine[0x83C9B5DE1D9371](f76_local1, f76_local5[f0_local0.BMContracts.weeklyContractIndex2 + 1].id)
	Engine[0x83C9B5DE1D9371](f76_local2, f76_local5[f0_local0.BMContracts.dailyContractIndex + 1].id)
	Engine[0x83C9B5DE1D9371](f76_local3, LuaUtils.SecondsToTimeRemainingString(f76_local5.timeRemainingWeekly))
	Engine[0x83C9B5DE1D9371](f76_local4, LuaUtils.SecondsToTimeRemainingString(f76_local5.timeRemainingDaily))
end
f0_local0.GetCurrentFactionDvars = function()
	return Engine[0x22EAAB59AA27E9B](0x341DE25CB0D6F66) or 0, Engine[0x22EAAB59AA27E9B](0x7067C5D4FE9075E) or 0, Engine[0x9E5BE3B4BBA4E0E](0x6C8247D6D84D328)
end
f0_local0.GetCallingsBundle = function()
	if f0_local0.callingsBundle == nil then
		f0_local0.callingsBundle = Engine[0xE00B2F29271C60B](0x258EFC12235EFC9)
	end
	return f0_local0.callingsBundle
end
f0_local0.GetCallingsStats = function(f79_arg0)
	local f79_local0 = Engine[0xA6C26EBACD7322D](f79_arg0)
	if f79_local0 then
		return f79_local0[0xAE679FEF1E88988]
	else
		return nil
	end
end
f0_local0.StorageWriteZMProgression = function(f80_arg0)
	Engine[0x28A466EF7723621](f80_arg0, Enum[0xBBD4F9E70101BA8][0xA57D6164B91A8FC])
end
f0_local0.UpdateFactionCallings = function(f81_arg0)
	local f81_local0 = f0_local0.GetCallingsStats(f81_arg0)
	if not f81_local0 then
		return
	end
	local f81_local1 = function(f82_arg0, f82_arg1, f82_arg2)
		f82_arg0[0xB9514BB20FEC5FF]:set(f82_arg1 - 1)
		f82_arg0[0xA5AB6FB11258EBF]:set(f82_arg2 - 1)
		f82_arg0[0xBF1EBBFA7B16C64]:set(0)
		f82_arg0[0xE608064D306991F]:set(Engine[0x786FFC9E621CAB7]())
	end
	local f81_local2 = function(f83_arg0, f83_arg1, f83_arg2)
		if f83_arg0[0xD8EAF5A5A9F1CC1]:get() == 0 then
			return true
		elseif f83_arg1 - 1 ~= f83_arg0[0x5DB84305A85FAEA]:get() or f83_arg2 - 1 ~= f83_arg0[0x4D468697915DFAA]:get() then
			return true
		else
			local f83_local0 = f83_arg0[0xE608064D306991F]:get()
			if f83_local0 == "0" then
				return true
			elseif Engine[0x786FFC9E621CAB7]() - Engine[0x90B6BCE69A8E08B](f83_local0) > Engine[0x90B6BCE69A8E08B](tostring(604800)) then
				return true
			else
				return false
			end
		end
	end
	local f81_local3, f81_local4, f81_local5 = f0_local0.GetCurrentFactionDvars()
	if f81_local3 ~= 0 and f81_local4 ~= 0 and f81_local5 then
		if f81_local2(f81_local0, f81_local3, f81_local4) then
			f81_local1(f81_local0, f81_local3, f81_local4)
		end
		f81_local0[0xD8EAF5A5A9F1CC1]:set(1)
	else
		f81_local0[0xBF1EBBFA7B16C64]:set(0)
		f81_local0[0xD8EAF5A5A9F1CC1]:set(0)
	end
	f81_local0[0x5DB84305A85FAEA]:set(f81_local3 - 1)
	f81_local0[0x4D468697915DFAA]:set(f81_local4 - 1)
	f0_local0.StorageWriteZMProgression(f81_arg0)
end
f0_local0.UpdateAllCallings = function()
	if Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] or Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return
	end
	for f84_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
		if Engine[0xC7D35487C7E276D](f84_local0) then
			if Engine[0x9E5BE3B4BBA4E0E](0x1DA02CA40639DE5) then
				f0_local0.UpdateFactionCallings(f84_local0)
			end
			if Engine[0x9E5BE3B4BBA4E0E](0x7FF853067D7C38C) then
				f0_local0.UpdateDailyCalling(f84_local0)
			end
		end
	end
end
f0_local0.UploadAllLocalStatsBuffers = function()
	if Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] then
		return
	end
	for f85_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
		if Engine[0xC7D35487C7E276D](f85_local0) then
			f0_local0.UploadLocalStatsBuffer(f85_local0)
		end
	end
end
f0_local0.UploadLocalStatsBuffer = function(f86_arg0)
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		Engine[0x28A466EF7723621](f86_arg0, Enum[0xBBD4F9E70101BA8][0xA57D6164B91A8FC])
	elseif Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		Engine[0x28A466EF7723621](f86_arg0, Enum[0xBBD4F9E70101BA8][0xD5A7695E03A7A90])
	end
end
f0_local0.UpdateDailyCallingDvar = function()
	local f87_local0 = f0_local0.GetCallingsBundle()
	if not f87_local0 then
		return
	elseif not f87_local0.dailyschedule or #f87_local0.dailyschedule == 0 then
		return
	end
	local f87_local1 = #f87_local0.dailyschedule - 1
	local f87_local2 = Engine[0x786FFC9E621CAB7]()
	local f87_local3 = Engine[0x90B6BCE69A8E08B](tostring(f87_local0[0x21C303DA786A89C]))
	if f87_local2 < f87_local3 then
		Engine[0xB177D654FFB67BE]("zm_active_daily_calling", 0)
		return
	end
	local f87_local4 = (f87_local2 - f87_local3) / Engine[0x90B6BCE69A8E08B](tostring(86400))
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "AutoEvents"), "zm_daily_callings_timer"), f0_local0.SecondsToTimeRemainingString(Engine[0x8377C456E1E2B0B](Engine[0x6E2B2377DE5A745](f87_local3 + (f87_local4 + Engine[0x90B6BCE69A8E08B]("1")) * Engine[0x90B6BCE69A8E08B](tostring(86400)))) + 1))
	f87_local4 = tonumber(Engine[0x6E2B2377DE5A745](f87_local4)) % f87_local1
	local f87_local5 = Engine[0x22EAAB59AA27E9B](0xEF2B14C3BFEF02A)
	local f87_local6 = f87_local4 + 1
	Engine[0xB177D654FFB67BE]("zm_active_daily_calling", f87_local6)
	if f87_local5 and f87_local5 ~= f87_local6 then
		local f87_local7 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "AutoEvents"), "cycled")
		if not Engine[0x83C9B5DE1D9371](f87_local7, 1) then
			Engine[0x6A489878620F3BC](f87_local7)
		end
	end
end
f0_local0.UpdateDailyCalling = function(f88_arg0)
	f0_local0.UpdateDailyCallingDvar()
	local f88_local0 = Engine[0x8BF970606552F4C](f88_arg0, Enum[0xBBD4F9E70101BA8][0xA57D6164B91A8FC])
	if f88_local0 == nil then
		return
	end
	local f88_local1 = f88_local0[0x8E3320CCF4091E5]
	if f88_local1 == nil then
		return
	end
	local f88_local2 = Engine[0x22EAAB59AA27E9B](0xEF2B14C3BFEF02A)
	if f88_local2 == nil or f88_local2 == 0 then
		return
	end
	local f88_local3 = Engine[0x786FFC9E621CAB7]()
	local f88_local4 = function()
		local f89_local0 = f88_local1[0xAD32B22445C4828]:get()
		if f89_local0 == "0" then
			return true
		else
			return f88_local3 - Engine[0x90B6BCE69A8E08B](f89_local0) > Engine[0x90B6BCE69A8E08B](tostring(86400))
		end
	end
	if f88_local2 ~= f88_local1[0x87F0FCE798B3A4B]:get() or f88_local4() then
		f88_local1[0x9909144862249C6]:set(0)
		f88_local1[0x87F0FCE798B3A4B]:set(f88_local2)
		f88_local1[0xAD32B22445C4828]:set(f88_local3)
		Engine[0x28A466EF7723621](f88_arg0, Enum[0xBBD4F9E70101BA8][0xA57D6164B91A8FC])
	end
end
f0_local0.RefreshDoubleXPMask = function()
	for f90_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
		Engine[0x564BF7F86779F65](f90_local0)
	end
end
f0_local0.SaveAfterMatchContractStats = function()
	if not Engine[0x9E5BE3B4BBA4E0E]("contracts_enabled_mp") then
		return
	end
	for f91_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
		if Engine[0xC7D35487C7E276D](f91_local0) then
			local f91_local3 = Engine[0x8BF970606552F4C](f91_local0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
			if f91_local3 and f91_local3.contracts and f91_local3.contractsAAR then
				for f91_local7, f91_local8 in pairs(f0_local0.BMContracts) do
					f0_local0.SetAARContractStats(f91_local3.contracts[f91_local8], f91_local3.contractsAAR[f91_local8])
				end
			end
		end
	end
end
f0_local0.GetBlackjackHeroIndex = function(f92_arg0)
	for f92_local3, f92_local4 in ipairs(Engine[0xA5B5E7CABA5C3AB](f92_arg0)) do
		if CoDShared.IsLootHero(f92_local4) then
			return f92_local4.bodyIndex
		end
	end
end
f0_local0.ResetToLastSelectedSpecialistIfNeeded = function(f93_arg0)
	if Dvar[0x9E317343EDF4396]:get() then
		return
	end
	local f93_local0 = "gamedata/tables/common/consumables.csv"
	local f93_local1 = 0
	local f93_local2 = 1
	if Engine[0xC7D35487C7E276D](f93_arg0) then
		local f93_local3 = Engine[0x8BF970606552F4C](f93_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
		local f93_local4 = Engine[0x2DCF0973239E909](f93_local0, f93_local1, f93_local2, "blackjack")
		if f93_local4 == nil or f93_local4 == "" then
			return
		elseif f93_local3.consumables[f93_local4].awarded:get() <= f93_local3.consumables[f93_local4].consumed:get() then
			local f93_local5 = f0_local0.GetBlackjackHeroIndex(Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
			local f93_local6 = Engine[0x8BF970606552F4C](f93_arg0, Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA])
			for f93_local10, f93_local11 in pairs({
				[Enum[0x6A5F22B388F8B9E][0xF9EE7A8E21CAD9B]] = "lastSelectedCharacterIndex",
			}) do
				if Engine[0x693626824CE62F2](f93_arg0, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], f93_local10) == f93_local5 then
					Engine[0x5BD54CABF917CBF](f93_arg0, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], f93_local10, f93_local6[f93_local11]:get())
				end
			end
		end
	end
end
f0_local0.ResetToLastSelectedSpecialistIfNeededAfterMatch = function()
	if Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or not Engine[0x8BF601ABD141DF9]() then
		return
	end
	for f94_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
		f0_local0.ResetToLastSelectedSpecialistIfNeeded(f94_local0)
	end
end
f0_local0.SetLastSelectedSpecialist = function(f95_arg0, f95_arg1)
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		local f95_local0 = Engine[0x8BF970606552F4C](f95_arg0, Enum[0xBBD4F9E70101BA8][0xDF87425733853AE])
		if f95_local0 then
			f95_local0[0x766CE60E25569A3][0x8A76647E94009C3][0xDF5E6BB54765F4C]:set(f95_arg1)
		end
	end
end
f0_local2 = {
	[Enum[0x50236A3452F3A49][0x9571467DC6166AD]] = {
		[Enum[0x50236A3452F3A49][0x9571467DC6166AD]] = true,
		[Enum[0x50236A3452F3A49][0x31FC575F7E84E5C]] = true,
		[Enum[0x50236A3452F3A49][0x28476FFCBABCB0]] = true,
	},
	[Enum[0x50236A3452F3A49][0x31FC575F7E84E5C]] = {
		[Enum[0x50236A3452F3A49][0x9571467DC6166AD]] = true,
		[Enum[0x50236A3452F3A49][0x31FC575F7E84E5C]] = true,
		[Enum[0x50236A3452F3A49][0x28476FFCBABCB0]] = false,
	},
	[Enum[0x50236A3452F3A49][0x28476FFCBABCB0]] = {
		[Enum[0x50236A3452F3A49][0x9571467DC6166AD]] = true,
		[Enum[0x50236A3452F3A49][0x31FC575F7E84E5C]] = false,
		[Enum[0x50236A3452F3A49][0x28476FFCBABCB0]] = false,
	},
}
f0_local0.IsCompatibleNatConnection = function(f96_arg0, f96_arg1)
	if f96_arg1 == nil then
		f96_arg1 = Engine[0xD83EDB9C9B5C88E]()
	end
	if f96_arg1 == Enum[0x50236A3452F3A49][0x13C8D4EF221C85D] or f96_arg0 == Enum[0x50236A3452F3A49][0x13C8D4EF221C85D] then
		return true
	else
		return f0_local2[f96_arg1][f96_arg0]
	end
end
f0_local0.PlaylistRulesIncludes = function(f97_arg0, f97_arg1, f97_arg2)
	if f97_arg0 then
		for f97_local3, f97_local4 in ipairs(f97_arg0) do
			if f97_local4.name == f97_arg1 and f97_local4.value == f97_arg2 then
				return true
			end
		end
	end
	return false
end
f0_local0.smoothstep = function(f98_arg0, f98_arg1, f98_arg2)
	local f98_local0 = LUI.clamp((f98_arg2 - f98_arg0) / (f98_arg1 - f98_arg0), 0, 1)
	return f98_local0 * f98_local0 * (3 - 2 * f98_local0)
end
f0_local0.ClearDDLKeysAndArrays = function(f99_arg0, f99_arg1, f99_arg2)
	if f99_arg1.keys ~= nil then
		for f99_local3, f99_local4 in ipairs(f99_arg1.keys) do
			local f99_local5 = f99_arg0[f99_local4]
			if f99_local5 then
				f99_local5:set(f99_arg2)
			end
		end
	end
	if f99_arg1.arrays ~= nil then
		for f99_local3, f99_local4 in ipairs(f99_arg1.arrays) do
			local f99_local5 = f99_arg0[f99_local4]
			if f99_local5 then
				for f99_local6 = 1, #f99_local5, 1 do
					f99_local5[f99_local6 - 1]:set(f99_arg2)
				end
			end
		end
	end
	if f99_arg1.structArrays ~= nil then
		for f99_local3, f99_local4 in pairs(f99_arg1.structArrays) do
			local f99_local5 = f99_arg0[f99_local3]
			if f99_local5 then
				for f99_local6 = 1, #f99_local5, 1 do
					f0_local0.ClearDDLKeysAndArrays(f99_local5[f99_local6 - 1], f99_local4, f99_arg2)
				end
			end
		end
	end
	if f99_arg1.structs ~= nil then
		for f99_local3, f99_local4 in pairs(f99_arg1.structs) do
			local f99_local5 = f99_arg0[f99_local3]
			if f99_local5 then
				f0_local0.ClearDDLKeysAndArrays(f99_local5, f99_local4, f99_arg2)
			end
		end
	end
end
f0_local0.CreateModelsFromTable = function(f100_arg0, f100_arg1)
	for f100_local4, f100_local5 in pairs(f100_arg1) do
		if type(f100_local5) == "table" then
			f0_local0.CreateModelsFromTable(f100_arg0:create(f100_local4), f100_local5)
		else
			local f100_local3 = f100_arg0:create(f100_local4)
			f100_local3:set(f100_local5)
		end
	end
end
f0_local0.TrialAllowSplitscreen = function()
	return false
end
f0_local0.TrialRequirePaidSubscription = function()
	return true
end
f0_local0.RequirePaidSubscriptionForOnlinePlay = function()
	if LuaDefine.isPC then
		return true
	else
		local f103_local0, f103_local1 = Engine[0x40EC85343E0181F]()
		if (f103_local0 == Enum[0x48909109238341F][0xCBD4CF0639724C3]) or f103_local0 == Enum[0x48909109238341F][0x1E6B724DD50351E] then
			return false
		elseif Engine[0xCB675CA7856DA25]() then
			return f0_local0.TrialRequirePaidSubscription()
		else
			return true
		end
	end
end
f0_local0.PlayStationPlusUpsell = function(f104_arg0)
	if LuaDefine.isPS4 then
		if f0_local0.RequirePaidSubscriptionForOnlinePlay() then
			return Engine[0x53581D3A02EE9FF](f104_arg0)
		else
			return true
		end
	else
		return true
	end
end
f0_local0.OnlineOnlyDemo = function()
	if Dvar[0x9E838B67E5E49C2]:exists() and Dvar[0x9E838B67E5E49C2]:get() == 0 then
		return true
	elseif not LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN) then
		return true
	else
		return false
	end
end
f0_local0.OfflineOnlyDemo = function()
	if Dvar[0x34A7795843D3848]:exists() and Dvar[0x34A7795843D3848]:get() == 0 then
		return true
	elseif not LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		return true
	else
		return false
	end
end
f0_local0.SkipDirectorOnlineMenu = function()
	return Dvar[0xEBDE517125BAF38]:get()
end
f0_local0.OnlineModeAvailable = function()
	if f0_local1.onlineAvailable == nil then
		f0_local1.onlineAvailable = nil ~= LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE)
	end
	return f0_local1.onlineAvailable
end
f0_local0.LanModeAvailable = function()
	if f0_local1.lanAvailable == nil then
		f0_local1.lanAvailable = nil ~= LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE)
	end
	return f0_local1.lanAvailable
end
f0_local0.MultiplayerModeAvailable = function()
	if Dvar[0x639D4DB415CDB92]:exists() and Dvar[0x639D4DB415CDB92]:get() == 0 then
		return false
	elseif f0_local1.mpAvailable == nil then
		f0_local1.mpAvailable = nil ~= LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME)
	end
	if Engine[0x7D47312EBA41751]() or Engine[0xCB675CA7856DA25]() then
		return false
	end
	return f0_local1.mpAvailable
end
f0_local0.ZombiesModeAvailable = function()
	if Dvar[0xD9394548AC1DBA]:exists() and Dvar[0xD9394548AC1DBA]:get() == 0 then
		return false
	elseif f0_local1.zmAvailable == nil then
		f0_local1.zmAvailable = nil ~= LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME)
	end
	if Engine[0x7D47312EBA41751]() or Engine[0xCB675CA7856DA25]() or Engine[0x5405A6484A88367]() then
		return false
	end
	return f0_local1.zmAvailable
end
f0_local0.WarzoneModeAvailable = function()
	if Dvar[0xFA38645FB7CFB66]:exists() and Dvar[0xFA38645FB7CFB66]:get() == 0 then
		return false
	elseif f0_local1.wzAvailable == nil then
		f0_local1.wzAvailable = nil ~= LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
	end
	return f0_local1.wzAvailable
end
f0_local0.CampaignModeAvailable = function()
	if Dvar[0xB9D57065A7090D0]:exists() and Dvar[0xB9D57065A7090D0]:get() == 0 then
		return false
	elseif f0_local1.cpAvailable == nil then
		f0_local1.cpAvailable = nil ~= LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_PREGAME)
	end
	if Engine[0x7D47312EBA41751]() or Engine[0xCB675CA7856DA25]() then
		return false
	end
	return f0_local1.cpAvailable
end
f0_local0.GameModeAvailable = function(f114_arg0)
	if f114_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		return f0_local0.MultiplayerModeAvailable()
	elseif f114_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return f0_local0.ZombiesModeAvailable()
	elseif f114_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return f0_local0.WarzoneModeAvailable()
	elseif f114_arg0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		return f0_local0.CampaignModeAvailable()
	elseif f114_arg0 == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return true
	else
		return false
	end
end
f0_local0.MPArenaDisabled = function()
	if Dvar[0xC1B99856528FDF9]:exists() and Dvar[0xC1B99856528FDF9]:get() == 0 then
		return true
	elseif not LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) then
		return true
	end
	local f115_local0 = Engine[0x7D47312EBA41751]()
	if not f115_local0 then
		f115_local0 = Engine[0xCB675CA7856DA25]()
	end
	return f115_local0
end
f0_local0.ArenaModeAvailable = function()
	return not f0_local0.MPArenaDisabled()
end
f0_local0.MatchmakingTest = function()
	if Dvar[0x4984E142BD2D354]:exists() and Dvar[0x4984E142BD2D354]:get() > 0 then
		return Dvar[0x4984E142BD2D354]:get()
	else
		return 0
	end
end
f0_local0.GetMinPlayersToStart = function()
	return Dvar[0x500E4DB2F10F5EE]:get()
end
f0_local0.IsRoleUnlocked = function(f119_arg0, f119_arg1, f119_arg2)
	local f119_local0 = Engine[0xB678B832BC9DC0](f119_arg1, f119_arg2)
	if not f119_local0 then
		return false
	elseif f119_local0[0x562938AF86028A0] ~= nil then
		return Engine[0xB521CB398C92692](f119_arg0, f119_local0[0x562938AF86028A0])
	end
	local f119_local1 = f119_local0[0xA01F4246639318C]
	if f119_local1 and CoDShared.IsIntDvarNonZero(f119_local1) then
		return true
	elseif f119_local0[0x5E9D6D3424C0E7E] ~= nil then
		local f119_local2 = Engine[0x8FF94BB44442412](f119_local0[0x5E9D6D3424C0E7E], f119_arg1)
		if f119_local2 > CoDShared.EmptyItemIndex and not Engine[0x191C1637A229078](f119_arg0, f119_local2, f119_arg1) then
			return true
		elseif f119_local0[0x1D6157DBA773DA3] ~= nil and f119_local0[0x1D6157DBA773DA3] ~= 0x0 then
			local f119_local3 = CoDShared.LootIndexInfoLookup(f119_local0[0x1D6157DBA773DA3])
			if f119_local3 then
				return CoDShared.IsLootItemOwnedByName(f119_arg0, f119_local3.nameHash)
			end
		end
	end
	if f119_local0[0xD48E06E94FE4AFA] == 1 then
		return true
	elseif Dvar[0x818EB2F0EDA28E5]:get() then
		return true
	elseif f119_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and (not CoDShared.IsIntDvarNonZero(0xA5FD7D94CFC9DFD) or f119_local0[0xE69216C2DA7060A] ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) then
		if Engine[0x8BF970606552F4C](f119_arg0, Enum[0xBBD4F9E70101BA8][0xD1A0F784B3C95A0]) == nil then
			return false
		elseif Engine[0x8BF970606552F4C](f119_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882]) == nil then
			return false
		end
		local f119_local4 = Engine[0x8BF970606552F4C](f119_arg0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC])
		if not f119_local4 then
			return false
		end
		local f119_local5 = Engine[0x82C5756563934AE](f119_arg1, f119_arg2)
		if f119_local5 and f119_local4[0x147738D5CEE9199][f119_local5] then
			return f119_local4[0x147738D5CEE9199][f119_local5][0xA55E1714AECC27C]:get() == 1
		end
		return false
	end
	return true
end
f0_local0.ConnectingToDemonwareMaxWaitTime = function()
	local f120_local0 = LuaDefine.CONNECTINGDW_MAX_WAIT_TIME
	if Dvar[0x3B4D9D51B4DD6DA]:exists() then
		f120_local0 = f120_local0 + Dvar[0x3B4D9D51B4DD6DA]:get() * 1000
	end
	return f120_local0
end
f0_local0.ArenaDayOverwriteFixedTime = -1
f0_local0.SecondsInDay = 86400
f0_local0.ArenaSeasonAsset = nil
f0_local0.GetArenaSeasonAsset = function()
	return f0_local0.ArenaSeasonAsset
end
f0_local0.GetArenaSeasonElapsedSeconds = function()
	local f122_local0 = Engine[0x783588166FFFE1E]()
	if Engine[0xEDCFC612B39E0C0]("arena_day_overwrite") > 0 then
		f122_local0 = Engine[0xEDCFC612B39E0C0]("arena_day_overwrite") * f0_local0.SecondsInDay
		if f0_local0.ArenaDayOverwriteFixedTime == -1 then
			f0_local0.ArenaDayOverwriteFixedTime = Engine[0xEFF639FB8A1BE0A]()
		else
			f122_local0 = f122_local0 + Engine[0xEFF639FB8A1BE0A]() - f0_local0.ArenaDayOverwriteFixedTime
		end
	end
	return f122_local0
end
f0_local0.GetArenaEventStartAndDuration = function(f123_arg0, f123_arg1, f123_arg2, f123_arg3)
	local f123_local0 = f123_arg2.startOffset
	local f123_local1 = f123_arg0.eventlist[f123_arg1].endOffset
	if f123_arg2.eventType == Enum[0xC0EA92D04BC003B][0xA9E0B7849B16CD2] or f123_arg2.eventType == Enum[0xC0EA92D04BC003B][0x185075D2D3D8497] then
		f123_local1 = f123_arg3
		if f123_arg1 < #f123_arg0.eventlist then
			f123_local1 = f123_arg0.eventlist[f123_arg1 + 1].startOffset - 1
		end
	end
	return f123_local0, f123_local1 - f123_local0
end
f0_local0.GetArenaEventEntryAndEndSeconds = function(f124_arg0, f124_arg1)
	local f124_local0, f124_local1 = nil
	local f124_local2 = f0_local0.GetArenaSeason()
	if f124_local2 then
		local f124_local3 = f124_local2.duration
		for f124_local14, f124_local15 in ipairs(f124_local2.schedulelist) do
			if f124_local15 ~= nil then
				for f124_local12, f124_local13 in ipairs(f124_local15.eventlist) do
					if f124_local13 ~= f124_arg1 then
						local f124_local10, f124_local11 = f0_local0.GetArenaEventStartAndDuration(f124_local15, f124_local12, f124_local13, f124_local3)
						if f124_arg1 then
							if f124_arg0 <= f124_local10 then
								f124_local0 = f124_local13
							end
						end
						if f124_local10 <= f124_arg0 and f124_arg0 < f124_local10 + f124_local11 then
							f124_local0 = f124_local13
							if f124_local13.endOffset > -1 then
								f124_local1 = f124_local10 + f124_local11
							end
						end
					end
				end
			end
		end
	end
	return f124_local0, f124_local1
end
f0_local0.GetArenaEventEntryAndUpcoming = function(f125_arg0)
	local f125_local0, f125_local1 = f0_local0.GetArenaEventEntryAndEndSeconds(f125_arg0)
	if f125_local0 then
		if f125_local1 == nil then
			f125_local1 = f125_arg0 + 1
		end
		return f125_local0, f0_local0.GetArenaEventEntryAndEndSeconds(f125_local1, f125_local0)
	else
		return nil, nil
	end
end
f0_local0.GetArenaSeason = function()
	local f126_local0, f126_local1 = nil
	if Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
		if f0_local0.ArenaSeasonAsset == nil or f0_local0.ArenaSeasonAsset.seasonlist.nSeasons <= 0 then
			f0_local0.ArenaSeasonAsset = Engine[0x349A8E5848A2FAC]()
		end
		local f126_local2 = f0_local0.ArenaSeasonAsset
		local f126_local3 = Engine[0x5A1049D8CEE36C2]()
		if f126_local2 ~= nil and f126_local3 >= 0 then
			local f126_local4 = f126_local2.seasonlist[f126_local3]
			if f126_local4 ~= nil then
				f126_local0 = f126_local4
				f126_local1 = f126_local4.startTime
			end
		end
	end
	if Engine[0xEDCFC612B39E0C0]("arena_day_overwrite") > 0 then
		f126_local1 = 0
	end
	return f126_local0, f126_local1
end
f0_local0.GetEventStartAndDuration = function(f127_arg0, f127_arg1, f127_arg2, f127_arg3)
	local f127_local0 = f127_arg2.startOffset
	local f127_local1 = f127_arg0.eventlist[f127_arg1].endOffset
	if f127_arg2.eventType == Enum[0xC0EA92D04BC003B][0xA9E0B7849B16CD2] or f127_arg2.eventType == Enum[0xC0EA92D04BC003B][0x185075D2D3D8497] then
		f127_local1 = f127_arg3
		if f127_arg1 < #f127_arg0.eventlist then
			f127_local1 = f127_arg0.eventlist[f127_arg1 + 1].startOffset - 1
		end
	end
	return f127_local0, f127_local1 - f127_local0
end
f0_local0.GetEventEntryAndEndSeconds = function(f128_arg0, f128_arg1)
	local f128_local0, f128_local1 = nil
	local f128_local2 = f0_local0.GetArenaSeason()
	if f128_local2 then
		local f128_local3 = f128_local2.duration
		for f128_local14, f128_local15 in ipairs(f128_local2.schedulelist) do
			if f128_local15 ~= nil then
				for f128_local12, f128_local13 in ipairs(f128_local15.eventlist) do
					if f128_local13 ~= f128_arg1 then
						local f128_local10, f128_local11 = f0_local0.GetEventStartAndDuration(f128_local15, f128_local12, f128_local13, f128_local3)
						if f128_arg1 then
							if f128_arg0 <= f128_local10 then
								f128_local0 = f128_local13
							end
						end
						if f128_local10 <= f128_arg0 and f128_arg0 < f128_local10 + f128_local11 then
							f128_local0 = f128_local13
							if f128_local13.endOffset > -1 then
								f128_local1 = f128_local10 + f128_local11
							end
						end
					end
				end
			end
		end
	end
	return f128_local0, f128_local1
end
f0_local0.GetArenaEventEntryPlaylistByName = function(f129_arg0)
	if f129_arg0 and f129_arg0.eventType == Enum[0xC0EA92D04BC003B][0xC32571741C5B730] then
		return Engine[0xC68B4B9A2458BCB](0x7F03AFD7C3F6764)
	else
		return Engine[0xC68B4B9A2458BCB](0xF0917768CA87F27)
	end
end
f0_local0.GetArenaSkillBucketFromEvent = function(f130_arg0)
	return LuaUtils.ArenaSeasonAsset.skillBuckets[0xC80DD3D83847EEA]
end
f0_local0.GetEventEntryAndUpcoming = function(f131_arg0)
	local f131_local0, f131_local1 = f0_local0.GetEventEntryAndEndSeconds(f131_arg0)
	if f131_local0 then
		if f131_local1 == nil then
			f131_local1 = f131_arg0 + 1
		end
		return f131_local0, f0_local0.GetEventEntryAndEndSeconds(f131_local1, f131_local0)
	else
		return nil, nil
	end
end
f0_local0.GetCurrentEventEntryAndUpcoming = function()
	return f0_local0.GetEventEntryAndUpcoming(f0_local0.GetArenaSeasonElapsedSeconds())
end
f0_local0.GetEventEntry = function(f133_arg0)
	local f133_local0, f133_local1 = f0_local0.GetEventEntryAndUpcoming(f133_arg0)
	return f133_local0
end
f0_local0.GetCurrentEventEntry = function()
	local f134_local0, f134_local1 = f0_local0.GetCurrentEventEntryAndUpcoming()
	return f134_local0
end
f0_local0.GetUpcomingEventEntry = function()
	local f135_local0, f135_local1 = f0_local0.GetCurrentEventEntryAndUpcoming()
	return f135_local1
end
f0_local0.GetCurrentEventData = function()
	local f136_local0 = f0_local0.GetCurrentEventEntry()
	if f136_local0.event ~= nil then
		return Engine[0xE00B2F29271C60B](f136_local0.event)
	else
		return nil
	end
end
f0_local0.SetQuickplayPlaylistID = function(f137_arg0)
	if Engine[0x3ADF2C70B61E0EF](f137_arg0) then
		Engine[0xF26F6999FA03BB9](f137_arg0)
	else
		Engine[0xF26F6999FA03BB9](LuaDefine.INVALID_PLAYLIST_ID)
	end
end
LuaUtils = LuaReadOnlyTables.ReadOnlyTable(f0_local0)
