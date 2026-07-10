require("x64:31a96cffe9fd2d")
CoD.WeaponPersonalizeSlotContainer = InheritFrom(LUI.UIElement)
CoD.WeaponPersonalizeSlotContainer.__defaultWidth = 130
CoD.WeaponPersonalizeSlotContainer.__defaultHeight = 268
CoD.WeaponPersonalizeSlotContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPersonalizeSlotContainer)
	self.id = "WeaponPersonalizeSlotContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local DeathFxButton = CoD.WeaponPersonalizeSlot.new(f1_arg0, f1_arg1, 0, 0, 0, 115, 0, 0, 153, 268)
	DeathFxButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.WeaponOptionsUtility.CanEquipDeathFxForWeapon(f1_arg1)
			end,
		},
	})
	DeathFxButton.ButtonName:setText(LocalizeToUpperString(0xD527320A0F9B5A))
	DeathFxButton:subscribeToGlobalModel(f1_arg1, "LoadoutBreadcrumbs", "deathfx", function(model)
		DeathFxButton.newIcon:setModel(model, f1_arg1)
	end)
	DeathFxButton.WeaponPersonalizationItem.ItemImage.__Icon = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			DeathFxButton.WeaponPersonalizationItem.ItemImage:setImage(RegisterImage(CoD.WeaponOptionsUtility.GetWeaponDeathFxIconForItemIndex(f4_local0)))
		end
	end
	DeathFxButton:linkToElementModel(self, "equippedDeathFxIndex", true, DeathFxButton.WeaponPersonalizationItem.ItemImage.__Icon)
	DeathFxButton.WeaponPersonalizationItem.ItemImage.__Icon_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.equippedDeathFxIndex
		end
		if f5_local0 then
			DeathFxButton.WeaponPersonalizationItem.ItemImage.__Icon(f5_local0)
		end
	end
	DeathFxButton:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end)
	local f1_local2 = DeathFxButton
	local AccessoriesButton = DeathFxButton.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	AccessoriesButton(f1_local2, f1_local4.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end, false)
	DeathFxButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DeathFxButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.CACUtility.OpenCACOverlay(self, menu, controller, "WeaponDeathFxSelect", element, "")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeathFxButton, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsDeathFxEquippedForWeapon(menu, controller) and IsGamepad(controller) then
			CoD.WeaponOptionsUtility.ClearDeathFx(menu, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsDeathFxEquippedForWeapon(menu, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeathFxButton, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "ui_remove", function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsDeathFxEquippedForWeapon(menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.WeaponOptionsUtility.ClearDeathFx(menu, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsDeathFxEquippedForWeapon(menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	DeathFxButton:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		if CoD.WeaponOptionsUtility.IsDeathFxEquippedForWeapon(f15_arg1, f15_arg2) then
			return function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
				CoD.WeaponOptionsUtility.ClearDeathFx(f16_arg1, f16_arg2)
				UpdateAllMenuButtonPrompts(f16_arg1, f16_arg2)
			end
		else
		end
	end)
	self:addElement(DeathFxButton)
	self.DeathFxButton = DeathFxButton
	AccessoriesButton = CoD.WeaponPersonalizeSlot.new(f1_arg0, f1_arg1, 0, 0, 0, 115, 0, 0, 0, 115)
	AccessoriesButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.WeaponOptionsUtility.CanEquipCharmForWeapon(f1_arg1)
			end,
		},
	})
	AccessoriesButton.ButtonName:setText(LocalizeToUpperString(0xFA6E6FE616EF67))
	AccessoriesButton:subscribeToGlobalModel(f1_arg1, "LoadoutBreadcrumbs", "accessory", function(model)
		AccessoriesButton.newIcon:setModel(model, f1_arg1)
	end)
	AccessoriesButton.WeaponPersonalizationItem.ItemImage.__Icon = function(f19_arg0)
		local f19_local0 = f19_arg0:get()
		if f19_local0 ~= nil then
			AccessoriesButton.WeaponPersonalizationItem.ItemImage:setImage(RegisterImage(CoD.WeaponOptionsUtility.GetWeaponAccessoryIconForItemIndex(f1_arg0, f1_arg1, f19_local0)))
		end
	end
	AccessoriesButton:linkToElementModel(self, "equippedAccessoryIndex", true, AccessoriesButton.WeaponPersonalizationItem.ItemImage.__Icon)
	AccessoriesButton.WeaponPersonalizationItem.ItemImage.__Icon_FullPath = function()
		local f20_local0 = self:getModel()
		if f20_local0 then
			f20_local0 = self:getModel()
			f20_local0 = f20_local0.equippedAccessoryIndex
		end
		if f20_local0 then
			AccessoriesButton.WeaponPersonalizationItem.ItemImage.__Icon(f20_local0)
		end
	end
	AccessoriesButton:appendEventHandler("input_source_changed", function(f21_arg0, f21_arg1)
		f21_arg1.menu = f21_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f21_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f21_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end)
	f1_local4 = AccessoriesButton
	f1_local2 = AccessoriesButton.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local2(f1_local4, f1_local5.LastInput, function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end, false)
	AccessoriesButton:registerEventHandler("gain_focus", function(element, event)
		local f23_local0 = nil
		if element.gainFocus then
			f23_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f23_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		return f23_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AccessoriesButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.CACUtility.OpenCACOverlay(self, menu, controller, "WeaponAccessoriesSelect", element, "")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(AccessoriesButton, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsCharmEquippedForWeapon(menu, controller) and IsGamepad(controller) then
			CoD.WeaponOptionsUtility.ClearWeaponAccessory(menu, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsCharmEquippedForWeapon(menu, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(AccessoriesButton, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "ui_remove", function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsCharmEquippedForWeapon(menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.WeaponOptionsUtility.ClearWeaponAccessory(menu, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsCharmEquippedForWeapon(menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	AccessoriesButton:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
		if CoD.WeaponOptionsUtility.IsCharmEquippedForWeapon(f30_arg1, f30_arg2) then
			return function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
				CoD.WeaponOptionsUtility.ClearWeaponAccessory(f31_arg1, f31_arg2)
				UpdateAllMenuButtonPrompts(f31_arg1, f31_arg2)
			end
		else
		end
	end)
	self:addElement(AccessoriesButton)
	self.AccessoriesButton = AccessoriesButton
	f1_local4 = DeathFxButton
	f1_local2 = DeathFxButton.subscribeToModel
	f1_local5 = DataSources.WeaponPersonalization.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.equippedDeathFxIndex, DeathFxButton.WeaponPersonalizationItem.ItemImage.__Icon_FullPath)
	f1_local4 = AccessoriesButton
	f1_local2 = AccessoriesButton.subscribeToModel
	f1_local5 = DataSources.WeaponPersonalization.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.equippedAccessoryIndex, AccessoriesButton.WeaponPersonalizationItem.ItemImage.__Icon_FullPath)
	DeathFxButton.id = "DeathFxButton"
	AccessoriesButton.id = "AccessoriesButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local2 = self
	f1_local2 = DeathFxButton
	if IsPC() then
		CoD.BaseUtility.SetElementModelFromPropertyModel(f1_arg1, f1_arg0, f1_local2)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local2, f1_arg1, "name", "", "")
	else
		CoD.BaseUtility.SetElementModelFromPropertyModel(f1_arg1, f1_arg0, f1_local2)
	end
	f1_local2 = AccessoriesButton
	if IsPC() then
		CoD.BaseUtility.SetElementModelFromPropertyModel(f1_arg1, f1_arg0, f1_local2)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local2, f1_arg1, "name", "", "")
	else
		CoD.BaseUtility.SetElementModelFromPropertyModel(f1_arg1, f1_arg0, f1_local2)
	end
	return self
end
CoD.WeaponPersonalizeSlotContainer.__onClose = function(f32_arg0)
	f32_arg0.DeathFxButton:close()
	f32_arg0.AccessoriesButton:close()
end
