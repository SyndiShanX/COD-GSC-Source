require("x64:dee0d60cf1c6598")
require("x64:dc269f8d53f7f20")
require("x64:2729998c349f5a5")
require("x64:29187ea00d726c3")
CoD.DirectorPublicPlayerLists = InheritFrom(LUI.UIElement)
CoD.DirectorPublicPlayerLists.__defaultWidth = 425
CoD.DirectorPublicPlayerLists.__defaultHeight = 761
CoD.DirectorPublicPlayerLists.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.DirectorPublicPlayerLists)
	self.id = "DirectorPublicPlayerLists"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PartyCount = CoD.FooterButton_PartyCount.new(f1_arg0, f1_arg1, 0, 0, 1, 201, 0, 0, 0, 37)
	self:addElement(PartyCount)
	self.PartyCount = PartyCount
	local PartyList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	PartyList:mergeStateConditions({
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY)
			end,
		},
		{
			stateName = "EmptySearching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PartyList:linkToElementModel(PartyList, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(PartyList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	PartyList:linkToElementModel(PartyList, "info", true, function(model)
		if PartyList["__stateValidation_info->isPartyMember"] then
			PartyList:removeSubscription(PartyList["__stateValidation_info->isPartyMember"])
			PartyList["__stateValidation_info->isPartyMember"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.isPartyMember
		end
		if model then
			PartyList["__stateValidation_info->isPartyMember"] = PartyList:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(PartyList, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "info->isPartyMember",
				})
			end)
		end
	end)
	local f1_local3 = PartyList
	local VerticalListSpacer = PartyList.subscribeToModel
	local dotline = Engine[@"getglobalmodel"]()
	VerticalListSpacer(f1_local3, dotline["lobbyRoot.publicLobby.stage"], function(f8_arg0)
		f1_arg0:updateElementState(PartyList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	f1_local3 = PartyList
	VerticalListSpacer = PartyList.subscribeToModel
	dotline = Engine[@"getglobalmodel"]()
	VerticalListSpacer(f1_local3, dotline["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(PartyList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	PartyList:setLeftRight(0, 0, 0, 425)
	PartyList:setTopBottom(0, 0, 37, 395)
	PartyList:setWidgetType(CoD.DirectorExpandedLobbyMember)
	PartyList:setVerticalCount(5)
	PartyList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PartyList:setDataSource("DirectorPartyListWithFirstEmpty")
	PartyList:linkToElementModel(PartyList, "clientListFlags", true, function(model, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local3 = PartyList
	VerticalListSpacer = PartyList.subscribeToModel
	dotline = Engine[@"getglobalmodel"]()
	VerticalListSpacer(f1_local3, dotline["lobbyRoot.lobbyNetworkMode"], function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local3 = PartyList
	VerticalListSpacer = PartyList.subscribeToModel
	dotline = Engine[@"getglobalmodel"]()
	VerticalListSpacer(f1_local3, dotline["lobbyRoot.lobbyNav"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PartyList:registerEventHandler("gain_list_focus", function(element, event)
		local f13_local0 = nil
		DispatchEventToChildren(element, "update_state", f1_arg1)
		return f13_local0
	end)
	PartyList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f14_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForPartyMember(self, f1_arg0, f1_arg1, element)
		end
		return f14_local0
	end)
	PartyList:registerEventHandler("lose_list_focus", function(element, event)
		local f15_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForLocalClient(f1_arg1)
		end
		return f15_local0
	end)
	PartyList:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PartyList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			OpenOverlay(self, "Social_InvitePlayersPopup", controller, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			OpenOverlay(self, "Social_InvitePlayersPopup", controller, nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) then
			OpenLobbyInspection(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_42EA47C1D2988981", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_FF0DBCF80106E7B", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(PartyList, "setHeight", function(element, controller)
		ScaleToElementHeight(self, element, 0)
	end)
	self:addElement(PartyList)
	self.PartyList = PartyList
	VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 4, 429, 0, 0, 395, 399)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	f1_local3 = nil
	self.FooterButtonAddControllerHelpContainer = LUI.UIElement.createFake()
	dotline = LUI.UIImage.new(0, 0, 4, 425, 0, 0, 419, 425)
	dotline:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline)
	self.dotline = dotline
	local VerticalListSpacer02 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 425, 0, 0, 425, 427)
	self:addElement(VerticalListSpacer02)
	self.VerticalListSpacer02 = VerticalListSpacer02
	local LobbyList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	LobbyList:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LobbyList:linkToElementModel(LobbyList, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(LobbyList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	LobbyList:linkToElementModel(LobbyList, "info", true, function(model)
		if LobbyList["__stateValidation_info->xuid"] then
			LobbyList:removeSubscription(LobbyList["__stateValidation_info->xuid"])
			LobbyList["__stateValidation_info->xuid"] = nil
		end
		if model then
			local f22_local0 = model:get()
			local f22_local1 = model:get()
			model = f22_local0 and f22_local1.xuid
		end
		if model then
			LobbyList["__stateValidation_info->xuid"] = LobbyList:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(LobbyList, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "info->xuid",
				})
			end)
		end
	end)
	LobbyList:linkToElementModel(LobbyList, "info", true, function(model)
		if LobbyList["__stateValidation_info->isPartyMember"] then
			LobbyList:removeSubscription(LobbyList["__stateValidation_info->isPartyMember"])
			LobbyList["__stateValidation_info->isPartyMember"] = nil
		end
		if model then
			local f24_local0 = model:get()
			local f24_local1 = model:get()
			model = f24_local0 and f24_local1.isPartyMember
		end
		if model then
			LobbyList["__stateValidation_info->isPartyMember"] = LobbyList:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(LobbyList, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "info->isPartyMember",
				})
			end)
		end
	end)
	local f1_local8 = LobbyList
	local VerticalListSpacer01 = LobbyList.subscribeToModel
	local f1_local10 = Engine[@"getglobalmodel"]()
	VerticalListSpacer01(f1_local8, f1_local10["lobbyRoot.publicLobby.stage"], function(f26_arg0)
		f1_arg0:updateElementState(LobbyList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	f1_local8 = LobbyList
	VerticalListSpacer01 = LobbyList.subscribeToModel
	f1_local10 = Engine[@"getglobalmodel"]()
	VerticalListSpacer01(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f27_arg0)
		f1_arg0:updateElementState(LobbyList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LobbyList:setLeftRight(0, 0, 0, 425)
	LobbyList:setTopBottom(0, 0, 427, 785)
	LobbyList:setWidgetType(CoD.DirectorExpandedLobbyMember)
	LobbyList:setVerticalCount(5)
	LobbyList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LobbyList:setDataSource("DirectorLobbyNonPartyList")
	LobbyList:linkToElementModel(LobbyList, "clientListFlags", true, function(model, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local8 = LobbyList
	VerticalListSpacer01 = LobbyList.subscribeToModel
	f1_local10 = Engine[@"getglobalmodel"]()
	VerticalListSpacer01(f1_local8, f1_local10["lobbyRoot.lobbyNetworkMode"], function(f29_arg0, f29_arg1)
		CoD.Menu.UpdateButtonShownState(f29_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local8 = LobbyList
	VerticalListSpacer01 = LobbyList.subscribeToModel
	f1_local10 = Engine[@"getglobalmodel"]()
	VerticalListSpacer01(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LobbyList:registerEventHandler("gain_list_focus", function(element, event)
		local f31_local0 = nil
		DispatchEventToChildren(element, "update_state", f1_arg1)
		return f31_local0
	end)
	LobbyList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f32_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForPartyMember(self, f1_arg0, f1_arg1, element)
		end
		return f32_local0
	end)
	LobbyList:registerEventHandler("lose_list_focus", function(element, event)
		local f33_local0 = nil
		if AlwaysFalse() then
			CoD.DirectorUtility.PlayFrozenMomentForLocalClient(f1_arg1)
		end
		return f33_local0
	end)
	LobbyList:registerEventHandler("gain_focus", function(element, event)
		local f34_local0 = nil
		if element.gainFocus then
			f34_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f34_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f34_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LobbyList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			OpenOverlay(self, "Social_Main", controller, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			OpenOverlay(self, "Social_InvitePlayersPopup", controller, nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) then
			OpenLobbyInspection(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_42EA47C1D2988981", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and IsPC() and not IsLAN() and IsPlayerAllowedToPlayOnline(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_FF0DBCF80106E7B", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(LobbyList, "setHeight", function(element, controller)
		ScaleToElementHeight(self, element, 0)
	end)
	self:addElement(LobbyList)
	self.LobbyList = LobbyList
	VerticalListSpacer01 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 425, 0, 0, 785, 787)
	self:addElement(VerticalListSpacer01)
	self.VerticalListSpacer01 = VerticalListSpacer01
	self:mergeStateConditions({
		{
			stateName = "ShowLobbyList",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorLobbyList(f1_arg1)
			end,
		},
		{
			stateName = "HideSplitscreenInstructions",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsMatchmakingInProgress(f1_arg1)
			end,
		},
	})
	f1_local10 = self
	f1_local8 = self.subscribeToModel
	local f1_local11 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local10, f1_local11["lobbyRoot.lobbyNav"], function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local10 = self
	f1_local8 = self.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local10, f1_local11["lobbyRoot.publicLobby.stage"], function(f41_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	PartyList.id = "PartyList"
	LobbyList.id = "LobbyList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPublicPlayerLists.__resetProperties = function(f42_arg0)
	f42_arg0.LobbyList:completeAnimation()
	f42_arg0.FooterButtonAddControllerHelpContainer:completeAnimation()
	f42_arg0.LobbyList:setAlpha(1)
	f42_arg0.FooterButtonAddControllerHelpContainer:setAlpha(1)
end
CoD.DirectorPublicPlayerLists.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(1)
			f43_arg0.LobbyList:completeAnimation()
			f43_arg0.LobbyList:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.LobbyList)
		end,
	},
	ShowLobbyList = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(1)
			f44_arg0.FooterButtonAddControllerHelpContainer:completeAnimation()
			f44_arg0.FooterButtonAddControllerHelpContainer:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.FooterButtonAddControllerHelpContainer)
			f44_arg0.LobbyList:completeAnimation()
			f44_arg0.LobbyList:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.LobbyList)
		end,
	},
	HideSplitscreenInstructions = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(1)
			f45_arg0.FooterButtonAddControllerHelpContainer:completeAnimation()
			f45_arg0.FooterButtonAddControllerHelpContainer:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.FooterButtonAddControllerHelpContainer)
			f45_arg0.LobbyList:completeAnimation()
			f45_arg0.LobbyList:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.LobbyList)
		end,
	},
}
CoD.DirectorPublicPlayerLists.__onClose = function(f46_arg0)
	f46_arg0.PartyCount:close()
	f46_arg0.PartyList:close()
	f46_arg0.VerticalListSpacer:close()
	f46_arg0.FooterButtonAddControllerHelpContainer:close()
	f46_arg0.VerticalListSpacer02:close()
	f46_arg0.LobbyList:close()
	f46_arg0.VerticalListSpacer01:close()
end
