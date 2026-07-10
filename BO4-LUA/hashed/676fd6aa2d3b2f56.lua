require("x64:fbffc86e9a93477")
require("x64:7b5952c3bc0ee42")
require("x64:38c11a77e96e48c")
require("x64:75e2a524b093c12")
CoD.WeaponDeathFxSelectInternal = InheritFrom(LUI.UIElement)
CoD.WeaponDeathFxSelectInternal.__defaultWidth = 1920
CoD.WeaponDeathFxSelectInternal.__defaultHeight = 1080
CoD.WeaponDeathFxSelectInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if not IsCurrentMenu(f1_arg0, "WeaponTabbedAccessoriesSelect") then
		CoD.WeaponOptionsUtility.DeathFxCharacterUpdate(f1_arg0, f1_arg1)
	elseif IsCurrentMenu(f1_arg0, "WeaponTabbedAccessoriesSelect") then
		SendCustomClientScriptMenuChangeNotify(f1_arg1, "WeaponDeathFxSelect", true)
		CoD.WeaponOptionsUtility.DeathFxCharacterUpdate(f1_arg0, f1_arg1)
	end
	self:setClass(CoD.WeaponDeathFxSelectInternal)
	self.id = "WeaponDeathFxSelectInternal"
	self.soundSet = "CAC_WeaponPersonalization"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local DeathFxListBg = LUI.UIImage.new(0, 0, 73, 921, 0, 0, 81, 926)
	DeathFxListBg:setScale(0.77, 0.77)
	DeathFxListBg:setImage(RegisterImage(0xCE384B31419E220))
	DeathFxListBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	DeathFxListBg:setShaderVector(0, 0, 0, 0, 0)
	DeathFxListBg:setupNineSliceShader(212, 212)
	self:addElement(DeathFxListBg)
	self.DeathFxListBg = DeathFxListBg
	local DeathFxList = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, true, false, false, false)
	DeathFxList:setLeftRight(0, 0, 173, 814)
	DeathFxList:setTopBottom(0, 0, 178, 819)
	DeathFxList:setWidgetType(CoD.LootWeaponOptionButton)
	DeathFxList:setHorizontalCount(4)
	DeathFxList:setVerticalCount(4)
	DeathFxList:setSpacing(11)
	DeathFxList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DeathFxList:setVerticalCounter(CoD.verticalCounter)
	DeathFxList:setDataSource("WeaponDeathFxList")
	DeathFxList:linkToElementModel(DeathFxList, "available", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DeathFxList:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end)
	local XCamMouseControl = DeathFxList
	local ItemInfoPanel = DeathFxList.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ItemInfoPanel(XCamMouseControl, f1_local5.LastInput, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
	end, false)
	DeathFxList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f5_local0 = nil
		CoD.BreadcrumbUtility.SetWeaponDeathFxOld(f1_arg0, element, f1_arg1)
		return f5_local0
	end)
	DeathFxList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DeathFxList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") and not IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and not IsPC() then
			CoD.WeaponOptionsUtility.EquipDeathFx(menu, element, controller, false)
			UpdateButtonPromptState(menu, element, controller, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
			SaveLoadout(self, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") and not IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") then
			CoD.WeaponOptionsUtility.EquipDeathFx(menu, element, controller, false)
			UpdateButtonPromptState(menu, element, controller, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
			CoD.WeaponOptionsUtility.PreviewDeathFx(menu, element, controller)
			SaveLoadout(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") and not IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") and not IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeathFxList, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		if IsGamepad(controller) then
			CoD.WeaponOptionsUtility.PreviewDeathFx(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeathFxList, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_contextual_1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.WeaponOptionsUtility.PreviewDeathFx(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x52FB29ED3A3CA79, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeathFxList, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsGamepad(controller) then
			CoD.WeaponOptionsUtility.ClearDeathFx(menu, controller)
			UpdateButtonPromptState(menu, element, controller, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeathFxList, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "ui_remove", function(element, menu, controller, model)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsMouseOrKeyboard(controller) then
			CoD.WeaponOptionsUtility.ClearDeathFx(menu, controller)
			UpdateButtonPromptState(menu, element, controller, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	DeathFxList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x52FB29ED3A3CA79, function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
		return function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
			CoD.WeaponOptionsUtility.PreviewDeathFx(f18_arg1, f18_arg0, f18_arg2)
		end
	end)
	DeathFxList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
		if IsElementModelConditionFn(f19_arg1, self, f19_arg0, f19_arg2, "isEquippedFn") then
			return function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
				CoD.WeaponOptionsUtility.ClearDeathFx(f20_arg1, f20_arg2)
				UpdateButtonPromptState(f20_arg1, f20_arg0, f20_arg2, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
			end
		else
		end
	end)
	self:addElement(DeathFxList)
	self.DeathFxList = DeathFxList
	ItemInfoPanel = CoD.BM_ItemInfoPanel.new(f1_arg0, f1_arg1, 1, 1, -732, -192, 0, 0, 695, 845)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_arg0, f1_arg1, 0.32, 0.68, 500, 500, 0, 0, 165, 665)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	ItemInfoPanel:linkToElementModel(DeathFxList, nil, false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if not IsCurrentMenu(f1_arg0, "WeaponTabbedAccessoriesSelect") then
			CoD.WeaponOptionsUtility.StopDeathFxPreview(f1_arg0, f1_arg1)
		elseif IsCurrentMenu(f1_arg0, "WeaponTabbedAccessoriesSelect") then
			CoD.WeaponOptionsUtility.StopDeathFxPreview(f1_arg0, f1_arg1)
			SendCustomClientScriptMenuChangeNotify(f1_arg1, "WeaponDeathFxSelect", false)
		end
	end)
	DeathFxList.id = "DeathFxList"
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	self.__defaultFocus = DeathFxList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = DeathFxList
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local5, f1_arg1, "name", "", "")
	end
	return self
end
CoD.WeaponDeathFxSelectInternal.__onClose = function(f23_arg0)
	f23_arg0.ItemInfoPanel:close()
	f23_arg0.DeathFxList:close()
	f23_arg0.XCamMouseControl:close()
end
