require("x64:a0b077e734bb58b")
require("x64:339e8bfa38f633c")
CoD.PositionDraft_ViewTeams_Prompt = InheritFrom(LUI.UIElement)
CoD.PositionDraft_ViewTeams_Prompt.__defaultWidth = 600
CoD.PositionDraft_ViewTeams_Prompt.__defaultHeight = 300
CoD.PositionDraft_ViewTeams_Prompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PlayerRoleUtility.UpdateEnemyCountModels(f1_arg1)
	self:setClass(CoD.PositionDraft_ViewTeams_Prompt)
	self.id = "PositionDraft_ViewTeams_Prompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local viewTeams = LUI.UIText.new(0, 0, 0, 600, 0, 0, 240, 277)
	viewTeams:setRGB(0.66, 0.66, 0.66)
	viewTeams:setAlpha(0)
	viewTeams:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/view_teams"))
	viewTeams:setTTF("default")
	viewTeams:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	viewTeams:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(viewTeams)
	self.viewTeams = viewTeams
	local FriendlyStatus = CoD.PositionDraft_FriendlyTeamStatusBar.new(f1_arg0, f1_arg1, 0, 0, 89.5, 239.5, 0, 0, 199.5, 219.5)
	self:addElement(FriendlyStatus)
	self.FriendlyStatus = FriendlyStatus
	local EnemyStatus = CoD.PositionDraft_EnemyTeamStatusBar.new(f1_arg0, f1_arg1, 0, 0, 360, 510, 0, 0, 199.5, 219.5)
	self:addElement(EnemyStatus)
	self.EnemyStatus = EnemyStatus
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_ViewTeams_Prompt.__onClose = function(f2_arg0)
	f2_arg0.FriendlyStatus:close()
	f2_arg0.EnemyStatus:close()
end
