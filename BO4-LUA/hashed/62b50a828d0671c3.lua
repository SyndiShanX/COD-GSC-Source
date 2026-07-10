CoD.vhud_lightningstrike_ambientgadget_square = InheritFrom(LUI.UIElement)
CoD.vhud_lightningstrike_ambientgadget_square.__defaultWidth = 120
CoD.vhud_lightningstrike_ambientgadget_square.__defaultHeight = 50
CoD.vhud_lightningstrike_ambientgadget_square.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_lightningstrike_ambientgadget_square)
	self.id = "vhud_lightningstrike_ambientgadget_square"
	self.soundSet = "default"
	local AmbientCircle1 = LUI.UIImage.new(0, 0, 0, 30, 0.5, 0.5, -25, 25)
	AmbientCircle1:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientCircle1)
	self.AmbientCircle1 = AmbientCircle1
	local AmbientCircle2 = LUI.UIImage.new(0, 0, 30, 60, 0.5, 0.5, -25, 25)
	AmbientCircle2:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientCircle2)
	self.AmbientCircle2 = AmbientCircle2
	local AmbientCircle3 = LUI.UIImage.new(0, 0, 60, 90, 0.5, 0.5, -25, 25)
	AmbientCircle3:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientCircle3)
	self.AmbientCircle3 = AmbientCircle3
	local AmbientCircle4 = LUI.UIImage.new(0, 0, 90, 120, 0.5, 0.5, -25, 25)
	AmbientCircle4:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientCircle4)
	self.AmbientCircle4 = AmbientCircle4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
