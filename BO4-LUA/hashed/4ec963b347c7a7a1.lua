require("x64:d9c47b606eb32d9")
CoD.PrestigeAttachmentGrid = InheritFrom(LUI.UIElement)
CoD.PrestigeAttachmentGrid.__defaultWidth = 400
CoD.PrestigeAttachmentGrid.__defaultHeight = 100
CoD.PrestigeAttachmentGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrestigeAttachmentGrid)
	self.id = "PrestigeAttachmentGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrestigeAttachmentList = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	PrestigeAttachmentList:setLeftRight(1, 1, -250, -44)
	PrestigeAttachmentList:setTopBottom(0, 0, 20, 80)
	PrestigeAttachmentList:setWidgetType(CoD.PrestigeAttachmentSlot)
	PrestigeAttachmentList:setHorizontalCount(2)
	PrestigeAttachmentList:setSpacing(6)
	PrestigeAttachmentList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PrestigeAttachmentList:setDataSource("WeaponOptions")
	PrestigeAttachmentList:linkToElementModel(PrestigeAttachmentList, "itemIndex", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	PrestigeAttachmentList:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	local f1_local2 = PrestigeAttachmentList
	local f1_local3 = PrestigeAttachmentList.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	PrestigeAttachmentList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel(element, f1_arg1, f1_arg0)
		CoD.WeaponOptionsUtility.UpdateWeaponPrestigeAttachment(f1_arg0, element, f1_arg1)
		return f5_local0
	end)
	PrestigeAttachmentList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PrestigeAttachmentList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) and not CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) then
			PlaySoundAlias("uin_equipment_add")
			CoD.WeaponOptionsUtility.SetWeaponPrestigeAttachmentItem(menu, self, element, controller, false)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponPrestigeAttachmentItem(menu, controller, false)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, controller) and not CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(PrestigeAttachmentList, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) and IsGamepad(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponPrestigeAttachmentItem(menu, controller, false)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(PrestigeAttachmentList, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "ui_remove", function(element, menu, controller, model)
		if CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("cac_equipment_remove")
			CoD.WeaponOptionsUtility.ClearWeaponPrestigeAttachmentItem(menu, controller, false)
			UpdateSelfState(self, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	PrestigeAttachmentList:subscribeToGlobalModel(f1_arg1, "PerController", "WeaponPersonalization.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(PrestigeAttachmentList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	PrestigeAttachmentList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/remove", function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		if CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(f14_arg1, self, f14_arg0, f14_arg2) then
			return function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
				PlaySoundAlias("cac_equipment_remove")
				CoD.WeaponOptionsUtility.ClearWeaponPrestigeAttachmentItem(f15_arg1, f15_arg2, false)
				UpdateSelfState(self, f15_arg2)
				UpdateAllMenuButtonPrompts(f15_arg1, f15_arg2)
			end
		else
		end
	end)
	self:addElement(PrestigeAttachmentList)
	self.PrestigeAttachmentList = PrestigeAttachmentList
	PrestigeAttachmentList.id = "PrestigeAttachmentList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = PrestigeAttachmentList
	if IsPC() and CoD.BaseUtility.IsMenuLoadoutSlotEqualTo(f1_arg0, "secondary") then
		SetElementProperty(f1_local3, "_category", CoD.CACUtility.secondaryWeaponPrestigeSlot)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local3, f1_arg1, "name", "", "")
	elseif CoD.BaseUtility.IsMenuLoadoutSlotEqualTo(f1_arg0, "secondary") then
		SetElementProperty(f1_local3, "_category", CoD.CACUtility.secondaryWeaponPrestigeSlot)
	elseif IsPC() then
		SetElementProperty(f1_local3, "_category", CoD.CACUtility.primaryWeaponPrestigeSlot)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local3, f1_arg1, "name", "", "")
	else
		SetElementProperty(f1_local3, "_category", CoD.CACUtility.primaryWeaponPrestigeSlot)
	end
	return self
end
CoD.PrestigeAttachmentGrid.__resetProperties = function(f16_arg0)
	f16_arg0.PrestigeAttachmentList:completeAnimation()
	f16_arg0.PrestigeAttachmentList:setAlpha(1)
end
CoD.PrestigeAttachmentGrid.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.PrestigeAttachmentList:completeAnimation()
			f17_arg0.PrestigeAttachmentList:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PrestigeAttachmentList)
		end,
	},
	Visible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.PrestigeAttachmentList:completeAnimation()
			f18_arg0.PrestigeAttachmentList:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.PrestigeAttachmentList)
		end,
	},
}
CoD.PrestigeAttachmentGrid.__onClose = function(f19_arg0)
	f19_arg0.PrestigeAttachmentList:close()
end
