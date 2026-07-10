CoD.WZUtility = {}
CoD.WZUtility.TeamPlayerColor = {
	"WarzoneTeammate1",
	"WarzoneTeammate2",
	"WarzoneTeammate3",
	"WarzoneTeammate4",
	"WarzoneTeammate5",
}
CoD.WZUtility.PlayerStatusIcon = {
	[Enum[@"hash_14A07561A78E340B"][@"hash_38D80055B4F13E0F"]] = @"blacktransparent",
	[Enum[@"hash_14A07561A78E340B"][@"hash_358F9A363F8FBB07"]] = @"ui_icon_disconnect",
	[Enum[@"hash_14A07561A78E340B"][@"hash_59E50BB255808BF"]] = @"blacktransparent",
	[Enum[@"hash_14A07561A78E340B"][@"hash_7751743BBF671EDC"]] = @"blacktransparent",
	[Enum[@"hash_14A07561A78E340B"][@"hash_9BD8FECA6158847"]] = @"ui_icon_bleedout",
	[Enum[@"hash_14A07561A78E340B"][@"hash_3C233F1FA9F35C02"]] = @"ui_icon_dead",
}
CoD.WZUtility.PlayerStatusClientScriptState = {
	[Enum[@"hash_14A07561A78E340B"][@"hash_9BD8FECA6158847"]] = @"last_stand",
	[Enum[@"hash_14A07561A78E340B"][@"hash_3C233F1FA9F35C02"]] = @"dead",
}
CoD.WZUtility.InventoryItem = {
	INVENTORY_ITEM_NONE = 32767,
}
CoD.WZUtility.InventorySize = {
	ITEM_WORLD_PLAYER_INVENTORY_SIZE = 5,
	ITEM_WORLD_PLAYER_INVENTORY_SIZE_BACKPACK = 10,
}
CoD.WZUtility.DeathZoneState = {
	ZONE_ONLINE = 0,
	ZONE_WARNING = 1,
	ZONE_OFFLINE = 2,
	ZONE_HIDDEN = 4,
}
CoD.WZUtility.CollapseTimerState = LuaEnum.createEnum("OFF", "WARNING", "COLLAPSING")
CoD.WZUtility.ItemAvailableAction = LuaEnum.createEnum("NONE", "EQUIP", "ATTACH", "SWAP", "CONSUME", "DISCARD", "REPAIR")
CoD.WZUtility.InventoryNag = {
	NAG_NOT_SEEN = 0,
	NAG_VISIBLE = 1,
	NAG_DISMISSED = 2,
}
CoD.WZUtility.ArmorFlipbookFrames = 10
CoD.WZUtility.SeaLevelAltitude = 984
CoD.WZUtility.ObjectiveStates = {
	IN_PROGRESS = 0,
	COMPLETED = 1,
	FAILED = 2,
}
CoD.WZUtility.QuestItemUpdateTypes = {
	CHARACTER_UNLOCK_UPDATE_STATE = 0,
	CHARACTER_UNLOCK_UPDATE_ALREADY_COMPLETED = 1,
}
CoD.WZUtility.ArmorAssetList = {
	@"armor_item_large",
	@"armor_item_medium",
	@"armor_item_small",
}
CoD.WZUtility.DisableZoomIn = {}
CoD.WZUtility.DisableZoomOut = {}
CoD.WZUtility.WZPersonalizeGroupNames = {
	{
		index = 1,
		weapon_category = "weapon_assault",
		name = @"hash_7FE1B0B2003A6CC1",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_assault"],
		loadoutType = "primary",
		minUnlockableCount = 0,
	},
	{
		index = 2,
		weapon_category = "weapon_smg",
		name = @"hash_35A1E94F52AC6DAB",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_smg"],
		loadoutType = "primary",
		minUnlockableCount = 0,
	},
	{
		index = 3,
		weapon_category = "weapon_tactical",
		name = @"hash_1FB38D2633FBBEC7",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_tactical"],
		loadoutType = "primary",
		minUnlockableCount = 0,
	},
	{
		index = 4,
		weapon_category = "weapon_lmg",
		name = @"hash_6DB6F169E46CD4E4",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_lmg"],
		loadoutType = "primary",
		minUnlockableCount = 0,
	},
	{
		index = 5,
		weapon_category = "weapon_sniper",
		name = @"hash_2EF865AD574F5FAD",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_sniper"],
		loadoutType = "primary",
		minUnlockableCount = 0,
	},
	{
		index = 6,
		weapon_category = "weapon_cqb",
		name = @"hash_72584C59DF32630E",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_cqb"],
		loadoutType = "primary",
		minUnlockableCount = 0,
	},
	{
		index = 7,
		weapon_category = "weapon_pistol",
		name = @"hash_31F931942007CAB9",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_pistol"],
		loadoutType = "secondary",
		minUnlockableCount = 0,
	},
	{
		index = 8,
		weapon_category = "weapon_launcher",
		name = @"hash_3FB45C2314396720",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_launchers"],
		loadoutType = "secondary",
		minUnlockableCount = 0,
	},
	{
		index = 9,
		weapon_category = "weapon_knife",
		name = @"hash_28180FA72D55F45B",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_knife"],
		loadoutType = "secondary",
		minUnlockableCount = 3,
	},
	{
		index = 10,
		weapon_category = "weapon_special",
		name = @"hash_63A21A8AF3E42CDD",
		itemGroup = Enum[@"itemgroup_t"][@"itemgroup_special"],
		loadoutType = "secondary",
		minUnlockableCount = 0,
	},
}
local f0_local0 = CoD.WZUtility
local f0_local1 = {
	@"ar_accurate_t8",
	@"ar_damage_t8",
	@"ar_fastfire_t8",
	@"ar_galil_t8",
	@"ar_modular_t8",
	@"ar_peacekeeper_t8",
	@"ar_standard_t8",
	@"ar_stealth_t8",
	@"ar_an94_t8",
	@"ar_doublebarrel_t8",
	@"smg_accurate_t8",
	@"smg_capacity_t8",
	@"smg_fastburst_t8",
	@"smg_fastfire_t8",
	@"smg_handling_t8",
	@"smg_mp40_t8",
	@"smg_standard_t8",
	@"smg_folding_t8",
	@"smg_vmp_t8",
	@"smg_minigun_t8",
	@"tr_longburst_t8",
	@"tr_midburst_t8",
	@"tr_powersemi_t8",
	@"tr_leveraction_t8",
	@"tr_flechette_t8",
	@"tr_damageburst_t8",
	@"lmg_heavy_t8",
	@"lmg_spray_t8",
	@"lmg_standard_t8",
	@"lmg_double_t8",
	@"lmg_stealth_t8",
	@"sniper_fastrechamber_t8",
	@"sniper_locus_t8",
	@"sniper_powerbolt_t8",
	@"sniper_powersemi_t8",
	@"sniper_quickscope_t8",
	@"sniper_mini14_t8",
	@"sniper_damagesemi_t8",
	@"shotgun_pump_t8",
	@"shotgun_semiauto_t8",
	@"shotgun_fullauto_t8",
	@"shotgun_precision_t8",
	@"pistol_burst_t8",
	@"pistol_fullauto_t8",
	@"pistol_revolver_t8",
	@"pistol_standard_t8",
	@"launcher_standard_t8",
	@"melee_club_t8",
	@"melee_coinbag_t8",
	@"melee_cutlass_t8",
}
local f0_local2 = @"melee_demohammer_t8"
local f0_local3 = @"melee_secretsanta_t8"
local f0_local4 = @"melee_slaybell_t8"
local f0_local5 = @"melee_zombiearm_t8"
local f0_local6 = @"melee_stopsign_t8"
local f0_local7 = @"melee_actionfigure_t8"
local f0_local8 = @"melee_amuletfist_t8"
local f0_local9 = @"special_crossbow_t8"
f0_local1[33] = f0_local2
f0_local1[34] = f0_local3
f0_local1[35] = f0_local4
f0_local1[36] = f0_local5
f0_local1[37] = f0_local6
f0_local1[38] = f0_local7
f0_local1[39] = f0_local8
f0_local1[40] = f0_local9
f0_local0.WZPersonalizeWeaponNames = f0_local1
CoD.WZUtility.WZDLC1WeaponNames = {
	@"ar_standard_t8",
	@"smg_fastburst_t8",
	@"pistol_fullauto_t8",
}
CoD.WZUtility.GetWZLevel = function(f1_arg0)
	if tonumber(CoD.PrestigeUtility.GetMaxRankByMode(Enum[@"emodes"][@"mode_warzone"])) + 1 <= tonumber(f1_arg0) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_54008CE61FE52DCD")
	else
		return tostring(f1_arg0)
	end
end
CoD.WZUtility.SetInventoryIsOpen = function(f2_arg0, f2_arg1)
	local f2_local0 = DataSources.WarzoneInventory.getModel(f2_arg0)
	f2_local0.isOpen:set(f2_arg1)
end
CoD.WZUtility.SendInventoryNotify = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5)
	local f3_local0 = {}
	local f3_local1 = f3_arg1:getModel()
	f3_local0.id = f3_local1.id:get()
	f3_local1 = DataSources.WarzoneInventory.getModel(f3_arg0)
	f3_local0.selectedIndex = f3_local1.selectedIndex:get()
	f3_local0.extraArg = f3_arg3
	f3_local0.extraArg2 = f3_arg4
	SendCustomClientScriptNotifyForAdjustedClient(f3_arg0, f3_arg2, f3_local0)
	if CoD.isPC then
		f3_local1 = f3_arg1:getMenu()
		if f3_local1 then
			if not f3_arg5 or not f3_local1.__firstTooltipUpdateDoneWZ then
				CoD.WZUtility.UpdateWZInventoryTooltipOnElementWithTimerPC(f3_arg0, f3_arg1, f3_arg5)
			end
			f3_local1.__firstTooltipUpdateDoneWZ = true
		end
	end
end
CoD.WZUtility.SendInventoryPickUpNotifyInternal = function(f4_arg0, f4_arg1, f4_arg2)
	if f4_arg1 and not CoD.SafeGetModelValue(f4_arg1, "isDummy") and not CoD.SafeGetModelValue(f4_arg1, "collapsed") then
		local f4_local0 = DataSources.WarzoneInventory.getModel(f4_arg0)
		local f4_local1 = f4_local0.selectedIndex:get()
		local f4_local2 = CoD.SafeGetModelValue(f4_local0, "item" .. f4_local1 .. ".id")
		if f4_arg1.claimsInventorySlot and f4_arg1.claimsInventorySlot:get() ~= 0 and f4_local2 ~= nil and f4_local2 ~= CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE then
			local f4_local3 = f4_local0.firstFreeSlot:get()
			if f4_local3 ~= -1 then
				f4_local1 = f4_local3
			else
				SendCustomClientScriptNotifyForAdjustedClient(f4_arg0, "inventory_drop", {
					id = f4_local2,
					selectedIndex = f4_local1,
				})
			end
		end
		local f4_local3 = "multi_item_pickup"
		if f4_arg2 then
			f4_local3 = "multi_item_pickup_stowed_weapon"
		end
		SendCustomClientScriptNotifyForAdjustedClient(f4_arg0, f4_local3, {
			id = f4_arg1.id:get(),
			selectedIndex = f4_local1,
		})
	end
end
CoD.WZUtility.SendInventoryPickUpNotify = function(f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1:getModel()
	if f5_local0 then
		CoD.WZUtility.SendInventoryPickUpNotifyInternal(f5_arg0, f5_local0, false)
	end
end
CoD.WZUtility.SendInventoryPickUpStowedWeaponNotify = function(f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1:getModel()
	if f6_local0 then
		CoD.WZUtility.SendInventoryPickUpNotifyInternal(f6_arg0, f6_local0, true)
	end
end
CoD.WZUtility.SendInventoryAttachmentPickUpNotify = function(f7_arg0)
	SendCustomClientScriptNotifyForAdjustedClient(f7_arg0, "attachment_pickup")
end
CoD.WZUtility.LastPickUpFirstFrameNumber = -1
CoD.WZUtility.SendInventoryPickUpFirstNotify = function(f8_arg0, f8_arg1)
	local f8_local0 = Engine[@"hash_4C60FB88F484616D"]()
	if f8_local0 == CoD.WZUtility.LastPickUpFirstFrameNumber then
		return
	end
	CoD.WZUtility.LastPickUpFirstFrameNumber = f8_local0
	local f8_local1 = f8_arg1:getModel()
	if f8_local1 == nil or f8_local1.id:get() == CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE then
		local f8_local2 = DataSources.MultiItemPickup.getModel(f8_arg0)
		local f8_local3 = f8_local2.count:get()
		for f8_local4 = 1, f8_local3, 1 do
			f8_local1 = Engine[@"getmodel"](f8_local2, "item" .. f8_local4 - 1)
			local f8_local7 = CoD.SafeGetModelValue(f8_local1, "id")
			if f8_local7 ~= nil and f8_local7 ~= CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE then
				CoD.WZUtility.SendInventoryPickUpNotifyInternal(f8_arg0, f8_local1, false)
			end
		end
	else
		CoD.WZUtility.SendInventoryPickUpNotifyInternal(f8_arg0, f8_local1, false)
	end
end
CoD.WZUtility.CloseMultiItemPickup = function(f9_arg0)
	if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f9_arg0, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"]) then
		Engine[@"sendmenuresponse"](f9_arg0, @"multiitempickup", @"multi_item_menu_closed", 0)
	end
end
CoD.WZUtility.InitWZLoadingFractionUpdate = function(f10_arg0, f10_arg1)
	local f10_local0 = DataSources.LoadingScreenTeamInfo.getModel(f10_arg1)
	f10_local0 = f10_local0.wzLoadedFraction
	local f10_local1 = function(f11_arg0, f11_arg1)
		f10_local0:set(0.7 * f11_arg0 + 0.3 * f11_arg1)
	end
	local f10_local2 = DataSources.LoadingScreenTeamInfo.getModel(0)
	f10_local2 = f10_local2.loadedFraction
	local f10_local3 = DataSources.HUDItems.getModel(f10_arg1)
	f10_local3 = f10_local3.streamerLoadFraction
	f10_arg0:subscribeToGlobalModel(f10_arg1, "LoadingScreenTeamInfo", "loadedFraction", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			f10_local1(f12_local0, f10_local3:get())
		end
	end)
	f10_arg0:subscribeToGlobalModel(f10_arg1, "HUDItems", "streamerLoadFraction", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			f10_local1(f10_local2:get(), f13_local0)
		end
	end)
end
CoD.WZUtility.SendInventoryEquipNotify = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	CoD.WZUtility.SendInventoryNotify(f14_arg0, f14_arg1, "inventory_equip", f14_arg3)
	local f14_local0 = CoD.SafeGetModelValue(f14_arg1:getModel(), "availableAction")
	if f14_local0 == CoD.WZUtility.ItemAvailableAction.REPAIR or f14_local0 == CoD.WZUtility.ItemAvailableAction.CONSUME and CoD.SafeGetModelValue(f14_arg1:getModel(), "type") ~= "killstreak" then
		Engine[@"hash_27CD221DF1911DD1"](f14_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end
	if f14_arg3 then
		CoD.WZUtility.ResetQuickInventoryAutoCloseTimer(f14_arg2, f14_arg0)
	end
end
CoD.WZUtility.SendInventoryEquipOnWeaponNotify = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4)
	CoD.WZUtility.SendInventoryNotify(f15_arg0, f15_arg1, "inventory_equip", f15_arg3, f15_arg4)
	if f15_arg3 then
		CoD.WZUtility.ResetQuickInventoryAutoCloseTimer(f15_arg2, f15_arg0)
	end
end
CoD.WZUtility.SendInventoryDetachNotify = function(f16_arg0, f16_arg1)
	CoD.WZUtility.SendInventoryNotify(f16_arg0, f16_arg1, "inventory_detach")
end
CoD.WZUtility.NotifyCannotEquipInventory = function(f17_arg0, f17_arg1)
	local f17_local0 = f17_arg1:getModel()
	if f17_local0.equipped:get() == 1 then
		f17_local0 = DataSources.WarzoneInventory.getModel(f17_arg0)
		f17_local0 = f17_local0.cannotEquipItem
		local f17_local1 = f17_local0
		f17_local0 = f17_local0.set
		local f17_local2 = Engine[@"hash_4F9F1239CFD921FE"]
		local f17_local3 = @"warzone/already_equipped"
		local f17_local4 = f17_arg1:getModel()
		f17_local0(f17_local1, f17_local2(f17_local3, f17_local4.name:get()))
	else
		f17_local0 = DataSources.WarzoneInventory.getModel(f17_arg0)
		f17_local0 = f17_local0.cannotEquipItem
		local f17_local1 = f17_local0
		f17_local0 = f17_local0.set
		local f17_local2 = Engine[@"hash_4F9F1239CFD921FE"]
		local f17_local3 = @"warzone/cannot_equip"
		local f17_local4 = f17_arg1:getModel()
		f17_local0(f17_local1, f17_local2(f17_local3, f17_local4.name:get()))
	end
end
CoD.WZUtility.SendInventoryDropNotify = function(f18_arg0, f18_arg1)
	CoD.WZUtility.SendInventoryNotify(f18_arg0, f18_arg1, "inventory_drop")
end
CoD.WZUtility.SendInventoryPartialDropNotify = function(f19_arg0, f19_arg1)
	local f19_local0 = DataSources.WarzoneSplitInventory.getModel(f19_arg0)
	CoD.WZUtility.SendInventoryNotify(f19_arg0, f19_arg1, "inventory_drop", f19_local0.current:get())
end
CoD.WZUtility.SendInventoryDropCurrentWeaponNotify = function(f20_arg0)
	SendCustomClientScriptNotifyForAdjustedClient(f20_arg0, "inventory_drop_current_weapon")
end
CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify = function(f21_arg0)
	SendCustomClientScriptNotifyForAdjustedClient(f21_arg0, "inventory_drop_current_weapon_and_detach")
end
CoD.WZUtility.SendInventoryDropWeaponInSlotNotify = function(f22_arg0, f22_arg1)
	SendCustomClientScriptNotifyForAdjustedClient(f22_arg0, "inventory_drop_weapon_in_slot", {
		slotId = f22_arg1,
	})
end
CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify = function(f23_arg0, f23_arg1)
	SendCustomClientScriptNotifyForAdjustedClient(f23_arg0, "inventory_drop_weapon_in_slot_and_detach", {
		slotId = f23_arg1,
	})
end
CoD.WZUtility.SendInventoryItemFocusNotify = function(f24_arg0, f24_arg1)
	CoD.WZUtility.SendInventoryNotify(f24_arg0, f24_arg1, "inventory_item_focus", nil, nil, true)
	Engine[@"hash_27CD221DF1911DD1"](f24_arg0)
end
CoD.WZUtility.SendInventoryItemFocusNoneNotify = function(f25_arg0)
	SendCustomClientScriptNotifyForAdjustedClient(f25_arg0, "inventory_item_focus", {
		id = CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE,
	})
end
CoD.WZUtility.SendInventoryConsumeNotify = function(f26_arg0, f26_arg1)
	CoD.WZUtility.SendInventoryNotify(f26_arg0, f26_arg1, "inventory_consume")
end
CoD.WZUtility.AddPickupNotificationWatcher = function(f27_arg0, f27_arg1, f27_arg2)
	local f27_local0 = {}
	local f27_local1 = function()
		f27_arg2:setText(f27_local0[1])
		f27_arg1:playClip("PickUp")
	end
	f27_arg1:appendEventHandler("clip_over", function(f29_arg0, f29_arg1)
		table.remove(f27_local0, 1)
		if #f27_local0 > 0 then
			f27_local1()
		end
	end)
	f27_arg1:subscribeToGlobalModel(f27_arg0, "WarzoneInventory", "pickedUpItem", function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= 0x0 then
			table.insert(f27_local0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E719EE2BA38EDE4", f30_local0))
			if #f27_local0 == 1 then
				f27_local1()
			end
		end
	end, true)
	f27_arg1:subscribeToGlobalModel(f27_arg0, "WarzoneInventory", "droppedItem", function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= "" then
			table.insert(f27_local0, Engine[@"hash_4F9F1239CFD921FE"](@"warzone/dropped_x", f31_local0))
			if #f27_local0 == 1 then
				f27_local1()
			end
		end
	end, true)
	f27_arg1:subscribeToGlobalModel(f27_arg0, "WarzoneInventory", "cannotEquipItem", function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= 0x0 then
			table.insert(f27_local0, f32_local0)
			if #f27_local0 == 1 then
				f27_local1()
			end
		end
	end, true)
end
CoD.WZUtility.SetUpPassCustomFunctionToChildElement = function(f33_arg0, f33_arg1, f33_arg2)
	if f33_arg0 == f33_arg1 then
		error("PassCustomFunctionToChildElement cannot be called on self")
	end
	f33_arg0[f33_arg2] = function()
		if f33_arg1[f33_arg2] ~= nil then
			f33_arg1[f33_arg2]()
		end
	end
end
CoD.WZUtility.SetUpPlayClipOnCustomFunction = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
	f35_arg0[f35_arg3] = function()
		PlayClip(f35_arg0, f35_arg1, f35_arg2)
	end
end
CoD.WZUtility.HackUpdateListDataSourceAfterDelay = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
	f37_arg0:addElement(LUI.UITimer.newElementTimer(f37_arg4, true, function(f38_arg0)
		CoD.GridAndListUtility.UpdateDataSource(f37_arg0, f37_arg1, f37_arg2, f37_arg3)
	end))
end
CoD.WZUtility.SelectNextFreeItemSlot = function(f39_arg0, f39_arg1)
	local f39_local0 = f39_arg0.activeWidget
	if f39_local0 then
		local f39_local1 = f39_local0:getNextItem(true)
		while f39_local1 and f39_local1 ~= f39_local0 do
			local f39_local2 = f39_local1:getModel()
			if f39_local2.id:get() == CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE then
				f39_local1:setAsActiveItem()
				break
			end
			f39_local1 = f39_local1:getNextItem(true)
		end
	end
end
CoD.WZUtility.SplitterWidgetElement = nil
CoD.WZUtility.CurrentSplitItemElement = nil
CoD.WZUtility.SetPCSplitterWidgetElement = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	CoD.WZUtility.SplitterWidgetElement = f40_arg3
	if not CoD.WZUtility.SplitterWidgetElement.__updateSafeAreaRegistered then
		f40_arg0:appendEventHandler("update_safe_area", function(f41_arg0, f41_arg1)
			if CoD.WZUtility.SplitterWidgetElement and CoD.WZUtility.CurrentSplitItemElement then
				CoD.WZUtility.AlignPCSplitterWidgetOnElement(f40_arg2, CoD.WZUtility.CurrentSplitItemElement)
			end
		end)
		CoD.WZUtility.SplitterWidgetElement.__updateSafeAreaRegistered = true
	end
end
CoD.WZUtility.OpenPCSplitterWidgetForElement = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
	local f42_local0 = CoD.WZUtility.SplitterWidgetElement
	CoD.WZUtility.CurrentSplitItemElement = f42_arg3
	CoD.WZUtility.SetupSplitCount(f42_arg2, f42_arg3)
	MenuHidesFreeCursor(f42_arg1, f42_arg2)
	SetElementState(f42_arg0, f42_local0, f42_arg2, "Open")
	SetLoseFocusToSelf(f42_arg3, f42_arg2)
	SetFocusToSelf(f42_local0, f42_arg2)
	CoD.WZUtility.AlignPCSplitterWidgetOnElement(f42_arg2, f42_arg3, f42_local0)
	CoD.FreeCursorUtility.ForceCloseDetailedView(f42_arg1, f42_arg2)
	local f42_local1 = Engine[@"currentgametime"]()
	f42_arg1:setInputOverrideElement(f42_local0, function(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4)
		if Engine[@"currentgametime"]() == f42_local1 then
			return true
		elseif f43_arg3 == "ui_navup" or f43_arg4 == Enum[@"luibutton"][@"lui_key_up"] or f43_arg3 == "ui_navright" or f43_arg4 == Enum[@"luibutton"][@"lui_key_right"] then
			CoD.WZUtility.IncrementSplitCount(f43_arg2)
			return true
		elseif f43_arg3 == "ui_navdown" or f43_arg4 == Enum[@"luibutton"][@"lui_key_down"] or f43_arg3 == "ui_navleft" or f43_arg4 == Enum[@"luibutton"][@"lui_key_left"] then
			CoD.WZUtility.DecrementSplitCount(f43_arg2)
			return true
		elseif f43_arg3 == "ESCAPE" or f43_arg4 == Enum[@"luibutton"][@"lui_key_xbb_pscircle"] then
			CoD.WZUtility.ClosePCSplitterWidget(f42_local0, f43_arg1, f43_arg2)
			return true
		else
			CoD.WZUtility.ClosePCSplitterWidget(f42_local0, f43_arg1, f43_arg2)
			return false
		end
	end)
end
CoD.WZUtility.AlignPCSplitterWidgetOnElement = function(f44_arg0, f44_arg1)
	local f44_local0 = CoD.WZUtility.SplitterWidgetElement
	local f44_local1, f44_local2, f44_local3, f44_local4 = f44_local0:getLocalRect()
	local f44_local5, f44_local6, f44_local7, f44_local8 = f44_local0:getGlobalLeftRightTopBottom()
	local f44_local9 = f44_local1 - f44_local5
	local f44_local10 = f44_local2 - f44_local7
	local f44_local11, f44_local12, f44_local13, f44_local14 = f44_arg1:getGlobalLeftRightTopBottom()
	local f44_local15 = f44_local6 - f44_local5
	local f44_local16 = f44_local11 - (f44_local15 - f44_local12 - f44_local11) * 0.5 + f44_local9
	local f44_local17 = f44_local16 + f44_local15
	local f44_local18 = f44_local8 - f44_local7
	local f44_local19 = f44_local13 + (f44_local14 - f44_local13) * 0.5 + f44_local10
	local f44_local20 = f44_local19 + f44_local18
	local f44_local21, f44_local22 = Engine[@"getscreensize"](f44_arg0)
	local f44_local23 = f44_local22 - 60
	if f44_local23 < f44_local20 then
		local f44_local24 = f44_local20 - f44_local23
		f44_local19 = f44_local19 - f44_local24
		f44_local20 = f44_local20 - f44_local24
	end
	f44_local0:setLeftRight(0, 0, f44_local16, f44_local17)
	f44_local0:setTopBottom(0, 0, f44_local19, f44_local20)
end
CoD.WZUtility.ApplyPCSplitterWidget = function(f45_arg0, f45_arg1, f45_arg2)
	CoD.WZUtility.SendInventoryPartialDropNotify(f45_arg2, CoD.WZUtility.CurrentSplitItemElement)
	CoD.WZUtility.ClosePCSplitterWidget(f45_arg0, f45_arg1, f45_arg2)
end
CoD.WZUtility.ClosePCSplitterWidget = function(f46_arg0, f46_arg1, f46_arg2)
	local f46_local0 = CoD.WZUtility.SplitterWidgetElement
	if not f46_local0 or f46_local0.currentState ~= "Open" then
		return
	end
	local f46_local1 = CoD.WZUtility.CurrentSplitItemElement
	SetLoseFocusToSelf(f46_local0, f46_arg2)
	SetFocusToSelf(f46_local1, f46_arg2)
	SetElementState(f46_arg0, f46_local0, f46_arg2, "DefaultState")
	MenuUnhideFreeCursor(f46_arg1, f46_arg2)
	CoD.FreeCursorUtility.ToggleDetailedViewPC(f46_arg1, f46_arg2, true)
	if f46_local1.gridInfoTable then
		CoD.WZUtility.HackUpdateListDataSourceAfterDelay(f46_local1.gridInfoTable.parentGrid, true, false, true, "500")
	end
	f46_arg1:setInputOverrideElement(nil)
	CoD.WZUtility.CurrentSplitItemElement = nil
end
CoD.WZUtility.SetupSplitCount = function(f47_arg0, f47_arg1)
	local f47_local0 = DataSources.WarzoneSplitInventory.setupNewMax
	local f47_local1 = f47_arg0
	local f47_local2 = f47_arg1:getModel()
	f47_local0(f47_local1, f47_local2.stackCount:get() or 0)
end
CoD.WZUtility.IncrementSplitCount = function(f48_arg0)
	DataSources.WarzoneSplitInventory.increment(f48_arg0)
end
CoD.WZUtility.DecrementSplitCount = function(f49_arg0)
	DataSources.WarzoneSplitInventory.decrement(f49_arg0)
end
CoD.WZUtility.SetupQuickInventoryAutoClose = function(f50_arg0, f50_arg1, f50_arg2)
	local f50_local0 = Engine[@"getmodelforcontroller"](f50_arg1)
	f50_local0 = f50_local0["hudItems.inventory.open"]
	f50_arg0:subscribeToModel(f50_local0, function(model)
		local f51_local0 = model:get()
		if f51_local0 and not f50_arg0.__quickEquipAutoCloseTimer then
			f50_arg0.__quickEquipAutoCloseTimer = LUI.UITimer.newElementTimer(f50_arg2, true, function()
				f50_arg0.__quickEquipAutoCloseTimer:close()
				f50_arg0.__quickEquipAutoCloseTimer = nil
				CoD.WZUtility.CloseQuickAccessInventory(f50_arg0, f50_arg1)
			end)
			f50_arg0:addElement(f50_arg0.__quickEquipAutoCloseTimer)
		elseif not f51_local0 and f50_arg0.__quickEquipAutoCloseTimer then
			f50_arg0.__quickEquipAutoCloseTimer:close()
			f50_arg0.__quickEquipAutoCloseTimer = nil
		end
	end, false)
	local f50_local1 = f50_arg0
	local f50_local2 = f50_arg0.subscribeToModel
	local f50_local3 = Engine[@"getmodelforcontroller"](f50_arg1)
	f50_local2(f50_local1, f50_local3.ButtonBits[Enum[@"luibutton"][@"lui_key_xbx_pssquare"]].progress, function(f53_arg0)
		if f50_local0:get() and f50_arg0.__quickEquipAutoCloseTimer then
			local f53_local0 = f53_arg0:get()
			if f53_local0 and f53_local0 > 0 then
				CoD.WZUtility.ResetQuickInventoryAutoCloseTimer(f50_arg0, f50_arg1)
			end
		end
	end, false)
end
CoD.WZUtility.ResetQuickInventoryAutoCloseTimer = function(f54_arg0, f54_arg1)
	if f54_arg0.__quickEquipAutoCloseTimer then
		f54_arg0.__quickEquipAutoCloseTimer:reset()
	end
end
CoD.WZUtility.StartWarzone = function(f55_arg0)
	Engine[@"execnow"](f55_arg0, "startwzmatch")
end
CoD.WZUtility.IsPaintCansMaxed = function(f56_arg0)
	local f56_local0 = Engine[@"storagegetbuffer"](f56_arg0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"])
	if f56_local0 and f56_local0.PlayerStatsList.ITEMS_PAINT_CANS_COLLECTED.StatValue:get() >= 150 then
		return true
	else
		return false
	end
end
CoD.WZUtility.IsInventoryOpen = function(f57_arg0)
	return CoD.SafeGetModelValue(DataSources.WarzoneInventory.getModel(f57_arg0), "isOpen")
end
CoD.WZUtility.IsQuickInventoryOpen = function(f58_arg0)
	return CoD.ModelUtility.IsModelValueTrue(f58_arg0, "hudItems.inventory.open")
end
CoD.WZUtility.IsInLastStand = function(f59_arg0, f59_arg1)
	return CoD.ModelUtility.IsModelValueGreaterThan(f59_arg0, f59_arg1 .. ".progress", 0) or CoD.ModelUtility.IsModelValueEqualTo(f59_arg0, f59_arg1 .. ".beingRevived", 1)
end
CoD.WZUtility.HasBackpack = function(f60_arg0)
	return CoD.SafeGetModelValue(DataSources.WarzoneInventory.getModel(f60_arg0), "count") == CoD.WZUtility.InventorySize.ITEM_WORLD_PLAYER_INVENTORY_SIZE_BACKPACK
end
CoD.WZUtility.InventoryFull = function(f61_arg0)
	local f61_local0 = DataSources.WarzoneInventory.getModel(f61_arg0)
	local f61_local1 = CoD.SafeGetModelValue(f61_local0, "count")
	local f61_local2 = CoD.SafeGetModelValue(f61_local0, "filledSlots")
	local f61_local3 = 0
	if f61_local0.shard0 and f61_local0.shard0.stackCount then
		local f61_local4 = f61_local0.shard0.stackCount:get()
		if f61_local4 and f61_local4 > 0 then
			f61_local3 = 1
		end
	end
	return f61_local1 <= f61_local2 - f61_local3
end
CoD.WZUtility.IsActivePickupItem = function(f62_arg0, f62_arg1)
	local f62_local0 = DataSources.HUDItems.getModel(f62_arg0)
	if f62_local0.showPickupHint:get() then
		f62_local0 = DataSources.HUDItems.getModel(f62_arg0)
		f62_local0 = f62_local0.weapon3dHintState:get() or 0
		if CoD.BitUtility.IsBitSet(f62_local0, CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) or CoD.BitUtility.IsBitSet(f62_local0, CoD.HUDUtility.Weapon3DHintStateFlags.IGNORES_INVENTORY) or CoD.BitUtility.IsBitSet(f62_local0, CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) then
			return false
		end
		local f62_local1 = DataSources.HUDItems.getModel(f62_arg0)
		f62_local1 = f62_local1.weapon3dForcedHintItem:get() or -1
		if f62_local1 == -1 then
			local f62_local2 = DataSources.WarzoneInventory.getModel(f62_arg0)
			f62_local1 = f62_local2.firstFreeSlot:get() or -1
			if f62_local1 == -1 then
				f62_local2 = DataSources.WarzoneInventory.getModel(f62_arg0)
				f62_local1 = f62_local2.selectedIndex:get() or 0
			end
		end
		local f62_local2 = DataSources.WarzoneInventory.getModel(f62_arg0)
		f62_local2 = f62_local2["item" .. f62_local1]
		if f62_local2 and f62_local2 == f62_arg1:getModel() then
			return true
		end
	end
	return false
end
CoD.WZUtility.ShouldHideTeamWidget = function(f63_arg0)
	local f63_local0
	if Engine[@"isvisibilitybitset"](f63_arg0, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
		f63_local0 = Engine[@"isvisibilitybitset"](f63_arg0, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
		if not f63_local0 then
			f63_local0 = Engine[@"isvisibilitybitset"](f63_arg0, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
			if not f63_local0 then
				f63_local0 = Engine[@"isvisibilitybitset"](f63_arg0, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end
		end
	else
		f63_local0 = true
	end
	return f63_local0
end
CoD.WZUtility.IsCurrentCharacterDefault = function(f64_arg0)
	local f64_local0 = Engine[@"getpositionrolebundleinfo"](Engine[@"currentsessionmode"](), CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f64_arg0))
	if f64_local0[@"isdefaultcharacter"] == 1 then
		return true
	else
		return false
	end
end
CoD.WZUtility.ShowDefaultCharacterInfo = function(f65_arg0)
	local f65_local0 = Engine[@"getmodelforcontroller"](f65_arg0)
	local f65_local1 = f65_local0.PositionDraft
	if f65_local1 then
		f65_local1 = f65_local0.PositionDraft.focusedCharacterIndex
	end
	local f65_local2 = f65_local1 and f65_local1:get()
	if f65_local2 and f65_local2 ~= 0 then
		local f65_local3 = DataSources.WZDefaultCharacterInfo.getModel(f65_arg0)
		f65_local3 = f65_local3.characterIndex
		return f65_local2 == (f65_local3 and f65_local3:get())
	else
		return CoD.WZUtility.IsCurrentCharacterDefault(f65_arg0)
	end
end
CoD.WZUtility.ShouldHidePlatoonReviveNumber = function(f66_arg0)
	local f66_local0 = DataSources.HUDItems.getModel(f66_arg0)
	f66_local0 = f66_local0.lastStand.revivingClientNum:get()
	return CoD.WZUtility.IsOnFriendlyPlatoon(f66_arg0, f66_local0) and not CoD.WZUtility.IsOnControllersTeam(f66_arg0, f66_local0)
end
CoD.WZUtility.ShouldHideCharacterPersonalizationText = function(f67_arg0, f67_arg1)
	if IsGameTrial() then
		return true
	elseif CoD.SafeGetModelValue(f67_arg0:getModel(), "hasCustomization") then
		return false
	else
		return true
	end
end
CoD.WZUtility.IsOnControllersTeam = function(f68_arg0, f68_arg1)
	local f68_local0 = Engine[@"getclientnum"](f68_arg0)
	local f68_local1 = CoD.SafeGetModelValue(Engine[@"getmodelforclient"](f68_arg1), "team")
	local f68_local2 = CoD.SafeGetModelValue(Engine[@"getmodelforclient"](f68_local0), "team")
	return f68_local2 and f68_local1 and f68_local1 == f68_local2
end
CoD.WZUtility.IsPerClientOnFriendlyPlatoonOnly = function(f69_arg0, f69_arg1)
	local f69_local0 = Engine[@"getmodelforcontroller"](f69_arg1)
	local f69_local1 = CoD.SafeGetModelValue(f69_arg0:getModel(), "platoonNumber")
	local f69_local2 = CoD.SafeGetModelValue(f69_local0.clientModel:get(), "platoonNumber")
	local f69_local3 = CoD.SafeGetModelValue(f69_arg0:getModel(), "team")
	local f69_local4 = DataSources.Factions.getModel(f69_arg1)
	local f69_local5
	if f69_local1 ~= f69_local2 or f69_local3 == f69_local4.actualTeam:get() then
		f69_local5 = false
	else
		f69_local5 = true
	end
	return f69_local5
end
CoD.WZUtility.IsOnFriendlyPlatoon = function(f70_arg0, f70_arg1)
	local f70_local0 = CoD.SafeGetModelValue(Engine[@"getmodelforclient"](f70_arg1), "platoonNumber")
	if f70_local0 == nil then
		return false
	end
	local f70_local1 = Engine[@"getmodelforcontroller"](f70_arg0)
	local f70_local2
	if IsGametypeSettingsValue("platoonCount", 0) or f70_local0 ~= CoD.SafeGetModelValue(f70_local1.clientModel:get(), "platoonNumber") then
		f70_local2 = false
	else
		f70_local2 = true
	end
	return f70_local2
end
CoD.WZUtility.TeammateIndexClientNum = function(f71_arg0, f71_arg1)
	local f71_local0 = f71_arg1
	if CoD.WZUtility.IsOnControllersTeam(f71_arg0, f71_local0) then
		local f71_local1 = CoD.SafeGetModelValue(Engine[@"getmodelforclient"](f71_local0), "teammateIndex")
		if not f71_local1 then
			return 0
		else
			return f71_local1
		end
	else
		return -1
	end
end
CoD.WZUtility.TeamPlayerColorNameForTeammateIndex = function(f72_arg0, f72_arg1)
	return CoD.ColorUtility.GetColorBlindColorNameForPlayer(f72_arg0, CoD.WZUtility.TeamPlayerColor[f72_arg1 % #CoD.WZUtility.TeamPlayerColor + 1] or "White")
end
CoD.WZUtility.TeamPlayerColorNameForClientNum = function(f73_arg0, f73_arg1)
	local f73_local0 = f73_arg1
	local f73_local1 = CoD.WZUtility.TeammateIndexClientNum(f73_arg0, f73_local0)
	if f73_local1 ~= -1 then
		return CoD.ColorUtility.GetColorBlindColorNameForPlayer(f73_arg0, CoD.WZUtility.TeamPlayerColor[f73_local1 % #CoD.WZUtility.TeamPlayerColor + 1] or "White")
	elseif CoD.WZUtility.IsOnFriendlyPlatoon(f73_arg0, f73_local0) then
		return CoD.ColorUtility.GetColorBlindColorNameForPlayer(f73_arg0, "White")
	else
		return CoD.ColorUtility.GetColorBlindColorNameForPlayer(f73_arg0, "EnemyOrange")
	end
end
CoD.WZUtility.ShownPlayerIndexForClientNum = function(f74_arg0, f74_arg1)
	local f74_local0 = CoD.WZUtility.TeammateIndexClientNum(f74_arg0, f74_arg1)
	if f74_local0 == -1 then
		return ""
	else
		return "" .. f74_local0 + 1
	end
end
CoD.WZUtility.TeamPlayerColorForClientNum = function(f75_arg0, f75_arg1)
	return CoD.ColorUtility.ConvertTableToRGB(ColorSet[CoD.WZUtility.TeamPlayerColorNameForClientNum(f75_arg0, f75_arg1)])
end
CoD.WZUtility.TeamPlayerColorForTeammateIndex = function(f76_arg0, f76_arg1)
	return CoD.ColorUtility.ConvertTableToRGB(ColorSet[CoD.WZUtility.TeamPlayerColorNameForTeammateIndex(f76_arg0, f76_arg1)])
end
CoD.WZUtility.GetTeamPlayerStatusImage = function(f77_arg0)
	return CoD.WZUtility.PlayerStatusIcon[tonumber(f77_arg0)]
end
CoD.WZUtility.GetInventoryEquipText = function(f78_arg0)
	if f78_arg0 == "killstreak" then
		return @"menu/deploy"
	else
		return @"warzone/equip"
	end
end
CoD.WZUtility.PlayerStatusClientScriptNotify = function(f79_arg0, f79_arg1, f79_arg2)
	local f79_local0 = Engine[@"getlocalclientnum"](f79_arg0)
	local f79_local1 = f79_arg1:getModel()
	f79_local1 = f79_local1.clientNum:get()
	if f79_local1 ~= nil then
		Engine[@"sendclientscriptnotify"](f79_arg0, "teammate_state_change", {
			clientNum = f79_local1,
			localClientNum = f79_local0,
			state = CoD.WZUtility.PlayerStatusClientScriptState[f79_arg2:get()] or @"hash_0",
		})
	end
end
CoD.WZUtility.RarityToColorTable = {
	None = ColorSet.T8__SLATE,
	Common = ColorSet.T8__SLATE,
	Rare = ColorSet.BlackMarketRare,
	Epic = ColorSet.BlackMarketEpic,
	Legendary = ColorSet.BlackMarketLegendary,
}
CoD.WZUtility.WarzoneRarityToColor = function(f80_arg0)
	local f80_local0 = CoD.WZUtility.RarityToColorTable[f80_arg0]
	if not f80_local0 then
		f80_local0 = CoD.WZUtility.RarityToColorTable.None
	end
	return f80_local0.r, f80_local0.g, f80_local0.b
end
CoD.WZUtility.TowerIndexToName = function(f81_arg0)
	local f81_local0 = Engine[@"getglobalmodel"]()
	f81_local0 = f81_local0.hudItems.deathZones
	local f81_local1 = f81_local0 and f81_local0[f81_arg0]
	if f81_local1 then
		local f81_local2 = f81_local1.displayName
		local f81_local3 = f81_local1.displayName:get()
	end
	return f81_local2 and f81_local3 or 0x0
end
CoD.WZUtility.GetMultiItemReplaceText = function(f82_arg0, f82_arg1)
	local f82_local0 = DataSources.MultiItemPickup.getModel(f82_arg0)
	f82_local0 = f82_local0.currentSelection:get()
	local f82_local1 = f82_local0 and f82_local0.claimsInventorySlot:get() == 1
	local f82_local2 = DataSources.WarzoneInventory.getModel(f82_arg0)
	if f82_arg1 == 0x0 or not f82_local1 or f82_local2.firstFreeSlot:get() ~= -1 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"warzone/pick_up")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2FBCE5B447E66701", f82_arg1)
	end
end
CoD.WZUtility.GetArmorFlipbookFrame = function(f83_arg0, f83_arg1, f83_arg2, f83_arg3, f83_arg4, f83_arg5)
	local f83_local0 = f83_arg0
	local f83_local1 = f83_arg0.armorMax
	if f83_local1 then
		f83_local1 = f83_local0 and f83_arg0.armorMax:get()
	end
	if f83_local1 and f83_local1 > 0 then
		return math.floor(CoD.WZUtility.ArmorFlipbookFrames * (1 - f83_arg2 / f83_local1)), 0, 0, 0
	else
		return 0, 0, 0, 0
	end
end
CoD.WZUtility.GetArmorFlipbookIconForArmorTier = function(f84_arg0)
	local f84_local0 = f84_arg0
	if not CoD.WZUtility.ArmorTierToFlipbookImage then
		CoD.WZUtility.ArmorTierToFlipbookImage = {}
		for f84_local4, f84_local5 in ipairs(CoD.WZUtility.ArmorAssetList) do
			local f84_local6 = Engine[@"hash_2E00B2F29271C60B"](f84_local5)
			if f84_local6 and f84_local6[@"armortier"] ~= nil then
				CoD.WZUtility.ArmorTierToFlipbookImage[f84_local6[@"armortier"]] = f84_local6[@"icon"]
			end
		end
	end
	return CoD.WZUtility.ArmorTierToFlipbookImage[f84_local0] or @"blacktransparent"
end
CoD.WZUtility.GetArmorShardPips = function(f85_arg0, f85_arg1, f85_arg2, f85_arg3)
	local f85_local0 = f85_arg0
	if not CoD.WZUtility.ArmorTierToShardCount then
		CoD.WZUtility.ArmorTierToShardCount = {}
		for f85_local4, f85_local5 in ipairs(CoD.WZUtility.ArmorAssetList) do
			local f85_local6 = Engine[@"hash_2E00B2F29271C60B"](f85_local5)
			if f85_local6 and f85_local6[@"armortier"] ~= nil then
				CoD.WZUtility.ArmorTierToShardCount[f85_local6[@"armortier"]] = f85_local6[@"armorshards"]
			end
		end
	end
	return math.max(CoD.WZUtility.ArmorTierToShardCount[f85_local0] or 0, 1), 1, 0, 0
end
CoD.WZUtility.AdjustDistanceFromDeathCircle = function(f86_arg0, f86_arg1, f86_arg2)
	local f86_local0 = f86_arg2
	if f86_arg2 == 1 then
		return f86_arg1
	else
		return f86_arg2 * f86_arg0
	end
end
CoD.WZUtility.PrependUpsellIconIfNeed = function(f87_arg0, f87_arg1)
	if f87_arg0.purchasable and f87_arg0.purchasable:get() then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_31001FF6B558E68C", Engine[@"hash_4F9F1239CFD921FE"](f87_arg1))
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f87_arg1)
	end
end
CoD.WZUtility.TrialSpecificTierSkip = function(f88_arg0)
	if IsGameTrial() then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_64E334203F8258AC")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f88_arg0)
	end
end
DataSources.PlayerListWZ = {
	prepare = function(f89_arg0, f89_arg1, f89_arg2)
		f89_arg1.clients = {}
		local f89_local0 = Engine[@"getmodelforcontroller"](f89_arg0)
		local f89_local1 = Engine[@"getpredictedclientnum"](f89_arg0)
		local f89_local2 = Engine[@"getteamid"](f89_arg0, f89_local1)
		local f89_local3 = Engine[@"hash_F9C4C8A66F9CB02"](f89_arg0)
		local f89_local4 = 0
		for f89_local10, f89_local11 in pairs(f89_local3) do
			if f89_local2 == f89_local11 then
				local f89_local8 = CoD.SafeGetModelValue(Engine[@"getmodelforclient"](f89_local10), "teammateIndex")
				if f89_local1 ~= Engine[@"getclientnum"](f89_arg0) then
					if not f89_local8 then
						f89_local8 = f89_local4
						local f89_local9 = Engine[@"getmodelforclient"](f89_local10)
						f89_local9.teammateIndex:set(f89_local8)
					end
					f89_local4 = f89_local8 + 1
				end
				if f89_local8 ~= nil then
					table.insert(f89_arg1.clients, f89_local10)
				end
			end
		end
		table.sort(f89_arg1.clients)
		for f89_local10, f89_local11 in ipairs(f89_arg1.clients) do
			local f89_local8 = Engine[@"getmodelforclient"](f89_local11)
			local f89_local9 = CoD.SafeGetModelValue(Engine[@"getmodelforclient"](f89_local11), "teammateIndex")
			if not f89_local8.idNumber2 then
				local f89_local12 = f89_local8:create("idNumber2")
				f89_local12:set(f89_local9)
				f89_local12 = f89_local8:create("inGamePlayerStatus")
				f89_local12:set(Enum[@"hash_14A07561A78E340B"][@"hash_358F9A363F8FBB07"])
				f89_local12 = f89_local8:create("isMarkerIconPlaced")
				f89_local12:set(false)
				f89_local12 = f89_local8:create("isSpectreRisingTarget")
				f89_local12:set(false)
			end
		end
		if not f89_arg1.clientChangedTeamSubscription then
			f89_local6 = f89_arg1
			f89_local5 = f89_arg1.subscribeToModel
			f89_local7 = Engine[@"getmodelforcontroller"](f89_arg0)
			f89_arg1.clientChangedTeamSubscription = f89_local5(f89_local6, f89_local7:create("Clients.clientChangedTeam"), function()
				f89_arg1:updateDataSource(true, true)
			end, false)
			f89_local6 = f89_arg1
			f89_local5 = f89_arg1.subscribeToModel
			f89_local7 = Engine[@"getmodelforcontroller"](f89_arg0)
			f89_local5(f89_local6, f89_local7.deadSpectator.playerIndex, function()
				f89_arg1:updateDataSource(true, true)
			end, false)
		end
	end,
	getCount = function(f92_arg0)
		return #f92_arg0.clients
	end,
	getItem = function(f93_arg0, f93_arg1, f93_arg2)
		if f93_arg1.clients[f93_arg2] ~= nil then
			return Engine[@"getmodelforclient"](f93_arg1.clients[f93_arg2])
		else
			return Engine[@"getmodelforclient"](-1)
		end
	end,
}
DataSources.WZTeamScoreboard = {
	prepare = function(f94_arg0, f94_arg1, f94_arg2)
		f94_arg1.clients = {}
		local f94_local0 = Engine[@"getmodelforcontroller"](f94_arg0)
		local f94_local1 = Engine[@"getclientnum"](f94_arg0)
		local f94_local2 = Engine[@"getteamid"](f94_arg0, f94_local1)
		local f94_local3 = Engine[@"hash_F9C4C8A66F9CB02"](f94_arg0)
		local f94_local4 = 0
		for f94_local10, f94_local11 in pairs(f94_local3) do
			if f94_local2 == f94_local11 then
				local f94_local8 = CoD.SafeGetModelValue(Engine[@"getmodelforclient"](f94_local10), "teammateIndex")
				if f94_local1 ~= Engine[@"getclientnum"](f94_arg0) then
					if not f94_local8 then
						f94_local8 = f94_local4
						local f94_local9 = Engine[@"getmodelforclient"](f94_local10)
						f94_local9.teammateIndex:set(f94_local8)
					end
					f94_local4 = f94_local8 + 1
				end
				if f94_local8 ~= nil then
					table.insert(f94_arg1.clients, f94_local10)
				end
			end
		end
		table.sort(f94_arg1.clients)
		if not f94_arg1.clientChangedTeamSubscription then
			f94_local6 = f94_arg1
			f94_local5 = f94_arg1.subscribeToModel
			f94_local7 = Engine[@"getmodelforcontroller"](f94_arg0)
			f94_arg1.clientChangedTeamSubscription = f94_local5(f94_local6, f94_local7:create("Clients.clientChangedTeam"), function()
				f94_arg1:updateDataSource(true, true)
			end, false)
		end
	end,
	getCount = function(f96_arg0)
		return #f96_arg0.clients
	end,
	getItem = function(f97_arg0, f97_arg1, f97_arg2)
		if f97_arg1.clients[f97_arg2] ~= nil then
			return Engine[@"getmodelforclient"](f97_arg1.clients[f97_arg2])
		else
			return Engine[@"getmodelforclient"](-1)
		end
	end,
}
DataSources.NearbyFloorStates = {
	prepare = function(f98_arg0, f98_arg1, f98_arg2)
		local f98_local0 = Engine[@"getmodelforcontroller"](f98_arg0)
		f98_local0 = f98_local0.hudItems.deathZones
		if not f98_arg1._hasSubscriptions then
			f98_arg1._hasSubscriptions = true
			f98_arg1:subscribeToModel(f98_local0.towerIndex, function()
				f98_arg1:updateDataSource(true, true)
			end, false)
			f98_arg1:subscribeToModel(f98_local0.floorIndex, function()
				f98_arg1:updateDataSource(true, true)
			end, false)
		end
		local f98_local1 = Engine[@"getglobalmodel"]()
		f98_local1 = f98_local1.hudItems:create("deathZones")
		f98_arg1.fakeZoneModel = f98_local1:create("-1")
		local f98_local2 = f98_arg1.fakeZoneModel:create("state")
		f98_local2:set(CoD.WZUtility.DeathZoneState.ZONE_HIDDEN)
		f98_local2 = f98_arg1.fakeZoneModel:create("floorIndex")
		f98_local2:set(-1)
		f98_arg1._floorsAbove = math.floor((f98_arg1.vCount - 1) / 2)
		f98_arg1._floorsBelow = f98_arg1.vCount - 1 - f98_arg1._floorsAbove
		f98_arg1._currentTower = f98_local0.towerIndex:get()
		f98_arg1._currentFloor = f98_local0.floorIndex:get()
		f98_local2 = f98_local1[f98_arg1._currentTower]
		if f98_local2 and f98_arg1._updateFloorsAboveAndBelow then
			local f98_local3 = f98_local2.numFloors:get()
			local f98_local4 = f98_local0:create("floorsAbove")
			f98_local4:set(math.max(0, f98_arg1._currentFloor - f98_arg1._floorsAbove - 1))
			f98_local4 = f98_local0:create("floorsBelow")
			f98_local4:set(math.max(0, f98_local3 - f98_arg1._currentFloor - f98_arg1._floorsBelow))
		end
	end,
	getCount = function(f101_arg0)
		return f101_arg0.vCount
	end,
	getItem = function(f102_arg0, f102_arg1, f102_arg2)
		local f102_local0 = Engine[@"getglobalmodel"]()
		f102_local0 = f102_local0.hudItems.deathZones
		local f102_local1 = Engine[@"getmodelforcontroller"](f102_arg0)
		f102_local1 = f102_local1.hudItems.deathZones
		if f102_arg1._currentTower ~= 0 and f102_arg1._currentFloor ~= 0 then
			local f102_local2 = f102_arg1._currentFloor + f102_arg2 - f102_arg1._floorsAbove - 1
			local f102_local3 = f102_local0[f102_arg1._currentTower]
			if f102_local3 and (f102_local3.linkAdjacentFloors:get() == 1 or f102_arg2 == f102_arg1._floorsAbove + 1) and f102_local3[f102_local2] then
				return f102_local3[f102_local2]
			end
		end
		return f102_arg1.fakeZoneModel
	end,
}
DataSourceHelpers.PerControllerDataSourceSetup(
	"FloorSelection",
	"hudItems.floorSelection",
	function(f103_arg0, f103_arg1)
		if not f103_arg0.count then
			f103_arg0:create("open")
			local f103_local0 = f103_arg0:create("count")
			f103_local0:set(0)
		end
	end,
	false,
	{
		prepare = function(f104_arg0, f104_arg1, f104_arg2)
			if not f104_arg1._rootModel then
				f104_arg1._rootModel = DataSources.FloorSelection.getModel(f104_arg0)
				f104_arg1:subscribeToModel(f104_arg1._rootModel.count, function()
					f104_arg1:updateDataSource(false, true)
				end, false)
			end
		end,
		getCount = function(f106_arg0)
			return f106_arg0._rootModel.count:get()
		end,
		getItem = function(f107_arg0, f107_arg1, f107_arg2)
			local f107_local0 = f107_arg1._rootModel["item" .. f107_arg2 - 1]
			if f107_local0 ~= nil and f107_arg2 == 1 and f107_local0.name and f107_local0.name:get() == 0x0 then
				f107_local0.name:set(@"wz/auto_select")
			end
			return f107_local0
		end,
	}
)
DataSourceHelpers.PerControllerDataSourceSetup(
	"Elevator",
	"hudItems.elevator",
	function(f108_arg0, f108_arg1)
		if not f108_arg0.count then
			local f108_local0 = f108_arg0:create("count")
			f108_local0:set(0)
		end
	end,
	false,
	{
		prepare = function(f109_arg0, f109_arg1, f109_arg2)
			if not f109_arg1._rootModel then
				f109_arg1._rootModel = DataSources.Elevator.getModel(f109_arg0)
				f109_arg1:subscribeToModel(f109_arg1._rootModel.count, function()
					f109_arg1:updateDataSource(false, true)
				end, false)
			end
		end,
		getCount = function(f111_arg0)
			return f111_arg0._rootModel.count:get()
		end,
		getItem = function(f112_arg0, f112_arg1, f112_arg2)
			return f112_arg1._rootModel["item" .. f112_arg2 - 1]
		end,
	}
)
CoD.WZUtility.AmmoTypesToDisplayNames = {}
DataSources.WZAmmoPool = {
	prepare = function(f113_arg0, f113_arg1, f113_arg2)
		f113_arg1.ammoTypes = {}
		local f113_local0 = Engine[@"getmodelforcontroller"](f113_arg0)
		local f113_local1 = f113_local0:create("hudItems.inventory.pickedUpAmmoTypes")
		if not f113_local1._empty then
			local f113_local2 = f113_local1:create("_empty")
			local f113_local3 = f113_local2:create("rarity")
			f113_local3:set("None")
			f113_local3 = f113_local2:create("id")
			f113_local3:set(CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			f113_local3 = f113_local2:create("name")
			f113_local3:set(0x0)
			f113_local3 = f113_local2:create("stackCount")
			f113_local3:set(0)
			f113_local3 = f113_local2:create("icon")
			f113_local3:set(@"blacktransparent")
		end
		if (CoD.SafeGetModelValue(f113_local1, "count") or 0) > 0 then
			local f113_local2 = Engine[@"hash_5DABA94B203D6A38"](f113_arg0)
			for f113_local3 = 1, f113_local1.count:get(), 1 do
				local f113_local6 = f113_local1[f113_local3]
				local f113_local7 = f113_local6:create("rarity")
				f113_local7:set("None")
				f113_local7 = f113_local2[f113_local6.assetName:get()]
				if f113_local7 ~= nil then
					local f113_local8 = f113_local6:create("stackCount")
					f113_local8:set(f113_local7[@"count"])
				else
					local f113_local8 = f113_local6:create("stackCount")
					f113_local8:set(0)
				end
				table.insert(f113_arg1.ammoTypes, f113_local6)
			end
		end
		while #f113_arg1.ammoTypes < f113_arg1.hCount do
			table.insert(f113_arg1.ammoTypes, f113_local1._empty)
		end
		DataSourceHelpers.SubscribeOnceToUpdateDataSourceSkipFocus(f113_arg1, f113_local1, "_pickedUpAmmoTypeCountSubscription")
		local f113_local2 = DataSourceHelpers.SubscribeOnceToUpdateDataSourceSkipFocus
		local f113_local3 = f113_arg1
		local f113_local4 = DataSources.CurrentWeapon.getModel(f113_arg0)
		f113_local2(f113_local3, f113_local4.weaponReloadState, "_reloadStateSubscription")
	end,
	getCount = function(f114_arg0)
		return f114_arg0.ammoTypes and #f114_arg0.ammoTypes or 0
	end,
	getItem = function(f115_arg0, f115_arg1, f115_arg2)
		return f115_arg1.ammoTypes[f115_arg2]
	end,
}
DataSources.WZArmorItem = {
	prepare = function(f116_arg0, f116_arg1, f116_arg2)
		f116_arg1.armorItem = {}
		local f116_local0 = Engine[@"getmodelforcontroller"](f116_arg0)
		local f116_local1 = f116_local0:create("hudItems.inventory")
		local f116_local2 = f116_local1:create("filledSlots")
		local f116_local3 = f116_local1:create("hasArmor")
		f116_local3:set(false)
		if not f116_arg1._hasSubscription then
			f116_arg1._hasSubscription = true
			f116_arg1:subscribeToModel(f116_local2, function()
				f116_arg1:updateDataSource(false, true)
			end, false)
		end
		if f116_local2:get() > 0 then
			for f116_local3 = 1, f116_local1.count:get(), 1 do
				local f116_local6 = f116_local1["item" .. f116_local3 - 1]
				if f116_local6.type:get() == "armor" then
					table.insert(f116_arg1.armorItem, f116_local6)
				end
			end
		end
		f116_local1.hasArmor:set(#f116_arg1.armorItem > 0)
	end,
	getCount = function(f118_arg0)
		return f118_arg0.armorItem and #f118_arg0.armorItem or 0
	end,
	getItem = function(f119_arg0, f119_arg1, f119_arg2)
		return f119_arg1.armorItem[f119_arg2]
	end,
}
DataSources.HorizontalCompassPips = {
	prepare = function(f120_arg0, f120_arg1, f120_arg2)
		local f120_local0 = Engine[@"getmodelforcontroller"](f120_arg0)
		f120_local0 = f120_local0:create("DataSources.HorizontalCompassPips")
		f120_arg1.horizontalCompassPips = {}
		local f120_local1 = 20
		local f120_local2 = 95
		local f120_local3 = 2
		local f120_local4 = 45 / (1 + f120_local3)
		local f120_local5 = {
			@"warzone/compass_west",
			@"warzone/compass_north",
			@"warzone/compass_east",
			@"warzone/compass_south",
			@"warzone/compass_west",
			@"warzone/compass_north",
		}
		local f120_local6 = {
			@"warzone/compass_northwest",
			@"hash_4EBC7401C462CB11",
			@"warzone/compass_southeast",
			@"hash_56982C0C4CDC4751",
			@"warzone/compass_northwest",
			@"hash_4EBC7401C462CB11",
		}
		local f120_local7 = 270
		local f120_local8 = function(f121_arg0, f121_arg1)
			local f121_local0 = f120_local0:create(#f120_arg1.horizontalCompassPips + 1)
			local f121_local1 = f121_local0:create("text")
			f121_local1:set(f121_arg0)
			f121_local1 = f121_local0:create("degrees")
			f121_local1:set(f120_local7)
			f121_local1 = f121_local0:create("alpha")
			f121_local1:set(0)
			table.insert(f120_arg1.horizontalCompassPips, {
				model = f121_local0,
				widget = f121_arg1,
				degrees = f120_local7,
			})
			f120_local7 = (f120_local7 + f120_local4) % 360
		end
		for f120_local16, f120_local17 in ipairs(f120_local5) do
			f120_local8(Engine[@"hash_4F9F1239CFD921FE"](f120_local17), CoD.WZCompassCardinal)
			for f120_local13 = 1, f120_local3, 1 do
				local f120_local12 = f120_local13
				f120_local8(f120_local7, CoD.WZCompassMinor)
			end
			f120_local8(Engine[@"hash_4F9F1239CFD921FE"](f120_local6[f120_local16]), CoD.WZCompassIntercardinal)
			for f120_local13 = 1, f120_local3, 1 do
				local f120_local12 = f120_local13
				f120_local8(f120_local7, CoD.WZCompassMinor)
			end
		end
		if not f120_arg1._hasYawSubscription then
			f120_arg1._hasYawSubscription = true
			f120_arg1:addElement(LUI.UITimer.newElementTimer(0, true, function()
				local f122_local0 = f120_arg1
				local f122_local1 = f122_local0
				f122_local0 = f122_local0.subscribeToModel
				local f122_local2 = Engine[@"getmodelforcontroller"](f120_arg0)
				f122_local0(f122_local1, f122_local2.hudItems.yaw, function(f123_arg0)
					local f123_local0 = (f123_arg0:get() + 360) % 360
					local f123_local1 = f123_local0 / 540 + 0.17
					if not f120_arg1._startLeftPx then
						local f123_local2, f123_local3, f123_local4, f123_local5 = f120_arg1.itemStencil:getLocalLeftRight()
						f120_arg1._startLeftPx = f123_local4 - 0.5 * CoD.WZCompassCardinal.__defaultWidth
						f120_arg1._startRightPx = f123_local5 - 0.5 * CoD.WZCompassCardinal.__defaultWidth
					end
					f120_arg1.itemStencil:setLeftRight(f123_local1, f123_local1, f120_arg1._startLeftPx, f120_arg1._startRightPx)
					for f123_local5, f123_local7 in ipairs(f120_arg1.horizontalCompassPips) do
						local f123_local8 = (math.abs(360 - f123_local0 - f123_local7.degrees) + 360) % 360
						local f123_local6 = math.min(1, math.max(0, (f120_local2 - math.min(f123_local8, math.abs(f123_local8 - 360))) / f120_local1))
						if math.abs((#f120_arg1.horizontalCompassPips - f123_local5) / (#f120_arg1.horizontalCompassPips - 1) - f123_local1) > 0.27 then
							f123_local6 = 0
						end
						f123_local7.model.alpha:set(f123_local6)
					end
				end, true)
			end))
		end
	end,
	getCount = function(f124_arg0)
		return #f124_arg0.horizontalCompassPips
	end,
	getItem = function(f125_arg0, f125_arg1, f125_arg2)
		return f125_arg1.horizontalCompassPips[f125_arg2].model
	end,
	getWidgetTypeForItem = function(f126_arg0, f126_arg1, f126_arg2)
		return f126_arg0.horizontalCompassPips[f126_arg2].widget
	end,
}
CoD.WZUtility.NoUnlockableItemsAbleToPersonalize = function(f127_arg0)
	for f127_local3, f127_local4 in pairs(f127_arg0) do
		if CoD.WZUtility.ArrayContains(CoD.WZUtility.WZPersonalizeWeaponNames, f127_local4.nameHash) then
			return false
		end
	end
	return true
end
DataSources.WZPersonalizeWeaponGroups = ListHelper_SetupDataSource("WZPersonalizeWeaponGroups", function(f128_arg0)
	local f128_local0 = {}
	local f128_local1 = Engine[@"currentsessionmode"]()
	for f128_local5, f128_local6 in ipairs(CoD.WZUtility.WZPersonalizeGroupNames) do
		local f128_local7 = CoD.CACUtility.GetUnlockableItemsForItemGroup(f128_arg0, f128_local1, f128_local6.weapon_category, true)
		if f128_local6.minUnlockableCount < #f128_local7 and not CoD.CACUtility.AllUnlockableItemsBanned(f128_local7) and not CoD.WZUtility.NoUnlockableItemsAbleToPersonalize(f128_local7) then
			table.insert(f128_local0, {
				models = {
					name = f128_local6.name,
				},
				properties = {
					loadoutType = f128_local6.loadoutType,
					category = f128_local6.weapon_category,
					itemGroup = f128_local6.itemGroup,
				},
			})
		end
	end
	return f128_local0
end, true)
CoD.WZUtility[@"hash_E6C072866FEDB9F"] = function()
	if not Engine[@"sessionmodeismode"](Enum[@"enetworkmodes"][@"mode_network_online"]) then
		return false
	else
		local f129_local0 = Engine[@"getplaylistinfobyid"](Engine[@"getplaylistid"]())
		return f129_local0.isSpectreRising == true
	end
end
CoD.WZUtility.CreateCharacterCategoryDataSource = function(f130_arg0, f130_arg1)
	local f130_local0 = "WZCharacters_" .. CoD.ModeToModeString(f130_arg1)
	DataSources[f130_local0] = DataSourceHelpers.ListSetup(f130_local0, function(f131_arg0, f131_arg1)
		local f131_local0 = {}
		local f131_local1 = CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f131_arg0)
		f131_arg1.persistSelectedIndex = true
		local f131_local2 = Engine[@"currentsessionmode"]()
		local f131_local3 = CoD.PlayerRoleUtility.GetHeroList(f131_local2)
		local f131_local4 = Engine[@"hash_2343E1D78ABC6BF1"]()
		local f131_local5 = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded(f131_arg0, f131_local2)
		local f131_local6 = true
		for f131_local27, f131_local28 in ipairs(f131_local3) do
			local f131_local29 = f131_local28.bodyIndex
			local f131_local30 = Engine[@"getpositionrolebundleinfo"](f131_local2, f131_local29)
			if f131_local30[@"modecategory"] == f130_arg1 and f131_local30[@"isdefaultcharacter"] ~= 1 and (not f131_local28[@"requireddvar"] or CoD.BaseUtility.IsDvarEnabled(f131_local28[@"requireddvar"])) then
				local f131_local10 = CoD.PlayerRoleUtility.IsRoleBMUnavailable(f131_arg0, f131_local2, f131_local29)
				if f131_local28.assetName == @"hash_2E611C081F273DE3" then
					f131_local10 = false
				end
				if not f131_local10 then
					local f131_local11 = CoD.PlayerRoleUtility.IsRoleBMLocked(f131_arg0, f131_local2, f131_local29)
					local f131_local12 = f131_local11
					local f131_local13
					if f131_local30[@"hash_9173E55822A88B5"] == 1 or not CoD.PlayerRoleUtility.IsRoleUnlocked(f131_arg0, f131_local2, f131_local29) then
						if f131_local30[@"hash_4C98250D6799E088"] == 1 then
							f131_local13 = not f131_local4
						else
							f131_local13 = f131_local12 or true
						end
					else
						f131_local13 = false
					end
					local f131_local14 = @"hash_2C79EA24AB1A2BA"
					if f131_local30[@"hash_5D48E06E94FE4AFA"] ~= 1 then
						if not Engine[@"hash_41641CC988E0FD5F"](f131_local2, f131_local29) and f131_local30[@"unavailabletext"] then
							f131_local14 = f131_local30[@"unavailabletext"]
						elseif f131_local13 and f131_local30[@"lockedtext"] then
							f131_local14 = f131_local30[@"lockedtext"]
						end
					end
					if Dvar[@"hash_5F037DBD87F8EA84"]:exists() and (IsDurango() or IsPC()) and (f131_local28.assetName == @"hash_253C65B5254C2343" or f131_local28.assetName == @"hash_691B38344E00A93" or f131_local28.assetName == @"hash_4D5EDAD18BF7D543" or f131_local28.assetName == @"hash_2D020F0DF0ECB942") then
						f131_local14 = f131_local30[@"unavailabletext"]
					end
					if not f131_local13 and f130_arg1 == Enum[@"emodes"][@"mode_multiplayer"] and IsBooleanDvarSet(@"hash_4A5FD7D94CFC9DFD") then
						local f131_local15 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f131_local2, f131_local29)
						local f131_local16 = nil
						for f131_local23, f131_local24 in ipairs(f131_local15.outfits) do
							for f131_local20, f131_local21 in ipairs(f131_local24.presets) do
								if CoD.BlackMarketTableUtility[@"hash_733358695872A441"][f131_local21.lootId] then
									f131_local16 = CoD.BlackMarketTableUtility.LootInfoLookup(f131_arg0, f131_local21.lootId)
									break
								end
							end
							if f131_local16 ~= nil then
							end
						end
						if f131_local16 then
							if f131_local16.isLoot and not f131_local16.owned and f131_local16.available then
								f131_local14 = f131_local30[@"hash_5FDA925CA4CC9404"] or f131_local14
							elseif not f131_local16.owned then
								f131_local14 = f131_local30[@"hash_29B85DE1CC11BAD"] or f131_local14
							else
								local f131_local15 = false
								if f131_local30[@"entitlement"] ~= nil and not Engine[@"hasentitlement"](f131_arg0, f131_local30[@"entitlement"]) then
									if f131_local30[@"hash_4C98250D6799E088"] == 1 then
										f131_local15 = not f131_local4
									else
										f131_local15 = true
									end
								end
								local f131_local16 = false
								if f131_local6 then
									f131_local16 = true
									f131_local6 = false
								end
								local f131_local17 = false
								if f131_local28.assetName == @"hash_2E611C081F273DE3" or f131_local28.assetName == @"hash_585374560A87B1E7" then
									local f131_local18
									if f131_local30[@"entitlement"] ~= nil then
										f131_local18 = Engine[@"hasentitlement"](f131_arg0, f131_local30[@"entitlement"])
									else
										f131_local18 = false
									end
									if f131_local18 or not f131_local11 then
										f131_local13 = false
										f131_local15 = false
										f131_local11 = false
										f131_local14 = @"hash_2C79EA24AB1A2BA"
									else
										f131_local17 = true
									end
								end
								local f131_local19 = CoD.PlayerRoleUtility.HasCustomization(f131_arg0, CoD.PlayerRoleUtility.GetCachedHeroCustomization(f131_local2, f131_local29))
								if not f131_local17 then
									local f131_local23 = {}
									local f131_local24 = {
										name = f131_local28.displayName,
									}
									local f131_local25 = f131_local28[@"fullname"]
									if not f131_local25 then
										f131_local25 = 0x0
									end
									f131_local24.fullName = f131_local25
									f131_local24.icon = f131_local28.positionDraftIcon
									f131_local24.characterIndex = f131_local29
									f131_local24.disabled = f131_local13
									f131_local24.isBMLocked = f131_local11
									f131_local24.jobTitle = CoD.PlayerRoleUtility.GetCharacterTraitTitle(f131_local2, f131_local29)
									f131_local24.tooltipArchetype = f131_arg1.tooltipArchetype
									f131_local24.characterInT4 = f131_local30[@"hash_4BF1CCE3018DC22F"] == 1
									f131_local24.characterInT5 = f131_local30[@"hash_4BF1CBE3018DC07C"] == 1
									f131_local24.characterInT6 = f131_local30[@"hash_4BF1CEE3018DC595"] == 1
									f131_local24.characterInT7 = f131_local30[@"hash_4BF1CDE3018DC3E2"] == 1
									f131_local24.characterInT8 = f131_local30[@"hash_4BF1D0E3018DC8FB"] == 1
									f131_local24.isSelected = f131_local1 == f131_local29
									f131_local24.customizationMode = f130_arg1
									f131_local24.isDefaultCharacter = f131_local30[@"isdefaultcharacter"] == 1
									f131_local24.availabilityText = f131_local14
									f131_local24.purchasable = f131_local15
									f131_local24.breadcrumb = f131_local5[CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f131_local2] .. f131_local29]
									f131_local24.isEchelonUnlock = f131_local30[0x8E63886F9B0BAB] == 1
									f131_local24.hasCustomization = f131_local19
									f131_local24.previewEnabled = f130_arg1 == Enum[@"emodes"][@"mode_multiplayer"]
									f131_local23.models = f131_local24
									f131_local23.properties = {
										characterIndex = f131_local29,
										character = f131_local28,
										sortIndex = f131_local30[@"sortindex"],
										selectIndex = f131_local16,
										purchasable = f131_local15,
									}
									table.insert(f131_local0, f131_local23)
								end
							end
						else
							local f131_local15 = false
							if f131_local30[@"entitlement"] ~= nil and not Engine[@"hasentitlement"](f131_arg0, f131_local30[@"entitlement"]) then
								if f131_local30[@"hash_4C98250D6799E088"] == 1 then
									f131_local15 = not f131_local4
								else
									f131_local15 = true
								end
							end
							local f131_local16 = false
							if f131_local6 then
								f131_local16 = true
								f131_local6 = false
							end
							local f131_local17 = false
							if f131_local28.assetName == @"hash_2E611C081F273DE3" or f131_local28.assetName == @"hash_585374560A87B1E7" then
								local f131_local18
								if f131_local30[@"entitlement"] ~= nil then
									f131_local18 = Engine[@"hasentitlement"](f131_arg0, f131_local30[@"entitlement"])
								else
									f131_local18 = false
								end
								if f131_local18 or not f131_local11 then
									f131_local13 = false
									f131_local15 = false
									f131_local11 = false
									f131_local14 = @"hash_2C79EA24AB1A2BA"
								else
									f131_local17 = true
								end
							end
							local f131_local19 = CoD.PlayerRoleUtility.HasCustomization(f131_arg0, CoD.PlayerRoleUtility.GetCachedHeroCustomization(f131_local2, f131_local29))
							if not f131_local17 then
								local f131_local23 = {}
								local f131_local24 = {
									name = f131_local28.displayName,
								}
								local f131_local25 = f131_local28[@"fullname"]
								if not f131_local25 then
									f131_local25 = 0x0
								end
								f131_local24.fullName = f131_local25
								f131_local24.icon = f131_local28.positionDraftIcon
								f131_local24.characterIndex = f131_local29
								f131_local24.disabled = f131_local13
								f131_local24.isBMLocked = f131_local11
								f131_local24.jobTitle = CoD.PlayerRoleUtility.GetCharacterTraitTitle(f131_local2, f131_local29)
								f131_local24.tooltipArchetype = f131_arg1.tooltipArchetype
								f131_local24.characterInT4 = f131_local30[@"hash_4BF1CCE3018DC22F"] == 1
								f131_local24.characterInT5 = f131_local30[@"hash_4BF1CBE3018DC07C"] == 1
								f131_local24.characterInT6 = f131_local30[@"hash_4BF1CEE3018DC595"] == 1
								f131_local24.characterInT7 = f131_local30[@"hash_4BF1CDE3018DC3E2"] == 1
								f131_local24.characterInT8 = f131_local30[@"hash_4BF1D0E3018DC8FB"] == 1
								f131_local24.isSelected = f131_local1 == f131_local29
								f131_local24.customizationMode = f130_arg1
								f131_local24.isDefaultCharacter = f131_local30[@"isdefaultcharacter"] == 1
								f131_local24.availabilityText = f131_local14
								f131_local24.purchasable = f131_local15
								f131_local24.breadcrumb = f131_local5[CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f131_local2] .. f131_local29]
								f131_local24.isEchelonUnlock = f131_local30[0x8E63886F9B0BAB] == 1
								f131_local24.hasCustomization = f131_local19
								f131_local24.previewEnabled = f130_arg1 == Enum[@"emodes"][@"mode_multiplayer"]
								f131_local23.models = f131_local24
								f131_local23.properties = {
									characterIndex = f131_local29,
									character = f131_local28,
									sortIndex = f131_local30[@"sortindex"],
									selectIndex = f131_local16,
									purchasable = f131_local15,
								}
								table.insert(f131_local0, f131_local23)
							end
						end
					end
					local f131_local15 = false
					if f131_local30[@"entitlement"] ~= nil and not Engine[@"hasentitlement"](f131_arg0, f131_local30[@"entitlement"]) then
						if f131_local30[@"hash_4C98250D6799E088"] == 1 then
							f131_local15 = not f131_local4
						else
							f131_local15 = true
						end
					end
					local f131_local16 = false
					if f131_local6 then
						f131_local16 = true
						f131_local6 = false
					end
					local f131_local17 = false
					if f131_local28.assetName == @"hash_2E611C081F273DE3" or f131_local28.assetName == @"hash_585374560A87B1E7" then
						local f131_local18
						if f131_local30[@"entitlement"] ~= nil then
							f131_local18 = Engine[@"hasentitlement"](f131_arg0, f131_local30[@"entitlement"])
						else
							f131_local18 = false
						end
						if f131_local18 or not f131_local11 then
							f131_local13 = false
							f131_local15 = false
							f131_local11 = false
							f131_local14 = @"hash_2C79EA24AB1A2BA"
						else
							f131_local17 = true
						end
					end
					local f131_local19 = CoD.PlayerRoleUtility.HasCustomization(f131_arg0, CoD.PlayerRoleUtility.GetCachedHeroCustomization(f131_local2, f131_local29))
					if not f131_local17 then
						local f131_local23 = {}
						local f131_local24 = {
							name = f131_local28.displayName,
						}
						local f131_local25 = f131_local28[@"fullname"]
						if not f131_local25 then
							f131_local25 = 0x0
						end
						f131_local24.fullName = f131_local25
						f131_local24.icon = f131_local28.positionDraftIcon
						f131_local24.characterIndex = f131_local29
						f131_local24.disabled = f131_local13
						f131_local24.isBMLocked = f131_local11
						f131_local24.jobTitle = CoD.PlayerRoleUtility.GetCharacterTraitTitle(f131_local2, f131_local29)
						f131_local24.tooltipArchetype = f131_arg1.tooltipArchetype
						f131_local24.characterInT4 = f131_local30[@"hash_4BF1CCE3018DC22F"] == 1
						f131_local24.characterInT5 = f131_local30[@"hash_4BF1CBE3018DC07C"] == 1
						f131_local24.characterInT6 = f131_local30[@"hash_4BF1CEE3018DC595"] == 1
						f131_local24.characterInT7 = f131_local30[@"hash_4BF1CDE3018DC3E2"] == 1
						f131_local24.characterInT8 = f131_local30[@"hash_4BF1D0E3018DC8FB"] == 1
						f131_local24.isSelected = f131_local1 == f131_local29
						f131_local24.customizationMode = f130_arg1
						f131_local24.isDefaultCharacter = f131_local30[@"isdefaultcharacter"] == 1
						f131_local24.availabilityText = f131_local14
						f131_local24.purchasable = f131_local15
						f131_local24.breadcrumb = f131_local5[CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f131_local2] .. f131_local29]
						f131_local24.isEchelonUnlock = f131_local30[0x8E63886F9B0BAB] == 1
						f131_local24.hasCustomization = f131_local19
						f131_local24.previewEnabled = f130_arg1 == Enum[@"emodes"][@"mode_multiplayer"]
						f131_local23.models = f131_local24
						f131_local23.properties = {
							characterIndex = f131_local29,
							character = f131_local28,
							sortIndex = f131_local30[@"sortindex"],
							selectIndex = f131_local16,
							purchasable = f131_local15,
						}
						table.insert(f131_local0, f131_local23)
					end
				end
			end
		end
		table.sort(f131_local0, function(f132_arg0, f132_arg1)
			if f132_arg0.properties.purchasable ~= f132_arg1.properties.purchasable then
				if not f132_arg0.models.disabled then
					return f132_arg1.properties.purchasable
				else
					return f132_arg0.properties.purchasable
				end
			elseif f132_arg0.models.disabled ~= f132_arg1.models.disabled then
				return f132_arg1.models.disabled
			else
				return f132_arg0.properties.sortIndex < f132_arg1.properties.sortIndex
			end
		end)
		return f131_local0
	end)
	return f130_local0
end
DataSources.WZCharacterCategories = DataSourceHelpers.ListSetup("WZCharacterCategories", function(f133_arg0, f133_arg1)
	local f133_local0 = "CoD.CharacterSelection_StandardFrameWidget"
	local f133_local1 = "CoD.WZPersonalizeCharacter_StandardFrameWidget"
	local f133_local2 = CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f133_arg0)
	local f133_local3 = nil
	local f133_local4 = Engine[@"getpositionrolebundleinfo"](Engine[@"currentsessionmode"](), f133_local2)
	if f133_local4 then
		f133_local3 = f133_local4[@"modecategory"]
	end
	local f133_local5 = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded(f133_arg0, Engine[@"currentsessionmode"]())
	local f133_local6 = {
		{
			mode = Enum[@"emodes"][@"mode_warzone"],
			name = @"menu/warzone",
			frameWidget = "CoD.CharacterSelection_CustomCharacterFrameWidget",
			personalizeFrameWidget = "CoD.WZPersonalizeCharacter_CustomCharacterFrameWidget",
		},
		{
			mode = Enum[@"emodes"][@"mode_zombies"],
			name = @"menu/zombies",
		},
		{
			mode = Enum[@"emodes"][@"mode_multiplayer"],
			name = @"menu/multiplayer",
		},
	}
	local f133_local7 = {}
	for f133_local12, f133_local13 in ipairs(f133_local6) do
		local f133_local14 = CoD.ModeToModeString(f133_local13.mode)
		local f133_local15 = table.insert
		local f133_local16 = f133_local7
		local f133_local17 = {}
		local f133_local18 = {
			name = f133_local13.name,
		}
		local f133_local11 = f133_local13.frameWidget
		if not f133_local11 then
			f133_local11 = f133_local0
		end
		f133_local18.frameWidget = f133_local11
		f133_local11 = f133_local13.personalizeFrameWidget
		if not f133_local11 then
			f133_local11 = f133_local1
		end
		f133_local18.personalizeFrameWidget = f133_local11
		f133_local18.characterDatasource = CoD.WZUtility.CreateCharacterCategoryDataSource(f133_arg0, f133_local13.mode)
		f133_local18.playRevealClip = false
		f133_local18.mode = f133_local13.mode
		f133_local18.breadcrumb = f133_local5["wz_specialist_" .. f133_local14]
		f133_local17.models = f133_local18
		f133_local17.properties = {
			selectIndex = f133_local3 == f133_local13.mode,
		}
		f133_local15(f133_local16, f133_local17)
	end
	return f133_local7
end)
DataSourceHelpers.PerControllerDataSourceSetup("WZDefaultCharacterInfo", "WZDefaultCharacterInfo", function(f134_arg0, f134_arg1)
	local f134_local0 = {}
	local f134_local1 = Engine[@"currentsessionmode"]()
	local f134_local2 = CoD.PlayerRoleUtility.GetHeroList(f134_local1)
	local f134_local3 = Engine[@"hash_3FC41172469DB251"](f134_arg1)
	local f134_local4 = f134_local3[@"hash_6A8BD5071BCB463C"]:get()
	local f134_local5 = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded(f134_arg1, f134_local1)
	for f134_local9, f134_local10 in ipairs(f134_local2) do
		local f134_local11 = f134_local10.bodyIndex
		local f134_local12 = Engine[@"getpositionrolebundleinfo"](f134_local1, f134_local11)
		if f134_local12[@"isdefaultcharacter"] == 1 then
			if f134_local11 == f134_local4 then
				break
			end
			table.insert(f134_local0, f134_local11)
		end
		if f134_local11 == f134_local4 then
			f134_local4 = nil
		end
	end
	f134_local6 = f134_local4
	if not f134_local6 then
		f134_local6 = f134_local0[math.random(#f134_local0)]
		f134_local3[@"hash_6A8BD5071BCB463C"]:set(f134_local6)
	end
	f134_local7 = Engine[@"getgamertagforcontroller"](f134_arg1)
	f134_local8 = CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f134_arg1)
	f134_local9 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f134_local1, f134_local6)
	f134_local10 = f134_arg0:create("name")
	f134_local10:set(f134_local7)
	f134_local10 = f134_arg0:create("fullName")
	f134_local10:set(f134_local7)
	f134_local10 = f134_arg0:create("characterIndex")
	f134_local10:set(f134_local6)
	f134_local10 = f134_arg0:create("icon")
	local f134_local11 = f134_local10
	f134_local10 = f134_local10.set
	local f134_local12
	if f134_local9 then
		f134_local12 = f134_local9[@"hash_1ABF9CD0B63BCB25"]
		if not f134_local12 then
		else
			f134_local10(f134_local11, f134_local12)
			f134_local10 = f134_arg0:create("jobTitle")
			f134_local10:set(@"menu/default_character")
			f134_local10 = f134_arg0:create("disabled")
			f134_local10:set(false)
			f134_local10 = f134_arg0:create("characterInT4")
			f134_local10:set(false)
			f134_local10 = f134_arg0:create("characterInT5")
			f134_local10:set(false)
			f134_local10 = f134_arg0:create("characterInT6")
			f134_local10:set(false)
			f134_local10 = f134_arg0:create("characterInT7")
			f134_local10:set(false)
			f134_local10 = f134_arg0:create("characterInT8")
			f134_local10:set(false)
			f134_local10 = f134_arg0:create("customizationMode")
			f134_local10:set(Enum[@"emodes"][@"mode_warzone"])
			f134_local10 = f134_arg0:create("isDefaultCharacter")
			f134_local10:set(true)
			f134_local10 = f134_arg0:create("availabilityText")
			f134_local10:set(@"hash_2C79EA24AB1A2BA")
			f134_local10 = f134_arg0:create("isEchelonUnlock")
			f134_local10:set(false)
			f134_local10 = f134_arg0:create("hasCustomization")
			f134_local10:set(true)
			f134_local10 = f134_arg0:create("breadcrumb")
			f134_local10:set(f134_local5[CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f134_local1] .. f134_local6])
		end
	end
	f134_local12 = @"blacktransparent"
end, false)
DataSourceHelpers.GlobalDataSourceSetup("WarzoneGlobal", "hudItems.warzone", function(f135_arg0)
	f135_arg0:create("collapseTimerState")
	f135_arg0:create("collapseProgress")
	f135_arg0:create("reinsertionIndex")
	f135_arg0:create("collapseCount")
	f135_arg0:create("srProtoTimer")
end, false)
DataSourceHelpers.PerControllerDataSourceSetup("WarzonePerController", "hudItems.warzone", function(f136_arg0, f136_arg1)
	CoD.WZUtility.SetMapZoomModel(f136_arg1, f136_arg0:create("mapZoom"), 1)
	CoD.WZUtility.SetMapPanModel(f136_arg1, f136_arg0:create("mapPan"), 0, 0)
	local f136_local0 = f136_arg0:create("markerPos")
	f136_local0:set({
		x = 0.5,
		y = 0.5,
	})
end, false)
CoD.WZUtility.ZoomRange = {
	MAP_ZOOM_MIN = 1,
	MAP_ZOOM_MAX = 4,
}
CoD.WZUtility.MaxWidgetScaleFactor = Engine[@"issplitscreen"]() and 1.1 or 2.18
CoD.WZUtility.ScreenHeight = 1080
CoD.WZUtility.ZoomMap = function(f137_arg0, f137_arg1, f137_arg2)
	if f137_arg1 then
		local f137_local0 = Engine[@"getmodelforcontroller"](f137_arg0)
		if not IsRepeatButtonPress(f137_local0["ButtonBits." .. Enum[@"luibutton"][@"lui_key_rtrig"]]) then
			CoD.WZUtility.DisableZoomIn[f137_arg0] = false
		end
	else
		local f137_local0 = Engine[@"getmodelforcontroller"](f137_arg0)
		if not IsRepeatButtonPress(f137_local0["ButtonBits." .. Enum[@"luibutton"][@"lui_key_ltrig"]]) then
			CoD.WZUtility.DisableZoomOut[f137_arg0] = false
		end
	end
	local f137_local0 = true
	if f137_arg1 then
		if CoD.WZUtility.DisableZoomIn[f137_arg0] then
			f137_local0 = false
		end
	elseif CoD.WZUtility.DisableZoomOut[f137_arg0] then
		f137_local0 = false
	end
	if f137_local0 then
		local f137_local1 = Engine[@"getmodelforcontroller"](f137_arg0)
		f137_local1 = f137_local1.hudItems.warzone
		if not f137_arg1 or not 1.02 then
			local f137_local2 = 0.98
		end
		local f137_local2
		if CoD.isPC then
			if f137_arg1 then
				local f137_local3 = 1.08
			end
			f137_local2 = f137_local3 or 0.92
		end
		local f137_local4 = f137_local1.mapZoom:get()
		if f137_local4 >= CoD.WZUtility.MaxWidgetScaleFactor then
			f137_local2 = f137_local2 * f137_local2
		end
		CoD.WZUtility.SetNewZoomInternal(f137_arg0, f137_local1, LUI.clamp(f137_local4 * f137_local2, CoD.WZUtility.ZoomRange.MAP_ZOOM_MIN, CoD.WZUtility.ZoomRange.MAP_ZOOM_MAX), f137_arg1, f137_arg2)
	end
	if IsGamepad(f137_arg0) then
		Engine[@"blockgamefromkeyevent"]()
	end
end
CoD.WZUtility.SetNewZoomInternal = function(f138_arg0, f138_arg1, f138_arg2, f138_arg3, f138_arg4)
	local f138_local0 = f138_arg1.mapZoom:get()
	if f138_arg2 <= CoD.WZUtility.ZoomRange.MAP_ZOOM_MAX then
		CoD.WZUtility.SetMapZoomModel(f138_arg0, f138_arg1.mapZoom, f138_arg2)
		local f138_local1, f138_local2 = nil
		if IsMouseOrKeyboard(f138_arg0) then
			local f138_local3, f138_local4, f138_local5, f138_local6 = Engine[@"hash_3695399A0E06EC35"](f138_arg0, f138_arg4)
			local f138_local7 = DataSources.FreeCursor.getModel(f138_arg0)
			local f138_local7, f138_local8 = f138_local7.position:get()
			f138_local2 = f138_local8
			f138_local1 = (f138_local7 - f138_local3) / (f138_local5 - f138_local3)
			f138_local2 = (f138_local2 - f138_local4) / (f138_local6 - f138_local4)
		else
			f138_local1, f138_local2 = f138_arg1.markerPos:get()
		end
		local f138_local3, f138_local4 = f138_arg1.mapPan:get()
		local f138_local5 = 1 / f138_local0
		local f138_local6 = 1 / f138_arg2
		local f138_local7 = f138_local6 - f138_local5
		local f138_local8 = -(f138_local1 * f138_local7)
		local f138_local9 = -(f138_local2 * f138_local7)
		f138_local8 = f138_local8 + f138_local3
		f138_local9 = f138_local9 + f138_local4
		local f138_local10 = 1 - f138_local6
		local f138_local11 = LUI.clamp(f138_local8, 0, f138_local10)
		local f138_local12 = LUI.clamp(f138_local9, 0, f138_local10)
		CoD.WZUtility.SetMapPanModel(f138_arg0, f138_arg1.mapPan, f138_local11, f138_local12)
		f138_arg1.markerPos:set({
			x = f138_local1 - (f138_local11 - f138_local8) / f138_local6,
			y = f138_local2 - (f138_local12 - f138_local9) / f138_local6,
		})
	end
end
CoD.WZUtility.CenterCursorOnPlayer = function(f139_arg0, f139_arg1)
	local f139_local0 = Engine[@"hash_4E1D6BCF7D3131C5"](f139_arg0)
	local f139_local1, f139_local2 = CoD.HUDUtility.TransformWorldPosToCompassRelativePosition(f139_arg0, f139_local0.x, f139_local0.y)
	local f139_local3 = Engine[@"getmodelforcontroller"](f139_arg0)
	f139_local3 = f139_local3.hudItems.warzone
	local f139_local4 = f139_local3.mapZoom:get()
	CoD.WZUtility.SetNewZoomInternal(f139_arg0, f139_local3, 1, f139_arg1)
	f139_local3.markerPos:set({
		x = f139_local1,
		y = f139_local2,
	})
	CoD.WZUtility.SetNewZoomInternal(f139_arg0, f139_local3, f139_local4, f139_arg1)
end
CoD.WZUtility.InventoryIconsToStream = {}
DataSourceHelpers.PerControllerDataSourceSetup(
	"WarzoneInventory",
	"hudItems.inventory",
	function(f140_arg0, f140_arg1)
		if not f140_arg0.count then
			local f140_local0 = f140_arg0:create("count")
			f140_local0:set(0)
		end
		if not f140_arg0.selectedIndex then
			local f140_local0 = f140_arg0:create("selectedIndex")
			f140_local0:set(0)
		end
		local f140_local0 = f140_arg0:create("selectedItemName")
		f140_local0:set("")
		f140_local0 = f140_arg0:create("quickConsumeIndex")
		f140_local0:set(0)
		f140_local0 = f140_arg0:create("quickConsumeNetworkId")
		f140_local0:set(0)
		f140_local0 = f140_arg0:create("pickedUpItem")
		f140_local0:set(0x0)
		f140_local0 = f140_arg0:create("droppedItem")
		f140_local0:set(0x0)
		f140_local0 = f140_arg0:create("consumedItem")
		f140_local0:set(0x0)
		f140_local0 = f140_arg0:create("cannotEquipItem")
		f140_local0:set("")
		f140_local0 = f140_arg0:create("hasArmor")
		f140_local0:set(false)
		f140_local0 = f140_arg0:create("pickedUpWeapon")
		f140_local0:set(0x0)
		f140_local0 = f140_arg0:create("droppedWeapon")
		f140_local0:set(0x0)
		f140_local0 = f140_arg0:create("canUseQuickInventory")
		f140_local0:set(false)
		f140_local0 = f140_arg0:create("canNavigateLeft")
		f140_local0:set(false)
		f140_local0 = f140_arg0:create("canNavigateRight")
		f140_local0:set(false)
		f140_local0 = f140_arg0:create("canTransferFromStash")
		f140_local0:set(false)
		f140_local0 = f140_arg0:create("availableGearCount")
		f140_local0:set(0)
		f140_local0 = f140_arg0:create("availableHealthCount")
		f140_local0:set(0)
		f140_local0 = f140_arg0:create("availableAttachmentCount")
		f140_local0:set(0)
		f140_local0 = f140_arg0:create("availableEquipmentCount")
		f140_local0:set(0)
		f140_local0 = f140_arg0:create("availableConsumableCount")
		f140_local0:set(0)
		f140_local0 = f140_arg0:create("currentWeaponIndex")
		f140_local0:set(0)
		f140_arg0:create("currentWeapon")
		f140_local0 = f140_arg0:create("showAttachments")
		f140_local0:set(false)
		f140_local0 = f140_arg0:create("isOpen")
		f140_local0:set(false)
		f140_local0 = f140_arg0:create("inventoryNag")
		local f140_local1 = f140_local0
		f140_local0 = f140_local0.set
		local f140_local2 = f140_arg0.inventoryNag:get()
		if not f140_local2 then
			f140_local2 = CoD.WZUtility.InventoryNag.NAG_NOT_SEEN
		end
		f140_local0(f140_local1, f140_local2)
		if not DataSources.WarzoneInventory.currentWeaponSubscriptions then
			DataSources.WarzoneInventory.currentWeaponSubscriptions = {}
		end
		if not DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1] then
			DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1] = LUI.UIElement.new()
			DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1].currentForcedImage = nil
			DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1]:subscribeToModel(f140_arg0.currentWeapon, function(model)
				if model:get() then
					if DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1].currentForcedImage then
						Engine[0xE76D1EBA02208C](DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1].currentForcedImage)
					end
					local f141_local0 = CoD.WZUtility.GetPreviewImageLarge(model:get())
					if f141_local0 then
						f141_local0 = Engine[@"hash_1BF99001028052B9"](f141_local0)
					end
					if f141_local0 ~= nil and f141_local0 ~= 0x0 then
						Engine[@"hash_8A31148EE1BE3B1"](f141_local0)
						DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1].currentForcedImage = f141_local0
					end
				end
			end)
			DataSources.WarzoneInventory.currentWeaponSubscriptions[f140_arg1]:subscribeToModel(f140_arg0.pickedUpItem, function(model)
				if model:get() and model:get() ~= 0x0 then
					local f142_local0 = DataSources.WarzoneInventory.getModel(f140_arg1)
					if f142_local0.inventoryNag:get() == CoD.WZUtility.InventoryNag.NAG_NOT_SEEN then
						f142_local0.inventoryNag:set(CoD.WZUtility.InventoryNag.NAG_VISIBLE)
					end
				end
			end)
		end
		if not f140_arg0.resourceCount then
			f140_local0 = f140_arg0:create("resourceCount")
			f140_local0:set(0)
		end
		if not f140_arg0.shardCount then
			f140_local0 = f140_arg0:create("shardCount")
			f140_local0:set(0)
		end
		f140_arg0:create("firstFreeSlot")
	end,
	false,
	{
		prepare = function(f143_arg0, f143_arg1, f143_arg2)
			f143_arg1._items = {}
			if not f143_arg1._rootModel then
				f143_arg1._rootModel = DataSources.WarzoneInventory.getModel(f143_arg0)
				f143_arg1:subscribeToModel(f143_arg1._rootModel.count, function()
					f143_arg1:updateDataSource(false, true)
				end, false)
				f143_arg1:subscribeToModel(f143_arg1._rootModel.filledSlots, function()
					f143_arg1:updateDataSource(false, true)
				end, false)
				f143_arg1._globalItemSubscriptions = {}
				f143_arg1._itemSubscriptions = {}
			end
			local f143_local0 = {
				equipment = 0,
				armor = 0,
				health = 0,
				attachment = 0,
			}
			local f143_local1 = {}
			local f143_local2 = false
			local f143_local3 = 0
			local f143_local4 = false
			local f143_local5 = f143_arg1._rootModel.count:get() or 0
			for f143_local6 = 0, CoD.WZUtility.InventorySize.ITEM_WORLD_PLAYER_INVENTORY_SIZE_BACKPACK - 1, 1 do
				local f143_local9 = f143_arg1._rootModel["item" .. f143_local6]
				if not f143_arg1._globalItemSubscriptions[f143_local6] then
					f143_arg1._globalItemSubscriptions[f143_local6] = true
					f143_arg1:subscribeToModel(f143_local9:create("quickEquip"), function()
						f143_arg1:updateDataSource(false, true)
					end, false)
				end
				if not f143_arg1.filter or f143_arg1.filter(f143_local9) then
					if not f143_arg1._itemSubscriptions[f143_local6] then
						f143_arg1._itemSubscriptions[f143_local6] = true
						f143_arg1:subscribeToModel(f143_local9:create("assetName"), function(model)
							local f147_local0 = {
								damage = 0,
								range = 0,
								fireRate = 0,
								accuracy = 0,
								valid = false,
							}
							local f147_local1 = model and model:get()
							if f147_local1 ~= nil then
								local f147_local2 = CoD.CACUtility.GetUnlockableItemInfoByAssetHash(f147_local1, Enum[@"emodes"][@"mode_warzone"])
								if f147_local2 ~= nil and f147_local2.attributesTable then
									f147_local0 = {
										damage = f147_local2.attributesTable.damage,
										range = f147_local2.attributesTable.range,
										fireRate = f147_local2.attributesTable.fireRate,
										accuracy = f147_local2.attributesTable.accuracy,
										valid = true,
									}
								end
							end
							local f147_local2 = f143_local9:create("attributes")
							for f147_local6, f147_local7 in pairs(f147_local0) do
								local f147_local8 = f147_local2:create(f147_local6)
								f147_local8:set(f147_local7)
							end
						end, true)
						f143_arg1:subscribeToModel(f143_local9:create("equipped"), function()
							f143_arg1:updateDataSource(false, true)
							CoD.WZUtility.UpdateSelectedItemName(f143_arg1.menu, f143_arg0)
						end, false)
						f143_arg1:subscribeToModel(f143_local9:create("notAvailable"), function()
							f143_arg1:updateDataSource(false, true)
							CoD.WZUtility.UpdateSelectedItemName(f143_arg1.menu, f143_arg0)
						end, false)
					end
					if f143_local9.backpackSlot and f143_local9.backpackSlot:get() == 1 and not f143_local4 then
						f143_local4 = true
						local f143_local10 = f143_local9:create("firstBackpackItem")
						f143_local10:set(true)
					else
						local f143_local10 = f143_local9:create("firstBackpackItem")
						f143_local10:set(false)
					end
					local f143_local10 = f143_local9.icon
					if f143_local10 then
						f143_local10 = f143_local9.icon:get()
					end
					CoD.BaseUtility.AddForcedImageToTable(f143_local10, f143_local1)
					table.insert(f143_arg1._items, f143_local9)
				end
				local f143_local10 = CoD.SafeGetModelValue(f143_local9, "type")
				if f143_local10 then
					if f143_local0[f143_local10] ~= nil then
						if f143_local10 ~= "attachment" or CoD.SafeGetModelValue(f143_local9, "availableAction") ~= CoD.WZUtility.ItemAvailableAction.NONE then
							f143_local0[f143_local10] = f143_local0[f143_local10] + 1
							f143_local2 = true
						end
					elseif f143_local10 == "generic" and CoD.SafeGetModelValue(f143_local9, "availableAction") == CoD.WZUtility.ItemAvailableAction.CONSUME then
						f143_local2 = true
						f143_local3 = f143_local3 + 1
					end
				end
			end
			CoD.WZUtility.InventoryIconsToStream = CoD.BaseUtility.ForceStreamHelper(CoD.WZUtility.InventoryIconsToStream, f143_local1)
			f143_arg1._rootModel.availableGearCount:set(f143_local0.armor)
			f143_arg1._rootModel.availableHealthCount:set(f143_local0.health)
			f143_arg1._rootModel.availableAttachmentCount:set(f143_local0.attachment)
			f143_arg1._rootModel.availableEquipmentCount:set(f143_local0.equipment)
			f143_arg1._rootModel.availableConsumableCount:set(f143_local3)
		end,
		getCount = function(f150_arg0)
			return f150_arg0._items and #f150_arg0._items or 0
		end,
		getItem = function(f151_arg0, f151_arg1, f151_arg2)
			return f151_arg1._items[f151_arg2]
		end,
		getSpacerAfterColumn = function(f152_arg0, f152_arg1, f152_arg2)
			if f152_arg0._firstBackPackSpacerDistance then
				local f152_local0 = f152_arg0._items[f152_arg1 + 1]
				if f152_local0 and f152_local0.firstBackpackItem:get() then
					return f152_arg0._firstBackPackSpacerDistance
				end
			end
			return 0
		end,
	}
)
CoD.WZUtility.SetupItemObjectives = function(f153_arg0, f153_arg1, f153_arg2)
	local f153_local0 = f153_arg1:getModel()
	local f153_local1 = f153_local0 and f153_local0.unlockableItemRef
	if f153_arg1.objectiveCompletedSubscription then
		f153_arg1:removeSubscription(f153_arg1.objectiveCompletedSubscription)
		f153_arg1.objectiveCompletedSubscription = nil
	end
	if f153_local1 and f153_local1:get() ~= 0x0 then
		local f153_local2 = Engine[@"hash_68FF94BB44442412"](f153_local1:get(), Enum[@"emodes"][@"mode_warzone"])
		local f153_local3 = Engine[@"getmodelforcontroller"](f153_arg0)
		f153_local3 = f153_local3.questInfo
		local f153_local4 = f153_local3 and f153_local3[f153_local2]
		if not f153_local4 then
			return
		end
		f153_arg1.objectiveCompletedSubscription = f153_arg1:subscribeToModel(f153_local4:create("completed"), function(model)
			f153_arg2:updateElementState(f153_arg1, {
				name = "model_validation",
				menu = f153_arg2,
				controller = f153_arg0,
				modelValue = model:get(),
				modelName = "completed",
			})
		end, true)
		if f153_arg1.WarzoneInventoryUnlockMissionObjective then
			f153_arg1.WarzoneInventoryUnlockMissionObjective:setModel(f153_local4, f153_arg0)
		end
	end
end
CoD.WZUtility.UpdateUnlockQuestState = function(f155_arg0, f155_arg1)
	local f155_local0 = CoD.GetScriptNotifyData(f155_arg1)
	local f155_local1 = f155_local0[1]
	local f155_local2 = f155_local0[2]
	local f155_local3 = Engine[@"getmodelforcontroller"](f155_arg0)
	f155_local3 = f155_local3:create("questInfo")
	local f155_local4 = f155_local3 and f155_local3:create(f155_local2)
	if not f155_local4 then
		return
	end
	local f155_local5 = 1
	for f155_local6 = 3, #f155_local0, 1 do
		local f155_local9 = f155_local4["objective" .. f155_local6 - 2]
		if not f155_local9 then
			f155_local9 = f155_local4:create("objective" .. f155_local6 - 2)
			f155_local9:create("state")
		end
		local f155_local10 = f155_local9 and f155_local9.state
		if f155_local10 then
			f155_local10:set(f155_local0[f155_local6])
			if f155_local0[f155_local6] ~= CoD.WZUtility.ObjectiveStates.COMPLETED then
				f155_local5 = 0
			end
		end
	end
	if f155_local1 == CoD.WZUtility.QuestItemUpdateTypes.CHARACTER_UNLOCK_UPDATE_ALREADY_COMPLETED then
		f155_local6 = f155_local4:create("completed")
		f155_local6:set(2)
	else
		local f155_local6 = f155_local4:create("completed")
		if f155_local6:get() ~= 2 then
			f155_local6 = f155_local4:create("completed")
			f155_local6:set(f155_local5)
		end
	end
end
CoD.WZUtility.IsQuestItem = function(f156_arg0, f156_arg1)
	local f156_local0 = f156_arg0:getModel()
	if not f156_local0 then
		return false
	elseif f156_local0.type and f156_local0.type:get() == "quest" then
		return true
	elseif f156_local0.unlockableItemRef and f156_local0.unlockableItemRef:get() ~= 0x0 then
		return true
	else
		return false
	end
end
CoD.WZUtility.WasQuestItemCompletedPreviously = function(f157_arg0, f157_arg1)
	local f157_local0 = f157_arg0:getModel()
	if not f157_local0 then
		return false
	elseif not f157_local0.unlockableItemRef or f157_local0.unlockableItemRef:get() == 0x0 then
		return false
	else
		local f157_local1 = Engine[@"hash_68FF94BB44442412"](f157_local0.unlockableItemRef:get(), Enum[@"emodes"][@"mode_warzone"])
		if f157_local1 == 0 then
			return false
		else
			local f157_local2 = Engine[@"getmodelforcontroller"](f157_arg1)
			f157_local2 = f157_local2:create("questInfo")
			local f157_local3 = f157_local2 and f157_local2[f157_local1]
			local f157_local4 = f157_local3 and f157_local3.completed
			if not f157_local4 then
				return false
			else
				return f157_local4:get() == 2
			end
		end
	end
end
CoD.WZUtility.HackCheckWZNeedsCursorMovement = function(f158_arg0, f158_arg1)
	if CoD.isPC and f158_arg1 and f158_arg1.GameEndScoreWZ and f158_arg1.GameEndScoreWZ.currentState ~= "DefaultState" then
		SetAllowCursorMovement(f158_arg1, true)
	end
end
CoD.WZUtility.GetDisplayNameFromRef = function(f159_arg0, f159_arg1)
	if not f159_arg0 then
		f159_arg0 = Engine[@"currentsessionmode"]()
	end
	if not f159_arg1 or f159_arg1 == "" then
		return 0x0
	end
	local f159_local0 = f159_arg1
	if type(f159_local0) ~= "xhash" then
		f159_local0 = Engine[@"converttoxhash"](f159_local0)
	end
	local f159_local1 = CoD.CACUtility.GetUnlockableItemInfo(Engine[@"hash_68FF94BB44442412"](f159_local0, f159_arg0), f159_arg0)
	return f159_local1.displayName
end
CoD.WZUtility.GetPreviewImageLargeFromRef = function(f160_arg0, f160_arg1)
	if not f160_arg0 then
		f160_arg0 = Engine[@"currentsessionmode"]()
	end
	if not f160_arg1 then
		return
	end
	local f160_local0 = f160_arg1
	if type(f160_local0) ~= "xhash" then
		f160_local0 = Engine[@"converttoxhash"](f160_local0)
	end
	local f160_local1 = CoD.CACUtility.GetUnlockableItemInfo(Engine[@"hash_68FF94BB44442412"](f160_local0, f160_arg0), f160_arg0)
	return f160_local1.previewImageLarge
end
CoD.WZUtility.GetUnlockMissionString = function(f161_arg0)
	local f161_local0 = Engine[@"currentsessionmode"]()
	local f161_local1 = CoD.CACUtility.GetUnlockableItemInfo(Engine[@"hash_68FF94BB44442412"](f161_arg0, f161_local0), f161_local0)
	if not f161_local1 then
		return @"hash_2C79EA24AB1A2BA"
	elseif f161_local1.itemGroup == "hero" then
		if f161_local1[@"hash_6C190A0450674B42"] == 1 and IsBooleanDvarSet(@"hash_4A5FD7D94CFC9DFD") then
			return @"wz/outfit_mission"
		else
			return @"wz/character_mission"
		end
	else
		return @"wz/unlock_steps"
	end
end
CoD.WZUtility.ClearInventoryNag = function(f162_arg0)
	local f162_local0 = DataSources.WarzoneInventory.getModel(f162_arg0)
	if f162_local0.inventoryNag ~= nil then
		f162_local0.inventoryNag:set(CoD.WZUtility.InventoryNag.NAG_DISMISSED)
	else
		local f162_local1 = f162_local0:create("inventoryNag")
		f162_local1:set(CoD.WZUtility.InventoryNag.NAG_DISMISSED)
	end
end
CoD.WZUtility.ShouldShowInventoryNag = function(f163_arg0)
	local f163_local0 = DataSources.WarzoneInventory.getModel(f163_arg0)
	f163_local0 = f163_local0.inventoryNag
	return f163_local0 and f163_local0:get() == CoD.WZUtility.InventoryNag.NAG_VISIBLE
end
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneInventoryGlobal", "hudItems.inventory", function(f164_arg0, f164_arg1)
	if not f164_arg0.equipment then
		f164_arg0:create("health")
		f164_arg0:create("gear")
		f164_arg0:create("storage")
		f164_arg0:create("equipment")
	end
	if not f164_arg0.equipment.slotName then
		local f164_local0 = f164_arg0.health:create("slotName")
		f164_local0:set(@"warzone/health")
		f164_local0 = f164_arg0.gear:create("slotName")
		f164_local0:set(@"warzone/gear")
		f164_local0 = f164_arg0.storage:create("slotName")
		f164_local0:set(@"warzone/storage")
		f164_local0 = f164_arg0.equipment:create("slotName")
		f164_local0:set(@"warzone/equipment")
	end
	f164_arg0:create("initialize")
end, false)
CoD.WZUtility.IsDualWeaponUIDisabled = function()
	local f165_local0 = IsBooleanDvarSet(@"hash_76BE0F6B780186B6")
	if not f165_local0 then
		f165_local0 = not CoD.isPC
	end
	return f165_local0
end
CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled = function()
	local f166_local0 = IsBooleanDvarSet(@"hash_74BCABB49DE7CBD1")
	if not f166_local0 then
		f166_local0 = not CoD.isPC
	end
	return f166_local0
end
CoD.WZUtility.PrepareAttachmentsForWeaponId = function(f167_arg0, f167_arg1, f167_arg2)
	local f167_local0 = {
		@"weapon/optic",
		@"weapon/barrel",
		@"weapon/under_barrel",
		@"hash_A7D7820F10FF00C",
		@"weapon/body",
		@"weapon/stock",
	}
	f167_arg1._items = {}
	if not f167_arg1._rootModel then
		f167_arg1._rootModel = DataSources.WarzoneInventory.getModel(f167_arg0)
		if CoD.WZUtility.IsDualWeaponUIDisabled() then
			f167_arg1:subscribeToModel(f167_arg1._rootModel.currentWeaponIndex, function()
				f167_arg1:updateDataSource(false, true)
			end, false)
		end
		f167_arg1._itemSubscriptions = {}
	end
	if f167_arg2 == 0 and CoD.WZUtility.IsDualWeaponUIDisabled() then
		f167_arg2 = f167_arg1._rootModel.currentWeaponIndex:get()
	end
	local f167_local1 = f167_arg1._rootModel.attachmentCount:get()
	local f167_local2 = f167_arg2 * f167_local1
	for f167_local3 = f167_local2, f167_local2 + (f167_local1 or 1) - 1, 1 do
		local f167_local6 = f167_arg1._rootModel["attachment" .. f167_local3]
		if not f167_local6.slotName then
			local f167_local7 = f167_local6:create("slotName")
			f167_local7:set(f167_local0[f167_local3 - f167_local2 + 1])
		end
		table.insert(f167_arg1._items, f167_local6)
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneAttachments", "hudItems.inventory", function(f169_arg0, f169_arg1) end, false, {
	prepare = function(f170_arg0, f170_arg1, f170_arg2)
		CoD.WZUtility.PrepareAttachmentsForWeaponId(f170_arg0, f170_arg1, 0)
	end,
	getCount = function(f171_arg0)
		return f171_arg0._items and #f171_arg0._items or 0
	end,
	getItem = function(f172_arg0, f172_arg1, f172_arg2)
		return f172_arg1._items[f172_arg2]
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneStowedAttachments", "hudItems.inventory", function(f173_arg0, f173_arg1) end, false, {
	prepare = function(f174_arg0, f174_arg1, f174_arg2)
		CoD.WZUtility.PrepareAttachmentsForWeaponId(f174_arg0, f174_arg1, 1)
	end,
	getCount = function(f175_arg0)
		return f175_arg0._items and #f175_arg0._items or 0
	end,
	getItem = function(f176_arg0, f176_arg1, f176_arg2)
		return f176_arg1._items[f176_arg2]
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneResources", "hudItems.inventory", function(f177_arg0, f177_arg1) end, false, {
	prepare = function(f178_arg0, f178_arg1, f178_arg2)
		f178_arg1._items = {}
		if not f178_arg1._rootModel then
			f178_arg1._rootModel = DataSources.WarzoneInventory.getModel(f178_arg0)
			f178_arg1:subscribeToModel(f178_arg1._rootModel.resourceCount, function()
				f178_arg1:updateDataSource(false, true)
			end, false)
			f178_arg1._itemSubscriptions = {}
		end
		for f178_local0 = 0, (f178_arg1._rootModel.resourceCount:get() or 1) - 1, 1 do
			table.insert(f178_arg1._items, f178_arg1._rootModel["resource" .. f178_local0])
		end
	end,
	getCount = function(f180_arg0)
		return f180_arg0._items and #f180_arg0._items or 0
	end,
	getItem = function(f181_arg0, f181_arg1, f181_arg2)
		return f181_arg1._items[f181_arg2]
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneShards", "hudItems.inventory", function(f182_arg0, f182_arg1) end, false, {
	prepare = function(f183_arg0, f183_arg1, f183_arg2)
		f183_arg1._items = {}
		if not f183_arg1._rootModel then
			f183_arg1._rootModel = DataSources.WarzoneInventory.getModel(f183_arg0)
			f183_arg1:subscribeToModel(f183_arg1._rootModel.shardCount, function()
				f183_arg1:updateDataSource(false, true)
			end, false)
			f183_arg1:subscribeToModel(f183_arg1._rootModel.filledSlots, function()
				f183_arg1:updateDataSource(false, true)
			end, false)
			f183_arg1._itemSubscriptions = {}
		end
		for f183_local0 = 0, (f183_arg1._rootModel.shardCount:get() or 1) - 1, 1 do
			local f183_local3 = f183_arg1._rootModel["shard" .. f183_local0]
			if not f183_arg1.filter or f183_arg1.filter(f183_local3) then
				table.insert(f183_arg1._items, f183_local3)
			end
		end
	end,
	getCount = function(f186_arg0)
		return f186_arg0._items and #f186_arg0._items or 0
	end,
	getItem = function(f187_arg0, f187_arg1, f187_arg2)
		return f187_arg1._items[f187_arg2]
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup(
	"WarzoneConsumed",
	"hudItems.inventory.consumed",
	function(f188_arg0, f188_arg1)
		f188_arg0:create("count")
	end,
	false,
	{
		prepare = function(f189_arg0, f189_arg1, f189_arg2)
			f189_arg1._items = {}
			if not f189_arg1._rootModel then
				f189_arg1._rootModel = DataSources.WarzoneConsumed.getModel(f189_arg0)
				f189_arg1:subscribeToModel(f189_arg1._rootModel.count, function()
					f189_arg1:updateDataSource(false, true)
				end, false)
			end
			local f189_local0 = 0
			local f189_local1 = f189_arg1._rootModel.count:get() or 1
			local f189_local2 = f189_local1 - 1
			if f189_arg1.firstHalf then
				f189_local2 = math.ceil(f189_local1 / 2) - 1
			elseif f189_arg1.secondHalf then
				f189_local0 = math.ceil(f189_local1 / 2)
			end
			for f189_local3 = f189_local0, f189_local2, 1 do
				table.insert(f189_arg1._items, f189_arg1._rootModel["item" .. f189_local3])
			end
		end,
		getCount = function(f191_arg0)
			return f191_arg0._items and #f191_arg0._items or 0
		end,
		getItem = function(f192_arg0, f192_arg1, f192_arg2)
			return f192_arg1._items[f192_arg2]
		end,
	}
)
DataSourceHelpers.PerControllerDataSourceSetup(
	"WarzoneSplitInventory",
	"hudItems.warzone.splitInventory",
	function(f193_arg0)
		local f193_local0 = f193_arg0:create("max")
		f193_local0:set(0)
		f193_local0 = f193_arg0:create("current")
		f193_local0:set(0)
		f193_local0 = f193_arg0:create("canIncrement")
		f193_local0:set(false)
		f193_local0 = f193_arg0:create("canDecrement")
		f193_local0:set(false)
	end,
	false,
	{
		updateIncrementDecrement = function(f194_arg0)
			local f194_local0 = DataSources.WarzoneSplitInventory.getModel(f194_arg0)
			f194_local0.canIncrement:set(f194_local0.current:get() < f194_local0.max:get())
			f194_local0.canDecrement:set(f194_local0.current:get() > 1)
		end,
		setupNewMax = function(f195_arg0, f195_arg1)
			local f195_local0 = DataSources.WarzoneSplitInventory.getModel(f195_arg0)
			f195_local0.max:set(f195_arg1)
			f195_local0.current:set(math.floor(f195_arg1 / 2))
			DataSources.WarzoneSplitInventory.updateIncrementDecrement(f195_arg0)
		end,
		getStepSize = function(f196_arg0)
			local f196_local0 = DataSources.WarzoneSplitInventory.getModel(f196_arg0)
			local f196_local1 = f196_local0.max:get()
			if f196_local1 <= 10 then
				return 1
			elseif f196_local1 <= 50 then
				return 5
			elseif f196_local1 <= 100 then
				return 10
			else
				return 25
			end
		end,
		increment = function(f197_arg0)
			local f197_local0 = DataSources.WarzoneSplitInventory.getModel(f197_arg0)
			f197_local0.current:set(math.min(f197_local0.current:get() + DataSources.WarzoneSplitInventory.getStepSize(f197_arg0), f197_local0.max:get()))
			DataSources.WarzoneSplitInventory.updateIncrementDecrement(f197_arg0)
		end,
		decrement = function(f198_arg0)
			local f198_local0 = DataSources.WarzoneSplitInventory.getModel(f198_arg0)
			f198_local0.current:set(math.max(f198_local0.current:get() - DataSources.WarzoneSplitInventory.getStepSize(f198_arg0), 1))
			DataSources.WarzoneSplitInventory.updateIncrementDecrement(f198_arg0)
		end,
	}
)
DataSources.WarzoneMapGridHorizontal = ListHelper_SetupDataSource("WarzoneMapGridHorizontal", function(f199_arg0)
	local f199_local0 = {}
	for f199_local4, f199_local5 in ipairs({
		"A",
		"B",
		"C",
		"D",
		"E",
		"F",
		"G",
		"H",
	}) do
		table.insert(f199_local0, {
			models = {
				text = f199_local5,
			},
		})
	end
	return f199_local0
end)
DataSources.WarzoneMapGridVertical = ListHelper_SetupDataSource("WarzoneMapGridVertical", function(f200_arg0)
	local f200_local0 = {}
	for f200_local4, f200_local5 in ipairs({
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
	}) do
		table.insert(f200_local0, {
			models = {
				text = f200_local5,
			},
		})
	end
	return f200_local0
end)
CoD.WZUtility.SetMapZoomModel = function(f201_arg0, f201_arg1, f201_arg2)
	Engine[@"hash_6DFE30B5C2E65604"](f201_arg0, f201_arg2)
	f201_arg1:set(f201_arg2)
end
CoD.WZUtility.SetMapPanModel = function(f202_arg0, f202_arg1, f202_arg2, f202_arg3)
	Engine[@"hash_2D51C8FE679C9A35"](f202_arg0, f202_arg2, f202_arg3)
	f202_arg1:set({
		x = f202_arg2,
		y = f202_arg3,
	})
end
CoD.WZUtility.InitColumnHeadingsForScaleAndPan = function(f203_arg0, f203_arg1, f203_arg2)
	local f203_local0 = Engine[@"getmodelforcontroller"](f203_arg0)
	f203_local0 = f203_local0.hudItems.warzone
	local f203_local1, f203_local2, f203_local3, f203_local4 = f203_arg2:getLocalLeftRight()
	f203_arg1:subscribeToModel(f203_local0.mapPan, function(model)
		local f204_local0, f204_local1 = model:get()
		local f204_local2 = f203_local0.mapZoom:get()
		f203_arg2:setLeftRight(-f204_local0 * f204_local2, (1 - f204_local0) * f204_local2, 0, 0)
	end, false)
	f203_arg1:subscribeToModel(f203_local0.mapZoom, function(model)
		local f205_local0, f205_local1 = f203_local0.mapPan:get()
		local f205_local2 = model:get()
		f203_arg2:setLeftRight(-f205_local0 * f205_local2, (1 - f205_local0) * f205_local2, 0, 0)
	end, false)
	local f203_local5 = f203_arg1
	local f203_local6 = f203_arg1.subscribeToModel
	local f203_local7 = Engine[@"getmodelforcontroller"](f203_arg0)
	f203_local6(f203_local5, f203_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f206_arg0)
		if Engine[@"isvisibilitybitset"](f203_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) then
			CoD.WZUtility.DisableZoomIn[f203_arg0] = false
			CoD.WZUtility.DisableZoomOut[f203_arg0] = false
			if CoD.ModelUtility.AreButtonModelValueBitsSet(f203_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], Enum[@"luibuttonflags"][@"flag_down"]) then
				CoD.WZUtility.DisableZoomIn[f203_arg0] = true
			end
			if CoD.ModelUtility.AreButtonModelValueBitsSet(f203_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibuttonflags"][@"flag_down"]) then
				CoD.WZUtility.DisableZoomOut[f203_arg0] = true
			end
		end
	end, false)
end
CoD.WZUtility.InitWidgetForMouseDrag = function(f207_arg0, f207_arg1, f207_arg2)
	local f207_local0 = {
		x = nil,
		y = nil,
	}
	local f207_local1 = function(f208_arg0, f208_arg1, f208_arg2, f208_arg3)
		local f208_local0 = f207_local0
		local f208_local1 = f207_local0
		local f208_local2 = f208_arg1.x
		f208_local1.y = f208_arg1.y
		f208_local0.x = f208_local2
		f208_arg3:CaptureMouseAndLockFocus(f208_arg2, f208_arg0)
		f208_arg0.__lockedFocus = true
	end
	local f207_local2 = function(f209_arg0, f209_arg1, f209_arg2, f209_arg3)
		local f209_local0 = f207_local0
		local f209_local1 = f207_local0
		local f209_local2 = nil
		f209_local1.y = nil
		f209_local0.x = f209_local2
		f209_arg3:CaptureMouseAndLockFocus(f209_arg2, nil)
		f209_arg0.lockedFocus = false
	end
	local f207_local3 = function(f210_arg0, f210_arg1, f210_arg2)
		if f207_local0.x ~= nil then
			local f210_local0 = Engine[@"getmodelforcontroller"](f210_arg2)
			f210_local0 = f210_local0.hudItems.warzone
			local f210_local1 = f210_local0.markerPos
			local f210_local2 = f207_local0.x - f210_arg1.x
			local f210_local3 = f207_local0.y - f210_arg1.y
			local f210_local4 = 0 * math.abs(f210_local2) / f210_local0.mapZoom:get()
			local f210_local5 = 0 * math.abs(f210_local3) / f210_local0.mapZoom:get()
			local f210_local6 = 1 - 1 / f210_local0.mapZoom:get()
			local f210_local7, f210_local8 = f210_local0.mapPan:get()
			local f210_local9 = 0
			local f210_local10 = 0
			if f210_local2 > 0 then
				f210_local9 = f210_local7 + f210_local4
			else
				f210_local9 = f210_local7 - f210_local4
			end
			if f210_local3 > 0 then
				f210_local10 = f210_local8 + f210_local5
			else
				f210_local10 = f210_local8 - f210_local5
			end
			CoD.WZUtility.SetMapPanModel(f210_arg2, f210_local0.mapPan, LUI.clamp(f210_local9, 0, f210_local6), LUI.clamp(f210_local10, 0, f210_local6))
			local f210_local11, f210_local12, f210_local13, f210_local14 = Engine[@"hash_3695399A0E06EC35"](f210_arg2, f210_arg0.ScoreboardGameStatusMap)
			local f210_local15, f210_local16 = f210_local1:get()
			f210_local1:set({
				x = LUI.clamp(f210_local15 + f210_local2 / (f210_local11 + f210_local13) / 2, 0.02, 0.98),
				y = LUI.clamp(f210_local16 + f210_local3 / (f210_local12 + f210_local14) / 2, 0.02, 0.98),
			})
			local f210_local17 = f207_local0
			local f210_local18 = f207_local0
			local f210_local19 = f210_arg1.x
			f210_local18.y = f210_arg1.y
			f210_local17.x = f210_local19
			f210_local17 = f207_local0
			f210_local18 = f207_local0
			f210_local19 = f210_arg1.x
			f210_local18.y = f210_arg1.y
			f210_local17.x = f210_local19
		end
	end
	local f207_local4 = function(f211_arg0, f211_arg1, f211_arg2)
		if f211_arg0.__lockedFocus then
			f211_arg2:CaptureMouseAndLockFocus(f211_arg1, nil)
			f211_arg0.__lockedFocus = false
		end
	end
	local f207_local5 = function(f212_arg0)
		if f212_arg0.__lockedFocus then
			f212_arg0.__lockedFocus = false
		end
	end
	f207_arg0:setHandleMouse(true)
	f207_arg0:registerEventHandler("rightmousedown", function(element, event)
		f207_local1(element, event, f207_arg1, f207_arg2)
	end)
	f207_arg0:registerEventHandler("rightmouseup", function(element, event)
		f207_local2(element, event, f207_arg1, f207_arg2)
	end)
	f207_arg0:registerEventHandler("rightmousedrag", function(element, event)
		f207_local3(element, event, f207_arg1)
	end)
	f207_arg0:registerEventHandler("lose_focus", function(element, event)
		f207_local4(element, f207_arg1, f207_arg2)
	end)
	f207_arg0:registerEventHandler("mouse_capture_lost", function(element, event)
		f207_local5(element)
	end)
	f207_arg0.__onBorderClose = function(f218_arg0, f218_arg1, f218_arg2)
		if f218_arg0.__lockedFocus then
			f218_arg2:CaptureMouseAndLockFocus(f218_arg1, nil)
			f218_arg0.__lockedFocus = false
		end
	end
	LUI.OverrideFunction_CallOriginalSecond(f207_arg0, "close", f207_arg0.__onBorderClose)
end
CoD.WZUtility.InitWidgetForScaleAndPan = function(f219_arg0, f219_arg1)
	local f219_local0 = Engine[@"getmodelforcontroller"](f219_arg0)
	f219_local0 = f219_local0.hudItems.warzone
	local f219_local1, f219_local2, f219_local3, f219_local4 = f219_arg1:getLocalTopBottom()
	local f219_local5 = f219_local4 - f219_local3 - 70
	f219_arg1._alteredPosition = false
	f219_arg1._currentTopPx = f219_local3
	f219_arg1._currentBottomPx = f219_local4
	local f219_local6 = function(f220_arg0, f220_arg1, f220_arg2)
		local f220_local0 = f219_local5 * f220_arg2 - CoD.WZUtility.ScreenHeight
		if f220_local0 > 0 then
			local f220_local1 = 0
			if f220_arg1 * f220_arg2 < 0.5 then
				f220_local1 = f220_local0 * 0.5
			elseif f220_arg2 - 0.5 < f220_arg1 * f220_arg2 then
				f220_local1 = -f220_local0 * 0.5
			else
				f220_local1 = f220_local0 * 0.5 - f220_local0 * (f220_arg1 * f220_arg2 - 0.5) / (f220_arg2 - 1)
			end
			f219_arg1._currentTopPx = f219_local3 + f220_local1
			f219_arg1._currentBottomPx = f219_local4 + f220_local1
			f219_arg1:setTopBottom(f219_local1, f219_local2, f219_arg1._currentTopPx, f219_arg1._currentBottomPx)
			f219_arg1._alteredPosition = true
		elseif f219_arg1._alteredPosition then
			f219_arg1:setTopBottom(f219_local1, f219_local2, f219_local3, f219_local4)
			f219_arg1._currentTopPx = f219_local3
			f219_arg1._currentBottomPx = f219_local4
			f219_arg1._alteredPosition = false
		end
	end
	f219_arg1:subscribeToModel(f219_local0.markerPos, function(model)
		local f221_local0 = math.min(f219_local0.mapZoom:get(), CoD.WZUtility.MaxWidgetScaleFactor)
		local f221_local1, f221_local2 = model:get()
		f219_local6(f221_local1, f221_local2, f221_local0)
	end, false)
	f219_arg1:subscribeToModel(f219_local0.mapZoom, function(model)
		local f222_local0 = math.min(model:get(), CoD.WZUtility.MaxWidgetScaleFactor)
		f219_arg1:setScale(f222_local0, f222_local0)
		local f222_local1, f222_local2 = f219_local0.markerPos:get()
		f219_local6(f222_local1, f222_local2, f222_local0)
	end, false)
end
CoD.WZUtility.InitRowHeadingsForScaleAndPan = function(f223_arg0, f223_arg1, f223_arg2)
	local f223_local0 = Engine[@"getmodelforcontroller"](f223_arg0)
	f223_local0 = f223_local0.hudItems.warzone
	local f223_local1, f223_local2, f223_local3, f223_local4 = f223_arg2:getLocalTopBottom()
	f223_arg1:subscribeToModel(f223_local0.mapPan, function(model)
		local f224_local0, f224_local1 = model:get()
		local f224_local2 = f223_local0.mapZoom:get()
		f223_arg2:setTopBottom(-f224_local1 * f224_local2, (1 - f224_local1) * f224_local2, 0, 0)
	end, false)
	f223_arg1:subscribeToModel(f223_local0.mapZoom, function(model)
		local f225_local0, f225_local1 = f223_local0.mapPan:get()
		local f225_local2 = model:get()
		f223_arg2:setTopBottom(-f225_local1 * f225_local2, (1 - f225_local1) * f225_local2, 0, 0)
	end, false)
end
CoD.WZUtility.Normalize = function(f226_arg0)
	local f226_local0 = math.sqrt(f226_arg0.x * f226_arg0.x + f226_arg0.y * f226_arg0.y)
	f226_arg0.x = f226_arg0.x / f226_local0
	f226_arg0.y = f226_arg0.y / f226_local0
	return f226_arg0
end
CoD.WZUtility.InitPlayerMarker = function(f227_arg0, f227_arg1, f227_arg2, f227_arg3)
	local f227_local0 = DataSources.RightStick.getModel(f227_arg3)
	local f227_local1 = 0.01
	local f227_local2, f227_local3, f227_local4, f227_local5 = f227_arg1:getLocalLeftRight()
	local f227_local6 = f227_local5 - f227_local4
	local f227_local7 = f227_local4
	local f227_local8, f227_local9, f227_local10, f227_local11 = f227_arg1:getLocalTopBottom()
	local f227_local12 = f227_local11 - f227_local10
	local f227_local13 = f227_local10
	local f227_local14, f227_local15, f227_local16, f227_local17 = f227_arg2:getLocalLeftRight()
	local f227_local18 = f227_local16 - f227_local6 * 0.5
	local f227_local19 = f227_local17 - f227_local6 * 0.5 - f227_local18
	local f227_local20, f227_local21, f227_local22, f227_local23 = f227_arg2:getLocalTopBottom()
	local f227_local24 = f227_local22 - f227_local12
	local f227_local25 = f227_local23 - f227_local12 - f227_local24
	local f227_local26 = Engine[@"getmodelforcontroller"](f227_arg3)
	f227_local26 = f227_local26.hudItems.warzone
	local f227_local27 = f227_local26.markerPos
	f227_local27:set({
		x = 0.5,
		y = 0.5,
	})
	f227_arg1:addElement(LUI.UITimer.newElementTimer(0, false, function()
		if IsSelfInState(f227_arg1, "Visible") then
			local f228_local0 = f227_local0.X:get()
			local f228_local1 = f227_local0.Y:get()
			if f228_local0 ~= 0 or f228_local1 ~= 0 then
				local f228_local2, f228_local3 = f227_local27:get()
				local f228_local4 = f228_local2 + f228_local0 * f227_local1
				local f228_local5 = f228_local3 - f228_local1 * f227_local1
				local f228_local6 = f228_local4 - f228_local2
				local f228_local7 = f228_local5 - f228_local3
				local f228_local8 = 1 / f227_local26.mapZoom:get()
				local f228_local9 = f228_local4 - 0.5
				local f228_local10 = (f228_local5 - 0.5) * -1
				local f228_local11 = f228_local9 * f228_local9
				local f228_local12 = f228_local10 * f228_local10
				local f228_local13 = {
					x = f228_local0,
					y = f228_local1,
				}
				local f228_local14 = {
					x = f228_local9,
					y = f228_local10,
				}
				f228_local13 = CoD.WZUtility.Normalize(f228_local13)
				f228_local14 = CoD.WZUtility.Normalize(f228_local14)
				local f228_local15 = f228_local13.x * f228_local14.x
				local f228_local16 = f228_local13.y * f228_local14.y
				local f228_local17 = 0.8
				local f228_local18 = 0.2 * f228_local8 * 0.05
				local f228_local19 = f228_local17
				local f228_local20 = f228_local18
				local f228_local21, f228_local22 = f227_local26.mapPan:get()
				local f228_local23 = 1 - 1 / f227_local26.mapZoom:get()
				local f228_local24
				if (f228_local0 >= 0 or f228_local21 <= 0) and (f228_local0 <= 0 or f228_local21 >= f228_local23) then
					f228_local24 = false
				else
					f228_local24 = true
				end
				local f228_local25
				if (-f228_local1 >= 0 or f228_local22 <= 0) and (-f228_local1 <= 0 or f228_local22 >= f228_local23) then
					f228_local25 = false
				else
					f228_local25 = true
				end
				local f228_local26 = 0.16
				if f228_local24 then
					if f228_local15 > 0 then
						local f228_local27 = LUI.clamp(f228_local11 / f228_local26, 0, 1) * f228_local15
						f228_local17 = f228_local17 - 0.7 * f228_local27
						f228_local18 = f228_local18 + f228_local18 * 0.8 * f228_local27
					else
						f228_local18 = f228_local18 * 0.8
					end
				end
				if f228_local25 then
					if f228_local16 > 0 then
						local f228_local27 = LUI.clamp(f228_local12 / f228_local26, 0, 1) * f228_local16
						f228_local19 = f228_local19 - 0.7 * f228_local27
						f228_local20 = f228_local20 + f228_local20 * 0.8 * f228_local27
					else
						f228_local20 = f228_local20 * 0.8
					end
				end
				f228_local4 = f228_local2 + f228_local6 * f228_local17
				f228_local5 = f228_local3 + f228_local7 * f228_local19
				f228_local21 = f228_local21 + f228_local0 * f228_local18
				f228_local22 = f228_local22 - f228_local1 * f228_local20
				f227_local27:set({
					x = LUI.clamp(f228_local4, 0.02, 0.98),
					y = LUI.clamp(f228_local5, 0.02, 0.98),
				})
				CoD.WZUtility.SetMapPanModel(f227_arg3, f227_local26.mapPan, LUI.clamp(f228_local21, 0, f228_local23), LUI.clamp(f228_local22, 0, f228_local23))
			end
		end
	end))
	f227_arg1:subscribeToModel(f227_local27, function()
		local f229_local0, f229_local1 = f227_local27:get()
		f227_local7 = f227_local18 + f229_local0 * f227_local19
		f227_local13 = f227_local24 + f229_local1 * f227_local25
		f227_arg1:setLeftRight(f227_local2, f227_local3, f227_local7, f227_local7 + f227_local6)
		f227_arg1:setTopBottom(f227_local8, f227_local9, f227_local13, f227_local13 + f227_local12)
	end, false)
	f227_arg1:subscribeToGlobalModel(f227_arg3, "PerController", "scriptNotify", function(model)
		local f230_local0 = f227_arg0
		local f230_local1 = CoD.GetScriptNotifyData(model)
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"teammate_waypoint_placed") then
			local f230_local2 = f230_local1[1]
			local f230_local3, f230_local4 = CoD.HUDUtility.TransformCompassRelativePositionToWorldPos(f227_arg3, f230_local1[2] / 999, f230_local1[3] / 999)
			Engine[@"sendclientscriptnotify"](f227_arg3, "teammate_waypoint_placed", {
				clientNum = f230_local2,
				localClientNum = Engine[@"getlocalclientnum"](f227_arg3),
				xCoord = f230_local3,
				yCoord = f230_local4,
			})
			local f230_local5 = Engine[@"getmodelforclient"](f230_local2)
			local f230_local6 = f230_local5:create("isMarkerIconPlaced")
			f230_local6:set(true)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"teammate_waypoint_removed") then
			local f230_local2 = f230_local1[1]
			Engine[@"sendclientscriptnotify"](f227_arg3, "teammate_waypoint_removed", {
				clientNum = f230_local2,
				localClientNum = Engine[@"getlocalclientnum"](f227_arg3),
			})
			local f230_local4 = Engine[@"getmodelforclient"](f230_local2)
			local f230_local7 = f230_local4:create("isMarkerIconPlaced")
			f230_local7:set(false)
		end
	end)
end
CoD.WZUtility.CheckAndSetInputBlocker = function(f231_arg0, f231_arg1, f231_arg2, f231_arg3)
	if f231_arg0._ignoreInputTimer then
		return false
	else
		f231_arg0._ignoreInputTimer = LUI.UITimer.newElementTimer(f231_arg1, true, function()
			f231_arg0._ignoreInputTimer = nil
			f231_arg2:set(f231_arg3)
		end)
		f231_arg0:addElement(f231_arg0._ignoreInputTimer)
		return true
	end
end
CoD.WZUtility.WaypointStatus = LuaEnum.createEnum("ALLOW_PLACEMENT", "ALLOW_DELETION", "POST_PLACEMENT_DELAY", "POST_DELETION_DELAY")
CoD.WZUtility.PlaceMarker = function(f233_arg0, f233_arg1, f233_arg2)
	local f233_local0 = Engine[@"getmodelforcontroller"](f233_arg0)
	f233_local0 = f233_local0.hudItems.waypointStatus
	if not CoD.WZUtility.CheckAndSetInputBlocker(f233_arg1, 200, f233_local0, CoD.WZUtility.WaypointStatus.ALLOW_DELETION) then
		return
	end
	local f233_local1, f233_local2, f233_local3, f233_local4 = f233_arg1:getLocalLeftRight()
	local f233_local5, f233_local6, f233_local7, f233_local8 = f233_arg1:getLocalTopBottom()
	local f233_local9, f233_local10, f233_local11, f233_local12 = f233_arg2:getLocalLeftRight()
	local f233_local13, f233_local14, f233_local15, f233_local16 = f233_arg2:getLocalTopBottom()
	local f233_local17, f233_local18 = nil
	local f233_local19 = Engine[@"getmodelforcontroller"](f233_arg0)
	f233_local19 = f233_local19.hudItems.warzone
	local f233_local20 = f233_local19.mapZoom:get()
	local f233_local21, f233_local22 = f233_local19.mapPan:get()
	if IsMouseOrKeyboard(f233_arg0) then
		local f233_local23 = 0
		local f233_local24 = 1
		f233_local11, f233_local15, f233_local12, f233_local16 = Engine[@"hash_3695399A0E06EC35"](f233_arg0, f233_arg2)
		local f233_local25 = DataSources.FreeCursor.getModel(f233_arg0)
		local f233_local25, f233_local26 = f233_local25.position:get()
		f233_local18 = f233_local26
		f233_local17 = (f233_local25 - f233_local11) / (f233_local12 - f233_local11)
		f233_local18 = (f233_local18 - f233_local15) / (f233_local16 - f233_local15)
		if f233_local24 < f233_local17 or f233_local17 < f233_local23 or f233_local24 < f233_local18 or f233_local18 < f233_local23 then
			return
		end
	else
		f233_local17 = (0.5 * (f233_local3 + f233_local4) - f233_local11) / (f233_local12 - f233_local11)
		f233_local18 = (f233_local8 - f233_local15) / (f233_local16 - f233_local15)
	end
	Engine[@"sendmenuresponse"](f233_arg0, "WaypointPlaced", "placed", math.floor((f233_local17 / f233_local20 + f233_local21) * 999) * 1000 + math.floor((f233_local18 / f233_local20 + f233_local22) * 999))
	f233_local0:set(CoD.WZUtility.WaypointStatus.POST_PLACEMENT_DELAY)
	Engine[@"playsound"]("uin_warzone_waypoint_place")
	if IsGamepad(f233_arg0) then
		Engine[@"blockgamefromkeyevent"]()
	end
end
CoD.WZUtility.RemoveMarker = function(f234_arg0, f234_arg1)
	local f234_local0 = Engine[@"getmodelforcontroller"](f234_arg0)
	f234_local0 = f234_local0.hudItems.waypointStatus
	if not CoD.WZUtility.CheckAndSetInputBlocker(f234_arg1, 200, f234_local0, CoD.WZUtility.WaypointStatus.ALLOW_PLACEMENT) then
		return
	end
	Engine[@"sendmenuresponse"](f234_arg0, "WaypointPlaced", "removed", 0)
	f234_local0:set(CoD.WZUtility.WaypointStatus.POST_DELETION_DELAY)
	Engine[@"playsound"]("uin_warzone_waypoint_rmv")
	if IsGamepad(f234_arg0) then
		Engine[@"blockgamefromkeyevent"]()
	end
end
CoD.WZUtility.NextWeapon = function(f235_arg0)
	Engine[@"exec"](f235_arg0, "weapnext")
end
CoD.WZUtility.PrevWeapon = function(f236_arg0)
	if CoD.isPC then
		Engine[@"exec"](f236_arg0, "weapprev")
	end
end
CoD.WZUtility.SwitchToWeaponInSlot = function(f237_arg0, f237_arg1)
	Engine[@"hash_3592B553D11380E7"](f237_arg0, f237_arg1)
end
CoD.WZUtility.SwitchToNextWeapon = function(f238_arg0)
	local f238_local0 = DataSources.WarzoneInventory.getModel(f238_arg0)
	local f238_local1 = f238_local0.currentWeaponIndex:get()
	if f238_local1 then
		local f238_local2 = Engine[@"hash_3592B553D11380E7"]
		local f238_local3 = f238_arg0
		local f238_local4
		if f238_local1 == 0 then
			f238_local4 = 1
			if not f238_local4 then
			else
				f238_local2(f238_local3, f238_local4)
			end
		end
		f238_local4 = 0
	end
end
CoD.WZUtility.SetElementModelToCurrentWeaponModel = function(f239_arg0, f239_arg1)
	local f239_local0 = DataSources.WarzoneInventory.getModel(f239_arg0)
	local f239_local1 = f239_local0.currentWeaponIndex:get()
	if f239_local1 then
		local f239_local2 = f239_local0["weapon" .. f239_local1]
		if f239_local2 then
			f239_arg1:setModel(f239_local2, f239_arg0)
		end
	end
end
CoD.WZUtility.SetElementModelToElementWeaponModel = function(f240_arg0, f240_arg1, f240_arg2)
	local f240_local0 = DataSources.WarzoneInventory.getModel(f240_arg0)
	local f240_local1 = f240_arg2.weaponId
	if f240_local1 then
		local f240_local2 = f240_local0["weapon" .. f240_local1]
		if f240_local2 then
			f240_arg1:setModel(f240_local2, f240_arg0)
		end
	end
end
CoD.WZUtility.SetElementModelValueToCurrentWeaponModel = function(f241_arg0, f241_arg1, f241_arg2)
	local f241_local0 = DataSources.WarzoneInventory.getModel(f241_arg0)
	local f241_local1 = f241_local0.currentWeaponIndex:get()
	if f241_local1 then
		local f241_local2 = f241_local0["weapon" .. f241_local1]
		if f241_local2 and f241_arg1:getModel() then
			local f241_local3 = f241_arg1:getModel()
			if not f241_local3[f241_arg2] then
				f241_local3 = f241_arg1:getModel()
				f241_local3:create(f241_arg2)
			end
			f241_local3 = f241_arg1:getModel()
			f241_local3[f241_arg2]:set(f241_local2)
		end
	end
end
CoD.WZUtility.HasNextWeapon = function(f242_arg0)
	local f242_local0 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f242_arg0), "heldWeapons.1.equippedWeaponReference")
	return f242_local0 and f242_local0 ~= 0x0
end
CoD.WZUtility.ShouldShowWeaponAndAttachments = function(f243_arg0)
	local f243_local0 = CoD.SafeGetModelValue(f243_arg0:getModel(), "currentWeapon")
	if not f243_local0 then
		return false
	else
		return CoD.CACUtility.GetPreviewImageLarge(Enum[@"emodes"][@"mode_warzone"], CoD.CACUtility.GetUnlockableItemInfo(f243_local0, Enum[@"emodes"][@"mode_warzone"])) ~= RegisterImage(@"blacktransparent")
	end
end
CoD.WZUtility.CurrentlyIsDriverOrGunner = function(f244_arg0)
	if Engine[@"isplayerinvehicle"](f244_arg0) then
		local f244_local0 = Engine[@"getmodelforcontroller"](f244_arg0)
		f244_local0 = f244_local0.vehicle
		local f244_local1 = f244_local0 and f244_local0.seatOccupantClientNum
		if f244_local1 then
			local f244_local2 = Engine[@"getclientnum"](f244_arg0)
			for f244_local3 = 0, 4, 1 do
				local f244_local6 = f244_local1[f244_local3]
				if f244_local6 and f244_local6:get() == f244_local2 then
					return true
				end
			end
		end
	end
	return false
end
CoD.WZUtility.IsQuickEquipListFirstItemVisible = function(f245_arg0)
	if f245_arg0.layoutItems and f245_arg0.layoutItems[1] then
		for f245_local3, f245_local4 in pairs(f245_arg0.layoutItems[1]) do
			if f245_local4.gridInfoTable.zeroBasedIndex == 0 then
				return true
			end
		end
	end
	return false
end
CoD.WZUtility.IsQuickEquipListLastItemVisible = function(f246_arg0)
	local f246_local0 = f246_arg0:getDataSource()
	local f246_local1 = f246_local0.getCount(f246_arg0)
	if f246_arg0.layoutItems and f246_arg0.layoutItems[1] then
		for f246_local5, f246_local6 in pairs(f246_arg0.layoutItems[1]) do
			if f246_local6.gridInfoTable.zeroBasedIndex == f246_local1 - 1 then
				return true
			end
		end
	end
	return false
end
CoD.WZUtility.IsSpectatingEnemy = function(f247_arg0)
	return CoD.TeamUtility.GetTeamIDForController(f247_arg0) ~= CoD.TeamUtility.GetPredictedTeamID(f247_arg0)
end
CoD.WZUtility.IsControllerDeadAndNotRespawning = function(f248_arg0)
	if not IsVisibilityBitSet(f248_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) then
		return false
	else
		return CoD.WZUtility.IsSpectatingEnemy(f248_arg0)
	end
end
CoD.WZUtility.GetPreviewImageLarge = function(f249_arg0)
	return CoD.CACUtility.GetPreviewImageLarge(Enum[@"emodes"][@"mode_warzone"], CoD.CACUtility.GetUnlockableItemInfo(f249_arg0, Enum[@"emodes"][@"mode_warzone"]))
end
CoD.WZUtility.GetWeaponNameString = function(f250_arg0, f250_arg1)
	local f250_local0 = CoD.CACUtility.GetUnlockableItemInfo(f250_arg1, Enum[@"emodes"][@"mode_warzone"])
	if not f250_local0 then
		return ""
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f250_local0.displayName)
	end
end
CoD.WZUtility.GetWeaponNameColor = function(f251_arg0, f251_arg1)
	if not CoD.CACUtility.GetUnlockableItemInfo(f251_arg1, Enum[@"emodes"][@"mode_warzone"]) then
		return CoD.ColorUtility.ExplodeColor(ColorSet.T8__OFF__WHITE)
	else
		local f251_local0 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f251_arg0), "hudItems.inventory.currentWeapon.isOperator") or 0
		local f251_local1 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f251_arg0), "hudItems.inventory.currentWeapon.isTactical") or 0
		if f251_local0 ~= 0 then
			return CoD.ColorUtility.ExplodeColor(ColorSet.OperatorWeaponText)
		elseif f251_local1 ~= 0 then
			return CoD.ColorUtility.ExplodeColor(ColorSet.TacticalWeaponText)
		else
			return CoD.ColorUtility.ExplodeColor(ColorSet.T8__OFF__WHITE)
		end
	end
end
CoD.WZUtility.GetWeaponAmmoString = function(f252_arg0, f252_arg1)
	local f252_local0 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f252_arg0), "hudItems.inventory.currentWeapon.ammoType")
	if not f252_local0 or f252_local0 == 0x0 then
		return ""
	else
		return Engine[@"hash_4F9F1239CFD921FE"](0x2B266B4344E94C, f252_local0)
	end
end
CoD.WZUtility.GetWeaponNameAndAmmoString = function(f253_arg0, f253_arg1)
	local f253_local0 = CoD.CACUtility.GetUnlockableItemInfo(f253_arg1, Enum[@"emodes"][@"mode_warzone"])
	if not f253_local0 then
		return ""
	else
		local f253_local1 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f253_arg0), "hudItems.inventory.currentWeapon.ammoType")
		if not f253_local1 or f253_local1 == 0x0 then
			return Engine[@"hash_4F9F1239CFD921FE"](f253_local0.displayName)
		else
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_31DD58AA20274399", f253_local0.displayName, f253_local1)
		end
	end
end
CoD.WZUtility.AddAmmoString = function(f254_arg0, f254_arg1, f254_arg2)
	local f254_local0 = f254_arg1.weaponId
	if f254_local0 then
		local f254_local1 = DataSources.WarzoneInventory.getModel(f254_arg0)
		local f254_local2 = "weapon"
		f254_local1 = f254_local1["weapon" .. f254_local0].ammoType
		if f254_local1 then
			f254_local2 = f254_local1:get()
			if f254_local2 and f254_local2 ~= 0x0 then
				return Engine[@"hash_4F9F1239CFD921FE"](@"hash_31DD58AA20274399", f254_arg2, f254_local2)
			end
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f254_arg2)
end
CoD.WZUtility.GetFreeFallAltitudeRatio = function(f255_arg0, f255_arg1)
	local f255_local0 = DataSources.HUDItems.getModel(f255_arg0)
	local f255_local1 = f255_local0
	local f255_local2 = f255_local0.freeFallStartAltitude
	if f255_local2 then
		f255_local2 = f255_local1 and f255_local0.freeFallStartAltitude:get()
	end
	if f255_local2 and f255_local2 > 0 then
		return 1 - math.max(math.min((f255_arg1 - CoD.WZUtility.SeaLevelAltitude) / (f255_local2 - CoD.WZUtility.SeaLevelAltitude), 1), 0)
	else
		return 0
	end
end
CoD.WZUtility.GetGroundUnderPlayerAltitudeRatio = function(f256_arg0, f256_arg1, f256_arg2, f256_arg3, f256_arg4)
	local f256_local0 = DataSources.HUDItems.getModel(f256_arg0)
	local f256_local1 = f256_local0
	local f256_local2 = f256_local0.freeFallStartAltitude
	if f256_local2 then
		f256_local2 = f256_local1 and f256_local0.freeFallStartAltitude:get()
	end
	if f256_local2 and f256_local2 > 0 then
		return 1 - math.max(math.min((f256_arg1 - CoD.WZUtility.SeaLevelAltitude) / (f256_local2 - CoD.WZUtility.SeaLevelAltitude), 1), 0), 1, 0, 0
	else
		return 0, 1, 0, 0
	end
end
CoD.WZUtility.IsQuickInventoryMenuDisabledInCycle = function(f257_arg0, f257_arg1)
	return f257_arg1._disableInCycle
end
CoD.WZUtility.AddQuickAccessInventoryWidget = function(f258_arg0, f258_arg1, f258_arg2, f258_arg3, f258_arg4)
	if not f258_arg0._quickAccessInventory then
		f258_arg0._quickAccessInventory = {}
		f258_arg0._quickAccessInventory.widgets = {}
	end
	f258_arg0._quickAccessInventory.widgets[f258_arg3] = f258_arg2
	f258_arg2._disableInCycle = f258_arg4
end
CoD.WZUtility.OpenQuickAccessInventory = function(f259_arg0, f259_arg1)
	SetControllerModelValue(f259_arg1, "hudItems.inventory.open", true)
	Engine[@"playsound"]("uin_wz_menu_equip_open", f259_arg1)
	CoD.WZUtility.UpdateDpadLeftRightAvailability(f259_arg0, f259_arg1)
	local f259_local0 = CoD.OptionsUtility.IsProfileIntValue(f259_arg1, "warzoneCycleItems", 1)
	if f259_arg0._quickAccessInventory.widgets then
		if f259_arg0._quickAccessInventory._selectedList and (not f259_local0 or f259_local0 and not f259_arg0._quickAccessInventory._selectedList._disableInCycle) and f259_arg0._quickAccessInventory._selectedList:processEvent({
			name = "gain_focus",
			controller = f259_arg1,
		}) then
			CoD.WZUtility.UpdateSelectedItemName(f259_arg0, f259_arg1)
			return
		end
		for f259_local6, f259_local7 in LUI.IterateTableBySortedKeys(f259_arg0._quickAccessInventory.widgets) do
			local f259_local5
			if f259_local0 then
				local f259_local4 = f259_local0
				f259_local5 = not f259_local7._disableInCycle
			else
				f259_local5 = f259_local4 and true
			end
			if f259_local5 and f259_local7:processEvent({
				name = "gain_focus",
				controller = f259_arg1,
			}) then
				f259_arg0._quickAccessInventory._selectedList = f259_local7
				CoD.WZUtility.UpdateSelectedItemName(f259_arg0, f259_arg1)
				return
			end
			f259_local7:processEvent({
				name = "lose_focus",
				controller = f259_arg1,
			})
		end
	end
end
CoD.WZUtility.CloseQuickAccessInventory = function(f260_arg0, f260_arg1)
	SetControllerModelValue(f260_arg1, "hudItems.inventory.open", false)
	Engine[@"playsound"]("uin_wz_menu_equip_close", f260_arg1)
	Engine[@"hash_27CD221DF1911DD1"](f260_arg1)
	if f260_arg0._quickAccessInventory and f260_arg0._quickAccessInventory._selectedList then
		f260_arg0._quickAccessInventory._selectedList:processEvent({
			name = "lose_focus",
			controller = f260_arg1,
		})
		CoD.HUDUtility.GiveFocusToMenu(f260_arg0, f260_arg1)
	end
end
CoD.WZUtility.CycleHealthQuickAccessInventory = function(f261_arg0, f261_arg1, f261_arg2)
	if not IsRepeatButtonPress(f261_arg2) then
		SendCustomClientScriptNotifyForAdjustedClient(f261_arg1, "cycle_health")
	end
	CoD.WZUtility.ResetQuickInventoryAutoCloseTimer(f261_arg0, f261_arg1)
end
CoD.WZUtility.CycleEquipmentQuickAccessInventory = function(f262_arg0, f262_arg1, f262_arg2)
	if not IsRepeatButtonPress(f262_arg2) then
		SendCustomClientScriptNotifyForAdjustedClient(f262_arg1, "cycle_equipment")
	end
	CoD.WZUtility.ResetQuickInventoryAutoCloseTimer(f262_arg0, f262_arg1)
end
CoD.WZUtility.UpdateDpadLeftRightAvailability = function(f263_arg0, f263_arg1)
	local f263_local0 = false
	local f263_local1 = false
	local f263_local2 = CoD.OptionsUtility.IsProfileIntValue(f263_arg1, "warzoneCycleItems", 1)
	local f263_local3 = f263_arg0
	local f263_local4 = f263_arg0._quickAccessInventory
	if f263_local4 then
		f263_local4 = f263_arg0._quickAccessInventory._selectedList
		if f263_local4 then
			f263_local4 = f263_local3 and f263_arg0._quickAccessInventory._selectedList._quickAccessList
		end
	end
	if f263_local4 then
		local f263_local5 = f263_local4.activeWidget
		if f263_local5 then
			f263_local5 = f263_local4.activeWidget.gridInfoTable.zeroBasedIndex
		end
		if f263_local5 ~= nil then
			if f263_local5 + 1 < f263_local4.itemCount then
				f263_local1 = true
			end
			if f263_local5 >= 1 then
				f263_local0 = true
			end
		end
		if not f263_local0 then
			local f263_local6 = LuaUtils.FindItemInArray(f263_arg0._quickAccessInventory.widgets, f263_arg0._quickAccessInventory._selectedList)
			for f263_local7 = f263_local6 - 1, -f263_local6, -1 do
				local f263_local10 = f263_local7
				if f263_local10 <= 0 then
					f263_local10 = #f263_arg0._quickAccessInventory.widgets + f263_local10
				end
				if f263_arg0._quickAccessInventory.widgets[f263_local10] and f263_arg0._quickAccessInventory.widgets[f263_local10]._quickAccessList.itemCount > 0 and (not f263_local2 or f263_local2 and not f263_arg0._quickAccessInventory.widgets[f263_local10]._disableInCycle) then
					f263_local0 = true
					break
				end
			end
		end
		if not f263_local1 then
			local f263_local6 = LuaUtils.FindItemInArray(f263_arg0._quickAccessInventory.widgets, f263_arg0._quickAccessInventory._selectedList)
			for f263_local7 = f263_local6 + 1, #f263_arg0._quickAccessInventory.widgets + f263_local6, 1 do
				local f263_local10 = f263_local7
				if #f263_arg0._quickAccessInventory.widgets < f263_local10 then
					f263_local10 = f263_local10 - #f263_arg0._quickAccessInventory.widgets
				end
				if f263_arg0._quickAccessInventory.widgets[f263_local7] and f263_arg0._quickAccessInventory.widgets[f263_local7]._quickAccessList.itemCount > 0 and (not f263_local2 or f263_local2 and not f263_arg0._quickAccessInventory.widgets[f263_local7]._disableInCycle) then
					f263_local1 = true
					break
				end
			end
		end
	end
	local f263_local5 = DataSources.WarzoneInventory.getModel(f263_arg1)
	f263_local5.canNavigateLeft:set(f263_local0)
	f263_local5.canNavigateRight:set(f263_local1)
	CoD.WZUtility.UpdateSelectedItemName(f263_arg0, f263_arg1)
	Engine[@"hash_27CD221DF1911DD1"](f263_arg1)
end
CoD.WZUtility.UpdateSelectedItemName = function(f264_arg0, f264_arg1)
	local f264_local0 = DataSources.WarzoneInventory.getModel(f264_arg1)
	if f264_arg0._quickAccessInventory and f264_arg0._quickAccessInventory._selectedList then
		local f264_local1 = f264_arg0._quickAccessInventory._selectedList._quickAccessList
		local f264_local2 = ""
		if f264_local1 and f264_local1.activeWidget then
			local f264_local3 = f264_local1.activeWidget:getModel()
			if f264_local3 then
				f264_local2 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](f264_local3.name:get()))
			end
		end
		f264_local0.selectedItemName:set(f264_local2)
	end
end
CoD.WZUtility.LocalizeSelectedInventoryIntoString = function(f265_arg0, f265_arg1)
	local f265_local0 = Engine[@"getmodelforcontroller"](f265_arg0)
	return Engine[@"hash_4F9F1239CFD921FE"](f265_arg1, f265_local0["hudItems.inventory.selectedItemName"]:get())
end
CoD.WZUtility.AddQuickInventoryNavigation = function(f266_arg0, f266_arg1, f266_arg2, f266_arg3)
	local f266_local0 = LUI.GridLayout.NavigationFlags.CHANGE_FOCUS
	f266_arg1._quickAccessList = f266_arg3
	CoD.Menu.AddButtonCallbackFunction(f266_arg0, f266_arg3, f266_arg2, Enum[@"luibutton"][@"lui_key_left"], "ui_navleft", function(element, menu, controller, f267_arg3)
		local f267_local0 = CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1)
		if not f266_arg3.m_disableNavigation then
			if not (not f266_arg3.dpadDisabled or not IsDpadButton(f267_arg3)) or f266_arg3:navigateItemLeft(f266_local0) then
				CoD.WZUtility.UpdateDpadLeftRightAvailability(menu, controller)
				return true
			end
			local f267_local1 = LuaUtils.FindItemInArray(menu._quickAccessInventory.widgets, f266_arg3:getParent())
			if f267_local1 ~= nil then
				for f267_local2 = 1, #menu._quickAccessInventory.widgets - 1, 1 do
					local f267_local5 = f267_local1 - f267_local2
					if f267_local5 <= 0 then
						f267_local5 = f267_local5 + #menu._quickAccessInventory.widgets
					end
					local f267_local6
					if f267_local0 then
						local f267_local7 = f267_local0
						f267_local6 = not menu._quickAccessInventory.widgets[f267_local5]._disableInCycle
					else
						f267_local6 = f267_local7 and true
					end
					if menu._quickAccessInventory.widgets[f267_local5] and f267_local6 then
						local f267_local8 = menu._quickAccessInventory.widgets[f267_local5].InventoryEquipmentLarge
						if f267_local8 then
							f267_local8:setActiveItem(f267_local8:getLastSelectableItem(), 0)
						end
						if menu._quickAccessInventory.widgets[f267_local5]:processEvent({
							name = "gain_focus",
							controller = controller,
						}) then
							menu._quickAccessInventory._selectedList = menu._quickAccessInventory.widgets[f267_local5]
							CoD.WZUtility.UpdateDpadLeftRightAvailability(menu, controller)
							return true
						end
					end
				end
			end
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f266_arg0, f266_arg3, f266_arg2, Enum[@"luibutton"][@"lui_key_right"], "ui_navright", function(element, menu, controller, f268_arg3)
		local f268_local0 = CoD.OptionsUtility.IsProfileIntValue(controller, "warzoneCycleItems", 1)
		if not f266_arg3.m_disableNavigation then
			if not (not f266_arg3.dpadDisabled or not IsDpadButton(f268_arg3)) or f266_arg3:navigateItemRight(f266_local0) then
				CoD.WZUtility.UpdateDpadLeftRightAvailability(menu, controller)
				return true
			end
			local f268_local1 = LuaUtils.FindItemInArray(menu._quickAccessInventory.widgets, f266_arg3:getParent())
			if f268_local1 ~= nil then
				for f268_local2 = 1, #menu._quickAccessInventory.widgets - 1, 1 do
					local f268_local5 = f268_local1 + f268_local2
					if #menu._quickAccessInventory.widgets < f268_local5 then
						f268_local5 = f268_local5 - #menu._quickAccessInventory.widgets
					end
					if #menu._quickAccessInventory.widgets < f268_local5 then
						f268_local5 = f268_local5 - #menu._quickAccessInventory.widgets
					end
					local f268_local6
					if f268_local0 then
						local f268_local7 = f268_local0
						f268_local6 = not menu._quickAccessInventory.widgets[f268_local5]._disableInCycle
					else
						f268_local6 = f268_local7 and true
					end
					if menu._quickAccessInventory.widgets[f268_local5] and f268_local6 then
						local f268_local8 = menu._quickAccessInventory.widgets[f268_local5].InventoryEquipmentLarge
						if f268_local8 then
							f268_local8:setActiveItem(f268_local8:getFirstSelectableItem(), 0)
						end
						if menu._quickAccessInventory.widgets[f268_local5]:processEvent({
							name = "gain_focus",
							controller = controller,
						}) then
							menu._quickAccessInventory._selectedList = menu._quickAccessInventory.widgets[f268_local5]
							CoD.WZUtility.UpdateDpadLeftRightAvailability(menu, controller)
							return true
						end
					end
				end
			end
		end
	end)
end
CoD.WZUtility.SetupLastStandClientModelUpdate = function(f269_arg0, f269_arg1, f269_arg2)
	local f269_local0 = f269_arg1:getModel()
	local f269_local1 = Engine[@"getmodelforclient"](f269_local0.clientNum:get())
	local f269_local2 = f269_local1:create("lastStand")
	f269_local2 = f269_local2:create(f269_arg2)
	f269_local2 = f269_local2:create("health")
	if f269_local2 then
		local f269_local3 = f269_arg1
		local f269_local4 = f269_arg1.subscribeToModel
		local f269_local5 = f269_arg1:getModel()
		f269_local4(f269_local3, f269_local5.health, function(f270_arg0)
			local f270_local0 = f270_arg0:get()
			if f270_local0 then
				f269_local2:set(f270_local0)
			end
		end)
	end
	local f269_local4 = f269_local1:create("lastStand")
	f269_local4 = f269_local4:create(f269_arg2)
	f269_local4 = f269_local4:create("reviveProgress")
	if f269_local4 then
		local f269_local5 = f269_arg1
		local f269_local3 = f269_arg1.subscribeToModel
		local f269_local6 = f269_arg1:getModel()
		f269_local3(f269_local5, f269_local6.reviveProgress, function(f271_arg0)
			local f271_local0 = f271_arg0:get()
			if f271_local0 then
				f269_local4:set(f271_local0)
				CoD.BaseUtility.SmoothLinearInterpolateClientTime(f269_arg2, "selfRevive", f269_local4, f271_local0)
			end
		end)
	end
end
CoD.WZUtility.SetupLastStandBleedoutBar = function(f272_arg0, f272_arg1, f272_arg2)
	if f272_arg1.BleedoutBar then
		local f272_local0 = f272_arg1:getModel()
		f272_local0 = f272_local0:create("lastStand")
		f272_local0 = f272_local0:create(f272_arg2)
		f272_local0:create("health")
		f272_arg1.BleedoutBar:setModel(f272_local0, f272_arg2)
	end
end
CoD.WZUtility.SetupReviveProgressBar = function(f273_arg0, f273_arg1, f273_arg2)
	if f273_arg2.progressBar then
		local f273_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f273_arg1))
		local f273_local1 = f273_local0:create("lastStand")
		f273_local1 = f273_local1:create(f273_arg1)
		f273_local1 = f273_local1:create("reviveProgress")
		if f273_local1 then
			f273_arg2:subscribeToModel(f273_local1, function(model)
				local f274_local0 = model:get()
				if f274_local0 then
					f273_arg2.progressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f274_local0, 1), CoD.GetVectorComponentFromString(f274_local0, 2), CoD.GetVectorComponentFromString(f274_local0, 3), CoD.GetVectorComponentFromString(f274_local0, 4))
				end
			end)
		end
	end
end
CoD.WZUtility.SetupBleedoutProgressBar = function(f275_arg0, f275_arg1, f275_arg2)
	if f275_arg2.progressBar then
		local f275_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f275_arg1))
		local f275_local1 = f275_local0:create("lastStand")
		f275_local1 = f275_local1:create(f275_arg1)
		f275_local1 = f275_local1:create("health")
		if f275_local1 then
			f275_arg2:subscribeToModel(f275_local1, function(model)
				local f276_local0 = model:get()
				if f276_local0 then
					f275_arg2.progressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f276_local0, 1), CoD.GetVectorComponentFromString(f276_local0, 2), CoD.GetVectorComponentFromString(f276_local0, 3), CoD.GetVectorComponentFromString(f276_local0, 4))
				end
			end)
		end
	end
end
CoD.WZUtility.ShouldPlayValueUpdate = function(f277_arg0, f277_arg1)
	local f277_local0 = f277_arg1:getModel()
	if not f277_local0 or not f277_local0.value or not f277_local0.value:get() then
		return false
	else
		local f277_local1 = f277_local0.value:get()
		f277_local1 = f277_local1:get()
		if f277_arg1.lastValue and f277_arg1.lastValue == f277_local1 then
			return false
		else
			f277_arg1.lastValue = f277_local1
			return true
		end
	end
end
CoD.WZUtility.IndicatorToModels = {
	kills = {
		getModel = function(f278_arg0)
			local f278_local0 = {}
			local f278_local1 = DataSources.HUDItems.getModel(f278_arg0)
			f278_local0[1] = f278_local1.playerKills
			return f278_local0
		end,
		type = "hudGameStat",
	},
	cleanups = {
		getModel = function(f279_arg0)
			local f279_local0 = {}
			local f279_local1 = DataSources.HUDItems.getModel(f279_arg0)
			f279_local0[1] = f279_local1.playerCleanUps
			return f279_local0
		end,
		type = "hudGameStat",
	},
	playersalive = {
		getModel = function(f280_arg0)
			local f280_local0 = {}
			local f280_local1 = DataSources.HUDItems.getModel(f280_arg0)
			f280_local1 = f280_local1.alivePlayerCount
			local f280_local2 = DataSources.HUDItems.getModel(f280_arg0)
			f280_local2 = f280_local2.alivePlayerCountEnemy
			f280_local0[1] = f280_local1
			f280_local0[2] = f280_local2
			return f280_local0
		end,
		type = "gameInformation",
	},
	playersspectating = {
		getModel = function(f281_arg0)
			local f281_local0 = Engine[@"getclientnum"](f281_arg0)
			local f281_local1 = {}
			local f281_local2 = Engine[@"getmodelforclient"](f281_local0)
			f281_local1[1] = f281_local2.spectatorCount
			return f281_local1
		end,
		type = "gameInformation",
	},
	cash = {
		getModel = function(f282_arg0)
			local f282_local0 = {}
			local f282_local1 = Engine[@"getmodelforcontroller"](f282_arg0)
			f282_local1 = f282_local1.gameScore.playerScore
			local f282_local2 = Engine[@"getmodelforcontroller"](f282_arg0)
			f282_local2 = f282_local2.gameScore.enemyScore
			f282_local0[1] = f282_local1
			f282_local0[2] = f282_local2
			return f282_local0
		end,
		type = "wzDeposit",
	},
	livesremaining = {
		getModel = function(f283_arg0)
			local f283_local0 = {}
			local f283_local1 = DataSources.HUDItems.getModel(f283_arg0)
			f283_local0[1] = f283_local1.playerLivesRemaining
			return f283_local0
		end,
		type = "hudGameStat",
	},
}
CoD.WZUtility.SetupGameStatusIndicatorSub = function(f284_arg0, f284_arg1, f284_arg2, f284_arg3)
	local f284_local0 = f284_arg0:getModel()
	if not f284_local0 or not f284_local0[f284_arg3] or type(f284_local0[f284_arg3]:get()) ~= "userdata" then
		return
	elseif f284_arg2["_" .. f284_arg3 .. "Subscription"] then
		f284_arg2:removeSubscription(f284_arg2["_" .. f284_arg3 .. "Subscription"])
	end
	f284_arg2["_" .. f284_arg3 .. "Subscription"] = f284_arg2:subscribeToModel(f284_local0[f284_arg3]:get(), function(model)
		local f285_local0 = model:get()
		if f285_local0 ~= nil then
			f284_arg2:setText(f285_local0)
		end
	end, true)
end
CoD.WZUtility.SetupGameStatusIndicatorSubscriptions = function(f286_arg0, f286_arg1, f286_arg2, f286_arg3, f286_arg4)
	CoD.WZUtility.SetupGameStatusIndicatorSub(f286_arg0, f286_arg1, f286_arg2, "value1")
	CoD.WZUtility.SetupGameStatusIndicatorSub(f286_arg0, f286_arg1, f286_arg3, "value1")
	CoD.WZUtility.SetupGameStatusIndicatorSub(f286_arg0, f286_arg1, f286_arg4, "value2")
end
CoD.WZUtility.GameStatusIndicatorShouldShowRedX = function(f287_arg0, f287_arg1)
	if f287_arg0.indicatorKey == "livesremaining" and f287_arg0.prematchEnded == true and CoD.WZUtility.AnyReinsertionsRemaining(f287_arg1) == false then
		return true
	else
		return false
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneGameStatusIndicatorList", "WarzoneGameStatusIndicatorList", function(f288_arg0, f288_arg1)
	local f288_local0 = Engine[@"hash_2E00B2F29271C60B"](@"wz_game_status_indicators")
	if not f288_local0 then
		return
	end
	for f288_local7, f288_local8 in pairs(CoD.WZUtility.IndicatorToModels) do
		if f288_local7 ~= "cash" or f288_local7 == "cash" and IsBooleanDvarSet(0x74ED0F04816B75) then
			local f288_local4 = f288_arg0.key
			if not f288_local4 then
				f288_local4 = f288_arg0:create(f288_local7)
				local f288_local5 = f288_local8.getModel(f288_arg1)
				local f288_local6 = f288_local4:create("value1")
				f288_local6:set(f288_local5[1])
				f288_local6 = f288_local4:create("value2")
				f288_local6:set(f288_local5[2])
				f288_local6 = f288_local4:create("indicatorId")
				f288_local6:set(f288_local7)
			end
			if not f288_local4.icon then
				local f288_local5 = Engine[@"converttoxhash"]("icon" .. f288_local7)
				local f288_local6 = f288_local4:create("icon")
				f288_local6:set(f288_local0[f288_local5] and f288_local0[f288_local5] or @"ui_icon_dead")
			end
			if not f288_local4.type then
				local f288_local5 = f288_local4:create("type")
				f288_local5:set(f288_local8.type)
			end
		end
	end
end, false)
DataSources.WarzoneGameStatusIndicatorList.CommonPrepare = function(f289_arg0, f289_arg1, f289_arg2, f289_arg3)
	if not f289_arg1._rootModel then
		f289_arg1._rootModel = DataSources.WarzoneGameStatusIndicatorList.getModel(f289_arg0)
	end
	local f289_local0 = Engine[@"hash_2E00B2F29271C60B"](@"wz_game_status_indicators")
	if not f289_local0 then
		return
	end
	f289_arg1._items = {}
	f289_arg1._lastModelType = nil
	if not f289_local0[f289_arg3] then
		return
	elseif not f289_arg1.playersSettingsSubscription then
		local f289_local1 = f289_arg1
		local f289_local2 = f289_arg1.subscribeToModel
		local f289_local3 = Engine[@"getmodelforcontroller"](f289_arg0)
		f289_arg1.playersSettingsSubscription = f289_local2(f289_local1, f289_local3.PlayerSettingsUpdate, function(f290_arg0)
			f289_arg1:updateDataSource(false, true)
		end, false)
	end
	if not f289_arg1.scriptNotifySubscription and not f289_arg1.prematchEnded then
		f289_arg1.prematchEnded = false
		f289_arg1.scriptNotifySubscription = f289_arg1:subscribeToGlobalModel(f289_arg0, "PerController", "scriptNotify", function(model)
			if model:get() == @"prematch_timer_ended" then
				f289_arg1.prematchEnded = true
				f289_arg1:updateDataSource(false, true)
			end
		end)
	end
	for f289_local2 = 1, #f289_local0[f289_arg3], 1 do
		local f289_local4 = f289_local0[f289_arg3][f289_local2][@"indicator"]
		if (f289_local4 ~= "cash" or f289_local4 == "cash" and IsBooleanDvarSet(0x74ED0F04816B75)) and (not f289_arg2 or f289_arg2(f289_arg1._rootModel[f289_local4])) then
			local f289_local5 = nil
			if f289_local4 == "playersspectating" then
				if f289_arg1._rootModel[f289_local4] and f289_arg1._rootModel[f289_local4].value1 and f289_arg1._rootModel[f289_local4].value1:get() then
					if not f289_arg1.playersSpectatingSubscription then
						f289_arg1.playersSpectatingSubscription = f289_arg1:subscribeToModel(f289_arg1._rootModel[f289_local4].value1:get(), function(model)
							f289_arg1:updateDataSource(false, true)
						end, false)
					end
					local f289_local6 = f289_arg1._rootModel[f289_local4].value1:get()
					if f289_local6:get() > 0 then
						f289_local5 = true
					end
				end
			elseif f289_local4 == "cleanups" then
				if not CoD.GameEndScoreUtility.IsSoloTeamGame() and not CoD.BaseUtility.IsDvarEnabled("hideCleanups") then
					f289_local5 = true
				end
			elseif f289_local4 == "livesremaining" then
				if IsGametypeSettingsValue("wzEnableWaveRespawn", 1) and not CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad") then
					f289_local5 = true
				elseif CoD.BaseUtility.IsDvarEnabled("alwaysShowLivesRemaining") then
					f289_local5 = true
				end
			elseif f289_local4 == "kills" then
				if not CoD.BaseUtility.IsDvarEnabled("hideKills") then
					f289_local5 = true
				end
			else
				f289_local5 = true
			end
			if f289_local5 then
				if f289_local4 == "cleanups" then
					f289_local5 = not CoD.WZUtility.IsWarzoneUIHidden(f289_arg0, "wzHideCleanupsUI", "warzoneHideCleanups")
				elseif f289_local4 == "kills" then
					f289_local5 = not CoD.WZUtility.IsWarzoneUIHidden(f289_arg0, "wzHideKillsUI", "warzoneHideKills")
				elseif f289_local4 == "playersalive" then
					if f289_arg1.prematchEnded then
						f289_local5 = not CoD.WZUtility.IsWarzoneUIHidden(f289_arg0, "wzHidePlayersAliveUI", "warzoneHidePlayersAlive")
					else
						f289_local5 = true
					end
				elseif f289_local4 == "playersspectating" then
					f289_local5 = not CoD.WZUtility.IsWarzoneUIHidden(f289_arg0, "wzHideSpectatorsUI", "warzoneHideSpectators")
				end
			end
			if f289_local5 then
				local f289_local6 = 0
				if not f289_arg1._lastModelType then
					f289_arg1._lastModelType = f289_arg1._rootModel[f289_local4].type:get()
				elseif f289_arg1._lastModelType ~= f289_arg1._rootModel[f289_local4].type:get() then
					f289_arg1._items[#f289_arg1._items].properties.vSpacing = 10
					f289_arg1._lastModelType = f289_arg1._rootModel[f289_local4].type:get()
				end
				table.insert(f289_arg1._items, {
					model = f289_arg1._rootModel[f289_local4],
					properties = {
						vSpacing = f289_local6,
						indicatorKey = f289_local4,
						prematchEnded = f289_arg1.prematchEnded,
					},
				})
			end
		end
	end
end
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneGameStatusIndicatorListEndGameLeft", "WarzoneGameStatusIndicatorList", function(f293_arg0, f293_arg1) end, false, {
	prepare = function(f294_arg0, f294_arg1, f294_arg2)
		DataSources.WarzoneGameStatusIndicatorList.CommonPrepare(f294_arg0, f294_arg1, f294_arg2, "endgame_left")
	end,
	getCount = function(f295_arg0)
		return f295_arg0._items and #f295_arg0._items or 0
	end,
	getItem = function(f296_arg0, f296_arg1, f296_arg2)
		return f296_arg1._items[f296_arg2].model
	end,
	getSpacerAfterColumn = function(f297_arg0, f297_arg1, f297_arg2)
		local f297_local0 = f297_arg0._items
		if f297_local0[f297_arg1] then
			return f297_local0[f297_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getCustomPropertiesForItem = function(f298_arg0, f298_arg1)
		local f298_local0 = f298_arg0._items
		if f298_local0 and f298_local0[f298_arg1] then
			return f298_local0[f298_arg1].properties
		else
		end
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneGameStatusIndicatorListEndGameRight", "WarzoneGameStatusIndicatorList", function(f299_arg0, f299_arg1) end, false, {
	prepare = function(f300_arg0, f300_arg1, f300_arg2)
		DataSources.WarzoneGameStatusIndicatorList.CommonPrepare(f300_arg0, f300_arg1, f300_arg2, "endgame_right")
	end,
	getCount = function(f301_arg0)
		return f301_arg0._items and #f301_arg0._items or 0
	end,
	getItem = function(f302_arg0, f302_arg1, f302_arg2)
		return f302_arg1._items[f302_arg2].model
	end,
	getSpacerAfterColumn = function(f303_arg0, f303_arg1, f303_arg2)
		local f303_local0 = f303_arg0._items
		if f303_local0[f303_arg1] then
			return f303_local0[f303_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getCustomPropertiesForItem = function(f304_arg0, f304_arg1)
		local f304_local0 = f304_arg0._items
		if f304_local0 and f304_local0[f304_arg1] then
			return f304_local0[f304_arg1].properties
		else
		end
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneGameStatusIndicatorListInventoryLeft", "WarzoneGameStatusIndicatorList", function(f305_arg0, f305_arg1) end, false, {
	prepare = function(f306_arg0, f306_arg1, f306_arg2)
		DataSources.WarzoneGameStatusIndicatorList.CommonPrepare(f306_arg0, f306_arg1, f306_arg2, "inventory_left")
	end,
	getCount = function(f307_arg0)
		return f307_arg0._items and #f307_arg0._items or 0
	end,
	getItem = function(f308_arg0, f308_arg1, f308_arg2)
		return f308_arg1._items[f308_arg2].model
	end,
	getSpacerAfterColumn = function(f309_arg0, f309_arg1, f309_arg2)
		local f309_local0 = f309_arg0._items
		if f309_local0[f309_arg1] then
			return f309_local0[f309_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getCustomPropertiesForItem = function(f310_arg0, f310_arg1)
		local f310_local0 = f310_arg0._items
		if f310_local0 and f310_local0[f310_arg1] then
			return f310_local0[f310_arg1].properties
		else
		end
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneGameStatusIndicatorListInventoryRight", "WarzoneGameStatusIndicatorList", function(f311_arg0, f311_arg1) end, false, {
	prepare = function(f312_arg0, f312_arg1, f312_arg2)
		DataSources.WarzoneGameStatusIndicatorList.CommonPrepare(f312_arg0, f312_arg1, f312_arg2, "inventory_right")
	end,
	getCount = function(f313_arg0)
		return f313_arg0._items and #f313_arg0._items or 0
	end,
	getItem = function(f314_arg0, f314_arg1, f314_arg2)
		return f314_arg1._items[f314_arg2].model
	end,
	getSpacerAfterColumn = function(f315_arg0, f315_arg1, f315_arg2)
		local f315_local0 = f315_arg0._items
		if f315_local0[f315_arg1] then
			return f315_local0[f315_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getCustomPropertiesForItem = function(f316_arg0, f316_arg1)
		local f316_local0 = f316_arg0._items
		if f316_local0 and f316_local0[f316_arg1] then
			return f316_local0[f316_arg1].properties
		else
		end
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneGameStatusIndicatorListHUDLeft", "WarzoneGameStatusIndicatorList", function(f317_arg0, f317_arg1) end, false, {
	prepare = function(f318_arg0, f318_arg1, f318_arg2)
		DataSources.WarzoneGameStatusIndicatorList.CommonPrepare(f318_arg0, f318_arg1, f318_arg2, "ingame_left")
	end,
	getCount = function(f319_arg0)
		return f319_arg0._items and #f319_arg0._items or 0
	end,
	getItem = function(f320_arg0, f320_arg1, f320_arg2)
		return f320_arg1._items[f320_arg2].model
	end,
	getSpacerAfterColumn = function(f321_arg0, f321_arg1, f321_arg2)
		local f321_local0 = f321_arg0._items
		if f321_local0[f321_arg1] then
			return f321_local0[f321_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getCustomPropertiesForItem = function(f322_arg0, f322_arg1)
		local f322_local0 = f322_arg0._items
		if f322_local0 and f322_local0[f322_arg1] then
			return f322_local0[f322_arg1].properties
		else
		end
	end,
})
DataSourceHelpers.PerControllerDataSourceSetup("WarzoneGameStatusIndicatorListHUDRight", "WarzoneGameStatusIndicatorList", function(f323_arg0, f323_arg1) end, false, {
	prepare = function(f324_arg0, f324_arg1, f324_arg2)
		DataSources.WarzoneGameStatusIndicatorList.CommonPrepare(f324_arg0, f324_arg1, f324_arg2, "ingame_right")
	end,
	getCount = function(f325_arg0)
		return f325_arg0._items and #f325_arg0._items or 0
	end,
	getItem = function(f326_arg0, f326_arg1, f326_arg2)
		return f326_arg1._items[f326_arg2].model
	end,
	getSpacerAfterColumn = function(f327_arg0, f327_arg1, f327_arg2)
		local f327_local0 = f327_arg0._items
		if f327_local0[f327_arg1] then
			return f327_local0[f327_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getCustomPropertiesForItem = function(f328_arg0, f328_arg1)
		local f328_local0 = f328_arg0._items
		if f328_local0 and f328_local0[f328_arg1] then
			return f328_local0[f328_arg1].properties
		else
		end
	end,
})
CoD.WZUtility.CharacterInfoShowState = LuaEnum.createEnum("HIDE", "SHOW")
DataSourceHelpers.PerControllerDataSourceSetup("WZCharacterInfo", "WZCharacterInfo", function(f329_arg0, f329_arg1)
	f329_arg0:create("infoModel")
	f329_arg0:create("showInfoState")
end, false)
CoD.WZUtility.SetElementModelToControllerModelValue = function(f330_arg0, f330_arg1, f330_arg2)
	local f330_local0 = Engine[@"getmodelforcontroller"](f330_arg1)
	f330_local0 = f330_local0[f330_arg2]
	if not f330_local0 then
		return
	else
		local f330_local1 = f330_local0:get()
		if not f330_local1 or type(f330_local1) ~= "userdata" then
			return
		else
			f330_arg0:setModel(f330_local1, f330_arg1)
		end
	end
end
CoD.WZUtility.UpdateWZInventoryTooltipOnElementWithTimerPC = function(f331_arg0, f331_arg1)
	local f331_local0 = f331_arg1:getMenu()
	if f331_local0 then
		if f331_local0.__updateWZTooltipTimerPC then
			f331_local0.__updateWZTooltipTimerPC:close()
			f331_local0.__updateWZTooltipTimerPC = nil
		end
		f331_local0.__updateWZTooltipTimerPC = LUI.UITimer.newElementTimer(200, true, function()
			f331_local0.__updateWZTooltipTimerPC = nil
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f331_arg0, f331_arg1)
			CoD.FreeCursorUtility.UpdateSetupContext(f331_arg1, f331_arg0)
		end)
		f331_local0:addElement(f331_local0.__updateWZTooltipTimerPC)
		CoD.Menu.UpdateAllButtonPrompts(f331_local0, f331_arg0)
	end
end
CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC = function(f333_arg0, f333_arg1)
	if not CoD.isPC then
		return
	end
	local f333_local0 = f333_arg1:getModel()
	if f333_local0 then
		if f333_local0.description then
			local f333_local1 = Engine[@"getmodelvalue"](f333_local0.description)
			if f333_local1 ~= 0x0 then
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f333_local0, "detailedDescription"), Engine[@"localize"](f333_local1))
			else
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f333_local0, "detailedDescription"), "")
			end
		end
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f333_local0, "tooltipArchetype"), CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE)
	end
end
CoD.WZUtility.UpdateMultiItemPickupInventoryVisibilityPC = function(f334_arg0, f334_arg1, f334_arg2, f334_arg3)
	if f334_arg3 and f334_arg3:get() == Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"] then
		CoD.ScoreboardUtility.ShowInventory(f334_arg2)
		f334_arg0._multipickupActivated = true
	else
		if Engine[@"isvisibilitybitset"](f334_arg2, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and CoD.ModelUtility.IsModelValueEqualToEnum(f334_arg2, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_INVENTORY) and f334_arg0._multipickupActivated then
			CoD.ScoreboardUtility.HideInventory(nil, f334_arg2)
		end
		f334_arg0._multipickupActivated = nil
	end
end
CoD.WZUtility.ScoreboardVisibilitySetAndPC = function(f335_arg0)
	if not IsMouseOrKeyboard(f335_arg0) then
		return false
	end
	local f335_local0 = CoD.WZUtility.IsInventoryOpen(f335_arg0)
	if f335_local0 then
		f335_local0 = IsVisibilityBitSet(f335_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
		if not f335_local0 then
			f335_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f335_arg0, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
		end
	end
	return f335_local0
end
CoD.WZUtility.IsPcInventoryOpen = function(f336_arg0)
	return CoD.isPC and CoD.WZUtility.IsInventoryOpen(f336_arg0)
end
CoD.WZUtility.AllowWZOffline = function()
	return true
end
CoD.WZUtility.IsPCSplitterOpen = function(f338_arg0)
	local f338_local0 = CoD.WZUtility.SplitterWidgetElement
	if f338_local0 then
		return IsElementInState(f338_local0, "Open")
	else
		return false
	end
end
CoD.WZUtility.GetArmorStashCountString = function(f339_arg0, f339_arg1)
	local f339_local0
	if f339_arg1 then
		f339_local0 = LocalizeIntoStringIfNotEmpty(@"mp/multiplier_x", f339_arg1)
		if not f339_local0 then
		else
			return f339_local0
		end
	end
	f339_local0 = ""
end
CoD.WZUtility.SetupAnimateArmorShardSlotWhenUnavailable = function(f340_arg0, f340_arg1)
	local f340_local0 = f340_arg0
	local f340_local1 = f340_arg0.subscribeToModel
	local f340_local2 = Engine[@"getmodelforcontroller"](f340_arg1)
	f340_local1(f340_local0, f340_local2["hudItems.inventory"].create(f340_local2["hudItems.inventory"], "armorShardNotAvailable"), function(f341_arg0, f341_arg1)
		PlayClip(f340_arg0, "Empty", f340_arg1)
		PlaySoundAlias("uin_unavailable_charging")
	end, false)
end
CoD.WZUtility.InventoryItemDisplaysPickup = function(f342_arg0, f342_arg1)
	local f342_local0 = IsMouseOrKeyboard(f342_arg1)
	if f342_local0 then
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f342_arg0, f342_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f342_arg1, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f342_arg1, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f342_arg1, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.EQUIPS) then
			f342_local0 = not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f342_arg1, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS)
		else
			f342_local0 = false
		end
	end
	return f342_local0
end
CoD.WZUtility.InventoryItemDisplaysEquip = function(f343_arg0, f343_arg1)
	local f343_local0 = IsMouseOrKeyboard(f343_arg1)
	if f343_local0 then
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f343_arg0, f343_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f343_arg1, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f343_arg1, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) then
			f343_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f343_arg1, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.EQUIPS)
		else
			f343_local0 = false
		end
	end
	return f343_local0
end
CoD.WZUtility.IsFillSquadAvailable = function(f344_arg0)
	local f344_local0 = Engine[@"getglobalmodel"]()
	f344_local0 = f344_local0.lobbyRoot
	local f344_local1 = f344_local0.playlistId:get()
	if not f344_local1 then
		return false
	else
		local f344_local2 = Engine[@"getplaylistmaxpartysize"](f344_local1)
		local f344_local3 = f344_local0.lobbyList.playerCount:get()
		return f344_local2 and f344_local3 and f344_local3 < f344_local2
	end
end
CoD.WZUtility.GetLoadoutStorageBuffer = function(f345_arg0)
	local f345_local0 = Enum[@"storagefiletype"][@"storage_wz_loadouts_offline"]
	if not IsLocal() then
		if IsCustomLobby() then
			f345_local0 = Enum[@"storagefiletype"][@"storage_wz_loadouts_custom"]
		else
			f345_local0 = Enum[@"storagefiletype"][@"storage_wz_loadouts"]
		end
	end
	return Engine[@"storagegetbuffer"](f345_arg0, f345_local0)
end
CoD.WZUtility.GetVariantSlot = function(f346_arg0, f346_arg1, f346_arg2)
	local f346_local0 = CoD.WZUtility.GetLoadoutStorageBuffer(f346_arg0)
	local f346_local1, f346_local2 = nil
	local f346_local3 = f346_local0.variant
	for f346_local4 = 0, #f346_local3 - 1, 1 do
		local f346_local7 = f346_local3[f346_local4]
		local f346_local8 = f346_local7.itemIndex:get()
		if not f346_local2 and f346_local8 == CoD.CACUtility.EmptyItemIndex then
			f346_local2 = f346_local7
		end
		if f346_local8 == f346_arg1 then
			f346_local1 = f346_local7
			break
		end
	end
	if not f346_local1 and f346_arg2 then
		f346_local1 = f346_local2
		f346_local1.itemIndex:set(f346_arg1)
		f346_local1.paintjobSlot:set(Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"])
	end
	if not f346_local1 then
		return nil
	else
		return f346_local1
	end
end
CoD.WZUtility.ReconcileVariantSlot = function(f347_arg0, f347_arg1)
	local f347_local0 = CoD.WZUtility.GetVariantSlot(f347_arg0, f347_arg1, false)
	if f347_local0 then
		local f347_local1 = f347_local0.camoIndex:get()
		local f347_local2 = Engine[@"tablelookup"](CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6B79D07B3744EA1A"], "camo", Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], f347_local1)
		if f347_local2 and not CoD.CACUtility.MasteryCamos[f347_local2] then
			local f347_local3 = CoD.CACUtility.AdjustCamoIfSignatureCamo(f347_arg0, f347_local1)
			if f347_local3 ~= f347_local1 then
				f347_local0.camoIndex:set(f347_local3)
			end
		end
	end
end
CoD.WZUtility.GetWeaponModelSlot = function(f348_arg0, f348_arg1, f348_arg2)
	local f348_local0 = f348_arg0 and CoD.WZUtility.GetVariantSlot(f348_arg1, f348_arg0, false)
	if not f348_arg2 then
		f348_arg2 = 0
	end
	if f348_local0 then
		return f348_local0.weaponModelSlot and f348_local0.weaponModelSlot:get() or f348_arg2
	else
		return f348_arg2
	end
end
CoD.WZUtility.GetWeaponOptionsTableForIndex = function(f349_arg0, f349_arg1, f349_arg2)
	if not f349_arg1 then
		return CoD.WeaponOptionsUtility.CreateWeaponOptionsTable()
	end
	local f349_local0 = CoD.WZUtility.GetVariantSlot(f349_arg0, f349_arg1, false)
	local f349_local1 = 0
	local f349_local2 = 0
	local f349_local3 = 0
	local f349_local4 = 0
	local f349_local5 = 0
	if f349_local0 then
		f349_local1 = f349_local0.camoIndex:get()
		f349_local2 = f349_local0.reticleIndex:get()
		f349_local4 = f349_local0.weaponModelSlot:get()
		f349_local5 = f349_local0.charmIndex:get()
	end
	if f349_arg2 then
		f349_local4 = f349_arg2
	end
	Engine[@"clearpaintjoblayerdata"]()
	return CoD.WeaponOptionsUtility.CreateWeaponOptionsTable(f349_local1, f349_local2, f349_local3, f349_local4, nil, f349_local5)
end
CoD.WZUtility.SetSignatureWeapon = function(f350_arg0, f350_arg1, f350_arg2)
	local f350_local0 = f350_arg0:getModel(f350_arg1, "itemIndex")
	local f350_local1 = f350_arg0:getModel(f350_arg1, "weaponModelSlotIndex")
	local f350_local2 = f350_local0 and f350_local0:get()
	local f350_local3 = f350_local2 and CoD.WZUtility.GetVariantSlot(f350_arg1, f350_local2, true)
	if f350_local1 and f350_local3 then
		local f350_local4 = f350_local1:get()
		local f350_local5 = false
		local f350_local6 = f350_local3.weaponModelSlot:get()
		if f350_arg0.mastercraftWeaponModelSlots and #f350_arg0.mastercraftWeaponModelSlots > 0 then
			for f350_local10, f350_local11 in ipairs(f350_arg0.mastercraftWeaponModelSlots) do
				if f350_local6 == f350_local11 then
					f350_local5 = true
					break
				end
			end
		end
		if f350_arg0.equipSound and f350_arg0.equipSound ~= 0x0 then
			Engine[@"hash_498954175CA6A32C"](f350_arg0.equipSound)
		end
		f350_local3.weaponModelSlot:set(f350_local4)
		if CoD.SafeGetModelValue(f350_arg0:getModel(), "isMastercraft") then
			f350_local3.camoIndex:set(CoD.SafeGetModelValue(f350_arg0:getModel(), "weaponOptionSubIndex"))
		elseif f350_local5 then
			f350_local3.camoIndex:set(CoD.CACUtility.EmptyItemIndex)
		end
		local f350_local7 = f350_arg0:getModel(f350_arg1, "unlockableItemModel")
		if f350_local7 and f350_local7:get() then
			local f350_local8 = f350_local7:get()
			if f350_local8.weaponModelSlot then
				f350_local8 = f350_local7:get()
				f350_local8.weaponModelSlot:set(f350_local4)
			end
		end
	end
end
CoD.WZUtility.ArrayContains = function(f351_arg0, f351_arg1)
	for f351_local0 = 1, #f351_arg0, 1 do
		if f351_arg0[f351_local0] == f351_arg1 then
			return true
		end
	end
	return false
end
CoD.WZUtility.GetPersonalizeItemsForItemGroup = function(f352_arg0, f352_arg1, f352_arg2)
	local f352_local0 = CoD.CACUtility.GetUnlockableItemsForItemGroup(f352_arg0, Enum[@"emodes"][@"mode_warzone"], f352_arg2)
	local f352_local1 = {}
	for f352_local5, f352_local6 in ipairs(f352_local0) do
		if CoD.WZUtility.ArrayContains(CoD.WZUtility.WZPersonalizeWeaponNames, f352_local6.nameHash) then
			table.insert(f352_local1, f352_local6)
		end
	end
	return f352_local1
end
CoD.WZUtility.GetEquippedSignatureWeaponImage = function(f353_arg0, f353_arg1, f353_arg2)
	if f353_arg0.useVariantSlot and f353_arg0.useVariantSlot:get() > 0 then
		return f353_arg0.image:get()
	else
		local f353_local0 = Enum[@"emodes"][@"mode_warzone"]
		local f353_local1 = f353_arg2
		local f353_local2 = Enum[@"statindexoffset"][@"hash_6569E84652131CD7"]
		if f353_local1 > CoD.CACUtility.EmptyItemIndex then
			local f353_local3 = Engine[@"getitemimage"](f353_local1, f353_local2, f353_local0)
			local f353_local4 = Engine[@"hash_7B98952F69D937F9"](f353_local1, f353_local2, f353_local0)
			if f353_local4 then
				local f353_local5 = CoD.WZUtility.GetWeaponModelSlot(f353_local1, f353_arg1)
				if f353_local5 > 0 then
					local f353_local6 = Engine[@"hash_79F0BB7D52A7A978"](f353_local4)
					local f353_local7 = f353_local6[f353_local5 + 1]
					if f353_local7 then
						f353_local3 = f353_local7[@"imageref"] or f353_local3
					end
				end
			end
			return RegisterImage(f353_local3)
		else
		end
	end
end
CoD.WZUtility.GetEquippedSignatureWeaponName = function(f354_arg0, f354_arg1, f354_arg2)
	if f354_arg0.useVariantSlot and f354_arg0.useVariantSlot:get() > 0 then
		return f354_arg0.displayName:get()
	else
		local f354_local0 = Enum[@"emodes"][@"mode_warzone"]
		local f354_local1 = f354_arg2
		local f354_local2 = Enum[@"statindexoffset"][@"hash_6569E84652131CD7"]
		if f354_local1 > CoD.CACUtility.EmptyItemIndex then
			local f354_local3 = Engine[@"hash_4F9F1239CFD921FE"](Engine[@"getitemname"](f354_local1, f354_local2, f354_local0))
			local f354_local4 = Engine[@"hash_7B98952F69D937F9"](f354_local1, f354_local2, f354_local0)
			if f354_local4 then
				local f354_local5 = CoD.WZUtility.GetWeaponModelSlot(f354_local1, f354_arg1)
				if f354_local5 > 0 then
					local f354_local6 = Engine[@"hash_79F0BB7D52A7A978"](f354_local4)
					local f354_local7 = f354_local6[f354_local5 + 1]
					if f354_local7 then
						if f354_local7[@"hash_5C2AA73D9F82E9C2"] and f354_local7[@"ismark2"] then
							if f354_local7[@"displayname"] then
								f354_local3 = Engine[@"hash_4F9F1239CFD921FE"](f354_local7[@"displayname"]) or f354_local3
							end
						else
							f354_local3 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_341954FC612B5845", f354_local3)
						end
					end
				end
			end
			return f354_local3
		else
		end
	end
end
CoD.WZUtility.GetCollapseIndexAndCountString = function(f355_arg0)
	local f355_local0 = f355_arg0
	local f355_local1 = Engine[@"getglobalmodel"]()
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_758EB3330F8F2A25", f355_local0 + 1, f355_local1.hudItems.warzone.collapseCount:get())
end
CoD.WZUtility.AnyReinsertionsRemaining = function(f356_arg0)
	local f356_local0 = Engine[@"getglobalmodel"]()
	f356_local0 = f356_local0.hudItems.warzone
	local f356_local1 = f356_local0.reinsertionIndex:get()
	local f356_local2 = f356_local0.collapseCount:get()
	local f356_local3 = true
	if Engine[@"getgametypesetting"](@"wzenablewaverespawn") == 1 then
		local f356_local4 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f356_arg0), "hudItems.playerCanRedeploy")
		if not f356_local4 or f356_local4 <= 0 then
			f356_local3 = false
		end
	end
	local f356_local4
	if f356_local1 < f356_local2 then
		f356_local4 = f356_local3
	else
		f356_local4 = false
	end
	return f356_local4
end
CoD.WZUtility.UpdatePersonalizeWeaponModel = function(f357_arg0, f357_arg1, f357_arg2)
	local f357_local0 = CoD.BaseUtility.GetMenuSessionMode(f357_arg2)
	local f357_local1 = f357_arg2.__loadoutType
	local f357_local2 = 0x0
	local f357_local3 = f357_arg0:getModel()
	local f357_local4 = nil
	if f357_local3 and f357_local3.itemIndex then
		f357_local4 = f357_local3.itemIndex:get()
		f357_local2 = Engine[@"hash_7B98952F69D937F9"](f357_local4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f357_local0)
	end
	CoD.WZUtility.ReconcileVariantSlot(f357_arg1, f357_local4)
	local f357_local5 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForElement(f357_arg0, f357_arg1, f357_local0)
	local f357_local6 = CoD.WZUtility.GetWeaponOptionsTableForIndex(f357_arg1, f357_local4)
	local f357_local7 = CoD.WZUtility.GetVariantSlot(f357_arg1, f357_local4, false)
	if f357_local7 then
		f357_local6.robStage = CoD.WeaponOptionsUtility.GetRobStageForCamoIndex(f357_local7.camoIndex:get())
	end
	f357_local6 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(f357_local6)
	if f357_local1 and f357_local2 then
		local f357_local8 = Engine[@"sendclientscriptnotify"]
		local f357_local9 = f357_arg1
		local f357_local10 = "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f357_arg1)
		local f357_local11 = {
			base_weapon_slot = f357_local1,
			weapon = f357_local2,
			attachments = f357_local5,
			camera = "select01",
		}
		if f357_local4 then
			local f357_local12 = f357_local6
		end
		f357_local11.options = f357_local12 or CoD.CACUtility.EmptyWeaponOptions()
		f357_local11.is_item_unlocked = true
		f357_local11.is_item_tokenlocked = true
		f357_local8(f357_local9, f357_local10, f357_local11)
	end
end
CoD.WZUtility.SetWeaponOptionForVariant = function(f358_arg0, f358_arg1, f358_arg2, f358_arg3)
	local f358_local0 = CoD.BaseUtility.GetMenuSessionMode(f358_arg3)
	local f358_local1 = f358_arg3._model
	if f358_local1 then
		f358_local1 = f358_arg3._model.itemIndex:get()
	end
	local f358_local2 = CoD.WZUtility.GetVariantSlot(f358_arg2, f358_local1, true)
	if not f358_local2 then
		return
	end
	local f358_local3 = f358_arg1:getModel(f358_arg2, "weaponOptionTypeName")
	local f358_local4 = f358_arg1:getModel(f358_arg2, "weaponOptionSubIndex")
	local f358_local5 = f358_arg1:getModel(f358_arg2, "weaponOptionType")
	if f358_local3 and f358_local4 and f358_local5 then
		local f358_local6 = f358_local3:get()
		local f358_local7 = f358_local4:get()
		local f358_local8 = f358_local5:get()
		if f358_local8 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_paintjob"] then
			local f358_local9 = f358_arg1:getModel(f358_arg2, "paintjobSlot")
			f358_local2.paintjobSlot:set(f358_local9:get())
		elseif f358_local8 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle"] then
			f358_local2.reticleIndex:set(f358_local7)
		elseif f358_local8 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_camo"] then
			f358_local2.camoIndex:set(f358_local7)
		end
		local f358_local9 = CoD.WZUtility.GetWeaponModelSlot(f358_local1, f358_arg2)
		if f358_local9 > 0 then
			local f358_local10 = Engine[@"hash_79F0BB7D52A7A978"](Engine[@"hash_7B98952F69D937F9"](f358_local1, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f358_local0))
			if f358_local10[f358_local9 + 1] and not f358_local10[f358_local9 + 1][@"hash_5C2AA73D9F82E9C2"] then
				f358_local2.weaponModelSlot:set(CoD.CACUtility.EmptyItemIndex)
				f358_arg3._model.weaponModelSlot:set(CoD.CACUtility.EmptyItemIndex)
			end
		end
	end
	CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f358_arg1, f358_arg2)
end
CoD.WZUtility.SetSignatureWeaponThemeForVariant = function(f359_arg0, f359_arg1, f359_arg2, f359_arg3)
	local f359_local0 = CoD.BaseUtility.GetMenuSessionMode(f359_arg3)
	local f359_local1 = f359_arg3._model
	if f359_local1 then
		f359_local1 = f359_arg3._model.itemIndex:get()
	end
	local f359_local2 = CoD.WZUtility.GetVariantSlot(f359_arg2, f359_local1, true)
	if not f359_local2 or not f359_local2.weaponModelSlot or not f359_local2.camoIndex then
		return
	end
	local f359_local3 = f359_arg1:getModel(f359_arg2, "signatureWeaponModelSlot")
	local f359_local4 = f359_arg1:getModel(f359_arg2, "weaponOptionSubIndex")
	if f359_local3 then
		local f359_local5 = f359_local3:get()
		local f359_local6 = CoD.CACUtility.EmptyItemIndex
		if f359_local4 and f359_local4:get() then
			f359_local6 = f359_local4:get()
		end
		f359_local2.weaponModelSlot:set(f359_local5)
		f359_local2.camoIndex:set(f359_local6)
	end
	CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f359_arg1, f359_arg2)
end
CoD.WZUtility.ClearWeaponOptionForVariant = function(f360_arg0, f360_arg1, f360_arg2, f360_arg3)
	local f360_local0 = CoD.BaseUtility.GetMenuSessionMode(f360_arg3)
	local f360_local1 = f360_arg3._model
	if f360_local1 then
		f360_local1 = f360_arg3._model.itemIndex:get()
	end
	local f360_local2 = CoD.WZUtility.GetVariantSlot(f360_arg2, f360_local1, true)
	if not f360_local2 then
		return
	end
	local f360_local3 = f360_arg1:getModel(f360_arg2, "weaponOptionType")
	local f360_local4
	if f360_local3 then
		f360_local4 = f360_local3:get()
		if not f360_local4 then
		else
			if f360_local4 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_camo"] then
				f360_local2.camoIndex:set(CoD.CACUtility.EmptyItemIndex)
			elseif f360_local4 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_reticle"] then
				f360_local2.reticleIndex:set(CoD.CACUtility.EmptyItemIndex)
			elseif f360_local4 == Enum[@"eweaponoptiongroup"][@"weaponoption_group_paintjob"] then
				f360_local2.paintjobSlot:set(Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"])
			end
			CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f360_arg1, f360_arg2)
		end
	end
	f360_local4 = Enum[@"eweaponoptiongroup"][@"weaponoption_group_invalid"]
end
CoD.WZUtility.IsWeaponOptionEquipped = function(f361_arg0, f361_arg1, f361_arg2, f361_arg3)
	local f361_local0 = f361_arg0._model
	if f361_local0 then
		f361_local0 = f361_arg0._model.itemIndex:get()
	end
	local f361_local1 = CoD.WZUtility.GetVariantSlot(f361_arg2, f361_local0, false)
	local f361_local2 = f361_arg1:getModel()
	if f361_local2 and f361_local1 and f361_local1[f361_arg3] then
		local f361_local3 = f361_local1[f361_arg3]:get()
		local f361_local4 = f361_local2.weaponOptionSubIndex:get()
		if f361_local2.weaponOptionType:get() == Enum[@"eweaponoptiongroup"][@"weaponoption_group_paintjob"] and f361_local2.paintjobSlot then
			local f361_local5 = f361_local2.paintjobSlot:get()
			if f361_local5 ~= Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] then
				return f361_local5 == f361_local3
			end
		end
		return f361_local4 == f361_local3
	else
		return false
	end
end
CoD.WZUtility.GetArmoryCharmItemFromWeapon = function(f362_arg0, f362_arg1)
	local f362_local0 = CoD.WZUtility.GetVariantSlot(f362_arg0, f362_arg1, true)
	if f362_local0 and f362_local0.charmIndex then
		return f362_local0.charmIndex:get()
	else
		return CoD.CACUtility.EmptyItemIndex
	end
end
CoD.WZUtility.SetArmoryCharmItem = function(f363_arg0, f363_arg1, f363_arg2)
	local f363_local0 = f363_arg0._model
	if f363_local0 then
		f363_local0 = f363_arg0._model.itemIndex:get()
	end
	local f363_local1 = CoD.WZUtility.GetVariantSlot(f363_arg1, f363_local0, true)
	if not f363_local1 then
		return
	elseif f363_local1.charmIndex then
		f363_local1.charmIndex:set(f363_arg2)
	end
end
CoD.WZUtility.GetArmoryCharmItem = function(f364_arg0, f364_arg1)
	local f364_local0 = f364_arg0._model
	if f364_local0 then
		f364_local0 = f364_arg0._model.itemIndex:get()
	end
	return CoD.WZUtility.GetArmoryCharmItemFromWeapon(f364_arg1, f364_local0)
end
CoD.WZUtility.IsArmoryWeaponCharmEquipped = function(f365_arg0, f365_arg1, f365_arg2)
	local f365_local0 = CoD.SafeGetModelValue(f365_arg1:getModel(), "itemIndex")
	local f365_local1 = f365_arg0._model
	if f365_local1 then
		f365_local1 = f365_arg0._model.itemIndex:get()
	end
	local f365_local2 = CoD.WZUtility.GetVariantSlot(f365_arg2, f365_local1, true)
	if not f365_local2 or not f365_local0 then
		return false
	elseif f365_local2.charmIndex then
		return f365_local2.charmIndex:get() == f365_local0
	else
		return false
	end
end
CoD.WZUtility.SetArmoryDeathFx = function(f366_arg0, f366_arg1, f366_arg2)
	local f366_local0 = f366_arg0._model
	if f366_local0 then
		f366_local0 = f366_arg0._model.itemIndex:get()
	end
	local f366_local1 = CoD.WZUtility.GetVariantSlot(f366_arg1, f366_local0, true)
	if not f366_local1 then
		return
	elseif f366_local1.deathFxIndex then
		f366_local1.deathFxIndex:set(f366_arg2)
	end
end
CoD.WZUtility.GetArmoryDeathFx = function(f367_arg0, f367_arg1)
	local f367_local0 = f367_arg0._model
	if f367_local0 then
		f367_local0 = f367_arg0._model.itemIndex:get()
	end
	local f367_local1 = CoD.WZUtility.GetVariantSlot(f367_arg1, f367_local0, true)
	if f367_local1 and f367_local1.deathFxIndex then
		return f367_local1.deathFxIndex:get()
	else
		return CoD.CACUtility.EmptyItemIndex
	end
end
CoD.WZUtility.IsArmoryWeaponDeathFxEquipped = function(f368_arg0, f368_arg1, f368_arg2)
	local f368_local0 = CoD.SafeGetModelValue(f368_arg1:getModel(), "itemIndex")
	local f368_local1 = f368_arg0._model
	if f368_local1 then
		f368_local1 = f368_arg0._model.itemIndex:get()
	end
	local f368_local2 = CoD.WZUtility.GetVariantSlot(f368_arg2, f368_local1, true)
	if not f368_local2 or not f368_local0 then
		return false
	elseif f368_local2.deathFxIndex then
		return f368_local2.deathFxIndex:get() == f368_local0
	else
		return false
	end
end
CoD.WZUtility.PlayWZTrialVideo = function(f369_arg0, f369_arg1)
	if not IsGameTrial() or not IsBooleanDvarSet(@"hash_31C389A5A38BA7C") then
		return
	end
	local f369_local0 = Engine[@"storagegetbuffer"](f369_arg1, Enum[@"storagefiletype"][@"storage_wz_stats_online"])
	if not f369_local0 then
		return
	end
	local f369_local1 = Engine[@"getmodelforcontroller"](f369_arg1)
	f369_local1 = f369_local1:create("attemptedShowWZTrialVideo", true)
	if f369_local1:get() == nil then
		f369_local1:set(false)
	end
	local f369_local2 = f369_local0.extraBools[2]
	if f369_local2:get() == 0 then
		f369_local2:set(1)
		Engine[@"storagewrite"](f369_arg1, Enum[@"storagefiletype"][@"storage_wz_stats_online"])
		f369_local1:set(true)
		return
	elseif f369_local1:get() then
		return
	end
	f369_local2 = f369_local0.extraBools[3]
	if f369_local2:get() ~= 0 then
		return
	end
	f369_local2:set(1)
	Engine[@"storagewrite"](f369_arg1, Enum[@"storagefiletype"][@"storage_wz_stats_online"])
	CoD.WZUtility.PlayWZTrialVideoInternal(f369_arg0, f369_arg1)
end
CoD.WZUtility.PlayWZTrialVideoInternal = function(f370_arg0, f370_arg1)
	local f370_local0 = DataSources.VoDViewer.getModel(f370_arg1)
	f370_local0.stream:set(CoD.VideoStreamingUtility.GetMoviePlayerParams(Enum[@"hash_6C47FC1BD2E5CCEE"][@"hash_390B07394D69C5F4"], "core_frontend_wz_trial_trailer", false, false))
	DelayOpenOverlay(f370_arg0, "VoDViewer", f370_arg1, {
		fullscreen = true,
	})
end
CoD.WZUtility.CreateMOTDWZTrialCard = function(f371_arg0, f371_arg1)
	if not IsBooleanDvarSet(@"hash_31C389A5A38BA7C") then
		return
	else
		table.insert(f371_arg0, {
			models = {
				locked = false,
				name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4BB3EB781613CA2C"),
				iconBackground = @"ui_icon_crm_featured_thanks",
				iconBackgroundFocus = @"ui_icon_crm_featured_thanks",
				descriptionText = @"hash_71B03F3DADFD429C",
				action = function(f372_arg0, f372_arg1, f372_arg2, f372_arg3, f372_arg4)
					CoD.WZUtility.PlayWZTrialVideoInternal(f372_arg4, f372_arg2)
				end,
				showForAllClients = true,
				hasDoubleXP = false,
				hasDoubleWeaponXP = false,
			},
		})
	end
end
CoD.WZUtility.SelectWeaponAndOpenCustomization = function(f373_arg0, f373_arg1, f373_arg2, f373_arg3)
	if f373_arg0.WeaponListWidget and f373_arg0.WeaponListWidget.weaponList then
		local f373_local0 = f373_arg0.WeaponListWidget
		CoD.CraftUtility.SetupPaintjobPersonalization(f373_local0, f373_arg1, f373_arg3)
		CoD.CACUtility.OpenWeaponPersonalizationOverlay(f373_local0, f373_arg0, f373_arg3, f373_arg1, f373_arg2, "primary")
		PlaySoundAlias("uin_toggle_generic")
	end
end
CoD.WZUtility.GetWZInventoryUnlockDescription = function(f374_arg0, f374_arg1, f374_arg2, f374_arg3)
	local f374_local0 = CoD.SafeGetModelValue(f374_arg1, "objective" .. f374_arg2 .. ".unlockProgress")
	if f374_local0 and f374_local0 >= 0 then
		return Engine[@"hash_4F9F1239CFD921FE"](f374_arg3, f374_local0)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f374_arg3)
	end
end
CoD.WZUtility.IsPersonalizationLockedForWeapon = function(f375_arg0, f375_arg1, f375_arg2)
	local f375_local0 = f375_arg1:getModel(f375_arg2, "refHash")
	local f375_local1 = f375_local0 and f375_local0:get()
	if f375_local1 and not CoD.WZUtility.ArrayContains(CoD.WZUtility.WZDLC1WeaponNames, f375_local1) then
		local f375_local2 = CoD.BlackMarketTableUtility.LootInfoLookup(f375_arg2, f375_local1)
		if f375_local2.isLoot then
			return not f375_local2.owned
		end
	end
	return false
end
CoD.WZUtility.HasWeaponAttachments = function(f376_arg0, f376_arg1)
	local f376_local0 = DataSources.WarzoneInventory.getModel(f376_arg0)
	local f376_local1 = "weapon"
	return f376_local0["weapon" .. f376_arg1].supportsAttachments:get() == 1
end
CoD.WZUtility.HasAttachments = function(f377_arg0, f377_arg1)
	local f377_local0 = DataSources.WarzoneInventory.getModel(f377_arg0)
	local f377_local1 = "weapon"
	return f377_local0["weapon" .. f377_arg1].hasAttachments:get() == 1
end
CoD.WZUtility.GetDecoratedStringForRank = function(f378_arg0, f378_arg1, f378_arg2)
	local f378_local0 = Enum[@"emodes"][@"mode_warzone"]
	if IsGameModeParagonCapable(f378_local0) and Engine[@"getprestigecap"](f378_local0) <= f378_arg2 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_35927EF63E459082", Engine[@"getparagonrankdisplaylevel"](f378_arg1))
	elseif CoD.PrestigeUtility.GetMaxRankByMode(f378_local0) <= f378_arg0 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_54008CE61FE52DCD")
	else
		return tostring(Engine[@"getrankdisplaylevel"](f378_arg0, f378_local0))
	end
end
CoD.WZUtility.GetRankColorForPLevel = function(f379_arg0, f379_arg1)
	local f379_local0 = Enum[@"emodes"][@"mode_warzone"]
	if IsGameModeParagonCapable(f379_local0) and Engine[@"getprestigecap"](f379_local0) <= f379_arg1 then
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.PlayerParagonOrange)
	else
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.T8__OFF__GRAY)
	end
end
CoD.WZUtility.GetRankStringForRankString = function(f380_arg0)
	return f380_arg0
end
CoD.WZUtility.GetOverheadRankColorForPLevelByXUID = function(f381_arg0, f381_arg1)
	local f381_local0 = f381_arg1
	local f381_local1 = Enum[@"emodes"][@"mode_warzone"]
	if IsGameModeParagonCapable(f381_local1) and Engine[@"getprestigecap"](f381_local1) <= CoD.PrestigeUtility.GetCurrentPLevel(f381_arg0) then
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.PlayerParagonOrange)
	else
		return CoD.ColorUtility.ConvertTableToRGB(Engine[@"islocalclient"](f381_local0) and ColorSet.PlayerYellow or ColorSet.T8__OFF__GRAY)
	end
end
CoD.WZUtility.GetDecoratedStringForRankByXUID = function(f382_arg0, f382_arg1)
	local f382_local0 = Enum[@"emodes"][@"mode_warzone"]
	local f382_local1 = f382_arg1
	local f382_local2 = CoD.PrestigeUtility.GetCurrentPLevel(f382_arg0)
	local f382_local3 = Engine[@"hash_419FAC7D9E55031E"](f382_local1, f382_local0)
	return CoD.WZUtility.GetDecoratedStringForRank(f382_local3.rank or 0, f382_local3.paragonRank or 0, f382_local2)
end
CoD.WZUtility.SetWeaponHeaderTexts = function(f383_arg0, f383_arg1)
	local f383_local0 = f383_arg0.weaponId or 0
	f383_arg1.HeaderWeapon:setText(Engine[@"hash_4F9F1239CFD921FE"]("WZ/WEAPON_WITH_ID", tostring(f383_local0 + 1)))
	f383_arg1.HeaderWeaponEquipped:setText(Engine[@"hash_4F9F1239CFD921FE"]("WZ/WEAPON_EQUIPED", tostring(f383_local0 + 1)))
end
CoD.WZUtility.IsWarzoneUIHidden = function(f384_arg0, f384_arg1, f384_arg2)
	if not CoD.HUDUtility.IsWarzone() then
		return false
	elseif Engine[@"getgametypesetting"](f384_arg1) == 1 then
		return true
	end
	local f384_local0 = Engine[@"getprofilevarint"](f384_arg0, f384_arg2)
	local f384_local1 = Engine[@"getgametypesetting"]("maxTeamPlayers")
	if f384_local0 ~= nil then
		if f384_local0 == Enum[@"hash_2893D841C87EFCD2"][@"warzone_show"] then
			return false
		elseif f384_local0 == Enum[@"hash_2893D841C87EFCD2"][@"hash_2AF5BF04553FFD4A"] then
			return f384_local1 > 1
		elseif f384_local0 == Enum[@"hash_2893D841C87EFCD2"][@"hash_29E6666B7E57403C"] then
			return f384_local1 == 1
		elseif f384_local0 == Enum[@"hash_2893D841C87EFCD2"][@"warzone_hide"] then
			return true
		end
	end
	return false
end
CoD.WZUtility.IsWarzoneMapDisabled = function(f385_arg0, f385_arg1)
	if not CoD.HUDUtility.IsWarzone() then
		return false
	elseif Engine[@"getgametypesetting"]("wzDisableMapUI") == 1 then
		return true
	elseif not IsInPrematchPeriod(f385_arg0) and Engine[@"getgametypesetting"]("wzDisableMatchMapUI") == 1 then
		return true
	else
		return false
	end
end
CoD.WZUtility.SetQuickConsumeFilter = function(f386_arg0, f386_arg1, f386_arg2)
	local f386_local0 = f386_arg2
	local f386_local1 = f386_arg2.subscribeToModel
	local f386_local2 = Engine[@"getmodelforcontroller"](f386_arg1)
	f386_local1(f386_local0, f386_local2["hudItems.inventory.quickConsumeNetworkId"], function(f387_arg0)
		f386_arg2:setFilter(function(f388_arg0)
			local f388_local0 = f387_arg0:get()
			local f388_local1
			if f388_arg0.id:get() ~= f388_local0 or f388_local0 == 0 or f388_local0 == CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE then
				f388_local1 = false
			else
				f388_local1 = true
			end
			return f388_local1
		end)
		UpdateDataSource(f386_arg0, f386_arg2, f386_arg1)
	end, false)
end
CoD.WZUtility.ShowQuickInventoryPC = function(f389_arg0)
	local f389_local0 = Engine[@"getmodelforcontroller"](f389_arg0)
	f389_local0 = f389_local0["hudItems.inventory.quickConsumeNetworkId"].get(f389_local0["hudItems.inventory.quickConsumeNetworkId"])
	local f389_local1
	if f389_local0 == 0 or f389_local0 == CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE then
		f389_local1 = false
	else
		f389_local1 = true
	end
	return f389_local1
end
CoD.WZUtility.SendInventoryEquipCurrentConsumable = function(f390_arg0, f390_arg1)
	local f390_local0 = SendCustomClientScriptNotifyForAdjustedClient
	local f390_local1 = f390_arg0
	local f390_local2 = "inventory_equip_quick_consumable"
	local f390_local3 = {}
	local f390_local4 = f390_arg1:getModel()
	f390_local3.id = f390_local4.id:get()
	f390_local0(f390_local1, f390_local2, f390_local3)
end
CoD.WZUtility.WZAARConvertChallengeProgressForBar = function(f391_arg0, f391_arg1, f391_arg2, f391_arg3)
	local f391_local0 = f391_arg1
	local f391_local1 = f391_local0:create("challengeProgress")
	local f391_local2 = f391_local1:create("earnedXpProgress")
	local f391_local3 = f391_local2
	f391_local2 = f391_local2.set
	local f391_local4 = f391_local0.statPercent
	if f391_local4 then
		f391_local4 = f391_local0.statPercent:get()
	end
	f391_local2(f391_local3, f391_local4)
	f391_local2 = f391_local1:create("previousXpProgress")
	f391_local3 = f391_local2
	f391_local2 = f391_local2.set
	f391_local4 = f391_local0.prevStatPercent
	if f391_local4 then
		f391_local4 = f391_local0.prevStatPercent:get()
	end
	f391_local2(f391_local3, f391_local4)
	f391_arg3:setModel(f391_local1, f391_arg2)
end
CoD.WZUtility.WZAARDelayThenAnimateProgress = function(f392_arg0, f392_arg1, f392_arg2, f392_arg3)
	if not f392_arg0:getModel() then
		return
	end
	local f392_local0 = f392_arg0:getModel()
	local f392_local1 = f392_local0.numInGameEntries
	if f392_local1 then
		f392_local1 = f392_local0.numInGameEntries:get()
	end
	local f392_local2 = "uin_draft_bar_fill_1shot"
	local f392_local3 = function()
		local f393_local0 = f392_local0.earnedXpProgress and f392_local0.earnedXpProgress:get() or 0
		CoD.SoundUtility.PlaySoundOnceForController(f392_arg1, f392_local2)
		f392_arg2.Meter:beginAnimation(f392_arg3, Enum[@"luitween"][@"luitween_ease_both"])
		f392_arg2.MeterAdd:beginAnimation(f392_arg3)
		f392_arg2.MeterGlow:beginAnimation(f392_arg3)
		f392_arg2.Meter:setShaderVector(0, f393_local0, 0, 0, 0)
		f392_arg2.MeterAdd:setShaderVector(0, f393_local0, 0, 0, 0)
		f392_arg2.MeterGlow:setShaderVector(0, f393_local0, 0, 0, 0)
	end
	local f392_local4 = f392_local0.previousXpProgress and f392_local0.previousXpProgress:get() or 0
	if (f392_local0.earnedXpProgress and f392_local0.earnedXpProgress:get() or 0) < f392_local4 then
		f392_local4 = 0
	end
	f392_arg2.Meter:setShaderVector(0, f392_local4, 0, 0, 0)
	f392_arg2.MeterAdd:setShaderVector(0, f392_local4, 0, 0, 0)
	f392_arg2.MeterGlow:setShaderVector(0, f392_local4, 0, 0, 0)
	local f392_local5 = f392_arg0._progressDelay
	if not f392_local5 then
		f392_local5 = (f392_local1 + 1) * 200
	end
	f392_arg0._progAnimTimer = LUI.UITimer.newElementTimer(f392_local5, true, f392_local3)
	f392_arg0:addElement(f392_arg0._progAnimTimer)
	f392_arg0._progAnimEndTimer = LUI.UITimer.newElementTimer(f392_local5 + f392_arg3, true, function()
		CoD.SoundUtility.StopPlayOnceSoundForController(f392_arg1, f392_local2)
		local f394_local0 = Engine[@"getmodelforcontroller"](f392_arg1)
		f394_local0.seenWZInGameAAR:set(true)
	end)
	f392_arg0:addElement(f392_arg0._progAnimEndTimer)
end
CoD.WZUtility.WZAARDelayThenAnimateTotalMerits = function(f395_arg0, f395_arg1, f395_arg2, f395_arg3)
	if not f395_arg0:getModel() then
		return
	else
		local f395_local0 = f395_arg0:getModel()
		local f395_local1 = f395_local0.numInGameEntries:get()
		local f395_local2 = f395_local0.totalMerit:get()
		local f395_local3 = 0
		local f395_local4 = function()
			f395_arg0._meritAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f397_arg0)
				f395_local3 = f395_local3 + f397_arg0.timeElapsed
				local f397_local0 = f395_local3 / f395_arg3
				if f395_arg3 <= f395_local3 then
					f395_arg2:setText(tostring(f395_local2))
					f395_arg0._meritAnimTimer:close()
				else
					f395_arg2:setText(tostring(math.floor(f397_local0 * f395_local2)))
				end
			end)
			f395_arg0:addElement(f395_arg0._meritAnimTimer)
		end
		f395_arg2:setText("0")
		f395_arg0._meritTotalDelayTimer = LUI.UITimer.newElementTimer((f395_local1 + 1) * 200, true, f395_local4)
		f395_arg0:addElement(f395_arg0._meritTotalDelayTimer)
	end
end
CoD.WZUtility.DelayThenShowInGameReport = function(f398_arg0, f398_arg1)
	local f398_local0 = Engine[@"getmodelforcontroller"](f398_arg1)
	if not IsOnlineGame() or not IsBooleanDvarSet("ui_showWZAAR") or CoD.BaseUtility.IsSelfInState(f398_arg0, "Elimination") or CoD.HUDUtility.IsWZCustomGame(f398_arg1) or f398_local0.hudItems.warzone.aarViewed:get() then
		return
	else
		f398_arg0._IGRShowTimer = LUI.UITimer.newElementTimer(1500, true, function()
			f398_local0.hudItems.warzone.aarVisible:set(true)
			f398_local0.hudItems.warzone.aarViewed:set(true)
		end)
		f398_arg0:addElement(f398_arg0._IGRShowTimer)
	end
end
CoD.WZUtility.SetupWaveEndTimer = function(f400_arg0, f400_arg1)
	local f400_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "hudItems.waveRespawnTime")
	if f400_local0 then
		f400_arg1:setupEndTimer(Engine[@"getservertime"](f400_arg0) + f400_local0 * 1000)
	end
end
CoD.WZUtility.IsGameTypeEqualToBigTeam = function()
	local f401_local0 = Dvar[@"g_gametype"]:get()
	local f401_local1
	if f401_local0 == nil or f401_local0 ~= "warzone_bigteam_quad" and f401_local0 ~= "warzone_bigteam_dbno_quad" then
		f401_local1 = false
	else
		f401_local1 = true
	end
	return f401_local1
end
