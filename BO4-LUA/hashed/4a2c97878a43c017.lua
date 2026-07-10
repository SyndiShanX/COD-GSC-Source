require("x64:bc6e2379d2241fb")
require("x64:3f0c583dc4db051")
require("x64:ce1e6b6549d478c")
require("x64:5d80cb371475b19")
require("x64:156d841adc02c80")
require("x64:bd4f2948bbf0002")
CoD.PurchaseTiersConfirmation = InheritFrom(CoD.Menu)
LUI.createMenu.PurchaseTiersConfirmation = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PurchaseTiersConfirmation", f1_arg0)
	local f1_local1 = self
	InitDataSourceModel(f1_arg0, "TierPurchase")
	SetModelToGlobalDataSource(f1_arg0, self, "TierPurchase")
	DataSourceHelperRecreate(f1_arg0, "TierPurchase")
	SetMenuProperty(f1_local1, "__keepPopupButtonListPC", true)
	self:setClass(CoD.PurchaseTiersConfirmation)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate.ButtonList:setWidgetType(CoD.ItemShopButton)
	FullscreenPopupTemplate.ButtonList:setDataSource("TierPurchaseList")
	FullscreenPopupTemplate.Subtitle:setText(Engine[0xF9F1239CFD921FE](0x73FB71DD306C936))
	FullscreenPopupTemplate.ErrorSubtitle:setText(LocalizeToUpperString(0xA3298EE0A8F4603))
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x9D00A7D3D969F6E))
	FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(0x8CCB8B7EF76929B))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(0x83048BBBD98FC6A))
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local PopupImage = LUI.UIImage.new(0.5, 0.5, -960, -324, 0.5, 0.5, -214, 230)
	PopupImage:setImage(RegisterImage(0xCDD43147C7EA23E))
	self:addElement(PopupImage)
	self.PopupImage = PopupImage
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:setAlpha(0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local TextBGBox = LUI.UIImage.new(0.5, 0.5, -912.5, -371.5, 0.5, 0.5, 135, 178)
	TextBGBox:setRGB(0.36, 0.63, 0.74)
	TextBGBox:setAlpha(0.01)
	TextBGBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TextBGBox:setShaderVector(0, 0, 0, 0, 0)
	TextBGBox:setupNineSliceShader(4, 4)
	self:addElement(TextBGBox)
	self.TextBGBox = TextBGBox
	local BGDotPatternLarge = LUI.UIImage.new(0.5, 0.5, -912.5, -371.5, 0.5, 0.5, 135, 178)
	BGDotPatternLarge:setRGB(0.36, 0.63, 0.74)
	BGDotPatternLarge:setAlpha(0.06)
	BGDotPatternLarge:setImage(RegisterImage(0xFC21A8215EA012B))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local AccentLineTop = LUI.UIImage.new(0.5, 0.5, -916, -368, 0.5, 0.5, 121, 141)
	AccentLineTop:setRGB(0.5, 0.85, 1)
	AccentLineTop:setAlpha(0.08)
	AccentLineTop:setImage(RegisterImage(0x86466DCA17566C6))
	self:addElement(AccentLineTop)
	self.AccentLineTop = AccentLineTop
	local AccentLineBottom = LUI.UIImage.new(0.5, 0.5, -916, -368, 0.5, 0.5, 173, 193)
	AccentLineBottom:setRGB(0.5, 0.85, 1)
	AccentLineBottom:setAlpha(0.08)
	AccentLineBottom:setImage(RegisterImage(0x86466DCA17566C6))
	self:addElement(AccentLineBottom)
	self.AccentLineBottom = AccentLineBottom
	local BracketRight = LUI.UIImage.new(0.5, 0.5, -383, -359, 0.5, 0.5, 121, 193)
	BracketRight:setRGB(0.79, 0.94, 1)
	BracketRight:setImage(RegisterImage(0xE1C1C55D18A0A1B))
	self:addElement(BracketRight)
	self.BracketRight = BracketRight
	local BracketLeft = LUI.UIImage.new(0.5, 0.5, -926, -902, 0.5, 0.5, 121, 193)
	BracketLeft:setRGB(0.79, 0.94, 1)
	BracketLeft:setYRot(180)
	BracketLeft:setImage(RegisterImage(0xE1C1C55D18A0A1B))
	self:addElement(BracketLeft)
	self.BracketLeft = BracketLeft
	local Tiers = LUI.UIText.new(0.5, 0.5, -874.5, -409.5, 0.5, 0.5, 138, 178)
	Tiers:setRGB(0.5, 0.85, 1)
	Tiers:setTTF("ttmussels_demibold")
	Tiers:setMaterial(LUI.UIImage.GetCachedMaterial(0x93F361CC41C94AF))
	Tiers:setShaderVector(0, 0.8, 0, 0, 0)
	Tiers:setShaderVector(1, 0, 0, 0, 0)
	Tiers:setShaderVector(2, 0, 0.7, 1, 0.2)
	Tiers:setLetterSpacing(6)
	Tiers:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Tiers:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Tiers)
	self.Tiers = Tiers
	local Price = LUI.UIText.new(0.5, 0.5, -957, -327, 0.5, 0.5, 196, 222)
	Price:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	Price:setTTF("ttmussels_demibold")
	Price:setLetterSpacing(4)
	Price:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Price:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Price)
	self.Price = Price
	local Purchase = LUI.UIText.new(0.5, 0.5, -960, -330, 0.5, 0.5, 104, 124)
	Purchase:setRGB(0.82, 0.95, 1)
	Purchase:setText(LocalizeToUpperString(0x85952ACC6D0C1B0))
	Purchase:setTTF("ttmussels_regular")
	Purchase:setLetterSpacing(3)
	Purchase:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Purchase:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Purchase)
	self.Purchase = Purchase
	local Linker = LUI.UIImage.new(0.5, 0.5, -330, -326, 0.5, 0.5, -192, 205)
	Linker:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker:setAlpha(0.35)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local SpinnerLoadingAnimation = CoD.SpinnerLoadingAnimation.new(f1_local1, f1_arg0, 0.5, 0.5, -285, -157, 0.5, 0.5, -64, 64)
	SpinnerLoadingAnimation:setAlpha(0)
	self:addElement(SpinnerLoadingAnimation)
	self.SpinnerLoadingAnimation = SpinnerLoadingAnimation
	local TextBox = LUI.UIText.new(0.5, 0.5, -285, 455, 0.5, 0.5, -132, -110)
	TextBox:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TextBox:setAlpha(0)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x5F5E0C5965105B7))
	TextBox:setTTF("dinnext_regular")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local CommonIdentityWidgetStreamlinedPC = nil
	CommonIdentityWidgetStreamlinedPC = CoD.CommonIdentityWidgetStreamlined.new(f1_local1, f1_arg0, 0.5, 0.5, 426, 956, 0.5, 0.5, -282, -242)
	CommonIdentityWidgetStreamlinedPC:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlinedPC:setModel(model, f1_arg0)
	end)
	self:addElement(CommonIdentityWidgetStreamlinedPC)
	self.CommonIdentityWidgetStreamlinedPC = CommonIdentityWidgetStreamlinedPC
	local f1_local19 = nil
	self.CommonIdentityWidgetStreamlinedC = LUI.UIElement.createFake()
	local ImagePrompt = CoD.ImagePrompt.new(f1_local1, f1_arg0, 0.5, 0.5, -285, 195, 0.5, 0.5, -118, -58)
	ImagePrompt:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "LootStreamProgress.allRngUnlocked")
			end,
		},
	})
	local f1_local21 = ImagePrompt
	local CratePurchaseTip = ImagePrompt.subscribeToModel
	local f1_local23 = Engine[0x4DF5CFBC1771947](f1_arg0)
	CratePurchaseTip(f1_local21, f1_local23["LootStreamProgress.allRngUnlocked"], function(f5_arg0)
		f1_local1:updateElementState(ImagePrompt, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "LootStreamProgress.allRngUnlocked",
		})
	end, false)
	ImagePrompt.ImagePromptInternal.warningIcon:setImage(RegisterImage(0x4CE3CD81428CFA5))
	ImagePrompt.ImagePromptInternal.warningTextPrompt:setText(Engine[0xF9F1239CFD921FE](0xAB9A04058E8DADC))
	self:addElement(ImagePrompt)
	self.ImagePrompt = ImagePrompt
	CratePurchaseTip = CoD.ImagePrompt.new(f1_local1, f1_arg0, 0.5, 0.5, -285, 195, 0.5, 0.5, -118, -58)
	CratePurchaseTip:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "CratePurchaseTip")
			end,
		},
	})
	CratePurchaseTip:linkToElementModel(CratePurchaseTip, "CratePurchaseTip", true, function(model)
		f1_local1:updateElementState(CratePurchaseTip, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "CratePurchaseTip",
		})
	end)
	CratePurchaseTip.ImagePromptInternal.warningIcon:setImage(RegisterImage(0x4CE3CD81428CFA5))
	CratePurchaseTip:linkToElementModel(self, nil, false, function(model)
		CratePurchaseTip:setModel(model, f1_arg0)
	end)
	CratePurchaseTip:linkToElementModel(self, "CrateCost", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CratePurchaseTip.ImagePromptInternal.warningTextPrompt:setText(LocalizeIntoString(0x856283FBFAE4074, f9_local0))
		end
	end)
	self:addElement(CratePurchaseTip)
	self.CratePurchaseTip = CratePurchaseTip
	Tiers:linkToElementModel(FullscreenPopupTemplate.ButtonList, "tierRef", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Tiers:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	Price:linkToElementModel(FullscreenPopupTemplate.ButtonList, "priceRef", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Price:setText(CoD.BaseUtility.AlreadyLocalized(f11_local0))
		end
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f12_local0 = nil
		if self.OcclusionChange then
			f12_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f12_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) and IsMenuInState(f1_local1, "UnlockingTiers") then
			GoBack(self, f1_arg0)
		end
		if not f12_local0 then
			f12_local0 = self:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsMenuInState(menu, "UnlockingTiers") then
			CoD.BlackMarketUtility.SendPurchaseTiersEvent(controller, menu)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsMenuInState(menu, "UnlockingTiers") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		PlaySoundAlias("uin_menu_action")
		MenuHidesFreeCursor(f15_arg2, f15_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "AutoEvents.cycled", function(model)
		local f16_local0 = self
		if MenuPropertyIsTrue(f1_local1, "__postLoadFinished") then
			CoD.BlackMarketUtility.SendPurchaseTiersEvent(f1_arg0, f1_local1)
			GoBack(self, f1_arg0)
		end
	end)
	FullscreenPopupTemplate.buttons:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.buttonPC:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.id = "FullscreenPopupTemplate"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FullscreenPopupTemplate
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local21 = self
	SetMenuProperty(f1_local1, "__postLoadFinished", true)
	f1_local21 = FullscreenPopupTemplate
	if IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local21, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end
	return self
end
CoD.PurchaseTiersConfirmation.__resetProperties = function(f18_arg0)
	f18_arg0.SpinnerLoadingAnimation:completeAnimation()
	f18_arg0.TextBox:completeAnimation()
	f18_arg0.SpinnerLoadingAnimation:setAlpha(0)
	f18_arg0.TextBox:setLeftRight(0.5, 0.5, -285, 455)
	f18_arg0.TextBox:setAlpha(0)
end
CoD.PurchaseTiersConfirmation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.SpinnerLoadingAnimation:completeAnimation()
			f19_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.SpinnerLoadingAnimation)
			f19_arg0.TextBox:completeAnimation()
			f19_arg0.TextBox:setLeftRight(0.5, 0.5, -269, 431)
			f19_arg0.TextBox:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TextBox)
		end,
	},
	UnlockingTiers = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.SpinnerLoadingAnimation:completeAnimation()
			f20_arg0.SpinnerLoadingAnimation:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.SpinnerLoadingAnimation)
			f20_arg0.TextBox:completeAnimation()
			f20_arg0.TextBox:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.TextBox)
		end,
	},
}
CoD.PurchaseTiersConfirmation.__onClose = function(f21_arg0)
	f21_arg0.__on_close_removeOverrides()
	f21_arg0.Tiers:close()
	f21_arg0.Price:close()
	f21_arg0.FullscreenPopupTemplate:close()
	f21_arg0.FooterContainerFrontendRight:close()
	f21_arg0.SpinnerLoadingAnimation:close()
	f21_arg0.CommonIdentityWidgetStreamlinedPC:close()
	f21_arg0.CommonIdentityWidgetStreamlinedC:close()
	f21_arg0.ImagePrompt:close()
	f21_arg0.CratePurchaseTip:close()
end
