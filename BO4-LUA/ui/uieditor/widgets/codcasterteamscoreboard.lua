require("x64:8b7a1fef811bc3a")
require("x64:6a28b92b4010049")
CoD.CodCasterTeamScoreboard = InheritFrom(LUI.UIElement)
CoD.CodCasterTeamScoreboard.__defaultWidth = 520
CoD.CodCasterTeamScoreboard.__defaultHeight = 116
CoD.CodCasterTeamScoreboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterTeamScoreboard)
	self.id = "CodCasterTeamScoreboard"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBot = LUI.UIImage.new(0.5, 0.5, -233, 233, 0.62, 0.62, -37.5, 37.5)
	BlurBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBot:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBot)
	self.BlurBot = BlurBot
	local BlurTop = LUI.UIImage.new(0.5, 0.5, -235, 235, 0.18, 0.18, -12.5, 12.5)
	BlurTop:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurTop:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurTop)
	self.BlurTop = BlurTop
	local TeamBackingAlliedBot = LUI.UIImage.new(0, 0, 31.5, 205.5, 0, 0, 36, 106)
	TeamBackingAlliedBot:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamBackingAlliedBot:setRGB(f2_local0)
		end
	end)
	self:addElement(TeamBackingAlliedBot)
	self.TeamBackingAlliedBot = TeamBackingAlliedBot
	local TeamBackingAlliedTop = LUI.UIImage.new(0, 0, 31.5, 151.5, 0, 0, 8.5, 33.5)
	TeamBackingAlliedTop:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TeamBackingAlliedTop:setRGB(f3_local0)
		end
	end)
	self:addElement(TeamBackingAlliedTop)
	self.TeamBackingAlliedTop = TeamBackingAlliedTop
	local TeamBackingAxisBot = LUI.UIImage.new(0, 0, 317, 491, 0, 0, 36, 106)
	TeamBackingAxisBot:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "axisFactionColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TeamBackingAxisBot:setRGB(f4_local0)
		end
	end)
	self:addElement(TeamBackingAxisBot)
	self.TeamBackingAxisBot = TeamBackingAxisBot
	local TeamBackingAxisTop = LUI.UIImage.new(0, 0, 368, 488, 0, 0, 8.5, 33.5)
	TeamBackingAxisTop:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "axisFactionColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TeamBackingAxisTop:setRGB(f5_local0)
		end
	end)
	self:addElement(TeamBackingAxisTop)
	self.TeamBackingAxisTop = TeamBackingAxisTop
	local teamleft = CoD.codcasterTeamscoreboardColor.new(f1_arg0, f1_arg1, 0.06, 0.06, -2, 178, 0, 0, 6, 110)
	teamleft.score:setText("")
	teamleft.score2:setText("")
	teamleft:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionIcon", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			teamleft.teamlogo:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(teamleft)
	self.teamleft = teamleft
	local teamright = CoD.codcasterTeamscoreboardColor.new(f1_arg0, f1_arg1, 1, 1, -207, -27, 0, 0, 6, 110)
	teamright:setXRot(180)
	teamright:setZRot(180)
	teamright.teamlogo:setYRot(180)
	teamright.score:setYRot(180)
	teamright.score:setText("")
	teamright.score2:setYRot(180)
	teamright.score2:setText("")
	teamright.TeamnameShadow:setAlpha(0)
	teamright.Teamname:setAlpha(0)
	teamright:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "axisFactionIcon", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			teamright.teamlogo:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(teamright)
	self.teamright = teamright
	local SelectArrowRight = LUI.UIImage.new(0, 0, 317, 333, 0, 0, 37, 105)
	SelectArrowRight:setAlpha(0)
	SelectArrowRight:setYRot(180)
	SelectArrowRight:setImage(RegisterImage(0xCDDB5BA2ABCA6CF))
	SelectArrowRight:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "axisFactionColor", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			SelectArrowRight:setRGB(f8_local0)
		end
	end)
	self:addElement(SelectArrowRight)
	self.SelectArrowRight = SelectArrowRight
	local SelectArrowLeft = LUI.UIImage.new(0, 0, 189, 205, 0, 0, 37, 105)
	SelectArrowLeft:setAlpha(0)
	SelectArrowLeft:setImage(RegisterImage(0xCDDB5BA2ABCA6CF))
	SelectArrowLeft:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "alliesFactionColor", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			SelectArrowLeft:setRGB(f9_local0)
		end
	end)
	self:addElement(SelectArrowLeft)
	self.SelectArrowLeft = SelectArrowLeft
	local frame = LUI.UIImage.new(0.5, 0.5, -260, 260, 0, 0, 0, 116)
	frame:setImage(RegisterImage(0x61C3519381A43C7))
	self:addElement(frame)
	self.frame = frame
	local GameTimer = CoD.Codcaster_timer_nl.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0, 0, 44.5, 71.5)
	self:addElement(GameTimer)
	self.GameTimer = GameTimer
	local gamemode = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 10, 30)
	gamemode:setTTF("ttmussels_demibold")
	gamemode:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	gamemode:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	gamemode:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	gamemode:subscribeToGlobalModel(f1_arg1, "Scoreboard", "gameType", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			gamemode:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	self:addElement(gamemode)
	self.gamemode = gamemode
	local TeamIndicatorLeft = LUI.UIImage.new(0, 0, 3, 43, 0, 0, 31, 111)
	TeamIndicatorLeft:setAlpha(0)
	TeamIndicatorLeft:setImage(RegisterImage(0xC5A305502986CC7))
	TeamIndicatorLeft:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "alliesFactionColor", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			TeamIndicatorLeft:setRGB(f11_local0)
		end
	end)
	self:addElement(TeamIndicatorLeft)
	self.TeamIndicatorLeft = TeamIndicatorLeft
	local TeamIndicatorRight = LUI.UIImage.new(0, 0, 479, 519, 0, 0, 31, 111)
	TeamIndicatorRight:setAlpha(0)
	TeamIndicatorRight:setYRot(180)
	TeamIndicatorRight:setImage(RegisterImage(0xC5A305502986CC7))
	TeamIndicatorRight:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "axisFactionColor", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			TeamIndicatorRight:setRGB(f12_local0)
		end
	end)
	self:addElement(TeamIndicatorRight)
	self.TeamIndicatorRight = TeamIndicatorRight
	local teamname4 = LUI.UIText.new(-0.5, -0.5, 633, 743, 0, 0, 14, 32)
	teamname4:setRGB(0, 0, 0)
	teamname4:setAlpha(0.75)
	teamname4:setTTF("notosans_bold")
	teamname4:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	teamname4:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	teamname4:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionDisplayName", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			teamname4:setText(f13_local0)
		end
	end)
	self:addElement(teamname4)
	self.teamname4 = teamname4
	local teamname3 = LUI.UIText.new(-0.5, -0.5, 632, 742, 0, 0, 13, 31)
	teamname3:setTTF("notosans_bold")
	teamname3:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	teamname3:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	teamname3:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionDisplayName", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			teamname3:setText(f14_local0)
		end
	end)
	self:addElement(teamname3)
	self.teamname3 = teamname3
	self:mergeStateConditions({
		{
			stateName = "teamLeftwatch",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.CurrentSpectatedTeamEqualTo(f1_arg1, 1)
			end,
		},
		{
			stateName = "teamRigthwatch",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.CurrentSpectatedTeamEqualTo(f1_arg1, 2)
			end,
		},
	})
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local19(f1_local18, f1_local20["deadSpectator.playerTeam"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "deadSpectator.playerTeam",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local19 = self
	CoD.CodCasterUtility.InitScores(self, f1_arg1)
	return self
end
CoD.CodCasterTeamScoreboard.__resetProperties = function(f18_arg0)
	f18_arg0.gamemode:completeAnimation()
	f18_arg0.GameTimer:completeAnimation()
	f18_arg0.frame:completeAnimation()
	f18_arg0.teamright:completeAnimation()
	f18_arg0.teamleft:completeAnimation()
	f18_arg0.BlurTop:completeAnimation()
	f18_arg0.BlurBot:completeAnimation()
	f18_arg0.TeamIndicatorLeft:completeAnimation()
	f18_arg0.TeamIndicatorRight:completeAnimation()
	f18_arg0.teamname3:completeAnimation()
	f18_arg0.teamname4:completeAnimation()
	f18_arg0.TeamBackingAlliedBot:completeAnimation()
	f18_arg0.TeamBackingAxisBot:completeAnimation()
	f18_arg0.TeamBackingAxisTop:completeAnimation()
	f18_arg0.TeamBackingAlliedTop:completeAnimation()
	f18_arg0.SelectArrowLeft:completeAnimation()
	f18_arg0.SelectArrowRight:completeAnimation()
	f18_arg0.gamemode:setAlpha(1)
	f18_arg0.GameTimer:setAlpha(1)
	f18_arg0.frame:setAlpha(1)
	f18_arg0.teamright:setLeftRight(1, 1, -207, -27)
	f18_arg0.teamright:setAlpha(1)
	f18_arg0.teamleft:setAlpha(1)
	f18_arg0.BlurTop:setAlpha(1)
	f18_arg0.BlurBot:setAlpha(1)
	f18_arg0.TeamIndicatorLeft:setAlpha(0)
	f18_arg0.TeamIndicatorRight:setLeftRight(0, 0, 479, 519)
	f18_arg0.TeamIndicatorRight:setAlpha(0)
	f18_arg0.teamname3:setAlpha(1)
	f18_arg0.teamname4:setAlpha(0.75)
	f18_arg0.TeamBackingAlliedBot:setAlpha(1)
	f18_arg0.TeamBackingAxisBot:setAlpha(1)
	f18_arg0.TeamBackingAxisTop:setAlpha(1)
	f18_arg0.TeamBackingAlliedTop:setAlpha(1)
	f18_arg0.SelectArrowLeft:setAlpha(0)
	f18_arg0.SelectArrowRight:setAlpha(0)
end
CoD.CodCasterTeamScoreboard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(15)
			f19_arg0.BlurBot:completeAnimation()
			f19_arg0.BlurBot:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BlurBot)
			f19_arg0.BlurTop:completeAnimation()
			f19_arg0.BlurTop:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BlurTop)
			f19_arg0.TeamBackingAlliedBot:completeAnimation()
			f19_arg0.TeamBackingAlliedBot:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TeamBackingAlliedBot)
			f19_arg0.TeamBackingAlliedTop:completeAnimation()
			f19_arg0.TeamBackingAlliedTop:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TeamBackingAlliedTop)
			f19_arg0.TeamBackingAxisBot:completeAnimation()
			f19_arg0.TeamBackingAxisBot:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TeamBackingAxisBot)
			f19_arg0.TeamBackingAxisTop:completeAnimation()
			f19_arg0.TeamBackingAxisTop:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TeamBackingAxisTop)
			f19_arg0.teamleft:completeAnimation()
			f19_arg0.teamleft:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.teamleft)
			f19_arg0.teamright:completeAnimation()
			f19_arg0.teamright:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.teamright)
			f19_arg0.frame:completeAnimation()
			f19_arg0.frame:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.frame)
			f19_arg0.GameTimer:completeAnimation()
			f19_arg0.GameTimer:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.GameTimer)
			f19_arg0.gamemode:completeAnimation()
			f19_arg0.gamemode:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.gamemode)
			f19_arg0.TeamIndicatorLeft:completeAnimation()
			f19_arg0.TeamIndicatorLeft:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TeamIndicatorLeft)
			f19_arg0.TeamIndicatorRight:completeAnimation()
			f19_arg0.TeamIndicatorRight:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TeamIndicatorRight)
			f19_arg0.teamname4:completeAnimation()
			f19_arg0.teamname4:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.teamname4)
			f19_arg0.teamname3:completeAnimation()
			f19_arg0.teamname3:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.teamname3)
		end,
	},
	teamLeftwatch = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(9)
			f20_arg0.TeamBackingAlliedBot:completeAnimation()
			f20_arg0.TeamBackingAlliedBot:setAlpha(0.9)
			f20_arg0.clipFinished(f20_arg0.TeamBackingAlliedBot)
			f20_arg0.TeamBackingAlliedTop:completeAnimation()
			f20_arg0.TeamBackingAlliedTop:setAlpha(0.9)
			f20_arg0.clipFinished(f20_arg0.TeamBackingAlliedTop)
			f20_arg0.TeamBackingAxisBot:completeAnimation()
			f20_arg0.TeamBackingAxisBot:setAlpha(0.5)
			f20_arg0.clipFinished(f20_arg0.TeamBackingAxisBot)
			f20_arg0.TeamBackingAxisTop:completeAnimation()
			f20_arg0.TeamBackingAxisTop:setAlpha(0.5)
			f20_arg0.clipFinished(f20_arg0.TeamBackingAxisTop)
			f20_arg0.teamleft:completeAnimation()
			f20_arg0.clipFinished(f20_arg0.teamleft)
			f20_arg0.teamright:completeAnimation()
			f20_arg0.teamright:setLeftRight(1, 1, -209, -29)
			f20_arg0.clipFinished(f20_arg0.teamright)
			f20_arg0.SelectArrowLeft:completeAnimation()
			f20_arg0.SelectArrowLeft:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.SelectArrowLeft)
			f20_arg0.TeamIndicatorLeft:completeAnimation()
			f20_arg0.TeamIndicatorLeft:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.TeamIndicatorLeft)
			f20_arg0.TeamIndicatorRight:completeAnimation()
			f20_arg0.TeamIndicatorRight:setLeftRight(0, 0, 478, 518)
			f20_arg0.TeamIndicatorRight:setAlpha(0.1)
			f20_arg0.clipFinished(f20_arg0.TeamIndicatorRight)
		end,
	},
	teamRigthwatch = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(9)
			f21_arg0.TeamBackingAlliedBot:completeAnimation()
			f21_arg0.TeamBackingAlliedBot:setAlpha(0.5)
			f21_arg0.clipFinished(f21_arg0.TeamBackingAlliedBot)
			f21_arg0.TeamBackingAlliedTop:completeAnimation()
			f21_arg0.TeamBackingAlliedTop:setAlpha(0.5)
			f21_arg0.clipFinished(f21_arg0.TeamBackingAlliedTop)
			f21_arg0.TeamBackingAxisBot:completeAnimation()
			f21_arg0.TeamBackingAxisBot:setAlpha(0.9)
			f21_arg0.clipFinished(f21_arg0.TeamBackingAxisBot)
			f21_arg0.TeamBackingAxisTop:completeAnimation()
			f21_arg0.TeamBackingAxisTop:setAlpha(0.9)
			f21_arg0.clipFinished(f21_arg0.TeamBackingAxisTop)
			f21_arg0.teamleft:completeAnimation()
			f21_arg0.clipFinished(f21_arg0.teamleft)
			f21_arg0.teamright:completeAnimation()
			f21_arg0.teamright:setLeftRight(1, 1, -209, -29)
			f21_arg0.clipFinished(f21_arg0.teamright)
			f21_arg0.SelectArrowRight:completeAnimation()
			f21_arg0.SelectArrowRight:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.SelectArrowRight)
			f21_arg0.TeamIndicatorLeft:completeAnimation()
			f21_arg0.TeamIndicatorLeft:setAlpha(0.1)
			f21_arg0.clipFinished(f21_arg0.TeamIndicatorLeft)
			f21_arg0.TeamIndicatorRight:completeAnimation()
			f21_arg0.TeamIndicatorRight:setLeftRight(0, 0, 478, 518)
			f21_arg0.TeamIndicatorRight:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.TeamIndicatorRight)
		end,
	},
}
CoD.CodCasterTeamScoreboard.__onClose = function(f22_arg0)
	f22_arg0.TeamBackingAlliedBot:close()
	f22_arg0.TeamBackingAlliedTop:close()
	f22_arg0.TeamBackingAxisBot:close()
	f22_arg0.TeamBackingAxisTop:close()
	f22_arg0.teamleft:close()
	f22_arg0.teamright:close()
	f22_arg0.SelectArrowRight:close()
	f22_arg0.SelectArrowLeft:close()
	f22_arg0.GameTimer:close()
	f22_arg0.gamemode:close()
	f22_arg0.TeamIndicatorLeft:close()
	f22_arg0.TeamIndicatorRight:close()
	f22_arg0.teamname4:close()
	f22_arg0.teamname3:close()
end
