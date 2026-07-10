require("x64:dee0d60cf1c6598")
require("x64:b59e6af0a2c4a80")
CoD.DirectorVerticalPartyListCustom = InheritFrom(LUI.UIElement)
CoD.DirectorVerticalPartyListCustom.__defaultWidth = 520
CoD.DirectorVerticalPartyListCustom.__defaultHeight = 524
CoD.DirectorVerticalPartyListCustom.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.DirectorVerticalPartyListCustom)
	self.id = "DirectorVerticalPartyListCustom"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CustomGamePlayersWithFirstEmpty = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	CustomGamePlayersWithFirstEmpty:setLeftRight(0, 0, 95, 520)
	CustomGamePlayersWithFirstEmpty:setTopBottom(0, 0, 0, 524)
	CustomGamePlayersWithFirstEmpty:setScale(0.9, 0.9)
	CustomGamePlayersWithFirstEmpty:setWidgetType(CoD.DirectorCustomGameMember)
	CustomGamePlayersWithFirstEmpty:setSpacing(4)
	CustomGamePlayersWithFirstEmpty:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CustomGamePlayersWithFirstEmpty:setDataSource("DirectorPartyListWithFirstEmpty")
	CustomGamePlayersWithFirstEmpty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "privateClient.max", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CustomGamePlayersWithFirstEmpty:setVerticalCount(f2_local0)
		end
	end)
	CustomGamePlayersWithFirstEmpty:linkToElementModel(CustomGamePlayersWithFirstEmpty, "clientListFlags", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = CustomGamePlayersWithFirstEmpty
	local f1_local3 = CustomGamePlayersWithFirstEmpty.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamePlayersWithFirstEmpty:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local2 = CustomGamePlayersWithFirstEmpty
	f1_local3 = CustomGamePlayersWithFirstEmpty.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamePlayersWithFirstEmpty:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CustomGamePlayersWithFirstEmpty, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLobbyNetworkModeLAN() and IsGamepad(controller) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Social_InvitePlayersPopup", controller, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLobbyNetworkModeLAN() and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Social_InvitePlayersPopup", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLobbyNetworkModeLAN() and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x7F02CC573E312E5, nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLobbyNetworkModeLAN() and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(CustomGamePlayersWithFirstEmpty)
	self.CustomGamePlayersWithFirstEmpty = CustomGamePlayersWithFirstEmpty
	f1_local3 = nil
	self.FooterButtonAddControllerHelpContainer = LUI.UIElement.createFake()
	self:mergeStateConditions({
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				local f10_local0 = IsZombies()
				if f10_local0 then
					if not IsPC() then
						f10_local0 = not IsLobbyNetworkModeLAN()
					else
						f10_local0 = false
					end
				end
				return f10_local0
			end,
		},
	})
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CustomGamePlayersWithFirstEmpty.id = "CustomGamePlayersWithFirstEmpty"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorVerticalPartyListCustom.__onClose = function(f12_arg0)
	f12_arg0.CustomGamePlayersWithFirstEmpty:close()
	f12_arg0.FooterButtonAddControllerHelpContainer:close()
end
