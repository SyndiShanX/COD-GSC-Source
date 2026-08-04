require("ui/uieditor/widgets/footer/fe_leftcontainer_notlobby")
require("ui/uieditor/widgets/pc/pc_smallclosebutton")
require("ui/uieditor/widgets/systemoverlays/featureoverlay_button_mouseonly")
CoD.CommonCenteredPopup = InheritFrom(LUI.UIElement)
CoD.CommonCenteredPopup.__defaultWidth = 1920
CoD.CommonCenteredPopup.__defaultHeight = 1080
CoD.CommonCenteredPopup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonCenteredPopup)
	self.id = "CommonCenteredPopup"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local BlackfadeBlurB = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurB:setRGB(0, 0, 0)
	BlackfadeBlurB:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlackfadeBlurB:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlackfadeBlurB)
	self.BlackfadeBlurB = BlackfadeBlurB
	local BlackfadeBlurF = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurF:setRGB(0, 0, 0)
	BlackfadeBlurF:setAlpha(0.6)
	self:addElement(BlackfadeBlurF)
	self.BlackfadeBlurF = BlackfadeBlurF
	local CenterBackground = LUI.UIImage.new(0.5, 0.5, -348, 348, 0.5, 0.5, -500, 500)
	CenterBackground:setRGB(0.09, 0.09, 0.09)
	CenterBackground:setAlpha(0.9)
	self:addElement(CenterBackground)
	self.CenterBackground = CenterBackground
	local CenterTiledBacking = LUI.UIImage.new(0.5, 0.5, -348, 348, 0.5, 0.5, -500, 500)
	CenterTiledBacking:setAlpha(0.25)
	CenterTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	CenterTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	CenterTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	CenterTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(CenterTiledBacking)
	self.CenterTiledBacking = CenterTiledBacking
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0.5, 0.5, -312, 336, 0.5, 0.5, 439, 487)
	self:addElement(buttons)
	self.buttons = buttons
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_arg0, f1_arg1, 0.5, 0.5, -333, -147, 0.5, 0.5, 424, 484)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/back_caps"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		GoBack(self, f3_arg2)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local LayoutBottomBar = LUI.UIImage.new(0.5, 0.5, -349.5, 349.5, 0.5, 0.5, 473, 501)
	LayoutBottomBar:setZRot(180)
	LayoutBottomBar:setImage(RegisterImage("uie_ui_menu_social_popup_menu_bar"))
	self:addElement(LayoutBottomBar)
	self.LayoutBottomBar = LayoutBottomBar
	local LayoutTopBar = LUI.UIImage.new(0.5, 0.5, -349.5, 349.5, 0.5, 0.5, -500.5, -472.5)
	LayoutTopBar:setImage(RegisterImage("uie_ui_menu_social_popup_menu_bar"))
	self:addElement(LayoutTopBar)
	self.LayoutTopBar = LayoutTopBar
	local LayoutTopBarStripes = LUI.UIImage.new(0.5, 0.5, -348, 348, 0.5, 0.5, -500.5, -484.5)
	LayoutTopBarStripes:setImage(RegisterImage("uie_ui_menu_inspection_window_loading_stripe"))
	self:addElement(LayoutTopBarStripes)
	self.LayoutTopBarStripes = LayoutTopBarStripes
	local TitleBackgroundBar = LUI.UIImage.new(0.5, 0.5, -336.5, 336.5, 0.5, 0.5, -472, -444)
	TitleBackgroundBar:setRGB(0.25, 0.24, 0.22)
	TitleBackgroundBar:setAlpha(0.88)
	self:addElement(TitleBackgroundBar)
	self.TitleBackgroundBar = TitleBackgroundBar
	local TitleTiledBacking = LUI.UIImage.new(0.5, 0.5, -336.5, 336.5, 0.5, 0.5, -472, -444)
	TitleTiledBacking:setAlpha(0.5)
	TitleTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TitleTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TitleTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TitleTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TitleTiledBacking)
	self.TitleTiledBacking = TitleTiledBacking
	local TitleText = LUI.UIText.new(0.5, 0.5, -279.5, 279.5, 0.5, 0.5, -469, -445)
	TitleText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TitleText:setAlpha(0.6)
	TitleText:setText("")
	TitleText:setTTF("ttmussels_regular")
	TitleText:setLetterSpacing(4)
	TitleText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	TitleText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(TitleText)
	self.TitleText = TitleText
	local TitleLayoutElementL = LUI.UIImage.new(0.5, 0.5, -331, -315, 0.5, 0.5, -465, -449)
	TitleLayoutElementL:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TitleLayoutElementL:setZRot(90)
	TitleLayoutElementL:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	TitleLayoutElementL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TitleLayoutElementL:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(TitleLayoutElementL)
	self.TitleLayoutElementL = TitleLayoutElementL
	local TitleLayoutElementR = LUI.UIImage.new(0.5, 0.5, 313, 329, 0.5, 0.5, -464, -448)
	TitleLayoutElementR:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TitleLayoutElementR:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	TitleLayoutElementR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TitleLayoutElementR:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(TitleLayoutElementR)
	self.TitleLayoutElementR = TitleLayoutElementR
	local HeaderBackground = LUI.UIImage.new(0.5, 0.5, -336.5, 336.5, 0.5, 0.5, -423, -231)
	HeaderBackground:setRGB(0.23, 0.23, 0.23)
	HeaderBackground:setAlpha(0.25)
	self:addElement(HeaderBackground)
	self.HeaderBackground = HeaderBackground
	local HeaderTopBar = LUI.UIImage.new(0.5, 0.5, -5, -1, 0.5, 0.5, -767, -90)
	HeaderTopBar:setAlpha(0.09)
	HeaderTopBar:setZRot(90)
	HeaderTopBar:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	HeaderTopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	HeaderTopBar:setShaderVector(0, 0, 0, 0, 0)
	HeaderTopBar:setupNineSliceShader(4, 8)
	self:addElement(HeaderTopBar)
	self.HeaderTopBar = HeaderTopBar
	local HeaderBottomBar = LUI.UIImage.new(0.5, 0.5, -5, -1, 0.5, 0.5, -566, 111)
	HeaderBottomBar:setAlpha(0.09)
	HeaderBottomBar:setZRot(90)
	HeaderBottomBar:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	HeaderBottomBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	HeaderBottomBar:setShaderVector(0, 0, 0, 0, 0)
	HeaderBottomBar:setupNineSliceShader(4, 8)
	self:addElement(HeaderBottomBar)
	self.HeaderBottomBar = HeaderBottomBar
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 302, 336, 0.5, 0.5, -475, -441)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNQuit, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		GoBack(self, f6_arg2)
		return true
	end, function(f7_arg0, f7_arg1, f7_arg2)
		CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	if CoD.isPC then
		buttons.id = "buttons"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonCenteredPopup.__onClose = function(f8_arg0)
	f8_arg0.buttons:close()
	f8_arg0.featureOverlayButtonMouseOnly:close()
	f8_arg0.BTNQuit:close()
end
