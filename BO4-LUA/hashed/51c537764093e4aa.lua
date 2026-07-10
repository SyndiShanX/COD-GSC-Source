CoD.ItemShopButtonFrame = InheritFrom(LUI.UIElement)
CoD.ItemShopButtonFrame.__defaultWidth = 352
CoD.ItemShopButtonFrame.__defaultHeight = 116
CoD.ItemShopButtonFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopButtonFrame)
	self.id = "ItemShopButtonFrame"
	self.soundSet = "default"
	local NineSliceBMFrame = LUI.UIImage.new(0, 0, 0, 352, 0, 0, 0, 116)
	NineSliceBMFrame:setImage(RegisterImage(0x1AC151A09D526DC))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceBMFrame:setShaderVector(0, 0, 0, 0, 0)
	NineSliceBMFrame:setupNineSliceShader(162, 52)
	self:addElement(NineSliceBMFrame)
	self.NineSliceBMFrame = NineSliceBMFrame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
