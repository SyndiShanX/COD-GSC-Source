require("x64:aa18a2396b77054")
require("x64:ca1dc89b2aa714c")
require("x64:b1b346e32476a2e")
CoD.ActiveCamoGrid = InheritFrom(LUI.UIElement)
CoD.ActiveCamoGrid.__defaultWidth = 1254
CoD.ActiveCamoGrid.__defaultHeight = 350
CoD.ActiveCamoGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ActiveCamoGrid)
	self.id = "ActiveCamoGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BottomBracket9Slice = LUI.UIImage.new(0, 0, 0, 1254, 0, 0, 28, 37)
	BottomBracket9Slice:setAlpha(0.5)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local Label = LUI.UIText.new(0, 0, 0, 316, 0, 0, 11, 27)
	Label:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Label:setText(LocalizeToUpperString(@"hash_57A8BC9CB373E4C6"))
	Label:setTTF("default")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Label)
	self.Label = Label
	local ActiveCamoList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	ActiveCamoList:mergeStateConditions({
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsWeaponCamoNew(menu, element, f1_arg1)
			end,
		},
	})
	ActiveCamoList:setLeftRight(0, 0, 12, 1242)
	ActiveCamoList:setTopBottom(0, 0, 40, 300)
	ActiveCamoList:setWidgetType(CoD.ActiveThemeSlot)
	ActiveCamoList:setHorizontalCount(10)
	ActiveCamoList:setSpacing(10)
	ActiveCamoList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ActiveCamoList:setHorizontalScrollbar(CoD.PC_GridHorizontalScrollbar)
	ActiveCamoList:setHorizontalCounter(CoD.horizontalCounter)
	ActiveCamoList:setDataSource("WeaponOptions")
	ActiveCamoList:linkToElementModel(ActiveCamoList, "itemIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	ActiveCamoList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local f1_local4 = ActiveCamoList
	local CamosWillAppearHereText = ActiveCamoList.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	CamosWillAppearHereText(f1_local4, f1_local6.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	ActiveCamoList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
		CoD.CraftUtility.PreviewWeaponCamo(self, element, f1_arg1, f1_arg0)
		return f6_local0
	end)
	ActiveCamoList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f7_local0 = nil
		if IsElementInState(element, "New") then
			CoD.BreadcrumbUtility.SetWeaponCamoOld(f1_arg0, element, f1_arg1)
			CoD.BreadcrumbUtility.UpdateWeaponCamoBreadcrumbs(f1_arg0, f1_arg1)
			CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_arg0, f1_arg1)
			CoD.WeaponOptionsUtility.ClearWeaponOptionInfoModel(f1_arg0, f1_arg1, element)
		else
			CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_arg0, f1_arg1)
			CoD.WeaponOptionsUtility.ClearWeaponOptionInfoModel(f1_arg0, f1_arg1, element)
		end
		return f7_local0
	end)
	ActiveCamoList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ActiveCamoList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if ShouldDisplayContextualMenuInActiveCamoList(controller, element) and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) then
			PlaySoundAlias("cac_equipment_add")
			CoD.WeaponOptionsUtility.SetWeaponOptionClassItemHelper(self, element, controller, menu)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif ShouldDisplayContextualMenuInActiveCamoList(controller, element) and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) then
			PlaySoundAlias("cac_equipment_add")
			CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if ShouldDisplayContextualMenuInActiveCamoList(controller, element) and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif ShouldDisplayContextualMenuInActiveCamoList(controller, element) and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ActiveCamoList, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ActiveCamoList, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ActiveCamoList, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and not CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrappedOrLocked(menu, element, controller) then
			CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(menu, controller, "CamoPersonalizationDetails", element, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and not CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrappedOrLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"menu/details", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ActiveCamoList, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_contextual_1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and not CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(menu, element, controller) then
			CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(menu, controller, "CamoPersonalizationDetails", element, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and ShouldDisplayContextualMenuInActiveCamoList(controller, element) and not CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/details", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ActiveCamoList, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MWHEELUP", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollLeft(self.ActiveCamoList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.ActiveCamoList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELUP")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(ActiveCamoList, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MWHEELDOWN", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollRight(self.ActiveCamoList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.ActiveCamoList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELDOWN")
		return false
	end, false)
	ActiveCamoList:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(ActiveCamoList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	ActiveCamoList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/remove", function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
		if ShouldDisplayContextualMenuInActiveCamoList(f24_arg2, f24_arg0) and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(f24_arg1, f24_arg0, f24_arg2, "camoIndex") then
			return function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
				PlaySoundAlias("cac_equipment_remove")
				CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, f25_arg0, f25_arg1, f25_arg2)
				UpdateSelfState(self, f25_arg2)
				UpdateAllMenuButtonPrompts(f25_arg1, f25_arg2)
			end
		else
		end
	end)
	ActiveCamoList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/details", function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
		if IsPC() and ShouldDisplayContextualMenuInActiveCamoList(f26_arg2, f26_arg0) and not CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(f26_arg1, f26_arg0, f26_arg2) then
			return function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
				CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(f27_arg1, f27_arg2, "CamoPersonalizationDetails", f27_arg0, false)
			end
		else
		end
	end)
	self:addElement(ActiveCamoList)
	self.ActiveCamoList = ActiveCamoList
	CamosWillAppearHereText = LUI.UIText.new(0, 0, 12, 1242, 0, 0, 150, 180)
	CamosWillAppearHereText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_79B15B2A5E21491C"))
	CamosWillAppearHereText:setTTF("dinnext_regular")
	CamosWillAppearHereText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CamosWillAppearHereText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CamosWillAppearHereText)
	self.CamosWillAppearHereText = CamosWillAppearHereText
	self:mergeStateConditions({
		{
			stateName = "ListEmpty",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.ActiveCamoList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f29_arg1)
	end)
	ActiveCamoList.id = "ActiveCamoList"
	self.__defaultFocus = ActiveCamoList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	if IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalCounter(f1_arg0, self.ActiveCamoList)
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	elseif not IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalScrollbar(f1_arg0, self.ActiveCamoList)
	end
	f1_local4 = ActiveCamoList
	if IsPC() then
		CoD.WeaponOptionsUtility.SetReactiveCamoCateogry(f1_arg0, f1_local4)
		UpdateSelfState(self, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local4, f1_arg1, "name", "", "")
	else
		CoD.WeaponOptionsUtility.SetReactiveCamoCateogry(f1_arg0, f1_local4)
		UpdateSelfState(self, f1_arg1)
	end
	return self
end
CoD.ActiveCamoGrid.__resetProperties = function(f30_arg0)
	f30_arg0.CamosWillAppearHereText:completeAnimation()
	f30_arg0.CamosWillAppearHereText:setAlpha(1)
end
CoD.ActiveCamoGrid.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.CamosWillAppearHereText:completeAnimation()
			f31_arg0.CamosWillAppearHereText:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.CamosWillAppearHereText)
		end,
	},
	ListEmpty = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ActiveCamoGrid.__onClose = function(f33_arg0)
	f33_arg0.ActiveCamoList:close()
end
