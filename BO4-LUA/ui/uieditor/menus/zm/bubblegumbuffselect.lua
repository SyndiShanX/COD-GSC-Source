require("x64:1827e15981384e2")
require("x64:341ce33d59fafd1")
require("x64:ce1e6b6549d478c")
require("x64:38c11a77e96e48c")
require("x64:5b3f12fb71c1346")
require("x64:51417b7fe0a0948")
require("x64:7046b0d9f3594f1")
require("x64:602298da419f4f")
CoD.BubblegumBuffSelect = InheritFrom(CoD.Menu)
LUI.createMenu.BubblegumBuffSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BubblegumBuffSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "BubbleGumBuffUpdated", 0)
	self:setClass(CoD.BubblegumBuffSelect)
	self.soundSet = "ZCAC"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local selectionList = LUI.UIList.new(f1_local1, f1_arg0, 16, 0, nil, false, false, false, false)
	selectionList:setLeftRight(0.5, 0.5, -387, 387)
	selectionList:setTopBottom(0, 0, 203, 803)
	selectionList:setWidgetType(CoD.BGBListItem)
	selectionList:setHorizontalCount(5)
	selectionList:setVerticalCount(4)
	selectionList:setSpacing(16)
	selectionList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	selectionList:setVerticalCounter(CoD.verticalCounter)
	selectionList:setDataSource("Unlockables")
	selectionList:linkToElementModel(selectionList, "globalItemIndex", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	selectionList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_local1, self, element, f1_arg0)
		return f3_local0
	end)
	selectionList:registerEventHandler("gain_list_focus", function(element, event)
		local f4_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "ItemInfo")
		return f4_local0
	end)
	selectionList:registerEventHandler("used_permanent_unlock_token", function(element, event)
		local f5_local0 = nil
		CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_local1, self, element, f1_arg0)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	selectionList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.EquipBubblegumBuff(menu, element, controller)
			CoD.ZMLoadoutUtility.UpdateBubbleGumPackForCurrentClass(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "usebgb1", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.SetBubblegumBuffLoadoutSelectedIndexWithPromptSlot(controller, "up")
			CoD.ZMLoadoutUtility.EquipBubblegumBuff(menu, element, controller)
			CoD.ZMLoadoutUtility.UpdateBubbleGumPackForCurrentClass(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "usebgb1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "usebgb2", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.SetBubblegumBuffLoadoutSelectedIndexWithPromptSlot(controller, "right")
			CoD.ZMLoadoutUtility.EquipBubblegumBuff(menu, element, controller)
			CoD.ZMLoadoutUtility.UpdateBubbleGumPackForCurrentClass(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "usebgb2")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "usebgb3", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.SetBubblegumBuffLoadoutSelectedIndexWithPromptSlot(controller, "down")
			CoD.ZMLoadoutUtility.EquipBubblegumBuff(menu, element, controller)
			CoD.ZMLoadoutUtility.UpdateBubbleGumPackForCurrentClass(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "usebgb3")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "usebgb4", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.SetBubblegumBuffLoadoutSelectedIndexWithPromptSlot(controller, "left")
			CoD.ZMLoadoutUtility.EquipBubblegumBuff(menu, element, controller)
			CoD.ZMLoadoutUtility.UpdateBubbleGumPackForCurrentClass(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "usebgb4")
			return false
		else
			return false
		end
	end, false)
	self:addElement(selectionList)
	self.selectionList = selectionList
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 424, 454)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, 411, 911, 0.5, 0.5, 76, 183)
	ItemInfo:mergeStateConditions({
		{
			stateName = "ZombieCompact",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f18_local0 = nil
		if element.menuLoaded then
			f18_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f18_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f18_local0 then
			f18_local0 = element:dispatchEventToChildren(event)
		end
		return f18_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local EquippedBGBContainer = CoD.EquippedBGBContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -899, -549, 0.5, 0.5, -289, 61)
	self:addElement(EquippedBGBContainer)
	self.EquippedBGBContainer = EquippedBGBContainer
	local PCEquippedBGBContainer = nil
	PCEquippedBGBContainer = CoD.PC_EquippedBGBContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -795, -668, 0.5, 0.5, -334, 130)
	self:addElement(PCEquippedBGBContainer)
	self.PCEquippedBGBContainer = PCEquippedBGBContainer
	local TopBar = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0.5, 0.5, 283, 286)
	TopBar:setRGB(0.58, 0.85, 1)
	TopBar:setAlpha(0.5)
	TopBar:setZoom(2)
	TopBar:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local hint = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, 312, 330)
	hint:setRGB(0.58, 0.58, 0.58)
	hint:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4C3CD6A380B2DAA3"))
	hint:setTTF("ttmussels_regular")
	hint:setLetterSpacing(2)
	hint:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	hint:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(hint)
	self.hint = hint
	local TopBar2 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0.5, 0.5, 356, 359)
	TopBar2:setRGB(0.58, 0.85, 1)
	TopBar2:setAlpha(0.5)
	TopBar2:setZoom(2)
	TopBar2:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	local BGBSelectSafeAreaContainer = CoD.BGBSelectSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	BGBSelectSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f19_local0 = nil
		if element.menuLoaded then
			f19_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f19_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f19_local0 then
			f19_local0 = element:dispatchEventToChildren(event)
		end
		return f19_local0
	end)
	BGBSelectSafeAreaContainer:registerEventHandler("list_active_changed", function(element, event)
		local f20_local0 = nil
		SetProperty(self, "__itemGroup", element.filter)
		SetProperty(self, "__rarity", element.rarity)
		UpdateDataSource(self, self.selectionList, f1_arg0)
		return f20_local0
	end)
	self:addElement(BGBSelectSafeAreaContainer)
	self.BGBSelectSafeAreaContainer = BGBSelectSafeAreaContainer
	RestrictedText:linkToElementModel(selectionList, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg0)
	end)
	ItemInfo:linkToElementModel(selectionList, nil, false, function(model)
		ItemInfo:setModel(model, f1_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "DefaultStateKeyboard",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f24_arg0, f24_arg1)
		f24_arg1.menu = f24_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f24_arg1)
	end)
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local13(f1_local12, f1_local14.LastInput, function(f25_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f25_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = DataSources.BGBLoadout.getModel(f1_arg0)
	f1_local13(f1_local12, f1_local14.selectedIndex, function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_right"])
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_left"])
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f27_local0 = nil
		if self.menuLoaded then
			f27_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f27_local0 = self.super:menuLoaded(event)
		end
		ShowHeaderIconOnly(f1_local1)
		SetElementStateByElementName(self, "GenericMenuFrame0", f1_arg0, "Update")
		PlayClipOnElement(self, {
			elementName = "GenericMenuFrame0",
			clipName = "intro",
		}, f1_arg0)
		PlayClip(self, "into", f1_arg0)
		if not f27_local0 then
			f27_local0 = self:dispatchEventToChildren(event)
		end
		return f27_local0
	end)
	self:registerEventHandler("list_active_changed", function(self, event)
		local f28_local0 = nil
		CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_local1, self, self.selectionList, f1_arg0)
		return f28_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		PlaySoundSetSound(self, "menu_no_selection")
		SendClientScriptMenuChangeNotify(controller, menu, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, true)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_up"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 0) then
			SetControllerModelValue(controller, "BGBLoadout.selectedIndex", 0)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_up"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 1) then
			SetControllerModelValue(controller, "BGBLoadout.selectedIndex", 1)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_down"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 2) then
			SetControllerModelValue(controller, "BGBLoadout.selectedIndex", 2)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 2) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_down"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 3) then
			SetControllerModelValue(controller, "BGBLoadout.selectedIndex", 3)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "BGBLoadout", "selectedIndex", 3) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
		local f39_local0 = self
		SendClientScriptMenuChangeNotify(f39_arg1, f39_arg2, true)
		SetPerControllerTableProperty(f39_arg1, "weaponCategory", "bubblegum")
		SetGlobalModelValueTrue("inBubblegumBuffSelectMenu")
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetGlobalModelValueFalse("inBubblegumBuffSelectMenu")
		SetControllerModelValue(f1_arg0, "BGBLoadout.selectedIndex", -1)
		CoD.CACUtility.ClearClassWeaponModel(f1_local1, f1_arg0)
		ClearMenuSavedState(f1_local1)
	end)
	selectionList.id = "selectionList"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	EquippedBGBContainer.id = "EquippedBGBContainer"
	if CoD.isPC then
		PCEquippedBGBContainer.id = "PCEquippedBGBContainer"
	end
	BGBSelectSafeAreaContainer.id = "BGBSelectSafeAreaContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = selectionList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local13 = self
	CoD.BaseUtility.SetMenuSessionMode(f1_local1, Enum[@"emodes"][@"mode_zombies"])
	CoD.ZMLoadoutUtility.AddBGBSelectMenuControls(f1_local1, self.CategoryTabs, self.EquippedBGBContainer, f1_arg0)
	return self
end
CoD.BubblegumBuffSelect.__resetProperties = function(f42_arg0)
	f42_arg0.PCEquippedBGBContainer:completeAnimation()
	f42_arg0.EquippedBGBContainer:completeAnimation()
	f42_arg0.PCEquippedBGBContainer:setAlpha(1)
	f42_arg0.EquippedBGBContainer:setAlpha(1)
end
CoD.BubblegumBuffSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(1)
			f43_arg0.PCEquippedBGBContainer:completeAnimation()
			f43_arg0.PCEquippedBGBContainer:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.PCEquippedBGBContainer)
		end,
	},
	DefaultStateKeyboard = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(1)
			f44_arg0.EquippedBGBContainer:completeAnimation()
			f44_arg0.EquippedBGBContainer:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.EquippedBGBContainer)
		end,
	},
}
CoD.BubblegumBuffSelect.__onClose = function(f45_arg0)
	f45_arg0.__on_close_removeOverrides()
	f45_arg0.RestrictedText:close()
	f45_arg0.ItemInfo:close()
	f45_arg0.selectionList:close()
	f45_arg0.FooterContainerFrontendRight:close()
	f45_arg0.EquippedBGBContainer:close()
	f45_arg0.PCEquippedBGBContainer:close()
	f45_arg0.BGBSelectSafeAreaContainer:close()
end
