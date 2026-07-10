require("x64:ce1e6b6549d478c")
require("x64:a79adf0dbc1a1b6")
require("x64:71c4c59d812255d")
require("x64:a24b28b508f6914")
require("x64:7889ce1e3e2e8a")
CoD.LobbyServerBrowserOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.LobbyServerBrowserOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LobbyServerBrowserOverlay", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LobbyServerBrowserOverlay)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local FooterContainerFrontendRight = nil
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -48, 0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local FooterContainerFrontendRight2 = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight2:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight2)
	self.FooterContainerFrontendRight2 = FooterContainerFrontendRight2
	local LANServerBrowserDetails = CoD.LocalServerRowList.new(f1_local1, f1_arg0, 0.5, 0.5, -800, 800, 0.5, 0.5, -310, 300)
	self:addElement(LANServerBrowserDetails)
	self.LANServerBrowserDetails = LANServerBrowserDetails
	local HeaderBackingL = LUI.UIImage.new(0, 0, 160, 1229, 0, 0, 176, 216)
	HeaderBackingL:setRGB(0, 0, 0)
	HeaderBackingL:setAlpha(0.5)
	self:addElement(HeaderBackingL)
	self.HeaderBackingL = HeaderBackingL
	local HeaderBackingR = LUI.UIImage.new(0, 0, 1244, 1760, 0, 0, 176, 216)
	HeaderBackingR:setRGB(0, 0, 0)
	HeaderBackingR:setAlpha(0.5)
	self:addElement(HeaderBackingR)
	self.HeaderBackingR = HeaderBackingR
	local HostNameText = LUI.UIText.new(0.5, 0.5, -783, -583, 0.5, 0.5, -353.5, -334.5)
	HostNameText:setRGB(0.59, 0.59, 0.59)
	HostNameText:setScale(LanguageOverrideNumber("japanese", 0.75, 1, 1))
	HostNameText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_127B70868F266323"))
	HostNameText:setTTF("ttmussels_regular")
	HostNameText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HostNameText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(HostNameText)
	self.HostNameText = HostNameText
	local PlayerCountText = LUI.UIText.new(0.5, 0.5, -388, -188, 0.5, 0.5, -353, -334)
	PlayerCountText:setRGB(0.59, 0.59, 0.59)
	PlayerCountText:setScale(LanguageOverrideNumber("japanese", 0.75, 1, 1))
	PlayerCountText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6AA5858F1B91378B"))
	PlayerCountText:setTTF("ttmussels_regular")
	PlayerCountText:setLetterSpacing(1)
	PlayerCountText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayerCountText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayerCountText)
	self.PlayerCountText = PlayerCountText
	local GameMode = LUI.UIText.new(0.5, 0.5, -251, -31, 0.5, 0.5, -353.5, -334.5)
	GameMode:setRGB(0.59, 0.59, 0.59)
	GameMode:setScale(LanguageOverrideNumber("japanese", 0.75, 1, 1))
	GameMode:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3EC341CF3D1C0D67"))
	GameMode:setTTF("ttmussels_regular")
	GameMode:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameMode:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GameMode)
	self.GameMode = GameMode
	local StatusTextBox = LUI.UIText.new(0.5, 0.5, 30.5, 250.5, 0.5, 0.5, -353.5, -334.5)
	StatusTextBox:setRGB(0.59, 0.59, 0.59)
	StatusTextBox:setScale(LanguageOverrideNumber("japanese", 0.75, 1, 1))
	StatusTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E20BF67125A4903"))
	StatusTextBox:setTTF("ttmussels_regular")
	StatusTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatusTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StatusTextBox)
	self.StatusTextBox = StatusTextBox
	local DetailsTextBox = LUI.UIText.new(0.5, 0.5, 294, 514, 0.5, 0.5, -353.5, -334.5)
	DetailsTextBox:setRGB(0.59, 0.59, 0.59)
	DetailsTextBox:setScale(LanguageOverrideNumber("japanese", 0.75, 1, 1))
	DetailsTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2871519113740169"))
	DetailsTextBox:setTTF("ttmussels_regular")
	DetailsTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DetailsTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DetailsTextBox)
	self.DetailsTextBox = DetailsTextBox
	local HeaderPixelGridTiledBackingL = LUI.UIImage.new(0.02, 0.02, 127.5, 1196.5, 0.31, 0.31, -160.5, -120.5)
	HeaderPixelGridTiledBackingL:setAlpha(0.15)
	HeaderPixelGridTiledBackingL:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	HeaderPixelGridTiledBackingL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderPixelGridTiledBackingL:setShaderVector(0, 0, 0, 0, 0)
	HeaderPixelGridTiledBackingL:setupNineSliceShader(128, 128)
	self:addElement(HeaderPixelGridTiledBackingL)
	self.HeaderPixelGridTiledBackingL = HeaderPixelGridTiledBackingL
	local HeaderPixelGridTiledBackingR = LUI.UIImage.new(0.02, 0.02, 1211.5, 1727.5, 0.31, 0.31, -160.5, -120.5)
	HeaderPixelGridTiledBackingR:setAlpha(0.15)
	HeaderPixelGridTiledBackingR:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	HeaderPixelGridTiledBackingR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderPixelGridTiledBackingR:setShaderVector(0, 0, 0, 0, 0)
	HeaderPixelGridTiledBackingR:setupNineSliceShader(128, 128)
	self:addElement(HeaderPixelGridTiledBackingR)
	self.HeaderPixelGridTiledBackingR = HeaderPixelGridTiledBackingR
	local CornerPipR = LUI.UIImage.new(0, 0, 1749.5, 1765.5, 0, 0, 830, 846)
	CornerPipR:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CornerPipR:setAlpha(0.25)
	CornerPipR:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPipR)
	self.CornerPipR = CornerPipR
	local CornerPipL = LUI.UIImage.new(0, 0, 155, 171, 0, 0, 830, 846)
	CornerPipL:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CornerPipL:setAlpha(0.25)
	CornerPipL:setYRot(180)
	CornerPipL:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPipL)
	self.CornerPipL = CornerPipL
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_local1, f1_arg0, 0, 0, 1645.5, 1757.5, 0, 0, 854, 870)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local SafeAreaContainerLobbyServerBrwoserOverlay = CoD.SafeAreaContainer_LobbyServerBrwoserOverlay.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	SafeAreaContainerLobbyServerBrwoserOverlay:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(SafeAreaContainerLobbyServerBrwoserOverlay)
	self.SafeAreaContainerLobbyServerBrwoserOverlay = SafeAreaContainerLobbyServerBrwoserOverlay
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"mp/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		RefreshServerList(self, controller)
		PlaySoundAlias("uin_paint_image_flip_toggle")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_3864802EE42E1E92", nil, nil)
		return true
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	FooterContainerFrontendRight2:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight2.id = "FooterContainerFrontendRight2"
	end
	LANServerBrowserDetails.id = "LANServerBrowserDetails"
	SafeAreaContainerLobbyServerBrwoserOverlay.id = "SafeAreaContainerLobbyServerBrwoserOverlay"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local19 = self
	RefreshServerList(self, f1_arg0)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.LobbyServerBrowserOverlay.__onClose = function(f8_arg0)
	f8_arg0.Background:close()
	f8_arg0.FooterContainerFrontendRight:close()
	f8_arg0.FooterContainerFrontendRight2:close()
	f8_arg0.LANServerBrowserDetails:close()
	f8_arg0.TabbedScoreboardFuiBox:close()
	f8_arg0.SafeAreaContainerLobbyServerBrwoserOverlay:close()
end
