require("ui/uieditor/widgets/systemoverlays/featureoverlay_layout")
CoD.FeatureOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.FeatureOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FeatureOverlay", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.FeatureOverlay)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local layout = CoD.featureOverlay_Layout.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	layout:linkToElementModel(self, nil, false, function(model)
		layout:setModel(model, f1_arg0)
	end)
	self:addElement(layout)
	self.layout = layout
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		if HasOverlayBackAction(f5_arg1) then
			PerformOverlayBack(f5_arg1, f5_arg2)
			return true
		else
		end
	end, function(f6_arg0, f6_arg1, f6_arg2)
		if HasOverlayBackAction(f6_arg1) then
			CoD.Menu.SetButtonLabel(f6_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		return true
	end, function(f8_arg0, f8_arg1, f8_arg2)
		CoD.Menu.SetButtonLabel(f8_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], 0x0, nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xby_pstriangle"], nil, function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		return true
	end, function(f10_arg0, f10_arg1, f10_arg2)
		CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], 0x0, nil, nil)
		return false
	end, false)
	layout.vlayout.buttons.buttons:setModel(self.buttonModel, f1_arg0)
	layout.id = "layout"
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
CoD.FeatureOverlay.__onClose = function(f11_arg0)
	f11_arg0.layout:close()
end
