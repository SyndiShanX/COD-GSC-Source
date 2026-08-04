require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/startmenu/controlsoptions/pc_startmenu_options_controls_keybind")
require("ui/uieditor/widgets/pc/startmenu/listitem")
CoD.PC_StartMenu_Options_Controls_KeyBinder = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_KeyBinder.__defaultWidth = 750
CoD.PC_StartMenu_Options_Controls_KeyBinder.__defaultHeight = 65
CoD.PC_StartMenu_Options_Controls_KeyBinder.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_KeyBinder)
	self.id = "PC_StartMenu_Options_Controls_KeyBinder"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListItem = CoD.ListItem.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ListItem:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	ListItem:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ListItem, f3_arg1)
	end)
	local KeyBind1 = ListItem
	local emptyFocusable = ListItem.subscribeToModel
	local KeyBind2 = Engine.GetModelForController(f1_arg1)
	emptyFocusable(KeyBind1, KeyBind2.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(ListItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ListItem:linkToElementModel(self, nil, false, function(model)
		ListItem:setModel(model, f1_arg1)
	end)
	ListItem:linkToElementModel(self, "name", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ListItem.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(ListItem)
	self.ListItem = ListItem
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 40, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	KeyBind1 = CoD.PC_StartMenu_Options_Controls_KeyBind.new(f1_arg0, f1_arg1, 1, 1, -348, -174, 0, 1, 0, 0)
	KeyBind1:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "IsBinding",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "binding_main")
			end,
		},
	})
	KeyBind1:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(KeyBind1, f9_arg1)
	end)
	local f1_local5 = KeyBind1
	KeyBind2 = KeyBind1.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg1)
	KeyBind2(f1_local5, f1_local6.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(KeyBind1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	KeyBind1:linkToElementModel(KeyBind1, "binding_main", true, function(model)
		f1_arg0:updateElementState(KeyBind1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "binding_main",
		})
	end)
	KeyBind1:linkToElementModel(self, nil, false, function(model)
		KeyBind1:setModel(model, f1_arg1)
	end)
	KeyBind1:linkToElementModel(self, "bind_main", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			KeyBind1.KeyVisual.KeyText:setText(CoD.BaseUtility.AlreadyLocalized(f13_local0))
		end
	end)
	self:addElement(KeyBind1)
	self.KeyBind1 = KeyBind1
	KeyBind2 = CoD.PC_StartMenu_Options_Controls_KeyBind.new(f1_arg0, f1_arg1, 1, 1, -174, 0, 0, 1, 0, 0)
	KeyBind2:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "IsBinding",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "binding_alt")
			end,
		},
	})
	KeyBind2:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(KeyBind2, f16_arg1)
	end)
	f1_local6 = KeyBind2
	f1_local5 = KeyBind2.subscribeToModel
	local f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local6, f1_local7.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(KeyBind2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	KeyBind2:linkToElementModel(KeyBind2, "binding_alt", true, function(model)
		f1_arg0:updateElementState(KeyBind2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "binding_alt",
		})
	end)
	KeyBind2:linkToElementModel(self, nil, false, function(model)
		KeyBind2:setModel(model, f1_arg1)
	end)
	KeyBind2:linkToElementModel(self, "bind_alt", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			KeyBind2.KeyVisual.KeyText:setText(CoD.BaseUtility.AlreadyLocalized(f20_local0))
		end
	end)
	self:addElement(KeyBind2)
	self.KeyBind2 = KeyBind2
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "FadedOut",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f23_arg1)
	end)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local6, f1_local7.LastInput, function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f25_arg2, f25_arg3, f25_arg4)
		if IsInDefaultState(element) and CoD.ModelUtility.IsSelfModelPathNil(element, controller, "action") and IsSelfPropertyValue(self, "action", nil) then
			DisableMouseButton(self, controller)
			DisableKeyboardNavigationByElement(self.emptyFocusable)
		elseif IsSelfInState(self, "Disabled") then
			EnableKeyboardNavigationByElement(self.emptyFocusable)
		elseif IsInDefaultState(self) then
			DisableKeyboardNavigationByElement(self.emptyFocusable)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.PCWidgetUtility.PrepareMainAltKeyBinder(self, f1_arg1, f1_arg0, controller, self.KeyBind1, self.KeyBind2)
	end)
	emptyFocusable.id = "emptyFocusable"
	KeyBind1.id = "KeyBind1"
	KeyBind2.id = "KeyBind2"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_KeyBinder.__resetProperties = function(f27_arg0)
	f27_arg0.ListItem:completeAnimation()
	f27_arg0.KeyBind1:completeAnimation()
	f27_arg0.KeyBind2:completeAnimation()
	f27_arg0.ListItem:setAlpha(1)
	f27_arg0.KeyBind1:setAlpha(1)
	f27_arg0.KeyBind2:setAlpha(1)
end
CoD.PC_StartMenu_Options_Controls_KeyBinder.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.ListItem:completeAnimation()
			f28_arg0.ListItem:playClip("DefaultClip")
			f28_arg0.clipFinished(f28_arg0.ListItem)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.ListItem:playClip("cGainFocus")
				f29_arg0.ListItem:beginAnimation(150)
				f29_arg0.ListItem:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f29_arg0.clipFinished(element, event)
				end)
			end
			f29_arg0.ListItem:completeAnimation()
			f29_arg0.ListItem:setAlpha(1)
			f29_local0(f29_arg0.ListItem)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			local f32_local0 = function(f33_arg0)
				f32_arg0.ListItem:playClip("cLoseFocus")
				f32_arg0.ListItem:beginAnimation(150)
				f32_arg0.ListItem:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f32_arg0.clipFinished(element, event)
				end)
			end
			f32_arg0.ListItem:completeAnimation()
			f32_arg0.ListItem:setAlpha(1)
			f32_local0(f32_arg0.ListItem)
		end,
		ChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.ListItem:completeAnimation()
			f35_arg0.ListItem:playClip("cFocus")
			f35_arg0.clipFinished(f35_arg0.ListItem)
		end,
		Active = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.ListItem:completeAnimation()
			f36_arg0.ListItem:playClip("cActive")
			f36_arg0.clipFinished(f36_arg0.ListItem)
		end,
		LoseActive = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			f37_arg0.ListItem:completeAnimation()
			f37_arg0.ListItem:playClip("cLoseActive")
			f37_arg0.clipFinished(f37_arg0.ListItem)
			local f37_local0 = function(f38_arg0)
				f37_arg0.KeyBind1:beginAnimation(150)
				f37_arg0.KeyBind1:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.KeyBind1:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.KeyBind1:completeAnimation()
			f37_arg0.KeyBind1:setAlpha(1)
			f37_local0(f37_arg0.KeyBind1)
		end,
		ActiveAndChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			f39_arg0.ListItem:completeAnimation()
			f39_arg0.ListItem:playClip("cActiveAndFocus")
			f39_arg0.clipFinished(f39_arg0.ListItem)
		end,
		GainActiveAndChildFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.ListItem:completeAnimation()
			f40_arg0.ListItem:playClip("cGainActiveAndFocus")
			f40_arg0.clipFinished(f40_arg0.ListItem)
			local f40_local0 = function(f41_arg0)
				f40_arg0.KeyBind1:beginAnimation(150)
				f40_arg0.KeyBind1:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.KeyBind1:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.KeyBind1:completeAnimation()
			f40_arg0.KeyBind1:setAlpha(1)
			f40_local0(f40_arg0.KeyBind1)
		end,
		ActiveToActiveAndChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(1)
			f42_arg0.ListItem:completeAnimation()
			f42_arg0.ListItem:playClip("cActiveToActiveAndFocus")
			f42_arg0.clipFinished(f42_arg0.ListItem)
		end,
		ActiveAndChildFocusToActive = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(1)
			f43_arg0.ListItem:completeAnimation()
			f43_arg0.ListItem:playClip("cActiveAndFocusToActive")
			f43_arg0.clipFinished(f43_arg0.ListItem)
		end,
	},
	Disabled = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.ListItem:completeAnimation()
			f44_arg0.ListItem:playClip("DefaultClip")
			f44_arg0.clipFinished(f44_arg0.ListItem)
			f44_arg0.KeyBind1:completeAnimation()
			f44_arg0.KeyBind1:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.KeyBind1)
			f44_arg0.KeyBind2:completeAnimation()
			f44_arg0.KeyBind2:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.KeyBind2)
		end,
		ChildFocus = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(3)
			f45_arg0.ListItem:completeAnimation()
			f45_arg0.ListItem:playClip("dFocus")
			f45_arg0.clipFinished(f45_arg0.ListItem)
			f45_arg0.KeyBind1:completeAnimation()
			f45_arg0.KeyBind1:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.KeyBind1)
			f45_arg0.KeyBind2:completeAnimation()
			f45_arg0.KeyBind2:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.KeyBind2)
		end,
		GainChildFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(3)
			local f46_local0 = function(f47_arg0)
				f46_arg0.ListItem:playClip("dGainFocus")
				f46_arg0.ListItem:beginAnimation(150)
				f46_arg0.ListItem:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dGainFocus")
					f46_arg0.clipFinished(element, event)
				end)
			end
			f46_arg0.ListItem:completeAnimation()
			f46_arg0.ListItem:setAlpha(1)
			f46_local0(f46_arg0.ListItem)
			f46_arg0.KeyBind1:completeAnimation()
			f46_arg0.KeyBind1:setAlpha(0.2)
			f46_arg0.clipFinished(f46_arg0.KeyBind1)
			f46_arg0.KeyBind2:completeAnimation()
			f46_arg0.KeyBind2:setAlpha(0.2)
			f46_arg0.clipFinished(f46_arg0.KeyBind2)
		end,
		LoseChildFocus = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			local f49_local0 = function(f50_arg0)
				f49_arg0.ListItem:playClip("dLoseFocus")
				f49_arg0.ListItem:beginAnimation(150)
				f49_arg0.ListItem:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dLoseFocus")
					f49_arg0.clipFinished(element, event)
				end)
			end
			f49_arg0.ListItem:completeAnimation()
			f49_arg0.ListItem:setAlpha(1)
			f49_local0(f49_arg0.ListItem)
			f49_arg0.KeyBind1:completeAnimation()
			f49_arg0.KeyBind1:setAlpha(0.2)
			f49_arg0.clipFinished(f49_arg0.KeyBind1)
			f49_arg0.KeyBind2:completeAnimation()
			f49_arg0.KeyBind2:setAlpha(0.2)
			f49_arg0.clipFinished(f49_arg0.KeyBind2)
		end,
		Active = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(3)
			f52_arg0.ListItem:completeAnimation()
			f52_arg0.ListItem:playClip("dActive")
			f52_arg0.clipFinished(f52_arg0.ListItem)
			f52_arg0.KeyBind1:completeAnimation()
			f52_arg0.KeyBind1:setAlpha(0.2)
			f52_arg0.clipFinished(f52_arg0.KeyBind1)
			f52_arg0.KeyBind2:completeAnimation()
			f52_arg0.KeyBind2:setAlpha(0.2)
			f52_arg0.clipFinished(f52_arg0.KeyBind2)
		end,
		ActiveAndChildFocus = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(3)
			f53_arg0.ListItem:completeAnimation()
			f53_arg0.ListItem:playClip("dActiveAndFocus")
			f53_arg0.clipFinished(f53_arg0.ListItem)
			f53_arg0.KeyBind1:completeAnimation()
			f53_arg0.KeyBind1:setAlpha(0.2)
			f53_arg0.clipFinished(f53_arg0.KeyBind1)
			f53_arg0.KeyBind2:completeAnimation()
			f53_arg0.KeyBind2:setAlpha(0.2)
			f53_arg0.clipFinished(f53_arg0.KeyBind2)
		end,
		LoseActive = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(3)
			f54_arg0.ListItem:completeAnimation()
			f54_arg0.ListItem:playClip("dLoseActive")
			f54_arg0.clipFinished(f54_arg0.ListItem)
			local f54_local0 = function(f55_arg0)
				f54_arg0.KeyBind1:beginAnimation(150)
				f54_arg0.KeyBind1:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.KeyBind1:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.KeyBind1:completeAnimation()
			f54_arg0.KeyBind1:setAlpha(0.2)
			f54_local0(f54_arg0.KeyBind1)
			local f54_local1 = function(f56_arg0)
				f54_arg0.KeyBind2:beginAnimation(150)
				f54_arg0.KeyBind2:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.KeyBind2:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.KeyBind2:completeAnimation()
			f54_arg0.KeyBind2:setAlpha(0.2)
			f54_local1(f54_arg0.KeyBind2)
		end,
		GainActiveAndChildFocus = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(3)
			f57_arg0.ListItem:completeAnimation()
			f57_arg0.ListItem:playClip("dGainActiveAndFocus")
			f57_arg0.clipFinished(f57_arg0.ListItem)
			local f57_local0 = function(f58_arg0)
				f57_arg0.KeyBind1:beginAnimation(150)
				f57_arg0.KeyBind1:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.KeyBind1:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.KeyBind1:completeAnimation()
			f57_arg0.KeyBind1:setAlpha(0.2)
			f57_local0(f57_arg0.KeyBind1)
			local f57_local1 = function(f59_arg0)
				f57_arg0.KeyBind2:beginAnimation(150)
				f57_arg0.KeyBind2:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.KeyBind2:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.KeyBind2:completeAnimation()
			f57_arg0.KeyBind2:setAlpha(0.2)
			f57_local1(f57_arg0.KeyBind2)
		end,
		ActiveAndChildFocusToActive = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(3)
			f60_arg0.ListItem:completeAnimation()
			f60_arg0.ListItem:playClip("dActiveAndFocusToActive")
			f60_arg0.clipFinished(f60_arg0.ListItem)
			f60_arg0.KeyBind1:completeAnimation()
			f60_arg0.KeyBind1:setAlpha(0.2)
			f60_arg0.clipFinished(f60_arg0.KeyBind1)
			f60_arg0.KeyBind2:completeAnimation()
			f60_arg0.KeyBind2:setAlpha(0.2)
			f60_arg0.clipFinished(f60_arg0.KeyBind2)
		end,
		ActiveToActiveAndChildFocus = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(3)
			f61_arg0.ListItem:completeAnimation()
			f61_arg0.ListItem:playClip("dActiveToActiveAndFocus")
			f61_arg0.clipFinished(f61_arg0.ListItem)
			f61_arg0.KeyBind1:completeAnimation()
			f61_arg0.KeyBind1:setAlpha(0.2)
			f61_arg0.clipFinished(f61_arg0.KeyBind1)
			f61_arg0.KeyBind2:completeAnimation()
			f61_arg0.KeyBind2:setAlpha(0.2)
			f61_arg0.clipFinished(f61_arg0.KeyBind2)
		end,
	},
	FadedOut = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PC_StartMenu_Options_Controls_KeyBinder.__onClose = function(f63_arg0)
	f63_arg0.ListItem:close()
	f63_arg0.emptyFocusable:close()
	f63_arg0.KeyBind1:close()
	f63_arg0.KeyBind2:close()
end
