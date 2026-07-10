require("x64:4f48b2a3318365e")
require("x64:529465f0ae09a3a")
require("x64:34abf3130246ee3")
require("x64:cd5cb173216cc96")
require("x64:17046c31fdd4246")
require("x64:ba1becb5559b00c")
require("x64:603d4f08148b9bb")
require("x64:2c2bec7a9db1e9f")
require("x64:893d5763141ed56")
require("x64:6f28821b90063e7")
require("x64:99e7576eaf0080d")
require("x64:e6e998e69bb521f")
require("x64:31f1efc4b4da885")
require("x64:d667965a2409a7e")
require("x64:dec58b7dad03016")
require("x64:6e1e74cf1a468c")
require("x64:a6cc1001a20fa8e")
require("x64:ca56f16edd19c8e")
require("x64:d501b8def8708f0")
require("x64:1091cbae4e762b9")
require("x64:fed80f8bacb80c6")
require("x64:596959cf1a189d1")
CoD.Hud_MP_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.Hud_MP_SafeAreaContainer.__defaultWidth = 1920
CoD.Hud_MP_SafeAreaContainer.__defaultHeight = 1080
CoD.Hud_MP_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_MP_SafeAreaContainer)
	self.id = "Hud_MP_SafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScoreInfo = CoD.ScoreInfoContainer.new(f1_arg0, f1_arg1, 0, 0, 39, 249, 0, 0, 349, 452)
	ScoreInfo:mergeStateConditions({
		{
			stateName = "VisibleSpawnSelect",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f2_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
						and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					then
						f2_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
						if f2_local0 then
							f2_local0 = not IsGameTypeCombatTraining()
						end
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f3_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
						and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					then
						f3_local0 = not IsGameTypeCombatTraining()
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
	})
	local PlayerWidgetContainer = ScoreInfo
	local AmmoWidgetContainer = ScoreInfo.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f4_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f5_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f6_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f7_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f8_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f9_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f10_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f11_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f12_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f13_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f14_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f15_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f16_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f17_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f18_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["factions.isCoDCaster"], function(f19_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["hudItems.playerSpawned"], function(f20_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f21_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f22_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"]], function(f23_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"],
		})
	end, false)
	PlayerWidgetContainer = ScoreInfo
	AmmoWidgetContainer = ScoreInfo.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	AmmoWidgetContainer(PlayerWidgetContainer, f1_local4["hudItems.showSpawnSelect"], function(f24_arg0)
		f1_arg0:updateElementState(ScoreInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	self:addElement(ScoreInfo)
	self.ScoreInfo = ScoreInfo
	AmmoWidgetContainer = CoD.AmmoWidgetMPContainer.new(f1_arg0, f1_arg1, 1, 1, -590, 0, 1, 1, -158.5, 27.5)
	AmmoWidgetContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f25_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f25_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
						and not IsCodCaster(f1_arg1)
					then
						f25_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
					else
						f25_local0 = false
					end
				end
				return f25_local0
			end,
		},
	})
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	local ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f26_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f27_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f28_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f29_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f30_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f31_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f32_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f33_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f34_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f35_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f36_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f37_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f38_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f39_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f40_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f41_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["factions.isCoDCaster"], function(f42_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["hudItems.playerSpawned"], function(f43_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["hudItems.showSpawnSelect"], function(f44_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = DataSources.CodCaster.getModel(f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC.profileSettingsUpdated, function(f45_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f46_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local4 = AmmoWidgetContainer
	PlayerWidgetContainer = AmmoWidgetContainer.subscribeToModel
	ContextNotificationSpecialistWeaponHintListPC = Engine[@"getmodelforcontroller"](f1_arg1)
	PlayerWidgetContainer(f1_local4, ContextNotificationSpecialistWeaponHintListPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]], function(f47_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"],
		})
	end, false)
	self:addElement(AmmoWidgetContainer)
	self.AmmoWidgetContainer = AmmoWidgetContainer
	PlayerWidgetContainer = CoD.PlayerWidgetContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -143, 43)
	PlayerWidgetContainer:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f48_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f48_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and not IsCodCaster(f1_arg1)
					then
						f48_local0 = IsPC()
						if f48_local0 then
							f48_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
						end
					else
						f48_local0 = false
					end
				end
				return f48_local0
			end,
		},
		{
			stateName = "VisibleCenteredByAbility",
			condition = function(menu, element, event)
				local f49_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "HUDItems", "abilityHintIndex", CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_RADIATION_FIELD)
				if f49_local0 then
					f49_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
					if f49_local0 then
						if
							not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
							and not IsCodCaster(f1_arg1)
						then
							f49_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
						else
							f49_local0 = false
						end
					end
				end
				return f49_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f50_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f50_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and not IsCodCaster(f1_arg1)
					then
						f50_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
					else
						f50_local0 = false
					end
				end
				return f50_local0
			end,
		},
	})
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	local ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f51_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f52_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f53_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f54_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f55_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f56_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f56_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f57_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f57_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f58_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f58_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f59_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f59_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f60_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f60_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f61_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f61_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f62_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f62_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f63_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f63_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f64_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f64_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f65_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f65_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f66_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f66_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["factions.isCoDCaster"], function(f67_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f67_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["hudItems.playerSpawned"], function(f68_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f68_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["hudItems.showSpawnSelect"], function(f69_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f69_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer.abilityHintIndex, function(f70_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f70_arg0:get(),
			modelName = "abilityHintIndex",
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f71_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f71_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	ContextNotificationSpecialistWeaponHintListPC = PlayerWidgetContainer
	f1_local4 = PlayerWidgetContainer.subscribeToModel
	ContextNotificationContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(ContextNotificationSpecialistWeaponHintListPC, ContextNotificationContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"]], function(f72_arg0)
		f1_arg0:updateElementState(PlayerWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f72_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"],
		})
	end, false)
	self:addElement(PlayerWidgetContainer)
	self.PlayerWidgetContainer = PlayerWidgetContainer
	f1_local4 = nil
	self.ContextNotificationSpecialistWeaponHintList = LUI.UIElement.createFake()
	ContextNotificationSpecialistWeaponHintListPC = nil
	ContextNotificationSpecialistWeaponHintListPC = CoD.ContextNotification_SpecialistWeaponHintList.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 1, 1, -174, -144)
	self:addElement(ContextNotificationSpecialistWeaponHintListPC)
	self.ContextNotificationSpecialistWeaponHintListPC = ContextNotificationSpecialistWeaponHintListPC
	ContextNotificationContainer = CoD.ContextNotificationContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 1, 1, -306, -276)
	self:addElement(ContextNotificationContainer)
	self.ContextNotificationContainer = ContextNotificationContainer
	local ReadyEvents = CoD.ReadyEvents.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 1, 1, -433, -253)
	ReadyEvents:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f73_local0 = ReadyEvents
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"killstreak_received") then
			AddKillstreakReceivedNotification(self, f73_local0, f1_arg1, model)
		end
	end)
	self:addElement(ReadyEvents)
	self.ReadyEvents = ReadyEvents
	local EMPScoreInfo = CoD.EMP_ScoreInfo.new(f1_arg0, f1_arg1, 0, 0, -10, 502, 1, 1, -110, 146)
	self:addElement(EMPScoreInfo)
	self.EMPScoreInfo = EMPScoreInfo
	local EMPWeaponInfo = CoD.EMP_WeaponInfo.new(f1_arg0, f1_arg1, 1, 1, -502, 10, 1, 1, -270, -14)
	self:addElement(EMPWeaponInfo)
	self.EMPWeaponInfo = EMPWeaponInfo
	local VoipContainer0 = CoD.Voip_Container.new(f1_arg0, f1_arg1, 0, 0, 314, 724, 0, 0, 22, 130)
	VoipContainer0:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f74_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f74_local0 then
					if
						Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_compass_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f74_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
					else
						f74_local0 = false
					end
				end
				return f74_local0
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				local f75_local0 = IsCodCaster(f1_arg1)
				if f75_local0 then
					f75_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_voip_dock", 1)
					if f75_local0 then
						f75_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					end
				end
				return f75_local0
			end,
		},
	})
	local WaypointCloseMessage = VoipContainer0
	local MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	local GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["hudItems.playerSpawned"], function(f76_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f76_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"]], function(f77_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f77_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f78_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f78_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f79_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f79_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f80_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f80_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f81_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f81_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f82_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f82_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f83_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f83_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f84_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f84_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f85_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f85_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f86_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f86_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f87_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f87_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f88_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f88_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f89_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f89_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f90_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f90_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"]], function(f91_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f91_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["factions.isCoDCaster"], function(f92_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f92_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = DataSources.CodCaster.getModel(f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification.profileSettingsUpdated, function(f93_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f93_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(VoipContainer0)
	self.VoipContainer0 = VoipContainer0
	MPHardcoreInventoryWidget = CoD.MP_HardcoreInventoryWidget.new(f1_arg0, f1_arg1, 1, 1, -637.5, -520.5, 1, 1, -217, -77)
	self:addElement(MPHardcoreInventoryWidget)
	self.MPHardcoreInventoryWidget = MPHardcoreInventoryWidget
	WaypointCloseMessage = CoD.WaypointCloseMessage.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 0, 0, 267, 288)
	WaypointCloseMessage.text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	self:addElement(WaypointCloseMessage)
	self.WaypointCloseMessage = WaypointCloseMessage
	GameUpdateNotification = CoD.GameUpdateNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, -250, 250, 0, 0, 294, 342)
	GameUpdateNotification:subscribeToGlobalModel(f1_arg1, "GameUpdateNotification", nil, function(model)
		GameUpdateNotification:setModel(model, f1_arg1)
	end)
	self:addElement(GameUpdateNotification)
	self.GameUpdateNotification = GameUpdateNotification
	local ObituaryCallout = CoD.ObituaryCallout.new(f1_arg0, f1_arg1, 0.5, 0.5, -140, 140, 1, 1, -237, -197)
	self:addElement(ObituaryCallout)
	self.ObituaryCallout = ObituaryCallout
	local AmmoWidgetMPUltimate = CoD.AmmoWidgetMP_Ultimate.new(f1_arg0, f1_arg1, 0.5, 0.5, -134, 134, 1, 1, -122.5, -2.5)
	AmmoWidgetMPUltimate:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f95_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f95_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
						and not IsCodCaster(f1_arg1)
						and not CoD.HUDUtility.IsGameTypeEqualToString("oic")
					then
						f95_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
					else
						f95_local0 = false
					end
				end
				return f95_local0
			end,
		},
	})
	local DeathCamContainer = AmmoWidgetMPUltimate
	local ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	local ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f96_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f96_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f97_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f97_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f98_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f98_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f99_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f99_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f100_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f100_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f101_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f101_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f102_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f102_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f103_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f103_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f104_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f104_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f105_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f105_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f106_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f106_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f107_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f107_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f108_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f108_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f109_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f109_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f110_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f110_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["factions.isCoDCaster"], function(f111_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f111_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["hudItems.playerSpawned"], function(f112_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f112_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f113_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f113_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["hudItems.showSpawnSelect"], function(f114_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f114_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = DataSources.CodCaster.getModel(f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper.profileSettingsUpdated, function(f115_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f115_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f116_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f116_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]], function(f117_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f117_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = DataSources.HUDItems.getModel(f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper.hacked, function(f118_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f118_arg0:get(),
			modelName = "hacked",
		})
	end, false)
	AmmoWidgetMPUltimate:setScale(0.85, 0.85)
	AmmoWidgetMPUltimate:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget2", function(model)
		AmmoWidgetMPUltimate:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPUltimate)
	self.AmmoWidgetMPUltimate = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = CoD.ObitInfoFeedContainer.new(f1_arg0, f1_arg1, 0, 0, 4, 504, 1, 1, -485.5, -125.5)
	ObitInfoFeedContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f120_local0
				if not IsCodCaster(f1_arg1) then
					f120_local0 = not IsGameTypeCombatTraining()
				else
					f120_local0 = false
				end
				return f120_local0
			end,
		},
	})
	ScrStkContainerWrapper = ObitInfoFeedContainer
	DeathCamContainer = ObitInfoFeedContainer.subscribeToModel
	local CombatTrainingGameTimer = Engine[@"getmodelforcontroller"](f1_arg1)
	DeathCamContainer(ScrStkContainerWrapper, CombatTrainingGameTimer["factions.isCoDCaster"], function(f121_arg0)
		f1_arg0:updateElementState(ObitInfoFeedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f121_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	ScrStkContainerWrapper = ObitInfoFeedContainer
	DeathCamContainer = ObitInfoFeedContainer.subscribeToModel
	CombatTrainingGameTimer = DataSources.CodCaster.getModel(f1_arg1)
	DeathCamContainer(ScrStkContainerWrapper, CombatTrainingGameTimer.profileSettingsUpdated, function(f122_arg0)
		f1_arg0:updateElementState(ObitInfoFeedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f122_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	ScrStkContainerWrapper = ObitInfoFeedContainer
	DeathCamContainer = ObitInfoFeedContainer.subscribeToModel
	CombatTrainingGameTimer = Engine[@"getmodelforcontroller"](f1_arg1)
	DeathCamContainer(ScrStkContainerWrapper, CombatTrainingGameTimer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f123_arg0)
		f1_arg0:updateElementState(ObitInfoFeedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f123_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	self:addElement(ObitInfoFeedContainer)
	self.ObitInfoFeedContainer = ObitInfoFeedContainer
	DeathCamContainer = CoD.DeathCamContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.85, 0.85, -154.5, 145.5)
	DeathCamContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f124_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"])
				if f124_local0 then
					if not CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0) then
						f124_local0 = not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					else
						f124_local0 = false
					end
				end
				return f124_local0
			end,
		},
	})
	CombatTrainingGameTimer = DeathCamContainer
	ScrStkContainerWrapper = DeathCamContainer.subscribeToModel
	local FastLoadoutContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ScrStkContainerWrapper(CombatTrainingGameTimer, FastLoadoutContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f125_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f125_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	CombatTrainingGameTimer = DeathCamContainer
	ScrStkContainerWrapper = DeathCamContainer.subscribeToModel
	FastLoadoutContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ScrStkContainerWrapper(CombatTrainingGameTimer, FastLoadoutContainer["hudItems.hacked"], function(f126_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f126_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	CombatTrainingGameTimer = DeathCamContainer
	ScrStkContainerWrapper = DeathCamContainer.subscribeToModel
	FastLoadoutContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ScrStkContainerWrapper(CombatTrainingGameTimer, FastLoadoutContainer["hudItems.showSpawnSelect"], function(f127_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f127_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	DeathCamContainer:setAlpha(0)
	self:addElement(DeathCamContainer)
	self.DeathCamContainer = DeathCamContainer
	ScrStkContainerWrapper = CoD.ScrStk_ContainerWrapper.new(f1_arg0, f1_arg1, 1, 1, -156, 7, 1, 1, -393, -131)
	self:addElement(ScrStkContainerWrapper)
	self.ScrStkContainerWrapper = ScrStkContainerWrapper
	CombatTrainingGameTimer = CoD.CombatTrainingGameTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0.5, 0.5, -495.5, -430.5)
	self:addElement(CombatTrainingGameTimer)
	self.CombatTrainingGameTimer = CombatTrainingGameTimer
	FastLoadoutContainer = CoD.FastLoadoutContainer.new(f1_arg0, f1_arg1, 1, 1, -380, 0, 1, 1, -181, -81)
	self:addElement(FastLoadoutContainer)
	self.FastLoadoutContainer = FastLoadoutContainer
	local CompassGroupContainer = CoD.CompassGroupMPContainerTransition.new(f1_arg0, f1_arg1, 0, 0, -31, 319, 0, 0, 1, 351)
	CompassGroupContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f128_local0
				if
					Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_compass_visible"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
					and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
				then
					f128_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
				else
					f128_local0 = false
				end
				return f128_local0
			end,
		},
	})
	local IcePickHacked = CompassGroupContainer
	local VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	local SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f129_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f129_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f130_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f130_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f131_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f131_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f132_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f132_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f133_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f133_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f134_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f134_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f135_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f135_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f136_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f136_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f137_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f137_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f138_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f138_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f139_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f139_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f140_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f140_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f141_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f141_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f142_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f142_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f143_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f143_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f144_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f144_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["factions.isCoDCaster"], function(f145_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f145_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["hudItems.playerSpawned"], function(f146_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f146_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"]], function(f147_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f147_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f148_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f148_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f149_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f149_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	IcePickHacked = CompassGroupContainer
	VoipContainerNoCompass = CompassGroupContainer.subscribeToModel
	SpawnBeaconDeathCam = Engine[@"getmodelforcontroller"](f1_arg1)
	VoipContainerNoCompass(IcePickHacked, SpawnBeaconDeathCam["hudItems.showSpawnSelect"], function(f150_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f150_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	self:addElement(CompassGroupContainer)
	self.CompassGroupContainer = CompassGroupContainer
	VoipContainerNoCompass = CoD.Voip_Container.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 22, 130)
	VoipContainerNoCompass:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f151_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f151_local0 then
					if
						Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_compass_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
					then
						f151_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						if f151_local0 then
						else
							return f151_local0
						end
					end
					f151_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
				end
				return f151_local0
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	local f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["hudItems.playerSpawned"], function(f153_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f153_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"]], function(f154_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f154_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f155_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f155_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f156_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f156_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f157_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f157_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f158_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f158_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f159_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f159_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f160_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f160_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f161_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f161_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f162_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f162_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f163_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f163_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f164_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f164_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f165_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f165_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f166_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f166_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	SpawnBeaconDeathCam = VoipContainerNoCompass
	IcePickHacked = VoipContainerNoCompass.subscribeToModel
	f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	IcePickHacked(SpawnBeaconDeathCam, f1_local25["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f167_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f167_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	self:addElement(VoipContainerNoCompass)
	self.VoipContainerNoCompass = VoipContainerNoCompass
	IcePickHacked = CoD.IcePickHacked.new(f1_arg0, f1_arg1, 0.5, 0.5, -160, 160, 0, 0, 737, 837)
	self:addElement(IcePickHacked)
	self.IcePickHacked = IcePickHacked
	SpawnBeaconDeathCam = CoD.SpawnBeaconDeathCam.new(f1_arg0, f1_arg1, 0.5, 0.5, -90, 90, 1, 1, -262, -227)
	self:addElement(SpawnBeaconDeathCam)
	self.SpawnBeaconDeathCam = SpawnBeaconDeathCam
	self:mergeStateConditions({
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerhud", 1)
			end,
		},
		{
			stateName = "HideForSpawnSelect",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
			end,
		},
	})
	local f1_local26 = self
	f1_local25 = self.subscribeToModel
	local f1_local27 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local25(f1_local26, f1_local27["factions.isCoDCaster"], function(f170_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f170_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local26 = self
	f1_local25 = self.subscribeToModel
	f1_local27 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local25(f1_local26, f1_local27.profileSettingsUpdated, function(f171_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f171_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local26 = self
	f1_local25 = self.subscribeToModel
	f1_local27 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local25(f1_local26, f1_local27["hudItems.showSpawnSelect"], function(f172_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f172_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	ScoreInfo.id = "ScoreInfo"
	AmmoWidgetContainer.id = "AmmoWidgetContainer"
	ObituaryCallout.id = "ObituaryCallout"
	ScrStkContainerWrapper.id = "ScrStkContainerWrapper"
	if CoD.isPC then
		FastLoadoutContainer.id = "FastLoadoutContainer"
	end
	self.__defaultFocus = ScrStkContainerWrapper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local25 = self
	if not IsPC() then
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.ScrStkContainerWrapper)
	end
	return self
end
CoD.Hud_MP_SafeAreaContainer.__resetProperties = function(f173_arg0)
	f173_arg0.VoipContainer0:completeAnimation()
	f173_arg0.AmmoWidgetContainer:completeAnimation()
	f173_arg0.ScoreInfo:completeAnimation()
	f173_arg0.PlayerWidgetContainer:completeAnimation()
	f173_arg0.DeathCamContainer:completeAnimation()
	f173_arg0.AmmoWidgetMPUltimate:completeAnimation()
	f173_arg0.CompassGroupContainer:completeAnimation()
	f173_arg0.ObitInfoFeedContainer:completeAnimation()
	f173_arg0.ScrStkContainerWrapper:completeAnimation()
	f173_arg0.VoipContainer0:setAlpha(1)
	f173_arg0.AmmoWidgetContainer:setAlpha(1)
	f173_arg0.ScoreInfo:setAlpha(1)
	f173_arg0.PlayerWidgetContainer:setLeftRight(0, 1, 0, 0)
	f173_arg0.PlayerWidgetContainer:setTopBottom(1, 1, -143, 43)
	f173_arg0.PlayerWidgetContainer:setAlpha(1)
	f173_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -300, 300)
	f173_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -154.5, 145.5)
	f173_arg0.AmmoWidgetMPUltimate:setAlpha(1)
	f173_arg0.CompassGroupContainer:setAlpha(1)
	f173_arg0.ObitInfoFeedContainer:setLeftRight(0, 0, 4, 504)
	f173_arg0.ObitInfoFeedContainer:setTopBottom(1, 1, -485.5, -125.5)
	f173_arg0.ScrStkContainerWrapper:setAlpha(1)
end
CoD.Hud_MP_SafeAreaContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f174_arg0, f174_arg1)
			f174_arg0:__resetProperties()
			f174_arg0:setupElementClipCounter(0)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f175_arg0, f175_arg1)
			f175_arg0:__resetProperties()
			f175_arg0:setupElementClipCounter(3)
			f175_arg0.ScoreInfo:completeAnimation()
			f175_arg0.ScoreInfo:setAlpha(0)
			f175_arg0.clipFinished(f175_arg0.ScoreInfo)
			f175_arg0.AmmoWidgetContainer:completeAnimation()
			f175_arg0.AmmoWidgetContainer:setAlpha(0)
			f175_arg0.clipFinished(f175_arg0.AmmoWidgetContainer)
			f175_arg0.VoipContainer0:completeAnimation()
			f175_arg0.VoipContainer0:setAlpha(0)
			f175_arg0.clipFinished(f175_arg0.VoipContainer0)
		end,
	},
	HideForSpawnSelect = {
		DefaultClip = function(f176_arg0, f176_arg1)
			f176_arg0:__resetProperties()
			f176_arg0:setupElementClipCounter(9)
			f176_arg0.ScoreInfo:completeAnimation()
			f176_arg0.ScoreInfo:setAlpha(0)
			f176_arg0.clipFinished(f176_arg0.ScoreInfo)
			f176_arg0.AmmoWidgetContainer:completeAnimation()
			f176_arg0.AmmoWidgetContainer:setAlpha(0)
			f176_arg0.clipFinished(f176_arg0.AmmoWidgetContainer)
			f176_arg0.PlayerWidgetContainer:completeAnimation()
			f176_arg0.PlayerWidgetContainer:setLeftRight(0, 0, 0, 597)
			f176_arg0.PlayerWidgetContainer:setTopBottom(1, 1, -170, 16)
			f176_arg0.PlayerWidgetContainer:setAlpha(0)
			f176_arg0.clipFinished(f176_arg0.PlayerWidgetContainer)
			f176_arg0.VoipContainer0:completeAnimation()
			f176_arg0.VoipContainer0:setAlpha(0)
			f176_arg0.clipFinished(f176_arg0.VoipContainer0)
			f176_arg0.AmmoWidgetMPUltimate:completeAnimation()
			f176_arg0.AmmoWidgetMPUltimate:setAlpha(0)
			f176_arg0.clipFinished(f176_arg0.AmmoWidgetMPUltimate)
			f176_arg0.ObitInfoFeedContainer:completeAnimation()
			f176_arg0.ObitInfoFeedContainer:setLeftRight(0, 0, 76, 576)
			f176_arg0.ObitInfoFeedContainer:setTopBottom(1, 1, -468, -218)
			f176_arg0.clipFinished(f176_arg0.ObitInfoFeedContainer)
			f176_arg0.DeathCamContainer:completeAnimation()
			f176_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -300, 300)
			f176_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -153.5, 146.5)
			f176_arg0.clipFinished(f176_arg0.DeathCamContainer)
			f176_arg0.ScrStkContainerWrapper:completeAnimation()
			f176_arg0.ScrStkContainerWrapper:setAlpha(0)
			f176_arg0.clipFinished(f176_arg0.ScrStkContainerWrapper)
			f176_arg0.CompassGroupContainer:completeAnimation()
			f176_arg0.CompassGroupContainer:setAlpha(0)
			f176_arg0.clipFinished(f176_arg0.CompassGroupContainer)
		end,
		DefaultState = function(f177_arg0, f177_arg1)
			f177_arg0:__resetProperties()
			f177_arg0:setupElementClipCounter(9)
			local f177_local0 = function(f178_arg0)
				f177_arg0.ScoreInfo:beginAnimation(400)
				f177_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.ScoreInfo:completeAnimation()
			f177_arg0.ScoreInfo:setAlpha(0)
			f177_local0(f177_arg0.ScoreInfo)
			local f177_local1 = function(f179_arg0)
				f177_arg0.AmmoWidgetContainer:beginAnimation(400)
				f177_arg0.AmmoWidgetContainer:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.AmmoWidgetContainer:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.AmmoWidgetContainer:completeAnimation()
			f177_arg0.AmmoWidgetContainer:setAlpha(0)
			f177_local1(f177_arg0.AmmoWidgetContainer)
			local f177_local2 = function(f180_arg0)
				f177_arg0.PlayerWidgetContainer:beginAnimation(400)
				f177_arg0.PlayerWidgetContainer:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.PlayerWidgetContainer:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.PlayerWidgetContainer:completeAnimation()
			f177_arg0.PlayerWidgetContainer:setLeftRight(0, 0, 0, 597)
			f177_arg0.PlayerWidgetContainer:setTopBottom(1, 1, -170, 16)
			f177_arg0.PlayerWidgetContainer:setAlpha(0)
			f177_local2(f177_arg0.PlayerWidgetContainer)
			local f177_local3 = function(f181_arg0)
				f177_arg0.VoipContainer0:beginAnimation(400)
				f177_arg0.VoipContainer0:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.VoipContainer0:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.VoipContainer0:completeAnimation()
			f177_arg0.VoipContainer0:setAlpha(0)
			f177_local3(f177_arg0.VoipContainer0)
			local f177_local4 = function(f182_arg0)
				f177_arg0.AmmoWidgetMPUltimate:beginAnimation(400)
				f177_arg0.AmmoWidgetMPUltimate:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.AmmoWidgetMPUltimate:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.AmmoWidgetMPUltimate:completeAnimation()
			f177_arg0.AmmoWidgetMPUltimate:setAlpha(0)
			f177_local4(f177_arg0.AmmoWidgetMPUltimate)
			local f177_local5 = function(f183_arg0)
				f177_arg0.ObitInfoFeedContainer:beginAnimation(400)
				f177_arg0.ObitInfoFeedContainer:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.ObitInfoFeedContainer:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.ObitInfoFeedContainer:completeAnimation()
			f177_arg0.ObitInfoFeedContainer:setLeftRight(0, 0, 76, 576)
			f177_arg0.ObitInfoFeedContainer:setTopBottom(1, 1, -468, -218)
			f177_local5(f177_arg0.ObitInfoFeedContainer)
			local f177_local6 = function(f184_arg0)
				f177_arg0.DeathCamContainer:beginAnimation(400)
				f177_arg0.DeathCamContainer:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.DeathCamContainer:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.DeathCamContainer:completeAnimation()
			f177_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -300, 300)
			f177_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -153.5, 146.5)
			f177_local6(f177_arg0.DeathCamContainer)
			local f177_local7 = function(f185_arg0)
				f177_arg0.ScrStkContainerWrapper:beginAnimation(400)
				f177_arg0.ScrStkContainerWrapper:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.ScrStkContainerWrapper:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.ScrStkContainerWrapper:completeAnimation()
			f177_arg0.ScrStkContainerWrapper:setAlpha(0)
			f177_local7(f177_arg0.ScrStkContainerWrapper)
			local f177_local8 = function(f186_arg0)
				f177_arg0.CompassGroupContainer:beginAnimation(400)
				f177_arg0.CompassGroupContainer:registerEventHandler("interrupted_keyframe", f177_arg0.clipInterrupted)
				f177_arg0.CompassGroupContainer:registerEventHandler("transition_complete_keyframe", f177_arg0.clipFinished)
			end
			f177_arg0.CompassGroupContainer:completeAnimation()
			f177_arg0.CompassGroupContainer:setAlpha(0)
			f177_local8(f177_arg0.CompassGroupContainer)
		end,
	},
}
CoD.Hud_MP_SafeAreaContainer.__onClose = function(f187_arg0)
	f187_arg0.ScoreInfo:close()
	f187_arg0.AmmoWidgetContainer:close()
	f187_arg0.PlayerWidgetContainer:close()
	f187_arg0.ContextNotificationSpecialistWeaponHintList:close()
	f187_arg0.ContextNotificationSpecialistWeaponHintListPC:close()
	f187_arg0.ContextNotificationContainer:close()
	f187_arg0.ReadyEvents:close()
	f187_arg0.EMPScoreInfo:close()
	f187_arg0.EMPWeaponInfo:close()
	f187_arg0.VoipContainer0:close()
	f187_arg0.MPHardcoreInventoryWidget:close()
	f187_arg0.WaypointCloseMessage:close()
	f187_arg0.GameUpdateNotification:close()
	f187_arg0.ObituaryCallout:close()
	f187_arg0.AmmoWidgetMPUltimate:close()
	f187_arg0.ObitInfoFeedContainer:close()
	f187_arg0.DeathCamContainer:close()
	f187_arg0.ScrStkContainerWrapper:close()
	f187_arg0.CombatTrainingGameTimer:close()
	f187_arg0.FastLoadoutContainer:close()
	f187_arg0.CompassGroupContainer:close()
	f187_arg0.VoipContainerNoCompass:close()
	f187_arg0.IcePickHacked:close()
	f187_arg0.SpawnBeaconDeathCam:close()
end
