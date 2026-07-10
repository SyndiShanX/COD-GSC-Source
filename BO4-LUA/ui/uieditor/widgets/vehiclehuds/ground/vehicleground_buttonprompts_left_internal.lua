require("x64:de9e451ea80d529")
require("x64:fb4ac1597b7dda8")
require("x64:291b90da1df3a5f")
CoD.VehicleGround_ButtonPrompts_Left_Internal = InheritFrom(LUI.UIElement)
CoD.VehicleGround_ButtonPrompts_Left_Internal.__defaultWidth = 1400
CoD.VehicleGround_ButtonPrompts_Left_Internal.__defaultHeight = 48
CoD.VehicleGround_ButtonPrompts_Left_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.VehicleGround_ButtonPrompts_Left_Internal)
	self.id = "VehicleGround_ButtonPrompts_Left_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Left4Btn = CoD.VehicleButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 0, 0, 0, 48)
	Left4Btn:linkToElementModel(self, "bindings.LEFT_4", false, function(model)
		Left4Btn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Left4Btn, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Left4Btn)
	self.Left4Btn = Left4Btn
	local Left3Btn = CoD.VehicleButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 200, 400, 0, 0, 0, 48)
	Left3Btn:linkToElementModel(self, "bindings.LEFT_3", false, function(model)
		Left3Btn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Left3Btn, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Left3Btn)
	self.Left3Btn = Left3Btn
	local Left2Btn = CoD.VehicleButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 400, 600, 0, 0, 0, 48)
	Left2Btn:linkToElementModel(self, "bindings.LEFT_2", false, function(model)
		Left2Btn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Left2Btn, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Left2Btn)
	self.Left2Btn = Left2Btn
	local Left1Btn = CoD.VehicleButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 600, 800, 0, 0, 0, 48)
	Left1Btn:linkToElementModel(self, "bindings.LEFT_1", false, function(model)
		Left1Btn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Left1Btn, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Left1Btn)
	self.Left1Btn = Left1Btn
	local Left0Btn = CoD.VehicleButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 800, 1000, 0, 0, 0, 48)
	Left0Btn:linkToElementModel(self, "bindings.LEFT_0", false, function(model)
		Left0Btn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Left0Btn, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Left0Btn)
	self.Left0Btn = Left0Btn
	local SwitchToDriverBtn = CoD.VehicleHoldSwitchSeat.new(f1_arg0, f1_arg1, 0, 0, 1000, 1200, 0, 0, 0, 48)
	SwitchToDriverBtn:linkToElementModel(self, nil, false, function(model)
		SwitchToDriverBtn:setModel(model, f1_arg1)
	end)
	SwitchToDriverBtn:linkToElementModel(self, "vehicleDriverStringOverrideRef", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			SwitchToDriverBtn.label:setText(LocalizeToUpperString(f13_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(SwitchToDriverBtn, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(SwitchToDriverBtn)
	self.SwitchToDriverBtn = SwitchToDriverBtn
	local ExitVehicleBtn = CoD.VehicleHoldButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1200, 1400, 0, 0, 0, 48)
	ExitVehicleBtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			ExitVehicleBtn.buttonPromptImage:setImage(RegisterImage(f15_local0))
		end
	end)
	ExitVehicleBtn:linkToElementModel(self, nil, false, function(model)
		ExitVehicleBtn:setModel(model, f1_arg1)
	end)
	ExitVehicleBtn:linkToElementModel(self, "vehicleExitPromptRef", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			ExitVehicleBtn.label:setText(Engine[@"hash_4F9F1239CFD921FE"](f17_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(ExitVehicleBtn, "setState", function(element, controller, f18_arg2, f18_arg3, f18_arg4)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(ExitVehicleBtn)
	self.ExitVehicleBtn = ExitVehicleBtn
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_ButtonPrompts_Left_Internal.__onClose = function(f19_arg0)
	f19_arg0.Left4Btn:close()
	f19_arg0.Left3Btn:close()
	f19_arg0.Left2Btn:close()
	f19_arg0.Left1Btn:close()
	f19_arg0.Left0Btn:close()
	f19_arg0.SwitchToDriverBtn:close()
	f19_arg0.ExitVehicleBtn:close()
end
