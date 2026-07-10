require("x64:d6ecdf7755aeddc")
require("x64:9b17a53aa3b9f9a")
require("x64:f6ae994925ce8e1")
require("x64:523012e06043492")
require("x64:28557d516501618")
require("x64:d24ec043cbcc14d")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:38c11a77e96e48c")
require("x64:82580983913de78")
CoD.DirectorGamemodeSelectionZMOffline = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorGamemodeSelectionZMOffline = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorGamemodeSelectionZMOffline", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.CreateGlobalModel("localZMDifficulty")
	CoD.BaseUtility.CreateGlobalModel("localZMTrialVariant")
	CoD.BaseUtility.CreateGlobalModel("ZMLobbyExclusions.focusedPlaylistID")
	self:setClass(CoD.DirectorGamemodeSelectionZMOffline)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local TEMPBlackBGOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TEMPBlackBGOverlay:setRGB(0, 0, 0)
	TEMPBlackBGOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TEMPBlackBGOverlay:setShaderVector(0, 0.01, 0.5, 0, 0)
	self:addElement(TEMPBlackBGOverlay)
	self.TEMPBlackBGOverlay = TEMPBlackBGOverlay
	local BGDarkOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGDarkOverlay:setRGB(0, 0, 0)
	BGDarkOverlay:setAlpha(0.75)
	self:addElement(BGDarkOverlay)
	self.BGDarkOverlay = BGDarkOverlay
	local Maps = LUI.UIList.new(f1_local1, f1_arg0, 20, 0, nil, false, false, false, false)
	Maps:setLeftRight(0, 0, 97, 1141)
	Maps:setTopBottom(0, 0, 282, 882)
	Maps:setZoom(80)
	Maps:setWidgetType(CoD.DirectorMapSelectItem)
	Maps:setHorizontalCount(4)
	Maps:setVerticalCount(5)
	Maps:setSpacing(20)
	Maps:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Maps:setVerticalCounter(CoD.verticalCounter)
	Maps:setDataSource("DirectorMapList")
	Maps:appendEventHandler("on_session_start", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	Maps:appendEventHandler("on_session_end", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local TutorialMaps = Maps
	local GauntletMaps = Maps.subscribeToModel
	local CommonHeader = Engine[0x8DF2E5447F384B9]()
	GauntletMaps(TutorialMaps, CommonHeader["lobbyRoot.lobbyNav"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	TutorialMaps = Maps
	GauntletMaps = Maps.subscribeToModel
	CommonHeader = Engine[0x8DF2E5447F384B9]()
	GauntletMaps(TutorialMaps, CommonHeader["lobbyRoot.gameClient.update"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	TutorialMaps = Maps
	GauntletMaps = Maps.subscribeToModel
	CommonHeader = Engine[0x8DF2E5447F384B9]()
	GauntletMaps(TutorialMaps, CommonHeader["lobbyRoot.privateClient.update"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	Maps:registerEventHandler("list_item_gain_focus", function(element, event)
		local f7_local0 = nil
		CoD.ZombieUtility.UpdateFocusedZMOfflineInfo(f1_arg0, element)
		return f7_local0
	end)
	Maps:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(Maps, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and not IsElementPropertyValue(element, "purchasable", true) then
			CoD.ZombieUtility.SelectTutorialMapDifficulty(element, controller)
			MapSelected(element, controller)
			PlaySoundSetSound(self, "action")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			OpenPurchaseMapPackConfirmation(controller, element, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and not IsElementPropertyValue(element, "purchasable", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	Maps:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "selectedGameType", function(model)
		UpdateDataSource(self, Maps, f1_arg0)
	end)
	Maps:subscribeToGlobalModel(f1_arg0, "GlobalModel", "lobbyRoot.selectedGameType", function(model)
		CoD.ZombieUtility.UpdateFocusedZMOfflineInfo(f1_arg0, Maps)
	end)
	self:addElement(Maps)
	self.Maps = Maps
	GauntletMaps = LUI.UIList.new(f1_local1, f1_arg0, 20, 0, nil, false, false, false, false)
	GauntletMaps:setLeftRight(0, 0, 97, 1141)
	GauntletMaps:setTopBottom(0, 0, 282, 882)
	GauntletMaps:setAlpha(0)
	GauntletMaps:setZoom(80)
	GauntletMaps:setWidgetType(CoD.DirectorGauntletMapSelectItem)
	GauntletMaps:setHorizontalCount(4)
	GauntletMaps:setVerticalCount(5)
	GauntletMaps:setSpacing(20)
	GauntletMaps:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GauntletMaps:setVerticalCounter(CoD.verticalCounter)
	GauntletMaps:setDataSource("DirectorMapList")
	GauntletMaps:appendEventHandler("on_session_start", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f13_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	GauntletMaps:appendEventHandler("on_session_end", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	CommonHeader = GauntletMaps
	TutorialMaps = GauntletMaps.subscribeToModel
	local DifficultyList = Engine[0x8DF2E5447F384B9]()
	TutorialMaps(CommonHeader, DifficultyList["lobbyRoot.lobbyNav"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CommonHeader = GauntletMaps
	TutorialMaps = GauntletMaps.subscribeToModel
	DifficultyList = Engine[0x8DF2E5447F384B9]()
	TutorialMaps(CommonHeader, DifficultyList["lobbyRoot.gameClient.update"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CommonHeader = GauntletMaps
	TutorialMaps = GauntletMaps.subscribeToModel
	DifficultyList = Engine[0x8DF2E5447F384B9]()
	TutorialMaps(CommonHeader, DifficultyList["lobbyRoot.privateClient.update"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	GauntletMaps:registerEventHandler("list_item_gain_focus", function(element, event)
		local f18_local0 = nil
		CoD.ZombieUtility.UpdateFocusedZMOfflineInfo(f1_arg0, element)
		return f18_local0
	end)
	GauntletMaps:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f19_local0
	end)
	f1_local1:AddButtonCallbackFunction(GauntletMaps, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and not IsElementPropertyValue(element, "purchasable", true) then
			CoD.ZombieUtility.SelectTutorialMapDifficulty(element, controller)
			MapSelected(element, controller)
			PlaySoundSetSound(self, "action")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			OpenPurchaseMapPackConfirmation(controller, element, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and not IsElementPropertyValue(element, "purchasable", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	GauntletMaps:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "selectedGameType", function(model)
		UpdateDataSource(self, GauntletMaps, f1_arg0)
	end)
	GauntletMaps:subscribeToGlobalModel(f1_arg0, "GlobalModel", "lobbyRoot.selectedGameType", function(model)
		CoD.ZombieUtility.UpdateFocusedZMOfflineInfo(f1_arg0, GauntletMaps)
	end)
	self:addElement(GauntletMaps)
	self.GauntletMaps = GauntletMaps
	TutorialMaps = LUI.UIList.new(f1_local1, f1_arg0, 20, 0, nil, false, false, false, false)
	TutorialMaps:setLeftRight(0, 0, 97, 609)
	TutorialMaps:setTopBottom(0, 0, 282, 386)
	TutorialMaps:setAlpha(0)
	TutorialMaps:setZoom(80)
	TutorialMaps:setWidgetType(CoD.DirectorZMTutorialMapSelectItem)
	TutorialMaps:setHorizontalCount(2)
	TutorialMaps:setSpacing(20)
	TutorialMaps:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TutorialMaps:setVerticalCounter(CoD.verticalCounter)
	TutorialMaps:setDataSource("DirectorMapList")
	TutorialMaps:appendEventHandler("on_session_start", function(f24_arg0, f24_arg1)
		f24_arg1.menu = f24_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f24_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	TutorialMaps:appendEventHandler("on_session_end", function(f25_arg0, f25_arg1)
		f25_arg1.menu = f25_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f25_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DifficultyList = TutorialMaps
	CommonHeader = TutorialMaps.subscribeToModel
	local BackingGrayMediumLeft = Engine[0x8DF2E5447F384B9]()
	CommonHeader(DifficultyList, BackingGrayMediumLeft["lobbyRoot.lobbyNav"], function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DifficultyList = TutorialMaps
	CommonHeader = TutorialMaps.subscribeToModel
	BackingGrayMediumLeft = Engine[0x8DF2E5447F384B9]()
	CommonHeader(DifficultyList, BackingGrayMediumLeft["lobbyRoot.gameClient.update"], function(f27_arg0, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DifficultyList = TutorialMaps
	CommonHeader = TutorialMaps.subscribeToModel
	BackingGrayMediumLeft = Engine[0x8DF2E5447F384B9]()
	CommonHeader(DifficultyList, BackingGrayMediumLeft["lobbyRoot.privateClient.update"], function(f28_arg0, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	TutorialMaps:registerEventHandler("list_item_gain_focus", function(element, event)
		local f29_local0 = nil
		CoD.ZombieUtility.UpdateFocusedZMOfflineInfo(f1_arg0, element)
		return f29_local0
	end)
	TutorialMaps:registerEventHandler("gain_focus", function(element, event)
		local f30_local0 = nil
		if element.gainFocus then
			f30_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f30_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f30_local0
	end)
	f1_local1:AddButtonCallbackFunction(TutorialMaps, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and not IsElementPropertyValue(element, "purchasable", true) then
			CoD.ZombieUtility.SelectTutorialMapDifficulty(element, controller)
			MapSelected(element, controller)
			PlaySoundSetSound(self, "action")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			OpenPurchaseMapPackConfirmation(controller, element, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and not IsElementPropertyValue(element, "purchasable", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	TutorialMaps:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "selectedGameType", function(model)
		UpdateDataSource(self, TutorialMaps, f1_arg0)
	end)
	TutorialMaps:subscribeToGlobalModel(f1_arg0, "GlobalModel", "lobbyRoot.selectedGameType", function(model)
		CoD.ZombieUtility.UpdateFocusedZMOfflineInfo(f1_arg0, TutorialMaps)
	end)
	self:addElement(TutorialMaps)
	self.TutorialMaps = TutorialMaps
	CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x4456C22914B29F9))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f35_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f36_local0 = nil
		if element.menuLoaded then
			f36_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f36_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f36_local0 then
			f36_local0 = element:dispatchEventToChildren(event)
		end
		return f36_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	DifficultyList = LUI.UIList.new(f1_local1, f1_arg0, 19, 0, nil, false, false, false, false)
	DifficultyList:setLeftRight(0.5, 0.5, -863, 178)
	DifficultyList:setTopBottom(0, 0, 189, 241)
	DifficultyList:setWidgetType(CoD.ZMDifficultySelectButton)
	DifficultyList:setHorizontalCount(4)
	DifficultyList:setSpacing(19)
	DifficultyList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DifficultyList:setDataSource("ZMDifficultyList")
	DifficultyList:registerEventHandler("gain_focus", function(element, event)
		local f37_local0 = nil
		if element.gainFocus then
			f37_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f37_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f37_local0
	end)
	f1_local1:AddButtonCallbackFunction(DifficultyList, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.ZombieUtility.SelectDifficulty(element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xAC3B80C833B60E1, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(DifficultyList)
	self.DifficultyList = DifficultyList
	BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, -25)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f40_local0 = nil
		if element.menuLoaded then
			f40_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f40_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f40_local0 then
			f40_local0 = element:dispatchEventToChildren(event)
		end
		return f40_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f41_local0 = nil
		if element.menuLoaded then
			f41_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f41_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f41_local0 then
			f41_local0 = element:dispatchEventToChildren(event)
		end
		return f41_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local DirectorInfoPanelZM = CoD.DirectorInfoPanelZM.new(f1_local1, f1_arg0, 1, 1, -637, -97, 0.13, 0.83, 50, 50)
	DirectorInfoPanelZM:subscribeToGlobalModel(f1_arg0, "DirectorZMPlaylistInfo", nil, function(model)
		DirectorInfoPanelZM:setModel(model, f1_arg0)
	end)
	self:addElement(DirectorInfoPanelZM)
	self.DirectorInfoPanelZM = DirectorInfoPanelZM
	local DirectorHeaderTabSafeArea = CoD.DirectorHeaderTabSafeArea.new(f1_local1, f1_arg0, -0, 1, 0, 0, 0, 0, 0, 1080)
	DirectorHeaderTabSafeArea.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x4456C22914B29F9))
	DirectorHeaderTabSafeArea.CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(0x7F5AD3549344EFF))
	DirectorHeaderTabSafeArea.Tabs.customClasssList:setDataSource("DirectorGameTypeList")
	DirectorHeaderTabSafeArea:registerEventHandler("menu_loaded", function(element, event)
		local f43_local0 = nil
		if element.menuLoaded then
			f43_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f43_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f43_local0 then
			f43_local0 = element:dispatchEventToChildren(event)
		end
		return f43_local0
	end)
	self:addElement(DirectorHeaderTabSafeArea)
	self.DirectorHeaderTabSafeArea = DirectorHeaderTabSafeArea
	local DottedDivider = LUI.UIImage.new(0, 0, 615, 619, 0, 0, -261, 783)
	DottedDivider:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DottedDivider:setAlpha(0)
	DottedDivider:setZRot(90)
	DottedDivider:setImage(RegisterImage(0xC49B0C8991A541F))
	DottedDivider:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	DottedDivider:setShaderVector(0, 0, 0, 0, 0)
	DottedDivider:setupNineSliceShader(4, 8)
	self:addElement(DottedDivider)
	self.DottedDivider = DottedDivider
	self:mergeStateConditions({
		{
			stateName = "Tutorial",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.selectedGameType", 0xBC1A39D743DD767)
			end,
		},
		{
			stateName = "Trials",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.selectedGameType", 0x8F6A072F8CF2F88)
			end,
		},
		{
			stateName = "Classic",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.selectedGameType", 0x73B5B4896F886CB)
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.selectedGameType"], function(f47_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f47_arg0:get(),
			modelName = "lobbyRoot.selectedGameType",
		})
	end, false)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f48_local0 = nil
		if self.OcclusionChange then
			f48_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f48_local0 = self.super:OcclusionChange(event)
		end
		if not CoD.BaseUtility.IsSelfInEitherState(self, "Tutorial", "Trials") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, self.Maps, f1_arg0)
		elseif IsSelfInState(self, "Tutorial") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, self.TutorialMaps, f1_arg0)
		elseif IsSelfInState(self, "Trials") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, self.GauntletMaps, f1_arg0)
		end
		if not f48_local0 then
			f48_local0 = self:dispatchEventToChildren(event)
		end
		return f48_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.ZombieUtility.ResolveInvalidMapGametypeSelection(controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f51_arg2, f51_arg3, f51_arg4)
		if not CoD.BaseUtility.IsSelfInEitherState(self, "Tutorial", "Trials") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, self.Maps, controller)
		elseif IsSelfInState(self, "Tutorial") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, self.TutorialMaps, controller)
		elseif IsSelfInState(self, "Trials") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, self.GauntletMaps, controller)
		end
	end)
	Maps.id = "Maps"
	GauntletMaps.id = "GauntletMaps"
	TutorialMaps.id = "TutorialMaps"
	DifficultyList.id = "DifficultyList"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	DirectorHeaderTabSafeArea.id = "DirectorHeaderTabSafeArea"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = Maps
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.DirectorGamemodeSelectionZMOffline.__resetProperties = function(f52_arg0)
	f52_arg0.TutorialMaps:completeAnimation()
	f52_arg0.Maps:completeAnimation()
	f52_arg0.GauntletMaps:completeAnimation()
	f52_arg0.DottedDivider:completeAnimation()
	f52_arg0.TutorialMaps:setAlpha(0)
	f52_arg0.Maps:setAlpha(1)
	f52_arg0.GauntletMaps:setAlpha(0)
	f52_arg0.DottedDivider:setAlpha(0)
end
CoD.DirectorGamemodeSelectionZMOffline.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(0)
		end,
	},
	Tutorial = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(2)
			f54_arg0.Maps:completeAnimation()
			f54_arg0.Maps:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.Maps)
			f54_arg0.TutorialMaps:completeAnimation()
			f54_arg0.TutorialMaps:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.TutorialMaps)
		end,
	},
	Trials = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(3)
			f55_arg0.Maps:completeAnimation()
			f55_arg0.Maps:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Maps)
			f55_arg0.GauntletMaps:completeAnimation()
			f55_arg0.GauntletMaps:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.GauntletMaps)
			f55_arg0.TutorialMaps:completeAnimation()
			f55_arg0.TutorialMaps:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.TutorialMaps)
		end,
	},
	Classic = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(1)
			f56_arg0.DottedDivider:completeAnimation()
			f56_arg0.DottedDivider:setAlpha(0.15)
			f56_arg0.clipFinished(f56_arg0.DottedDivider)
		end,
	},
}
CoD.DirectorGamemodeSelectionZMOffline.__onClose = function(f57_arg0)
	f57_arg0.Maps:close()
	f57_arg0.GauntletMaps:close()
	f57_arg0.TutorialMaps:close()
	f57_arg0.CommonHeader:close()
	f57_arg0.DifficultyList:close()
	f57_arg0.BackingGrayMediumLeft:close()
	f57_arg0.FooterContainerFrontendRight:close()
	f57_arg0.DirectorInfoPanelZM:close()
	f57_arg0.DirectorHeaderTabSafeArea:close()
end
