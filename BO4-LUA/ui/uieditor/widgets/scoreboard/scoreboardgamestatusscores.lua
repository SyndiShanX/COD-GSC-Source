require("x64:6ffd43c6428a70a")
require("x64:790ed847e916d0e")
require("x64:c9b5bc029376445")
require("x64:fe3b1e339207b75")
require("x64:40b97e13c45b9cb")
CoD.ScoreboardGameStatusScores = InheritFrom(LUI.UIElement)
CoD.ScoreboardGameStatusScores.__defaultWidth = 1920
CoD.ScoreboardGameStatusScores.__defaultHeight = 200
CoD.ScoreboardGameStatusScores.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardGameStatusScores)
	self.id = "ScoreboardGameStatusScores"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.ScoreboardGameStatusScoresBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -150.5, -0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local SpecialistImage = LUI.UIFixedAspectRatioImage.new(0, 0, 242, 475, 0, 0, -44, 161)
	SpecialistImage:linkToElementModel(self, "scoreboard.characterIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpecialistImage:setImage(RegisterImage(GetPositionDraftIconByIndex(f2_local0)))
		end
	end)
	self:addElement(SpecialistImage)
	self.SpecialistImage = SpecialistImage
	local LightBarHero = LUI.UIImage.new(0, 0, 500, 6500, 0, 0, 161, 169)
	LightBarHero:setRGB(0.95, 0.95, 0.95)
	LightBarHero:setAlpha(0.12)
	self:addElement(LightBarHero)
	self.LightBarHero = LightBarHero
	local stripeHero = LUI.UIImage.new(0.5, 0.5, -6460, -460, 0, 0, 161, 169)
	stripeHero:setAlpha(0.5)
	stripeHero:setImage(RegisterImage(@"hash_287FBA6ED8287E8B"))
	stripeHero:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6E9593DF28749F2"))
	stripeHero:setShaderVector(0, 12.82, 1, 0, 0)
	stripeHero:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(stripeHero)
	self.stripeHero = stripeHero
	local GameTypeStat4 = CoD.ScoreboardGameTypeSpecificStat.new(f1_arg0, f1_arg1, 0, 0, 1055.5, 1149.5, 0, 0, 96.5, 117.5)
	GameTypeStat4:setAlpha(0)
	GameTypeStat4.StatName:setText(GetScoreboardColumnHeader(f1_arg1, 1, "Score"))
	GameTypeStat4:linkToElementModel(self, "scoreboard.col2", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GameTypeStat4.StatValue:setText(f3_local0)
		end
	end)
	self:addElement(GameTypeStat4)
	self.GameTypeStat4 = GameTypeStat4
	local GameTypeStat3 = CoD.ScoreboardGameTypeSpecificStat.new(f1_arg0, f1_arg1, 0, 0, 1055.5, 1149.5, 0, 0, 124, 145)
	GameTypeStat3.StatName:setText(GetScoreboardColumnHeader(f1_arg1, 5, "Score"))
	GameTypeStat3:linkToElementModel(self, "scoreboard.footer3", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GameTypeStat3.StatValue:setText(f4_local0)
		end
	end)
	self:addElement(GameTypeStat3)
	self.GameTypeStat3 = GameTypeStat3
	local GameTypeStat2 = CoD.ScoreboardGameTypeSpecificStat.new(f1_arg0, f1_arg1, 0, 0, 1055.5, 1149.5, 0, 0, 99.5, 120.5)
	GameTypeStat2.StatName:setText(GetScoreboardColumnHeader(f1_arg1, 4, "Score"))
	GameTypeStat2:linkToElementModel(self, "scoreboard.footer2", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GameTypeStat2.StatValue:setText(f5_local0)
		end
	end)
	self:addElement(GameTypeStat2)
	self.GameTypeStat2 = GameTypeStat2
	local GameTypeStat1 = CoD.ScoreboardGameTypeSpecificStat.new(f1_arg0, f1_arg1, 0, 0, 1055.5, 1149.5, 0, 0, 75.5, 96.5)
	GameTypeStat1.StatName:setText(GetScoreboardColumnHeader(f1_arg1, 3, "Score"))
	GameTypeStat1:linkToElementModel(self, "scoreboard.footer1", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			GameTypeStat1.StatValue:setText(f6_local0)
		end
	end)
	self:addElement(GameTypeStat1)
	self.GameTypeStat1 = GameTypeStat1
	local CoreStat2 = CoD.ScoreboardCoreStat.new(f1_arg0, f1_arg1, 0, 0, 664.5, 740.5, 0, 0, 76.5, 127.5)
	CoreStat2.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5297A0D6FB981600"))
	CoreStat2:linkToElementModel(self, "scoreboard.deaths", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CoreStat2.StatValue:setText(f7_local0)
		end
	end)
	self:addElement(CoreStat2)
	self.CoreStat2 = CoreStat2
	local CoreStat1 = CoD.ScoreboardCoreStat.new(f1_arg0, f1_arg1, 0, 0, 558.5, 634.5, 0, 0, 76.5, 127.5)
	CoreStat1.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mpui/ekia"))
	CoreStat1:linkToElementModel(self, "scoreboard.ekia", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CoreStat1.StatValue:setText(f8_local0)
		end
	end)
	self:addElement(CoreStat1)
	self.CoreStat1 = CoreStat1
	local StatValue = LUI.UIText.new(0, 0, 866.5, 942.5, 0.5, 0.5, 2, 41)
	StatValue:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	StatValue:setAlpha(0.7)
	StatValue:setTTF("0arame_mono_stencil")
	StatValue:setLetterSpacing(2)
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatValue:setBackingType(2)
	StatValue:setBackingColor(0.05, 0.05, 0.05)
	StatValue:setBackingAlpha(0.6)
	StatValue:setBackingXPadding(16)
	StatValue:setBackingYPadding(3)
	StatValue:linkToElementModel(self, "scoreboard.col2", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			StatValue:setText(f9_local0)
		end
	end)
	self:addElement(StatValue)
	self.StatValue = StatValue
	local StatValueSas = LUI.UIText.new(0, 0, 866.5, 942.5, 0.5, 0.5, 2, 41)
	StatValueSas:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	StatValueSas:setAlpha(0)
	StatValueSas:setTTF("0arame_mono_stencil")
	StatValueSas:setLetterSpacing(2)
	StatValueSas:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatValueSas:setBackingType(2)
	StatValueSas:setBackingColor(0.05, 0.05, 0.05)
	StatValueSas:setBackingAlpha(0.6)
	StatValueSas:setBackingXPadding(16)
	StatValueSas:setBackingYPadding(3)
	StatValueSas:linkToElementModel(self, "scoreboard.footer4", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			StatValueSas:setText(f10_local0)
		end
	end)
	self:addElement(StatValueSas)
	self.StatValueSas = StatValueSas
	local StatValueBounty = LUI.UIText.new(0, 0, 866.5, 942.5, 0.5, 0.5, 2, 41)
	StatValueBounty:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	StatValueBounty:setAlpha(0)
	StatValueBounty:setTTF("0arame_mono_stencil")
	StatValueBounty:setLetterSpacing(2)
	StatValueBounty:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatValueBounty:setBackingType(2)
	StatValueBounty:setBackingColor(0.05, 0.05, 0.05)
	StatValueBounty:setBackingAlpha(0.6)
	StatValueBounty:setBackingXPadding(16)
	StatValueBounty:setBackingYPadding(3)
	StatValueBounty:linkToElementModel(self, "scoreboard.col3", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			StatValueBounty:setText(f11_local0)
		end
	end)
	self:addElement(StatValueBounty)
	self.StatValueBounty = StatValueBounty
	local StatValueHardpoint = LUI.UIText.new(0, 0, 866.5, 942.5, 0.5, 0.5, 2, 41)
	StatValueHardpoint:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	StatValueHardpoint:setAlpha(0)
	StatValueHardpoint:setTTF("0arame_mono_stencil")
	StatValueHardpoint:setLetterSpacing(2)
	StatValueHardpoint:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatValueHardpoint:setBackingType(2)
	StatValueHardpoint:setBackingColor(0.05, 0.05, 0.05)
	StatValueHardpoint:setBackingAlpha(0.6)
	StatValueHardpoint:setBackingXPadding(16)
	StatValueHardpoint:setBackingYPadding(3)
	StatValueHardpoint:linkToElementModel(self, "scoreboard.footer1", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			StatValueHardpoint:setText(f12_local0)
		end
	end)
	self:addElement(StatValueHardpoint)
	self.StatValueHardpoint = StatValueHardpoint
	local StatName = LUI.UIText.new(0, 0, 866.5, 942.5, 0, 0, 76.5, 97.5)
	StatName:setRGB(0.92, 0.89, 0.72)
	StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_24478A903275510A"))
	StatName:setTTF("ttmussels_regular")
	StatName:setLetterSpacing(2)
	StatName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(StatName)
	self.StatName = StatName
	local SpecialistName = LUI.UIText.new(0, 0, 243, 443, 0, 0, 95, 116)
	SpecialistName:setTTF("ttmussels_demibold")
	SpecialistName:setLetterSpacing(2)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SpecialistName:setBackingType(2)
	SpecialistName:setBackingColor(0, 0, 0)
	SpecialistName:setBackingAlpha(0.9)
	SpecialistName:setBackingXPadding(8)
	SpecialistName:setBackingYPadding(3)
	SpecialistName:linkToElementModel(self, "scoreboard.characterIndex", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			SpecialistName:setText(Engine[@"hash_4F9F1239CFD921FE"](GetCharacterDisplayNameByIndex(f13_local0)))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local PipRT = LUI.UIImage.new(0.5, 0.5, 920, 936, 0, 0, 77.5, 93.5)
	PipRT:setScale(2, 2)
	PipRT:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	PipRT:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipRT)
	self.PipRT = PipRT
	local PipLT = LUI.UIImage.new(0.5, 0.5, -940, -924, 0, 0, 77.5, 93.5)
	PipLT:setZRot(90)
	PipLT:setScale(2, 2)
	PipLT:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	PipLT:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipLT)
	self.PipLT = PipLT
	local ScoreboardButtonPrompts = CoD.ScoreboardButtonPrompts.new(f1_arg0, f1_arg1, 0, 0, 1624, 1880, 0, 0, 65.5, 154.5)
	ScoreboardButtonPrompts:setScale(0.75, 0.75)
	ScoreboardButtonPrompts:linkToElementModel(self, nil, false, function(model)
		ScoreboardButtonPrompts:setModel(model, f1_arg1)
	end)
	self:addElement(ScoreboardButtonPrompts)
	self.ScoreboardButtonPrompts = ScoreboardButtonPrompts
	local PlayerName = CoD.ScoreboardGameStatusPlayerName.new(f1_arg0, f1_arg1, 0, 0, 241, 493, 0, 0, 124.5, 157.5)
	PlayerName:linkToElementModel(self, nil, false, function(model)
		PlayerName:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local InfoDivider1 = LUI.UIImage.new(0, 0, 498, 502, 0, 0, 64, 156)
	InfoDivider1:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_divider"))
	InfoDivider1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoDivider1)
	self.InfoDivider1 = InfoDivider1
	local InfoDivider3 = LUI.UIImage.new(0, 0, 1003, 1007, 0, 0, 64, 156)
	InfoDivider3:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_divider"))
	InfoDivider3:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoDivider3)
	self.InfoDivider3 = InfoDivider3
	local InfoDivider2 = LUI.UIImage.new(0, 0, 801, 805, 0, 0, 64, 156)
	InfoDivider2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_divider"))
	InfoDivider2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoDivider2)
	self.InfoDivider2 = InfoDivider2
	self:mergeStateConditions({
		{
			stateName = "HiddenByEvent",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "NoPlayers",
			condition = function(menu, element, event)
				local f17_local0 = IsCodCaster(f1_arg1)
				if f17_local0 then
					f17_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("scoreboard.team1.count", 0)
					if f17_local0 then
						f17_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("scoreboard.team2.count", 0)
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "NoPlayersAAR",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self, f1_arg1, "scoreboard.characterIndex")
			end,
		},
		{
			stateName = "TDM",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("tdm")
			end,
		},
		{
			stateName = "Dom",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("dom")
			end,
		},
		{
			stateName = "Control",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("control")
			end,
		},
		{
			stateName = "Hardpoint",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("koth")
			end,
		},
		{
			stateName = "SearchDestroy",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("sd")
			end,
		},
		{
			stateName = "Bounty",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("bounty")
			end,
		},
		{
			stateName = "FFA",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("dm")
			end,
		},
		{
			stateName = "Gun",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("gun")
			end,
		},
		{
			stateName = "Escort",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("escort")
			end,
		},
		{
			stateName = "OneintheChamber",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("oic")
			end,
		},
		{
			stateName = "SticksAndStones",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("sas")
			end,
		},
		{
			stateName = "Clean",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("clean")
			end,
		},
		{
			stateName = "Infect",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("infect")
			end,
		},
		{
			stateName = "SurvivorsVsZombies",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("svz")
			end,
		},
	})
	local f1_local24 = self
	local f1_local25 = self.subscribeToModel
	local f1_local26 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local25(f1_local24, f1_local26["factions.isCoDCaster"], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getglobalmodel"]()
	f1_local25(f1_local24, f1_local26["scoreboard.team1.count"], function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getglobalmodel"]()
	f1_local25(f1_local24, f1_local26["scoreboard.team2.count"], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	self:linkToElementModel(self, "scoreboard.characterIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "scoreboard.characterIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f37_arg2, f37_arg3, f37_arg4)
		if IsSelfInState(self, "HiddenByEvent") then
			HideWidget(self)
		elseif IsInGame() then
			ShowWidget(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local25 = self
	f1_local25 = Backing
	if IsPC() then
		SizeToWidthOfScreen(f1_local25, f1_arg1)
	end
	return self
end
CoD.ScoreboardGameStatusScores.__resetProperties = function(f38_arg0, f38_arg1)
	f38_arg0.SpecialistImage:completeAnimation()
	f38_arg0.InfoDivider2:completeAnimation()
	f38_arg0.InfoDivider3:completeAnimation()
	f38_arg0.InfoDivider1:completeAnimation()
	f38_arg0.PlayerName:completeAnimation()
	f38_arg0.ScoreboardButtonPrompts:completeAnimation()
	f38_arg0.PipLT:completeAnimation()
	f38_arg0.PipRT:completeAnimation()
	f38_arg0.SpecialistName:completeAnimation()
	f38_arg0.StatName:completeAnimation()
	f38_arg0.StatValueHardpoint:completeAnimation()
	f38_arg0.StatValueBounty:completeAnimation()
	f38_arg0.StatValue:completeAnimation()
	f38_arg0.CoreStat1:completeAnimation()
	f38_arg0.CoreStat2:completeAnimation()
	f38_arg0.GameTypeStat1:completeAnimation()
	f38_arg0.GameTypeStat2:completeAnimation()
	f38_arg0.GameTypeStat3:completeAnimation()
	f38_arg0.stripeHero:completeAnimation()
	f38_arg0.LightBarHero:completeAnimation()
	f38_arg0.Backing:completeAnimation()
	f38_arg0.StatValueSas:completeAnimation()
	f38_arg0.GameTypeStat4:completeAnimation()
	f38_arg0.SpecialistImage:setAlpha(1)
	f38_arg0.InfoDivider2:setAlpha(1)
	f38_arg0.InfoDivider3:setLeftRight(0, 0, 1003, 1007)
	f38_arg0.InfoDivider3:setAlpha(1)
	f38_arg0.InfoDivider1:setAlpha(1)
	f38_arg0.PlayerName:setAlpha(1)
	f38_arg0.ScoreboardButtonPrompts:setAlpha(1)
	f38_arg0.PipLT:setAlpha(1)
	f38_arg0.PipRT:setAlpha(1)
	f38_arg0.SpecialistName:setAlpha(1)
	f38_arg0.StatName:setLeftRight(0, 0, 866.5, 942.5)
	f38_arg0.StatName:setAlpha(1)
	f38_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_24478A903275510A"))
	f38_arg0.StatValueHardpoint:setAlpha(0)
	f38_arg0.StatValueBounty:setAlpha(0)
	f38_arg0.StatValue:setLeftRight(0, 0, 866.5, 942.5)
	f38_arg0.StatValue:setAlpha(0.7)
	f38_arg0.CoreStat1:setAlpha(1)
	f38_arg0.CoreStat2:setAlpha(1)
	f38_arg0.GameTypeStat1:setTopBottom(0, 0, 75.5, 96.5)
	f38_arg0.GameTypeStat1:setAlpha(1)
	f38_arg0.GameTypeStat2:setLeftRight(0, 0, 1055.5, 1149.5)
	f38_arg0.GameTypeStat2:setTopBottom(0, 0, 99.5, 120.5)
	f38_arg0.GameTypeStat2:setAlpha(1)
	f38_arg0.GameTypeStat3:setLeftRight(0, 0, 1055.5, 1149.5)
	f38_arg0.GameTypeStat3:setTopBottom(0, 0, 124, 145)
	f38_arg0.GameTypeStat3:setAlpha(1)
	f38_arg0.stripeHero:setAlpha(0.5)
	f38_arg0.LightBarHero:setAlpha(0.12)
	f38_arg0.Backing:setAlpha(1)
	f38_arg0.StatValueSas:setAlpha(0)
	f38_arg0.GameTypeStat4:setTopBottom(0, 0, 96.5, 117.5)
	f38_arg0.GameTypeStat4:setAlpha(0)
	f38_arg0.GameTypeStat4.StatName:setText(GetScoreboardColumnHeader(f38_arg1, 1, "Score"))
end
CoD.ScoreboardGameStatusScores.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties(f39_arg1)
			f39_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenByEvent = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties(f40_arg1)
			f40_arg0:setupElementClipCounter(1)
			f40_arg0.SpecialistImage:completeAnimation()
			f40_arg0.SpecialistImage:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.SpecialistImage)
		end,
	},
	NoPlayers = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties(f41_arg1)
			f41_arg0:setupElementClipCounter(21)
			f41_arg0.Backing:completeAnimation()
			f41_arg0.Backing:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.Backing)
			f41_arg0.SpecialistImage:completeAnimation()
			f41_arg0.SpecialistImage:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.SpecialistImage)
			f41_arg0.LightBarHero:completeAnimation()
			f41_arg0.LightBarHero:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.LightBarHero)
			f41_arg0.stripeHero:completeAnimation()
			f41_arg0.stripeHero:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.stripeHero)
			f41_arg0.GameTypeStat3:completeAnimation()
			f41_arg0.GameTypeStat3:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.GameTypeStat3)
			f41_arg0.GameTypeStat2:completeAnimation()
			f41_arg0.GameTypeStat2:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.GameTypeStat2)
			f41_arg0.GameTypeStat1:completeAnimation()
			f41_arg0.GameTypeStat1:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.GameTypeStat1)
			f41_arg0.CoreStat2:completeAnimation()
			f41_arg0.CoreStat2:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.CoreStat2)
			f41_arg0.CoreStat1:completeAnimation()
			f41_arg0.CoreStat1:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.CoreStat1)
			f41_arg0.StatValue:completeAnimation()
			f41_arg0.StatValue:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.StatValue)
			f41_arg0.StatValueBounty:completeAnimation()
			f41_arg0.StatValueBounty:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.StatValueBounty)
			f41_arg0.StatValueHardpoint:completeAnimation()
			f41_arg0.StatValueHardpoint:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.StatValueHardpoint)
			f41_arg0.StatName:completeAnimation()
			f41_arg0.StatName:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.StatName)
			f41_arg0.SpecialistName:completeAnimation()
			f41_arg0.SpecialistName:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.SpecialistName)
			f41_arg0.PipRT:completeAnimation()
			f41_arg0.PipRT:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PipRT)
			f41_arg0.PipLT:completeAnimation()
			f41_arg0.PipLT:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PipLT)
			f41_arg0.ScoreboardButtonPrompts:completeAnimation()
			f41_arg0.ScoreboardButtonPrompts:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ScoreboardButtonPrompts)
			f41_arg0.PlayerName:completeAnimation()
			f41_arg0.PlayerName:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PlayerName)
			f41_arg0.InfoDivider1:completeAnimation()
			f41_arg0.InfoDivider1:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.InfoDivider1)
			f41_arg0.InfoDivider3:completeAnimation()
			f41_arg0.InfoDivider3:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.InfoDivider3)
			f41_arg0.InfoDivider2:completeAnimation()
			f41_arg0.InfoDivider2:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.InfoDivider2)
		end,
	},
	NoPlayersAAR = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties(f42_arg1)
			f42_arg0:setupElementClipCounter(21)
			f42_arg0.Backing:completeAnimation()
			f42_arg0.Backing:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Backing)
			f42_arg0.SpecialistImage:completeAnimation()
			f42_arg0.SpecialistImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.SpecialistImage)
			f42_arg0.LightBarHero:completeAnimation()
			f42_arg0.LightBarHero:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.LightBarHero)
			f42_arg0.stripeHero:completeAnimation()
			f42_arg0.stripeHero:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.stripeHero)
			f42_arg0.GameTypeStat3:completeAnimation()
			f42_arg0.GameTypeStat3:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.GameTypeStat3)
			f42_arg0.GameTypeStat2:completeAnimation()
			f42_arg0.GameTypeStat2:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.GameTypeStat2)
			f42_arg0.GameTypeStat1:completeAnimation()
			f42_arg0.GameTypeStat1:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.GameTypeStat1)
			f42_arg0.CoreStat2:completeAnimation()
			f42_arg0.CoreStat2:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.CoreStat2)
			f42_arg0.CoreStat1:completeAnimation()
			f42_arg0.CoreStat1:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.CoreStat1)
			f42_arg0.StatValue:completeAnimation()
			f42_arg0.StatValue:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.StatValue)
			f42_arg0.StatValueBounty:completeAnimation()
			f42_arg0.StatValueBounty:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.StatValueBounty)
			f42_arg0.StatValueHardpoint:completeAnimation()
			f42_arg0.StatValueHardpoint:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.StatValueHardpoint)
			f42_arg0.StatName:completeAnimation()
			f42_arg0.StatName:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.StatName)
			f42_arg0.SpecialistName:completeAnimation()
			f42_arg0.SpecialistName:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.SpecialistName)
			f42_arg0.PipRT:completeAnimation()
			f42_arg0.PipRT:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.PipRT)
			f42_arg0.PipLT:completeAnimation()
			f42_arg0.PipLT:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.PipLT)
			f42_arg0.ScoreboardButtonPrompts:completeAnimation()
			f42_arg0.ScoreboardButtonPrompts:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ScoreboardButtonPrompts)
			f42_arg0.PlayerName:completeAnimation()
			f42_arg0.PlayerName:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.PlayerName)
			f42_arg0.InfoDivider1:completeAnimation()
			f42_arg0.InfoDivider1:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.InfoDivider1)
			f42_arg0.InfoDivider3:completeAnimation()
			f42_arg0.InfoDivider3:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.InfoDivider3)
			f42_arg0.InfoDivider2:completeAnimation()
			f42_arg0.InfoDivider2:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.InfoDivider2)
		end,
	},
	TDM = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties(f43_arg1)
			f43_arg0:setupElementClipCounter(4)
			f43_arg0.GameTypeStat3:completeAnimation()
			f43_arg0.GameTypeStat3:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.GameTypeStat3)
			f43_arg0.GameTypeStat2:completeAnimation()
			f43_arg0.GameTypeStat2:setTopBottom(0, 0, 122.5, 143.5)
			f43_arg0.clipFinished(f43_arg0.GameTypeStat2)
			f43_arg0.GameTypeStat1:completeAnimation()
			f43_arg0.GameTypeStat1:setTopBottom(0, 0, 97.5, 118.5)
			f43_arg0.clipFinished(f43_arg0.GameTypeStat1)
			f43_arg0.StatName:completeAnimation()
			f43_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49B521FC58C6C10A"))
			f43_arg0.clipFinished(f43_arg0.StatName)
		end,
	},
	Dom = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties(f44_arg1)
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.GameTypeStat3:completeAnimation()
			f44_arg0.GameTypeStat3:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.GameTypeStat3)
			f44_arg0.GameTypeStat2:completeAnimation()
			f44_arg0.GameTypeStat2:setTopBottom(0, 0, 122.5, 143.5)
			f44_arg0.clipFinished(f44_arg0.GameTypeStat2)
			f44_arg0.GameTypeStat1:completeAnimation()
			f44_arg0.GameTypeStat1:setTopBottom(0, 0, 97.5, 118.5)
			f44_arg0.clipFinished(f44_arg0.GameTypeStat1)
		end,
	},
	Control = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties(f45_arg1)
			f45_arg0:setupElementClipCounter(3)
			f45_arg0.GameTypeStat3:completeAnimation()
			f45_arg0.GameTypeStat3:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.GameTypeStat3)
			f45_arg0.GameTypeStat2:completeAnimation()
			f45_arg0.GameTypeStat2:setTopBottom(0, 0, 122.5, 143.5)
			f45_arg0.clipFinished(f45_arg0.GameTypeStat2)
			f45_arg0.GameTypeStat1:completeAnimation()
			f45_arg0.GameTypeStat1:setTopBottom(0, 0, 97.5, 118.5)
			f45_arg0.clipFinished(f45_arg0.GameTypeStat1)
		end,
	},
	Hardpoint = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties(f46_arg1)
			f46_arg0:setupElementClipCounter(6)
			f46_arg0.GameTypeStat3:completeAnimation()
			f46_arg0.GameTypeStat3:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.GameTypeStat3)
			f46_arg0.GameTypeStat2:completeAnimation()
			f46_arg0.GameTypeStat2:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.GameTypeStat2)
			f46_arg0.GameTypeStat1:completeAnimation()
			f46_arg0.GameTypeStat1:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.GameTypeStat1)
			f46_arg0.StatValue:completeAnimation()
			f46_arg0.StatValue:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.StatValue)
			f46_arg0.StatValueHardpoint:completeAnimation()
			f46_arg0.StatValueHardpoint:setAlpha(0.7)
			f46_arg0.clipFinished(f46_arg0.StatValueHardpoint)
			f46_arg0.StatName:completeAnimation()
			f46_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3EAAF992DCD56393"))
			f46_arg0.clipFinished(f46_arg0.StatName)
		end,
	},
	SearchDestroy = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties(f47_arg1)
			f47_arg0:setupElementClipCounter(0)
		end,
	},
	Bounty = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties(f48_arg1)
			f48_arg0:setupElementClipCounter(2)
			f48_arg0.StatValue:completeAnimation()
			f48_arg0.StatValue:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.StatValue)
			f48_arg0.StatValueBounty:completeAnimation()
			f48_arg0.StatValueBounty:setAlpha(0.7)
			f48_arg0.clipFinished(f48_arg0.StatValueBounty)
		end,
	},
	FFA = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties(f49_arg1)
			f49_arg0:setupElementClipCounter(9)
			f49_arg0.GameTypeStat3:completeAnimation()
			f49_arg0.GameTypeStat3:setLeftRight(0, 0, 754.5, 848.5)
			f49_arg0.GameTypeStat3:setTopBottom(0, 0, 109, 130)
			f49_arg0.clipFinished(f49_arg0.GameTypeStat3)
			f49_arg0.GameTypeStat2:completeAnimation()
			f49_arg0.GameTypeStat2:setLeftRight(0, 0, 754.5, 848.5)
			f49_arg0.GameTypeStat2:setTopBottom(0, 0, 84.5, 105.5)
			f49_arg0.clipFinished(f49_arg0.GameTypeStat2)
			f49_arg0.GameTypeStat1:completeAnimation()
			f49_arg0.GameTypeStat1:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.GameTypeStat1)
			f49_arg0.CoreStat2:completeAnimation()
			f49_arg0.CoreStat2:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.CoreStat2)
			f49_arg0.CoreStat1:completeAnimation()
			f49_arg0.CoreStat1:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.CoreStat1)
			f49_arg0.StatValue:completeAnimation()
			f49_arg0.StatValue:setLeftRight(0, 0, 565.5, 641.5)
			f49_arg0.clipFinished(f49_arg0.StatValue)
			f49_arg0.StatName:completeAnimation()
			f49_arg0.StatName:setLeftRight(0, 0, 565.5, 641.5)
			f49_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49B521FC58C6C10A"))
			f49_arg0.clipFinished(f49_arg0.StatName)
			f49_arg0.InfoDivider3:completeAnimation()
			f49_arg0.InfoDivider3:setLeftRight(0, 0, 702, 706)
			f49_arg0.clipFinished(f49_arg0.InfoDivider3)
			f49_arg0.InfoDivider2:completeAnimation()
			f49_arg0.InfoDivider2:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.InfoDivider2)
		end,
	},
	Gun = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties(f50_arg1)
			f50_arg0:setupElementClipCounter(9)
			f50_arg0.GameTypeStat3:completeAnimation()
			f50_arg0.GameTypeStat3:setLeftRight(0, 0, 754.5, 848.5)
			f50_arg0.GameTypeStat3:setTopBottom(0, 0, 109, 130)
			f50_arg0.clipFinished(f50_arg0.GameTypeStat3)
			f50_arg0.GameTypeStat2:completeAnimation()
			f50_arg0.GameTypeStat2:setLeftRight(0, 0, 754.5, 848.5)
			f50_arg0.GameTypeStat2:setTopBottom(0, 0, 84.5, 105.5)
			f50_arg0.clipFinished(f50_arg0.GameTypeStat2)
			f50_arg0.GameTypeStat1:completeAnimation()
			f50_arg0.GameTypeStat1:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.GameTypeStat1)
			f50_arg0.CoreStat2:completeAnimation()
			f50_arg0.CoreStat2:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.CoreStat2)
			f50_arg0.CoreStat1:completeAnimation()
			f50_arg0.CoreStat1:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.CoreStat1)
			f50_arg0.StatValue:completeAnimation()
			f50_arg0.StatValue:setLeftRight(0, 0, 565.5, 641.5)
			f50_arg0.clipFinished(f50_arg0.StatValue)
			f50_arg0.StatName:completeAnimation()
			f50_arg0.StatName:setLeftRight(0, 0, 565.5, 641.5)
			f50_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49B521FC58C6C10A"))
			f50_arg0.clipFinished(f50_arg0.StatName)
			f50_arg0.InfoDivider3:completeAnimation()
			f50_arg0.InfoDivider3:setLeftRight(0, 0, 702, 706)
			f50_arg0.clipFinished(f50_arg0.InfoDivider3)
			f50_arg0.InfoDivider2:completeAnimation()
			f50_arg0.InfoDivider2:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.InfoDivider2)
		end,
	},
	Escort = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties(f51_arg1)
			f51_arg0:setupElementClipCounter(5)
			f51_arg0.GameTypeStat3:completeAnimation()
			f51_arg0.GameTypeStat3:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.GameTypeStat3)
			f51_arg0.GameTypeStat2:completeAnimation()
			f51_arg0.GameTypeStat2:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.GameTypeStat2)
			f51_arg0.GameTypeStat1:completeAnimation()
			f51_arg0.GameTypeStat1:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.GameTypeStat1)
			f51_arg0.StatValue:completeAnimation()
			f51_arg0.StatValue:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.StatValue)
			f51_arg0.StatValueBounty:completeAnimation()
			f51_arg0.StatValueBounty:setAlpha(0.7)
			f51_arg0.clipFinished(f51_arg0.StatValueBounty)
		end,
	},
	OneintheChamber = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties(f52_arg1)
			f52_arg0:setupElementClipCounter(4)
			f52_arg0.GameTypeStat3:completeAnimation()
			f52_arg0.GameTypeStat3:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.GameTypeStat3)
			f52_arg0.GameTypeStat2:completeAnimation()
			f52_arg0.GameTypeStat2:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.GameTypeStat2)
			f52_arg0.GameTypeStat1:completeAnimation()
			f52_arg0.GameTypeStat1:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.GameTypeStat1)
			f52_arg0.StatName:completeAnimation()
			f52_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49B521FC58C6C10A"))
			f52_arg0.clipFinished(f52_arg0.StatName)
		end,
	},
	SticksAndStones = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties(f53_arg1)
			f53_arg0:setupElementClipCounter(6)
			f53_arg0.GameTypeStat3:completeAnimation()
			f53_arg0.GameTypeStat3:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.GameTypeStat3)
			f53_arg0.GameTypeStat2:completeAnimation()
			f53_arg0.GameTypeStat2:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.GameTypeStat2)
			f53_arg0.GameTypeStat1:completeAnimation()
			f53_arg0.GameTypeStat1:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.GameTypeStat1)
			f53_arg0.StatValue:completeAnimation()
			f53_arg0.StatValue:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.StatValue)
			f53_arg0.StatValueSas:completeAnimation()
			f53_arg0.StatValueSas:setAlpha(0.7)
			f53_arg0.clipFinished(f53_arg0.StatValueSas)
			f53_arg0.StatName:completeAnimation()
			f53_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49B521FC58C6C10A"))
			f53_arg0.clipFinished(f53_arg0.StatName)
		end,
	},
	Clean = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties(f54_arg1)
			f54_arg0:setupElementClipCounter(3)
			f54_arg0.GameTypeStat3:completeAnimation()
			f54_arg0.GameTypeStat3:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.GameTypeStat3)
			f54_arg0.GameTypeStat2:completeAnimation()
			f54_arg0.GameTypeStat2:setTopBottom(0, 0, 122.5, 143.5)
			f54_arg0.clipFinished(f54_arg0.GameTypeStat2)
			f54_arg0.GameTypeStat1:completeAnimation()
			f54_arg0.GameTypeStat1:setTopBottom(0, 0, 97.5, 118.5)
			f54_arg0.clipFinished(f54_arg0.GameTypeStat1)
		end,
	},
	Infect = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties(f55_arg1)
			f55_arg0:setupElementClipCounter(7)
			f55_arg0.GameTypeStat4:completeAnimation()
			f55_arg0.GameTypeStat4.StatName:completeAnimation()
			f55_arg0.GameTypeStat4:setTopBottom(0, 0, 97.5, 118.5)
			f55_arg0.GameTypeStat4:setAlpha(1)
			f55_arg0.GameTypeStat4.StatName:setText(GetScoreboardColumnHeader(f55_arg1, 1, "Score"))
			f55_arg0.clipFinished(f55_arg0.GameTypeStat4)
			f55_arg0.GameTypeStat3:completeAnimation()
			f55_arg0.GameTypeStat3:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.GameTypeStat3)
			f55_arg0.GameTypeStat2:completeAnimation()
			f55_arg0.GameTypeStat2:setTopBottom(0, 0, 122.5, 144.5)
			f55_arg0.clipFinished(f55_arg0.GameTypeStat2)
			f55_arg0.GameTypeStat1:completeAnimation()
			f55_arg0.GameTypeStat1:setTopBottom(0, 0, 97.5, 118.5)
			f55_arg0.GameTypeStat1:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.GameTypeStat1)
			f55_arg0.StatValue:completeAnimation()
			f55_arg0.StatValue:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.StatValue)
			f55_arg0.StatValueHardpoint:completeAnimation()
			f55_arg0.StatValueHardpoint:setAlpha(0.7)
			f55_arg0.clipFinished(f55_arg0.StatValueHardpoint)
			f55_arg0.StatName:completeAnimation()
			f55_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49B521FC58C6C10A"))
			f55_arg0.clipFinished(f55_arg0.StatName)
		end,
	},
	SurvivorsVsZombies = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties(f56_arg1)
			f56_arg0:setupElementClipCounter(7)
			f56_arg0.GameTypeStat4:completeAnimation()
			f56_arg0.GameTypeStat4.StatName:completeAnimation()
			f56_arg0.GameTypeStat4:setTopBottom(0, 0, 97.5, 118.5)
			f56_arg0.GameTypeStat4:setAlpha(1)
			f56_arg0.GameTypeStat4.StatName:setText(GetScoreboardColumnHeader(f56_arg1, 1, "Score"))
			f56_arg0.clipFinished(f56_arg0.GameTypeStat4)
			f56_arg0.GameTypeStat3:completeAnimation()
			f56_arg0.GameTypeStat3:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.GameTypeStat3)
			f56_arg0.GameTypeStat2:completeAnimation()
			f56_arg0.GameTypeStat2:setTopBottom(0, 0, 122.5, 144.5)
			f56_arg0.clipFinished(f56_arg0.GameTypeStat2)
			f56_arg0.GameTypeStat1:completeAnimation()
			f56_arg0.GameTypeStat1:setTopBottom(0, 0, 97.5, 118.5)
			f56_arg0.GameTypeStat1:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.GameTypeStat1)
			f56_arg0.StatValue:completeAnimation()
			f56_arg0.StatValue:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.StatValue)
			f56_arg0.StatValueHardpoint:completeAnimation()
			f56_arg0.StatValueHardpoint:setAlpha(0.7)
			f56_arg0.clipFinished(f56_arg0.StatValueHardpoint)
			f56_arg0.StatName:completeAnimation()
			f56_arg0.StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49B521FC58C6C10A"))
			f56_arg0.clipFinished(f56_arg0.StatName)
		end,
	},
}
CoD.ScoreboardGameStatusScores.__onClose = function(f57_arg0)
	f57_arg0.Backing:close()
	f57_arg0.SpecialistImage:close()
	f57_arg0.GameTypeStat4:close()
	f57_arg0.GameTypeStat3:close()
	f57_arg0.GameTypeStat2:close()
	f57_arg0.GameTypeStat1:close()
	f57_arg0.CoreStat2:close()
	f57_arg0.CoreStat1:close()
	f57_arg0.StatValue:close()
	f57_arg0.StatValueSas:close()
	f57_arg0.StatValueBounty:close()
	f57_arg0.StatValueHardpoint:close()
	f57_arg0.SpecialistName:close()
	f57_arg0.ScoreboardButtonPrompts:close()
	f57_arg0.PlayerName:close()
end
