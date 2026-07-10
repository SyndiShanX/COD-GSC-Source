require("x64:a1884ee33b19dc2")
require("x64:bf776923c7291f4")
CoD.StartMenu_AmmoList = InheritFrom(LUI.UIElement)
CoD.StartMenu_AmmoList.__defaultWidth = 220
CoD.StartMenu_AmmoList.__defaultHeight = 752
CoD.StartMenu_AmmoList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_AmmoList)
	self.id = "StartMenu_AmmoList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	List:setLeftRight(0, 0, -1, 203)
	List:setTopBottom(0, 0, 38, 458)
	List:setWidgetType(CoD.WarzoneInventoryAmmoItem)
	List:setHorizontalCount(2)
	List:setVerticalCount(4)
	List:setSpacing(20)
	List:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	List:setDataSource("WZAmmoPool")
	List:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	local BottomBracket9Slice = List
	local HeaderImage = List.subscribeToModel
	local Title = Engine[@"getmodelforcontroller"](f1_arg1)
	HeaderImage(BottomBracket9Slice, Title.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	List:linkToElementModel(List, "id", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	List:linkToElementModel(List, "stackCount", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	List:registerEventHandler("list_active_changed", function(element, event)
		local f6_local0 = nil
		CoD.GridAndListUtility.AlignElementToListItem2D(f1_arg1, element, self.InventorySplitter)
		return f6_local0
	end)
	List:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "F", function(element, menu, controller, model)
		if not IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.SetupSplitCount(controller, element)
			MenuHidesFreeCursor(menu, controller)
			SetElementState(self, self.InventorySplitter, controller, "Open")
			SetLoseFocusToElement(self, "List", controller)
			SetFocusToElement(self, "InventorySplitter", controller)
			return true
		elseif IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "F")
			return true
		elseif IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "F")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "F", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "MOUSE3", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f20_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f20_arg0, f20_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(f20_arg0, f20_arg2, "stackCount", 0) then
			return function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f21_arg2, f21_arg0)
				CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/split", function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f22_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f22_arg0, f22_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(f22_arg0, f22_arg2, "stackCount", 1) then
			return function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
				CoD.WZUtility.OpenPCSplitterWidgetForElement(self, f23_arg1, f23_arg2, f23_arg0)
			end
		else
		end
	end)
	self:addElement(List)
	self.List = List
	HeaderImage = LUI.UIImage.new(1, 1, -64, 0, 0, 0, 0, 64)
	HeaderImage:setAlpha(0)
	HeaderImage:setImage(RegisterImage(@"blacktransparent"))
	self:addElement(HeaderImage)
	self.HeaderImage = HeaderImage
	BottomBracket9Slice = LUI.UIImage.new(0, 0, -1, 203, 0, 0, -1, 8)
	BottomBracket9Slice:setRGB(0.55, 0.54, 0.49)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	Title = LUI.UIText.new(0, 0, 15, 115, 0, 0, 2, 24)
	Title:setRGB(0, 0, 0)
	Title:setText(LocalizeToUpperString(@"warzone/ammo"))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setBackingType(1)
	Title:setBackingWidget(CoD.WZBox9Slice, f1_arg0, f1_arg1)
	Title:setBackingColor(0.55, 0.54, 0.49)
	Title:setBackingXPadding(16)
	Title:setBackingYPadding(2)
	self:addElement(Title)
	self.Title = Title
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.InventorySplitter = f1_local5
	self:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "isOpen", function(model)
		local f24_local0 = self
		if CoD.WZUtility.IsInventoryOpen(f1_arg1) then
			CoD.GridAndListUtility.UpdateDataSource(self.List, false, false, true)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.multiItemPickup.forceNotifyAmmoList", function(model)
		local f25_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.List, false, false, true)
	end)
	List.id = "List"
	f1_local5.id = "InventorySplitter"
	self.__defaultFocus = List
	self.__on_close_removeOverrides = function()
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuClosed", self.__on_onStartMenuClosed_InventorySplitter)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	f1_local6 = List
	if IsPC() then
		DisableAutoButtonCallback(f1_arg0, f1_local6, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local6, f1_arg1, "name", "", "")
	end
	return self
end
CoD.StartMenu_AmmoList.__onClose = function(f27_arg0)
	f27_arg0.__on_close_removeOverrides()
	f27_arg0.List:close()
	f27_arg0.InventorySplitter:close()
end
