require("x64:b9a16de4d977bda")
CoD.Barracks_StatsOverview_WZ_Efficiency = InheritFrom(LUI.UIElement)
CoD.Barracks_StatsOverview_WZ_Efficiency.__defaultWidth = 310
CoD.Barracks_StatsOverview_WZ_Efficiency.__defaultHeight = 131
CoD.Barracks_StatsOverview_WZ_Efficiency.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 1, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.Barracks_StatsOverview_WZ_Efficiency)
	self.id = "Barracks_StatsOverview_WZ_Efficiency"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CleanUpsPerGame = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 0, 21)
	CleanUpsPerGame.StatHeaderText:setText(LocalizeToUpperString(@"hash_52B986F18574B0BC"))
	CleanUpsPerGame.StatValue.__Stat_Value = function()
		CleanUpsPerGame.StatValue:setText(CoD.PlayerStatsUtility.GetWZCleanUpsPerGame(f1_arg1, f1_arg0, 11235))
	end
	CleanUpsPerGame.StatValue.__Stat_Value()
	self:addElement(CleanUpsPerGame)
	self.CleanUpsPerGame = CleanUpsPerGame
	local MostDamage = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 22, 43)
	MostDamage.StatHeaderText:setText(LocalizeToUpperString(@"menu/most_damage"))
	MostDamage.StatValue.__Stat_Value = function()
		MostDamage.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModeHighestPlayerStorageStat(f1_arg1, f1_arg0, @"hash_15B27DF39A4715A3", 11235))
	end
	MostDamage.StatValue.__Stat_Value()
	self:addElement(MostDamage)
	self.MostDamage = MostDamage
	local DistanceTravelled = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 44, 65)
	DistanceTravelled.StatHeaderText:setText(LocalizeToUpperString(@"menu/distance_travelled"))
	DistanceTravelled.StatValue.__Stat_Value = function()
		DistanceTravelled.StatValue:setText(DistanceInMetricString(UnitsToMeters(CoD.PlayerStatsUtility.GetWZGameModeAggregatePlayerStorageStats(f1_arg1, f1_arg0, CoD.PlayerStatsUtility.WZDistanceTraveledStats, "112km 358m"))))
	end
	DistanceTravelled.StatValue.__Stat_Value()
	self:addElement(DistanceTravelled)
	self.DistanceTravelled = DistanceTravelled
	local RevivesPerGame = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 66, 87)
	RevivesPerGame.StatHeaderText:setText(LocalizeToUpperString(@"hash_2497EA85FDE897FA"))
	RevivesPerGame.StatValue.__Stat_Value = function()
		RevivesPerGame.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"revives", @"total_games_played", 11235))
	end
	RevivesPerGame.StatValue.__Stat_Value()
	self:addElement(RevivesPerGame)
	self.RevivesPerGame = RevivesPerGame
	local VehiclesDestroyed = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 88, 109)
	VehiclesDestroyed.StatHeaderText:setText(LocalizeToUpperString(@"menu/vehicles_destroyed"))
	VehiclesDestroyed.StatValue.__Stat_Value = function()
		VehiclesDestroyed.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"vehicles_destroyed", 11235))
	end
	VehiclesDestroyed.StatValue.__Stat_Value()
	self:addElement(VehiclesDestroyed)
	self.VehiclesDestroyed = VehiclesDestroyed
	local Deaths = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 111, 132)
	Deaths.StatHeaderText:setText(LocalizeToUpperString(@"mpui/deaths"))
	Deaths.StatValue.__Stat_Value = function()
		Deaths.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"deaths", 11235))
	end
	Deaths.StatValue.__Stat_Value()
	self:addElement(Deaths)
	self.Deaths = Deaths
	local f1_local7 = CleanUpsPerGame
	local f1_local8 = CleanUpsPerGame.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], CleanUpsPerGame.StatValue.__Stat_Value)
	f1_local7 = MostDamage
	f1_local8 = MostDamage.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], MostDamage.StatValue.__Stat_Value)
	f1_local7 = DistanceTravelled
	f1_local8 = DistanceTravelled.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], DistanceTravelled.StatValue.__Stat_Value)
	f1_local7 = RevivesPerGame
	f1_local8 = RevivesPerGame.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], RevivesPerGame.StatValue.__Stat_Value)
	f1_local7 = VehiclesDestroyed
	f1_local8 = VehiclesDestroyed.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], VehiclesDestroyed.StatValue.__Stat_Value)
	f1_local7 = Deaths
	f1_local8 = Deaths.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["PlayerBarracksStats.currentFilter"], Deaths.StatValue.__Stat_Value)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Barracks_StatsOverview_WZ_Efficiency.__resetProperties = function(f8_arg0)
	f8_arg0.RevivesPerGame:completeAnimation()
	f8_arg0.CleanUpsPerGame:completeAnimation()
	f8_arg0.RevivesPerGame:setAlpha(1)
	f8_arg0.CleanUpsPerGame:setAlpha(1)
end
CoD.Barracks_StatsOverview_WZ_Efficiency.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Solo = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.CleanUpsPerGame:completeAnimation()
			f10_arg0.CleanUpsPerGame:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CleanUpsPerGame)
			f10_arg0.RevivesPerGame:completeAnimation()
			f10_arg0.RevivesPerGame:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RevivesPerGame)
		end,
	},
}
CoD.Barracks_StatsOverview_WZ_Efficiency.__onClose = function(f11_arg0)
	f11_arg0.CleanUpsPerGame:close()
	f11_arg0.MostDamage:close()
	f11_arg0.DistanceTravelled:close()
	f11_arg0.RevivesPerGame:close()
	f11_arg0.VehiclesDestroyed:close()
	f11_arg0.Deaths:close()
end
