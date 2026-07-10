CoD.CallingCards_Asset_helicopter = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_helicopter.__defaultWidth = 356
CoD.CallingCards_Asset_helicopter.__defaultHeight = 190
CoD.CallingCards_Asset_helicopter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_helicopter)
	self.id = "CallingCards_Asset_helicopter"
	self.soundSet = "default"
	local propeller = LUI.UIImage.new(0, 0, 0, 356, 0, 0, 0, 146)
	propeller:setAlpha(0.5)
	propeller:setImage(RegisterImage(0xF0B31E7071A5826))
	propeller:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	propeller:setShaderVector(0, 1, 2.19, 0, 0)
	propeller:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(propeller)
	self.propeller = propeller
	local helicopter = LUI.UIImage.new(0, 0, 101, 333, 0, 0, 33, 177)
	helicopter:setScale(1.1, 1.1)
	helicopter:setImage(RegisterImage(0x986BF5FED827EE2))
	self:addElement(helicopter)
	self.helicopter = helicopter
	local propeller2 = LUI.UIImage.new(0, 0, 298, 329, 0, 0, 86, 114)
	propeller2:setAlpha(0.5)
	propeller2:setImage(RegisterImage(0xF0B31E7071A5826))
	propeller2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	propeller2:setShaderVector(0, 1, 2.19, 0, 0)
	propeller2:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(propeller2)
	self.propeller2 = propeller2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
