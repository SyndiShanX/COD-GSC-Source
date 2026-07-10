require("x64:9cb1900193778bc")
CoD.PC_TelemetryItem = InheritFrom(LUI.UIElement)
CoD.PC_TelemetryItem.__defaultWidth = 93
CoD.PC_TelemetryItem.__defaultHeight = 15
CoD.PC_TelemetryItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_TelemetryItem)
	self.id = "PC_TelemetryItem"
	self.soundSet = "default"
	local KeyPromptBacking = CoD.KeyPromptBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(KeyPromptBacking)
	self.KeyPromptBacking = KeyPromptBacking
	local Label = LUI.UIText.new(0, 0, 3, 40, 0.5, 0.5, -7.5, 7.5)
	Label:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Label:setTTF("ttmussels_regular")
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(Label, "setText", function(element, controller)
		if not HasProperty(element, "initialWidthSet") then
			SetElementProperty(element, "initialWidthSet", true)
			ScaleWidgetToLabelCenteredWithMinimum(self, element, 5, 93)
		end
	end)
	self:addElement(Label)
	self.Label = Label
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_TelemetryItem.__onClose = function(f3_arg0)
	f3_arg0.KeyPromptBacking:close()
end
