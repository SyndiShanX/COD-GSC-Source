CoD.vhud_lightningstrike_ambientgadget_circle = InheritFrom(LUI.UIElement)
CoD.vhud_lightningstrike_ambientgadget_circle.__defaultWidth = 114
CoD.vhud_lightningstrike_ambientgadget_circle.__defaultHeight = 50
CoD.vhud_lightningstrike_ambientgadget_circle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_lightningstrike_ambientgadget_circle)
	self.id = "vhud_lightningstrike_ambientgadget_circle"
	self.soundSet = "default"
	local AmbientBracket = LUI.UIImage.new(0.5, 0.5, -57, 57, 1, 1, -30, 0)
	AmbientBracket:setImage(RegisterImage(0x1F58148C2B569CD))
	self:addElement(AmbientBracket)
	self.AmbientBracket = AmbientBracket
	local Circle3 = LUI.UIImage.new(0, 0, 74, 98, 0.4, 0.4, -20, 20)
	Circle3:setImage(RegisterImage(0x255468D158A8D39))
	self:addElement(Circle3)
	self.Circle3 = Circle3
	local Circle2 = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.4, 0.4, -20, 20)
	Circle2:setImage(RegisterImage(0x255468D158A8D39))
	self:addElement(Circle2)
	self.Circle2 = Circle2
	local Circle1 = LUI.UIImage.new(0, 0, 16, 40, 0.4, 0.4, -20, 20)
	Circle1:setImage(RegisterImage(0x255468D158A8D39))
	self:addElement(Circle1)
	self.Circle1 = Circle1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
