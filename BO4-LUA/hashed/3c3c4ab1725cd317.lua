require("x64:325eec9c0fe7758")
require("x64:c0436d48eab47f9")
require("x64:2435be124ae6695")
CoD.WarzoneQuickInventoryShardItem = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickInventoryShardItem.__defaultWidth = 70
CoD.WarzoneQuickInventoryShardItem.__defaultHeight = 70
CoD.WarzoneQuickInventoryShardItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickInventoryShardItem)
	self.id = "WarzoneQuickInventoryShardItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ActiveBG = LUI.UIImage.new(0.5, 0.5, -44, 44, 0.5, 0.5, -44.5, 43.5)
	ActiveBG:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ActiveBG:setAlpha(0)
	ActiveBG:setScale(0.9, 0.9)
	ActiveBG:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_glow"))
	ActiveBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ActiveBG:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(ActiveBG)
	self.ActiveBG = ActiveBG
	local Button = CoD.WarzoneInventoryMenuItemSmall_Internal_QE.new(f1_arg0, f1_arg1, 0.5, 0.5, -44, 44, 0.5, 0.5, -45, 43)
	Button:setScale(0.9, 0.9)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	Button:linkToElementModel(Button, "id", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	Button:linkToElementModel(Button, "availableAction", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	Button:linkToElementModel(Button, "castTime", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local SquarePrompt = Button
	local ConsumedProgress = Button.subscribeToModel
	local FocusSound = DataSources.HUDItems.getModel(f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound.armorType, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	ConsumedProgress(SquarePrompt, FocusSound.armor, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	ConsumedProgress(SquarePrompt, FocusSound.armorMax, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	ConsumedProgress(SquarePrompt, FocusSound.isInVehicle, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.0"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.1"], function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.2"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.3"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.4"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["hudItems.inventory.open"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	Button:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Button, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 4000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 5000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"wz/repair_armor", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 6000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif CoD.WZUtility.IsQuickInventoryOpen(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return false
		else
			return false
		end
	end, false)
	Button:linkToElementModel(self, "name", true, function(model)
		local f19_local0 = Button
		CoD.WZUtility.UpdateSelectedItemName(f1_arg0, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	ConsumedProgress = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -24, 24)
	ConsumedProgress:setRGB(0, 0, 0)
	ConsumedProgress:setAlpha(0.8)
	ConsumedProgress:setScale(1.26, 1.26)
	ConsumedProgress:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	ConsumedProgress:setShaderVector(1, 0.5, 0, 0, 0)
	ConsumedProgress:setShaderVector(2, 0.5, 0, 0, 0)
	ConsumedProgress:setShaderVector(3, 0, 0, 0, 0)
	ConsumedProgress:setShaderVector(4, 0, 0, 0, 0)
	ConsumedProgress:linkToElementModel(self, "endStartFraction", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			ConsumedProgress:setShaderVector(0, CoD.GetVectorComponentFromString(f20_local0, 1), CoD.GetVectorComponentFromString(f20_local0, 2), CoD.GetVectorComponentFromString(f20_local0, 3), CoD.GetVectorComponentFromString(f20_local0, 4))
		end
	end)
	self:addElement(ConsumedProgress)
	self.ConsumedProgress = ConsumedProgress
	SquarePrompt = CoD.WarzoneQuickInventoryUsePrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, -36, 0)
	SquarePrompt:setAlpha(0)
	self:addElement(SquarePrompt)
	self.SquarePrompt = SquarePrompt
	FocusSound = LUI.UIElement.new(0, 0, 95.5, 127.5, 0, 0, 55.5, 87.5)
	self:addElement(FocusSound)
	self.FocusSound = FocusSound
	local Bar = LUI.UIImage.new(0, 0, 22, 46, 0, 0, 45.5, 77.5)
	Bar:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_selected_bar"))
	Bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bar)
	self.Bar = Bar
	local EMP = CoD.Warzone_EMP_QuickEquip.new(f1_arg0, f1_arg1, 0, 0, -13, 75, 0, 0, -6.5, 77.5)
	self:addElement(EMP)
	self.EMP = EMP
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
		{
			stateName = "RightScreenEdge",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "type", "attachment")
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	self:linkToElementModel(self, "type", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "type",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.WZUtility.ResetQuickInventoryAutoCloseTimer(f1_arg0, f1_arg1)
	end)
	Button.id = "Button"
	SquarePrompt:appendEventHandler("menu_loaded", function()
		SquarePrompt:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	SquarePrompt.id = "SquarePrompt"
	self.__defaultFocus = Button
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneQuickInventoryShardItem.__resetProperties = function(f28_arg0)
	f28_arg0.Bar:completeAnimation()
	f28_arg0.Button:completeAnimation()
	f28_arg0.ActiveBG:completeAnimation()
	f28_arg0.SquarePrompt:completeAnimation()
	f28_arg0.FocusSound:completeAnimation()
	f28_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
	f28_arg0.Bar:setAlpha(1)
	f28_arg0.Bar:setScale(1, 1)
	f28_arg0.Button:setScale(0.9, 0.9)
	f28_arg0.ActiveBG:setAlpha(0)
	f28_arg0.ActiveBG:setScale(0.9, 0.9)
	f28_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -75, 75)
	f28_arg0.SquarePrompt:setAlpha(0)
	f28_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	f28_arg0.FocusSound:setPlaySoundDirect(false)
end
CoD.WarzoneQuickInventoryShardItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.Bar:completeAnimation()
			f29_arg0.Bar:setAlpha(0)
			f29_arg0.Bar:setScale(0.9, 0.9)
			f29_arg0.clipFinished(f29_arg0.Bar)
		end,
		ChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			f30_arg0.ActiveBG:completeAnimation()
			f30_arg0.ActiveBG:setAlpha(1)
			f30_arg0.ActiveBG:setScale(1, 1)
			f30_arg0.clipFinished(f30_arg0.ActiveBG)
			f30_arg0.Button:completeAnimation()
			f30_arg0.Button:setScale(1, 1)
			f30_arg0.clipFinished(f30_arg0.Button)
			f30_arg0.SquarePrompt:completeAnimation()
			f30_arg0.SquarePrompt:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.SquarePrompt)
			f30_arg0.Bar:completeAnimation()
			f30_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f30_arg0.Bar:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Bar)
		end,
		GainChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(4)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ActiveBG:beginAnimation(120)
				f31_arg0.ActiveBG:setAlpha(1)
				f31_arg0.ActiveBG:setScale(1, 1)
				f31_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ActiveBG:completeAnimation()
			f31_arg0.ActiveBG:setAlpha(0)
			f31_arg0.ActiveBG:setScale(0.9, 0.9)
			f31_local0(f31_arg0.ActiveBG)
			local f31_local1 = function(f33_arg0)
				f31_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f31_arg0.Button:setScale(1, 1)
				f31_arg0.Button:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Button:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.Button:completeAnimation()
			f31_arg0.Button:setScale(0.9, 0.9)
			f31_local1(f31_arg0.Button)
			f31_arg0.FocusSound:completeAnimation()
			f31_arg0.FocusSound:setPlaySoundDirect(true)
			f31_arg0.FocusSound:playSound("cac_slide_nav", f31_arg1)
			f31_arg0.clipFinished(f31_arg0.FocusSound)
			local f31_local2 = function(f34_arg0)
				f31_arg0.Bar:beginAnimation(120)
				f31_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
				f31_arg0.Bar:setAlpha(1)
				f31_arg0.Bar:setScale(1, 1)
				f31_arg0.Bar:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Bar:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.Bar:completeAnimation()
			f31_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
			f31_arg0.Bar:setAlpha(0)
			f31_arg0.Bar:setScale(0.9, 0.9)
			f31_local2(f31_arg0.Bar)
		end,
		LoseChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(3)
			local f35_local0 = function(f36_arg0)
				f35_arg0.ActiveBG:beginAnimation(120)
				f35_arg0.ActiveBG:setAlpha(0)
				f35_arg0.ActiveBG:setScale(0.9, 0.9)
				f35_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.ActiveBG:completeAnimation()
			f35_arg0.ActiveBG:setAlpha(1)
			f35_arg0.ActiveBG:setScale(1, 1)
			f35_local0(f35_arg0.ActiveBG)
			local f35_local1 = function(f37_arg0)
				f35_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f35_arg0.Button:setScale(0.9, 0.9)
				f35_arg0.Button:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Button:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Button:completeAnimation()
			f35_arg0.Button:setScale(1, 1)
			f35_local1(f35_arg0.Button)
			local f35_local2 = function(f38_arg0)
				f35_arg0.Bar:beginAnimation(120)
				f35_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
				f35_arg0.Bar:setAlpha(0)
				f35_arg0.Bar:setScale(0.9, 0.9)
				f35_arg0.Bar:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Bar:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Bar:completeAnimation()
			f35_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f35_arg0.Bar:setAlpha(1)
			f35_arg0.Bar:setScale(1, 1)
			f35_local2(f35_arg0.Bar)
		end,
	},
	Disabled = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(0)
		end,
	},
	RightScreenEdge = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			f41_arg0.SquarePrompt:completeAnimation()
			f41_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f41_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f41_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f41_arg0.clipFinished(f41_arg0.SquarePrompt)
			f41_arg0.Bar:completeAnimation()
			f41_arg0.Bar:setAlpha(0)
			f41_arg0.Bar:setScale(0.9, 0.9)
			f41_arg0.clipFinished(f41_arg0.Bar)
		end,
		ChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(4)
			f42_arg0.ActiveBG:completeAnimation()
			f42_arg0.ActiveBG:setAlpha(1)
			f42_arg0.ActiveBG:setScale(1, 1)
			f42_arg0.clipFinished(f42_arg0.ActiveBG)
			f42_arg0.Button:completeAnimation()
			f42_arg0.Button:setScale(1, 1)
			f42_arg0.clipFinished(f42_arg0.Button)
			f42_arg0.SquarePrompt:completeAnimation()
			f42_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f42_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f42_arg0.SquarePrompt:setAlpha(1)
			f42_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f42_arg0.clipFinished(f42_arg0.SquarePrompt)
			f42_arg0.Bar:completeAnimation()
			f42_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f42_arg0.Bar:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.Bar)
		end,
		GainChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(5)
			local f43_local0 = function(f44_arg0)
				f43_arg0.ActiveBG:beginAnimation(120)
				f43_arg0.ActiveBG:setAlpha(1)
				f43_arg0.ActiveBG:setScale(1, 1)
				f43_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.ActiveBG:completeAnimation()
			f43_arg0.ActiveBG:setAlpha(0)
			f43_arg0.ActiveBG:setScale(0.9, 0.9)
			f43_local0(f43_arg0.ActiveBG)
			local f43_local1 = function(f45_arg0)
				f43_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f43_arg0.Button:setScale(1, 1)
				f43_arg0.Button:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.Button:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.Button:completeAnimation()
			f43_arg0.Button:setScale(0.9, 0.9)
			f43_local1(f43_arg0.Button)
			f43_arg0.SquarePrompt:completeAnimation()
			f43_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f43_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f43_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f43_arg0.clipFinished(f43_arg0.SquarePrompt)
			f43_arg0.FocusSound:completeAnimation()
			f43_arg0.FocusSound:setPlaySoundDirect(true)
			f43_arg0.FocusSound:playSound("cac_slide_nav", f43_arg1)
			f43_arg0.clipFinished(f43_arg0.FocusSound)
			local f43_local2 = function(f46_arg0)
				f43_arg0.Bar:beginAnimation(120)
				f43_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
				f43_arg0.Bar:setAlpha(1)
				f43_arg0.Bar:setScale(1, 1)
				f43_arg0.Bar:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.Bar:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.Bar:completeAnimation()
			f43_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
			f43_arg0.Bar:setAlpha(0)
			f43_arg0.Bar:setScale(0.9, 0.9)
			f43_local2(f43_arg0.Bar)
		end,
		LoseChildFocus = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			local f47_local0 = function(f48_arg0)
				f47_arg0.ActiveBG:beginAnimation(120)
				f47_arg0.ActiveBG:setAlpha(0)
				f47_arg0.ActiveBG:setScale(0.9, 0.9)
				f47_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.ActiveBG:completeAnimation()
			f47_arg0.ActiveBG:setAlpha(1)
			f47_arg0.ActiveBG:setScale(1, 1)
			f47_local0(f47_arg0.ActiveBG)
			local f47_local1 = function(f49_arg0)
				f47_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f47_arg0.Button:setScale(0.9, 0.9)
				f47_arg0.Button:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.Button:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.Button:completeAnimation()
			f47_arg0.Button:setScale(1, 1)
			f47_local1(f47_arg0.Button)
			f47_arg0.SquarePrompt:completeAnimation()
			f47_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f47_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f47_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f47_arg0.clipFinished(f47_arg0.SquarePrompt)
			local f47_local2 = function(f50_arg0)
				f47_arg0.Bar:beginAnimation(120)
				f47_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
				f47_arg0.Bar:setAlpha(0)
				f47_arg0.Bar:setScale(0.9, 0.9)
				f47_arg0.Bar:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.Bar:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.Bar:completeAnimation()
			f47_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f47_arg0.Bar:setAlpha(1)
			f47_arg0.Bar:setScale(1, 1)
			f47_local2(f47_arg0.Bar)
		end,
	},
}
CoD.WarzoneQuickInventoryShardItem.__onClose = function(f51_arg0)
	f51_arg0.Button:close()
	f51_arg0.ConsumedProgress:close()
	f51_arg0.SquarePrompt:close()
	f51_arg0.EMP:close()
end
