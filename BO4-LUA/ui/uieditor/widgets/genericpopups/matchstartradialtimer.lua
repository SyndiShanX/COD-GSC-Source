CoD.MatchstartRadialTimer = InheritFrom(LUI.UIElement)
CoD.MatchstartRadialTimer.__defaultWidth = 100
CoD.MatchstartRadialTimer.__defaultHeight = 100
CoD.MatchstartRadialTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MatchstartRadialTimer)
	self.id = "MatchstartRadialTimer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backer = LUI.UIImage.new(0.1, 0.9, 0, 0, 0.1, 0.9, 0, 0)
	backer:setRGB(0.39, 0.15, 0.15)
	backer:setAlpha(0.2)
	backer:setScale(1.4, 1.4)
	backer:setImage(RegisterImage(0xF52F421F52D0B40))
	self:addElement(backer)
	self.backer = backer
	local ClockBacking = LUI.UIImage.new(0.1, 0.9, 0, 0, 0.1, 0.9, 0, 0)
	ClockBacking:setRGB(0.39, 0.15, 0.15)
	ClockBacking:setAlpha(0.6)
	ClockBacking:setImage(RegisterImage(0x60E8FD9901EAF47))
	ClockBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	ClockBacking:setShaderVector(0, 1, 0, 0, 0)
	ClockBacking:setShaderVector(1, 0.5, 0, 0, 0)
	ClockBacking:setShaderVector(2, 0.5, 0, 0, 0)
	ClockBacking:setShaderVector(3, 0, 0, 0, 0)
	ClockBacking:setShaderVector(4, 10, 0.03, 0, 0)
	self:addElement(ClockBacking)
	self.ClockBacking = ClockBacking
	local Clock = LUI.UIImage.new(0.1, 0.9, 0, 0, 0.1, 0.9, 0, 0)
	Clock:setRGB(0.93, 0.33, 0.21)
	Clock:setImage(RegisterImage(0x60E8FD9901EAF47))
	Clock:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	Clock:setShaderVector(0, SetVectorComponent(0, 0, 1, 0.1, 0, 0))
	Clock:setShaderVector(1, 0.5, 0, 0, 0)
	Clock:setShaderVector(2, 0.5, 0, 0, 0)
	Clock:setShaderVector(3, 0, 0, 0, 0)
	Clock:setShaderVector(4, 10, 0.03, 0, 0)
	self:addElement(Clock)
	self.Clock = Clock
	local fui = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fui:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	fui:setAlpha(0.26)
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
CoD.MatchstartRadialTimer.__resetProperties = function(f2_arg0)
	f2_arg0.Clock:completeAnimation()
	f2_arg0.ClockBacking:completeAnimation()
	f2_arg0.backer:completeAnimation()
	f2_arg0.Clock:setAlpha(1)
	f2_arg0.ClockBacking:setAlpha(0.6)
	f2_arg0.backer:setAlpha(0.2)
end
CoD.MatchstartRadialTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.backer:completeAnimation()
			f4_arg0.backer:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.backer)
			f4_arg0.ClockBacking:completeAnimation()
			f4_arg0.ClockBacking:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ClockBacking)
			f4_arg0.Clock:completeAnimation()
			f4_arg0.Clock:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Clock)
		end,
	},
}
