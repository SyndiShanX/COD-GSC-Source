require("x64:4b67b3d78299a63")
require("x64:ef912f3f903134c")
require("x64:c3fa19037d61cad")
CoD.WZPersonalizeCharacter_CustomCharacterFrameWidget = InheritFrom(LUI.UIElement)
CoD.WZPersonalizeCharacter_CustomCharacterFrameWidget.__defaultWidth = 906
CoD.WZPersonalizeCharacter_CustomCharacterFrameWidget.__defaultHeight = 800
CoD.WZPersonalizeCharacter_CustomCharacterFrameWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZPersonalizeCharacter_CustomCharacterFrameWidget)
	self.id = "WZPersonalizeCharacter_CustomCharacterFrameWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Characters = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	Characters:setLeftRight(0, 0, 304, 760)
	Characters:setTopBottom(0, 0, -0.5, 864.5)
	Characters:setWidgetType(CoD.HubSpecialist_character)
	Characters:setHorizontalCount(3)
	Characters:setVerticalCount(5)
	Characters:setSpacing(0)
	Characters:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Characters:linkToElementModel(self, "characterDatasource", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Characters:setDataSource(f2_local0)
		end
	end)
	Characters:linkToElementModel(Characters, "disabled", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Characters:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		SetControllerModelValue(f1_arg1, "WZCharacterInfo.infoModel", element:getModel())
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.SHOW)
		return f4_local0
	end)
	Characters:registerEventHandler("list_item_lose_focus", function(element, event)
		local f5_local0 = nil
		if not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "CustomCharacter") and not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Characters") then
			PositionDraftOnFocusCharacterLost(self, element, f1_arg1, false)
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
		end
		return f5_local0
	end)
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() then
			OpenOverlay(self, "WZPersonalizeCharacterInspect", controller, {
				model = element:getModel(),
				properties = {
					_sessionMode = Enum[@"emodes"][@"mode_warzone"],
					_storageLoadoutBuffer = menu._storageLoadoutBuffer,
				},
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Characters)
	self.Characters = Characters
	local CustomCharacter = CoD.CharacterSelection_CustomCharacterButton.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 0, 0, 32, 512)
	CustomCharacter:mergeStateConditions({
		{
			stateName = "NoPersonalize",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	CustomCharacter:subscribeToGlobalModel(f1_arg1, "WZDefaultCharacterInfo", nil, function(model)
		CustomCharacter:setModel(model, f1_arg1)
	end)
	CustomCharacter:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CustomCharacter, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		OpenOverlay(self, "WZPersonalizeCharacterInspect", controller, {
			model = element:getModel(),
			properties = {
				_sessionMode = Enum[@"emodes"][@"mode_warzone"],
				_storageLoadoutBuffer = menu._storageLoadoutBuffer,
			},
		})
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(CustomCharacter, "childFocusGained", function(element)
		SetControllerModelValue(f1_arg1, "WZCharacterInfo.infoModel", element:getModel())
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.SHOW)
	end)
	LUI.OverrideFunction_CallOriginalFirst(CustomCharacter, "childFocusLost", function(element)
		if not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Characters") then
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
		end
	end)
	self:addElement(CustomCharacter)
	self.CustomCharacter = CustomCharacter
	Characters.id = "Characters"
	CustomCharacter.id = "CustomCharacter"
	self.__defaultFocus = CustomCharacter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	if CoD.WZUtility.IsCurrentCharacterDefault(f1_arg1) then
		ChangeDefaultFocus(self, self.CustomCharacter)
		SetElementProperty(f1_local3, "_leftMostElement", self.CustomCharacter.CharacterSelectionCustomCharacterButtonInternal.CommonButtonOutline)
	else
		SetElementProperty(f1_local3, "_leftMostElement", self.CustomCharacter.CharacterSelectionCustomCharacterButtonInternal.CommonButtonOutline)
	end
	return self
end
CoD.WZPersonalizeCharacter_CustomCharacterFrameWidget.__onClose = function(f16_arg0)
	f16_arg0.Characters:close()
	f16_arg0.CustomCharacter:close()
end
