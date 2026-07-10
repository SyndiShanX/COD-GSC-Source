require("x64:ce1e6b6549d478c")
require("x64:2e696224b0060b4")
require("x64:b3acf028e6f3cc1")
require("x64:a24b28b508f6914")
require("x64:3dd43113c4e1bd6")
require("x64:f027dcc6409e42c")
CoD.FTUEWZProgressionMenu = InheritFrom(CoD.Menu)
LUI.createMenu.FTUEWZProgressionMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FTUEWZProgressionMenu", f1_arg0)
	local f1_local1 = self
	EnableAnyController(self, f1_arg0)
	self:setClass(CoD.FTUEWZProgressionMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local StartMenuBackground = CoD.StartMenu_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	StartMenuBackground:setAlpha(0)
	self:addElement(StartMenuBackground)
	self.StartMenuBackground = StartMenuBackground
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local Echelon20Info = CoD.FTUEWZProgressionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -812, -535, 0, 0, 110.5, 410.5)
	Echelon20Info.EchelonImage:setImage(RegisterImage(@"ui_icon_rank_wz_level20_large"))
	Echelon20Info.EchelonTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7FB86910F7D83FB0"))
	Echelon20Info.EchelonIndex:setText(LocalizeStringWithParameter(@"hash_2294790D215078A9", 20))
	self:addElement(Echelon20Info)
	self.Echelon20Info = Echelon20Info
	local Echelon40Info = CoD.FTUEWZProgressionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -529.5, -252.5, 0, 0, 110.5, 410.5)
	Echelon40Info.EchelonImage:setImage(RegisterImage(@"ui_icon_rank_wz_level40_large"))
	Echelon40Info.EchelonTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_12EC236168355FDA"))
	Echelon40Info.EchelonIndex:setText(LocalizeStringWithParameter(@"hash_2294790D215078A9", 40))
	self:addElement(Echelon40Info)
	self.Echelon40Info = Echelon40Info
	local Echelon60Info = CoD.FTUEWZProgressionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 30, 0, 0, 110.5, 410.5)
	Echelon60Info.EchelonImage:setImage(RegisterImage(@"ui_icon_rank_wz_level60_large"))
	Echelon60Info.EchelonTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](0x1D7F974E549B8C))
	Echelon60Info.EchelonIndex:setText(LocalizeStringWithParameter(@"hash_2294790D215078A9", 60))
	self:addElement(Echelon60Info)
	self.Echelon60Info = Echelon60Info
	local Echelon80Info = CoD.FTUEWZProgressionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 36, 313, 0, 0, 110.5, 410.5)
	Echelon80Info.EchelonImage:setImage(RegisterImage(@"ui_icon_rank_wz_level80_large"))
	Echelon80Info.EchelonTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1A3A998EB2BFD676"))
	Echelon80Info.EchelonIndex:setText(LocalizeStringWithParameter(@"hash_2294790D215078A9", 80))
	self:addElement(Echelon80Info)
	self.Echelon80Info = Echelon80Info
	local LargeEchelon = CoD.FTUEWZProgressionLargeWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 350, 850, 0, 0, 110.5, 910.5)
	self:addElement(LargeEchelon)
	self.LargeEchelon = LargeEchelon
	local Title = LUI.UIText.new(0.5, 0.5, -812, 305, 0, 0, 483, 548)
	Title:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Title:setText(LocalizeToUpperString(@"hash_34E8C73AFA2FDB01"))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(Title)
	self.Title = Title
	local DescriptionTextBox = LUI.UIText.new(0.5, 0.5, -812, 305, 0, 0, 548, 570)
	DescriptionTextBox:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DescriptionTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BD47EE0FD8A55FB"))
	DescriptionTextBox:setTTF("dinnext_regular")
	DescriptionTextBox:setLineSpacing(5)
	DescriptionTextBox:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	DescriptionTextBox:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(DescriptionTextBox)
	self.DescriptionTextBox = DescriptionTextBox
	local PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, -812, -572, 0.3, 0.3, 506.5, 586.5)
	PCButton.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
	PCButton:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PCButton.Icon:setImage(RegisterImage(f3_local0))
		end
	end)
	PCButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_local1, f1_arg0, 0.5, 0.5, 752, 850, 0, 0, 84.5, 96.5)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local dotline2 = LUI.UIImage.new(0.5, 0.5, -811, 313, 0, 0, 448, 452)
	dotline2:setAlpha(0.25)
	dotline2:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline2:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline2)
	self.dotline2 = dotline2
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		PCButton.id = "PCButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local16 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.FTUEWZProgressionMenu.__onClose = function(f9_arg0)
	f9_arg0.StartMenuBackground:close()
	f9_arg0.FooterContainerFrontendRight:close()
	f9_arg0.Echelon20Info:close()
	f9_arg0.Echelon40Info:close()
	f9_arg0.Echelon60Info:close()
	f9_arg0.Echelon80Info:close()
	f9_arg0.LargeEchelon:close()
	f9_arg0.PCButton:close()
	f9_arg0.TabbedScoreboardFuiBox:close()
end
