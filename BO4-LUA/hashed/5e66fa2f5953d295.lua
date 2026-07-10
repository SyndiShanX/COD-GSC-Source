CoD.ItemShopPreviewButtonContentImage = InheritFrom(LUI.UIElement)
CoD.ItemShopPreviewButtonContentImage.__defaultWidth = 224
CoD.ItemShopPreviewButtonContentImage.__defaultHeight = 308
CoD.ItemShopPreviewButtonContentImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopPreviewButtonContentImage)
	self.id = "ItemShopPreviewButtonContentImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Default = LUI.UIImage.new(0, 0, 0, 224, 0, 0, 0, 307)
	Default:setAlpha(0)
	Default:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Default:setShaderVector(0, 0.5, 0, 0, 0)
	Default:setShaderVector(1, 1, 1, 0, 0)
	Default:setShaderVector(2, 0, 0, 0, 0)
	Default:linkToElementModel(self, "detailsImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Default:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Default)
	self.Default = Default
	local OutfitBundle = LUI.UIImage.new(0, 0, 0, 224, 0, 0, 0, 307)
	OutfitBundle:setAlpha(0)
	OutfitBundle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	OutfitBundle:setShaderVector(0, 0.5, 0.3, 0, 0)
	OutfitBundle:setShaderVector(1, 1, 1, 0, 0)
	OutfitBundle:setShaderVector(2, 0, 0, 0, 0)
	OutfitBundle:linkToElementModel(self, "detailsImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			OutfitBundle:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(OutfitBundle)
	self.OutfitBundle = OutfitBundle
	local OutfitPalette = LUI.UIImage.new(0, 0, 0, 224, 0, 0, 0, 307)
	OutfitPalette:setAlpha(0)
	OutfitPalette:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	OutfitPalette:setShaderVector(0, 0.5, 0, 0, 0)
	OutfitPalette:setShaderVector(1, 1, 1, 0, 0)
	OutfitPalette:setShaderVector(2, 0.05, 0, 0, 0)
	OutfitPalette:linkToElementModel(self, "detailsImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			OutfitPalette:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(OutfitPalette)
	self.OutfitPalette = OutfitPalette
	self:mergeStateConditions({
		{
			stateName = "OutfitBundle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"outfit_bundle")
			end,
		},
		{
			stateName = "OutfitPalette",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"palette")
			end,
		},
	})
	self:linkToElementModel(self, "itemCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopPreviewButtonContentImage.__resetProperties = function(f8_arg0)
	f8_arg0.Default:completeAnimation()
	f8_arg0.OutfitBundle:completeAnimation()
	f8_arg0.OutfitPalette:completeAnimation()
	f8_arg0.Default:setAlpha(0)
	f8_arg0.OutfitBundle:setAlpha(0)
	f8_arg0.OutfitPalette:setAlpha(0)
end
CoD.ItemShopPreviewButtonContentImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Default:completeAnimation()
			f9_arg0.Default:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Default)
		end,
	},
	OutfitBundle = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.OutfitBundle:completeAnimation()
			f10_arg0.OutfitBundle:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.OutfitBundle)
		end,
	},
	OutfitPalette = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.OutfitPalette:completeAnimation()
			f11_arg0.OutfitPalette:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.OutfitPalette)
		end,
	},
}
CoD.ItemShopPreviewButtonContentImage.__onClose = function(f12_arg0)
	f12_arg0.Default:close()
	f12_arg0.OutfitBundle:close()
	f12_arg0.OutfitPalette:close()
end
