require("x64:caf02dcc11642e8")
CoD.PurchaseTiers = InheritFrom(LUI.UIElement)
CoD.PurchaseTiers.__defaultWidth = 180
CoD.PurchaseTiers.__defaultHeight = 90
CoD.PurchaseTiers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseTiers)
	self.id = "PurchaseTiers"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Black = LUI.UIImage.new(0, 0, 22.5, 157.5, 0, 0, -397.5, -395.5)
	Black:setRGB(0, 0, 0)
	Black:setAlpha(0)
	self:addElement(Black)
	self.Black = Black
	local PurchaseBand3 = LUI.UIImage.new(0, 0, 11, 169, 0, 0, -404.5, -388.5)
	PurchaseBand3:setImage(RegisterImage(0xD77FEBA1B6DF8BA))
	PurchaseBand3:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	PurchaseBand3:setShaderVector(0, 0, 0, 0, 0)
	PurchaseBand3:setupNineSliceShader(20, 8)
	self:addElement(PurchaseBand3)
	self.PurchaseBand3 = PurchaseBand3
	local Internal = CoD.PurchaseTiersInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -90, 90, 0, 0, 4, 71)
	self:addElement(Internal)
	self.Internal = Internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PurchaseTiers.__resetProperties = function(f2_arg0)
	f2_arg0.Black:completeAnimation()
	f2_arg0.PurchaseBand3:completeAnimation()
	f2_arg0.Black:setLeftRight(0, 0, 22.5, 157.5)
	f2_arg0.Black:setTopBottom(0, 0, -397.5, -395.5)
	f2_arg0.PurchaseBand3:setTopBottom(0, 0, -404.5, -388.5)
end
CoD.PurchaseTiers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	OneStream = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Black:completeAnimation()
			f4_arg0.Black:setTopBottom(0, 0, -235.5, -233.5)
			f4_arg0.clipFinished(f4_arg0.Black)
			f4_arg0.PurchaseBand3:completeAnimation()
			f4_arg0.PurchaseBand3:setTopBottom(0, 0, -242.5, -226.5)
			f4_arg0.clipFinished(f4_arg0.PurchaseBand3)
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
			f5_arg0.PurchaseBand3:completeAnimation()
			f5_arg0.PurchaseBand3:setTopBottom(0, 0, -404.5, -388.5)
			f5_arg0.clipFinished(f5_arg0.PurchaseBand3)
		end,
	},
	ThreeStream = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Black:completeAnimation()
			f6_arg0.Black:setTopBottom(0, 0, -559.5, -557.5)
			f6_arg0.clipFinished(f6_arg0.Black)
			f6_arg0.PurchaseBand3:completeAnimation()
			f6_arg0.PurchaseBand3:setTopBottom(0, 0, -566.5, -550.5)
			f6_arg0.clipFinished(f6_arg0.PurchaseBand3)
		end,
	},
	FourStream = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Black:completeAnimation()
			f7_arg0.Black:setTopBottom(0, 0, -721.5, -719.5)
			f7_arg0.clipFinished(f7_arg0.Black)
			f7_arg0.PurchaseBand3:completeAnimation()
			f7_arg0.PurchaseBand3:setTopBottom(0, 0, -728.5, -712.5)
			f7_arg0.clipFinished(f7_arg0.PurchaseBand3)
		end,
	},
}
CoD.PurchaseTiers.__onClose = function(f8_arg0)
	f8_arg0.Internal:close()
end
