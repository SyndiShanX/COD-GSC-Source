require("x64:1e1a53313536ac3")
CoD.GameSettings_Optionstextbox = InheritFrom(LUI.UIElement)
CoD.GameSettings_Optionstextbox.__defaultWidth = 674
CoD.GameSettings_Optionstextbox.__defaultHeight = 33
CoD.GameSettings_Optionstextbox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_Optionstextbox)
	self.id = "GameSettings_Optionstextbox"
	self.soundSet = "none"
	local CACvarientTitlePanel0 = CoD.CAC_varientTitlePanel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CACvarientTitlePanel0:setAlpha(0.25)
	self:addElement(CACvarientTitlePanel0)
	self.CACvarientTitlePanel0 = CACvarientTitlePanel0
	local TextBox = LUI.UIText.new(0, 0, 0, 674, 0, 0, 0, 21)
	TextBox:setRGB(0.74, 0.74, 0.74)
	TextBox:setText("")
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(TextBox, "setText", function(element, controller)
		ScaleWidgetToLabelWrapped(self, element, 0, 0)
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_Optionstextbox.__onClose = function(f3_arg0)
	f3_arg0.CACvarientTitlePanel0:close()
end
