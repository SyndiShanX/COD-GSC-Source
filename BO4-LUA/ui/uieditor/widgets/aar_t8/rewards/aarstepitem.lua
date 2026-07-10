require("x64:15cf4f01e6aec35")
CoD.AARStepItem = InheritFrom(LUI.UIElement)
CoD.AARStepItem.__defaultWidth = 380
CoD.AARStepItem.__defaultHeight = 100
CoD.AARStepItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARStepItem)
	self.id = "AARStepItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TierText = LUI.UIText.new(0.5, 0.5, -181.5, 181.5, 0, 0, 7, 25)
	TierText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TierText:setTTF("dinnext_regular")
	TierText:setLetterSpacing(4)
	TierText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TierText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TierText:linkToElementModel(self, "tierProgressText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TierText:setText(ToUpper(f2_local0))
		end
	end)
	self:addElement(TierText)
	self.TierText = TierText
	local SpecialPip1 = CoD.SpecialEventProgressPip.new(f1_arg0, f1_arg1, 0, 0, 110, 142, 0.5, 0.5, -16, 16)
	SpecialPip1:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierMax", 1)
			end,
		},
		{
			stateName = "CompletedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "tierProgress", 1)
			end,
		},
		{
			stateName = "IncompleteState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierProgress", 1)
			end,
		},
	})
	SpecialPip1:linkToElementModel(SpecialPip1, "tierMax", true, function(model)
		f1_arg0:updateElementState(SpecialPip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	SpecialPip1:linkToElementModel(SpecialPip1, "tierProgress", true, function(model)
		f1_arg0:updateElementState(SpecialPip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	SpecialPip1:linkToElementModel(self, nil, false, function(model)
		SpecialPip1:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialPip1)
	self.SpecialPip1 = SpecialPip1
	local SpecialPip2 = CoD.SpecialEventProgressPip.new(f1_arg0, f1_arg1, 0, 0, 153, 185, 0.5, 0.5, -16, 16)
	SpecialPip2:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierMax", 2)
			end,
		},
		{
			stateName = "CompletedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "tierProgress", 2)
			end,
		},
		{
			stateName = "IncompleteState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierProgress", 2)
			end,
		},
	})
	SpecialPip2:linkToElementModel(SpecialPip2, "tierMax", true, function(model)
		f1_arg0:updateElementState(SpecialPip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	SpecialPip2:linkToElementModel(SpecialPip2, "tierProgress", true, function(model)
		f1_arg0:updateElementState(SpecialPip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	SpecialPip2:linkToElementModel(self, nil, false, function(model)
		SpecialPip2:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialPip2)
	self.SpecialPip2 = SpecialPip2
	local SpecialPip3 = CoD.SpecialEventProgressPip.new(f1_arg0, f1_arg1, 0.5, 0.5, 6, 38, 0.5, 0.5, -16, 16)
	SpecialPip3:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierMax", 3)
			end,
		},
		{
			stateName = "CompletedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "tierProgress", 3)
			end,
		},
		{
			stateName = "IncompleteState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierProgress", 3)
			end,
		},
	})
	SpecialPip3:linkToElementModel(SpecialPip3, "tierMax", true, function(model)
		f1_arg0:updateElementState(SpecialPip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	SpecialPip3:linkToElementModel(SpecialPip3, "tierProgress", true, function(model)
		f1_arg0:updateElementState(SpecialPip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	SpecialPip3:linkToElementModel(self, nil, false, function(model)
		SpecialPip3:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialPip3)
	self.SpecialPip3 = SpecialPip3
	local SpecialPip4 = CoD.SpecialEventProgressPip.new(f1_arg0, f1_arg1, 0, 0, 239, 271, 0.5, 0.5, -16, 16)
	SpecialPip4:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierMax", 4)
			end,
		},
		{
			stateName = "CompletedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "tierProgress", 4)
			end,
		},
		{
			stateName = "IncompleteState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierProgress", 4)
			end,
		},
	})
	SpecialPip4:linkToElementModel(SpecialPip4, "tierMax", true, function(model)
		f1_arg0:updateElementState(SpecialPip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	SpecialPip4:linkToElementModel(SpecialPip4, "tierProgress", true, function(model)
		f1_arg0:updateElementState(SpecialPip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	SpecialPip4:linkToElementModel(self, nil, false, function(model)
		SpecialPip4:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialPip4)
	self.SpecialPip4 = SpecialPip4
	local SpecialPip5 = CoD.SpecialEventProgressPip.new(f1_arg0, f1_arg1, 0, 0, 282, 314, 0.5, 0.5, -16, 16)
	SpecialPip5:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierMax", 5)
			end,
		},
		{
			stateName = "CompletedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "tierProgress", 5)
			end,
		},
		{
			stateName = "IncompleteState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "tierProgress", 5)
			end,
		},
	})
	SpecialPip5:linkToElementModel(SpecialPip5, "tierMax", true, function(model)
		f1_arg0:updateElementState(SpecialPip5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	SpecialPip5:linkToElementModel(SpecialPip5, "tierProgress", true, function(model)
		f1_arg0:updateElementState(SpecialPip5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	SpecialPip5:linkToElementModel(self, nil, false, function(model)
		SpecialPip5:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialPip5)
	self.SpecialPip5 = SpecialPip5
	local GUIDE = LUI.UIImage.new(0, 0, 0, 190, 0, 0, 0, 100)
	GUIDE:setAlpha(0)
	self:addElement(GUIDE)
	self.GUIDE = GUIDE
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isTiered")
			end,
		},
	})
	self:linkToElementModel(self, "isTiered", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isTiered",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARStepItem.__resetProperties = function(f35_arg0)
	f35_arg0.TierText:completeAnimation()
	f35_arg0.SpecialPip5:completeAnimation()
	f35_arg0.SpecialPip4:completeAnimation()
	f35_arg0.SpecialPip3:completeAnimation()
	f35_arg0.SpecialPip2:completeAnimation()
	f35_arg0.SpecialPip1:completeAnimation()
	f35_arg0.TierText:setAlpha(1)
	f35_arg0.SpecialPip5:setAlpha(1)
	f35_arg0.SpecialPip4:setAlpha(1)
	f35_arg0.SpecialPip3:setAlpha(1)
	f35_arg0.SpecialPip2:setAlpha(1)
	f35_arg0.SpecialPip1:setAlpha(1)
end
CoD.AARStepItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(6)
			f37_arg0.TierText:completeAnimation()
			f37_arg0.TierText:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.TierText)
			f37_arg0.SpecialPip1:completeAnimation()
			f37_arg0.SpecialPip1:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.SpecialPip1)
			f37_arg0.SpecialPip2:completeAnimation()
			f37_arg0.SpecialPip2:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.SpecialPip2)
			f37_arg0.SpecialPip3:completeAnimation()
			f37_arg0.SpecialPip3:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.SpecialPip3)
			f37_arg0.SpecialPip4:completeAnimation()
			f37_arg0.SpecialPip4:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.SpecialPip4)
			f37_arg0.SpecialPip5:completeAnimation()
			f37_arg0.SpecialPip5:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.SpecialPip5)
		end,
	},
}
CoD.AARStepItem.__onClose = function(f38_arg0)
	f38_arg0.TierText:close()
	f38_arg0.SpecialPip1:close()
	f38_arg0.SpecialPip2:close()
	f38_arg0.SpecialPip3:close()
	f38_arg0.SpecialPip4:close()
	f38_arg0.SpecialPip5:close()
end
