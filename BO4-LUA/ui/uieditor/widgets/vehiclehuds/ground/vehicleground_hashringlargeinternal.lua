CoD.VehicleGround_HashRingLargeInternal = InheritFrom(LUI.UIElement)
CoD.VehicleGround_HashRingLargeInternal.__defaultWidth = 814
CoD.VehicleGround_HashRingLargeInternal.__defaultHeight = 432
CoD.VehicleGround_HashRingLargeInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_HashRingLargeInternal)
	self.id = "VehicleGround_HashRingLargeInternal"
	self.soundSet = "default"
	local HashLarge = LUI.UIImage.new(1, 1, -144, 0, 0.5, 0.5, -216, 216)
	HashLarge:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_hashringlarge"))
	self:addElement(HashLarge)
	self.HashLarge = HashLarge
	local Null = LUI.UIImage.new(0, 0, 0, 144, 0.5, 0.5, -216, 216)
	Null:setAlpha(0)
	Null:setYRot(-180)
	self:addElement(Null)
	self.Null = Null
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
