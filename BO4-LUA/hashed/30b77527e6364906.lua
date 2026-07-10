require("x64:bc6e2379d2241fb")
require("x64:3f0c583dc4db051")
require("x64:2a83f25ce6a0dd3")
require("x64:f035e2b6323687d")
require("x64:4cee61320cd1f1b")
CoD.PurchaseReservesItem = InheritFrom(CoD.Menu)
LUI.createMenu.PurchaseReservesItem = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PurchaseReservesItem", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1._properties)
	SetMenuProperty(f1_local1, "__keepPopupButtonListPC", true)
	SetMenuProperty(f1_local1, "_isReservesItem", true)
	SetMenuProperty(f1_local1, "name", f1_arg1._model.name:get())
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	SetMenuProperty(f1_local1, "price", f1_arg1._model.price:get())
	self:setClass(CoD.PurchaseReservesItem)
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
	FullscreenPopupTemplate.ButtonList:setDataSource("PurchaseReservesItemButtons")
	FullscreenPopupTemplate.ErrorSubtitle:setText("")
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x9D00A7D3D969F6E))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(0x83048BBBD98FC6A))
	FullscreenPopupTemplate:linkToElementModel(self, nil, false, function(model)
		FullscreenPopupTemplate:setModel(model, f1_arg0)
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			FullscreenPopupTemplate.Subtitle:setText(LocalizeIntoString(0xAF16248246D3D96, f7_local0))
		end
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			FullscreenPopupTemplate.Title:setText(ToUpper(LocalizeIntoString(0x63FCD1B0849669E, f8_local0)))
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
	local PopupImage = LUI.UIImage.new(0.5, 0.5, -960, -324, 0.5, 0.5, -214, 230)
	PopupImage:linkToElementModel(self, "popupImage", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			PopupImage:setImage(RegisterImage(f10_local0))
		end
	end)
	self:addElement(PopupImage)
	self.PopupImage = PopupImage
	local Linker = LUI.UIImage.new(0.5, 0.5, -330, -326, 0.5, 0.5, -192, 205)
	Linker:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker:setAlpha(0.35)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local Price = LUI.UIText.new(0.5, 0.5, -957, -327, 0.5, 0.5, 196, 222)
	Price:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	Price:setTTF("ttmussels_demibold")
	Price:setLetterSpacing(4)
	Price:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Price:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Price:linkToElementModel(self, "price", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Price:setText(LocalizeIntoString(0x7AD54B6F8C27799, f11_local0))
		end
	end)
	self:addElement(Price)
	self.Price = Price
	local StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 341, 445, 0, 0, 23.5, 103.5)
	StartMenuCODpoints:setAlpha(0)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f12_local0))
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
	local f1_local9 = nil
	self.CommonIdentityWidgetStreamlinedC = LUI.UIElement.createFake()
	local Purchase = LUI.UIText.new(0.5, 0.5, -960, -330, 0.5, 0.5, 104, 124)
	Purchase:setRGB(0.82, 0.95, 1)
	Purchase:setText(LocalizeToUpperString(0x85952ACC6D0C1B0))
	Purchase:setTTF("ttmussels_regular")
	Purchase:setLetterSpacing(3)
	Purchase:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Purchase:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Purchase)
	self.Purchase = Purchase
	local ItemName = LUI.UIText.new(0.5, 0.5, -914.5, -370.5, 0.5, 0.5, 138, 178)
	ItemName:setRGB(0.5, 0.85, 1)
	ItemName:setTTF("ttmussels_demibold")
	ItemName:setMaterial(LUI.UIImage.GetCachedMaterial(0x93F361CC41C94AF))
	ItemName:setShaderVector(0, 0.8, 0, 0, 0)
	ItemName:setShaderVector(1, 0, 0, 0, 0)
	ItemName:setShaderVector(2, 0, 0.7, 1, 0.2)
	ItemName:setLetterSpacing(6)
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ItemName:linkToElementModel(self, "name", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			ItemName:setText(LocalizeToUpperString(f14_local0))
		end
	end)
	self:addElement(ItemName)
	self.ItemName = ItemName
	local BracketLeft = LUI.UIImage.new(0.5, 0.5, -926, -902, 0.5, 0.5, 121, 193)
	BracketLeft:setRGB(0.79, 0.94, 1)
	BracketLeft:setYRot(180)
	BracketLeft:setImage(RegisterImage(0xE1C1C55D18A0A1B))
	self:addElement(BracketLeft)
	self.BracketLeft = BracketLeft
	local BracketRight = LUI.UIImage.new(0.5, 0.5, -383, -359, 0.5, 0.5, 121, 193)
	BracketRight:setRGB(0.79, 0.94, 1)
	BracketRight:setImage(RegisterImage(0xE1C1C55D18A0A1B))
	self:addElement(BracketRight)
	self.BracketRight = BracketRight
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			GoBack(self, controller)
			CoD.BlackMarketUtility.SendPurchaseReservesEvent(controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x70A9FDC87CD3D48, nil, nil)
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
			DelayGoBack(f1_local1, f1_arg0, 50)
		end
	end)
	self:linkToElementModel(self, "price", true, function(model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToPropertyValue(self, f1_arg0, "price", "price") then
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
	local f1_local14 = self
	f1_local14 = FullscreenPopupTemplate
	if IsPC() and IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local14, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	elseif IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local14, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end
	return self
end
CoD.PurchaseReservesItem.__onClose = function(f22_arg0)
	f22_arg0.FullscreenPopupTemplate:close()
	f22_arg0.SelfIdentityBadge:close()
	f22_arg0.PopupImage:close()
	f22_arg0.Price:close()
	f22_arg0.StartMenuCODpoints:close()
	f22_arg0.CommonIdentityWidgetStreamlinedPC:close()
	f22_arg0.CommonIdentityWidgetStreamlinedC:close()
	f22_arg0.ItemName:close()
end
