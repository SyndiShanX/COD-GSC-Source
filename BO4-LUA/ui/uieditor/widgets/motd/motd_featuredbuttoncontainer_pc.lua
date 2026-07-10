require("x64:c829ac7d797ba4c")
CoD.MOTD_FeaturedButtonContainer_PC = InheritFrom(LUI.UIElement)
CoD.MOTD_FeaturedButtonContainer_PC.__defaultWidth = 357
CoD.MOTD_FeaturedButtonContainer_PC.__defaultHeight = 60
CoD.MOTD_FeaturedButtonContainer_PC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 36, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.MOTD_FeaturedButtonContainer_PC)
	self.id = "MOTD_FeaturedButtonContainer_PC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local continueButtonPC = nil
	continueButtonPC = CoD.featureOverlay_Button_MouseOnly.new(f1_arg0, f1_arg1, 0.5, 0.5, 18.5, 178.5, 0.5, 0.5, -30, 30)
	continueButtonPC.featureOverlayButtonContainer.Title:setText(LocalizeToUpperString(@"menu/continue"))
	continueButtonPC:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not CoD.MOTDUtility.FeatureCard_PopupActionExist(f1_arg1, element) then
			ReplaceElementWithFake(self, "continueButtonPC")
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	continueButtonPC:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(continueButtonPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.MOTDUtility.FeatureCard_HandlePopupAction(self, controller, element, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(continueButtonPC)
	self.continueButtonPC = continueButtonPC
	local backButtonPC = nil
	backButtonPC = CoD.featureOverlay_Button_MouseOnly.new(f1_arg0, f1_arg1, 0.5, 0.5, -177.5, -17.5, 0.5, 0.5, -30, 30)
	backButtonPC.featureOverlayButtonContainer.Title:setText(LocalizeToUpperString(@"hash_778D439E1B360368"))
	backButtonPC:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(backButtonPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"mp/back", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(backButtonPC)
	self.backButtonPC = backButtonPC
	if CoD.isPC then
		continueButtonPC.id = "continueButtonPC"
	end
	if CoD.isPC then
		backButtonPC.id = "backButtonPC"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_FeaturedButtonContainer_PC.__onClose = function(f9_arg0)
	f9_arg0.continueButtonPC:close()
	f9_arg0.backButtonPC:close()
end
