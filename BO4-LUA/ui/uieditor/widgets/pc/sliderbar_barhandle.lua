require("ui/uieditor/widgets/pc/sliderbar_barhandle_bardetail")
CoD.SliderBar_BarHandle = InheritFrom(LUI.UIElement)
CoD.SliderBar_BarHandle.__defaultWidth = 1
CoD.SliderBar_BarHandle.__defaultHeight = 70
CoD.SliderBar_BarHandle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SliderBar_BarHandle)
	self.id = "SliderBar_BarHandle"
	self.soundSet = "ChooseDecal"
	local Line = LUI.UIImage.new(0, 0, 0, 1, 0, 1, 0, 0)
	Line:setRGB(0.49, 0.49, 0.49)
	self:addElement(Line)
	self.Line = Line
	local Detail = CoD.SliderBar_BarHandle_BarDetail.new(f1_arg0, f1_arg1, 0, 0, -10, 0, 0.5, 0.5, -29, 29)
	Detail:setRGB(0.58, 0.58, 0.58)
	self:addElement(Detail)
	self.Detail = Detail
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SliderBar_BarHandle.__onClose = function(f2_arg0)
	f2_arg0.Detail:close()
end
