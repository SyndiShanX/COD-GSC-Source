require("x64:247246d7126f06b")
require("x64:1ad5602d33a7c3a")
CoD.AmmoWidgetWZ_WeaponImage = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZ_WeaponImage.__defaultWidth = 164
CoD.AmmoWidgetWZ_WeaponImage.__defaultHeight = 50
CoD.AmmoWidgetWZ_WeaponImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetWZ_WeaponImage)
	self.id = "AmmoWidgetWZ_WeaponImage"
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
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0, 0, -164, 0, 0, 0, -44, 6)
	WeaponImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	WeaponImage:setShaderVector(0, 1, 0, 0, 0)
	WeaponImage:linkToElementModel(self, "weapon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			WeaponImage:setImage(RegisterImage(GetHudImageFromItemIndex(f4_local0)))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local HeroAbilityUseString = CoD.AmmoWidgetWZ_WeaponName.new(f1_arg0, f1_arg1, 0, 0, -127, 11, 0, 0, 0, 12)
	HeroAbilityUseString:linkToElementModel(self, "weapon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			HeroAbilityUseString.HeroAbilityUseString:setText(ConvertToUpperString(LocalizeHash(GetHudDisplayNameFromItemIndex(f5_local0))))
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
CoD.AmmoWidgetWZ_WeaponImage.__onClose = function(f6_arg0)
	f6_arg0.PowerWeaponDrainGadget3:close()
	f6_arg0.PowerWeaponDrainGadget2:close()
	f6_arg0.WeaponImage:close()
	f6_arg0.HeroAbilityUseString:close()
end
