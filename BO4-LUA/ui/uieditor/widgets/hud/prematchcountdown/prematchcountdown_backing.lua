CoD.PrematchCountdown_Backing = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_Backing.__defaultWidth = 325
CoD.PrematchCountdown_Backing.__defaultHeight = 50
CoD.PrematchCountdown_Backing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_Backing)
	self.id = "PrematchCountdown_Backing"
	self.soundSet = "default"
	local BlurBacking = LUI.UIImage.new(0, 1, 0, 0, 0.13, 0.87, 0, 0)
	BlurBacking:setRGB(0, 0, 0)
	BlurBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBacking:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBacking)
	self.BlurBacking = BlurBacking
	local BlurBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0.13, 0.87, 0, 0)
	BlurBacking2:setRGB(0, 0, 0)
	BlurBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBacking2:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBacking2)
	self.BlurBacking2 = BlurBacking2
	local Graphic = LUI.UIImage.new(0, 1, 0, 0, -0, 0.98, 0, 0)
	Graphic:setImage(RegisterImage(@"uie_ui_hud_core_match_begins_banner"))
	Graphic:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Graphic:setShaderVector(0, 1.1, 0, 0, 0)
	self:addElement(Graphic)
	self.Graphic = Graphic
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
