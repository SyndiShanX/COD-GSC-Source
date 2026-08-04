require("ui/uieditor/widgets/fileshare/fileshareoptionbutton")
require("ui/uieditor/widgets/loadinganimation/spinnerloadinganimation")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_alertstatusbar")
require("ui/uieditor/widgets/footer/fe_leftcontainer_notlobbypc")
require("ui/uieditor/widgets/pc/pc_smallclosebutton")
CoD.FullscreenPopupTemplate = InheritFrom(LUI.UIElement)
CoD.FullscreenPopupTemplate.__defaultWidth = 1920
CoD.FullscreenPopupTemplate.__defaultHeight = 1080
CoD.FullscreenPopupTemplate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FullscreenPopupTemplate)
	self.id = "FullscreenPopupTemplate"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.94)
	self:addElement(Background)
	self.Background = Background
	local blur = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -230, 244)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -229, 244)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.94)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -228, 242)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local ButtonList = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0.5, 0.5, -285, 135)
	ButtonList:setTopBottom(0.5, 0.5, -70, 182)
	ButtonList:setWidgetType(CoD.FileshareOptionButton)
	ButtonList:setVerticalCount(4)
	ButtonList:setSpacing(20)
	ButtonList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonList, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		if IsInDefaultState(self) then
			PlaySoundAlias("uin_points_purchase")
			ProcessListAction(self, f3_arg0, f3_arg2, f3_arg1)
			return true
		elseif IsSelfInState(self, "FinishedState") and MenuPropertyIsTrue(f3_arg1, "_isReservesItem") then
			PlaySoundAlias("uin_points_purchase")
			ProcessListAction(self, f3_arg0, f3_arg2, f3_arg1)
			return true
		else
		end
	end, function(f4_arg0, f4_arg1, f4_arg2)
		if IsInDefaultState(self) then
			CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsSelfInState(self, "FinishedState") and MenuPropertyIsTrue(f4_arg1, "_isReservesItem") then
			CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.BtnDone = f1_local6
	local Subtitle = LUI.UIText.new(0.5, 0.5, -285, 527, 0.5, 0.5, -128, -106)
	Subtitle:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Subtitle:setTTF("dinnext_regular")
	Subtitle:setLetterSpacing(1)
	Subtitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Subtitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(Subtitle)
	self.Subtitle = Subtitle
	local DoneSubtitle = LUI.UIText.new(0.5, 0.5, -285, 527, 0.5, 0.5, -128, -106)
	DoneSubtitle:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	DoneSubtitle:setText("")
	DoneSubtitle:setTTF("dinnext_regular")
	DoneSubtitle:setLetterSpacing(1)
	DoneSubtitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	DoneSubtitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(DoneSubtitle)
	self.DoneSubtitle = DoneSubtitle
	local ErrorSubtitle = LUI.UIText.new(0.5, 0.5, -285, 527, 0.5, 0.5, -128, -106)
	ErrorSubtitle:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ErrorSubtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	ErrorSubtitle:setTTF("dinnext_regular")
	ErrorSubtitle:setLetterSpacing(1)
	ErrorSubtitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ErrorSubtitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(ErrorSubtitle)
	self.ErrorSubtitle = ErrorSubtitle
	local WorkingTitle = LUI.UIText.new(0.5, 0.5, -286, 490, 0.5, 0.5, -188.5, -153.5)
	WorkingTitle:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	WorkingTitle:setText(LocalizeToUpperString(@"menu/new"))
	WorkingTitle:setTTF("ttmussels_demibold")
	WorkingTitle:setLetterSpacing(1)
	WorkingTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	WorkingTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(WorkingTitle)
	self.WorkingTitle = WorkingTitle
	local Title = LUI.UIText.new(0.5, 0.5, -286, 490, 0.5, 0.5, -188.5, -153.5)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(LocalizeToUpperString(@"menu/new"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(Title)
	self.Title = Title
	local DoneTitle = LUI.UIText.new(0.5, 0.5, -286, 490, 0.5, 0.5, -188.5, -153.5)
	DoneTitle:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	DoneTitle:setText(LocalizeToUpperString(@"menu/new"))
	DoneTitle:setTTF("ttmussels_demibold")
	DoneTitle:setLetterSpacing(1)
	DoneTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	DoneTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(DoneTitle)
	self.DoneTitle = DoneTitle
	local ErrorTitle = LUI.UIText.new(0.5, 0.5, -286, 490, 0.5, 0.5, -188.5, -153.5)
	ErrorTitle:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	ErrorTitle:setAlpha(0)
	ErrorTitle:setText(LocalizeToUpperString("menu/error_caps"))
	ErrorTitle:setTTF("ttmussels_demibold")
	ErrorTitle:setLetterSpacing(1)
	ErrorTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ErrorTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(ErrorTitle)
	self.ErrorTitle = ErrorTitle
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -230, -214)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 226, 242)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -229, -223)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	local alertStatusBar2 = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, 239, 245)
	alertStatusBar2:linkToElementModel(self, nil, false, function(model)
		alertStatusBar2:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar2)
	self.alertStatusBar2 = alertStatusBar2
	local f1_local18 = nil
	self.buttons = LUI.UIElement.createFake()
	local SpinnerLoadingAnimation = CoD.SpinnerLoadingAnimation.new(f1_arg0, f1_arg1, 0.5, 0.5, -285, -157, 0.5, 0.5, -64, 64)
	self:addElement(SpinnerLoadingAnimation)
	self.SpinnerLoadingAnimation = SpinnerLoadingAnimation
	local buttonPC = nil
	buttonPC = CoD.fe_LeftContainer_NOTLobbyPC.new(f1_arg0, f1_arg1, 0.5, 0.5, -285, 507, 0.5, 0.5, 156, 216)
	self:addElement(buttonPC)
	self.buttonPC = buttonPC
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 864, 898, 0.5, 0.5, -192, -158)
	BTNQuit:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCUtility.CanShowPCSmallCloseButton(menu, f1_arg1, self)
			end,
		},
	})
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNQuit, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		if CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f9_arg1, f9_arg2, self) and not CoD.PCUtility.PCSmallCloseButtonLinkedInputIsValue(f9_arg1, f9_arg2, self, Enum.LUIButton[@"lui_key_xba_pscross"]) then
			CoD.PCUtility.SendPCSmallCloseButtonLinkedInput(f9_arg1, f9_arg2, self)
			return true
		elseif not CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f9_arg1, f9_arg2, self) then
			GoBack(self, f9_arg2)
			return true
		else
		end
	end, function(f10_arg0, f10_arg1, f10_arg2)
		if CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f10_arg1, f10_arg2, self) and not CoD.PCUtility.PCSmallCloseButtonLinkedInputIsValue(f10_arg1, f10_arg2, self, Enum.LUIButton[@"lui_key_xba_pscross"]) then
			CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, nil)
			return false
		elseif not CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f10_arg1, f10_arg2, self) then
			CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(BTNQuit, f1_arg1, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		if CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f11_arg1, f11_arg2, self) then
			CoD.PCUtility.SendPCSmallCloseButtonLinkedInput(f11_arg1, f11_arg2, self)
			return true
		else
			GoBack(self, f11_arg2)
			return true
		end
	end, function(f12_arg0, f12_arg1, f12_arg2)
		CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(BTNQuit, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		if CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f13_arg1, f13_arg2, self) then
			CoD.PCUtility.SendPCSmallCloseButtonLinkedInput(f13_arg1, f13_arg2, self)
			return true
		else
			GoBack(self, f13_arg2)
			return true
		end
	end, function(f14_arg0, f14_arg1, f14_arg2)
		CoD.Menu.SetButtonLabel(f14_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f15_arg2, f15_arg3, f15_arg4)
		if IsSelfInState(self, "ErrorState") then
			MakeElementNotFocusable(self, "ButtonList", controller)
			MakeElementFocusable(self, "BtnDone", controller)
			SetLoseFocusToElement(self, "ButtonList", controller)
			SetFocusToElement(self, "BtnDone", controller)
			UpdateAllMenuButtonPrompts(f1_arg0, controller)
			UpdateElementState(self, "BTNQuit", controller)
		elseif IsSelfInState(self, "CustomState") then
			MakeElementNotFocusable(self, "BtnDone", controller)
			MakeElementNotFocusable(self, "ButtonList", controller)
			UpdateAllMenuButtonPrompts(f1_arg0, controller)
			UpdateElementState(self, "BTNQuit", controller)
		elseif IsSelfInState(self, "FinishedState") and MenuPropertyIsTrue(f1_arg0, "_isReservesItem") then
			UpdateElementState(self, "BTNQuit", controller)
			UpdateAllMenuButtonPrompts(f1_arg0, controller)
			ShowWidget(self.ButtonList)
		else
			UpdateAllMenuButtonPrompts(f1_arg0, controller)
			UpdateElementState(self, "BTNQuit", controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_arg0)
	end)
	ButtonList.id = "ButtonList"
	f1_local6.id = "BtnDone"
	if CoD.isPC then
		buttonPC.id = "buttonPC"
	end
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	self.__defaultFocus = ButtonList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local22 = self
	if IsPC() and not MenuPropertyIsTrue(f1_arg0, "__keepPopupButtonListPC") then
		ReplaceElementWithFake(self, "ButtonList")
		CoD.BaseUtility.SetDefaultFocusToElement(self, self.buttonPC)
	else
		MenuHidesFreeCursor(f1_arg0, f1_arg1)
	end
	f1_local22 = BTNQuit
	if IsPC() then
		CoD.PCUtility.RegisterPCSmallCloseButtonWidget(f1_arg0, f1_arg1, self, f1_local22)
	end
	return self
end
CoD.FullscreenPopupTemplate.__resetProperties = function(f17_arg0)
	f17_arg0.WorkingTitle:completeAnimation()
	f17_arg0.DoneTitle:completeAnimation()
	f17_arg0.BtnDone:completeAnimation()
	f17_arg0.ErrorSubtitle:completeAnimation()
	f17_arg0.SpinnerLoadingAnimation:completeAnimation()
	f17_arg0.DoneSubtitle:completeAnimation()
	f17_arg0.Title:completeAnimation()
	f17_arg0.ButtonList:completeAnimation()
	f17_arg0.Subtitle:completeAnimation()
	f17_arg0.ErrorTitle:completeAnimation()
	f17_arg0.WorkingTitle:setAlpha(1)
	f17_arg0.DoneTitle:setAlpha(1)
	f17_arg0.BtnDone:setAlpha(1)
	f17_arg0.ErrorSubtitle:setAlpha(1)
	f17_arg0.SpinnerLoadingAnimation:setAlpha(1)
	f17_arg0.DoneSubtitle:setAlpha(1)
	f17_arg0.Title:setAlpha(1)
	f17_arg0.ButtonList:setAlpha(1)
	f17_arg0.Subtitle:setAlpha(1)
	f17_arg0.ErrorTitle:setAlpha(0)
end
CoD.FullscreenPopupTemplate.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(5)
			f18_arg0.BtnDone:completeAnimation()
			f18_arg0.BtnDone:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.BtnDone)
			f18_arg0.DoneSubtitle:completeAnimation()
			f18_arg0.DoneSubtitle:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.DoneSubtitle)
			f18_arg0.ErrorSubtitle:completeAnimation()
			f18_arg0.ErrorSubtitle:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ErrorSubtitle)
			f18_arg0.WorkingTitle:completeAnimation()
			f18_arg0.WorkingTitle:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.WorkingTitle)
			f18_arg0.DoneTitle:completeAnimation()
			f18_arg0.DoneTitle:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.DoneTitle)
			f18_arg0.SpinnerLoadingAnimation:completeAnimation()
			f18_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SpinnerLoadingAnimation)
		end,
	},
	WorkingState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(7)
			f19_arg0.ButtonList:completeAnimation()
			f19_arg0.ButtonList:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ButtonList)
			f19_arg0.BtnDone:completeAnimation()
			f19_arg0.BtnDone:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BtnDone)
			f19_arg0.Subtitle:completeAnimation()
			f19_arg0.Subtitle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Subtitle)
			f19_arg0.DoneSubtitle:completeAnimation()
			f19_arg0.DoneSubtitle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DoneSubtitle)
			f19_arg0.ErrorSubtitle:completeAnimation()
			f19_arg0.ErrorSubtitle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ErrorSubtitle)
			f19_arg0.Title:completeAnimation()
			f19_arg0.Title:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Title)
			f19_arg0.DoneTitle:completeAnimation()
			f19_arg0.DoneTitle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DoneTitle)
			f19_arg0.SpinnerLoadingAnimation:completeAnimation()
			f19_arg0.SpinnerLoadingAnimation:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.SpinnerLoadingAnimation)
		end,
	},
	ErrorState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(8)
			f20_arg0.ButtonList:completeAnimation()
			f20_arg0.ButtonList:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ButtonList)
			f20_arg0.Subtitle:completeAnimation()
			f20_arg0.Subtitle:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Subtitle)
			f20_arg0.DoneSubtitle:completeAnimation()
			f20_arg0.DoneSubtitle:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DoneSubtitle)
			f20_arg0.WorkingTitle:completeAnimation()
			f20_arg0.WorkingTitle:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.WorkingTitle)
			f20_arg0.Title:completeAnimation()
			f20_arg0.Title:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Title)
			f20_arg0.DoneTitle:completeAnimation()
			f20_arg0.DoneTitle:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DoneTitle)
			f20_arg0.ErrorTitle:completeAnimation()
			f20_arg0.ErrorTitle:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ErrorTitle)
			f20_arg0.SpinnerLoadingAnimation:completeAnimation()
			f20_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SpinnerLoadingAnimation)
		end,
	},
	CustomState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(6)
			f21_arg0.ButtonList:completeAnimation()
			f21_arg0.ButtonList:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ButtonList)
			f21_arg0.BtnDone:completeAnimation()
			f21_arg0.BtnDone:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.BtnDone)
			f21_arg0.DoneSubtitle:completeAnimation()
			f21_arg0.DoneSubtitle:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.DoneSubtitle)
			f21_arg0.ErrorSubtitle:completeAnimation()
			f21_arg0.ErrorSubtitle:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ErrorSubtitle)
			f21_arg0.WorkingTitle:completeAnimation()
			f21_arg0.WorkingTitle:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.WorkingTitle)
			f21_arg0.DoneTitle:completeAnimation()
			f21_arg0.DoneTitle:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.DoneTitle)
			f21_arg0.SpinnerLoadingAnimation:completeAnimation()
			f21_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.SpinnerLoadingAnimation)
		end,
	},
	FinishedState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(9)
			f22_arg0.ButtonList:completeAnimation()
			f22_arg0.ButtonList:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ButtonList)
			f22_arg0.BtnDone:completeAnimation()
			f22_arg0.BtnDone:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BtnDone)
			f22_arg0.Subtitle:completeAnimation()
			f22_arg0.Subtitle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Subtitle)
			f22_arg0.DoneSubtitle:completeAnimation()
			f22_arg0.DoneSubtitle:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.DoneSubtitle)
			f22_arg0.ErrorSubtitle:completeAnimation()
			f22_arg0.ErrorSubtitle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ErrorSubtitle)
			f22_arg0.WorkingTitle:completeAnimation()
			f22_arg0.WorkingTitle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.WorkingTitle)
			f22_arg0.Title:completeAnimation()
			f22_arg0.Title:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Title)
			f22_arg0.DoneTitle:completeAnimation()
			f22_arg0.DoneTitle:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.DoneTitle)
			f22_arg0.ErrorTitle:completeAnimation()
			f22_arg0.ErrorTitle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ErrorTitle)
			f22_arg0.SpinnerLoadingAnimation:completeAnimation()
			f22_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.SpinnerLoadingAnimation)
		end,
	},
}
CoD.FullscreenPopupTemplate.__onClose = function(f23_arg0)
	f23_arg0.ButtonList:close()
	f23_arg0.BtnDone:close()
	f23_arg0.alertStatusBar:close()
	f23_arg0.alertStatusBar2:close()
	f23_arg0.buttons:close()
	f23_arg0.SpinnerLoadingAnimation:close()
	f23_arg0.buttonPC:close()
	f23_arg0.BTNQuit:close()
end
