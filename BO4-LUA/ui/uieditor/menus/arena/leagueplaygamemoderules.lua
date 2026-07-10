require("x64:f3fc0ec27ad5c4e")
CoD.LeaguePlayGameModeRules = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlayGameModeRules = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlayGameModeRules", f1_arg0)
	local f1_local1 = self
	if not IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	end
	self:setClass(CoD.LeaguePlayGameModeRules)
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
	local BackgroundTop = LUI.UIImage.new(0.5, 0.5, -497, 497, 0, 0, 113, 172)
	BackgroundTop:setAlpha(0.02)
	self:addElement(BackgroundTop)
	self.BackgroundTop = BackgroundTop
	local BGDotPatternTop = LUI.UIImage.new(0.5, 0.5, -497, 497, 0, 0, 112, 171)
	BGDotPatternTop:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BGDotPatternTop:setAlpha(0.05)
	BGDotPatternTop:setImage(RegisterImage(0xFC21A8215EA012B))
	BGDotPatternTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BGDotPatternTop:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternTop:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternTop)
	self.BGDotPatternTop = BGDotPatternTop
	local Control = LUI.UIImage.new(0.5, 0.5, -433.5, -193.5, 0, 0, 648, 888)
	Control:setImage(RegisterImage(0xB257A30BA2452FB))
	self:addElement(Control)
	self.Control = Control
	local ControlRules = LUI.UIText.new(0.5, 0.5, -193.5, 426.5, 0, 0, 731, 749)
	ControlRules:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ControlRules:setAlpha(0.8)
	ControlRules:setText(Engine[0xF9F1239CFD921FE](0x823B0CB3D9ABF2))
	ControlRules:setTTF("dinnext_regular")
	ControlRules:setLetterSpacing(1)
	ControlRules:setLineSpacing(2)
	ControlRules:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ControlRules:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ControlRules)
	self.ControlRules = ControlRules
	local ControlTitle = LUI.UIText.new(0.5, 0.5, -193.5, 330.5, 0, 0, 696, 723)
	ControlTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ControlTitle:setText(Engine[0xF9F1239CFD921FE](0xEC3279692A4D03E))
	ControlTitle:setTTF("default")
	ControlTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ControlTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ControlTitle)
	self.ControlTitle = ControlTitle
	local Hardpoint = LUI.UIImage.new(0.5, 0.5, -433.5, -193.5, 0, 0, 423, 663)
	Hardpoint:setImage(RegisterImage(0x427C23199BBDE9F))
	self:addElement(Hardpoint)
	self.Hardpoint = Hardpoint
	local HardpointRules = LUI.UIText.new(0.5, 0.5, -193.5, 426.5, 0, 0, 504, 522)
	HardpointRules:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	HardpointRules:setAlpha(0.8)
	HardpointRules:setText(Engine[0xF9F1239CFD921FE](0xC70A8C6C93F10AE))
	HardpointRules:setTTF("dinnext_regular")
	HardpointRules:setLetterSpacing(1)
	HardpointRules:setLineSpacing(2)
	HardpointRules:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HardpointRules:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(HardpointRules)
	self.HardpointRules = HardpointRules
	local HardpointTitle = LUI.UIText.new(0.5, 0.5, -193.5, 330.5, 0, 0, 469, 496)
	HardpointTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	HardpointTitle:setText(Engine[0xF9F1239CFD921FE](0x74D6D89F097A672))
	HardpointTitle:setTTF("default")
	HardpointTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HardpointTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(HardpointTitle)
	self.HardpointTitle = HardpointTitle
	local SearchAndDestroy = LUI.UIImage.new(0.5, 0.5, -433.5, -193.5, 0, 0, 197, 437)
	SearchAndDestroy:setImage(RegisterImage(0xD6533ECA6B3F5DF))
	self:addElement(SearchAndDestroy)
	self.SearchAndDestroy = SearchAndDestroy
	local SearchAndDestroyRules = LUI.UIText.new(0.5, 0.5, -193.5, 426.5, 0, 0, 280, 298)
	SearchAndDestroyRules:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	SearchAndDestroyRules:setAlpha(0.8)
	SearchAndDestroyRules:setText(Engine[0xF9F1239CFD921FE](0x9AAA52DB0FC4E90))
	SearchAndDestroyRules:setTTF("dinnext_regular")
	SearchAndDestroyRules:setLetterSpacing(1)
	SearchAndDestroyRules:setLineSpacing(2)
	SearchAndDestroyRules:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SearchAndDestroyRules:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SearchAndDestroyRules)
	self.SearchAndDestroyRules = SearchAndDestroyRules
	local SearchAndDestroyTitle = LUI.UIText.new(0.5, 0.5, -193.5, 330.5, 0, 0, 245, 272)
	SearchAndDestroyTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	SearchAndDestroyTitle:setText(Engine[0xF9F1239CFD921FE](0x1F403C48EF7B8B4))
	SearchAndDestroyTitle:setTTF("default")
	SearchAndDestroyTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SearchAndDestroyTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SearchAndDestroyTitle)
	self.SearchAndDestroyTitle = SearchAndDestroyTitle
	local ScreenSubTitle = LUI.UIText.new(0.5, 0.5, -400, 400, 0, 0, 183.5, 204.5)
	ScreenSubTitle:setText(Engine[0xF9F1239CFD921FE](0xDCA39A7569B2F75))
	ScreenSubTitle:setTTF("ttmussels_regular")
	ScreenSubTitle:setLetterSpacing(1)
	ScreenSubTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ScreenSubTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ScreenSubTitle)
	self.ScreenSubTitle = ScreenSubTitle
	local ScreenTitle = LUI.UIText.new(0.5, 0.5, -450, 450, 0, 0, 129.5, 165.5)
	ScreenTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ScreenTitle:setText(Engine[0xF9F1239CFD921FE](0x86B7DE6FDD7CEB8))
	ScreenTitle:setTTF("ttmussels_demibold")
	ScreenTitle:setLetterSpacing(6)
	ScreenTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ScreenTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ScreenTitle)
	self.ScreenTitle = ScreenTitle
	local DividerLine2 = LUI.UIImage.new(0.5, 0.5, -497.5, 496.5, 0, 0, 659, 663)
	DividerLine2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DividerLine2:setAlpha(0.2)
	DividerLine2:setImage(RegisterImage(0xB20AD7A31239369))
	DividerLine2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	DividerLine2:setShaderVector(0, 0, 0, 0, 0)
	DividerLine2:setupNineSliceShader(16, 4)
	self:addElement(DividerLine2)
	self.DividerLine2 = DividerLine2
	local DividerLine1 = LUI.UIImage.new(0.5, 0.5, -497.5, 496.5, 0, 0, 421, 425)
	DividerLine1:setAlpha(0.2)
	DividerLine1:setImage(RegisterImage(0xB20AD7A31239369))
	DividerLine1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	DividerLine1:setShaderVector(0, 0, 0, 0, 0)
	DividerLine1:setupNineSliceShader(16, 4)
	self:addElement(DividerLine1)
	self.DividerLine1 = DividerLine1
	self:mergeStateConditions({
		{
			stateName = "DefaultStatePC",
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
CoD.LeaguePlayGameModeRules.__resetProperties = function(f7_arg0)
	f7_arg0.BackgroundTop:completeAnimation()
	f7_arg0.Control:completeAnimation()
	f7_arg0.ControlRules:completeAnimation()
	f7_arg0.ControlTitle:completeAnimation()
	f7_arg0.Hardpoint:completeAnimation()
	f7_arg0.HardpointRules:completeAnimation()
	f7_arg0.HardpointTitle:completeAnimation()
	f7_arg0.SearchAndDestroy:completeAnimation()
	f7_arg0.SearchAndDestroyRules:completeAnimation()
	f7_arg0.SearchAndDestroyTitle:completeAnimation()
	f7_arg0.ScreenSubTitle:completeAnimation()
	f7_arg0.ScreenTitle:completeAnimation()
	f7_arg0.DividerLine2:completeAnimation()
	f7_arg0.DividerLine1:completeAnimation()
	f7_arg0.BGDotPatternTop:completeAnimation()
	f7_arg0.BackgroundTop:setLeftRight(0.5, 0.5, -497, 497)
	f7_arg0.BackgroundTop:setTopBottom(0, 0, 113, 172)
	f7_arg0.Control:setTopBottom(0, 0, 648, 888)
	f7_arg0.ControlRules:setTopBottom(0, 0, 731, 749)
	f7_arg0.ControlTitle:setTopBottom(0, 0, 696, 723)
	f7_arg0.Hardpoint:setTopBottom(0, 0, 423, 663)
	f7_arg0.HardpointRules:setTopBottom(0, 0, 504, 522)
	f7_arg0.HardpointTitle:setTopBottom(0, 0, 469, 496)
	f7_arg0.SearchAndDestroy:setTopBottom(0, 0, 197, 437)
	f7_arg0.SearchAndDestroyRules:setTopBottom(0, 0, 280, 298)
	f7_arg0.SearchAndDestroyTitle:setTopBottom(0, 0, 245, 272)
	f7_arg0.ScreenSubTitle:setTopBottom(0, 0, 183.5, 204.5)
	f7_arg0.ScreenTitle:setTopBottom(0, 0, 129.5, 165.5)
	f7_arg0.DividerLine2:setTopBottom(0, 0, 659, 663)
	f7_arg0.DividerLine1:setTopBottom(0, 0, 421, 425)
	f7_arg0.BGDotPatternTop:setTopBottom(0, 0, 112, 171)
end
CoD.LeaguePlayGameModeRules.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(15)
			f9_arg0.BackgroundTop:completeAnimation()
			f9_arg0.BackgroundTop:setLeftRight(0.5, 0.5, -500, 500)
			f9_arg0.BackgroundTop:setTopBottom(0, 0, 85, 147)
			f9_arg0.clipFinished(f9_arg0.BackgroundTop)
			f9_arg0.BGDotPatternTop:completeAnimation()
			f9_arg0.BGDotPatternTop:setTopBottom(0, 0, 87, 146)
			f9_arg0.clipFinished(f9_arg0.BGDotPatternTop)
			f9_arg0.Control:completeAnimation()
			f9_arg0.Control:setTopBottom(0, 0, 623, 863)
			f9_arg0.clipFinished(f9_arg0.Control)
			f9_arg0.ControlRules:completeAnimation()
			f9_arg0.ControlRules:setTopBottom(0, 0, 706, 724)
			f9_arg0.clipFinished(f9_arg0.ControlRules)
			f9_arg0.ControlTitle:completeAnimation()
			f9_arg0.ControlTitle:setTopBottom(0, 0, 671, 698)
			f9_arg0.clipFinished(f9_arg0.ControlTitle)
			f9_arg0.Hardpoint:completeAnimation()
			f9_arg0.Hardpoint:setTopBottom(0, 0, 398, 638)
			f9_arg0.clipFinished(f9_arg0.Hardpoint)
			f9_arg0.HardpointRules:completeAnimation()
			f9_arg0.HardpointRules:setTopBottom(0, 0, 479, 497)
			f9_arg0.clipFinished(f9_arg0.HardpointRules)
			f9_arg0.HardpointTitle:completeAnimation()
			f9_arg0.HardpointTitle:setTopBottom(0, 0, 444, 471)
			f9_arg0.clipFinished(f9_arg0.HardpointTitle)
			f9_arg0.SearchAndDestroy:completeAnimation()
			f9_arg0.SearchAndDestroy:setTopBottom(0, 0, 172, 412)
			f9_arg0.clipFinished(f9_arg0.SearchAndDestroy)
			f9_arg0.SearchAndDestroyRules:completeAnimation()
			f9_arg0.SearchAndDestroyRules:setTopBottom(0, 0, 255, 273)
			f9_arg0.clipFinished(f9_arg0.SearchAndDestroyRules)
			f9_arg0.SearchAndDestroyTitle:completeAnimation()
			f9_arg0.SearchAndDestroyTitle:setTopBottom(0, 0, 220, 247)
			f9_arg0.clipFinished(f9_arg0.SearchAndDestroyTitle)
			f9_arg0.ScreenSubTitle:completeAnimation()
			f9_arg0.ScreenSubTitle:setTopBottom(0, 0, 158, 179)
			f9_arg0.clipFinished(f9_arg0.ScreenSubTitle)
			f9_arg0.ScreenTitle:completeAnimation()
			f9_arg0.ScreenTitle:setTopBottom(0, 0, 104, 140)
			f9_arg0.clipFinished(f9_arg0.ScreenTitle)
			f9_arg0.DividerLine2:completeAnimation()
			f9_arg0.DividerLine2:setTopBottom(0, 0, 634, 638)
			f9_arg0.clipFinished(f9_arg0.DividerLine2)
			f9_arg0.DividerLine1:completeAnimation()
			f9_arg0.DividerLine1:setTopBottom(0, 0, 396, 400)
			f9_arg0.clipFinished(f9_arg0.DividerLine1)
		end,
	},
}
CoD.LeaguePlayGameModeRules.__onClose = function(f10_arg0)
	f10_arg0.LeaguePlayRulesPopup:close()
end
