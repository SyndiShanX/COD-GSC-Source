require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/sliderbar_editbox")
require("ui/uieditor/widgets/pc/sliderbar_slider")
require("ui/uieditor/widgets/pc/startmenu/listitem")
CoD.SliderBar = InheritFrom(LUI.UIElement)
CoD.SliderBar.__defaultWidth = 810
CoD.SliderBar.__defaultHeight = 64
CoD.SliderBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SliderBar)
	self.id = "SliderBar"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListItem = CoD.ListItem.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ListItem:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
	})
	ListItem:linkToElementModel(ListItem, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(ListItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	ListItem:linkToElementModel(self, nil, false, function(model)
		ListItem:setModel(model, f1_arg1)
	end)
	ListItem:linkToElementModel(self, "name", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ListItem.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(ListItem)
	self.ListItem = ListItem
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 40, 0, 0, 0, 0, 65)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local Slider = CoD.SliderBar_Slider.new(f1_arg0, f1_arg1, 1, 1, -348, -67, 0, 1, 0, 0)
	Slider:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
	})
	Slider:linkToElementModel(Slider, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(Slider, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	Slider:linkToElementModel(self, nil, false, function(model)
		Slider:setModel(model, f1_arg1)
	end)
	self:addElement(Slider)
	self.Slider = Slider
	local EditBox = CoD.SliderBar_EditBox.new(f1_arg0, f1_arg1, 1, 1, -68, 0, 0, 1, 0, 0)
	EditBox:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
	})
	EditBox:linkToElementModel(EditBox, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(EditBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	self:addElement(EditBox)
	self.EditBox = EditBox
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "FadedOut",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.PCWidgetUtility.PrepareSliderBar(self, f1_arg1, f1_arg0, controller, self.Slider)
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f15_local0 = self
		CoD.PCUtility.CallValueUpdateIfExist(self, f1_arg1)
		CoD.PCWidgetUtility.UpdateSliderbarVisuals(self, self.Slider)
	end)
	emptyFocusable.id = "emptyFocusable"
	Slider.id = "Slider"
	EditBox.id = "EditBox"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SliderBar.__resetProperties = function(f16_arg0)
	f16_arg0.ListItem:completeAnimation()
	f16_arg0.Slider:completeAnimation()
	f16_arg0.EditBox:completeAnimation()
	f16_arg0.ListItem:setAlpha(1)
	f16_arg0.Slider:setAlpha(1)
	f16_arg0.Slider.FilledPart:setAlpha(0.02)
	f16_arg0.EditBox:setAlpha(1)
end
CoD.SliderBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ListItem:completeAnimation()
			f17_arg0.ListItem:playClip("DefaultClip")
			f17_arg0.clipFinished(f17_arg0.ListItem)
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.ListItem:completeAnimation()
			f18_arg0.ListItem:playClip("cFocus")
			f18_arg0.clipFinished(f18_arg0.ListItem)
			f18_arg0.Slider:completeAnimation()
			f18_arg0.Slider.FilledPart:completeAnimation()
			f18_arg0.Slider.FilledPart:setAlpha(0.04)
			f18_arg0.clipFinished(f18_arg0.Slider)
		end,
		Active = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.ListItem:completeAnimation()
			f19_arg0.ListItem:playClip("cActive")
			f19_arg0.clipFinished(f19_arg0.ListItem)
			local f19_local0 = function(f20_arg0)
				f19_arg0.Slider:beginAnimation(150)
				f19_arg0.Slider.FilledPart:beginAnimation(150)
				f19_arg0.Slider.FilledPart:setAlpha(0.06)
				f19_arg0.Slider:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Slider:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.Slider:completeAnimation()
			f19_arg0.Slider.FilledPart:completeAnimation()
			f19_arg0.Slider.FilledPart:setAlpha(0.04)
			f19_local0(f19_arg0.Slider)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.ListItem:playClip("cLoseFocus")
				f21_arg0.ListItem:beginAnimation(150)
				f21_arg0.ListItem:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f21_arg0.clipFinished(element, event)
				end)
			end
			f21_arg0.ListItem:completeAnimation()
			f21_arg0.ListItem:setAlpha(1)
			f21_local0(f21_arg0.ListItem)
			local f21_local1 = function(f24_arg0)
				f21_arg0.Slider:beginAnimation(150)
				f21_arg0.Slider.FilledPart:beginAnimation(150)
				f21_arg0.Slider.FilledPart:setAlpha(0.02)
				f21_arg0.Slider:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Slider:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Slider:completeAnimation()
			f21_arg0.Slider.FilledPart:completeAnimation()
			f21_arg0.Slider.FilledPart:setAlpha(0.04)
			f21_local1(f21_arg0.Slider)
		end,
		GainChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.ListItem:playClip("cGainFocus")
				f25_arg0.ListItem:beginAnimation(150)
				f25_arg0.ListItem:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f25_arg0.clipFinished(element, event)
				end)
			end
			f25_arg0.ListItem:completeAnimation()
			f25_arg0.ListItem:setAlpha(1)
			f25_local0(f25_arg0.ListItem)
			local f25_local1 = function(f28_arg0)
				f25_arg0.Slider:beginAnimation(150)
				f25_arg0.Slider.FilledPart:beginAnimation(150)
				f25_arg0.Slider.FilledPart:setAlpha(0.04)
				f25_arg0.Slider:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Slider:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.Slider:completeAnimation()
			f25_arg0.Slider.FilledPart:completeAnimation()
			f25_arg0.Slider.FilledPart:setAlpha(0.02)
			f25_local1(f25_arg0.Slider)
		end,
		LoseActive = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.ListItem:completeAnimation()
			f29_arg0.ListItem:playClip("cLoseActive")
			f29_arg0.clipFinished(f29_arg0.ListItem)
			local f29_local0 = function(f30_arg0)
				f29_arg0.Slider:beginAnimation(150)
				f29_arg0.Slider.FilledPart:beginAnimation(150)
				f29_arg0.Slider.FilledPart:setAlpha(0.02)
				f29_arg0.Slider:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.Slider:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.Slider:completeAnimation()
			f29_arg0.Slider.FilledPart:completeAnimation()
			f29_arg0.Slider.FilledPart:setAlpha(0.04)
			f29_local0(f29_arg0.Slider)
		end,
		GainActiveAndChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.ListItem:completeAnimation()
			f31_arg0.ListItem:playClip("cGainActiveAndFocus")
			f31_arg0.clipFinished(f31_arg0.ListItem)
			local f31_local0 = function(f32_arg0)
				f31_arg0.Slider:beginAnimation(150)
				f31_arg0.Slider.FilledPart:beginAnimation(150)
				f31_arg0.Slider.FilledPart:setAlpha(0.06)
				f31_arg0.Slider:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Slider:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.Slider:completeAnimation()
			f31_arg0.Slider.FilledPart:completeAnimation()
			f31_arg0.Slider.FilledPart:setAlpha(0.02)
			f31_local0(f31_arg0.Slider)
		end,
		ActiveToActiveAndChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.ListItem:completeAnimation()
			f33_arg0.ListItem:playClip("cActiveToActiveAndFocus")
			f33_arg0.clipFinished(f33_arg0.ListItem)
			local f33_local0 = function(f34_arg0)
				f33_arg0.Slider:beginAnimation(150)
				f33_arg0.Slider.FilledPart:beginAnimation(150)
				f33_arg0.Slider.FilledPart:setAlpha(0.06)
				f33_arg0.Slider:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Slider:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Slider:completeAnimation()
			f33_arg0.Slider.FilledPart:completeAnimation()
			f33_arg0.Slider.FilledPart:setAlpha(0.04)
			f33_local0(f33_arg0.Slider)
		end,
		ActiveAndChildFocusToActive = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.ListItem:completeAnimation()
			f35_arg0.ListItem:playClip("cActiveAndFocusToActive")
			f35_arg0.clipFinished(f35_arg0.ListItem)
			local f35_local0 = function(f36_arg0)
				f35_arg0.Slider:beginAnimation(150)
				f35_arg0.Slider.FilledPart:beginAnimation(150)
				f35_arg0.Slider.FilledPart:setAlpha(0.04)
				f35_arg0.Slider:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Slider:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Slider:completeAnimation()
			f35_arg0.Slider.FilledPart:completeAnimation()
			f35_arg0.Slider.FilledPart:setAlpha(0.06)
			f35_local0(f35_arg0.Slider)
		end,
		ActiveAndChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			f37_arg0.ListItem:completeAnimation()
			f37_arg0.ListItem:playClip("cActiveAndFocus")
			f37_arg0.clipFinished(f37_arg0.ListItem)
			local f37_local0 = function(f38_arg0)
				f37_arg0.Slider:beginAnimation(150)
				f37_arg0.Slider.FilledPart:beginAnimation(150)
				f37_arg0.Slider.FilledPart:setAlpha(0.06)
				f37_arg0.Slider:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Slider:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.Slider:completeAnimation()
			f37_arg0.Slider.FilledPart:completeAnimation()
			f37_arg0.Slider.FilledPart:setAlpha(0.04)
			f37_local0(f37_arg0.Slider)
		end,
	},
	Unavailable = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(3)
			f39_arg0.ListItem:completeAnimation()
			f39_arg0.ListItem:playClip("DefaultClip")
			f39_arg0.clipFinished(f39_arg0.ListItem)
			f39_arg0.Slider:completeAnimation()
			f39_arg0.Slider:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.Slider)
			f39_arg0.EditBox:completeAnimation()
			f39_arg0.EditBox:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.EditBox)
		end,
		Active = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(3)
			f40_arg0.ListItem:completeAnimation()
			f40_arg0.ListItem:playClip("dActive")
			f40_arg0.clipFinished(f40_arg0.ListItem)
			f40_arg0.Slider:completeAnimation()
			f40_arg0.Slider:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.Slider)
			f40_arg0.EditBox:completeAnimation()
			f40_arg0.EditBox:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.EditBox)
		end,
		ChildFocus = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(3)
			f41_arg0.ListItem:completeAnimation()
			f41_arg0.ListItem:playClip("dFocus")
			f41_arg0.clipFinished(f41_arg0.ListItem)
			f41_arg0.Slider:completeAnimation()
			f41_arg0.Slider:setAlpha(0.2)
			f41_arg0.clipFinished(f41_arg0.Slider)
			f41_arg0.EditBox:completeAnimation()
			f41_arg0.EditBox:setAlpha(0.2)
			f41_arg0.clipFinished(f41_arg0.EditBox)
		end,
		GainChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(3)
			local f42_local0 = function(f43_arg0)
				f42_arg0.ListItem:playClip("dGainFocus")
				f42_arg0.ListItem:beginAnimation(150)
				f42_arg0.ListItem:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dGainFocus")
					f42_arg0.clipFinished(element, event)
				end)
			end
			f42_arg0.ListItem:completeAnimation()
			f42_arg0.ListItem:setAlpha(1)
			f42_local0(f42_arg0.ListItem)
			f42_arg0.Slider:completeAnimation()
			f42_arg0.Slider:setAlpha(0.2)
			f42_arg0.clipFinished(f42_arg0.Slider)
			f42_arg0.EditBox:completeAnimation()
			f42_arg0.EditBox:setAlpha(0.2)
			f42_arg0.clipFinished(f42_arg0.EditBox)
		end,
		LoseChildFocus = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(3)
			local f45_local0 = function(f46_arg0)
				f45_arg0.ListItem:playClip("dLoseFocus")
				f45_arg0.ListItem:beginAnimation(150)
				f45_arg0.ListItem:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dLoseFocus")
					f45_arg0.clipFinished(element, event)
				end)
			end
			f45_arg0.ListItem:completeAnimation()
			f45_arg0.ListItem:setAlpha(1)
			f45_local0(f45_arg0.ListItem)
			f45_arg0.Slider:completeAnimation()
			f45_arg0.Slider:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.Slider)
			f45_arg0.EditBox:completeAnimation()
			f45_arg0.EditBox:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.EditBox)
		end,
		ActiveAndChildFocus = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(3)
			f48_arg0.ListItem:completeAnimation()
			f48_arg0.ListItem:playClip("dActiveAndFocus")
			f48_arg0.clipFinished(f48_arg0.ListItem)
			f48_arg0.Slider:completeAnimation()
			f48_arg0.Slider:setAlpha(0.2)
			f48_arg0.clipFinished(f48_arg0.Slider)
			f48_arg0.EditBox:completeAnimation()
			f48_arg0.EditBox:setAlpha(0.2)
			f48_arg0.clipFinished(f48_arg0.EditBox)
		end,
		LoseActive = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			f49_arg0.ListItem:completeAnimation()
			f49_arg0.ListItem:playClip("dLoseActive")
			f49_arg0.clipFinished(f49_arg0.ListItem)
			local f49_local0 = function(f50_arg0)
				f49_arg0.Slider:beginAnimation(150)
				f49_arg0.Slider:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.Slider:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.Slider:completeAnimation()
			f49_arg0.Slider:setAlpha(0.2)
			f49_local0(f49_arg0.Slider)
			local f49_local1 = function(f51_arg0)
				f49_arg0.EditBox:beginAnimation(150)
				f49_arg0.EditBox:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.EditBox:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.EditBox:completeAnimation()
			f49_arg0.EditBox:setAlpha(0.2)
			f49_local1(f49_arg0.EditBox)
		end,
		GainActiveAndChildFocus = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(3)
			f52_arg0.ListItem:completeAnimation()
			f52_arg0.ListItem:playClip("dGainActiveAndFocus")
			f52_arg0.clipFinished(f52_arg0.ListItem)
			local f52_local0 = function(f53_arg0)
				f52_arg0.Slider:beginAnimation(150)
				f52_arg0.Slider:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.Slider:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.Slider:completeAnimation()
			f52_arg0.Slider:setAlpha(0.2)
			f52_local0(f52_arg0.Slider)
			local f52_local1 = function(f54_arg0)
				f52_arg0.EditBox:beginAnimation(150)
				f52_arg0.EditBox:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.EditBox:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.EditBox:completeAnimation()
			f52_arg0.EditBox:setAlpha(0.2)
			f52_local1(f52_arg0.EditBox)
		end,
		ActiveAndChildFocusToActive = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(3)
			f55_arg0.ListItem:completeAnimation()
			f55_arg0.ListItem:playClip("dActiveAndFocusToActive")
			f55_arg0.clipFinished(f55_arg0.ListItem)
			f55_arg0.Slider:completeAnimation()
			f55_arg0.Slider:setAlpha(0.2)
			f55_arg0.clipFinished(f55_arg0.Slider)
			f55_arg0.EditBox:completeAnimation()
			f55_arg0.EditBox:setAlpha(0.2)
			f55_arg0.clipFinished(f55_arg0.EditBox)
		end,
		ActiveToActiveAndChildFocus = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(3)
			f56_arg0.ListItem:completeAnimation()
			f56_arg0.ListItem:playClip("dActiveToActiveAndFocus")
			f56_arg0.clipFinished(f56_arg0.ListItem)
			f56_arg0.Slider:completeAnimation()
			f56_arg0.Slider:setAlpha(0.2)
			f56_arg0.clipFinished(f56_arg0.Slider)
			f56_arg0.EditBox:completeAnimation()
			f56_arg0.EditBox:setAlpha(0.2)
			f56_arg0.clipFinished(f56_arg0.EditBox)
		end,
	},
	FadedOut = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(3)
			f57_arg0.ListItem:completeAnimation()
			f57_arg0.ListItem:setAlpha(0.3)
			f57_arg0.clipFinished(f57_arg0.ListItem)
			f57_arg0.Slider:completeAnimation()
			f57_arg0.Slider:setAlpha(0.3)
			f57_arg0.clipFinished(f57_arg0.Slider)
			f57_arg0.EditBox:completeAnimation()
			f57_arg0.EditBox:setAlpha(0.3)
			f57_arg0.clipFinished(f57_arg0.EditBox)
		end,
	},
}
CoD.SliderBar.__onClose = function(f58_arg0)
	f58_arg0.ListItem:close()
	f58_arg0.emptyFocusable:close()
	f58_arg0.Slider:close()
	f58_arg0.EditBox:close()
end
