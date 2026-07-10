CoD.ui_icon_callingcards_heavymetal_cop2 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_heavymetal_cop2.__defaultWidth = 10
CoD.ui_icon_callingcards_heavymetal_cop2.__defaultHeight = 10
CoD.ui_icon_callingcards_heavymetal_cop2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_heavymetal_cop2)
	self.id = "ui_icon_callingcards_heavymetal_cop2"
	self.soundSet = "default"
	local cop2 = LUI.UIImage.new(0, 0, -88, 216, 0, 0, 0, 248)
	cop2:setImage(RegisterImage(@"uie_ui_menu_callingcards_heavymetal_char1"))
	self:addElement(cop2)
	self.cop2 = cop2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
