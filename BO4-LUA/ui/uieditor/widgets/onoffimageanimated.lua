require("x64:7323f389161595d")
CoD.onOffImageAnimated = InheritFrom(LUI.UIElement)
CoD.onOffImageAnimated.__defaultWidth = 30
CoD.onOffImageAnimated.__defaultHeight = 30
CoD.onOffImageAnimated.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.onOffImageAnimated)
	self.id = "onOffImageAnimated"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local promptContainer = CoD.FaceButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0, 0, 0, 30, 0, 0, 0, 30)
	promptContainer:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			promptContainer.ControllerImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(promptContainer)
	self.promptContainer = promptContainer
	promptContainer.id = "promptContainer"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.FreeCursorUtility.UseSelfWidthIfElementVisible(self, self.promptContainer)
	return self
end
CoD.onOffImageAnimated.__resetProperties = function(f3_arg0)
	f3_arg0.promptContainer:completeAnimation()
	f3_arg0.promptContainer:setAlpha(1)
end
CoD.onOffImageAnimated.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.promptContainer:completeAnimation()
			f4_arg0.promptContainer:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.promptContainer)
		end,
		On = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.promptContainer:beginAnimation(200)
				f5_arg0.promptContainer:setAlpha(1)
				f5_arg0.promptContainer:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.promptContainer:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.promptContainer:completeAnimation()
			f5_arg0.promptContainer:setAlpha(0)
			f5_local0(f5_arg0.promptContainer)
		end,
	},
	On = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.promptContainer:beginAnimation(200)
				f8_arg0.promptContainer:setAlpha(0)
				f8_arg0.promptContainer:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.promptContainer:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.promptContainer:completeAnimation()
			f8_arg0.promptContainer:setAlpha(1)
			f8_local0(f8_arg0.promptContainer)
		end,
	},
}
CoD.onOffImageAnimated.__onClose = function(f10_arg0)
	f10_arg0.promptContainer:close()
end
