require("x64:b79410dc8d1ea84")
CoD.PC_ClassOptionRenameBox = InheritFrom(LUI.UIElement)
CoD.PC_ClassOptionRenameBox.__defaultWidth = 412
CoD.PC_ClassOptionRenameBox.__defaultHeight = 30
CoD.PC_ClassOptionRenameBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "RenameClassText")
	self:setClass(CoD.PC_ClassOptionRenameBox)
	self.id = "PC_ClassOptionRenameBox"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.2)
	self:addElement(Background)
	self.Background = Background
	local ClassNameText = LUI.UIText.new(0, 1, 10, -10, 0.5, 0.5, -12, 12)
	ClassNameText:setAlpha(0.4)
	ClassNameText:setTTF("notosans_regular")
	ClassNameText:setLetterSpacing(2)
	ClassNameText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ClassNameText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ClassNameText:subscribeToGlobalModel(f1_arg1, "CACClassOptions", "customClassName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClassNameText:setText(f2_local0)
		end
	end)
	self:addElement(ClassNameText)
	self.ClassNameText = ClassNameText
	local TextBox = LUI.UIText.new(0, 1, 10, -10, 0.5, 0.5, -12, 12)
	TextBox:setAlpha(0)
	TextBox:setText("")
	TextBox:setTTF("notosans_regular")
	TextBox:setLetterSpacing(2)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	self:mergeStateConditions({
		{
			stateName = "InputState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "RenameClassText")
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.RenameClassText, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "RenameClassText",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	if IsPC() then
		CoD.PCUtility.SetEditBoxMaxChar(self, 16)
		CoD.BaseUtility.SetUseStencil(self)
		CoD.PCUtility.MakeEditBoxRealTime(self, "RenameClassText")
		CoD.PCUtility.SetupEditControlWithControllerModel(self, f1_arg1, f1_arg0, "RenameClassText")
	end
	DisableModelStringReplacement(TextBox)
	return self
end
CoD.PC_ClassOptionRenameBox.__resetProperties = function(f5_arg0)
	f5_arg0.PCHighlightBorder:completeAnimation()
	f5_arg0.ClassNameText:completeAnimation()
	f5_arg0.TextBox:completeAnimation()
	f5_arg0.ClassNameText:setRGB(1, 1, 1)
	f5_arg0.ClassNameText:setAlpha(0.4)
	f5_arg0.TextBox:setAlpha(0)
end
CoD.PC_ClassOptionRenameBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.PCHighlightBorder:completeAnimation()
			f6_arg0.PCHighlightBorder:playClip("DefaultClip")
			f6_arg0.clipFinished(f6_arg0.PCHighlightBorder)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.ClassNameText:completeAnimation()
			f7_arg0.ClassNameText:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.ClassNameText)
			f7_arg0.PCHighlightBorder:completeAnimation()
			f7_arg0.PCHighlightBorder:playClip("cFocus")
			f7_arg0.clipFinished(f7_arg0.PCHighlightBorder)
		end,
		InputFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.ClassNameText:completeAnimation()
			f8_arg0.ClassNameText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f8_arg0.ClassNameText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ClassNameText)
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.TextBox)
			f8_arg0.PCHighlightBorder:completeAnimation()
			f8_arg0.PCHighlightBorder:playClip("cFocus")
			f8_arg0.clipFinished(f8_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.ClassNameText:beginAnimation(150)
				f9_arg0.ClassNameText:setAlpha(1)
				f9_arg0.ClassNameText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ClassNameText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ClassNameText:completeAnimation()
			f9_arg0.ClassNameText:setAlpha(0.4)
			f9_local0(f9_arg0.ClassNameText)
			f9_arg0.PCHighlightBorder:completeAnimation()
			f9_arg0.PCHighlightBorder:playClip("cGainFocus")
			f9_arg0.clipFinished(f9_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.ClassNameText:beginAnimation(150)
				f11_arg0.ClassNameText:setAlpha(0.4)
				f11_arg0.ClassNameText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ClassNameText:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ClassNameText:completeAnimation()
			f11_arg0.ClassNameText:setAlpha(1)
			f11_local0(f11_arg0.ClassNameText)
			f11_arg0.PCHighlightBorder:completeAnimation()
			f11_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f11_arg0.clipFinished(f11_arg0.PCHighlightBorder)
		end,
	},
	InputState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.ClassNameText:completeAnimation()
			f13_arg0.ClassNameText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ClassNameText)
			f13_arg0.TextBox:completeAnimation()
			f13_arg0.TextBox:setAlpha(0.4)
			f13_arg0.clipFinished(f13_arg0.TextBox)
			f13_arg0.PCHighlightBorder:completeAnimation()
			f13_arg0.PCHighlightBorder:playClip("DefaultClip")
			f13_arg0.clipFinished(f13_arg0.PCHighlightBorder)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.ClassNameText:completeAnimation()
			f14_arg0.ClassNameText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f14_arg0.ClassNameText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ClassNameText)
			f14_arg0.TextBox:completeAnimation()
			f14_arg0.TextBox:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.TextBox)
			f14_arg0.PCHighlightBorder:completeAnimation()
			f14_arg0.PCHighlightBorder:playClip("cFocus")
			f14_arg0.clipFinished(f14_arg0.PCHighlightBorder)
		end,
		InputFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.ClassNameText:completeAnimation()
			f15_arg0.ClassNameText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f15_arg0.ClassNameText:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ClassNameText)
			f15_arg0.TextBox:completeAnimation()
			f15_arg0.TextBox:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.TextBox)
			f15_arg0.PCHighlightBorder:completeAnimation()
			f15_arg0.PCHighlightBorder:playClip("cFocus")
			f15_arg0.clipFinished(f15_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				f16_arg0.ClassNameText:beginAnimation(150)
				f16_arg0.ClassNameText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f16_arg0.ClassNameText:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ClassNameText:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ClassNameText:completeAnimation()
			f16_arg0.ClassNameText:setRGB(1, 1, 1)
			f16_arg0.ClassNameText:setAlpha(0)
			f16_local0(f16_arg0.ClassNameText)
			local f16_local1 = function(f18_arg0)
				f16_arg0.TextBox:beginAnimation(150)
				f16_arg0.TextBox:setAlpha(1)
				f16_arg0.TextBox:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.TextBox:completeAnimation()
			f16_arg0.TextBox:setAlpha(0.4)
			f16_local1(f16_arg0.TextBox)
			f16_arg0.PCHighlightBorder:completeAnimation()
			f16_arg0.PCHighlightBorder:playClip("cGainFocus")
			f16_arg0.clipFinished(f16_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ClassNameText:beginAnimation(150)
				f19_arg0.ClassNameText:setRGB(1, 1, 1)
				f19_arg0.ClassNameText:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ClassNameText:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ClassNameText:completeAnimation()
			f19_arg0.ClassNameText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f19_arg0.ClassNameText:setAlpha(0)
			f19_local0(f19_arg0.ClassNameText)
			f19_arg0.TextBox:completeAnimation()
			f19_arg0.TextBox:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.TextBox)
			f19_arg0.PCHighlightBorder:completeAnimation()
			f19_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f19_arg0.clipFinished(f19_arg0.PCHighlightBorder)
		end,
	},
}
CoD.PC_ClassOptionRenameBox.__onClose = function(f21_arg0)
	f21_arg0.ClassNameText:close()
	f21_arg0.TextBox:close()
	f21_arg0.PCHighlightBorder:close()
end
