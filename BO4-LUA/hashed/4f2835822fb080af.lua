if CoD == nil then
	CoD = {}
end
CoD.UpdateConsoleColors = function(f1_arg0)
	if CoD.ColorUtility then
		CoD.ColorUtility.ConsoleColors[f1_arg0.controller] = f1_arg0.colors
	end
end
CoD.TestFFOTDFnOverride = function()
	Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "Failed to override UI VM funtion from FFOTD.\n")
	error("Failed to override UI VM funtion from FFOTD.")
end
CoD.ButtonMappings = {}
local f0_local0 = Engine[0x4069DE29EEDD103]()
CoD.isDurango = f0_local0 == "durango"
CoD.isPC = f0_local0 == "pc"
CoD.isPS4 = f0_local0 == "orbis"
CoD.mapsTable = Engine[0xF21A889CC4B74F9]()
CoD.DLCBits = {
	CONTENT_UNKNOWN = Enum[0xE2A6806BB83D51C][0x7573E9DC14E9ECF],
	CONTENT_ORIGINALMAPS = Enum[0xE2A6806BB83D51C][0x8F57745D21DF973],
	CONTENT_DLC0ZM = Enum[0xE2A6806BB83D51C][0xD0159800EF882D],
	CONTENT_DLC2MP = Enum[0xE2A6806BB83D51C][0x29A60980B253C57],
	CONTENT_DLC1ZM = Enum[0xE2A6806BB83D51C][0x8261E9804B77826],
	CONTENT_DLC3MP = Enum[0xE2A6806BB83D51C][0xA487F980F37C788],
	CONTENT_DLC2ZM = Enum[0xE2A6806BB83D51C][0x2B943980B3FBB9F],
	CONTENT_DLC4MP = Enum[0xE2A6806BB83D51C][0xCEE5E97EC437975],
	CONTENT_DLC3ZM = Enum[0xE2A6806BB83D51C][0xA298C980F1D2D10],
	CONTENT_DLC5MP = Enum[0xE2A6806BB83D51C][0x7448D97F2981FCE],
	CONTENT_DLC4ZM = Enum[0xE2A6806BB83D51C][0xCAD7197EC0C02C9],
	CONTENT_DLC6MP = Enum[0xE2A6806BB83D51C][0xEFFA497F6B527C3],
	CONTENT_DLC5ZM = Enum[0xE2A6806BB83D51C][0x7699A97F2B75222],
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
	[Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]] = {
		products = {
			[CoD.DLCBits.CONTENT_DLC2MP] = "mpdlc1",
			[CoD.DLCBits.CONTENT_DLC3MP] = "mpdlc2",
			[CoD.DLCBits.CONTENT_DLC4MP] = "mpdlc3",
			[CoD.DLCBits.CONTENT_DLC5MP] = "mpdlc4",
			[CoD.DLCBits.CONTENT_DLC6MP] = "mpdlc5",
		},
		known = 0,
	},
	[Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]] = {
		products = {
			[CoD.DLCBits.CONTENT_DLC0ZM] = "zombiesdlc0",
			[CoD.DLCBits.CONTENT_DLC1ZM] = "zmdlc1",
			[CoD.DLCBits.CONTENT_DLC2ZM] = "zmdlc2",
			[CoD.DLCBits.CONTENT_DLC3ZM] = "zmdlc3",
			[CoD.DLCBits.CONTENT_DLC4ZM] = "zmdlc4",
		},
		known = 0,
	},
	[Enum[0x9C0C2196D8313A0][0x60063C67132EB69]] = {
		products = {},
		known = 0,
	},
	[Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]] = {
		products = {},
		known = 0,
	},
	[Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE]] = {
		products = {},
		known = 0,
	},
}
CoD.profileKey_gametype = 0x792C1F90C3A5C7F
CoD.profileKey_map = 0x80F5919176D2D91
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
		Engine[0x39E704619FEB20F](f3_arg0)
	end
end
CoD.PlayFrontendMusicForLobby = function(f4_arg0)
	local f4_local0 = nil
	local f4_local1 = LobbyData.GetLobbyMenuByID(f4_arg0)
	if f4_local1[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x79D01499920B292] and CoD.PCKoreaUtility.ShowKorea15Plus() then
		return
	else
		f4_local0 = f4_local1 and f4_local1[0x9F541C0AE41279]
		if not f4_local0 or f0_local1 == f4_local0 then
			return
		else
			f0_local1 = f4_local0
			Engine[0x39E704619FEB20F](f4_local0)
		end
	end
end
CoD.StopFrontendMusic = function()
	Engine[0x39E704619FEB20F]("")
end
CoD.ResetFrontendMusic = function()
	Engine[0x39E704619FEB20F](f0_local1)
end
CoD.Currencies = {}
CoD.Currencies.COD_POINTS = 0xB7F40FB4E8165B5
CoD.Currencies.ZM_NEBULIUM_PLASMA = 0x29BE58E64C4830B
CoD.Currencies.MP_PRESTIGE_TOKEN = 0x7383BC9312521B2
CoD.Currencies.ZM_PRESTIGE_TOKEN = 0x3EDC88C2BF44B8A
CoD.Currencies.DOTD_INCENTIVE_TOKEN = 0x1C7EA5D9369C760
CoD.Currencies.BLACKOPSPASS_INCENTIVE_TOKEN = 0x8A567E09E922681
CoD.weaponAttributes = 0xAB70A73C80987CF
CoD.scoreInfoTableMP = 0x8C87487ED1A7400
CoD.scoreInfoTableZM = 0x458380C310907D8
CoD.scoreInfoTableWZ = 0x4C20A4E91609EE8
CoD.weaponOptions = 0x2836CDB1280A2E4
CoD.ScoreInfoTable = {}
CoD.ScoreInfoTable.BaseMPTable = 0x6B11084B77644F7
CoD.ScoreInfoTable.BaseWZTable = 0x7EA4C79706FD49B
CoD.ScoreInfoTable.ScriptRefCol = 0
CoD.ScoreInfoTable.MedalXPCol = 2
CoD.ScoreInfoTable.MedalRefCol = 10
CoD.ScoreInfoTable.MedalAssetCol = 11
CoD.ScoreInfoTable.MedalCategoryCol = 15
CoD.isFrontend = Engine[0xB87231BF773995E]() == "core_frontend"
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
	CoD.isFrontend = Engine[0xB87231BF773995E]() == "core_frontend"
	Engine[0xB177D654FFB67BE]("splitscreen_horizontal", Engine[0xB72F603CAC75B3A](f7_arg0.controller, "splitscreenOrientation"))
	if IsGameTypeDOA() then
		Engine[0xB177D654FFB67BE]("ui_blocksaves", "1")
	end
	if CoD.CACUtility then
		CoD.CACUtility.UnlockablesTable = nil
	end
	CoD.gameModeEnum = Engine[0x3EAC408F958FF05]()
	if CoD.PlayerRoleUtility then
		for f7_local0 = Enum[0x9C0C2196D8313A0][0x85320C1E5C16613], Enum[0x9C0C2196D8313A0][0x96642BDE9B5962E] - 1, 1 do
			if f7_local0 ~= CoD.gameModeEnum then
				CoD.PlayerRoleUtility.Heroes.HeroList[f7_local0] = nil
				CoD.PlayerRoleUtility.Heroes.HeroListSorted[f7_local0] = nil
				CoD.PlayerRoleUtility.Heroes.HeroInfo[f7_local0] = nil
				CoD.PlayerRoleUtility.Heroes.HeroCustomization[f7_local0] = nil
			end
		end
	end
	if CoD.gameModeEnum == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		CoD.isMultiplayer = true
		CoD.scoreInfoTable = CoD.scoreInfoTableMP
		CoD.weaponAttributes = 0xAB70A73C80987CF
		CoD.statsMilestonePath = 0x87CF26422669B76
		CoD.gunLevelsTable = 0x7D6337A77EF98AD
		CoD.emblemIconsTable = 0x25E8C4A61C9BFDA
		CoD.gameMode = "MP"
		CoD.profileKey_gametype = 0x792C1F90C3A5C7F
		CoD.profileKey_map = 0x80F5919176D2D91
		CoD.isModeSelected = true
		local f7_local0 = Engine[0x69811927938FCD7]()
		if not f7_local0 or f7_local0 == "" then
			f7_local0 = Dvar[0xFF54369D6573B91]:get() or ""
		end
		CoD.scoreInfoTable = 0x93A1C8D4C90544 .. string.gsub(string.gsub(string.gsub(string.gsub(f7_local0, "_hc", ""), "_cwl", ""), "_bb", ""), "_dm", "") .. ".csv"
	end
	if CoD.gameModeEnum == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		CoD.isCampaign = true
		CoD.protoMapsTable = 0x160D3837EDD2EDB
		CoD.statsMilestonePath = 0x929B58638C59880
		CoD.scoreInfoTable = 0xFF88B807408D20A
		CoD.weaponAttributes = 0x8CD79CD0F5DC983
		CoD.statsMilestone = 0x4208F5B04921371
		CoD.gunLevelsTable = 0x150230C4105DC11
		CoD.gameMode = "CP"
		CoD.isModeSelected = true
		CoD.profileKey_gametype = 0x18F3F96B2374B6B
		CoD.profileKey_map = 0x9EBC53C8753C0E1
	end
	if CoD.gameModeEnum == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		CoD.isZombie = true
		CoD.weaponAttributes = 0x297479F395531C3
		CoD.statsMilestonePath = 0x4A621A5800B5B4A
		CoD.profileKey_gametype = 0x1DD2E96B2794FD9
		CoD.profileKey_map = 0xA03CC3C87685EA7
		CoD.gameMode = "ZM"
		CoD.isModeSelected = true
		CoD.gunLevelsTable = 0xEA60CF27BEDFA51
		CoD.emblemIconsTable = 0x25E8C4A61C9BFDA
		CoD.scoreInfoTable = CoD.scoreInfoTableZM
	end
	if CoD.gameModeEnum == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		CoD.isWarzone = true
		CoD.scoreInfoTable = 0x7EA4C79706FD49B
		CoD.weaponAttributes = 0xAB70A73C80987CF
		CoD.statsMilestonePath = 0x87CF26422669B76
		CoD.gunLevelsTable = 0x7D6337A77EF98AD
		CoD.emblemIconsTable = 0x25E8C4A61C9BFDA
		CoD.profileKey_gametype = 0x1D34196B2711B9D
		CoD.profileKey_map = 0xA2FC33C878D8A47
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
		f8_arg1 = Engine[0x3EAC408F958FF05]()
	end
	if f8_arg1 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		return 0x929B58638C59880 .. f8_arg0 .. ".csv"
	elseif f8_arg1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		return 0x87CF26422669B76 .. f8_arg0 .. ".csv"
	elseif f8_arg1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return 0x4A621A5800B5B4A .. f8_arg0 .. ".csv"
	elseif f8_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return 0x128A0E3BB01AA7E .. f8_arg0 .. ".csv"
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
if Enum[0xAA0EE37DF15F5A8][0xD4A7E4FA92D24E1] == Dvar[0xA97AE527D90FB24]:get() then
	CoD.textSize.ExtraSmall = 20
	CoD.textSize.Default = 21
	CoD.textSize.Condensed = 24
	CoD.textSize.Big = 36
elseif Enum[0xAA0EE37DF15F5A8][0xD31CB900BD1AC99] == Dvar[0xA97AE527D90FB24]:get() then
	CoD.textSize.ExtraSmall = 16
	CoD.textSize.Default = 19
	CoD.textSize.Condensed = 21
	CoD.textSize.Big = 32
elseif Enum[0xAA0EE37DF15F5A8][0x5D4AD876D4B4D93] == Dvar[0xA97AE527D90FB24]:get() or Enum[0xAA0EE37DF15F5A8][0x9A4194D08679C69] == Dvar[0xA97AE527D90FB24]:get() then
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
CoD.STATS_LOCATION_NORMAL = Enum[0x303F77CADBF82AB][0xF27E237306A62E0]
CoD.STATS_LOCATION_FORCE_NORMAL = Enum[0x303F77CADBF82AB][0xCE72C1C740420F0]
CoD.STATS_LOCATION_STABLE = Enum[0x303F77CADBF82AB][0x6E606A76A3BEE20]
CoD.STATS_LOCATION_OTHERPLAYER = Enum[0x303F77CADBF82AB][0x74C9883C7987112]
CoD.SYSINFO_VERSION_NUMBER = Enum[0x13520493EA3E4E6][0x3516FC0653CED2B]
CoD.SYSINFO_CONNECTIVITY_INFO = Enum[0x13520493EA3E4E6][0x97F7B44378BF205]
CoD.SYSINFO_NAT_TYPE = Enum[0x13520493EA3E4E6][0x4E2FBBB564A15A7]
CoD.SYSINFO_CUSTOMER_SUPPORT_LINK = Enum[0x13520493EA3E4E6][0x358DF5F927588D8]
CoD.SYSINFO_BANDWIDTH = Enum[0x13520493EA3E4E6][0x3F8854901700D98]
CoD.SYSINFO_IP_ADDRESS = Enum[0x13520493EA3E4E6][0xE0AEC71385FF185]
CoD.SYSINFO_EXTERNAL_IP_ADDRESS = Enum[0x13520493EA3E4E6][0x173BB5389A4757]
CoD.SYSINFO_INTERNAL_IP_ADDRESS = Enum[0x13520493EA3E4E6][0x4F5D644F387FEF9]
CoD.SYSINFO_GEOGRAPHICAL_REGION = Enum[0x13520493EA3E4E6][0xCAF3EF4DC7AEB72]
CoD.SYSINFO_Q = Enum[0x13520493EA3E4E6][0x902208E2581595E]
CoD.SYSINFO_CONSOLE_ID = Enum[0x13520493EA3E4E6][0xD6F5B6C5A26B198]
CoD.SYSINFO_MAC_ADDRESS = Enum[0x13520493EA3E4E6][0xD7181B02CCB471]
CoD.SYSINFO_NAT_TYPE_LOBBY = Enum[0x13520493EA3E4E6][0x6E84D083A157F20]
CoD.SYSINFO_CONNECTION_TYPE = Enum[0x13520493EA3E4E6][0xCB3FA94B87B3254]
CoD.ModeStringToMode = function(f11_arg0)
	if f11_arg0 == "mp" then
		return Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	elseif f11_arg0 == "cp" then
		return Enum[0x9C0C2196D8313A0][0x60063C67132EB69]
	elseif f11_arg0 == "zm" then
		return Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]
	elseif f11_arg0 == "wz" then
		return Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]
	else
		return Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE]
	end
end
CoD.ModeToModeString = function(f12_arg0)
	if f12_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		return "mp"
	elseif f12_arg0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		return "cp"
	elseif f12_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return "zm"
	elseif f12_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return "wz"
	else
	end
end
CoD.WeaponOptionFilterStringToEnum = function(f13_arg0)
	if f13_arg0 == "zm" then
		return Enum[0x35EF5EB24C7CAA2][0xA37D61710E68BE9]
	elseif f13_arg0 == "mp" then
		return Enum[0x35EF5EB24C7CAA2][0xA55C71710FF6FFB]
	elseif f13_arg0 == "cp" then
		return Enum[0x35EF5EB24C7CAA2][0xA37D61710E68BE9]
	elseif f13_arg0 == "wz" then
		return Enum[0x35EF5EB24C7CAA2][0xA2DC91710DE214D]
	elseif f13_arg0 == "loot" then
		return Enum[0x35EF5EB24C7CAA2][0xA52D61710FD53A1]
	else
		return Enum[0x35EF5EB24C7CAA2][0xB36D6E5C4AFBC7F]
	end
end
CoD.WeaponOptionFilterToString = function(f14_arg0)
	if f14_arg0 == Enum[0x35EF5EB24C7CAA2][0xA37D61710E68BE9] then
		return "zm"
	elseif f14_arg0 == Enum[0x35EF5EB24C7CAA2][0xA77C317111C4F95] then
		return "mp"
	elseif f14_arg0 == Enum[0x35EF5EB24C7CAA2][0xA55C71710FF6FFB] then
		return "cp"
	elseif f14_arg0 == Enum[0x35EF5EB24C7CAA2][0xA2DC91710DE214D] then
		return "wz"
	elseif f14_arg0 == Enum[0x35EF5EB24C7CAA2][0xA52D61710FD53A1] then
		return "loot"
	elseif f14_arg0 == Enum[0x35EF5EB24C7CAA2][0x17115CF3063829F] then
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
	return Engine[0xE89628E21B49660]()
end
CoD.isPublicOnlineGame = function()
	return Engine[0x8BF601ABD141DF9]()
end
CoD.isHost = function()
	return Engine[0x9E5BE3B4BBA4E0E]("sv_running")
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
		f19_arg2 = Engine[0x3EAC408F958FF05]()
	end
	if not CoD.DirectorUtility.IsSessionModeAvailable(nil, f19_arg2) then
		return Engine[0xF9F1239CFD921FE](0x0)
	elseif f19_arg1 == 0 then
		return Engine[0xF9F1239CFD921FE](CoD.RankUtility.GetRankInfoField(f19_arg2, f19_arg0, 0x3E538ACFBFDD718, 0x0))
	elseif f19_arg1 == CoD.PrestigeUtility.GetPrestigeCap(f19_arg2) then
		return Engine[0xF9F1239CFD921FE](0xD87A39C0FE06CA1)
	else
		return Engine[0xF9F1239CFD921FE](0x910399F02006FB7, f19_arg1)
	end
end
CoD.GetRankOrParagonIcon = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	if f20_arg0 < 0 or f20_arg1 < 0 then
		return ""
	elseif IsGameModeParagonCapable(f20_arg3) and f20_arg1 == CoD.PrestigeUtility.GetPrestigeCap(f20_arg3) and f20_arg2 ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
		return Engine[0x142BF2BEA87722E](f20_arg2, f20_arg3)
	else
		return Engine[0x9C6922557618920](f20_arg0, f20_arg1, f20_arg3)
	end
end
CoD.GetUnlockRankAndLevelForItemIndex = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	local f21_local0 = Engine[0x6A28AE1C9C05372](f21_arg1, f21_arg2, f21_arg4)
	return Engine[0xED84C33EC5F01EA](f21_arg3, CoD.GetRankName(f21_local0, 0, f21_arg4), f21_local0 + 1)
end
CoD.GetUnlockStringForItemIndex = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
	if not Engine[0x195EDEFFB47F120](f22_arg0, f22_arg1, f22_arg2, f22_arg3) then
		local f22_local0 = Engine[0x708EB21A8740A71](f22_arg1, f22_arg2, f22_arg3)
		if f22_local0 then
			return Engine[0xF9F1239CFD921FE](0x93E7CC7D7789D8F .. f22_local0 .. "_REQUIRED_HINT")
		end
	end
	return CoD.GetUnlockRankAndLevelForItemIndex(f22_arg0, f22_arg1, f22_arg2, 0x10EFA40E4B9F78E, f22_arg3)
end
CoD.PrestigeNext = function(f23_arg0)
	local f23_local0
	if tonumber(Engine[0x637B53CC6A00D27](f23_arg0, "PLEVEL")) >= tonumber(CoD.PrestigeUtility.GetPrestigeCap()) or tonumber(Engine[0x637B53CC6A00D27](f23_arg0, "RANK")) ~= tonumber(CoD.RankUtility.GetRankCap()) then
		f23_local0 = false
	else
		f23_local0 = true
	end
	return f23_local0
end
CoD.PrestigeNextLevelText = function(f24_arg0)
	local f24_local0 = tonumber(Engine[0x637B53CC6A00D27](f24_arg0, "PLEVEL"))
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
	if not f25_arg2 and Engine[0x3176B986956D1B3](f25_arg0, f25_arg1) then
		f25_local0 = Engine[0x40943B6BA0CC6A](f25_arg0, f25_arg1)
	end
	local f25_local1 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
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
	elseif CoD.isPC and Engine[0x7B48C1ABFF0F764]() and CoD.isWarzone then
		return false
	elseif CoD.isPC and not CoDShared.IsGameInstalled() then
		return false
	elseif Dvar[0xE52CB4B7B32961A]:get() and Engine[0xB4EEE57E45369DB]() == Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
		return false
	end
	local f26_local0 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	if Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		f26_local0 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
	end
	local f26_local1 = Engine[0xEA2BE00F49480D](f26_local0)
	if not f26_local1 then
		f26_local1 = Engine[0x47928339DC88872](f26_local0)
	end
	local f26_local2 = Engine[0x47928339DC88872](f26_local0)
	local f26_local3 = Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f26_local0)
	local f26_local4 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f26_local0, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	if not f26_local1 then
		local f26_local5 = f26_local2
	end
	return f26_local5 and f26_local4 < f26_local3
end
CoD.invitePlayer = function(f27_arg0, f27_arg1, f27_arg2)
	if CoD.canInviteToGame(f27_arg0, f27_arg1) then
		Engine[0xDC0ACA64436EDC1](f27_arg0, f27_arg1, false)
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
		Engine[0x87AE7E64BA5AD61]("OnInvite", {
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
	if Engine[0xAA4B5B49E490A7](f29_arg0, f29_arg1) == CoD.CraftUtility.EMBLEM_INVALID_ID then
		return true
	else
		return false
	end
end
CoD.SetCustomization = function(f30_arg0, f30_arg1, f30_arg2)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](DataSources.Customization.getModel(f30_arg0), f30_arg2), f30_arg1)
end
CoD.GetCustomization = function(f31_arg0, f31_arg1)
	return Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](DataSources.Customization.getModel(f31_arg0), f31_arg1))
end
CoD.GetCodCasterTeamName = function(f32_arg0, f32_arg1)
	local f32_local0 = nil
	if CoD.CodCasterUtility.IsCodCasterAssigned(f32_arg0) and f32_arg1 == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
		f32_arg1 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
	end
	if f32_arg1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		f32_local0 = "team1"
	elseif f32_arg1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
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
	return Engine[0xF9F1239CFD921FE](CoD.TeamUtility.GetDefaultTeamName(f32_arg1))
end
CoD.GetCodCasterTeamColor = function(f33_arg0, f33_arg1)
	local f33_local0 = nil
	if f33_arg1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		f33_local0 = "team1"
	elseif f33_arg1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
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
	local f34_local0 = Engine[0xEA74FA7EE46E195](Engine[0x69811927938FCD7]())
	return f34_local0.image
end
CoD.IsTeamChangeAllowed = function(f35_arg0)
	if Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x95910ACF90F64AD]) then
		return false
	else
		local f35_local0 = LobbyData.GetCurrentMenuTarget()
		if f35_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			return false
		elseif Engine[0xDBC2AD5002B261B](0x9088FF007A6191A) == 1 then
			return true
		else
			return false
		end
	end
end
CoD.IsShoutcaster = function(f36_arg0)
	if Engine[0xA55C3ACD0D2BCF0]() then
		if Engine[0x15858452493DB17]() then
			return true
		end
	else
		local f36_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f36_arg0), "factions.isCoDCaster")
		local f36_local1 = true
		if f36_local0 then
			f36_local1 = Engine[0x614D394F6F9A18D](f36_local0)
		end
		if f36_local1 and (CoD.TeamUtility.GetTeamID(f36_arg0) == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] or Engine[0x10EC0F87E8F63A](f36_arg0)) then
			return true
		end
	end
	return false
end
CoD.GetCurrentPlayerStats = function(f37_arg0)
	return CoD.GetPlayerStats(f37_arg0, Engine[0x8E494FC6037B54]())
end
CoD.GetBeforeMatchPlayerStats = function(f38_arg0)
	return CoD.GetPlayerStats(f38_arg0, Engine[0xE038E13929C6347]())
end
CoD.GetPlayerStats = function(f39_arg0, f39_arg1)
	if f39_arg1 then
		return Engine[0xA6C26EBACD7322D](f39_arg0, f39_arg1)
	else
		return Engine[0xA6C26EBACD7322D](f39_arg0)
	end
end
CoD.ExeProfileVarBool = function(f40_arg0, f40_arg1)
	local f40_local0 = Engine[0x3745B56C88F5316](f40_arg0)
	if f40_local0 ~= nil and f40_local0[f40_arg1] ~= nil and f40_local0[f40_arg1]:get() == 1 then
		return true
	else
		return false
	end
end
CoD.ShoutcasterProfileVarBool = function(f41_arg0, f41_arg1)
	local f41_local0 = Engine[0x8BF970606552F4C](f41_arg0, Enum[0xBBD4F9E70101BA8][0xED1503A2D3DAE6])
	if f41_local0 ~= nil and f41_local0[f41_arg1] ~= nil and f41_local0[f41_arg1]:get() == 1 then
		return true
	else
		return false
	end
end
CoD.ShoutcasterProfileVarValue = function(f42_arg0, f42_arg1)
	local f42_local0 = Engine[0x8BF970606552F4C](f42_arg0, Enum[0xBBD4F9E70101BA8][0xED1503A2D3DAE6])
	if f42_local0 ~= nil and f42_local0[f42_arg1] ~= nil then
		return f42_local0[f42_arg1]:get()
	else
		return nil
	end
end
CoD.SetShoutcasterProfileVarValue = function(f43_arg0, f43_arg1, f43_arg2)
	local f43_local0 = Engine[0x8BF970606552F4C](f43_arg0, Enum[0xBBD4F9E70101BA8][0xED1503A2D3DAE6])
	if f43_local0 ~= nil and f43_local0[f43_arg1] ~= nil and f43_arg2 ~= nil then
		f43_local0[f43_arg1]:set(f43_arg2)
	end
	local f43_local1 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f43_arg0), "CodCaster.profileSettingsUpdated")
	if f43_local1 then
		Engine[0x6A489878620F3BC](f43_local1)
	end
end
CoD.SetupTeamIdentityInformation = function(f44_arg0, f44_arg1, f44_arg2)
	local f44_local0 = DataSources.TeamIdentityInformation.getModel(f44_arg1, f44_arg2)
	local f44_local1 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
	if f44_arg2 == "team2" then
		f44_local1 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
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
		f44_local2 = Engine[0xF9F1239CFD921FE](f44_local2)
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f44_local0, "teamName"), f44_local2)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f44_local0, "teamLogo"), f44_local3)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f44_local0, "teamLogoName"), f44_local4)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f44_local0, "teamColor"), f44_local5)
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
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x71E8B35DBF101D7], "CoD.CPMPZM function called in WZ mode, using the MP result\n")
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
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x71E8B35DBF101D7], "CoD.CPMPZMINV function called in WZ mode, using the MP result of <" .. f47_arg1(">\n"))
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
	f48_arg0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f48_arg0, "itemIndex"))
	f48_arg1 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f48_arg1, "itemIndex"))
	local f48_local2 = CoD.CACUtility.WeaponListSessionMode
	local f48_local3, f48_local4 = nil
	if f48_local2 ~= nil then
		f48_local3 = Engine[0x9996A31F81AC8FB](f48_arg0, f48_local2)
		f48_local4 = Engine[0x9996A31F81AC8FB](f48_arg1, f48_local2)
	else
		f48_local3 = Engine[0x9996A31F81AC8FB](f48_arg0)
		f48_local4 = Engine[0x9996A31F81AC8FB](f48_arg1)
	end
	if f48_local3 == f48_local4 then
		return f48_arg0 < f48_arg1
	end
	return f48_local3 < f48_local4
end
CoD.UnlockablesComparisonFunction = function(f49_arg0, f49_arg1)
	local f49_local0 = Engine[0x9996A31F81AC8FB](f49_arg0)
	local f49_local1 = Engine[0x9996A31F81AC8FB](f49_arg1)
	if f49_local0 == f49_local1 then
		return f49_arg0 < f49_arg1
	else
		return f49_local0 < f49_local1
	end
end
CoD.GetUnlockablesByGroupName = function(f50_arg0)
	local f50_local0 = Engine[0xCE5D53FB879DE17](f50_arg0, CoD.PrestigeUtility.GetPermanentUnlockMode())
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
		Engine[0x83C9B5DE1D9371](f54_local1, Engine[0x614D394F6F9A18D](f54_local0))
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
	if Engine[0x8069F5969D47DEF]() then
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
				if CoD.GetMouseFocus(f59_arg0) == nil and nil ~= LUI.DEV and Dvar[0x3B8B4D0064475D4]:exists() then
					Dvar[0x3B8B4D0064475D4]:set("")
					Dvar[0x196FDA5E89973C6]:set("")
				end
			end
		end
		f59_local3 = nil
	end
end
CoD.SafeGetModelValue = function(f60_arg0, f60_arg1)
	local f60_local0 = f60_arg0 and Engine[0x40E824FE270E174](f60_arg0, f60_arg1)
	return f60_local0 and Engine[0x614D394F6F9A18D](f60_local0)
end
CoD.GetScriptNotifyData = function(f61_arg0)
	local f61_local0 = f61_arg0 and Engine[0x40E824FE270E174](f61_arg0, "numArgs")
	local f61_local1 = f61_local0 and Engine[0x614D394F6F9A18D](f61_local0)
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
	f65_local0 = f65_arg0[0x3BF77799B56C06C]
	if not f65_local0 then
		return
	elseif LuaUtils.IsArenaMode() == false then
		f65_local1 = f65_arg0[0x29D03CD36A9D999]
		if f65_local1 then
			return f65_local0:get() - f65_local1:get()
		end
	elseif LuaUtils.IsArenaMode() == true then
		f65_local1 = f65_arg0[0x29D03CD36A9D999]
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
	local f67_local0 = CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "combatRecordMode")
	if f67_local0 == "cp" then
		return Enum[0x9C0C2196D8313A0][0x60063C67132EB69]
	elseif f67_local0 == "zm" or f67_local0 == "doa" then
		return Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]
	else
		return Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	end
end
CoD.GetCombatRecordModeAbbreviation = function()
	local f68_local0 = CoD.GetCombatRecordMode()
	if f68_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		return "mp"
	elseif f68_local0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		return "cp"
	elseif f68_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return "mp"
	else
	end
end
CoD.GetCombatRecordStats = function(f69_arg0)
	if CoD.CombatRecordOtherPlayerStats then
		return Engine[0x601DCCC0A9186D7]()
	elseif CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "combatRecordMode") == "cp" then
		return Engine[0x8BF970606552F4C](f69_arg0, Enum[0xBBD4F9E70101BA8][0xA5B261DA142B9F6])
	elseif CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "combatRecordMode") == "zm" then
		return Engine[0x8BF970606552F4C](f69_arg0, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	else
		return Engine[0x8BF970606552F4C](f69_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end
end
CoD.GetCombatRecordComparisonStats = function(f70_arg0)
	if CoD.CombatRecordOtherPlayerStats then
		if CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "combatRecordMode") == "cp" then
			return Engine[0x8BF970606552F4C](f70_arg0, Enum[0xBBD4F9E70101BA8][0xA5B261DA142B9F6])
		elseif CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "combatRecordMode") == "zm" then
			return Engine[0x8BF970606552F4C](f70_arg0, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
		else
			return Engine[0x8BF970606552F4C](f70_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
		end
	else
		return Engine[0x601DCCC0A9186D7]()
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
		return Engine[0x7192908F4764ED3](f72_arg0)
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
