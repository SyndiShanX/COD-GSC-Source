require("x64:bc369071cd70b7c")
CoD.AARTierItem = InheritFrom(LUI.UIElement)
CoD.AARTierItem.__defaultWidth = 380
CoD.AARTierItem.__defaultHeight = 100
CoD.AARTierItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierItem)
	self.id = "AARTierItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TierText = LUI.UIText.new(0, 0, 17, 380, 0, 0, 14, 35)
	TierText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TierText:setTTF("ttmussels_demibold")
	TierText:setLetterSpacing(4)
	TierText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TierText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TierText:linkToElementModel(self, "tierProgressText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TierText:setText(ToUpper(f2_local0))
		end
	end)
	self:addElement(TierText)
	self.TierText = TierText
	local Pip1 = CoD.AARTierPip.new(f1_arg0, f1_arg1, 0, 0, 18, 56, 0, 0, 40, 78)
	Pip1:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierProgress", 1)
			end,
		},
		{
			stateName = "NotFilled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierMax", 1)
			end,
		},
	})
	Pip1:linkToElementModel(Pip1, "tierProgress", true, function(model)
		f1_arg0:updateElementState(Pip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	Pip1:linkToElementModel(Pip1, "tierMax", true, function(model)
		f1_arg0:updateElementState(Pip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	self:addElement(Pip1)
	self.Pip1 = Pip1
	local Pip2 = CoD.AARTierPip.new(f1_arg0, f1_arg1, 0, 0, 65, 103, 0, 0, 40, 78)
	Pip2:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierProgress", 2)
			end,
		},
		{
			stateName = "NotFilled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierMax", 2)
			end,
		},
	})
	Pip2:linkToElementModel(Pip2, "tierProgress", true, function(model)
		f1_arg0:updateElementState(Pip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	Pip2:linkToElementModel(Pip2, "tierMax", true, function(model)
		f1_arg0:updateElementState(Pip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	self:addElement(Pip2)
	self.Pip2 = Pip2
	local Pip3 = CoD.AARTierPip.new(f1_arg0, f1_arg1, 0, 0, 112, 150, 0, 0, 40, 78)
	Pip3:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierProgress", 3)
			end,
		},
		{
			stateName = "NotFilled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierMax", 3)
			end,
		},
	})
	Pip3:linkToElementModel(Pip3, "tierProgress", true, function(model)
		f1_arg0:updateElementState(Pip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	Pip3:linkToElementModel(Pip3, "tierMax", true, function(model)
		f1_arg0:updateElementState(Pip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	self:addElement(Pip3)
	self.Pip3 = Pip3
	local Pip4 = CoD.AARTierPip.new(f1_arg0, f1_arg1, 0, 0, 159, 197, 0, 0, 40, 78)
	Pip4:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierProgress", 4)
			end,
		},
		{
			stateName = "NotFilled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierMax", 4)
			end,
		},
	})
	Pip4:linkToElementModel(Pip4, "tierProgress", true, function(model)
		f1_arg0:updateElementState(Pip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	Pip4:linkToElementModel(Pip4, "tierMax", true, function(model)
		f1_arg0:updateElementState(Pip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	self:addElement(Pip4)
	self.Pip4 = Pip4
	local Pip5 = CoD.AARTierPip.new(f1_arg0, f1_arg1, 0, 0, 206, 244, 0, 0, 40, 78)
	Pip5:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierProgress", 5)
			end,
		},
		{
			stateName = "NotFilled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "tierMax", 5)
			end,
		},
	})
	Pip5:linkToElementModel(Pip5, "tierProgress", true, function(model)
		f1_arg0:updateElementState(Pip5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierProgress",
		})
	end)
	Pip5:linkToElementModel(Pip5, "tierMax", true, function(model)
		f1_arg0:updateElementState(Pip5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierMax",
		})
	end)
	self:addElement(Pip5)
	self.Pip5 = Pip5
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
CoD.AARTierItem.__resetProperties = function(f25_arg0)
	f25_arg0.Pip5:completeAnimation()
	f25_arg0.Pip4:completeAnimation()
	f25_arg0.Pip3:completeAnimation()
	f25_arg0.Pip2:completeAnimation()
	f25_arg0.Pip1:completeAnimation()
	f25_arg0.TierText:completeAnimation()
	f25_arg0.Pip5:setAlpha(1)
	f25_arg0.Pip4:setAlpha(1)
	f25_arg0.Pip3:setAlpha(1)
	f25_arg0.Pip2:setAlpha(1)
	f25_arg0.Pip1:setAlpha(1)
	f25_arg0.TierText:setAlpha(1)
end
CoD.AARTierItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(6)
			f27_arg0.TierText:completeAnimation()
			f27_arg0.TierText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.TierText)
			f27_arg0.Pip1:completeAnimation()
			f27_arg0.Pip1:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Pip1)
			f27_arg0.Pip2:completeAnimation()
			f27_arg0.Pip2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Pip2)
			f27_arg0.Pip3:completeAnimation()
			f27_arg0.Pip3:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Pip3)
			f27_arg0.Pip4:completeAnimation()
			f27_arg0.Pip4:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Pip4)
			f27_arg0.Pip5:completeAnimation()
			f27_arg0.Pip5:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Pip5)
		end,
	},
}
CoD.AARTierItem.__onClose = function(f28_arg0)
	f28_arg0.TierText:close()
	f28_arg0.Pip1:close()
	f28_arg0.Pip2:close()
	f28_arg0.Pip3:close()
	f28_arg0.Pip4:close()
	f28_arg0.Pip5:close()
end
