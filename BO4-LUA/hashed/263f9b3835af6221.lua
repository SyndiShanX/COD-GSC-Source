require("x64:548e655549337ec")
CoD.DirectorTheaterModeSelectButton = InheritFrom(LUI.UIElement)
CoD.DirectorTheaterModeSelectButton.__defaultWidth = 390
CoD.DirectorTheaterModeSelectButton.__defaultHeight = 280
CoD.DirectorTheaterModeSelectButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTheaterModeSelectButton)
	self.id = "DirectorTheaterModeSelectButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorTheaterModeSelectButtonInternal = CoD.DirectorTheaterModeSelectButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0, 1, 0, 0)
	DirectorTheaterModeSelectButtonInternal:linkToElementModel(self, nil, false, function(model)
		DirectorTheaterModeSelectButtonInternal:setModel(model, f1_arg1)
	end)
	DirectorTheaterModeSelectButtonInternal:linkToElementModel(self, "subtitle", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorTheaterModeSelectButtonInternal.ButtonText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(DirectorTheaterModeSelectButtonInternal)
	self.DirectorTheaterModeSelectButtonInternal = DirectorTheaterModeSelectButtonInternal
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "locked")
			end,
		},
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "locked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	DirectorTheaterModeSelectButtonInternal.id = "DirectorTheaterModeSelectButtonInternal"
	self.__defaultFocus = DirectorTheaterModeSelectButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTheaterModeSelectButton.__resetProperties = function(f7_arg0)
	f7_arg0.DirectorTheaterModeSelectButtonInternal:completeAnimation()
	f7_arg0.DirectorTheaterModeSelectButtonInternal:setScale(1, 1)
end
CoD.DirectorTheaterModeSelectButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.DirectorTheaterModeSelectButtonInternal:completeAnimation()
			f9_arg0.DirectorTheaterModeSelectButtonInternal:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.DirectorTheaterModeSelectButtonInternal)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.DirectorTheaterModeSelectButtonInternal:beginAnimation(200)
				f10_arg0.DirectorTheaterModeSelectButtonInternal:setScale(1.05, 1.05)
				f10_arg0.DirectorTheaterModeSelectButtonInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.DirectorTheaterModeSelectButtonInternal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.DirectorTheaterModeSelectButtonInternal:completeAnimation()
			f10_arg0.DirectorTheaterModeSelectButtonInternal:setScale(1, 1)
			f10_local0(f10_arg0.DirectorTheaterModeSelectButtonInternal)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.DirectorTheaterModeSelectButtonInternal:beginAnimation(200)
				f12_arg0.DirectorTheaterModeSelectButtonInternal:setScale(1, 1)
				f12_arg0.DirectorTheaterModeSelectButtonInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.DirectorTheaterModeSelectButtonInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.DirectorTheaterModeSelectButtonInternal:completeAnimation()
			f12_arg0.DirectorTheaterModeSelectButtonInternal:setScale(1.05, 1.05)
			f12_local0(f12_arg0.DirectorTheaterModeSelectButtonInternal)
		end,
	},
	Locked = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Unselectable = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorTheaterModeSelectButton.__onClose = function(f16_arg0)
	f16_arg0.DirectorTheaterModeSelectButtonInternal:close()
end
