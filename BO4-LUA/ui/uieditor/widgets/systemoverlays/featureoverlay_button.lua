require("ui/uieditor/widgets/systemoverlays/featureoverlay_button_container")
CoD.featureOverlay_Button = InheritFrom(LUI.UIElement)
CoD.featureOverlay_Button.__defaultWidth = 200
CoD.featureOverlay_Button.__defaultHeight = 60
CoD.featureOverlay_Button.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.featureOverlay_Button)
	self.id = "featureOverlay_Button"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonContainer = CoD.featureOverlay_Button_Container.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ButtonContainer:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Disabled")
			end,
		},
	})
	ButtonContainer.Blur:setAlpha(0.05)
	ButtonContainer:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(ButtonContainer)
	self.ButtonContainer = ButtonContainer
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		UpdateElementState(self, "ButtonContainer", controller)
	end)
	ButtonContainer.id = "ButtonContainer"
	self.__defaultFocus = ButtonContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.featureOverlay_Button.__resetProperties = function(f5_arg0)
	f5_arg0.ButtonContainer:completeAnimation()
	f5_arg0.ButtonContainer:setAlpha(1)
	f5_arg0.ButtonContainer:setScale(1, 1)
	f5_arg0.ButtonContainer.Title:setAlpha(1)
end
CoD.featureOverlay_Button.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ButtonContainer:completeAnimation()
			f6_arg0.ButtonContainer:setScale(0.98, 0.95)
			f6_arg0.clipFinished(f6_arg0.ButtonContainer)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ButtonContainer:completeAnimation()
			f7_arg0.ButtonContainer:setScale(1.03, 1.03)
			f7_arg0.clipFinished(f7_arg0.ButtonContainer)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ButtonContainer:beginAnimation(150)
				f8_arg0.ButtonContainer:setScale(1.03, 1.03)
				f8_arg0.ButtonContainer:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ButtonContainer:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ButtonContainer:completeAnimation()
			f8_arg0.ButtonContainer:setScale(0.98, 0.95)
			f8_local0(f8_arg0.ButtonContainer)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.ButtonContainer:beginAnimation(100)
				f10_arg0.ButtonContainer:setScale(0.98, 0.95)
				f10_arg0.ButtonContainer:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ButtonContainer:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ButtonContainer:completeAnimation()
			f10_arg0.ButtonContainer:setScale(1.03, 1.03)
			f10_local0(f10_arg0.ButtonContainer)
		end,
	},
	Disabled = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ButtonContainer:completeAnimation()
			f12_arg0.ButtonContainer.Title:completeAnimation()
			f12_arg0.ButtonContainer:setAlpha(0.5)
			f12_arg0.ButtonContainer.Title:setAlpha(0.3)
			f12_arg0.clipFinished(f12_arg0.ButtonContainer)
		end,
	},
}
CoD.featureOverlay_Button.__onClose = function(f13_arg0)
	f13_arg0.ButtonContainer:close()
end
