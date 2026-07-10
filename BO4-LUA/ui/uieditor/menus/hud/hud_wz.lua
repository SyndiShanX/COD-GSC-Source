require("x64:d4ed3fd8d1fcc4a")
require("x64:2675595fa323085")
require("x64:a5a237b6384eb7")
require("x64:ba717ae8e378ed5")
require("x64:692fa98381d81d1")
require("x64:7c5a5334738ad1e")
require("x64:59adac4746a97e8")
require("x64:3ee697ffd3e0c9e")
require("x64:1091cbae4e762b9")
require("x64:b4608168bbee1cb")
require("x64:7bf7c90da429cca")
require("x64:13012bca0fbd2f4")
require("x64:794f27988d07830")
require("x64:c0887595cfb6bb1")
local f0_local0 = function(f1_arg0, f1_arg1)
	if IsSplitscreenAndInGame() then
		local f1_local0, f1_local1, f1_local2, f1_local3 = Engine[@"getusersafeareaforcontroller"](f1_arg1, true)
		f1_arg0.CalloutItems.BGDarkening:setLeftRight(false, false, f1_local0 * 1.5, f1_local2 * 1.5)
		f1_arg0.CalloutItems.BGDarkening:setTopBottom(false, false, f1_local1 * 1.5, f1_local3 * 1.5)
	end
	if IsDemoPlaying() then
		ReplaceElementWithFake(f1_arg0, "emptyFocusable")
	end
end
CoD.Hud_WZ = InheritFrom(CoD.Menu)
LUI.createMenu.Hud_WZ = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("Hud_WZ", f2_arg0)
	local f2_local1 = self
	if IsPC() then
		DisableAutoButtonCallback(f2_local1, self, f2_arg0)
		CoD.BaseUtility.InitControllerModelIfNotSet(f2_arg0, "hudItems.warzone.aarVisible", false)
		CoD.BaseUtility.InitControllerModelIfNotSet(f2_arg0, "hudItems.warzone.aarViewed", false)
	else
		CoD.BaseUtility.InitControllerModelIfNotSet(f2_arg0, "hudItems.warzone.aarVisible", false)
		CoD.BaseUtility.InitControllerModelIfNotSet(f2_arg0, "hudItems.warzone.aarViewed", false)
	end
	self:setUseCylinderMapping(true)
	self:setClass(CoD.Hud_WZ)
	self.soundSet = "HUD"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	f2_local1:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f2_local1, f2_arg0, 0, 0, 1920, 1970, 0, 0, 968, 1018)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local HudWZSafeAreaContainer = CoD.Hud_WZ_SafeAreaContainer.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(HudWZSafeAreaContainer)
	self.HudWZSafeAreaContainer = HudWZSafeAreaContainer
	local ReadyEvents = CoD.ReadyEvents.new(f2_local1, f2_arg0, 0.5, 0.5, -300, 300, 1, 1, -267, -87)
	ReadyEvents:setAlpha(0)
	ReadyEvents:subscribeToGlobalModel(f2_arg0, "PerController", "scriptNotify", function(model)
		local f3_local0 = ReadyEvents
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hero_weapon_received") then
			AddHeroAbilityReceivedNotification(self, f3_local0, f2_arg0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"killstreak_received") then
			AddKillstreakReceivedNotification(self, f3_local0, f2_arg0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"levelup") then
			AddSlotUnlockedNotification(self, f3_local0, f2_arg0, model)
		end
	end)
	self:addElement(ReadyEvents)
	self.ReadyEvents = ReadyEvents
	local fullscreenContainer = CoD.DynamicContainerWidget.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(fullscreenContainer)
	self.fullscreenContainer = fullscreenContainer
	local MPDamageFeedback0 = CoD.MPDamageFeedback.new(f2_local1, f2_arg0, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	MPDamageFeedback0:subscribeToGlobalModel(f2_arg0, "CurrentWeapon", nil, function(model)
		MPDamageFeedback0:setModel(model, f2_arg0)
	end)
	self:addElement(MPDamageFeedback0)
	self.MPDamageFeedback0 = MPDamageFeedback0
	local IngameChatClientContainer = nil
	IngameChatClientContainer = CoD.IngameChatClientContainer.new(f2_local1, f2_arg0, 0, 0, 0, 540, 0.42, 0.42, -4, 286)
	self:addElement(IngameChatClientContainer)
	self.IngameChatClientContainer = IngameChatClientContainer
	local MPObjectiveNotificationWidget = CoD.MP_ObjectiveNotificationWidget.new(f2_local1, f2_arg0, 0.5, 0.5, -960, 960, 0, 0, 54, 326)
	MPObjectiveNotificationWidget:mergeStateConditions({
		{
			stateName = "ShowNotification",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ShowNotificationDefenders",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	MPObjectiveNotificationWidget:subscribeToGlobalModel(f2_arg0, "PerController", "gametypeObjective", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			MPObjectiveNotificationWidget.GameTypeText:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(MPObjectiveNotificationWidget)
	self.MPObjectiveNotificationWidget = MPObjectiveNotificationWidget
	local GameEndScoreWZ = CoD.GameEndScore_WZ.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(GameEndScoreWZ)
	self.GameEndScoreWZ = GameEndScoreWZ
	local ScoreboardWidget = CoD.ScoreboardWidgetWZ.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ScoreboardWidget)
	self.ScoreboardWidget = ScoreboardWidget
	local MPHintTextContainer = CoD.MPHintTextContainer.new(f2_local1, f2_arg0, 0.5, 0.5, -864, 864, 1, 1, -272, -233)
	MPHintTextContainer:mergeStateConditions({
		{
			stateName = "display_noblink",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueNonEmptyString(f2_arg0, "MPHintText")
			end,
		},
	})
	local PCNotifContainer = MPHintTextContainer
	local SpraysAndGestures = MPHintTextContainer.subscribeToModel
	local CalloutItems = Engine[@"getmodelforcontroller"](f2_arg0)
	SpraysAndGestures(PCNotifContainer, CalloutItems.MPHintText, function(f9_arg0)
		f2_local1:updateElementState(MPHintTextContainer, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f9_arg0:get(),
			modelName = "MPHintText",
		})
	end, false)
	MPHintTextContainer:subscribeToGlobalModel(f2_arg0, "PerController", "MPHintText", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			MPHintTextContainer.MPHintText:setText(CoD.BaseUtility.AlreadyLocalized(f10_local0))
		end
	end)
	self:addElement(MPHintTextContainer)
	self.MPHintTextContainer = MPHintTextContainer
	SpraysAndGestures = CoD.MPSpraysAndGestures.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SpraysAndGestures:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f11_local0 = CoD.HUDUtility.IsSpraysAndGesturesButtonHeld(f2_arg0)
				if f11_local0 then
					if
						not CoD.HUDUtility.HideWheelInPrematch(f2_arg0)
						and not CoD.ModelUtility.IsClientModelValueTrue(f2_arg0, "isInLastStand")
						and not CoD.WZUtility.IsQuickInventoryOpen(f2_arg0)
						and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f2_arg0, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_player_dead"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
						and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					then
						f11_local0 = not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
					else
						f11_local0 = false
					end
				end
				return f11_local0
			end,
		},
	})
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	local FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["ButtonBits.actionSlots.Sprays_Boasts"], function(f12_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f12_arg0:get(),
			modelName = "ButtonBits.actionSlots.Sprays_Boasts",
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["hudItems.PCWheels.sprayGestureWheelKeyPressed"], function(f13_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f13_arg0:get(),
			modelName = "hudItems.PCWheels.sprayGestureWheelKeyPressed",
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["hudItems.PCWheels.calloutWheelKeyPressed"], function(f14_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f14_arg0:get(),
			modelName = "hudItems.PCWheels.calloutWheelKeyPressed",
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f2_arg0))
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer.isInLastStand, function(f15_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f15_arg0:get(),
			modelName = "isInLastStand",
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["hudItems.inventory.open"], function(f16_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f16_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = DataSources.MultiItemPickup.getModel(f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer.status, function(f17_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f17_arg0:get(),
			modelName = "status",
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f18_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f19_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_missile"]], function(f20_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_missile"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f21_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]], function(f22_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f23_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f24_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f25_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	CalloutItems = SpraysAndGestures
	PCNotifContainer = SpraysAndGestures.subscribeToModel
	FrontendBattlenetContainer = Engine[@"getmodelforcontroller"](f2_arg0)
	PCNotifContainer(CalloutItems, FrontendBattlenetContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f26_arg0)
		f2_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	self:addElement(SpraysAndGestures)
	self.SpraysAndGestures = SpraysAndGestures
	PCNotifContainer = nil
	PCNotifContainer = CoD.PC_Notif_Container.new(f2_local1, f2_arg0, 0.5, 0.5, 470, 920, 0, 0, 106, 206)
	self:addElement(PCNotifContainer)
	self.PCNotifContainer = PCNotifContainer
	CalloutItems = CoD.MPCalloutItems.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	CalloutItems:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f27_local0 = CoD.HUDUtility.IsCalloutsButtonPressed(f2_arg0)
				if f27_local0 then
					f27_local0 = CoD.HUDUtility.EnableCalloutWheel()
					if f27_local0 then
						if not CoD.HUDUtility.HideWheelInPrematch(f2_arg0) and not IsInTheaterMode() and not CoD.ModelUtility.IsClientModelValueTrue(f2_arg0, "isInLastStand") and not CoD.WZUtility.IsQuickInventoryOpen(f2_arg0) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f2_arg0, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"]) and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) and not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) then
							f27_local0 = not Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
						else
							f27_local0 = false
						end
					end
				end
				return f27_local0
			end,
		},
	})
	local f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	local f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["ButtonBits.actionSlots.Flourish_Callouts"], function(f28_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f28_arg0:get(),
			modelName = "ButtonBits.actionSlots.Flourish_Callouts",
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["hudItems.PCWheels.calloutWheelKeyPressed"], function(f29_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f29_arg0:get(),
			modelName = "hudItems.PCWheels.calloutWheelKeyPressed",
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["hudItems.PCWheels.sprayGestureWheelKeyPressed"], function(f30_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f30_arg0:get(),
			modelName = "hudItems.PCWheels.sprayGestureWheelKeyPressed",
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getglobalmodel"]()
	FrontendBattlenetContainer(f2_local16, f2_local17["lobbyRoot.lobbyNav"], function(f31_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f31_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f2_arg0))
	FrontendBattlenetContainer(f2_local16, f2_local17.isInLastStand, function(f32_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f32_arg0:get(),
			modelName = "isInLastStand",
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["hudItems.inventory.open"], function(f33_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f33_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = DataSources.MultiItemPickup.getModel(f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17.status, function(f34_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f34_arg0:get(),
			modelName = "status",
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f35_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f35_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f36_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f37_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f37_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f2_local16 = CalloutItems
	FrontendBattlenetContainer = CalloutItems.subscribeToModel
	f2_local17 = Engine[@"getmodelforcontroller"](f2_arg0)
	FrontendBattlenetContainer(f2_local16, f2_local17["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f38_arg0)
		f2_local1:updateElementState(CalloutItems, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	self:addElement(CalloutItems)
	self.CalloutItems = CalloutItems
	FrontendBattlenetContainer = nil
	FrontendBattlenetContainer = CoD.FrontendBattlenetContainer.new(f2_local1, f2_arg0, 0.5, 0.5, -795.5, -359.5, 1, 1, -841, -61)
	self:addElement(FrontendBattlenetContainer)
	self.FrontendBattlenetContainer = FrontendBattlenetContainer
	self:mergeStateConditions({
		{
			stateName = "HideAllButScoreboard",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f2_arg0, Enum[@"uivisibilitybit"][@"bit_stage_ended"])
			end,
		},
		{
			stateName = "SpeedBoost",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "playerAbilities.playerGadget2.id", "gadget_speed_burst") and CoD.ModelUtility.IsModelValueEqualToEnum(f2_arg0, "playerAbilities.playerGadget2.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
			end,
		},
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f2_arg0) and IsCodCasterProfileValueEqualTo(f2_arg0, "shoutcaster_qs_playerhud", 1)
			end,
		},
	})
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	local f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_stage_ended"]], function(f42_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f42_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_stage_ended"],
		})
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["playerAbilities.playerGadget2.id"], function(f43_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f43_arg0:get(),
			modelName = "playerAbilities.playerGadget2.id",
		})
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["playerAbilities.playerGadget2.state"], function(f44_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f44_arg0:get(),
			modelName = "playerAbilities.playerGadget2.state",
		})
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["factions.isCoDCaster"], function(f45_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f45_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = DataSources.CodCaster.getModel(f2_arg0)
	f2_local16(f2_local17, f2_local18.profileSettingsUpdated, function(f46_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f46_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f47_arg0, f47_arg1)
		CoD.Menu.UpdateButtonShownState(f47_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f48_arg0, f48_arg1)
		CoD.Menu.UpdateButtonShownState(f48_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f48_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f48_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]], function(f49_arg0, f49_arg1)
		CoD.Menu.UpdateButtonShownState(f49_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f49_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f50_arg0, f50_arg1)
		CoD.Menu.UpdateButtonShownState(f50_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f50_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f50_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f51_arg0, f51_arg1)
		CoD.Menu.UpdateButtonShownState(f51_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f51_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f52_arg0, f52_arg1)
		CoD.Menu.UpdateButtonShownState(f52_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f52_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
		CoD.Menu.UpdateButtonShownState(f52_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f52_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f53_arg0, f53_arg1)
		CoD.Menu.UpdateButtonShownState(f53_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f53_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f54_arg0, f54_arg1)
		CoD.Menu.UpdateButtonShownState(f54_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f54_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["hudItems.lastStand.progress"], function(f55_arg0, f55_arg1)
		CoD.Menu.UpdateButtonShownState(f55_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f55_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["hudItems.lastStand.beingRevived"], function(f56_arg0, f56_arg1)
		CoD.Menu.UpdateButtonShownState(f56_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f56_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["hudItems.inventory.canUseQuickInventory"], function(f57_arg0, f57_arg1)
		CoD.Menu.UpdateButtonShownState(f57_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["vehicle.hidePlayerInfo"], function(f58_arg0, f58_arg1)
		CoD.Menu.UpdateButtonShownState(f58_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_up"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["hudItems.inventory.open"], function(f59_arg0, f59_arg1)
		CoD.Menu.UpdateButtonShownState(f59_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_down"])
		CoD.Menu.UpdateButtonShownState(f59_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f59_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f59_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f59_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(f59_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getglobalmodel"]()
	f2_local16(f2_local17, f2_local18["lobbyRoot.lobbyNav"], function(f60_arg0, f60_arg1)
		CoD.Menu.UpdateButtonShownState(f60_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = DataSources.WarzoneInventory.getModel(f2_arg0)
	f2_local16(f2_local17, f2_local18.isOpen, function(f61_arg0, f61_arg1)
		CoD.Menu.UpdateButtonShownState(f61_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["gameScore.currentState"], function(f62_arg0, f62_arg1)
		CoD.Menu.UpdateButtonShownState(f62_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f62_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f62_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["hudItems.warzone.aarViewed"], function(f63_arg0, f63_arg1)
		CoD.Menu.UpdateButtonShownState(f63_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f63_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f63_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f64_arg0, f64_arg1)
		CoD.Menu.UpdateButtonShownState(f64_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["huditems.warzone.aarVisible"], function(f65_arg0, f65_arg1)
		CoD.Menu.UpdateButtonShownState(f65_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	self:appendEventHandler("input_source_changed", function(f66_arg0, f66_arg1)
		f66_arg1.menu = f66_arg1.menu or f2_local1
		CoD.Menu.UpdateButtonShownState(f66_arg0, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f66_arg0, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18.LastInput, function(f67_arg0, f67_arg1)
		CoD.Menu.UpdateButtonShownState(f67_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f67_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = DataSources.HUDItems.getModel(f2_arg0)
	f2_local16(f2_local17, f2_local18.aliveTeammateCount, function(f68_arg0, f68_arg1)
		CoD.Menu.UpdateButtonShownState(f68_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f68_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["gameScore.hasPlayedDeathCam"], function(f69_arg0, f69_arg1)
		CoD.Menu.UpdateButtonShownState(f69_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f69_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f70_arg0, f70_arg1)
		CoD.Menu.UpdateButtonShownState(f70_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f70_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getglobalmodel"]()
	f2_local16(f2_local17, f2_local18["storageGlobalRoot.user_settings"], function(f71_arg0, f71_arg1)
		CoD.Menu.UpdateButtonShownState(f71_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f71_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f71_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f71_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(f71_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local17 = self
	f2_local16 = self.subscribeToModel
	f2_local18 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local16(f2_local17, f2_local18.PlayerSettingsUpdate, function(f72_arg0, f72_arg1)
		CoD.Menu.UpdateButtonShownState(f72_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f72_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f72_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f72_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(f72_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) then
			CoD.ScoreboardUtility.HideScoreboard(menu, controller)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_back"], nil, function(element, menu, controller, model)
		if CoD.ScoreboardUtility.CanHideScoreboard(controller) then
			CoD.ScoreboardUtility.HideScoreboard(menu, controller)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ScoreboardUtility.CanHideScoreboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_up"], nil, function(element, menu, controller, model)
		if not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(controller, "hudItems.lastStand") and CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.canUseQuickInventory") and not CoD.ModelUtility.IsModelValueTrue(controller, "vehicle.hidePlayerInfo") and not IsGametypeSettingsValue("wzDisableQuickEquipUI", 1) then
			CoD.WZUtility.OpenQuickAccessInventory(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(controller, "hudItems.lastStand") and CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.canUseQuickInventory") and not CoD.ModelUtility.IsModelValueTrue(controller, "vehicle.hidePlayerInfo") and not IsGametypeSettingsValue("wzDisableQuickEquipUI", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_up"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_down"], nil, function(element, menu, controller, model)
		if not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(controller, "hudItems.lastStand") and CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") then
			CoD.WZUtility.CloseQuickAccessInventory(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(controller, "hudItems.lastStand") and CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_down"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_none"], "weapnext", function(element, menu, controller, model)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.WZUtility.NextWeapon(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "weapnext")
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_none"], "weapprev", function(element, menu, controller, model)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.WZUtility.PrevWeapon(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "weapprev")
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_none"], "weapswitchprimary", function(element, menu, controller, model)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.WZUtility.SwitchToWeaponInSlot(controller, 0)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "weapswitchprimary")
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_none"], "weapswitchsecondary", function(element, menu, controller, model)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.WZUtility.SwitchToWeaponInSlot(controller, 1)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and CoD.WZUtility.IsInventoryOpen(controller) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "weapswitchsecondary")
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not IsDemoPlaying() then
			SetControllerModelValue(controller, "huditems.warzone.aarVisible", false)
			LockInput(self, controller, false)
			SetAllowCursorMovement(menu, false)
			SendMenuResponse(self, "GameEndScore", "skip_deathcam", controller)
			CoD.GameEndScoreUtility.ClearTransition(controller)
			SetFocusToElement(self, "emptyFocusablePC", controller)
			CoD.LobbyUtility.SetPlayerLocation(controller, Enum[@"hash_C0AB9543C5C440B"][@"hash_49B478094C85DBBB"])
			CoD.PCWidgetUtility.CloseChat(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"ui/spectate", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_contextual_3", function(element, menu, controller, model)
		if IsPC() and CoD.ModelUtility.IsModelValueTrue(controller, "huditems.warzone.aarVisible") and IsOnlineGame() and IsBooleanDvarSet("ui_showWZAAR") and not IsElementInState(self.GameEndScoreWZ, "EliminationPC") and not CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) then
			SetControllerModelValue(controller, "huditems.warzone.aarVisible", false)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.ModelUtility.IsModelValueTrue(controller, "huditems.warzone.aarVisible") and IsOnlineGame() and IsBooleanDvarSet("ui_showWZAAR") and not IsElementInState(self.GameEndScoreWZ, "EliminationPC") and not CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_4B914F387B0A33A9", nil, "ui_contextual_3")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_contextual_1", function(element, menu, controller, model)
		if IsPC() and IsMouseOrKeyboard(controller) and CoD.GameEndScoreUtility.CanShowWarzoneKillcam(controller) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and not IsDemoPlaying() and not IsInDefaultState(self.GameEndScoreWZ) and CoD.GameEndScoreUtility.HasViewedInGameReport(controller) then
			LockInput(self, controller, false)
			SetAllowCursorMovement(menu, false)
			SendMenuResponse(self, "GameEndScore", "play_deathcam", controller)
			SetControllerModelValue(controller, "gameScore.hasPlayedDeathCam", true)
			PlaySoundAlias("uin_killcam_start")
			CoD.BaseUtility.PlayMusic("death")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and IsMouseOrKeyboard(controller) and CoD.GameEndScoreUtility.CanShowWarzoneKillcam(controller) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and not IsDemoPlaying() and not IsInDefaultState(self.GameEndScoreWZ) and CoD.GameEndScoreUtility.HasViewedInGameReport(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"wz/deathcam", nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_lb"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_lb"]) then
			CoD.WZUtility.CycleHealthQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_lb"]) then
			CoD.WZUtility.CycleEquipmentQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_lb"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, nil)
			return false
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_lb"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_rb"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_rb"]) then
			CoD.WZUtility.CycleHealthQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_rb"]) then
			CoD.WZUtility.CycleEquipmentQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_rb"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, nil)
			return false
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_rb"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.WZUtility.CycleHealthQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.WZUtility.CycleEquipmentQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
			return false
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.WZUtility.CycleHealthQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.WZUtility.CycleEquipmentQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, nil)
			return false
		elseif CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonUseEquipment(controller, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_xba_pscross"]) then
			CoD.WZUtility.CycleHealthQuickAccessInventory(menu, controller, model)
			BlockGameFromKeyEvent(controller)
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.GameEndScoreUtility.CanShowWarzoneKillcam(controller) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and not IsDemoPlaying() and not IsInDefaultState(self.GameEndScoreWZ) and CoD.GameEndScoreUtility.HasViewedInGameReport(controller) then
			LockInput(self, controller, false)
			SetAllowCursorMovement(menu, false)
			SendMenuResponse(self, "GameEndScore", "play_deathcam", controller)
			SetControllerModelValue(controller, "gameScore.hasPlayedDeathCam", true)
			PlaySoundAlias("uin_killcam_start")
			CoD.BaseUtility.PlayMusic("death")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.inventory.open") and CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1) and CoD.OptionsUtility.IsButtonHeal(controller, Enum[@"luibutton"][@"lui_key_xba_pscross"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		elseif IsPC() and IsGamepad(controller) and CoD.GameEndScoreUtility.CanShowWarzoneKillcam(controller) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and not IsDemoPlaying() and not IsInDefaultState(self.GameEndScoreWZ) and CoD.GameEndScoreUtility.HasViewedInGameReport(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_lstick_pressed"], "ui_remove", function(element, menu, controller, model)
		if IsPC() and CanReportPlayerEndGameWarzone(self, controller) and not IsElementInState(self.GameEndScoreWZ, "DefaultState") then
			ShowReportPlayerDialogTargetingKiller(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CanReportPlayerEndGameWarzone(self, controller) and not IsElementInState(self.GameEndScoreWZ, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lstick_pressed"], @"menu/report_player", nil, "ui_remove")
			return true
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f2_arg0, "PerController", "huditems.inventory.canUseQuickInventory", function(model)
		local f107_local0 = self
		if not CoD.ModelUtility.IsModelValueTrue(f2_arg0, "hudItems.inventory.canUseQuickInventory") and CoD.WZUtility.IsQuickInventoryOpen(f2_arg0) then
			CoD.WZUtility.CloseQuickAccessInventory(f2_local1, f2_arg0)
		end
	end)
	self:subscribeToGlobalModel(f2_arg0, "PerController", "scriptNotify", function(model)
		local f108_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"character_unlock_update") then
			CoD.WZUtility.UpdateUnlockQuestState(f2_arg0, model)
		end
	end)
	emptyFocusable.id = "emptyFocusable"
	HudWZSafeAreaContainer.id = "HudWZSafeAreaContainer"
	if CoD.isPC then
		IngameChatClientContainer.id = "IngameChatClientContainer"
	end
	GameEndScoreWZ.id = "GameEndScoreWZ"
	ScoreboardWidget:setModel(self.buttonModel, f2_arg0)
	ScoreboardWidget.id = "ScoreboardWidget"
	if CoD.isPC then
		SpraysAndGestures.id = "SpraysAndGestures"
	end
	if CoD.isPC then
		PCNotifContainer.id = "PCNotifContainer"
	end
	if CoD.isPC then
		CalloutItems.id = "CalloutItems"
	end
	if CoD.isPC then
		FrontendBattlenetContainer.id = "FrontendBattlenetContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if f0_local0 then
		f0_local0(self, f2_arg0)
	end
	f2_local16 = self
	if IsPC() then
		SetProperty(self, "preserveLuiButton", {
			[Enum[@"luibutton"][@"lui_key_back"]] = true,
		})
		SetAllowCursorMovement(f2_local1, false)
		CoD.HUDUtility.SetupGrenadeWarningIndicators(self, f2_arg0)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.GameEndScoreWZ)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.HudWZSafeAreaContainer)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.ScoreboardWidget)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.emptyFocusable)
		CoD.PCKoreaUtility.StartKoreaIndulgenceChecks(self)
		SizeToHudArea(self.MPHintTextContainer, f2_arg0)
		SizeToHudArea(self.MPObjectiveNotificationWidget, f2_arg0)
		SizeToHudArea(self.IngameChatClientContainer, f2_arg0)
		SizeToHudArea(self.ReadyEvents, f2_arg0)
	else
		SetProperty(self, "preserveLuiButton", {
			[Enum[@"luibutton"][@"lui_key_back"]] = true,
		})
		SetAllowCursorMovement(f2_local1, false)
		CoD.HUDUtility.SetupGrenadeWarningIndicators(self, f2_arg0)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.GameEndScoreWZ)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.HudWZSafeAreaContainer)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.ScoreboardWidget)
		SetProperty(self, "disableKeyboardNavigation", true)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.emptyFocusable)
		CoD.HUDUtility.SetupWZArmbladeReticles(self, f2_arg0)
	end
	return self
end
CoD.Hud_WZ.__resetProperties = function(f109_arg0)
	f109_arg0.ReadyEvents:completeAnimation()
	f109_arg0.ReadyEvents:setAlpha(0)
end
CoD.Hud_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f110_arg0, f110_arg1)
			f110_arg0:__resetProperties()
			f110_arg0:setupElementClipCounter(0)
		end,
	},
	HideAllButScoreboard = {
		DefaultClip = function(f111_arg0, f111_arg1)
			f111_arg0:__resetProperties()
			f111_arg0:setupElementClipCounter(1)
			f111_arg0.ReadyEvents:completeAnimation()
			f111_arg0.ReadyEvents:setAlpha(0)
			f111_arg0.clipFinished(f111_arg0.ReadyEvents)
		end,
	},
	SpeedBoost = {
		DefaultClip = function(f112_arg0, f112_arg1)
			f112_arg0:__resetProperties()
			f112_arg0:setupElementClipCounter(0)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f113_arg0, f113_arg1)
			f113_arg0:__resetProperties()
			f113_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Hud_WZ.__onClose = function(f114_arg0)
	f114_arg0.emptyFocusable:close()
	f114_arg0.HudWZSafeAreaContainer:close()
	f114_arg0.ReadyEvents:close()
	f114_arg0.fullscreenContainer:close()
	f114_arg0.MPDamageFeedback0:close()
	f114_arg0.IngameChatClientContainer:close()
	f114_arg0.MPObjectiveNotificationWidget:close()
	f114_arg0.GameEndScoreWZ:close()
	f114_arg0.ScoreboardWidget:close()
	f114_arg0.MPHintTextContainer:close()
	f114_arg0.SpraysAndGestures:close()
	f114_arg0.PCNotifContainer:close()
	f114_arg0.CalloutItems:close()
	f114_arg0.FrontendBattlenetContainer:close()
end
