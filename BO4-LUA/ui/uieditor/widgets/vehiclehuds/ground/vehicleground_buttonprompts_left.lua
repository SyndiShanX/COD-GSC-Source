require("x64:ef177d4a6200bf4")
require("x64:3a59bdc32fff6ae")
CoD.VehicleGround_ButtonPrompts_Left = InheritFrom(LUI.UIElement)
CoD.VehicleGround_ButtonPrompts_Left.__defaultWidth = 1400
CoD.VehicleGround_ButtonPrompts_Left.__defaultHeight = 48
CoD.VehicleGround_ButtonPrompts_Left.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_ButtonPrompts_Left)
	self.id = "VehicleGround_ButtonPrompts_Left"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backing = CoD.VehicleGround_ButtonPrompts_Backing.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local ButtonPromptsInternal = CoD.VehicleGround_ButtonPrompts_Left_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -700, 700, 0.5, 0.5, -24, 24)
	ButtonPromptsInternal:linkToElementModel(self, nil, false, function(model)
		ButtonPromptsInternal:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(ButtonPromptsInternal, "setWidth", function(element, controller)
		ScaleToElementWidth(self, element, 0)
	end)
	self:addElement(ButtonPromptsInternal)
	self.ButtonPromptsInternal = ButtonPromptsInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_ButtonPrompts_Left.__onClose = function(f4_arg0)
	f4_arg0.Backing:close()
	f4_arg0.ButtonPromptsInternal:close()
end
