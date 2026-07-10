require("x64:46728994d8c06c0")
require("x64:8e65dffcd6f8796")
require("x64:98541652d16a0fc")
require("x64:b9a16de4d977bda")
require("x64:1919854135acff3")
require("x64:c6c708ebd4ae043")
require("x64:ab14b7762fde7e3")
CoD.Barracks_StatsOverview_WZ = InheritFrom(LUI.UIElement)
CoD.Barracks_StatsOverview_WZ.__defaultWidth = 477
CoD.Barracks_StatsOverview_WZ.__defaultHeight = 677
CoD.Barracks_StatsOverview_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Barracks_StatsOverview_WZ)
	self.id = "Barracks_StatsOverview_WZ"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 0, 0, 677)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local BgOther = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 542, 667)
	BgOther:setRGB(0.23, 0.23, 0.23)
	BgOther:setAlpha(0)
	self:addElement(BgOther)
	self.BgOther = BgOther
	local bgAvgDamage = LUI.UIImage.new(0, 0, 11, 468, 0, 0, 454.5, 666.5)
	bgAvgDamage:setRGB(0.23, 0.23, 0.23)
	bgAvgDamage:setAlpha(0.25)
	self:addElement(bgAvgDamage)
	self.bgAvgDamage = bgAvgDamage
	local bgKill = LUI.UIImage.new(0, 0, 11, 468, 0, 0, 232.5, 444.5)
	bgKill:setRGB(0.23, 0.23, 0.23)
	bgKill:setAlpha(0.25)
	self:addElement(bgKill)
	self.bgKill = bgKill
	local bgWin = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 103, 222)
	bgWin:setRGB(0.23, 0.23, 0.23)
	bgWin:setAlpha(0.25)
	self:addElement(bgWin)
	self.bgWin = bgWin
	local Header = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 40)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(LocalizeToUpperString(@"menu/career_stats"))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(Header)
	self.Header = Header
	local TimePlayedText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 44, 62)
	TimePlayedText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TimePlayedText:setAlpha(0.5)
	TimePlayedText.__String_Reference = function()
		TimePlayedText:setText(SecondsAsTimePlayedString(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"time_played_total", 0x0)))
	end
	TimePlayedText.__String_Reference()
	TimePlayedText:setTTF("ttmussels_regular")
	TimePlayedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(TimePlayedText)
	self.TimePlayedText = TimePlayedText
	local Wins = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 19.5, 219.5, 0, 0, 115, 182)
	Wins.StatValue.__Stat_Value = function()
		Wins.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"wins", 11235))
	end
	Wins.StatValue.__Stat_Value()
	Wins.StatHeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4585891326C1258C"))
	self:addElement(Wins)
	self.Wins = Wins
	local Kills = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 19.5, 219.5, 0, 0, 240, 307)
	Kills.StatValue.__Stat_Value = function()
		Kills.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat(f1_arg1, f1_arg0, @"kills", 11235))
	end
	Kills.StatValue.__Stat_Value()
	Kills.StatHeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_16B234CB46B5ACD4"))
	self:addElement(Kills)
	self.Kills = Kills
	local KillsPerGame = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 467, 0, 0, 265, 286)
	KillsPerGame.StatHeaderText:setText(LocalizeToUpperString(@"menu/kills_game"))
	KillsPerGame.StatValue.__Stat_Value = function()
		KillsPerGame.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"kills", @"total_games_played", 11235))
	end
	KillsPerGame.StatValue.__Stat_Value()
	self:addElement(KillsPerGame)
	self.KillsPerGame = KillsPerGame
	local KillDeathRatio = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 467, 0, 0, 287, 308)
	KillDeathRatio.StatHeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/kd_short"))
	KillDeathRatio.StatValue.__Stat_Value = function()
		KillDeathRatio.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"kills", @"deaths", 11235))
	end
	KillDeathRatio.StatValue.__Stat_Value()
	self:addElement(KillDeathRatio)
	self.KillDeathRatio = KillDeathRatio
	local HeadshotPct = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 467, 0, 0, 308, 329)
	HeadshotPct.StatHeaderText:setText(LocalizeToUpperString(@"menu/headshot_pct"))
	HeadshotPct.StatValue.__Stat_Value = function()
		HeadshotPct.StatValue:setText(FractionToPercentageRounded(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"hits_headshot", @"hits", "88%")))
	end
	HeadshotPct.StatValue.__Stat_Value()
	self:addElement(HeadshotPct)
	self.HeadshotPct = HeadshotPct
	local KillsAfterRevivePct = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 467, 0, 0, 329, 350)
	KillsAfterRevivePct.StatHeaderText:setText(LocalizeToUpperString(@"hash_58A1E63E734BC103"))
	KillsAfterRevivePct.StatValue.__Stat_Value = function()
		KillsAfterRevivePct.StatValue:setText(FractionToPercentageRounded(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"kills_after_revive", @"kills", "88%")))
	end
	KillsAfterRevivePct.StatValue.__Stat_Value()
	self:addElement(KillsAfterRevivePct)
	self.KillsAfterRevivePct = KillsAfterRevivePct
	local HotDropKillPct = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 467, 0, 0, 351, 372)
	HotDropKillPct.StatHeaderText:setText(LocalizeToUpperString(@"hash_7C4C85FE1273E187"))
	HotDropKillPct.StatValue.__Stat_Value = function()
		HotDropKillPct.StatValue:setText(FractionToPercentageRounded(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"kills_early", @"kills", "88%")))
	end
	HotDropKillPct.StatValue.__Stat_Value()
	self:addElement(HotDropKillPct)
	self.HotDropKillPct = HotDropKillPct
	local MostKills = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 467, 0, 0, 373, 394)
	MostKills.StatHeaderText:setText(LocalizeToUpperString(@"menu/most_kills"))
	MostKills.StatValue.__Stat_Value = function()
		MostKills.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModeHighestPlayerStorageStat(f1_arg1, f1_arg0, @"hash_6E4E1EB9512BA7B5", 11235))
	end
	MostKills.StatValue.__Stat_Value()
	self:addElement(MostKills)
	self.MostKills = MostKills
	local LongestDistanceKill = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 467, 0, 0, 395, 416)
	LongestDistanceKill.StatHeaderText:setText(LocalizeToUpperString(@"hash_2E3E72FE9F094F80"))
	LongestDistanceKill.StatValue.__Stat_Value = function()
		LongestDistanceKill.StatValue:setText(DistanceInMetricString(UnitsToMeters(CoD.PlayerStatsUtility.GetWZGameModeHighestPlayerStorageStat(f1_arg1, f1_arg0, @"longest_distance_kill", "112km 358m"))))
	end
	LongestDistanceKill.StatValue.__Stat_Value()
	self:addElement(LongestDistanceKill)
	self.LongestDistanceKill = LongestDistanceKill
	local EfficiencyHeader = CoD.PlayerStatsHeader.new(f1_arg0, f1_arg1, 0, 0, 11, 467, 0, 0, 455, 476)
	EfficiencyHeader.HeaderText:setText(LocalizeToUpperString(@"menu/efficiency"))
	self:addElement(EfficiencyHeader)
	self.EfficiencyHeader = EfficiencyHeader
	local AverageDamage = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 19.5, 219.5, 0, 0, 485, 552)
	AverageDamage.StatValue.__Stat_Value = function()
		AverageDamage.StatValue:setText(CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio(f1_arg1, f1_arg0, @"total_damage", @"total_games_played", 11235))
	end
	AverageDamage.StatValue.__Stat_Value()
	AverageDamage.StatHeaderText:setText(LocalizeToUpperString(@"menu/avg_damage"))
	self:addElement(AverageDamage)
	self.AverageDamage = AverageDamage
	local CleanUpsPerGame = CoD.Barracks_StatsOverview_WZ_Efficiency.new(f1_arg0, f1_arg1, 0, 0, 155, 465, 0, 0, 507, 638)
	CleanUpsPerGame:mergeStateConditions({
		{
			stateName = "Solo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PlayerBarracksStats", "currentFilter", CoD.PlayerStatsUtility.WZGameModeDisplayType.SOLO)
			end,
		},
	})
	local dotline01 = CleanUpsPerGame
	local OtherHeader = CleanUpsPerGame.subscribeToModel
	local dotline02 = DataSources.PlayerBarracksStats.getModel(f1_arg1)
	OtherHeader(dotline01, dotline02.currentFilter, function(f14_arg0)
		f1_arg0:updateElementState(CleanUpsPerGame, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "currentFilter",
		})
	end, false)
	self:addElement(CleanUpsPerGame)
	self.CleanUpsPerGame = CleanUpsPerGame
	OtherHeader = CoD.PlayerStatsHeader.new(f1_arg0, f1_arg1, 0, 0, 15.5, 469.5, 0, 0, 560, 581)
	OtherHeader:setAlpha(0)
	OtherHeader.HeaderText:setText(LocalizeToUpperString(@"menu/other"))
	self:addElement(OtherHeader)
	self.OtherHeader = OtherHeader
	dotline01 = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 224.5, 228.5)
	dotline01:setAlpha(0.2)
	dotline01:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline01:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline01)
	self.dotline01 = dotline01
	dotline02 = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 446.5, 450.5)
	dotline02:setAlpha(0.2)
	dotline02:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline02:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline02)
	self.dotline02 = dotline02
	local FuiBoxRight = LUI.UIImage.new(0, 0, 435.5, 469.5, 0, 0, 42.5, 8.5)
	FuiBoxRight:setAlpha(0.1)
	FuiBoxRight:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBoxRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBoxRight:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBoxRight)
	self.FuiBoxRight = FuiBoxRight
	local FuiBoxLeft = LUI.UIImage.new(0, 0, 10, 44, 0, 0, 42.5, 8.5)
	FuiBoxLeft:setAlpha(0.1)
	FuiBoxLeft:setZRot(90)
	FuiBoxLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBoxLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBoxLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBoxLeft)
	self.FuiBoxLeft = FuiBoxLeft
	local WZGameModeFilter = LUI.UIText.new(0, 0, 20, 220, 0, 0, 76, 94)
	WZGameModeFilter:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	WZGameModeFilter:setTTF("ttmussels_regular")
	WZGameModeFilter:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WZGameModeFilter:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "currentFilter", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			WZGameModeFilter:setText(LocalizeToUpperString(CoD.PlayerStatsUtility.GetWZGameModeFilterNameForType(f15_local0)))
		end
	end)
	self:addElement(WZGameModeFilter)
	self.WZGameModeFilter = WZGameModeFilter
	local WZGameModeFilterButton = LUI.UIText.new(1, 1, -216.5, -16.5, 0, 0, 76, 94)
	WZGameModeFilterButton:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	WZGameModeFilterButton:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4DB718E1421D5D37"))
	WZGameModeFilterButton:setTTF("ttmussels_regular")
	WZGameModeFilterButton:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(WZGameModeFilterButton)
	self.WZGameModeFilterButton = WZGameModeFilterButton
	local WZGameModeFilterButtonPC = nil
	WZGameModeFilterButtonPC = CoD.Barracks_StatsOverview_WZ_FilterPCString.new(f1_arg0, f1_arg1, 0, 0, 260.5, 460.5, 0, 0, 76, 94)
	self:addElement(WZGameModeFilterButtonPC)
	self.WZGameModeFilterButtonPC = WZGameModeFilterButtonPC
	local WinLossRatio = CoD.Barracks_StatsOverview_WZ_Wins.new(f1_arg0, f1_arg1, 0, 0, 155, 465, 0, 0, 139, 203)
	WinLossRatio:mergeStateConditions({
		{
			stateName = "Solos",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PlayerBarracksStats", "currentFilter", CoD.PlayerStatsUtility.WZGameModeDisplayType.SOLO)
			end,
		},
		{
			stateName = "Duos",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PlayerBarracksStats", "currentFilter", CoD.PlayerStatsUtility.WZGameModeDisplayType.DUOS)
			end,
		},
		{
			stateName = "Quads",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PlayerBarracksStats", "currentFilter", CoD.PlayerStatsUtility.WZGameModeDisplayType.QUADS)
			end,
		},
		{
			stateName = "LTM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PlayerBarracksStats", "currentFilter", CoD.PlayerStatsUtility.WZGameModeDisplayType.LTM)
			end,
		},
	})
	local f1_local29 = WinLossRatio
	local f1_local30 = WinLossRatio.subscribeToModel
	local f1_local31 = DataSources.PlayerBarracksStats.getModel(f1_arg1)
	f1_local30(f1_local29, f1_local31.currentFilter, function(f20_arg0)
		f1_arg0:updateElementState(WinLossRatio, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "currentFilter",
		})
	end, false)
	self:addElement(WinLossRatio)
	self.WinLossRatio = WinLossRatio
	f1_local29 = TimePlayedText
	f1_local30 = TimePlayedText.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], TimePlayedText.__String_Reference)
	f1_local29 = Wins
	f1_local30 = Wins.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], Wins.StatValue.__Stat_Value)
	f1_local29 = Kills
	f1_local30 = Kills.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], Kills.StatValue.__Stat_Value)
	f1_local29 = KillsPerGame
	f1_local30 = KillsPerGame.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], KillsPerGame.StatValue.__Stat_Value)
	f1_local29 = KillDeathRatio
	f1_local30 = KillDeathRatio.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], KillDeathRatio.StatValue.__Stat_Value)
	f1_local29 = HeadshotPct
	f1_local30 = HeadshotPct.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], HeadshotPct.StatValue.__Stat_Value)
	f1_local29 = KillsAfterRevivePct
	f1_local30 = KillsAfterRevivePct.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], KillsAfterRevivePct.StatValue.__Stat_Value)
	f1_local29 = HotDropKillPct
	f1_local30 = HotDropKillPct.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], HotDropKillPct.StatValue.__Stat_Value)
	f1_local29 = MostKills
	f1_local30 = MostKills.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], MostKills.StatValue.__Stat_Value)
	f1_local29 = LongestDistanceKill
	f1_local30 = LongestDistanceKill.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], LongestDistanceKill.StatValue.__Stat_Value)
	f1_local29 = AverageDamage
	f1_local30 = AverageDamage.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["PlayerBarracksStats.currentFilter"], AverageDamage.StatValue.__Stat_Value)
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f23_arg1)
	end)
	f1_local29 = self
	f1_local30 = self.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31.LastInput, function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Barracks_StatsOverview_WZ.__resetProperties = function(f25_arg0)
	f25_arg0.WZGameModeFilterButtonPC:completeAnimation()
	f25_arg0.WZGameModeFilterButton:completeAnimation()
	f25_arg0.TimePlayedText:completeAnimation()
	f25_arg0.WZGameModeFilterButtonPC:setAlpha(1)
	f25_arg0.WZGameModeFilterButton:setAlpha(1)
	f25_arg0.TimePlayedText:setTopBottom(0, 0, 44, 62)
end
CoD.Barracks_StatsOverview_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.WZGameModeFilterButtonPC:completeAnimation()
			f26_arg0.WZGameModeFilterButtonPC:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.WZGameModeFilterButtonPC)
		end,
	},
	KBM = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.WZGameModeFilterButton:completeAnimation()
			f27_arg0.WZGameModeFilterButton:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.WZGameModeFilterButton)
			f27_arg0.WZGameModeFilterButtonPC:completeAnimation()
			f27_arg0.WZGameModeFilterButtonPC:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.WZGameModeFilterButtonPC)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.TimePlayedText:completeAnimation()
			f28_arg0.TimePlayedText:setTopBottom(0, 0, 50, 63)
			f28_arg0.clipFinished(f28_arg0.TimePlayedText)
		end,
	},
}
CoD.Barracks_StatsOverview_WZ.__onClose = function(f29_arg0)
	f29_arg0.CommonDetailPanel2:close()
	f29_arg0.TimePlayedText:close()
	f29_arg0.Wins:close()
	f29_arg0.Kills:close()
	f29_arg0.KillsPerGame:close()
	f29_arg0.KillDeathRatio:close()
	f29_arg0.HeadshotPct:close()
	f29_arg0.KillsAfterRevivePct:close()
	f29_arg0.HotDropKillPct:close()
	f29_arg0.MostKills:close()
	f29_arg0.LongestDistanceKill:close()
	f29_arg0.EfficiencyHeader:close()
	f29_arg0.AverageDamage:close()
	f29_arg0.CleanUpsPerGame:close()
	f29_arg0.OtherHeader:close()
	f29_arg0.WZGameModeFilter:close()
	f29_arg0.WZGameModeFilterButtonPC:close()
	f29_arg0.WinLossRatio:close()
end
