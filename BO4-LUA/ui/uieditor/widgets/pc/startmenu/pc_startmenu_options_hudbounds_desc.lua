CoD.PC_StartMenu_Options_HUDBounds_Desc = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_HUDBounds_Desc.__defaultWidth = 760
CoD.PC_StartMenu_Options_HUDBounds_Desc.__defaultHeight = 65
CoD.PC_StartMenu_Options_HUDBounds_Desc.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_HUDBounds_Desc)
	self.id = "PC_StartMenu_Options_HUDBounds_Desc"
	self.soundSet = "default"
	local Description = LUI.UIText.new(0.5, 0.5, -380, 380, 0.5, 0.5, -12.5, 12.5)
	Description:setRGB(0.51, 0.51, 0.51)
	Description:setText(Engine[0xF9F1239CFD921FE](0x7A619F36F31F521))
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setLineSpacing(4)
	Description:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Description:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	Description:setBackingType(2)
	Description:setBackingAlpha(0)
	LUI.OverrideFunction_CallOriginalFirst(Description, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWrapped(self, self.Description, 0, 0)
	end)
	self:addElement(Description)
	self.Description = Description
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
