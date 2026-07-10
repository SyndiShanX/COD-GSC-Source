CoD.ZMAmmoWidgetUtility = {}
CoD.ZMAmmoWidgetUtility.AmmoWidgetZMEquipedWeaponsListPipState = LuaEnum.createEnum("NO_WEAPON", "HAS_WEAPON", "HAS_EQUIPPED_WEAPON")
CoD.ZMAmmoWidgetUtility.HasPerk = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = Engine[@"hash_2D97229B24C685D5"](f1_arg1, f1_arg2)
	for f1_local1 = 0, CoD.ZMPerkUtility.PerkVaporCount - 1, 1 do
		local f1_local4 = DataSources.HUDItems.getModel(f1_arg0)
		f1_local4 = f1_local4["perkVapor." .. f1_local1]
		if f1_local4 and f1_local4.itemIndex and f1_local4.itemIndex:get() == f1_local0 and f1_local4.state:get() == CoD.ZMPerkUtility.PerkVaporStates.CONSUMED then
			return true
		end
	end
	for f1_local1 = 0, CoD.ZMPerkUtility.ExtraPerkVaporCount - 1, 1 do
		local f1_local4 = DataSources.HUDItems.getModel(f1_arg0)
		f1_local4 = f1_local4["extraPerkVapor." .. f1_local1]
		if f1_local4 and f1_local4.itemIndex and f1_local4.itemIndex:get() == f1_local0 and f1_local4.state:get() == CoD.ZMPerkUtility.PerkVaporStates.CONSUMED then
			return true
		end
	end
end
CoD.ZMAmmoWidgetUtility.GetHeldWeaponsUpdatedModel = function(f2_arg0)
	local f2_local0 = Engine[@"getmodelforcontroller"](f2_arg0)
	return f2_local0:create("heldWeaponsUpdated")
end
CoD.ZMAmmoWidgetUtility.GetHeldWeaponsList = function(f3_arg0, f3_arg1)
	local f3_local0 = Engine[@"getmodelforcontroller"](f3_arg0)
	local f3_local1 = f3_local0.heldWeapons
	local f3_local2 = {}
	for f3_local3 = 0, CoD.WeaponUtility.MaxHeldWeapons - 1, 1 do
		local f3_local6 = f3_local1[f3_local3 .. ""]
		if f3_local6 then
			local f3_local7 = f3_local6.weapon:get()
			if f3_local7 and f3_local7 > 0 then
				local f3_local8 = Engine[@"getloadoutslotforitem"](f3_local7)
				if f3_local8 == "primary" or f3_local8 == "secondary" then
					table.insert(f3_local2, f3_local7)
				end
			end
		end
	end
	return f3_local2
end
CoD.ZMAmmoWidgetUtility.WeaponsListHasWeapon = function(f4_arg0, f4_arg1)
	for f4_local3, f4_local4 in ipairs(f4_arg0) do
		if f4_arg1 == f4_local4 then
			return f4_local3
		end
	end
end
DataSources.AmmoWidgetZMEquippedWeaponsList = DataSourceHelpers.CustomListSetup("AmmoWidgetZMEquippedWeaponsList", function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = 2
	if CoD.ZMAmmoWidgetUtility.HasPerk(f5_arg1, @"perk_additional_primary_weapon", Enum[@"emodes"][@"mode_zombies"]) then
		f5_local0 = 3
	end
	local f5_local1 = CoD.ZMAmmoWidgetUtility.GetHeldWeaponsList(f5_arg1, f5_local0)
	for f5_local2 = 1, f5_local0, 1 do
		local f5_local5 = f5_arg2:create(f5_local2 .. "")
		f5_local5 = f5_local5:create("state")
		local f5_local6 = f5_arg2:create(f5_local2 .. "")
		f5_local6 = f5_local6:create("weapon")
		if not f5_local5:get() then
			f5_local5:set(CoD.ZMAmmoWidgetUtility.AmmoWidgetZMEquipedWeaponsListPipState.NO_WEAPON)
		end
		if f5_local6:get() and not CoD.ZMAmmoWidgetUtility.WeaponsListHasWeapon(f5_local1, f5_local6:get()) then
			f5_local5:set(CoD.ZMAmmoWidgetUtility.AmmoWidgetZMEquipedWeaponsListPipState.NO_WEAPON)
			f5_local6:set(0)
		end
		table.insert(f5_arg3, {
			model = f5_local5,
		})
	end
	local f5_local2 = function(f6_arg0)
		for f6_local0 = 1, f5_local0, 1 do
			local f6_local3 = f5_arg2:create(f6_local0 .. "")
			f6_local3 = f6_local3:create("state")
			local f6_local4 = f5_arg2:create(f6_local0 .. "")
			f6_local4 = f6_local4:create("weapon")
			if f6_local4:get() == f6_arg0 then
				return f6_local0
			end
		end
		for f6_local0 = 1, f5_local0, 1 do
			local f6_local3 = f5_arg2:create(f6_local0 .. "")
			f6_local3 = f6_local3:create("state")
			local f6_local4 = f5_arg2:create(f6_local0 .. "")
			f6_local4 = f6_local4:create("weapon")
			if f6_local3:get() == CoD.ZMAmmoWidgetUtility.AmmoWidgetZMEquipedWeaponsListPipState.NO_WEAPON or not f6_local4:get() or f6_local4:get() == 0 then
				return f6_local0
			elseif f6_local4:get() and not CoD.ZMAmmoWidgetUtility.WeaponsListHasWeapon(f5_local1, f6_local4:get()) then
				return f6_local0
			end
		end
	end
	for f5_local5, f5_local6 in ipairs(f5_local1) do
		local f5_local10 = f5_local2(f5_local6)
		if f5_local10 then
			local f5_local8 = f5_arg2:create(f5_local10 .. "")
			f5_local8 = f5_local8:create("state")
			local f5_local9 = f5_arg2:create(f5_local10 .. "")
			f5_local9 = f5_local9:create("weapon")
			if not f5_local9:get() or f5_local9:get() == 0 then
				f5_local9:set(f5_local6)
			end
			f5_local8:set(CoD.ZMAmmoWidgetUtility.AmmoWidgetZMEquipedWeaponsListPipState.HAS_WEAPON)
			if f5_local5 == 1 then
				f5_local8:set(CoD.ZMAmmoWidgetUtility.AmmoWidgetZMEquipedWeaponsListPipState.HAS_EQUIPPED_WEAPON)
			end
		end
	end
	if f5_arg0.__weaponChangedSubcription then
		f5_arg0:removeSubscription(f5_arg0.__weaponChangedSubcription)
	end
	f5_arg0.__weaponChangedSubcription = f5_arg0:subscribeToModel(CoD.ZMAmmoWidgetUtility.GetHeldWeaponsUpdatedModel(f5_arg1), function()
		f5_arg0:updateDataSource()
	end, false)
	if f5_arg0.__numWeaponSlotsChangedSubscription then
		f5_arg0:removeSubscription(f5_arg0.__numWeaponSlotsChangedSubscription)
	end
	f5_local3 = Engine[@"getmodelforcontroller"](f5_arg1)
	f5_arg0.__numWeaponSlotsChangedSubscription = f5_arg0:subscribeToModel(f5_local3:create("PerkVaporStateUpdated"), function()
		f5_arg0:updateDataSource()
	end, false)
end)
