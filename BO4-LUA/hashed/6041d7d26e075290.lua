CoD.CurrentTier = InheritFrom(LUI.UIElement)
CoD.CurrentTier.__defaultWidth = 180
CoD.CurrentTier.__defaultHeight = 90
CoD.CurrentTier.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CurrentTier)
	self.id = "CurrentTier"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PurchaseText = LUI.UIText.new(0, 0, 0, 180, 0, 0, 37, 53)
	PurchaseText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PurchaseText:setAlpha(0)
	PurchaseText:setText(LocalizeToUpperString(@"menu/current_tier"))
	PurchaseText:setTTF("ttmussels_demibold")
	PurchaseText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	PurchaseText:setShaderVector(0, 1, 0, 0, 0)
	PurchaseText:setShaderVector(1, 0, 0, 0, 0)
	PurchaseText:setShaderVector(2, 0, 0, 0, 1)
	PurchaseText:setLetterSpacing(2)
	PurchaseText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(PurchaseText)
	self.PurchaseText = PurchaseText
	local Black = LUI.UIImage.new(0, 0, 22.5, 157.5, 0, 0, -397.5, -395.5)
	Black:setRGB(0, 0, 0)
	Black:setAlpha(0)
	self:addElement(Black)
	self.Black = Black
	local PurchaseBand = LUI.UIImage.new(0, 0, 16, 164, 0, 0, 7, 23)
	PurchaseBand:setImage(RegisterImage(@"hash_5C43B0F1483F42F2"))
	PurchaseBand:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	PurchaseBand:setShaderVector(0, 0, 0, 0, 0)
	PurchaseBand:setupNineSliceShader(20, 8)
	self:addElement(PurchaseBand)
	self.PurchaseBand = PurchaseBand
	local PurchaseBand2 = LUI.UIImage.new(0, 0, 16, 164, 0, 0, -404.5, -388.5)
	PurchaseBand2:setImage(RegisterImage(@"hash_5C43B0F1483F42F2"))
	PurchaseBand2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	PurchaseBand2:setShaderVector(0, 0, 0, 0, 0)
	PurchaseBand2:setupNineSliceShader(20, 8)
	self:addElement(PurchaseBand2)
	self.PurchaseBand2 = PurchaseBand2
	local arrow = LUI.UIImage.new(0, 0, 62, 126, 0, 0, -405, -389)
	arrow:setZRot(180)
	arrow:setImage(RegisterImage(@"hash_788C0CE731ECA734"))
	arrow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CurrentTier.__resetProperties = function(f2_arg0)
	f2_arg0.arrow:completeAnimation()
	f2_arg0.Black:completeAnimation()
	f2_arg0.PurchaseBand2:completeAnimation()
	f2_arg0.arrow:setTopBottom(0, 0, -405, -389)
	f2_arg0.Black:setLeftRight(0, 0, 22.5, 157.5)
	f2_arg0.Black:setTopBottom(0, 0, -397.5, -395.5)
	f2_arg0.PurchaseBand2:setTopBottom(0, 0, -404.5, -388.5)
end
CoD.CurrentTier.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.arrow:completeAnimation()
			f3_arg0.arrow:setTopBottom(0, 0, -404, -388)
			f3_arg0.clipFinished(f3_arg0.arrow)
		end,
	},
	OneStream = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Black:completeAnimation()
			f4_arg0.Black:setTopBottom(0, 0, -235.5, -233.5)
			f4_arg0.clipFinished(f4_arg0.Black)
			f4_arg0.PurchaseBand2:completeAnimation()
			f4_arg0.PurchaseBand2:setTopBottom(0, 0, -242.5, -226.5)
			f4_arg0.clipFinished(f4_arg0.PurchaseBand2)
			f4_arg0.arrow:completeAnimation()
			f4_arg0.arrow:setTopBottom(0, 0, -242, -226)
			f4_arg0.clipFinished(f4_arg0.arrow)
		end,
	},
	TwoStream = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Black:completeAnimation()
			f5_arg0.Black:setLeftRight(0, 0, 22.5, 157.5)
			f5_arg0.Black:setTopBottom(0, 0, -397.5, -395.5)
			f5_arg0.clipFinished(f5_arg0.Black)
			f5_arg0.arrow:completeAnimation()
			f5_arg0.arrow:setTopBottom(0, 0, -404, -388)
			f5_arg0.clipFinished(f5_arg0.arrow)
		end,
	},
	ThreeStream = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Black:completeAnimation()
			f6_arg0.Black:setTopBottom(0, 0, -559.5, -557.5)
			f6_arg0.clipFinished(f6_arg0.Black)
			f6_arg0.PurchaseBand2:completeAnimation()
			f6_arg0.PurchaseBand2:setTopBottom(0, 0, -566.5, -550.5)
			f6_arg0.clipFinished(f6_arg0.PurchaseBand2)
			f6_arg0.arrow:completeAnimation()
			f6_arg0.arrow:setTopBottom(0, 0, -566, -550)
			f6_arg0.clipFinished(f6_arg0.arrow)
		end,
	},
	FourStream = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.Black:completeAnimation()
			f7_arg0.Black:setTopBottom(0, 0, -721.5, -719.5)
			f7_arg0.clipFinished(f7_arg0.Black)
			f7_arg0.PurchaseBand2:completeAnimation()
			f7_arg0.PurchaseBand2:setTopBottom(0, 0, -728.5, -712.5)
			f7_arg0.clipFinished(f7_arg0.PurchaseBand2)
			f7_arg0.arrow:completeAnimation()
			f7_arg0.arrow:setTopBottom(0, 0, -728, -712)
			f7_arg0.clipFinished(f7_arg0.arrow)
		end,
	},
}
