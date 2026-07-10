require("x64:f91d9d528eb4ebd")
require("x64:1f846296f1a1b81")
CoD.DirectorPreGameButtonLeftJustified = InheritFrom(LUI.UIElement)
CoD.DirectorPreGameButtonLeftJustified.__defaultWidth = 212
CoD.DirectorPreGameButtonLeftJustified.__defaultHeight = 50
CoD.DirectorPreGameButtonLeftJustified.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPreGameButtonLeftJustified)
	self.id = "DirectorPreGameButtonLeftJustified"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local baseButton = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 212, 0, 0, 0, 50)
	baseButton:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "locked")
			end,
		},
	})
	baseButton:linkToElementModel(baseButton, "trialLocked", true, function(model)
		f1_arg0:updateElementState(baseButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	baseButton:linkToElementModel(baseButton, "locked", true, function(model)
		f1_arg0:updateElementState(baseButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	baseButton.MiddleText:setTTF("ttmussels_regular")
	baseButton.MiddleTextFocus:setTTF("ttmussels_regular")
	baseButton:linkToElementModel(self, nil, false, function(model)
		baseButton:setModel(model, f1_arg1)
	end)
	baseButton:linkToElementModel(self, "subtitle", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			baseButton.MiddleText:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	baseButton:linkToElementModel(self, "subtitle", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			baseButton.MiddleTextFocus:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	self:addElement(baseButton)
	self.baseButton = baseButton
	local sizeElement = CoD.DirectorSelectButtonImageInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 212, 0, 0, 0, 50)
	sizeElement:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "locked")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	sizeElement:linkToElementModel(sizeElement, "trialLocked", true, function(model)
		f1_arg0:updateElementState(sizeElement, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	sizeElement:linkToElementModel(sizeElement, "locked", true, function(model)
		f1_arg0:updateElementState(sizeElement, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	sizeElement:setAlpha(0)
	sizeElement.Tint:setRGB(0.05, 0.08, 0.11)
	sizeElement.Tint:setAlpha(0.25)
	sizeElement:linkToElementModel(self, nil, false, function(model)
		sizeElement:setModel(model, f1_arg1)
	end)
	sizeElement:linkToElementModel(self, "subtitle", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			sizeElement.ButtonName.GameModeText:setText(ToUpper(CoD.BaseUtility.LocalizeIfXHash(f15_local0)))
		end
	end)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	self:mergeStateConditions({
		{
			stateName = "Large",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "small")
			end,
		},
	})
	self:linkToElementModel(self, "small", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "small",
		})
	end)
	baseButton.id = "baseButton"
	sizeElement.id = "sizeElement"
	self.__defaultFocus = baseButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPreGameButtonLeftJustified.__resetProperties = function(f18_arg0)
	f18_arg0.baseButton:completeAnimation()
	f18_arg0.sizeElement:completeAnimation()
	f18_arg0.baseButton:setTopBottom(0, 0, 0, 50)
	f18_arg0.baseButton:setAlpha(1)
	f18_arg0.baseButton:setScale(1, 1)
	f18_arg0.sizeElement:setLeftRight(0, 0, 0, 212)
	f18_arg0.sizeElement:setTopBottom(0, 0, 0, 50)
	f18_arg0.sizeElement:setAlpha(0)
	f18_arg0.sizeElement:setScale(1, 1)
end
CoD.DirectorPreGameButtonLeftJustified.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.baseButton:completeAnimation()
			f20_arg0.baseButton:setScale(1.05, 1.05)
			f20_arg0.clipFinished(f20_arg0.baseButton)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.baseButton:beginAnimation(200)
				f21_arg0.baseButton:setScale(1.05, 1.05)
				f21_arg0.baseButton:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.baseButton:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.baseButton:completeAnimation()
			f21_arg0.baseButton:setScale(1, 1)
			f21_local0(f21_arg0.baseButton)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.baseButton:beginAnimation(200)
				f23_arg0.baseButton:setScale(1, 1)
				f23_arg0.baseButton:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.baseButton:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.baseButton:completeAnimation()
			f23_arg0.baseButton:setScale(1.05, 1.05)
			f23_local0(f23_arg0.baseButton)
		end,
	},
	Large = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.baseButton:completeAnimation()
			f25_arg0.baseButton:setTopBottom(0, 0, 0, 197)
			f25_arg0.baseButton:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.baseButton)
			f25_arg0.sizeElement:completeAnimation()
			f25_arg0.sizeElement:setLeftRight(0, 0, 0, 212)
			f25_arg0.sizeElement:setTopBottom(0, 0, 0, 189)
			f25_arg0.sizeElement:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.sizeElement)
		end,
		ChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.baseButton:completeAnimation()
			f26_arg0.baseButton:setTopBottom(0, 0, 0, 197)
			f26_arg0.baseButton:setAlpha(0)
			f26_arg0.baseButton:setScale(1.05, 1.05)
			f26_arg0.clipFinished(f26_arg0.baseButton)
			f26_arg0.sizeElement:completeAnimation()
			f26_arg0.sizeElement:setLeftRight(0, 0, 0, 212)
			f26_arg0.sizeElement:setTopBottom(0, 0, 0, 189)
			f26_arg0.sizeElement:setAlpha(1)
			f26_arg0.sizeElement:setScale(1.05, 1.05)
			f26_arg0.clipFinished(f26_arg0.sizeElement)
		end,
		GainChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.baseButton:beginAnimation(200)
				f27_arg0.baseButton:setScale(1.05, 1.05)
				f27_arg0.baseButton:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.baseButton:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.baseButton:completeAnimation()
			f27_arg0.baseButton:setTopBottom(0, 0, 0, 197)
			f27_arg0.baseButton:setAlpha(0)
			f27_arg0.baseButton:setScale(1, 1)
			f27_local0(f27_arg0.baseButton)
			local f27_local1 = function(f29_arg0)
				f27_arg0.sizeElement:beginAnimation(200)
				f27_arg0.sizeElement:setScale(1.05, 1.05)
				f27_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.sizeElement:completeAnimation()
			f27_arg0.sizeElement:setLeftRight(0, 0, 0, 212)
			f27_arg0.sizeElement:setTopBottom(0, 0, 0, 189)
			f27_arg0.sizeElement:setAlpha(1)
			f27_arg0.sizeElement:setScale(1, 1)
			f27_local1(f27_arg0.sizeElement)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				f30_arg0.baseButton:beginAnimation(200)
				f30_arg0.baseButton:setScale(1, 1)
				f30_arg0.baseButton:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.baseButton:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.baseButton:completeAnimation()
			f30_arg0.baseButton:setTopBottom(0, 0, 0, 197)
			f30_arg0.baseButton:setAlpha(0)
			f30_arg0.baseButton:setScale(1.05, 1.05)
			f30_local0(f30_arg0.baseButton)
			local f30_local1 = function(f32_arg0)
				f30_arg0.sizeElement:beginAnimation(200)
				f30_arg0.sizeElement:setScale(1, 1)
				f30_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.sizeElement:completeAnimation()
			f30_arg0.sizeElement:setLeftRight(0, 0, 0, 212)
			f30_arg0.sizeElement:setTopBottom(0, 0, 0, 189)
			f30_arg0.sizeElement:setAlpha(1)
			f30_arg0.sizeElement:setScale(1.05, 1.05)
			f30_local1(f30_arg0.sizeElement)
		end,
	},
}
CoD.DirectorPreGameButtonLeftJustified.__onClose = function(f33_arg0)
	f33_arg0.baseButton:close()
	f33_arg0.sizeElement:close()
end
