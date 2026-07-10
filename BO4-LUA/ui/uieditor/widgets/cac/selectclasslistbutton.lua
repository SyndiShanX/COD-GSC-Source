require("x64:9ef8e7ef66dcc85")
CoD.SelectClassListButton = InheritFrom(LUI.UIElement)
CoD.SelectClassListButton.__defaultWidth = 170
CoD.SelectClassListButton.__defaultHeight = 35
CoD.SelectClassListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SelectClassListButton)
	self.id = "SelectClassListButton"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ImageGlow = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -34, 0)
	ImageGlow:setAlpha(0)
	ImageGlow:setImage(RegisterImage(0x7B23E8B1ACF3472))
	self:addElement(ImageGlow)
	self.ImageGlow = ImageGlow
	local BottomLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 0)
	BottomLine:setRGB(0.39, 0.39, 0.39)
	BottomLine:setAlpha(0)
	self:addElement(BottomLine)
	self.BottomLine = BottomLine
	local ClassName = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -9, 9)
	ClassName:setRGB(0.39, 0.39, 0.39)
	ClassName:setTTF("notosans_regular")
	ClassName:setLetterSpacing(3)
	ClassName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ClassName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ClassName:linkToElementModel(self, "customClassName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClassName:setText(ToUpper(f2_local0))
		end
	end)
	self:addElement(ClassName)
	self.ClassName = ClassName
	local ClassName2 = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -9, 9)
	ClassName2:setRGB(0.92, 0.89, 0.72)
	ClassName2:setAlpha(0)
	ClassName2:setTTF("notosans_bold")
	ClassName2:setLetterSpacing(3)
	ClassName2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ClassName2:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ClassName2:linkToElementModel(self, "customClassName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ClassName2:setText(ToUpper(f3_local0))
		end
	end)
	self:addElement(ClassName2)
	self.ClassName2 = ClassName2
	local BracketLeft = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -6, 0)
	BracketLeft:setRGB(0.63, 0.62, 0.61)
	BracketLeft:setAlpha(0)
	self:addElement(BracketLeft)
	self.BracketLeft = BracketLeft
	local BracketRight = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -6, 0)
	BracketRight:setRGB(0.63, 0.62, 0.61)
	BracketRight:setAlpha(0)
	self:addElement(BracketRight)
	self.BracketRight = BracketRight
	local vhudButtonPromptMinimal = CoD.vhud_ButtonPrompt_Minimal.new(f1_arg0, f1_arg1, 0, 0, 32.5, 177.5, 0, 0, -42, -10)
	vhudButtonPromptMinimal:mergeStateConditions({
		{
			stateName = "NotInUse",
			condition = function(menu, element, event)
				local f4_local0
				if not IsPC() then
					f4_local0 = CoD.CACUtility.IsCurrentElementClassLocked(menu, self, f1_arg1)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "CoolingDownHideButton",
			condition = function(menu, element, event)
				local f6_local0
				if not IsPC() then
					f6_local0 = AlwaysFalse()
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "hideButtonImage",
			condition = function(menu, element, event)
				local f7_local0
				if not IsPC() then
					f7_local0 = AlwaysFalse()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
		{
			stateName = "CoolingDown",
			condition = function(menu, element, event)
				local f8_local0
				if not IsPC() then
					f8_local0 = AlwaysFalse()
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
		{
			stateName = "ChooseClassPCGamepad",
			condition = function(menu, element, event)
				return IsPC() and IsGamepad(f1_arg1)
			end,
		},
	})
	vhudButtonPromptMinimal:linkToElementModel(vhudButtonPromptMinimal, nil, true, function(model)
		f1_arg0:updateElementState(vhudButtonPromptMinimal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	local f1_local8 = vhudButtonPromptMinimal
	local f1_local9 = vhudButtonPromptMinimal.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.isCoDCaster"], function(f11_arg0)
		f1_arg0:updateElementState(vhudButtonPromptMinimal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	vhudButtonPromptMinimal:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(vhudButtonPromptMinimal, f12_arg1)
	end)
	f1_local8 = vhudButtonPromptMinimal
	f1_local9 = vhudButtonPromptMinimal.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f13_arg0)
		f1_arg0:updateElementState(vhudButtonPromptMinimal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	vhudButtonPromptMinimal:setAlpha(0)
	vhudButtonPromptMinimal.prompt:setText(Engine[0xF9F1239CFD921FE](0xAC3B80C833B60E1))
	vhudButtonPromptMinimal:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			vhudButtonPromptMinimal.button:setImage(RegisterImage(f14_local0))
		end
	end)
	self:addElement(vhudButtonPromptMinimal)
	self.vhudButtonPromptMinimal = vhudButtonPromptMinimal
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f16_arg1)
	end)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SelectClassListButton.__resetProperties = function(f18_arg0)
	f18_arg0.BottomLine:completeAnimation()
	f18_arg0.ImageGlow:completeAnimation()
	f18_arg0.ClassName2:completeAnimation()
	f18_arg0.BracketRight:completeAnimation()
	f18_arg0.BracketLeft:completeAnimation()
	f18_arg0.ClassName:completeAnimation()
	f18_arg0.vhudButtonPromptMinimal:completeAnimation()
	f18_arg0.BottomLine:setRGB(0.39, 0.39, 0.39)
	f18_arg0.BottomLine:setAlpha(0)
	f18_arg0.ImageGlow:setAlpha(0)
	f18_arg0.ClassName2:setAlpha(0)
	f18_arg0.BracketRight:setRGB(0.63, 0.62, 0.61)
	f18_arg0.BracketRight:setAlpha(0)
	f18_arg0.BracketLeft:setRGB(0.63, 0.62, 0.61)
	f18_arg0.BracketLeft:setAlpha(0)
	f18_arg0.ClassName:setRGB(0.39, 0.39, 0.39)
	f18_arg0.ClassName:setAlpha(1)
	f18_arg0.vhudButtonPromptMinimal:setLeftRight(0, 0, 32.5, 177.5)
	f18_arg0.vhudButtonPromptMinimal:setTopBottom(0, 0, -42, -10)
	f18_arg0.vhudButtonPromptMinimal:setAlpha(0)
end
CoD.SelectClassListButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.ImageGlow:completeAnimation()
			f19_arg0.ImageGlow:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ImageGlow)
			f19_arg0.BottomLine:completeAnimation()
			f19_arg0.BottomLine:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BottomLine)
			f19_arg0.ClassName2:completeAnimation()
			f19_arg0.ClassName2:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ClassName2)
		end,
		Active = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
			local f20_local0 = function(f21_arg0)
				f20_arg0.ImageGlow:beginAnimation(150)
				f20_arg0.ImageGlow:setAlpha(1)
				f20_arg0.ImageGlow:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ImageGlow:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ImageGlow:completeAnimation()
			f20_arg0.ImageGlow:setAlpha(0)
			f20_local0(f20_arg0.ImageGlow)
			local f20_local1 = function(f22_arg0)
				f20_arg0.BottomLine:beginAnimation(150)
				f20_arg0.BottomLine:setRGB(0.92, 0.89, 0.72)
				f20_arg0.BottomLine:setAlpha(1)
				f20_arg0.BottomLine:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BottomLine:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.BottomLine:completeAnimation()
			f20_arg0.BottomLine:setRGB(0.39, 0.39, 0.39)
			f20_arg0.BottomLine:setAlpha(0)
			f20_local1(f20_arg0.BottomLine)
			local f20_local2 = function(f23_arg0)
				f20_arg0.ClassName:beginAnimation(150)
				f20_arg0.ClassName:setAlpha(0)
				f20_arg0.ClassName:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ClassName:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ClassName:completeAnimation()
			f20_arg0.ClassName:setRGB(0.39, 0.39, 0.39)
			f20_arg0.ClassName:setAlpha(1)
			f20_local2(f20_arg0.ClassName)
			local f20_local3 = function(f24_arg0)
				f20_arg0.ClassName2:beginAnimation(150)
				f20_arg0.ClassName2:setAlpha(1)
				f20_arg0.ClassName2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ClassName2:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ClassName2:completeAnimation()
			f20_arg0.ClassName2:setAlpha(0)
			f20_local3(f20_arg0.ClassName2)
			local f20_local4 = function(f25_arg0)
				f20_arg0.BracketLeft:beginAnimation(150)
				f20_arg0.BracketLeft:setRGB(0.92, 0.89, 0.72)
				f20_arg0.BracketLeft:setAlpha(1)
				f20_arg0.BracketLeft:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BracketLeft:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.BracketLeft:completeAnimation()
			f20_arg0.BracketLeft:setRGB(0.92, 0.92, 0.92)
			f20_arg0.BracketLeft:setAlpha(0)
			f20_local4(f20_arg0.BracketLeft)
			local f20_local5 = function(f26_arg0)
				f20_arg0.BracketRight:beginAnimation(150)
				f20_arg0.BracketRight:setRGB(0.92, 0.89, 0.72)
				f20_arg0.BracketRight:setAlpha(1)
				f20_arg0.BracketRight:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BracketRight:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.BracketRight:completeAnimation()
			f20_arg0.BracketRight:setRGB(0.92, 0.92, 0.92)
			f20_arg0.BracketRight:setAlpha(0)
			f20_local5(f20_arg0.BracketRight)
			local f20_local6 = function(f27_arg0)
				f20_arg0.vhudButtonPromptMinimal:beginAnimation(150)
				f20_arg0.vhudButtonPromptMinimal:setAlpha(1)
				f20_arg0.vhudButtonPromptMinimal:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.vhudButtonPromptMinimal:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.vhudButtonPromptMinimal:completeAnimation()
			f20_arg0.vhudButtonPromptMinimal:setLeftRight(0.5, 0.5, -72.5, 72.5)
			f20_arg0.vhudButtonPromptMinimal:setTopBottom(0, 0, -44, -12)
			f20_arg0.vhudButtonPromptMinimal:setAlpha(0)
			f20_local6(f20_arg0.vhudButtonPromptMinimal)
		end,
		Focus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.ImageGlow:completeAnimation()
			f28_arg0.ImageGlow:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ImageGlow)
			f28_arg0.BottomLine:completeAnimation()
			f28_arg0.BottomLine:setRGB(0.92, 0.89, 0.72)
			f28_arg0.BottomLine:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.BottomLine)
			f28_arg0.ClassName:completeAnimation()
			f28_arg0.ClassName:setRGB(0.39, 0.39, 0.39)
			f28_arg0.ClassName:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ClassName)
			f28_arg0.ClassName2:completeAnimation()
			f28_arg0.ClassName2:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.ClassName2)
			f28_arg0.vhudButtonPromptMinimal:completeAnimation()
			f28_arg0.vhudButtonPromptMinimal:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.vhudButtonPromptMinimal)
		end,
		ActiveAndFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(7)
			f29_arg0.ImageGlow:completeAnimation()
			f29_arg0.ImageGlow:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.ImageGlow)
			f29_arg0.BottomLine:completeAnimation()
			f29_arg0.BottomLine:setRGB(0.92, 0.89, 0.72)
			f29_arg0.BottomLine:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.BottomLine)
			f29_arg0.ClassName:completeAnimation()
			f29_arg0.ClassName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f29_arg0.ClassName:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ClassName)
			f29_arg0.ClassName2:completeAnimation()
			f29_arg0.ClassName2:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.ClassName2)
			f29_arg0.BracketLeft:completeAnimation()
			f29_arg0.BracketLeft:setRGB(0.92, 0.89, 0.72)
			f29_arg0.BracketLeft:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.BracketLeft)
			f29_arg0.BracketRight:completeAnimation()
			f29_arg0.BracketRight:setRGB(0.92, 0.89, 0.72)
			f29_arg0.BracketRight:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.BracketRight)
			f29_arg0.vhudButtonPromptMinimal:completeAnimation()
			f29_arg0.vhudButtonPromptMinimal:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.vhudButtonPromptMinimal)
		end,
	},
	KBM = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.ImageGlow:completeAnimation()
			f30_arg0.ImageGlow:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ImageGlow)
			f30_arg0.BottomLine:completeAnimation()
			f30_arg0.BottomLine:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.BottomLine)
			f30_arg0.ClassName2:completeAnimation()
			f30_arg0.ClassName2:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ClassName2)
		end,
		Active = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(7)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ImageGlow:beginAnimation(150)
				f31_arg0.ImageGlow:setAlpha(1)
				f31_arg0.ImageGlow:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ImageGlow:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ImageGlow:completeAnimation()
			f31_arg0.ImageGlow:setAlpha(0)
			f31_local0(f31_arg0.ImageGlow)
			local f31_local1 = function(f33_arg0)
				f31_arg0.BottomLine:beginAnimation(150)
				f31_arg0.BottomLine:setRGB(0.92, 0.89, 0.72)
				f31_arg0.BottomLine:setAlpha(1)
				f31_arg0.BottomLine:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BottomLine:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BottomLine:completeAnimation()
			f31_arg0.BottomLine:setRGB(0.39, 0.39, 0.39)
			f31_arg0.BottomLine:setAlpha(0)
			f31_local1(f31_arg0.BottomLine)
			local f31_local2 = function(f34_arg0)
				f31_arg0.ClassName:beginAnimation(150)
				f31_arg0.ClassName:setAlpha(0)
				f31_arg0.ClassName:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ClassName:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ClassName:completeAnimation()
			f31_arg0.ClassName:setRGB(0.39, 0.39, 0.39)
			f31_arg0.ClassName:setAlpha(1)
			f31_local2(f31_arg0.ClassName)
			local f31_local3 = function(f35_arg0)
				f31_arg0.ClassName2:beginAnimation(150)
				f31_arg0.ClassName2:setAlpha(1)
				f31_arg0.ClassName2:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ClassName2:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ClassName2:completeAnimation()
			f31_arg0.ClassName2:setAlpha(0)
			f31_local3(f31_arg0.ClassName2)
			local f31_local4 = function(f36_arg0)
				f31_arg0.BracketLeft:beginAnimation(150)
				f31_arg0.BracketLeft:setRGB(0.92, 0.89, 0.72)
				f31_arg0.BracketLeft:setAlpha(1)
				f31_arg0.BracketLeft:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BracketLeft:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BracketLeft:completeAnimation()
			f31_arg0.BracketLeft:setRGB(0.92, 0.92, 0.92)
			f31_arg0.BracketLeft:setAlpha(0)
			f31_local4(f31_arg0.BracketLeft)
			local f31_local5 = function(f37_arg0)
				f31_arg0.BracketRight:beginAnimation(150)
				f31_arg0.BracketRight:setRGB(0.92, 0.89, 0.72)
				f31_arg0.BracketRight:setAlpha(1)
				f31_arg0.BracketRight:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BracketRight:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BracketRight:completeAnimation()
			f31_arg0.BracketRight:setRGB(0.92, 0.92, 0.92)
			f31_arg0.BracketRight:setAlpha(0)
			f31_local5(f31_arg0.BracketRight)
			f31_arg0.vhudButtonPromptMinimal:completeAnimation()
			f31_arg0.vhudButtonPromptMinimal:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.vhudButtonPromptMinimal)
		end,
		Focus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(4)
			f38_arg0.ImageGlow:completeAnimation()
			f38_arg0.ImageGlow:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ImageGlow)
			f38_arg0.BottomLine:completeAnimation()
			f38_arg0.BottomLine:setRGB(0.92, 0.89, 0.72)
			f38_arg0.BottomLine:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.BottomLine)
			f38_arg0.ClassName:completeAnimation()
			f38_arg0.ClassName:setRGB(0.39, 0.39, 0.39)
			f38_arg0.ClassName:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ClassName)
			f38_arg0.ClassName2:completeAnimation()
			f38_arg0.ClassName2:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.ClassName2)
		end,
		ActiveAndFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(6)
			f39_arg0.ImageGlow:completeAnimation()
			f39_arg0.ImageGlow:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ImageGlow)
			f39_arg0.BottomLine:completeAnimation()
			f39_arg0.BottomLine:setRGB(0.92, 0.89, 0.72)
			f39_arg0.BottomLine:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.BottomLine)
			f39_arg0.ClassName:completeAnimation()
			f39_arg0.ClassName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f39_arg0.ClassName:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ClassName)
			f39_arg0.ClassName2:completeAnimation()
			f39_arg0.ClassName2:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ClassName2)
			f39_arg0.BracketLeft:completeAnimation()
			f39_arg0.BracketLeft:setRGB(0.92, 0.89, 0.72)
			f39_arg0.BracketLeft:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.BracketLeft)
			f39_arg0.BracketRight:completeAnimation()
			f39_arg0.BracketRight:setRGB(0.92, 0.89, 0.72)
			f39_arg0.BracketRight:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.BracketRight)
		end,
	},
}
if not CoD.isPC then
	CoD.SelectClassListButton.__clipsPerState.DefaultState.Focus = nil
	CoD.SelectClassListButton.__clipsPerState.DefaultState.ActiveAndFocus = nil
	CoD.SelectClassListButton.__clipsPerState.KBM.DefaultClip = nil
	CoD.SelectClassListButton.__clipsPerState.KBM.Focus = nil
	CoD.SelectClassListButton.__clipsPerState.KBM.ActiveAndFocus = nil
end
CoD.SelectClassListButton.__onClose = function(f40_arg0)
	f40_arg0.ClassName:close()
	f40_arg0.ClassName2:close()
	f40_arg0.vhudButtonPromptMinimal:close()
end
