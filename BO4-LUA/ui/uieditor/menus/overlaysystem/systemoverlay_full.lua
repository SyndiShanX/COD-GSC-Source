require("x64:37c17dc9dd913d9")
require("x64:ba72b08fda6493")
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
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f2_local1:AddButtonCallbackFunction(BTNQuit, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		PerformOverlayBack(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if HasOverlayContinueAction(menu) then
			PerformOverlayContinue(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasOverlayContinueAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if HasOverlayBackAction(menu) then
			PerformOverlayBack(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasOverlayBackAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
		return false
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, nil)
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
