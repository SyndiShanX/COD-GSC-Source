require("x64:7c03458f023327")
CoD.HUD_PC_Wingsuit = InheritFrom(LUI.UIElement)
CoD.HUD_PC_Wingsuit.__defaultWidth = 495
CoD.HUD_PC_Wingsuit.__defaultHeight = 65
CoD.HUD_PC_Wingsuit.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_PC_Wingsuit)
	self.id = "HUD_PC_Wingsuit"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpeedUp = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -146.5, -51.5, 1, 1, -65, 0)
	SpeedUp:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	SpeedUp.label:setText(LocalizeToUpperString(@"hash_DE0EFB7A131D734"))
	SpeedUp.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f1_arg1, "+forward")))
	self:addElement(SpeedUp)
	self.SpeedUp = SpeedUp
	local SlowDown = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -47.5, 47.5, 1, 1, -65, 0)
	SlowDown:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	SlowDown.label:setText(LocalizeToUpperString(@"hash_799B5D0CE4888821"))
	SlowDown.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f1_arg1, "+back")))
	LUI.OverrideFunction_CallOriginalFirst(SlowDown, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsSelfInState(self, "Gamepad") then
			HideWidget(self.SlowDown)
		end
	end)
	self:addElement(SlowDown)
	self.SlowDown = SlowDown
	local FreeLook = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, 51.5, 146.5, 1, 1, -65, 0)
	FreeLook:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	FreeLook.label:setText(LocalizeToUpperString(@"warzone/wingsuit_l2"))
	FreeLook.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f1_arg1, "+vehiclealtcontrol")))
	self:addElement(FreeLook)
	self.FreeLook = FreeLook
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f8_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	if not IsWarzone() then
		HideWidget(f1_local5)
	end
	return self
end
CoD.HUD_PC_Wingsuit.__resetProperties = function(f10_arg0, f10_arg1)
	f10_arg0.FreeLook:completeAnimation()
	f10_arg0.SpeedUp:completeAnimation()
	f10_arg0.SlowDown:completeAnimation()
	f10_arg0.FreeLook:setLeftRight(0.5, 0.5, 51.5, 146.5)
	f10_arg0.FreeLook:setAlpha(1)
	f10_arg0.FreeLook.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f10_arg1, "+vehiclealtcontrol")))
	f10_arg0.SpeedUp:setAlpha(1)
	f10_arg0.SpeedUp.label:setText(LocalizeToUpperString(@"hash_DE0EFB7A131D734"))
	f10_arg0.SpeedUp.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f10_arg1, "+forward")))
	f10_arg0.SlowDown:setLeftRight(0.5, 0.5, -47.5, 47.5)
	f10_arg0.SlowDown:setAlpha(1)
	f10_arg0.SlowDown.label:setText(LocalizeToUpperString(@"hash_799B5D0CE4888821"))
	f10_arg0.SlowDown.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f10_arg1, "+back")))
end
CoD.HUD_PC_Wingsuit.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties(f11_arg1)
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.FreeLook:beginAnimation(13060)
			f11_arg0.FreeLook.HUDVehiclePromptContainer.KBMText:beginAnimation(13060)
			f11_arg0.FreeLook.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f11_arg1, "+vehiclealtcontrol")))
			f11_arg0.FreeLook:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.FreeLook:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties(f12_arg1)
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.SpeedUp:completeAnimation()
			f12_arg0.SpeedUp:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SpeedUp)
			f12_arg0.SlowDown:completeAnimation()
			f12_arg0.SlowDown:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SlowDown)
			f12_arg0.FreeLook:completeAnimation()
			f12_arg0.FreeLook:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.FreeLook)
		end,
	},
	Gamepad = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties(f13_arg1)
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.SpeedUp:completeAnimation()
			f13_arg0.SpeedUp.label:completeAnimation()
			f13_arg0.SpeedUp.HUDVehiclePromptContainer.KBMText:completeAnimation()
			f13_arg0.SpeedUp:setAlpha(1)
			f13_arg0.SpeedUp.label:setText(LocalizeToUpperString(@"warzone/wingsuit_ls"))
			f13_arg0.SpeedUp.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f13_arg1, "+movestick")))
			f13_arg0.clipFinished(f13_arg0.SpeedUp)
			f13_arg0.SlowDown:completeAnimation()
			f13_arg0.SlowDown.label:completeAnimation()
			f13_arg0.SlowDown.HUDVehiclePromptContainer.KBMText:completeAnimation()
			f13_arg0.SlowDown:setLeftRight(0.5, 0.5, -47.5, 47.5)
			f13_arg0.SlowDown:setAlpha(0)
			f13_arg0.SlowDown.label:setText(LocalizeToUpperString(@"warzone/wingsuit_ls"))
			f13_arg0.SlowDown.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f13_arg1, "+movestick")))
			f13_arg0.clipFinished(f13_arg0.SlowDown)
			f13_arg0.FreeLook:completeAnimation()
			f13_arg0.FreeLook.HUDVehiclePromptContainer.KBMText:completeAnimation()
			f13_arg0.FreeLook:setLeftRight(0.5, 0.5, 51.5, 146.5)
			f13_arg0.FreeLook.HUDVehiclePromptContainer.KBMText:setText(CoD.BaseUtility.AlreadyLocalized(CoD.PCUtility.GetKeybind(f13_arg1, "+speed_throw")))
			f13_arg0.clipFinished(f13_arg0.FreeLook)
		end,
	},
}
CoD.HUD_PC_Wingsuit.__onClose = function(f14_arg0)
	f14_arg0.SpeedUp:close()
	f14_arg0.SlowDown:close()
	f14_arg0.FreeLook:close()
end
