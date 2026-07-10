require("x64:fbffc86e9a93477")
require("x64:7b5952c3bc0ee42")
require("x64:38c11a77e96e48c")
require("x64:75e2a524b093c12")
CoD.WeaponAccessoriesSelectInternal = InheritFrom(LUI.UIElement)
CoD.WeaponAccessoriesSelectInternal.__defaultWidth = 1920
CoD.WeaponAccessoriesSelectInternal.__defaultHeight = 1080
CoD.WeaponAccessoriesSelectInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CACUtility.ShowEmptyWeaponCharmModel(f1_arg0, f1_arg1)
	self:setClass(CoD.WeaponAccessoriesSelectInternal)
	self.id = "WeaponAccessoriesSelectInternal"
	self.soundSet = "CAC_WeaponPersonalization"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CharmListBg = LUI.UIImage.new(0, 0, 73, 921, 0, 0, 81, 926)
	CharmListBg:setScale(0.77, 0.77)
	CharmListBg:setImage(RegisterImage(@"uie_ui_menu_emblem_empty_bg"))
	CharmListBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	CharmListBg:setShaderVector(0, 0, 0, 0, 0)
	CharmListBg:setupNineSliceShader(212, 212)
	self:addElement(CharmListBg)
	self.CharmListBg = CharmListBg
	local CharmList = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, true, false, false, false)
	CharmList:setLeftRight(0, 0, 173, 814)
	CharmList:setTopBottom(0, 0, 178, 819)
	CharmList:setWidgetType(CoD.LootWeaponOptionButton)
	CharmList:setHorizontalCount(4)
	CharmList:setVerticalCount(4)
	CharmList:setSpacing(11)
	CharmList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CharmList:setVerticalCounter(CoD.verticalCounter)
	CharmList:setDataSource("WeaponCharmList")
	CharmList:linkToElementModel(CharmList, "isLocked", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	CharmList:linkToElementModel(CharmList, "available", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	CharmList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	local CharmsMessage = CharmList
	local ItemInfoPanel = CharmList.subscribeToModel
	local XCamMouseControl = Engine[@"getmodelforcontroller"](f1_arg1)
	ItemInfoPanel(CharmsMessage, XCamMouseControl.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	CharmList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.CACUtility.UpdateWeaponCharmModel(f1_arg0, element, f1_arg1)
		return f6_local0
	end)
	CharmList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f7_local0 = nil
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPrestigeAttachment") then
			CoD.BreadcrumbUtility.SetWeaponAccessoryOld(f1_arg0, element, f1_arg1)
		end
		return f7_local0
	end)
	CharmList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CharmList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isLocked") and CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, controller, "available") and not IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") then
			CoD.WeaponOptionsUtility.EquipWeaponAccessory(menu, element, controller, false)
			SaveLoadout(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isLocked") and CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, controller, "available") and not IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CharmList, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsGamepad(controller) then
			CoD.WeaponOptionsUtility.ClearWeaponAccessory(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CharmList, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "ui_remove", function(element, menu, controller, model)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsMouseOrKeyboard(controller) then
			CoD.WeaponOptionsUtility.ClearWeaponAccessory(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementModelConditionFn(menu, self, element, controller, "isEquippedFn") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	CharmList:subscribeToGlobalModel(f1_arg1, "WeaponCharmList", "updateSelections", function(model)
		local f15_local0 = CharmList
		UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
	end)
	CharmList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/remove", function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if IsElementModelConditionFn(f16_arg1, self, f16_arg0, f16_arg2, "isEquippedFn") then
			return function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
				CoD.WeaponOptionsUtility.ClearWeaponAccessory(f17_arg1, f17_arg2)
			end
		else
		end
	end)
	self:addElement(CharmList)
	self.CharmList = CharmList
	ItemInfoPanel = CoD.BM_ItemInfoPanel.new(f1_arg0, f1_arg1, 1, 1, -732, -192, 0, 0, 695, 845)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	CharmsMessage = LUI.UIText.new(0, 0, 167, 817, 0.5, 0.5, -53.5, -23.5)
	CharmsMessage:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CharmsMessage:setAlpha(0)
	CharmsMessage:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6F11EFCA50B790EB"))
	CharmsMessage:setTTF("dinnext_regular")
	CharmsMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CharmsMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CharmsMessage)
	self.CharmsMessage = CharmsMessage
	XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_arg0, f1_arg1, 0.32, 0.68, 500, 500, 0, 0, 165, 665)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	ItemInfoPanel:linkToElementModel(CharmList, nil, false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "ListEmpty",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.CharmList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f20_arg1)
	end)
	CharmList.id = "CharmList"
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	self.__defaultFocus = CharmList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	f1_local6 = CharmList
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local6, f1_arg1, "name", "", "")
	end
	return self
end
CoD.WeaponAccessoriesSelectInternal.__resetProperties = function(f21_arg0)
	f21_arg0.CharmsMessage:completeAnimation()
	f21_arg0.CharmsMessage:setAlpha(0)
end
CoD.WeaponAccessoriesSelectInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	ListEmpty = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.CharmsMessage:completeAnimation()
			f23_arg0.CharmsMessage:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.CharmsMessage)
		end,
	},
}
CoD.WeaponAccessoriesSelectInternal.__onClose = function(f24_arg0)
	f24_arg0.ItemInfoPanel:close()
	f24_arg0.CharmList:close()
	f24_arg0.XCamMouseControl:close()
end
