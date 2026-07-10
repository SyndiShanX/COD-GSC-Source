CoD.vhud_attack_helicopter_health = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_health.__defaultWidth = 302
CoD.vhud_attack_helicopter_health.__defaultHeight = 178
CoD.vhud_attack_helicopter_health.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_health)
	self.id = "vhud_attack_helicopter_health"
	self.soundSet = "none"
	local BackImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BackImage)
	self.BackImage = BackImage
	local Overlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Overlay:setRGB(0.98, 0.98, 0.98)
	Overlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	Overlay:setShaderVector(1, 0, 0, 0, 0)
	Overlay:setShaderVector(2, 1, 0, 0, 0)
	Overlay:setShaderVector(3, 0, 0, 0, 0)
	Overlay:setShaderVector(4, 0, 0, 0, 0)
	Overlay:linkToElementModel(self, "damage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Overlay:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(Overlay)
	self.Overlay = Overlay
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_health.__onClose = function(f3_arg0)
	f3_arg0.Overlay:close()
end
