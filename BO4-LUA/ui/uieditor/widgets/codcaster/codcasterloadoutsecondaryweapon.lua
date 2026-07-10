require("x64:3312cee82b37227")
CoD.CodCasterLoadoutSecondaryWeapon = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutSecondaryWeapon.__defaultWidth = 112
CoD.CodCasterLoadoutSecondaryWeapon.__defaultHeight = 76
CoD.CodCasterLoadoutSecondaryWeapon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(true)
	self:setClass(CoD.CodCasterLoadoutSecondaryWeapon)
	self.id = "CodCasterLoadoutSecondaryWeapon"
	self.soundSet = "none"
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 4, 67)
	BG:setRGB(0, 0, 0)
	BG:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BG)
	self.BG = BG
	local WeaponBackground = LUI.UIImage.new(0, 0, 0, 112, 0, 0, 0, 76)
	WeaponBackground:setImage(RegisterImage(0x585023D9CCFF746))
	self:addElement(WeaponBackground)
	self.WeaponBackground = WeaponBackground
	local GlowWeapon = LUI.UIImage.new(0, 0, -18, 155, 0, 0, -5, 81)
	GlowWeapon:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	GlowWeapon:setAlpha(0.26)
	GlowWeapon:setImage(RegisterImage(0xCC888FA4B192112))
	GlowWeapon:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowWeapon)
	self.GlowWeapon = GlowWeapon
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0, 0, 9.5, 102.5, 0, 0, 9.5, 66.5)
	FixedAspectRatioImage:setScale(0.8, 0.8)
	FixedAspectRatioImage:subscribeToGlobalModel(f1_arg1, "PerController", "secondaryWeapon.item", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(CoD.CodCasterUtility.GetSecondaryWeaponImage(f1_arg1, f2_local0)))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local CodCasterLoadoutSelection = CoD.CodCasterLoadoutSelectionSecond.new(f1_arg0, f1_arg1, 0.5, 0.5, -57, 57, 0.5, 0.5, -40, 36)
	CodCasterLoadoutSelection:setAlpha(0)
	self:addElement(CodCasterLoadoutSelection)
	self.CodCasterLoadoutSelection = CodCasterLoadoutSelection
	self:subscribeToGlobalModel(f1_arg1, "PerController", "secondaryWeapon.indexIndex", function(model)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weapon", function(model)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "CodCaster.profileSettingsUpdated", function(model)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutSecondaryWeapon.__onClose = function(f6_arg0)
	f6_arg0.FixedAspectRatioImage:close()
	f6_arg0.CodCasterLoadoutSelection:close()
end
