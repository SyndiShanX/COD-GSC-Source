require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_full_layout")
require("ui/uieditor/widgets/pc/pc_smallclosebutton")
CoD.SystemOverlay_MessageDialogFull = InheritFrom(CoD.Menu)
LUI.createMenu.SystemOverlay_MessageDialogFull = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SystemOverlay_MessageDialogFull", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.SystemOverlay_MessageDialogFull)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local layout = CoD.systemOverlay_Full_Layout.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	layout:linkToElementModel(self, nil, false, function(model)
		layout:setModel(model, f1_arg0)
	end)
	self:addElement(layout)
	self.layout = layout
	local emptyFocusable = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 866, 900, 0.5, 0.5, -230, -198)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(BTNQuit, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		PerformOverlayBack(f4_arg1, f4_arg2)
		return true
	end, function(f5_arg0, f5_arg1, f5_arg2)
		CoD.Menu.SetButtonLabel(f5_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		if CoD.OverlayUtility.HasOverlayACrossAction(f6_arg1) then
			CoD.OverlayUtility.PerformOverlayACrossAction(f6_arg1, f6_arg2)
			return true
		else
		end
	end, function(f7_arg0, f7_arg1, f7_arg2)
		if CoD.OverlayUtility.HasOverlayACrossAction(f7_arg1) then
			CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"hash_128080D5840E11B2", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], "ESCAPE", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if CoD.OverlayUtility.HasOverlayBCircleAction(f8_arg1) then
			CoD.OverlayUtility.PerformOverlayBCircleAction(f8_arg1, f8_arg2)
			return true
		else
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		if CoD.OverlayUtility.HasOverlayBCircleAction(f9_arg1) then
			CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"hash_128080D5840E11B2", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], "A", function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		if CoD.OverlayUtility.HasOverlayXSquareAction(f10_arg1) then
			CoD.OverlayUtility.PerformOverlayXSquareAction(f10_arg1, f10_arg2)
			return true
		else
		end
	end, function(f11_arg0, f11_arg1, f11_arg2)
		if CoD.OverlayUtility.HasOverlayXSquareAction(f11_arg1) then
			CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], @"hash_128080D5840E11B2", nil, "A")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xby_pstriangle"], "S", function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if CoD.OverlayUtility.HasOverlayYTriangleAction(f12_arg1) then
			CoD.OverlayUtility.PerformOverlayYTriangleAction(f12_arg1, f12_arg2)
			return true
		else
		end
	end, function(f13_arg0, f13_arg1, f13_arg2)
		if CoD.OverlayUtility.HasOverlayYTriangleAction(f13_arg1) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], @"hash_128080D5840E11B2", nil, "S")
			return true
		else
			return false
		end
	end, false)
	layout.buttons:setModel(self.buttonModel, f1_arg0)
	layout.id = "layout"
	emptyFocusable.id = "emptyFocusable"
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
	return self
end
CoD.SystemOverlay_MessageDialogFull.__onClose = function(f14_arg0)
	f14_arg0.layout:close()
	f14_arg0.emptyFocusable:close()
	f14_arg0.BTNQuit:close()
end
