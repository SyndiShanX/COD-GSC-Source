CoD.WeaponLevelUpHeaderRight = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpHeaderRight.__defaultWidth = 70
CoD.WeaponLevelUpHeaderRight.__defaultHeight = 8
CoD.WeaponLevelUpHeaderRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpHeaderRight)
	self.id = "WeaponLevelUpHeaderRight"
	self.soundSet = "default"
	local HeaderSide = LUI.UIImage.new(0, 0, 0, 70, 0, 0, 0, 8)
	HeaderSide:setRGB(0, 0, 0)
	HeaderSide:setAlpha(0.5)
	HeaderSide:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	HeaderSide:setShaderVector(0, 0, 1, 0, 0)
	self:addElement(HeaderSide)
	self.HeaderSide = HeaderSide
	local HeaderArrow = LUI.UIImage.new(0, 0, 31, 39, 0, 0, 0, 8)
	HeaderArrow:setImage(RegisterImage(0xB402897EB8F521E))
	self:addElement(HeaderArrow)
	self.HeaderArrow = HeaderArrow
	self.HeaderArrow:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HeaderArrow:setRGB(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelUpHeaderRight.__onClose = function(f3_arg0)
	f3_arg0.HeaderArrow:close()
end
