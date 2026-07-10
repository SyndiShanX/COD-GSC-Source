CoD.VehicleGround_IrisOutterThin = InheritFrom(LUI.UIElement)
CoD.VehicleGround_IrisOutterThin.__defaultWidth = 2131
CoD.VehicleGround_IrisOutterThin.__defaultHeight = 1414
CoD.VehicleGround_IrisOutterThin.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_IrisOutterThin)
	self.id = "VehicleGround_IrisOutterThin"
	self.soundSet = "default"
	local Image0 = LUI.UIImage.new(0, 0, -30, 337, 0, 1, 0, 0)
	Image0:setImage(RegisterImage(0x2FFC7E1F199FCAD))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	local Image1 = LUI.UIImage.new(1, 1, -367, 0, 0, 1, 0, 0)
	Image1:setZRot(-180)
	Image1:setImage(RegisterImage(0x2FFC7E1F199FCAD))
	Image1:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image1)
	self.Image1 = Image1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
