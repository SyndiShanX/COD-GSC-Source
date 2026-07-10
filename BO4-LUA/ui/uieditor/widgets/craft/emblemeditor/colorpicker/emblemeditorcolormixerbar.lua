require("x64:acbf06924421e35")
require("x64:f5303f981058fb7")
CoD.EmblemEditorColorMixerBar = InheritFrom(LUI.UIElement)
CoD.EmblemEditorColorMixerBar.__defaultWidth = 552
CoD.EmblemEditorColorMixerBar.__defaultHeight = 20
CoD.EmblemEditorColorMixerBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorColorMixerBar)
	self.id = "EmblemEditorColorMixerBar"
	self.soundSet = "SelectColor_ColorMixer"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	Frame:setAlpha(0.5)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(4, 4)
	self:addElement(Frame)
	self.Frame = Frame
	local barBg = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	barBg:setAlpha(0.05)
	self:addElement(barBg)
	self.barBg = barBg
	local bar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bar:setMaterial(LUI.UIImage.GetCachedMaterial(0x28C8EA936A933BE))
	bar:setShaderVector(0, 0, 0, 0, 1)
	bar:setShaderVector(1, 1, 1, 1, 1)
	self:addElement(bar)
	self.bar = bar
	local pointer = CoD.EmblemEditorColorMixerPointer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 2.5, 0, 1, 0, 0)
	self:addElement(pointer)
	self.pointer = pointer
	local RightArrow = LUI.UIImage.new(1, 1, 10, 20, 0, 0, 0, 20)
	RightArrow:setImage(RegisterImage(0x1226A0CC6137EEE))
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	local LeftArrow = LUI.UIImage.new(0, 0, -20, -10, 0, 0, 0, 20)
	LeftArrow:setZRot(180)
	LeftArrow:setImage(RegisterImage(0x1226A0CC6137EEE))
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, -2, 554, 0, 0, -2, 22)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	if IsPC() then
		CoD.PCUtility.SetColorMixerSliderDrag(self, f1_arg1)
	end
	return self
end
CoD.EmblemEditorColorMixerBar.__resetProperties = function(f2_arg0)
	f2_arg0.RightArrow:completeAnimation()
	f2_arg0.LeftArrow:completeAnimation()
	f2_arg0.barBg:completeAnimation()
	f2_arg0.pointer:completeAnimation()
	f2_arg0.Frame:completeAnimation()
	f2_arg0.RightArrow:setRGB(1, 1, 1)
	f2_arg0.RightArrow:setAlpha(1)
	f2_arg0.LeftArrow:setRGB(1, 1, 1)
	f2_arg0.LeftArrow:setAlpha(1)
	f2_arg0.barBg:setLeftRight(0, 1, -2, 2)
	f2_arg0.barBg:setTopBottom(0, 1, -2, 2)
	f2_arg0.barBg:setRGB(1, 1, 1)
	f2_arg0.barBg:setAlpha(0.05)
	f2_arg0.pointer:setRGB(1, 1, 1)
	f2_arg0.Frame:setRGB(1, 1, 1)
	f2_arg0.Frame:setAlpha(0.5)
end
CoD.EmblemEditorColorMixerBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.RightArrow:completeAnimation()
			f3_arg0.RightArrow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.RightArrow)
			f3_arg0.LeftArrow:completeAnimation()
			f3_arg0.LeftArrow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.LeftArrow)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(5)
			f4_arg0.Frame:completeAnimation()
			f4_arg0.Frame:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.Frame:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Frame)
			f4_arg0.barBg:completeAnimation()
			f4_arg0.barBg:setLeftRight(0, 1, -2, 2)
			f4_arg0.barBg:setTopBottom(0, 1, -2, 2)
			f4_arg0.barBg:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.barBg:setAlpha(0.3)
			f4_arg0.clipFinished(f4_arg0.barBg)
			f4_arg0.pointer:completeAnimation()
			f4_arg0.pointer:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.pointer)
			f4_arg0.RightArrow:completeAnimation()
			f4_arg0.RightArrow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.RightArrow)
			f4_arg0.LeftArrow:completeAnimation()
			f4_arg0.LeftArrow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.LeftArrow)
		end,
	},
}
CoD.EmblemEditorColorMixerBar.__onClose = function(f5_arg0)
	f5_arg0.pointer:close()
	f5_arg0.CommonCornerPips:close()
end
