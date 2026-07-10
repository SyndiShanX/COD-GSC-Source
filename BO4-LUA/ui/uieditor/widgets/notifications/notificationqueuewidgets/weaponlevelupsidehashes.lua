CoD.WeaponLevelUpSideHashes = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpSideHashes.__defaultWidth = 519
CoD.WeaponLevelUpSideHashes.__defaultHeight = 20
CoD.WeaponLevelUpSideHashes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpSideHashes)
	self.id = "WeaponLevelUpSideHashes"
	self.soundSet = "default"
	local HashRight = LUI.UIImage.new(1, 1, -8, 0, 0, 0, 0, 20)
	HashRight:setAlpha(0.5)
	HashRight:setImage(RegisterImage(0x5D630CAEDFB6072))
	self:addElement(HashRight)
	self.HashRight = HashRight
	local HashLeft = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 20)
	HashLeft:setAlpha(0.5)
	HashLeft:setImage(RegisterImage(0x5D630CAEDFB6072))
	self:addElement(HashLeft)
	self.HashLeft = HashLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
