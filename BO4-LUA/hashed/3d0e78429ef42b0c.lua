require("x64:db56e8522ed782c")
require("x64:fcfc38ff6366a17")
require("x64:f76d24ca4263dc4")
require("x64:79a2abecba85306")
require("x64:5f1df1bb13a3d07")
require("x64:5d80cb371475b19")
require("x64:93604c7b6b216ac")
require("x64:67940364f14a232")
CoD.ContractFrameInternal = InheritFrom(LUI.UIElement)
CoD.ContractFrameInternal.__defaultWidth = 1071
CoD.ContractFrameInternal.__defaultHeight = 851
CoD.ContractFrameInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractFrameInternal)
	self.id = "ContractFrameInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PurchasedContractsButton = CoD.ItemShopButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -314, 146, 1, 1, -227, -167)
	PurchasedContractsButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ContractUtility.ShowPurchasedContractMenuButton(f1_arg1, 2)
			end,
		},
	})
	local Blur4 = PurchasedContractsButton
	local TransactionDeepLinkButton = PurchasedContractsButton.subscribeToModel
	local Blur3 = Engine[@"getglobalmodel"]()
	TransactionDeepLinkButton(Blur4, Blur3.ContractsForceUpdate, function(f3_arg0)
		f1_arg0:updateElementState(PurchasedContractsButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "ContractsForceUpdate",
		})
	end, false)
	PurchasedContractsButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"menu/view_all"))
	PurchasedContractsButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/view_all"))
	PurchasedContractsButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PurchasedContractsButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		OpenOverlay(self, "PurchasedContractsMenu", controller)
		PlaySoundAlias("uin_press_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(PurchasedContractsButton)
	self.PurchasedContractsButton = PurchasedContractsButton
	TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0.88, 0.88, -936.5, -706.5, 0, 0, 781, 851)
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f7_local0
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
	Blur4 = LUI.UIImage.new(0, 0, 480, 898, 0, 0, 377, 565)
	Blur4:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur4:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur4)
	self.Blur4 = Blur4
	Blur3 = LUI.UIImage.new(0, 0, 5, 423, 0, 0, 377, 565)
	Blur3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur3:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur3)
	self.Blur3 = Blur3
	local Blur2 = LUI.UIImage.new(0, 0, 480, 898, 0, 0, 81, 269)
	Blur2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur2:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur2)
	self.Blur2 = Blur2
	local Blur1 = LUI.UIImage.new(0, 0, 5, 423, 0, 0, 81, 269)
	Blur1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur1:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur1)
	self.Blur1 = Blur1
	local ContractItemEmpty4 = CoD.ContractItemEmpty.new(f1_arg0, f1_arg1, 0, 0, 480, 898, 0, 0, 377, 565)
	ContractItemEmpty4:setAlpha(0.27)
	self:addElement(ContractItemEmpty4)
	self.ContractItemEmpty4 = ContractItemEmpty4
	local ContractItemEmpty3 = CoD.ContractItemEmpty.new(f1_arg0, f1_arg1, 0, 0, 5, 423, 0, 0, 377, 565)
	ContractItemEmpty3:setAlpha(0.27)
	self:addElement(ContractItemEmpty3)
	self.ContractItemEmpty3 = ContractItemEmpty3
	local ContractItemEmpty2 = CoD.ContractItemEmpty.new(f1_arg0, f1_arg1, 0, 0, 480, 898, 0, 0, 81, 269)
	ContractItemEmpty2:setAlpha(0.27)
	self:addElement(ContractItemEmpty2)
	self.ContractItemEmpty2 = ContractItemEmpty2
	local ContractItemEmpty = CoD.ContractItemEmpty.new(f1_arg0, f1_arg1, 0, 0, 5, 423, 0, 0, 81, 269)
	ContractItemEmpty:setAlpha(0.27)
	self:addElement(ContractItemEmpty)
	self.ContractItemEmpty = ContractItemEmpty
	local infoBracketBot = LUI.UIImage.new(0, 0, 0, 903, 0, 0, 36, 44)
	infoBracketBot:setRGB(0.98, 1, 0.89)
	infoBracketBot:setAlpha(0.35)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local infoBracketBot2 = LUI.UIImage.new(0, 0, 0, 903, 0, 0, 360, 368)
	infoBracketBot2:setRGB(0.98, 1, 0.89)
	infoBracketBot2:setAlpha(0.35)
	infoBracketBot2:setZRot(180)
	infoBracketBot2:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot2:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot2:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot2)
	self.infoBracketBot2 = infoBracketBot2
	local PurchasableContracts = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -530.5, -175.5, 0.5, 0.5, -102.5, -52.5)
	PurchasableContracts.TextBox2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PurchasableContracts.TextBox2:setAlpha(0)
	self:addElement(PurchasableContracts)
	self.PurchasableContracts = PurchasableContracts
	local AvailableContracts = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -530.5, -175.5, 0.5, 0.5, -425.5, -375.5)
	self:addElement(AvailableContracts)
	self.AvailableContracts = AvailableContracts
	local PurchasedContractList = LUI.UIList.new(f1_arg0, f1_arg1, 57, 0, nil, false, false, false, false)
	PurchasedContractList:setLeftRight(0, 0, 5, 898)
	PurchasedContractList:setTopBottom(0, 0, 376.5, 565.5)
	PurchasedContractList:setWidgetType(CoD.ContractItem)
	PurchasedContractList:setHorizontalCount(2)
	PurchasedContractList:setSpacing(57)
	PurchasedContractList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PurchasedContractList:setDataSource("PurchasedContracts")
	PurchasedContractList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f12_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "ContractInfoPanel")
		CoD.BlackMarketUtility.CopySignatureWeaponProperty(f1_arg1, element, self.ContractInfoPanel)
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		return f12_local0
	end)
	PurchasedContractList:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PurchasedContractList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		CoD.ContractUtility.OpenContractDetails(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(PurchasedContractList)
	self.PurchasedContractList = PurchasedContractList
	local PurchasableContractList = LUI.UIList.new(f1_arg0, f1_arg1, 57, 0, nil, false, false, false, false)
	PurchasableContractList:setLeftRight(0, 0, 5, 898)
	PurchasableContractList:setTopBottom(0, 0, 80.5, 269.5)
	PurchasableContractList:setWidgetType(CoD.ContractItem)
	PurchasableContractList:setHorizontalCount(2)
	PurchasableContractList:setSpacing(57)
	PurchasableContractList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PurchasableContractList:setDataSource("PurchasableContracts")
	PurchasableContractList:linkToElementModel(PurchasableContractList, "purchased", true, function(model, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	PurchasableContractList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f17_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "ContractInfoPanel")
		CoD.BlackMarketUtility.CopySignatureWeaponProperty(f1_arg1, element, self.ContractInfoPanel)
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		return f17_local0
	end)
	PurchasableContractList:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f18_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PurchasableContractList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchased") then
			PlaySoundAlias("uin_toggle_generic")
			CoD.ContractUtility.OpenContractDetails(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchased") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(PurchasableContractList)
	self.PurchasableContractList = PurchasableContractList
	local ContractTimer1 = LUI.UIText.new(0, 0, 6, 423, 0, 0, 52, 70)
	ContractTimer1:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	ContractTimer1:setTTF("ttmussels_regular")
	ContractTimer1:setLetterSpacing(2)
	ContractTimer1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ContractTimer1:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ContractTimer1:subscribeToGlobalModel(f1_arg1, "AutoEvents", "autoevent_contract1_timer", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			ContractTimer1:setText(LocalizeIntoStringIfNotEmpty(@"hash_5AAA70C5480C51D2", f21_local0))
		end
	end)
	self:addElement(ContractTimer1)
	self.ContractTimer1 = ContractTimer1
	local ContractTimer2 = LUI.UIText.new(0, 0, 480, 897, 0, 0, 52, 70)
	ContractTimer2:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	ContractTimer2:setTTF("ttmussels_regular")
	ContractTimer2:setLetterSpacing(2)
	ContractTimer2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ContractTimer2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ContractTimer2:subscribeToGlobalModel(f1_arg1, "AutoEvents", "autoevent_contract2_timer", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			ContractTimer2:setText(LocalizeIntoStringIfNotEmpty(@"hash_5AAA70C5480C51D2", f22_local0))
		end
	end)
	self:addElement(ContractTimer2)
	self.ContractTimer2 = ContractTimer2
	local SupplyChainDetails = CoD.ContractSupplyChainDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, 586, 1186, 0, 0, -167, 913)
	SupplyChainDetails:mergeStateConditions({
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "name", true, function(model)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f25_arg0, f25_arg1)
		f25_arg1.menu = f25_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SupplyChainDetails, f25_arg1)
	end)
	local f1_local20 = SupplyChainDetails
	local ContractInfoPanel = SupplyChainDetails.subscribeToModel
	local f1_local22 = Engine[@"getmodelforcontroller"](f1_arg1)
	ContractInfoPanel(f1_local20, f1_local22.LastInput, function(f26_arg0)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "character", true, function(model)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "character",
		})
	end)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "weaponRef", true, function(model)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponRef",
		})
	end)
	self:addElement(SupplyChainDetails)
	self.SupplyChainDetails = SupplyChainDetails
	ContractInfoPanel = CoD.ContractSupplyChainDetails_InfoPanel.new(f1_arg0, f1_arg1, 0, 0, 1181, 1739, 0, 0, 575, 821)
	ContractInfoPanel:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name")
			end,
		},
	})
	ContractInfoPanel:linkToElementModel(ContractInfoPanel, "name", true, function(model)
		f1_arg0:updateElementState(ContractInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	ContractInfoPanel:linkToElementModel(ContractInfoPanel, "itemCategory", true, function(model)
		f1_arg0:updateElementState(ContractInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	ContractInfoPanel:appendEventHandler("input_source_changed", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ContractInfoPanel, f32_arg1)
	end)
	f1_local22 = ContractInfoPanel
	f1_local20 = ContractInfoPanel.subscribeToModel
	local f1_local23 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local20(f1_local22, f1_local23.LastInput, function(f33_arg0)
		f1_arg0:updateElementState(ContractInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:addElement(ContractInfoPanel)
	self.ContractInfoPanel = ContractInfoPanel
	PurchasedContractsButton.id = "PurchasedContractsButton"
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	PurchasedContractList.id = "PurchasedContractList"
	PurchasableContractList.id = "PurchasableContractList"
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	self.__defaultFocus = PurchasableContractList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local20 = self
	f1_local20 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	f1_local20 = PurchasedContractList
	SetElementProperty(f1_local20, "_maxShowContracts", 2)
	SetElementProperty(f1_local20, "_excludeCompletedContracts", true)
	return self
end
CoD.ContractFrameInternal.__onClose = function(f34_arg0)
	f34_arg0.PurchasedContractsButton:close()
	f34_arg0.TransactionDeepLinkButton:close()
	f34_arg0.ContractItemEmpty4:close()
	f34_arg0.ContractItemEmpty3:close()
	f34_arg0.ContractItemEmpty2:close()
	f34_arg0.ContractItemEmpty:close()
	f34_arg0.PurchasableContracts:close()
	f34_arg0.AvailableContracts:close()
	f34_arg0.PurchasedContractList:close()
	f34_arg0.PurchasableContractList:close()
	f34_arg0.ContractTimer1:close()
	f34_arg0.ContractTimer2:close()
	f34_arg0.SupplyChainDetails:close()
	f34_arg0.ContractInfoPanel:close()
end
