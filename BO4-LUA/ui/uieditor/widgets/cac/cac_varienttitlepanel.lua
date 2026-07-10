CoD.CAC_varientTitlePanel = InheritFrom(LUI.UIElement)
CoD.CAC_varientTitlePanel.__defaultWidth = 463
CoD.CAC_varientTitlePanel.__defaultHeight = 54
CoD.CAC_varientTitlePanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CAC_varientTitlePanel)
	self.id = "CAC_varientTitlePanel"
	self.soundSet = "CAC_EditLoadout"
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0, 0, 0)
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
