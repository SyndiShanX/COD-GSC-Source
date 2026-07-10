require("x64:4375d7f763f4320")
CoD.CODCasterTeamBaseBar = InheritFrom(LUI.UIElement)
CoD.CODCasterTeamBaseBar.__defaultWidth = 12
CoD.CODCasterTeamBaseBar.__defaultHeight = 149
CoD.CODCasterTeamBaseBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CODCasterTeamBaseBar)
	self.id = "CODCasterTeamBaseBar"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local TeamBaseBar = CoD.CODCasterTeamBaseBarColor.new(f1_arg0, f1_arg1, 0, 0, 0, 12, 0, 0, 0, 149)
	TeamBaseBar:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_5B17513E9D94CE76"))
	TeamBaseBar:setShaderVector(0, 0, 1, 0, 0)
	TeamBaseBar:setShaderVector(1, 0, 0, 0, 0)
	TeamBaseBar:setShaderVector(2, 0.96, 1, 0, 0)
	TeamBaseBar:setShaderVector(3, 0, 0, 0, 0)
	self:addElement(TeamBaseBar)
	self.TeamBaseBar = TeamBaseBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CODCasterTeamBaseBar.__onClose = function(f2_arg0)
	f2_arg0.TeamBaseBar:close()
end
