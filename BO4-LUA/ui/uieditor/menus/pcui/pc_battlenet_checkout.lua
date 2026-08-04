require("ui/uieditor/widgets/pc/battlenet_checkout_closebutton")
require("ui/uieditor/widgets/pc/battlenet_checkout_view")
CoD.PC_Battlenet_Checkout = InheritFrom(CoD.Menu)
LUI.createMenu.PC_Battlenet_Checkout = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_Battlenet_Checkout", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PC_Battlenet_Checkout)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BattlenetCheckoutBorderbackground = LUI.UIImage.new(0.5, 0.5, -400, 400, 0.5, 0.5, -450, 450)
	BattlenetCheckoutBorderbackground:setRGB(0, 0, 0)
	self:addElement(BattlenetCheckoutBorderbackground)
	self.BattlenetCheckoutBorderbackground = BattlenetCheckoutBorderbackground
	local BattlenetCheckoutView = CoD.Battlenet_Checkout_View.new(f1_local1, f1_arg0, 0.5, 0.5, -400, 400, 0.5, 0.5, -450, 450)
	self:addElement(BattlenetCheckoutView)
	self.BattlenetCheckoutView = BattlenetCheckoutView
	local BattlenetCheckoutCloseButton = CoD.Battlenet_Checkout_CloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 370, 390, 0, 0, 110, 130)
	BattlenetCheckoutCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(BattlenetCheckoutCloseButton, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		GoBack(self, f3_arg2)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(BattlenetCheckoutCloseButton)
	self.BattlenetCheckoutCloseButton = BattlenetCheckoutCloseButton
	self.__on_menuOpened_self = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = self
		CoD.PCUtility.BeginBattlenetCheckout(f5_arg2, f5_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.PCUtility.CancelBattlenetCheckout(f1_arg0, true)
	end)
	BattlenetCheckoutCloseButton.id = "BattlenetCheckoutCloseButton"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = BattlenetCheckoutCloseButton
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local5 = self
	CoD.PCUtility.SetupBattlenetBackgroundBorderElement(BattlenetCheckoutBorderbackground)
	CoD.PCUtility.SetupBattlenetCloseButtonWidget(BattlenetCheckoutCloseButton)
	return self
end
CoD.PC_Battlenet_Checkout.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.BattlenetCheckoutBorderbackground:close()
	f8_arg0.BattlenetCheckoutView:close()
	f8_arg0.BattlenetCheckoutCloseButton:close()
end
