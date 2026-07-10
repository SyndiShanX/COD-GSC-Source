require("x64:c71b3cf9012e5dd")
local f0_local0 = {
	isPS4 = Engine[@"getcurrentplatform"]() == "orbis",
	isXbox = Engine[@"getcurrentplatform"]() == "durango",
	isPC = Engine[@"getcurrentplatform"]() == "pc",
	isPS4Client = Engine[@"hash_25AE97B58D7132F3"]() == "orbis",
	isXboxClient = Engine[@"hash_25AE97B58D7132F3"]() == "durango",
	isPCClient = Engine[@"hash_25AE97B58D7132F3"]() == "pc",
	isDedicated = Engine[@"isdedicatedserver"]() == true,
	LUA_INT_MIN = -8388607,
	LUA_INT_MAX = 8388607,
	INT_MAX = Engine[@"getlimitvalue"](Enum[@"limit"][@"limit_int_max"]),
	UINT_MAX = Engine[@"getlimitvalue"](Enum[@"limit"][@"limit_uint_max"]),
	CONNECTINGDW_MAX_WAIT_TIME = 30000,
}
if f0_local0.isPS4 then
	f0_local0.CONNECTINGDW_MAX_WAIT_TIME = 40000
elseif f0_local0.isXbox then
	f0_local0.CONNECTINGDW_MAX_WAIT_TIME = 60000
end
f0_local0.INVALID_CONTROLLER_PORT = -1
f0_local0.INVALID_CLIENT_INDEX = -1
f0_local0.MAX_CLIENTS = Engine[@"getmaxclients"]()
f0_local0.MAX_CONTROLLER_COUNT = Engine[@"getmaxcontrollercount"]()
f0_local0.ZERO_X64 = Engine[@"numbertouint64"](0)
f0_local0.INVALID_XUID = 0
f0_local0.INVALID_XUID_X64 = Engine[@"numbertouint64"](0)
f0_local0.INVALID_PLAYLIST_ID = 0
f0_local0.T8_BUILD_NAME = "t8"
f0_local0.LEADERBOARD_MAX_ROWS = 101
f0_local0.BD_NOT_CONNECTED = 2
f0_local0.PS_PLUS_CHECK_TIME = 45000
f0_local0.TOAST_POPUP_ICON_SUCCESS = "ui_menu_popups_toastnotification_icon_mail"
f0_local0.TOAST_POPUP_ICON_ERROR = "ui_menu_popups_toastnotification_icon_fail"
f0_local0.INVITE_TOAST_POPUP_ACCEPTED_ICON = "t7_mp_icon_groups_invite_accepted"
f0_local0.INVITE_TOAST_POPUP_REJECTED_ICON = "t7_mp_icon_groups_invite_rejected"
f0_local0.TASKMANAGER2_DEFAULT_TIMEOUT = 0
f0_local0.BATTLENET_CURRENTGAME_FOURCC = Engine[@"hash_2FCB6EF7051DF576"]()
f0_local0.createEnum = function(...)
	local f1_local0 = {}
	for f1_local4, f1_local5 in ipairs({
		n = select("#", ...),
		...,
	}) do
		f1_local0[f1_local5] = f1_local4 - 1
	end
	return LuaReadOnlyTables.ReadOnlyTable(f1_local0)
end
LuaDefine = LuaReadOnlyTables.ReadOnlyTable(f0_local0)
