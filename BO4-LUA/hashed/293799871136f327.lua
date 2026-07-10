require("x64:97e3c43ee11670")
require("x64:9c073fbbcfd61b3")
require("x64:ffbc64370f13dd9")
require("x64:a969a8392712433")
require("x64:c8666fff462a645")
require("x64:f5d49602f55b483")
require("x64:fbaed9d1bf93d4c")
require("x64:9d86ea4c820510d")
require("x64:e757ecab77bdc64")
require("x64:b5905d805906315")
require("x64:aa5c97c296aded6")
require("x64:83b8db1dd36662e")
require("x64:c354b0a26f3b5f9")
require("x64:3921bc3d09ef7fd")
require("x64:67940364f14a232")
require("x64:a830f5543072a43")
CoD.SupplyChainFrame = InheritFrom(LUI.UIElement)
CoD.SupplyChainFrame.__defaultWidth = 1920
CoD.SupplyChainFrame.__defaultHeight = 1080
CoD.SupplyChainFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if not IsBooleanDvarSet("loot_sunsetBlackjackShopActive") then
		SetFocusedTierModelValue(f1_arg1, "0", "")
		SetControllerModelValue(f1_arg1, "MaxTier", CoD.BlackMarketUtility.SupplyChainMaxTiers)
		SetPerControllerTableProperty(f1_arg1, "haveActiveContractInStream", nil)
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "BlackMarketSeasonThreeIntroduction")
	else
		SetFocusedTierModelValue(f1_arg1, "0", "")
		SetControllerModelValue(f1_arg1, "MaxTier", CoD.BlackMarketUtility.SupplyChainMaxTiers)
		SetPerControllerTableProperty(f1_arg1, "haveActiveContractInStream", nil)
	end
	self:setClass(CoD.SupplyChainFrame)
	self.id = "SupplyChainFrame"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CurrentSeasonText = LUI.UIText.new(0.5, 0.5, -814, 310, 0, 0, 135, 172)
	CurrentSeasonText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CurrentSeasonText:setAlpha(0)
	CurrentSeasonText:setText(LocalizeToUpperString(@"hash_26CBF773605247A2"))
	CurrentSeasonText:setTTF("ttmussels_regular")
	CurrentSeasonText:setLetterSpacing(8)
	CurrentSeasonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CurrentSeasonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CurrentSeasonText)
	self.CurrentSeasonText = CurrentSeasonText
	local ItemList = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	ItemList:setLeftRight(0.5, 0.5, -483, 233)
	ItemList:setTopBottom(0, 0, 169, 975)
	ItemList:setWidgetType(CoD.SupplyChainItem)
	ItemList:setHorizontalCount(5)
	ItemList:setVerticalCount(5)
	ItemList:setSpacing(4)
	ItemList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemList:setDataSource("LootTierItems")
	ItemList:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local CurrentTier = ItemList
	local SupplyChainDetails = ItemList.subscribeToModel
	local PurchaseTiers = Engine[@"getmodelforcontroller"](f1_arg1)
	SupplyChainDetails(CurrentTier, PurchaseTiers.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ItemList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		if not IsPC() then
			SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
			SetPerControllerTableProperty(f1_arg1, "allowTierPurchase", true)
		elseif IsPC() and IsGamepadOrKeyboardNavigation(f1_arg1) then
			SetCurrentElementAsActive(self, element, f1_arg1)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		end
		return f4_local0
	end)
	ItemList:registerEventHandler("lose_list_focus", function(element, event)
		local f5_local0 = nil
		if not IsPC() then
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
		end
		return f5_local0
	end)
	ItemList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f6_local0 = nil
		if not IsPC() then
			CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		elseif not IsPC() then
			CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		end
		return f6_local0
	end)
	ItemList:registerEventHandler("occlusion_change", function(element, event)
		local f7_local0 = nil
		if element.OcclusionChange then
			f7_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f7_local0 = element.super:OcclusionChange(event)
		end
		if CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "LootStreamProgress.playAnimation") and not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "playContrabandReveal") and IsPerControllerTablePropertyValue(f1_arg1, "offScreenPurchase", true) and not IsPerControllerTablePropertyValue(f1_arg1, "redeemingTierBundleItem", true) then
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(element)
			CoD.BlackMarketUtility.CacheContrabandRevealTier(element, f1_arg1)
			UpdateDataSource(self, element, f1_arg1)
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
			CoD.BlackMarketUtility.TriggerContrabandReveal(f1_arg1, element, self.SupplyChainDetails)
			CoD.BlackMarketUtility.TriggerRevealAnimation(f1_arg1, element)
			UpdateElementState(self, "DiscountDetailsWidget", f1_arg1)
		elseif CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "LootStreamProgress.playAnimation") and not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "playContrabandReveal") and not IsPerControllerTablePropertyValue(f1_arg1, "redeemingTierBundleItem", true) then
			CoD.BlackMarketUtility.CacheContrabandRevealTier(element, f1_arg1)
			UpdateDataSource(self, element, f1_arg1)
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
			CoD.BlackMarketUtility.TriggerContrabandReveal(f1_arg1, element, self.SupplyChainDetails)
			CoD.BlackMarketUtility.TriggerRevealAnimation(f1_arg1, element)
			UpdateElementState(self, "DiscountDetailsWidget", f1_arg1)
		end
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	ItemList:registerEventHandler("list_active_changed", function(element, event)
		local f8_local0 = nil
		if IsPC() then
			PlaySoundAlias("cac_grid_nav")
			SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
			CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
			CoD.BlackMarketUtility.SetHighlightedPurchaseTierFromItemList(f1_arg1, element)
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
			SetPerControllerTableProperty(f1_arg1, "allowTierPurchase", true)
			CoD.BlackMarketUtility.TriggerRevealAnimation(f1_arg1, element)
		end
		return f8_local0
	end)
	ItemList:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_right"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ItemList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetCurrentElementAsActive(self, element, controller)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(menu, element, controller)
			return true
		elseif AlwaysFalse() then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "ReservesPromoImagePopup", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		elseif AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_2871519113740169", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ItemList, f1_arg1, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
		if IsDpadButton(model) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 1) and not CoD.BlackMarketUtility.IsTierItemInUpsellRow(controller, element) and not IsMenuInState(menu, "Processing") then
			SetFocusedTierModelValue(controller, "1", "decrement")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			PlaySoundAlias("uin_trigger_slide")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDpadButton(nil) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 1) and not CoD.BlackMarketUtility.IsTierItemInUpsellRow(controller, element) and not IsMenuInState(menu, "Processing") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ItemList, f1_arg1, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		if IsDpadButton(model) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 5) and not IsMenuInState(menu, "Processing") then
			SetFocusedTierModelValue(controller, "1", "increment")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			PlaySoundAlias("uin_trigger_slide")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDpadButton(nil) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 5) and not IsMenuInState(menu, "Processing") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(ItemList, "childFocusGained", function(element)
		if not IsPC() then
			SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(ItemList, "setModel", function(element, controller)
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
	end)
	LUI.OverrideFunction_CallOriginalFirst(ItemList, "setDataSource", function(element, controller)
		SetCurrentElementAsActive(self, element, f1_arg1)
	end)
	ItemList:subscribeToGlobalModel(f1_arg1, "PerController", "FocusedTier", function(model)
		local f19_local0 = ItemList
		if CoD.BlackMarketUtility.HasFocusedTierValue(f1_arg1, f1_arg0) and not CoD.BlackMarketUtility.IsMenuOccluded(f1_arg0) then
			UpdateDataSource(self, f19_local0, f1_arg1)
			CoD.BlackMarketUtility.UpdateSupplyChainFocus(f1_arg1, f19_local0)
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
		end
	end)
	ItemList:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ContractsForceUpdate", function(model)
		UpdateDataSource(self, ItemList, f1_arg1)
	end)
	ItemList:subscribeToGlobalModel(f1_arg1, "PerController", "LootStreamProgress", function(model)
		UpdateDataSource(self, ItemList, f1_arg1)
		CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
		CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
	end)
	ItemList:subscribeToGlobalModel(f1_arg1, "PerController", "playContrabandReveal", function(model)
		local f22_local0 = ItemList
		if CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "playContrabandReveal") then
			SetControllerModelValue(f1_arg1, "playContrabandReveal", false)
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f22_local0)
			CoD.BlackMarketUtility.CacheContrabandRevealTier(f22_local0, f1_arg1)
			UpdateDataSource(self, f22_local0, f1_arg1)
			CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
			CoD.BlackMarketUtility.PlaceCurrentTiersWidget(f1_arg1, self, "CurrentTier")
			CoD.BlackMarketUtility.TriggerContrabandReveal(f1_arg1, f22_local0, self.SupplyChainDetails)
			CoD.BlackMarketUtility.TriggerRevealAnimation(f1_arg1, f22_local0)
			UpdateElementState(self, "DiscountDetailsWidget", f1_arg1)
		end
	end)
	self:addElement(ItemList)
	self.ItemList = ItemList
	SupplyChainDetails = CoD.SupplyChainDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, 310, 910, 0, 0, -79, 1001)
	LUI.OverrideFunction_CallOriginalFirst(SupplyChainDetails, "setModel", function(element, controller)
		UpdateElementState(self, "PurchaseButton", f1_arg1)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "TrialWidget")
	end)
	self:addElement(SupplyChainDetails)
	self.SupplyChainDetails = SupplyChainDetails
	CurrentTier = CoD.CurrentTier.new(f1_arg0, f1_arg1, 0, 0, 450, 630, 0, 0, 975, 1065)
	CurrentTier:setAlpha(0)
	self:addElement(CurrentTier)
	self.CurrentTier = CurrentTier
	PurchaseTiers = CoD.PurchaseTiers.new(f1_arg0, f1_arg1, 0, 0, 126, 306, 0, 0, 975, 1065)
	PurchaseTiers:setAlpha(0)
	self:addElement(PurchaseTiers)
	self.PurchaseTiers = PurchaseTiers
	local RightPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 236.5, 303.5, 0, 0, 194, 239)
	RightPageOver.KeyMouseImage:setImage(RegisterImage(@"uie_bumperright"))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f24_local0))
		end
	end)
	RightPageOver:registerEventHandler("gain_focus", function(element, event)
		local f25_local0 = nil
		if element.gainFocus then
			f25_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f25_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f25_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightPageOver, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_trigger_slide")
		SetFocusedTierModelValue(controller, "5", "increment")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	local RightPageOver2 = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -904, -837, 0, 0, 194, 239)
	RightPageOver2:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			RightPageOver2.ControllerImage:setImage(RegisterImage(f28_local0))
		end
	end)
	RightPageOver2:registerEventHandler("gain_focus", function(element, event)
		local f29_local0 = nil
		if element.gainFocus then
			f29_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f29_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f29_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightPageOver2, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_trigger_slide")
		SetFocusedTierModelValue(controller, "5", "decrement")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(RightPageOver2)
	self.RightPageOver2 = RightPageOver2
	local pointer = CoD.SupplyChainBumperPointers.new(f1_arg0, f1_arg1, 0.5, 0.5, -858.5, -826.5, 0, 0, 165, 245)
	pointer:setAlpha(0.8)
	self:addElement(pointer)
	self.pointer = pointer
	local pointer2 = CoD.SupplyChainBumperPointers.new(f1_arg0, f1_arg1, 0.5, 0.5, 226.5, 258.5, 0, 0, 165, 245)
	pointer2:setAlpha(0.8)
	pointer2:setYRot(180)
	self:addElement(pointer2)
	self.pointer2 = pointer2
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -841, 240, 0, 0, 176, 184)
	infoBracketBot:setRGB(0.98, 1, 0.89)
	infoBracketBot:setAlpha(0.35)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local PurchaseButton = nil
	PurchaseButton = CoD.PC_BnetStore_PurchaseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 346, 892, 0, 0, 950, 1011)
	PurchaseButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideSupplyChainPurchaseButton(f1_arg1, self.SupplyChainDetails)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local StartMenuSmallTierLevel = PurchaseButton
	local TransactionDeepLinkButton = PurchaseButton.subscribeToModel
	local StreamList = Engine[@"getglobalmodel"]()
	TransactionDeepLinkButton(StartMenuSmallTierLevel, StreamList["lobbyRoot.lobbyNetworkMode"], function(f34_arg0)
		f1_arg0:updateElementState(PurchaseButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	PurchaseButton:appendEventHandler("input_source_changed", function(f35_arg0, f35_arg1)
		f35_arg1.menu = f35_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PurchaseButton, f35_arg1)
	end)
	StartMenuSmallTierLevel = PurchaseButton
	TransactionDeepLinkButton = PurchaseButton.subscribeToModel
	StreamList = Engine[@"getmodelforcontroller"](f1_arg1)
	TransactionDeepLinkButton(StartMenuSmallTierLevel, StreamList.LastInput, function(f36_arg0)
		f1_arg0:updateElementState(PurchaseButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	PurchaseButton.ButtonTitle:setText(LocalizeToUpperString(@"menu/purchase"))
	PurchaseButton:registerEventHandler("gain_focus", function(element, event)
		local f37_local0 = nil
		if element.gainFocus then
			f37_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f37_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f37_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PurchaseButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.SetHighlightedPurchaseTierFromItemList(controller, self.ItemList)
		CoD.BlackMarketUtility.PCOpenPurchaseTiersConfirmation(self, "PurchaseTiersConfirmation", controller, self.ItemList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(PurchaseButton)
	self.PurchaseButton = PurchaseButton
	TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -605, 0.5, 0.5, 363, 435)
	TransactionDeepLinkButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsCommerceEnabledOnPC()
			end,
		},
	})
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f41_local0 = nil
		if element.gainFocus then
			f41_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f41_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f41_local0
	end)
	f1_arg0:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkBlackmarket(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkBlackmarket(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(TransactionDeepLinkButton)
	self.TransactionDeepLinkButton = TransactionDeepLinkButton
	StartMenuSmallTierLevel = CoD.StartMenu_SmallTierLevel.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -486, 0, 0, 170, 250)
	self:addElement(StartMenuSmallTierLevel)
	self.StartMenuSmallTierLevel = StartMenuSmallTierLevel
	StreamList = CoD.SupplyChainFrameContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -486, 0, 0, 254, 954)
	StreamList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f46_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContract") then
			SetElementModelToFocusedElementSubModel(self, f1_arg1, element, self.SupplyChainDetails, "contractModels")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
		return f46_local0
	end)
	self:addElement(StreamList)
	self.StreamList = StreamList
	local SpecialDeal = CoD.SpecialDeal.new(f1_arg0, f1_arg1, 0.5, 0.5, -849, -133, 0, 0, 680.5, 808.5)
	SpecialDeal:registerEventHandler("gain_focus", function(element, event)
		local f47_local0 = nil
		if element.gainFocus then
			f47_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f47_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f47_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SpecialDeal, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsElementInState(element, "HasAction") then
			CoD.BlackMarketUtility.SpecialDealAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(element, "HasAction") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(SpecialDeal)
	self.SpecialDeal = SpecialDeal
	local TrialWidget = CoD.BlackMarketTrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0, 0, 172.5, 719.5, 0, 0, 890, 925)
	TrialWidget:setScale(1.2, 1.2)
	TrialWidget:linkToElementModel(self, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	local DiscountTiersWidget = CoD.DiscountTiersContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	DiscountTiersWidget:registerEventHandler("list_item_gain_focus", function(element, event)
		local f51_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		return f51_local0
	end)
	LUI.OverrideFunction_CallOriginalFirst(DiscountTiersWidget, "childFocusGained", function(element)
		SetElementState(self, self.SupplyChainDetails, f1_arg1, "Hidden")
		SetPerControllerTableProperty(f1_arg1, "allowTierPurchase", false)
		CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
	end)
	LUI.OverrideFunction_CallOriginalFirst(DiscountTiersWidget, "childFocusLost", function(element)
		SetPerControllerTableProperty(f1_arg1, "allowTierPurchase", true)
		CoD.BlackMarketUtility.MovePurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
		UpdateElementState(self, "SupplyChainDetails", f1_arg1)
		UpdateElementState(self, "DiscountTiersWidget", f1_arg1)
	end)
	self:addElement(DiscountTiersWidget)
	self.DiscountTiersWidget = DiscountTiersWidget
	self:linkToElementModel(self, "movieName", true, function(model, f54_arg1)
		CoD.Menu.UpdateButtonShownState(f54_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	self:appendEventHandler("input_source_changed", function(f55_arg0, f55_arg1)
		f55_arg1.menu = f55_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f55_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20.LastInput, function(f56_arg0, f56_arg1)
		CoD.Menu.UpdateButtonShownState(f56_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.ItemList, controller, "movieName") and IsMouseOrKeyboard(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, self.ItemList, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.ItemList, controller, "movieName") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_0", nil, "ui_remove")
			return false
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
		if IsElementReceivingMenuOpenEventForTheFirstTime(self) and IsPC() then
			CoD.GridAndListUtility.ActivateListPCSelectionBehavior(self.ItemList)
			CoD.GridAndListUtility.DisableListActiveOnFocus(self.ItemList)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", nil, function(model)
		local f60_local0 = self
		if not CoD.BlackMarketUtility.IsMenuOccluded(f1_arg0) then
			CoD.BlackMarketUtility.ShowPostseasonPopup(f1_arg0, f1_arg1, nil)
		end
	end)
	ItemList.id = "ItemList"
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	if CoD.isPC then
		RightPageOver.id = "RightPageOver"
	end
	if CoD.isPC then
		RightPageOver2.id = "RightPageOver2"
	end
	if CoD.isPC then
		PurchaseButton.id = "PurchaseButton"
	end
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	StreamList.id = "StreamList"
	SpecialDeal.id = "SpecialDeal"
	DiscountTiersWidget.id = "DiscountTiersWidget"
	self.__defaultFocus = ItemList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local19 = self
	SetMenuProperty(f1_arg0, "_isFirstElementActive", false)
	SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "character")
	SetFocusedTierModelValue(f1_arg1, "0", "")
	SetControllerModelValue(f1_arg1, "MaxTier", CoD.BlackMarketUtility.SupplyChainMaxTiers)
	CoD.BlackMarketUtility.ShowAllRNGPopup(f1_arg0, f1_arg1, nil)
	CoD.BlackMarketUtility.SetActiveOnFirstSupplyChainElement(f1_arg1, self.ItemList, f1_arg0)
	CoD.BlackMarketUtility.InitTiersWidgetNextFrame(f1_arg1, self, f1_arg0)
	SetMenuProperty(f1_arg0, "__hideSupplyChainDetailsButtons", false)
	CoD.BlackMarketUtility.RegisterCurrentTiersWidget(f1_arg1, self, "CurrentTier")
	CoD.BlackMarketUtility.RegisterPurchaseTiersWidget(f1_arg1, self, "PurchaseTiers")
	SetElementState(self, self.SupplyChainDetails, f1_arg1, "Hidden")
	CoD.BlackMarketUtility.EnableItemshopTick(f1_arg1, self)
	f1_local19 = PurchaseButton
	if IsGameTrial() then
		ReplaceElementWithFake(self, "PurchaseButton")
	end
	f1_local19 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	return self
end
CoD.SupplyChainFrame.__onClose = function(f62_arg0)
	f62_arg0.__on_close_removeOverrides()
	f62_arg0.ItemList:close()
	f62_arg0.SupplyChainDetails:close()
	f62_arg0.CurrentTier:close()
	f62_arg0.PurchaseTiers:close()
	f62_arg0.RightPageOver:close()
	f62_arg0.RightPageOver2:close()
	f62_arg0.pointer:close()
	f62_arg0.pointer2:close()
	f62_arg0.PurchaseButton:close()
	f62_arg0.TransactionDeepLinkButton:close()
	f62_arg0.StartMenuSmallTierLevel:close()
	f62_arg0.StreamList:close()
	f62_arg0.SpecialDeal:close()
	f62_arg0.TrialWidget:close()
	f62_arg0.DiscountTiersWidget:close()
end
