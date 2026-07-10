require("x64:673b9bfc92c298b")
CoD.PC_PartyListContainer = InheritFrom(LUI.UIElement)
CoD.PC_PartyListContainer.__defaultWidth = 68
CoD.PC_PartyListContainer.__defaultHeight = 68
CoD.PC_PartyListContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_PartyListContainer)
	self.id = "PC_PartyListContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PartyList = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	PartyList:setLeftRight(1, 1, -68, 0)
	PartyList:setTopBottom(0, 0, 0, 68)
	PartyList:setWidgetType(CoD.DirectorLobbyMember)
	PartyList:setSpacing(5)
	PartyList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PartyList:setBackingWidgetYPadding(-7)
	PartyList:setDataSource("DirectorPartyList")
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
	PartyList:registerEventHandler("gain_list_focus", function(element, event)
		local f5_local0 = nil
		DispatchEventToChildren(element, "update_state", f1_arg1)
		return f5_local0
	end)
	PartyList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForPartyMember(self, f1_arg0, f1_arg1, element)
		end
		return f6_local0
	end)
	PartyList:registerEventHandler("lose_list_focus", function(element, event)
		local f7_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForLocalClient(f1_arg1)
		end
		return f7_local0
	end)
	PartyList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PartyList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			OpenOverlay(self, "Social_Main", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_42EA47C1D2988981", nil, nil)
			return true
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
CoD.PC_PartyListContainer.__onClose = function(f11_arg0)
	f11_arg0.PartyList:close()
end
