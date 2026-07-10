require("x64:e5bfb75539585a8")
require("x64:6fc3850ee0e7df6")
require("x64:e99196b904ad18")
require("x64:4c9a492524a6a24")
require("x64:e41af73729601d6")
require("x64:7889ce1e3e2e8a")
require("x64:19c1945d2e472b0")
require("x64:be779d5e87238aa")
CoD.CodCasterSettingsSideBar = InheritFrom(CoD.Menu)
LUI.createMenu.CodCasterSettingsSideBar = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("CodCasterSettingsSideBar", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Update", nil)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Reset", nil)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "customGamesEdit", false)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.CodCasterSettingsSideBar)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local texture = LUI.UIImage.new(1, 1, -1050, 0, 0, 0, 0, 1080)
	texture:setAlpha(0.75)
	texture:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	texture:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(texture)
	self.texture = texture
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 1, 1, -1050, 0, 0, 0, 0, 1080)
	self:addElement(Background)
	self.Background = Background
	local BackingBlack = CoD.CodCasterSettingFooter.new(f1_local1, f1_arg0, 1, 1, -1049, 17, 0, 0, 1015, 1268)
	self:addElement(BackingBlack)
	self.BackingBlack = BackingBlack
	local tabBG = CoD.CodCaster_Settings_CategoryTabs_BG.new(f1_local1, f1_arg0, 1, 1, -1050, 0, 0, 0, 51, 88)
	self:addElement(tabBG)
	self.tabBG = tabBG
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.TabFrame = f1_local6
	local f1_local7 = nil
	local TabFramePC = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFramePC:setLeftRight(1, 1, -1016, -56)
	TabFramePC:setTopBottom(0, 0, 134.5, 1012.5)
	self:addElement(TabFramePC)
	self.TabFramePC = TabFramePC
	local BGSceneBlur = LUI.UIImage.new(1, 1, -1050, -230, 0, 0, 16.5, 83.5)
	BGSceneBlur:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	BGSceneBlur:setAlpha(0)
	self:addElement(BGSceneBlur)
	self.BGSceneBlur = BGSceneBlur
	local f1_local10 = nil
	self.background2 = LUI.UIElement.createFake()
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_local1, f1_arg0, 1, 1, -1050, 0, 0, 0, 9.5, 51.5)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local TopBar2 = LUI.UIImage.new(1, 1, -1050, 0, 0, 0, 50.5, 51.5)
	TopBar2:setRGB(0.46, 0.46, 0.51)
	TopBar2:setAlpha(0.8)
	TopBar2:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TopBar2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 1, 1, -910, 90, 0, 0, 0.5, 42.5)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local Title = LUI.UIText.new(1, 1, -1020, -702, 0, 0, 15.5, 45.5)
	Title:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	Title:setText(LocalizeToUpperString(@"hash_7E2311AD89D11E7C"))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(Title)
	self.Title = Title
	local FooterContainerIngameRight = CoD.CodCasterSettingsSideBarLeftbuttoncontainer.new(f1_local1, f1_arg0, 1, 1, -1000, -420, 1, 1, -48, 0)
	self:addElement(FooterContainerIngameRight)
	self.FooterContainerIngameRight = FooterContainerIngameRight
	local CatgeoryTab = CoD.CodCaster_Settings_CategoryTabs.new(f1_local1, f1_arg0, 1, 1, -1050, 0, 0, 0, 51, 88)
	CatgeoryTab.categoryTabsListPC:setDataSource("CodCasterSideBarSettingsTabs")
	CatgeoryTab.categoryTabsList:setDataSource("CodCasterSideBarSettingsTabs")
	CatgeoryTab:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(CatgeoryTab)
	self.CatgeoryTab = CatgeoryTab
	local quitButton = nil
	quitButton = CoD.featureOverlay_Button.new(f1_local1, f1_arg0, 1, 1, -319, -119, 0, 0, 924, 984)
	quitButton.ButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/back"))
	quitButton:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(quitButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		SaveShoutcasterSettings(self, element, controller)
		GoBack(self, controller)
		SetLuiKeyCatcher(false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(quitButton)
	self.quitButton = quitButton
	local resetButton = nil
	resetButton = CoD.featureOverlay_Button.new(f1_local1, f1_arg0, 1, 1, -550, -350, 0, 0, 924, 984)
	resetButton.ButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FA987631536BD44"))
	resetButton:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(resetButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		CoD.CodCasterUtility.OpenResetCodCasterSettingsPopup(self, element, controller, "", menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(resetButton)
	self.resetButton = resetButton
	f1_local6:linkToElementModel(CatgeoryTab.categoryTabsList, "tabWidget", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			f1_local6:changeFrameWidget(f9_local0)
		end
	end)
	TabFramePC:linkToElementModel(CatgeoryTab.categoryTabsListPC, "tabWidget", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			TabFramePC:changeFrameWidget(f10_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"])
			end,
		},
		{
			stateName = "PCGamepad",
			condition = function(menu, element, event)
				return IsPC() and IsGamepad(f1_arg0)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local20(f1_local19, f1_local21["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f15_arg1)
	end)
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local20(f1_local19, f1_local21.LastInput, function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f17_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local20(f1_local19, f1_local21.LastInput, function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], "Y", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			SaveShoutcasterSettings(self, element, controller)
			GoBack(self, controller)
			SetLuiKeyCatcher(false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"menu/back", nil, "Y")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_contextual_2", function(element, menu, controller, model)
		if IsGamepad(controller) then
			CoD.CodCasterUtility.ResetCodcasterSettingsGamepad(controller, menu)
			PlaySoundAlias("uin_party_ease_slide")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_5FA987631536BD44", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f23_arg2, f23_arg3, f23_arg4)
		if IsMenuInState(f1_local1, "Hidden") then
			SaveShoutcasterSettings(self, element, controller)
			GoBack(self, controller)
			SetLuiKeyCatcher(false)
		end
	end)
	f1_local6.id = "TabFrame"
	TabFramePC.id = "TabFramePC"
	FooterContainerIngameRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerIngameRight.id = "FooterContainerIngameRight"
	end
	CatgeoryTab.id = "CatgeoryTab"
	if CoD.isPC then
		quitButton.id = "quitButton"
	end
	if CoD.isPC then
		resetButton.id = "resetButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = f1_local6
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local20 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.TabFramePC)
		ForceCheckDefaultPCFocus(self.TabFramePC, f1_local1, f1_arg0)
	end
	return self
end
CoD.CodCasterSettingsSideBar.__resetProperties = function(f24_arg0)
	f24_arg0.quitButton:completeAnimation()
	f24_arg0.resetButton:completeAnimation()
	f24_arg0.CatgeoryTab:completeAnimation()
	f24_arg0.FooterContainerIngameRight:completeAnimation()
	f24_arg0.Title:completeAnimation()
	f24_arg0.BackingGrayMediumLeft:completeAnimation()
	f24_arg0.TopBar2:completeAnimation()
	f24_arg0.DotTiledBacking:completeAnimation()
	f24_arg0.background2:completeAnimation()
	f24_arg0.BGSceneBlur:completeAnimation()
	f24_arg0.TabFramePC:completeAnimation()
	f24_arg0.TabFrame:completeAnimation()
	f24_arg0.tabBG:completeAnimation()
	f24_arg0.BackingBlack:completeAnimation()
	f24_arg0.Background:completeAnimation()
	f24_arg0.texture:completeAnimation()
	f24_arg0.quitButton:setLeftRight(1, 1, -319, -119)
	f24_arg0.quitButton:setAlpha(1)
	f24_arg0.resetButton:setAlpha(1)
	f24_arg0.CatgeoryTab:setAlpha(1)
	f24_arg0.FooterContainerIngameRight:setLeftRight(1, 1, -1000, -420)
	f24_arg0.FooterContainerIngameRight:setAlpha(1)
	f24_arg0.Title:setAlpha(1)
	f24_arg0.BackingGrayMediumLeft:setAlpha(1)
	f24_arg0.TopBar2:setAlpha(0.8)
	f24_arg0.DotTiledBacking:setAlpha(0.5)
	f24_arg0.background2:setAlpha(0.2)
	f24_arg0.BGSceneBlur:setAlpha(0)
	f24_arg0.TabFramePC:setAlpha(1)
	f24_arg0.TabFrame:setAlpha(1)
	f24_arg0.tabBG:setAlpha(1)
	f24_arg0.BackingBlack:setAlpha(1)
	f24_arg0.Background:setLeftRight(1, 1, -1050, 0)
	f24_arg0.Background:setTopBottom(0, 0, 0, 1080)
	f24_arg0.Background:setAlpha(1)
	f24_arg0.texture:setAlpha(0.75)
end
CoD.CodCasterSettingsSideBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.quitButton:completeAnimation()
			f25_arg0.quitButton:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.quitButton)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(14)
			f26_arg0.texture:completeAnimation()
			f26_arg0.texture:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.texture)
			f26_arg0.Background:completeAnimation()
			f26_arg0.Background:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Background)
			f26_arg0.BackingBlack:completeAnimation()
			f26_arg0.BackingBlack:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.BackingBlack)
			f26_arg0.tabBG:completeAnimation()
			f26_arg0.tabBG:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.tabBG)
			f26_arg0.TabFrame:completeAnimation()
			f26_arg0.TabFrame:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.TabFrame)
			f26_arg0.TabFramePC:completeAnimation()
			f26_arg0.TabFramePC:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.TabFramePC)
			f26_arg0.BGSceneBlur:completeAnimation()
			f26_arg0.BGSceneBlur:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.BGSceneBlur)
			f26_arg0.background2:completeAnimation()
			f26_arg0.background2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.background2)
			f26_arg0.DotTiledBacking:completeAnimation()
			f26_arg0.DotTiledBacking:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DotTiledBacking)
			f26_arg0.TopBar2:completeAnimation()
			f26_arg0.TopBar2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.TopBar2)
			f26_arg0.BackingGrayMediumLeft:completeAnimation()
			f26_arg0.BackingGrayMediumLeft:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.BackingGrayMediumLeft)
			f26_arg0.Title:completeAnimation()
			f26_arg0.Title:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Title)
			f26_arg0.FooterContainerIngameRight:completeAnimation()
			f26_arg0.FooterContainerIngameRight:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.FooterContainerIngameRight)
			f26_arg0.CatgeoryTab:completeAnimation()
			f26_arg0.CatgeoryTab:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CatgeoryTab)
			f26_arg0.quitButton:completeAnimation()
			f26_arg0.quitButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.quitButton)
			f26_arg0.resetButton:completeAnimation()
			f26_arg0.resetButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.resetButton)
		end,
	},
	PCGamepad = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			f27_arg0.Background:completeAnimation()
			f27_arg0.Background:setLeftRight(1, 1, -1050, 0)
			f27_arg0.Background:setTopBottom(0, 0, 0, 1200)
			f27_arg0.clipFinished(f27_arg0.Background)
			f27_arg0.BackingBlack:completeAnimation()
			f27_arg0.BackingBlack:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.BackingBlack)
			f27_arg0.FooterContainerIngameRight:completeAnimation()
			f27_arg0.FooterContainerIngameRight:setLeftRight(1, 1, -1000, 50)
			f27_arg0.clipFinished(f27_arg0.FooterContainerIngameRight)
			f27_arg0.quitButton:completeAnimation()
			f27_arg0.quitButton:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.quitButton)
			f27_arg0.resetButton:completeAnimation()
			f27_arg0.resetButton:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.resetButton)
		end,
	},
	PC = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			f28_arg0.Background:completeAnimation()
			f28_arg0.Background:setTopBottom(0, 0, 0, 1200)
			f28_arg0.clipFinished(f28_arg0.Background)
			f28_arg0.BackingBlack:completeAnimation()
			f28_arg0.BackingBlack:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.BackingBlack)
			f28_arg0.FooterContainerIngameRight:completeAnimation()
			f28_arg0.FooterContainerIngameRight:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FooterContainerIngameRight)
			f28_arg0.quitButton:completeAnimation()
			f28_arg0.quitButton:setLeftRight(1, 1, -305, -105)
			f28_arg0.clipFinished(f28_arg0.quitButton)
		end,
	},
}
CoD.CodCasterSettingsSideBar.__onClose = function(f29_arg0)
	f29_arg0.TabFrame:close()
	f29_arg0.TabFramePC:close()
	f29_arg0.Background:close()
	f29_arg0.BackingBlack:close()
	f29_arg0.tabBG:close()
	f29_arg0.DotTiledBacking:close()
	f29_arg0.BackingGrayMediumLeft:close()
	f29_arg0.FooterContainerIngameRight:close()
	f29_arg0.CatgeoryTab:close()
	f29_arg0.quitButton:close()
	f29_arg0.resetButton:close()
end
