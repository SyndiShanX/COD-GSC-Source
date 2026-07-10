require("x64:351793fe51beaa2")
require("x64:bf776923c7291f4")
CoD.StartMenu_InventoryList = InheritFrom(LUI.UIElement)
CoD.StartMenu_InventoryList.__defaultWidth = 540
CoD.StartMenu_InventoryList.__defaultHeight = 239
CoD.StartMenu_InventoryList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_InventoryList)
	self.id = "StartMenu_InventoryList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, -0.1, 0.9, 37, 5)
	Backing:setRGB(0.45, 0.45, 0.45)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local BottomBracket9Slice = LUI.UIImage.new(0, 0, 1, 560, 0, 0, -7, 2)
	BottomBracket9Slice:setRGB(0.55, 0.54, 0.49)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local Title = LUI.UIText.new(0, 0, 17.5, 117.5, 0, 0, -4.5, 17.5)
	Title:setRGB(0, 0, 0)
	Title:setText(LocalizeToUpperString(@"warzone/inventory"))
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
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	List:setLeftRight(0, 0, 0, 560)
	List:setTopBottom(0, 0, 27, 239)
	List:setWidgetType(CoD.WarzoneInventoryMenuItemSmall)
	List:setHorizontalCount(5)
	List:setVerticalCount(2)
	List:setSpacing(20)
	List:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	List:setDataSource("WarzoneInventory")
	List:linkToElementModel(List, "id", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	List:linkToElementModel(List, "availableAction", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	List:linkToElementModel(List, "type", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
	end)
	local f1_local5 = List
	local f1_local6 = List.subscribeToModel
	local f1_local7 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	f1_local6(f1_local5, f1_local7.isInVehicle, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.0"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.1"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.2"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.3"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.4"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	List:linkToElementModel(List, "castTime", true, function(model, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.showAttachments, function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	List:linkToElementModel(List, "stackCount", true, function(model, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	List:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	List:linkToElementModel(List, "stowedAvailableAction", true, function(model, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
	end)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.inventory.quickConsumeNetworkId"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	List:registerEventHandler("list_active_changed", function(element, event)
		local f18_local0 = nil
		CoD.GridAndListUtility.AlignElementToListItem2D(f1_arg1, element, self.InventorySplitter)
		return f18_local0
	end)
	List:registerEventHandler("list_item_gain_focus", function(element, event)
		local f19_local0 = nil
		CoD.WZUtility.SendInventoryItemFocusNotify(f1_arg1, element)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg1, self, element)
		return f19_local0
	end)
	List:registerEventHandler("lose_list_focus", function(element, event)
		local f20_local0 = nil
		CoD.WZUtility.SendInventoryItemFocusNoneNotify(f1_arg1)
		return f20_local0
	end)
	List:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f21_local0
	end)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "killstreak") and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "showAttachments") and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.EQUIP) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "killstreak") and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 4000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 5000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 6000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "showAttachments") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"warzone/attach", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.EQUIP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"warzone/equip", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not IsPC() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.SetupSplitCount(controller, element)
			MenuHidesFreeCursor(menu, controller)
			SetElementState(self, self.InventorySplitter, controller, "Open")
			SetLoseFocusToElement(self, "List", controller)
			SetFocusToElement(self, "InventorySplitter", controller)
			return true
		elseif IsPC() and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not IsPC() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsPC() and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_144DB3A08BE7FB92", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_144DB3A08BE7FB92", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "F", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_144DB3A08BE7FB92", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_144DB3A08BE7FB92", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.EQUIP) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "showAttachments") then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			CoD.WZUtility.SendInventoryConsumeNotify(controller, element)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.EQUIP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"menu/equip", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "showAttachments") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"warzone/attach", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"menu/use", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"menu/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.EQUIP) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "showAttachments") then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			CoD.WZUtility.SendInventoryConsumeNotify(controller, element)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.EQUIP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "showAttachments") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "MOUSE3", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and not CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(self, controller, "hudItems.inventory.quickConsumeNetworkId", "id") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "generic") then
			CoD.WZUtility.SendInventoryEquipCurrentConsumable(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"wz/swap_stowed", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"wz/transfer_stowed", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and not CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(self, controller, "hudItems.inventory.quickConsumeNetworkId", "id") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "generic") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_42900747B42A56BA", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
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
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_1", function(element, menu, controller, model)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"wz/swap_stowed", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"wz/transfer_stowed", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/use", function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f40_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f40_arg0, f40_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f40_arg0, f40_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			return function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
				CoD.WZUtility.SendInventoryConsumeNotify(f41_arg2, f41_arg0)
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/attach", function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f42_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f42_arg0, f42_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f42_arg0, f42_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f42_arg2, "WarzoneInventory", "showAttachments") then
			return function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
				CoD.WZUtility.SendInventoryEquipNotify(f43_arg2, f43_arg0, f43_arg1, false)
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/swap", function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f44_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f44_arg0, f44_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f44_arg0, f44_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			return function(f45_arg0, f45_arg1, f45_arg2, f45_arg3)
				CoD.WZUtility.SendInventoryEquipNotify(f45_arg2, f45_arg0, f45_arg1, false)
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/equip", function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f46_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f46_arg0, f46_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f46_arg0, f46_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.EQUIP) then
			return function(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
				CoD.WZUtility.SendInventoryEquipNotify(f47_arg2, f47_arg0, f47_arg1, false)
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_144DB3A08BE7FB92", function(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f48_arg0, f48_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f48_arg0, f48_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f48_arg2) then
			return function(f49_arg0, f49_arg1, f49_arg2, f49_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f49_arg2, f49_arg0)
				CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f50_arg0, f50_arg1, f50_arg2, f50_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f50_arg0, f50_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f50_arg0, f50_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f50_arg2) then
			return function(f51_arg0, f51_arg1, f51_arg2, f51_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f51_arg2, f51_arg0)
				CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/split", function(f52_arg0, f52_arg1, f52_arg2, f52_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f52_arg0, f52_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(f52_arg0, f52_arg2, "stackCount", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f52_arg2) then
			return function(f53_arg0, f53_arg1, f53_arg2, f53_arg3)
				CoD.WZUtility.OpenPCSplitterWidgetForElement(self, f53_arg1, f53_arg2, f53_arg0)
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"wz/swap_stowed", function(f54_arg0, f54_arg1, f54_arg2, f54_arg3)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f54_arg0, f54_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f54_arg2) and IsMouseOrKeyboard(f54_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f54_arg0, f54_arg2, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f54_arg0, f54_arg2, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.SWAP) then
			return function(f55_arg0, f55_arg1, f55_arg2, f55_arg3)
				CoD.WZUtility.SendInventoryEquipOnWeaponNotify(f55_arg2, f55_arg0, f55_arg1, false, true)
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"wz/transfer_stowed", function(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f56_arg0, f56_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f56_arg2) and IsMouseOrKeyboard(f56_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f56_arg0, f56_arg2, "type", "attachment") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f56_arg0, f56_arg2, "stowedAvailableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			return function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
				CoD.WZUtility.SendInventoryEquipOnWeaponNotify(f57_arg2, f57_arg0, f57_arg1, false, true)
			end
		else
		end
	end)
	self:addElement(List)
	self.List = List
	f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.InventorySplitter = f1_local6
	self:mergeStateConditions({
		{
			stateName = "ExtraStorageVisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.inventory.count", CoD.WZUtility.InventorySize.ITEM_WORLD_PLAYER_INVENTORY_SIZE)
			end,
		},
	})
	f1_local7 = self
	f1_local5 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local7, f1_local8["hudItems.inventory.count"], function(f59_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f59_arg0:get(),
			modelName = "hudItems.inventory.count",
		})
	end, false)
	self.__on_onStartMenuOpened_self = function(f60_arg0, f60_arg1)
		local f60_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.List, false, false, true)
	end
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f61_arg2, f61_arg3, f61_arg4)
		CoD.GridAndListUtility.UpdateDataSource(self.List, false, false, true)
	end)
	List.id = "List"
	f1_local6.id = "InventorySplitter"
	self.__defaultFocus = List
	self.__on_close_removeOverrides = function()
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_self)
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuClosed", self.__on_onStartMenuClosed_InventorySplitter)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = List
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local5, f1_arg1, "name", "", "")
	end
	return self
end
CoD.StartMenu_InventoryList.__resetProperties = function(f63_arg0)
	f63_arg0.List:completeAnimation()
	f63_arg0.Title:completeAnimation()
	f63_arg0.BottomBracket9Slice:completeAnimation()
	f63_arg0.InventorySplitter:completeAnimation()
	f63_arg0.Backing:completeAnimation()
	f63_arg0.List:setTopBottom(0, 0, 27, 239)
	f63_arg0.Title:setTopBottom(0, 0, -4.5, 17.5)
	f63_arg0.Title:setText(LocalizeToUpperString(@"warzone/inventory"))
	f63_arg0.BottomBracket9Slice:setTopBottom(0, 0, -7, 2)
	f63_arg0.InventorySplitter:setTopBottom(0, 0, 0, 50)
	f63_arg0.Backing:setTopBottom(-0.1, 0.9, 37, 5)
end
CoD.StartMenu_InventoryList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(4)
			f64_arg0.Backing:completeAnimation()
			f64_arg0.Backing:setTopBottom(-0.1, 0.9, 73, 41)
			f64_arg0.clipFinished(f64_arg0.Backing)
			f64_arg0.BottomBracket9Slice:completeAnimation()
			f64_arg0.BottomBracket9Slice:setTopBottom(0, 0, 73, 82)
			f64_arg0.clipFinished(f64_arg0.BottomBracket9Slice)
			f64_arg0.Title:completeAnimation()
			f64_arg0.Title:setTopBottom(0, 0, 76, 100)
			f64_arg0.clipFinished(f64_arg0.Title)
			f64_arg0.List:completeAnimation()
			f64_arg0.List:setTopBottom(0, 0, 115.5, 211.5)
			f64_arg0.clipFinished(f64_arg0.List)
			f64_arg0.InventorySplitter:completeAnimation()
			f64_arg0.InventorySplitter:setTopBottom(0, 0, 97.5, 147.5)
			f64_arg0.clipFinished(f64_arg0.InventorySplitter)
		end,
	},
	ExtraStorageVisible = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(2)
			f65_arg0.BottomBracket9Slice:completeAnimation()
			f65_arg0.BottomBracket9Slice:setTopBottom(0, 0, -13, -4)
			f65_arg0.clipFinished(f65_arg0.BottomBracket9Slice)
			f65_arg0.Title:completeAnimation()
			f65_arg0.Title:setTopBottom(0, 0, -10.5, 11.5)
			f65_arg0.Title:setText(LocalizeToUpperString(@"warzone/backpack"))
			f65_arg0.clipFinished(f65_arg0.Title)
		end,
	},
}
CoD.StartMenu_InventoryList.__onClose = function(f66_arg0)
	f66_arg0.__on_close_removeOverrides()
	f66_arg0.List:close()
	f66_arg0.InventorySplitter:close()
end
