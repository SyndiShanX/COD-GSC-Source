require("x64:f7139f69731b8c1")
require("x64:f765dee1e5ccee0")
require("x64:6abd6dcfe95863d")
require("x64:be52530c0ca57a1")
require("x64:62f021f9ada720d")
require("x64:1f846296f1a1b81")
require("x64:772a6846d311d82")
CoD.ItemDetailsSunsetPurchaseContainer = InheritFrom(LUI.UIElement)
CoD.ItemDetailsSunsetPurchaseContainer.__defaultWidth = 454
CoD.ItemDetailsSunsetPurchaseContainer.__defaultHeight = 91
CoD.ItemDetailsSunsetPurchaseContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemDetailsSunsetPurchaseContainer)
	self.id = "ItemDetailsSunsetPurchaseContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PriceText = LUI.UIText.new(0, 0, 7.5, 207.5, 0, 0, 63, 91)
	PriceText:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	PriceText:setTTF("ttmussels_demibold")
	PriceText:setLetterSpacing(2)
	PriceText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PriceText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PriceText:linkToElementModel(self, "price", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PriceText:setText(LocalizeIntoString(@"hash_56A3CC7BE3008989", f2_local0))
		end
	end)
	self:addElement(PriceText)
	self.PriceText = PriceText
	local CasePriceText = CoD.ItemDetailsCasePrice.new(f1_arg0, f1_arg1, 0, 0, 246, 446, 0, 0, 63, 91)
	CasePriceText:linkToElementModel(self, nil, false, function(model)
		CasePriceText:setModel(model, f1_arg1)
	end)
	self:addElement(CasePriceText)
	self.CasePriceText = CasePriceText
	local ItemShopButtonCP = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 215, 0, 0, 0, 52)
	ItemShopButtonCP:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ArenaSuspended",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemShopButtonCP.MiddleText:setText(LocalizeToUpperString(@"menu/purchase"))
	ItemShopButtonCP.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/purchase"))
	local f1_local4 = ItemShopButtonCP
	local ItemShopButtonCases = ItemShopButtonCP.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	ItemShopButtonCases(f1_local4, f1_local6["LootStreamProgress.codPoints"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ItemShopButtonCP:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ItemShopButtonCP, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if MenuPropertyIsTrue(menu, "isSunsetPurchaseContractScreen") and CanPurchaseItem(controller, self) then
			OpenPopup(self, "PurchaseContractConfirmationSunset", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		elseif CanPurchaseItem(controller, self) then
			OpenPopup(self, "ItemShopConfirmation", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		else
			OpenPopup(self, "PurchaseCodPoints", controller, menu:getModel())
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(ItemShopButtonCP)
	self.ItemShopButtonCP = ItemShopButtonCP
	ItemShopButtonCases = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 0, 238.5, 453.5, 0, 0, 0, 52)
	ItemShopButtonCases:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ArenaSuspended",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.CanExchangeLootCases(f1_arg1, self)
			end,
		},
	})
	f1_local6 = ItemShopButtonCases
	f1_local4 = ItemShopButtonCases.subscribeToModel
	local f1_local7 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	f1_local4(f1_local6, f1_local7.lootCaseCount, function(f16_arg0)
		f1_arg0:updateElementState(ItemShopButtonCases, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lootCaseCount",
		})
	end, false)
	ItemShopButtonCases:linkToElementModel(ItemShopButtonCases, "casePrice", true, function(model)
		f1_arg0:updateElementState(ItemShopButtonCases, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "casePrice",
		})
	end)
	ItemShopButtonCases.MiddleText:setText(LocalizeToUpperString(@"hash_7C2737E72EC4A26"))
	ItemShopButtonCases.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_7C2737E72EC4A26"))
	f1_local6 = ItemShopButtonCases
	f1_local4 = ItemShopButtonCases.subscribeToModel
	f1_local7 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	f1_local4(f1_local6, f1_local7.lootCaseCount, function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ItemShopButtonCases:linkToElementModel(ItemShopButtonCases, "casePrice", true, function(model, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ItemShopButtonCases:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ItemShopButtonCases, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if MenuPropertyIsTrue(menu, "isSunsetPurchaseContractScreen") and CoD.BlackMarketUtility.CanExchangeLootCases(controller, self) then
			OpenPopup(self, "CaseExchangeContractConfirmation", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		elseif CoD.BlackMarketUtility.CanExchangeLootCases(controller, self) then
			OpenPopup(self, "ItemShopCaseExchangeConfirmation", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if MenuPropertyIsTrue(menu, "isSunsetPurchaseContractScreen") and CoD.BlackMarketUtility.CanExchangeLootCases(controller, self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CoD.BlackMarketUtility.CanExchangeLootCases(controller, self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(ItemShopButtonCases)
	self.ItemShopButtonCases = ItemShopButtonCases
	self:mergeStateConditions({
		{
			stateName = "CPOnly",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "casePrice", 0)
			end,
		},
		{
			stateName = "CaseOnly",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "price", 0)
			end,
		},
	})
	self:linkToElementModel(self, "casePrice", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "casePrice",
		})
	end)
	self:linkToElementModel(self, "price", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "price",
		})
	end)
	ItemShopButtonCP.id = "ItemShopButtonCP"
	ItemShopButtonCases.id = "ItemShopButtonCases"
	self.__defaultFocus = ItemShopButtonCP
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemDetailsSunsetPurchaseContainer.__resetProperties = function(f27_arg0)
	f27_arg0.ItemShopButtonCases:completeAnimation()
	f27_arg0.ItemShopButtonCP:completeAnimation()
	f27_arg0.PriceText:completeAnimation()
	f27_arg0.CasePriceText:completeAnimation()
	f27_arg0.ItemShopButtonCases:setLeftRight(0, 0, 238.5, 453.5)
	f27_arg0.ItemShopButtonCases:setAlpha(1)
	f27_arg0.ItemShopButtonCP:setLeftRight(0, 0, 0, 215)
	f27_arg0.ItemShopButtonCP:setAlpha(1)
	f27_arg0.PriceText:setLeftRight(0, 0, 7.5, 207.5)
	f27_arg0.PriceText:setAlpha(1)
	f27_arg0.CasePriceText:setLeftRight(0, 0, 246, 446)
	f27_arg0.CasePriceText:setAlpha(1)
end
CoD.ItemDetailsSunsetPurchaseContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	CPOnly = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(4)
			f29_arg0.PriceText:completeAnimation()
			f29_arg0.PriceText:setLeftRight(0, 0, 0, 454)
			f29_arg0.clipFinished(f29_arg0.PriceText)
			f29_arg0.CasePriceText:completeAnimation()
			f29_arg0.CasePriceText:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.CasePriceText)
			f29_arg0.ItemShopButtonCP:completeAnimation()
			f29_arg0.ItemShopButtonCP:setLeftRight(0, 0, 0, 454)
			f29_arg0.clipFinished(f29_arg0.ItemShopButtonCP)
			f29_arg0.ItemShopButtonCases:completeAnimation()
			f29_arg0.ItemShopButtonCases:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ItemShopButtonCases)
		end,
	},
	CaseOnly = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			f30_arg0.PriceText:completeAnimation()
			f30_arg0.PriceText:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.PriceText)
			f30_arg0.CasePriceText:completeAnimation()
			f30_arg0.CasePriceText:setLeftRight(0, 0, 0, 454)
			f30_arg0.clipFinished(f30_arg0.CasePriceText)
			f30_arg0.ItemShopButtonCP:completeAnimation()
			f30_arg0.ItemShopButtonCP:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ItemShopButtonCP)
			f30_arg0.ItemShopButtonCases:completeAnimation()
			f30_arg0.ItemShopButtonCases:setLeftRight(0, 0, 0, 454)
			f30_arg0.clipFinished(f30_arg0.ItemShopButtonCases)
		end,
	},
}
CoD.ItemDetailsSunsetPurchaseContainer.__onClose = function(f31_arg0)
	f31_arg0.PriceText:close()
	f31_arg0.CasePriceText:close()
	f31_arg0.ItemShopButtonCP:close()
	f31_arg0.ItemShopButtonCases:close()
end
