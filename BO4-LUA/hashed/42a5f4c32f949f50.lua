require("x64:be52530c0ca57a1")
require("x64:a240ce7f5fae27f")
require("x64:d988b567be037bc")
require("x64:ff46188cc1c3579")
require("x64:c0e24f3dd0285d0")
require("x64:6d85dd0ad8ad389")
require("x64:68036bda8abbe94")
require("x64:c01e8478a7d92cd")
require("x64:6735e84e8dd1117")
require("x64:5d80cb371475b19")
require("x64:a24b28b508f6914")
CoD.ContractDetailsPanel = InheritFrom(LUI.UIElement)
CoD.ContractDetailsPanel.__defaultWidth = 776
CoD.ContractDetailsPanel.__defaultHeight = 727
CoD.ContractDetailsPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractDetailsPanel)
	self.id = "ContractDetailsPanel"
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
	local ContractPrice = LUI.UIText.new(0.5, 0.5, 19.5, 219.5, 1, 1, -322, -290)
	ContractPrice:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	ContractPrice:setAlpha(0)
	ContractPrice:setTTF("ttmussels_demibold")
	ContractPrice:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractPrice:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ContractPrice:linkToElementModel(self, "price", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ContractPrice:setText(LocalizeIntoString(0x6A3CC7BE3008989, f12_local0))
		end
	end)
	self:addElement(ContractPrice)
	self.ContractPrice = ContractPrice
	local ContractCost = CoD.ContractItemCostLarge.new(f1_arg0, f1_arg1, 0, 0, 415, 600, 0, 0, 411, 432)
	ContractCost:setAlpha(0)
	ContractCost:linkToElementModel(self, nil, false, function(model)
		ContractCost:setModel(model, f1_arg1)
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	local PurchaseContractButton = CoD.ItemShopButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -109.5, 348.5, 1, 1, -384, -332)
	PurchaseContractButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PurchaseContractButton:setAlpha(0)
	PurchaseContractButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x85952ACC6D0C1B0))
	PurchaseContractButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x85952ACC6D0C1B0))
	local TabbedScoreboardFuiBox2 = PurchaseContractButton
	local TabbedScoreboardFuiBox = PurchaseContractButton.subscribeToModel
	local Seasonal = Engine[0x4DF5CFBC1771947](f1_arg1)
	TabbedScoreboardFuiBox(TabbedScoreboardFuiBox2, Seasonal["LootStreamProgress.codPoints"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PurchaseContractButton:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PurchaseContractButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CanPurchaseItem(controller, self) then
			OpenPopup(self, "PurchaseContractConfirmation", controller, {
				_model = self:getModel(),
			})
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			PlaySoundAlias("uin_press_generic")
			return true
		else
			OpenPopup(self, "PurchaseCodPoints", controller, menu:getModel())
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(PurchaseContractButton)
	self.PurchaseContractButton = PurchaseContractButton
	TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 624.5, 736.5, 0, 0, 413, 429)
	TabbedScoreboardFuiBox:setAlpha(0)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	TabbedScoreboardFuiBox2 = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 278.5, 390.5, 0, 0, 413, 429)
	TabbedScoreboardFuiBox2:setAlpha(0)
	TabbedScoreboardFuiBox2:setZRot(180)
	self:addElement(TabbedScoreboardFuiBox2)
	self.TabbedScoreboardFuiBox2 = TabbedScoreboardFuiBox2
	Seasonal = CoD.ContractSeasonalOverlay_InfoPanel.new(f1_arg0, f1_arg1, 0, 0, 0.5, 759.5, 0, 0, 32, 57)
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
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			TierBoost:setText(ToUpper(CoD.BlackMarketUtility.GetTierBoostPercentString(f1_arg1, f22_local0)))
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
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18.ContractsForceUpdate, function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
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
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["LootStreamProgress.personalTierBoost"], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "LootStreamProgress.personalTierBoost",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f31_arg2, f31_arg3, f31_arg4)
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
	PurchaseContractButton.id = "PurchaseContractButton"
	self.__defaultFocus = PurchaseContractButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local17 = self
	f1_local17 = Backer
	if not CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent(f1_arg1, f1_arg0) then
		SetAlpha(self.TierBoostDisclaimer, 0)
	end
	return self
end
CoD.ContractDetailsPanel.__resetProperties = function(f32_arg0)
	f32_arg0.Backer:completeAnimation()
	f32_arg0.Info:completeAnimation()
	f32_arg0.Header:completeAnimation()
	f32_arg0.RewardCount:completeAnimation()
	f32_arg0.ContractPrice:completeAnimation()
	f32_arg0.PurchaseContractButton:completeAnimation()
	f32_arg0.TabbedScoreboardFuiBox:completeAnimation()
	f32_arg0.TabbedScoreboardFuiBox2:completeAnimation()
	f32_arg0.RewardCountPC:completeAnimation()
	f32_arg0.ContractProgressBar:completeAnimation()
	f32_arg0.TierBoost:completeAnimation()
	f32_arg0.TierBoostDisclaimer:completeAnimation()
	f32_arg0.ContractCost:completeAnimation()
	f32_arg0.ActivateContractButton:completeAnimation()
	f32_arg0.Backer:setAlpha(1)
	f32_arg0.Info:setAlpha(1)
	f32_arg0.Header:setAlpha(1)
	f32_arg0.RewardCount:setAlpha(1)
	f32_arg0.ContractPrice:setAlpha(0)
	f32_arg0.PurchaseContractButton:setAlpha(0)
	f32_arg0.TabbedScoreboardFuiBox:setAlpha(0)
	f32_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
	f32_arg0.RewardCountPC:setAlpha(1)
	f32_arg0.ContractProgressBar:setAlpha(1)
	f32_arg0.TierBoost:setLeftRight(0, 0, 407.5, 607.5)
	f32_arg0.TierBoost:setTopBottom(0, 0, 285, 304)
	f32_arg0.TierBoost:setAlpha(0)
	f32_arg0.TierBoostDisclaimer:setAlpha(0)
	f32_arg0.ContractCost:setAlpha(0)
	f32_arg0.ActivateContractButton:setAlpha(0)
end
CoD.ContractDetailsPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(12)
			local f33_local0 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(410)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.Backer:beginAnimation(90)
				f33_arg0.Backer:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Backer:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f33_arg0.Backer:completeAnimation()
			f33_arg0.Backer:setAlpha(0)
			f33_local0(f33_arg0.Backer)
			local f33_local1 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(450)
					f37_arg0:setAlpha(1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.RewardCount:beginAnimation(570)
				f33_arg0.RewardCount:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.RewardCount:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f33_arg0.RewardCount:completeAnimation()
			f33_arg0.RewardCount:setAlpha(0)
			f33_local1(f33_arg0.RewardCount)
			local f33_local2 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(450)
					f39_arg0:setAlpha(1)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.RewardCountPC:beginAnimation(570)
				f33_arg0.RewardCountPC:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.RewardCountPC:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f33_arg0.RewardCountPC:completeAnimation()
			f33_arg0.RewardCountPC:setAlpha(0)
			f33_local2(f33_arg0.RewardCountPC)
			local f33_local3 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					f41_arg0:beginAnimation(420)
					f41_arg0:setAlpha(1)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.Info:beginAnimation(310)
				f33_arg0.Info:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Info:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f33_arg0.Info:completeAnimation()
			f33_arg0.Info:setAlpha(0)
			f33_local3(f33_arg0.Info)
			local f33_local4 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					f43_arg0:beginAnimation(400)
					f43_arg0:setAlpha(1)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.Header:beginAnimation(160)
				f33_arg0.Header:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Header:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f33_arg0.Header:completeAnimation()
			f33_arg0.Header:setAlpha(0)
			f33_local4(f33_arg0.Header)
			f33_arg0.ContractProgressBar:completeAnimation()
			f33_arg0.ContractProgressBar:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ContractProgressBar)
			local f33_local5 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(420)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.ContractPrice:beginAnimation(310)
				f33_arg0.ContractPrice:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.ContractPrice:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f33_arg0.ContractPrice:completeAnimation()
			f33_arg0.ContractPrice:setAlpha(0)
			f33_local5(f33_arg0.ContractPrice)
			local f33_local6 = function(f46_arg0)
				f46_arg0:beginAnimation(410)
				f46_arg0:setAlpha(1)
				f46_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.ContractCost:beginAnimation(320)
			f33_arg0.ContractCost:setAlpha(0)
			f33_arg0.ContractCost:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
			f33_arg0.ContractCost:registerEventHandler("transition_complete_keyframe", f33_local6)
			local f33_local7 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(420)
					f48_arg0:setAlpha(1)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.PurchaseContractButton:beginAnimation(310)
				f33_arg0.PurchaseContractButton:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.PurchaseContractButton:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f33_arg0.PurchaseContractButton:completeAnimation()
			f33_arg0.PurchaseContractButton:setAlpha(0)
			f33_local7(f33_arg0.PurchaseContractButton)
			local f33_local8 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(420)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.TabbedScoreboardFuiBox:beginAnimation(310)
				f33_arg0.TabbedScoreboardFuiBox:setAlpha(1)
				f33_arg0.TabbedScoreboardFuiBox:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.TabbedScoreboardFuiBox:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f33_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f33_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f33_local8(f33_arg0.TabbedScoreboardFuiBox)
			local f33_local9 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(420)
					f52_arg0:setAlpha(1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.TabbedScoreboardFuiBox2:beginAnimation(310)
				f33_arg0.TabbedScoreboardFuiBox2:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.TabbedScoreboardFuiBox2:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f33_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f33_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
			f33_local9(f33_arg0.TabbedScoreboardFuiBox2)
			f33_arg0.TierBoostDisclaimer:completeAnimation()
			f33_arg0.TierBoostDisclaimer:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.TierBoostDisclaimer)
			f33_arg0.TierBoost:completeAnimation()
			f33_arg0.TierBoost:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.TierBoost)
		end,
	},
	Active = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(7)
			local f53_local0 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					f55_arg0:beginAnimation(410)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
				end
				f53_arg0.Backer:beginAnimation(90)
				f53_arg0.Backer:setAlpha(1)
				f53_arg0.Backer:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.Backer:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f53_arg0.Backer:completeAnimation()
			f53_arg0.Backer:setAlpha(0)
			f53_local0(f53_arg0.Backer)
			local f53_local1 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(450)
					f57_arg0:setAlpha(1)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
				end
				f53_arg0.RewardCount:beginAnimation(570)
				f53_arg0.RewardCount:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.RewardCount:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f53_arg0.RewardCount:completeAnimation()
			f53_arg0.RewardCount:setAlpha(0)
			f53_local1(f53_arg0.RewardCount)
			local f53_local2 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(450)
					f59_arg0:setAlpha(1)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
				end
				f53_arg0.RewardCountPC:beginAnimation(570)
				f53_arg0.RewardCountPC:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.RewardCountPC:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f53_arg0.RewardCountPC:completeAnimation()
			f53_arg0.RewardCountPC:setAlpha(0)
			f53_local2(f53_arg0.RewardCountPC)
			local f53_local3 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					f61_arg0:beginAnimation(420)
					f61_arg0:setAlpha(1)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
				end
				f53_arg0.Info:beginAnimation(310)
				f53_arg0.Info:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.Info:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f53_arg0.Info:completeAnimation()
			f53_arg0.Info:setAlpha(0)
			f53_local3(f53_arg0.Info)
			local f53_local4 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					f63_arg0:beginAnimation(410)
					f63_arg0:setAlpha(1)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
				end
				f53_arg0.Header:beginAnimation(160)
				f53_arg0.Header:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.Header:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f53_arg0.Header:completeAnimation()
			f53_arg0.Header:setAlpha(0)
			f53_local4(f53_arg0.Header)
			local f53_local5 = function(f64_arg0)
				local f64_local0 = function(f65_arg0)
					f65_arg0:beginAnimation(420)
					f65_arg0:setAlpha(1)
					f65_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
				end
				f53_arg0.ContractProgressBar:beginAnimation(310)
				f53_arg0.ContractProgressBar:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.ContractProgressBar:registerEventHandler("transition_complete_keyframe", f64_local0)
			end
			f53_arg0.ContractProgressBar:completeAnimation()
			f53_arg0.ContractProgressBar:setAlpha(0)
			f53_local5(f53_arg0.ContractProgressBar)
			f53_arg0.TierBoostDisclaimer:completeAnimation()
			f53_arg0.TierBoostDisclaimer:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.TierBoostDisclaimer)
			f53_arg0.TierBoost:completeAnimation()
			f53_arg0.TierBoost:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.TierBoost)
		end,
	},
	Purchased = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(8)
			local f66_local0 = function(f67_arg0)
				local f67_local0 = function(f68_arg0)
					f68_arg0:beginAnimation(410)
					f68_arg0:setAlpha(1)
					f68_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.Backer:beginAnimation(90)
				f66_arg0.Backer:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.Backer:registerEventHandler("transition_complete_keyframe", f67_local0)
			end
			f66_arg0.Backer:completeAnimation()
			f66_arg0.Backer:setAlpha(0)
			f66_local0(f66_arg0.Backer)
			local f66_local1 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					f70_arg0:beginAnimation(459)
					f70_arg0:setAlpha(1)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.RewardCount:beginAnimation(570)
				f66_arg0.RewardCount:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.RewardCount:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f66_arg0.RewardCount:completeAnimation()
			f66_arg0.RewardCount:setAlpha(0)
			f66_local1(f66_arg0.RewardCount)
			local f66_local2 = function(f71_arg0)
				local f71_local0 = function(f72_arg0)
					f72_arg0:beginAnimation(459)
					f72_arg0:setAlpha(1)
					f72_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.RewardCountPC:beginAnimation(570)
				f66_arg0.RewardCountPC:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.RewardCountPC:registerEventHandler("transition_complete_keyframe", f71_local0)
			end
			f66_arg0.RewardCountPC:completeAnimation()
			f66_arg0.RewardCountPC:setAlpha(0)
			f66_local2(f66_arg0.RewardCountPC)
			local f66_local3 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					f74_arg0:beginAnimation(410)
					f74_arg0:setAlpha(1)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.Info:beginAnimation(320)
				f66_arg0.Info:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.Info:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f66_arg0.Info:completeAnimation()
			f66_arg0.Info:setAlpha(0)
			f66_local3(f66_arg0.Info)
			local f66_local4 = function(f75_arg0)
				local f75_local0 = function(f76_arg0)
					f76_arg0:beginAnimation(410)
					f76_arg0:setAlpha(1)
					f76_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.Header:beginAnimation(160)
				f66_arg0.Header:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.Header:registerEventHandler("transition_complete_keyframe", f75_local0)
			end
			f66_arg0.Header:completeAnimation()
			f66_arg0.Header:setAlpha(0)
			f66_local4(f66_arg0.Header)
			local f66_local5 = function(f77_arg0)
				local f77_local0 = function(f78_arg0)
					f78_arg0:beginAnimation(420)
					f78_arg0:setAlpha(1)
					f78_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.ContractProgressBar:beginAnimation(310)
				f66_arg0.ContractProgressBar:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.ContractProgressBar:registerEventHandler("transition_complete_keyframe", f77_local0)
			end
			f66_arg0.ContractProgressBar:completeAnimation()
			f66_arg0.ContractProgressBar:setAlpha(0)
			f66_local5(f66_arg0.ContractProgressBar)
			local f66_local6 = function(f79_arg0)
				local f79_local0 = function(f80_arg0)
					f80_arg0:beginAnimation(420)
					f80_arg0:setAlpha(1)
					f80_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.ActivateContractButton:beginAnimation(310)
				f66_arg0.ActivateContractButton:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.ActivateContractButton:registerEventHandler("transition_complete_keyframe", f79_local0)
			end
			f66_arg0.ActivateContractButton:completeAnimation()
			f66_arg0.ActivateContractButton:setAlpha(0)
			f66_local6(f66_arg0.ActivateContractButton)
			f66_arg0.TierBoostDisclaimer:completeAnimation()
			f66_arg0.TierBoostDisclaimer:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.TierBoostDisclaimer)
			f66_arg0.TierBoost:completeAnimation()
			f66_arg0.TierBoost:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.TierBoost)
		end,
	},
	UnpurchasedWithTierBoost = {
		DefaultClip = function(f81_arg0, f81_arg1)
			f81_arg0:__resetProperties()
			f81_arg0:setupElementClipCounter(12)
			local f81_local0 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					f83_arg0:beginAnimation(410)
					f83_arg0:setAlpha(1)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.Backer:beginAnimation(90)
				f81_arg0.Backer:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.Backer:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f81_arg0.Backer:completeAnimation()
			f81_arg0.Backer:setAlpha(0)
			f81_local0(f81_arg0.Backer)
			local f81_local1 = function(f84_arg0)
				local f84_local0 = function(f85_arg0)
					f85_arg0:beginAnimation(450)
					f85_arg0:setAlpha(1)
					f85_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.RewardCount:beginAnimation(570)
				f81_arg0.RewardCount:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.RewardCount:registerEventHandler("transition_complete_keyframe", f84_local0)
			end
			f81_arg0.RewardCount:completeAnimation()
			f81_arg0.RewardCount:setAlpha(0)
			f81_local1(f81_arg0.RewardCount)
			local f81_local2 = function(f86_arg0)
				local f86_local0 = function(f87_arg0)
					f87_arg0:beginAnimation(450)
					f87_arg0:setAlpha(1)
					f87_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.RewardCountPC:beginAnimation(570)
				f81_arg0.RewardCountPC:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.RewardCountPC:registerEventHandler("transition_complete_keyframe", f86_local0)
			end
			f81_arg0.RewardCountPC:completeAnimation()
			f81_arg0.RewardCountPC:setAlpha(0)
			f81_local2(f81_arg0.RewardCountPC)
			local f81_local3 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					f89_arg0:beginAnimation(420)
					f89_arg0:setAlpha(1)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.Info:beginAnimation(310)
				f81_arg0.Info:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.Info:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f81_arg0.Info:completeAnimation()
			f81_arg0.Info:setAlpha(0)
			f81_local3(f81_arg0.Info)
			local f81_local4 = function(f90_arg0)
				local f90_local0 = function(f91_arg0)
					f91_arg0:beginAnimation(400)
					f91_arg0:setAlpha(1)
					f91_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.Header:beginAnimation(160)
				f81_arg0.Header:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.Header:registerEventHandler("transition_complete_keyframe", f90_local0)
			end
			f81_arg0.Header:completeAnimation()
			f81_arg0.Header:setAlpha(0)
			f81_local4(f81_arg0.Header)
			f81_arg0.ContractProgressBar:completeAnimation()
			f81_arg0.ContractProgressBar:setAlpha(0)
			f81_arg0.clipFinished(f81_arg0.ContractProgressBar)
			local f81_local5 = function(f92_arg0)
				local f92_local0 = function(f93_arg0)
					f93_arg0:beginAnimation(420)
					f93_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.ContractPrice:beginAnimation(310)
				f81_arg0.ContractPrice:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.ContractPrice:registerEventHandler("transition_complete_keyframe", f92_local0)
			end
			f81_arg0.ContractPrice:completeAnimation()
			f81_arg0.ContractPrice:setAlpha(0)
			f81_local5(f81_arg0.ContractPrice)
			local f81_local6 = function(f94_arg0)
				f94_arg0:beginAnimation(410)
				f94_arg0:setAlpha(1)
				f94_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
			end
			f81_arg0.ContractCost:beginAnimation(320)
			f81_arg0.ContractCost:setAlpha(0)
			f81_arg0.ContractCost:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
			f81_arg0.ContractCost:registerEventHandler("transition_complete_keyframe", f81_local6)
			local f81_local7 = function(f95_arg0)
				local f95_local0 = function(f96_arg0)
					f96_arg0:beginAnimation(420)
					f96_arg0:setAlpha(1)
					f96_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.PurchaseContractButton:beginAnimation(310)
				f81_arg0.PurchaseContractButton:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.PurchaseContractButton:registerEventHandler("transition_complete_keyframe", f95_local0)
			end
			f81_arg0.PurchaseContractButton:completeAnimation()
			f81_arg0.PurchaseContractButton:setAlpha(0)
			f81_local7(f81_arg0.PurchaseContractButton)
			local f81_local8 = function(f97_arg0)
				local f97_local0 = function(f98_arg0)
					f98_arg0:beginAnimation(420)
					f98_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.TabbedScoreboardFuiBox:beginAnimation(310)
				f81_arg0.TabbedScoreboardFuiBox:setAlpha(1)
				f81_arg0.TabbedScoreboardFuiBox:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.TabbedScoreboardFuiBox:registerEventHandler("transition_complete_keyframe", f97_local0)
			end
			f81_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f81_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f81_local8(f81_arg0.TabbedScoreboardFuiBox)
			local f81_local9 = function(f99_arg0)
				local f99_local0 = function(f100_arg0)
					f100_arg0:beginAnimation(420)
					f100_arg0:setAlpha(1)
					f100_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.TabbedScoreboardFuiBox2:beginAnimation(310)
				f81_arg0.TabbedScoreboardFuiBox2:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.TabbedScoreboardFuiBox2:registerEventHandler("transition_complete_keyframe", f99_local0)
			end
			f81_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f81_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
			f81_local9(f81_arg0.TabbedScoreboardFuiBox2)
			local f81_local10 = function(f101_arg0)
				local f101_local0 = function(f102_arg0)
					local f102_local0 = function(f103_arg0)
						f103_arg0:beginAnimation(289)
						f103_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
					end
					f102_arg0:beginAnimation(420)
					f102_arg0:setAlpha(1)
					f102_arg0:registerEventHandler("transition_complete_keyframe", f102_local0)
				end
				f81_arg0.TierBoostDisclaimer:beginAnimation(310)
				f81_arg0.TierBoostDisclaimer:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.TierBoostDisclaimer:registerEventHandler("transition_complete_keyframe", f101_local0)
			end
			f81_arg0.TierBoostDisclaimer:completeAnimation()
			f81_arg0.TierBoostDisclaimer:setAlpha(0)
			f81_local10(f81_arg0.TierBoostDisclaimer)
			local f81_local11 = function(f104_arg0)
				local f104_local0 = function(f105_arg0)
					local f105_local0 = function(f106_arg0)
						f106_arg0:beginAnimation(289)
						f106_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
					end
					f105_arg0:beginAnimation(420)
					f105_arg0:setAlpha(1)
					f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
				end
				f81_arg0.TierBoost:beginAnimation(310)
				f81_arg0.TierBoost:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.TierBoost:registerEventHandler("transition_complete_keyframe", f104_local0)
			end
			f81_arg0.TierBoost:completeAnimation()
			f81_arg0.TierBoost:setAlpha(0)
			f81_local11(f81_arg0.TierBoost)
		end,
	},
	UnpurchasedTierBoostAsianLang = {
		DefaultClip = function(f107_arg0, f107_arg1)
			f107_arg0:__resetProperties()
			f107_arg0:setupElementClipCounter(12)
			local f107_local0 = function(f108_arg0)
				local f108_local0 = function(f109_arg0)
					f109_arg0:beginAnimation(410)
					f109_arg0:setAlpha(1)
					f109_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Backer:beginAnimation(90)
				f107_arg0.Backer:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Backer:registerEventHandler("transition_complete_keyframe", f108_local0)
			end
			f107_arg0.Backer:completeAnimation()
			f107_arg0.Backer:setAlpha(0)
			f107_local0(f107_arg0.Backer)
			local f107_local1 = function(f110_arg0)
				local f110_local0 = function(f111_arg0)
					f111_arg0:beginAnimation(450)
					f111_arg0:setAlpha(1)
					f111_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.RewardCount:beginAnimation(570)
				f107_arg0.RewardCount:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.RewardCount:registerEventHandler("transition_complete_keyframe", f110_local0)
			end
			f107_arg0.RewardCount:completeAnimation()
			f107_arg0.RewardCount:setAlpha(0)
			f107_local1(f107_arg0.RewardCount)
			local f107_local2 = function(f112_arg0)
				local f112_local0 = function(f113_arg0)
					f113_arg0:beginAnimation(450)
					f113_arg0:setAlpha(1)
					f113_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.RewardCountPC:beginAnimation(570)
				f107_arg0.RewardCountPC:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.RewardCountPC:registerEventHandler("transition_complete_keyframe", f112_local0)
			end
			f107_arg0.RewardCountPC:completeAnimation()
			f107_arg0.RewardCountPC:setAlpha(0)
			f107_local2(f107_arg0.RewardCountPC)
			local f107_local3 = function(f114_arg0)
				local f114_local0 = function(f115_arg0)
					f115_arg0:beginAnimation(420)
					f115_arg0:setAlpha(1)
					f115_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Info:beginAnimation(310)
				f107_arg0.Info:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Info:registerEventHandler("transition_complete_keyframe", f114_local0)
			end
			f107_arg0.Info:completeAnimation()
			f107_arg0.Info:setAlpha(0)
			f107_local3(f107_arg0.Info)
			local f107_local4 = function(f116_arg0)
				local f116_local0 = function(f117_arg0)
					f117_arg0:beginAnimation(400)
					f117_arg0:setAlpha(1)
					f117_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Header:beginAnimation(160)
				f107_arg0.Header:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Header:registerEventHandler("transition_complete_keyframe", f116_local0)
			end
			f107_arg0.Header:completeAnimation()
			f107_arg0.Header:setAlpha(0)
			f107_local4(f107_arg0.Header)
			f107_arg0.ContractProgressBar:completeAnimation()
			f107_arg0.ContractProgressBar:setAlpha(0)
			f107_arg0.clipFinished(f107_arg0.ContractProgressBar)
			local f107_local5 = function(f118_arg0)
				local f118_local0 = function(f119_arg0)
					f119_arg0:beginAnimation(420)
					f119_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.ContractPrice:beginAnimation(310)
				f107_arg0.ContractPrice:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.ContractPrice:registerEventHandler("transition_complete_keyframe", f118_local0)
			end
			f107_arg0.ContractPrice:completeAnimation()
			f107_arg0.ContractPrice:setAlpha(0)
			f107_local5(f107_arg0.ContractPrice)
			local f107_local6 = function(f120_arg0)
				f120_arg0:beginAnimation(410)
				f120_arg0:setAlpha(1)
				f120_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
			end
			f107_arg0.ContractCost:beginAnimation(320)
			f107_arg0.ContractCost:setAlpha(0)
			f107_arg0.ContractCost:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
			f107_arg0.ContractCost:registerEventHandler("transition_complete_keyframe", f107_local6)
			local f107_local7 = function(f121_arg0)
				local f121_local0 = function(f122_arg0)
					f122_arg0:beginAnimation(420)
					f122_arg0:setAlpha(1)
					f122_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.PurchaseContractButton:beginAnimation(310)
				f107_arg0.PurchaseContractButton:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.PurchaseContractButton:registerEventHandler("transition_complete_keyframe", f121_local0)
			end
			f107_arg0.PurchaseContractButton:completeAnimation()
			f107_arg0.PurchaseContractButton:setAlpha(0)
			f107_local7(f107_arg0.PurchaseContractButton)
			local f107_local8 = function(f123_arg0)
				local f123_local0 = function(f124_arg0)
					f124_arg0:beginAnimation(420)
					f124_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.TabbedScoreboardFuiBox:beginAnimation(310)
				f107_arg0.TabbedScoreboardFuiBox:setAlpha(1)
				f107_arg0.TabbedScoreboardFuiBox:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.TabbedScoreboardFuiBox:registerEventHandler("transition_complete_keyframe", f123_local0)
			end
			f107_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f107_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f107_local8(f107_arg0.TabbedScoreboardFuiBox)
			local f107_local9 = function(f125_arg0)
				local f125_local0 = function(f126_arg0)
					f126_arg0:beginAnimation(420)
					f126_arg0:setAlpha(1)
					f126_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.TabbedScoreboardFuiBox2:beginAnimation(310)
				f107_arg0.TabbedScoreboardFuiBox2:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.TabbedScoreboardFuiBox2:registerEventHandler("transition_complete_keyframe", f125_local0)
			end
			f107_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f107_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
			f107_local9(f107_arg0.TabbedScoreboardFuiBox2)
			local f107_local10 = function(f127_arg0)
				local f127_local0 = function(f128_arg0)
					local f128_local0 = function(f129_arg0)
						f129_arg0:beginAnimation(289)
						f129_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
					end
					f128_arg0:beginAnimation(420)
					f128_arg0:setAlpha(1)
					f128_arg0:registerEventHandler("transition_complete_keyframe", f128_local0)
				end
				f107_arg0.TierBoostDisclaimer:beginAnimation(310)
				f107_arg0.TierBoostDisclaimer:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.TierBoostDisclaimer:registerEventHandler("transition_complete_keyframe", f127_local0)
			end
			f107_arg0.TierBoostDisclaimer:completeAnimation()
			f107_arg0.TierBoostDisclaimer:setAlpha(0)
			f107_local10(f107_arg0.TierBoostDisclaimer)
			local f107_local11 = function(f130_arg0)
				local f130_local0 = function(f131_arg0)
					local f131_local0 = function(f132_arg0)
						f132_arg0:beginAnimation(289)
						f132_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
					end
					f131_arg0:beginAnimation(420)
					f131_arg0:setAlpha(1)
					f131_arg0:registerEventHandler("transition_complete_keyframe", f131_local0)
				end
				f107_arg0.TierBoost:beginAnimation(310)
				f107_arg0.TierBoost:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.TierBoost:registerEventHandler("transition_complete_keyframe", f130_local0)
			end
			f107_arg0.TierBoost:completeAnimation()
			f107_arg0.TierBoost:setLeftRight(0, 0, 36.5, 236.5)
			f107_arg0.TierBoost:setTopBottom(0, 0, 410, 429)
			f107_arg0.TierBoost:setAlpha(0)
			f107_local11(f107_arg0.TierBoost)
		end,
	},
}
CoD.ContractDetailsPanel.__onClose = function(f133_arg0)
	f133_arg0.Backer:close()
	f133_arg0.Info:close()
	f133_arg0.Header:close()
	f133_arg0.ContractProgressBar:close()
	f133_arg0.ActivateContractButton:close()
	f133_arg0.ContractPrice:close()
	f133_arg0.ContractCost:close()
	f133_arg0.PurchaseContractButton:close()
	f133_arg0.TabbedScoreboardFuiBox:close()
	f133_arg0.TabbedScoreboardFuiBox2:close()
	f133_arg0.Seasonal:close()
	f133_arg0.TierBoost:close()
end
