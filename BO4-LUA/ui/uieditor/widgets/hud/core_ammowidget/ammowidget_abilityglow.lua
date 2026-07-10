CoD.AmmoWidget_AbilityGlow = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_AbilityGlow.__defaultWidth = 198
CoD.AmmoWidget_AbilityGlow.__defaultHeight = 198
CoD.AmmoWidget_AbilityGlow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_AbilityGlow)
	self.id = "AmmoWidget_AbilityGlow"
	self.soundSet = "default"
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setImage(RegisterImage(0xADB6DDF46BD80B5))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
