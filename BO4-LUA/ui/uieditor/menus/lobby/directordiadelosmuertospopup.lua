require("x64:d7ba7c36104672")
require("x64:b64d9dfa5911bd2")
require("x64:c829ac7d797ba4c")
CoD.DirectorDiaDeLosMuertosPopup = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorDiaDeLosMuertosPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorDiaDeLosMuertosPopup", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.DirectorDiaDeLosMuertosPopup)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BlackfadeBlurF = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurF:setRGB(0, 0, 0)
	BlackfadeBlurF:setAlpha(0.6)
	self:addElement(BlackfadeBlurF)
	self.BlackfadeBlurF = BlackfadeBlurF
	local BlackfadeBlurB = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurB:setRGB(0, 0, 0)
	BlackfadeBlurB:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlackfadeBlurB:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlackfadeBlurB)
	self.BlackfadeBlurB = BlackfadeBlurB
	local CenterBackground = LUI.UIImage.new(0.5, 0.5, -641, 655, 0.5, 0.5, -378, 363)
	CenterBackground:setRGB(0.09, 0.09, 0.09)
	CenterBackground:setAlpha(0.9)
	self:addElement(CenterBackground)
	self.CenterBackground = CenterBackground
	local CenterTiledBacking = LUI.UIImage.new(0.5, 0.5, -641, 655, 0.5, 0.5, -378, 363)
	CenterTiledBacking:setAlpha(0.25)
	CenterTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	CenterTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	CenterTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	CenterTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(CenterTiledBacking)
	self.CenterTiledBacking = CenterTiledBacking
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_local1, f1_arg0, 0.5, 0.5, -588, 60, 0.5, 0.5, 300, 348)
	self:addElement(buttons)
	self.buttons = buttons
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, -609, -449, 0.5, 0.5, 285, 345)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_778D439E1B360368"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local HeaderStripe = LUI.UIImage.new(0.5, 0.5, -641, 655, 0.5, 0.5, -378, -364)
	HeaderStripe:setAlpha(0.7)
	HeaderStripe:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripe:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe:setupNineSliceShader(100, 15)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	local TitleBackgroundBar = LUI.UIImage.new(0.5, 0.5, -601.5, 222.5, 0.5, 0.5, -332, -304)
	TitleBackgroundBar:setRGB(0.25, 0.24, 0.22)
	TitleBackgroundBar:setAlpha(0.88)
	self:addElement(TitleBackgroundBar)
	self.TitleBackgroundBar = TitleBackgroundBar
	local TitleTiledBacking = LUI.UIImage.new(0.5, 0.5, -601.5, 222.5, 0.5, 0.5, -332, -304)
	TitleTiledBacking:setAlpha(0.5)
	TitleTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TitleTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TitleTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TitleTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TitleTiledBacking)
	self.TitleTiledBacking = TitleTiledBacking
	local HeaderBackground = LUI.UIImage.new(0.5, 0.5, -601, 223, 0.5, 0.5, -270.5, -170.5)
	HeaderBackground:setRGB(0.23, 0.23, 0.23)
	HeaderBackground:setAlpha(0.25)
	self:addElement(HeaderBackground)
	self.HeaderBackground = HeaderBackground
	local HeaderTopBar = LUI.UIImage.new(0.5, 0.5, -190, -186, 0.5, 0.5, -700, 140)
	HeaderTopBar:setAlpha(0.09)
	HeaderTopBar:setZRot(90)
	HeaderTopBar:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	HeaderTopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	HeaderTopBar:setShaderVector(0, 0, 0, 0, 0)
	HeaderTopBar:setupNineSliceShader(4, 8)
	self:addElement(HeaderTopBar)
	self.HeaderTopBar = HeaderTopBar
	local HeaderBottomBar = LUI.UIImage.new(0.5, 0.5, -190, -186, 0.5, 0.5, -581, 259)
	HeaderBottomBar:setAlpha(0.09)
	HeaderBottomBar:setZRot(90)
	HeaderBottomBar:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	HeaderBottomBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	HeaderBottomBar:setShaderVector(0, 0, 0, 0, 0)
	HeaderBottomBar:setupNineSliceShader(4, 8)
	self:addElement(HeaderBottomBar)
	self.HeaderBottomBar = HeaderBottomBar
	local PreviewImage = LUI.UIImage.new(0.5, 0.5, 271, 655, 0.5, 0.5, -359, 361)
	self:addElement(PreviewImage)
	self.PreviewImage = PreviewImage
	local Characters = LUI.UIList.new(f1_local1, f1_arg0, 2, 0, nil, false, false, false, false)
	Characters:mergeStateConditions({
		{
			stateName = "ViewSelectedPlayer_Searching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "UnavailablePC",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	Characters:linkToElementModel(Characters, "isBMLocked", true, function(model)
		f1_local1:updateElementState(Characters, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isBMLocked",
		})
	end)
	Characters:setLeftRight(0.5, 0.5, -611, 237)
	Characters:setTopBottom(0.5, 0.5, -121, 191)
	Characters:setWidgetType(CoD.PositionDraft_Character)
	Characters:setHorizontalCount(5)
	Characters:setVerticalCount(2)
	Characters:setBalanceGridRows(true)
	Characters:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Characters:setDataSource("PositionDraftCharactersMPPromo")
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_local1:AddButtonCallbackFunction(Characters, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		PlaySoundAlias("uin_start_char_select")
		CoD.EntitlementUtility.SelectSpecialistForEntitlement(menu, controller, element, Enum[@"emodes"][@"mode_multiplayer"], @"hash_6C94ED95E25D8246")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(Characters)
	self.Characters = Characters
	local OptionDesc = LUI.UIText.new(0.5, 0.5, -510, 139, 0.5, 0.5, -238, -213)
	OptionDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_45A4A2C20AFB2BC"))
	OptionDesc:setTTF("dinnext_regular")
	OptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	OptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, -643, 657, 0.5, 0.5, 348, 364)
	BoundaryBot:setRGB(ColorSet.FriendlyFlagBg.r, ColorSet.FriendlyFlagBg.g, ColorSet.FriendlyFlagBg.b)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setImage(RegisterImage(@"uie_ui_hud_tak5_player_layout_bracket"))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	local BoundaryBot2 = LUI.UIImage.new(0.5, 0.5, -643, 657, 0.5, 0.5, -381, -365)
	BoundaryBot2:setRGB(ColorSet.FriendlyFlagBg.r, ColorSet.FriendlyFlagBg.g, ColorSet.FriendlyFlagBg.b)
	BoundaryBot2:setAlpha(0.15)
	BoundaryBot2:setZRot(180)
	BoundaryBot2:setImage(RegisterImage(@"uie_ui_hud_tak5_player_layout_bracket"))
	BoundaryBot2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BoundaryBot2:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot2:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot2)
	self.BoundaryBot2 = BoundaryBot2
	local TitleText = LUI.UIText.new(0.5, 0.5, -465, 94, 0.5, 0.5, -328, -304)
	TitleText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TitleText:setAlpha(0.6)
	TitleText:setText(LocalizeToUpperString(@"hash_77FAADD86E118FEB"))
	TitleText:setTTF("ttmussels_regular")
	TitleText:setLetterSpacing(4)
	TitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TitleText)
	self.TitleText = TitleText
	local TitleLayoutElementR = LUI.UIImage.new(0.5, 0.5, 123, 139, 0.5, 0.5, -323, -307)
	TitleLayoutElementR:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TitleLayoutElementR:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	TitleLayoutElementR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TitleLayoutElementR:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(TitleLayoutElementR)
	self.TitleLayoutElementR = TitleLayoutElementR
	local TitleLayoutElementL = LUI.UIImage.new(0.5, 0.5, -521, -505, 0.5, 0.5, -324, -308)
	TitleLayoutElementL:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TitleLayoutElementL:setZRot(90)
	TitleLayoutElementL:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	TitleLayoutElementL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TitleLayoutElementL:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(TitleLayoutElementL)
	self.TitleLayoutElementL = TitleLayoutElementL
	PreviewImage:linkToElementModel(Characters, "assetName", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			PreviewImage:setImage(RegisterImage(CoD.EntitlementUtility.GetDOTDImageFull(f14_local0)))
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		buttons.id = "buttons"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	Characters.id = "Characters"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = Characters
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.DirectorDiaDeLosMuertosPopup.__onClose = function(f17_arg0)
	f17_arg0.PreviewImage:close()
	f17_arg0.buttons:close()
	f17_arg0.featureOverlayButtonMouseOnly:close()
	f17_arg0.Characters:close()
end
