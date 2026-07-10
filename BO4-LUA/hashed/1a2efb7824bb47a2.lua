require("x64:d988b567be037bc")
require("x64:ff46188cc1c3579")
require("x64:c0e24f3dd0285d0")
require("x64:68036bda8abbe94")
require("x64:c01e8478a7d92cd")
require("x64:6735e84e8dd1117")
require("x64:767ebae822b5b13")
require("x64:5d80cb371475b19")
require("x64:a24b28b508f6914")
CoD.ContractDetailsPanelSunset = InheritFrom(LUI.UIElement)
CoD.ContractDetailsPanelSunset.__defaultWidth = 776
CoD.ContractDetailsPanelSunset.__defaultHeight = 727
CoD.ContractDetailsPanelSunset.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractDetailsPanelSunset)
	self.id = "ContractDetailsPanelSunset"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = CoD.ContractDetailsPanelBacker.new(f1_arg0, f1_arg1, 0.5, 0.5, -388, 388, 0.5, 0.5, -363.5, 363.5)
	self:addElement(Backer)
	self.Backer = Backer
	local f1_local2 = nil
	self.RewardCount = LUI.UIElement.createFake()
	local RewardCountPC = nil
	RewardCountPC = LUI.UIText.new(0.5, 0.5, -365.5, 364.5, 1, 1, -42, -18)
	RewardCountPC:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RewardCountPC:setText("")
	RewardCountPC:setTTF("ttmussels_regular")
	RewardCountPC:setLetterSpacing(2)
	RewardCountPC:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(RewardCountPC)
	self.RewardCountPC = RewardCountPC
	local Info = CoD.ContractDetailsPanelInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 804, 0, 0, 54.5, 463.5)
	Info:linkToElementModel(self, nil, false, function(model)
		Info:setModel(model, f1_arg1)
	end)
	self:addElement(Info)
	self.Info = Info
	local Header = CoD.ContractDetailsPanelHeader.new(f1_arg0, f1_arg1, 0, 0, -4, 764, 0, 0, 29, 65)
	Header:linkToElementModel(self, nil, false, function(model)
		Header:setModel(model, f1_arg1)
	end)
	self:addElement(Header)
	self.Header = Header
	local ContractProgressBar = CoD.ContractProgressBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -172, 172, 0, 0, 421, 439)
	ContractProgressBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "complete")
			end,
		},
	})
	ContractProgressBar:linkToElementModel(ContractProgressBar, "complete", true, function(model)
		f1_arg0:updateElementState(ContractProgressBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	ContractProgressBar:setScale(1.5, 1.5)
	ContractProgressBar:linkToElementModel(self, nil, false, function(model)
		ContractProgressBar:setModel(model, f1_arg1)
	end)
	self:addElement(ContractProgressBar)
	self.ContractProgressBar = ContractProgressBar
	local ActivateContractButton = CoD.ItemShopButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -109.5, 348.5, 1, 1, -384, -332)
	ActivateContractButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "complete")
			end,
		},
	})
	ActivateContractButton:linkToElementModel(ActivateContractButton, "complete", true, function(model)
		f1_arg0:updateElementState(ActivateContractButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	ActivateContractButton:setAlpha(0)
	ActivateContractButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x5AB9ECEB1A97273))
	ActivateContractButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x5AB9ECEB1A97273))
	ActivateContractButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ActivateContractButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.ContractUtility.SelectActiveContractAction(self, controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(ActivateContractButton)
	self.ActivateContractButton = ActivateContractButton
	local PurchaseContainer = CoD.ItemDetailsSunsetPurchaseContainer.new(f1_arg0, f1_arg1, 0, 0, 283, 737, 0, 0, 344, 435)
	PurchaseContainer:linkToElementModel(self, nil, false, function(model)
		PurchaseContainer:setModel(model, f1_arg1)
	end)
	self:addElement(PurchaseContainer)
	self.PurchaseContainer = PurchaseContainer
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 624.5, 736.5, 0, 0, 413, 429)
	TabbedScoreboardFuiBox:setAlpha(0)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local TabbedScoreboardFuiBox2 = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 278.5, 390.5, 0, 0, 413, 429)
	TabbedScoreboardFuiBox2:setAlpha(0)
	TabbedScoreboardFuiBox2:setZRot(180)
	self:addElement(TabbedScoreboardFuiBox2)
	self.TabbedScoreboardFuiBox2 = TabbedScoreboardFuiBox2
	local Seasonal = CoD.ContractSeasonalOverlay_InfoPanel.new(f1_arg0, f1_arg1, 0, 0, 0.5, 759.5, 0, 0, 32, 57)
	Seasonal:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "seasonal")
			end,
		},
	})
	Seasonal:linkToElementModel(Seasonal, "seasonal", true, function(model)
		f1_arg0:updateElementState(Seasonal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "seasonal",
		})
	end)
	Seasonal:linkToElementModel(self, nil, false, function(model)
		Seasonal:setModel(model, f1_arg1)
	end)
	self:addElement(Seasonal)
	self.Seasonal = Seasonal
	local TierBoostDisclaimer = LUI.UIText.new(0, 0, 304.5, 714.5, 0, 0, 310, 324)
	TierBoostDisclaimer:setAlpha(0)
	TierBoostDisclaimer:setText(Engine[0xF9F1239CFD921FE](0x92255DD4A01A50B))
	TierBoostDisclaimer:setTTF("default")
	TierBoostDisclaimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TierBoostDisclaimer)
	self.TierBoostDisclaimer = TierBoostDisclaimer
	local TierBoost = LUI.UIText.new(0, 0, 407.5, 607.5, 0, 0, 285, 304)
	TierBoost:setRGB(0, 0, 0)
	TierBoost:setAlpha(0)
	TierBoost:setTTF("ttmussels_demibold")
	TierBoost:setLetterSpacing(2)
	TierBoost:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TierBoost:setBackingType(1)
	TierBoost:setBackingWidget(CoD.ContractSeasonalPromoBacker, f1_arg0, f1_arg1)
	TierBoost:setBackingXPadding(7)
	TierBoost:setBackingYPadding(1)
	TierBoost:subscribeToGlobalModel(f1_arg1, "TierBoostPercent", "specialorder_boost_amount", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			TierBoost:setText(ToUpper(CoD.BlackMarketUtility.GetTierBoostPercentString(f1_arg1, f16_local0)))
		end
	end)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ContractUtility.IsElementContractActive(element, f1_arg1)
			end,
		},
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
			end,
		},
		{
			stateName = "UnpurchasedWithTierBoost",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent(f1_arg1, menu) and not CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
		{
			stateName = "UnpurchasedTierBoostAsianLang",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent(f1_arg1, menu) and CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	self:linkToElementModel(self, "contractId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "contractId",
		})
	end)
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16.ContractsForceUpdate, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "ContractsForceUpdate",
		})
	end, false)
	self:linkToElementModel(self, "purchased", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["LootStreamProgress.personalTierBoost"], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "LootStreamProgress.personalTierBoost",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f25_arg2, f25_arg3, f25_arg4)
		if IsSelfInState(self, "Purchased") and CoD.ModelUtility.IsSelfModelValueTrue(self, controller, "complete") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.Info)
		elseif IsSelfInState(self, "Purchased") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.ActivateContractButton)
		elseif IsSelfInState(self, "Active") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.Info)
		end
	end)
	Info.id = "Info"
	ActivateContractButton.id = "ActivateContractButton"
	PurchaseContainer.id = "PurchaseContainer"
	self.__defaultFocus = PurchaseContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	f1_local15 = Backer
	if not CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent(f1_arg1, f1_arg0) then
		SetAlpha(self.TierBoostDisclaimer, 0)
	end
	return self
end
CoD.ContractDetailsPanelSunset.__resetProperties = function(f26_arg0)
	f26_arg0.ContractProgressBar:completeAnimation()
	f26_arg0.TierBoost:completeAnimation()
	f26_arg0.TierBoostDisclaimer:completeAnimation()
	f26_arg0.TabbedScoreboardFuiBox2:completeAnimation()
	f26_arg0.TabbedScoreboardFuiBox:completeAnimation()
	f26_arg0.Header:completeAnimation()
	f26_arg0.Info:completeAnimation()
	f26_arg0.RewardCountPC:completeAnimation()
	f26_arg0.RewardCount:completeAnimation()
	f26_arg0.Backer:completeAnimation()
	f26_arg0.PurchaseContainer:completeAnimation()
	f26_arg0.ActivateContractButton:completeAnimation()
	f26_arg0.ContractProgressBar:setAlpha(1)
	f26_arg0.TierBoost:setLeftRight(0, 0, 407.5, 607.5)
	f26_arg0.TierBoost:setTopBottom(0, 0, 285, 304)
	f26_arg0.TierBoost:setAlpha(0)
	f26_arg0.TierBoostDisclaimer:setAlpha(0)
	f26_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
	f26_arg0.TabbedScoreboardFuiBox:setAlpha(0)
	f26_arg0.Header:setAlpha(1)
	f26_arg0.Info:setAlpha(1)
	f26_arg0.RewardCountPC:setAlpha(1)
	f26_arg0.RewardCount:setAlpha(1)
	f26_arg0.Backer:setAlpha(1)
	f26_arg0.PurchaseContainer:setAlpha(1)
	f26_arg0.ActivateContractButton:setAlpha(0)
end
CoD.ContractDetailsPanelSunset.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(9)
			f27_arg0.Backer:completeAnimation()
			f27_arg0.Backer:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.Backer)
			f27_arg0.RewardCount:completeAnimation()
			f27_arg0.RewardCount:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.RewardCount)
			f27_arg0.RewardCountPC:completeAnimation()
			f27_arg0.RewardCountPC:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.RewardCountPC)
			f27_arg0.Info:completeAnimation()
			f27_arg0.Info:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.Info)
			f27_arg0.Header:completeAnimation()
			f27_arg0.Header:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.Header)
			f27_arg0.ContractProgressBar:completeAnimation()
			f27_arg0.ContractProgressBar:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ContractProgressBar)
			f27_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f27_arg0.TabbedScoreboardFuiBox:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.TabbedScoreboardFuiBox)
			f27_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f27_arg0.TabbedScoreboardFuiBox2:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.TabbedScoreboardFuiBox2)
			f27_arg0.TierBoostDisclaimer:completeAnimation()
			f27_arg0.TierBoostDisclaimer:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.TierBoostDisclaimer)
			f27_arg0.TierBoost:completeAnimation()
			f27_arg0.TierBoost:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.TierBoost)
		end,
	},
	Active = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(8)
			f28_arg0.Backer:completeAnimation()
			f28_arg0.Backer:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Backer)
			f28_arg0.RewardCount:completeAnimation()
			f28_arg0.RewardCount:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.RewardCount)
			f28_arg0.RewardCountPC:completeAnimation()
			f28_arg0.RewardCountPC:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.RewardCountPC)
			f28_arg0.Info:completeAnimation()
			f28_arg0.Info:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Info)
			f28_arg0.Header:completeAnimation()
			f28_arg0.Header:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Header)
			f28_arg0.ContractProgressBar:completeAnimation()
			f28_arg0.ContractProgressBar:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.ContractProgressBar)
			f28_arg0.PurchaseContainer:completeAnimation()
			f28_arg0.PurchaseContainer:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.PurchaseContainer)
			f28_arg0.TierBoostDisclaimer:completeAnimation()
			f28_arg0.TierBoostDisclaimer:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.TierBoostDisclaimer)
			f28_arg0.TierBoost:completeAnimation()
			f28_arg0.TierBoost:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.TierBoost)
		end,
	},
	Purchased = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(9)
			f29_arg0.Backer:completeAnimation()
			f29_arg0.Backer:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.Backer)
			f29_arg0.RewardCount:completeAnimation()
			f29_arg0.RewardCount:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.RewardCount)
			f29_arg0.RewardCountPC:completeAnimation()
			f29_arg0.RewardCountPC:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.RewardCountPC)
			f29_arg0.Info:completeAnimation()
			f29_arg0.Info:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.Info)
			f29_arg0.Header:completeAnimation()
			f29_arg0.Header:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.Header)
			f29_arg0.ContractProgressBar:completeAnimation()
			f29_arg0.ContractProgressBar:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.ContractProgressBar)
			f29_arg0.ActivateContractButton:completeAnimation()
			f29_arg0.ActivateContractButton:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.ActivateContractButton)
			f29_arg0.PurchaseContainer:completeAnimation()
			f29_arg0.PurchaseContainer:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.PurchaseContainer)
			f29_arg0.TierBoostDisclaimer:completeAnimation()
			f29_arg0.TierBoostDisclaimer:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.TierBoostDisclaimer)
			f29_arg0.TierBoost:completeAnimation()
			f29_arg0.TierBoost:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.TierBoost)
		end,
	},
	UnpurchasedWithTierBoost = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(9)
			f30_arg0.Backer:completeAnimation()
			f30_arg0.Backer:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Backer)
			f30_arg0.RewardCount:completeAnimation()
			f30_arg0.RewardCount:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.RewardCount)
			f30_arg0.RewardCountPC:completeAnimation()
			f30_arg0.RewardCountPC:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.RewardCountPC)
			f30_arg0.Info:completeAnimation()
			f30_arg0.Info:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Info)
			f30_arg0.Header:completeAnimation()
			f30_arg0.Header:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Header)
			f30_arg0.ContractProgressBar:completeAnimation()
			f30_arg0.ContractProgressBar:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ContractProgressBar)
			f30_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f30_arg0.TabbedScoreboardFuiBox:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TabbedScoreboardFuiBox)
			f30_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f30_arg0.TabbedScoreboardFuiBox2:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TabbedScoreboardFuiBox2)
			f30_arg0.TierBoostDisclaimer:completeAnimation()
			f30_arg0.TierBoostDisclaimer:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TierBoostDisclaimer)
			f30_arg0.TierBoost:completeAnimation()
			f30_arg0.TierBoost:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TierBoost)
		end,
	},
	UnpurchasedTierBoostAsianLang = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(9)
			f31_arg0.Backer:completeAnimation()
			f31_arg0.Backer:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.Backer)
			f31_arg0.RewardCount:completeAnimation()
			f31_arg0.RewardCount:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.RewardCount)
			f31_arg0.RewardCountPC:completeAnimation()
			f31_arg0.RewardCountPC:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.RewardCountPC)
			f31_arg0.Info:completeAnimation()
			f31_arg0.Info:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.Info)
			f31_arg0.Header:completeAnimation()
			f31_arg0.Header:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.Header)
			f31_arg0.ContractProgressBar:completeAnimation()
			f31_arg0.ContractProgressBar:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ContractProgressBar)
			f31_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f31_arg0.TabbedScoreboardFuiBox:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.TabbedScoreboardFuiBox)
			f31_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f31_arg0.TabbedScoreboardFuiBox2:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.TabbedScoreboardFuiBox2)
			f31_arg0.TierBoostDisclaimer:completeAnimation()
			f31_arg0.TierBoostDisclaimer:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.TierBoostDisclaimer)
			f31_arg0.TierBoost:completeAnimation()
			f31_arg0.TierBoost:setLeftRight(0, 0, 36.5, 236.5)
			f31_arg0.TierBoost:setTopBottom(0, 0, 410, 429)
			f31_arg0.TierBoost:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.TierBoost)
		end,
	},
}
CoD.ContractDetailsPanelSunset.__onClose = function(f32_arg0)
	f32_arg0.Backer:close()
	f32_arg0.Info:close()
	f32_arg0.Header:close()
	f32_arg0.ContractProgressBar:close()
	f32_arg0.ActivateContractButton:close()
	f32_arg0.PurchaseContainer:close()
	f32_arg0.TabbedScoreboardFuiBox:close()
	f32_arg0.TabbedScoreboardFuiBox2:close()
	f32_arg0.Seasonal:close()
	f32_arg0.TierBoost:close()
end
