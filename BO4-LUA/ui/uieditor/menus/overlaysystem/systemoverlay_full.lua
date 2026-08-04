require("ui/uieditor/widgets/systemoverlays/systemoverlay_full_layout")
require("ui/uieditor/widgets/pc/pc_smallclosebutton")
local PostLoadFunc = function(f1_arg0)
	f1_arg0.disablePopupOpenCloseAnim = true
	f1_arg0.disableBlur = true
end
CoD.SystemOverlay_Full = InheritFrom(CoD.Menu)
LUI.createMenu.SystemOverlay_Full = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("SystemOverlay_Full", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.SystemOverlay_Full)
	self.soundSet = "default"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	local layout = CoD.systemOverlay_Full_Layout.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	layout:linkToElementModel(self, nil, false, function(model)
		layout:setModel(model, f2_arg0)
	end)
	self:addElement(layout)
	self.layout = layout
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f2_local1, f2_arg0, 0.5, 0.5, 866, 900, 0.5, 0.5, -230, -198)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f2_local1:AddButtonCallbackFunction(BTNQuit, f2_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		PerformOverlayBack(f5_arg1, f5_arg2)
		return true
	end, function(f6_arg0, f6_arg1, f6_arg2)
		CoD.Menu.SetButtonLabel(f6_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		if HasOverlayContinueAction(f7_arg1) then
			PerformOverlayContinue(f7_arg1, f7_arg2)
			return true
		else
		end
	end, function(f8_arg0, f8_arg1, f8_arg2)
		if HasOverlayContinueAction(f8_arg1) then
			CoD.Menu.SetButtonLabel(f8_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/continue", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		if HasOverlayBackAction(f9_arg1) then
			PerformOverlayBack(f9_arg1, f9_arg2)
			return true
		else
		end
	end, function(f10_arg0, f10_arg1, f10_arg2)
		if HasOverlayBackAction(f10_arg1) then
			CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		return true
	end, function(f12_arg0, f12_arg1, f12_arg2)
		CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], 0x0, nil, nil)
		return false
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum.LUIButton[@"lui_key_xby_pstriangle"], nil, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		return true
	end, function(f14_arg0, f14_arg1, f14_arg2)
		CoD.Menu.SetButtonLabel(f14_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], 0x0, nil, nil)
		return false
	end, false)
	layout.buttons:setModel(self.buttonModel, f2_arg0)
	layout.id = "layout"
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = layout
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.SystemOverlay_Full.__onClose = function(f15_arg0)
	f15_arg0.layout:close()
	f15_arg0.BTNQuit:close()
end
