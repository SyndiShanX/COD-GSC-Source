require("x64:2dda97565904a32")
require("x64:f35548f980a65c8")
require("x64:556b09e8a9ff9a4")
require("x64:e5ea38d12085110")
require("x64:1f846296f1a1b81")
require("x64:563fb7a595cf17")
CoD.PC_CoDAccount = InheritFrom(LUI.UIElement)
CoD.PC_CoDAccount.__defaultWidth = 1920
CoD.PC_CoDAccount.__defaultHeight = 780
CoD.PC_CoDAccount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_CoDAccount)
	self.id = "PC_CoDAccount"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Backer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backer:setRGB(0.67, 0.67, 0.67)
	Backer:setAlpha(0.02)
	self:addElement(Backer)
	self.Backer = Backer
	local Border = LUI.UIImage.new(0, 1, -72, 72, 0.5, 0.5, -360, 360)
	Border:setRGB(0.8, 0.76, 0.7)
	Border:setAlpha(0.03)
	Border:setImage(RegisterImage(@"uie_highlight_border_line"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(6, 6)
	self:addElement(Border)
	self.Border = Border
	local Network = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0, 0, 703, 943, 0, 0, 222, 462)
	Network.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage(@"ui_icon_startmenu_option_network"))
	Network.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString(@"menu/network"))
	Network:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Network, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		OpenOverlay(self, "StartMenu_Options_Network", controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(Network)
	self.Network = Network
	local Credits = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0, 0, 977, 1217, 0, 0, 222, 462)
	Credits.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage(@"ui_icon_startmenu_option_credits"))
	Credits.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString(@"menu/pc_credits"))
	Credits:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Credits, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		OpenOverlay(self, "Credit_Fullscreen", controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(Credits)
	self.Credits = Credits
	local CoDaccount = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 0, 703, 1217, 0, 0, 499, 568)
	CoDaccount.LeaderActivityText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6E60E694DE8A2F04"))
	CoDaccount.MiddleText:setText(LocalizeToUpperString(@"hash_6E60E694DE8A2F04"))
	CoDaccount.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_6E60E694DE8A2F04"))
	CoDaccount:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CoDaccount, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.CoDAccountUtility.IsAccountFeatureEnabled(controller) and not IsSignedIntoUno(controller) then
			OpenOverlay(self, "StartMenu_Options_CoDAccount_CTA", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.CoDAccountUtility.IsAccountFeatureEnabled(controller) and IsSignedIntoUno(controller) then
			OpenOverlay(self, "StartMenu_Options_CoDAccount_ManageAccount", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CoDAccountUtility.IsAccountFeatureEnabled(controller) and not IsSignedIntoUno(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.CoDAccountUtility.IsAccountFeatureEnabled(controller) and IsSignedIntoUno(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CoDaccount)
	self.CoDaccount = CoDaccount
	Network.id = "Network"
	Credits.id = "Credits"
	CoDaccount.id = "CoDaccount"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	SizeToWidthOfScreen(Backer, f1_arg1)
	SizeToWidthOfScreen(Border, f1_arg1)
	return self
end
CoD.PC_CoDAccount.__onClose = function(f11_arg0)
	f11_arg0.Backer:close()
	f11_arg0.Border:close()
	f11_arg0.Network:close()
	f11_arg0.Credits:close()
	f11_arg0.CoDaccount:close()
end
