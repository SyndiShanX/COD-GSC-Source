require("x64:90b88e935956c1d")
CoD.AARTierRewardItemUnlocked = InheritFrom(LUI.UIElement)
CoD.AARTierRewardItemUnlocked.__defaultWidth = 105
CoD.AARTierRewardItemUnlocked.__defaultHeight = 136
CoD.AARTierRewardItemUnlocked.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardItemUnlocked)
	self.id = "AARTierRewardItemUnlocked"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.85)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Darken = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Darken:setRGB(0, 0, 0)
	Darken:setAlpha(0.5)
	self:addElement(Darken)
	self.Darken = Darken
	local RewardImage = CoD.AARTierRewardItemImage.new(f1_arg0, f1_arg1, 0, 1, 1, -1, 0, 1, 1, -1)
	RewardImage:linkToElementModel(self, nil, false, function(model)
		RewardImage:setModel(model, f1_arg1)
	end)
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	local LockBacker = LUI.UIImage.new(1, 1, -52, 0, 1, 1, -52, 0)
	LockBacker:setRGB(0, 0, 0)
	LockBacker:setAlpha(0)
	LockBacker:setImage(RegisterImage(@"uie_ui_menu_item_shop_lock_backer"))
	self:addElement(LockBacker)
	self.LockBacker = LockBacker
	local LockIcon = LUI.UIImage.new(1, 1, -52, 0, 1, 1, -52, 0)
	LockIcon:setAlpha(0)
	LockIcon:setImage(RegisterImage(@"uie_ui_menu_item_shop_lock"))
	LockIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	LockIcon:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
	local CommonFrame01 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	CommonFrame01:setRGB(0.26, 0.26, 0.26)
	CommonFrame01:setImage(RegisterImage(@"hash_5CA6E5C175806396"))
	CommonFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	CommonFrame01:setShaderVector(0, 0, 0, 0, 0)
	CommonFrame01:setupNineSliceShader(8, 8)
	self:addElement(CommonFrame01)
	self.CommonFrame01 = CommonFrame01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardItemUnlocked.__onClose = function(f3_arg0)
	f3_arg0.RewardImage:close()
end
