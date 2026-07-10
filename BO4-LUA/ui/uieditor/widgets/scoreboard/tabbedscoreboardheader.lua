require("x64:b74f01dc35100a0")
require("x64:86de590d97533bf")
require("x64:2b4c41c3979c25d")
require("x64:88c4c902e95d92a")
require("x64:2c65f12853233d0")
require("x64:282e27740c9d716")
CoD.TabbedScoreboardHeader = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeader.__defaultWidth = 1450
CoD.TabbedScoreboardHeader.__defaultHeight = 170
CoD.TabbedScoreboardHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardHeader)
	self.id = "TabbedScoreboardHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBG = LUI.UIImage.new(0, 0, 0, 1450, 0, 0, 0, 187)
	BlurBG:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBG)
	self.BlurBG = BlurBG
	local TintBot = LUI.UIImage.new(0, 0, 0, 1450, 0, 0, 178, 187)
	TintBot:setRGB(0, 0, 0)
	TintBot:setAlpha(0.3)
	self:addElement(TintBot)
	self.TintBot = TintBot
	local TintBody = LUI.UIImage.new(0, 0, -1, 1451, 0, 0, 0, 188)
	TintBody:setRGB(0.87, 0.87, 0.87)
	TintBody:setAlpha(0.9)
	TintBody:setImage(RegisterImage(0xFB1318D1BC9DC08))
	self:addElement(TintBody)
	self.TintBody = TintBody
	local TintTop = LUI.UIImage.new(0, 0, 0, 1450, 0, 0, 0, 30)
	TintTop:setRGB(0, 0, 0)
	TintTop:setAlpha(0.3)
	self:addElement(TintTop)
	self.TintTop = TintTop
	local EnemyBacking = CoD.TabbedScoreboardHeaderEnemy.new(f1_arg0, f1_arg1, 0, 0, 718, 1458, 0, 0, 79, 212)
	self:addElement(EnemyBacking)
	self.EnemyBacking = EnemyBacking
	local TeamBacking = CoD.TabbedScoreboardHeaderTeam.new(f1_arg0, f1_arg1, 0, 0, -7.5, 732.5, 0, 0, 79, 213)
	self:addElement(TeamBacking)
	self.TeamBacking = TeamBacking
	local YourTeamTopBar = CoD.TabbedScoreboardHeaderTopbar.new(f1_arg0, f1_arg1, 0, 0, 7, 695, 0, 0, 69, 79)
	self:addElement(YourTeamTopBar)
	self.YourTeamTopBar = YourTeamTopBar
	local EnemyTeamTopBar = CoD.TabbedScoreboardHeaderTopbar02.new(f1_arg0, f1_arg1, 0, 0, 757, 1445, 0, 0, 69, 79)
	self:addElement(EnemyTeamTopBar)
	self.EnemyTeamTopBar = EnemyTeamTopBar
	local EnemyTeamLine = LUI.UIImage.new(0.5, 0.5, 33, 717, 0, 0, 164, 170)
	EnemyTeamLine:setAlpha(0)
	EnemyTeamLine:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnemyTeamLine:setRGB(f2_local0)
		end
	end)
	self:addElement(EnemyTeamLine)
	self.EnemyTeamLine = EnemyTeamLine
	local YourTeamLine = LUI.UIImage.new(0.5, 0.5, -717, -33, 0, 0, 164, 170)
	YourTeamLine:setAlpha(0)
	YourTeamLine:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			YourTeamLine:setRGB(f3_local0)
		end
	end)
	self:addElement(YourTeamLine)
	self.YourTeamLine = YourTeamLine
	local GameTimer00 = LUI.UIText.new(0.5, 0.5, 644, 729, 0, 0, 45, 70)
	GameTimer00:setRGB(0.7, 0.7, 0.7)
	GameTimer00:setTTF("ttmussels_regular")
	GameTimer00:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	GameTimer00:setLetterSpacing(2)
	GameTimer00:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GameTimer00:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GameTimer00:subscribeToGlobalModel(f1_arg1, "GameScore", "gameTimeEnd", function(model)
		if model:get() ~= nil then
			GameTimer00:setupGameTimer()
		end
	end)
	self:addElement(GameTimer00)
	self.GameTimer00 = GameTimer00
	local EnemyIcon = LUI.UIImage.new(0, 0, 1334, 1414, 0, 0, 81.5, 161.5)
	EnemyIcon:subscribeToGlobalModel(f1_arg1, "Factions", "enemyFactionIcon", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EnemyIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(EnemyIcon)
	self.EnemyIcon = EnemyIcon
	local CodcasterTeam2Logo = LUI.UIImage.new(0, 0, 1334, 1414, 0, 0, 81.5, 161.5)
	CodcasterTeam2Logo:setAlpha(0)
	CodcasterTeam2Logo:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionIcon", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CodcasterTeam2Logo:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(CodcasterTeam2Logo)
	self.CodcasterTeam2Logo = CodcasterTeam2Logo
	local YourTeamIcon = LUI.UIImage.new(0, 0, 36, 116, 0, 0, 81.5, 161.5)
	YourTeamIcon:subscribeToGlobalModel(f1_arg1, "Factions", "playerFactionIcon", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			YourTeamIcon:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(YourTeamIcon)
	self.YourTeamIcon = YourTeamIcon
	local CodcasterTeam1Logo = LUI.UIImage.new(0, 0, 36, 116, 0, 0, 81.5, 161.5)
	CodcasterTeam1Logo:setAlpha(0)
	CodcasterTeam1Logo:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionIcon", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CodcasterTeam1Logo:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(CodcasterTeam1Logo)
	self.CodcasterTeam1Logo = CodcasterTeam1Logo
	local VS = LUI.UIText.new(0.5, 0.5, -227, 229, 0, 0, 109, 139)
	VS:setRGB(0.91, 0.91, 0.91)
	VS:setAlpha(0.8)
	VS:setText(Engine[0xF9F1239CFD921FE](0x4F347C78B3F5793))
	VS:setTTF("0arame_mono_stencil")
	VS:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	VS:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(VS)
	self.VS = VS
	local GameTypeText = LUI.UIText.new(0, 0, 17, 341, 0, 0, 33.5, 45.5)
	GameTypeText:setRGB(0.7, 0.7, 0.7)
	GameTypeText:setAlpha(0.3)
	GameTypeText:setText(Engine[0xF9F1239CFD921FE](0x7F09D9C7D9A3FEE))
	GameTypeText:setTTF("dinnext_regular")
	GameTypeText:setLetterSpacing(2)
	GameTypeText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GameTypeText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(GameTypeText)
	self.GameTypeText = GameTypeText
	local TimeText = LUI.UIText.new(0, 0, 1350, 1435, 0, 0, 33.5, 45.5)
	TimeText:setRGB(0.7, 0.7, 0.7)
	TimeText:setAlpha(0.3)
	TimeText:setText(Engine[0xF9F1239CFD921FE](0xA4424A69B99B9E5))
	TimeText:setTTF("dinnext_regular")
	TimeText:setLetterSpacing(2)
	TimeText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TimeText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(TimeText)
	self.TimeText = TimeText
	local TabbedScoreboardHeaderScores = CoD.TabbedScoreboardHeaderScores.new(f1_arg0, f1_arg1, 0.5, 0.5, -217.5, 217.5, 0, 0, 91, 160)
	self:addElement(TabbedScoreboardHeaderScores)
	self.TabbedScoreboardHeaderScores = TabbedScoreboardHeaderScores
	local GameType = CoD.TabbedScoreboardHeaderTitle.new(f1_arg0, f1_arg1, 0, 0, 15, 953, 0, 0, 45, 70)
	self:addElement(GameType)
	self.GameType = GameType
	local CodCasterTeam1Name = LUI.UIText.new(0, 0, 129, 329, 0, 0, 109, 134)
	CodCasterTeam1Name:setAlpha(0)
	CodCasterTeam1Name:setTTF("notosans_bold")
	CodCasterTeam1Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CodCasterTeam1Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CodCasterTeam1Name:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "alliesFactionDisplayName", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CodCasterTeam1Name:setText(f9_local0)
		end
	end)
	self:addElement(CodCasterTeam1Name)
	self.CodCasterTeam1Name = CodCasterTeam1Name
	local CodCasterTeam2Name = LUI.UIText.new(0, 0, 1121, 1321, 0, 0, 111, 136)
	CodCasterTeam2Name:setAlpha(0)
	CodCasterTeam2Name:setTTF("notosans_bold")
	CodCasterTeam2Name:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	CodCasterTeam2Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CodCasterTeam2Name:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionDisplayName", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CodCasterTeam2Name:setText(f10_local0)
		end
	end)
	self:addElement(CodCasterTeam2Name)
	self.CodCasterTeam2Name = CodCasterTeam2Name
	self:mergeStateConditions({
		{
			stateName = "FFAType",
			condition = function(menu, element, event)
				return not IsGametypeTeambased()
			end,
		},
		{
			stateName = "Codcaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local23 = self
	local f1_local24 = self.subscribeToModel
	local f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local24(f1_local23, f1_local25["factions.isCoDCaster"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	TabbedScoreboardHeaderScores.id = "TabbedScoreboardHeaderScores"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeader.__resetProperties = function(f14_arg0)
	f14_arg0.CodCasterTeam2Name:completeAnimation()
	f14_arg0.CodCasterTeam1Name:completeAnimation()
	f14_arg0.TabbedScoreboardHeaderScores:completeAnimation()
	f14_arg0.VS:completeAnimation()
	f14_arg0.CodcasterTeam1Logo:completeAnimation()
	f14_arg0.YourTeamIcon:completeAnimation()
	f14_arg0.CodcasterTeam2Logo:completeAnimation()
	f14_arg0.EnemyIcon:completeAnimation()
	f14_arg0.YourTeamLine:completeAnimation()
	f14_arg0.EnemyTeamLine:completeAnimation()
	f14_arg0.TeamBacking:completeAnimation()
	f14_arg0.EnemyBacking:completeAnimation()
	f14_arg0.TintBot:completeAnimation()
	f14_arg0.BlurBG:completeAnimation()
	f14_arg0.CodCasterTeam2Name:setLeftRight(0, 0, 1121, 1321)
	f14_arg0.CodCasterTeam2Name:setAlpha(0)
	f14_arg0.CodCasterTeam2Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	f14_arg0.CodCasterTeam1Name:setLeftRight(0, 0, 129, 329)
	f14_arg0.CodCasterTeam1Name:setAlpha(0)
	f14_arg0.CodCasterTeam1Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	f14_arg0.TabbedScoreboardHeaderScores:setAlpha(1)
	f14_arg0.VS:setAlpha(0.8)
	f14_arg0.CodcasterTeam1Logo:setAlpha(0)
	f14_arg0.YourTeamIcon:setAlpha(1)
	f14_arg0.CodcasterTeam2Logo:setAlpha(0)
	f14_arg0.EnemyIcon:setAlpha(1)
	f14_arg0.YourTeamLine:setAlpha(0)
	f14_arg0.EnemyTeamLine:setAlpha(0)
	f14_arg0.TeamBacking:setAlpha(1)
	f14_arg0.EnemyBacking:setAlpha(1)
	f14_arg0.TintBot:setAlpha(0.3)
	f14_arg0.BlurBG:setTopBottom(0, 0, 0, 187)
end
CoD.TabbedScoreboardHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	FFAType = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(14)
			f16_arg0.BlurBG:completeAnimation()
			f16_arg0.BlurBG:setTopBottom(0, 0, 0, 170)
			f16_arg0.clipFinished(f16_arg0.BlurBG)
			f16_arg0.TintBot:completeAnimation()
			f16_arg0.TintBot:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TintBot)
			f16_arg0.EnemyBacking:completeAnimation()
			f16_arg0.EnemyBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EnemyBacking)
			f16_arg0.TeamBacking:completeAnimation()
			f16_arg0.TeamBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamBacking)
			f16_arg0.EnemyTeamLine:completeAnimation()
			f16_arg0.EnemyTeamLine:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EnemyTeamLine)
			f16_arg0.YourTeamLine:completeAnimation()
			f16_arg0.YourTeamLine:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.YourTeamLine)
			f16_arg0.EnemyIcon:completeAnimation()
			f16_arg0.EnemyIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EnemyIcon)
			f16_arg0.CodcasterTeam2Logo:completeAnimation()
			f16_arg0.CodcasterTeam2Logo:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CodcasterTeam2Logo)
			f16_arg0.YourTeamIcon:completeAnimation()
			f16_arg0.YourTeamIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.YourTeamIcon)
			f16_arg0.CodcasterTeam1Logo:completeAnimation()
			f16_arg0.CodcasterTeam1Logo:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CodcasterTeam1Logo)
			f16_arg0.VS:completeAnimation()
			f16_arg0.VS:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.VS)
			f16_arg0.TabbedScoreboardHeaderScores:completeAnimation()
			f16_arg0.TabbedScoreboardHeaderScores:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TabbedScoreboardHeaderScores)
			f16_arg0.CodCasterTeam1Name:completeAnimation()
			f16_arg0.CodCasterTeam1Name:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CodCasterTeam1Name)
			f16_arg0.CodCasterTeam2Name:completeAnimation()
			f16_arg0.CodCasterTeam2Name:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CodCasterTeam2Name)
		end,
	},
	Codcaster = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(6)
			f17_arg0.EnemyIcon:completeAnimation()
			f17_arg0.EnemyIcon:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.EnemyIcon)
			f17_arg0.CodcasterTeam2Logo:completeAnimation()
			f17_arg0.CodcasterTeam2Logo:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CodcasterTeam2Logo)
			f17_arg0.YourTeamIcon:completeAnimation()
			f17_arg0.YourTeamIcon:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.YourTeamIcon)
			f17_arg0.CodcasterTeam1Logo:completeAnimation()
			f17_arg0.CodcasterTeam1Logo:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CodcasterTeam1Logo)
			f17_arg0.CodCasterTeam1Name:completeAnimation()
			f17_arg0.CodCasterTeam1Name:setLeftRight(0, 0, 129, 429)
			f17_arg0.CodCasterTeam1Name:setAlpha(1)
			f17_arg0.CodCasterTeam1Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
			f17_arg0.clipFinished(f17_arg0.CodCasterTeam1Name)
			f17_arg0.CodCasterTeam2Name:completeAnimation()
			f17_arg0.CodCasterTeam2Name:setLeftRight(0, 0, 1021, 1321)
			f17_arg0.CodCasterTeam2Name:setAlpha(1)
			f17_arg0.CodCasterTeam2Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
			f17_arg0.clipFinished(f17_arg0.CodCasterTeam2Name)
		end,
	},
}
CoD.TabbedScoreboardHeader.__onClose = function(f18_arg0)
	f18_arg0.EnemyBacking:close()
	f18_arg0.TeamBacking:close()
	f18_arg0.YourTeamTopBar:close()
	f18_arg0.EnemyTeamTopBar:close()
	f18_arg0.EnemyTeamLine:close()
	f18_arg0.YourTeamLine:close()
	f18_arg0.GameTimer00:close()
	f18_arg0.EnemyIcon:close()
	f18_arg0.CodcasterTeam2Logo:close()
	f18_arg0.YourTeamIcon:close()
	f18_arg0.CodcasterTeam1Logo:close()
	f18_arg0.TabbedScoreboardHeaderScores:close()
	f18_arg0.GameType:close()
	f18_arg0.CodCasterTeam1Name:close()
	f18_arg0.CodCasterTeam2Name:close()
end
