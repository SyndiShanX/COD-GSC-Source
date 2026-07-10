CoD.vhud_HellstormRingSmall = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormRingSmall.__defaultWidth = 100
CoD.vhud_HellstormRingSmall.__defaultHeight = 100
CoD.vhud_HellstormRingSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormRingSmall)
	self.id = "vhud_HellstormRingSmall"
	self.soundSet = "default"
	local ringBR = LUI.UIImage.new(0.5, 0.5, 50, 0, 0.5, 0.5, 50, 0)
	ringBR:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	ringBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ringBR:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(ringBR)
	self.ringBR = ringBR
	local ringTL = LUI.UIImage.new(0.5, 0.5, -50, 0, 0.5, 0.5, -50, 0)
	ringTL:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	ringTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ringTL:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(ringTL)
	self.ringTL = ringTL
	local ringTR = LUI.UIImage.new(1, 1, 0, -50, 0.5, 0.5, -50, 0)
	ringTR:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	ringTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ringTR:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(ringTR)
	self.ringTR = ringTR
	local ringBL = LUI.UIImage.new(0.5, 0.5, -50, 0, 0.5, 0.5, 50, 0)
	ringBL:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	ringBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ringBL:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(ringBL)
	self.ringBL = ringBL
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
