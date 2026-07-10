require("x64:aa18a2396b77054")
CoD.ActiveThemeGrid = InheritFrom(LUI.UIElement)
CoD.ActiveThemeGrid.__defaultWidth = 150
CoD.ActiveThemeGrid.__defaultHeight = 350
CoD.ActiveThemeGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ActiveThemeGrid)
	self.id = "ActiveThemeGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local BottomBracket9Slice = LUI.UIImage.new(0, 1, 9, -9, 0, 0, 28, 37)
	BottomBracket9Slice:setAlpha(0.5)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local MasteryGrid = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	MasteryGrid:setLeftRight(0.5, 0.5, -57, 57)
	MasteryGrid:setTopBottom(0, 0, 37, 297)
	MasteryGrid:setWidgetType(CoD.ActiveThemeSlot)
	MasteryGrid:setSpacing(10)
	MasteryGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MasteryGrid:setDataSource("WeaponOptions")
	MasteryGrid:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	local f1_local3 = MasteryGrid
	local Label = MasteryGrid.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Label(f1_local3, f1_local5.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	MasteryGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
		CoD.CraftUtility.PreviewWeaponCamo(self, element, f1_arg1, f1_arg0)
		return f4_local0
	end)
	MasteryGrid:registerEventHandler("list_item_lose_focus", function(element, event)
		local f5_local0 = nil
		CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_arg0, f1_arg1)
		return f5_local0
	end)
	MasteryGrid:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			PlaySoundAlias("cac_equipment_add")
			CoD.WeaponOptionsUtility.SetWeaponOptionClassItemHelper(self, element, controller, menu)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	MasteryGrid:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(MasteryGrid, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	MasteryGrid:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(f14_arg1, f14_arg0, f14_arg2, "camoIndex") then
			return function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
				PlaySoundAlias("cac_equipment_remove")
				CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, f15_arg0, f15_arg1, f15_arg2)
				UpdateSelfState(self, f15_arg2)
				UpdateAllMenuButtonPrompts(f15_arg1, f15_arg2)
			end
		else
		end
	end)
	self:addElement(MasteryGrid)
	self.MasteryGrid = MasteryGrid
	Label = LUI.UIText.new(0, 0, 9, 171, 0, 0, 11, 27)
	Label:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Label:setText(LocalizeToUpperString(0x7A8BC9CB373E4C6))
	Label:setTTF("default")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Label)
	self.Label = Label
	MasteryGrid.id = "MasteryGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = MasteryGrid
	SetElementProperty(f1_local3, "_category", "activeTheme")
	UpdateSelfState(self, f1_arg1)
	CoD.PCWidgetUtility.SetupContextualMenu(f1_local3, f1_arg1, "name", "", "")
	return self
end
CoD.ActiveThemeGrid.__onClose = function(f16_arg0)
	f16_arg0.MasteryGrid:close()
end
