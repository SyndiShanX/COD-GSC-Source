require("x64:fc0f7412b0fb282")
require("x64:39d9212b99bae0b")
require("x64:277d08dca360631")
require("x64:3b50d7628cfd730")
require("x64:27d8fc35e68e24e")
require("x64:6ffd0cbc81f637b")
require("x64:40d0ea25e914a88")
require("x64:35653ef4ad2299d")
CoD.ReservesButtonLayout = InheritFrom(LUI.UIElement)
CoD.ReservesButtonLayout.__defaultWidth = 991
CoD.ReservesButtonLayout.__defaultHeight = 528
CoD.ReservesButtonLayout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "reservesSpecialOfferAvailable", false)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "reservesViewingCrates", false)
	self:setClass(CoD.ReservesButtonLayout)
	self.id = "ReservesButtonLayout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DotLineTop = CoD.ReservesButtonLayoutBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 750, 0, 0, 0, 528)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	local CrateCarousel = CoD.ReservesCrateCarousel.new(f1_arg0, f1_arg1, 0, 0, 207.5, 455.5, 0, 0, 34, 496)
	self:addElement(CrateCarousel)
	self.CrateCarousel = CrateCarousel
	local OffersCarousel = CoD.ReservesOffersCarousel.new(f1_arg0, f1_arg1, 0, 0, 469, 717, 0, 0, 34, 496)
	self:addElement(OffersCarousel)
	self.OffersCarousel = OffersCarousel
	local ReservesBribeStackCarousel = CoD.ReservesBribeStackCarousel.new(f1_arg0, f1_arg1, 0, 0, 743, 991, 0, 0, 34, 496)
	self:addElement(ReservesBribeStackCarousel)
	self.ReservesBribeStackCarousel = ReservesBribeStackCarousel
	local LootCaseButton = CoD.ReservesLootButtonsGroup.new(f1_arg0, f1_arg1, 0, 0, 33, 193, 0, 0, 33, 494)
	self:addElement(LootCaseButton)
	self.LootCaseButton = LootCaseButton
	local NoDupeCrate = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, true, false, false, false)
	NoDupeCrate:setLeftRight(0, 0, 743, 991)
	NoDupeCrate:setTopBottom(0, 0, 34, 496)
	NoDupeCrate:setAlpha(0)
	NoDupeCrate:setWidgetType(CoD.ReservesBribeStack)
	NoDupeCrate:setSpacing(12)
	NoDupeCrate:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NoDupeCrate:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	NoDupeCrate:setDataSource("NoDupeBribeStack")
	local f1_local7 = NoDupeCrate
	local f1_local8 = NoDupeCrate.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["LootStreamProgress.allRngUnlocked"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	NoDupeCrate:linkToElementModel(NoDupeCrate, "purchased", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	NoDupeCrate:registerEventHandler("gain_list_focus", function(element, event)
		local f4_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", false)
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, element)
		return f4_local0
	end)
	NoDupeCrate:registerEventHandler("lose_list_focus", function(element, event)
		local f5_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", true)
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, element)
		return f5_local0
	end)
	NoDupeCrate:registerEventHandler("gain_focus", function(element, event)
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
	f1_arg0:AddButtonCallbackFunction(NoDupeCrate, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(NoDupeCrate, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(NoDupeCrate, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.BlackMarketUtility.OpenAllReservesOwnedDialog(menu, controller)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchased") then
			OpenOverlay(self, "PurchaseBribeStack", controller, {
				_model = element:getModel(),
			})
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsControllerModelValueTrue(controller, "LootStreamProgress.allRngUnlocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/purchase", nil, nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchased") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/purchase", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(NoDupeCrate, "updateDataSource", function(element, controller, f13_arg2, f13_arg3)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(element)
	end)
	self:addElement(NoDupeCrate)
	self.NoDupeCrate = NoDupeCrate
	self:mergeStateConditions({
		{
			stateName = "SunsetNoDupe",
			condition = function(menu, element, event)
				local f14_local0 = IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
				if f14_local0 then
					f14_local0 = IsBooleanDvarSet("loot_purchase_no_dupe")
					if f14_local0 then
						f14_local0 = CoD.GridAndListUtility.ListElementHasAtLeastNumElements(self.CrateCarousel, 1)
					end
				end
				return f14_local0
			end,
		},
		{
			stateName = "SunsetNoDupeShort",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_sunsetBlackjackShopActive") and IsBooleanDvarSet("loot_purchase_no_dupe")
			end,
		},
		{
			stateName = "Sunset",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
			end,
		},
		{
			stateName = "NDCEnabledAndHasSpecialOffers",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsDvarEnabled("ui_enableNoDupeCrates") and CoD.ModelUtility.IsModelValueTrue(f1_arg1, "reservesSpecialOfferAvailable")
			end,
		},
		{
			stateName = "NDCEnabled",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsDvarEnabled("ui_enableNoDupeCrates")
			end,
		},
		{
			stateName = "HasSpecialOffers",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "reservesSpecialOfferAvailable")
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f20_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.reservesSpecialOfferAvailable, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "reservesSpecialOfferAvailable",
		})
	end, false)
	CrateCarousel.id = "CrateCarousel"
	OffersCarousel.id = "OffersCarousel"
	ReservesBribeStackCarousel.id = "ReservesBribeStackCarousel"
	LootCaseButton.id = "LootCaseButton"
	NoDupeCrate.id = "NoDupeCrate"
	self.__defaultFocus = LootCaseButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	f1_local8 = NoDupeCrate
	CoD.BaseUtility.DisableNavigation(f1_local8)
	SetElementProperty(f1_local8, "__loopOnSameRow", true)
	SetElementProperty(f1_local8, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local8)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local8, 0.5)
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f1_local8)
	return self
end
CoD.ReservesButtonLayout.__resetProperties = function(f22_arg0)
	f22_arg0.DotLineTop:completeAnimation()
	f22_arg0.ReservesBribeStackCarousel:completeAnimation()
	f22_arg0.OffersCarousel:completeAnimation()
	f22_arg0.CrateCarousel:completeAnimation()
	f22_arg0.NoDupeCrate:completeAnimation()
	f22_arg0.DotLineTop:setLeftRight(0, 0, 0, 750)
	f22_arg0.ReservesBribeStackCarousel:setLeftRight(0, 0, 743, 991)
	f22_arg0.ReservesBribeStackCarousel:setAlpha(1)
	f22_arg0.OffersCarousel:setLeftRight(0, 0, 469, 717)
	f22_arg0.OffersCarousel:setAlpha(1)
	f22_arg0.CrateCarousel:setLeftRight(0, 0, 207.5, 455.5)
	f22_arg0.CrateCarousel:setAlpha(1)
	f22_arg0.NoDupeCrate:setLeftRight(0, 0, 743, 991)
	f22_arg0.NoDupeCrate:setAlpha(0)
end
CoD.ReservesButtonLayout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.DotLineTop:completeAnimation()
			f23_arg0.DotLineTop:setLeftRight(0, 0, 9, 478)
			f23_arg0.clipFinished(f23_arg0.DotLineTop)
			f23_arg0.ReservesBribeStackCarousel:completeAnimation()
			f23_arg0.ReservesBribeStackCarousel:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ReservesBribeStackCarousel)
		end,
	},
	SunsetNoDupe = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(5)
			f24_arg0.DotLineTop:completeAnimation()
			f24_arg0.DotLineTop:setLeftRight(0, 0, 0, 1023)
			f24_arg0.clipFinished(f24_arg0.DotLineTop)
			f24_arg0.CrateCarousel:completeAnimation()
			f24_arg0.CrateCarousel:setLeftRight(0, 0, 743, 991)
			f24_arg0.clipFinished(f24_arg0.CrateCarousel)
			f24_arg0.OffersCarousel:completeAnimation()
			f24_arg0.OffersCarousel:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.OffersCarousel)
			f24_arg0.ReservesBribeStackCarousel:completeAnimation()
			f24_arg0.ReservesBribeStackCarousel:setLeftRight(0, 0, 469, 717)
			f24_arg0.ReservesBribeStackCarousel:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ReservesBribeStackCarousel)
			f24_arg0.NoDupeCrate:completeAnimation()
			f24_arg0.NoDupeCrate:setLeftRight(0, 0, 207.5, 455.5)
			f24_arg0.NoDupeCrate:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.NoDupeCrate)
		end,
	},
	SunsetNoDupeShort = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(5)
			f25_arg0.DotLineTop:completeAnimation()
			f25_arg0.DotLineTop:setLeftRight(0, 0, 0, 743)
			f25_arg0.clipFinished(f25_arg0.DotLineTop)
			f25_arg0.CrateCarousel:completeAnimation()
			f25_arg0.CrateCarousel:setLeftRight(0, 0, 743, 991)
			f25_arg0.clipFinished(f25_arg0.CrateCarousel)
			f25_arg0.OffersCarousel:completeAnimation()
			f25_arg0.OffersCarousel:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.OffersCarousel)
			f25_arg0.ReservesBribeStackCarousel:completeAnimation()
			f25_arg0.ReservesBribeStackCarousel:setLeftRight(0, 0, 469, 717)
			f25_arg0.ReservesBribeStackCarousel:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.ReservesBribeStackCarousel)
			f25_arg0.NoDupeCrate:completeAnimation()
			f25_arg0.NoDupeCrate:setLeftRight(0, 0, 207.5, 455.5)
			f25_arg0.NoDupeCrate:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.NoDupeCrate)
		end,
	},
	Sunset = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(5)
			f26_arg0.DotLineTop:completeAnimation()
			f26_arg0.DotLineTop:setLeftRight(0, 0, 0, 1023)
			f26_arg0.clipFinished(f26_arg0.DotLineTop)
			f26_arg0.CrateCarousel:completeAnimation()
			f26_arg0.CrateCarousel:setLeftRight(0, 0, 743, 991)
			f26_arg0.clipFinished(f26_arg0.CrateCarousel)
			f26_arg0.OffersCarousel:completeAnimation()
			f26_arg0.OffersCarousel:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.OffersCarousel)
			f26_arg0.ReservesBribeStackCarousel:completeAnimation()
			f26_arg0.ReservesBribeStackCarousel:setLeftRight(0, 0, 469, 717)
			f26_arg0.ReservesBribeStackCarousel:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.ReservesBribeStackCarousel)
			f26_arg0.NoDupeCrate:completeAnimation()
			f26_arg0.NoDupeCrate:setLeftRight(0, 0, 207.5, 455.5)
			f26_arg0.NoDupeCrate:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.NoDupeCrate)
		end,
	},
	NDCEnabledAndHasSpecialOffers = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			f27_arg0.DotLineTop:completeAnimation()
			f27_arg0.DotLineTop:setLeftRight(0, 0, -7, 1016)
			f27_arg0.clipFinished(f27_arg0.DotLineTop)
			f27_arg0.CrateCarousel:completeAnimation()
			f27_arg0.CrateCarousel:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.CrateCarousel)
			f27_arg0.OffersCarousel:completeAnimation()
			f27_arg0.OffersCarousel:setLeftRight(0, 0, 730.5, 978.5)
			f27_arg0.clipFinished(f27_arg0.OffersCarousel)
			f27_arg0.ReservesBribeStackCarousel:completeAnimation()
			f27_arg0.ReservesBribeStackCarousel:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ReservesBribeStackCarousel)
			f27_arg0.NoDupeCrate:completeAnimation()
			f27_arg0.NoDupeCrate:setLeftRight(0, 0, 469, 717)
			f27_arg0.NoDupeCrate:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.NoDupeCrate)
		end,
	},
	NDCEnabled = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			f28_arg0.OffersCarousel:completeAnimation()
			f28_arg0.OffersCarousel:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.OffersCarousel)
			f28_arg0.ReservesBribeStackCarousel:completeAnimation()
			f28_arg0.ReservesBribeStackCarousel:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ReservesBribeStackCarousel)
			f28_arg0.NoDupeCrate:completeAnimation()
			f28_arg0.NoDupeCrate:setLeftRight(0, 0, 469, 717)
			f28_arg0.NoDupeCrate:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.NoDupeCrate)
		end,
	},
	HasSpecialOffers = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.ReservesBribeStackCarousel:completeAnimation()
			f29_arg0.ReservesBribeStackCarousel:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ReservesBribeStackCarousel)
		end,
	},
}
CoD.ReservesButtonLayout.__onClose = function(f30_arg0)
	f30_arg0.DotLineTop:close()
	f30_arg0.CrateCarousel:close()
	f30_arg0.OffersCarousel:close()
	f30_arg0.ReservesBribeStackCarousel:close()
	f30_arg0.LootCaseButton:close()
	f30_arg0.NoDupeCrate:close()
end
