require("x64:529465f0ae09a3a")
require("x64:34abf3130246ee3")
require("x64:ba1becb5559b00c")
require("x64:893d5763141ed56")
require("x64:6f28821b90063e7")
require("x64:99e7576eaf0080d")
require("x64:e6e998e69bb521f")
require("x64:31f1efc4b4da885")
require("x64:6e1e74cf1a468c")
require("x64:ca56f16edd19c8e")
require("x64:d501b8def8708f0")
require("x64:1091cbae4e762b9")
require("x64:fed80f8bacb80c6")
require("x64:596959cf1a189d1")
CoD.Hud_MP_Codcaster_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.Hud_MP_Codcaster_SafeAreaContainer.__defaultWidth = 1920
CoD.Hud_MP_Codcaster_SafeAreaContainer.__defaultHeight = 1080
CoD.Hud_MP_Codcaster_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_MP_Codcaster_SafeAreaContainer)
	self.id = "Hud_MP_Codcaster_SafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AmmoWidgetContainer = CoD.AmmoWidgetMPContainer.new(f1_arg0, f1_arg1, 1, 1, -590, 0, 1, 1, -149, 37)
	AmmoWidgetContainer:mergeStateConditions({
		{
			stateName = "Visible",
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
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
						and not IsCodCaster(f1_arg1)
					then
						f2_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local ContextNotificationContainer = AmmoWidgetContainer
	local ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	local ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f3_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f4_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f5_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f6_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f7_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f8_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f9_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f10_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f11_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f12_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f13_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f14_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f15_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f16_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f17_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f18_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["factions.isCoDCaster"], function(f19_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["hudItems.playerSpawned"], function(f20_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["hudItems.showSpawnSelect"], function(f21_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = DataSources.CodCaster.getModel(f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents.profileSettingsUpdated, function(f22_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f23_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	ContextNotificationContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = AmmoWidgetContainer.subscribeToModel
	ReadyEvents = Engine[@"getmodelforcontroller"](f1_arg1)
	ContextNotificationSpecialistWeaponHintList(ContextNotificationContainer, ReadyEvents["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]], function(f24_arg0)
		f1_arg0:updateElementState(AmmoWidgetContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"],
		})
	end, false)
	self:addElement(AmmoWidgetContainer)
	self.AmmoWidgetContainer = AmmoWidgetContainer
	ContextNotificationSpecialistWeaponHintList = CoD.ContextNotification_SpecialistWeaponHintList.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 1, 1, -145, -115)
	self:addElement(ContextNotificationSpecialistWeaponHintList)
	self.ContextNotificationSpecialistWeaponHintList = ContextNotificationSpecialistWeaponHintList
	ContextNotificationContainer = CoD.ContextNotificationContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 1, 1, -306, -276)
	self:addElement(ContextNotificationContainer)
	self.ContextNotificationContainer = ContextNotificationContainer
	ReadyEvents = CoD.ReadyEvents.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 1, 1, -433, -253)
	ReadyEvents:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f25_local0 = ReadyEvents
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"killstreak_received") then
			AddKillstreakReceivedNotification(self, f25_local0, f1_arg1, model)
		end
	end)
	self:addElement(ReadyEvents)
	self.ReadyEvents = ReadyEvents
	local EMPWeaponInfo = CoD.EMP_WeaponInfo.new(f1_arg0, f1_arg1, 1, 1, -512, 0, 1, 1, -256, 0)
	self:addElement(EMPWeaponInfo)
	self.EMPWeaponInfo = EMPWeaponInfo
	local VoipContainer0 = CoD.Voip_Container.new(f1_arg0, f1_arg1, 0, 0, 314, 724, 0, 0, 22, 130)
	VoipContainer0:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f26_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f26_local0 then
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
					then
						f26_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
					else
						f26_local0 = false
					end
				end
				return f26_local0
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				local f27_local0 = IsCodCaster(f1_arg1)
				if f27_local0 then
					f27_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_voip_dock", 1)
					if f27_local0 then
						f27_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					end
				end
				return f27_local0
			end,
		},
	})
	local WaypointCloseMessage = VoipContainer0
	local MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	local GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["hudItems.playerSpawned"], function(f28_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f29_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f30_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f31_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f32_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f33_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f34_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f35_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f36_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f37_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f38_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f39_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f40_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f41_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f42_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f43_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f44_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"]], function(f45_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"],
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = Engine[@"getmodelforcontroller"](f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification["factions.isCoDCaster"], function(f46_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	WaypointCloseMessage = VoipContainer0
	MPHardcoreInventoryWidget = VoipContainer0.subscribeToModel
	GameUpdateNotification = DataSources.CodCaster.getModel(f1_arg1)
	MPHardcoreInventoryWidget(WaypointCloseMessage, GameUpdateNotification.profileSettingsUpdated, function(f47_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(VoipContainer0)
	self.VoipContainer0 = VoipContainer0
	MPHardcoreInventoryWidget = CoD.MP_HardcoreInventoryWidget.new(f1_arg0, f1_arg1, 1, 1, -637.5, -520.5, 1, 1, -217, -77)
	self:addElement(MPHardcoreInventoryWidget)
	self.MPHardcoreInventoryWidget = MPHardcoreInventoryWidget
	WaypointCloseMessage = CoD.WaypointCloseMessage.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 0.5, 0.5, -273, -252)
	WaypointCloseMessage.text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	self:addElement(WaypointCloseMessage)
	self.WaypointCloseMessage = WaypointCloseMessage
	GameUpdateNotification = CoD.GameUpdateNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, -250, 250, 0, 0, 202, 250)
	GameUpdateNotification:subscribeToGlobalModel(f1_arg1, "GameUpdateNotification", nil, function(model)
		GameUpdateNotification:setModel(model, f1_arg1)
	end)
	self:addElement(GameUpdateNotification)
	self.GameUpdateNotification = GameUpdateNotification
	local ObituaryCallout = CoD.ObituaryCallout.new(f1_arg0, f1_arg1, 0.5, 0.5, -140, 140, 1, 1, -232, -192)
	self:addElement(ObituaryCallout)
	self.ObituaryCallout = ObituaryCallout
	local AmmoWidgetMPUltimate = CoD.AmmoWidgetMP_Ultimate.new(f1_arg0, f1_arg1, 0.5, 0.5, -134, 134, 1, 1, -122.5, -2.5)
	AmmoWidgetMPUltimate:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f49_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
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
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
						and not IsCodCaster(f1_arg1)
						and not CoD.HUDUtility.IsGameTypeEqualToString("oic")
					then
						f49_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
					else
						f49_local0 = false
					end
				end
				return f49_local0
			end,
		},
	})
	local DeathCamContainer = AmmoWidgetMPUltimate
	local ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	local ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f50_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f51_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f52_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f53_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f54_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f55_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f56_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f56_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f57_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f57_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f58_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f58_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f59_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f59_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f60_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f60_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f61_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f61_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f62_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f62_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f63_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f63_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f64_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f64_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["factions.isCoDCaster"], function(f65_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f65_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["hudItems.playerSpawned"], function(f66_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f66_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f67_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f67_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["hudItems.showSpawnSelect"], function(f68_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f68_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = DataSources.CodCaster.getModel(f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper.profileSettingsUpdated, function(f69_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f69_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f70_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f70_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = Engine[@"getmodelforcontroller"](f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]], function(f71_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f71_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"],
		})
	end, false)
	DeathCamContainer = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = AmmoWidgetMPUltimate.subscribeToModel
	ScrStkContainerWrapper = DataSources.HUDItems.getModel(f1_arg1)
	ObitInfoFeedContainer(DeathCamContainer, ScrStkContainerWrapper.hacked, function(f72_arg0)
		f1_arg0:updateElementState(AmmoWidgetMPUltimate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f72_arg0:get(),
			modelName = "hacked",
		})
	end, false)
	AmmoWidgetMPUltimate:setScale(0.85, 0.85)
	AmmoWidgetMPUltimate:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget2", function(model)
		AmmoWidgetMPUltimate:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPUltimate)
	self.AmmoWidgetMPUltimate = AmmoWidgetMPUltimate
	ObitInfoFeedContainer = CoD.ObitInfoFeedContainer.new(f1_arg0, f1_arg1, 0, 0, 11, 511, 1, 1, -490.5, -130.5)
	ObitInfoFeedContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f74_local0
				if not IsCodCaster(f1_arg1) then
					f74_local0 = not IsGameTypeCombatTraining()
				else
					f74_local0 = false
				end
				return f74_local0
			end,
		},
	})
	ScrStkContainerWrapper = ObitInfoFeedContainer
	DeathCamContainer = ObitInfoFeedContainer.subscribeToModel
	local f1_local15 = Engine[@"getmodelforcontroller"](f1_arg1)
	DeathCamContainer(ScrStkContainerWrapper, f1_local15["factions.isCoDCaster"], function(f75_arg0)
		f1_arg0:updateElementState(ObitInfoFeedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f75_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	ScrStkContainerWrapper = ObitInfoFeedContainer
	DeathCamContainer = ObitInfoFeedContainer.subscribeToModel
	f1_local15 = DataSources.CodCaster.getModel(f1_arg1)
	DeathCamContainer(ScrStkContainerWrapper, f1_local15.profileSettingsUpdated, function(f76_arg0)
		f1_arg0:updateElementState(ObitInfoFeedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f76_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	ScrStkContainerWrapper = ObitInfoFeedContainer
	DeathCamContainer = ObitInfoFeedContainer.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg1)
	DeathCamContainer(ScrStkContainerWrapper, f1_local15["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f77_arg0)
		f1_arg0:updateElementState(ObitInfoFeedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f77_arg0:get(),
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
				local f78_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"])
				if f78_local0 then
					if not CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0) then
						f78_local0 = not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					else
						f78_local0 = false
					end
				end
				return f78_local0
			end,
		},
	})
	f1_local15 = DeathCamContainer
	ScrStkContainerWrapper = DeathCamContainer.subscribeToModel
	local f1_local16 = Engine[@"getmodelforcontroller"](f1_arg1)
	ScrStkContainerWrapper(f1_local15, f1_local16["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f79_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f79_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f1_local15 = DeathCamContainer
	ScrStkContainerWrapper = DeathCamContainer.subscribeToModel
	f1_local16 = Engine[@"getmodelforcontroller"](f1_arg1)
	ScrStkContainerWrapper(f1_local15, f1_local16["hudItems.hacked"], function(f80_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f80_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local15 = DeathCamContainer
	ScrStkContainerWrapper = DeathCamContainer.subscribeToModel
	f1_local16 = Engine[@"getmodelforcontroller"](f1_arg1)
	ScrStkContainerWrapper(f1_local15, f1_local16["hudItems.showSpawnSelect"], function(f81_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f81_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	DeathCamContainer:setAlpha(0)
	self:addElement(DeathCamContainer)
	self.DeathCamContainer = DeathCamContainer
	ScrStkContainerWrapper = CoD.ScrStk_ContainerWrapper.new(f1_arg0, f1_arg1, 1, 1, -156, 7, 1, 1, -393, -131)
	ScrStkContainerWrapper:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f82_local0
				if
					not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
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
				then
					f82_local0 = CoD.BountyHunterUtility.HasBountyStreakOrNotBounty(f1_arg1)
					if f82_local0 then
						f82_local0 = IsPC()
						if f82_local0 then
							if not CoD.HUDUtility.ShouldHideScorestreaks() then
								f82_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_scorestreaks", 1)
								if f82_local0 then
									f82_local0 = not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
								end
							else
								f82_local0 = false
							end
						end
					end
				else
					f82_local0 = false
				end
				return f82_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f83_local0
				if
					not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
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
				then
					f83_local0 = CoD.BountyHunterUtility.HasBountyStreakOrNotBounty(f1_arg1)
					if f83_local0 then
						if not CoD.HUDUtility.ShouldHideScorestreaks() then
							f83_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_scorestreaks", 1)
							if f83_local0 then
								f83_local0 = not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
							end
						else
							f83_local0 = false
						end
					end
				else
					f83_local0 = false
				end
				return f83_local0
			end,
		},
	})
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	local f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["hudItems.showSpawnSelect"], function(f84_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f84_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f85_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f85_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f86_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f86_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f87_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f87_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f88_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f88_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f89_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f89_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f90_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f90_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f91_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f91_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f92_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f92_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f93_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f93_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f94_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f94_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f95_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f95_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f96_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f96_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f97_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f97_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f98_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f98_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f99_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f99_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["killstreaks.killstreak3.rewardAmmo"], function(f100_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f100_arg0:get(),
			modelName = "killstreaks.killstreak3.rewardAmmo",
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f101_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f101_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local15(f1_local16, f1_local17.profileSettingsUpdated, function(f102_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f102_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]], function(f103_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f103_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f104_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f104_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f105_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f105_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local16 = ScrStkContainerWrapper
	f1_local15 = ScrStkContainerWrapper.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["PositionDraft.stage"], function(f106_arg0)
		f1_arg0:updateElementState(ScrStkContainerWrapper, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f106_arg0:get(),
			modelName = "PositionDraft.stage",
		})
	end, false)
	self:addElement(ScrStkContainerWrapper)
	self.ScrStkContainerWrapper = ScrStkContainerWrapper
	self:mergeStateConditions({
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerhud", 1)
			end,
		},
		{
			stateName = "HideForCodCasterEmptyServer",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and ShouldHideCodCasterHud(f1_arg1)
			end,
		},
		{
			stateName = "HideForSpawnSelect",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
			end,
		},
	})
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["factions.isCoDCaster"], function(f110_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f110_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local15(f1_local16, f1_local17.profileSettingsUpdated, function(f111_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f111_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local16, f1_local17["scoreboard.team1.count"], function(f112_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f112_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local16, f1_local17["scoreboard.team2.count"], function(f113_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f113_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local16, f1_local17["hudItems.showSpawnSelect"], function(f114_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f114_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	AmmoWidgetContainer.id = "AmmoWidgetContainer"
	ObituaryCallout.id = "ObituaryCallout"
	ScrStkContainerWrapper.id = "ScrStkContainerWrapper"
	self.__defaultFocus = ScrStkContainerWrapper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	if not IsPC() then
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.ScrStkContainerWrapper)
	end
	return self
end
CoD.Hud_MP_Codcaster_SafeAreaContainer.__resetProperties = function(f115_arg0)
	f115_arg0.VoipContainer0:completeAnimation()
	f115_arg0.AmmoWidgetContainer:completeAnimation()
	f115_arg0.ScrStkContainerWrapper:completeAnimation()
	f115_arg0.AmmoWidgetMPUltimate:completeAnimation()
	f115_arg0.EMPWeaponInfo:completeAnimation()
	f115_arg0.DeathCamContainer:completeAnimation()
	f115_arg0.ObitInfoFeedContainer:completeAnimation()
	f115_arg0.VoipContainer0:setAlpha(1)
	f115_arg0.AmmoWidgetContainer:setAlpha(1)
	f115_arg0.ScrStkContainerWrapper:setAlpha(1)
	f115_arg0.AmmoWidgetMPUltimate:setAlpha(1)
	f115_arg0.EMPWeaponInfo:setAlpha(1)
	f115_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -300, 300)
	f115_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -154.5, 145.5)
	f115_arg0.ObitInfoFeedContainer:setLeftRight(0, 0, 11, 511)
	f115_arg0.ObitInfoFeedContainer:setTopBottom(1, 1, -490.5, -130.5)
end
CoD.Hud_MP_Codcaster_SafeAreaContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f116_arg0, f116_arg1)
			f116_arg0:__resetProperties()
			f116_arg0:setupElementClipCounter(0)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f117_arg0, f117_arg1)
			f117_arg0:__resetProperties()
			f117_arg0:setupElementClipCounter(3)
			f117_arg0.AmmoWidgetContainer:completeAnimation()
			f117_arg0.AmmoWidgetContainer:setAlpha(0)
			f117_arg0.clipFinished(f117_arg0.AmmoWidgetContainer)
			f117_arg0.VoipContainer0:completeAnimation()
			f117_arg0.VoipContainer0:setAlpha(0)
			f117_arg0.clipFinished(f117_arg0.VoipContainer0)
			f117_arg0.ScrStkContainerWrapper:completeAnimation()
			f117_arg0.ScrStkContainerWrapper:setAlpha(0)
			f117_arg0.clipFinished(f117_arg0.ScrStkContainerWrapper)
		end,
	},
	HideForCodCasterEmptyServer = {
		DefaultClip = function(f118_arg0, f118_arg1)
			f118_arg0:__resetProperties()
			f118_arg0:setupElementClipCounter(5)
			f118_arg0.AmmoWidgetContainer:completeAnimation()
			f118_arg0.AmmoWidgetContainer:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.AmmoWidgetContainer)
			f118_arg0.EMPWeaponInfo:completeAnimation()
			f118_arg0.EMPWeaponInfo:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.EMPWeaponInfo)
			f118_arg0.VoipContainer0:completeAnimation()
			f118_arg0.VoipContainer0:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.VoipContainer0)
			f118_arg0.AmmoWidgetMPUltimate:completeAnimation()
			f118_arg0.AmmoWidgetMPUltimate:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.AmmoWidgetMPUltimate)
			f118_arg0.ScrStkContainerWrapper:completeAnimation()
			f118_arg0.ScrStkContainerWrapper:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.ScrStkContainerWrapper)
		end,
	},
	HideForSpawnSelect = {
		DefaultClip = function(f119_arg0, f119_arg1)
			f119_arg0:__resetProperties()
			f119_arg0:setupElementClipCounter(6)
			f119_arg0.AmmoWidgetContainer:completeAnimation()
			f119_arg0.AmmoWidgetContainer:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.AmmoWidgetContainer)
			f119_arg0.VoipContainer0:completeAnimation()
			f119_arg0.VoipContainer0:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.VoipContainer0)
			f119_arg0.AmmoWidgetMPUltimate:completeAnimation()
			f119_arg0.AmmoWidgetMPUltimate:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.AmmoWidgetMPUltimate)
			f119_arg0.ObitInfoFeedContainer:completeAnimation()
			f119_arg0.ObitInfoFeedContainer:setLeftRight(0, 0, 76, 576)
			f119_arg0.ObitInfoFeedContainer:setTopBottom(1, 1, -468, -218)
			f119_arg0.clipFinished(f119_arg0.ObitInfoFeedContainer)
			f119_arg0.DeathCamContainer:completeAnimation()
			f119_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -300, 300)
			f119_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -153.5, 146.5)
			f119_arg0.clipFinished(f119_arg0.DeathCamContainer)
			f119_arg0.ScrStkContainerWrapper:completeAnimation()
			f119_arg0.ScrStkContainerWrapper:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.ScrStkContainerWrapper)
		end,
		DefaultState = function(f120_arg0, f120_arg1)
			f120_arg0:__resetProperties()
			f120_arg0:setupElementClipCounter(6)
			local f120_local0 = function(f121_arg0)
				f120_arg0.AmmoWidgetContainer:beginAnimation(400)
				f120_arg0.AmmoWidgetContainer:registerEventHandler("interrupted_keyframe", f120_arg0.clipInterrupted)
				f120_arg0.AmmoWidgetContainer:registerEventHandler("transition_complete_keyframe", f120_arg0.clipFinished)
			end
			f120_arg0.AmmoWidgetContainer:completeAnimation()
			f120_arg0.AmmoWidgetContainer:setAlpha(0)
			f120_local0(f120_arg0.AmmoWidgetContainer)
			local f120_local1 = function(f122_arg0)
				f120_arg0.VoipContainer0:beginAnimation(400)
				f120_arg0.VoipContainer0:registerEventHandler("interrupted_keyframe", f120_arg0.clipInterrupted)
				f120_arg0.VoipContainer0:registerEventHandler("transition_complete_keyframe", f120_arg0.clipFinished)
			end
			f120_arg0.VoipContainer0:completeAnimation()
			f120_arg0.VoipContainer0:setAlpha(0)
			f120_local1(f120_arg0.VoipContainer0)
			local f120_local2 = function(f123_arg0)
				f120_arg0.AmmoWidgetMPUltimate:beginAnimation(400)
				f120_arg0.AmmoWidgetMPUltimate:registerEventHandler("interrupted_keyframe", f120_arg0.clipInterrupted)
				f120_arg0.AmmoWidgetMPUltimate:registerEventHandler("transition_complete_keyframe", f120_arg0.clipFinished)
			end
			f120_arg0.AmmoWidgetMPUltimate:completeAnimation()
			f120_arg0.AmmoWidgetMPUltimate:setAlpha(0)
			f120_local2(f120_arg0.AmmoWidgetMPUltimate)
			local f120_local3 = function(f124_arg0)
				f120_arg0.ObitInfoFeedContainer:beginAnimation(400)
				f120_arg0.ObitInfoFeedContainer:registerEventHandler("interrupted_keyframe", f120_arg0.clipInterrupted)
				f120_arg0.ObitInfoFeedContainer:registerEventHandler("transition_complete_keyframe", f120_arg0.clipFinished)
			end
			f120_arg0.ObitInfoFeedContainer:completeAnimation()
			f120_arg0.ObitInfoFeedContainer:setLeftRight(0, 0, 76, 576)
			f120_arg0.ObitInfoFeedContainer:setTopBottom(1, 1, -468, -218)
			f120_local3(f120_arg0.ObitInfoFeedContainer)
			local f120_local4 = function(f125_arg0)
				f120_arg0.DeathCamContainer:beginAnimation(400)
				f120_arg0.DeathCamContainer:registerEventHandler("interrupted_keyframe", f120_arg0.clipInterrupted)
				f120_arg0.DeathCamContainer:registerEventHandler("transition_complete_keyframe", f120_arg0.clipFinished)
			end
			f120_arg0.DeathCamContainer:completeAnimation()
			f120_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -300, 300)
			f120_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -153.5, 146.5)
			f120_local4(f120_arg0.DeathCamContainer)
			local f120_local5 = function(f126_arg0)
				f120_arg0.ScrStkContainerWrapper:beginAnimation(400)
				f120_arg0.ScrStkContainerWrapper:registerEventHandler("interrupted_keyframe", f120_arg0.clipInterrupted)
				f120_arg0.ScrStkContainerWrapper:registerEventHandler("transition_complete_keyframe", f120_arg0.clipFinished)
			end
			f120_arg0.ScrStkContainerWrapper:completeAnimation()
			f120_arg0.ScrStkContainerWrapper:setAlpha(0)
			f120_local5(f120_arg0.ScrStkContainerWrapper)
		end,
	},
}
CoD.Hud_MP_Codcaster_SafeAreaContainer.__onClose = function(f127_arg0)
	f127_arg0.AmmoWidgetContainer:close()
	f127_arg0.ContextNotificationSpecialistWeaponHintList:close()
	f127_arg0.ContextNotificationContainer:close()
	f127_arg0.ReadyEvents:close()
	f127_arg0.EMPWeaponInfo:close()
	f127_arg0.VoipContainer0:close()
	f127_arg0.MPHardcoreInventoryWidget:close()
	f127_arg0.WaypointCloseMessage:close()
	f127_arg0.GameUpdateNotification:close()
	f127_arg0.ObituaryCallout:close()
	f127_arg0.AmmoWidgetMPUltimate:close()
	f127_arg0.ObitInfoFeedContainer:close()
	f127_arg0.DeathCamContainer:close()
	f127_arg0.ScrStkContainerWrapper:close()
end
