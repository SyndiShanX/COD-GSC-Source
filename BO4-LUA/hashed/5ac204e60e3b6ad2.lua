require("x64:8671e55d58e1b3f")
CoD.EquippedBGB = InheritFrom(LUI.UIElement)
CoD.EquippedBGB.__defaultWidth = 120
CoD.EquippedBGB.__defaultHeight = 120
CoD.EquippedBGB.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EquippedBGB)
	self.id = "EquippedBGB"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ElixirCount = CoD.EquippedBGBInternal.new(f1_arg0, f1_arg1, 0, 0, -42, 162, 0, 0, -42, 162)
	ElixirCount:linkToElementModel(self, nil, false, function(model)
		ElixirCount:setModel(model, f1_arg1)
	end)
	self:addElement(ElixirCount)
	self.ElixirCount = ElixirCount
	self:mergeStateConditions({
		{
			stateName = "ZeroInventorySelected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "BGBLoadout", "selectedIndex", "slotIndex")
			end,
		},
		{
			stateName = "ZeroInventory",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.BGBLoadout.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.selectedIndex, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	self:linkToElementModel(self, "slotIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slotIndex",
		})
	end)
	ElixirCount.id = "ElixirCount"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EquippedBGB.__resetProperties = function(f8_arg0)
	f8_arg0.ElixirCount:completeAnimation()
	f8_arg0.ElixirCount:setScale(1, 1)
end
CoD.EquippedBGB.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ElixirCount:completeAnimation()
			f10_arg0.ElixirCount:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.ElixirCount)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f11_arg0.ElixirCount:setScale(1.05, 1.05)
				f11_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ElixirCount:completeAnimation()
			f11_arg0.ElixirCount:setScale(1, 1)
			f11_local0(f11_arg0.ElixirCount)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f13_arg0.ElixirCount:setScale(1, 1)
				f13_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ElixirCount:completeAnimation()
			f13_arg0.ElixirCount:setScale(1.05, 1.05)
			f13_local0(f13_arg0.ElixirCount)
		end,
	},
	ZeroInventorySelected = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.ElixirCount:completeAnimation()
			f16_arg0.ElixirCount:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.ElixirCount)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f17_arg0.ElixirCount:setScale(1.05, 1.05)
				f17_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ElixirCount:completeAnimation()
			f17_arg0.ElixirCount:setScale(1, 1)
			f17_local0(f17_arg0.ElixirCount)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f19_arg0.ElixirCount:setScale(1, 1)
				f19_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ElixirCount:completeAnimation()
			f19_arg0.ElixirCount:setScale(1.05, 1.05)
			f19_local0(f19_arg0.ElixirCount)
		end,
	},
	Selected = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.ElixirCount:completeAnimation()
			f22_arg0.ElixirCount:setScale(1.05, 1.05)
			f22_arg0.clipFinished(f22_arg0.ElixirCount)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f23_arg0.ElixirCount:setScale(1.05, 1.05)
				f23_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.ElixirCount:completeAnimation()
			f23_arg0.ElixirCount:setScale(1, 1)
			f23_local0(f23_arg0.ElixirCount)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f25_arg0.ElixirCount:setScale(1, 1)
				f25_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.ElixirCount:completeAnimation()
			f25_arg0.ElixirCount:setScale(1.05, 1.05)
			f25_local0(f25_arg0.ElixirCount)
		end,
	},
	ZeroInventory = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.ElixirCount:completeAnimation()
			f28_arg0.ElixirCount:setScale(1.05, 1.05)
			f28_arg0.clipFinished(f28_arg0.ElixirCount)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f29_arg0.ElixirCount:setScale(1.05, 1.05)
				f29_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.ElixirCount:completeAnimation()
			f29_arg0.ElixirCount:setScale(1, 1)
			f29_local0(f29_arg0.ElixirCount)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f31_arg0.ElixirCount:setScale(1, 1)
				f31_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ElixirCount:completeAnimation()
			f31_arg0.ElixirCount:setScale(1.05, 1.05)
			f31_local0(f31_arg0.ElixirCount)
		end,
	},
}
CoD.EquippedBGB.__onClose = function(f33_arg0)
	f33_arg0.ElixirCount:close()
end
