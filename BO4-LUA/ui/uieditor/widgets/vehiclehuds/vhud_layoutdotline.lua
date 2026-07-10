CoD.vhud_layoutDotLine = InheritFrom(LUI.UIElement)
CoD.vhud_layoutDotLine.__defaultWidth = 1920
CoD.vhud_layoutDotLine.__defaultHeight = 4
CoD.vhud_layoutDotLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_layoutDotLine)
	self.id = "vhud_layoutDotLine"
	self.soundSet = "default"
	local dotline = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 0, 4)
	dotline:setAlpha(0.5)
	dotline:setImage(RegisterImage(0xA107567B8C02509))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(0x7EA4827662D4CD4))
	dotline:setShaderVector(0, 8, 1, 0, 0)
	dotline:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(dotline)
	self.dotline = dotline
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
