CoD.GameEndScoreTeamIcon = InheritFrom(LUI.UIElement)
CoD.GameEndScoreTeamIcon.__defaultWidth = 100
CoD.GameEndScoreTeamIcon.__defaultHeight = 100
CoD.GameEndScoreTeamIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreTeamIcon)
	self.id = "GameEndScoreTeamIcon"
	self.soundSet = "default"
	local StandardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StandardIcon:setImage(RegisterImage(@"hash_3EB54B7AC43CFC03"))
	self:addElement(StandardIcon)
	self.StandardIcon = StandardIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
