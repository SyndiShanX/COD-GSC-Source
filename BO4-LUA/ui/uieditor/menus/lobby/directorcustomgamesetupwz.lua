require("x64:d6ecdf7755aeddc")
require("x64:498d997a55065bd")
require("x64:2f210cb5e3fa853")
require("x64:ddadf7646104898")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:2675595fa323085")
CoD.DirectorCustomGameSetUpWZ = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorCustomGameSetUpWZ = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorCustomGameSetUpWZ", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.DirectorCustomGameSetUpWZ)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 6, -6)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local DirectorGameSettingList = CoD.DirectorGameSettingList.new(f1_local1, f1_arg0, 0.5, 0.5, 508, 864, 0, 0, 250, 670)
	self:addElement(DirectorGameSettingList)
	self.DirectorGameSettingList = DirectorGameSettingList
	local HeaderGameMode = LUI.UIText.new(0.5, 0.5, 508, 968, 0, 0, 223, 243)
	HeaderGameMode:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderGameMode:setText(LocalizeToUpperString(@"hash_5FBDB9A40DBC9E7A"))
	HeaderGameMode:setTTF("default")
	HeaderGameMode:setLetterSpacing(2)
	HeaderGameMode:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HeaderGameMode:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(HeaderGameMode)
	self.HeaderGameMode = HeaderGameMode
	local SelectionModeFocusBlocker = nil
	SelectionModeFocusBlocker = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0.5, 0.5, 498, 874, 0, 0, 240, 944)
	SelectionModeFocusBlocker:setAlpha(0)
	self:addElement(SelectionModeFocusBlocker)
	self.SelectionModeFocusBlocker = SelectionModeFocusBlocker
	local SelectionModeOverlay = nil
	SelectionModeOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectionModeOverlay:setRGB(0, 0, 0)
	SelectionModeOverlay:setAlpha(0)
	self:addElement(SelectionModeOverlay)
	self.SelectionModeOverlay = SelectionModeOverlay
	local BackingFree = LUI.UIImage.new(0.5, 0.5, -861, 0, 0, 0, 227, 872)
	BackingFree:setRGB(0, 0, 0)
	BackingFree:setAlpha(0)
	self:addElement(BackingFree)
	self.BackingFree = BackingFree
	local FreeTeam = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	FreeTeam:setLeftRight(0.5, 0.5, -840, -22)
	FreeTeam:setTopBottom(0, 0, 250, 850)
	FreeTeam:setAlpha(0)
	FreeTeam:setWidgetType(CoD.DirectorTeamMember)
	FreeTeam:setHorizontalCount(2)
	FreeTeam:setVerticalCount(6)
	FreeTeam:setSpacing(18)
	FreeTeam:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FreeTeam:setDataSource("DirectorPartyListCustom")
	self:addElement(FreeTeam)
	self.FreeTeam = FreeTeam
	local HeaderFreeTeam = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -861, 0, 0, 0, 200, 230)
	HeaderFreeTeam:setAlpha(0)
	HeaderFreeTeam.Label:setAlpha(0)
	HeaderFreeTeam.Label:setText(LocalizeToUpperString(@"mpui/allies"))
	self:addElement(HeaderFreeTeam)
	self.HeaderFreeTeam = HeaderFreeTeam
	local BackingTeam2 = LUI.UIImage.new(0.5, 0.5, -410, 32, 0, 0, 227, 666)
	BackingTeam2:setRGB(0, 0, 0)
	BackingTeam2:setAlpha(0.15)
	self:addElement(BackingTeam2)
	self.BackingTeam2 = BackingTeam2
	local Team2Quads = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team2Quads:setLeftRight(0.5, 0.5, -389, 11)
	Team2Quads:setTopBottom(0, 0, 250, 644)
	Team2Quads:setWidgetType(CoD.DirectorTeamMember)
	Team2Quads:setVerticalCount(4)
	Team2Quads:setSpacing(18)
	Team2Quads:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team2Quads:setFilter(function(f2_arg0)
		return f2_arg0.team:get() == Enum[@"team_t"][@"team_axis"]
	end)
	Team2Quads:setDataSource("DirectorPartyListCustom")
	Team2Quads:appendEventHandler("on_session_start", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team2Quads:appendEventHandler("on_session_end", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local HeaderTeam2 = Team2Quads
	local Team2Duos = Team2Quads.subscribeToModel
	local BackingTeam1 = Engine[@"getglobalmodel"]()
	Team2Duos(HeaderTeam2, BackingTeam1["lobbyRoot.lobbyNav"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam2 = Team2Quads
	Team2Duos = Team2Quads.subscribeToModel
	BackingTeam1 = Engine[@"getglobalmodel"]()
	Team2Duos(HeaderTeam2, BackingTeam1["lobbyRoot.gameClient.update"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam2 = Team2Quads
	Team2Duos = Team2Quads.subscribeToModel
	BackingTeam1 = Engine[@"getglobalmodel"]()
	Team2Duos(HeaderTeam2, BackingTeam1["lobbyRoot.privateClient.update"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team2Quads:linkToElementModel(Team2Quads, "xuid", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team2Quads:linkToElementModel(Team2Quads, "team", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	HeaderTeam2 = Team2Quads
	Team2Duos = Team2Quads.subscribeToModel
	BackingTeam1 = DataSources.LobbyRoot.getModel(f1_arg0)
	Team2Duos(HeaderTeam2, BackingTeam1.selectedXuid, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team2Quads:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	HeaderTeam2 = Team2Quads
	Team2Duos = Team2Quads.subscribeToModel
	BackingTeam1 = Engine[@"getmodelforcontroller"](f1_arg0)
	Team2Duos(HeaderTeam2, BackingTeam1.LastInput, function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam2 = Team2Quads
	Team2Duos = Team2Quads.subscribeToModel
	BackingTeam1 = DataSources.LobbyRoot.getModel(f1_arg0)
	Team2Duos(HeaderTeam2, BackingTeam1.selectedXuidTeam, function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team2Quads:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f14_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team2Quads, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team2Quads)
	self.Team2Quads = Team2Quads
	Team2Duos = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team2Duos:setLeftRight(0.5, 0.5, -389, 11)
	Team2Duos:setTopBottom(0, 0, 250, 438)
	Team2Duos:setAlpha(0)
	Team2Duos:setWidgetType(CoD.DirectorTeamMember)
	Team2Duos:setVerticalCount(2)
	Team2Duos:setSpacing(18)
	Team2Duos:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team2Duos:setFilter(function(f17_arg0)
		return f17_arg0.team:get() == Enum[@"team_t"][@"team_axis"]
	end)
	Team2Duos:setDataSource("DirectorPartyListCustom")
	Team2Duos:appendEventHandler("on_session_start", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f18_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team2Duos:appendEventHandler("on_session_end", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam1 = Team2Duos
	HeaderTeam2 = Team2Duos.subscribeToModel
	local Team1Quads = Engine[@"getglobalmodel"]()
	HeaderTeam2(BackingTeam1, Team1Quads["lobbyRoot.lobbyNav"], function(f20_arg0, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam1 = Team2Duos
	HeaderTeam2 = Team2Duos.subscribeToModel
	Team1Quads = Engine[@"getglobalmodel"]()
	HeaderTeam2(BackingTeam1, Team1Quads["lobbyRoot.gameClient.update"], function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam1 = Team2Duos
	HeaderTeam2 = Team2Duos.subscribeToModel
	Team1Quads = Engine[@"getglobalmodel"]()
	HeaderTeam2(BackingTeam1, Team1Quads["lobbyRoot.privateClient.update"], function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team2Duos:linkToElementModel(Team2Duos, "xuid", true, function(model, f23_arg1)
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team2Duos:linkToElementModel(Team2Duos, "team", true, function(model, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam1 = Team2Duos
	HeaderTeam2 = Team2Duos.subscribeToModel
	Team1Quads = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam2(BackingTeam1, Team1Quads.selectedXuid, function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team2Duos:appendEventHandler("input_source_changed", function(f26_arg0, f26_arg1)
		f26_arg1.menu = f26_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f26_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam1 = Team2Duos
	HeaderTeam2 = Team2Duos.subscribeToModel
	Team1Quads = Engine[@"getmodelforcontroller"](f1_arg0)
	HeaderTeam2(BackingTeam1, Team1Quads.LastInput, function(f27_arg0, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam1 = Team2Duos
	HeaderTeam2 = Team2Duos.subscribeToModel
	Team1Quads = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam2(BackingTeam1, Team1Quads.selectedXuidTeam, function(f28_arg0, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team2Duos:registerEventHandler("gain_focus", function(element, event)
		local f29_local0 = nil
		if element.gainFocus then
			f29_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f29_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f29_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team2Duos, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team2Duos)
	self.Team2Duos = Team2Duos
	HeaderTeam2 = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -409, 33, 0, 0, 200, 230)
	HeaderTeam2.Label:setText(LocalizeToUpperString(@"hash_4F622580C146167B"))
	self:addElement(HeaderTeam2)
	self.HeaderTeam2 = HeaderTeam2
	BackingTeam1 = LUI.UIImage.new(0.5, 0.5, -861, -419, 0, 0, 227, 666)
	BackingTeam1:setRGB(0, 0, 0)
	BackingTeam1:setAlpha(0.15)
	self:addElement(BackingTeam1)
	self.BackingTeam1 = BackingTeam1
	Team1Quads = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team1Quads:setLeftRight(0.5, 0.5, -840, -440)
	Team1Quads:setTopBottom(0, 0, 250, 644)
	Team1Quads:setWidgetType(CoD.DirectorTeamMember)
	Team1Quads:setVerticalCount(4)
	Team1Quads:setSpacing(18)
	Team1Quads:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team1Quads:setFilter(function(f32_arg0)
		return f32_arg0.team:get() == Enum[@"team_t"][@"team_allies"]
	end)
	Team1Quads:setDataSource("DirectorPartyListCustom")
	Team1Quads:appendEventHandler("on_session_start", function(f33_arg0, f33_arg1)
		f33_arg1.menu = f33_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f33_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team1Quads:appendEventHandler("on_session_end", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f34_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local HeaderTeam1 = Team1Quads
	local Team1Duos = Team1Quads.subscribeToModel
	local FooterContainerFrontendRight = Engine[@"getglobalmodel"]()
	Team1Duos(HeaderTeam1, FooterContainerFrontendRight["lobbyRoot.lobbyNav"], function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam1 = Team1Quads
	Team1Duos = Team1Quads.subscribeToModel
	FooterContainerFrontendRight = Engine[@"getglobalmodel"]()
	Team1Duos(HeaderTeam1, FooterContainerFrontendRight["lobbyRoot.gameClient.update"], function(f36_arg0, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam1 = Team1Quads
	Team1Duos = Team1Quads.subscribeToModel
	FooterContainerFrontendRight = Engine[@"getglobalmodel"]()
	Team1Duos(HeaderTeam1, FooterContainerFrontendRight["lobbyRoot.privateClient.update"], function(f37_arg0, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team1Quads:linkToElementModel(Team1Quads, "xuid", true, function(model, f38_arg1)
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team1Quads:linkToElementModel(Team1Quads, "team", true, function(model, f39_arg1)
		CoD.Menu.UpdateButtonShownState(f39_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	HeaderTeam1 = Team1Quads
	Team1Duos = Team1Quads.subscribeToModel
	FooterContainerFrontendRight = DataSources.LobbyRoot.getModel(f1_arg0)
	Team1Duos(HeaderTeam1, FooterContainerFrontendRight.selectedXuid, function(f40_arg0, f40_arg1)
		CoD.Menu.UpdateButtonShownState(f40_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team1Quads:appendEventHandler("input_source_changed", function(f41_arg0, f41_arg1)
		f41_arg1.menu = f41_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f41_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	HeaderTeam1 = Team1Quads
	Team1Duos = Team1Quads.subscribeToModel
	FooterContainerFrontendRight = Engine[@"getmodelforcontroller"](f1_arg0)
	Team1Duos(HeaderTeam1, FooterContainerFrontendRight.LastInput, function(f42_arg0, f42_arg1)
		CoD.Menu.UpdateButtonShownState(f42_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam1 = Team1Quads
	Team1Duos = Team1Quads.subscribeToModel
	FooterContainerFrontendRight = DataSources.LobbyRoot.getModel(f1_arg0)
	Team1Duos(HeaderTeam1, FooterContainerFrontendRight.selectedXuidTeam, function(f43_arg0, f43_arg1)
		CoD.Menu.UpdateButtonShownState(f43_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team1Quads:registerEventHandler("gain_focus", function(element, event)
		local f44_local0 = nil
		if element.gainFocus then
			f44_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f44_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f44_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team1Quads, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team1Quads)
	self.Team1Quads = Team1Quads
	Team1Duos = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team1Duos:setLeftRight(0.5, 0.5, -840, -440)
	Team1Duos:setTopBottom(0, 0, 250, 438)
	Team1Duos:setAlpha(0)
	Team1Duos:setWidgetType(CoD.DirectorTeamMember)
	Team1Duos:setVerticalCount(2)
	Team1Duos:setSpacing(18)
	Team1Duos:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team1Duos:setFilter(function(f47_arg0)
		return f47_arg0.team:get() == Enum[@"team_t"][@"team_allies"]
	end)
	Team1Duos:setDataSource("DirectorPartyListCustom")
	Team1Duos:appendEventHandler("on_session_start", function(f48_arg0, f48_arg1)
		f48_arg1.menu = f48_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f48_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team1Duos:appendEventHandler("on_session_end", function(f49_arg0, f49_arg1)
		f49_arg1.menu = f49_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f49_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	FooterContainerFrontendRight = Team1Duos
	HeaderTeam1 = Team1Duos.subscribeToModel
	local CommonHeader = Engine[@"getglobalmodel"]()
	HeaderTeam1(FooterContainerFrontendRight, CommonHeader["lobbyRoot.lobbyNav"], function(f50_arg0, f50_arg1)
		CoD.Menu.UpdateButtonShownState(f50_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	FooterContainerFrontendRight = Team1Duos
	HeaderTeam1 = Team1Duos.subscribeToModel
	CommonHeader = Engine[@"getglobalmodel"]()
	HeaderTeam1(FooterContainerFrontendRight, CommonHeader["lobbyRoot.gameClient.update"], function(f51_arg0, f51_arg1)
		CoD.Menu.UpdateButtonShownState(f51_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	FooterContainerFrontendRight = Team1Duos
	HeaderTeam1 = Team1Duos.subscribeToModel
	CommonHeader = Engine[@"getglobalmodel"]()
	HeaderTeam1(FooterContainerFrontendRight, CommonHeader["lobbyRoot.privateClient.update"], function(f52_arg0, f52_arg1)
		CoD.Menu.UpdateButtonShownState(f52_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team1Duos:linkToElementModel(Team1Duos, "xuid", true, function(model, f53_arg1)
		CoD.Menu.UpdateButtonShownState(f53_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team1Duos:linkToElementModel(Team1Duos, "team", true, function(model, f54_arg1)
		CoD.Menu.UpdateButtonShownState(f54_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	FooterContainerFrontendRight = Team1Duos
	HeaderTeam1 = Team1Duos.subscribeToModel
	CommonHeader = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam1(FooterContainerFrontendRight, CommonHeader.selectedXuid, function(f55_arg0, f55_arg1)
		CoD.Menu.UpdateButtonShownState(f55_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team1Duos:appendEventHandler("input_source_changed", function(f56_arg0, f56_arg1)
		f56_arg1.menu = f56_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f56_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	FooterContainerFrontendRight = Team1Duos
	HeaderTeam1 = Team1Duos.subscribeToModel
	CommonHeader = Engine[@"getmodelforcontroller"](f1_arg0)
	HeaderTeam1(FooterContainerFrontendRight, CommonHeader.LastInput, function(f57_arg0, f57_arg1)
		CoD.Menu.UpdateButtonShownState(f57_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	FooterContainerFrontendRight = Team1Duos
	HeaderTeam1 = Team1Duos.subscribeToModel
	CommonHeader = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam1(FooterContainerFrontendRight, CommonHeader.selectedXuidTeam, function(f58_arg0, f58_arg1)
		CoD.Menu.UpdateButtonShownState(f58_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team1Duos:registerEventHandler("gain_focus", function(element, event)
		local f59_local0 = nil
		if element.gainFocus then
			f59_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f59_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f59_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team1Duos, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team1Duos)
	self.Team1Duos = Team1Duos
	HeaderTeam1 = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -861, -419, 0, 0, 200, 230)
	HeaderTeam1.Label:setText(LocalizeToUpperString(@"hash_4F622680C146182E"))
	self:addElement(HeaderTeam1)
	self.HeaderTeam1 = HeaderTeam1
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f62_local0 = nil
		if element.menuLoaded then
			f62_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f62_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f62_local0 then
			f62_local0 = element:dispatchEventToChildren(event)
		end
		return f62_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyMainMode", function(model)
		local f63_local0 = model:get()
		if f63_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f63_local0)))
		end
	end)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f64_local0 = model:get()
		if f64_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(f64_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f65_local0 = nil
		if element.menuLoaded then
			f65_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f65_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f65_local0 then
			f65_local0 = element:dispatchEventToChildren(event)
		end
		return f65_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f66_local0 = nil
		if element.menuLoaded then
			f66_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f66_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f66_local0 then
			f66_local0 = element:dispatchEventToChildren(event)
		end
		return f66_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local BackingTeam3 = LUI.UIImage.new(0.5, 0.5, 44, 486, 0, 0, 227, 666)
	BackingTeam3:setRGB(0, 0, 0)
	BackingTeam3:setAlpha(0.15)
	self:addElement(BackingTeam3)
	self.BackingTeam3 = BackingTeam3
	local Team3Quads = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team3Quads:setLeftRight(0.5, 0.5, 65, 465)
	Team3Quads:setTopBottom(0, 0, 250, 644)
	Team3Quads:setWidgetType(CoD.DirectorTeamMember)
	Team3Quads:setVerticalCount(4)
	Team3Quads:setSpacing(18)
	Team3Quads:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team3Quads:setFilter(function(f67_arg0)
		return f67_arg0.team:get() == Enum[@"team_t"][@"team_three"]
	end)
	Team3Quads:setDataSource("DirectorPartyListCustom")
	Team3Quads:appendEventHandler("on_session_start", function(f68_arg0, f68_arg1)
		f68_arg1.menu = f68_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f68_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team3Quads:appendEventHandler("on_session_end", function(f69_arg0, f69_arg1)
		f69_arg1.menu = f69_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f69_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local HeaderTeam3 = Team3Quads
	local Team3Duos = Team3Quads.subscribeToModel
	local BackingTeam4 = Engine[@"getglobalmodel"]()
	Team3Duos(HeaderTeam3, BackingTeam4["lobbyRoot.lobbyNav"], function(f70_arg0, f70_arg1)
		CoD.Menu.UpdateButtonShownState(f70_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam3 = Team3Quads
	Team3Duos = Team3Quads.subscribeToModel
	BackingTeam4 = Engine[@"getglobalmodel"]()
	Team3Duos(HeaderTeam3, BackingTeam4["lobbyRoot.gameClient.update"], function(f71_arg0, f71_arg1)
		CoD.Menu.UpdateButtonShownState(f71_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam3 = Team3Quads
	Team3Duos = Team3Quads.subscribeToModel
	BackingTeam4 = Engine[@"getglobalmodel"]()
	Team3Duos(HeaderTeam3, BackingTeam4["lobbyRoot.privateClient.update"], function(f72_arg0, f72_arg1)
		CoD.Menu.UpdateButtonShownState(f72_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team3Quads:linkToElementModel(Team3Quads, "xuid", true, function(model, f73_arg1)
		CoD.Menu.UpdateButtonShownState(f73_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team3Quads:linkToElementModel(Team3Quads, "team", true, function(model, f74_arg1)
		CoD.Menu.UpdateButtonShownState(f74_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	HeaderTeam3 = Team3Quads
	Team3Duos = Team3Quads.subscribeToModel
	BackingTeam4 = DataSources.LobbyRoot.getModel(f1_arg0)
	Team3Duos(HeaderTeam3, BackingTeam4.selectedXuid, function(f75_arg0, f75_arg1)
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team3Quads:appendEventHandler("input_source_changed", function(f76_arg0, f76_arg1)
		f76_arg1.menu = f76_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f76_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	HeaderTeam3 = Team3Quads
	Team3Duos = Team3Quads.subscribeToModel
	BackingTeam4 = Engine[@"getmodelforcontroller"](f1_arg0)
	Team3Duos(HeaderTeam3, BackingTeam4.LastInput, function(f77_arg0, f77_arg1)
		CoD.Menu.UpdateButtonShownState(f77_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	HeaderTeam3 = Team3Quads
	Team3Duos = Team3Quads.subscribeToModel
	BackingTeam4 = DataSources.LobbyRoot.getModel(f1_arg0)
	Team3Duos(HeaderTeam3, BackingTeam4.selectedXuidTeam, function(f78_arg0, f78_arg1)
		CoD.Menu.UpdateButtonShownState(f78_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team3Quads:registerEventHandler("gain_focus", function(element, event)
		local f79_local0 = nil
		if element.gainFocus then
			f79_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f79_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f79_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team3Quads, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team3Quads)
	self.Team3Quads = Team3Quads
	Team3Duos = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team3Duos:setLeftRight(0.5, 0.5, 65, 465)
	Team3Duos:setTopBottom(0, 0, 250, 438)
	Team3Duos:setAlpha(0)
	Team3Duos:setWidgetType(CoD.DirectorTeamMember)
	Team3Duos:setVerticalCount(2)
	Team3Duos:setSpacing(18)
	Team3Duos:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team3Duos:setFilter(function(f82_arg0)
		return f82_arg0.team:get() == Enum[@"team_t"][@"team_three"]
	end)
	Team3Duos:setDataSource("DirectorPartyListCustom")
	Team3Duos:appendEventHandler("on_session_start", function(f83_arg0, f83_arg1)
		f83_arg1.menu = f83_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f83_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team3Duos:appendEventHandler("on_session_end", function(f84_arg0, f84_arg1)
		f84_arg1.menu = f84_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f84_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam4 = Team3Duos
	HeaderTeam3 = Team3Duos.subscribeToModel
	local Team4 = Engine[@"getglobalmodel"]()
	HeaderTeam3(BackingTeam4, Team4["lobbyRoot.lobbyNav"], function(f85_arg0, f85_arg1)
		CoD.Menu.UpdateButtonShownState(f85_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam4 = Team3Duos
	HeaderTeam3 = Team3Duos.subscribeToModel
	Team4 = Engine[@"getglobalmodel"]()
	HeaderTeam3(BackingTeam4, Team4["lobbyRoot.gameClient.update"], function(f86_arg0, f86_arg1)
		CoD.Menu.UpdateButtonShownState(f86_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam4 = Team3Duos
	HeaderTeam3 = Team3Duos.subscribeToModel
	Team4 = Engine[@"getglobalmodel"]()
	HeaderTeam3(BackingTeam4, Team4["lobbyRoot.privateClient.update"], function(f87_arg0, f87_arg1)
		CoD.Menu.UpdateButtonShownState(f87_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team3Duos:linkToElementModel(Team3Duos, "xuid", true, function(model, f88_arg1)
		CoD.Menu.UpdateButtonShownState(f88_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team3Duos:linkToElementModel(Team3Duos, "team", true, function(model, f89_arg1)
		CoD.Menu.UpdateButtonShownState(f89_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam4 = Team3Duos
	HeaderTeam3 = Team3Duos.subscribeToModel
	Team4 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam3(BackingTeam4, Team4.selectedXuid, function(f90_arg0, f90_arg1)
		CoD.Menu.UpdateButtonShownState(f90_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team3Duos:appendEventHandler("input_source_changed", function(f91_arg0, f91_arg1)
		f91_arg1.menu = f91_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f91_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam4 = Team3Duos
	HeaderTeam3 = Team3Duos.subscribeToModel
	Team4 = Engine[@"getmodelforcontroller"](f1_arg0)
	HeaderTeam3(BackingTeam4, Team4.LastInput, function(f92_arg0, f92_arg1)
		CoD.Menu.UpdateButtonShownState(f92_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam4 = Team3Duos
	HeaderTeam3 = Team3Duos.subscribeToModel
	Team4 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam3(BackingTeam4, Team4.selectedXuidTeam, function(f93_arg0, f93_arg1)
		CoD.Menu.UpdateButtonShownState(f93_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team3Duos:registerEventHandler("gain_focus", function(element, event)
		local f94_local0 = nil
		if element.gainFocus then
			f94_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f94_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f94_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team3Duos, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team3Duos)
	self.Team3Duos = Team3Duos
	HeaderTeam3 = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, 44, 486, 0, 0, 200, 230)
	HeaderTeam3.Label:setText(LocalizeToUpperString(@"hash_4F622480C14614C8"))
	self:addElement(HeaderTeam3)
	self.HeaderTeam3 = HeaderTeam3
	BackingTeam4 = LUI.UIImage.new(0.5, 0.5, -861, -419, 0, 0, 536, 769)
	BackingTeam4:setRGB(0, 0, 0)
	BackingTeam4:setAlpha(0)
	self:addElement(BackingTeam4)
	self.BackingTeam4 = BackingTeam4
	Team4 = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team4:setLeftRight(0.5, 0.5, -840, -440)
	Team4:setTopBottom(0, 0, 559, 747)
	Team4:setAlpha(0)
	Team4:setWidgetType(CoD.DirectorTeamMember)
	Team4:setVerticalCount(2)
	Team4:setSpacing(18)
	Team4:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team4:setFilter(function(f97_arg0)
		return f97_arg0.team:get() == Enum[@"team_t"][@"team_four"]
	end)
	Team4:setDataSource("DirectorPartyListCustom")
	Team4:appendEventHandler("on_session_start", function(f98_arg0, f98_arg1)
		f98_arg1.menu = f98_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f98_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team4:appendEventHandler("on_session_end", function(f99_arg0, f99_arg1)
		f99_arg1.menu = f99_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f99_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local BackingTeam5 = Team4
	local HeaderTeam4 = Team4.subscribeToModel
	local Team5 = Engine[@"getglobalmodel"]()
	HeaderTeam4(BackingTeam5, Team5["lobbyRoot.lobbyNav"], function(f100_arg0, f100_arg1)
		CoD.Menu.UpdateButtonShownState(f100_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam5 = Team4
	HeaderTeam4 = Team4.subscribeToModel
	Team5 = Engine[@"getglobalmodel"]()
	HeaderTeam4(BackingTeam5, Team5["lobbyRoot.gameClient.update"], function(f101_arg0, f101_arg1)
		CoD.Menu.UpdateButtonShownState(f101_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam5 = Team4
	HeaderTeam4 = Team4.subscribeToModel
	Team5 = Engine[@"getglobalmodel"]()
	HeaderTeam4(BackingTeam5, Team5["lobbyRoot.privateClient.update"], function(f102_arg0, f102_arg1)
		CoD.Menu.UpdateButtonShownState(f102_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team4:linkToElementModel(Team4, "xuid", true, function(model, f103_arg1)
		CoD.Menu.UpdateButtonShownState(f103_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team4:linkToElementModel(Team4, "team", true, function(model, f104_arg1)
		CoD.Menu.UpdateButtonShownState(f104_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam5 = Team4
	HeaderTeam4 = Team4.subscribeToModel
	Team5 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam4(BackingTeam5, Team5.selectedXuid, function(f105_arg0, f105_arg1)
		CoD.Menu.UpdateButtonShownState(f105_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team4:appendEventHandler("input_source_changed", function(f106_arg0, f106_arg1)
		f106_arg1.menu = f106_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f106_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam5 = Team4
	HeaderTeam4 = Team4.subscribeToModel
	Team5 = Engine[@"getmodelforcontroller"](f1_arg0)
	HeaderTeam4(BackingTeam5, Team5.LastInput, function(f107_arg0, f107_arg1)
		CoD.Menu.UpdateButtonShownState(f107_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam5 = Team4
	HeaderTeam4 = Team4.subscribeToModel
	Team5 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam4(BackingTeam5, Team5.selectedXuidTeam, function(f108_arg0, f108_arg1)
		CoD.Menu.UpdateButtonShownState(f108_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team4:registerEventHandler("gain_focus", function(element, event)
		local f109_local0 = nil
		if element.gainFocus then
			f109_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f109_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f109_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team4, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team4)
	self.Team4 = Team4
	HeaderTeam4 = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -861, -419, 0, 0, 509, 539)
	HeaderTeam4:setAlpha(0)
	HeaderTeam4.Label:setText(LocalizeToUpperString(@"hash_4F622B80C14620AD"))
	self:addElement(HeaderTeam4)
	self.HeaderTeam4 = HeaderTeam4
	BackingTeam5 = LUI.UIImage.new(0.5, 0.5, -410, 32, 0, 0, 536, 769)
	BackingTeam5:setRGB(0, 0, 0)
	BackingTeam5:setAlpha(0)
	self:addElement(BackingTeam5)
	self.BackingTeam5 = BackingTeam5
	Team5 = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team5:setLeftRight(0.5, 0.5, -389, 11)
	Team5:setTopBottom(0, 0, 559, 747)
	Team5:setAlpha(0)
	Team5:setWidgetType(CoD.DirectorTeamMember)
	Team5:setVerticalCount(2)
	Team5:setSpacing(18)
	Team5:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team5:setFilter(function(f112_arg0)
		return f112_arg0.team:get() == Enum[@"team_t"][@"team_five"]
	end)
	Team5:setDataSource("DirectorPartyListCustom")
	Team5:appendEventHandler("on_session_start", function(f113_arg0, f113_arg1)
		f113_arg1.menu = f113_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f113_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team5:appendEventHandler("on_session_end", function(f114_arg0, f114_arg1)
		f114_arg1.menu = f114_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f114_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local BackingTeam6 = Team5
	local HeaderTeam5 = Team5.subscribeToModel
	local Team6 = Engine[@"getglobalmodel"]()
	HeaderTeam5(BackingTeam6, Team6["lobbyRoot.lobbyNav"], function(f115_arg0, f115_arg1)
		CoD.Menu.UpdateButtonShownState(f115_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam6 = Team5
	HeaderTeam5 = Team5.subscribeToModel
	Team6 = Engine[@"getglobalmodel"]()
	HeaderTeam5(BackingTeam6, Team6["lobbyRoot.gameClient.update"], function(f116_arg0, f116_arg1)
		CoD.Menu.UpdateButtonShownState(f116_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam6 = Team5
	HeaderTeam5 = Team5.subscribeToModel
	Team6 = Engine[@"getglobalmodel"]()
	HeaderTeam5(BackingTeam6, Team6["lobbyRoot.privateClient.update"], function(f117_arg0, f117_arg1)
		CoD.Menu.UpdateButtonShownState(f117_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team5:linkToElementModel(Team5, "xuid", true, function(model, f118_arg1)
		CoD.Menu.UpdateButtonShownState(f118_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team5:linkToElementModel(Team5, "team", true, function(model, f119_arg1)
		CoD.Menu.UpdateButtonShownState(f119_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam6 = Team5
	HeaderTeam5 = Team5.subscribeToModel
	Team6 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam5(BackingTeam6, Team6.selectedXuid, function(f120_arg0, f120_arg1)
		CoD.Menu.UpdateButtonShownState(f120_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team5:appendEventHandler("input_source_changed", function(f121_arg0, f121_arg1)
		f121_arg1.menu = f121_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f121_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BackingTeam6 = Team5
	HeaderTeam5 = Team5.subscribeToModel
	Team6 = Engine[@"getmodelforcontroller"](f1_arg0)
	HeaderTeam5(BackingTeam6, Team6.LastInput, function(f122_arg0, f122_arg1)
		CoD.Menu.UpdateButtonShownState(f122_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackingTeam6 = Team5
	HeaderTeam5 = Team5.subscribeToModel
	Team6 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam5(BackingTeam6, Team6.selectedXuidTeam, function(f123_arg0, f123_arg1)
		CoD.Menu.UpdateButtonShownState(f123_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team5:registerEventHandler("gain_focus", function(element, event)
		local f124_local0 = nil
		if element.gainFocus then
			f124_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f124_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f124_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team5, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team5)
	self.Team5 = Team5
	HeaderTeam5 = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -409, 33, 0, 0, 509, 539)
	HeaderTeam5:setAlpha(0)
	HeaderTeam5.Label:setText(LocalizeToUpperString(@"hash_4F622A80C1461EFA"))
	self:addElement(HeaderTeam5)
	self.HeaderTeam5 = HeaderTeam5
	BackingTeam6 = LUI.UIImage.new(0.5, 0.5, 44, 486, 0, 0, 536, 769)
	BackingTeam6:setRGB(0, 0, 0)
	BackingTeam6:setAlpha(0)
	self:addElement(BackingTeam6)
	self.BackingTeam6 = BackingTeam6
	Team6 = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	Team6:setLeftRight(0.5, 0.5, 65, 465)
	Team6:setTopBottom(0, 0, 559, 747)
	Team6:setAlpha(0)
	Team6:setWidgetType(CoD.DirectorTeamMember)
	Team6:setVerticalCount(2)
	Team6:setSpacing(18)
	Team6:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team6:setFilter(function(f127_arg0)
		return f127_arg0.team:get() == Enum[@"team_t"][@"team_six"]
	end)
	Team6:setDataSource("DirectorPartyListCustom")
	Team6:appendEventHandler("on_session_start", function(f128_arg0, f128_arg1)
		f128_arg1.menu = f128_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f128_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team6:appendEventHandler("on_session_end", function(f129_arg0, f129_arg1)
		f129_arg1.menu = f129_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f129_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local33 = Team6
	local HeaderTeam6 = Team6.subscribeToModel
	local f1_local35 = Engine[@"getglobalmodel"]()
	HeaderTeam6(f1_local33, f1_local35["lobbyRoot.lobbyNav"], function(f130_arg0, f130_arg1)
		CoD.Menu.UpdateButtonShownState(f130_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local33 = Team6
	HeaderTeam6 = Team6.subscribeToModel
	f1_local35 = Engine[@"getglobalmodel"]()
	HeaderTeam6(f1_local33, f1_local35["lobbyRoot.gameClient.update"], function(f131_arg0, f131_arg1)
		CoD.Menu.UpdateButtonShownState(f131_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local33 = Team6
	HeaderTeam6 = Team6.subscribeToModel
	f1_local35 = Engine[@"getglobalmodel"]()
	HeaderTeam6(f1_local33, f1_local35["lobbyRoot.privateClient.update"], function(f132_arg0, f132_arg1)
		CoD.Menu.UpdateButtonShownState(f132_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team6:linkToElementModel(Team6, "xuid", true, function(model, f133_arg1)
		CoD.Menu.UpdateButtonShownState(f133_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Team6:linkToElementModel(Team6, "team", true, function(model, f134_arg1)
		CoD.Menu.UpdateButtonShownState(f134_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local33 = Team6
	HeaderTeam6 = Team6.subscribeToModel
	f1_local35 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam6(f1_local33, f1_local35.selectedXuid, function(f135_arg0, f135_arg1)
		CoD.Menu.UpdateButtonShownState(f135_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team6:appendEventHandler("input_source_changed", function(f136_arg0, f136_arg1)
		f136_arg1.menu = f136_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f136_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local33 = Team6
	HeaderTeam6 = Team6.subscribeToModel
	f1_local35 = Engine[@"getmodelforcontroller"](f1_arg0)
	HeaderTeam6(f1_local33, f1_local35.LastInput, function(f137_arg0, f137_arg1)
		CoD.Menu.UpdateButtonShownState(f137_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local33 = Team6
	HeaderTeam6 = Team6.subscribeToModel
	f1_local35 = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderTeam6(f1_local33, f1_local35.selectedXuidTeam, function(f138_arg0, f138_arg1)
		CoD.Menu.UpdateButtonShownState(f138_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Team6:registerEventHandler("gain_focus", function(element, event)
		local f139_local0 = nil
		if element.gainFocus then
			f139_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f139_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f139_local0
	end)
	f1_local1:AddButtonCallbackFunction(Team6, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SelectClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.SwapWithSelectedClient(controller, element)
			PlaySoundSetSound(self, "list_action")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/move", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/add", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Team6)
	self.Team6 = Team6
	HeaderTeam6 = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, 44, 486, 0, 0, 509, 539)
	HeaderTeam6:setAlpha(0)
	HeaderTeam6.Label:setText(LocalizeToUpperString(@"hash_4F622980C1461D47"))
	self:addElement(HeaderTeam6)
	self.HeaderTeam6 = HeaderTeam6
	self:mergeStateConditions({
		{
			stateName = "Duos",
			condition = function(menu, element, event)
				return IsMaxTeamPlayersEqualTo(2)
			end,
		},
		{
			stateName = "Solos",
			condition = function(menu, element, event)
				return IsMaxTeamPlayersEqualTo(1)
			end,
		},
	})
	f1_local35 = self
	f1_local33 = self.subscribeToModel
	local f1_local36 = Engine[@"getglobalmodel"]()
	f1_local33(f1_local35, f1_local36["MapVote.mapVoteGameModeNext"], function(f144_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f144_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model, f145_arg1)
		CoD.Menu.UpdateButtonShownState(f145_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		else
			GoBack(self, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "lobbyRoot.selectedXuid", function(model)
		local f148_local0 = self
		if IsPC() and CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.selectedXuid", LuaDefine.INVALID_XUID_X64) then
			EnableKeyboardNavigationByElement(self.DirectorGameSettingList)
			EnableKeyboardNavigationByElement(self.DirectorLobbySettingList)
			HideWidget(self.SelectionModeOverlay)
			HideWidget(self.SelectionModeFocusBlocker)
		elseif IsPC() then
			DisableKeyboardNavigationByElement(self.DirectorGameSettingList)
			DisableKeyboardNavigationByElement(self.DirectorLobbySettingList)
			SetAlpha(self.SelectionModeOverlay, 0.6)
			ShowWidget(self.SelectionModeFocusBlocker)
		end
	end)
	DirectorGameSettingList.id = "DirectorGameSettingList"
	if CoD.isPC then
		SelectionModeFocusBlocker.id = "SelectionModeFocusBlocker"
	end
	FreeTeam.id = "FreeTeam"
	Team2Quads.id = "Team2Quads"
	Team2Duos.id = "Team2Duos"
	Team1Quads.id = "Team1Quads"
	Team1Duos.id = "Team1Duos"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	Team3Quads.id = "Team3Quads"
	Team3Duos.id = "Team3Duos"
	Team4.id = "Team4"
	Team5.id = "Team5"
	Team6.id = "Team6"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = DirectorGameSettingList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local33 = self
	f1_local33 = SelectionModeFocusBlocker
	if IsPC() then
		SetElementProperty(f1_local33, "_yieldFocus", nil)
		DisableKeyboardNavigationByElement(f1_local33)
		SetIgnorePlaySoundSetSound(f1_local33, true)
	end
	SetElementProperty(FreeTeam, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team2Quads, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team2Duos, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team1Quads, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team1Duos, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team3Quads, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team3Duos, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team4, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team5, "_checkChildFocusForSelectability", true)
	SetElementProperty(Team6, "_checkChildFocusForSelectability", true)
	return self
end
CoD.DirectorCustomGameSetUpWZ.__resetProperties = function(f149_arg0)
	f149_arg0.BackingTeam1:completeAnimation()
	f149_arg0.BackingTeam2:completeAnimation()
	f149_arg0.BackingTeam3:completeAnimation()
	f149_arg0.BackingTeam6:completeAnimation()
	f149_arg0.BackingTeam5:completeAnimation()
	f149_arg0.BackingTeam4:completeAnimation()
	f149_arg0.HeaderTeam6:completeAnimation()
	f149_arg0.Team6:completeAnimation()
	f149_arg0.HeaderTeam5:completeAnimation()
	f149_arg0.Team5:completeAnimation()
	f149_arg0.HeaderTeam4:completeAnimation()
	f149_arg0.Team4:completeAnimation()
	f149_arg0.Team2Quads:completeAnimation()
	f149_arg0.Team2Duos:completeAnimation()
	f149_arg0.Team1Quads:completeAnimation()
	f149_arg0.Team1Duos:completeAnimation()
	f149_arg0.Team3Quads:completeAnimation()
	f149_arg0.Team3Duos:completeAnimation()
	f149_arg0.HeaderTeam2:completeAnimation()
	f149_arg0.HeaderTeam1:completeAnimation()
	f149_arg0.HeaderTeam3:completeAnimation()
	f149_arg0.BackingFree:completeAnimation()
	f149_arg0.FreeTeam:completeAnimation()
	f149_arg0.HeaderFreeTeam:completeAnimation()
	f149_arg0.BackingTeam1:setTopBottom(0, 0, 227, 666)
	f149_arg0.BackingTeam1:setAlpha(0.15)
	f149_arg0.BackingTeam2:setTopBottom(0, 0, 227, 666)
	f149_arg0.BackingTeam2:setAlpha(0.15)
	f149_arg0.BackingTeam3:setTopBottom(0, 0, 227, 666)
	f149_arg0.BackingTeam3:setAlpha(0.15)
	f149_arg0.BackingTeam6:setAlpha(0)
	f149_arg0.BackingTeam5:setAlpha(0)
	f149_arg0.BackingTeam4:setAlpha(0)
	f149_arg0.HeaderTeam6:setAlpha(0)
	f149_arg0.Team6:setAlpha(0)
	f149_arg0.HeaderTeam5:setAlpha(0)
	f149_arg0.Team5:setAlpha(0)
	f149_arg0.HeaderTeam4:setAlpha(0)
	f149_arg0.Team4:setAlpha(0)
	f149_arg0.Team2Quads:setAlpha(1)
	f149_arg0.Team2Duos:setAlpha(0)
	f149_arg0.Team1Quads:setAlpha(1)
	f149_arg0.Team1Duos:setAlpha(0)
	f149_arg0.Team3Quads:setAlpha(1)
	f149_arg0.Team3Duos:setAlpha(0)
	f149_arg0.HeaderTeam2:setAlpha(1)
	f149_arg0.HeaderTeam1:setAlpha(1)
	f149_arg0.HeaderTeam3:setAlpha(1)
	f149_arg0.BackingFree:setAlpha(0)
	f149_arg0.FreeTeam:setAlpha(0)
	f149_arg0.HeaderFreeTeam:setAlpha(0)
end
CoD.DirectorCustomGameSetUpWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f150_arg0, f150_arg1)
			f150_arg0:__resetProperties()
			f150_arg0:setupElementClipCounter(0)
		end,
	},
	Duos = {
		DefaultClip = function(f151_arg0, f151_arg1)
			f151_arg0:__resetProperties()
			f151_arg0:setupElementClipCounter(18)
			f151_arg0.BackingTeam2:completeAnimation()
			f151_arg0.BackingTeam2:setTopBottom(0, 0, 227, 460)
			f151_arg0.clipFinished(f151_arg0.BackingTeam2)
			f151_arg0.Team2Quads:completeAnimation()
			f151_arg0.Team2Quads:setAlpha(0)
			f151_arg0.clipFinished(f151_arg0.Team2Quads)
			f151_arg0.Team2Duos:completeAnimation()
			f151_arg0.Team2Duos:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Team2Duos)
			f151_arg0.BackingTeam1:completeAnimation()
			f151_arg0.BackingTeam1:setTopBottom(0, 0, 227, 460)
			f151_arg0.clipFinished(f151_arg0.BackingTeam1)
			f151_arg0.Team1Quads:completeAnimation()
			f151_arg0.Team1Quads:setAlpha(0)
			f151_arg0.clipFinished(f151_arg0.Team1Quads)
			f151_arg0.Team1Duos:completeAnimation()
			f151_arg0.Team1Duos:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Team1Duos)
			f151_arg0.BackingTeam3:completeAnimation()
			f151_arg0.BackingTeam3:setTopBottom(0, 0, 227, 460)
			f151_arg0.clipFinished(f151_arg0.BackingTeam3)
			f151_arg0.Team3Quads:completeAnimation()
			f151_arg0.Team3Quads:setAlpha(0)
			f151_arg0.clipFinished(f151_arg0.Team3Quads)
			f151_arg0.Team3Duos:completeAnimation()
			f151_arg0.Team3Duos:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Team3Duos)
			f151_arg0.BackingTeam4:completeAnimation()
			f151_arg0.BackingTeam4:setAlpha(0.15)
			f151_arg0.clipFinished(f151_arg0.BackingTeam4)
			f151_arg0.Team4:completeAnimation()
			f151_arg0.Team4:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Team4)
			f151_arg0.HeaderTeam4:completeAnimation()
			f151_arg0.HeaderTeam4:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.HeaderTeam4)
			f151_arg0.BackingTeam5:completeAnimation()
			f151_arg0.BackingTeam5:setAlpha(0.15)
			f151_arg0.clipFinished(f151_arg0.BackingTeam5)
			f151_arg0.Team5:completeAnimation()
			f151_arg0.Team5:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Team5)
			f151_arg0.HeaderTeam5:completeAnimation()
			f151_arg0.HeaderTeam5:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.HeaderTeam5)
			f151_arg0.BackingTeam6:completeAnimation()
			f151_arg0.BackingTeam6:setAlpha(0.15)
			f151_arg0.clipFinished(f151_arg0.BackingTeam6)
			f151_arg0.Team6:completeAnimation()
			f151_arg0.Team6:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Team6)
			f151_arg0.HeaderTeam6:completeAnimation()
			f151_arg0.HeaderTeam6:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.HeaderTeam6)
		end,
	},
	Solos = {
		DefaultClip = function(f152_arg0, f152_arg1)
			f152_arg0:__resetProperties()
			f152_arg0:setupElementClipCounter(12)
			f152_arg0.BackingFree:completeAnimation()
			f152_arg0.BackingFree:setAlpha(0.15)
			f152_arg0.clipFinished(f152_arg0.BackingFree)
			f152_arg0.FreeTeam:completeAnimation()
			f152_arg0.FreeTeam:setAlpha(1)
			f152_arg0.clipFinished(f152_arg0.FreeTeam)
			f152_arg0.HeaderFreeTeam:completeAnimation()
			f152_arg0.HeaderFreeTeam:setAlpha(1)
			f152_arg0.clipFinished(f152_arg0.HeaderFreeTeam)
			f152_arg0.BackingTeam2:completeAnimation()
			f152_arg0.BackingTeam2:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.BackingTeam2)
			f152_arg0.Team2Quads:completeAnimation()
			f152_arg0.Team2Quads:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.Team2Quads)
			f152_arg0.HeaderTeam2:completeAnimation()
			f152_arg0.HeaderTeam2:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.HeaderTeam2)
			f152_arg0.BackingTeam1:completeAnimation()
			f152_arg0.BackingTeam1:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.BackingTeam1)
			f152_arg0.Team1Quads:completeAnimation()
			f152_arg0.Team1Quads:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.Team1Quads)
			f152_arg0.HeaderTeam1:completeAnimation()
			f152_arg0.HeaderTeam1:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.HeaderTeam1)
			f152_arg0.BackingTeam3:completeAnimation()
			f152_arg0.BackingTeam3:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.BackingTeam3)
			f152_arg0.Team3Quads:completeAnimation()
			f152_arg0.Team3Quads:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.Team3Quads)
			f152_arg0.HeaderTeam3:completeAnimation()
			f152_arg0.HeaderTeam3:setAlpha(0)
			f152_arg0.clipFinished(f152_arg0.HeaderTeam3)
		end,
	},
}
CoD.DirectorCustomGameSetUpWZ.__onClose = function(f153_arg0)
	f153_arg0.DirectorGameSettingList:close()
	f153_arg0.SelectionModeFocusBlocker:close()
	f153_arg0.FreeTeam:close()
	f153_arg0.HeaderFreeTeam:close()
	f153_arg0.Team2Quads:close()
	f153_arg0.Team2Duos:close()
	f153_arg0.HeaderTeam2:close()
	f153_arg0.Team1Quads:close()
	f153_arg0.Team1Duos:close()
	f153_arg0.HeaderTeam1:close()
	f153_arg0.FooterContainerFrontendRight:close()
	f153_arg0.CommonHeader:close()
	f153_arg0.BackingGrayMediumLeft:close()
	f153_arg0.Team3Quads:close()
	f153_arg0.Team3Duos:close()
	f153_arg0.HeaderTeam3:close()
	f153_arg0.Team4:close()
	f153_arg0.HeaderTeam4:close()
	f153_arg0.Team5:close()
	f153_arg0.HeaderTeam5:close()
	f153_arg0.Team6:close()
	f153_arg0.HeaderTeam6:close()
end
