CoD.WeaponUtility = {}
CoD.WeaponUtility.WeaponIsSegmentedReloadResult = {}
CoD.WeaponUtility.WeaponUsesAmmoResult = {}
CoD.WeaponUtility.WeaponRefUsesAmmoResult = {}
CoD.WeaponUtility.WeaponRefIsClipOnlyResult = {}
CoD.WeaponUtility.MaxHeldWeapons = 15
CoD.WeaponUtility.CurrentWeaponIsSegmentedReload = function(f1_arg0)
	local f1_local0 = Engine[0x4DF5CFBC1771947](f1_arg0)
	local f1_local1 = DataSources.CurrentWeapon.getModel(f1_arg0)
	f1_local1 = f1_local1.weapon:get()
	if f1_local1 ~= nil and CoD.WeaponUtility.WeaponIsSegmentedReloadResult[f1_local1] == nil then
		CoD.WeaponUtility.WeaponIsSegmentedReloadResult[f1_local1] = Engine[0x64187036D5BBB3E](Engine[0xB98952F69D937F9](f1_local1))
	end
	return CoD.WeaponUtility.WeaponIsSegmentedReloadResult[f1_local1]
end
CoD.WeaponUtility.WeaponUsesAmmoInternal = function(f2_arg0, f2_arg1)
	local f2_local0 = 0x0
	if f2_arg1 == nil then
		return false
	elseif f2_arg1 == 0 then
		f2_local0 = CoD.SafeGetModelValue(f2_arg0, "equippedWeaponReference")
		if f2_local0 then
			local f2_local1 = Engine[0x6277892F01D31E9](f2_local0)
		end
		f2_local0 = f2_local1 or 0x0
	else
		f2_local0 = Engine[0xB98952F69D937F9](f2_arg1)
	end
	if (CoD.isZombie or CoD.isWarzone) and Engine[0xE57FCFF3F3FB7AE](f2_local0) then
		return false
	else
		local f2_local2
		if not Engine[0x68981188BC3B5D9](f2_local0, "melee") and not Engine[0x68981188BC3B5D9](f2_local0, "riotshield") then
			f2_local2 = not Engine[0x68981188BC3B5D9](f2_local0, "grenade")
		else
			f2_local2 = false
		end
	end
	return f2_local2
end
CoD.WeaponUtility.CurrentWeaponUsesAmmo = function(f3_arg0)
	local f3_local0 = Engine[0x4DF5CFBC1771947](f3_arg0)
	local f3_local1 = DataSources.CurrentWeapon.getModel(f3_arg0)
	local f3_local2 = f3_local1.weapon:get()
	if f3_local2 ~= nil and CoD.WeaponUtility.WeaponUsesAmmoResult[f3_local2] == nil then
		CoD.WeaponUtility.WeaponUsesAmmoResult[f3_local2] = CoD.WeaponUtility.WeaponUsesAmmoInternal(f3_local1, f3_local2)
	end
	return CoD.WeaponUtility.WeaponUsesAmmoResult[f3_local2]
end
CoD.WeaponUtility.CurrentZMWeaponUsesAmmo = function(f4_arg0)
	local f4_local0 = Engine[0x4DF5CFBC1771947](f4_arg0)
	local f4_local1 = DataSources.CurrentWeapon.getModel(f4_arg0)
	local f4_local2 = f4_local1.equippedWeaponReference:get()
	if f4_local2 ~= nil and CoD.WeaponUtility.WeaponRefUsesAmmoResult[f4_local2] == nil then
		CoD.WeaponUtility.WeaponRefUsesAmmoResult[f4_local2] = not Engine[0xE57FCFF3F3FB7AE](Engine[0x6277892F01D31E9](f4_local2))
	end
	return CoD.WeaponUtility.WeaponRefUsesAmmoResult[f4_local2]
end
CoD.WeaponUtility.CurrentZMWeaponIsClipOnlyAmmo = function(f5_arg0)
	return f5_local1.isClipOnly and f5_local1.isClipOnly:get()
end
CoD.WeaponUtility.ShouldHidePickupsForThirdPersonWeapon = function(f6_arg0)
	return Engine[0xAC255C64518F89E](f6_arg0)
end
