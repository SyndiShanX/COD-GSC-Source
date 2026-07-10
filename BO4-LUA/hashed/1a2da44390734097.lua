require("x64:b79410dc8d1ea84")
CoD.MultiItemPickupWaypointItem = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupWaypointItem.__defaultWidth = 156
CoD.MultiItemPickupWaypointItem.__defaultHeight = 81
CoD.MultiItemPickupWaypointItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MultiItemPickupWaypointItem)
	self.id = "MultiItemPickupWaypointItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PickupHintImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 156, 0, 0, 0, 81)
	PickupHintImage:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PickupHintImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PickupHintImage)
	self.PickupHintImage = PickupHintImage
	local PCHighlightBorder = nil
	PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0.12, 0.88, 0, 0, 0.12, 0.88, 0, 0)
	PCHighlightBorder:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	PCHighlightBorder:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PCHighlightBorder, f4_arg1)
	end)
	local f1_local3 = PCHighlightBorder
	local f1_local4 = PCHighlightBorder.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(PCHighlightBorder, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDummy")
			end,
		},
		{
			stateName = "Outer",
			condition = function(menu, element, event)
				return not CoD.GridAndListUtility.IsElementWithinIndexOfActiveElement(element, 1)
			end,
		},
		{
			stateName = "Inner",
			condition = function(menu, element, event)
				return not CoD.GridAndListUtility.IsElementWithinIndexOfActiveElement(element, 0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f10_arg1)
	end)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "isDummy", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDummy",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "forceNotifyActive", function(model)
		local f13_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MultiItemPickupWaypointItem.__resetProperties = function(f14_arg0)
	f14_arg0.PickupHintImage:completeAnimation()
	f14_arg0.PickupHintImage:setAlpha(1)
	f14_arg0.PickupHintImage:setScale(1, 1)
end
CoD.MultiItemPickupWaypointItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.PickupHintImage:completeAnimation()
			f15_arg0.PickupHintImage:setScale(1.5, 1.5)
			f15_arg0.clipFinished(f15_arg0.PickupHintImage)
		end,
		Active = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.PickupHintImage:completeAnimation()
			f16_arg0.PickupHintImage:setScale(1.5, 1.5)
			f16_arg0.clipFinished(f16_arg0.PickupHintImage)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.PickupHintImage:completeAnimation()
			f17_arg0.PickupHintImage:setScale(1.5, 1.5)
			f17_arg0.clipFinished(f17_arg0.PickupHintImage)
		end,
	},
	KBM = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.PickupHintImage:completeAnimation()
			f19_arg0.PickupHintImage:setScale(1.5, 1.5)
			f19_arg0.clipFinished(f19_arg0.PickupHintImage)
		end,
		Active = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.PickupHintImage:completeAnimation()
			f20_arg0.PickupHintImage:setScale(1.5, 1.5)
			f20_arg0.clipFinished(f20_arg0.PickupHintImage)
		end,
		ActiveAndFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.PickupHintImage:completeAnimation()
			f21_arg0.PickupHintImage:setScale(0.75, 0.75)
			f21_arg0.clipFinished(f21_arg0.PickupHintImage)
		end,
	},
	Disabled = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.PickupHintImage:completeAnimation()
			f22_arg0.PickupHintImage:setAlpha(0)
			f22_arg0.PickupHintImage:setScale(1.25, 1.25)
			f22_arg0.clipFinished(f22_arg0.PickupHintImage)
		end,
	},
	Outer = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.PickupHintImage:completeAnimation()
			f23_arg0.PickupHintImage:setAlpha(0.4)
			f23_arg0.PickupHintImage:setScale(0.6, 0.6)
			f23_arg0.clipFinished(f23_arg0.PickupHintImage)
		end,
		Active = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.PickupHintImage:completeAnimation()
			f24_arg0.PickupHintImage:setAlpha(0.4)
			f24_arg0.PickupHintImage:setScale(0.6, 0.6)
			f24_arg0.clipFinished(f24_arg0.PickupHintImage)
		end,
	},
	Inner = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.PickupHintImage:completeAnimation()
			f25_arg0.PickupHintImage:setAlpha(0.6)
			f25_arg0.PickupHintImage:setScale(0.5, 0.5)
			f25_arg0.clipFinished(f25_arg0.PickupHintImage)
		end,
		Active = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.PickupHintImage:completeAnimation()
			f26_arg0.PickupHintImage:setAlpha(0.6)
			f26_arg0.PickupHintImage:setScale(0.5, 0.5)
			f26_arg0.clipFinished(f26_arg0.PickupHintImage)
		end,
	},
}
CoD.MultiItemPickupWaypointItem.__onClose = function(f27_arg0)
	f27_arg0.PickupHintImage:close()
	f27_arg0.PCHighlightBorder:close()
end
