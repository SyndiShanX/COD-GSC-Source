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
	LeftOutside:setImage(RegisterImage(0xA1F4C7AABD41123))
	self:addElement(LeftOutside)
	self.LeftOutside = LeftOutside
	local LeftInside = LUI.UIImage.new(0.5, 0.5, -640, -136, 0.5, 0.5, -144, 144)
	LeftInside:setImage(RegisterImage(0x8701156ECFD8271))
	self:addElement(LeftInside)
	self.LeftInside = LeftInside
	local RightInside = LUI.UIImage.new(0.5, 0.5, 135, 639, 0.5, 0.5, -144, 144)
	RightInside:setImage(RegisterImage(0x76777F51D47B72E))
	self:addElement(RightInside)
	self.RightInside = RightInside
	local RightOutside0 = LUI.UIImage.new(1, 1, -180, 0, 0.5, 0.5, -360, 360)
	RightOutside0:setImage(RegisterImage(0x44E75DCBF85410))
	self:addElement(RightOutside0)
	self.RightOutside0 = RightOutside0
	local Center = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -9, 9)
	Center:setImage(RegisterImage(0xB5FB2A2F90EDEA8))
	self:addElement(Center)
	self.Center = Center
	local centerBottom = LUI.UIImage.new(0.5, 0.5, -9, 9, 0.5, 0.5, -2, 178)
	centerBottom:setRGB(0.64, 1, 0.81)
	centerBottom:setImage(RegisterImage(0xDA0467784A8B9BB))
	self:addElement(centerBottom)
	self.centerBottom = centerBottom
	local Top = LUI.UIImage.new(0.5, 0.5, -108, 108, 0.5, 0.5, -355, -193)
	Top:setImage(RegisterImage(0x3EF5D271C26C88C))
	self:addElement(Top)
	self.Top = Top
	local Bottom = LUI.UIImage.new(0.5, 0.5, -108, 108, 0.5, 0.5, 178, 340)
	Bottom:setImage(RegisterImage(0xB30F65E7909C814))
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
