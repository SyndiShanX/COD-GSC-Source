require("x64:dbbe35720247c09")
require("x64:a4c60719b1e8805")
CoD.PerformanceOptionGrid = InheritFrom(LUI.UIElement)
CoD.PerformanceOptionGrid.__defaultWidth = 392
CoD.PerformanceOptionGrid.__defaultHeight = 350
CoD.PerformanceOptionGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PerformanceOptionGrid)
	self.id = "PerformanceOptionGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PerformanceGrid = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	PerformanceGrid:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, f1_arg1, "camoIndex")
			end,
		},
	})
	PerformanceGrid:setLeftRight(0, 0, 21, 371)
	PerformanceGrid:setTopBottom(0, 0, 40, 300)
	PerformanceGrid:setWidgetType(CoD.CamoSlot)
	PerformanceGrid:setHorizontalCount(3)
	PerformanceGrid:setVerticalCount(3)
	PerformanceGrid:setSpacing(10)
	PerformanceGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PerformanceGrid:setDataSource("WeaponOptions")
	PerformanceGrid:linkToElementModel(PerformanceGrid, "itemIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	PerformanceGrid:linkToElementModel(PerformanceGrid, "unlockSessionMode", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	PerformanceGrid:linkToElementModel(PerformanceGrid, "unlockProgressAndTarget", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local BottomBracket9Slice = PerformanceGrid
	local Label = PerformanceGrid.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	Label(BottomBracket9Slice, f1_local4.paintCanCount, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PerformanceGrid:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	BottomBracket9Slice = PerformanceGrid
	Label = PerformanceGrid.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	Label(BottomBracket9Slice, f1_local4.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	PerformanceGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
		CoD.CraftUtility.PreviewWeaponCamo(self, element, f1_arg1, f1_arg0)
		return f9_local0
	end)
	PerformanceGrid:registerEventHandler("lose_list_focus", function(element, event)
		local f10_local0 = nil
		CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_arg0, f1_arg1)
		CoD.WeaponOptionsUtility.ClearWeaponOptionInfoModel(f1_arg0, f1_arg1, element)
		return f10_local0
	end)
	PerformanceGrid:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PerformanceGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "unlockSessionMode", Enum[@"emodes"][@"mode_warzone"]) and CoD.WeaponOptionsUtility.CanPurchasePaintCanCamo(element, controller) then
			OpenPopup(self, "WZPurchaseCamo", controller, {
				_model = element:getModel(),
			})
			return true
		elseif CoD.WeaponOptionsUtility.CanEquipWeaponOption(menu, element, controller) and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			PlaySoundAlias("cac_equipment_add")
			CoD.WeaponOptionsUtility.SetWeaponOptionClassItemHelper(self, element, controller, menu)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "unlockSessionMode", Enum[@"emodes"][@"mode_warzone"]) and CoD.WeaponOptionsUtility.CanPurchasePaintCanCamo(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/redeem", nil, nil)
			return true
		elseif CoD.WeaponOptionsUtility.CanEquipWeaponOption(menu, element, controller) and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(PerformanceGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and IsGamepad(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(PerformanceGrid, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "ui_remove", function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(PerformanceGrid, "updateDataSource", function(element, controller, f18_arg2, f18_arg3)
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "PerformanceGrid") then
			CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
			CoD.CraftUtility.PreviewWeaponCamo(self, element, f1_arg1, f1_arg0)
		end
	end)
	PerformanceGrid:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(PerformanceGrid, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	PerformanceGrid:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/remove", function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(f20_arg1, f20_arg0, f20_arg2, "camoIndex") then
			return function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
				PlaySoundAlias("cac_equipment_remove")
				CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, f21_arg0, f21_arg1, f21_arg2)
				UpdateSelfState(self, f21_arg2)
				UpdateAllMenuButtonPrompts(f21_arg1, f21_arg2)
			end
		else
		end
	end)
	self:addElement(PerformanceGrid)
	self.PerformanceGrid = PerformanceGrid
	Label = LUI.UIText.new(0, 0, 9, 349, 0, 0, 11, 27)
	Label:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Label:setText(LocalizeToUpperString(@"hash_E28A07E0C69E9E9"))
	Label:setTTF("default")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Label)
	self.Label = Label
	BottomBracket9Slice = LUI.UIImage.new(0, 1, 9, -9, 0, 0, 28, 37)
	BottomBracket9Slice:setAlpha(0.5)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	PerformanceGrid.id = "PerformanceGrid"
	self.__defaultFocus = PerformanceGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	f1_local4 = PerformanceGrid
	if IsPC() then
		SetElementProperty(f1_local4, "_category", "perf")
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local4, f1_arg1, "name", "", "")
	else
		SetElementProperty(f1_local4, "_category", "perf")
	end
	return self
end
CoD.PerformanceOptionGrid.__onClose = function(f22_arg0)
	f22_arg0.PerformanceGrid:close()
end
