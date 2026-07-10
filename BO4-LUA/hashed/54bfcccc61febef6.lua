CoD.zm_LaboratoryDescriptionDivider = InheritFrom(LUI.UIElement)
CoD.zm_LaboratoryDescriptionDivider.__defaultWidth = 512
CoD.zm_LaboratoryDescriptionDivider.__defaultHeight = 32
CoD.zm_LaboratoryDescriptionDivider.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_LaboratoryDescriptionDivider)
	self.id = "zm_LaboratoryDescriptionDivider"
	self.soundSet = "none"
	local StrokeCenter = LUI.UIImage.new(0, 1, 0, 0, 0.15, 0.85, 0, 0)
	StrokeCenter:setImage(RegisterImage(0xA2435D4CA7897C6))
	self:addElement(StrokeCenter)
	self.StrokeCenter = StrokeCenter
	local Center = LUI.UIImage.new(0.5, 0.5, -75, 75, 0.5, 0.5, -7, 12)
	Center:setScale(1.05, 1.05)
	Center:setImage(RegisterImage(0x463D9B727066CEB))
	self:addElement(Center)
	self.Center = Center
	local R = LUI.UIImage.new(1, 1, -5, 5, 0.5, 0.5, -5, 5)
	R:setImage(RegisterImage(0x1EC82771A88A0E6))
	self:addElement(R)
	self.R = R
	local L = LUI.UIImage.new(0, 0, -5, 5, 0.5, 0.5, -5, 5)
	L:setImage(RegisterImage(0x1EC82771A88A0E6))
	self:addElement(L)
	self.L = L
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
