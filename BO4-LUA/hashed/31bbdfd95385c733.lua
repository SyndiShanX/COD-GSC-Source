CoD.ui_icon_callingcards_fairytales_finger5 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_finger5.__defaultWidth = 10
CoD.ui_icon_callingcards_fairytales_finger5.__defaultHeight = 10
CoD.ui_icon_callingcards_fairytales_finger5.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_finger5)
	self.id = "ui_icon_callingcards_fairytales_finger5"
	self.soundSet = "default"
	local finger5 = LUI.UIImage.new(0, 0, -35, 21, 0, 0, -10, 62)
	finger5:setImage(RegisterImage(0xDAD37048BDCE0F6))
	self:addElement(finger5)
	self.finger5 = finger5
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
