require("x64:ec94048bad1fbac")
CoD.BountyHunterPreviewItem = InheritFrom(LUI.UIElement)
CoD.BountyHunterPreviewItem.__defaultWidth = 330
CoD.BountyHunterPreviewItem.__defaultHeight = 100
CoD.BountyHunterPreviewItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.BountyHunterPreviewItem)
	self.id = "BountyHunterPreviewItem"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ItemImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 100, 0, 0, 0, 100)
	ItemImage:setStretchedDimension(4)
	ItemImage:linkToElementModel(self, "imageLarge", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ItemImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f2_local0))
		end
	end)
	self:addElement(ItemImage)
	self.ItemImage = ItemImage
	local ItemName = LUI.UIText.new(0, 0, 100, 330, 0, 0, 0, 30)
	ItemName:setRGB(0.78, 0.78, 0.78)
	ItemName:setTTF("ttmussels_regular")
	ItemName:setLetterSpacing(4)
	ItemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ItemName:linkToElementModel(self, "displayName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ItemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(ItemName)
	self.ItemName = ItemName
	local DirectorDividerWithGradient = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 100, 322, 0, 0, 33, 40)
	DirectorDividerWithGradient:setRGB(0.5, 0.5, 0.5)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	local ItemDescription = LUI.UIText.new(0, 0, 100, 330, 0, 0, 39, 59)
	ItemDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ItemDescription:setTTF("dinnext_regular")
	ItemDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ItemDescription:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ItemDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(ItemDescription)
	self.ItemDescription = ItemDescription
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "trackTier", 0)
			end,
		},
	})
	self:linkToElementModel(self, "trackTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trackTier",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPreviewItem.__resetProperties = function(f7_arg0)
	f7_arg0.ItemImage:completeAnimation()
	f7_arg0.ItemDescription:completeAnimation()
	f7_arg0.ItemName:completeAnimation()
	f7_arg0.DirectorDividerWithGradient:completeAnimation()
	f7_arg0.ItemImage:setAlpha(1)
	f7_arg0.ItemDescription:setAlpha(1)
	f7_arg0.ItemName:setAlpha(1)
	f7_arg0.DirectorDividerWithGradient:setAlpha(1)
end
CoD.BountyHunterPreviewItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.ItemImage:completeAnimation()
			f8_arg0.ItemImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ItemImage)
			f8_arg0.ItemName:completeAnimation()
			f8_arg0.ItemName:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ItemName)
			f8_arg0.DirectorDividerWithGradient:completeAnimation()
			f8_arg0.DirectorDividerWithGradient:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DirectorDividerWithGradient)
			f8_arg0.ItemDescription:completeAnimation()
			f8_arg0.ItemDescription:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ItemDescription)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BountyHunterPreviewItem.__onClose = function(f10_arg0)
	f10_arg0.ItemImage:close()
	f10_arg0.ItemName:close()
	f10_arg0.DirectorDividerWithGradient:close()
	f10_arg0.ItemDescription:close()
end
