require("x64:247246d7126f06b")
require("x64:729e84a5e6a8211")
CoD.AmmoWidget_WeaponImage = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_WeaponImage.__defaultWidth = 164
CoD.AmmoWidget_WeaponImage.__defaultHeight = 50
CoD.AmmoWidget_WeaponImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_WeaponImage)
	self.id = "AmmoWidget_WeaponImage"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local PowerWeaponDrainGadget3 = CoD.AmmoWidget_PowerWeaponDrain.new(f1_arg0, f1_arg1, 0, 0, -290, -125, 0, 0, -19.5, 41.5)
	PowerWeaponDrainGadget3:setAlpha(0)
	PowerWeaponDrainGadget3.Empty:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	PowerWeaponDrainGadget3.Fill2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	PowerWeaponDrainGadget3.Fill:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	PowerWeaponDrainGadget3.Fill3:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	PowerWeaponDrainGadget3:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget3", function(model)
		PowerWeaponDrainGadget3:setModel(model, f1_arg1)
	end)
	self:addElement(PowerWeaponDrainGadget3)
	self.PowerWeaponDrainGadget3 = PowerWeaponDrainGadget3
	local PowerWeaponDrainGadget2 = CoD.AmmoWidget_PowerWeaponDrain.new(f1_arg0, f1_arg1, 0, 0, -290, -125, 0, 0, -19.5, 41.5)
	PowerWeaponDrainGadget2:setAlpha(0)
	PowerWeaponDrainGadget2.Empty:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	PowerWeaponDrainGadget2.Fill2:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	PowerWeaponDrainGadget2.Fill:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	PowerWeaponDrainGadget2.Fill3:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	PowerWeaponDrainGadget2:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget2", function(model)
		PowerWeaponDrainGadget2:setModel(model, f1_arg1)
	end)
	self:addElement(PowerWeaponDrainGadget2)
	self.PowerWeaponDrainGadget2 = PowerWeaponDrainGadget2
	local GlowWeapon = LUI.UIImage.new(0, 0, -145, 28, 0, 0, -31.5, 54.5)
	GlowWeapon:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	GlowWeapon:setAlpha(0.12)
	GlowWeapon:setImage(RegisterImage(@"hash_1CC888FA4B192112"))
	GlowWeapon:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowWeapon)
	self.GlowWeapon = GlowWeapon
	local WeaponImage3 = LUI.UIFixedAspectRatioImage.new(0, 0, -122, -18, 0, 0, -15, 41)
	WeaponImage3:setAlpha(0)
	WeaponImage3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	WeaponImage3:setShaderVector(0, 1, 0, 0, 0)
	WeaponImage3:linkToElementModel(self, "weapon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			WeaponImage3:setImage(RegisterImage(GetHudImageFromItemIndex(f4_local0)))
		end
	end)
	self:addElement(WeaponImage3)
	self.WeaponImage3 = WeaponImage3
	local WeaponImage2 = LUI.UIFixedAspectRatioImage.new(0, 0, -122, -18, 0, 0, -15, 41)
	WeaponImage2:setAlpha(0.12)
	WeaponImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	WeaponImage2:setStretchedDimension(3)
	WeaponImage2:linkToElementModel(self, "weapon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			WeaponImage2:setImage(RegisterImage(GetHudImageFromItemIndex(f5_local0)))
		end
	end)
	self:addElement(WeaponImage2)
	self.WeaponImage2 = WeaponImage2
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0, 0, -122, -18, 0, 0, -15, 41)
	WeaponImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	WeaponImage:setShaderVector(0, 1, 0, 0, 0)
	WeaponImage:setStretchedDimension(4)
	WeaponImage:linkToElementModel(self, "weapon", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			WeaponImage:setImage(RegisterImage(GetHudImageFromItemIndex(f6_local0)))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local HeroAbilityUseString = CoD.AmmoWidget_WeaponName.new(f1_arg0, f1_arg1, 0, 0, -231, -111, 0, 0, -7.5, 4.5)
	HeroAbilityUseString:linkToElementModel(self, "weaponName", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			HeroAbilityUseString.HeroAbilityUseString:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f7_local0)))
		end
	end)
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_WeaponImage.__onClose = function(f8_arg0)
	f8_arg0.PowerWeaponDrainGadget3:close()
	f8_arg0.PowerWeaponDrainGadget2:close()
	f8_arg0.WeaponImage3:close()
	f8_arg0.WeaponImage2:close()
	f8_arg0.WeaponImage:close()
	f8_arg0.HeroAbilityUseString:close()
end
