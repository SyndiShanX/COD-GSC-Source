CoD.DiscountTiersNumber = InheritFrom(LUI.UIElement)
CoD.DiscountTiersNumber.__defaultWidth = 250
CoD.DiscountTiersNumber.__defaultHeight = 50
CoD.DiscountTiersNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DiscountTiersNumber)
	self.id = "DiscountTiersNumber"
	self.soundSet = "default"
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	FixedAspectRatioImage:setAlpha(0)
	FixedAspectRatioImage:setImage(RegisterImage(@"ui_icon_blackmarket_tier_medium"))
	FixedAspectRatioImage:setStretchedDimension(6)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local Desc = LUI.UIText.new(0, 0, 13, 213, 0, 0, 17, 44)
	Desc:setText(LocalizeToUpperString(@"hash_4DEF8E006178A1AD"))
	Desc:setTTF("ttmussels_demibold")
	Desc:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Desc:setShaderVector(0, 0.5, 0, 0, 0)
	Desc:setShaderVector(1, 0, 0, 0, 0)
	Desc:setShaderVector(2, 0, 0, 0, 1)
	Desc:setLetterSpacing(3)
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Desc)
	self.Desc = Desc
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
