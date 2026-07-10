require("x64:200e0f7e16d533")
CoD.DiscountTiersDesc = InheritFrom(LUI.UIElement)
CoD.DiscountTiersDesc.__defaultWidth = 340
CoD.DiscountTiersDesc.__defaultHeight = 50
CoD.DiscountTiersDesc.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DiscountTiersDesc)
	self.id = "DiscountTiersDesc"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OneTierDesc = LUI.UIText.new(0.5, 0.5, -156, 44, 0.5, 0.5, -12, 16)
	OneTierDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OneTierDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4A53B7CE50DE4FBC"))
	OneTierDesc:setTTF("ttmussels_demibold")
	OneTierDesc:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	OneTierDesc:setShaderVector(0, 0.5, 0, 0, 0)
	OneTierDesc:setShaderVector(1, 0, 0, 0, 0)
	OneTierDesc:setShaderVector(2, 0, 0, 0, 1)
	OneTierDesc:setLetterSpacing(4)
	OneTierDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OneTierDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(OneTierDesc)
	self.OneTierDesc = OneTierDesc
	local Purchase = LUI.UIText.new(0.5, 0.5, -156, 44, 0.5, 0.5, -39, -11)
	Purchase:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Purchase:setText(LocalizeToUpperString(@"menu/purchase"))
	Purchase:setTTF("ttmussels_demibold")
	Purchase:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Purchase:setShaderVector(0, 0.5, 0, 0, 0)
	Purchase:setShaderVector(1, 0, 0, 0, 0)
	Purchase:setShaderVector(2, 0, 0, 0, 1)
	Purchase:setLetterSpacing(4)
	Purchase:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Purchase:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(Purchase)
	self.Purchase = Purchase
	local Desc = CoD.DiscountTiersNumber.new(f1_arg0, f1_arg1, 0.5, 0.5, -170, 80, 0.5, 0.5, -39, 11)
	Desc:linkToElementModel(self, nil, false, function(model)
		Desc:setModel(model, f1_arg1)
	end)
	self:addElement(Desc)
	self.Desc = Desc
	self:mergeStateConditions({
		{
			stateName = "OneTier",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "tiers", 1)
			end,
		},
	})
	self:linkToElementModel(self, "tiers", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tiers",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DiscountTiersDesc.__resetProperties = function(f5_arg0)
	f5_arg0.OneTierDesc:completeAnimation()
	f5_arg0.Purchase:completeAnimation()
	f5_arg0.Desc:completeAnimation()
	f5_arg0.OneTierDesc:setAlpha(1)
	f5_arg0.Purchase:setAlpha(1)
	f5_arg0.Desc:setAlpha(1)
end
CoD.DiscountTiersDesc.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.OneTierDesc:completeAnimation()
			f6_arg0.OneTierDesc:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.OneTierDesc)
			f6_arg0.Purchase:completeAnimation()
			f6_arg0.Purchase:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Purchase)
		end,
	},
	OneTier = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.OneTierDesc:completeAnimation()
			f7_arg0.OneTierDesc:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.OneTierDesc)
			f7_arg0.Desc:completeAnimation()
			f7_arg0.Desc:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Desc)
		end,
	},
}
CoD.DiscountTiersDesc.__onClose = function(f8_arg0)
	f8_arg0.Desc:close()
end
