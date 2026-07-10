require("x64:fba4267ffde82d4")
require("x64:576d89990c6e6ac")
CoD.ScoreInfoEscort = InheritFrom(LUI.UIElement)
CoD.ScoreInfoEscort.__defaultWidth = 222
CoD.ScoreInfoEscort.__defaultHeight = 122
CoD.ScoreInfoEscort.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfoEscort)
	self.id = "ScoreInfoEscort"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local FrameEscort = LUI.UIImage.new(0, 0, 0, 222, 0, 0, 0, 122)
	FrameEscort:setImage(RegisterImage(0x6577725EEE88A2))
	self:addElement(FrameEscort)
	self.FrameEscort = FrameEscort
	local EscortBar = CoD.ScoreInfoEscortBar.new(f1_arg0, f1_arg1, 0, 0, 29, 193, 0, 0, 56, 100)
	self:addElement(EscortBar)
	self.EscortBar = EscortBar
	local FriendlyWinPips = CoD.ScoreInfo_RoundList.new(f1_arg0, f1_arg1, 0.5, 0.5, -87, -15, 0, 0, 54, 86)
	FriendlyWinPips.RoundPips:setDataSource("PlayerTeamRoundPips")
	FriendlyWinPips.RoundScoreText:setRGB(1, 0.99, 1)
	FriendlyWinPips:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScore", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FriendlyWinPips.RoundScoreText:setText(CoD.GameTypeUtility.RoundsWonOfRoundsTotal(f2_local0))
		end
	end)
	self:addElement(FriendlyWinPips)
	self.FriendlyWinPips = FriendlyWinPips
	local EnemyWinPips = CoD.ScoreInfo_RoundList.new(f1_arg0, f1_arg1, 0.5, 0.5, 15, 87, 0, 0, 54, 86)
	EnemyWinPips.RoundPips:setDataSource("EnemyTeamRoundPips")
	EnemyWinPips:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnemyWinPips.RoundPips:setRGB(f3_local0)
		end
	end)
	EnemyWinPips:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EnemyWinPips.RoundScoreText:setRGB(f4_local0)
		end
	end)
	EnemyWinPips:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScore", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EnemyWinPips.RoundScoreText:setText(CoD.GameTypeUtility.RoundsWonOfRoundsTotal(f5_local0))
		end
	end)
	self:addElement(EnemyWinPips)
	self.EnemyWinPips = EnemyWinPips
	FriendlyWinPips.id = "FriendlyWinPips"
	EnemyWinPips.id = "EnemyWinPips"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoEscort.__onClose = function(f6_arg0)
	f6_arg0.EscortBar:close()
	f6_arg0.FriendlyWinPips:close()
	f6_arg0.EnemyWinPips:close()
end
