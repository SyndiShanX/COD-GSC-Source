CoD.BM_Reserves_Charm = InheritFrom(LUI.UIElement)
CoD.BM_Reserves_Charm.__defaultWidth = 292
CoD.BM_Reserves_Charm.__defaultHeight = 351
CoD.BM_Reserves_Charm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_Reserves_Charm)
	self.id = "BM_Reserves_Charm"
	self.soundSet = "default"
	local WeaponBacking = LUI.UIImage.new(0.5, 0.5, -154, 154, 0, 0, 224.5, 352.5)
	WeaponBacking:setAlpha(0.02)
	self:addElement(WeaponBacking)
	self.WeaponBacking = WeaponBacking
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -165, 165, 0, 0, 224.5, 352.5)
	WeaponImage:setStretchedDimension(6)
	WeaponImage:linkToElementModel(self, "weaponRef", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponImage:setImage(CoD.BlackMarketUtility.GetMPItemPreviewImage(f2_local0))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local CharmImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -146, 146, 0, 0, 0, 224)
	CharmImage:setStretchedDimension(6)
	CharmImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CharmImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(CharmImage)
	self.CharmImage = CharmImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_Reserves_Charm.__onClose = function(f4_arg0)
	f4_arg0.WeaponImage:close()
	f4_arg0.CharmImage:close()
end
