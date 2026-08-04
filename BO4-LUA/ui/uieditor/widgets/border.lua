require("ui/uieditor/widgets/lobby/common/fe_titlenumbrdr")
CoD.Border = InheritFrom(LUI.UIElement)
CoD.Border.__defaultWidth = 537
CoD.Border.__defaultHeight = 36
CoD.Border.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Border)
	self.id = "Border"
	self.soundSet = "default"
	local FETitleNumBrdr00 = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 1, 1, 1, 0, 1, 0, 0)
	self:addElement(FETitleNumBrdr00)
	self.FETitleNumBrdr00 = FETitleNumBrdr00
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Border.__onClose = function(f2_arg0)
	f2_arg0.FETitleNumBrdr00:close()
end
