CoD.ui_icon_callingcards_fairytales_finger2 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_finger2.__defaultWidth = 10
CoD.ui_icon_callingcards_fairytales_finger2.__defaultHeight = 10
CoD.ui_icon_callingcards_fairytales_finger2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_finger2)
	self.id = "ui_icon_callingcards_fairytales_finger2"
	self.soundSet = "default"
	local finger2 = LUI.UIImage.new(0, 0, -74, 22, 0, 0, -26, 14)
	finger2:setImage(RegisterImage(0xDAD3A048BDCE60F))
	self:addElement(finger2)
	self.finger2 = finger2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
