require("x64:faebebd743bba6e")
CoD.BetaCallingCardPopup = InheritFrom(CoD.Menu)
LUI.createMenu.BetaCallingCardPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BetaCallingCardPopup", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.BetaCallingCardPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BetaRewardWidget = CoD.BetaRewardWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BetaRewardWidget)
	self.BetaRewardWidget = BetaRewardWidget
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
CoD.BetaCallingCardPopup.__onClose = function(f4_arg0)
	f4_arg0.BetaRewardWidget:close()
end
