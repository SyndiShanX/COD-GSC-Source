require("x64:f3fc0ec27ad5c4e")
CoD.LeaguePlayContentRules = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlayContentRules = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlayContentRules", f1_arg0)
	local f1_local1 = self
	if not IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	end
	self:setClass(CoD.LeaguePlayContentRules)
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
	local BGDotPatternTop = LUI.UIImage.new(0.5, 0.5, -497, 497, 0, 0, 112, 171)
	BGDotPatternTop:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BGDotPatternTop:setAlpha(0.05)
	BGDotPatternTop:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	BGDotPatternTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BGDotPatternTop:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternTop:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternTop)
	self.BGDotPatternTop = BGDotPatternTop
	local BGModification = LUI.UIImage.new(0.5, 0.5, -391, 389, 0.5, 0.5, 159, 369)
	BGModification:setRGB(0.92, 0.92, 0.92)
	BGModification:setAlpha(0.01)
	self:addElement(BGModification)
	self.BGModification = BGModification
	local BGRestrictions = LUI.UIImage.new(0.5, 0.5, -391, 389, 0.5, 0.5, -185, 55)
	BGRestrictions:setRGB(0.92, 0.92, 0.92)
	BGRestrictions:setAlpha(0.01)
	self:addElement(BGRestrictions)
	self.BGRestrictions = BGRestrictions
	local ModificationsRules = LUI.UIText.new(0.5, 0.5, -379, 361, 0.5, 0.5, 175, 193)
	ModificationsRules:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ModificationsRules:setAlpha(0.8)
	ModificationsRules:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_76B6C3C7C77932AF"))
	ModificationsRules:setTTF("dinnext_regular")
	ModificationsRules:setLetterSpacing(1)
	ModificationsRules:setLineSpacing(4)
	ModificationsRules:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ModificationsRules:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ModificationsRules)
	self.ModificationsRules = ModificationsRules
	local ModificationsDescription = LUI.UIText.new(0.5, 0.5, -391, 389, 0.5, 0.5, 132, 150)
	ModificationsDescription:setRGB(0.92, 0.92, 0.92)
	ModificationsDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49871CCE28D2D712"))
	ModificationsDescription:setTTF("ttmussels_regular")
	ModificationsDescription:setLetterSpacing(1)
	ModificationsDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ModificationsDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ModificationsDescription)
	self.ModificationsDescription = ModificationsDescription
	local Modifications = LUI.UIText.new(0.5, 0.5, -391, 349, 0.5, 0.5, 105, 132)
	Modifications:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Modifications:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_640ADCE41CBA3106"))
	Modifications:setTTF("ttmussels_demibold")
	Modifications:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Modifications:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Modifications)
	self.Modifications = Modifications
	local RestrictionsDescription = LUI.UIText.new(0.5, 0.5, -391, 389, 0.5, 0.5, -214, -196)
	RestrictionsDescription:setRGB(0.92, 0.92, 0.92)
	RestrictionsDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_14436CCFF155D5B3"))
	RestrictionsDescription:setTTF("ttmussels_regular")
	RestrictionsDescription:setLetterSpacing(1)
	RestrictionsDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RestrictionsDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RestrictionsDescription)
	self.RestrictionsDescription = RestrictionsDescription
	local RestrictionRules = LUI.UIText.new(0.5, 0.5, -379, 361, 0.5, 0.5, -171, -153)
	RestrictionRules:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	RestrictionRules:setAlpha(0.8)
	RestrictionRules:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3FD43749541B8196"))
	RestrictionRules:setTTF("dinnext_regular")
	RestrictionRules:setLetterSpacing(1)
	RestrictionRules:setLineSpacing(4)
	RestrictionRules:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RestrictionRules:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RestrictionRules)
	self.RestrictionRules = RestrictionRules
	local Restrictions = LUI.UIText.new(0.5, 0.5, -391, 349, 0.5, 0.5, -241, -214)
	Restrictions:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Restrictions:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_24CAE0EF959361FA"))
	Restrictions:setTTF("ttmussels_demibold")
	Restrictions:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Restrictions:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Restrictions)
	self.Restrictions = Restrictions
	local ScreenSubTitle = LUI.UIText.new(0.5, 0.5, -391.5, 408.5, 0.5, 0.5, -357.5, -336.5)
	ScreenSubTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_51FA61E0F29F804E"))
	ScreenSubTitle:setTTF("ttmussels_regular")
	ScreenSubTitle:setLetterSpacing(1)
	ScreenSubTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ScreenSubTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ScreenSubTitle)
	self.ScreenSubTitle = ScreenSubTitle
	local ScreenTitle = LUI.UIText.new(0.5, 0.5, -450, 450, 0.5, 0.5, -411.5, -375.5)
	ScreenTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ScreenTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1F794CE5D3A3BE33"))
	ScreenTitle:setTTF("ttmussels_demibold")
	ScreenTitle:setLetterSpacing(6)
	ScreenTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ScreenTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ScreenTitle)
	self.ScreenTitle = ScreenTitle
	local DividerLine = LUI.UIImage.new(0.5, 0.5, -497.5, 496.5, 0.5, 0.5, 83, 87)
	DividerLine:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DividerLine:setAlpha(0.2)
	DividerLine:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DividerLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DividerLine:setShaderVector(0, 0, 0, 0, 0)
	DividerLine:setupNineSliceShader(16, 4)
	self:addElement(DividerLine)
	self.DividerLine = DividerLine
	self:mergeStateConditions({
		{
			stateName = "AsianLanguagePC",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian() and IsPC()
			end,
		},
		{
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
		{
			stateName = "ArabicLanguage",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			GoBack(self, controller)
			return true
		else
			GoBack(self, controller)
			return true
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		else
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/dismiss", nil, "ESCAPE")
			return true
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if not IsPC() then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
		end
	end)
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
CoD.LeaguePlayContentRules.__resetProperties = function(f10_arg0)
	f10_arg0.ModificationsDescription:completeAnimation()
	f10_arg0.RestrictionsDescription:completeAnimation()
	f10_arg0.ModificationsRules:completeAnimation()
	f10_arg0.RestrictionRules:completeAnimation()
	f10_arg0.ScreenTitle:completeAnimation()
	f10_arg0.DividerLine:completeAnimation()
	f10_arg0.ScreenSubTitle:completeAnimation()
	f10_arg0.Restrictions:completeAnimation()
	f10_arg0.Modifications:completeAnimation()
	f10_arg0.BGRestrictions:completeAnimation()
	f10_arg0.BGModification:completeAnimation()
	f10_arg0.BackgroundTop:completeAnimation()
	f10_arg0.BGDotPatternTop:completeAnimation()
	f10_arg0.ModificationsDescription:setTopBottom(0.5, 0.5, 132, 150)
	f10_arg0.RestrictionsDescription:setTopBottom(0.5, 0.5, -214, -196)
	f10_arg0.ModificationsRules:setTopBottom(0.5, 0.5, 175, 193)
	f10_arg0.ModificationsRules:setLineSpacing(4)
	f10_arg0.RestrictionRules:setTopBottom(0.5, 0.5, -171, -153)
	f10_arg0.RestrictionRules:setLineSpacing(4)
	f10_arg0.ScreenTitle:setTopBottom(0.5, 0.5, -411.5, -375.5)
	f10_arg0.DividerLine:setTopBottom(0.5, 0.5, 83, 87)
	f10_arg0.ScreenSubTitle:setTopBottom(0.5, 0.5, -357.5, -336.5)
	f10_arg0.Restrictions:setTopBottom(0.5, 0.5, -241, -214)
	f10_arg0.Modifications:setTopBottom(0.5, 0.5, 105, 132)
	f10_arg0.BGRestrictions:setTopBottom(0.5, 0.5, -185, 55)
	f10_arg0.BGModification:setTopBottom(0.5, 0.5, 159, 369)
	f10_arg0.BackgroundTop:setLeftRight(0.5, 0.5, -497, 497)
	f10_arg0.BackgroundTop:setTopBottom(0.5, 0.5, -427, -368)
	f10_arg0.BGDotPatternTop:setTopBottom(0, 0, 112, 171)
end
CoD.LeaguePlayContentRules.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguagePC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.ModificationsRules:completeAnimation()
			f12_arg0.ModificationsRules:setTopBottom(0.5, 0.5, 175, 188)
			f12_arg0.clipFinished(f12_arg0.ModificationsRules)
			f12_arg0.ModificationsDescription:completeAnimation()
			f12_arg0.ModificationsDescription:setTopBottom(0.5, 0.5, 143, 155)
			f12_arg0.clipFinished(f12_arg0.ModificationsDescription)
			f12_arg0.RestrictionsDescription:completeAnimation()
			f12_arg0.RestrictionsDescription:setTopBottom(0.5, 0.5, -202, -190)
			f12_arg0.clipFinished(f12_arg0.RestrictionsDescription)
			f12_arg0.RestrictionRules:completeAnimation()
			f12_arg0.RestrictionRules:setTopBottom(0.5, 0.5, -171, -158)
			f12_arg0.clipFinished(f12_arg0.RestrictionRules)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(13)
			f13_arg0.BackgroundTop:completeAnimation()
			f13_arg0.BackgroundTop:setLeftRight(0.5, 0.5, -500, 500)
			f13_arg0.BackgroundTop:setTopBottom(0.5, 0.5, -455, -392)
			f13_arg0.clipFinished(f13_arg0.BackgroundTop)
			f13_arg0.BGDotPatternTop:completeAnimation()
			f13_arg0.BGDotPatternTop:setTopBottom(0, 0, 88, 147)
			f13_arg0.clipFinished(f13_arg0.BGDotPatternTop)
			f13_arg0.BGModification:completeAnimation()
			f13_arg0.BGModification:setTopBottom(0.5, 0.5, 134, 344)
			f13_arg0.clipFinished(f13_arg0.BGModification)
			f13_arg0.BGRestrictions:completeAnimation()
			f13_arg0.BGRestrictions:setTopBottom(0.5, 0.5, -210, 30)
			f13_arg0.clipFinished(f13_arg0.BGRestrictions)
			f13_arg0.ModificationsRules:completeAnimation()
			f13_arg0.ModificationsRules:setTopBottom(0.5, 0.5, 150, 168)
			f13_arg0.clipFinished(f13_arg0.ModificationsRules)
			f13_arg0.ModificationsDescription:completeAnimation()
			f13_arg0.ModificationsDescription:setTopBottom(0.5, 0.5, 107, 125)
			f13_arg0.clipFinished(f13_arg0.ModificationsDescription)
			f13_arg0.Modifications:completeAnimation()
			f13_arg0.Modifications:setTopBottom(0.5, 0.5, 80, 107)
			f13_arg0.clipFinished(f13_arg0.Modifications)
			f13_arg0.RestrictionsDescription:completeAnimation()
			f13_arg0.RestrictionsDescription:setTopBottom(0.5, 0.5, -239, -221)
			f13_arg0.clipFinished(f13_arg0.RestrictionsDescription)
			f13_arg0.RestrictionRules:completeAnimation()
			f13_arg0.RestrictionRules:setTopBottom(0.5, 0.5, -196, -178)
			f13_arg0.clipFinished(f13_arg0.RestrictionRules)
			f13_arg0.Restrictions:completeAnimation()
			f13_arg0.Restrictions:setTopBottom(0.5, 0.5, -266, -239)
			f13_arg0.clipFinished(f13_arg0.Restrictions)
			f13_arg0.ScreenSubTitle:completeAnimation()
			f13_arg0.ScreenSubTitle:setTopBottom(0.5, 0.5, -382, -361)
			f13_arg0.clipFinished(f13_arg0.ScreenSubTitle)
			f13_arg0.ScreenTitle:completeAnimation()
			f13_arg0.ScreenTitle:setTopBottom(0.5, 0.5, -437, -401)
			f13_arg0.clipFinished(f13_arg0.ScreenTitle)
			f13_arg0.DividerLine:completeAnimation()
			f13_arg0.DividerLine:setTopBottom(0.5, 0.5, -26, -22)
			f13_arg0.clipFinished(f13_arg0.DividerLine)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.ModificationsRules:completeAnimation()
			f14_arg0.ModificationsRules:setTopBottom(0.5, 0.5, 175, 188)
			f14_arg0.clipFinished(f14_arg0.ModificationsRules)
			f14_arg0.ModificationsDescription:completeAnimation()
			f14_arg0.ModificationsDescription:setTopBottom(0.5, 0.5, 143, 155)
			f14_arg0.clipFinished(f14_arg0.ModificationsDescription)
			f14_arg0.RestrictionsDescription:completeAnimation()
			f14_arg0.RestrictionsDescription:setTopBottom(0.5, 0.5, -202, -190)
			f14_arg0.clipFinished(f14_arg0.RestrictionsDescription)
			f14_arg0.RestrictionRules:completeAnimation()
			f14_arg0.RestrictionRules:setTopBottom(0.5, 0.5, -171, -158)
			f14_arg0.clipFinished(f14_arg0.RestrictionRules)
		end,
	},
	ArabicLanguage = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.ModificationsRules:completeAnimation()
			f15_arg0.ModificationsRules:setTopBottom(0.5, 0.5, 166, 183)
			f15_arg0.ModificationsRules:setLineSpacing(1)
			f15_arg0.clipFinished(f15_arg0.ModificationsRules)
			f15_arg0.RestrictionRules:completeAnimation()
			f15_arg0.RestrictionRules:setTopBottom(0.5, 0.5, -176, -159)
			f15_arg0.RestrictionRules:setLineSpacing(2)
			f15_arg0.clipFinished(f15_arg0.RestrictionRules)
		end,
	},
}
CoD.LeaguePlayContentRules.__onClose = function(f16_arg0)
	f16_arg0.LeaguePlayRulesPopup:close()
end
