CoD.WarzonePlayerArrow = InheritFrom(LUI.UIElement)
CoD.WarzonePlayerArrow.__defaultWidth = 64
CoD.WarzonePlayerArrow.__defaultHeight = 64
CoD.WarzonePlayerArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzonePlayerArrow)
	self.id = "WarzonePlayerArrow"
	self.soundSet = "none"
	local arrow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	arrow:setImage(RegisterImage(@"hash_77C92505D1F238BC"))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
