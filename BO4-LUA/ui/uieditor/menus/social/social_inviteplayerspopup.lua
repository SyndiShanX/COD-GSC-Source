require("x64:f315f285d876794")
require("x64:3507fa8399fe49")
require("x64:e9cfc3cb5356fa5")
require("x64:d7ba7c36104672")
require("x64:38c11a77e96e48c")
require("x64:e930ac5578a8d6e")
require("x64:eeba179b3edce79")
require("x64:ba72b08fda6493")
require("x64:9e9198b8b1a81d5")
require("x64:c829ac7d797ba4c")
CoD.Social_InvitePlayersPopup = InheritFrom(CoD.Menu)
LUI.createMenu.Social_InvitePlayersPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Social_InvitePlayersPopup", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.SocialUtility.ClearCheckedInvitees()
	CoD.SocialUtility.PushCurrentSocialTab(f1_local1)
	self:setClass(CoD.Social_InvitePlayersPopup)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlackBacking:setShaderVector(0, 0, 0.75, 0, 0)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local Background = LUI.UIImage.new(0.5, 0.5, -472, 472, 0, 0, 40, 1040)
	Background:setRGB(0.09, 0.09, 0.09)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local Container = LUI.UIImage.new(0.5, 0.5, -460, 460, 0, 0, 117, 309)
	Container:setRGB(0.23, 0.23, 0.23)
	Container:setAlpha(0.25)
	self:addElement(Container)
	self.Container = Container
	local TiledBacking = LUI.UIImage.new(0.5, 0.5, -471.5, 471.5, 0.06, 0.06, -29, 971)
	TiledBacking:setAlpha(0.25)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local TiledBacking2 = LUI.UIImage.new(0.5, 0.5, -460, 460, 0.06, 0.06, 0.5, 29.5)
	TiledBacking2:setAlpha(0.5)
	TiledBacking2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking2)
	self.TiledBacking2 = TiledBacking2
	local f1_local7 = nil
	f1_local7 = LUI.UIElement.createFake()
	self.onlineList = f1_local7
	local tabs = CoD.CommonTabBar.new(f1_local1, f1_arg0, 0.5, 0.5, -1802.5, 1497.5, 0, 0, 337.5, 399.5)
	tabs.Tabs.grid:setFilter(function(f2_arg0)
		return f2_arg0.showInQuickInvite:get() == true
	end)
	tabs.Tabs.grid:setDataSource("SocialTabs")
	tabs:registerEventHandler("list_active_changed", function(element, event)
		local f3_local0 = nil
		SetSocialTab(self, element, f1_arg0)
		FetchOnlineFriendsData(self, element, f1_arg0)
		PlaySoundSetSound(self, "tab_changed")
		UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
		return f3_local0
	end)
	self:addElement(tabs)
	self.tabs = tabs
	local Bar = LUI.UIImage.new(0.5, 0.5, -460, 460, 0, 0, 69.5, 97.5)
	Bar:setRGB(0.25, 0.24, 0.22)
	Bar:setAlpha(0.88)
	self:addElement(Bar)
	self.Bar = Bar
	local InvitePlayersText = LUI.UIText.new(0.5, 0.5, -460.5, 460.5, 0, 0, 72, 96)
	InvitePlayersText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	InvitePlayersText:setAlpha(0.6)
	InvitePlayersText:setText(LocalizeToUpperString(@"hash_C4EB9FE5F09A2E7"))
	InvitePlayersText:setTTF("ttmussels_regular")
	InvitePlayersText:setLetterSpacing(4)
	InvitePlayersText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	InvitePlayersText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(InvitePlayersText)
	self.InvitePlayersText = InvitePlayersText
	local SendInvitesButton = CoD.CommonListButtonShort.new(f1_local1, f1_arg0, 0.5, 0.5, 211.5, 451.5, 0, 0, 409.5, 501.5)
	SendInvitesButton.Title:setText(LocalizeToUpperString(@"hash_14B2046A85ED2600"))
	SendInvitesButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(SendInvitesButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsPC() then
			CoD.SocialUtility.SendInvites(self, controller)
			GoBack(self, controller)
			return true
		elseif IsPC() then
			CoD.SocialUtility.SendInvites(self, controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ui_confirm")
			return true
		elseif IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(SendInvitesButton)
	self.SendInvitesButton = SendInvitesButton
	local SelectedCount = LUI.UIText.new(0.5, 0.5, 233, 433, 0, 0, 549, 603)
	SelectedCount:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	SelectedCount:setTTF("0arame_mono_stencil")
	SelectedCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SelectedCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SelectedCount:subscribeToGlobalModel(f1_arg0, "SocialRoot", "selectedCount", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SelectedCount:setText(f7_local0)
		end
	end)
	self:addElement(SelectedCount)
	self.SelectedCount = SelectedCount
	local SelectedCount2 = LUI.UIText.new(0.5, 0.5, 233, 433, 0, 0, 522, 547)
	SelectedCount2:setAlpha(0.7)
	SelectedCount2:setText(LocalizeToUpperString(@"menu/selected"))
	SelectedCount2:setTTF("ttmussels_regular")
	SelectedCount2:setLetterSpacing(4)
	SelectedCount2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SelectedCount2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SelectedCount2)
	self.SelectedCount2 = SelectedCount2
	local noPlayersOnlineText = LUI.UIText.new(0.5, 0.5, -402.5, 115.5, 0, 0, 412.5, 449.5)
	noPlayersOnlineText:setAlpha(0)
	noPlayersOnlineText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_765A2CB730C7F61D"))
	noPlayersOnlineText:setTTF("ttmussels_regular")
	noPlayersOnlineText:setLetterSpacing(2)
	noPlayersOnlineText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	noPlayersOnlineText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(noPlayersOnlineText)
	self.noPlayersOnlineText = noPlayersOnlineText
	local LayoutTopBar = LUI.UIImage.new(0.5, 0.5, -473, 473, 0, 0, 40, 68)
	LayoutTopBar:setImage(RegisterImage(@"uie_ui_menu_social_popup_menu_bar"))
	self:addElement(LayoutTopBar)
	self.LayoutTopBar = LayoutTopBar
	local LayoutTopBar2 = LUI.UIImage.new(0.5, 0.5, -473, 473, 0, 0, 1012, 1040)
	LayoutTopBar2:setZRot(180)
	LayoutTopBar2:setImage(RegisterImage(@"uie_ui_menu_social_popup_menu_bar"))
	self:addElement(LayoutTopBar2)
	self.LayoutTopBar2 = LayoutTopBar2
	local Stripes = LUI.UIImage.new(0.5, 0.5, -471.5, 471.5, 0, 0, 39, 55)
	Stripes:setImage(RegisterImage(@"uie_ui_menu_social_bar_stripe"))
	self:addElement(Stripes)
	self.Stripes = Stripes
	local Linker = LUI.UIImage.new(0.5, 0.5, -4, 0, 0, 0, -350.5, 574.5)
	Linker:setAlpha(0.09)
	Linker:setZRot(90)
	Linker:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local Linker2 = LUI.UIImage.new(0.5, 0.5, -4, 0, 0, 0, -148.5, 776.5)
	Linker2:setAlpha(0.09)
	Linker2:setZRot(90)
	Linker2:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Linker2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Linker2:setShaderVector(0, 0, 0, 0, 0)
	Linker2:setupNineSliceShader(4, 8)
	self:addElement(Linker2)
	self.Linker2 = Linker2
	local LayoutElementTL2 = LUI.UIImage.new(0.5, 0.5, 437, 453, 0, 0, 77.5, 93.5)
	LayoutElementTL2:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	LayoutElementTL2:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	LayoutElementTL2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	LayoutElementTL2:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(LayoutElementTL2)
	self.LayoutElementTL2 = LayoutElementTL2
	local LayoutElementTL = LUI.UIImage.new(0.5, 0.5, -451, -435, 0, 0, 77.5, 93.5)
	LayoutElementTL:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	LayoutElementTL:setZRot(90)
	LayoutElementTL:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	LayoutElementTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	LayoutElementTL:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(LayoutElementTL)
	self.LayoutElementTL = LayoutElementTL
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_local1, f1_arg0, 0.5, 0.5, -436.5, 211.5, 0.5, 0.5, 438, 486)
	self:addElement(buttons)
	self.buttons = buttons
	local PCSimpleVScrollList = nil
	PCSimpleVScrollList = CoD.PC_SimpleVScrollList.new(f1_local1, f1_arg0, 0.5, 0.5, -408.5, 105.5, 0.5, 0.5, -127.5, 432.5)
	PCSimpleVScrollList.ScrollView.View:setWidgetType(CoD.Social_PlayersListButtonWithCheckbox)
	PCSimpleVScrollList.ScrollView.View:setVerticalCount(AddWithoutPreview(0, 12))
	PCSimpleVScrollList.ScrollView.View:setVerticalCounter(CoD.verticalCounter)
	PCSimpleVScrollList.ScrollView.View:setDataSource("SocialInvitePlayersList")
	PCSimpleVScrollList:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f8_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end)
	local BTNQuit = PCSimpleVScrollList
	local Header = PCSimpleVScrollList.subscribeToModel
	local featureOverlayButtonMouseOnly = Engine[@"getmodelforcontroller"](f1_arg0)
	Header(BTNQuit, featureOverlayButtonMouseOnly.LastInput, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
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
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		return f11_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCSimpleVScrollList, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) then
			SetSelectedFriendXUID(self, element, controller)
			OpenOverlay(self, "Social_PlayerDetailsPopup", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_1E0254269ED8FFD3", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(PCSimpleVScrollList)
	self.PCSimpleVScrollList = PCSimpleVScrollList
	Header = CoD.Social_InvitePlayersHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -381, 306, 0.5, 0.5, -407.5, -238.5)
	self:addElement(Header)
	self.Header = Header
	BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 426, 460, 0.5, 0.5, -473.5, -439.5)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f14_local0
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
	featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, -408.5, -222.5, 0.5, 0.5, 426, 486)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_778D439E1B360368"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f17_local0 = nil
		if element.gainFocus then
			f17_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f17_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f17_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	Header:linkToElementModel(f1_local7, nil, false, function(model)
		Header:setModel(model, f1_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "NoPlayersOnline",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg0, "SocialRoot", "visibleCount", 0)
			end,
		},
	})
	local f1_local27 = self
	local f1_local28 = self.subscribeToModel
	local f1_local29 = DataSources.SocialRoot.getModel(f1_arg0)
	f1_local28(f1_local27, f1_local29.visibleCount, function(f22_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f22_arg0:get(),
			modelName = "visibleCount",
		})
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f23_local0 = nil
		if self.menuLoaded then
			f23_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f23_local0 = self.super:menuLoaded(event)
		end
		if not IsPC() then
			CoD.FreeCursorUtility.AddLockedFocusLeftOrRightNavigation(f1_local1, f1_arg0, self.onlineList, self.SendInvitesButton)
		end
		if not f23_local0 then
			f23_local0 = self:dispatchEventToChildren(event)
		end
		return f23_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"mp/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.SocialUtility.PopCurrentSocialTab(f1_local1)
	end)
	self.__on_menuOpened_self = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		local f27_local0 = self
		CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f27_arg2, f27_arg2, f27_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	f1_local7.id = "onlineList"
	tabs.id = "tabs"
	SendInvitesButton.id = "SendInvitesButton"
	buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		buttons.id = "buttons"
	end
	if CoD.isPC then
		PCSimpleVScrollList.id = "PCSimpleVScrollList"
	end
	Header.id = "Header"
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = f1_local7
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local28 = self
	SetElementPropertyEnum(self.onlineList, "_presenceFilter", Enum[@"presencefilter"][@"presence_filter_online"])
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.SocialUtility.SetSelfInviteTypeToSocialRoot(self, f1_arg0)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local7, self.SendInvitesButton)
	f1_local28 = PCSimpleVScrollList
	if IsPC() then
		CoD.PCWidgetUtility.SelectFirstActiveItemInPCScrollView(self, f1_arg0, self.PCSimpleVScrollList, self.Header)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, self.PCSimpleVScrollList, self.SendInvitesButton)
	end
	return self
end
CoD.Social_InvitePlayersPopup.__resetProperties = function(f29_arg0)
	f29_arg0.noPlayersOnlineText:completeAnimation()
	f29_arg0.onlineList:completeAnimation()
	f29_arg0.PCSimpleVScrollList:completeAnimation()
	f29_arg0.Header:completeAnimation()
	f29_arg0.noPlayersOnlineText:setAlpha(0)
	f29_arg0.onlineList:setAlpha(1)
	f29_arg0.PCSimpleVScrollList:setAlpha(1)
	f29_arg0.Header:setAlpha(1)
end
CoD.Social_InvitePlayersPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	NoPlayersOnline = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.onlineList:completeAnimation()
			f31_arg0.onlineList:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.onlineList)
			f31_arg0.noPlayersOnlineText:completeAnimation()
			f31_arg0.noPlayersOnlineText:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.noPlayersOnlineText)
			f31_arg0.PCSimpleVScrollList:completeAnimation()
			f31_arg0.PCSimpleVScrollList:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.PCSimpleVScrollList)
			f31_arg0.Header:completeAnimation()
			f31_arg0.Header:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Header)
		end,
	},
}
CoD.Social_InvitePlayersPopup.__onClose = function(f32_arg0)
	f32_arg0.__on_close_removeOverrides()
	f32_arg0.Header:close()
	f32_arg0.onlineList:close()
	f32_arg0.tabs:close()
	f32_arg0.SendInvitesButton:close()
	f32_arg0.SelectedCount:close()
	f32_arg0.buttons:close()
	f32_arg0.PCSimpleVScrollList:close()
	f32_arg0.BTNQuit:close()
	f32_arg0.featureOverlayButtonMouseOnly:close()
end
