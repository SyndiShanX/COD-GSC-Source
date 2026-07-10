CoD.ZM_ReviveClampedArrow = InheritFrom(LUI.UIElement)
CoD.ZM_ReviveClampedArrow.__defaultWidth = 390
CoD.ZM_ReviveClampedArrow.__defaultHeight = 96
CoD.ZM_ReviveClampedArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZM_ReviveClampedArrow)
	self.id = "ZM_ReviveClampedArrow"
	self.soundSet = "default"
	local arrow = LUI.UIImage.new(1, 1, -96, 0, 0, 1, 0, 0)
	arrow:setZRot(90)
	arrow:setImage(RegisterImage(@"uie_t7_zm_hud_revive_arrow"))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
