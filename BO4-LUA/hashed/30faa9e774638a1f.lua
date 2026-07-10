require("x64:dd513db11e2bfb6")
require("x64:88a4793bcdc6806")
require("x64:69c5ab8a4b56a69")
require("x64:1300da9b0ba493a")
CoD.ReservesLootButtonsGroup = InheritFrom(LUI.UIElement)
CoD.ReservesLootButtonsGroup.__defaultWidth = 160
CoD.ReservesLootButtonsGroup.__defaultHeight = 461
CoD.ReservesLootButtonsGroup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesLootButtonsGroup)
	self.id = "ReservesLootButtonsGroup"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ReservesLootBribeButton = CoD.ReservesLootBribeButtonContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, 86.5, 230.5)
	ReservesLootBribeButton:subscribeToGlobalModel(f1_arg1, "ReservesLootPurchaseCase", nil, function(model)
		ReservesLootBribeButton:setModel(model, f1_arg1)
	end)
	local LootCaseButton = ReservesLootBribeButton
	local LootBundleCrateButton = ReservesLootBribeButton.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	LootBundleCrateButton(LootCaseButton, f1_local4["LootStreamProgress.allRngUnlocked"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LootCaseButton = ReservesLootBribeButton
	LootBundleCrateButton = ReservesLootBribeButton.subscribeToModel
	f1_local4 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	LootBundleCrateButton(LootCaseButton, f1_local4.lootBribeCount, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ReservesLootBribeButton:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ReservesLootBribeButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.BlackMarketUtility.OpenAllReservesOwnedDialog(menu, controller)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "ReservesItemCounts", "lootBribeCount", 0) then
			OpenOverlay(self, "OpenBribeConfirmation", controller, {
				_model = element:getModel(),
				_properties = {
					_bribeType = LuaEnum.BRIBE_TYPES.BRIBE,
				},
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/redeem", nil, nil)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "ReservesItemCounts", "lootBribeCount", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/redeem", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(ReservesLootBribeButton)
	self.ReservesLootBribeButton = ReservesLootBribeButton
	LootBundleCrateButton = CoD.ReservesLootBundleCrateButtonContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -72.5, 69.5)
	LootBundleCrateButton:subscribeToGlobalModel(f1_arg1, "ReservesLootBundleCrate", nil, function(model)
		LootBundleCrateButton:setModel(model, f1_arg1)
	end)
	f1_local4 = LootBundleCrateButton
	LootCaseButton = LootBundleCrateButton.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	LootCaseButton(f1_local4, f1_local5["LootStreamProgress.allRngUnlocked"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local4 = LootBundleCrateButton
	LootCaseButton = LootBundleCrateButton.subscribeToModel
	f1_local5 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	LootCaseButton(f1_local4, f1_local5.lootBundleCrateCount, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LootBundleCrateButton:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LootBundleCrateButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.BlackMarketUtility.OpenAllReservesOwnedDialog(menu, controller)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "ReservesItemCounts", "lootBundleCrateCount", 0) then
			OpenOverlay(self, "OpenBribeConfirmation", controller, {
				_model = element:getModel(),
				_properties = {
					_bribeType = LuaEnum.BRIBE_TYPES.CRATE,
				},
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/redeem", nil, nil)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "ReservesItemCounts", "lootBundleCrateCount", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/redeem", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(LootBundleCrateButton)
	self.LootBundleCrateButton = LootBundleCrateButton
	LootCaseButton = CoD.ReservesLootCaseButtonContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -230.5, -86.5)
	LootCaseButton:subscribeToGlobalModel(f1_arg1, "ReservesLootPurchaseCase", nil, function(model)
		LootCaseButton:setModel(model, f1_arg1)
	end)
	f1_local5 = LootCaseButton
	f1_local4 = LootCaseButton.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["LootStreamProgress.allRngUnlocked"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local5 = LootCaseButton
	f1_local4 = LootCaseButton.subscribeToModel
	f1_local6 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6.lootCaseCount, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LootCaseButton:registerEventHandler("gain_focus", function(element, event)
		local f17_local0 = nil
		if element.gainFocus then
			f17_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f17_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f17_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LootCaseButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.BlackMarketUtility.OpenAllReservesOwnedDialog(menu, controller)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "ReservesItemCounts", "lootCaseCount", 0) then
			OpenOverlay(self, "OpenBribeConfirmation", controller, {
				_model = element:getModel(),
				_properties = {
					_bribeType = LuaEnum.BRIBE_TYPES.CASE,
				},
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/redeem", nil, nil)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "ReservesItemCounts", "lootCaseCount", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/redeem", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(LootCaseButton)
	self.LootCaseButton = LootCaseButton
	ReservesLootBribeButton.id = "ReservesLootBribeButton"
	LootBundleCrateButton.id = "LootBundleCrateButton"
	LootCaseButton.id = "LootCaseButton"
	self.__defaultFocus = LootCaseButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesLootButtonsGroup.__onClose = function(f20_arg0)
	f20_arg0.ReservesLootBribeButton:close()
	f20_arg0.LootBundleCrateButton:close()
	f20_arg0.LootCaseButton:close()
end
