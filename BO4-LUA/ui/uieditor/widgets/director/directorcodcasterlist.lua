require("x64:4966d07fc5fd240")
CoD.DirectorCoDCasterList = InheritFrom(LUI.UIElement)
CoD.DirectorCoDCasterList.__defaultWidth = 400
CoD.DirectorCoDCasterList.__defaultHeight = 140
CoD.DirectorCoDCasterList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 15, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.DirectorCoDCasterList)
	self.id = "DirectorCoDCasterList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterTeam = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	CodCasterTeam:setLeftRight(0, 0, 0, 400)
	CodCasterTeam:setTopBottom(0, 0, 0, 180)
	CodCasterTeam:setWidgetType(CoD.DirectorCustomGameCodCaster)
	CodCasterTeam:setVerticalCount(2)
	CodCasterTeam:setSpacing(10)
	CodCasterTeam:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CodCasterTeam:setFilter(function(f2_arg0)
		return f2_arg0.team:get() == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556]
	end)
	CodCasterTeam:setDataSource("DirectorPartyListCustom")
	CodCasterTeam:appendEventHandler("on_session_start", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	CodCasterTeam:appendEventHandler("on_session_end", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = CodCasterTeam
	local f1_local3 = CodCasterTeam.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = CodCasterTeam
	f1_local3 = CodCasterTeam.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.gameClient.update"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = CodCasterTeam
	f1_local3 = CodCasterTeam.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.privateClient.update"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CodCasterTeam:linkToElementModel(CodCasterTeam, "xuid", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	CodCasterTeam:linkToElementModel(CodCasterTeam, "team", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local2 = CodCasterTeam
	f1_local3 = CodCasterTeam.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.selectedXuid, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CodCasterTeam:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local2 = CodCasterTeam
	f1_local3 = CodCasterTeam.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = CodCasterTeam
	f1_local3 = CodCasterTeam.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.selectedXuidTeam, function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CodCasterTeam:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CodCasterTeam, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
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
	self:addElement(CodCasterTeam)
	self.CodCasterTeam = CodCasterTeam
	CodCasterTeam.id = "CodCasterTeam"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	SetElementProperty(CodCasterTeam, "_checkChildFocusForSelectability", true)
	return self
end
CoD.DirectorCoDCasterList.__resetProperties = function(f17_arg0)
	f17_arg0.CodCasterTeam:completeAnimation()
	f17_arg0.CodCasterTeam:setAlpha(1)
end
CoD.DirectorCoDCasterList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.CodCasterTeam:completeAnimation()
			f19_arg0.CodCasterTeam:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CodCasterTeam)
		end,
	},
	Invisible = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.CodCasterTeam:completeAnimation()
			f20_arg0.CodCasterTeam:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CodCasterTeam)
		end,
	},
}
CoD.DirectorCoDCasterList.__onClose = function(f21_arg0)
	f21_arg0.CodCasterTeam:close()
end
