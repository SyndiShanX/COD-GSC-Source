require("x64:ab3f46201c530b4")
CoD.DirectorSelectButton = InheritFrom(LUI.UIElement)
CoD.DirectorSelectButton.__defaultWidth = 300
CoD.DirectorSelectButton.__defaultHeight = 394
CoD.DirectorSelectButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorSelectButton)
	self.id = "DirectorSelectButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonInternal = CoD.DirectorSelectButtonInternalCard.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonInternal.ImageNotFocus:setAlpha(0.85)
	DirectorSelectButtonInternal.ImageMask:setAlpha(0)
	DirectorSelectButtonInternal:linkToElementModel(self, nil, false, function(model)
		DirectorSelectButtonInternal:setModel(model, f1_arg1)
	end)
	DirectorSelectButtonInternal:linkToElementModel(self, "iconBackground", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorSelectButtonInternal.ImageNotFocus:setImage(RegisterImage(f3_local0))
		end
	end)
	DirectorSelectButtonInternal:linkToElementModel(self, "iconBackgroundFocus", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorSelectButtonInternal.ImageFocus:setImage(RegisterImage(f4_local0))
		end
	end)
	DirectorSelectButtonInternal:linkToElementModel(self, "subtitle", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DirectorSelectButtonInternal.LeaderActivityText:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	DirectorSelectButtonInternal:linkToElementModel(self, "name", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DirectorSelectButtonInternal.MiddleText:setText(ToUpper(CoD.BaseUtility.LocalizeIfXHash(f6_local0)))
		end
	end)
	DirectorSelectButtonInternal:linkToElementModel(self, "playlistDesc", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			DirectorSelectButtonInternal.GameModeDescription:setText(CoD.BaseUtility.LocalizeIfXHash(f7_local0))
		end
	end)
	self:addElement(DirectorSelectButtonInternal)
	self.DirectorSelectButtonInternal = DirectorSelectButtonInternal
	self:mergeStateConditions({
		{
			stateName = "Small",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "small")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "locked")
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
	self:linkToElementModel(self, "locked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	DirectorSelectButtonInternal.id = "DirectorSelectButtonInternal"
	self.__defaultFocus = DirectorSelectButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorSelectButton.__resetProperties = function(f12_arg0)
	f12_arg0.DirectorSelectButtonInternal:completeAnimation()
	f12_arg0.DirectorSelectButtonInternal:setAlpha(1)
	f12_arg0.DirectorSelectButtonInternal:setZoom(0)
	f12_arg0.DirectorSelectButtonInternal:setScale(1, 1)
	f12_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(0.85)
	f12_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(0)
end
CoD.DirectorSelectButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.DirectorSelectButtonInternal:completeAnimation()
			f13_arg0.DirectorSelectButtonInternal.ImageNotFocus:completeAnimation()
			f13_arg0.DirectorSelectButtonInternal.ImageFocus:completeAnimation()
			f13_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(0.85)
			f13_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DirectorSelectButtonInternal)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.DirectorSelectButtonInternal:completeAnimation()
			f14_arg0.DirectorSelectButtonInternal.ImageNotFocus:completeAnimation()
			f14_arg0.DirectorSelectButtonInternal.ImageFocus:completeAnimation()
			f14_arg0.DirectorSelectButtonInternal:setZoom(5)
			f14_arg0.DirectorSelectButtonInternal:setScale(1.05, 1.05)
			f14_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(1)
			f14_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.DirectorSelectButtonInternal)
		end,
		GainChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.DirectorSelectButtonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f15_arg0.DirectorSelectButtonInternal.ImageNotFocus:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f15_arg0.DirectorSelectButtonInternal.ImageFocus:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f15_arg0.DirectorSelectButtonInternal:setScale(1.05, 1.05)
				f15_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(1)
				f15_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(1)
				f15_arg0.DirectorSelectButtonInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.DirectorSelectButtonInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.DirectorSelectButtonInternal:completeAnimation()
			f15_arg0.DirectorSelectButtonInternal.ImageNotFocus:completeAnimation()
			f15_arg0.DirectorSelectButtonInternal.ImageFocus:completeAnimation()
			f15_arg0.DirectorSelectButtonInternal:setZoom(5)
			f15_arg0.DirectorSelectButtonInternal:setScale(1, 1)
			f15_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(0.85)
			f15_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(0)
			f15_local0(f15_arg0.DirectorSelectButtonInternal)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.DirectorSelectButtonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f17_arg0.DirectorSelectButtonInternal.ImageNotFocus:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f17_arg0.DirectorSelectButtonInternal.ImageFocus:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f17_arg0.DirectorSelectButtonInternal:setScale(1, 1)
				f17_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(0.85)
				f17_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(0)
				f17_arg0.DirectorSelectButtonInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DirectorSelectButtonInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.DirectorSelectButtonInternal:completeAnimation()
			f17_arg0.DirectorSelectButtonInternal.ImageNotFocus:completeAnimation()
			f17_arg0.DirectorSelectButtonInternal.ImageFocus:completeAnimation()
			f17_arg0.DirectorSelectButtonInternal:setZoom(0)
			f17_arg0.DirectorSelectButtonInternal:setScale(1.05, 1.05)
			f17_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(1)
			f17_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(1)
			f17_local0(f17_arg0.DirectorSelectButtonInternal)
		end,
	},
	Small = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.DirectorSelectButtonInternal:completeAnimation()
			f19_arg0.DirectorSelectButtonInternal:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DirectorSelectButtonInternal)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.DirectorSelectButtonInternal:completeAnimation()
			f20_arg0.DirectorSelectButtonInternal:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DirectorSelectButtonInternal)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.DirectorSelectButtonInternal:completeAnimation()
			f21_arg0.DirectorSelectButtonInternal:setAlpha(0)
			f21_arg0.DirectorSelectButtonInternal:setScale(1, 1)
			f21_arg0.clipFinished(f21_arg0.DirectorSelectButtonInternal)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.DirectorSelectButtonInternal:completeAnimation()
			f22_arg0.DirectorSelectButtonInternal:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.DirectorSelectButtonInternal)
		end,
	},
	Locked = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.DirectorSelectButtonInternal:completeAnimation()
			f23_arg0.clipFinished(f23_arg0.DirectorSelectButtonInternal)
		end,
		ChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.DirectorSelectButtonInternal:completeAnimation()
			f24_arg0.DirectorSelectButtonInternal.ImageNotFocus:completeAnimation()
			f24_arg0.DirectorSelectButtonInternal.ImageFocus:completeAnimation()
			f24_arg0.DirectorSelectButtonInternal:setScale(1.05, 1.05)
			f24_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(1)
			f24_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.DirectorSelectButtonInternal)
		end,
		GainChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.DirectorSelectButtonInternal:beginAnimation(200)
				f25_arg0.DirectorSelectButtonInternal.ImageNotFocus:beginAnimation(200)
				f25_arg0.DirectorSelectButtonInternal.ImageFocus:beginAnimation(200)
				f25_arg0.DirectorSelectButtonInternal:setScale(1.05, 1.05)
				f25_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(1)
				f25_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(1)
				f25_arg0.DirectorSelectButtonInternal:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DirectorSelectButtonInternal:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.DirectorSelectButtonInternal:completeAnimation()
			f25_arg0.DirectorSelectButtonInternal.ImageNotFocus:completeAnimation()
			f25_arg0.DirectorSelectButtonInternal.ImageFocus:completeAnimation()
			f25_arg0.DirectorSelectButtonInternal:setScale(1, 1)
			f25_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(0.85)
			f25_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(0)
			f25_local0(f25_arg0.DirectorSelectButtonInternal)
		end,
		LoseChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			local f27_local0 = function(f28_arg0)
				f27_arg0.DirectorSelectButtonInternal:beginAnimation(200)
				f27_arg0.DirectorSelectButtonInternal.ImageNotFocus:beginAnimation(200)
				f27_arg0.DirectorSelectButtonInternal.ImageFocus:beginAnimation(200)
				f27_arg0.DirectorSelectButtonInternal:setScale(1, 1)
				f27_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(0.85)
				f27_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(0)
				f27_arg0.DirectorSelectButtonInternal:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DirectorSelectButtonInternal:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.DirectorSelectButtonInternal:completeAnimation()
			f27_arg0.DirectorSelectButtonInternal.ImageNotFocus:completeAnimation()
			f27_arg0.DirectorSelectButtonInternal.ImageFocus:completeAnimation()
			f27_arg0.DirectorSelectButtonInternal:setScale(1.05, 1.05)
			f27_arg0.DirectorSelectButtonInternal.ImageNotFocus:setAlpha(1)
			f27_arg0.DirectorSelectButtonInternal.ImageFocus:setAlpha(1)
			f27_local0(f27_arg0.DirectorSelectButtonInternal)
		end,
	},
}
CoD.DirectorSelectButton.__onClose = function(f29_arg0)
	f29_arg0.DirectorSelectButtonInternal:close()
end
