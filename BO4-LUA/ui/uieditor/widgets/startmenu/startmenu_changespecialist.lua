require("x64:88b4d51833c79f5")
require("x64:341ce33d59fafd1")
require("x64:c048e011d7fa11c")
require("x64:e6df4068375d284")
require("x64:b64d9dfa5911bd2")
require("x64:753cb15c89114c6")
require("x64:2190adaba331dcb")
require("x64:b710bc406e458bd")
CoD.StartMenu_ChangeSpecialist = InheritFrom(LUI.UIElement)
CoD.StartMenu_ChangeSpecialist.__defaultWidth = 1980
CoD.StartMenu_ChangeSpecialist.__defaultHeight = 1080
CoD.StartMenu_ChangeSpecialist.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if IsInGame() then
		CoD.PlayerRoleUtility.SetPositionDraftSelectedCharacterIndex(f1_arg1)
	end
	self:setClass(CoD.StartMenu_ChangeSpecialist)
	self.id = "StartMenu_ChangeSpecialist"
	self.soundSet = "MultiplayerMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local specialistRespawnDesc = LUI.UIText.new(0.5, 0.5, -281.5, 281.5, 0.5, 0.5, -339.5, -306.5)
	specialistRespawnDesc:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	specialistRespawnDesc:setZoom(10)
	specialistRespawnDesc:setText(LocalizeToUpperString(0xAC6339F7CCE11C4))
	specialistRespawnDesc:setTTF("ttmussels_demibold")
	specialistRespawnDesc:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	specialistRespawnDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(specialistRespawnDesc)
	self.specialistRespawnDesc = specialistRespawnDesc
	local Characters = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	Characters:mergeStateConditions({
		{
			stateName = "ViewSelectedPlayer_Searching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local3 = Characters
	local DraftCooldown = Characters.subscribeToModel
	local ChangeClassButtonPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	DraftCooldown(f1_local3, ChangeClassButtonPC["PositionEditLoadout.SelectedCharacterIndex"], function(f3_arg0)
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
	f1_local3 = Characters
	DraftCooldown = Characters.subscribeToModel
	ChangeClassButtonPC = Engine[0x8DF2E5447F384B9]()
	DraftCooldown(f1_local3, ChangeClassButtonPC["hudItems.specialistSwitchIsLethal"], function(f8_arg0)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.specialistSwitchIsLethal",
		})
	end, false)
	f1_local3 = Characters
	DraftCooldown = Characters.subscribeToModel
	ChangeClassButtonPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	DraftCooldown(f1_local3, ChangeClassButtonPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]], function(f9_arg0)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47],
		})
	end, false)
	Characters:setLeftRight(0.5, 0.5, -594, 594)
	Characters:setTopBottom(0.5, 0.5, -301, 11)
	Characters:setWidgetType(CoD.PositionDraft_Character)
	Characters:setHorizontalCount(7)
	Characters:setVerticalCount(2)
	Characters:setBalanceGridRows(true)
	Characters:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Characters:setDataSource("PositionDraftCharacters")
	Characters:registerEventHandler("lose_list_focus", function(element, event)
		local f10_local0 = nil
		CoD.GridAndListUtility.UpdateDataSource(self.Characters, false, false, false)
		return f10_local0
	end)
	Characters:registerEventHandler("list_item_gain_focus", function(element, event)
		local f11_local0 = nil
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg1, self.RestrictedText, element)
		UpdateElementState(self, "RestrictedText", f1_arg1)
		return f11_local0
	end)
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.PlayerRoleUtility.IsSpecialistSelectable(element, controller) and not IsElementInState(element, "Unavailable") and not IsElementInState(element, "UnavailablePC") and not IsPC() and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.PlayerRoleUtility.InGameChangeSpecialist(element, controller)
			PlaySoundAlias("uin_start_char_select")
			return true
		elseif CoD.PlayerRoleUtility.IsSpecialistSelectable(element, controller) and not IsElementInState(element, "Unavailable") and not IsElementInState(element, "UnavailablePC") and IsPC() and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.PlayerRoleUtility.InGameChangeSpecialist(element, controller)
			PlaySoundAlias("uin_start_char_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.PlayerRoleUtility.IsSpecialistSelectable(element, controller) and not IsElementInState(element, "Unavailable") and not IsElementInState(element, "UnavailablePC") and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, Enum[0xBEBDBAEEB3ECCCA][0x71B04FAC5BE0E35] | 400 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], "ui_confirm")
			return true
		elseif CoD.PlayerRoleUtility.IsSpecialistSelectable(element, controller) and not IsElementInState(element, "Unavailable") and not IsElementInState(element, "UnavailablePC") and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Characters)
	self.Characters = Characters
	DraftCooldown = CoD.PositionDraft_Cooldown.new(f1_arg0, f1_arg1, 0.5, 0.5, -862.5, 862.5, 0.5, 0.5, -391.5, -354.5)
	DraftCooldown:setZoom(10)
	self:addElement(DraftCooldown)
	self.DraftCooldown = DraftCooldown
	f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.ChangeClassButton = f1_local3
	ChangeClassButtonPC = nil
	ChangeClassButtonPC = CoD.DirectorGenericButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -125, 125, 1, 1, -300, -208)
	ChangeClassButtonPC:setScale(0.8, 0.8)
	ChangeClassButtonPC.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x83E3BA6F8C2DB04))
	ChangeClassButtonPC.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x83E3BA6F8C2DB04))
	local f1_local6 = ChangeClassButtonPC
	local f1_local7 = ChangeClassButtonPC.subscribeToModel
	local SignatureAbility = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, SignatureAbility["PositionDraft.stage"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ChangeClassButtonPC:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ChangeClassButtonPC, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueLessThan(controller, "PositionDraft.stage", 6) then
			CoD.StartMenuUtility.ShowClassSelectSlideout(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueLessThan(controller, "PositionDraft.stage", 6) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ChangeClassButtonPC)
	self.ChangeClassButtonPC = ChangeClassButtonPC
	f1_local7 = nil
	f1_local7 = LUI.UIElement.createFake()
	self.ArenaQuitButton = f1_local7
	f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.QuitButton = f1_local6
	SignatureAbility = CoD.StartMenu_SignatureItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -41.5, 498.5, 0.5, 0.5, 45.5, 160.5)
	SignatureAbility:setScale(0.8, 0.8)
	self:addElement(SignatureAbility)
	self.SignatureAbility = SignatureAbility
	local SignatureEquipment = CoD.StartMenu_SignatureItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -498.5, 41.5, 0.5, 0.5, 45.5, 160.5)
	SignatureEquipment:setScale(0.8, 0.8)
	self:addElement(SignatureEquipment)
	self.SignatureEquipment = SignatureEquipment
	local SelectedClassMiniPreview = CoD.SelectedClassMiniPreview.new(f1_arg0, f1_arg1, -0.1, 1.1, 0, 0, 1, 1, -186.5, 113.5)
	self:addElement(SelectedClassMiniPreview)
	self.SelectedClassMiniPreview = SelectedClassMiniPreview
	local XpMeter = CoD.AARXpMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -878.5, 421.5, 1, 1, -347, -328)
	XpMeter:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsPublicOnlineGame()
			end,
		},
	})
	XpMeter.PreviousXP.Meter:setShaderVector(0, 0, 0, 0, 0)
	XpMeter.PreviousXP.MeterAdd:setShaderVector(0, 0, 0, 0, 0)
	XpMeter.PreviousXP.MeterGlow:setShaderVector(0, 0, 0, 0, 0)
	XpMeter:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", nil, function(model)
		XpMeter:setModel(model, f1_arg1)
	end)
	XpMeter:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", "progress", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			XpMeter.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", "progress", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			XpMeter.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", "progress", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			XpMeter.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f23_local0, 1), CoD.GetVectorComponentFromString(f23_local0, 2), CoD.GetVectorComponentFromString(f23_local0, 3), CoD.GetVectorComponentFromString(f23_local0, 4))
		end
	end)
	XpMeter:linkToElementModel(self, "xpEarnedDuringMatch", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			XpMeter.xpEarnedText:setText(LocalizeIntoString(0x5C4E2BA06EA49A5, f24_local0))
		end
	end)
	XpMeter:linkToElementModel(self, "xpNeededToLevelUp", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			XpMeter.xpNeededText:setText(LocalizeIntoString(0x2B924F206C5B4D8, f25_local0))
		end
	end)
	self:addElement(XpMeter)
	self.XpMeter = XpMeter
	local PCKoreaContentDescriptorsIcons = nil
	PCKoreaContentDescriptorsIcons = CoD.PC_Korea_ContentDescriptors_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, -885.5, -696.5, 0, 0, 89.5, 425.5)
	self:addElement(PCKoreaContentDescriptorsIcons)
	self.PCKoreaContentDescriptorsIcons = PCKoreaContentDescriptorsIcons
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_arg0, f1_arg1, 0.5, 0.5, -247, 247, 0.5, 0.5, 19.5, 49.5)
	RestrictedText:mergeStateConditions({
		{
			stateName = "CharacterRestricted",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeCWL() and CoD.PlayerRoleUtility.IsSelfModelCharacterRestricted(element)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f27_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f27_local0 = CoD.PlayerRoleUtility.IsAnyAbilityRestricted(element)
				else
					f27_local0 = false
				end
				return f27_local0
			end,
		},
	})
	local f1_local14 = RestrictedText
	local f1_local15 = RestrictedText.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f28_arg0)
		f1_arg0:updateElementState(RestrictedText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	SignatureAbility:linkToElementModel(Characters, "equipment", false, function(model)
		SignatureAbility:setModel(model, f1_arg1)
	end)
	SignatureEquipment:linkToElementModel(Characters, "ability", false, function(model)
		SignatureEquipment:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "GameTypeBounty",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.GameTypeHidesChooseClass(f1_arg1)
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self.__on_onStartMenuOpened_self = function(f34_arg0, f34_arg1)
		local f34_local0 = self
		CoD.PlayerRoleUtility.UpdatePositionDraftModels(f34_arg1)
	end
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f35_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xDDDF8559F5B304D) and CoD.ModelUtility.IsScriptNotifyDataArgEqualTo(model, 1, 1) then
			CoD.ModelUtility.SetScriptNotifyDataArg(model, 1, 0)
			StartMenuGoBack(f1_arg0, f1_arg1)
		end
	end)
	Characters.id = "Characters"
	f1_local3.id = "ChangeClassButton"
	if CoD.isPC then
		ChangeClassButtonPC.id = "ChangeClassButtonPC"
	end
	f1_local7.id = "ArenaQuitButton"
	f1_local6:appendEventHandler("menu_loaded", function()
		f1_local6:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	f1_local6.id = "QuitButton"
	SelectedClassMiniPreview.id = "SelectedClassMiniPreview"
	self.__defaultFocus = f1_local3
	self.__on_close_removeOverrides = function()
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	if IsPC() and IsMouseOrKeyboard(f1_arg1) then
		CoD.PlayerRoleUtility.SubscribeForPostionDraftUpdates(self, f1_arg1)
		CoD.PCUtility.SetListOrGridAsAcceptingFocusToActiveElement(self.Characters)
		CoD.BountyHunterUtility.SetChangeSpecialistDefaultFocus(self, f1_arg1)
	else
		CoD.PlayerRoleUtility.SubscribeForPostionDraftUpdates(self, f1_arg1)
		CoD.BountyHunterUtility.SetChangeSpecialistDefaultFocus(self, f1_arg1)
	end
	f1_local15 = Characters
	if IsPC() then
		SetElementPropertyEnum(f1_local15, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT)
	else
		SetElementPropertyEnum(f1_local15, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT)
	end
	return self
end
CoD.StartMenu_ChangeSpecialist.__resetProperties = function(f38_arg0)
	f38_arg0.ArenaQuitButton:completeAnimation()
	f38_arg0.ChangeClassButton:completeAnimation()
	f38_arg0.QuitButton:completeAnimation()
	f38_arg0.SelectedClassMiniPreview:completeAnimation()
	f38_arg0.ChangeClassButtonPC:completeAnimation()
	f38_arg0.XpMeter:completeAnimation()
	f38_arg0.ArenaQuitButton:setAlpha(0)
	f38_arg0.ChangeClassButton:setAlpha(1)
	f38_arg0.QuitButton:setLeftRight(0.5, 0.5, -12, 238)
	f38_arg0.QuitButton:setAlpha(1)
	f38_arg0.SelectedClassMiniPreview:setAlpha(1)
	f38_arg0.ChangeClassButtonPC:setAlpha(1)
	f38_arg0.XpMeter:setAlpha(1)
end
CoD.StartMenu_ChangeSpecialist.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(0)
			f39_arg0.ArenaQuitButton:completeAnimation()
			f39_arg0.ArenaQuitButton:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ArenaQuitButton)
		end,
	},
	GameTypeBounty = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.ChangeClassButton:completeAnimation()
			f40_arg0.ChangeClassButton:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.ChangeClassButton)
			f40_arg0.ChangeClassButtonPC:completeAnimation()
			f40_arg0.ChangeClassButtonPC:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.ChangeClassButtonPC)
			f40_arg0.QuitButton:completeAnimation()
			f40_arg0.QuitButton:setLeftRight(0.5, 0.5, -125, 125)
			f40_arg0.clipFinished(f40_arg0.QuitButton)
			f40_arg0.SelectedClassMiniPreview:completeAnimation()
			f40_arg0.SelectedClassMiniPreview:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.SelectedClassMiniPreview)
		end,
	},
	Arena = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(1)
			f41_arg0.ArenaQuitButton:completeAnimation()
			f41_arg0.ArenaQuitButton:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.ArenaQuitButton)
			f41_arg0.QuitButton:completeAnimation()
			f41_arg0.QuitButton:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.QuitButton)
			f41_arg0.XpMeter:completeAnimation()
			f41_arg0.XpMeter:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.XpMeter)
		end,
	},
}
CoD.StartMenu_ChangeSpecialist.__onClose = function(f42_arg0)
	f42_arg0.__on_close_removeOverrides()
	f42_arg0.SignatureAbility:close()
	f42_arg0.SignatureEquipment:close()
	f42_arg0.Characters:close()
	f42_arg0.DraftCooldown:close()
	f42_arg0.ChangeClassButton:close()
	f42_arg0.ChangeClassButtonPC:close()
	f42_arg0.ArenaQuitButton:close()
	f42_arg0.QuitButton:close()
	f42_arg0.SelectedClassMiniPreview:close()
	f42_arg0.XpMeter:close()
	f42_arg0.PCKoreaContentDescriptorsIcons:close()
	f42_arg0.RestrictedText:close()
end
