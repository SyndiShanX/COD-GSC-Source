require("x64:94242ada7c129a0")
require("x64:cd8d4b91f5f751a")
CoD.Armory_OpticsList = InheritFrom(LUI.UIElement)
CoD.Armory_OpticsList.__defaultWidth = 500
CoD.Armory_OpticsList.__defaultHeight = 300
CoD.Armory_OpticsList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_OpticsList)
	self.id = "Armory_OpticsList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local BlackGradientBG = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 35, 31)
	BlackGradientBG:setRGB(0, 0, 0)
	BlackGradientBG:setAlpha(0.3)
	BlackGradientBG:setZRot(180)
	BlackGradientBG:setZoom(10)
	BlackGradientBG:setImage(RegisterImage(@"hash_78A6742E3F9A2ED"))
	self:addElement(BlackGradientBG)
	self.BlackGradientBG = BlackGradientBG
	local TopLine = LUI.UIImage.new(0, 1, 1, -1, 0, 0, 31, 49)
	TopLine:setAlpha(0.5)
	TopLine:setZoom(10)
	TopLine:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_line"))
	TopLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopLine)
	self.TopLine = TopLine
	local OpticsHeader = LUI.UIText.new(0.5, 0.5, -192.5, 192.5, 0, 0, -8, 10)
	OpticsHeader:setRGB(0.39, 0.39, 0.39)
	OpticsHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BB87386985BA15F"))
	OpticsHeader:setTTF("ttmussels_demibold")
	OpticsHeader:setLetterSpacing(4)
	OpticsHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	OpticsHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(OpticsHeader)
	self.OpticsHeader = OpticsHeader
	local Optics = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, false, false, false, false)
	Optics:setLeftRight(0.5, 0.5, -237, 237)
	Optics:setTopBottom(0, 0, 42, 281)
	Optics:setZoom(13)
	Optics:setWidgetType(CoD.Armory_AttachmentSlotContainer)
	Optics:setHorizontalCount(3)
	Optics:setVerticalCount(2)
	Optics:setSpacing(15)
	Optics:setBalanceGridRows(true)
	Optics:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Optics:setFilter(function(f2_arg0)
		return f2_arg0.attachmentGroup:get() == Enum[@"eattachmentgroup"][@"attachment_group_optic"]
	end)
	Optics:setDataSource("ArmoryWeaponAttachments")
	Optics:linkToElementModel(Optics, "itemIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local f1_local5 = Optics
	local OpticAttachmentPip = Optics.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	OpticAttachmentPip(f1_local5, f1_local7.armoryAttachmentUpdated, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	Optics:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	f1_local5 = Optics
	OpticAttachmentPip = Optics.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	OpticAttachmentPip(f1_local5, f1_local7.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	Optics:registerEventHandler("list_item_gain_focus", function(element, event)
		local f7_local0 = nil
		CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_arg0, element, f1_arg1, true)
		CoD.ZMLoadoutUtility.UpdateAttachmentListModelForWeaponAttributes(f1_arg0, self.Optics, f1_arg1)
		return f7_local0
	end)
	Optics:registerEventHandler("gain_list_focus", function(element, event)
		return nil
	end)
	Optics:registerEventHandler("lose_list_focus", function(element, event)
		local f9_local0 = nil
		CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_arg0, element, f1_arg1, false)
		CoD.WeaponAttachmentsUtility.ResetActiveListItemForList(element, f1_arg1)
		CoD.ZMLoadoutUtility.ResetAttachmentListModelForWeaponAttributes(f1_arg0, f1_arg0, f1_arg1)
		return f9_local0
	end)
	Optics:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Optics, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and not CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not CoD.ZMLoadoutUtility.IsArmoryAnyOpticAttachmentEquipped(controller, menu) then
			CoD.ZMLoadoutUtility.EquipArmoryElementAttachment(element, controller, menu)
			PlaySoundAlias("uin_cac_attach_base")
			return true
		elseif IsPC() and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.ZMLoadoutUtility.ToggleArmoryElementAttachment(element, controller, menu)
			return true
		elseif IsPC() and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") then
			CoD.ZMLoadoutUtility.ForceEquipArmoryOpticElementAttachment(element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and not CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not CoD.ZMLoadoutUtility.IsArmoryAnyOpticAttachmentEquipped(controller, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsPC() and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsPC() and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Optics, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment(element, controller, menu)
			PlaySoundAlias("uin_cac_attach_remove")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Optics, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment(element, controller, menu)
			PlaySoundAlias("uin_cac_attach_remove")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_remove")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Optics, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and IsBooleanDvarSet("tu12_zmEnableReticleCustomization") and CoD.CACUtility.IsAttachmentWithCustomReticle(menu, element) then
			CoD.CraftUtility.SetUpOpticPersonalization(element, controller)
			CoD.CACUtility.OpenCACAttachmentOverlay(self, element, menu, controller, "ReticleSelect", element, "primary")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and IsBooleanDvarSet("tu12_zmEnableReticleCustomization") and CoD.CACUtility.IsAttachmentWithCustomReticle(menu, element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_4AFF37175F950D17", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Optics, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_contextual_1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and IsBooleanDvarSet("tu12_zmEnableReticleCustomization") and CoD.CACUtility.IsAttachmentWithCustomReticle(menu, element) then
			CoD.CraftUtility.SetUpOpticPersonalization(element, controller)
			CoD.CACUtility.OpenCACAttachmentOverlay(self, element, menu, controller, "ReticleSelect", element, "primary")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and IsBooleanDvarSet("tu12_zmEnableReticleCustomization") and CoD.CACUtility.IsAttachmentWithCustomReticle(menu, element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_4AFF37175F950D17", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	Optics:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		local f21_local0 = Optics
		if not IsMouse(f1_arg1) and AlwaysFalse() then
			CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_arg0, f21_local0, f1_arg1, true)
		end
	end)
	Optics:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/remove", function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		if CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(f22_arg0, f22_arg2, f22_arg1) then
			return function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
				CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment(f23_arg0, f23_arg2, f23_arg1)
				PlaySoundAlias("uin_cac_attach_remove")
			end
		else
		end
	end)
	Optics:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_4AFF37175F950D17", function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
		if CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(f24_arg0, f24_arg2, f24_arg1) and not IsListElementChildInState(f24_arg0, "AttachmentSlot", "NotAvailable") and IsBooleanDvarSet("tu12_zmEnableReticleCustomization") and CoD.CACUtility.IsAttachmentWithCustomReticle(f24_arg1, f24_arg0) then
			return function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
				CoD.CraftUtility.SetUpOpticPersonalization(f25_arg0, f25_arg2)
				CoD.CACUtility.OpenCACAttachmentOverlay(self, f25_arg0, f25_arg1, f25_arg2, "ReticleSelect", f25_arg0, "primary")
			end
		else
		end
	end)
	self:addElement(Optics)
	self.Optics = Optics
	OpticAttachmentPip = CoD.Armory_AttachmentPip.new(f1_arg0, f1_arg1, 0.5, 0.5, -6, 6, 0, 0, 25, 37)
	OpticAttachmentPip:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not CoD.ZMLoadoutUtility.IsArmoryAnyOpticAttachmentEquipped(f1_arg1, menu)
			end,
		},
	})
	OpticAttachmentPip:linkToElementModel(OpticAttachmentPip, "itemIndex", true, function(model)
		f1_arg0:updateElementState(OpticAttachmentPip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	f1_local7 = OpticAttachmentPip
	f1_local5 = OpticAttachmentPip.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local7, f1_local8.armoryAttachmentUpdated, function(f30_arg0)
		f1_arg0:updateElementState(OpticAttachmentPip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "armoryAttachmentUpdated",
		})
	end, false)
	self:addElement(OpticAttachmentPip)
	self.OpticAttachmentPip = OpticAttachmentPip
	self.__on_menuOpened_self = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
		local f31_local0 = self
		ScaleToElementWidth(self, self.Optics, 30)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	Optics.id = "Optics"
	self.__defaultFocus = Optics
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = Optics
	if IsPC() then
		SetElementProperty(f1_local5, "_isOptic", true)
		CoD.WeaponAttachmentsUtility.UpdateHorizontalCount(f1_arg0, f1_local5, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local5, f1_arg1, "name", "", "")
	else
		SetElementProperty(f1_local5, "_isOptic", true)
		CoD.WeaponAttachmentsUtility.UpdateHorizontalCount(f1_arg0, f1_local5, f1_arg1)
	end
	return self
end
CoD.Armory_OpticsList.__onClose = function(f33_arg0)
	f33_arg0.__on_close_removeOverrides()
	f33_arg0.Optics:close()
	f33_arg0.OpticAttachmentPip:close()
end
