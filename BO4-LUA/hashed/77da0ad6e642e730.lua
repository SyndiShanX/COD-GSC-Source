CoD.BountyHunterPackageTierItem = InheritFrom(LUI.UIElement)
CoD.BountyHunterPackageTierItem.__defaultWidth = 115
CoD.BountyHunterPackageTierItem.__defaultHeight = 115
CoD.BountyHunterPackageTierItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterPackageTierItem)
	self.id = "BountyHunterPackageTierItem"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ItemImage = LUI.UIFixedAspectRatioImage.new(0, 0, 17.5, 97.5, 0, 0, 17.5, 97.5)
	ItemImage:setStretchedDimension(4)
	ItemImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ItemImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f2_local0))
		end
	end)
	self:addElement(ItemImage)
	self.ItemImage = ItemImage
	self:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsTrackPackagePurchased(self, menu, f1_arg1)
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.BountyHunterUtility.IsPackageTierAvailable(self)
			end,
		},
	})
	self:linkToElementModel(self, "trackModel", true, function(model)
		if self["__stateValidation_trackModel->tierPurchased"] then
			self:removeSubscription(self["__stateValidation_trackModel->tierPurchased"])
			self["__stateValidation_trackModel->tierPurchased"] = nil
		end
		if model then
			local f5_local0 = model:get()
			local f5_local1 = model:get()
			model = f5_local0 and f5_local1.tierPurchased
		end
		if model then
			self["__stateValidation_trackModel->tierPurchased"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "trackModel->tierPurchased",
				})
			end)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPackageTierItem.__resetProperties = function(f7_arg0)
	f7_arg0.ItemImage:completeAnimation()
	f7_arg0.ItemImage:setAlpha(1)
end
CoD.BountyHunterPackageTierItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Purchased = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ItemImage:completeAnimation()
			f9_arg0.ItemImage:setAlpha(0.25)
			f9_arg0.clipFinished(f9_arg0.ItemImage)
		end,
	},
	Unavailable = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ItemImage:completeAnimation()
			f10_arg0.ItemImage:setAlpha(0.25)
			f10_arg0.clipFinished(f10_arg0.ItemImage)
		end,
	},
}
CoD.BountyHunterPackageTierItem.__onClose = function(f11_arg0)
	f11_arg0.ItemImage:close()
end
