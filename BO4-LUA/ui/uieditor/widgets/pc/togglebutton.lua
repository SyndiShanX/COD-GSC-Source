require("x64:2675595fa323085")
require("x64:1ba14a6a952408f")
require("x64:55b10f9afc8df1d")
CoD.ToggleButton = InheritFrom(LUI.UIElement)
CoD.ToggleButton.__defaultWidth = 810
CoD.ToggleButton.__defaultHeight = 65
CoD.ToggleButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ToggleButton)
	self.id = "ToggleButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListItem = CoD.ListItem.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 65)
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
			ListItem.Title:setText(Engine[0xF9F1239CFD921FE](f5_local0))
		end
	end)
	self:addElement(ListItem)
	self.ListItem = ListItem
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 40, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local On = CoD.ToggleButton_Button.new(f1_arg0, f1_arg1, 1, 1, -347, -173, 0, 1, 0, 0)
	On:mergeStateConditions({
		{
			stateName = "UnavailableToggled",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1) and CoD.PCWidgetUtility.IsToggled(self, event)
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "Toggled",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.IsToggled(self, event)
			end,
		},
	})
	On:linkToElementModel(On, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(On, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	On:linkToElementModel(On, "currentValue", true, function(model)
		f1_arg0:updateElementState(On, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "currentValue",
		})
	end)
	On.On.__On_String_Reference = function()
		On.On:setText(LocalizeToUpperString(CoD.PCWidgetUtility.SetToggleString(self, "toggleOnString", 0x439156E8D96D245)))
	end
	On.On.__On_String_Reference()
	On:linkToElementModel(self, nil, false, function(model)
		On:setModel(model, f1_arg1)
	end)
	self:addElement(On)
	self.On = On
	local Off = CoD.ToggleButton_Button.new(f1_arg0, f1_arg1, 1, 1, -174, 0, 0, 1, 0, 0)
	Off:mergeStateConditions({
		{
			stateName = "UnavailableToggled",
			condition = function(menu, element, event)
				local f13_local0
				if not CoD.PCWidgetUtility.IsToggled(self, event) then
					f13_local0 = CoD.PCUtility.IsUnavailable(self, f1_arg1)
				else
					f13_local0 = false
				end
				return f13_local0
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "Toggled",
			condition = function(menu, element, event)
				return not CoD.PCWidgetUtility.IsToggled(self, event)
			end,
		},
	})
	Off:linkToElementModel(Off, "currentValue", true, function(model)
		f1_arg0:updateElementState(Off, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "currentValue",
		})
	end)
	Off:linkToElementModel(Off, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(Off, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	Off.On.__On_String_Reference = function()
		Off.On:setText(LocalizeToUpperString(CoD.PCWidgetUtility.SetToggleString(self, "toggleOffString", 0x3ECBDDA975E2AC1)))
	end
	Off.On.__On_String_Reference()
	Off:linkToElementModel(self, nil, false, function(model)
		Off:setModel(model, f1_arg1)
	end)
	self:addElement(Off)
	self.Off = Off
	On:linkToElementModel(self, "toggleOnString", true, On.On.__On_String_Reference)
	On:linkToElementModel(self, "toggleOffString", true, On.On.__On_String_Reference)
	Off:linkToElementModel(self, "toggleOnString", true, Off.On.__On_String_Reference)
	Off:linkToElementModel(self, "toggleOffString", true, Off.On.__On_String_Reference)
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
		CoD.PCWidgetUtility.PrepareYesNoToggleButton(self, self.On, self.Off, f1_arg1, f1_arg0, controller)
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f24_local0 = self
		CoD.PCUtility.CallValueUpdateIfExist(self, f1_arg1)
	end)
	emptyFocusable.id = "emptyFocusable"
	On.id = "On"
	Off.id = "Off"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	SetElementProperty(self.On, "_isLeft", true)
	SetElementProperty(self.Off, "_isRight", true)
	UpdateElementState(self, "On", f1_arg1)
	UpdateElementState(self, "Off", f1_arg1)
	return self
end
CoD.ToggleButton.__resetProperties = function(f25_arg0)
	f25_arg0.ListItem:completeAnimation()
	f25_arg0.On:completeAnimation()
	f25_arg0.emptyFocusable:completeAnimation()
	f25_arg0.Off:completeAnimation()
	f25_arg0.ListItem:setAlpha(1)
	f25_arg0.On:setAlpha(1)
	f25_arg0.emptyFocusable:setAlpha(1)
	f25_arg0.Off:setAlpha(1)
end
CoD.ToggleButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.ListItem:completeAnimation()
			f26_arg0.ListItem:playClip("DefaultClip")
			f26_arg0.clipFinished(f26_arg0.ListItem)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.ListItem:completeAnimation()
			f27_arg0.ListItem:playClip("cFocus")
			f27_arg0.clipFinished(f27_arg0.ListItem)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.ListItem:playClip("cGainFocus")
				f28_arg0.ListItem:beginAnimation(150)
				f28_arg0.ListItem:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f28_arg0.clipFinished(element, event)
				end)
			end
			f28_arg0.ListItem:completeAnimation()
			f28_arg0.ListItem:setAlpha(1)
			f28_local0(f28_arg0.ListItem)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ListItem:playClip("cLoseFocus")
				f31_arg0.ListItem:beginAnimation(150)
				f31_arg0.ListItem:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f31_arg0.clipFinished(element, event)
				end)
			end
			f31_arg0.ListItem:completeAnimation()
			f31_arg0.ListItem:setAlpha(1)
			f31_local0(f31_arg0.ListItem)
		end,
		Active = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.ListItem:completeAnimation()
			f34_arg0.ListItem:playClip("cActive")
			f34_arg0.clipFinished(f34_arg0.ListItem)
		end,
		LoseActive = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.ListItem:completeAnimation()
			f35_arg0.ListItem:playClip("cLoseActive")
			f35_arg0.clipFinished(f35_arg0.ListItem)
			local f35_local0 = function(f36_arg0)
				f35_arg0.On:beginAnimation(150)
				f35_arg0.On:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.On:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.On:completeAnimation()
			f35_arg0.On:setAlpha(1)
			f35_local0(f35_arg0.On)
		end,
		ActiveAndChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.ListItem:completeAnimation()
			f37_arg0.ListItem:playClip("cActiveAndFocus")
			f37_arg0.clipFinished(f37_arg0.ListItem)
		end,
		ActiveAndChildFocusToActive = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.ListItem:completeAnimation()
			f38_arg0.ListItem:playClip("cActiveAndFocusToActive")
			f38_arg0.clipFinished(f38_arg0.ListItem)
		end,
		ActiveToActiveAndChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			f39_arg0.ListItem:completeAnimation()
			f39_arg0.ListItem:playClip("cActiveToActiveAndFocus")
			f39_arg0.clipFinished(f39_arg0.ListItem)
		end,
		GainActiveAndChildFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.ListItem:completeAnimation()
			f40_arg0.ListItem:playClip("cGainActiveAndFocus")
			f40_arg0.clipFinished(f40_arg0.ListItem)
			local f40_local0 = function(f41_arg0)
				f40_arg0.emptyFocusable:beginAnimation(150)
				f40_arg0.emptyFocusable:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.emptyFocusable:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.emptyFocusable:completeAnimation()
			f40_arg0.emptyFocusable:setAlpha(1)
			f40_local0(f40_arg0.emptyFocusable)
		end,
	},
	Unavailable = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(3)
			f42_arg0.ListItem:completeAnimation()
			f42_arg0.ListItem:playClip("DefaultClip")
			f42_arg0.clipFinished(f42_arg0.ListItem)
			f42_arg0.On:completeAnimation()
			f42_arg0.On:setAlpha(0.2)
			f42_arg0.clipFinished(f42_arg0.On)
			f42_arg0.Off:completeAnimation()
			f42_arg0.Off:setAlpha(0.2)
			f42_arg0.clipFinished(f42_arg0.Off)
		end,
		ChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(3)
			f43_arg0.ListItem:completeAnimation()
			f43_arg0.ListItem:playClip("dFocus")
			f43_arg0.clipFinished(f43_arg0.ListItem)
			f43_arg0.On:completeAnimation()
			f43_arg0.On:setAlpha(0.2)
			f43_arg0.clipFinished(f43_arg0.On)
			f43_arg0.Off:completeAnimation()
			f43_arg0.Off:setAlpha(0.2)
			f43_arg0.clipFinished(f43_arg0.Off)
		end,
		Active = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.ListItem:completeAnimation()
			f44_arg0.ListItem:playClip("dActive")
			f44_arg0.clipFinished(f44_arg0.ListItem)
			f44_arg0.On:completeAnimation()
			f44_arg0.On:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.On)
			f44_arg0.Off:completeAnimation()
			f44_arg0.Off:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.Off)
		end,
		GainChildFocus = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(3)
			local f45_local0 = function(f46_arg0)
				f45_arg0.ListItem:playClip("dGainFocus")
				f45_arg0.ListItem:beginAnimation(150)
				f45_arg0.ListItem:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dGainFocus")
					f45_arg0.clipFinished(element, event)
				end)
			end
			f45_arg0.ListItem:completeAnimation()
			f45_arg0.ListItem:setAlpha(1)
			f45_local0(f45_arg0.ListItem)
			f45_arg0.On:completeAnimation()
			f45_arg0.On:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.On)
			f45_arg0.Off:completeAnimation()
			f45_arg0.Off:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.Off)
		end,
		LoseChildFocus = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(3)
			local f48_local0 = function(f49_arg0)
				f48_arg0.ListItem:playClip("dLoseFocus")
				f48_arg0.ListItem:beginAnimation(150)
				f48_arg0.ListItem:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dLoseFocus")
					f48_arg0.clipFinished(element, event)
				end)
			end
			f48_arg0.ListItem:completeAnimation()
			f48_arg0.ListItem:setAlpha(1)
			f48_local0(f48_arg0.ListItem)
			f48_arg0.On:completeAnimation()
			f48_arg0.On:setAlpha(0.2)
			f48_arg0.clipFinished(f48_arg0.On)
			f48_arg0.Off:completeAnimation()
			f48_arg0.Off:setAlpha(0.2)
			f48_arg0.clipFinished(f48_arg0.Off)
		end,
		ActiveAndChildFocus = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(3)
			f51_arg0.ListItem:completeAnimation()
			f51_arg0.ListItem:playClip("dActiveAndFocus")
			f51_arg0.clipFinished(f51_arg0.ListItem)
			f51_arg0.On:completeAnimation()
			f51_arg0.On:setAlpha(0.2)
			f51_arg0.clipFinished(f51_arg0.On)
			f51_arg0.Off:completeAnimation()
			f51_arg0.Off:setAlpha(0.2)
			f51_arg0.clipFinished(f51_arg0.Off)
		end,
		LoseActive = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(3)
			f52_arg0.ListItem:completeAnimation()
			f52_arg0.ListItem:playClip("dLoseActive")
			f52_arg0.clipFinished(f52_arg0.ListItem)
			local f52_local0 = function(f53_arg0)
				f52_arg0.On:beginAnimation(150)
				f52_arg0.On:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.On:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.On:completeAnimation()
			f52_arg0.On:setAlpha(0.2)
			f52_local0(f52_arg0.On)
			local f52_local1 = function(f54_arg0)
				f52_arg0.Off:beginAnimation(150)
				f52_arg0.Off:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.Off:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.Off:completeAnimation()
			f52_arg0.Off:setAlpha(0.2)
			f52_local1(f52_arg0.Off)
		end,
		GainActiveAndChildFocus = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(3)
			f55_arg0.ListItem:completeAnimation()
			f55_arg0.ListItem:playClip("dGainActiveAndFocus")
			f55_arg0.clipFinished(f55_arg0.ListItem)
			local f55_local0 = function(f56_arg0)
				f55_arg0.On:beginAnimation(150)
				f55_arg0.On:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.On:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.On:completeAnimation()
			f55_arg0.On:setAlpha(0.2)
			f55_local0(f55_arg0.On)
			local f55_local1 = function(f57_arg0)
				f55_arg0.Off:beginAnimation(150)
				f55_arg0.Off:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.Off:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.Off:completeAnimation()
			f55_arg0.Off:setAlpha(0.2)
			f55_local1(f55_arg0.Off)
		end,
		ActiveAndChildFocusToActive = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(3)
			f58_arg0.ListItem:completeAnimation()
			f58_arg0.ListItem:playClip("dActiveAndFocusToActive")
			f58_arg0.clipFinished(f58_arg0.ListItem)
			f58_arg0.On:completeAnimation()
			f58_arg0.On:setAlpha(0.2)
			f58_arg0.clipFinished(f58_arg0.On)
			f58_arg0.Off:completeAnimation()
			f58_arg0.Off:setAlpha(0.2)
			f58_arg0.clipFinished(f58_arg0.Off)
		end,
		ActiveToActiveAndChildFocus = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(3)
			f59_arg0.ListItem:completeAnimation()
			f59_arg0.ListItem:playClip("dActiveToActiveAndFocus")
			f59_arg0.clipFinished(f59_arg0.ListItem)
			f59_arg0.On:completeAnimation()
			f59_arg0.On:setAlpha(0.2)
			f59_arg0.clipFinished(f59_arg0.On)
			f59_arg0.Off:completeAnimation()
			f59_arg0.Off:setAlpha(0.2)
			f59_arg0.clipFinished(f59_arg0.Off)
		end,
	},
	FadedOut = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(3)
			f60_arg0.ListItem:completeAnimation()
			f60_arg0.ListItem:setAlpha(0.3)
			f60_arg0.clipFinished(f60_arg0.ListItem)
			f60_arg0.On:completeAnimation()
			f60_arg0.On:setAlpha(0.3)
			f60_arg0.clipFinished(f60_arg0.On)
			f60_arg0.Off:completeAnimation()
			f60_arg0.Off:setAlpha(0.3)
			f60_arg0.clipFinished(f60_arg0.Off)
		end,
	},
}
CoD.ToggleButton.__onClose = function(f61_arg0)
	f61_arg0.ListItem:close()
	f61_arg0.emptyFocusable:close()
	f61_arg0.On:close()
	f61_arg0.Off:close()
end
