require("x64:325eec9c0fe7758")
require("x64:1744d99b88fcb45")
require("x64:c0436d48eab47f9")
require("x64:2435be124ae6695")
CoD.WarzoneQuickInventoryItem = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickInventoryItem.__defaultWidth = 70
CoD.WarzoneQuickInventoryItem.__defaultHeight = 70
CoD.WarzoneQuickInventoryItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickInventoryItem)
	self.id = "WarzoneQuickInventoryItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CycleBackground = LUI.UIImage.new(0, 0, 0, 71, 0, 0, -2, 75)
	CycleBackground:setRGB(0.37, 0.37, 0.35)
	CycleBackground:setAlpha(0)
	self:addElement(CycleBackground)
	self.CycleBackground = CycleBackground
	local ActiveBG = LUI.UIImage.new(0.5, 0.5, -44, 44, 0.5, 0.5, -44.5, 43.5)
	ActiveBG:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ActiveBG:setAlpha(0)
	ActiveBG:setScale(0.9, 0.9)
	ActiveBG:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_glow"))
	ActiveBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ActiveBG:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(ActiveBG)
	self.ActiveBG = ActiveBG
	local MidArrow = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 26, 42, 0, 0, 62, 78)
	MidArrow:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	MidArrow:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MidArrow:setAlpha(0)
	MidArrow:setZRot(-90)
	self:addElement(MidArrow)
	self.MidArrow = MidArrow
	local Button = CoD.WarzoneInventoryMenuItemSmall_Internal_QE.new(f1_arg0, f1_arg1, 0.5, 0.5, -44, 44, 0.5, 0.5, -45, 43)
	Button:setScale(0.9, 0.9)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	Button:linkToElementModel(Button, "id", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	Button:linkToElementModel(Button, "availableAction", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	Button:linkToElementModel(Button, "type", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local SquarePrompt = Button
	local ConsumedProgress = Button.subscribeToModel
	local FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["hudItems.inventory.open"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	ConsumedProgress(SquarePrompt, FocusSound.isInVehicle, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.0"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.1"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.2"], function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.3"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SquarePrompt = Button
	ConsumedProgress = Button.subscribeToModel
	FocusSound = Engine[@"getmodelforcontroller"](f1_arg1)
	ConsumedProgress(SquarePrompt, FocusSound["vehicle.seatOccupantClientNum.4"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	Button:linkToElementModel(Button, "castTime", true, function(model, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	Button:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Button, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "killstreak") and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			BlockGameFromKeyEvent(controller)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			BlockGameFromKeyEvent(controller)
			return true
		elseif CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.NONE) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, true)
			BlockGameFromKeyEvent(controller)
			return true
		elseif CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "type", "killstreak") and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 1) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 2) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 3) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 4) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 4000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 2500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, controller, "castTime", 5) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 5000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.HUDUtility.PlayerHasPerk(controller, @"specialty_consumer") and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 3000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) and CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.WZUtility.CurrentlyIsDriverOrGunner(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_7A45793735D89BB3", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 6000 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.ATTACH) and CoD.WZUtility.IsQuickInventoryOpen(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_41F7289BC37F8FA5", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.SWAP) and CoD.WZUtility.IsQuickInventoryOpen(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_918999DDF357263", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return true
		elseif CoD.WZUtility.IsQuickInventoryOpen(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.NONE) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_11B824FEE55364A2", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return true
		elseif CoD.WZUtility.IsQuickInventoryOpen(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return false
		else
			return false
		end
	end, false)
	Button:linkToElementModel(self, "name", true, function(model)
		local f18_local0 = Button
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
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			ConsumedProgress:setShaderVector(0, CoD.GetVectorComponentFromString(f19_local0, 1), CoD.GetVectorComponentFromString(f19_local0, 2), CoD.GetVectorComponentFromString(f19_local0, 3), CoD.GetVectorComponentFromString(f19_local0, 4))
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
	local Bar = LUI.UIImage.new(0, 0, 22, 46, 0, 0, 46, 78)
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
			stateName = "Hidden",
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
			stateName = "CycleQuickEquip",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "cycle", 1)
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
	self:linkToElementModel(self, "cycle", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cycle",
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
	if CoD.isPC then
		MidArrow.id = "MidArrow"
	end
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
CoD.WarzoneQuickInventoryItem.__resetProperties = function(f30_arg0)
	f30_arg0.Bar:completeAnimation()
	f30_arg0.Button:completeAnimation()
	f30_arg0.ActiveBG:completeAnimation()
	f30_arg0.SquarePrompt:completeAnimation()
	f30_arg0.FocusSound:completeAnimation()
	f30_arg0.ConsumedProgress:completeAnimation()
	f30_arg0.MidArrow:completeAnimation()
	f30_arg0.CycleBackground:completeAnimation()
	f30_arg0.Bar:setTopBottom(0, 0, 46, 78)
	f30_arg0.Bar:setAlpha(1)
	f30_arg0.Bar:setScale(1, 1)
	f30_arg0.Button:setAlpha(1)
	f30_arg0.Button:setScale(0.9, 0.9)
	f30_arg0.ActiveBG:setAlpha(0)
	f30_arg0.ActiveBG:setScale(0.9, 0.9)
	f30_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -75, 75)
	f30_arg0.SquarePrompt:setAlpha(0)
	f30_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	f30_arg0.FocusSound:setPlaySoundDirect(false)
	f30_arg0.ConsumedProgress:setAlpha(0.8)
	f30_arg0.MidArrow:setAlpha(0)
	f30_arg0.CycleBackground:setAlpha(0)
end
CoD.WarzoneQuickInventoryItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.Bar:completeAnimation()
			f31_arg0.Bar:setAlpha(0)
			f31_arg0.Bar:setScale(0.9, 0.9)
			f31_arg0.clipFinished(f31_arg0.Bar)
		end,
		ChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(4)
			f32_arg0.ActiveBG:completeAnimation()
			f32_arg0.ActiveBG:setAlpha(1)
			f32_arg0.ActiveBG:setScale(1, 1)
			f32_arg0.clipFinished(f32_arg0.ActiveBG)
			f32_arg0.Button:completeAnimation()
			f32_arg0.Button:setScale(1, 1)
			f32_arg0.clipFinished(f32_arg0.Button)
			f32_arg0.SquarePrompt:completeAnimation()
			f32_arg0.SquarePrompt:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.SquarePrompt)
			f32_arg0.Bar:completeAnimation()
			f32_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f32_arg0.Bar:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.Bar)
		end,
		GainChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(4)
			local f33_local0 = function(f34_arg0)
				f33_arg0.ActiveBG:beginAnimation(120)
				f33_arg0.ActiveBG:setAlpha(1)
				f33_arg0.ActiveBG:setScale(1, 1)
				f33_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.ActiveBG:completeAnimation()
			f33_arg0.ActiveBG:setAlpha(0)
			f33_arg0.ActiveBG:setScale(0.9, 0.9)
			f33_local0(f33_arg0.ActiveBG)
			local f33_local1 = function(f35_arg0)
				f33_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f33_arg0.Button:setScale(1, 1)
				f33_arg0.Button:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Button:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Button:completeAnimation()
			f33_arg0.Button:setScale(0.9, 0.9)
			f33_local1(f33_arg0.Button)
			f33_arg0.FocusSound:completeAnimation()
			f33_arg0.FocusSound:setPlaySoundDirect(true)
			f33_arg0.FocusSound:playSound("cac_slide_nav", f33_arg1)
			f33_arg0.clipFinished(f33_arg0.FocusSound)
			local f33_local2 = function(f36_arg0)
				f33_arg0.Bar:beginAnimation(120)
				f33_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
				f33_arg0.Bar:setAlpha(1)
				f33_arg0.Bar:setScale(1, 1)
				f33_arg0.Bar:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Bar:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Bar:completeAnimation()
			f33_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
			f33_arg0.Bar:setAlpha(0)
			f33_arg0.Bar:setScale(0.9, 0.9)
			f33_local2(f33_arg0.Bar)
		end,
		LoseChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			local f37_local0 = function(f38_arg0)
				f37_arg0.ActiveBG:beginAnimation(120)
				f37_arg0.ActiveBG:setAlpha(0)
				f37_arg0.ActiveBG:setScale(0.9, 0.9)
				f37_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.ActiveBG:completeAnimation()
			f37_arg0.ActiveBG:setAlpha(1)
			f37_arg0.ActiveBG:setScale(1, 1)
			f37_local0(f37_arg0.ActiveBG)
			local f37_local1 = function(f39_arg0)
				f37_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f37_arg0.Button:setScale(0.9, 0.9)
				f37_arg0.Button:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Button:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.Button:completeAnimation()
			f37_arg0.Button:setScale(1, 1)
			f37_local1(f37_arg0.Button)
			local f37_local2 = function(f40_arg0)
				f37_arg0.Bar:beginAnimation(120)
				f37_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
				f37_arg0.Bar:setAlpha(0)
				f37_arg0.Bar:setScale(0.9, 0.9)
				f37_arg0.Bar:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Bar:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.Bar:completeAnimation()
			f37_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f37_arg0.Bar:setAlpha(1)
			f37_arg0.Bar:setScale(1, 1)
			f37_local2(f37_arg0.Bar)
		end,
	},
	Disabled = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(6)
			f42_arg0.ActiveBG:completeAnimation()
			f42_arg0.ActiveBG:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ActiveBG)
			f42_arg0.MidArrow:completeAnimation()
			f42_arg0.MidArrow:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.MidArrow)
			f42_arg0.Button:completeAnimation()
			f42_arg0.Button:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Button)
			f42_arg0.ConsumedProgress:completeAnimation()
			f42_arg0.ConsumedProgress:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ConsumedProgress)
			f42_arg0.SquarePrompt:completeAnimation()
			f42_arg0.SquarePrompt:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.SquarePrompt)
			f42_arg0.Bar:completeAnimation()
			f42_arg0.Bar:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Bar)
		end,
	},
	Empty = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(0)
		end,
	},
	CycleQuickEquip = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			f44_arg0.CycleBackground:completeAnimation()
			f44_arg0.CycleBackground:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.CycleBackground)
			f44_arg0.MidArrow:completeAnimation()
			f44_arg0.MidArrow:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.MidArrow)
		end,
	},
	RightScreenEdge = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			f45_arg0.SquarePrompt:completeAnimation()
			f45_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f45_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f45_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f45_arg0.clipFinished(f45_arg0.SquarePrompt)
			f45_arg0.Bar:completeAnimation()
			f45_arg0.Bar:setAlpha(0)
			f45_arg0.Bar:setScale(0.9, 0.9)
			f45_arg0.clipFinished(f45_arg0.Bar)
		end,
		ChildFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(4)
			f46_arg0.ActiveBG:completeAnimation()
			f46_arg0.ActiveBG:setAlpha(1)
			f46_arg0.ActiveBG:setScale(1, 1)
			f46_arg0.clipFinished(f46_arg0.ActiveBG)
			f46_arg0.Button:completeAnimation()
			f46_arg0.Button:setScale(1, 1)
			f46_arg0.clipFinished(f46_arg0.Button)
			f46_arg0.SquarePrompt:completeAnimation()
			f46_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f46_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f46_arg0.SquarePrompt:setAlpha(0)
			f46_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f46_arg0.clipFinished(f46_arg0.SquarePrompt)
			f46_arg0.Bar:completeAnimation()
			f46_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f46_arg0.Bar:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.Bar)
		end,
		GainChildFocus = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(5)
			local f47_local0 = function(f48_arg0)
				f47_arg0.ActiveBG:beginAnimation(120)
				f47_arg0.ActiveBG:setAlpha(1)
				f47_arg0.ActiveBG:setScale(1, 1)
				f47_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.ActiveBG:completeAnimation()
			f47_arg0.ActiveBG:setAlpha(0)
			f47_arg0.ActiveBG:setScale(0.9, 0.9)
			f47_local0(f47_arg0.ActiveBG)
			local f47_local1 = function(f49_arg0)
				f47_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f47_arg0.Button:setScale(1, 1)
				f47_arg0.Button:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.Button:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.Button:completeAnimation()
			f47_arg0.Button:setScale(0.9, 0.9)
			f47_local1(f47_arg0.Button)
			f47_arg0.SquarePrompt:completeAnimation()
			f47_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f47_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f47_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f47_arg0.clipFinished(f47_arg0.SquarePrompt)
			f47_arg0.FocusSound:completeAnimation()
			f47_arg0.FocusSound:setPlaySoundDirect(true)
			f47_arg0.FocusSound:playSound("cac_slide_nav", f47_arg1)
			f47_arg0.clipFinished(f47_arg0.FocusSound)
			local f47_local2 = function(f50_arg0)
				f47_arg0.Bar:beginAnimation(120)
				f47_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
				f47_arg0.Bar:setAlpha(1)
				f47_arg0.Bar:setScale(1, 1)
				f47_arg0.Bar:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.Bar:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.Bar:completeAnimation()
			f47_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
			f47_arg0.Bar:setAlpha(0)
			f47_arg0.Bar:setScale(0.9, 0.9)
			f47_local2(f47_arg0.Bar)
		end,
		LoseChildFocus = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(4)
			local f51_local0 = function(f52_arg0)
				f51_arg0.ActiveBG:beginAnimation(120)
				f51_arg0.ActiveBG:setAlpha(0)
				f51_arg0.ActiveBG:setScale(0.9, 0.9)
				f51_arg0.ActiveBG:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.ActiveBG:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.ActiveBG:completeAnimation()
			f51_arg0.ActiveBG:setAlpha(1)
			f51_arg0.ActiveBG:setScale(1, 1)
			f51_local0(f51_arg0.ActiveBG)
			local f51_local1 = function(f53_arg0)
				f51_arg0.Button:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f51_arg0.Button:setScale(0.9, 0.9)
				f51_arg0.Button:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.Button:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.Button:completeAnimation()
			f51_arg0.Button:setScale(1, 1)
			f51_local1(f51_arg0.Button)
			f51_arg0.SquarePrompt:completeAnimation()
			f51_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:completeAnimation()
			f51_arg0.SquarePrompt:setLeftRight(0.5, 0.5, -115, 35)
			f51_arg0.SquarePrompt.WarzoneQuickInventoryPromptInternal.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f51_arg0.clipFinished(f51_arg0.SquarePrompt)
			local f51_local2 = function(f54_arg0)
				f51_arg0.Bar:beginAnimation(120)
				f51_arg0.Bar:setTopBottom(0, 0, 45.5, 77.5)
				f51_arg0.Bar:setAlpha(0)
				f51_arg0.Bar:setScale(0.9, 0.9)
				f51_arg0.Bar:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.Bar:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.Bar:completeAnimation()
			f51_arg0.Bar:setTopBottom(0, 0, 48.5, 80.5)
			f51_arg0.Bar:setAlpha(1)
			f51_arg0.Bar:setScale(1, 1)
			f51_local2(f51_arg0.Bar)
		end,
	},
}
CoD.WarzoneQuickInventoryItem.__onClose = function(f55_arg0)
	f55_arg0.MidArrow:close()
	f55_arg0.Button:close()
	f55_arg0.ConsumedProgress:close()
	f55_arg0.SquarePrompt:close()
	f55_arg0.EMP:close()
end
