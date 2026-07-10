require("x64:2675595fa323085")
require("x64:d03b459fa976316")
require("x64:ec3aebbc4ad4b48")
CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings.__defaultWidth = 750
CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings.__defaultHeight = 65
CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PCWidgetUtility.PrepareOptionsKeysetBindingsDropdownProperties(self, f1_arg1)
	self:setClass(CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings)
	self.id = "PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListItem = CoD.ListItemNoCategory.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
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
			ListItem.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(ListItem)
	self.ListItem = ListItem
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local DropdownList = CoD.DropDownList_ItemControl.new(f1_arg0, f1_arg1, 1, 1, -300, 0, 0, 1, 0, 0)
	DropdownList:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
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
	DropdownList:linkToElementModel(self, nil, false, function(model)
		DropdownList:setModel(model, f1_arg1)
	end)
	DropdownList.TextBox.__Text = function(f8_arg0)
		local f8_local0 = f8_arg0:get()
		if f8_local0 ~= nil then
			DropdownList.TextBox:setText(CoD.BaseUtility.LocalizeIfXHash(CoD.PCWidgetUtility.KeybindPresetToText(self, f8_local0)))
		end
	end
	DropdownList:linkToElementModel(self, "presetId", true, DropdownList.TextBox.__Text)
	DropdownList.TextBox.__Text_FullPath = function()
		local f9_local0 = self:getModel()
		if f9_local0 then
			f9_local0 = self:getModel()
			f9_local0 = f9_local0.presetId
		end
		if f9_local0 then
			DropdownList.TextBox.__Text(f9_local0)
		end
	end
	self:addElement(DropdownList)
	self.DropdownList = DropdownList
	DropdownList:linkToElementModel(self, "presetIsModified", true, DropdownList.TextBox.__Text_FullPath)
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
		local f14_local0 = self
		CoD.PCUtility.CallValueUpdateIfExist(self, f1_arg1)
	end)
	emptyFocusable.id = "emptyFocusable"
	DropdownList.id = "DropdownList"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings.__resetProperties = function(f15_arg0)
	f15_arg0.ListItem:completeAnimation()
	f15_arg0.DropdownList:completeAnimation()
	f15_arg0.ListItem:setRGB(1, 1, 1)
	f15_arg0.ListItem:setAlpha(1)
	f15_arg0.DropdownList:setRGB(1, 1, 1)
	f15_arg0.DropdownList:setAlpha(1)
	f15_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
end
CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.ListItem:completeAnimation()
			f16_arg0.ListItem:playClip("DefaultClip")
			f16_arg0.clipFinished(f16_arg0.ListItem)
			f16_arg0.DropdownList:completeAnimation()
			f16_arg0.DropdownList.Arrow:completeAnimation()
			f16_arg0.DropdownList.Arrow:setRGB(0.81, 0.81, 0.81)
			f16_arg0.clipFinished(f16_arg0.DropdownList)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.ListItem:completeAnimation()
			f17_arg0.ListItem:setRGB(1, 1, 1)
			f17_arg0.ListItem:playClip("cFocus")
			f17_arg0.clipFinished(f17_arg0.ListItem)
			f17_arg0.DropdownList:completeAnimation()
			f17_arg0.DropdownList.Arrow:completeAnimation()
			f17_arg0.DropdownList:setRGB(1, 1, 1)
			f17_arg0.DropdownList.Arrow:setRGB(0.88, 0.88, 0.88)
			f17_arg0.clipFinished(f17_arg0.DropdownList)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				f18_arg0.ListItem:playClip("cGainFocus")
				f18_arg0.ListItem:beginAnimation(150)
				f18_arg0.ListItem:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f18_arg0.clipFinished(element, event)
				end)
			end
			f18_arg0.ListItem:completeAnimation()
			f18_arg0.ListItem:setAlpha(1)
			f18_local0(f18_arg0.ListItem)
			local f18_local1 = function(f21_arg0)
				f18_arg0.DropdownList:beginAnimation(150)
				f18_arg0.DropdownList.Arrow:beginAnimation(150)
				f18_arg0.DropdownList.Arrow:setRGB(0.88, 0.88, 0.88)
				f18_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.DropdownList:completeAnimation()
			f18_arg0.DropdownList.Arrow:completeAnimation()
			f18_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
			f18_local1(f18_arg0.DropdownList)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.ListItem:playClip("cLoseFocus")
				f22_arg0.ListItem:beginAnimation(150)
				f22_arg0.ListItem:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f22_arg0.clipFinished(element, event)
				end)
			end
			f22_arg0.ListItem:completeAnimation()
			f22_arg0.ListItem:setAlpha(1)
			f22_local0(f22_arg0.ListItem)
			local f22_local1 = function(f25_arg0)
				f22_arg0.DropdownList:beginAnimation(150)
				f22_arg0.DropdownList.Arrow:beginAnimation(150)
				f22_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
				f22_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.DropdownList:completeAnimation()
			f22_arg0.DropdownList.Arrow:completeAnimation()
			f22_arg0.DropdownList.Arrow:setRGB(0.88, 0.88, 0.88)
			f22_local1(f22_arg0.DropdownList)
		end,
		Active = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.ListItem:completeAnimation()
			f26_arg0.ListItem:playClip("cActive")
			f26_arg0.clipFinished(f26_arg0.ListItem)
			f26_arg0.DropdownList:completeAnimation()
			f26_arg0.DropdownList.Arrow:completeAnimation()
			f26_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f26_arg0.clipFinished(f26_arg0.DropdownList)
		end,
		ActiveAndChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.ListItem:completeAnimation()
			f27_arg0.ListItem:playClip("cActiveAndFocus")
			f27_arg0.clipFinished(f27_arg0.ListItem)
			f27_arg0.DropdownList:completeAnimation()
			f27_arg0.DropdownList.Arrow:completeAnimation()
			f27_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f27_arg0.clipFinished(f27_arg0.DropdownList)
		end,
		ActiveToActiveAndChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.ListItem:completeAnimation()
			f28_arg0.ListItem:playClip("cActiveToActiveAndFocus")
			f28_arg0.clipFinished(f28_arg0.ListItem)
			f28_arg0.DropdownList:completeAnimation()
			f28_arg0.DropdownList.Arrow:completeAnimation()
			f28_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f28_arg0.clipFinished(f28_arg0.DropdownList)
		end,
		ActiveAndFocusToActive = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.DropdownList:completeAnimation()
			f29_arg0.DropdownList.Arrow:completeAnimation()
			f29_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f29_arg0.clipFinished(f29_arg0.DropdownList)
		end,
		GainActiveAndChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.ListItem:completeAnimation()
			f30_arg0.ListItem:playClip("cGainActiveAndFocus")
			f30_arg0.clipFinished(f30_arg0.ListItem)
			local f30_local0 = function(f31_arg0)
				f30_arg0.DropdownList:beginAnimation(150)
				f30_arg0.DropdownList.Arrow:beginAnimation(150)
				f30_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
				f30_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.DropdownList:completeAnimation()
			f30_arg0.DropdownList.Arrow:completeAnimation()
			f30_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
			f30_local0(f30_arg0.DropdownList)
		end,
		LoseActive = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.ListItem:completeAnimation()
			f32_arg0.ListItem:playClip("cLoseActive")
			f32_arg0.clipFinished(f32_arg0.ListItem)
			local f32_local0 = function(f33_arg0)
				f32_arg0.DropdownList:beginAnimation(150)
				f32_arg0.DropdownList.Arrow:beginAnimation(150)
				f32_arg0.DropdownList.Arrow:setRGB(0.58, 0.58, 0.58)
				f32_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.DropdownList:completeAnimation()
			f32_arg0.DropdownList.Arrow:completeAnimation()
			f32_arg0.DropdownList.Arrow:setRGB(1, 1, 1)
			f32_local0(f32_arg0.DropdownList)
		end,
	},
	Unavailable = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.ListItem:completeAnimation()
			f34_arg0.ListItem:playClip("dDefault")
			f34_arg0.clipFinished(f34_arg0.ListItem)
			f34_arg0.DropdownList:completeAnimation()
			f34_arg0.DropdownList:setAlpha(0.2)
			f34_arg0.clipFinished(f34_arg0.DropdownList)
		end,
		ChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.ListItem:completeAnimation()
			f35_arg0.ListItem:playClip("dFocus")
			f35_arg0.clipFinished(f35_arg0.ListItem)
			f35_arg0.DropdownList:completeAnimation()
			f35_arg0.DropdownList:setAlpha(0.2)
			f35_arg0.clipFinished(f35_arg0.DropdownList)
		end,
		Active = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.ListItem:completeAnimation()
			f36_arg0.ListItem:playClip("dActive")
			f36_arg0.clipFinished(f36_arg0.ListItem)
			f36_arg0.DropdownList:completeAnimation()
			f36_arg0.DropdownList:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.DropdownList)
		end,
		GainChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			local f37_local0 = function(f38_arg0)
				f37_arg0.ListItem:playClip("dGainFocus")
				f37_arg0.ListItem:beginAnimation(150)
				f37_arg0.ListItem:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dGainFocus")
					f37_arg0.clipFinished(element, event)
				end)
			end
			f37_arg0.ListItem:completeAnimation()
			f37_arg0.ListItem:setAlpha(1)
			f37_local0(f37_arg0.ListItem)
			f37_arg0.DropdownList:completeAnimation()
			f37_arg0.DropdownList:setAlpha(0.2)
			f37_arg0.clipFinished(f37_arg0.DropdownList)
		end,
		LoseChildFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			local f40_local0 = function(f41_arg0)
				f40_arg0.ListItem:playClip("dLoseFocus")
				f40_arg0.ListItem:beginAnimation(150)
				f40_arg0.ListItem:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dLoseFocus")
					f40_arg0.clipFinished(element, event)
				end)
			end
			f40_arg0.ListItem:completeAnimation()
			f40_arg0.ListItem:setAlpha(1)
			f40_local0(f40_arg0.ListItem)
			f40_arg0.DropdownList:completeAnimation()
			f40_arg0.DropdownList:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.DropdownList)
		end,
		ActiveAndChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			f43_arg0.ListItem:completeAnimation()
			f43_arg0.ListItem:playClip("dActiveAndFocus")
			f43_arg0.clipFinished(f43_arg0.ListItem)
			f43_arg0.DropdownList:completeAnimation()
			f43_arg0.DropdownList:setAlpha(0.2)
			f43_arg0.clipFinished(f43_arg0.DropdownList)
		end,
		GainActiveAndChildFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			f44_arg0.ListItem:completeAnimation()
			f44_arg0.ListItem:playClip("dGainActiveAndFocus")
			f44_arg0.clipFinished(f44_arg0.ListItem)
			local f44_local0 = function(f45_arg0)
				f44_arg0.DropdownList:beginAnimation(150)
				f44_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.DropdownList:completeAnimation()
			f44_arg0.DropdownList:setAlpha(0.2)
			f44_local0(f44_arg0.DropdownList)
		end,
		LoseActive = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(2)
			f46_arg0.ListItem:completeAnimation()
			f46_arg0.ListItem:playClip("dLoseActive")
			f46_arg0.clipFinished(f46_arg0.ListItem)
			local f46_local0 = function(f47_arg0)
				f46_arg0.DropdownList:beginAnimation(150)
				f46_arg0.DropdownList:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.DropdownList:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.DropdownList:completeAnimation()
			f46_arg0.DropdownList:setAlpha(0.2)
			f46_local0(f46_arg0.DropdownList)
		end,
		ActiveAndChildFocusToActive = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			f48_arg0.ListItem:completeAnimation()
			f48_arg0.ListItem:playClip("dActiveAndFocusToActive")
			f48_arg0.clipFinished(f48_arg0.ListItem)
			f48_arg0.DropdownList:completeAnimation()
			f48_arg0.DropdownList:setAlpha(0.2)
			f48_arg0.clipFinished(f48_arg0.DropdownList)
		end,
		ActiveToActiveAndChildFocus = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(2)
			f49_arg0.ListItem:completeAnimation()
			f49_arg0.ListItem:playClip("dActiveToActiveAndFocus")
			f49_arg0.clipFinished(f49_arg0.ListItem)
			f49_arg0.DropdownList:completeAnimation()
			f49_arg0.DropdownList:setAlpha(0.2)
			f49_arg0.clipFinished(f49_arg0.DropdownList)
		end,
	},
	FadedOut = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(2)
			f50_arg0.ListItem:completeAnimation()
			f50_arg0.ListItem:setAlpha(0.3)
			f50_arg0.clipFinished(f50_arg0.ListItem)
			f50_arg0.DropdownList:completeAnimation()
			f50_arg0.DropdownList:setAlpha(0.3)
			f50_arg0.clipFinished(f50_arg0.DropdownList)
		end,
	},
}
CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings.__onClose = function(f51_arg0)
	f51_arg0.ListItem:close()
	f51_arg0.emptyFocusable:close()
	f51_arg0.DropdownList:close()
end
