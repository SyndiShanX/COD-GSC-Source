require("x64:be52530c0ca57a1")
require("x64:ffbc64370f13dd9")
require("x64:b8e2ca68acca1fd")
require("x64:db806626fb64f10")
require("x64:2cf4ad39ea2c548")
require("x64:599b7e2c6f2fec4")
require("x64:156d841adc02c80")
CoD.QuarterMasterMenu = InheritFrom(CoD.Menu)
LUI.createMenu.QuarterMasterMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("QuarterMasterMenu", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitGlobalModel("ContractsForceUpdate", nil)
	CoD.BaseUtility.InitPersistentControllerModelIfNotSet(f1_arg0, "LootStreamProgress.pagedRequestStatus", nil)
	CoD.BlackMarketUtility.CreatePersistentPagedRequestModel(f1_arg0)
	CoD.BlackMarketUtility.ResetSignatureWeaponState(f1_local1)
	CoD.BlackMarketUtility.EnableItemshopTick(f1_arg0, self)
	SetPerControllerTableProperty(f1_arg0, "inBlackMarket", true)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BlackMarketUtility.ClearRNGModels(f1_arg0)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "playContrabandReveal", false)
	CoD.BlackMarketUtility.EnableReserveDealsTick(f1_arg0, self)
	CoD.BlackMarketUtility.EnableBribeMenuTick(f1_arg0, self)
	self:setClass(CoD.QuarterMasterMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ItemShopBackgroundBlur = CoD.ItemShopBackgroundBlur.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ItemShopBackgroundBlur)
	self.ItemShopBackgroundBlur = ItemShopBackgroundBlur
	local Frame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	Frame:setLeftRight(0, 1, 0, 0)
	Frame:setTopBottom(0, 1, 0, 0)
	self:addElement(Frame)
	self.Frame = Frame
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
	local TabBarContainer = CoD.ItemShopTabBarContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	TabBarContainer:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	TabBarContainer:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "category", "inventory") then
			SetElementState(self, self.ItemShopBackgroundBlur, f1_arg0, "DefaultState")
			CoD.BlackMarketUtility.SetQuarterMasterMenuCurrentTab(element, f1_arg0, f1_local1)
			CoD.MetricsUtility.BlackMarketTabChange(f1_local1, element, f1_arg0)
		elseif not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "category", "inventory") then
			SetElementState(self, self.ItemShopBackgroundBlur, f1_arg0, "Hidden")
			CoD.BlackMarketUtility.SetQuarterMasterMenuCurrentTab(element, f1_arg0, f1_local1)
			CoD.MetricsUtility.BlackMarketTabChange(f1_local1, element, f1_arg0)
		end
		return f4_local0
	end)
	self:addElement(TabBarContainer)
	self.TabBarContainer = TabBarContainer
	local SpinnerLoadingAnimation = CoD.SpinnerLoadingAnimation.new(f1_local1, f1_arg0, 0, 0, 930, 990, 0, 0, 510, 570)
	SpinnerLoadingAnimation:setAlpha(0)
	self:addElement(SpinnerLoadingAnimation)
	self.SpinnerLoadingAnimation = SpinnerLoadingAnimation
	Frame:linkToElementModel(TabBarContainer.FETabBar.Tabs.grid, "frameWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Frame:changeFrameWidget(f5_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Processing",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "LootStreamProgress.pagedRequestStatus", "Requested")
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["LootStreamProgress.pagedRequestStatus"], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "LootStreamProgress.pagedRequestStatus",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["LootStreamProgress.pagedRequestStatus"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNetworkMode"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = DataSources.AutoEvents.getModel(f1_arg0)
	f1_local8(f1_local7, f1_local9.cycled, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9.LastInput, function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f13_local0 = nil
		if self.OcclusionChange then
			f13_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f13_local0 = self.super:OcclusionChange(event)
		end
		UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
		if not f13_local0 then
			f13_local0 = self:dispatchEventToChildren(event)
		end
		return f13_local0
	end)
	self:registerEventHandler("list_active_changed", function(self, event)
		local f14_local0 = nil
		CoD.BlackMarketUtility.MarkTabAsSeen(f1_arg0, f1_local1)
		return f14_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		PlaySoundAlias("uin_cmn_backout")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_contextual_3", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsModelValueEqualTo(controller, "LootStreamProgress.pagedRequestStatus", "Requested") and IsCommerceEnabledOnPC() and AreCodPointsEnabled(controller) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) and not IsGameTrial() then
			OpenPopup(self, "PurchaseCodPoints", controller)
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsModelValueEqualTo(controller, "LootStreamProgress.pagedRequestStatus", "Requested") and IsCommerceEnabledOnPC() and AreCodPointsEnabled(controller) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_263D5409DEC36DFA", nil, "ui_contextual_3")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], nil, function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_rtrig"]) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) then
			CoD.BlackMarketUtility.PageStreamHoldUpdateAction(menu)
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "increment")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_rtrig"]) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], nil, function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_ltrig"]) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) then
			CoD.BlackMarketUtility.PageStreamHoldUpdateAction(menu)
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "decrement")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_ltrig"]) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and CoD.BlackMarketUtility.ShowPurchaseTiersPrompt(controller, self.Frame, "PurchaseTiers") and AreCodPointsEnabled(controller) and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) and not IsGameTrial() then
			CoD.BlackMarketUtility.SetHighlightedPurchaseTier(controller, self.Frame)
			CoD.BlackMarketUtility.OpenPurchaseTiersConfirmation(controller, self, self.Frame)
			PlaySoundSetSound(self, "action")
			return true
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and AreCodPointsEnabled(controller) and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) and not IsGameTrial() then
			CoD.BlackMarketUtility.SetHighlightedPurchaseTier(controller, self.Frame)
			CoD.BlackMarketUtility.OpenPurchaseTiersConfirmation(controller, self, self.Frame)
			PlaySoundSetSound(self, "action")
			return true
		elseif IsDesiredFrameWidget(controller, self.Frame, "BlackjackReserveFrame") and CoD.BlackMarketUtility.CanShowReservesPreview(controller) and IsGamepad(controller) then
			CoD.BlackMarketUtility.PlayReservesPreviewVideo(controller, menu, false, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and CoD.BlackMarketUtility.ShowPurchaseTiersPrompt(controller, self.Frame, "PurchaseTiers") and AreCodPointsEnabled(controller) and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_5FAF2C4773992641", nil, nil)
			return true
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") and AreCodPointsEnabled(controller) and IsPerControllerTablePropertyValue(controller, "allowTierPurchase", true) and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		elseif IsDesiredFrameWidget(controller, self.Frame, "BlackjackReserveFrame") and CoD.BlackMarketUtility.CanShowReservesPreview(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_remove", function(element, menu, controller, model)
		if IsDesiredFrameWidget(controller, self.Frame, "BlackjackReserveFrame") and CoD.BlackMarketUtility.CanShowReservesPreview(controller) and IsMouseOrKeyboard(controller) then
			CoD.BlackMarketUtility.PlayReservesPreviewVideo(controller, menu, false, true)
			return true
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil(self.Frame, controller, "movieName") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "movieName", "") and not IsMenuInState(menu, "Processing") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.BlackMarketUtility.SetupSupplyChainMovie(self.Frame, controller, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "allowFrozenMoment", true) and not IsMenuInState(menu, "Processing") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDesiredFrameWidget(controller, self.Frame, "BlackjackReserveFrame") and CoD.BlackMarketUtility.CanShowReservesPreview(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_remove")
			return false
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil(self.Frame, controller, "movieName") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "movieName", "") and not IsMenuInState(menu, "Processing") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_remove")
			return false
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "allowFrozenMoment", true) and not IsMenuInState(menu, "Processing") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_remove")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"], "ui_contextual_2", function(element, menu, controller, model)
		if IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and CoD.BlackMarketUtility.CanPlayGesture(self.Frame) and not IsMenuInState(menu, "Processing") then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.PlayGesture(self, self.Frame, controller)
			return true
		elseif IsDesiredFrameWidget(controller, self.Frame, "ItemShopFrame") and CoD.BlackMarketUtility.CanPlayGesture(self.Frame) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.PlayGesture(self, self.Frame, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and CoD.BlackMarketUtility.CanPlayGesture(self.Frame) and not IsMenuInState(menu, "Processing") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_0", nil, "ui_contextual_2")
			return false
		elseif IsDesiredFrameWidget(controller, self.Frame, "ItemShopFrame") and CoD.BlackMarketUtility.CanPlayGesture(self.Frame) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_0", nil, "ui_contextual_2")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], "ui_contextual_1", function(element, menu, controller, model)
		if not IsMenuInState(menu, "Processing") and CoD.BlackMarketUtility.CanToggleSignatureWeapon(self.Frame) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.ToggleSignatureWeapon(menu, controller, self.Frame)
			return true
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "allowTogglePreview", true) and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "itemCategory", @"signature_weapon") then
			CoD.BlackMarketUtility.ToggleCharacterModelCamera(menu, self.Frame, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsMenuInState(menu, "Processing") and CoD.BlackMarketUtility.CanToggleSignatureWeapon(self.Frame) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "ui_contextual_1")
			return false
		elseif IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "allowTogglePreview", true) and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(self.Frame, controller, "itemCategory", @"signature_weapon") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") then
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "increment")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") then
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "decrement")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and IsDesiredFrameWidget(controller, self.Frame, "SupplyChainFrame") and not IsMenuInState(menu, "Processing") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
			CoD.BreadcrumbUtility.UpdateStartMenuBreadcrumb(f1_arg0)
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
			ClearMenuSavedState(f1_local1)
			CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 0)
			SetPerControllerTableProperty(f1_arg0, "inBlackMarket", false)
			CoD.MetricsUtility.BlackMarketEntryEvent(f1_arg0, f1_local1)
			CoD.BlackMarketUtility.OnQuitBlackMarketCustomFunction(f1_local1, f1_arg0)
			CoD.BlackMarketUtility.ClearBlackMarketMenuForTest(f1_arg0)
		else
			CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
			CoD.BreadcrumbUtility.UpdateStartMenuBreadcrumb(f1_arg0)
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
			ClearMenuSavedState(f1_local1)
			CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 0)
			SetPerControllerTableProperty(f1_arg0, "inBlackMarket", false)
			CoD.MetricsUtility.BlackMarketEntryEvent(f1_arg0, f1_local1)
			CoD.BlackMarketUtility.ClearBlackMarketMenuForTest(f1_arg0)
		end
	end)
	Frame.id = "Frame"
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	TabBarContainer.id = "TabBarContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = Frame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local8 = self
	if not IsBooleanDvarSet("ui_enableItemShop") and not IsBooleanDvarSet("ui_enableContracts") then
		SetElementState(self, self.TabBarContainer, f1_arg0, "Hidden")
	else
		CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 1)
		CoD.BlackMarketUtility.QuarterMasterFrameChangeActions(f1_local1, self.Frame, f1_arg0)
		CoD.BlackMarketUtility.PlayBlackMarketFrontendMusic(self, f1_arg0)
		AutoSelectCodPointCategory(self, f1_arg0)
		CoD.BlackMarketUtility.SetupPageStreamHoldActionReadyCheck(f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.BlackMarketUtility.ShowFreeBundlePopupIfNeeded(self.Frame, f1_arg0)
		CoD.BlackMarketUtility.SetBlackMarketMenuForTest(f1_arg0, f1_local1)
	end
	return self
end
CoD.QuarterMasterMenu.__resetProperties = function(f36_arg0)
	f36_arg0.SpinnerLoadingAnimation:completeAnimation()
	f36_arg0.SpinnerLoadingAnimation:setAlpha(0)
end
CoD.QuarterMasterMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.SpinnerLoadingAnimation:completeAnimation()
			f37_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.SpinnerLoadingAnimation)
		end,
	},
	Processing = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.SpinnerLoadingAnimation:completeAnimation()
			f38_arg0.SpinnerLoadingAnimation:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.SpinnerLoadingAnimation)
		end,
	},
}
CoD.QuarterMasterMenu.__onClose = function(f39_arg0)
	f39_arg0.Frame:close()
	f39_arg0.ItemShopBackgroundBlur:close()
	f39_arg0.GenericMenuFrameIdentity:close()
	f39_arg0.TabBarContainer:close()
	f39_arg0.SpinnerLoadingAnimation:close()
end
