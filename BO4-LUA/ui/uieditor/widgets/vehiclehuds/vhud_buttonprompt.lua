require("x64:e09bcc7e0af69ad")
CoD.vhud_ButtonPrompt = InheritFrom(LUI.UIElement)
CoD.vhud_ButtonPrompt.__defaultWidth = 129
CoD.vhud_ButtonPrompt.__defaultHeight = 129
CoD.vhud_ButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ButtonPrompt)
	self.id = "vhud_ButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local prompt = LUI.UIText.new(0.5, 0.5, -150, 150, 0.5, 0.5, 7.5, 24.5)
	prompt:setTTF("ttmussels_regular")
	prompt:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3B0AEA8900F97CFB"))
	prompt:setShaderVector(0, 0, 0, 0, 0)
	prompt:setShaderVector(1, 0, 0, 0, 0)
	prompt:setShaderVector(2, 0.6, 0, 0, 0)
	prompt:setLetterSpacing(0.5)
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	prompt:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			prompt:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(prompt)
	self.prompt = prompt
	local button0 = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -37.5, -1.5)
	button0:setAlpha(0.1)
	self:addElement(button0)
	self.button0 = button0
	local button1 = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -37.5, -1.5)
	button1:setAlpha(0.15)
	button1:setZoom(15)
	self:addElement(button1)
	self.button1 = button1
	local button = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -37.5, -1.5)
	button:setAlpha(0.65)
	button:setZoom(15)
	self:addElement(button)
	self.button = button
	local bind = LUI.UIText.new(0.5, 0.5, -20, 20, 0.5, 0.5, -37.5, -1.5)
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
	local backing = CoD.vhud_ms_ButtonWidgetCooldown.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0, 0, 94, 104)
	backing:linkToElementModel(self, "cooldown", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			backing:setModel(f4_local0, f1_arg1)
		end
	end)
	self:addElement(backing)
	self.backing = backing
	self:mergeStateConditions({
		{
			stateName = "NotInUse",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "text")
			end,
		},
		{
			stateName = "CoolingDownHideButton",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bind") and CoD.ModelUtility.IsSelfModelPathValueLessThan(element, f1_arg1, "cooldown->cooldown", 1)
			end,
		},
		{
			stateName = "hideButtonImage",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bind")
			end,
		},
		{
			stateName = "CoolingDown",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueLessThan(element, f1_arg1, "cooldown->cooldown", 1)
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
			local f11_local0 = model:get()
			local f11_local1 = model:get()
			model = f11_local0 and f11_local1.cooldown
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
	local f1_local7 = self
	if IsPC() then
		SizeToHudArea(f1_local7, f1_arg1)
	end
	return self
end
CoD.vhud_ButtonPrompt.__resetProperties = function(f13_arg0)
	f13_arg0.prompt:completeAnimation()
	f13_arg0.button0:completeAnimation()
	f13_arg0.button1:completeAnimation()
	f13_arg0.button:completeAnimation()
	f13_arg0.backing:completeAnimation()
	f13_arg0.bind:completeAnimation()
	f13_arg0.prompt:setRGB(1, 1, 1)
	f13_arg0.prompt:setAlpha(1)
	f13_arg0.button0:setRGB(1, 1, 1)
	f13_arg0.button0:setAlpha(0.1)
	f13_arg0.button1:setRGB(1, 1, 1)
	f13_arg0.button1:setAlpha(0.15)
	f13_arg0.button:setRGB(1, 1, 1)
	f13_arg0.button:setAlpha(0.65)
	f13_arg0.button:setScale(1, 1)
	f13_arg0.backing:setAlpha(1)
	f13_arg0.bind:setRGB(1, 1, 1)
end
CoD.vhud_ButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	NotInUse = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.prompt:completeAnimation()
			f15_arg0.prompt:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.prompt)
			f15_arg0.button0:completeAnimation()
			f15_arg0.button0:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.button0)
			f15_arg0.button1:completeAnimation()
			f15_arg0.button1:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.button1)
			f15_arg0.button:completeAnimation()
			f15_arg0.button:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.button)
			f15_arg0.backing:completeAnimation()
			f15_arg0.backing:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.backing)
		end,
	},
	CoolingDownHideButton = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(5)
			f16_arg0.prompt:completeAnimation()
			f16_arg0.prompt:setRGB(0.4, 0.4, 0.4)
			f16_arg0.clipFinished(f16_arg0.prompt)
			f16_arg0.button0:completeAnimation()
			f16_arg0.button0:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.button0)
			f16_arg0.button1:completeAnimation()
			f16_arg0.button1:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.button1)
			f16_arg0.button:completeAnimation()
			f16_arg0.button:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.button)
			f16_arg0.bind:completeAnimation()
			f16_arg0.bind:setRGB(0.61, 0.61, 0.61)
			f16_arg0.clipFinished(f16_arg0.bind)
		end,
	},
	hideButtonImage = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.button0:completeAnimation()
			f17_arg0.button0:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.button0)
			f17_arg0.button1:completeAnimation()
			f17_arg0.button1:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.button1)
			f17_arg0.button:completeAnimation()
			f17_arg0.button:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.button)
		end,
	},
	CoolingDown = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(5)
			f18_arg0.prompt:completeAnimation()
			f18_arg0.prompt:setRGB(0.4, 0.4, 0.4)
			f18_arg0.clipFinished(f18_arg0.prompt)
			f18_arg0.button0:completeAnimation()
			f18_arg0.button0:setRGB(0.61, 0.61, 0.61)
			f18_arg0.clipFinished(f18_arg0.button0)
			f18_arg0.button1:completeAnimation()
			f18_arg0.button1:setRGB(0.61, 0.61, 0.61)
			f18_arg0.clipFinished(f18_arg0.button1)
			f18_arg0.button:completeAnimation()
			f18_arg0.button:setRGB(0.61, 0.61, 0.61)
			f18_arg0.clipFinished(f18_arg0.button)
			f18_arg0.bind:completeAnimation()
			f18_arg0.bind:setRGB(0.61, 0.61, 0.61)
			f18_arg0.clipFinished(f18_arg0.bind)
		end,
		DefaultState = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(99)
					f21_arg0:setAlpha(0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.button:beginAnimation(300)
				f19_arg0.button:setAlpha(0.3)
				f19_arg0.button:setScale(2.25, 2.25)
				f19_arg0.button:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.button:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.button:completeAnimation()
			f19_arg0.button:setRGB(0.92, 0.91, 0.04)
			f19_arg0.button:setAlpha(0.8)
			f19_arg0.button:setScale(1, 1)
			f19_local0(f19_arg0.button)
		end,
	},
}
CoD.vhud_ButtonPrompt.__onClose = function(f22_arg0)
	f22_arg0.prompt:close()
	f22_arg0.bind:close()
	f22_arg0.backing:close()
end
