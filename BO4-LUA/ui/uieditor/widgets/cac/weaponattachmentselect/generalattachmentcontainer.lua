require("x64:8f124afe0474afa")
CoD.GeneralAttachmentContainer = InheritFrom(LUI.UIElement)
CoD.GeneralAttachmentContainer.__defaultWidth = 800
CoD.GeneralAttachmentContainer.__defaultHeight = 300
CoD.GeneralAttachmentContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GeneralAttachmentContainer)
	self.id = "GeneralAttachmentContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local AttachmentList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	AttachmentList:setLeftRight(0.5, 0.5, -295, 295)
	AttachmentList:setTopBottom(0, 0, 19, 209)
	AttachmentList:setScale(1.2, 1.2)
	AttachmentList:setWidgetType(CoD.AttachmentSlotContainer)
	AttachmentList:setHorizontalCount(4)
	AttachmentList:setVerticalCount(2)
	AttachmentList:setSpacing(10)
	AttachmentList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AttachmentList:setDataSource("WeaponAttachments")
	AttachmentList:linkToElementModel(AttachmentList, "isUberAttachment", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	AttachmentList:linkToElementModel(AttachmentList, "itemIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	AttachmentList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		CoD.CACUtility.UpdateWeaponAttachmentModel(f1_arg0, element, f1_arg1, true)
		CoD.BreadcrumbUtility.SetAttachmentAsOld(f1_arg0, element, f1_arg1)
		return f4_local0
	end)
	AttachmentList:registerEventHandler("lose_list_focus", function(element, event)
		local f5_local0 = nil
		CoD.CACUtility.UpdateWeaponAttachmentModel(f1_arg0, element, f1_arg1, false)
		CoD.WeaponAttachmentsUtility.ResetActiveListItemForList(self.AttachmentList, f1_arg1)
		return f5_local0
	end)
	AttachmentList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AttachmentList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isUberAttachment") and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.CACUtility.IsCACAttachmentItemLocked(menu, element, controller) then
			CoD.CACUtility.SetWeaponAttachmentItem(menu, self, element, controller, true)
			CoD.BreadcrumbUtility.UpdateWeaponOpticBreadcrumbs(menu, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isUberAttachment") and CoD.WeaponAttachmentsUtility.CanEquipUberAttachmentInSlot(menu) and not CoD.CACUtility.IsCACAttachmentItemLocked(menu, element, controller) then
			CoD.CACUtility.SetWeaponAttachmentItem(menu, self, element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isUberAttachment") and not IsListElementChildInState(element, "AttachmentSlot", "NotAvailable") and not CoD.CACUtility.IsCACAttachmentItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isUberAttachment") and CoD.WeaponAttachmentsUtility.CanEquipUberAttachmentInSlot(menu) and not CoD.CACUtility.IsCACAttachmentItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	AttachmentList:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		local f9_local0 = AttachmentList
		if not IsMouse(f1_arg1) then
			CoD.CACUtility.UpdateWeaponAttachmentModel(f1_arg0, f9_local0, f1_arg1, true)
		end
	end)
	self:addElement(AttachmentList)
	self.AttachmentList = AttachmentList
	self.__on_menuOpened_self = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		local f10_local0 = self
		ScaleToElementWidth(self, self.AttachmentList, 30)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	AttachmentList.id = "AttachmentList"
	self.__defaultFocus = AttachmentList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	f1_local2 = AttachmentList
	if IsPC() then
		CoD.WeaponAttachmentsUtility.UpdateHorizontalCount(f1_arg0, self.AttachmentList, f1_arg1)
		CoD.WeaponAttachmentsUtility.UpdateAttachmentFilter(f1_arg0, f1_local2, f1_arg1)
	else
		CoD.WeaponAttachmentsUtility.UpdateHorizontalCount(f1_arg0, self.AttachmentList, f1_arg1)
		CoD.WeaponAttachmentsUtility.UpdateAttachmentFilter(f1_arg0, f1_local2, f1_arg1)
	end
	return self
end
CoD.GeneralAttachmentContainer.__onClose = function(f12_arg0)
	f12_arg0.__on_close_removeOverrides()
	f12_arg0.AttachmentList:close()
end
