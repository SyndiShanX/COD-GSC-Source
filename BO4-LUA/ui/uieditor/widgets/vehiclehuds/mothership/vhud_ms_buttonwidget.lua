require("x64:18839db83d2cd93")
require("x64:e09bcc7e0af69ad")
CoD.vhud_ms_ButtonWidget = InheritFrom(LUI.UIElement)
CoD.vhud_ms_ButtonWidget.__defaultWidth = 129
CoD.vhud_ms_ButtonWidget.__defaultHeight = 163
CoD.vhud_ms_ButtonWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_ButtonWidget)
	self.id = "vhud_ms_ButtonWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backinglines = CoD.vhud_button_backing_lines.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 55, 0.5, 0.5, -59, 51)
	backinglines:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.bindings.color", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			backinglines:setRGB(f2_local0)
		end
	end)
	self:addElement(backinglines)
	self.backinglines = backinglines
	local prompt = LUI.UIText.new(0.5, 0.5, -150, 150, 0.5, 0.5, 40, 64)
	prompt:setTTF("dinnext_regular")
	prompt:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	prompt:setShaderVector(0, 0, 0, 0, 0)
	prompt:setShaderVector(1, 0, 0, 0, 0)
	prompt:setShaderVector(2, 1, 0, 0, 0)
	prompt:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	prompt:setLetterSpacing(0.5)
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	prompt:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			prompt:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(prompt)
	self.prompt = prompt
	local button0 = LUI.UIImage.new(0.5, 0.5, -20, 21, 0.5, 0.5, -16, 23)
	button0:setAlpha(0.1)
	button0:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scanlines_add"))
	button0:setShaderVector(0, 2.91, 0, 0, 0)
	button0:setShaderVector(1, 1, 0, 0, 0)
	button0:setShaderVector(2, 0.03, 0, 0, 0)
	self:addElement(button0)
	self.button0 = button0
	local button1 = LUI.UIImage.new(0.5, 0.5, -20, 21, 0.5, 0.5, -17, 22)
	button1:setAlpha(0.15)
	button1:setZoom(15)
	button1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(button1)
	self.button1 = button1
	local button = LUI.UIImage.new(0.5, 0.5, -20, 21, 0.5, 0.5, -17, 22)
	button:setAlpha(0.65)
	button:setZoom(15)
	button:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(button)
	self.button = button
	local bind = LUI.UIText.new(0.5, 0.5, -20, 20, 0.5, 0.5, -20, 20)
	bind:setTTF("default")
	bind:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	bind:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	bind:linkToElementModel(self, "bind", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			bind:setText(f4_local0)
		end
	end)
	self:addElement(bind)
	self.bind = bind
	local backing = CoD.vhud_ms_ButtonWidgetCooldown.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0, 0, 145.5, 155.5)
	backing:linkToElementModel(self, "cooldown", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			backing:setModel(f5_local0, f1_arg1)
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
			local f12_local0 = model:get()
			local f12_local1 = model:get()
			model = f12_local0 and f12_local1.cooldown
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
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_ButtonWidget.__resetProperties = function(f14_arg0)
	f14_arg0.prompt:completeAnimation()
	f14_arg0.button0:completeAnimation()
	f14_arg0.button1:completeAnimation()
	f14_arg0.button:completeAnimation()
	f14_arg0.backinglines:completeAnimation()
	f14_arg0.backing:completeAnimation()
	f14_arg0.bind:completeAnimation()
	f14_arg0.prompt:setRGB(1, 1, 1)
	f14_arg0.prompt:setAlpha(1)
	f14_arg0.button0:setRGB(1, 1, 1)
	f14_arg0.button0:setAlpha(0.1)
	f14_arg0.button1:setRGB(1, 1, 1)
	f14_arg0.button1:setAlpha(0.15)
	f14_arg0.button:setRGB(1, 1, 1)
	f14_arg0.button:setAlpha(0.65)
	f14_arg0.button:setScale(1, 1)
	f14_arg0.backinglines:setAlpha(1)
	f14_arg0.backing:setAlpha(1)
	f14_arg0.bind:setRGB(1, 1, 1)
end
CoD.vhud_ms_ButtonWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	NotInUse = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(6)
			f16_arg0.backinglines:completeAnimation()
			f16_arg0.backinglines:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.backinglines)
			f16_arg0.prompt:completeAnimation()
			f16_arg0.prompt:setAlpha(0)
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
			f16_arg0.backing:completeAnimation()
			f16_arg0.backing:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.backing)
		end,
	},
	CoolingDownHideButton = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			f17_arg0.prompt:completeAnimation()
			f17_arg0.prompt:setRGB(0.4, 0.4, 0.4)
			f17_arg0.clipFinished(f17_arg0.prompt)
			f17_arg0.button0:completeAnimation()
			f17_arg0.button0:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.button0)
			f17_arg0.button1:completeAnimation()
			f17_arg0.button1:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.button1)
			f17_arg0.button:completeAnimation()
			f17_arg0.button:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.button)
			f17_arg0.bind:completeAnimation()
			f17_arg0.bind:setRGB(0.61, 0.61, 0.61)
			f17_arg0.clipFinished(f17_arg0.bind)
		end,
	},
	hideButtonImage = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.button0:completeAnimation()
			f18_arg0.button0:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.button0)
			f18_arg0.button1:completeAnimation()
			f18_arg0.button1:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.button1)
			f18_arg0.button:completeAnimation()
			f18_arg0.button:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.button)
		end,
	},
	CoolingDown = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.prompt:completeAnimation()
			f19_arg0.prompt:setRGB(0.4, 0.4, 0.4)
			f19_arg0.clipFinished(f19_arg0.prompt)
			f19_arg0.button0:completeAnimation()
			f19_arg0.button0:setRGB(0.61, 0.61, 0.61)
			f19_arg0.clipFinished(f19_arg0.button0)
			f19_arg0.button1:completeAnimation()
			f19_arg0.button1:setRGB(0.61, 0.61, 0.61)
			f19_arg0.clipFinished(f19_arg0.button1)
			f19_arg0.button:completeAnimation()
			f19_arg0.button:setRGB(0.61, 0.61, 0.61)
			f19_arg0.clipFinished(f19_arg0.button)
			f19_arg0.bind:completeAnimation()
			f19_arg0.bind:setRGB(0.61, 0.61, 0.61)
			f19_arg0.clipFinished(f19_arg0.bind)
		end,
		DefaultState = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(99)
					f22_arg0:setAlpha(0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.button:beginAnimation(300)
				f20_arg0.button:setAlpha(0.3)
				f20_arg0.button:setScale(2.25, 2.25)
				f20_arg0.button:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.button:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.button:completeAnimation()
			f20_arg0.button:setRGB(0.92, 0.91, 0.04)
			f20_arg0.button:setAlpha(0.8)
			f20_arg0.button:setScale(1, 1)
			f20_local0(f20_arg0.button)
		end,
	},
}
CoD.vhud_ms_ButtonWidget.__onClose = function(f23_arg0)
	f23_arg0.backinglines:close()
	f23_arg0.prompt:close()
	f23_arg0.bind:close()
	f23_arg0.backing:close()
end
