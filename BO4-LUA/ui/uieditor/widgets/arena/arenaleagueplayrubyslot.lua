CoD.arenaLeaguePlayRubySlot = InheritFrom(LUI.UIElement)
CoD.arenaLeaguePlayRubySlot.__defaultWidth = 40
CoD.arenaLeaguePlayRubySlot.__defaultHeight = 40
CoD.arenaLeaguePlayRubySlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.arenaLeaguePlayRubySlot)
	self.id = "arenaLeaguePlayRubySlot"
	self.soundSet = "none"
	local RubySlot = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -20, 20)
	RubySlot:setImage(RegisterImage(0x81EAB9F8F5950E7))
	self:addElement(RubySlot)
	self.RubySlot = RubySlot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
