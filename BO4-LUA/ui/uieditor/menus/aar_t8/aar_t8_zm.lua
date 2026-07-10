require("x64:19bf86db65af0e")
require("x64:bc43f0e5d65041e")
require("x64:2caedcdba8e68d0")
require("x64:dcd854a7bb6c2c2")
require("x64:93feffa3a82d41c")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:233e193bf9509f4")
require("x64:feb272637b3842")
require("x64:a1b9abe59dc83dc")
require("x64:9d68986bd32e9fe")
require("x64:db2330a5cdd63e8")
CoD.AAR_T8_ZM = InheritFrom(CoD.Menu)
LUI.createMenu.AAR_T8_ZM = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AAR_T8_ZM", f1_arg0)
	local f1_local1 = self
	CoD.AARUtility.InitAARModels(f1_arg0)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.AAR_T8_ZM)
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
	local AARSummaryTab = CoD.AARSummaryTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -442, 458)
	AARSummaryTab:subscribeToGlobalModel(f1_arg0, "AARSummaryStats", nil, function(model)
		AARSummaryTab:setModel(model, f1_arg0)
	end)
	self:addElement(AARSummaryTab)
	self.AARSummaryTab = AARSummaryTab
	local AARContractsTab = CoD.AARContractsTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	self:addElement(AARContractsTab)
	self.AARContractsTab = AARContractsTab
	local ZMAARScoreboardTab = CoD.ZMAARScoreboardTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -442, 458)
	ZMAARScoreboardTab:subscribeToGlobalModel(f1_arg0, "AARSummaryStats", nil, function(model)
		ZMAARScoreboardTab:setModel(model, f1_arg0)
	end)
	self:addElement(ZMAARScoreboardTab)
	self.ZMAARScoreboardTab = ZMAARScoreboardTab
	local ZMAARTrialTab = CoD.ZMAARTrialTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -442, 458)
	ZMAARTrialTab:subscribeToGlobalModel(f1_arg0, "AARSummaryStats", nil, function(model)
		ZMAARTrialTab:setModel(model, f1_arg0)
	end)
	self:addElement(ZMAARTrialTab)
	self.ZMAARTrialTab = ZMAARTrialTab
	local AARMedalsTab = CoD.AARMedalsTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -442, 458)
	AARMedalsTab:setAlpha(0)
	self:addElement(AARMedalsTab)
	self.AARMedalsTab = AARMedalsTab
	local AARRewardsTab = CoD.AARRewardsTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -442, 458)
	self:addElement(AARRewardsTab)
	self.AARRewardsTab = AARRewardsTab
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local StageNotificationContainer = CoD.StageNotificationContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 120)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg0, "MapVote", "mapVoteGameModeNext", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.StageTitle:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f6_local0))
		end
	end)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "publicLobby.stageDetails", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.subtitle:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f7_local0)))
		end
	end)
	StageNotificationContainer:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(StageNotificationContainer)
	self.StageNotificationContainer = StageNotificationContainer
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_5EEF90B1483C4C23"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f10_local0 = nil
		if element.menuLoaded then
			f10_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f10_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f10_local0 then
			f10_local0 = element:dispatchEventToChildren(event)
		end
		return f10_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local ZMAARStampWidget = CoD.ZMAARStampWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 514, 854, 0.5, 0.5, -298, -218)
	self:addElement(ZMAARStampWidget)
	self.ZMAARStampWidget = ZMAARStampWidget
	local ScoreboardTab = CoD.AARScoreboardTabButton.new(f1_local1, f1_arg0, 0.5, 0.5, -339, 339, 0, 0, 13, 47)
	ScoreboardTab:registerEventHandler("menu_loaded", function(element, event)
		local f11_local0 = nil
		if element.menuLoaded then
			f11_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f11_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f11_local0 then
			f11_local0 = element:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self:addElement(ScoreboardTab)
	self.ScoreboardTab = ScoreboardTab
	local TopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	TopBar:registerEventHandler("menu_loaded", function(element, event)
		local f12_local0 = nil
		if element.menuLoaded then
			f12_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f12_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f12_local0 then
			f12_local0 = element:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local DoubleXPNotification = CoD.AARDoubleXPNotification.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	DoubleXPNotification:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
			end,
		},
	})
	local f1_local16 = DoubleXPNotification
	local f1_local17 = DoubleXPNotification.subscribeToModel
	local f1_local18 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local17(f1_local16, f1_local18["AAR.activeTab"], function(f14_arg0)
		f1_local1:updateElementState(DoubleXPNotification, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	self:addElement(DoubleXPNotification)
	self.DoubleXPNotification = DoubleXPNotification
	self:mergeStateConditions({
		{
			stateName = "Offline_IGR",
			condition = function(menu, element, event)
				local f15_local0 = IsPC()
				if f15_local0 then
					f15_local0 = CoD.PCKoreaUtility.IsInIGR()
					if f15_local0 then
						f15_local0 = IsLobbyNetworkModeLAN()
					end
				end
				return f15_local0
			end,
		},
		{
			stateName = "DefaultState_IGR",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.IsInIGR()
			end,
		},
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
	})
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[@"getglobalmodel"]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNav"], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[@"getglobalmodel"]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNav"], function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
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
	self.__on_menuOpened_self = function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
		local f26_local0 = self
		CoD.AARUtility.OpenAAROverlays(f26_arg2, f26_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "AAR.activeTab", function(model)
		local f28_local0 = self
		CoD.AARUtility.UpdateAARScene(f1_local1, f1_arg0)
	end)
	AARSummaryTab.id = "AARSummaryTab"
	AARContractsTab.id = "AARContractsTab"
	ZMAARScoreboardTab.id = "ZMAARScoreboardTab"
	ZMAARTrialTab.id = "ZMAARTrialTab"
	AARMedalsTab.id = "AARMedalsTab"
	AARRewardsTab.id = "AARRewardsTab"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	ScoreboardTab.id = "ScoreboardTab"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = AARSummaryTab
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
	f1_local17 = self
	CoD.AARUtility.AARFirstTimeOpenActions(self, f1_arg0, f1_local1)
	CoD.AARUtility.AnimateCurrentLevelProgress(f1_local1, f1_arg0)
	f1_local17 = DoubleXPNotification
	if not IsPC() then
		SizeToSafeArea(f1_local17, f1_arg0)
	end
	return self
end
CoD.AAR_T8_ZM.__resetProperties = function(f30_arg0)
	f30_arg0.CommonHeader:completeAnimation()
	f30_arg0.StageNotificationContainer:completeAnimation()
	f30_arg0.ZMAARStampWidget:completeAnimation()
	f30_arg0.CommonHeader:setAlpha(1)
	f30_arg0.StageNotificationContainer:setAlpha(1)
	f30_arg0.ZMAARStampWidget:setTopBottom(0.5, 0.5, -298, -218)
end
CoD.AAR_T8_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.StageNotificationContainer:completeAnimation()
			f31_arg0.StageNotificationContainer:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.StageNotificationContainer)
			f31_arg0.CommonHeader:completeAnimation()
			f31_arg0.CommonHeader:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.CommonHeader)
		end,
	},
	Offline_IGR = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.StageNotificationContainer:completeAnimation()
			f32_arg0.StageNotificationContainer:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.StageNotificationContainer)
			f32_arg0.ZMAARStampWidget:completeAnimation()
			f32_arg0.ZMAARStampWidget:setTopBottom(0.5, 0.5, -127, -47)
			f32_arg0.clipFinished(f32_arg0.ZMAARStampWidget)
		end,
	},
	DefaultState_IGR = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			f33_arg0.StageNotificationContainer:completeAnimation()
			f33_arg0.StageNotificationContainer:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.StageNotificationContainer)
			f33_arg0.CommonHeader:completeAnimation()
			f33_arg0.CommonHeader:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.CommonHeader)
			f33_arg0.ZMAARStampWidget:completeAnimation()
			f33_arg0.ZMAARStampWidget:setTopBottom(0.5, 0.5, -127, -47)
			f33_arg0.clipFinished(f33_arg0.ZMAARStampWidget)
		end,
	},
	Offline = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.StageNotificationContainer:completeAnimation()
			f34_arg0.StageNotificationContainer:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.StageNotificationContainer)
		end,
	},
}
CoD.AAR_T8_ZM.__onClose = function(f35_arg0)
	f35_arg0.__on_close_removeOverrides()
	f35_arg0.AARSummaryTab:close()
	f35_arg0.AARContractsTab:close()
	f35_arg0.ZMAARScoreboardTab:close()
	f35_arg0.ZMAARTrialTab:close()
	f35_arg0.AARMedalsTab:close()
	f35_arg0.AARRewardsTab:close()
	f35_arg0.FooterContainerFrontendRight:close()
	f35_arg0.StageNotificationContainer:close()
	f35_arg0.CommonHeader:close()
	f35_arg0.ZMAARStampWidget:close()
	f35_arg0.ScoreboardTab:close()
	f35_arg0.TopBar:close()
	f35_arg0.DoubleXPNotification:close()
end
