CoD.WeaponAttributesEmptyBar = InheritFrom(LUI.UIElement)
CoD.WeaponAttributesEmptyBar.__defaultWidth = 27
CoD.WeaponAttributesEmptyBar.__defaultHeight = 16
CoD.WeaponAttributesEmptyBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponAttributesEmptyBar)
	self.id = "WeaponAttributesEmptyBar"
	self.soundSet = "none"
	local LeftEmptyBar = LUI.UIImage.new(0, 0, 2, 12, 0, 1, 6, -6)
	LeftEmptyBar:setRGB(0.27, 0.27, 0.27)
	LeftEmptyBar:setAlpha(0.25)
	self:addElement(LeftEmptyBar)
	self.LeftEmptyBar = LeftEmptyBar
	local RightEmptyBar = LUI.UIImage.new(1, 1, -13, -3, 0, 1, 6, -6)
	RightEmptyBar:setRGB(0.27, 0.27, 0.27)
	RightEmptyBar:setAlpha(0.25)
	self:addElement(RightEmptyBar)
	self.RightEmptyBar = RightEmptyBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
