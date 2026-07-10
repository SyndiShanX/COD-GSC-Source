CoD.RadialTimer = InheritFrom(LUI.UIElement)
CoD.RadialTimer.__defaultWidth = 150
CoD.RadialTimer.__defaultHeight = 150
CoD.RadialTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RadialTimer)
	self.id = "RadialTimer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backer = LUI.UIImage.new(0, 0, 42.5, 106.5, 0, 0, 42.5, 106.5)
	backer:setRGB(0, 0, 0)
	backer:setAlpha(0.6)
	backer:setScale(1.4, 1.4)
	backer:setImage(RegisterImage(0xF52F421F52D0B40))
	self:addElement(backer)
	self.backer = backer
	local ClockBacking = LUI.UIImage.new(0.28, 0.72, 0, 0, 0.28, 0.72, 0, 0)
	ClockBacking:setRGB(0.28, 0.28, 0.28)
	ClockBacking:setImage(RegisterImage(0x60E8FD9901EAF47))
	ClockBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	ClockBacking:setShaderVector(0, 1, 0, 0, 0)
	ClockBacking:setShaderVector(1, 0.5, 0, 0, 0)
	ClockBacking:setShaderVector(2, 0.5, 0, 0, 0)
	ClockBacking:setShaderVector(3, 0, 0, 0, 0)
	ClockBacking:setShaderVector(4, 10, 0.03, 0, 0)
	self:addElement(ClockBacking)
	self.ClockBacking = ClockBacking
	local Clock = LUI.UIImage.new(0.28, 0.72, 0, 0, 0.28, 0.72, 0, 0)
	Clock:setRGB(1, 0.99, 0.93)
	Clock:setImage(RegisterImage(0x60E8FD9901EAF47))
	Clock:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	Clock:setShaderVector(0, SetVectorComponent(0, 0, 1, 0.1, 0, 0))
	Clock:setShaderVector(1, 0.5, 0, 0, 0)
	Clock:setShaderVector(2, 0.5, 0, 0, 0)
	Clock:setShaderVector(3, 0, 0, 0, 0)
	Clock:setShaderVector(4, 10, 0.03, 0, 0)
	self:addElement(Clock)
	self.Clock = Clock
	local TimeText = LUI.UIText.new(0.5, 0.5, -40, 40, 0.5, 0.5, -18, 20)
	TimeText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	TimeText:setTTF("0arame_mono_stencil")
	TimeText:setLetterSpacing(2)
	TimeText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TimeText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(TimeText)
	self.TimeText = TimeText
	local fui = LUI.UIImage.new(0, 0, 25, 125, 0, 0, 25, 125)
	fui:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	fui:setAlpha(0.4)
	fui:setScale(0.84, 0.84)
	fui:setImage(RegisterImage(0xA3DD2D35024623C))
	fui:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	fui:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(fui)
	self.fui = fui
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.RadialTimer.__resetProperties = function(f2_arg0)
	f2_arg0.fui:completeAnimation()
	f2_arg0.TimeText:completeAnimation()
	f2_arg0.Clock:completeAnimation()
	f2_arg0.ClockBacking:completeAnimation()
	f2_arg0.backer:completeAnimation()
	f2_arg0.fui:setTopBottom(0, 0, 25, 125)
	f2_arg0.fui:setAlpha(0.4)
	f2_arg0.fui:setScale(0.84, 0.84)
	f2_arg0.TimeText:setTopBottom(0.5, 0.5, -18, 20)
	f2_arg0.TimeText:setAlpha(1)
	f2_arg0.Clock:setAlpha(1)
	f2_arg0.ClockBacking:setAlpha(1)
	f2_arg0.backer:setAlpha(0.6)
end
CoD.RadialTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.TimeText:completeAnimation()
			f3_arg0.TimeText:setTopBottom(0.5, 0.5, -17, 19)
			f3_arg0.clipFinished(f3_arg0.TimeText)
			f3_arg0.fui:completeAnimation()
			f3_arg0.fui:setTopBottom(0, 0, 25.5, 125.5)
			f3_arg0.fui:setScale(0.82, 0.82)
			f3_arg0.clipFinished(f3_arg0.fui)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(5)
			f4_arg0.backer:completeAnimation()
			f4_arg0.backer:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.backer)
			f4_arg0.ClockBacking:completeAnimation()
			f4_arg0.ClockBacking:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ClockBacking)
			f4_arg0.Clock:completeAnimation()
			f4_arg0.Clock:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Clock)
			f4_arg0.TimeText:completeAnimation()
			f4_arg0.TimeText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TimeText)
			f4_arg0.fui:completeAnimation()
			f4_arg0.fui:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.fui)
		end,
	},
}
