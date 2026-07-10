require("x64:1cbc21606fc4149")
CoD.DirectorPlaylistOption = InheritFrom(LUI.UIElement)
CoD.DirectorPlaylistOption.__defaultWidth = 372
CoD.DirectorPlaylistOption.__defaultHeight = 246
CoD.DirectorPlaylistOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPlaylistOption)
	self.id = "DirectorPlaylistOption"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorPlaylistOptionaInternal = CoD.DirectorPlaylistOptionInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 372, 0, 0, 0, 246)
	DirectorPlaylistOptionaInternal.SceneBlur:setAlpha(0)
	DirectorPlaylistOptionaInternal.ImageMask:setAlpha(0)
	DirectorPlaylistOptionaInternal.MiddleText:setText(LocalizeToUpperString(@"hash_A43B10D9DA121A"))
	DirectorPlaylistOptionaInternal:linkToElementModel(self, nil, false, function(model)
		DirectorPlaylistOptionaInternal:setModel(model, f1_arg1)
	end)
	DirectorPlaylistOptionaInternal:linkToElementModel(self, "descriptionText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorPlaylistOptionaInternal.GameModeDescription:setText(f3_local0)
		end
	end)
	self:addElement(DirectorPlaylistOptionaInternal)
	self.DirectorPlaylistOptionaInternal = DirectorPlaylistOptionaInternal
	self:mergeStateConditions({
		{
			stateName = "Featured",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "featured")
			end,
		},
	})
	self:linkToElementModel(self, "featured", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featured",
		})
	end)
	DirectorPlaylistOptionaInternal.id = "DirectorPlaylistOptionaInternal"
	self.__defaultFocus = DirectorPlaylistOptionaInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPlaylistOption.__resetProperties = function(f6_arg0)
	f6_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
	f6_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 246)
	f6_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
	f6_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:setAlpha(0)
	f6_arg0.DirectorPlaylistOptionaInternal.ImageFocus:setAlpha(0)
	f6_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:setAlpha(1)
end
CoD.DirectorPlaylistOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f8_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.DirectorPlaylistOptionaInternal)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200)
				f9_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
				f9_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f9_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
			f9_local0(f9_arg0.DirectorPlaylistOptionaInternal)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200)
				f11_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
				f11_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f11_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f11_local0(f11_arg0.DirectorPlaylistOptionaInternal)
		end,
	},
	Featured = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f13_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:completeAnimation()
			f13_arg0.DirectorPlaylistOptionaInternal.ImageFocus:completeAnimation()
			f13_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:completeAnimation()
			f13_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 512)
			f13_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:setAlpha(1)
			f13_arg0.DirectorPlaylistOptionaInternal.ImageFocus:setAlpha(0.02)
			f13_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DirectorPlaylistOptionaInternal)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f14_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:completeAnimation()
			f14_arg0.DirectorPlaylistOptionaInternal.ImageFocus:completeAnimation()
			f14_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:completeAnimation()
			f14_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 512)
			f14_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f14_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:setAlpha(0)
			f14_arg0.DirectorPlaylistOptionaInternal.ImageFocus:setAlpha(1)
			f14_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.DirectorPlaylistOptionaInternal)
		end,
		GainChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200)
				f15_arg0.DirectorPlaylistOptionaInternal.ImageFocus:beginAnimation(200)
				f15_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
				f15_arg0.DirectorPlaylistOptionaInternal.ImageFocus:setAlpha(1)
				f15_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f15_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:completeAnimation()
			f15_arg0.DirectorPlaylistOptionaInternal.ImageFocus:completeAnimation()
			f15_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:completeAnimation()
			f15_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 512)
			f15_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
			f15_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:setAlpha(1)
			f15_arg0.DirectorPlaylistOptionaInternal.ImageFocus:setAlpha(0)
			f15_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:setAlpha(0)
			f15_local0(f15_arg0.DirectorPlaylistOptionaInternal)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200)
				f17_arg0.DirectorPlaylistOptionaInternal.ImageFocus:beginAnimation(200)
				f17_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
				f17_arg0.DirectorPlaylistOptionaInternal.ImageFocus:setAlpha(0)
				f17_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f17_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:completeAnimation()
			f17_arg0.DirectorPlaylistOptionaInternal.ImageFocus:completeAnimation()
			f17_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:completeAnimation()
			f17_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 512)
			f17_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f17_arg0.DirectorPlaylistOptionaInternal.ImageNotFocus:setAlpha(1)
			f17_arg0.DirectorPlaylistOptionaInternal.ImageFocus:setAlpha(1)
			f17_arg0.DirectorPlaylistOptionaInternal.GamemodeIcon:setAlpha(0)
			f17_local0(f17_arg0.DirectorPlaylistOptionaInternal)
		end,
	},
}
CoD.DirectorPlaylistOption.__onClose = function(f19_arg0)
	f19_arg0.DirectorPlaylistOptionaInternal:close()
end
