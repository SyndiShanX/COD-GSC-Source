CoD.PurchaseableItemContentImageDaily = InheritFrom(LUI.UIElement)
CoD.PurchaseableItemContentImageDaily.__defaultWidth = 248
CoD.PurchaseableItemContentImageDaily.__defaultHeight = 248
CoD.PurchaseableItemContentImageDaily.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseableItemContentImageDaily)
	self.id = "PurchaseableItemContentImageDaily"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DailyImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -124, 124, 0, 0, 0, 248)
	DailyImage:setAlpha(0)
	DailyImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DailyImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(DailyImage)
	self.DailyImage = DailyImage
	local DailyImageSmall = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -72, 72, 0, 0, 39, 183)
	DailyImageSmall:setAlpha(0)
	DailyImageSmall:linkToElementModel(self, "primaryImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DailyImageSmall:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(DailyImageSmall)
	self.DailyImageSmall = DailyImageSmall
	local DailyImageCallingCard = LUI.UIImage.new(0, 0, 5, 243, 0, 0, 55.5, 164.5)
	DailyImageCallingCard:setAlpha(0)
	DailyImageCallingCard:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	DailyImageCallingCard:setShaderVector(0, 0, 0, 0, 0)
	DailyImageCallingCard:setShaderVector(1, 1, 1, 0, 0)
	DailyImageCallingCard:setShaderVector(2, 0, 0, 0, 0)
	DailyImageCallingCard:linkToElementModel(self, "primaryImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DailyImageCallingCard:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(DailyImageCallingCard)
	self.DailyImageCallingCard = DailyImageCallingCard
	local DailyImageCamo = LUI.UIImage.new(0, 0, 0, 248, 0, 0, 0, 248)
	DailyImageCamo:setAlpha(0)
	DailyImageCamo:linkToElementModel(self, "primaryImage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DailyImageCamo:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(DailyImageCamo)
	self.DailyImageCamo = DailyImageCamo
	self:mergeStateConditions({
		{
			stateName = "OutfitPalette",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xDD691088352B680)
			end,
		},
		{
			stateName = "CallingCard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCA2BC08C1A6BCF6)
			end,
		},
		{
			stateName = "Camo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xB0C9EF63048F282)
			end,
		},
		{
			stateName = "WarpaintBundle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x48B82A2276A1CAF)
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
CoD.PurchaseableItemContentImageDaily.__resetProperties = function(f11_arg0)
	f11_arg0.DailyImageSmall:completeAnimation()
	f11_arg0.DailyImage:completeAnimation()
	f11_arg0.DailyImageCallingCard:completeAnimation()
	f11_arg0.DailyImageCamo:completeAnimation()
	f11_arg0.DailyImageSmall:setAlpha(0)
	f11_arg0.DailyImage:setAlpha(0)
	f11_arg0.DailyImageCallingCard:setAlpha(0)
	f11_arg0.DailyImageCamo:setAlpha(0)
end
CoD.PurchaseableItemContentImageDaily.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.DailyImageSmall:completeAnimation()
			f12_arg0.DailyImageSmall:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.DailyImageSmall)
		end,
	},
	OutfitPalette = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.DailyImage:completeAnimation()
			f13_arg0.DailyImage:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.DailyImage)
		end,
	},
	CallingCard = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.DailyImageCallingCard:completeAnimation()
			f14_arg0.DailyImageCallingCard:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.DailyImageCallingCard)
		end,
	},
	Camo = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.DailyImageCamo:completeAnimation()
			f15_arg0.DailyImageCamo:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.DailyImageCamo)
		end,
	},
	WarpaintBundle = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.DailyImageCamo:completeAnimation()
			f16_arg0.DailyImageCamo:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.DailyImageCamo)
		end,
	},
}
CoD.PurchaseableItemContentImageDaily.__onClose = function(f17_arg0)
	f17_arg0.DailyImage:close()
	f17_arg0.DailyImageSmall:close()
	f17_arg0.DailyImageCallingCard:close()
	f17_arg0.DailyImageCamo:close()
end
