require("x64:889e6abaea2a560")
CoD.CodCasterTeamIdentityInformationPanel = InheritFrom(LUI.UIElement)
CoD.CodCasterTeamIdentityInformationPanel.__defaultWidth = 684
CoD.CodCasterTeamIdentityInformationPanel.__defaultHeight = 540
CoD.CodCasterTeamIdentityInformationPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterTeamIdentityInformationPanel)
	self.id = "CodCasterTeamIdentityInformationPanel"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterTeam1Information = CoD.CodCasterTeamIdentityInformation.new(f1_arg0, f1_arg1, 0, 0, 0, 684, 0, 0, -1, 269)
	CodCasterTeam1Information.TeamLogoTitle:setText(LocalizeToUpperString(0x53D63E3F4E6CDC0))
	CodCasterTeam1Information.TeamNameTitle:setText(LocalizeToUpperString(0xD1CDFD2190AC31C))
	CodCasterTeam1Information.TeamColorTitle:setText(LocalizeToUpperString(0x1BE11FFFC43DC2E))
	CodCasterTeam1Information:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team1", function(model)
		CodCasterTeam1Information:setModel(model, f1_arg1)
	end)
	self:addElement(CodCasterTeam1Information)
	self.CodCasterTeam1Information = CodCasterTeam1Information
	local CodCasterTeam2Information = CoD.CodCasterTeamIdentityInformation.new(f1_arg0, f1_arg1, 0, 0, 0, 684, 0, 0, 282, 560)
	CodCasterTeam2Information.TeamLogoTitle:setText(LocalizeToUpperString(0x7594C4235BAF38F))
	CodCasterTeam2Information.TeamNameTitle:setText(LocalizeToUpperString(0x750B8544C6063AB))
	CodCasterTeam2Information.TeamColorTitle:setText(LocalizeToUpperString(0x75FBF79F95C5DBF))
	CodCasterTeam2Information:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team2", function(model)
		CodCasterTeam2Information:setModel(model, f1_arg1)
	end)
	self:addElement(CodCasterTeam2Information)
	self.CodCasterTeam2Information = CodCasterTeam2Information
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterTeamIdentityInformationPanel.__resetProperties = function(f4_arg0)
	f4_arg0.CodCasterTeam1Information:completeAnimation()
	f4_arg0.CodCasterTeam2Information:completeAnimation()
	f4_arg0.CodCasterTeam1Information:setAlpha(1)
	f4_arg0.CodCasterTeam2Information:setLeftRight(0, 0, 0, 684)
	f4_arg0.CodCasterTeam2Information:setTopBottom(0, 0, 282, 560)
	f4_arg0.CodCasterTeam2Information:setAlpha(1)
end
CoD.CodCasterTeamIdentityInformationPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.CodCasterTeam1Information:completeAnimation()
			f5_arg0.CodCasterTeam1Information:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CodCasterTeam1Information)
			f5_arg0.CodCasterTeam2Information:completeAnimation()
			f5_arg0.CodCasterTeam2Information:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CodCasterTeam2Information)
		end,
	},
	ShowBoth = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	ShowTeam1Only = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.CodCasterTeam2Information:completeAnimation()
			f7_arg0.CodCasterTeam2Information:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CodCasterTeam2Information)
		end,
	},
	ShowTeam2Only = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.CodCasterTeam1Information:completeAnimation()
			f8_arg0.CodCasterTeam1Information:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CodCasterTeam1Information)
			f8_arg0.CodCasterTeam2Information:completeAnimation()
			f8_arg0.CodCasterTeam2Information:setLeftRight(0, 0, 0, 684)
			f8_arg0.CodCasterTeam2Information:setTopBottom(0, 0, -1, 269)
			f8_arg0.clipFinished(f8_arg0.CodCasterTeam2Information)
		end,
	},
}
CoD.CodCasterTeamIdentityInformationPanel.__onClose = function(f9_arg0)
	f9_arg0.CodCasterTeam1Information:close()
	f9_arg0.CodCasterTeam2Information:close()
end
