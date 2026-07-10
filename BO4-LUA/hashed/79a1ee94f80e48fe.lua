require("x64:ba1840fbd23c6bb")
CoD.BM_AvailabeContractItem = InheritFrom(LUI.UIElement)
CoD.BM_AvailabeContractItem.__defaultWidth = 200
CoD.BM_AvailabeContractItem.__defaultHeight = 200
CoD.BM_AvailabeContractItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_AvailabeContractItem)
	self.id = "BM_AvailabeContractItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BMContractEquippedTick = CoD.BM_AvailabeContractItemInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0.5, 0.5, -100, 100)
	BMContractEquippedTick:linkToElementModel(self, nil, false, function(model)
		BMContractEquippedTick:setModel(model, f1_arg1)
	end)
	self:addElement(BMContractEquippedTick)
	self.BMContractEquippedTick = BMContractEquippedTick
	self:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
		{
			stateName = "Hard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "difficulty", 1)
			end,
		},
	})
	self:linkToElementModel(self, "completed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	self:linkToElementModel(self, "difficulty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "difficulty",
		})
	end)
	BMContractEquippedTick.id = "BMContractEquippedTick"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_AvailabeContractItem.__resetProperties = function(f7_arg0)
	f7_arg0.BMContractEquippedTick:completeAnimation()
	f7_arg0.BMContractEquippedTick:setScale(1, 1)
end
CoD.BM_AvailabeContractItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.BMContractEquippedTick:completeAnimation()
			f9_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
			f9_arg0.clipFinished(f9_arg0.BMContractEquippedTick)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.BMContractEquippedTick:beginAnimation(200)
				f10_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
				f10_arg0.BMContractEquippedTick:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BMContractEquippedTick:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.BMContractEquippedTick:completeAnimation()
			f10_arg0.BMContractEquippedTick:setScale(1, 1)
			f10_local0(f10_arg0.BMContractEquippedTick)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.BMContractEquippedTick:beginAnimation(200)
				f12_arg0.BMContractEquippedTick:setScale(1, 1)
				f12_arg0.BMContractEquippedTick:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BMContractEquippedTick:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.BMContractEquippedTick:completeAnimation()
			f12_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
			f12_local0(f12_arg0.BMContractEquippedTick)
		end,
	},
	Completed = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.BMContractEquippedTick:completeAnimation()
			f15_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
			f15_arg0.clipFinished(f15_arg0.BMContractEquippedTick)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.BMContractEquippedTick:beginAnimation(200)
				f16_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
				f16_arg0.BMContractEquippedTick:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.BMContractEquippedTick:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.BMContractEquippedTick:completeAnimation()
			f16_arg0.BMContractEquippedTick:setScale(1, 1)
			f16_local0(f16_arg0.BMContractEquippedTick)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.BMContractEquippedTick:beginAnimation(200)
				f18_arg0.BMContractEquippedTick:setScale(1, 1)
				f18_arg0.BMContractEquippedTick:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.BMContractEquippedTick:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.BMContractEquippedTick:completeAnimation()
			f18_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
			f18_local0(f18_arg0.BMContractEquippedTick)
		end,
	},
	Hard = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.BMContractEquippedTick:completeAnimation()
			f21_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
			f21_arg0.clipFinished(f21_arg0.BMContractEquippedTick)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.BMContractEquippedTick:beginAnimation(200)
				f22_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
				f22_arg0.BMContractEquippedTick:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.BMContractEquippedTick:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.BMContractEquippedTick:completeAnimation()
			f22_arg0.BMContractEquippedTick:setScale(1, 1)
			f22_local0(f22_arg0.BMContractEquippedTick)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.BMContractEquippedTick:beginAnimation(200)
				f24_arg0.BMContractEquippedTick:setScale(1, 1)
				f24_arg0.BMContractEquippedTick:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.BMContractEquippedTick:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.BMContractEquippedTick:completeAnimation()
			f24_arg0.BMContractEquippedTick:setScale(1.06, 1.06)
			f24_local0(f24_arg0.BMContractEquippedTick)
		end,
	},
}
CoD.BM_AvailabeContractItem.__onClose = function(f26_arg0)
	f26_arg0.BMContractEquippedTick:close()
end
