CoD.grenadeWarningArrow = InheritFrom(LUI.UIElement)
CoD.grenadeWarningArrow.__defaultWidth = 105
CoD.grenadeWarningArrow.__defaultHeight = 105
CoD.grenadeWarningArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.grenadeWarningArrow)
	self.id = "grenadeWarningArrow"
	self.soundSet = "default"
	local arrow = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, 17.5, 81.5)
	arrow:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_arrow_02"))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
