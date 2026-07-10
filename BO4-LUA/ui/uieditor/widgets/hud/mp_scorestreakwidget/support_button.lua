require("x64:f65b3780508b5c7")
require("x64:34778f864da9dda")
require("x64:7740d6a36622800")
require("x64:eb2b44d72f6861a")
require("x64:e6b26605fb6b80c")
CoD.Support_Button = InheritFrom(LUI.UIElement)
CoD.Support_Button.__defaultWidth = 40
CoD.Support_Button.__defaultHeight = 41
CoD.Support_Button.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Support_Button)
	self.id = "Support_Button"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, -22, 60, 0, 0, -19, 64)
	Background:setAlpha(0.2)
	Background:setImage(RegisterImage(0x75825763EF40352))
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Background)
	self.Background = Background
	local LED = LUI.UIImage.new(0, 0, -11.5, 52.5, 0, 0, -13, 51)
	LED:setRGB(0.79, 0.45, 0.05)
	LED:setAlpha(0)
	LED:setImage(RegisterImage(0xBA589418FAFF06D))
	self:addElement(LED)
	self.LED = LED
	local buttonInternal = CoD.Support_ButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0, 0, 2, 43)
	buttonInternal:linkToElementModel(self, nil, false, function(model)
		buttonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(buttonInternal)
	self.buttonInternal = buttonInternal
	local Bar = CoD.Support_EarningBar.new(f1_arg0, f1_arg1, 0, 0, -9, 0, 0, 0, 19, 21)
	Bar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Bar:setAlpha(0)
	Bar:linkToElementModel(self, nil, false, function(model)
		Bar:setModel(model, f1_arg1)
	end)
	self:addElement(Bar)
	self.Bar = Bar
	local ButtonProgressRing = CoD.ButtonProgressRing.new(f1_arg0, f1_arg1, 1, 1, -94, -52, 0.5, 0.5, -21, 21)
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
	local ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 1, 1, -117.5, -28.5, 0.5, 0.5, -23, 22)
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
	local Rule = Engine[0x4DF5CFBC1771947](f1_arg1)
	ArrowUp(ArrowDown, Rule["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f10_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	ArrowDown = ControllerDependentTextBox
	ArrowUp = ControllerDependentTextBox.subscribeToModel
	Rule = Engine[0x4DF5CFBC1771947](f1_arg1)
	ArrowUp(ArrowDown, Rule["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f11_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	ControllerDependentTextBox:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ControllerDependentTextBox, f12_arg1)
	end)
	ArrowDown = ControllerDependentTextBox
	ArrowUp = ControllerDependentTextBox.subscribeToModel
	Rule = Engine[0x4DF5CFBC1771947](f1_arg1)
	ArrowUp(ArrowDown, Rule.LastInput, function(f13_arg0)
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
	ControllerDependentTextBox.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
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
	ArrowUp = CoD.Support_ButtonArrow.new(f1_arg0, f1_arg1, 0, 0, -41, -25, 0, 0, -17, -1)
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
	ArrowDown = CoD.Support_ButtonArrow.new(f1_arg0, f1_arg1, 0, 0, -41, -25, 0, 0, 41, 57)
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
	Rule = LUI.UIImage.new(0, 0, 0, 40, 0, 0, -6, 2)
	Rule:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Rule:setAlpha(0)
	Rule:setImage(RegisterImage(0x44F091BA4D4DD60))
	Rule:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Rule)
	self.Rule = Rule
	local Rule2 = LUI.UIImage.new(0, 0, 0, 40, 0, 0, 41.5, 49.5)
	Rule2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Rule2:setAlpha(0)
	Rule2:setImage(RegisterImage(0x44F091BA4D4DD60))
	Rule2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Rule2)
	self.Rule2 = Rule2
	local Bar2 = LUI.UIImage.new(0, 0, -0.5, 39.5, 0, 0, 41.5, 49.5)
	Bar2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Bar2:setAlpha(0)
	Bar2:setImage(RegisterImage(0x755ACF915D91894))
	Bar2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Bar2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Bar2)
	self.Bar2 = Bar2
	local Bar3 = LUI.UIImage.new(0, 0, -0.5, 39.5, 0, 0, -6, 2)
	Bar3:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Bar3:setAlpha(0)
	Bar3:setImage(RegisterImage(0x755ACF915D91894))
	Bar3:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Bar3:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Bar3)
	self.Bar3 = Bar3
	local FUItop2 = LUI.UIImage.new(0, 0, 0.5, 40.5, 0, 0, 36, 44)
	FUItop2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	FUItop2:setAlpha(0)
	FUItop2:setImage(RegisterImage(0xD21881AE56187FC))
	FUItop2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FUItop2)
	self.FUItop2 = FUItop2
	local FUItop = LUI.UIImage.new(0, 0, 0.5, 40.5, 0, 0, -5, 3)
	FUItop:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	FUItop:setAlpha(0)
	FUItop:setImage(RegisterImage(0xD21881AE56187FC))
	FUItop:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FUItop)
	self.FUItop = FUItop
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
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local16(f1_local15, f1_local17.LastInput, function(f27_arg0)
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
CoD.Support_Button.__resetProperties = function(f29_arg0)
	f29_arg0.buttonInternal:completeAnimation()
	f29_arg0.Bar:completeAnimation()
	f29_arg0.Background:completeAnimation()
	f29_arg0.LED:completeAnimation()
	f29_arg0.ButtonProgressRing:completeAnimation()
	f29_arg0.ControllerDependentTextBox:completeAnimation()
	f29_arg0.Rule:completeAnimation()
	f29_arg0.Bar3:completeAnimation()
	f29_arg0.Bar2:completeAnimation()
	f29_arg0.Rule2:completeAnimation()
	f29_arg0.FUItop2:completeAnimation()
	f29_arg0.FUItop:completeAnimation()
	f29_arg0.ArrowUp:completeAnimation()
	f29_arg0.ArrowDown:completeAnimation()
	f29_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
	f29_arg0.buttonInternal:setTopBottom(0, 0, 2, 43)
	f29_arg0.buttonInternal:setScale(1, 1)
	f29_arg0.Bar:setLeftRight(0, 0, -9, 0)
	f29_arg0.Bar:setTopBottom(0, 0, 19, 21)
	f29_arg0.Background:setRGB(1, 1, 1)
	f29_arg0.Background:setAlpha(0.2)
	f29_arg0.Background:setScale(1, 1)
	f29_arg0.LED:setAlpha(0)
	f29_arg0.ButtonProgressRing:setAlpha(0)
	f29_arg0.ControllerDependentTextBox:setLeftRight(1, 1, -117.5, -28.5)
	f29_arg0.ControllerDependentTextBox:setTopBottom(0.5, 0.5, -23, 22)
	f29_arg0.ControllerDependentTextBox:setAlpha(0)
	f29_arg0.Rule:setAlpha(0)
	f29_arg0.Bar3:setAlpha(0)
	f29_arg0.Bar2:setAlpha(0)
	f29_arg0.Rule2:setAlpha(0)
	f29_arg0.FUItop2:setLeftRight(0, 0, 0.5, 40.5)
	f29_arg0.FUItop2:setAlpha(0)
	f29_arg0.FUItop:setLeftRight(0, 0, 0.5, 40.5)
	f29_arg0.FUItop:setAlpha(0)
	f29_arg0.ArrowUp:setLeftRight(0, 0, -41, -25)
	f29_arg0.ArrowUp:setTopBottom(0, 0, -17, -1)
	f29_arg0.ArrowUp:setAlpha(0)
	f29_arg0.ArrowDown:setTopBottom(0, 0, 41, 57)
	f29_arg0.ArrowDown:setAlpha(0)
end
CoD.Support_Button.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.Background:completeAnimation()
			f30_arg0.Background:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Background)
			f30_arg0.buttonInternal:completeAnimation()
			f30_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
			f30_arg0.buttonInternal:setTopBottom(0, 0, 0, 41)
			f30_arg0.clipFinished(f30_arg0.buttonInternal)
			f30_arg0.Bar:completeAnimation()
			f30_arg0.Bar:setLeftRight(0, 0, -6, 3)
			f30_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f30_arg0.clipFinished(f30_arg0.Bar)
		end,
	},
	Usable = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(4)
			f31_arg0.Background:completeAnimation()
			f31_arg0.Background:setAlpha(0.05)
			f31_arg0.Background:setScale(1, 0.8)
			f31_arg0.clipFinished(f31_arg0.Background)
			f31_arg0.LED:completeAnimation()
			f31_arg0.LED:setAlpha(0.08)
			f31_arg0.clipFinished(f31_arg0.LED)
			f31_arg0.buttonInternal:completeAnimation()
			f31_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
			f31_arg0.buttonInternal:setTopBottom(0, 0, 0, 41)
			f31_arg0.clipFinished(f31_arg0.buttonInternal)
			f31_arg0.Bar:completeAnimation()
			f31_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f31_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f31_arg0.clipFinished(f31_arg0.Bar)
		end,
		Focus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(14)
			local f32_local0 = function(f33_arg0)
				f32_arg0.Background:beginAnimation(230, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f32_arg0.Background:setScale(1, 1)
				f32_arg0.Background:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Background:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.Background:completeAnimation()
			f32_arg0.Background:setRGB(1, 1, 1)
			f32_arg0.Background:setAlpha(0.75)
			f32_arg0.Background:setScale(1, 0.8)
			f32_local0(f32_arg0.Background)
			f32_arg0.LED:completeAnimation()
			f32_arg0.LED:setAlpha(0.34)
			f32_arg0.clipFinished(f32_arg0.LED)
			local f32_local1 = function(f34_arg0)
				f32_arg0.buttonInternal:beginAnimation(230, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f32_arg0.buttonInternal:setScale(1.1, 1.1)
				f32_arg0.buttonInternal:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.buttonInternal:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.buttonInternal:completeAnimation()
			f32_arg0.buttonInternal:setScale(1, 1)
			f32_local1(f32_arg0.buttonInternal)
			f32_arg0.Bar:completeAnimation()
			f32_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f32_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f32_arg0.clipFinished(f32_arg0.Bar)
			f32_arg0.ButtonProgressRing:completeAnimation()
			f32_arg0.ButtonProgressRing:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ButtonProgressRing)
			f32_arg0.ControllerDependentTextBox:completeAnimation()
			f32_arg0.ControllerDependentTextBox:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ControllerDependentTextBox)
			f32_arg0.ArrowUp:completeAnimation()
			f32_arg0.ArrowUp:setLeftRight(0, 0, -41, -25)
			f32_arg0.ArrowUp:setTopBottom(0, 0, -15, 1)
			f32_arg0.ArrowUp:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ArrowUp)
			f32_arg0.ArrowDown:completeAnimation()
			f32_arg0.ArrowDown:setTopBottom(0, 0, 39, 55)
			f32_arg0.ArrowDown:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ArrowDown)
			f32_arg0.Rule:completeAnimation()
			f32_arg0.Rule:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.Rule)
			f32_arg0.Rule2:completeAnimation()
			f32_arg0.Rule2:setAlpha(0.93)
			f32_arg0.clipFinished(f32_arg0.Rule2)
			f32_arg0.Bar2:completeAnimation()
			f32_arg0.Bar2:setAlpha(0.93)
			f32_arg0.clipFinished(f32_arg0.Bar2)
			f32_arg0.Bar3:completeAnimation()
			f32_arg0.Bar3:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.Bar3)
			f32_arg0.FUItop2:completeAnimation()
			f32_arg0.FUItop2:setLeftRight(0, 0, -0.5, 39.5)
			f32_arg0.FUItop2:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.FUItop2)
			f32_arg0.FUItop:completeAnimation()
			f32_arg0.FUItop:setLeftRight(0, 0, -0.5, 39.5)
			f32_arg0.FUItop:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.FUItop)
		end,
	},
	UsableKBM = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(5)
			local f35_local0 = function(f36_arg0)
				f35_arg0.Background:beginAnimation(230)
				f35_arg0.Background:setScale(1, 1)
				f35_arg0.Background:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Background:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Background:completeAnimation()
			f35_arg0.Background:setRGB(1, 1, 1)
			f35_arg0.Background:setAlpha(0.75)
			f35_arg0.Background:setScale(1, 0.8)
			f35_local0(f35_arg0.Background)
			f35_arg0.LED:completeAnimation()
			f35_arg0.LED:setAlpha(0.34)
			f35_arg0.clipFinished(f35_arg0.LED)
			local f35_local1 = function(f37_arg0)
				f35_arg0.buttonInternal:beginAnimation(230)
				f35_arg0.buttonInternal:setScale(1.1, 1.1)
				f35_arg0.buttonInternal:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.buttonInternal:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.buttonInternal:completeAnimation()
			f35_arg0.buttonInternal:setLeftRight(0, 0, 0, 40)
			f35_arg0.buttonInternal:setTopBottom(0, 0, 0, 41)
			f35_arg0.buttonInternal:setScale(1, 1)
			f35_local1(f35_arg0.buttonInternal)
			f35_arg0.Bar:completeAnimation()
			f35_arg0.Bar:setLeftRight(0, 0, -18, -9)
			f35_arg0.Bar:setTopBottom(0, 0, 19, 21)
			f35_arg0.clipFinished(f35_arg0.Bar)
			f35_arg0.ControllerDependentTextBox:completeAnimation()
			f35_arg0.ControllerDependentTextBox:setLeftRight(1, 1, -119, -30)
			f35_arg0.ControllerDependentTextBox:setTopBottom(0.5, 0.5, -1.5, 20.5)
			f35_arg0.ControllerDependentTextBox:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.ControllerDependentTextBox)
		end,
	},
}
CoD.Support_Button.__onClose = function(f38_arg0)
	f38_arg0.buttonInternal:close()
	f38_arg0.Bar:close()
	f38_arg0.ButtonProgressRing:close()
	f38_arg0.ControllerDependentTextBox:close()
	f38_arg0.ArrowUp:close()
	f38_arg0.ArrowDown:close()
end
