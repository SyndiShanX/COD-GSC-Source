require("x64:ade951b2d8c4d9a")
require("x64:f1a14508096b6ce")
CoD.DirectorZMMapSelectItem = InheritFrom(LUI.UIElement)
CoD.DirectorZMMapSelectItem.__defaultWidth = 246
CoD.DirectorZMMapSelectItem.__defaultHeight = 104
CoD.DirectorZMMapSelectItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorZMMapSelectItem)
	self.id = "DirectorZMMapSelectItem"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorZMMapSelectItemInternal = CoD.DirectorZMMapSelectItemInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorZMMapSelectItemInternal.FeaturedTag:setText(LocalizeToUpperString(@"menu/public_tab"))
	DirectorZMMapSelectItemInternal:linkToElementModel(self, nil, false, function(model)
		DirectorZMMapSelectItemInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorZMMapSelectItemInternal)
	self.DirectorZMMapSelectItemInternal = DirectorZMMapSelectItemInternal
	self:mergeStateConditions({
		{
			stateName = "FeaturedTrialsMap",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isFeatured") and CoD.ZombieUtility.TrialsInfo()
			end,
		},
		{
			stateName = "Featured",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isFeatured")
			end,
		},
		{
			stateName = "TrialsMap",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.TrialsInfo()
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
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["ZMLobbyExclusions.ZMPlaylistTab"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "ZMLobbyExclusions.ZMPlaylistTab",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f8_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
	end)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["ZMLobbyExclusions.ZMPlaylistTab"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_2", function(element, menu, controller, model)
		if not IsGamepad(controller) and CoD.ZombieUtility.TrialsInfo() then
			OpenOverlay(self, "DirectorZMTrialsInfo", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsGamepad(controller) and CoD.ZombieUtility.TrialsInfo() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"hash_641F3D5435B98808", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	self:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_641F3D5435B98808", function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		if CoD.ZombieUtility.TrialsInfo() then
			return function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
				OpenOverlay(self, "DirectorZMTrialsInfo", f14_arg2)
			end
		else
		end
	end)
	DirectorZMMapSelectItemInternal.id = "DirectorZMMapSelectItemInternal"
	self.__defaultFocus = DirectorZMMapSelectItemInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local3, f1_arg1, "trialName", "", "")
	end
	return self
end
CoD.DirectorZMMapSelectItem.__resetProperties = function(f15_arg0)
	f15_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
	f15_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
	f15_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(1)
	f15_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(0)
	f15_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(0)
	f15_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(0)
end
CoD.DirectorZMMapSelectItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f17_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.DirectorZMMapSelectItemInternal)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f18_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
				f18_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f18_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
			f18_local0(f18_arg0.DirectorZMMapSelectItemInternal)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f20_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
				f20_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f20_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f20_local0(f20_arg0.DirectorZMMapSelectItemInternal)
		end,
	},
	FeaturedTrialsMap = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f22_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f22_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f22_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f22_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f22_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f22_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f22_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f22_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.DirectorZMMapSelectItemInternal)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f23_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f23_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f23_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f23_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f23_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f23_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f23_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f23_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f23_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.DirectorZMMapSelectItemInternal)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
				f24_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f24_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f24_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f24_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f24_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f24_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
			f24_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f24_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f24_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f24_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f24_local0(f24_arg0.DirectorZMMapSelectItemInternal)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f26_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
				f26_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f26_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f26_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f26_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f26_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f26_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f26_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f26_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f26_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f26_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f26_local0(f26_arg0.DirectorZMMapSelectItemInternal)
		end,
	},
	Featured = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f28_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f28_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f28_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f28_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.DirectorZMMapSelectItemInternal)
		end,
		ChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f29_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f29_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f29_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f29_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f29_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.DirectorZMMapSelectItemInternal)
		end,
		GainChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f30_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
				f30_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f30_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f30_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f30_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
			f30_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f30_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f30_local0(f30_arg0.DirectorZMMapSelectItemInternal)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			local f32_local0 = function(f33_arg0)
				f32_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f32_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
				f32_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f32_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:completeAnimation()
			f32_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:completeAnimation()
			f32_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f32_arg0.DirectorZMMapSelectItemInternal.FeaturedBannerBG:setAlpha(1)
			f32_arg0.DirectorZMMapSelectItemInternal.FeaturedTag:setAlpha(1)
			f32_local0(f32_arg0.DirectorZMMapSelectItemInternal)
		end,
	},
	TrialsMap = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f34_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f34_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f34_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f34_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.DirectorZMMapSelectItemInternal)
		end,
		ChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f35_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f35_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f35_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f35_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f35_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.DirectorZMMapSelectItemInternal)
		end,
		GainChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			local f36_local0 = function(f37_arg0)
				f36_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f36_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
				f36_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f36_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f36_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f36_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
			f36_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f36_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f36_local0(f36_arg0.DirectorZMMapSelectItemInternal)
		end,
		LoseChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			local f38_local0 = function(f39_arg0)
				f38_arg0.DirectorZMMapSelectItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f38_arg0.DirectorZMMapSelectItemInternal:setScale(1, 1)
				f38_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.DirectorZMMapSelectItemInternal:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.DirectorZMMapSelectItemInternal:completeAnimation()
			f38_arg0.DirectorZMMapSelectItemInternal.MapName:completeAnimation()
			f38_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:completeAnimation()
			f38_arg0.DirectorZMMapSelectItemInternal:setScale(1.05, 1.05)
			f38_arg0.DirectorZMMapSelectItemInternal.MapName:setAlpha(0)
			f38_arg0.DirectorZMMapSelectItemInternal.TrialsMapName:setAlpha(1)
			f38_local0(f38_arg0.DirectorZMMapSelectItemInternal)
		end,
	},
}
CoD.DirectorZMMapSelectItem.__onClose = function(f40_arg0)
	f40_arg0.DirectorZMMapSelectItemInternal:close()
end
