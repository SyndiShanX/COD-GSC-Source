require("x64:7c03458f023327")
require("x64:cef6d3bcce79c05")
CoD.HUD_PC_Vehicle = InheritFrom(LUI.UIElement)
CoD.HUD_PC_Vehicle.__defaultWidth = 650
CoD.HUD_PC_Vehicle.__defaultHeight = 65
CoD.HUD_PC_Vehicle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.HUD_PC_Vehicle)
	self.id = "HUD_PC_Vehicle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local HUDVehiclePromptL4 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, -217.5, -122.5, 0, 0, 0, 65)
	HUDVehiclePromptL4:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.bindings.LEFT_4", function(model)
		HUDVehiclePromptL4:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptL4:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HUDVehiclePromptL4.label:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	HUDVehiclePromptL4:linkToElementModel(self, "bind", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			HUDVehiclePromptL4.HUDVehiclePromptContainer.KBMText:setText(f4_local0)
		end
	end)
	self:addElement(HUDVehiclePromptL4)
	self.HUDVehiclePromptL4 = HUDVehiclePromptL4
	local HUDVehiclePromptL3 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, -118.5, -23.5, 0, 0, 0, 65)
	HUDVehiclePromptL3:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.bindings.LEFT_3", function(model)
		HUDVehiclePromptL3:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptL3:linkToElementModel(self, "text", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HUDVehiclePromptL3.label:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	HUDVehiclePromptL3:linkToElementModel(self, "bind", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			HUDVehiclePromptL3.HUDVehiclePromptContainer.KBMText:setText(f7_local0)
		end
	end)
	self:addElement(HUDVehiclePromptL3)
	self.HUDVehiclePromptL3 = HUDVehiclePromptL3
	local HUDVehiclePromptL2 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, -19.5, 75.5, 0, 0, 0, 65)
	HUDVehiclePromptL2:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.bindings.LEFT_2", function(model)
		HUDVehiclePromptL2:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptL2:linkToElementModel(self, "text", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			HUDVehiclePromptL2.label:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	HUDVehiclePromptL2:linkToElementModel(self, "bind", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			HUDVehiclePromptL2.HUDVehiclePromptContainer.KBMText:setText(f10_local0)
		end
	end)
	self:addElement(HUDVehiclePromptL2)
	self.HUDVehiclePromptL2 = HUDVehiclePromptL2
	local HUDVehiclePromptL1 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, 79.5, 174.5, 0, 0, 0, 65)
	HUDVehiclePromptL1:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.bindings.LEFT_1", function(model)
		HUDVehiclePromptL1:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptL1:linkToElementModel(self, "text", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			HUDVehiclePromptL1.label:setText(LocalizeToUpperString(f12_local0))
		end
	end)
	HUDVehiclePromptL1:linkToElementModel(self, "bind", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			HUDVehiclePromptL1.HUDVehiclePromptContainer.KBMText:setText(f13_local0)
		end
	end)
	self:addElement(HUDVehiclePromptL1)
	self.HUDVehiclePromptL1 = HUDVehiclePromptL1
	local HUDVehiclePromptL0 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, 178.5, 273.5, 0, 0, 0, 65)
	HUDVehiclePromptL0:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.bindings.LEFT_0", function(model)
		HUDVehiclePromptL0:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptL0:linkToElementModel(self, "text", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			HUDVehiclePromptL0.label:setText(LocalizeToUpperString(f15_local0))
		end
	end)
	HUDVehiclePromptL0:linkToElementModel(self, "bind", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			HUDVehiclePromptL0.HUDVehiclePromptContainer.KBMText:setText(f16_local0)
		end
	end)
	self:addElement(HUDVehiclePromptL0)
	self.HUDVehiclePromptL0 = HUDVehiclePromptL0
	local HUDVehiclePromptR0 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, 277.5, 372.5, 0, 0, 0, 65)
	HUDVehiclePromptR0:linkToElementModel(self, "bindings.RIGHT_0", false, function(model)
		HUDVehiclePromptR0:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptR0:linkToElementModel(self, "text", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			HUDVehiclePromptR0.label:setText(LocalizeToUpperString(f18_local0))
		end
	end)
	HUDVehiclePromptR0:linkToElementModel(self, "bind", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			HUDVehiclePromptR0.HUDVehiclePromptContainer.KBMText:setText(f19_local0)
		end
	end)
	self:addElement(HUDVehiclePromptR0)
	self.HUDVehiclePromptR0 = HUDVehiclePromptR0
	local HUDVehiclePromptR1 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, 376.5, 471.5, 0, 0, 0, 65)
	HUDVehiclePromptR1:linkToElementModel(self, "bindings.RIGHT_1", false, function(model)
		HUDVehiclePromptR1:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptR1:linkToElementModel(self, "text", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			HUDVehiclePromptR1.label:setText(LocalizeToUpperString(f21_local0))
		end
	end)
	HUDVehiclePromptR1:linkToElementModel(self, "bind", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			HUDVehiclePromptR1.HUDVehiclePromptContainer.KBMText:setText(f22_local0)
		end
	end)
	self:addElement(HUDVehiclePromptR1)
	self.HUDVehiclePromptR1 = HUDVehiclePromptR1
	local HUDVehiclePromptR2 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, 475.5, 570.5, 0, 0, 0, 65)
	HUDVehiclePromptR2:linkToElementModel(self, "bindings.RIGHT_2", false, function(model)
		HUDVehiclePromptR2:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptR2:linkToElementModel(self, "text", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			HUDVehiclePromptR2.label:setText(LocalizeToUpperString(f24_local0))
		end
	end)
	HUDVehiclePromptR2:linkToElementModel(self, "bind", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			HUDVehiclePromptR2.HUDVehiclePromptContainer.KBMText:setText(f25_local0)
		end
	end)
	self:addElement(HUDVehiclePromptR2)
	self.HUDVehiclePromptR2 = HUDVehiclePromptR2
	local HUDVehiclePromptR3 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, 574.5, 669.5, 0, 0, 0, 65)
	HUDVehiclePromptR3:linkToElementModel(self, "bindings.RIGHT_3", false, function(model)
		HUDVehiclePromptR3:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptR3:linkToElementModel(self, "text", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			HUDVehiclePromptR3.label:setText(LocalizeToUpperString(f27_local0))
		end
	end)
	HUDVehiclePromptR3:linkToElementModel(self, "bind", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			HUDVehiclePromptR3.HUDVehiclePromptContainer.KBMText:setText(f28_local0)
		end
	end)
	self:addElement(HUDVehiclePromptR3)
	self.HUDVehiclePromptR3 = HUDVehiclePromptR3
	local HUDVehiclePromptR4 = CoD.HUD_VehiclePrompt.new(f1_arg0, f1_arg1, 0, 0, 673.5, 768.5, 0, 0, 0, 65)
	HUDVehiclePromptR4:linkToElementModel(self, "bindings.RIGHT_4", false, function(model)
		HUDVehiclePromptR4:setModel(model, f1_arg1)
	end)
	HUDVehiclePromptR4:linkToElementModel(self, "text", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			HUDVehiclePromptR4.label:setText(LocalizeToUpperString(f30_local0))
		end
	end)
	HUDVehiclePromptR4:linkToElementModel(self, "bind", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			HUDVehiclePromptR4.HUDVehiclePromptContainer.KBMText:setText(f31_local0)
		end
	end)
	self:addElement(HUDVehiclePromptR4)
	self.HUDVehiclePromptR4 = HUDVehiclePromptR4
	local ExitPrompt = CoD.HUD_VehiclePrompt_Hold.new(f1_arg0, f1_arg1, 0, 0, 772.5, 867.5, 0, 0, 0, 65)
	ExitPrompt.label:setText(LocalizeToUpperString(0xC7D903A026627FC))
	ExitPrompt.HUDVehiclePromptContainer.KBMText:setText(CoD.PCUtility.GetKeybind(f1_arg1, "+activate"))
	ExitPrompt:linkToElementModel(self, nil, false, function(model)
		ExitPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(ExitPrompt)
	self.ExitPrompt = ExitPrompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local12 = self
	if IsInTheaterMode() then
		HideWidget(f1_local12)
	end
	return self
end
CoD.HUD_PC_Vehicle.__onClose = function(f33_arg0)
	f33_arg0.HUDVehiclePromptL4:close()
	f33_arg0.HUDVehiclePromptL3:close()
	f33_arg0.HUDVehiclePromptL2:close()
	f33_arg0.HUDVehiclePromptL1:close()
	f33_arg0.HUDVehiclePromptL0:close()
	f33_arg0.HUDVehiclePromptR0:close()
	f33_arg0.HUDVehiclePromptR1:close()
	f33_arg0.HUDVehiclePromptR2:close()
	f33_arg0.HUDVehiclePromptR3:close()
	f33_arg0.HUDVehiclePromptR4:close()
	f33_arg0.ExitPrompt:close()
end
