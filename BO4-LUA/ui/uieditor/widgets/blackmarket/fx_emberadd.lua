CoD.fx_EmberAdd = InheritFrom(LUI.UIElement)
CoD.fx_EmberAdd.__defaultWidth = 288
CoD.fx_EmberAdd.__defaultHeight = 360
CoD.fx_EmberAdd.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.fx_EmberAdd)
	self.id = "fx_EmberAdd"
	self.soundSet = "default"
	local Ember = LUI.UIImage.new(0, 1, 64, -64, 0, 1, 77, -83)
	Ember:setRGB(0.89, 0.68, 0.04)
	Ember:setZRot(270)
	Ember:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	Ember:setShaderVector(0, 1, 1, 0, 0)
	Ember:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember)
	self.Ember = Ember
	local Ember2 = LUI.UIImage.new(0, 1, 64, -64, 0, 1, 77, -83)
	Ember2:setRGB(0.89, 0.68, 0.04)
	Ember2:setZRot(270)
	Ember2:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	Ember2:setShaderVector(0, 1, 1, 0, 0)
	Ember2:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember2)
	self.Ember2 = Ember2
	local Ember4 = LUI.UIImage.new(0, 1, 64, -64, 0, 1, 77, -83)
	Ember4:setRGB(0.89, 0.68, 0.04)
	Ember4:setZRot(270)
	Ember4:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember4:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	Ember4:setShaderVector(0, 1, 1, 0, 0)
	Ember4:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember4)
	self.Ember4 = Ember4
	local Ember3 = LUI.UIImage.new(0, 1, 64, -64, 0, 1, 77, -83)
	Ember3:setRGB(0.89, 0.68, 0.04)
	Ember3:setZRot(270)
	Ember3:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember3:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	Ember3:setShaderVector(0, 1, 1, 0, 0)
	Ember3:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember3)
	self.Ember3 = Ember3
	local Ember7 = LUI.UIImage.new(0, 1, 64, -64, 0, 1, 77, -83)
	Ember7:setRGB(0.89, 0.68, 0.04)
	Ember7:setZRot(270)
	Ember7:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember7:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	Ember7:setShaderVector(0, 1, 1, 0, 0)
	Ember7:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember7)
	self.Ember7 = Ember7
	local Ember6 = LUI.UIImage.new(0, 1, 64, -64, 0, 1, 77, -83)
	Ember6:setRGB(0.89, 0.68, 0.04)
	Ember6:setZRot(270)
	Ember6:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember6:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	Ember6:setShaderVector(0, 1, 1, 0, 0)
	Ember6:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember6)
	self.Ember6 = Ember6
	local Ember5 = LUI.UIImage.new(0, 1, 64, -64, 0, 1, 77, -83)
	Ember5:setRGB(0.89, 0.68, 0.04)
	Ember5:setZRot(270)
	Ember5:setImage(RegisterImage(@"uie_t7_blackmarket_crate_ember"))
	Ember5:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	Ember5:setShaderVector(0, 1, 1, 0, 0)
	Ember5:setShaderVector(1, 0, 0.25, 0, 0)
	self:addElement(Ember5)
	self.Ember5 = Ember5
	local mask = LUI.UIImage.new(0, 1, 0, 0, 0.2, 0.8, 0, 0)
	mask:setZRot(270)
	mask:setImage(RegisterImage(@"uie_t7_blackmarket_crate_smokemask"))
	mask:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(mask)
	self.mask = mask
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
