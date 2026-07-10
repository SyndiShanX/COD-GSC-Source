require("x64:d4ed3fd8d1fcc4a")
require("x64:484d96d72e020cb")
require("x64:84edea6058974e3")
require("x64:ba717ae8e378ed5")
require("x64:692fa98381d81d1")
require("x64:7c5a5334738ad1e")
require("x64:59adac4746a97e8")
require("x64:42130825ee4aad2")
require("x64:a4d62339ab35bca")
require("x64:b4608168bbee1cb")
require("x64:da54af56b1dee1f")
require("x64:13012bca0fbd2f4")
require("x64:794f27988d07830")
require("x64:c0887595cfb6bb1")
CoD.Hud_MP = InheritFrom(CoD.Menu)
LUI.createMenu.Hud_MP = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Hud_MP", f1_arg0)
	local f1_local1 = self
	if IsPC() then
		CoD.PCKoreaUtility.StartKoreaIndulgenceChecks(self)
	end
	self:setUseCylinderMapping(true)
	self:setClass(CoD.Hud_MP)
	self.soundSet = "HUD"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local HudMPSafeAreaContainer = CoD.Hud_MP_SafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	HudMPSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToHudArea(element, f1_arg0)
		elseif not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(HudMPSafeAreaContainer)
	self.HudMPSafeAreaContainer = HudMPSafeAreaContainer
	local MPScore = CoD.MPScr.new(f1_local1, f1_arg0, 0.5, 0.5, 84, 234, 0, 0, 492, 530)
	MPScore:subscribeToGlobalModel(f1_arg0, "PerController", "scriptNotify", function(model)
		local f3_local0 = MPScore
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"score_event") and CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg0) then
			SetElementProperty(f1_local1, "_ignoreNextMoneyChange", true)
			SetMPScoreText(f1_local1, f3_local0, f1_arg0, model)
			PlayClipOnElement(self, {
				elementName = "MPScore",
				clipName = "BountyCash",
			}, f1_arg0)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"score_event") and IsSpecificGadgetInUse(f1_arg0, f3_local0, "gadget_combat_efficiency") and not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg0) then
			PlayClipOnElement(self, {
				elementName = "MPScore",
				clipName = "CombatEfficiencyScore",
			}, f1_arg0)
			SetMPScoreText(f1_local1, f3_local0, f1_arg0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"score_event") and not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg0) then
			PlayClipOnElement(self, {
				elementName = "MPScore",
				clipName = "NormalScore",
			}, f1_arg0)
			SetMPScoreText(f1_local1, f3_local0, f1_arg0, model)
		end
	end)
	self:addElement(MPScore)
	self.MPScore = MPScore
	local fullscreenContainer = CoD.DynamicContainerWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(fullscreenContainer)
	self.fullscreenContainer = fullscreenContainer
	local MPDamageFeedback0 = CoD.MPDamageFeedback.new(f1_local1, f1_arg0, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	MPDamageFeedback0:subscribeToGlobalModel(f1_arg0, "CurrentWeapon", nil, function(model)
		MPDamageFeedback0:setModel(model, f1_arg0)
	end)
	self:addElement(MPDamageFeedback0)
	self.MPDamageFeedback0 = MPDamageFeedback0
	local IngameChatClientContainer = nil
	IngameChatClientContainer = CoD.IngameChatClientContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -943, -403, 0.5, 0.5, -60, 230)
	self:addElement(IngameChatClientContainer)
	self.IngameChatClientContainer = IngameChatClientContainer
	local MPObjectiveNotificationWidget = CoD.MP_ObjectiveNotificationWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 54, 326)
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
	MPObjectiveNotificationWidget:subscribeToGlobalModel(f1_arg0, "PerController", "gametypeObjective", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			MPObjectiveNotificationWidget.GameTypeText:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(MPObjectiveNotificationWidget)
	self.MPObjectiveNotificationWidget = MPObjectiveNotificationWidget
	local GameEndScore = CoD.GameEndScore.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(GameEndScore)
	self.GameEndScore = GameEndScore
	local HighValueOperatives = CoD.HighValueOperatives.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	HighValueOperatives:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg0, "high_value_operatives")
			end,
		},
	})
	local MPHintTextContainer = HighValueOperatives
	local ScoreboardWidget = HighValueOperatives.subscribeToModel
	local SpraysAndGestures = Engine[@"getmodelforcontroller"](f1_arg0)
	ScoreboardWidget(MPHintTextContainer, SpraysAndGestures["gameScore.currentState"], function(f9_arg0)
		f1_local1:updateElementState(HighValueOperatives, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	self:addElement(HighValueOperatives)
	self.HighValueOperatives = HighValueOperatives
	ScoreboardWidget = CoD.ScoreboardWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	self:addElement(ScoreboardWidget)
	self.ScoreboardWidget = ScoreboardWidget
	MPHintTextContainer = CoD.MPHintTextContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -864, 864, 1, 1, -272, -233)
	MPHintTextContainer:mergeStateConditions({
		{
			stateName = "display_noblink",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueNonEmptyString(f1_arg0, "MPHintText")
			end,
		},
	})
	local CalloutItems = MPHintTextContainer
	SpraysAndGestures = MPHintTextContainer.subscribeToModel
	local PCNotifContainer = Engine[@"getmodelforcontroller"](f1_arg0)
	SpraysAndGestures(CalloutItems, PCNotifContainer.MPHintText, function(f11_arg0)
		f1_local1:updateElementState(MPHintTextContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "MPHintText",
		})
	end, false)
	MPHintTextContainer:subscribeToGlobalModel(f1_arg0, "PerController", "MPHintText", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			MPHintTextContainer.MPHintText:setText(CoD.BaseUtility.AlreadyLocalized(f12_local0))
		end
	end)
	self:addElement(MPHintTextContainer)
	self.MPHintTextContainer = MPHintTextContainer
	SpraysAndGestures = CoD.MPSpraysAndGestures.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(SpraysAndGestures)
	self.SpraysAndGestures = SpraysAndGestures
	CalloutItems = CoD.MPCalloutItems.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CalloutItems)
	self.CalloutItems = CalloutItems
	PCNotifContainer = nil
	PCNotifContainer = CoD.PC_Notif_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 470, 920, 0, 0, 30, 130)
	self:addElement(PCNotifContainer)
	self.PCNotifContainer = PCNotifContainer
	local FrontendBattlenetContainer = nil
	FrontendBattlenetContainer = CoD.FrontendBattlenetContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -795.5, -359.5, 1, 1, -841, -61)
	self:addElement(FrontendBattlenetContainer)
	self.FrontendBattlenetContainer = FrontendBattlenetContainer
	local PlayerEmblem = LUI.UIImage.new(0, 0, 0, 140, 0, 0, 1109.5, 1249.5)
	PlayerEmblem:setAlpha(0.01)
	PlayerEmblem:subscribeToGlobalModel(f1_arg0, "StageResults", "potmClient", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			PlayerEmblem:setupPlayerEmblemByXUID(GetClientGameLobbyXUIDForClientNumString(f13_local0))
		end
	end)
	self:addElement(PlayerEmblem)
	self.PlayerEmblem = PlayerEmblem
	self:mergeStateConditions({
		{
			stateName = "HideAllButScoreboard",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end,
		},
		{
			stateName = "SpeedBoost",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "playerAbilities.playerGadget2.id", "gadget_speed_burst") and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "playerAbilities.playerGadget2.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
			end,
		},
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg0) and IsCodCasterProfileValueEqualTo(f1_arg0, "shoutcaster_qs_playerhud", 1)
			end,
		},
	})
	local f1_local17 = self
	local f1_local18 = self.subscribeToModel
	local f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local18(f1_local17, f1_local19["playerAbilities.playerGadget2.id"], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "playerAbilities.playerGadget2.id",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local18(f1_local17, f1_local19["playerAbilities.playerGadget2.state"], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "playerAbilities.playerGadget2.state",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local18(f1_local17, f1_local19["factions.isCoDCaster"], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = DataSources.CodCaster.getModel(f1_arg0)
	f1_local18(f1_local17, f1_local19.profileSettingsUpdated, function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.HUDUtility.AreXButtonPressesDisallowed(self) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.HUDUtility.AreXButtonPressesDisallowed(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "scriptNotify", function(model)
		local f24_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"player_spawned") and not CoD.PlayerRoleUtility.IsPositionDraftStage(f1_arg0, CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_DRAFT) then
			CoD.HUDUtility.DisallowXButtonPressForTime(f1_local1, self, 400)
		end
	end)
	HudMPSafeAreaContainer.id = "HudMPSafeAreaContainer"
	if CoD.isPC then
		IngameChatClientContainer.id = "IngameChatClientContainer"
	end
	GameEndScore.id = "GameEndScore"
	HighValueOperatives.id = "HighValueOperatives"
	ScoreboardWidget:setModel(self.buttonModel, f1_arg0)
	ScoreboardWidget.id = "ScoreboardWidget"
	if CoD.isPC then
		SpraysAndGestures.id = "SpraysAndGestures"
	end
	if CoD.isPC then
		CalloutItems.id = "CalloutItems"
	end
	if CoD.isPC then
		PCNotifContainer.id = "PCNotifContainer"
	end
	if CoD.isPC then
		FrontendBattlenetContainer.id = "FrontendBattlenetContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = HudMPSafeAreaContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local18 = self
	SetProperty(self, "preserveLuiButton", {
		[Enum[@"luibutton"][@"lui_key_back"]] = true,
	})
	CoD.HUDUtility.SetupGrenadeWarningIndicators(self, f1_arg0)
	SetAllowCursorMovement(f1_local1, false)
	CoD.HUDUtility.SetupArmbladeReticles(self, f1_arg0)
	return self
end
CoD.Hud_MP.__resetProperties = function(f25_arg0)
	f25_arg0.MPScore:completeAnimation()
	f25_arg0.MPScore:setAlpha(1)
end
CoD.Hud_MP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	HideAllButScoreboard = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.MPScore:completeAnimation()
			f27_arg0.MPScore:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.MPScore)
		end,
	},
	SpeedBoost = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.MPScore:completeAnimation()
			f29_arg0.MPScore:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.MPScore)
		end,
	},
}
CoD.Hud_MP.__onClose = function(f30_arg0)
	f30_arg0.HudMPSafeAreaContainer:close()
	f30_arg0.MPScore:close()
	f30_arg0.fullscreenContainer:close()
	f30_arg0.MPDamageFeedback0:close()
	f30_arg0.IngameChatClientContainer:close()
	f30_arg0.MPObjectiveNotificationWidget:close()
	f30_arg0.GameEndScore:close()
	f30_arg0.HighValueOperatives:close()
	f30_arg0.ScoreboardWidget:close()
	f30_arg0.MPHintTextContainer:close()
	f30_arg0.SpraysAndGestures:close()
	f30_arg0.CalloutItems:close()
	f30_arg0.PCNotifContainer:close()
	f30_arg0.FrontendBattlenetContainer:close()
	f30_arg0.PlayerEmblem:close()
end
