CoD.Loot_BonusToastGenericBacking = InheritFrom(LUI.UIElement)
CoD.Loot_BonusToastGenericBacking.__defaultWidth = 400
CoD.Loot_BonusToastGenericBacking.__defaultHeight = 150
CoD.Loot_BonusToastGenericBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Loot_BonusToastGenericBacking)
	self.id = "Loot_BonusToastGenericBacking"
	self.soundSet = "none"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -5, 1)
	NoiseTiledBacking:setAlpha(0.9)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CommonStripes01Tiled = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -7, 2)
	CommonStripes01Tiled:setAlpha(0.85)
	CommonStripes01Tiled:setImage(RegisterImage(0x649895CFFA4963D))
	CommonStripes01Tiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	CommonStripes01Tiled:setShaderVector(0, 0, 0, 0, 0)
	CommonStripes01Tiled:setupNineSliceShader(64, 16)
	self:addElement(CommonStripes01Tiled)
	self.CommonStripes01Tiled = CommonStripes01Tiled
	local Category = LUI.UIText.new(0, 0, 131.5, 399.5, 0, 0, 38.5, 56.5)
	Category:setRGB(0.49, 0.49, 0.49)
	Category:setText("")
	Category:setTTF("ttmussels_regular")
	Category:setLetterSpacing(4)
	Category:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Category:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Category)
	self.Category = Category
	local SetName = LUI.UIText.new(0, 0, 131.5, 399.5, 0, 0, 94.5, 111.5)
	SetName:setRGB(0.49, 0.49, 0.49)
	SetName:setText("")
	SetName:setTTF("dinnext_regular")
	SetName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SetName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SetName)
	self.SetName = SetName
	local ItemName = LUI.UIText.new(0, 0, 131.5, 399.5, 0, 0, 63.5, 87.5)
	ItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ItemName:setText("")
	ItemName:setTTF("ttmussels_regular")
	ItemName:setLetterSpacing(2)
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ItemName)
	self.ItemName = ItemName
	local CommonFrame01 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, 0, 2)
	CommonFrame01:setRGB(0.59, 0.59, 0.59)
	CommonFrame01:setAlpha(0.25)
	CommonFrame01:setImage(RegisterImage(0xCA6E5C175806396))
	CommonFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CommonFrame01:setShaderVector(0, 0, 0, 0, 0)
	CommonFrame01:setupNineSliceShader(8, 8)
	self:addElement(CommonFrame01)
	self.CommonFrame01 = CommonFrame01
	local BottomBracket9Slice = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -7, 2)
	BottomBracket9Slice:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local BottomBracket9Slice2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 9)
	BottomBracket9Slice2:setZRot(180)
	BottomBracket9Slice2:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice2:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice2:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice2)
	self.BottomBracket9Slice2 = BottomBracket9Slice2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
