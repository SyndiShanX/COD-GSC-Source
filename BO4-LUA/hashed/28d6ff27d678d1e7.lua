require("x64:2cd5497a304c464")
require("x64:d24e4a6046a91b2")
CoD.vhud_gunship_health = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_health.__defaultWidth = 353
CoD.vhud_gunship_health.__defaultHeight = 180
CoD.vhud_gunship_health.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_health)
	self.id = "vhud_gunship_health"
	self.soundSet = "default"
	local VehicleHpBg = LUI.UIImage.new(1, 1, -351, -49, 1, 1, -179, -1)
	VehicleHpBg:setImage(RegisterImage(0xE6BF37C3B5F9A2A))
	VehicleHpBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	VehicleHpBg:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(VehicleHpBg)
	self.VehicleHpBg = VehicleHpBg
	local Health = CoD.vhud_attack_helicopter_health.new(f1_arg0, f1_arg1, 1, 1, -320.5, -75.5, 1, 1, -147, -33)
	Health.BackImage:setImage(RegisterImage(0xD473EB6538DEF86))
	Health.Overlay:setImage(RegisterImage(0x12292CEE63E41B0))
	Health:linkToElementModel(self, nil, false, function(model)
		Health:setModel(model, f1_arg1)
	end)
	self:addElement(Health)
	self.Health = Health
	local vhudmsTimebar = CoD.vhud_ms_Timebar.new(f1_arg0, f1_arg1, 1, 1, -350, 0, 1, 1, -20, -7)
	vhudmsTimebar:linkToElementModel(self, nil, false, function(model)
		vhudmsTimebar:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsTimebar)
	self.vhudmsTimebar = vhudmsTimebar
	local Ac120Name = LUI.UIImage.new(1, 1, -324, -238, 1, 1, -167, -149)
	Ac120Name:setImage(RegisterImage(0x93841FB9CF9F7D7))
	Ac120Name:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Ac120Name)
	self.Ac120Name = Ac120Name
	local vehicleCornerRT = LUI.UIImage.new(1, 1, -73, -49, 1, 1, -180, -156)
	vehicleCornerRT:setImage(RegisterImage(0x2A026C4CBC764C1))
	self:addElement(vehicleCornerRT)
	self.vehicleCornerRT = vehicleCornerRT
	local vehicleCornerLT = LUI.UIImage.new(1, 1, -353, -329, 1, 1, -180, -156)
	vehicleCornerLT:setZRot(90)
	vehicleCornerLT:setImage(RegisterImage(0x2A026C4CBC764C1))
	self:addElement(vehicleCornerLT)
	self.vehicleCornerLT = vehicleCornerLT
	local vehicleCornerLB = LUI.UIImage.new(1, 1, -353, -329, 1, 1, -24, 0)
	vehicleCornerLB:setZRot(180)
	vehicleCornerLB:setImage(RegisterImage(0x2A026C4CBC764C1))
	self:addElement(vehicleCornerLB)
	self.vehicleCornerLB = vehicleCornerLB
	local vehicleCornerRT4 = LUI.UIImage.new(1, 1, -72.5, -48.5, 1, 1, -24, 0)
	vehicleCornerRT4:setZRot(270)
	vehicleCornerRT4:setImage(RegisterImage(0x2A026C4CBC764C1))
	self:addElement(vehicleCornerRT4)
	self.vehicleCornerRT4 = vehicleCornerRT4
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_health.__onClose = function(f4_arg0)
	f4_arg0.Health:close()
	f4_arg0.vhudmsTimebar:close()
end
