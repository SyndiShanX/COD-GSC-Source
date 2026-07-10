require("x64:98f1288a89a9af6")
require("x64:aaa2f6ba4984209")
require("x64:110e986e11c842b")
require("x64:96a7f52b396ecf6")
require("x64:75b68cdde53ec78")
CoD.PC_StartMenu_Options_RegistrationForm = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_RegistrationForm.__defaultWidth = 1920
CoD.PC_StartMenu_Options_RegistrationForm.__defaultHeight = 1080
CoD.PC_StartMenu_Options_RegistrationForm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_RegistrationForm)
	self.id = "PC_StartMenu_Options_RegistrationForm"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_arg0, f1_arg1, 0.5, 0.5, -410, 410, 0.5, 0.5, -450, 450)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local registrationFormDob = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	registrationFormDob:setLeftRight(0.5, 0.5, -375, 375)
	registrationFormDob:setTopBottom(0.49, 0.49, -72, 132)
	registrationFormDob:setWidgetType(CoD.StartMenu_Options_NumOption)
	registrationFormDob:setVerticalCount(3)
	registrationFormDob:setSpacing(12)
	registrationFormDob:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	registrationFormDob:setDataSource("CODAccountRegisterInfoDob")
	self:addElement(registrationFormDob)
	self.registrationFormDob = registrationFormDob
	local registrationFormRegion = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	registrationFormRegion:setLeftRight(0.5, 0.5, -375, 375)
	registrationFormRegion:setTopBottom(0, 0, 127.5, 187.5)
	registrationFormRegion:setWidgetType(CoD.StartMenu_Options_NumOption)
	registrationFormRegion:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	registrationFormRegion:setDataSource("CODAccountRegisterInfoRegion")
	self:addElement(registrationFormRegion)
	self.registrationFormRegion = registrationFormRegion
	local registrationFormOptions = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	registrationFormOptions:setLeftRight(0.5, 0.5, -380, 380)
	registrationFormOptions:setTopBottom(0.7, 0.7, -74, 58)
	registrationFormOptions:setWidgetType(CoD.StartMenu_Options_SimpleCheckOption)
	registrationFormOptions:setVerticalCount(2)
	registrationFormOptions:setSpacing(12)
	registrationFormOptions:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	registrationFormOptions:setDataSource("CODAccountRegisterInfoOptions")
	registrationFormOptions:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(registrationFormOptions, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(registrationFormOptions)
	self.registrationFormOptions = registrationFormOptions
	local registerButton = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	registerButton:setLeftRight(0.5, 0.5, -380, 380)
	registerButton:setTopBottom(0.87, 0.87, -61, -1)
	registerButton:setWidgetType(CoD.StartMenu_Options_ButtonAction)
	registerButton:setSpacing(12)
	registerButton:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	registerButton:setDataSource("CODAccountRegisterConfirmation")
	registerButton:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(registerButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(registerButton)
	self.registerButton = registerButton
	local DateOfBirthHeader = LUI.UIText.new(0.5, 0.5, -375, 375, 0.4, 0.4, 0, 25)
	DateOfBirthHeader:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	DateOfBirthHeader:setText(Engine[0xF9F1239CFD921FE](0x3BA3C3532BBA47A))
	DateOfBirthHeader:setTTF("ttmussels_regular")
	DateOfBirthHeader:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DateOfBirthHeader:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DateOfBirthHeader)
	self.DateOfBirthHeader = DateOfBirthHeader
	local GUIDE = LUI.UIImage.new(0, 0, 1104, 1164, 0, 0, 89.5, 149.5)
	GUIDE:setAlpha(0)
	self:addElement(GUIDE)
	self.GUIDE = GUIDE
	local GUIDE2 = LUI.UIImage.new(0, 0, 0, 340, 0, 0, 0, 1080)
	GUIDE2:setAlpha(0)
	self:addElement(GUIDE2)
	self.GUIDE2 = GUIDE2
	local Image = LUI.UIImage.new(0, 0, 1593, 1920, 0, 0, 0, 1080)
	Image:setAlpha(0)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0, 0, 354, 414, 0, 0, 874.5, 934.5)
	Image2:setAlpha(0)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(0, 0, 354, 440, 0, 0, 994, 1080)
	Image3:setAlpha(0)
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(0, 0, 585, 625, 0, 0, 814, 854)
	Image4:setAlpha(0)
	self:addElement(Image4)
	self.Image4 = Image4
	local InfoText = LUI.UIText.new(0.7, 0.7, 36, 436, 0, 0, 127.5, 148.5)
	InfoText:setRGB(0.96, 0.93, 0.84)
	InfoText:setAlpha(0.3)
	InfoText:setTTF("ttmussels_regular")
	InfoText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	InfoText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	InfoText:linkToElementModel(self, "hintText", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			InfoText:setText(CoD.BaseUtility.LocalizeIfXHash(f8_local0))
		end
	end)
	self:addElement(InfoText)
	self.InfoText = InfoText
	local PCRegistrationEmail = CoD.PC_CoDAccount_EditableOption.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 0.19, 0.19, 0, 60)
	PCRegistrationEmail.ActionText:setText(LocalizeString(0x1770F1CA89E2DE5))
	PCRegistrationEmail:linkToElementModel(self, "currentText", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			PCRegistrationEmail.CurrentText.TextBox:setText(f9_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PCRegistrationEmail, "childFocusGained", function(element)
		CoD.CoDAccountUtility.OnNewAccountItemFocusChangeWithHint(f1_arg1, "MENU/CODACCOUNT_REGISTER_EMAIL_DESC")
	end)
	self:addElement(PCRegistrationEmail)
	self.PCRegistrationEmail = PCRegistrationEmail
	local PCRegistrationPassword = CoD.PC_CoDAccount_EditableOption.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 0.26, 0.26, 0, 60)
	PCRegistrationPassword.ActionText:setText(LocalizeString(0xA50C91C923FBBF6))
	PCRegistrationPassword:linkToElementModel(self, "currentText", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			PCRegistrationPassword.CurrentText.TextBox:setText(f11_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PCRegistrationPassword, "childFocusGained", function(element)
		CoD.CoDAccountUtility.OnNewAccountItemFocusChangeWithHint(f1_arg1, "MENU/CODACCOUNT_REGISTER_PW_DESC")
	end)
	self:addElement(PCRegistrationPassword)
	self.PCRegistrationPassword = PCRegistrationPassword
	local PCRegistrationConfirmationPassword = CoD.PC_CoDAccount_EditableOption.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 0.33, 0.33, 2, 62)
	PCRegistrationConfirmationPassword.ActionText:setText(LocalizeString(0xC77EF01F8EFB323))
	PCRegistrationConfirmationPassword:linkToElementModel(self, "currentText", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			PCRegistrationConfirmationPassword.CurrentText.TextBox:setText(f13_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PCRegistrationConfirmationPassword, "childFocusGained", function(element)
		CoD.CoDAccountUtility.OnNewAccountItemFocusChangeWithHint(f1_arg1, "MENU/CODACCOUNT_REGISTER_CONF_PW_DESC")
	end)
	self:addElement(PCRegistrationConfirmationPassword)
	self.PCRegistrationConfirmationPassword = PCRegistrationConfirmationPassword
	registrationFormDob.id = "registrationFormDob"
	registrationFormRegion.id = "registrationFormRegion"
	registrationFormOptions.id = "registrationFormOptions"
	registerButton.id = "registerButton"
	PCRegistrationEmail.id = "PCRegistrationEmail"
	PCRegistrationPassword.id = "PCRegistrationPassword"
	PCRegistrationConfirmationPassword.id = "PCRegistrationConfirmationPassword"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local17 = self
	CoD.CoDAccountUtility.SetupEditBoxControlRegistration(self, PCRegistrationEmail, f1_arg1, f1_arg0, "emailAddress", false)
	CoD.CoDAccountUtility.SetupEditBoxControlRegistration(self, PCRegistrationPassword, f1_arg1, f1_arg0, "password", true)
	CoD.CoDAccountUtility.SetupEditBoxControlRegistration(self, PCRegistrationConfirmationPassword, f1_arg1, f1_arg0, "confPassword", true)
	return self
end
CoD.PC_StartMenu_Options_RegistrationForm.__onClose = function(f15_arg0)
	f15_arg0.CommonDetailPanel:close()
	f15_arg0.registrationFormDob:close()
	f15_arg0.registrationFormRegion:close()
	f15_arg0.registrationFormOptions:close()
	f15_arg0.registerButton:close()
	f15_arg0.InfoText:close()
	f15_arg0.PCRegistrationEmail:close()
	f15_arg0.PCRegistrationPassword:close()
	f15_arg0.PCRegistrationConfirmationPassword:close()
end
