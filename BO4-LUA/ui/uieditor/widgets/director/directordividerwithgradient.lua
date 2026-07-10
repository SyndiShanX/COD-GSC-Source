CoD.DirectorDividerWithGradient = InheritFrom(LUI.UIElement)
CoD.DirectorDividerWithGradient.__defaultWidth = 500
CoD.DirectorDividerWithGradient.__defaultHeight = 1
CoD.DirectorDividerWithGradient.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorDividerWithGradient)
	self.id = "DirectorDividerWithGradient"
	self.soundSet = "none"
	local Divider = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	Divider:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	Divider:setShaderVector(0, 0, 1, 0, 0)
	Divider:setShaderVector(1, 0, 0.5, 0, 0)
	Divider:setShaderVector(2, 0, 1, 0, 0)
	Divider:setShaderVector(3, 0, 0, 0, 0)
	Divider:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Divider)
	self.Divider = Divider
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
