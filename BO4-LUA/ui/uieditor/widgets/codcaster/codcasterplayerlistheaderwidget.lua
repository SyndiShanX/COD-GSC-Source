require("x64:fd24c921a536ec2")
require("x64:6398e4f9aeb3650")
CoD.CodCasterPlayerListHeaderWidget = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerListHeaderWidget.__defaultWidth = 404
CoD.CodCasterPlayerListHeaderWidget.__defaultHeight = 8
CoD.CodCasterPlayerListHeaderWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPlayerListHeaderWidget)
	self.id = "CodCasterPlayerListHeaderWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TeamName = LUI.UIText.new(0, 0, 12, 300, 0, 0, 8, 35)
	TeamName:setRGB(0, 0, 0)
	TeamName:setAlpha(0)
	TeamName:setText("")
	TeamName:setTTF("ttmussels_demibold")
	TeamName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TeamName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TeamName)
	self.TeamName = TeamName
	local TeamColor = LUI.UIImage.new(0, 0, 0, 408, 0.5, 0.5, -4, 4)
	TeamColor:setImage(RegisterImage(0xEC8BB204A4E0070))
	self:addElement(TeamColor)
	self.TeamColor = TeamColor
	local TEMPScoreColumn2Header = CoD.TextWithBg.new(f1_arg0, f1_arg1, 1, 1, -111, -73, 0.5, 0.5, -22, 26)
	TEMPScoreColumn2Header:setAlpha(0)
	TEMPScoreColumn2Header.Bg:setRGB(0.31, 0.31, 0.31)
	TEMPScoreColumn2Header.Bg:setAlpha(0)
	TEMPScoreColumn2Header.Text:setRGB(0.88, 0.89, 0.93)
	TEMPScoreColumn2Header.Text:setAlpha(0.7)
	TEMPScoreColumn2Header.Text:setText(GetScoreboardColumnHeader(f1_arg1, 1, "Score"))
	self:addElement(TEMPScoreColumn2Header)
	self.TEMPScoreColumn2Header = TEMPScoreColumn2Header
	local TEMPScoreColumn3Header = CoD.TextWithBg.new(f1_arg0, f1_arg1, 1, 1, -60, 0, 0.5, 0.5, -22, 26)
	TEMPScoreColumn3Header:setAlpha(0)
	TEMPScoreColumn3Header.Bg:setRGB(0.31, 0.31, 0.31)
	TEMPScoreColumn3Header.Bg:setAlpha(0)
	TEMPScoreColumn3Header.Text:setRGB(0.88, 0.89, 0.93)
	TEMPScoreColumn3Header.Text:setAlpha(0.7)
	TEMPScoreColumn3Header.Text:setText(GetScoreboardColumnHeader(f1_arg1, 2, "Score"))
	self:addElement(TEMPScoreColumn3Header)
	self.TEMPScoreColumn3Header = TEMPScoreColumn3Header
	local KD = LUI.UIText.new(1, 1, -169, -100, 0, 0, 11, 35)
	KD:setRGB(0, 0, 0)
	KD:setAlpha(0)
	KD:setText(Engine[0xF9F1239CFD921FE](0x9F7AB977F072D55))
	KD:setTTF("ttmussels_regular")
	KD:setLetterSpacing(2)
	KD:setLineSpacing(5)
	KD:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KD:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KD)
	self.KD = KD
	local ScoreColumn3Header = CoD.CodCasterPlayerListHeaderObjectiveColumn.new(f1_arg0, f1_arg1, 1, 1, -47, -17, 0, 0, 5, 35)
	ScoreColumn3Header:setAlpha(0)
	self:addElement(ScoreColumn3Header)
	self.ScoreColumn3Header = ScoreColumn3Header
	local Killstreak = LUI.UIImage.new(1, 1, -95, -59, 0, 0, 3, 39)
	Killstreak:setAlpha(0)
	Killstreak:setImage(RegisterImage(0x7FCFF2E6BE4FFBC))
	self:addElement(Killstreak)
	self.Killstreak = Killstreak
	local KillIcon = LUI.UIImage.new(0, 0, 298, 318, 0, 0, 10, 30)
	KillIcon:setRGB(0.06, 0.06, 0.06)
	KillIcon:setAlpha(0)
	KillIcon:setImage(RegisterImage(0xD6EA61A12AEADCE))
	self:addElement(KillIcon)
	self.KillIcon = KillIcon
	local DeathIcon = LUI.UIImage.new(0, 0, 326, 346, 0, 0, 10, 30)
	DeathIcon:setRGB(0.09, 0.08, 0.08)
	DeathIcon:setAlpha(0)
	DeathIcon:setImage(RegisterImage(0x9E55E6818C34348))
	self:addElement(DeathIcon)
	self.DeathIcon = DeathIcon
	local KillStreakIcon = LUI.UIImage.new(0, 0, 382, 402, 0, 0, 10, 30)
	KillStreakIcon:setRGB(0.14, 0.13, 0.13)
	KillStreakIcon:setAlpha(0)
	KillStreakIcon:setImage(RegisterImage(0x6323B83A0678830))
	self:addElement(KillStreakIcon)
	self.KillStreakIcon = KillStreakIcon
	local ObjectiveIcon = LUI.UIImage.new(0, 0, 425, 445, 0, 0, 10, 30)
	ObjectiveIcon:setRGB(0.17, 0.16, 0.16)
	ObjectiveIcon:setAlpha(0)
	ObjectiveIcon:setImage(RegisterImage(0x9B36BAC94F853D))
	self:addElement(ObjectiveIcon)
	self.ObjectiveIcon = ObjectiveIcon
	local HealthIcon = LUI.UIImage.new(0, 0, 249, 272, 0, 0, 8, 31)
	HealthIcon:setRGB(0, 0, 0)
	HealthIcon:setAlpha(0)
	HealthIcon:setImage(RegisterImage(0x5655902DAB45F22))
	self:addElement(HealthIcon)
	self.HealthIcon = HealthIcon
	self:mergeStateConditions({
		{
			stateName = "NonTeamBased",
			condition = function(menu, element, event)
				return not IsGametypeTeambased()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPlayerListHeaderWidget.__resetProperties = function(f3_arg0)
	f3_arg0.TeamColor:completeAnimation()
	f3_arg0.TeamName:completeAnimation()
	f3_arg0.TeamColor:setAlpha(1)
	f3_arg0.TeamName:setAlpha(0)
end
CoD.CodCasterPlayerListHeaderWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	NonTeamBased = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.TeamName:completeAnimation()
			f5_arg0.TeamName:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TeamName)
			f5_arg0.TeamColor:completeAnimation()
			f5_arg0.TeamColor:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TeamColor)
		end,
	},
}
CoD.CodCasterPlayerListHeaderWidget.__onClose = function(f6_arg0)
	f6_arg0.TEMPScoreColumn2Header:close()
	f6_arg0.TEMPScoreColumn3Header:close()
	f6_arg0.ScoreColumn3Header:close()
end
