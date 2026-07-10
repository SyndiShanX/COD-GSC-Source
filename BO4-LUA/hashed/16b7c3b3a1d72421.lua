require("x64:6c2d0068c093e84")
require("x64:24adaf674659a70")
CoD.ContractItemCostLarge = InheritFrom(LUI.UIElement)
CoD.ContractItemCostLarge.__defaultWidth = 185
CoD.ContractItemCostLarge.__defaultHeight = 21
CoD.ContractItemCostLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractItemCostLarge)
	self.id = "ContractItemCostLarge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Free = LUI.UIText.new(0.5, 0.5, -92.5, 92.5, 0, 0, -1, 22)
	Free:setRGB(0, 0.96, 1)
	Free:setText(LocalizeToUpperString(@"mpui/free"))
	Free:setTTF("ttmussels_demibold")
	Free:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Free:setLetterSpacing(2)
	Free:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Free:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Free:setBackingType(1)
	Free:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	Free:setBackingColor(0.92, 0.92, 0.92)
	Free:setBackingXPadding(8)
	Free:setBackingYPadding(2)
	Free._backingElement.Frame:setRGB(0, 0.96, 1)
	self:addElement(Free)
	self.Free = Free
	local ContractCost = LUI.UIText.new(0.5, 0.5, -92.5, 92.5, 0, 0, -5, 25)
	ContractCost:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	ContractCost:setTTF("ttmussels_demibold")
	ContractCost:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	ContractCost:setShaderVector(0, 1, 0, 0, 0)
	ContractCost:setShaderVector(1, 0, 0, 0, 0)
	ContractCost:setShaderVector(2, 1, 0, 0, 0.3)
	ContractCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ContractCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ContractCost:linkToElementModel(self, "price", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractCost:setText(LocalizeIntoString(@"hash_56A3CC7BE3008989", f2_local0))
		end
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	local fxEmber = CoD.fx_Ember.new(f1_arg0, f1_arg1, 0, 0, -106, 182, 0, 0, -135, 225)
	fxEmber:setRGB(0, 0.48, 1)
	fxEmber:setAlpha(0)
	fxEmber:setScale(0.6, 0.6)
	fxEmber:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(fxEmber)
	self.fxEmber = fxEmber
	local fxEmber2 = CoD.fx_Ember.new(f1_arg0, f1_arg1, 0, 0, -106, 182, 0, 0, -135, 225)
	fxEmber2:setRGB(0, 0.82, 1)
	fxEmber2:setAlpha(0)
	fxEmber2:setScale(0.6, 0.6)
	fxEmber2:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(fxEmber2)
	self.fxEmber2 = fxEmber2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractItemCostLarge.__resetProperties = function(f3_arg0)
	f3_arg0.ContractCost:completeAnimation()
	f3_arg0.fxEmber2:completeAnimation()
	f3_arg0.fxEmber:completeAnimation()
	f3_arg0.Free:completeAnimation()
	f3_arg0.ContractCost:setAlpha(1)
	f3_arg0.fxEmber2:setAlpha(0)
	f3_arg0.fxEmber:setAlpha(0)
	f3_arg0.Free:setAlpha(1)
end
CoD.ContractItemCostLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.Free:completeAnimation()
			f4_arg0.Free:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Free)
			f4_arg0.ContractCost:completeAnimation()
			f4_arg0.ContractCost:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.ContractCost)
			f4_arg0.fxEmber:completeAnimation()
			f4_arg0.fxEmber:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.fxEmber)
			f4_arg0.fxEmber2:completeAnimation()
			f4_arg0.fxEmber2:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.fxEmber2)
		end,
	},
	Free = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.Free:completeAnimation()
			f5_arg0.Free:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Free)
			f5_arg0.ContractCost:completeAnimation()
			f5_arg0.ContractCost:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ContractCost)
			f5_arg0.fxEmber:completeAnimation()
			f5_arg0.fxEmber:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.fxEmber)
			f5_arg0.fxEmber2:completeAnimation()
			f5_arg0.fxEmber2:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.fxEmber2)
		end,
	},
}
CoD.ContractItemCostLarge.__onClose = function(f6_arg0)
	f6_arg0.ContractCost:close()
	f6_arg0.fxEmber:close()
	f6_arg0.fxEmber2:close()
end
