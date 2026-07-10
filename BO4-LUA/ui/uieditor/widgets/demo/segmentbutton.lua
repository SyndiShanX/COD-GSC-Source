require("x64:704a0d70f9c7c02")
CoD.SegmentButton = InheritFrom(LUI.UIElement)
CoD.SegmentButton.__defaultWidth = 321
CoD.SegmentButton.__defaultHeight = 180
CoD.SegmentButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SegmentButton)
	self.id = "SegmentButton"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SegmentButton = CoD.SegmentButtonInternal.new(f1_arg0, f1_arg1, 0, 0, -3, 324, 0, 0, -3, 183)
	SegmentButton:linkToElementModel(self, nil, false, function(model)
		SegmentButton:setModel(model, f1_arg1)
	end)
	self:addElement(SegmentButton)
	self.SegmentButton = SegmentButton
	self:mergeStateConditions({
		{
			stateName = "EmptyState",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
		{
			stateName = "SelectedState",
			condition = function(menu, element, event)
				return IsSegmentInSelectedState(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:linkToElementModel(self, "selected", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	SegmentButton.id = "SegmentButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SegmentButton.__resetProperties = function(f7_arg0)
	f7_arg0.SegmentButton:completeAnimation()
	f7_arg0.SegmentButton:setScale(1, 1)
end
CoD.SegmentButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.SegmentButton:completeAnimation()
			f9_arg0.SegmentButton:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.SegmentButton)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.SegmentButton:beginAnimation(200)
				f10_arg0.SegmentButton:setScale(1.05, 1.05)
				f10_arg0.SegmentButton:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.SegmentButton:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.SegmentButton:completeAnimation()
			f10_arg0.SegmentButton:setScale(1, 1)
			f10_local0(f10_arg0.SegmentButton)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.SegmentButton:beginAnimation(200)
				f12_arg0.SegmentButton:setScale(1, 1)
				f12_arg0.SegmentButton:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SegmentButton:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SegmentButton:completeAnimation()
			f12_arg0.SegmentButton:setScale(1.05, 1.05)
			f12_local0(f12_arg0.SegmentButton)
		end,
	},
	EmptyState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	SelectedState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.SegmentButton:completeAnimation()
			f16_arg0.SegmentButton:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.SegmentButton)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.SegmentButton:beginAnimation(150)
				f17_arg0.SegmentButton:setScale(1.05, 1.05)
				f17_arg0.SegmentButton:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SegmentButton:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.SegmentButton:completeAnimation()
			f17_arg0.SegmentButton:setScale(1, 1)
			f17_local0(f17_arg0.SegmentButton)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.SegmentButton:beginAnimation(150)
				f19_arg0.SegmentButton:setScale(1, 1)
				f19_arg0.SegmentButton:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.SegmentButton:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.SegmentButton:completeAnimation()
			f19_arg0.SegmentButton:setScale(1.05, 1.05)
			f19_local0(f19_arg0.SegmentButton)
		end,
	},
}
CoD.SegmentButton.__onClose = function(f21_arg0)
	f21_arg0.SegmentButton:close()
end
