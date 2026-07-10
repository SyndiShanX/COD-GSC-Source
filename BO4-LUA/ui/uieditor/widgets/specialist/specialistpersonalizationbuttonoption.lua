require("x64:dbb04b55fa27ac6")
require("x64:b20339e832dc8eb")
CoD.SpecialistPersonalizationButtonOption = InheritFrom(LUI.UIElement)
CoD.SpecialistPersonalizationButtonOption.__defaultWidth = 393
CoD.SpecialistPersonalizationButtonOption.__defaultHeight = 69
CoD.SpecialistPersonalizationButtonOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistPersonalizationButtonOption)
	self.id = "SpecialistPersonalizationButtonOption"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonOptionInternal = CoD.SpecialistPersonalizationButtonOptionInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 393, 0, 0, 0, 69)
	ButtonOptionInternal:linkToElementModel(self, nil, false, function(model)
		ButtonOptionInternal:setModel(model, f1_arg1)
	end)
	ButtonOptionInternal:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ButtonOptionInternal.Header:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(ButtonOptionInternal)
	self.ButtonOptionInternal = ButtonOptionInternal
	local breadcrumbCount = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 1, 1, -31, -4, 0, 0, 0, 27)
	breadcrumbCount:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	breadcrumbCount:linkToElementModel(breadcrumbCount, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(breadcrumbCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	breadcrumbCount:linkToElementModel(self, "breadcrumb", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			breadcrumbCount:setModel(f6_local0, f1_arg1)
		end
	end)
	self:addElement(breadcrumbCount)
	self.breadcrumbCount = breadcrumbCount
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "disabled")
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
	ButtonOptionInternal.id = "ButtonOptionInternal"
	self.__defaultFocus = ButtonOptionInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistPersonalizationButtonOption.__resetProperties = function(f9_arg0)
	f9_arg0.ButtonOptionInternal:completeAnimation()
	f9_arg0.ButtonOptionInternal:setRGB(1, 1, 1)
	f9_arg0.ButtonOptionInternal:setAlpha(1)
	f9_arg0.ButtonOptionInternal:setScale(1, 1)
end
CoD.SpecialistPersonalizationButtonOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ButtonOptionInternal:completeAnimation()
			f11_arg0.ButtonOptionInternal:setScale(1.03, 1.12)
			f11_arg0.clipFinished(f11_arg0.ButtonOptionInternal)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ButtonOptionInternal:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f12_arg0.ButtonOptionInternal:setScale(1.03, 1.12)
				f12_arg0.ButtonOptionInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ButtonOptionInternal:completeAnimation()
			f12_arg0.ButtonOptionInternal:setScale(1, 1)
			f12_local0(f12_arg0.ButtonOptionInternal)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.ButtonOptionInternal:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f14_arg0.ButtonOptionInternal:setScale(1, 1)
				f14_arg0.ButtonOptionInternal:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ButtonOptionInternal:completeAnimation()
			f14_arg0.ButtonOptionInternal:setScale(1.03, 1.12)
			f14_local0(f14_arg0.ButtonOptionInternal)
		end,
		Active = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.ButtonOptionInternal:completeAnimation()
			f16_arg0.ButtonOptionInternal:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.ButtonOptionInternal)
		end,
		ActiveAndChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ButtonOptionInternal:completeAnimation()
			f17_arg0.ButtonOptionInternal:setScale(1.03, 1.12)
			f17_arg0.clipFinished(f17_arg0.ButtonOptionInternal)
		end,
		ActiveToActiveAndChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.ButtonOptionInternal:beginAnimation(100)
				f18_arg0.ButtonOptionInternal:setScale(1.03, 1.12)
				f18_arg0.ButtonOptionInternal:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.ButtonOptionInternal:completeAnimation()
			f18_arg0.ButtonOptionInternal:setAlpha(1)
			f18_arg0.ButtonOptionInternal:setScale(1, 1)
			f18_local0(f18_arg0.ButtonOptionInternal)
		end,
		ActiveAndChildFocusToActive = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.ButtonOptionInternal:beginAnimation(100)
				f20_arg0.ButtonOptionInternal:setScale(1, 1)
				f20_arg0.ButtonOptionInternal:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ButtonOptionInternal:completeAnimation()
			f20_arg0.ButtonOptionInternal:setAlpha(1)
			f20_arg0.ButtonOptionInternal:setScale(1.03, 1.12)
			f20_local0(f20_arg0.ButtonOptionInternal)
		end,
	},
	Disabled = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.ButtonOptionInternal:completeAnimation()
			f22_arg0.ButtonOptionInternal:setRGB(0.64, 0.64, 0.64)
			f22_arg0.clipFinished(f22_arg0.ButtonOptionInternal)
		end,
	},
}
if not CoD.isPC then
	CoD.SpecialistPersonalizationButtonOption.__clipsPerState.DefaultState.Active = nil
	CoD.SpecialistPersonalizationButtonOption.__clipsPerState.DefaultState.ActiveAndChildFocus = nil
	CoD.SpecialistPersonalizationButtonOption.__clipsPerState.DefaultState.ActiveToActiveAndChildFocus = nil
	CoD.SpecialistPersonalizationButtonOption.__clipsPerState.DefaultState.ActiveAndChildFocusToActive = nil
end
CoD.SpecialistPersonalizationButtonOption.__onClose = function(f23_arg0)
	f23_arg0.ButtonOptionInternal:close()
	f23_arg0.breadcrumbCount:close()
end
