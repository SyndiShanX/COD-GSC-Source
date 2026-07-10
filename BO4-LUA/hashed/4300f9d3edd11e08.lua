require("x64:f64a16f3daec0d")
require("x64:3a6f78fa6060013")
CoD.BM_ContractDetails = InheritFrom(LUI.UIElement)
CoD.BM_ContractDetails.__defaultWidth = 460
CoD.BM_ContractDetails.__defaultHeight = 636
CoD.BM_ContractDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ContractDetails)
	self.id = "BM_ContractDetails"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonMiniInternal = CoD.BM_ContractsSlotButton.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsInDefaultState(self)
			end,
		},
	})
	DirectorSelectButtonMiniInternal:setAlpha(0.6)
	DirectorSelectButtonMiniInternal.SceneBlur:setAlpha(0)
	DirectorSelectButtonMiniInternal:linkToElementModel(self, nil, false, function(model)
		DirectorSelectButtonMiniInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	local BMContractDetailsInternal = CoD.BM_ContractDetailsInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -230, 230, 0.5, 0.5, -317, 317)
	BMContractDetailsInternal:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed") and IsInDefaultState(self)
			end,
		},
	})
	BMContractDetailsInternal:linkToElementModel(BMContractDetailsInternal, "displayName", true, function(model)
		f1_arg0:updateElementState(BMContractDetailsInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "displayName",
		})
	end)
	BMContractDetailsInternal:linkToElementModel(BMContractDetailsInternal, "completed", true, function(model)
		f1_arg0:updateElementState(BMContractDetailsInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	BMContractDetailsInternal:linkToElementModel(self, nil, false, function(model)
		BMContractDetailsInternal:setModel(model, f1_arg1)
	end)
	self:addElement(BMContractDetailsInternal)
	self.BMContractDetailsInternal = BMContractDetailsInternal
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	self.__defaultFocus = DirectorSelectButtonMiniInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ContractDetails.__resetProperties = function(f8_arg0)
	f8_arg0.BMContractDetailsInternal:completeAnimation()
	f8_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f8_arg0.BMContractDetailsInternal:setScale(1, 1)
	f8_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
end
CoD.BM_ContractDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	ContractSlot = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f11_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.DirectorSelectButtonMiniInternal)
			f11_arg0.BMContractDetailsInternal:completeAnimation()
			f11_arg0.BMContractDetailsInternal:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.BMContractDetailsInternal)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.DirectorSelectButtonMiniInternal:beginAnimation(150)
				f12_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
				f12_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f12_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f12_local0(f12_arg0.DirectorSelectButtonMiniInternal)
			local f12_local1 = function(f14_arg0)
				f12_arg0.BMContractDetailsInternal:beginAnimation(150)
				f12_arg0.BMContractDetailsInternal:setScale(1.05, 1.05)
				f12_arg0.BMContractDetailsInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BMContractDetailsInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.BMContractDetailsInternal:completeAnimation()
			f12_arg0.BMContractDetailsInternal:setScale(1, 1)
			f12_local1(f12_arg0.BMContractDetailsInternal)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.DirectorSelectButtonMiniInternal:beginAnimation(100)
				f15_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f15_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f15_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f15_local0(f15_arg0.DirectorSelectButtonMiniInternal)
			local f15_local1 = function(f17_arg0)
				f15_arg0.BMContractDetailsInternal:beginAnimation(100)
				f15_arg0.BMContractDetailsInternal:setScale(1, 1)
				f15_arg0.BMContractDetailsInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.BMContractDetailsInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.BMContractDetailsInternal:completeAnimation()
			f15_arg0.BMContractDetailsInternal:setScale(1.05, 1.05)
			f15_local1(f15_arg0.BMContractDetailsInternal)
		end,
	},
}
CoD.BM_ContractDetails.__onClose = function(f18_arg0)
	f18_arg0.DirectorSelectButtonMiniInternal:close()
	f18_arg0.BMContractDetailsInternal:close()
end
