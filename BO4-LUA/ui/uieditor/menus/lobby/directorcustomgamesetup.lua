require("x64:d6ecdf7755aeddc")
require("x64:28b7b6066db25af")
require("x64:498d997a55065bd")
require("x64:2f210cb5e3fa853")
require("x64:6af0791fe52582b")
require("x64:ddadf7646104898")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:2675595fa323085")
CoD.DirectorCustomGameSetUp = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorCustomGameSetUp = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorCustomGameSetUp", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.DirectorCustomGameSetUp)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 6, -6)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local DirectorLobbySettingList = CoD.DirectorLobbySettingList.new(f1_local1, f1_arg0, 0.5, 0.5, 508, 864, 0, 0, 734, 934)
	DirectorLobbySettingList:mergeStateConditions({
		{
			stateName = "NoCodCaster",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local HeaderGameRule = DirectorLobbySettingList
	local DirectorGameSettingList = DirectorLobbySettingList.subscribeToModel
	local HeaderGameMode = Engine[0x8DF2E5447F384B9]()
	DirectorGameSettingList(HeaderGameRule, HeaderGameMode["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_local1:updateElementState(DirectorLobbySettingList, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(DirectorLobbySettingList)
	self.DirectorLobbySettingList = DirectorLobbySettingList
	DirectorGameSettingList = CoD.DirectorGameSettingList.new(f1_local1, f1_arg0, 0.5, 0.5, 508, 864, 0, 0, 250, 670)
	self:addElement(DirectorGameSettingList)
	self.DirectorGameSettingList = DirectorGameSettingList
	HeaderGameRule = LUI.UIText.new(0.5, 0.5, 508, 968, 0, 0, 476, 496)
	HeaderGameRule:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderGameRule:setText(Engine[0xF9F1239CFD921FE](0xBB7AA7A26F39DFA))
	HeaderGameRule:setTTF("default")
	HeaderGameRule:setLetterSpacing(2)
	HeaderGameRule:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HeaderGameRule:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(HeaderGameRule)
	self.HeaderGameRule = HeaderGameRule
	HeaderGameMode = LUI.UIText.new(0.5, 0.5, 508, 968, 0, 0, 223, 243)
	HeaderGameMode:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderGameMode:setText(LocalizeToUpperString(0x1496B17DC3093F9))
	HeaderGameMode:setTTF("default")
	HeaderGameMode:setLetterSpacing(2)
	HeaderGameMode:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HeaderGameMode:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
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
	BackingFree:setAlpha(0.15)
	self:addElement(BackingFree)
	self.BackingFree = BackingFree
	local FreeTeam = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	FreeTeam:setLeftRight(0.5, 0.5, -840, -22)
	FreeTeam:setTopBottom(0, 0, 250, 850)
	FreeTeam:setWidgetType(CoD.DirectorTeamMember)
	FreeTeam:setHorizontalCount(2)
	FreeTeam:setVerticalCount(6)
	FreeTeam:setSpacing(18)
	FreeTeam:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FreeTeam:setFilter(function(f4_arg0)
		local f4_local0
		if f4_arg0.team:get() == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] or f4_arg0.team:get() == Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] then
			f4_local0 = false
		else
			f4_local0 = true
		end
		return f4_local0
	end)
	FreeTeam:setDataSource("DirectorPartyListCustom")
	FreeTeam:appendEventHandler("on_session_start", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	FreeTeam:appendEventHandler("on_session_end", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local BackingAxis = FreeTeam
	local HeaderFreeTeam = FreeTeam.subscribeToModel
	local AxisTeam = Engine[0x8DF2E5447F384B9]()
	HeaderFreeTeam(BackingAxis, AxisTeam["lobbyRoot.lobbyNav"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BackingAxis = FreeTeam
	HeaderFreeTeam = FreeTeam.subscribeToModel
	AxisTeam = Engine[0x8DF2E5447F384B9]()
	HeaderFreeTeam(BackingAxis, AxisTeam["lobbyRoot.gameClient.update"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BackingAxis = FreeTeam
	HeaderFreeTeam = FreeTeam.subscribeToModel
	AxisTeam = Engine[0x8DF2E5447F384B9]()
	HeaderFreeTeam(BackingAxis, AxisTeam["lobbyRoot.privateClient.update"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	FreeTeam:linkToElementModel(FreeTeam, "xuid", true, function(model, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	FreeTeam:linkToElementModel(FreeTeam, "team", true, function(model, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	BackingAxis = FreeTeam
	HeaderFreeTeam = FreeTeam.subscribeToModel
	AxisTeam = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderFreeTeam(BackingAxis, AxisTeam.selectedXuid, function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	FreeTeam:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f13_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	BackingAxis = FreeTeam
	HeaderFreeTeam = FreeTeam.subscribeToModel
	AxisTeam = Engine[0x4DF5CFBC1771947](f1_arg0)
	HeaderFreeTeam(BackingAxis, AxisTeam.LastInput, function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BackingAxis = FreeTeam
	HeaderFreeTeam = FreeTeam.subscribeToModel
	AxisTeam = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderFreeTeam(BackingAxis, AxisTeam.selectedXuidTeam, function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	FreeTeam:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_local1:AddButtonCallbackFunction(FreeTeam, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x2D7AF821FE36BC6, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xB4A0F5945BB8108, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x9038794D2FBCFAA, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	FreeTeam:subscribeToGlobalModel(f1_arg0, "GlobalModel", "MapVote.mapVoteGameModeNext", function(model)
		CoD.GridAndListUtility.UpdateDataSource(FreeTeam, true, false, true)
	end)
	self:addElement(FreeTeam)
	self.FreeTeam = FreeTeam
	HeaderFreeTeam = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -861, 0, 0, 0, 200, 230)
	HeaderFreeTeam.Label:setRGB(ColorSet.CodCasterFactionAllies.r, ColorSet.CodCasterFactionAllies.g, ColorSet.CodCasterFactionAllies.b)
	HeaderFreeTeam.Label:setAlpha(0)
	HeaderFreeTeam.Label:setText(LocalizeToUpperString(0xC815AF97EE8C135))
	self:addElement(HeaderFreeTeam)
	self.HeaderFreeTeam = HeaderFreeTeam
	BackingAxis = LUI.UIImage.new(0.5, 0.5, -410, 32, 0, 0, 227, 872)
	BackingAxis:setRGB(0, 0, 0)
	BackingAxis:setAlpha(0.15)
	self:addElement(BackingAxis)
	self.BackingAxis = BackingAxis
	AxisTeam = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	AxisTeam:setLeftRight(0.5, 0.5, -389, 11)
	AxisTeam:setTopBottom(0, 0, 250, 850)
	AxisTeam:setWidgetType(CoD.DirectorTeamMember)
	AxisTeam:setVerticalCount(6)
	AxisTeam:setSpacing(18)
	AxisTeam:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AxisTeam:setFilter(function(f20_arg0)
		return f20_arg0.team:get() == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
	end)
	AxisTeam:setDataSource("DirectorPartyListCustom")
	AxisTeam:appendEventHandler("on_session_start", function(f21_arg0, f21_arg1)
		f21_arg1.menu = f21_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f21_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AxisTeam:appendEventHandler("on_session_end", function(f22_arg0, f22_arg1)
		f22_arg1.menu = f22_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f22_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local BackingAllies = AxisTeam
	local HeaderAxisTeam = AxisTeam.subscribeToModel
	local AlliesTeam = Engine[0x8DF2E5447F384B9]()
	HeaderAxisTeam(BackingAllies, AlliesTeam["lobbyRoot.lobbyNav"], function(f23_arg0, f23_arg1)
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BackingAllies = AxisTeam
	HeaderAxisTeam = AxisTeam.subscribeToModel
	AlliesTeam = Engine[0x8DF2E5447F384B9]()
	HeaderAxisTeam(BackingAllies, AlliesTeam["lobbyRoot.gameClient.update"], function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BackingAllies = AxisTeam
	HeaderAxisTeam = AxisTeam.subscribeToModel
	AlliesTeam = Engine[0x8DF2E5447F384B9]()
	HeaderAxisTeam(BackingAllies, AlliesTeam["lobbyRoot.privateClient.update"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AxisTeam:linkToElementModel(AxisTeam, "xuid", true, function(model, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AxisTeam:linkToElementModel(AxisTeam, "team", true, function(model, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	BackingAllies = AxisTeam
	HeaderAxisTeam = AxisTeam.subscribeToModel
	AlliesTeam = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderAxisTeam(BackingAllies, AlliesTeam.selectedXuid, function(f28_arg0, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AxisTeam:appendEventHandler("input_source_changed", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	BackingAllies = AxisTeam
	HeaderAxisTeam = AxisTeam.subscribeToModel
	AlliesTeam = Engine[0x4DF5CFBC1771947](f1_arg0)
	HeaderAxisTeam(BackingAllies, AlliesTeam.LastInput, function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BackingAllies = AxisTeam
	HeaderAxisTeam = AxisTeam.subscribeToModel
	AlliesTeam = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderAxisTeam(BackingAllies, AlliesTeam.selectedXuidTeam, function(f31_arg0, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AxisTeam:registerEventHandler("gain_focus", function(element, event)
		local f32_local0 = nil
		if element.gainFocus then
			f32_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f32_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f32_local0
	end)
	f1_local1:AddButtonCallbackFunction(AxisTeam, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x2D7AF821FE36BC6, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xB4A0F5945BB8108, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x9038794D2FBCFAA, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	AxisTeam:subscribeToGlobalModel(f1_arg0, "GlobalModel", "MapVote.mapVoteGameModeNext", function(model)
		CoD.GridAndListUtility.UpdateDataSource(AxisTeam, true, false, true)
	end)
	self:addElement(AxisTeam)
	self.AxisTeam = AxisTeam
	HeaderAxisTeam = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -409, 33, 0, 0, 200, 230)
	HeaderAxisTeam.Backing:setRGB(ColorSet.CodCasterFactionAxis.r, ColorSet.CodCasterFactionAxis.g, ColorSet.CodCasterFactionAxis.b)
	HeaderAxisTeam.Label:setRGB(ColorSet.CodCasterFactionAxis.r, ColorSet.CodCasterFactionAxis.g, ColorSet.CodCasterFactionAxis.b)
	HeaderAxisTeam.Label:setText(LocalizeToUpperString(0x12BD5927860415A))
	self:addElement(HeaderAxisTeam)
	self.HeaderAxisTeam = HeaderAxisTeam
	BackingAllies = LUI.UIImage.new(0.5, 0.5, -861, -419, 0, 0, 227, 872)
	BackingAllies:setRGB(0, 0, 0)
	BackingAllies:setAlpha(0.15)
	self:addElement(BackingAllies)
	self.BackingAllies = BackingAllies
	AlliesTeam = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	AlliesTeam:setLeftRight(0.5, 0.5, -840, -440)
	AlliesTeam:setTopBottom(0, 0, 250, 850)
	AlliesTeam:setWidgetType(CoD.DirectorTeamMember)
	AlliesTeam:setVerticalCount(6)
	AlliesTeam:setSpacing(18)
	AlliesTeam:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AlliesTeam:setFilter(function(f36_arg0)
		return f36_arg0.team:get() == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
	end)
	AlliesTeam:setDataSource("DirectorPartyListCustom")
	AlliesTeam:appendEventHandler("on_session_start", function(f37_arg0, f37_arg1)
		f37_arg1.menu = f37_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f37_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AlliesTeam:appendEventHandler("on_session_end", function(f38_arg0, f38_arg1)
		f38_arg1.menu = f38_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f38_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local FooterContainerFrontendRight = AlliesTeam
	local HeaderAlliesTeam = AlliesTeam.subscribeToModel
	local CommonHeader = Engine[0x8DF2E5447F384B9]()
	HeaderAlliesTeam(FooterContainerFrontendRight, CommonHeader["lobbyRoot.lobbyNav"], function(f39_arg0, f39_arg1)
		CoD.Menu.UpdateButtonShownState(f39_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	FooterContainerFrontendRight = AlliesTeam
	HeaderAlliesTeam = AlliesTeam.subscribeToModel
	CommonHeader = Engine[0x8DF2E5447F384B9]()
	HeaderAlliesTeam(FooterContainerFrontendRight, CommonHeader["lobbyRoot.gameClient.update"], function(f40_arg0, f40_arg1)
		CoD.Menu.UpdateButtonShownState(f40_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	FooterContainerFrontendRight = AlliesTeam
	HeaderAlliesTeam = AlliesTeam.subscribeToModel
	CommonHeader = Engine[0x8DF2E5447F384B9]()
	HeaderAlliesTeam(FooterContainerFrontendRight, CommonHeader["lobbyRoot.privateClient.update"], function(f41_arg0, f41_arg1)
		CoD.Menu.UpdateButtonShownState(f41_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AlliesTeam:linkToElementModel(AlliesTeam, "xuid", true, function(model, f42_arg1)
		CoD.Menu.UpdateButtonShownState(f42_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AlliesTeam:linkToElementModel(AlliesTeam, "team", true, function(model, f43_arg1)
		CoD.Menu.UpdateButtonShownState(f43_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	FooterContainerFrontendRight = AlliesTeam
	HeaderAlliesTeam = AlliesTeam.subscribeToModel
	CommonHeader = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderAlliesTeam(FooterContainerFrontendRight, CommonHeader.selectedXuid, function(f44_arg0, f44_arg1)
		CoD.Menu.UpdateButtonShownState(f44_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AlliesTeam:appendEventHandler("input_source_changed", function(f45_arg0, f45_arg1)
		f45_arg1.menu = f45_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f45_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	FooterContainerFrontendRight = AlliesTeam
	HeaderAlliesTeam = AlliesTeam.subscribeToModel
	CommonHeader = Engine[0x4DF5CFBC1771947](f1_arg0)
	HeaderAlliesTeam(FooterContainerFrontendRight, CommonHeader.LastInput, function(f46_arg0, f46_arg1)
		CoD.Menu.UpdateButtonShownState(f46_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	FooterContainerFrontendRight = AlliesTeam
	HeaderAlliesTeam = AlliesTeam.subscribeToModel
	CommonHeader = DataSources.LobbyRoot.getModel(f1_arg0)
	HeaderAlliesTeam(FooterContainerFrontendRight, CommonHeader.selectedXuidTeam, function(f47_arg0, f47_arg1)
		CoD.Menu.UpdateButtonShownState(f47_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AlliesTeam:registerEventHandler("gain_focus", function(element, event)
		local f48_local0 = nil
		if element.gainFocus then
			f48_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f48_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f48_local0
	end)
	f1_local1:AddButtonCallbackFunction(AlliesTeam, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x2D7AF821FE36BC6, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xB4A0F5945BB8108, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x9038794D2FBCFAA, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSelectClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and not CoD.DirectorUtility.IsClientEmpty(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.CanSwapWithSelectedClient(controller, element) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	AlliesTeam:subscribeToGlobalModel(f1_arg0, "GlobalModel", "MapVote.mapVoteGameModeNext", function(model)
		CoD.GridAndListUtility.UpdateDataSource(AlliesTeam, true, false, true)
	end)
	self:addElement(AlliesTeam)
	self.AlliesTeam = AlliesTeam
	HeaderAlliesTeam = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, -861, -419, 0, 0, 200, 230)
	HeaderAlliesTeam.Backing:setRGB(ColorSet.CodCasterFactionAllies.r, ColorSet.CodCasterFactionAllies.g, ColorSet.CodCasterFactionAllies.b)
	HeaderAlliesTeam.Label:setRGB(ColorSet.CodCasterFactionAllies.r, ColorSet.CodCasterFactionAllies.g, ColorSet.CodCasterFactionAllies.b)
	HeaderAlliesTeam.Label:setText(LocalizeToUpperString(0xC815AF97EE8C135))
	self:addElement(HeaderAlliesTeam)
	self.HeaderAlliesTeam = HeaderAlliesTeam
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f52_local0 = nil
		if element.menuLoaded then
			f52_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f52_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f52_local0 then
			f52_local0 = element:dispatchEventToChildren(event)
		end
		return f52_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyMainMode", function(model)
		local f53_local0 = model:get()
		if f53_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f53_local0)))
		end
	end)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f54_local0 = model:get()
		if f54_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(f54_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f55_local0 = nil
		if element.menuLoaded then
			f55_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f55_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f55_local0 then
			f55_local0 = element:dispatchEventToChildren(event)
		end
		return f55_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f56_local0 = nil
		if element.menuLoaded then
			f56_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f56_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f56_local0 then
			f56_local0 = element:dispatchEventToChildren(event)
		end
		return f56_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local BackingCODCaster = LUI.UIImage.new(0.5, 0.5, 44, 486, 0, 0, 227, 872)
	BackingCODCaster:setRGB(0, 0, 0)
	BackingCODCaster:setAlpha(0.15)
	self:addElement(BackingCODCaster)
	self.BackingCODCaster = BackingCODCaster
	local DirectorCoDCasterList = CoD.DirectorCoDCasterList.new(f1_local1, f1_arg0, 0.5, 0.5, 65, 465, 0, 0, 250, 820)
	DirectorCoDCasterList:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.ShowDirectorCustomMatchCoDCasterList(f1_arg0)
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.CodCasterUtility.IsCodCasterEnabled()
			end,
		},
	})
	local f1_local23 = DirectorCoDCasterList
	local HeaderCODCaster = DirectorCoDCasterList.subscribeToModel
	local f1_local25 = Engine[0x8DF2E5447F384B9]()
	HeaderCODCaster(f1_local23, f1_local25["lobbyRoot.lobbyNav"], function(f59_arg0)
		f1_local1:updateElementState(DirectorCoDCasterList, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f59_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local23 = DirectorCoDCasterList
	HeaderCODCaster = DirectorCoDCasterList.subscribeToModel
	f1_local25 = Engine[0x8DF2E5447F384B9]()
	HeaderCODCaster(f1_local23, f1_local25["lobbyRoot.gameClient.update"], function(f60_arg0)
		f1_local1:updateElementState(DirectorCoDCasterList, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f60_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local23 = DirectorCoDCasterList
	HeaderCODCaster = DirectorCoDCasterList.subscribeToModel
	f1_local25 = Engine[0x8DF2E5447F384B9]()
	HeaderCODCaster(f1_local23, f1_local25["lobbyRoot.privateClient.update"], function(f61_arg0)
		f1_local1:updateElementState(DirectorCoDCasterList, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f61_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	self:addElement(DirectorCoDCasterList)
	self.DirectorCoDCasterList = DirectorCoDCasterList
	HeaderCODCaster = CoD.DirectorFixedWidthHeading.new(f1_local1, f1_arg0, 0.5, 0.5, 44, 486, 0, 0, 200, 230)
	self:addElement(HeaderCODCaster)
	self.HeaderCODCaster = HeaderCODCaster
	self:mergeStateConditions({
		{
			stateName = "NonTeamBasedGameMode",
			condition = function(menu, element, event)
				local f62_local0
				if not IsZombies() then
					f62_local0 = not IsTeamBasedGameMode(f1_arg0)
				else
					f62_local0 = false
				end
				return f62_local0
			end,
		},
		{
			stateName = "ZMCustomGames",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	f1_local25 = self
	f1_local23 = self.subscribeToModel
	local f1_local26 = Engine[0x8DF2E5447F384B9]()
	f1_local23(f1_local25, f1_local26["lobbyRoot.lobbyNav"], function(f64_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f64_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local25 = self
	f1_local23 = self.subscribeToModel
	f1_local26 = Engine[0x8DF2E5447F384B9]()
	f1_local23(f1_local25, f1_local26["MapVote.mapVoteGameModeNext"], function(f65_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f65_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model, f66_arg1)
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if CoD.DirectorUtility.HasSelectedClient(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			return true
		else
			GoBack(self, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f69_arg2, f69_arg3, f69_arg4)
		if IsMenuInState(f1_local1, "ZMCustomGames") then
			GoBack(self, controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "lobbyRoot.selectedXuid", function(model)
		local f70_local0 = self
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
	DirectorLobbySettingList.id = "DirectorLobbySettingList"
	DirectorGameSettingList.id = "DirectorGameSettingList"
	if CoD.isPC then
		SelectionModeFocusBlocker.id = "SelectionModeFocusBlocker"
	end
	FreeTeam.id = "FreeTeam"
	AxisTeam.id = "AxisTeam"
	AlliesTeam.id = "AlliesTeam"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	DirectorCoDCasterList.id = "DirectorCoDCasterList"
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
	f1_local23 = self
	f1_local23 = SelectionModeFocusBlocker
	if IsPC() then
		SetElementProperty(f1_local23, "_yieldFocus", nil)
		DisableKeyboardNavigationByElement(f1_local23)
		SetIgnorePlaySoundSetSound(f1_local23, true)
	end
	SetElementProperty(FreeTeam, "_checkChildFocusForSelectability", true)
	SetElementProperty(AxisTeam, "_checkChildFocusForSelectability", true)
	SetElementProperty(AlliesTeam, "_checkChildFocusForSelectability", true)
	return self
end
CoD.DirectorCustomGameSetUp.__resetProperties = function(f71_arg0)
	f71_arg0.HeaderFreeTeam:completeAnimation()
	f71_arg0.FreeTeam:completeAnimation()
	f71_arg0.BackingFree:completeAnimation()
	f71_arg0.HeaderAlliesTeam:completeAnimation()
	f71_arg0.HeaderAxisTeam:completeAnimation()
	f71_arg0.HeaderCODCaster:completeAnimation()
	f71_arg0.DirectorCoDCasterList:completeAnimation()
	f71_arg0.BackingCODCaster:completeAnimation()
	f71_arg0.AxisTeam:completeAnimation()
	f71_arg0.BackingAxis:completeAnimation()
	f71_arg0.AlliesTeam:completeAnimation()
	f71_arg0.BackingAllies:completeAnimation()
	f71_arg0.HeaderFreeTeam:setAlpha(1)
	f71_arg0.FreeTeam:setAlpha(1)
	f71_arg0.BackingFree:setAlpha(0.15)
	f71_arg0.HeaderAlliesTeam:setAlpha(1)
	f71_arg0.HeaderAlliesTeam.Backing:setRGB(ColorSet.CodCasterFactionAllies.r, ColorSet.CodCasterFactionAllies.g, ColorSet.CodCasterFactionAllies.b)
	f71_arg0.HeaderAlliesTeam.Backing:setAlpha(1)
	f71_arg0.HeaderAlliesTeam.Label:setRGB(ColorSet.CodCasterFactionAllies.r, ColorSet.CodCasterFactionAllies.g, ColorSet.CodCasterFactionAllies.b)
	f71_arg0.HeaderAlliesTeam.Label:setAlpha(1)
	f71_arg0.HeaderAlliesTeam.Label:setText(LocalizeToUpperString(0xC815AF97EE8C135))
	f71_arg0.HeaderAxisTeam:setAlpha(1)
	f71_arg0.HeaderAxisTeam.Backing:setRGB(ColorSet.CodCasterFactionAxis.r, ColorSet.CodCasterFactionAxis.g, ColorSet.CodCasterFactionAxis.b)
	f71_arg0.HeaderAxisTeam.Backing:setAlpha(1)
	f71_arg0.HeaderAxisTeam.Label:setRGB(ColorSet.CodCasterFactionAxis.r, ColorSet.CodCasterFactionAxis.g, ColorSet.CodCasterFactionAxis.b)
	f71_arg0.HeaderAxisTeam.Label:setText(LocalizeToUpperString(0x12BD5927860415A))
	f71_arg0.HeaderCODCaster:setAlpha(1)
	f71_arg0.HeaderCODCaster.Backing:setRGB(0.29, 0.29, 0.29)
	f71_arg0.DirectorCoDCasterList:setAlpha(1)
	f71_arg0.BackingCODCaster:setAlpha(0.15)
	f71_arg0.AxisTeam:setAlpha(1)
	f71_arg0.BackingAxis:setAlpha(0.15)
	f71_arg0.AlliesTeam:setAlpha(1)
	f71_arg0.BackingAllies:setAlpha(0.15)
end
CoD.DirectorCustomGameSetUp.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(3)
			f72_arg0.BackingFree:completeAnimation()
			f72_arg0.BackingFree:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.BackingFree)
			f72_arg0.FreeTeam:completeAnimation()
			f72_arg0.FreeTeam:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.FreeTeam)
			f72_arg0.HeaderFreeTeam:completeAnimation()
			f72_arg0.HeaderFreeTeam:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.HeaderFreeTeam)
		end,
	},
	NonTeamBasedGameMode = {
		DefaultClip = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(12)
			f73_arg0.BackingFree:completeAnimation()
			f73_arg0.BackingFree:setAlpha(0.15)
			f73_arg0.clipFinished(f73_arg0.BackingFree)
			f73_arg0.FreeTeam:completeAnimation()
			f73_arg0.FreeTeam:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.FreeTeam)
			f73_arg0.HeaderFreeTeam:completeAnimation()
			f73_arg0.HeaderFreeTeam:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.HeaderFreeTeam)
			f73_arg0.BackingAxis:completeAnimation()
			f73_arg0.BackingAxis:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.BackingAxis)
			f73_arg0.AxisTeam:completeAnimation()
			f73_arg0.AxisTeam:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.AxisTeam)
			f73_arg0.HeaderAxisTeam:completeAnimation()
			f73_arg0.HeaderAxisTeam.Backing:completeAnimation()
			f73_arg0.HeaderAxisTeam.Label:completeAnimation()
			f73_arg0.HeaderAxisTeam:setAlpha(0)
			f73_arg0.HeaderAxisTeam.Backing:setRGB(0.29, 0.29, 0.29)
			f73_arg0.HeaderAxisTeam.Backing:setAlpha(1)
			f73_arg0.HeaderAxisTeam.Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f73_arg0.HeaderAxisTeam.Label:setText(LocalizeToUpperString(0x39A9E427416E0C7))
			f73_arg0.clipFinished(f73_arg0.HeaderAxisTeam)
			f73_arg0.BackingAllies:completeAnimation()
			f73_arg0.BackingAllies:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.BackingAllies)
			f73_arg0.AlliesTeam:completeAnimation()
			f73_arg0.AlliesTeam:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.AlliesTeam)
			f73_arg0.HeaderAlliesTeam:completeAnimation()
			f73_arg0.HeaderAlliesTeam.Backing:completeAnimation()
			f73_arg0.HeaderAlliesTeam.Label:completeAnimation()
			f73_arg0.HeaderAlliesTeam:setAlpha(0)
			f73_arg0.HeaderAlliesTeam.Backing:setRGB(0.29, 0.29, 0.29)
			f73_arg0.HeaderAlliesTeam.Backing:setAlpha(1)
			f73_arg0.HeaderAlliesTeam.Label:setRGB(ColorSet.CodCasterFactionAllies.r, ColorSet.CodCasterFactionAllies.g, ColorSet.CodCasterFactionAllies.b)
			f73_arg0.HeaderAlliesTeam.Label:setAlpha(0)
			f73_arg0.HeaderAlliesTeam.Label:setText(LocalizeToUpperString(0xC815AF97EE8C135))
			f73_arg0.clipFinished(f73_arg0.HeaderAlliesTeam)
			f73_arg0.BackingCODCaster:completeAnimation()
			f73_arg0.BackingCODCaster:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.BackingCODCaster)
			f73_arg0.DirectorCoDCasterList:completeAnimation()
			f73_arg0.DirectorCoDCasterList:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.DirectorCoDCasterList)
			f73_arg0.HeaderCODCaster:completeAnimation()
			f73_arg0.HeaderCODCaster.Backing:completeAnimation()
			f73_arg0.HeaderCODCaster:setAlpha(1)
			f73_arg0.HeaderCODCaster.Backing:setRGB(0.29, 0.29, 0.29)
			f73_arg0.clipFinished(f73_arg0.HeaderCODCaster)
		end,
	},
	ZMCustomGames = {
		DefaultClip = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(12)
			f74_arg0.BackingFree:completeAnimation()
			f74_arg0.BackingFree:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.BackingFree)
			f74_arg0.FreeTeam:completeAnimation()
			f74_arg0.FreeTeam:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.FreeTeam)
			f74_arg0.HeaderFreeTeam:completeAnimation()
			f74_arg0.HeaderFreeTeam:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.HeaderFreeTeam)
			f74_arg0.BackingAxis:completeAnimation()
			f74_arg0.BackingAxis:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.BackingAxis)
			f74_arg0.AxisTeam:completeAnimation()
			f74_arg0.AxisTeam:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.AxisTeam)
			f74_arg0.HeaderAxisTeam:completeAnimation()
			f74_arg0.HeaderAxisTeam.Backing:completeAnimation()
			f74_arg0.HeaderAxisTeam.Label:completeAnimation()
			f74_arg0.HeaderAxisTeam:setAlpha(0)
			f74_arg0.HeaderAxisTeam.Backing:setRGB(0.29, 0.29, 0.29)
			f74_arg0.HeaderAxisTeam.Backing:setAlpha(1)
			f74_arg0.HeaderAxisTeam.Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f74_arg0.HeaderAxisTeam.Label:setText(LocalizeToUpperString(0x39A9E427416E0C7))
			f74_arg0.clipFinished(f74_arg0.HeaderAxisTeam)
			f74_arg0.BackingAllies:completeAnimation()
			f74_arg0.BackingAllies:setAlpha(0.15)
			f74_arg0.clipFinished(f74_arg0.BackingAllies)
			f74_arg0.AlliesTeam:completeAnimation()
			f74_arg0.AlliesTeam:setAlpha(1)
			f74_arg0.clipFinished(f74_arg0.AlliesTeam)
			f74_arg0.HeaderAlliesTeam:completeAnimation()
			f74_arg0.HeaderAlliesTeam.Backing:completeAnimation()
			f74_arg0.HeaderAlliesTeam.Label:completeAnimation()
			f74_arg0.HeaderAlliesTeam.Backing:setRGB(0.29, 0.29, 0.29)
			f74_arg0.HeaderAlliesTeam.Backing:setAlpha(1)
			f74_arg0.HeaderAlliesTeam.Label:setRGB(1, 1, 1)
			f74_arg0.HeaderAlliesTeam.Label:setAlpha(1)
			f74_arg0.HeaderAlliesTeam.Label:setText(LocalizeToUpperString(0x39A9F427416E27A))
			f74_arg0.clipFinished(f74_arg0.HeaderAlliesTeam)
			f74_arg0.BackingCODCaster:completeAnimation()
			f74_arg0.BackingCODCaster:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.BackingCODCaster)
			f74_arg0.DirectorCoDCasterList:completeAnimation()
			f74_arg0.DirectorCoDCasterList:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.DirectorCoDCasterList)
			f74_arg0.HeaderCODCaster:completeAnimation()
			f74_arg0.HeaderCODCaster.Backing:completeAnimation()
			f74_arg0.HeaderCODCaster:setAlpha(0)
			f74_arg0.HeaderCODCaster.Backing:setRGB(0.29, 0.29, 0.29)
			f74_arg0.clipFinished(f74_arg0.HeaderCODCaster)
		end,
	},
}
CoD.DirectorCustomGameSetUp.__onClose = function(f75_arg0)
	f75_arg0.DirectorLobbySettingList:close()
	f75_arg0.DirectorGameSettingList:close()
	f75_arg0.SelectionModeFocusBlocker:close()
	f75_arg0.FreeTeam:close()
	f75_arg0.HeaderFreeTeam:close()
	f75_arg0.AxisTeam:close()
	f75_arg0.HeaderAxisTeam:close()
	f75_arg0.AlliesTeam:close()
	f75_arg0.HeaderAlliesTeam:close()
	f75_arg0.FooterContainerFrontendRight:close()
	f75_arg0.CommonHeader:close()
	f75_arg0.BackingGrayMediumLeft:close()
	f75_arg0.DirectorCoDCasterList:close()
	f75_arg0.HeaderCODCaster:close()
end
