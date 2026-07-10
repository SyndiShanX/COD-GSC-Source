CoD.SelectedFilmSummaryGameResult = InheritFrom(LUI.UIElement)
CoD.SelectedFilmSummaryGameResult.__defaultWidth = 577
CoD.SelectedFilmSummaryGameResult.__defaultHeight = 36
CoD.SelectedFilmSummaryGameResult.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 12, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.SelectedFilmSummaryGameResult)
	self.id = "SelectedFilmSummaryGameResult"
	self.soundSet = "default"
	local GameResult = LUI.UIText.new(0, 0, 0, 102, 0.5, 0.5, -18, 18)
	GameResult:setTTF("ttmussels_regular")
	GameResult:setLetterSpacing(1)
	GameResult:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GameResult:linkToElementModel(self, "gameResultText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GameResult:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(GameResult)
	self.GameResult = GameResult
	local PlayerScore = LUI.UIText.new(0, 0, 114, 165, 0.5, 0.5, -18, 18)
	PlayerScore:setTTF("ttmussels_regular")
	PlayerScore:setLetterSpacing(1)
	PlayerScore:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlayerScore:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	PlayerScore:linkToElementModel(self, "playerScore", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerScore:setText(f3_local0)
		end
	end)
	self:addElement(PlayerScore)
	self.PlayerScore = PlayerScore
	local ScoreSeperator = LUI.UIText.new(0, 0, 165, 197, 0.5, 0.5, -18, 18)
	ScoreSeperator:setText(CoD.BaseUtility.AlreadyLocalized("-"))
	ScoreSeperator:setTTF("default")
	ScoreSeperator:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ScoreSeperator:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ScoreSeperator)
	self.ScoreSeperator = ScoreSeperator
	local OppositionScore = LUI.UIText.new(0, 0, 209, 370, 0.5, 0.5, -18, 18)
	OppositionScore:setTTF("ttmussels_regular")
	OppositionScore:setLetterSpacing(1)
	OppositionScore:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OppositionScore:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	OppositionScore:linkToElementModel(self, "oppositionScore", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			OppositionScore:setText(f4_local0)
		end
	end)
	self:addElement(OppositionScore)
	self.OppositionScore = OppositionScore
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SelectedFilmSummaryGameResult.__onClose = function(f5_arg0)
	f5_arg0.GameResult:close()
	f5_arg0.PlayerScore:close()
	f5_arg0.OppositionScore:close()
end
