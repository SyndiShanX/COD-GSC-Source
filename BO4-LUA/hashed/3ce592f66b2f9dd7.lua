require("x64:128cefcb7517aee")
CoD.ThemeOptionGrid = InheritFrom(LUI.UIElement)
CoD.ThemeOptionGrid.__defaultWidth = 1239
CoD.ThemeOptionGrid.__defaultHeight = 350
CoD.ThemeOptionGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ThemeOptionGrid)
	self.id = "ThemeOptionGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Label = LUI.UIText.new(0, 0, 0, 162, 0, 0, 11, 27)
	Label:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Label:setText(LocalizeToUpperString(0x81782ED786B4A3))
	Label:setTTF("default")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Label)
	self.Label = Label
	local BottomBracket9Slice = LUI.UIImage.new(0, 0, 0, 1239, 0, 0, 28, 37)
	BottomBracket9Slice:setAlpha(0.5)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local MasteryGrid = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	MasteryGrid:setLeftRight(0, 0, 12, 1227)
	MasteryGrid:setTopBottom(0, 0, 40, 300)
	MasteryGrid:setWidgetType(CoD.ThemeSlot)
	MasteryGrid:setHorizontalCount(7)
	MasteryGrid:setSpacing(10)
	MasteryGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MasteryGrid:setDataSource("WeaponOptions")
	MasteryGrid:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	local f1_local4 = MasteryGrid
	local CamosWillAppearHereText = MasteryGrid.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	CamosWillAppearHereText(f1_local4, f1_local6.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	MasteryGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
		CoD.WeaponOptionsUtility.PreviewSignatureWeaponTheme(element, f1_arg0, f1_arg1)
		return f4_local0
	end)
	MasteryGrid:registerEventHandler("list_item_lose_focus", function(element, event)
		local f5_local0 = nil
		CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_arg0, f1_arg1)
		CoD.WeaponOptionsUtility.ClearWeaponOptionInfoModel(f1_arg0, f1_arg1, element)
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
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, element, controller) and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			PlaySoundAlias("cac_equipment_add")
			CoD.WeaponOptionsUtility.SetSignatureWeaponThemeHelper(self, element, controller, menu)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			PlaySoundAlias("cac_equipment_add")
			CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, element, controller) and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and IsGamepad(controller) then
			PlaySoundAlias("cac_equipment_add")
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
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "ui_remove", function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "camoIndex") and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("cac_equipment_add")
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
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, element, controller) and IsGamepad(controller) then
			CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(menu, controller, "CamoPersonalizationDetails", element, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, element, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0xB1A784560EDFEA7, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(MasteryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(menu, controller, "CamoPersonalizationDetails", element, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0xB1A784560EDFEA7, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	MasteryGrid:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(MasteryGrid, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	MasteryGrid:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
		if CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(f18_arg1, f18_arg0, f18_arg2, "camoIndex") then
			return function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
				PlaySoundAlias("cac_equipment_add")
				CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper(self, f19_arg0, f19_arg1, f19_arg2)
				UpdateSelfState(self, f19_arg2)
				UpdateAllMenuButtonPrompts(f19_arg1, f19_arg2)
			end
		else
		end
	end)
	MasteryGrid:AddContextualMenuAction(f1_arg0, f1_arg1, 0xB1A784560EDFEA7, function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
		if CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(f20_arg1, f20_arg0, f20_arg2) then
			return function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
				CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(f21_arg1, f21_arg2, "CamoPersonalizationDetails", f21_arg0, false)
			end
		else
		end
	end)
	self:addElement(MasteryGrid)
	self.MasteryGrid = MasteryGrid
	CamosWillAppearHereText = LUI.UIText.new(0, 0, 12, 1242, 0, 0, 150, 180)
	CamosWillAppearHereText:setText(Engine[0xF9F1239CFD921FE](0xD6E6182D71F2921))
	CamosWillAppearHereText:setTTF("dinnext_regular")
	CamosWillAppearHereText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CamosWillAppearHereText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CamosWillAppearHereText)
	self.CamosWillAppearHereText = CamosWillAppearHereText
	self:mergeStateConditions({
		{
			stateName = "ListEmpty",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.MasteryGrid)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f23_arg1)
	end)
	MasteryGrid.id = "MasteryGrid"
	self.__defaultFocus = MasteryGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	f1_local4 = MasteryGrid
	if IsPC() then
		SetElementProperty(f1_local4, "_category", "theme")
		UpdateSelfState(self, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local4, f1_arg1, "name", "", "")
	else
		SetElementProperty(f1_local4, "_category", "theme")
		UpdateSelfState(self, f1_arg1)
	end
	return self
end
CoD.ThemeOptionGrid.__resetProperties = function(f24_arg0)
	f24_arg0.CamosWillAppearHereText:completeAnimation()
	f24_arg0.CamosWillAppearHereText:setAlpha(1)
end
CoD.ThemeOptionGrid.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.CamosWillAppearHereText:completeAnimation()
			f25_arg0.CamosWillAppearHereText:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CamosWillAppearHereText)
		end,
	},
	ListEmpty = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ThemeOptionGrid.__onClose = function(f27_arg0)
	f27_arg0.MasteryGrid:close()
end
