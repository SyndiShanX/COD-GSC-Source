require("x64:f5303f981058fb7")
CoD.EmblemEditorGradientSliderBar = InheritFrom(LUI.UIElement)
CoD.EmblemEditorGradientSliderBar.__defaultWidth = 800
CoD.EmblemEditorGradientSliderBar.__defaultHeight = 20
CoD.EmblemEditorGradientSliderBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorGradientSliderBar)
	self.id = "EmblemEditorGradientSliderBar"
	self.soundSet = "SelectColor_ColorMixer"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local barBg3 = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	barBg3:setAlpha(0.05)
	self:addElement(barBg3)
	self.barBg3 = barBg3
	local BgWhite = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgWhite:setAlpha(0.2)
	self:addElement(BgWhite)
	self.BgWhite = BgWhite
	local Frame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	Frame:setAlpha(0.5)
	Frame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(4, 4)
	self:addElement(Frame)
	self.Frame = Frame
	local bar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_gradient_normal"))
	bar:setShaderVector(0, 0, 0, 0, 1)
	bar:setShaderVector(1, 1, 1, 1, 1)
	bar:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(bar)
	self.bar = bar
	local pointer = CoD.EmblemEditorColorMixerPointer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 2.5, 0, 1, 0, 0)
	self:addElement(pointer)
	self.pointer = pointer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	if IsPC() then
		CoD.PCUtility.SetGradientSliderDrag(self, f1_arg1)
	end
	return self
end
CoD.EmblemEditorGradientSliderBar.__resetProperties = function(f2_arg0)
	f2_arg0.pointer:completeAnimation()
	f2_arg0.barBg3:completeAnimation()
	f2_arg0.Frame:completeAnimation()
	f2_arg0.pointer:setRGB(1, 1, 1)
	f2_arg0.barBg3:setRGB(1, 1, 1)
	f2_arg0.barBg3:setAlpha(0.05)
	f2_arg0.Frame:setRGB(1, 1, 1)
end
CoD.EmblemEditorGradientSliderBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.barBg3:completeAnimation()
			f4_arg0.barBg3:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.barBg3:setAlpha(0.3)
			f4_arg0.clipFinished(f4_arg0.barBg3)
			f4_arg0.Frame:completeAnimation()
			f4_arg0.Frame:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.Frame)
			f4_arg0.pointer:completeAnimation()
			f4_arg0.pointer:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.pointer)
		end,
	},
}
CoD.EmblemEditorGradientSliderBar.__onClose = function(f5_arg0)
	f5_arg0.pointer:close()
end
