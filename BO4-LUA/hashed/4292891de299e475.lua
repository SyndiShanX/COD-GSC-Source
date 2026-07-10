require("x64:9b528a05aba52d6")
require("x64:be52530c0ca57a1")
require("x64:87b99331f9f0f2e")
require("x64:d9aa3b65d03dbea")
require("x64:1b4c8138db31275")
require("x64:e640e71cf12af4c")
require("x64:b5905d805906315")
CoD.DiscountTiersContainer = InheritFrom(LUI.UIElement)
CoD.DiscountTiersContainer.__defaultWidth = 1920
CoD.DiscountTiersContainer.__defaultHeight = 1080
CoD.DiscountTiersContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DiscountTiersContainer)
	self.id = "DiscountTiersContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DiscountList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	DiscountList:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DiscountList:linkToElementModel(DiscountList, "reservesButton", true, function(model)
		f1_arg0:updateElementState(DiscountList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reservesButton",
		})
	end)
	DiscountList:linkToElementModel(DiscountList, "purchaseReservesItem", true, function(model)
		f1_arg0:updateElementState(DiscountList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchaseReservesItem",
		})
	end)
	DiscountList:linkToElementModel(DiscountList, "percentOff", true, function(model)
		f1_arg0:updateElementState(DiscountList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentOff",
		})
	end)
	DiscountList:linkToElementModel(DiscountList, "bundle", true, function(model)
		f1_arg0:updateElementState(DiscountList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bundle",
		})
	end)
	DiscountList:linkToElementModel(DiscountList, "purchased", true, function(model)
		f1_arg0:updateElementState(DiscountList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	DiscountList:linkToElementModel(DiscountList, "tiers", true, function(model)
		f1_arg0:updateElementState(DiscountList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tiers",
		})
	end)
	DiscountList:setLeftRight(0, 0, 116, 468)
	DiscountList:setTopBottom(0, 0, 832, 948)
	DiscountList:setWidgetType(CoD.DiscountTiersWidget)
	DiscountList:setSpacing(8)
	DiscountList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DiscountList:setDataSource("DiscountList")
	DiscountList:linkToElementModel(DiscountList, "bundle", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	DiscountList:linkToElementModel(DiscountList, "reservesButton", true, function(model, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	DiscountList:linkToElementModel(DiscountList, "purchaseReservesItem", true, function(model, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local DiscountDetailsWidget = DiscountList
	local ReserveDeals = DiscountList.subscribeToModel
	local ReserveDealsDetails = Engine[@"getmodelforcontroller"](f1_arg1)
	ReserveDeals(DiscountDetailsWidget, ReserveDealsDetails["LootStreamProgress.allRngUnlocked"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	DiscountDetailsWidget = DiscountList
	ReserveDeals = DiscountList.subscribeToModel
	ReserveDealsDetails = Engine[@"getmodelforcontroller"](f1_arg1)
	ReserveDeals(DiscountDetailsWidget, ReserveDealsDetails["LootStreamProgress.codPoints"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	DiscountList:registerEventHandler("occlusion_change", function(element, event)
		local f14_local0 = nil
		if element.OcclusionChange then
			f14_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f14_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			UpdateDataSource(self, element, f1_arg1)
		end
		if not f14_local0 then
			f14_local0 = element:dispatchEventToChildren(event)
		end
		return f14_local0
	end)
	DiscountList:registerEventHandler("lose_focus", function(element, event)
		local f15_local0 = nil
		if element.loseFocus then
			f15_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f15_local0 = element.super:loseFocus(event)
		end
		UpdateState(self, event)
		return f15_local0
	end)
	DiscountList:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DiscountList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "bundle") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.BlackMarketUtility.SetHighlightedPurchaseTierForSpecialDeal(controller, menu, element)
			OpenOverlay(self, "ItemShopDetails", controller, {
				_model = element:getModel(),
			})
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "reservesButton") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchaseReservesItem") and CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.BlackMarketUtility.OpenAllReservesOwnedDialog(menu, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "reservesButton") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchaseReservesItem") and CanPurchaseItem(controller, element) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "PurchaseReservesItem", controller, {
				_model = DataSources.ReservesLootBundleCrate.getModel(controller),
				_properties = {
					_isOtherBlackMarketTab = true,
				},
			})
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "reservesButton") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchaseReservesItem") then
			OpenPopup(self, "PurchaseCodPoints", controller, element:getModel())
			return true
		else
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.BlackMarketUtility.SpecialDealAction(self, element, controller, menu)
			PlaySoundAlias("uin_toggle_generic")
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	DiscountList:linkToElementModel(self, "percentOff", true, function(model)
		local f19_local0 = DiscountList
		UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
	end)
	self:addElement(DiscountList)
	self.DiscountList = DiscountList
	ReserveDeals = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	ReserveDeals:setLeftRight(0, 0, 468, 1180)
	ReserveDeals:setTopBottom(0, 0, 832, 948)
	ReserveDeals:setWidgetType(CoD.ReserveDealsWidget)
	ReserveDeals:setHorizontalCount(2)
	ReserveDeals:setSpacing(8)
	ReserveDeals:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ReserveDeals:setDataSource("ReserveDealsList")
	ReserveDeals:registerEventHandler("occlusion_change", function(element, event)
		local f20_local0 = nil
		if element.OcclusionChange then
			f20_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f20_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			UpdateDataSource(self, element, f1_arg1)
		end
		if not f20_local0 then
			f20_local0 = element:dispatchEventToChildren(event)
		end
		return f20_local0
	end)
	ReserveDeals:registerEventHandler("lose_focus", function(element, event)
		local f21_local0 = nil
		if element.loseFocus then
			f21_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f21_local0 = element.super:loseFocus(event)
		end
		UpdateState(self, event)
		return f21_local0
	end)
	ReserveDeals:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f22_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ReserveDeals, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(ReserveDeals)
	self.ReserveDeals = ReserveDeals
	DiscountDetailsWidget = CoD.DiscountDetailsWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 310, 910, 0, 0, -79, 1001)
	DiscountDetailsWidget:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ShowDetails",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bundleTitleRef")
			end,
		},
	})
	DiscountDetailsWidget:linkToElementModel(DiscountDetailsWidget, "bundleTitleRef", true, function(model)
		f1_arg0:updateElementState(DiscountDetailsWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bundleTitleRef",
		})
	end)
	self:addElement(DiscountDetailsWidget)
	self.DiscountDetailsWidget = DiscountDetailsWidget
	ReserveDealsDetails = CoD.SupplyChainDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, 310, 910, 0, 0, -79, 1001)
	LUI.OverrideFunction_CallOriginalFirst(ReserveDealsDetails, "setModel", function(element, controller)
		UpdateElementState(self, "PurchaseButton", f1_arg1)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "TrialWidget")
	end)
	self:addElement(ReserveDealsDetails)
	self.ReserveDealsDetails = ReserveDealsDetails
	DiscountDetailsWidget:linkToElementModel(DiscountList, nil, false, function(model)
		DiscountDetailsWidget:setModel(model, f1_arg1)
	end)
	ReserveDealsDetails:linkToElementModel(ReserveDeals, nil, false, function(model)
		ReserveDealsDetails:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "ReserveDetailsHideDiscount",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_sunsetBlackjackShopActive") and IsWidgetInFocus(self, "ReserveDeals", event)
			end,
		},
		{
			stateName = "HideDetailsHideDiscount",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
			end,
		},
		{
			stateName = "DiscountDetails",
			condition = function(menu, element, event)
				return IsWidgetInFocus(self, "DiscountList", event)
			end,
		},
		{
			stateName = "ReserveDetails",
			condition = function(menu, element, event)
				return IsWidgetInFocus(self, "ReserveDeals", event)
			end,
		},
		{
			stateName = "HideDetails",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:appendEventHandler("record_curr_focused_elem_id", function(f36_arg0, f36_arg1)
		f36_arg1.menu = f36_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f36_arg1)
	end)
	DiscountList.id = "DiscountList"
	ReserveDeals.id = "ReserveDeals"
	if CoD.isPC then
		ReserveDealsDetails.id = "ReserveDealsDetails"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = DiscountList
	if IsPC() then
		SetElementProperty(f1_local5, "doNotResizeOnUpdateLayout", true)
	end
	f1_local5 = ReserveDeals
	if IsPC() then
		SetElementProperty(f1_local5, "doNotResizeOnUpdateLayout", true)
	else
		CoD.BaseUtility.DisableNavigation(f1_local5)
	end
	SetElementProperty(ReserveDealsDetails, "__selfHideSupplyChainDetailsButtons", true)
	return self
end
CoD.DiscountTiersContainer.__resetProperties = function(f37_arg0)
	f37_arg0.ReserveDealsDetails:completeAnimation()
	f37_arg0.DiscountDetailsWidget:completeAnimation()
	f37_arg0.ReserveDeals:completeAnimation()
	f37_arg0.DiscountList:completeAnimation()
	f37_arg0.ReserveDealsDetails:setAlpha(1)
	f37_arg0.DiscountDetailsWidget:setAlpha(1)
	f37_arg0.ReserveDeals:setLeftRight(0, 0, 468, 1180)
	f37_arg0.DiscountList:setAlpha(1)
end
CoD.DiscountTiersContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.DiscountDetailsWidget:completeAnimation()
			f38_arg0.DiscountDetailsWidget:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.DiscountDetailsWidget)
			f38_arg0.ReserveDealsDetails:completeAnimation()
			f38_arg0.ReserveDealsDetails:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ReserveDealsDetails)
		end,
	},
	ReserveDetailsHideDiscount = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(3)
			f39_arg0.DiscountList:completeAnimation()
			f39_arg0.DiscountList:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.DiscountList)
			f39_arg0.ReserveDeals:completeAnimation()
			f39_arg0.ReserveDeals:setLeftRight(0, 0, 116, 828)
			f39_arg0.clipFinished(f39_arg0.ReserveDeals)
			f39_arg0.DiscountDetailsWidget:completeAnimation()
			f39_arg0.DiscountDetailsWidget:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.DiscountDetailsWidget)
		end,
	},
	HideDetailsHideDiscount = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(4)
			f40_arg0.DiscountList:completeAnimation()
			f40_arg0.DiscountList:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.DiscountList)
			f40_arg0.ReserveDeals:completeAnimation()
			f40_arg0.ReserveDeals:setLeftRight(0, 0, 116, 828)
			f40_arg0.clipFinished(f40_arg0.ReserveDeals)
			f40_arg0.DiscountDetailsWidget:completeAnimation()
			f40_arg0.DiscountDetailsWidget:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.DiscountDetailsWidget)
			f40_arg0.ReserveDealsDetails:completeAnimation()
			f40_arg0.ReserveDealsDetails:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.ReserveDealsDetails)
		end,
	},
	DiscountDetails = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			f41_arg0.DiscountDetailsWidget:completeAnimation()
			f41_arg0.DiscountDetailsWidget:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.DiscountDetailsWidget)
			f41_arg0.ReserveDealsDetails:completeAnimation()
			f41_arg0.ReserveDealsDetails:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ReserveDealsDetails)
		end,
	},
	ReserveDetails = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.DiscountDetailsWidget:completeAnimation()
			f42_arg0.DiscountDetailsWidget:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.DiscountDetailsWidget)
			f42_arg0.ReserveDealsDetails:completeAnimation()
			f42_arg0.ReserveDealsDetails:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.ReserveDealsDetails)
		end,
	},
	HideDetails = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			f43_arg0.DiscountDetailsWidget:completeAnimation()
			f43_arg0.DiscountDetailsWidget:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.DiscountDetailsWidget)
			f43_arg0.ReserveDealsDetails:completeAnimation()
			f43_arg0.ReserveDealsDetails:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ReserveDealsDetails)
		end,
	},
}
CoD.DiscountTiersContainer.__onClose = function(f44_arg0)
	f44_arg0.DiscountDetailsWidget:close()
	f44_arg0.ReserveDealsDetails:close()
	f44_arg0.DiscountList:close()
	f44_arg0.ReserveDeals:close()
end
