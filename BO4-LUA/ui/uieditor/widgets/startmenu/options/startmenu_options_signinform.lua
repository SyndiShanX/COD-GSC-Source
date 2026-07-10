require("x64:98f1288a89a9af6")
require("x64:110e986e11c842b")
require("x64:75b68cdde53ec78")
require("x64:37c2d1d7ea091ae")
require("x64:63355d9a3377f1d")
CoD.StartMenu_Options_SignInForm = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SignInForm.__defaultWidth = 1920
CoD.StartMenu_Options_SignInForm.__defaultHeight = 1080
CoD.StartMenu_Options_SignInForm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SignInForm)
	self.id = "StartMenu_Options_SignInForm"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, -190, 190)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local registrationFormStrings = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	registrationFormStrings:setLeftRight(0.5, 0.5, -380, 380)
	registrationFormStrings:setTopBottom(0, 0, 376, 508)
	registrationFormStrings:setWidgetType(CoD.StartMenu_Options_TextBoxOption)
	registrationFormStrings:setVerticalCount(2)
	registrationFormStrings:setSpacing(12)
	registrationFormStrings:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	registrationFormStrings:setDataSource("CODAccountSignInInfoBasic")
	registrationFormStrings:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(registrationFormStrings, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(registrationFormStrings)
	self.registrationFormStrings = registrationFormStrings
	local registrationFormOptions = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	registrationFormOptions:setLeftRight(0.5, 0.5, -380, 380)
	registrationFormOptions:setTopBottom(0, 0, 548, 608)
	registrationFormOptions:setWidgetType(CoD.StartMenu_Options_SimpleCheckOption)
	registrationFormOptions:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	registrationFormOptions:setDataSource("CODAccountSignInInfoOptions")
	registrationFormOptions:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(registrationFormOptions, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		PlaySoundAlias("uin_paint_image_flip_toggle")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(registrationFormOptions)
	self.registrationFormOptions = registrationFormOptions
	local registerButton = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	registerButton:setLeftRight(0.5, 0.5, -380, 380)
	registerButton:setTopBottom(0, 0, 648, 708)
	registerButton:setWidgetType(CoD.StartMenu_Options_ButtonAction)
	registerButton:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	registerButton:setDataSource("CODAccountSignInConfirmation")
	registerButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(registerButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(registerButton)
	self.registerButton = registerButton
	local DescriptionTextScrolling = CoD.verticalScrollingTextBox.new(f1_arg0, f1_arg1, 0, 0, 1375, 1758, 0, 0, 376, 708)
	DescriptionTextScrolling:setRGB(0.63, 0.62, 0.59)
	DescriptionTextScrolling.textBox.text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DescriptionTextScrolling.textBox.text:setLetterSpacing(-1)
	DescriptionTextScrolling:linkToElementModel(self, "hintText", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DescriptionTextScrolling.textBox.text:setText(Engine[0xF9F1239CFD921FE](f11_local0))
		end
	end)
	self:addElement(DescriptionTextScrolling)
	self.DescriptionTextScrolling = DescriptionTextScrolling
	registrationFormStrings.id = "registrationFormStrings"
	registrationFormOptions.id = "registrationFormOptions"
	registerButton.id = "registerButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SignInForm.__onClose = function(f12_arg0)
	f12_arg0.CommonDetailPanel:close()
	f12_arg0.registrationFormStrings:close()
	f12_arg0.registrationFormOptions:close()
	f12_arg0.registerButton:close()
	f12_arg0.DescriptionTextScrolling:close()
end
