require("ui/uieditor/widgets/controllerdependent_textbox")
CoD.PC_ButtonPrompt3dBind = InheritFrom(LUI.UIElement)
CoD.PC_ButtonPrompt3dBind.__defaultWidth = 89
CoD.PC_ButtonPrompt3dBind.__defaultHeight = 22
CoD.PC_ButtonPrompt3dBind.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_ButtonPrompt3dBind)
	self.id = "PC_ButtonPrompt3dBind"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -44.5, 44.5, 0.5, 0.5, -11, 11)
	ControllerDependentTextBox.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"]("platform/activate_bind"))
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_ButtonPrompt3dBind.__onClose = function(f2_arg0)
	f2_arg0.ControllerDependentTextBox:close()
end
