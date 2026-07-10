CoD.WZObituaryTeamIcon = InheritFrom(LUI.UIElement)
CoD.WZObituaryTeamIcon.__defaultWidth = 26
CoD.WZObituaryTeamIcon.__defaultHeight = 26
CoD.WZObituaryTeamIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZObituaryTeamIcon)
	self.id = "WZObituaryTeamIcon"
	self.soundSet = "default"
	local Backer = LUI.UIImage.new(0, 0, 0, 26, 0, 0, 0, 26)
	Backer:setRGB(0.05, 0.41, 0.37)
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Backer:setShaderVector(0, 0.03, 0.03, 0.03, 0.03)
	self:addElement(Backer)
	self.Backer = Backer
	local TeamNumber = LUI.UIText.new(0, 0, 0, 26, 0, 0, 0, 26)
	TeamNumber:setText(1)
	TeamNumber:setTTF("ttmussels_regular")
	TeamNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TeamNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TeamNumber)
	self.TeamNumber = TeamNumber
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
