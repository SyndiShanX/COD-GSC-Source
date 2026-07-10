require("x64:9ef8e7ef66dcc85")
require("x64:34778f864da9dda")
CoD.vhud_hellstorm_button_layout = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_button_layout.__defaultWidth = 1920
CoD.vhud_hellstorm_button_layout.__defaultHeight = 1080
CoD.vhud_hellstorm_button_layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_button_layout)
	self.id = "vhud_hellstorm_button_layout"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KBMClusterBombActionName = nil
	KBMClusterBombActionName = LUI.UIText.new(0.5, 0.5, -583, -283, 1, 1, -159, -143)
	KBMClusterBombActionName:setAlpha(0)
	KBMClusterBombActionName:setText(Engine[0xF9F1239CFD921FE](0x6368EB0A070207A))
	KBMClusterBombActionName:setTTF("ttmussels_regular")
	KBMClusterBombActionName:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	KBMClusterBombActionName:setShaderVector(0, 0, 0, 0, 0)
	KBMClusterBombActionName:setShaderVector(1, 0, 0, 0, 0)
	KBMClusterBombActionName:setShaderVector(2, 1, 0, 0, 0)
	KBMClusterBombActionName:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	KBMClusterBombActionName:setLetterSpacing(0.5)
	KBMClusterBombActionName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KBMClusterBombActionName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KBMClusterBombActionName)
	self.KBMClusterBombActionName = KBMClusterBombActionName
	local KBMClusterBombPrompt = nil
	KBMClusterBombPrompt = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -474, -385, 1, 1, -203.5, -181.5)
	KBMClusterBombPrompt:setAlpha(0)
	KBMClusterBombPrompt.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+attack}]"))
	KBMClusterBombPrompt.GamepadText:setText("")
	self:addElement(KBMClusterBombPrompt)
	self.KBMClusterBombPrompt = KBMClusterBombPrompt
	local KBMSlowDownActionName = nil
	KBMSlowDownActionName = LUI.UIText.new(0.5, 0.5, 278.5, 578.5, 1, 1, -159, -143)
	KBMSlowDownActionName:setAlpha(0)
	KBMSlowDownActionName:setText(Engine[0xF9F1239CFD921FE](0xB1A03F2448A49D9))
	KBMSlowDownActionName:setTTF("ttmussels_regular")
	KBMSlowDownActionName:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	KBMSlowDownActionName:setShaderVector(0, 0, 0, 0, 0)
	KBMSlowDownActionName:setShaderVector(1, 0, 0, 0, 0)
	KBMSlowDownActionName:setShaderVector(2, 1, 0, 0, 0)
	KBMSlowDownActionName:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	KBMSlowDownActionName:setLetterSpacing(0.5)
	KBMSlowDownActionName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KBMSlowDownActionName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KBMSlowDownActionName)
	self.KBMSlowDownActionName = KBMSlowDownActionName
	local KBMSlowDownPrompt = nil
	KBMSlowDownPrompt = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, 384, 473, 1, 1, -203.5, -181.5)
	KBMSlowDownPrompt:setAlpha(0)
	KBMSlowDownPrompt.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+speed_throw}]"))
	KBMSlowDownPrompt.GamepadText:setText("")
	self:addElement(KBMSlowDownPrompt)
	self.KBMSlowDownPrompt = KBMSlowDownPrompt
	local KBMSpeedBoostActionName = nil
	KBMSpeedBoostActionName = LUI.UIText.new(0.5, 0.5, -150, 150, 1, 1, -112, -96)
	KBMSpeedBoostActionName:setAlpha(0)
	KBMSpeedBoostActionName:setText(Engine[0xF9F1239CFD921FE](0x9D336E3DD657B0A))
	KBMSpeedBoostActionName:setTTF("ttmussels_regular")
	KBMSpeedBoostActionName:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	KBMSpeedBoostActionName:setShaderVector(0, 0, 0, 0, 0)
	KBMSpeedBoostActionName:setShaderVector(1, 0, 0, 0, 0)
	KBMSpeedBoostActionName:setShaderVector(2, 1, 0, 0, 0)
	KBMSpeedBoostActionName:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	KBMSpeedBoostActionName:setLetterSpacing(0.5)
	KBMSpeedBoostActionName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KBMSpeedBoostActionName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KBMSpeedBoostActionName)
	self.KBMSpeedBoostActionName = KBMSpeedBoostActionName
	local KBMSpeedBoostPrompt = nil
	KBMSpeedBoostPrompt = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -44.5, 44.5, 1, 1, -156.5, -134.5)
	KBMSpeedBoostPrompt:setAlpha(0)
	KBMSpeedBoostPrompt.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+vehicleboost}]"))
	KBMSpeedBoostPrompt.GamepadText:setText("")
	self:addElement(KBMSpeedBoostPrompt)
	self.KBMSpeedBoostPrompt = KBMSpeedBoostPrompt
	local LeftTrigger = CoD.vhud_ButtonPrompt_Minimal.new(f1_arg0, f1_arg1, 0.5, 0.5, -518, -343, 1, 1, -176, -126)
	LeftTrigger:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC() and AlwaysFalse()
			end,
		},
	})
	LeftTrigger:linkToElementModel(LeftTrigger, "text", true, function(model)
		f1_arg0:updateElementState(LeftTrigger, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	local L3Button = LeftTrigger
	local RightTrigger = LeftTrigger.subscribeToModel
	local RightStick = Engine[0x4DF5CFBC1771947](f1_arg1)
	RightTrigger(L3Button, RightStick["factions.isCoDCaster"], function(f4_arg0)
		f1_arg0:updateElementState(LeftTrigger, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LeftTrigger:linkToElementModel(LeftTrigger, "bind", true, function(model)
		f1_arg0:updateElementState(LeftTrigger, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	LeftTrigger:linkToElementModel(LeftTrigger, "cooldown", true, function(model)
		if LeftTrigger["__stateValidation_cooldown->cooldown"] then
			LeftTrigger:removeSubscription(LeftTrigger["__stateValidation_cooldown->cooldown"])
			LeftTrigger["__stateValidation_cooldown->cooldown"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.cooldown
		end
		if model then
			LeftTrigger["__stateValidation_cooldown->cooldown"] = LeftTrigger:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(LeftTrigger, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "cooldown->cooldown",
				})
			end)
		end
	end)
	LeftTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_trigger_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			LeftTrigger.button:setImage(RegisterImage(f8_local0))
		end
	end)
	LeftTrigger:linkToElementModel(self, "BUTTON_LTRIG", false, function(model)
		LeftTrigger:setModel(model, f1_arg1)
	end)
	LeftTrigger:linkToElementModel(self, "BUTTON_LTRIG.text", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			LeftTrigger.prompt:setText(Engine[0xF9F1239CFD921FE](f10_local0))
		end
	end)
	self:addElement(LeftTrigger)
	self.LeftTrigger = LeftTrigger
	RightTrigger = CoD.vhud_ButtonPrompt_Minimal.new(f1_arg0, f1_arg1, 0.5, 0.5, 320, 495, 1, 1, -176, -126)
	RightTrigger:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC() and AlwaysFalse()
			end,
		},
	})
	RightTrigger:linkToElementModel(RightTrigger, "text", true, function(model)
		f1_arg0:updateElementState(RightTrigger, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	RightStick = RightTrigger
	L3Button = RightTrigger.subscribeToModel
	local f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	L3Button(RightStick, f1_local11["factions.isCoDCaster"], function(f13_arg0)
		f1_arg0:updateElementState(RightTrigger, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	RightTrigger:linkToElementModel(RightTrigger, "bind", true, function(model)
		f1_arg0:updateElementState(RightTrigger, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	RightTrigger:linkToElementModel(RightTrigger, "cooldown", true, function(model)
		if RightTrigger["__stateValidation_cooldown->cooldown"] then
			RightTrigger:removeSubscription(RightTrigger["__stateValidation_cooldown->cooldown"])
			RightTrigger["__stateValidation_cooldown->cooldown"] = nil
		end
		if model then
			local f15_local0 = model:get()
			local f15_local1 = model:get()
			model = f15_local0 and f15_local1.cooldown
		end
		if model then
			RightTrigger["__stateValidation_cooldown->cooldown"] = RightTrigger:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(RightTrigger, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "cooldown->cooldown",
				})
			end)
		end
	end)
	RightTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_trigger_button_image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			RightTrigger.button:setImage(RegisterImage(f17_local0))
		end
	end)
	RightTrigger:linkToElementModel(self, "BUTTON_RTRIG", false, function(model)
		RightTrigger:setModel(model, f1_arg1)
	end)
	RightTrigger:linkToElementModel(self, "BUTTON_RTRIG.text", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			RightTrigger.prompt:setText(Engine[0xF9F1239CFD921FE](f19_local0))
		end
	end)
	self:addElement(RightTrigger)
	self.RightTrigger = RightTrigger
	L3Button = CoD.vhud_ButtonPrompt_Minimal.new(f1_arg0, f1_arg1, 0.5, 0.5, -303, -128, 1, 1, -126, -76)
	L3Button:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC() and AlwaysFalse()
			end,
		},
	})
	L3Button:linkToElementModel(L3Button, "text", true, function(model)
		f1_arg0:updateElementState(L3Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	f1_local11 = L3Button
	RightStick = L3Button.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	RightStick(f1_local11, f1_local12["factions.isCoDCaster"], function(f22_arg0)
		f1_arg0:updateElementState(L3Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	L3Button:linkToElementModel(L3Button, "bind", true, function(model)
		f1_arg0:updateElementState(L3Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	L3Button:linkToElementModel(L3Button, "cooldown", true, function(model)
		if L3Button["__stateValidation_cooldown->cooldown"] then
			L3Button:removeSubscription(L3Button["__stateValidation_cooldown->cooldown"])
			L3Button["__stateValidation_cooldown->cooldown"] = nil
		end
		if model then
			local f24_local0 = model:get()
			local f24_local1 = model:get()
			model = f24_local0 and f24_local1.cooldown
		end
		if model then
			L3Button["__stateValidation_cooldown->cooldown"] = L3Button:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(L3Button, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "cooldown->cooldown",
				})
			end)
		end
	end)
	L3Button:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_stick_button_image", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			L3Button.button:setImage(RegisterImage(f26_local0))
		end
	end)
	L3Button:linkToElementModel(self, "BUTTON_LSTICK", false, function(model)
		L3Button:setModel(model, f1_arg1)
	end)
	L3Button:linkToElementModel(self, "BUTTON_LSTICK.text", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			L3Button.prompt:setText(Engine[0xF9F1239CFD921FE](f28_local0))
		end
	end)
	self:addElement(L3Button)
	self.L3Button = L3Button
	RightStick = CoD.vhud_ButtonPrompt_Minimal.new(f1_arg0, f1_arg1, 0.5, 0.5, 129, 304, 1, 1, -126, -76)
	RightStick:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC() and AlwaysFalse()
			end,
		},
	})
	RightStick:linkToElementModel(RightStick, "text", true, function(model)
		f1_arg0:updateElementState(RightStick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	f1_local12 = RightStick
	f1_local11 = RightStick.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local12, f1_local13["factions.isCoDCaster"], function(f31_arg0)
		f1_arg0:updateElementState(RightStick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	RightStick:linkToElementModel(RightStick, "bind", true, function(model)
		f1_arg0:updateElementState(RightStick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	RightStick:linkToElementModel(RightStick, "cooldown", true, function(model)
		if RightStick["__stateValidation_cooldown->cooldown"] then
			RightStick:removeSubscription(RightStick["__stateValidation_cooldown->cooldown"])
			RightStick["__stateValidation_cooldown->cooldown"] = nil
		end
		if model then
			local f33_local0 = model:get()
			local f33_local1 = model:get()
			model = f33_local0 and f33_local1.cooldown
		end
		if model then
			RightStick["__stateValidation_cooldown->cooldown"] = RightStick:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(RightStick, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "cooldown->cooldown",
				})
			end)
		end
	end)
	RightStick:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_stick_move_image", function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			RightStick.button:setImage(RegisterImage(f35_local0))
		end
	end)
	RightStick:linkToElementModel(self, "R_STICK", false, function(model)
		RightStick:setModel(model, f1_arg1)
	end)
	RightStick:linkToElementModel(self, "R_STICK.text", true, function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			RightStick.prompt:setText(Engine[0xF9F1239CFD921FE](f37_local0))
		end
	end)
	self:addElement(RightStick)
	self.RightStick = RightStick
	self:mergeStateConditions({
		{
			stateName = "KeyboardMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f39_arg0, f39_arg1)
		f39_arg1.menu = f39_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f39_arg1)
	end)
	f1_local12 = self
	f1_local11 = self.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local12, f1_local13.LastInput, function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	if IsPC() then
		SizeToHudArea(f1_local11, f1_arg1)
	end
	return self
end
CoD.vhud_hellstorm_button_layout.__resetProperties = function(f41_arg0)
	f41_arg0.RightStick:completeAnimation()
	f41_arg0.KBMSpeedBoostPrompt:completeAnimation()
	f41_arg0.KBMSpeedBoostActionName:completeAnimation()
	f41_arg0.KBMSlowDownPrompt:completeAnimation()
	f41_arg0.KBMSlowDownActionName:completeAnimation()
	f41_arg0.KBMClusterBombPrompt:completeAnimation()
	f41_arg0.KBMClusterBombActionName:completeAnimation()
	f41_arg0.LeftTrigger:completeAnimation()
	f41_arg0.RightTrigger:completeAnimation()
	f41_arg0.L3Button:completeAnimation()
	f41_arg0.RightStick:setLeftRight(0.5, 0.5, 129, 304)
	f41_arg0.RightStick:setTopBottom(1, 1, -126, -76)
	f41_arg0.RightStick:setAlpha(1)
	f41_arg0.KBMSpeedBoostPrompt:setAlpha(0)
	f41_arg0.KBMSpeedBoostActionName:setAlpha(0)
	f41_arg0.KBMSlowDownPrompt:setAlpha(0)
	f41_arg0.KBMSlowDownActionName:setAlpha(0)
	f41_arg0.KBMClusterBombPrompt:setAlpha(0)
	f41_arg0.KBMClusterBombActionName:setLeftRight(0.5, 0.5, -583, -283)
	f41_arg0.KBMClusterBombActionName:setAlpha(0)
	f41_arg0.LeftTrigger:setAlpha(1)
	f41_arg0.RightTrigger:setAlpha(1)
	f41_arg0.L3Button:setAlpha(1)
end
CoD.vhud_hellstorm_button_layout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(1)
			f42_arg0.RightStick:completeAnimation()
			f42_arg0.RightStick:setLeftRight(0.5, 0.5, 148, 323)
			f42_arg0.RightStick:setTopBottom(1, 1, -125, -75)
			f42_arg0.clipFinished(f42_arg0.RightStick)
		end,
	},
	KeyboardMouse = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(10)
			f43_arg0.KBMClusterBombActionName:completeAnimation()
			f43_arg0.KBMClusterBombActionName:setLeftRight(0.5, 0.5, -582, -282)
			f43_arg0.KBMClusterBombActionName:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.KBMClusterBombActionName)
			f43_arg0.KBMClusterBombPrompt:completeAnimation()
			f43_arg0.KBMClusterBombPrompt:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.KBMClusterBombPrompt)
			f43_arg0.KBMSlowDownActionName:completeAnimation()
			f43_arg0.KBMSlowDownActionName:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.KBMSlowDownActionName)
			f43_arg0.KBMSlowDownPrompt:completeAnimation()
			f43_arg0.KBMSlowDownPrompt:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.KBMSlowDownPrompt)
			f43_arg0.KBMSpeedBoostActionName:completeAnimation()
			f43_arg0.KBMSpeedBoostActionName:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.KBMSpeedBoostActionName)
			f43_arg0.KBMSpeedBoostPrompt:completeAnimation()
			f43_arg0.KBMSpeedBoostPrompt:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.KBMSpeedBoostPrompt)
			f43_arg0.LeftTrigger:completeAnimation()
			f43_arg0.LeftTrigger:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.LeftTrigger)
			f43_arg0.RightTrigger:completeAnimation()
			f43_arg0.RightTrigger:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.RightTrigger)
			f43_arg0.L3Button:completeAnimation()
			f43_arg0.L3Button:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.L3Button)
			f43_arg0.RightStick:completeAnimation()
			f43_arg0.RightStick:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.RightStick)
		end,
	},
}
CoD.vhud_hellstorm_button_layout.__onClose = function(f44_arg0)
	f44_arg0.KBMClusterBombPrompt:close()
	f44_arg0.KBMSlowDownPrompt:close()
	f44_arg0.KBMSpeedBoostPrompt:close()
	f44_arg0.LeftTrigger:close()
	f44_arg0.RightTrigger:close()
	f44_arg0.L3Button:close()
	f44_arg0.RightStick:close()
end
