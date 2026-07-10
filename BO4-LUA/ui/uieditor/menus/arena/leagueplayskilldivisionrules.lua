require("x64:53349419f3104a1")
require("x64:f3fc0ec27ad5c4e")
require("x64:e327b7f03479680")
CoD.LeaguePlaySkillDivisionRules = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlaySkillDivisionRules = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlaySkillDivisionRules", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LeaguePlaySkillDivisionRules)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local LeaguePlayRulesPopup = CoD.LeaguePlayRulesPopup.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	LeaguePlayRulesPopup:mergeStateConditions({
		{
			stateName = "LeaguePlayRankRules",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:addElement(LeaguePlayRulesPopup)
	self.LeaguePlayRulesPopup = LeaguePlayRulesPopup
	local BackgroundTop = LUI.UIImage.new(0.5, 0.5, -497, 497, 0.5, 0.5, -427, -368)
	BackgroundTop:setAlpha(0.02)
	self:addElement(BackgroundTop)
	self.BackgroundTop = BackgroundTop
	local BGDotPatternTop = LUI.UIImage.new(0.5, 0.5, -497, 497, 0.5, 0.5, -428, -369)
	BGDotPatternTop:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BGDotPatternTop:setAlpha(0.05)
	BGDotPatternTop:setImage(RegisterImage(0xFC21A8215EA012B))
	BGDotPatternTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BGDotPatternTop:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternTop:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternTop)
	self.BGDotPatternTop = BGDotPatternTop
	local DisplayImage = LUI.UIImage.new(0.5, 0.5, -468, 30, 0.5, 0.5, -284, 298)
	DisplayImage:setImage(RegisterImage(0x3C590AC3E812395))
	DisplayImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	DisplayImage:setShaderVector(0, 0.5, 0, 0, 0)
	DisplayImage:setShaderVector(1, 1, 1, 0, 0)
	DisplayImage:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(DisplayImage)
	self.DisplayImage = DisplayImage
	local SubHeader = LUI.UIText.new(0.5, 0.5, -470, 470, 0.5, 0.5, -350.5, -331.5)
	SubHeader:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SubHeader:setAlpha(0.5)
	SubHeader:setText(Engine[0xF9F1239CFD921FE](0xE7EA3AD42D23FD7))
	SubHeader:setTTF("ttmussels_regular")
	SubHeader:setLetterSpacing(2)
	SubHeader:setLineSpacing(1)
	SubHeader:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SubHeader:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SubHeader)
	self.SubHeader = SubHeader
	local BackingTopRank = CoD.LeaguePlaySkillDivisionRankBacking.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, -285, -191)
	self:addElement(BackingTopRank)
	self.BackingTopRank = BackingTopRank
	local TopRank = CoD.ArenaSkillDivision.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, -285, -191)
	TopRank.SkillBadge:setImage(RegisterImage(0x9853E7CB53E6FE8))
	TopRank.Title:setRGB(0.64, 0.13, 0.69)
	TopRank.Title:setText(LocalizeToUpperString(0x56161D4902B44C3))
	TopRank.Description:setText(LocalizeToUpperString(0xEC877567B5AFC55))
	self:addElement(TopRank)
	self.TopRank = TopRank
	local BackingSecondRank = CoD.LeaguePlaySkillDivisionRankBacking.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, -163, -69)
	BackingSecondRank.TopTriangle:setAlpha(0.04)
	self:addElement(BackingSecondRank)
	self.BackingSecondRank = BackingSecondRank
	local SecondRank = CoD.ArenaSkillDivision.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, -162.5, -68.5)
	SecondRank.SkillBadge:setImage(RegisterImage(0x77644A3D1920171))
	SecondRank.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SecondRank.Title:setText(LocalizeToUpperString(0x198C584B9BE2680))
	SecondRank.Description:setText(LocalizeToUpperString(0xF42543937B4C208))
	self:addElement(SecondRank)
	self.SecondRank = SecondRank
	local BackingThirdRank = CoD.LeaguePlaySkillDivisionRankBacking.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, -41, 53)
	BackingThirdRank.TopTriangle:setAlpha(0.04)
	self:addElement(BackingThirdRank)
	self.BackingThirdRank = BackingThirdRank
	local ThirdRank = CoD.ArenaSkillDivision.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, -40.5, 53.5)
	ThirdRank.SkillBadge:setImage(RegisterImage(0xAE51DF99A62031E))
	ThirdRank.Title:setRGB(0.32, 0.8, 0.1)
	ThirdRank.Title:setText(LocalizeToUpperString(0x2813B2356E26CF9))
	ThirdRank.Description:setText(LocalizeToUpperString(0xE6504108D92C8D3))
	self:addElement(ThirdRank)
	self.ThirdRank = ThirdRank
	local BackingFourthRank = CoD.LeaguePlaySkillDivisionRankBacking.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, 81.5, 175.5)
	BackingFourthRank.TopTriangle:setAlpha(0.04)
	self:addElement(BackingFourthRank)
	self.BackingFourthRank = BackingFourthRank
	local FourthRank = CoD.ArenaSkillDivision.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 470, 0.5, 0.5, 81.5, 175.5)
	FourthRank.SkillBadge:setImage(RegisterImage(0xDCF3FC6FA429166))
	FourthRank.Title:setRGB(0.98, 0.86, 0.09)
	FourthRank.Title:setText(LocalizeToUpperString(0x8E7615C0CA01BDC))
	FourthRank.Description:setText(LocalizeToUpperString(0x10B06685E486224))
	self:addElement(FourthRank)
	self.FourthRank = FourthRank
	local BackingFifthRank = CoD.LeaguePlaySkillDivisionRankBacking.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, 203, 297)
	BackingFifthRank:mergeStateConditions({
		{
			stateName = "NoSkillBadgeBacking",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	BackingFifthRank.TopTriangle:setAlpha(0.04)
	self:addElement(BackingFifthRank)
	self.BackingFifthRank = BackingFifthRank
	local FifthRank = CoD.ArenaSkillDivision.new(f1_local1, f1_arg0, 0.5, 0.5, 58, 469, 0.5, 0.5, 203.5, 297.5)
	FifthRank:mergeStateConditions({
		{
			stateName = "NoSkillBadge",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	FifthRank.Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	FifthRank.Title:setText(LocalizeToUpperString(0xF9BC5593DCA6179))
	FifthRank.Description:setText(LocalizeToUpperString(0x41FE97BD8035653))
	self:addElement(FifthRank)
	self.FifthRank = FifthRank
	local Header = LUI.UIText.new(0.5, 0.5, -450, 450, 0.5, 0.5, -411.5, -375.5)
	Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Header:setText(LocalizeToUpperString(0x92A27F7A5B7166D))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(6)
	Header:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Header)
	self.Header = Header
	self:mergeStateConditions({
		{
			stateName = "DefaultPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x3996BAAC73C3F6D, nil, nil)
		return true
	end, false)
	LeaguePlayRulesPopup.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		LeaguePlayRulesPopup.id = "LeaguePlayRulesPopup"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.LeaguePlaySkillDivisionRules.__resetProperties = function(f8_arg0)
	f8_arg0.Header:completeAnimation()
	f8_arg0.BGDotPatternTop:completeAnimation()
	f8_arg0.BackgroundTop:completeAnimation()
	f8_arg0.Header:setTopBottom(0.5, 0.5, -411.5, -375.5)
	f8_arg0.BGDotPatternTop:setTopBottom(0.5, 0.5, -428, -369)
	f8_arg0.BackgroundTop:setLeftRight(0.5, 0.5, -497, 497)
	f8_arg0.BackgroundTop:setTopBottom(0.5, 0.5, -427, -368)
end
CoD.LeaguePlaySkillDivisionRules.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultPC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.BackgroundTop:completeAnimation()
			f10_arg0.BackgroundTop:setLeftRight(0.5, 0.5, -500, 500)
			f10_arg0.BackgroundTop:setTopBottom(0.5, 0.5, -455.5, -393.5)
			f10_arg0.clipFinished(f10_arg0.BackgroundTop)
			f10_arg0.BGDotPatternTop:completeAnimation()
			f10_arg0.BGDotPatternTop:setTopBottom(0.5, 0.5, -454, -395)
			f10_arg0.clipFinished(f10_arg0.BGDotPatternTop)
			f10_arg0.Header:completeAnimation()
			f10_arg0.Header:setTopBottom(0.5, 0.5, -437.5, -401.5)
			f10_arg0.clipFinished(f10_arg0.Header)
		end,
	},
}
CoD.LeaguePlaySkillDivisionRules.__onClose = function(f11_arg0)
	f11_arg0.LeaguePlayRulesPopup:close()
	f11_arg0.BackingTopRank:close()
	f11_arg0.TopRank:close()
	f11_arg0.BackingSecondRank:close()
	f11_arg0.SecondRank:close()
	f11_arg0.BackingThirdRank:close()
	f11_arg0.ThirdRank:close()
	f11_arg0.BackingFourthRank:close()
	f11_arg0.FourthRank:close()
	f11_arg0.BackingFifthRank:close()
	f11_arg0.FifthRank:close()
end
