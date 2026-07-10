CoD.WarzoneInventoryUnlockMissionBacking = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryUnlockMissionBacking.__defaultWidth = 474
CoD.WarzoneInventoryUnlockMissionBacking.__defaultHeight = 578
CoD.WarzoneInventoryUnlockMissionBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryUnlockMissionBacking)
	self.id = "WarzoneInventoryUnlockMissionBacking"
	self.soundSet = "default"
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingTint:setRGB(0, 0, 0)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local BackingNoise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingNoise:setAlpha(0.5)
	BackingNoise:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local FooterStripe3 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 0, 16)
	FooterStripe3:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	FooterStripe3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	FooterStripe3:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe3:setupNineSliceShader(90, 16)
	self:addElement(FooterStripe3)
	self.FooterStripe3 = FooterStripe3
	local FooterStripe2 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 1, 17)
	FooterStripe2:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	FooterStripe2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	FooterStripe2:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe2:setupNineSliceShader(90, 16)
	self:addElement(FooterStripe2)
	self.FooterStripe2 = FooterStripe2
	local FooterStripe1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 0, 16)
	FooterStripe1:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(90, 16)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	local BraketBottom = LUI.UIImage.new(0, 1, -2, 2, 1, 1, -28, 1)
	BraketBottom:setZRot(180)
	BraketBottom:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	BraketBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BraketBottom:setShaderVector(0, 0, 0, 0, 0)
	BraketBottom:setupNineSliceShader(200, 100)
	self:addElement(BraketBottom)
	self.BraketBottom = BraketBottom
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setRGB(0.07, 0.07, 0.07)
	self:addElement(bg)
	self.bg = bg
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
