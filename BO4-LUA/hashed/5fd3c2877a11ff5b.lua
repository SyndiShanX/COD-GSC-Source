require("x64:bc6e2379d2241fb")
require("x64:3f0c583dc4db051")
require("x64:ef9c1900ac4bdfe")
require("x64:5d80cb371475b19")
require("x64:b175512a7a605a8")
require("x64:f035e2b6323687d")
require("x64:4cee61320cd1f1b")
CoD.PurchaseContractConfirmation = InheritFrom(CoD.Menu)
LUI.createMenu.PurchaseContractConfirmation = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PurchaseContractConfirmation", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	SetMenuProperty(f1_local1, "_closeAndGoBack", true)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "purchaseContractNoActivate", false)
	SetMenuProperty(f1_local1, "__keepPopupButtonListPC", not CoD.ContractUtility.IsActiveContractSlotOpen(f1_arg0))
	self:setClass(CoD.PurchaseContractConfirmation)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate:mergeStateConditions({
		{
			stateName = "WorkingState",
			condition = function(menu, element, event)
				return IsElementInState(element, "WorkingState")
			end,
		},
		{
			stateName = "ErrorState",
			condition = function(menu, element, event)
				return IsElementInState(element, "ErrorState")
			end,
		},
		{
			stateName = "CustomState",
			condition = function(menu, element, event)
				return IsElementInState(element, "CustomState")
			end,
		},
		{
			stateName = "FinishedState",
			condition = function(menu, element, event)
				return IsElementInState(element, "FinishedState")
			end,
		},
	})
	FullscreenPopupTemplate.ButtonList:setWidgetType(CoD.ItemShopButton)
	FullscreenPopupTemplate.ButtonList:setDataSource("PurchaseContractConfirmationButtons")
	FullscreenPopupTemplate.ErrorSubtitle:setText(Engine[0xF9F1239CFD921FE](0x306208DB7BBE129))
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x9D00A7D3D969F6E))
	FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(0xDDD82D5235E28E7))
	FullscreenPopupTemplate.DoneTitle.__Done_Title = function()
		FullscreenPopupTemplate.DoneTitle:setText(Engine[0xF9F1239CFD921FE](CoD.ContractUtility.UsePurchaseAndActivateContractCompleteTitleIfNeeded(f1_arg0, 0x2D662663ACE5444)))
	end
	FullscreenPopupTemplate.DoneTitle.__Done_Title()
	FullscreenPopupTemplate:linkToElementModel(self, nil, false, function(model)
		FullscreenPopupTemplate:setModel(model, f1_arg0)
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			FullscreenPopupTemplate.Subtitle:setText(CoD.ContractUtility.GetPurchaseContractConfirmDesc(self:getModel(), f1_arg0, f8_local0))
		end
	end)
	FullscreenPopupTemplate.DoneSubtitle.__Done_Subtitle = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			FullscreenPopupTemplate.DoneSubtitle:setText(CoD.ContractUtility.GetPurchaseContractCompleteDesc(self:getModel(), f1_arg0, f9_local0))
		end
	end
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, FullscreenPopupTemplate.DoneSubtitle.__Done_Subtitle)
	FullscreenPopupTemplate.DoneSubtitle.__Done_Subtitle_FullPath = function()
		local f10_local0 = self:getModel()
		if f10_local0 then
			f10_local0 = self:getModel()
			f10_local0 = f10_local0.name
		end
		if f10_local0 then
			FullscreenPopupTemplate.DoneSubtitle.__Done_Subtitle(f10_local0)
		end
	end
	LUI.OverrideFunction_CallOriginalFirst(FullscreenPopupTemplate, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		if IsPC() and IsElementInState(element, "FinishedState") then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
			UpdateSelfElementState(f1_local1, self.StateIndicator, controller)
		elseif IsPC() and IsElementInState(element, "ErrorState") then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
			UpdateSelfElementState(f1_local1, self.StateIndicator, controller)
		elseif IsPC() then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
			UpdateSelfElementState(f1_local1, self.StateIndicator, controller)
		else
			UpdateSelfElementState(f1_local1, self.StateIndicator, controller)
		end
	end)
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local SelfIdentityBadge = CoD.SelfIdentityBadge.new(f1_local1, f1_arg0, 0.5, 0.5, 541, 872, 0, 0, 33.5, 98.5)
	SelfIdentityBadge:setAlpha(0)
	SelfIdentityBadge:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		SelfIdentityBadge:setModel(model, f1_arg0)
	end)
	self:addElement(SelfIdentityBadge)
	self.SelfIdentityBadge = SelfIdentityBadge
	local Linker = LUI.UIImage.new(0.5, 0.5, -330, -326, 0.5, 0.5, -192, 205)
	Linker:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker:setAlpha(0.35)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local CornerPip = LUI.UIImage.new(0.5, 0.5, -802.5, -786.5, 0.5, 0.5, -187, -171)
	CornerPip:setAlpha(0.4)
	CornerPip:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip)
	self.CornerPip = CornerPip
	local CornerPip2 = LUI.UIImage.new(0.5, 0.5, -494.5, -478.5, 0.5, 0.5, -187, -171)
	CornerPip2:setAlpha(0.4)
	CornerPip2:setZRot(270)
	CornerPip2:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip2)
	self.CornerPip2 = CornerPip2
	local CornerPip3 = LUI.UIImage.new(0.5, 0.5, -803.5, -787.5, 0.5, 0.5, 122, 138)
	CornerPip3:setAlpha(0.4)
	CornerPip3:setZRot(90)
	CornerPip3:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip3)
	self.CornerPip3 = CornerPip3
	local CornerPip4 = LUI.UIImage.new(0.5, 0.5, -494.5, -478.5, 0.5, 0.5, 121, 137)
	CornerPip4:setAlpha(0.4)
	CornerPip4:setZRot(180)
	CornerPip4:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip4)
	self.CornerPip4 = CornerPip4
	local Black = LUI.UIImage.new(0.5, 0.5, -960, -330, 0.5, 0.5, -214.5, 230.5)
	Black:setRGB(0, 0, 0)
	Black:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	Black:setShaderVector(0, 0, 1, 0, 0)
	Black:setShaderVector(1, 0, 0.16, 0, 0)
	Black:setShaderVector(2, 0, 1, 0, 0)
	Black:setShaderVector(3, 0, 0, 0, 0)
	Black:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Black)
	self.Black = Black
	local ContentImage = CoD.PurchaseItemContentImage.new(f1_local1, f1_arg0, 0.5, 0.5, -1244, -412, 0.5, 0.5, -204, 172)
	ContentImage:linkToElementModel(self, nil, false, function(model)
		ContentImage:setModel(model, f1_arg0)
	end)
	self:addElement(ContentImage)
	self.ContentImage = ContentImage
	local StateIndicator = CoD.PurchaseContract_StateIndicator.new(f1_local1, f1_arg0, 0.5, 0.5, -960, -330, 0.5, 0.5, 183.5, 226.5)
	StateIndicator:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return IsElementInState(self.FullscreenPopupTemplate, "FinishedState") and CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "purchaseContractNoActivate")
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return IsElementInState(self.FullscreenPopupTemplate, "FinishedState")
			end,
		},
	})
	local CommonIdentityWidgetStreamlinedPC = StateIndicator
	local StartMenuCODpoints = StateIndicator.subscribeToModel
	local f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	StartMenuCODpoints(CommonIdentityWidgetStreamlinedPC, f1_local14.purchaseContractNoActivate, function(f16_arg0)
		f1_local1:updateElementState(StateIndicator, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "purchaseContractNoActivate",
		})
	end, false)
	StateIndicator:linkToElementModel(self, "price", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			StateIndicator.CostText:setText(LocalizeIntoString(0x6A3CC7BE3008989, f17_local0))
		end
	end)
	self:addElement(StateIndicator)
	self.StateIndicator = StateIndicator
	StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 341, 445, 0, 0, 23.5, 103.5)
	StartMenuCODpoints:setAlpha(0)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f18_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	CommonIdentityWidgetStreamlinedPC = nil
	CommonIdentityWidgetStreamlinedPC = CoD.CommonIdentityWidgetStreamlined.new(f1_local1, f1_arg0, 0.5, 0.5, 426, 956, 0.5, 0.5, -282, -242)
	CommonIdentityWidgetStreamlinedPC:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlinedPC:setModel(model, f1_arg0)
	end)
	self:addElement(CommonIdentityWidgetStreamlinedPC)
	self.CommonIdentityWidgetStreamlinedPC = CommonIdentityWidgetStreamlinedPC
	f1_local14 = nil
	self.CommonIdentityWidgetStreamlinedC = LUI.UIElement.createFake()
	local ContractName = LUI.UIText.new(0.5, 0.5, -960, -330, 0.5, 0.5, 144.5, 183.5)
	ContractName:setTTF("ttmussels_demibold")
	ContractName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ContractName:linkToElementModel(self, "name", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			ContractName:setText(Engine[0xF9F1239CFD921FE](f20_local0))
		end
	end)
	self:addElement(ContractName)
	self.ContractName = ContractName
	local f1_local16 = FullscreenPopupTemplate
	local f1_local17 = FullscreenPopupTemplate.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local17(f1_local16, f1_local18.purchaseContractNoActivate, FullscreenPopupTemplate.DoneSubtitle.__Done_Subtitle_FullPath)
	f1_local16 = FullscreenPopupTemplate
	f1_local17 = FullscreenPopupTemplate.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local17(f1_local16, f1_local18.purchaseContractNoActivate, FullscreenPopupTemplate.DoneTitle.__Done_Title)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			DelayCloseAndGoBack(menu, controller, 0)
			ForceNotifyGlobalModel(controller, "ContractsForceUpdate")
			return true
		elseif IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			GoBack(self, controller)
			return true
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not MenuPropertyIsTrue(menu, "__keepPopupButtonListPC") then
			SetElementWorkingStateAndPurchaseDWSKU(self.FullscreenPopupTemplate, controller)
			PlaySoundAlias("uin_points_purchase")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
			return true
		elseif IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not MenuPropertyIsTrue(menu, "__keepPopupButtonListPC") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x85952ACC6D0C1B0, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "ItemshopRotation", "cycled", function(model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") and CoD.ContractUtility.OpenedContractExpired(self, self, f1_arg0) then
			GoBack(self, f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "AutoEvents", "cycled", function(model)
		local f26_local0 = self
		if IsElementInAnyState(self.FullscreenPopupTemplate, "WorkingState", "ErrorState", "CustomState", "FinishedState") then
			DelayCloseAndGoBack(f1_local1, f1_arg0, 0)
		end
	end)
	FullscreenPopupTemplate.buttons:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.buttonPC:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.id = "FullscreenPopupTemplate"
	SelfIdentityBadge.id = "SelfIdentityBadge"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FullscreenPopupTemplate
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local17 = self
	SetMenuProperty(f1_local1, "_isContract", true)
	return self
end
CoD.PurchaseContractConfirmation.__onClose = function(f27_arg0)
	f27_arg0.FullscreenPopupTemplate:close()
	f27_arg0.SelfIdentityBadge:close()
	f27_arg0.ContentImage:close()
	f27_arg0.StateIndicator:close()
	f27_arg0.StartMenuCODpoints:close()
	f27_arg0.CommonIdentityWidgetStreamlinedPC:close()
	f27_arg0.CommonIdentityWidgetStreamlinedC:close()
	f27_arg0.ContractName:close()
end
