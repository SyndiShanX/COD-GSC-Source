require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_freecursor_layout")
CoD.SystemOverlay_MessageDialog = InheritFrom(CoD.Menu)
LUI.createMenu.SystemOverlay_MessageDialog = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SystemOverlay_MessageDialog", f1_arg0)
	local f1_local1 = self
	CoD.OverlayUtility.SystemOverlayPreLoad(self, f1_arg0)
	self:setClass(CoD.SystemOverlay_MessageDialog)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local layout = CoD.systemOverlay_FreeCursor_Layout.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	layout:linkToElementModel(self, nil, false, function(model)
		layout:setModel(model, f1_arg0)
	end)
	self:addElement(layout)
	self.layout = layout
	local emptyFocusable = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg0)
	f1_local5(f1_local4, f1_local6.LastInput, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		if not IsMouseOrKeyboard(f5_arg2) and CoD.OverlayUtility.HasOverlayACrossAction(f5_arg1) then
			CoD.OverlayUtility.PerformOverlayACrossAction(f5_arg1, f5_arg2)
			return true
		else
		end
	end, function(f6_arg0, f6_arg1, f6_arg2)
		if not IsMouseOrKeyboard(f6_arg2) and CoD.OverlayUtility.HasOverlayACrossAction(f6_arg1) then
			CoD.Menu.SetButtonLabel(f6_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"hash_128080D5840E11B2", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		if CoD.OverlayUtility.HasOverlayBCircleAction(f7_arg1) then
			CoD.OverlayUtility.PerformOverlayBCircleAction(f7_arg1, f7_arg2)
			return true
		else
		end
	end, function(f8_arg0, f8_arg1, f8_arg2)
		if CoD.OverlayUtility.HasOverlayBCircleAction(f8_arg1) then
			CoD.Menu.SetButtonLabel(f8_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"hash_128080D5840E11B2", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], "A", function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		if CoD.OverlayUtility.HasOverlayXSquareAction(f9_arg1) then
			CoD.OverlayUtility.PerformOverlayXSquareAction(f9_arg1, f9_arg2)
			return true
		else
		end
	end, function(f10_arg0, f10_arg1, f10_arg2)
		if CoD.OverlayUtility.HasOverlayXSquareAction(f10_arg1) then
			CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], @"hash_128080D5840E11B2", nil, "A")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xby_pstriangle"], "S", function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		if CoD.OverlayUtility.HasOverlayYTriangleAction(f11_arg1) then
			CoD.OverlayUtility.PerformOverlayYTriangleAction(f11_arg1, f11_arg2)
			return true
		else
		end
	end, function(f12_arg0, f12_arg1, f12_arg2)
		if CoD.OverlayUtility.HasOverlayYTriangleAction(f12_arg1) then
			CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], @"hash_128080D5840E11B2", nil, "S")
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
	f1_local5 = self
	CoD.OverlayUtility.SystemOverlayPostLoad(self, f1_arg0)
	DisableKeyboardNavigationByElement(emptyFocusable)
	return self
end
CoD.SystemOverlay_MessageDialog.__onClose = function(f13_arg0)
	f13_arg0.layout:close()
	f13_arg0.emptyFocusable:close()
end
