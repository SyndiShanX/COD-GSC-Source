require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/dropdownlist_itemcontrol")
require("ui/uieditor/widgets/pc/startmenu/listitem")
CoD.DropDownList = InheritFrom(LUI.UIElement)
CoD.DropDownList.__defaultWidth = 810
CoD.DropDownList.__defaultHeight = 65
CoD.DropDownList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DropDownList)
	self.id = "DropDownList"
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
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 40, 0, 0, 1, 0, 0)
	emptyFocusable:linkToElementModel(emptyFocusable, "refreshWidget", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emptyFocusable, f1_arg1, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if not CoD.PCUtility.IsUnavailable(self, f8_arg2) then
			CoD.PCWidgetUtility.CreateDropdown(self, self.DropdownList, f8_arg2, f8_arg1, "DropDown_ItemList")
			return true
		else
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		if not CoD.PCUtility.IsUnavailable(self, f9_arg2) then
			CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local DropdownList = CoD.DropDownList_ItemControl.new(f1_arg0, f1_arg1, 1, 1, -348, 0, 0.5, 1.5, -33, -33)
	DropdownList:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "Open",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOpen")
			end,
		},
		{
			stateName = "Close",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOpen")
			end,
		},
	})
	DropdownList:linkToElementModel(DropdownList, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(DropdownList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	DropdownList:linkToElementModel(DropdownList, "isOpen", true, function(model)
		f1_arg0:updateElementState(DropdownList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOpen",
		})
	end)
	DropdownList:linkToElementModel(self, nil, false, function(model)
		DropdownList:setModel(model, f1_arg1)
	end)
	DropdownList:linkToElementModel(self, "currentValue", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			DropdownList.TextBox:setText(CoD.BaseUtility.LocalizeIfXHash(CoD.PCWidgetUtility.OptionValueToOptionName(self, f16_local0)))
		end
	end)
	self:addElement(DropdownList)
	self.DropdownList = DropdownList
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
		CoD.PCWidgetUtility.PrepareDropdownList(self, f1_arg1, f1_arg0, controller, self.DropdownList)
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f21_local0 = self
		CoD.PCUtility.CallValueUpdateIfExist(self, f1_arg1)
	end)
	self:linkToElementModel(self, "refreshWidget", true, function(model)
		local f22_local0 = self
		CoD.PCWidgetUtility.UpdateOptionList(self, f1_arg1, true)
	end)
	emptyFocusable.id = "emptyFocusable"
	DropdownList.id = "DropdownList"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	DisableKeyboardNavigationByElement(self.DropdownList)
	return self
end
CoD.DropDownList.__resetProperties = function(f23_arg0)
	f23_arg0.ListItem:completeAnimation()
	f23_arg0.DropdownList:completeAnimation()
	f23_arg0.ListItem:setRGB(1, 1, 1)
	f23_arg0.ListItem:setAlpha(1)
	f23_arg0.DropdownList:setRGB(1, 1, 1)
	f23_arg0.DropdownList:setAlpha(1)
	f23_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
end
CoD.DropDownList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.ListItem:completeAnimation()
			f24_arg0.ListItem:playClip("DefaultClip")
			f24_arg0.clipFinished(f24_arg0.ListItem)
			f24_arg0.DropdownList:completeAnimation()
			f24_arg0.DropdownList.Arrow:completeAnimation()
			f24_arg0.DropdownList.Arrow:setRGB(0.81, 0.81, 0.81)
			f24_arg0.clipFinished(f24_arg0.DropdownList)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.ListItem:completeAnimation()
			f25_arg0.ListItem:setRGB(1, 1, 1)
			f25_arg0.ListItem:playClip("cFocus")
			f25_arg0.clipFinished(f25_arg0.ListItem)
			f25_arg0.DropdownList:completeAnimation()
			f25_arg0.DropdownList.Arrow:completeAnimation()
			f25_arg0.DropdownList:setRGB(1, 1, 1)
			f25_arg0.DropdownList.Arrow:setRGB(0.88, 0.88, 0.88)
			f25_arg0.clipFinished(f25_arg0.DropdownList)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				f26_arg0.ListItem:playClip("cGainFocus")
				f26_arg0.ListItem:beginAnimation(150)
				f26_arg0.ListItem:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f26_arg0.clipFinished(element, event)
				end)
			end
			f26_arg0.ListItem:completeAnimation()
			f26_arg0.ListItem:setAlpha(1)
			f26_local0(f26_arg0.ListItem)
			local f26_local1 = function(f29_arg0)
				f26_arg0.DropdownList:beginAnimation(150)
				f26_arg0.DropdownList.Arrow:beginAnimation(150)
				f26_arg0.DropdownList.Arrow:setRGB(0.88, 0.88, 0.88)
				f26_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.DropdownList:completeAnimation()
			f26_arg0.DropdownList.Arrow:completeAnimation()
			f26_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
			f26_local1(f26_arg0.DropdownList)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				f30_arg0.ListItem:playClip("cLoseFocus")
				f30_arg0.ListItem:beginAnimation(150)
				f30_arg0.ListItem:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f30_arg0.clipFinished(element, event)
				end)
			end
			f30_arg0.ListItem:completeAnimation()
			f30_arg0.ListItem:setAlpha(1)
			f30_local0(f30_arg0.ListItem)
			local f30_local1 = function(f33_arg0)
				f30_arg0.DropdownList:beginAnimation(150)
				f30_arg0.DropdownList.Arrow:beginAnimation(150)
				f30_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
				f30_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.DropdownList:completeAnimation()
			f30_arg0.DropdownList.Arrow:completeAnimation()
			f30_arg0.DropdownList.Arrow:setRGB(0.88, 0.88, 0.88)
			f30_local1(f30_arg0.DropdownList)
		end,
		Active = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.ListItem:completeAnimation()
			f34_arg0.ListItem:playClip("cActive")
			f34_arg0.clipFinished(f34_arg0.ListItem)
			f34_arg0.DropdownList:completeAnimation()
			f34_arg0.DropdownList.Arrow:completeAnimation()
			f34_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f34_arg0.clipFinished(f34_arg0.DropdownList)
		end,
		ActiveAndChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.ListItem:completeAnimation()
			f35_arg0.ListItem:playClip("cActiveAndFocus")
			f35_arg0.clipFinished(f35_arg0.ListItem)
			f35_arg0.DropdownList:completeAnimation()
			f35_arg0.DropdownList.Arrow:completeAnimation()
			f35_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f35_arg0.clipFinished(f35_arg0.DropdownList)
		end,
		ActiveToActiveAndChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.ListItem:completeAnimation()
			f36_arg0.ListItem:playClip("cActiveToActiveAndFocus")
			f36_arg0.clipFinished(f36_arg0.ListItem)
			f36_arg0.DropdownList:completeAnimation()
			f36_arg0.DropdownList.Arrow:completeAnimation()
			f36_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f36_arg0.clipFinished(f36_arg0.DropdownList)
		end,
		ActiveAndFocusToActive = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.DropdownList:completeAnimation()
			f37_arg0.DropdownList.Arrow:completeAnimation()
			f37_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f37_arg0.clipFinished(f37_arg0.DropdownList)
		end,
		GainActiveAndChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.ListItem:completeAnimation()
			f38_arg0.ListItem:playClip("cGainActiveAndFocus")
			f38_arg0.clipFinished(f38_arg0.ListItem)
			local f38_local0 = function(f39_arg0)
				f38_arg0.DropdownList:beginAnimation(150)
				f38_arg0.DropdownList.Arrow:beginAnimation(150)
				f38_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
				f38_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.DropdownList:completeAnimation()
			f38_arg0.DropdownList.Arrow:completeAnimation()
			f38_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
			f38_local0(f38_arg0.DropdownList)
		end,
		LoseActive = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.ListItem:completeAnimation()
			f40_arg0.ListItem:playClip("cLoseActive")
			f40_arg0.clipFinished(f40_arg0.ListItem)
			local f40_local0 = function(f41_arg0)
				f40_arg0.DropdownList:beginAnimation(150)
				f40_arg0.DropdownList.Arrow:beginAnimation(150)
				f40_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
				f40_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.DropdownList:completeAnimation()
			f40_arg0.DropdownList.Arrow:completeAnimation()
			f40_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f40_local0(f40_arg0.DropdownList)
		end,
	},
	Unavailable = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.ListItem:completeAnimation()
			f42_arg0.ListItem:playClip("dDefault")
			f42_arg0.clipFinished(f42_arg0.ListItem)
			f42_arg0.DropdownList:completeAnimation()
			f42_arg0.DropdownList:setAlpha(0.2)
			f42_arg0.clipFinished(f42_arg0.DropdownList)
		end,
		ChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			f43_arg0.ListItem:completeAnimation()
			f43_arg0.ListItem:playClip("dFocus")
			f43_arg0.clipFinished(f43_arg0.ListItem)
			f43_arg0.DropdownList:completeAnimation()
			f43_arg0.DropdownList:setAlpha(0.2)
			f43_arg0.clipFinished(f43_arg0.DropdownList)
		end,
		Active = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			f44_arg0.ListItem:completeAnimation()
			f44_arg0.ListItem:playClip("dActive")
			f44_arg0.clipFinished(f44_arg0.ListItem)
			f44_arg0.DropdownList:completeAnimation()
			f44_arg0.DropdownList:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.DropdownList)
		end,
		GainChildFocus = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
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
			f45_arg0.DropdownList:completeAnimation()
			f45_arg0.DropdownList:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.DropdownList)
		end,
		LoseChildFocus = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
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
			f48_arg0.DropdownList:completeAnimation()
			f48_arg0.DropdownList:setAlpha(0.2)
			f48_arg0.clipFinished(f48_arg0.DropdownList)
		end,
		ActiveAndChildFocus = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(2)
			f51_arg0.ListItem:completeAnimation()
			f51_arg0.ListItem:playClip("dActiveAndFocus")
			f51_arg0.clipFinished(f51_arg0.ListItem)
			f51_arg0.DropdownList:completeAnimation()
			f51_arg0.DropdownList:setAlpha(0.2)
			f51_arg0.clipFinished(f51_arg0.DropdownList)
		end,
		GainActiveAndChildFocus = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(2)
			f52_arg0.ListItem:completeAnimation()
			f52_arg0.ListItem:playClip("dGainActiveAndFocus")
			f52_arg0.clipFinished(f52_arg0.ListItem)
			local f52_local0 = function(f53_arg0)
				f52_arg0.DropdownList:beginAnimation(150)
				f52_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.DropdownList:completeAnimation()
			f52_arg0.DropdownList:setAlpha(0.2)
			f52_local0(f52_arg0.DropdownList)
		end,
		LoseActive = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(2)
			f54_arg0.ListItem:completeAnimation()
			f54_arg0.ListItem:playClip("dLoseActive")
			f54_arg0.clipFinished(f54_arg0.ListItem)
			local f54_local0 = function(f55_arg0)
				f54_arg0.DropdownList:beginAnimation(150)
				f54_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.DropdownList:completeAnimation()
			f54_arg0.DropdownList:setAlpha(0.2)
			f54_local0(f54_arg0.DropdownList)
		end,
		ActiveAndChildFocusToActive = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(2)
			f56_arg0.ListItem:completeAnimation()
			f56_arg0.ListItem:playClip("dActiveAndFocusToActive")
			f56_arg0.clipFinished(f56_arg0.ListItem)
			f56_arg0.DropdownList:completeAnimation()
			f56_arg0.DropdownList:setAlpha(0.2)
			f56_arg0.clipFinished(f56_arg0.DropdownList)
		end,
		ActiveToActiveAndChildFocus = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(2)
			f57_arg0.ListItem:completeAnimation()
			f57_arg0.ListItem:playClip("dActiveToActiveAndFocus")
			f57_arg0.clipFinished(f57_arg0.ListItem)
			f57_arg0.DropdownList:completeAnimation()
			f57_arg0.DropdownList:setAlpha(0.2)
			f57_arg0.clipFinished(f57_arg0.DropdownList)
		end,
	},
	FadedOut = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(2)
			f58_arg0.ListItem:completeAnimation()
			f58_arg0.ListItem:setAlpha(0.3)
			f58_arg0.clipFinished(f58_arg0.ListItem)
			f58_arg0.DropdownList:completeAnimation()
			f58_arg0.DropdownList:setAlpha(0.3)
			f58_arg0.clipFinished(f58_arg0.DropdownList)
		end,
	},
}
CoD.DropDownList.__onClose = function(f59_arg0)
	f59_arg0.ListItem:close()
	f59_arg0.emptyFocusable:close()
	f59_arg0.DropdownList:close()
end
