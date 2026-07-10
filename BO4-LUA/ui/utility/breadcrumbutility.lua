
CoD.BreadcrumbUtility = {}
CoD.BreadcrumbUtility.BreadcrumbLoadoutSlots = {
	"primary",
	"secondary",
	"primarygrenade",
	"tacticalgear",
	"talent1",
	"talent2",
	"talent3",
	"bonuscard1"
}
CoD.BreadcrumbUtility.BreadcrumbSprayGestureCateogries = {
	"gestures",
	"tags",
	"tagsets"
}
CoD.BreadcrumbUtility.BreadcrumbStartMenuTabs = {
	"themenu",
	"identity",
	"personalization"
}
CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable = {
	[0] = "zm_specialist_",
	[1] = "mp_specialist_",
	[2] = "",
	[3] = "wz_specialist_",
	[4] = ""
}
CoD.BreadcrumbUtility.OutfitParts = {
	[0] = "arms",
	[1] = "decals",
	[2] = "head",
	[3] = "headgear",
	[4] = "legs",
	[5] = "palette",
	[6] = "torso",
	[7] = "war_paint"
}
CoD.BreadcrumbUtility.PresetPart = "preset"
CoD.BreadcrumbUtility.ItemNewValue = CoDLootShared.ItemOwnedValue
CoD.BreadcrumbUtility.ItemOwnedValue = CoDLootShared.ItemNewValue
CoD.BreadcrumbUtility.BreadcrumbEmblemTabs = {}
CoD.BreadcrumbUtility.BreadcrumbCallingCardTabs = {}
CoD.BreadcrumbUtility.GetRoot = function ( f1_arg0 )
	if IsInGame() then
		return LUI.roots["UIRoot" .. f1_arg0]
	else
		return LUI.roots.UIRootFull
	end
end
CoD.BreadcrumbUtility.QueueBreadcrumbTask = function ( f2_arg0, f2_arg1, f2_arg2 )
	if not IsInGame() then
		local f2_local0 = CoD.BreadcrumbUtility.GetRoot( f2_arg0 )
		if not f2_local0.__breadcrumbTasks then
			f2_local0.__breadcrumbTasks = {}
			f2_local0.__breadcrumbTaskFns = {}
			f2_local0.__breadcrumbTaskTimer = LUI.UITimer.newElementTimer( 0, false, function ()
				local f3_local0 = Engine[@"getdvarint"]( @"hash_285F070D3156AF02" )
				if f3_local0 <= 0 then
					f3_local0 = 1
				end
				for f3_local1 = 1, math.min( #f2_local0.__breadcrumbTasks, f3_local0 ), 1 do
					local f3_local4 = f3_local1
					local f3_local5 = table.remove( f2_local0.__breadcrumbTasks, 1 )
					Engine[@"beginpixevent"]( "Breadcrumb: " .. f3_local5 )
					f2_local0.__breadcrumbTaskFns[f3_local5]()
					Engine[@"endpixevent"]()
					f2_local0.__breadcrumbTaskFns[f3_local5] = nil
				end
				if #f2_local0.__breadcrumbTasks == 0 then
					f2_local0.__breadcrumbTasks = nil
					f2_local0.__breadcrumbTaskFns = nil
					f2_local0.__breadcrumbTaskTimer:close()
					f2_local0.__breadcrumbTaskTimer = nil
				end
			end )
			f2_local0:addElement( f2_local0.__breadcrumbTaskTimer )
		end
		if not f2_local0.__breadcrumbTaskFns[f2_arg1] then
			table.insert( f2_local0.__breadcrumbTasks, f2_arg1 )
		end
		f2_local0.__breadcrumbTaskFns[f2_arg1] = f2_arg2
	end
end
local f0_local0 = function ( f4_arg0 )
	for f4_local3, f4_local4 in ipairs( root.__breadCrumbChildrenParents[f4_arg0] ) do
		root.__breadCrumbParentFns[f4_local4]()
	end
end
CoD.BreadcrumbUtility.BreadcrumbParentUpdateFn = function ( f5_arg0, f5_arg1 )
	local f5_local0 = 0
	for f5_local4, f5_local5 in ipairs( f5_arg0.__breadCrumbChildLinks[f5_arg1] ) do
		if not f5_local5.condition or f5_local5.condition() then
			f5_local0 = f5_local0 + (f5_local5.model:get() or 0)
		end
	end
	f5_arg1:set( f5_local0 )
end
CoD.BreadcrumbUtility.AddChildCountLink = function ( f6_arg0, f6_arg1, f6_arg2, f6_arg3 )
	local f6_local0 = CoD.BreadcrumbUtility.GetRoot( f6_arg0 )
	if not f6_local0.__breadCrumbChildLinks then
		f6_local0.__breadCrumbChildLinks = {}
		f6_local0.__breadCrumbChildSubscriptions = {}
		f6_local0.__breadCrumbChildrenParents = {}
		f6_local0.__breadcrumbSubscriptionFn = function ( f7_arg0 )
			for f7_local3, f7_local4 in ipairs( f6_local0.__breadCrumbChildrenParents[f7_arg0] ) do
				CoD.BreadcrumbUtility.BreadcrumbParentUpdateFn( f6_local0, f7_local4 )
			end
		end
		
	end
	if not f6_local0.__breadCrumbChildLinks[f6_arg1] then
		f6_local0.__breadCrumbChildLinks[f6_arg1] = {}
		table.insert( f6_local0.__breadCrumbChildLinks[f6_arg1], {
			model = f6_arg2,
			condition = f6_arg3
		} )
	elseif not LuaUtils.FindItemInArray( f6_local0.__breadCrumbChildLinks[f6_arg1], function ( f8_arg0, f8_arg1 )
		return f8_arg0 == f8_arg1.model
	end
	 ) then
		table.insert( f6_local0.__breadCrumbChildLinks[f6_arg1], {
			model = f6_arg2,
			condition = f6_arg3
		} )
	end
	if not f6_local0.__breadCrumbChildSubscriptions[f6_arg2] then
		f6_local0.__breadCrumbChildrenParents[f6_arg2] = {
			f6_arg1
		}
		f6_local0.__breadCrumbChildSubscriptions[f6_arg2] = f6_local0:subscribeToModel( f6_arg2, f6_local0.__breadcrumbSubscriptionFn, false )
	elseif not LuaUtils.FindItemInArray( f6_local0.__breadCrumbChildrenParents[f6_arg2], f6_arg1 ) then
		table.insert( f6_local0.__breadCrumbChildrenParents[f6_arg2], f6_arg1 )
	end
end
CoD.BreadcrumbUtility.ForceUpdateChildCountLink = function ( f9_arg0, f9_arg1 )
	local f9_local0 = CoD.BreadcrumbUtility.GetRoot( f9_arg0 )
	if f9_local0.__breadCrumbChildLinks and f9_local0.__breadCrumbChildLinks[f9_arg1] then
		CoD.BreadcrumbUtility.BreadcrumbParentUpdateFn( f9_local0, f9_arg1 )
	end
end
CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer = function ( f10_arg0, f10_arg1 )
	if not f10_arg1 then
		f10_arg1 = Engine[@"currentsessionmode"]()
	end
	if f10_arg1 == Enum[@"emodes"][@"mode_zombies"] then
		return Engine[@"storagegetbuffer"]( f10_arg0, Enum[@"storagefiletype"][@"storage_zm_stats_online"] )
	elseif f10_arg1 == Enum[@"emodes"][@"mode_warzone"] then
		return Engine[@"storagegetbuffer"]( f10_arg0, Enum[@"storagefiletype"][@"storage_wz_stats_online"] )
	else
		return Engine[@"storagegetbuffer"]( f10_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"] )
	end
end
CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer = function ( f11_arg0, f11_arg1 )
	if not f11_arg1 then
		f11_arg1 = Engine[@"currentsessionmode"]()
	end
	local f11_local0 = Enum[@"storagefiletype"][@"storage_mp_loadouts"]
	if f11_arg1 == Enum[@"emodes"][@"mode_zombies"] then
		f11_local0 = Enum[@"storagefiletype"][@"storage_zm_loadouts"]
	elseif f11_arg1 == Enum[@"emodes"][@"mode_warzone"] then
		f11_local0 = Enum[@"storagefiletype"][@"storage_wz_loadouts"]
	end
	local f11_local1 = Engine[@"storagegetbuffer"]( f11_arg0, f11_local0 )
	if f11_local1 then
		return f11_local1[@"cacloadouts"]
	else
		
	end
end
CoD.BreadcrumbUtility.AreBreadcrumbsEnabled = function ()
	return IsBooleanDvarSet( 0xC636B462826C27 )
end
CoD.BreadcrumbUtility.GetSprayGestureTable = function ()
	if not CoD.BreadcrumbUtility.AllSprayGesturesList then
		CoD.BreadcrumbUtility.AllSprayGesturesList = Engine[@"hash_2B2E4CCC119597B0"]()
	end
	return CoD.BreadcrumbUtility.AllSprayGesturesList
end
CoD.BreadcrumbUtility.UpdateCallingCardOwnedAndCheckIfSeenStat = function ( f14_arg0, f14_arg1, f14_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f14_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f14_arg0 )
		if f14_local0 and f14_local0[@"hash_1D45B221DEE76EE4"] and f14_local0[@"hash_1D45B221DEE76EE4"][f14_arg2] then
			f14_local0[@"hash_1D45B221DEE76EE4"][f14_arg2]:set( CoD.BreadcrumbUtility.ItemOwnedValue )
			return f14_local0[@"hash_58BB06B8B337E385"][f14_arg2]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			return false
		end
	end
end
CoD.BreadcrumbUtility.UpdateEmblemOwnedAndCheckIfSeenStat = function ( f15_arg0, f15_arg1, f15_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f15_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f15_arg0 )
		if f15_local0 and f15_local0[@"icon_owned"] and f15_local0[@"icon_owned"][f15_arg2] then
			f15_local0[@"icon_owned"][f15_arg2]:set( CoD.BreadcrumbUtility.ItemOwnedValue )
			return f15_local0[@"hash_42799A890D40252F"][f15_arg2]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			return false
		end
	end
end
CoD.BreadcrumbUtility.IsStatWeaponItemNew = function ( f16_arg0, f16_arg1, f16_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	elseif CoD.BaseUtility.GetMenuStorageClientBuffer( f16_arg0 ) then
		
	else
		
	end
end
CoD.BreadcrumbUtility.IsStatLootWeaponItemAsOld = function ( f17_arg0, f17_arg1, f17_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return true
	else
		local f17_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f17_arg0 )
		if f17_local0 and f17_local0[@"hash_24B9A9540A303875"] and f17_local0[@"hash_24B9A9540A303875"][f17_arg2] then
			return f17_local0[@"hash_24B9A9540A303875"][f17_arg2]:get() == CoD.BreadcrumbUtility.ItemNewValue
		else
			return true
		end
	end
end
CoD.BreadcrumbUtility.IsStatSignatureWeaponItemAsOld = function ( f18_arg0, f18_arg1, f18_arg2, f18_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return true
	else
		local f18_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f18_arg0 )
		if f18_local0 and f18_local0[@"hash_6326A574B8674519"] and f18_local0[@"hash_6326A574B8674519"][f18_arg2] and f18_local0[@"hash_6326A574B8674519"][f18_arg2][@"hash_5D8E0E10A5664D5C"][f18_arg3] then
			return f18_local0[@"hash_6326A574B8674519"][f18_arg2][@"hash_5D8E0E10A5664D5C"][f18_arg3]:get() == CoD.BreadcrumbUtility.ItemNewValue
		else
			return true
		end
	end
end
CoD.BreadcrumbUtility.IsStatWeaponAttachmentNew = function ( f19_arg0, f19_arg1, f19_arg2, f19_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	elseif CoD.BaseUtility.GetMenuStorageClientBuffer( f19_arg0 ) then
		
	else
		
	end
end
CoD.BreadcrumbUtility.IsStatItemNew = function ( f20_arg0, f20_arg1, f20_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	elseif CoD.BaseUtility.GetMenuStorageClientBuffer( f20_arg0 ) then
		
	else
		
	end
end
CoD.BreadcrumbUtility.IsStatEmblemStickerIconNew = function ( f21_arg0, f21_arg1, f21_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f21_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f21_arg0 )
		if f21_local0 and f21_local0[@"hash_42799A890D40252F"] and f21_local0[@"hash_42799A890D40252F"][f21_arg2] then
			return f21_local0[@"hash_42799A890D40252F"][f21_arg2]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.IsStatCallingCardNew = function ( f22_arg0, f22_arg1, f22_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f22_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f22_arg0 )
		if f22_local0 and f22_local0[@"hash_58BB06B8B337E385"] and f22_local0[@"hash_58BB06B8B337E385"][f22_arg2] then
			return f22_local0[@"hash_58BB06B8B337E385"][f22_arg2]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.IsStatSpecialistSprayGestureNew = function ( f23_arg0, f23_arg1, f23_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f23_local0 = CoD.BaseUtility.GetMenuStorageLoadoutBuffer( f23_arg0 )
		if f23_local0 and f23_local0[@"hash_F48E22CED35E56D"] and f23_local0[@"hash_F48E22CED35E56D"][f23_arg2] then
			return f23_local0[@"hash_F48E22CED35E56D"][f23_arg2]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.IsStatSpecialistOutfitItemNew = function ( f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4, f24_arg5 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	end
	local f24_local0 = CoD.BaseUtility.GetMenuStorageLoadoutBuffer( f24_arg0 )
	if f24_arg0._sessionMode == Enum[@"emodes"][@"mode_zombies"] then
		if not CoD.ZMStoryUtility.CharacterIndexToStory[f24_arg2] then
			CoD.ZMStoryUtility.GenerateCharacterToStoryTable()
		end
		local f24_local1 = CoD.ZMStoryUtility.CharacterIndexToStory[f24_arg2]
		if f24_local1 and f24_local0 then
			f24_local0 = f24_local0[f24_local1]
		end
	end
	if f24_local0 and f24_local0[@"characters"][f24_arg2] and f24_local0[@"characters"][f24_arg2][@"outfit_breadcrumbs"][f24_arg3] then
		if f24_arg4 == CoD.BreadcrumbUtility.PresetPart then
			if f24_local0[@"characters"][f24_arg2][@"outfit_breadcrumbs"][f24_arg3][@"hash_63930AAFA5D6AC7B"][f24_arg5] then
				return f24_local0[@"characters"][f24_arg2][@"outfit_breadcrumbs"][f24_arg3][@"hash_63930AAFA5D6AC7B"][f24_arg5]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
			end
		elseif f24_local0[@"characters"][f24_arg2][@"outfit_breadcrumbs"][f24_arg3][@"parts"][f24_arg4] and f24_local0[@"characters"][f24_arg2][@"outfit_breadcrumbs"][f24_arg3][@"parts"][f24_arg4][@"hash_3D834AEE4BD18D13"][f24_arg5] then
			return f24_local0[@"characters"][f24_arg2][@"outfit_breadcrumbs"][f24_arg3][@"parts"][f24_arg4][@"hash_3D834AEE4BD18D13"][f24_arg5]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		end
	end
end
CoD.BreadcrumbUtility.JumpkitPartLookup = {
	[Enum[@"hash_58037372CBD17C20"][@"hash_7BF99C226E97F1DB"]] = @"parachute",
	[Enum[@"hash_58037372CBD17C20"][@"hash_4711A76E11C936FF"]] = @"trail",
	[Enum[@"hash_58037372CBD17C20"][@"hash_D7DC1BB143B4455"]] = @"wingsuit"
}
CoD.BreadcrumbUtility.IsStatSpecialistJumpKitPartNew = function ( f25_arg0, f25_arg1, f25_arg2, f25_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f25_local0 = CoD.BaseUtility.GetMenuStorageLoadoutBuffer( f25_arg0 )
		local f25_local1 = CoD.BreadcrumbUtility.JumpkitPartLookup[f25_arg3]
		if f25_local0 and f25_local1 and f25_local0[@"hash_729CAD1E38EC0D06"] and f25_local0[@"hash_729CAD1E38EC0D06"][f25_local1] and f25_local0[@"hash_729CAD1E38EC0D06"][f25_local1].jumpkit_part_marked_old[f25_arg2] then
			return f25_local0[@"hash_729CAD1E38EC0D06"][f25_local1].jumpkit_part_marked_old[f25_arg2]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.IsStatWeaponAccessoryNew = function ( f26_arg0, f26_arg1, f26_arg2, f26_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f26_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f26_arg0 )
		if f26_local0 and f26_local0[@"hash_6326A574B8674519"] and f26_local0[@"hash_6326A574B8674519"][f26_arg2] and f26_local0[@"hash_6326A574B8674519"][f26_arg2][@"hash_46F3E7D5FFAA28E0"] and f26_local0[@"hash_6326A574B8674519"][f26_arg2][@"hash_46F3E7D5FFAA28E0"][f26_arg3] then
			return f26_local0[@"hash_6326A574B8674519"][f26_arg2][@"hash_46F3E7D5FFAA28E0"][f26_arg3]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.IsStatWeaponDeathFxNew = function ( f27_arg0, f27_arg1, f27_arg2, f27_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	elseif CoD.WeaponOptionsUtility.ExcludedShippedDeathFxWeapons[f27_arg2] then
		return false
	else
		local f27_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f27_arg0 )
		if f27_local0 and f27_local0[@"hash_6326A574B8674519"] and f27_local0[@"hash_6326A574B8674519"][f27_arg2] and f27_local0[@"hash_6326A574B8674519"][f27_arg2][@"hash_6790AE6A6414898A"] and f27_local0[@"hash_6326A574B8674519"][f27_arg2][@"hash_6790AE6A6414898A"][f27_arg3] then
			return f27_local0[@"hash_6326A574B8674519"][f27_arg2][@"hash_6790AE6A6414898A"][f27_arg3]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.IsStatWeaponOpticNew = function ( f28_arg0, f28_arg1, f28_arg2, f28_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f28_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f28_arg0 )
		if f28_local0 and f28_local0[@"hash_6326A574B8674519"] and f28_local0[@"hash_6326A574B8674519"][f28_arg2] and f28_local0[@"hash_6326A574B8674519"][f28_arg2][@"hash_5F4B90954C205CDE"] and f28_local0[@"hash_6326A574B8674519"][f28_arg2][@"hash_5F4B90954C205CDE"][f28_arg3] then
			return f28_local0[@"hash_6326A574B8674519"][f28_arg2][@"hash_5F4B90954C205CDE"][f28_arg3]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.IsStatWeaponCamoNew = function ( f29_arg0, f29_arg1, f29_arg2, f29_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f29_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f29_arg0 )
		if f29_local0 and f29_local0[@"hash_6326A574B8674519"] and f29_local0[@"hash_6326A574B8674519"][f29_arg2] and f29_local0[@"hash_6326A574B8674519"][f29_arg2][@"hash_2E3660BDEC3818FD"] and f29_local0[@"hash_6326A574B8674519"][f29_arg2][@"hash_2E3660BDEC3818FD"][f29_arg3] then
			return f29_local0[@"hash_6326A574B8674519"][f29_arg2][@"hash_2E3660BDEC3818FD"][f29_arg3]:get() ~= CoD.BreadcrumbUtility.ItemNewValue
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearWeaponItemNew = function ( f30_arg0, f30_arg1, f30_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	elseif CoD.BaseUtility.GetMenuStorageClientBuffer( f30_arg0 ) then
		
	else
		
	end
end
CoD.BreadcrumbUtility.ClearLootWeaponItemAsOld = function ( f31_arg0, f31_arg1, f31_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	end
	local f31_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f31_arg0 )
	if f31_local0 then
		f31_local0[@"hash_24B9A9540A303875"][f31_arg2]:set( CoD.BreadcrumbUtility.ItemNewValue )
	end
end
CoD.BreadcrumbUtility.ClearSignatureWeaponItemAsOld = function ( f32_arg0, f32_arg1, f32_arg2, f32_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	end
	local f32_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f32_arg0 )
	if f32_local0 then
		f32_local0[@"hash_6326A574B8674519"][f32_arg2][@"hash_5D8E0E10A5664D5C"][f32_arg3]:set( CoD.BreadcrumbUtility.ItemNewValue )
	end
end
CoD.BreadcrumbUtility.ClearWeaponAttachmentNew = function ( f33_arg0, f33_arg1, f33_arg2, f33_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	elseif CoD.BaseUtility.GetMenuStorageClientBuffer( f33_arg0 ) then
		
	else
		
	end
end
CoD.BreadcrumbUtility.ClearItemNew = function ( f34_arg0, f34_arg1, f34_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	elseif CoD.BaseUtility.GetMenuStorageClientBuffer( f34_arg0 ) then
		
	else
		
	end
end
CoD.BreadcrumbUtility.ClearEmblemStickerIconNew = function ( f35_arg0, f35_arg1, f35_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f35_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f35_arg0 )
		if f35_local0 then
			return f35_local0[@"hash_42799A890D40252F"][f35_arg2]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearCallingCardNew = function ( f36_arg0, f36_arg1, f36_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f36_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f36_arg0 )
		if f36_local0 then
			return f36_local0[@"hash_58BB06B8B337E385"][f36_arg2]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearSprayGestureNew = function ( f37_arg0, f37_arg1, f37_arg2 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f37_local0 = CoD.BaseUtility.GetMenuStorageLoadoutBuffer( f37_arg0 )
		if f37_local0 and f37_local0[@"hash_F48E22CED35E56D"][f37_arg2] then
			return f37_local0[@"hash_F48E22CED35E56D"][f37_arg2]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearSpecialistOutfitItem = function ( f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4, f38_arg5 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	end
	local f38_local0 = CoD.BaseUtility.GetMenuStorageLoadoutBuffer( f38_arg0 )
	if f38_arg0._sessionMode == Enum[@"emodes"][@"mode_zombies"] then
		if not CoD.ZMStoryUtility.CharacterIndexToStory[f38_arg2] then
			CoD.ZMStoryUtility.GenerateCharacterToStoryTable()
		end
		local f38_local1 = CoD.ZMStoryUtility.CharacterIndexToStory[f38_arg2]
		if f38_local1 and f38_local0 then
			f38_local0 = f38_local0[f38_local1]
		end
	end
	if f38_local0 and f38_local0[@"characters"][f38_arg2] and f38_local0[@"characters"][f38_arg2][@"outfit_breadcrumbs"][f38_arg3] then
		if f38_arg4 == CoD.BreadcrumbUtility.PresetPart then
			if f38_local0[@"characters"][f38_arg2][@"outfit_breadcrumbs"][f38_arg3][@"hash_63930AAFA5D6AC7B"][f38_arg5] then
				return f38_local0[@"characters"][f38_arg2][@"outfit_breadcrumbs"][f38_arg3][@"hash_63930AAFA5D6AC7B"][f38_arg5]:set( CoD.BreadcrumbUtility.ItemNewValue )
			end
		elseif f38_local0[@"characters"][f38_arg2][@"outfit_breadcrumbs"][f38_arg3][@"parts"][f38_arg4] and f38_local0[@"characters"][f38_arg2][@"outfit_breadcrumbs"][f38_arg3][@"parts"][f38_arg4][@"hash_3D834AEE4BD18D13"][f38_arg5] then
			return f38_local0[@"characters"][f38_arg2][@"outfit_breadcrumbs"][f38_arg3][@"parts"][f38_arg4][@"hash_3D834AEE4BD18D13"][f38_arg5]:set( CoD.BreadcrumbUtility.ItemNewValue )
		end
	end
end
CoD.BreadcrumbUtility.ClearJumpKitPartNew = function ( f39_arg0, f39_arg1, f39_arg2, f39_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f39_local0 = CoD.BaseUtility.GetMenuStorageLoadoutBuffer( f39_arg0 )
		local f39_local1 = CoD.BreadcrumbUtility.JumpkitPartLookup[f39_arg3]
		if f39_local0 and f39_local1 and f39_local0[@"hash_729CAD1E38EC0D06"] and f39_local0[@"hash_729CAD1E38EC0D06"][f39_local1] and f39_local0[@"hash_729CAD1E38EC0D06"][f39_local1].jumpkit_part_marked_old[f39_arg2] then
			return f39_local0[@"hash_729CAD1E38EC0D06"][f39_local1].jumpkit_part_marked_old[f39_arg2]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearWeaponAccessoryItem = function ( f40_arg0, f40_arg1, f40_arg2, f40_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f40_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f40_arg0 )
		if f40_local0 and f40_local0[@"hash_6326A574B8674519"] and f40_local0[@"hash_6326A574B8674519"][f40_arg2] and f40_local0[@"hash_6326A574B8674519"][f40_arg2].charms_marked_old and f40_local0[@"hash_6326A574B8674519"][f40_arg2].charms_marked_old[f40_arg3] then
			return f40_local0[@"hash_6326A574B8674519"][f40_arg2].charms_marked_old[f40_arg3]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearWeaponDeathFxItem = function ( f41_arg0, f41_arg1, f41_arg2, f41_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f41_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f41_arg0 )
		if f41_local0 and f41_local0[@"hash_6326A574B8674519"] and f41_local0[@"hash_6326A574B8674519"][f41_arg2] and f41_local0[@"hash_6326A574B8674519"][f41_arg2].deathfx_marked_old and f41_local0[@"hash_6326A574B8674519"][f41_arg2].deathfx_marked_old[f41_arg3] then
			return f41_local0[@"hash_6326A574B8674519"][f41_arg2].deathfx_marked_old[f41_arg3]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearWeaponOpticItem = function ( f42_arg0, f42_arg1, f42_arg2, f42_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f42_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f42_arg0 )
		if f42_local0 and f42_local0[@"hash_6326A574B8674519"] and f42_local0[@"hash_6326A574B8674519"][f42_arg2] and f42_local0[@"hash_6326A574B8674519"][f42_arg2].reticle_marked_old and f42_local0[@"hash_6326A574B8674519"][f42_arg2].reticle_marked_old[f42_arg3] then
			return f42_local0[@"hash_6326A574B8674519"][f42_arg2].reticle_marked_old[f42_arg3]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.ClearWeaponCamoItem = function ( f43_arg0, f43_arg1, f43_arg2, f43_arg3 )
	if not CoD.BreadcrumbUtility.AreBreadcrumbsEnabled() then
		return false
	else
		local f43_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f43_arg0 )
		if f43_local0 and f43_local0[@"hash_6326A574B8674519"] and f43_local0[@"hash_6326A574B8674519"][f43_arg2] and f43_local0[@"hash_6326A574B8674519"][f43_arg2].camos_marked_old and f43_local0[@"hash_6326A574B8674519"][f43_arg2].camos_marked_old[f43_arg3] then
			return f43_local0[@"hash_6326A574B8674519"][f43_arg2].camos_marked_old[f43_arg3]:set( CoD.BreadcrumbUtility.ItemNewValue )
		else
			
		end
	end
end
CoD.BreadcrumbUtility.GetLootWeaponNewCountForSlot = function ( f44_arg0, f44_arg1, f44_arg2 )
	local f44_local0 = 0
	for f44_local4, f44_local5 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f44_arg0._sessionMode, f44_arg2 ) ) do
		f44_local0 = f44_local0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForWeapon( f44_arg0, f44_arg1, f44_local5.nameHash )
	end
	return f44_local0
end
CoD.BreadcrumbUtility.GetLootWeaponNewCountForCategory = function ( f45_arg0, f45_arg1, f45_arg2 )
	local f45_local0 = 0
	local f45_local1 = f45_arg0._sessionMode
	for f45_local5, f45_local6 in ipairs( CoD.CACUtility.GetUnlockableItemsForItemGroup( f45_arg1, f45_local1, f45_arg2 ) ) do
		if not Engine[@"isitemlocked"]( f45_arg1, f45_local6.globalItemIndex, f45_local1 ) then
			f45_local0 = f45_local0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForWeapon( f45_arg0, f45_arg1, f45_local6.nameHash )
		end
	end
	return f45_local0
end
CoD.BreadcrumbUtility.GetLootWeaponNewCountForWeapon = function ( f46_arg0, f46_arg1, f46_arg2 )
	local f46_local0 = 0
	local f46_local1, f46_local2 = CoD.BlackMarketTableUtility.SimpleLootLookup( f46_arg1, f46_arg2 )
	if f46_local1 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"] and f46_local2 and not CoD.BreadcrumbUtility.IsStatLootWeaponItemAsOld( f46_arg0, f46_arg1, f46_arg2 ) then
		f46_local0 = f46_local0 + 1
	end
	for f46_local6, f46_local7 in CoD.CACUtility.ForAvailableSignatureWeapons( f46_arg1, f46_arg2, not IsCurrentMenu( f46_arg0, "PaintjobWeaponSelect" ), true ) do
		local f46_local8 = f46_local7[@"index"]
		if f46_local8 > CoD.CACUtility.EmptyItemIndex and not CoD.BreadcrumbUtility.IsStatSignatureWeaponItemAsOld( f46_arg0, f46_arg1, f46_arg2, f46_local8 - 1 ) then
			f46_local0 = f46_local0 + 1
		end
	end
	return f46_local0
end
CoD.BreadcrumbUtility.UpdateEmblemStickerIconBreadcrumbCount = function ( f47_arg0, f47_arg1 )
	for f47_local3, f47_local4 in ipairs( CoD.BreadcrumbUtility.BreadcrumbEmblemTabs[f47_arg1] ) do
		if f47_local4 then
			DataSources.EmblemCallingCardBreadcrumbs.updateEmblemBreadcrumbs( f47_arg0, f47_arg1, f47_local4 )
		end
	end
end
CoD.BreadcrumbUtility.GetEmblemNewCountFromOwned = function ( f48_arg0, f48_arg1, f48_arg2 )
	local f48_local0 = 0
	if not IsUserContentRestricted( f48_arg1 ) then
		local f48_local1 = CoD.BaseUtility.GetMenuStorageClientBuffer( f48_arg0 )
		if f48_local1 and f48_local1[@"icon_owned"] and f48_local1[@"hash_42799A890D40252F"] then
			local f48_local2 = Engine[@"emblemfiltercount"]( f48_arg1, 0, f48_arg2 )
			for f48_local3 = 0, f48_local2 - 1, 1 do
				local f48_local6 = Engine[@"emblemfiltericonid"]( f48_arg1, 0, f48_arg2, f48_local3 )
				if f48_local1[@"icon_owned"][f48_local6] and f48_local1[@"icon_owned"][f48_local6]:get() == CoDLootShared.ItemOwnedValue and f48_local1[@"hash_42799A890D40252F"][f48_local6] and f48_local1[@"hash_42799A890D40252F"][f48_local6]:get() ~= CoDLootShared.ItemNewValue then
					f48_local0 = f48_local0 + 1
				end
			end
		end
	end
	return f48_local0
end
CoD.BreadcrumbUtility.GetEmblemByCategoryNewCount = function ( f49_arg0, f49_arg1, f49_arg2 )
	if not f49_arg2 then
		return 0
	end
	local f49_local0 = 0
	if not IsUserContentRestricted( f49_arg1 ) then
		local f49_local1 = Engine[@"emblemfiltercount"]( f49_arg1, 0, f49_arg2 )
		for f49_local2 = 0, f49_local1 - 1, 1 do
			local f49_local5 = false
			local f49_local6 = Engine[@"emblemfiltericonid"]( f49_arg1, 0, f49_arg2, f49_local2 )
			if Engine[@"hash_2D1419DCE072A0B1"]( f49_local6 ) then
				f49_local5 = Engine[@"hash_52EE0A51483D8E7C"]( f49_arg1, f49_local6 )
			else
				local f49_local7 = CoD.BlackMarketTableUtility.LootInfoLookup( f49_arg1, CoD.BlackMarketUtility.GetLootDecalName( f49_arg1, f49_local6 ) )
				if f49_local7 then
					f49_local5 = not f49_local7.owned
				else
					f49_local5 = true
				end
			end
			if not f49_local5 and CoD.BreadcrumbUtility.UpdateEmblemOwnedAndCheckIfSeenStat( f49_arg0, f49_arg1, f49_local6 ) then
				f49_local0 = f49_local0 + 1
			end
		end
	end
	return f49_local0
end
CoD.BreadcrumbUtility.GetLootCallingCardNewCountFromOwned = function ( f50_arg0, f50_arg1 )
	local f50_local0 = CoD.BaseUtility.GetMenuStorageClientBuffer( f50_arg0 )
	local f50_local1 = 0
	if f50_local0 and f50_local0[@"hash_1D45B221DEE76EE4"] and f50_local0[@"hash_58BB06B8B337E385"] then
		for f50_local5, f50_local6 in DDLUtils.ipairs( f50_local0[@"hash_1D45B221DEE76EE4"] ) do
			if f50_local0[@"hash_1D45B221DEE76EE4"][f50_local5] and f50_local0[@"hash_1D45B221DEE76EE4"][f50_local5]:get() == CoDLootShared.ItemOwnedValue and f50_local0[@"hash_58BB06B8B337E385"][f50_local5] and f50_local0[@"hash_58BB06B8B337E385"][f50_local5]:get() ~= CoDLootShared.ItemNewValue then
				f50_local1 = f50_local1 + 1
			end
		end
	end
	return f50_local1
end
CoD.BreadcrumbUtility.UpdateOwnedCallingCardsAndCount = function ( f51_arg0, f51_arg1, f51_arg2 )
	local f51_local0 = {}
	local f51_local1 = 0
	if IsLive() and f51_arg2 == "loot" then
		for f51_local7, f51_local8 in ipairs( CoD.BlackMarketTableUtility.GetItemsOfType( f51_arg1, @"calling_card" ) ) do
			if f51_local8 then
				local f51_local5 = nil
				local f51_local6 = CoD.BlackMarketTableUtility.LootInfoLookup( f51_arg1, f51_local8 )
				if f51_local6.setMaster then
					f51_local5 = CoD.BlackMarketUtility.GetMasterCallingCardIdFromImage( f51_local8 )
				else
					f51_local5 = CoD.BlackMarketUtility.GetCallingCardIdFromImage( f51_local8 )
				end
				if f51_local6.owned and f51_local5 and CoD.BreadcrumbUtility.UpdateCallingCardOwnedAndCheckIfSeenStat( f51_arg0, f51_arg1, f51_local5 ) then
					f51_local1 = f51_local1 + 1
				end
			end
		end
	else
		if f51_arg2 == "general" then
			f51_local0 = CoD.ChallengesUtility.GetGeneralCallingCards( f51_arg1, false )
		elseif not CoD.CACUtility.IsProgressionEnabled( f51_arg0._sessionMode ) then
			return 
		elseif f51_arg2 == "mp" then
			f51_local0 = CoD.ChallengesUtility.GetChallengeCardsForSessionMode( f51_arg1, Enum[@"emodes"][@"mode_multiplayer"], f51_arg2, false )
		elseif f51_arg2 == "zm" then
			f51_local0 = CoD.ChallengesUtility.GetChallengeCardsForSessionMode( f51_arg1, Enum[@"emodes"][@"mode_zombies"], f51_arg2, false )
		elseif f51_arg2 == "wz" then
			f51_local0 = CoD.ChallengesUtility.GetChallengeCardsForSessionMode( f51_arg1, Enum[@"emodes"][@"mode_warzone"], f51_arg2, false )
		elseif f51_arg2 == "masters" then
			f51_local0 = CoD.ChallengesUtility.GetMasteryChallengeCards( f51_arg1, false )
		end
		for f51_local4, f51_local7 in ipairs( f51_local0 ) do
			if f51_local7 and f51_local7.models then
				local f51_local8 = f51_local7.models
				if f51_local8 and not f51_local8.isLocked and f51_local8.iconId and CoD.BreadcrumbUtility.IsStatCallingCardNew( f51_arg0, f51_arg1, f51_local8.iconId ) then
					f51_local1 = f51_local1 + 1
				end
			end
		end
	end
	return f51_local1
end
CoD.BreadcrumbUtility.UpdateSprayGestureNewCountTable = function ( f52_arg0, f52_arg1, f52_arg2 )
	local f52_local0 = {
		tags = 0,
		tagsets = 0,
		gestures = 0
	}
	if not f52_arg0._sessionMode then
		local f52_local1 = Engine[@"currentsessionmode"]()
	end
	for f52_local8, f52_local9 in ipairs( CoD.BreadcrumbUtility.GetSprayGestureTable() ) do
		local f52_local10 = f52_local9[@"assetname"]
		if CoD.BreadcrumbUtility.IsStatSpecialistSprayGestureNew( f52_arg0, f52_arg1, f52_local8 ) and CoDShared.IsNotLootItemOrIsOwnedById( f52_arg1, f52_local10 ) then
			local f52_local5 = CoD.BlackMarketTableUtility.LootInfoLookup( f52_arg1, f52_local10 )
			if CoD.PlayerRoleUtility.AllowSprayOrGesture( f52_arg1, f52_local9, f52_local5 ) then
				local f52_local6 = f52_local9[@"entitlement"]
				if f52_local6 then
					f52_local6 = f52_local9[@"entitlement"] ~= 0x0
				end
				local f52_local7 = f52_local9[@"isdefault"]
				if f52_local7 then
					f52_local7 = f52_local9[@"isdefault"] == 1
				end
				if f52_local9[@"type"] == @"tag" then
					if not f52_local5 or not f52_local5.inSet then
						if not f52_local7 and (f52_local6 or f52_local5.owned) then
							if f52_arg2 then
								CoD.BreadcrumbUtility.ClearSprayGestureNew( f52_arg0, f52_arg1, f52_local8 )
							else
								f52_local0.tags = f52_local0.tags + 1
								goto basicblock_31:
							end
						end
					end
					if f52_local6 or f52_local5.owned then
						if f52_arg2 then
							CoD.BreadcrumbUtility.ClearSprayGestureNew( f52_arg0, f52_arg1, f52_local8 )
						else
							f52_local0.tagsets = f52_local0.tagsets + 1
							goto basicblock_31:
						end
					end
				end
				if f52_local9[@"type"] == @"gesture" and (f52_local6 or f52_local5.owned) then
					if f52_arg2 then
						CoD.BreadcrumbUtility.ClearSprayGestureNew( f52_arg0, f52_arg1, f52_local8 )
					else
						f52_local0.gestures = f52_local0.gestures + 1
					end
				end
			end
		end
	end
	f52_local2 = DataSources.SprayGestureBreadcrumbs.getModel( f52_arg1 )
	f52_local2.tags.breadcrumbCount:set( f52_local0.tags )
	f52_local2.tagsets.breadcrumbCount:set( f52_local0.tagsets )
	f52_local2.gestures.breadcrumbCount:set( f52_local0.gestures )
end
CoD.BreadcrumbUtility.GetAccessoryNewCountForWeapon = function ( f53_arg0, f53_arg1, f53_arg2 )
	local f53_local0 = 0
	local f53_local1 = CoD.BaseUtility.GetMenuStorageClientBuffer( f53_arg0 )
	local f53_local2 = Engine[@"hash_7A7E3CD65E63086F"]( @"hash_5F2DC7A2FE7EEDC5" )
	local f53_local3 = {
		weaponRef = f53_arg2
	}
	if f53_local2 then
		for f53_local7, f53_local8 in ipairs( f53_local2 ) do
			local f53_local9 = CoD.BlackMarketTableUtility.LootInfoLookup( f53_arg1, f53_local8[@"lootid"], f53_local8[@"entitlement"], f53_local3 )
			if f53_local9 and f53_local9.owned and (f53_local9.isEntitlement or f53_local9.isLoot) and CoD.BreadcrumbUtility.IsStatWeaponAccessoryNew( f53_arg0, f53_arg1, f53_arg2, f53_local7 - 1 ) then
				f53_local0 = f53_local0 + 1
			end
		end
	end
	return f53_local0
end
CoD.BreadcrumbUtility.GetDeathFxNewCountForWeapon = function ( f54_arg0, f54_arg1, f54_arg2 )
	if CoD.WeaponOptionsUtility.ExcludedShippedDeathFxWeapons[f54_arg2] then
		return 0
	end
	local f54_local0 = 0
	local f54_local1 = CoD.BaseUtility.GetMenuStorageClientBuffer( f54_arg0 )
	local f54_local2 = Engine[@"hash_7A7E3CD65E63086F"]( @"hash_A8F031F7C7B2ED8" )
	local f54_local3 = {
		weaponRef = f54_arg2
	}
	if f54_local2 then
		for f54_local7, f54_local8 in ipairs( f54_local2 ) do
			local f54_local9 = CoD.BlackMarketTableUtility.LootInfoLookup( f54_arg1, f54_local8[@"lootid"], f54_local8[@"entitlement"], f54_local3 )
			if f54_local9 and f54_local9.owned and (f54_local9.isEntitlement or f54_local9.isLoot) and CoD.BreadcrumbUtility.IsStatWeaponDeathFxNew( f54_arg0, f54_arg1, f54_arg2, f54_local7 - 1 ) then
				f54_local0 = f54_local0 + 1
			end
		end
	end
	return f54_local0
end
CoD.BreadcrumbUtility.GetOpticsNewCountForWeapon = function ( f55_arg0, f55_arg1 )
	local f55_local0 = 0
	if f55_arg0._itemRefHash and f55_arg0._attachmentRef then
		local f55_local1 = CoD.WeaponOptionsUtility.lootReticlesData[f55_arg0._attachmentRef]
		if f55_local1 then
			for f55_local7, f55_local8 in ipairs( f55_local1 ) do
				local f55_local5 = f55_local8.lootItemOverride
				if not f55_local5 then
					f55_local5 = Engine[@"converttoxhash"]( "reticle_" .. f55_arg0._attachmentRef .. "_" .. f55_local8.reticleIndex )
				end
				local f55_local6 = CoD.BlackMarketTableUtility.LootInfoLookup( f55_arg1, f55_local5 )
				if (f55_local6.available or f55_local8.entitlement and Engine[@"hasentitlement"]( f55_arg1, f55_local8.entitlement )) and CoD.BreadcrumbUtility.IsStatWeaponOpticNew( f55_arg0, f55_arg1, f55_arg0._itemRefHash, f55_local8.weaponOptionSubIndex ) then
					f55_local0 = f55_local0 + 1
				end
			end
		end
	end
	return f55_local0
end
CoD.BreadcrumbUtility.BuildWeaponCamoTable = function ( f56_arg0, f56_arg1, f56_arg2, f56_arg3 )
	local f56_local0 = {
		lootbase = {},
		active = {}
	}
	local f56_local1 = Engine[@"tablefindrows"]( CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2BE9816FAD8AD2D2"], "lootbase" )
	if f56_local1 then
		for f56_local5, f56_local6 in ipairs( f56_local1 ) do
			local f56_local7 = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, f56_local6, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"] )
			if f56_local7 then
				table.insert( f56_local0.lootbase, {
					camoName = f56_local7
				} )
			end
		end
	end
	if f56_arg3 then
		local f56_local2 = Engine[@"tablefindrows"]( CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2BE9816FAD8AD2D2"], "active" )
		if f56_local2 then
			for f56_local6, f56_local7 in ipairs( f56_local2 ) do
				local f56_local8 = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, f56_local7, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"] )
				if f56_local8 then
					table.insert( f56_local0.active, {
						camoName = f56_local8
					} )
				end
			end
		end
	end
	return f56_local0
end
CoD.BreadcrumbUtility.GetTotalCamoNewCountForWeapon = function ( f57_arg0, f57_arg1, f57_arg2 )
	local f57_local0 = 0
	local f57_local1 = CoD.WeaponOptionsUtility.WeaponCannotGetHeadshots( f57_arg0._sessionMode, Engine[@"hash_2D97229B24C685D5"]( f57_arg2, f57_arg0._sessionMode ) )
	if f57_arg2 then
		local f57_local2 = CoD.WeaponOptionsUtility.WeaponOptionsTable
		if f57_local2 == nil then
			f57_local2 = CoD.BreadcrumbUtility.BuildWeaponCamoTable( f57_arg0, f57_arg1, f57_arg2, not f57_local1 )
		else
			f57_local2 = f57_local2.camo_loot
		end
		if f57_local2 ~= nil then
			f57_local0 = CoD.BreadcrumbUtility.GetCamoNewCountForWeapon( f57_arg0, f57_arg1, f57_local2.lootbase, f57_arg2 )
			if not f57_local1 then
				f57_local0 = f57_local0 + CoD.BreadcrumbUtility.GetCamoNewCountForWeapon( f57_arg0, f57_arg1, f57_local2.active, f57_arg2 )
			end
		end
	end
	return f57_local0
end
CoD.BreadcrumbUtility.GetCamoNewCountForWeapon = function ( f58_arg0, f58_arg1, f58_arg2, f58_arg3 )
	local f58_local0 = 0
	if f58_arg2 ~= nil then
		for f58_local9, f58_local10 in ipairs( f58_arg2 ) do
			local f58_local4
			if f58_local10 and f58_local10.ref and f58_local10.ref:get() then
				f58_local4 = Engine[@"converttoxhash"]( f58_local10.ref:get() )
				if not f58_local4 then
				
				elseif f58_local4 then
					local f58_local5 = Engine[@"tablelookup"]( CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f58_local4 )
					local f58_local6 = Engine[@"tablelookup"]( CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_entitlement_name"], Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f58_local4 )
					local f58_local7
					if f58_local4 then
						f58_local7 = CoD.WeaponOptionsUtility.AlternateCamoLootIDLookup[f58_local4]
						if not f58_local7 then
						
						else
							local f58_local8 = CoD.BlackMarketTableUtility.GetLootInfoForCamo( f58_arg1, f58_local7, f58_arg3, f58_local6 )
							if f58_local8 and f58_local8.owned and (f58_local8.isEntitlement or f58_local8.isLoot) and f58_local5 and CoD.BreadcrumbUtility.IsStatWeaponCamoNew( f58_arg0, f58_arg1, f58_arg3, f58_local5 ) then
								f58_local0 = f58_local0 + 1
							end
						end
					end
					f58_local7 = f58_local4
				end
			end
			f58_local4 = f58_local10 and f58_local10.camoName
		end
	end
	return f58_local0
end
CoD.BreadcrumbUtility.DecrementPrimarySecondaryBreadCrumbCount = function ( f59_arg0, f59_arg1, f59_arg2 )
	local f59_local0 = CoD.BaseUtility.GetMenuModel( f59_arg0 )
	local f59_local1 = CoD.BaseUtility.GetMenuSessionMode( f59_arg0 )
	if f59_local0 then
		if f59_local1 == Enum[@"emodes"][@"mode_multiplayer"] then
			if f59_arg2 == f59_local0.primary.refHash:get() then
				f59_local0.primary.breadcrumbCount:set( math.max( 0, f59_local0.primary.breadcrumbCount:get() - 1 ) )
			elseif f59_arg2 == f59_local0.secondary.refHash:get() then
				f59_local0.secondary.breadcrumbCount:set( math.max( 0, f59_local0.secondary.breadcrumbCount:get() - 1 ) )
			end
		elseif f59_local1 == Enum[@"emodes"][@"mode_zombies"] then
			f59_local0.breadcrumbCount:set( math.max( 0, f59_local0.breadcrumbCount:get() - 1 ) )
		elseif f59_local1 == Enum[@"emodes"][@"mode_warzone"] then
			f59_local0.breadcrumbCount:set( math.max( 0, f59_local0.breadcrumbCount:get() - 1 ) )
		end
	end
end
CoD.BreadcrumbUtility.SetClientStorageBuffer = function ( f60_arg0, f60_arg1 )
	f60_arg0._storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f60_arg1, CoD.BaseUtility.GetMenuSessionMode( f60_arg0 ) )
end
CoD.BreadcrumbUtility.SetClientStorageBufferForMode = function ( f61_arg0, f61_arg1, f61_arg2 )
	f61_arg0._storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f61_arg1, f61_arg2 )
end
CoD.BreadcrumbUtility.UploadBuffer = function ( f62_arg0, f62_arg1 )
	Engine[@"storagewrite"]( f62_arg0, f62_arg1 )
end
CoD.BreadcrumbUtility.UpdateLoadoutBreadcrumbs = function ( f63_arg0, f63_arg1 )
	local f63_local0 = CoD.BaseUtility.GetMenuSessionMode( f63_arg0 )
	local f63_local1 = DataSources.LoadoutBreadcrumbs.getModel( f63_arg1 )
	if f63_local1 then
		for f63_local5, f63_local6 in ipairs( CoD.BreadcrumbUtility.BreadcrumbLoadoutSlots ) do
			DataSources.LoadoutBreadcrumbs.updateLoadoutSlotBreadcrumbs( f63_local1[f63_local6], f63_arg1, f63_local0, f63_local6 )
		end
	end
end
CoD.BreadcrumbUtility.UpdateWeaponGroupBreadcrumbs = function ( f64_arg0, f64_arg1, f64_arg2 )
	local f64_local0 = CoD.BaseUtility.GetMenuSessionMode( f64_arg0 )
	local f64_local1 = DataSources.LoadoutBreadcrumbs.getModel( f64_arg1 )
	if f64_local1 then
		DataSources.LoadoutBreadcrumbs.updateWeaponGroup( f64_local1[f64_arg2], f64_arg1, f64_local0, f64_arg2 )
	end
end
CoD.BreadcrumbUtility.UpdateWeaponBreadcrumbs = function ( f65_arg0, f65_arg1, f65_arg2 )
	local f65_local0 = CoD.BaseUtility.GetMenuSessionMode( f65_arg0 )
	local f65_local1 = DataSources.LoadoutBreadcrumbs.getModel( f65_arg1 )
	if f65_local1 then
		DataSources.LoadoutBreadcrumbs.updateWeapon( f65_local1.signature[Engine[@"hash_2D97229B24C685D5"]( f65_arg2, f65_local0 )], f65_arg1, f65_local0, f65_arg2 )
	end
end
CoD.BreadcrumbUtility.SetWeaponAsOld = function ( f66_arg0, f66_arg1, f66_arg2, f66_arg3 )
	local f66_local0 = CoD.BaseUtility.GetMenuSessionMode( f66_arg0 )
	if not CoD.BreadcrumbUtility.IsItemNew( f66_arg0, f66_arg2, f66_arg3 ) then
		
	else
		
	end
	local f66_local1 = f66_arg2:getModel()
	if f66_local1 and f66_local1.globalItemIndex then
		local f66_local2 = f66_local1.globalItemIndex:get()
		if CoD.CACUtility.EmptyItemIndex < f66_local2 then
			CoD.BreadcrumbUtility.ClearWeaponItemNew( f66_arg0, f66_arg3, f66_local1.refHash:get() )
			local f66_local3 = CoD.CACUtility.GetUnlockableItemInfo( f66_local2, f66_local0 )
			CoD.BreadcrumbUtility.UpdateWeaponGroupBreadcrumbs( f66_arg0, f66_arg3, f66_local3.itemGroup )
		end
	end
end
CoD.BreadcrumbUtility.SetItemAsOld = function ( f67_arg0, f67_arg1, f67_arg2 )
	local f67_local0 = CoD.BaseUtility.GetMenuSessionMode( f67_arg0 )
	if not CoD.BreadcrumbUtility.IsItemNew( f67_arg0, f67_arg1, f67_arg2 ) then
		
	else
		
	end
	local f67_local1 = f67_arg1:getModel()
	if f67_local1 and f67_local1.globalItemIndex and CoD.CACUtility.EmptyItemIndex < f67_local1.globalItemIndex:get() then
		CoD.BreadcrumbUtility.ClearItemNew( f67_arg0, f67_arg2, f67_local1.refHash:get() )
	end
end
CoD.BreadcrumbUtility.SetAttachmentAsOld = function ( f68_arg0, f68_arg1, f68_arg2 )
	local f68_local0 = CoD.BaseUtility.GetMenuSessionMode( f68_arg0 )
	if not CoD.BreadcrumbUtility.IsAttachmentNew( f68_arg0, f68_arg1, f68_arg2 ) then
		
	else
		
	end
	local f68_local1 = f68_arg1:getModel()
	if f68_local1 and f68_local1.itemIndex and f68_local1.weaponIndex then
		local f68_local2 = f68_local1.weaponIndex:get()
		if CoD.CACUtility.EmptyItemIndex < f68_local2 and CoD.CACUtility.EmptyItemIndex < f68_local1.itemIndex:get() then
			local f68_local3 = CoD.CACUtility.GetUnlockableItemInfo( f68_local2, f68_local0 )
			CoD.BreadcrumbUtility.ClearWeaponAttachmentNew( f68_arg0, f68_arg2, f68_local3.nameHash, f68_local1.attachmentRef:get() )
		end
	end
end
CoD.BreadcrumbUtility.SetLootWeaponAsOld = function ( f69_arg0, f69_arg1, f69_arg2 )
	local f69_local0 = CoD.BaseUtility.GetMenuSessionMode( f69_arg0 )
	local f69_local1 = f69_arg1:getModel()
	if f69_local1 then
		local f69_local2 = f69_local1.refHash:get()
		local f69_local3 = CoD.SafeGetModelValue( f69_local1, "useVariantSlot" )
		if f69_local3 and f69_local3 > 0 then
			CoD.BreadcrumbUtility.ClearSignatureWeaponItemAsOld( f69_arg0, f69_arg2, f69_local2, f69_local3 - 1 )
		else
			CoD.BreadcrumbUtility.ClearLootWeaponItemAsOld( f69_arg0, f69_arg2, f69_local2 )
		end
		CoD.BreadcrumbUtility.UpdateLoadoutBreadcrumbs( f69_arg0, f69_arg2 )
		local f69_local4 = Engine[@"getweapongroup"]( f69_local1.itemIndex:get(), f69_local0 )
		local f69_local5 = CoD.CACUtility.GetWeaponGroupsNames( "primary" )
		local f69_local6 = CoD.CACUtility.GetWeaponGroupsNames( "secondary" )
		local f69_local7
		if f69_local5 then
			f69_local7 = f69_local5[f69_local4]
			if not f69_local7 then
			
			else
				if f69_local7 then
					f69_local7 = f69_local7.weapon_category
				end
				if f69_local7 then
					CoD.BreadcrumbUtility.UpdateWeaponGroupBreadcrumbs( f69_arg0, f69_arg2, f69_local7 )
				end
			end
		end
		f69_local7 = f69_local6 and f69_local6[f69_local4]
	end
end
CoD.BreadcrumbUtility.SetSignatureWeaponAsOld = function ( f70_arg0, f70_arg1, f70_arg2 )
	local f70_local0 = CoD.BaseUtility.GetMenuSessionMode( f70_arg0 )
	local f70_local1 = f70_arg1:getModel()
	if f70_local1 then
		local f70_local2 = f70_local1.weaponNameHash:get()
		local f70_local3 = f70_local1.weaponModelSlotIndex:get()
		if f70_local3 >= 1 then
			CoD.BreadcrumbUtility.ClearSignatureWeaponItemAsOld( f70_arg0, f70_arg2, f70_local2, f70_local3 - 1 )
			CoD.BreadcrumbUtility.UpdateLoadoutBreadcrumbs( f70_arg0, f70_arg2 )
			CoD.BreadcrumbUtility.UpdateWeaponBreadcrumbs( f70_arg0, f70_arg2, f70_local2 )
			local f70_local4 = Engine[@"getweapongroup"]( f70_local1.itemIndex:get(), f70_local0 )
			local f70_local5 = CoD.CACUtility.GetWeaponGroupsNames( "primary" )
			local f70_local6 = CoD.CACUtility.GetWeaponGroupsNames( "secondary" )
			local f70_local7
			if f70_local5 then
				f70_local7 = f70_local5[f70_local4]
				if not f70_local7 then
				
				else
					if f70_local7 then
						f70_local7 = f70_local7.weapon_category
					end
					if f70_local7 then
						CoD.BreadcrumbUtility.UpdateWeaponGroupBreadcrumbs( f70_arg0, f70_arg2, f70_local7 )
					end
				end
			end
			f70_local7 = f70_local6 and f70_local6[f70_local4]
		end
	end
end
CoD.BreadcrumbUtility.SetDecalStickerIconAsOld = function ( f71_arg0, f71_arg1, f71_arg2 )
	local f71_local0 = f71_arg1:getModel()
	local f71_local1 = CoD.SafeGetModelValue( f71_local0, "iconID" )
	if f71_local1 and CoD.ModelUtility.IsSelfModelValueNilOrTrue( f71_arg1, f71_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatEmblemStickerIconNew( f71_arg0, f71_arg1, f71_local1 ) then
		CoD.BreadcrumbUtility.ClearEmblemStickerIconNew( f71_arg0, f71_arg2, f71_local1 )
		UpdateSelfElementState( f71_arg0, f71_arg1, f71_arg2 )
		local f71_local2 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f71_arg2 )
		if f71_local2 then
			if f71_local0.setPieceIndex then
				f71_local2.STICKERSET.breadcrumbCount:set( math.max( 0, f71_local2.STICKERSET.breadcrumbCount:get() - 1 ) )
			else
				f71_local2.STICKER.breadcrumbCount:set( math.max( 0, f71_local2.STICKER.breadcrumbCount:get() - 1 ) )
			end
		end
	end
end
CoD.BreadcrumbUtility.SetEmblemStickerIconAsOld = function ( f72_arg0, f72_arg1, f72_arg2 )
	local f72_local0 = f72_arg1:getModel()
	local f72_local1 = CoD.SafeGetModelValue( f72_local0, "emblemIndex" )
	if f72_local1 and CoD.ModelUtility.IsSelfModelValueNilOrTrue( f72_arg1, f72_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatEmblemStickerIconNew( f72_arg0, f72_arg1, f72_local1 ) then
		CoD.BreadcrumbUtility.ClearEmblemStickerIconNew( f72_arg0, f72_arg2, f72_local1 )
		UpdateSelfElementState( f72_arg0, f72_arg1, f72_arg2 )
		local f72_local2 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f72_arg2 )
		if f72_local2 then
			if f72_local0.setPieceIndex then
				f72_local2.STICKERSET.breadcrumbCount:set( math.max( 0, f72_local2.STICKERSET.breadcrumbCount:get() - 1 ) )
			else
				f72_local2.STICKER.breadcrumbCount:set( math.max( 0, f72_local2.STICKER.breadcrumbCount:get() - 1 ) )
			end
		end
	end
end
CoD.BreadcrumbUtility.SetCallingCardsAsOld = function ( f73_arg0, f73_arg1, f73_arg2 )
	local f73_local0 = f73_arg1:getModel()
	local f73_local1 = CoD.SafeGetModelValue( f73_local0, "iconId" )
	if f73_local1 and not CoD.ModelUtility.IsSelfModelValueTrue( f73_arg1, f73_arg2, "isLocked" ) and CoD.ModelUtility.IsSelfModelValueNilOrTrue( f73_arg1, f73_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatCallingCardNew( f73_arg0, f73_arg1, f73_local1 ) then
		CoD.BreadcrumbUtility.ClearCallingCardNew( f73_arg0, f73_arg2, f73_local1 )
		UpdateSelfElementState( f73_arg0, f73_arg1, f73_arg2 )
		local f73_local2 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f73_arg2 )
		if f73_local2 then
			if f73_arg1.category or f73_arg1.subCategory then
				if f73_local2["callingcards_" .. f73_arg1.category] then
					local f73_local3 = "callingcards_"
					f73_local3 = f73_local2["callingcards_" .. f73_arg1.category].breadcrumbCount:get()
					local f73_local4 = "callingcards_"
					f73_local2["callingcards_" .. f73_arg1.category].breadcrumbCount:set( math.max( 0, f73_local3 - 1 ) )
				end
				if f73_arg1.subCategory and f73_local2[f73_arg1.subCategory] then
					f73_local2[f73_arg1.subCategory].breadcrumbCount:set( math.max( 0, f73_local2[f73_arg1.subCategory].breadcrumbCount:get() - 1 ) )
				end
				if f73_arg1.breadcrumbModelName and f73_local2[f73_arg1.breadcrumbModelName] then
					f73_local2[f73_arg1.breadcrumbModelName].breadcrumbCount:set( math.max( 0, f73_local2[f73_arg1.breadcrumbModelName].breadcrumbCount:get() - 1 ) )
				end
			else
				local f73_local3 = CoD.SafeGetModelValue( f73_local0, "categoryTab" )
				if f73_local3 and f73_local2["callingcards_" .. f73_local3] then
					local f73_local4 = "callingcards_"
					f73_local4 = f73_local2["callingcards_" .. f73_local3].breadcrumbCount:get()
					local f73_local5 = "callingcards_"
					f73_local2["callingcards_" .. f73_local3].breadcrumbCount:set( math.max( 0, f73_local4 - 1 ) )
				end
				if f73_local2[f73_local1] then
					f73_local2[f73_local1].breadcrumbCount:set( math.max( 0, f73_local2[f73_local1].breadcrumbCount:get() - 1 ) )
				end
			end
		end
	end
end
CoD.BreadcrumbUtility.SetSprayGestureAsOld = function ( f74_arg0, f74_arg1, f74_arg2 )
	local f74_local0 = CoD.SafeGetModelValue( f74_arg1:getModel(), "index" )
	if f74_local0 and CoD.ModelUtility.IsSelfModelValueNilOrTrue( f74_arg1, f74_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatSpecialistSprayGestureNew( f74_arg0, f74_arg2, f74_local0 ) then
		CoD.BreadcrumbUtility.ClearSprayGestureNew( f74_arg0, f74_arg2, f74_local0 )
		UpdateSelfElementState( f74_arg0, f74_arg1, f74_arg2 )
		if f74_arg1.category then
			local f74_local1 = DataSources.SprayGestureBreadcrumbs.getModel( f74_arg2 )
			local f74_local2 = f74_local1[f74_arg1.category]
			if f74_local2 then
				f74_local2.breadcrumbCount:set( math.max( 0, f74_local2.breadcrumbCount:get() - 1 ) )
			end
		end
	end
end
CoD.BreadcrumbUtility.SetSpecialistOutfitItemAsOld = function ( f75_arg0, f75_arg1, f75_arg2 )
	local f75_local0 = f75_arg1:getModel()
	local f75_local1 = CoD.SafeGetModelValue( f75_arg0:getModel(), "characterIndex" )
	if f75_local1 and f75_local0 and f75_local0.outfitIndex and CoD.ModelUtility.IsSelfModelValueNilOrTrue( f75_arg1, f75_arg2, "owned" ) then
		local f75_local2 = f75_local0.outfitIndex:get()
		local f75_local3, f75_local4 = nil
		local f75_local5 = false
		local f75_local6 = nil
		local f75_local7 = Engine[@"currentsessionmode"]()
		if f75_local0.presetIndex and f75_local0.presetIndex:get() ~= -1 then
			f75_local3 = CoD.BreadcrumbUtility.PresetPart
			f75_local4 = f75_local0.presetIndex:get()
			f75_local5 = true
		elseif f75_local0.itemType and f75_local0.itemIndex then
			f75_local6 = f75_local0.itemType:get()
			f75_local3 = CoD.BreadcrumbUtility.OutfitParts[f75_local6]
			f75_local4 = f75_local0.itemIndex:get()
		end
		if f75_local3 and f75_local4 and CoD.BreadcrumbUtility.IsStatSpecialistOutfitItemNew( f75_arg0, f75_arg2, f75_local1, f75_local2, f75_local3, f75_local4 ) then
			CoD.BreadcrumbUtility.ClearSpecialistOutfitItem( f75_arg0, f75_arg2, f75_local1, f75_local2, f75_local3, f75_local4 )
			UpdateSelfElementState( f75_arg0, f75_arg1, f75_arg2 )
			if f75_local5 then
				local f75_local8 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemePreset( f75_arg2, f75_local7, f75_local1, f75_local2 )
				if f75_local8 then
					f75_local8.breadcrumbCount:set( math.max( 0, f75_local8.breadcrumbCount:get() - 1 ) )
				end
			elseif f75_local6 then
				local f75_local8 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemeItemType( f75_arg2, f75_local7, f75_local1, f75_local2, f75_local6 )
				if f75_local8 then
					f75_local8.breadcrumbCount:set( math.max( 0, f75_local8.breadcrumbCount:get() - 1 ) )
				end
			end
		end
	end
end
CoD.BreadcrumbUtility.SetJumpkitPartOld = function ( f76_arg0, f76_arg1, f76_arg2 )
	local f76_local0 = CoD.SafeGetModelValue( f76_arg1:getModel(), "itemIndex" )
	local f76_local1 = CoD.SafeGetModelValue( f76_arg1:getModel(), "type" )
	if f76_local0 and f76_local1 and CoD.ModelUtility.IsSelfModelValueNilOrTrue( f76_arg1, f76_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatSpecialistJumpKitPartNew( f76_arg0, f76_arg2, f76_local0, f76_local1 ) then
		CoD.BreadcrumbUtility.ClearJumpKitPartNew( f76_arg0, f76_arg2, f76_local0, f76_local1 )
		UpdateSelfElementState( f76_arg0, f76_arg1, f76_arg2 )
		local f76_local2 = DataSources.JumpkitBreadcrumbs.getModel( f76_arg2 )
		f76_local2 = f76_local2["part_" .. f76_local1]
		if f76_local2 then
			f76_local2.breadcrumbCount:set( math.max( 0, f76_local2.breadcrumbCount:get() - 1 ) )
		end
	end
end
CoD.BreadcrumbUtility.SetWeaponAccessoryOld = function ( f77_arg0, f77_arg1, f77_arg2 )
	local f77_local0 = CoD.SafeGetModelValue( f77_arg1:getModel(), "itemIndex" )
	if f77_local0 and f77_local0 > 0 then
		local f77_local1 = CoD.GetCustomization( f77_arg2, "weaponRefHash" )
		if CoD.ModelUtility.IsSelfModelValueNilOrTrue( f77_arg1, f77_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatWeaponAccessoryNew( f77_arg0, f77_arg2, f77_local1, f77_local0 ) then
			CoD.BreadcrumbUtility.ClearWeaponAccessoryItem( f77_arg0, f77_arg2, f77_local1, f77_local0 )
			UpdateSelfElementState( f77_arg0, f77_arg1, f77_arg2 )
			local f77_local2 = DataSources.LoadoutBreadcrumbs.getModel( f77_arg2 )
			f77_local2 = f77_local2.accessory
			if f77_local2 then
				f77_local2.breadcrumbCount:set( math.max( 0, f77_local2.breadcrumbCount:get() - 1 ) )
			end
			CoD.BreadcrumbUtility.DecrementPrimarySecondaryBreadCrumbCount( f77_arg0, f77_arg2, f77_local1 )
		end
	end
end
CoD.BreadcrumbUtility.UpdateWeaponAccessoryBreadcrumbs = function ( f78_arg0, f78_arg1 )
	local f78_local0 = CoD.GetCustomization( f78_arg1, "weaponRefHash" )
	local f78_local1 = DataSources.LoadoutBreadcrumbs.getModel( f78_arg1 )
	local f78_local2 = f78_local1.accessory
	if f78_local2 and f78_local0 ~= CoD.SafeGetModelValue( f78_local2, "weaponRefHash" ) then
		DataSources.LoadoutBreadcrumbs.updateWeaponCharmBreadcrumbs( f78_local2, f78_arg1, CoD.BaseUtility.GetMenuSessionMode( f78_arg0 ), f78_local0 )
		f78_local2.weaponRefHash:set( f78_local0 )
	end
end
CoD.BreadcrumbUtility.SetWeaponDeathFxOld = function ( f79_arg0, f79_arg1, f79_arg2 )
	local f79_local0 = CoD.SafeGetModelValue( f79_arg1:getModel(), "itemIndex" )
	if f79_local0 and f79_local0 > 0 then
		local f79_local1 = CoD.GetCustomization( f79_arg2, "weaponRefHash" )
		if CoD.ModelUtility.IsSelfModelValueNilOrTrue( f79_arg1, f79_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatWeaponDeathFxNew( f79_arg0, f79_arg2, f79_local1, f79_local0 ) then
			CoD.BreadcrumbUtility.ClearWeaponDeathFxItem( f79_arg0, f79_arg2, f79_local1, f79_local0 )
			UpdateSelfElementState( f79_arg0, f79_arg1, f79_arg2 )
			local f79_local2 = DataSources.LoadoutBreadcrumbs.getModel( f79_arg2 )
			f79_local2 = f79_local2.deathFx
			if f79_local2 then
				f79_local2.breadcrumbCount:set( math.max( 0, f79_local2.breadcrumbCount:get() - 1 ) )
			end
			CoD.BreadcrumbUtility.DecrementPrimarySecondaryBreadCrumbCount( f79_arg0, f79_arg2, f79_local1 )
		end
	end
end
CoD.BreadcrumbUtility.UpdateWeaponDeathFxBreadcrumbs = function ( f80_arg0, f80_arg1 )
	local f80_local0 = CoD.GetCustomization( f80_arg1, "weaponRefHash" )
	local f80_local1 = DataSources.LoadoutBreadcrumbs.getModel( f80_arg1 )
	local f80_local2 = f80_local1.deathFx
	if f80_local2 and f80_local0 ~= CoD.SafeGetModelValue( f80_local2, "weaponRefHash" ) then
		DataSources.LoadoutBreadcrumbs.updateWeaponDeathFxBreadcrumbs( f80_local2, f80_arg1, CoD.BaseUtility.GetMenuSessionMode( f80_arg0 ), f80_local0 )
		f80_local2.weaponRefHash:set( f80_local0 )
	end
end
CoD.BreadcrumbUtility.SetWeaponOpticOld = function ( f81_arg0, f81_arg1, f81_arg2 )
	local f81_local0 = CoD.SafeGetModelValue( f81_arg1:getModel(), "itemIndex" )
	local f81_local1, f81_local2, f81_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f81_arg0 )
	if f81_local1 and f81_local3 and f81_local0 and f81_local0 > 0 then
		local f81_local4 = f81_local1[f81_local3].refHash:get()
		if f81_local4 and CoD.ModelUtility.IsSelfModelValueNilOrTrue( f81_arg1, f81_arg2, "owned" ) and CoD.BreadcrumbUtility.IsStatWeaponOpticNew( f81_arg0, f81_arg2, f81_local4, f81_local0 ) then
			CoD.BreadcrumbUtility.ClearWeaponOpticItem( f81_arg0, f81_arg2, f81_local4, f81_local0 )
			UpdateSelfElementState( f81_arg0, f81_arg1, f81_arg2 )
			local f81_local5 = DataSources.LoadoutBreadcrumbs.getModel( f81_arg2 )
			f81_local5 = f81_local5.optics
			if f81_local5 then
				f81_local5.breadcrumbCount:set( math.max( 0, f81_local5.breadcrumbCount:get() - 1 ) )
			end
		end
	end
end
CoD.BreadcrumbUtility.UpdateWeaponOpticBreadcrumbs = function ( f82_arg0, f82_arg1 )
	local f82_local0 = DataSources.LoadoutBreadcrumbs.getModel( f82_arg1 )
	local f82_local1 = f82_local0.optics
	if f82_local1 then
		local f82_local2, f82_local3, f82_local4 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f82_arg0 )
		local f82_local5 = CoD.BaseUtility.GetMenuLoadoutListItemSlot( f82_arg0 )
		if f82_local2 and f82_local5 and f82_local4 and f82_local3 then
			DataSources.LoadoutBreadcrumbs.updateWeaponOpticsBreadcrumbs( f82_local1, f82_arg1, f82_local3, CoD.SafeGetModelValue( f82_local2[f82_local4], "refHash" ), CoD.SafeGetModelValue( f82_local2[f82_local5], "ref" ) )
		end
	end
end
CoD.BreadcrumbUtility.SetWeaponCamoOld = function ( f83_arg0, f83_arg1, f83_arg2 )
	local f83_local0 = f83_arg1 and f83_arg1:getModel()
	local f83_local1
	if f83_local0 then
		f83_local1 = CoD.SafeGetModelValue( f83_local0, "lootData.owned" )
		if not f83_local1 then
		
		else
			if f83_local0 and f83_local1 == true and CoD.BreadcrumbUtility.IsWeaponCamoNew( f83_arg0, f83_arg1, f83_arg2 ) then
				local f83_local2 = CoD.GetCustomization( f83_arg2, "weaponRefHash" )
				local f83_local3 = Engine[@"tablelookup"]( CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], CoD.SafeGetModelValue( f83_local0, "ref" ) )
				if f83_local2 and f83_local3 then
					CoD.BreadcrumbUtility.ClearWeaponCamoItem( f83_arg0, f83_arg2, f83_local2, f83_local3 )
					UpdateSelfElementState( f83_arg0, f83_arg1, f83_arg2 )
					CoD.BreadcrumbUtility.DecrementPrimarySecondaryBreadCrumbCount( f83_arg0, f83_arg2, f83_local2 )
				end
			end
		end
	end
	f83_local1 = true
end
CoD.BreadcrumbUtility.UpdateWeaponCamoBreadcrumbs = function ( f84_arg0, f84_arg1 )
	local f84_local0 = CoD.GetCustomization( f84_arg1, "weaponRefHash" )
	local f84_local1 = DataSources.LoadoutBreadcrumbs.getModel( f84_arg1 )
	local f84_local2 = f84_local1.camos
	if f84_local1 and f84_local2 then
		DataSources.LoadoutBreadcrumbs.updateWeaponCamoBreadcrumbs( f84_local1, f84_arg1, CoD.BaseUtility.GetMenuSessionMode( f84_arg0 ), f84_local0 )
		f84_local2.weaponRefHash:set( f84_local0 )
	end
end
CoD.BreadcrumbUtility.UpdateStartMenuBreadcrumb = function ( f85_arg0 )
	if IsInGame() then
		return 
	end
	local f85_local0 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	if not IsLobbyNetworkModeLAN() and Engine[@"getplayerstats"]( f85_arg0, CoD.STATS_LOCATION_NORMAL, Enum[@"emodes"][@"mode_multiplayer"] ) then
		DataSources.StartMenuBreadcrumbs.recreateStartTabBreadcrumbModelsIfNeeded( f85_arg0, f85_local0, DataSources.StartMenuBreadcrumbs.getModel( f85_arg0 ) )
	end
end
CoD.BreadcrumbUtility.ClearAllPersonalizationBreadcrumbs = function ( f86_arg0, f86_arg1 )
	local f86_local0 = CoD.BaseUtility.GetMenuSessionMode( f86_arg0 )
	for f86_local5, f86_local6 in ipairs( CoD.PlayerRoleUtility.GetHeroList( f86_local0 ) ) do
		if f86_local6 and f86_local6.bodyIndex then
			local f86_local4 = f86_local6.bodyIndex
			DataSources.CharacterBreadcrumbs.updateAllCurrentSpecialistOutfitItemBreadcrumbs( f86_arg0, f86_arg1, f86_local4, CoD.PlayerRoleUtility.GetCachedHeroCustomization( f86_local0, f86_local4 ), true )
		end
	end
	DataSources.StartMenuBreadcrumbs.recreate( f86_arg1 )
	SaveLoadoutGeneric( f86_arg1 )
end
CoD.BreadcrumbUtility.IsItemNew = function ( f87_arg0, f87_arg1, f87_arg2 )
	local f87_local0 = CoD.BaseUtility.GetMenuSessionMode( f87_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f87_local0 ) then
		return false
	end
	local f87_local1 = f87_arg1:getModel()
	if f87_local1 then
		local f87_local2 = CoD.CACUtility.EmptyItemIndex
		if f87_local1.globalItemIndex then
			f87_local2 = f87_local1.globalItemIndex:get()
		end
		if f87_local2 <= CoD.CACUtility.EmptyItemIndex and f87_local1.itemIndex then
			f87_local2 = f87_local1.itemIndex:get()
		end
		if CoD.CACUtility.EmptyItemIndex < f87_local2 then
			local f87_local3 = CoD.CACUtility.GetUnlockableItemInfo( f87_local2, f87_local0 )
			local f87_local4 = f87_local3.nameHash
			local f87_local5 = CoD.SafeGetModelValue( f87_local1, "useVariantSlot" )
			if f87_local5 and f87_local5 > 0 then
				return not CoD.BreadcrumbUtility.IsStatSignatureWeaponItemAsOld( f87_arg0, f87_arg2, f87_local4, f87_local5 - 1 )
			else
				local f87_local6, f87_local7 = CoD.BlackMarketTableUtility.SimpleLootLookup( f87_arg2, f87_local4 )
				if f87_local6 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"] and f87_local7 and not CoD.BreadcrumbUtility.IsStatLootWeaponItemAsOld( f87_arg0, f87_arg2, f87_local4 ) then
					return true
				else
					return CoD.BreadcrumbUtility.IsStatItemNew( f87_arg0, f87_arg2, f87_local4 )
				end
			end
		end
	end
	return false
end
CoD.BreadcrumbUtility.IsAttachmentNew = function ( f88_arg0, f88_arg1, f88_arg2 )
	local f88_local0 = CoD.BaseUtility.GetMenuSessionMode( f88_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f88_local0 ) then
		return false
	end
	local f88_local1 = f88_arg1:getModel()
	if f88_local1 and f88_local1.itemIndex and f88_local1.weaponIndex then
		local f88_local2 = f88_local1.weaponIndex:get()
		if CoD.CACUtility.EmptyItemIndex < f88_local2 and CoD.CACUtility.EmptyItemIndex < f88_local1.itemIndex:get() then
			local f88_local3 = CoD.CACUtility.GetUnlockableItemInfo( f88_local2, f88_local0 )
			return CoD.BreadcrumbUtility.IsStatWeaponAttachmentNew( f88_arg0, f88_arg2, f88_local3.nameHash, f88_local1.attachmentRef:get() )
		end
	end
	return false
end
CoD.BreadcrumbUtility.IsWeaponOpticNew = function ( f89_arg0, f89_arg1, f89_arg2 )
	local f89_local0 = CoD.BaseUtility.GetMenuSessionMode( f89_arg0 )
	local f89_local1 = f89_arg1:getModel()
	if f89_local1 and f89_local1.itemIndex and f89_local1.weaponItemIndex then
		local f89_local2 = f89_local1.weaponItemIndex:get()
		local f89_local3 = f89_local1.itemIndex:get()
		if CoD.CACUtility.EmptyItemIndex < f89_local2 and CoD.CACUtility.EmptyItemIndex < f89_local3 then
			local f89_local4 = CoD.CACUtility.GetUnlockableItemInfo( f89_local2, f89_local0 )
			return CoD.BreadcrumbUtility.IsStatWeaponOpticNew( f89_arg0, f89_arg2, f89_local4.nameHash, f89_local3 )
		end
	end
	return false
end
CoD.BreadcrumbUtility.IsWeaponCamoNew = function ( f90_arg0, f90_arg1, f90_arg2 )
	local f90_local0 = CoD.GetCustomization( f90_arg2, "weaponRefHash" )
	local f90_local1 = Engine[@"tablelookup"]( CoD.CACUtility.CamoOptionsTable, Enum[@"hash_25DD5CC8AEA7314B"][@"hash_6A6342D60A0D5AAE"], Enum[@"hash_25DD5CC8AEA7314B"][@"hash_3AA94CABDA68EB21"], f90_arg1 and CoD.SafeGetModelValue( f90_arg1:getModel(), "ref" ) )
	if f90_local0 and f90_local1 and f90_local1 >= 0 then
		return CoD.BreadcrumbUtility.IsStatWeaponCamoNew( f90_arg0, f90_arg2, f90_local0, f90_local1 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.IsAnyOpticsNew = function ( f91_arg0, f91_arg1, f91_arg2 )
	local f91_local0 = CoD.BaseUtility.GetMenuSessionMode( f91_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f91_local0 ) then
		return false
	else
		local f91_local1 = CoD.BaseUtility.GetMenuModel( f91_arg0 )
		if f91_local1 and f91_local1[f91_arg2] and f91_local1[f91_arg2].itemIndex then
			local f91_local2 = f91_local1[f91_arg2].itemIndex:get()
			if not f91_local2 then
				f91_local2 = CoD.CACUtility.EmptyItemIndex
			end
			return Engine[@"areanyopticsnew"]( f91_arg1, f91_local2, f91_local0 )
		else
			return false
		end
	end
end
CoD.BreadcrumbUtility.IsAnyAttachmentsNew = function ( f92_arg0, f92_arg1, f92_arg2 )
	local f92_local0 = CoD.BaseUtility.GetMenuSessionMode( f92_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f92_local0 ) then
		return false
	else
		local f92_local1 = CoD.BaseUtility.GetMenuModel( f92_arg0 )
		if f92_local1 and f92_local1[f92_arg2] and f92_local1[f92_arg2].itemIndex then
			local f92_local2 = f92_local1[f92_arg2].itemIndex:get()
			if not f92_local2 then
				f92_local2 = CoD.CACUtility.EmptyItemIndex
			end
			return Engine[@"areanynonopticattachmentsnew"]( f92_arg1, f92_local2, f92_local0 )
		else
			return false
		end
	end
end
CoD.BreadcrumbUtility.IsAnyLoadoutSlotNew = function ( f93_arg0, f93_arg1 )
	local f93_local0, f93_local1, f93_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f93_arg0 )
	if not CoD.CACUtility.IsProgressionEnabled( f93_local1 ) then
		return false
	elseif f93_local2 then
		return Engine[@"isloadoutslotnew"]( f93_arg1, f93_local2 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.IsAnythingInCACNew = function ( f94_arg0, f94_arg1, f94_arg2 )
	local f94_local0 = f94_arg0 and CoD.BaseUtility.GetMenuSessionMode( f94_arg0 )
	if not f94_local0 and f94_arg2 then
		f94_local0 = f94_arg2
	end
	if not f94_local0 then
		return false
	elseif not CoD.CACUtility.IsProgressionEnabled( f94_local0 ) then
		return false
	else
		
	end
end
CoD.BreadcrumbUtility.IsAnyScorestreaksNew = function ( f95_arg0, f95_arg1, f95_arg2 )
	local f95_local0 = f95_arg0 and CoD.BaseUtility.GetMenuSessionMode( f95_arg0 )
	if not f95_local0 and f95_arg2 then
		f95_local0 = f95_arg2
	end
	if not f95_local0 then
		return false
	else
		
	end
end
CoD.BreadcrumbUtility.IsAnyWeaponGroupNew = function ( f96_arg0, f96_arg1, f96_arg2 )
	if not CoD.CACUtility.IsProgressionEnabled( CoD.BaseUtility.GetMenuSessionMode( f96_arg0 ) ) then
		return false
	else
		local f96_local0 = f96_arg1:getModel()
		if f96_local0 and f96_local0.breadcrumbCount then
			return f96_local0.breadcrumbCount:get() > 0
		else
			return false
		end
	end
end
CoD.BreadcrumbUtility.IsEmblemStickerIconNew = function ( f97_arg0, f97_arg1, f97_arg2 )
	local f97_local0 = CoD.SafeGetModelValue( f97_arg1:getModel(), "emblemIndex" )
	if f97_local0 then
		return CoD.BreadcrumbUtility.IsStatEmblemStickerIconNew( f97_arg0, f97_arg2, f97_local0 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.IsDecalStickerIconNew = function ( f98_arg0, f98_arg1, f98_arg2 )
	local f98_local0 = CoD.SafeGetModelValue( f98_arg1:getModel(), "iconID" )
	if f98_local0 then
		return CoD.BreadcrumbUtility.IsStatEmblemStickerIconNew( f98_arg0, f98_arg2, f98_local0 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.IsAnyEmblemStickerIconNew = function ( f99_arg0, f99_arg1 )
	if IsLive() then
		local f99_local0 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f99_arg1 )
		local f99_local1 = 0
		if f99_local0 then
			for f99_local5, f99_local6 in ipairs( CoD.BreadcrumbUtility.BreadcrumbEmblemTabs[f99_arg1] ) do
				f99_local1 = f99_local1 + CoD.SafeGetModelValue( f99_local0[f99_local6.type], "breadcrumbCount" ) or 0
				if f99_local1 > 0 then
					return true
				end
			end
		end
	end
	return false
end
CoD.BreadcrumbUtility.IsCallingCardNew = function ( f100_arg0, f100_arg1, f100_arg2 )
	local f100_local0 = CoD.SafeGetModelValue( f100_arg1:getModel(), "iconID" )
	if f100_local0 then
		return CoD.BreadcrumbUtility.IsStatCallingCardNew( f100_arg0, f100_arg2, f100_local0 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.IsAnyCallingCardsNew = function ( f101_arg0, f101_arg1 )
	local f101_local0 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f101_arg1 )
	local f101_local1 = 0
	if f101_local0 then
		for f101_local5, f101_local6 in ipairs( CoD.BreadcrumbUtility.BreadcrumbCallingCardTabs[f101_arg1] ) do
			f101_local1 = f101_local1 + (CoD.SafeGetModelValue( f101_local0[f101_local6.type], "breadcrumbCount" ) or 0)
			if f101_local1 > 0 then
				return true
			end
		end
	end
	return false
end
CoD.BreadcrumbUtility.IsSpecialistSprayGestureNew = function ( f102_arg0, f102_arg1, f102_arg2 )
	local f102_local0 = CoD.SafeGetModelValue( f102_arg1:getModel(), "index" )
	if f102_local0 then
		return CoD.BreadcrumbUtility.IsStatSpecialistSprayGestureNew( f102_arg0, f102_arg2, f102_local0 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.IsSpecialistJumpKitPartNew = function ( f103_arg0, f103_arg1, f103_arg2 )
	local f103_local0 = CoD.SafeGetModelValue( f103_arg1:getModel(), "itemIndex" )
	local f103_local1 = CoD.SafeGetModelValue( f103_arg1:getModel(), "type" )
	if f103_local0 and f103_local1 then
		return CoD.BreadcrumbUtility.IsStatSpecialistJumpKitPartNew( f103_arg0, f103_arg2, f103_local0, f103_local1 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.DoesCharacerHaveAnyNew = function ( f104_arg0, f104_arg1, f104_arg2 )
	local f104_local0 = CoD.SafeGetModelValue( f104_arg1:getModel(), "characterIndex" )
	local f104_local1 = CoD.BaseUtility.GetMenuSessionMode( f104_arg0 )
	if f104_local0 and f104_local1 then
		local f104_local2 = DataSources.CharacterBreadcrumbs.getModel( f104_arg2 )
		local f104_local3 = CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f104_local1] .. f104_local0
		if f104_local2 and f104_local2[f104_local3] then
			return CoD.SafeGetModelValue( f104_local2[f104_local3], "breadcrumbCount" ) > 0
		end
	end
	return false
end
CoD.BreadcrumbUtility.ShouldShowTheMenuBreadcrumb = function ( f105_arg0, f105_arg1 )
	return CoD.ModelUtility.IsSelfModelValueGreaterThan( f105_arg0, f105_arg1, "breadcrumbCount", 0 )
end
CoD.BreadcrumbUtility.IsSignatureWeaponNew = function ( f106_arg0, f106_arg1, f106_arg2 )
	if not CoD.CACUtility.IsProgressionEnabled( CoD.BaseUtility.GetMenuSessionMode( f106_arg0 ) ) then
		return false
	end
	local f106_local0 = f106_arg1:getModel()
	if f106_local0 then
		local f106_local1 = f106_local0.weaponNameHash:get()
		local f106_local2 = f106_local0.weaponModelSlotIndex:get()
		if f106_local2 >= 1 then
			return not CoD.BreadcrumbUtility.IsStatSignatureWeaponItemAsOld( f106_arg0, f106_arg2, f106_local1, f106_local2 - 1 )
		end
	end
	return false
end
CoD.BreadcrumbUtility.IsSpecialistOutfitItemNew = function ( f107_arg0, f107_arg1, f107_arg2 )
	local f107_local0 = f107_arg1:getModel()
	local f107_local1 = CoD.SafeGetModelValue( f107_arg0:getModel(), "characterIndex" )
	if f107_local1 and f107_local0 and f107_local0.outfitIndex then
		local f107_local2 = f107_local0.outfitIndex:get()
		local f107_local3, f107_local4 = nil
		if f107_local0.presetIndex and f107_local0.presetIndex:get() ~= -1 then
			f107_local3 = CoD.BreadcrumbUtility.PresetPart
			f107_local4 = f107_local0.presetIndex:get()
		elseif f107_local0.itemType and f107_local0.itemIndex then
			f107_local3 = CoD.BreadcrumbUtility.OutfitParts[f107_local0.itemType:get()]
			f107_local4 = f107_local0.itemIndex:get()
		end
		if f107_local3 and f107_local4 then
			return CoD.BreadcrumbUtility.IsStatSpecialistOutfitItemNew( f107_arg0, f107_arg2, f107_local1, f107_local2, f107_local3, f107_local4 )
		end
	end
	return false
end
CoD.BreadcrumbUtility.IsWeaponAccessoryNew = function ( f108_arg0, f108_arg1, f108_arg2, f108_arg3 )
	local f108_local0 = CoD.SafeGetModelValue( f108_arg2:getModel(), "itemIndex" )
	if not CoD.SafeGetModelValue( f108_arg2:getModel(), "isPrestigeAttachment" ) and f108_local0 and f108_local0 > 0 then
		return CoD.BreadcrumbUtility.IsStatWeaponAccessoryNew( f108_arg0, f108_arg3, CoD.GetCustomization( f108_arg3, "weaponRefHash" ), f108_local0 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.IsWeaponDeathFxNew = function ( f109_arg0, f109_arg1, f109_arg2, f109_arg3 )
	local f109_local0 = CoD.SafeGetModelValue( f109_arg2:getModel(), "itemIndex" )
	if f109_local0 and f109_local0 > 0 then
		return CoD.BreadcrumbUtility.IsStatWeaponDeathFxNew( f109_arg0, f109_arg3, CoD.GetCustomization( f109_arg3, "weaponRefHash" ), f109_local0 )
	else
		return false
	end
end
CoD.BreadcrumbUtility.UpdatePersonalizeStringIfNew = function ( f110_arg0, f110_arg1 )
	local f110_local0 = CoD.SafeGetModelValue( f110_arg0.breadcrumb:get(), "breadcrumbCount" )
	if f110_local0 and f110_local0 > 0 then
		return LocalizeHash( @"hash_4222960C47764579" )
	else
		return LocalizeHash( @"hash_32315E97C5F6E412" )
	end
end
CoD.BreadcrumbUtility.UpdateNewBreadcrumbPersonalizationString = function ( f111_arg0, f111_arg1, f111_arg2 )
	local f111_local0 = f111_arg0:getModel()
	if f111_local0 then
		local f111_local1 = CoD.SafeGetModelValue( f111_local0, "refHash" )
		local f111_local2 = CoD.SafeGetModelValue( f111_local0, "breadcrumbCount" )
		if f111_local2 and f111_local2 > 0 then
			local f111_local3 = Engine[@"currentsessionmode"]()
			local f111_local4 = {
				_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f111_arg1, f111_local3 ),
				_sessionMode = f111_local3
			}
			local f111_local5 = CoD.BreadcrumbUtility.GetAccessoryNewCountForWeapon( f111_local4, f111_arg1, f111_local1 ) or 0
			local f111_local6 = CoD.BreadcrumbUtility.GetDeathFxNewCountForWeapon( f111_local4, f111_arg1, f111_local1 ) or 0
			local f111_local7 = CoD.BreadcrumbUtility.GetTotalCamoNewCountForWeapon( f111_local4, f111_arg1, f111_local1 ) or 0
			if f111_local6 > 0 and f111_local5 > 0 and f111_local7 > 0 then
				return LocalizeHash( @"hash_4FD4E3B92DD58E7E" )
			elseif f111_local6 > 0 and f111_local7 > 0 then
				return LocalizeHash( 0x2BBFED0E90D9A3 )
			elseif f111_local5 > 0 and f111_local7 > 0 then
				return LocalizeHash( @"hash_2F5E5FC338D016E5" )
			elseif f111_local6 > 0 and f111_local5 > 0 then
				return LocalizeHash( @"hash_4CB6A3C969CC6D2B" )
			elseif f111_local6 > 0 then
				return LocalizeHash( @"hash_423F8C0B20F78080" )
			elseif f111_local5 > 0 then
				return LocalizeHash( @"hash_12D5124C8FDAEA4A" )
			elseif f111_local7 > 0 then
				return LocalizeHash( @"hash_6E1AB9CFEA797AC4" )
			end
		end
	end
	return ""
end
DataSourceHelpers.PerControllerDataSourceSetup( "StartMenuBreadcrumbs", "Breadcrumbs.startMenu", function ( f112_arg0, f112_arg1 )
	if IsInGame() then
		return 
	end
	local f112_local0 = Engine[@"currentsessionmode"]()
	local f112_local1 = LobbyData.GetCurrentMenuTarget()
	local f112_local2 = f112_local1[@"id"] == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING )
	DataSources.StartMenuBreadcrumbs.initPersonalizationMode( f112_arg0, f112_local0 )
	for f112_local6, f112_local7 in ipairs( CoD.BreadcrumbUtility.BreadcrumbStartMenuTabs ) do
		local f112_local8 = f112_arg0:create( f112_local7 )
		local f112_local9 = 0
		local f112_local10 = f112_local8:create( "breadcrumbCount" )
		f112_local10:set( f112_local9 )
	end
	if not f112_local2 then
		f112_local3 = DataSources.EmblemCallingCardBreadcrumbs.recreate( f112_arg1 )
		if f112_local3 then
			f112_local4 = f112_arg0:create( "identity" )
			f112_local4 = f112_local4.breadcrumbCount
			for f112_local8, f112_local9 in ipairs( CoD.BreadcrumbUtility.BreadcrumbEmblemTabs[f112_arg1] ) do
				local f112_local10 = CoD.BreadcrumbUtility.AddChildCountLink
				local f112_local11 = f112_arg1
				local f112_local12 = f112_local4
				local f112_local13 = f112_local3:create( f112_local9.type )
				f112_local10( f112_local11, f112_local12, f112_local13:create( "breadcrumbCount" ) )
			end
			for f112_local8, f112_local9 in ipairs( CoD.BreadcrumbUtility.BreadcrumbCallingCardTabs[f112_arg1] ) do
				local f112_local10 = CoD.BreadcrumbUtility.AddChildCountLink
				local f112_local11 = f112_arg1
				local f112_local12 = f112_local4
				local f112_local13 = f112_local3:create( f112_local9.type )
				f112_local10( f112_local11, f112_local12, f112_local13:create( "breadcrumbCount" ) )
			end
			CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f112_arg1, f112_local4 )
		end
	end
	f112_local3 = f112_arg0.themenu.breadcrumbCount
	CoD.BreadcrumbUtility.AddChildCountLink( f112_arg1, f112_local3, f112_arg0.identity.breadcrumbCount )
	CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f112_arg1, f112_local3 )
	f112_arg0.personalizationMode:set( f112_local0 )
end, true, {
	initPersonalizationMode = function ( f113_arg0, f113_arg1 )
		if not f113_arg0.personalizationMode then
			local f113_local0 = f113_arg0:create( "personalizationMode" )
			f113_local0:set( f113_arg1 )
		end
		if not f113_arg0.inventoryUpdated then
			local f113_local0 = f113_arg0:create( "inventoryUpdated" )
			f113_local0:set( false )
			f113_local0 = f113_arg0:create( "callingCardInventoryUpdated" )
			f113_local0:set( false )
			f113_local0 = f113_arg0:create( "emblemInventoryUpdated" )
			f113_local0:set( false )
		end
	end,
	recreateStartTabBreadcrumbModelsIfNeeded = function ( f114_arg0, f114_arg1, f114_arg2 )
		local f114_local0 = false
		if CoD.SafeGetModelValue( f114_arg2, "inventoryUpdated" ) then
			f114_local0 = true
			f114_arg2.inventoryUpdated:set( false )
		end
		if not f114_local0 and f114_arg1 ~= CoD.SafeGetModelValue( f114_arg2, "personalizationMode" ) then
			f114_local0 = true
		end
		if f114_local0 then
			DataSources.StartMenuBreadcrumbs.recreate( f114_arg0 )
			if CoD.SafeGetModelValue( f114_arg2, "callingCardInventoryUpdated" ) then
				DataSources.EmblemCallingCardBreadcrumbs.updateLootCallingCardBreadcrumbs( {
					_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f114_arg0, f114_arg1 ),
					_sessionMode = f114_arg1
				}, f114_arg0 )
				local f114_local1 = f114_arg2:create( "callingCardInventoryUpdated" )
				f114_local1:set( false )
			end
			if CoD.SafeGetModelValue( f114_arg2, "emblemInventoryUpdated" ) then
				DataSources.EmblemCallingCardBreadcrumbs.updateEmblemBreadcrumbs( {
					_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f114_arg0, f114_arg1 ),
					_sessionMode = f114_arg1
				}, f114_arg0 )
				local f114_local1 = f114_arg2:create( "emblemInventoryUpdated" )
				f114_local1:set( false )
			end
			DataSources.JumpkitBreadcrumbs.updateJumpkitBreadcrumbs( f114_arg0 )
			DataSources.SprayGestureBreadcrumbs.updateAllSprayGestureBreadcrumbs( f114_arg0, f114_arg1, false )
			DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded( f114_arg0, f114_arg1 )
		end
	end
} )
DataSourceHelpers.PerControllerDataSourceSetup( "CharacterBreadcrumbs", "Breadcrumbs.characters", function ( f115_arg0, f115_arg1 )
	local f115_local0 = Engine[@"currentsessionmode"]()
	local f115_local1 = f115_arg0:create( "breadcrumbCount" )
	f115_local1:set( 0 )
	if f115_local0 ~= Enum[@"emodes"][@"mode_invalid"] and not IsInGame() and not IsLobbyNetworkModeLAN() then
		local f115_local2 = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer( f115_arg1, f115_local0 )
		local f115_local3 = CoD.PlayerRoleUtility.GetHeroList( f115_local0 )
		local f115_local4 = {}
		for f115_local5 = 0, Enum[@"emodes"][@"mode_count"] - 1, 1 do
			local f115_local8 = f115_arg0:create( "wz_specialist_" .. (CoD.ModeToModeString( f115_local5 ) or "") )
			f115_local4[f115_local5] = f115_local8:create( "breadcrumbCount" )
			f115_local4[f115_local5]:set( 0 )
		end
		local f115_local5 = function ()
			return f115_local0 == Engine[@"currentsessionmode"]()
		end
		
		local f115_local6 = {}
		if f115_local3 then
			for f115_local8, f115_local16 in ipairs( f115_local3 ) do
				if f115_local16 and f115_local16.bodyIndex then
					local f115_local11 = f115_local16.bodyIndex
					local f115_local12 = f115_arg0:create( CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f115_local0] .. f115_local11 )
					local f115_local13 = f115_local12:create( "breadcrumbCount" )
					f115_local13:set( 0 )
					CoD.BreadcrumbUtility.AddChildCountLink( f115_arg1, f115_local1, f115_local13, f115_local5 )
					if CoD.PlayerRoleUtility.IsRoleUnlocked( f115_arg1, f115_local0, f115_local11 ) then
						f115_local6[f115_local11] = f115_local12
						local f115_local14 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter( f115_arg1, f115_local0, f115_local11 )
						CoD.BreadcrumbUtility.AddChildCountLink( f115_arg1, f115_local13, f115_local14:create( "breadcrumbCount" ) )
						CoD.BreadcrumbUtility.QueueBreadcrumbTask( f115_arg1, "updateAllSpecialistOutfitItems " .. f115_local0 .. " " .. f115_local11, function ()
							DataSources.SpecialistOutfitBreadcrumbs.updateAllSpecialistOutfitItems( {
								_storageLoadoutBuffer = f115_local2,
								_sessionMode = f115_local0
							}, f115_arg1, f115_local0, f115_local11, CoD.PlayerRoleUtility.GetCachedHeroCustomization( f115_local0, f115_local11 ), false )
						end )
						if f115_local0 == Enum[@"emodes"][@"mode_warzone"] then
							local f115_local15 = Engine[@"getpositionrolebundleinfo"]( f115_local0, f115_local11 )
							if f115_local15[@"isdefaultcharacter"] ~= 1 then
								CoD.BreadcrumbUtility.AddChildCountLink( f115_arg1, f115_local4[f115_local15[@"modecategory"]], f115_local13 )
							end
						end
						CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f115_arg1, f115_local13 )
					end
				end
			end
		end
		for f115_local8, f115_local16 in pairs( f115_local4 ) do
			CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f115_arg1, f115_local16 )
		end
		DataSources.CharacterBreadcrumbs.characterModels[f115_local0] = f115_local6
	end
	local f115_local2 = f115_arg0:create( "characterId" )
	f115_local2:set( "none" )
	CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f115_arg1, f115_local1 )
end, true, {
	characterModels = {},
	recreateCharacterBreadcrumbModelsIfNeeded = function ( f118_arg0, f118_arg1 )
		local f118_local0 = DataSources.CharacterBreadcrumbs.getModel( f118_arg0 )
		local f118_local1 = false
		local f118_local2 = f118_local0:create( "currentTier" )
		f118_local1 = f118_local2:set( CoD.BlackMarketUtility.GetCurrentSeasonTier( f118_arg0 ) ) or f118_local1
		local f118_local3 = f118_local0:create( "personalizationMode" )
		if f118_local3:set( f118_arg1 ) or f118_local1 then
			DataSources.CharacterBreadcrumbs.recreate( f118_arg0 )
		end
		return f118_local0
	end,
	updateAllCurrentSpecialistOutfitItemBreadcrumbs = function ( f119_arg0, f119_arg1, f119_arg2, f119_arg3, f119_arg4 )
		local f119_local0 = DataSources.CharacterBreadcrumbs.getModel( f119_arg1 )
		local f119_local1 = CoD.BaseUtility.GetMenuSessionMode( f119_arg0 )
		local f119_local2 = CoD.ModeToModeString( f119_local1 ) .. "_" .. f119_arg2
		if f119_local2 ~= f119_local0.characterId:get() then
			DataSources.SpecialistOutfitBreadcrumbs.updateAllSpecialistOutfitItems( f119_arg0, f119_arg1, f119_local1, f119_arg2, f119_arg3, f119_arg4 )
		end
		f119_local0.characterId:set( f119_local2 )
	end
} )
DataSourceHelpers.PerControllerDataSourceSetup( "DepotBreadcrumbs", "Breadcrumbs.depot", function ( f120_arg0, f120_arg1 )
	local f120_local0 = f120_arg0:create( "breadcrumbCount" )
	f120_local0:set( 0 )
	local f120_local1 = DataSources.SprayGestureBreadcrumbs.getModel( f120_arg1 )
	CoD.BreadcrumbUtility.AddChildCountLink( f120_arg1, f120_local0, f120_local1.breadcrumbCount )
	local f120_local2 = DataSources.JumpkitBreadcrumbs.getModel( f120_arg1 )
	CoD.BreadcrumbUtility.AddChildCountLink( f120_arg1, f120_local0, f120_local2.breadcrumbCount, function ()
		return Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"]
	end )
	CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f120_arg1, f120_local0 )
end )
DataSourceHelpers.PerControllerDataSourceSetup( "SprayGestureBreadcrumbs", "Breadcrumbs.sprayGesture", function ( f122_arg0, f122_arg1 )
	local f122_local0 = f122_arg0:create( "breadcrumbCount" )
	f122_local0:set( 0 )
	local f122_local1 = f122_arg0:create( "totaltags" )
	f122_local1 = f122_local1:create( "breadcrumbCount" )
	f122_local1:set( 0 )
	CoD.BreadcrumbUtility.AddChildCountLink( f122_arg1, f122_local0, f122_local1 )
	for f122_local5, f122_local6 in ipairs( CoD.BreadcrumbUtility.BreadcrumbSprayGestureCateogries ) do
		local f122_local7 = f122_arg0:create( f122_local6 )
		f122_local7 = f122_local7:create( "breadcrumbCount" )
		f122_local7:set( 0 )
		if f122_local6 ~= "gestures" then
			CoD.BreadcrumbUtility.AddChildCountLink( f122_arg1, f122_local1, f122_local7 )
		else
			CoD.BreadcrumbUtility.AddChildCountLink( f122_arg1, f122_local0, f122_local7 )
		end
	end
end, true, {
	updateAllSprayGestureBreadcrumbs = function ( f123_arg0, f123_arg1, f123_arg2 )
		local f123_local0 = {
			_storageLoadoutBuffer = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer( f123_arg0, f123_arg1 ),
			_sessionMode = f123_arg1
		}
		if f123_arg1 == Enum[@"emodes"][@"mode_multiplayer"] or f123_arg1 == Enum[@"emodes"][@"mode_warzone"] then
			CoD.BreadcrumbUtility.QueueBreadcrumbTask( f123_arg0, "UpdateSprayGestureNewCountTable", function ()
				CoD.BreadcrumbUtility.UpdateSprayGestureNewCountTable( f123_local0, f123_arg0, f123_arg2 )
			end )
		end
	end
} )
DataSourceHelpers.PerControllerDataSourceSetup( "JumpkitBreadcrumbs", "Breadcrumbs.jumpkits", function ( f125_arg0, f125_arg1 )
	local f125_local0 = f125_arg0:create( "breadcrumbCount" )
	f125_local0:set( 0 )
	for f125_local0 = 0, Enum[@"hash_58037372CBD17C20"][@"hash_7CB623E2324C5CCF"] - 1, 1 do
		local f125_local3 = f125_arg0:create( "part_" .. f125_local0 )
		f125_local3 = f125_local3:create( "breadcrumbCount" )
		f125_local3:set( 0 )
		CoD.BreadcrumbUtility.AddChildCountLink( f125_arg1, f125_arg0.breadcrumbCount, f125_local3 )
	end
	DataSources.JumpkitBreadcrumbs.updateJumpkitBreadcrumbs( f125_arg1 )
end, true, {
	updateJumpkitBreadcrumbs = function ( f126_arg0, f126_arg1 )
		if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
			CoD.BreadcrumbUtility.QueueBreadcrumbTask( f126_arg0, "updateJumpkitBreadcrumbs ", function ()
				local f127_local0 = {}
				for f127_local1 = 0, Enum[@"hash_58037372CBD17C20"][@"hash_7CB623E2324C5CCF"] - 1, 1 do
					f127_local0[f127_local1] = 0
				end
				local f127_local1 = Enum[@"emodes"][@"mode_warzone"]
				local f127_local3 = {
					_storageLoadoutBuffer = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer( f126_arg0, f127_local1 ),
					_sessionMode = f127_local1
				}
				local f127_local4 = Engine[@"hash_7A7E3CD65E63086F"]( @"jumpkits" )
				if f127_local4 then
					for f127_local11, f127_local12 in ipairs( f127_local4 ) do
						local f127_local13, f127_local14 = CoD.BlackMarketTableUtility.SimpleLootLookup( f126_arg0, f127_local12[@"lootid"], f127_local12[@"entitlement"] )
						if f127_local13 == CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"] or f127_local14 then
							for f127_local8 = 0, Enum[@"hash_58037372CBD17C20"][@"hash_7CB623E2324C5CCF"] - 1, 1 do
								if CoD.BreadcrumbUtility.IsStatSpecialistJumpKitPartNew( f127_local3, f126_arg0, f127_local11 - 1, f127_local8 ) then
									if f126_arg1 then
										CoD.BreadcrumbUtility.ClearJumpKitPartNew( f127_local3, f126_arg0, f127_local11 - 1, f127_local8 )
									else
										f127_local0[f127_local8] = f127_local0[f127_local8] + 1
									end
								end
							end
						end
					end
				end
				local f127_local5 = DataSources.JumpkitBreadcrumbs.getModel( f126_arg0 )
				for f127_local6 = 0, Enum[@"hash_58037372CBD17C20"][@"hash_7CB623E2324C5CCF"] - 1, 1 do
					local f127_local13 = "part_"
					f127_local5["part_" .. f127_local6].breadcrumbCount:set( f127_local0[f127_local6] )
				end
			end )
		end
	end
} )
DataSourceHelpers.PerControllerDataSourceSetup( "SpecialistOutfitBreadcrumbs", "Breadcrumbs.outfits", nil, true, {
	updateAllSpecialistOutfitItems = function ( f128_arg0, f128_arg1, f128_arg2, f128_arg3, f128_arg4, f128_arg5 )
		local f128_local0 = f128_arg4.outfits
		local f128_local1 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter( f128_arg1, f128_arg2, f128_arg3 )
		local f128_local2 = 0
		local f128_local3 = {}
		local f128_local4 = 0
		local f128_local5 = f128_local1:create( "breadcrumbCount" )
		f128_local5:set( 0 )
		local f128_local6 = f128_local1:create( "outfits" )
		f128_local6 = f128_local6:create( "breadcrumbCount" )
		f128_local6:set( 0 )
		CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local5, f128_local6 )
		local f128_local7 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForPresetsCategory( f128_arg1, f128_arg2, f128_arg3 )
		f128_local7 = f128_local7:create( "breadcrumbCount" )
		CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local6, f128_local7 )
		local f128_local8 = function ( f129_arg0 )
			if not f129_arg0.isValid then
				return false
			else
				local f129_local0, f129_local1 = CoD.BlackMarketTableUtility.SimpleLootLookup( f128_arg1, f129_arg0.lootId, f129_arg0.entitlement )
				if f129_local0 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"] then
					return f129_local1
				else
					return false
				end
			end
		end
		
		if f128_local0 and #f128_local0 > 0 then
			for f128_local16, f128_local17 in ipairs( f128_local0 ) do
				local f128_local18 = f128_local16 - 1
				local f128_local19 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemePresetCategory( f128_arg1, f128_arg2, f128_arg3, f128_local18 )
				f128_local19 = f128_local19:create( "breadcrumbCount" )
				CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local7, f128_local19 )
				local f128_local20 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemePreset( f128_arg1, f128_arg2, f128_arg3, f128_local18 )
				f128_local20 = f128_local20:create( "breadcrumbCount" )
				CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local19, f128_local20 )
				local f128_local12 = 0
				for f128_local13, f128_local14 in ipairs( f128_local17.presets ) do
					if f128_local8( f128_local14 ) and CoD.BreadcrumbUtility.IsStatSpecialistOutfitItemNew( f128_arg0, f128_arg1, f128_arg3, f128_local18, CoD.BreadcrumbUtility.PresetPart, f128_local13 - 1 ) then
						if f128_arg5 then
							CoD.BreadcrumbUtility.ClearSpecialistOutfitItem( f128_arg0, f128_arg1, f128_arg3, f128_local18, CoD.BreadcrumbUtility.PresetPart, f128_local13 - 1 )
						else
							f128_local12 = f128_local12 + 1
						end
					end
				end
				f128_local20:set( f128_local12 )
			end
			for f128_local16, f128_local17 in ipairs( CoDLoadoutsShared.characterCustomizationRegions ) do
				if f128_local17.requiresBreadcrumb then
					local f128_local18 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForItemTypeCategory( f128_arg1, f128_arg2, f128_arg3, f128_local17.type )
					f128_local18 = f128_local18:create( "breadcrumbCount" )
					if f128_local17.type ~= Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
						CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local6, f128_local18 )
					else
						CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local5, f128_local18 )
					end
					for f128_local21, f128_local22 in ipairs( f128_local0 ) do
						local f128_local15 = f128_local21 - 1
						local f128_local13 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemeItemType( f128_arg1, f128_arg2, f128_arg3, f128_local15, f128_local17.type )
						f128_local13 = f128_local13:create( "breadcrumbCount" )
						CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local18, f128_local13 )
						if f128_local17.type == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
							local f128_local14 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemePresetCategory( f128_arg1, f128_arg2, f128_arg3, f128_local15 )
							f128_local14 = f128_local14:create( "breadcrumbCount" )
							CoD.BreadcrumbUtility.AddChildCountLink( f128_arg1, f128_local14, f128_local13 )
							CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f128_arg1, f128_local14 )
						end
						local f128_local14 = 0
						if f128_local22[f128_local17.name] then
							local f128_local23 = CoD.BreadcrumbUtility.OutfitParts[f128_local17.type]
							for f128_local24 = 1, #f128_local22[f128_local17.name], 1 do
								if f128_local21 ~= 1 or f128_local24 ~= 1 then
									local f128_local27 = f128_local22[f128_local17.name][f128_local24]
									local f128_local28 = f128_local24 - 1
									local f128_local29 = f128_local8( f128_local27 )
									if not f128_local29 and f128_local17.type == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] and f128_local27.lootId ~= 0x0 then
										local f128_local30 = CoD.PlayerRoleUtility.LookupLootForWarPaint( f128_arg1, f128_local27, f128_local22.presets )
										f128_local29 = f128_local30.owned
									end
									if f128_local29 and CoD.BreadcrumbUtility.IsStatSpecialistOutfitItemNew( f128_arg0, f128_arg1, f128_arg3, f128_local15, f128_local23, f128_local28 ) then
										if f128_arg5 then
											CoD.BreadcrumbUtility.ClearSpecialistOutfitItem( f128_arg0, f128_arg1, f128_arg3, f128_local15, f128_local23, f128_local28 )
										else
											f128_local14 = f128_local14 + 1
										end
									end
								end
							end
						end
						f128_local13:set( f128_local14 )
					end
					CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f128_arg1, f128_local18 )
				end
			end
			for f128_local16, f128_local17 in ipairs( f128_local0 ) do
				local f128_local19 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemePresetCategory( f128_arg1, f128_arg2, f128_arg3, f128_local16 - 1 )
				CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f128_arg1, f128_local19:create( "breadcrumbCount" ) )
			end
		end
		CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f128_arg1, f128_local7 )
		CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f128_arg1, f128_local6 )
		CoD.BreadcrumbUtility.ForceUpdateChildCountLink( f128_arg1, f128_local5 )
	end,
	getBreadcrumbModelForCharacter = function ( f130_arg0, f130_arg1, f130_arg2 )
		local f130_local0 = DataSources.SpecialistOutfitBreadcrumbs.getModel( f130_arg0 )
		return f130_local0:create( CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f130_arg1] .. f130_arg2 )
	end,
	getBreadcrumbModelForThemeItemType = function ( f131_arg0, f131_arg1, f131_arg2, f131_arg3, f131_arg4 )
		local f131_local0 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter( f131_arg0, f131_arg1, f131_arg2 )
		f131_local0 = f131_local0:create( "outfit_" .. f131_arg3 )
		return f131_local0:create( "type_" .. f131_arg4 )
	end,
	getBreadcrumbModelForThemePreset = function ( f132_arg0, f132_arg1, f132_arg2, f132_arg3 )
		local f132_local0 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter( f132_arg0, f132_arg1, f132_arg2 )
		f132_local0 = f132_local0:create( "outfit_" .. f132_arg3 )
		return f132_local0:create( "type_preset" )
	end,
	getBreadcrumbModelForThemePresetCategory = function ( f133_arg0, f133_arg1, f133_arg2, f133_arg3 )
		local f133_local0 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter( f133_arg0, f133_arg1, f133_arg2 )
		f133_local0 = f133_local0:create( "outfit_" .. f133_arg3 )
		return f133_local0:create( "type_preset_category" )
	end,
	getBreadcrumbModelForItemTypeCategory = function ( f134_arg0, f134_arg1, f134_arg2, f134_arg3 )
		local f134_local0 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter( f134_arg0, f134_arg1, f134_arg2 )
		return f134_local0:create( "type_" .. f134_arg3 )
	end,
	getBreadcrumbModelForPresetsCategory = function ( f135_arg0, f135_arg1, f135_arg2 )
		local f135_local0 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter( f135_arg0, f135_arg1, f135_arg2 )
		return f135_local0:create( "type_preset" )
	end
} )
DataSourceHelpers.PerControllerDataSourceSetup( "EmblemCallingCardBreadcrumbs", "Breadcrumbs", function ( f136_arg0, f136_arg1 )
	local f136_local0 = Enum[@"emodes"][@"mode_multiplayer"]
	DataSources.EmblemCallingCardBreadcrumbs.initEmblemCallingCardCategories( f136_arg1, f136_arg0, {
		_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f136_arg1, f136_local0 ),
		_sessionMode = f136_local0
	} )
	local f136_local1 = f136_arg0:create( "lootSingleSet" )
	f136_local1 = f136_local1:create( "breadcrumbCount" )
	f136_local1:set( 0 )
end, true, {
	initEmblemCallingCardCategories = function ( f137_arg0, f137_arg1, f137_arg2 )
		if not CoD.BreadcrumbUtility.BreadcrumbEmblemTabs[f137_arg0] then
			CoD.BreadcrumbUtility.BreadcrumbEmblemTabs[f137_arg0] = {
				{
					type = "sticker",
					category = CoD.CraftUtility.EmblemStickerCategory
				},
				{
					type = "stickerset",
					category = CoD.CraftUtility.EmblemStickerSetCategory
				}
			}
			for f137_local3, f137_local4 in ipairs( CoD.BreadcrumbUtility.BreadcrumbEmblemTabs[f137_arg0] ) do
				local f137_local5 = f137_arg1:create( f137_local4.type )
				f137_local5 = f137_local5:create( "breadcrumbCount" )
				f137_local5:set( 0 )
				CoD.BreadcrumbUtility.QueueBreadcrumbTask( f137_arg0, f137_local4.type, function ()
					f137_local5:set( CoD.BreadcrumbUtility.GetEmblemByCategoryNewCount( f137_arg2, f137_arg0, f137_local4.category ) )
				end )
			end
		end
		if not CoD.BreadcrumbUtility.BreadcrumbCallingCardTabs[f137_arg0] then
			CoD.BreadcrumbUtility.BreadcrumbCallingCardTabs[f137_arg0] = {
				{
					type = "callingcards_general",
					category = "general"
				},
				{
					type = "callingcards_mp",
					category = "mp"
				},
				{
					type = "callingcards_zm",
					category = "zm"
				},
				{
					type = "callingcards_wz",
					category = "wz"
				},
				{
					type = "callingcards_masters",
					category = "masters"
				},
				{
					type = "callingcards_loot",
					category = "loot"
				}
			}
			for f137_local3, f137_local4 in ipairs( CoD.BreadcrumbUtility.BreadcrumbCallingCardTabs[f137_arg0] ) do
				local f137_local5 = f137_arg1:create( f137_local4.type )
				f137_local5 = f137_local5:create( "breadcrumbCount" )
				f137_local5:set( 0 )
				CoD.BreadcrumbUtility.QueueBreadcrumbTask( f137_arg0, f137_local4.type, function ()
					f137_local5:set( CoD.BreadcrumbUtility.UpdateOwnedCallingCardsAndCount( f137_arg2, f137_arg0, f137_local4.category ) )
				end )
			end
		end
	end,
	updateEmblemBreadcrumbs = function ( f140_arg0, f140_arg1 )
		local f140_local0 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f140_arg1 )
		if f140_local0 then
			for f140_local4, f140_local5 in ipairs( CoD.BreadcrumbUtility.BreadcrumbEmblemTabs[f140_arg1] ) do
				if f140_local5 and f140_local0[f140_local5.type] then
					CoD.BreadcrumbUtility.QueueBreadcrumbTask( f140_arg1, f140_local5.type, function ()
						f140_local0[f140_local5.type].breadcrumbCount:set( CoD.BreadcrumbUtility.GetEmblemNewCountFromOwned( f140_arg0, f140_arg1, f140_local5.category ) )
					end )
				end
			end
		end
	end,
	updateLootCallingCardBreadcrumbs = function ( f142_arg0, f142_arg1 )
		local f142_local0 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f142_arg1 )
		if f142_local0 and f142_local0.callingcards_loot then
			f142_local0.callingcards_loot.breadcrumbCount.set( REG3.breadcrumbCount, CoD.BreadcrumbUtility.GetLootCallingCardNewCountFromOwned( f142_arg0, f142_arg1 ) )
		end
	end,
	updateCallingCardLootSingleCardSetBreadcrumbs = function ( f143_arg0, f143_arg1 )
		local f143_local0 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f143_arg1 )
		local f143_local1 = 0
		for f143_local5, f143_local6 in ipairs( CoD.BlackMarketUtility.CommonCallingCardsTable ) do
			if f143_local6 and f143_local6.lootInfo.owned and f143_local6.iconId and CoD.BreadcrumbUtility.IsStatCallingCardNew( f143_arg0, f143_arg1, f143_local6.iconId ) then
				f143_local1 = f143_local1 + 1
			end
		end
		f143_local0.lootSingleSet.breadcrumbCount:set( f143_local1 )
	end
} )
DataSourceHelpers.PerControllerDataSourceSetup( "LoadoutBreadcrumbs", "Breadcrumbs", function ( f144_arg0, f144_arg1 )
	local f144_local0 = Engine[@"currentsessionmode"]()
	local f144_local1 = Engine[@"getmodelforcontroller"]( f144_arg1 )
	f144_local1 = f144_local1.isInPaintshop
	if f144_local1 and f144_local1:get() == true then
		f144_local0 = Enum[@"emodes"][@"mode_multiplayer"]
	end
	local f144_local2 = {
		_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f144_arg1, f144_local0 ),
		_sessionMode = f144_local0
	}
	for f144_local6, f144_local7 in ipairs( CoD.BreadcrumbUtility.BreadcrumbLoadoutSlots ) do
		local f144_local8 = f144_arg0:create( f144_local7 )
		local f144_local9 = 0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForSlot( f144_local2, f144_arg1, f144_local7 )
		local f144_local10 = f144_local8:create( "breadcrumbCount" )
		f144_local10:set( f144_local9 )
	end
	f144_local3 = function ( f145_arg0 )
		for f145_local3, f145_local4 in ipairs( f145_arg0 ) do
			local f145_local5 = f145_local4.weapon_category
			local f145_local6 = f144_arg0:create( f145_local5 )
			local f145_local7 = 0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForCategory( f144_local2, f144_arg1, f145_local5 )
			local f145_local8 = f145_local6:create( "breadcrumbCount" )
			f145_local8:set( f145_local7 )
		end
	end
	
	f144_local3( CoD.CACUtility.GetWeaponGroupsNames( "primary" ) )
	f144_local3( CoD.CACUtility.GetWeaponGroupsNames( "secondary" ) )
	for f144_local7, f144_local8 in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
		if (f144_local8.loadoutSlot == "primary" or f144_local8.loadoutSlot == "secondary") and #Engine[@"hash_79F0BB7D52A7A978"]( f144_local8.nameHash ) > 1 then
			local f144_local10 = f144_arg0:create( "signature" )
			f144_local10 = f144_local10:create( f144_local8.itemIndex )
			local f144_local11 = 0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForWeapon( f144_local2, f144_arg1, f144_local8.nameHash )
			local f144_local12 = f144_local10:create( "breadcrumbCount" )
			f144_local12:set( f144_local11 )
		end
	end
	for f144_local7, f144_local8 in ipairs( {
		"accessory",
		"deathfx",
		"optics",
		"camos",
		"basiccamo",
		"activecamo"
	} ) do
		local f144_local9 = f144_arg0:create( f144_local8 )
		local f144_local10 = f144_local9:create( "breadcrumbCount" )
		f144_local10:set( 0 )
		f144_local10 = f144_local9:create( "weaponRefHash" )
		f144_local10:set( 0x0 )
	end
end, false, {
	updateLoadoutSlotBreadcrumbs = function ( f146_arg0, f146_arg1, f146_arg2, f146_arg3 )
		if f146_arg0.breadcrumbCount:get() > 0 then
			f146_arg0.breadcrumbCount:set( 0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForSlot( {
				_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f146_arg1, f146_arg2 ),
				_sessionMode = f146_arg2
			}, f146_arg1, f146_arg3 ) )
		end
	end,
	updateWeaponGroup = function ( f147_arg0, f147_arg1, f147_arg2, f147_arg3 )
		if f147_arg0.breadcrumbCount:get() > 0 then
			f147_arg0.breadcrumbCount:set( 0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForCategory( {
				_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f147_arg1, f147_arg2 ),
				_sessionMode = f147_arg2
			}, f147_arg1, f147_arg3 ) )
		end
	end,
	updateWeapon = function ( f148_arg0, f148_arg1, f148_arg2, f148_arg3 )
		if f148_arg0.breadcrumbCount:get() > 0 then
			f148_arg0.breadcrumbCount:set( 0 + CoD.BreadcrumbUtility.GetLootWeaponNewCountForWeapon( {
				_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f148_arg1, f148_arg2 ),
				_sessionMode = f148_arg2
			}, f148_arg1, f148_arg3 ) )
		end
	end,
	updateWeaponCharmBreadcrumbs = function ( f149_arg0, f149_arg1, f149_arg2, f149_arg3 )
		f149_arg0.breadcrumbCount:set( CoD.BreadcrumbUtility.GetAccessoryNewCountForWeapon( {
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f149_arg1, f149_arg2 ),
			_sessionMode = f149_arg2
		}, f149_arg1, f149_arg3 ) )
	end,
	updateWeaponDeathFxBreadcrumbs = function ( f150_arg0, f150_arg1, f150_arg2, f150_arg3 )
		f150_arg0.breadcrumbCount:set( CoD.BreadcrumbUtility.GetDeathFxNewCountForWeapon( {
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f150_arg1, f150_arg2 ),
			_sessionMode = f150_arg2
		}, f150_arg1, f150_arg3 ) )
	end,
	updateWeaponOpticsBreadcrumbs = function ( f151_arg0, f151_arg1, f151_arg2, f151_arg3, f151_arg4 )
		f151_arg0.breadcrumbCount:set( CoD.BreadcrumbUtility.GetOpticsNewCountForWeapon( {
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f151_arg1, f151_arg2 ),
			_itemRefHash = f151_arg3,
			_attachmentRef = f151_arg4
		}, f151_arg1 ) )
	end,
	updateWeaponCamoBreadcrumbs = function ( f152_arg0, f152_arg1, f152_arg2, f152_arg3 )
		local f152_local0 = {
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer( f152_arg1, f152_arg2 ),
			_sessionMode = f152_arg2
		}
		local f152_local1 = 0
		local f152_local2 = 0
		local f152_local3 = 0
		local f152_local4 = f152_arg0.camos
		local f152_local5 = CoD.WeaponOptionsUtility.WeaponOptionsTable
		if f152_local5 then
			local f152_local6 = f152_local5.camo_loot
		end
		f152_local5 = f152_local6 or nil
		if f152_local5 then
			local f152_local7 = f152_arg0.basiccamo
			if f152_local7 then
				f152_local3 = CoD.BreadcrumbUtility.GetCamoNewCountForWeapon( f152_local0, f152_arg1, f152_local5.lootbase, f152_arg3 ) or 0
				f152_local7.breadcrumbCount:set( f152_local3 )
			end
			local f152_local8 = f152_arg0.activecamo
			if f152_local8 then
				f152_local2 = CoD.BreadcrumbUtility.GetCamoNewCountForWeapon( f152_local0, f152_arg1, f152_local5.active, f152_arg3 ) or 0
				f152_local8.breadcrumbCount:set( f152_local2 )
			end
			f152_local1 = (f152_local3 or 0) + (f152_local2 or 0)
		end
		f152_local4.breadcrumbCount:set( f152_local1 )
	end
} )
