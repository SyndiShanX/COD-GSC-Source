require("x64:62adff09117f331")
require("x64:d69f65024f3f205")
require("x64:228a7baa572b047")
require("x64:e8e4ca11e9bec8b")
require("x64:a9255c570c68aa8")
CoD.ArenaInfoWidget = InheritFrom(LUI.UIElement)
CoD.ArenaInfoWidget.__defaultWidth = 349
CoD.ArenaInfoWidget.__defaultHeight = 635
CoD.ArenaInfoWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaInfoWidget)
	self.id = "ArenaInfoWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0, 0, 1.5, 350.5, 0, 0, 35, 636)
	Background:setRGB(0.09, 0.09, 0.09)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local TiledBacking = LUI.UIImage.new(0, 0, 1.5, 350.5, 0, 0, 38, 636)
	TiledBacking:setAlpha(0.25)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local TiledwhiteNoiseBacking = LUI.UIImage.new(0, 0, 1.5, 132.5, 0, 0, 469, 600)
	TiledwhiteNoiseBacking:setAlpha(0.01)
	TiledwhiteNoiseBacking:setImage(RegisterImage(0x7167D8C33A06020))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local Background2 = LUI.UIImage.new(0, 0, 1.5, 350.5, 0, 0, 600, 636)
	Background2:setRGB(0, 0, 0)
	Background2:setAlpha(0.4)
	self:addElement(Background2)
	self.Background2 = Background2
	local BGDotPatternLarge2 = LUI.UIImage.new(0, 0, 2.5, 350.5, 0, 0, 467, 471)
	BGDotPatternLarge2:setImage(RegisterImage(0xB20AD7A31239369))
	BGDotPatternLarge2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	BGDotPatternLarge2:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge2:setupNineSliceShader(32, 4)
	self:addElement(BGDotPatternLarge2)
	self.BGDotPatternLarge2 = BGDotPatternLarge2
	local ArenaRubies = CoD.ArenaRubies.new(f1_arg0, f1_arg1, 0, 0, 212.5, 352.5, 0, 0, 498, 572)
	ArenaRubies:setAlpha(0)
	ArenaRubies:setScale(0.8, 0.8)
	self:addElement(ArenaRubies)
	self.ArenaRubies = ArenaRubies
	local arenaFlameStreak = LUI.UIImage.new(0, 0, -63, 197, 0, 0, 405, 665)
	arenaFlameStreak:setImage(RegisterImage(0x39CD2A8412A4F6))
	arenaFlameStreak:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	arenaFlameStreak:setShaderVector(0, 4, 4, 0, 0)
	arenaFlameStreak:setShaderVector(1, 8, 0, 0, 0)
	self:addElement(arenaFlameStreak)
	self.arenaFlameStreak = arenaFlameStreak
	local Icon = LUI.UIImage.new(0, 0, 1.5, 132.5, 0, 0, 469, 600)
	Icon:setScale(0.98, 0.98)
	Icon:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge.xuid", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankIconFromXuid(f2_local0)))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local SkillIcon = LUI.UIImage.new(0, 0, 1.5, 132.5, 0, 0, 469, 600)
	SkillIcon.__Image = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			SkillIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSkillDivisionIconFromXuid(f3_local0)))
		end
	end
	SkillIcon:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge.xuid", SkillIcon.__Image)
	SkillIcon.__Image_FullPath = function()
		local f4_local0 = DataSources.PerController.getModel(f1_arg1)
		f4_local0 = f4_local0["identityBadge.xuid"]
		if f4_local0 then
			SkillIcon.__Image(f4_local0)
		end
	end
	self:addElement(SkillIcon)
	self.SkillIcon = SkillIcon
	local RankTitle = LUI.UIText.new(0, 0, 140.5, 352.5, 0, 0, 492, 510)
	RankTitle:setRGB(0.92, 0.92, 0.92)
	RankTitle:setAlpha(0.5)
	RankTitle:setText(LocalizeToUpperString(0x3370355189B42A7))
	RankTitle:setTTF("ttmussels_regular")
	RankTitle:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	RankTitle:setShaderVector(0, 1, 0, 0, 0)
	RankTitle:setShaderVector(1, 0, 0, 0, 0)
	RankTitle:setShaderVector(2, 0, 0, 0, 0.5)
	RankTitle:setLetterSpacing(1)
	RankTitle:setLineSpacing(1)
	RankTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RankTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RankTitle)
	self.RankTitle = RankTitle
	local Rank = LUI.UIText.new(0, 0, 135.5, 255.5, 0, 0, 504.5, 571.5)
	Rank:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Rank.__String_Reference = function()
		Rank:setText(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankFromXuid(12))
	end
	Rank.__String_Reference()
	Rank:setTTF("0arame_mono_stencil")
	Rank:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Rank:setShaderVector(0, 1, 0, 0, 0)
	Rank:setShaderVector(1, 0, 0, 0, 0)
	Rank:setShaderVector(2, 0.3, 0.3, 0.3, 0.3)
	Rank:setLetterSpacing(2)
	Rank:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Rank)
	self.Rank = Rank
	local WinStreak = CoD.LeaguePlayLeaderboard_InfoPaneWinStreak.new(f1_arg0, f1_arg1, 0, 0, 14, 341, 0, 0, 602, 635)
	WinStreak.WinStreak:setText(CoD.ArenaLeaguePlayUtility.GetPlayerBestCurrentEventGameStreakFromXuid(3))
	self:addElement(WinStreak)
	self.WinStreak = WinStreak
	local EmblemFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1.5, 350.5, 0, 0, 35, 384)
	EmblemFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmblemFrame:setAlpha(0.02)
	self:addElement(EmblemFrame)
	self.EmblemFrame = EmblemFrame
	local Emblem = LUI.UIImage.new(0, 0, 1.5, 350.5, 0, 0, 35, 384)
	Emblem:setScale(0.98, 0.98)
	self:addElement(Emblem)
	self.Emblem = Emblem
	local SocialArrow = CoD.CommonSocialArrow.new(f1_arg0, f1_arg1, 0, 0, 322.5, 346.5, 0, 0, 38, 51)
	self:addElement(SocialArrow)
	self.SocialArrow = SocialArrow
	local infoBracketBot = LUI.UIImage.new(0, 0, 0.5, 351.5, 0, 0, 629, 637)
	infoBracketBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot:setAlpha(0.5)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local CallingCard = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 1.5, 350.5, 0, 0, 384, 466)
	self:addElement(CallingCard)
	self.CallingCard = CallingCard
	local Name = LUI.UIText.new(0, 0, 0.5, 348.5, 0.5, 0.5, -317.5, -283.5)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Name:setTTF("notosans_regular")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Name)
	self.Name = Name
	local f1_local19 = SkillIcon
	local f1_local20 = SkillIcon.subscribeToModel
	local f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21.lobbyNav, SkillIcon.__Image_FullPath)
	f1_local19 = SkillIcon
	f1_local20 = SkillIcon.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["privateClient.update"], SkillIcon.__Image_FullPath)
	f1_local19 = SkillIcon
	f1_local20 = SkillIcon.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["gameClient.update"], SkillIcon.__Image_FullPath)
	f1_local19 = SkillIcon
	f1_local20 = SkillIcon.subscribeToModel
	f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["PartyPrivacy.privacy"], SkillIcon.__Image_FullPath)
	f1_local19 = Rank
	f1_local20 = Rank.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21.lobbyNav, Rank.__String_Reference)
	f1_local19 = Rank
	f1_local20 = Rank.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["privateClient.update"], Rank.__String_Reference)
	f1_local19 = Rank
	f1_local20 = Rank.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["gameClient.update"], Rank.__String_Reference)
	f1_local19 = Rank
	f1_local20 = Rank.subscribeToModel
	f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["PartyPrivacy.privacy"], Rank.__String_Reference)
	CallingCard.id = "CallingCard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaInfoWidget.__onClose = function(f6_arg0)
	f6_arg0.ArenaRubies:close()
	f6_arg0.Icon:close()
	f6_arg0.SkillIcon:close()
	f6_arg0.Rank:close()
	f6_arg0.WinStreak:close()
	f6_arg0.EmblemFrame:close()
	f6_arg0.SocialArrow:close()
	f6_arg0.CallingCard:close()
end
