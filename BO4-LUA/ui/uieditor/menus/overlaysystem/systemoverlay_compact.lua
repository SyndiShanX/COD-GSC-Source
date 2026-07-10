require("x64:e582b7357923563")
require("x64:ba72b08fda6493")
CoD.SystemOverlay_Compact = InheritFrom(CoD.Menu)
LUI.createMenu.SystemOverlay_Compact = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SystemOverlay_Compact", f1_arg0)
	local f1_local1 = self
	DisableAutoButtonCallback(f1_local1, self, f1_arg0)
	self:setClass(CoD.SystemOverlay_Compact)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local layout = CoD.systemOverlay_Compact_Layout.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	layout:setAlpha(0.99)
	layout:linkToElementModel(self, nil, false, function(model)
		layout:setModel(model, f1_arg0)
	end)
	self:addElement(layout)
	self.layout = layout
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 866, 900, 0.5, 0.5, -232, -198)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(BTNQuit, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if HasOverlayBackAction(menu) then
			PerformOverlayBack(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasOverlayBackAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if not IsPC() then
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayXSquareAction(menu) then
			CoD.OverlayUtility.PerformOverlayXSquareAction(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayXSquareAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/overlay_label", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if not IsPC() then
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayYTriangleAction(menu) then
			CoD.OverlayUtility.PerformOverlayYTriangleAction(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_0", nil, nil)
			return false
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayYTriangleAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"menu/overlay_label", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsPC() and HasOverlayContinueAction(menu) then
			PerformOverlayContinue(menu, controller)
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayACrossAction(menu) then
			CoD.OverlayUtility.PerformOverlayACrossAction(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and HasOverlayContinueAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, nil)
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayACrossAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/overlay_label", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if not IsPC() and HasOverlayBackAction(menu) then
			PerformOverlayBack(menu, controller)
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayBCircleAction(menu) then
			CoD.OverlayUtility.PerformOverlayBCircleAction(menu, controller)
			return true
		elseif IsPC() and IsMouseOrKeyboard(controller) and HasOverlayBackAction(menu) then
			PerformOverlayBack(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and HasOverlayBackAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.OverlayUtility.HasOverlayBCircleAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/overlay_label", nil, "ESCAPE")
			return true
		elseif IsPC() and IsMouseOrKeyboard(controller) and HasOverlayBackAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/overlay_label", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	layout.buttons:setModel(self.buttonModel, f1_arg0)
	layout.id = "layout"
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = layout
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local5 = self
	SetProperty(self, "disablePopupOpenCloseAnim", true)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	f1_local5 = BTNQuit
	if not HasOverlayBackAction(f1_local1) then
		ReplaceElementWithFake(self, "BTNQuit")
	end
	return self
end
CoD.SystemOverlay_Compact.__onClose = function(f16_arg0)
	f16_arg0.layout:close()
	f16_arg0.BTNQuit:close()
end
