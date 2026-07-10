CoD.WeaponLevelUpBrackets = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpBrackets.__defaultWidth = 514
CoD.WeaponLevelUpBrackets.__defaultHeight = 210
CoD.WeaponLevelUpBrackets.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpBrackets)
	self.id = "WeaponLevelUpBrackets"
	self.soundSet = "default"
	local BracketBottomRight = LUI.UIImage.new(1, 1, -20, 0, 1, 1, -20, 0)
	BracketBottomRight:setAlpha(0.5)
	BracketBottomRight:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_bottomright"))
	self:addElement(BracketBottomRight)
	self.BracketBottomRight = BracketBottomRight
	local BracketTopRight = LUI.UIImage.new(1, 1, -20, 0, 0, 0, 0, 20)
	BracketTopRight:setAlpha(0.5)
	BracketTopRight:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_topright"))
	self:addElement(BracketTopRight)
	self.BracketTopRight = BracketTopRight
	local BracketTopLeft = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	BracketTopLeft:setAlpha(0.5)
	BracketTopLeft:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_topleft"))
	self:addElement(BracketTopLeft)
	self.BracketTopLeft = BracketTopLeft
	local BracketBottomLeft = LUI.UIImage.new(0, 0, 0, 20, 1, 1, -20, 0)
	BracketBottomLeft:setAlpha(0.5)
	BracketBottomLeft:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_bottomleft"))
	self:addElement(BracketBottomLeft)
	self.BracketBottomLeft = BracketBottomLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
