require("x64:4ceb8e53c9b511d")
CoD.BGBListItem = InheritFrom(LUI.UIElement)
CoD.BGBListItem.__defaultWidth = 142
CoD.BGBListItem.__defaultHeight = 138
CoD.BGBListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BGBListItem)
	self.id = "BGBListItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMElixirSlot = CoD.ZMElixirSlotInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -80, 80)
	ZMElixirSlot:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "NoConsumablesRemainingEquipped",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsBubbleGumBuffEquippedInAnySlot(menu, self, f1_arg1) and not CoD.CACUtility.DoesCACItemHaveConsumablesRemaining(menu, element, f1_arg1, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE])
			end,
		},
		{
			stateName = "NoConsumablesRemaining",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.ZMLoadoutUtility.IsBubbleGumBuffEquippedInAnySlot(menu, self, f1_arg1) then
					f4_local0 = not CoD.CACUtility.DoesCACItemHaveConsumablesRemaining(menu, element, f1_arg1, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE])
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsBubbleGumBuffEquippedInAnySlot(menu, self, f1_arg1)
			end,
		},
	})
	ZMElixirSlot:linkToElementModel(ZMElixirSlot, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(ZMElixirSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	ZMElixirSlot:linkToElementModel(ZMElixirSlot, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ZMElixirSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local2 = ZMElixirSlot
	local f1_local3 = ZMElixirSlot.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.BubbleGumBuffUpdated, function(f8_arg0)
		f1_arg0:updateElementState(ZMElixirSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "BubbleGumBuffUpdated",
		})
	end, false)
	ZMElixirSlot:linkToElementModel(self, nil, false, function(model)
		ZMElixirSlot:setModel(model, f1_arg1)
	end)
	ZMElixirSlot:linkToElementModel(self, nil, false, function(model)
		ZMElixirSlot.ConsumableCounter:setModel(model, f1_arg1)
	end)
	self:addElement(ZMElixirSlot)
	self.ZMElixirSlot = ZMElixirSlot
	ZMElixirSlot.id = "ZMElixirSlot"
	self.__defaultFocus = ZMElixirSlot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BGBListItem.__resetProperties = function(f11_arg0)
	f11_arg0.ZMElixirSlot:completeAnimation()
	f11_arg0.ZMElixirSlot:setScale(1, 1)
end
CoD.BGBListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.ZMElixirSlot:completeAnimation()
			f13_arg0.ZMElixirSlot:setScale(1.03, 1.03)
			f13_arg0.clipFinished(f13_arg0.ZMElixirSlot)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.ZMElixirSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f14_arg0.ZMElixirSlot:setScale(1.03, 1.03)
				f14_arg0.ZMElixirSlot:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ZMElixirSlot:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ZMElixirSlot:completeAnimation()
			f14_arg0.ZMElixirSlot:setScale(1, 1)
			f14_local0(f14_arg0.ZMElixirSlot)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.ZMElixirSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f16_arg0.ZMElixirSlot:setScale(1, 1)
				f16_arg0.ZMElixirSlot:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ZMElixirSlot:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ZMElixirSlot:completeAnimation()
			f16_arg0.ZMElixirSlot:setScale(1.03, 1.03)
			f16_local0(f16_arg0.ZMElixirSlot)
		end,
	},
}
CoD.BGBListItem.__onClose = function(f18_arg0)
	f18_arg0.ZMElixirSlot:close()
end
