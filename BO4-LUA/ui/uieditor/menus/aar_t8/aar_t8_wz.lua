require("x64:19bf86db65af0e")
require("x64:bc43f0e5d65041e")
require("x64:d15797b08b66dd4")
require("x64:dcd854a7bb6c2c2")
require("x64:d325629f2c60cbb")
require("x64:5299e9177f75b70")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:233e193bf9509f4")
CoD.AAR_T8_WZ = InheritFrom(CoD.Menu)
LUI.createMenu.AAR_T8_WZ = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AAR_T8_WZ", f1_arg0)
	local f1_local1 = self
	CoD.AARUtility.InitAARModels(f1_arg0)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.AAR_T8_WZ)
	self.soundSet = "CAC"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, -0.1, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local AARMeritReportTab = CoD.AARMeritReportTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	self:addElement(AARMeritReportTab)
	self.AARMeritReportTab = AARMeritReportTab
	local AARSummaryTabWZ = CoD.AARSummaryTab_WZ.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 9, 9)
	AARSummaryTabWZ:subscribeToGlobalModel(f1_arg0, "AARSummaryStats", nil, function(model)
		AARSummaryTabWZ:setModel(model, f1_arg0)
	end)
	self:addElement(AARSummaryTabWZ)
	self.AARSummaryTabWZ = AARSummaryTabWZ
	local AARContractsTab = CoD.AARContractsTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	self:addElement(AARContractsTab)
	self.AARContractsTab = AARContractsTab
	local AARSquadSummary = CoD.AARSquadSummary.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	self:addElement(AARSquadSummary)
	self.AARSquadSummary = AARSquadSummary
	local AARMedalsTab = CoD.AARMedalsTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -440, 460)
	self:addElement(AARMedalsTab)
	self.AARMedalsTab = AARMedalsTab
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local StageNotificationContainer = CoD.StageNotificationContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 120)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg0, "MapVote", "mapVoteGameModeNext", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.StageTitle:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f4_local0))
		end
	end)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "publicLobby.stageDetails", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.subtitle:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f5_local0)))
		end
	end)
	StageNotificationContainer:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(StageNotificationContainer)
	self.StageNotificationContainer = StageNotificationContainer
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_5EEF90B1483C4C23"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local ScoreboardTab = CoD.AARScoreboardTabButton.new(f1_local1, f1_arg0, 0.5, 0.5, -339, 339, 0, 0, 4, 38)
	ScoreboardTab:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(ScoreboardTab)
	self.ScoreboardTab = ScoreboardTab
	local TopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	TopBar:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(TopBar)
	self.TopBar = TopBar
	self:mergeStateConditions({
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[@"getglobalmodel"]()
	f1_local14(f1_local13, f1_local15["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getglobalmodel"]()
	f1_local14(f1_local13, f1_local15["lobbyRoot.lobbyNav"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ui_confirm", function(element, menu, controller, model)
		if not IsPC() then
			CoD.AnalyticsUtility.GoBackAndShowMatchSurveyIfNecessary(menu, controller)
			MenuUnhideFreeCursor(menu, controller)
			return true
		elseif IsPC() then
			CoD.AnalyticsUtility.GoBackAndShowMatchSurveyIfNecessary(menu, controller)
			MenuUnhideFreeCursor(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_4E4E038F4690D38D", nil, "ui_confirm")
			return true
		elseif IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], "ESCAPE", function(element, menu, controller, model)
		CoD.AnalyticsUtility.GoBackAndShowMatchSurveyIfNecessary(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "ESCAPE")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_contextual_1", function(element, menu, controller, model)
		if IsLobbyNetworkModeLive() and not IsRecentGameBookmarked(controller) then
			FileshareBookmarkRecentGame(controller)
			UpdateButtonPromptState(menu, element, controller, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyNetworkModeLive() and not IsRecentGameBookmarked(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/bookmark_game", nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
		local f20_local0 = self
		CoD.AARUtility.OpenAAROverlays(f20_arg2, f20_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "AAR.activeTab", function(model)
		local f22_local0 = self
		CoD.AARUtility.UpdateAARScene(f1_local1, f1_arg0)
	end)
	AARSummaryTabWZ.id = "AARSummaryTabWZ"
	AARContractsTab.id = "AARContractsTab"
	AARSquadSummary.id = "AARSquadSummary"
	AARMedalsTab.id = "AARMedalsTab"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	ScoreboardTab.id = "ScoreboardTab"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local14 = self
	CoD.AARUtility.AARFirstTimeOpenActions(self, f1_arg0, f1_local1)
	CoD.AARUtility.AnimateCurrentLevelProgress(f1_local1, f1_arg0)
	return self
end
CoD.AAR_T8_WZ.__resetProperties = function(f24_arg0)
	f24_arg0.CommonHeader:completeAnimation()
	f24_arg0.StageNotificationContainer:completeAnimation()
	f24_arg0.CommonHeader:setAlpha(1)
	f24_arg0.StageNotificationContainer:setAlpha(1)
end
CoD.AAR_T8_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.StageNotificationContainer:completeAnimation()
			f25_arg0.StageNotificationContainer:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.StageNotificationContainer)
			f25_arg0.CommonHeader:completeAnimation()
			f25_arg0.CommonHeader:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.CommonHeader)
		end,
	},
	Offline = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.StageNotificationContainer:completeAnimation()
			f26_arg0.StageNotificationContainer:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.StageNotificationContainer)
		end,
	},
}
CoD.AAR_T8_WZ.__onClose = function(f27_arg0)
	f27_arg0.__on_close_removeOverrides()
	f27_arg0.AARMeritReportTab:close()
	f27_arg0.AARSummaryTabWZ:close()
	f27_arg0.AARContractsTab:close()
	f27_arg0.AARSquadSummary:close()
	f27_arg0.AARMedalsTab:close()
	f27_arg0.FooterContainerFrontendRight:close()
	f27_arg0.StageNotificationContainer:close()
	f27_arg0.CommonHeader:close()
	f27_arg0.ScoreboardTab:close()
	f27_arg0.TopBar:close()
end
