require("x64:b74f01dc35100a0")
require("x64:2b4c41c3979c25d")
require("x64:2c65f12853233d0")
require("x64:282e27740c9d716")
CoD.AARScoreboardHeader = InheritFrom(LUI.UIElement)
CoD.AARScoreboardHeader.__defaultWidth = 1450
CoD.AARScoreboardHeader.__defaultHeight = 170
CoD.AARScoreboardHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARScoreboardHeader)
	self.id = "AARScoreboardHeader"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBG = LUI.UIImage.new(0, 0, 0, 1450, 0, 0, 22, 194)
	BlurBG:setAlpha(0)
	BlurBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBG)
	self.BlurBG = BlurBG
	local TintBodyL = LUI.UIImage.new(0, 0, -1, 725, 0, 0, 18, 194)
	TintBodyL:setImage(RegisterImage(0xFF1F4F6EBBE150))
	self:addElement(TintBodyL)
	self.TintBodyL = TintBodyL
	local TintBodyR = LUI.UIImage.new(0, 0, 1451, 725, 0, 0, 18, 194)
	TintBodyR:setImage(RegisterImage(0xFF1F4F6EBBE150))
	self:addElement(TintBodyR)
	self.TintBodyR = TintBodyR
	local TintBot = LUI.UIImage.new(0, 0, 0, 1450, 0, 0, 185, 194)
	TintBot:setRGB(0, 0, 0)
	TintBot:setAlpha(0.3)
	self:addElement(TintBot)
	self.TintBot = TintBot
	local TintTop = LUI.UIImage.new(0, 0, 0, 1450, 0, 0, 22, 32)
	TintTop:setRGB(0, 0, 0)
	TintTop:setAlpha(0.3)
	self:addElement(TintTop)
	self.TintTop = TintTop
	local EnemyBacking = CoD.TabbedScoreboardHeaderEnemy.new(f1_arg0, f1_arg1, 0, 0, 719, 1459, 0, 0, 77, 210)
	self:addElement(EnemyBacking)
	self.EnemyBacking = EnemyBacking
	local TeamBacking = CoD.TabbedScoreboardHeaderTeam.new(f1_arg0, f1_arg1, 0, 0, -7.5, 732.5, 0, 0, 77, 211)
	self:addElement(TeamBacking)
	self.TeamBacking = TeamBacking
	local YourTeamTopBar = CoD.TabbedScoreboardHeaderTopbar.new(f1_arg0, f1_arg1, 0, 0, 7, 695, 0, 0, 67, 77)
	self:addElement(YourTeamTopBar)
	self.YourTeamTopBar = YourTeamTopBar
	local EnemyTeamTopBar = CoD.TabbedScoreboardHeaderTopbar02.new(f1_arg0, f1_arg1, 0, 0, 757, 1445, 0, 0, 67, 77)
	self:addElement(EnemyTeamTopBar)
	self.EnemyTeamTopBar = EnemyTeamTopBar
	local VS = LUI.UIText.new(0.5, 0.5, -228, 228, 0, 0, 104, 134)
	VS:setRGB(0.91, 0.91, 0.91)
	VS:setAlpha(0.8)
	VS:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_34F347C78B3F5793"))
	VS:setTTF("0arame_mono_stencil")
	VS:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	VS:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(VS)
	self.VS = VS
	local TeamKills = LUI.UIText.new(0, 0, 488.5, 645.5, 0, 0, 89.5, 153.5)
	TeamKills:setTTF("0arame_mono_stencil")
	TeamKills:setLetterSpacing(2)
	TeamKills:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	TeamKills:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	TeamKills:linkToElementModel(self, "teamScore", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamKills:setText(f2_local0)
		end
	end)
	self:addElement(TeamKills)
	self.TeamKills = TeamKills
	local EnemyKills = LUI.UIText.new(0, 0, 800, 953, 0, 0, 90.5, 154.5)
	EnemyKills:setTTF("0arame_mono_stencil")
	EnemyKills:setLetterSpacing(2)
	EnemyKills:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EnemyKills:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	EnemyKills:linkToElementModel(self, "enemyScore", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnemyKills:setText(f3_local0)
		end
	end)
	self:addElement(EnemyKills)
	self.EnemyKills = EnemyKills
	local YourTeamIcon = LUI.UIImage.new(0, 0, 36, 116, 0, 0, 79.5, 159.5)
	YourTeamIcon:linkToElementModel(self, "teamIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			YourTeamIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(YourTeamIcon)
	self.YourTeamIcon = YourTeamIcon
	local EnemyIcon = LUI.UIImage.new(0, 0, 1334, 1414, 0, 0, 79.5, 159.5)
	EnemyIcon:linkToElementModel(self, "enemyIcon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EnemyIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(EnemyIcon)
	self.EnemyIcon = EnemyIcon
	local YourTeamLine = LUI.UIImage.new(0.5, 0.5, -717, -33, 0, 0, 162, 168)
	YourTeamLine:setAlpha(0)
	YourTeamLine:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveFriendlyColor", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			YourTeamLine:setRGB(f6_local0)
		end
	end)
	self:addElement(YourTeamLine)
	self.YourTeamLine = YourTeamLine
	local EnemyTeamLine = LUI.UIImage.new(0.5, 0.5, 33, 717, 0, 0, 162, 168)
	EnemyTeamLine:setAlpha(0)
	EnemyTeamLine:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			EnemyTeamLine:setRGB(f7_local0)
		end
	end)
	self:addElement(EnemyTeamLine)
	self.EnemyTeamLine = EnemyTeamLine
	local MapText = LUI.UIText.new(0.5, 0.5, -228, 228, 0, 0, 43, 68)
	MapText:setRGB(0.7, 0.7, 0.7)
	MapText:setTTF("ttmussels_regular")
	MapText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MapText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	MapText:subscribeToGlobalModel(f1_arg1, "AARRoot", "mapName", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			MapText:setText(MapNameToLocalizedMapName(f8_local0))
		end
	end)
	self:addElement(MapText)
	self.MapText = MapText
	local GameType = LUI.UIText.new(0, 0, 15, 455, 0, 0, 43, 68)
	GameType:setRGB(0.7, 0.7, 0.7)
	GameType:setTTF("ttmussels_regular")
	GameType:setLetterSpacing(2)
	GameType:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameType:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	GameType:subscribeToGlobalModel(f1_arg1, "AARRoot", "gametype", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			GameType:setText(GameTypeToLocalizedGameType(f9_local0))
		end
	end)
	self:addElement(GameType)
	self.GameType = GameType
	local CodCasterTeam2Name = LUI.UIText.new(0, 0, 1121, 1321, 0, 0, 111, 136)
	CodCasterTeam2Name:setAlpha(0)
	CodCasterTeam2Name:setTTF("notosans_bold")
	CodCasterTeam2Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	CodCasterTeam2Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CodCasterTeam2Name:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionDisplayName", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CodCasterTeam2Name:setText(f10_local0)
		end
	end)
	self:addElement(CodCasterTeam2Name)
	self.CodCasterTeam2Name = CodCasterTeam2Name
	local CodCasterTeam1Name = LUI.UIText.new(0, 0, 129, 329, 0, 0, 109, 134)
	CodCasterTeam1Name:setAlpha(0)
	CodCasterTeam1Name:setTTF("notosans_bold")
	CodCasterTeam1Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CodCasterTeam1Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CodCasterTeam1Name:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "alliesFactionDisplayName", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CodCasterTeam1Name:setText(f11_local0)
		end
	end)
	self:addElement(CodCasterTeam1Name)
	self.CodCasterTeam1Name = CodCasterTeam1Name
	self:mergeStateConditions({
		{
			stateName = "FFAType",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeTeamFFA(f1_arg1)
			end,
		},
		{
			stateName = "CodCaster",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsCodCasterOrAssigned(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARScoreboardHeader.__resetProperties = function(f14_arg0)
	f14_arg0.EnemyTeamLine:completeAnimation()
	f14_arg0.YourTeamLine:completeAnimation()
	f14_arg0.EnemyIcon:completeAnimation()
	f14_arg0.YourTeamIcon:completeAnimation()
	f14_arg0.EnemyKills:completeAnimation()
	f14_arg0.TeamKills:completeAnimation()
	f14_arg0.VS:completeAnimation()
	f14_arg0.TintBodyR:completeAnimation()
	f14_arg0.TintBodyL:completeAnimation()
	f14_arg0.BlurBG:completeAnimation()
	f14_arg0.TeamBacking:completeAnimation()
	f14_arg0.EnemyBacking:completeAnimation()
	f14_arg0.TintBot:completeAnimation()
	f14_arg0.CodCasterTeam2Name:completeAnimation()
	f14_arg0.CodCasterTeam1Name:completeAnimation()
	f14_arg0.EnemyTeamLine:setAlpha(0)
	f14_arg0.YourTeamLine:setAlpha(0)
	f14_arg0.EnemyIcon:setAlpha(1)
	f14_arg0.YourTeamIcon:setAlpha(1)
	f14_arg0.EnemyKills:setAlpha(1)
	f14_arg0.TeamKills:setAlpha(1)
	f14_arg0.VS:setAlpha(0.8)
	f14_arg0.TintBodyR:setTopBottom(0, 0, 18, 194)
	f14_arg0.TintBodyR:setAlpha(1)
	f14_arg0.TintBodyL:setTopBottom(0, 0, 18, 194)
	f14_arg0.TintBodyL:setAlpha(1)
	f14_arg0.BlurBG:setTopBottom(0, 0, 22, 194)
	f14_arg0.BlurBG:setAlpha(0)
	f14_arg0.TeamBacking:setAlpha(1)
	f14_arg0.EnemyBacking:setAlpha(1)
	f14_arg0.TintBot:setAlpha(0.3)
	f14_arg0.CodCasterTeam2Name:setLeftRight(0, 0, 1121, 1321)
	f14_arg0.CodCasterTeam2Name:setAlpha(0)
	f14_arg0.CodCasterTeam1Name:setLeftRight(0, 0, 129, 329)
	f14_arg0.CodCasterTeam1Name:setAlpha(0)
end
CoD.AARScoreboardHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	FFAType = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(13)
			f16_arg0.BlurBG:completeAnimation()
			f16_arg0.BlurBG:setTopBottom(0, 0, 22, 106)
			f16_arg0.BlurBG:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BlurBG)
			f16_arg0.TintBodyL:completeAnimation()
			f16_arg0.TintBodyL:setTopBottom(0, 0, 18, 101)
			f16_arg0.TintBodyL:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TintBodyL)
			f16_arg0.TintBodyR:completeAnimation()
			f16_arg0.TintBodyR:setTopBottom(0, 0, 18, 101)
			f16_arg0.TintBodyR:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TintBodyR)
			f16_arg0.TintBot:completeAnimation()
			f16_arg0.TintBot:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TintBot)
			f16_arg0.EnemyBacking:completeAnimation()
			f16_arg0.EnemyBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EnemyBacking)
			f16_arg0.TeamBacking:completeAnimation()
			f16_arg0.TeamBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamBacking)
			f16_arg0.VS:completeAnimation()
			f16_arg0.VS:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.VS)
			f16_arg0.TeamKills:completeAnimation()
			f16_arg0.TeamKills:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamKills)
			f16_arg0.EnemyKills:completeAnimation()
			f16_arg0.EnemyKills:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EnemyKills)
			f16_arg0.YourTeamIcon:completeAnimation()
			f16_arg0.YourTeamIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.YourTeamIcon)
			f16_arg0.EnemyIcon:completeAnimation()
			f16_arg0.EnemyIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EnemyIcon)
			f16_arg0.YourTeamLine:completeAnimation()
			f16_arg0.YourTeamLine:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.YourTeamLine)
			f16_arg0.EnemyTeamLine:completeAnimation()
			f16_arg0.EnemyTeamLine:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EnemyTeamLine)
		end,
	},
	CodCaster = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.CodCasterTeam2Name:completeAnimation()
			f17_arg0.CodCasterTeam2Name:setLeftRight(0, 0, 921, 1321)
			f17_arg0.CodCasterTeam2Name:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CodCasterTeam2Name)
			f17_arg0.CodCasterTeam1Name:completeAnimation()
			f17_arg0.CodCasterTeam1Name:setLeftRight(0, 0, 129, 529)
			f17_arg0.CodCasterTeam1Name:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CodCasterTeam1Name)
		end,
	},
}
CoD.AARScoreboardHeader.__onClose = function(f18_arg0)
	f18_arg0.EnemyBacking:close()
	f18_arg0.TeamBacking:close()
	f18_arg0.YourTeamTopBar:close()
	f18_arg0.EnemyTeamTopBar:close()
	f18_arg0.TeamKills:close()
	f18_arg0.EnemyKills:close()
	f18_arg0.YourTeamIcon:close()
	f18_arg0.EnemyIcon:close()
	f18_arg0.YourTeamLine:close()
	f18_arg0.EnemyTeamLine:close()
	f18_arg0.MapText:close()
	f18_arg0.GameType:close()
	f18_arg0.CodCasterTeam2Name:close()
	f18_arg0.CodCasterTeam1Name:close()
end
