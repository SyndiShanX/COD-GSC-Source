require("x64:dbbe35720247c09")
require("x64:a4c60719b1e8805")
CoD.TechnicalOptionGrid = InheritFrom(LUI.UIElement)
CoD.TechnicalOptionGrid.__defaultWidth = 272
CoD.TechnicalOptionGrid.__defaultHeight = 350
CoD.TechnicalOptionGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TechnicalOptionGrid)
	self.id = "TechnicalOptionGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TechnicalGrid = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	TechnicalGrid:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, f1_arg1, "camoIndex")
			end,
		},
	})
	TechnicalGrid:setLeftRight(0.5, 0.5, -115, 115)
	TechnicalGrid:setTopBottom(0, 0, 40, 300)
	TechnicalGrid:setWidgetType(CoD.CamoSlot)
	TechnicalGrid:setHorizontalCount(2)
	TechnicalGrid:setVerticalCount(3)
	TechnicalGrid:setSpacing(10)
	TechnicalGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TechnicalGrid:setDataSource("WeaponOptions")
	TechnicalGrid:linkToElementModel(TechnicalGrid, "itemIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	TechnicalGrid:linkToElementModel(TechnicalGrid, "unlockSessionMode", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	TechnicalGrid:linkToElementModel(TechnicalGrid, "unlockProgressAndTarget", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local BottomBracket9Slice = TechnicalGrid
	local Label = TechnicalGrid.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Label(BottomBracket9Slice, f1_local4.paintCanCount, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	TechnicalGrid:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end)
	BottomBracket9Slice = TechnicalGrid
	Label = TechnicalGrid.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Label(BottomBracket9Slice, f1_local4.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end, false)
	TechnicalGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
		CoD.CraftUtility.PreviewWeaponCamo(self, element, f1_arg1, f1_arg0)
		return f9_local0
	end)
	TechnicalGrid:registerEventHandler("lose_list_focus", function(element, event)
		local f10_local0 = nil
		CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_arg0, f1_arg1)
		CoD.WeaponOptionsUtility.ClearWeaponOptionInfoModel(f1_arg0, f1_arg1, element)
		return f10_local0
	end)
	TechnicalGrid:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(TechnicalGrid, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "unlockSessionMode", Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]) and CoD.WeaponOptionsUtility.CanPurchasePaintCanCamo(element, controller) then
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
		if CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "unlockSessionMode", Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]) and CoD.WeaponOptionsUtility.CanPurchasePaintCanCamo(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x867BE59364DD53B, nil, nil)
			return true
		elseif CoD.WeaponOptionsUtility.CanEquipWeaponOption(menu, element, controller) and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(TechnicalGrid, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(TechnicalGrid, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "ui_remove", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(TechnicalGrid, "updateDataSource", function(element, controller, f18_arg2, f18_arg3)
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "TechnicalGrid") then
			CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
			CoD.CraftUtility.PreviewWeaponCamo(self, element, f1_arg1, f1_arg0)
		end
	end)
	TechnicalGrid:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(TechnicalGrid, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	TechnicalGrid:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
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
	self:addElement(TechnicalGrid)
	self.TechnicalGrid = TechnicalGrid
	Label = LUI.UIText.new(0, 0, 9, 239, 0, 0, 11, 27)
	Label:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Label:setText(LocalizeToUpperString(0x9636BD50CD0DC6C))
	Label:setTTF("default")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Label)
	self.Label = Label
	BottomBracket9Slice = LUI.UIImage.new(0, 1, 9, -9, 0, 0, 28, 37)
	BottomBracket9Slice:setAlpha(0.5)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	TechnicalGrid.id = "TechnicalGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	f1_local4 = TechnicalGrid
	if IsPC() then
		SetElementProperty(f1_local4, "_category", "tech")
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local4, f1_arg1, "name", "", "")
	else
		SetElementProperty(f1_local4, "_category", "tech")
	end
	return self
end
CoD.TechnicalOptionGrid.__onClose = function(f22_arg0)
	f22_arg0.TechnicalGrid:close()
end
