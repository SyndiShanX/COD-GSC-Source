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
	Line0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_turret_damageiconlinergb"))
	Line0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Line0)
	self.Line0 = Line0
	local Red = LUI.UIImage.new(0.5, 0.5, -73, 74, 0.5, 0.5, -73, 74)
	Red:setAlpha(0.8)
	Red:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_turret_damageiconred"))
	Red:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
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
	Line:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_turret_damageiconlinergb"))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
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
