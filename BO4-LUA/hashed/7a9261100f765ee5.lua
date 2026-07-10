require("x64:c3028f94f53cf2e")
require("x64:d2a12cc8ff589a9")
require("x64:e0ca8a717281d46")
CoD.VehicleHUD_GroundVehicle = InheritFrom(CoD.Menu)
LUI.createMenu.VehicleHUD_GroundVehicle = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VehicleHUD_GroundVehicle", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VehicleHUD_GroundVehicle)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local genericVHUDReticleOverlay = CoD.genericVHUDReticleOverlay.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	genericVHUDReticleOverlay:linkToElementModel(self, nil, false, function(model)
		genericVHUDReticleOverlay:setModel(model, f1_arg0)
	end)
	self:addElement(genericVHUDReticleOverlay)
	self.genericVHUDReticleOverlay = genericVHUDReticleOverlay
	local AbilitiesAndAmmo = CoD.VehicleGround_AbilitiesAndAmmo.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	AbilitiesAndAmmo:linkToElementModel(self, nil, false, function(model)
		AbilitiesAndAmmo:setModel(model, f1_arg0)
	end)
	self:addElement(AbilitiesAndAmmo)
	self.AbilitiesAndAmmo = AbilitiesAndAmmo
	local CompassGroupVehicleGPS = CoD.CompassGroupVehicleGPS.new(f1_local1, f1_arg0, 0, 0, 659, 929, 0, 0, -493, -223)
	Engine[0xF0AF2C4A29D15D7](f1_arg0, 4, 270, 270)
	CompassGroupVehicleGPS:setUI3DWindow(4)
	self:addElement(CompassGroupVehicleGPS)
	self.CompassGroupVehicleGPS = CompassGroupVehicleGPS
	self.__on_menuOpened_self = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		SizeToSafeArea(self, f4_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.VehicleHUD_GroundVehicle.__onClose = function(f6_arg0)
	f6_arg0.__on_close_removeOverrides()
	f6_arg0.genericVHUDReticleOverlay:close()
	f6_arg0.AbilitiesAndAmmo:close()
	f6_arg0.CompassGroupVehicleGPS:close()
end
