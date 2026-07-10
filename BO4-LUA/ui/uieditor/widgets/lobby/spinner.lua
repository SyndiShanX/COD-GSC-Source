require("x64:d210adadabcfe9f")
CoD.Spinner = InheritFrom(LUI.UIElement)
CoD.Spinner.__defaultWidth = 1920
CoD.Spinner.__defaultHeight = 1080
CoD.Spinner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Spinner)
	self.id = "Spinner"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AnimationLoadingWidget0 = CoD.AnimationLoadingWidget.new(f1_arg0, f1_arg1, 1, 1, -282, -66, 1, 1, -270, -54)
	AnimationLoadingWidget0:setScale(0.65, 0.65)
	self:addElement(AnimationLoadingWidget0)
	self.AnimationLoadingWidget0 = AnimationLoadingWidget0
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive")
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.spinnerActive"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.spinnerActive",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsSelfInState(self, "Visible") then
			CoD.LobbyUtility.SetSpinnerActive(true)
		else
			CoD.LobbyUtility.SetSpinnerActive(false)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Spinner.__resetProperties = function(f5_arg0)
	f5_arg0.AnimationLoadingWidget0:completeAnimation()
	f5_arg0.AnimationLoadingWidget0:setAlpha(1)
end
CoD.Spinner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.AnimationLoadingWidget0:completeAnimation()
			f6_arg0.AnimationLoadingWidget0:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AnimationLoadingWidget0)
		end,
		Visible = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.AnimationLoadingWidget0:beginAnimation(200)
				f7_arg0.AnimationLoadingWidget0:setAlpha(1)
				f7_arg0.AnimationLoadingWidget0:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AnimationLoadingWidget0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.AnimationLoadingWidget0:completeAnimation()
			f7_arg0.AnimationLoadingWidget0:setAlpha(0)
			f7_local0(f7_arg0.AnimationLoadingWidget0)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.AnimationLoadingWidget0:beginAnimation(200)
				f10_arg0.AnimationLoadingWidget0:setAlpha(0)
				f10_arg0.AnimationLoadingWidget0:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.AnimationLoadingWidget0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.AnimationLoadingWidget0:completeAnimation()
			f10_arg0.AnimationLoadingWidget0:setAlpha(1)
			f10_local0(f10_arg0.AnimationLoadingWidget0)
		end,
	},
}
CoD.Spinner.__onClose = function(f12_arg0)
	f12_arg0.AnimationLoadingWidget0:close()
end
