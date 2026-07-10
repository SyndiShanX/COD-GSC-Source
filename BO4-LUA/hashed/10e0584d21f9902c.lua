require("x64:bc6e2379d2241fb")
require("x64:3f0c583dc4db051")
require("x64:5d80cb371475b19")
require("x64:79ffb6336ac6e4c")
require("x64:156d841adc02c80")
require("x64:f035e2b6323687d")
require("x64:4cee61320cd1f1b")
CoD.ItemShopCaseExchangeConfirmation = InheritFrom(CoD.Menu)
LUI.createMenu.ItemShopCaseExchangeConfirmation = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ItemShopCaseExchangeConfirmation", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	SetMenuProperty(f1_local1, "_closeAndGoBack", true)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1._properties)
	self:setClass(CoD.ItemShopCaseExchangeConfirmation)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
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
	FullscreenPopupTemplate.Subtitle:setText(Engine[0xF9F1239CFD921FE](0xFD2315D7C41480E))
	FullscreenPopupTemplate.ErrorSubtitle:setText(LocalizeToUpperString(0xA5FEF098BBBD5A3))
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x54D5E3ECAB13858))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(0x456F58A03ED7888))
	FullscreenPopupTemplate:linkToElementModel(self, nil, false, function(model)
		FullscreenPopupTemplate:setModel(model, f1_arg0)
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			FullscreenPopupTemplate.Title:setText(ToUpper(LocalizeIntoString(0xBCE67CC57BD00E0, f7_local0)))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(FullscreenPopupTemplate, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		if IsPC() and IsElementInState(element, "FinishedState") then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		elseif IsPC() and IsElementInState(element, "ErrorState") then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		elseif IsPC() then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
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
	local f1_local9 = nil
	self.Black = LUI.UIElement.createFake()
	local BlackPC = nil
	BlackPC = LUI.UIImage.new(0.5, 0.5, -960, -330, 0.5, 0.5, -214.5, 230.5)
	BlackPC:setRGB(0, 0, 0)
	BlackPC:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	BlackPC:setShaderVector(0, 0, 1, 0, 0)
	BlackPC:setShaderVector(1, 0.16, 0.16, 0, 0)
	BlackPC:setShaderVector(2, 0, 1, 0, 0)
	BlackPC:setShaderVector(3, 0, 0, 0, 0)
	BlackPC:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(BlackPC)
	self.BlackPC = BlackPC
	local ContentImage = CoD.PurchaseItemShopContentImage.new(f1_local1, f1_arg0, 0.5, 0.5, -1244, -412, 0.5, 0.5, -204, 172)
	ContentImage:linkToElementModel(self, nil, false, function(model)
		ContentImage:setModel(model, f1_arg0)
	end)
	self:addElement(ContentImage)
	self.ContentImage = ContentImage
	local CostText = LUI.UIText.new(0.5, 0.5, -960, -330, 0.5, 0.5, 196, 226)
	CostText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CostText:setTTF("ttmussels_demibold")
	CostText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CostText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CostText:linkToElementModel(self, "casePrice", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CostText:setText(LocalizeIntoStringIfNotEmpty(0x9CBD79D3C8A2BED, f11_local0))
		end
	end)
	self:addElement(CostText)
	self.CostText = CostText
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
	local f1_local15 = nil
	self.CommonIdentityWidgetStreamlinedC = LUI.UIElement.createFake()
	local SpinnerLoadingAnimation = CoD.SpinnerLoadingAnimation.new(f1_local1, f1_arg0, 0.5, 0.5, -285, -225, 0.5, 0.5, -64, -4)
	SpinnerLoadingAnimation:setAlpha(0)
	self:addElement(SpinnerLoadingAnimation)
	self.SpinnerLoadingAnimation = SpinnerLoadingAnimation
	local TextBox = LUI.UIText.new(0.5, 0.5, -269, 471, 0.5, 0.5, -132, -110)
	TextBox:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TextBox:setAlpha(0)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x5F5E0C5965105B7))
	TextBox:setTTF("dinnext_regular")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:linkToElementModel(self, "casePrice", true, function(model, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
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
		if IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			GoBack(self, controller)
			return true
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") and CoD.ModelUtility.IsSelfModelValueGreaterThan(self, controller, "casePrice", 0) then
			CoD.BlackMarketUtility.SetElementWorkingStateAndExchangeLootCases(self.FullscreenPopupTemplate, controller)
			PlaySoundAlias("uin_points_purchase")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") and CoD.ModelUtility.IsSelfModelValueGreaterThan(self, controller, "casePrice", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x7C2737E72EC4A26, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "ItemshopRotation.cycled", function(model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") and CoD.BlackMarketUtility.WasItemCycled(f1_arg0, self) then
			GoBack(self, f1_arg0)
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
	return self
end
CoD.ItemShopCaseExchangeConfirmation.__resetProperties = function(f20_arg0)
	f20_arg0.SpinnerLoadingAnimation:completeAnimation()
	f20_arg0.TextBox:completeAnimation()
	f20_arg0.SpinnerLoadingAnimation:setAlpha(0)
	f20_arg0.TextBox:setTopBottom(0.5, 0.5, -132, -110)
	f20_arg0.TextBox:setAlpha(0)
end
CoD.ItemShopCaseExchangeConfirmation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.SpinnerLoadingAnimation:completeAnimation()
			f21_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.SpinnerLoadingAnimation)
			f21_arg0.TextBox:completeAnimation()
			f21_arg0.TextBox:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TextBox)
		end,
	},
	UnlockingTiers = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.SpinnerLoadingAnimation:completeAnimation()
			f22_arg0.SpinnerLoadingAnimation:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.SpinnerLoadingAnimation)
			f22_arg0.TextBox:completeAnimation()
			f22_arg0.TextBox:setTopBottom(0, 0, 406, 428)
			f22_arg0.TextBox:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.TextBox)
		end,
	},
}
CoD.ItemShopCaseExchangeConfirmation.__onClose = function(f23_arg0)
	f23_arg0.FullscreenPopupTemplate:close()
	f23_arg0.SelfIdentityBadge:close()
	f23_arg0.ContentImage:close()
	f23_arg0.CostText:close()
	f23_arg0.StartMenuCODpoints:close()
	f23_arg0.CommonIdentityWidgetStreamlinedPC:close()
	f23_arg0.CommonIdentityWidgetStreamlinedC:close()
	f23_arg0.SpinnerLoadingAnimation:close()
end
