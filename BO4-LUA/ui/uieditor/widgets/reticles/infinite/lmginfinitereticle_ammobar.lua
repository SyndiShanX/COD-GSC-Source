CoD.lmgInfiniteReticle_AmmoBar = InheritFrom(LUI.UIElement)
CoD.lmgInfiniteReticle_AmmoBar.__defaultWidth = 154
CoD.lmgInfiniteReticle_AmmoBar.__defaultHeight = 18
CoD.lmgInfiniteReticle_AmmoBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.lmgInfiniteReticle_AmmoBar)
	self.id = "lmgInfiniteReticle_AmmoBar"
	self.soundSet = "default"
	local ammoEmpty = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ammoEmpty:setRGB(0.16, 0.16, 0.16)
	ammoEmpty:setAlpha(0.9)
	ammoEmpty:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_ammo_empty"))
	self:addElement(ammoEmpty)
	self.ammoEmpty = ammoEmpty
	local ammoFull = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ammoFull:setRGB(0.33, 0.95, 0.81)
	ammoFull:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_ammo"))
	ammoFull:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	ammoFull:setShaderVector(0, 1, 0, 0, 0)
	ammoFull:setShaderVector(1, 0, 0, 0, 0)
	ammoFull:setShaderVector(2, 1, 0, 0, 0)
	ammoFull:setShaderVector(3, 0, 0, 0, 0)
	ammoFull:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ammoFull)
	self.ammoFull = ammoFull
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
