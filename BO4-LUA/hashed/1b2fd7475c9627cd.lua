CoD.WarzoneInventoryCounter = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryCounter.__defaultWidth = 20
CoD.WarzoneInventoryCounter.__defaultHeight = 20
CoD.WarzoneInventoryCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryCounter)
	self.id = "WarzoneInventoryCounter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Counter = LUI.UIText.new(0.5, 0.5, -10, 10, 0.5, 0.5, -12, 12)
	Counter:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Counter:setTTF("0arame_mono_stencil")
	Counter:setLetterSpacing(1)
	Counter:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Counter:setBackingType(2)
	Counter:setBackingColor(0, 0, 0)
	Counter:setBackingXPadding(5)
	Counter:setBackingYPadding(1)
	Counter:linkToElementModel(self, "stackCount", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Counter:setText(f2_local0)
		end
	end)
	self:addElement(Counter)
	self.Counter = Counter
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "stackCount", 1)
			end,
		},
	})
	self:linkToElementModel(self, "stackCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stackCount",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryCounter.__resetProperties = function(f5_arg0)
	f5_arg0.Counter:completeAnimation()
	f5_arg0.Counter:setAlpha(1)
end
CoD.WarzoneInventoryCounter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Counter:completeAnimation()
			f7_arg0.Counter:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Counter)
		end,
	},
}
CoD.WarzoneInventoryCounter.__onClose = function(f8_arg0)
	f8_arg0.Counter:close()
end
