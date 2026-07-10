require("x64:d4ed3fd8d1fcc4a")
require("x64:484d96d72e020cb")
require("x64:84edea6058974e3")
require("x64:ba717ae8e378ed5")
require("x64:7c5a5334738ad1e")
require("x64:6b727030f343bc3")
require("x64:a4d62339ab35bca")
require("x64:b4608168bbee1cb")
require("x64:da54af56b1dee1f")
require("x64:13012bca0fbd2f4")
CoD.Hud_MP_Codcaster = InheritFrom(CoD.Menu)
LUI.createMenu.Hud_MP_Codcaster = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Hud_MP_Codcaster", f1_arg0)
	local f1_local1 = self
	self:setUseCylinderMapping(true)
	self:setClass(CoD.Hud_MP_Codcaster)
	self.soundSet = "HUD"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local HudMPSafeAreaContainer = CoD.Hud_MP_Codcaster_SafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
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
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x57A02387D3C368A) and CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg0) then
			SetElementProperty(f1_local1, "_ignoreNextMoneyChange", true)
			SetMPScoreText(f1_local1, f3_local0, f1_arg0, model)
			PlayClipOnElement(self, {
				elementName = "MPScore",
				clipName = "BountyCash",
			}, f1_arg0)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x57A02387D3C368A) and IsSpecificGadgetInUse(f1_arg0, f3_local0, "gadget_combat_efficiency") and not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg0) then
			PlayClipOnElement(self, {
				elementName = "MPScore",
				clipName = "CombatEfficiencyScore",
			}, f1_arg0)
			SetMPScoreText(f1_local1, f3_local0, f1_arg0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x57A02387D3C368A) and not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg0) then
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
			MPObjectiveNotificationWidget.GameTypeText:setText(Engine[0xF9F1239CFD921FE](f7_local0))
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
	local FrontendBattlenetContainer = Engine[0x4DF5CFBC1771947](f1_arg0)
	ScoreboardWidget(MPHintTextContainer, FrontendBattlenetContainer["gameScore.currentState"], function(f9_arg0)
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
	local f1_local12 = MPHintTextContainer
	FrontendBattlenetContainer = MPHintTextContainer.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg0)
	FrontendBattlenetContainer(f1_local12, f1_local13.MPHintText, function(f11_arg0)
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
	FrontendBattlenetContainer = nil
	FrontendBattlenetContainer = CoD.FrontendBattlenetContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -795.5, -359.5, 1, 1, -841, -61)
	self:addElement(FrontendBattlenetContainer)
	self.FrontendBattlenetContainer = FrontendBattlenetContainer
	self:mergeStateConditions({
		{
			stateName = "HideAllButScoreboard",
			condition = function(menu, element, event)
				local f13_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
				if not f13_local0 then
					f13_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					if not f13_local0 then
						f13_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
						if not f13_local0 then
							f13_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x1E59914E91E423A])
						end
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "SpeedBoost",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "playerAbilities.playerGadget2.id", "gadget_speed_burst") and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "playerAbilities.playerGadget2.state", Enum[0xF0447219F15F7F3][0x1873A43E9D1620E])
			end,
		},
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg0) and IsCodCasterProfileValueEqualTo(f1_arg0, "shoutcaster_qs_playerhud", 1)
			end,
		},
	})
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	local f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local12(f1_local13, f1_local14["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local12(f1_local13, f1_local14["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local12(f1_local13, f1_local14["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local12(f1_local13, f1_local14["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1E59914E91E423A]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1E59914E91E423A],
		})
	end, false)
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local12(f1_local13, f1_local14["playerAbilities.playerGadget2.id"], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "playerAbilities.playerGadget2.id",
		})
	end, false)
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local12(f1_local13, f1_local14["playerAbilities.playerGadget2.state"], function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "playerAbilities.playerGadget2.state",
		})
	end, false)
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local12(f1_local13, f1_local14["factions.isCoDCaster"], function(f22_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f22_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local13 = self
	f1_local12 = self.subscribeToModel
	f1_local14 = DataSources.CodCaster.getModel(f1_arg0)
	f1_local12(f1_local13, f1_local14.profileSettingsUpdated, function(f23_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f23_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.HUDUtility.AreXButtonPressesDisallowed(self) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.HUDUtility.AreXButtonPressesDisallowed(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "scriptNotify", function(model)
		local f26_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x9FB0A7FE2E8EC41) and not CoD.PlayerRoleUtility.IsPositionDraftStage(f1_arg0, CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_DRAFT) then
			CoD.HUDUtility.DisallowXButtonPressForTime(f1_local1, self, 400)
		end
	end)
	HudMPSafeAreaContainer.id = "HudMPSafeAreaContainer"
	GameEndScore.id = "GameEndScore"
	HighValueOperatives.id = "HighValueOperatives"
	ScoreboardWidget:setModel(self.buttonModel, f1_arg0)
	ScoreboardWidget.id = "ScoreboardWidget"
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
	f1_local12 = self
	SetProperty(self, "preserveLuiButton", {
		[Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1]] = true,
	})
	CoD.HUDUtility.SetupGrenadeWarningIndicators(self, f1_arg0)
	SetAllowCursorMovement(f1_local1, false)
	return self
end
CoD.Hud_MP_Codcaster.__resetProperties = function(f27_arg0)
	f27_arg0.MPScore:completeAnimation()
	f27_arg0.MPScore:setAlpha(1)
end
CoD.Hud_MP_Codcaster.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	HideAllButScoreboard = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.MPScore:completeAnimation()
			f29_arg0.MPScore:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.MPScore)
		end,
	},
	SpeedBoost = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.MPScore:completeAnimation()
			f31_arg0.MPScore:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.MPScore)
		end,
	},
}
CoD.Hud_MP_Codcaster.__onClose = function(f32_arg0)
	f32_arg0.HudMPSafeAreaContainer:close()
	f32_arg0.MPScore:close()
	f32_arg0.fullscreenContainer:close()
	f32_arg0.MPDamageFeedback0:close()
	f32_arg0.MPObjectiveNotificationWidget:close()
	f32_arg0.GameEndScore:close()
	f32_arg0.HighValueOperatives:close()
	f32_arg0.ScoreboardWidget:close()
	f32_arg0.MPHintTextContainer:close()
	f32_arg0.FrontendBattlenetContainer:close()
end
