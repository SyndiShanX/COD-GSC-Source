require("x64:2675595fa323085")
require("x64:94bcc019394211c")
CoD.SystemOverlay_FreeCursor_Full = InheritFrom(CoD.Menu)
LUI.createMenu.SystemOverlay_FreeCursor_Full = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SystemOverlay_FreeCursor_Full", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.SystemOverlay_FreeCursor_Full)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local layout = CoD.systemOverlay_FreeCursor_Full_Layout.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	layout:setAlpha(0.99)
	layout:linkToElementModel(self, nil, false, function(model)
		layout:setModel(model, f1_arg0)
	end)
	self:addElement(layout)
	self.layout = layout
	local emptyFocusable = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.OverlayUtility.HasOverlayACrossAction(menu) then
			CoD.OverlayUtility.PerformOverlayACrossAction(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.OverlayUtility.HasOverlayACrossAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x28080D5840E11B2, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		if CoD.OverlayUtility.HasOverlayBCircleAction(menu) then
			CoD.OverlayUtility.PerformOverlayBCircleAction(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.OverlayUtility.HasOverlayBCircleAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x28080D5840E11B2, nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "A", function(element, menu, controller, model)
		if CoD.OverlayUtility.HasOverlayXSquareAction(menu) then
			CoD.OverlayUtility.PerformOverlayXSquareAction(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.OverlayUtility.HasOverlayXSquareAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x28080D5840E11B2, nil, "A")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "S", function(element, menu, controller, model)
		if CoD.OverlayUtility.HasOverlayYTriangleAction(menu) then
			CoD.OverlayUtility.PerformOverlayYTriangleAction(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.OverlayUtility.HasOverlayYTriangleAction(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x28080D5840E11B2, nil, "S")
			return true
		else
			return false
		end
	end, false)
	layout.buttons:setModel(self.buttonModel, f1_arg0)
	layout.id = "layout"
	emptyFocusable.id = "emptyFocusable"
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
CoD.SystemOverlay_FreeCursor_Full.__onClose = function(f11_arg0)
	f11_arg0.layout:close()
	f11_arg0.emptyFocusable:close()
end
