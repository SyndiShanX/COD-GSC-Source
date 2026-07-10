require("x64:d58649a93c7c23a")
require("x64:643bb843a38237")
require("x64:b06ac7d487ebb93")
require("x64:574ad94e3056951")
require("x64:6767134a413986e")
require("x64:12a47386affd813")
require("x64:2a8dac04babf8b8")
require("x64:98f657bdbe677aa")
require("x64:3a03e6abe332775")
require("x64:9258f7404e4ba1d")
require("x64:6af9b7da2a5cafd")
require("x64:247779f7898be87")
require("x64:c0f8856fca43866")
require("x64:776309501d0fd4")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:13012bca0fbd2f4")
require("x64:6be582def81a3b7")
require("x64:dd67ebb9f0b033a")
require("x64:6ee653ade3452f5")
require("x64:c0887595cfb6bb1")
CoD.Director = InheritFrom(CoD.Menu)
LUI.createMenu.Director = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Director", f1_arg0)
	local f1_local1 = self
	CoD.DirectorUtility.SetupDirectorStateDefaultFocusCallbacks(f1_local1, f1_arg0)
	EnableAnyController(self, f1_arg0)
	CoD.DirectorUtility.CreateOfflineScreenState()
	CoD.BaseUtility.SelfShowsBuildInfo(self)
	CoD.DirectorUtility.InitCompanionApp(self, f1_arg0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "Contracts.updateActiveContracts", 0)
	self:setClass(CoD.Director)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	ScorestreakAspectRatioFix:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ScorestreakAspectRatioFix:setAlpha(0)
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local FullScreenBlack = CoD.DirectorFullscreenBlack.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(FullScreenBlack)
	self.FullScreenBlack = FullScreenBlack
	local SearchQoSJoinList = LUI.GridLayout.new(f1_local1, f1_arg0, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	SearchQoSJoinList:setLeftRight(0, 0, 519, 1281)
	SearchQoSJoinList:setTopBottom(0, 0, 80, 828)
	SearchQoSJoinList:setWidgetType(CoD.SessionSearchQoSJoin)
	SearchQoSJoinList:setVerticalCount(50)
	SearchQoSJoinList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SearchQoSJoinList:setDataSource("DebugSessionSearchQoSJoin")
	self:addElement(SearchQoSJoinList)
	self.SearchQoSJoinList = SearchQoSJoinList
	local DirectorTheater = CoD.DirectorTheater.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorTheater:setAlpha(0)
	self:addElement(DirectorTheater)
	self.DirectorTheater = DirectorTheater
	local DirectorCustom = CoD.directorCustom.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	DirectorCustom:setAlpha(0)
	DirectorCustom:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(DirectorCustom)
	self.DirectorCustom = DirectorCustom
	local DirectorTraining = CoD.directorTraining.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorTraining:setAlpha(0)
	DirectorTraining:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(DirectorTraining)
	self.DirectorTraining = DirectorTraining
	local DirectorArenaMatchmaking = CoD.directorArenaMatchmaking.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	DirectorArenaMatchmaking:setAlpha(0)
	DirectorArenaMatchmaking:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(DirectorArenaMatchmaking)
	self.DirectorArenaMatchmaking = DirectorArenaMatchmaking
	local DirectorArenaPregame = CoD.directorArenaPregame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	DirectorArenaPregame:setAlpha(0)
	DirectorArenaPregame:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(DirectorArenaPregame)
	self.DirectorArenaPregame = DirectorArenaPregame
	local DirectorPublic = CoD.directorPublic.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	DirectorPublic:setAlpha(0)
	DirectorPublic:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(DirectorPublic)
	self.DirectorPublic = DirectorPublic
	local DirectorPrivate = CoD.directorPrivate.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	DirectorPrivate:setAlpha(0)
	DirectorPrivate:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(DirectorPrivate)
	self.DirectorPrivate = DirectorPrivate
	local DirectorPregame = CoD.directorPregame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	DirectorPregame:setAlpha(0)
	DirectorPregame:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(DirectorPregame)
	self.DirectorPregame = DirectorPregame
	local DirectorSelect = CoD.directorSelect.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelect:setAlpha(0)
	self:addElement(DirectorSelect)
	self.DirectorSelect = DirectorSelect
	local DirectorCommonSafeAreaBottomAndLeft = CoD.DirectorCommonSafeAreaBottomAndLeft.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -512, 0)
	DirectorCommonSafeAreaBottomAndLeft:registerEventHandler("menu_loaded", function(element, event)
		local f10_local0 = nil
		if element.menuLoaded then
			f10_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f10_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f10_local0 then
			f10_local0 = element:dispatchEventToChildren(event)
		end
		return f10_local0
	end)
	self:addElement(DirectorCommonSafeAreaBottomAndLeft)
	self.DirectorCommonSafeAreaBottomAndLeft = DirectorCommonSafeAreaBottomAndLeft
	local DirectorCommonPartyList = CoD.DirectorCommonPartyLists.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 775)
	DirectorCommonPartyList:registerEventHandler("menu_loaded", function(element, event)
		local f11_local0 = nil
		if element.menuLoaded then
			f11_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f11_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f11_local0 then
			f11_local0 = element:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self:addElement(DirectorCommonPartyList)
	self.DirectorCommonPartyList = DirectorCommonPartyList
	local ChatClient = nil
	ChatClient = CoD.FrontendChatClientContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -943, -403, 0.94, 0.94, -287, 3)
	self:addElement(ChatClient)
	self.ChatClient = ChatClient
	local ChatClientPassiveEntryDisplay = nil
	ChatClientPassiveEntryDisplay = CoD.ChatClientPassiveEntryDisplay.new(f1_local1, f1_arg0, 0.5, 0.5, -943, -403, 0.94, 0.94, -287, 3)
	self:addElement(ChatClientPassiveEntryDisplay)
	self.ChatClientPassiveEntryDisplay = ChatClientPassiveEntryDisplay
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:subscribeToGlobalModel(f1_arg0, "StartMenuBreadcrumbs", "themenu", function(model)
		FooterContainerFrontendRight.LeftContainerPC.PersistentLeftContainer.FooterButtonPlayerAccount.Spacer3.newIcon:setModel(model, f1_arg0)
	end)
	FooterContainerFrontendRight:subscribeToGlobalModel(f1_arg0, "StartMenuBreadcrumbs", "themenu", function(model)
		FooterContainerFrontendRight.CenterContainer.Options.newIcon:setModel(model, f1_arg0)
	end)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f14_local0 = nil
		if element.menuLoaded then
			f14_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f14_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f14_local0 then
			f14_local0 = element:dispatchEventToChildren(event)
		end
		return f14_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f15_local0 = nil
		if element.menuLoaded then
			f15_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f15_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f15_local0 then
			f15_local0 = element:dispatchEventToChildren(event)
		end
		return f15_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local blackFade = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	blackFade:setRGB(0, 0, 0)
	blackFade:setAlpha(0)
	self:addElement(blackFade)
	self.blackFade = blackFade
	local FrontendBattlenetContainer = nil
	FrontendBattlenetContainer = CoD.FrontendBattlenetContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -868, -432, 0.95, 0.95, -780, 0)
	self:addElement(FrontendBattlenetContainer)
	self.FrontendBattlenetContainer = FrontendBattlenetContainer
	local PCNotif = nil
	PCNotif = CoD.PC_Notif_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 470, 920, 0, 0, 70, 170)
	self:addElement(PCNotif)
	self.PCNotif = PCNotif
	local KoreaErrorMessage = nil
	KoreaErrorMessage = LUI.UIText.new(0, 0, 374.5, 1583.5, 0, 0, 417, 454)
	KoreaErrorMessage:setAlpha(0)
	KoreaErrorMessage:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/korea_15plus_blocked_gamemode"))
	KoreaErrorMessage:setTTF("default")
	KoreaErrorMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KoreaErrorMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(KoreaErrorMessage)
	self.KoreaErrorMessage = KoreaErrorMessage
	local BlackFadeForGameStart = LUI.UIImage.new(-0.05, 1.05, 0, 0, -0.05, 1.05, 0, 0)
	BlackFadeForGameStart:setRGB(0, 0, 0)
	BlackFadeForGameStart:setAlpha(0)
	self:addElement(BlackFadeForGameStart)
	self.BlackFadeForGameStart = BlackFadeForGameStart
	self:mergeStateConditions({
		{
			stateName = "HideForGameStart",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg0, "LobbyRoot", "hideMenusForGameStart", 1)
			end,
		},
		{
			stateName = "ShowSelectKorea15Plus",
			condition = function(menu, element, event)
				local f17_local0 = IsPC()
				if f17_local0 then
					f17_local0 = IsZombies()
					if f17_local0 then
						f17_local0 = CoD.PCKoreaUtility.ShowKorea15Plus()
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "ShowSelect",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorSelect(f1_arg0)
			end,
		},
		{
			stateName = "ShowPregame",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorPregame(f1_arg0)
			end,
		},
		{
			stateName = "ShowPrivate",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorPrivate(self, f1_arg0)
			end,
		},
		{
			stateName = "ShowCustom",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorCustom(self, f1_arg0)
			end,
		},
		{
			stateName = "ShowArena",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorArena(f1_arg0)
			end,
		},
		{
			stateName = "ShowArenaMatchmaking",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorArenaMatchmaking(f1_arg0)
			end,
		},
		{
			stateName = "ShowTheater",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorTheater(f1_arg0)
			end,
		},
		{
			stateName = "ShowPublic",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorPublic(f1_arg0)
			end,
		},
		{
			stateName = "ShowTraining",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorTraining(f1_arg0)
			end,
		},
	})
	local f1_local25 = self
	local f1_local26 = self.subscribeToModel
	local f1_local27 = DataSources.LobbyRoot.getModel(f1_arg0)
	f1_local26(f1_local25, f1_local27.hideMenusForGameStart, function(f27_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f27_arg0:get(),
			modelName = "hideMenusForGameStart",
		})
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.lobbyNav"], function(f28_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f28_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.showSelect"], function(f29_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f29_arg0:get(),
			modelName = "lobbyRoot.showSelect",
		})
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.lobbyNetworkMode"], function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.lobbyNav"], function(f31_arg0, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.privateClient.update"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.showSelect"], function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	self:appendEventHandler("input_source_changed", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f34_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f34_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local26(f1_local25, f1_local27.LastInput, function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local26(f1_local25, f1_local27["DirectorZMLoadoutPreview.ZMLoadoutPreviewWidgetShown"], function(f36_arg0, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.lobbyTimeRemaining"], function(f38_arg0, f38_arg1)
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.spinnerActive"], function(f39_arg0, f39_arg1)
		CoD.Menu.UpdateButtonShownState(f39_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f39_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.publicLobby.stage"], function(f40_arg0, f40_arg1)
		CoD.Menu.UpdateButtonShownState(f40_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f40_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	self:appendEventHandler("on_session_start", function(f41_arg0, f41_arg1)
		f41_arg1.menu = f41_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f41_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f41_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end)
	self:appendEventHandler("on_session_end", function(f42_arg0, f42_arg1)
		f42_arg1.menu = f42_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f42_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f42_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getglobalmodel"]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.gameClient.update"], function(f43_arg0, f43_arg1)
		CoD.Menu.UpdateButtonShownState(f43_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f43_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	self:registerEventHandler("unused_gamepad_button", function(self, event)
		local f44_local0 = nil
		LobbyAddLocalClient(self, event.controller or f1_arg0)
		if not f44_local0 then
			f44_local0 = self:dispatchEventToChildren(event)
		end
		return f44_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], nil, function(element, menu, controller, model)
		if not IsPC() then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "StartMenu_Main", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"menu/menu", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if not IsPC() and not IsLAN() and not IsPlayerAGuest(controller) and IsPlayerAllowedToPlayOnline(controller) and not CoD.DirectorUtility.IsSocialButtonDisabledForDemo(controller) and not CoD.DirectorUtility.ShowDirectorTraining(controller) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Social_Main", controller, nil)
			return true
		elseif CoD.DirectorUtility.ShowDirectorSelect(controller) and IsPC() and not IsLAN() then
			CoD.BaseUtility.CallCustomElementFunction(self, self.DirectorSelect, controller, menu, "_activateFeaturedWidget")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and not IsLAN() and not IsPlayerAGuest(controller) and IsPlayerAllowedToPlayOnline(controller) and not CoD.DirectorUtility.IsSocialButtonDisabledForDemo(controller) and not CoD.DirectorUtility.ShowDirectorTraining(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"menu/social", nil, nil)
			return true
		elseif CoD.DirectorUtility.ShowDirectorSelect(controller) and IsPC() and not IsLAN() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.DirectorUtility.IsOfflineDemo() and IsLobbyNetworkModeLAN() and CoD.BaseUtility.IsButtonHoldFinished(model) then
			LobbyGoBack(self, controller)
			return true
		elseif CoD.DirectorUtility.ShowDirectorSelect(controller) and CoD.DirectorUtility.IsOfflineDemo() and IsLobbyNetworkModeLAN() and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.DirectorUtility.NavigateToLobby(menu, controller, LuaEnum.UI.DIRECTOR_LAN_MP)
			return true
		elseif CoD.DirectorUtility.ShowDirectorSelect(controller) and not IsLAN() and not IsPC() and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.BaseUtility.CallCustomElementFunction(self, self.DirectorSelect, controller, menu, "_activateFeaturedWidget")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.DirectorUtility.IsOfflineDemo() and IsLobbyNetworkModeLAN() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return false
		elseif CoD.DirectorUtility.ShowDirectorSelect(controller) and CoD.DirectorUtility.IsOfflineDemo() and IsLobbyNetworkModeLAN() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return false
		elseif CoD.DirectorUtility.ShowDirectorSelect(controller) and not IsLAN() and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"hash_64D2505E19049444"], "ESCAPE", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) then
			CoD.DirectorUtility.HideLoadoutPreview(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) then
			CoD.DirectorUtility.HideLoadoutPreview(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and not CoD.DirectorUtility.IsOfflineDemo() and not CoD.DirectorUtility.ShowDirectorPregame(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and not CoD.ArenaUtility.ArenaMatchSet(self) then
			LobbyGoBack(self, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() and IsPC() then
			LobbyGoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() then
			LobbyGoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.LobbyUtility.ShouldShowLeaveLobbyPopup() and not CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.DirectorUtility.IsOfflineDemo() and not CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) then
			CoD.LobbyUtility.LobbyGoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			LobbyGoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			LobbyGoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorSelect(controller) then
			OpenPCQuit(self, menu, self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.AllowShortPressToGoBack(self, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/cancel", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and not CoD.DirectorUtility.IsOfflineDemo() and not CoD.DirectorUtility.ShowDirectorPregame(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and not CoD.ArenaUtility.ArenaMatchSet(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/cancel", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.LobbyUtility.ShouldShowLeaveLobbyPopup() and not CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.DirectorUtility.IsOfflineDemo() and not CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/cancel", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/cancel", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorSelect(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/quit", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.AllowShortPressToGoBack(self, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, true)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) and not IsPC() then
			CoD.DirectorUtility.HideLoadoutPreview(controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) then
			CoD.DirectorUtility.HideLoadoutPreview(controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and not CoD.DirectorUtility.ShowDirectorPregame(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and not CoD.ArenaUtility.ArenaMatchSet(self) then
			LobbyGoBack(self, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() and IsPC() then
			LobbyGoBack(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() then
			LobbyGoBack(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.LobbyUtility.ShouldShowLeaveLobbyPopup() and not CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.DirectorUtility.IsOfflineDemo() and not CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) then
			CoD.LobbyUtility.LobbyGoBack(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			LobbyGoBack(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			LobbyGoBack(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorSelect(controller) and IsPC() then
			OpenPCQuit(self, menu, self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.AllowShortPressToGoBack(self, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			LobbyGoBack(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) and IsPC() then
			CoD.DirectorUtility.HideLoadoutPreview(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/hide_loadout", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/cancel", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/leave", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and not CoD.DirectorUtility.ShowDirectorPregame(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/leave", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and not CoD.ArenaUtility.ArenaMatchSet(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/leave", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/cancel", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and IsLobbyPrivateHost() and IsWarzone() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_FF006933C958CA6", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/leave", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.LobbyUtility.ShouldShowLeaveLobbyPopup() and not CoD.DirectorUtility.ShowDirectorPublic(controller) and not CoD.DirectorUtility.IsOfflineDemo() and not CoD.DirectorUtility.ShowDirectorArenaMatchmaking(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/leave", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorCustom(self, controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/cancel", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorTheater(controller) and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/cancel", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.ShowDirectorSelect(controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/quit", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.AllowShortPressToGoBack(self, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.IsLoadoutPreviewWidgetShown(controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.AARUtility.CanShowAAR(menu, controller) then
			CoD.AARUtility.OpenAAR(menu, controller)
			UpdateButtonPromptState(menu, element, controller, Enum[@"luibutton"][@"lui_key_back"])
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.AARUtility.CanShowAAR(menu, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_5EEF90B1483C4C23", nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], "ui_contextual_2", function(element, menu, controller, model)
		if IsBooleanDvarSet("lobby_gestures_enabled") and CoD.DirectorUtility[@"hash_61E20A632CB63092"](controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BaseUtility.MenuPreservesButton(menu, Enum[@"luibutton"][@"lui_key_rtrig"], true)
			OpenOverlay(self, "DirectorGestureSelector", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsBooleanDvarSet("lobby_gestures_enabled") and CoD.DirectorUtility[@"hash_61E20A632CB63092"](controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"menu/gesture", nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f59_arg2, f59_arg3, f59_arg4)
		if IsElementInState(f1_local1, "ShowArena") then
			CoD.AARUtility.OpenAARIfNeeded(f1_local1, controller)
			UpdateButtonPromptState(f1_local1, element, controller, Enum[@"luibutton"][@"lui_key_back"])
			CoD.DirectorUtility.ForceNotifyPrivateClientUpdate()
			ForceNotifyControllerModel(controller, "Contracts.updateActiveContracts")
		elseif IsElementInAnyState(f1_local1, "ShowCustom", "ShowArena", "ShowPublic", "ShowPrivate", "ShowPregame") then
			CoD.AARUtility.OpenAARIfNeeded(f1_local1, controller)
			UpdateButtonPromptState(f1_local1, element, controller, Enum[@"luibutton"][@"lui_key_back"])
			ForceNotifyControllerModel(controller, "Contracts.updateActiveContracts")
		elseif IsElementInState(f1_local1, "ShowTraining") then
			CoD.CTUtility.InitSpecialistHeadquarters(f1_local1, controller)
			UpdateButtonPromptState(f1_local1, element, controller, Enum[@"luibutton"][@"lui_key_back"])
		elseif IsElementInState(f1_local1, "ShowArenaMatchmaking") then
			CoD.DirectorUtility.ForceNotifyPrivateClientUpdate()
			ForceNotifyControllerModel(controller, "Contracts.updateActiveContracts")
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
		CoD.DirectorUtility.OnDirectorClose(f1_local1)
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "lobbyRoot.room", function(model)
		local f61_local0 = self
		RefreshLobbyRoom(f1_local1, f1_arg0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "isMatchmaking", function(model)
		local f62_local0 = self
		RefreshLobbyRoom(f1_local1, f1_arg0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "hideMenusForGameStart", function(model)
		local f63_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, 1) then
			PlayClip(self, "HideForGameStart", f1_arg0)
			SetLoseFocusToSelf(self, f1_arg0)
			MenuHidesFreeCursor(f1_local1, f1_arg0)
		elseif CoD.ModelUtility.IsParamModelEqualTo(model, 0) then
			PlayClip(self, "DefaultClip", f1_arg0)
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
		end
	end)
	SearchQoSJoinList.id = "SearchQoSJoinList"
	DirectorTheater.id = "DirectorTheater"
	DirectorCustom.id = "DirectorCustom"
	DirectorTraining.id = "DirectorTraining"
	DirectorArenaMatchmaking.id = "DirectorArenaMatchmaking"
	DirectorArenaPregame.id = "DirectorArenaPregame"
	DirectorPublic.id = "DirectorPublic"
	DirectorPrivate.id = "DirectorPrivate"
	DirectorPregame.id = "DirectorPregame"
	DirectorSelect.id = "DirectorSelect"
	DirectorCommonSafeAreaBottomAndLeft.id = "DirectorCommonSafeAreaBottomAndLeft"
	DirectorCommonPartyList.id = "DirectorCommonPartyList"
	if CoD.isPC then
		ChatClient.id = "ChatClient"
	end
	if CoD.isPC then
		ChatClientPassiveEntryDisplay.id = "ChatClientPassiveEntryDisplay"
	end
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		FrontendBattlenetContainer.id = "FrontendBattlenetContainer"
	end
	if CoD.isPC then
		PCNotif.id = "PCNotif"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = DirectorTheater
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local26 = self
	if IsPC() then
		CoD.DirectorUtility.PostLoad(f1_arg0, self)
		CoD.PCWidgetUtility.ResetAllKeysColor()
		CoD.PCUtility.StartTrackingFriendUpdate(f1_local1, f1_arg0)
		CoD.PCKoreaUtility.StartKoreaIndulgenceChecks(self)
		PrepareNavigationInDirectorRoot(f1_arg0)
		CheckModeAvailableAndBackOut_ZM(self, f1_local1, f1_arg0)
	else
		CoD.DirectorUtility.PostLoad(f1_arg0, self)
	end
	f1_local26 = FullScreenBlack
	if IsPC() then
		SizeToWidthOfScreen(f1_local26, f1_arg0)
	end
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorTheater, "ShowTheater")
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorCustom, "ShowCustom")
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorTraining, "ShowTraining")
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorArenaMatchmaking, "ShowArenaMatchmaking")
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorArenaPregame, "ShowArena")
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorPublic, "ShowPublic")
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorPregame, "ShowPregame")
	CoD.DirectorUtility.RegisterDirectorStateDefaultFocus(f1_local1, DirectorSelect, "ShowSelect")
	f1_local26 = blackFade
	if IsPC() then
		SizeToWidthOfScreen(f1_local26, f1_arg0)
	end
	return self
end
CoD.Director.__resetProperties = function(f64_arg0)
	f64_arg0.BlackFadeForGameStart:completeAnimation()
	f64_arg0.KoreaErrorMessage:completeAnimation()
	f64_arg0.blackFade:completeAnimation()
	f64_arg0.DirectorSelect:completeAnimation()
	f64_arg0.DirectorCommonSafeAreaBottomAndLeft:completeAnimation()
	f64_arg0.DirectorCommonPartyList:completeAnimation()
	f64_arg0.DirectorPregame:completeAnimation()
	f64_arg0.ScorestreakAspectRatioFix:completeAnimation()
	f64_arg0.DirectorPrivate:completeAnimation()
	f64_arg0.DirectorCustom:completeAnimation()
	f64_arg0.DirectorArenaPregame:completeAnimation()
	f64_arg0.DirectorArenaMatchmaking:completeAnimation()
	f64_arg0.DirectorTheater:completeAnimation()
	f64_arg0.DirectorPublic:completeAnimation()
	f64_arg0.BackingGrayMediumLeft:completeAnimation()
	f64_arg0.DirectorTraining:completeAnimation()
	f64_arg0.BlackFadeForGameStart:setAlpha(0)
	f64_arg0.KoreaErrorMessage:setAlpha(0)
	f64_arg0.blackFade:setAlpha(0)
	f64_arg0.DirectorSelect:setAlpha(0)
	f64_arg0.DirectorCommonSafeAreaBottomAndLeft:setAlpha(1)
	f64_arg0.DirectorCommonPartyList:setAlpha(1)
	f64_arg0.DirectorPregame:setAlpha(0)
	f64_arg0.ScorestreakAspectRatioFix:setAlpha(0)
	f64_arg0.DirectorPrivate:setAlpha(0)
	f64_arg0.DirectorCustom:setAlpha(0)
	f64_arg0.DirectorArenaPregame:setAlpha(0)
	f64_arg0.DirectorArenaMatchmaking:setAlpha(0)
	f64_arg0.DirectorTheater:setAlpha(0)
	f64_arg0.DirectorPublic:setAlpha(0)
	f64_arg0.BackingGrayMediumLeft:setAlpha(1)
	f64_arg0.DirectorTraining:setAlpha(0)
end
CoD.Director.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(0)
		end,
		HideForGameStart = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(1)
			local f66_local0 = function(f67_arg0)
				f66_arg0.BlackFadeForGameStart:beginAnimation(750)
				f66_arg0.BlackFadeForGameStart:setAlpha(1)
				f66_arg0.BlackFadeForGameStart:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.BlackFadeForGameStart:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.BlackFadeForGameStart:completeAnimation()
			f66_arg0.BlackFadeForGameStart:setAlpha(0)
			f66_local0(f66_arg0.BlackFadeForGameStart)
		end,
	},
	HideForGameStart = {
		DefaultClip = function(f68_arg0, f68_arg1)
			f68_arg0:__resetProperties()
			f68_arg0:setupElementClipCounter(1)
			f68_arg0.BlackFadeForGameStart:completeAnimation()
			f68_arg0.BlackFadeForGameStart:setAlpha(1)
			f68_arg0.clipFinished(f68_arg0.BlackFadeForGameStart)
		end,
	},
	ShowSelectKorea15Plus = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(2)
			f69_arg0.blackFade:completeAnimation()
			f69_arg0.blackFade:setAlpha(1)
			f69_arg0.clipFinished(f69_arg0.blackFade)
			f69_arg0.KoreaErrorMessage:completeAnimation()
			f69_arg0.KoreaErrorMessage:setAlpha(1)
			f69_arg0.clipFinished(f69_arg0.KoreaErrorMessage)
		end,
		HideForGameStart = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(3)
			f70_arg0.blackFade:completeAnimation()
			f70_arg0.blackFade:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.blackFade)
			f70_arg0.KoreaErrorMessage:completeAnimation()
			f70_arg0.KoreaErrorMessage:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.KoreaErrorMessage)
			f70_arg0.BlackFadeForGameStart:completeAnimation()
			f70_arg0.BlackFadeForGameStart:setAlpha(1)
			f70_arg0.clipFinished(f70_arg0.BlackFadeForGameStart)
		end,
	},
	ShowSelect = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(3)
			f71_arg0.DirectorSelect:completeAnimation()
			f71_arg0.DirectorSelect:setAlpha(1)
			f71_arg0.clipFinished(f71_arg0.DirectorSelect)
			f71_arg0.DirectorCommonSafeAreaBottomAndLeft:completeAnimation()
			f71_arg0.DirectorCommonSafeAreaBottomAndLeft:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.DirectorCommonSafeAreaBottomAndLeft)
			f71_arg0.DirectorCommonPartyList:completeAnimation()
			f71_arg0.DirectorCommonPartyList:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.DirectorCommonPartyList)
		end,
		HideForGameStart = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(2)
			local f72_local0 = function(f73_arg0)
				f72_arg0.DirectorSelect:beginAnimation(750)
				f72_arg0.DirectorSelect:setAlpha(0)
				f72_arg0.DirectorSelect:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.DirectorSelect:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
			end
			f72_arg0.DirectorSelect:completeAnimation()
			f72_arg0.DirectorSelect:setAlpha(1)
			f72_local0(f72_arg0.DirectorSelect)
			local f72_local1 = function(f74_arg0)
				f72_arg0.BlackFadeForGameStart:beginAnimation(750)
				f72_arg0.BlackFadeForGameStart:setAlpha(1)
				f72_arg0.BlackFadeForGameStart:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.BlackFadeForGameStart:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
			end
			f72_arg0.BlackFadeForGameStart:completeAnimation()
			f72_arg0.BlackFadeForGameStart:setAlpha(0)
			f72_local1(f72_arg0.BlackFadeForGameStart)
		end,
	},
	ShowPregame = {
		DefaultClip = function(f75_arg0, f75_arg1)
			f75_arg0:__resetProperties()
			f75_arg0:setupElementClipCounter(2)
			f75_arg0.ScorestreakAspectRatioFix:completeAnimation()
			f75_arg0.ScorestreakAspectRatioFix:setAlpha(1)
			f75_arg0.clipFinished(f75_arg0.ScorestreakAspectRatioFix)
			f75_arg0.DirectorPregame:completeAnimation()
			f75_arg0.DirectorPregame:setAlpha(1)
			f75_arg0.clipFinished(f75_arg0.DirectorPregame)
		end,
		HideForGameStart = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(2)
			local f76_local0 = function(f77_arg0)
				f76_arg0.DirectorPregame:beginAnimation(750)
				f76_arg0.DirectorPregame:setAlpha(0)
				f76_arg0.DirectorPregame:registerEventHandler("interrupted_keyframe", f76_arg0.clipInterrupted)
				f76_arg0.DirectorPregame:registerEventHandler("transition_complete_keyframe", f76_arg0.clipFinished)
			end
			f76_arg0.DirectorPregame:completeAnimation()
			f76_arg0.DirectorPregame:setAlpha(1)
			f76_local0(f76_arg0.DirectorPregame)
			local f76_local1 = function(f78_arg0)
				f76_arg0.BlackFadeForGameStart:beginAnimation(750)
				f76_arg0.BlackFadeForGameStart:setAlpha(1)
				f76_arg0.BlackFadeForGameStart:registerEventHandler("interrupted_keyframe", f76_arg0.clipInterrupted)
				f76_arg0.BlackFadeForGameStart:registerEventHandler("transition_complete_keyframe", f76_arg0.clipFinished)
			end
			f76_arg0.BlackFadeForGameStart:completeAnimation()
			f76_arg0.BlackFadeForGameStart:setAlpha(0)
			f76_local1(f76_arg0.BlackFadeForGameStart)
		end,
	},
	ShowPrivate = {
		DefaultClip = function(f79_arg0, f79_arg1)
			f79_arg0:__resetProperties()
			f79_arg0:setupElementClipCounter(2)
			f79_arg0.ScorestreakAspectRatioFix:completeAnimation()
			f79_arg0.ScorestreakAspectRatioFix:setAlpha(1)
			f79_arg0.clipFinished(f79_arg0.ScorestreakAspectRatioFix)
			f79_arg0.DirectorPrivate:completeAnimation()
			f79_arg0.DirectorPrivate:setAlpha(1)
			f79_arg0.clipFinished(f79_arg0.DirectorPrivate)
		end,
		HideForGameStart = function(f80_arg0, f80_arg1)
			f80_arg0:__resetProperties()
			f80_arg0:setupElementClipCounter(2)
			local f80_local0 = function(f81_arg0)
				f80_arg0.DirectorPrivate:beginAnimation(750)
				f80_arg0.DirectorPrivate:setAlpha(0)
				f80_arg0.DirectorPrivate:registerEventHandler("interrupted_keyframe", f80_arg0.clipInterrupted)
				f80_arg0.DirectorPrivate:registerEventHandler("transition_complete_keyframe", f80_arg0.clipFinished)
			end
			f80_arg0.DirectorPrivate:completeAnimation()
			f80_arg0.DirectorPrivate:setAlpha(1)
			f80_local0(f80_arg0.DirectorPrivate)
			local f80_local1 = function(f82_arg0)
				f80_arg0.BlackFadeForGameStart:beginAnimation(750)
				f80_arg0.BlackFadeForGameStart:setAlpha(1)
				f80_arg0.BlackFadeForGameStart:registerEventHandler("interrupted_keyframe", f80_arg0.clipInterrupted)
				f80_arg0.BlackFadeForGameStart:registerEventHandler("transition_complete_keyframe", f80_arg0.clipFinished)
			end
			f80_arg0.BlackFadeForGameStart:completeAnimation()
			f80_arg0.BlackFadeForGameStart:setAlpha(0)
			f80_local1(f80_arg0.BlackFadeForGameStart)
		end,
	},
	ShowCustom = {
		DefaultClip = function(f83_arg0, f83_arg1)
			f83_arg0:__resetProperties()
			f83_arg0:setupElementClipCounter(4)
			f83_arg0.ScorestreakAspectRatioFix:completeAnimation()
			f83_arg0.ScorestreakAspectRatioFix:setAlpha(1)
			f83_arg0.clipFinished(f83_arg0.ScorestreakAspectRatioFix)
			f83_arg0.DirectorCustom:completeAnimation()
			f83_arg0.DirectorCustom:setAlpha(1)
			f83_arg0.clipFinished(f83_arg0.DirectorCustom)
			f83_arg0.DirectorCommonSafeAreaBottomAndLeft:completeAnimation()
			f83_arg0.DirectorCommonSafeAreaBottomAndLeft:setAlpha(0)
			f83_arg0.clipFinished(f83_arg0.DirectorCommonSafeAreaBottomAndLeft)
			f83_arg0.DirectorCommonPartyList:completeAnimation()
			f83_arg0.DirectorCommonPartyList:setAlpha(0)
			f83_arg0.clipFinished(f83_arg0.DirectorCommonPartyList)
		end,
		HideForGameStart = function(f84_arg0, f84_arg1)
			f84_arg0:__resetProperties()
			f84_arg0:setupElementClipCounter(4)
			f84_arg0.DirectorCustom:completeAnimation()
			f84_arg0.DirectorCustom:setAlpha(1)
			f84_arg0.clipFinished(f84_arg0.DirectorCustom)
			f84_arg0.DirectorCommonSafeAreaBottomAndLeft:completeAnimation()
			f84_arg0.DirectorCommonSafeAreaBottomAndLeft:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.DirectorCommonSafeAreaBottomAndLeft)
			f84_arg0.DirectorCommonPartyList:completeAnimation()
			f84_arg0.DirectorCommonPartyList:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.DirectorCommonPartyList)
			local f84_local0 = function(f85_arg0)
				f84_arg0.blackFade:beginAnimation(200)
				f84_arg0.blackFade:setAlpha(0.8)
				f84_arg0.blackFade:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.blackFade:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
			end
			f84_arg0.blackFade:completeAnimation()
			f84_arg0.blackFade:setAlpha(0)
			f84_local0(f84_arg0.blackFade)
		end,
	},
	ShowArena = {
		DefaultClip = function(f86_arg0, f86_arg1)
			f86_arg0:__resetProperties()
			f86_arg0:setupElementClipCounter(2)
			f86_arg0.ScorestreakAspectRatioFix:completeAnimation()
			f86_arg0.ScorestreakAspectRatioFix:setAlpha(1)
			f86_arg0.clipFinished(f86_arg0.ScorestreakAspectRatioFix)
			f86_arg0.DirectorArenaPregame:completeAnimation()
			f86_arg0.DirectorArenaPregame:setAlpha(1)
			f86_arg0.clipFinished(f86_arg0.DirectorArenaPregame)
		end,
		HideForGameStart = function(f87_arg0, f87_arg1)
			f87_arg0:__resetProperties()
			f87_arg0:setupElementClipCounter(1)
			local f87_local0 = function(f88_arg0)
				f87_arg0.blackFade:beginAnimation(200)
				f87_arg0.blackFade:setAlpha(0.8)
				f87_arg0.blackFade:registerEventHandler("interrupted_keyframe", f87_arg0.clipInterrupted)
				f87_arg0.blackFade:registerEventHandler("transition_complete_keyframe", f87_arg0.clipFinished)
			end
			f87_arg0.blackFade:completeAnimation()
			f87_arg0.blackFade:setAlpha(0)
			f87_local0(f87_arg0.blackFade)
		end,
	},
	ShowArenaMatchmaking = {
		DefaultClip = function(f89_arg0, f89_arg1)
			f89_arg0:__resetProperties()
			f89_arg0:setupElementClipCounter(2)
			f89_arg0.ScorestreakAspectRatioFix:completeAnimation()
			f89_arg0.ScorestreakAspectRatioFix:setAlpha(1)
			f89_arg0.clipFinished(f89_arg0.ScorestreakAspectRatioFix)
			f89_arg0.DirectorArenaMatchmaking:completeAnimation()
			f89_arg0.DirectorArenaMatchmaking:setAlpha(1)
			f89_arg0.clipFinished(f89_arg0.DirectorArenaMatchmaking)
		end,
		HideForGameStart = function(f90_arg0, f90_arg1)
			f90_arg0:__resetProperties()
			f90_arg0:setupElementClipCounter(2)
			local f90_local0 = function(f91_arg0)
				f90_arg0.DirectorArenaMatchmaking:beginAnimation(750)
				f90_arg0.DirectorArenaMatchmaking:setAlpha(0)
				f90_arg0.DirectorArenaMatchmaking:registerEventHandler("interrupted_keyframe", f90_arg0.clipInterrupted)
				f90_arg0.DirectorArenaMatchmaking:registerEventHandler("transition_complete_keyframe", f90_arg0.clipFinished)
			end
			f90_arg0.DirectorArenaMatchmaking:completeAnimation()
			f90_arg0.DirectorArenaMatchmaking:setAlpha(1)
			f90_local0(f90_arg0.DirectorArenaMatchmaking)
			local f90_local1 = function(f92_arg0)
				f90_arg0.BlackFadeForGameStart:beginAnimation(750)
				f90_arg0.BlackFadeForGameStart:setAlpha(1)
				f90_arg0.BlackFadeForGameStart:registerEventHandler("interrupted_keyframe", f90_arg0.clipInterrupted)
				f90_arg0.BlackFadeForGameStart:registerEventHandler("transition_complete_keyframe", f90_arg0.clipFinished)
			end
			f90_arg0.BlackFadeForGameStart:completeAnimation()
			f90_arg0.BlackFadeForGameStart:setAlpha(0)
			f90_local1(f90_arg0.BlackFadeForGameStart)
		end,
	},
	ShowTheater = {
		DefaultClip = function(f93_arg0, f93_arg1)
			f93_arg0:__resetProperties()
			f93_arg0:setupElementClipCounter(3)
			f93_arg0.DirectorTheater:completeAnimation()
			f93_arg0.DirectorTheater:setAlpha(1)
			f93_arg0.clipFinished(f93_arg0.DirectorTheater)
			f93_arg0.DirectorCommonSafeAreaBottomAndLeft:completeAnimation()
			f93_arg0.DirectorCommonSafeAreaBottomAndLeft:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.DirectorCommonSafeAreaBottomAndLeft)
			f93_arg0.DirectorCommonPartyList:completeAnimation()
			f93_arg0.DirectorCommonPartyList:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.DirectorCommonPartyList)
		end,
		HideForGameStart = function(f94_arg0, f94_arg1)
			f94_arg0:__resetProperties()
			f94_arg0:setupElementClipCounter(2)
			f94_arg0.DirectorTheater:completeAnimation()
			f94_arg0.DirectorTheater:setAlpha(1)
			f94_arg0.clipFinished(f94_arg0.DirectorTheater)
			local f94_local0 = function(f95_arg0)
				f94_arg0.blackFade:beginAnimation(200)
				f94_arg0.blackFade:setAlpha(0.8)
				f94_arg0.blackFade:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.blackFade:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.blackFade:completeAnimation()
			f94_arg0.blackFade:setAlpha(0)
			f94_local0(f94_arg0.blackFade)
		end,
	},
	ShowPublic = {
		DefaultClip = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(3)
			f96_arg0.ScorestreakAspectRatioFix:completeAnimation()
			f96_arg0.ScorestreakAspectRatioFix:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.ScorestreakAspectRatioFix)
			f96_arg0.DirectorPublic:completeAnimation()
			f96_arg0.DirectorPublic:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.DirectorPublic)
			f96_arg0.BackingGrayMediumLeft:completeAnimation()
			f96_arg0.BackingGrayMediumLeft:setAlpha(0)
			f96_arg0.clipFinished(f96_arg0.BackingGrayMediumLeft)
		end,
		HideForGameStart = function(f97_arg0, f97_arg1)
			f97_arg0:__resetProperties()
			f97_arg0:setupElementClipCounter(3)
			local f97_local0 = function(f98_arg0)
				f97_arg0.DirectorPublic:beginAnimation(750)
				f97_arg0.DirectorPublic:setAlpha(0)
				f97_arg0.DirectorPublic:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.DirectorPublic:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
			end
			f97_arg0.DirectorPublic:completeAnimation()
			f97_arg0.DirectorPublic:setAlpha(1)
			f97_local0(f97_arg0.DirectorPublic)
			local f97_local1 = function(f99_arg0)
				f97_arg0.BackingGrayMediumLeft:beginAnimation(750)
				f97_arg0.BackingGrayMediumLeft:setAlpha(1)
				f97_arg0.BackingGrayMediumLeft:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.BackingGrayMediumLeft:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
			end
			f97_arg0.BackingGrayMediumLeft:completeAnimation()
			f97_arg0.BackingGrayMediumLeft:setAlpha(0)
			f97_local1(f97_arg0.BackingGrayMediumLeft)
			local f97_local2 = function(f100_arg0)
				f97_arg0.BlackFadeForGameStart:beginAnimation(750)
				f97_arg0.BlackFadeForGameStart:setAlpha(1)
				f97_arg0.BlackFadeForGameStart:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.BlackFadeForGameStart:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
			end
			f97_arg0.BlackFadeForGameStart:completeAnimation()
			f97_arg0.BlackFadeForGameStart:setAlpha(0)
			f97_local2(f97_arg0.BlackFadeForGameStart)
		end,
	},
	ShowTraining = {
		DefaultClip = function(f101_arg0, f101_arg1)
			f101_arg0:__resetProperties()
			f101_arg0:setupElementClipCounter(3)
			f101_arg0.DirectorTraining:completeAnimation()
			f101_arg0.DirectorTraining:setAlpha(1)
			f101_arg0.clipFinished(f101_arg0.DirectorTraining)
			f101_arg0.DirectorCommonSafeAreaBottomAndLeft:completeAnimation()
			f101_arg0.DirectorCommonSafeAreaBottomAndLeft:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.DirectorCommonSafeAreaBottomAndLeft)
			f101_arg0.DirectorCommonPartyList:completeAnimation()
			f101_arg0.DirectorCommonPartyList:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.DirectorCommonPartyList)
		end,
		HideForGameStart = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(2)
			f102_arg0.DirectorCustom:completeAnimation()
			f102_arg0.DirectorCustom:setAlpha(1)
			f102_arg0.clipFinished(f102_arg0.DirectorCustom)
			local f102_local0 = function(f103_arg0)
				f102_arg0.blackFade:beginAnimation(200)
				f102_arg0.blackFade:setAlpha(0.8)
				f102_arg0.blackFade:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
				f102_arg0.blackFade:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
			end
			f102_arg0.blackFade:completeAnimation()
			f102_arg0.blackFade:setAlpha(0)
			f102_local0(f102_arg0.blackFade)
		end,
	},
}
CoD.Director.__onClose = function(f104_arg0)
	f104_arg0.ScorestreakAspectRatioFix:close()
	f104_arg0.FullScreenBlack:close()
	f104_arg0.SearchQoSJoinList:close()
	f104_arg0.DirectorTheater:close()
	f104_arg0.DirectorCustom:close()
	f104_arg0.DirectorTraining:close()
	f104_arg0.DirectorArenaMatchmaking:close()
	f104_arg0.DirectorArenaPregame:close()
	f104_arg0.DirectorPublic:close()
	f104_arg0.DirectorPrivate:close()
	f104_arg0.DirectorPregame:close()
	f104_arg0.DirectorSelect:close()
	f104_arg0.DirectorCommonSafeAreaBottomAndLeft:close()
	f104_arg0.DirectorCommonPartyList:close()
	f104_arg0.ChatClient:close()
	f104_arg0.ChatClientPassiveEntryDisplay:close()
	f104_arg0.FooterContainerFrontendRight:close()
	f104_arg0.BackingGrayMediumLeft:close()
	f104_arg0.blackFade:close()
	f104_arg0.FrontendBattlenetContainer:close()
	f104_arg0.PCNotif:close()
end
