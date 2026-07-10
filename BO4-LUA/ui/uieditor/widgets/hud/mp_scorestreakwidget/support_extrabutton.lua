require("x64:f65b3780508b5c7")
require("x64:34778f864da9dda")
require("x64:7740d6a36622800")
require("x64:eb2b44d72f6861a")
require("x64:e6b26605fb6b80c")
CoD.Support_ExtraButton = InheritFrom(LUI.UIElement)
CoD.Support_ExtraButton.__defaultWidth = 40
CoD.Support_ExtraButton.__defaultHeight = 70
CoD.Support_ExtraButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Support_ExtraButton)
	self.id = "Support_ExtraButton"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGTopBlur = LUI.UIImage.new(0, 0, -12, 60, 0, 0, 5, 69)
	BGTopBlur:setImage(RegisterImage(@"uie_ui_hud_core_frame_streaks_widget_top_mask"))
	BGTopBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGTopBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGTopBlur)
	self.BGTopBlur = BGTopBlur
	local BGTop = LUI.UIImage.new(0, 0, -12, 60, 0, 0, 5, 69)
	BGTop:setImage(RegisterImage(@"uie_ui_hud_core_frame_streaks_widget_top"))
	self:addElement(BGTop)
	self.BGTop = BGTop
	local PanelDark = LUI.UIImage.new(0, 0, -22, 60, 0, 0, -3.5, 79.5)
	PanelDark:setAlpha(0.97)
	PanelDark:setImage(RegisterImage(@"uie_streak_flare_bg"))
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local Background = LUI.UIImage.new(0, 0, -22, 60, 0, 0, -3.5, 79.5)
	Background:setAlpha(0.2)
	Background:setImage(RegisterImage(@"uie_streak_flare"))
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Background)
	self.Background = Background
	local LED = LUI.UIImage.new(0, 0, -11.5, 52.5, 0, 0, 3, 67)
	LED:setRGB(0.79, 0.45, 0.05)
	LED:setAlpha(0)
	LED:setImage(RegisterImage(@"uie_ui_hud_core_streak_led_button"))
	self:addElement(LED)
	self.LED = LED
	local buttonInternal = CoD.Support_ButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0, 0, 18, 59)
	buttonInternal:linkToElementModel(self, nil, false, function(model)
		buttonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(buttonInternal)
	self.buttonInternal = buttonInternal
	local Bar = CoD.Support_EarningBar.new(f1_arg0, f1_arg1, 0, 0, -9, 0, 0, 0, 35, 37)
	Bar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Bar:setAlpha(0)
	Bar:linkToElementModel(self, nil, false, function(model)
		Bar:setModel(model, f1_arg1)
	end)
	self:addElement(Bar)
	self.Bar = Bar
	local ButtonProgressRing = CoD.ButtonProgressRing.new(f1_arg0, f1_arg1, 1, 1, -94, -52, 0, 0, 15.5, 57.5)
	ButtonProgressRing:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ButtonProgressRing:setAlpha(0)
	ButtonProgressRing:setScale(0.7, 0.7)
	ButtonProgressRing:subscribeToGlobalModel(f1_arg1, "HUDItems", "heroHoldProgress", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ButtonProgressRing.progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self:addElement(ButtonProgressRing)
	self.ButtonProgressRing = ButtonProgressRing
	local ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 1, 1, -117.5, -28.5, 0, 0, 13.5, 58.5)
	ControllerDependentTextBox:mergeStateConditions({
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
				return IsMouseOrKeyboard(f1_arg1) and AlwaysTrue()
			end,
		},
	})
	local ArrowDown = ControllerDependentTextBox
	local ArrowUp = ControllerDependentTextBox.subscribeToModel
	local FUItop2 = Engine[@"getmodelforcontroller"](f1_arg1)
	ArrowUp(ArrowDown, FUItop2["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	ArrowDown = ControllerDependentTextBox
	ArrowUp = ControllerDependentTextBox.subscribeToModel
	FUItop2 = Engine[@"getmodelforcontroller"](f1_arg1)
	ArrowUp(ArrowDown, FUItop2["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f11_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	ControllerDependentTextBox:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ControllerDependentTextBox, f12_arg1)
	end)
	ArrowDown = ControllerDependentTextBox
	ArrowUp = ControllerDependentTextBox.subscribeToModel
	FUItop2 = Engine[@"getmodelforcontroller"](f1_arg1)
	ArrowUp(ArrowDown, FUItop2.LastInput, function(f13_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ControllerDependentTextBox:setAlpha(0)
	ControllerDependentTextBox.KBMText:setLetterSpacing(0)
	ControllerDependentTextBox.GamepadText:setText(CoD.BaseUtility.AlreadyLocalized("[{+weapnext_inventory}]"))
	ControllerDependentTextBox.GamepadText:setLetterSpacing(0)
	ControllerDependentTextBox.GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ControllerDependentTextBox:linkToElementModel(self, nil, false, function(model)
		ControllerDependentTextBox:setModel(model, f1_arg1)
	end)
	ControllerDependentTextBox:linkToElementModel(self, "bindingKBM", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(f15_local0))
		end
	end)
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	ArrowUp = CoD.Support_ButtonArrow.new(f1_arg0, f1_arg1, 0, 0, -41, -25, 0, 0, -1, 15)
	ArrowUp:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "arrowState", CoD.ScorestreakInGameUtility.ArrowState.UP, CoD.ScorestreakInGameUtility.ArrowState.BOTH)
			end,
		},
	})
	ArrowUp:linkToElementModel(ArrowUp, "arrowState", true, function(model)
		f1_arg0:updateElementState(ArrowUp, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "arrowState",
		})
	end)
	ArrowUp:setAlpha(0)
	ArrowUp:setZRot(90)
	ArrowUp:linkToElementModel(self, nil, false, function(model)
		ArrowUp:setModel(model, f1_arg1)
	end)
	self:addElement(ArrowUp)
	self.ArrowUp = ArrowUp
	ArrowDown = CoD.Support_ButtonArrow.new(f1_arg0, f1_arg1, 0, 0, -41, -25, 0, 0, 57, 73)
	ArrowDown:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "arrowState", CoD.ScorestreakInGameUtility.ArrowState.DOWN, CoD.ScorestreakInGameUtility.ArrowState.BOTH)
			end,
		},
	})
	ArrowDown:linkToElementModel(ArrowDown, "arrowState", true, function(model)
		f1_arg0:updateElementState(ArrowDown, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "arrowState",
		})
	end)
	ArrowDown:setAlpha(0)
	ArrowDown:setZRot(-90)
	ArrowDown:linkToElementModel(self, nil, false, function(model)
		ArrowDown:setModel(model, f1_arg1)
	end)
	self:addElement(ArrowDown)
	self.ArrowDown = ArrowDown
	FUItop2 = LUI.UIImage.new(0, 0, 0.5, 40.5, 0, 0, 52, 60)
	FUItop2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	FUItop2:setAlpha(0)
	FUItop2:setImage(RegisterImage(@"uie_ui_hud_core_streak_widget_fui_selector"))
	FUItop2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(FUItop2)
	self.FUItop2 = FUItop2
	self:mergeStateConditions({
		{
			stateName = "Usable",
			condition = function(menu, element, event)
				local f22_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "rewardImage")
				if f22_local0 then
					f22_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "rewardAmmo", 0)
					if f22_local0 then
						f22_local0 = IsGamepad(f1_arg1)
					end
				end
				return f22_local0
			end,
		},
		{
			stateName = "UsableKBM",
			condition = function(menu, element, event)
				local f23_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "rewardImage")
				if f23_local0 then
					f23_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "rewardAmmo", 0)
					if f23_local0 then
						f23_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f23_local0
			end,
		},
	})
	self:linkToElementModel(self, "rewardImage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardImage",
		})
	end)
	self:linkToElementModel(self, "rewardAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardAmmo",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f26_arg0, f26_arg1)
		f26_arg1.menu = f26_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f26_arg1)
	end)
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local14(f1_local13, f1_local15.LastInput, function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f28_arg2, f28_arg3, f28_arg4)
		DispatchEventToParent(element, "scorestreak_state_update", controller)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Support_ExtraButton.__resetProperties = function(f29_arg0)
	f29_arg0.buttonInternal:completeAnimation()
	f29_arg0.Bar:completeAnimation()
	f29_arg0.Background:completeAnimation()
	f29_arg0.FUItop2:completeAnimation()
	f29_arg0.ArrowDown:completeAnimation()
	f29_arg0.ArrowUp:completeAnimation()
	f29_arg0.ControllerDependentTextBox:completeAnimation()
	f29_arg0.ButtonProgressRing:completeAnimation()
	f29_arg0.LED:completeAnimation()
	f29_arg0.PanelDark:completeAnimation()
	f29_arg0.BGTop:completeAnimation()
	f29_arg0.BGTopBlur:completeAnimation()
	f29_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
	f29_arg0.buttonInternal:setTopBottom(0, 0, 18, 59)
	f29_arg0.buttonInternal:setAlpha(1)
	f29_arg0.buttonInternal:setScale(1, 1)
	f29_arg0.Bar:setLeftRight(0, 0, -9, 0)
	f29_arg0.Bar:setTopBottom(0, 0, 35, 37)
	f29_arg0.Bar:setAlpha(0)
	f29_arg0.Background:setTopBottom(0, 0, -3.5, 79.5)
	f29_arg0.Background:setRGB(1, 1, 1)
	f29_arg0.Background:setAlpha(0.2)
	f29_arg0.Background:setScale(1, 1)
	f29_arg0.FUItop2:setLeftRight(0, 0, 0.5, 40.5)
	f29_arg0.FUItop2:setAlpha(0)
	f29_arg0.ArrowDown:setTopBottom(0, 0, 57, 73)
	f29_arg0.ArrowDown:setAlpha(0)
	f29_arg0.ArrowUp:setLeftRight(0, 0, -41, -25)
	f29_arg0.ArrowUp:setTopBottom(0, 0, -1, 15)
	f29_arg0.ArrowUp:setAlpha(0)
	f29_arg0.ControllerDependentTextBox:setLeftRight(1, 1, -117.5, -28.5)
	f29_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 13.5, 58.5)
	f29_arg0.ControllerDependentTextBox:setAlpha(0)
	f29_arg0.ButtonProgressRing:setAlpha(0)
	f29_arg0.LED:setTopBottom(0, 0, 3, 67)
	f29_arg0.LED:setAlpha(0)
	f29_arg0.PanelDark:setTopBottom(0, 0, -3.5, 79.5)
	f29_arg0.PanelDark:setAlpha(0.97)
	f29_arg0.PanelDark:setScale(1, 1)
	f29_arg0.BGTop:setTopBottom(0, 0, 5, 69)
	f29_arg0.BGTop:setAlpha(1)
	f29_arg0.BGTopBlur:setTopBottom(0, 0, 5, 69)
	f29_arg0.BGTopBlur:setAlpha(1)
end
CoD.Support_ExtraButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(12)
			f30_arg0.BGTopBlur:completeAnimation()
			f30_arg0.BGTopBlur:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.BGTopBlur)
			f30_arg0.BGTop:completeAnimation()
			f30_arg0.BGTop:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.BGTop)
			f30_arg0.PanelDark:completeAnimation()
			f30_arg0.PanelDark:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.PanelDark)
			f30_arg0.Background:completeAnimation()
			f30_arg0.Background:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Background)
			f30_arg0.LED:completeAnimation()
			f30_arg0.LED:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.LED)
			f30_arg0.buttonInternal:completeAnimation()
			f30_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
			f30_arg0.buttonInternal:setTopBottom(0, 0, 0, 41)
			f30_arg0.buttonInternal:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.buttonInternal)
			f30_arg0.Bar:completeAnimation()
			f30_arg0.Bar:setLeftRight(0, 0, -6, 3)
			f30_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f30_arg0.Bar:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Bar)
			f30_arg0.ButtonProgressRing:completeAnimation()
			f30_arg0.ButtonProgressRing:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ButtonProgressRing)
			f30_arg0.ControllerDependentTextBox:completeAnimation()
			f30_arg0.ControllerDependentTextBox:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ControllerDependentTextBox)
			f30_arg0.ArrowUp:completeAnimation()
			f30_arg0.ArrowUp:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ArrowUp)
			f30_arg0.ArrowDown:completeAnimation()
			f30_arg0.ArrowDown:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ArrowDown)
			f30_arg0.FUItop2:completeAnimation()
			f30_arg0.FUItop2:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.FUItop2)
		end,
		Usable = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(12)
			local f31_local0 = function(f32_arg0)
				f31_arg0.BGTopBlur:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f31_arg0.BGTopBlur:setTopBottom(0, 0, 5, 69)
				f31_arg0.BGTopBlur:setAlpha(1)
				f31_arg0.BGTopBlur:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BGTopBlur:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BGTopBlur:completeAnimation()
			f31_arg0.BGTopBlur:setTopBottom(0, 0, 15, 79)
			f31_arg0.BGTopBlur:setAlpha(0)
			f31_local0(f31_arg0.BGTopBlur)
			local f31_local1 = function(f33_arg0)
				f31_arg0.BGTop:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f31_arg0.BGTop:setTopBottom(0, 0, 5, 69)
				f31_arg0.BGTop:setAlpha(1)
				f31_arg0.BGTop:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BGTop:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BGTop:completeAnimation()
			f31_arg0.BGTop:setTopBottom(0, 0, 15, 79)
			f31_arg0.BGTop:setAlpha(0)
			f31_local1(f31_arg0.BGTop)
			local f31_local2 = function(f34_arg0)
				f31_arg0.PanelDark:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f31_arg0.PanelDark:setTopBottom(0, 0, -3.5, 79.5)
				f31_arg0.PanelDark:setAlpha(0.97)
				f31_arg0.PanelDark:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.PanelDark:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.PanelDark:completeAnimation()
			f31_arg0.PanelDark:setTopBottom(0, 0, 6.5, 89.5)
			f31_arg0.PanelDark:setAlpha(0)
			f31_arg0.PanelDark:setScale(1, 0.8)
			f31_local2(f31_arg0.PanelDark)
			local f31_local3 = function(f35_arg0)
				f31_arg0.Background:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f31_arg0.Background:setTopBottom(0, 0, -3.5, 79.5)
				f31_arg0.Background:setAlpha(0.05)
				f31_arg0.Background:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Background:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.Background:completeAnimation()
			f31_arg0.Background:setTopBottom(0, 0, 6.5, 89.5)
			f31_arg0.Background:setAlpha(0)
			f31_arg0.Background:setScale(1, 0.8)
			f31_local3(f31_arg0.Background)
			local f31_local4 = function(f36_arg0)
				f31_arg0.LED:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f31_arg0.LED:setTopBottom(0, 0, 3, 67)
				f31_arg0.LED:setAlpha(0.08)
				f31_arg0.LED:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.LED:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.LED:completeAnimation()
			f31_arg0.LED:setTopBottom(0, 0, 13, 77)
			f31_arg0.LED:setAlpha(0)
			f31_local4(f31_arg0.LED)
			local f31_local5 = function(f37_arg0)
				f31_arg0.buttonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_bounce"])
				f31_arg0.buttonInternal:setAlpha(1)
				f31_arg0.buttonInternal:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.buttonInternal:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.buttonInternal:completeAnimation()
			f31_arg0.buttonInternal:setAlpha(0)
			f31_local5(f31_arg0.buttonInternal)
			f31_arg0.Bar:completeAnimation()
			f31_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f31_arg0.clipFinished(f31_arg0.Bar)
			f31_arg0.ButtonProgressRing:completeAnimation()
			f31_arg0.ButtonProgressRing:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ButtonProgressRing)
			f31_arg0.ControllerDependentTextBox:completeAnimation()
			f31_arg0.ControllerDependentTextBox:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ControllerDependentTextBox)
			f31_arg0.ArrowUp:completeAnimation()
			f31_arg0.ArrowUp:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ArrowUp)
			f31_arg0.ArrowDown:completeAnimation()
			f31_arg0.ArrowDown:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ArrowDown)
			f31_arg0.FUItop2:completeAnimation()
			f31_arg0.FUItop2:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.FUItop2)
		end,
	},
	Usable = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(5)
			f38_arg0.PanelDark:completeAnimation()
			f38_arg0.PanelDark:setScale(1, 0.8)
			f38_arg0.clipFinished(f38_arg0.PanelDark)
			f38_arg0.Background:completeAnimation()
			f38_arg0.Background:setAlpha(0.05)
			f38_arg0.Background:setScale(1, 0.8)
			f38_arg0.clipFinished(f38_arg0.Background)
			f38_arg0.LED:completeAnimation()
			f38_arg0.LED:setAlpha(0.08)
			f38_arg0.clipFinished(f38_arg0.LED)
			f38_arg0.buttonInternal:completeAnimation()
			f38_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
			f38_arg0.clipFinished(f38_arg0.buttonInternal)
			f38_arg0.Bar:completeAnimation()
			f38_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f38_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f38_arg0.clipFinished(f38_arg0.Bar)
		end,
		Focus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(10)
			local f39_local0 = function(f40_arg0)
				f39_arg0.PanelDark:beginAnimation(230, Enum[@"luitween"][@"luitween_ease_both"])
				f39_arg0.PanelDark:setScale(1, 1)
				f39_arg0.PanelDark:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.PanelDark:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.PanelDark:completeAnimation()
			f39_arg0.PanelDark:setScale(1, 0.8)
			f39_local0(f39_arg0.PanelDark)
			local f39_local1 = function(f41_arg0)
				f39_arg0.Background:beginAnimation(230, Enum[@"luitween"][@"luitween_ease_both"])
				f39_arg0.Background:setScale(1, 1)
				f39_arg0.Background:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Background:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.Background:completeAnimation()
			f39_arg0.Background:setRGB(1, 1, 1)
			f39_arg0.Background:setAlpha(0.75)
			f39_arg0.Background:setScale(1, 0.8)
			f39_local1(f39_arg0.Background)
			f39_arg0.LED:completeAnimation()
			f39_arg0.LED:setAlpha(0.34)
			f39_arg0.clipFinished(f39_arg0.LED)
			local f39_local2 = function(f42_arg0)
				f39_arg0.buttonInternal:beginAnimation(230, Enum[@"luitween"][@"luitween_ease_both"])
				f39_arg0.buttonInternal:setScale(1.1, 1.1)
				f39_arg0.buttonInternal:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.buttonInternal:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.buttonInternal:completeAnimation()
			f39_arg0.buttonInternal:setScale(1, 1)
			f39_local2(f39_arg0.buttonInternal)
			f39_arg0.Bar:completeAnimation()
			f39_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f39_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f39_arg0.clipFinished(f39_arg0.Bar)
			f39_arg0.ButtonProgressRing:completeAnimation()
			f39_arg0.ButtonProgressRing:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ButtonProgressRing)
			f39_arg0.ControllerDependentTextBox:completeAnimation()
			f39_arg0.ControllerDependentTextBox:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ControllerDependentTextBox)
			f39_arg0.ArrowUp:completeAnimation()
			f39_arg0.ArrowUp:setLeftRight(0, 0, -41, -25)
			f39_arg0.ArrowUp:setTopBottom(0, 0, 2, 18)
			f39_arg0.ArrowUp:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ArrowUp)
			f39_arg0.ArrowDown:completeAnimation()
			f39_arg0.ArrowDown:setTopBottom(0, 0, 56, 72)
			f39_arg0.ArrowDown:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ArrowDown)
			f39_arg0.FUItop2:completeAnimation()
			f39_arg0.FUItop2:setLeftRight(0, 0, -0.5, 39.5)
			f39_arg0.FUItop2:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.FUItop2)
		end,
		DefaultState = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(12)
			local f43_local0 = function(f44_arg0)
				f43_arg0.BGTopBlur:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f43_arg0.BGTopBlur:setTopBottom(0, 0, 15, 79)
				f43_arg0.BGTopBlur:setAlpha(0)
				f43_arg0.BGTopBlur:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.BGTopBlur:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.BGTopBlur:completeAnimation()
			f43_arg0.BGTopBlur:setTopBottom(0, 0, 5, 69)
			f43_arg0.BGTopBlur:setAlpha(1)
			f43_local0(f43_arg0.BGTopBlur)
			local f43_local1 = function(f45_arg0)
				f43_arg0.BGTop:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f43_arg0.BGTop:setTopBottom(0, 0, 15, 79)
				f43_arg0.BGTop:setAlpha(0)
				f43_arg0.BGTop:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.BGTop:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.BGTop:completeAnimation()
			f43_arg0.BGTop:setTopBottom(0, 0, 5, 69)
			f43_arg0.BGTop:setAlpha(1)
			f43_local1(f43_arg0.BGTop)
			local f43_local2 = function(f46_arg0)
				f43_arg0.PanelDark:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f43_arg0.PanelDark:setTopBottom(0, 0, 6.5, 89.5)
				f43_arg0.PanelDark:setAlpha(0)
				f43_arg0.PanelDark:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.PanelDark:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.PanelDark:completeAnimation()
			f43_arg0.PanelDark:setTopBottom(0, 0, -3.5, 79.5)
			f43_arg0.PanelDark:setAlpha(0.97)
			f43_arg0.PanelDark:setScale(1, 0.8)
			f43_local2(f43_arg0.PanelDark)
			local f43_local3 = function(f47_arg0)
				f43_arg0.Background:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f43_arg0.Background:setTopBottom(0, 0, 6.5, 89.5)
				f43_arg0.Background:setAlpha(0)
				f43_arg0.Background:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.Background:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.Background:completeAnimation()
			f43_arg0.Background:setTopBottom(0, 0, -3.5, 79.5)
			f43_arg0.Background:setAlpha(0.05)
			f43_arg0.Background:setScale(1, 0.8)
			f43_local3(f43_arg0.Background)
			local f43_local4 = function(f48_arg0)
				f43_arg0.LED:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f43_arg0.LED:setTopBottom(0, 0, 13, 77)
				f43_arg0.LED:setAlpha(0)
				f43_arg0.LED:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.LED:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.LED:completeAnimation()
			f43_arg0.LED:setTopBottom(0, 0, 3, 67)
			f43_arg0.LED:setAlpha(0.08)
			f43_local4(f43_arg0.LED)
			local f43_local5 = function(f49_arg0)
				f43_arg0.buttonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_bounce"])
				f43_arg0.buttonInternal:setAlpha(0)
				f43_arg0.buttonInternal:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.buttonInternal:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.buttonInternal:completeAnimation()
			f43_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
			f43_arg0.buttonInternal:setTopBottom(0, 0, 18, 59)
			f43_arg0.buttonInternal:setAlpha(1)
			f43_local5(f43_arg0.buttonInternal)
			f43_arg0.Bar:completeAnimation()
			f43_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f43_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f43_arg0.Bar:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Bar)
			f43_arg0.ButtonProgressRing:completeAnimation()
			f43_arg0.ButtonProgressRing:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ButtonProgressRing)
			f43_arg0.ControllerDependentTextBox:completeAnimation()
			f43_arg0.ControllerDependentTextBox:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ControllerDependentTextBox)
			f43_arg0.ArrowUp:completeAnimation()
			f43_arg0.ArrowUp:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ArrowUp)
			f43_arg0.ArrowDown:completeAnimation()
			f43_arg0.ArrowDown:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ArrowDown)
			f43_arg0.FUItop2:completeAnimation()
			f43_arg0.FUItop2:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.FUItop2)
		end,
	},
	UsableKBM = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(6)
			local f50_local0 = function(f51_arg0)
				f50_arg0.PanelDark:beginAnimation(230)
				f50_arg0.PanelDark:setScale(1, 1)
				f50_arg0.PanelDark:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.PanelDark:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.PanelDark:completeAnimation()
			f50_arg0.PanelDark:setScale(1, 0.8)
			f50_local0(f50_arg0.PanelDark)
			local f50_local1 = function(f52_arg0)
				f50_arg0.Background:beginAnimation(230)
				f50_arg0.Background:setScale(1, 1)
				f50_arg0.Background:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.Background:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.Background:completeAnimation()
			f50_arg0.Background:setRGB(1, 1, 1)
			f50_arg0.Background:setAlpha(0.75)
			f50_arg0.Background:setScale(1, 0.8)
			f50_local1(f50_arg0.Background)
			f50_arg0.LED:completeAnimation()
			f50_arg0.LED:setAlpha(0.34)
			f50_arg0.clipFinished(f50_arg0.LED)
			local f50_local2 = function(f53_arg0)
				f50_arg0.buttonInternal:beginAnimation(230)
				f50_arg0.buttonInternal:setScale(1.1, 1.1)
				f50_arg0.buttonInternal:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.buttonInternal:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.buttonInternal:completeAnimation()
			f50_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
			f50_arg0.buttonInternal:setScale(1, 1)
			f50_local2(f50_arg0.buttonInternal)
			f50_arg0.Bar:completeAnimation()
			f50_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f50_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f50_arg0.clipFinished(f50_arg0.Bar)
			f50_arg0.ControllerDependentTextBox:completeAnimation()
			f50_arg0.ControllerDependentTextBox:setLeftRight(1, 1, -119, -30)
			f50_arg0.ControllerDependentTextBox:setTopBottom(0.5, 0.5, -1.5, 20.5)
			f50_arg0.ControllerDependentTextBox:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ControllerDependentTextBox)
		end,
	},
}
CoD.Support_ExtraButton.__onClose = function(f54_arg0)
	f54_arg0.buttonInternal:close()
	f54_arg0.Bar:close()
	f54_arg0.ButtonProgressRing:close()
	f54_arg0.ControllerDependentTextBox:close()
	f54_arg0.ArrowUp:close()
	f54_arg0.ArrowDown:close()
end
