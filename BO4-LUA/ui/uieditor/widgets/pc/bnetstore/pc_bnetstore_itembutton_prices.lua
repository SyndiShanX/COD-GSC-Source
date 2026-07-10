CoD.PC_BnetStore_ItemButton_Prices = InheritFrom(LUI.UIElement)
CoD.PC_BnetStore_ItemButton_Prices.__defaultWidth = 324
CoD.PC_BnetStore_ItemButton_Prices.__defaultHeight = 29
CoD.PC_BnetStore_ItemButton_Prices.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 12, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.PC_BnetStore_ItemButton_Prices)
	self.id = "PC_BnetStore_ItemButton_Prices"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SalePrice = LUI.UIText.new(0, 0, 0, 0, 0, 0, 0, 31)
	SalePrice:setRGB(0.6, 0.76, 0.23)
	SalePrice:setAlpha(0)
	SalePrice:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	SalePrice:setTTF("ttmussels_regular")
	SalePrice:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	SalePrice:setShaderVector(0, 25, 0, 0, 0)
	SalePrice:setShaderVector(1, 0, 0, 0, 0)
	SalePrice:setShaderVector(2, 0.16, 0.6, 0.07, 0.4)
	SalePrice:setLetterSpacing(2)
	SalePrice:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(SalePrice)
	self.SalePrice = SalePrice
	local Price = LUI.UIText.new(0, 0, 12, 149, 0, 0, 0, 31)
	Price:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Price:setTTF("ttmussels_regular")
	Price:setLetterSpacing(2)
	Price:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Price:setBackingType(2)
	Price:setBackingAlpha(0)
	Price:setBackingXPadding(2)
	Price:setBackingImage(RegisterImage(0x543EE2663FE7871))
	Price:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	Price:setBackingShaderVector(0, 0, 1, 0, 0)
	Price:setBackingShaderVector(1, 0, 0, 0, 0)
	Price:setBackingShaderVector(2, 0.39, 0.47, 0, 0)
	Price:setBackingShaderVector(3, 0, 0, 0, 0)
	Price:setBackingShaderVector(4, 0, 0, 0, 0)
	self:addElement(Price)
	self.Price = Price
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_BnetStore_ItemButton_Prices.__resetProperties = function(f2_arg0)
	f2_arg0.Price:completeAnimation()
	f2_arg0.SalePrice:completeAnimation()
	f2_arg0.Price:setLeftRight(0, 0, 12, 149)
	f2_arg0.Price:setTopBottom(0, 0, 0, 31)
	f2_arg0.Price:setRGB(1, 1, 1)
	f2_arg0.Price:setAlpha(1)
	f2_arg0.Price:setBackingAlpha(0)
	f2_arg0.SalePrice:setLeftRight(0, 0, 0, 0)
	f2_arg0.SalePrice:setAlpha(0)
end
CoD.PC_BnetStore_ItemButton_Prices.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Price:completeAnimation()
			f3_arg0.Price:setBackingAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Price)
		end,
	},
	InSale = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.SalePrice:completeAnimation()
			f4_arg0.SalePrice:setLeftRight(0, 0, 0, 130)
			f4_arg0.SalePrice:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.SalePrice)
			f4_arg0.Price:completeAnimation()
			f4_arg0.Price:setLeftRight(0, 0, 5, 142)
			f4_arg0.Price:setTopBottom(0, 0, 5, 30)
			f4_arg0.Price:setRGB(1, 1, 1)
			f4_arg0.Price:setAlpha(0.15)
			f4_arg0.Price:setBackingAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Price)
		end,
	},
}
