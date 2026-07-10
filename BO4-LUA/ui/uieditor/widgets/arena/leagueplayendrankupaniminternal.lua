require("x64:f0719e4ce2c9bb1")
require("x64:254d7496f056d77")
require("x64:9f36e58fca789e6")
CoD.LeaguePlayEndrankupAnimInternal = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEndrankupAnimInternal.__defaultWidth = 600
CoD.LeaguePlayEndrankupAnimInternal.__defaultHeight = 800
CoD.LeaguePlayEndrankupAnimInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEndrankupAnimInternal)
	self.id = "LeaguePlayEndrankupAnimInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Ruby = CoD.LeaguePlayEndrankupAnimInternalRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -171.5, 171.5, 0, 0, 646, 850)
	Ruby:linkToElementModel(self, nil, false, function(model)
		Ruby:setModel(model, f1_arg1)
	end)
	self:addElement(Ruby)
	self.Ruby = Ruby
	local PlacementText = CoD.LeaguePlayEndRankUpPlacementText.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 22, 94)
	PlacementText:linkToElementModel(self, nil, false, function(model)
		PlacementText:setModel(model, f1_arg1)
	end)
	self:addElement(PlacementText)
	self.PlacementText = PlacementText
	local RankIcon = CoD.LeaguePlayEndRankUpRankIcon.new(f1_arg0, f1_arg1, 0, 0, 75, 525, 0, 0, 108, 651)
	RankIcon:linkToElementModel(self, nil, false, function(model)
		RankIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	self:linkToElementModel(self, "rankUpUpdateRubies", true, function(model)
		local f5_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, true) then
			CoD.ArenaLeaguePlayUtility.AnimateRankUpRubies(f1_arg0, self.Ruby, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEndrankupAnimInternal.__onClose = function(f6_arg0)
	f6_arg0.Ruby:close()
	f6_arg0.PlacementText:close()
	f6_arg0.RankIcon:close()
end
