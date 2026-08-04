require("ui/uieditor/widgets/common/commondetailpanel")
require("ui/uieditor/widgets/pc/pc_codaccount_editableoption")
require("ui/uieditor/widgets/startmenu/startmenu_options_buttonaction")
require("ui/uieditor/widgets/startmenu/startmenu_options_simplecheckoption")
CoD.PC_StartMenu_Options_SignInForm = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_SignInForm.__defaultWidth = 1920
CoD.PC_StartMenu_Options_SignInForm.__defaultHeight = 1080
CoD.PC_StartMenu_Options_SignInForm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_SignInForm)
	self.id = "PC_StartMenu_Options_SignInForm"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, -190, 190)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local registrationFormOptions = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	registrationFormOptions:setLeftRight(0.5, 0.5, -380, 380)
	registrationFormOptions:setTopBottom(0, 0, 548, 608)
	registrationFormOptions:setWidgetType(CoD.StartMenu_Options_SimpleCheckOption)
	registrationFormOptions:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	registrationFormOptions:setDataSource("CODAccountSignInInfoOptions")
	registrationFormOptions:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.CoDAccountUtility.OnSignInItemFocusChange(f1_arg0, f1_arg1, element)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(registrationFormOptions, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		ProcessListAction(self, f3_arg0, f3_arg2, f3_arg1)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(registrationFormOptions)
	self.registrationFormOptions = registrationFormOptions
	local registerButton = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	registerButton:setLeftRight(0.5, 0.5, -380, 380)
	registerButton:setTopBottom(0, 0, 648, 708)
	registerButton:setWidgetType(CoD.StartMenu_Options_ButtonAction)
	registerButton:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	registerButton:setDataSource("CODAccountSignInConfirmation")
	registerButton:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(registerButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		ProcessListAction(self, f6_arg0, f6_arg2, f6_arg1)
		return true
	end, function(f7_arg0, f7_arg1, f7_arg2)
		CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(registerButton)
	self.registerButton = registerButton
	local DescriptionText = LUI.UIText.new(0.5, 0.5, 410, 810, 0, 0, 376, 397)
	DescriptionText:setRGB(0.96, 0.93, 0.84)
	DescriptionText:setAlpha(0.3)
	DescriptionText:setTTF("ttmussels_regular")
	DescriptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	DescriptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	DescriptionText:linkToElementModel(self, "hintText", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DescriptionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	self:addElement(DescriptionText)
	self.DescriptionText = DescriptionText
	local GUIDE = LUI.UIImage.new(0, 0, 1108, 1168, 0, 0, 340, 400)
	GUIDE:setAlpha(0)
	self:addElement(GUIDE)
	self.GUIDE = GUIDE
	local GUIDE2 = LUI.UIImage.new(0, 0, 0, 340, 0, 0, 340, 400)
	GUIDE2:setAlpha(0)
	self:addElement(GUIDE2)
	self.GUIDE2 = GUIDE2
	local Image = LUI.UIImage.new(0, 0, 1580, 1920, 0, 0, 328, 388)
	Image:setAlpha(0)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0, 0, 580, 620, 0, 0, 608, 648)
	Image2:setAlpha(0)
	self:addElement(Image2)
	self.Image2 = Image2
	local PCSignInEmail = CoD.PC_CoDAccount_EditableOption.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 0.37, 0.37, 0.5, 60.5)
	PCSignInEmail.ActionText:setText(LocalizeString(@"hash_61770F1CA89E2DE5"))
	PCSignInEmail:linkToElementModel(self, "currentText", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			PCSignInEmail.CurrentText.TextBox:setText(f9_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PCSignInEmail, "childFocusGained", function(element)
		CoD.CoDAccountUtility.OnSignInItemFocusChangeWithHint(f1_arg1, "MENU/CODACCOUNT_REGISTER_EMAIL_DESC")
	end)
	self:addElement(PCSignInEmail)
	self.PCSignInEmail = PCSignInEmail
	local PCSignInPassword = CoD.PC_CoDAccount_EditableOption.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 0.44, 0.44, 0, 60)
	PCSignInPassword.ActionText:setText(LocalizeString(@"hash_4A50C91C923FBBF6"))
	PCSignInPassword:linkToElementModel(self, "currentText", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			PCSignInPassword.CurrentText.TextBox:setText(f11_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PCSignInPassword, "childFocusGained", function(element)
		CoD.CoDAccountUtility.OnSignInItemFocusChangeWithHint(f1_arg1, "MENU/CODACCOUNT_REGISTER_PW_DESC")
	end)
	self:addElement(PCSignInPassword)
	self.PCSignInPassword = PCSignInPassword
	registrationFormOptions.id = "registrationFormOptions"
	registerButton.id = "registerButton"
	PCSignInEmail.id = "PCSignInEmail"
	PCSignInPassword.id = "PCSignInPassword"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	CoD.CoDAccountUtility.SetupEditBoxControlSignIn(self, PCSignInEmail, f1_arg1, f1_arg0, "emailAddress", false)
	CoD.CoDAccountUtility.SetupEditBoxControlSignIn(self, PCSignInPassword, f1_arg1, f1_arg0, "password", true)
	return self
end
CoD.PC_StartMenu_Options_SignInForm.__onClose = function(f13_arg0)
	f13_arg0.CommonDetailPanel:close()
	f13_arg0.registrationFormOptions:close()
	f13_arg0.registerButton:close()
	f13_arg0.DescriptionText:close()
	f13_arg0.PCSignInEmail:close()
	f13_arg0.PCSignInPassword:close()
end
