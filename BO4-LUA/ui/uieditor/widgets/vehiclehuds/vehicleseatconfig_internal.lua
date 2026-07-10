require("x64:aed3f55b9ef43dd")
require("x64:aba4f0586fe0e9f")
CoD.VehicleSeatConfig_Internal = InheritFrom(LUI.UIElement)
CoD.VehicleSeatConfig_Internal.__defaultWidth = 150
CoD.VehicleSeatConfig_Internal.__defaultHeight = 300
CoD.VehicleSeatConfig_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleSeatConfig_Internal)
	self.id = "VehicleSeatConfig_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BoatBg = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	BoatBg:setRGB(0.13, 0.13, 0.13)
	BoatBg:setAlpha(0)
	BoatBg:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_boat"))
	BoatBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BoatBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BoatBg)
	self.BoatBg = BoatBg
	local BoatDamage = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	BoatDamage:setAlpha(0)
	BoatDamage:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_boat_damage"))
	self:addElement(BoatDamage)
	self.BoatDamage = BoatDamage
	local Boat = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	Boat:setAlpha(0)
	Boat:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_boat"))
	Boat:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Boat:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Boat)
	self.Boat = Boat
	local BoatPatrolBG = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	BoatPatrolBG:setRGB(0.13, 0.13, 0.13)
	BoatPatrolBG:setAlpha(0)
	BoatPatrolBG:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_patrol"))
	BoatPatrolBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BoatPatrolBG:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BoatPatrolBG)
	self.BoatPatrolBG = BoatPatrolBG
	local BoatPatrol = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	BoatPatrol:setAlpha(0)
	BoatPatrol:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_patrol"))
	BoatPatrol:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BoatPatrol:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BoatPatrol)
	self.BoatPatrol = BoatPatrol
	local BuggyBG = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	BuggyBG:setRGB(0.13, 0.13, 0.13)
	BuggyBG:setAlpha(0)
	BuggyBG:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_buggy"))
	BuggyBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BuggyBG:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BuggyBG)
	self.BuggyBG = BuggyBG
	local Buggy = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	Buggy:setAlpha(0)
	Buggy:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_buggy"))
	Buggy:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Buggy:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Buggy)
	self.Buggy = Buggy
	local CivilanSUVBG = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	CivilanSUVBG:setRGB(0.13, 0.13, 0.13)
	CivilanSUVBG:setAlpha(0)
	CivilanSUVBG:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_civiliansuv"))
	CivilanSUVBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	CivilanSUVBG:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CivilanSUVBG)
	self.CivilanSUVBG = CivilanSUVBG
	local CivilianSUV = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	CivilianSUV:setAlpha(0)
	CivilianSUV:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_civiliansuv"))
	CivilianSUV:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CivilianSUV:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CivilianSUV)
	self.CivilianSUV = CivilianSUV
	local CivilanMusscleCarBG = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	CivilanMusscleCarBG:setRGB(0.13, 0.13, 0.13)
	CivilanMusscleCarBG:setAlpha(0)
	CivilanMusscleCarBG:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_civilianmusclecar"))
	CivilanMusscleCarBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	CivilanMusscleCarBG:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CivilanMusscleCarBG)
	self.CivilanMusscleCarBG = CivilanMusscleCarBG
	local CivilianMuscleCar = LUI.UIImage.new(0, 0, 47, 103, 0, 0, 84, 196)
	CivilianMuscleCar:setAlpha(0)
	CivilianMuscleCar:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_civilianmusclecar"))
	CivilianMuscleCar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CivilianMuscleCar:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CivilianMuscleCar)
	self.CivilianMuscleCar = CivilianMuscleCar
	local HelicopterBg = LUI.UIImage.new(0, 0, -3, 153, 0, 0, 44.5, 244.5)
	HelicopterBg:setRGB(0.13, 0.13, 0.13)
	HelicopterBg:setAlpha(0)
	HelicopterBg:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_bird"))
	HelicopterBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	HelicopterBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(HelicopterBg)
	self.HelicopterBg = HelicopterBg
	local HelicopterDamage = LUI.UIImage.new(0, 0, -3, 153, 0, 0, 44.5, 244.5)
	HelicopterDamage:setAlpha(0)
	HelicopterDamage:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_bird_damage"))
	self:addElement(HelicopterDamage)
	self.HelicopterDamage = HelicopterDamage
	local Helicopter = LUI.UIImage.new(0, 0, -3, 153, 0, 0, 44.5, 244.5)
	Helicopter:setAlpha(0)
	Helicopter:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_bird"))
	Helicopter:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Helicopter:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Helicopter)
	self.Helicopter = Helicopter
	local HelicopterUH1Dbg = LUI.UIImage.new(0, 0, -3, 153, 0, 0, 44.5, 244.5)
	HelicopterUH1Dbg:setRGB(0.13, 0.13, 0.13)
	HelicopterUH1Dbg:setAlpha(0)
	HelicopterUH1Dbg:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_uh1d"))
	HelicopterUH1Dbg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	HelicopterUH1Dbg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(HelicopterUH1Dbg)
	self.HelicopterUH1Dbg = HelicopterUH1Dbg
	local HelicopterUH1D = LUI.UIImage.new(0, 0, -3, 153, 0, 0, 44.5, 244.5)
	HelicopterUH1D:setAlpha(0)
	HelicopterUH1D:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_uh1d"))
	HelicopterUH1D:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	HelicopterUH1D:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(HelicopterUH1D)
	self.HelicopterUH1D = HelicopterUH1D
	local CargoTruckBg = LUI.UIImage.new(0, 0, 49, 101, 0, 0, 76, 204)
	CargoTruckBg:setRGB(0.13, 0.13, 0.13)
	CargoTruckBg:setAlpha(0)
	CargoTruckBg:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_truck"))
	CargoTruckBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	CargoTruckBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CargoTruckBg)
	self.CargoTruckBg = CargoTruckBg
	local CargoTruckDamage = LUI.UIImage.new(0, 0, 49, 101, 0, 0, 76, 204)
	CargoTruckDamage:setAlpha(0)
	CargoTruckDamage:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_truck_damage"))
	self:addElement(CargoTruckDamage)
	self.CargoTruckDamage = CargoTruckDamage
	local CargoTruck = LUI.UIImage.new(0, 0, 49, 101, 0, 0, 76, 204)
	CargoTruck:setAlpha(0)
	CargoTruck:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_truck"))
	CargoTruck:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CargoTruck:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CargoTruck)
	self.CargoTruck = CargoTruck
	local AtvBg = LUI.UIImage.new(0, 0, 51, 99, 0, 0, 99, 191)
	AtvBg:setRGB(0.13, 0.13, 0.13)
	AtvBg:setAlpha(0)
	AtvBg:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_atv"))
	AtvBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	AtvBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(AtvBg)
	self.AtvBg = AtvBg
	local AtvDamaged = LUI.UIImage.new(0, 0, 51, 99, 0, 0, 99, 191)
	AtvDamaged:setAlpha(0)
	AtvDamaged:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_atv_damage"))
	self:addElement(AtvDamaged)
	self.AtvDamaged = AtvDamaged
	local Atv = LUI.UIImage.new(0, 0, 51, 99, 0, 0, 99, 191)
	Atv:setAlpha(0)
	Atv:setImage(RegisterImage(@"uie_ui_icon_wz_hud_vehicle_atv"))
	Atv:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Atv:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Atv)
	self.Atv = Atv
	local MotorCycleBg = LUI.UIImage.new(0, 0, 37, 109, 0, 0, 108, 188)
	MotorCycleBg:setRGB(0.13, 0.13, 0.13)
	MotorCycleBg:setAlpha(0)
	MotorCycleBg:setImage(RegisterImage(@"ui_icon_wz_hud_vehicle_motorcycle"))
	MotorCycleBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	MotorCycleBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(MotorCycleBg)
	self.MotorCycleBg = MotorCycleBg
	local MotorCycle = LUI.UIImage.new(0, 0, 37, 109, 0, 0, 108, 188)
	MotorCycle:setAlpha(0)
	MotorCycle:setImage(RegisterImage(@"ui_icon_wz_hud_vehicle_motorcycle"))
	MotorCycle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	MotorCycle:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(MotorCycle)
	self.MotorCycle = MotorCycle
	local TankBg = LUI.UIImage.new(0, 0, 43, 107, 0, 0, 52, 204)
	TankBg:setRGB(0.13, 0.13, 0.13)
	TankBg:setAlpha(0)
	TankBg:setImage(RegisterImage(@"ui_icon_wz_hud_vehicle_tank"))
	TankBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TankBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TankBg)
	self.TankBg = TankBg
	local Tank = LUI.UIImage.new(0, 0, 43, 107, 0, 0, 52, 204)
	Tank:setAlpha(0)
	Tank:setImage(RegisterImage(@"ui_icon_wz_hud_vehicle_tank"))
	Tank:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Tank:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Tank)
	self.Tank = Tank
	local Driver = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 63, 87, 0, 0, 84, 108)
	Driver:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_driver"], -1)
			end,
		},
	})
	Driver:linkToElementModel(Driver, Enum[@"vehicleseatpositions"][@"veh_pos_driver"], true, function(model)
		f1_arg0:updateElementState(Driver, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_driver"],
		})
	end)
	Driver:setAlpha(0)
	Driver:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Driver:setModel(model, f1_arg1)
	end)
	Driver.OccupiedPip.__OccupiedPip_Color = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			Driver.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f5_local0))
		end
	end
	Driver:linkToElementModel(self, "seatOccupantClientNum.0", true, Driver.OccupiedPip.__OccupiedPip_Color)
	Driver.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f6_local0 = self:getModel()
		if f6_local0 then
			f6_local0 = self:getModel()
			f6_local0 = f6_local0["seatOccupantClientNum.0"]
		end
		if f6_local0 then
			Driver.OccupiedPip.__OccupiedPip_Color(f6_local0)
		end
	end
	Driver:linkToElementModel(self, "seatOccupantClientNum.0", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Driver.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f7_local0))
		end
	end)
	self:addElement(Driver)
	self.Driver = Driver
	local CoPilot = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 77, 101, 0, 0, 77, 101)
	CoPilot:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_5"], -1)
			end,
		},
	})
	CoPilot:linkToElementModel(CoPilot, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_5"], true, function(model)
		f1_arg0:updateElementState(CoPilot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_passenger_5"],
		})
	end)
	CoPilot:setAlpha(0)
	CoPilot:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		CoPilot:setModel(model, f1_arg1)
	end)
	CoPilot.OccupiedPip.__OccupiedPip_Color = function(f11_arg0)
		local f11_local0 = f11_arg0:get()
		if f11_local0 ~= nil then
			CoPilot.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f11_local0))
		end
	end
	CoPilot:linkToElementModel(self, "seatOccupantClientNum.9", true, CoPilot.OccupiedPip.__OccupiedPip_Color)
	CoPilot.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f12_local0 = self:getModel()
		if f12_local0 then
			f12_local0 = self:getModel()
			f12_local0 = f12_local0["seatOccupantClientNum.9"]
		end
		if f12_local0 then
			CoPilot.OccupiedPip.__OccupiedPip_Color(f12_local0)
		end
	end
	CoPilot:linkToElementModel(self, "seatOccupantClientNum.9", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			CoPilot.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f13_local0))
		end
	end)
	self:addElement(CoPilot)
	self.CoPilot = CoPilot
	local Passenger1 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 43, 67, 0, 0, 118, 142)
	Passenger1:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_1"], -1)
			end,
		},
	})
	Passenger1:linkToElementModel(Passenger1, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_1"], true, function(model)
		f1_arg0:updateElementState(Passenger1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_passenger_1"],
		})
	end)
	Passenger1:setAlpha(0)
	Passenger1:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Passenger1:setModel(model, f1_arg1)
	end)
	Passenger1.OccupiedPip.__OccupiedPip_Color = function(f17_arg0)
		local f17_local0 = f17_arg0:get()
		if f17_local0 ~= nil then
			Passenger1.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f17_local0))
		end
	end
	Passenger1:linkToElementModel(self, "seatOccupantClientNum.5", true, Passenger1.OccupiedPip.__OccupiedPip_Color)
	Passenger1.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f18_local0 = self:getModel()
		if f18_local0 then
			f18_local0 = self:getModel()
			f18_local0 = f18_local0["seatOccupantClientNum.5"]
		end
		if f18_local0 then
			Passenger1.OccupiedPip.__OccupiedPip_Color(f18_local0)
		end
	end
	Passenger1:linkToElementModel(self, "seatOccupantClientNum.5", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			Passenger1.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f19_local0))
		end
	end)
	self:addElement(Passenger1)
	self.Passenger1 = Passenger1
	local Passenger2 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 83, 107, 0, 0, 118, 142)
	Passenger2:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_2"], -1)
			end,
		},
	})
	Passenger2:linkToElementModel(Passenger2, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_2"], true, function(model)
		f1_arg0:updateElementState(Passenger2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_passenger_2"],
		})
	end)
	Passenger2:setAlpha(0)
	Passenger2:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Passenger2:setModel(model, f1_arg1)
	end)
	Passenger2.OccupiedPip.__OccupiedPip_Color = function(f23_arg0)
		local f23_local0 = f23_arg0:get()
		if f23_local0 ~= nil then
			Passenger2.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f23_local0))
		end
	end
	Passenger2:linkToElementModel(self, "seatOccupantClientNum.6", true, Passenger2.OccupiedPip.__OccupiedPip_Color)
	Passenger2.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f24_local0 = self:getModel()
		if f24_local0 then
			f24_local0 = self:getModel()
			f24_local0 = f24_local0["seatOccupantClientNum.6"]
		end
		if f24_local0 then
			Passenger2.OccupiedPip.__OccupiedPip_Color(f24_local0)
		end
	end
	Passenger2:linkToElementModel(self, "seatOccupantClientNum.6", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			Passenger2.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f25_local0))
		end
	end)
	self:addElement(Passenger2)
	self.Passenger2 = Passenger2
	local Passenger3 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 43, 67, 0, 0, 152, 176)
	Passenger3:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_3"], -1)
			end,
		},
	})
	Passenger3:linkToElementModel(Passenger3, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_3"], true, function(model)
		f1_arg0:updateElementState(Passenger3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_passenger_3"],
		})
	end)
	Passenger3:setAlpha(0)
	Passenger3:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Passenger3:setModel(model, f1_arg1)
	end)
	Passenger3.OccupiedPip.__OccupiedPip_Color = function(f29_arg0)
		local f29_local0 = f29_arg0:get()
		if f29_local0 ~= nil then
			Passenger3.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f29_local0))
		end
	end
	Passenger3:linkToElementModel(self, "seatOccupantClientNum.7", true, Passenger3.OccupiedPip.__OccupiedPip_Color)
	Passenger3.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f30_local0 = self:getModel()
		if f30_local0 then
			f30_local0 = self:getModel()
			f30_local0 = f30_local0["seatOccupantClientNum.7"]
		end
		if f30_local0 then
			Passenger3.OccupiedPip.__OccupiedPip_Color(f30_local0)
		end
	end
	Passenger3:linkToElementModel(self, "seatOccupantClientNum.7", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			Passenger3.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f31_local0))
		end
	end)
	self:addElement(Passenger3)
	self.Passenger3 = Passenger3
	local Passenger4 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 83, 107, 0, 0, 152, 176)
	Passenger4:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_4"], -1)
			end,
		},
	})
	Passenger4:linkToElementModel(Passenger4, Enum[@"vehicleseatpositions"][@"veh_pos_passenger_4"], true, function(model)
		f1_arg0:updateElementState(Passenger4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_passenger_4"],
		})
	end)
	Passenger4:setAlpha(0)
	Passenger4:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Passenger4:setModel(model, f1_arg1)
	end)
	Passenger4.OccupiedPip.__OccupiedPip_Color = function(f35_arg0)
		local f35_local0 = f35_arg0:get()
		if f35_local0 ~= nil then
			Passenger4.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f35_local0))
		end
	end
	Passenger4:linkToElementModel(self, "seatOccupantClientNum.8", true, Passenger4.OccupiedPip.__OccupiedPip_Color)
	Passenger4.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f36_local0 = self:getModel()
		if f36_local0 then
			f36_local0 = self:getModel()
			f36_local0 = f36_local0["seatOccupantClientNum.8"]
		end
		if f36_local0 then
			Passenger4.OccupiedPip.__OccupiedPip_Color(f36_local0)
		end
	end
	Passenger4:linkToElementModel(self, "seatOccupantClientNum.8", true, function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			Passenger4.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f37_local0))
		end
	end)
	self:addElement(Passenger4)
	self.Passenger4 = Passenger4
	local Gunner1 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 43, 67, 0, 0, 186, 210)
	Gunner1:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_1"], -1)
			end,
		},
	})
	Gunner1:linkToElementModel(Gunner1, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_1"], true, function(model)
		f1_arg0:updateElementState(Gunner1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_gunner_1"],
		})
	end)
	Gunner1:setAlpha(0)
	Gunner1:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Gunner1:setModel(model, f1_arg1)
	end)
	Gunner1.OccupiedPip.__OccupiedPip_Color = function(f41_arg0)
		local f41_local0 = f41_arg0:get()
		if f41_local0 ~= nil then
			Gunner1.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f41_local0))
		end
	end
	Gunner1:linkToElementModel(self, "seatOccupantClientNum.1", true, Gunner1.OccupiedPip.__OccupiedPip_Color)
	Gunner1.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f42_local0 = self:getModel()
		if f42_local0 then
			f42_local0 = self:getModel()
			f42_local0 = f42_local0["seatOccupantClientNum.1"]
		end
		if f42_local0 then
			Gunner1.OccupiedPip.__OccupiedPip_Color(f42_local0)
		end
	end
	Gunner1:linkToElementModel(self, "seatOccupantClientNum.1", true, function(model)
		local f43_local0 = model:get()
		if f43_local0 ~= nil then
			Gunner1.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f43_local0))
		end
	end)
	self:addElement(Gunner1)
	self.Gunner1 = Gunner1
	local Gunner2 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 83, 107, 0, 0, 186, 210)
	Gunner2:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_2"], -1)
			end,
		},
	})
	Gunner2:linkToElementModel(Gunner2, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_2"], true, function(model)
		f1_arg0:updateElementState(Gunner2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_gunner_2"],
		})
	end)
	Gunner2:setAlpha(0)
	Gunner2:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Gunner2:setModel(model, f1_arg1)
	end)
	Gunner2.OccupiedPip.__OccupiedPip_Color = function(f47_arg0)
		local f47_local0 = f47_arg0:get()
		if f47_local0 ~= nil then
			Gunner2.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f47_local0))
		end
	end
	Gunner2:linkToElementModel(self, "seatOccupantClientNum.2", true, Gunner2.OccupiedPip.__OccupiedPip_Color)
	Gunner2.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f48_local0 = self:getModel()
		if f48_local0 then
			f48_local0 = self:getModel()
			f48_local0 = f48_local0["seatOccupantClientNum.2"]
		end
		if f48_local0 then
			Gunner2.OccupiedPip.__OccupiedPip_Color(f48_local0)
		end
	end
	Gunner2:linkToElementModel(self, "seatOccupantClientNum.2", true, function(model)
		local f49_local0 = model:get()
		if f49_local0 ~= nil then
			Gunner2.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f49_local0))
		end
	end)
	self:addElement(Gunner2)
	self.Gunner2 = Gunner2
	local Gunner3 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 43, 67, 0, 0, 220, 244)
	Gunner3:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_3"], -1)
			end,
		},
	})
	Gunner3:linkToElementModel(Gunner3, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_3"], true, function(model)
		f1_arg0:updateElementState(Gunner3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_gunner_3"],
		})
	end)
	Gunner3:setAlpha(0)
	Gunner3:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Gunner3:setModel(model, f1_arg1)
	end)
	Gunner3.OccupiedPip.__OccupiedPip_Color = function(f53_arg0)
		local f53_local0 = f53_arg0:get()
		if f53_local0 ~= nil then
			Gunner3.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f53_local0))
		end
	end
	Gunner3:linkToElementModel(self, "seatOccupantClientNum.3", true, Gunner3.OccupiedPip.__OccupiedPip_Color)
	Gunner3.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f54_local0 = self:getModel()
		if f54_local0 then
			f54_local0 = self:getModel()
			f54_local0 = f54_local0["seatOccupantClientNum.3"]
		end
		if f54_local0 then
			Gunner3.OccupiedPip.__OccupiedPip_Color(f54_local0)
		end
	end
	Gunner3:linkToElementModel(self, "seatOccupantClientNum.3", true, function(model)
		local f55_local0 = model:get()
		if f55_local0 ~= nil then
			Gunner3.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f55_local0))
		end
	end)
	self:addElement(Gunner3)
	self.Gunner3 = Gunner3
	local Gunner4 = CoD.VehicleSeatConfig_SeatPip.new(f1_arg0, f1_arg1, 0, 0, 83, 107, 0, 0, 220, 244)
	Gunner4:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueEqualTo(element, f1_arg1, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_4"], -1)
			end,
		},
	})
	Gunner4:linkToElementModel(Gunner4, Enum[@"vehicleseatpositions"][@"veh_pos_gunner_4"], true, function(model)
		f1_arg0:updateElementState(Gunner4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"vehicleseatpositions"][@"veh_pos_gunner_4"],
		})
	end)
	Gunner4:setAlpha(0)
	Gunner4:linkToElementModel(self, "seatOccupantClientNum", false, function(model)
		Gunner4:setModel(model, f1_arg1)
	end)
	Gunner4.OccupiedPip.__OccupiedPip_Color = function(f59_arg0)
		local f59_local0 = f59_arg0:get()
		if f59_local0 ~= nil then
			Gunner4.OccupiedPip:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f59_local0))
		end
	end
	Gunner4:linkToElementModel(self, "seatOccupantClientNum.4", true, Gunner4.OccupiedPip.__OccupiedPip_Color)
	Gunner4.OccupiedPip.__OccupiedPip_Color_FullPath = function()
		local f60_local0 = self:getModel()
		if f60_local0 then
			f60_local0 = self:getModel()
			f60_local0 = f60_local0["seatOccupantClientNum.4"]
		end
		if f60_local0 then
			Gunner4.OccupiedPip.__OccupiedPip_Color(f60_local0)
		end
	end
	Gunner4:linkToElementModel(self, "seatOccupantClientNum.4", true, function(model)
		local f61_local0 = model:get()
		if f61_local0 ~= nil then
			Gunner4.IDNumber2:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f61_local0))
		end
	end)
	self:addElement(Gunner4)
	self.Gunner4 = Gunner4
	local WarzoneEMPVehicle = CoD.Warzone_EMP_Vehicle.new(f1_arg0, f1_arg1, 0, 0, 10, 150, 0, 0, 34, 266)
	self:addElement(WarzoneEMPVehicle)
	self.WarzoneEMPVehicle = WarzoneEMPVehicle
	Driver:linkToElementModel(self, "team", true, Driver.OccupiedPip.__OccupiedPip_Color_FullPath)
	local f1_local38 = Driver
	local f1_local39 = Driver.subscribeToModel
	local f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Driver.OccupiedPip.__OccupiedPip_Color_FullPath)
	CoPilot:linkToElementModel(self, "team", true, CoPilot.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = CoPilot
	f1_local39 = CoPilot.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], CoPilot.OccupiedPip.__OccupiedPip_Color_FullPath)
	Passenger1:linkToElementModel(self, "team", true, Passenger1.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Passenger1
	f1_local39 = Passenger1.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Passenger1.OccupiedPip.__OccupiedPip_Color_FullPath)
	Passenger2:linkToElementModel(self, "team", true, Passenger2.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Passenger2
	f1_local39 = Passenger2.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Passenger2.OccupiedPip.__OccupiedPip_Color_FullPath)
	Passenger3:linkToElementModel(self, "team", true, Passenger3.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Passenger3
	f1_local39 = Passenger3.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Passenger3.OccupiedPip.__OccupiedPip_Color_FullPath)
	Passenger4:linkToElementModel(self, "team", true, Passenger4.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Passenger4
	f1_local39 = Passenger4.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Passenger4.OccupiedPip.__OccupiedPip_Color_FullPath)
	Gunner1:linkToElementModel(self, "team", true, Gunner1.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Gunner1
	f1_local39 = Gunner1.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Gunner1.OccupiedPip.__OccupiedPip_Color_FullPath)
	Gunner2:linkToElementModel(self, "team", true, Gunner2.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Gunner2
	f1_local39 = Gunner2.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Gunner2.OccupiedPip.__OccupiedPip_Color_FullPath)
	Gunner3:linkToElementModel(self, "team", true, Gunner3.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Gunner3
	f1_local39 = Gunner3.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Gunner3.OccupiedPip.__OccupiedPip_Color_FullPath)
	Gunner4:linkToElementModel(self, "team", true, Gunner4.OccupiedPip.__OccupiedPip_Color_FullPath)
	f1_local38 = Gunner4
	f1_local39 = Gunner4.subscribeToModel
	f1_local40 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local39(f1_local38, f1_local40["profile.colorblindMode"], Gunner4.OccupiedPip.__OccupiedPip_Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "ATV",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.ATV)
			end,
		},
		{
			stateName = "CargoTruck",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.CARGO_TRUCK)
			end,
		},
		{
			stateName = "Helicopter",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.HELICOPTER)
			end,
		},
		{
			stateName = "Boat",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.BOAT)
			end,
		},
		{
			stateName = "Buggy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.BUGGY)
			end,
		},
		{
			stateName = "Patrol",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.PATROL)
			end,
		},
		{
			stateName = "UH1D",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.UH1D)
			end,
		},
		{
			stateName = "CivilianSUV",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.SUV)
			end,
		},
		{
			stateName = "CivilianMuscleCar",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.MUSCLE_CAR)
			end,
		},
		{
			stateName = "HelicopterAttack",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.ATTACK_HELICOPTER)
			end,
		},
		{
			stateName = "Motorcycle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.MOTORCYCLE)
			end,
		},
		{
			stateName = "Tank",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "seatMapState", CoD.VehicleUtility.SeatMapStates.TANK)
			end,
		},
	})
	self:linkToElementModel(self, "seatMapState", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "seatMapState",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleSeatConfig_Internal.__resetProperties = function(f75_arg0)
	f75_arg0.Passenger4:completeAnimation()
	f75_arg0.Passenger3:completeAnimation()
	f75_arg0.Passenger2:completeAnimation()
	f75_arg0.Passenger1:completeAnimation()
	f75_arg0.Driver:completeAnimation()
	f75_arg0.Gunner1:completeAnimation()
	f75_arg0.Gunner2:completeAnimation()
	f75_arg0.Gunner3:completeAnimation()
	f75_arg0.Gunner4:completeAnimation()
	f75_arg0.WarzoneEMPVehicle:completeAnimation()
	f75_arg0.Atv:completeAnimation()
	f75_arg0.AtvBg:completeAnimation()
	f75_arg0.Boat:completeAnimation()
	f75_arg0.BoatBg:completeAnimation()
	f75_arg0.Helicopter:completeAnimation()
	f75_arg0.HelicopterBg:completeAnimation()
	f75_arg0.CoPilot:completeAnimation()
	f75_arg0.CargoTruck:completeAnimation()
	f75_arg0.CargoTruckBg:completeAnimation()
	f75_arg0.Buggy:completeAnimation()
	f75_arg0.BuggyBG:completeAnimation()
	f75_arg0.BoatPatrol:completeAnimation()
	f75_arg0.BoatPatrolBG:completeAnimation()
	f75_arg0.HelicopterUH1D:completeAnimation()
	f75_arg0.HelicopterUH1Dbg:completeAnimation()
	f75_arg0.CivilianSUV:completeAnimation()
	f75_arg0.CivilanSUVBG:completeAnimation()
	f75_arg0.CivilanMusscleCarBG:completeAnimation()
	f75_arg0.CivilianMuscleCar:completeAnimation()
	f75_arg0.MotorCycle:completeAnimation()
	f75_arg0.MotorCycleBg:completeAnimation()
	f75_arg0.TankBg:completeAnimation()
	f75_arg0.Tank:completeAnimation()
	f75_arg0.Passenger4:setLeftRight(0, 0, 83, 107)
	f75_arg0.Passenger4:setTopBottom(0, 0, 152, 176)
	f75_arg0.Passenger4:setAlpha(0)
	f75_arg0.Passenger3:setLeftRight(0, 0, 43, 67)
	f75_arg0.Passenger3:setTopBottom(0, 0, 152, 176)
	f75_arg0.Passenger3:setAlpha(0)
	f75_arg0.Passenger2:setLeftRight(0, 0, 83, 107)
	f75_arg0.Passenger2:setTopBottom(0, 0, 118, 142)
	f75_arg0.Passenger2:setAlpha(0)
	f75_arg0.Passenger1:setLeftRight(0, 0, 43, 67)
	f75_arg0.Passenger1:setTopBottom(0, 0, 118, 142)
	f75_arg0.Passenger1:setAlpha(0)
	f75_arg0.Driver:setLeftRight(0, 0, 63, 87)
	f75_arg0.Driver:setTopBottom(0, 0, 84, 108)
	f75_arg0.Driver:setAlpha(0)
	f75_arg0.Gunner1:setLeftRight(0, 0, 43, 67)
	f75_arg0.Gunner1:setTopBottom(0, 0, 186, 210)
	f75_arg0.Gunner1:setAlpha(0)
	f75_arg0.Gunner2:setLeftRight(0, 0, 83, 107)
	f75_arg0.Gunner2:setTopBottom(0, 0, 186, 210)
	f75_arg0.Gunner2:setAlpha(0)
	f75_arg0.Gunner3:setAlpha(0)
	f75_arg0.Gunner4:setAlpha(0)
	f75_arg0.WarzoneEMPVehicle:setAlpha(1)
	f75_arg0.Atv:setAlpha(0)
	f75_arg0.AtvBg:setAlpha(0)
	f75_arg0.Boat:setTopBottom(0, 0, 84, 196)
	f75_arg0.Boat:setAlpha(0)
	f75_arg0.BoatBg:setTopBottom(0, 0, 84, 196)
	f75_arg0.BoatBg:setAlpha(0)
	f75_arg0.Helicopter:setAlpha(0)
	f75_arg0.HelicopterBg:setAlpha(0)
	f75_arg0.CoPilot:setLeftRight(0, 0, 77, 101)
	f75_arg0.CoPilot:setTopBottom(0, 0, 77, 101)
	f75_arg0.CoPilot:setAlpha(0)
	f75_arg0.CargoTruck:setAlpha(0)
	f75_arg0.CargoTruckBg:setAlpha(0)
	f75_arg0.Buggy:setAlpha(0)
	f75_arg0.BuggyBG:setAlpha(0)
	f75_arg0.BoatPatrol:setAlpha(0)
	f75_arg0.BoatPatrolBG:setAlpha(0)
	f75_arg0.HelicopterUH1D:setAlpha(0)
	f75_arg0.HelicopterUH1Dbg:setAlpha(0)
	f75_arg0.CivilianSUV:setAlpha(0)
	f75_arg0.CivilanSUVBG:setAlpha(0)
	f75_arg0.CivilanMusscleCarBG:setAlpha(0)
	f75_arg0.CivilianMuscleCar:setAlpha(0)
	f75_arg0.MotorCycle:setAlpha(0)
	f75_arg0.MotorCycleBg:setAlpha(0)
	f75_arg0.TankBg:setAlpha(0)
	f75_arg0.Tank:setAlpha(0)
end
CoD.VehicleSeatConfig_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(10)
			f76_arg0.Driver:completeAnimation()
			f76_arg0.Driver:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Driver)
			f76_arg0.Passenger1:completeAnimation()
			f76_arg0.Passenger1:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Passenger1)
			f76_arg0.Passenger2:completeAnimation()
			f76_arg0.Passenger2:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Passenger2)
			f76_arg0.Passenger3:completeAnimation()
			f76_arg0.Passenger3:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Passenger3)
			f76_arg0.Passenger4:completeAnimation()
			f76_arg0.Passenger4:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Passenger4)
			f76_arg0.Gunner1:completeAnimation()
			f76_arg0.Gunner1:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Gunner1)
			f76_arg0.Gunner2:completeAnimation()
			f76_arg0.Gunner2:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Gunner2)
			f76_arg0.Gunner3:completeAnimation()
			f76_arg0.Gunner3:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Gunner3)
			f76_arg0.Gunner4:completeAnimation()
			f76_arg0.Gunner4:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.Gunner4)
			f76_arg0.WarzoneEMPVehicle:completeAnimation()
			f76_arg0.WarzoneEMPVehicle:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.WarzoneEMPVehicle)
		end,
		ATV = function(f77_arg0, f77_arg1)
			f77_arg0:__resetProperties()
			f77_arg0:setupElementClipCounter(7)
			local f77_local0 = function(f78_arg0)
				f77_arg0.AtvBg:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f77_arg0.AtvBg:setAlpha(0.8)
				f77_arg0.AtvBg:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.AtvBg:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
			end
			f77_arg0.AtvBg:completeAnimation()
			f77_arg0.AtvBg:setAlpha(0)
			f77_local0(f77_arg0.AtvBg)
			local f77_local1 = function(f79_arg0)
				f77_arg0.Atv:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f77_arg0.Atv:setAlpha(0.4)
				f77_arg0.Atv:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.Atv:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
			end
			f77_arg0.Atv:completeAnimation()
			f77_arg0.Atv:setAlpha(0)
			f77_local1(f77_arg0.Atv)
			local f77_local2 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					f81_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_both"])
					f81_arg0:setAlpha(1)
					f81_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
				end
				f77_arg0.Driver:beginAnimation(300)
				f77_arg0.Driver:setTopBottom(0, 0, 132, 156)
				f77_arg0.Driver:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.Driver:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f77_arg0.Driver:completeAnimation()
			f77_arg0.Driver:setLeftRight(0, 0, 63, 87)
			f77_arg0.Driver:setTopBottom(0, 0, 84, 108)
			f77_arg0.Driver:setAlpha(0)
			f77_local2(f77_arg0.Driver)
			local f77_local3 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					f83_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_both"])
					f83_arg0:setAlpha(1)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
				end
				f77_arg0.Passenger1:beginAnimation(300)
				f77_arg0.Passenger1:setLeftRight(0, 0, 63, 87)
				f77_arg0.Passenger1:setTopBottom(0, 0, 170, 194)
				f77_arg0.Passenger1:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.Passenger1:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f77_arg0.Passenger1:completeAnimation()
			f77_arg0.Passenger1:setLeftRight(0, 0, 43, 67)
			f77_arg0.Passenger1:setTopBottom(0, 0, 118, 142)
			f77_arg0.Passenger1:setAlpha(0)
			f77_local3(f77_arg0.Passenger1)
			f77_arg0.Passenger2:completeAnimation()
			f77_arg0.Passenger2:setAlpha(0)
			f77_arg0.clipFinished(f77_arg0.Passenger2)
			f77_arg0.Passenger3:completeAnimation()
			f77_arg0.Passenger3:setAlpha(0)
			f77_arg0.clipFinished(f77_arg0.Passenger3)
			f77_arg0.Passenger4:completeAnimation()
			f77_arg0.Passenger4:setAlpha(0)
			f77_arg0.clipFinished(f77_arg0.Passenger4)
		end,
		Boat = function(f84_arg0, f84_arg1)
			f84_arg0:__resetProperties()
			f84_arg0:setupElementClipCounter(7)
			local f84_local0 = function(f85_arg0)
				f84_arg0.BoatBg:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f84_arg0.BoatBg:setAlpha(0.8)
				f84_arg0.BoatBg:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.BoatBg:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
			end
			f84_arg0.BoatBg:completeAnimation()
			f84_arg0.BoatBg:setTopBottom(0, 0, 84, 196)
			f84_arg0.BoatBg:setAlpha(0)
			f84_local0(f84_arg0.BoatBg)
			local f84_local1 = function(f86_arg0)
				f84_arg0.Boat:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f84_arg0.Boat:setAlpha(0.4)
				f84_arg0.Boat:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.Boat:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
			end
			f84_arg0.Boat:completeAnimation()
			f84_arg0.Boat:setTopBottom(0, 0, 84, 196)
			f84_arg0.Boat:setAlpha(0)
			f84_local1(f84_arg0.Boat)
			local f84_local2 = function(f87_arg0)
				local f87_local0 = function(f88_arg0)
					f88_arg0:beginAnimation(199)
					f88_arg0:setAlpha(1)
					f88_arg0:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
				end
				f84_arg0.Driver:beginAnimation(300)
				f84_arg0.Driver:setTopBottom(0, 0, 155, 179)
				f84_arg0.Driver:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.Driver:registerEventHandler("transition_complete_keyframe", f87_local0)
			end
			f84_arg0.Driver:completeAnimation()
			f84_arg0.Driver:setLeftRight(0, 0, 63, 87)
			f84_arg0.Driver:setTopBottom(0, 0, 84, 108)
			f84_arg0.Driver:setAlpha(0)
			f84_local2(f84_arg0.Driver)
			local f84_local3 = function(f89_arg0)
				local f89_local0 = function(f90_arg0)
					f90_arg0:beginAnimation(199)
					f90_arg0:setAlpha(1)
					f90_arg0:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
				end
				f84_arg0.Passenger1:beginAnimation(300)
				f84_arg0.Passenger1:setTopBottom(0, 0, 95, 119)
				f84_arg0.Passenger1:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.Passenger1:registerEventHandler("transition_complete_keyframe", f89_local0)
			end
			f84_arg0.Passenger1:completeAnimation()
			f84_arg0.Passenger1:setTopBottom(0, 0, 118, 142)
			f84_arg0.Passenger1:setAlpha(0)
			f84_local3(f84_arg0.Passenger1)
			local f84_local4 = function(f91_arg0)
				local f91_local0 = function(f92_arg0)
					f92_arg0:beginAnimation(199)
					f92_arg0:setAlpha(1)
					f92_arg0:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
				end
				f84_arg0.Passenger2:beginAnimation(300)
				f84_arg0.Passenger2:setTopBottom(0, 0, 95, 119)
				f84_arg0.Passenger2:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.Passenger2:registerEventHandler("transition_complete_keyframe", f91_local0)
			end
			f84_arg0.Passenger2:completeAnimation()
			f84_arg0.Passenger2:setTopBottom(0, 0, 118, 142)
			f84_arg0.Passenger2:setAlpha(0)
			f84_local4(f84_arg0.Passenger2)
			local f84_local5 = function(f93_arg0)
				local f93_local0 = function(f94_arg0)
					f94_arg0:beginAnimation(199)
					f94_arg0:setAlpha(1)
					f94_arg0:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
				end
				f84_arg0.Passenger3:beginAnimation(300)
				f84_arg0.Passenger3:setTopBottom(0, 0, 125, 149)
				f84_arg0.Passenger3:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.Passenger3:registerEventHandler("transition_complete_keyframe", f93_local0)
			end
			f84_arg0.Passenger3:completeAnimation()
			f84_arg0.Passenger3:setTopBottom(0, 0, 152, 176)
			f84_arg0.Passenger3:setAlpha(0)
			f84_local5(f84_arg0.Passenger3)
			local f84_local6 = function(f95_arg0)
				local f95_local0 = function(f96_arg0)
					f96_arg0:beginAnimation(199)
					f96_arg0:setAlpha(1)
					f96_arg0:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
				end
				f84_arg0.Passenger4:beginAnimation(300)
				f84_arg0.Passenger4:setTopBottom(0, 0, 125, 149)
				f84_arg0.Passenger4:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.Passenger4:registerEventHandler("transition_complete_keyframe", f95_local0)
			end
			f84_arg0.Passenger4:completeAnimation()
			f84_arg0.Passenger4:setLeftRight(0, 0, 83, 107)
			f84_arg0.Passenger4:setTopBottom(0, 0, 152, 176)
			f84_arg0.Passenger4:setAlpha(0)
			f84_local6(f84_arg0.Passenger4)
		end,
		Helicopter = function(f97_arg0, f97_arg1)
			f97_arg0:__resetProperties()
			f97_arg0:setupElementClipCounter(8)
			local f97_local0 = function(f98_arg0)
				f97_arg0.HelicopterBg:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f97_arg0.HelicopterBg:setAlpha(0.8)
				f97_arg0.HelicopterBg:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.HelicopterBg:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
			end
			f97_arg0.HelicopterBg:completeAnimation()
			f97_arg0.HelicopterBg:setAlpha(0)
			f97_local0(f97_arg0.HelicopterBg)
			local f97_local1 = function(f99_arg0)
				f97_arg0.Helicopter:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f97_arg0.Helicopter:setAlpha(0.4)
				f97_arg0.Helicopter:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.Helicopter:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
			end
			f97_arg0.Helicopter:completeAnimation()
			f97_arg0.Helicopter:setAlpha(0)
			f97_local1(f97_arg0.Helicopter)
			local f97_local2 = function(f100_arg0)
				local f100_local0 = function(f101_arg0)
					f101_arg0:beginAnimation(199)
					f101_arg0:setAlpha(1)
					f101_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
				end
				f97_arg0.Driver:beginAnimation(300)
				f97_arg0.Driver:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.Driver:registerEventHandler("transition_complete_keyframe", f100_local0)
			end
			f97_arg0.Driver:completeAnimation()
			f97_arg0.Driver:setLeftRight(0, 0, 49, 73)
			f97_arg0.Driver:setTopBottom(0, 0, 77, 101)
			f97_arg0.Driver:setAlpha(0)
			f97_local2(f97_arg0.Driver)
			local f97_local3 = function(f102_arg0)
				local f102_local0 = function(f103_arg0)
					f103_arg0:beginAnimation(199)
					f103_arg0:setAlpha(1)
					f103_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
				end
				f97_arg0.CoPilot:beginAnimation(300)
				f97_arg0.CoPilot:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.CoPilot:registerEventHandler("transition_complete_keyframe", f102_local0)
			end
			f97_arg0.CoPilot:completeAnimation()
			f97_arg0.CoPilot:setLeftRight(0, 0, 77, 101)
			f97_arg0.CoPilot:setTopBottom(0, 0, 77, 101)
			f97_arg0.CoPilot:setAlpha(0)
			f97_local3(f97_arg0.CoPilot)
			local f97_local4 = function(f104_arg0)
				local f104_local0 = function(f105_arg0)
					f105_arg0:beginAnimation(199)
					f105_arg0:setAlpha(1)
					f105_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
				end
				f97_arg0.Passenger1:beginAnimation(300)
				f97_arg0.Passenger1:setTopBottom(0, 0, 109, 133)
				f97_arg0.Passenger1:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.Passenger1:registerEventHandler("transition_complete_keyframe", f104_local0)
			end
			f97_arg0.Passenger1:completeAnimation()
			f97_arg0.Passenger1:setTopBottom(0, 0, 118, 142)
			f97_arg0.Passenger1:setAlpha(0)
			f97_local4(f97_arg0.Passenger1)
			local f97_local5 = function(f106_arg0)
				local f106_local0 = function(f107_arg0)
					f107_arg0:beginAnimation(199)
					f107_arg0:setAlpha(1)
					f107_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
				end
				f97_arg0.Passenger2:beginAnimation(300)
				f97_arg0.Passenger2:setTopBottom(0, 0, 109, 133)
				f97_arg0.Passenger2:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.Passenger2:registerEventHandler("transition_complete_keyframe", f106_local0)
			end
			f97_arg0.Passenger2:completeAnimation()
			f97_arg0.Passenger2:setTopBottom(0, 0, 118, 142)
			f97_arg0.Passenger2:setAlpha(0)
			f97_local5(f97_arg0.Passenger2)
			local f97_local6 = function(f108_arg0)
				local f108_local0 = function(f109_arg0)
					f109_arg0:beginAnimation(199)
					f109_arg0:setAlpha(1)
					f109_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
				end
				f97_arg0.Passenger3:beginAnimation(300)
				f97_arg0.Passenger3:setTopBottom(0, 0, 142, 166)
				f97_arg0.Passenger3:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.Passenger3:registerEventHandler("transition_complete_keyframe", f108_local0)
			end
			f97_arg0.Passenger3:completeAnimation()
			f97_arg0.Passenger3:setTopBottom(0, 0, 152, 176)
			f97_arg0.Passenger3:setAlpha(0)
			f97_local6(f97_arg0.Passenger3)
			local f97_local7 = function(f110_arg0)
				local f110_local0 = function(f111_arg0)
					f111_arg0:beginAnimation(199)
					f111_arg0:setAlpha(1)
					f111_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
				end
				f97_arg0.Passenger4:beginAnimation(300)
				f97_arg0.Passenger4:setTopBottom(0, 0, 142, 166)
				f97_arg0.Passenger4:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.Passenger4:registerEventHandler("transition_complete_keyframe", f110_local0)
			end
			f97_arg0.Passenger4:completeAnimation()
			f97_arg0.Passenger4:setTopBottom(0, 0, 152, 176)
			f97_arg0.Passenger4:setAlpha(0)
			f97_local7(f97_arg0.Passenger4)
		end,
		CargoTruck = function(f112_arg0, f112_arg1)
			f112_arg0:__resetProperties()
			f112_arg0:setupElementClipCounter(7)
			local f112_local0 = function(f113_arg0)
				f112_arg0.CargoTruckBg:beginAnimation(300)
				f112_arg0.CargoTruckBg:setAlpha(0.8)
				f112_arg0.CargoTruckBg:registerEventHandler("interrupted_keyframe", f112_arg0.clipInterrupted)
				f112_arg0.CargoTruckBg:registerEventHandler("transition_complete_keyframe", f112_arg0.clipFinished)
			end
			f112_arg0.CargoTruckBg:completeAnimation()
			f112_arg0.CargoTruckBg:setAlpha(0)
			f112_local0(f112_arg0.CargoTruckBg)
			local f112_local1 = function(f114_arg0)
				f112_arg0.CargoTruck:beginAnimation(300)
				f112_arg0.CargoTruck:setAlpha(0.4)
				f112_arg0.CargoTruck:registerEventHandler("interrupted_keyframe", f112_arg0.clipInterrupted)
				f112_arg0.CargoTruck:registerEventHandler("transition_complete_keyframe", f112_arg0.clipFinished)
			end
			f112_arg0.CargoTruck:completeAnimation()
			f112_arg0.CargoTruck:setAlpha(0)
			f112_local1(f112_arg0.CargoTruck)
			local f112_local2 = function(f115_arg0)
				local f115_local0 = function(f116_arg0)
					f116_arg0:beginAnimation(199)
					f116_arg0:setAlpha(1)
					f116_arg0:registerEventHandler("transition_complete_keyframe", f112_arg0.clipFinished)
				end
				f112_arg0.Driver:beginAnimation(300)
				f112_arg0.Driver:registerEventHandler("interrupted_keyframe", f112_arg0.clipInterrupted)
				f112_arg0.Driver:registerEventHandler("transition_complete_keyframe", f115_local0)
			end
			f112_arg0.Driver:completeAnimation()
			f112_arg0.Driver:setLeftRight(0, 0, 47, 71)
			f112_arg0.Driver:setTopBottom(0, 0, 103, 127)
			f112_arg0.Driver:setAlpha(0)
			f112_local2(f112_arg0.Driver)
			local f112_local3 = function(f117_arg0)
				local f117_local0 = function(f118_arg0)
					f118_arg0:beginAnimation(199)
					f118_arg0:setAlpha(1)
					f118_arg0:registerEventHandler("transition_complete_keyframe", f112_arg0.clipFinished)
				end
				f112_arg0.Passenger1:beginAnimation(300)
				f112_arg0.Passenger1:registerEventHandler("interrupted_keyframe", f112_arg0.clipInterrupted)
				f112_arg0.Passenger1:registerEventHandler("transition_complete_keyframe", f117_local0)
			end
			f112_arg0.Passenger1:completeAnimation()
			f112_arg0.Passenger1:setLeftRight(0, 0, 79, 103)
			f112_arg0.Passenger1:setTopBottom(0, 0, 103, 127)
			f112_arg0.Passenger1:setAlpha(0)
			f112_local3(f112_arg0.Passenger1)
			f112_arg0.Passenger2:completeAnimation()
			f112_arg0.Passenger2:setLeftRight(0, 0, 79, 103)
			f112_arg0.Passenger2:setTopBottom(0, 0, 103, 127)
			f112_arg0.Passenger2:setAlpha(0)
			f112_arg0.clipFinished(f112_arg0.Passenger2)
			f112_arg0.Passenger3:completeAnimation()
			f112_arg0.Passenger3:setTopBottom(0, 0, 152, 176)
			f112_arg0.Passenger3:setAlpha(0)
			f112_arg0.clipFinished(f112_arg0.Passenger3)
			f112_arg0.Passenger4:completeAnimation()
			f112_arg0.Passenger4:setTopBottom(0, 0, 152, 176)
			f112_arg0.Passenger4:setAlpha(0)
			f112_arg0.clipFinished(f112_arg0.Passenger4)
		end,
	},
	ATV = {
		DefaultClip = function(f119_arg0, f119_arg1)
			f119_arg0:__resetProperties()
			f119_arg0:setupElementClipCounter(11)
			f119_arg0.AtvBg:completeAnimation()
			f119_arg0.AtvBg:setAlpha(0.8)
			f119_arg0.clipFinished(f119_arg0.AtvBg)
			local f119_local0 = function(f120_arg0)
				local f120_local0 = function(f121_arg0)
					local f121_local0 = function(f122_arg0)
						f122_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
						f122_arg0:setAlpha(0.4)
						f122_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
					end
					f121_arg0:beginAnimation(200)
					f121_arg0:registerEventHandler("transition_complete_keyframe", f121_local0)
				end
				f119_arg0.Atv:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f119_arg0.Atv:setAlpha(0.1)
				f119_arg0.Atv:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.Atv:registerEventHandler("transition_complete_keyframe", f120_local0)
			end
			f119_arg0.Atv:completeAnimation()
			f119_arg0.Atv:setAlpha(0.4)
			f119_local0(f119_arg0.Atv)
			f119_arg0.Driver:completeAnimation()
			f119_arg0.Driver:setLeftRight(0, 0, 63, 87)
			f119_arg0.Driver:setTopBottom(0, 0, 132, 156)
			f119_arg0.Driver:setAlpha(1)
			f119_arg0.clipFinished(f119_arg0.Driver)
			f119_arg0.Passenger1:completeAnimation()
			f119_arg0.Passenger1:setLeftRight(0, 0, 63, 87)
			f119_arg0.Passenger1:setTopBottom(0, 0, 170, 194)
			f119_arg0.Passenger1:setAlpha(1)
			f119_arg0.clipFinished(f119_arg0.Passenger1)
			f119_arg0.Passenger2:completeAnimation()
			f119_arg0.Passenger2:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Passenger2)
			f119_arg0.Passenger3:completeAnimation()
			f119_arg0.Passenger3:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Passenger3)
			f119_arg0.Passenger4:completeAnimation()
			f119_arg0.Passenger4:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Passenger4)
			f119_arg0.Gunner1:completeAnimation()
			f119_arg0.Gunner1:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Gunner1)
			f119_arg0.Gunner2:completeAnimation()
			f119_arg0.Gunner2:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Gunner2)
			f119_arg0.Gunner3:completeAnimation()
			f119_arg0.Gunner3:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Gunner3)
			f119_arg0.Gunner4:completeAnimation()
			f119_arg0.Gunner4:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Gunner4)
			f119_arg0.nextClip = "DefaultClip"
		end,
	},
	CargoTruck = {
		DefaultClip = function(f123_arg0, f123_arg1)
			f123_arg0:__resetProperties()
			f123_arg0:setupElementClipCounter(11)
			f123_arg0.CargoTruckBg:completeAnimation()
			f123_arg0.CargoTruckBg:setAlpha(0.8)
			f123_arg0.clipFinished(f123_arg0.CargoTruckBg)
			local f123_local0 = function(f124_arg0)
				local f124_local0 = function(f125_arg0)
					local f125_local0 = function(f126_arg0)
						f126_arg0:beginAnimation(1020, Enum[@"luitween"][@"luitween_ease_both"])
						f126_arg0:setAlpha(0.4)
						f126_arg0:registerEventHandler("transition_complete_keyframe", f123_arg0.clipFinished)
					end
					f125_arg0:beginAnimation(190)
					f125_arg0:registerEventHandler("transition_complete_keyframe", f125_local0)
				end
				f123_arg0.CargoTruck:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f123_arg0.CargoTruck:setAlpha(0.1)
				f123_arg0.CargoTruck:registerEventHandler("interrupted_keyframe", f123_arg0.clipInterrupted)
				f123_arg0.CargoTruck:registerEventHandler("transition_complete_keyframe", f124_local0)
			end
			f123_arg0.CargoTruck:completeAnimation()
			f123_arg0.CargoTruck:setAlpha(0.4)
			f123_local0(f123_arg0.CargoTruck)
			f123_arg0.Driver:completeAnimation()
			f123_arg0.Driver:setLeftRight(0, 0, 47, 71)
			f123_arg0.Driver:setTopBottom(0, 0, 103, 127)
			f123_arg0.Driver:setAlpha(1)
			f123_arg0.clipFinished(f123_arg0.Driver)
			f123_arg0.Passenger1:completeAnimation()
			f123_arg0.Passenger1:setLeftRight(0, 0, 79, 103)
			f123_arg0.Passenger1:setTopBottom(0, 0, 103, 127)
			f123_arg0.Passenger1:setAlpha(1)
			f123_arg0.clipFinished(f123_arg0.Passenger1)
			f123_arg0.Passenger2:completeAnimation()
			f123_arg0.Passenger2:setTopBottom(0, 0, 138, 162)
			f123_arg0.Passenger2:setAlpha(0)
			f123_arg0.clipFinished(f123_arg0.Passenger2)
			f123_arg0.Passenger3:completeAnimation()
			f123_arg0.Passenger3:setTopBottom(0, 0, 173, 197)
			f123_arg0.Passenger3:setAlpha(0)
			f123_arg0.clipFinished(f123_arg0.Passenger3)
			f123_arg0.Passenger4:completeAnimation()
			f123_arg0.Passenger4:setTopBottom(0, 0, 173, 197)
			f123_arg0.Passenger4:setAlpha(0)
			f123_arg0.clipFinished(f123_arg0.Passenger4)
			f123_arg0.Gunner1:completeAnimation()
			f123_arg0.Gunner1:setAlpha(0)
			f123_arg0.clipFinished(f123_arg0.Gunner1)
			f123_arg0.Gunner2:completeAnimation()
			f123_arg0.Gunner2:setAlpha(0)
			f123_arg0.clipFinished(f123_arg0.Gunner2)
			f123_arg0.Gunner3:completeAnimation()
			f123_arg0.Gunner3:setAlpha(0)
			f123_arg0.clipFinished(f123_arg0.Gunner3)
			f123_arg0.Gunner4:completeAnimation()
			f123_arg0.Gunner4:setAlpha(0)
			f123_arg0.clipFinished(f123_arg0.Gunner4)
			f123_arg0.nextClip = "DefaultClip"
		end,
	},
	Helicopter = {
		DefaultClip = function(f127_arg0, f127_arg1)
			f127_arg0:__resetProperties()
			f127_arg0:setupElementClipCounter(12)
			f127_arg0.HelicopterBg:completeAnimation()
			f127_arg0.HelicopterBg:setAlpha(0.8)
			f127_arg0.clipFinished(f127_arg0.HelicopterBg)
			local f127_local0 = function(f128_arg0)
				local f128_local0 = function(f129_arg0)
					local f129_local0 = function(f130_arg0)
						f130_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
						f130_arg0:setAlpha(0.4)
						f130_arg0:registerEventHandler("transition_complete_keyframe", f127_arg0.clipFinished)
					end
					f129_arg0:beginAnimation(200)
					f129_arg0:registerEventHandler("transition_complete_keyframe", f129_local0)
				end
				f127_arg0.Helicopter:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f127_arg0.Helicopter:setAlpha(0.1)
				f127_arg0.Helicopter:registerEventHandler("interrupted_keyframe", f127_arg0.clipInterrupted)
				f127_arg0.Helicopter:registerEventHandler("transition_complete_keyframe", f128_local0)
			end
			f127_arg0.Helicopter:completeAnimation()
			f127_arg0.Helicopter:setAlpha(0.4)
			f127_local0(f127_arg0.Helicopter)
			f127_arg0.Driver:completeAnimation()
			f127_arg0.Driver:setLeftRight(0, 0, 49, 73)
			f127_arg0.Driver:setTopBottom(0, 0, 77, 101)
			f127_arg0.Driver:setAlpha(1)
			f127_arg0.clipFinished(f127_arg0.Driver)
			f127_arg0.CoPilot:completeAnimation()
			f127_arg0.CoPilot:setLeftRight(0, 0, 77, 101)
			f127_arg0.CoPilot:setTopBottom(0, 0, 77, 101)
			f127_arg0.CoPilot:setAlpha(1)
			f127_arg0.clipFinished(f127_arg0.CoPilot)
			f127_arg0.Passenger1:completeAnimation()
			f127_arg0.Passenger1:setTopBottom(0, 0, 109, 133)
			f127_arg0.Passenger1:setAlpha(1)
			f127_arg0.clipFinished(f127_arg0.Passenger1)
			f127_arg0.Passenger2:completeAnimation()
			f127_arg0.Passenger2:setTopBottom(0, 0, 109, 133)
			f127_arg0.Passenger2:setAlpha(1)
			f127_arg0.clipFinished(f127_arg0.Passenger2)
			f127_arg0.Passenger3:completeAnimation()
			f127_arg0.Passenger3:setTopBottom(0, 0, 142, 166)
			f127_arg0.Passenger3:setAlpha(1)
			f127_arg0.clipFinished(f127_arg0.Passenger3)
			f127_arg0.Passenger4:completeAnimation()
			f127_arg0.Passenger4:setTopBottom(0, 0, 142, 166)
			f127_arg0.Passenger4:setAlpha(1)
			f127_arg0.clipFinished(f127_arg0.Passenger4)
			f127_arg0.Gunner1:completeAnimation()
			f127_arg0.Gunner1:setAlpha(0)
			f127_arg0.clipFinished(f127_arg0.Gunner1)
			f127_arg0.Gunner2:completeAnimation()
			f127_arg0.Gunner2:setAlpha(0)
			f127_arg0.clipFinished(f127_arg0.Gunner2)
			f127_arg0.Gunner3:completeAnimation()
			f127_arg0.Gunner3:setAlpha(0)
			f127_arg0.clipFinished(f127_arg0.Gunner3)
			f127_arg0.Gunner4:completeAnimation()
			f127_arg0.Gunner4:setAlpha(0)
			f127_arg0.clipFinished(f127_arg0.Gunner4)
			f127_arg0.nextClip = "DefaultClip"
		end,
	},
	Boat = {
		DefaultClip = function(f131_arg0, f131_arg1)
			f131_arg0:__resetProperties()
			f131_arg0:setupElementClipCounter(11)
			f131_arg0.BoatBg:completeAnimation()
			f131_arg0.BoatBg:setTopBottom(0, 0, 84, 196)
			f131_arg0.BoatBg:setAlpha(0.8)
			f131_arg0.clipFinished(f131_arg0.BoatBg)
			local f131_local0 = function(f132_arg0)
				local f132_local0 = function(f133_arg0)
					local f133_local0 = function(f134_arg0)
						f134_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
						f134_arg0:setAlpha(0.4)
						f134_arg0:registerEventHandler("transition_complete_keyframe", f131_arg0.clipFinished)
					end
					f133_arg0:beginAnimation(200)
					f133_arg0:registerEventHandler("transition_complete_keyframe", f133_local0)
				end
				f131_arg0.Boat:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f131_arg0.Boat:setAlpha(0.1)
				f131_arg0.Boat:registerEventHandler("interrupted_keyframe", f131_arg0.clipInterrupted)
				f131_arg0.Boat:registerEventHandler("transition_complete_keyframe", f132_local0)
			end
			f131_arg0.Boat:completeAnimation()
			f131_arg0.Boat:setTopBottom(0, 0, 84, 196)
			f131_arg0.Boat:setAlpha(0.4)
			f131_local0(f131_arg0.Boat)
			f131_arg0.Driver:completeAnimation()
			f131_arg0.Driver:setLeftRight(0, 0, 63, 87)
			f131_arg0.Driver:setTopBottom(0, 0, 155, 179)
			f131_arg0.Driver:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.Driver)
			f131_arg0.Passenger1:completeAnimation()
			f131_arg0.Passenger1:setTopBottom(0, 0, 95, 119)
			f131_arg0.Passenger1:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Passenger1)
			f131_arg0.Passenger2:completeAnimation()
			f131_arg0.Passenger2:setTopBottom(0, 0, 95, 119)
			f131_arg0.Passenger2:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Passenger2)
			f131_arg0.Passenger3:completeAnimation()
			f131_arg0.Passenger3:setTopBottom(0, 0, 125, 149)
			f131_arg0.Passenger3:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Passenger3)
			f131_arg0.Passenger4:completeAnimation()
			f131_arg0.Passenger4:setLeftRight(0, 0, 83, 107)
			f131_arg0.Passenger4:setTopBottom(0, 0, 125, 149)
			f131_arg0.Passenger4:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Passenger4)
			f131_arg0.Gunner1:completeAnimation()
			f131_arg0.Gunner1:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Gunner1)
			f131_arg0.Gunner2:completeAnimation()
			f131_arg0.Gunner2:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Gunner2)
			f131_arg0.Gunner3:completeAnimation()
			f131_arg0.Gunner3:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Gunner3)
			f131_arg0.Gunner4:completeAnimation()
			f131_arg0.Gunner4:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Gunner4)
			f131_arg0.nextClip = "DefaultClip"
		end,
	},
	Buggy = {
		DefaultClip = function(f135_arg0, f135_arg1)
			f135_arg0:__resetProperties()
			f135_arg0:setupElementClipCounter(10)
			f135_arg0.BuggyBG:completeAnimation()
			f135_arg0.BuggyBG:setAlpha(0.8)
			f135_arg0.clipFinished(f135_arg0.BuggyBG)
			local f135_local0 = function(f136_arg0)
				local f136_local0 = function(f137_arg0)
					local f137_local0 = function(f138_arg0)
						f138_arg0:beginAnimation(1000)
						f138_arg0:setAlpha(0.4)
						f138_arg0:registerEventHandler("transition_complete_keyframe", f135_arg0.clipFinished)
					end
					f137_arg0:beginAnimation(200)
					f137_arg0:registerEventHandler("transition_complete_keyframe", f137_local0)
				end
				f135_arg0.Buggy:beginAnimation(1000)
				f135_arg0.Buggy:setAlpha(0.1)
				f135_arg0.Buggy:registerEventHandler("interrupted_keyframe", f135_arg0.clipInterrupted)
				f135_arg0.Buggy:registerEventHandler("transition_complete_keyframe", f136_local0)
			end
			f135_arg0.Buggy:completeAnimation()
			f135_arg0.Buggy:setAlpha(0.4)
			f135_local0(f135_arg0.Buggy)
			f135_arg0.Driver:completeAnimation()
			f135_arg0.Driver:setLeftRight(0, 0, 38, 62)
			f135_arg0.Driver:setTopBottom(0, 0, 132.5, 156.5)
			f135_arg0.Driver:setAlpha(1)
			f135_arg0.clipFinished(f135_arg0.Driver)
			f135_arg0.Passenger1:completeAnimation()
			f135_arg0.Passenger1:setLeftRight(0, 0, 89, 113)
			f135_arg0.Passenger1:setTopBottom(0, 0, 132.5, 156.5)
			f135_arg0.Passenger1:setAlpha(1)
			f135_arg0.clipFinished(f135_arg0.Passenger1)
			f135_arg0.Passenger2:completeAnimation()
			f135_arg0.Passenger2:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.Passenger2)
			f135_arg0.Passenger3:completeAnimation()
			f135_arg0.Passenger3:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.Passenger3)
			f135_arg0.Gunner1:completeAnimation()
			f135_arg0.Gunner1:setLeftRight(0, 0, 63, 87)
			f135_arg0.Gunner1:setTopBottom(0, 0, 165, 189)
			f135_arg0.Gunner1:setAlpha(1)
			f135_arg0.clipFinished(f135_arg0.Gunner1)
			f135_arg0.Gunner2:completeAnimation()
			f135_arg0.Gunner2:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.Gunner2)
			f135_arg0.Gunner3:completeAnimation()
			f135_arg0.Gunner3:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.Gunner3)
			f135_arg0.Gunner4:completeAnimation()
			f135_arg0.Gunner4:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.Gunner4)
			f135_arg0.nextClip = "DefaultClip"
		end,
	},
	Patrol = {
		DefaultClip = function(f139_arg0, f139_arg1)
			f139_arg0:__resetProperties()
			f139_arg0:setupElementClipCounter(10)
			f139_arg0.BoatPatrolBG:completeAnimation()
			f139_arg0.BoatPatrolBG:setAlpha(0.8)
			f139_arg0.clipFinished(f139_arg0.BoatPatrolBG)
			local f139_local0 = function(f140_arg0)
				local f140_local0 = function(f141_arg0)
					local f141_local0 = function(f142_arg0)
						f142_arg0:beginAnimation(1000)
						f142_arg0:setAlpha(0.4)
						f142_arg0:registerEventHandler("transition_complete_keyframe", f139_arg0.clipFinished)
					end
					f141_arg0:beginAnimation(200)
					f141_arg0:registerEventHandler("transition_complete_keyframe", f141_local0)
				end
				f139_arg0.BoatPatrol:beginAnimation(1000)
				f139_arg0.BoatPatrol:setAlpha(0.1)
				f139_arg0.BoatPatrol:registerEventHandler("interrupted_keyframe", f139_arg0.clipInterrupted)
				f139_arg0.BoatPatrol:registerEventHandler("transition_complete_keyframe", f140_local0)
			end
			f139_arg0.BoatPatrol:completeAnimation()
			f139_arg0.BoatPatrol:setAlpha(0.4)
			f139_local0(f139_arg0.BoatPatrol)
			f139_arg0.Driver:completeAnimation()
			f139_arg0.Driver:setLeftRight(0, 0, 63, 87)
			f139_arg0.Driver:setTopBottom(0, 0, 150, 174)
			f139_arg0.Driver:setAlpha(1)
			f139_arg0.clipFinished(f139_arg0.Driver)
			f139_arg0.Passenger1:completeAnimation()
			f139_arg0.Passenger1:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.Passenger1)
			f139_arg0.Passenger2:completeAnimation()
			f139_arg0.Passenger2:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.Passenger2)
			f139_arg0.Passenger3:completeAnimation()
			f139_arg0.Passenger3:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.Passenger3)
			f139_arg0.Gunner1:completeAnimation()
			f139_arg0.Gunner1:setLeftRight(0, 0, 63, 87)
			f139_arg0.Gunner1:setTopBottom(0, 0, 104, 128)
			f139_arg0.Gunner1:setAlpha(1)
			f139_arg0.clipFinished(f139_arg0.Gunner1)
			f139_arg0.Gunner2:completeAnimation()
			f139_arg0.Gunner2:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.Gunner2)
			f139_arg0.Gunner3:completeAnimation()
			f139_arg0.Gunner3:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.Gunner3)
			f139_arg0.Gunner4:completeAnimation()
			f139_arg0.Gunner4:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.Gunner4)
			f139_arg0.nextClip = "DefaultClip"
		end,
	},
	UH1D = {
		DefaultClip = function(f143_arg0, f143_arg1)
			f143_arg0:__resetProperties()
			f143_arg0:setupElementClipCounter(11)
			f143_arg0.HelicopterUH1Dbg:completeAnimation()
			f143_arg0.HelicopterUH1Dbg:setAlpha(0.8)
			f143_arg0.clipFinished(f143_arg0.HelicopterUH1Dbg)
			local f143_local0 = function(f144_arg0)
				local f144_local0 = function(f145_arg0)
					local f145_local0 = function(f146_arg0)
						f146_arg0:beginAnimation(1000)
						f146_arg0:setAlpha(0.4)
						f146_arg0:registerEventHandler("transition_complete_keyframe", f143_arg0.clipFinished)
					end
					f145_arg0:beginAnimation(200)
					f145_arg0:registerEventHandler("transition_complete_keyframe", f145_local0)
				end
				f143_arg0.HelicopterUH1D:beginAnimation(1000)
				f143_arg0.HelicopterUH1D:setAlpha(0.1)
				f143_arg0.HelicopterUH1D:registerEventHandler("interrupted_keyframe", f143_arg0.clipInterrupted)
				f143_arg0.HelicopterUH1D:registerEventHandler("transition_complete_keyframe", f144_local0)
			end
			f143_arg0.HelicopterUH1D:completeAnimation()
			f143_arg0.HelicopterUH1D:setAlpha(0.4)
			f143_local0(f143_arg0.HelicopterUH1D)
			f143_arg0.Driver:completeAnimation()
			f143_arg0.Driver:setLeftRight(0, 0, 43, 67)
			f143_arg0.Driver:setTopBottom(0, 0, 91, 115)
			f143_arg0.Driver:setAlpha(1)
			f143_arg0.clipFinished(f143_arg0.Driver)
			f143_arg0.Passenger1:completeAnimation()
			f143_arg0.Passenger1:setLeftRight(0, 0, 83, 107)
			f143_arg0.Passenger1:setTopBottom(0, 0, 91, 115)
			f143_arg0.Passenger1:setAlpha(1)
			f143_arg0.clipFinished(f143_arg0.Passenger1)
			f143_arg0.Passenger2:completeAnimation()
			f143_arg0.Passenger2:setTopBottom(0, 0, 91, 115)
			f143_arg0.Passenger2:setAlpha(0)
			f143_arg0.clipFinished(f143_arg0.Passenger2)
			f143_arg0.Passenger3:completeAnimation()
			f143_arg0.Passenger3:setAlpha(0)
			f143_arg0.clipFinished(f143_arg0.Passenger3)
			f143_arg0.Passenger4:completeAnimation()
			f143_arg0.Passenger4:setAlpha(0)
			f143_arg0.clipFinished(f143_arg0.Passenger4)
			f143_arg0.Gunner1:completeAnimation()
			f143_arg0.Gunner1:setTopBottom(0, 0, 126, 150)
			f143_arg0.Gunner1:setAlpha(1)
			f143_arg0.clipFinished(f143_arg0.Gunner1)
			f143_arg0.Gunner2:completeAnimation()
			f143_arg0.Gunner2:setTopBottom(0, 0, 126, 150)
			f143_arg0.Gunner2:setAlpha(1)
			f143_arg0.clipFinished(f143_arg0.Gunner2)
			f143_arg0.Gunner3:completeAnimation()
			f143_arg0.Gunner3:setAlpha(0)
			f143_arg0.clipFinished(f143_arg0.Gunner3)
			f143_arg0.Gunner4:completeAnimation()
			f143_arg0.Gunner4:setAlpha(0)
			f143_arg0.clipFinished(f143_arg0.Gunner4)
			f143_arg0.nextClip = "DefaultClip"
		end,
	},
	CivilianSUV = {
		DefaultClip = function(f147_arg0, f147_arg1)
			f147_arg0:__resetProperties()
			f147_arg0:setupElementClipCounter(6)
			f147_arg0.CivilanSUVBG:completeAnimation()
			f147_arg0.CivilanSUVBG:setAlpha(0.8)
			f147_arg0.clipFinished(f147_arg0.CivilanSUVBG)
			local f147_local0 = function(f148_arg0)
				local f148_local0 = function(f149_arg0)
					local f149_local0 = function(f150_arg0)
						f150_arg0:beginAnimation(1020)
						f150_arg0:setAlpha(0.4)
						f150_arg0:registerEventHandler("transition_complete_keyframe", f147_arg0.clipFinished)
					end
					f149_arg0:beginAnimation(190)
					f149_arg0:registerEventHandler("transition_complete_keyframe", f149_local0)
				end
				f147_arg0.CivilianSUV:beginAnimation(1000)
				f147_arg0.CivilianSUV:setAlpha(0.1)
				f147_arg0.CivilianSUV:registerEventHandler("interrupted_keyframe", f147_arg0.clipInterrupted)
				f147_arg0.CivilianSUV:registerEventHandler("transition_complete_keyframe", f148_local0)
			end
			f147_arg0.CivilianSUV:completeAnimation()
			f147_arg0.CivilianSUV:setAlpha(0.4)
			f147_local0(f147_arg0.CivilianSUV)
			f147_arg0.Driver:completeAnimation()
			f147_arg0.Driver:setLeftRight(0, 0, 45, 69)
			f147_arg0.Driver:setTopBottom(0, 0, 126, 150)
			f147_arg0.Driver:setAlpha(1)
			f147_arg0.clipFinished(f147_arg0.Driver)
			f147_arg0.Passenger1:completeAnimation()
			f147_arg0.Passenger1:setLeftRight(0, 0, 83, 107)
			f147_arg0.Passenger1:setTopBottom(0, 0, 126, 150)
			f147_arg0.Passenger1:setAlpha(1)
			f147_arg0.clipFinished(f147_arg0.Passenger1)
			f147_arg0.Passenger2:completeAnimation()
			f147_arg0.Passenger2:setLeftRight(0, 0, 45, 69)
			f147_arg0.Passenger2:setTopBottom(0, 0, 158, 182)
			f147_arg0.Passenger2:setAlpha(1)
			f147_arg0.clipFinished(f147_arg0.Passenger2)
			f147_arg0.Passenger3:completeAnimation()
			f147_arg0.Passenger3:setLeftRight(0, 0, 83, 107)
			f147_arg0.Passenger3:setTopBottom(0, 0, 158, 182)
			f147_arg0.Passenger3:setAlpha(1)
			f147_arg0.clipFinished(f147_arg0.Passenger3)
			f147_arg0.nextClip = "DefaultClip"
		end,
	},
	CivilianMuscleCar = {
		DefaultClip = function(f151_arg0, f151_arg1)
			f151_arg0:__resetProperties()
			f151_arg0:setupElementClipCounter(6)
			f151_arg0.CivilanMusscleCarBG:completeAnimation()
			f151_arg0.CivilanMusscleCarBG:setAlpha(0.8)
			f151_arg0.clipFinished(f151_arg0.CivilanMusscleCarBG)
			local f151_local0 = function(f152_arg0)
				local f152_local0 = function(f153_arg0)
					local f153_local0 = function(f154_arg0)
						f154_arg0:beginAnimation(1020)
						f154_arg0:setAlpha(0.4)
						f154_arg0:registerEventHandler("transition_complete_keyframe", f151_arg0.clipFinished)
					end
					f153_arg0:beginAnimation(190)
					f153_arg0:registerEventHandler("transition_complete_keyframe", f153_local0)
				end
				f151_arg0.CivilianMuscleCar:beginAnimation(1000)
				f151_arg0.CivilianMuscleCar:setAlpha(0.1)
				f151_arg0.CivilianMuscleCar:registerEventHandler("interrupted_keyframe", f151_arg0.clipInterrupted)
				f151_arg0.CivilianMuscleCar:registerEventHandler("transition_complete_keyframe", f152_local0)
			end
			f151_arg0.CivilianMuscleCar:completeAnimation()
			f151_arg0.CivilianMuscleCar:setAlpha(0.4)
			f151_local0(f151_arg0.CivilianMuscleCar)
			f151_arg0.Driver:completeAnimation()
			f151_arg0.Driver:setLeftRight(0, 0, 44, 68)
			f151_arg0.Driver:setTopBottom(0, 0, 125.5, 149.5)
			f151_arg0.Driver:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Driver)
			f151_arg0.Passenger1:completeAnimation()
			f151_arg0.Passenger1:setLeftRight(0, 0, 82, 106)
			f151_arg0.Passenger1:setTopBottom(0, 0, 125.5, 149.5)
			f151_arg0.Passenger1:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Passenger1)
			f151_arg0.Passenger2:completeAnimation()
			f151_arg0.Passenger2:setLeftRight(0, 0, 44, 68)
			f151_arg0.Passenger2:setTopBottom(0, 0, 154, 178)
			f151_arg0.Passenger2:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Passenger2)
			f151_arg0.Passenger3:completeAnimation()
			f151_arg0.Passenger3:setLeftRight(0, 0, 82, 106)
			f151_arg0.Passenger3:setTopBottom(0, 0, 154, 178)
			f151_arg0.Passenger3:setAlpha(1)
			f151_arg0.clipFinished(f151_arg0.Passenger3)
			f151_arg0.nextClip = "DefaultClip"
		end,
	},
	HelicopterAttack = {
		DefaultClip = function(f155_arg0, f155_arg1)
			f155_arg0:__resetProperties()
			f155_arg0:setupElementClipCounter(12)
			f155_arg0.HelicopterBg:completeAnimation()
			f155_arg0.HelicopterBg:setAlpha(0.8)
			f155_arg0.clipFinished(f155_arg0.HelicopterBg)
			local f155_local0 = function(f156_arg0)
				local f156_local0 = function(f157_arg0)
					local f157_local0 = function(f158_arg0)
						f158_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
						f158_arg0:setAlpha(0.4)
						f158_arg0:registerEventHandler("transition_complete_keyframe", f155_arg0.clipFinished)
					end
					f157_arg0:beginAnimation(200)
					f157_arg0:registerEventHandler("transition_complete_keyframe", f157_local0)
				end
				f155_arg0.Helicopter:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f155_arg0.Helicopter:setAlpha(0.1)
				f155_arg0.Helicopter:registerEventHandler("interrupted_keyframe", f155_arg0.clipInterrupted)
				f155_arg0.Helicopter:registerEventHandler("transition_complete_keyframe", f156_local0)
			end
			f155_arg0.Helicopter:completeAnimation()
			f155_arg0.Helicopter:setAlpha(0.4)
			f155_local0(f155_arg0.Helicopter)
			f155_arg0.Driver:completeAnimation()
			f155_arg0.Driver:setLeftRight(0, 0, 45, 69)
			f155_arg0.Driver:setTopBottom(0, 0, 91, 115)
			f155_arg0.Driver:setAlpha(1)
			f155_arg0.clipFinished(f155_arg0.Driver)
			f155_arg0.CoPilot:completeAnimation()
			f155_arg0.CoPilot:setLeftRight(0, 0, 81, 105)
			f155_arg0.CoPilot:setTopBottom(0, 0, 91, 115)
			f155_arg0.CoPilot:setAlpha(1)
			f155_arg0.clipFinished(f155_arg0.CoPilot)
			f155_arg0.Passenger1:completeAnimation()
			f155_arg0.Passenger1:setLeftRight(0, 0, 45, 69)
			f155_arg0.Passenger1:setTopBottom(0, 0, 122, 146)
			f155_arg0.Passenger1:setAlpha(0)
			f155_arg0.clipFinished(f155_arg0.Passenger1)
			f155_arg0.Passenger2:completeAnimation()
			f155_arg0.Passenger2:setLeftRight(0, 0, 81, 105)
			f155_arg0.Passenger2:setTopBottom(0, 0, 122, 146)
			f155_arg0.Passenger2:setAlpha(0)
			f155_arg0.clipFinished(f155_arg0.Passenger2)
			f155_arg0.Passenger3:completeAnimation()
			f155_arg0.Passenger3:setTopBottom(0, 0, 142, 166)
			f155_arg0.Passenger3:setAlpha(0)
			f155_arg0.clipFinished(f155_arg0.Passenger3)
			f155_arg0.Passenger4:completeAnimation()
			f155_arg0.Passenger4:setTopBottom(0, 0, 142, 166)
			f155_arg0.Passenger4:setAlpha(0)
			f155_arg0.clipFinished(f155_arg0.Passenger4)
			f155_arg0.Gunner1:completeAnimation()
			f155_arg0.Gunner1:setLeftRight(0, 0, 81, 105)
			f155_arg0.Gunner1:setTopBottom(0, 0, 122, 146)
			f155_arg0.Gunner1:setAlpha(1)
			f155_arg0.clipFinished(f155_arg0.Gunner1)
			f155_arg0.Gunner2:completeAnimation()
			f155_arg0.Gunner2:setLeftRight(0, 0, 45, 69)
			f155_arg0.Gunner2:setTopBottom(0, 0, 122, 146)
			f155_arg0.Gunner2:setAlpha(1)
			f155_arg0.clipFinished(f155_arg0.Gunner2)
			f155_arg0.Gunner3:completeAnimation()
			f155_arg0.Gunner3:setAlpha(0)
			f155_arg0.clipFinished(f155_arg0.Gunner3)
			f155_arg0.Gunner4:completeAnimation()
			f155_arg0.Gunner4:setAlpha(0)
			f155_arg0.clipFinished(f155_arg0.Gunner4)
			f155_arg0.nextClip = "DefaultClip"
		end,
	},
	Motorcycle = {
		DefaultClip = function(f159_arg0, f159_arg1)
			f159_arg0:__resetProperties()
			f159_arg0:setupElementClipCounter(4)
			f159_arg0.MotorCycleBg:completeAnimation()
			f159_arg0.MotorCycleBg:setAlpha(0.8)
			f159_arg0.clipFinished(f159_arg0.MotorCycleBg)
			local f159_local0 = function(f160_arg0)
				local f160_local0 = function(f161_arg0)
					local f161_local0 = function(f162_arg0)
						f162_arg0:beginAnimation(1000)
						f162_arg0:setAlpha(0.4)
						f162_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
					end
					f161_arg0:beginAnimation(200)
					f161_arg0:registerEventHandler("transition_complete_keyframe", f161_local0)
				end
				f159_arg0.MotorCycle:beginAnimation(1000)
				f159_arg0.MotorCycle:setAlpha(0.1)
				f159_arg0.MotorCycle:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.MotorCycle:registerEventHandler("transition_complete_keyframe", f160_local0)
			end
			f159_arg0.MotorCycle:completeAnimation()
			f159_arg0.MotorCycle:setAlpha(0.4)
			f159_local0(f159_arg0.MotorCycle)
			f159_arg0.Driver:completeAnimation()
			f159_arg0.Driver:setLeftRight(0, 0, 47, 71)
			f159_arg0.Driver:setTopBottom(0, 0, 133, 157)
			f159_arg0.Driver:setAlpha(1)
			f159_arg0.clipFinished(f159_arg0.Driver)
			f159_arg0.Passenger1:completeAnimation()
			f159_arg0.Passenger1:setLeftRight(0, 0, 74, 98)
			f159_arg0.Passenger1:setTopBottom(0, 0, 157.5, 181.5)
			f159_arg0.Passenger1:setAlpha(1)
			f159_arg0.clipFinished(f159_arg0.Passenger1)
			f159_arg0.nextClip = "DefaultClip"
		end,
	},
	Tank = {
		DefaultClip = function(f163_arg0, f163_arg1)
			f163_arg0:__resetProperties()
			f163_arg0:setupElementClipCounter(4)
			f163_arg0.TankBg:completeAnimation()
			f163_arg0.TankBg:setAlpha(0.8)
			f163_arg0.clipFinished(f163_arg0.TankBg)
			local f163_local0 = function(f164_arg0)
				local f164_local0 = function(f165_arg0)
					local f165_local0 = function(f166_arg0)
						f166_arg0:beginAnimation(1000)
						f166_arg0:setAlpha(0.4)
						f166_arg0:registerEventHandler("transition_complete_keyframe", f163_arg0.clipFinished)
					end
					f165_arg0:beginAnimation(200)
					f165_arg0:registerEventHandler("transition_complete_keyframe", f165_local0)
				end
				f163_arg0.Tank:beginAnimation(1000)
				f163_arg0.Tank:setAlpha(0.1)
				f163_arg0.Tank:registerEventHandler("interrupted_keyframe", f163_arg0.clipInterrupted)
				f163_arg0.Tank:registerEventHandler("transition_complete_keyframe", f164_local0)
			end
			f163_arg0.Tank:completeAnimation()
			f163_arg0.Tank:setAlpha(0.4)
			f163_local0(f163_arg0.Tank)
			f163_arg0.Driver:completeAnimation()
			f163_arg0.Driver:setTopBottom(0, 0, 99, 123)
			f163_arg0.Driver:setAlpha(1)
			f163_arg0.clipFinished(f163_arg0.Driver)
			f163_arg0.Passenger1:completeAnimation()
			f163_arg0.Passenger1:setLeftRight(0, 0, 75, 99)
			f163_arg0.Passenger1:setTopBottom(0, 0, 153, 177)
			f163_arg0.Passenger1:setAlpha(1)
			f163_arg0.clipFinished(f163_arg0.Passenger1)
			f163_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.VehicleSeatConfig_Internal.__onClose = function(f167_arg0)
	f167_arg0.Driver:close()
	f167_arg0.CoPilot:close()
	f167_arg0.Passenger1:close()
	f167_arg0.Passenger2:close()
	f167_arg0.Passenger3:close()
	f167_arg0.Passenger4:close()
	f167_arg0.Gunner1:close()
	f167_arg0.Gunner2:close()
	f167_arg0.Gunner3:close()
	f167_arg0.Gunner4:close()
	f167_arg0.WarzoneEMPVehicle:close()
end
