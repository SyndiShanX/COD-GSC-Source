CoD.CallingCards_Asset_armyguy_arm = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_armyguy_arm.__defaultWidth = 272
CoD.CallingCards_Asset_armyguy_arm.__defaultHeight = 96
CoD.CallingCards_Asset_armyguy_arm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_armyguy_arm)
	self.id = "CallingCards_Asset_armyguy_arm"
	self.soundSet = "default"
	local arm = LUI.UIImage.new(0, 0, 136, 272, 0, 0, 0, 96)
	arm:setImage(RegisterImage(@"uie_ui_icon_callingcards_backout_100percent_armyguy_arm"))
	self:addElement(arm)
	self.arm = arm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
