CoD.LaboratoryPlasma_CodPointsCost = InheritFrom(LUI.UIElement)
CoD.LaboratoryPlasma_CodPointsCost.__defaultWidth = 171
CoD.LaboratoryPlasma_CodPointsCost.__defaultHeight = 37
CoD.LaboratoryPlasma_CodPointsCost.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryPlasma_CodPointsCost)
	self.id = "LaboratoryPlasma_CodPointsCost"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cost = LUI.UIText.new(0, 0, 0, 171, 0, 0, 0, 37)
	cost:setTTF("ttmussels_regular")
	cost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	cost:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	cost:linkToElementModel(self, "price", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			cost:setText(f2_local0)
		end
	end)
	self:addElement(cost)
	self.cost = cost
	self:mergeStateConditions({
		{
			stateName = "NotEnoughCodPoints",
			condition = function(menu, element, event)
				return not CanPurchaseItem(f1_arg1, self)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["LootStreamProgress.codPoints"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LootStreamProgress.codPoints",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryPlasma_CodPointsCost.__resetProperties = function(f5_arg0)
	f5_arg0.cost:completeAnimation()
	f5_arg0.cost:setRGB(1, 1, 1)
end
CoD.LaboratoryPlasma_CodPointsCost.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	NotEnoughCodPoints = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.cost:completeAnimation()
			f7_arg0.cost:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f7_arg0.clipFinished(f7_arg0.cost)
		end,
	},
}
CoD.LaboratoryPlasma_CodPointsCost.__onClose = function(f8_arg0)
	f8_arg0.cost:close()
end
