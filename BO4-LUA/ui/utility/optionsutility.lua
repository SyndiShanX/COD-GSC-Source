require("x64:b5d5f7ffe97a9a7")
require("x64:be06f4309b61a6f")
require("x64:f3c5259f470592d")
CoD.SafeArea = {}
CoD.SafeArea.DefaultWidthHeightRatioPC = CoD.isPC and Dvar[0x5CD540599443549]:get() or nil
CoD.SafeArea.MinimumWidthHeightRatioPC = CoD.isPC and Dvar[0x27DBAC5B98A0234]:get() or nil
CoD.SafeArea.Minimum = 0.9
CoD.SafeArea.Maximum = 1
CoD.SafeArea.AdjustAmount = 0
CoD.SafeArea.VerticalBordersClicked = false
CoD.SafeArea.HorizontalBordersClicked = false
CoD.SafeArea.InitialX = 0
CoD.SafeArea.InitialY = 0
CoD.OptionsUtility = {}
CoD.OptionsUtility.SENSITIVITY_1 = 0.4
CoD.OptionsUtility.SENSITIVITY_2 = 0.6
CoD.OptionsUtility.SENSITIVITY_3 = 0.8
CoD.OptionsUtility.SENSITIVITY_4 = 1
CoD.OptionsUtility.SENSITIVITY_5 = 1.2
CoD.OptionsUtility.SENSITIVITY_6 = 1.4
CoD.OptionsUtility.SENSITIVITY_7 = 1.6
CoD.OptionsUtility.SENSITIVITY_8 = 1.8
CoD.OptionsUtility.SENSITIVITY_9 = 2
CoD.OptionsUtility.SENSITIVITY_10 = 2.25
CoD.OptionsUtility.SENSITIVITY_11 = 2.5
CoD.OptionsUtility.SENSITIVITY_12 = 3
CoD.OptionsUtility.SENSITIVITY_13 = 3.5
CoD.OptionsUtility.SENSITIVITY_14 = 4
CoD.OptionsUtility.ButtonLayoutListAssetName = 0x389ADF5BAE5D049
CoD.OptionsUtility.DemoButtonLayoutListAssetName = 0x863A4B07CDC6A22
CoD.OptionsUtility.StickLayoutListAssetName = 0xB603FFBDE556AD3
CoD.OptionsUtility.EnabledDisabledLabels = {
	0x94EB0E3329EDF5F,
	0x742854D20BB9B14,
}
CoD.OptionsUtility.EnabledDisabledValues = {
	0,
	1,
}
CoD.OptionsUtility.SettingLongSliderStart = 0.08
CoD.OptionsUtility.SettingLongSliderEnd = 0.92
CoD.OptionsUtility.PlayTestAudioSetting = "play_test_audio"
CoD.OptionsUtility.MaxSplitscreenBots = 12
CoD.OptionsUtility.ControllerPreviewStates = LuaEnum.createEnum("CONTROLLER_BLANK", "CONTROLLER_BUTTONS", "CONTROLLER_STICKS")
CoD.OptionsUtility.PlayerOptionsTabIndex = LuaEnum.createEnum("OPTION_TAB_NONE", "OPTION_TAB_CONTROLS", "OPTION_TAB_GRAPHICS", "OPTION_TAB_AUDIO", "OPTION_TAB_WARZONE", "OPTION_TAB_NETWORK", "OPTION_TAB_VOICE", "OPTION_TAB_CONTENT_FILTER")
CoD.OptionsUtility.LanguageRussianSetting = "language_russian"
CoD.OptionsUtility.LanguagePolishSetting = "language_polish"
CoD.OptionsUtility.LanguageJapaneseSetting = "language_japanese"
CoD.OptionsUtility.LanguageArabicSetting = "language_arabic"
CoD.OptionsUtility.LanguageSettings = {
	[CoD.OptionsUtility.LanguageRussianSetting] = true,
	[CoD.OptionsUtility.LanguagePolishSetting] = true,
	[CoD.OptionsUtility.LanguageArabicSetting] = true,
	[CoD.OptionsUtility.LanguageJapaneseSetting] = true,
}
CoD.OptionsUtility.IsLanguageSetting = function(f1_arg0)
	return CoD.OptionsUtility.LanguageSettings[f1_arg0] ~= nil
end
CoD.OptionsUtility.EnglishFromLocalized = {
	russian_full = "russian",
	japanese_full = "japanese",
	polish_full = "polish",
	arabic = "arabic_partial",
}
CoD.OptionsUtility.LocalizedFromEnglish = {
	russian = "russian_full",
	japanese = "japanese_full",
	polish = "polish_full",
	arabic_partial = "arabic",
}
CoD.OptionsUtility.BrightnessSettings = {
	"scene_brightness",
}
CoD.OptionsUtility.ColorblindSettings = {
	"colorblind_mode",
}
CoD.OptionsUtility.IsWarzoneOrInvalidMode = function()
	local f2_local0 = IsWarzone()
	if not f2_local0 then
		f2_local0 = IsMainModeInvalid()
	end
	return f2_local0
end
CoD.OptionsUtility.PlayerOptionsTabsInfo = {
	[CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_CONTROLS] = {
		name = 0x19352A5A4C9CAC9,
		widget = "CoD.StartMenu_Options_Frame_Controls",
	},
	[CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_GRAPHICS] = {
		name = 0xE2B4B3485831A1A,
		widget = "CoD.StartMenu_Options_Frame_Graphics",
		condition = ShouldOpenGraphicsAndSoundOptions,
		conditionResult = true,
	},
	[CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_AUDIO] = {
		name = 0xB8F71718019166B,
		widget = "CoD.StartMenu_Options_Frame_Sound",
		condition = ShouldOpenGraphicsAndSoundOptions,
		conditionResult = true,
	},
	[CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_WARZONE] = {
		name = 0xA2DD20750465431,
		widget = "CoD.StartMenu_Options_Frame_Warzone",
		condition = CoD.OptionsUtility.IsWarzoneOrInvalidMode,
		conditionResult = true,
	},
	[CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_NETWORK] = {
		name = 0x9F9A830F04564A7,
		widget = "CoD.StartMenu_Options_Frame_Network",
		condition = CoD.OptionsUtility.DisabledForOfflineDemoExceptWZTrial,
		conditionResult = false,
	},
	[CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_VOICE] = {
		name = 0xB87589E683A1951,
		widget = "CoD.StartMenu_Options_Frame_Voice",
		condition = CoD.OptionsUtility.DisabledForOfflineDemoExceptWZTrial,
		conditionResult = false,
	},
	[CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_CONTENT_FILTER] = {
		name = 0xD52DB291DBBD257,
		widget = "CoD.StartMenu_Options_Frame_GraphicContent",
		condition = CoD.OptionsUtility.DisabledForCurrentMilestoneExceptWZTrial,
		conditionResult = false,
	},
}
CoD.OptionsUtility.DisabledForOfflineDemoExceptWZTrial = function()
	return CoD.DirectorUtility.IsOfflineDemo() and not IsGameTrial()
end
CoD.OptionsUtility.DisabledForCurrentMilestoneExceptWZTrial = function()
	return CoD.DirectorUtility.DisableForCurrentMilestone() and not IsGameTrial()
end
CoD.OptionsUtility.IsOptionAssetInList = function(f5_arg0, f5_arg1)
	for f5_local3, f5_local4 in ipairs(f5_arg1) do
		if f5_local4 == f5_arg0 then
			return true
		end
	end
	return false
end
CoD.OptionsUtility.GetGameSettingsInfo = function(f6_arg0)
	return CoD.OptionsUtility.GetGameSettingsInfoFromTable(Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f6_arg0)))
end
CoD.OptionsUtility.GetGameSettingsInfoFromTable = function(f7_arg0)
	if f7_arg0 then
		if IsPC() and f7_arg0[0x853EF08FE1E46D] == 1 then
			return nil
		end
		local f7_local0 = {
			name = f7_arg0[0x55F116BF695C8F6],
			setting = f7_arg0[0x14C73E954E9760B],
			image = f7_arg0[0x245C555A23CB4AE] or 0x7615068F50B3D66,
			useLongSlider = f7_arg0[0xDD5060AA2F3FF5F] == 1,
			addUnlimitedButton = f7_arg0[0xD268F562204A4FB] == 1,
		}
		local f7_local1 = {}
		local f7_local2 = {}
		local f7_local3 = {}
		local f7_local4 = f7_arg0[0x215FC62D5AAB9FF] or 0x0
		local f7_local5 = f7_arg0[0x9F7FCEC8FCB623D] or 0x0
		local f7_local6 = f7_arg0[0x147773D1453B614] or 2
		for f7_local7 = 1, f7_local6, 1 do
			table.insert(f7_local2, f7_arg0[0x9F7FCEC8FCB623D .. f7_local7] or f7_local5)
			table.insert(f7_local3, tonumber(f7_arg0[0xCE4FD9430E80CEA .. f7_local7]) or 0)
			table.insert(f7_local1, f7_arg0[0x215FC62D5AAB9FF .. f7_local7] or f7_local4)
		end
		if f7_arg0[0x15A0D9812F3D286] == 1 then
			f7_local1 = {
				f7_local4,
			}
			f7_local2 = CoD.OptionsUtility.EnabledDisabledLabels
			f7_local3 = CoD.OptionsUtility.EnabledDisabledValues
		end
		f7_local0.hintText = f7_local1
		f7_local0.labels = f7_local2
		f7_local0.values = f7_local3
		return f7_local0
	else
		return nil
	end
end
CoD.OptionsUtility.DraftSettings = {
	"draft_enabled",
	"draft_time",
	"draft_every_round",
	"draft_required_clients",
}
CoD.OptionsUtility.GeneralSettings = {
	"server_msec",
	"prematch_period",
	"preround_period",
	"force_radar",
	"round_start_explosive_delay",
	"allow_killcam",
	"round_start_killstreak_delay",
	"kill_event_score_multiplier",
	"escalation_enabled",
	"use_spawn_groups",
	"fow_reveal_enabled",
	"disable_manual_healing",
}
CoD.OptionsUtility.HealthAndDamageSettings = {
	"player_max_health",
	"player_health_regen_time",
	"friendly_fire_type",
	"teamkill_punish_count",
	"only_headshots",
	"allow_hit_markers",
}
CoD.OptionsUtility.SpawnSettings = {
	"player_num_lives",
	"player_respawn_delay",
	"incremental_spawn_delay",
	"player_force_respawn",
	"wave_respawn_delay",
	"spawn_suicide_penalty",
	"spawn_teamkilled_penalty",
	"spawn_select",
	"team_num_lives",
}
CoD.OptionsUtility.CustomClassSettings = {
	"disable_cac",
	"max_allocation",
}
CoD.OptionsUtility.PresetClassSettings = {
	"preset_classes_per_team",
}
CoD.OptionsUtility.GlobalTopLevelGametypeSettings = {
	"hardcore_mode",
}
CoD.OptionsUtility.GetGametypeWinConditionsTable = function(f8_arg0)
	local f8_local0 = {}
	local f8_local1 = Engine[0xE00B2F29271C60B](0x336328281F5061D)
	local f8_local2 = f8_local1 and f8_local1[f8_arg0 .. "_winconditionslist"]
	if f8_local2 then
		for f8_local6, f8_local7 in ipairs(f8_local2) do
			table.insert(f8_local0, f8_local7[0x3C119C726692754])
		end
	end
	return f8_local0
end
CoD.OptionsUtility.GetGametypeAdvancedOptionsTable = function(f9_arg0)
	local f9_local0 = {}
	local f9_local1 = Engine[0xE00B2F29271C60B](0x336328281F5061D)
	local f9_local2 = f9_local1 and f9_local1[f9_arg0 .. "_advancedoptionslist"]
	if f9_local2 then
		for f9_local6, f9_local7 in ipairs(f9_local2) do
			table.insert(f9_local0, f9_local7[0x3C119C726692754])
		end
	end
	return f9_local0
end
CoD.OptionsUtility.PlayerSettingsOpenOverlayAction = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4)
	if f10_arg3 and f10_arg3.menuName then
		OpenOverlay(f10_arg4, f10_arg3.menuName, f10_arg2)
	end
end
CoD.OptionsUtility.PlayerSettings = {}
CoD.OptionsUtility.PlayerSettings.ControllerSettings = {
	{
		groupName = 0x0,
		options = {
			"look_inversion",
			"look_sensitivity_horizontal",
			"look_sensitivity_vertical",
			"look_sensitivity_ads_scalar",
			"look_sensitivity_ads_scalar_highzoom",
		},
	},
	{
		groupName = 0x0,
		options = {
			"target_assist",
			"aim_assist",
			"controller_vibration",
			"sprint_cancel_reload",
			"auto_mantle_enabled",
			"auto_sprint_enabled",
		},
	},
}
if true ~= Engine[0xA55C3ACD0D2BCF0]() then
	table.insert(CoD.OptionsUtility.PlayerSettings.ControllerSettings, {
		groupName = 0x0,
		options = {
			"stick_layout",
		},
		additionalProperties = {
			showSticks = true,
		},
	})
	table.insert(CoD.OptionsUtility.PlayerSettings.ControllerSettings, {
		groupName = 0x0,
		options = {
			"button_layout",
			"trigger_config",
		},
		additionalProperties = {
			showButtons = true,
		},
	})
end
CoD.OptionsUtility.PlayerSettings.GraphicsSettings = {
	{
		groupName = 0x7D7B86AED625BE2,
		options = {
			"scene_brightness",
			"colorblind_mode",
			"gamertag_indicator",
			"splitscreen_orientation",
		},
	},
	{
		groupName = 0x17A2FCF5956B22,
		additionalProperties = {
			name = Engine[0xF9F1239CFD921FE](0x20EBAA5BAFF1E1C),
			action = CoD.OptionsUtility.PlayerSettingsOpenOverlayAction,
			actionParam = {
				menuName = "StartMenu_Options_Graphics_SafeArea",
			},
			hideOptionInfo = true,
		},
	},
}
CoD.OptionsUtility.PlayerSettings.AudioSettings = {
	{
		groupName = 0xFB21DF51B8EF25C,
		options = {
			"master_volume",
			CoD.OptionsUtility.PlayTestAudioSetting,
			"audio_presets",
			"show_subtitles",
		},
	},
	{
		groupName = 0xC9EBE411155B7FC,
		options = {
			"voice_volume",
			"music_volume",
			"chat_volume",
			"sfx_volume",
			"cinematic_volume",
		},
	},
	{
		groupName = 0xFC75A042AC9C0DA,
		options = {
			"multiplayer_dialog",
		},
	},
	{
		groupName = 0x160BC39C53DFD73,
		options = {
			"controller_sound",
		},
	},
	{
		groupName = 0x7FCA90CCB9BD246,
		options = {
			CoD.OptionsUtility.LanguageRussianSetting,
			CoD.OptionsUtility.LanguagePolishSetting,
			CoD.OptionsUtility.LanguageArabicSetting,
			CoD.OptionsUtility.LanguageJapaneseSetting,
		},
	},
}
CoD.OptionsUtility.PlayerSettings.ContentSettings = {
	{
		groupName = 0xD52DB291DBBD257,
		options = {
			"graphic_content",
			"zombie_cartoon",
			"user_generated_content",
		},
	},
}
CoD.OptionsUtility.PlayerSettings.FirstTimeContentSettings = {
	{
		groupName = 0xD52DB291DBBD257,
		options = {
			"graphic_content",
		},
	},
}
CoD.OptionsUtility.PlayerSettings.VoiceSettings = {
	{
		groupName = 0x7D7B86AED625BE2,
		options = {
			"mute_all_except_party",
		},
	},
}
CoD.OptionsUtility.PlayerSettings.WarzoneSettings = {
	{
		groupName = 0x0,
		options = {
			"warzone_compass",
			"warzone_instant_pickups",
			"warzone_priority_pickups",
			"warzone_cycle_items",
			"warzone_auto_mount_ladder",
			"warzone_reload_on_press",
		},
	},
	{
		groupName = 0xAA3B45486FC1EDE,
		options = {
			"warzone_incognito_self",
			"warzone_incognito_others",
		},
	},
}
CoD.OptionsUtility.PlayerSettings.TheaterSettings = {
	{
		groupName = 0x150299A3BCE594,
		options = {
			"demo_recordwithautoplay",
			"demo_togglegamehud",
		},
	},
	{
		groupName = 0xB850A750B6DE292,
		options = {
			"demo_autodollyrecord",
			"demo_autodollykeyframeinterval",
		},
	},
}
DataSourceHelpers.PerControllerDataSourceSetup("ButtonLayoutLabels", "ButtonLayoutLabels", function(f11_arg0, f11_arg1)
	local f11_local0, f11_local1 = nil
	local f11_local2 = CoD.OptionsUtility.ButtonLayoutListAssetName
	local f11_local3 = Engine[0xA55C3ACD0D2BCF0]()
	local f11_local4 = Engine[0xD4D7317F380395F](f11_arg1, "gpad_buttonsConfig")
	local f11_local5 = Engine[0xD4D7317F380395F](f11_arg1, "flipped_control_config") == 1
	local f11_local6 = Enum[0xC85221447A6BA72][0xB9D5672A46230CC]
	if f11_local3 then
		f11_local6 = 1
		f11_local4 = 1
		f11_local5 = false
		f11_local2 = CoD.OptionsUtility.DemoButtonLayoutListAssetName
	end
	local f11_local7 = Engine[0x4DF5CFBC1771947](f11_arg1)
	f11_local7 = f11_local7.buttonLayoutPreview
	local f11_local8 = f11_local7 and f11_local7:get()
	if f11_local8 then
		f11_local4 = f11_local8
	end
	local f11_local9 = Engine[0x4DF5CFBC1771947](f11_arg1)
	f11_local9 = f11_local9.buttonFlippedPreview
	local f11_local10 = f11_local9 and f11_local9:get()
	if f11_local10 then
		f11_local5 = f11_local10 == 1
	end
	local f11_local11 = Engine[0xA7E3CD65E63086F](f11_local2)
	if f11_local11 then
		for f11_local15, f11_local16 in ipairs(f11_local11) do
			if f11_local16[0xBFDFDDB8F2BEEB5] == f11_local4 then
				f11_local0 = f11_local16
			end
			if f11_local16[0xBFDFDDB8F2BEEB5] == f11_local6 then
				f11_local1 = f11_local16
			end
			if f11_local0 and f11_local1 then
				break
			end
		end
	end
	if not f11_local0 then
		return
	end
	local f11_local12 = "_label"
	local f11_local13 = CoD.BaseUtility.GetCurrentSessionModeString()
	if f11_local13 ~= "" then
		f11_local12 = "_" .. f11_local13 .. f11_local12
	elseif not CoD.DirectorUtility.IsSessionModeAvailable(f11_arg1, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) then
		f11_local12 = "_mp" .. f11_local12
	end
	local f11_local14 = function(f12_arg0, f12_arg1)
		local f12_local0 = true
		local f12_local1 = f11_arg0:create(f12_arg0)
		local f12_local2 = f11_local0[f12_arg1 .. f11_local12]
		if not f12_local2 then
			f12_local2 = f11_local0[f12_arg1 .. "_label"]
		end
		if f11_local1 then
			local f12_local3 = f11_local1[f12_arg1 .. f11_local12]
			if not f12_local3 then
				f12_local3 = f11_local1[f12_arg1 .. "_label"]
			end
			f12_local0 = f12_local2 == f12_local3
		end
		local f12_local3 = f12_local1:create("text")
		f12_local3:set(f12_local2)
		f12_local3 = f12_local1:create("isDefault")
		f12_local3:set(f12_local0)
	end
	f11_local14("xbA_psCross", 0x574A8D65872F471)
	f11_local14("xbB_psCircle", 0x574A5D65872EF58)
	f11_local14("xbX_psSquare", 0x574AFD658730056)
	f11_local14("xbY_psTriangle", 0x574B0D658730209)
	f11_local14("back", 0xC5B9961DE2A7859)
	f11_local14("start", 0xB6549C9442290D2)
	f11_local14("leftDpad", 0x6636C500CD317C7)
	f11_local14("rightDpad", 0x44ED6DCD32FB7F8)
	f11_local14("upDpad", 0x872FD384B8E9347)
	f11_local14("downDpad", 0xE6F4A963B341BA2)
	f11_local14("leftStick", 0x981D3C9EFB3588A)
	f11_local14("rightStick", 0x1AD685511C2CD38)
	if f11_local5 then
		f11_local14("lb", 0xA21357689398BA4)
		f11_local14("rb", 0xB8FA5BEDABA6332)
		f11_local14("leftTrig", 0x71CB5CA0A239B12)
		f11_local14("rightTrig", 0xBDF1D29ED293F4C)
	else
		f11_local14("lb", 0x71CB5CA0A239B12)
		f11_local14("rb", 0xBDF1D29ED293F4C)
		f11_local14("leftTrig", 0xA21357689398BA4)
		f11_local14("rightTrig", 0xB8FA5BEDABA6332)
	end
end, true)
DataSourceHelpers.PerControllerDataSourceSetup("StickLayoutLabels", "StickLayoutLabels", function(f13_arg0, f13_arg1)
	local f13_local0, f13_local1 = nil
	local f13_local2 = Engine[0xD4D7317F380395F](f13_arg1, "gpad_sticksConfig")
	local f13_local3 = Engine[0x4DF5CFBC1771947](f13_arg1)
	f13_local3 = f13_local3.stickLayoutPreview
	local f13_local4 = f13_local3 and f13_local3:get()
	if f13_local4 then
		f13_local2 = f13_local4
	end
	local f13_local5 = Engine[0xA7E3CD65E63086F](CoD.OptionsUtility.StickLayoutListAssetName)
	if f13_local5 then
		for f13_local9, f13_local10 in ipairs(f13_local5) do
			if f13_local10[0x2ACD017CCBEFB33] == f13_local2 then
				f13_local0 = f13_local10
			end
			if f13_local10[0x2ACD017CCBEFB33] == Enum[0xAA0D870E884EDC0][0x3CE611246DBB77B] then
				f13_local1 = f13_local10
			end
			if f13_local0 and f13_local1 then
				break
			end
		end
	end
	if not f13_local0 then
		return
	else
		local f13_local6 = function(f14_arg0, f14_arg1)
			local f14_local0 = true
			if f13_local1 then
				f14_local0 = f13_local0[Engine[0xC53F8D38DF9042B](f14_arg1 .. "_label")] == f13_local1[Engine[0xC53F8D38DF9042B](f14_arg1 .. "_label")]
			end
			local f14_local1 = f13_arg0:create(f14_arg0)
			local f14_local2 = f14_local1:create("text")
			f14_local2:set(f13_local0[Engine[0xC53F8D38DF9042B](f14_arg1 .. "_label")])
			f14_local2 = f14_local1:create("isDefault")
			f14_local2:set(f14_local0)
		end
		f13_local6("leftStickUp", "lstick_up")
		f13_local6("leftStickDown", "lstick_down")
		f13_local6("leftStickLeftRight", "lstick_lr")
		f13_local6("rightStickUp", "rstick_up")
		f13_local6("rightStickDown", "rstick_down")
		f13_local6("rightStickLeftRight", "rstick_lr")
		local f13_local7 = f13_arg0:create("leftStickImg")
		f13_local7:set(f13_local0[0x8AC8AA260B7F6E3])
		f13_local7 = f13_arg0:create("rightStickImg")
		f13_local7:set(f13_local0[0x593B62D1EEFC885])
	end
end, true)
CoD.OptionsUtility.GetPlayerSettingDefaultValue = function(f15_arg0, f15_arg1)
	return CoD.OptionsUtility.GetPlayerSettingDefaultValueFromOptionInfo(f15_arg0, Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f15_arg1)))
end
CoD.OptionsUtility.GetPlayerSettingDefaultValueFromOptionInfo = function(f16_arg0, f16_arg1)
	local f16_local0 = nil
	if f16_arg1 then
		if f16_arg1[0x15A0D9812F3D286] == 1 then
			if f16_arg1[0x60DFED5B3CCF56B] == 1 then
				local f16_local1 = 1
			end
			f16_local0 = f16_local1 or 0
		elseif f16_arg1[0xC97F4CCEE4EFEB7] == 1 then
			f16_local0 = f16_arg1[0x77326D80ECDE714]
		elseif f16_arg1.options then
			local f16_local2 = f16_arg1.options[(f16_arg1[0x2A5CFFC76A4879] or 0) + 1]
			if f16_local2 then
				f16_local0 = tonumber(f16_local2[0xCE4FD9430E80CEA])
			end
		end
	end
	return f16_local0
end
CoD.OptionsUtility.IsPlayerSettingDefault = function(f17_arg0, f17_arg1)
	local f17_local0 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f17_arg1))
	if f17_local0 then
		local f17_local1 = nil
		if CoD.OptionsUtility.IsOptionAssetInList(f17_arg1, CoD.CodCasterUtility.CodCasterProfileSettings) then
			f17_local1 = CoD.ShoutcasterProfileVarValue(f17_arg0, f17_local0[0x6E183377E0C37F4])
		else
			f17_local1 = tonumber(Engine[0x8C7ADE01B406F5E](f17_arg0, f17_local0[0x6E183377E0C37F4]))
		end
		return f17_local1 == CoD.OptionsUtility.GetPlayerSettingDefaultValue(f17_arg0, f17_arg1)
	else
		return false
	end
end
CoD.OptionsUtility.ExcludeOption = function(f18_arg0, f18_arg1)
	if f18_arg1[0xA10BCFA5A2B032] == 1 and IsOrbis() then
		return true
	elseif f18_arg1[0xA048923948E2319] == 1 and IsDurango() then
		return true
	elseif f18_arg1[0xFEFFCAEBB169320] == 1 and IsPC() then
		return true
	elseif CoD.DirectorUtility.DisableForCurrentMilestone(f18_arg0) and (f18_arg1[0x4BCADBA8E631B86] == "splitscreen_orientation" or f18_arg1[0x4BCADBA8E631B86] == "audio_presets") then
		return true
	elseif f18_arg1[0x42D405AEF2DCA10] == 1 and IsInGame() then
		return true
	elseif f18_arg1[0xD2DFEEE6B42B17E] == 1 and f18_arg0 ~= Engine[0xA5B9C0111291A8B]() then
		return true
	elseif f18_arg1[0x8E712B176AC0EF1] == 1 and not CoD.OptionsUtility.IsWarzoneOrInvalidMode() then
		return true
	elseif CoD.OptionsUtility.IsLanguageSetting(f18_arg1[0x4BCADBA8E631B86]) then
		if f18_arg1[0x4BCADBA8E631B86] == CoD.OptionsUtility.LanguageArabicSetting and not IsArabicSku() then
			return true
		elseif f18_arg1[0x4BCADBA8E631B86] == CoD.OptionsUtility.LanguageJapaneseSetting and not IsJapaneseSku() then
			return true
		elseif f18_arg1[0x4BCADBA8E631B86] == CoD.OptionsUtility.LanguageRussianSetting and not IsRussianSku() then
			return true
		elseif f18_arg1[0x4BCADBA8E631B86] == CoD.OptionsUtility.LanguagePolishSetting and not IsPolishSku() then
			return true
		end
	end
	if f18_arg1[0x4BCADBA8E631B86] == "user_generated_content" and Engine[0x102989C756324E2](f18_arg0) then
		return true
	elseif f18_arg1[0x8847657D5DB441C] == 1 and Engine[0xBEB2B814FA0D518](f18_arg0) == Enum[0xB16E5B2AF9D5263][0x2731C51590EF20A] then
		return true
	end
	return false
end
CoD.OptionsUtility.NotifyPlayerSettingsUpdate = function(f19_arg0, f19_arg1)
	local f19_local0 = Engine[0x4DF5CFBC1771947](f19_arg0)
	f19_local0 = f19_local0.PlayerSettingsUpdate
	if f19_local0 and not f19_local0:set(f19_arg1) then
		Engine[0x6A489878620F3BC](f19_local0)
	end
end
CoD.OptionsUtility.PlayerSettingsItemSelected = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3, f20_arg4)
	local f20_local0 = f20_arg1.index
	if f20_local0 and f20_arg0.__lastSelectedIndex ~= f20_local0 then
		f20_arg0.__lastSelectedIndex = f20_local0
		CoD.OptionsUtility.ItemSelectedFunction(f20_arg0, f20_arg1, f20_arg2, f20_arg3, f20_arg4)
		SelectItemIfPossible(f20_arg0, f20_arg1, f20_arg2)
		local f20_local1 = f20_arg0:getModel(f20_arg2, "currentSelection")
		if f20_local1 then
			f20_local1:set(f20_local0)
		end
		local f20_local2 = f20_arg0:getModel(f20_arg2, "optionAssetName")
		if f20_local2 then
			CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f20_arg2, f20_local2:get())
		end
	end
end
CoD.OptionsUtility.PlayerSettingsItemSelectedButtons = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	CoD.OptionsUtility.PlayerSettingsItemSelected(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	CoD.OptionsUtility.SetButtonLayoutPreview(f21_arg1, f21_arg2)
end
CoD.OptionsUtility.PlayerSettingsItemSelectedSticks = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	CoD.OptionsUtility.PlayerSettingsItemSelected(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	CoD.OptionsUtility.SetStickLayoutPreview(f22_arg1, f22_arg2)
end
CoD.OptionsUtility.PlayerSettingsItemSelectedBrightness = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4)
	CoD.OptionsUtility.PlayerSettingsItemSelected(f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4)
	CoD.OptionsUtility.UpdateBrightnessPreviewColor(f23_arg2)
end
CoD.OptionsUtility.PlayerSettingsItemSelectedColorblind = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4)
	CoD.OptionsUtility.PlayerSettingsItemSelected(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4)
	ForceNotifyControllerModel(f24_arg2, "profile.colorblindMode")
end
CoD.OptionsUtility.PlayerSettingsItemSelectedLanguage = function(f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4)
	if not f25_arg0.changingLanguage and f25_arg1.index ~= CoD.OptionsUtility.GetCurrentLanguageSelection() then
		f25_arg0.changingLanguage = true
		local f25_local0 = Engine[0x8E9485024EFDB9]()
		local f25_local1 = f25_local0
		if CoD.OptionsUtility.EnglishFromLocalized[f25_local0] then
			f25_local1 = CoD.OptionsUtility.EnglishFromLocalized[f25_local0]
		elseif CoD.OptionsUtility.LocalizedFromEnglish[f25_local0] then
			f25_local1 = CoD.OptionsUtility.LocalizedFromEnglish[f25_local0]
		end
		ChangeLanguage(f25_arg0, f25_arg1, f25_arg2, f25_local1, f25_arg3, f25_arg4)
	end
end
CoD.OptionsUtility.GetDefaultOptionIndex = function(f26_arg0)
	if not f26_arg0 then
		return 1
	elseif f26_arg0[0x15A0D9812F3D286] == 1 then
		if f26_arg0[0x60DFED5B3CCF56B] == 1 then
			return 1
		else
			return 2
		end
	elseif f26_arg0[0xC97F4CCEE4EFEB7] == 1 then
		local f26_local0 = f26_arg0[0xB5A1CBBE01A23F3] or 0
		local f26_local1 = f26_arg0[0x546C97C01207014] or 0
		local f26_local2 = f26_arg0[0xD0592BDDB5DA4E1] or 0
		local f26_local3 = f26_arg0[0x77326D80ECDE714] or f26_local0
		local f26_local4 = 0
		if f26_local0 < f26_local1 and f26_local2 > 0 then
			for f26_local5 = f26_local0, f26_local1, f26_local2 do
				f26_local4 = f26_local4 + 1
				if math.abs(f26_local3 - f26_local5) < 0 then
					return f26_local4
				end
			end
		end
	elseif f26_arg0[0xA45F46644AD8745] then
		return (f26_arg0[0x2A5CFFC76A4879] or 0) + 1
	end
	return 1
end
CoD.OptionsUtility.GetCurrentLanguageSelection = function()
	local f27_local0 = Engine[0x8E9485024EFDB9]()
	if CoD.OptionsUtility.EnglishFromLocalized[f27_local0] ~= nil then
		return 2
	elseif CoD.OptionsUtility.LocalizedFromEnglish[f27_local0] ~= nil then
		return 1
	else
		return 0
	end
end
CoD.OptionsUtility.CreatePlayerSettingsDatasource = function(f28_arg0, f28_arg1, f28_arg2)
	local f28_local0 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f28_arg1))
	if f28_local0 and not CoD.OptionsUtility.ExcludeOption(f28_arg0, f28_local0) then
		local f28_local1 = f28_local0[0x1C0A2F2034B03B4] or 0x0
		local f28_local2 = {}
		if f28_local0[0x15A0D9812F3D286] == 1 then
			f28_local2 = {
				{
					name = Engine[0xF9F1239CFD921FE](0x5BE4D02B20F370A),
					value = 1,
				},
				{
					name = Engine[0xF9F1239CFD921FE](0x17857948FC2CCFC),
					value = 0,
				},
			}
		elseif f28_local0[0xC97F4CCEE4EFEB7] == 1 then
			local f28_local3 = f28_local0[0xB5A1CBBE01A23F3] or 0
			local f28_local4 = f28_local0[0x546C97C01207014] or 0
			local f28_local5 = f28_local0[0xD0592BDDB5DA4E1] or 0
			local f28_local6 = f28_local0[0xB04DDD806C34DE8] or 1
			local f28_local7 = f28_local0[0x77326D80ECDE714] or f28_local3
			if f28_local3 < f28_local4 and f28_local5 > 0 then
				for f28_local8 = f28_local3, f28_local4, f28_local5 do
					table.insert(f28_local2, {
						name = string.format("%g", f28_local8 * f28_local6),
						value = tonumber(string.format("%g", f28_local8)),
					})
				end
			end
		elseif f28_local0.options then
			for f28_local6, f28_local7 in ipairs(f28_local0.options) do
				table.insert(f28_local2, {
					name = Engine[0xF9F1239CFD921FE](f28_local7[0x9F7FCEC8FCB623D] or f28_local1),
					value = tonumber(f28_local7[0xCE4FD9430E80CEA]) or 0,
				})
			end
		end
		local f28_local3 = CoD.OptionsUtility.GetDefaultOptionIndex(f28_local0)
		for f28_local7, f28_local8 in ipairs(f28_local2) do
			f28_local8.index = f28_local7
			f28_local8.isDefault = f28_local7 == f28_local3
		end
		f28_local4 = CoD.OptionsUtility.PlayerSettingsItemSelected
		f28_local5 = "PlayerSettingOptions_" .. f28_arg1
		f28_local6 = f28_local3
		f28_local7 = nil
		if CoD.OptionsUtility.IsLanguageSetting(f28_arg1) then
			f28_local4 = CoD.OptionsUtility.PlayerSettingsItemSelectedLanguage
			f28_local6 = CoD.OptionsUtility.GetCurrentLanguageSelection()
			f28_local7 = function()
				return CoD.OptionsUtility.GetCurrentLanguageSelection() and 1 or 0
			end
		elseif CoD.OptionsUtility.IsOptionAssetInList(f28_arg1, CoD.OptionsUtility.BrightnessSettings) then
			f28_local4 = CoD.OptionsUtility.PlayerSettingsItemSelectedBrightness
		elseif CoD.OptionsUtility.IsOptionAssetInList(f28_arg1, CoD.OptionsUtility.ColorblindSettings) then
			f28_local4 = CoD.OptionsUtility.PlayerSettingsItemSelectedColorblind
		elseif CoD.OptionsUtility.IsOptionAssetInList(f28_arg1, CoD.CodCasterUtility.CodCasterProfileSettings) then
			f28_local6 = CoD.ShoutcasterProfileVarValue(f28_arg0, f28_local0[0x6E183377E0C37F4])
			f28_local4 = CoD.CodCasterUtility.CodCasterSettingsItemSelected
		elseif f28_arg2 then
			if f28_arg2.showButtons then
				f28_local4 = CoD.OptionsUtility.PlayerSettingsItemSelectedButtons
			elseif f28_arg2.showSticks then
				f28_local4 = CoD.OptionsUtility.PlayerSettingsItemSelectedSticks
			end
		else
			f28_local6 = CoD.OptionsUtility.GetProfileSelection(f28_arg0, f28_local2, f28_local0[0x6E183377E0C37F4]) or f28_local3
		end
		f28_local8 = {
			models = {
				name = Engine[0xF9F1239CFD921FE](f28_local0[0x55F116BF695C8F6] or 0x0),
				hintText = Engine[0xF9F1239CFD921FE](f28_local0[0xCC44970C8397929] or 0x0),
				optionAssetName = f28_arg1,
				optionsDatasource = CoD.OptionsUtility.CreateOptionDataSource(f28_arg0, f28_local5, f28_local2, f28_local0[0x6E183377E0C37F4], f28_local4, f28_local7, f28_arg1),
				currentSelection = f28_local6,
			},
			properties = {},
		}
		if f28_arg2 then
			for f28_local12, f28_local13 in pairs(f28_arg2) do
				if not f28_local8.properties[f28_local12] then
					f28_local8.properties[f28_local12] = f28_local13
				end
			end
		end
		return f28_local8
	else
		return nil
	end
end
CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
	local f30_local0 = {
		models = {
			name = f30_arg0 or "",
			hintText = f30_arg1 or "",
			buttonPromptText = f30_arg2 or "",
		},
		properties = {
			customWidgetOverride = CoD.StartMenu_Options_SettingButton_Wrapper,
		},
	}
	if f30_arg3 then
		for f30_local4, f30_local5 in pairs(f30_arg3) do
			f30_local0.properties[f30_local4] = f30_local5
		end
	end
	return f30_local0
end
CoD.OptionsUtility.PlayerSettingsGroupListPrepare = function(f31_arg0, f31_arg1)
	local f31_local0 = {}
	for f31_local10, f31_local11 in ipairs(f31_arg1) do
		local f31_local12 = f31_local11.groupName
		local f31_local13 = nil
		local f31_local14 = {}
		if f31_local11.options and not (f31_local12 == 0x4ADE150FFB574D4 and f31_arg0 ~= Engine[0xA5B9C0111291A8B]() and IsInGame()) then
			for f31_local8, f31_local9 in ipairs(f31_local11.options) do
				if f31_local9 == CoD.OptionsUtility.PlayTestAudioSetting then
					table.insert(f31_local14, f31_local9)
				end
				local f31_local7 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f31_local9))
				if f31_local7 and not CoD.OptionsUtility.ExcludeOption(f31_arg0, f31_local7) then
					table.insert(f31_local14, f31_local9)
				end
			end
			if #f31_local14 > 0 then
				if f31_local12 ~= 0x0 then
					table.insert(f31_local0, {
						models = {
							name = Engine[0xF9F1239CFD921FE](f31_local12),
						},
						properties = {
							customWidgetOverride = CoD.StartMenu_Options_SettingGroupHeader,
						},
					})
				end
				for f31_local8, f31_local9 in ipairs(f31_local14) do
					if f31_local9 == CoD.OptionsUtility.PlayTestAudioSetting then
						table.insert(
							f31_local0,
							CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(Engine[0xF9F1239CFD921FE](0xE3C7E82F378C646), Engine[0xF9F1239CFD921FE](0xEBA848F0918C436), Engine[0xF9F1239CFD921FE](0x11D6BD520F78B0E), {
								isAudioTest = true,
							})
						)
					end
					local f31_local7 = CoD.OptionsUtility.CreatePlayerSettingsDatasource(f31_arg0, f31_local9, f31_local11.additionalProperties)
					if f31_local7 then
						table.insert(f31_local0, f31_local7)
					end
				end
			end
		end
		if f31_local11.additionalProperties and f31_local11.additionalProperties.action then
			table.insert(f31_local0, {
				models = {
					name = Engine[0xF9F1239CFD921FE](f31_local12),
				},
				properties = {
					customWidgetOverride = CoD.StartMenu_Options_SettingGroupHeader,
				},
			})
			local f31_local4 = f31_local11.additionalProperties
			table.insert(f31_local0, CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(f31_local4.name, f31_local4.hintText, f31_local4.buttonPromptText, f31_local4))
		end
	end
	return f31_local0
end
CoD.OptionsUtility.PlayerSettingsControlsListPrepare = function(f32_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f32_arg0, CoD.OptionsUtility.PlayerSettings.ControllerSettings)
end
CoD.OptionsUtility.PlayerSettingsGraphicsListPrepare = function(f33_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f33_arg0, CoD.OptionsUtility.PlayerSettings.GraphicsSettings)
end
CoD.OptionsUtility.PlayerSettingsAudioListPrepare = function(f34_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f34_arg0, CoD.OptionsUtility.PlayerSettings.AudioSettings)
end
CoD.OptionsUtility.PlayerSettingsContentListPrepare = function(f35_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f35_arg0, CoD.OptionsUtility.PlayerSettings.ContentSettings)
end
CoD.OptionsUtility.PlayerSettingsFirstTimeContentListPrepare = function(f36_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f36_arg0, CoD.OptionsUtility.PlayerSettings.FirstTimeContentSettings)
end
CoD.OptionsUtility.PlayerSettingsVoiceListPrepare = function(f37_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f37_arg0, CoD.OptionsUtility.PlayerSettings.VoiceSettings)
end
CoD.OptionsUtility.PlayerSettingsWarzoneListPrepare = function(f38_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f38_arg0, CoD.OptionsUtility.PlayerSettings.WarzoneSettings)
end
CoD.OptionsUtility.PlayerSettingsTheaterListPrepare = function(f39_arg0)
	return CoD.OptionsUtility.PlayerSettingsGroupListPrepare(f39_arg0, CoD.OptionsUtility.PlayerSettings.TheaterSettings)
end
CoD.OptionsUtility.PlayerSettingsNetworkListPrepare = function(f40_arg0)
	local f40_local0 = {}
	table.insert(f40_local0, {
		models = {
			name = Engine[0xF9F1239CFD921FE](0x9F9A830F04564A7),
		},
		properties = {
			customWidgetOverride = CoD.StartMenu_Options_SettingGroupHeader,
		},
	})
	table.insert(f40_local0, {
		models = {
			frameWidget = "CoD.StartMenu_Options_Network_OverviewPanel",
		},
		properties = {
			customWidgetOverride = CoD.StartMenu_Options_Network_StatusOverview_Wrapper,
			hideOptionInfo = true,
			showOverviewPanel = true,
		},
	})
	local f40_local1, f40_local2 = Engine[0xC952A85BDC1F8D9](f40_arg0, CoD.SYSINFO_NAT_TYPE)
	local f40_local3 = 0x0
	local f40_local4 = Engine[0x5DD093E52718]()
	if f40_local1 == Enum[0x50236A3452F3A49][0x9571467DC6166AD] then
		f40_local3 = 0xAA445309112CF99
	elseif f40_local1 == Enum[0x50236A3452F3A49][0x31FC575F7E84E5C] then
		f40_local3 = 0x14209B554672F30
	elseif f40_local1 == Enum[0x50236A3452F3A49][0x28476FFCBABCB0] then
		f40_local3 = 0xC305B096E1E2E84
	end
	table.insert(f40_local0, CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(Engine[0xF9F1239CFD921FE](0xB1478806C990BB), Engine[0xF9F1239CFD921FE](f40_local3, f40_local4), f40_local2))
	local f40_local5 = Engine[0xF9F1239CFD921FE](0x86EBF1A2FAA0274)
	local f40_local6 = Engine[0xF9F1239CFD921FE](0xD1ACE135B0A0DAE)
	local f40_local7, f40_local8 = Engine[0x50D07ABC7D13586](f40_arg0, CoD.SYSINFO_BANDWIDTH)
	table.insert(f40_local0, CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(f40_local5, f40_local6, f40_local7))
	local f40_local9, f40_local10 = Engine[0xC952A85BDC1F8D9](f40_arg0, CoD.SYSINFO_CONNECTION_TYPE)
	local f40_local11 = ""
	if f40_local9 == Enum[0xF9B5140618251DD][0xE6C9091868D18A] then
		f40_local11 = 0x87FDEFB84AAAE2E
	elseif f40_local9 == Enum[0xF9B5140618251DD][0xEFC42E21A350493] then
		f40_local11 = 0x26CFE1DF00BD287
	end
	table.insert(f40_local0, CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(Engine[0xF9F1239CFD921FE](0x7B6345471085D98), Engine[0xF9F1239CFD921FE](f40_local11), f40_local10))
	local f40_local12 = Engine[0xF9F1239CFD921FE](0xC241C17DD620CFF)
	local f40_local13, f40_local14 = Engine[0x50D07ABC7D13586](f40_arg0, CoD.SYSINFO_GEOGRAPHICAL_REGION)
	table.insert(
		f40_local0,
		CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(Engine[0xF9F1239CFD921FE](0x28B24D7EC3259D6), Engine[0xF9F1239CFD921FE](0xBE0FD8782640557), f40_local12, {
			action = CoD.OptionsUtility.ShowHideNetworkSettingInfo,
			hiddenLabel = Engine[0xF9F1239CFD921FE](0xC241C17DD620CFF),
			showingLabel = f40_local13,
			hiddenDesc = Engine[0xF9F1239CFD921FE](0xBE0FD8782640557),
			showingDesc = Engine[0xF9F1239CFD921FE](0xFA6535477C42613),
			isHidden = true,
		})
	)
	local f40_local15, f40_local16 = Engine[0x50D07ABC7D13586](f40_arg0, CoD.SYSINFO_EXTERNAL_IP_ADDRESS)
	table.insert(
		f40_local0,
		CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(Engine[0xF9F1239CFD921FE](0x7367624D2662070), Engine[0xF9F1239CFD921FE](0xD75251DBDF92FD4), f40_local12, {
			action = CoD.OptionsUtility.ShowHideNetworkSettingInfo,
			hiddenLabel = Engine[0xF9F1239CFD921FE](0xC241C17DD620CFF),
			showingLabel = f40_local15,
			hiddenDesc = Engine[0xF9F1239CFD921FE](0xD75251DBDF92FD4),
			showingDesc = Engine[0xF9F1239CFD921FE](0x22E830E31485122),
			isHidden = true,
		})
	)
	local f40_local17, f40_local18 = Engine[0x50D07ABC7D13586](f40_arg0, CoD.SYSINFO_INTERNAL_IP_ADDRESS)
	table.insert(
		f40_local0,
		CoD.OptionsUtility.CreatePlayerSettingsButtonDatasource(Engine[0xF9F1239CFD921FE](0x32CA1559CDF918A), Engine[0xF9F1239CFD921FE](0x87FC2843A65DDAA), f40_local12, {
			action = CoD.OptionsUtility.ShowHideNetworkSettingInfo,
			hiddenLabel = Engine[0xF9F1239CFD921FE](0xC241C17DD620CFF),
			showingLabel = f40_local17,
			hiddenDesc = Engine[0xF9F1239CFD921FE](0x87FC2843A65DDAA),
			showingDesc = Engine[0xF9F1239CFD921FE](0xC1498B590516530),
			isHidden = true,
		})
	)
	local f40_local19 = CoD.OptionsUtility.CreatePlayerSettingsDatasource(f40_arg0, "connection_meter")
	if f40_local19 then
		table.insert(f40_local0, f40_local19)
	end
	return f40_local0
end
DataSources.PlayerSettingsControlsList = DataSourceHelpers.ListSetup("PlayerSettingsControlsList", CoD.OptionsUtility.PlayerSettingsControlsListPrepare, true)
DataSources.PlayerSettingsGraphicsList = DataSourceHelpers.ListSetup("PlayerSettingsGraphicsList", CoD.OptionsUtility.PlayerSettingsGraphicsListPrepare, true)
DataSources.PlayerSettingsAudioList = DataSourceHelpers.ListSetup("PlayerSettingsAudioList", CoD.OptionsUtility.PlayerSettingsAudioListPrepare, true)
DataSources.PlayerSettingsContentList = DataSourceHelpers.ListSetup("PlayerSettingsContentList", CoD.OptionsUtility.PlayerSettingsContentListPrepare, true)
DataSources.PlayerSettingsVoiceList = DataSourceHelpers.ListSetup("PlayerSettingsVoiceList", CoD.OptionsUtility.PlayerSettingsVoiceListPrepare, true)
DataSources.PlayerSettingsWarzoneList = DataSourceHelpers.ListSetup("PlayerSettingsWarzoneList", CoD.OptionsUtility.PlayerSettingsWarzoneListPrepare, true)
DataSources.PlayerSettingsNetworkList = DataSourceHelpers.ListSetup("PlayerSettingsNetworkList", CoD.OptionsUtility.PlayerSettingsNetworkListPrepare, true)
DataSources.PlayerSettingsTheaterList = DataSourceHelpers.ListSetup("PlayerSettingsTheaterList", CoD.OptionsUtility.PlayerSettingsTheaterListPrepare, true)
DataSources.PlayerSettingsFirstTimeContentList = DataSourceHelpers.ListSetup("PlayerSettingsFirstTimeContentList", CoD.OptionsUtility.PlayerSettingsFirstTimeContentListPrepare, true)
DataSources.PlayerOptionsTabs = DataSourceHelpers.ListSetup("PlayerOptionsTabs", function(f41_arg0)
	local f41_local0 = {}
	local f41_local1 = Engine[0x4DF5CFBC1771947](f41_arg0)
	f41_local1 = f41_local1.selectedPlayerOptionsTab
	local f41_local2 = f41_local1 and f41_local1:get()
	for f41_local7, f41_local8 in ipairs(CoD.OptionsUtility.PlayerOptionsTabsInfo) do
		local f41_local6
		if f41_local8.condition and f41_local8.condition(f41_arg0) ~= f41_local8.conditionResult then
			f41_local6 = false
		else
			f41_local6 = true
		end
		if f41_local6 or not f41_local8.hideIfUnavailable then
			table.insert(f41_local0, {
				models = {
					tabName = f41_local8.name,
					frameWidget = f41_local8.widget,
					available = f41_local6,
				},
				properties = {
					tabIndex = f41_local7,
					selectIndex = f41_local7 == f41_local2,
				},
			})
		end
	end
	return f41_local0
end, true)
DataSources.AboutPingBars = DataSourceHelpers.ListSetup("AboutPingBars", function(f42_arg0)
	local f42_local0 = {}
	for f42_local1 = Engine[0x5F8EA8E2974BDCF](), 1, -1 do
		table.insert(f42_local0, {
			models = {
				pingIndex = f42_local1,
			},
		})
	end
	return f42_local0
end, true)
DataSourceHelpers.PerControllerDataSourceSetup("CurrentOptionInfo", "CurrentOptionInfo", function(f43_arg0, f43_arg1)
	local f43_local0 = f43_arg0:create("name")
	f43_local0:set("")
	f43_local0 = f43_arg0:create("hintText")
	f43_local0:set("")
	f43_local0 = f43_arg0:create("hideInfo")
	f43_local0:set(false)
end, true)
CoD.OptionsUtility.SetCurrentOptionInfo = function(f44_arg0, f44_arg1)
	local f44_local0 = f44_arg0:getModel()
	if f44_local0 then
		local f44_local1 = DataSources.CurrentOptionInfo.getModel(f44_arg1)
		local f44_local2 = f44_local0.name
		if f44_local2 then
			f44_local2 = f44_local0.name:get()
		end
		f44_local1.name:set(f44_local2 or "")
		local f44_local3 = f44_local0.hintText
		if f44_local3 then
			f44_local3 = f44_local0.hintText:get()
		end
		f44_local1.hintText:set(f44_local3 or "")
		f44_local1.hideInfo:set(f44_arg0.hideOptionInfo == true)
	end
end
CoD.OptionsUtility.InitPlayerSettingWidget = function(f45_arg0, f45_arg1)
	local f45_local0 = f45_arg0[f45_arg1]
	if f45_local0 and f45_local0.updateDataSource then
		f45_local0:registerEventHandler("update_settings_list_focus", function(element, event)
			local f46_local0 = f45_arg0:getModel()
			if f46_local0 and f46_local0.optionAssetName and f46_local0.currentSelection then
				local f46_local1 = f46_local0.optionAssetName:get()
				if f46_local1 then
					local f46_local2 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f46_local1))
					if f46_local2 then
						local f46_local3 = CoD.OptionsUtility.GetDefaultOptionIndex(f46_local2)
						f46_local0.currentSelection:set(f46_local3)
						f45_local0:setActiveItem(f45_local0:getItemAt(f46_local3))
						f45_arg0.__lastSelectedIndex = nil
					end
				end
			end
		end)
	end
end
CoD.OptionsUtility.ResetPlayerSettingToDefaultByOptionAssetName = function(f47_arg0, f47_arg1)
	local f47_local0 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f47_arg1))
	if f47_local0 then
		local f47_local1 = nil
		if CoD.OptionsUtility.IsOptionAssetInList(f47_arg1, CoD.CodCasterUtility.CodCasterProfileSettings) then
			f47_local1 = CoD.ShoutcasterProfileVarValue(f47_arg0, f47_local0[0x6E183377E0C37F4])
		else
			f47_local1 = tonumber(Engine[0x8C7ADE01B406F5E](f47_arg0, f47_local0[0x6E183377E0C37F4]))
		end
		local f47_local2 = CoD.OptionsUtility.GetPlayerSettingDefaultValue(f47_arg0, f47_arg1)
		if f47_local1 ~= f47_local2 then
			if CoD.OptionsUtility.IsOptionAssetInList(f47_arg1, CoD.CodCasterUtility.CodCasterProfileSettings) then
				CoD.SetShoutcasterProfileVarValue(f47_arg0, f47_local0[0x6E183377E0C37F4], f47_local2)
			else
				Engine[0x280E4C1191CC53D](f47_arg0, f47_local0[0x6E183377E0C37F4], f47_local2)
			end
			return true
		end
	end
	return false
end
CoD.OptionsUtility.ResetPlayerSettingToDefault = function(f48_arg0, f48_arg1)
	local f48_local0 = f48_arg0:getModel()
	local f48_local1 = f48_local0.optionAssetName
	if f48_local1 then
		f48_local1 = f48_local0.optionAssetName:get()
	end
	if f48_local1 and CoD.OptionsUtility.ResetPlayerSettingToDefaultByOptionAssetName(f48_arg1, f48_local1) then
		f48_arg0:dispatchEventToChildren({
			name = "update_settings_list_focus",
			controller = f48_arg1,
		})
		CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f48_arg1, f48_local1)
	end
end
CoD.OptionsUtility.ResetPlayerSettingsGroupToDefault = function(f49_arg0, f49_arg1)
	if f49_arg0.optionsList and #f49_arg0.optionsList > 0 then
		local f49_local0 = {}
		for f49_local4, f49_local5 in ipairs(f49_arg0.optionsList) do
			if CoD.OptionsUtility.ResetPlayerSettingToDefaultByOptionAssetName(f49_arg1, f49_local5) then
				table.insert(f49_local0, f49_local5)
			end
		end
		if #f49_local0 > 0 then
			f49_arg0:dispatchEventToChildren({
				name = "update_settings_list_focus",
				controller = f49_arg1,
			})
			for f49_local4, f49_local5 in ipairs(f49_local0) do
				CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f49_arg1, f49_local5)
			end
		end
	else
		local f49_local0 = f49_arg0:getModel(f49_arg1, "previewSetting")
		local f49_local1 = f49_local0 and f49_local0:get()
		if f49_local1 and CoD.OptionsUtility.ResetPlayerSettingToDefaultByOptionAssetName(f49_arg1, f49_local1) then
			CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f49_arg1, f49_local1)
		end
	end
end
CoD.OptionsUtility.ResetPlayerSettingsGroupListToDefault = function(f50_arg0, f50_arg1)
	for f50_local3, f50_local4, f50_local5 in f50_arg1:forEachElement() do
		CoD.OptionsUtility.ResetPlayerSettingToDefault(f50_local5, f50_arg0)
	end
end
CoD.OptionsUtility.SetPlayerSettingsModel = function(f51_arg0, f51_arg1, f51_arg2)
	local f51_local0 = CoD.OptionsUtility.CreatePlayerSettingsDatasource(f51_arg1, f51_arg2)
	if f51_local0 and f51_local0.models then
		local f51_local1 = Engine[0x4DF5CFBC1771947](f51_arg1)
		f51_local1 = f51_local1:create("PlayerSetting_" .. f51_arg2)
		LuaUtils.CreateModelsFromTable(f51_local1, f51_local0.models)
		f51_arg0:setModel(f51_local1, f51_arg1)
	end
end
CoD.OptionsUtility.SetOptionHintText = function(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = nil
	if f52_arg1 then
		if f52_arg1.hintText then
			f52_local0 = f52_arg1.hintText
		else
			local f52_local1 = f52_arg1:getModel()
			if f52_local1 then
				f52_local0 = f52_local1.hintText and f52_local1.hintText:get()
			end
		end
	end
	if f52_local0 then
		DataSources.PerController.setHintText(f52_arg2, Engine[0xF9F1239CFD921FE](f52_local0))
	else
		DataSources.PerController.clearHintText(f52_arg2)
	end
end
CoD.OptionsUtility.UpdateBrightnessPreviewColor = function(f53_arg0)
	local f53_local0 = 16 * Engine[0xB75B48400B76AA4](f53_arg0, "r_sceneBrightness") + 29
	local f53_local1 = Engine[0x4DF5CFBC1771947](f53_arg0)
	f53_local1 = f53_local1:create("profile.brightnessPreviewColor")
	f53_local1:set(f53_local0 .. " " .. f53_local0 .. " " .. f53_local0)
end
CoD.OptionsUtility.SetButtonLayoutPreview = function(f54_arg0, f54_arg1)
	local f54_local0 = Engine[0x4DF5CFBC1771947](f54_arg1)
	f54_local0 = f54_local0:create("buttonLayoutPreview")
	local f54_local1 = Engine[0x4DF5CFBC1771947](f54_arg1)
	f54_local1 = f54_local1:create("buttonFlippedPreview")
	local f54_local2 = false
	local f54_local3 = false
	if f54_arg0.actionParam == "gpad_buttonsConfig" or f54_arg0.actionParam == "demo_controllerConfig" then
		f54_local2 = f54_local0:set(f54_arg0.value)
		f54_local3 = f54_local1:set(false)
	elseif f54_arg0.actionParam == "flipped_control_config" then
		f54_local2 = f54_local0:set(false)
		f54_local3 = f54_local1:set(f54_arg0.value)
	end
	if f54_local2 or f54_local3 then
		DataSourceHelperRecreate(f54_arg1, "ButtonLayoutLabels")
	end
end
CoD.OptionsUtility.ClearButtonLayoutPreview = function(f55_arg0)
	local f55_local0 = Engine[0x4DF5CFBC1771947](f55_arg0)
	f55_local0 = f55_local0:create("buttonLayoutPreview")
	local f55_local1 = Engine[0x4DF5CFBC1771947](f55_arg0)
	f55_local1 = f55_local1:create("buttonFlippedPreview")
	if f55_local0:set(false) or f55_local1:set(false) then
		DataSourceHelperRecreate(f55_arg0, "ButtonLayoutLabels")
	end
end
CoD.OptionsUtility.SetStickLayoutPreview = function(f56_arg0, f56_arg1)
	local f56_local0 = Engine[0x4DF5CFBC1771947](f56_arg1)
	f56_local0 = f56_local0:create("stickLayoutPreview")
	if f56_arg0.value and f56_local0:set(f56_arg0.value) then
		DataSourceHelperRecreate(f56_arg1, "StickLayoutLabels")
	end
end
CoD.OptionsUtility.ClearStickLayoutPreview = function(f57_arg0)
	local f57_local0 = Engine[0x4DF5CFBC1771947](f57_arg0)
	f57_local0 = f57_local0:create("stickLayoutPreview")
	if f57_local0:set(false) then
		DataSourceHelperRecreate(f57_arg0, "StickLayoutLabels")
	end
end
CoD.OptionsUtility.ShowHideNetworkSettingInfo = function(f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4)
	local f58_local0 = ""
	local f58_local1 = ""
	if f58_arg1.isHidden then
		f58_local0 = f58_arg1.showingLabel or ""
		f58_local1 = f58_arg1.showingDesc or ""
		f58_arg1.isHidden = false
	else
		f58_local0 = f58_arg1.hiddenLabel or ""
		f58_local1 = f58_arg1.hiddenDesc or ""
		f58_arg1.isHidden = true
	end
	local f58_local2 = f58_arg1:getModel(f58_arg2, "buttonPromptText")
	if f58_local2 then
		f58_local2:set(f58_local0)
	end
	local f58_local3 = f58_arg1:getModel(f58_arg2, "hintText")
	if f58_local3 then
		f58_local3:set(f58_local1)
	end
	CoD.OptionsUtility.SetCurrentOptionInfo(f58_arg1, f58_arg2)
end
CoD.OptionsUtility.IsPlayerSettingsGroupCustom = function(f59_arg0, f59_arg1)
	if f59_arg0.optionsList then
		for f59_local3, f59_local4 in ipairs(f59_arg0.optionsList) do
			if not CoD.OptionsUtility.IsPlayerSettingDefault(f59_arg1, f59_local4) then
				return true
			end
		end
	end
	return false
end
CoD.OptionsUtility.IsCurrentSettingSliderValueDefault = function(f60_arg0, f60_arg1)
	local f60_local0 = f60_arg0:getModel(f60_arg1, "optionAssetName")
	if f60_local0 then
		f60_local0 = f60_local0:get()
	end
	if f60_local0 then
		return CoD.OptionsUtility.IsPlayerSettingDefault(f60_arg1, f60_local0)
	else
		return false
	end
end
CoD.OptionsUtility.IsPlayerSettingItemSelected = function(f61_arg0, f61_arg1, f61_arg2)
	local f61_local0 = f61_arg0:getModel(f61_arg2, "currentSelection")
	local f61_local1 = f61_local0 and f61_local0:get()
	local f61_local2 = f61_arg1:getModel(f61_arg2, "index")
	local f61_local3 = f61_local2 and f61_local2:get()
	if f61_local1 and f61_local3 then
		return f61_local1 == f61_local3
	else
		return false
	end
end
CoD.OptionsUtility.IsBrightnessSetting = function(f62_arg0, f62_arg1)
	local f62_local0 = f62_arg0:getModel(f62_arg1, "optionAssetName")
	local f62_local1 = f62_local0 and f62_local0:get()
	if f62_local1 then
		return CoD.OptionsUtility.IsOptionAssetInList(f62_local1, CoD.OptionsUtility.BrightnessSettings)
	else
		return false
	end
end
CoD.OptionsUtility.IsColorblindSetting = function(f63_arg0, f63_arg1)
	local f63_local0 = f63_arg0:getModel(f63_arg1, "optionAssetName")
	local f63_local1 = f63_local0 and f63_local0:get()
	if f63_local1 then
		return CoD.OptionsUtility.IsOptionAssetInList(f63_local1, CoD.OptionsUtility.ColorblindSettings)
	else
		return false
	end
end
CoD.OptionsUtility.AreCreditsAvailable = function(f64_arg0)
	local f64_local0
	if not IsInGame() then
		if CoD.DirectorUtility.DisableForCurrentMilestone(f64_arg0) then
			f64_local0 = IsGameTrial()
		else
			f64_local0 = true
		end
	else
		f64_local0 = false
	end
	return f64_local0
end
CoD.OptionsUtility.UserGeneratedContentSettingChanged = function(f65_arg0)
	local f65_local0 = Engine[0x4DF5CFBC1771947](f65_arg0)
	f65_local0 = f65_local0.PlayerSettingsUpdate
	return f65_local0 and f65_local0:get() == "user_generated_content"
end
CoD.OptionsUtility.GetCurrentPreviewSettingLabel = function(f66_arg0, f66_arg1)
	local f66_local0 = ""
	local f66_local1 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f66_arg1))
	if f66_local1 then
		local f66_local2 = tonumber(Engine[0x8C7ADE01B406F5E](f66_arg0, f66_local1[0x6E183377E0C37F4]))
		if f66_local1[0x15A0D9812F3D286] == 1 then
			if f66_local2 == 1 then
				f66_local0 = Engine[0xF9F1239CFD921FE](0x5BE4D02B20F370A)
			else
				f66_local0 = Engine[0xF9F1239CFD921FE](0x17857948FC2CCFC)
			end
		elseif f66_local1[0xC97F4CCEE4EFEB7] == 1 then
			f66_local0 = string.format("%g", f66_local2 * f66_local1[0xB04DDD806C34DE8])
		elseif f66_local1.options then
			for f66_local6, f66_local7 in ipairs(f66_local1.options) do
				if tonumber(f66_local7[0xCE4FD9430E80CEA]) == f66_local2 then
					f66_local0 = Engine[0xF9F1239CFD921FE](f66_local7[0x9F7FCEC8FCB623D])
					break
				end
			end
		end
	end
	return f66_local0
end
CoD.OptionsUtility.GetSettingSliderCurrentOptionPip = function(f67_arg0, f67_arg1, f67_arg2, f67_arg3, f67_arg4, f67_arg5)
	local f67_local0 = f67_arg1.totalOptionsCount
	if f67_local0 then
		f67_local0 = f67_arg1.totalOptionsCount:get()
	end
	if f67_local0 then
		local f67_local1 = f67_arg2
		local f67_local2 = 1 / f67_local0
		local f67_local3 = (f67_local1 - 1) * f67_local2
		return f67_local3, f67_local3 + f67_local2, 0, 1
	else
		return f67_arg2, f67_arg3, f67_arg4, f67_arg5
	end
end
CoD.OptionsUtility.GetMaxBotsCount = function()
	if Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x8A42AF1547AB4DF]) > 1 then
		return CoD.OptionsUtility.MaxSplitscreenBots
	else
		return LuaDefine.MAX_CLIENTS
	end
end
CoD.OptionsUtility.DvarShownCustomGameOptions = {
	[0x9EF5478510B5AF3] = {
		0x9C28F0B2A623FA5,
	},
	[0x7C3EBC11793A175] = {
		0x6436F50FAF41689,
		0x65BA2184C27828F,
		0x6700855B131A427,
		0xB74D1759BD25756,
		0x76D5E7BFFCF1E3D,
	},
	[0x686ED971E896201] = {
		0xF55E280D866341D,
		0x2EE429BB9CE771C,
	},
	[0xE30B8B2F3629DA3] = {
		0x6DF1564C342C831,
		0x7FF67C16576E231,
		0xBEC3890EA83D709,
		0xB0BEFCBAC8AEDE6,
	},
	[0xBFA5BDA576BE7C4] = {
		0x5AABD057794561C,
		0x3AC6983716EB72B,
	},
	[0x1232038A2928EDD] = {
		0x4E500E1B323DAF7,
		0x821E81969996ECE,
	},
	[0xE1190045EF3588B] = {
		0x75EC38C3F3487D5,
	},
	[0xC1A8ED8D0BF271C] = {
		0x44B157A9FA6573D,
	},
}
CoD.OptionsUtility.CustomGameOptionsShownByDvar = {}
for f0_local6, f0_local7 in pairs(CoD.OptionsUtility.DvarShownCustomGameOptions) do
	for f0_local3, f0_local4 in ipairs(f0_local7) do
		CoD.OptionsUtility.CustomGameOptionsShownByDvar[f0_local4] = f0_local6
	end
end
CoD.OptionsUtility.DvarHideCustomGameOption = function(f69_arg0)
	local f69_local0 = f69_arg0
	if type(f69_local0) ~= "xhash" then
		f69_local0 = Engine[0xC53F8D38DF9042B](f69_local0)
	end
	local f69_local1 = CoD.OptionsUtility.CustomGameOptionsShownByDvar[f69_local0]
	if f69_local1 then
		return not IsBooleanDvarSet(f69_local1)
	else
		return false
	end
end
CoD.OptionsUtility.CreateRestrictionGameOptionsDatasourceTable = function(f70_arg0, f70_arg1, f70_arg2)
	local f70_local0 = {}
	for f70_local4, f70_local5 in ipairs(f70_arg1) do
		table.insert(f70_local0, CoD.OptionsUtility.CreateRestrictionListOptions(f70_arg0, f70_local5.name, f70_local5.hintText, f70_local5.setting, f70_local5, f70_arg2 .. "_" .. f70_local4))
	end
	return f70_local0
end
CoD.OptionsUtility.CreateCustomGameOptionsDatasourceTable = function(f71_arg0, f71_arg1, f71_arg2)
	local f71_local0 = {}
	for f71_local4, f71_local5 in ipairs(f71_arg1) do
		if not CoD.OptionsUtility.DvarHideCustomGameOption(f71_local5.setting) then
			table.insert(f71_local0, CoD.OptionsUtility.CreateListOptions(f71_arg0, f71_local5.name, f71_local5.hintText, f71_local5.setting, f71_local5, f71_arg2 .. "_" .. f71_local5.setting))
		end
	end
	return f71_local0
end
CoD.OptionsUtility.CustomGameOptionsSettingsUpdate = function(f72_arg0, f72_arg1, f72_arg2)
	local f72_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings"), "Update")
	if f72_arg1.updateSubscription then
		f72_arg1:removeSubscription(f72_arg1.updateSubscription)
	end
	f72_arg1.updateSubscription = f72_arg1:subscribeToModel(f72_local0, function()
		f72_arg1:updateDataSource(false, true)
	end, false)
end
CoD.OptionsUtility.PrepareWinConditionOptions = function(f74_arg0, f74_arg1)
	local f74_local0 = {}
	local f74_local1 = ""
	local f74_local2 = Engine[0x69811927938FCD7]()
	if f74_arg1.dataSourceName then
		f74_local1 = DataSources[f74_arg1.dataSourceName]._datasourceNameHeader
	end
	local f74_local3 = CoD.OptionsUtility.GetGametypeWinConditionsTable(f74_local2)
	if f74_local3 then
		for f74_local7, f74_local8 in ipairs(f74_local3) do
			table.insert(f74_local0, CoD.OptionsUtility.GetGameSettingsInfo(f74_local8))
		end
		f74_local0 = CoD.OptionsUtility.CreateCustomGameOptionsDatasourceTable(f74_arg0, f74_local0, f74_local1)
	end
	return f74_local0
end
CoD.OptionsUtility.AreWinConditionOptionsDefault = function()
	local f75_local0 = CoD.OptionsUtility.GetGametypeWinConditionsTable(Engine[0x69811927938FCD7]())
	if f75_local0 then
		for f75_local4, f75_local5 in ipairs(f75_local0) do
			local f75_local6 = CoD.OptionsUtility.GetGameSettingsInfo(f75_local5)
			if f75_local6 and not Engine[0xB99615DA5FDB57E](f75_local6.setting) then
				return false
			end
		end
	end
	return true
end
CoD.OptionsUtility.PerpareAdvancedGametypeOptions = function(f76_arg0, f76_arg1)
	local f76_local0 = {}
	local f76_local1 = ""
	local f76_local2 = Engine[0x69811927938FCD7]()
	if f76_arg1.dataSourceName then
		f76_local1 = DataSources[f76_arg1.dataSourceName]._datasourceNameHeader
	end
	local f76_local3 = CoD.OptionsUtility.GetGametypeAdvancedOptionsTable(f76_local2)
	if f76_local3 then
		for f76_local7, f76_local8 in ipairs(f76_local3) do
			table.insert(f76_local0, CoD.OptionsUtility.GetGameSettingsInfo(f76_local8))
		end
		f76_local0 = CoD.OptionsUtility.CreateCustomGameOptionsDatasourceTable(f76_arg0, f76_local0, f76_local1)
	end
	return f76_local0
end
CoD.OptionsUtility.AreAdvancedGametypeOptionsDefault = function()
	local f77_local0 = CoD.OptionsUtility.GetGametypeAdvancedOptionsTable(Engine[0x69811927938FCD7]())
	if f77_local0 then
		for f77_local4, f77_local5 in ipairs(f77_local0) do
			local f77_local6 = CoD.OptionsUtility.GetGameSettingsInfo(f77_local5)
			if f77_local6 and not Engine[0xB99615DA5FDB57E](f77_local6.setting) then
				return false
			end
		end
	end
	return true
end
CoD.OptionsUtility.PrepareRosterOptions = function(f78_arg0, f78_arg1)
	local f78_local0 = {}
	local f78_local1 = 6
	local f78_local2 = Engine[0x1E32FEF495242B8]()
	local f78_local3 = Engine[0x1E32FEF495242B8](true)
	local f78_local4 = function(f79_arg0, f79_arg1, f79_arg2)
		local f79_local0 = f79_arg1:get()
		local f79_local1 = f79_arg0:get()
		local f79_local2 = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3, f80_arg4)
			if f79_arg1:get() ~= f80_arg3 then
				f79_arg1:set(f80_arg3)
				local f80_local0 = Engine[0x8DF2E5447F384B9]()
				f80_local0 = f80_local0:create("GametypeSettings.Update")
				f80_local0:forceNotifySubscriptions()
			end
		end
		local f79_local3 = "gts_maxUniqueRolesPerTeam" .. f79_arg2
		DataSources[f79_local3] = DataSourceHelpers.ListSetup(f79_local3, function()
			local f81_local0 = {}
			for f81_local1 = 0, f78_local1, 1 do
				table.insert(f81_local0, {
					models = {
						text = f81_local1,
					},
					properties = {
						title = 0x0,
						desc = 0x0,
						image = 0x7615068F50B3D66,
						value = f81_local1,
						selectIndex = f81_local1 == f79_local0,
						loopEdges = true,
						action = f79_local2,
						actionParam = f81_local1,
						index = f81_local1 + 1,
						totalOptionsCount = f78_local1 + 1,
						isDefault = f79_local1 == f81_local1,
					},
				})
			end
			f81_local0[1].properties.first = true
			f81_local0[f78_local1 + 1].properties.last = true
			return f81_local0
		end, nil, nil, nil)
		return f79_local3
	end
	local f78_local5 = CoD.PlayerRoleUtility.GetHeroList(Engine[0x3EAC408F958FF05]())
	if f78_local5 then
		for f78_local9, f78_local10 in ipairs(f78_local5) do
			local f78_local11 = f78_local10.bodyIndex
			local f78_local12 = f78_local3[0x53F3A0F536232FB][f78_local11]
			local f78_local13 = f78_local2[0x53F3A0F536232FB][f78_local11]
			table.insert(f78_local0, {
				models = {
					name = Engine[0xF9F1239CFD921FE](f78_local10.displayName),
					desc = 0x3F61F4CF743D1BF,
					image = "blacktransparent",
					optionsDatasource = f78_local4(f78_local12, f78_local13, f78_local11),
				},
				properties = {
					isDefaultCondition = function()
						return f78_local13:get() == f78_local12:get()
					end,
					revert = function(f83_arg0)
						f78_local13:set(f78_local12:get())
					end,
				},
			})
		end
	end
	return f78_local0
end
CoD.OptionsUtility.AreRosterOptionsDefault = function()
	local f84_local0 = CoD.PlayerRoleUtility.GetHeroList(Engine[0x3EAC408F958FF05]())
	if f84_local0 then
		for f84_local4, f84_local5 in ipairs(f84_local0) do
			local f84_local6 = f84_local5.bodyIndex
			local f84_local7 = Engine[0x1E32FEF495242B8]()
			local f84_local8 = Engine[0x1E32FEF495242B8](true)
			if f84_local7[0x53F3A0F536232FB][f84_local6]:get() ~= f84_local8[0x53F3A0F536232FB][f84_local6]:get() then
				return false
			end
		end
	end
	return true
end
CoD.OptionsUtility.CACRestrictionCategories = {
	{
		id = "Weapons",
		name = 0xE8E97B711AC8F24,
		tabIndex = 1,
		image = 0xA26DB0CA8E3CAE0,
	},
	{
		id = "Attachments",
		name = 0x56E6F15BA89EEED,
		tabIndex = 2,
		image = 0xC0BC7A99737BD47,
	},
	{
		id = "Gear",
		name = 0x4AEF303ED69E004,
		tabIndex = 3,
		image = 0xFDFA6EA3CBE57C4,
	},
	{
		id = "Equipment",
		name = 0x5C60F77B9332E5B,
		tabIndex = 4,
		image = 0x8C0672200A742AD,
	},
	{
		id = "Perks",
		name = 0xE2669E63163D964,
		tabIndex = 5,
		image = 0xF307FB3B72049A8,
	},
	{
		id = "Wildcards",
		name = 0x454D80797ED0C36,
		tabIndex = 6,
		image = 0x43BDDEFE06E4FF6,
	},
}
CoD.OptionsUtility.PrepareCACRestrictionGameOptions = function(f85_arg0)
	local f85_local0 = {}
	local f85_local1 = function(f86_arg0, f86_arg1, f86_arg2)
		if f86_arg1.gridInfoTable.parentGrid.openRestriction then
			local f86_local0 = Engine[0x8DF2E5447F384B9]()
			local f86_local1 = f86_local0.GametypeSettings.CACRestrictionTabIndex
			if f86_local1 and f86_arg1.tabIndex then
				f86_local1:set(f86_arg1.tabIndex)
				OpenOverlay(f86_arg0, "GameSettings_CACRestrictionSettings", f86_arg2)
			end
		end
	end
	for f85_local5, f85_local6 in ipairs(CoD.OptionsUtility.CACRestrictionCategories) do
		table.insert(f85_local0, {
			models = {
				categoryName = f85_local6.name,
				categoryImage = f85_local6.image,
			},
			properties = {
				skipUpdateInfoModels = false,
				title = f85_local6.name,
				image = f85_local6.image,
				action = f85_local1,
				tabIndex = f85_local6.tabIndex,
			},
		})
	end
	return f85_local0
end
CoD.OptionsUtility.PrepareAttachmentRestrictionGameOptions = function(f87_arg0)
	local f87_local0 = {}
	local f87_local1 = function(f88_arg0, f88_arg1, f88_arg2)
		if f88_arg1.gridInfoTable.parentGrid.openWeaponAttachment then
			local f88_local0 = Engine[0x8DF2E5447F384B9]()
			local f88_local1 = f88_local0.GametypeSettings.ActiveAttachmentCategoryIndex
			if f88_local1 and f88_arg1.listIndex then
				f88_local1:set(f88_arg1.listIndex)
				OpenOverlay(f88_arg0, "GameSettings_AttachmentRestrictionSettings", f88_arg2)
			end
		end
	end
	for f87_local5, f87_local6 in ipairs(CoD.OptionsUtility.CustomGameOptions.WeaponAttachmentRestrictionOptionCategories) do
		table.insert(f87_local0, {
			models = {
				categoryName = f87_local6.name,
				categoryImage = f87_local6.image,
			},
			properties = {
				skipUpdateInfoModels = false,
				title = f87_local6.name,
				image = f87_local6.image,
				action = f87_local1,
				gameSettingListName = f87_local6.gameSettingListName,
				listIndex = f87_local5,
			},
		})
	end
	return f87_local0
end
CoD.OptionsUtility.PrepareScopeRestrictionGameOptions = function(f89_arg0)
	local f89_local0 = {}
	local f89_local1 = function(f90_arg0, f90_arg1, f90_arg2)
		if f90_arg1.gridInfoTable.parentGrid.openWeaponAttachment then
			local f90_local0 = Engine[0x8DF2E5447F384B9]()
			local f90_local1 = f90_local0.GametypeSettings.ActiveScopeCategoryIndex
			if f90_local1 and f90_arg1.listIndex then
				f90_local1:set(f90_arg1.listIndex)
				OpenOverlay(f90_arg0, "GameSettings_ScopeRestrictionSettings", f90_arg2)
			end
		end
	end
	for f89_local5, f89_local6 in ipairs(CoD.OptionsUtility.CustomGameOptions.WeaponScopeRestrictionOptionCategories) do
		table.insert(f89_local0, {
			models = {
				categoryName = f89_local6.name,
				categoryImage = f89_local6.image,
			},
			properties = {
				skipUpdateInfoModels = false,
				title = f89_local6.name,
				image = f89_local6.image,
				action = f89_local1,
				gameSettingListName = f89_local6.gameSettingListName,
				listIndex = f89_local5,
			},
		})
	end
	return f89_local0
end
CoD.OptionsUtility.InitCurrentActiveRestrictionCategoryIndex = function()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "ActiveRestrictionCategoryIndex"), 1)
end
CoD.OptionsUtility.InitCurrentAttachmentCategoryIndex = function()
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "CurrentAttachmentCategoryIndex"), 1)
end
CoD.OptionsUtility.SetCurrentActiveRestrictionCategoryIndex = function(f93_arg0)
	local f93_local0 = Engine[0x8DF2E5447F384B9]()
	f93_local0 = f93_local0.ActiveRestrictionCategoryIndex
	if f93_local0 then
		f93_local0:set(f93_arg0.index)
	end
end
CoD.OptionsUtility.SetCurrentAttachmentCategoryIndex = function(f94_arg0)
	local f94_local0 = Engine[0x8DF2E5447F384B9]()
	f94_local0 = f94_local0.CurrentAttachmentCategoryIndex
	if f94_local0 then
		f94_local0:set(f94_arg0.index)
	end
end
CoD.OptionsUtility.IsCACCategoryActive = function(f95_arg0)
	local f95_local0 = Engine[0x8DF2E5447F384B9]()
	f95_local0 = f95_local0.ActiveRestrictionCategoryIndex
	if f95_local0 then
		return f95_local0:get() == f95_arg0.CACCategoryIndex
	else
		return false
	end
end
CoD.OptionsUtility.IsOperatorModCategoryActive = function(f96_arg0)
	local f96_local0 = Engine[0x8DF2E5447F384B9]()
	f96_local0 = f96_local0.CurrentAttachmentCategoryIndex
	if f96_local0 then
		return f96_local0:get() == f96_arg0.operatorModCategoryIndex
	else
		return false
	end
end
CoD.OptionsUtility.PrepareRestrictionGameOptions = function(f97_arg0, f97_arg1)
	local f97_local0 = {}
	local f97_local1 = ""
	local f97_local2 = nil
	if f97_arg1.dataSourceName then
		f97_local1 = DataSources[f97_arg1.dataSourceName]._datasourceNameHeader
		f97_local2 = DataSources[f97_arg1.dataSourceName]._gameSettingListName
	end
	if f97_local2 then
		for f97_local6, f97_local7 in ipairs(Engine[0xA7E3CD65E63086F](f97_local2)) do
			table.insert(f97_local0, CoD.OptionsUtility.GetGameSettingsInfoFromTable(f97_local7))
		end
	end
	return CoD.OptionsUtility.CreateRestrictionGameOptionsDatasourceTable(f97_arg0, f97_local0, f97_local1)
end
CoD.OptionsUtility.PrepareCustomGameOptions = function(f98_arg0, f98_arg1)
	local f98_local0 = {}
	local f98_local1 = ""
	local f98_local2 = nil
	if f98_arg1.dataSourceName then
		f98_local1 = DataSources[f98_arg1.dataSourceName]._datasourceNameHeader
		f98_local2 = DataSources[f98_arg1.dataSourceName]._gameSettingListName
	end
	if f98_local2 then
		for f98_local6, f98_local7 in ipairs(Engine[0xA7E3CD65E63086F](f98_local2)) do
			table.insert(f98_local0, CoD.OptionsUtility.GetGameSettingsInfoFromTable(f98_local7))
		end
	end
	return CoD.OptionsUtility.CreateCustomGameOptionsDatasourceTable(f98_arg0, f98_local0, f98_local1)
end
CoD.OptionsUtility.AreCustomGameOptionsDefault = function(f99_arg0)
	if f99_arg0 then
		for f99_local3, f99_local4 in ipairs(Engine[0xA7E3CD65E63086F](f99_arg0)) do
			local f99_local5 = CoD.OptionsUtility.GetGameSettingsInfoFromTable(f99_local4)
			if not Engine[0xB99615DA5FDB57E](f99_local5.setting) then
				return false
			end
		end
	end
	return true
end
CoD.OptionsUtility.AreRestrictionOpionsDefault = function(f100_arg0)
	if f100_arg0 then
		local f100_local0 = Engine[0xA7E3CD65E63086F](f100_arg0)
		if f100_local0 then
			for f100_local4, f100_local5 in ipairs(f100_local0) do
				local f100_local6 = CoD.OptionsUtility.GetGameSettingsInfoFromTable(f100_local5)
				if CoD.OptionsUtility.GetGameTypeSettingFromPath(f100_local6.setting, false) ~= CoD.OptionsUtility.GetGameTypeSettingFromPath(f100_local6.setting, true) then
					return false
				end
			end
		end
	end
	return true
end
CoD.OptionsUtility.CustomGameOptions = {}
CoD.OptionsUtility.CustomGameOptions.GametypeOptionCategories = {
	{
		ref = "winConditions",
		groupName = 0x8834B78A436357A,
		datasourceNameHeader = "WinConditionOptionsList",
		datasourceFunc = CoD.OptionsUtility.PrepareWinConditionOptions,
		isDefaultCondition = CoD.OptionsUtility.AreWinConditionOptionsDefault,
	},
	{
		ref = "advanced",
		groupName = 0x28390D13CBB27BB,
		datasourceNameHeader = "AdvancedGametypeOptionsList",
		datasourceFunc = CoD.OptionsUtility.PerpareAdvancedGametypeOptions,
		isDefaultCondition = CoD.OptionsUtility.AreAdvancedGametypeOptionsDefault,
	},
	{
		ref = "spawn",
		groupName = 0x31964F4B1361B2A,
		datasourceNameHeader = "SpawnOptionsList",
		gameSettingListName = 0xE2B8D2D3AB47434,
	},
	{
		ref = "gameplay",
		groupName = 0xA31D2DFFA5784E3,
		datasourceNameHeader = "GameplayOptionsList",
		gameSettingListName = 0x982E1C9D180D09,
	},
}
CoD.OptionsUtility.CustomGameOptions.SpecialistOptionCategories = {
	{
		ref = "roster",
		groupName = 0xCE0853CC48F0523,
		datasourceNameHeader = "RosterOptionsList",
		datasourceFunc = CoD.OptionsUtility.PrepareRosterOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRosterOptionsDefault,
	},
	{
		ref = "draft",
		groupName = 0xB3B20E9F7EF8F32,
		datasourceNameHeader = "DraftOptionsList",
		gameSettingListName = 0x8268E61B2632DF0,
	},
	{
		ref = "health",
		groupName = 0xFC1BF5051FD9C7F,
		datasourceNameHeader = "HealthOptionsList",
		gameSettingListName = 0x157C260765CC9B,
	},
	{
		ref = "cooldowns",
		groupName = 0xA1C82945949497D,
		datasourceNameHeader = "CooldownsOptionList",
		gameSettingListName = 0xAF9C28E1BF6D7C5,
	},
	{
		ref = "cac",
		groupName = 0x941C9E6F436E2A4,
		datasourceNameHeader = "CACOptionsList",
		gameSettingListName = 0x36329A7175CEDFA,
	},
}
CoD.OptionsUtility.CustomGameOptions.RestrictionOptionCategories = {
	{
		ref = "cac",
		groupName = 0x941C9E6F436E2A4,
		datasourceNameHeader = "cac",
		datasourceFunc = CoD.OptionsUtility.PrepareCACRestrictionGameOptions,
		isDefaultCondition = AlwaysTrue,
		index = 1,
	},
	{
		ref = "scorestreak",
		groupName = 0xD17CC7D16033AEA,
		datasourceNameHeader = "scorestreak",
		gameSettingListName = 0xF49631BB8925FD9,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		index = 2,
	},
	{
		ref = "specialistitem",
		groupName = 0xDB4B25D82BDB7E5,
		datasourceNameHeader = "specialistitem",
		gameSettingListName = 0x696B18E6F5FC6C9,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		index = 3,
	},
}
CoD.OptionsUtility.CustomGameOptions.WeaponRestrictionOptionCategories = {
	{
		ref = "assaultrifle",
		groupName = 0xFE1B0B2003A6CC1,
		datasourceNameHeader = "AR",
		gameSettingListName = 0x76FB5372632DFE7,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "smg",
		groupName = 0x5A1E94F52AC6DAB,
		datasourceNameHeader = "SMG",
		gameSettingListName = 0x34B3EFE87A75373,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "tacticalrifle",
		groupName = 0xFB38D2633FBBEC7,
		datasourceNameHeader = "TR",
		gameSettingListName = 0xFEF4309CE9E136E,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "lmg",
		groupName = 0xDB6F169E46CD4E4,
		datasourceNameHeader = "LMG",
		gameSettingListName = 0x7BDF1F25CF7E7C2,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "sniper",
		groupName = 0xEF865AD574F5FAD,
		datasourceNameHeader = "SR",
		gameSettingListName = 0xAB63B0156A0BFD3,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "secondaries",
		groupName = 0xB00F60446232842,
		datasourceNameHeader = "second",
		gameSettingListName = 0xAF06F4782B7EAEC,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
}
CoD.OptionsUtility.CustomGameOptions.AttachmentRestrictionOptionCategories = {
	{
		ref = "attachments",
		groupName = 0x31E6136F9B444FB,
		datasourceNameHeader = "attach",
		datasourceFunc = CoD.OptionsUtility.PrepareAttachmentRestrictionGameOptions,
		isDefaultCondition = AlwaysTrue,
		index = 1,
	},
	{
		ref = "scopes",
		groupName = 0xBB87386985BA15F,
		datasourceNameHeader = "scope",
		datasourceFunc = CoD.OptionsUtility.PrepareScopeRestrictionGameOptions,
		isDefaultCondition = AlwaysTrue,
		index = 2,
	},
	{
		ref = "operatorMods",
		groupName = 0x912DE50663D611C,
		datasourceNameHeader = "OM",
		gameSettingListName = 0xD1AA8EA775DF1BE,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		index = 3,
	},
}
CoD.OptionsUtility.CustomGameOptions.GearRestrictionOptionCategories = {
	{
		ref = "gear",
		groupName = 0x305E03714EE77FC,
		datasourceNameHeader = "gear",
		gameSettingListName = 0x341FA197163D7BB,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
}
CoD.OptionsUtility.CustomGameOptions.EquipmentRestrictionOptionCategories = {
	{
		ref = "equipment",
		groupName = 0xDA102A6853690E6,
		datasourceNameHeader = "equipment",
		gameSettingListName = 0x851181E44643032,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "abilities",
		groupName = 0x759164343B5C489,
		datasourceNameHeader = "abilities",
		gameSettingListName = 0x9ED388E75ADB17E,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
}
CoD.OptionsUtility.CustomGameOptions.PerkRestrictionOptionCategories = {
	{
		ref = "Perk1",
		groupName = 0xCC26359EAAED27A,
		datasourceNameHeader = "perk1",
		gameSettingListName = 0xD35EC3B2B4D4FCD,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "Perk2",
		groupName = 0xCC26259EAAED0C7,
		datasourceNameHeader = "perk2",
		gameSettingListName = 0x1932698FEBB43EC,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "Perk3",
		groupName = 0xCC26159EAAECF14,
		datasourceNameHeader = "perk3",
		gameSettingListName = 0xDF45CFA77E25457,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
}
CoD.OptionsUtility.CustomGameOptions.WildcardRestrictionOptionCategories = {
	{
		ref = "Primary",
		groupName = 0x15A61D25BFBC0C5,
		datasourceNameHeader = "wc_bonus",
		gameSettingListName = 0x61DD84FB29836E3,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "Secondary",
		groupName = 0xB484D92443361D8,
		datasourceNameHeader = "wc_primary",
		gameSettingListName = 0xBB1D346EDD82C6F,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
	{
		ref = "Perk",
		groupName = 0xBB44C71D0F6B5C8,
		datasourceNameHeader = "wc_secondary",
		gameSettingListName = 0x216798C8AFE6C5D,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
	},
}
CoD.OptionsUtility.CustomGameOptions.WeaponAttachmentRestrictionOptionCategories = {
	{
		ref = "clantag",
		name = 0x87AD82563AAAC53,
		datasourceNameHeader = "clantag",
		gameSettingListName = 0x30934E4914D5786,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x6D0468E5DCF0064,
	},
	{
		ref = "damage",
		name = 0x58A5A9B0D37907E,
		datasourceNameHeader = "dmg",
		gameSettingListName = 0x853570F56380CA9,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x2B70CCA333FBFC4,
	},
	{
		ref = "damage2",
		name = 0x1A84177756A3124,
		datasourceNameHeader = "dmg_2",
		gameSettingListName = 0xF0092F951C5776B,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xCCAB19515532F02,
	},
	{
		ref = "extbarrel",
		name = 0x145598022D0A29A,
		datasourceNameHeader = "extb",
		gameSettingListName = 0x985098E8CA52329,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x12AFED74DF0C6EA,
	},
	{
		ref = "extbarrel2",
		name = 0x979BCBB28846378,
		datasourceNameHeader = "extb_2",
		gameSettingListName = 0x3896122CD22B2EB,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xCD5DFD97021E108,
	},
	{
		ref = "extclip",
		name = 0x8539DADE7DED104,
		datasourceNameHeader = "extc",
		gameSettingListName = 0x673BA0BE6C8221F,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x90EEE777CE07A3D,
	},
	{
		ref = "extclip2",
		name = 0x4E62480FF9D7EC2,
		datasourceNameHeader = "extc_2",
		gameSettingListName = 0xCA7D90A41C4A251,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x4D94409316F677D,
	},
	{
		ref = "extpellets",
		name = 0x49D76181177939A,
		datasourceNameHeader = "extp",
		gameSettingListName = 0x8BAC5F74D6985F9,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x8A5B5F4444F687A,
	},
	{
		ref = "fastreload",
		name = 0x9417526D0316C80,
		datasourceNameHeader = "fastr",
		gameSettingListName = 0xC4CC07C0BB00F43,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x14AF02DB08848BE,
	},
	{
		ref = "fastreload2",
		name = 0xBA6C2F3C3FBB276,
		datasourceNameHeader = "fastr_2",
		gameSettingListName = 0x52765527DA9A64D,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xA9EA9A2F79345E4,
	},
	{
		ref = "fmj",
		name = 0x6C9D4311616D408,
		datasourceNameHeader = "fmj",
		gameSettingListName = 0xF106A80B35F16F7,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x25851700209BC71,
	},
	{
		ref = "fmj2",
		name = 0xFC7C96888CA9E8E,
		datasourceNameHeader = "fmj_2",
		gameSettingListName = 0xCED9A4C7E99F619,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x5CEA453768AE5D9,
	},
	{
		ref = "grip",
		name = 0x668BA627A4613DF,
		datasourceNameHeader = "grip",
		gameSettingListName = 0x4A28A895C252DD4,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xFEA5B59970FD3B8,
	},
	{
		ref = "grip2",
		name = 0xA08A255C513DBB7,
		datasourceNameHeader = "grip_2",
		gameSettingListName = 0x4F88EA6BB5E695C,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xB0CC33BAFE4737E,
	},
	{
		ref = "hipgrip",
		name = 0xA913D1E3A54FD50,
		datasourceNameHeader = "hipg",
		gameSettingListName = 0xF60C6E3A4BBA05F,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xFEA5B59970FD3B8,
	},
	{
		ref = "killcounter",
		name = 0x9403D3AE8FEC071,
		datasourceNameHeader = "killc",
		gameSettingListName = 0x353E9985991D45A,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xDE50A0F088C9890,
	},
	{
		ref = "mixclip",
		name = 0xCC7F71ABFC0CFF9,
		datasourceNameHeader = "mixc",
		gameSettingListName = 0x652994B4B63E58A,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x2B58BAAB55182FA,
	},
	{
		ref = "quickdraw",
		name = 0xD3FB8921872BADC,
		datasourceNameHeader = "quickd",
		gameSettingListName = 0xB1EE51F35879D2B,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x52B907E1C78F6D9,
	},
	{
		ref = "quickdraw2",
		name = 0x6018E3F8AF3A26A,
		datasourceNameHeader = "quickd_2",
		gameSettingListName = 0x63D932124346125,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x1FD714A618B9151,
	},
	{
		ref = "rf",
		name = 0x1B6E00A1E4A4533,
		datasourceNameHeader = "rf",
		gameSettingListName = 0x8F26A8657EE4A50,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x569D7F13CE4A7EA,
	},
	{
		ref = "speedreloader",
		name = 0xA4289CDE4DF7D84,
		datasourceNameHeader = "speedr",
		gameSettingListName = 0x64EDD76C83F0A7B,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xA1B4C89ED2B136C,
	},
	{
		ref = "stabilizer",
		name = 0x6379DF785E8FC82,
		datasourceNameHeader = "stabi",
		gameSettingListName = 0x32EFFD14F3041B5,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xD340684B88F4740,
	},
	{
		ref = "stabilizer2",
		name = 0xC454EB3FEC22798,
		datasourceNameHeader = "stabi_2",
		gameSettingListName = 0x32B47D0292D5C2F,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xD340684B88F4740,
	},
	{
		ref = "stalker",
		name = 0x5ACC09D0CCF025,
		datasourceNameHeader = "stalk",
		gameSettingListName = 0xCC1175D26B7BD0E,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xFAB7A502B3D526A,
	},
	{
		ref = "stalker2",
		name = 0x738CBADCC3BF715,
		datasourceNameHeader = "stalk_2",
		gameSettingListName = 0xBCBDF381C292696,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xDB32E397932EB88,
	},
	{
		ref = "steadyaim",
		name = 0x23A0D2AE835C09A,
		datasourceNameHeader = "stead",
		gameSettingListName = 0xA64984669450221,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x8974283BFD375DF,
	},
	{
		ref = "steadyaim2",
		name = 0xE6507E893565D78,
		datasourceNameHeader = "stead_2",
		gameSettingListName = 0xD8830ABBBD692D3,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xC7BF2DEF45161B7,
	},
	{
		ref = "supply",
		name = 0x2F0AD7055088814,
		datasourceNameHeader = "supply",
		gameSettingListName = 0xD879E820CC6A11B,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x5930767EB77BD40,
	},
	{
		ref = "suppressed",
		name = 0x4E9B9C1D82DD8A9,
		datasourceNameHeader = "suppress",
		gameSettingListName = 0xEC41F9038E2A0DA,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xE782C6128E2EEBE,
	},
}
CoD.OptionsUtility.CustomGameOptions.WeaponScopeRestrictionOptionCategories = {
	{
		ref = "acog",
		name = 0x14D50924A98D471,
		datasourceNameHeader = "acog",
		gameSettingListName = 0x6A1896E5289E6E6,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xEF26FBC6045309B,
	},
	{
		ref = "dualop",
		name = 0x20EA333C5EC0972,
		datasourceNameHeader = "dualop",
		gameSettingListName = 0xB9D2BC62F846E9D,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x6264D3601836C7,
	},
	{
		ref = "elo",
		name = 0x1E802311D14F63B,
		datasourceNameHeader = "elo",
		gameSettingListName = 0x73D46D3E61C81E0,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xF1214A621FB58D6,
	},
	{
		ref = "fastlock",
		name = 0xDD44E49656068F,
		datasourceNameHeader = "fastlock",
		gameSettingListName = 0xDE319E8BAE738A0,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x8974283BFD375DF,
	},
	{
		ref = "holo",
		name = 0x629C45BBBF2D03B,
		datasourceNameHeader = "holo",
		gameSettingListName = 0x37960375278EF0,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x6F32DA6DE7A20A8,
	},
	{
		ref = "ir",
		name = 0x168EA0A1E0834E0,
		datasourceNameHeader = "ir",
		gameSettingListName = 0xFDAE74C8857A22F,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x56979B2EFA2154B,
	},
	{
		ref = "is",
		name = 0x168EB0A1E083693,
		datasourceNameHeader = "is",
		gameSettingListName = 0x370B20C0081D744,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xD2E23BB6EF88D35,
	},
	{
		ref = "mms",
		name = 0xCD59E30F6058B46,
		datasourceNameHeader = "mms",
		gameSettingListName = 0x84D0BA58FC2AFF5,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0xFB2777024FE1303,
	},
	{
		ref = "pscope",
		name = 0x6875A88704D7C94,
		datasourceNameHeader = "pscope",
		gameSettingListName = 0xD70F9460A59270F,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x363EDB767C1A169,
	},
	{
		ref = "reflect",
		name = 0x85F8A52DFF8D4EC,
		datasourceNameHeader = "reflect",
		gameSettingListName = 0x872CAA86A2CBB62,
		datasourceFunc = CoD.OptionsUtility.PrepareRestrictionGameOptions,
		isDefaultCondition = CoD.OptionsUtility.AreRestrictionOpionsDefault,
		image = 0x1DA9CFF81D30682,
	},
}
CoD.OptionsUtility.SetCurrentCACCategoryTab = function(f101_arg0)
	local f101_local0 = Engine[0x8DF2E5447F384B9]()
	f101_local0 = f101_local0.GametypeSettings.CACRestrictionTabIndex
	local f101_local1 = CoD.isPC and f101_arg0.CategoryTabs.categoryTabsListPC or f101_arg0.CategoryTabs.categoryTabsList
	if f101_local0 and f101_local1 then
		f101_local1:setActiveItem(f101_local1:getItemAtPosition(1, f101_local0:get(), false))
	end
end
CoD.OptionsUtility.SetCurrentActiveWeaponAttachmentCategory = function(f102_arg0)
	local f102_local0 = Engine[0x8DF2E5447F384B9]()
	f102_local0 = f102_local0.GametypeSettings.ActiveAttachmentCategoryIndex
	local f102_local1 = CoD.isPC and f102_arg0.OptionCategoryGrid or f102_arg0.OptionCategoryList
	local f102_local2 = f102_arg0.GameSettingsBackground.MenuFrame.CommonHeader.subtitle.StageTitle
	if f102_local0 and f102_local1 and f102_local2 then
		f102_local1:setActiveItem(f102_local1:getItemAtPosition(f102_local0:get(), 1, false))
		local f102_local3 = f102_local2
		local f102_local4 = f102_local2.setText
		local f102_local5 = LocalizeToUpperString
		local f102_local6 = CoD.OptionsUtility.CustomGameOptions.WeaponAttachmentRestrictionOptionCategories
		local f102_local7 = f102_local0
		f102_local4(f102_local3, f102_local5(f102_local6[f102_local0:get()].name))
	end
end
CoD.OptionsUtility.SetCurrentActiveWeaponScopeCategory = function(f103_arg0)
	local f103_local0 = Engine[0x8DF2E5447F384B9]()
	f103_local0 = f103_local0.GametypeSettings.ActiveScopeCategoryIndex
	local f103_local1 = CoD.isPC and f103_arg0.OptionCategoryGrid or f103_arg0.OptionCategoryList
	local f103_local2 = f103_arg0.GameSettingsBackground.MenuFrame.CommonHeader.subtitle.StageTitle
	if f103_local0 and f103_local1 and f103_local2 then
		f103_local1:setActiveItem(f103_local1:getItemAtPosition(f103_local0:get(), 1, false))
		local f103_local3 = f103_local2
		local f103_local4 = f103_local2.setText
		local f103_local5 = LocalizeToUpperString
		local f103_local6 = CoD.OptionsUtility.CustomGameOptions.WeaponScopeRestrictionOptionCategories
		local f103_local7 = f103_local0
		f103_local4(f103_local3, f103_local5(f103_local6[f103_local0:get()].name))
	end
end
CoD.OptionsUtility.PersistentMPCustomGameOptionCategories = {
	"GametypeOptionCategories",
	"SpecialistOptionCategories",
	"RestrictionOptionCategories",
	"WeaponRestrictionOptionCategories",
	"AttachmentRestrictionOptionCategories",
	"GearRestrictionOptionCategories",
	"EquipmentRestrictionOptionCategories",
	"PerkRestrictionOptionCategories",
	"WildcardRestrictionOptionCategories",
	"WeaponAttachmentRestrictionOptionCategories",
	"WeaponScopeRestrictionOptionCategories",
}
CoD.OptionsUtility.IsPersistentMPCustomGameOptionCategories = function(f104_arg0)
	for f104_local3, f104_local4 in ipairs(CoD.OptionsUtility.PersistentMPCustomGameOptionCategories) do
		if f104_local4 == f104_arg0 then
			return true
		end
	end
	return false
end
CoD.OptionsUtility.ClearDynamicCustomGameOptionCategories = function()
	local f105_local0 = {}
	for f105_local4, f105_local5 in pairs(CoD.OptionsUtility.CustomGameOptions) do
		if not CoD.OptionsUtility.IsPersistentMPCustomGameOptionCategories(f105_local4) then
			table.insert(f105_local0, f105_local4)
		end
	end
	for f105_local4, f105_local5 in ipairs(f105_local0) do
		CoD.OptionsUtility.CustomGameOptions[f105_local5] = nil
	end
end
CoD.OptionsUtility.PrepareCustomGameOptionCategories = function(f106_arg0, f106_arg1, f106_arg2)
	local f106_local0 = {}
	for f106_local8, f106_local9 in ipairs(f106_arg1) do
		local f106_local10 = f106_arg2 .. f106_local9.ref
		local f106_local4 = f106_local9.datasourceFunc
		if not f106_local4 then
			f106_local4 = CoD.OptionsUtility.PrepareCustomGameOptions
		end
		DataSources[f106_local10] = DataSourceHelpers.ListSetup(f106_local10, f106_local4, true)
		DataSources[f106_local10]._datasourceNameHeader = f106_local9.datasourceNameHeader
		DataSources[f106_local10]._gameSettingListName = f106_local9.gameSettingListName
		local f106_local5 = {
			models = {
				groupName = f106_local9.groupName,
				optionsListDatasource = f106_local10,
			},
		}
		local f106_local6 = {}
		local f106_local7 = f106_local9.isDefaultCondition
		if not f106_local7 then
			f106_local7 = CoD.OptionsUtility.AreCustomGameOptionsDefault
		end
		f106_local6.isDefaultCondition = f106_local7
		f106_local6.gameSettingListName = f106_local9.gameSettingListName
		f106_local6.index = f106_local9.index or 0
		f106_local5.properties = f106_local6
		table.insert(f106_local0, f106_local5)
	end
	return f106_local0
end
CoD.OptionsUtility.SetupCategoryList = function(f107_arg0, f107_arg1, f107_arg2, f107_arg3)
	local f107_local0 = Engine[0xA7E3CD65E63086F](f107_arg1)
	if f107_local0 then
		for f107_local4, f107_local5 in ipairs(f107_local0) do
			table.insert(f107_arg0, {
				ref = f107_local5[0x4BCADBA8E631B86],
				groupName = f107_local5[0x48D88758C193892],
				datasourceNameHeader = f107_local5[0x4BCADBA8E631B86],
				gameSettingListName = Engine[0xC53F8D38DF9042B](f107_local5[0xAC203D32950D429]),
			})
		end
	end
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMGeneral = function(f108_arg0)
	CoD.OptionsUtility.CustomGameOptions.ZMGeneralOptionCategories = {}
	CoD.OptionsUtility.SetupCategoryList(CoD.OptionsUtility.CustomGameOptions.ZMGeneralOptionCategories, 0x46A5A0343DC92A)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f108_arg0, CoD.OptionsUtility.CustomGameOptions.ZMGeneralOptionCategories, "ZMGeneralOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMSystems = function(f109_arg0)
	CoD.OptionsUtility.CustomGameOptions.ZMSystemsOptionCategories = {}
	CoD.OptionsUtility.SetupCategoryList(CoD.OptionsUtility.CustomGameOptions.ZMSystemsOptionCategories, 0xE88CD8CB0504108)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f109_arg0, CoD.OptionsUtility.CustomGameOptions.ZMSystemsOptionCategories, "ZMSystemsOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMWeapons = function(f110_arg0)
	CoD.OptionsUtility.CustomGameOptions.ZMWeaponsOptionCategories = {}
	CoD.OptionsUtility.SetupCategoryList(CoD.OptionsUtility.CustomGameOptions.ZMWeaponsOptionCategories, 0x48AE780261A4DC3)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f110_arg0, CoD.OptionsUtility.CustomGameOptions.ZMWeaponsOptionCategories, "ZMWeaponsOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMEnemies = function(f111_arg0)
	CoD.OptionsUtility.CustomGameOptions.ZMEnemiesOptionCategories = {}
	CoD.OptionsUtility.SetupCategoryList(CoD.OptionsUtility.CustomGameOptions.ZMEnemiesOptionCategories, 0x97BE4943B698B6)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f111_arg0, CoD.OptionsUtility.CustomGameOptions.ZMEnemiesOptionCategories, "ZMEnemiesOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMPlayer = function(f112_arg0)
	CoD.OptionsUtility.CustomGameOptions.ZMPlayerOptionCategories = {}
	CoD.OptionsUtility.SetupCategoryList(CoD.OptionsUtility.CustomGameOptions.ZMPlayerOptionCategories, 0xEBDF9662AC3257B)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f112_arg0, CoD.OptionsUtility.CustomGameOptions.ZMPlayerOptionCategories, "ZMPlayerOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesGametype = function(f113_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f113_arg0, CoD.OptionsUtility.CustomGameOptions.GametypeOptionCategories, "GametypeOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesSpecialist = function(f114_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f114_arg0, CoD.OptionsUtility.CustomGameOptions.SpecialistOptionCategories, "SpecialistOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionRestrictionGameOptions = function(f115_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f115_arg0, CoD.OptionsUtility.CustomGameOptions.RestrictionOptionCategories, "RestrictionOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWeaponRestriction = function(f116_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f116_arg0, CoD.OptionsUtility.CustomGameOptions.WeaponRestrictionOptionCategories, "WeaponOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesAttachmentRestriction = function(f117_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f117_arg0, CoD.OptionsUtility.CustomGameOptions.AttachmentRestrictionOptionCategories, "AttachmentOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesGearRestriction = function(f118_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f118_arg0, CoD.OptionsUtility.CustomGameOptions.GearRestrictionOptionCategories, "GearOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesEquipmentRestriction = function(f119_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f119_arg0, CoD.OptionsUtility.CustomGameOptions.EquipmentRestrictionOptionCategories, "EquipmentOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesPerkRestriction = function(f120_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f120_arg0, CoD.OptionsUtility.CustomGameOptions.PerkRestrictionOptionCategories, "PerkOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWildcardRestriction = function(f121_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f121_arg0, CoD.OptionsUtility.CustomGameOptions.WildcardRestrictionOptionCategories, "WCOptionCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWeaponAttachmentRestriction = function(f122_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f122_arg0, CoD.OptionsUtility.CustomGameOptions.WeaponAttachmentRestrictionOptionCategories, "WeaponAttachmentCategories_")
end
CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWeaponScopeRestriction = function(f123_arg0)
	return CoD.OptionsUtility.PrepareCustomGameOptionCategories(f123_arg0, CoD.OptionsUtility.CustomGameOptions.WeaponScopeRestrictionOptionCategories, "WeaponScopeCategories_")
end
CoD.OptionsUtility.PrepareGlobalLobbyOptionList = function(f124_arg0)
	local f124_local0 = {}
	for f124_local4, f124_local5 in ipairs(Engine[0xA7E3CD65E63086F](0xB56D51133EFAE32)) do
		table.insert(f124_local0, CoD.OptionsUtility.GetGameSettingsInfoFromTable(f124_local5))
	end
	return CoD.OptionsUtility.CreateCustomGameOptionsDatasourceTable(f124_arg0, f124_local0, "GlobalLobbyOptions_")
end
DataSources.GametypeOptionCategories = DataSourceHelpers.ListSetup("GametypeOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesGametype, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.SpecialistOptionCategories = DataSourceHelpers.ListSetup("SpecialistOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesSpecialist, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.RestrictionOptionCategories = DataSourceHelpers.ListSetup("RestrictionOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionRestrictionGameOptions, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.WeaponRestrictionOptionCategories = DataSourceHelpers.ListSetup("WeaponOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWeaponRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.AttachmentRestrictionOptionCategories = DataSourceHelpers.ListSetup("AttachmentOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesAttachmentRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.GearRestrictionOptionCategories = DataSourceHelpers.ListSetup("GearOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesGearRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.EquipmentRestrictionOptionCategories = DataSourceHelpers.ListSetup("EquipmentOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesEquipmentRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.PerkRestrictionOptionCategories = DataSourceHelpers.ListSetup("PerkOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesPerkRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.WildcardRestrictionOptionCategories = DataSourceHelpers.ListSetup("WCOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWildcardRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.WeaponAttachmentOptionCategories = DataSourceHelpers.ListSetup("WeaponAttachmentOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWeaponAttachmentRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.WeaponScopeOptionCategories = DataSourceHelpers.ListSetup("WeaponScopeOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesWeaponScopeRestriction, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.ZMGeneralOptionCategories = DataSourceHelpers.ListSetup("ZMGeneralOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMGeneral, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.ZMSystemsOptionCategories = DataSourceHelpers.ListSetup("ZMSystemsOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMSystems, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.ZMWeaponsOptionCategories = DataSourceHelpers.ListSetup("ZMWeaponsOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMWeapons, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.ZMEnemiesOptionCategories = DataSourceHelpers.ListSetup("ZMEnemiesOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMEnemies, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.ZMPlayerOptionCategories = DataSourceHelpers.ListSetup("ZMPlayerOptionCategories", CoD.OptionsUtility.PrepareCustomGameOptionCategoriesZMPlayer, nil, nil, CoD.OptionsUtility.CustomGameOptionsSettingsUpdate)
DataSources.GlobalLobbyOptionList = DataSourceHelpers.ListSetup("GlobalLobbyOptionList", CoD.OptionsUtility.PrepareGlobalLobbyOptionList, true)
CoD.OptionsUtility.AreSpecialistOptionsValid = function(f125_arg0)
	local f125_local0 = Engine[0x1E32FEF495242B8]()
	local f125_local1 = CoD.PlayerRoleUtility.GetHeroList(Engine[0x3EAC408F958FF05]())
	if f125_local1 then
		for f125_local5, f125_local6 in ipairs(f125_local1) do
			if f125_local0[0x53F3A0F536232FB][f125_local6.bodyIndex]:get() > 0 then
				return true
			end
		end
	end
	return false
end
CoD.OptionsUtility.ShowInvalidSpecialistOptionsDialog = function(f126_arg0)
	LuaUtils.UI_ShowErrorMessageDialog(f126_arg0, 0x68BDA7CE2E3DF93, 0x2240BD412963AD)
end
CoD.OptionsUtility.IsCustomGameSettingDefault = function(f127_arg0, f127_arg1)
	local f127_local0 = f127_arg0.isDefaultCondition
	if not f127_local0 then
		f127_local0 = f127_arg0:getParent()
		f127_local0 = f127_local0.isDefaultCondition
	end
	local f127_local1
	if f127_arg0:getParent() then
		f127_local1 = f127_arg0:getParent()
		f127_local1 = f127_local1.isRestriction
		if not f127_local1 then
		else
			if f127_local0 then
				return f127_local0(f127_arg0, f127_arg1)
			else
				local f127_local2 = f127_arg0:getModel(f127_arg1, "setting")
				local f127_local3 = f127_local2 and f127_local2:get()
				if f127_local3 then
					local f127_local4, f127_local5 = nil
					if f127_local1 then
						f127_local4 = CoD.OptionsUtility.GetGameTypeSettingFromPath(f127_local3, true)
						f127_local5 = CoD.OptionsUtility.GetGameTypeSettingFromPath(f127_local3, false)
					else
						f127_local4 = Engine[0xDBC2AD5002B261B](f127_local3, true)
						f127_local5 = Engine[0xDBC2AD5002B261B](f127_local3)
					end
					return f127_local5 == f127_local4
				else
					return false
				end
			end
		end
	end
	f127_local1 = false
end
CoD.OptionsUtility.IsCustomGameOptionCategoryDefault = function(f128_arg0, f128_arg1)
	if f128_arg0.isDefaultCondition then
		return f128_arg0.isDefaultCondition(f128_arg0.gameSettingListName, f128_arg1)
	else
		return false
	end
end
CoD.OptionsUtility.IsCustomGameOptionTabDefault = function(f129_arg0, f129_arg1)
	if f129_arg0.optionCategoriesTable then
		for f129_local3, f129_local4 in ipairs(f129_arg0.optionCategoriesTable) do
			if f129_local4.isDefaultCondition then
				if not f129_local4.isDefaultCondition(f129_local4.gameSettingListName) then
					return false
				end
			end
			if not CoD.OptionsUtility.AreCustomGameOptionsDefault(f129_local4.gameSettingListName) then
				return false
			end
		end
	end
	return true
end
CoD.OptionsUtility.AreAllCustomGameOptionsDefault = function(f130_arg0)
	for f130_local6, f130_local7 in pairs(CoD.OptionsUtility.CustomGameOptions) do
		for f130_local3, f130_local4 in ipairs(f130_local7) do
			if f130_local4.isDefaultCondition then
				if not f130_local4.isDefaultCondition(f130_local4.gameSettingListName) then
					return false
				end
			end
			if not CoD.OptionsUtility.AreCustomGameOptionsDefault(f130_local4.gameSettingListName) then
				return false
			end
		end
	end
	return true
end
CoD.OptionsUtility.GetSettingSliderStartEndValues = function(f131_arg0, f131_arg1, f131_arg2)
	local f131_local0 = 0
	local f131_local1 = 0
	if f131_arg2 then
		local f131_local2 = CoD.OptionsUtility.SettingLongSliderStart
		local f131_local3 = CoD.OptionsUtility.SettingLongSliderEnd
		local f131_local4 = 1 / (f131_arg1 - 1)
		f131_local0 = f131_local2
		f131_local1 = (f131_arg0 - 1) * f131_local4 * (f131_local3 - f131_local2) + f131_local2
	else
		local f131_local2 = 1 / f131_arg1
		f131_local0 = (f131_arg0 - 1) * f131_local2
		f131_local1 = f131_local0 + f131_local2
	end
	return f131_local0, f131_local1
end
CoD.OptionsUtility.UpdateSettingSliderBars = function(f132_arg0, f132_arg1, f132_arg2, f132_arg3, f132_arg4, f132_arg5)
	local f132_local0 = f132_arg1.index or 1
	local f132_local1 = f132_arg1.totalOptionsCount or 1
	local f132_local2 = f132_arg1.isDefault
	local f132_local3 = f132_arg1.useLongSlider
	local f132_local4
	if f132_local3 then
		f132_local4 = 1
		if not f132_local4 then
		else
			local f132_local5 = f132_arg0[f132_arg3]
			local f132_local6 = f132_arg0[f132_arg4]
			local f132_local7 = f132_arg0[f132_arg5]
			if f132_local5 then
				f132_local5:setShaderVector(1, f132_local4, 1, 0, 0)
			end
			if f132_local6 or f132_local7 then
				local f132_local8, f132_local9 = CoD.OptionsUtility.GetSettingSliderStartEndValues(f132_local0, f132_local1, f132_local3)
				if f132_local2 then
					f132_local6:setShaderVector(1, f132_local4, 1, 0, 0)
					f132_local6:setShaderVector(2, f132_local8, f132_local9, 0, 1)
					f132_local7:setShaderVector(2, 0, 0, 0, 0)
				else
					f132_local7:setShaderVector(1, f132_local4, 1, 0, 0)
					f132_local7:setShaderVector(2, f132_local8, f132_local9, 0, 1)
					f132_local6:setShaderVector(2, 0, 0, 0, 0)
				end
			end
		end
	end
	f132_local4 = f132_local1
end
CoD.OptionsUtility.UpdateSettingSliderBarsNoCustom = function(f133_arg0, f133_arg1, f133_arg2, f133_arg3, f133_arg4)
	local f133_local0 = f133_arg1.index or 1
	local f133_local1 = f133_arg1.totalOptionsCount or 1
	local f133_local2 = f133_arg1.useLongSlider
	local f133_local3
	if f133_local2 then
		f133_local3 = 1
		if not f133_local3 then
		else
			local f133_local4 = f133_arg0[f133_arg3]
			local f133_local5 = f133_arg0[f133_arg4]
			if f133_local4 then
				f133_local4:setShaderVector(1, f133_local3, 1, 0, 0)
			end
			if f133_local5 then
				local f133_local6, f133_local7 = CoD.OptionsUtility.GetSettingSliderStartEndValues(f133_local0, f133_local1, f133_local2)
				f133_local5:setShaderVector(1, f133_local3, 1, 0, 0)
				f133_local5:setShaderVector(2, f133_local6, f133_local7, 0, 1)
			end
		end
	end
	f133_local3 = f133_local1
end
CoD.OverlayUtility.AddAutoDetectOverlay("SaveCustomGameOptions", {
	menuName = "SystemOverlay_Compact",
	title = 0x10C2995ECE3B47B,
	description = 0x78ED51BF9AC7F6D,
	categoryType = CoD.OverlayUtility.OverlayTypes.Save,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	options = function()
		local f134_local0 = function(f135_arg0, f135_arg1)
			local f135_local0 = GoBack(f135_arg0, f135_arg1)
			CustomGameSettingsMenuClosed(f135_local0, f135_arg1)
			ClearMenuSavedState(f135_local0)
			GoBack(f135_local0, f135_arg1)
		end
		local f134_local1 = function(f136_arg0, f136_arg1)
			GoBack(f136_arg0, f136_arg1)
		end
		local f134_local2 = {}
		table.insert(f134_local2, {
			text = 0xDFD294FC69F682,
			action = f134_local0,
		})
		table.insert(f134_local2, {
			text = 0x5C16E02B211A4F4,
			action = f134_local1,
			isCancelOption = true,
		})
		return f134_local2
	end,
})
CoD.OptionsUtility.OnBotSettingsChange = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3, f137_arg4)
	local f137_local0 = f137_arg3
	local f137_local1 = Engine[0x22EAAB59AA27E9B](f137_local0)
	local f137_local2 = f137_arg1.value
	CoD.OptionsUtility.UpdateInfoModels(f137_arg1)
	if f137_local2 == f137_local1 then
		return
	else
		Engine[0xB177D654FFB67BE](f137_local0, f137_local2)
	end
end
DataSources.BotSettings = DataSourceHelpers.ListSetup(
	"BotSettings",
	function(f138_arg0)
		local f138_local0 = {}
		table.insert(
			f138_local0,
			CoD.OptionsUtility.CreateDvarSettings(f138_arg0, 0xA95F72AAF581A9, 0xCBD385CD19E9EFC, "BotOptions_Difficulty", "bot_difficulty", {
				{
					option = Engine[0xF9F1239CFD921FE](0xC59B321D25B5BDC),
					value = 0,
				},
				{
					option = Engine[0xF9F1239CFD921FE](0x48B9B4B38EF1C6B),
					value = 1,
					default = true,
				},
				{
					option = Engine[0xF9F1239CFD921FE](0x849A68439C5A3AD),
					value = 2,
				},
				{
					option = Engine[0xF9F1239CFD921FE](0x8CB70A94994D5BD),
					value = 3,
				},
			}, nil, CoD.OptionsUtility.OnBotSettingsChange)
		)
		return f138_local0
	end,
	nil,
	nil,
	function(f139_arg0, f139_arg1, f139_arg2)
		local f139_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Update")
		if f139_arg1.updateSubscription then
			f139_arg1:removeSubscription(f139_arg1.updateSubscription)
		end
		f139_arg1.updateSubscription = f139_arg1:subscribeToModel(f139_local0, function()
			f139_arg1:updateDataSource()
		end, false)
	end
)
CoD.OptionsUtility.ItemSelectedFunction = function(f141_arg0, f141_arg1, f141_arg2, f141_arg3, f141_arg4)
	if f141_arg3 then
		Engine[0x280E4C1191CC53D](f141_arg2, f141_arg3, f141_arg1.value)
	end
end
CoD.OptionsUtility.GetCustomProfileSelection = function(f142_arg0, f142_arg1, f142_arg2)
	for f142_local3, f142_local4 in ipairs(f142_arg1) do
		if f142_arg1[f142_local3].value == tonumber(f142_arg2) then
			return f142_local3
		end
	end
end
CoD.OptionsUtility.GetProfileSelection = function(f143_arg0, f143_arg1, f143_arg2, f143_arg3)
	local f143_local0 = nil
	if f143_arg3 and CoD.OptionsUtility.IsOptionAssetInList(f143_arg3, CoD.CodCasterUtility.CodCasterProfileSettings) then
		f143_local0 = CoD.ShoutcasterProfileVarValue(f143_arg0, f143_arg2)
	else
		f143_local0 = tonumber(Engine[0x8C7ADE01B406F5E](f143_arg0, f143_arg2))
	end
	return CoD.OptionsUtility.GetCustomProfileSelection(f143_arg0, f143_arg1, f143_local0)
end
CoD.OptionsUtility.CreateOptionDataSource = function(f144_arg0, f144_arg1, f144_arg2, f144_arg3, f144_arg4, f144_arg5, f144_arg6)
	local f144_local0 = function()
		local f145_local0 = nil
		if f144_arg3 then
			local f145_local1 = CoD.OptionsUtility.GetProfileSelection(f144_arg0, f144_arg2, f144_arg3, f144_arg6)
			f145_local0 = f144_arg2[f145_local1] and f145_local1 and f144_arg2[f145_local1].value
		end
		return f145_local0
	end
	if f144_arg5 == nil then
		f144_arg5 = f144_local0
	end
	DataSources[f144_arg1] = DataSourceHelpers.ListSetup(f144_arg1, function(f146_arg0)
		local f146_local0 = {}
		for f146_local9, f146_local10 in ipairs(f144_arg2) do
			local f146_local11 = {
				models = {
					text = f146_local10.name,
				},
			}
			local f146_local5 = {
				value = f146_local10.value,
				actionParam = f144_arg3,
				selectIndex = f146_local10.value == f144_arg5(),
			}
			local f146_local4 = f144_arg4
			if not f146_local4 then
				f146_local4 = CoD.OptionsUtility.ItemSelectedFunction
			end
			f146_local5.action = f146_local4
			f146_local5.loopEdges = #f144_arg2 <= 2
			f146_local5.index = f146_local9
			f146_local5.totalOptionsCount = #f144_arg2
			f146_local5.isDefault = f146_local10.isDefault
			f146_local11.properties = f146_local5
			if f146_local10.customModels then
				for f146_local7, f146_local8 in pairs(f146_local10.customModels) do
					f146_local11.models[f146_local7] = f146_local8
				end
			end
			table.insert(f146_local0, f146_local11)
		end
		f146_local0[1].properties.first = true
		f146_local0[#f144_arg2].properties.last = true
		return f146_local0
	end, true)
	return f144_arg1
end
CoD.OptionsUtility.GetPlayerStat = function(f147_arg0, f147_arg1)
	local f147_local0 = Engine[0xA6C26EBACD7322D](f147_arg0)
	for f147_local4, f147_local5 in ipairs(f147_arg1) do
		if not f147_local0 then
			break
		end
		f147_local0 = f147_local0[f147_local5]
	end
	return f147_local0
end
CoD.OptionsUtility.StatItemSelectedFunction = function(f148_arg0, f148_arg1, f148_arg2, f148_arg3, f148_arg4)
	local f148_local0 = CoD.OptionsUtility.GetPlayerStat(f148_arg2, f148_arg3)
	if f148_local0 then
		f148_local0:set(f148_arg1.value)
	end
end
CoD.OptionsUtility.GetCustomStatSelection = function(f149_arg0, f149_arg1, f149_arg2, f149_arg3)
	local f149_local0 = CoD.OptionsUtility.GetPlayerStat(f149_arg0, f149_arg2)
	local f149_local1 = CoD.OptionsUtility.GetCustomProfileSelection
	local f149_local2 = f149_arg0
	local f149_local3 = f149_arg1
	local f149_local4 = tonumber
	local f149_local5
	if f149_local0 then
		f149_local5 = f149_local0:get()
		if not f149_local5 then
		else
			return f149_local1(f149_local2, f149_local3, f149_local4(f149_local5))
		end
	end
	f149_local5 = 0
end
CoD.OptionsUtility.CreateStatDataSource = function(f150_arg0, f150_arg1, f150_arg2, f150_arg3, f150_arg4, f150_arg5)
	DataSources[f150_arg1] = DataSourceHelpers.ListSetup(f150_arg1, function(f151_arg0)
		local f151_local0 = {}
		for f151_local9, f151_local10 in ipairs(f150_arg2) do
			local f151_local11 = {
				models = {
					text = f151_local10.name,
				},
			}
			local f151_local5 = {
				value = f151_local10.value,
				actionParam = f150_arg3,
			}
			local f151_local4 = f150_arg4
			if not f151_local4 then
				f151_local4 = CoD.OptionsUtility.StatItemSelectedFunction
			end
			f151_local5.action = f151_local4
			f151_local5.loopEdges = #f150_arg2 <= 2
			f151_local5.selectIndex = f150_arg5 == f151_local9
			f151_local11.properties = f151_local5
			if f151_local10.customModels then
				for f151_local7, f151_local8 in pairs(f151_local10.customModels) do
					f151_local11.models[f151_local7] = f151_local8
				end
			end
			table.insert(f151_local0, f151_local11)
		end
		f151_local0[1].properties.first = true
		f151_local0[#f150_arg2].properties.last = true
		return f151_local0
	end, true)
	return f150_arg1
end
CoD.OptionsUtility.CustomItemSelectedFunction = function(f152_arg0, f152_arg1, f152_arg2, f152_arg3, f152_arg4)
	local f152_local0 = f152_arg1.value
	local f152_local1 = f152_arg1.valueChangedCallback(f152_local0)
	if f152_local1 then
		f152_local0 = f152_local1
	end
	if f152_arg3 then
		Engine[0x280E4C1191CC53D](f152_arg2, f152_arg3, f152_local0)
	end
end
CoD.OptionsUtility.CreateCustomOptionDataSource = function(f153_arg0, f153_arg1, f153_arg2, f153_arg3, f153_arg4, f153_arg5, f153_arg6)
	local f153_local0 = nil
	if f153_arg3 then
		local f153_local1 = CoD.OptionsUtility.GetProfileSelection(f153_arg0, f153_arg2, f153_arg3)
		f153_local0 = f153_arg2[f153_local1] and f153_local1 and f153_arg2[f153_local1].value
	end
	DataSources[f153_arg1] = DataSourceHelpers.ListSetup(f153_arg1, function(f154_arg0)
		local f154_local0 = {}
		if not f153_arg5 then
			f153_arg5 = CoD.OptionsUtility.CustomItemSelectedFunction
		end
		for f154_local4, f154_local5 in ipairs(f153_arg2) do
			table.insert(f154_local0, {
				models = {
					text = f153_arg2[f154_local4].name,
					index = f154_local4,
					totalOptionsCount = #f153_arg2,
				},
				properties = {
					index = f154_local4,
					totalOptionsCount = #f153_arg2,
					value = f153_arg2[f154_local4].value,
					options = f153_arg2,
					actionParam = f153_arg3,
					action = f153_arg5,
					selectIndex = f154_local5.value == f153_local0,
					valueChangedCallback = f153_arg4,
					revertAction = f153_arg6,
				},
			})
		end
		f154_local0[1].properties.first = true
		f154_local0[#f153_arg2].properties.last = true
		return f154_local0
	end, true)
	return f153_arg1
end
CoD.OptionsUtility.RefetchRegulations = function(f155_arg0, f155_arg1)
	local f155_local0 = DataSources.PrivacySettingManagementForm.getModel(f155_arg0)
	f155_local0 = f155_local0.updateProgressState
	local f155_local1 = f155_arg1
	local f155_local2 = f155_arg1.subscribeToModel
	local f155_local3 = Engine[0x4DF5CFBC1771947](f155_arg0)
	f155_arg1._refetchRegulationsModelSubscription = f155_local2(f155_local1, f155_local3.Regulation.getRegulationTaskState, function(f156_arg0)
		local f156_local0 = f156_arg0:get()
		if f156_local0 ~= Enum[0xF55D2209BB384C0][0xD2F6C862853BF9] and f156_local0 ~= Enum[0xF55D2209BB384C0][0xA9FE23E308C562E] then
			if f155_arg1._refetchRegulationsModelSubscription then
				f155_arg1:removeSubscription(f155_arg1._refetchRegulationsModelSubscription)
				f155_arg1._refetchRegulationsModelSubscription = nil
			end
			if f156_local0 == Enum[0xF55D2209BB384C0][0x3C6AFF8EA8A6DE0] then
				if f155_arg1._updatePrivacySettingsTimeOutTimer then
					f155_arg1._updatePrivacySettingsTimeOutTimer:close()
					f155_arg1._updatePrivacySettingsTimeOutTimer = nil
				end
				f155_local0:set(Enum[0x65887EAAB38F9F8][0xDE287BA1764B6AE])
			elseif f156_local0 == Enum[0xF55D2209BB384C0][0x9F6E852BF8BA43E] then
				f155_local0:set(Enum[0x65887EAAB38F9F8][0xF100F564F11A910])
			end
		end
	end, false)
	Engine[0xB7FD5C8C333B560](f155_arg0)
end
CoD.OptionsUtility.RefetchUserRegulationPreferences = function(f157_arg0, f157_arg1)
	local f157_local0 = DataSources.PrivacySettingManagementForm.getModel(f157_arg0)
	f157_local0 = f157_local0.updateProgressState
	local f157_local1 = f157_arg1
	local f157_local2 = f157_arg1.subscribeToModel
	local f157_local3 = Engine[0x4DF5CFBC1771947](f157_arg0)
	f157_arg1._refetchRegulationPreferencesModelSubscription = f157_local2(f157_local1, f157_local3.Regulation.getRegulationUserPreferenceTaskState, function(f158_arg0)
		local f158_local0 = f158_arg0:get()
		if f158_local0 ~= Enum[0x310FB3777A7C3CF][0xF379E60B34CEDA0] and f158_local0 ~= Enum[0x310FB3777A7C3CF][0x26E57777CD6130D] then
			if f157_arg1._refetchRegulationPreferencesModelSubscription then
				f157_arg1:removeSubscription(f157_arg1._refetchRegulationPreferencesModelSubscription)
				f157_arg1._refetchRegulationPreferencesModelSubscription = nil
			end
			if f158_local0 == Enum[0x310FB3777A7C3CF][0x88D0D20FAF1996D] then
				CoD.OptionsUtility.RefetchRegulations(f157_arg0, f157_arg1)
			elseif f158_local0 == Enum[0x310FB3777A7C3CF][0x9E44B3114CCE857] then
				f157_local0:set(Enum[0x65887EAAB38F9F8][0xF100F564F11A910])
			end
		end
	end, false)
	Engine[0x10B58B22A102AA2](f157_arg0)
end
CoD.OptionsUtility.DelaySetNextUserRegulationPreference = function(f159_arg0, f159_arg1, f159_arg2)
	f159_arg1._delaySetNextUserRegulationPreferenceTimer = LUI.UITimer.newElementTimer(f159_arg2, true, function()
		if f159_arg1._delaySetNextUserRegulationPreferenceTimer then
			f159_arg1._delaySetNextUserRegulationPreferenceTimer:close()
			f159_arg1._delaySetNextUserRegulationPreferenceTimer = nil
		end
		CoD.OptionsUtility.SetNextUserRegulationPreference(f159_arg0, f159_arg1)
	end)
	f159_arg1:addElement(f159_arg1._delaySetNextUserRegulationPreferenceTimer)
end
CoD.OptionsUtility.SetNextUserRegulationPreference = function(f161_arg0, f161_arg1)
	local f161_local0 = DataSources.PrivacySettingManagementForm.getModel(f161_arg0)
	f161_local0 = f161_local0.updateProgressState
	if #f161_arg1._regulationPreferencesToSet < f161_arg1._regultionIndex then
		CoD.OptionsUtility.RefetchUserRegulationPreferences(f161_arg0, f161_arg1)
	else
		local f161_local1 = f161_arg1
		local f161_local2 = f161_arg1.subscribeToModel
		local f161_local3 = Engine[0x4DF5CFBC1771947](f161_arg0)
		f161_arg1._setRegulationPreferenceModelSubscription = f161_local2(f161_local1, f161_local3.Regulation.updateRegulationTaskState, function(f162_arg0)
			local f162_local0 = f162_arg0:get()
			if f162_local0 ~= Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87] and f162_local0 ~= Enum[0x65887EAAB38F9F8][0xB9DF5339B289B88] then
				if f161_arg1._setRegulationPreferenceModelSubscription then
					f161_arg1:removeSubscription(f161_arg1._setRegulationPreferenceModelSubscription)
					f161_arg1._setRegulationPreferenceModelSubscription = nil
				end
				if f162_local0 == Enum[0x65887EAAB38F9F8][0xDE287BA1764B6AE] then
					f161_arg1._regultionIndex = f161_arg1._regultionIndex + 1
					CoD.OptionsUtility.DelaySetNextUserRegulationPreference(f161_arg0, f161_arg1, 250)
				elseif f162_local0 == Enum[0x65887EAAB38F9F8][0xF100F564F11A910] then
					f161_local0:set(Enum[0x65887EAAB38F9F8][0xF100F564F11A910])
				end
			end
		end, false)
		f161_local2 = f161_arg1._regulationPreferencesToSet[f161_arg1._regultionIndex]
		Engine[0x7C75E608EA39B5C](f161_arg0, "setUserRegulationPreference " .. f161_local2.regulationName .. " " .. f161_local2.versionNumber .. " " .. (f161_local2.currentValue and "1" or "0"))
	end
end
CoD.OptionsUtility.ApplyPrivacySettingUpdates = function(f163_arg0, f163_arg1, f163_arg2)
	local f163_local0 = Engine[0x4DF5CFBC1771947](f163_arg1)
	f163_local0 = f163_local0.Regulation
	local f163_local1 = DataSources.PrivacySettingManagementForm.getModel(f163_arg1)
	f163_local1.updateProgressState:set(Enum[0x65887EAAB38F9F8][0xB9DF5339B289B88])
	f163_arg2._regultionIndex = 1
	f163_arg2._regulationPreferencesToSet = {}
	for f163_local6, f163_local7, f163_local8 in f163_arg0:forEachElement() do
		local f163_local9 = f163_local8.privacySettingProperties
		if f163_local9 then
			local f163_local5 = f163_local8:getModel()
			f163_local5 = f163_local5.currentValue:get()
			if f163_local9.inverseOptIn then
				f163_local5 = not f163_local5
			end
			table.insert(f163_arg2._regulationPreferencesToSet, {
				regulationName = f163_local9.regulationName,
				versionNumber = f163_local9.versionNumber,
				currentValue = f163_local5,
			})
		end
	end
	f163_arg2._updatePrivacySettingsTimeOutTimer = LUI.UITimer.newElementTimer(30000, true, function()
		if f163_arg2._updatePrivacySettingsTimeOutTimer then
			f163_arg2._updatePrivacySettingsTimeOutTimer:close()
			f163_arg2._updatePrivacySettingsTimeOutTimer = nil
		end
		f163_local1:set(Enum[0x65887EAAB38F9F8][0xF100F564F11A910])
	end)
	f163_arg2:addElement(f163_arg2._updatePrivacySettingsTimeOutTimer)
	CoD.OptionsUtility.SetNextUserRegulationPreference(f163_arg1, f163_arg2)
end
DataSources.PrivacySettingOptionList = DataSourceHelpers.ListSetup("PrivacySettingOptionList", function(f165_arg0)
	local f165_local0 = {}
	local f165_local1 = {}
	local f165_local2 = function(f166_arg0, f166_arg1, f166_arg2, f166_arg3, f166_arg4)
		local f166_local0 = f166_arg1:getModel()
		f166_local0 = f166_local0.currentValue
		f166_local0:set(not f166_local0:get())
	end
	local f165_local3 = function(f167_arg0, f167_arg1, f167_arg2, f167_arg3, f167_arg4)
		if f167_arg1.gridInfoTable and f167_arg1.gridInfoTable.parentGrid then
			CoD.OptionsUtility.ApplyPrivacySettingUpdates(f167_arg1.gridInfoTable.parentGrid, f167_arg2, f167_arg4)
		end
	end
	local f165_local4 = function(f168_arg0, f168_arg1, f168_arg2, f168_arg3, f168_arg4, f168_arg5)
		local f168_local0 = table.insert
		local f168_local1 = f165_local0
		local f168_local2 = {
			models = {
				displayText = f168_arg0,
				currentValue = f168_arg1,
			},
		}
		local f168_local3 = {
			descTextList = f168_arg2,
			privacySettingProperties = f168_arg3,
			sortIndex = f168_arg4,
		}
		local f168_local4
		if f168_arg5 then
			f168_local4 = f165_local3
			if not f168_local4 then
			else
				f168_local3.action = f168_local4
				if f168_arg5 then
					f168_local4 = CoD.StartMenu_Options_ButtonOption
					if not f168_local4 then
					else
						f168_local3.customWidgetOverride = f168_local4
						f168_local2.properties = f168_local3
						f168_local0(f168_local1, f168_local2)
					end
				end
				f168_local4 = nil
			end
		end
		f168_local4 = f165_local2
	end
	for f165_local8, f165_local9 in ipairs(Engine[0xF1DC07D6D6FCCB1](f165_arg0)) do
		f165_local1[f165_local9.name] = f165_local9
	end
	for f165_local9, f165_local10 in ipairs(Engine[0x71D4F3ACFC7A260](f165_arg0)) do
		if not f165_local1[f165_local10.name] then
			f165_local1[f165_local10.name] = f165_local10
		end
	end
	f165_local6 = Engine[0xE00B2F29271C60B](0x32F219664D64096)
	if f165_local6 and f165_local6.privacySettingsList then
		for f165_local10, f165_local24 in ipairs(f165_local6.privacySettingsList) do
			local f165_local25 = f165_local1[f165_local24[0xADCC08CA48ED01A]]
			if f165_local24.versionList and f165_local25 then
				local f165_local11 = f165_local24.versionList[#f165_local24.versionList]
				if f165_local11.descEntryList then
					local f165_local12 = f165_local11.descEntryList[1]
					local f165_local13 = f165_local11.descEntryList[1][0x39D8D28CAEEE1D4]
				end
				local f165_local14 = f165_local12 and f165_local13 or 0x0
				local f165_local15
				if #f165_local24.versionList > 0 then
					f165_local15 = #f165_local24.versionList - 1
					if not f165_local15 then
					else
						local f165_local16 = f165_local11[0x571C2BDC5EE62D7] == 1
						local f165_local17 = f165_local25.optin
						if f165_local17 == nil then
							f165_local17 = f165_local11[0x16EC83454242826] == 1
						elseif f165_local16 then
							f165_local17 = not f165_local17
						end
						local f165_local18 = {}
						for f165_local22, f165_local23 in ipairs(f165_local11.descEntryList) do
							table.insert(f165_local18, f165_local23[0x39D8D28CAEEE1D4])
						end
						f165_local4(f165_local11[0xEAA584BA09D3B9], f165_local17, f165_local18, {
							regulationName = f165_local24[0xADCC08CA48ED01A],
							versionNumber = f165_local15,
							inverseOptIn = f165_local16,
						}, f165_local10, false)
					end
				end
				f165_local15 = 0
			end
		end
	end
	f165_local4(0xF40F3FDF1A1A500, false, {
		0x8842B720D88FF53,
	}, nil, 1000, true)
	table.sort(f165_local0, function(f169_arg0, f169_arg1)
		return f169_arg0.properties.sortIndex < f169_arg1.properties.sortIndex
	end)
	return f165_local0
end)
DataSources.PrivacySettingManagementForm = {
	getModel = function(f170_arg0)
		local f170_local0 = Engine[0x4DF5CFBC1771947](f170_arg0)
		f170_local0 = f170_local0.PrivacySettingManagementForm
		if f170_local0 == nil then
			local f170_local1 = Engine[0x4DF5CFBC1771947](f170_arg0)
			f170_local0 = f170_local1:create("PrivacySettingManagementForm")
			f170_local1 = f170_local0:create("descText")
			f170_local1:set(0x0)
			f170_local1 = f170_local0:create("currentPage")
			f170_local1:set(0)
			f170_local1 = f170_local0:create("lastPage")
			f170_local1:set(0)
			f170_local1 = f170_local0:create("updateProgressState")
			f170_local1:set(Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87])
		end
		return f170_local0
	end,
}
CoD.OptionsUtility.OnPrivacySettingItemFocusChange = function(f171_arg0, f171_arg1)
	local f171_local0 = DataSources.PrivacySettingManagementForm.getModel(f171_arg0)
	if f171_arg1.descTextList then
		f171_local0.descText:set(f171_arg1.descTextList[1] or 0x0)
		f171_local0.currentPage:set(1)
		f171_local0.lastPage:set(#f171_arg1.descTextList)
	else
		f171_local0.descText:set(0x0)
		f171_local0.currentPage:set(1)
		f171_local0.lastPage:set(1)
	end
end
CoD.OptionsUtility.ChangePrivacySettingDescPage = function(f172_arg0, f172_arg1, f172_arg2)
	local f172_local0 = DataSources.PrivacySettingManagementForm.getModel(f172_arg0)
	local f172_local1 = f172_local0.currentPage:get() + (tonumber(f172_arg2) or 0)
	if f172_arg1.descTextList and f172_arg1.descTextList[f172_local1] then
		f172_local0.descText:set(f172_arg1.descTextList[f172_local1])
		f172_local0.currentPage:set(f172_local1)
	end
end
CoD.OptionsUtility.ShowPrivacySettingsButton = function(f173_arg0)
	if IsBooleanDvarSet(0xB5EBB309618BBC7) and not IsInGame() and Engine[0xC68FC14365BB66B](Enum[0x1DD23D27A61F09A][0x9A232F8674583A3]) then
		if #Engine[0xF1DC07D6D6FCCB1](f173_arg0) > 0 then
			return true
		elseif #Engine[0x71D4F3ACFC7A260](f173_arg0) > 0 then
			return true
		end
	end
	return false
end
CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage = function(f174_arg0)
	local f174_local0 = DataSources.PrivacySettingManagementForm.getModel(f174_arg0)
	local f174_local1 = tonumber(f174_local0.currentPage:get()) or 0
	local f174_local2 = tonumber(f174_local0.lastPage:get()) or 0
	local f174_local3
	if f174_local2 > 1 and f174_local2 > f174_local1 then
		f174_local3 = false
	else
		f174_local3 = true
	end
	return f174_local3
end
CoD.OptionsUtility.GametypeSettingsItemSelectedFunction = function(f175_arg0, f175_arg1, f175_arg2, f175_arg3, f175_arg4)
	local f175_local0 = f175_arg3
	local f175_local1 = nil
	if f175_arg1.isRestriction then
		f175_local1 = CoD.OptionsUtility.GetGameTypeSettingFromPath(f175_local0, false)
	else
		f175_local1 = Engine[0xDBC2AD5002B261B](f175_local0, false)
	end
	CoD.OptionsUtility.UpdateInfoModels(f175_arg1)
	if f175_arg1.value == f175_local1 then
		return
	elseif CoD.OptionsUtility.GameSettingValidateFunctions[f175_local0] and not CoD.OptionsUtility.GameSettingValidateFunctions[f175_local0](f175_arg1.value) then
		local f175_local2 = Engine[0xDBC2AD5002B261B](f175_arg1.value)
		local f175_local3 = f175_arg1:getParent()
		f175_local3 = f175_local3:getParent()
		if f175_local3 and f175_local3.lastActiveWidget then
			f175_local3:setActiveItem(f175_local3.lastActiveWidget)
		end
		return
	end
	print("Setting GametypeSetting: " .. f175_arg3 .. " to: " .. f175_arg1.value)
	if f175_arg1.isRestriction then
		CoD.OptionsUtility.SetGameTypeSettingFromPath(f175_local0, f175_arg1.value)
	else
		Engine[0x8F8F27DCB1E337F](f175_arg3, f175_arg1.value)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings"), f175_arg3), f175_arg1.value)
	end
	Engine[0x202BEB9A6859B8B](Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]), Enum[0x35E410854EFA4AD][0x502684AB907572B])
end
CoD.OptionsUtility.GetGameTypeSettingSplitPath = function(f176_arg0)
	local f176_local0 = {}
	for f176_local4 in string.gmatch(string.gsub(f176_arg0, "__", "."), "[^%.]+") do
		table.insert(f176_local0, Engine[0xC53F8D38DF9042B](f176_local4))
	end
	return f176_local0
end
CoD.OptionsUtility.GetGameTypeSettingFromPath = function(f177_arg0, f177_arg1)
	local f177_local0 = CoD.OptionsUtility.GetGameTypeSettingSplitPath(f177_arg0)
	local f177_local1 = table.getn(f177_local0)
	if f177_local1 > 1 then
		return Engine[0xBA261CAAAC2C344](f177_local1, f177_local0, f177_arg1) and 1 or 0
	else
	end
end
CoD.OptionsUtility.SetGameTypeSettingFromPath = function(f178_arg0, f178_arg1)
	local f178_local0 = CoD.OptionsUtility.GetGameTypeSettingSplitPath(f178_arg0)
	local f178_local1 = table.getn(f178_local0)
	if f178_local1 > 1 then
		Engine[0xF8C1298644BFA58](f178_arg1 == 1, f178_local1, f178_local0)
	end
end
CoD.OptionsUtility.CreateGametypeSettingsDataSource = function(f179_arg0, f179_arg1, f179_arg2, f179_arg3, f179_arg4, f179_arg5)
	local f179_local0 = nil
	for f179_local4, f179_local5 in ipairs(f179_arg2) do
		if f179_local5.isDefault then
			f179_local0 = f179_local4
			break
		end
	end
	DataSources[f179_arg1] = DataSourceHelpers.ListSetup(
		f179_arg1,
		function(f180_arg0)
			local f180_local0 = nil
			if f179_arg5 then
				f180_local0 = CoD.OptionsUtility.GetGameTypeSettingFromPath(f179_arg3, false)
			else
				f180_local0 = tonumber(Engine[0xDBC2AD5002B261B](f179_arg3))
			end
			if f180_local0 == nil then
				f180_local0 = 0
			end
			local f180_local1 = {}
			for f180_local5, f180_local6 in ipairs(f179_arg2) do
				table.insert(f180_local1, {
					models = {
						text = f180_local6.name,
					},
					properties = {
						title = f180_local6.title,
						desc = f180_local6.desc,
						image = f180_local6.image,
						value = f180_local6.value,
						actionParam = f179_arg3,
						action = CoD.OptionsUtility.GametypeSettingsItemSelectedFunction,
						selectIndex = f180_local6.value == f180_local0,
						loopEdges = f179_arg4,
						index = f180_local5,
						totalOptionsCount = #f179_arg2,
						isDefault = f180_local6.isDefault,
						useLongSlider = f180_local6.useLongSlider,
						isRestriction = f179_arg5,
						revert = function(f181_arg0)
							if f179_arg5 then
								CoD.OptionsUtility.SetGameTypeSettingFromPath(f179_arg3, CoD.OptionsUtility.GetGameTypeSettingFromPath(f179_arg3, true))
							else
								Engine[0x8F8F27DCB1E337F](f179_arg3, Engine[0xDBC2AD5002B261B](f179_arg3, true))
							end
						end,
					},
				})
			end
			f180_local1[1].properties.first = true
			f180_local1[#f179_arg2].properties.last = true
			return f180_local1
		end,
		true,
		nil,
		function(f182_arg0, f182_arg1, f182_arg2)
			if f179_local0 then
				local f182_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings"), "Reset")
				if f182_arg1.resetSubscription then
					f182_arg1:removeSubscription(f182_arg1.resetSubscription)
				end
				f182_arg1.resetSubscription = f182_arg1:subscribeToModel(f182_local0, function()
					local f183_local0, f183_local1 = f182_arg1:getRowAndColumnForIndex(f179_local0 - 1)
					f182_arg1:setActiveIndex(f183_local0, f183_local1, 0)
				end, false)
			end
		end
	)
	return f179_arg1
end
CoD.OptionsUtility.CreateEnabledDisabledProfileVar = function(f184_arg0, f184_arg1, f184_arg2, f184_arg3, f184_arg4)
	local f184_local0 = {
		{
			name = Engine[0xF9F1239CFD921FE](0x742854D20BB9B14),
			value = 1,
			title = f184_arg1,
			desc = f184_arg2,
		},
		{
			name = Engine[0xF9F1239CFD921FE](0x94EB0E3329EDF5F),
			value = 0,
			title = f184_arg1,
			desc = f184_arg2,
		},
	}
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](f184_arg1),
			desc = Engine[0xF9F1239CFD921FE](f184_arg2),
			image = "blacktransparent",
			optionsDatasource = CoD.OptionsUtility.CreateOptionDataSource(f184_arg0, f184_arg4, f184_local0, f184_arg3),
			currentSelection = CoD.OptionsUtility.GetProfileSelection(f184_arg0, f184_local0, f184_arg3),
		},
		properties = {},
	}
end
CoD.OptionsUtility.CreateEnabledDisabledOptions = function(f185_arg0, f185_arg1, f185_arg2, f185_arg3, f185_arg4)
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](f185_arg1),
			desc = Engine[0xF9F1239CFD921FE](f185_arg2),
			image = "blacktransparent",
			optionsDatasource = CoD.OptionsUtility.CreateGametypeSettingsDataSource(f185_arg0, f185_arg4, {
				{
					name = Engine[0xF9F1239CFD921FE](0x742854D20BB9B14),
					value = 1,
					title = f185_arg1,
					desc = f185_arg2,
				},
				{
					name = Engine[0xF9F1239CFD921FE](0x94EB0E3329EDF5F),
					value = 0,
					title = f185_arg1,
					desc = f185_arg2,
				},
			}, f185_arg3, true),
			setting = f185_arg3,
		},
		properties = {
			revert = function(f186_arg0)
				Engine[0x8F8F27DCB1E337F](f185_arg3, Engine[0xDBC2AD5002B261B](f185_arg3, true))
			end,
		},
	}
end
CoD.OptionsUtility.CreateRestrictionListOptions = function(f187_arg0, f187_arg1, f187_arg2, f187_arg3, f187_arg4, f187_arg5)
	local f187_local0 = f187_arg4.setting or f187_arg3
	local f187_local1 = {}
	local f187_local2 = CoD.OptionsUtility.GetGameTypeSettingFromPath(f187_local0, true)
	local f187_local3 = 0
	local f187_local4 = 1
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](f187_arg1),
			desc = f187_arg4.hintText[1],
			optionsDatasource = CoD.OptionsUtility.CreateGametypeSettingsDataSource(f187_arg0, f187_arg5, {
				{
					name = Engine[0xF9F1239CFD921FE](0x742854D20BB9B14),
					value = f187_local3,
					title = f187_arg1,
					desc = f187_arg2[1],
					isDefault = f187_local3 == f187_local2,
					useLongSlider = f187_arg4.useLongSlider,
					image = f187_arg4.image,
				},
				{
					name = Engine[0xF9F1239CFD921FE](0x94EB0E3329EDF5F),
					value = f187_local4,
					title = f187_arg1,
					desc = f187_arg2[2],
					isDefault = f187_local4 == f187_local2,
					useLongSlider = f187_arg4.useLongSlider,
					image = f187_arg4.image,
				},
			}, f187_local0, false, true),
			setting = f187_local0,
			image = f187_arg4.image,
		},
		properties = {
			skipUpdateInfoModels = true,
			isDefaultCondition = false,
			isRestriction = true,
			revert = function(f188_arg0)
				Engine[0x8F8F27DCB1E337F](f187_local0, Engine[0xDBC2AD5002B261B](f187_local0, true))
			end,
		},
	}
end
CoD.OptionsUtility.CreateListOptions = function(f189_arg0, f189_arg1, f189_arg2, f189_arg3, f189_arg4, f189_arg5)
	local f189_local0 = f189_arg4.setting or f189_arg3
	local f189_local1 = {}
	local f189_local2 = Engine[0x5E32DBCF21BCD0F]()
	local f189_local3 = Engine[0xDBC2AD5002B261B](f189_local0, true)
	for f189_local10, f189_local11 in ipairs(f189_arg4.values) do
		if not CoD.OptionsUtility.GameSettingValidateFunctions[f189_local0] or CoD.OptionsUtility.GameSettingValidateFunctions[f189_local0](f189_local11) then
			local f189_local7 = f189_local11
			if tonumber(f189_local11) then
				f189_local7 = string.gsub(f189_local7, "%.", f189_local2, 1)
			end
			local f189_local8 = f189_local7
			if f189_arg4.labels then
				if f189_arg4.labels[f189_local10] then
					f189_local8 = f189_arg4.labels[f189_local10]
				else
					f189_local8 = f189_arg4.labels[#f189_arg4.labels]
				end
			end
			local f189_local9 = 0x0
			if f189_arg2 then
				if f189_arg2[f189_local10] then
					f189_local9 = f189_arg2[f189_local10]
				else
					f189_local9 = f189_arg2[#f189_arg2]
				end
			end
			f189_local1[#f189_local1 + 1] = {
				name = Engine[0xED84C33EC5F01EA](f189_local8, f189_local7),
				value = f189_local11,
				title = f189_arg1,
				desc = f189_local9,
				isDefault = f189_local11 == f189_local3,
				useLongSlider = f189_arg4.useLongSlider,
			}
		end
	end
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](f189_arg1),
			desc = f189_arg4.hintText[1],
			image = "blacktransparent",
			optionsDatasource = CoD.OptionsUtility.CreateGametypeSettingsDataSource(f189_arg0, f189_arg5, f189_local1, f189_local0, false, false),
			setting = f189_local0,
			addUnlimitedButton = f189_arg4.addUnlimitedButton,
		},
		properties = {
			isDefaultCondition = false,
			revert = function(f190_arg0)
				Engine[0x8F8F27DCB1E337F](f189_local0, Engine[0xDBC2AD5002B261B](f189_local0, true))
			end,
		},
	}
end
CoD.OptionsUtility.CreateDvarSettingsDataSource = function(f191_arg0, f191_arg1, f191_arg2, f191_arg3, f191_arg4, f191_arg5)
	local f191_local0 = Engine[0x22EAAB59AA27E9B](f191_arg3)
	if f191_local0 == nil then
		f191_local0 = 0
	end
	DataSources[f191_arg1] = DataSourceHelpers.ListSetup(f191_arg1, function(f192_arg0)
		local f192_local0 = {}
		for f192_local4, f192_local5 in ipairs(f191_arg2) do
			table.insert(f192_local0, {
				models = {
					text = f191_arg2[f192_local4].name,
				},
				properties = {
					title = f191_arg2[f192_local4].title,
					desc = f191_arg2[f192_local4].desc,
					image = f191_arg2[f192_local4].image,
					value = f191_arg2[f192_local4].value,
					default = f191_arg2[f192_local4].default,
					index = f192_local4,
					totalOptionsCount = #f191_arg2,
					actionParam = f191_arg3,
					action = f191_arg5,
					selectIndex = f191_arg2[f192_local4].value == f191_local0,
					loopEdges = f191_arg4,
					showChangeIndicator = function(f193_arg0, f193_arg1, f193_arg2)
						return f193_arg0.default ~= true
					end,
				},
			})
		end
		f192_local0[1].properties.first = true
		f192_local0[#f191_arg2].properties.last = true
		return f192_local0
	end, nil, nil, nil)
	return f191_arg1
end
CoD.OptionsUtility.CreateDvarSettingsDataSourceCustom = function(f194_arg0, f194_arg1, f194_arg2, f194_arg3, f194_arg4, f194_arg5)
	local f194_local0 = Engine[0x22EAAB59AA27E9B](f194_arg3)
	if f194_local0 == nil then
		f194_local0 = 0
	end
	DataSources[f194_arg1] = DataSourceHelpers.ListSetup(f194_arg1, function(f195_arg0)
		local f195_local0 = {}
		for f195_local4, f195_local5 in ipairs(f194_arg2) do
			table.insert(f195_local0, {
				models = {
					text = f194_arg2[f195_local4].name,
					index = f195_local4,
					totalOptionsCount = #f194_arg2,
				},
				properties = {
					index = f195_local4,
					totalOptionsCount = #f194_arg2,
					value = f194_arg2[f195_local4].value,
					default = f194_arg2[f195_local4].default,
					actionParam = f194_arg3,
					action = f194_arg5,
					selectIndex = f194_arg2[f195_local4].value == f194_local0,
					loopEdges = f194_arg4,
					showChangeIndicator = function(f196_arg0, f196_arg1, f196_arg2)
						return f196_arg0.default ~= true
					end,
				},
			})
		end
		f195_local0[1].properties.first = true
		f195_local0[#f194_arg2].properties.last = true
		return f195_local0
	end, nil, nil, nil)
	return f194_arg1
end
CoD.OptionsUtility.CreateDvarSettings = function(f197_arg0, f197_arg1, f197_arg2, f197_arg3, f197_arg4, f197_arg5, f197_arg6, f197_arg7)
	local f197_local0 = {}
	local f197_local1 = nil
	for f197_local5, f197_local6 in ipairs(f197_arg5) do
		if f197_local6.default == true then
			f197_local1 = f197_local6.value
		end
		table.insert(f197_local0, {
			name = f197_local6.option,
			value = f197_local6.value,
			title = f197_arg1,
			desc = f197_arg2,
			default = f197_local6.default,
		})
	end
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](f197_arg1),
			desc = Engine[0xF9F1239CFD921FE](f197_arg2),
			image = f197_arg6,
			optionsDatasource = CoD.OptionsUtility.CreateDvarSettingsDataSource(f197_arg0, f197_arg3, f197_local0, f197_arg4, false, f197_arg7),
		},
		properties = {
			revert = function(f198_arg0)
				Engine[0xB177D654FFB67BE](f197_arg4, f197_local1)
			end,
		},
	}
end
CoD.OptionsUtility.CreateNamedSettings = function(f199_arg0, f199_arg1, f199_arg2, f199_arg3, f199_arg4, f199_arg5, f199_arg6)
	local f199_local0 = {}
	for f199_local4, f199_local5 in ipairs(f199_arg5) do
		table.insert(f199_local0, {
			name = f199_local5.option,
			value = f199_local5.value,
			title = f199_arg1,
			desc = f199_arg2,
		})
	end
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](f199_arg1),
			desc = Engine[0xF9F1239CFD921FE](f199_arg2),
			image = f199_arg6,
			optionsDatasource = CoD.OptionsUtility.CreateGametypeSettingsDataSource(f199_arg0, f199_arg3, f199_local0, f199_arg4),
			setting = f199_arg4,
		},
		properties = {
			revert = function(f200_arg0)
				Engine[0x8F8F27DCB1E337F](f199_arg4, Engine[0xDBC2AD5002B261B](f199_arg4, true))
			end,
		},
	}
end
CoD.OptionsUtility.UpdateInfoModels = function(f201_arg0)
	if not f201_arg0.skipUpdateInfoModels then
		local f201_local0 = f201_arg0.title
		local f201_local1 = f201_arg0.desc
		local f201_local2 = f201_arg0.image
		local f201_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f201_local3, "title"), f201_local0)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f201_local3, "description"), f201_local1)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f201_local3, "image"), f201_local2)
	end
end
CoD.OptionsUtility.GametypeSettingsSetItemRestrictionState = function(f202_arg0, f202_arg1, f202_arg2, f202_arg3, f202_arg4)
	local f202_local0 = f202_arg1.value
	local f202_local1 = f202_arg3.itemIndex
	CoD.OptionsUtility.UpdateInfoModels(f202_arg1)
	if f202_local1 then
		print("Setting Item Restriction: Item: " .. f202_local1 .. " State: " .. f202_local0)
		local f202_local2 = f202_arg1:getParent()
		f202_local2 = f202_local2:getParent()
		f202_local2 = f202_local2:getParent()
		f202_local2:processEvent({
			name = "update_state",
			controller = f202_arg0.controller,
			controller = f202_arg2,
			forceDispatch = true,
		})
		Engine[0x202BEB9A6859B8B](Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]), Enum[0x35E410854EFA4AD][0x502684AB907572B])
	end
end
CoD.OptionsUtility.GametypeSettingsSetAttachmentRestrictionState = function(f203_arg0, f203_arg1, f203_arg2, f203_arg3, f203_arg4)
	local f203_local0 = f203_arg3.attachmentIndex
	local f203_local1 = f203_arg1.value
	CoD.OptionsUtility.UpdateInfoModels(f203_arg1)
	if not f203_local1 then
		return
	end
	local f203_local2, f203_local3 = CoD.CACUtility.GetAllItems()
	for f203_local7, f203_local8 in pairs(f203_local2) do
		if f203_local8.attachments and f203_local8.attachments[f203_local0] then
			print("Setting Weapon Attachment Restriction: Attachment: " .. f203_local0 .. " Weapon: " .. f203_local7 .. " State: " .. f203_local1)
		end
	end
end
CoD.OptionsUtility.GametypeSettingsSetAttachmentRestrictionStateForGroup = function(f204_arg0, f204_arg1, f204_arg2, f204_arg3, f204_arg4)
	local f204_local0 = f204_arg3.attachmentIndex
	local f204_local1 = f204_arg3.weaponGroups
	local f204_local2 = f204_arg1.value
	CoD.OptionsUtility.UpdateInfoModels(f204_arg1)
	if not f204_local2 then
		return
	end
	local f204_local3, f204_local4 = CoD.CACUtility.GetAllItems()
	for f204_local8, f204_local9 in pairs(f204_local3) do
		if f204_local9.attachments and f204_local9.attachments[f204_local0] and f204_local1[f204_local9.groupIndex] then
			print("Setting Weapon Attachment Restriction: Attachment: " .. f204_local0 .. " Weapon: " .. f204_local8 .. " State: " .. f204_local2)
		end
	end
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings"), "updateWeaponList"))
	f204_local7 = f204_arg1:getParent()
	if f204_local7 then
		f204_local7 = f204_local7:getParent()
		if f204_local7 then
			f204_local7 = f204_local7:getParent()
			if f204_local7 then
				f204_local7:processEvent({
					name = "update_state",
					controller = f204_arg0.controller,
					controller = f204_arg2,
					forceDispatch = true,
				})
			end
		end
	end
end
CoD.OptionsUtility.GametypeSettingsSetAttachmentRestrictionStateForWeapon = function(f205_arg0, f205_arg1, f205_arg2, f205_arg3, f205_arg4)
	local f205_local0 = f205_arg3.attachmentIndex
	local f205_local1 = f205_arg3.weaponIndex
	local f205_local2 = f205_arg1.value
	CoD.OptionsUtility.UpdateInfoModels(f205_arg1)
	print("Setting Weapon Attachment Restriction: Attachment: " .. f205_local0 .. " Weapon: " .. f205_local1 .. " State: " .. f205_local2)
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings"), "updateWeaponGroup"))
	local f205_local3 = f205_arg1:getParent()
	f205_local3 = f205_local3:getParent()
	f205_local3 = f205_local3:getParent()
	f205_local3:processEvent({
		name = "update_state",
		controller = f205_arg0.controller,
		controller = f205_arg2,
		forceDispatch = true,
	})
end
CoD.OptionsUtility.CreateItemRestrictionSettings = function(f206_arg0, f206_arg1, f206_arg2, f206_arg3, f206_arg4, f206_arg5, f206_arg6, f206_arg7, f206_arg8, f206_arg9)
	local f206_local0 = {}
	for f206_local4, f206_local5 in ipairs(f206_arg4) do
		table.insert(f206_local0, {
			name = f206_local5.option,
			value = f206_local5.value,
			title = f206_arg1,
			desc = f206_local5.desc,
			image = f206_arg5,
			disabled = f206_local5.disabled,
			default = f206_local5.default,
		})
	end
	DataSources[f206_arg3] = DataSourceHelpers.ListSetup(f206_arg3, function(f207_arg0)
		local f207_local0 = {}
		for f207_local4, f207_local5 in ipairs(f206_local0) do
			table.insert(f207_local0, {
				models = {
					text = f206_local0[f207_local4].name,
				},
				properties = {
					title = f206_local0[f207_local4].title,
					desc = f206_local0[f207_local4].desc,
					image = f206_local0[f207_local4].image,
					value = f206_local0[f207_local4].value,
					default = f206_local0[f207_local4].default,
					actionParam = f206_arg7,
					action = f206_arg6,
					selectIndex = f206_local0[f207_local4].value == f206_arg8(f206_arg7),
					loopEdges = false,
					showChangeIndicator = function(f208_arg0, f208_arg1, f208_arg2)
						return f208_arg0.default ~= true
					end,
					revert = function(f209_arg0)
						f206_arg9(f209_arg0)
					end,
				},
			})
		end
		f207_local0[1].properties.first = true
		f207_local0[#f206_local0].properties.last = true
		return f207_local0
	end, nil, nil, nil)
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](f206_arg1),
			desc = Engine[0xF9F1239CFD921FE](f206_arg2),
			image = f206_arg5,
			optionsDatasource = f206_arg3,
			itemIndex = f206_arg7.itemIndex,
			attachmentIndex = f206_arg7.attachmentIndex,
			weaponIndex = f206_arg7.weaponIndex,
			weaponGroups = f206_arg7.weaponGroups,
		},
		properties = {
			itemIndex = f206_arg7.itemIndex,
			attachmentIndex = f206_arg7.attachmentIndex,
			weaponIndex = f206_arg7.weaponIndex,
			weaponGroups = f206_arg7.weaponGroups,
			revert = function(f210_arg0)
				f206_arg9(f210_arg0)
			end,
		},
	}
end
CoD.OptionsUtility.GameSettingValidateFunctions = {}
CoD.OptionsUtility.SetGameSettingValidateFunction = function(f211_arg0, f211_arg1)
	CoD.OptionsUtility.GameSettingValidateFunctions[f211_arg0] = f211_arg1
end
CoD.OptionsUtility.IsProfileIntValue = function(f212_arg0, f212_arg1, f212_arg2)
	return Engine[0xB72F603CAC75B3A](f212_arg0, f212_arg1) == f212_arg2
end
CoD.OptionsUtility.GameOptionsPopupSettings = {}
DataSources.SliderOptions = DataSourceHelpers.ListSetup("SliderOptions", function(f213_arg0)
	local f213_local0 = {}
	for f213_local4, f213_local5 in ipairs(CoD.OptionsUtility.GameOptionsPopupSettings) do
		local f213_local6 = CoD.OptionsUtility.GetGameSettingsInfo(f213_local5)
		table.insert(f213_local0, CoD.OptionsUtility.CreateListOptions(f213_arg0, f213_local6.name, f213_local6.hintText, f213_local6.setting, f213_local6, "GameTypeOptionsList_" .. f213_local5))
	end
	return f213_local0
end, true)
CoD.OptionsUtility.LinkToCurrentSelectionAndSetActiveIndex = function(f214_arg0, f214_arg1)
	if not f214_arg0.hasLinkToCurrentSelectionAndSetActiveIndex then
		f214_arg0.hasLinkToCurrentSelectionAndSetActiveIndex = true
		f214_arg1:linkToElementModel(f214_arg0, "currentSelection", true, function(model)
			local f215_local0, f215_local1 = f214_arg1:getRowAndColumnForIndex(model:get() - 1)
			f214_arg1:setActiveIndex(f215_local0, f215_local1, 0)
		end)
	end
end
CoD.OptionsUtility.LinkToCurrentSelection = function(f216_arg0, f216_arg1)
	if not f216_arg0.hasLinkToCurrentSelection then
		f216_arg0.hasLinkToCurrentSelection = true
		f216_arg1:linkToElementModel(f216_arg0, "currentSelection", true, function(model) end)
	end
end
CoD.OptionsUtility.CycleSettingListRight = function(f218_arg0)
	LUI.GridLayout.navigateItemRight(f218_arg0, LUI.GridLayout.NavigationFlags.CHANGE_FOCUS)
end
CoD.OptionsUtility.CycleSettingListLeft = function(f219_arg0)
	LUI.GridLayout.navigateItemLeft(f219_arg0, LUI.GridLayout.NavigationFlags.CHANGE_FOCUS)
end
CoD.OptionsUtility.SetFocusToGrid = function(f220_arg0)
	if f220_arg0 then
		LUI.GridLayout.giveFocusToActiveWidget(f220_arg0)
	end
end
CoD.OptionsUtility.IsButtonUseEquipment = function(f221_arg0, f221_arg1)
	local f221_local0 = Engine[0xD4D7317F380395F](f221_arg0, "gpad_buttonsConfig")
	local f221_local1 = Engine[0xD4D7317F380395F](f221_arg0, "flipped_control_config") == 1
	if f221_arg1 == Enum[0x3DD78803F918E9D][0x493152B20AE4F58] then
		if not f221_local1 then
			return f221_local0 == 2
		else
			return f221_local0 == 4
		end
	elseif f221_arg1 == Enum[0x3DD78803F918E9D][0x49A252B20B48936] then
		if not f221_local1 then
			local f221_local2
			if f221_local0 ~= 0 and f221_local0 ~= 1 and f221_local0 ~= 3 and f221_local0 ~= 6 and f221_local0 ~= 7 and f221_local0 ~= 8 then
				f221_local2 = false
			else
				f221_local2 = true
			end
			return f221_local2
		else
			return f221_local0 == 5
		end
	elseif f221_arg1 == Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC] then
		if not f221_local1 then
			return f221_local0 == 4
		else
			return f221_local0 == 2
		end
	elseif f221_arg1 == Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA] then
		if not f221_local1 then
			return f221_local0 == 5
		else
			local f221_local2
			if f221_local0 ~= 0 and f221_local0 ~= 1 and f221_local0 ~= 3 and f221_local0 ~= 6 and f221_local0 ~= 7 and f221_local0 ~= 8 then
				f221_local2 = false
			else
				f221_local2 = true
			end
		end
		return f221_local2
	else
		return false
	end
end
CoD.OptionsUtility.IsButtonHeal = function(f222_arg0, f222_arg1)
	local f222_local0 = Engine[0xD4D7317F380395F](f222_arg0, "gpad_buttonsConfig")
	local f222_local1 = Engine[0xD4D7317F380395F](f222_arg0, "flipped_control_config") == 1
	if f222_arg1 == Enum[0x3DD78803F918E9D][0x493152B20AE4F58] then
		if not f222_local1 then
			local f222_local2
			if f222_local0 ~= 0 and f222_local0 ~= 1 and f222_local0 ~= 3 and f222_local0 ~= 4 and f222_local0 ~= 8 then
				f222_local2 = false
			else
				f222_local2 = true
			end
			return f222_local2
		end
	elseif f222_arg1 == Enum[0x3DD78803F918E9D][0x49A252B20B48936] then
		if not f222_local1 then
			local f222_local2
			if f222_local0 ~= 2 and f222_local0 ~= 5 then
				f222_local2 = false
			else
				f222_local2 = true
			end
			return f222_local2
		end
	elseif f222_arg1 == Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC] then
		if f222_local1 then
			local f222_local2
			if f222_local0 ~= 0 and f222_local0 ~= 1 and f222_local0 ~= 3 and f222_local0 ~= 4 and f222_local0 ~= 8 then
				f222_local2 = false
			else
				f222_local2 = true
			end
			return f222_local2
		end
	elseif f222_arg1 == Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA] then
		if f222_local1 then
			local f222_local2
			if f222_local0 ~= 2 and f222_local0 ~= 5 then
				f222_local2 = false
			else
				f222_local2 = true
			end
			return f222_local2
		end
	elseif f222_arg1 == Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F] then
		local f222_local2
		if f222_local0 ~= 6 and f222_local0 ~= 7 then
			f222_local2 = false
		else
			f222_local2 = true
		end
		return f222_local2
	end
	return false
end
CoD.OptionsUtility.ZMGameSettingsMainCategories = {
	{
		id = "zm_general",
		displayName = 0xEDC7C8B1FD8453F,
		optionsList = "gsocl_zm_general",
	},
	{
		id = "zm_systems",
		displayName = 0xD1BDFA5F7482249,
		optionsList = "gsocl_zm_systems",
	},
	{
		id = "zm_weapons",
		displayName = 0x5F975C212125124,
		optionsList = "gsocl_zm_weapons",
	},
	{
		id = "zm_enemies",
		displayName = 0xA4C0D40C8DBA6EB,
		optionsList = "gsocl_zm_enemies",
	},
	{
		id = "zm_player",
		displayName = 0x89CF1420A8398FE,
		optionsList = "gsocl_zm_player",
	},
}
DataSources.ZMGameSettings = ListHelper_SetupDataSource("ZMGameSettings", function(f223_arg0)
	return {}
end, true)
DataSources.ZMGameSettingsCategories = ListHelper_SetupDataSource("ZMGameSettingsCategories", function(f224_arg0)
	local f224_local0 = {}
	local f224_local1 = function(f225_arg0)
		local f225_local0 = Engine[0xA7E3CD65E63086F](Engine[0xC53F8D38DF9042B](f225_arg0))
		if f225_local0 then
			for f225_local4, f225_local5 in ipairs(f225_local0) do
				table.insert(f224_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](f225_local5[0x48D88758C193892]),
					},
					properties = {
						title = f225_local5[0x48D88758C193892],
						desc = f225_local5[0x8907AA9F3779B44],
						action = CoD.OptionsUtility.ZombieOpenGameSettingsSubMenu,
						actionParam = {
							"GameSettings_GenericSubmenu",
						},
						settingsListName = f225_local5[0xAC203D32950D429],
					},
				})
			end
		end
	end
	local f224_local2 = CoD.OptionsUtility.GetCurrentGameSettingsTab()
	local f224_local3 = ""
	for f224_local7, f224_local8 in pairs(CoD.OptionsUtility.ZMGameSettingsMainCategories) do
		if f224_local8.id == f224_local2 then
			f224_local3 = f224_local8.optionsList
		end
	end
	f224_local1(f224_local3)
	return f224_local0
end, true)
DataSources.ZMGameSettingsSubmenuSettings = ListHelper_SetupDataSource("ZMGameSettingsSubmenuSettings", function(f226_arg0)
	local f226_local0 = {}
	local f226_local1 = CoD.OptionsUtility.GetGameSettingsModel("settingsSubCategory")
	local f226_local2 = f226_local1:get()
	if f226_local2 then
		for f226_local6, f226_local7 in ipairs(Engine[0xA7E3CD65E63086F](Engine[0xC53F8D38DF9042B](f226_local2))) do
			local f226_local8 = CoD.OptionsUtility.GetGameSettingsInfoFromTable(f226_local7)
			table.insert(f226_local0, CoD.OptionsUtility.CreateListOptions(f226_arg0, f226_local8.name, f226_local8.hintText, f226_local8.setting, f226_local8, "gsol_zm_general_" .. f226_local7[0x4BCADBA8E631B86]))
		end
	end
	return f226_local0
end, true)
CoD.OptionsUtility.ZombieOpenGameSettingsSubMenu = function(f227_arg0, f227_arg1, f227_arg2, f227_arg3, f227_arg4)
	local f227_local0 = CoD.OptionsUtility.GetGameSettingsModel("settingsSubCategory")
	f227_local0:set(f227_arg1.settingsListName)
	f227_arg4:saveState(f227_arg2)
	OpenOverlay(f227_arg4, "GameSettings_GenericSubmenu", f227_arg2)
end
CoD.OptionsUtility.SetupZombieGameSettingsSubmenu = function(f228_arg0, f228_arg1, f228_arg2)
	f228_arg0.Options.ButtonList:setDataSource("ZMGameSettingsSubmenuSettings")
end
CoD.OptionsUtility.SetupZombieGameSettings = function(f229_arg0, f229_arg1, f229_arg2)
	f229_arg0.Options.Sliders:setDataSource("ZMGameSettings")
	f229_arg0.Options.Buttions:setDataSource("ZMGameSettingsCategories")
end
CoD.OptionsUtility.ZombieGameSettingsTabChanged = function(f230_arg0, f230_arg1, f230_arg2, f230_arg3)
	f230_arg0.Options.Sliders:updateDataSource()
	f230_arg0.Options.Buttions:updateDataSource()
end
CoD.OptionsUtility.GetGameSettingsModel = function(f231_arg0)
	local f231_local0 = Engine[0x8DF2E5447F384B9]()
	local f231_local1 = f231_local0:create("GametypeSettings")
	if f231_arg0 then
		return f231_local1:create(f231_arg0)
	else
		return f231_local1
	end
end
CoD.OptionsUtility.GetCurrentGameSettingsTab = function()
	local f232_local0 = CoD.OptionsUtility.GetGameSettingsModel("tabId")
	return f232_local0:get()
end
CoD.OptionsUtility.GameSettingsTabChanged = function(f233_arg0, f233_arg1, f233_arg2)
	local f233_local0 = CoD.OptionsUtility.GetGameSettingsModel("tabId")
	f233_local0:set(f233_arg1.tabId)
	CoD.OptionsUtility.ClearInfoModels()
	CoD.OptionsUtility.UpdateImagePreviewModels(f233_arg1)
end
CoD.OptionsUtility.UpdateImagePreviewModels = function(f234_arg0)
	local f234_local0 = f234_arg0.showSmallPreview or false
	local f234_local1 = f234_arg0.showLargePreview or false
	local f234_local2 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings")
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f234_local2, "showSmallPreview"), f234_local0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f234_local2, "showLargePreview"), f234_local1)
end
CoD.OptionsUtility.ClearInfoModels = function()
	local f235_local0 = 0x0
	local f235_local1 = 0x0
	local f235_local2 = 0x7615068F50B3D66
	local f235_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings")
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f235_local3, "title"), f235_local0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f235_local3, "description"), f235_local1)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f235_local3, "image"), f235_local2)
end
CoD.OptionsUtility.SetFocusToRestrictionOptionsList = function(f236_arg0, f236_arg1)
	local f236_local0 = Engine[0x8DF2E5447F384B9]()
	f236_local0 = f236_local0.ActiveRestrictionCategoryIndex
	local f236_local1 = f236_arg0.CACCategoryIndex
	local f236_local2 = CoD.isPC and f236_arg0.SlidersPC or f236_arg0.Sliders
	local f236_local3 = CoD.isPC and f236_arg0.CACRestrictionCategoriesPC or f236_arg0.CACRestrictionCategories
	if f236_local0 and f236_local0:get() == f236_local1 then
		SetFocusToElement(f236_arg0, f236_local3.id, f236_arg1)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f236_local3)
	else
		SetFocusToElement(f236_arg0, f236_local2.id, f236_arg1)
	end
end
CoD.OptionsUtility.SetFocusToAttachmentOptionsList = function(f237_arg0, f237_arg1)
	local f237_local0 = Engine[0x8DF2E5447F384B9]()
	f237_local0 = f237_local0.CurrentAttachmentCategoryIndex
	local f237_local1 = f237_arg0.operatorModCategoryIndex
	local f237_local2 = CoD.isPC and f237_arg0.SlidersPC or f237_arg0.Sliders
	local f237_local3 = CoD.isPC and f237_arg0.AttachRestrictionCategoriesPC or f237_arg0.AttachRestrictionCategories
	if f237_local0 and f237_local0:get() == f237_local1 then
		SetFocusToElement(f237_arg0, f237_local2.id, f237_arg1)
	else
		SetFocusToElement(f237_arg0, f237_local3.id, f237_arg1)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f237_local3)
	end
end
CoD.OptionsUtility.ZombieGameSettingSetupSubmenuList = function(f238_arg0, f238_arg1)
	local f238_local0 = f238_arg1.ButtonList
	if f238_local0 then
		LUI.OverrideFunction_CallOriginalFirst(f238_local0, "pageUp", function(element)
			element:updateDataSource(true, true, false)
		end)
		LUI.OverrideFunction_CallOriginalFirst(f238_local0, "pageDown", function(element)
			element:updateDataSource(true, true, false)
		end)
	end
end
