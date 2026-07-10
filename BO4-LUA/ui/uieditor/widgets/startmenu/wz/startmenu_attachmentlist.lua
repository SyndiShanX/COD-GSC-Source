require("x64:e8dbd840828bc3")
CoD.StartMenu_AttachmentList = InheritFrom(LUI.UIElement)
CoD.StartMenu_AttachmentList.__defaultWidth = 652
CoD.StartMenu_AttachmentList.__defaultHeight = 124
CoD.StartMenu_AttachmentList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_AttachmentList)
	self.id = "StartMenu_AttachmentList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	f1_local1 = LUI.UIElement.createFake()
	self.WeaponAttachments = f1_local1
	local f1_local2 = nil
	local WeaponAttachmentsPC = LUI.UIList.new(f1_arg0, f1_arg1, 42, 0, nil, false, false, false, false)
	WeaponAttachmentsPC:setLeftRight(0.5, 0.5, -174, 186)
	WeaponAttachmentsPC:setTopBottom(0, 0, 0, 222)
	WeaponAttachmentsPC:setAlpha(0)
	WeaponAttachmentsPC:setWidgetType(CoD.WarzoneInventoryMenuItem)
	WeaponAttachmentsPC:setHorizontalCount(3)
	WeaponAttachmentsPC:setVerticalCount(2)
	WeaponAttachmentsPC:setSpacing(42)
	WeaponAttachmentsPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WeaponAttachmentsPC:setDataSource("WarzoneAttachments")
	WeaponAttachmentsPC:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	local HeaderImage = WeaponAttachmentsPC
	local Title = WeaponAttachmentsPC.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	Title(HeaderImage, f1_local6.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	WeaponAttachmentsPC:linkToElementModel(WeaponAttachmentsPC, "id", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	HeaderImage = WeaponAttachmentsPC
	Title = WeaponAttachmentsPC.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	Title(HeaderImage, f1_local6["hudItems.inventory.count"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	HeaderImage = WeaponAttachmentsPC
	Title = WeaponAttachmentsPC.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	Title(HeaderImage, f1_local6["hudItems.inventory.filledSlots"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	HeaderImage = WeaponAttachmentsPC
	Title = WeaponAttachmentsPC.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	Title(HeaderImage, f1_local6["hudItems.inventory.shard0.stackCount"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	WeaponAttachmentsPC:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/detach", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsPC, f1_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lstick_pressed"], @"menu/detach", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsPC, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"menu/detach", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsPC, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsPC, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	WeaponAttachmentsPC:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/detach", function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f23_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f23_arg0, f23_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(f23_arg2) then
			return function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
				CoD.WZUtility.SendInventoryDetachNotify(f24_arg2, f24_arg0)
			end
		else
		end
	end)
	WeaponAttachmentsPC:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f25_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f25_arg0, f25_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f26_arg2, f26_arg0)
			end
		else
		end
	end)
	self:addElement(WeaponAttachmentsPC)
	self.WeaponAttachmentsPC = WeaponAttachmentsPC
	Title = LUI.UIText.new(0, 0, 8, 108, 0, 0, -27.5, -3.5)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setAlpha(0)
	Title:setText(LocalizeToUpperString(@"menu/attachments"))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Title)
	self.Title = Title
	HeaderImage = LUI.UIImage.new(1, 1, -80.5, -16.5, 0, 0, -47.5, 16.5)
	HeaderImage:setAlpha(0)
	HeaderImage:setImage(RegisterImage(@"blacktransparent"))
	self:addElement(HeaderImage)
	self.HeaderImage = HeaderImage
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local1.id = "WeaponAttachments"
	WeaponAttachmentsPC.id = "WeaponAttachmentsPC"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	f1_local6 = f1_local1
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local6, f1_arg1, "name", "", "")
	end
	f1_local6 = WeaponAttachmentsPC
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local6, f1_arg1, "name", "", "")
	end
	return self
end
CoD.StartMenu_AttachmentList.__resetProperties = function(f28_arg0)
	f28_arg0.WeaponAttachments:completeAnimation()
	f28_arg0.WeaponAttachmentsPC:completeAnimation()
	f28_arg0.WeaponAttachments:setAlpha(1)
	f28_arg0.WeaponAttachmentsPC:setAlpha(0)
end
CoD.StartMenu_AttachmentList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			f30_arg0.WeaponAttachments:completeAnimation()
			f30_arg0.WeaponAttachments:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WeaponAttachments)
			f30_arg0.WeaponAttachmentsPC:completeAnimation()
			f30_arg0.WeaponAttachmentsPC:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.WeaponAttachmentsPC)
		end,
	},
}
CoD.StartMenu_AttachmentList.__onClose = function(f31_arg0)
	f31_arg0.WeaponAttachments:close()
	f31_arg0.WeaponAttachmentsPC:close()
end
