require("x64:2675595fa323085")
require("x64:7d2086e818e7f81")
require("x64:1ba14a6a952408f")
CoD.OpenButton = InheritFrom(LUI.UIElement)
CoD.OpenButton.__defaultWidth = 810
CoD.OpenButton.__defaultHeight = 65
CoD.OpenButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OpenButton)
	self.id = "OpenButton"
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
	ListItem:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ListItem.Title:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(ListItem)
	self.ListItem = ListItem
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 40, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local Button = CoD.OpenButton_Button.new(f1_arg0, f1_arg1, 1, 1, -348, 0, 0.5, 0.5, -32.5, 32.5)
	Button:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
	})
	Button:linkToElementModel(Button, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	Button.Text:setText(LocalizeToUpperString(0x68F4DC4AFAA11C3))
	self:addElement(Button)
	self.Button = Button
	self.Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
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
		CoD.PCWidgetUtility.PrepareOpenButton(self, self.Button, f1_arg1, f1_arg0, controller)
	end)
	emptyFocusable.id = "emptyFocusable"
	Button.id = "Button"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OpenButton.__resetProperties = function(f12_arg0)
	f12_arg0.ListItem:completeAnimation()
	f12_arg0.Button:completeAnimation()
	f12_arg0.ListItem:setAlpha(1)
	f12_arg0.Button:setAlpha(1)
end
CoD.OpenButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.ListItem:completeAnimation()
			f13_arg0.ListItem:playClip("DefaultClip")
			f13_arg0.clipFinished(f13_arg0.ListItem)
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.ListItem:completeAnimation()
			f14_arg0.ListItem:playClip("cActive")
			f14_arg0.clipFinished(f14_arg0.ListItem)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.ListItem:completeAnimation()
			f15_arg0.ListItem:playClip("cFocus")
			f15_arg0.clipFinished(f15_arg0.ListItem)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.ListItem:playClip("cLoseFocus")
				f16_arg0.ListItem:beginAnimation(150)
				f16_arg0.ListItem:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f16_arg0.clipFinished(element, event)
				end)
			end
			f16_arg0.ListItem:completeAnimation()
			f16_arg0.ListItem:setAlpha(1)
			f16_local0(f16_arg0.ListItem)
		end,
		GainChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ListItem:playClip("cGainFocus")
				f19_arg0.ListItem:beginAnimation(150)
				f19_arg0.ListItem:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f19_arg0.clipFinished(element, event)
				end)
			end
			f19_arg0.ListItem:completeAnimation()
			f19_arg0.ListItem:setAlpha(1)
			f19_local0(f19_arg0.ListItem)
		end,
		LoseActive = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.ListItem:completeAnimation()
			f22_arg0.ListItem:playClip("cLoseActive")
			f22_arg0.clipFinished(f22_arg0.ListItem)
			local f22_local0 = function(f23_arg0)
				f22_arg0.Button:beginAnimation(150)
				f22_arg0.Button:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Button:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Button:completeAnimation()
			f22_arg0.Button:setAlpha(1)
			f22_local0(f22_arg0.Button)
		end,
		ActiveAndChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.ListItem:completeAnimation()
			f24_arg0.ListItem:playClip("cActiveAndFocus")
			f24_arg0.clipFinished(f24_arg0.ListItem)
		end,
		ActiveAndChildFocusToActive = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.ListItem:completeAnimation()
			f25_arg0.ListItem:playClip("cActiveAndFocusToActive")
			f25_arg0.clipFinished(f25_arg0.ListItem)
		end,
		ActiveToActiveAndChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.ListItem:completeAnimation()
			f26_arg0.ListItem:playClip("cActiveToActiveAndFocus")
			f26_arg0.clipFinished(f26_arg0.ListItem)
			local f26_local0 = function(f27_arg0)
				f26_arg0.Button:beginAnimation(150)
				f26_arg0.Button:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Button:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Button:completeAnimation()
			f26_arg0.Button:setAlpha(1)
			f26_local0(f26_arg0.Button)
		end,
		GainActiveAndChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.ListItem:completeAnimation()
			f28_arg0.ListItem:playClip("cGainActiveAndFocus")
			f28_arg0.clipFinished(f28_arg0.ListItem)
			local f28_local0 = function(f29_arg0)
				f28_arg0.Button:beginAnimation(150)
				f28_arg0.Button:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Button:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.Button:completeAnimation()
			f28_arg0.Button:setAlpha(1)
			f28_local0(f28_arg0.Button)
		end,
	},
	Unavailable = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.ListItem:completeAnimation()
			f30_arg0.ListItem:playClip("DefaultClip")
			f30_arg0.clipFinished(f30_arg0.ListItem)
			f30_arg0.Button:completeAnimation()
			f30_arg0.Button:setAlpha(0.2)
			f30_arg0.clipFinished(f30_arg0.Button)
		end,
		ChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.ListItem:completeAnimation()
			f31_arg0.ListItem:playClip("dFocus")
			f31_arg0.clipFinished(f31_arg0.ListItem)
			f31_arg0.Button:completeAnimation()
			f31_arg0.Button:setAlpha(0.2)
			f31_arg0.clipFinished(f31_arg0.Button)
		end,
		Active = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.ListItem:completeAnimation()
			f32_arg0.ListItem:playClip("dActive")
			f32_arg0.clipFinished(f32_arg0.ListItem)
			f32_arg0.Button:completeAnimation()
			f32_arg0.Button:setAlpha(0.2)
			f32_arg0.clipFinished(f32_arg0.Button)
		end,
		GainChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			local f33_local0 = function(f34_arg0)
				f33_arg0.ListItem:playClip("dGainFocus")
				f33_arg0.ListItem:beginAnimation(150)
				f33_arg0.ListItem:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dGainFocus")
					f33_arg0.clipFinished(element, event)
				end)
			end
			f33_arg0.ListItem:completeAnimation()
			f33_arg0.ListItem:setAlpha(1)
			f33_local0(f33_arg0.ListItem)
			f33_arg0.Button:completeAnimation()
			f33_arg0.Button:setAlpha(0.2)
			f33_arg0.clipFinished(f33_arg0.Button)
		end,
		LoseChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			local f36_local0 = function(f37_arg0)
				f36_arg0.ListItem:playClip("dLoseFocus")
				f36_arg0.ListItem:beginAnimation(150)
				f36_arg0.ListItem:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dLoseFocus")
					f36_arg0.clipFinished(element, event)
				end)
			end
			f36_arg0.ListItem:completeAnimation()
			f36_arg0.ListItem:setAlpha(1)
			f36_local0(f36_arg0.ListItem)
			f36_arg0.Button:completeAnimation()
			f36_arg0.Button:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.Button)
		end,
		ActiveAndChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.ListItem:completeAnimation()
			f39_arg0.ListItem:playClip("dActiveAndFocus")
			f39_arg0.clipFinished(f39_arg0.ListItem)
			f39_arg0.Button:completeAnimation()
			f39_arg0.Button:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.Button)
		end,
		GainActiveAndChildFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.ListItem:completeAnimation()
			f40_arg0.ListItem:playClip("dGainActiveAndFocus")
			f40_arg0.clipFinished(f40_arg0.ListItem)
			local f40_local0 = function(f41_arg0)
				f40_arg0.Button:beginAnimation(150)
				f40_arg0.Button:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.Button:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.Button:completeAnimation()
			f40_arg0.Button:setAlpha(0.2)
			f40_local0(f40_arg0.Button)
		end,
		LoseActive = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.ListItem:completeAnimation()
			f42_arg0.ListItem:playClip("dLoseActive")
			f42_arg0.clipFinished(f42_arg0.ListItem)
			local f42_local0 = function(f43_arg0)
				f42_arg0.Button:beginAnimation(150)
				f42_arg0.Button:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.Button:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.Button:completeAnimation()
			f42_arg0.Button:setAlpha(0.2)
			f42_local0(f42_arg0.Button)
		end,
		ActiveToActiveAndChildFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			f44_arg0.ListItem:completeAnimation()
			f44_arg0.ListItem:playClip("dActiveToActiveAndFocus")
			f44_arg0.clipFinished(f44_arg0.ListItem)
			f44_arg0.Button:completeAnimation()
			f44_arg0.Button:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.Button)
		end,
		ActiveAndChildFocusToActive = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			f45_arg0.ListItem:completeAnimation()
			f45_arg0.ListItem:playClip("dActiveAndFocusToActive")
			f45_arg0.clipFinished(f45_arg0.ListItem)
			f45_arg0.Button:completeAnimation()
			f45_arg0.Button:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.Button)
		end,
	},
	FadedOut = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(2)
			f46_arg0.ListItem:completeAnimation()
			f46_arg0.ListItem:setAlpha(0.3)
			f46_arg0.clipFinished(f46_arg0.ListItem)
			f46_arg0.Button:completeAnimation()
			f46_arg0.Button:setAlpha(0.3)
			f46_arg0.clipFinished(f46_arg0.Button)
		end,
	},
}
CoD.OpenButton.__onClose = function(f47_arg0)
	f47_arg0.ListItem:close()
	f47_arg0.emptyFocusable:close()
	f47_arg0.Button:close()
end
