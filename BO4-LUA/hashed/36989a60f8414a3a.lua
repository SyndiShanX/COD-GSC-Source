require("x64:faebebd743bba6e")
CoD.BetaUnlockPopup = InheritFrom(CoD.Menu)
LUI.createMenu.BetaUnlockPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BetaUnlockPopup", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.BetaUnlockPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BetaRewardWidget = CoD.BetaRewardWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(BetaRewardWidget)
	self.BetaRewardWidget = BetaRewardWidget
	local Description = LUI.UIText.new(0.5, 0.5, -577.5, 577.5, 0.5, 0.5, 104, 131)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A41F9908742825E"))
	Description:setTTF("ttmussels_regular")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Description)
	self.Description = Description
	local CallingCardText = LUI.UIText.new(0.5, 0.5, 0, 469, 0.5, 0.5, -194, -161)
	CallingCardText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_A4E0BB7A87A54EA"))
	CallingCardText:setTTF("ttmussels_regular")
	CallingCardText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CallingCardText)
	self.CallingCardText = CallingCardText
	local prestigeimage = LUI.UIImage.new(0.5, 0.5, 89.5, 217.5, 0.5, 0.5, -161, -33)
	prestigeimage:setImage(RegisterImage(@"ui_icon_prestige_permanenttoken"))
	self:addElement(prestigeimage)
	self.prestigeimage = prestigeimage
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.EntitlementUtility.SetCurrentEntitlementViewed(controller)
		CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/ok", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
		return true
	end, false)
	if CoD.isPC then
		BetaRewardWidget.id = "BetaRewardWidget"
	end
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
CoD.BetaUnlockPopup.__onClose = function(f4_arg0)
	f4_arg0.BetaRewardWidget:close()
end
