require("x64:ee455bcbe1a7e9")
require("x64:8e660a4623a5e21")
require("x64:3f0c583dc4db051")
require("x64:ce1e6b6549d478c")
require("x64:156d841adc02c80")
CoD.WZPurchaseCamo = InheritFrom(CoD.Menu)
LUI.createMenu.WZPurchaseCamo = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WZPurchaseCamo", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1._model)
	SetMenuProperty(f1_local1, "__keepPopupButtonListPC", true)
	self:setClass(CoD.WZPurchaseCamo)
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
	FullscreenPopupTemplate.ButtonList:setWidgetType(CoD.CommonListButton)
	FullscreenPopupTemplate.ButtonList:setDataSource("PurchaseCamoList")
	FullscreenPopupTemplate.Subtitle:setText(Engine[0xF9F1239CFD921FE](0x47FEC1C323B4F6B))
	FullscreenPopupTemplate.ErrorSubtitle:setText("")
	FullscreenPopupTemplate.WorkingTitle:setText("")
	FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(0xC6D71184390ADDC))
	FullscreenPopupTemplate.DoneTitle:setText("")
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local PopupImage = LUI.UIImage.new(0.5, 0.5, -810, -474, 0.5, 0.5, -162, 78)
	PopupImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PopupImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PopupImage)
	self.PopupImage = PopupImage
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:setAlpha(0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
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
	Tiers:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Tiers:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Tiers)
	self.Tiers = Tiers
	local Purchase = LUI.UIText.new(0.5, 0.5, -960, -330, 0.5, 0.5, 104, 124)
	Purchase:setRGB(0.82, 0.95, 1)
	Purchase:setText(LocalizeToUpperString(0x1A06466EC351FA7))
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
	CommonIdentityWidgetStreamlinedPC = CoD.PaintCanIdentityWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 426, 956, 0.5, 0.5, -282, -242)
	CommonIdentityWidgetStreamlinedPC:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlinedPC:setModel(model, f1_arg0)
	end)
	self:addElement(CommonIdentityWidgetStreamlinedPC)
	self.CommonIdentityWidgetStreamlinedPC = CommonIdentityWidgetStreamlinedPC
	local f1_local18 = nil
	self.CommonIdentityWidgetStreamlinedC = LUI.UIElement.createFake()
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	self.__on_menuOpened_self = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		local f8_local0 = self
		PlaySoundAlias("uin_menu_action")
		MenuHidesFreeCursor(f8_arg2, f8_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
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
	local f1_local19 = self
	f1_local19 = FullscreenPopupTemplate
	if IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local19, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end
	return self
end
CoD.WZPurchaseCamo.__resetProperties = function(f10_arg0)
	f10_arg0.SpinnerLoadingAnimation:completeAnimation()
	f10_arg0.TextBox:completeAnimation()
	f10_arg0.SpinnerLoadingAnimation:setAlpha(0)
	f10_arg0.TextBox:setLeftRight(0.5, 0.5, -285, 455)
	f10_arg0.TextBox:setAlpha(0)
end
CoD.WZPurchaseCamo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.SpinnerLoadingAnimation:completeAnimation()
			f11_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.SpinnerLoadingAnimation)
			f11_arg0.TextBox:completeAnimation()
			f11_arg0.TextBox:setLeftRight(0.5, 0.5, -269, 431)
			f11_arg0.TextBox:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TextBox)
		end,
	},
}
CoD.WZPurchaseCamo.__onClose = function(f12_arg0)
	f12_arg0.__on_close_removeOverrides()
	f12_arg0.FullscreenPopupTemplate:close()
	f12_arg0.PopupImage:close()
	f12_arg0.FooterContainerFrontendRight:close()
	f12_arg0.Tiers:close()
	f12_arg0.SpinnerLoadingAnimation:close()
	f12_arg0.CommonIdentityWidgetStreamlinedPC:close()
	f12_arg0.CommonIdentityWidgetStreamlinedC:close()
end
