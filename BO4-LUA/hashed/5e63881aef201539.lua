require("x64:b710bc406e458bd")
CoD.PC_Quit_Korea_Container = InheritFrom(LUI.UIElement)
CoD.PC_Quit_Korea_Container.__defaultWidth = 1920
CoD.PC_Quit_Korea_Container.__defaultHeight = 1080
CoD.PC_Quit_Korea_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Quit_Korea_Container)
	self.id = "PC_Quit_Korea_Container"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local PCKoreaContentDescriptorsContainer = CoD.PC_Korea_ContentDescriptors_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, 617, 806, 0, 0, 41, 377)
	self:addElement(PCKoreaContentDescriptorsContainer)
	self.PCKoreaContentDescriptorsContainer = PCKoreaContentDescriptorsContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Quit_Korea_Container.__onClose = function(f2_arg0)
	f2_arg0.PCKoreaContentDescriptorsContainer:close()
end
