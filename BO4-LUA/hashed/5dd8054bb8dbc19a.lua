require("x64:31a4b0ad2fb3c96")
CoD.LaboratoryPlasma_ListButton = InheritFrom(LUI.UIElement)
CoD.LaboratoryPlasma_ListButton.__defaultWidth = 650
CoD.LaboratoryPlasma_ListButton.__defaultHeight = 90
CoD.LaboratoryPlasma_ListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryPlasma_ListButton)
	self.id = "LaboratoryPlasma_ListButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.LaboratoryPlasma_ListButton_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -325, 325, 0.5, 0.5, -45, 45)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	self:mergeStateConditions({
		{
			stateName = "IsFeatured",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isFeatured")
			end,
		},
	})
	self:linkToElementModel(self, "isFeatured", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isFeatured",
		})
	end)
	Button.id = "Button"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryPlasma_ListButton.__resetProperties = function(f5_arg0)
	f5_arg0.Button:completeAnimation()
	f5_arg0.Button:setScale(1, 1)
end
CoD.LaboratoryPlasma_ListButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Button:completeAnimation()
			f7_arg0.Button:setScale(1.05, 1.05)
			f7_arg0.clipFinished(f7_arg0.Button)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Button:beginAnimation(200)
				f8_arg0.Button:setScale(1.05, 1.05)
				f8_arg0.Button:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Button:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Button:completeAnimation()
			f8_arg0.Button:setScale(1, 1)
			f8_local0(f8_arg0.Button)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.Button:beginAnimation(200)
				f10_arg0.Button:setScale(1, 1)
				f10_arg0.Button:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Button:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Button:completeAnimation()
			f10_arg0.Button:setScale(1.05, 1.05)
			f10_local0(f10_arg0.Button)
		end,
	},
	IsFeatured = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Button:completeAnimation()
			f13_arg0.Button:setScale(1.05, 1.05)
			f13_arg0.clipFinished(f13_arg0.Button)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Button:beginAnimation(200)
				f14_arg0.Button:setScale(1.05, 1.05)
				f14_arg0.Button:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Button:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Button:completeAnimation()
			f14_arg0.Button:setScale(1, 1)
			f14_local0(f14_arg0.Button)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Button:beginAnimation(200)
				f16_arg0.Button:setScale(1, 1)
				f16_arg0.Button:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Button:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Button:completeAnimation()
			f16_arg0.Button:setScale(1.05, 1.05)
			f16_local0(f16_arg0.Button)
		end,
	},
}
CoD.LaboratoryPlasma_ListButton.__onClose = function(f18_arg0)
	f18_arg0.Button:close()
end
