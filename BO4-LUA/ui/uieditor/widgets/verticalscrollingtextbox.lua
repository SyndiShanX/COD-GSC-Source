require("ui/uieditor/widgets/verticalscrollingtextcontainer")
CoD.verticalScrollingTextBox = InheritFrom(LUI.UIElement)
CoD.verticalScrollingTextBox.__defaultWidth = 900
CoD.verticalScrollingTextBox.__defaultHeight = 300
CoD.verticalScrollingTextBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.verticalScrollingTextBox)
	self.id = "verticalScrollingTextBox"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local textBox = CoD.verticalScrollingTextContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 21)
	self:addElement(textBox)
	self.textBox = textBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.TextUtility.SetupVerticalScrollingTextWidget(self, f1_arg1)
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.verticalScrollingTextBox.__onClose = function(f2_arg0)
	f2_arg0.textBox:close()
end
