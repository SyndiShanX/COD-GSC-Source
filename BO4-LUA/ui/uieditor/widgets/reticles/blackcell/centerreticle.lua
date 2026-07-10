CoD.CenterReticle = InheritFrom(LUI.UIElement)
CoD.CenterReticle.__defaultWidth = 1641
CoD.CenterReticle.__defaultHeight = 742
CoD.CenterReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CenterReticle)
	self.id = "CenterReticle"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeftOutside = LUI.UIImage.new(0, 0, 0, 180, 0.5, 0.5, -360, 360)
	LeftOutside:setImage(RegisterImage(@"uie_t7_hud_blackcell_leftoutside"))
	self:addElement(LeftOutside)
	self.LeftOutside = LeftOutside
	local LeftInside = LUI.UIImage.new(0.5, 0.5, -640, -136, 0.5, 0.5, -144, 144)
	LeftInside:setImage(RegisterImage(@"uie_t7_hud_blackcell_left_inside"))
	self:addElement(LeftInside)
	self.LeftInside = LeftInside
	local RightInside = LUI.UIImage.new(0.5, 0.5, 135, 639, 0.5, 0.5, -144, 144)
	RightInside:setImage(RegisterImage(@"uie_t7_hud_blackcell_right_inside"))
	self:addElement(RightInside)
	self.RightInside = RightInside
	local RightOutside0 = LUI.UIImage.new(1, 1, -180, 0, 0.5, 0.5, -360, 360)
	RightOutside0:setImage(RegisterImage(@"uie_t7_hud_blackcell_rightoutside"))
	self:addElement(RightOutside0)
	self.RightOutside0 = RightOutside0
	local Center = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -9, 9)
	Center:setImage(RegisterImage(@"uie_t7_hud_blackcell_center"))
	self:addElement(Center)
	self.Center = Center
	local centerBottom = LUI.UIImage.new(0.5, 0.5, -9, 9, 0.5, 0.5, -2, 178)
	centerBottom:setRGB(0.64, 1, 0.81)
	centerBottom:setImage(RegisterImage(@"uie_t7_hud_blackcell_centerbottom"))
	self:addElement(centerBottom)
	self.centerBottom = centerBottom
	local Top = LUI.UIImage.new(0.5, 0.5, -108, 108, 0.5, 0.5, -355, -193)
	Top:setImage(RegisterImage(@"uie_t7_hud_blackcell_topinside"))
	self:addElement(Top)
	self.Top = Top
	local Bottom = LUI.UIImage.new(0.5, 0.5, -108, 108, 0.5, 0.5, 178, 340)
	Bottom:setImage(RegisterImage(@"uie_t7_blackcell_bothinside"))
	self:addElement(Bottom)
	self.Bottom = Bottom
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CenterReticle.__resetProperties = function(f2_arg0)
	f2_arg0.LeftInside:completeAnimation()
	f2_arg0.RightInside:completeAnimation()
	f2_arg0.Top:completeAnimation()
	f2_arg0.Bottom:completeAnimation()
	f2_arg0.centerBottom:completeAnimation()
	f2_arg0.Center:completeAnimation()
	f2_arg0.LeftInside:setRGB(1, 1, 1)
	f2_arg0.RightInside:setRGB(1, 1, 1)
	f2_arg0.Top:setRGB(1, 1, 1)
	f2_arg0.Bottom:setRGB(1, 1, 1)
	f2_arg0.centerBottom:setRGB(0.64, 1, 0.81)
	f2_arg0.Center:setRGB(1, 1, 1)
end
CoD.CenterReticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(6)
			f4_arg0.LeftInside:completeAnimation()
			f4_arg0.LeftInside:setRGB(1, 0.15, 0.15)
			f4_arg0.clipFinished(f4_arg0.LeftInside)
			f4_arg0.RightInside:completeAnimation()
			f4_arg0.RightInside:setRGB(1, 0.15, 0.15)
			f4_arg0.clipFinished(f4_arg0.RightInside)
			f4_arg0.Center:completeAnimation()
			f4_arg0.Center:setRGB(1, 0.15, 0.15)
			f4_arg0.clipFinished(f4_arg0.Center)
			f4_arg0.centerBottom:completeAnimation()
			f4_arg0.centerBottom:setRGB(1, 0.15, 0.15)
			f4_arg0.clipFinished(f4_arg0.centerBottom)
			f4_arg0.Top:completeAnimation()
			f4_arg0.Top:setRGB(1, 0.15, 0.15)
			f4_arg0.clipFinished(f4_arg0.Top)
			f4_arg0.Bottom:completeAnimation()
			f4_arg0.Bottom:setRGB(1, 0.15, 0.15)
			f4_arg0.clipFinished(f4_arg0.Bottom)
		end,
	},
}
