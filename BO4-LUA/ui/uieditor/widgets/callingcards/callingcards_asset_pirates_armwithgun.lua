CoD.CallingCards_Asset_Pirates_armwithgun = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Pirates_armwithgun.__defaultWidth = 10
CoD.CallingCards_Asset_Pirates_armwithgun.__defaultHeight = 10
CoD.CallingCards_Asset_Pirates_armwithgun.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Pirates_armwithgun)
	self.id = "CallingCards_Asset_Pirates_armwithgun"
	self.soundSet = "default"
	local armwithgun = LUI.UIImage.new(0, 0, -13, 211, 0, 0, -86, 74)
	armwithgun:setImage(RegisterImage("uie_ui_icon_callingcards_pirates_arm2"))
	self:addElement(armwithgun)
	self.armwithgun = armwithgun
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
