require("x64:5587cd3245f1dc1")
require("x64:b236d88d3647924")
require("x64:def6a654efe7944")
require("x64:67940364f14a232")
require("x64:7b2e5c29b34a47e")
require("x64:d4ed3fd8d1fcc4a")
require("x64:e41af73729601d6")
require("x64:429ef25909713fe")
require("x64:233e193bf9509f4")
CoD.directorArenaMatchmaking = InheritFrom(LUI.UIElement)
CoD.directorArenaMatchmaking.__defaultWidth = 1920
CoD.directorArenaMatchmaking.__defaultHeight = 1080
CoD.directorArenaMatchmaking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.DirectorUtility.InitPublicLobbyModels(self, f1_arg1, f1_arg0)
	CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
	self:setClass(CoD.directorArenaMatchmaking)
	self.id = "directorArenaMatchmaking"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StageNotificationContainer = CoD.StageNotificationContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 120)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.StageTitle:setText(ToUpper(f2_local0))
		end
	end)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.stageDetails", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.subtitle:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f3_local0)))
		end
	end)
	self:addElement(StageNotificationContainer)
	self.StageNotificationContainer = StageNotificationContainer
	local TopBar = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.MapVote = f1_local3
	local MapVotePC = nil
	MapVotePC = CoD.MapVote.new(f1_arg0, f1_arg1, 0.5, 0.5, -505, 406, 1, 1, -399, -184)
	MapVotePC:mergeStateConditions({
		{
			stateName = "MapVote",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.VOTING) and AlwaysFalse()
			end,
		},
		{
			stateName = "MapVoteChosenNext",
			condition = function(menu, element, event)
				local f5_local0 = CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN)
				if f5_local0 then
					f5_local0 = CoD.ModelUtility.IsGlobalModelValueEqualToEnum("MapVote.lobbyMapVoteType", Enum[@"lobbymapvote"][@"lobby_mapvote_next"])
					if f5_local0 then
						f5_local0 = AlwaysFalse()
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "MapVoteChosenPrevious",
			condition = function(menu, element, event)
				local f6_local0 = CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN)
				if f6_local0 then
					f6_local0 = CoD.ModelUtility.IsGlobalModelValueEqualToEnum("MapVote.lobbyMapVoteType", Enum[@"lobbymapvote"][@"lobby_mapvote_previous"])
					if f6_local0 then
						f6_local0 = AlwaysFalse()
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "MapVoteChosenRandom",
			condition = function(menu, element, event)
				local f7_local0 = CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN)
				if f7_local0 then
					f7_local0 = CoD.ModelUtility.IsGlobalModelValueEqualToEnum("MapVote.lobbyMapVoteType", Enum[@"lobbymapvote"][@"lobby_mapvote_random"])
					if f7_local0 then
						f7_local0 = AlwaysFalse()
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "SelectedMap",
			condition = function(menu, element, event)
				local f8_local0 = CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN)
				if f8_local0 then
					f8_local0 = CoD.ArenaUtility.ArenaMatchSet(self)
					if f8_local0 then
						f8_local0 = IsArenaMode()
					end
				end
				return f8_local0
			end,
		},
	})
	local overheadNameContainer = MapVotePC
	local DirectorReadyButton = MapVotePC.subscribeToModel
	local DirectorPreGameButton = Engine[@"getglobalmodel"]()
	DirectorReadyButton(overheadNameContainer, DirectorPreGameButton["lobbyRoot.mapVote"], function(f9_arg0)
		f1_arg0:updateElementState(MapVotePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.mapVote",
		})
	end, false)
	overheadNameContainer = MapVotePC
	DirectorReadyButton = MapVotePC.subscribeToModel
	DirectorPreGameButton = Engine[@"getglobalmodel"]()
	DirectorReadyButton(overheadNameContainer, DirectorPreGameButton["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(MapVotePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	overheadNameContainer = MapVotePC
	DirectorReadyButton = MapVotePC.subscribeToModel
	DirectorPreGameButton = Engine[@"getglobalmodel"]()
	DirectorReadyButton(overheadNameContainer, DirectorPreGameButton["MapVote.lobbyMapVoteType"], function(f11_arg0)
		f1_arg0:updateElementState(MapVotePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "MapVote.lobbyMapVoteType",
		})
	end, false)
	overheadNameContainer = MapVotePC
	DirectorReadyButton = MapVotePC.subscribeToModel
	DirectorPreGameButton = Engine[@"getglobalmodel"]()
	DirectorReadyButton(overheadNameContainer, DirectorPreGameButton["lobbyRoot.publicLobby.stage"], function(f12_arg0)
		f1_arg0:updateElementState(MapVotePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:addElement(MapVotePC)
	self.MapVotePC = MapVotePC
	DirectorReadyButton = CoD.DirectorReadyButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 470, 896, 1, 1, -188, -108)
	DirectorReadyButton:setAlpha(0)
	DirectorReadyButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"menu/ready_up"))
	DirectorReadyButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/ready_up"))
	DirectorReadyButton.PlayText:setText(LocalizeToUpperString(@"menu/ready"))
	DirectorReadyButton:subscribeToGlobalModel(f1_arg1, "PerController", "ButtonBits." .. Enum[@"luibutton"][@"lui_key_xba_pscross"], function(model)
		DirectorReadyButton:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorReadyButton)
	self.DirectorReadyButton = DirectorReadyButton
	overheadNameContainer = CoD.DynamicContainerWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	self:addElement(overheadNameContainer)
	self.overheadNameContainer = overheadNameContainer
	DirectorPreGameButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0, 0, 536.5, 766.5, 1, 1, -178, -108)
	DirectorPreGameButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsBooleanDvarSet("loot_enableBlackMarket")
			end,
		},
	})
	DirectorPreGameButton:setAlpha(0)
	DirectorPreGameButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(@"menu/black_market"))
	DirectorPreGameButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/black_market"))
	DirectorPreGameButton:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorPreGameButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		OpenQuarterMaster(self, element, controller, "", menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/black_market", nil, nil)
		return true
	end, false)
	self:addElement(DirectorPreGameButton)
	self.DirectorPreGameButton = DirectorPreGameButton
	local ArenaEventButtons = CoD.ArenaEventButtons.new(f1_arg0, f1_arg1, 0.5, 0.5, 122, 322, 1, 1, -178, -108)
	ArenaEventButtons:setAlpha(0)
	self:addElement(ArenaEventButtons)
	self.ArenaEventButtons = ArenaEventButtons
	local ArenaDailyBonus = CoD.ArenaDailyBonus.new(f1_arg0, f1_arg1, 0.5, 0.5, 122, 322, 1, 1, -258, -188)
	ArenaDailyBonus:setAlpha(0)
	self:addElement(ArenaDailyBonus)
	self.ArenaDailyBonus = ArenaDailyBonus
	local ArenaEventProgressButton = CoD.ArenaEventProgressButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	self:addElement(ArenaEventProgressButton)
	self.ArenaEventProgressButton = ArenaEventProgressButton
	self:mergeStateConditions({
		{
			stateName = "IsPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "gameClientDataUpdate", function(model)
		local f19_local0 = self
		if CoD.DirectorUtility.ShowDirectorArenaMatchmaking(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "clientUpdated", function(model)
		local f20_local0 = self
		if CoD.DirectorUtility.ShowDirectorArenaMatchmaking(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyNav", function(model)
		local f21_local0 = self
		if CoD.DirectorUtility.ShowDirectorArenaMatchmaking(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	f1_local3.id = "MapVote"
	if CoD.isPC then
		MapVotePC.id = "MapVotePC"
	end
	DirectorReadyButton.id = "DirectorReadyButton"
	DirectorPreGameButton.id = "DirectorPreGameButton"
	ArenaEventButtons.id = "ArenaEventButtons"
	ArenaEventProgressButton.id = "ArenaEventProgressButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	CoD.LobbyUtility.InitOverheadNamesPreLobby(f1_arg0, f1_arg1, overheadNameContainer)
	return self
end
CoD.directorArenaMatchmaking.__onClose = function(f22_arg0)
	f22_arg0.StageNotificationContainer:close()
	f22_arg0.TopBar:close()
	f22_arg0.MapVote:close()
	f22_arg0.MapVotePC:close()
	f22_arg0.DirectorReadyButton:close()
	f22_arg0.overheadNameContainer:close()
	f22_arg0.DirectorPreGameButton:close()
	f22_arg0.ArenaEventButtons:close()
	f22_arg0.ArenaDailyBonus:close()
	f22_arg0.ArenaEventProgressButton:close()
end
