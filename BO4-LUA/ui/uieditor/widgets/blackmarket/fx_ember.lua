CoD.fx_Ember = InheritFrom(LUI.UIElement)
CoD.fx_Ember.__defaultWidth = 288
CoD.fx_Ember.__defaultHeight = 360
CoD.fx_Ember.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.fx_Ember)
	self.id = "fx_Ember"
	self.soundSet = "default"
	local Ember = LUI.UIImage.new(0, 1, 60, -68, 0, 1, 0, -160)
	Ember:setRGB(0.89, 0.68, 0.04)
	Ember:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	Ember:setShaderVector(0, 1, 1, 0, 0)
	Ember:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember)
	self.Ember = Ember
	local mask = LUI.UIImage.new(0.01, 1, 0, 0, 0.13, 0.73, -54, -60)
	mask:setImage(RegisterImage(@"uie_t7_blackmarket_crate_smokemask"))
	self:addElement(mask)
	self.mask = mask
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
