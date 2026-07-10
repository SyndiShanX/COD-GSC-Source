CoD.AARTierRewardSlotEmpty = InheritFrom(LUI.UIElement)
CoD.AARTierRewardSlotEmpty.__defaultWidth = 310
CoD.AARTierRewardSlotEmpty.__defaultHeight = 577
CoD.AARTierRewardSlotEmpty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardSlotEmpty)
	self.id = "AARTierRewardSlotEmpty"
	self.soundSet = "none"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.05)
	self:addElement(Image)
	self.Image = Image
	local Border = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Border:setRGB(0.2, 0.2, 0.22)
	Border:setAlpha(0.25)
	Border:setImage(RegisterImage(@"hash_5CA6E5C175806396"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(8, 8)
	self:addElement(Border)
	self.Border = Border
	local Brackets = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	Brackets:setRGB(0.49, 0.49, 0.49)
	Brackets:setAlpha(0.03)
	Brackets:setImage(RegisterImage(@"uie_ui_menu_store_focus_pips"))
	Brackets:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Brackets:setShaderVector(0, 0, 0, 0, 0)
	Brackets:setupNineSliceShader(44, 44)
	self:addElement(Brackets)
	self.Brackets = Brackets
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
