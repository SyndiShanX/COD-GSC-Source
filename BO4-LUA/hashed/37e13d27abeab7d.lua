require("x64:2cd5497a304c464")
require("x64:d24e4a6046a91b2")
CoD.vhud_tank_robot_health = InheritFrom(LUI.UIElement)
CoD.vhud_tank_robot_health.__defaultWidth = 353
CoD.vhud_tank_robot_health.__defaultHeight = 180
CoD.vhud_tank_robot_health.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_tank_robot_health)
	self.id = "vhud_tank_robot_health"
	self.soundSet = "default"
	local VehicleHpBg = LUI.UIImage.new(0, 0, 1.5, 303.5, 0, 0, 1, 179)
	VehicleHpBg:setImage(RegisterImage(0xE6BF37C3B5F9A2A))
	self:addElement(VehicleHpBg)
	self.VehicleHpBg = VehicleHpBg
	local Health = CoD.vhud_attack_helicopter_health.new(f1_arg0, f1_arg1, 0, 0, 32.5, 277.5, 0, 0, 33, 147)
	Health.BackImage:setImage(RegisterImage(0xF6E7E992111B6AE))
	Health.Overlay:setImage(RegisterImage(0xA45692501DFF1B8))
	Health:linkToElementModel(self, nil, false, function(model)
		Health:setModel(model, f1_arg1)
	end)
	self:addElement(Health)
	self.Health = Health
	local vhudmsTimebar = CoD.vhud_ms_Timebar.new(f1_arg0, f1_arg1, 1, 1, -350, 0, 0, 0, 160, 173)
	vhudmsTimebar:linkToElementModel(self, nil, false, function(model)
		vhudmsTimebar:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsTimebar)
	self.vhudmsTimebar = vhudmsTimebar
	local vehicleCornerRT = LUI.UIImage.new(0, 0, 280, 304, 0, 0, 0, 24)
	vehicleCornerRT:setImage(RegisterImage(0x2A026C4CBC764C1))
	vehicleCornerRT:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	vehicleCornerRT:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(vehicleCornerRT)
	self.vehicleCornerRT = vehicleCornerRT
	local vehicleCornerLT = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	vehicleCornerLT:setZRot(90)
	vehicleCornerLT:setImage(RegisterImage(0x2A026C4CBC764C1))
	vehicleCornerLT:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	vehicleCornerLT:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(vehicleCornerLT)
	self.vehicleCornerLT = vehicleCornerLT
	local vehicleCornerLB = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 156, 180)
	vehicleCornerLB:setZRot(180)
	vehicleCornerLB:setImage(RegisterImage(0x2A026C4CBC764C1))
	vehicleCornerLB:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	vehicleCornerLB:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(vehicleCornerLB)
	self.vehicleCornerLB = vehicleCornerLB
	local vehicleCornerRT4 = LUI.UIImage.new(0, 0, 280.5, 304.5, 0, 0, 156, 180)
	vehicleCornerRT4:setZRot(270)
	vehicleCornerRT4:setImage(RegisterImage(0x2A026C4CBC764C1))
	vehicleCornerRT4:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	vehicleCornerRT4:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(vehicleCornerRT4)
	self.vehicleCornerRT4 = vehicleCornerRT4
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_tank_robot_health.__onClose = function(f4_arg0)
	f4_arg0.Health:close()
	f4_arg0.vhudmsTimebar:close()
end
