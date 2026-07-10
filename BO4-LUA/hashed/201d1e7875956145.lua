require("x64:b62ba0298ebda7a")
require("x64:53aa92712af1594")
require("x64:89ba7fe93e9e723")
CoD.ReticleGroupContainer = InheritFrom(LUI.UIElement)
CoD.ReticleGroupContainer.__defaultWidth = 1920
CoD.ReticleGroupContainer.__defaultHeight = 350
CoD.ReticleGroupContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReticleGroupContainer)
	self.id = "ReticleGroupContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CycleColorPrompt = CoD.ReticleCycleColorPrompt.new(f1_arg0, f1_arg1, 0, 0, 860, 1060, 0, 0, 41, 91)
	CycleColorPrompt:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.WeaponOptionsUtility.ShouldShowReticleCycleColorPrompt(f1_arg1, element, menu)
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	CycleColorPrompt:linkToElementModel(CycleColorPrompt, "itemIndex", true, function(model)
		f1_arg0:updateElementState(CycleColorPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	CycleColorPrompt:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CycleColorPrompt, f5_arg1)
	end)
	local ReticlesList = CycleColorPrompt
	local Label = CycleColorPrompt.subscribeToModel
	local ReticleColors = Engine[0x4DF5CFBC1771947](f1_arg1)
	Label(ReticlesList, ReticleColors.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(CycleColorPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:addElement(CycleColorPrompt)
	self.CycleColorPrompt = CycleColorPrompt
	Label = LUI.UIText.new(0, 1, 0, 0, 0, 0, 104, 122)
	Label:setRGB(0.39, 0.39, 0.39)
	Label:setText(LocalizeToUpperString(0xE44ADD3E8DA4E08))
	Label:setTTF("default")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Label)
	self.Label = Label
	ReticlesList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	ReticlesList:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, f1_arg1, "reticleIndex")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				local f8_local0 = CoD.CACUtility.IsProgressionWithWarzoneEnabledForMenu(menu)
				if f8_local0 then
					f8_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
					if f8_local0 then
						f8_local0 = not CoD.WeaponOptionsUtility.IsItemLootReticle(menu, element, f1_arg1)
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "LootLocked",
			condition = function(menu, element, event)
				return IsElementPropertyValue(element, "isLootLocked", true)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsWeaponOpticNew(menu, element, f1_arg1) and not IsZombies()
			end,
		},
	})
	ReticlesList:linkToElementModel(ReticlesList, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ReticlesList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local ReticlesWillAppearHereText = ReticlesList
	ReticleColors = ReticlesList.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	ReticleColors(ReticlesWillAppearHereText, f1_local6["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(ReticlesList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ReticlesList:setLeftRight(0.5, 0.5, -475, 475)
	ReticlesList:setTopBottom(0, 0, 127, 297)
	ReticlesList:setWidgetType(CoD.ReticleSlot)
	ReticlesList:setHorizontalCount(8)
	ReticlesList:setVerticalCount(2)
	ReticlesList:setSpacing(10)
	ReticlesList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ReticlesList:setDataSource("WeaponReticles")
	ReticlesList:linkToElementModel(ReticlesList, "itemIndex", true, function(model, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	ReticlesList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f14_local0 = nil
		CoD.WeaponOptionsUtility.UpdateWeaponReticle(f1_arg0, element, f1_arg1, false)
		CoD.GridAndListUtility.UpdateDataSource(self.ReticleColors, true, true, true)
		return f14_local0
	end)
	ReticlesList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f15_local0 = nil
		if IsElementInState(element, "New") then
			CoD.BreadcrumbUtility.SetWeaponOpticOld(f1_arg0, element, f1_arg1)
			CoD.BreadcrumbUtility.UpdateWeaponOpticBreadcrumbs(f1_arg0, f1_arg1)
		end
		return f15_local0
	end)
	ReticlesList:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ReticlesList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.CanEquipWeaponOption(menu, element, controller) and CoD.WeaponOptionsUtility.IsReticlePreviewing(controller, element, menu) and not IsElementPropertyValue(element, "isLootLocked", true) then
			SetCurrentElementAsActive(self, element, controller)
			CoD.WeaponOptionsUtility.SetWeaponOptionClassItemHelper(self, element, controller, menu)
			CoD.WeaponOptionsUtility.UpdateWeaponReticle(menu, element, controller, true)
			UpdateElementState(self, "ReticlesList", controller)
			UpdateElementState(self, "ReticleColors", controller)
			UpdateElementState(self, "CycleColorPrompt", controller)
			CoD.GridAndListUtility.UpdateDataSource(self.ReticleColors, true, true, true)
			PlaySoundAlias("uin_cac_attach_base")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.CanEquipWeaponOption(menu, element, controller) and CoD.WeaponOptionsUtility.IsReticlePreviewing(controller, element, menu) and not IsElementPropertyValue(element, "isLootLocked", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	ReticlesList:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.reticleListUpdate", function(model)
		UpdateDataSource(self, ReticlesList, f1_arg1)
		UpdateSelfState(self, f1_arg1)
	end)
	self:addElement(ReticlesList)
	self.ReticlesList = ReticlesList
	ReticleColors = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 10, 0, nil, nil, true, false, false, false)
	ReticleColors:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ReticleColors:linkToElementModel(ReticleColors, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ReticleColors, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	ReticleColors:appendEventHandler("input_source_changed", function(f22_arg0, f22_arg1)
		f22_arg1.menu = f22_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ReticleColors, f22_arg1)
	end)
	f1_local6 = ReticleColors
	ReticlesWillAppearHereText = ReticleColors.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ReticlesWillAppearHereText(f1_local6, f1_local7.LastInput, function(f23_arg0)
		f1_arg0:updateElementState(ReticleColors, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ReticleColors:setLeftRight(0.5, 0.5, -295, 295)
	ReticleColors:setTopBottom(0, 0, -47, 33)
	ReticleColors:setScale(0.9, 0.9)
	ReticleColors:setWidgetType(CoD.ReticleColorSlot)
	ReticleColors:setHorizontalCount(5)
	ReticleColors:setSpacing(10)
	ReticleColors:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ReticleColors:setDataSource("WeaponReticleColor")
	ReticleColors:registerEventHandler("list_active_changed", function(element, event)
		local f24_local0 = nil
		CoD.WeaponOptionsUtility.SetWeaponOptionClassItemHelper(self, element, f1_arg1, f1_arg0)
		CoD.WeaponOptionsUtility.UpdateWeaponReticleImage(f1_arg0, element, self.ReticlesList, f1_arg1)
		ForceCheckDefaultPCFocus(element, f1_arg0, f1_arg1)
		return f24_local0
	end)
	ReticleColors:registerEventHandler("gain_focus", function(element, event)
		local f25_local0 = nil
		if element.gainFocus then
			f25_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f25_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f25_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ReticleColors, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		SetCurrentElementAsActive(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self.__on_menuOpened_ReticleColors = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
		local f28_local0 = ReticleColors
		SetElementProperty(f28_local0, "_receivedMenuOpen", true)
		SetElementProperty(f28_local0, "__loopOnSameRow", true)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_ReticleColors)
	ReticleColors:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.reticleListUpdate", function(model)
		UpdateDataSource(self, ReticleColors, f1_arg1)
		UpdateSelfState(self, f1_arg1)
	end)
	self:addElement(ReticleColors)
	self.ReticleColors = ReticleColors
	ReticlesWillAppearHereText = LUI.UIText.new(0.5, 0.5, -615, 615, 0, 0, 150, 180)
	ReticlesWillAppearHereText:setAlpha(0)
	ReticlesWillAppearHereText:setText(Engine[0xF9F1239CFD921FE](0x13D359FE54DC768))
	ReticlesWillAppearHereText:setTTF("dinnext_regular")
	ReticlesWillAppearHereText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ReticlesWillAppearHereText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ReticlesWillAppearHereText)
	self.ReticlesWillAppearHereText = ReticlesWillAppearHereText
	CycleColorPrompt:linkToElementModel(ReticlesList, nil, false, function(model)
		CycleColorPrompt:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "ListEmpty",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.ReticlesList)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f33_arg0, f33_arg1)
		f33_arg1.menu = f33_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f33_arg1)
	end)
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local7, f1_local8.LastInput, function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:appendEventHandler("grid_updated", function(f35_arg0, f35_arg1)
		f35_arg1.menu = f35_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f35_arg1)
	end)
	self:appendEventHandler("input_source_changed", function(f36_arg0, f36_arg1)
		f36_arg1.menu = f36_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f36_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local7, f1_local8.LastInput, function(f37_arg0, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		if not IsMouseOrKeyboard(controller) then
			CoD.GridAndListUtility.NavigateGridItemInChild(self, controller, "ReticleColors", true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_arg0)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f41_arg2, f41_arg3, f41_arg4)
		if IsElementInState(element, "ListEmpty") then
			SetLoseFocusToElement(self, "ReticlesList", controller)
			ClearRecordedFocus(f1_arg0, controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.reticleListUpdate", function(model)
		if not IsPC() and not IsElementInState(self, "ListEmpty") then
			DelaySetFocusToElement(self, "ReticlesList", f1_arg1, 50)
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.ReticlesList)
		end
	end)
	ReticlesList.id = "ReticlesList"
	ReticleColors.id = "ReticleColors"
	self.__defaultFocus = ReticlesList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_ReticleColors)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	f1_local6 = ReticleColors
	if IsPC() then
		CoD.GridAndListUtility.DisableListActiveOnFocus(f1_local6)
		CoD.GridAndListUtility.ActivateListPCSelectionBehavior(f1_local6)
	end
	return self
end
CoD.ReticleGroupContainer.__resetProperties = function(f44_arg0)
	f44_arg0.ReticleColors:completeAnimation()
	f44_arg0.ReticlesWillAppearHereText:completeAnimation()
	f44_arg0.ReticleColors:setTopBottom(0, 0, -47, 33)
	f44_arg0.ReticlesWillAppearHereText:setAlpha(0)
end
CoD.ReticleGroupContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(1)
			f46_arg0.ReticleColors:completeAnimation()
			f46_arg0.ReticleColors:setTopBottom(0, 0, 0, 80)
			f46_arg0.clipFinished(f46_arg0.ReticleColors)
		end,
	},
	ListEmpty = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(1)
			f47_arg0.ReticlesWillAppearHereText:completeAnimation()
			f47_arg0.ReticlesWillAppearHereText:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.ReticlesWillAppearHereText)
		end,
	},
}
CoD.ReticleGroupContainer.__onClose = function(f48_arg0)
	f48_arg0.__on_close_removeOverrides()
	f48_arg0.CycleColorPrompt:close()
	f48_arg0.ReticlesList:close()
	f48_arg0.ReticleColors:close()
end
