CoD.genericPooledVehicleHealthBar = InheritFrom(LUI.UIElement)
CoD.genericPooledVehicleHealthBar.__defaultWidth = 54
CoD.genericPooledVehicleHealthBar.__defaultHeight = 174
CoD.genericPooledVehicleHealthBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericPooledVehicleHealthBar)
	self.id = "genericPooledVehicleHealthBar"
	self.soundSet = "default"
	local fullBacking = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 174)
	fullBacking:setRGB(0.15, 0.15, 0.15)
	fullBacking:setImage(RegisterImage(0xC71371FF96104D6))
	fullBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	fullBacking:setShaderVector(0, 0, 1, 0, 0)
	fullBacking:setShaderVector(1, 0, 0, 0, 0)
	fullBacking:setShaderVector(2, 0, 1, 0, 0)
	fullBacking:setShaderVector(3, 0, 0, 0, 0)
	fullBacking:setShaderVector(4, 1, 0, 6, 0.02)
	self:addElement(fullBacking)
	self.fullBacking = fullBacking
	local currentPool = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 174)
	currentPool:setRGB(0.53, 0.53, 0.53)
	currentPool:setImage(RegisterImage(0xC82371FF96F7809))
	currentPool:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	currentPool:setShaderVector(0, 0, 1, 0, 0)
	currentPool:setShaderVector(1, 0, 0, 0, 0)
	currentPool:setShaderVector(2, 0, 1, 0, 0)
	currentPool:setShaderVector(3, 0, 0, 0, 0)
	currentPool:setShaderVector(4, 1, 0, 6, 0.02)
	self:addElement(currentPool)
	self.currentPool = currentPool
	local currentDamage = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 174)
	currentDamage:setImage(RegisterImage(0xC82371FF96F7809))
	currentDamage:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	currentDamage:setShaderVector(0, 0, 1, 0, 0)
	currentDamage:setShaderVector(1, 0, 0, 0, 0)
	currentDamage:setShaderVector(2, 0, 1, 0, 0)
	currentDamage:setShaderVector(3, 0, 0, 0, 0)
	currentDamage:setShaderVector(4, 1, 0, 6, 0.02)
	self:addElement(currentDamage)
	self.currentDamage = currentDamage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	CoD.VehicleUtility.RegisterPooledHealthBar(self, f1_arg1, "fullBacking", "currentPool", "currentDamage")
	return self
end
CoD.genericPooledVehicleHealthBar.__onClose = function(f2_arg0)
	f2_arg0.fullBacking:close()
	f2_arg0.currentPool:close()
	f2_arg0.currentDamage:close()
end
