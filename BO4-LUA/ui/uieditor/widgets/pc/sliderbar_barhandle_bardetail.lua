CoD.SliderBar_BarHandle_BarDetail = InheritFrom(LUI.UIElement)
CoD.SliderBar_BarHandle_BarDetail.__defaultWidth = 10
CoD.SliderBar_BarHandle_BarDetail.__defaultHeight = 58
CoD.SliderBar_BarHandle_BarDetail.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SliderBar_BarHandle_BarDetail)
	self.id = "SliderBar_BarHandle_BarDetail"
	self.soundSet = "default"
	local Thick = LUI.UIImage.new(1, 1, -10, 0, 0, 1, 6, -6)
	self:addElement(Thick)
	self.Thick = Thick
	local Detail = LUI.UIImage.new(0.5, 0.5, 0, 1, 0, 1, 20, -20)
	Detail:setRGB(0, 0, 0)
	Detail:setAlpha(0.5)
	self:addElement(Detail)
	self.Detail = Detail
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
