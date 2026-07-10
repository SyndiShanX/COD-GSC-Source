require("x64:5587cd3245f1dc1")
require("x64:b236d88d3647924")
require("x64:def6a654efe7944")
require("x64:1b3cf3c514fa720")
require("x64:d4e0d48242633e2")
require("x64:96b6f6ba428edcc")
require("x64:d6ecdf7755aeddc")
require("x64:6385641db19d152")
require("x64:131b51676141877")
require("x64:260c7a8e3737127")
require("x64:c89d021ac8b3747")
require("x64:ea788cab9c8c2f2")
require("x64:2675595fa323085")
CoD.directorArenaPregame = InheritFrom(LUI.UIElement)
CoD.directorArenaPregame.__defaultWidth = 1920
CoD.directorArenaPregame.__defaultHeight = 1080
CoD.directorArenaPregame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.DirectorUtility.InitPublicLobbyModels(self, f1_arg1, f1_arg0)
	CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
	CoD.DirectorUtility.InitQuickPlayModel(f1_arg1)
	DataSourceHelperGetModel(f1_arg1, "Arena")
	self:setClass(CoD.directorArenaPregame)
	self.id = "directorArenaPregame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Header = CoD.DirectorScreenHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -870, -227, 0, 0, 301, 401)
	Header:setAlpha(0)
	Header:setZoom(75)
	Header.Header:setText(LocalizeToUpperString(@"menu/local"))
	self:addElement(Header)
	self.Header = Header
	local pckeyboardNavigationRedirector2 = nil
	pckeyboardNavigationRedirector2 = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.8, 384, 384, 0.27, 0.32, 0, 0)
	self:addElement(pckeyboardNavigationRedirector2)
	self.pckeyboardNavigationRedirector2 = pckeyboardNavigationRedirector2
	local pckeyboardNavigationRedirector = nil
	pckeyboardNavigationRedirector = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.8, 384, 384, 0.77, 0.82, 0, 0)
	self:addElement(pckeyboardNavigationRedirector)
	self.pckeyboardNavigationRedirector = pckeyboardNavigationRedirector
	local FindMatchButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	FindMatchButton:mergeStateConditions({
		{
			stateName = "ArenaSuspended",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.LeaverLockoutActive()
			end,
		},
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return not IsPartyLeader(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsPartyLeader(f1_arg1)
			end,
		},
	})
	local CompetitiveOverviewRankBanner = FindMatchButton
	local DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	local LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["Arena.lockoutTimeRemaining"], function(f5_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "Arena.lockoutTimeRemaining",
		})
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.privateClient.isHost"], function(f7_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.gameClient.isHost"], function(f8_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
		})
	end, false)
	FindMatchButton:appendEventHandler("on_session_start", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FindMatchButton, f9_arg1)
	end)
	FindMatchButton:appendEventHandler("on_session_end", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FindMatchButton, f10_arg1)
	end)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.gameClient.update"], function(f11_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.privateClient.update"], function(f12_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle.offlineScreenState, function(f13_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	FindMatchButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"menu/find_match"))
	FindMatchButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/find_match"))
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.lobbyNav"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.privateClient.isHost"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.gameClient.isHost"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.playlistId"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	CompetitiveOverviewRankBanner = FindMatchButton
	DirectorLobbyPoseMembers = FindMatchButton.subscribeToModel
	LeagueEventEndDelayMessageTitle = Engine[@"getglobalmodel"]()
	DirectorLobbyPoseMembers(CompetitiveOverviewRankBanner, LeagueEventEndDelayMessageTitle["lobbyRoot.lobbyList.playerCount"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	FindMatchButton:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FindMatchButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsPartyLeader(controller) and not CoD.ArenaLeaguePlayUtility.ForceCheckLeaverLockoutActive() and not CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.DirectorUtility.NavigateToArenaMatchmakingLobby(self, menu, controller, element)
			PlaySoundAlias("uin_press_generic")
			return true
		elseif IsPartyLeader(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPartyLeader(controller) and not CoD.ArenaLeaguePlayUtility.ForceCheckLeaverLockoutActive() and not CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsPartyLeader(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(FindMatchButton)
	self.FindMatchButton = FindMatchButton
	DirectorLobbyPoseMembers = CoD.DirectorLobbyPoseMembers.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(DirectorLobbyPoseMembers)
	self.DirectorLobbyPoseMembers = DirectorLobbyPoseMembers
	CompetitiveOverviewRankBanner = CoD.CompetitiveOverviewRankBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -881, -681, 0, 0, -111.5, 388.5)
	CompetitiveOverviewRankBanner:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ArenaUtility.IsArenaLeaguePlay(true)
			end,
		},
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				local f23_local0
				if not CoD.ArenaUtility.IsArenaLeaguePlay(false) then
					f23_local0 = not CoD.ArenaLeaguePlayUtility.HasPoints(self, f1_arg1)
				else
					f23_local0 = false
				end
				return f23_local0
			end,
		},
		{
			stateName = "Lobby",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local CustomGamesButton = CompetitiveOverviewRankBanner
	LeagueEventEndDelayMessageTitle = CompetitiveOverviewRankBanner.subscribeToModel
	local CommonHeader = Engine[@"getglobalmodel"]()
	LeagueEventEndDelayMessageTitle(CustomGamesButton, CommonHeader["lobbyRoot.lobbyNav"], function(f25_arg0)
		f1_arg0:updateElementState(CompetitiveOverviewRankBanner, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CompetitiveOverviewRankBanner:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyNav", function(model)
		UpdateSelfElementState(f1_arg0, CompetitiveOverviewRankBanner, f1_arg1)
	end)
	self:addElement(CompetitiveOverviewRankBanner)
	self.CompetitiveOverviewRankBanner = CompetitiveOverviewRankBanner
	LeagueEventEndDelayMessageTitle = CoD.LeaguePlayEventEndDelayLobbyMessage.new(f1_arg0, f1_arg1, 0.5, 0.5, -691, -179, 0, 0, 55.5, 205.5)
	self:addElement(LeagueEventEndDelayMessageTitle)
	self.LeagueEventEndDelayMessageTitle = LeagueEventEndDelayMessageTitle
	CustomGamesButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -522, -476)
	CustomGamesButton:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f27_local0 = IsLobbyHostOfCurrentMenu()
				if f27_local0 then
					f27_local0 = IsArenaMode()
					if f27_local0 then
						f27_local0 = CoD.DirectorUtility.ShowDirectorArena(f1_arg1)
					end
				end
				return f27_local0
			end,
		},
	})
	CustomGamesButton:appendEventHandler("on_session_start", function(f28_arg0, f28_arg1)
		f28_arg1.menu = f28_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CustomGamesButton, f28_arg1)
	end)
	CustomGamesButton:appendEventHandler("on_session_end", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CustomGamesButton, f29_arg1)
	end)
	local DirectorLeaderActivitySelect = CustomGamesButton
	CommonHeader = CustomGamesButton.subscribeToModel
	local ArenaEventButtons = Engine[@"getglobalmodel"]()
	CommonHeader(DirectorLeaderActivitySelect, ArenaEventButtons["lobbyRoot.lobbyNav"], function(f30_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorLeaderActivitySelect = CustomGamesButton
	CommonHeader = CustomGamesButton.subscribeToModel
	ArenaEventButtons = Engine[@"getglobalmodel"]()
	CommonHeader(DirectorLeaderActivitySelect, ArenaEventButtons["lobbyRoot.gameClient.update"], function(f31_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	DirectorLeaderActivitySelect = CustomGamesButton
	CommonHeader = CustomGamesButton.subscribeToModel
	ArenaEventButtons = Engine[@"getglobalmodel"]()
	CommonHeader(DirectorLeaderActivitySelect, ArenaEventButtons["lobbyRoot.privateClient.update"], function(f32_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	DirectorLeaderActivitySelect = CustomGamesButton
	CommonHeader = CustomGamesButton.subscribeToModel
	ArenaEventButtons = Engine[@"getglobalmodel"]()
	CommonHeader(DirectorLeaderActivitySelect, ArenaEventButtons.offlineScreenState, function(f33_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference = function()
		CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(CoD.DirectorUtility.GetCustomGamesName(@"menu/custom_games")))
	end
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference()
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String = function()
		CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(CoD.DirectorUtility.GetCustomGamesName(@"menu/custom_games")))
	end
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String()
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	CustomGamesButton:registerEventHandler("gain_focus", function(element, event)
		local f36_local0 = nil
		if element.gainFocus then
			f36_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f36_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f36_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CustomGamesButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			PlaySoundAlias("uin_press_generic")
			OpenCustomGamesLobby(menu, controller)
			return true
		else
			PlaySoundAlias("uin_press_generic")
			OpenSystemOverlay(self, menu, controller, "CustomGamesNotification")
			SetLoseFocusToSelf(self, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(CustomGamesButton)
	self.CustomGamesButton = CustomGamesButton
	CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader.subtitle.subtitle:setText("")
	CommonHeader:subscribeToGlobalModel(f1_arg1, "Arena", "arenaTitle", function(model)
		local f39_local0 = model:get()
		if f39_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(f39_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	DirectorLeaderActivitySelect = CoD.DirectorLeaderActivitySelect.new(f1_arg0, f1_arg1, 0.5, 0.5, 625, 930, 0, 0, 8, 57)
	DirectorLeaderActivitySelect:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	DirectorLeaderActivitySelect:appendEventHandler("on_session_start", function(f41_arg0, f41_arg1)
		f41_arg1.menu = f41_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, f41_arg1)
	end)
	DirectorLeaderActivitySelect:appendEventHandler("on_session_end", function(f42_arg0, f42_arg1)
		f42_arg1.menu = f42_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, f42_arg1)
	end)
	local ArenaEventProgressButton = DirectorLeaderActivitySelect
	ArenaEventButtons = DirectorLeaderActivitySelect.subscribeToModel
	local ArenaTeamDisplay = Engine[@"getglobalmodel"]()
	ArenaEventButtons(ArenaEventProgressButton, ArenaTeamDisplay["lobbyRoot.lobbyNav"], function(f43_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ArenaEventProgressButton = DirectorLeaderActivitySelect
	ArenaEventButtons = DirectorLeaderActivitySelect.subscribeToModel
	ArenaTeamDisplay = Engine[@"getglobalmodel"]()
	ArenaEventButtons(ArenaEventProgressButton, ArenaTeamDisplay["lobbyRoot.gameClient.update"], function(f44_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	ArenaEventProgressButton = DirectorLeaderActivitySelect
	ArenaEventButtons = DirectorLeaderActivitySelect.subscribeToModel
	ArenaTeamDisplay = Engine[@"getglobalmodel"]()
	ArenaEventButtons(ArenaEventProgressButton, ArenaTeamDisplay["lobbyRoot.privateClient.update"], function(f45_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	DirectorLeaderActivitySelect:setAlpha(0)
	self:addElement(DirectorLeaderActivitySelect)
	self.DirectorLeaderActivitySelect = DirectorLeaderActivitySelect
	ArenaEventButtons = CoD.ArenaEventButtons.new(f1_arg0, f1_arg1, 0.5, 0.5, 250, 450, 1, 1, -178, -108)
	ArenaEventButtons:setAlpha(0)
	self:addElement(ArenaEventButtons)
	self.ArenaEventButtons = ArenaEventButtons
	ArenaEventProgressButton = CoD.ArenaEventProgressButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -279, -209)
	self:addElement(ArenaEventProgressButton)
	self.ArenaEventProgressButton = ArenaEventProgressButton
	ArenaTeamDisplay = CoD.ArenaTeamDisplay.new(f1_arg0, f1_arg1, 0, 0, 1170, 1420, 0, 0, 218.5, 518.5)
	self:addElement(ArenaTeamDisplay)
	self.ArenaTeamDisplay = ArenaTeamDisplay
	local ArenaDailyBonus = CoD.ArenaDailyBonus.new(f1_arg0, f1_arg1, 0.5, 0.5, 250, 450, 1, 1, -258, -188)
	ArenaDailyBonus:setAlpha(0)
	self:addElement(ArenaDailyBonus)
	self.ArenaDailyBonus = ArenaDailyBonus
	local ArenaMapAndGameType = CoD.ArenaMapAndGameType.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -443, -293)
	self:addElement(ArenaMapAndGameType)
	self.ArenaMapAndGameType = ArenaMapAndGameType
	local f1_local16 = CustomGamesButton
	local f1_local17 = CustomGamesButton.subscribeToModel
	local f1_local18 = Engine[@"getglobalmodel"]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference)
	f1_local16 = CustomGamesButton
	f1_local17 = CustomGamesButton.subscribeToModel
	f1_local18 = Engine[@"getglobalmodel"]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String)
	self:mergeStateConditions({
		{
			stateName = "IsPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f47_arg2, f47_arg3, f47_arg4)
		ForceCheckDefaultPCFocus(element, f1_arg0, controller)
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "gameClientDataUpdate", function(model)
		local f48_local0 = self
		if CoD.DirectorUtility.ShowDirectorArena(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "clientUpdated", function(model)
		local f49_local0 = self
		if CoD.DirectorUtility.ShowDirectorArena(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyNav", function(model)
		local f50_local0 = self
		if IsLobbyHost() and CoD.DirectorUtility.IsLobbyMenu(f1_arg1, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
			UpdateElementState(self, "ArenaTeamDisplay", f1_arg1)
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.FindMatchButton)
		elseif not IsLobbyHost() and CoD.DirectorUtility.ShowDirectorArena(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
			UpdateElementState(self, "ArenaTeamDisplay", f1_arg1)
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.HomeOrPlayList)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "LobbyRoot.gameClient.isHost", function(model)
		local f51_local0 = self
		UpdateElementState(self, "FindMatchButton", f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "LobbyRoot.privateClient.isHost", function(model)
		local f52_local0 = self
		UpdateElementState(self, "FindMatchButton", f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "Arena.triggerEndOfEvent", function(model)
		local f53_local0 = self
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "Arena", "triggerEndOfEvent") and CoD.DirectorUtility.IsLobbyMenu(f1_arg1, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) then
			OpenSystemOverlay(self, f1_arg0, f1_arg1, "ArenaEventDone", nil)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "Arena.arenaLeaguePlayShowEndRankUp", function(model)
		local f54_local0 = self
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "Arena", "arenaLeaguePlayShowEndRankUp") and not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "Arena", "triggerEndOfEvent") and CoD.DirectorUtility.IsLobbyMenu(f1_arg1, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) then
			CoD.ArenaLeaguePlayUtility.OpenLeaguePlayEndRankUp(self, f1_arg1)
			SetGlobalModelValueFalse("Arena.arenaLeaguePlayShowDelayedResultsPopup")
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "Arena.arenaLeaguePlayShowDelayedResultsPopup", function(model)
		local f55_local0 = self
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "Arena", "arenaLeaguePlayShowDelayedResultsPopup") and not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "Arena", "arenaLeaguePlayShowEndRankUp") and not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "Arena", "triggerEndOfEvent") and CoD.DirectorUtility.IsLobbyMenu(f1_arg1, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) then
			OpenSystemOverlay(self, f1_arg0, f1_arg1, "Arena_EventEndResultsDelay", nil)
			SetGlobalModelValueFalse("Arena.arenaLeaguePlayShowDelayedResultsPopup")
		end
	end)
	if CoD.isPC then
		pckeyboardNavigationRedirector2.id = "pckeyboardNavigationRedirector2"
	end
	if CoD.isPC then
		pckeyboardNavigationRedirector.id = "pckeyboardNavigationRedirector"
	end
	FindMatchButton.id = "FindMatchButton"
	CustomGamesButton.id = "CustomGamesButton"
	ArenaEventButtons.id = "ArenaEventButtons"
	ArenaEventProgressButton.id = "ArenaEventProgressButton"
	ArenaMapAndGameType.id = "ArenaMapAndGameType"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local17 = self
	CoD.ArenaUtility.PostLoad(f1_arg1, self)
	f1_local17 = pckeyboardNavigationRedirector2
	if IsPC() then
		CoD.PCUtility.SetAsRedirectItem(f1_local17)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local17, self.Loadouts)
	end
	f1_local17 = pckeyboardNavigationRedirector
	if IsPC() then
		CoD.PCUtility.SetAsRedirectItem(f1_local17)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local17, self.Loadouts)
	end
	return self
end
CoD.directorArenaPregame.__onClose = function(f56_arg0)
	f56_arg0.Header:close()
	f56_arg0.pckeyboardNavigationRedirector2:close()
	f56_arg0.pckeyboardNavigationRedirector:close()
	f56_arg0.FindMatchButton:close()
	f56_arg0.DirectorLobbyPoseMembers:close()
	f56_arg0.CompetitiveOverviewRankBanner:close()
	f56_arg0.LeagueEventEndDelayMessageTitle:close()
	f56_arg0.CustomGamesButton:close()
	f56_arg0.CommonHeader:close()
	f56_arg0.DirectorLeaderActivitySelect:close()
	f56_arg0.ArenaEventButtons:close()
	f56_arg0.ArenaEventProgressButton:close()
	f56_arg0.ArenaTeamDisplay:close()
	f56_arg0.ArenaDailyBonus:close()
	f56_arg0.ArenaMapAndGameType:close()
end
