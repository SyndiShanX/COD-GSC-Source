require("x64:b64d9dfa5911bd2")
CoD.PositionDraft_CharacterList = InheritFrom(LUI.UIElement)
CoD.PositionDraft_CharacterList.__defaultWidth = 420
CoD.PositionDraft_CharacterList.__defaultHeight = 639
CoD.PositionDraft_CharacterList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_CharacterList)
	self.id = "PositionDraft_CharacterList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Characters = LUI.UIList.new(f1_arg0, f1_arg1, -5, 0, nil, true, false, false, false)
	Characters:mergeStateConditions({
		{
			stateName = "ViewSelectedPlayer_Searching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local2 = Characters
	local f1_local3 = Characters.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["PositionEditLoadout.SelectedCharacterIndex"], function(f3_arg0)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "PositionEditLoadout.SelectedCharacterIndex",
		})
	end, false)
	Characters:linkToElementModel(Characters, "characterIndex", true, function(model)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	Characters:linkToElementModel(Characters, "isBMLocked", true, function(model)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMLocked",
		})
	end)
	Characters:linkToElementModel(Characters, "disabled", true, function(model)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	Characters:linkToElementModel(Characters, "unavailable", true, function(model)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	f1_local2 = Characters
	f1_local3 = Characters.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["hudItems.specialistSwitchIsLethal"], function(f8_arg0)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.specialistSwitchIsLethal",
		})
	end, false)
	f1_local2 = Characters
	f1_local3 = Characters.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f9_arg0)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	Characters:setLeftRight(0.5, 0.5, -245, 249)
	Characters:setTopBottom(0.5, 0.5, -383, 372)
	Characters:setScale(0.88, 0.88)
	Characters:setWidgetType(CoD.PositionDraft_Character)
	Characters:setHorizontalCount(3)
	Characters:setVerticalCount(5)
	Characters:setSpacing(-5)
	Characters:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Characters:setDataSource("PositionDraftCharacters")
	f1_local2 = Characters
	f1_local3 = Characters.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["factions.isCoDCaster"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Characters:registerEventHandler("list_item_gain_focus", function(element, event)
		local f11_local0 = nil
		if not IsCodCaster(f1_arg1) then
			PositionDraftOnFocusCharacter(self, element, f1_arg1)
		end
		return f11_local0
	end)
	Characters:registerEventHandler("list_item_lose_focus", function(element, event)
		local f12_local0 = nil
		if not IsCodCaster(f1_arg1) and IsPC() then
			PositionDraftOnFocusCharacterLost(self, element, f1_arg1, false)
		end
		return f12_local0
	end)
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsCodCaster(controller) and IsElementInState(element, "DefaultState") then
			PositionDraftSelectCharacter(self, element, controller)
			SetLoseFocusToElement(self, "Characters", controller)
			SetControllerModelValue(controller, "PositionDraft.characterSelected", true)
			PlaySoundAlias("uin_specialist_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsCodCaster(controller) and IsElementInState(element, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(Characters, "setState", function(element, controller, f16_arg2, f16_arg3, f16_arg4)
		if IsSelfInState(self, "Draft") then
			CoD.FreeCursorUtility.RetriggerCursorPosition(f1_arg0, controller)
			CheckDefaultPCFocus(self.Characters, f1_arg0, controller)
		elseif IsSelfInState(self, "CharacterSelected") then
			CoD.FreeCursorUtility.RetriggerCursorPosition(f1_arg0, controller)
			CheckDefaultPCFocus(self.PositionDraftReadyButton, f1_arg0, controller)
		else
			ClearRecordedFocus(f1_arg0, controller)
			CoD.FreeCursorUtility.RetriggerCursorPosition(f1_arg0, controller)
		end
	end)
	self:addElement(Characters)
	self.Characters = Characters
	Characters.id = "Characters"
	self.__defaultFocus = Characters
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.PlayerRoleUtility.PositionDraftCharactersPostLoad(self, f1_arg1, self.Characters)
	f1_local3 = Characters
	if IsPC() then
		SetElementPropertyEnum(f1_local3, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.ACTION_PROMPT)
	else
		SetElementPropertyEnum(f1_local3, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.ACTION_PROMPT)
	end
	return self
end
CoD.PositionDraft_CharacterList.__onClose = function(f17_arg0)
	f17_arg0.Characters:close()
end
