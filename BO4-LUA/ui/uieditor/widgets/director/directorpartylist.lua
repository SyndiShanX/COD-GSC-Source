require("x64:dee0d60cf1c6598")
require("x64:673b9bfc92c298b")
CoD.DirectorPartyList = InheritFrom(LUI.UIElement)
CoD.DirectorPartyList.__defaultWidth = 408
CoD.DirectorPartyList.__defaultHeight = 70
CoD.DirectorPartyList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPartyList)
	self.id = "DirectorPartyList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PartyList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	PartyList:setLeftRight(1, 1, -408, 0)
	PartyList:setTopBottom(0, 0, 0, 68)
	PartyList:setWidgetType(CoD.DirectorLobbyMember)
	PartyList:setHorizontalCount(6)
	PartyList:setSpacing(0)
	PartyList:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	PartyList:setBackingWidgetYPadding(-7)
	PartyList:setDataSource("DirectorPartyListHorizontal")
	PartyList:linkToElementModel(PartyList, "clientListFlags", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local2 = PartyList
	local f1_local3 = PartyList.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNetworkMode"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local2 = PartyList
	f1_local3 = PartyList.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PartyList:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local2 = PartyList
	f1_local3 = PartyList.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PartyList:registerEventHandler("gain_list_focus", function(element, event)
		local f7_local0 = nil
		DispatchEventToChildren(element, "update_state", f1_arg1)
		return f7_local0
	end)
	PartyList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f8_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForPartyMember(self, f1_arg0, f1_arg1, element)
		end
		return f8_local0
	end)
	PartyList:registerEventHandler("lose_list_focus", function(element, event)
		local f9_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForLocalClient(f1_arg1)
		end
		return f9_local0
	end)
	PartyList:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PartyList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) and IsPC() then
			OpenOverlay(self, "Social_InvitePlayersPopup", controller, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			OpenOverlay(self, "Social_InvitePlayersPopup", controller, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsGamepad(controller) then
			OpenLobbyInspection(menu, element, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsMouseOrKeyboard(controller) then
			OpenLobbyInspection(menu, element, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_42EA47C1D2988981", nil, "ui_confirm")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_FF0DBCF80106E7B", nil, "ui_confirm")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(PartyList)
	self.PartyList = PartyList
	PartyList.id = "PartyList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPartyList.__onClose = function(f13_arg0)
	f13_arg0.PartyList:close()
end
