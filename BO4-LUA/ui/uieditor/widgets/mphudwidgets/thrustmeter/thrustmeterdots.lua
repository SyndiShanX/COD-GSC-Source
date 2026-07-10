CoD.ThrustMeterDots = InheritFrom(LUI.UIElement)
CoD.ThrustMeterDots.__defaultWidth = 224
CoD.ThrustMeterDots.__defaultHeight = 44
CoD.ThrustMeterDots.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ThrustMeterDots)
	self.id = "ThrustMeterDots"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local dots = LUI.UIImage.new(0, 0, -5.5, 216.5, 0, 0, 6, 50)
	dots:setAlpha(0)
	dots:setImage(RegisterImage(@"uie_ui_hud_core_thrust_widget_container"))
	dots:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	dots:setShaderVector(0, 0.8, 0, 0, 0)
	dots:setShaderVector(1, 0.5, 0, 0, 0)
	dots:setShaderVector(2, 0.5, 0, 0, 0)
	dots:setShaderVector(3, 0, 0, 0, 0)
	dots:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(dots)
	self.dots = dots
	local fill = LUI.UIImage.new(0.5, 0.5, -112, 112, 0.5, 0.5, -22, 22)
	fill:setYRot(180)
	fill:setImage(RegisterImage(@"hash_3D604C2FA238EBD"))
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	fill:setShaderVector(0, 0.8, 0, 0, 0)
	fill:setShaderVector(1, 0.5, 0, 0, 0)
	fill:setShaderVector(2, 0.5, 0, 0, 0)
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(fill)
	self.fill = fill
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
