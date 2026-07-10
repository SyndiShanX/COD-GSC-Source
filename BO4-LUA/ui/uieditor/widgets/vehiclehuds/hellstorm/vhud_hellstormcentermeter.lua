CoD.vhud_HellstormCenterMeter = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormCenterMeter.__defaultWidth = 824
CoD.vhud_HellstormCenterMeter.__defaultHeight = 824
CoD.vhud_HellstormCenterMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormCenterMeter)
	self.id = "vhud_HellstormCenterMeter"
	self.soundSet = "default"
	local Meter = LUI.UIImage.new(0, 0, 0, 824, 0, 0, 0, 824)
	Meter:setImage(RegisterImage(0x1D295E568DDF30C))
	Meter:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	Meter:setShaderVector(0, 1, 0, 0, 0)
	Meter:setShaderVector(1, 0.5, 0, 0, 0)
	Meter:setShaderVector(2, 0.5, 0, 0, 0)
	Meter:setShaderVector(3, 0, 0, 0, 0)
	Meter:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Meter)
	self.Meter = Meter
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
