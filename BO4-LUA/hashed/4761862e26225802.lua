require("x64:bc6e2379d2241fb")
require("x64:3f0c583dc4db051")
require("x64:e4ab7898d6eef2c")
require("x64:2a83f25ce6a0dd3")
require("x64:f035e2b6323687d")
require("x64:4cee61320cd1f1b")
CoD.PurchaseBribeStack = InheritFrom(CoD.Menu)
LUI.createMenu.PurchaseBribeStack = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PurchaseBribeStack", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1._properties)
	SetMenuProperty(f1_local1, "__keepPopupButtonListPC", true)
	SetMenuProperty(f1_local1, "_isReservesItem", true)
	SetMenuProperty(f1_local1, "name", f1_arg1._model.name:get())
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	SetMenuProperty(f1_local1, "price", f1_arg1._model.price:get())
	self:setClass(CoD.PurchaseBribeStack)
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
	FullscreenPopupTemplate.ButtonList:setWidgetType(CoD.PurchaseReservesItemButton)
	FullscreenPopupTemplate.ButtonList:setDataSource("PurchaseBribeStackButtons")
	FullscreenPopupTemplate.ErrorSubtitle:setText("")
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(@"menu/purchase_processing"))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(@"menu/purchase_complete"))
	FullscreenPopupTemplate:linkToElementModel(self, "desc", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			FullscreenPopupTemplate.Subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.CheckForBribePopupDescOverride(self:getModel(), f6_local0)))
		end
	end)
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -960, -324, 0.5, 0.5, -214, 230)
	FixedAspectRatioImage:setStretchedDimension(6)
	FixedAspectRatioImage:linkToElementModel(self, "popupImage", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
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
	Linker:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 341, 445, 0, 0, 23.5, 103.5)
	StartMenuCODpoints:setAlpha(0)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f9_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	local CommonIdentityWidgetStreamlinedPC = nil
	CommonIdentityWidgetStreamlinedPC = CoD.CommonIdentityWidgetStreamlined.new(f1_local1, f1_arg0, 0.5, 0.5, 426, 956, 0.5, 0.5, -282, -242)
	CommonIdentityWidgetStreamlinedPC:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlinedPC:setModel(model, f1_arg0)
	end)
	self:addElement(CommonIdentityWidgetStreamlinedPC)
	self.CommonIdentityWidgetStreamlinedPC = CommonIdentityWidgetStreamlinedPC
	local f1_local8 = nil
	self.CommonIdentityWidgetStreamlinedC = LUI.UIElement.createFake()
	local ItemName = LUI.UIText.new(0.5, 0.5, -914.5, -370.5, 0.5, 0.5, 138, 178)
	ItemName:setRGB(0.5, 0.85, 1)
	ItemName:setTTF("ttmussels_demibold")
	ItemName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_593F361CC41C94AF"))
	ItemName:setShaderVector(0, 0.8, 0, 0, 0)
	ItemName:setShaderVector(1, 0, 0, 0, 0)
	ItemName:setShaderVector(2, 0, 0.7, 1, 0.2)
	ItemName:setLetterSpacing(6)
	ItemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ItemName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ItemName:linkToElementModel(self, "name", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ItemName:setText(LocalizeToUpperString(f11_local0))
		end
	end)
	self:addElement(ItemName)
	self.ItemName = ItemName
	local BracketLeft = LUI.UIImage.new(0.5, 0.5, -926, -902, 0.5, 0.5, 121, 193)
	BracketLeft:setRGB(0.79, 0.94, 1)
	BracketLeft:setYRot(180)
	BracketLeft:setImage(RegisterImage(@"uie_ui_menu_common_bracket01"))
	self:addElement(BracketLeft)
	self.BracketLeft = BracketLeft
	local BracketRight = LUI.UIImage.new(0.5, 0.5, -383, -359, 0.5, 0.5, 121, 193)
	BracketRight:setRGB(0.79, 0.94, 1)
	BracketRight:setImage(RegisterImage(@"uie_ui_menu_common_bracket01"))
	self:addElement(BracketRight)
	self.BracketRight = BracketRight
	local Price = CoD.ContractItemCostMultiCurrency.new(f1_local1, f1_arg0, 0, 0, 225.5, 410.5, 0, 0, 733, 754)
	Price:linkToElementModel(self, nil, false, function(model)
		Price:setModel(model, f1_arg0)
	end)
	self:addElement(Price)
	self.Price = Price
	self.FullscreenPopupTemplate:linkToElementModel(self, nil, false, function(model)
		FullscreenPopupTemplate:setModel(model, f1_arg0)
	end)
	self.FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			FullscreenPopupTemplate.Title:setText(ToUpper(LocalizeIntoString(@"menu/acquire_item", f14_local0)))
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.BlackMarketUtility.SendItemShopViewEvent(controller, menu, "")
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.BlackMarketUtility.SendItemShopViewEvent(controller, menu, "")
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ForceNotifyControllerModel(f1_arg0, "updateCrateBundleOffers")
	end)
	self:linkToElementModel(self, "name", true, function(model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToPropertyValue(self, f1_arg0, "name", "name") then
			CoD.BlackMarketUtility.SendItemShopViewEvent(f1_arg0, f1_local1, "")
			DelayGoBack(f1_local1, f1_arg0, 50)
		end
	end)
	self:linkToElementModel(self, "price", true, function(model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToPropertyValue(self, f1_arg0, "price", "price") then
			CoD.BlackMarketUtility.SendItemShopViewEvent(f1_arg0, f1_local1, "")
			DelayGoBack(f1_local1, f1_arg0, 50)
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
	local f1_local13 = self
	f1_local13 = FullscreenPopupTemplate
	if IsPC() and IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local13, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	elseif IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local13, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end
	return self
end
CoD.PurchaseBribeStack.__onClose = function(f22_arg0)
	f22_arg0.FullscreenPopupTemplate:close()
	f22_arg0.FixedAspectRatioImage:close()
	f22_arg0.SelfIdentityBadge:close()
	f22_arg0.StartMenuCODpoints:close()
	f22_arg0.CommonIdentityWidgetStreamlinedPC:close()
	f22_arg0.CommonIdentityWidgetStreamlinedC:close()
	f22_arg0.ItemName:close()
	f22_arg0.Price:close()
end
