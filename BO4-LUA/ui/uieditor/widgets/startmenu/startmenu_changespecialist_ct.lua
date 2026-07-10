require("x64:b64d9dfa5911bd2")
require("x64:753cb15c89114c6")
require("x64:2190adaba331dcb")
CoD.StartMenu_ChangeSpecialist_CT = InheritFrom(LUI.UIElement)
CoD.StartMenu_ChangeSpecialist_CT.__defaultWidth = 1725
CoD.StartMenu_ChangeSpecialist_CT.__defaultHeight = 780
CoD.StartMenu_ChangeSpecialist_CT.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if IsInGame() then
		CoD.PlayerRoleUtility.SetPositionDraftSelectedCharacterIndex(f1_arg1)
	end
	self:setClass(CoD.StartMenu_ChangeSpecialist_CT)
	self.id = "StartMenu_ChangeSpecialist_CT"
	self.soundSet = "MultiplayerMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local specialistRespawnDesc = LUI.UIText.new(0.5, 0.5, -281.5, 281.5, 0.5, 0.5, -246, -213)
	specialistRespawnDesc:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	specialistRespawnDesc:setZoom(10)
	specialistRespawnDesc:setText(LocalizeToUpperString(@"menu/specialist"))
	specialistRespawnDesc:setTTF("ttmussels_demibold")
	specialistRespawnDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	specialistRespawnDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
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
	local SignatureAbility = Engine[@"getmodelforcontroller"](f1_arg1)
	DraftCooldown(f1_local3, SignatureAbility["PositionEditLoadout.SelectedCharacterIndex"], function(f3_arg0)
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
	SignatureAbility = Engine[@"getglobalmodel"]()
	DraftCooldown(f1_local3, SignatureAbility["hudItems.specialistSwitchIsLethal"], function(f8_arg0)
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
	SignatureAbility = Engine[@"getmodelforcontroller"](f1_arg1)
	DraftCooldown(f1_local3, SignatureAbility["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f9_arg0)
		f1_arg0:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	Characters:setLeftRight(0.5, 0.5, -268, -100)
	Characters:setTopBottom(0.5, 0.5, -141, 14)
	Characters:setScale(2, 2)
	Characters:setWidgetType(CoD.PositionDraft_Character)
	Characters:setBalanceGridRows(true)
	Characters:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Characters:setDataSource("PositionDraftCharacters")
	Characters:registerEventHandler("lose_list_focus", function(element, event)
		local f10_local0 = nil
		CoD.GridAndListUtility.UpdateDataSource(self.Characters, false, false, false)
		return f10_local0
	end)
	self:addElement(Characters)
	self.Characters = Characters
	DraftCooldown = CoD.PositionDraft_Cooldown.new(f1_arg0, f1_arg1, 0.5, 0.5, -862.5, 862.5, 0.5, 0.5, -369.5, -332.5)
	DraftCooldown:setZoom(10)
	self:addElement(DraftCooldown)
	self.DraftCooldown = DraftCooldown
	f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.QuitButton = f1_local3
	SignatureAbility = CoD.StartMenu_SignatureItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -13, 527, 0.5, 0.5, -45.5, 69.5)
	SignatureAbility:setScale(0.8, 0.8)
	self:addElement(SignatureAbility)
	self.SignatureAbility = SignatureAbility
	local SignatureEquipment = CoD.StartMenu_SignatureItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -13, 527, 0.5, 0.5, -160.5, -45.5)
	SignatureEquipment:setScale(0.8, 0.8)
	self:addElement(SignatureEquipment)
	self.SignatureEquipment = SignatureEquipment
	SignatureAbility:linkToElementModel(Characters, "equipment", false, function(model)
		SignatureAbility:setModel(model, f1_arg1)
	end)
	SignatureEquipment:linkToElementModel(Characters, "ability", false, function(model)
		SignatureEquipment:setModel(model, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f13_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_2DDDF8559F5B304D") and CoD.ModelUtility.IsScriptNotifyDataArgEqualTo(model, 1, 1) then
			CoD.ModelUtility.SetScriptNotifyDataArg(model, 1, 0)
			StartMenuGoBack(f1_arg0, f1_arg1)
		end
	end)
	Characters.id = "Characters"
	f1_local3:appendEventHandler("menu_loaded", function()
		f1_local3:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	f1_local3.id = "QuitButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	if IsPC() and IsMouseOrKeyboard(f1_arg1) then
		CoD.PCUtility.SetListOrGridAsAcceptingFocusToActiveElement(self.Characters)
	end
	f1_local7 = Characters
	if IsPC() then
		SetElementPropertyEnum(f1_local7, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT)
	else
		SetElementPropertyEnum(f1_local7, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT)
	end
	return self
end
CoD.StartMenu_ChangeSpecialist_CT.__onClose = function(f15_arg0)
	f15_arg0.SignatureAbility:close()
	f15_arg0.SignatureEquipment:close()
	f15_arg0.Characters:close()
	f15_arg0.DraftCooldown:close()
	f15_arg0.QuitButton:close()
end
