require("x64:cacf05396a4a836")
require("x64:d2a12cc8ff589a9")
CoD.VehicleHUD_Prompts = InheritFrom(CoD.Menu)
LUI.createMenu.VehicleHUD_Prompts = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VehicleHUD_Prompts", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VehicleHUD_Prompts)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local vhudButtonContainer = CoD.vhud_generic_button_layout.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudButtonContainer:linkToElementModel(self, "bindings", false, function(model)
		vhudButtonContainer:setModel(model, f1_arg0)
	end)
	self.__on_menuOpened_vhudButtonContainer = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		SizeToSafeArea(vhudButtonContainer, f3_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_vhudButtonContainer)
	self:addElement(vhudButtonContainer)
	self.vhudButtonContainer = vhudButtonContainer
	local genericVHUDReticleOverlay = CoD.genericVHUDReticleOverlay.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	genericVHUDReticleOverlay:linkToElementModel(self, nil, false, function(model)
		genericVHUDReticleOverlay:setModel(model, f1_arg0)
	end)
	self:addElement(genericVHUDReticleOverlay)
	self.genericVHUDReticleOverlay = genericVHUDReticleOverlay
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_vhudButtonContainer)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.VehicleHUD_Prompts.__onClose = function(f6_arg0)
	f6_arg0.__on_close_removeOverrides()
	f6_arg0.vhudButtonContainer:close()
	f6_arg0.genericVHUDReticleOverlay:close()
end
