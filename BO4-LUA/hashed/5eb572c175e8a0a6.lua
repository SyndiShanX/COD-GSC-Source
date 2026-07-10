require("x64:be52530c0ca57a1")
require("x64:87b99331f9f0f2e")
require("x64:faa5e2f0fd53709")
require("x64:35653ef4ad2299d")
require("x64:b1b346e32476a2e")
CoD.ReservesCrateCarousel = InheritFrom(LUI.UIElement)
CoD.ReservesCrateCarousel.__defaultWidth = 248
CoD.ReservesCrateCarousel.__defaultHeight = 462
CoD.ReservesCrateCarousel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "updateCrateBundleOffers", 0)
	self:setClass(CoD.ReservesCrateCarousel)
	self.id = "ReservesCrateCarousel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CrateCarousel = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, true, false, false, false)
	CrateCarousel:setLeftRight(0.5, 0.5, -124, 124)
	CrateCarousel:setTopBottom(0.5, 0.5, -231, 231)
	CrateCarousel:setWidgetType(CoD.ReservesLootCrateButtonContainer)
	CrateCarousel:setSpacing(12)
	CrateCarousel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CrateCarousel:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	CrateCarousel:setDataSource("ReservesLootPurchaseItems")
	local f1_local2 = CrateCarousel
	local f1_local3 = CrateCarousel.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["LootStreamProgress.allRngUnlocked"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local2 = CrateCarousel
	f1_local3 = CrateCarousel.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["LootStreamProgress.codPoints"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	CrateCarousel:registerEventHandler("gain_list_focus", function(element, event)
		local f4_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", false)
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, element)
		return f4_local0
	end)
	CrateCarousel:registerEventHandler("lose_list_focus", function(element, event)
		local f5_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", true)
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, element)
		return f5_local0
	end)
	CrateCarousel:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.BlackMarketUtility.OpenAllReservesOwnedDialog(menu, controller)
			return true
		elseif CanPurchaseItem(controller, element) then
			OpenOverlay(self, "PurchaseReservesItem", controller, {
				_model = element:getModel(),
			})
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
			OpenPopup(self, "PurchaseCodPoints", controller, element:getModel())
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/purchase", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(CrateCarousel, "updateDataSource", function(element, controller, f13_arg2, f13_arg3)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(element)
	end)
	CrateCarousel:subscribeToGlobalModel(f1_arg1, "PerController", "updateCrateBundleOffers", function(model)
		CoD.GridAndListUtility.UpdateDataSource(CrateCarousel, false, true, true)
	end)
	self:addElement(CrateCarousel)
	self.CrateCarousel = CrateCarousel
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f16_arg1)
	end)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	CrateCarousel.id = "CrateCarousel"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = CrateCarousel
	CoD.BaseUtility.DisableNavigation(f1_local3)
	SetElementProperty(f1_local3, "__loopOnSameRow", true)
	SetElementProperty(f1_local3, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local3)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local3, 0.5)
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f1_local3)
	return self
end
CoD.ReservesCrateCarousel.__resetProperties = function(f18_arg0)
	f18_arg0.CrateCarousel:completeAnimation()
	f18_arg0.CrateCarousel:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
end
CoD.ReservesCrateCarousel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.CrateCarousel:completeAnimation()
			f20_arg0.CrateCarousel:setHorizontalCounter(CoD.horizontalCounter)
			f20_arg0.clipFinished(f20_arg0.CrateCarousel)
		end,
	},
}
CoD.ReservesCrateCarousel.__onClose = function(f21_arg0)
	f21_arg0.CrateCarousel:close()
end
