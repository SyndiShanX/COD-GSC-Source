CoD.Tak5Reticle_Bracket = InheritFrom(LUI.UIElement)
CoD.Tak5Reticle_Bracket.__defaultWidth = 800
CoD.Tak5Reticle_Bracket.__defaultHeight = 380
CoD.Tak5Reticle_Bracket.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tak5Reticle_Bracket)
	self.id = "Tak5Reticle_Bracket"
	self.soundSet = "default"
	local right = LUI.UIImage.new(0, 0, 700, 762, 0.5, 0.5, -193, 193)
	right:setZRot(180)
	right:setImage(RegisterImage(@"uie_ui_hud_tak5_bracket"))
	self:addElement(right)
	self.right = right
	local left = LUI.UIImage.new(0, 0, 38, 100, 0.5, 0.5, -193, 193)
	left:setImage(RegisterImage(@"uie_ui_hud_tak5_bracket"))
	self:addElement(left)
	self.left = left
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
