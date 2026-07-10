require("x64:1394ae5e9cdcb54")
require("x64:ffc2c7e4adad795")
require("x64:a60f9dd8c2d255e")
require("x64:c0cb09f85132dc0")
require("x64:a969a8392712433")
CoD.PaintshopWeaponSelectWidget = InheritFrom(LUI.UIElement)
CoD.PaintshopWeaponSelectWidget.__defaultWidth = 1920
CoD.PaintshopWeaponSelectWidget.__defaultHeight = 1080
CoD.PaintshopWeaponSelectWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopWeaponSelectWidget)
	self.id = "PaintshopWeaponSelectWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local weaponList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, false, false, false, false)
	weaponList:setLeftRight(0.5, 0.5, -721, 721)
	weaponList:setTopBottom(1, 1, -384, -114)
	weaponList:setWidgetType(CoD.WeaponSelectGridItem)
	weaponList:setHorizontalCount(5)
	weaponList:setVerticalCount(2)
	weaponList:setSpacing(18)
	weaponList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	weaponList:setDataSource("PaintshopWeaponList")
	weaponList:linkToElementModel(weaponList, "refHash", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	weaponList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		CoD.CACUtility.UpdateWeaponNameInfoModel(f1_arg0, element, f1_arg1)
		CoD.CraftUtility.UpdateWeaponModel(f1_arg0, element, f1_arg1)
		return f3_local0
	end)
	weaponList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.CACUtility.ShowWeaponVariantList(menu, controller, self.WeaponVariantListWidget)
			PlaySoundAlias("uin_press_generic")
			SetControllerModelValue(controller, "PaintjobWeaponVariantListShown", true)
			return true
		elseif not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.CraftUtility.OpenPaintjobSelection(self, element, controller, "setweapon", menu)
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_weaponList = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		local f7_local0 = weaponList
		CoD.CACUtility.SetActiveListItemToFirstSelectableItem(f7_local0, f7_arg1)
		CoD.CraftUtility.UpdateWeaponModel(f7_arg2, f7_local0, f7_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_weaponList)
	self:addElement(weaponList)
	self.weaponList = weaponList
	local weaponCategoryList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	weaponCategoryList:setLeftRight(0.5, 0.5, -600, 600)
	weaponCategoryList:setTopBottom(0, 0, 52, 87)
	weaponCategoryList:setZoom(72)
	weaponCategoryList:setWidgetType(CoD.CACTextTab)
	weaponCategoryList:setHorizontalCount(5)
	weaponCategoryList:setSpacing(0)
	weaponCategoryList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	weaponCategoryList:setDataSource("PaintshopWeaponGroups")
	weaponCategoryList:registerEventHandler("list_active_changed", function(element, event)
		local f8_local0 = nil
		if CoD.BaseUtility.IsWidgetVisible(element) then
			SetStateByElementModel(self, element, f1_arg1, "state")
			SetElementProperty(f1_arg0, "__itemGroup", element.category)
			SetLoseFocusToElement(self, "weaponList", f1_arg1)
			UpdateDataSource(self, self.weaponList, f1_arg1)
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_arg0, f1_arg0, f1_arg1)
			ForceCheckDefaultPCFocus(f1_arg0, f1_arg0, f1_arg1)
		end
		return f8_local0
	end)
	self.__on_menuOpened_weaponCategoryList = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		local f9_local0 = weaponCategoryList
		if not IsElementPropertyValue(f9_local0, "_receivedMenuOpen", true) then
			SetElementProperty(f9_local0, "_receivedMenuOpen", true)
			CoD.CACUtility.SetActiveListItemForWeaponGroup(f9_arg2, f9_arg1, self.weaponCategoryList)
			UpdateDataSource(self, self.weaponList, f9_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
	self:addElement(weaponCategoryList)
	self.weaponCategoryList = weaponCategoryList
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -799.5, -599.5, 0, 0, 52, 86)
	LB:setZoom(72)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 600, 771, 0, 0, 52, 86)
	RB:setZoom(72)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	local RightArrow = nil
	RightArrow = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 600, 667, 0, 0, 48.5, 93.5)
	RightArrow:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1) and AlwaysFalse()
			end,
		},
	})
	RightArrow:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(RightArrow, f11_arg1)
	end)
	local WeaponVariantListWidget = RightArrow
	local LeftArrow = RightArrow.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	LeftArrow(WeaponVariantListWidget, f1_local8.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(RightArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	RightArrow.KeyMouseImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	RightArrow.ControllerImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	RightArrow:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.GridAndListUtility.NavigateGridItem(self.weaponCategoryList, controller, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	LeftArrow = nil
	LeftArrow = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -666.5, -599.5, 0, 0, 48.5, 93.5)
	LeftArrow:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1) and AlwaysFalse()
			end,
		},
	})
	LeftArrow:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(LeftArrow, f17_arg1)
	end)
	f1_local8 = LeftArrow
	WeaponVariantListWidget = LeftArrow.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	WeaponVariantListWidget(f1_local8, f1_local9.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(LeftArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LeftArrow:setZRot(180)
	LeftArrow.KeyMouseImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	LeftArrow.ControllerImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	LeftArrow:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.GridAndListUtility.NavigateGridItem(self.weaponCategoryList, controller, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	WeaponVariantListWidget = CoD.WeaponVariantListWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -294, 196)
	WeaponVariantListWidget.SignatureWeaponList:setSpacing(18)
	WeaponVariantListWidget:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		return f22_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponVariantListWidget, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.CACUtility.HideWeaponVariantList(menu, controller)
		SetControllerModelValue(controller, "PaintjobWeaponVariantListShown", false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	self:addElement(WeaponVariantListWidget)
	self.WeaponVariantListWidget = WeaponVariantListWidget
	WeaponVariantListWidget:linkToElementModel(weaponList, nil, false, function(model)
		WeaponVariantListWidget:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "NoCategories",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.weaponCategoryList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f27_arg0, f27_arg1)
		f27_arg1.menu = f27_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f27_arg1)
	end)
	weaponList.id = "weaponList"
	weaponCategoryList.id = "weaponCategoryList"
	if CoD.isPC then
		RightArrow.id = "RightArrow"
	end
	if CoD.isPC then
		LeftArrow.id = "LeftArrow"
	end
	WeaponVariantListWidget.id = "WeaponVariantListWidget"
	self.__defaultFocus = weaponList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_weaponList)
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	f1_local8 = weaponList
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local8, f1_arg1, "displayName", "", "")
		SetElementProperty(f1_local8, "ignoreSavedActive", true)
		CoD.CACUtility.UseEquippedItemAsDefaultFocus(f1_arg0, f1_arg1, f1_local8)
	else
		SetElementProperty(f1_local8, "ignoreSavedActive", true)
	end
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, weaponCategoryList, f1_arg1)
	DisableKeyboardNavigationByElement(RightArrow)
	DisableKeyboardNavigationByElement(LeftArrow)
	f1_local8 = WeaponVariantListWidget
	HideWidget(self.WeaponVariantListWidget)
	SetElementProperty(f1_local8, "_forPaintshop", true)
	return self
end
CoD.PaintshopWeaponSelectWidget.__resetProperties = function(f29_arg0)
	f29_arg0.weaponCategoryList:completeAnimation()
	f29_arg0.RB:completeAnimation()
	f29_arg0.LB:completeAnimation()
	f29_arg0.weaponCategoryList:setAlpha(1)
	f29_arg0.RB:setAlpha(1)
	f29_arg0.LB:setAlpha(1)
end
CoD.PaintshopWeaponSelectWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	NoCategories = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.weaponCategoryList:completeAnimation()
			f31_arg0.weaponCategoryList:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.weaponCategoryList)
			f31_arg0.LB:completeAnimation()
			f31_arg0.LB:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.LB)
			f31_arg0.RB:completeAnimation()
			f31_arg0.RB:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.RB)
		end,
	},
}
CoD.PaintshopWeaponSelectWidget.__onClose = function(f32_arg0)
	f32_arg0.__on_close_removeOverrides()
	f32_arg0.WeaponVariantListWidget:close()
	f32_arg0.weaponList:close()
	f32_arg0.weaponCategoryList:close()
	f32_arg0.LB:close()
	f32_arg0.RB:close()
	f32_arg0.RightArrow:close()
	f32_arg0.LeftArrow:close()
end
