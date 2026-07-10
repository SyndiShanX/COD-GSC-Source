require("x64:c7a70f5004ad7ac")
require("x64:2675595fa323085")
require("x64:7961759e01b9074")
require("x64:ba72b08fda6493")
require("x64:afb6fc994d349aa")
require("x64:87edb7802d72c0e")
CoD.PC_Store_Refund_Korea = InheritFrom(CoD.Menu)
LUI.createMenu.PC_Store_Refund_Korea = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_Store_Refund_Korea", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.CreateGlobalModel("PCStoreKoreaAccepts")
	self:setClass(CoD.PC_Store_Refund_Korea)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -229.5, 243.5)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -228, 242)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local ButtonList = LUI.UIList.new(f1_local1, f1_arg0, 28, 0, nil, false, false, false, false)
	ButtonList:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg0)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "hidden")
			end,
		},
	})
	ButtonList:linkToElementModel(ButtonList, "disabled", true, function(model)
		f1_local1:updateElementState(ButtonList, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	ButtonList:linkToElementModel(ButtonList, "hidden", true, function(model)
		f1_local1:updateElementState(ButtonList, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "hidden",
		})
	end)
	ButtonList:setLeftRight(0.5, 0.5, -273, 739)
	ButtonList:setTopBottom(0.5, 0.5, 122, 182)
	ButtonList:setWidgetType(CoD.featureOverlay_Button_Container)
	ButtonList:setHorizontalCount(5)
	ButtonList:setSpacing(28)
	ButtonList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonList:setDataSource("PCKoreaRefundButtons")
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(ButtonList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local ValidityPeriod = LUI.UIText.new(0.5, 0.5, -271, 879, 0.5, 0.5, -58.5, -37.5)
	ValidityPeriod:setRGB(ColorSet.T8_PC_CHAT_GAME_EVENT.r, ColorSet.T8_PC_CHAT_GAME_EVENT.g, ColorSet.T8_PC_CHAT_GAME_EVENT.b)
	ValidityPeriod:setTTF("ttmussels_regular")
	ValidityPeriod:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ValidityPeriod:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ValidityPeriod:linkToElementModel(self, "ValidityPeriod", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ValidityPeriod:setText(f9_local0)
		end
	end)
	self:addElement(ValidityPeriod)
	self.ValidityPeriod = ValidityPeriod
	local emptyFocusableCheck = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0.5, 0.5, -270, -230, 0.5, 0.5, 18, 58)
	self:addElement(emptyFocusableCheck)
	self.emptyFocusableCheck = emptyFocusableCheck
	local RefundOrNotText = LUI.UIText.new(0.5, 0.5, -208, 942, 0.5, 0.5, 29, 47)
	RefundOrNotText:setRGB(0.39, 0.39, 0.39)
	RefundOrNotText:setTTF("notosans_regular")
	RefundOrNotText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RefundOrNotText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	RefundOrNotText:linkToElementModel(self, "LegalText", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			RefundOrNotText:setText(f10_local0)
		end
	end)
	self:addElement(RefundOrNotText)
	self.RefundOrNotText = RefundOrNotText
	local CommonCheckbox = CoD.CommonCheckbox.new(f1_local1, f1_arg0, 0.5, 0.5, -270, -230, 0.5, 0.5, 18, 58)
	CommonCheckbox:mergeStateConditions({
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("PCStoreKoreaAccepts")
			end,
		},
	})
	local Title = CommonCheckbox
	local blur = CommonCheckbox.subscribeToModel
	local Description = Engine[@"getglobalmodel"]()
	blur(Title, Description.PCStoreKoreaAccepts, function(f12_arg0)
		f1_local1:updateElementState(CommonCheckbox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "PCStoreKoreaAccepts",
		})
	end, false)
	CommonCheckbox:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f13_local0
	end)
	f1_local1:AddButtonCallbackFunction(CommonCheckbox, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ToggleGlobalModelValueBoolean("PCStoreKoreaAccepts")
		UpdateElementState(self, "ButtonList", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(CommonCheckbox)
	self.CommonCheckbox = CommonCheckbox
	blur = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -229, 245)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	Title = LUI.UIText.new(0.5, 0.5, -272, 771, 0.5, 0.5, -187.5, -142.5)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Title:linkToElementModel(self, "Title", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			Title:setText(f16_local0)
		end
	end)
	self:addElement(Title)
	self.Title = Title
	Description = LUI.UIText.new(0.5, 0.5, -271, 541, 0.5, 0.5, -119, -97)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "Description", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			Description:setText(f17_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -230, -214)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 230, 246)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, -229, -223)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg0)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	local alertStatusBar2 = CoD.systemOverlay_alertStatusBar.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, 239, 245)
	alertStatusBar2:linkToElementModel(self, nil, false, function(model)
		alertStatusBar2:setModel(model, f1_arg0)
	end)
	self:addElement(alertStatusBar2)
	self.alertStatusBar2 = alertStatusBar2
	local codpoints = LUI.UIImage.new(0.5, 0.5, -695, -661, 0.5, 0.5, 156, 190)
	codpoints:setAlpha(0)
	codpoints:setImage(RegisterImage(@"uie_ui_codpoints_symbol_32x32"))
	self:addElement(codpoints)
	self.codpoints = codpoints
	local vial = LUI.UIImage.new(0.5, 0.5, -698, -660, 0.5, 0.5, 153, 191)
	vial:setAlpha(0)
	vial:setImage(RegisterImage(@"uie_t7_hud_zm_vial_aar_256"))
	self:addElement(vial)
	self.vial = vial
	local CostWithText = LUI.UIText.new(0.5, 0.5, -708, -576, 0.5, 0.5, 157, 186)
	CostWithText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	CostWithText:setAlpha(0)
	CostWithText:setTTF("ttmussels_demibold")
	CostWithText:setLetterSpacing(1)
	CostWithText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CostWithText:linkToElementModel(self, "CostString", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			CostWithText:setText(f20_local0)
		end
	end)
	self:addElement(CostWithText)
	self.CostWithText = CostWithText
	local Cost = LUI.UIText.new(0.5, 0.5, -651, -560, 0.5, 0.5, 157, 186)
	Cost:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Cost:setAlpha(0)
	Cost:setTTF("ttmussels_demibold")
	Cost:setLetterSpacing(1)
	Cost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Cost:linkToElementModel(self, "Cost", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			Cost:setText(f21_local0)
		end
	end)
	self:addElement(Cost)
	self.Cost = Cost
	local QuitBtn = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 864, 898, 0.5, 0.5, -192, -158)
	QuitBtn:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f22_local0
	end)
	f1_local1:AddButtonCallbackFunction(QuitBtn, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.PCKoreaUtility.DeclineRefundPopup(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(QuitBtn)
	self.QuitBtn = QuitBtn
	local StartMenuSmallTierLevel = CoD.PC_Store_Refund_Korea_Product_Image.new(f1_local1, f1_arg0, 0.5, 0.5, -815.5, -466.5, 0.5, 0.5, -124, 78)
	StartMenuSmallTierLevel:linkToElementModel(self, nil, false, function(model)
		StartMenuSmallTierLevel:setModel(model, f1_arg0)
	end)
	StartMenuSmallTierLevel:linkToElementModel(self, "TierRef", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			StartMenuSmallTierLevel.Tiers:setText(Engine[@"hash_4F9F1239CFD921FE"](f26_local0))
		end
	end)
	self:addElement(StartMenuSmallTierLevel)
	self.StartMenuSmallTierLevel = StartMenuSmallTierLevel
	local LargeProductImage = LUI.UIImage.new(0.5, 0.5, -960, -324, 0.5, 0.5, -214, 230)
	LargeProductImage:linkToElementModel(self, "LargeProductImage", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			LargeProductImage:setImage(RegisterImage(f27_local0))
		end
	end)
	self:addElement(LargeProductImage)
	self.LargeProductImage = LargeProductImage
	local Linker = LUI.UIImage.new(0.5, 0.5, -330, -326, 0.5, 0.5, -193, 204)
	Linker:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker:setAlpha(0.35)
	Linker:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	self:mergeStateConditions({
		{
			stateName = "IsPriceString",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg0, "CostString")
			end,
		},
		{
			stateName = "IsPriceCoDPoints",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToHashString(f1_arg0, element, "Currency", @"cod_points")
			end,
		},
		{
			stateName = "IsPriceVials",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToHashString(f1_arg0, element, "Currency", @"nebulium_plasma")
			end,
		},
	})
	self:linkToElementModel(self, "CostString", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "CostString",
		})
	end)
	self:linkToElementModel(self, "Currency", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "Currency",
		})
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		SetGlobalModelValueFalse("PCStoreKoreaAccepts")
		CoD.PCKoreaUtility.DeclineRefundPopup(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, "ESCAPE")
		return false
	end, false)
	ButtonList.id = "ButtonList"
	emptyFocusableCheck.id = "emptyFocusableCheck"
	if CoD.isPC then
		CommonCheckbox.id = "CommonCheckbox"
	end
	QuitBtn.id = "QuitBtn"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.PC_Store_Refund_Korea.__resetProperties = function(f35_arg0)
	f35_arg0.CostWithText:completeAnimation()
	f35_arg0.codpoints:completeAnimation()
	f35_arg0.Cost:completeAnimation()
	f35_arg0.vial:completeAnimation()
	f35_arg0.CostWithText:setAlpha(0)
	f35_arg0.codpoints:setAlpha(0)
	f35_arg0.Cost:setAlpha(0)
	f35_arg0.vial:setAlpha(0)
end
CoD.PC_Store_Refund_Korea.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(0)
		end,
	},
	IsPriceString = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.CostWithText:completeAnimation()
			f37_arg0.CostWithText:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.CostWithText)
		end,
	},
	IsPriceCoDPoints = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.codpoints:completeAnimation()
			f38_arg0.codpoints:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.codpoints)
			f38_arg0.Cost:completeAnimation()
			f38_arg0.Cost:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.Cost)
		end,
	},
	IsPriceVials = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.vial:completeAnimation()
			f39_arg0.vial:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.vial)
			f39_arg0.Cost:completeAnimation()
			f39_arg0.Cost:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.Cost)
		end,
	},
}
CoD.PC_Store_Refund_Korea.__onClose = function(f40_arg0)
	f40_arg0.ButtonList:close()
	f40_arg0.ValidityPeriod:close()
	f40_arg0.emptyFocusableCheck:close()
	f40_arg0.RefundOrNotText:close()
	f40_arg0.CommonCheckbox:close()
	f40_arg0.Title:close()
	f40_arg0.Description:close()
	f40_arg0.alertStatusBar:close()
	f40_arg0.alertStatusBar2:close()
	f40_arg0.CostWithText:close()
	f40_arg0.Cost:close()
	f40_arg0.QuitBtn:close()
	f40_arg0.StartMenuSmallTierLevel:close()
	f40_arg0.LargeProductImage:close()
end
