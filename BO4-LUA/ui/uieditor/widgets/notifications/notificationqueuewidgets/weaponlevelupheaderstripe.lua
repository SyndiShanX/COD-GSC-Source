CoD.WeaponLevelUpHeaderStripe = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpHeaderStripe.__defaultWidth = 418
CoD.WeaponLevelUpHeaderStripe.__defaultHeight = 8
CoD.WeaponLevelUpHeaderStripe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpHeaderStripe)
	self.id = "WeaponLevelUpHeaderStripe"
	self.soundSet = "default"
	local HeaderBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HeaderBacking:setRGB(0.87, 0.87, 0.87)
	HeaderBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	HeaderBacking:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(HeaderBacking)
	self.HeaderBacking = HeaderBacking
	local HeaderBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HeaderBacking2:setAlpha(0.5)
	self:addElement(HeaderBacking2)
	self.HeaderBacking2 = HeaderBacking2
	local HeaderStripe = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HeaderStripe:setRGB(0, 0, 0)
	HeaderStripe:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripe:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe:setupNineSliceShader(50, 8)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	self.HeaderBacking2:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HeaderBacking2:setRGB(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelUpHeaderStripe.__onClose = function(f3_arg0)
	f3_arg0.HeaderBacking2:close()
end
