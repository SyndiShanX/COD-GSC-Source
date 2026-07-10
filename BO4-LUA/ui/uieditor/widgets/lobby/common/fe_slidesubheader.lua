require("x64:c4bf36f89c65d01")
CoD.FE_SlideSubHeader = InheritFrom(LUI.UIElement)
CoD.FE_SlideSubHeader.__defaultWidth = 175
CoD.FE_SlideSubHeader.__defaultHeight = 42
CoD.FE_SlideSubHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_SlideSubHeader)
	self.id = "FE_SlideSubHeader"
	self.soundSet = "ModeSelection"
	local FELabelSubHeadingD0 = CoD.FE_LabelSubHeadingD.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0.5, 0.5, -21, 21)
	FELabelSubHeadingD0.Label0:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FELabelSubHeadingD0.Label0:setText("")
	FELabelSubHeadingD0.Label0:setTTF("ttmussels_regular")
	LUI.OverrideFunction_CallOriginalFirst(FELabelSubHeadingD0, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 3)
	end)
	self:addElement(FELabelSubHeadingD0)
	self.FELabelSubHeadingD0 = FELabelSubHeadingD0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FE_SlideSubHeader.__onClose = function(f3_arg0)
	f3_arg0.FELabelSubHeadingD0:close()
end
