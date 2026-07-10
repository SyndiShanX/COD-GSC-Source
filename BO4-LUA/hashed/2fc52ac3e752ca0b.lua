require("x64:68a7fb500b8d75f")
CoD.WarzoneQuickInventoryPromptInternal = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickInventoryPromptInternal.__defaultWidth = 150
CoD.WarzoneQuickInventoryPromptInternal.__defaultHeight = 36
CoD.WarzoneQuickInventoryPromptInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickInventoryPromptInternal)
	self.id = "WarzoneQuickInventoryPromptInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(0.5, 0.5, -103.5, 136.5, 0, 0, 9, 27)
	label:setRGB(0.92, 0.92, 0.92)
	label:setTTF("ttmussels_regular")
	label:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	label:setShaderVector(0, 0.6, 0, 0, 0)
	label:setShaderVector(1, 0.3, 0, 0, 0)
	label:setShaderVector(2, 0, 0, 0, 1)
	label:setLetterSpacing(2)
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	label:setBackingType(1)
	label:setBackingWidget(CoD.WarzoneQuickInventoryPromptBacking, f1_arg0, f1_arg1)
	label:setBackingXPadding(38)
	label:setBackingYPadding(8)
	label:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			label._backingElement.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	label.__String_Reference = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			label:setText(ConvertToUpperString(CoD.WZUtility.LocalizeSelectedInventoryIntoString(f1_arg1, f3_local0)))
		end
	end
	label:linkToElementModel(self, "Label", true, label.__String_Reference)
	label.__String_Reference_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.Label
		end
		if f4_local0 then
			label.__String_Reference(f4_local0)
		end
	end
	label:linkToElementModel(self, nil, false, function(model)
		label:setBackingModel(model, f1_arg1)
	end)
	self:addElement(label)
	self.label = label
	local f1_local2 = label
	local f1_local3 = label.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.inventory.selectedItemName"], label.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"]) and CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"bpf_contextual"])
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"]) and CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"bpf_contextual"])
			end,
		},
		{
			stateName = "DefaultStateGamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f11_arg1)
	end)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f13_arg2, f13_arg3, f13_arg4)
		if IsInDefaultState(self) and IsMouseOrKeyboard(controller) then
			DisableMouseButton(self, controller)
			CoD.FreeCursorUtility.CloseContextualPromptPC(self)
		elseif IsMouseOrKeyboard(controller) then
			EnableMouseButton(self, controller)
			CoD.FreeCursorUtility.OpenContextualPromptPC(self)
		elseif IsInDefaultState(self) and IsGamepad(controller) then
			DisableMouseButton(self, controller)
		elseif IsGamepad(controller) then
			EnableMouseButton(self, controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	if IsPC() then
		CoD.PCUtility.SetupButtonPromptForPC(self, f1_arg1, f1_arg0)
		CoD.FreeCursorUtility.UseLocalHeight(self)
		CoD.FreeCursorUtility.SetupHideContextualPromptPC(f1_local3, f1_arg1)
	else
		CoD.FreeCursorUtility.UseLocalHeight(self)
	end
	return self
end
CoD.WarzoneQuickInventoryPromptInternal.__resetProperties = function(f14_arg0)
	f14_arg0.label:completeAnimation()
	f14_arg0.label:setRGB(0.92, 0.92, 0.92)
	f14_arg0.label:setAlpha(1)
end
CoD.WarzoneQuickInventoryPromptInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.label:completeAnimation()
			f15_arg0.label:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.label)
		end,
	},
	Disabled = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.label:completeAnimation()
			f16_arg0.label:setRGB(0.5, 0.5, 0.5)
			f16_arg0.label:setAlpha(0.5)
			f16_arg0.clipFinished(f16_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.label:completeAnimation()
			f17_arg0.label:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.label)
		end,
		Hide = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.label:completeAnimation()
			f18_arg0.label:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.label)
		end,
		Focus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.label:completeAnimation()
			f19_arg0.label:setRGB(0.87, 0.37, 0)
			f19_arg0.clipFinished(f19_arg0.label)
		end,
		DefaultState = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.label:beginAnimation(200)
				f20_arg0.label:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.label:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.label:completeAnimation()
			f20_arg0.label:setAlpha(1)
			f20_local0(f20_arg0.label)
		end,
	},
	DefaultStateGamepad = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.label:completeAnimation()
			f22_arg0.label:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.label)
		end,
	},
}
CoD.WarzoneQuickInventoryPromptInternal.__onClose = function(f23_arg0)
	f23_arg0.label:close()
end
