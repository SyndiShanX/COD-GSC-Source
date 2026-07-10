require("x64:82fe168192ec8a7")
CoD.WarzoneTeamListContainer = InheritFrom(LUI.UIElement)
CoD.WarzoneTeamListContainer.__defaultWidth = 385
CoD.WarzoneTeamListContainer.__defaultHeight = 258
CoD.WarzoneTeamListContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneTeamListContainer)
	self.id = "WarzoneTeamListContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local TeamPlayerList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	TeamPlayerList:setLeftRight(0, 0, 0, 385)
	TeamPlayerList:setTopBottom(1, 1, -258, 0)
	TeamPlayerList:setWidgetType(CoD.WZTeamListItem)
	TeamPlayerList:setVerticalCount(5)
	TeamPlayerList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamPlayerList:setDataSource("PlayerListWZ")
	self:addElement(TeamPlayerList)
	self.TeamPlayerList = TeamPlayerList
	TeamPlayerList.id = "TeamPlayerList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneTeamListContainer.__onClose = function(f2_arg0)
	f2_arg0.TeamPlayerList:close()
end
