require("x64:b9a16de4d977bda")
require("x64:6d44165b8920650")
CoD.ButtonFrame_ArenaBarracksStats = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_ArenaBarracksStats.__defaultWidth = 469
CoD.ButtonFrame_ArenaBarracksStats.__defaultHeight = 500
CoD.ButtonFrame_ArenaBarracksStats.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_ArenaBarracksStats)
	self.id = "ButtonFrame_ArenaBarracksStats"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bgScore2 = LUI.UIImage.new(0.5, 0.5, -226, 226, 0, 0, 78.5, 250.5)
	bgScore2:setRGB(0.23, 0.23, 0.23)
	bgScore2:setAlpha(0.25)
	self:addElement(bgScore2)
	self.bgScore2 = bgScore2
	local bgScore = LUI.UIImage.new(0.5, 0.5, -226, 226, 0, 0, 261, 365)
	bgScore:setRGB(0.23, 0.23, 0.23)
	bgScore:setAlpha(0.25)
	self:addElement(bgScore)
	self.bgScore = bgScore
	local FirstPlaceStat = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 212.5, 514.5, 0, 0, 132, 153)
	FirstPlaceStat.StatHeaderText:setText(LocalizeToUpperString(@"hash_42ABF42E82EB4AB3"))
	FirstPlaceStat.StatValue:setText(CoD.PlayerStatsUtility.GetArenaBarracksStat(f1_arg0, @"leagueplaystats", @"hash_13CD14843EE22778", 5589))
	self:addElement(FirstPlaceStat)
	self.FirstPlaceStat = FirstPlaceStat
	local TopTenStat = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 212.5, 514.5, 0, 0, 178, 199)
	TopTenStat.StatHeaderText:setText(LocalizeToUpperString(@"hash_6B828F9D4DF6BFCF"))
	TopTenStat.StatValue:setText(CoD.PlayerStatsUtility.GetArenaBarracksStat(f1_arg0, @"leagueplaystats", @"hash_560AFA63073D5CD4", 5589))
	self:addElement(TopTenStat)
	self.TopTenStat = TopTenStat
	local TopFiveStat = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 212.5, 514.5, 0, 0, 155, 176)
	TopFiveStat.StatHeaderText:setText(LocalizeToUpperString(@"hash_77C475D48916CFB0"))
	TopFiveStat.StatValue:setText(CoD.PlayerStatsUtility.GetArenaBarracksStat(f1_arg0, @"leagueplaystats", 0x2B2E96F4A06832, 5589))
	self:addElement(TopFiveStat)
	self.TopFiveStat = TopFiveStat
	local TopTwentyFiveStat = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 212.5, 514.5, 0, 0, 201.5, 222.5)
	TopTwentyFiveStat.StatHeaderText:setText(LocalizeToUpperString(@"hash_1D0694434493E4B6"))
	TopTwentyFiveStat.StatValue:setText(CoD.PlayerStatsUtility.GetArenaBarracksStat(f1_arg0, @"leagueplaystats", @"hash_715015D9AC9517CC", 5589))
	self:addElement(TopTwentyFiveStat)
	self.TopTwentyFiveStat = TopTwentyFiveStat
	local Placements = LUI.UIText.new(0, 0, 130, 339, 0, 0, 50, 65)
	Placements:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Placements:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_310CD8744F277B18"))
	Placements:setTTF("ttmussels_regular")
	Placements:setLetterSpacing(1)
	Placements:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Placements:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Placements)
	self.Placements = Placements
	local LeagueCareerTitle = LUI.UIText.new(0, 0, 6.5, 462.5, 0, 0, 19, 46)
	LeagueCareerTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LeagueCareerTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6EED2099B101A416"))
	LeagueCareerTitle:setTTF("ttmussels_regular")
	LeagueCareerTitle:setLetterSpacing(2)
	LeagueCareerTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	LeagueCareerTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(LeagueCareerTitle)
	self.LeagueCareerTitle = LeagueCareerTitle
	local FirstPlace = CoD.ButtonFrame_ArenaBarracksStats_Firstplace.new(f1_arg0, f1_arg1, 0, 0, 13, 456, 0, 0, 268, 373)
	FirstPlace:subscribeToGlobalModel(f1_arg1, "LeaguePlay", nil, function(model)
		FirstPlace:setModel(model, f1_arg1)
	end)
	self:addElement(FirstPlace)
	self.FirstPlace = FirstPlace
	local HighestPlaceTitle = LUI.UIText.new(0, 0, 36.5, 244.5, 0, 0, 114.5, 135.5)
	HighestPlaceTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HighestPlaceTitle:setAlpha(0.7)
	HighestPlaceTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_481E8DE6BBBDD83"))
	HighestPlaceTitle:setTTF("ttmussels_regular")
	HighestPlaceTitle:setLetterSpacing(1)
	HighestPlaceTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	HighestPlaceTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(HighestPlaceTitle)
	self.HighestPlaceTitle = HighestPlaceTitle
	local StatsValueHighestPlace = LUI.UIText.new(0, 0, 42.5, 238.5, 0, 0, 140.5, 222.5)
	StatsValueHighestPlace:setRGB(0.69, 0.56, 0.04)
	StatsValueHighestPlace:setText(CoD.PlayerStatsUtility.GetArenaBarracksStat(f1_arg0, @"leagueplaystats", @"bestsubdivisionrank", 5589))
	StatsValueHighestPlace:setTTF("ttmussels_demibold")
	StatsValueHighestPlace:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatsValueHighestPlace:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(StatsValueHighestPlace)
	self.StatsValueHighestPlace = StatsValueHighestPlace
	local dotline01 = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 254, 258)
	dotline01:setAlpha(0.2)
	dotline01:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline01:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline01)
	self.dotline01 = dotline01
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_ArenaBarracksStats.__resetProperties = function(f4_arg0)
	f4_arg0.HighestPlaceTitle:completeAnimation()
	f4_arg0.FirstPlaceStat:completeAnimation()
	f4_arg0.TopFiveStat:completeAnimation()
	f4_arg0.TopTenStat:completeAnimation()
	f4_arg0.TopTwentyFiveStat:completeAnimation()
	f4_arg0.HighestPlaceTitle:setTopBottom(0, 0, 114.5, 135.5)
	f4_arg0.FirstPlaceStat:setTopBottom(0, 0, 132, 153)
	f4_arg0.FirstPlaceStat:setScale(1, 1)
	f4_arg0.TopFiveStat:setTopBottom(0, 0, 155, 176)
	f4_arg0.TopFiveStat:setScale(1, 1)
	f4_arg0.TopTenStat:setTopBottom(0, 0, 178, 199)
	f4_arg0.TopTenStat:setScale(1, 1)
	f4_arg0.TopTwentyFiveStat:setTopBottom(0, 0, 201.5, 222.5)
	f4_arg0.TopTwentyFiveStat:setScale(1, 1)
end
CoD.ButtonFrame_ArenaBarracksStats.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.FirstPlaceStat:completeAnimation()
			f6_arg0.FirstPlaceStat:setTopBottom(0, 0, 71, 92)
			f6_arg0.FirstPlaceStat:setScale(0.84, 0.84)
			f6_arg0.clipFinished(f6_arg0.FirstPlaceStat)
			f6_arg0.TopTenStat:completeAnimation()
			f6_arg0.TopTenStat:setTopBottom(0, 0, 107, 128)
			f6_arg0.TopTenStat:setScale(0.84, 0.84)
			f6_arg0.clipFinished(f6_arg0.TopTenStat)
			f6_arg0.TopFiveStat:completeAnimation()
			f6_arg0.TopFiveStat:setTopBottom(0, 0, 89, 110)
			f6_arg0.TopFiveStat:setScale(0.84, 0.84)
			f6_arg0.clipFinished(f6_arg0.TopFiveStat)
			f6_arg0.TopTwentyFiveStat:completeAnimation()
			f6_arg0.TopTwentyFiveStat:setTopBottom(0, 0, 125.5, 146.5)
			f6_arg0.TopTwentyFiveStat:setScale(0.84, 0.84)
			f6_arg0.clipFinished(f6_arg0.TopTwentyFiveStat)
			f6_arg0.HighestPlaceTitle:completeAnimation()
			f6_arg0.HighestPlaceTitle:setTopBottom(0, 0, 51, 63)
			f6_arg0.clipFinished(f6_arg0.HighestPlaceTitle)
		end,
	},
}
CoD.ButtonFrame_ArenaBarracksStats.__onClose = function(f7_arg0)
	f7_arg0.FirstPlaceStat:close()
	f7_arg0.TopTenStat:close()
	f7_arg0.TopFiveStat:close()
	f7_arg0.TopTwentyFiveStat:close()
	f7_arg0.FirstPlace:close()
end
