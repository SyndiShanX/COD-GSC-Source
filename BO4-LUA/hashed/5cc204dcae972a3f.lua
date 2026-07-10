require("x64:ec85b8e81fc1c0e")
require("x64:38c11a77e96e48c")
CoD.PaintjobOptionGrid = InheritFrom(LUI.UIElement)
CoD.PaintjobOptionGrid.__defaultWidth = 270
CoD.PaintjobOptionGrid.__defaultHeight = 350
CoD.PaintjobOptionGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintjobOptionGrid)
	self.id = "PaintjobOptionGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Label = LUI.UIText.new(0, 0, 8, 240, 0, 0, 11, 27)
	Label:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Label:setText(LocalizeToUpperString(0x7903AA4008142BA))
	Label:setTTF("ttmussels_regular")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Label)
	self.Label = Label
	local paintjobsList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	paintjobsList:setLeftRight(0, 0, 20, 250)
	paintjobsList:setTopBottom(0, 0, 37, 297)
	paintjobsList:setWidgetType(CoD.PaintjobPersonalizationSlot)
	paintjobsList:setHorizontalCount(2)
	paintjobsList:setVerticalCount(3)
	paintjobsList:setSpacing(10)
	paintjobsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	paintjobsList:setVerticalCounter(CoD.verticalCounter)
	paintjobsList:setDataSource("WeaponOptions")
	local f1_local3 = paintjobsList
	local BottomBracket9Slice = paintjobsList.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	BottomBracket9Slice(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end, false)
	paintjobsList:linkToElementModel(paintjobsList, "ref", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	paintjobsList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end)
	f1_local3 = paintjobsList
	BottomBracket9Slice = paintjobsList.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	BottomBracket9Slice(f1_local3, f1_local5.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end, false)
	paintjobsList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
		CoD.CraftUtility.PaintjobPersonalization_Preview(self, element, f1_arg1)
		return f6_local0
	end)
	paintjobsList:registerEventHandler("lose_list_focus", function(element, event)
		local f7_local0 = nil
		CoD.CraftUtility.PaintjobPersonalization_RestoreSelected(self, f1_arg1)
		CoD.WeaponOptionsUtility.ClearWeaponOptionInfoModel(f1_arg0, f1_arg1, element)
		return f7_local0
	end)
	paintjobsList:registerEventHandler("gain_focus", function(element, event)
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
	f1_arg0:AddButtonCallbackFunction(paintjobsList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsZombies() and not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "ref", "paintjob_create") and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			PlaySoundAlias("cac_equipment_add")
			CoD.WeaponOptionsUtility.SetWeaponOptionClassItem(self, element, controller, menu)
			CoD.CraftUtility.PaintjobPersonalization_Select(self, element, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif IsZombies() and not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "ref", "paintjob_create") and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			PlaySoundAlias("cac_equipment_add")
			CoD.ZMLoadoutUtility.SetWeaponOptionForVariant(self, element, controller, menu)
			CoD.CraftUtility.PaintjobPersonalization_Select(self, element, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "ref", "paintjob_create") then
			PlaySoundAlias("uin_toggle_generic")
			CoD.CraftUtility.OpenPaintjobSelection(self, element, controller, "nil", menu)
			return true
		elseif IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			PlaySoundAlias("cac_equipment_remove")
			CoD.ZMLoadoutUtility.ClearWeaponOptionForVariant(self, element, controller, menu)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif not IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptions(element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsZombies() and not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "ref", "paintjob_create") and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif IsZombies() and not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "ref", "paintjob_create") and not CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "ref", "paintjob_create") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xDFFD9B8A1D5E6D4, nil, nil)
			return true
		elseif IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif not IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(paintjobsList, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsGamepad(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.ZMLoadoutUtility.ClearWeaponOptionForVariant(self, element, controller, menu)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif not IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsGamepad(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptions(element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		elseif not IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(paintjobsList, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "ui_remove", function(element, menu, controller, model)
		if IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.ZMLoadoutUtility.ClearWeaponOptionForVariant(self, element, controller, menu)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif not IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponOptions(element, menu, controller)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		elseif not IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, controller, "paintjobSlot") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	paintjobsList:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(paintjobsList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	paintjobsList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(f16_arg1, f16_arg0, f16_arg2, "paintjobSlot") then
			return function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
				PlaySoundAlias("cac_equipment_remove")
				CoD.ZMLoadoutUtility.ClearWeaponOptionForVariant(self, f17_arg0, f17_arg2, f17_arg1)
				UpdateSelfState(self, f17_arg2)
				UpdateAllMenuButtonPrompts(f17_arg1, f17_arg2)
			end
		elseif not IsZombies() and CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(f16_arg1, f16_arg0, f16_arg2, "paintjobSlot") then
			return function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
				PlaySoundAlias("cac_equipment_remove")
				CoD.WeaponOptionsUtility.ClearWeaponOptions(f18_arg0, f18_arg1, f18_arg2)
				UpdateSelfState(self, f18_arg2)
				UpdateAllMenuButtonPrompts(f18_arg1, f18_arg2)
			end
		else
		end
	end)
	self:addElement(paintjobsList)
	self.paintjobsList = paintjobsList
	BottomBracket9Slice = LUI.UIImage.new(0, 1, 8, -8, 0, 0, 28, 37)
	BottomBracket9Slice:setAlpha(0.5)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.paintjobsList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f20_arg1)
	end)
	paintjobsList.id = "paintjobsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = paintjobsList
	if IsPC() then
		SetElementProperty(f1_local3, "_category", "paintjob")
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local3, f1_arg1, "name", "", "")
	else
		SetElementProperty(f1_local3, "_category", "paintjob")
	end
	return self
end
CoD.PaintjobOptionGrid.__resetProperties = function(f21_arg0)
	f21_arg0.BottomBracket9Slice:completeAnimation()
	f21_arg0.paintjobsList:completeAnimation()
	f21_arg0.Label:completeAnimation()
	f21_arg0.BottomBracket9Slice:setAlpha(0.5)
	f21_arg0.paintjobsList:setAlpha(1)
	f21_arg0.Label:setAlpha(1)
end
CoD.PaintjobOptionGrid.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.Label:completeAnimation()
			f23_arg0.Label:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Label)
			f23_arg0.paintjobsList:completeAnimation()
			f23_arg0.paintjobsList:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.paintjobsList)
			f23_arg0.BottomBracket9Slice:completeAnimation()
			f23_arg0.BottomBracket9Slice:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.BottomBracket9Slice)
		end,
	},
}
CoD.PaintjobOptionGrid.__onClose = function(f24_arg0)
	f24_arg0.paintjobsList:close()
end
