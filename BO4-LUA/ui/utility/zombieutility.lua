CoD.ZombieUtility = {}
CoD.ZombieUtility.TrialsInfoStates = LuaEnum.createEnum("STATE_INVISIBLE", "STATE_COUNTER", "STATE_UNCHECKED", "STATE_CHECKED")
CoD.ZombieUtility.TrialsGameStates = LuaEnum.createEnum("STATE_PLAYING", "STATE_ROUND_RESET", "STATE_GAME_OVER_SUCCESS", "STATE_GAME_OVER_FAILURE")
CoD.ZombieUtility.MapToTrialsCSVPrefix = {
	zm_zodt8 = @"hash_EFE70CADBE4C183",
	zm_office = @"hash_2AB7DAAB01B8557E",
	zm_towers = @"hash_7879F08905406A48",
	zm_escape = @"hash_6DA20E363F296451",
	zm_mansion = @"hash_772CB250BE51DE37",
	zm_red = @"hash_74A4EDFD6AD1375",
	zm_white = @"hash_7E5032A765530F0B",
	zm_orange = @"hash_423355D2C68D0B98",
}
CoD.ZombieUtility.MAX_CLIENTS_ZM = 4
CoD.ZombieUtility.Rush = {
	PositionStrings = {
		@"hash_2A73371AB809D14",
		@"hash_2A73671AB80A22D",
		@"hash_2A73571AB80A07A",
		@"hash_2A73071AB8097FB",
	},
}
CoD.ZombieUtility.SpecialZombiesImages = {
	"uie_catalyst_splash",
	"uie_stoker_splash",
	"uie_blightfather_splash",
	"uie_tigeer_splash",
	"uie_marauder_splash",
	"uie_gladiator_splash",
	"uie_hellhound_splash",
	"uie_nova_splash",
	"uie_warden_splash",
	"uie_werewolf_splash",
	"uie_nosferatu_splash",
	"uie_skeleton_fb_splash",
	"uie_gegenees_splash",
	"ui_hud_zm_rush_lightninghounds",
	"ui_hud_zm_rush_nova6bombers",
	"ui_hud_zm_rush_joltingjacks",
	@"hash_3E15FF6A079B0562",
	@"hash_9477BAAE284D117",
}
CoD.ZombieUtility.Tcm = {
	MapNames = {
		@"hash_199FB0AE2F03F1A2",
		@"hash_4D2DD155D209C085",
		@"hash_37683AED7837049E",
		@"hash_35F8C9292224EF9A",
	},
	Rules = {
		{
			@"hash_33C244D92D758043",
			@"hash_33C243D92D757E90",
			@"hash_33C246D92D7583A9",
			@"hash_33C245D92D7581F6",
			@"hash_33C248D92D75870F",
			@"hash_33C247D92D75855C",
			@"hash_33C24AD92D758A75",
			@"hash_33C249D92D7588C2",
		},
		{
			@"hash_35887635B266B5F8",
			@"hash_35887735B266B7AB",
			@"hash_35887835B266B95E",
			@"hash_35887935B266BB11",
			@"hash_35887A35B266BCC4",
			@"hash_35887B35B266BE77",
			@"hash_35887C35B266C02A",
			@"hash_35887D35B266C1DD",
			@"hash_35886E35B266A860",
		},
		{
			@"hash_178F2BE78DDF9457",
			@"hash_178F2AE78DDF92A4",
			@"hash_178F2DE78DDF97BD",
			@"hash_178F2CE78DDF960A",
			@"hash_178F27E78DDF8D8B",
			@"hash_178F26E78DDF8BD8",
			@"hash_178F29E78DDF90F1",
			@"hash_178F28E78DDF8F3E",
			@"hash_178F23E78DDF86BF",
			@"hash_178F22E78DDF850C",
		},
		{
			@"hash_58D7F2F6AEA5FD9B",
			@"hash_58D7F1F6AEA5FBE8",
			@"hash_58D7F4F6AEA60101",
			@"hash_58D7F3F6AEA5FF4E",
			@"hash_58D7F6F6AEA60467",
			@"hash_58D7F5F6AEA602B4",
			@"hash_58D7F8F6AEA607CD",
			@"hash_58D7F7F6AEA6061A",
			@"hash_58D7EAF6AEA5F003",
			@"hash_58D7E9F6AEA5EE50",
			@"hash_1CEBFE2AC40AF008",
			@"hash_1CEBFF2AC40AF1BB",
		},
	},
}
CoD.ZombieUtility.TutorialStringOverrideKBM = {
	[@"hash_42258C918B04D5F2"] = @"hash_566FF1DA2A135D32",
	[@"hash_1544925C6FC2B561"] = @"hash_2622693C3B2CF6DF",
	[@"hash_B7646FEF6461730"] = @"hash_2CF50844EE21F73C",
	[@"hash_C360659FDDE1CA7"] = @"hash_3713CFFAE8B48F55",
	[@"hash_49608704D6C3DC17"] = @"hash_77E4F27EADD05E61",
	[@"hash_52ED5BAFC1E1A62C"] = @"hash_43F817FB61BDA3C8",
}
CoD.ZombieUtility.ZMTrialsEnum = {
	"zm_zodt8_default",
	"zm_towers_default",
	"zm_office_default",
	"zm_escape_default",
	"zm_mansion_default",
	"zm_red_default",
	"zm_zodt8_variant_1",
	"zm_white_default",
	"zm_orange_default",
}
CoD.ZombieUtility.ZombiesTrialsAARStrings = {
	[0] = {
		[@"hash_4C36BC08BE026B1B"] = 0x22DD330E5D2D03,
		[@"hash_3C050E25F20B5814"] = 0x186B330E5416C8,
		[@"hash_1C2A75E3FFC55ABA"] = @"hash_55FCCC7390F542C5",
		[@"hash_198AA0DF94DC45F7"] = @"hash_6E8C885892A76288",
		[@"hash_4D3FCB432AB0BED0"] = @"hash_6E96FA5892B078C3",
		[@"hash_2B5823ED10209C66"] = @"hash_1A520421D887EBE2",
	},
	[1] = {
		[@"hash_4C36BC08BE026B1B"] = @"hash_27E461D6C7FAFC6D",
		[@"hash_3C050E25F20B5814"] = @"hash_766697C1783D654E",
		[@"hash_1C2A75E3FFC55ABA"] = @"hash_5AAD65A984774D93",
		[@"hash_198AA0DF94DC45F7"] = @"hash_455733E33C41608E",
		[@"hash_4D3FCB432AB0BED0"] = @"hash_51AEC93F7D5EC2AD",
		[@"hash_2B5823ED10209C66"] = @"hash_1A232CAC64E6966C",
	},
}
CoD.ZombieUtility.SetTutorialHintStringControllerDependant = function(f1_arg0, f1_arg1, f1_arg2)
	if IsMouseOrKeyboard(f1_arg1) and CoD.ZombieUtility.TutorialStringOverrideKBM[f1_arg2] then
		f1_arg2 = CoD.ZombieUtility.TutorialStringOverrideKBM[f1_arg2]
	end
	return f1_arg2
end
CoD.ZombieUtility.CommonPostLoadHud = function(f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = DataSources.WorldSpaceIndicators.getModel(f2_arg1)
	CoD.HUDUtility.SetupGrenadeWarningIndicators(f2_arg0, f2_arg1)
	if f2_local0 then
		local f2_local1 = function(f3_arg0)
			local f3_local0 = f3_arg0:getFirstChild()
			while f3_local0 do
				if LUI.startswith(f3_local0.id, "bleedOutItem") then
					local f3_local1 = f3_local0:getModel(f2_arg1, "playerName")
					if f3_local1 then
						Engine.SetModelValue(f3_local1, Engine.GetGamertagForClient(f2_arg1, f3_local0.bleedOutClient))
					end
				end
				f3_local0 = f3_local0:getNextSibling()
			end
		end
		local f2_local2 = 0
		local f2_local3 = true
		while f2_local3 do
			local f2_local4 = f2_local0:create("bleedOutModel" .. f2_local2)
			local f2_local5 = f2_local4:create("playerName")
			f2_local5:set(Engine.GetGamertagForClient(f2_arg1, f2_local2))
			local f2_local6 = f2_local4:create("prompt")
			f2_local6:set(@"zmui/revive")
			f2_local6 = f2_local4:create("clockPercent")
			f2_local6:set(0)
			f2_local6 = f2_local4:create("bleedOutPercent")
			f2_local6:set(0)
			f2_local6 = f2_local4:create("stateFlags")
			f2_local6:set(0)
			f2_local6 = f2_local4:create("arrowAngle")
			f2_local6:set(0)
			f2_local6 = f2_local4:create("hide")
			f2_local6:set(0)
			f2_local6 = CoD.ZM_Revive.new(f2_arg0, f2_arg1, 0, 0, 0, CoD.ZM_Revive.__defaultWidth, 0, 0, 0, CoD.ZM_Revive.__defaultHeight)
			f2_local6.bleedOutClient = f2_local2
			f2_local6.id = "bleedOutItem" .. f2_local2
			f2_local6:setModel(f2_local4, f2_arg1)
			f2_local3 = f2_local6:setupBleedOutWidget(f2_arg1, f2_local2)
			f2_arg0:sendInitializationEvents(f2_arg1, f2_local6)
			f2_arg0.fullscreenContainer:addElement(f2_local6)
			if not f2_arg0._connectionChangeHandlerSubscription then
				f2_arg0._connectionChangeHandlerSubscription = f2_arg0.fullscreenContainer:subscribeToModel(Engine.GetModel(Engine.GetModelForController(f2_arg1), "playerConnected"), function(model)
					f2_local1(f2_arg0.fullscreenContainer)
				end)
			end
			f2_local2 = f2_local2 + 1
		end
	end
	f2_arg0.m_inputDisabled = true
	if LUI.DEV ~= nil then
		if LUI.DEVHideButtonPrompts then
			f2_arg0.CursorHint:setAlpha(0)
		end
		f2_arg0:registerEventHandler("hide_button_prompts", function(element, event)
			element.CursorHint:setAlpha(event.show and 1 or 0)
		end)
	end
end
CoD.ZombieUtility.GetCharacterEnumString = function(f6_arg0)
	if f6_arg0 == 0 then
		return "ZOD_CRAFTABLE_RITUAL_NONE_ENUM"
	elseif f6_arg0 == 1 then
		return "ZOD_CRAFTABLE_RITUAL_BOXER_ENUM"
	elseif f6_arg0 == 2 then
		return "ZOD_CRAFTABLE_RITUAL_DETECTIVE_ENUM"
	elseif f6_arg0 == 3 then
		return "ZOD_CRAFTABLE_RITUAL_FEMME_ENUM"
	elseif f6_arg0 == 4 then
		return "ZOD_CRAFTABLE_RITUAL_MAGICIAN_ENUM"
	else
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("ZMHud", "zmhud", function(f7_arg0, f7_arg1)
	f7_arg0:create("player_lives")
	f7_arg0:create("weaponLevel")
	f7_arg0:create("weaponProgression")
	f7_arg0:create("swordEnergy")
	f7_arg0:create("swordState")
	f7_arg0:create("aat")
	f7_arg0:create("aatIcon")
	f7_arg0:create("currentWeaponLocked")
	f7_arg0:create("currentEquipmentLocked")
	f7_arg0:create("currentSpecialLocked")
	local f7_local0 = f7_arg0:create("updateDisableWeapon")
	f7_local0:set(0)
	f7_local0 = f7_arg0:create("delayDisableWeapon")
	f7_local0:set(0)
	f7_local0 = f7_arg0:create("delayDisableEquipment")
	f7_local0:set(0)
	f7_local0 = f7_arg0:create("delayDisableSpecial")
	f7_local0:set(0)
	f7_arg0:create("ammoModifierActive")
	f7_arg0:create("bgb_current")
	f7_arg0:create("bgb_display")
	f7_arg0:create("bgb_timer")
	f7_arg0:create("bgb_activations_remaining")
	f7_arg0:create("bgb_invalid_use")
	f7_arg0:create("bgb_one_shot_use")
end, false)
DataSourceHelpers.GlobalDataSourceSetup("ZMHudGlobal", "ZMHudGlobal", function(f8_arg0)
	local f8_local0 = f8_arg0:create("trials")
	local f8_local1 = f8_local0:create("roundNumber")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("roundTitle")
	f8_local1:set(0x0)
	f8_local1 = f8_local0:create("roundDescription")
	f8_local1:set(0x0)
	f8_local1 = f8_local0:create("failurePlayer")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("failureReason")
	f8_local1:set(0x0)
	f8_local1 = f8_local0:create("strikes")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("gameState")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("disableAbilities")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("disablePerks")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("disableGun")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("disableEquip")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("disableSpecial")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("gameStartTime")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("playerCounterMax")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("infoHidden")
	f8_local1:set(false)
	f8_local1 = f8_local0:create("roundSplashPlay")
	f8_local1:set(false)
	f8_local1 = f8_local0:create("globalCheckState")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("globalCounterValue")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("globalCounterMax")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("hudDeactivated")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("roundSuccess")
	f8_local1:set(0)
	f8_local1 = f8_local0:create("showScoreboard")
	f8_local1:set(0)
	f8_local1 = f8_arg0:create("tcm")
	f8_local1:create("active")
	local f8_local2 = f8_arg0:create("isScoreboardPCOpen")
	f8_local2:set(0)
end, false)
DataSources.TcmRules = DataSourceHelpers.ListSetup(
	"TcmRules",
	function(f9_arg0)
		local f9_local0 = {}
		local f9_local1 = Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.tcm.active")
		local f9_local2 = 0
		if f9_local1 then
			f9_local2 = f9_local1:get()
		end
		local f9_local3 = CoD.ZombieUtility.Tcm.Rules[f9_local2]
		if f9_local3 then
			local f9_local4 = 1
			while f9_local3[f9_local4] do
				table.insert(f9_local0, {
					models = {
						text = f9_local3[f9_local4],
					},
				})
				f9_local4 = f9_local4 + 1
			end
		end
		return f9_local0
	end,
	nil,
	nil,
	function(f10_arg0, f10_arg1, f10_arg2)
		if not f10_arg1.__gameEndSubscription then
			f10_arg1.__gameEndSubscription = true
			f10_arg1:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "ZmHudGlobal.tcm.active"), function(model)
				f10_arg1:clearLayout()
				f10_arg1:updateDataSource(false, false)
			end)
		end
	end
)
DataSources.ZMPlayerList = {
	getModel = function(f12_arg0)
		return Engine.CreateModel(Engine.GetModelForController(f12_arg0), "PlayerList")
	end,
}
DataSources.ZombieGameoverScoreboard = DataSourceHelpers.ListSetup(
	"ZombieGameoverScoreboard",
	function(f13_arg0)
		local f13_local0 = {}
		local f13_local1 = DataSources.ZMPlayerList.getModel(f13_arg0)
		local f13_local2 = Engine.GetClientNum(f13_arg0)
		for f13_local3 = 0, 3, 1 do
			local f13_local6 = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetGlobalModel(), "scoreboard.team1." .. f13_local3 .. ".clientNum")))
			local f13_local7 = f13_local3 + 1
			if f13_local6 > -1 then
				local f13_local8 = Engine.CreateModel(f13_local1, DataSources.PlayerListZM.clientNumToArrayIndex(f13_local6, f13_local2))
				local f13_local9 = f13_local8:create("zombiePlayerIcon")
				local f13_local10 = Engine.GetModel(Engine.GetGlobalModel(), "Clients." .. f13_local6 .. ".scoreboard")
				table.insert(f13_local0, {
					models = {
						clientNum = f13_local6,
						position = f13_local7,
						zombiePlayerIcon = Engine.GetModelValue(f13_local9),
						playerName = Engine.GetModelValue(Engine.GetModel(f13_local10, "playerName")),
						col1 = Engine.GetModelValue(Engine.GetModel(f13_local10, "col1")),
						col2 = Engine.GetModelValue(Engine.GetModel(f13_local10, "col2")),
						col3 = Engine.GetModelValue(Engine.GetModel(f13_local10, "col3")),
						col4 = Engine.GetModelValue(Engine.GetModel(f13_local10, "footer1")),
						col5 = Engine.GetModelValue(Engine.GetModel(f13_local10, "footer2")),
					},
				})
			end
		end
		return f13_local0
	end,
	nil,
	nil,
	function(f14_arg0, f14_arg1, f14_arg2)
		if not f14_arg1.__gameEndSubscription then
			f14_arg1.__gameEndSubscription = true
			local f14_local0 = f14_arg1
			local f14_local1 = f14_arg1.subscribeToModel
			local f14_local2 = Engine.GetModelForController(f14_arg0)
			f14_local1(f14_local0, f14_local2["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_game_ended"]], function(f15_arg0)
				f14_arg1:clearLayout()
				f14_arg1:updateDataSource(false, false)
			end)
		end
	end
)
CoD.ZombieUtility.PowerUps = {}
CoD.ZombieUtility.PowerUps.STATE_OFF = 0
CoD.ZombieUtility.PowerUps.STATE_ON = 1
CoD.ZombieUtility.PowerUps.STATE_FLASHING_OFF = 2
CoD.ZombieUtility.PowerUps.STATE_FLASHING_ON = 3
CoD.ZombieUtility.PowerUps.ClientFieldNames = {}
table.insert(CoD.ZombieUtility.PowerUps.ClientFieldNames, {
	clientFieldName = "powerup_instant_kill",
	image = "ui_icon_hud_zb_power_up_insta_kill",
})
table.insert(CoD.ZombieUtility.PowerUps.ClientFieldNames, {
	clientFieldName = "powerup_double_points",
	image = "ui_icon_hud_zb_power_up_double_points",
})
table.insert(CoD.ZombieUtility.PowerUps.ClientFieldNames, {
	clientFieldName = "powerup_fire_sale",
	image = "ui_icon_hud_zb_power_up_firesale",
})
table.insert(CoD.ZombieUtility.PowerUps.ClientFieldNames, {
	clientFieldName = "powerup_zombie_blood",
	image = "ui_icon_hud_zb_escape_blood_power_up",
})
table.insert(CoD.ZombieUtility.PowerUps.ClientFieldNames, {
	clientFieldName = "powerup_bon_fire",
	image = "ui_icon_hud_zb_bonfiresale",
})
DataSources.PowerUps = {
	prepare = function(f16_arg0, f16_arg1, f16_arg2)
		f16_arg1.model = Engine.CreateModel(Engine.GetModelForController(f16_arg0), "hudItems.zmPowerUps")
		if not f16_arg1.eventHandlersRegistered then
			f16_arg1.eventHandlersRegistered = true
			f16_arg1.clientFieldStates = {}
			f16_arg1.models = {}
			f16_arg1.updateSubscriptions = {}
			for f16_local3, f16_local4 in ipairs(CoD.ZombieUtility.PowerUps.ClientFieldNames) do
				local f16_local5 = f16_local4.clientFieldName
				f16_arg1.models[f16_local3] = Engine.CreateModel(f16_arg1.model, f16_local5)
				local f16_local6 = f16_arg1.models[f16_local3]:create("image")
				f16_local6:set(f16_local4.image)
				f16_local6 = f16_arg1.models[f16_local3]:create("state")
				f16_local6:set(CoD.ZombieUtility.PowerUps.STATE_OFF)
				f16_arg1.clientFieldStates[f16_local5] = CoD.ZombieUtility.PowerUps.STATE_OFF
				table.insert(
					f16_arg1.updateSubscriptions,
					f16_arg1:subscribeToModel(f16_arg1.models[f16_local3].state, function(f17_arg0)
						f16_arg1.clientFieldStates[f16_local5] = f17_arg0:get()
						f16_arg1:updateDataSource()
					end, false)
				)
			end
		end
	end,
	getCount = function(f18_arg0)
		local f18_local0 = 0
		for f18_local4, f18_local5 in ipairs(CoD.ZombieUtility.PowerUps.ClientFieldNames) do
			if f18_arg0.clientFieldStates[f18_local5.clientFieldName] ~= CoD.ZombieUtility.PowerUps.STATE_OFF then
				f18_local0 = f18_local0 + 1
			end
		end
		return f18_local0
	end,
	getItem = function(f19_arg0, f19_arg1, f19_arg2)
		local f19_local0 = 0
		for f19_local4, f19_local5 in ipairs(CoD.ZombieUtility.PowerUps.ClientFieldNames) do
			if f19_arg1.clientFieldStates[f19_local5.clientFieldName] ~= CoD.ZombieUtility.PowerUps.STATE_OFF and f19_local0 + 1 == f19_arg2 then
				return f19_arg1.models[f19_local4]
			end
		end
		return nil
	end,
}
CoD.ZombieUtility.OpenZombieLoadout = function(f20_arg0, f20_arg1)
	OpenOverlay(f20_arg1, "ZMLoadoutMain", f20_arg0)
end
CoD.ZombieUtility.TrialsTimerShouldShow = function()
	if Engine.GetGametypeSetting("zmshowtimer") == 1 and CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 0) then
		return true
	else
		return false
	end
end
CoD.ZombieUtility.HideIfIsArcadeMode = function(f22_arg0)
	if Dvar.g_gametype:get() == "zstandard" then
		return 0
	else
		return 1
	end
end
CoD.ZombieUtility.ShowIfIsArcadeMode = function(f23_arg0)
	if Dvar.g_gametype:get() == "zstandard" then
		return 1
	else
		return 0
	end
end
CoD.ZombieUtility.GetSurvivedRoundsText = function(f24_arg0)
	if f24_arg0 == 1 then
		return Engine[@"hash_4F9F1239CFD921FE"]("zombie/survived_round")
	else
		return Engine[@"hash_4F9F1239CFD921FE"]("zombie/survived_rounds", f24_arg0)
	end
end
CoD.ZombieUtility.GetNumDownsText = function(f25_arg0)
	if f25_arg0 == 0 then
		return Engine[@"hash_4F9F1239CFD921FE"](0x5F0B7103756F36)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_643C0E62C6B9C42B", f25_arg0)
	end
end
CoD.ZombieUtility.IsZombieFactionRewardsAvailable = function(f26_arg0)
	if not IsLobbyNetworkModeLAN() then
		local f26_local0, f26_local1, f26_local2 = LuaUtils.GetCurrentFactionDvars()
		local f26_local3 = IsBooleanDvarSet("faction_callings_enabled_zm")
		if f26_local3 then
			if f26_local0 == 0 or f26_local1 == 0 then
				f26_local3 = false
			else
				f26_local3 = true
			end
		end
		return f26_local3
	else
		return false
	end
end
CoD.ZombieUtility.IsZombieCallingsAvailable = function(f27_arg0)
	if not IsLobbyNetworkModeLAN() then
		local f27_local0, f27_local1, f27_local2 = LuaUtils.GetCurrentFactionDvars()
		local f27_local3 = IsBooleanDvarSet("faction_callings_enabled_zm")
		if f27_local3 then
			if f27_local0 ~= 0 and f27_local1 ~= 0 then
				f27_local3 = f27_local2
			else
				f27_local3 = false
			end
		end
		return f27_local3
	else
		return false
	end
end
CoD.ZombieUtility.IsSpeedStatusEffectActive = function(f28_arg0)
	local f28_local0 = DataSources.PlayerAbilities.getModel(f28_arg0)
	f28_local0 = f28_local0.playerGadget2
	if f28_local0 then
		local f28_local1 = f28_local0.id and f28_local0.id:get() or 0x0
		if type(f28_local1) == "string" and (f28_local1 == "hero_chakram_lv2_zm" or f28_local1 == "hero_chakram_lv3_zm") and f28_local0.state then
			return f28_local0.state:get() == Enum[@"weapongadgetstates"][@"player_ability_state_inuse"]
		elseif (f28_local1 == "hero_chakram_lv2_zm" or f28_local1 == "hero_chakram_lv3_zm") and f28_local0.state then
			return f28_local0.state:get() == Enum[@"weapongadgetstates"][@"player_ability_state_inuse"]
		end
	end
	return false
end
CoD.ZombieUtility.IsVigorStatusEffectActive = function(f29_arg0)
	local f29_local0 = DataSources.PlayerAbilities.getModel(f29_arg0)
	f29_local0 = f29_local0.playerGadget2
	if f29_local0 then
		local f29_local1 = f29_local0.id and f29_local0.id:get() or 0x0
		if type(f29_local1) == "string" then
			local f29_local2
			if f29_local1 ~= "hero_scepter_lv2_zm" and f29_local1 ~= "hero_scepter_lv3_zm" then
				f29_local2 = false
			else
				f29_local2 = true
			end
			return f29_local2
		else
			local f29_local2
			if f29_local1 ~= "hero_scepter_lv2_zm" and f29_local1 ~= "hero_scepter_lv3_zm" then
				f29_local2 = false
			else
				f29_local2 = true
			end
		end
		return f29_local2
	else
		return false
	end
end
CoD.ZombieUtility.AddUpdateOrderHandlingForZMRushPlayercards = function(f30_arg0, f30_arg1)
	local f30_local0 = function()
		if f30_arg0.currentState == "HudStart" then
			local f31_local0 = Engine.GetModelForController(f30_arg1)
			f31_local0 = f31_local0:create("Clients.clientCount")
			local f31_local1 = CoD.ZombieUtility.MAX_CLIENTS_ZM - f31_local0:get()
			local f31_local2 = Engine.GetClientNum(f30_arg1)
			for f31_local3 = 0, 3, 1 do
				local f31_local6 = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetGlobalModel(), "scoreboard.team1." .. f31_local3 .. ".clientNum")))
				if f31_local6 > -1 then
					PlayClip(f30_arg0, "Client" .. DataSources.PlayerListZM.clientNumToArrayIndex(f31_local6, f31_local2) .. "Pos" .. f31_local3 + f31_local1, f30_arg1)
				end
			end
		end
	end
	local f30_local1 = function()
		f30_local0()
		if CoD.ModelUtility.IsModelValueGreaterThan(f30_arg1, "gameScore.roundsPlayed", 2) then
			if f30_arg0.orderTimer ~= nil then
				f30_arg0.orderTimer.disposable = true
				f30_arg0.orderTimer.timerEventFunction = nil
				f30_arg0.orderTimer:completeAnimation()
				f30_arg0.orderTimer:close()
				f30_arg0.orderTimer = nil
			end
			f30_arg0.orderTimer = LUI.UITimer.newElementTimer(100, false, f30_local0)
			f30_arg0:addElement(f30_arg0.orderTimer)
		end
	end
	local f30_local2 = f30_arg0
	local f30_local3 = f30_arg0.subscribeToModel
	local f30_local4 = Engine.GetModelForController(f30_arg1)
	f30_local3(f30_local2, f30_local4:create("Clients.clientCount"), f30_local0)
	f30_arg0.orderTimer = nil
	LUI.OverrideFunction_CallOriginalFirst(f30_arg0, "setState", function(element, controller, f33_arg2, f33_arg3, f33_arg4)
		if f33_arg2 ~= "HudStart" then
			if f30_arg0.orderTimer ~= nil then
				f30_arg0.orderTimer.disposable = true
				f30_arg0.orderTimer.timerEventFunction = nil
				f30_arg0.orderTimer:completeAnimation()
				f30_arg0.orderTimer:close()
				f30_arg0.orderTimer = nil
			end
		elseif f30_arg0.orderTimer == nil then
			f30_arg0.orderTimer = LUI.UITimer.newElementTimer(5000, false, f30_local1)
			f30_arg0:addElement(f30_arg0.orderTimer)
			f30_arg0.immediateUpdateOrderDelay = LUI.UITimer.newElementTimer(5, true, f30_local0)
			f30_arg0:addElement(f30_arg0.immediateUpdateOrderDelay)
		end
	end)
end
CoD.ZombieUtility.GetZombiesRushPositionForIndex = function(f34_arg0, f34_arg1)
	local f34_local0 = Engine.GetModelForController(f34_arg0)
	f34_local0 = f34_local0:create("Clients.clientCount")
	return CoD.ZombieUtility.GetStringPositionForIndex(f34_arg1 - CoD.ZombieUtility.MAX_CLIENTS_ZM - f34_local0:get())
end
CoD.ZombieUtility.SetupZMPlayerListModel = function(f35_arg0, f35_arg1)
	local f35_local0 = DataSources.ZMPlayerList.getModel(f35_arg1)
	local f35_local1 = Engine.GetClientNum(f35_arg1)
	for f35_local2 = 0, 3, 1 do
		local f35_local5 = Engine.CreateModel(f35_local0, DataSources.PlayerListZM.clientNumToArrayIndex(f35_local2, f35_local1))
		Engine.SetModelValue(Engine.CreateModel(f35_local5, "zombieInventoryIcon"), "blacktransparent")
		f35_local5:create("playerScore")
		f35_local5:create("playerIsDowned")
		f35_local5:create("zombiePlayerIcon")
		f35_local5:create("multiplier_count")
		f35_local5:create("multiplier_blink")
		local f35_local6 = f35_local5:create("self_revives")
		f35_local6:set(0)
		f35_local5:create("self_revives_direction")
		f35_local5:create("clientModel")
		DataSources.PlayerListZM.subscriptions[f35_arg1]:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "PlayerList.client" .. f35_local2 .. ".playerIsDowned"), function(model)
			Engine.SetModelValue(Engine.CreateModel(f35_local5, "playerIsDowned"), Engine.GetModelValue(model))
		end)
		DataSources.PlayerListZM.subscriptions[f35_arg1]:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "PlayerList.client" .. f35_local2 .. ".multiplier_count"), function(model)
			Engine.SetModelValue(Engine.CreateModel(f35_local5, "multiplier_count"), Engine.GetModelValue(model))
		end)
		DataSources.PlayerListZM.subscriptions[f35_arg1]:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "PlayerList.client" .. f35_local2 .. ".multiplier_blink"), function(model)
			Engine.SetModelValue(Engine.CreateModel(f35_local5, "multiplier_blink"), Engine.GetModelValue(model))
		end)
		DataSources.PlayerListZM.subscriptions[f35_arg1]:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "PlayerList.client" .. f35_local2 .. ".self_revives"), function(model)
			local f39_local0 = Engine.CreateModel(f35_local5, "self_revives")
			local f39_local1 = Engine.GetModelValue(f39_local0)
			local f39_local2 = Engine.GetModelValue(model)
			local f39_local3 = 0
			if f39_local2 < f39_local1 then
				f39_local3 = -1
			elseif f39_local1 < f39_local2 then
				f39_local3 = 1
			end
			Engine.SetModelValue(Engine.CreateModel(f35_local5, "self_revives_direction"), f39_local3)
			Engine.SetModelValue(f39_local0, f39_local2)
		end)
		f35_local6 = Engine.CreateModel(f35_local5, "clientModel")
		f35_local6:set(Engine.GetModel(Engine.GetGlobalModel(), "Clients." .. f35_local2))
	end
end
CoD.ZombieUtility.IsClientnumFromElementEqualToOurs = function(f40_arg0, f40_arg1)
	local f40_local0 = Engine.GetClientNum(f40_arg0)
	local f40_local1 = f40_arg1:getModel()
	if f40_local1 then
		local f40_local2 = Engine.GetModel(f40_local1, "clientNum")
		if f40_local2 then
			return f40_local0 == Engine.GetModelValue(f40_local2)
		end
	end
	return false
end
CoD.ZombieUtility.IsSelfModelValueGreaterThanCachedValue = function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
	local f41_local0 = f41_arg1:getModel()
	if f41_local0 then
		local f41_local1 = Engine.GetModel(f41_local0, f41_arg2)
		if f41_local1 then
			local f41_local2 = Engine.GetModelValue(f41_local1)
			if f41_local2 and f41_arg1[f41_arg3] then
				return f41_arg1[f41_arg3] < f41_local2
			end
		end
	end
	return false
end
CoD.ZombieUtility.AdjustAarAllTimeStatWidgetsWidthToStretchAcrossMapImage = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
	local f42_local0 = #CoD.ZombieUtility.ZMAllTimeSummaryListGenericInfoTableFunc(f42_arg1, nil)
	CoD.ZMAARGenericAllTimeStatWidget.__defaultWidth = (CoD.ZMAARAllTimePerfWidget.__defaultWidth - f42_arg3 - f42_arg2 * (f42_local0 - 1)) / f42_local0
end
CoD.ZombieUtility.AdjustAarStatWidgetsWidthToStretchAcrossMapImage = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
	local f43_local0 = #CoD.ZombieUtility.ZMSummaryListGenericInfoTableFunc(f43_arg1, nil)
	CoD.ZMGenericSummaryStatWidget.__defaultWidth = (CoD.ZMAARAllTimePerfWidget.__defaultWidth - f43_arg3 - f43_arg2 * (f43_local0 - 1)) / f43_local0
end
CoD.ZombieUtility.ReturnScoreifNotArcade = function(f44_arg0)
	if CoD.HUDUtility.IsGameTypeEqualToString("zstandard") then
		return ""
	else
		return f44_arg0
	end
end
CoD.ZombieUtility.SetupZMTeamScoreBinding = function(f45_arg0, f45_arg1)
	local f45_local0 = function(f46_arg0)
		local f46_local0 = 0
		for f46_local1 = 0, 3, 1 do
			local f46_local4 = f45_arg0:getModel(f45_arg1, f46_local1 .. ".playerScore")
			if f46_local4 then
				local f46_local5 = f46_local4:get()
				if f46_local5 ~= nil then
					f46_local0 = f46_local0 + f46_local5
				end
			end
		end
		f45_arg0.Score:setText(f46_local0)
	end
	f45_arg0.Score:linkToElementModel(f45_arg0, "0.playerScore", true, f45_local0)
	f45_arg0.Score:linkToElementModel(f45_arg0, "1.playerScore", true, f45_local0)
	f45_arg0.Score:linkToElementModel(f45_arg0, "2.playerScore", true, f45_local0)
	f45_arg0.Score:linkToElementModel(f45_arg0, "3.playerScore", true, f45_local0)
end
CoD.ZombieUtility.TrialsNoHudPostLoad = function(f47_arg0, f47_arg1, f47_arg2)
	if CoD.HUDUtility.IsAnyGameType(f47_arg1, "ztrials") then
		f47_arg0:mergeStateConditions({
			{
				stateName = "Hidden",
				condition = function(menu, element, event)
					return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
				end,
			},
		})
		local f47_local0 = f47_arg0
		local f47_local1 = f47_arg0.subscribeToModel
		local f47_local2 = Engine.GetGlobalModel()
		f47_local1(f47_local0, f47_local2["ZMHudGlobal.trials.hudDeactivated"], function(f49_arg0)
			f47_arg2:updateElementState(f47_arg0, {
				name = "model_validation",
				menu = f47_arg2,
				controller = f47_arg1,
				modelValue = f49_arg0:get(),
				modelName = "ZMHudGlobal.trials.hudDeactivated",
			})
		end, false)
	end
end
CoD.ZombieUtility.SetZombiePointPickupNotificationAmount = function(f50_arg0, f50_arg1)
	local f50_local0 = CoD.GetScriptNotifyData(f50_arg1)
	f50_arg0.PointAmount:setText(f50_local0[1])
end
CoD.ZombieUtility.OnPlayTrialsRoundSplashNotification = function()
	Engine.SetModelValue(Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.roundSplashPlay"), true)
end
CoD.ZombieUtility.OnFinishTrialsRoundSplashNotification = function()
	Engine.SetModelValue(Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.infoHidden"), false)
	Engine.SetModelValue(Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.roundSplashPlay"), false)
end
CoD.ZombieUtility.AddTrialsRoundSplashNotification = function(f53_arg0, f53_arg1, f53_arg2)
	Engine.SetModelValue(Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.infoHidden"), true)
	f53_arg1:appendNotification({
		clip = "TrialsRoundSplash",
		playCallback = CoD.ZombieUtility.OnPlayTrialsRoundSplashNotification,
		finishCallback = CoD.ZombieUtility.OnFinishTrialsRoundSplashNotification,
	})
end
CoD.ZombieUtility.AddTcmSplashNotification = function(f54_arg0, f54_arg1, f54_arg2)
	f54_arg1:appendNotification({
		clip = "TcmSplash",
	})
end
CoD.ZombieUtility.OnPlayTributeSplash = function(f55_arg0)
	if f55_arg0 then
		local f55_local0 = Engine.GetModelForController(f55_arg0)
		local f55_local1 = f55_local0.zmhud:create("playTributeSplash")
		f55_local1:set(1)
	end
end
CoD.ZombieUtility.OnFinishTributeSplash = function(f56_arg0)
	if f56_arg0 then
		local f56_local0 = Engine.GetModelForController(f56_arg0)
		local f56_local1 = f56_local0.zmhud:create("playTributeSplash")
		f56_local1:set(0)
	end
end
CoD.ZombieUtility.AddTributeSplashNotification = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
	if f57_arg2 and f57_arg2:get() > 0 then
		f57_arg1:appendNotification({
			clip = "TributeSplash",
			playCallback = CoD.ZombieUtility.OnPlayTributeSplash,
			finishCallback = CoD.ZombieUtility.OnFinishTributeSplash,
		})
	end
end
CoD.ZombieUtility.GetPlayerDownColor = function(f58_arg0)
	if f58_arg0 == 1 then
		return ColorSet.ZombiePlayerDown.r, ColorSet.ZombiePlayerDown.g, ColorSet.ZombiePlayerDown.b
	else
		return ColorSet.WaypointNeutral.r, ColorSet.WaypointNeutral.g, ColorSet.WaypointNeutral.b
	end
end
CoD.ZombieUtility.GetTrialsTableForMap = function(f59_arg0, f59_arg1)
	if not f59_arg1 then
		f59_arg1 = Engine.GetGametypeSetting("zmtrialsvariant")
	end
	local f59_local0 = CoD.ZombieUtility.MapToTrialsCSVPrefix[f59_arg0]
	if f59_local0 then
		if f59_arg1 and f59_arg1 > 0 then
			return f59_local0 .. "_trials_variant_" .. f59_arg1 .. ".csv"
		else
			return f59_local0 .. "_trials.csv"
		end
	else
		return nil
	end
end
CoD.ZombieUtility.GetTrialsNameForMap = function(f60_arg0, f60_arg1)
	if not f60_arg1 then
		f60_arg1 = Engine.GetGametypeSetting("zmtrialsvariant")
	end
	if f60_arg1 and f60_arg1 > 0 then
		return f60_arg0 .. "_variant_" .. f60_arg1
	else
		return f60_arg0 .. "_default"
	end
end
CoD.ZombieUtility.TrialsMedalNotification = function(f61_arg0, f61_arg1, f61_arg2)
	local f61_local0 = CoD.ZombieUtility.GetTrialsTableForMap(Engine[@"converttoxhash"](Engine.GetCurrentMapName()))
	local f61_local1 = 7
	local f61_local2 = 8
	local f61_local3 = CoD.GetScriptNotifyData(f61_arg2)
	local f61_local4 = f61_local3[1]
	f61_arg1:playNotification(Engine[@"hash_4C6F8EC444864600"](f61_local0, f61_local4, f61_local1), Engine[@"hash_4C6F8EC444864600"](f61_local0, f61_local4, f61_local2))
end
CoD.ZombieUtility.TrialsCreatePlayerListClientModel = function(f62_arg0, f62_arg1)
	local f62_local0 = Engine.GetGlobalModel()
	local f62_local1 = Engine.GetClientNum(f62_arg1)
	local f62_local2 = Engine[@"getmodelforclient"](f62_local1)
	assert(f62_local2.clientNum:get() == f62_local1)
	local f62_local3 = f62_local0:create("PlayerList.client" .. f62_local1)
	if f62_local3 ~= nil then
		f62_arg0:setModel(f62_local3, f62_arg1)
	end
end
CoD.ZombieUtility.SubscribeForSoloMatchLobbyTitle = function(f63_arg0)
	local f63_local0 = Engine.GetGlobalModel()
	f63_local0 = f63_local0:create("lobbyRoot")
	local f63_local1 = f63_local0:create("lobbyTitle")
	local f63_local2 = f63_local0:create("lobbyList")
	f63_local2 = f63_local2:create("playerCount")
	local f63_local3 = function()
		local f64_local0 = LobbyData.GetCurrentMenuTarget()
		if f64_local0.name == LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE then
			if f63_local2:get() ~= 1 then
				f63_local1:set(f64_local0.title)
			else
				f63_local1:set(@"menu/solo_match")
			end
		end
	end
	f63_arg0:subscribeToModel(f63_local1, f63_local3, true)
	f63_arg0:subscribeToModel(f63_local2, f63_local3, true)
end
CoD.ZombieUtility.GetCounterProgress = function(f65_arg0)
	local f65_local0 = Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.playerCounterMax")
	local f65_local1 = f65_local0:get()
	if f65_arg0 ~= nil and f65_local1 ~= nil then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5B7D5EBBEC599C9A", f65_arg0, f65_local1)
	else
		return ""
	end
end
CoD.ZombieUtility.IsNotTrialsOrTrialsModelAllowed = function(f66_arg0, f66_arg1)
	if not CoD.HUDUtility.IsAnyGameType(f66_arg0, "ztrials") then
		return true
	else
		local f66_local0 = Engine.GetModel(Engine.GetGlobalModel(), f66_arg1)
		if f66_local0:get() ~= true then
			return true
		else
			return false
		end
	end
end
CoD.ZombieUtility.GetGlobalTrialsCounterProgress = function(f67_arg0, f67_arg1, f67_arg2)
	local f67_local0 = Engine.GetModel(f67_arg0, "globalCounterMax")
	if f67_local0 then
		local f67_local1 = f67_local0:get()
		if f67_arg2 ~= nil and f67_local1 ~= nil then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f67_arg2, f67_local1)
		end
	end
	return element:getText() or ""
end
CoD.ZombieUtility.GetStats = function(f68_arg0)
	local f68_local0 = CoD.GetBeforeMatchPlayerStats(f68_arg0)
	local f68_local1 = CoD.GetCurrentPlayerStats(f68_arg0)
	if IsLobbyNetworkModeLAN() then
		f68_local1 = f68_local0
	end
	return f68_local0, f68_local1
end
CoD.ZombieUtility.ShowZMLobbyPoseOptions = function()
	return Engine[@"getdvarbool"]("ui_enableZMLobbyPoseOptions")
end
CoD.ZombieUtility.GetShamedPlayerPortrait = function(f70_arg0, f70_arg1, f70_arg2)
	local f70_local0 = Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.failurePlayer")
	if f70_local0 ~= nil then
		local f70_local1 = Engine.GetModelValue(f70_local0)
		local f70_local2 = {
			0,
			1,
			2,
			3,
		}
		local f70_local3 = 0
		local f70_local4 = nil
		for f70_local8, f70_local9 in ipairs(f70_local2) do
			if CoD.BitUtility.IsBitSet(f70_local1, f70_local9) then
				f70_local3 = f70_local3 + 1
			end
			if f70_arg1 <= f70_local3 then
				f70_local4 = f70_local8 - 1
				break
			end
		end
		if f70_local4 ~= nil then
			f70_local6 = Engine.CreateModel(Engine.GetModelForController(f70_arg0), "PlayerList")
			f70_local7 = 0
			f70_local8 = Engine[@"getmodelforclient"](f70_local4)
			if f70_local8 then
				f70_local9 = f70_local8.xuid:get()
				local f70_local10 = f70_local8.playerName:get()
				if Engine.GetXUID64(f70_arg0) ~= f70_local9 then
					for f70_local11 = 1, Dvar.com_maxclients:get() - 1, 1 do
						if f70_local9 == LuaDefine.INVALID_XUID_X64 then
							if f70_local6[f70_local11].playerName and f70_local6[f70_local11].playerName:get() == f70_local10 then
								f70_local7 = f70_local11
							end
						end
						if f70_local6[f70_local11].xuid and f70_local6[f70_local11].xuid:get() == f70_local9 then
							f70_local7 = f70_local11
						end
					end
				end
				f70_local9 = f70_local6:create(f70_local7)
				local f70_local14 = f70_local9
				f70_local10 = f70_local9.zombiePlayerIcon
				if f70_local10 then
					f70_local10 = f70_local14 and f70_local9.zombiePlayerIcon:get()
				end
				if f70_local10 then
					return f70_local10
				else
					return ""
				end
			else
				return ""
			end
		end
	end
	return ""
end
CoD.ZombieUtility.GetTrialFailurePlayerGamertagByCount = function(f71_arg0, f71_arg1, f71_arg2)
	local f71_local0 = Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.failurePlayer")
	local f71_local1 = nil
	if f71_local0 ~= nil then
		local f71_local2 = Engine.GetModelValue(f71_local0)
		local f71_local3 = {
			0,
			1,
			2,
			3,
		}
		local f71_local4 = 0
		local f71_local5 = nil
		for f71_local9, f71_local10 in ipairs(f71_local3) do
			if CoD.BitUtility.IsBitSet(f71_local2, f71_local10) then
				f71_local4 = f71_local4 + 1
			end
			if f71_arg1 <= f71_local4 then
				f71_local5 = f71_local9 - 1
				break
			end
		end
		if f71_local5 ~= nil then
			f71_local1 = Engine.GetGamertagForClient(f71_arg0, f71_local5)
		else
			if f71_local1 ~= nil then
				return f71_local1
			else
				return ""
			end
		end
	end
	if f71_local1 ~= nil then
		return f71_local1
	else
		return ""
	end
end
CoD.ZombieUtility.FailurePlayerCountMatchesNum = function(f72_arg0, f72_arg1)
	local f72_local0 = Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.failurePlayer")
	local f72_local1 = 0
	if f72_local0 ~= nil then
		local f72_local2 = Engine.GetModelValue(f72_local0)
		for f72_local6, f72_local7 in ipairs({
			0,
			1,
			2,
			3,
		}) do
			if CoD.BitUtility.IsBitSet(f72_local2, f72_local7) then
				f72_local1 = f72_local1 + 1
			end
		end
	end
	return f72_arg1 == f72_local1
end
CoD.ZombieUtility.ShouldShowFailurePlayer = function(f73_arg0)
	local f73_local0 = Engine.GetModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.failurePlayer")
	local f73_local1 = nil
	if f73_local0 ~= nil and CoD.BitUtility.IsAnyBitSet(Engine.GetModelValue(f73_local0), {
		0,
		1,
		2,
		3,
	}) then
		return true
	else
		return false
	end
end
CoD.ZombieUtility.GetStringPositionForIndex = function(f74_arg0)
	if CoD.ZombieUtility.Rush.PositionStrings[f74_arg0] ~= nil then
		return Engine[@"hash_4F9F1239CFD921FE"](CoD.ZombieUtility.Rush.PositionStrings[f74_arg0])
	else
		return ""
	end
end
CoD.ZombieUtility.GetZombieScoreboardColumnRushMultiplierTreatment = function(f75_arg0, f75_arg1)
	if CoD.HUDUtility.IsAnyGameType(f75_arg0, "zstandard") or CoD.isFrontend then
		local f75_local0
		if f75_arg1 then
			f75_local0 = LocalizeIntoStringIfNotEmpty(@"mp/multiplier_x", f75_arg1)
			if not f75_local0 then
			else
				return f75_local0
			end
		end
		f75_local0 = ""
	else
		return f75_arg1
	end
end
CoD.ZombieUtility.GetIsDelayDisableWeaponEqualTo = function(f76_arg0, f76_arg1)
	return CoD.ModelUtility.IsModelValueEqualTo(f76_arg0, "ZMHud.delayDisableWeapon", f76_arg1)
end
CoD.ZombieUtility.SetupTrialsStaggerDisables = function(f77_arg0, f77_arg1)
	local f77_local0 = 750
	local f77_local1 = 750
	local f77_local2 = function(f78_arg0)
		if f78_arg0:get() == true then
			Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableSpecial"), 1)
			Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableEquipment"), 1)
			Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableWeapon"), 1)
		else
			Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableEquipment"), 1)
			Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableWeapon"), 1)
			Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableSpecial"), 2)
			Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.updateDisableWeapon"), 1)
		end
	end
	local f77_local3 = function(f79_arg0)
		if f79_arg0:get() == 2 then
			if CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.disableSpecial", 1) then
				if f77_arg0.delayDisableTimer ~= nil then
					f77_arg0.delayDisableTimer.disposable = true
					f77_arg0.delayDisableTimer.timerEventFunction = nil
					f77_arg0.delayDisableTimer:completeAnimation()
					f77_arg0.delayDisableTimer:close()
					f77_arg0.delayDisableTimer = nil
				end
				f77_arg0.delayDisableTimer = LUI.UITimer.newElementTimer(f77_local0, true, function()
					Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableEquipment"), 2)
				end)
				f77_arg0:addElement(f77_arg0.delayDisableTimer)
			else
				Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableEquipment"), 2)
			end
		end
	end
	local f77_local4 = function(f81_arg0)
		if f81_arg0:get() == 2 then
			if CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.disableEquip", 1) then
				if f77_arg0.delayDisableTimer ~= nil then
					f77_arg0.delayDisableTimer.disposable = true
					f77_arg0.delayDisableTimer.timerEventFunction = nil
					f77_arg0.delayDisableTimer:completeAnimation()
					f77_arg0.delayDisableTimer:close()
					f77_arg0.delayDisableTimer = nil
				end
				f77_arg0.delayDisableTimer = LUI.UITimer.newElementTimer(f77_local0, true, function()
					Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableWeapon"), 2)
				end)
				f77_arg0:addElement(f77_arg0.delayDisableTimer)
			else
				Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableWeapon"), 2)
			end
		end
	end
	local f77_local5 = function(f83_arg0)
		if f83_arg0:get() == 2 then
			if CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.disableGun", 1) then
				Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.updateDisableWeapon"), 2)
			end
			if f77_arg0.delayDisableTimer ~= nil then
				f77_arg0.delayDisableTimer.disposable = true
				f77_arg0.delayDisableTimer.timerEventFunction = nil
				f77_arg0.delayDisableTimer:completeAnimation()
				f77_arg0.delayDisableTimer:close()
				f77_arg0.delayDisableTimer = nil
			end
			f77_arg0.delayDisableTimer = LUI.UITimer.newElementTimer(f77_local1, true, function()
				Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableSpecial"), 0)
				Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableEquipment"), 0)
				Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableWeapon"), 0)
				Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.updateDisableWeapon"), 0)
			end)
			f77_arg0:addElement(f77_arg0.delayDisableTimer)
		end
	end
	Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.updateDisableWeapon"), 0)
	f77_arg0:subscribeToModel(Engine.CreateModel(Engine.GetGlobalModel(), "ZMHudGlobal.trials.infoHidden"), f77_local2)
	f77_arg0:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableSpecial"), f77_local3)
	f77_arg0:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableEquipment"), f77_local4)
	f77_arg0:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(f77_arg1), "ZMHud.delayDisableWeapon"), f77_local5)
end
CoD.ZombieUtility.GetTrialsGameOverText = function(f85_arg0)
	if f85_arg0 == CoD.ZombieUtility.TrialsGameStates.STATE_GAME_OVER_SUCCESS then
		return LocalizeToUpperString("zmtrials/trial_completed")
	else
		return Engine[@"hash_4F9F1239CFD921FE"]("zombie/game_over")
	end
end
CoD.ZombieUtility.GetTrialsCompletetionTime = function(f86_arg0, f86_arg1)
	if f86_arg1 == 1 then
		local f86_local0, f86_local1 = CoD.ZombieUtility.GetStats(f86_arg0)
		assert(f86_local1 ~= nil)
		local f86_local2 = @"hash_336A23C0EE93A18"
		local f86_local3 = Engine[@"converttoxhash"](Engine[@"hash_36F8027A8BC75673"]())
		local f86_local4 = Engine[@"converttoxhash"](Engine[@"lobbygetmap"]())
		assert(f86_local3 ~= nil)
		assert(f86_local4 ~= nil)
		local f86_local5 = f86_local1.AfterActionReportStats.gameLength:get()
		if f86_local0 then
			f86_local0 = f86_local0.PlayerStatsByMap[f86_local4].statsByGameType[f86_local3].stats
			local f86_local6 = nil
			if f86_local0 ~= nil and CoD.isOnlineGame() then
				f86_local6 = f86_local0.FASTEST_TIME_TO_COMPLETE_ROUND_30.StatValue:get()
				if f86_local6 and (not (f86_local6 ~= 0 or f86_local5 == 0) or f86_local6 ~= 0 and f86_local5 ~= 0 and f86_local5 < f86_local6) then
					f86_local2 = 0x1F78DD6B35E3B
				end
			end
		end
		if not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", CoD.ZombieUtility.TrialsGameStates.STATE_GAME_OVER_SUCCESS) then
			f86_local2 = @"hash_34A2384F7FC9C5E9"
		end
		local f86_local6 = function(f87_arg0)
			if f87_arg0 == nil then
				return 0
			else
				return math.floor(f87_arg0 / 1000)
			end
		end
		return Engine[@"hash_4F9F1239CFD921FE"](f86_local2, CoD.AARUtility.SecondsToHoursMinutesSecondsString(f86_local6(f86_local5)))
	else
		return ""
	end
end
CoD.ZombieUtility.FormatNumbersWithDelimetersIfGametype = function(f88_arg0, f88_arg1, f88_arg2)
	if CoD.HUDUtility.IsAnyGameType(f88_arg0, f88_arg1) then
		return CoD.TextUtility.FormatNumberWithDelimiters(f88_arg2)
	else
		return f88_arg2
	end
end
CoD.ZombieUtility.ZMPlaylistTabs = {
	BEGIN = 1,
	FEATURED = 1,
	PUBLIC = 2,
	ZCLASSIC = 3,
	ZSTANDARD = 4,
	TCM = 5,
	ZTRIALS = 6,
	ZTUTORIAL = 7,
	COUNT = 7,
}
CoD.ZombieUtility.GameTypeAllowsBots = function()
	local f89_local0 = Engine.GetGlobalModel()
	f89_local0 = f89_local0:create("MapVote.mapVoteGameModeNext")
	return f89_local0 and f89_local0:get() == "zclassic"
end
CoD.ZombieUtility.IsZMLoadoutPreviewWidgetShown = function(f90_arg0)
	local f90_local0 = DataSources.DirectorZMLoadoutPreview.getModel(f90_arg0)
	local f90_local1
	if f90_local0 ~= nil then
		f90_local1 = f90_local0.ZMLoadoutPreviewWidgetShown:get()
	else
		f90_local1 = false
	end
	return f90_local1
end
CoD.ZombieUtility.GetLocalZMLobbyTitle = function(f91_arg0)
	if IsZombies() and IsLobbyNetworkModeLAN() and IsLobbyHostOfCurrentMenu() and CoD.ZombieUtility.IsZMOfflineScreenStateCustomGame() then
		return @"hash_7E61C8890948FD72"
	else
		return f91_arg0
	end
end
CoD.ZombieUtility.GetLocalZMDifficultyImage = function(f92_arg0)
	if IsLobbyNetworkModeLAN() and f92_arg0 == "zclassic" and not CoD.ZombieUtility.IsZMOfflineScreenStateCustomGame() then
		local f92_local0 = {
			"ui_icon_difficulty_zm_casual_large",
			"ui_icon_difficulty_zm_normal_large",
			"ui_icon_difficulty_zm_hardcore_large",
			"ui_icon_difficulty_zm_realistic_large",
		}
		local f92_local1 = Engine.GetGlobalModel()
		f92_local1 = f92_local1:create("localZMDifficulty")
		return f92_local0[(f92_local1:get() or 1) + 1]
	else
		return "blacktransparent"
	end
end
CoD.ZombieUtility.MapNameToZMOfflineLocalizedMapName = function(f93_arg0)
	if IsLobbyNetworkModeLAN() then
		local f93_local0 = Engine.GetGlobalModel()
		f93_local0 = f93_local0:create("MapVote.mapVoteGameModeNext")
		f93_local0 = f93_local0:get()
		if f93_local0 == "ztutorial" then
			local f93_local1 = Engine.GetGlobalModel()
			f93_local1 = f93_local1:create("localZMDifficulty")
			f93_local1 = f93_local1:get() or 1
			local f93_local2 = {
				@"hash_364122F25F791280",
				@"hash_C9580DAB628ED90",
			}
			return Engine[@"hash_4F9F1239CFD921FE"](f93_local2[f93_local1 + 1]) or ""
		elseif f93_local0 == "ztrials" then
			local f93_local1 = Engine.GetGlobalModel()
			f93_local1 = f93_local1:create("localZMTrialVariant")
			return LocalizeToUpperString(CoD.MapUtility.GetMapValue(f93_arg0, CoD.ZombieUtility.GetTrialMapNameFieldName(f93_local1:get()), 0x0))
		end
	end
	return CoD.MapUtility.MapNameToLocalizedToUpperName(f93_arg0)
end
CoD.ZombieUtility.SetDefaultGameTypeZMDifficulty = function(f94_arg0)
	if f94_arg0 and f94_arg0 ~= "zclassic" then
		local f94_local0 = 1
		if f94_arg0 == "ztutorial" then
			f94_local0 = 0
		end
		Engine.SetGametypeSetting("zmDifficulty", f94_local0)
		CoD.ZombieUtility.SetLocalZMDifficultyModel(f94_local0)
		local f94_local1 = Engine[@"lobbygetcontrollinglobbysession"](Enum.LobbyModule[@"lobby_module_host"])
		Engine[@"lobbyevent"]("OnGametypeSettingsChange", {
			lobbyModule = Enum.LobbyModule[@"lobby_module_host"],
			lobbyType = f94_local1,
			fromUI = true,
		})
		Engine[@"lobbyhostsessionsetdirty"](f94_local1, Enum.SessionDirty[@"session_dirty_state"])
	end
end
CoD.ZombieUtility.HideZMLoadoutPreview = function(f95_arg0)
	local f95_local0 = DataSources.DirectorZMLoadoutPreview.getModel(f95_arg0)
	f95_local0.ZMLoadoutPreviewWidgetPrivate:set("CoD.NOTHING")
	f95_local0.ZMLoadoutPreviewWidgetPublic:set("CoD.NOTHING")
	f95_local0.ZMLoadoutPreviewWidgetCustom:set("CoD.NOTHING")
	f95_local0.ZMLoadoutPreviewWidgetShown:set(false)
	f95_local0.ZMLoadoutPreviewInfoShown:set(false)
	f95_local0.ZMLoadoutPreviewItemName:set("")
	f95_local0.ZMLoadoutPreviewItemDesc:set(0x0)
	f95_local0.ZMLoadoutPreviewItemImage:set(0x0)
end
CoD.ZombieUtility.SetPlaylistTab = function(f96_arg0, f96_arg1)
	local f96_local0 = Engine.GetGlobalModel()
	f96_local0 = f96_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	if f96_arg0 == CoD.ZombieUtility.ZMPlaylistTabs.FEATURED or f96_arg0 == CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
		f96_local0:set(f96_arg0)
	elseif f96_arg0 == CoD.ZombieUtility.ZMPlaylistTabs.ZCLASSIC or f96_arg0 == CoD.ZombieUtility.ZMPlaylistTabs.ZSTANDARD or f96_arg0 == CoD.ZombieUtility.ZMPlaylistTabs.ZTRIALS or f96_arg0 == CoD.ZombieUtility.ZMPlaylistTabs.ZTUTORIAL or f96_arg0 == CoD.ZombieUtility.ZMPlaylistTabs.TCM then
		f96_local0:set(f96_arg1)
	end
end
CoD.ZombieUtility.GetDifficultyText = function(f97_arg0)
	local f97_local0 = {
		@"hash_2ED79943A5C831E7",
		@"hash_ECB7319B79FAA96",
		@"hash_667807E571813E78",
		@"hash_392095A74A04187F",
	}
	return f97_local0[f97_local0 + 1]
end
CoD.ZombieUtility.GetGroupedGameType = function(f98_arg0, f98_arg1)
	local f98_local0 = Engine[@"hash_1F2CD89B3C345FD3"](f98_arg0)
	if f98_arg1 ~= nil and f98_arg1 ~= "ztcm" then
		return f98_local0.gametype
	else
		local f98_local1 = Engine[@"hash_48D4B2F88BB8D5E7"](f98_local0.gametype)
		return Engine[@"converttoxhash"](f98_local1.groupName)
	end
end
CoD.ZombieUtility.GetGametypeTabName = function(f99_arg0)
	for f99_local3, f99_local4 in pairs(Engine.GetGametypesBase()) do
		if f99_local4.gametype == f99_arg0 then
			return f99_local4.name
		end
	end
	return 0x0
end
CoD.ZombieUtility.ZMOfflineScreenState = {
	PRIVATE = 0,
	CUSTOM_GAME = 1,
}
CoD.ZombieUtility.ZMOfflineNavigateToCustomGames = function(f100_arg0)
	CoD.ZombieUtility.SetZMOfflineScreenStateToCustomGame(f100_arg0)
end
CoD.ZombieUtility.IsZMOfflineScreenStateCustomGame = function()
	local f101_local0 = CoD.ZombieUtility.InitZMOfflineScreenState()
	return f101_local0:get() == CoD.ZombieUtility.ZMOfflineScreenState.CUSTOM_GAME
end
CoD.ZombieUtility.SetZMOfflineScreenStateToPrivate = function(f102_arg0)
	CoD.LobbyUtility.RemoveAllLobbyBots(f102_arg0)
	Engine.ResetGametypeSettings()
	local f102_local0 = CoD.DirectorUtility.CreateOfflineScreenState()
	f102_local0:set(CoD.ZombieUtility.ZMOfflineScreenState.PRIVATE)
end
CoD.ZombieUtility.SetZMOfflineScreenStateToCustomGame = function(f103_arg0)
	Engine.ResetGametypeSettings()
	local f103_local0 = Engine.GetGlobalModel()
	f103_local0 = f103_local0:create("lobbyRoot.selectedGameType")
	f103_local0 = f103_local0:get()
	local f103_local1 = false
	local f103_local2 = {}
	for f103_local6, f103_local7 in pairs(CoD.GameTypeUtility.GameTypeTable) do
		if f103_local7.groupName == "zclassic" then
			table.insert(f103_local2, f103_local7.name)
			if f103_local0 == Engine[@"converttoxhash"](f103_local7.name) then
				f103_local1 = true
				break
			end
		end
	end
	if not f103_local1 and #f103_local2 > 0 then
		SetGameType(f103_arg0, f103_local2[1])
	end
	f103_local3 = CoD.DirectorUtility.CreateOfflineScreenState()
	f103_local3:set(CoD.ZombieUtility.ZMOfflineScreenState.CUSTOM_GAME)
end
CoD.ZombieUtility.InitZMOfflineScreenState = function()
	local f104_local0 = CoD.DirectorUtility.CreateOfflineScreenState()
	if not f104_local0:get() then
		f104_local0:set(CoD.ZombieUtility.ZMOfflineScreenState.PRIVATE)
	end
	return f104_local0
end
CoD.ZombieUtility.ArrayContains = function(f105_arg0, f105_arg1)
	for f105_local0 = 1, #f105_arg0, 1 do
		if f105_arg0[f105_local0] == f105_arg1 then
			return true
		end
	end
	return false
end
CoD.ZombieUtility.GetTrialRoundGridInfo = function(f106_arg0, f106_arg1, f106_arg2)
	local f106_local0 = {}
	local f106_local1 = CoD.ZombieUtility.GetTrialsTableForMap(f106_arg0, f106_arg2)
	if f106_local1 ~= nil then
		local f106_local2 = 1
		local f106_local3 = 2
		local f106_local4 = 3
		local f106_local5 = {}
		local f106_local6 = Engine.GetTableRowCount(f106_local1)
		local f106_local7 = -1
		local f106_local8 = CoD.ZombieUtility.GetTrialsNameForMap(f106_arg0, f106_arg2)
		for f106_local9 = 0, f106_local6, 1 do
			if Engine[@"hash_4C6F8EC444864600"](f106_local1, f106_local9, f106_local2) == f106_local8 then
				f106_local7 = 0
			elseif f106_local7 >= 0 then
				local f106_local12 = Engine[@"hash_4C6F8EC444864600"](f106_local1, f106_local9, f106_local3)
				local f106_local13 = Engine[@"hash_4C6F8EC444864600"](f106_local1, f106_local9, f106_local4)
				if f106_local12 and f106_local13 and f106_local12 ~= f106_local13 then
					f106_local7 = f106_local7 + 1
					local f106_local14 = table.insert
					local f106_local15 = f106_local5
					local f106_local16 = {
						trialIndex = f106_local7,
						numText = string.format("%02d", f106_local7),
						descText = Engine[@"hash_4F9F1239CFD921FE"](f106_local13),
						titleText = Engine[@"hash_4F9F1239CFD921FE"](f106_local12),
					}
					local f106_local17
					if not f106_arg1 or f106_local7 > f106_arg1 then
						f106_local17 = false
					else
						f106_local17 = true
					end
					f106_local16.shown = f106_local17
					f106_local14(f106_local15, f106_local16)
				end
			end
			if f106_local7 == 30 then
				break
			end
		end
		if f106_local7 == 30 then
			local f106_local9 = 3
			local f106_local10 = 10
			for f106_local11 = 1, f106_local10, 1 do
				for f106_local13 = 1, f106_local9, 1 do
					local f106_local17 = f106_local5[f106_local11 + (f106_local13 - 1) * f106_local10]
					table.insert(f106_local0, {
						models = {
							trialIndex = f106_local17.trialIndex,
							numText = f106_local17.numText,
							descText = f106_local17.descText,
							titleText = f106_local17.titleText,
							shown = f106_local17.shown,
							lastInColumn = f106_local11 == f106_local10,
						},
					})
				end
			end
		else
			return f106_local0
		end
	end
	return f106_local0
end
CoD.ZombieUtility.GetZMPlaylistDifficulty = function(f107_arg0)
	for f107_local0 = 1, #f107_arg0.rules, 1 do
		local f107_local3 = f107_arg0.rules[f107_local0]
		if f107_local3.type == 0 and f107_local3.name == "zmdifficulty" then
			return tonumber(f107_local3.value)
		end
	end
	return 1
end
CoD.ZombieUtility.GetEquivalentPublicPlaylist = function(f108_arg0, f108_arg1)
	local f108_local0 = Engine[@"getplaylistinfobyid"](f108_arg1)
	if f108_local0.excludePublicLobby then
		local f108_local1 = LobbyData.GetCurrentMenuTarget()
		local f108_local2 = CoD.DirectorUtility.GetPlaylists()
		for f108_local3 = 1, #f108_local2, 1 do
			local f108_local6 = f108_local2[f108_local3]
			if f108_local6.hidden ~= true then
				local f108_local7 = LuaUtils.GetEModeForLobbyMainMode(f108_local6.lobbyMainMode)
				if (f108_local7 == nil or CoD.DirectorUtility.IsSessionModeAvailable(f108_arg0, f108_local7)) and f108_local1[@"mainmode"] == f108_local6.lobbyMainMode then
					local f108_local8 = f108_local6.entries
					for f108_local9 = 1, #f108_local8, 1 do
						local f108_local12 = f108_local8[f108_local9]
						if not f108_local12.excludePublicLobby and #f108_local12.rotationList == 1 and f108_local12.rotationList[1].map == f108_local0.rotationList[1].map and f108_local12.rotationList[1].gametype == f108_local0.rotationList[1].gametype and CoD.ZombieUtility.GetZMPlaylistDifficulty(f108_local12) == CoD.ZombieUtility.GetZMPlaylistDifficulty(f108_local0) then
							return f108_local12.id
						end
					end
				end
			end
		end
	end
	return nil
end
CoD.ZombieUtility.GetEquivalentPrivatePlaylist = function(f109_arg0, f109_arg1)
	local f109_local0 = Engine[@"getplaylistinfobyid"](f109_arg1)
	if not f109_local0.excludePublicLobby then
		local f109_local1 = LobbyData.GetCurrentMenuTarget()
		local f109_local2 = CoD.DirectorUtility.GetPlaylists()
		for f109_local3 = 1, #f109_local2, 1 do
			local f109_local6 = f109_local2[f109_local3]
			if f109_local6.hidden ~= true then
				local f109_local7 = LuaUtils.GetEModeForLobbyMainMode(f109_local6.lobbyMainMode)
				if (f109_local7 == nil or CoD.DirectorUtility.IsSessionModeAvailable(f109_arg0, f109_local7)) and f109_local1[@"mainmode"] == f109_local6.lobbyMainMode then
					local f109_local8 = f109_local6.entries
					for f109_local9 = 1, #f109_local8, 1 do
						local f109_local12 = f109_local8[f109_local9]
						if f109_local12.excludePublicLobby and #f109_local12.rotationList == 1 and f109_local12.rotationList[1].map == f109_local0.rotationList[1].map and f109_local12.rotationList[1].gametype == f109_local0.rotationList[1].gametype and CoD.ZombieUtility.GetZMPlaylistDifficulty(f109_local12) == CoD.ZombieUtility.GetZMPlaylistDifficulty(f109_local0) then
							return f109_local12.id
						end
					end
				end
			end
		end
	end
	return nil
end
CoD.ZombieUtility.UpdateFocusedZMOfflineInfo = function(f110_arg0, f110_arg1)
	local f110_local0 = CoD.SafeGetModelValue(f110_arg1:getModel(), "id")
	local f110_local1 = Engine.GetGlobalModel()
	f110_local1 = f110_local1:create("lobbyRoot.selectedGameType")
	f110_local1 = f110_local1:get()
	local f110_local2 = CoD.SafeGetModelValue(f110_arg1:getModel(), "difficulty")
	if f110_local0 and f110_local1 and f110_local2 then
		CoD.ZombieUtility.UpdateZMOfflineInfo(f110_arg0, f110_local0, f110_local1, f110_local2, f110_arg1)
	end
end
CoD.ZombieUtility.UpdateZMOfflineInfo = function(f111_arg0, f111_arg1, f111_arg2, f111_arg3, f111_arg4)
	local f111_local0 = DataSources.DirectorZMPlaylistInfo.getModel(f111_arg0)
	f111_local0.name:set(CoD.MapUtility.GetMapValue(f111_arg1, "mapName", 0x0))
	if f111_arg2 == "ztrials" then
		f111_local0.name:set(CoD.MapUtility.GetMapValue(f111_arg1, CoD.ZombieUtility.GetTrialMapNameFieldName(CoD.SafeGetModelValue(f111_arg4:getModel(), "trialVariant")), 0x0))
	end
	f111_local0.image:set(CoD.MapUtility.GetMapValue(f111_arg1, "previewImage", 0x0))
	local f111_local1 = Engine[@"hash_48D4B2F88BB8D5E7"](f111_arg2)
	local f111_local2 = Engine[@"converttoxhash"](f111_local1.groupName)
	local f111_local3 = 0x0
	if f111_arg2 == "zclassic" then
		f111_local3 = @"hash_F44B71F613A7D65"
	elseif f111_arg2 == "zstandard" then
		f111_local3 = @"hash_159DF0D7D85936E1"
	elseif f111_local2 == "ztcm" then
		f111_local3 = @"hash_1F8845568A0DA5AD"
	elseif f111_arg2 == "ztrials" then
		f111_local3 = @"hash_65A74962FD2F07DE"
	elseif f111_arg2 == "ztutorial" then
		f111_local3 = @"hash_752D3B2A3C8DB965"
		local f111_local4 = {
			@"hash_364122F25F791280",
			@"hash_C9580DAB628ED90",
		}
		f111_local0.name:set(f111_local4[f111_arg3 + 1])
	end
	f111_local0.tabDesc:set(f111_local3)
	local f111_local4 = Engine[@"hash_4F9F1239CFD921FE"](CoD.MapUtility.GetMapValue(f111_arg1, "mapDescription", 0x0))
	if f111_arg2 == "ztutorial" then
		if f111_arg3 == 0 then
			f111_local4 = Engine[@"hash_4F9F1239CFD921FE"]("zmui/ztutorial_desc")
		elseif f111_arg3 == 1 then
			f111_local4 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_9A181BE33C22198")
		end
	end
	f111_local0.desc:set(f111_local4)
	local f111_local5 = CoD.MapUtility.GetMapValue(f111_arg1, "storyloadouttype", 0)
	local f111_local6 = 0x0
	if f111_arg2 ~= "ztutorial" then
		if f111_local5 == 0 then
			f111_local6 = @"hash_66D26560889B0C05"
		elseif f111_local5 == 1 then
			f111_local6 = @"hash_3AAA6B748B1B361A"
		end
	end
	f111_local0.storyDesc:set(f111_local6)
	f111_local0.lockState:set(Enum[@"playlistlockstate"][@"pls_unlocked"])
end
CoD.ZombieUtility.UpdateZMPlaylistInfo = function(f112_arg0, f112_arg1, f112_arg2, f112_arg3)
	local f112_local0 = Engine[@"getplaylistinfobyid"](f112_arg1)
	local f112_local1 = Engine.GetGlobalModel()
	f112_local1 = f112_local1:create("DirectorZMPlaylistInfo")
	local f112_local2 = CoD.GetPlayerStats(f112_arg0)
	if f112_local2 == nil then
		return
	end
	local f112_local3 = f112_local0.rotationList[1].map
	local f112_local4 = Engine[@"hash_1F2CD89B3C345FD3"](f112_local0.rotationList[1].gametype)
	local f112_local5 = f112_local4.gametype
	local f112_local6 = function(f113_arg0)
		local f113_local0 = math.floor(f113_arg0 / 1000)
		local f113_local1 = math.floor(f113_local0 / 3600)
		f113_local0 = f113_local0 - f113_local1 * 3600
		local f113_local2 = math.floor(f113_local0 / 60)
		f113_local0 = f113_local0 - f113_local2 * 60
		if f113_local1 ~= 0 and f113_local1 < 10 then
			f113_local1 = "0" .. f113_local1
		end
		if f113_local2 < 10 then
			f113_local2 = "0" .. f113_local2
		end
		if f113_local0 < 10 then
			f113_local0 = "0" .. f113_local0
		end
		if f113_local1 == 0 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5DA15869CF160D19", f113_local2, f113_local0)
		else
			return Engine[@"hash_4F9F1239CFD921FE"](0x7967DE7F4AADC1, f113_local1, f113_local2, f113_local0)
		end
	end
	local f112_local7 = function()
		if f112_local0.isQuickplayCard then
			return 0x0
		end
		local f114_local0 = nil
		for f114_local4, f114_local5 in ipairs(f112_local0.rotationList) do
			local f114_local6 = CoD.MapUtility.GetMapValue(f114_local5.map, "storyloadouttype", 0)
			if f114_local0 ~= nil and f114_local0 ~= f114_local6 then
				return 0x0
			end
			f114_local0 = f114_local6
		end
		if f114_local0 ~= nil then
			if f114_local0 == 0 then
				return @"hash_66D26560889B0C05"
			elseif f114_local0 == 1 then
				return @"hash_3AAA6B748B1B361A"
			end
		end
		return 0x0
	end
	if f112_arg2 == CoD.ZombieUtility.ZMPlaylistTabs.FEATURED or f112_arg2 == CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
		f112_local1.name:set(f112_local0.name)
		f112_local1.image:set(f112_local0.imageTileSideInfo or "blacktransparent")
		f112_local1.tabDesc:set(0x0)
		f112_local1.desc:set(Engine[@"hash_632A860841DBD025"](f112_arg0, f112_arg1, Enum.eModes.mode_zombies))
		f112_local1.storyDesc:set(f112_local7())
		f112_local1.lockState:set(f112_local0.lockState)
	elseif f112_arg2 == "zclassic" then
		f112_local1.name:set(CoD.MapUtility.GetMapValue(f112_local3, "mapName", 0x0))
		f112_local1.image:set(f112_local0.imageTileSideInfo or "blacktransparent")
		f112_local1.tabDesc:set(@"hash_F44B71F613A7D65")
		f112_local1.desc:set(MapNameToLocalizedMapDescription(f112_local3))
		f112_local1.storyDesc:set(f112_local7())
		f112_local1.lockState:set(f112_local0.lockState)
		if f112_local2.PlayerStatsByMap[f112_local3] then
			local f112_local8 = f112_local2.PlayerStatsByMap[f112_local3].statsByGameType[f112_local5].statsByDifficulty[f112_arg3].stats
			f112_local1.statInt1:set(f112_local8.MOST_KILLS.statValue:get())
			f112_local1.statInt2:set(f112_local8.MOST_HEADSHOTS.statValue:get())
			f112_local1.statInt3:set(f112_local8.HIGHEST_ROUND_REACHED.statValue:get())
			f112_local1.statInt4:set(f112_local8.MAIN_QUEST_COMPLETED.statValue:get())
			local f112_local9 = f112_local8.FASTEST_QUEST_COMPLETION_TIME.statValue:get()
			if f112_local9 == 0 then
				f112_local1.statTimeString1:set(Engine.ToUpper(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2791826DA0652E1A")))
			else
				f112_local1.statTimeString1:set(f112_local6(f112_local9))
			end
		end
	elseif f112_arg2 == "zstandard" then
		f112_local1.name:set(CoD.MapUtility.GetMapValue(f112_local3, "mapName", 0x0))
		f112_local1.image:set(f112_local0.imageTileSideInfo or "blacktransparent")
		f112_local1.tabDesc:set(@"hash_159DF0D7D85936E1")
		f112_local1.desc:set(MapNameToLocalizedMapDescription(f112_local3))
		f112_local1.storyDesc:set(f112_local7())
		f112_local1.lockState:set(f112_local0.lockState)
		if f112_local2.PlayerStatsByMap[f112_local3] then
			local f112_local8 = f112_local2.PlayerStatsByMap[f112_local3].statsByGameType[f112_local5].stats
			f112_local1.statInt1:set(f112_local8.KILLS.statValue:get())
			f112_local1.statInt2:set(f112_local8.HEADSHOTS.statValue:get())
			f112_local1.statInt3:set(f112_local8.HIGHEST_SCORE.statValue:get())
			f112_local1.statInt4:set(f112_local8.HIGHEST_TEAM_SCORE.statValue:get())
		end
	elseif f112_arg2 == "ztcm" then
		f112_local1.name:set(CoD.MapUtility.GetMapValue(f112_local3, "mapName", 0x0))
		f112_local1.image:set(f112_local0.imageTileSideInfo or "blacktransparent")
		f112_local1.tabDesc:set(@"hash_1F8845568A0DA5AD")
		f112_local1.desc:set(MapNameToLocalizedMapDescription(f112_local3))
		f112_local1.storyDesc:set(f112_local7())
		f112_local1.lockState:set(f112_local0.lockState)
		if f112_local2.PlayerStatsByMap[f112_local3] then
			local f112_local8 = f112_local2.PlayerStatsByMap[f112_local3].statsByGameType[f112_local5].stats
			f112_local1.statInt1:set(f112_local8.KILLS.statValue:get())
			f112_local1.statInt2:set(f112_local8.HEADSHOTS.statValue:get())
			f112_local1.statInt3:set(f112_local8.HIGHEST_ROUND_REACHED.statValue:get())
		end
	elseif f112_arg2 == "ztrials" then
		f112_local1.name:set(CoD.MapUtility.GetMapValue(f112_local3, CoD.ZombieUtility.GetTrialMapNameFieldName(CoD.ZombieUtility.GetZMPlaylistTrialVariant(f112_local0)), 0x0))
		f112_local1.image:set(f112_local0.imageTileSideInfo or "blacktransparent")
		f112_local1.tabDesc:set(@"hash_65A74962FD2F07DE")
		f112_local1.desc:set(MapNameToLocalizedMapDescription(f112_local3))
		f112_local1.storyDesc:set(f112_local7())
		f112_local1.lockState:set(f112_local0.lockState)
		local f112_local9 = CoD.ZombieUtility.GetZMPlaylistTrialName(f112_local0)
		if f112_local2.PlayerStatsByTrial[f112_local9] then
			local f112_local10 = f112_local2.PlayerStatsByTrial[f112_local9]
			f112_local1.statInt1:set(f112_local10.kills:get())
			f112_local1.statInt2:set(f112_local10.headshots:get())
			f112_local1.statInt3:set(f112_local10.highest_round_reached:get())
			local f112_local11 = f112_local10.fastest_time_to_round_10:get()
			if f112_local11 == 0 then
				f112_local1.statTimeString1:set(Engine.ToUpper(Engine[@"hash_4F9F1239CFD921FE"]("zmtrials/incomplete")))
				f112_local1.bronzeComplete:set(false)
			else
				f112_local1.statTimeString1:set(f112_local6(f112_local11))
				f112_local1.bronzeComplete:set(true)
			end
			local f112_local12 = f112_local10.fastest_time_to_round_20:get()
			if f112_local12 == 0 then
				f112_local1.statTimeString2:set(Engine.ToUpper(Engine[@"hash_4F9F1239CFD921FE"]("zmtrials/incomplete")))
				f112_local1.silverComplete:set(false)
			else
				f112_local1.statTimeString2:set(f112_local6(f112_local12))
				f112_local1.silverComplete:set(true)
			end
			local f112_local13 = f112_local10.fastest_time_to_complete_round_30:get()
			if f112_local13 == 0 then
				f112_local1.statTimeString3:set(Engine.ToUpper(Engine[@"hash_4F9F1239CFD921FE"]("zmtrials/incomplete")))
				f112_local1.goldComplete:set(false)
			else
				f112_local1.statTimeString3:set(f112_local6(f112_local13))
				f112_local1.goldComplete:set(true)
			end
		end
	elseif f112_arg2 == "ztutorial" then
		f112_local1.name:set(f112_local0.name)
		f112_local1.image:set(f112_local0.imageTileSideInfo or "blacktransparent")
		f112_local1.tabDesc:set(@"hash_752D3B2A3C8DB965")
		f112_local1.desc:set(Engine[@"hash_632A860841DBD025"](f112_arg0, f112_arg1, Enum.eModes.mode_zombies))
		f112_local1.storyDesc:set(0x0)
	end
end
CoD.ZombieUtility.GetQuickPlayPlaylistID = function(f115_arg0)
	local f115_local0 = LobbyData.GetCurrentMenuTarget()
	local f115_local1 = CoD.DirectorUtility.GetPlaylists()
	for f115_local2 = 1, #f115_local1, 1 do
		local f115_local5 = f115_local1[f115_local2]
		if f115_local5.hidden ~= true then
			local f115_local6 = LuaUtils.GetEModeForLobbyMainMode(f115_local5.lobbyMainMode)
			if (f115_local6 == nil or CoD.DirectorUtility.IsSessionModeAvailable(f115_arg0, f115_local6)) and f115_local0[@"mainmode"] == f115_local5.lobbyMainMode then
				local f115_local7 = f115_local5.entries
				for f115_local8 = 1, #f115_local7, 1 do
					local f115_local11 = f115_local7[f115_local8]
					if f115_local11.rotationList and #f115_local11.rotationList == 1 then
						local f115_local12 = Engine[@"hash_1F2CD89B3C345FD3"](f115_local11.rotationList[1].gametype)
						if f115_local12.gametype == "ztutorial" and CoD.ZombieUtility.GetZMPlaylistDifficulty(f115_local11) == 0 then
							return f115_local11.id
						end
					end
				end
			end
		end
	end
	return -1
end
DataSourceHelpers.GlobalDataSourceSetup("DirectorZMPlaylistInfo", "DirectorZMPlaylistInfo", function(f116_arg0)
	local f116_local0 = f116_arg0:create("name")
	f116_local0:set(0x0)
	f116_local0 = f116_arg0:create("image")
	f116_local0:set(0x0)
	f116_local0 = f116_arg0:create("tabDesc")
	f116_local0:set(0x0)
	f116_local0 = f116_arg0:create("desc")
	f116_local0:set("")
	f116_local0 = f116_arg0:create("storyDesc")
	f116_local0:set(0x0)
	f116_local0 = f116_arg0:create("statInt1")
	f116_local0:set(0)
	f116_local0 = f116_arg0:create("statInt2")
	f116_local0:set(0)
	f116_local0 = f116_arg0:create("statInt3")
	f116_local0:set(0)
	f116_local0 = f116_arg0:create("statInt4")
	f116_local0:set(0)
	f116_local0 = f116_arg0:create("statTimeString1")
	f116_local0:set("")
	f116_local0 = f116_arg0:create("statTimeString2")
	f116_local0:set("")
	f116_local0 = f116_arg0:create("statTimeString3")
	f116_local0:set("")
	f116_local0 = f116_arg0:create("bronzeComplete")
	f116_local0:set(false)
	f116_local0 = f116_arg0:create("silverComplete")
	f116_local0:set(false)
	f116_local0 = f116_arg0:create("goldComplete")
	f116_local0:set(false)
	f116_local0 = f116_arg0:create("lockState")
	f116_local0:set(Enum[@"playlistlockstate"][@"pls_unlocked"])
end, false)
CoD.ZombieUtility.GetAARTrialStatsRootModel = function(f117_arg0)
	local f117_local0 = CoD.AARUtility.GetAARRootModel(f117_arg0)
	return f117_local0:create("trialStats")
end
local f0_local0 = function(f118_arg0, f118_arg1)
	local f118_local0, f118_local1 = CoD.AARUtility.GetStats(f118_arg0)
	local f118_local2 = CoD.AARUtility.GetCurrentGametype(f118_arg0)
	if not f118_local2 then
		f118_local2 = Engine[@"hash_36F8027A8BC75673"]()
	end
	local f118_local3 = CoD.AARUtility.GetCurrentMapName(f118_arg0)
	if not f118_local3 then
		f118_local3 = Engine[@"lobbygetmap"]()
	end
	local f118_local4, f118_local5 = nil
	local f118_local6 = 1000000
	if CoD.BaseUtility.IsDvarEnabled("ui_forceAAR") then
		return f118_local6
	elseif f118_arg1.flags then
		if f118_arg1.flags.useStatsByMap and f118_local2 == "ztrials" then
			local f118_local7 = CoD.ZombieUtility.GetTrialsNameForMap(f118_local3, CoD.ZombieUtility.GetAARTrialVariant(f118_arg0))
			local f118_local8
			if f118_local1 then
				f118_local8 = f118_local1.PlayerStatsByTrial[f118_local7]
				if not f118_local8 then
				else
					local f118_local9
					if f118_local0 then
						f118_local9 = f118_local0.PlayerStatsByTrial[f118_local7]
						if not f118_local9 then
						else
							if f118_local8 and f118_local8[f118_arg1.statName] then
								local f118_local10 = f118_local8[f118_arg1.statName]:get()
							end
							f118_local4 = f118_local10 or nil
							if f118_local9 and f118_local9[f118_arg1.statName] then
								local f118_local11 = f118_local9[f118_arg1.statName]:get()
							end
							f118_local5 = f118_local11 or nil
						end
					end
					f118_local9 = nil
				end
			end
			f118_local8 = nil
		end
		if not f118_local4 or not f118_local5 then
			if not f118_local1.PlayerStatsByMap[f118_local3] then
				return f118_local6
			elseif f118_arg1.flags.useStatsByGametype and f118_arg1.flags.useStatsByMap then
				if f118_local1 then
					local f118_local12 = f118_local1.PlayerStatsByMap[f118_local3].statsByGameType[f118_local2].stats
				end
				f118_local1 = f118_local12 or nil
				if f118_local0 then
					local f118_local13 = f118_local0.PlayerStatsByMap[f118_local3].statsByGameType[f118_local2].stats
				end
				f118_local0 = f118_local13 or nil
				if f118_local1 then
					local f118_local14 = f118_local1[f118_arg1.statName].StatValue:get()
				end
				f118_local4 = f118_local14 or f118_local6
				if f118_local0 then
					local f118_local15 = f118_local0[f118_arg1.statName].StatValue:get()
				end
				f118_local5 = f118_local15 or f118_local6
			elseif f118_arg1.flags.useStatsByGametype then
				if f118_local1 then
					local f118_local16 = f118_local1.PlayerStatsByGametype[f118_local2]
				end
				f118_local1 = f118_local16 or nil
				if f118_local0 then
					local f118_local17 = f118_local0.PlayerStatsByGametype[f118_local2]
				end
				f118_local0 = f118_local17 or nil
				if f118_local1 then
					local f118_local18 = f118_local1[f118_arg1.statName].StatValue:get()
				end
				f118_local4 = f118_local18 or f118_local6
				if f118_local0 then
					local f118_local19 = f118_local0[f118_arg1.statName].StatValue:get()
				end
				f118_local5 = f118_local19 or f118_local6
			elseif f118_arg1.flags.useStatsByMap then
				if f118_local1 then
					local f118_local20 = f118_local1.PlayerStatsByMap[f118_local3].stats
				end
				f118_local1 = f118_local20 or nil
				if f118_local0 then
					local f118_local21 = f118_local0.PlayerStatsByMap[f118_local3].stats
				end
				f118_local0 = f118_local21 or nil
				if f118_local1 then
					local f118_local22 = f118_local1[f118_arg1.statName].StatValue:get()
				end
				f118_local4 = f118_local22 or f118_local6
				if f118_local0 then
					local f118_local23 = f118_local0[f118_arg1.statName].StatValue:get()
				end
				f118_local5 = f118_local23 or f118_local6
			end
		end
	elseif f118_arg1.useAarStats then
		if f118_local1 then
			local f118_local24 = f118_local1.AfterActionReportStats[f118_arg1.statName]:get()
		end
		f118_local4 = f118_local24 or f118_local6
		if f118_local0 then
			local f118_local25 = f118_local0.AfterActionReportStats[f118_arg1.statName]:get()
		end
		f118_local5 = f118_local25 or f118_local6
	else
		if f118_local1 then
			local f118_local26 = f118_local1.PlayerStatsList[f118_arg1.statName].StatValue:get()
		end
		f118_local4 = f118_local26 or f118_local6
		if f118_local0 then
			local f118_local27 = f118_local0.PlayerStatsList[f118_arg1.statName].StatValue:get()
		end
		f118_local5 = f118_local27 or f118_local6
	end
	if f118_arg1.useStatDiff then
		return f118_local4 - f118_local5
	elseif f118_arg1.useStatBeforeMatch then
		return f118_local5
	end
	return f118_local4
end
CoD.ZombieUtility.GetStat = function(f119_arg0, f119_arg1)
	return f0_local0(f119_arg0, f119_arg1)
end
CoD.ZombieUtility.GetZMRoundStats = function(f120_arg0)
	local f120_local0 = {}
	if CoD.AARUtility.UseTestData() or not IsZombies() then
		f120_local0.kills = string.format("%9.0f", 596236)
		f120_local0.headshots = 10000
		f120_local0.revives = 546
		f120_local0.score = string.format("%9.0f", 121350872)
		f120_local0.teamScore = string.format("%9.0f", 999888768)
		f120_local0.highestMultiplier = 67
		f120_local0.roundReached = 19
		f120_local0.roundsCompleted = 18
		f120_local0.time = CoD.AARUtility.SecondsToHoursMinutesSecondsString(256)
		f120_local0.timeToRound10 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(321)
		f120_local0.timeToRound20 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(654)
		f120_local0.timeToRoundCompletion = CoD.AARUtility.SecondsToHoursMinutesSecondsString(1000)
		f120_local0.allTimeKills = string.format("%9.0f", 596236992)
		f120_local0.allTimeHeadshots = 10000
		f120_local0.highestRound = 28
		f120_local0.highestRoundCompleted = 27
		f120_local0.averageRound = 13
		f120_local0.allTimeTeamScore = string.format("%9.0f", 999888768)
		f120_local0.allTimeHighestMultiplier = 67
		f120_local0.allTimeScore = string.format("%9.0f", 121350872)
		f120_local0.fastestToRound10 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(231)
		f120_local0.fastestToRound20 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(564)
		f120_local0.fastestToCompletion = CoD.AARUtility.SecondsToHoursMinutesSecondsString(987)
		f120_local0.isNewBestTime = ""
		f120_local0.isNewHighestRound = ""
		f120_local0.isTrialComplete = ""
		f120_local0.prevHighestRoundCompleted = -1
	else
		local f120_local1 = Engine.GetSelfGamertag(f120_arg0)
		local f120_local2 = {
			useStatsByMap = true,
			useStatsByGametype = true,
			useDifficultyLookup = true,
		}
		local f120_local3 = {
			useStatsByMap = true,
			useStatsByGametype = true,
		}
		local f120_local4 = {
			useStatsByMap = true,
		}
		local f120_local5 = function(f121_arg0)
			return math.floor(f121_arg0 / 1000)
		end
		f120_local0.kills = f0_local0(f120_arg0, {
			statName = "kills",
			useAarStats = true,
		})
		f120_local0.headshots = f0_local0(f120_arg0, {
			statName = "headshots",
			useAarStats = true,
		})
		f120_local0.revives = f0_local0(f120_arg0, {
			statName = "revives",
			useAarStats = true,
		})
		f120_local0.score = f0_local0(f120_arg0, {
			statName = "total_points",
			useAarStats = true,
		})
		f120_local0.teamScore = f0_local0(f120_arg0, {
			statName = "team_score",
			useAarStats = true,
		})
		f120_local0.highestMultiplier = f0_local0(f120_arg0, {
			statName = "highest_multiplier",
			useAarStats = true,
		})
		f120_local0.roundsCompleted = f0_local0(f120_arg0, {
			statName = "total_rounds_survived",
			useAarStats = true,
		})
		f120_local0.roundReached = f0_local0(f120_arg0, {
			statName = "highest_round_reached",
			useAarStats = true,
		})
		f120_local0.time = CoD.AARUtility.SecondsToHoursMinutesSecondsString(f120_local5(f0_local0(f120_arg0, {
			statName = "gameLength",
			useAarStats = true,
		})))
		f120_local0.timeToRound10 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(f120_local5(f0_local0(f120_arg0, {
			statName = "fastest_time_to_round_10",
			useAarStats = true,
		})))
		f120_local0.timeToRound20 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(f120_local5(f0_local0(f120_arg0, {
			statName = "fastest_time_to_round_20",
			useAarStats = true,
		})))
		f120_local0.timeToRoundCompletion = CoD.AARUtility.SecondsToHoursMinutesSecondsString(f120_local5(f0_local0(f120_arg0, {
			statName = "fastest_time_to_complete_round_30",
			useAarStats = true,
		})))
		local f120_local6 = f0_local0(f120_arg0, {
			statName = "TOTAL_GAMES_PLAYED",
			flags = f120_local3,
		})
		if f120_local6 == 0 or not f120_local6 or f120_local6 == "" then
			f120_local6 = 1 or f120_local6
		end
		f120_local0.allTimeKills = f0_local0(f120_arg0, {
			statName = "MOST_KILLS",
			flags = f120_local3,
		})
		f120_local0.allTimeHeadshots = f0_local0(f120_arg0, {
			statName = "MOST_HEADSHOTS",
			flags = f120_local3,
		})
		f120_local0.highestRound = f0_local0(f120_arg0, {
			statName = "HIGHEST_ROUND_REACHED",
			flags = f120_local3,
		})
		f120_local0.averageRound = math.ceil(f0_local0(f120_arg0, {
			statName = "TOTAL_ROUNDS_SURVIVED",
			flags = f120_local3,
		}) / f120_local6)
		f120_local0.allTimeTeamScore = f0_local0(f120_arg0, {
			statName = "HIGHEST_TEAM_SCORE",
			flags = f120_local3,
		})
		f120_local0.allTimeHighestMultiplier = f0_local0(f120_arg0, {
			statName = "HIGHEST_MULTIPLIER",
			flags = f120_local3,
		})
		f120_local0.allTimeScore = f0_local0(f120_arg0, {
			statName = "HIGHEST_SCORE",
			flags = f120_local3,
		})
		f120_local0.fastestToRound10 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(f120_local5(f0_local0(f120_arg0, {
			statName = "FASTEST_TIME_TO_ROUND_10",
			flags = f120_local3,
		})))
		f120_local0.fastestToRound20 = CoD.AARUtility.SecondsToHoursMinutesSecondsString(f120_local5(f0_local0(f120_arg0, {
			statName = "FASTEST_TIME_TO_ROUND_20",
			flags = f120_local3,
		})))
		local f120_local7 = f0_local0(f120_arg0, {
			statName = "FASTEST_TIME_TO_COMPLETE_ROUND_30",
			flags = f120_local3,
		})
		f120_local0.fastestToCompletion = CoD.AARUtility.SecondsToHoursMinutesSecondsString(f120_local5(f120_local7))
		local f120_local8
		if f120_local7 and f120_local7 ~= 0 and f120_local7 ~= nil and f120_local7 ~= "" then
			f120_local8 = 30
			if not f120_local8 then
			else
				f120_local0.highestRoundCompleted = f120_local8
				f120_local0.isNewBestTime = ""
				f120_local0.isNewHighestRound = ""
				f120_local0.isTrialComplete = ""
				f120_local8 = f0_local0(f120_arg0, {
					statName = "FASTEST_TIME_TO_COMPLETE_ROUND_30",
					useStatBeforeMatch = true,
					flags = f120_local3,
				})
				if not (f120_local8 ~= 0 or f120_local7 == 0) or f120_local8 ~= 0 and f120_local7 ~= 0 and f120_local7 < f120_local8 then
					f120_local0.isNewBestTime = 1
				end
				local f120_local9 = f0_local0(f120_arg0, {
					statName = "HIGHEST_ROUND_REACHED",
					useStatBeforeMatch = true,
					flags = f120_local3,
				})
				local f120_local10
				if f120_local8 and f120_local8 ~= 0 and f120_local8 ~= nil and f120_local8 ~= "" then
					f120_local10 = 30
					if not f120_local10 then
					else
						f120_local0.prevHighestRoundCompleted = f120_local10
						if not (f120_local9 ~= 0 or f120_local0.highestRound == 0) or f120_local9 ~= 0 and f120_local0.highestRound ~= 0 and f120_local9 < f120_local0.highestRound then
							f120_local0.isNewHighestRound = 1
						end
						if f120_local0.roundsCompleted >= 30 then
							f120_local0.isTrialComplete = 1
						end
					end
				end
				f120_local10 = f120_local9 - 1
			end
		end
		f120_local8 = f120_local0.highestRound - 1
	end
	return f120_local0
end
local f0_local1 = function(f122_arg0)
	local f122_local0 = CoD.AARUtility.GetCurrentGametype(f122_arg0)
	if not f122_local0 then
		f122_local0 = Engine[@"hash_36F8027A8BC75673"]()
	end
	return IsZombies() and f122_local1 and f122_local2
end
local f0_local2 = function(f123_arg0)
	return string.sub(f123_arg0, 1, 4) == "ztcm"
end
CoD.ZombieUtility.ZMSummaryListGenericInfoTableFunc = function(f124_arg0, f124_arg1)
	local f124_local0 = {}
	local f124_local1 = CoD.ZombieUtility.GetZMRoundStats(f124_arg0)
	local f124_local2 = CoD.AARUtility.GetCurrentGametype(f124_arg0)
	if not f124_local2 then
		f124_local2 = Engine[@"hash_36F8027A8BC75673"]()
	end
	local f124_local3 = {}
	if f124_local2 == "zclassic" or f0_local2(f124_local2) then
		f124_local3 = {
			{
				title = "menu/lb_zmglobal_kills",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.kills),
			},
			{
				title = "zmui/headshots_caps",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.headshots),
			},
			{
				title = "zmui/revives_caps",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.revives),
			},
			{
				title = @"aar/score",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.score),
			},
			{
				title = @"hash_1D94FC284D93FC2C",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.roundReached),
			},
			{
				title = @"hash_2BD36CB2DA85CF8C",
				value = f124_local1.time,
			},
		}
	elseif f124_local2 == "ztrials" then
		local f124_local4 = CoD.ZombieUtility.GetAARTrialVariant(f124_arg0)
		local f124_local5 = f124_local4 and CoD.ZombieUtility.ZombiesTrialsAARStrings[f124_local4]
		local f124_local6 = {}
		local f124_local7 = {
			title = "menu/lb_zmglobal_kills",
			value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.kills),
		}
		local f124_local8 = {
			title = "zmui/headshots_caps",
			value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.headshots),
		}
		local f124_local9 = {
			title = @"hash_1D94FC284D93FC2C",
			value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.roundReached),
		}
		local f124_local10 = {}
		local f124_local11
		if f124_local5 then
			f124_local11 = f124_local5[@"hash_4C36BC08BE026B1B"]
			if not f124_local11 then
			else
				f124_local10.title = f124_local11
				f124_local10.value = f124_local1.timeToRound10
				f124_local11 = {}
				local f124_local12
				if f124_local5 then
					f124_local12 = f124_local5[@"hash_3C050E25F20B5814"]
					if not f124_local12 then
					else
						f124_local11.title = f124_local12
						f124_local11.value = f124_local1.timeToRound20
						f124_local12 = {}
						local f124_local13
						if f124_local5 then
							f124_local13 = f124_local5[@"hash_1C2A75E3FFC55ABA"]
							if not f124_local13 then
							else
								f124_local12.title = f124_local13
								f124_local12.value = f124_local1.timeToRoundCompletion
								f124_local6[1] = f124_local7
								f124_local6[2] = f124_local8
								f124_local6[3] = f124_local9
								f124_local6[4] = f124_local10
								f124_local6[5] = f124_local11
								f124_local6[6] = f124_local12
								f124_local3 = f124_local6
							end
						end
						f124_local13 = 0x0
					end
				end
				f124_local12 = 0x0
			end
		end
		f124_local11 = 0x0
	elseif f124_local2 == "zstandard" then
		f124_local3 = {
			{
				title = "menu/lb_zmglobal_kills",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.kills),
			},
			{
				title = "zmui/headshots_caps",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.headshots),
			},
			{
				title = "zmui/highest_multiplier",
				value = CoD.ZombieUtility.GetZombieScoreboardColumnRushMultiplierTreatment(f124_arg0, f124_local1.highestMultiplier),
			},
			{
				title = "menu/score_caps",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.score),
			},
		}
		if not f0_local1(f124_arg0) then
			table.insert(f124_local3, {
				title = "codcaster/ds_team_score",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f124_local1.teamScore),
			})
		end
		table.insert(f124_local3, {
			title = @"hash_2BD36CB2DA85CF8C",
			value = f124_local1.time,
		})
	end
	for f124_local7, f124_local8 in ipairs(f124_local3) do
		table.insert(f124_local0, {
			models = {
				title = f124_local8.title,
				value = f124_local8.value,
			},
		})
	end
	return f124_local0
end
DataSources.ZMSummaryListGeneric = ListHelper_SetupDataSource("ZMSummaryListGeneric", CoD.ZombieUtility.ZMSummaryListGenericInfoTableFunc, true)
CoD.ZombieUtility.ZMAllTimeSummaryListGenericInfoTableFunc = function(f125_arg0, f125_arg1)
	local f125_local0 = {}
	local f125_local1 = CoD.ZombieUtility.GetZMRoundStats(f125_arg0)
	local f125_local2 = CoD.AARUtility.GetCurrentGametype(f125_arg0)
	if not f125_local2 then
		f125_local2 = Engine[@"hash_36F8027A8BC75673"]()
	end
	local f125_local3 = {}
	if f125_local2 == "zclassic" or f0_local2(f125_local2) then
		f125_local3 = {
			{
				title = "menu/lb_zmglobal_kills",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeKills),
			},
			{
				title = "zmui/headshots_caps",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeHeadshots),
			},
			{
				title = "zmui/highest_round_reached",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.highestRound),
			},
			{
				title = @"hash_434FF6AAA0F9F838",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.averageRound),
			},
		}
	elseif f125_local2 == "ztrials" then
		local f125_local4 = CoD.ZombieUtility.GetAARTrialVariant(f125_arg0)
		local f125_local5 = f125_local4 and CoD.ZombieUtility.ZombiesTrialsAARStrings[f125_local4]
		local f125_local6 = {}
		local f125_local7 = {
			title = "menu/lb_zmglobal_kills",
			value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeKills),
		}
		local f125_local8 = {
			title = "zmui/headshots_caps",
			value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeHeadshots),
		}
		local f125_local9 = {
			title = "zmui/highest_round_reached",
			value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.highestRound),
		}
		local f125_local10 = {}
		local f125_local11
		if f125_local5 then
			f125_local11 = f125_local5[@"hash_198AA0DF94DC45F7"]
			if not f125_local11 then
			else
				f125_local10.title = f125_local11
				f125_local10.value = f125_local1.fastestToRound10
				f125_local11 = {}
				local f125_local12
				if f125_local5 then
					f125_local12 = f125_local5[@"hash_4D3FCB432AB0BED0"]
					if not f125_local12 then
					else
						f125_local11.title = f125_local12
						f125_local11.value = f125_local1.fastestToRound20
						f125_local12 = {}
						local f125_local13
						if f125_local5 then
							f125_local13 = f125_local5[@"hash_2B5823ED10209C66"]
							if not f125_local13 then
							else
								f125_local12.title = f125_local13
								f125_local12.value = f125_local1.fastestToCompletion
								f125_local6[1] = f125_local7
								f125_local6[2] = f125_local8
								f125_local6[3] = f125_local9
								f125_local6[4] = f125_local10
								f125_local6[5] = f125_local11
								f125_local6[6] = f125_local12
								f125_local3 = f125_local6
							end
						end
						f125_local13 = 0x0
					end
				end
				f125_local12 = 0x0
			end
		end
		f125_local11 = 0x0
	elseif f125_local2 == "zstandard" then
		f125_local3 = {
			{
				title = "menu/lb_zmglobal_kills",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeKills),
			},
			{
				title = "zmui/headshots_caps",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeHeadshots),
			},
			{
				title = "zmui/highest_multiplier",
				value = CoD.ZombieUtility.GetZombieScoreboardColumnRushMultiplierTreatment(f125_arg0, f125_local1.allTimeHighestMultiplier),
			},
			{
				title = "menu/score_caps",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeScore),
			},
		}
		if not f0_local1(f125_arg0) then
			table.insert(f125_local3, {
				title = "codcaster/ds_team_score",
				value = CoD.TextUtility.FormatNumberWithDelimiters(f125_local1.allTimeTeamScore),
			})
		end
	end
	for f125_local7, f125_local8 in ipairs(f125_local3) do
		table.insert(f125_local0, {
			models = {
				title = f125_local8.title,
				value = f125_local8.value,
			},
		})
	end
	return f125_local0
end
CoD.ZombieUtility.SetupTrialStats = function(f126_arg0)
	local f126_local0 = CoD.ZombieUtility.GetAARTrialStatsRootModel(f126_arg0)
	for f126_local4, f126_local5 in pairs(CoD.ZombieUtility.GetZMRoundStats(f126_arg0)) do
		local f126_local6 = f126_local0:create(f126_local4)
		f126_local6:set(f126_local5)
	end
	CoD.ZombieUtility.GetAARTrialVariant(f126_arg0)
end
CoD.ZombieUtility.GetAARTrialVariant = function(f127_arg0)
	local f127_local0 = CoD.ZombieUtility.GetAARTrialStatsRootModel(f127_arg0)
	local f127_local1 = f127_local0.zmTrialsVariant
	if not f127_local1 then
		f127_local1 = f127_local0:create("zmTrialsVariant")
		f127_local1:set(Engine.GetGametypeSetting("zmtrialsvariant"))
	end
	return f127_local1 and f127_local1:get()
end
DataSources.ZMAllTimeSummaryListGeneric = ListHelper_SetupDataSource("ZMAllTimeSummaryListGeneric", CoD.ZombieUtility.ZMAllTimeSummaryListGenericInfoTableFunc, true)
DataSources.ZmAarTrialRoundGrid = ListHelper_SetupDataSource("ZmAarTrialRoundGrid", function(f128_arg0, f128_arg1)
	if not CoD.ZombieUtility then
		return {}
	else
		return CoD.ZombieUtility.GetTrialRoundGridInfo(CoD.MapUtility.ConvertMapNameToXHash(Engine.IsInGame() and Engine[@"lobbygetmap"]() or CoD.AARUtility.GetCurrentMapName(f128_arg0)), nil, Engine.IsInGame() and Engine.GetGametypeSetting("zmtrialsvariant") or CoD.ZombieUtility.GetAARTrialVariant(f128_arg0))
	end
end, true)
DataSources.ZmAarTrialRoundColumn = ListHelper_SetupDataSource("ZmAarTrialRoundColumn", function(f129_arg0, f129_arg1)
	local f129_local0 = {}
	for f129_local4, f129_local5 in ipairs({
		{
			roundCompleteRequirement = 10,
		},
		{
			roundCompleteRequirement = 20,
		},
		{
			roundCompleteRequirement = 30,
		},
	}) do
		table.insert(f129_local0, {
			models = {
				roundCompleteRequirement = f129_local5.roundCompleteRequirement,
			},
		})
	end
	return f129_local0
end, true)
DataSources.ZmAarTrialRewardList = ListHelper_SetupDataSource("ZmAarTrialRewardList", function(f130_arg0, f130_arg1)
	local f130_local0 = {}
	for f130_local4, f130_local5 in ipairs({
		{
			roundCompleteRequirement = 10,
			rewardImage1 = "specialty_marathon_zombies",
			rewardImage2 = "blacktransparent",
		},
		{
			roundCompleteRequirement = 20,
			rewardImage1 = "specialty_marathon_zombies",
			rewardImage2 = "blacktransparent",
		},
		{
			roundCompleteRequirement = 30,
			rewardImage1 = "specialty_marathon_zombies",
			rewardImage2 = "specialty_marathon_zombies",
		},
	}) do
		table.insert(f130_local0, {
			models = {
				roundCompleteRequirement = f130_local5.roundCompleteRequirement,
				rewardImage1 = f130_local5.rewardImage1,
				rewardImage2 = f130_local5.rewardImage2,
			},
		})
	end
	return f130_local0
end, true)
DataSources.AARTrialStats = {
	getModel = function(f131_arg0)
		return CoD.ZombieUtility.GetAARTrialStatsRootModel(f131_arg0)
	end,
}
CoD.ZombieUtility.GetZMPlaylistTrialVariant = function(f132_arg0)
	for f132_local3, f132_local4 in ipairs(f132_arg0.rules) do
		if f132_local4.type == 0 and f132_local4.name == "zmtrialsvariant" then
			return tonumber(f132_local4.value)
		end
	end
	return 0
end
CoD.ZombieUtility.GetZMPlaylistTrialName = function(f133_arg0)
	return CoD.ZombieUtility.GetTrialsNameForMap(f133_arg0.rotationList[1].map, CoD.ZombieUtility.GetZMPlaylistTrialVariant(f133_arg0))
end
CoD.ZombieUtility.IsFocusedPlaylistTrialVariant = function(f134_arg0)
	local f134_local0 = Engine.GetGlobalModel()
	f134_local0 = f134_local0:create("ZMLobbyExclusions.focusedPlaylistID")
	if f134_local0 and f134_local0:get() then
		return f134_arg0 == CoD.ZombieUtility.GetZMPlaylistTrialVariant(Engine[@"getplaylistinfobyid"](f134_local0:get()))
	else
	end
end
DataSources.ZMTrialInfoRoundStat = DataSourceHelpers.ListSetup("ZMTrialInfoRoundStat", function(f135_arg0, f135_arg1)
	local f135_local0 = {}
	local f135_local1 = Engine.GetGlobalModel()
	f135_local1 = f135_local1:create("ZMLobbyExclusions.focusedPlaylistID")
	local f135_local2 = 0
	if f135_local1 and f135_local1:get() then
		local f135_local3 = Engine[@"getplaylistinfobyid"](f135_local1:get())
		local f135_local4 = f135_local3.rotationList[1].map
		local f135_local5 = Engine[@"hash_1F2CD89B3C345FD3"](f135_local3.rotationList[1].gametype)
		local f135_local6 = f135_local5.gametype
		if not IsLobbyNetworkModeLAN() then
			local f135_local7 = CoD.GetPlayerStats(f135_arg0)
			local f135_local8 = CoD.ZombieUtility.GetZMPlaylistTrialName(f135_local3)
			if f135_local7.PlayerStatsByTrial[f135_local8] then
				f135_local2 = f135_local7.PlayerStatsByTrial[f135_local8].highest_round_reached:get()
			end
		end
		f135_local0 = CoD.ZombieUtility.GetTrialRoundGridInfo(f135_local4, f135_local2, CoD.ZombieUtility.GetZMPlaylistTrialVariant(f135_local3))
	end
	return f135_local0
end, true)
DataSourceHelpers.PerControllerDataSourceSetup("ZMBarracksTrialStats", "ZMBarracksTrialStats", function(f136_arg0, f136_arg1)
	local f136_local0 = 0
	local f136_local1 = 0
	local f136_local2 = 0
	if Engine.CurrentSessionMode() == Enum.eModes.mode_zombies then
		local f136_local3 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer(f136_arg1)
		local f136_local4 = f136_local3 and f136_local3.playerstatsbytrial
		if f136_local4 then
			for f136_local8, f136_local9 in ipairs(CoD.ZombieUtility.ZMTrialsEnum) do
				local f136_local10 = f136_local4[f136_local9]
				if f136_local10 then
					if 0 < f136_local10.fastest_time_to_complete_round_30:get() then
						f136_local0 = f136_local0 + 1
					end
					if 0 < f136_local10.fastest_time_to_round_20:get() then
						f136_local1 = f136_local1 + 1
					end
					if 0 < f136_local10.fastest_time_to_round_10:get() then
						f136_local2 = f136_local2 + 1
					end
				end
			end
		end
	end
	local f136_local3 = f136_arg0:create("goldMedals")
	f136_local3:set(f136_local0)
	f136_local3 = f136_arg0:create("silverMedals")
	f136_local3:set(f136_local1)
	f136_local3 = f136_arg0:create("bronzeMedals")
	f136_local3:set(f136_local2)
end, false)
DataSources.DirectorZMPlaylistInfoMaps = DataSourceHelpers.ListSetup("DirectorZMPlaylistInfoMaps", function(f137_arg0, f137_arg1)
	local f137_local0 = {}
	local f137_local1 = Engine.GetGlobalModel()
	f137_local1 = f137_local1:create("ZMLobbyExclusions.ZMPlaylistTab")
	local f137_local2 = f137_local1:get()
	local f137_local3 = Engine.GetGlobalModel()
	f137_local3 = f137_local3:create("ZMLobbyExclusions.focusedPlaylistID")
	local f137_local4 = f137_local3:get()
	local f137_local5 = Engine.GetGlobalModel()
	f137_local5 = f137_local5:create("LobbyRoot.PlaylistID")
	local f137_local6 = f137_local5:get()
	if f137_local4 == nil then
		f137_local4 = f137_local6
	end
	if f137_local2 == CoD.ZombieUtility.ZMPlaylistTabs.FEATURED or f137_local2 == CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
		local f137_local7 = {}
		local f137_local8 = Engine[@"getplaylistinfobyid"](f137_local4)
		local f137_local9 = f137_local8.rotationList
		for f137_local10 = 1, #f137_local9, 1 do
			local f137_local13 = f137_local9[f137_local10].map
			if not CoD.ZombieUtility.ArrayContains(f137_local7, f137_local13) then
				table.insert(f137_local7, f137_local13)
				table.insert(f137_local0, {
					models = {
						map = f137_local13,
					},
				})
			end
		end
	end
	if #f137_local0 < 4 then
		for f137_local7 = #f137_local0 + 1, 4, 1 do
			local f137_local10 = f137_local7
			table.insert(f137_local0, {
				models = {
					map = 0x0,
				},
			})
		end
	end
	if f137_arg1.playlistTabSubscription == nil then
		f137_arg1.playlistTabSubscription = f137_arg1:subscribeToModel(f137_local1, function()
			f137_arg1:updateDataSource()
		end, false)
	end
	if f137_arg1.focusedPlaylistIdSubscription == nil then
		f137_arg1.focusedPlaylistIdSubscription = f137_arg1:subscribeToModel(f137_local3, function()
			f137_arg1:updateDataSource()
		end, false)
	end
	if f137_arg1.playlistIDSubscription == nil then
		f137_arg1.playlistIDSubscription = f137_arg1:subscribeToModel(f137_local5, function()
			f137_arg1:updateDataSource()
		end, false)
	end
	return f137_local0
end, true)
DataSources.DirectorZMPlaylistInfoModes = DataSourceHelpers.ListSetup("DirectorZMPlaylistInfoModes", function(f141_arg0, f141_arg1)
	local f141_local0 = {}
	local f141_local1 = Engine.GetGlobalModel()
	f141_local1 = f141_local1:create("ZMLobbyExclusions.ZMPlaylistTab")
	local f141_local2 = f141_local1:get()
	local f141_local3 = Engine.GetGlobalModel()
	f141_local3 = f141_local3:create("ZMLobbyExclusions.focusedPlaylistID")
	local f141_local4 = f141_local3:get()
	local f141_local5 = Engine.GetGlobalModel()
	f141_local5 = f141_local5:create("LobbyRoot.PlaylistID")
	local f141_local6 = f141_local5:get()
	if f141_local4 == nil then
		f141_local4 = f141_local6
	end
	if f141_local2 == CoD.ZombieUtility.ZMPlaylistTabs.FEATURED or f141_local2 == CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
		local f141_local7 = {}
		local f141_local8 = Engine[@"getplaylistinfobyid"](f141_local4)
		local f141_local9 = f141_local8.rotationList
		for f141_local10 = 1, #f141_local9, 1 do
			local f141_local13 = Engine[@"hash_1F2CD89B3C345FD3"](f141_local9[f141_local10].gametype)
			local f141_local14 = f141_local13.gametype
			if not CoD.ZombieUtility.ArrayContains(f141_local7, f141_local14) then
				table.insert(f141_local7, f141_local14)
				table.insert(f141_local0, {
					models = {
						gametype = f141_local14,
					},
				})
			end
		end
	end
	if f141_arg1.playlistTabSubscription == nil then
		f141_arg1.playlistTabSubscription = f141_arg1:subscribeToModel(f141_local1, function()
			f141_arg1:updateDataSource()
		end, false)
	end
	if f141_arg1.focusedPlaylistIdSubscription == nil then
		f141_arg1.focusedPlaylistIdSubscription = f141_arg1:subscribeToModel(f141_local3, function()
			f141_arg1:updateDataSource()
		end, false)
	end
	if f141_arg1.playlistIDSubscription == nil then
		f141_arg1.playlistIDSubscription = f141_arg1:subscribeToModel(f141_local5, function()
			f141_arg1:updateDataSource()
		end, false)
	end
	return f141_local0
end, true)
DataSources.ZMDifficultyList = DataSourceHelpers.ListSetup("ZMDifficultyList", function(f145_arg0, f145_arg1)
	local f145_local0 = {
		@"hash_2ED79943A5C831E7",
		@"hash_ECB7319B79FAA96",
		@"hash_667807E571813E78",
		@"hash_392095A74A04187F",
	}
	local f145_local1 = {
		"ui_icon_difficulty_zm_casual_large",
		"ui_icon_difficulty_zm_normal_large",
		"ui_icon_difficulty_zm_hardcore_large",
		"ui_icon_difficulty_zm_realistic_large",
	}
	local f145_local2 = {}
	local f145_local3 = Engine.GetGlobalModel()
	f145_local3 = f145_local3:create("ZMLobbyExclusions")
	f145_local3 = f145_local3:create("ZMPrivateDifficulty")
	if f145_arg1.difficultySubscription == nil then
		f145_arg1.difficultySubscription = f145_arg1:subscribeToModel(f145_local3, function()
			f145_arg1:updateDataSource()
		end, false)
	end
	local f145_local4 = nil
	if not IsLobbyNetworkModeLAN() then
		local f145_local5 = Engine.GetGlobalModel()
		f145_local5 = f145_local5:create("ZMLobbyExclusions.ZMPlaylistTab")
		if f145_arg1.playlistTabSubscription == nil then
			f145_arg1.playlistTabSubscription = f145_arg1:subscribeToModel(f145_local5, function()
				f145_arg1:updateDataSource()
			end, false)
		end
		if f145_arg1.gametypeSubscription then
			f145_arg1:removeSubscription(f145_arg1.gametypeSubscription)
		end
		local f145_local6 = f145_local5:get()
		if f145_local6 ~= CoD.ZombieUtility.ZMPlaylistTabs.FEATURED and f145_local6 ~= CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC and f145_local6 ~= CoD.ZombieUtility.ZMPlaylistTabs.TCM then
			f145_local4 = f145_local6
		end
	else
		local f145_local5 = Engine.GetGlobalModel()
		f145_local5 = f145_local5:create("lobbyRoot.selectedGameType")
		if f145_arg1.gametypeSubscription == nil then
			f145_arg1.gametypeSubscription = f145_arg1:subscribeToModel(f145_local5, function()
				f145_arg1:updateDataSource()
			end, false)
		end
		if f145_arg1.playlistTabSubscription then
			f145_arg1:removeSubscription(f145_arg1.playlistTabSubscription)
		end
		f145_local4 = f145_local5:get()
		Engine.SetGametypeSetting("zmDifficulty", f145_local3:get())
		CoD.ZombieUtility.SetLocalZMDifficultyModel(f145_local3:get())
		local f145_local6 = Engine[@"lobbygetcontrollinglobbysession"](Enum.LobbyModule[@"lobby_module_host"])
		Engine[@"lobbyevent"]("OnGametypeSettingsChange", {
			lobbyModule = Enum.LobbyModule[@"lobby_module_host"],
			lobbyType = f145_local6,
			fromUI = true,
		})
		Engine[@"lobbyhostsessionsetdirty"](f145_local6, Enum.SessionDirty[@"session_dirty_state"])
	end
	if f145_local4 ~= nil then
		local f145_local5 = Engine[@"hash_48D4B2F88BB8D5E7"](f145_local4)
		local f145_local6 = f145_local3:get()
		local f145_local7 = f145_local5.difficultyRangeMin
		local f145_local8 = f145_local5.difficultyRangeMax
		if f145_local7 ~= f145_local8 then
			for f145_local9 = f145_local7, f145_local8, 1 do
				table.insert(f145_local2, {
					models = {
						difficultyID = f145_local9,
						difficultyText = f145_local0[f145_local9 + 1],
						difficultyImage = f145_local1[f145_local9 + 1],
						selected = f145_local9 == f145_local6,
					},
				})
			end
		end
	end
	return f145_local2
end, true)
DataSources.DirectorPlaylistMapList = DataSourceHelpers.ListSetup("DirectorPlaylistMapList", function(f149_arg0, f149_arg1)
	local f149_local0 = {}
	local f149_local1 = Engine[@"getplaylistid"]()
	local f149_local2 = Engine.GetGlobalModel()
	f149_local2 = f149_local2:create("ZMLobbyExclusions.ZMPlaylistTab")
	local f149_local3 = f149_local2:get()
	local f149_local4 = Engine.GetGlobalModel()
	f149_local4 = f149_local4:create("ZMLobbyExclusions.ZMPrivateDifficulty")
	local f149_local5 = f149_local4:get()
	local f149_local6 = CoD.LobbyUtility.GetClientList()
	local f149_local7 = CoD.ZombieUtility.GetUnfilteredPlaylistEntriesForTab(f149_arg0, f149_local3, f149_local5)
	if f149_local3 ~= CoD.ZombieUtility.ZMPlaylistTabs.FEATURED and f149_local3 ~= CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC and f149_local3 ~= CoD.ZombieUtility.ZMPlaylistTabs.TCM and f149_local3 ~= "ztrials" and f149_local3 ~= "ztutorial" then
		local f149_local8 = {}
		local f149_local9 = {}
		for f149_local10 = 1, #f149_local7, 1 do
			local f149_local13 = f149_local7[f149_local10]
			local f149_local14 = f149_local13.rotationList[1].map
			if not CoD.ZombieUtility.ArrayContains(f149_local9, f149_local14) then
				table.insert(f149_local9, f149_local14)
				table.insert(f149_local8, f149_local13)
			end
		end
		f149_local7 = f149_local8
	end
	if f149_local3 == CoD.ZombieUtility.ZMPlaylistTabs.FEATURED or f149_local3 == CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
		local f149_local8 = false
		local f149_local9 = {}
		for f149_local10 = 1, #f149_local7, 1 do
			local f149_local13 = f149_local7[f149_local10]
			if f149_local13.featured then
				f149_local8 = true
				if f149_local13.isQuickplayCard then
					table.insert(f149_local9, 1, f149_local13)
				else
					table.insert(f149_local9, f149_local13)
				end
			end
		end
		for f149_local10 = 1, #f149_local7, 1 do
			local f149_local13 = f149_local7[f149_local10]
			if not f149_local13.featured then
				table.insert(f149_local9, f149_local13)
			end
		end
		f149_local7 = f149_local9
	end
	local f149_local8 = false
	for f149_local9 = 1, #f149_local7, 1 do
		local f149_local15 = f149_local7[f149_local9]
		local f149_local13 = f149_local15.id == f149_local1
		if not f149_local13 and Engine[@"getdvarbool"]("zm_select_playlist_on_tab_change") then
			local f149_local14 = Engine[@"getplaylistinfobyid"](f149_local1)
			if #f149_local15.rotationList == 1 and #f149_local14.rotationList == 1 then
				f149_local13 = f149_local15.rotationList[1].map == f149_local14.rotationList[1].map
				if f149_local13 then
					Engine[@"setplaylistid"](f149_local15.id)
					LuaUtils.SetQuickplayPlaylistID(f149_local15.id)
				end
			end
		end
		if f149_local13 then
			f149_local8 = true
		end
		local f149_local14 = f149_local15.rotationList[1].map
		local f149_local16 = CoD.MapUtility.GetMapValue(f149_local15.rotationList[1].map, "mapName", 0x0)
		local f149_local17 = CoD.MapUtility.GetMapValue(f149_local15.rotationList[1].map, "previewImage", 0x0)
		local f149_local18 = CoD.MapUtility.GetMapValue(f149_local15.rotationList[1].map, "bigPreviewImage", 0x0)
		local f149_local19 = CoD.MapUtility.GetMapValue(f149_local15.rotationList[1].map, "mapDescription", 0x0)
		local f149_local20 = f149_local15.description
		local f149_local21 = f149_local16
		local f149_local22 = f149_local15.locked
		if not f149_local22 and CoD.DirectorUtility.IsPlaylistRankRestrictedForPlayer(f149_local15, Enum.eModes.mode_zombies, f149_arg0) then
			f149_local22 = true
		end
		local f149_local23 = LuaUtils.PlaylistRulesIncludes(f149_local15.rules, "scr_xpscalezm", "2")
		local f149_local24 = LuaUtils.PlaylistRulesIncludes(f149_local15.rules, "scr_gunxpscalezm", "2")
		local f149_local25 = CoD.ZombieUtility.IsDoubleNP(f149_arg0)
		local f149_local26 = f149_local15.featured and 2 or 1
		local f149_local27 = table.insert
		local f149_local28 = f149_local0
		local f149_local29 = {}
		local f149_local30 = {
			id = f149_local14,
			playlistID = f149_local15.id,
			text = Engine.Localize(f149_local16),
			buttonText = Engine.Localize(f149_local21),
			image = f149_local17,
			imageLarge = f149_local18,
		}
		local f149_local31 = f149_local15.imageTileSmall
		if not f149_local31 then
			f149_local31 = "blacktransparent"
		end
		f149_local30.tileImage = f149_local31
		f149_local30.playlistDesc = f149_local20
		if f149_local3 ~= CoD.ZombieUtility.ZMPlaylistTabs.FEATURED and f149_local3 ~= CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
			f149_local31 = not f149_local15.excludePublicLobby
		else
			f149_local31 = false
		end
		f149_local30.isFeatured = f149_local31
		f149_local30.playlist = f149_local15.id
		f149_local30.name = Engine[@"hash_4F9F1239CFD921FE"](f149_local15.name)
		f149_local30.playlistDesc = f149_local20
		f149_local31 = f149_local15.imageTileLarge
		if not f149_local31 then
			f149_local31 = "blacktransparent"
		end
		f149_local30.icon = f149_local31
		f149_local30.iconBackground = f149_local15.imageBackground
		f149_local30.iconBackgroundFocus = f149_local15.imageBackgroundFocus
		f149_local30.mode = f149_local15.mainMode
		f149_local30.locked = f149_local22
		f149_local30.lockState = Engine[@"hash_514ECF96E169F000"](f149_arg0, f149_local15.id)
		f149_local30.featured = f149_local15.featured == true
		f149_local30.maxPartySize = f149_local15.maxPartySize
		f149_local30.hasDoubleXP = f149_local23
		f149_local30.hasDoubleWeaponXP = f149_local24
		f149_local30.hasDoubleNP = f149_local25
		f149_local30.showForAllClients = false
		f149_local30.trialVariant = CoD.ZombieUtility.GetZMPlaylistTrialVariant(f149_local15)
		f149_local30.trialName = CoD.ZombieUtility.LocalizeTrialMapName(f149_local14, CoD.ZombieUtility.GetZMPlaylistTrialVariant(f149_local15))
		f149_local29.models = f149_local30
		f149_local30 = {
			mapName = f149_local14,
			playlistID = f149_local15.id,
			selectIndex = f149_local13,
		}
		f149_local31 = Engine[@"hash_77D47312EBA41751"]()
		if not f149_local31 then
			f149_local31 = Engine[@"hash_5CB675CA7856DA25"]()
		end
		f149_local30.disabled = f149_local31
		f149_local30.purchasable = not Engine.IsMapValid(CoD.MapUtility.ConvertMapNameToXHash(f149_local14))
		f149_local30.rowSpan = f149_local26
		f149_local29.properties = f149_local30
		f149_local27(f149_local28, f149_local29)
	end
	if not f149_local8 and #f149_local0 > 0 and f149_local3 == "zclassic" then
		local f149_local9 = Engine[@"getplaylistinfobyid"](f149_local1)
		for f149_local10 = 1, #f149_local0, 1 do
			if #f149_local9.rotationList == 1 and f149_local9.excludePublicLobby and f149_local0[f149_local10].models.id == f149_local9.rotationList[1].map and CoD.ZombieUtility.GetGroupedGameType(f149_local9.rotationList[1].gametype, "zclassic") == "zclassic" then
				f149_local0[f149_local10].properties.selectIndex = true
				f149_local8 = true
				Engine[@"setplaylistid"](f149_local0[f149_local10].models.playlistID)
				LuaUtils.SetQuickplayPlaylistID(f149_local0[f149_local10].models.playlistID)
				break
			end
		end
	end
	if not f149_local8 and #f149_local0 > 0 then
		f149_local0[1].properties.selectIndex = true
		if Engine[@"getdvarbool"]("zm_select_playlist_on_tab_change") then
			f149_local9 = f149_local0[1].models.playlistID
			f149_local8 = true
			Engine[@"setplaylistid"](f149_local9)
			LuaUtils.SetQuickplayPlaylistID(f149_local9)
		end
	end
	if f149_arg1.playlistTabSubscription == nil then
		f149_arg1.playlistTabSubscription = f149_arg1:subscribeToModel(f149_local2, function()
			f149_arg1:updateDataSource()
		end, false)
	end
	if f149_arg1.difficultySubscription == nil then
		f149_arg1.difficultySubscription = f149_arg1:subscribeToModel(f149_local4, function()
			f149_arg1:updateDataSource()
		end, false)
	end
	return f149_local0
end, true)
DataSources.DirectorPlaylistGameTypeList = DataSourceHelpers.ListSetup("DirectorPlaylistGameTypeList", function(f152_arg0, f152_arg1)
	local f152_local0 = {}
	local f152_local1 = Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot")
	local f152_local2 = Engine.GetModel(f152_local1, "playlistId")
	local f152_local3 = nil
	if f152_local2 and f152_local2:get() then
		f152_local3 = Engine[@"getplaylistinfobyid"](f152_local2:get())
	end
	local f152_local4 = Engine.CreateModel(Engine.CreateModel(f152_local1, "lobbyList"), "playerCount")
	local f152_local5 = Engine.GetModelValue(f152_local4) or 0
	local f152_local6 = #CoD.ZombieUtility.GetUnfilteredPlaylistEntriesForTab(f152_arg0, CoD.ZombieUtility.ZMPlaylistTabs.FEATURED) > 0
	local f152_local7 = false
	for f152_local8 = CoD.ZombieUtility.ZMPlaylistTabs.BEGIN, CoD.ZombieUtility.ZMPlaylistTabs.COUNT, 1 do
		local f152_local11 = ""
		local f152_local12 = 0x0
		local f152_local13 = false
		local f152_local14 = false
		if f152_local8 == CoD.ZombieUtility.ZMPlaylistTabs.FEATURED then
			f152_local14 = not f152_local6
			f152_local12 = @"menu/featured"
			f152_local13 = f152_local3.featuredCategory and f152_local3 and not f152_local3.excludePublicLobby
		elseif f152_local8 == CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
			f152_local12 = @"menu/public_tab"
			local f152_local15 = f152_local3
			if not f152_local3.featuredCategory then
				f152_local13 = not f152_local3.excludePublicLobby
			else
				f152_local13 = false
			end
		elseif f152_local8 == CoD.ZombieUtility.ZMPlaylistTabs.ZCLASSIC then
			f152_local11 = "zclassic"
			f152_local12 = CoD.ZombieUtility.GetGametypeTabName("zclassic")
			if f152_local3 and #f152_local3.rotationList == 1 then
				local f152_local16 = Engine[@"hash_1F2CD89B3C345FD3"](f152_local3.rotationList[1].gametype)
				f152_local13 = f152_local16 and f152_local16.gametype == "zclassic"
			end
		elseif f152_local8 == CoD.ZombieUtility.ZMPlaylistTabs.ZSTANDARD then
			f152_local11 = "zstandard"
			f152_local12 = CoD.ZombieUtility.GetGametypeTabName("zstandard")
			if f152_local3 and #f152_local3.rotationList == 1 then
				local f152_local16 = Engine[@"hash_1F2CD89B3C345FD3"](f152_local3.rotationList[1].gametype)
				f152_local13 = f152_local16 and f152_local16.gametype == "zstandard"
			end
		elseif f152_local8 == CoD.ZombieUtility.ZMPlaylistTabs.TCM then
			if not LUI.DEV then
				f152_local14 = true
			end
			f152_local11 = "ztcm"
			f152_local12 = CoD.ZombieUtility.GetGametypeTabName("ztcm")
			if f152_local3 and #f152_local3.rotationList == 1 then
				local f152_local16 = Engine[@"hash_1F2CD89B3C345FD3"](f152_local3.rotationList[1].gametype)
				f152_local13 = f152_local16 and f152_local16.gametype == "ztcm"
			end
		elseif f152_local8 == CoD.ZombieUtility.ZMPlaylistTabs.ZTRIALS then
			f152_local14 = IsBooleanDvarSet(0x431CAAEFB37761)
			f152_local11 = "ztrials"
			f152_local12 = CoD.ZombieUtility.GetGametypeTabName("ztrials")
			if f152_local3 and #f152_local3.rotationList == 1 then
				local f152_local16 = Engine[@"hash_1F2CD89B3C345FD3"](f152_local3.rotationList[1].gametype)
				f152_local13 = f152_local16 and f152_local16.gametype == "ztrials"
			end
		elseif f152_local8 == CoD.ZombieUtility.ZMPlaylistTabs.ZTUTORIAL then
			if f152_local5 > 1 then
				f152_local14 = true
			end
			f152_local11 = "ztutorial"
			f152_local12 = CoD.ZombieUtility.GetGametypeTabName("ztutorial")
			if f152_local3 and #f152_local3.rotationList == 1 then
				local f152_local16 = Engine[@"hash_1F2CD89B3C345FD3"](f152_local3.rotationList[1].gametype)
				f152_local13 = f152_local16 and f152_local16.gametype == "ztutorial"
			end
		end
		if not f152_local14 then
			if f152_local13 and not f152_local7 then
				f152_local7 = true
				CoD.ZombieUtility.SetPlaylistTab(f152_local8, f152_local11)
			elseif f152_local7 then
				f152_local13 = false
			end
			table.insert(f152_local0, {
				models = {
					id = f152_local11,
					name = f152_local12,
					tabID = f152_local8,
					available = true,
				},
				properties = {
					selectIndex = f152_local13,
				},
			})
		end
	end
	if not f152_local7 then
		f152_local0[1].properties.selectIndex = true
		CoD.ZombieUtility.SetPlaylistTab(f152_local0[1].models.tabID, f152_local0[1].models.id)
	end
	if f152_arg1.playerCountSubscription == nil then
		f152_arg1.playerCountSubscription = f152_arg1:subscribeToModel(f152_local4, function()
			f152_arg1:updateDataSource()
		end, false)
	end
	return f152_local0
end, true)
CoD.ZombieUtility.GetUnfilteredPlaylistEntriesForTab = function(f154_arg0, f154_arg1, f154_arg2)
	local f154_local0 = {}
	local f154_local1 = LobbyData.GetCurrentMenuTarget()
	local f154_local2 = CoD.DirectorUtility.GetPlaylists()
	for f154_local3 = 1, #f154_local2, 1 do
		local f154_local6 = f154_local2[f154_local3]
		if f154_local6.hidden ~= true then
			local f154_local7 = LuaUtils.GetEModeForLobbyMainMode(f154_local6.lobbyMainMode)
			if (f154_local7 == nil or CoD.DirectorUtility.IsSessionModeAvailable(f154_arg0, f154_local7)) and f154_local1[@"mainmode"] == f154_local6.lobbyMainMode then
				local f154_local8 = f154_local6.entries
				for f154_local9 = 1, #f154_local8, 1 do
					local f154_local12 = false
					local f154_local13 = f154_local8[f154_local9]
					if f154_arg1 == CoD.ZombieUtility.ZMPlaylistTabs.FEATURED then
						if f154_local13.featuredCategory and not f154_local13.excludePublicLobby then
							f154_local12 = true
						end
					elseif f154_arg1 == CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
						if not f154_local13.featuredCategory and not f154_local13.excludePublicLobby then
							f154_local12 = true
						end
					elseif f154_arg1 == "ztutorial" then
						local f154_local14 = Engine[@"hash_1F2CD89B3C345FD3"](f154_local13.rotationList[1].gametype)
						if f154_local14.gametype == f154_arg1 then
							f154_local12 = true
						end
					elseif f154_arg1 ~= nil and #f154_local13.rotationList == 1 and f154_local13.excludePublicLobby and (f154_arg1 ~= "zclassic" or f154_arg1 == "zclassic" and CoD.ZombieUtility.GetZMPlaylistDifficulty(f154_local13) == f154_arg2) and CoD.ZombieUtility.GetGroupedGameType(f154_local13.rotationList[1].gametype, f154_arg1) == f154_arg1 then
						f154_local12 = true
					end
					if f154_local13.isQuickplayCard and not CoD.DirectorUtility.IsQuickplayAvailableForMode(Enum.LobbyMainMode[@"lobby_mainmode_zm"]) then
						f154_local12 = false
					end
					if f154_local12 then
						table.insert(f154_local0, f154_local13)
					end
				end
			end
		end
	end
	return f154_local0
end
CoD.ZombieUtility.GetQuickplayPlaylists = function(f155_arg0, f155_arg1)
	local f155_local0 = {}
	for f155_local4, f155_local5 in ipairs(CoD.ZombieUtility.GetUnfilteredPlaylistEntriesForTab(f155_arg1, CoD.ZombieUtility.ZMPlaylistTabs.FEATURED)) do
		if f155_local5.canQuickplay then
			table.insert(f155_local0, f155_local5.id)
		end
	end
	for f155_local4, f155_local5 in ipairs(CoD.ZombieUtility.GetUnfilteredPlaylistEntriesForTab(f155_arg1, CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC)) do
		if f155_local5.canQuickplay then
			table.insert(f155_local0, f155_local5.id)
		end
	end
	return f155_local0
end
CoD.ZombieUtility.ToggleZMLoadoutPreviewInfo = function(f156_arg0, f156_arg1)
	local f156_local0 = DataSources.DirectorZMLoadoutPreview.getModel(f156_arg0)
	f156_local0.ZMLoadoutPreviewInfoShown:set(f156_arg1)
end
CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement = function(f157_arg0, f157_arg1, f157_arg2)
	local f157_local0 = f157_arg0
	if not f157_arg0:getModel() and f157_arg1:getModel() then
		f157_local0 = f157_arg1
	end
	local f157_local1 = CoD.ZMLoadoutUtility.IsCurrentPreviewClassLocked(f157_local0, f157_arg2)
	local f157_local2 = CoD.SafeGetModelValue(f157_arg1:getModel(), "name")
	if not f157_local2 then
		f157_local2 = CoD.SafeGetModelValue(f157_arg1:getModel(), "displayName")
	end
	if type(f157_local2) == "xhash" then
		f157_local2 = Engine[@"hash_4F9F1239CFD921FE"](f157_local2)
	end
	local f157_local3 = CoD.SafeGetModelValue(f157_arg1:getModel(), "detailedDesc")
	if not f157_local3 then
		f157_local3 = CoD.SafeGetModelValue(f157_arg1:getModel(), "description")
	end
	local f157_local4 = CoD.SafeGetModelValue(f157_arg1:getModel(), "image")
	if not f157_local4 then
		f157_local4 = CoD.SafeGetModelValue(f157_arg1:getModel(), "itemImage")
	end
	local f157_local5 = CoD.SafeGetModelValue(f157_arg1:getModel(), "isRestricted")
	if f157_local1 then
		CoD.ZombieUtility.SetZMLoadoutPreviewInfo("", 0x0, "blacktransparent", f157_arg2, false)
	elseif f157_local2 and f157_local3 and f157_local4 and f157_local5 ~= nil then
		CoD.ZombieUtility.SetZMLoadoutPreviewInfo(f157_local2, f157_local3, f157_local4, f157_arg2, f157_local5)
	end
end
CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex = function(f158_arg0, f158_arg1, f158_arg2, f158_arg3)
	local f158_local0 = CoD.SafeGetModelValue(f158_arg0:getModel(), f158_arg1)
	if f158_local0 then
		local f158_local1 = GetItemNameFromIndex(f158_arg2, f158_local0)
		if type(f158_local1) == "xhash" then
			f158_local1 = Engine[@"hash_4F9F1239CFD921FE"](f158_local1)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfo(f158_local1, GetItemDescFromIndex(f158_arg2, f158_local0), GetItemImageFromIndex(f158_arg2, f158_local0), f158_arg3, false)
	end
end
CoD.ZombieUtility.SetZMLoadoutPreviewInfo = function(f159_arg0, f159_arg1, f159_arg2, f159_arg3, f159_arg4)
	local f159_local0 = DataSources.DirectorZMLoadoutPreview.getModel(f159_arg3)
	if not f159_arg2 or f159_arg2 == 0x0 or f159_arg2 == "blacktransparent" or f159_arg2 == "blacktransparent" then
		f159_local0.ZMLoadoutPreviewInfoShown:set(false)
	else
		f159_local0.ZMLoadoutPreviewInfoShown:set(true)
		f159_local0.ZMLoadoutPreviewItemName:set(f159_arg0)
		f159_local0.ZMLoadoutPreviewItemDesc:set(f159_arg1)
		f159_local0.ZMLoadoutPreviewItemImage:set(f159_arg2)
		f159_local0.ZMLoadoutPreviewItemIsRestricted:set(f159_arg4)
	end
end
CoD.ZombieUtility.ShowZMLoadoutPreviewPrivate = function(f160_arg0)
	CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory(f160_arg0)
	local f160_local0 = DataSources.DirectorZMLoadoutPreview.getModel(f160_arg0)
	f160_local0.ZMLoadoutPreviewWidgetPrivate:set("CoD.ZMLoadoutPreviewFull")
	f160_local0.ZMLoadoutPreviewWidgetShown:set(true)
end
CoD.ZombieUtility.ShowZMLoadoutPreviewPublic = function(f161_arg0)
	CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory(f161_arg0)
	local f161_local0 = DataSources.DirectorZMLoadoutPreview.getModel(f161_arg0)
	f161_local0.ZMLoadoutPreviewWidgetPublic:set("CoD.ZMLoadoutPreviewFull")
	f161_local0.ZMLoadoutPreviewWidgetShown:set(true)
end
CoD.ZombieUtility.ShowZMLoadoutPreviewCustom = function(f162_arg0)
	CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory(f162_arg0)
	local f162_local0 = DataSources.DirectorZMLoadoutPreview.getModel(f162_arg0)
	f162_local0.ZMLoadoutPreviewWidgetCustom:set("CoD.ZMLoadoutPreviewFull")
	f162_local0.ZMLoadoutPreviewWidgetShown:set(true)
end
CoD.ZombieUtility.PlaylistTabSelected = function(f163_arg0, f163_arg1, f163_arg2)
	local f163_local0 = CoD.SafeGetModelValue(f163_arg1:getModel(), "tabID")
	CoD.ZombieUtility.SetPlaylistTab(f163_local0, CoD.SafeGetModelValue(f163_arg1:getModel(), "id"), f163_arg0, f163_arg2)
	CoD.FTUEUtility.ShowZMModeFTUESequenceIfNotSeen(f163_arg0, f163_arg2, f163_local0)
end
CoD.ZombieUtility.SelectDifficulty = function(f164_arg0, f164_arg1)
	local f164_local0 = f164_arg0:getModel(f164_arg1, "difficultyID")
	f164_local0 = f164_local0:get()
	local f164_local1 = Engine.GetGlobalModel()
	f164_local1 = f164_local1:create("ZMLobbyExclusions")
	f164_local1 = f164_local1:create("ZMPrivateDifficulty")
	f164_local1:set(f164_local0)
	if IsLobbyNetworkModeLAN() then
		Engine.SetGametypeSetting("zmDifficulty", f164_local0)
		CoD.ZombieUtility.SetLocalZMDifficultyModel(f164_local0)
		local f164_local2 = Engine[@"lobbygetcontrollinglobbysession"](Enum.LobbyModule[@"lobby_module_host"])
		Engine[@"lobbyevent"]("OnGametypeSettingsChange", {
			lobbyModule = Enum.LobbyModule[@"lobby_module_host"],
			lobbyType = f164_local2,
			fromUI = true,
		})
		Engine[@"lobbyhostsessionsetdirty"](f164_local2, Enum.SessionDirty[@"session_dirty_state"])
	end
end
CoD.ZombieUtility.SetLocalZMDifficultyModel = function(f165_arg0)
	local f165_local0 = Engine.GetGlobalModel()
	f165_local0 = f165_local0:create("localZMDifficulty")
	f165_local0:set(f165_arg0)
end
CoD.ZombieUtility.SetLocalZMTrialVariantModel = function(f166_arg0)
	local f166_local0 = Engine.GetGlobalModel()
	f166_local0 = f166_local0:create("localZMTrialVariant")
	f166_local0:set(f166_arg0)
end
CoD.ZombieUtility.SelectTutorialMapDifficulty = function(f167_arg0, f167_arg1)
	local f167_local0 = Engine.GetGlobalModel()
	f167_local0 = f167_local0:create("lobbyRoot.selectedGameType")
	if f167_local0 and f167_local0:get() == "ztutorial" then
		local f167_local1 = f167_arg0:getModel(f167_arg1, "difficulty")
		if f167_local1 and f167_local1:get() then
			f167_local1 = f167_local1:get()
			if IsLobbyNetworkModeLAN() then
				Engine.SetGametypeSetting("zmDifficulty", f167_local1)
				CoD.ZombieUtility.SetLocalZMDifficultyModel(f167_local1)
				local f167_local2 = Engine[@"lobbygetcontrollinglobbysession"](Enum.LobbyModule[@"lobby_module_host"])
				Engine[@"lobbyevent"]("OnGametypeSettingsChange", {
					lobbyModule = Enum.LobbyModule[@"lobby_module_host"],
					lobbyType = f167_local2,
					fromUI = true,
				})
				Engine[@"lobbyhostsessionsetdirty"](f167_local2, Enum.SessionDirty[@"session_dirty_state"])
			end
		end
	elseif f167_local0 and f167_local0:get() == "ztrials" then
		local f167_local1 = CoD.SafeGetModelValue(f167_arg0:getModel(), "trialVariant")
		if f167_local1 and IsLobbyNetworkModeLAN() then
			Engine.SetGametypeSetting("zmTrialsVariant", f167_local1)
			CoD.ZombieUtility.SetLocalZMTrialVariantModel(f167_local1)
			local f167_local2 = Engine[@"lobbygetcontrollinglobbysession"](Enum.LobbyModule[@"lobby_module_host"])
			Engine[@"lobbyevent"]("OnGametypeSettingsChange", {
				lobbyModule = Enum.LobbyModule[@"lobby_module_host"],
				lobbyType = f167_local2,
				fromUI = true,
			})
			Engine[@"lobbyhostsessionsetdirty"](f167_local2, Enum.SessionDirty[@"session_dirty_state"])
		end
	end
end
CoD.ZombieUtility.SetFocusedPlaylistIDToLobbyPlaylistID = function(f168_arg0)
	local f168_local0 = Engine.GetGlobalModel()
	f168_local0 = f168_local0:create("lobbyRoot.playlistID")
	local f168_local1 = Engine.GetGlobalModel()
	f168_local1 = f168_local1:create("ZMLobbyExclusions.focusedPlaylistID")
	f168_local1:set(f168_local0:get())
	CoD.ZombieUtility.UpdateFocusedPlaylistMapsAndGamemodes(f168_arg0)
end
CoD.ZombieUtility.UpdateFocusedPlaylistID = function(f169_arg0, f169_arg1)
	local f169_local0 = Engine.GetGlobalModel()
	f169_local0 = f169_local0:create("ZMLobbyExclusions.focusedPlaylistID")
	local f169_local1 = f169_arg1:getModel()
	local f169_local2 = f169_local1
	local f169_local3 = f169_local1.playlistID
	if f169_local3 then
		f169_local3 = f169_local2 and f169_local1.playlistID:get()
	end
	if f169_local3 then
		f169_local0:set(f169_local3)
		CoD.ZombieUtility.UpdateFocusedPlaylistMapsAndGamemodes(f169_arg0)
	end
end
CoD.ZombieUtility.UpdateFocusedPlaylistMapsAndGamemodes = function(f170_arg0)
	local f170_local0 = Engine.GetGlobalModel()
	f170_local0 = f170_local0:create("ZMLobbyExclusions.PlaylistMapsString")
	local f170_local1 = Engine.GetGlobalModel()
	f170_local1 = f170_local1:create("ZMLobbyExclusions.PlaylistGamemodesString")
	local f170_local2 = Engine.GetGlobalModel()
	f170_local2 = f170_local2:create("ZMLobbyExclusions.focusedPlaylistID")
	local f170_local3 = f170_local2:get()
	local f170_local4 = {}
	local f170_local5 = {}
	local f170_local6 = {}
	local f170_local7 = {}
	local f170_local8 = Engine[@"getplaylistinfobyid"](f170_local3)
	local f170_local9 = f170_local8.rotationList
	for f170_local10 = 1, #f170_local9, 1 do
		local f170_local13 = f170_local9[f170_local10]
		local f170_local14 = f170_local13.map
		if not CoD.ZombieUtility.ArrayContains(f170_local5, f170_local14) and Engine.IsMapValid(f170_local14) then
			table.insert(f170_local5, f170_local14)
			table.insert(f170_local4, f170_local14)
		end
		local f170_local15 = CoD.ZombieUtility.GetGroupedGameType(f170_local13.gametype, "ztcm")
		if f170_local15 ~= @"zctm" then
			local f170_local16 = Engine[@"hash_1F2CD89B3C345FD3"](f170_local13.gametype)
			f170_local15 = f170_local16.gametype
		end
		if not CoD.ZombieUtility.ArrayContains(f170_local7, f170_local15) then
			table.insert(f170_local7, f170_local15)
			table.insert(f170_local6, f170_local15)
		end
	end
	local f170_local10 = nil
	if f170_local8.isQuickplayCard then
		f170_local10 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_323ED5097167B286")
	else
		for f170_local11 = 1, #f170_local4, 1 do
			local f170_local15 = CoD.MapUtility.GetLocalizedMapValue(f170_local4[f170_local11], "mapName", "")
			local f170_local16
			if f170_local10 then
				f170_local16 = f170_local10 .. ", "
				if not f170_local16 then
				else
					f170_local10 = f170_local16 .. f170_local15
				end
			end
			f170_local16 = ""
		end
	end
	if f170_local10 == nil then
		f170_local10 = ""
	end
	f170_local0:set(f170_local10)
	local f170_local11 = nil
	if f170_local8.isQuickplayCard then
		f170_local11 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_323ED5097167B286")
	else
		for f170_local12 = 1, #f170_local6, 1 do
			local f170_local15 = f170_local6[f170_local12]
			local f170_local16 = nil
			if f170_local15 == "zclassic" then
				f170_local16 = @"hash_F44B71F613A7D65"
			elseif f170_local15 == "zstandard" then
				f170_local16 = @"hash_159DF0D7D85936E1"
			elseif f170_local15 == "ztcm" then
				f170_local16 = @"hash_1F8845568A0DA5AD"
			elseif f170_local15 == "ztrials" then
				f170_local16 = @"hash_65A74962FD2F07DE"
			end
			if f170_local16 ~= nil then
				f170_local16 = Engine[@"hash_4F9F1239CFD921FE"](f170_local16)
				local f170_local18
				if f170_local11 then
					f170_local18 = f170_local11 .. "\n"
					if not f170_local18 then
					else
						f170_local11 = f170_local18 .. f170_local16
					end
				end
				f170_local18 = ""
			end
		end
	end
	f170_local1:set(f170_local11)
end
CoD.ZombieUtility.SubscribeToZMPlaylistInfoModels = function(f171_arg0, f171_arg1)
	local f171_local0 = Engine.GetGlobalModel()
	f171_local0 = f171_local0:create("ZMLobbyExclusions.focusedPlaylistID")
	local f171_local1 = Engine.GetGlobalModel()
	f171_local1 = f171_local1:create("ZMLobbyExclusions.ZMPlaylistTab")
	local f171_local2 = Engine.GetGlobalModel()
	f171_local2 = f171_local2:create("ZMLobbyExclusions.ZMPrivateDifficulty")
	local f171_local3 = function()
		local f172_local0 = f171_local0:get()
		local f172_local1 = f171_local1:get()
		local f172_local2 = f171_local2:get()
		if f172_local0 ~= nil and f172_local1 ~= nil then
			CoD.ZombieUtility.UpdateZMPlaylistInfo(f171_arg1, f172_local0, f172_local1, f172_local2)
		end
	end
	f171_arg0:subscribeToModel(f171_local0, f171_local3, true)
	f171_arg0:subscribeToModel(f171_local1, f171_local3, true)
	f171_arg0:subscribeToModel(f171_local2, f171_local3, true)
end
CoD.ZombieUtility.QuickPlayPregame = function(f173_arg0, f173_arg1)
	local f173_local0 = Engine.CreateModel(Engine.CreateModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot"), "lobbyList"), "playerCount")
	if f173_local0 and f173_local0:get() == 1 then
		local f173_local1 = CoD.ZombieUtility.GetQuickPlayPlaylistID(f173_arg1)
		if f173_local1 ~= -1 then
			Engine[@"setplaylistid"](f173_local1)
			LuaUtils.SetQuickplayPlaylistID(f173_local1)
			Engine[@"lobbyevent"]("OnGameLobbyGameServerDataUpdate", {})
			CoD.DirectorUtility.NavigateToPrivateLobbyForCurrentMode(f173_arg0, f173_arg1)
			local f173_local2 = Engine.GetModel(Engine.GetGlobalModel(), "QuickPlay")
			f173_local2:set(true)
		end
	end
end
CoD.ZombieUtility.QuickPlayPrivate = function(f174_arg0, f174_arg1)
	local f174_local0 = Engine.CreateModel(Engine.CreateModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot"), "lobbyList"), "playerCount")
	if f174_local0 and f174_local0:get() == 1 then
		local f174_local1 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f174_arg1)
		if f174_local1 and f174_local1.extraBools[2] then
			f174_local1.extraBools[2]:set(1)
			CoD.ZombieUtility.InitTutorialQuickPlayModel(f174_arg1)
		end
		CoD.DirectorUtility.SetPlayerReady(f174_arg1)
	end
	local f174_local1 = Engine.GetModel(Engine.GetGlobalModel(), "QuickPlay")
	f174_local1:set(false)
end
CoD.ZombieUtility.ShouldShowPlaylistSelection = function(f175_arg0)
	local f175_local0 = Engine.GetGlobalModel()
	f175_local0 = f175_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	local f175_local1 = f175_local0:get()
	local f175_local2
	if f175_local1 ~= CoD.ZombieUtility.ZMPlaylistTabs.FEATURED and f175_local1 ~= CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC and f175_local1 ~= "ztutorial" then
		f175_local2 = false
	else
		f175_local2 = true
	end
	return f175_local2
end
CoD.ZombieUtility.FeaturedInfo = function()
	local f176_local0 = Engine.GetGlobalModel()
	f176_local0 = f176_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	local f176_local1 = f176_local0:get()
	local f176_local2
	if f176_local1 ~= CoD.ZombieUtility.ZMPlaylistTabs.FEATURED and f176_local1 ~= CoD.ZombieUtility.ZMPlaylistTabs.PUBLIC then
		f176_local2 = false
	else
		f176_local2 = true
	end
	return f176_local2
end
CoD.ZombieUtility.ClassicInfo = function()
	local f177_local0 = Engine.GetGlobalModel()
	f177_local0 = f177_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	return f177_local0:get() == "zclassic"
end
CoD.ZombieUtility.ZombieRushInfo = function()
	local f178_local0 = Engine.GetGlobalModel()
	f178_local0 = f178_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	return f178_local0:get() == "zstandard"
end
CoD.ZombieUtility.TCMInfo = function()
	local f179_local0 = Engine.GetGlobalModel()
	f179_local0 = f179_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	return f179_local0:get() == "ztcm"
end
CoD.ZombieUtility.TrialsInfo = function()
	local f180_local0 = Engine.GetGlobalModel()
	f180_local0 = f180_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	return f180_local0:get() == "ztrials"
end
CoD.ZombieUtility.TutorialInfo = function()
	local f181_local0 = Engine.GetGlobalModel()
	f181_local0 = f181_local0:create("ZMLobbyExclusions.ZMPlaylistTab")
	return f181_local0:get() == "ztutorial"
end
CoD.ZombieUtility.SpecialZombieNotification = function(f182_arg0, f182_arg1, f182_arg2)
	local f182_local0 = CoD.GetScriptNotifyData(f182_arg2)
	f182_arg1:appendNotification({
		clip = "TextAndImageSpecial",
		title = Engine.Localize(Engine.GetIString(f182_local0[2], "CS_LOCALIZED_STRINGS")),
		description = 0x0,
		specialImage = RegisterImage(CoD.ZombieUtility.SpecialZombiesImages[f182_local0[1]] or "blacktransparent"),
	})
end
CoD.ZombieUtility.GetTcmTitle = function(f183_arg0)
	if CoD.ZombieUtility.Tcm.MapNames[f183_arg0] then
		return Engine[@"hash_4F9F1239CFD921FE"](CoD.ZombieUtility.Tcm.MapNames[f183_arg0])
	else
		return ""
	end
end
CoD.ZombieUtility.IsEasterEggsAllowed = function(f184_arg0)
	if Dvar.g_gametype:get() == "zclassic" and CoD.isPublicOnlineGame() and not IsGametypeSettingsValue("zmDifficulty", 0) then
		return true
	else
		return false
	end
end
CoD.ZombieUtility.IsHighestRoundSurvivedGreaterThanOrEqualTo = function(f185_arg0, f185_arg1)
	local f185_local0 = CoD.ZombieUtility.GetZMRoundStats(f185_arg0)
	return f185_arg1 <= f185_local0.highestRoundCompleted
end
CoD.ZombieUtility.IsHighestTrialRoundSurvivedGreaterThanOrEqualTo = function(f186_arg0, f186_arg1)
	local f186_local0 = CoD.ZombieUtility.GetTrialsNameForMap(Engine.IsInGame() and Engine.GetCurrentMap() or CoD.AARUtility.GetCurrentMapName(f186_arg0), Engine.IsInGame() and Engine.GetGametypeSetting("zmtrialsvariant") or CoD.ZombieUtility.GetAARTrialVariant(f186_arg0))
	local f186_local1 = 0
	if not IsLobbyNetworkModeLAN() then
		local f186_local2 = CoD.GetPlayerStats(f186_arg0)
		if f186_local2.PlayerStatsByTrial[f186_local0] then
			f186_local1 = f186_local2.PlayerStatsByTrial[f186_local0].highest_round_reached:get()
		end
	end
	return f186_arg1 <= f186_local1
end
CoD.ZombieUtility.IsSelfModelValueLessThanOrEqualToMapStatVal = function(f187_arg0, f187_arg1, f187_arg2, f187_arg3)
	local f187_local0 = f187_arg0:getModel()
	if f187_arg2 ~= "" and f187_local0 then
		f187_local0 = Engine.GetModel(f187_local0, f187_arg2)
	end
	local f187_local1 = f187_local0 and Engine.GetModelValue(f187_local0)
	local f187_local2
	if f187_local1 == nil or f187_local1 > CoD.ZombieUtility.GetStat(f187_arg1, {
		statName = f187_arg3,
		flags = {
			useStatsByMap = true,
			useStatsByGametype = true,
		},
	}) then
		f187_local2 = false
	else
		f187_local2 = true
	end
	return f187_local2
end
CoD.ZombieUtility.IsSelfModelValueLessThanOrEqualToTrialStatVal = function(f188_arg0, f188_arg1, f188_arg2, f188_arg3)
	local f188_local0 = f188_arg0:getModel()
	if f188_arg2 ~= "" and f188_local0 then
		f188_local0 = Engine.GetModel(f188_local0, f188_arg2)
	end
	local f188_local1 = f188_local0 and Engine.GetModelValue(f188_local0)
	local f188_local2 = CoD.ZombieUtility.GetTrialsNameForMap(Engine.IsInGame() and Engine.GetCurrentMap() or CoD.AARUtility.GetCurrentMapName(f188_arg1), Engine.IsInGame() and Engine.GetGametypeSetting("zmtrialsvariant") or CoD.ZombieUtility.GetAARTrialVariant(f188_arg1))
	local f188_local3 = 0
	if not IsLobbyNetworkModeLAN() then
		local f188_local4 = CoD.GetPlayerStats(f188_arg1)
		if f188_local4.PlayerStatsByTrial[f188_local2] then
			f188_local3 = f188_local4.PlayerStatsByTrial[f188_local2][f188_arg3]:get()
		end
	end
	local f188_local4
	if f188_local1 == nil or f188_local1 > f188_local3 then
		f188_local4 = false
	else
		f188_local4 = true
	end
	return f188_local4
end
CoD.ZombieUtility.GetPositionDraftClient = function(f189_arg0, f189_arg1)
	local f189_local0 = DataSources.PositionDraftClients.getModel(f189_arg0)
	if f189_local0 then
		for f189_local1 = 1, CoD.PlayerRoleUtility.MAX_SUPPORTED_POSITION_DRAFT_CLIENTS, 1 do
			local f189_local4 = f189_local0[f189_local1]
			if f189_local4 then
				local f189_local5 = f189_local4.xuid
				if f189_local5 and f189_local5:get() and f189_local5:get() ~= LuaDefine.INVALID_XUID_X64 and f189_local5:get() == f189_arg1 then
					return f189_local4
				end
			end
		end
	end
	return nil
end
CoD.ZombieUtility.OrderCharacterButtonZMList = function(f190_arg0, f190_arg1, f190_arg2)
	local f190_local0 = Engine.GetGlobalModel()
	f190_local0 = f190_local0:create("MapVote")
	f190_local0 = f190_local0:create("mapVoteMapNext")
	local f190_local1 = f190_local0:get()
	local f190_local2 = {}
	local f190_local3 = {}
	if not f190_local1 then
		return f190_local2
	end
	local f190_local4 = {
		story1 = {
			{
				"niko",
				"Unik",
				"mist",
			},
			{
				"demp",
				"Udem",
				"russ",
			},
			{
				"rich",
				"Uric",
				"stuh",
			},
			{
				"take",
				"Utak",
				"marl",
			},
		},
		[@"story2"] = {
			{
				"scar",
			},
			{
				"brun",
			},
			{
				"shaw",
			},
			{
				"dieg",
			},
		},
		[@"hash_8EF85DD9EA9716E"] = {
			{
				"brig",
			},
			{
				"butl",
			},
			{
				"guns",
			},
			{
				"psyc",
			},
		},
	}
	local f190_local5 = CoD.MapUtility.GetMapValue(f190_local1, @"cast")
	if not f190_local5 or not f190_local4[f190_local5] then
		return f190_local2
	end
	for f190_local17, f190_local18 in ipairs(f190_local4[f190_local5]) do
		for f190_local12, f190_local13 in ipairs(f190_local18) do
			for f190_local9, f190_local10 in ipairs(f190_arg2) do
				if f190_local10.bundle and f190_local13 == f190_local10.bundle[@"chrname"] then
					f190_arg2[f190_local9].order = f190_local17
				end
			end
		end
	end
	for f190_local17, f190_local18 in ipairs(f190_arg2) do
		local f190_local19, f190_local20 = nil
		for f190_local15, f190_local16 in ipairs(f190_arg2) do
			if f190_local16.order == f190_local17 then
				f190_local20 = f190_local16
				f190_local19 = f190_local15
				break
			end
		end
		if not f190_local19 then
			table.insert(f190_local2, 0)
		else
			table.insert(f190_local2, f190_local20)
			table.insert(f190_local3, f190_local19)
		end
	end
	f190_local6 = function(f191_arg0)
		for f191_local3, f191_local4 in ipairs(f190_local3) do
			if f191_arg0 == f191_local4 then
				return true
			end
		end
		return false
	end
	f190_local7 = function()
		for f192_local3, f192_local4 in ipairs(f190_arg2) do
			if not f190_local6(f192_local3) then
				return f192_local3
			end
		end
		return nil
	end
	for f190_local19, f190_local20 in ipairs(f190_local2) do
		if f190_local20 == 0 then
			local f190_local14 = f190_local7()
			if f190_local14 then
				f190_local2[f190_local19] = f190_arg2[f190_local14]
				table.insert(f190_local3, f190_local14)
			end
		end
	end
	return f190_local2
end
CoD.ZombieUtility.SubscribeToLobbyClientInfo = function(f193_arg0, f193_arg1)
	local f193_local0 = Engine.GetGlobalModel()
	f193_local0 = f193_local0.LobbyClients
	if not f193_arg0._lobbyMembersChangedSubscription then
		f193_arg0._lobbyMembersChangedSubscription = f193_arg0:subscribeToModel(f193_local0.membersChanged, function()
			DataSourceHelperRecreate(f193_arg1, "DirectorCharacterButtonZMList")
		end, false)
	end
end
CoD.ZombieUtility.GetShieldIconForCurrentMap = function(f195_arg0)
	return CoD.MapUtility.GetMapValue(Engine.GetCurrentMap(), "shield", "blacktransparent")
end
CoD.ZombieUtility.InitTutorialQuickPlayModel = function(f196_arg0)
	local f196_local0 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f196_arg0)
	local f196_local1 = Engine.GetGlobalModel()
	f196_local1 = f196_local1:create("ZMLobbyExclusions")
	f196_local1 = f196_local1:create("ShowTutorialQuickPlay")
	if f196_local0 and f196_local0.extraBools[2] and f196_local0.extraBools[2]:get() == 0 then
		f196_local1:set(true)
	else
		f196_local1:set(false)
	end
end
CoD.ZombieUtility.IsDoubleNP = function(f197_arg0)
	if CoD.HUDUtility.IsGameTypeEqualToString("ztutorial") and not InFrontend() then
		return false
	end
	local f197_local0 = nil
	if IsPublicOnlineGame() then
		f197_local0 = Engine[@"getplaylistid"]()
	end
	if Engine[@"hash_5F4F47F17B3BDCB3"](f197_arg0, Engine[@"hash_2ACFE452C407B25B"](Enum.eModes.mode_zombies), Enum.eModes.mode_zombies, f197_local0) then
		return true
	end
	local f197_local1 = Engine[@"getdvarint"](@"hash_1624FAAEE3C04F09")
	return f197_local1 and f197_local1 > 1
end
CoD.ZombieUtility.CreateZMDoubleNotification = function(f198_arg0, f198_arg1, f198_arg2)
	local PrematchCountdown2xpNotificationZM = function(f199_arg0, f199_arg1)
		if f199_arg0.PrematchCountdown2xpNotificationZM then
			return false
		end
		local f199_local0 = Engine.GetModelForController(f199_arg1)
		f199_local0 = f199_local0:create("DoubleXpNotification")
		if f199_local0 and f199_local0:get() then
			return false
		elseif not IsLobbyNetworkModeLive() then
			return false
		end
		local f199_local1 = IsDoubleXP(f199_arg1)
		if not f199_local1 then
			f199_local1 = IsDoubleWeaponXP(f199_arg1)
			if not f199_local1 then
				f199_local1 = CoD.ZombieUtility.IsDoubleNP(f199_arg1)
			end
		end
		return f199_local1
	end
	if PrematchCountdown2xpNotificationZM(f198_arg1, f198_arg2) then
		PrematchCountdown2xpNotificationZM = CoD.PrematchCountdown_2xpNotificationZM.new(f198_arg0, f198_arg2, 0.5, 0.5, -200, 200, 0, 0, 0, 255)
		f198_arg1:addElement(PrematchCountdown2xpNotificationZM)
		f198_arg1.PrematchCountdown2xpNotificationZM = PrematchCountdown2xpNotificationZM
		f198_arg0:sendInitializationEvents(f198_arg2, PrematchCountdown2xpNotificationZM)
		LUI.OverrideFunction_CallOriginalSecond(f198_arg1, "close", function(element)
			if element.PrematchCountdown2xpNotificationZM then
				element.PrematchCountdown2xpNotificationZM:close()
			end
		end)
		local f198_local1 = function(f201_arg0)
			f201_arg0:playClip("Notify")
			f201_arg0:registerEventHandler("clip_over", function(element, event)
				local f202_local0 = Engine.GetModelForController(f198_arg2)
				f202_local0 = f202_local0:create("DoubleXpNotification")
				f202_local0:set(true)
				element:close()
			end)
		end
		f198_local1(PrematchCountdown2xpNotificationZM)
	end
end
CoD.ZombieUtility.ResolveInvalidMapGametypeSelection = function(f203_arg0)
	local f203_local0 = Engine.GetGlobalModel()
	f203_local0 = f203_local0:create("lobbyRoot.selectedGameType")
	f203_local0 = f203_local0:get()
	local f203_local1 = Engine[@"converttoxhash"](Engine[@"lobbygetmap"]())
	local f203_local2 = {
		zclassic = @"hash_4B1B381DE2ADC014",
		ztrials = @"hash_37EEA154A1D4F3C1",
		zgrief = 0x4F1EA0CA4EC9E3,
		zstandard = @"hash_5154C514171FEE9",
		ztcm = @"hash_D126B224D84608C",
		ztutorial = @"hash_674923AD245EF8BE",
	}
	local f203_local3 = function(f204_arg0, f204_arg1)
		return CoD.MapUtility.MapsTable[f204_arg0].uniqueID < CoD.MapUtility.MapsTable[f204_arg1].uniqueID
	end
	local f203_local4 = function(f205_arg0)
		if CoD.MapUtility.MapsTable[f205_arg0][f203_local2[f203_local0]] == 1 then
			if f203_local0 == "ztrials" then
				local f205_local0 = CoD.DirectorUtility.TrialsMapEnabledDvars[f205_arg0]
				if f205_local0 and IsBooleanDvarSet(f205_local0) then
					return true
				end
			end
			return false
		else
			return true
		end
	end
	if not f203_local4(f203_local1) then
		for f203_local8, f203_local9 in LUI.IterateTableBySortedKeys(CoD.MapUtility.MapsTable, f203_local3, f203_local4) do
			if f203_local9.mapName ~= nil then
				SetMap(f203_arg0, f203_local9.mapName, false)
				break
			end
		end
	end
end
CoD.ZombieUtility.OpenArmoryAttachmentFromSignatureList = function(f206_arg0, f206_arg1, f206_arg2)
	if f206_arg0.WeaponListWidget and f206_arg0.WeaponListWidget.weaponList and f206_arg1._weaponListElement then
		CoD.ZMLoadoutUtility.OpenArmoryAttachmentOverlay(f206_arg0.WeaponListWidget, f206_arg1._weaponListElement, f206_arg2, f206_arg0)
		PlaySoundAlias("uin_toggle_generic")
	end
end
CoD.ZombieUtility.GauntletMapNameToLocalizedMapDetailedName = function(f207_arg0, f207_arg1, f207_arg2)
	return MapNameToLocalizedMapDetailedName(f207_arg0, CoD.ZombieUtility.GetTrialMapNameFieldName(CoD.SafeGetModelValue(f207_arg1, "trialVariant")), f207_arg2)
end
CoD.ZombieUtility.GauntletMapNameToLocalizedMapDetailedNameIfPurchasable = function(f208_arg0, f208_arg1, f208_arg2)
	return MapNameToLocalizedMapDetailedNameIfPurchasable(f208_arg0, f208_arg1, CoD.ZombieUtility.GetTrialMapNameFieldName(CoD.SafeGetModelValue(f208_arg1, "trialVariant")), f208_arg2)
end
CoD.ZombieUtility.GetTrialMapNameFieldName = function(f209_arg0)
	if not f209_arg0 or f209_arg0 == 0 then
		return @"trialsmapname"
	else
		return @"trialsvariantname" .. f209_arg0
	end
end
CoD.ZombieUtility.LocalizeTrialMapName = function(f210_arg0, f210_arg1)
	local f210_local0 = CoD.MapUtility.GetLocalizedMapValue(f210_arg0, CoD.ZombieUtility.GetTrialMapNameFieldName(f210_arg1), "")
	if f210_local0 and f210_local0 ~= 0x0 then
		return f210_local0
	else
		return 0x0
	end
end
