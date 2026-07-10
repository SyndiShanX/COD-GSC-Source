require("x64:a876df622faedff")
require("x64:7436037cf4fb98c")
require("x64:38c11a77e96e48c")
CoD.LeaguePlayLeaderboard = InheritFrom(LUI.UIElement)
CoD.LeaguePlayLeaderboard.__defaultWidth = 1920
CoD.LeaguePlayLeaderboard.__defaultHeight = 1080
CoD.LeaguePlayLeaderboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ArenaUtility.InitLadderListLoadedModel(f1_arg1)
	self:setClass(CoD.LeaguePlayLeaderboard)
	self.id = "LeaguePlayLeaderboard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ErrorText = LUI.UIText.new(0, 0, 544, 1344, 0, 0, 521.5, 558.5)
	ErrorText:setAlpha(0)
	ErrorText:setText(Engine[0xF9F1239CFD921FE](0x354A89EC41ABE97))
	ErrorText:setTTF("default")
	ErrorText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ErrorText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ErrorText)
	self.ErrorText = ErrorText
	local LeaderboardEntries = LUI.UIList.new(f1_arg0, f1_arg1, 13, 0, nil, false, false, false, false)
	LeaderboardEntries:setLeftRight(0, 0, 286, 1184)
	LeaderboardEntries:setTopBottom(0, 0, 306, 903)
	LeaderboardEntries:setWidgetType(CoD.LeaguePlayLeaderboardEntry)
	LeaderboardEntries:setVerticalCount(10)
	LeaderboardEntries:setSpacing(13)
	LeaderboardEntries:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LeaderboardEntries:setVerticalCounter(CoD.verticalCounter)
	LeaderboardEntries:setDataSource("LeaguePlayLadderMemberList")
	LeaderboardEntries:subscribeToGlobalModel(f1_arg1, "LeaguePlayLadderMemberList", "allXuidInfoLoaded", function(model)
		local f2_local0 = LeaderboardEntries
		CoD.ArenaLeaguePlayUtility.UpdateLadderListMemberRubyCount(self, f2_local0)
		CoD.ArenaLeaguePlayUtility.UpdateLadderListCurrentPlayerFocus(self, f2_local0)
	end)
	self:addElement(LeaderboardEntries)
	self.LeaderboardEntries = LeaderboardEntries
	local RankPointsTitle = LUI.UIText.new(0, 0, 855, 1005, 0, 0, 286, 301)
	RankPointsTitle:setRGB(0.92, 0.92, 0.92)
	RankPointsTitle:setText(Engine[0xF9F1239CFD921FE](0x1275B8C997A0D5E))
	RankPointsTitle:setTTF("0arame_mono_stencil")
	RankPointsTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RankPointsTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(RankPointsTitle)
	self.RankPointsTitle = RankPointsTitle
	local GemReward = LUI.UIText.new(0, 0, 1019, 1169, 0, 0, 286, 301)
	GemReward:setRGB(0.92, 0.92, 0.92)
	GemReward:setText(Engine[0xF9F1239CFD921FE](0x7A8731E3BA139AF))
	GemReward:setTTF("0arame_mono_stencil")
	GemReward:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GemReward:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(GemReward)
	self.GemReward = GemReward
	local RankTitle = LUI.UIText.new(0, 0, 250, 410, 0, 0, 286, 301)
	RankTitle:setRGB(0.92, 0.92, 0.92)
	RankTitle:setText(LocalizeToUpperString(0x49C509B807FDA37))
	RankTitle:setTTF("0arame_mono_stencil")
	RankTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RankTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(RankTitle)
	self.RankTitle = RankTitle
	local topline5 = LUI.UIImage.new(0, 0, 1004, 1184, 0, 0, 303, 306)
	topline5:setRGB(0.92, 0.89, 0.72)
	topline5:setAlpha(0.05)
	self:addElement(topline5)
	self.topline5 = topline5
	local topline4 = LUI.UIImage.new(0, 0, 864, 996, 0, 0, 303, 306)
	topline4:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topline4:setAlpha(0.05)
	self:addElement(topline4)
	self.topline4 = topline4
	local topline3 = LUI.UIImage.new(0, 0, 438, 856, 0, 0, 303, 306)
	topline3:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topline3:setAlpha(0.05)
	self:addElement(topline3)
	self.topline3 = topline3
	local topline2 = LUI.UIImage.new(0, 0, 382, 430, 0, 0, 303, 306)
	topline2:setRGB(0.92, 0.89, 0.72)
	topline2:setAlpha(0.05)
	self:addElement(topline2)
	self.topline2 = topline2
	local topline1 = LUI.UIImage.new(0, 0, 286, 374, 0, 0, 303, 306)
	topline1:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topline1:setAlpha(0.05)
	self:addElement(topline1)
	self.topline1 = topline1
	local RefreshingLabel = LUI.UIText.new(0, 0, 704, 1184, 0, 0, 178, 203)
	RefreshingLabel:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	RefreshingLabel:setText(Engine[0xF9F1239CFD921FE](0x74560BEAFB9F4D1))
	RefreshingLabel:setTTF("ttmussels_regular")
	RefreshingLabel:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	RefreshingLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RefreshingLabel)
	self.RefreshingLabel = RefreshingLabel
	local ArenaLeaguePlayLadderSkillDivision = CoD.ArenaLeaguePlay_LadderSkillDivision.new(f1_arg0, f1_arg1, 0, 0, 283, 1181, 0, 0, 120, 216)
	self:addElement(ArenaLeaguePlayLadderSkillDivision)
	self.ArenaLeaguePlayLadderSkillDivision = ArenaLeaguePlayLadderSkillDivision
	self:mergeStateConditions({
		{
			stateName = "DailyBonusAvailable",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730])
				if f3_local0 then
					f3_local0 = CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, f1_arg1)
					if f3_local0 then
						f3_local0 = not CoD.ArenaUtility.IsDailyPoolRemainingCompleteTimer(self, f1_arg1, element)
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LeaguePlayLadderMemberList", "allXuidInfoLoaded", true) and CoD.ModelUtility.IsGlobalDataSourceModelValueNil(f1_arg1, "LeaguePlayLadder", "leagueNameCode")
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local13, f1_local15["lobbyPlaylist.name"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local13, f1_local15["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local13, f1_local15["LeaguePlayLadder.entityLadderRank"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LeaguePlayLadder.entityLadderRank",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = DataSources.LeaguePlayLadderMemberList.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.allXuidInfoLoaded, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "allXuidInfoLoaded",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = DataSources.LeaguePlayLadder.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.leagueNameCode, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "leagueNameCode",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "LeaguePlayLadderMemberList.loaded", function(model)
		local f10_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueGreaterThan("LeaguePlayLadderMemberList.loaded", 0) then
			SetAlpha(self.RefreshingLabel, 0)
			CoD.ArenaLeaguePlayUtility.ForceLadderPlayerArrows(self.LeaderboardEntries, f1_arg1)
		elseif CoD.ModelUtility.IsGlobalModelValueEqualTo("LeaguePlayLadderMemberList.loaded", 0) then
			SetAlpha(self.RefreshingLabel, 100)
		end
	end)
	LeaderboardEntries.id = "LeaderboardEntries"
	self.__defaultFocus = LeaderboardEntries
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayLeaderboard.__resetProperties = function(f11_arg0)
	f11_arg0.LeaderboardEntries:completeAnimation()
	f11_arg0.RankTitle:completeAnimation()
	f11_arg0.RankPointsTitle:completeAnimation()
	f11_arg0.GemReward:completeAnimation()
	f11_arg0.ErrorText:completeAnimation()
	f11_arg0.topline1:completeAnimation()
	f11_arg0.topline2:completeAnimation()
	f11_arg0.topline3:completeAnimation()
	f11_arg0.topline4:completeAnimation()
	f11_arg0.topline5:completeAnimation()
	f11_arg0.LeaderboardEntries:setAlpha(1)
	f11_arg0.RankTitle:setAlpha(1)
	f11_arg0.RankPointsTitle:setAlpha(1)
	f11_arg0.GemReward:setAlpha(1)
	f11_arg0.ErrorText:setAlpha(0)
	f11_arg0.topline1:setAlpha(0.05)
	f11_arg0.topline2:setAlpha(0.05)
	f11_arg0.topline3:setAlpha(0.05)
	f11_arg0.topline4:setAlpha(0.05)
	f11_arg0.topline5:setAlpha(0.05)
end
CoD.LeaguePlayLeaderboard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	DailyBonusAvailable = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Error = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(10)
			f14_arg0.ErrorText:completeAnimation()
			f14_arg0.ErrorText:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ErrorText)
			f14_arg0.LeaderboardEntries:completeAnimation()
			f14_arg0.LeaderboardEntries:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.LeaderboardEntries)
			f14_arg0.RankPointsTitle:completeAnimation()
			f14_arg0.RankPointsTitle:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.RankPointsTitle)
			f14_arg0.GemReward:completeAnimation()
			f14_arg0.GemReward:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.GemReward)
			f14_arg0.RankTitle:completeAnimation()
			f14_arg0.RankTitle:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.RankTitle)
			f14_arg0.topline5:completeAnimation()
			f14_arg0.topline5:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.topline5)
			f14_arg0.topline4:completeAnimation()
			f14_arg0.topline4:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.topline4)
			f14_arg0.topline3:completeAnimation()
			f14_arg0.topline3:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.topline3)
			f14_arg0.topline2:completeAnimation()
			f14_arg0.topline2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.topline2)
			f14_arg0.topline1:completeAnimation()
			f14_arg0.topline1:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.topline1)
		end,
	},
}
CoD.LeaguePlayLeaderboard.__onClose = function(f15_arg0)
	f15_arg0.LeaderboardEntries:close()
	f15_arg0.ArenaLeaguePlayLadderSkillDivision:close()
end
