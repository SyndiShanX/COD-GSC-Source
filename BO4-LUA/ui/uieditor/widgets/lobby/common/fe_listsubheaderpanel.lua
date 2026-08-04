CoD.FE_ListSubHeaderPanel = InheritFrom(LUI.UIElement)
CoD.FE_ListSubHeaderPanel.__defaultWidth = 48
CoD.FE_ListSubHeaderPanel.__defaultHeight = 45
CoD.FE_ListSubHeaderPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ListSubHeaderPanel)
	self.id = "FE_ListSubHeaderPanel"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, -10, 14, 0, 1, -2, 2)
	Image:setImage(RegisterImage("uie_t7_menu_frontend_listsubheadpanelfull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setupNineSliceShader(24, 6)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
