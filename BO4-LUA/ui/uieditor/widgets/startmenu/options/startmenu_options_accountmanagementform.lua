require("x64:1deecd602935a98")
require("x64:75b68cdde53ec78")
CoD.StartMenu_Options_AccountManagementForm = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_AccountManagementForm.__defaultWidth = 1920
CoD.StartMenu_Options_AccountManagementForm.__defaultHeight = 1080
CoD.StartMenu_Options_AccountManagementForm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_AccountManagementForm)
	self.id = "StartMenu_Options_AccountManagementForm"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local AccountOptions = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	AccountOptions:setLeftRight(0.5, 0.5, -380, 380)
	AccountOptions:setTopBottom(0, 0, 489, 549)
	AccountOptions:setWidgetType(CoD.StartMenu_Options_SimpleCheckOption)
	AccountOptions:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AccountOptions:setDataSource("CODAccountManagementOptions")
	AccountOptions:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AccountOptions, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(AccountOptions)
	self.AccountOptions = AccountOptions
	local AccountButtonOptionsList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	AccountButtonOptionsList:setLeftRight(0.5, 0.5, -380, 380)
	AccountButtonOptionsList:setTopBottom(0, 0, 549, 609)
	AccountButtonOptionsList:setWidgetType(CoD.StartMenu_Options_ButtonOption)
	AccountButtonOptionsList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AccountButtonOptionsList:setDataSource("CODAccountManagementConfirmation")
	AccountButtonOptionsList:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AccountButtonOptionsList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(AccountButtonOptionsList)
	self.AccountButtonOptionsList = AccountButtonOptionsList
	local Title = LUI.UIText.new(0.5, 0.5, -362.5, 362.5, 0, 0, 210.5, 264.5)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[0xF9F1239CFD921FE](0x30BC41F2404F851))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local Body = LUI.UIText.new(0.5, 0.5, -362.5, 362.5, 0, 0, 296.5, 320.5)
	Body:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Body:setText(Engine[0xF9F1239CFD921FE](0xFDF4DE037465FD4))
	Body:setTTF("dinnext_regular")
	Body:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Body:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Body)
	self.Body = Body
	local DescriptionText = LUI.UIText.new(0.5, 0.5, 392, 849, 0, 0, 210.5, 234.5)
	DescriptionText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DescriptionText:setTTF("dinnext_regular")
	DescriptionText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DescriptionText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	DescriptionText:subscribeToGlobalModel(f1_arg1, "CODAccountManagementForm", "hintText", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DescriptionText:setText(Engine[0xF9F1239CFD921FE](f8_local0))
		end
	end)
	self:addElement(DescriptionText)
	self.DescriptionText = DescriptionText
	AccountOptions.id = "AccountOptions"
	AccountButtonOptionsList.id = "AccountButtonOptionsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_AccountManagementForm.__onClose = function(f9_arg0)
	f9_arg0.AccountOptions:close()
	f9_arg0.AccountButtonOptionsList:close()
	f9_arg0.DescriptionText:close()
end
