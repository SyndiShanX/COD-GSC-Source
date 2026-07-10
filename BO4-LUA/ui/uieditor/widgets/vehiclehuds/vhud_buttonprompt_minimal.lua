require("x64:34778f864da9dda")
CoD.vhud_ButtonPrompt_Minimal = InheritFrom(LUI.UIElement)
CoD.vhud_ButtonPrompt_Minimal.__defaultWidth = 175
CoD.vhud_ButtonPrompt_Minimal.__defaultHeight = 50
CoD.vhud_ButtonPrompt_Minimal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ButtonPrompt_Minimal)
	self.id = "vhud_ButtonPrompt_Minimal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local prompt = LUI.UIText.new(0, 0, 58, 358, 0, 0, 16.5, 33.5)
	prompt:setTTF("ttmussels_regular")
	prompt:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3B0AEA8900F97CFB"))
	prompt:setShaderVector(0, 0, 0, 0, 0)
	prompt:setShaderVector(1, 0, 0, 0, 0)
	prompt:setShaderVector(2, 0.6, 0, 0, 0)
	prompt:setLetterSpacing(0.5)
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	prompt:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			prompt:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(prompt)
	self.prompt = prompt
	local button = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -21, 15)
	button:setScale(0.65, 0.65)
	self:addElement(button)
	self.button = button
	local bind = LUI.UIText.new(0.5, 0.5, -75, -35, 0.5, 0.5, -23, 13)
	bind:setTTF("default")
	bind:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	bind:linkToElementModel(self, "bind", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			bind:setText(f3_local0)
		end
	end)
	self:addElement(bind)
	self.bind = bind
	local triangle = LUI.UIImage.new(0.5, 0.5, -32, 32, 0, 0, -14, 50)
	triangle:setRGB(0.62, 0.61, 0.61)
	triangle:setScale(0.15, 0.15)
	triangle:setImage(RegisterImage(@"uie_ui_menu_draft_triangle"))
	self:addElement(triangle)
	self.triangle = triangle
	local ControllerDependentTextBox = nil
	ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0, 0, 32, 121, 0, 0, -25.5, -3.5)
	ControllerDependentTextBox:setAlpha(0)
	ControllerDependentTextBox.GamepadText:setText("")
	ControllerDependentTextBox:linkToElementModel(self, "bind", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ControllerDependentTextBox.KBMText:setText(f4_local0)
		end
	end)
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	self:mergeStateConditions({
		{
			stateName = "NotInUse",
			condition = function(menu, element, event)
				local f5_local0
				if not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "text") then
					f5_local0 = not IsPC()
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "Codcaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "CoolingDownHideButton",
			condition = function(menu, element, event)
				local f8_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bind")
				if f8_local0 then
					f8_local0 = CoD.ModelUtility.IsSelfModelPathValueLessThan(element, f1_arg1, "cooldown->cooldown", 1)
					if f8_local0 then
						f8_local0 = not IsPC()
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "hideButtonImage",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bind") and not IsPC()
			end,
		},
		{
			stateName = "CoolingDown",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueLessThan(element, f1_arg1, "cooldown->cooldown", 1) and not IsPC()
			end,
		},
		{
			stateName = "HideTriangle",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ChooseClassPCGamepad",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "text", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["factions.isCoDCaster"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	self:linkToElementModel(self, "bind", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	self:linkToElementModel(self, "cooldown", true, function(model)
		if self["__stateValidation_cooldown->cooldown"] then
			self:removeSubscription(self["__stateValidation_cooldown->cooldown"])
			self["__stateValidation_cooldown->cooldown"] = nil
		end
		if model then
			local f16_local0 = model:get()
			local f16_local1 = model:get()
			model = f16_local0 and f16_local1.cooldown
		end
		if model then
			self["__stateValidation_cooldown->cooldown"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "cooldown->cooldown",
				})
			end)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	f1_local7 = bind
	if IsPC() then
		ReplaceElementWithFake(self, "bind")
	end
	return self
end
CoD.vhud_ButtonPrompt_Minimal.__resetProperties = function(f18_arg0)
	f18_arg0.triangle:completeAnimation()
	f18_arg0.button:completeAnimation()
	f18_arg0.prompt:completeAnimation()
	f18_arg0.bind:completeAnimation()
	f18_arg0.ControllerDependentTextBox:completeAnimation()
	f18_arg0.triangle:setTopBottom(0, 0, -14, 50)
	f18_arg0.triangle:setAlpha(1)
	f18_arg0.button:setLeftRight(0.5, 0.5, -20, 20)
	f18_arg0.button:setTopBottom(0.5, 0.5, -21, 15)
	f18_arg0.button:setRGB(1, 1, 1)
	f18_arg0.button:setAlpha(1)
	f18_arg0.prompt:setLeftRight(0, 0, 58, 358)
	f18_arg0.prompt:setTopBottom(0, 0, 16.5, 33.5)
	f18_arg0.prompt:setRGB(1, 1, 1)
	f18_arg0.prompt:setAlpha(1)
	f18_arg0.prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f18_arg0.bind:setRGB(1, 1, 1)
	f18_arg0.bind:setAlpha(1)
	f18_arg0.ControllerDependentTextBox:setAlpha(0)
end
CoD.vhud_ButtonPrompt_Minimal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.prompt:completeAnimation()
			f19_arg0.prompt:setLeftRight(0.5, 0.5, -16, 284)
			f19_arg0.prompt:setTopBottom(0.5, 0.5, -11.5, 5.5)
			f19_arg0.clipFinished(f19_arg0.prompt)
			f19_arg0.button:completeAnimation()
			f19_arg0.button:setLeftRight(0.5, 0.5, -55, -15)
			f19_arg0.button:setTopBottom(0.5, 0.5, -23, 17)
			f19_arg0.clipFinished(f19_arg0.button)
			f19_arg0.triangle:completeAnimation()
			f19_arg0.triangle:setTopBottom(0, 0, 4, 68)
			f19_arg0.triangle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.triangle)
		end,
	},
	NotInUse = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.prompt:completeAnimation()
			f20_arg0.prompt:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.prompt)
			f20_arg0.button:completeAnimation()
			f20_arg0.button:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.button)
			f20_arg0.bind:completeAnimation()
			f20_arg0.bind:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.bind)
			f20_arg0.triangle:completeAnimation()
			f20_arg0.triangle:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.triangle)
			f20_arg0.ControllerDependentTextBox:completeAnimation()
			f20_arg0.ControllerDependentTextBox:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ControllerDependentTextBox)
		end,
	},
	Codcaster = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(5)
			f21_arg0.prompt:completeAnimation()
			f21_arg0.prompt:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.prompt)
			f21_arg0.button:completeAnimation()
			f21_arg0.button:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.button)
			f21_arg0.bind:completeAnimation()
			f21_arg0.bind:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.bind)
			f21_arg0.triangle:completeAnimation()
			f21_arg0.triangle:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.triangle)
			f21_arg0.ControllerDependentTextBox:completeAnimation()
			f21_arg0.ControllerDependentTextBox:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ControllerDependentTextBox)
		end,
	},
	PC = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.prompt:completeAnimation()
			f22_arg0.prompt:setLeftRight(0.5, 0.5, -87, 87)
			f22_arg0.prompt:setTopBottom(0.5, 0.5, -5.5, 11.5)
			f22_arg0.prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f22_arg0.clipFinished(f22_arg0.prompt)
			f22_arg0.button:completeAnimation()
			f22_arg0.button:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.button)
			f22_arg0.bind:completeAnimation()
			f22_arg0.bind:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.bind)
			f22_arg0.triangle:completeAnimation()
			f22_arg0.triangle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.triangle)
			f22_arg0.ControllerDependentTextBox:completeAnimation()
			f22_arg0.ControllerDependentTextBox:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.ControllerDependentTextBox)
		end,
	},
	CoolingDownHideButton = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.prompt:completeAnimation()
			f23_arg0.prompt:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.prompt)
			f23_arg0.button:completeAnimation()
			f23_arg0.button:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.button)
			f23_arg0.bind:completeAnimation()
			f23_arg0.bind:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.bind)
			f23_arg0.triangle:completeAnimation()
			f23_arg0.triangle:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.triangle)
		end,
	},
	hideButtonImage = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.button:completeAnimation()
			f24_arg0.button:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.button)
			f24_arg0.triangle:completeAnimation()
			f24_arg0.triangle:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.triangle)
		end,
	},
	CoolingDown = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			f25_arg0.prompt:completeAnimation()
			f25_arg0.prompt:setRGB(0, 0, 0)
			f25_arg0.clipFinished(f25_arg0.prompt)
			f25_arg0.button:completeAnimation()
			f25_arg0.button:setRGB(0, 0, 0)
			f25_arg0.clipFinished(f25_arg0.button)
			f25_arg0.bind:completeAnimation()
			f25_arg0.bind:setRGB(0.4, 0.4, 0.4)
			f25_arg0.clipFinished(f25_arg0.bind)
			f25_arg0.triangle:completeAnimation()
			f25_arg0.triangle:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.triangle)
		end,
	},
	HideTriangle = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.prompt:completeAnimation()
			f26_arg0.prompt:setLeftRight(0.5, 0.5, -16, 284)
			f26_arg0.prompt:setTopBottom(0.5, 0.5, -11.5, 5.5)
			f26_arg0.clipFinished(f26_arg0.prompt)
			f26_arg0.button:completeAnimation()
			f26_arg0.button:setLeftRight(0.5, 0.5, -55, -15)
			f26_arg0.button:setTopBottom(0.5, 0.5, -23, 17)
			f26_arg0.clipFinished(f26_arg0.button)
			f26_arg0.triangle:completeAnimation()
			f26_arg0.triangle:setTopBottom(0, 0, 4, 68)
			f26_arg0.clipFinished(f26_arg0.triangle)
		end,
	},
	ChooseClassPCGamepad = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.prompt:completeAnimation()
			f27_arg0.prompt:setLeftRight(0.5, 0.5, -16, 284)
			f27_arg0.prompt:setTopBottom(0.5, 0.5, -11.5, 5.5)
			f27_arg0.clipFinished(f27_arg0.prompt)
			f27_arg0.button:completeAnimation()
			f27_arg0.button:setLeftRight(0.5, 0.5, -55, -15)
			f27_arg0.button:setTopBottom(0.5, 0.5, -23, 17)
			f27_arg0.clipFinished(f27_arg0.button)
			f27_arg0.triangle:completeAnimation()
			f27_arg0.triangle:setTopBottom(0, 0, 4, 68)
			f27_arg0.triangle:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.triangle)
			f27_arg0.ControllerDependentTextBox:completeAnimation()
			f27_arg0.ControllerDependentTextBox:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ControllerDependentTextBox)
		end,
	},
}
CoD.vhud_ButtonPrompt_Minimal.__onClose = function(f28_arg0)
	f28_arg0.prompt:close()
	f28_arg0.bind:close()
	f28_arg0.ControllerDependentTextBox:close()
end
