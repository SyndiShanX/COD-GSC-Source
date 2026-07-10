require("x64:d7ba7c36104672")
CoD.featureOverlay_frameVLayout_Buttons = InheritFrom(LUI.UIElement)
CoD.featureOverlay_frameVLayout_Buttons.__defaultWidth = 1920
CoD.featureOverlay_frameVLayout_Buttons.__defaultHeight = 54
CoD.featureOverlay_frameVLayout_Buttons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.featureOverlay_frameVLayout_Buttons)
	self.id = "featureOverlay_frameVLayout_Buttons"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local buttonBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	buttonBacking:setRGB(0.13, 0.11, 0.12)
	self:addElement(buttonBacking)
	self.buttonBacking = buttonBacking
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0, 1, 96, -1176, 0.5, 0.5, -24, 24)
	self:addElement(buttons)
	self.buttons = buttons
	if CoD.isPC then
		buttons.id = "buttons"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.featureOverlay_frameVLayout_Buttons.__onClose = function(f2_arg0)
	f2_arg0.buttons:close()
end
