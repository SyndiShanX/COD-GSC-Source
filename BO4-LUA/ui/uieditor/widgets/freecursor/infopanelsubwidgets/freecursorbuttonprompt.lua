require("x64:b10e5cd828cc66e")
require("x64:29187ea00d726c3")
require("x64:246178cf189051b")
CoD.freeCursorButtonPrompt = InheritFrom(LUI.UIElement)
CoD.freeCursorButtonPrompt.__defaultWidth = 150
CoD.freeCursorButtonPrompt.__defaultHeight = 36
CoD.freeCursorButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, true)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.freeCursorButtonPrompt)
	self.id = "freeCursorButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.06, 0.06, 0.06)
	self:addElement(backing)
	self.backing = backing
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 4, 0.5, 0.5, -18, 18)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local keyPrompt = nil
	keyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0.03, 0.03, 2.5, 28.5, 0.5, 0.5, -13.5, 13.5)
	keyPrompt:setAlpha(0)
	keyPrompt.Border.FETitleNumBrdr00.Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	keyPrompt.keybind.__KeyBind = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			keyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized(UpdateKeyShortcutsButtonPrompts(self, f1_arg1, f2_local0)))
		end
	end
	keyPrompt:linkToElementModel(self, "Label", true, keyPrompt.keybind.__KeyBind)
	keyPrompt.keybind.__KeyBind_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.Label
		end
		if f3_local0 then
			keyPrompt.keybind.__KeyBind(f3_local0)
		end
	end
	self:addElement(keyPrompt)
	self.keyPrompt = keyPrompt
	local button = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 37, 73, 0, 0, 0, 36)
	button.backing:setRGB(0.06, 0.06, 0.06)
	button:linkToElementModel(self, nil, false, function(model)
		button:setModel(model, f1_arg1)
	end)
	self:addElement(button)
	self.button = button
	local Spacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 77, 78, 0.5, 0.5, -18, 18)
	self:addElement(Spacer3)
	self.Spacer3 = Spacer3
	local label = LUI.UIText.new(0, 0, 82, 151, 0, 0, 8, 26)
	label:setRGB(0.92, 0.92, 0.92)
	label:setTTF("ttmussels_demibold")
	label:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	label:setLetterSpacing(4)
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	label:linkToElementModel(self, "Label", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			label:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(label)
	self.label = label
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 155, 157, 0.5, 0.5, -18, 18)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	keyPrompt:appendEventHandler("input_source_changed", keyPrompt.keybind.__KeyBind_FullPath)
	local f1_local8 = keyPrompt
	local f1_local9 = keyPrompt.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, keyPrompt.keybind.__KeyBind_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"])
				if f6_local0 then
					f6_local0 = IsGamepad(f1_arg1)
					if f6_local0 then
						f6_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"bpf_contextual"])
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f7_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"])
				if f7_local0 then
					f7_local0 = IsGamepad(f1_arg1)
					if f7_local0 then
						f7_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"bpf_contextual"])
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "DisabledPC",
			condition = function(menu, element, event)
				local f8_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"])
				if f8_local0 then
					if not IsGamepad(f1_arg1) and not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f8_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"bpf_contextual"])
						if f8_local0 then
							f8_local0 = IsPC()
						end
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "EnabledPC",
			condition = function(menu, element, event)
				local f9_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"])
				if f9_local0 then
					if not IsGamepad(f1_arg1) and not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f9_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"bpf_contextual"])
						if f9_local0 then
							f9_local0 = IsPC()
						end
					else
						f9_local0 = false
					end
				end
				return f9_local0
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
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f11_arg1)
	end)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		if IsInDefaultState(self) and IsMouseOrKeyboard(controller) then
			DisableMouseButton(self, controller)
			HideWidget(element)
			CoD.FreeCursorUtility.UpdateContextualPromptModelPC(self, controller)
		elseif IsMouseOrKeyboard(controller) then
			EnableMouseButton(self, controller)
			ShowWidget(element)
			CoD.FreeCursorUtility.UpdateContextualPromptModelPC(self, controller)
		elseif IsInDefaultState(self) and IsGamepad(controller) then
			DisableMouseButton(self, controller)
			HideWidget(self)
		elseif IsGamepad(controller) then
			EnableMouseButton(self, controller)
			ShowWidget(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	if IsPC() then
		CoD.PCUtility.SetupButtonPromptForPC(self, f1_arg1, f1_arg0)
		CoD.FreeCursorUtility.UseLocalHeight(self)
		CoD.FreeCursorUtility.SetupHideContextualPromptPC(f1_local9, f1_arg1)
	else
		CoD.FreeCursorUtility.UseLocalHeight(self)
	end
	return self
end
CoD.freeCursorButtonPrompt.__resetProperties = function(f15_arg0)
	f15_arg0.label:completeAnimation()
	f15_arg0.keyPrompt:completeAnimation()
	f15_arg0.button:completeAnimation()
	f15_arg0.backing:completeAnimation()
	f15_arg0.label:setTopBottom(0, 0, 8, 26)
	f15_arg0.label:setRGB(0.92, 0.92, 0.92)
	f15_arg0.label:setAlpha(1)
	f15_arg0.label:setLetterSpacing(4)
	f15_arg0.keyPrompt:setTopBottom(0.5, 0.5, -13.5, 13.5)
	f15_arg0.keyPrompt:setAlpha(0)
	f15_arg0.button:setLeftRight(0, 0, 37, 73)
	f15_arg0.button:setTopBottom(0, 0, 0, 36)
	f15_arg0.backing:setAlpha(1)
end
CoD.freeCursorButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.label:completeAnimation()
			f16_arg0.label:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.label)
		end,
	},
	Disabled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.label:completeAnimation()
			f17_arg0.label:setRGB(0.5, 0.5, 0.5)
			f17_arg0.label:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.label:completeAnimation()
			f18_arg0.label:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.label)
		end,
		Hide = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.label:completeAnimation()
			f19_arg0.label:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.label)
		end,
		Focus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.label:completeAnimation()
			f20_arg0.label:setRGB(0.87, 0.37, 0)
			f20_arg0.clipFinished(f20_arg0.label)
		end,
		DefaultState = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.label:beginAnimation(200)
				f21_arg0.label:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.label:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.label:completeAnimation()
			f21_arg0.label:setAlpha(1)
			f21_local0(f21_arg0.label)
		end,
	},
	DisabledPC = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.keyPrompt:completeAnimation()
			f23_arg0.keyPrompt:setAlpha(0.5)
			f23_arg0.clipFinished(f23_arg0.keyPrompt)
			f23_arg0.label:completeAnimation()
			f23_arg0.label:setRGB(0.5, 0.5, 0.5)
			f23_arg0.label:setAlpha(0.5)
			f23_arg0.clipFinished(f23_arg0.label)
		end,
	},
	EnabledPC = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.backing:completeAnimation()
			f24_arg0.backing:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.backing)
			f24_arg0.keyPrompt:completeAnimation()
			f24_arg0.keyPrompt:setTopBottom(0.5, 0.5, -12, 12)
			f24_arg0.keyPrompt:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.keyPrompt)
			f24_arg0.button:completeAnimation()
			f24_arg0.button:setLeftRight(0, 0, 37, 69)
			f24_arg0.button:setTopBottom(0.5, 0.5, -16, 16)
			f24_arg0.clipFinished(f24_arg0.button)
			f24_arg0.label:completeAnimation()
			f24_arg0.label:setTopBottom(0.5, 0.5, -8, 8)
			f24_arg0.label:setLetterSpacing(3)
			f24_arg0.clipFinished(f24_arg0.label)
		end,
		Hide = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.label:completeAnimation()
			f25_arg0.label:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.label)
		end,
		Focus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.label:completeAnimation()
			f26_arg0.label:setRGB(0.87, 0.37, 0)
			f26_arg0.clipFinished(f26_arg0.label)
		end,
	},
}
CoD.freeCursorButtonPrompt.__onClose = function(f27_arg0)
	f27_arg0.Spacer:close()
	f27_arg0.keyPrompt:close()
	f27_arg0.button:close()
	f27_arg0.Spacer3:close()
	f27_arg0.label:close()
	f27_arg0.Spacer2:close()
end
