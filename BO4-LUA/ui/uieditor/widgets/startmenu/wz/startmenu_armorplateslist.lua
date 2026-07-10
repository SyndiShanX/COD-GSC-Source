require("x64:351793fe51beaa2")
require("x64:bf776923c7291f4")
CoD.StartMenu_ArmorPlatesList = InheritFrom(LUI.UIElement)
CoD.StartMenu_ArmorPlatesList.__defaultWidth = 215
CoD.StartMenu_ArmorPlatesList.__defaultHeight = 124
CoD.StartMenu_ArmorPlatesList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ArmorPlatesList)
	self.id = "StartMenu_ArmorPlatesList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 0.4, 0, 0, -0.1, 0.5, 37, 5)
	Backing:setRGB(0.45, 0.45, 0.45)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local BottomBracket9Slice = LUI.UIImage.new(0, 0, 1, 209, 0, 0, -7, 2)
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
	Title:setText(LocalizeToUpperString(@"hash_5FF2F205B4F34F1D"))
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
	List:setLeftRight(0, 0, 0, 212)
	List:setTopBottom(0, 0, 28, 124)
	List:setWidgetType(CoD.WarzoneInventoryMenuItemSmall)
	List:setHorizontalCount(2)
	List:setSpacing(20)
	List:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	List:setDataSource("WarzoneShards")
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
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end)
	List:linkToElementModel(List, "castTime", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local f1_local5 = List
	local f1_local6 = List.subscribeToModel
	local f1_local7 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.armorType, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	f1_local6(f1_local5, f1_local7.armor, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	f1_local6(f1_local5, f1_local7.armorMax, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	f1_local6(f1_local5, f1_local7.isInVehicle, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.0"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.1"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.2"], function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.3"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.seatOccupantClientNum.4"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	List:linkToElementModel(List, "stackCount", true, function(model, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	List:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	f1_local5 = List
	f1_local6 = List.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	List:registerEventHandler("list_active_changed", function(element, event)
		local f17_local0 = nil
		CoD.GridAndListUtility.AlignElementToListItem2D(f1_arg1, element, self.InventorySplitter)
		return f17_local0
	end)
	List:registerEventHandler("list_item_gain_focus", function(element, event)
		local f18_local0 = nil
		CoD.WZUtility.SendInventoryItemFocusNotify(f1_arg1, element)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg1, self, element)
		return f18_local0
	end)
	List:registerEventHandler("lose_list_focus", function(element, event)
		local f19_local0 = nil
		CoD.WZUtility.SendInventoryItemFocusNoneNotify(f1_arg1)
		return f19_local0
	end)
	List:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 4000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 2500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 5000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 6000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_confirm")
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
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
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
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_144DB3A08BE7FB92", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) then
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
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) then
			CoD.WZUtility.SendInventoryConsumeNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) then
			CoD.WZUtility.SendInventoryConsumeNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) then
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
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 0) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"wz/repair_armor", function(f37_arg0, f37_arg1, f37_arg2, f37_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f37_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f37_arg0, f37_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f37_arg0, f37_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f37_arg2, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(f37_arg2) then
			return function(f38_arg0, f38_arg1, f38_arg2, f38_arg3)
				CoD.WZUtility.SendInventoryConsumeNotify(f38_arg2, f38_arg0)
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f39_arg0, f39_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f39_arg0, f39_arg2, "availableAction", CoD.WZUtility.ItemAvailableAction.DISCARD) and CoD.ModelUtility.IsSelfModelValueGreaterThan(f39_arg0, f39_arg2, "stackCount", 0) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f39_arg2) then
			return function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f40_arg2, f40_arg0)
				CoD.WZUtility.HackUpdateListDataSourceAfterDelay(self.List, true, false, true, "500")
			end
		else
		end
	end)
	List:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/split", function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f41_arg0, f41_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(f41_arg0, f41_arg2, "stackCount", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f41_arg2) then
			return function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
				CoD.WZUtility.OpenPCSplitterWidgetForElement(self, f42_arg1, f42_arg2, f42_arg0)
			end
		else
		end
	end)
	self:addElement(List)
	self.List = List
	f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.InventorySplitter = f1_local6
	self.__on_onStartMenuOpened_self = function(f43_arg0, f43_arg1)
		local f43_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.List, false, false, true)
	end
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f44_arg2, f44_arg3, f44_arg4)
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
CoD.StartMenu_ArmorPlatesList.__resetProperties = function(f46_arg0)
	f46_arg0.List:completeAnimation()
	f46_arg0.Title:completeAnimation()
	f46_arg0.BottomBracket9Slice:completeAnimation()
	f46_arg0.InventorySplitter:completeAnimation()
	f46_arg0.Backing:completeAnimation()
	f46_arg0.List:setTopBottom(0, 0, 28, 124)
	f46_arg0.Title:setTopBottom(0, 0, -4.5, 17.5)
	f46_arg0.BottomBracket9Slice:setTopBottom(0, 0, -7, 2)
	f46_arg0.InventorySplitter:setTopBottom(0, 0, 0, 50)
	f46_arg0.Backing:setTopBottom(-0.1, 0.5, 37, 5)
end
CoD.StartMenu_ArmorPlatesList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			f47_arg0.Backing:completeAnimation()
			f47_arg0.Backing:setTopBottom(-0.1, 0.9, 73, 41)
			f47_arg0.clipFinished(f47_arg0.Backing)
			f47_arg0.BottomBracket9Slice:completeAnimation()
			f47_arg0.BottomBracket9Slice:setTopBottom(0, 0, 73, 82)
			f47_arg0.clipFinished(f47_arg0.BottomBracket9Slice)
			f47_arg0.Title:completeAnimation()
			f47_arg0.Title:setTopBottom(0, 0, 76, 100)
			f47_arg0.clipFinished(f47_arg0.Title)
			f47_arg0.List:completeAnimation()
			f47_arg0.List:setTopBottom(0, 0, 115.5, 211.5)
			f47_arg0.clipFinished(f47_arg0.List)
			f47_arg0.InventorySplitter:completeAnimation()
			f47_arg0.InventorySplitter:setTopBottom(0, 0, 97.5, 147.5)
			f47_arg0.clipFinished(f47_arg0.InventorySplitter)
		end,
	},
}
CoD.StartMenu_ArmorPlatesList.__onClose = function(f48_arg0)
	f48_arg0.__on_close_removeOverrides()
	f48_arg0.List:close()
	f48_arg0.InventorySplitter:close()
end
