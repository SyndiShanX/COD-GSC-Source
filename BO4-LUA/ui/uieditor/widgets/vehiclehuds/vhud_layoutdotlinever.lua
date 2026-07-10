CoD.vhud_layoutDotLineVer = InheritFrom(LUI.UIElement)
CoD.vhud_layoutDotLineVer.__defaultWidth = 2
CoD.vhud_layoutDotLineVer.__defaultHeight = 1165
CoD.vhud_layoutDotLineVer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_layoutDotLineVer)
	self.id = "vhud_layoutDotLineVer"
	self.soundSet = "default"
	local layoutDotlineV01 = LUI.UIImage.new(0, 0, 0, 2, 0, 0, 0, 1170)
	layoutDotlineV01:setAlpha(0.5)
	layoutDotlineV01:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_layout_grid_dotline_ver"))
	layoutDotlineV01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	layoutDotlineV01:setShaderVector(0, 1, 5, 0, 0)
	layoutDotlineV01:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(layoutDotlineV01)
	self.layoutDotlineV01 = layoutDotlineV01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
