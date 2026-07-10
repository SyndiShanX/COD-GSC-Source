require("x64:b9a16de4d977bda")
CoD.Barracks_StatsOverview_WZ_Wins = InheritFrom(LUI.UIElement)
CoD.Barracks_StatsOverview_WZ_Wins.__defaultWidth = 310
CoD.Barracks_StatsOverview_WZ_Wins.__defaultHeight = 64
CoD.Barracks_StatsOverview_WZ_Wins.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 1, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.Barracks_StatsOverview_WZ_Wins)
	self.id = "Barracks_StatsOverview_WZ_Wins"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WinLossRatio = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 0, 21)
	WinLossRatio.StatHeaderText:setText(LocalizeToUpperString(@"menu/win_pct"))
	WinLossRatio.StatValue.__Stat_Value = function()
		WinLossRatio.StatValue:setText(FractionToPercentageRounded(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"wins", @"total_games_played", "88%")))
	end
	WinLossRatio.StatValue.__Stat_Value()
	self:addElement(WinLossRatio)
	self.WinLossRatio = WinLossRatio
	local GamesPlayed = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 22, 43)
	GamesPlayed.StatHeaderText:setText(LocalizeToUpperString(@"menu/games"))
	GamesPlayed.StatValue.__Stat_Value = function()
		GamesPlayed.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"total_games_played", 11235))
	end
	GamesPlayed.StatValue.__Stat_Value()
	self:addElement(GamesPlayed)
	self.GamesPlayed = GamesPlayed
	local TopFive = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 44, 65)
	TopFive.StatHeaderText:setText(LocalizeToUpperString(@"menu/top_5"))
	TopFive.StatValue.__Stat_Value = function()
		TopFive.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"hash_5E9A745460A10F80", 11235))
	end
	TopFive.StatValue.__Stat_Value()
	self:addElement(TopFive)
	self.TopFive = TopFive
	local TopTen = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 66, 87)
	TopTen.StatHeaderText:setText(LocalizeToUpperString(@"menu/top_10"))
	TopTen.StatValue.__Stat_Value = function()
		TopTen.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"hash_7B8D2C77874A1C24", 11235))
	end
	TopTen.StatValue.__Stat_Value()
	self:addElement(TopTen)
	self.TopTen = TopTen
	local Top15 = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 88, 109)
	Top15.StatHeaderText:setText(LocalizeToUpperString(@"menu/top_15"))
	Top15.StatValue.__Stat_Value = function()
		Top15.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"hash_6429D1FCCDEF2C9", 11235))
	end
	Top15.StatValue.__Stat_Value()
	self:addElement(Top15)
	self.Top15 = Top15
	local TopPlacements = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 110, 131)
	TopPlacements.StatHeaderText:setText(LocalizeToUpperString(@"hash_6971770DEFE5452D"))
	TopPlacements.StatValue.__Stat_Value = function()
		TopPlacements.StatValue:setText(CoD.PlayerStatsUtility.GetWZTopPlacements(f1_arg1, f1_arg0, 11235))
	end
	TopPlacements.StatValue.__Stat_Value()
	self:addElement(TopPlacements)
	self.TopPlacements = TopPlacements
	local f1_local7 = WinLossRatio
	local f1_local8 = WinLossRatio.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], WinLossRatio.StatValue.__Stat_Value)
	f1_local7 = GamesPlayed
	f1_local8 = GamesPlayed.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], GamesPlayed.StatValue.__Stat_Value)
	f1_local7 = TopFive
	f1_local8 = TopFive.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], TopFive.StatValue.__Stat_Value)
	f1_local7 = TopTen
	f1_local8 = TopTen.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], TopTen.StatValue.__Stat_Value)
	f1_local7 = Top15
	f1_local8 = Top15.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], Top15.StatValue.__Stat_Value)
	f1_local7 = TopPlacements
	f1_local8 = TopPlacements.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], TopPlacements.StatValue.__Stat_Value)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Barracks_StatsOverview_WZ_Wins.__resetProperties = function(f8_arg0)
	f8_arg0.TopTen:completeAnimation()
	f8_arg0.Top15:completeAnimation()
	f8_arg0.TopPlacements:completeAnimation()
	f8_arg0.TopFive:completeAnimation()
	f8_arg0.TopTen:setAlpha(1)
	f8_arg0.Top15:setAlpha(1)
	f8_arg0.TopPlacements:setAlpha(1)
	f8_arg0.TopFive:setAlpha(1)
end
CoD.Barracks_StatsOverview_WZ_Wins.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.TopFive:completeAnimation()
			f9_arg0.TopFive:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TopFive)
			f9_arg0.TopTen:completeAnimation()
			f9_arg0.TopTen:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TopTen)
			f9_arg0.Top15:completeAnimation()
			f9_arg0.Top15:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Top15)
			f9_arg0.TopPlacements:completeAnimation()
			f9_arg0.TopPlacements:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.TopPlacements)
		end,
	},
	Solos = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.TopFive:completeAnimation()
			f10_arg0.TopFive:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TopFive)
			f10_arg0.TopTen:completeAnimation()
			f10_arg0.TopTen:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TopTen)
			f10_arg0.TopPlacements:completeAnimation()
			f10_arg0.TopPlacements:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TopPlacements)
		end,
	},
	Duos = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.TopFive:completeAnimation()
			f11_arg0.TopFive:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TopFive)
			f11_arg0.Top15:completeAnimation()
			f11_arg0.Top15:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Top15)
			f11_arg0.TopPlacements:completeAnimation()
			f11_arg0.TopPlacements:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TopPlacements)
		end,
	},
	Quads = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.TopTen:completeAnimation()
			f12_arg0.TopTen:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TopTen)
			f12_arg0.Top15:completeAnimation()
			f12_arg0.Top15:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Top15)
			f12_arg0.TopPlacements:completeAnimation()
			f12_arg0.TopPlacements:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TopPlacements)
		end,
	},
	LTM = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.TopFive:completeAnimation()
			f13_arg0.TopFive:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.TopFive)
			f13_arg0.TopTen:completeAnimation()
			f13_arg0.TopTen:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.TopTen)
			f13_arg0.Top15:completeAnimation()
			f13_arg0.Top15:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Top15)
			f13_arg0.TopPlacements:completeAnimation()
			f13_arg0.TopPlacements:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.TopPlacements)
		end,
	},
}
CoD.Barracks_StatsOverview_WZ_Wins.__onClose = function(f14_arg0)
	f14_arg0.WinLossRatio:close()
	f14_arg0.GamesPlayed:close()
	f14_arg0.TopFive:close()
	f14_arg0.TopTen:close()
	f14_arg0.Top15:close()
	f14_arg0.TopPlacements:close()
end
