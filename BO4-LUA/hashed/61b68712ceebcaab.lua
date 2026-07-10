require("x64:2675595fa323085")
CoD.PC_Prestige_Slider = InheritFrom(LUI.UIElement)
CoD.PC_Prestige_Slider.__defaultWidth = 1038
CoD.PC_Prestige_Slider.__defaultHeight = 16
CoD.PC_Prestige_Slider.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Prestige_Slider)
	self.id = "PC_Prestige_Slider"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	local slider = LUI.UIImage.new(0, 1, 18, -18, 0, 1, 5, -5)
	slider:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	self:addElement(slider)
	self.slider = slider
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -519, 519, 0.5, 0.5, -9, 9)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	emptyFocusable.id = "emptyFocusable"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Prestige_Slider.__onClose = function(f2_arg0)
	f2_arg0.emptyFocusable:close()
end
