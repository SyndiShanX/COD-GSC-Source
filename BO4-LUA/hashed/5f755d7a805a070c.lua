CoD.zm_LaboratoryDescriptionDividerSecondary = InheritFrom(LUI.UIElement)
CoD.zm_LaboratoryDescriptionDividerSecondary.__defaultWidth = 512
CoD.zm_LaboratoryDescriptionDividerSecondary.__defaultHeight = 32
CoD.zm_LaboratoryDescriptionDividerSecondary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_LaboratoryDescriptionDividerSecondary)
	self.id = "zm_LaboratoryDescriptionDividerSecondary"
	self.soundSet = "none"
	local Stroke = LUI.UIImage.new(0, 1, 0, 0, 0.25, 0.75, 0, 0)
	Stroke:setImage(RegisterImage(@"hash_6A2435D4CA7897C6"))
	self:addElement(Stroke)
	self.Stroke = Stroke
	local R = LUI.UIImage.new(1, 1, -5, 5, 0.5, 0.5, -5, 5)
	R:setImage(RegisterImage(@"hash_61EC82771A88A0E6"))
	self:addElement(R)
	self.R = R
	local L = LUI.UIImage.new(0, 0, -5, 5, 0.5, 0.5, -5, 5)
	L:setImage(RegisterImage(@"hash_61EC82771A88A0E6"))
	self:addElement(L)
	self.L = L
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
