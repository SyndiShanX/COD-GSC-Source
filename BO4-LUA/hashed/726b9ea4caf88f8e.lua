require("x64:be52530c0ca57a1")
require("x64:ffbc64370f13dd9")
require("x64:b8e2ca68acca1fd")
require("x64:db806626fb64f10")
require("x64:79a2abecba85306")
require("x64:a20c338941ade19")
require("x64:b3eabfae4736e17")
require("x64:aa5c97c296aded6")
require("x64:75e2a524b093c12")
CoD.ItemShopDetails = InheritFrom(CoD.Menu)
LUI.createMenu.ItemShopDetails = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ItemShopDetails", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	CoD.BlackMarketUtility.SetPropertiesFromItemModel(f1_arg0, self)
	SetMenuProperty(f1_local1, "name", f1_arg1._model.name:get())
	CoD.BlackMarketUtility.EnableItemshopTick(f1_arg0, self)
	CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
	SetFocusedTierModelValue(f1_arg0, "1", "set")
	CoD.BaseUtility.SetControllerModelToSelfModelValue(f1_arg0, f1_local1, "MaxTier", "totalRewardCount")
	self:setClass(CoD.ItemShopDetails)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/black_market"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local ItemDetails = CoD.ItemDetails.new(f1_local1, f1_arg0, 0.5, 0.5, -840, -64, 0, 0, 178, 608)
	ItemDetails:linkToElementModel(self, nil, false, function(model)
		ItemDetails:setModel(model, f1_arg0)
	end)
	ItemDetails:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local SupplyChainDetails = ItemDetails
	local XCamMouseControl = ItemDetails.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	XCamMouseControl(SupplyChainDetails, f1_local6.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ItemDetails:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, element)
			SetElementState(self, self.SupplyChainDetails, f1_arg0, "DefaultState")
		end
		return f6_local0
	end)
	ItemDetails:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(ItemDetails, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			SetElementModelToFocusedElementModel(controller, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(menu, controller, element)
			SetControllerModelValue(controller, "contractDetailsShowItemInfo", true)
			SetElementState(self, self.SupplyChainDetails, controller, "DefaultState")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ItemDetails)
	self.ItemDetails = ItemDetails
	XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0.6, 0.6, 118, 750, 0, 0, 64, 684)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	SupplyChainDetails = CoD.ContractSupplyChainDetails.new(f1_local1, f1_arg0, 0.5, 0.5, 310, 910, 0, 0, -79, 1001)
	SupplyChainDetails:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				local f11_local0
				if not IsMouseOrKeyboard(f1_arg0) and not IsWidgetInFocus(self, "RewardList", event) then
					f11_local0 = not IsWidgetInFocus(self, "RewardGridPC", event)
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
	})
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_local1
		f1_local1:updateElementState(SupplyChainDetails, f12_arg1)
	end)
	local f1_local7 = SupplyChainDetails
	f1_local6 = SupplyChainDetails.subscribeToModel
	local RewardGridPC = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local7, RewardGridPC.LastInput, function(f13_arg0)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	SupplyChainDetails:appendEventHandler("record_curr_focused_elem_id", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_local1
		f1_local1:updateElementState(SupplyChainDetails, f14_arg1)
	end)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "character", true, function(model)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "character",
		})
	end)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "weaponRef", true, function(model)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "weaponRef",
		})
	end)
	SupplyChainDetails:linkToElementModel(self, nil, false, function(model)
		SupplyChainDetails:setModel(model, f1_arg0)
	end)
	self:addElement(SupplyChainDetails)
	self.SupplyChainDetails = SupplyChainDetails
	f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.RewardList = f1_local6
	f1_local7 = nil
	RewardGridPC = LUI.UIList.new(f1_local1, f1_arg0, 11, 0, nil, false, false, false, false)
	RewardGridPC:setLeftRight(0.5, 0.5, -824, -80)
	RewardGridPC:setTopBottom(0, 0, 684, 842)
	RewardGridPC:setWidgetType(CoD.SupplyChainItem)
	RewardGridPC:setHorizontalCount(5)
	RewardGridPC:setSpacing(11)
	RewardGridPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RewardGridPC:setDataSource("BundleItemsList")
	RewardGridPC:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f18_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local9 = RewardGridPC
	local ShopTimer = RewardGridPC.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg0)
	ShopTimer(f1_local9, f1_local11.LastInput, function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RewardGridPC:registerEventHandler("gain_list_focus", function(element, event)
		local f20_local0 = nil
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetControllerModelValue(f1_arg0, "contractDetailsShowItemInfo", true)
		end
		return f20_local0
	end)
	RewardGridPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f21_local0 = nil
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, element)
			SetElementState(self, self.SupplyChainDetails, f1_arg0, "DefaultState")
		end
		return f21_local0
	end)
	RewardGridPC:registerEventHandler("input_source_changed", function(element, event)
		local f22_local0 = nil
		if IsMouse(f1_arg0) then
			CoD.GridAndListUtility.DisableListActiveOnFocus(element)
			CoD.GridAndListUtility.ActivateListPCSelectionBehavior(element)
		elseif IsGamepad(f1_arg0) then
			CoD.GridAndListUtility.EnableListActiveOnFocus(element)
		end
		if not f22_local0 then
			f22_local0 = element:dispatchEventToChildren(event)
		end
		return f22_local0
	end)
	RewardGridPC:registerEventHandler("gain_focus", function(element, event)
		local f23_local0 = nil
		if element.gainFocus then
			f23_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f23_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f23_local0
	end)
	f1_local1:AddButtonCallbackFunction(RewardGridPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetElementModelToFocusedElementModel(controller, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(menu, controller, element)
			SetControllerModelValue(controller, "contractDetailsShowItemInfo", true)
			SetCurrentElementAsActive(self, element, controller)
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(menu, element, controller)
			SetElementState(self, self.SupplyChainDetails, controller, "DefaultState")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(RewardGridPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetElementModelToFocusedElementModel(controller, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(menu, controller, element)
			SetControllerModelValue(controller, "contractDetailsShowItemInfo", true)
			SetCurrentElementAsActive(self, element, controller)
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(menu, element, controller)
			SetElementState(self, self.SupplyChainDetails, controller, "DefaultState")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(RewardGridPC, "childFocusGained", function(element)
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
		end
	end)
	RewardGridPC:subscribeToGlobalModel(f1_arg0, "PerController", "FocusedTier", function(model)
		UpdateDataSource(self, RewardGridPC, f1_arg0)
	end)
	self:addElement(RewardGridPC)
	self.RewardGridPC = RewardGridPC
	ShopTimer = CoD.ShopTimer.new(f1_local1, f1_arg0, 0.5, 0.5, -816.5, -566.5, 0, 0, 135, 195)
	ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference = function(f30_arg0)
		local f30_local0 = f30_arg0:get()
		if f30_local0 ~= nil then
			ShopTimer.ReserveDealTimer.TextBox2:setText(CoD.BlackMarketUtility.GetTimerModelValue(self:getModel(), f30_local0))
		end
	end
	ShopTimer:subscribeToGlobalModel(f1_arg0, "ReserveDealsRotation", "currentTime", ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference)
	ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference_FullPath = function()
		local f31_local0 = DataSources.ReserveDealsRotation.getModel(f1_arg0)
		f31_local0 = f31_local0.currentTime
		if f31_local0 then
			ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference(f31_local0)
		end
	end
	ShopTimer:subscribeToGlobalModel(f1_arg0, "AutoEvents", "autoevent_discount1_timer", function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			ShopTimer.DiscountTimerSlot1.TextBox2:setText(f32_local0)
		end
	end)
	ShopTimer:subscribeToGlobalModel(f1_arg0, "AutoEvents", "autoevent_discount2_timer", function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			ShopTimer.DiscountTimerSlot2.TextBox2:setText(f33_local0)
		end
	end)
	ShopTimer:subscribeToGlobalModel(f1_arg0, "AutoEvents", "autoevent_discount3_timer", function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			ShopTimer.DiscountTimerSlot3.TextBox2:setText(f34_local0)
		end
	end)
	ShopTimer:linkToElementModel(self, nil, false, function(model)
		ShopTimer:setModel(model, f1_arg0)
	end)
	self:addElement(ShopTimer)
	self.ShopTimer = ShopTimer
	f1_local11 = ShopTimer
	f1_local9 = ShopTimer.subscribeToModel
	local f1_local12 = DataSources.ReserveDealsRotation.getModel(f1_arg0)
	f1_local9(f1_local11, f1_local12.cycled, ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference_FullPath)
	self:linkToElementModel(self, "movieName", true, function(model, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	self:appendEventHandler("record_curr_focused_elem_id", function(f37_arg0, f37_arg1)
		f37_arg1.menu = f37_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f37_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	self:linkToElementModel(self, "allowFrozenMoment", true, function(model, f38_arg1)
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.SendItemShopViewEvent(controller, menu, "")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_contextual_3", function(element, menu, controller, model)
		OpenPopup(self, "PurchaseCodPoints", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_263D5409DEC36DFA", nil, "ui_contextual_3")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.CanPlayGesture(menu) then
			CoD.BlackMarketUtility.PlayGesture(self, menu, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.BlackMarketUtility.CanPlayGesture(menu) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.PlayGesture(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.CanPlayGesture(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_0", nil, "ui_contextual_2")
			return false
		elseif CoD.BlackMarketUtility.CanPlayGesture(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"menu/preview", nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], nil, function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.BlackMarketUtility.PageStreamHoldUpdateAction(menu)
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "increment")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsPC() then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.BlackMarketUtility.SetupSupplyChainMovie(menu, controller, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"menu/preview", nil, "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], nil, function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.BlackMarketUtility.PageStreamHoldUpdateAction(menu)
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "decrement")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.CanToggleSignatureWeapon(menu) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.ToggleSignatureWeapon(menu, controller, menu)
			return true
		elseif CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "allowTogglePreview", true) and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "itemCategory", @"signature_weapon") then
			CoD.BlackMarketUtility.ToggleCharacterModelCamera(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.CanToggleSignatureWeapon(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "ui_contextual_1")
			return false
		elseif CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "allowTogglePreview", true) and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "itemCategory", @"signature_weapon") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_remove", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "allowFrozenMoment", true) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "RewardList") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		elseif not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil(menu, controller, "movieName") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "movieName", "") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.BlackMarketUtility.SetupSupplyChainMovie(menu, controller, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) then
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "allowFrozenMoment", true) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "RewardList") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_remove")
			return false
		elseif not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil(menu, controller, "movieName") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "movieName", "") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_remove")
			return false
		elseif CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/preview", nil, "ui_remove")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/preview", nil, "ui_remove")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg0, "MaxTier", CoD.BlackMarketUtility.SupplyChainMaxTiers)
		CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
		CoD.BlackMarketUtility.ItemShopDetailsClientScriptMenuCloseNotify(f1_arg0, f1_local1)
		SetFocusedTierModelValue(f1_arg0, "0", "")
		ClearMenuSavedState(f1_local1)
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "ItemshopRotation.cycled", function(model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") and CoD.BlackMarketUtility.WasItemCycled(f1_arg0, self) then
			CoD.BlackMarketUtility.SendItemShopViewEvent(f1_arg0, f1_local1, "")
			GoBack(self, f1_arg0)
		end
	end)
	self:linkToElementModel(self, "name", true, function(model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToPropertyValue(self, f1_arg0, "name", "name") then
			DelayGoBack(f1_local1, f1_arg0, 50)
		end
	end)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	ItemDetails.id = "ItemDetails"
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	f1_local6.id = "RewardList"
	RewardGridPC.id = "RewardGridPC"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ItemDetails
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local9 = self
	CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, f1_local9)
	CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_local1, f1_local9, f1_arg0)
	CoD.BlackMarketUtility.SetupPageStreamHoldActionReadyCheck(f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibutton"][@"lui_key_rtrig"])
	return self
end
CoD.ItemShopDetails.__onClose = function(f58_arg0)
	f58_arg0.GenericMenuFrameIdentity:close()
	f58_arg0.ItemDetails:close()
	f58_arg0.XCamMouseControl:close()
	f58_arg0.SupplyChainDetails:close()
	f58_arg0.RewardList:close()
	f58_arg0.RewardGridPC:close()
	f58_arg0.ShopTimer:close()
end
