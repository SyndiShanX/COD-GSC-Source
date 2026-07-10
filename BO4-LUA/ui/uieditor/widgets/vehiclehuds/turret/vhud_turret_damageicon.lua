CoD.vhud_turret_damageicon = InheritFrom(LUI.UIElement)
CoD.vhud_turret_damageicon.__defaultWidth = 150
CoD.vhud_turret_damageicon.__defaultHeight = 150
CoD.vhud_turret_damageicon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_turret_damageicon)
	self.id = "vhud_turret_damageicon"
	self.soundSet = "default"
	local Line0 = LUI.UIImage.new(0.5, 0.5, -73, 74, 0.5, 0.5, -73, 74)
	Line0:setRGB(1, 0.83, 0.39)
	Line0:setAlpha(0.2)
	Line0:setZoom(-50)
	Line0:setImage(RegisterImage(0x753F952B3C143C2))
	Line0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Line0)
	self.Line0 = Line0
	local Red = LUI.UIImage.new(0.5, 0.5, -73, 74, 0.5, 0.5, -73, 74)
	Red:setAlpha(0.8)
	Red:setImage(RegisterImage(0xFA5129C8BD4F5B0))
	Red:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	Red:setShaderVector(1, 0, 0, 0, 0)
	Red:setShaderVector(2, 1, 0, 0, 0)
	Red:setShaderVector(3, 0, 0, 0, 0)
	Red:setShaderVector(4, 0, 0, 0, 0)
	Red:linkToElementModel(self, "damage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Red:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(Red)
	self.Red = Red
	local Line = LUI.UIImage.new(0.5, 0.5, -73, 74, 0.5, 0.5, -73, 74)
	Line:setRGB(1, 0.83, 0.39)
	Line:setImage(RegisterImage(0x753F952B3C143C2))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Line)
	self.Line = Line
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_turret_damageicon.__onClose = function(f3_arg0)
	f3_arg0.Red:close()
end
