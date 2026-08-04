CoD.systemOverlay_supportWidget = InheritFrom(LUI.UIElement)
CoD.systemOverlay_supportWidget.__defaultWidth = 306
CoD.systemOverlay_supportWidget.__defaultHeight = 36
CoD.systemOverlay_supportWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_supportWidget)
	self.id = "systemOverlay_supportWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local supportBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 36)
	supportBacking:setAlpha(0.6)
	self:addElement(supportBacking)
	self.supportBacking = supportBacking
	local supportingText = LUI.UIText.new(0, 0, 10, 634, 0, 0, 9.5, 26.5)
	supportingText:setRGB(0, 0, 0)
	supportingText:setTTF("ttmussels_demibold")
	supportingText:setLetterSpacing(4)
	supportingText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	supportingText:linkToElementModel(self, "supportText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			supportingText:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(supportingText)
	self.supportingText = supportingText
	self:mergeStateConditions({
		{
			stateName = "NoSupport",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "supportText")
			end,
		},
	})
	self:linkToElementModel(self, "supportText", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "supportText",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_supportWidget.__resetProperties = function(f5_arg0)
	f5_arg0.supportingText:completeAnimation()
	f5_arg0.supportBacking:completeAnimation()
	f5_arg0.supportingText:setAlpha(1)
	f5_arg0.supportBacking:setAlpha(0.6)
end
CoD.systemOverlay_supportWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	NoSupport = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.supportBacking:completeAnimation()
			f7_arg0.supportBacking:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.supportBacking)
			f7_arg0.supportingText:completeAnimation()
			f7_arg0.supportingText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.supportingText)
		end,
	},
}
CoD.systemOverlay_supportWidget.__onClose = function(f8_arg0)
	f8_arg0.supportingText:close()
end
