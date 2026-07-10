require("x64:6abd6dcfe95863d")
require("x64:be52530c0ca57a1")
require("x64:ffbc64370f13dd9")
require("x64:b8e2ca68acca1fd")
require("x64:db806626fb64f10")
require("x64:670e7986a13c379")
require("x64:6d04ce9f4899b7")
require("x64:294871407213026")
require("x64:e669990f96d54e9")
require("x64:70301570eda8b06")
require("x64:79a2abecba85306")
require("x64:a20c338941ade19")
require("x64:5d80cb371475b19")
require("x64:b3eabfae4736e17")
require("x64:75e2a524b093c12")
CoD.BlackMarketBountyDetails = InheritFrom(CoD.Menu)
LUI.createMenu.BlackMarketBountyDetails = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BlackMarketBountyDetails", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	CoD.BlackMarketUtility.EnableItemshopTick(f1_arg0, self)
	CoD.BlackMarketUtility.SetPropertiesFromItemModel(f1_arg0, self)
	CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
	SetFocusedTierModelValue(f1_arg0, "1", "set")
	CoD.BaseUtility.SetControllerModelToSelfModelValue(f1_arg0, f1_local1, "MaxTier", "totalRewardCount")
	self:setClass(CoD.BlackMarketBountyDetails)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BMBountyRequirementContainer = CoD.BM_BountyRequirementContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -330, 0)
	self:addElement(BMBountyRequirementContainer)
	self.BMBountyRequirementContainer = BMBountyRequirementContainer
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
	local ItemDetails = CoD.ItemDetails.new(f1_local1, f1_arg0, 0.5, 0.5, -1867, -1091, 0, 0, 159, 589)
	ItemDetails:linkToElementModel(self, nil, false, function(model)
		ItemDetails:setModel(model, f1_arg0)
	end)
	ItemDetails:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local SupplyChainDetails = ItemDetails
	local XCamMouseControl = ItemDetails.subscribeToModel
	local BMBountyItemPreview = Engine[@"getmodelforcontroller"](f1_arg0)
	XCamMouseControl(SupplyChainDetails, BMBountyItemPreview.LastInput, function(f5_arg0, f5_arg1)
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
	SupplyChainDetails = CoD.ContractSupplyChainDetails.new(f1_local1, f1_arg0, 0.5, 0.5, 1159, 1759, 0, 0, -15, 1065)
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
				if not IsMouseOrKeyboard(f1_arg0) and not IsWidgetInFocus(self, "RewardList", event) and not IsWidgetInFocus(self, "RewardGridPC", event) then
					f11_local0 = not IsWidgetInFocus(self, "BountyBundleList", event)
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
	local f1_local8 = SupplyChainDetails
	BMBountyItemPreview = SupplyChainDetails.subscribeToModel
	local BountyBundleList = Engine[@"getmodelforcontroller"](f1_arg0)
	BMBountyItemPreview(f1_local8, BountyBundleList.LastInput, function(f13_arg0)
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
	BMBountyItemPreview = CoD.BM_BountyItemPreview.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	BMBountyItemPreview:linkToElementModel(self, nil, false, function(model)
		BMBountyItemPreview:setModel(model, f1_arg0)
	end)
	self:addElement(BMBountyItemPreview)
	self.BMBountyItemPreview = BMBountyItemPreview
	f1_local8 = nil
	f1_local8 = LUI.UIElement.createFake()
	self.RewardList = f1_local8
	BountyBundleList = LUI.UIList.new(f1_local1, f1_arg0, 11, 0, nil, false, false, false, false)
	BountyBundleList:setLeftRight(0.5, 0.5, 294, 838)
	BountyBundleList:setTopBottom(0.5, 0.5, 85, 197)
	BountyBundleList:setWidgetType(CoD.BM_BountyBundleItem)
	BountyBundleList:setHorizontalCount(5)
	BountyBundleList:setSpacing(11)
	BountyBundleList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	BountyBundleList:setDataSource("BundleItemsList")
	BountyBundleList:linkToElementModel(BountyBundleList, "allowFrozenMoment", true, function(model, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	BountyBundleList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f20_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "BMBountyDetails")
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "BMBountyItemPreview")
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, element)
		return f20_local0
	end)
	BountyBundleList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f21_local0 = nil
		CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
		return f21_local0
	end)
	BountyBundleList:registerEventHandler("lose_list_focus", function(element, event)
		local f22_local0 = nil
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg0, self.SupplyChainDetails, self)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg0, self.BMBountyDetails, self)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg0, self.BMBountyItemPreview, self)
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, self)
		return f22_local0
	end)
	BountyBundleList:registerEventHandler("gain_focus", function(element, event)
		local f23_local0 = nil
		if element.gainFocus then
			f23_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f23_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_right"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f23_local0
	end)
	f1_local1:AddButtonCallbackFunction(BountyBundleList, f1_arg0, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
		if IsDpadButton(model) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 1) then
			SetFocusedTierModelValue(controller, "1", "decrement")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDpadButton(nil) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(BountyBundleList, f1_arg0, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		if IsDpadButton(model) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 5) then
			SetFocusedTierModelValue(controller, "1", "increment")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDpadButton(nil) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 5) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(BountyBundleList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "allowFrozenMoment") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "allowFrozenMoment") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(BountyBundleList, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
	end)
	BountyBundleList:subscribeToGlobalModel(f1_arg0, "PerController", "FocusedTier", function(model)
		local f31_local0 = BountyBundleList
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "RewardList") then
			UpdateDataSource(self, f31_local0, f1_arg0)
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, f31_local0)
		else
			UpdateDataSource(self, f31_local0, f1_arg0)
		end
	end)
	self:addElement(BountyBundleList)
	self.BountyBundleList = BountyBundleList
	local ShopTimer = CoD.ShopTimer.new(f1_local1, f1_arg0, 0, 0, 143.5, 393.5, 0, 0, 135, 195)
	ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference = function(f32_arg0)
		local f32_local0 = f32_arg0:get()
		if f32_local0 ~= nil then
			ShopTimer.ReserveDealTimer.TextBox2:setText(CoD.BlackMarketUtility.GetTimerModelValue(self:getModel(), f32_local0))
		end
	end
	ShopTimer:subscribeToGlobalModel(f1_arg0, "ReserveDealsRotation", "currentTime", ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference)
	ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference_FullPath = function()
		local f33_local0 = DataSources.ReserveDealsRotation.getModel(f1_arg0)
		f33_local0 = f33_local0.currentTime
		if f33_local0 then
			ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference(f33_local0)
		end
	end
	ShopTimer:subscribeToGlobalModel(f1_arg0, "AutoEvents", "autoevent_discount1_timer", function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			ShopTimer.DiscountTimerSlot1.TextBox2:setText(f34_local0)
		end
	end)
	ShopTimer:subscribeToGlobalModel(f1_arg0, "AutoEvents", "autoevent_discount2_timer", function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			ShopTimer.DiscountTimerSlot2.TextBox2:setText(f35_local0)
		end
	end)
	ShopTimer:subscribeToGlobalModel(f1_arg0, "AutoEvents", "autoevent_discount3_timer", function(model)
		local f36_local0 = model:get()
		if f36_local0 ~= nil then
			ShopTimer.DiscountTimerSlot3.TextBox2:setText(f36_local0)
		end
	end)
	ShopTimer:linkToElementModel(self, nil, false, function(model)
		ShopTimer:setModel(model, f1_arg0)
	end)
	self:addElement(ShopTimer)
	self.ShopTimer = ShopTimer
	local BMBountyDetails = CoD.BM_BountyDetails.new(f1_local1, f1_arg0, 0, 0, 120, 920, 0, 0, 525, 625)
	BMBountyDetails:linkToElementModel(self, nil, false, function(model)
		BMBountyDetails:setModel(model, f1_arg0)
	end)
	self:addElement(BMBountyDetails)
	self.BMBountyDetails = BMBountyDetails
	local PurchaseButton = CoD.ItemShopButton.new(f1_local1, f1_arg0, 0, 0, 120, 570, 0, 0, 669, 721)
	PurchaseButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg0, "purchased")
			end,
		},
	})
	PurchaseButton:linkToElementModel(PurchaseButton, "purchased", true, function(model)
		f1_local1:updateElementState(PurchaseButton, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	PurchaseButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"hash_4516BC3828DEEAD"))
	PurchaseButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_4516BC3828DEEAD"))
	PurchaseButton:linkToElementModel(self, nil, false, function(model)
		PurchaseButton:setModel(model, f1_arg0)
	end)
	local f1_local13 = PurchaseButton
	local BMActivateBountyButton = PurchaseButton.subscribeToModel
	local f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	BMActivateBountyButton(f1_local13, f1_local15["LootStreamProgress.codPoints"], function(f42_arg0, f42_arg1)
		CoD.Menu.UpdateButtonShownState(f42_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PurchaseButton:registerEventHandler("gain_focus", function(element, event)
		local f43_local0 = nil
		if element.gainFocus then
			f43_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f43_local0 = element.super:gainFocus(event)
		end
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, f1_local1)
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f43_local0
	end)
	f1_local1:AddButtonCallbackFunction(PurchaseButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CanPurchaseItem(controller, self) and IsInDefaultState(self) then
			OpenPopup(self, "ItemShopConfirmation", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		elseif CanPurchaseItem(controller, self) and IsElementInState(self, "SubItems") then
			OpenPopup(self, "ItemShopConfirmation", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			return true
		elseif IsInDefaultState(self) then
			OpenPopup(self, "PurchaseCodPoints", controller, menu:getModel())
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		elseif IsElementInState(self, "SubItems") then
			OpenPopup(self, "PurchaseCodPoints", controller, menu:getModel())
			return true
		else
		end
	end, function(element, menu, controller)
		if CanPurchaseItem(controller, self) and IsInDefaultState(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CanPurchaseItem(controller, self) and IsElementInState(self, "SubItems") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsInDefaultState(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsElementInState(self, "SubItems") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(PurchaseButton)
	self.PurchaseButton = PurchaseButton
	BMActivateBountyButton = CoD.BM_ActivateBountyButton.new(f1_local1, f1_arg0, 0, 0, 595, 1045, 0, 0, 669, 721)
	BMActivateBountyButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"hash_3F31710F4130CFEA"))
	BMActivateBountyButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_3F31710F4130CFEA"))
	BMActivateBountyButton:registerEventHandler("gain_focus", function(element, event)
		local f46_local0 = nil
		if element.gainFocus then
			f46_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f46_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f46_local0
	end)
	f1_local1:AddButtonCallbackFunction(BMActivateBountyButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsInDefaultState(element) then
			OpenPopup(self, "ItemShopConfirmation", controller, {
				_model = self:getModel(),
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(BMActivateBountyButton)
	self.BMActivateBountyButton = BMActivateBountyButton
	f1_local15 = ShopTimer
	f1_local13 = ShopTimer.subscribeToModel
	local f1_local16 = DataSources.ReserveDealsRotation.getModel(f1_arg0)
	f1_local13(f1_local15, f1_local16.cycled, ShopTimer.ReserveDealTimer.TextBox2.__ReserveDealTimer_TextBox2_String_Reference_FullPath)
	self:linkToElementModel(self, "movieName", true, function(model, f49_arg1)
		CoD.Menu.UpdateButtonShownState(f49_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f49_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	self:linkToElementModel(self, "allowFrozenMoment", true, function(model, f50_arg1)
		CoD.Menu.UpdateButtonShownState(f50_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
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
		if CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "allowFrozenMoment", true) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
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
		if CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "allowFrozenMoment", true) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
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
			GoBack(self, f1_arg0)
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
	f1_local8.id = "RewardList"
	BountyBundleList.id = "BountyBundleList"
	PurchaseButton.id = "PurchaseButton"
	BMActivateBountyButton.id = "BMActivateBountyButton"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = PurchaseButton
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local13 = self
	CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, f1_local13)
	CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_local1, f1_local13, f1_arg0)
	CoD.BlackMarketUtility.SetupPageStreamHoldActionReadyCheck(f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibutton"][@"lui_key_rtrig"])
	return self
end
CoD.BlackMarketBountyDetails.__onClose = function(f69_arg0)
	f69_arg0.BMBountyRequirementContainer:close()
	f69_arg0.GenericMenuFrameIdentity:close()
	f69_arg0.ItemDetails:close()
	f69_arg0.XCamMouseControl:close()
	f69_arg0.SupplyChainDetails:close()
	f69_arg0.BMBountyItemPreview:close()
	f69_arg0.RewardList:close()
	f69_arg0.BountyBundleList:close()
	f69_arg0.ShopTimer:close()
	f69_arg0.BMBountyDetails:close()
	f69_arg0.PurchaseButton:close()
	f69_arg0.BMActivateBountyButton:close()
end
