require("x64:4f48b2a3318365e")
require("x64:9ef8e7ef66dcc85")
require("x64:34778f864da9dda")
require("x64:9d92dce1e4291ce")
CoD.vhud_gunship_buttonPrompt = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_buttonPrompt.__defaultWidth = 730
CoD.vhud_gunship_buttonPrompt.__defaultHeight = 939
CoD.vhud_gunship_buttonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_buttonPrompt)
	self.id = "vhud_gunship_buttonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CycleWeaponPrompt = CoD.vhud_ButtonPrompt_Minimal.new(f1_arg0, f1_arg1, 0.5, 0.5, -312.5, -137.5, 1, 1, -93, -43)
	CycleWeaponPrompt:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC() and AlwaysFalse()
			end,
		},
	})
	CycleWeaponPrompt:linkToElementModel(CycleWeaponPrompt, "text", true, function(model)
		f1_arg0:updateElementState(CycleWeaponPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	local CombatTrainingGameTimer = CycleWeaponPrompt
	local ExitPrompt = CycleWeaponPrompt.subscribeToModel
	local KBMCyclePrompt = Engine[0x4DF5CFBC1771947](f1_arg1)
	ExitPrompt(CombatTrainingGameTimer, KBMCyclePrompt["factions.isCoDCaster"], function(f4_arg0)
		f1_arg0:updateElementState(CycleWeaponPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	CycleWeaponPrompt:linkToElementModel(CycleWeaponPrompt, "bind", true, function(model)
		f1_arg0:updateElementState(CycleWeaponPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	CycleWeaponPrompt:linkToElementModel(CycleWeaponPrompt, "cooldown", true, function(model)
		if CycleWeaponPrompt["__stateValidation_cooldown->cooldown"] then
			CycleWeaponPrompt:removeSubscription(CycleWeaponPrompt["__stateValidation_cooldown->cooldown"])
			CycleWeaponPrompt["__stateValidation_cooldown->cooldown"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.cooldown
		end
		if model then
			CycleWeaponPrompt["__stateValidation_cooldown->cooldown"] = CycleWeaponPrompt:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(CycleWeaponPrompt, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "cooldown->cooldown",
				})
			end)
		end
	end)
	CycleWeaponPrompt:subscribeToGlobalModel(f1_arg1, "VehicleController", "alt2_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CycleWeaponPrompt.button:setImage(RegisterImage(f8_local0))
		end
	end)
	CycleWeaponPrompt:linkToElementModel(self, "bindings.BUTTON_Y", false, function(model)
		CycleWeaponPrompt:setModel(model, f1_arg1)
	end)
	CycleWeaponPrompt:linkToElementModel(self, "text", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CycleWeaponPrompt.prompt:setText(Engine[0xF9F1239CFD921FE](f10_local0))
		end
	end)
	self:addElement(CycleWeaponPrompt)
	self.CycleWeaponPrompt = CycleWeaponPrompt
	ExitPrompt = CoD.vhud_ButtonPrompt_Minimal.new(f1_arg0, f1_arg1, 0.5, 0.5, 136.5, 311.5, 1, 1, -93, -43)
	ExitPrompt:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC() and AlwaysFalse()
			end,
		},
	})
	ExitPrompt:linkToElementModel(ExitPrompt, "text", true, function(model)
		f1_arg0:updateElementState(ExitPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	KBMCyclePrompt = ExitPrompt
	CombatTrainingGameTimer = ExitPrompt.subscribeToModel
	local KBMCycleActionName = Engine[0x4DF5CFBC1771947](f1_arg1)
	CombatTrainingGameTimer(KBMCyclePrompt, KBMCycleActionName["factions.isCoDCaster"], function(f13_arg0)
		f1_arg0:updateElementState(ExitPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	ExitPrompt:linkToElementModel(ExitPrompt, "bind", true, function(model)
		f1_arg0:updateElementState(ExitPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	ExitPrompt:linkToElementModel(ExitPrompt, "cooldown", true, function(model)
		if ExitPrompt["__stateValidation_cooldown->cooldown"] then
			ExitPrompt:removeSubscription(ExitPrompt["__stateValidation_cooldown->cooldown"])
			ExitPrompt["__stateValidation_cooldown->cooldown"] = nil
		end
		if model then
			local f15_local0 = model:get()
			local f15_local1 = model:get()
			model = f15_local0 and f15_local1.cooldown
		end
		if model then
			ExitPrompt["__stateValidation_cooldown->cooldown"] = ExitPrompt:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(ExitPrompt, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "cooldown->cooldown",
				})
			end)
		end
	end)
	ExitPrompt:subscribeToGlobalModel(f1_arg1, "VehicleController", "alt1_button_image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			ExitPrompt.button:setImage(RegisterImage(f17_local0))
		end
	end)
	ExitPrompt:linkToElementModel(self, "bindings.BUTTON_X", false, function(model)
		ExitPrompt:setModel(model, f1_arg1)
	end)
	ExitPrompt:linkToElementModel(self, "text", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			ExitPrompt.prompt:setText(Engine[0xF9F1239CFD921FE](f19_local0))
		end
	end)
	self:addElement(ExitPrompt)
	self.ExitPrompt = ExitPrompt
	CombatTrainingGameTimer = CoD.CombatTrainingGameTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -101.5, 98.5, 0, 0, 0, 65)
	CombatTrainingGameTimer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsGameTypeCombatTraining()
			end,
		},
	})
	CombatTrainingGameTimer:setAlpha(0)
	CombatTrainingGameTimer:setScale(2, 2)
	self:addElement(CombatTrainingGameTimer)
	self.CombatTrainingGameTimer = CombatTrainingGameTimer
	KBMCyclePrompt = nil
	KBMCyclePrompt = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -259.5, -170.5, 1, 1, -122.5, -100.5)
	KBMCyclePrompt:setAlpha(0)
	KBMCyclePrompt.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{weapnext}]"))
	KBMCyclePrompt.GamepadText:setText("")
	self:addElement(KBMCyclePrompt)
	self.KBMCyclePrompt = KBMCyclePrompt
	KBMCycleActionName = nil
	KBMCycleActionName = LUI.UIText.new(0.5, 0.5, -365, -65, 1, 1, -78, -62)
	KBMCycleActionName:setAlpha(0)
	KBMCycleActionName:setText(Engine[0xF9F1239CFD921FE](0xCD7EB3F7D80E6F7))
	KBMCycleActionName:setTTF("ttmussels_regular")
	KBMCycleActionName:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	KBMCycleActionName:setLetterSpacing(0.5)
	KBMCycleActionName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(KBMCycleActionName)
	self.KBMCycleActionName = KBMCycleActionName
	local KBMExitPrompt = nil
	KBMExitPrompt = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, 170.5, 259.5, 1, 1, -122.5, -100.5)
	KBMExitPrompt:setAlpha(0)
	KBMExitPrompt.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+activate}] "))
	KBMExitPrompt.GamepadText:setText("")
	self:addElement(KBMExitPrompt)
	self.KBMExitPrompt = KBMExitPrompt
	local KBMExitActionName = nil
	KBMExitActionName = LUI.UIText.new(0.5, 0.5, 65, 365, 1, 1, -78, -62)
	KBMExitActionName:setAlpha(0)
	KBMExitActionName:setText(Engine[0xF9F1239CFD921FE](0xC7D903A026627FC))
	KBMExitActionName:setTTF("ttmussels_regular")
	KBMExitActionName:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	KBMExitActionName:setLetterSpacing(0.5)
	KBMExitActionName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KBMExitActionName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KBMExitActionName)
	self.KBMExitActionName = KBMExitActionName
	local HeroAbilityHoldStringPC = nil
	HeroAbilityHoldStringPC = CoD.AbilityHoldToActivate.new(f1_arg0, f1_arg1, 0.5, 0.5, 115, 315, 1, 1, -183.5, -134.5)
	HeroAbilityHoldStringPC:mergeStateConditions({
		{
			stateName = "NonHoldToActivate",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "VisibleCharged",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "VisibleInUse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	HeroAbilityHoldStringPC:setAlpha(0)
	self:addElement(HeroAbilityHoldStringPC)
	self.HeroAbilityHoldStringPC = HeroAbilityHoldStringPC
	self:mergeStateConditions({
		{
			stateName = "KBMExitHidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and IsGameTypeCombatTraining()
			end,
		},
		{
			stateName = "HideExitPrompt",
			condition = function(menu, element, event)
				return IsGameTypeCombatTraining()
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f27_arg0, f27_arg1)
		f27_arg1.menu = f27_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f27_arg1)
	end)
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11.LastInput, function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_buttonPrompt.__resetProperties = function(f29_arg0)
	f29_arg0.ExitPrompt:completeAnimation()
	f29_arg0.CycleWeaponPrompt:completeAnimation()
	f29_arg0.CombatTrainingGameTimer:completeAnimation()
	f29_arg0.KBMCycleActionName:completeAnimation()
	f29_arg0.KBMCyclePrompt:completeAnimation()
	f29_arg0.KBMExitActionName:completeAnimation()
	f29_arg0.KBMExitPrompt:completeAnimation()
	f29_arg0.HeroAbilityHoldStringPC:completeAnimation()
	f29_arg0.ExitPrompt:setAlpha(1)
	f29_arg0.CycleWeaponPrompt:setAlpha(1)
	f29_arg0.CombatTrainingGameTimer:setAlpha(0)
	f29_arg0.KBMCycleActionName:setAlpha(0)
	f29_arg0.KBMCyclePrompt:setAlpha(0)
	f29_arg0.KBMExitActionName:setAlpha(0)
	f29_arg0.KBMExitPrompt:setAlpha(0)
	f29_arg0.HeroAbilityHoldStringPC:setAlpha(0)
end
CoD.vhud_gunship_buttonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	KBMExitHidden = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(5)
			f31_arg0.CycleWeaponPrompt:completeAnimation()
			f31_arg0.CycleWeaponPrompt:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.CycleWeaponPrompt)
			f31_arg0.ExitPrompt:completeAnimation()
			f31_arg0.ExitPrompt:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ExitPrompt)
			f31_arg0.CombatTrainingGameTimer:completeAnimation()
			f31_arg0.CombatTrainingGameTimer:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.CombatTrainingGameTimer)
			f31_arg0.KBMCyclePrompt:completeAnimation()
			f31_arg0.KBMCyclePrompt:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.KBMCyclePrompt)
			f31_arg0.KBMCycleActionName:completeAnimation()
			f31_arg0.KBMCycleActionName:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.KBMCycleActionName)
		end,
	},
	HideExitPrompt = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.ExitPrompt:completeAnimation()
			f32_arg0.ExitPrompt:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ExitPrompt)
			f32_arg0.CombatTrainingGameTimer:completeAnimation()
			f32_arg0.CombatTrainingGameTimer:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.CombatTrainingGameTimer)
		end,
	},
	KBM = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(7)
			f33_arg0.CycleWeaponPrompt:completeAnimation()
			f33_arg0.CycleWeaponPrompt:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.CycleWeaponPrompt)
			f33_arg0.ExitPrompt:completeAnimation()
			f33_arg0.ExitPrompt:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ExitPrompt)
			f33_arg0.KBMCyclePrompt:completeAnimation()
			f33_arg0.KBMCyclePrompt:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.KBMCyclePrompt)
			f33_arg0.KBMCycleActionName:completeAnimation()
			f33_arg0.KBMCycleActionName:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.KBMCycleActionName)
			f33_arg0.KBMExitPrompt:completeAnimation()
			f33_arg0.KBMExitPrompt:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.KBMExitPrompt)
			f33_arg0.KBMExitActionName:completeAnimation()
			f33_arg0.KBMExitActionName:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.KBMExitActionName)
			f33_arg0.HeroAbilityHoldStringPC:completeAnimation()
			f33_arg0.HeroAbilityHoldStringPC:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.HeroAbilityHoldStringPC)
		end,
	},
}
CoD.vhud_gunship_buttonPrompt.__onClose = function(f34_arg0)
	f34_arg0.CycleWeaponPrompt:close()
	f34_arg0.ExitPrompt:close()
	f34_arg0.CombatTrainingGameTimer:close()
	f34_arg0.KBMCyclePrompt:close()
	f34_arg0.KBMExitPrompt:close()
	f34_arg0.HeroAbilityHoldStringPC:close()
end
