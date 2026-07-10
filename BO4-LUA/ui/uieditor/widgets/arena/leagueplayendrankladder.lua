require("x64:4ab72db8012133a")
CoD.leaguePlayEndRankladder = InheritFrom(LUI.UIElement)
CoD.leaguePlayEndRankladder.__defaultWidth = 898
CoD.leaguePlayEndRankladder.__defaultHeight = 220
CoD.leaguePlayEndRankladder.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.leaguePlayEndRankladder)
	self.id = "leaguePlayEndRankladder"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local LadderRows = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	LadderRows:setLeftRight(0.5, 0.5, -449, 449)
	LadderRows:setTopBottom(0, 0, 0, 164)
	LadderRows:setWidgetType(CoD.AAR_LeaguePlayLadderEntry)
	LadderRows:setVerticalCount(3)
	LadderRows:setSpacing(10)
	LadderRows:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LadderRows:setDataSource("LeaguePlayLadderMemberList")
	LadderRows:subscribeToGlobalModel(f1_arg1, "LeaguePlayLadderMemberList", "allXuidInfoLoaded", function(model)
		CoD.ArenaLeaguePlayUtility.UpdateLadderListCurrentPlayerFocus(self, LadderRows)
	end)
	self:addElement(LadderRows)
	self.LadderRows = LadderRows
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "LeaguePlayLadderMemberList.loaded", function(model)
		local f3_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueGreaterThan("LeaguePlayLadderMemberList.loaded", 0) then
			CoD.ArenaLeaguePlayUtility.ForceLadderPlayerArrows(f3_local0, f1_arg1)
		end
	end)
	LadderRows.id = "LadderRows"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.leaguePlayEndRankladder.__onClose = function(f4_arg0)
	f4_arg0.LadderRows:close()
end
