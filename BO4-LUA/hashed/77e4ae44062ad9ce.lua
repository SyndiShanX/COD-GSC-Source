require("x64:46728994d8c06c0")
require("x64:b9a16de4d977bda")
require("x64:c6c708ebd4ae043")
CoD.Barracks_StatsOverview = InheritFrom(LUI.UIElement)
CoD.Barracks_StatsOverview.__defaultWidth = 477
CoD.Barracks_StatsOverview.__defaultHeight = 677
CoD.Barracks_StatsOverview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "PrestigeMenuInfo.hasPrestiged", false)
	self:setClass(CoD.Barracks_StatsOverview)
	self.id = "Barracks_StatsOverview"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 0, 0, 677)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local bgDamage = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 570, 667)
	bgDamage:setRGB(0.23, 0.23, 0.23)
	bgDamage:setAlpha(0.25)
	self:addElement(bgDamage)
	self.bgDamage = bgDamage
	local bgHeal = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 467, 564)
	bgHeal:setRGB(0.23, 0.23, 0.23)
	bgHeal:setAlpha(0.25)
	self:addElement(bgHeal)
	self.bgHeal = bgHeal
	local bgScore = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 361, 461)
	bgScore:setRGB(0.23, 0.23, 0.23)
	bgScore:setAlpha(0.25)
	self:addElement(bgScore)
	self.bgScore = bgScore
	local bgEkia = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 178, 355)
	bgEkia:setRGB(0.23, 0.23, 0.23)
	bgEkia:setAlpha(0.25)
	self:addElement(bgEkia)
	self.bgEkia = bgEkia
	local bgWin = LUI.UIImage.new(0.5, 0.5, -228.5, 228.5, 0, 0, 72, 172)
	bgWin:setRGB(0.23, 0.23, 0.23)
	bgWin:setAlpha(0.25)
	self:addElement(bgWin)
	self.bgWin = bgWin
	local Header = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10, 40)
	Header:setRGB(0.92, 0.92, 0.92)
	Header:setText(LocalizeToUpperString(0xCE8C743423F4D99))
	Header:setTTF("ttmussels_regular")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(Header)
	self.Header = Header
	local TimePlayedText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 44, 62)
	TimePlayedText:setRGB(0.92, 0.92, 0.92)
	TimePlayedText:setAlpha(0.5)
	TimePlayedText.__String_Reference = function()
		TimePlayedText:setText(SecondsAsTimePlayedString(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, 0x3BF15114F02AF7B, 0x0)))
	end
	TimePlayedText.__String_Reference()
	TimePlayedText:setTTF("ttmussels_regular")
	TimePlayedText:setLetterSpacing(1)
	TimePlayedText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TimePlayedText)
	self.TimePlayedText = TimePlayedText
	local Wins = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 84, 151)
	Wins.StatValue.__Stat_Value = function()
		Wins.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, 0x61FFBF65560C4BE, 11235))
	end
	Wins.StatValue.__Stat_Value()
	Wins.StatHeaderText:setText(Engine[0xF9F1239CFD921FE](0x585891326C1258C))
	self:addElement(Wins)
	self.Wins = Wins
	local Losses = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 109, 130)
	Losses.StatHeaderText:setText(LocalizeToUpperString(0x3597821C1906BB1))
	Losses.StatValue.__Stat_Value = function()
		Losses.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, 0x60496832E1A37A, 11235))
	end
	Losses.StatValue.__Stat_Value()
	self:addElement(Losses)
	self.Losses = Losses
	local WinLossRatio = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 131, 152)
	WinLossRatio.StatHeaderText:setText(Engine[0xF9F1239CFD921FE](0x9F34F3A8BD173F7))
	WinLossRatio.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatRatio(f1_arg0, 0x61FFBF65560C4BE, 0x60496832E1A37A, 8.13))
	self:addElement(WinLossRatio)
	self.WinLossRatio = WinLossRatio
	local EKIA = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 190, 257)
	EKIA.StatValue.__Stat_Value = function()
		EKIA.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, 0x80C2F604F99D74B, 11235))
	end
	EKIA.StatValue.__Stat_Value()
	EKIA.StatHeaderText:setText(LocalizeToUpperString(0xF7FF9B8A85C450A))
	self:addElement(EKIA)
	self.EKIA = EKIA
	local Deaths = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 215, 236)
	Deaths.StatHeaderText:setText(LocalizeToUpperString(0x13CE1B89172BB60))
	Deaths.StatValue.__Stat_Value = function()
		Deaths.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, 0x6ED920648D707FA, 11235))
	end
	Deaths.StatValue.__Stat_Value()
	self:addElement(Deaths)
	self.Deaths = Deaths
	local EKIADeathRatio = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 236, 257)
	EKIADeathRatio.StatHeaderText:setText(LocalizeToUpperString(0x9BA25BF6C566FAC))
	EKIADeathRatio.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatRatio(f1_arg0, 0x80C2F604F99D74B, 0x6ED920648D707FA, 8.13))
	self:addElement(EKIADeathRatio)
	self.EKIADeathRatio = EKIADeathRatio
	local EKIAGameRatio = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 257, 278)
	EKIAGameRatio.StatHeaderText:setText(LocalizeToUpperString(0x605089E34BE8886))
	EKIAGameRatio.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatRatio(f1_arg0, 0x80C2F604F99D74B, 0x25E6910D90BDEA9, 8.13))
	self:addElement(EKIAGameRatio)
	self.EKIAGameRatio = EKIAGameRatio
	local DirectActionKills = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 280, 301)
	DirectActionKills.StatHeaderText:setText(LocalizeToUpperString(0xE14EE036C8198F))
	DirectActionKills.StatValue.__Stat_Value = function()
		DirectActionKills.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, 0x333F2FA3DF0EA1D, 11235))
	end
	DirectActionKills.StatValue.__Stat_Value()
	self:addElement(DirectActionKills)
	self.DirectActionKills = DirectActionKills
	local HeadshotPct = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 301, 322)
	HeadshotPct.StatHeaderText:setText(LocalizeToUpperString(0xF1382FBC8E58E3D))
	HeadshotPct.StatValue:setText(FractionToPercentageRounded(CoD.PlayerStatsUtility.GetPlayerStorageStatRatio(f1_arg0, 0x70B357B9F671585, 0xD238EA28DDDB583, "88%")))
	self:addElement(HeadshotPct)
	self.HeadshotPct = HeadshotPct
	local HighestKillStreak = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 322, 343)
	HighestKillStreak.StatHeaderText:setText(LocalizeToUpperString(0x1DCC7AB8B8F861))
	HighestKillStreak.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatNoCombined(f1_arg0, 0xEF976B050E0AA48, 11235))
	self:addElement(HighestKillStreak)
	self.HighestKillStreak = HighestKillStreak
	local Score = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 373.5, 440.5)
	Score.StatValue.__Stat_Value = function()
		Score.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, 0x10E63FBE7F624F5, 11235))
	end
	Score.StatValue.__Stat_Value()
	Score.StatHeaderText:setText(Engine[0xF9F1239CFD921FE](0x7B9FE59853C1B82))
	self:addElement(Score)
	self.Score = Score
	local ScorePerMinute = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 397.5, 418.5)
	ScorePerMinute.StatHeaderText:setText(LocalizeToUpperString(0x5402AF9B15DF76C))
	ScorePerMinute.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatPerMinute(f1_arg0, 0x10E63FBE7F624F5, 0x3BF15114F02AF7B, 5589))
	self:addElement(ScorePerMinute)
	self.ScorePerMinute = ScorePerMinute
	local ScorePerGame = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 419.5, 440.5)
	ScorePerGame.StatHeaderText:setText(LocalizeToUpperString(0x48059D61004B186))
	ScorePerGame.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatRatio(f1_arg0, 0x10E63FBE7F624F5, 0x25E6910D90BDEA9, 8.13))
	self:addElement(ScorePerGame)
	self.ScorePerGame = ScorePerGame
	local HealingPerGame = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 479, 546)
	HealingPerGame.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatRatioRounded(f1_arg0, 0x48216881A2EA3A1, 0x25E6910D90BDEA9, 2134))
	HealingPerGame.StatHeaderText:setText(LocalizeToUpperString(0x3D18843B906256))
	self:addElement(HealingPerGame)
	self.HealingPerGame = HealingPerGame
	local HealLifeRatio = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 504, 525)
	HealLifeRatio.StatHeaderText:setText(LocalizeToUpperString(0xC8DC799B6329C34))
	HealLifeRatio.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatRatio(f1_arg0, 0x48216881A2EA3A1, 0x6ED920648D707FA, 8.13))
	self:addElement(HealLifeRatio)
	self.HealLifeRatio = HealLifeRatio
	local AverageLife = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 525, 546)
	AverageLife.StatHeaderText:setText(LocalizeToUpperString(0x964663B30F4C0DD))
	AverageLife.StatValue:setText(SecondsAsTime(CoD.PlayerStatsUtility.GetPlayerStorageStatRatioRounded(f1_arg0, 0x3BF15114F02AF7B, 0x6ED920648D707FA, "1:02")))
	self:addElement(AverageLife)
	self.AverageLife = AverageLife
	local DamagePerGame = CoD.PlayerStatsMain.new(f1_arg0, f1_arg1, 0, 0, 15.5, 215.5, 0, 0, 582, 649)
	DamagePerGame.StatValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStatRatioRounded(f1_arg0, 0xD238EA28DDDB583, 0x25E6910D90BDEA9, 2134))
	DamagePerGame.StatHeaderText:setText(LocalizeToUpperString(0x92A67A7E572FF7D))
	self:addElement(DamagePerGame)
	self.DamagePerGame = DamagePerGame
	local DamagePerMinute = CoD.PlayerStatsDetailed.new(f1_arg0, f1_arg1, 0, 0, 164, 466, 0, 0, 607, 628)
	DamagePerMinute.StatHeaderText:setText(LocalizeToUpperString(0x879843A2F29796B))
	DamagePerMinute.StatValue:setText(SecondsAsTime(CoD.PlayerStatsUtility.GetPlayerStorageStatPerMinute(f1_arg0, 0xD238EA28DDDB583, 0x3BF15114F02AF7B, "1:02")))
	self:addElement(DamagePerMinute)
	self.DamagePerMinute = DamagePerMinute
	local dotline01 = LUI.UIImage.new(0, 0, 8.5, 468.5, 0, 0, 173, 177)
	dotline01:setAlpha(0.2)
	dotline01:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	dotline01:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline01)
	self.dotline01 = dotline01
	local dotline02 = LUI.UIImage.new(0, 0, 7.5, 469.5, 0, 0, 356, 360)
	dotline02:setAlpha(0.2)
	dotline02:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	dotline02:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline02)
	self.dotline02 = dotline02
	local dotline03 = LUI.UIImage.new(0, 0, 8, 468, 0, 0, 462, 466)
	dotline03:setAlpha(0.2)
	dotline03:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	dotline03:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline03)
	self.dotline03 = dotline03
	local dotline04 = LUI.UIImage.new(0, 0, 8, 468, 0, 0, 565, 569)
	dotline04:setAlpha(0.2)
	dotline04:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline04:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	dotline04:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline04)
	self.dotline04 = dotline04
	local CornerPipR = LUI.UIImage.new(0, 0, 433, 467, 0, 0, 42.5, 8.5)
	CornerPipR:setAlpha(0.1)
	CornerPipR:setImage(RegisterImage(0x811A80C0AADA825))
	CornerPipR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	CornerPipR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CornerPipR)
	self.CornerPipR = CornerPipR
	local CornerPipL = LUI.UIImage.new(0, 0, 10, 44, 0, 0, 42.5, 8.5)
	CornerPipL:setAlpha(0.1)
	CornerPipL:setZRot(90)
	CornerPipL:setImage(RegisterImage(0x811A80C0AADA825))
	CornerPipL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	CornerPipL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CornerPipL)
	self.CornerPipL = CornerPipL
	local f1_local33 = TimePlayedText
	local f1_local34 = TimePlayedText.subscribeToModel
	local f1_local35 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local34(f1_local33, f1_local35["PrestigeMenuInfo.hasPrestiged"], TimePlayedText.__String_Reference)
	f1_local33 = Wins
	f1_local34 = Wins.subscribeToModel
	f1_local35 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local34(f1_local33, f1_local35["PrestigeMenuInfo.hasPrestiged"], Wins.StatValue.__Stat_Value)
	f1_local33 = Losses
	f1_local34 = Losses.subscribeToModel
	f1_local35 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local34(f1_local33, f1_local35["PrestigeMenuInfo.hasPrestiged"], Losses.StatValue.__Stat_Value)
	f1_local33 = EKIA
	f1_local34 = EKIA.subscribeToModel
	f1_local35 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local34(f1_local33, f1_local35["PrestigeMenuInfo.hasPrestiged"], EKIA.StatValue.__Stat_Value)
	f1_local33 = Deaths
	f1_local34 = Deaths.subscribeToModel
	f1_local35 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local34(f1_local33, f1_local35["PrestigeMenuInfo.hasPrestiged"], Deaths.StatValue.__Stat_Value)
	f1_local33 = DirectActionKills
	f1_local34 = DirectActionKills.subscribeToModel
	f1_local35 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local34(f1_local33, f1_local35["PrestigeMenuInfo.hasPrestiged"], DirectActionKills.StatValue.__Stat_Value)
	f1_local33 = Score
	f1_local34 = Score.subscribeToModel
	f1_local35 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local34(f1_local33, f1_local35["PrestigeMenuInfo.hasPrestiged"], Score.StatValue.__Stat_Value)
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
CoD.Barracks_StatsOverview.__resetProperties = function(f10_arg0)
	f10_arg0.TimePlayedText:completeAnimation()
	f10_arg0.TimePlayedText:setTopBottom(0, 0, 44, 62)
end
CoD.Barracks_StatsOverview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.TimePlayedText:completeAnimation()
			f12_arg0.TimePlayedText:setTopBottom(0, 0, 50, 63)
			f12_arg0.clipFinished(f12_arg0.TimePlayedText)
		end,
	},
}
CoD.Barracks_StatsOverview.__onClose = function(f13_arg0)
	f13_arg0.CommonDetailPanel2:close()
	f13_arg0.TimePlayedText:close()
	f13_arg0.Wins:close()
	f13_arg0.Losses:close()
	f13_arg0.WinLossRatio:close()
	f13_arg0.EKIA:close()
	f13_arg0.Deaths:close()
	f13_arg0.EKIADeathRatio:close()
	f13_arg0.EKIAGameRatio:close()
	f13_arg0.DirectActionKills:close()
	f13_arg0.HeadshotPct:close()
	f13_arg0.HighestKillStreak:close()
	f13_arg0.Score:close()
	f13_arg0.ScorePerMinute:close()
	f13_arg0.ScorePerGame:close()
	f13_arg0.HealingPerGame:close()
	f13_arg0.HealLifeRatio:close()
	f13_arg0.AverageLife:close()
	f13_arg0.DamagePerGame:close()
	f13_arg0.DamagePerMinute:close()
end
