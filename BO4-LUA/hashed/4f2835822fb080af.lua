if CoD == nil then
	CoD = {}
end
CoD.UpdateConsoleColors = function(f1_arg0)
	if CoD.ColorUtility then
		CoD.ColorUtility.ConsoleColors[f1_arg0.controller] = f1_arg0.colors
	end
end
CoD.TestFFOTDFnOverride = function()
	Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_live"], "Failed to override UI VM funtion from FFOTD.\n")
	error("Failed to override UI VM funtion from FFOTD.")
end
CoD.ButtonMappings = {}
local f0_local0 = Engine[@"getcurrentplatform"]()
CoD.isDurango = f0_local0 == "durango"
CoD.isPC = f0_local0 == "pc"
CoD.isPS4 = f0_local0 == "orbis"
CoD.mapsTable = Engine[@"getgdtmapstable"]()
CoD.DLCBits = {
	CONTENT_UNKNOWN = Enum[@"contentflagbits"][@"content_unknown"],
	CONTENT_ORIGINALMAPS = Enum[@"contentflagbits"][@"content_originalmaps"],
	CONTENT_DLC0ZM = Enum[@"contentflagbits"][@"content_dlc0zm"],
	CONTENT_DLC2MP = Enum[@"contentflagbits"][@"content_dlc2mp"],
	CONTENT_DLC1ZM = Enum[@"contentflagbits"][@"content_dlc1zm"],
	CONTENT_DLC3MP = Enum[@"contentflagbits"][@"content_dlc3mp"],
	CONTENT_DLC2ZM = Enum[@"contentflagbits"][@"content_dlc2zm"],
	CONTENT_DLC4MP = Enum[@"contentflagbits"][@"content_dlc4mp"],
	CONTENT_DLC3ZM = Enum[@"contentflagbits"][@"content_dlc3zm"],
	CONTENT_DLC5MP = Enum[@"contentflagbits"][@"content_dlc5mp"],
	CONTENT_DLC4ZM = Enum[@"contentflagbits"][@"content_dlc4zm"],
	CONTENT_DLC6MP = Enum[@"contentflagbits"][@"content_dlc6mp"],
	CONTENT_DLC5ZM = Enum[@"contentflagbits"][@"content_dlc5zm"],
}
CoD.DLCPackFromBit = {
	[CoD.DLCBits.CONTENT_DLC0ZM] = "DLC0ZM",
	[CoD.DLCBits.CONTENT_DLC2MP] = "DLC2MP",
	[CoD.DLCBits.CONTENT_DLC1ZM] = "DLC1ZM",
	[CoD.DLCBits.CONTENT_DLC3MP] = "DLC3MP",
	[CoD.DLCBits.CONTENT_DLC2ZM] = "DLC2ZM",
	[CoD.DLCBits.CONTENT_DLC4MP] = "DLC4MP",
	[CoD.DLCBits.CONTENT_DLC3ZM] = "DLC3ZM",
	[CoD.DLCBits.CONTENT_DLC5MP] = "DLC5MP",
	[CoD.DLCBits.CONTENT_DLC4ZM] = "DLC4ZM",
	[CoD.DLCBits.CONTENT_DLC6MP] = "DLC6MP",
	[CoD.DLCBits.CONTENT_DLC5ZM] = "DLC5ZM",
}
CoD.ProductFromBit = {
	[Enum[@"emodes"][@"mode_multiplayer"]] = {
		products = {
			[CoD.DLCBits.CONTENT_DLC2MP] = "mpdlc1",
			[CoD.DLCBits.CONTENT_DLC3MP] = "mpdlc2",
			[CoD.DLCBits.CONTENT_DLC4MP] = "mpdlc3",
			[CoD.DLCBits.CONTENT_DLC5MP] = "mpdlc4",
			[CoD.DLCBits.CONTENT_DLC6MP] = "mpdlc5",
		},
		known = 0,
	},
	[Enum[@"emodes"][@"mode_zombies"]] = {
		products = {
			[CoD.DLCBits.CONTENT_DLC0ZM] = "zombiesdlc0",
			[CoD.DLCBits.CONTENT_DLC1ZM] = "zmdlc1",
			[CoD.DLCBits.CONTENT_DLC2ZM] = "zmdlc2",
			[CoD.DLCBits.CONTENT_DLC3ZM] = "zmdlc3",
			[CoD.DLCBits.CONTENT_DLC4ZM] = "zmdlc4",
		},
		known = 0,
	},
	[Enum[@"emodes"][@"mode_campaign"]] = {
		products = {},
		known = 0,
	},
	[Enum[@"emodes"][@"mode_warzone"]] = {
		products = {},
		known = 0,
	},
	[Enum[@"emodes"][@"mode_invalid"]] = {
		products = {},
		known = 0,
	},
}
CoD.profileKey_gametype = @"gametype"
CoD.profileKey_map = @"map"
CoD.attachmentTable = 0xCFEB5C2C217B385
CoD.backgroundsTable = 0xA24C07219458C5B
CoD.didYouKnowTable = 0xF9D3BFB4832D305
CoD.fileShareTable = 0x78C98D5D265BE6A
CoD.musicPlayerTable = 0x590AA487A61749F
CoD.levelPointTable = 0x7D9B02ADD394D54
local f0_local1 = ""
CoD.PlayFrontendMusic = function(f3_arg0)
	if f3_arg0 == nil then
		f3_arg0 = "titlescreen"
		if CoD.isCampaign then
			f3_arg0 = "cp_frontend"
		elseif CoD.isMultiplayer then
			f3_arg0 = "mp_frontend"
		elseif CoD.isZombie then
			f3_arg0 = "zm_frontend"
		end
	end
	if f0_local1 == f3_arg0 then
		return
	else
		f0_local1 = f3_arg0
		Engine[@"playmenumusic"](f3_arg0)
	end
end
CoD.PlayFrontendMusicForLobby = function(f4_arg0)
	local f4_local0 = nil
	local f4_local1 = LobbyData.GetLobbyMenuByID(f4_arg0)
	if f4_local1[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] and CoD.PCKoreaUtility.ShowKorea15Plus() then
		return
	else
		f4_local0 = f4_local1 and f4_local1[@"menumusic"]
		if not f4_local0 or f0_local1 == f4_local0 then
			return
		else
			f0_local1 = f4_local0
			Engine[@"playmenumusic"](f4_local0)
		end
	end
end
CoD.StopFrontendMusic = function()
	Engine[@"playmenumusic"]("")
end
CoD.ResetFrontendMusic = function()
	Engine[@"playmenumusic"](f0_local1)
end
CoD.Currencies = {}
CoD.Currencies.COD_POINTS = @"cod_points"
CoD.Currencies.ZM_NEBULIUM_PLASMA = @"nebulium_plasma"
CoD.Currencies.MP_PRESTIGE_TOKEN = @"mp_prestige_token"
CoD.Currencies.ZM_PRESTIGE_TOKEN = @"zm_prestige_token"
CoD.Currencies.DOTD_INCENTIVE_TOKEN = @"dotd_incentive_token"
CoD.Currencies.BLACKOPSPASS_INCENTIVE_TOKEN = @"blackopspass_incentive_token"
CoD.weaponAttributes = 0xAB70A73C80987CF
CoD.scoreInfoTableMP = 0x8C87487ED1A7400
CoD.scoreInfoTableZM = 0x458380C310907D8
CoD.scoreInfoTableWZ = @"hash_64C20A4E91609EE8"
CoD.weaponOptions = 0x2836CDB1280A2E4
CoD.ScoreInfoTable = {}
CoD.ScoreInfoTable.BaseMPTable = 0x6B11084B77644F7
CoD.ScoreInfoTable.BaseWZTable = 0x7EA4C79706FD49B
CoD.ScoreInfoTable.ScriptRefCol = 0
CoD.ScoreInfoTable.MedalXPCol = 2
CoD.ScoreInfoTable.MedalRefCol = 10
CoD.ScoreInfoTable.MedalAssetCol = 11
CoD.ScoreInfoTable.MedalCategoryCol = 15
CoD.isFrontend = Engine[@"getcurrentmap"]() == "core_frontend"
CoD.SetupMode = function(f7_arg0)
	CoD.isCampaign = false
	CoD.isMultiplayer = false
	CoD.isZombie = false
	CoD.isWarzone = false
	CoD.isModeSelected = false
	CoD.gameModeEnum = nil
	if f7_arg0.abbreviation == nil then
		return
	end
	CoD.isFrontend = Engine[@"getcurrentmap"]() == "core_frontend"
	Engine[@"setdvar"]("splitscreen_horizontal", Engine[@"getprofilevarint"](f7_arg0.controller, "splitscreenOrientation"))
	if IsGameTypeDOA() then
		Engine[@"setdvar"]("ui_blocksaves", "1")
	end
	if CoD.CACUtility then
		CoD.CACUtility.UnlockablesTable = nil
	end
	CoD.gameModeEnum = Engine[@"currentsessionmode"]()
	if CoD.PlayerRoleUtility then
		for f7_local0 = Enum[@"emodes"][@"mode_first"], Enum[@"emodes"][@"mode_count"] - 1, 1 do
			if f7_local0 ~= CoD.gameModeEnum then
				CoD.PlayerRoleUtility.Heroes.HeroList[f7_local0] = nil
				CoD.PlayerRoleUtility.Heroes.HeroListSorted[f7_local0] = nil
				CoD.PlayerRoleUtility.Heroes.HeroInfo[f7_local0] = nil
				CoD.PlayerRoleUtility.Heroes.HeroCustomization[f7_local0] = nil
			end
		end
	end
	if CoD.gameModeEnum == Enum[@"emodes"][@"mode_multiplayer"] then
		CoD.isMultiplayer = true
		CoD.scoreInfoTable = CoD.scoreInfoTableMP
		CoD.weaponAttributes = 0xAB70A73C80987CF
		CoD.statsMilestonePath = @"gamedata/stats/mp/statsmilestones"
		CoD.gunLevelsTable = 0x7D6337A77EF98AD
		CoD.emblemIconsTable = 0x25E8C4A61C9BFDA
		CoD.gameMode = "MP"
		CoD.profileKey_gametype = @"gametype"
		CoD.profileKey_map = @"map"
		CoD.isModeSelected = true
		local f7_local0 = Engine[@"lobbygetgametype"]()
		if not f7_local0 or f7_local0 == "" then
			f7_local0 = Dvar[@"g_gametype"]:get() or ""
		end
		CoD.scoreInfoTable = 0x93A1C8D4C90544 .. string.gsub(string.gsub(string.gsub(string.gsub(f7_local0, "_hc", ""), "_cwl", ""), "_bb", ""), "_dm", "") .. ".csv"
	end
	if CoD.gameModeEnum == Enum[@"emodes"][@"mode_campaign"] then
		CoD.isCampaign = true
		CoD.protoMapsTable = @"hash_1160D3837EDD2EDB"
		CoD.statsMilestonePath = @"gamedata/stats/cp/statsmilestones"
		CoD.scoreInfoTable = 0xFF88B807408D20A
		CoD.weaponAttributes = 0x8CD79CD0F5DC983
		CoD.statsMilestone = 0x4208F5B04921371
		CoD.gunLevelsTable = 0x150230C4105DC11
		CoD.gameMode = "CP"
		CoD.isModeSelected = true
		CoD.profileKey_gametype = @"gametype_cp"
		CoD.profileKey_map = @"map_cp"
	end
	if CoD.gameModeEnum == Enum[@"emodes"][@"mode_zombies"] then
		CoD.isZombie = true
		CoD.weaponAttributes = 0x297479F395531C3
		CoD.statsMilestonePath = @"gamedata/stats/zm/statsmilestones"
		CoD.profileKey_gametype = @"gametype_zm"
		CoD.profileKey_map = @"map_zm"
		CoD.gameMode = "ZM"
		CoD.isModeSelected = true
		CoD.gunLevelsTable = 0xEA60CF27BEDFA51
		CoD.emblemIconsTable = 0x25E8C4A61C9BFDA
		CoD.scoreInfoTable = CoD.scoreInfoTableZM
	end
	if CoD.gameModeEnum == Enum[@"emodes"][@"mode_warzone"] then
		CoD.isWarzone = true
		CoD.scoreInfoTable = 0x7EA4C79706FD49B
		CoD.weaponAttributes = 0xAB70A73C80987CF
		CoD.statsMilestonePath = @"gamedata/stats/mp/statsmilestones"
		CoD.gunLevelsTable = 0x7D6337A77EF98AD
		CoD.emblemIconsTable = 0x25E8C4A61C9BFDA
		CoD.profileKey_gametype = @"gametype_wz"
		CoD.profileKey_map = @"map_wz"
		CoD.gameMode = "WZ"
		CoD.isModeSelected = true
	end
end
if CoD.perController == nil then
	CoD.perController = {}
	for f0_local2 = 0, 3, 1 do
		CoD.perController[f0_local2] = {}
	end
end
CoD.getStatsMilestoneTable = function(f8_arg0, f8_arg1)
	if not f8_arg1 then
		f8_arg1 = Engine[@"currentsessionmode"]()
	end
	if f8_arg1 == Enum[@"emodes"][@"mode_campaign"] then
		return @"gamedata/stats/cp/statsmilestones" .. f8_arg0 .. ".csv"
	elseif f8_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
		return @"gamedata/stats/mp/statsmilestones" .. f8_arg0 .. ".csv"
	elseif f8_arg1 == Enum[@"emodes"][@"mode_zombies"] then
		return @"gamedata/stats/zm/statsmilestones" .. f8_arg0 .. ".csv"
	elseif f8_arg1 == Enum[@"emodes"][@"mode_warzone"] then
		return @"gamedata/stats/wz/statsmilestones" .. f8_arg0 .. ".csv"
	else
	end
end
if CoD.fonts == nil then
	CoD.fonts = {}
end
CoD.fonts.Default = RegisterFont("default")
CoD.fonts.Condensed = CoD.fonts.Default
CoD.fonts.Big = CoD.fonts.Default
CoD.fonts.Chat = RegisterFont("notosans_regular")
CoD.textSize = {}
if Enum[@"language_t"][@"language_russian"] == Dvar[@"loc_language"]:get() then
	CoD.textSize.ExtraSmall = 20
	CoD.textSize.Default = 21
	CoD.textSize.Condensed = 24
	CoD.textSize.Big = 36
elseif Enum[@"language_t"][@"language_polish"] == Dvar[@"loc_language"]:get() then
	CoD.textSize.ExtraSmall = 16
	CoD.textSize.Default = 19
	CoD.textSize.Condensed = 21
	CoD.textSize.Big = 32
elseif Enum[@"language_t"][@"language_japanese"] == Dvar[@"loc_language"]:get() or Enum[@"language_t"][@"hash_39A4194D08679C69"] == Dvar[@"loc_language"]:get() then
	CoD.textSize.ExtraSmall = 15
	CoD.textSize.Default = 17
	CoD.textSize.Condensed = 22
	CoD.textSize.Big = 40
else
	CoD.textSize.ExtraSmall = 20
	CoD.textSize.Default = 25
	CoD.textSize.Condensed = 30
	CoD.textSize.Big = 48
end
CoD.GetFontBasedOnSize = function(f9_arg0)
	local f9_local0 = LUI.ShallowCopy(CoD.textSize)
	local f9_local1, f9_local2, f9_local3, f9_local4 = nil
	local f9_local5 = {}
	for f9_local9, f9_local10 in pairs(f9_local0) do
		table.insert(f9_local5, {
			name = f9_local9,
			size = f9_local10,
		})
	end
	table.sort(f9_local5, function(f10_arg0, f10_arg1)
		return f10_arg0.size < f10_arg1.size
	end)
	for f9_local9, f9_local10 in ipairs(f9_local5) do
		f9_local3 = f9_local10.name
		f9_local4 = f9_local10.size
		if not f9_local2 then
			f9_local2 = f9_local3
		end
		if f9_arg0 <= (f9_local4 + CoD.textSize[f9_local2]) / 2 then
			break
		end
		f9_local2 = f9_local3
	end
	if f9_local2 then
		return CoD.fonts[f9_local2]
	else
	end
end
CoD.buttonStrings = {}
CoD.buttonStrings.primary = "^BBUTTON_LUI_PRIMARY^"
CoD.buttonStrings.secondary = "^BBUTTON_LUI_SECONDARY^"
CoD.buttonStrings.alt1 = "^BBUTTON_LUI_ALT1^"
CoD.buttonStrings.alt2 = "^BBUTTON_LUI_ALT2^"
CoD.buttonStrings.select = "^BBUTTON_LUI_SELECT^"
CoD.buttonStrings.start = "^BBUTTON_LUI_START^"
CoD.buttonStrings.shoulderl = "^BBUTTON_LUI_SHOULDERL^"
CoD.buttonStrings.shoulderr = "^BBUTTON_LUI_SHOULDERR^"
CoD.buttonStrings.right_stick = "^BBUTTON_LUI_RIGHT_STICK^"
CoD.buttonStrings.left_stick_up = "^BBUTTON_LUI_LEFT_STICK_UP^"
CoD.buttonStrings.right_trigger = "^BBUTTON_LUI_RIGHT_TRIGGER^"
CoD.buttonStrings.left_trigger = "^BBUTTON_LUI_LEFT_TRIGGER^"
CoD.buttonStrings.dpad_all = "^BBUTTON_LUI_DPAD_ALL^"
CoD.buttonStrings.dpad_ud = "^BBUTTON_LUI_DPAD_UD^"
CoD.buttonStrings.dpad_lr = "^BBUTTON_LUI_DPAD_RL^"
CoD.buttonStrings.left = "^BBUTTON_LUI_DPAD_L^"
CoD.buttonStrings.up = "^BBUTTON_LUI_DPAD_U^"
CoD.buttonStrings.down = "^BBUTTON_LUI_DPAD_D^"
CoD.buttonStrings.right = "^BBUTTON_LUI_DPAD_R^"
CoD.buttonStrings.emblem_move = "^BBUTTON_EMBLEM_MOVE^"
CoD.buttonStrings.emblem_scale = "^BBUTTON_EMBLEM_SCALE^"
CoD.buttonStrings.right_stick_pressed = "^BBUTTON_LUI_RIGHT_STICK^"
if CoD.isPC == true then
	CoD.buttonStringsShortCut = {}
	CoD.buttonStringsShortCut.primary = "@KEY_ENTER"
	CoD.buttonStringsShortCut.secondary = "@KEY_ESC_SHORT"
	CoD.buttonStringsShortCut.alt1 = "unnasigned_alt1"
	CoD.buttonStringsShortCut.alt2 = "unnasigned_alt2"
	CoD.buttonStringsShortCut.select = "@KEY_TAB"
	CoD.buttonStringsShortCut.start = "unnasigned_start"
	CoD.buttonStringsShortCut.shoulderl = "^BBUTTON_CYCLE_LEFT^"
	CoD.buttonStringsShortCut.shoulderr = "^BBUTTON_CYCLE_RIGHT^"
	CoD.buttonStringsShortCut.right_stick = "+lookstick"
	CoD.buttonStringsShortCut.left_stick_up = "unnasigned_lsu"
	CoD.buttonStringsShortCut.right_trigger = "unnasigned_rt"
	CoD.buttonStringsShortCut.left_trigger = "unnasigned_lt"
	CoD.buttonStringsShortCut.dpad_all = "@KEY_ARROWS"
	CoD.buttonStringsShortCut.dpad_ud = "@KEY_UP_DOWN_ARROWS"
	CoD.buttonStringsShortCut.dpad_lr = "@KEY_LEFT_RIGHT_ARROWS"
	CoD.buttonStringsShortCut.left = "@KEY_LEFTARROW"
	CoD.buttonStringsShortCut.up = "@KEY_UPARROW"
	CoD.buttonStringsShortCut.down = "@KEY_DOWNARROW"
	CoD.buttonStringsShortCut.actiondown = "+actionslot 2"
	CoD.buttonStringsShortCut.actionup = "+actionslot 1"
	CoD.buttonStringsShortCut.actionleft = "+actionslot 3"
	CoD.buttonStringsShortCut.actionright = "+actionslot 4"
	CoD.buttonStringsShortCut.mouse = "^BBUTTON_MOUSE_CLICK^"
	CoD.buttonStringsShortCut.mouse1 = "^BBUTTON_MOUSE_LEFT^"
	CoD.buttonStringsShortCut.mouse2 = "^BBUTTON_MOUSE_RIGHT^"
	CoD.buttonStringsShortCut.mouse3 = "^BBUTTON_MOUSE_MIDDLE^"
	CoD.buttonStringsShortCut.mouse_edit = "^BBUTTON_MOUSE_EDIT^"
	CoD.buttonStringsShortCut.wheelup = "^BMOUSE_WHEEL_UP^"
	CoD.buttonStringsShortCut.wheeldown = "^BMOUSE_WHEEL_DOWN^"
	CoD.buttonStringsShortCut.space = "@KEY_SPACE"
	CoD.buttonStringsShortCut.backspace = "@KEY_BACKSPACE"
	CoD.buttonStringsShortCut.emblem_move = "^BBUTTON_EMBLEM_MOVE^"
	CoD.buttonStringsShortCut.emblem_scale = "^BBUTTON_EMBLEM_SCALE^"
end
CoD.TweenType = {
	Linear = 0,
	Elastic = 1,
	Back = 2,
	Bounce = 3,
}
CoD.STATS_LOCATION_NORMAL = Enum[@"statslocation"][@"stats_location_normal"]
CoD.STATS_LOCATION_FORCE_NORMAL = Enum[@"statslocation"][@"stats_location_force_normal"]
CoD.STATS_LOCATION_STABLE = Enum[@"statslocation"][@"stats_location_stable"]
CoD.STATS_LOCATION_OTHERPLAYER = Enum[@"statslocation"][@"stats_location_otherplayer"]
CoD.SYSINFO_VERSION_NUMBER = Enum[@"sysinfo"][@"sysinfo_version_number"]
CoD.SYSINFO_CONNECTIVITY_INFO = Enum[@"sysinfo"][@"sysinfo_connectivity_info"]
CoD.SYSINFO_NAT_TYPE = Enum[@"sysinfo"][@"sysinfo_nat_type"]
CoD.SYSINFO_CUSTOMER_SUPPORT_LINK = Enum[@"sysinfo"][@"sysinfo_customer_support_link"]
CoD.SYSINFO_BANDWIDTH = Enum[@"sysinfo"][@"sysinfo_bandwidth"]
CoD.SYSINFO_IP_ADDRESS = Enum[@"sysinfo"][@"sysinfo_ip_address"]
CoD.SYSINFO_EXTERNAL_IP_ADDRESS = Enum[@"sysinfo"][@"sysinfo_external_ip_address"]
CoD.SYSINFO_INTERNAL_IP_ADDRESS = Enum[@"sysinfo"][@"sysinfo_internal_ip_address"]
CoD.SYSINFO_GEOGRAPHICAL_REGION = Enum[@"sysinfo"][@"sysinfo_geographical_region"]
CoD.SYSINFO_Q = Enum[@"sysinfo"][@"sysinfo_q"]
CoD.SYSINFO_CONSOLE_ID = Enum[@"sysinfo"][@"sysinfo_console_id"]
CoD.SYSINFO_MAC_ADDRESS = Enum[@"sysinfo"][@"sysinfo_mac_address"]
CoD.SYSINFO_NAT_TYPE_LOBBY = Enum[@"sysinfo"][@"sysinfo_nat_type_lobby"]
CoD.SYSINFO_CONNECTION_TYPE = Enum[@"sysinfo"][@"sysinfo_connection_type"]
CoD.ModeStringToMode = function(f11_arg0)
	if f11_arg0 == "mp" then
		return Enum[@"emodes"][@"mode_multiplayer"]
	elseif f11_arg0 == "cp" then
		return Enum[@"emodes"][@"mode_campaign"]
	elseif f11_arg0 == "zm" then
		return Enum[@"emodes"][@"mode_zombies"]
	elseif f11_arg0 == "wz" then
		return Enum[@"emodes"][@"mode_warzone"]
	else
		return Enum[@"emodes"][@"mode_invalid"]
	end
end
CoD.ModeToModeString = function(f12_arg0)
	if f12_arg0 == Enum[@"emodes"][@"mode_multiplayer"] then
		return "mp"
	elseif f12_arg0 == Enum[@"emodes"][@"mode_campaign"] then
		return "cp"
	elseif f12_arg0 == Enum[@"emodes"][@"mode_zombies"] then
		return "zm"
	elseif f12_arg0 == Enum[@"emodes"][@"mode_warzone"] then
		return "wz"
	else
	end
end
CoD.WeaponOptionFilterStringToEnum = function(f13_arg0)
	if f13_arg0 == "zm" then
		return Enum[@"weaponoptionfilter"][@"weaponoption_filter_zm"]
	elseif f13_arg0 == "mp" then
		return Enum[@"weaponoptionfilter"][@"weaponoption_filter_cp"]
	elseif f13_arg0 == "cp" then
		return Enum[@"weaponoptionfilter"][@"weaponoption_filter_zm"]
	elseif f13_arg0 == "wz" then
		return Enum[@"weaponoptionfilter"][@"hash_2A2DC91710DE214D"]
	elseif f13_arg0 == "loot" then
		return Enum[@"weaponoptionfilter"][@"weaponoption_filter_bm"]
	else
		return Enum[@"weaponoptionfilter"][@"weaponoption_filter_count"]
	end
end
CoD.WeaponOptionFilterToString = function(f14_arg0)
	if f14_arg0 == Enum[@"weaponoptionfilter"][@"weaponoption_filter_zm"] then
		return "zm"
	elseif f14_arg0 == Enum[@"weaponoptionfilter"][@"weaponoption_filter_mp"] then
		return "mp"
	elseif f14_arg0 == Enum[@"weaponoptionfilter"][@"weaponoption_filter_cp"] then
		return "cp"
	elseif f14_arg0 == Enum[@"weaponoptionfilter"][@"hash_2A2DC91710DE214D"] then
		return "wz"
	elseif f14_arg0 == Enum[@"weaponoptionfilter"][@"weaponoption_filter_bm"] then
		return "loot"
	elseif f14_arg0 == Enum[@"weaponoptionfilter"][@"weaponoption_filter_extras"] then
		return "extras"
	else
	end
end
CoD.useController = true
CoD.useMouse = false
CoD.useKeyboard = false
if CoD.isPC == true then
	CoD.useMouse = true
	CoD.useController = true
	CoD.useKeyboard = true
end
CoD.isOnlineGame = function()
	return Engine[@"sessionmode_isonlinegame"]()
end
CoD.isPublicOnlineGame = function()
	return Engine[@"sessionmode_ispubliconlinegame"]()
end
CoD.isHost = function()
	return Engine[@"getdvarbool"]("sv_running")
end
CoD.separateNumberWithCommas = function(f18_arg0)
	local f18_local0 = tostring(f18_arg0)
	local f18_local1 = string.len(f18_local0)
	local f18_local2 = nil
	for f18_local3 = f18_local1, 1, -3 do
		local f18_local6 = f18_local3 - 2
		if f18_local6 < 1 then
			f18_local6 = 1
		end
		if f18_local2 == nil then
			f18_local2 = string.sub(f18_local0, f18_local6, f18_local3)
		else
			f18_local2 = string.sub(f18_local0, f18_local6, f18_local3) .. "," .. f18_local2
		end
	end
	return f18_local2
end
CoD.GetRankName = function(f19_arg0, f19_arg1, f19_arg2)
	if not f19_arg2 then
		f19_arg2 = Engine[@"currentsessionmode"]()
	end
	if not CoD.DirectorUtility.IsSessionModeAvailable(nil, f19_arg2) then
		return Engine[@"hash_4F9F1239CFD921FE"](0x0)
	elseif f19_arg1 == 0 then
		return Engine[@"hash_4F9F1239CFD921FE"](CoD.RankUtility.GetRankInfoField(f19_arg2, f19_arg0, @"fullnameref", 0x0))
	elseif f19_arg1 == CoD.PrestigeUtility.GetPrestigeCap(f19_arg2) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/prestige_master")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4910399F02006FB7", f19_arg1)
	end
end
CoD.GetRankOrParagonIcon = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	if f20_arg0 < 0 or f20_arg1 < 0 then
		return ""
	elseif IsGameModeParagonCapable(f20_arg3) and f20_arg1 == CoD.PrestigeUtility.GetPrestigeCap(f20_arg3) and f20_arg2 ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
		return Engine[@"getparagoniconbyid"](f20_arg2, f20_arg3)
	else
		return Engine[@"getrankicon"](f20_arg0, f20_arg1, f20_arg3)
	end
end
CoD.GetUnlockRankAndLevelForItemIndex = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	local f21_local0 = Engine[@"getitemunlocklevel"](f21_arg1, f21_arg2, f21_arg4)
	return Engine[@"localize"](f21_arg3, CoD.GetRankName(f21_local0, 0, f21_arg4), f21_local0 + 1)
end
CoD.GetUnlockStringForItemIndex = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
	if not Engine[@"hasdlcforitem"](f22_arg0, f22_arg1, f22_arg2, f22_arg3) then
		local f22_local0 = Engine[@"getdlcnameforitem"](f22_arg1, f22_arg2, f22_arg3)
		if f22_local0 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"menu/" .. f22_local0 .. "_REQUIRED_HINT")
		end
	end
	return CoD.GetUnlockRankAndLevelForItemIndex(f22_arg0, f22_arg1, f22_arg2, @"menu/unlocked_at", f22_arg3)
end
CoD.PrestigeNext = function(f23_arg0)
	local f23_local0
	if tonumber(Engine[@"getstatbyname"](f23_arg0, "PLEVEL")) >= tonumber(CoD.PrestigeUtility.GetPrestigeCap()) or tonumber(Engine[@"getstatbyname"](f23_arg0, "RANK")) ~= tonumber(CoD.RankUtility.GetRankCap()) then
		f23_local0 = false
	else
		f23_local0 = true
	end
	return f23_local0
end
CoD.PrestigeNextLevelText = function(f24_arg0)
	local f24_local0 = tonumber(Engine[@"getstatbyname"](f24_arg0, "PLEVEL"))
	local f24_local1 = tonumber(CoD.PrestigeUtility.GetPrestigeCap())
	local f24_local2 = 1
	if f24_local1 - 1 <= f24_local0 then
		f24_local2 = ""
	end
	return f24_local2
end
CoD.canInviteToGame = function(f25_arg0, f25_arg1, f25_arg2)
	if f25_arg2 == nil then
		f25_arg2 = false
	end
	if not CoD.canSendInvites(f25_arg0) then
		return false
	end
	local f25_local0 = true
	if not f25_arg2 and Engine[@"isfriendfromxuid"](f25_arg0, f25_arg1) then
		f25_local0 = Engine[@"isplayerinvitable"](f25_arg0, f25_arg1)
	end
	local f25_local1 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	for f25_local5, f25_local6 in ipairs(f25_local1.sessionClients) do
		if f25_local6.xuid == f25_arg1 then
			return false
		end
	end
	if CoD.isPC and CoD.PCWidgetUtility.ShowCancelPartyInvite(f25_arg0, nil, f25_arg1) then
		return false
	elseif CoD.isPC and not CoDShared.IsGameInstalled() then
		return false
	end
	return f25_local0
end
CoD.canSendInvites = function(f26_arg0)
	if IsInTheaterMode() then
		return false
	elseif CoD.isPC and Engine[@"isingame"]() and CoD.isWarzone then
		return false
	elseif CoD.isPC and not CoDShared.IsGameInstalled() then
		return false
	elseif Dvar[@"partyprivacyenabled"]:get() and Engine[@"getpartyprivacy"]() == Enum[@"partyprivacy"][@"party_privacy_closed"] then
		return false
	end
	local f26_local0 = Enum[@"lobbytype"][@"lobby_type_private"]
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		f26_local0 = Enum[@"lobbytype"][@"lobby_type_game"]
	end
	local f26_local1 = Engine[@"islobbyhost"](f26_local0)
	if not f26_local1 then
		f26_local1 = Engine[@"inlobbyparty"](f26_local0)
	end
	local f26_local2 = Engine[@"inlobbyparty"](f26_local0)
	local f26_local3 = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f26_local0)
	local f26_local4 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], f26_local0, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	if not f26_local1 then
		local f26_local5 = f26_local2
	end
	return f26_local5 and f26_local4 < f26_local3
end
CoD.invitePlayer = function(f27_arg0, f27_arg1, f27_arg2)
	if CoD.canInviteToGame(f27_arg0, f27_arg1) then
		Engine[@"sendinvitebyxuid"](f27_arg0, f27_arg1, false)
		if CoD.isPC then
			CoD.PCUtility.ShowGameEventFromEnum(CoD.PCUtility.GameEventStrings.PARTY_INVITE_TO_PLAYER)
		end
	else
		if CoD.isPC then
			CoD.PCUtility.ShowGameEventFromEnum(CoD.PCUtility.GameEventStrings.PARTY_ERROR_UNAVAILABLE)
		end
		DebugPrint("^1LUI: ^2cannot send invite.")
	end
end
CoD.invitePlayerByGamertag = function(f28_arg0, f28_arg1, f28_arg2)
	if LuaDefine.INVALID_XUID_X64 == f28_arg1 then
		return
	elseif CoD.canInviteToGame(f28_arg0, f28_arg1, true) then
		Engine[@"lobbyevent"]("OnInvite", {
			controller = f28_arg0,
			xuid1 = f28_arg1,
			gamertag1 = f28_arg2,
			inviteCount = 1,
		})
	else
		DebugPrint("^1LUI: ^2cannot send invite.")
	end
end
CoD.IsLayerEmpty = function(f29_arg0, f29_arg1)
	if Engine[@"getselectedlayericonid"](f29_arg0, f29_arg1) == CoD.CraftUtility.EMBLEM_INVALID_ID then
		return true
	else
		return false
	end
end
CoD.SetCustomization = function(f30_arg0, f30_arg1, f30_arg2)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](DataSources.Customization.getModel(f30_arg0), f30_arg2), f30_arg1)
end
CoD.GetCustomization = function(f31_arg0, f31_arg1)
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](DataSources.Customization.getModel(f31_arg0), f31_arg1))
end
CoD.GetCodCasterTeamName = function(f32_arg0, f32_arg1)
	local f32_local0 = nil
	if CoD.CodCasterUtility.IsCodCasterAssigned(f32_arg0) and f32_arg1 == Enum[@"team_t"][@"team_spectator"] then
		f32_arg1 = Enum[@"team_t"][@"team_allies"]
	end
	if f32_arg1 == Enum[@"team_t"][@"team_allies"] then
		f32_local0 = "team1"
	elseif f32_arg1 == Enum[@"team_t"][@"team_axis"] then
		f32_local0 = "team2"
	end
	if f32_local0 then
		local f32_local1 = CoD.ShoutcasterProfileVarValue(f32_arg0, "shoutcaster_fe_" .. f32_local0 .. "_name")
		if f32_local1 ~= nil then
			if f32_local1 == "" then
				return CoD.TeamUtility.GetDefaultCodCasterTeamName(f32_local0)
			else
				return f32_local1
			end
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamName(f32_arg1))
end
CoD.GetCodCasterTeamColor = function(f33_arg0, f33_arg1)
	local f33_local0 = nil
	if f33_arg1 == Enum[@"team_t"][@"team_allies"] then
		f33_local0 = "team1"
	elseif f33_arg1 == Enum[@"team_t"][@"team_axis"] then
		f33_local0 = "team2"
	end
	if f33_local0 then
		local f33_local1 = CoD.CodCasterUtility.GetCodCasterTeamColorInformation(f33_arg0, CoD.ShoutcasterProfileVarValue(f33_arg0, "shoutcaster_fe_" .. f33_local0 .. "_color"), "color")
		if f33_local1 ~= nil then
			return f33_local1
		end
	end
	return CoD.TeamUtility.GetDefaultTeamFactionColor(f33_arg1)
end
CoD.GetLoadingScreenGameTypeIconName = function()
	local f34_local0 = Engine[@"getgametypeinfo"](Engine[@"lobbygetgametype"]())
	return f34_local0.image
end
CoD.IsTeamChangeAllowed = function(f35_arg0)
	if Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_matchmaking_playlist"]) then
		return false
	else
		local f35_local0 = LobbyData.GetCurrentMenuTarget()
		if f35_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			return false
		elseif Engine[@"getgametypesetting"](@"allowingameteamchange") == 1 then
			return true
		else
			return false
		end
	end
end
CoD.IsShoutcaster = function(f36_arg0)
	if Engine[@"isdemoplaying"]() then
		if Engine[@"isdemoshoutcaster"]() then
			return true
		end
	else
		local f36_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f36_arg0), "factions.isCoDCaster")
		local f36_local1 = true
		if f36_local0 then
			f36_local1 = Engine[@"getmodelvalue"](f36_local0)
		end
		if f36_local1 and (CoD.TeamUtility.GetTeamID(f36_arg0) == Enum[@"team_t"][@"team_spectator"] or Engine[@"isshoutcaster"](f36_arg0)) then
			return true
		end
	end
	return false
end
CoD.GetCurrentPlayerStats = function(f37_arg0)
	return CoD.GetPlayerStats(f37_arg0, Engine[0x8E494FC6037B54]())
end
CoD.GetBeforeMatchPlayerStats = function(f38_arg0)
	return CoD.GetPlayerStats(f38_arg0, Engine[@"hash_4E038E13929C6347"]())
end
CoD.GetPlayerStats = function(f39_arg0, f39_arg1)
	if f39_arg1 then
		return Engine[@"getplayerstats"](f39_arg0, f39_arg1)
	else
		return Engine[@"getplayerstats"](f39_arg0)
	end
end
CoD.ExeProfileVarBool = function(f40_arg0, f40_arg1)
	local f40_local0 = Engine[@"getplayercommongamerprofile"](f40_arg0)
	if f40_local0 ~= nil and f40_local0[f40_arg1] ~= nil and f40_local0[f40_arg1]:get() == 1 then
		return true
	else
		return false
	end
end
CoD.ShoutcasterProfileVarBool = function(f41_arg0, f41_arg1)
	local f41_local0 = Engine[@"storagegetbuffer"](f41_arg0, Enum[@"storagefiletype"][@"storage_profile_shoutcaster"])
	if f41_local0 ~= nil and f41_local0[f41_arg1] ~= nil and f41_local0[f41_arg1]:get() == 1 then
		return true
	else
		return false
	end
end
CoD.ShoutcasterProfileVarValue = function(f42_arg0, f42_arg1)
	local f42_local0 = Engine[@"storagegetbuffer"](f42_arg0, Enum[@"storagefiletype"][@"storage_profile_shoutcaster"])
	if f42_local0 ~= nil and f42_local0[f42_arg1] ~= nil then
		return f42_local0[f42_arg1]:get()
	else
		return nil
	end
end
CoD.SetShoutcasterProfileVarValue = function(f43_arg0, f43_arg1, f43_arg2)
	local f43_local0 = Engine[@"storagegetbuffer"](f43_arg0, Enum[@"storagefiletype"][@"storage_profile_shoutcaster"])
	if f43_local0 ~= nil and f43_local0[f43_arg1] ~= nil and f43_arg2 ~= nil then
		f43_local0[f43_arg1]:set(f43_arg2)
	end
	local f43_local1 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f43_arg0), "CodCaster.profileSettingsUpdated")
	if f43_local1 then
		Engine[@"forcenotifymodelsubscriptions"](f43_local1)
	end
end
CoD.SetupTeamIdentityInformation = function(f44_arg0, f44_arg1, f44_arg2)
	local f44_local0 = DataSources.TeamIdentityInformation.getModel(f44_arg1, f44_arg2)
	local f44_local1 = Enum[@"team_t"][@"team_allies"]
	if f44_arg2 == "team2" then
		f44_local1 = Enum[@"team_t"][@"team_axis"]
	end
	local f44_local2 = CoD.TeamUtility.GetDefaultTeamName(f44_local1)
	local f44_local3 = CoD.CodCasterUtility.GetDefaultCodCasterFactionIcon(f44_local1)
	local f44_local4 = ""
	local f44_local5 = CoD.TeamUtility.GetDefaultTeamFactionColor(f44_local1)
	if CoD.ShoutcasterProfileVarBool(f44_arg1, "shoutcaster_fe_team_identity") then
		if CoD.ShoutcasterProfileVarValue(f44_arg1, "shoutcaster_fe_" .. f44_arg2 .. "_name") == "" then
			f44_local2 = CoD.TeamUtility.GetDefaultCodCasterTeamName(f44_arg2)
		end
		f44_local3 = CoD.CodCasterUtility.GetCodCasterTeamLogoInformation(f44_arg1, CoD.ShoutcasterProfileVarValue(f44_arg1, "shoutcaster_fe_" .. f44_arg2 .. "_icon"), "ref")
		f44_local4 = CoD.CodCasterUtility.GetCodCasterTeamLogoInformation(f44_arg1, CoD.ShoutcasterProfileVarValue(f44_arg1, "shoutcaster_fe_" .. f44_arg2 .. "_icon"), "name")
		f44_local5 = CoD.CodCasterUtility.GetCodCasterTeamColorInformation(f44_arg1, CoD.ShoutcasterProfileVarValue(f44_arg1, "shoutcaster_fe_" .. f44_arg2 .. "_color"), "color")
	else
		f44_local2 = Engine[@"hash_4F9F1239CFD921FE"](f44_local2)
	end
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f44_local0, "teamName"), f44_local2)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f44_local0, "teamLogo"), f44_local3)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f44_local0, "teamLogoName"), f44_local4)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f44_local0, "teamColor"), f44_local5)
end
CoD.CPMPZM = function(f45_arg0, f45_arg1, f45_arg2)
	if CoD.isCampaign == true then
		return f45_arg0
	elseif CoD.isMultiplayer == true then
		return f45_arg1
	elseif CoD.isZombie == true then
		return f45_arg2
	elseif CoD.isWarzone == true then
		local f45_local0 = f45_arg1
		if f45_arg1 and type(f45_arg1) == "table" then
			f45_local0 = f45_arg1.id
		end
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lui"], "CoD.CPMPZM function called in WZ mode, using the MP result\n")
		return f45_arg1
	else
		error("Called CoD.CPMPZM function in a mode incapable of handling it")
		return nil
	end
end
CoD.CPMPZMWZ = function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
	if CoD.isCampaign == true then
		return f46_arg0
	elseif CoD.isMultiplayer == true then
		return f46_arg1
	elseif CoD.isZombie == true then
		return f46_arg2
	elseif CoD.isWarzone == true then
		return f46_arg3
	else
		error("Called CoD.CPMPZM function in a mode incapable of handling it")
		return nil
	end
end
CoD.CPMPZMINV = function(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
	if CoD.isCampaign == true then
		return f47_arg0
	elseif CoD.isMultiplayer == true then
		return f47_arg1
	elseif CoD.isZombie == true then
		return f47_arg2
	elseif CoD.isWarzone == true then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lui"], "CoD.CPMPZMINV function called in WZ mode, using the MP result of <" .. f47_arg1(">\n"))
		return f47_arg1
	else
		return f47_arg3
	end
end
CoD.UnlockablesDataSourceComparisonFunction = function(f48_arg0, f48_arg1)
	local f48_local0 = CoD.SafeGetModelValue(f48_arg0, "isBMClassified")
	local f48_local1 = CoD.SafeGetModelValue(f48_arg1, "isBMClassified")
	if f48_local0 and not f48_local1 then
		return false
	elseif not f48_local0 and f48_local1 then
		return true
	end
	f48_arg0 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f48_arg0, "itemIndex"))
	f48_arg1 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f48_arg1, "itemIndex"))
	local f48_local2 = CoD.CACUtility.WeaponListSessionMode
	local f48_local3, f48_local4 = nil
	if f48_local2 ~= nil then
		f48_local3 = Engine[@"getitemsortkey"](f48_arg0, f48_local2)
		f48_local4 = Engine[@"getitemsortkey"](f48_arg1, f48_local2)
	else
		f48_local3 = Engine[@"getitemsortkey"](f48_arg0)
		f48_local4 = Engine[@"getitemsortkey"](f48_arg1)
	end
	if f48_local3 == f48_local4 then
		return f48_arg0 < f48_arg1
	end
	return f48_local3 < f48_local4
end
CoD.UnlockablesComparisonFunction = function(f49_arg0, f49_arg1)
	local f49_local0 = Engine[@"getitemsortkey"](f49_arg0)
	local f49_local1 = Engine[@"getitemsortkey"](f49_arg1)
	if f49_local0 == f49_local1 then
		return f49_arg0 < f49_arg1
	else
		return f49_local0 < f49_local1
	end
end
CoD.GetUnlockablesByGroupName = function(f50_arg0)
	local f50_local0 = Engine[@"getunlockablesbygroupname"](f50_arg0, CoD.PrestigeUtility.GetPermanentUnlockMode())
	table.sort(f50_local0, CoD.UnlockablesComparisonFunction)
	return f50_local0
end
CoD.GetNumValuesFromSpaceSeparatedString = function(f51_arg0)
	local f51_local0 = {}
	for f51_local4 in string.gmatch(f51_arg0, "%d+%.*%d*") do
		table.insert(f51_local0, tonumber(f51_local4))
	end
	return f51_local0
end
CoD.GetVectorComponentFromString = function(f52_arg0, f52_arg1)
	if type(f52_arg0) == "string" then
		local f52_local0 = CoD.GetNumValuesFromSpaceSeparatedString(f52_arg0)
		if f52_arg1 > 0 and f52_arg1 <= #f52_local0 then
			return f52_local0[f52_arg1]
		else
			return 0
		end
	elseif f52_arg1 == 1 then
		return f52_arg0
	else
		return 0
	end
end
CoD.SwapFocusableElements = function(f53_arg0, f53_arg1, f53_arg2)
	if f53_arg1 then
		f53_arg1:processEvent({
			name = "lose_focus",
			controller = f53_arg0,
		})
		f53_arg1:makeNotFocusable(f53_arg0)
	end
	if f53_arg2 then
		f53_arg2:makeFocusableWithoutResettingNavigation(f53_arg0)
		f53_arg2:processEvent({
			name = "gain_focus",
			controller = f53_arg0,
		})
	end
end
CoD.CopyModelValue = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4)
	local f54_local0 = f54_arg1:getModel(f54_arg0, f54_arg2)
	local f54_local1 = f54_arg3:getModel(f54_arg0, f54_arg4)
	if f54_local0 and f54_local1 then
		Engine[@"setmodelvalue"](f54_local1, Engine[@"getmodelvalue"](f54_local0))
	end
end
CoD.GetTimeText = function(f55_arg0)
	local f55_local0 = f55_arg0
	local f55_local1 = math.floor(f55_local0 / 60000)
	return string.format("%d:%02d", f55_local1, (f55_local0 - f55_local1 * 60 * 1000) / 1000)
end
CoD.GetKDRatio = function(f56_arg0, f56_arg1)
	local f56_local0 = 0
	if f56_arg1 <= 0 then
		return f56_arg0
	else
		local f56_local1, f56_local2 = math.modf(f56_arg0 / f56_arg1)
		return f56_local1 .. "." .. math.floor(f56_local2 * 100)
	end
end
CoD.GetMouseFocus = function(f57_arg0)
	if f57_arg0 == nil then
		f57_arg0 = 0
		if not CoD.isFrontend then
			DebugPrint("^1LUI: ^2nil controller passed to CoD.GetMouseFocus().")
		end
	end
	local f57_local0 = LUI.currentMouseFocus[f57_arg0 + 1]
	if f57_local0 == false then
		return nil
	else
		return f57_local0
	end
end
CoD.BaseSetMouseFocus = function(f58_arg0, f58_arg1)
	if f58_arg1 == nil then
		f58_arg1 = false
	end
	if CoD.isFrontend or f58_arg0 == nil then
		if f58_arg0 == nil then
			DebugPrint("^1LUI: ^2nil controller passed to CoD.BaseSetMouseFocus().")
		end
		for f58_local0 = 1, #LUI.currentMouseFocus, 1 do
			LUI.currentMouseFocus[f58_local0] = f58_arg1
		end
	else
		LUI.currentMouseFocus[f58_arg0 + 1] = f58_arg1
	end
end
CoD.SetCurrentMouseFocus = function(f59_arg0, f59_arg1)
	CoD.BaseSetMouseFocus(f59_arg0, f59_arg1)
	if Engine[@"usingfreecursor"]() then
		local f59_local0 = DataSources.FreeCursor.getModel(f59_arg0)
		f59_local0.hasFocus:set(CoD.GetMouseFocus(f59_arg0) ~= nil)
		local f59_local1 = DataSources.FreeCursor.setupContext
		local f59_local2 = f59_arg0
		local f59_local3
		if f59_arg1 then
			f59_local3 = f59_arg1:getModel()
			if not f59_local3 then
			else
				f59_local1(f59_local2, f59_local3)
				if CoD.GetMouseFocus(f59_arg0) == nil and nil ~= LUI.DEV and Dvar[@"ui_currfocuslist"]:exists() then
					Dvar[@"ui_currfocuslist"]:set("")
					Dvar[@"ui_currfocusstates"]:set("")
				end
			end
		end
		f59_local3 = nil
	end
end
CoD.SafeGetModelValue = function(f60_arg0, f60_arg1)
	local f60_local0 = f60_arg0 and Engine[@"getmodel"](f60_arg0, f60_arg1)
	return f60_local0 and Engine[@"getmodelvalue"](f60_local0)
end
CoD.GetScriptNotifyData = function(f61_arg0)
	local f61_local0 = f61_arg0 and Engine[@"getmodel"](f61_arg0, "numArgs")
	local f61_local1 = f61_local0 and Engine[@"getmodelvalue"](f61_local0)
	local f61_local2 = nil
	if f61_local1 ~= nil and f61_local1 > 0 then
		f61_local2 = {}
	end
	for f61_local3 = 1, f61_local1, 1 do
		table.insert(f61_local2, CoD.SafeGetModelValue(f61_arg0, "arg" .. f61_local3))
	end
	return f61_local2
end
CoD.SafeGetDDL = function(f62_arg0, f62_arg1)
	if f62_arg0 then
		local f62_local0 = LUI.getTableFromPath(f62_arg1, f62_arg0)
		if f62_local0 then
			return f62_local0:get()
		end
	end
	return nil
end
CoD.GetCombatRecordStatForPath = function(f63_arg0, f63_arg1)
	local f63_local0 = f63_arg0
	for f63_local4 in string.gmatch(f63_arg1, "[%w_]+") do
		f63_local0 = f63_local0[f63_local4]
		if not f63_local0 then
			return
		end
	end
	if not f63_local0 then
		return
	end
	f63_local1 = f63_local0.statValue
	if not f63_local1 then
		return f63_local0:get()
	elseif CoD.CombatRecordMode == "public" then
		f63_local2 = f63_local0.arenaValue
		if f63_local2 then
			return f63_local1:get() - f63_local2:get()
		end
	elseif CoD.CombatRecordMode == "arena" then
		f63_local2 = f63_local0.arenaValue
		if f63_local2 then
			return f63_local2:get()
		end
	end
	return f63_local1:get()
end
CoD.GetCombatRecordStatForPathOrZero = function(f64_arg0, f64_arg1)
	local f64_local0 = CoD.GetCombatRecordStatForPath(f64_arg0, f64_arg1)
	if f64_local0 == nil then
		return 0
	else
		return f64_local0
	end
end
CoD.GetCombatRecordStatFromArgPath = function(f65_arg0, ...)
	for f65_local3, f65_local4 in ipairs({
		n = select("#", ...),
		...,
	}) do
		f65_arg0 = f65_arg0[f65_local4]
		if not f65_arg0 then
			return
		end
	end
	f65_local0 = f65_arg0[@"statvalue"]
	if not f65_local0 then
		return
	elseif LuaUtils.IsArenaMode() == false then
		f65_local1 = f65_arg0[@"arenavalue"]
		if f65_local1 then
			return f65_local0:get() - f65_local1:get()
		end
	elseif LuaUtils.IsArenaMode() == true then
		f65_local1 = f65_arg0[@"arenavalue"]
		if f65_local1 then
			return f65_local1:get()
		end
	end
	return f65_local0:get()
end
CoD.GetCombatRecordStatFromArgPathOrZero = function(f66_arg0, ...)
	return CoD.GetCombatRecordStatForPath(f66_arg0, ...) or 0
end
CoD.GetCombatRecordMode = function()
	local f67_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "combatRecordMode")
	if f67_local0 == "cp" then
		return Enum[@"emodes"][@"mode_campaign"]
	elseif f67_local0 == "zm" or f67_local0 == "doa" then
		return Enum[@"emodes"][@"mode_zombies"]
	else
		return Enum[@"emodes"][@"mode_multiplayer"]
	end
end
CoD.GetCombatRecordModeAbbreviation = function()
	local f68_local0 = CoD.GetCombatRecordMode()
	if f68_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		return "mp"
	elseif f68_local0 == Enum[@"emodes"][@"mode_campaign"] then
		return "cp"
	elseif f68_local0 == Enum[@"emodes"][@"mode_zombies"] then
		return "mp"
	else
	end
end
CoD.GetCombatRecordStats = function(f69_arg0)
	if CoD.CombatRecordOtherPlayerStats then
		return Engine[@"getotherplayerstatsbuffer"]()
	elseif CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "combatRecordMode") == "cp" then
		return Engine[@"storagegetbuffer"](f69_arg0, Enum[@"storagefiletype"][@"storage_cp_stats_online"])
	elseif CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "combatRecordMode") == "zm" then
		return Engine[@"storagegetbuffer"](f69_arg0, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	else
		return Engine[@"storagegetbuffer"](f69_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end
end
CoD.GetCombatRecordComparisonStats = function(f70_arg0)
	if CoD.CombatRecordOtherPlayerStats then
		if CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "combatRecordMode") == "cp" then
			return Engine[@"storagegetbuffer"](f70_arg0, Enum[@"storagefiletype"][@"storage_cp_stats_online"])
		elseif CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "combatRecordMode") == "zm" then
			return Engine[@"storagegetbuffer"](f70_arg0, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
		else
			return Engine[@"storagegetbuffer"](f70_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		end
	else
		return Engine[@"getotherplayerstatsbuffer"]()
	end
end
CoD.GetDisplayRatioFromTwoStats = function(f71_arg0, f71_arg1)
	if f71_arg0 and f71_arg1 then
		local f71_local0 = nil
		if f71_arg1 == 0 then
			f71_arg1 = 1
		end
		f71_local0 = f71_arg0 / f71_arg1
		if f71_local0 >= 100 then
			return math.floor(f71_local0 + 0.5)
		else
			return string.format("%.2f", math.floor(f71_local0 * 100 + 0.5) / 100)
		end
	else
		return ""
	end
end
CoD.GetLocalClientAdjustedNum = function(f72_arg0)
	if CoD.isFrontend then
		return 0
	else
		return Engine[@"getlocalclientnum"](f72_arg0)
	end
end
CoD.LUIElemHeightEnum = {
	Default = 0,
	Small = 1,
	Large = 2,
	XL = 3,
}
CoD.setTextSizeFromHeightEnum = function(f73_arg0)
	if f73_arg0 == CoD.LUIElemHeightEnum.Default then
		return 37
	elseif f73_arg0 == CoD.LUIElemHeightEnum.Small then
		return 30
	elseif f73_arg0 == CoD.LUIElemHeightEnum.Large then
		return 54
	else
		return 72
	end
end
