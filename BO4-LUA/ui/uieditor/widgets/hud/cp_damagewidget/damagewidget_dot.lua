require("x64:b9f546022ef5716")
CoD.DamageWidget_Dot = InheritFrom(LUI.UIElement)
CoD.DamageWidget_Dot.__defaultWidth = 6
CoD.DamageWidget_Dot.__defaultHeight = 6
CoD.DamageWidget_Dot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DamageWidget_Dot)
	self.id = "DamageWidget_Dot"
	self.soundSet = "default"
	local AbilityWheelPixel0 = CoD.AbilityWheel_Pixel.new(f1_arg0, f1_arg1, 0, 0, -3, 9, 0, 0, -3, 9)
	AbilityWheelPixel0:setAlpha(0)
	AbilityWheelPixel0.Image20:setAlpha(0.7)
	AbilityWheelPixel0.Image20:setZoom(10)
	self:addElement(AbilityWheelPixel0)
	self.AbilityWheelPixel0 = AbilityWheelPixel0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DamageWidget_Dot.__onClose = function(f2_arg0)
	f2_arg0.AbilityWheelPixel0:close()
end
