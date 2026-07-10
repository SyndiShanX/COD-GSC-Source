require("x64:b79410dc8d1ea84")
CoD.SliderBar_EditBox = InheritFrom(LUI.UIElement)
CoD.SliderBar_EditBox.__defaultWidth = 65
CoD.SliderBar_EditBox.__defaultHeight = 65
CoD.SliderBar_EditBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SliderBar_EditBox)
	self.id = "SliderBar_EditBox"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EditBoxBG = LUI.UIImage.new(1, 2, -70, -70, 0.26, 1.26, -18.5, -18.5)
	EditBoxBG:setRGB(0.76, 0.76, 0.76)
	EditBoxBG:setAlpha(0)
	self:addElement(EditBoxBG)
	self.EditBoxBG = EditBoxBG
	local TextBox = LUI.UIText.new(0.5, 0.5, -31, 31, 0.5, 0.5, -9, 9)
	TextBox:setRGB(0.76, 0.76, 0.76)
	TextBox:setAlpha(0.75)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -2, 2)
	Frame:setRGB(0.2, 0.2, 0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SliderBar_EditBox.__resetProperties = function(f2_arg0)
	f2_arg0.PCHighlightBorder:completeAnimation()
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
	f2_arg0.TextBox:setAlpha(0.75)
end
CoD.SliderBar_EditBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.PCHighlightBorder:completeAnimation()
			f3_arg0.PCHighlightBorder:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.PCHighlightBorder)
		end,
		InputFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.TextBox:completeAnimation()
			f4_arg0.TextBox:setRGB(1, 1, 1)
			f4_arg0.TextBox:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.TextBox)
			f4_arg0.PCHighlightBorder:completeAnimation()
			f4_arg0.PCHighlightBorder:playClip("cFocus")
			f4_arg0.clipFinished(f4_arg0.PCHighlightBorder)
			f4_arg0.nextClip = "InputFocus"
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.TextBox:completeAnimation()
			f5_arg0.TextBox:setRGB(1, 1, 1)
			f5_arg0.TextBox:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.TextBox)
			f5_arg0.PCHighlightBorder:completeAnimation()
			f5_arg0.PCHighlightBorder:playClip("cFocus")
			f5_arg0.clipFinished(f5_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f6_arg0.TextBox:beginAnimation(150)
				f6_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
				f6_arg0.TextBox:setAlpha(0.75)
				f6_arg0.TextBox:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.TextBox:completeAnimation()
			f6_arg0.TextBox:setRGB(1, 1, 1)
			f6_arg0.TextBox:setAlpha(1)
			f6_local0(f6_arg0.TextBox)
			f6_arg0.PCHighlightBorder:completeAnimation()
			f6_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f6_arg0.clipFinished(f6_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.TextBox:beginAnimation(150)
				f8_arg0.TextBox:setRGB(1, 1, 1)
				f8_arg0.TextBox:setAlpha(1)
				f8_arg0.TextBox:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
			f8_arg0.TextBox:setAlpha(0.75)
			f8_local0(f8_arg0.TextBox)
			f8_arg0.PCHighlightBorder:completeAnimation()
			f8_arg0.PCHighlightBorder:playClip("cGainFocus")
			f8_arg0.clipFinished(f8_arg0.PCHighlightBorder)
		end,
	},
	Unavailable = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.PCHighlightBorder:completeAnimation()
			f10_arg0.PCHighlightBorder:playClip("DefaultClip")
			f10_arg0.clipFinished(f10_arg0.PCHighlightBorder)
		end,
	},
}
CoD.SliderBar_EditBox.__onClose = function(f11_arg0)
	f11_arg0.PCHighlightBorder:close()
end
