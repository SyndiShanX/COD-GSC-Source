require("x64:a4b1f499cecb4af")
require("x64:daebe2fee039529")
CoD.ThrustMeter = InheritFrom(LUI.UIElement)
CoD.ThrustMeter.__defaultWidth = 224
CoD.ThrustMeter.__defaultHeight = 44
CoD.ThrustMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "_lastScalableWidth", -1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ThrustMeter)
	self.id = "ThrustMeter"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Panel = LUI.UIImage.new(0.5, 0.5, -112, 112, 0.5, 0.5, -22, 22)
	Panel:setImage(RegisterImage(0x866397AC1DFF95))
	self:addElement(Panel)
	self.Panel = Panel
	local Empty = LUI.UIImage.new(0, 0, 17, 239, 0, 0, 13, 57)
	Empty:setAlpha(0)
	Empty:setImage(RegisterImage(0x9A01E3B4ED07F13))
	self:addElement(Empty)
	self.Empty = Empty
	local Arc = LUI.UIImage.new(0, 0, 16.5, 238.5, 0, 0, 13, 57)
	Arc:setAlpha(0)
	Arc:setImage(RegisterImage(0x38719A9CBF6E8F4))
	self:addElement(Arc)
	self.Arc = Arc
	local thrustMeter = CoD.ThrustMeterDots.new(f1_arg0, f1_arg1, 0.5, 0.5, -114, 110, 0.5, 0.5, -22, 22)
	thrustMeter.dots:setShaderVector(0, 0.8, 0.01, 0, 0)
	thrustMeter.dots:setShaderVector(1, 0, 0, 0, 0)
	thrustMeter.fill:setShaderVector(0, 0.54, 0, 0, 0)
	thrustMeter.fill:setShaderVector(2, -3.18, 0, 0, 0)
	self:addElement(thrustMeter)
	self.thrustMeter = thrustMeter
	local thrustArrows = CoD.ThrustMeterArrows.new(f1_arg0, f1_arg1, 0.5, 0.5, -10, 12, 1, 1, -445, 5)
	thrustArrows:setAlpha(0)
	thrustArrows.right1:setZRot(27)
	self:addElement(thrustArrows)
	self.thrustArrows = thrustArrows
	local pixel1 = LUI.UIImage.new(0.5, 0.5, -120, -108, 1, 1, -54, -42)
	pixel1:setAlpha(0)
	pixel1:setImage(RegisterImage(0xA4E3A816ADAA8CD))
	pixel1:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(pixel1)
	self.pixel1 = pixel1
	local pixel2 = LUI.UIImage.new(0.5, 0.5, 108, 120, 1, 1, -54, -42)
	pixel2:setAlpha(0)
	pixel2:setImage(RegisterImage(0xA4E3A816ADAA8CD))
	pixel2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(pixel2)
	self.pixel2 = pixel2
	self:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerEnergyRatio", function(model)
		local f2_local0 = self
		CoD.HUDUtility.UpdateThrustMeter(self, self.thrustMeter, self.thrustArrows, f1_arg1, model)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ThrustMeter.__onClose = function(f3_arg0)
	f3_arg0.thrustMeter:close()
	f3_arg0.thrustArrows:close()
end
