require("x64:c71b3cf9012e5dd")
local f0_local0 = {
	LootIndexTable = {},
}
f0_local0.LootIndexTable.name = 0xFBBF46E0C82BC10
f0_local0.LootIndexTable.name_2 = 0xB18A941FE6183B9
f0_local0.LootIndexTable.COL_NAMEHASH = 0
f0_local0.LootIndexTable.COL_ID = 1
f0_local0.LootIndexTable.COL_TABLE_TYPE = 2
f0_local0.LootIndexTable.COL_BUNDLES = 3
f0_local0.LootIndexTable.COL_DROP = 4
f0_local0.LootIndexTable.COL_SEASON = 5
f0_local0.LootIndexTable.COL_ITEM_TYPE = 6
f0_local0.LootIndexTable.COL_SET = 7
f0_local0.LootBonusTable = {}
f0_local0.LootBonusTable.name = 0x30CAA8686798E2B
f0_local0.LootBonusTable.COL_NAMEHASH = 0
f0_local0.LootBonusTable.COL_TYPE = 1
f0_local0.LootBonusTable.COL_SET = 2
f0_local0.LootBonusTable.COL_MINIMUMTARGET = 3
f0_local0.LootBonusTable.COL_TOTAL = 4
f0_local0.LootBonusTable.COL_STRINGREF = 5
f0_local0.LootBonusTable.COL_RARITY = 6
f0_local0.DefaultUnlockedLootTable = {
	[@"ar_galil_t8"] = {
		Enum[@"emodes"][@"mode_zombies"],
		Enum[@"emodes"][@"mode_warzone"],
	},
}
f0_local0.ItemOwnedValue = 1
f0_local0.ItemNewValue = 1
f0_local0.BribeOpenedIds = {
	"500580",
	"500660",
	"500774",
	"500862",
	"500578",
	"500510",
	"500533",
}
f0_local0.NonLootItemIds = {
	"599996",
	"500163",
}
f0_local0.UpdateLootOwnedForItem = function(f1_arg0, f1_arg1)
	for f1_local3, f1_local4 in pairs(f0_local0.BribeOpenedIds) do
		if f1_local4 == f1_arg1 then
			return
		end
	end
	for f1_local3, f1_local4 in pairs(f0_local0.NonLootItemIds) do
		if f1_local4 == f1_arg1 then
			return
		end
	end
	f1_local0 = f0_local0.GetItemNameHashFromLootId(f1_arg1)
	f1_local1 = f0_local0.GetLootItemCategory(f1_arg1)
	if f1_local0 and f1_local1 then
		f1_local2 = Engine[@"getmodelforcontroller"](f1_arg0)
		f1_local2 = f1_local2:create("Breadcrumbs.startMenu")
		f1_local3 = Engine[@"storagegetbuffer"](f1_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		if f1_local3 then
			if f1_local1 == @"calling_card" then
				f1_local4 = CoDShared.GetCallingCardIdFromImage(f1_local0)
				if f1_local4 and f1_local3[@"hash_1D45B221DEE76EE4"] and f1_local3[@"hash_1D45B221DEE76EE4"][f1_local4] then
					f1_local3[@"hash_1D45B221DEE76EE4"][f1_local4]:set(f0_local0.ItemOwnedValue)
				end
				local f1_local5 = f0_local0.GetLootItemSetName(f1_local0)
				if f1_local5 and f1_local5 ~= 0x0 then
					local f1_local6 = f0_local0.GetUnlockedSetBonusItem(f1_arg0, f1_local5)
					if f1_local6 then
						local f1_local7 = CoDShared.GetSetBonusCallingCardIdFromImage(f1_local6)
						if f1_local7 and f1_local3[@"hash_1D45B221DEE76EE4"] and f1_local3[@"hash_1D45B221DEE76EE4"][f1_local7] then
							f1_local3[@"hash_1D45B221DEE76EE4"][f1_local7]:set(f0_local0.ItemOwnedValue)
						end
					end
				end
				if f1_local2 then
					local f1_local6 = f1_local2:create("callingCardInventoryUpdated")
					f1_local6:set(true)
				end
			elseif f1_local1 == @"sticker" then
				f1_local4 = CoDShared.GetEmblemIdFromImage(f1_local0)
				if f1_local4 and f1_local3[@"icon_owned"] and f1_local3[@"icon_owned"][f1_local4] then
					f1_local3[@"icon_owned"][f1_local4]:set(f0_local0.ItemOwnedValue)
				end
				local f1_local5 = f0_local0.GetLootItemSetName(f1_local0)
				if f1_local5 and f1_local5 ~= 0x0 then
					local f1_local6 = f0_local0.GetUnlockedSetBonusItem(f1_arg0, f1_local5)
					if f1_local6 then
						local f1_local7 = CoDShared.GetEmblemIdFromImage(f1_local6)
						if f1_local7 and f1_local3[@"icon_owned"] and f1_local3[@"icon_owned"][f1_local7] then
							f1_local3[@"icon_owned"][f1_local7]:set(f0_local0.ItemOwnedValue)
						end
					end
				end
				if f1_local2 then
					local f1_local6 = f1_local2:create("emblemInventoryUpdated")
					f1_local6:set(true)
				end
			end
		end
		if f1_local2 then
			if not f1_local2.inventoryUpdated then
				f1_local2:create("inventoryUpdated")
			end
			f1_local2.inventoryUpdated:set(true)
		end
	end
end
f0_local0.GetItemNameHashFromLootId = function(f2_arg0)
	local f2_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name, f0_local0.LootIndexTable.COL_NAMEHASH, f0_local0.LootIndexTable.COL_ID, f2_arg0)
	if not f2_local0 or f2_local0 == 0x0 then
		f2_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name_2, f0_local0.LootIndexTable.COL_NAMEHASH, f0_local0.LootIndexTable.COL_ID, f2_arg0)
	end
	return f2_local0 or 0x0
end
f0_local0.GetItemLootIdFromNameHash = function(f3_arg0)
	local f3_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name, f0_local0.LootIndexTable.COL_ID, f0_local0.LootIndexTable.COL_NAMEHASH, f3_arg0)
	if not f3_local0 or f3_local0 == "" then
		f3_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name_2, f0_local0.LootIndexTable.COL_ID, f0_local0.LootIndexTable.COL_NAMEHASH, f3_arg0)
	end
	return f3_local0 or ""
end
f0_local0.GetLootItemCategory = function(f4_arg0)
	local f4_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name, f0_local0.LootIndexTable.COL_ITEM_TYPE, f0_local0.LootIndexTable.COL_ID, f4_arg0)
	if not f4_local0 or f4_local0 == 0x0 then
		f4_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name_2, f0_local0.LootIndexTable.COL_ITEM_TYPE, f0_local0.LootIndexTable.COL_ID, f4_arg0)
	end
	return f4_local0 or 0x0
end
f0_local0.GetLootItemSetName = function(f5_arg0)
	local f5_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name, f0_local0.LootIndexTable.COL_SET, f0_local0.LootIndexTable.COL_NAMEHASH, f5_arg0)
	if not f5_local0 or f5_local0 == 0x0 then
		f5_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name_2, f0_local0.LootIndexTable.COL_SET, f0_local0.LootIndexTable.COL_NAMEHASH, f5_arg0)
	end
	return f5_local0 or 0x0
end
f0_local0.GetLootItemLootType = function(f6_arg0)
	local f6_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name, f0_local0.LootIndexTable.COL_TABLE_TYPE, f0_local0.LootIndexTable.COL_ID, f6_arg0)
	if not f6_local0 or f6_local0 == 0x0 then
		f6_local0 = Engine[0x6ED59F41A5B1CC](f0_local0.LootIndexTable.name_2, f0_local0.LootIndexTable.COL_TABLE_TYPE, f0_local0.LootIndexTable.COL_ID, f6_arg0)
	end
	if f6_local0 == @"season" then
		return LuaEnum.LOOT_TYPE.SEASON
	elseif f6_local0 == @"contraband" then
		return LuaEnum.LOOT_TYPE.CONTRABAND
	elseif f6_local0 == @"contract" then
		return LuaEnum.LOOT_TYPE.CONTRACT
	elseif f6_local0 == @"hash_731315EF3FB1AE07" then
		return LuaEnum.LOOT_TYPE.ITEMSHOP
	elseif f6_local0 == @"bundles" then
		return LuaEnum.LOOT_TYPE.BUNDLE
	else
		return LuaEnum.LOOT_TYPE.EMPTY
	end
end
f0_local0.GetUnlockedSetBonusItem = function(f7_arg0, f7_arg1)
	if f0_local0.IsBonusSetUnlocked(f7_arg0, f7_arg1) then
		return Engine[0x6ED59F41A5B1CC](f0_local0.LootBonusTable.name, f0_local0.LootBonusTable.COL_NAMEHASH, f0_local0.LootBonusTable.COL_SET, f7_arg1)
	else
	end
end
f0_local0.IsBonusSetUnlocked = function(f8_arg0, f8_arg1)
	local f8_local0 = f0_local0.GetBonusSetMinimumTarget(f8_arg1)
	if f8_local0 <= 0 then
		return true
	else
		local f8_local1, f8_local2 = f0_local0.GetNumberOwnedAndAvailableOfSet(f8_arg0, f8_arg1)
		return f8_local0 <= f8_local1
	end
end
f0_local0.GetBonusSetMinimumTarget = function(f9_arg0)
	local f9_local0 = Engine[@"tablefindrows"](f0_local0.LootBonusTable.name, f0_local0.LootBonusTable.COL_SET, f9_arg0)
	if f9_local0 and #f9_local0 > 0 then
		return Engine[@"hash_4C6F8EC444864600"](f0_local0.LootBonusTable.name, f9_local0[1], f0_local0.LootBonusTable.COL_MINIMUMTARGET)
	else
		return 0
	end
end
f0_local0.GetNumberOwnedAndAvailableOfSet = function(f10_arg0, f10_arg1)
	local f10_local0 = 0
	local f10_local1 = 0
	local f10_local2 = Engine[@"tablefindrows"](f0_local0.LootIndexTable.name, f0_local0.LootIndexTable.COL_SET, f10_arg1)
	local f10_local3 = f0_local0.LootIndexTable.name
	if not f10_local2 or f10_local2 == 0 then
		f10_local2 = Engine[@"tablefindrows"](f0_local0.LootIndexTable.name_2, f0_local0.LootIndexTable.COL_SET, f10_arg1)
		f10_local3 = f0_local0.LootIndexTable.name_2
	end
	for f10_local4 = 1, #f10_local2, 1 do
		if 0 < Engine[@"hash_34509DFCBC7BC5CE"](f10_arg0, Engine[@"hash_4C6F8EC444864600"](f10_local3, f10_local2[f10_local4], f0_local0.LootIndexTable.COL_ID)) then
			f10_local0 = f10_local0 + 1
		end
	end
	return f10_local0, math.max(#f10_local2 - 1, 0)
end
CoDLootShared = LuaReadOnlyTables.ReadOnlyTable(f0_local0)
