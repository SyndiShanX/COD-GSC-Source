CoD.cac_ItemTitleGlow = InheritFrom(LUI.UIElement)
CoD.cac_ItemTitleGlow.__defaultWidth = 144
CoD.cac_ItemTitleGlow.__defaultHeight = 60
CoD.cac_ItemTitleGlow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_ItemTitleGlow)
	self.id = "cac_ItemTitleGlow"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setImage(RegisterImage("uie_t7_menu_cac_itemtitleglowfull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	Image:setShaderVector(0, 0, 0, 0.42, 0.3)
	Image:setupNineSliceShader(18, 18)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
