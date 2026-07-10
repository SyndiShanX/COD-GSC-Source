require("x64:e473f35708d423a")
require("x64:7ec6bc10fa8e6b3")
require("x64:226aaa4f7a48917")
CoD.ArenaSkillEvaluationWidget = InheritFrom(LUI.UIElement)
CoD.ArenaSkillEvaluationWidget.__defaultWidth = 960
CoD.ArenaSkillEvaluationWidget.__defaultHeight = 740
CoD.ArenaSkillEvaluationWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaSkillEvaluationWidget)
	self.id = "ArenaSkillEvaluationWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Bg = CoD.ArenaSkillEvaluationBg.new(f1_arg0, f1_arg1, 0, 0, -121, 1081, 0, 0, 73, 765)
	self:addElement(Bg)
	self.Bg = Bg
	local MatchesPlayedText2 = LUI.UIText.new(0, 0, 142.5, 225.5, 0, 0, 329.5, 374.5)
	MatchesPlayedText2:setRGB(0.92, 0.92, 0.92)
	MatchesPlayedText2:setText(CoD.ArenaLeaguePlayUtility.GetCompletedPlacementMatchesString(f1_arg1, @"menu/empty"))
	MatchesPlayedText2:setTTF("ttmussels_demibold")
	MatchesPlayedText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	MatchesPlayedText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MatchesPlayedText2)
	self.MatchesPlayedText2 = MatchesPlayedText2
	local MatchesPlayedText = LUI.UIText.new(0, 0, 225.5, 349.5, 0, 0, 329.5, 374.5)
	MatchesPlayedText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	MatchesPlayedText:setText(CoD.ArenaLeaguePlayUtility.GetCompletedPlacementMatchesProgressString(f1_arg1, 0xC973F0F3138027))
	MatchesPlayedText:setTTF("ttmussels_demibold")
	MatchesPlayedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MatchesPlayedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MatchesPlayedText)
	self.MatchesPlayedText = MatchesPlayedText
	local AARLeaguePlayPlacementList = CoD.AAR_LeaguePlay_PlacementList.new(f1_arg0, f1_arg1, 0, 0, 226, 726, 0.02, 0.02, 287, 387)
	self:addElement(AARLeaguePlayPlacementList)
	self.AARLeaguePlayPlacementList = AARLeaguePlayPlacementList
	local MatchesLeft = LUI.UIText.new(0, 0, 160, 800, 0, 0, 402, 432)
	MatchesLeft:setRGB(0.92, 0.92, 0.92)
	MatchesLeft:setText(CoD.ArenaLeaguePlayUtility.GetMatchesLeftProgressString(f1_arg1, @"hash_1C095D2FF1EE2755"))
	MatchesLeft:setTTF("ttmussels_demibold")
	MatchesLeft:setLetterSpacing(4)
	MatchesLeft:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MatchesLeft:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MatchesLeft)
	self.MatchesLeft = MatchesLeft
	local skillEvaluation = LUI.UIText.new(0, 0, 109.5, 850.5, 0, 0, 198, 243)
	skillEvaluation:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	skillEvaluation:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_73E4553EECDA2C32"))
	skillEvaluation:setTTF("ttmussels_demibold")
	skillEvaluation:setLetterSpacing(2)
	skillEvaluation:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	skillEvaluation:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(skillEvaluation)
	self.skillEvaluation = skillEvaluation
	local playerXMatches = LUI.UIText.new(0, 0, 38.5, 921.5, 0, 0, 243, 264)
	playerXMatches:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	playerXMatches:setText(CoD.ArenaLeaguePlayUtility.GetMaxMatchesProgressString(f1_arg1, @"hash_520F5978FB90FA5A"))
	playerXMatches:setTTF("ttmussels_regular")
	playerXMatches:setLetterSpacing(4)
	playerXMatches:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	playerXMatches:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(playerXMatches)
	self.playerXMatches = playerXMatches
	local explanation = LUI.UIText.new(0, 0, 151.5, 808.5, 0, 0, 695, 716)
	explanation:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	explanation:setAlpha(0.5)
	explanation:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3646B33B96EB86BD"))
	explanation:setTTF("dinnext_regular")
	explanation:setLetterSpacing(1)
	explanation:setLineSpacing(1)
	explanation:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	explanation:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(explanation)
	self.explanation = explanation
	local ArenaEventTimerLarge = CoD.ArenaEventTimerLarge.new(f1_arg0, f1_arg1, 0, 0, 370, 630, 0, 0, 139, 164)
	ArenaEventTimerLarge:setAlpha(0)
	ArenaEventTimerLarge:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventTimer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArenaEventTimerLarge.EventEndsIn:setText(f2_local0)
		end
	end)
	self:addElement(ArenaEventTimerLarge)
	self.ArenaEventTimerLarge = ArenaEventTimerLarge
	local TopTriangle = LUI.UIImage.new(0.5, 0.5, -46, 46, 0.5, 0.5, -112, -68)
	TopTriangle:setRGB(0.92, 0.92, 0.92)
	TopTriangle:setAlpha(0.05)
	TopTriangle:setScale(0.3, 0.3)
	TopTriangle:setImage(RegisterImage(@"uie_ui_menu_arena_league_hub_triangle"))
	self:addElement(TopTriangle)
	self.TopTriangle = TopTriangle
	AARLeaguePlayPlacementList.id = "AARLeaguePlayPlacementList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaSkillEvaluationWidget.__onClose = function(f3_arg0)
	f3_arg0.Bg:close()
	f3_arg0.AARLeaguePlayPlacementList:close()
	f3_arg0.ArenaEventTimerLarge:close()
end
