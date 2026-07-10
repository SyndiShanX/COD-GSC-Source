CoD.ui_icon_callingcards_fairytales_finger4 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_finger4.__defaultWidth = 10
CoD.ui_icon_callingcards_fairytales_finger4.__defaultHeight = 10
CoD.ui_icon_callingcards_fairytales_finger4.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_finger4)
	self.id = "ui_icon_callingcards_fairytales_finger4"
	self.soundSet = "default"
	local finger4 = LUI.UIImage.new(0, 0, -56, 16, 0, 0, -6, 66)
	finger4:setImage(RegisterImage(@"uie_ui_icon_callingcards_fairytale_finger4"))
	self:addElement(finger4)
	self.finger4 = finger4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
