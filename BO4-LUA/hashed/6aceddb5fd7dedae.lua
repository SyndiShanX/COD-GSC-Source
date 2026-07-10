require("x64:b103ab1982e7112")
CoD.BountyHunterPackageTierSeparator = InheritFrom(LUI.UIElement)
CoD.BountyHunterPackageTierSeparator.__defaultWidth = 25
CoD.BountyHunterPackageTierSeparator.__defaultHeight = 115
CoD.BountyHunterPackageTierSeparator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterPackageTierSeparator)
	self.id = "BountyHunterPackageTierSeparator"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Separator = CoD.AttachmentUpgradeArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -41, 41, 0.5, 0.5, -26, 26)
	Separator:mergeStateConditions({
		{
			stateName = "UpgradeAvailable",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsPackageTierSeparatorActive(self)
			end,
		},
	})
	Separator:linkToElementModel(Separator, "trackModel", true, function(model)
		if Separator["__stateValidation_trackModel->tierPurchased"] then
			Separator:removeSubscription(Separator["__stateValidation_trackModel->tierPurchased"])
			Separator["__stateValidation_trackModel->tierPurchased"] = nil
		end
		if model then
			local f3_local0 = model:get()
			local f3_local1 = model:get()
			model = f3_local0 and f3_local1.tierPurchased
		end
		if model then
			Separator["__stateValidation_trackModel->tierPurchased"] = Separator:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(Separator, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "trackModel->tierPurchased",
				})
			end)
		end
	end)
	Separator:setZRot(90)
	Separator:linkToElementModel(self, nil, false, function(model)
		Separator:setModel(model, f1_arg1)
	end)
	self:addElement(Separator)
	self.Separator = Separator
	self:mergeStateConditions({
		{
			stateName = "FirstItem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "trackTier", 1)
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
CoD.BountyHunterPackageTierSeparator.__resetProperties = function(f8_arg0)
	f8_arg0.Separator:completeAnimation()
	f8_arg0.Separator:setAlpha(1)
end
CoD.BountyHunterPackageTierSeparator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	FirstItem = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Separator:completeAnimation()
			f10_arg0.Separator:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Separator)
		end,
	},
}
CoD.BountyHunterPackageTierSeparator.__onClose = function(f11_arg0)
	f11_arg0.Separator:close()
end
