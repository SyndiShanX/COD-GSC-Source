require("x64:eda152e1d10147a")
require("x64:d6ecdf7755aeddc")
require("x64:71d2a0ed724628e")
require("x64:510c74f677603f0")
require("x64:e9cfc3cb5356fa5")
require("x64:e41af73729601d6")
require("x64:277c80b335b601")
require("x64:6ac3810d0729f5")
require("x64:e87da06c6cbb22")
require("x64:8ad6caf7657a396")
require("x64:c1b8e8afdaf81b9")
require("x64:eeba179b3edce79")
require("x64:7889ce1e3e2e8a")
require("x64:a9255c570c68aa8")
require("x64:ba72b08fda6493")
require("x64:9e9198b8b1a81d5")
CoD.Leaderboards_PlayersList = InheritFrom(CoD.Menu)
LUI.createMenu.Leaderboards_PlayersList = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Leaderboards_PlayersList", f1_arg0)
	local f1_local1 = self
	CoD.SocialUtility.ClearCheckedInvitees()
	CoD.SocialUtility.PushCurrentSocialTab(f1_local1)
	CoD.BaseUtility.CreateGlobalModel("socialRoot.showPlayersList")
	CoD.LeaderboardUtility.InitPlayersListState()
	self:setClass(CoD.Leaderboards_PlayersList)
	self.soundSet = "FriendsMenu"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local tabs = CoD.CommonTabBar.new(f1_local1, f1_arg0, 0.5, 0.5, -1822, 1450, 0.5, 0.5, -405, -343)
	tabs:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.showPlayersList", true)
			end,
		},
	})
	local NoiseTiledBacking = tabs
	local EmptyPlaylistFrame = tabs.subscribeToModel
	local SelectedCount = Engine[@"getglobalmodel"]()
	EmptyPlaylistFrame(NoiseTiledBacking, SelectedCount["socialRoot.showPlayersList"], function(f3_arg0)
		f1_local1:updateElementState(tabs, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "socialRoot.showPlayersList",
		})
	end, false)
	tabs.Tabs.grid:setWidgetType(CoD.CommonTab)
	tabs.Tabs.grid:setDataSource("PlayersListTabs")
	tabs:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		SetSocialTab(self, element, f1_arg0)
		FetchOnlineFriendsData(self, element, f1_arg0)
		PlaySoundSetSound(self, "tab_changed")
		return f4_local0
	end)
	self:addElement(tabs)
	self.tabs = tabs
	EmptyPlaylistFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -445.5, 68.5, 0.5, 0.5, -344.5, 321.5)
	EmptyPlaylistFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmptyPlaylistFrame:setAlpha(0)
	self:addElement(EmptyPlaylistFrame)
	self.EmptyPlaylistFrame = EmptyPlaylistFrame
	NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -444.5, 67.5, 0.5, 0.5, -345, 322)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	SelectedCount = LUI.UIText.new(0.5, 0.5, 93, 396, 0.5, 0.5, -202, -148)
	SelectedCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectedCount:setTTF("0arame_mono_stencil")
	SelectedCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SelectedCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SelectedCount:subscribeToGlobalModel(f1_arg0, "SocialRoot", "selectedCount", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SelectedCount:setText(f5_local0)
		end
	end)
	self:addElement(SelectedCount)
	self.SelectedCount = SelectedCount
	local SelectedCountTitle = LUI.UIText.new(0.5, 0.5, 93, 396, 0.5, 0.5, -227, -205)
	SelectedCountTitle:setAlpha(0.7)
	SelectedCountTitle:setText(LocalizeToUpperString(@"menu/selected"))
	SelectedCountTitle:setTTF("ttmussels_regular")
	SelectedCountTitle:setLetterSpacing(4)
	SelectedCountTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SelectedCountTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SelectedCountTitle)
	self.SelectedCountTitle = SelectedCountTitle
	local noPlayersText = LUI.UIText.new(0.5, 0.5, -445.5, 68.5, 0.5, 0.5, -12.5, 12.5)
	noPlayersText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	noPlayersText:setAlpha(0)
	noPlayersText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6E00774FA3F4A55D"))
	noPlayersText:setTTF("ttmussels_regular")
	noPlayersText:setLetterSpacing(2)
	noPlayersText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	noPlayersText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(noPlayersText)
	self.noPlayersText = noPlayersText
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/players_list"))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 360, 394, 0.5, 0.5, -65.5, -31.5)
	BTNQuit:setAlpha(0)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(BTNQuit, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	local PCSimpleVScrollList = nil
	PCSimpleVScrollList = CoD.PC_SimpleVScrollList.new(f1_local1, f1_arg0, 0.5, 0.5, -446.5, 67.5, 0.5, 0.5, -344, 290)
	PCSimpleVScrollList.ScrollView.View:setWidgetType(CoD.Social_PlayersListButtonWithCheckbox)
	PCSimpleVScrollList.ScrollView.View:setVerticalCount(AddWithoutPreview(0, 12))
	PCSimpleVScrollList.ScrollView.View:setSpacing(14)
	PCSimpleVScrollList.ScrollView.View:setDataSource("SocialPlayersList")
	PCSimpleVScrollList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f10_local0 = nil
		CacheSocialOnlinePlayersListModels(self, element, f1_arg0)
		CopyModelFindElement(f1_local1, f1_arg0, element, "Header")
		PlaySoundAlias("uin_paint_decal_nav")
		return f10_local0
	end)
	PCSimpleVScrollList:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCSimpleVScrollList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.SocialUtility.ToggleAddCheckbox(controller, element)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(PCSimpleVScrollList)
	self.PCSimpleVScrollList = PCSimpleVScrollList
	local f1_local12 = nil
	f1_local12 = LUI.UIElement.createFake()
	self.playersList = f1_local12
	local ActionButton = CoD.PlayersListActionButton.new(f1_local1, f1_arg0, 0.5, 0.5, 95, 398, 0.5, 0.5, -344.5, -252.5)
	ActionButton:mergeStateConditions({
		{
			stateName = "AddPlayers",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList")
			end,
		},
		{
			stateName = "RemovePlayers",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList")
			end,
		},
	})
	local HeaderStripe = ActionButton
	local PlayerListFullText = ActionButton.subscribeToModel
	local CommonHeader = Engine[@"getglobalmodel"]()
	PlayerListFullText(HeaderStripe, CommonHeader["socialRoot.showPlayersList"], function(f16_arg0)
		f1_local1:updateElementState(ActionButton, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "socialRoot.showPlayersList",
		})
	end, false)
	HeaderStripe = ActionButton
	PlayerListFullText = ActionButton.subscribeToModel
	CommonHeader = Engine[@"getglobalmodel"]()
	PlayerListFullText(HeaderStripe, CommonHeader["socialRoot.showPlayersList"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ActionButton:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f18_local0
	end)
	f1_local1:AddButtonCallbackFunction(ActionButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.SocialUtility.AddPlayers(controller)
			CoD.SocialUtility.ClearCheckedInvitees()
			ForceNotifyGlobalModel(controller, "socialRoot.tab")
			PlaySoundSetSound(self, "list_action")
			return true
		elseif CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.SocialUtility.RemovePlayers(controller)
			CoD.SocialUtility.ClearCheckedInvitees()
			ForceNotifyGlobalModel(controller, "socialRoot.tab")
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, nil)
			return true
		elseif CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(ActionButton)
	self.ActionButton = ActionButton
	PlayerListFullText = LUI.UIText.new(0.5, 0.5, 93, 396, 0.5, 0.5, -78, -53)
	PlayerListFullText:setRGB(ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b)
	PlayerListFullText:setAlpha(0)
	PlayerListFullText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_C52261C65F3EF0F"))
	PlayerListFullText:setTTF("dinnext_regular")
	PlayerListFullText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayerListFullText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayerListFullText)
	self.PlayerListFullText = PlayerListFullText
	HeaderStripe = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0.5, 1.5, -960, -960, 0, 0, 0, 42)
	HeaderStripe:setAlpha(0)
	HeaderStripe:registerEventHandler("menu_loaded", function(element, event)
		local f21_local0 = nil
		if element.menuLoaded then
			f21_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f21_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		elseif IsPC() then
			SizeToWidthOfScreen(element, f1_arg0)
		end
		if not f21_local0 then
			f21_local0 = element:dispatchEventToChildren(event)
		end
		return f21_local0
	end)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 1.5, -960, -960, 0, 0, 0, 67)
	CommonHeader:setAlpha(0)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/players_list"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f22_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f23_local0 = nil
		if element.menuLoaded then
			f23_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f23_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f23_local0 then
			f23_local0 = element:dispatchEventToChildren(event)
		end
		return f23_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local PlaylistButton = CoD.LeaderboardListButton.new(f1_local1, f1_arg0, 0.5, 0.5, -773, -470, 0.5, 0.5, -343, -251)
	PlaylistButton.CommonListButtonShortInternal.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/players_list"))
	local f1_local18 = PlaylistButton
	local AddPlayerButton = PlaylistButton.subscribeToModel
	local PlayerInfoPanePC = Engine[@"getglobalmodel"]()
	AddPlayerButton(f1_local18, PlayerInfoPanePC["socialRoot.showPlayersList"], function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PlaylistButton:registerEventHandler("gain_focus", function(element, event)
		local f25_local0 = nil
		if element.gainFocus then
			f25_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f25_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f25_local0
	end)
	f1_local1:AddButtonCallbackFunction(PlaylistButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.SocialUtility.ClearCheckedInvitees()
			SetGlobalModelValueTrue("socialRoot.showPlayersList")
			PlaySoundSetSound(self, "tab_changed")
			ForceNotifyGlobalModel(controller, "socialRoot.tab")
			ForceNotifyGlobalModel(controller, "socialRoot.showPlayersList")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(PlaylistButton)
	self.PlaylistButton = PlaylistButton
	AddPlayerButton = CoD.LeaderboardListButton.new(f1_local1, f1_arg0, 0.5, 0.5, -773, -470, 0.5, 0.5, -235.5, -143.5)
	AddPlayerButton.CommonListButtonShortInternal.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/add_players"))
	PlayerInfoPanePC = AddPlayerButton
	f1_local18 = AddPlayerButton.subscribeToModel
	local AutoAddFriendsButton = Engine[@"getglobalmodel"]()
	f1_local18(PlayerInfoPanePC, AutoAddFriendsButton["socialRoot.showPlayersList"], function(f28_arg0, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	AddPlayerButton:registerEventHandler("gain_focus", function(element, event)
		local f29_local0 = nil
		if element.gainFocus then
			f29_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f29_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f29_local0
	end)
	f1_local1:AddButtonCallbackFunction(AddPlayerButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.SocialUtility.ClearCheckedInvitees()
			SetGlobalModelValueFalse("socialRoot.showPlayersList")
			PlaySoundSetSound(self, "tab_changed")
			ForceNotifyGlobalModel(controller, "socialRoot.tab")
			ForceNotifyGlobalModel(controller, "socialRoot.showPlayersList")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(AddPlayerButton)
	self.AddPlayerButton = AddPlayerButton
	f1_local18 = nil
	f1_local18 = LUI.UIElement.createFake()
	self.PlayerInfoPane = f1_local18
	PlayerInfoPanePC = nil
	PlayerInfoPanePC = CoD.Social_InfoPaneLeft.new(f1_local1, f1_arg0, 0.5, 0.5, 421, 881, 0.5, 0.5, -374, 367)
	self:addElement(PlayerInfoPanePC)
	self.PlayerInfoPanePC = PlayerInfoPanePC
	AutoAddFriendsButton = CoD.AutoAddFriendsButton.new(f1_local1, f1_arg0, 0.5, 0.5, -773, -470, 0.5, 0.5, -128, -36)
	self:addElement(AutoAddFriendsButton)
	self.AutoAddFriendsButton = AutoAddFriendsButton
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f32_local0 = nil
		if element.menuLoaded then
			f32_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f32_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f32_local0 then
			f32_local0 = element:dispatchEventToChildren(event)
		end
		return f32_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	local PlayersListCountandMax = CoD.PlayersListCountandMax.new(f1_local1, f1_arg0, 0.5, 0.5, 96, 394, 0.5, 0.5, -131, -110)
	self:addElement(PlayersListCountandMax)
	self.PlayersListCountandMax = PlayersListCountandMax
	f1_local18:linkToElementModel(f1_local12, nil, false, function(model)
		f1_local18:setModel(model, f1_arg0)
	end)
	PlayerInfoPanePC:linkToElementModel(PCSimpleVScrollList.ScrollView.View, nil, false, function(model)
		PlayerInfoPanePC:setModel(model, f1_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "PlayersListFull",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.playersListFull")
			end,
		},
		{
			stateName = "NoPlayersOnline",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg0, "SocialRoot", "visibleCount", 0) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.showPlayersList", true)
			end,
		},
		{
			stateName = "ViewPlayersList",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.showPlayersList", true) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg0, "SocialRoot", "visibleCount", 0)
			end,
		},
		{
			stateName = "EmptyPlayersList",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg0, "SocialRoot", "visibleCount", 0) and CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.showPlayersList", true)
			end,
		},
	})
	local f1_local24 = self
	local f1_local25 = self.subscribeToModel
	local f1_local26 = Engine[@"getglobalmodel"]()
	f1_local25(f1_local24, f1_local26["socialRoot.playersListFull"], function(f39_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f39_arg0:get(),
			modelName = "socialRoot.playersListFull",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = DataSources.SocialRoot.getModel(f1_arg0)
	f1_local25(f1_local24, f1_local26.visibleCount, function(f40_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f40_arg0:get(),
			modelName = "visibleCount",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getglobalmodel"]()
	f1_local25(f1_local24, f1_local26["socialRoot.showPlayersList"], function(f41_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f41_arg0:get(),
			modelName = "socialRoot.showPlayersList",
		})
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f42_local0 = nil
		if self.menuLoaded then
			f42_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f42_local0 = self.super:menuLoaded(event)
		end
		if not IsPC() then
			SetGlobalModelValueTrue("socialRoot.showPlayersList")
			CoD.FreeCursorUtility.AddLockedFocusLeftOrRightNavigation(f1_local1, f1_arg0, self.playersList, self.ActionButton)
		end
		if not f42_local0 then
			f42_local0 = self:dispatchEventToChildren(event)
		end
		return f42_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetGlobalModelValueFalse("socialRoot.showPlayersList")
		CoD.SocialUtility.PopCurrentSocialTab(f1_local1)
	end)
	tabs.id = "tabs"
	GenericMenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	if CoD.isPC then
		PCSimpleVScrollList.id = "PCSimpleVScrollList"
	end
	f1_local12.id = "playersList"
	ActionButton.id = "ActionButton"
	PlaylistButton.id = "PlaylistButton"
	AddPlayerButton.id = "AddPlayerButton"
	f1_local18.id = "PlayerInfoPane"
	if CoD.isPC then
		PlayerInfoPanePC.id = "PlayerInfoPanePC"
	end
	AutoAddFriendsButton.id = "AutoAddFriendsButton"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = GenericMenuFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local25 = self
	f1_local25 = PCSimpleVScrollList
	if IsPC() then
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local25, self.ActionButton)
	end
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local12, self.ActionButton)
	return self
end
CoD.Leaderboards_PlayersList.__resetProperties = function(f46_arg0)
	f46_arg0.PlayerListFullText:completeAnimation()
	f46_arg0.PCSimpleVScrollList:completeAnimation()
	f46_arg0.noPlayersText:completeAnimation()
	f46_arg0.EmptyPlaylistFrame:completeAnimation()
	f46_arg0.NoiseTiledBacking:completeAnimation()
	f46_arg0.PlayerInfoPanePC:completeAnimation()
	f46_arg0.PlayerInfoPane:completeAnimation()
	f46_arg0.playersList:completeAnimation()
	f46_arg0.PlayerListFullText:setAlpha(0)
	f46_arg0.PCSimpleVScrollList:setAlpha(1)
	f46_arg0.noPlayersText:setAlpha(0)
	f46_arg0.EmptyPlaylistFrame:setAlpha(0)
	f46_arg0.NoiseTiledBacking:setAlpha(0)
	f46_arg0.PlayerInfoPanePC:setAlpha(1)
	f46_arg0.PlayerInfoPane:setAlpha(1)
	f46_arg0.playersList:setAlpha(1)
end
CoD.Leaderboards_PlayersList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(0)
		end,
	},
	PlayersListFull = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(1)
			f48_arg0.PlayerListFullText:completeAnimation()
			f48_arg0.PlayerListFullText:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.PlayerListFullText)
		end,
	},
	NoPlayersOnline = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(5)
			f49_arg0.EmptyPlaylistFrame:completeAnimation()
			f49_arg0.EmptyPlaylistFrame:setAlpha(0.01)
			f49_arg0.clipFinished(f49_arg0.EmptyPlaylistFrame)
			f49_arg0.NoiseTiledBacking:completeAnimation()
			f49_arg0.NoiseTiledBacking:setAlpha(0.55)
			f49_arg0.clipFinished(f49_arg0.NoiseTiledBacking)
			f49_arg0.noPlayersText:completeAnimation()
			f49_arg0.noPlayersText:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.noPlayersText)
			f49_arg0.PCSimpleVScrollList:completeAnimation()
			f49_arg0.PCSimpleVScrollList:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.PCSimpleVScrollList)
			f49_arg0.PlayerInfoPane:completeAnimation()
			f49_arg0.PlayerInfoPane:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.PlayerInfoPane)
			f49_arg0.PlayerInfoPanePC:completeAnimation()
			f49_arg0.PlayerInfoPanePC:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.PlayerInfoPanePC)
		end,
	},
	ViewPlayersList = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(0)
		end,
	},
	EmptyPlayersList = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(4)
			f51_arg0.EmptyPlaylistFrame:completeAnimation()
			f51_arg0.EmptyPlaylistFrame:setAlpha(0.01)
			f51_arg0.clipFinished(f51_arg0.EmptyPlaylistFrame)
			f51_arg0.NoiseTiledBacking:completeAnimation()
			f51_arg0.NoiseTiledBacking:setAlpha(0.55)
			f51_arg0.clipFinished(f51_arg0.NoiseTiledBacking)
			f51_arg0.noPlayersText:completeAnimation()
			f51_arg0.noPlayersText:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.noPlayersText)
			f51_arg0.playersList:completeAnimation()
			f51_arg0.playersList:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.playersList)
			f51_arg0.PlayerInfoPane:completeAnimation()
			f51_arg0.PlayerInfoPane:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.PlayerInfoPane)
			f51_arg0.PlayerInfoPanePC:completeAnimation()
			f51_arg0.PlayerInfoPanePC:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.PlayerInfoPanePC)
		end,
	},
}
CoD.Leaderboards_PlayersList.__onClose = function(f52_arg0)
	f52_arg0.PlayerInfoPane:close()
	f52_arg0.PlayerInfoPanePC:close()
	f52_arg0.Background:close()
	f52_arg0.tabs:close()
	f52_arg0.EmptyPlaylistFrame:close()
	f52_arg0.SelectedCount:close()
	f52_arg0.GenericMenuFrame:close()
	f52_arg0.BTNQuit:close()
	f52_arg0.PCSimpleVScrollList:close()
	f52_arg0.playersList:close()
	f52_arg0.ActionButton:close()
	f52_arg0.HeaderStripe:close()
	f52_arg0.CommonHeader:close()
	f52_arg0.PlaylistButton:close()
	f52_arg0.AddPlayerButton:close()
	f52_arg0.AutoAddFriendsButton:close()
	f52_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
	f52_arg0.PlayersListCountandMax:close()
end
