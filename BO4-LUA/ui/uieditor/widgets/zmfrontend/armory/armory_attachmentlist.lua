require("x64:a2607a18baf43e7")
require("x64:cd8d4b91f5f751a")
CoD.Armory_AttachmentList = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentList.__defaultWidth = 800
CoD.Armory_AttachmentList.__defaultHeight = 300
CoD.Armory_AttachmentList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_AttachmentList)
	self.id = "Armory_AttachmentList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackGradientBG = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 35, 31)
	BlackGradientBG:setRGB(0, 0, 0)
	BlackGradientBG:setAlpha(0.3)
	BlackGradientBG:setZRot(180)
	BlackGradientBG:setZoom(10)
	BlackGradientBG:setImage(RegisterImage(@"hash_78A6742E3F9A2ED"))
	self:addElement(BlackGradientBG)
	self.BlackGradientBG = BlackGradientBG
	local TopLine = LUI.UIImage.new(0, 1.01, -3, -5, 0, 0, 31, 49)
	TopLine:setAlpha(0.5)
	TopLine:setZoom(10)
	TopLine:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_line"))
	TopLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopLine)
	self.TopLine = TopLine
	local AttachmentHeader = LUI.UIText.new(0.5, 0.5, -392.5, 392.5, 0, 0, -8, 10)
	AttachmentHeader:setRGB(0.39, 0.39, 0.39)
	AttachmentHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_56E6F15BA89EEED"))
	AttachmentHeader:setTTF("ttmussels_demibold")
	AttachmentHeader:setLetterSpacing(4)
	AttachmentHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	AttachmentHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AttachmentHeader)
	self.AttachmentHeader = AttachmentHeader
	local Attachments = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, false, false, false, false)
	Attachments:setLeftRight(0.5, 0.5, -318.5, 318.5)
	Attachments:setTopBottom(0, 0, 40, 279)
	Attachments:setZoom(13)
	Attachments:setWidgetType(CoD.Armory_AttachmentSlotContainer)
	Attachments:setHorizontalCount(4)
	Attachments:setVerticalCount(2)
	Attachments:setSpacing(15)
	Attachments:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachments:setFilter(function(f2_arg0)
		return f2_arg0.attachmentGroup:get() ~= Enum[@"eattachmentgroup"][@"attachment_group_optic"]
	end)
	Attachments:setDataSource("ArmoryWeaponAttachments")
	Attachments:linkToElementModel(Attachments, "itemIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end)
	local f1_local5 = Attachments
	local ArmoryAttachmentPipContainer = Attachments.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	ArmoryAttachmentPipContainer(f1_local5, f1_local7.armoryAttachmentUpdated, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	Attachments:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end)
	f1_local5 = Attachments
	ArmoryAttachmentPipContainer = Attachments.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	ArmoryAttachmentPipContainer(f1_local5, f1_local7.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	Attachments:registerEventHandler("list_item_gain_focus", function(element, event)
		local f7_local0 = nil
		CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_arg0, element, f1_arg1, true)
		CoD.ZMLoadoutUtility.UpdateAttachmentListModelForWeaponAttributes(f1_arg0, self.Attachments, f1_arg1)
		return f7_local0
	end)
	Attachments:registerEventHandler("lose_list_focus", function(element, event)
		local f8_local0 = nil
		CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_arg0, element, f1_arg1, false)
		CoD.WeaponAttachmentsUtility.ResetActiveListItemForList(element, f1_arg1)
		CoD.ZMLoadoutUtility.ResetAttachmentListModelForWeaponAttributes(f1_arg0, f1_arg0, f1_arg1)
		return f8_local0
	end)
	Attachments:registerEventHandler("gain_list_focus", function(element, event)
		return nil
	end)
	Attachments:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Attachments, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and not CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and CoD.ZMLoadoutUtility.CanArmoryElementAttachmentBeEquipped(element, controller, menu) then
			CoD.ZMLoadoutUtility.EquipArmoryElementAttachment(element, controller, menu)
			return true
		elseif IsPC() and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and CoD.ZMLoadoutUtility.CanArmoryElementAttachmentBeEquipped(element, controller, menu) and not CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.ZMLoadoutUtility.EquipArmoryElementAttachment(element, controller, menu)
			return true
		elseif IsPC() and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment(element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and not CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and CoD.ZMLoadoutUtility.CanArmoryElementAttachmentBeEquipped(element, controller, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsPC() and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) and CoD.ZMLoadoutUtility.CanArmoryElementAttachmentBeEquipped(element, controller, menu) and not CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsPC() and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) and not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Attachments, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment(element, controller, menu)
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
	f1_arg0:AddButtonCallbackFunction(Attachments, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, controller, menu) then
			CoD.ZMLoadoutUtility.RemoveArmoryElementAttachment(element, controller, menu)
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
	Attachments:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		local f17_local0 = Attachments
		if IsMouse(f1_arg1) and AlwaysFalse() then
			CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_arg0, f17_local0, f1_arg1, false)
			CoD.WeaponAttachmentsUtility.ResetActiveListItemForList(f17_local0, f1_arg1)
		elseif not IsMouse(f1_arg1) and AlwaysFalse() then
			CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_arg0, f17_local0, f1_arg1, true)
		end
	end)
	self:addElement(Attachments)
	self.Attachments = Attachments
	ArmoryAttachmentPipContainer = CoD.Armory_AttachmentPipContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -43.5, 43.5, 0, 0, 25, 37)
	ArmoryAttachmentPipContainer:mergeStateConditions({
		{
			stateName = "FourSlots",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "FourSlotsHideOptic",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsWeaponAttachmentPipFourSlots(menu, element)
			end,
		},
		{
			stateName = "HideOptic",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ArmoryAttachmentPipContainer:linkToElementModel(ArmoryAttachmentPipContainer, "showAttachmentPips", true, function(model)
		f1_arg0:updateElementState(ArmoryAttachmentPipContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showAttachmentPips",
		})
	end)
	ArmoryAttachmentPipContainer:linkToElementModel(self, nil, false, function(model)
		ArmoryAttachmentPipContainer:setModel(model, f1_arg1)
	end)
	self:addElement(ArmoryAttachmentPipContainer)
	self.ArmoryAttachmentPipContainer = ArmoryAttachmentPipContainer
	self:mergeStateConditions({
		{
			stateName = "UberInList",
			condition = function(menu, element, event)
				return CoD.WeaponAttachmentsUtility.DoesWeaponHaveUberAttachment(menu, element)
			end,
		},
	})
	self.__on_menuOpened_self = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
		local f24_local0 = self
		ScaleToElementWidth(self, self.Attachments, 30)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	Attachments.id = "Attachments"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = Attachments
	CoD.WeaponAttachmentsUtility.UpdateHorizontalCount(f1_arg0, self.Attachments, f1_arg1)
	return self
end
CoD.Armory_AttachmentList.__resetProperties = function(f26_arg0)
	f26_arg0.AttachmentHeader:completeAnimation()
	f26_arg0.AttachmentHeader:setLeftRight(0.5, 0.5, -392.5, 392.5)
end
CoD.Armory_AttachmentList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
	},
	UberInList = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.AttachmentHeader:completeAnimation()
			f28_arg0.AttachmentHeader:setLeftRight(0.5, 0.5, -563.5, 221.5)
			f28_arg0.clipFinished(f28_arg0.AttachmentHeader)
		end,
	},
}
CoD.Armory_AttachmentList.__onClose = function(f29_arg0)
	f29_arg0.__on_close_removeOverrides()
	f29_arg0.Attachments:close()
	f29_arg0.ArmoryAttachmentPipContainer:close()
end
