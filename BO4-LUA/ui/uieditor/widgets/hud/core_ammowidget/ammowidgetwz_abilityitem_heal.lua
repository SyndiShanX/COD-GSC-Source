require("x64:34778f864da9dda")
require("x64:9d92dce1e4291ce")
require("x64:1ebda7298b79984")
require("x64:27890fc3c34fd7e")
CoD.AmmoWidgetWZ_AbilityItem_Heal = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZ_AbilityItem_Heal.__defaultWidth = 72
CoD.AmmoWidgetWZ_AbilityItem_Heal.__defaultHeight = 59
CoD.AmmoWidgetWZ_AbilityItem_Heal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetWZ_AbilityItem_Heal)
	self.id = "AmmoWidgetWZ_AbilityItem_Heal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0.5, 0.5, -36, 32, 0.5, 0.5, -30, 30)
	Backing:setRGB(0.34, 0.32, 0.2)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_player_widget_ability_backer"))
	self:addElement(Backing)
	self.Backing = Backing
	local Glow = LUI.UIImage.new(0, 0, 9, 61, 0, 0, 7, 59)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"hash_3613317835FD35EB"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local ClockMeterAdd = LUI.UIImage.new(0.5, 0.5, -35, 31, 0.5, 0.5, -29, 29)
	ClockMeterAdd:setRGB(0, 0, 0)
	ClockMeterAdd:setAlpha(0)
	ClockMeterAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	ClockMeterAdd:setShaderVector(1, 0.5, 0, 0, 0)
	ClockMeterAdd:setShaderVector(2, 0.5, 0, 0, 0)
	ClockMeterAdd:setShaderVector(3, 0, 0, 0, 0)
	ClockMeterAdd:setShaderVector(4, 0, 0, 0, 0)
	ClockMeterAdd:linkToElementModel(self, "powerRatio", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClockMeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(ClockMeterAdd)
	self.ClockMeterAdd = ClockMeterAdd
	local Box = LUI.UIImage.new(0, 0, -1, 69, 0, 0, -5, 65)
	Box:setImage(RegisterImage(@"uie_ui_hud_core_abeg_widget_box"))
	Box:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Box:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Box)
	self.Box = Box
	local PowerBasedImageAvailable = LUI.UIImage.new(0, 0, 6, 61, 0, 0, 2, 57)
	PowerBasedImageAvailable:setScale(0.9, 0.9)
	PowerBasedImageAvailable:linkToElementModel(self, "id", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PowerBasedImageAvailable:setImage(GetWeaponGadgetIconAvailable(f3_local0))
		end
	end)
	self:addElement(PowerBasedImageAvailable)
	self.PowerBasedImageAvailable = PowerBasedImageAvailable
	local PowerBasedImageUnavailable = LUI.UIImage.new(0, 0, 6, 61, 0, 0, -1, 54)
	PowerBasedImageUnavailable:setAlpha(0)
	PowerBasedImageUnavailable:setScale(0.86, 0.86)
	PowerBasedImageUnavailable:linkToElementModel(self, "id", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PowerBasedImageUnavailable:setImage(GetWeaponGadgetIconUnavailable(f4_local0))
		end
	end)
	self:addElement(PowerBasedImageUnavailable)
	self.PowerBasedImageUnavailable = PowerBasedImageUnavailable
	local NotAvailable = CoD.AmmoWidgetWZ_EquipmentEmpty.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 26, 0.5, 0.5, -19.5, 22.5)
	NotAvailable:linkToElementModel(self, nil, false, function(model)
		NotAvailable:setModel(model, f1_arg1)
	end)
	NotAvailable:linkToElementModel(self, "id", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			NotAvailable.ImgIcon:setImage(GetWeaponGadgetIconAvailable(f6_local0))
		end
	end)
	NotAvailable:linkToElementModel(self, "id", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			NotAvailable.ImgIconGrow:setImage(GetWeaponGadgetIconAvailable(f7_local0))
		end
	end)
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	local HeroAbilityUseString = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -36, 36, 0, 0, 68, 92)
	HeroAbilityUseString:mergeStateConditions({
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
				if not f9_local0 then
					f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					if not f9_local0 then
						f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbility",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbilityWZ",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysTrue()
			end,
		},
	})
	local QuickEquipCycleString = HeroAbilityUseString
	local HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
	local HeroAbilityHoldStringPC = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldString(QuickEquipCycleString, HeroAbilityHoldStringPC.PlayerSettingsUpdate, function(f15_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	QuickEquipCycleString = HeroAbilityUseString
	HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
	HeroAbilityHoldStringPC = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldString(QuickEquipCycleString, HeroAbilityHoldStringPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f16_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	QuickEquipCycleString = HeroAbilityUseString
	HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
	HeroAbilityHoldStringPC = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldString(QuickEquipCycleString, HeroAbilityHoldStringPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f17_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	QuickEquipCycleString = HeroAbilityUseString
	HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
	HeroAbilityHoldStringPC = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldString(QuickEquipCycleString, HeroAbilityHoldStringPC["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"]], function(f18_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"],
		})
	end, false)
	HeroAbilityUseString:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_arg0
		f1_arg0:updateElementState(HeroAbilityUseString, f19_arg1)
	end)
	QuickEquipCycleString = HeroAbilityUseString
	HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
	HeroAbilityHoldStringPC = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldString(QuickEquipCycleString, HeroAbilityHoldStringPC.LastInput, function(f20_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	HeroAbilityUseString.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2EC61C43D90FCF56"))
	HeroAbilityUseString.GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29E6A8D0F83F4FC6"))
	HeroAbilityUseString.GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	HeroAbilityHoldString = CoD.AbilityHoldToActivate.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0, 0, -50, -1)
	HeroAbilityHoldString:linkToElementModel(self, nil, false, function(model)
		HeroAbilityHoldString:setModel(model, f1_arg1)
	end)
	self:addElement(HeroAbilityHoldString)
	self.HeroAbilityHoldString = HeroAbilityHoldString
	QuickEquipCycleString = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, 20, 259, 0, 0, 71, 89)
	QuickEquipCycleString:mergeStateConditions({
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "warzoneCycleItems", 1) and CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbility",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbilityWZ",
			condition = function(menu, element, event)
				local f29_local0 = IsMouseOrKeyboard(f1_arg1)
				if f29_local0 then
					f29_local0 = AlwaysTrue()
					if f29_local0 then
						f29_local0 = CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "warzoneCycleItems", 1)
					end
				end
				return f29_local0
			end,
		},
	})
	local LED = QuickEquipCycleString
	HeroAbilityHoldStringPC = QuickEquipCycleString.subscribeToModel
	local stackCount = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldStringPC(LED, stackCount.PlayerSettingsUpdate, function(f30_arg0)
		f1_arg0:updateElementState(QuickEquipCycleString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	LED = QuickEquipCycleString
	HeroAbilityHoldStringPC = QuickEquipCycleString.subscribeToModel
	stackCount = Engine[@"getglobalmodel"]()
	HeroAbilityHoldStringPC(LED, stackCount["storageGlobalRoot.user_settings"], function(f31_arg0)
		f1_arg0:updateElementState(QuickEquipCycleString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	LED = QuickEquipCycleString
	HeroAbilityHoldStringPC = QuickEquipCycleString.subscribeToModel
	stackCount = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldStringPC(LED, stackCount["hudItems.inventory.open"], function(f32_arg0)
		f1_arg0:updateElementState(QuickEquipCycleString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	QuickEquipCycleString:appendEventHandler("input_source_changed", function(f33_arg0, f33_arg1)
		f33_arg1.menu = f33_arg1.menu or f1_arg0
		f1_arg0:updateElementState(QuickEquipCycleString, f33_arg1)
	end)
	LED = QuickEquipCycleString
	HeroAbilityHoldStringPC = QuickEquipCycleString.subscribeToModel
	stackCount = Engine[@"getmodelforcontroller"](f1_arg1)
	HeroAbilityHoldStringPC(LED, stackCount.LastInput, function(f34_arg0)
		f1_arg0:updateElementState(QuickEquipCycleString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	QuickEquipCycleString.KBMText:setText("")
	QuickEquipCycleString.KBMText:setLetterSpacing(2)
	QuickEquipCycleString.GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4FB00D233B6DAFE4"))
	QuickEquipCycleString.GamepadText:setTTF("ttmussels_regular")
	QuickEquipCycleString.GamepadText:setLetterSpacing(2)
	self:addElement(QuickEquipCycleString)
	self.QuickEquipCycleString = QuickEquipCycleString
	HeroAbilityHoldStringPC = nil
	HeroAbilityHoldStringPC = CoD.AbilityHoldToActivate.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0, 0, -65.5, -16.5)
	HeroAbilityHoldStringPC.__Alpha = function()
		HeroAbilityHoldStringPC:setAlpha(CoD.HUDUtility.GetAbilityHoldToActivateAlpha(f1_arg1, self, 1))
	end
	HeroAbilityHoldStringPC.__Alpha()
	HeroAbilityHoldStringPC:linkToElementModel(self, nil, false, function(model)
		HeroAbilityHoldStringPC:setModel(model, f1_arg1)
	end)
	self:addElement(HeroAbilityHoldStringPC)
	self.HeroAbilityHoldStringPC = HeroAbilityHoldStringPC
	LED = LUI.UIImage.new(0, 0, 0.5, 68.5, 0, 0, -4.5, 63.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.2)
	LED:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_player_widget_led_heal"))
	self:addElement(LED)
	self.LED = LED
	stackCount = CoD.WarzoneAbilityItemCounter.new(f1_arg0, f1_arg1, 0, 0, 38.5, 74.5, 0, 0, 41, 65)
	stackCount:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan(f1_arg1, "HUDItems", "healthItemstackCount", 1)
			end,
		},
	})
	local f1_local14 = stackCount
	local f1_local15 = stackCount.subscribeToModel
	local f1_local16 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.healthItemstackCount, function(f38_arg0)
		f1_arg0:updateElementState(stackCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "healthItemstackCount",
		})
	end, false)
	stackCount:linkToElementModel(stackCount, "id", true, function(model)
		f1_arg0:updateElementState(stackCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	stackCount:subscribeToGlobalModel(f1_arg1, "HUDItems", "healthItemstackCount", function(model)
		local f40_local0 = model:get()
		if f40_local0 ~= nil then
			stackCount.Quantity:setText(CoD.BaseUtility.AlreadyLocalized(f40_local0))
		end
	end)
	self:addElement(stackCount)
	self.stackCount = stackCount
	HeroAbilityHoldStringPC:linkToElementModel(self, "powerRatio", true, HeroAbilityHoldStringPC.__Alpha)
	f1_local14 = HeroAbilityHoldStringPC
	f1_local15 = HeroAbilityHoldStringPC.subscribeToModel
	f1_local16 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local14, f1_local16["GameplayFeedbackSettings.hideRadiationHold"], HeroAbilityHoldStringPC.__Alpha)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "count", 0)
			end,
		},
		{
			stateName = "InUse",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
			end,
		},
		{
			stateName = "Deployed",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PowerBasedEmptyCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_charging"]) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "powerRatio", 0)
			end,
		},
		{
			stateName = "PowerBasedCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_charging"])
			end,
		},
		{
			stateName = "PowerBased",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_hidden"])
			end,
		},
	})
	self:linkToElementModel(self, "count", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "count",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "powerRatio", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "powerRatio",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f50_arg2, f50_arg3, f50_arg4)
		if CoD.HUDUtility.ShouldPulseNewAmmo(self) and IsSelfInState(self, "PowerBased") then
			PlayClip(self, "Pulse", controller)
		end
	end)
	self:linkToElementModel(self, "id", true, function(model)
		local f51_local0 = self
		if CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "warzoneCycleItems", 1) and CoD.WZUtility.IsQuickInventoryOpen(f1_arg1) then
			PlayClip(self, "FadeIn", f1_arg1)
		end
	end)
	self:linkToElementModel(self, "ammo", true, function(model)
		local f52_local0 = self
		if IsSelfInState(self, "PowerBased") and CoD.HUDUtility.ShouldPulseNewAmmo(self) then
			PlayClip(self, "Pulse", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	SetElementProperty(NotAvailable, "show_empty_health_flash", true)
	f1_local15 = HeroAbilityHoldString
	if IsPC() then
		HideWidget(self.HeroAbilityHoldString)
	end
	return self
end
CoD.AmmoWidgetWZ_AbilityItem_Heal.__resetProperties = function(f53_arg0)
	f53_arg0.NotAvailable:completeAnimation()
	f53_arg0.HeroAbilityUseString:completeAnimation()
	f53_arg0.QuickEquipCycleString:completeAnimation()
	f53_arg0.PowerBasedImageUnavailable:completeAnimation()
	f53_arg0.PowerBasedImageAvailable:completeAnimation()
	f53_arg0.Glow:completeAnimation()
	f53_arg0.Box:completeAnimation()
	f53_arg0.LED:completeAnimation()
	f53_arg0.ClockMeterAdd:completeAnimation()
	f53_arg0.Backing:completeAnimation()
	f53_arg0.stackCount:completeAnimation()
	f53_arg0.NotAvailable:setAlpha(1)
	f53_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
	f53_arg0.HeroAbilityUseString:setAlpha(1)
	f53_arg0.QuickEquipCycleString:setAlpha(1)
	f53_arg0.PowerBasedImageUnavailable:setRGB(1, 1, 1)
	f53_arg0.PowerBasedImageUnavailable:setAlpha(0)
	f53_arg0.PowerBasedImageAvailable:setAlpha(1)
	f53_arg0.Glow:setAlpha(0)
	f53_arg0.Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	f53_arg0.Box:setRGB(1, 1, 1)
	f53_arg0.Box:setAlpha(1)
	f53_arg0.LED:setRGB(0, 0, 0)
	f53_arg0.LED:setAlpha(0.2)
	f53_arg0.ClockMeterAdd:setRGB(0, 0, 0)
	f53_arg0.ClockMeterAdd:setAlpha(0)
	f53_arg0.Backing:setAlpha(0)
	f53_arg0.stackCount:setLeftRight(0, 0, 38.5, 74.5)
	f53_arg0.stackCount:setAlpha(1)
end
CoD.AmmoWidgetWZ_AbilityItem_Heal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(3)
			f54_arg0.NotAvailable:completeAnimation()
			f54_arg0.NotAvailable:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.NotAvailable)
			f54_arg0.HeroAbilityUseString:completeAnimation()
			f54_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f54_arg0.HeroAbilityUseString:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.HeroAbilityUseString)
			f54_arg0.QuickEquipCycleString:completeAnimation()
			f54_arg0.QuickEquipCycleString:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.QuickEquipCycleString)
			f54_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(8)
			f55_arg0.Glow:completeAnimation()
			f55_arg0.Glow:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Glow)
			f55_arg0.Box:completeAnimation()
			f55_arg0.Box:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Box)
			f55_arg0.PowerBasedImageAvailable:completeAnimation()
			f55_arg0.PowerBasedImageAvailable:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.PowerBasedImageAvailable)
			f55_arg0.PowerBasedImageUnavailable:completeAnimation()
			f55_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.PowerBasedImageUnavailable)
			f55_arg0.NotAvailable:completeAnimation()
			f55_arg0.NotAvailable:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.NotAvailable)
			f55_arg0.HeroAbilityUseString:completeAnimation()
			f55_arg0.HeroAbilityUseString:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.HeroAbilityUseString)
			f55_arg0.QuickEquipCycleString:completeAnimation()
			f55_arg0.QuickEquipCycleString:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.QuickEquipCycleString)
			f55_arg0.LED:completeAnimation()
			f55_arg0.LED:setAlpha(0.2)
			f55_arg0.clipFinished(f55_arg0.LED)
		end,
	},
	InUse = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(5)
			f56_arg0.Backing:completeAnimation()
			f56_arg0.Backing:setAlpha(0.95)
			f56_arg0.clipFinished(f56_arg0.Backing)
			f56_arg0.ClockMeterAdd:completeAnimation()
			f56_arg0.ClockMeterAdd:setAlpha(0.8)
			f56_arg0.clipFinished(f56_arg0.ClockMeterAdd)
			f56_arg0.NotAvailable:completeAnimation()
			f56_arg0.NotAvailable:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.NotAvailable)
			f56_arg0.HeroAbilityUseString:completeAnimation()
			f56_arg0.HeroAbilityUseString:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.HeroAbilityUseString)
			f56_arg0.QuickEquipCycleString:completeAnimation()
			f56_arg0.QuickEquipCycleString:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.QuickEquipCycleString)
			f56_arg0.nextClip = "DefaultClip"
		end,
	},
	Deployed = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(3)
			f57_arg0.Backing:completeAnimation()
			f57_arg0.Backing:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.Backing)
			f57_arg0.NotAvailable:completeAnimation()
			f57_arg0.NotAvailable:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.NotAvailable)
			f57_arg0.HeroAbilityUseString:completeAnimation()
			f57_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f57_arg0.HeroAbilityUseString:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.HeroAbilityUseString)
		end,
	},
	PowerBasedEmptyCharging = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(6)
			f58_arg0.Backing:completeAnimation()
			f58_arg0.Backing:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.Backing)
			f58_arg0.ClockMeterAdd:completeAnimation()
			f58_arg0.ClockMeterAdd:setRGB(0, 0, 0)
			f58_arg0.ClockMeterAdd:setAlpha(0.8)
			f58_arg0.clipFinished(f58_arg0.ClockMeterAdd)
			f58_arg0.PowerBasedImageAvailable:completeAnimation()
			f58_arg0.PowerBasedImageAvailable:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.PowerBasedImageAvailable)
			f58_arg0.PowerBasedImageUnavailable:completeAnimation()
			f58_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f58_arg0.clipFinished(f58_arg0.PowerBasedImageUnavailable)
			f58_arg0.NotAvailable:completeAnimation()
			f58_arg0.NotAvailable:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.NotAvailable)
			f58_arg0.HeroAbilityUseString:completeAnimation()
			f58_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f58_arg0.HeroAbilityUseString:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.HeroAbilityUseString)
		end,
	},
	PowerBasedCharging = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(6)
			f59_arg0.ClockMeterAdd:completeAnimation()
			f59_arg0.ClockMeterAdd:setRGB(0, 0, 0)
			f59_arg0.ClockMeterAdd:setAlpha(0.8)
			f59_arg0.clipFinished(f59_arg0.ClockMeterAdd)
			f59_arg0.PowerBasedImageAvailable:completeAnimation()
			f59_arg0.PowerBasedImageAvailable:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.PowerBasedImageAvailable)
			f59_arg0.PowerBasedImageUnavailable:completeAnimation()
			f59_arg0.PowerBasedImageUnavailable:setAlpha(1)
			f59_arg0.clipFinished(f59_arg0.PowerBasedImageUnavailable)
			f59_arg0.NotAvailable:completeAnimation()
			f59_arg0.NotAvailable:setAlpha(1)
			f59_arg0.clipFinished(f59_arg0.NotAvailable)
			f59_arg0.HeroAbilityUseString:completeAnimation()
			f59_arg0.HeroAbilityUseString:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.HeroAbilityUseString)
			f59_arg0.QuickEquipCycleString:completeAnimation()
			f59_arg0.QuickEquipCycleString:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.QuickEquipCycleString)
		end,
	},
	PowerBased = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(6)
			f60_arg0.Glow:completeAnimation()
			f60_arg0.Glow:setAlpha(0.1)
			f60_arg0.Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f60_arg0.clipFinished(f60_arg0.Glow)
			f60_arg0.Box:completeAnimation()
			f60_arg0.Box:setRGB(0, 0, 0)
			f60_arg0.Box:setAlpha(1)
			f60_arg0.clipFinished(f60_arg0.Box)
			f60_arg0.PowerBasedImageUnavailable:completeAnimation()
			f60_arg0.PowerBasedImageUnavailable:setRGB(0.74, 0.69, 0.42)
			f60_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.PowerBasedImageUnavailable)
			f60_arg0.NotAvailable:completeAnimation()
			f60_arg0.NotAvailable:setAlpha(1)
			f60_arg0.clipFinished(f60_arg0.NotAvailable)
			f60_arg0.HeroAbilityUseString:completeAnimation()
			f60_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
			f60_arg0.HeroAbilityUseString:setAlpha(1)
			f60_arg0.clipFinished(f60_arg0.HeroAbilityUseString)
			f60_arg0.LED:completeAnimation()
			f60_arg0.LED:setRGB(0, 0, 0)
			f60_arg0.LED:setAlpha(0.2)
			f60_arg0.clipFinished(f60_arg0.LED)
		end,
		Pulse = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(3)
			f61_arg0.Box:completeAnimation()
			f61_arg0.Box:setRGB(0, 0, 0)
			f61_arg0.Box:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.Box)
			f61_arg0.NotAvailable:completeAnimation()
			f61_arg0.NotAvailable:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.NotAvailable)
			f61_arg0.LED:completeAnimation()
			f61_arg0.LED:setRGB(0, 0, 0)
			f61_arg0.LED:setAlpha(0.2)
			f61_arg0.clipFinished(f61_arg0.LED)
			f61_arg0.nextClip = "Pulse"
		end,
		FadeIn = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(8)
			f62_arg0.Glow:completeAnimation()
			f62_arg0.Glow:setAlpha(0.1)
			f62_arg0.Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f62_arg0.clipFinished(f62_arg0.Glow)
			f62_arg0.Box:completeAnimation()
			f62_arg0.Box:setRGB(0, 0, 0)
			f62_arg0.Box:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.Box)
			local f62_local0 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					f64_arg0:beginAnimation(210)
					f64_arg0:setAlpha(1)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
				end
				f62_arg0.PowerBasedImageAvailable:beginAnimation(200)
				f62_arg0.PowerBasedImageAvailable:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.PowerBasedImageAvailable:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f62_arg0.PowerBasedImageAvailable:completeAnimation()
			f62_arg0.PowerBasedImageAvailable:setAlpha(0)
			f62_local0(f62_arg0.PowerBasedImageAvailable)
			f62_arg0.PowerBasedImageUnavailable:completeAnimation()
			f62_arg0.PowerBasedImageUnavailable:setRGB(0.74, 0.69, 0.42)
			f62_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.PowerBasedImageUnavailable)
			f62_arg0.NotAvailable:completeAnimation()
			f62_arg0.NotAvailable:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.NotAvailable)
			f62_arg0.HeroAbilityUseString:completeAnimation()
			f62_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
			f62_arg0.HeroAbilityUseString:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.HeroAbilityUseString)
			f62_arg0.LED:completeAnimation()
			f62_arg0.LED:setRGB(0, 0, 0)
			f62_arg0.LED:setAlpha(0.2)
			f62_arg0.clipFinished(f62_arg0.LED)
			local f62_local1 = function(f65_arg0)
				local f65_local0 = function(f66_arg0)
					f66_arg0:beginAnimation(210)
					f66_arg0:setAlpha(1)
					f66_arg0:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
				end
				f62_arg0.stackCount:beginAnimation(200)
				f62_arg0.stackCount:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.stackCount:registerEventHandler("transition_complete_keyframe", f65_local0)
			end
			f62_arg0.stackCount:completeAnimation()
			f62_arg0.stackCount:setLeftRight(0, 0, 38, 74)
			f62_arg0.stackCount:setAlpha(0)
			f62_local1(f62_arg0.stackCount)
		end,
	},
}
CoD.AmmoWidgetWZ_AbilityItem_Heal.__onClose = function(f67_arg0)
	f67_arg0.ClockMeterAdd:close()
	f67_arg0.PowerBasedImageAvailable:close()
	f67_arg0.PowerBasedImageUnavailable:close()
	f67_arg0.NotAvailable:close()
	f67_arg0.HeroAbilityUseString:close()
	f67_arg0.HeroAbilityHoldString:close()
	f67_arg0.QuickEquipCycleString:close()
	f67_arg0.HeroAbilityHoldStringPC:close()
	f67_arg0.stackCount:close()
end
