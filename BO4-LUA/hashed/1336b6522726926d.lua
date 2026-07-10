CoD.AARTierRewardItemImage = InheritFrom(LUI.UIElement)
CoD.AARTierRewardItemImage.__defaultWidth = 105
CoD.AARTierRewardItemImage.__defaultHeight = 136
CoD.AARTierRewardItemImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardItemImage)
	self.id = "AARTierRewardItemImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CroppedImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CroppedImage:setAlpha(0)
	CroppedImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	CroppedImage:setShaderVector(0, 0.5, 0.5, 0, 0)
	CroppedImage:setShaderVector(1, 1, 1, 0, 0)
	CroppedImage:setShaderVector(2, 0, 0, 0, 0)
	CroppedImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CroppedImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(CroppedImage)
	self.CroppedImage = CroppedImage
	local CroppedImageOutfit = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CroppedImageOutfit:setAlpha(0)
	CroppedImageOutfit:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	CroppedImageOutfit:setShaderVector(0, 0.5, 0, 0, 0)
	CroppedImageOutfit:setShaderVector(1, 1, 1, 0, 0)
	CroppedImageOutfit:setShaderVector(2, 0, 0, 0, 0)
	CroppedImageOutfit:linkToElementModel(self, "primaryImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CroppedImageOutfit:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(CroppedImageOutfit)
	self.CroppedImageOutfit = CroppedImageOutfit
	local ImageCropped = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ImageCropped:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	ImageCropped:setShaderVector(0, 0.5, 0.5, 0, 0)
	ImageCropped:setShaderVector(1, 1, 1, 0, 0)
	ImageCropped:setShaderVector(2, 0, 0, 0, 0)
	ImageCropped:linkToElementModel(self, "primaryImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ImageCropped:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(ImageCropped)
	self.ImageCropped = ImageCropped
	self:mergeStateConditions({
		{
			stateName = "Crate",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContrabandCrate")
			end,
		},
		{
			stateName = "OutfitWarPaint",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xFB8B65946FBF7A2)
			end,
		},
		{
			stateName = "OutfitWarPaintBundle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x48B82A2276A1CAF)
			end,
		},
		{
			stateName = "OutfitPalette",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xDD691088352B680)
			end,
		},
		{
			stateName = "OutfitBundle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xC398D8E22A2269B)
			end,
		},
	})
	self:linkToElementModel(self, "isContrabandCrate", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContrabandCrate",
		})
	end)
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
CoD.AARTierRewardItemImage.__resetProperties = function(f12_arg0)
	f12_arg0.CroppedImage:completeAnimation()
	f12_arg0.ImageCropped:completeAnimation()
	f12_arg0.CroppedImageOutfit:completeAnimation()
	f12_arg0.CroppedImage:setAlpha(0)
	f12_arg0.ImageCropped:setAlpha(1)
	f12_arg0.CroppedImageOutfit:setAlpha(0)
end
CoD.AARTierRewardItemImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Crate = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.CroppedImage:completeAnimation()
			f14_arg0.CroppedImage:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.CroppedImage)
			f14_arg0.ImageCropped:completeAnimation()
			f14_arg0.ImageCropped:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ImageCropped)
		end,
	},
	OutfitWarPaint = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.CroppedImage:completeAnimation()
			f15_arg0.CroppedImage:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.CroppedImage)
			f15_arg0.ImageCropped:completeAnimation()
			f15_arg0.ImageCropped:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ImageCropped)
		end,
	},
	OutfitWarPaintBundle = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.CroppedImage:completeAnimation()
			f16_arg0.CroppedImage:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.CroppedImage)
			f16_arg0.ImageCropped:completeAnimation()
			f16_arg0.ImageCropped:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ImageCropped)
		end,
	},
	OutfitPalette = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.CroppedImageOutfit:completeAnimation()
			f17_arg0.CroppedImageOutfit:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CroppedImageOutfit)
			f17_arg0.ImageCropped:completeAnimation()
			f17_arg0.ImageCropped:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ImageCropped)
		end,
	},
	OutfitBundle = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.CroppedImageOutfit:completeAnimation()
			f18_arg0.CroppedImageOutfit:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.CroppedImageOutfit)
			f18_arg0.ImageCropped:completeAnimation()
			f18_arg0.ImageCropped:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ImageCropped)
		end,
	},
}
CoD.AARTierRewardItemImage.__onClose = function(f19_arg0)
	f19_arg0.CroppedImage:close()
	f19_arg0.CroppedImageOutfit:close()
	f19_arg0.ImageCropped:close()
end
