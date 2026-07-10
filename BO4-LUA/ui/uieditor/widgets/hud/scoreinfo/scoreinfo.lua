require("x64:76b89c73379cfb5")
require("x64:68e8f00efa22b76")
require("x64:662f5e0bf553163")
require("x64:b606c2b63bb56d6")
CoD.ScoreInfo = InheritFrom(LUI.UIElement)
CoD.ScoreInfo.__defaultWidth = 210
CoD.ScoreInfo.__defaultHeight = 68
CoD.ScoreInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "gameScore.gameTimeLow", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "PlayerTeamLastLivesData.teamSize", 1)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "EnemyTeamLastLivesData.teamSize", 1)
	self:setClass(CoD.ScoreInfo)
	self.id = "ScoreInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 2, 208, 0, 0, 2, 65)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Panel = LUI.UIImage.new(0, 0, 4, 206, 0, 0, 1, 66)
	Panel:setRGB(0.18, 0.17, 0.16)
	Panel:setAlpha(0.94)
	self:addElement(Panel)
	self.Panel = Panel
	local EnemyTeamScoreContainer = CoD.ScoreInfo_ScoreContainer.new(f1_arg0, f1_arg1, 0, 0, 123, 203, 0, 0, 5, 171)
	EnemyTeamScoreContainer.ScoreContainerInternal.ControlRoundPips.RoundPips:setDataSource("EnemyTeamRoundPips")
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.Container2:setAlpha(0.9)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty2:setAlpha(1)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2:setAlpha(1)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapBottom2:setAlpha(1)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapTop2:setAlpha(1)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.Container:setAlpha(0)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:setAlpha(0)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setAlpha(0)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapBottom:setAlpha(0)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapTop:setAlpha(0)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:setAlpha(0)
	EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.Container2:setAlpha(0)
	EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.Diamond:setAlpha(0)
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ControlRoundPips.RoundPips:setRGB(f2_local0)
		end
	end)
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ControlRoundPips.RoundScoreText:setRGB(f3_local0)
		end
	end)
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScore", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ControlRoundPips.RoundScoreText:setText(CoD.GameTypeUtility.RoundsWonOfRoundsTotal(f4_local0))
		end
	end)
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2:setRGB(f5_local0)
		end
	end)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2.__ScoreContainerInternal_ScoreBar_Progress_Percent = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2:setShaderVector(2, DivideByScoreLimit(f1_arg1, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScore", EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2.__ScoreContainerInternal_ScoreBar_Progress_Percent)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2.__ScoreContainerInternal_ScoreBar_Progress_Percent_FullPath = function()
		local f7_local0 = DataSources.GameScore.getModel(f1_arg1)
		f7_local0 = f7_local0.enemyScore
		if f7_local0 then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2.__ScoreContainerInternal_ScoreBar_Progress_Percent(f7_local0)
		end
	end
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setRGB(f8_local0)
		end
	end)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setShaderVector(2, DivideByScoreLimit(f1_arg1, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4)))
		end
	end
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScore", EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent)
	EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent_FullPath = function()
		local f10_local0 = DataSources.GameScore.getModel(f1_arg1)
		f10_local0 = f10_local0.enemyScore
		if f10_local0 then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent(f10_local0)
		end
	end
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScore", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.ScoreText2:setText(f11_local0)
		end
	end)
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScore", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.ScoreText:setText(f12_local0)
		end
	end)
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "EnemyTeamLastLivesData", nil, function(model)
		EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives:setModel(model, f1_arg1)
	end)
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesIcon:setRGB(f14_local0)
		end
	end)
	EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count = function(f15_arg0)
		local f15_local0 = f15_arg0:get()
		if f15_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2:setText(CoD.HUDUtility.AddTeamSize(f1_arg1, 1, f15_local0))
		end
	end
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "TeamLivesData", "enemyTeamLives", EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count)
	EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count_FullPath = function()
		local f16_local0 = DataSources.TeamLivesData.getModel(f1_arg1)
		f16_local0 = f16_local0.enemyTeamLives
		if f16_local0 then
			EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count(f16_local0)
		end
	end
	EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count = function(f17_arg0)
		local f17_local0 = f17_arg0:get()
		if f17_local0 ~= nil then
			EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount:setText(CoD.HUDUtility.AddTeamSize(f1_arg1, 1, f17_local0))
		end
	end
	EnemyTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "TeamLivesData", "enemyTeamLives", EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count)
	EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count_FullPath = function()
		local f18_local0 = DataSources.TeamLivesData.getModel(f1_arg1)
		f18_local0 = f18_local0.enemyTeamLives
		if f18_local0 then
			EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count(f18_local0)
		end
	end
	self:addElement(EnemyTeamScoreContainer)
	self.EnemyTeamScoreContainer = EnemyTeamScoreContainer
	local PlayerTeamScoreContainer = CoD.ScoreInfo_ScoreContainer.new(f1_arg0, f1_arg1, 0, 0, 11, 91, 0, 0, 5, 171)
	PlayerTeamScoreContainer.ScoreContainerInternal.ControlRoundPips.RoundPips:setDataSource("PlayerTeamRoundPips")
	PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half2:setAlpha(0)
	PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.Container:setAlpha(0)
	PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.Diamond2:setAlpha(0)
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScore", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.ControlRoundPips.RoundScoreText:setText(CoD.GameTypeUtility.RoundsWonOfRoundsTotal(f19_local0))
		end
	end)
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveFriendlyColor", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setRGB(f20_local0)
		end
	end)
	PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent = function(f21_arg0)
		local f21_local0 = f21_arg0:get()
		if f21_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setShaderVector(2, DivideByScoreLimit(f1_arg1, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4)))
		end
	end
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScore", PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent)
	PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent_FullPath = function()
		local f22_local0 = DataSources.GameScore.getModel(f1_arg1)
		f22_local0 = f22_local0.playerScore
		if f22_local0 then
			PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent(f22_local0)
		end
	end
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScore", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.ScoreText2:setText(f23_local0)
		end
	end)
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScore", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.ScoreText:setText(f24_local0)
		end
	end)
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "PlayerTeamLastLivesData", nil, function(model)
		PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives:setModel(model, f1_arg1)
	end)
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveFriendlyColor", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesIcon:setRGB(f26_local0)
		end
	end)
	PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count = function(f27_arg0)
		local f27_local0 = f27_arg0:get()
		if f27_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2:setText(CoD.HUDUtility.AddTeamSize(f1_arg1, 0, f27_local0))
		end
	end
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "TeamLivesData", "playerTeamLives", PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count)
	PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count_FullPath = function()
		local f28_local0 = DataSources.TeamLivesData.getModel(f1_arg1)
		f28_local0 = f28_local0.playerTeamLives
		if f28_local0 then
			PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count(f28_local0)
		end
	end
	PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count = function(f29_arg0)
		local f29_local0 = f29_arg0:get()
		if f29_local0 ~= nil then
			PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount:setText(CoD.HUDUtility.AddTeamSize(f1_arg1, 0, f29_local0))
		end
	end
	PlayerTeamScoreContainer:subscribeToGlobalModel(f1_arg1, "TeamLivesData", "playerTeamLives", PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count)
	PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count_FullPath = function()
		local f30_local0 = DataSources.TeamLivesData.getModel(f1_arg1)
		f30_local0 = f30_local0.playerTeamLives
		if f30_local0 then
			PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count(f30_local0)
		end
	end
	LUI.OverrideFunction_CallOriginalFirst(PlayerTeamScoreContainer, "setHeight", function(element, controller)
		ScaleToElementHeight(self, element, 0)
	end)
	self:addElement(PlayerTeamScoreContainer)
	self.PlayerTeamScoreContainer = PlayerTeamScoreContainer
	local LED = LUI.UIImage.new(0, 0, -5, 217, 0, 0, -45, 77)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.2)
	LED:setImage(RegisterImage(0x246EAAAA50A60D7))
	self:addElement(LED)
	self.LED = LED
	local LEDFull = LUI.UIImage.new(0, 0, -5, 217, 0, 0, -45, 77)
	LEDFull:setRGB(0, 0, 0)
	LEDFull:setAlpha(0.2)
	LEDFull:setImage(RegisterImage(0x322B09BC49B50F1))
	self:addElement(LEDFull)
	self.LEDFull = LEDFull
	local Frame = LUI.UIImage.new(0, 0, -5, 217, 0, 0, -45.5, 76.5)
	Frame:setImage(RegisterImage(0x5410432CF8A125A))
	self:addElement(Frame)
	self.Frame = Frame
	local EscortScoreInfo = CoD.ScoreInfoEscort.new(f1_arg0, f1_arg1, 0, 0, -5, 217, 0, 0, -45.5, 76.5)
	self:addElement(EscortScoreInfo)
	self.EscortScoreInfo = EscortScoreInfo
	local PropScoreInfo = CoD.ScoreInfoProp.new(f1_arg0, f1_arg1, 0, 0, -5, 217, 0, 0, -45.5, 76.5)
	PropScoreInfo:setAlpha(0)
	self:addElement(PropScoreInfo)
	self.PropScoreInfo = PropScoreInfo
	local ScoreInfoCTF = CoD.ScoreInfoCTF.new(f1_arg0, f1_arg1, 0, 0, -5, 217, 0, 0, 80, 202)
	ScoreInfoCTF:setAlpha(0)
	self:addElement(ScoreInfoCTF)
	self.ScoreInfoCTF = ScoreInfoCTF
	local f1_local11 = EnemyTeamScoreContainer
	local f1_local12 = EnemyTeamScoreContainer.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["gameScore.roundsPlayed"], EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill2.__ScoreContainerInternal_ScoreBar_Progress_Percent_FullPath)
	f1_local11 = EnemyTeamScoreContainer
	f1_local12 = EnemyTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["gameScore.roundsPlayed"], EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent_FullPath)
	f1_local11 = EnemyTeamScoreContainer
	f1_local12 = EnemyTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["PlayerTeamLastLivesData.teamSize"], EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count_FullPath)
	f1_local11 = EnemyTeamScoreContainer
	f1_local12 = EnemyTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["EnemyTeamLastLivesData.teamSize"], EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count_FullPath)
	f1_local11 = EnemyTeamScoreContainer
	f1_local12 = EnemyTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["PlayerTeamLastLivesData.teamSize"], EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count_FullPath)
	f1_local11 = EnemyTeamScoreContainer
	f1_local12 = EnemyTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["EnemyTeamLastLivesData.teamSize"], EnemyTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count_FullPath)
	f1_local11 = PlayerTeamScoreContainer
	f1_local12 = PlayerTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["gameScore.roundsPlayed"], PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill.__ScoreContainerInternal_ScoreBar_Progress_Percent_FullPath)
	f1_local11 = PlayerTeamScoreContainer
	f1_local12 = PlayerTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["PlayerTeamLastLivesData.teamSize"], PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count_FullPath)
	f1_local11 = PlayerTeamScoreContainer
	f1_local12 = PlayerTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["EnemyTeamLastLivesData.teamSize"], PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount2.__ScoreContainerInternal_TeamLives_Team_Lives_Count_FullPath)
	f1_local11 = PlayerTeamScoreContainer
	f1_local12 = PlayerTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["PlayerTeamLastLivesData.teamSize"], PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count_FullPath)
	f1_local11 = PlayerTeamScoreContainer
	f1_local12 = PlayerTeamScoreContainer.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["EnemyTeamLastLivesData.teamSize"], PlayerTeamScoreContainer.ScoreContainerInternal.TeamLives.TeamLivesCount.__Team_Lives_Count_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Escort",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("escort")
			end,
		},
		{
			stateName = "Prop",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("prop")
			end,
		},
		{
			stateName = "CTF",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("ctf")
			end,
		},
		{
			stateName = "RoundBased",
			condition = function(menu, element, event)
				return IsGametypeSettingsValue("roundLimit", 2)
			end,
		},
	})
	EnemyTeamScoreContainer.id = "EnemyTeamScoreContainer"
	PlayerTeamScoreContainer.id = "PlayerTeamScoreContainer"
	EscortScoreInfo.id = "EscortScoreInfo"
	PropScoreInfo.id = "PropScoreInfo"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfo.__resetProperties = function(f36_arg0)
	f36_arg0.PlayerTeamScoreContainer:completeAnimation()
	f36_arg0.EnemyTeamScoreContainer:completeAnimation()
	f36_arg0.EscortScoreInfo:completeAnimation()
	f36_arg0.LEDFull:completeAnimation()
	f36_arg0.Frame:completeAnimation()
	f36_arg0.LED:completeAnimation()
	f36_arg0.PropScoreInfo:completeAnimation()
	f36_arg0.ScoreInfoCTF:completeAnimation()
	f36_arg0.Panel:completeAnimation()
	f36_arg0.Blur:completeAnimation()
	f36_arg0.PlayerTeamScoreContainer:setTopBottom(0, 0, 5, 171)
	f36_arg0.PlayerTeamScoreContainer:setAlpha(1)
	f36_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:setAlpha(1)
	f36_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setAlpha(1)
	f36_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapBottom:setAlpha(1)
	f36_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(1)
	f36_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half2:setAlpha(0)
	f36_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:setAlpha(1)
	f36_arg0.EnemyTeamScoreContainer:setTopBottom(0, 0, 5, 171)
	f36_arg0.EnemyTeamScoreContainer:setAlpha(1)
	f36_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(1)
	f36_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half2:setAlpha(1)
	f36_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:setAlpha(0)
	f36_arg0.EscortScoreInfo:setTopBottom(0, 0, -45.5, 76.5)
	f36_arg0.EscortScoreInfo:setAlpha(1)
	f36_arg0.LEDFull:setTopBottom(0, 0, -45, 77)
	f36_arg0.LEDFull:setAlpha(0.2)
	f36_arg0.Frame:setTopBottom(0, 0, -45.5, 76.5)
	f36_arg0.Frame:setAlpha(1)
	f36_arg0.LED:setTopBottom(0, 0, -45, 77)
	f36_arg0.LED:setAlpha(0.2)
	f36_arg0.PropScoreInfo:setTopBottom(0, 0, -45.5, 76.5)
	f36_arg0.PropScoreInfo:setAlpha(0)
	f36_arg0.ScoreInfoCTF:setAlpha(0)
	f36_arg0.Panel:setTopBottom(0, 0, 1, 66)
	f36_arg0.Blur:setTopBottom(0, 0, 2, 65)
end
CoD.ScoreInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			f37_arg0.EnemyTeamScoreContainer:completeAnimation()
			f37_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:completeAnimation()
			f37_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.EnemyTeamScoreContainer)
			f37_arg0.PlayerTeamScoreContainer:completeAnimation()
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:completeAnimation()
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:completeAnimation()
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapBottom:completeAnimation()
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:completeAnimation()
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:completeAnimation()
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:setAlpha(1)
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setAlpha(1)
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapBottom:setAlpha(1)
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(0)
			f37_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.PlayerTeamScoreContainer)
			f37_arg0.LEDFull:completeAnimation()
			f37_arg0.LEDFull:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.LEDFull)
			f37_arg0.EscortScoreInfo:completeAnimation()
			f37_arg0.EscortScoreInfo:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.EscortScoreInfo)
		end,
	},
	Escort = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(5)
			f38_arg0.EnemyTeamScoreContainer:completeAnimation()
			f38_arg0.EnemyTeamScoreContainer:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.EnemyTeamScoreContainer)
			f38_arg0.PlayerTeamScoreContainer:completeAnimation()
			f38_arg0.PlayerTeamScoreContainer:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.PlayerTeamScoreContainer)
			f38_arg0.LED:completeAnimation()
			f38_arg0.LED:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.LED)
			f38_arg0.Frame:completeAnimation()
			f38_arg0.Frame:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Frame)
			f38_arg0.PropScoreInfo:completeAnimation()
			f38_arg0.PropScoreInfo:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.PropScoreInfo)
		end,
	},
	Prop = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(6)
			f39_arg0.EnemyTeamScoreContainer:completeAnimation()
			f39_arg0.EnemyTeamScoreContainer:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.EnemyTeamScoreContainer)
			f39_arg0.PlayerTeamScoreContainer:completeAnimation()
			f39_arg0.PlayerTeamScoreContainer:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.PlayerTeamScoreContainer)
			f39_arg0.LED:completeAnimation()
			f39_arg0.LED:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.LED)
			f39_arg0.Frame:completeAnimation()
			f39_arg0.Frame:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.Frame)
			f39_arg0.EscortScoreInfo:completeAnimation()
			f39_arg0.EscortScoreInfo:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.EscortScoreInfo)
			f39_arg0.PropScoreInfo:completeAnimation()
			f39_arg0.PropScoreInfo:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.PropScoreInfo)
		end,
	},
	CTF = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(10)
			f40_arg0.Blur:completeAnimation()
			f40_arg0.Blur:setTopBottom(0, 0, 2, 65)
			f40_arg0.clipFinished(f40_arg0.Blur)
			f40_arg0.Panel:completeAnimation()
			f40_arg0.Panel:setTopBottom(0, 0, 1, 66)
			f40_arg0.clipFinished(f40_arg0.Panel)
			f40_arg0.EnemyTeamScoreContainer:completeAnimation()
			f40_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:completeAnimation()
			f40_arg0.EnemyTeamScoreContainer:setTopBottom(0, 0, 5, 171)
			f40_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.EnemyTeamScoreContainer)
			f40_arg0.PlayerTeamScoreContainer:completeAnimation()
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:completeAnimation()
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:completeAnimation()
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapBottom:completeAnimation()
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:completeAnimation()
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:completeAnimation()
			f40_arg0.PlayerTeamScoreContainer:setTopBottom(0, 0, 5, 171)
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:setAlpha(1)
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterFill:setAlpha(1)
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.CapBottom:setAlpha(1)
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(0)
			f40_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.PlayerTeamScoreContainer)
			f40_arg0.LED:completeAnimation()
			f40_arg0.LED:setTopBottom(0, 0, -45, 77)
			f40_arg0.clipFinished(f40_arg0.LED)
			f40_arg0.LEDFull:completeAnimation()
			f40_arg0.LEDFull:setTopBottom(0, 0, -45, 77)
			f40_arg0.LEDFull:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.LEDFull)
			f40_arg0.Frame:completeAnimation()
			f40_arg0.Frame:setTopBottom(0, 0, -45.5, 76.5)
			f40_arg0.clipFinished(f40_arg0.Frame)
			f40_arg0.EscortScoreInfo:completeAnimation()
			f40_arg0.EscortScoreInfo:setTopBottom(0, 0, -45.5, 76.5)
			f40_arg0.EscortScoreInfo:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.EscortScoreInfo)
			f40_arg0.PropScoreInfo:completeAnimation()
			f40_arg0.PropScoreInfo:setTopBottom(0, 0, -45.5, 76.5)
			f40_arg0.clipFinished(f40_arg0.PropScoreInfo)
			f40_arg0.ScoreInfoCTF:completeAnimation()
			f40_arg0.ScoreInfoCTF:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ScoreInfoCTF)
		end,
	},
	RoundBased = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(5)
			f41_arg0.EnemyTeamScoreContainer:completeAnimation()
			f41_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:completeAnimation()
			f41_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half2:completeAnimation()
			f41_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:completeAnimation()
			f41_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(0.99)
			f41_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half2:setAlpha(1)
			f41_arg0.EnemyTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.EnemyTeamScoreContainer)
			f41_arg0.PlayerTeamScoreContainer:completeAnimation()
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:completeAnimation()
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:completeAnimation()
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half2:completeAnimation()
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:completeAnimation()
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.MeterEmpty:setAlpha(1)
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft:setAlpha(0.99)
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half2:setAlpha(0)
			f41_arg0.PlayerTeamScoreContainer.ScoreContainerInternal.ScoreBar.RoundPipLeft.Half:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.PlayerTeamScoreContainer)
			f41_arg0.LEDFull:completeAnimation()
			f41_arg0.LEDFull:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.LEDFull)
			f41_arg0.EscortScoreInfo:completeAnimation()
			f41_arg0.EscortScoreInfo:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.EscortScoreInfo)
			f41_arg0.PropScoreInfo:completeAnimation()
			f41_arg0.PropScoreInfo:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PropScoreInfo)
		end,
	},
}
CoD.ScoreInfo.__onClose = function(f42_arg0)
	f42_arg0.EnemyTeamScoreContainer:close()
	f42_arg0.PlayerTeamScoreContainer:close()
	f42_arg0.EscortScoreInfo:close()
	f42_arg0.PropScoreInfo:close()
	f42_arg0.ScoreInfoCTF:close()
end
