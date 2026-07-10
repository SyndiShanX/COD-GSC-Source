require("x64:46728994d8c06c0")
require("x64:b9a16de4d977bda")
require("x64:1919854135acff3")
require("x64:c6c708ebd4ae043")
CoD.Barracks_StatsOverview_ZM = InheritFrom(LUI.UIElement)
CoD.Barracks_StatsOverview_ZM.__defaultWidth = 477
CoD.Barracks_StatsOverview_ZM.__defaultHeight = 677
CoD.Barracks_StatsOverview_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "PrestigeMenuInfo.hasPrestiged", false)
	self:setClass(CoD.Barracks_StatsOverview_ZM)
	self.id = "Barracks_StatsOverview_ZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 1, 0, 0)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local bgHeadshot = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 178, 278)
	bgHeadshot:setRGB(0.23, 0.23, 0.23)
	bgHeadshot:setAlpha(0.25)
	self:addElement(bgHeadshot)
	self.bgHeadshot = bgHeadshot
	local bgKill = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 72, 172)
	bgKill:setRGB(0.23, 0.23, 0.23)
	bgKill:setAlpha(0.25)
	self:addElement(bgKill)
	self.bgKill = bgKill
	local bgGamesPlayed = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 286.5, 680.5)
	bgGamesPlayed:setRGB(0.23, 0.23, 0.23)
	bgGamesPlayed:setAlpha(0.25)
	self:addElement(bgGamesPlayed)
	self.bgGamesPlayed = bgGamesPlayed
	local Header = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10.5, 40.5)
	Header:setRGB(0.92, 0.92, 0.92)
	Header:setText(LocalizeToUpperString(@"menu/career_stats"))
	Header:setTTF("ttmussels_regular")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(Header)
	self.Header = Header
	local TimePlayedText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 44, 62)
	TimePlayedText:setRGB(0.92, 0.92, 0.92)
	TimePlayedText:setAlpha(0.5)
	TimePlayedText.__String_Reference = function()
		TimePlayedText:setText(SecondsAsTimePlayedString(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, @"time_played_total", 0x0)))
	end
	TimePlayedText.__String_Reference()
	TimePlayedText:setTTF("ttmussels_regular")
	TimePlayedText:setLetterSpacing(1)
	TimePlayedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(TimePlayedText)
	self.TimePlayedText = TimePlayedText
	local Kills = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 88, 155)
	Kills.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, CoD.PlayerStatsUtility.ZMGameModeTable, @"kills", 11235))
	Kills.StatHeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_16B234CB46B5ACD4"))
	self:addElement(Kills)
	self.Kills = Kills
	local KillsClassic = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 113, 134)
	KillsClassic.StatHeaderText:setText(LocalizeToUpperString(@"zmui/classic"))
	KillsClassic.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zclassic", @"kills", 11235))
	self:addElement(KillsClassic)
	self.KillsClassic = KillsClassic
	local KillsRush = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 135, 156)
	KillsRush.StatHeaderText:setText(LocalizeToUpperString(@"zmui/standard"))
	KillsRush.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zstandard", @"kills", 11235))
	self:addElement(KillsRush)
	self.KillsRush = KillsRush
	local Headshots = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 194, 261)
	Headshots.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, CoD.PlayerStatsUtility.ZMGameModeTable, @"headshots", 11235))
	Headshots.StatHeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_8E2A982E7E6C57A"))
	self:addElement(Headshots)
	self.Headshots = Headshots
	local HeadshotsClassic = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 219, 240)
	HeadshotsClassic.StatHeaderText:setText(LocalizeToUpperString(@"zmui/classic"))
	HeadshotsClassic.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zclassic", @"headshots", 11235))
	self:addElement(HeadshotsClassic)
	self.HeadshotsClassic = HeadshotsClassic
	local HeadshotsRush = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 240, 261)
	HeadshotsRush.StatHeaderText:setText(LocalizeToUpperString(@"zmui/standard"))
	HeadshotsRush.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zstandard", @"headshots", 11235))
	self:addElement(HeadshotsRush)
	self.HeadshotsRush = HeadshotsRush
	local GamesPlayedHeader = CoD.PlayerStatsHeader.new(f1_arg0, f1_arg1, 0, 0, 10, 467, 0, 0, 285, 306)
	GamesPlayedHeader.HeaderText:setText(LocalizeToUpperString(@"hash_160E7B72DEB51F25"))
	self:addElement(GamesPlayedHeader)
	self.GamesPlayedHeader = GamesPlayedHeader
	local GamesPlayedClassic = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 320, 387)
	GamesPlayedClassic.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zclassic", @"total_games_played", 11235))
	GamesPlayedClassic.StatHeaderText:setText(LocalizeToUpperString(@"zmui/classic"))
	self:addElement(GamesPlayedClassic)
	self.GamesPlayedClassic = GamesPlayedClassic
	local HighestRound1 = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 345, 366)
	HighestRound1:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestRound1Map", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HighestRound1.StatHeaderText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	HighestRound1:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestRound1", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			HighestRound1.StatValue:setText(f4_local0)
		end
	end)
	self:addElement(HighestRound1)
	self.HighestRound1 = HighestRound1
	local HighestRound2 = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 366, 387)
	HighestRound2:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestRound2Map", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			HighestRound2.StatHeaderText:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	HighestRound2:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestRound2", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HighestRound2.StatValue:setText(f6_local0)
		end
	end)
	self:addElement(HighestRound2)
	self.HighestRound2 = HighestRound2
	local HighestRound3 = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 387, 408)
	HighestRound3:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestRound3Map", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			HighestRound3.StatHeaderText:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	HighestRound3:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestRound3", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			HighestRound3.StatValue:setText(f8_local0)
		end
	end)
	self:addElement(HighestRound3)
	self.HighestRound3 = HighestRound3
	local RevivesClassic = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 423, 444)
	RevivesClassic.StatHeaderText:setText(LocalizeToUpperString(@"hash_1A704161437E2306"))
	RevivesClassic.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zclassic", @"revives", 11235))
	self:addElement(RevivesClassic)
	self.RevivesClassic = RevivesClassic
	local GamesPlayedRush = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 493, 560)
	GamesPlayedRush.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zstandard", @"total_games_played", 11235))
	GamesPlayedRush.StatHeaderText:setText(LocalizeToUpperString(@"zmui/standard"))
	self:addElement(GamesPlayedRush)
	self.GamesPlayedRush = GamesPlayedRush
	local HighScore1 = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 518, 539)
	HighScore1:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestScore1Map", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			HighScore1.StatHeaderText:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	HighScore1:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestScore1", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			HighScore1.StatValue:setText(f10_local0)
		end
	end)
	self:addElement(HighScore1)
	self.HighScore1 = HighScore1
	local HighScore2 = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 539, 560)
	HighScore2:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestScore2Map", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			HighScore2.StatHeaderText:setText(LocalizeToUpperString(f11_local0))
		end
	end)
	HighScore2:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestScore2", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			HighScore2.StatValue:setText(f12_local0)
		end
	end)
	self:addElement(HighScore2)
	self.HighScore2 = HighScore2
	local HighScore3 = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 560, 581)
	HighScore3:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestScore3Map", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			HighScore3.StatHeaderText:setText(LocalizeToUpperString(f13_local0))
		end
	end)
	HighScore3:subscribeToGlobalModel(f1_arg1, "PlayerBarracksStats", "zmHighestScore3", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			HighScore3.StatValue:setText(f14_local0)
		end
	end)
	self:addElement(HighScore3)
	self.HighScore3 = HighScore3
	local FirstPlaceFinishs = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 155, 457, 0, 0, 598, 619)
	FirstPlaceFinishs.StatHeaderText:setText(LocalizeToUpperString(@"hash_2473CF0BE429035F"))
	FirstPlaceFinishs.StatValue:setText(CoD.PlayerStatsUtility.GetGameModePlayerStorageStat(f1_arg1, f1_arg0, @"zstandard", @"rush_first_place_finishes", 11235))
	self:addElement(FirstPlaceFinishs)
	self.FirstPlaceFinishs = FirstPlaceFinishs
	local dotline01 = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 173, 177)
	dotline01:setAlpha(0.2)
	dotline01:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline01:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline01)
	self.dotline01 = dotline01
	local dotline02 = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 279, 283)
	dotline02:setAlpha(0.2)
	dotline02:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline02:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline02)
	self.dotline02 = dotline02
	local HighScoreMap = LUI.UIText.new(0, 0, 222, 467, 0, 0, 493, 511)
	HighScoreMap:setRGB(0.92, 0.92, 0.92)
	HighScoreMap:setText(LocalizeToUpperString(@"hash_376A194FF413BE2"))
	HighScoreMap:setTTF("ttmussels_regular")
	HighScoreMap:setLetterSpacing(1)
	HighScoreMap:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HighScoreMap:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(HighScoreMap)
	self.HighScoreMap = HighScoreMap
	local HighRoundMap = LUI.UIText.new(0, 0, 222, 467, 0, 0, 320.5, 338.5)
	HighRoundMap:setRGB(0.92, 0.92, 0.92)
	HighRoundMap:setText(LocalizeToUpperString(@"hash_A9E202FF295512C"))
	HighRoundMap:setTTF("ttmussels_regular")
	HighRoundMap:setLetterSpacing(1)
	HighRoundMap:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HighRoundMap:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(HighRoundMap)
	self.HighRoundMap = HighRoundMap
	local f1_local28 = TimePlayedText
	local f1_local29 = TimePlayedText.subscribeToModel
	local f1_local30 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local29(f1_local28, f1_local30["PrestigeMenuInfo.hasPrestiged"], TimePlayedText.__String_Reference)
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
	f1_local29 = self
	CoD.PlayerStatsUtility.UpdateZMHighestStats(f1_arg0, f1_arg1)
	return self
end
CoD.Barracks_StatsOverview_ZM.__resetProperties = function(f16_arg0)
	f16_arg0.TimePlayedText:completeAnimation()
	f16_arg0.HighRoundMap:completeAnimation()
	f16_arg0.HighScoreMap:completeAnimation()
	f16_arg0.TimePlayedText:setTopBottom(0, 0, 44, 62)
	f16_arg0.HighRoundMap:setTopBottom(0, 0, 320.5, 338.5)
	f16_arg0.HighScoreMap:setTopBottom(0, 0, 493, 511)
end
CoD.Barracks_StatsOverview_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.TimePlayedText:completeAnimation()
			f18_arg0.TimePlayedText:setTopBottom(0, 0, 50, 63)
			f18_arg0.clipFinished(f18_arg0.TimePlayedText)
			f18_arg0.HighScoreMap:completeAnimation()
			f18_arg0.HighScoreMap:setTopBottom(0, 0, 493, 506)
			f18_arg0.clipFinished(f18_arg0.HighScoreMap)
			f18_arg0.HighRoundMap:completeAnimation()
			f18_arg0.HighRoundMap:setTopBottom(0, 0, 320.5, 333.5)
			f18_arg0.clipFinished(f18_arg0.HighRoundMap)
		end,
	},
}
CoD.Barracks_StatsOverview_ZM.__onClose = function(f19_arg0)
	f19_arg0.CommonDetailPanel2:close()
	f19_arg0.TimePlayedText:close()
	f19_arg0.Kills:close()
	f19_arg0.KillsClassic:close()
	f19_arg0.KillsRush:close()
	f19_arg0.Headshots:close()
	f19_arg0.HeadshotsClassic:close()
	f19_arg0.HeadshotsRush:close()
	f19_arg0.GamesPlayedHeader:close()
	f19_arg0.GamesPlayedClassic:close()
	f19_arg0.HighestRound1:close()
	f19_arg0.HighestRound2:close()
	f19_arg0.HighestRound3:close()
	f19_arg0.RevivesClassic:close()
	f19_arg0.GamesPlayedRush:close()
	f19_arg0.HighScore1:close()
	f19_arg0.HighScore2:close()
	f19_arg0.HighScore3:close()
	f19_arg0.FirstPlaceFinishs:close()
end
