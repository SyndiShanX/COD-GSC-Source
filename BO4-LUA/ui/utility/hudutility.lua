CoD.HUDUtility = {}
CoD.HUDUtility.MaxObjectiveFlagOverrides = 5
CoD.HUDUtility.SUPPLY_DROP_CRATE_STATE_NONE = 0
CoD.HUDUtility.SUPPLY_DROP_CRATE_STATE_CAPTURE = 1
CoD.HUDUtility.SUPPLY_DROP_CRATE_STATE_HACK = 2
CoD.HUDUtility.SUPPLY_DROP_CRATE_STATE_DISARM = 3
CoD.HUDUtility.BATTERY_STATE_HOME = 0
CoD.HUDUtility.BATTERY_STATE_DELIVERED = 1
CoD.HUDUtility.BATTERY_STATE_CARRIED = 2
CoD.HUDUtility.BATTERY_STATE_AWAY = 3
CoD.HUDUtility.BATTERY_STATE_ATTACKED = 4
CoD.HUDUtility.GagdetHintIndex = LuaEnum.createEnum("GADGET_HINT_INDEX_NONE", "GADGET_HINT_INDEX_BATTLESHIELD", "GADGET_HINT_INDEX_RADIATION_FIELD", "GADGET_HINT_INDEX_IR_STROBE_THROW", "GADGET_HINT_INDEX_SENTRY_TURRET_DEPLOY", "GADGET_HINT_INDEX_HAWK", "GADGET_HINT_INDEX_BLADE", "GADGET_HINT_INDEX_BLADE_PROJECTILE", "GADGET_HINT_INDEX_RADIATION_FIELD_PRESS", "GADGET_HINT_INDEX_BATTLESHIELD_PRESS", "GADGET_HINT_INDEX_BATTLESHIELD_TOGGLE")
CoD.HUDUtility.SpecialistWeaponHints = {
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_NONE] = 0x0,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BATTLESHIELD] = 0xA4B259D73C66D4A,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BATTLESHIELD_PRESS] = 0x898E3EB1FCC7D86,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BATTLESHIELD_TOGGLE] = 0x89E067F1A8B2F83,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_RADIATION_FIELD] = 0xB9271B74C9E78D1,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_RADIATION_FIELD_PRESS] = 0xEDF1A87591E1A19,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_IR_STROBE_THROW] = 0xAC2D0906A020021,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_SENTRY_TURRET_DEPLOY] = 0x714FE17B9D7DFF4,
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_HAWK] = 0xDDD779F341E9E3F,
}
CoD.HUDUtility.SpecialistWeaponHintsLower = {
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BLADE] = {
		0xD5F40862A6547E9,
		0x71A522E7769CFCA,
	},
	[CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BLADE_PROJECTILE] = {
		0xD491CB6B92E42D7,
	},
}
CoD.HUDUtility.MinimapMode = {
	MODE_FIXED = 0,
	MODE_ROTATING = 1,
}
CoD.HUDUtility.GameStatusMode = {
	MODE_SHOW_SCORES = 0,
	MODE_SHOW_MAP = 1,
	MODE_SHOW_INVENTORY = 2,
}
CoD.HUDUtility.MAX_WOUNDS = 4
CoD.HUDUtility.PositionDraftSelfPosition = 1
CoD.HUDUtility.GetCachedObjective = function(f1_arg0)
	if f1_arg0 == nil then
		return nil
	elseif nil == CoD.HUDUtility.ObjectivesTable then
		CoD.HUDUtility.ObjectivesTable = {}
	end
	if CoD.HUDUtility.ObjectivesTable[f1_arg0] ~= nil then
		return CoD.HUDUtility.ObjectivesTable[f1_arg0]
	end
	local f1_local0 = Engine[0xCB2605C28DDB2CA](f1_arg0)
	CoD.HUDUtility.ObjectivesTable[f1_arg0] = f1_local0
	return f1_local0
end
CoD.HUDUtility.GetObjectiveAndUpdateCache = function(f2_arg0)
	if f2_arg0 ~= nil then
		CoD.HUDUtility.ObjectivesTable[f2_arg0] = nil
	end
	return CoD.HUDUtility.GetCachedObjective(f2_arg0)
end
CoD.HUDUtility.ObjectiveHasAnyTextFlagOverrides = function(f3_arg0)
	for f3_local0 = 1, CoD.HUDUtility.MaxObjectiveFlagOverrides, 1 do
		local f3_local3 = 0x48B9564BD522390 .. f3_local0
		if f3_arg0[f3_local3] or f3_arg0[f3_local3 .. "Friendly"] or f3_arg0[f3_local3 .. "Enemy"] then
			return true
		end
	end
	return false
end
CoD.HUDUtility.ObjectiveHasAnyImageFlagOverrides = function(f4_arg0)
	for f4_local0 = 1, CoD.HUDUtility.MaxObjectiveFlagOverrides, 1 do
		if f4_arg0[0x3485B4C6E6D7631 .. f4_local0] then
			return true
		end
	end
end
CoD.HUDUtility.ShouldSwapObjectiveTeams = function(f5_arg0, f5_arg1, f5_arg2)
	return f5_arg1[0x60B9EF849E6E166 .. Engine[0x12267460B50F00A](f5_arg0, f5_arg2)] == 1
end
CoD.HUDUtility.GetObjectiveColor = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local f6_local0 = "White"
	local f6_local1 = Engine[0x4C77EAF5F088DC3](f6_arg0, f6_arg2)
	local f6_local2 = Engine[0x2C6B07FD023877B](f6_arg0, Engine[0x869E84B826141D2](f6_arg0))
	local f6_local3 = Engine[0x532E31F2015143B](f6_arg0, f6_arg2, f6_local2)
	local f6_local4 = Engine[0x3E1BD98D6F60CC3](f6_arg0, f6_arg2, f6_local2)
	local f6_local5
	if f6_local1 ~= Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] and f6_local1 ~= Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] then
		f6_local5 = false
	else
		f6_local5 = true
	end
	local f6_local6 = f6_local1 == f6_local2
	local f6_local7 = Engine[0x12267460B50F00A](f6_arg0, f6_arg2)
	local f6_local8 = f6_arg1[0x95F9D317A2A29F2] == 1
	local f6_local9 = f6_arg1[0x10D4E971D1595D8] == 1
	local f6_local10 = f6_arg1[0xD169798AE315F87] == 1
	local f6_local11 = f6_arg1[0xA9F33959ED866DA] == 1
	local f6_local12 = f6_arg1[0x7618987067BD185] == 1
	if f6_arg3 and f6_arg1[0x5783D4CCECA51AF] == 1 then
		f6_local8 = f6_arg1[0x494C4BE1D7C3187] == 1
		f6_local9 = f6_arg1[0xEF11E154A54D0FF] == 1
		f6_local10 = f6_arg1[0x30BC092997D59F8] == 1
		f6_local11 = f6_arg1[0xBB039ADE0A4204F] == 1
		f6_local12 = f6_arg1[0x6C28A4687B3549E] == 1
	end
	if f6_local6 and f6_local8 then
		f6_local0 = CoD.TeamUtility.GetColorSetNameFriendlyColor(f6_arg0, CoD.HUDUtility.WaypointGetTeam(f6_arg0, f6_arg2))
	elseif not f6_local5 and f6_local8 then
		f6_local0 = CoD.TeamUtility.GetColorSetNameEnemyColor(f6_arg0, CoD.HUDUtility.WaypointGetTeam(f6_arg0, f6_arg2))
	elseif not (not f6_arg3 or f6_arg1[0x2AABD602E3377AE] ~= 1) or f6_arg1[0xAA62D0A685E1935] == 1 then
		f6_local0 = CoD.WZUtility.TeamPlayerColorNameForClientNum(f6_arg0, Engine[0xC43D7E71B1CA70B](f6_arg0, f6_arg2))
	end
	if f6_local3 and f6_local4 and f6_local9 then
		f6_local0 = "White"
	end
	if not f6_local3 and not f6_local4 and f6_local12 then
		f6_local0 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f6_arg0, "PlayerYellow")
	end
	if f6_local7 == 0 and f6_local11 then
		f6_local0 = "White"
	end
	if f6_local3 and f6_local4 and f6_local10 then
		f6_local0 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f6_arg0, "EnemyOrange")
	end
	return f6_local0
end
CoD.HUDUtility.ObjectiveUpdated = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5, f7_arg6)
	local f7_local0 = f7_arg2.waypoint_image or 0x7615068F50B3D66
	local f7_local1 = f7_arg2[0x5E9D3AC02630A17] or 0x7615068F50B3D66
	local f7_local2 = f7_arg2[0x5E9D4AC02630BCA] or 0x7615068F50B3D66
	local f7_local3 = f7_arg2.waypoint_text or ""
	local f7_local4 = f7_arg2[0xE3FD1464311AFA1] or 0x7615068F50B3D66
	local f7_local5 = Engine[0x4C77EAF5F088DC3](f7_arg1, f7_arg6)
	local f7_local6 = Engine[0x869E84B826141D2](f7_arg1)
	local f7_local7 = Engine[0x2C6B07FD023877B](f7_arg1, f7_local6)
	local f7_local8 = Engine[0x1DE3FFB9566D7E7](f7_arg1, f7_arg6, f7_local6)
	local f7_local9 = Engine[0x532E31F2015143B](f7_arg1, f7_arg6, f7_local7)
	local f7_local10 = Engine[0x3E1BD98D6F60CC3](f7_arg1, f7_arg6, f7_local7)
	local f7_local11
	if f7_local5 ~= Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] and f7_local5 ~= Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] then
		f7_local11 = false
	else
		f7_local11 = true
	end
	local f7_local12 = f7_local5 == f7_local7
	local f7_local13 = Engine[0x12267460B50F00A](f7_arg1, f7_arg6)
	local f7_local14 = f7_arg3:create("gamemodeFlags")
	f7_local14:set(f7_local13)
	if not f7_local11 and (not (f7_local13 ~= 1 or f7_arg2[0xCA076E59350E6D5] ~= 1) or f7_local13 == 2 and f7_arg2[0xCA073E59350E1BC] == 1) then
		f7_local12 = not f7_local12
	end
	if f7_local11 then
		f7_local3 = f7_arg2[0x670E71E3702DEF9] or f7_local3
		f7_local0 = f7_arg2[0xB1425CEED5941DF] or f7_local0
		f7_local4 = f7_arg2[0x1F7C7371625DBE8] or f7_local4
		if f7_local9 and f7_local10 then
			f7_local3 = f7_arg2[0x41D181A50A73ED6] or f7_local3
			f7_local0 = f7_arg2[0x1C5D52A12A311B4] or f7_local0
		elseif f7_local8 then
			f7_local3 = f7_arg2[0xE93A7E28DB7698C] or f7_local3
			f7_local0 = f7_arg2[0x52FD46B862849F6] or f7_local0
		elseif f7_local9 then
			f7_local3 = f7_arg2[0x5AA6420570D06B2] or f7_local3
			f7_local0 = f7_arg2[0xC7E0DB39FC83714] or f7_local0
		elseif f7_local10 then
			f7_local3 = f7_arg2[0x9516156EA8DDC19] or f7_local3
			f7_local0 = f7_arg2[0xED0B2C5D2C15BBF] or f7_local0
		end
	elseif f7_local12 then
		f7_local3 = f7_arg2[0xFBF2480290A211A] or f7_local3
		f7_local0 = f7_arg2[0x927B79ED954A278] or f7_local0
		f7_local4 = f7_arg2[0xA464F3B561F16A7] or f7_local4
		if f7_local9 and f7_local10 then
			f7_local3 = f7_arg2[0xD99BB37B7E02B14] or f7_local3
			f7_local0 = f7_arg2[0xC4D4A470DABF402] or f7_local0
		elseif f7_local8 then
			f7_local3 = f7_arg2[0x20FA9AFC3AFA6CA] or f7_local3
			f7_local0 = f7_arg2[0x4E19935A50A81B4] or f7_local0
		elseif f7_local9 then
			f7_local3 = f7_arg2[0xBBDA2989D794088] or f7_local3
			f7_local0 = f7_arg2[0xEC91C9B076572E2] or f7_local0
		elseif f7_local10 then
			f7_local3 = f7_arg2[0x6C9ADBC59924111] or f7_local3
			f7_local0 = f7_arg2[0xFFC88A480A0B08F] or f7_local0
		end
	else
		f7_local3 = f7_arg2[0x1421179D8B525CB] or f7_local3
		f7_local0 = f7_arg2[0x2542DACDD0BA59D] or f7_local0
		f7_local4 = f7_arg2[0x207CD530AA845F4] or f7_local4
		if f7_local9 and f7_local10 then
			f7_local3 = f7_arg2[0xC78FB07AA3581C5] or f7_local3
			f7_local0 = f7_arg2[0xFCCEF8F202DDD0F] or f7_local0
		elseif f7_local8 then
			f7_local3 = f7_arg2[0xC8F1836F8323A77] or f7_local3
			f7_local0 = f7_arg2[0x3AA40A85083C1E5] or f7_local0
		elseif f7_local9 then
			f7_local3 = f7_arg2[0x49BAAE25FDFCF19] or f7_local3
			f7_local0 = f7_arg2[0x1E8B60EB296076F] or f7_local0
		elseif f7_local10 then
			f7_local3 = f7_arg2[0x2EBB71B0AB9BE32] or f7_local3
			f7_local0 = f7_arg2[0x3E01DEEF259DCAC] or f7_local0
		end
	end
	if CoD.HUDUtility.ObjectiveHasAnyTextFlagOverrides(f7_arg2) then
		f7_local14 = 0x48B9564BD522390 .. f7_local13
		f7_local3 = f7_arg2[f7_local14] or f7_local3
		if f7_local12 then
			f7_local3 = f7_arg2[f7_local14 .. "Friendly"] or f7_local3
		elseif not f7_local11 then
			f7_local3 = f7_arg2[f7_local14 .. "Enemy"] or f7_local3
		end
	end
	if f7_arg2[0xA8F7A3EDE89CCD7] and CoD.CodCasterUtility.CodCasterIsInAerialCam(f7_arg1) then
		f7_local3 = 0x0
	end
	if CoD.HUDUtility.ObjectiveHasAnyImageFlagOverrides(f7_arg2) then
		f7_local0 = f7_arg2[0x3485B4C6E6D7631 .. f7_local13] or f7_local0
	end
	f7_local14 = CoD.HUDUtility.GetObjectiveColor(f7_arg1, f7_arg2, f7_arg6, false)
	f7_arg3.icon:set(f7_local0)
	f7_arg3.waypointBacking01:set(f7_local1)
	f7_arg3.waypointBacking02:set(f7_local2)
	f7_arg3.text:set(f7_local3)
	f7_arg3.objectiveWidgetIcon:set(f7_local4)
	f7_arg3.color:set(f7_local14)
	local f7_local15 = f7_arg4[f7_arg6]
	if f7_local15 then
		CoD.HUDUtility.WaypointUpdateIconAndText(f7_local15, f7_arg1, f7_local13)
	end
	local f7_local16 = DataSources.HUDItems.getModel(f7_arg1)
	f7_local16 = f7_local16.heldObjectiveId
	if f7_arg3.entNum:get() == Engine[0x761955642304848](f7_arg1) then
		if not f7_local16:set(f7_arg6) then
			f7_local16:forceNotifySubscriptions()
		end
	elseif f7_local16:get() == f7_arg6 then
		f7_local16:set(-1)
	end
end
CoD.HUDUtility.InitWaypointHandlers = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	local f8_local0 = f8_arg1[f8_arg3]
	local f8_local1
	if f8_arg4 ~= "" then
		f8_local1 = LUI.getTableFromPath(f8_arg4, f8_arg1)
		if not f8_local1 then
		else
			f8_arg1.objectiveData = {}
			if CoD.HUDUtility.ObjectivesTable == nil then
				CoD.HUDUtility.ObjectivesTable = {}
			end
			local f8_local2 = Engine[0x4DF5CFBC1771947](f8_arg2)
			if not f8_arg1.__hasColorBlindUpdate then
				f8_arg1:subscribeToModel(f8_local2.profile.colorBlindMode, function(model)
					for f9_local4, f9_local5 in pairs(f8_arg1.objectiveData) do
						local f9_local6 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f8_arg2, f9_local4))
						if f9_local6 ~= nil then
							local f9_local3 = Engine[0x40E824FE270E174](f8_local2, "objective" .. f9_local4)
							if f9_local3 and f9_local3.color then
								f9_local3.color:set(CoD.HUDUtility.GetObjectiveColor(f8_arg2, f9_local6, f9_local4, false))
							end
						end
					end
				end, false)
				f8_arg1.__hasColorBlindUpdate = true
			end
			local f8_local3 = function(f10_arg0, f10_arg1)
				local f10_local0 = Engine[0xBE25B67EDE3D9F9](f10_arg0, f10_arg1)
				local f10_local1 = CoD.HUDUtility.GetCachedObjective(f10_local0)
				if f10_local1 == nil then
					return
				elseif not f8_arg1.objectiveData[f10_arg1] then
					f8_arg1.objectiveData[f10_arg1] = {
						state = Enum[0xA2C16942D15B316][0x3D8C0161CB729FB],
						hasBaseSubscriptions = false,
					}
				end
				local f10_local2 = function(f11_arg0)
					local f11_local0
					if f11_arg0 ~= Enum[0xA2C16942D15B316][0x54563D60375E060] and f11_arg0 ~= Enum[0xA2C16942D15B316][0x59FDE7D12BCC045] then
						f11_local0 = false
					else
						f11_local0 = true
					end
					return f11_local0
				end
				local f10_local3 = function(f12_arg0)
					return f12_arg0 == Enum[0xA2C16942D15B316][0xDF225299252F5E]
				end
				local f10_local4 = f8_arg1.objectiveData[f10_arg1]
				local f10_local5 = Engine[0x4D9B99D8B1D5617](f10_arg0, f10_arg1)
				f10_local4.state = f10_local5
				local f10_local6 = function(f13_arg0)
					if f13_arg0 ~= "None" and f13_arg0 ~= "" then
						return CoD[f13_arg0]
					else
						return nil
					end
				end
				f10_local6 = f10_local6(f10_local1[0x7F0119E3154625])
				if not f10_local6 then
					return
				end
				local f10_local7 = Engine[0x40E824FE270E174](f8_local2, "objective" .. f10_arg1)
				local f10_local8 = nil
				if f10_local7 then
					f10_local7:set(f10_local0)
					f10_local8 = f10_local7.state
					f10_local7:create("clamped")
					f10_local7:create("isOffscreen")
					f10_local7:create("direction")
					local f10_local9 = f10_local7:create("text")
					f10_local9:set(0x0)
					f10_local7:create("distanceText")
					f10_local7:create("progress")
					f10_local7:create("icon")
					f10_local7:create("waypointBacking01")
					f10_local7:create("waypointBacking02")
					f10_local7:create("objectiveWidgetIcon")
					f10_local9 = f10_local7:create("id")
					f10_local9:set(f10_local0)
					f10_local9 = f10_local7:create("objId")
					if not f10_local9:set(f10_arg1) then
						f10_local7.objId:forceNotifySubscriptions()
					end
					f10_local7:create("color")
					f10_local7:create("team")
					f10_local9 = f10_local7:create("isFarAway")
					f10_local9:set(false)
					f10_local9 = f10_local7:create("isShoutCasterAerialCam")
					f10_local9:set(false)
					f10_local7:create("clientUseMask")
					f10_local7:create("teamMask")
					f10_local7:create("gamemodeFlags")
					f10_local7:create("waypointUpdate")
					f10_local9 = f10_local7:create("showWithAmmoState")
					f10_local9:set(0)
					f10_local9 = f10_local7:create("hasLowAmmoState")
					f10_local9:set(f10_local1.has_low_ammo_state or false)
					if f10_local1[0x758ECC3699C3FDC] == 1 then
						f10_local9 = f10_local7:create("radialTimer")
						if f10_local1[0x46D19887AADFEB7] == 1 then
							local f10_local10 = f10_local9
							local f10_local11 = f10_local9.set
							local f10_local12 = Engine[0x8DF2E5447F384B9]()
							f10_local11(f10_local10, f10_local12.bombTimer.bomb1)
						else
							local f10_local10 = f10_local9
							local f10_local11 = f10_local9.set
							local f10_local12 = Engine[0x8DF2E5447F384B9]()
							f10_local11(f10_local10, f10_local12.bombTimer.bomb0)
						end
					end
					if not f10_local4.hasBaseSubscriptions then
						f10_local4.hasBaseSubscriptions = true
						f8_arg1:subscribeToModel(f10_local7.team, function(model)
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, CoD.HUDUtility.GetCachedObjective(f10_local7:get()), f10_local7, f8_local0, f8_local1, f10_arg1)
						end, false)
						f8_arg1:subscribeToModel(f10_local7.clientUseMask, function(model)
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, CoD.HUDUtility.GetCachedObjective(f10_local7:get()), f10_local7, f8_local0, f8_local1, f10_arg1)
						end, false)
						f8_arg1:subscribeToModel(f10_local7.updateTime, function(model)
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, CoD.HUDUtility.GetCachedObjective(f10_local7:get()), f10_local7, f8_local0, f8_local1, f10_arg1)
						end, false)
						f8_arg1:subscribeToModel(f10_local7:create("forceUpdate"), function(model)
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, CoD.HUDUtility.GetCachedObjective(f10_local7:get()), f10_local7, f8_local0, f8_local1, f10_arg1)
						end, false)
						f8_arg1:subscribeToModel(f10_local7.entNum, function(model)
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, CoD.HUDUtility.GetCachedObjective(f10_local7:get()), f10_local7, f8_local0, f8_local1, f10_arg1)
						end, false)
						f8_arg1:subscribeToModel(f10_local7.isFarAway, function(model)
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, CoD.HUDUtility.GetCachedObjective(f10_local7:get()), f10_local7, f8_local0, f8_local1, f10_arg1)
						end, false)
						f8_arg1:subscribeToModel(f10_local7.isShoutCasterAerialCam, function(model)
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, CoD.HUDUtility.GetCachedObjective(f10_local7:get()), f10_local7, f8_local0, f8_local1, f10_arg1)
						end, false)
					end
				end
				CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f10_arg0, f10_local1, f10_local7, f8_local0, f8_local1, f10_arg1)
				if (f10_local2(f10_local5) or f10_local3(f10_local5)) and f10_local6 then
					if true == Dvar[0x650576ADE369039]:get() then
						local f10_local9 = 0
						local f10_local11 = f8_local0:getFirstChild()
						while f10_local11 ~= nil do
							f10_local9 = f10_local9 + 1
							f10_local11 = f10_local11:getNextSibling()
						end
						DebugPrint("Waypoint " .. f10_arg1 .. ": " .. f10_local9 .. " waypoints active")
					end
					local f10_local9 = f8_local0[f10_arg1]
					if f10_local9 ~= nil and f10_local9.objectiveWidget ~= f10_local1[0x7F0119E3154625] then
						f10_local8:set(Enum[0xA2C16942D15B316][0xDF225299252F5E])
						f10_local9 = nil
					end
					if f10_local9 == nil then
						Engine[0x6E447857BE70BC1]("Create Waypoint")
						f10_local9 = f10_local6.new(f8_arg1, f10_arg0, 0, 0, 0, f10_local6.__defaultWidth, 0, 0, 0, f10_local6.__defaultHeight)
						f10_local9.objectiveWidget = f10_local1[0x7F0119E3154625]
						f10_local9.objective = f10_local1
						CoD.HUDUtility.SetupWaypoint(f10_local9, f10_arg0, f10_arg1)
						f10_local9:setModel(f10_local7, f10_arg0)
						f8_local0:addElement(f10_local9)
						f8_arg1:sendInitializationEvents(f10_arg0, f10_local9)
						f8_local0[f10_arg1] = f10_local9
						Engine[0x66E2713AD003565]()
						f10_local9:subscribeToModel(f10_local8, function(model)
							if not f10_local2(Engine[0x614D394F6F9A18D](model)) then
								f10_local9:close()
								f8_local0[f10_arg1] = nil
								Engine[0x6A489878620F3BC](model)
							end
						end)
						if f8_local0[f10_arg1] == nil then
							return
						end
						local f10_local11 = function()
							local f22_local0 = Engine[0x2C6B07FD023877B](f10_arg0, Engine[0x869E84B826141D2](f10_arg0))
							CoD.HUDUtility.WaypointUpdateSnapToCenter(f10_local9, f10_arg0, Engine[0x532E31F2015143B](f10_arg0, f10_local9.objId, f22_local0), Engine[0x3E1BD98D6F60CC3](f10_arg0, f10_local9.objId, f22_local0))
						end
						f10_local9:subscribeToModel(f10_local7.clientUseMask, function(model)
							CoD.HUDUtility.WaypointUpdate(f10_local9, f10_arg0)
						end, false)
						f10_local9:subscribeToModel(f10_local7.team, function(model)
							CoD.HUDUtility.WaypointUpdate(f10_local9, f10_arg0)
						end, false)
						f10_local9:subscribeToModel(f10_local7.waypointUpdate, function(model)
							CoD.HUDUtility.WaypointUpdate(f10_local9, f10_arg0)
						end, false)
						if f10_local1.has_low_ammo_state then
							f10_local9:subscribeToGlobalModel(f10_arg0, "CurrentWeapon", "totalAmmoLow", function(model)
								CoD.HUDUtility.WaypointUpdate(f10_local9, f10_arg0)
							end, true)
						end
						CoD.HUDUtility.WaypointUpdate(f10_local9, f10_arg0)
						if f10_local1[0x44AC803636BB2F2] == 1 then
							f10_local9:linkToElementModel(f10_local9, "isOffscreen", true, function(model)
								f10_local11(model)
							end, true)
						end
						f10_local9:subscribeToModel(f8_local2.deadSpectator.playerIndex, f10_local11, false)
						f10_local9:subscribeToModel(f8_local2.interactivePrompt.activeObjectiveID, f10_local11, false)
						f10_local11()
						CoD.HUDUtility.WaypointUpdateIconAndText(f10_local9, f10_arg0, Engine[0x12267460B50F00A](f10_arg0, f10_local9.objId))
						f8_arg1:sendInitializationEvents(f10_arg0, f10_local9)
					else
						f10_local9.objective = f10_local1
						CoD.HUDUtility.SetupWaypoint(f10_local9, f10_arg0, f10_arg1)
					end
				end
				return true
			end
			f8_arg1:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f8_arg2), "newObjective"), function(model)
				f8_local3(f8_arg2, Engine[0x614D394F6F9A18D](model))
			end, false)
			if LUI.DEV then
				f8_arg1:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f8_arg2), "objectives.forceUpdate"), function(model)
					for f29_local5, f29_local6 in pairs(f8_arg1.objectiveData) do
						local f29_local7 = Engine[0xBE25B67EDE3D9F9](f8_arg2, f29_local5)
						if f29_local7 ~= nil then
							local f29_local3 = CoD.HUDUtility.GetObjectiveAndUpdateCache(f29_local7)
							if f8_local0[f29_local5] then
								f8_local0[f29_local5].objective = f29_local3
								CoD.HUDUtility.SetupWaypoint(f8_local0[f29_local5], f8_arg2, f29_local5)
								CoD.HUDUtility.WaypointUpdate(f8_local0[f29_local5], f8_arg2)
							end
							local f29_local4 = Engine[0x4DF5CFBC1771947](f8_arg2)
							f29_local4 = f29_local4["objective" .. f29_local5]
							CoD.HUDUtility.ObjectiveUpdated(f8_arg1, f8_arg2, f29_local3, f29_local4, f8_local0, f8_local1, f29_local5)
							f29_local4.id:forceNotifySubscriptions()
							if f8_local0[f29_local5] then
								f8_arg0:sendInitializationEvents(f8_arg2, f8_local0[f29_local5])
							end
							if f8_local1 and f8_local1[f29_local5] then
								f8_arg0:sendInitializationEvents(f8_arg2, f8_local1[f29_local5])
							end
						end
					end
				end)
			end
			Engine[0xD01519E8C5001FA](f8_arg2)
		end
	end
	f8_local1 = nil
end
CoD.HUDUtility.UpdateBallModels = function(f30_arg0, f30_arg1)
	local f30_local0 = Engine[0x4C77EAF5F088DC3](f30_arg0, f30_arg1)
	local f30_local1 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f30_arg0), "ballGametype")
	local f30_local2 = Engine[0xF9F1239CFD921FE](0x3822BF6666B7F1C)
	if f30_local0 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or f30_local0 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		f30_local2 = Engine[0xA457DFCEF7A7C9D](f30_arg0, Engine[0x626F871BFD9CF11](f30_arg0, f30_arg1))
	elseif Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f30_local1, "ballAway")) == 1 then
		f30_local2 = Engine[0xF9F1239CFD921FE](0xC376BAE65A55609)
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f30_local1, "ballStatusText"), f30_local2)
	if CoD.IsShoutcaster(f30_arg0) then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f30_local1, "ballHeldByFriendly"), f30_local0 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB])
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f30_local1, "ballHeldByEnemy"), f30_local0 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68])
	else
		local f30_local3 = CoD.TeamUtility.GetTeamID(f30_arg0)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f30_local1, "ballHeldByFriendly"), f30_local0 == f30_local3)
		local f30_local4 = Engine[0x83C9B5DE1D9371]
		local f30_local5 = Engine[0xA798E4552F5E872](f30_local1, "ballHeldByEnemy")
		local f30_local6
		if f30_local0 == f30_local3 or f30_local0 == Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] then
			f30_local6 = false
		else
			f30_local6 = true
		end
		f30_local4(f30_local5, f30_local6)
	end
end
CoD.HUDUtility.IsWaypointOwnedByMyTeam = function(f31_arg0, f31_arg1)
	if f31_arg0.objId and Engine[0x2C6B07FD023877B](f31_arg1, Engine[0x869E84B826141D2](f31_arg1)) == Engine[0x4C77EAF5F088DC3](f31_arg1, f31_arg0.objId) then
		return true
	else
		return false
	end
end
CoD.HUDUtility.IsPlayerUsingWaypoint = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
	if Engine[0xCB26E7BFE805CB5](f32_arg1) == true then
		return false
	elseif Engine[0x195741391F0D9B](f32_arg1) == true then
		return false
	elseif Engine[0xD8EF712B5613982](f32_arg1) == true then
		return false
	end
	local f32_local0 = Engine[0x869E84B826141D2](f32_arg1)
	local f32_local1 = f32_arg3 and f32_arg2 and f32_arg0.objective[0x60C69F351270D2] == 1
	if CoD.HUDUtility.IsWaypointOwnedByMyTeam(f32_arg0, f32_arg1) then
		if f32_arg0.objective[0xF547E434D3D166A] ~= 1 and not f32_local1 then
			return false
		end
	elseif f32_arg0.objective[0x10288E76F797F20] ~= 1 and not f32_local1 then
		return false
	end
	return Engine[0x1DE3FFB9566D7E7](f32_arg1, f32_arg0.objId, f32_local0)
end
CoD.HUDUtility.SetupWaypoint = function(f33_arg0, f33_arg1, f33_arg2)
	if f33_arg2 then
		local f33_local0 = f33_arg0.objective
		local f33_local1 = Engine[0x626F871BFD9CF11](f33_arg1, f33_arg2)
		f33_arg0.objId = f33_arg2
		f33_arg0.anyGameModeFlagSpecificText = CoD.HUDUtility.ObjectiveHasAnyTextFlagOverrides(f33_local0)
		f33_arg0:setupWaypointContainer(f33_arg0.objId)
		f33_arg0:setEntityContainerClamp(f33_local0.waypoint_clamp == true)
		if f33_local0[0xFC9D3C025110D8D] == 1 and Engine[0xDBC2AD5002B261B](0xC5C31373530028D) == 2 then
			f33_arg0.ping = true
		end
		local f33_local2 = Engine[0x21412B8F299CBEB]
		local f33_local3 = f33_arg1
		local f33_local4 = f33_arg2
		local f33_local5 = Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C]
		local f33_local6 = f33_arg0.ping
		if not f33_local6 then
			f33_local6 = false
		end
		f33_local2(f33_local3, f33_local4, f33_local5, f33_local6)
		f33_local2 = f33_local0.waypoint_x_offset
		if not f33_local2 then
			f33_local2 = 0
		end
		f33_arg0.xOffset = f33_local2
		f33_local2 = f33_local0.waypoint_y_offset
		if not f33_local2 then
			f33_local2 = 0
		end
		f33_arg0.yOffset = f33_local2
		f33_local2 = f33_local0.waypoint_z_offset
		if not f33_local2 then
			f33_local2 = 0
		end
		f33_arg0.zOffset = f33_local2
		if f33_local0.id == "warzone" then
			f33_arg0.progressMeterContested:setShaderVector(4, 3, 0.07, 0, 0)
			f33_arg0.progressMeter:setShaderVector(4, 3, 0.07, 0, 0)
		end
	end
end
CoD.HUDUtility.GetButtonPromptText = function(f34_arg0, f34_arg1)
	local f34_local0 = GetObjectiveXHashProperty(0x1BB6EE6EB270DC8, f34_arg0)
	local f34_local1
	if f34_arg1 ~= 0 then
		f34_local1 = GetObjectiveXHashProperty(0xF05079AB07DE82A .. f34_arg1, f34_arg0)
		if not f34_local1 then
		else
			if f34_local1 and f34_local1 ~= "" then
				f34_local0 = f34_local1 or f34_local0
			end
			return f34_local0
		end
	end
	f34_local1 = nil
end
CoD.HUDUtility.UseHintTextForActiveButtonPromptText = function(f35_arg0, f35_arg1)
	local f35_local0 = Engine[0x4DF5CFBC1771947](f35_arg1)
	local f35_local1 = function(f36_arg0, f36_arg1)
		local f36_local0 = CoD.HUDUtility.GetButtonPromptText(f35_arg0.objective.id, f36_arg1)
		if f36_local0 and f35_arg0.objId == f36_arg0 then
			local f36_local1 = Engine[0x40E824FE270E174](f35_local0, "hudItems")
			if CoD.WaypointUtility.ShouldHideWaypoint(f35_arg0, f35_arg1) then
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f36_local1, "showCursorHint"), false)
			else
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f36_local1, "showCursorHint"), true)
				local f36_local2 = Engine[0xDFD7EFA83DD8C75](f35_arg1, "+activate")
				if f36_local2 then
					f36_local0 = Engine[0xED84C33EC5F01EA](f36_local0, f36_local2)
				end
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f36_local1, "cursorHintText"), f36_local0)
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f36_local1, "cursorHintImage"), "blacktransparent")
			end
		end
	end
	local f35_local2 = f35_arg0
	local f35_local3 = f35_arg0.subscribeToModel
	local f35_local4 = f35_local0:create("interactivePrompt")
	f35_local3(f35_local2, f35_local4:create("activeObjectiveID"), function(f37_arg0)
		local f37_local0 = f35_arg0:getModel()
		if f37_local0 then
			f35_local1(f37_arg0:get(), f37_local0.gamemodeFlags:get())
		end
	end)
	f35_arg0:linkToElementModel(f35_arg0, "gamemodeFlags", true, function(model)
		f35_local1(f35_local0.interactivePrompt.activeObjectiveID:get(), model:get())
	end, true)
	LUI.OverrideFunction_CallOriginalFirst(f35_arg0, "setState", function(element, controller, f39_arg2)
		local f39_local0 = f35_arg0:getModel()
		if f39_local0 then
			f35_local1(f35_local0.interactivePrompt.activeObjectiveID:get(), f39_local0.gamemodeFlags:get())
		end
	end)
end
CoD.HUDUtility.Weapon3DHintStateFlags = {
	EQUIPS = 0,
	SWAPS = 1,
	INVENTORY_FULL = 2,
	STACKS = 3,
	IGNORES_INVENTORY = 4,
	ALSO_ALLOW_PICKUP = 5,
	AMMO_FULL = 6,
	MAX_PAINT_CANS = 7,
	ALSO_ALLOW_PICKUP_EQUIP = 8,
	ALSO_ALLOW_WEAPON_ATTACHMENT_SWAP = 9,
	ALSO_ALLOW_SWAP = 10,
}
CoD.HUDUtility.Disable3DWeaponHintButton = function(f40_arg0)
	if IsDemoPlaying() then
		return true
	elseif IsWarzone() then
		local f40_local0 = DataSources.HUDItems.getModel(f40_arg0)
		f40_local0 = f40_local0.weapon3dHintState:get() or 0
		local f40_local1 = CoD.BitUtility.IsBitSet(f40_local0, CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL)
		if not f40_local1 then
			f40_local1 = CoD.BitUtility.IsBitSet(f40_local0, CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL)
			if not f40_local1 then
				f40_local1 = CoD.BitUtility.IsBitSet(f40_local0, CoD.HUDUtility.Weapon3DHintStateFlags.MAX_PAINT_CANS)
			end
		end
		return f40_local1
	else
		return false
	end
end
CoD.HUDUtility.Disable3DWeaponHintButtonWithSwap = function(f41_arg0)
	if IsDemoPlaying() then
		return true
	elseif IsWarzone() then
		local f41_local0 = DataSources.HUDItems.getModel(f41_arg0)
		f41_local0 = f41_local0.weapon3dHintState:get() or 0
		if CoD.BitUtility.IsBitSet(f41_local0, CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) or CoD.BitUtility.IsBitSet(f41_local0, CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) or CoD.BitUtility.IsBitSet(f41_local0, CoD.HUDUtility.Weapon3DHintStateFlags.MAX_PAINT_CANS) then
			return CoD.BitUtility.IsBitSet(f41_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_SWAP)
		end
	end
	return false
end
CoD.HUDUtility.Hide3DWeaponHintButton = function(f42_arg0)
	if IsDemoPlaying() then
		return true
	elseif IsWarzone() then
		local f42_local0 = DataSources.HUDItems.getModel(f42_arg0)
		return CoD.BitUtility.IsBitSet(f42_local0.weapon3dHintState:get() or 0, CoD.HUDUtility.Weapon3DHintStateFlags.IGNORES_INVENTORY)
	else
		return false
	end
end
CoD.HUDUtility.AllowThirdPersonSpectating = function(f43_arg0)
	if IsArenaMode() then
		return false
	elseif IsGametypeSettingsValue("disableThirdPersonSpectating", 1) then
		return false
	elseif IsSplitscreenAndInGame(f43_arg0) then
		return false
	else
		return true
	end
end
CoD.HUDUtility.Get3DWeaponHintPickupHintText = function(f44_arg0, f44_arg1)
	local f44_local0 = 0x0
	if IsWarzone() then
		local f44_local1 = DataSources.HUDItems.getModel(f44_arg0)
		f44_local1 = f44_local1.weapon3dHintState:get() or 0
		if CoD.BitUtility.IsBitSet(f44_local1, CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			f44_local0 = 0x73B147964ED740
		elseif CoD.BitUtility.IsBitSet(f44_local1, CoD.HUDUtility.Weapon3DHintStateFlags.MAX_PAINT_CANS) then
			f44_local0 = 0x4173C4EEADD4DD9
		elseif CoD.BitUtility.IsBitSet(f44_local1, CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) then
			f44_local0 = 0xA0039CF9CCD3E36
		elseif CoD.BitUtility.IsBitSet(f44_local1, CoD.HUDUtility.Weapon3DHintStateFlags.EQUIPS) then
			f44_local0 = 0x38B775D97E72F0C
		elseif CoD.BitUtility.IsBitSet(f44_local1, CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS) then
			f44_local0 = 0x25F8C30A0958A7B
		else
			f44_local0 = 0x339E923E692AD5E
		end
	end
	return f44_local0
end
CoD.HUDUtility.Get3DWeaponHintPickupHintTextWithPickUpOptions = function(f45_arg0, f45_arg1)
	local f45_local0 = 0x0
	if IsWarzone() then
		local f45_local1 = DataSources.HUDItems.getModel(f45_arg0)
		local f45_local2 = f45_local1.weapon3dHintState:get() or 0
		if CoD.BitUtility.IsBitSet(f45_local2, CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			f45_local0 = 0x73B147964ED740
		elseif CoD.BitUtility.IsBitSet(f45_local2, CoD.HUDUtility.Weapon3DHintStateFlags.MAX_PAINT_CANS) then
			f45_local0 = 0x4173C4EEADD4DD9
		elseif CoD.BitUtility.IsBitSet(f45_local2, CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) then
			f45_local0 = 0xA0039CF9CCD3E36
		elseif CoD.BitUtility.IsBitSet(f45_local2, CoD.HUDUtility.Weapon3DHintStateFlags.EQUIPS) then
			if not IsBooleanDvarSet("tabbedMultiItemPickup") and f45_local1.heroHoldProgress:get() > 0 and not CoD.WZUtility.InventoryFull(f45_arg0) and CoD.BitUtility.IsBitSet(f45_local2, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_PICKUP) then
				f45_local0 = 0x339E923E692AD5E
			else
				f45_local0 = 0x38B775D97E72F0C
			end
		elseif CoD.BitUtility.IsBitSet(f45_local2, CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS) then
			f45_local0 = 0x25F8C30A0958A7B
		else
			f45_local0 = 0x339E923E692AD5E
		end
	end
	return f45_local0
end
CoD.HUDUtility.Get3DWeaponHintAlsoPickupHintTextWithPickUpOptions = function(f46_arg0, f46_arg1)
	local f46_local0 = 0x0
	if IsWarzone() then
		local f46_local1 = DataSources.HUDItems.getModel(f46_arg0)
		local f46_local2 = f46_local1.weapon3dHintState:get() or 0
		if CoD.BitUtility.IsBitSet(f46_local2, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_PICKUP_EQUIP) then
			f46_local0 = 0x1137C693ACA6BA7
		elseif CoD.BitUtility.IsBitSet(f46_local2, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_WEAPON_ATTACHMENT_SWAP) then
			f46_local0 = 0x928DC6C23119D85
		elseif CoD.BitUtility.IsBitSet(f46_local2, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_SWAP) then
			f46_local0 = 0x25F8C30A0958A7B
		else
			f46_local0 = 0x339E923E692AD5E
		end
	end
	return f46_local0
end
CoD.HUDUtility.UpdateFocusStashModel = function(f47_arg0, f47_arg1, f47_arg2)
	local f47_local0 = DataSources.FreeCursor.getModel(f47_arg1)
	f47_local0.contextualInfo.isStashFocused:set(f47_arg2)
end
CoD.HUDUtility.SetupWeaponHintPickupHintTextKBM = function(f48_arg0, f48_arg1, f48_arg2)
	if IsWarzone() then
		local f48_local0 = function()
			local f49_local0 = 0x0
			local f49_local1 = DataSources.HUDItems.getModel(f48_arg2)
			f49_local1 = f49_local1.weapon3dHintState:get() or 0
			local f49_local2 = DataSources.FreeCursor.getModel(f48_arg2)
			local f49_local3 = f49_local2.contextualInfo.isStashFocused
			if not f49_local3 or f49_local3:get() == false then
				f49_local0 = 0x0
			elseif CoD.BitUtility.IsBitSet(f49_local1, CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
				f49_local0 = 0x73B147964ED740
			elseif CoD.BitUtility.IsBitSet(f49_local1, CoD.HUDUtility.Weapon3DHintStateFlags.MAX_PAINT_CANS) then
				f49_local0 = 0x4173C4EEADD4DD9
			elseif CoD.BitUtility.IsBitSet(f49_local1, CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) then
				f49_local0 = 0xA0039CF9CCD3E36
			else
				f49_local0 = 0x0
			end
			f49_local2.contextualInfo.pickupHintWarzone:set(f49_local0)
			f49_local2.contextualInfo.updated:forceNotifySubscriptions()
		end
		f48_arg0:subscribeToGlobalModel(f48_arg2, "HUDItems", "weapon3dHintState", f48_local0)
		f48_arg0:subscribeToGlobalModel(f48_arg2, "FreeCursor", "contextualInfo.isStashFocused", f48_local0)
	end
end
CoD.HUDUtility.ShowTriangleFullInventoryPickupPrompt = function(f50_arg0)
	if IsDemoPlaying() then
		return false
	elseif not IsWarzone() or not CoD.WZUtility.InventoryFull(f50_arg0) then
		return false
	else
		local f50_local0 = DataSources.HUDItems.getModel(f50_arg0)
		return CoD.BitUtility.IsBitSet(f50_local0.weapon3dHintState:get() or 0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_SWAP)
	end
end
CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt = function(f51_arg0)
	if IsDemoPlaying() then
		return false
	elseif not IsWarzone() then
		return false
	end
	local f51_local0 = DataSources.HUDItems.getModel(f51_arg0)
	f51_local0 = f51_local0.weapon3dHintState:get() or 0
	if CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_WEAPON_ATTACHMENT_SWAP) then
		return true
	elseif CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_SWAP) then
		return true
	elseif CoD.WZUtility.InventoryFull(f51_arg0) and not CoD.HUDUtility.ShowTriangleFullInventoryPickupPrompt(f51_arg0) then
		return false
	elseif not CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_PICKUP) and not CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_PICKUP_EQUIP) and not CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_WEAPON_ATTACHMENT_SWAP) and not CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_SWAP) then
		return false
	elseif CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.EQUIPS) or CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS) or CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_PICKUP_EQUIP) then
		local f51_local1
		if not CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_PICKUP) then
			f51_local1 = CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_PICKUP_EQUIP)
			if f51_local1 then
			else
				return f51_local1
			end
		end
		f51_local1 = not CoD.BitUtility.IsBitSet(f51_local0, CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL)
	end
	return false
end
CoD.HUDUtility.PickupPromptOpacity = function(f52_arg0, f52_arg1)
	if not IsBooleanDvarSet("tabbedMultiItemPickup") and CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(f52_arg0) and not CoD.WZUtility.InventoryFull(f52_arg0) then
		local f52_local0 = DataSources.HUDItems.getModel(f52_arg0)
		if f52_local0.heroHoldProgress:get() > 0 then
			return 0.01
		end
	end
	return 1
end
CoD.HUDUtility.WAYPOINT_CTF_PULSE_BEGIN_ALPHA = 0.8
CoD.HUDUtility.WAYPOINT_CTF_PULSE_END_ALPHA = 0.3
CoD.HUDUtility.WaypointSetCompassObjectiveIcon = function(f53_arg0, f53_arg1, f53_arg2, f53_arg3, f53_arg4, f53_arg5)
	if f53_arg3 or f53_arg4 then
		if f53_arg5 then
			if f53_arg3 then
				Engine[0xED6169DDFABF71B](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], f53_arg3, f53_arg5.r, f53_arg5.g, f53_arg5.b)
				Engine[0xED6169DDFABF71B](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A], f53_arg3, f53_arg5.r, f53_arg5.g, f53_arg5.b)
			end
			if f53_arg4 then
				Engine[0xDADAACD4057DBDB](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], f53_arg4, f53_arg5.r, f53_arg5.g, f53_arg5.b)
				Engine[0xDADAACD4057DBDB](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A], f53_arg4, f53_arg5.r, f53_arg5.g, f53_arg5.b)
			end
		else
			if f53_arg3 then
				Engine[0xED6169DDFABF71B](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], f53_arg3)
				Engine[0xED6169DDFABF71B](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A], f53_arg3)
			end
			if f53_arg4 then
				Engine[0xDADAACD4057DBDB](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], f53_arg4)
				Engine[0xDADAACD4057DBDB](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A], f53_arg4)
			end
		end
		Engine[0x8CB82F5F8D70506](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], f53_arg0.objective[0x8172B233C10D79B] == 1)
		Engine[0x8CB82F5F8D70506](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A], f53_arg0.objective[0x8172B233C10D79B] == 1)
		Engine[0xE6CE7A287806EA4](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], f53_arg0.objective[0x528BA0C66DF2DFE] == 1)
		local f53_local0 = f53_arg0.objective[0x5141E79748AB619] == 1
		Engine[0xD40DC95325722DF](f53_arg1, f53_arg0.objId, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], f53_local0)
		Engine[0xD40DC95325722DF](f53_arg1, f53_arg0.objId, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A], f53_local0)
	else
		Engine[0xB1741BF0598F4C0](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C])
		Engine[0xB1741BF0598F4C0](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A])
		Engine[0x8275F3C972C0D3A](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C])
		Engine[0x8275F3C972C0D3A](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A])
		Engine[0xE6CE7A287806EA4](f53_arg1, f53_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], false)
		Engine[0xD40DC95325722DF](f53_arg1, f53_arg0.objId, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C], false)
		Engine[0xD40DC95325722DF](f53_arg1, f53_arg0.objId, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A], false)
	end
end
CoD.HUDUtility.WaypointClearCompassObjectiveIcon = function(f54_arg0, f54_arg1, f54_arg2)
	Engine[0xB1741BF0598F4C0](f54_arg1, f54_arg2, Enum[0xDFCD209FB0D27AF][0xA56794A2EF6C30C])
	Engine[0xB1741BF0598F4C0](f54_arg1, f54_arg2, Enum[0xDFCD209FB0D27AF][0x2FB5107C3D22A8A])
end
CoD.HUDUtility.WaypointGetTeam = function(f55_arg0, f55_arg1)
	return Engine[0x4C77EAF5F088DC3](f55_arg0, f55_arg1)
end
CoD.HUDUtility.WaypointUpdate_FlagA = function(f56_arg0, f56_arg1)
	CoD.HUDUtility.WaypointUpdate_Flag(f56_arg0, f56_arg1, "a")
end
CoD.HUDUtility.WaypointUpdate_FlagB = function(f57_arg0, f57_arg1)
	CoD.HUDUtility.WaypointUpdate_Flag(f57_arg0, f57_arg1, "b")
end
CoD.HUDUtility.WaypointUpdate_Flag = function(f58_arg0, f58_arg1, f58_arg2)
	local f58_local0 = Engine[0x4DF5CFBC1771947](f58_arg1)
	local f58_local1 = Engine[0x4C77EAF5F088DC3](f58_arg1, f58_arg0.objId)
	local f58_local2 = CoD.TeamUtility.GetTeamFactionColor(f58_local1)
	local f58_local3 = Engine[0x3E1BD98D6F60CC3](f58_arg1, f58_arg0.objId, f58_local1)
	if Engine[0x12267460B50F00A](f58_arg1, f58_arg0.objId) == 1 then
		if f58_local3 then
			local f58_local4 = Engine[0x626F871BFD9CF11](f58_arg1, f58_arg0.objId)
			local f58_local5 = f58_local0:create("hudItems.codcaster.Objective" .. f58_arg2 .. ".text")
			f58_local5:set(GetClientName(f58_arg1, f58_local4))
		else
			local f58_local4 = f58_local0:create("hudItems.codcaster.Objective" .. f58_arg2 .. ".text")
			f58_local4:set(Engine[0xF9F1239CFD921FE](0xFDA3B7A577429C1))
		end
	else
		local f58_local4 = f58_local0:create("hudItems.codcaster.Objective" .. f58_arg2 .. ".text")
		f58_local4:set(Engine[0xF9F1239CFD921FE](0xB3059214D90E5E2))
	end
	local f58_local4 = f58_local0:create("hudItems.codcaster.Objective" .. f58_arg2 .. ".color")
	f58_local4:set(f58_local2)
end
CoD.HUDUtility.WaypointUpdate_Ball_Ball = function(f59_arg0, f59_arg1)
	local f59_local0 = f59_arg0.objId
	local f59_local1 = Engine[0x4C77EAF5F088DC3](f59_arg1, f59_local0)
	local f59_local2 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f59_arg1), "ballGametype")
	local f59_local3 = Engine[0xF9F1239CFD921FE](0x3822BF6666B7F1C)
	if f59_local1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or f59_local1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		f59_local3 = Engine[0xA457DFCEF7A7C9D](f59_arg1, Engine[0x626F871BFD9CF11](f59_arg1, f59_local0))
	elseif Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f59_local2, "ballAway")) == 1 then
		f59_local3 = Engine[0xF9F1239CFD921FE](0xC376BAE65A55609)
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f59_local2, "ballStatusText"), f59_local3)
	if CoD.IsShoutcaster(f59_arg1) then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f59_local2, "ballHeldByFriendly"), f59_local1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB])
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f59_local2, "ballHeldByEnemy"), f59_local1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68])
	else
		local f59_local4 = CoD.TeamUtility.GetTeamID(f59_arg1)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f59_local2, "ballHeldByFriendly"), f59_local1 == f59_local4)
		local f59_local5 = Engine[0x83C9B5DE1D9371]
		local f59_local6 = Engine[0xA798E4552F5E872](f59_local2, "ballHeldByEnemy")
		local f59_local7
		if f59_local1 == f59_local4 or f59_local1 == Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] then
			f59_local7 = false
		else
			f59_local7 = true
		end
		f59_local5(f59_local6, f59_local7)
	end
end
CoD.HUDUtility.WaypointUpdate_Control0 = function(f60_arg0, f60_arg1)
	CoD.HUDUtility.WaypointUpdate_Control(f60_arg0, f60_arg1, "A", "0")
end
CoD.HUDUtility.WaypointUpdate_Control1 = function(f61_arg0, f61_arg1)
	CoD.HUDUtility.WaypointUpdate_Control(f61_arg0, f61_arg1, "B", "1")
end
CoD.HUDUtility.WaypointUpdate_EscortRobot = function(f62_arg0, f62_arg1)
	local f62_local0 = Engine[0x4DF5CFBC1771947](f62_arg1)
	local f62_local1 = Engine[0x4C77EAF5F088DC3](f62_arg1, f62_arg0.objId)
	local f62_local2 = f62_local0:create("CalloutWheel.escort_robot.team")
	f62_local2:set(f62_local1)
	f62_local2 = Engine[0x8DF2E5447F384B9]()
	local f62_local3 = f62_local2.Escort:create("robotObjective")
	f62_local3:set(f62_arg0:getModel())
end
CoD.HUDUtility.WaypointUpdate_Control = function(f63_arg0, f63_arg1, f63_arg2, f63_arg3)
	local f63_local0 = Engine[0x4DF5CFBC1771947](f63_arg1)
	local f63_local1 = Engine[0x4C77EAF5F088DC3](f63_arg1, f63_arg0.objId)
	local f63_local2 = CoD.TeamUtility.GetTeamFactionColor(f63_local1)
	local f63_local3 = CoD.CodCasterUtility.GetAttackingTeamColor(f63_local1)
	local f63_local4 = Engine[0x4A91602186AE14D](f63_arg1, f63_arg0.objId)
	local f63_local5 = f63_local0:create("hudItems.codcaster.Objective" .. f63_arg2 .. ".color")
	f63_local5:set(f63_local2)
	f63_local5 = f63_local0:create("hudItems.codcaster.Objective" .. f63_arg2 .. ".progress")
	f63_local5:set(f63_local4)
	f63_local5 = f63_local0:create("HUDItems.codcaster.attackTeamColor")
	f63_local5:set(f63_local3)
	f63_local5 = f63_local0:create("CalloutWheel.control_" .. f63_arg3 .. ".team")
	f63_local5:set(f63_local1)
end
CoD.HUDUtility.WaypointUpdate_Hardpoint = function(f64_arg0, f64_arg1)
	local f64_local0 = Engine[0x4DF5CFBC1771947](f64_arg1)
	local f64_local1 = Engine[0x4C77EAF5F088DC3](f64_arg1, f64_arg0.objId)
	local f64_local2 = Engine[0x532E31F2015143B](f64_arg1, f64_arg0.objId, f64_local1) and Engine[0x3E1BD98D6F60CC3](f64_arg1, f64_arg0.objId, f64_local1)
	local f64_local3 = nil
	if f64_local1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or f64_local1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		f64_local3 = CoD.TeamUtility.GetTeamFactionColor(f64_local1)
	else
		f64_local3 = "255 255 255"
	end
	local f64_local4 = f64_local0:create("hudItems.codcaster.hardpointVisibility")
	f64_local4:set(100)
	if f64_local2 then
		f64_local4 = f64_local0:create("HUDItems.codcaster.ObjectiveA.color")
		f64_local4:set(CoD.TeamUtility.GetTeamFactionColor(Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]))
		f64_local4 = f64_local0:create("HUDItems.codcaster.ObjectiveB.color")
		f64_local4:set(CoD.TeamUtility.GetTeamFactionColor(Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]))
	else
		f64_local4 = f64_local0:create("HUDItems.codcaster.ObjectiveA.color")
		f64_local4:set(f64_local3)
		f64_local4 = f64_local0:create("HUDItems.codcaster.ObjectiveB.color")
		f64_local4:set(f64_local3)
	end
end
CoD.HUDUtility.WaypointUpdate_SD_Bomb = function(f65_arg0, f65_arg1)
	local f65_local0 = Engine[0x4DF5CFBC1771947](f65_arg1)
	local f65_local1 = Engine[0x626F871BFD9CF11](f65_arg1, f65_arg0.objId)
	local f65_local2 = f65_local0:create("hudItems.SDBombClient")
	f65_local2:set(f65_local1 or -1)
end
CoD.HUDUtility.WaypointUpdate_SD_A = function(f66_arg0, f66_arg1)
	CoD.HUDUtility.WaypointUpdate_SD(f66_arg0, f66_arg1, "a")
end
CoD.HUDUtility.WaypointUpdate_SD_B = function(f67_arg0, f67_arg1)
	CoD.HUDUtility.WaypointUpdate_SD(f67_arg0, f67_arg1, "b")
end
CoD.HUDUtility.WaypointUpdate_SD = function(f68_arg0, f68_arg1, f68_arg2)
	local f68_local0 = Engine[0x4DF5CFBC1771947](f68_arg1)
	local f68_local1 = Engine[0x626F871BFD9CF11](f68_arg1, f68_arg0.objId)
	local f68_local2 = Engine[0x4C77EAF5F088DC3](f68_arg1, f68_arg0.objId)
	local f68_local3 = CoD.TeamUtility.GetTeamFactionColor(f68_local2)
	local f68_local4 = CoD.CodCasterUtility.GetAttackingTeamColor(f68_local2)
	local f68_local5 = Engine[0x4A91602186AE14D](f68_arg1, f68_arg0.objId)
	if Engine[0x12267460B50F00A](f68_arg1, f68_arg0.objId) == 0 then
		local f68_local6 = f68_local0:create("hudItems.codcaster.Bomb" .. f68_arg2)
		f68_local6:set(0)
	end
	local f68_local6 = f68_local0:create("hudItems.codcaster.Objective" .. f68_arg2 .. ".color")
	f68_local6:set(f68_local3)
	f68_local6 = f68_local0:create("hudItems.codcaster.Objective" .. f68_arg2 .. ".progress")
	f68_local6:set(f68_local5)
	f68_local6 = f68_local0:create("HUDItems.codcaster.attackTeamColor")
	f68_local6:set(f68_local4)
	f68_local6 = f68_local0:create("CalloutWheel.sd_" .. f68_arg2 .. ".team")
	f68_local6:set(f68_local2)
end
CoD.HUDUtility.WaypointUpdate_SD_Defuse_A = function(f69_arg0, f69_arg1)
	CoD.HUDUtility.WaypointUpdate_SD_Defuse(f69_arg0, f69_arg1, "A")
end
CoD.HUDUtility.WaypointUpdate_SD_Defuse_B = function(f70_arg0, f70_arg1)
	CoD.HUDUtility.WaypointUpdate_SD_Defuse(f70_arg0, f70_arg1, "B")
end
CoD.HUDUtility.WaypointUpdate_SD_Defuse = function(f71_arg0, f71_arg1, f71_arg2)
	local f71_local0 = Engine[0x4DF5CFBC1771947](f71_arg1)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](f71_local0, "SearchAndDestroy"), "defending"), CoD.HUDUtility.IsWaypointOwnedByMyTeam(f71_arg0, f71_arg1))
	local f71_local1 = Engine[0x4C77EAF5F088DC3](f71_arg1, f71_arg0.objId)
	local f71_local2 = CoD.TeamUtility.GetTeamFactionColor(f71_local1)
	local f71_local3 = CoD.CodCasterUtility.GetAttackingTeamColor(f71_local1)
	local f71_local4 = Engine[0x4A91602186AE14D](f71_arg1, f71_arg0.objId)
	local f71_local5 = f71_local0:create("hudItems.codcaster.Objective" .. f71_arg2 .. ".color")
	f71_local5:set(f71_local2)
	f71_local5 = f71_local0:create("hudItems.codcaster.Bomb" .. f71_arg2)
	f71_local5:set(1)
	f71_local5 = f71_local0:create("hudItems.codcaster.Objective" .. f71_arg2 .. ".progress")
	f71_local5:set(f71_local4)
	f71_local5 = f71_local0:create("HUDItems.codcaster.attackTeamColor")
	f71_local5:set(f71_local3)
end
CoD.HUDUtility.WaypointUpdate_CP_GM_Carry_Object = function(f72_arg0, f72_arg1)
	local f72_local0 = DataSources.CPGamePlayBundleData.getModel(f72_arg1)
	if f72_local0.briefcaseClient then
		f72_local0.briefcaseClient:set(Engine[0x626F871BFD9CF11](f72_arg1, f72_arg0.objId) or -1)
	end
end
CoD.HUDUtility.WaypointUpdate_Warzone = function(f73_arg0, f73_arg1)
	local f73_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.war.currentZoneProgress")
	f73_local0:set(Engine[0x4A91602186AE14D](f73_arg1, f73_arg0.objId))
	local f73_local1 = Engine[0x4C77EAF5F088DC3](f73_arg1, f73_arg0.objId)
	local f73_local2 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.war.objectiveHeldByAttackingTeam")
	local f73_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.war.objectiveHeldByDefendingTeam")
	f73_local2:set(Engine[0x532E31F2015143B](f73_arg1, f73_arg0.objId, f73_local1))
	f73_local3:set(Engine[0x3E1BD98D6F60CC3](f73_arg1, f73_arg0.objId, f73_local1))
end
CoD.HUDUtility.WaypointUpdate_Dom_A = function(f74_arg0, f74_arg1)
	CoD.HUDUtility.WaypointUpdate_Dom(f74_arg0, f74_arg1, "a")
end
CoD.HUDUtility.WaypointUpdate_Dom_B = function(f75_arg0, f75_arg1)
	CoD.HUDUtility.WaypointUpdate_Dom(f75_arg0, f75_arg1, "b")
end
CoD.HUDUtility.WaypointUpdate_Dom_C = function(f76_arg0, f76_arg1)
	CoD.HUDUtility.WaypointUpdate_Dom(f76_arg0, f76_arg1, "c")
end
CoD.HUDUtility.WaypointUpdate_Dom = function(f77_arg0, f77_arg1, f77_arg2)
	local f77_local0 = Engine[0x4DF5CFBC1771947](f77_arg1)
	local f77_local1 = Engine[0x4C77EAF5F088DC3](f77_arg1, f77_arg0.objId)
	local f77_local2 = nil
	if f77_local1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or f77_local1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		f77_local2 = CoD.TeamUtility.GetTeamFactionColor(f77_local1)
	else
		f77_local2 = "255 255 255"
	end
	local f77_local3 = f77_local0:create("hudItems.codcaster.Objective" .. f77_arg2 .. ".color")
	f77_local3:set(f77_local2)
	f77_local3 = f77_local0:create("CalloutWheel.dom_" .. f77_arg2 .. ".team")
	f77_local3:set(f77_local1)
end
CoD.HUDUtility.WaypointObjectiveSpecificUpdates = {
	[0x8D49D6C96840472] = CoD.HUDUtility.WaypointUpdate_FlagA,
	[0x8893CBFACF91D4B] = CoD.HUDUtility.WaypointUpdate_FlagB,
	[0xE8EE48622DE2D00] = CoD.HUDUtility.WaypointUpdate_Ball_Ball,
	[0x6EA8129FE9ADAB9] = CoD.HUDUtility.WaypointUpdate_Control0,
	[0x6EA8029FE9AD906] = CoD.HUDUtility.WaypointUpdate_Control1,
	[0x79B5E7B8398CF32] = CoD.HUDUtility.WaypointUpdate_Hardpoint,
	[0x30AD118CDEF1CE2] = CoD.HUDUtility.WaypointUpdate_SD_A,
	[0x30AD018CDEF1B2F] = CoD.HUDUtility.WaypointUpdate_SD_B,
	[0xB61F8136249312F] = CoD.HUDUtility.WaypointUpdate_SD_Bomb,
	[0xC8E9217EFF83A31] = CoD.HUDUtility.WaypointUpdate_SD_Defuse_A,
	[0xC8E8F17EFF83518] = CoD.HUDUtility.WaypointUpdate_SD_Defuse_B,
	[0xF362A660ECF07FF] = CoD.HUDUtility.WaypointUpdate_CP_GM_Carry_Object,
	[0x4ADDDB8A9448B02] = CoD.HUDUtility.WaypointUpdate_CP_GM_Carry_Object,
	[0x57E90B1451515A7] = CoD.HUDUtility.WaypointUpdate_Warzone,
	[0x515EFAB7D96F6B7] = CoD.HUDUtility.WaypointUpdate_Dom_A,
	[0x515F0AB7D96F86A] = CoD.HUDUtility.WaypointUpdate_Dom_B,
	[0x515F1AB7D96FA1D] = CoD.HUDUtility.WaypointUpdate_Dom_C,
	[0xC2F18BB880E692] = CoD.HUDUtility.WaypointUpdate_EscortRobot,
}
CoD.HUDUtility.WaypointListObjectiveTypes = {
	[0x6EA8129FE9ADAB9] = true,
	[0x6EA8029FE9AD906] = true,
	[0x6EA7F29FE9AD753] = true,
	[0x79B5E7B8398CF32] = true,
	[0x515EFAB7D96F6B7] = true,
	[0x515F0AB7D96F86A] = true,
	[0x515F1AB7D96FA1D] = true,
	[0x92DC9B45AD579F4] = true,
	[0x92DCCB45AD57F0D] = true,
}
CoD.HUDUtility.SDDemObjectiveTypes = {
	[0x92DC9B45AD579F4] = "a",
	[0x92DCCB45AD57F0D] = "b",
}
CoD.HUDUtility.WaypointUpdateIconAndText = function(f78_arg0, f78_arg1, f78_arg2)
	local f78_local0 = f78_arg0.objective[0xAA8267261655DF1]
	if f78_arg2 ~= 0 then
		f78_local0 = f78_arg0.objective[0xFD91F76A1196EAB .. f78_arg2] or f78_local0
	end
	if CoD.WaypointUtility.ShouldHideMinimapIcon(f78_arg0, f78_arg1) then
		CoD.HUDUtility.WaypointClearCompassObjectiveIcon(f78_arg0, f78_arg1, f78_arg0.objId)
	else
		local f78_local1 = f78_arg0:getModel()
		if f78_local1 and f78_local1.color then
			local f78_local2 = f78_local1.color:get()
			if f78_arg0.objective[0x5783D4CCECA51AF] then
				f78_local2 = CoD.HUDUtility.GetObjectiveColor(f78_arg1, f78_arg0.objective, f78_arg0.objId, true)
			end
			CoD.HUDUtility.WaypointSetCompassObjectiveIcon(f78_arg0, f78_arg1, f78_arg0.objId, f78_local0, f78_arg0.objective[0xAAC4A8770847600], ColorSet[f78_local2])
		end
	end
	local f78_local1 = CoD.HUDUtility.WaypointObjectiveSpecificUpdates[f78_arg0.objective.id]
	if f78_local1 then
		f78_local1(f78_arg0, f78_arg1)
	end
end
CoD.HUDUtility.ShouldSnapInteractableWaypointToCenter = function(f79_arg0, f79_arg1, f79_arg2, f79_arg3)
	if f79_arg0.objective[0xA8F7A3EDE89CCD7] and CoD.CodCasterUtility.CodCasterIsInAerialCam(f79_arg1) then
		return false
	elseif f79_arg0.objective[0xF12F05DDE5E8E84] == 1 then
		return true
	elseif CoD.HUDUtility.IsPlayerUsingWaypoint(f79_arg0, f79_arg1, f79_arg2, f79_arg3) then
		return true
	elseif f79_arg0.objective[0xDFD6C844E98BE2F] == 1 and not CoD.WaypointUtility.IsObjectiveRequirementLabelHidden(f79_arg0, f79_arg1) then
		return true
	elseif f79_arg0.objective[0x44AC803636BB2F2] == 1 then
		local f79_local0 = f79_arg0:getModel(f79_arg1, "isOffscreen")
		if f79_local0 and f79_local0:get() then
			return true
		end
	end
	return false
end
CoD.HUDUtility.WaypointUpdateSnapToCenter = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
	local f80_local0 = CoD.HUDUtility.ShouldSnapInteractableWaypointToCenter(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
	f80_arg0._halfWidth = CoD.FreeCursorUtility.GetWidthByLocalLeftRight(f80_arg0) / 2
	f80_arg0._halfHeight = CoD.FreeCursorUtility.GetHeightByLocalTopBottom(f80_arg0) / 2
	if f80_arg0.snappedToCenter == f80_local0 then
		return
	elseif f80_local0 == true then
		local f80_local1 = f80_arg0.objective[0xD4027E5576AB79E] or 0
		local f80_local2 = f80_arg0.objective[0xD4028E5576AB951] or 0
		if f80_arg0.snappedToCenter ~= nil then
			f80_arg0:beginAnimation("snap_in", 250, true, true)
		end
		f80_arg0:setEntityContainerStopUpdating(true)
		f80_arg0:setLeftRight(0.5, 0.5, -f80_arg0._halfWidth + f80_local1, f80_arg0._halfWidth + f80_local1)
		if f80_arg0.objective[0xAAF205AA281C88A] == 1 then
			f80_arg0:setTopBottom(0.5, 0.5, 128 + f80_local2, 128 + f80_arg0._halfHeight * 2 + f80_local2)
		else
			local f80_local3, f80_local4, f80_local5, f80_local6 = Engine[0x26E31A9FDAA85EB](f80_arg1, true)
			f80_arg0:setTopBottom(0.5, 0.5, 276 + f80_local4 + f80_local2, 276 + f80_local4 + f80_arg0._halfHeight * 2 + f80_local2)
		end
	else
		if f80_arg0.snappedToCenter ~= nil then
			f80_arg0:beginAnimation("snap_out", 250, true, true)
		end
		f80_arg0:setEntityContainerStopUpdating(false)
		f80_arg0:setLeftRight(0.5, 0.5, -f80_arg0._halfWidth, f80_arg0._halfWidth)
		f80_arg0:setTopBottom(0.5, 0.5, -f80_arg0._halfHeight, f80_arg0._halfHeight)
	end
	f80_arg0.snappedToCenter = f80_local0
end
CoD.HUDUtility.SetWaypointElementToFadeAlpha = function(f81_arg0, f81_arg1)
	if not f81_arg0._waypointFadeElements then
		f81_arg0._waypointFadeElements = {}
	end
	table.insert(f81_arg0._waypointFadeElements, f81_arg1)
end
CoD.HUDUtility.SetupWaypointContainerParent = function(f82_arg0)
	f82_arg0:setupWaypointContainerParent()
end
CoD.HUDUtility.WaypointUpdate = function(f83_arg0, f83_arg1)
	local f83_local0 = f83_arg0.objId
	local f83_local1 = f83_arg0.ping
	local f83_local2 = Engine[0x626F871BFD9CF11](f83_arg1, f83_local0)
	local f83_local3 = Engine[0x2C6B07FD023877B](f83_arg1, Engine[0x869E84B826141D2](f83_arg1))
	local f83_local4 = Engine[0x532E31F2015143B](f83_arg1, f83_local0, f83_local3)
	local f83_local5 = Engine[0x3E1BD98D6F60CC3](f83_arg1, f83_local0, f83_local3)
	CoD.HUDUtility.WaypointUpdateSnapToCenter(f83_arg0, f83_arg1, f83_local4, f83_local5)
	if f83_arg0.objective.has_low_ammo_state then
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f83_arg1, "CurrentWeapon", "totalAmmoLow") then
			f83_arg0:setEntityContainerClamp(f83_arg0.objective[0x728686596E4E083] == 1)
		else
			f83_arg0:setEntityContainerClamp(f83_arg0.objective.waypoint_clamp)
		end
	end
	local f83_local6 = f83_arg0.zOffset
	if (f83_local4 or f83_local5) and f83_arg0.objective[0xCA1B2992BC02684] ~= 0 then
		f83_local6 = f83_local6 + f83_arg0.objective[0xCA1B2992BC02684]
	end
	if f83_local2 and not f83_local1 then
		f83_arg0:setupWaypointContainer(f83_local0, f83_arg0.xOffset, f83_arg0.yOffset, f83_local6)
	else
		local f83_local7, f83_local8, f83_local9 = Engine[0xC39E4C676019B6D](f83_arg1, f83_local0)
		f83_arg0:setupWaypointContainer(f83_local0, f83_local7 + f83_arg0.xOffset, f83_local8 + f83_arg0.yOffset, f83_local9 + f83_local6)
	end
	if f83_local1 and f83_local2 then
		f83_arg0:clearEntityMidpoint(true)
		local f83_local7 = Engine[0xDBC2AD5002B261B](0x8C9EE40FA6A7B89) * 1000
		local f83_local8 = function(f84_arg0)
			f84_arg0:setAlpha(CoD.HUDUtility.WAYPOINT_CTF_PULSE_BEGIN_ALPHA)
			f84_arg0:beginAnimation(f83_local7, Enum[0xF50FFF429AB1890][0x253268AF0FBB0E8])
			f84_arg0:setAlpha(CoD.HUDUtility.WAYPOINT_CTF_PULSE_END_ALPHA)
		end
		for f83_local12, f83_local13 in ipairs(f83_arg0._waypointFadeElements) do
			f83_local8(f83_local13)
		end
		if f83_local7 > 0 then
			for f83_local12, f83_local13 in ipairs(f83_arg0._waypointFadeElements) do
				f83_local13:registerEventHandler("transition_complete_keyframe", function(element, event)
					if event.interrupted then
						element:setAlpha(1)
					else
						f83_local8(element)
					end
				end)
			end
		end
		f83_arg0.pinging = true
	elseif f83_arg0.pinging == true then
		for f83_local10, f83_local11 in ipairs(f83_arg0._waypointFadeElements) do
			f83_local11:registerEventHandler("transition_complete_keyframe", f83_arg0.clipFinished)
		end
		f83_arg0:clearEntityMidpoint(false)
		f83_arg0:completeAnimation()
		f83_arg0:setAlpha(1)
		f83_arg0.pinging = nil
	end
	f83_arg0:setEntityContainerScale(f83_arg0.objective[0x33FD2E0B6B927C6] == 1)
	if f83_arg0.objective[0xC590BF263AF815] == 1 and f83_arg0.WaypointArrowContainer then
		f83_arg0.WaypointArrowContainer:setup3dPointer(f83_local0)
	end
end
CoD.HUDUtility.IsObjectivePropertyValueEqualTo = function(f86_arg0, f86_arg1, f86_arg2)
	if f86_arg0:getModel() then
		local f86_local0 = CoD.HUDUtility.GetCachedObjective
		local f86_local1 = f86_arg0:getModel()
		f86_local0 = f86_local0(f86_local1:get())
		return f86_local0 and f86_local0[f86_arg1] == f86_arg2
	else
	end
end
CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo = function(f87_arg0, f87_arg1, f87_arg2)
	if f87_arg0:getModel() then
		local f87_local0 = CoD.HUDUtility.GetCachedObjective
		local f87_local1 = f87_arg0:getModel()
		f87_local0 = f87_local0(f87_local1:get())
		return f87_local0 and f87_local0[f87_arg1] == f87_arg2
	else
	end
end
CoD.HUDUtility.GetObjectivePropertyValue = function(f88_arg0, f88_arg1)
	if f88_arg0 then
		local f88_local0 = CoD.HUDUtility.GetCachedObjective(f88_arg0:get())
		return f88_local0 and f88_local0[f88_arg1]
	else
	end
end
CoD.HUDUtility.GetModifiedColorName = function(f89_arg0, f89_arg1, f89_arg2, f89_arg3)
	if f89_arg2 then
		return f89_arg1 .. "_Bright"
	elseif f89_arg3 then
		return f89_arg1 .. "_Muted"
	else
		return f89_arg1
	end
end
CoD.HUDUtility.GetFriendlyOrEnemyColorByObjIdInternal = function(f90_arg0, f90_arg1, f90_arg2, f90_arg3)
	local f90_local0 = CoD.HUDUtility.WaypointGetTeam(f90_arg0, f90_arg1)
	local f90_local1 = CoD.TeamUtility.GetTeamID(f90_arg0)
	local f90_local2 = CoD.perController[f90_arg0].objMeterPrevTeams and CoD.perController[f90_arg0].objMeterPrevTeams[f90_arg1] or Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC]
	local f90_local3 = Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC]
	local f90_local4 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f90_arg0, "WaypointNeutral")
	local f90_local5, f90_local6, f90_local7 = CoD.WaypointUtility.ConvertToColorInternal(CoD.HUDUtility.GetModifiedColorName(f90_arg0, f90_local4, f90_arg2, f90_arg3), f90_local4)
	if f90_local0 == Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] then
		local f90_local8 = Engine[0x532E31F2015143B](f90_arg0, f90_arg1, f90_local1)
		local f90_local9 = Engine[0x3E1BD98D6F60CC3](f90_arg0, f90_arg1, f90_local1)
		if f90_local8 and f90_local9 then
			f90_local3 = f90_local2
		elseif f90_local8 then
			f90_local3 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
		elseif f90_local9 then
			f90_local3 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
		else
			f90_local3 = f90_local2
		end
	elseif f90_local1 == f90_local0 then
		f90_local3 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
	else
		f90_local3 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
	end
	if not CoD.perController[f90_arg0].objMeterPrevTeams then
		CoD.perController[f90_arg0].objMeterPrevTeams = {}
	end
	CoD.perController[f90_arg0].objMeterPrevTeams[f90_arg1] = f90_local3
	if f90_local3 ~= Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] then
		if CoD.IsShoutcaster(f90_arg0) then
			local f90_local8 = f90_local3
			if f90_local1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
				if f90_local3 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
					local f90_local10 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
				end
				f90_local8 = f90_local10 or Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
			end
			local f90_local9 = CoD.HUDUtility.GetShoutcasterHudTeamColor(f90_arg0, f90_local8, "FriendlyBlue", "EnemyOrange")
			local f90_local11 = f90_local9.r
			local f90_local12 = f90_local9.g
			f90_local7 = f90_local9.b
			f90_local6 = f90_local12
			f90_local5 = f90_local11
		else
			if f90_local3 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
				f90_local4 = "FriendlyBlue"
			else
				f90_local4 = "EnemyOrange"
			end
			f90_local4 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f90_arg0, f90_local4)
			f90_local5, f90_local6, f90_local7 = CoD.WaypointUtility.ConvertToColorInternal(CoD.HUDUtility.GetModifiedColorName(f90_arg0, f90_local4, f90_arg2, f90_arg3), f90_local4)
		end
	end
	return f90_local5, f90_local6, f90_local7
end
CoD.HUDUtility.GetFriendlyOrEnemyBrightColorByObjId = function(f91_arg0, f91_arg1)
	return CoD.HUDUtility.GetFriendlyOrEnemyColorByObjIdInternal(f91_arg0, f91_arg1, true, false)
end
CoD.HUDUtility.GetFriendlyOrEnemyMutedColorByObjId = function(f92_arg0, f92_arg1)
	return CoD.HUDUtility.GetFriendlyOrEnemyColorByObjIdInternal(f92_arg0, f92_arg1, false, true)
end
CoD.HUDUtility.GetFriendlyOrEnemyColorByObjId = function(f93_arg0, f93_arg1)
	return CoD.HUDUtility.GetFriendlyOrEnemyColorByObjIdInternal(f93_arg0, f93_arg1, false, false)
end
CoD.HUDUtility.GetFriendlyOrEnemyColorByFlagsInternal = function(f94_arg0, f94_arg1, f94_arg2, f94_arg3, f94_arg4)
	local f94_local0 = CoD.TeamUtility.GetTeamID(f94_arg1)
	local f94_local1 = CoD.HUDUtility.GetObjectivePropertyValue(f94_arg0, 0x11952FE919E43 .. f94_arg2)
	local f94_local2 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f94_arg1, "WaypointNeutral")
	local f94_local3, f94_local4, f94_local5 = CoD.WaypointUtility.ConvertToColorInternal(CoD.HUDUtility.GetModifiedColorName(f94_arg1, f94_local2, f94_arg3, f94_arg4), f94_local2)
	if f94_arg2 > 0 then
		if CoD.IsShoutcaster(f94_arg1) then
			local f94_local6 = CoD.HUDUtility.GetShoutcasterHudTeamColor(f94_arg1, f94_local1, "FriendlyBlue", "EnemyOrange")
			local f94_local7 = f94_local6.r
			local f94_local8 = f94_local6.g
			f94_local5 = f94_local6.b
			f94_local4 = f94_local8
			f94_local3 = f94_local7
		else
			local f94_local6 = CoD.TeamUtility.GetOppositeTeamAxisAllies(f94_local0)
			if f94_local6 ~= f94_local0 then
				if f94_local1 == f94_local0 then
					f94_local2 = "FriendlyBlue"
				elseif f94_local1 == f94_local6 then
					f94_local2 = "EnemyOrange"
				else
					f94_local2 = "PlayerYellow"
				end
			elseif f94_local0 == f94_local1 then
				f94_local2 = "FriendlyBlue"
			else
				f94_local2 = "EnemyOrange"
			end
			f94_local2 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f94_arg1, f94_local2)
			f94_local3, f94_local4, f94_local5 = CoD.WaypointUtility.ConvertToColorInternal(CoD.HUDUtility.GetModifiedColorName(f94_arg1, f94_local2, f94_arg3, f94_arg4), f94_local2)
		end
	end
	return f94_local3, f94_local4, f94_local5
end
CoD.HUDUtility.GetFriendlyOrEnemyBrightColorByFlags = function(f95_arg0, f95_arg1, f95_arg2)
	return CoD.HUDUtility.GetFriendlyOrEnemyColorByFlagsInternal(f95_arg0, f95_arg1, f95_arg2, true, false)
end
CoD.HUDUtility.GetFriendlyOrEnemyMutedColorByFlags = function(f96_arg0, f96_arg1, f96_arg2)
	return CoD.HUDUtility.GetFriendlyOrEnemyColorByFlagsInternal(f96_arg0, f96_arg1, f96_arg2, false, true)
end
CoD.HUDUtility.GetFriendlyOrEnemyColorByFlags = function(f97_arg0, f97_arg1, f97_arg2)
	return CoD.HUDUtility.GetFriendlyOrEnemyColorByFlagsInternal(f97_arg0, f97_arg1, f97_arg2, false, false)
end
CoD.HUDUtility.VisibleIfInDemoPlayback = function()
	local f98_local0
	if Engine[0xA55C3ACD0D2BCF0]() then
		f98_local0 = CoD.ModelUtility.IsGlobalModelValueEqualToEnum("demo.cameraMode", Enum[0xF432DF404208022][0x448CED16817146D])
	else
		f98_local0 = true
	end
	return f98_local0
end
CoD.HUDUtility.GetOverheadHealthbarAlpha = function(f99_arg0, f99_arg1)
	local f99_local0 = CoD.SafeGetModelValue(f99_arg0:getModel(), "clientNum")
	local f99_local1 = Engine[0xA5B9C0111291A8B]()
	local f99_local2 = DataSources.GameplayFeedbackSettings.getModel(f99_local1)
	if CoD.IsShoutcaster(f99_local1) then
		return CoD.CodCasterUtility.ShouldShowOverheadInfo(f99_arg0, f99_local1, "shoutcaster_ds_overhead_health") and 1 or 0
	elseif IsVisibilityBitSet(f99_local1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]) then
		return 0
	elseif not CoD.isPC or not f99_local0 or f99_local0 < 0 or f99_local0 >= LuaDefine.MAX_CLIENTS then
		return f99_arg1
	elseif Engine[0x2C6B07FD023877B](f99_local1, f99_local0) == CoD.TeamUtility.GetTeamID(f99_local1) then
		f99_arg1 = CoD.SafeGetModelValue(f99_local2, "healthBarAllyAlpha")
	else
		f99_arg1 = CoD.SafeGetModelValue(f99_local2, "healthBarEnemyAlpha")
	end
	return f99_arg1
end
CoD.HUDUtility.GetAbilityHoldToActivateAlpha = function(f100_arg0, f100_arg1, f100_arg2)
	if not CoD.isPC then
		return f100_arg2
	else
		local f100_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f100_arg0), "hudItems.abilityHoldToActivate")
		if (f100_local0 and Engine[0x614D394F6F9A18D](f100_local0)) == 0 or CoD.SafeGetModelValue(DataSources.GameplayFeedbackSettings.getModel(f100_arg0), "hideRadiationHold") then
			return 0
		else
			return f100_arg2
		end
	end
end
CoD.HUDUtility.ConvertProgressToRadiationNeedleRotation = function(f101_arg0, f101_arg1, f101_arg2)
	return -(f101_arg1 * f101_arg2 - f101_arg1 / 2)
end
CoD.HUDUtility.MeterClockFraction = function(f102_arg0, f102_arg1, f102_arg2, f102_arg3, f102_arg4, f102_arg5, f102_arg6)
	local f102_local0 = f102_arg3
	local f102_local1 = (f102_arg1 - f102_arg0) * f102_local0 + f102_arg0
	DebugPrint("" .. f102_local0 .. ", " .. f102_local1)
	return f102_local1, 0, f102_arg2, 0
end
CoD.HUDUtility.InitOverheadNames = function(f103_arg0, f103_arg1, f103_arg2)
	local f103_local0 = f103_arg0[f103_arg2]
	if f103_local0 then
		f103_local0:setupOverheadNameContainer()
		local f103_local1 = CoD.CPMPZMWZ(CoD.OverheadName_CP, CoD.OverheadName_MP, CoD.OverheadName_ZM, CoD.OverheadName_WZ)
		if f103_local1 then
			for f103_local2 = 0, LuaDefine.MAX_CLIENTS - 1, 1 do
				local f103_local5 = Engine[0xE4D2F32833CFA6C](f103_local2)
				local f103_local6 = f103_local5:create("abilityCallout.shouldClamp")
				f103_local6:set(false)
				f103_local6 = f103_local5:create("abilityCallout.clamped")
				f103_local6:set(false)
				f103_local5:create("abilityCallout.direction")
				local f103_local7 = f103_local1.new(f103_arg0, f103_arg1, 0, 0, 0, f103_local1.__defaultWidth, 0, 0, 0, f103_local1.__defaultHeight)
				f103_local7:setupOverheadName(f103_local2)
				f103_local0:addElement(f103_local7)
				f103_arg0:sendInitializationEvents(f103_arg1, f103_local7)
			end
		end
		local f103_local2 = CoD.CPMPZM(CoD.ActorOverheadName_CP, nil, CoD.ActorOverheadName_ZM)
		if f103_local2 then
			local f103_local3 = Engine[0x4DF5CFBC1771947](f103_arg1)
			f103_local3 = f103_local3:create("ActorOverheadNames")
			local f103_local4 = nil
			local f103_local8 = -1
			repeat
				f103_local8 = f103_local8 + 1
				local f103_local5 = f103_local3:create(f103_local8)
				local f103_local6 = f103_local5:create("displayName")
				f103_local6:set("")
				f103_local6 = f103_local5:create("team")
				f103_local6:set(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
				f103_local4 = f103_local2.new(f103_arg0, f103_arg1, 0, 0, 0, f103_local2.__defaultWidth, 0, 0, 0, f103_local2.__defaultHeight)
				f103_local0:addElement(f103_local4)
				f103_local4:setModel(f103_local5, f103_arg1)
				f103_arg0:sendInitializationEvents(f103_arg1, f103_local4)
			until not f103_local4:setupActorOverheadName(f103_local8)
		end
	end
end
CoD.HUDUtility.InitOverheadNamesDraft = function(f104_arg0, f104_arg1, f104_arg2)
	local f104_local0 = f104_arg0[f104_arg2]
	if f104_local0 then
		f104_local0:setupOverheadNameContainer()
		local f104_local1 = CoD.PositionDraft_Client
		if f104_local1 then
			local f104_local2 = IsGametypeTeambased()
			local f104_local3 = nil
			if not f104_local2 then
				f104_local3 = CoD.HUDUtility.PositionDraftSelfPosition + 1
			elseif CoD.isPublicOnlineGame() then
				local f104_local4 = Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]())
				f104_local3 = f104_local4.maxPlayers / 2
			else
				f104_local3 = Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			end
			for f104_local5 = 0, f104_local3 - 1, 1 do
				if f104_local2 or f104_local5 == CoD.HUDUtility.PositionDraftSelfPosition then
					local f104_local7 = f104_local1.new(f104_arg0, f104_arg1, 0, 0, 0, f104_local1.__defaultWidth, 0, 0, 0, f104_local1.__defaultHeight)
					f104_local7:subscribeToGlobalModel(f104_arg1, "PositionDraftClients", f104_local5 + 1, function(model)
						f104_local7:setModel(model, f104_arg1)
					end)
					f104_local7:setupOverheadNameDraft(f104_local5)
					f104_local0:addElement(f104_local7)
					f104_arg0:sendInitializationEvents(f104_arg1, f104_local7)
				end
			end
		end
	end
end
CoD.HUDUtility.OverheadNameTeamIsSelfPlayerTeam = function(f106_arg0, f106_arg1)
	local f106_local0 = f106_arg0:getModel(f106_arg1, "team")
	return (f106_local0 and f106_local0:get()) == CoD.TeamUtility.GetTeamIDForController(f106_arg1)
end
CoD.HUDUtility.GetFriendlyOrEnemyColorNameByTeamId = function(f107_arg0, f107_arg1, f107_arg2, f107_arg3)
	local f107_local0 = DataSources.Factions.getModel(f107_arg0)
	f107_local0 = f107_local0.actualTeam:get()
	local f107_local1 = nil
	if f107_arg1 == f107_local0 then
		f107_local1 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f107_arg0, f107_arg2)
	else
		f107_local1 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f107_arg0, f107_arg3)
	end
	return f107_local1
end
CoD.HUDUtility.GetShoutcasterHudTeamColor = function(f108_arg0, f108_arg1, f108_arg2, f108_arg3)
	local f108_local0 = nil
	if CoD.TeamUtility.ShouldUseCustomTeamIdentity(f108_arg0) then
		f108_local0 = CoD.ColorUtility.GetColorFromFormattedColorString(CoD.GetCodCasterTeamColor(f108_arg0, f108_arg1))
	elseif f108_arg1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		f108_local0 = ColorSet[f108_arg2]
	else
		f108_local0 = ColorSet[f108_arg3]
	end
	return f108_local0
end
CoD.HUDUtility.GetFriendlyOrEnemyColorByTeamId = function(f109_arg0, f109_arg1)
	local f109_local0 = nil
	if CoD.IsShoutcaster(f109_arg0) then
		f109_local0 = CoD.HUDUtility.GetShoutcasterHudTeamColor(f109_arg0, f109_arg1, "FriendlyBlue", "EnemyOrange")
	else
		f109_local0 = ColorSet[CoD.HUDUtility.GetFriendlyOrEnemyColorNameByTeamId(f109_arg0, f109_arg1, "FriendlyBlue", "EnemyOrange")]
	end
	return f109_local0.r, f109_local0.g, f109_local0.b
end
CoD.HUDUtility.GetFriendlyOrEnemyBaseColor = function(f110_arg0, f110_arg1)
	local f110_local0 = CoD.HUDUtility.GetFriendlyOrEnemyColorNameByTeamId(f110_arg0, f110_arg1, "FriendlyBlue", "EnemyOrange")
	return CoD.WaypointUtility.ConvertToColorInternal(f110_local0 .. "_Base", f110_local0)
end
CoD.HUDUtility.GetFriendlyOrEnemyMutedColor = function(f111_arg0, f111_arg1)
	local f111_local0 = CoD.HUDUtility.GetFriendlyOrEnemyColorNameByTeamId(f111_arg0, f111_arg1, "FriendlyBlue", "EnemyOrange")
	return CoD.WaypointUtility.ConvertToColorInternal(f111_local0 .. "_Muted", f111_local0)
end
CoD.HUDUtility.GetFriendlyOrEnemyBrightColor = function(f112_arg0, f112_arg1)
	local f112_local0 = CoD.HUDUtility.GetFriendlyOrEnemyColorNameByTeamId(f112_arg0, f112_arg1, "FriendlyBlue", "EnemyOrange")
	return CoD.WaypointUtility.ConvertToColorInternal(f112_local0 .. "_Bright", f112_local0)
end
CoD.HUDUtility.GetOverheadNameColorByTeamId = function(f113_arg0, f113_arg1)
	if CoD.isWarzone then
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.White)
	else
		return CoD.HUDUtility.GetFriendlyOrEnemyColorByTeamId(f113_arg0, f113_arg1)
	end
end
CoD.HUDUtility.GetFriendlyOrEnemyHealthBarColorByTeamId = function(f114_arg0, f114_arg1)
	local f114_local0 = nil
	if CoD.IsShoutcaster(f114_arg0) then
		f114_local0 = CoD.HUDUtility.GetShoutcasterHudTeamColor(f114_arg0, f114_arg1, "FriendlyHealthBar", "EnemyOrange")
	else
		f114_local0 = ColorSet[CoD.HUDUtility.GetFriendlyOrEnemyColorNameByTeamId(f114_arg0, f114_arg1, "FriendlyHealthBar", "EnemyOrange")]
	end
	return f114_local0.r, f114_local0.g, f114_local0.b
end
CoD.HUDUtility.GetFriendlyOrEnemyHealthBarPulseColorByTeamId = function(f115_arg0, f115_arg1)
	local f115_local0 = ColorSet[CoD.HUDUtility.GetFriendlyOrEnemyColorNameByTeamId(f115_arg0, f115_arg1, "EnemyOrange", "FriendlyHealthBar")]
	return f115_local0.r, f115_local0.g, f115_local0.b
end
CoD.HUDUtility.GetPlayerNameColorByClientNum = function(f116_arg0, f116_arg1)
	if IsZombies() then
		local f116_local0 = Enum[0xC3EBEB018F9C5ED][0xD44A16999E1790A]
		local f116_local1 = Engine[0x3745B56C88F5316](f116_arg0)
		if f116_local1 ~= nil and f116_local1[0xF7EA50ADC77CDD0] ~= nil then
			f116_local0 = f116_local1[0xF7EA50ADC77CDD0]:get()
		end
		if f116_local0 == Enum[0xC3EBEB018F9C5ED][0xD44A16999E1790A] then
			local f116_local2 = nil
			if f116_arg1 == 0 then
				local f116_local3 = {}
				f116_local2 = Dvar[0x6BEE54AB204EDA4]:get()
			elseif f116_arg1 == 1 then
				local f116_local3 = {}
				f116_local2 = Dvar[0x6BEE64AB204EF57]:get()
			elseif f116_arg1 == 2 then
				local f116_local3 = {}
				f116_local2 = Dvar[0x6BEE74AB204F10A]:get()
			elseif f116_arg1 == 3 then
				local f116_local3 = {}
				f116_local2 = Dvar[0x6BEE84AB204F2BD]:get()
			end
			return f116_local2[1], f116_local2[2], f116_local2[3]
		end
	end
	return CoD.HUDUtility.GetFriendlyOrEnemyColorByTeamId(f116_arg0, Engine[0x2C6B07FD023877B](f116_arg0, f116_arg1))
end
CoD.HUDUtility.GetPlayerHealthBarColorByClientNum = function(f117_arg0, f117_arg1)
	if IsZombies() then
		local f117_local0 = Enum[0xC3EBEB018F9C5ED][0xD44A16999E1790A]
		local f117_local1 = Engine[0x3745B56C88F5316](f117_arg0)
		if f117_local1 ~= nil and f117_local1[0xF7EA50ADC77CDD0] ~= nil then
			f117_local0 = f117_local1[0xF7EA50ADC77CDD0]:get()
		end
		if f117_local0 == Enum[0xC3EBEB018F9C5ED][0xD44A16999E1790A] then
			local f117_local2 = nil
			if f117_arg1 == 0 then
				local f117_local3 = {}
				f117_local2 = Dvar[0x6BEE54AB204EDA4]:get()
			elseif f117_arg1 == 1 then
				local f117_local3 = {}
				f117_local2 = Dvar[0x6BEE64AB204EF57]:get()
			elseif f117_arg1 == 2 then
				local f117_local3 = {}
				f117_local2 = Dvar[0x6BEE74AB204F10A]:get()
			elseif f117_arg1 == 3 then
				local f117_local3 = {}
				f117_local2 = Dvar[0x6BEE84AB204F2BD]:get()
			end
			return f117_local2[1], f117_local2[2], f117_local2[3]
		end
	end
	return CoD.HUDUtility.GetFriendlyOrEnemyHealthBarColorByTeamId(f117_arg0, Engine[0x2C6B07FD023877B](f117_arg0, f117_arg1))
end
CoD.HUDUtility.InitObituaryCallout = function(f118_arg0, f118_arg1)
	local f118_local0 = f118_arg0
	f118_local0.playNotification = function(f119_arg0, f119_arg1)
		local f119_local0 = Engine[0x4DF5CFBC1771947](f118_arg1)
		local f119_local1 = f119_local0:create("obituaryCallout")
		local f119_local2 = f119_local1:create("clientNum")
		f119_local2:set(f119_arg1.clientNum)
		f119_local2 = f119_local1:create("mod")
		f119_local2:set(f119_arg1.mod)
		f119_local2 = f119_local1:create("damageDealt")
		f119_local2:set(f119_arg1.damageDealt)
		f119_local2 = f119_local1:create("style")
		if not f119_local2:set(f119_arg1.style) then
			Engine[0x6A489878620F3BC](f119_local1.style)
		end
		local f119_local3 = f119_local1:create("xuid")
		f119_local3:set(f119_arg1.xuid)
		f119_local3 = f119_local1:create("rank")
		f119_local3:set(f119_arg1.rank)
		f119_local3 = f119_local1:create("rankIcon")
		f119_local3:set(f119_arg1.rankIcon)
		f119_arg0.currentNotification = f119_arg1
		f119_arg0:setModel(f119_local1, f118_arg1)
		f118_arg0:playClip("Show")
	end
	f118_local0.appendNotification = function(f120_arg0, f120_arg1)
		if f120_arg1 == nil then
			return
		elseif f120_arg0.currentNotification ~= nil then
			local f120_local0 = f120_arg0.nextNotification
			if f120_local0 == nil then
				f120_arg0.nextNotification = f120_arg1
			end
			while f120_local0 and f120_local0.next ~= nil do
				f120_local0 = f120_local0.next
			end
			f120_local0.next = f120_arg1
		else
			f120_arg0:playNotification(f120_arg1)
		end
	end
	f118_local0:subscribeToGlobalModel(f118_arg1, "PerController", "scriptNotify", function(model)
		if CoD.ModelUtility.IsParamModelEqualToString(model, 0x9FB0A7FE2E8EC41) then
			f118_local0.nextNotification = nil
			f118_arg0:playClip("DefaultClip")
		end
	end)
	f118_local0.getModelValueTable = function(f122_arg0, f122_arg1)
		local f122_local0 = nil
		if f122_arg1.damageDealt then
			f122_local0 = {
				clientNum = f122_arg1.clientNum:get(),
				mod = f122_arg1.mod:get(),
				damageDealt = f122_arg1.damageDealt:get(),
				style = f122_arg1.style:get(),
				xuid = f122_arg1.xuid:get(),
				rank = f122_arg1.rank:get(),
				rankIcon = f122_arg1.rankIcon:get(),
			}
		else
			f122_local0 = {
				clientNum = f122_arg1.clientNum:get(),
				mod = f122_arg1.mod:get(),
				style = f122_arg1.style:get(),
				xuid = f122_arg1.xuid:get(),
				rank = f122_arg1.rank:get(),
				rankIcon = f122_arg1.rankIcon:get(),
			}
		end
		return f122_local0
	end
	f118_local0.currentNotification = nil
	f118_local0.nextNotification = nil
	local f118_local1 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f118_arg1), "playerKilledCallout")
	Engine[0x83C9B5DE1D9371](f118_local1, false)
	if not CoD.isCampaign then
		f118_local0:subscribeToModel(f118_local1, function(model)
			if Engine[0x614D394F6F9A18D](model) == true then
				f118_local0:appendNotification(f118_local0:getModelValueTable(Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f118_arg1), "playerObituary")))
			end
		end)
	end
	f118_arg0:registerEventHandler("clip_over", function(element, event)
		f118_local0.currentNotification = nil
		if f118_local0.nextNotification ~= nil then
			f118_local0:playNotification(f118_local0.nextNotification)
			f118_local0.nextNotification = f118_local0.nextNotification.next
		end
	end)
end
CoD.HUDUtility.GetModIconforClient = function(f125_arg0, f125_arg1)
	local f125_local0 = nil
	if f125_arg1 == Enum[0x52177B239BFECC1][0xAF054282DBAA25B] then
		f125_local0 = CoD.HUDUtility.GetModIcon(f125_arg1, 0x8DAF2B58F8C7979)
	else
		f125_local0 = CoD.HUDUtility.GetModIcon(Enum[0x52177B239BFECC1][0x2C99EB591CE8EB6], 0x8DAF2B58F8C7979)
	end
	local f125_local1 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f125_arg0), "playerObituary"), "weaponIcon"))
	if Engine[0x724C6F17E39C2CA]() < 39 then
		if f125_local1 and f125_local1 ~= "" then
			f125_local0 = f125_local1
		end
	elseif Engine[0x238317564B9D47B](f125_local1) then
		f125_local0 = f125_local1
	end
	return f125_local0
end
CoD.HUDUtility.GetModIcon = function(f126_arg0, f126_arg1)
	local f126_local0 = f126_arg1
	local f126_local1 = CoD.HUDUtility.GetModInfo(f126_arg0)
	if f126_local1 then
		f126_local0 = f126_local1[0xBFF4CC56C2092F0]
	end
	return f126_local0
end
CoD.HUDUtility.GetModInfo = function(f127_arg0)
	local f127_local0 = CoD.HUDUtility.GetMeansOfDeathTable()
	return f127_local0 and f127_local0[f127_arg0]
end
CoD.HUDUtility.GetMeansOfDeathTable = function()
	if not CoD.HUDUtility.MeansOfDeathTable then
		local f128_local0 = {}
		local f128_local1 = Engine[0xA7E3CD65E63086F](0x90E99B72AB53006)
		if f128_local1 then
			for f128_local5, f128_local6 in ipairs(f128_local1) do
				f128_local0[Enum[0x52177B239BFECC1][Engine[0xC53F8D38DF9042B](f128_local6[0x808591917670EE3])]] = f128_local6
			end
		end
		CoD.HUDUtility.MeansOfDeathTable = f128_local0
	end
	return CoD.HUDUtility.MeansOfDeathTable
end
CoD.HUDUtility.IsMovieShowing = function(f129_arg0)
	return Engine[0x843B346B80F560F]()
end
CoD.HUDUtility.InitLoadingMovie = function(f130_arg0)
	if CoD.HUDUtility.IsMovieShowing(f130_arg0) then
		return
	end
	local f130_local0 = Engine[0xB87231BF773995E]()
	if LUI.DEV and not Dvar[0x4C70893D7EA01B]:get() and not IsSimulateCT() then
		return
	elseif CoD.isZombie then
		if Engine[0xA55C3ACD0D2BCF0]() or Engine[0xBC62B0E988DCCAF]() or CoD.HUDUtility.IsGameTypeEqualToString("ztutorial") then
			return
		elseif Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]), Enum[0x575E471C039DBD6][0x92BC25E18D296F]) <= 1 then
			local f130_local1 = CoD.BaseUtility.GetMapValue(f130_local0, "introMovie")
			if f130_local1 ~= nil and not Engine[0x498D0E20C7F1218]() then
				Engine[0x828C13077688B82](f130_local1)
			end
			return
		end
	else
		if Dvar[0x867218C7B642957]:get() == "1" and not IsSimulateCT() then
			return
		end
		local f130_local2 = CoD.BaseUtility.GetMapValue(f130_local0, "introMovie")
		local f130_local1 = false
		if not CoD.isMultiplayer then
			local f130_local3 = CoD.isWarzone
		end
		local f130_local4 = false
		local f130_local5 = CoD.isMultiplayer
		local f130_local6 = false
		if CoD.isMultiplayer then
			local f130_local7 = not Engine[0xBC62B0E988DCCAF]()
		end
		if Engine[0x17B32C04C4BE462](Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2])) == Enum[0x8409AA0F01B5DBC][0xB3A1BBF18C0B176] or IsSimulateCT() then
			local f130_local8 = Dvar[0xFF54369D6573B91]:get()
			local f130_local9 = f130_local2
			f130_local2, f130_local6 = CoD.CTUtility.GetLoadingMovie(f130_arg0, f130_local8, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
			if not f130_local2 then
				f130_local2 = f130_local9
			else
				f130_local1 = false
				local f130_local3 = false
				f130_local5 = false
				local f130_local7 = false
			end
		end
		if f130_local2 ~= nil and not Engine[0x498D0E20C7F1218]() then
			if f130_local6 then
				CoD.CTUtility.SetSeenMovie(f130_arg0, "woods_intro")
				local f130_local8 = Engine[0x8DF2E5447F384B9]()
				local f130_local9 = f130_local8:create("isIntroTutorialMovie")
				f130_local9:set(true)
			end
			local f130_local8
			if f130_local2 ~= "wz_open_skyscrapers_loadingmovie" and f130_local2 ~= "wz_open_skyscrapers_alt_loadingmovie" then
				f130_local8 = false
			else
				f130_local8 = true
			end
			if CoD.isPC and f130_local8 and CoD.PCKoreaUtility.ShowKorea15Plus() then
				return
			end
			Engine[0x828C13077688B82](f130_local2, f130_local1, f130_local3, f130_local4, f130_local5, f130_local7)
		end
	end
end
CoD.HUDUtility.InitLoadingImageOrMovie = function(f131_arg0, f131_arg1)
	local f131_local0 = Engine[0xB87231BF773995E]()
	local f131_local1 = MapNameToMapLoadingImage(f131_arg1, f131_local0)
	CoD.HUDUtility.InitLoadingMovie(f131_arg1)
	if CoD.HUDUtility.IsMovieShowing(f131_arg1) then
		Engine[0xB177D654FFB67BE]("ui_useloadingmovie", 1)
		if CoD.BaseUtility.GetMapValue(f131_local0, 0xDB9057B4131C76B) == 1 then
			local f131_local2 = "$white"
		end
		f131_local1 = f131_local2 or "black"
		HUD_DelayLoadMenus()
	else
		Engine[0xB177D654FFB67BE]("ui_useloadingmovie", 0)
		if f131_local1 == nil or f131_local1 == 0x0 then
			f131_local1 = 0xA76163ACBEBF8FA
		end
	end
	f131_arg0:setImage(RegisterImage(f131_local1))
	f131_arg0:setRGB(1, 1, 1)
	f131_arg0:addElement(LUI.UITimer.newElementTimer(16, false, function()
		if f131_arg0.ismp4 and not Engine[0x1F5E6223320CA9D]() then
			f131_arg0:setRGB(0, 0, 0)
			f131_arg0:setImage(LUI.UIImage.GetCachedMaterial("ui_normal"))
			f131_arg0.ismp4 = nil
		elseif f131_arg0.ismp4 == nil and Engine[0x498D0E20C7F1218]() then
			f131_arg0:setupCurrentMoviePlayback()
			f131_arg0.ismp4 = false
		end
	end))
end
CoD.HUDUtility.StartPlay = function(f133_arg0, f133_arg1)
	if not Engine[0xEB086150763B954]() then
		Engine[0xF2281EA762A7527]()
	end
	if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		Engine[0xCF412AB395C7CE](true)
	end
end
CoD.HUDUtility.CachedDidYouKnowString = nil
CoD.HUDUtility.GetDidYouKnowString = function(f134_arg0)
	local f134_local0 = 0x0
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return ""
	elseif CoD.HUDUtility.CachedDidYouKnowString ~= nil then
		return CoD.HUDUtility.CachedDidYouKnowString
	end
	local f134_local1 = Engine[0xE00B2F29271C60B](IsMouseOrKeyboard(f134_arg0) and 0x9F43D523EB31B9F or 0x35D4E2FB34F1BDE)
	local f134_local2 = {}
	if CoD.isPC then
		table.insert(f134_local2, 0x5B46DA0C12D84AC)
	end
	if Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x3EF1485A96433A7]) == true then
		table.insert(f134_local2, 0x2E328480F317FA2)
	elseif CoD.isZombie == true then
		table.insert(f134_local2, 0x895E7245FA207A4)
	elseif CoD.isWarzone then
		table.insert(f134_local2, 0x57E90B1451515A7)
		if Engine[0xB87231BF773995E]() == "wz_escape" then
			table.insert(f134_local2, 0x1016C5A9D98F148)
		else
			table.insert(f134_local2, 0x3708CCE8BE0EDA7)
		end
		if CoD.HUDUtility.IsGameTypeEqualToString("warzone_hot_pursuit") then
			table.insert(f134_local2, 0xEE90511FD901B40)
		elseif CoD.HUDUtility.IsGameTypeWzAmbush() then
			table.insert(f134_local2, 0x6D86EE985C93E1B)
		elseif CoD.HUDUtility.IsGameTypeWzSpectre() then
			table.insert(f134_local2, 0x3296DC50458C5D3)
		elseif CoD.HUDUtility.IsGameTypeWzGroundWar() then
			table.insert(f134_local2, 0x58DDFB8E08B1832)
		end
		if CoD.HUDUtility.IsGameTypeWzRedeploy() then
			table.insert(f134_local2, 0x433E6E576BEB82B)
		end
	else
		if CoD.isMultiplayer then
			table.insert(f134_local2, 0xF6A03A9D0A1840B)
		end
		table.insert(f134_local2, 0xE275796A0D9A90B)
		table.insert(f134_local2, Engine[0xC53F8D38DF9042B](Engine[0x69811927938FCD7]()))
		if Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F]) == true then
			table.insert(f134_local2, 0x7D9D67ACD831310)
		elseif Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x95910ACF90F64AD]) == true then
			table.insert(f134_local2, 0x4B72165F60F5B60)
		end
	end
	if #f134_local2 > 0 then
		local f134_local3 = {}
		local f134_local4 = {}
		local f134_local5 = {}
		local f134_local6 = 0
		local f134_local7 = 0
		for f134_local12, f134_local13 in ipairs(f134_local2) do
			local f134_local14 = f134_local1[f134_local13 .. "Count"]
			local f134_local11 = f134_local1[f134_local13 .. "Weight"]
			if f134_local14 and f134_local14 > 0 then
				f134_local6 = f134_local6 + f134_local14
				if f134_local11 == nil then
					f134_local11 = 1
				end
				f134_local7 = f134_local7 + f134_local11
				f134_local3[#f134_local3 + 1] = f134_local14
				f134_local4[#f134_local4 + 1] = f134_local11
				f134_local5[#f134_local5 + 1] = f134_local13
			end
		end
		if f134_local6 > 0 then
			f134_local8 = 0
			f134_local9 = ""
			for f134_local14, f134_local11 in ipairs(f134_local5) do
				for f134_local15 = 1, f134_local1[f134_local11 .. "Count"], 1 do
					f134_local9 = f134_local11
					if f134_local15 < 10 then
						f134_local9 = f134_local9 .. "0"
					end
					f134_local9 = f134_local9 .. f134_local15
					if f134_local1[f134_local9] == 0xCAE12A542DB4611 or CoD.HUDUtility.IsDidYouKnowAssetValid(f134_local9, f134_local1) == false then
						f134_local8 = f134_local8 + 1
					end
				end
			end
			if f134_local8 == f134_local6 then
				return ""
			end
			f134_local10 = math.random(f134_local7)
			f134_local12 = 0
			f134_local13 = 1
			for f134_local14 = 1, #f134_local4, 1 do
				f134_local12 = f134_local4[f134_local14] + f134_local12
				if f134_local10 < f134_local12 then
					f134_local13 = f134_local14
					break
				end
			end
			f134_local14 = true
			f134_local11 = math.random(f134_local3[f134_local13])
			local f134_local15 = 0
			while f134_local14 and f134_local15 < f134_local3[f134_local13] do
				local f134_local16 = f134_local5[f134_local13]
				if f134_local11 < 10 then
					f134_local16 = f134_local16 .. "0"
				end
				f134_local16 = f134_local16 .. f134_local11
				if f134_local1[f134_local16] ~= 0xCAE12A542DB4611 then
					f134_local14 = false
				end
				f134_local14 = CoD.HUDUtility.IsDidYouKnowAssetValid(f134_local16, f134_local1) == false
				f134_local15 = f134_local15 + 1
				f134_local11 = f134_local11 + 1
				if f134_local3[f134_local13] < f134_local11 then
					f134_local11 = 1
				end
			end
		end
	end
	if f134_local0 == nil or f134_local0 == 0xCAE12A542DB4611 then
		return ""
	end
	CoD.HUDUtility.CachedDidYouKnowString = Engine[0xF9F1239CFD921FE](f134_local0)
	return CoD.HUDUtility.CachedDidYouKnowString
end
CoD.HUDUtility.InitLoadingScreenPlayerListSize = function(f135_arg0)
	if not f135_arg0._initializing then
		f135_arg0._initializing = true
		local f135_local0 = DataSources.LoadingScreenPlayerListTeam1.getCount(f135_arg0)
		local f135_local1 = 4
		if f135_local0 > 8 and f135_local0 < 11 then
			f135_local1 = 5
		elseif f135_local0 > 10 then
			f135_local1 = 6
		end
		if f135_local0 < 4 then
			f135_local1 = f135_local0
		end
		local f135_local2 = 160 * f135_local1 + 2 * (f135_local1 - 1)
		local f135_local3 = 640 - f135_local2 / 2
		f135_arg0:setLeftRight(true, false, f135_local3, f135_local3 + f135_local2)
		f135_arg0._initializing = nil
	end
end
CoD.HUDUtility.HandleWarZoneIcon = function(f136_arg0, f136_arg1)
	local f136_local0 = DataSources.WarData.getModel(f136_arg1)
	local f136_local1 = f136_local0:create("currentZoneIcon")
	f136_local1:set("$blacktransparent")
	local f136_local2 = f136_local0:create("currentZoneTier")
	f136_local2:set(0)
	local f136_local3 = f136_local0:create("currentZoneIconFlashing")
	f136_local3:set(false)
	local f136_local4 = function()
		local f137_local0 = Engine[0xB07E933C9E5CEB1]() / 1000 - f136_local0.currentZoneStartTime:get()
		local f137_local1 = f136_local0.currentZone:get()
		local f137_local2 = nil
		local f137_local3 = false
		if not DataSources.WarData.WarInfo then
			DataSources.WarData.Initialize(f136_arg1)
		end
		if DataSources.WarData.WarInfo.zoneInfo[f137_local1] == nil then
			f136_local1:set("$blacktransparent")
			f136_local3:set(false)
		else
			for f137_local10, f137_local11 in ipairs(DataSources.WarData.WarInfo.zoneInfo[f137_local1].tiers) do
				if f137_local11.time == 0 or f137_local0 < f137_local11.time then
					f136_local1:set(DataSources.WarData.WarInfo.tierInfo[f137_local10].icon)
					f136_local2:set(f137_local10)
					local f137_local7 = f136_local3
					local f137_local8 = f137_local7
					f137_local7 = f137_local7.set
					local f137_local9
					if f137_local11.time <= 0 or f137_local11.time - f137_local0 >= 10 then
					else
						f137_local9 = true
					end
					f137_local9 = false
				end
			end
		end
	end
	f136_arg0:addElement(LUI.UITimer.newElementTimer(500, false, function()
		f136_local4()
	end))
	f136_arg0:subscribeToModel(f136_local0.currentZoneStartTime, f136_local4, true)
	f136_arg0:subscribeToModel(f136_local0.currentZoneStartTime, f136_local4, true)
end
CoD.HUDUtility.FullscreenViewportStart = function(f139_arg0, f139_arg1)
	f139_arg0:setScale(1)
end
CoD.HUDUtility.FullscreenViewportStop = function(f140_arg0, f140_arg1)
	if f140_arg0.scale ~= nil then
		f140_arg0:setScale(f140_arg0.scale)
	else
		f140_arg0:setScale(1)
	end
end
CoD.HUDUtility.ApplySplitscreenScale = function(f141_arg0, f141_arg1)
	f141_arg0.scale = 1
	if Engine[0x7B48C1ABFF0F764]() and 1 < Engine[0xD0149A862599FFD]() then
		f141_arg0.scale = f141_arg1
		f141_arg0:setScale(f141_arg1)
	end
	f141_arg0:registerEventHandler("fullscreen_viewport_start", CoD.HUDUtility.FullscreenViewportStart)
	f141_arg0:registerEventHandler("fullscreen_viewport_stop", CoD.HUDUtility.FullscreenViewportStop)
end
CoD.HUDUtility.IsFogOfWarEnabled = function(f142_arg0)
	local f142_local0
	if Engine[0xDBC2AD5002B261B](0xDE81C0DEB6C0397) ~= 1 then
		f142_local0 = IsDvarValueEqualTo("ui_fogOfWar", true)
	else
		f142_local0 = true
	end
	return f142_local0
end
CoD.HUDUtility.IsRotatingMinimapEnabled = function(f143_arg0)
	local f143_local0
	if Engine[0xB72F603CAC75B3A](f143_arg0, "minimapMode") ~= CoD.HUDUtility.MinimapMode.MODE_ROTATING then
		f143_local0 = not CoD.isWarzone
	else
		f143_local0 = true
	end
	return f143_local0
end
CoD.HUDUtility.IsAnyGameType = function(f144_arg0, ...)
	local f144_local0 = Dvar[0xFF54369D6573B91]:get()
	for f144_local4, f144_local5 in ipairs({
		n = select("#", ...),
		...,
	}) do
		if f144_local5 == f144_local0 then
			return true
		end
	end
	return false
end
CoD.HUDUtility.SetUIActive = function(f145_arg0, f145_arg1)
	Engine[0x9B8C02E7F47BDE3](f145_arg0, f145_arg1)
end
CoD.HUDUtility.ClearHealthBarDelayTimer = function(f146_arg0)
	if f146_arg0.__healthBarAnimDelay then
		f146_arg0.__healthBarAnimDelay:close()
		f146_arg0.__healthBarAnimDelay = nil
	end
end
CoD.HUDUtility.ClearHealthBarLossPulseTimers = function(f147_arg0)
	if f147_arg0.__healthBarLossAnimTimers then
		for f147_local3, f147_local4 in ipairs(LUI.ShallowCopy(f147_arg0.__healthBarLossAnimTimers)) do
			f147_local4:close()
		end
		f147_arg0.__healthBarLossAnimTimers = {}
	end
end
CoD.HUDUtility.ImmediatelyPlayHealthBarLossPulseTimers = function(f148_arg0)
	if f148_arg0.__healthBarLossAnimTimers then
		for f148_local3, f148_local4 in ipairs(LUI.ShallowCopy(f148_arg0.__healthBarLossAnimTimers)) do
			f148_local4:processNow()
		end
		f148_arg0.__healthBarLossAnimTimers = {}
	end
end
CoD.HUDUtility.UpdatePlayerHealthBar = function(f149_arg0, f149_arg1, f149_arg2)
	return function()
		local f150_local0 = function(f151_arg0, f151_arg1, f151_arg2)
			local f151_local0 = LUI.getTableFromPath(f151_arg0, f149_arg0)
			if f151_local0 then
				f151_local0:setShaderVector(1, f151_arg1, f151_arg2, 0, 0)
			end
		end
		local f150_local1 = math.max(CoD.SafeGetModelValue(f149_arg0:getModel(), "health.healthValue") or 0, CoD.SafeGetModelValue(f149_arg0:getModel(), "health.maxHealth") or 0, CoD.SafeGetModelValue(f149_arg0:getModel(), "health.maxHealthRegen") or 0)
		if f150_local1 > 0 then
			local f150_local2 = CoD.HealthUtility.GetSpawnHealthPerBar(nil, f150_local1)
			f150_local0("HealthBar.HealthBackground", f150_local2, 1)
			f150_local0("HealthBar.HealthFill", f150_local2, 1)
			f150_local0("HealthBar.LowHealthFill", f150_local2, 1)
			f150_local0("HealthBar.CleanseBar", f150_local2, 1)
			f150_local0("HealthBar.CleanseBarBG", f150_local2, 1)
			f150_local0("HealthBar.Backer", f150_local2, 1)
		else
			f150_local0("HealthBar.HealthBackground", 0, 0, 0, 0)
			f150_local0("HealthBar.HealthFill", 0, 0, 0, 0)
			f150_local0("HealthBar.LowHealthFill", 0, 0, 0, 0)
			f150_local0("HealthBar.CleanseBar", 0, 0, 0, 0)
			f150_local0("HealthBar.CleanseBarBG", 0, 0, 0, 0)
			f150_local0("HealthBar.Backer", 0, 0, 0, 0)
		end
	end
end
CoD.HUDUtility.UpdateHealthValue = function(f152_arg0, f152_arg1, f152_arg2)
	return function(f153_arg0, f153_arg1, f153_arg2, f153_arg3)
		local f153_local0 = f153_arg0:get() or 0
		local f153_local1 = f153_arg1:get() or 0
		local f153_local2 = math.max(f153_local0, f153_local1, f153_arg2:get() or 0)
		if CoD.isZombie then
			f153_local1 = f153_local2
		end
		if not f152_arg0.__healthBarLossAnimTimers then
			f152_arg0.__healthBarLossAnimTimers = {}
		end
		CoD.HUDUtility.ClearHealthBarDelayTimer(f152_arg0)
		local f153_local3
		if f153_local0 ~= 0 then
			f153_local3 = f153_arg3:get()
			if not f153_local3 then
				f153_local3 = f152_arg0.isOverheadName
				if f153_local3 then
					f153_local3 = not f152_arg0:isOverheadNameRendering()
				end
			end
		else
			f153_local3 = true
		end
		if f153_local3 then
			CoD.HUDUtility.ClearHealthBarLossPulseTimers(f152_arg0)
		end
		local f153_local4 = false
		if f152_arg0.__lastHealth and not f153_local3 then
			local f153_local5 = f152_arg0.__lastHealth - f153_local0
			if f153_local5 <= 0 then
				CoD.HUDUtility.ClearHealthBarLossPulseTimers(f152_arg0)
			else
				CoD.HUDUtility.ImmediatelyPlayHealthBarLossPulseTimers(f152_arg0)
				local f153_local6 = Dvar[0x6B4CD2F5C8ADDBC]:get()
				local f153_local7 = LUI.clamp((f152_arg0.__lastHealth - f153_local1) / f153_local5, 0, 1)
				local f153_local8 = 1 - f153_local7
				local f153_local9 = f153_local6 * f153_local7
				f152_arg0.HealthBar.CleanseBar:beginAnimation(f153_local9, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				if f153_local8 <= 0 or f153_local8 >= 1 then
					f153_local4 = false
				else
					f153_local4 = true
				end
				if f153_local4 then
					f152_arg0.__healthBarAnimDelay = LUI.UITimer.newElementTimer(f153_local9, true, function()
						f152_arg0.HealthBar.HealthFill:beginAnimation(f153_local6 * f153_local8, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f152_arg0.HealthBar.HealthFill:setShaderVector(2, 0, f153_local0 / f153_local2, 0, 1)
						if f152_arg0.HealthBar.LowHealthFill then
							f152_arg0.HealthBar.LowHealthFill:beginAnimation(f153_local6 * f153_local8, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f152_arg0.HealthBar.LowHealthFill:setShaderVector(2, 0, f153_local0 / f153_local2, 0, 1)
						end
					end)
					f152_arg0:addElement(f152_arg0.__healthBarAnimDelay)
				else
					f152_arg0.HealthBar.HealthFill:beginAnimation(f153_local6, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					if f152_arg0.HealthBar.LowHealthFill then
						f152_arg0.HealthBar.LowHealthFill:beginAnimation(f153_local6, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					end
				end
				if f152_arg0.HealthBar.__playHealthBarLossPulse then
					local f153_local10 = CoD.HealthUtility.GetSpawnHealthPerBar(nil, f153_local2)
					local f153_local11 = 1 / f153_local10
					local f153_local12 = Dvar[0x42D42EFC73D739A]:get()
					local f153_local13 = math.ceil(f153_local0 / f153_local12)
					for f153_local14 = math.ceil(f152_arg0.__lastHealth / f153_local12) - 1, f153_local13, -1 do
						local f153_local17 = f153_local14
						local f153_local18 = LUI.UITimer.newElementTimer(f153_local6 * (1 - (f153_local17 * f153_local12 - f153_local0) / (f152_arg0.__lastHealth - f153_local0)), true, function()
							f152_arg0.HealthBar.__playHealthBarLossPulse(f153_local10, f153_local17 * f153_local11, (f153_local17 + 1) * f153_local11)
						end)
						local f153_local19 = f153_local18.close
						f153_local18.close = function()
							table.remove(f152_arg0.__healthBarLossAnimTimers, 1)
							f153_local19(f153_local18)
						end
						table.insert(f152_arg0.__healthBarLossAnimTimers, f153_local18)
						f152_arg0:addElement(f153_local18)
					end
				end
			end
		end
		if f153_local2 == 0 then
			f152_arg0.HealthBar.HealthFill:setShaderVector(2, 0, 0, 0, 0)
			if f152_arg0.HealthBar.LowHealthFill then
				f152_arg0.HealthBar.LowHealthFill:setShaderVector(2, 0, 0, 0, 0)
			end
		elseif f153_local1 < f153_local0 or f153_local4 then
			f152_arg0.HealthBar.HealthFill:setShaderVector(2, 0, f153_local1 / f153_local2, 0, 1)
			if f152_arg0.HealthBar.LowHealthFill then
				f152_arg0.HealthBar.LowHealthFill:setShaderVector(2, 0, f153_local1 / f153_local2, 0, 1)
			end
		else
			f152_arg0.HealthBar.HealthFill:setShaderVector(2, 0, f153_local0 / f153_local2, 0, 1)
			if f152_arg0.HealthBar.LowHealthFill then
				f152_arg0.HealthBar.LowHealthFill:setShaderVector(2, 0, f153_local0 / f153_local2, 0, 1)
			end
		end
		local f153_local5 = 1 - (f153_local2 - f153_local1) / f153_local2
		f152_arg0.HealthBar.CleanseBarBG:setShaderVector(2, f153_local5, 1, 0, 1)
		if f153_local0 < f153_local1 then
			f152_arg0.HealthBar.CleanseBar:setShaderVector(2, f153_local5, f153_local5, 0, 1)
		else
			f152_arg0.HealthBar.CleanseBar:setShaderVector(2, f153_local5, 1 - (f153_local2 - f153_local0) / f153_local2, 0, 1)
		end
		f152_arg0.__lastLastHealth = f152_arg0.__lastHealth
		f152_arg0.__lastHealth = f153_local0
	end
end
CoD.HUDUtility.UpdateHealthWoundBar = function(f157_arg0, f157_arg1, f157_arg2)
	return function(f158_arg0)
		local f158_local0 = CoD.SafeGetModelValue(f157_arg0:getModel(), "health.healthValue")
		local f158_local1 = CoD.SafeGetModelValue(f157_arg0:getModel(), "health.maxHealth")
		local f158_local2 = CoD.SafeGetModelValue(f157_arg0:getModel(), "health.maxHealthRegen")
		if not f158_local2 or f158_local2 == 0 or not f158_local1 then
			f157_arg0.HealthBar.WoundBar:setShaderVector(0, 0, 0, 0, 0)
			f157_arg0.HealthBar.HealthBackground:setShaderVector(2, 0, 1, 0, 1)
		else
			if f158_local2 < f158_local1 then
				if f157_arg0.__lastLastHealth and f157_arg0.__lastLastHealth < f158_local1 then
					f157_arg0.HealthBar.WoundBar:setShaderVector(0, 1 - (f158_local1 - f157_arg0.__lastLastHealth) / f158_local1, 1, 0, 0)
				end
				f157_arg0.HealthBar.WoundBar:beginAnimation(Dvar[0x6B4CD2F5C8ADDBC]:get(), Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
			end
			local f158_local3 = 1 - (f158_local1 - f158_local2) / f158_local1
			f157_arg0.HealthBar.WoundBar:setShaderVector(0, f158_local3, 1, 0, 0)
			f157_arg0.HealthBar.HealthBackground:setShaderVector(2, 0, f158_local3, 0, 1)
		end
		f157_arg0.__lastWoundHealth = f158_local0
	end
end
CoD.HUDUtility.SetupHealthBarAnimCancel = function(f159_arg0, f159_arg1, f159_arg2)
	return function(f160_arg0)
		if f160_arg0:get() then
			f159_arg0.HealthBar.HealthFill:beginAnimation(0)
			if f159_arg0.HealthBar.LowHealthFill then
				f159_arg0.HealthBar.LowHealthFill:beginAnimation(0)
			end
			CoD.HUDUtility.ClearHealthBarLossPulseTimers(f159_arg0)
			CoD.HUDUtility.ClearHealthBarDelayTimer(f159_arg0)
			f160_arg0:set(false)
		end
	end
end
CoD.HUDUtility.UpdateClientHealth = function(f161_arg0, f161_arg1)
	f161_arg0:linkToElementModel(f161_arg0, "clientNum", true, function(model)
		local f162_local0 = model:get()
		if f161_arg0.__selfClientOnly and f162_local0 ~= Engine[0x761955642304848](f161_arg1) then
			return
		elseif f162_local0 == nil or f162_local0 < 0 or f162_local0 >= LuaDefine.MAX_CLIENTS then
			return
		end
		local f162_local1 = CoD.HUDUtility.UpdateHealthValue(f161_arg0, f161_arg1, f162_local0)
		local f162_local2 = CoD.HUDUtility.UpdatePlayerHealthBar(f161_arg0, f161_arg1, f162_local0)
		local f162_local3 = CoD.HUDUtility.UpdateHealthWoundBar(f161_arg0, f161_arg1, f162_local0)
		local f162_local4 = CoD.HUDUtility.SetupHealthBarAnimCancel(f161_arg0, f161_arg1, f162_local0)
		if f161_arg0.__clientHealthCustomSubscriptions then
			for f162_local8, f162_local9 in ipairs(f161_arg0.__clientHealthCustomSubscriptions) do
				f161_arg0:removeSubscription(f162_local9)
			end
		end
		f161_arg0.__clientHealthCustomSubscriptions = {}
		local f162_local5 = Engine[0xE4D2F32833CFA6C](f162_local0)
		f162_local5 = f162_local5:create("health.healthValue")
		local f162_local6 = Engine[0xE4D2F32833CFA6C](f162_local0)
		f162_local6 = f162_local6:create("health.maxHealth")
		local f162_local7 = Engine[0xE4D2F32833CFA6C](f162_local0)
		f162_local7 = f162_local7:create("health.maxHealthRegen")
		local f162_local8 = Engine[0xE4D2F32833CFA6C](f162_local0)
		f162_local8 = f162_local8:create("characterIndex")
		local f162_local9 = Engine[0xE4D2F32833CFA6C](f162_local0)
		f162_local9 = f162_local9:create("cancelHealthBarAnim")
		table.insert(
			f161_arg0.__clientHealthCustomSubscriptions,
			f161_arg0:subscribeToModel(f162_local5, function()
				if CoD.isWarzone then
					local f163_local0 = f162_local5:get() or 0
					local f163_local1 = f162_local7:get() or 0
					local f163_local2
					if f163_local1 < 0 or f163_local1 >= f163_local0 then
						f163_local2 = false
					else
						f163_local2 = true
					end
					if f163_local2 or f161_arg0.__lastHealthBoosted then
						f162_local2()
					end
					f161_arg0.__lastHealthBoosted = f163_local2
				end
				f162_local1(f162_local5, f162_local6, f162_local7, f162_local9)
			end, true)
		)
		table.insert(
			f161_arg0.__clientHealthCustomSubscriptions,
			f161_arg0:subscribeToModel(f162_local6, function()
				f162_local1(f162_local5, f162_local6, f162_local7, f162_local9)
			end, true)
		)
		table.insert(
			f161_arg0.__clientHealthCustomSubscriptions,
			f161_arg0:subscribeToModel(f162_local7, function()
				if CoD.isWarzone then
					local f165_local0 = f162_local5:get() or 0
					local f165_local1 = f162_local7:get() or 0
					local f165_local2 = f161_arg0
					local f165_local3
					if f165_local1 < 0 or f165_local1 >= f165_local0 then
						f165_local3 = false
					else
						f165_local3 = true
					end
					f165_local2.__lastHealthBoosted = f165_local3
				end
				f162_local2()
				f162_local3(f162_local7)
				f162_local1(f162_local5, f162_local6, f162_local7, f162_local9)
			end, true)
		)
		table.insert(
			f161_arg0.__clientHealthCustomSubscriptions,
			f161_arg0:subscribeToModel(f162_local9, function()
				f162_local4(f162_local9)
			end, true)
		)
		table.insert(
			f161_arg0.__clientHealthCustomSubscriptions,
			f161_arg0:subscribeToModel(f162_local8, function(f167_arg0)
				f162_local2()
				f162_local3(f162_local7)
				f162_local1(f162_local5, f162_local6, f162_local7, f162_local9)
			end, true)
		)
	end)
end
CoD.HUDUtility.UpdateSelfClientHealth = function(f168_arg0, f168_arg1)
	f168_arg0.__selfClientOnly = true
	CoD.HUDUtility.UpdateClientHealth(f168_arg0, f168_arg1)
end
CoD.HUDUtility.CharacterPortraitStates = LuaEnum.createEnum("CHARACTER_PORTRAIT_CRITICAL", "CHARACTER_PORTRAIT_NORMAL", "CHARACTER_PORTRAIT_WOUNDED", "CHARACTER_PORTRAIT_BUFFED", "CHARACTER_PORTRAIT_HEALING")
CoD.HUDUtility.GetCachedBloodSettings = function()
	if not CoD.HUDUtility.CachedBloodSettings then
		local f169_local0 = 0x65152CC94D0D5F5
		if IsGametypeSettingsValue("hardcoreMode", 1) then
			f169_local0 = 0x517AFEA8E0801FC
		end
		CoD.HUDUtility.CachedBloodSettings = Engine[0xE00B2F29271C60B](f169_local0)
	end
	return CoD.HUDUtility.CachedBloodSettings
end
CoD.HUDUtility.IsPropHuntHealthCritical = function(f170_arg0, f170_arg1)
	local f170_local0 = f170_arg0:getModel()
	return (f170_local0["health.healthValue"]:get() or 0) <= (f170_local0["health.maxHealth"]:get() or 0) * 0
end
CoD.HUDUtility.IsCharacterInCriticalState = function(f171_arg0, f171_arg1)
	if CoD.HUDUtility.IsGameTypeEqualToString("prop") then
		return CoD.HUDUtility.IsPropHuntHealthCritical(f171_arg0, f171_arg1)
	else
		local f171_local0 = f171_arg0:getModel()
		local f171_local1 = CoD.HUDUtility.GetCachedBloodSettings()
		if f171_local0 and f171_local1 then
			return (f171_local0["health.healthValue"]:get() or 0) <= (f171_local1[0x32A671F0178BB3F] or 0)
		else
			return false
		end
	end
end
CoD.HUDUtility.IsCharacterInWoundedStated = function(f172_arg0, f172_arg1)
	local f172_local0 = f172_arg0:getModel()
	if f172_local0 then
		return (f172_local0["health.maxHealthRegen"]:get() or 0) < (f172_local0["health.maxHealth"]:get() or 0)
	else
		return false
	end
end
CoD.HUDUtility.IsCharacterInBuffedState = function(f173_arg0, f173_arg1)
	local f173_local0 = f173_arg0:getModel()
	if f173_local0 then
		return (f173_local0["health.maxHealth"]:get() or 0) < (f173_local0["health.maxHealthRegen"]:get() or 0)
	else
		return false
	end
end
CoD.HUDUtility.IsCharacterInHealingState = function(f174_arg0, f174_arg1)
	local f174_local0 = DataSources.PlayerAbilities.getModel(f174_arg1)
	if f174_local0.playerGadget1 then
		return f174_local0.playerGadget1.state:get() == Enum[0xF0447219F15F7F3][0x1873A43E9D1620E]
	else
		return false
	end
end
CoD.HUDUtility.DivideByPlayerMaxHealth = function(f175_arg0, f175_arg1, f175_arg2, f175_arg3, f175_arg4, f175_arg5, f175_arg6)
	if f175_arg0.health then
		local f175_local0 = f175_arg0.health.maxHealth
		local f175_local1 = f175_arg0.health.maxHealth:get()
	end
	local f175_local2 = f175_local0 and f175_local1 or 0
	if f175_arg0.health then
		local f175_local3 = f175_arg0.health.maxHealthRegen
		local f175_local4 = f175_arg0.health.maxHealthRegen:get()
	end
	local f175_local5 = math.max(f175_local2, f175_local3 and f175_local4 or 0)
	if f175_local5 and f175_local5 ~= 0 then
		if f175_arg2 == 1 then
			f175_arg3 = f175_arg3 / f175_local5
		elseif f175_arg2 == 2 then
			f175_arg4 = f175_arg4 / f175_local5
		elseif f175_arg2 == 3 then
			f175_arg5 = f175_arg5 / f175_local5
		elseif f175_arg2 == 4 then
			f175_arg6 = f175_arg6 / f175_local5
		end
	end
	return f175_arg3, f175_arg4, f175_arg5, f175_arg6
end
CoD.HUDUtility.InitHealthBoostNotification = function(f176_arg0, f176_arg1, f176_arg2, f176_arg3, f176_arg4)
	local f176_local0 = f176_arg4.__defaultWidth
	local f176_local1 = f176_arg4.__defaultHeight
	f176_arg0:linkToElementModel(f176_arg0, "clientNum", true, function(model)
		local f177_local0 = model:get()
		if f177_local0 < 0 or f177_local0 >= LuaDefine.MAX_CLIENTS then
			return
		elseif f176_arg1.__healthBoostNotificationCustomSubscriptions then
			for f177_local4, f177_local5 in ipairs(f176_arg1.__healthBoostNotificationCustomSubscriptions) do
				f176_arg1:removeSubscription(f177_local5)
			end
		end
		f176_arg1.__healthBoostNotificationCustomSubscriptions = {}
		f176_arg1.__lastMaxHealthRegen = 0
		local f177_local1 = Engine[0xE4D2F32833CFA6C](f177_local0)
		f177_local1 = f177_local1:create("health.maxHealth")
		local f177_local2 = Engine[0xE4D2F32833CFA6C](f177_local0)
		f177_local2 = f177_local2:create("health.maxHealthRegen")
		local f177_local3 = function()
			local f178_local0 = f177_local1:get() or 0
			local f178_local1 = f177_local2:get() or 0
			local f178_local2 = f178_local1 - f176_arg1.__lastMaxHealthRegen
			if f178_local0 < f178_local1 and f178_local2 > 0 then
				local f178_local3 = f176_arg4.new(f176_arg3, f176_arg2, 0, 0, 0, f176_local0, 0, 0, 0, f176_local1)
				if f178_local3.Text then
					f178_local3.Text:setText(Engine[0xF9F1239CFD921FE](0xA0F614541A9DE14, f178_local2))
				end
				f178_local3:registerEventHandler("clip_over", function(element, event)
					element:close()
				end)
				f178_local3:playClip("DefaultClip")
				f176_arg1:addElement(f178_local3)
				f176_arg3:sendInitializationEvents(f176_arg2, f178_local3)
			end
			f176_arg1.__lastMaxHealthRegen = f178_local1
		end
		if not Engine[0xDD333420C49E6D0](f176_arg2, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) and Engine[0x761955642304848](f176_arg2) == f177_local0 then
			table.insert(
				f176_arg1.__healthBoostNotificationCustomSubscriptions,
				f176_arg1:subscribeToModel(f177_local1, function()
					f177_local3()
				end, true)
			)
			table.insert(
				f176_arg1.__healthBoostNotificationCustomSubscriptions,
				f176_arg1:subscribeToModel(f177_local2, function()
					f177_local3()
				end, true)
			)
		end
	end)
end
CoD.HUDUtility.SetupCharacterPortrait = function(f182_arg0, f182_arg1)
	f182_arg0:linkToElementModel(f182_arg0, "clientNum", true, function(model)
		local f183_local0 = model:get()
		if f183_local0 < 0 or f183_local0 >= LuaDefine.MAX_CLIENTS then
			return
		else
			f182_arg0:setModel(Engine[0xE4D2F32833CFA6C](f183_local0), f182_arg1)
		end
	end)
end
DataSources.CTFLevelInfo = {
	getModel = function(f184_arg0)
		local f184_local0 = Engine[0x8DF2E5447F384B9]()
		f184_local0 = f184_local0:create("CTFLevelInfo")
		f184_local0:create("flagCarrierAllies")
		f184_local0:create("flagCarrierAxis")
		f184_local0:create("flagStateAllies")
		f184_local0:create("flagStateAxis")
		f184_local0:create("bestTimeAllies")
		f184_local0:create("bestTimeAxis")
		return f184_local0
	end,
}
DataSources.CharacterSelection = {
	getModel = function(f185_arg0)
		local f185_local0 = Engine[0x4DF5CFBC1771947](f185_arg0)
		return f185_local0:create("CharacterSelection")
	end,
}
DataSources.WaypointObjectiveList = DataSourceHelpers.ListSetup(
	"WaypointObjectiveList",
	function(f186_arg0)
		local f186_local0 = {}
		local f186_local1 = function(f187_arg0, f187_arg1)
			return f187_arg0.properties.objId < f187_arg1.properties.objId
		end
		if not CoD.perController[f186_arg0].waypointObjectiveList then
			CoD.perController[f186_arg0].waypointObjectiveList = {}
		end
		for f186_local5, f186_local6 in pairs(CoD.perController[f186_arg0].waypointObjectiveList) do
			table.insert(f186_local0, {
				models = {
					objectiveModel = f186_local6,
				},
				properties = {
					objective = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f186_arg0, f186_local5)),
					objId = f186_local5,
				},
			})
		end
		table.sort(f186_local0, f186_local1)
		return f186_local0
	end,
	nil,
	nil,
	function(f188_arg0, f188_arg1, f188_arg2)
		if not f188_arg1.__waypointObjectiveListCustomSubscriptions then
			f188_arg1.__waypointObjectiveListCustomSubscriptions = true
			f188_arg1:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f188_arg0), "newObjective"), function(model)
				local f189_local0 = model:get()
				if CoD.HUDUtility.WaypointListObjectiveTypes[Engine[0xBE25B67EDE3D9F9](f188_arg0, f189_local0)] then
					local f189_local1 = CoD.perController[f188_arg0].waypointObjectiveList
					local f189_local2 = Engine[0x4DF5CFBC1771947](f188_arg0)
					f189_local1[f189_local0] = f189_local2["objective" .. f189_local0]
					f188_arg1:updateDataSource(false, false)
				end
			end)
		end
	end
)
DataSources.WaypointObjectiveHardpoint = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	newObjectiveSubscriptions = {},
	prepare = function(f190_arg0, f190_arg1, f190_arg2)
		if not DataSources.WaypointObjectiveHardpoint.preparedForController then
			DataSources.WaypointObjectiveHardpoint.preparedForController = {}
		end
		if not DataSources.WaypointObjectiveHardpoint.subscriptions[f190_arg0] then
			DataSources.WaypointObjectiveHardpoint.subscriptions[f190_arg0] = LUI.UIElement.new()
		end
		DataSources.WaypointObjectiveHardpoint.subscriptions[f190_arg0]:unsubscribeFromAllModels()
		DataSources.WaypointObjectiveHardpoint.preparedForController[f190_arg0] = true
		local f190_local0 = Engine[0x4DF5CFBC1771947](f190_arg0)
		f190_local0 = f190_local0:create("WaypointObjectiveHardpoint")
		f190_local0:create("objectiveModel")
		if not CoD.perController[f190_arg0].waypointObjectiveList then
			CoD.perController[f190_arg0].waypointObjectiveList = {}
			if CoD.HUDUtility.WaypointListObjectiveTypes[Engine[0xBE25B67EDE3D9F9](f190_arg0, 0)] then
				local f190_local1 = f190_local0.objectiveModel
				local f190_local2 = f190_local1
				f190_local1 = f190_local1.set
				local f190_local3 = Engine[0x4DF5CFBC1771947](f190_arg0)
				f190_local1(f190_local2, f190_local3.objective0)
			end
		end
		for f190_local4, f190_local5 in pairs(CoD.perController[f190_arg0].waypointObjectiveList) do
			f190_local0.objectiveModel:set(f190_local5)
			DataSources.WaypointObjectiveHardpoint.subscriptions[f190_arg0]:subscribeToModel(f190_local5.state, function(model)
				if model:get() == Enum[0xA2C16942D15B316][0x54563D60375E060] then
					f190_local0.objectiveModel:set(f190_local5)
					Engine[0x6A489878620F3BC](f190_local0)
				end
			end, false)
		end
		if not DataSources.WaypointObjectiveHardpoint.newObjectiveSubscriptions[f190_arg0] then
			DataSources.WaypointObjectiveHardpoint.newObjectiveSubscriptions[f190_arg0] = LUI.UIElement.new()
			DataSources.WaypointObjectiveHardpoint.newObjectiveSubscriptions[f190_arg0]:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f190_arg0), "newObjective"), function(model)
				local f192_local0 = model:get()
				if CoD.HUDUtility.WaypointListObjectiveTypes[Engine[0xBE25B67EDE3D9F9](f190_arg0, f192_local0)] then
					local f192_local1 = CoD.perController[f190_arg0].waypointObjectiveList
					local f192_local2 = Engine[0x4DF5CFBC1771947](f190_arg0)
					f192_local1[f192_local0] = f192_local2["objective" .. f192_local0]
					DataSources.WaypointObjectiveHardpoint.preparedForController[f190_arg0] = false
					DataSources.WaypointObjectiveHardpoint.prepare(f190_arg0)
				end
			end)
		end
	end,
	getModel = function(f193_arg0)
		if not DataSources.WaypointObjectiveHardpoint.preparedForController or not DataSources.WaypointObjectiveHardpoint.preparedForController[f193_arg0] then
			DataSources.WaypointObjectiveHardpoint.prepare(f193_arg0)
		end
		local f193_local0 = Engine[0x4DF5CFBC1771947](f193_arg0)
		return f193_local0:create("WaypointObjectiveHardpoint")
	end,
}
DataSources.WaypointObjectiveSDDem = {
	preparedForController = {},
	newObjectiveSubscriptions = {},
	waypointObjectiveModelA = nil,
	waypointObjectiveModelB = nil,
	prepare = function(f194_arg0, f194_arg1, f194_arg2)
		if not DataSources.WaypointObjectiveSDDem.preparedForController then
			DataSources.WaypointObjectiveSDDem.preparedForController = {}
		end
		DataSources.WaypointObjectiveSDDem.preparedForController[f194_arg0] = true
		local f194_local0 = Engine[0x4DF5CFBC1771947](f194_arg0)
		f194_local0 = f194_local0:create("WaypointObjectiveSDDem")
		local f194_local1 = DataSources.WaypointObjectiveSDDem.waypointObjectiveModelA
		local f194_local2 = DataSources.WaypointObjectiveSDDem.waypointObjectiveModelB
		if not f194_local1 then
			local f194_local3 = Engine[0x4DF5CFBC1771947](f194_arg0)
			f194_local1 = f194_local3.objective0
		end
		local f194_local3 = f194_local0:create("waypointObjectiveA")
		f194_local3 = f194_local3:create("objectiveModel")
		if f194_local3:set(f194_local1) then
			Engine[0x6A489878620F3BC](f194_local0.waypointObjectiveA)
		end
		if not f194_local2 then
			f194_local3 = Engine[0x4DF5CFBC1771947](f194_arg0)
			f194_local2 = f194_local3.objective0
		end
		f194_local3 = f194_local0:create("waypointObjectiveB")
		f194_local3 = f194_local3:create("objectiveModel")
		if f194_local3:set(f194_local2) then
			Engine[0x6A489878620F3BC](f194_local0.waypointObjectiveB)
		end
		if not DataSources.WaypointObjectiveSDDem.newObjectiveSubscriptions[f194_arg0] then
			DataSources.WaypointObjectiveSDDem.newObjectiveSubscriptions[f194_arg0] = LUI.UIElement.new()
			DataSources.WaypointObjectiveSDDem.newObjectiveSubscriptions[f194_arg0]:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f194_arg0), "newObjective"), function(model)
				local f195_local0 = model:get()
				local f195_local1 = Engine[0xBE25B67EDE3D9F9](f194_arg0, f195_local0)
				if CoD.HUDUtility.SDDemObjectiveTypes[f195_local1] then
					local f195_local2 = Engine[0x4DF5CFBC1771947](f194_arg0)
					f195_local2 = f195_local2["objective" .. f195_local0]
					if not f195_local2.objId then
						local f195_local3 = f195_local2:create("objId")
						f195_local3:set(f195_local0)
					end
					if CoD.HUDUtility.SDDemObjectiveTypes[f195_local1] == "a" then
						DataSources.WaypointObjectiveSDDem.waypointObjectiveModelA = f195_local2
					elseif CoD.HUDUtility.SDDemObjectiveTypes[f195_local1] == "b" then
						DataSources.WaypointObjectiveSDDem.waypointObjectiveModelB = f195_local2
					end
					DataSources.WaypointObjectiveSDDem.preparedForController[f194_arg0] = false
					DataSources.WaypointObjectiveSDDem.prepare(f194_arg0)
				end
			end)
		end
	end,
	getModel = function(f196_arg0)
		if not DataSources.WaypointObjectiveSDDem.preparedForController or not DataSources.WaypointObjectiveSDDem.preparedForController[f196_arg0] then
			DataSources.WaypointObjectiveSDDem.prepare(f196_arg0)
		end
		local f196_local0 = Engine[0x4DF5CFBC1771947](f196_arg0)
		return f196_local0:create("WaypointObjectiveSDDem")
	end,
}
DataSources.BombTimer = {
	getModel = function(f197_arg0)
		local f197_local0 = Engine[0x8DF2E5447F384B9]()
		return f197_local0:create("bombTimer")
	end,
}
DataSourceHelpers.PerControllerDataSourceSetup(
	"WeaponPickupAttachmentList",
	"hudItems.pickupAttachmentList",
	function(f198_arg0, f198_arg1)
		if not f198_arg0.count or not f198_arg0.count:get() then
			local f198_local0 = f198_arg0:create("count")
			f198_local0:set(0)
			for f198_local0 = 0, 5, 1 do
				local f198_local3 = f198_arg0:create("attachment" .. f198_local0)
				f198_local3 = f198_local3:create("image")
				if not f198_local3:get() then
					f198_local3:set(0x7615068F50B3D66)
				end
			end
		end
	end,
	false,
	{
		prepare = function(f199_arg0, f199_arg1, f199_arg2)
			if not f199_arg1._rootModel then
				f199_arg1._rootModel = DataSources.WeaponPickupAttachmentList.getModel(f199_arg0)
			end
		end,
		getCount = function(f200_arg0)
			return f200_arg0._rootModel.count:get()
		end,
		getItem = function(f201_arg0, f201_arg1, f201_arg2)
			return f201_arg1._rootModel["attachment" .. f201_arg2 - 1]
		end,
	}
)
CoD.HUDUtility.DivideByBombTimeLimit = function(f202_arg0, f202_arg1, f202_arg2, f202_arg3, f202_arg4, f202_arg5)
	local f202_local0 = 0
	if IsCampaign() then
		local f202_local1 = DataSources.CPObjectiveTeams.getModel(f202_arg0)
		f202_local1 = f202_local1.myTeam
		if f202_local1 then
			f202_local1 = f202_local1:get()
		end
		local f202_local2 = f202_local1 and f202_local1.radialTimerMaxTime
		if f202_local2 then
			f202_local0 = (f202_local2:get() or 0) * 1000
		end
	elseif IsMultiplayer() then
		local f202_local1 = Engine[0xFC38819EA2193BA]()
		if f202_local1 == "koth" then
			f202_local0 = Engine[0xDBC2AD5002B261B](0x44B81EAB0B09AA1) * 1000
		elseif f202_local1 == "sd" then
			f202_local0 = Engine[0xDBC2AD5002B261B](0x372D52A8CC4D9EE) * 1000
		end
	end
	if f202_local0 == 0 then
		f202_local0 = 1
	end
	if f202_arg1 == 1 then
		f202_arg2 = f202_arg2 / f202_local0
	elseif f202_arg1 == 2 then
		f202_arg3 = f202_arg3 / f202_local0
	elseif f202_arg1 == 3 then
		f202_arg4 = f202_arg4 / f202_local0
	elseif f202_arg1 == 4 then
		f202_arg5 = f202_arg5 / f202_local0
	end
	return f202_arg2, f202_arg3, f202_arg4, f202_arg5
end
DataSources.TeamRoundData = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f203_arg0, f203_arg1, f203_arg2)
		if not DataSources.TeamRoundData.preparedForController then
			DataSources.TeamRoundData.preparedForController = {}
		end
		if not DataSources.TeamRoundData.subscriptions[f203_arg0] then
			DataSources.TeamRoundData.subscriptions[f203_arg0] = LUI.UIElement.new()
		end
		DataSources.TeamRoundData.subscriptions[f203_arg0]:unsubscribeFromAllModels()
		DataSources.TeamRoundData.preparedForController[f203_arg0] = true
		local f203_local0 = CoD.TeamUtility.GetTeamID(f203_arg0)
		local f203_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.team1.roundsWon")
		local f203_local2 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.team2.roundsWon")
		local f203_local3 = DataSources.Factions.getModel(f203_arg0)
		f203_local3 = f203_local3.actualTeam
		local f203_local4 = f203_local1:get()
		local f203_local5 = f203_local2:get()
		if f203_local0 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f203_local4 = f203_local2:get()
			f203_local5 = f203_local1:get()
		end
		local f203_local6 = Engine[0xDBC2AD5002B261B](0x1DE3291D87B1086)
		if f203_local6 == 0 then
			f203_local6 = 1
		end
		local f203_local7 = Engine[0x4DF5CFBC1771947](f203_arg0)
		f203_local7 = f203_local7:create("TeamRoundData")
		local f203_local8 = f203_local7:create("playerTeamRoundsWon")
		f203_local8:set(f203_local4)
		f203_local8 = f203_local7:create("enemyTeamRoundsWon")
		f203_local8:set(f203_local5)
		f203_local8 = f203_local7:create("playerTeamRoundsWonPercent")
		f203_local8:set(f203_local4 / f203_local6)
		f203_local8 = f203_local7:create("enemyTeamRoundsWonPercent")
		f203_local8:set(f203_local5 / f203_local6)
		DataSources.TeamRoundData.subscriptions[f203_arg0]:subscribeToModel(f203_local1, function()
			DataSources.TeamRoundData.preparedForController[f203_arg0] = false
			DataSources.TeamRoundData.prepare(f203_arg0)
		end, false)
		DataSources.TeamRoundData.subscriptions[f203_arg0]:subscribeToModel(f203_local2, function()
			DataSources.TeamRoundData.preparedForController[f203_arg0] = false
			DataSources.TeamRoundData.prepare(f203_arg0)
		end, false)
		DataSources.TeamRoundData.subscriptions[f203_arg0]:subscribeToModel(f203_local3, function()
			DataSources.TeamRoundData.preparedForController[f203_arg0] = false
			DataSources.TeamRoundData.prepare(f203_arg0)
		end, false)
	end,
	getModel = function(f207_arg0)
		if not DataSources.TeamRoundData.preparedForController or not DataSources.TeamRoundData.preparedForController[f207_arg0] then
			DataSources.TeamRoundData.prepare(f207_arg0)
		end
		local f207_local0 = Engine[0x4DF5CFBC1771947](f207_arg0)
		return f207_local0:create("TeamRoundData")
	end,
}
DataSources.TeamLivesData = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f208_arg0, f208_arg1, f208_arg2)
		if not DataSources.TeamLivesData.preparedForController then
			DataSources.TeamLivesData.preparedForController = {}
		end
		if not DataSources.TeamLivesData.subscriptions[f208_arg0] then
			DataSources.TeamLivesData.subscriptions[f208_arg0] = LUI.UIElement.new()
		end
		DataSources.TeamLivesData.subscriptions[f208_arg0]:unsubscribeFromAllModels()
		DataSources.TeamLivesData.preparedForController[f208_arg0] = true
		local f208_local0 = CoD.CodCasterUtility.GetStandardOrCodCasterTeam(f208_arg0)
		local f208_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.team1.livesCount")
		local f208_local2 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.team1.noRespawnsLeft")
		local f208_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.team2.livesCount")
		local f208_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "hudItems.team2.noRespawnsLeft")
		local f208_local5 = DataSources.Factions.getModel(f208_arg0)
		f208_local5 = f208_local5.actualTeam
		local f208_local6 = f208_local1:get()
		local f208_local7 = f208_local2:get() ~= 0
		local f208_local8 = f208_local3:get()
		local f208_local9 = f208_local4:get() ~= 0
		local f208_local10 = Engine[0xDBC2AD5002B261B](0x41EFF30F353B20F)
		if f208_local10 == 0 then
			f208_local10 = 1
		end
		local f208_local11 = Engine[0x4DF5CFBC1771947](f208_arg0)
		f208_local11 = f208_local11:create("TeamLivesData")
		local f208_local12 = Engine[0xA798E4552F5E872](f208_local11, "playerTeamLives")
		local f208_local13 = Engine[0xA798E4552F5E872](f208_local11, "playerTeamLivesPercent")
		local f208_local14 = Engine[0xA798E4552F5E872](f208_local11, "playerTeamNoRespawnsLeft")
		local f208_local15 = Engine[0xA798E4552F5E872](f208_local11, "enemyTeamLives")
		local f208_local16 = Engine[0xA798E4552F5E872](f208_local11, "enemyTeamLivesPercent")
		local f208_local17 = Engine[0xA798E4552F5E872](f208_local11, "enemyTeamNoRespawnsLeft")
		if f208_local0 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f208_local12:set(f208_local6)
			f208_local13:set(f208_local6 / f208_local10)
			f208_local14:set(f208_local7)
			f208_local15:set(f208_local8)
			f208_local16:set(f208_local8 / f208_local10)
			f208_local17:set(f208_local9)
		else
			f208_local12:set(f208_local8)
			f208_local13:set(f208_local8 / f208_local10)
			f208_local14:set(f208_local9)
			f208_local15:set(f208_local6)
			f208_local16:set(f208_local6 / f208_local10)
			f208_local17:set(f208_local7)
		end
		DataSources.TeamLivesData.subscriptions[f208_arg0]:subscribeToModel(f208_local1, function()
			DataSources.TeamLivesData.preparedForController[f208_arg0] = false
			DataSources.TeamLivesData.prepare(f208_arg0)
		end, false)
		DataSources.TeamLivesData.subscriptions[f208_arg0]:subscribeToModel(f208_local3, function()
			DataSources.TeamLivesData.preparedForController[f208_arg0] = false
			DataSources.TeamLivesData.prepare(f208_arg0)
		end, false)
		DataSources.TeamLivesData.subscriptions[f208_arg0]:subscribeToModel(f208_local5, function()
			DataSources.TeamLivesData.preparedForController[f208_arg0] = false
			DataSources.TeamLivesData.prepare(f208_arg0)
		end, false)
		DataSources.TeamLivesData.subscriptions[f208_arg0]:subscribeToModel(f208_local2, function()
			DataSources.TeamLivesData.preparedForController[f208_arg0] = false
			DataSources.TeamLivesData.prepare(f208_arg0)
		end, false)
		DataSources.TeamLivesData.subscriptions[f208_arg0]:subscribeToModel(f208_local4, function()
			DataSources.TeamLivesData.preparedForController[f208_arg0] = false
			DataSources.TeamLivesData.prepare(f208_arg0)
		end, false)
	end,
	getModel = function(f214_arg0)
		if not DataSources.TeamLivesData.preparedForController or not DataSources.TeamLivesData.preparedForController[f214_arg0] then
			DataSources.TeamLivesData.prepare(f214_arg0)
		end
		local f214_local0 = Engine[0x4DF5CFBC1771947](f214_arg0)
		return f214_local0:create("TeamLivesData")
	end,
}
CoD.HUDUtility.GetRoundPipsDatasourceTable = function(f215_arg0, f215_arg1)
	local f215_local0 = Engine[0xDBC2AD5002B261B](0x1DE3291D87B1086)
	local f215_local1 = Engine[0x8DF2E5447F384B9]()
	f215_local1 = f215_local1.hudItems.team1.roundsWon:get()
	if f215_arg0 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		local f215_local2 = Engine[0x8DF2E5447F384B9]()
		f215_local1 = f215_local2.hudItems.team2.roundsWon:get()
	end
	local f215_local2 = Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC]
	local f215_local3 = Engine[0x4DF5CFBC1771947](f215_arg1)
	if f215_local3.gameScore.winningTeam then
		f215_local3 = Engine[0x4DF5CFBC1771947](f215_arg1)
		f215_local2 = f215_local3.gameScore.winningTeam:get()
	end
	f215_local3 = DataSources.Factions.getModel(f215_arg1)
	local f215_local4
	if f215_arg0 == f215_local3.actualTeam:get() then
		f215_local4 = CoD.TeamUtility.GetColorSetFriendlyColor(f215_arg1, f215_arg0)
		if not f215_local4 then
		else
			local f215_local5 = {}
			for f215_local6 = 1, f215_local0, 1 do
				local f215_local9 = table.insert
				local f215_local10 = f215_local5
				local f215_local11 = {}
				local f215_local12 = {
					isComplete = f215_local6 <= f215_local1,
				}
				local f215_local13
				if f215_local1 ~= f215_local6 or f215_local2 ~= f215_arg0 then
					f215_local13 = false
				else
					f215_local13 = true
				end
				f215_local12.justComplete = f215_local13
				f215_local12.teamId = f215_arg0
				f215_local12.teamColor = CoD.ColorUtility.ConvertColor(f215_local4.r, f215_local4.g, f215_local4.b)
				f215_local11.models = f215_local12
				f215_local9(f215_local10, f215_local11)
			end
			return f215_local5
		end
	end
	f215_local4 = CoD.TeamUtility.GetColorSetEnemyColor(f215_arg1, f215_arg0)
end
CoD.HUDUtility.UpdateTeamPipsDatasource = function(f216_arg0, f216_arg1, f216_arg2)
	if not f216_arg1.__customUpdateTeamPipsSubscriptions then
		f216_arg1.__customUpdateTeamPipsSubscriptions = true
		local f216_local0 = f216_arg1
		local f216_local1 = f216_arg1.subscribeToModel
		local f216_local2 = Engine[0x8DF2E5447F384B9]()
		f216_local1(f216_local0, f216_local2.hudItems.team1.roundsWon, function()
			f216_arg1:updateDataSource(false, false)
		end, false)
		f216_local0 = f216_arg1
		f216_local1 = f216_arg1.subscribeToModel
		f216_local2 = Engine[0x8DF2E5447F384B9]()
		f216_local1(f216_local0, f216_local2.hudItems.team2.roundsWon, function()
			f216_arg1:updateDataSource(false, false)
		end, false)
		f216_local0 = f216_arg1
		f216_local1 = f216_arg1.subscribeToModel
		f216_local2 = DataSources.Factions.getModel(f216_arg0)
		f216_local1(f216_local0, f216_local2.actualTeam, function(f219_arg0)
			f216_arg1:updateDataSource(false, false)
		end, false)
		f216_local1 = Engine[0x4DF5CFBC1771947](f216_arg0)
		f216_local1 = f216_local1:create("gameScore")
		f216_local1:create("currentState")
		f216_local0 = f216_arg1
		f216_local1 = f216_arg1.subscribeToModel
		f216_local2 = Engine[0x4DF5CFBC1771947](f216_arg0)
		f216_local1(f216_local0, f216_local2.gameScore.currentState, function()
			f216_arg1:updateDataSource(false, false)
		end, false)
	end
end
DataSources.PlayerTeamRoundPips = DataSourceHelpers.ListSetup("PlayerTeamRoundPips", function(f221_arg0)
	local f221_local0 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
	if not IsCodCaster(f221_arg0) then
		local f221_local1 = DataSources.Factions.getModel(f221_arg0)
		f221_local1 = f221_local1.actualTeam:get()
		if f221_local1 then
			f221_local0 = f221_local1
		end
	end
	return CoD.HUDUtility.GetRoundPipsDatasourceTable(f221_local0, f221_arg0)
end, nil, nil, CoD.HUDUtility.UpdateTeamPipsDatasource)
DataSources.EnemyTeamRoundPips = DataSourceHelpers.ListSetup("EnemyTeamRoundPips", function(f222_arg0)
	local f222_local0 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
	if not IsCodCaster(f222_arg0) then
		local f222_local1 = DataSources.Factions.getModel(f222_arg0)
		if f222_local0 == f222_local1.actualTeam:get() then
			f222_local0 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
		end
	end
	return CoD.HUDUtility.GetRoundPipsDatasourceTable(f222_local0, f222_arg0)
end, nil, nil, CoD.HUDUtility.UpdateTeamPipsDatasource)
CoD.HUDUtility.EnterClipDropState = function(f223_arg0, f223_arg1)
	if not f223_arg0.clipAmmoRequiredForBulletDrop then
		return false
	else
		local f223_local0 = DataSources.CurrentWeapon.getModel(f223_arg1)
		if f223_arg0.clipAmmoRequiredForBulletDrop < f223_local0.ammoInClip:get() then
			return false
		else
			f223_local0 = DataSources.CurrentWeapon.getModel(f223_arg1)
			if f223_local0.weaponReloadState:get() ~= Enum[0x64D865FA8BC442C][0x64C9F4BBF9F8C1A] then
				return false
			else
				return true
			end
		end
	end
end
DataSources.CurrentWeaponStockAmmo = DataSourceHelpers.ListSetup("CurrentWeaponStockAmmo", function(f224_arg0, f224_arg1)
	local f224_local0 = {}
	local f224_local1 = DataSources.CurrentWeapon.getModel(f224_arg0)
	if not f224_arg1._maxPips then
		f224_arg1._maxPips = f224_arg1.hCount * f224_arg1.vCount
	end
	if f224_local1 and f224_local1.clipMaxAmmo and f224_local1.ammoStock then
		local f224_local2 = f224_local1.ammoStock:get() or 0
		local f224_local3 = math.max(1, f224_local1.clipMaxAmmo:get() or 1)
		local f224_local4 = math.ceil(f224_local2 / f224_local3)
		for f224_local5 = 1, math.min(f224_arg1._maxPips, f224_local4), 1 do
			local f224_local8 = 1
			local f224_local9 = -1
			if f224_local5 == f224_local4 then
				local f224_local10 = f224_local3 * (f224_local5 - 1)
				f224_local8 = (f224_local2 - f224_local10) / f224_local3
				if f224_local4 <= f224_arg1._maxPips then
					f224_local9 = f224_local3 - f224_local2 - f224_local10
				end
			end
			local f224_local10 = table.insert
			local f224_local11 = f224_local0
			local f224_local12 = {}
			local f224_local13 = {}
			local f224_local14
			if f224_local5 ~= f224_arg1._maxPips or f224_arg1._maxPips >= f224_local4 then
				f224_local14 = false
			else
				f224_local14 = true
			end
			f224_local13.hasExtra = f224_local14
			f224_local13.percentage = f224_local8
			f224_local12.models = f224_local13
			f224_local12.properties = {
				clipAmmoRequiredForBulletDrop = f224_local9,
			}
			f224_local10(f224_local11, f224_local12)
		end
	end
	return f224_local0
end, false)
DataSources.CurrentWeaponSingleShotAmmo = DataSourceHelpers.ListSetup("CurrentWeaponSingleShotAmmo", function(f225_arg0, f225_arg1)
	local f225_local0 = {}
	local f225_local1 = DataSources.CurrentWeapon.getModel(f225_arg0)
	if not f225_arg1._maxPips then
		f225_arg1._maxPips = f225_arg1.hCount * f225_arg1.vCount
		f225_arg1._maxHCount = f225_arg1.hCount
		f225_arg1._maxVCount = f225_arg1.vCount
	end
	if f225_local1 and f225_local1.ammoStock then
		local f225_local2 = f225_local1.ammoStock:get() or 0
		local f225_local3 = f225_local2
		f225_arg1.hCount = math.min(f225_arg1._maxHCount, math.ceil(f225_local2 / f225_arg1._maxVCount))
		for f225_local4 = 1, f225_arg1.hCount * f225_arg1.vCount, 1 do
			local f225_local7 = math.ceil(f225_local4 / f225_arg1.vCount)
			local f225_local8 = (f225_local4 - (f225_local7 - 1) * f225_arg1.vCount - 1) * f225_arg1.hCount + f225_local7
			local f225_local9 = {}
			local f225_local10 = {}
			local f225_local11
			if f225_local4 ~= f225_arg1._maxPips or f225_arg1._maxPips >= f225_local3 then
				f225_local11 = false
			else
				f225_local11 = true
			end
			f225_local10.hasExtra = f225_local11
			f225_local10.hidden = f225_local3 < f225_local4
			f225_local9.models = f225_local10
			f225_local0[f225_local8] = f225_local9
		end
	end
	return f225_local0
end, false)
DataSources.PlayerTeamScoreBar = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f226_arg0, f226_arg1, f226_arg2)
		if not DataSources.PlayerTeamScoreBar.preparedForController then
			DataSources.PlayerTeamScoreBar.preparedForController = {}
		end
		if not DataSources.PlayerTeamScoreBar.subscriptions[f226_arg0] then
			DataSources.PlayerTeamScoreBar.subscriptions[f226_arg0] = LUI.UIElement.new()
		end
		DataSources.PlayerTeamScoreBar.subscriptions[f226_arg0]:unsubscribeFromAllModels()
		DataSources.PlayerTeamScoreBar.preparedForController[f226_arg0] = true
		local f226_local0 = Engine[0x4DF5CFBC1771947](f226_arg0)
		local f226_local1 = f226_local0.gameScore.playerScore:get()
		local f226_local2 = Engine[0xDBC2AD5002B261B](0x4357EFB34352AA4)
		local f226_local3 = 0
		if f226_local2 > 0 then
			f226_local3 = f226_local1 / f226_local2
		end
		local f226_local4 = Engine[0x4DF5CFBC1771947](f226_arg0)
		f226_local4 = f226_local4:create("PlayerTeamScoreBar")
		local f226_local5 = f226_local4:create("scorePercent")
		f226_local5:set(f226_local3)
		DataSources.PlayerTeamScoreBar.subscriptions[f226_arg0]:subscribeToModel(f226_local0.gameScore.playerScore, function()
			DataSources.PlayerTeamScoreBar.preparedForController[f226_arg0] = false
			DataSources.PlayerTeamScoreBar.prepare(f226_arg0)
		end, false)
	end,
	getModel = function(f228_arg0)
		if not DataSources.PlayerTeamScoreBar.preparedForController or not DataSources.PlayerTeamScoreBar.preparedForController[f228_arg0] then
			DataSources.PlayerTeamScoreBar.prepare(f228_arg0)
		end
		local f228_local0 = Engine[0x4DF5CFBC1771947](f228_arg0)
		return f228_local0:create("PlayerTeamScoreBar")
	end,
}
DataSources.EnemyTeamScoreBar = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f229_arg0, f229_arg1, f229_arg2)
		if not DataSources.EnemyTeamScoreBar.preparedForController then
			DataSources.EnemyTeamScoreBar.preparedForController = {}
		end
		if not DataSources.EnemyTeamScoreBar.subscriptions[f229_arg0] then
			DataSources.EnemyTeamScoreBar.subscriptions[f229_arg0] = LUI.UIElement.new()
		end
		DataSources.EnemyTeamScoreBar.subscriptions[f229_arg0]:unsubscribeFromAllModels()
		DataSources.EnemyTeamScoreBar.preparedForController[f229_arg0] = true
		local f229_local0 = Engine[0x4DF5CFBC1771947](f229_arg0)
		local f229_local1 = f229_local0.gameScore.enemyScore:get()
		local f229_local2 = Engine[0xDBC2AD5002B261B](0x4357EFB34352AA4)
		local f229_local3 = 0
		if f229_local2 > 0 then
			f229_local3 = f229_local1 / f229_local2
		end
		local f229_local4 = Engine[0x4DF5CFBC1771947](f229_arg0)
		f229_local4 = f229_local4:create("EnemyTeamScoreBar")
		local f229_local5 = f229_local4:create("scorePercent")
		f229_local5:set(f229_local3)
		DataSources.EnemyTeamScoreBar.subscriptions[f229_arg0]:subscribeToModel(f229_local0.gameScore.enemyScore, function()
			DataSources.EnemyTeamScoreBar.preparedForController[f229_arg0] = false
			DataSources.EnemyTeamScoreBar.prepare(f229_arg0)
		end, false)
	end,
	getModel = function(f231_arg0)
		if not DataSources.EnemyTeamScoreBar.preparedForController or not DataSources.EnemyTeamScoreBar.preparedForController[f231_arg0] then
			DataSources.EnemyTeamScoreBar.prepare(f231_arg0)
		end
		local f231_local0 = Engine[0x4DF5CFBC1771947](f231_arg0)
		return f231_local0:create("EnemyTeamScoreBar")
	end,
}
CoD.HUDUtility.AdjustElementWidthByRoundsPlayed = function(f232_arg0, f232_arg1)
	local f232_local0 = Engine[0xDBC2AD5002B261B](0x1BE65BD13DB0766)
	if f232_local0 > 0 then
		if not f232_arg0.__widthByRoundsPlayedOriginalWidth then
			local f232_local1, f232_local2, f232_local3, f232_local4 = f232_arg0:getLocalLeftRight()
			f232_arg0.__widthByRoundsPlayedOriginalWidth = f232_local4 - f232_local3
		end
		f232_arg0:setWidth(f232_arg0.__widthByRoundsPlayedOriginalWidth * math.min(Engine[0x9672E391E0BF3DD](f232_arg1) + 1, f232_local0) / f232_local0)
	end
end
CoD.HUDUtility.IsFirstRound = function(f233_arg0)
	local f233_local0 = Engine[0x9672E391E0BF3DD](f233_arg0)
	local f233_local1
	if f233_local0 and f233_local0 ~= 0 then
		f233_local1 = false
	else
		f233_local1 = true
	end
	return f233_local1
end
CoD.HUDUtility.IsWZCustomGame = function(f234_arg0)
	local f234_local0
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f234_local0 = Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x5E90ACB801E4A3D])
	else
		f234_local0 = false
	end
	return f234_local0
end
CoD.HUDUtility.AddTeamSize = function(f235_arg0, f235_arg1, f235_arg2)
	local f235_local0 = Engine[0x4DF5CFBC1771947](f235_arg0)
	local f235_local1 = nil
	if f235_arg1 == 0 then
		f235_local1 = f235_local0:create("PlayerTeamLastLivesData")
	else
		f235_local1 = f235_local0:create("EnemyTeamLastLivesData")
	end
	local f235_local2 = f235_local1:create("teamSize")
	local f235_local3 = f235_local2:get()
	local f235_local4
	if not CoD.HUDUtility.IsGameTypeEqualToString("control") then
		f235_local4 = not CoD.HUDUtility.IsGameTypeEqualToString("svz")
	else
		f235_local4 = false
	end
	local f235_local5
	if f235_local4 then
		f235_local5 = 0
		if not f235_local5 then
		else
			return f235_local3 + f235_local5
		end
	end
	f235_local5 = f235_arg2
end
CoD.HUDUtility.GetMaxOneInChamberLives = function()
	return Engine[0xDBC2AD5002B261B](0x7AE47E47CEB98E3) or 1
end
CoD.HUDUtility.GetMaxOneInChamberBullets = function()
	return 3
end
CoD.HUDUtility.TooMuchAmmo = function(f238_arg0, f238_arg1)
	local f238_local0 = DataSources.CurrentWeapon.getModel(f238_arg0)
	return f238_arg1 < (f238_local0.ammoStock:get() or 0) + (f238_local0.ammoInClip:get() or 0)
end
CoD.HUDUtility.WeaponAmmoClipStockCombined = function(f239_arg0, f239_arg1)
	local f239_local0 = CoD.HUDUtility.GetMaxOneInChamberBullets()
	local f239_local1 = DataSources.CurrentWeapon.getModel(f239_arg0)
	return tostring((f239_local1.ammoStock:get() or 0) + (f239_local1.ammoInClip:get() or 0))
end
CoD.HUDUtility.UpdateOICLifeDatasource = function(f240_arg0, f240_arg1, f240_arg2)
	if not f240_arg1.__customUpdateOICLifeDatasource then
		f240_arg1.__customUpdateOICLifeDatasource = true
		local f240_local0 = f240_arg1
		local f240_local1 = f240_arg1.subscribeToModel
		local f240_local2 = DataSources.HUDItems.getModel(f240_arg0)
		f240_local1(f240_local0, f240_local2:create("playerLivesCount"), function()
			f240_arg1:updateDataSource(false, false)
		end, false)
	end
end
DataSources.OneInTheChamberLifeList = DataSourceHelpers.ListSetup("OneInTheChamberLifeList", function(f242_arg0)
	local f242_local0 = {}
	local f242_local1 = CoD.HUDUtility.GetMaxOneInChamberLives()
	local f242_local2 = DataSources.HUDItems.getModel(f242_arg0)
	f242_local2 = f242_local2:create("playerLivesCount")
	f242_local2 = f242_local2:get()
	local f242_local3 = {
		models = {
			on = true,
		},
	}
	local f242_local4 = {
		models = {
			on = false,
		},
	}
	for f242_local5 = 1, f242_local2, 1 do
		local f242_local8 = f242_local5
		table.insert(f242_local0, f242_local3)
	end
	local f242_local5 = math.max(0, f242_local1 - f242_local2)
	for f242_local6 = 1, f242_local5, 1 do
		local f242_local9 = f242_local6
		table.insert(f242_local0, f242_local4)
	end
	return f242_local0
end, nil, nil, CoD.HUDUtility.UpdateOICLifeDatasource)
CoD.HUDUtility.UpdateOICBulletDatasource = function(f243_arg0, f243_arg1, f243_arg2)
	if not f243_arg1.__customUpdateOICBulletDatasource then
		f243_arg1.__customUpdateOICBulletDatasource = true
		local f243_local0 = DataSources.CurrentWeapon.getModel(f243_arg0)
		local f243_local1 = f243_local0.ammoStock:get()
		local f243_local2 = f243_local0.ammoInClip:get()
		f243_arg1:subscribeToModel(f243_local0, function()
			f243_arg1:updateDataSource(false, false)
		end, false)
		f243_arg1:subscribeToModel(f243_local0.ammoStock, function()
			f243_arg1:updateDataSource(false, false)
		end, false)
		f243_arg1:subscribeToModel(f243_local0.ammoInClip, function()
			f243_arg1:updateDataSource(false, false)
		end, false)
	end
end
DataSources.OneInTheChamberBulletList = DataSourceHelpers.ListSetup("OneInTheChamberBulletList", function(f247_arg0)
	local f247_local0 = {}
	local f247_local1 = CoD.HUDUtility.GetMaxOneInChamberBullets()
	local f247_local2 = DataSources.CurrentWeapon.getModel(f247_arg0)
	local f247_local3 = (f247_local2.ammoStock:get() or 0) + (f247_local2.ammoInClip:get() or 0)
	local f247_local4 = {
		models = {
			on = true,
		},
	}
	local f247_local5 = {
		models = {
			on = false,
		},
	}
	for f247_local6 = 1, f247_local3, 1 do
		local f247_local9 = f247_local6
		table.insert(f247_local0, f247_local4)
	end
	local f247_local6 = math.max(0, f247_local1 - f247_local3)
	for f247_local7 = 1, f247_local6, 1 do
		local f247_local10 = f247_local7
		table.insert(f247_local0, f247_local5)
	end
	return f247_local0
end, nil, nil, CoD.HUDUtility.UpdateOICBulletDatasource)
CoD.HUDUtility.WeaponAmmoToWipeProgress = function(f248_arg0, f248_arg1, f248_arg2, f248_arg3, f248_arg4)
	local f248_local0 = CoD.HUDUtility.GetMaxOneInChamberBullets()
	local f248_local1 = DataSources.CurrentWeapon.getModel(f248_arg0)
	local f248_local2 = f248_local1.ammoStock:get()
	local f248_local3 = f248_local1.ammoInClip:get()
	if not f248_local2 or not f248_local3 then
		return 0, 0, 0, 1
	else
		return 0, (f248_local2 + f248_local3) / f248_local0, 0, 1
	end
end
CoD.HUDUtility.SetLastLivesDataModelValues = function(f249_arg0, f249_arg1)
	local f249_local0 = 0
	local f249_local1 = 0
	local f249_local2 = false
	local f249_local3 = Engine[0x8DF2E5447F384B9]()
	if f249_arg1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		f249_local0 = f249_local3.hudItems.team1.livesCount:get()
		f249_local1 = f249_local3.scoreboard.team1.count:get()
		f249_local2 = f249_local3.hudItems.team1.noRespawnsLeft:get() ~= 0
	elseif f249_arg1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		f249_local0 = f249_local3.hudItems.team2.livesCount:get()
		f249_local1 = f249_local3.scoreboard.team2.count:get()
		f249_local2 = f249_local3.hudItems.team2.noRespawnsLeft:get() ~= 0
	end
	local f249_local4 = f249_arg0:create("numPlayersAlive")
	f249_local4:set(f249_local0)
	f249_local4 = f249_arg0:create("teamSize")
	f249_local4:set(f249_local1)
	f249_local4 = f249_arg0:create("noRespawnsLeft")
	f249_local4:set(f249_local2)
	f249_local4 = f249_arg0:create("team")
	f249_local4:set(f249_arg1)
end
CoD.HUDUtility.SetLastLivesDataSubscriptions = function(f250_arg0, f250_arg1, f250_arg2)
	local f250_local0 = DataSources[f250_arg1]
	if f250_local0 then
		local f250_local1 = function()
			f250_local0.preparedForController[f250_arg0] = false
			f250_local0.prepare(f250_arg0)
		end
		local f250_local2 = f250_local0.subscriptions[f250_arg0]
		local f250_local3 = f250_local2
		f250_local2 = f250_local2.subscribeToModel
		local f250_local4 = DataSources.Factions.getModel(f250_arg0)
		f250_local2(f250_local3, f250_local4.actualTeam, f250_local1, false)
		f250_local2 = Engine[0x8DF2E5447F384B9]()
		if f250_arg2 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local2.hudItems.team1.livesCount, f250_local1, false)
			f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local2.scoreboard.team1.count, f250_local1, false)
			f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local2.hudItems.team1.noRespawnsLeft, f250_local1, false)
		elseif f250_arg2 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local2.hudItems.team2.livesCount, f250_local1, false)
			f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local2.scoreboard.team2.count, f250_local1, false)
			f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local2.hudItems.team2.noRespawnsLeft, f250_local1, false)
		end
		f250_local3 = Engine[0x4DF5CFBC1771947](f250_arg0)
		f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local3.hudItems.colorBlindSensitiveFriendlyColor, f250_local1, false)
		f250_local0.subscriptions[f250_arg0]:subscribeToModel(f250_local3.hudItems.colorBlindSensitiveEnemyColor, f250_local1, false)
	end
end
DataSources.PlayerTeamLastLivesData = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f252_arg0, f252_arg1, f252_arg2)
		if not DataSources.PlayerTeamLastLivesData.preparedForController then
			DataSources.PlayerTeamLastLivesData.preparedForController = {}
		end
		if not DataSources.PlayerTeamLastLivesData.subscriptions[f252_arg0] then
			DataSources.PlayerTeamLastLivesData.subscriptions[f252_arg0] = LUI.UIElement.new()
		end
		DataSources.PlayerTeamLastLivesData.subscriptions[f252_arg0]:unsubscribeFromAllModels()
		DataSources.PlayerTeamLastLivesData.preparedForController[f252_arg0] = true
		local f252_local0 = CoD.CodCasterUtility.GetStandardOrCodCasterTeam(f252_arg0)
		local f252_local1 = Engine[0x4DF5CFBC1771947](f252_arg0)
		local f252_local2 = Engine[0x4DF5CFBC1771947](f252_arg0)
		f252_local2 = f252_local2:create("PlayerTeamLastLivesData")
		local f252_local3 = f252_local2:create("teamColor")
		local f252_local4 = f252_local3
		f252_local3 = f252_local3.set
		local f252_local5 = Engine[0x4DF5CFBC1771947](f252_arg0)
		f252_local3(f252_local4, f252_local5.hudItems.colorBlindSensitiveFriendlyColor:get())
		CoD.HUDUtility.SetLastLivesDataModelValues(f252_local2, f252_local0)
		CoD.HUDUtility.SetLastLivesDataSubscriptions(f252_arg0, "PlayerTeamLastLivesData", f252_local0)
	end,
	getModel = function(f253_arg0)
		if not DataSources.PlayerTeamLastLivesData.preparedForController or not DataSources.PlayerTeamLastLivesData.preparedForController[f253_arg0] then
			DataSources.PlayerTeamLastLivesData.prepare(f253_arg0)
		end
		local f253_local0 = Engine[0x4DF5CFBC1771947](f253_arg0)
		return f253_local0:create("PlayerTeamLastLivesData")
	end,
}
DataSources.EnemyTeamLastLivesData = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f254_arg0, f254_arg1, f254_arg2)
		if not DataSources.EnemyTeamLastLivesData.preparedForController then
			DataSources.EnemyTeamLastLivesData.preparedForController = {}
		end
		if not DataSources.EnemyTeamLastLivesData.subscriptions[f254_arg0] then
			DataSources.EnemyTeamLastLivesData.subscriptions[f254_arg0] = LUI.UIElement.new()
		end
		DataSources.EnemyTeamLastLivesData.subscriptions[f254_arg0]:unsubscribeFromAllModels()
		DataSources.EnemyTeamLastLivesData.preparedForController[f254_arg0] = true
		local f254_local0 = CoD.CodCasterUtility.GetStandardOrCodCasterTeam(f254_arg0)
		local f254_local1 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
		if f254_local1 == f254_local0 then
			f254_local1 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
		end
		local f254_local2 = Engine[0x4DF5CFBC1771947](f254_arg0)
		local f254_local3 = Engine[0x4DF5CFBC1771947](f254_arg0)
		f254_local3 = f254_local3:create("EnemyTeamLastLivesData")
		local f254_local4 = f254_local3:create("teamColor")
		local f254_local5 = f254_local4
		f254_local4 = f254_local4.set
		local f254_local6 = Engine[0x4DF5CFBC1771947](f254_arg0)
		f254_local4(f254_local5, f254_local6.hudItems.colorBlindSensitiveEnemyColor:get())
		CoD.HUDUtility.SetLastLivesDataModelValues(f254_local3, f254_local1)
		CoD.HUDUtility.SetLastLivesDataSubscriptions(f254_arg0, "EnemyTeamLastLivesData", f254_local1)
	end,
	getModel = function(f255_arg0)
		if not DataSources.EnemyTeamLastLivesData.preparedForController or not DataSources.EnemyTeamLastLivesData.preparedForController[f255_arg0] then
			DataSources.EnemyTeamLastLivesData.prepare(f255_arg0)
		end
		local f255_local0 = Engine[0x4DF5CFBC1771947](f255_arg0)
		return f255_local0:create("EnemyTeamLastLivesData")
	end,
}
CoD.HUDUtility.ShouldShowLivesAsList = function(f256_arg0, f256_arg1)
	local f256_local0 = f256_arg0:getModel()
	if f256_local0 then
		if CoD.HUDUtility.IsGameTypeEqualToString("infect") then
			local f256_local1 = f256_local0:create("teamSize")
			f256_local1 = f256_local1:get()
			return f256_local1 and f256_local1 <= f256_arg1
		else
			local f256_local1 = f256_local0:create("noRespawnsLeft")
			f256_local1 = f256_local1:get()
			return f256_local1 and f256_local1 == true
		end
	else
		return false
	end
end
CoD.HUDUtility.ShouldHideScorestreaks = function()
	local f257_local0 = CoD.HUDUtility.IsGameTypeEqualToString("gun")
	if not f257_local0 then
		f257_local0 = CoD.HUDUtility.IsGameTypeEqualToString("oic")
		if not f257_local0 then
			f257_local0 = CoD.HUDUtility.IsGameTypeEqualToString("infect")
			if not f257_local0 then
				f257_local0 = CoD.HUDUtility.IsGameTypeEqualToString("prop")
				if not f257_local0 then
					f257_local0 = CoD.HUDUtility.IsGameTypeEqualToString("sas")
					if not f257_local0 then
						f257_local0 = CoD.HUDUtility.IsGameTypeEqualToString("svz")
					end
				end
			end
		end
	end
	return f257_local0
end
CoD.HUDUtility.ShouldHideWeaponPickup = function()
	local f258_local0 = CoD.HUDUtility.IsGameTypeEqualToString("oic")
	if not f258_local0 then
		f258_local0 = CoD.HUDUtility.IsGameTypeEqualToString("infect")
	end
	return f258_local0
end
CoD.HUDUtility.HideSignatureItem = function(f259_arg0)
	local f259_local0 = CoD.HUDUtility.IsGameTypeEqualToString("bounty")
	if not f259_local0 then
		f259_local0 = CoD.HUDUtility.IsGameTypeEqualToString("infect")
		if not f259_local0 then
			f259_local0 = CoD.HUDUtility.IsGameTypeBareBones()
		end
	end
	return f259_local0
end
CoD.HUDUtility.ShouldShowTeamLives = function(f260_arg0)
	if (CoD.HUDUtility.IsGameTypeEqualToString("sd") or CoD.HUDUtility.IsGameTypeEqualToString("sd_hc") or CoD.HUDUtility.IsGameTypeEqualToString("sd_cwl") or CoD.HUDUtility.IsGameTypeEqualToString("bounty")) and not IsGametypeSettingsValue("playerNumLives", 0) then
		return true
	elseif CoD.HUDUtility.IsGameTypeEqualToString("infect") then
		return true
	else
		return not IsGametypeSettingsValue("teamNumLives", 0)
	end
end
CoD.HUDUtility.GetSegmentCountForStockAmmo = function(f261_arg0)
	local f261_local0 = f261_arg0
	if 8 < f261_local0 then
		f261_local0 = f261_local0 / 3
	end
	return f261_local0
end
CoD.HUDUtility.GetCurrentAmmoPipWipeValue = function(f262_arg0, f262_arg1, f262_arg2, f262_arg3, f262_arg4)
	local f262_local0 = DataSources.CurrentWeapon.getModel(f262_arg0)
	local f262_local1 = 1
	if f262_local0 and f262_local0.ammoInClip and f262_local0.clipMaxAmmo then
		f262_local1 = (f262_local0.ammoInClip:get() or 1) / (f262_local0.clipMaxAmmo:get() or 1)
	end
	return f262_local1, 0, 0, 0
end
CoD.HUDUtility.GetAmmoWipePercentageClipFull = function(f263_arg0, f263_arg1, f263_arg2, f263_arg3, f263_arg4)
	local f263_local0 = DataSources.CurrentWeapon.getModel(f263_arg0)
	if f263_local0 then
		local f263_local1 = CoD.SafeGetModelValue(f263_local0, "clipMaxAmmo")
		if f263_local1 then
			return f263_arg1 / f263_local1, f263_arg2, f263_arg3, f263_arg4
		end
	end
	return 0, f263_arg2, f263_arg3, f263_arg4
end
CoD.HUDUtility.ShouldPulseNewAmmo = function(f264_arg0)
	local f264_local0 = f264_arg0.__savedPulseRef or 0
	local f264_local1 = f264_arg0.__savedPulseAmmo or 0
	f264_arg0.__savedPulseRef = CoD.SafeGetModelValue(f264_arg0:getModel(), "ref") or 0
	f264_arg0.__savedPulseAmmo = CoD.SafeGetModelValue(f264_arg0:getModel(), "ammo") or 0
	if f264_local0 == f264_arg0.__savedPulseRef and f264_local1 < f264_arg0.__savedPulseAmmo then
		return true
	else
		return false
	end
end
CoD.HUDUtility.TakeMenuFocus = function(f265_arg0, f265_arg1)
	f265_arg0:registerEventHandler("gain_focus", function(element, event)
		f265_arg1:processEvent(event)
	end)
end
CoD.HUDUtility.SetDOTDamage = function(f267_arg0, f267_arg1, f267_arg2)
	local f267_local0 = CoD.GetScriptNotifyData(f267_arg1)
	local f267_local1 = f267_local0[1]
	if f267_arg2 and f267_arg2 ~= 0x0 then
		f267_arg0:setText(Engine[0xF9F1239CFD921FE](localizeIntoRef, f267_local1))
	else
		f267_arg0:setText(f267_local1)
	end
end
DataSources.HealthWoundMeterList = DataSourceHelpers.ListSetup(
	"HealthWoundMeterList",
	function(f268_arg0)
		local f268_local0 = {}
		local f268_local1 = function(f269_arg0, f269_arg1)
			return f269_arg1.properties.endTime < f269_arg0.properties.endTime
		end
		local f268_local2 = Engine[0x4DF5CFBC1771947](f268_arg0)
		for f268_local3 = 0, CoD.HUDUtility.MAX_WOUNDS - 1, 1 do
			local f268_local6 = f268_local2.hudItems.health["wound" .. f268_local3]
			local f268_local7 = f268_local6 and f268_local6.isActive:get()
			if f268_local7 then
				table.insert(f268_local0, {
					models = {
						isActive = f268_local7,
						icon = f268_local6.icon:get(),
						woundIndex = f268_local3,
					},
					properties = {
						endTime = f268_local6.endTime:get(),
					},
				})
			end
		end
		table.sort(f268_local0, f268_local1)
		return f268_local0
	end,
	nil,
	nil,
	function(f270_arg0, f270_arg1, f270_arg2)
		if not f270_arg1.__healthWoundMeterListCustomSubscriptions then
			f270_arg1.__healthWoundMeterListCustomSubscriptions = true
			local f270_local0 = Engine[0x4DF5CFBC1771947](f270_arg0)
			for f270_local1 = 0, CoD.HUDUtility.MAX_WOUNDS - 1, 1 do
				local f270_local4 = f270_local0.hudItems.health["wound" .. f270_local1]
				f270_arg1:subscribeToModel(f270_local4.isActive, function(model)
					f270_arg1:updateDataSource(false, false)
				end)
				f270_arg1:subscribeToModel(f270_local4.endTime, function(model)
					f270_arg1:updateDataSource(false, false)
				end)
			end
		end
	end
)
CoD.HUDUtility.UpdateWoundMeterSubscriptions = function(f273_arg0, f273_arg1, f273_arg2, f273_arg3)
	local f273_local0 = nil
	local f273_local1 = f273_arg0:getModel(f273_arg2, "woundIndex")
	f273_local0 = f273_local1 and f273_local1:get()
	if f273_local0 then
		if f273_arg1.__updateWoundMeterCustomSubscriptions then
			for f273_local5, f273_local6 in ipairs(f273_arg1.__updateWoundMeterCustomSubscriptions) do
				f273_arg1:removeSubscription(f273_local6)
			end
		end
		f273_arg1.__updateWoundMeterCustomSubscriptions = {}
		table.insert(
			f273_arg1.__updateWoundMeterCustomSubscriptions,
			f273_arg1:subscribeToGlobalModel(f273_arg2, "HUDItems", "health.wound" .. f273_local0 .. ".decayProgress", function(f274_arg0)
				local f274_local0 = Engine[0x614D394F6F9A18D](f274_arg0)
				if f274_local0 then
					f273_arg1:setShaderVector(f273_arg3, CoD.GetVectorComponentFromString(f274_local0, 1), CoD.GetVectorComponentFromString(f274_local0, 2), CoD.GetVectorComponentFromString(f274_local0, 3), CoD.GetVectorComponentFromString(f274_local0, 4))
				end
			end)
		)
	end
end
CoD.HUDUtility.AddScoreboardBumperNavigation = function(f275_arg0, f275_arg1, f275_arg2)
	CoD.GridAndListUtility.AddBumperNavigationInternal(f275_arg0, f275_arg1, f275_arg2, function()
		if ScoreboardVisible(f275_arg2) then
			BlockGameFromKeyEvent(f275_arg2)
		end
	end, function()
		return ScoreboardVisible(f275_arg2) and not IsMouseOrKeyboard(f275_arg2)
	end)
end
CoD.HUDUtility.IsItemOfLoadoutSlot = function(f278_arg0, f278_arg1, f278_arg2)
	return Engine[0xAEB126818B87808](CoD.SafeGetModelValue(f278_arg0:getModel(), "weapon")) == f278_arg2
end
CoD.HUDUtility.GetObjectiveDescription = function(f279_arg0, f279_arg1, f279_arg2)
	local f279_local0 = tonumber(f279_arg2)
	if f279_local0 then
		local f279_local1 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f279_arg0, f279_local0))
		if f279_local1 then
			local f279_local2 = Engine[0x4C77EAF5F088DC3](f279_arg0, f279_local0)
			local f279_local3 = Engine[0x2C6B07FD023877B](f279_arg0, Engine[0x869E84B826141D2](f279_arg0))
			local f279_local4 = DataSources.CPObjectiveTeams.getModel(f279_arg0)
			f279_local4 = f279_local4.myTeam
			if f279_local4 then
				f279_local4 = f279_local4:get()
			end
			if not f279_local4 or f279_local3 == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] or f279_local2 == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] or f279_local2 == Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] then
				return Engine[0xED84C33EC5F01EA](f279_local1.description or "")
			elseif not (f279_arg1 ~= f279_local4 or f279_local2 ~= f279_local3) or f279_arg1 ~= f279_local4 and f279_local2 ~= f279_local3 then
				return Engine[0xED84C33EC5F01EA](f279_local1.friendly_description or "")
			else
				return Engine[0xED84C33EC5F01EA](f279_local1.enemy_description or "")
			end
		end
	end
	return ""
end
CoD.HUDUtility.GetObjectiveImage = function(f280_arg0, f280_arg1, f280_arg2)
	local f280_local0 = tonumber(f280_arg2)
	local f280_local1 = RegisterImage(0x7615068F50B3D66)
	if f280_local0 then
		local f280_local2 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f280_arg0, f280_local0))
		if f280_local2 and f280_local2.objective_image then
			f280_local1 = RegisterImage(f280_local2.objective_image)
		end
	end
	return f280_local1
end
CoD.HUDUtility.GetShortObjectiveDescription = function(f281_arg0, f281_arg1, f281_arg2)
	local f281_local0 = tonumber(f281_arg2)
	if f281_local0 then
		local f281_local1 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f281_arg0, f281_local0))
		if f281_local1 then
			local f281_local2 = Engine[0x4C77EAF5F088DC3](f281_arg0, f281_local0)
			local f281_local3 = Engine[0x2C6B07FD023877B](f281_arg0, Engine[0x869E84B826141D2](f281_arg0))
			local f281_local4 = DataSources.CPObjectiveTeams.getModel(f281_arg0)
			f281_local4 = f281_local4.myTeam
			if f281_local4 then
				f281_local4 = f281_local4:get()
			end
			if not f281_local4 or f281_local3 == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] or f281_local2 == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] or f281_local2 == Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] then
				return Engine[0xF9F1239CFD921FE](f281_local1[0x82EE2196E11AF59] or 0x0)
			elseif not (f281_arg1 ~= f281_local4 or f281_local2 ~= f281_local3) or f281_arg1 ~= f281_local4 and f281_local2 ~= f281_local3 then
				return Engine[0xF9F1239CFD921FE](f281_local1[0x7C677B684402F46] or 0x0)
			else
				return Engine[0xF9F1239CFD921FE](f281_local1[0x355896153E087] or 0x0)
			end
		end
	end
	return ""
end
CoD.HUDUtility.GadgetHasHoldPrompt = function(f282_arg0, f282_arg1)
	local f282_local0 = f282_arg0:getModel(f282_arg1, "id")
	local f282_local1 = f282_local0 and f282_local0:get()
	if f282_local1 then
		return Engine[0x3C9ABFFE3E851D1](f282_local1)
	else
		return false
	end
end
CoD.HUDUtility.ShouldPulseLowHealth = function(f283_arg0, f283_arg1)
	local f283_local0 = Engine[0x914912C5C194528]
	local f283_local1 = DataSources.CurrentWeapon.getModel(f283_arg0)
	f283_local0 = f283_local0(f283_local1.equippedWeaponReference:get() or 0x0)
	f283_local1 = f283_arg1:getModel()
	return f283_local1.health.healthValue:get() <= f283_local0 * 100
end
DataSources.MedicCleanse = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f284_arg0, f284_arg1, f284_arg2)
		if not DataSources.MedicCleanse.preparedForController then
			DataSources.MedicCleanse.preparedForController = {}
		end
		if not DataSources.MedicCleanse.subscriptions[f284_arg0] then
			DataSources.MedicCleanse.subscriptions[f284_arg0] = LUI.UIElement.new()
		end
		DataSources.MedicCleanse.subscriptions[f284_arg0]:unsubscribeFromAllModels()
		DataSources.MedicCleanse.preparedForController[f284_arg0] = true
		local f284_local0 = Engine[0x4DF5CFBC1771947](f284_arg0)
		f284_local0 = f284_local0:create("MedicCleanse")
		local f284_local1 = f284_local0:create("currentMedicCleanseCount")
		local f284_local2 = f284_local0:create("previousMedicCleanseCount")
		local f284_local3 = DataSources.MedicCleanse.subscriptions[f284_arg0]
		local f284_local4 = f284_local3
		f284_local3 = f284_local3.subscribeToModel
		local f284_local5 = DataSources.HUDItems.getModel(f284_arg0)
		f284_local3(f284_local4, f284_local5.medicCleanseCount, function(f285_arg0)
			local f285_local0 = f285_arg0:get()
			f284_local2:set(f284_local1:get())
			f284_local1:set(f285_local0)
		end, false)
	end,
	getModel = function(f286_arg0)
		if not DataSources.MedicCleanse.preparedForController or not DataSources.MedicCleanse.preparedForController[f286_arg0] then
			DataSources.MedicCleanse.prepare(f286_arg0)
		end
		local f286_local0 = Engine[0x4DF5CFBC1771947](f286_arg0)
		return f286_local0:create("MedicCleanse")
	end,
}
CoD.HUDUtility.InitWeaponPowerDrainBar = function(f287_arg0, f287_arg1, f287_arg2, f287_arg3, f287_arg4)
	f287_arg1.__weaponInUse = false
	f287_arg1.__endClipPlayed = true
	local f287_local0 = function()
		if f287_arg1.__endClipDelay then
			f287_arg1.__endClipDelay:close()
			f287_arg1.__endClipDelay = nil
		end
	end
	if f287_arg4 then
		f287_arg1:linkToElementModel(f287_arg0, "id", true, function(model)
			local f289_local0 = model:get()
			if f287_arg1.__lastWeaponId ~= f289_local0 then
				f287_arg0:setState(f287_arg2, "DefaultState")
				f287_arg1.__endClipPlayed = true
				f287_local0()
			end
			f287_arg1.__lastWeaponId = f289_local0
		end)
		local f287_local1 = f287_arg1
		local f287_local2 = f287_arg1.subscribeToModel
		local f287_local3 = Engine[0x4DF5CFBC1771947](f287_arg2)
		f287_local2(f287_local1, f287_local3.deadSpectator.playerIndex, function(f290_arg0)
			f287_arg0:setState(f287_arg2, "DefaultState")
			f287_arg1.__endClipPlayed = true
			f287_local0()
		end)
	end
	local f287_local2 = function()
		local f291_local0 = f287_arg0:getModel()
		if not f291_local0 then
			return false
		elseif f291_local0.state:get() ~= Enum[0xF0447219F15F7F3][0x1873A43E9D1620E] then
			return false
		end
		local f291_local1 = f291_local0.id:get()
		local f291_local2 = DataSources.CurrentWeapon.getModel(f287_arg2)
		if f291_local2.viewmodelWeaponName:get() ~= f291_local1 then
			f291_local2 = DataSources.CurrentWeapon.getModel(f287_arg2)
			if f291_local2.altViewmodelWeaponName:get() ~= f291_local1 then
				f291_local2 = false
			end
		end
		f291_local2 = true
	end
	local f287_local1 = function()
		local f292_local0 = f287_local2()
		if not f287_arg1.__weaponInUse and f292_local0 then
			f287_arg1.__endClipPlayed = false
			if f287_arg4 then
				f287_arg0:setState(f287_arg2, "Visible")
			end
		end
		f287_arg1.__weaponInUse = f292_local0
		local f292_local1 = f287_arg0:getModel()
		if f292_local1 then
			f292_local1 = f287_arg0:getModel()
			f292_local1 = f292_local1.state:get()
		end
		if f287_arg1.__lastState ~= f292_local1 then
			local f292_local2 = f287_arg0:getModel(f287_arg2, "powerRatio")
			if f292_local2 then
				Engine[0x6A489878620F3BC](f292_local2)
			end
		end
		f287_arg1.__lastState = f292_local1
	end
	if f287_arg4 then
		f287_arg1:subscribeToGlobalModel(f287_arg2, "CurrentWeapon", "viewmodelWeaponName", function(model)
			f287_local1()
		end)
	end
	f287_arg1:linkToElementModel(f287_arg0, "state", true, function(model)
		f287_local1()
	end)
	f287_arg1:linkToElementModel(f287_arg0, "powerRatio", true, function(model)
		local f295_local0 = model:get() or 0
		if f287_arg1.__weaponInUse and f295_local0 > 0 then
			f287_arg1:setShaderVector(0, 1, 1 - f295_local0, 0, 0)
		elseif not f287_arg1.__endClipPlayed then
			f287_arg1:beginAnimation(f287_arg3, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
			f287_arg1:setShaderVector(0, 1, 1, 0, 0)
			if f287_arg4 then
				f287_local0()
				f287_arg1.__endClipDelay = LUI.UITimer.newElementTimer(f287_arg3, true, function()
					f287_arg0:setState(f287_arg2, "DefaultState")
					f287_local0()
				end)
				f287_arg1:addElement(f287_arg1.__endClipDelay)
			end
			f287_arg1.__endClipPlayed = true
		end
	end)
end
CoD.HUDUtility.UsingPlayerGadgetWithBar = function(f297_arg0)
	local f297_local0 = DataSources.PlayerAbilities.getModel(f297_arg0)
	local f297_local1 = DataSources.CurrentWeapon.getModel(f297_arg0)
	f297_local1 = f297_local1.viewmodelWeaponName:get()
	local f297_local2 = DataSources.CurrentWeapon.getModel(f297_arg0)
	f297_local2 = f297_local2.altViewmodelWeaponName:get()
	local f297_local3 = function(f298_arg0)
		local f298_local0 = f297_local0[f298_arg0]
		if f298_local0 then
			local f298_local1
			if f298_local0.state:get() ~= Enum[0xF0447219F15F7F3][0x1873A43E9D1620E] or f297_local1 ~= f298_local0.id:get() and f297_local2 ~= f298_local0.id:get() then
				f298_local1 = false
			else
				f298_local1 = true
			end
			return f298_local1
		else
			return false
		end
	end
	local f297_local4 = f297_local3("playerGadget2")
	if not f297_local4 then
		f297_local4 = f297_local3("playerGadget3")
	end
	return f297_local4
end
CoD.HUDUtility.PlayerHasPerk = function(f299_arg0, f299_arg1)
	return Engine[0x15470EBA42394ED](f299_arg0, f299_arg1)
end
CoD.HUDUtility.AwarenessLevels = LuaEnum.createEnum("AWARENESS_LEVEL_NONE", "AWARENESS_LEVEL_OUTER_BIT", "AWARENESS_LEVEL_MID_BIT", "AWARENESS_LEVEL_INNER_BIT")
CoD.HUDUtility.AwarenessNumSegments = 8
CoD.HUDUtility.RotateAwarenessRingIfEnabled = function(f300_arg0)
	if Engine[0x22EAAB59AA27E9B]("ui_awareness_rotate") ~= 0 then
		return f300_arg0
	else
		return 0
	end
end
CoD.HUDUtility.SetXFractionByModel = function(f301_arg0, f301_arg1, f301_arg2)
	local f301_local0 = Engine[0x614D394F6F9A18D](f301_arg2)
	if f301_local0 then
		if f301_local0 <= 0 then
			f301_arg0:setShaderVector(0, 0, 0, 0, 0)
			if f301_arg0.updateTimer then
				f301_arg0.updateTimer:close()
				f301_arg0.updateTimer = nil
			end
		else
			f301_arg0.curProgress = 0
			f301_arg0.startTime = Engine[0xB07E933C9E5CEB1]()
			f301_arg0.updateTimer = LUI.UITimer.newElementTimer(16, false, function()
				local f302_local0 = Engine[0xB07E933C9E5CEB1]()
				f301_arg0.curProgress = f301_arg0.curProgress + f302_local0 - f301_arg0.startTime
				f301_arg0:setShaderVector(0, f301_arg0.curProgress / f301_local0, 0, 0, 0)
				f301_arg0.startTime = f302_local0
			end)
			f301_arg0:addElement(f301_arg0.updateTimer)
		end
	end
end
CoD.HUDUtility.TransformWorldPosToCompassRelativePosition = function(f303_arg0, f303_arg1, f303_arg2)
	local f303_local0, f303_local1, f303_local2, f303_local3 = Engine[0x803048A0AE6E039](f303_arg0)
	local f303_local4, f303_local5 = Engine[0xD345FF764DC8504](f303_arg0)
	local f303_local6, f303_local7 = nil
	if math.abs(f303_local4) > 0 then
		f303_local7 = (f303_arg1 - f303_local0) / (f303_local2 - f303_local0)
		f303_local6 = (f303_arg2 - f303_local1) / (f303_local3 - f303_local1)
	elseif math.abs(f303_local5) > 0 then
		f303_local6 = (f303_arg1 - f303_local0) / (f303_local2 - f303_local0)
		f303_local7 = (f303_arg2 - f303_local1) / (f303_local3 - f303_local1)
	end
	return f303_local6, f303_local7
end
CoD.HUDUtility.TransformCompassRelativePositionToWorldPos = function(f304_arg0, f304_arg1, f304_arg2)
	local f304_local0, f304_local1, f304_local2, f304_local3 = Engine[0x803048A0AE6E039](f304_arg0)
	local f304_local4, f304_local5 = Engine[0xD345FF764DC8504](f304_arg0)
	local f304_local6, f304_local7 = nil
	if math.abs(f304_local4) > 0 then
		f304_local6 = f304_local2 * f304_arg2 + f304_local0 * (1 - f304_arg2)
		f304_local7 = f304_local3 * f304_arg1 + f304_local1 * (1 - f304_arg1)
	elseif math.abs(f304_local5) > 0 then
		f304_local6 = f304_local2 * f304_arg1 + f304_local0 * (1 - f304_arg1)
		f304_local7 = f304_local3 * f304_arg2 + f304_local1 * (1 - f304_arg2)
	end
	return f304_local6, f304_local7
end
CoD.HUDUtility.ThrustMeter_Colors = {
	{
		r = 1,
		g = 1,
		b = 1,
	},
}
CoD.HUDUtility.ThrustMeter_Cutoffs = {
	0,
}
CoD.HUDUtility.ThrustMeter_Color_Lerp = function(f305_arg0, f305_arg1, f305_arg2, f305_arg3)
	f305_arg3 = math.min(math.max(0, f305_arg3), 1)
	f305_arg0:setRGB(f305_arg1.r * (1 - f305_arg3) + f305_arg2.r * f305_arg3, f305_arg1.g * (1 - f305_arg3) + f305_arg2.g * f305_arg3, f305_arg1.b * (1 - f305_arg3) + f305_arg2.b * f305_arg3)
end
CoD.HUDUtility.ThrustMeter_ApplyColor = function(f306_arg0, f306_arg1)
	for f306_local0 = 1, #CoD.HUDUtility.ThrustMeter_Cutoffs - 1, 1 do
		if CoD.HUDUtility.ThrustMeter_Cutoffs[f306_local0] <= f306_arg1 and f306_arg1 <= CoD.HUDUtility.ThrustMeter_Cutoffs[f306_local0 + 1] then
			CoD.HUDUtility.ThrustMeter_Color_Lerp(f306_arg0, CoD.HUDUtility.ThrustMeter_Colors[f306_local0], CoD.HUDUtility.ThrustMeter_Colors[f306_local0 + 1], (f306_arg1 - CoD.HUDUtility.ThrustMeter_Cutoffs[f306_local0]) / (CoD.HUDUtility.ThrustMeter_Cutoffs[f306_local0 + 1] - CoD.HUDUtility.ThrustMeter_Cutoffs[f306_local0]))
			return
		end
	end
	f306_arg0:setRGB(CoD.HUDUtility.ThrustMeter_Colors[#CoD.HUDUtility.ThrustMeter_Colors].r, CoD.HUDUtility.ThrustMeter_Colors[#CoD.HUDUtility.ThrustMeter_Colors].g, CoD.HUDUtility.ThrustMeter_Colors[#CoD.HUDUtility.ThrustMeter_Colors].b)
end
CoD.HUDUtility.UpdateThrustMeter = function(f307_arg0, f307_arg1, f307_arg2, f307_arg3, f307_arg4)
	local f307_local0 = Engine[0x614D394F6F9A18D](f307_arg4)
	if not f307_local0 then
		return
	elseif f307_arg0._lastScalableWidth == -1 then
		f307_arg0:playClip("IntroAnimation")
		f307_arg0._lastScalableWidth = 1
	end
	if f307_arg0._lastScalableWidth == f307_local0 then
		return
	end
	local f307_local1 = f307_arg0._lastScalableWidth + 0 < f307_local0
	f307_arg0._lastScalableWidth = f307_local0
	local f307_local2 = 0.48 + 0.04 * f307_local0
	local f307_local3 = -25.3 + 52.3 * f307_local0
	local f307_local4 = f307_local3 + 2
	f307_arg1.fill:beginAnimation("update_fill", 50, false, false)
	CoD.HUDUtility.ThrustMeter_ApplyColor(f307_arg1.fill, f307_local0)
	f307_arg1.fill:setShaderVector(0, f307_local2, 0, 0, 0)
	f307_arg1.dots:beginAnimation("update_fill", 50, false, false)
	f307_arg1.dots:setShaderVector(0, 1 - f307_local2, 0, 0, 0)
	local f307_local5 = 50
	if f307_local1 then
		f307_local5 = 50
		f307_arg2.right1:playClip("Fill")
	else
		f307_arg2.right1:playClip("Drain")
	end
	f307_arg2.right1:beginAnimation("right_chevron_thick", f307_local5, false, false)
	f307_arg2.right1:setZRot(f307_local3)
	f307_arg2.right2:beginAnimation("right_chevron_thin", f307_local5, false, false)
	f307_arg2.right2:setZRot(f307_local4)
end
CoD.HUDUtility.MiniTurretPostLoad = function(f308_arg0, f308_arg1)
	f308_arg0.originalClipOver = f308_arg0.m_eventHandlers.clip_over
	f308_arg0:registerEventHandler("clip_over", function(element, event)
		if not element.nextClip and not IsInDefaultState(element) then
			if IsElementInState(element, "EnemyKilled") then
				local f309_local0 = Engine[0x4DF5CFBC1771947](f308_arg1)
				f309_local0 = f309_local0.miniTurretKillCount
				if f309_local0 and type(f309_local0:get()) == "number" then
					SetControllerModelValueNumberDecrement(f308_arg1, "miniTurretKillCount", 0)
					if f309_local0:get() > 0 then
						element:playClip("DefaultClip")
					else
						SetState(element, "DefaultState", f308_arg1)
					end
				end
			else
				SetState(element, "DefaultState", f308_arg1)
			end
		end
		element:originalClipOver(event)
	end)
end
CoD.HUDUtility.OnDamageFeedbackSetState = function(f310_arg0, f310_arg1, f310_arg2)
	if f310_arg2 == "DefaultState" then
		if f310_arg0.moveToDefaultTimer then
			f310_arg0.moveToDefaultTimer:close()
			f310_arg0.moveToDefaultTimer = nil
		end
	elseif f310_arg0.moveToDefaultTimer then
		f310_arg0.moveToDefaultTimer:reset()
	else
		f310_arg0.moveToDefaultTimer = LUI.UITimer.newElementTimer(600, true, function()
			local f311_local0 = f310_arg0:getModel(f310_arg1, "damageFeedbackState")
			if f311_local0 then
				Engine[0x83C9B5DE1D9371](f311_local0, Enum[0x96EEA70EAC07218][0x939E3F6C6998E83])
			end
		end)
		f310_arg0:addElement(f310_arg0.moveToDefaultTimer)
	end
end
CoD.HUDUtility.SetupPrematchCountdown = function(f312_arg0, f312_arg1, f312_arg2, f312_arg3)
	f312_arg0.PrematchCountdownNumbers.Numbers.Numbers:setupPrematchTimer(f312_arg2)
	if not f312_arg3 then
		f312_arg0.PrematchCountdownNumbers:setAlpha(0)
		return
	elseif f312_arg2 then
		local f312_local0 = f312_arg2 - Engine[0xB07E933C9E5CEB1]()
		if f312_local0 > 5000 then
			f312_arg0:registerEventHandler("faction_start", function(element)
				element:playClip("Start")
				return true
			end)
			f312_arg0:addElement(LUI.UITimer.new(f312_local0 - 5000, "faction_start", true))
		else
			f312_arg0:playClip("Start")
		end
	end
	f312_arg0.PrematchCountdownNumbers:playClip("Start")
end
CoD.HUDUtility.PrematchCountdownPostLoad = function(f314_arg0, f314_arg1)
	if not IsDoubleXP(f314_arg1) and not IsDoubleWeaponXP(f314_arg1) and not IsDoubleLootXP(f314_arg1) and not ShouldDisplayFactionIconAtPrematchCountdown(f314_arg0) then
		f314_arg0.FactionIcon:close()
		f314_arg0.FactionIcon0:close()
		f314_arg0.FactionName:close()
	end
	local f314_local0 = function(f315_arg0, f315_arg1)
		f315_arg0:playClip("ShowObjectiveHint")
		f315_arg0:registerEventHandler("clip_over", function(element, event)
			local f316_local0 = Engine[0x9672E391E0BF3DD](f314_arg1)
			local f316_local1
			if f316_local0 ~= nil and f316_local0 ~= 0 then
				f316_local1 = false
			else
				f316_local1 = true
			end
			if f316_local1 and IsDoubleLootXP(f314_arg1) then
				element:playClip("ShowDoubleLootIcon")
				element:registerEventHandler("clip_over", function(element, event)
					element:close()
				end)
			else
				element:close()
			end
		end)
	end
	f314_arg0:subscribeToGlobalModel(f314_arg1, "PerController", "scriptNotify", function(model)
		local f318_local0 = Engine[0x614D394F6F9A18D](model)
		if f318_local0 == 0xEE9F12E547BE609 then
			local f318_local1 = {
				controller = f314_arg1,
				name = f318_local0,
				data = CoD.GetScriptNotifyData(model),
			}
			local f318_local2 = Engine[0xEA74FA7EE46E195](Engine[0xFC38819EA2193BA]())
			local f318_local3 = f318_local2.objective_strings[f318_local1.data[1] + 1][0x56473EFC71F09F] or ""
			f314_arg0:setAlpha(1)
			f314_arg0.GameTypeHintText.MatchText:setText(Engine[0xED84C33EC5F01EA](f318_local3))
			f314_arg0.GameTypeIcon:setImage(RegisterImage(CoD.GetLoadingScreenGameTypeIconName()))
			if f314_arg0.playFactionInfoAnimation and not HUD_IsFFA() then
				f314_arg0:playClip("ShowOnlyFactionInfo")
				f314_arg0:registerEventHandler("clip_over", f314_local0)
			else
				f314_local0(f314_arg0, f318_local1)
			end
		elseif f318_local0 == 0x14431C3CAF07786 then
			local f318_local1 = {
				controller = f314_arg1,
				name = f318_local0,
				data = CoD.GetScriptNotifyData(model),
			}
			local f318_local2
			if f318_local1.data == nil or f318_local1.data[1] ~= 1 then
				f318_local2 = false
			else
				f318_local2 = true
			end
			if f318_local2 then
				f314_arg0:playClip("Stop")
				f314_arg0.PrematchCountdownNumbers:playClip("Stop")
				f314_arg0:registerEventHandler("clip_over", function(element, event)
					element:setAlpha(0)
					if IsDemoPlaying() then
						element:close()
					end
				end)
			end
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f314_arg1), "isInPrematchPeriod"), 0)
		end
	end)
	f314_arg0.onPlayerSpawned = function(f320_arg0)
		if not IsInPrematchPeriod(f314_arg1) then
			f320_arg0.playFactionInfoAnimation = true
		end
	end
	f314_arg0.setupCountdown = CoD.HUDUtility.SetupPrematchCountdown
	f314_arg0:setState(f314_arg1, "DefaultState")
	local f314_local1 = Engine[0xDBC2AD5002B261B](0x2035BC579C2A9BE) * 1000
	local f314_local2 = Engine[0xB07E933C9E5CEB1]()
	local f314_local3 = 250
	if f314_local2 < f314_local1 then
		f314_local3 = f314_local1 - f314_local2
	end
	LUI.OverrideFunction_CallOriginalSecond(f314_arg0, "close", function(element)
		local f321_local0 = element:getParent()
		f321_local0.PrematchCountdown = nil
	end)
end
CoD.HUDUtility.SetupPrematchCountdownMinimize = function(f322_arg0, f322_arg1, f322_arg2, f322_arg3, f322_arg4)
	f322_arg0.PrematchCountdownNumbers.Numbers.Numbers:setupPrematchTimer(f322_arg2)
	f322_arg0.PrematchCountdownNumbersSmall.Timer:setupPrematchTimer(f322_arg2)
	if not f322_arg3 then
		f322_arg0.PrematchCountdownNumbers:setAlpha(0)
		return
	elseif f322_arg2 then
		f322_arg0:registerEventHandler("faction_start", function(element)
			element:playClip("Minimize")
			return true
		end)
		f322_arg0:addElement(LUI.UITimer.new(f322_arg4, "faction_start", true))
	end
	f322_arg0.PrematchCountdownNumbers:playClip("Start")
end
CoD.HUDUtility.PrematchCountdownMinimizePostLoad = function(f324_arg0, f324_arg1)
	local f324_local0 = function(f325_arg0, f325_arg1)
		f325_arg0:playClip("ShowObjectiveHint")
		f325_arg0:registerEventHandler("clip_over", function(element, event)
			element:close()
		end)
	end
	f324_arg0:subscribeToGlobalModel(f324_arg1, "PerController", "scriptNotify", function(model)
		local f327_local0 = model:get()
		if f327_local0 == 0xB0B843215635D02 then
			f324_arg0.__startCounterTime = Engine[0xB07E933C9E5CEB1]() + Engine[0xDBC2AD5002B261B](0x2035BC579C2A9BE) * 1000
			local f327_local1 = Engine[0x4DF5CFBC1771947](f324_arg1)
			f327_local1 = f327_local1:create("PositionDraft.stage")
			f327_local1:set(6)
			f324_arg0.__messageTimer = LUI.UITimer.newElementTimer(1000, false, function()
				local f328_local0 = f324_arg0.__startCounterTime - Engine[0xB07E933C9E5CEB1]()
				local f328_local1 = Engine[0x8DF2E5447F384B9]()
				f328_local1 = f328_local1:create("PositionDraft.timeRemaining")
				f328_local1:set(math.ceil(f328_local0 / 1000))
			end)
			f324_arg0:addElement(f324_arg0.__messageTimer)
		elseif f327_local0 == 0xEE9F12E547BE609 then
			local f327_local2 = {
				controller = f324_arg1,
				name = f327_local0,
				data = CoD.GetScriptNotifyData(model),
			}
			local f327_local1 = Engine[0xEA74FA7EE46E195](Engine[0xFC38819EA2193BA]())
			local f327_local3 = f327_local1.objective_strings[f327_local2.data[1] + 1][0x56473EFC71F09F] or ""
			f324_arg0:setAlpha(1)
			f324_arg0.GameTypeHintText.MatchText:setText(Engine[0xED84C33EC5F01EA](f327_local3))
			f324_local0(f324_arg0, f327_local2)
		elseif f327_local0 == 0x14431C3CAF07786 then
			local f327_local2 = {
				controller = f324_arg1,
				name = f327_local0,
				data = CoD.GetScriptNotifyData(model),
			}
			local f327_local1 = f327_local2.data
			if f327_local1 then
				f327_local1 = f327_local2.data[1] == 1
			end
			if f327_local2.data[2] then
				f324_arg0:close()
				return
			elseif f327_local1 then
				f324_arg0:playClip("Stop")
				f324_arg0:registerEventHandler("clip_over", function(element, event)
					element:setAlpha(0)
					if IsDemoPlaying() then
						element:close()
					end
				end)
				if f324_arg0.__messageTimer then
					local f327_local3 = Engine[0x4DF5CFBC1771947](f324_arg1)
					f327_local3 = f327_local3:create("PositionDraft.stage")
					f327_local3:set(0)
					f324_arg0.__messageTimer:close()
					f324_arg0.__messageTimer = nil
				end
			end
			local f327_local3 = Engine[0x4DF5CFBC1771947](f324_arg1)
			local f327_local4 = f327_local3:create("isInPrematchPeriod")
			f327_local4:set(0)
		end
	end)
	f324_arg0.setupCountdown = CoD.HUDUtility.SetupPrematchCountdownMinimize
	f324_arg0:setState(f324_arg1, "DefaultState")
	LUI.OverrideFunction_CallOriginalSecond(f324_arg0, "close", function(element)
		local f330_local0 = element:getParent()
		f330_local0.PrematchCountdown = nil
	end)
end
CoD.HUDUtility.SetupHoldingPenNotification = function(f331_arg0, f331_arg1, f331_arg2)
	f331_arg0:registerEventHandler("minimize_holding_pen", function(element)
		element:playClip("Minimize")
		return true
	end)
	f331_arg0:addElement(LUI.UITimer.new(f331_arg2, "minimize_holding_pen", true))
end
CoD.HUDUtility.HoldingPenNotificationPostLoad = function(f333_arg0, f333_arg1)
	f333_arg0.PrematchCountdownNumbers.Numbers.Numbers:setText("")
	f333_arg0.PrematchCountdownNumbersSmall.Timer:setText("")
	f333_arg0:subscribeToGlobalModel(f333_arg1, "PerController", "scriptNotify", function(model)
		local f334_local0 = model:get()
		if f334_local0 == 0xB0B843215635D02 or f334_local0 == 0x14431C3CAF07786 or f334_local0 == 0xEE9F12E547BE609 then
			f333_arg0:close()
		end
	end)
	f333_arg0.setupHoldingPenNotification = CoD.HUDUtility.SetupHoldingPenNotification
	f333_arg0:setState(f333_arg1, "DefaultState")
	LUI.OverrideFunction_CallOriginalSecond(f333_arg0, "close", function(element)
		local f335_local0 = element:getParent()
		f335_local0.HoldingPenNotification = nil
	end)
end
CoD.HUDUtility.AddToAbilityCalloutQueue = function(f336_arg0, f336_arg1, f336_arg2)
	if f336_arg2:get() == "ability_callout" then
		local f336_local0 = CoD.GetScriptNotifyData(f336_arg2)
		local f336_local1 = Engine[0x5495B2277D7A9D](f336_local0[1])
		local f336_local2 = Engine[0x7505E1D60F948DB](f336_local0[1])
		if f336_local1 ~= "" or f336_local2 ~= "" then
			CoD.QueueUtility.AddToTimedFnQueue(f336_arg0, CoD.QueueUtility.TimedFnQueuePriority.AbilityCallout, CoD.HUDUtility.SetAbilityCallout, {
				clipBased = true,
				notificationText = f336_local1,
				notificationIcon = f336_local2,
				clientNum = f336_local0[2],
			})
		end
	end
end
CoD.HUDUtility.SetupAbilityCalloutQueue = function(f337_arg0, f337_arg1, f337_arg2)
	local f337_local0 = Engine[0x4DF5CFBC1771947](f337_arg1)
	f337_arg0.menu = f337_arg2
	f337_arg0.controller = f337_arg1
	f337_arg0.widgetModels = {}
	for f337_local1 = 1, CoD.QueueUtility.TimedFnQueueMaxSize, 1 do
		table.insert(f337_arg0.widgetModels, Engine[0xA798E4552F5E872](f337_local0, "AbilityCallout" .. f337_local1))
	end
end
CoD.HUDUtility.SetAbilityCallout = function(f338_arg0, f338_arg1, f338_arg2)
	local f338_local0 = f338_arg0.widgetModels[f338_arg1]
	local f338_local1 = f338_local0:create("abilityName")
	local f338_local2 = f338_local0:create("abilityIcon")
	local f338_local3 = f338_local0:create("clientNum")
	f338_local1:set(f338_arg2.notificationText)
	f338_local2:set(f338_arg2.notificationIcon)
	f338_local3:set(f338_arg2.clientNum)
	local f338_local4 = CoD.AbilityCallout.new(f338_arg0.menu, f338_arg0.controller)
	f338_local4:setModel(f338_local0, controller)
	f338_arg0:addElement(f338_local4)
	f338_local4:playClip("Activate")
	f338_local4:registerEventHandler("clip_over", function()
		CoD.QueueUtility.PumpTimedFnQueue(f338_arg0)
		f338_local4:close()
	end)
	return f338_local4
end
CoD.HUDUtility.InitOverheadNameClampWatch = function(f340_arg0, f340_arg1)
	f340_arg0:linkToElementModel(f340_arg0, "abilityCallout.index", true, function(model)
		local f341_local0 = Engine[0xFA75409B5FA0438](model:get())
		local f341_local1 = f341_local0 and f341_local0 ~= ""
		local f341_local2 = f340_arg0:getModel()
		f341_local2 = f341_local2:create("abilityCallout.shouldClamp")
		f341_local2:set(f341_local1)
	end)
end
CoD.HUDUtility.ShowAbilityCalloutOverheadIcon = function(f342_arg0, f342_arg1)
	local f342_local0 = f342_arg0:getModel(f342_arg1, "index")
	if not f342_local0 then
		f342_local0 = f342_arg0:getModel(f342_arg1, "abilityCallout.index")
	end
	if f342_local0 then
		local f342_local1 = f342_local0:get() or 0
		if f342_local1 ~= 0 then
			local f342_local2 = Engine[0xFA75409B5FA0438](f342_local1)
			return f342_local2 and f342_local2 ~= ""
		end
	end
	return false
end
CoD.HUDUtility.GetAbilityCalloutOverheadIcon = function(f343_arg0)
	local f343_local0 = Engine[0xFA75409B5FA0438](f343_arg0)
	if not f343_local0 or f343_local0 == "" then
		return RegisterImage(0x7615068F50B3D66)
	else
		return f343_local0
	end
end
CoD.HUDUtility.UpdateMessageTimer = function(f344_arg0, f344_arg1)
	local f344_local0 = f344_arg1:get()
	if f344_local0 >= 0 then
		f344_arg0:setText(f344_local0)
	end
end
CoD.HUDUtility.SetupReviveHud = function(f345_arg0, f345_arg1, f345_arg2)
	assert(f345_arg1)
	f345_arg1:setAlpha(0)
	local f345_local0 = f345_arg0:getModel()
	f345_local0 = f345_local0:create("clientName")
	f345_local0:set("")
	f345_arg0:linkToElementModel(f345_arg0, "clientNum", true, function(model)
		local f346_local0 = f345_arg0:getModel()
		f346_local0.clientName:set(GetClientNameAndClanTag(f345_arg2, model:get() or 0))
	end)
	f345_arg0:linkToElementModel(f345_arg0, "fadeTime", true, function(model)
		if not Engine[0xDD333420C49E6D0](f345_arg2, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) then
			local f347_local0 = (model:get() or 0) * 100
			if f347_local0 == 0 then
				f345_arg1:setAlpha(0)
			else
				f345_arg1:setAlpha(1)
				f345_arg1:beginAnimation(f347_local0)
				f345_arg1:setAlpha(0)
			end
		end
	end)
end
DataSources.Consequences = {
	preparedForController = {},
	prepare = function(f348_arg0)
		if not DataSources.Consequences.preparedForController then
			DataSources.Consequences.preparedForController = {}
		end
		local f348_local0 = Engine[0x4DF5CFBC1771947](f348_arg0)
		f348_local0 = f348_local0:create("Consequences")
		f348_local0:create("message")
		f348_local0:create("detail")
		f348_local0:create("image")
		f348_local0:create("color")
		DataSources.Consequences.preparedForController[f348_arg0] = true
	end,
	getModel = function(f349_arg0)
		if not DataSources.Consequences.preparedForController or not DataSources.Consequences.preparedForController[f349_arg0] then
			DataSources.Consequences.prepare(f349_arg0)
		end
		local f349_local0 = Engine[0x4DF5CFBC1771947](f349_arg0)
		return f349_local0:create("Consequences")
	end,
}
CoD.HUDUtility.UpdateConsequenceModels = function(f350_arg0, f350_arg1, f350_arg2, f350_arg3)
	local f350_local0 = CoD.BaseUtility.GetMapValue(Engine[0x84A6876C104DA7D](), 0x6FC7A35E5798506)
	if f350_local0 then
		local f350_local1 = Engine[0xA7E3CD65E63086F](Engine[0xC53F8D38DF9042B](f350_local0))
		if f350_local1 then
			local f350_local2 = f350_local1[f350_arg3:get() + 1]
			if f350_local2 then
				local f350_local3 = DataSources.Consequences.getModel(f350_arg2)
				local f350_local4 = CoD.TeamUtility.GetTeam(f350_arg2)
				if f350_local4 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
					f350_local3.message:set(f350_local2[0x649E5C6703DBB1E] or "")
					f350_local3.detail:set(f350_local2[0x24EA0F017CE531E] or "")
					f350_local3.image:set(f350_local2[0x553E4FB59CCE764] or "")
					f350_local3.color:set(f350_local2[0xC73D00CD9C9B1CE] or "")
				elseif f350_local4 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
					f350_local3.message:set(f350_local2[0x4CA7E27A0369F53] or "")
					f350_local3.detail:set(f350_local2[0xE88D19F26C542E5] or "")
					f350_local3.image:set(f350_local2[0x62B0D276D1E7481] or "")
					f350_local3.color:set(f350_local2[0x5230C64036337BB] or "")
				end
			end
		end
	end
end
CoD.HUDUtility.LinkSetupEntityContainerToModel = function(f351_arg0, f351_arg1, f351_arg2, f351_arg3, f351_arg4, f351_arg5, f351_arg6)
	f351_arg0:setLeftRight(0, 0, 0, 0)
	f351_arg0:setTopBottom(0, 0, 0, 0)
	f351_arg0:setEntityContainerClamp(f351_arg2)
	f351_arg0:setEntityContainerScale(f351_arg3)
	f351_arg0:linkToElementModel(f351_arg0, f351_arg1, true, function(model)
		local f352_local0 = model:get()
		if f352_local0 ~= nil then
			f351_arg0:setupEntityContainer(f352_local0, f351_arg4, f351_arg5, f351_arg6)
		end
	end)
end
CoD.HUDUtility.InitLuiElemSelfModel = function(f353_arg0, f353_arg1, f353_arg2)
	local f353_local0 = f353_arg0:getModel()
	f353_local0 = f353_local0:create(f353_arg1)
	f353_local0:set(f353_arg2)
end
CoD.HUDUtility.SetupGrenadeWarningIndicators = function(f354_arg0, f354_arg1)
	local f354_local0 = DataSources.WorldSpaceIndicators.getModel(f354_arg1)
	local f354_local1 = 0
	local f354_local2 = true
	while f354_local2 do
		local f354_local3 = f354_local0:create("warningIndicator" .. f354_local1)
		f354_local3:create("image")
		local f354_local4 = f354_local3:create("direction")
		f354_local4:set(0)
		f354_local4 = f354_local3:create("clamped")
		f354_local4:set(false)
		f354_local4 = f354_local3:create("timeLeftPercent")
		f354_local4:set(0.1)
		f354_local4 = CoD.grenadeWarning.new(f354_arg0, f354_arg1, 0, 0, 0, CoD.grenadeWarning.__defaultWidth, 0, 0, 0, CoD.grenadeWarning.__defaultHeight)
		f354_local4.id = "grenadeWarning" .. f354_local1
		f354_local4:setModel(f354_local3, f354_arg1)
		f354_local2 = f354_local4:setupGrenadeWarning(f354_local1)
		f354_arg0.fullscreenContainer:addElement(f354_local4)
		f354_arg0:sendInitializationEvents(f354_arg1, f354_local4)
		f354_local1 = f354_local1 + 1
	end
end
CoD.HUDUtility.SetupArmbladeReticles = function(f355_arg0, f355_arg1)
	f355_arg0:subscribeToGlobalModel(f355_arg1, "PerController", "playerAbilities.playerGadget2.id", function(model)
		if model and Engine[0x614D394F6F9A18D](model) == 0x36FE71BB75A52D1 then
			if not f355_arg0.armbladeReticles then
				local f356_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f355_arg1), "ArmbladeReticles")
				f355_arg0.armbladeReticles = {}
				local f356_local1 = true
				local f356_local2 = 0
				while f356_local1 do
					local f356_local3 = CoD.RipperLockReticle.new(f355_arg0, f355_arg1, 0, 0, 0, CoD.RipperLockReticle.__defaultWidth, 0, 0, 0, CoD.RipperLockReticle.__defaultHeight)
					local f356_local4 = Engine[0xA798E4552F5E872](f356_local0, #f355_arg0.armbladeReticles)
					LUI.CreateModelsAndInitialize(f356_local4, {
						status = 0,
					})
					f356_local3:setModel(f356_local4, f355_arg1)
					f355_arg0:sendInitializationEvents(f355_arg1, f356_local3)
					f356_local1 = f356_local3:setupArmBladeTarget(f355_arg1, #f355_arg0.armbladeReticles)
					table.insert(f355_arg0.armbladeReticles, f356_local3)
					f355_arg0.fullscreenContainer:addElement(f356_local3)
				end
			end
		elseif f355_arg0.armbladeReticles then
			for f356_local3, f356_local4 in ipairs(f355_arg0.armbladeReticles) do
				f356_local4:close()
			end
			f355_arg0.armbladeReticles = nil
			f356_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f355_arg1), "ArmbladeReticles")
			if f356_local0 then
				Engine[0x8C7A8C4C5FD9892](f356_local0)
			end
		end
	end)
end
CoD.HUDUtility.SetupWZArmbladeReticles = function(f357_arg0, f357_arg1)
	f357_arg0:subscribeToGlobalModel(f357_arg1, "PerController", "heldWeapons.0.equippedWeaponReference", function(model)
		if model and Engine[0x614D394F6F9A18D](model) == 0x324DD1BB71A5659 then
			if not f357_arg0.armbladeReticles then
				local f358_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f357_arg1), "ArmbladeReticles")
				f357_arg0.armbladeReticles = {}
				local f358_local1 = true
				local f358_local2 = 0
				while f358_local1 do
					local f358_local3 = CoD.RipperLockReticle.new(f357_arg0, f357_arg1, 0, 0, 0, CoD.RipperLockReticle.__defaultWidth, 0, 0, 0, CoD.RipperLockReticle.__defaultHeight)
					local f358_local4 = Engine[0xA798E4552F5E872](f358_local0, #f357_arg0.armbladeReticles)
					LUI.CreateModelsAndInitialize(f358_local4, {
						status = 0,
					})
					f358_local3:setModel(f358_local4, f357_arg1)
					f357_arg0:sendInitializationEvents(f357_arg1, f358_local3)
					f358_local1 = f358_local3:setupArmBladeTarget(f357_arg1, #f357_arg0.armbladeReticles)
					table.insert(f357_arg0.armbladeReticles, f358_local3)
					f357_arg0.fullscreenContainer:addElement(f358_local3)
				end
			end
		elseif f357_arg0.armbladeReticles then
			for f358_local3, f358_local4 in ipairs(f357_arg0.armbladeReticles) do
				f358_local4:close()
			end
			f357_arg0.armbladeReticles = nil
			f358_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f357_arg1), "ArmbladeReticles")
			if f358_local0 then
				Engine[0x8C7A8C4C5FD9892](f358_local0)
			end
		end
	end)
end
CoD.HUDUtility.GetPredictedClientNameAndClanTag = function(f359_arg0, f359_arg1)
	local f359_local0 = Engine[0x869E84B826141D2](f359_arg0)
	return GetClientClantag(f359_arg0, f359_local0) .. GetClientName(f359_arg0, f359_local0)
end
CoD.HUDUtility.GetClientNameAndClanTagForClientNum = function(f360_arg0, f360_arg1)
	local f360_local0 = f360_arg1
	return GetClientClantag(f360_arg0, f360_local0) .. GetClientName(f360_arg0, f360_local0)
end
CoD.HUDUtility.GetScriptBundleStringField = function(f361_arg0, f361_arg1, f361_arg2)
	local f361_local0 = Engine[0xE00B2F29271C60B](f361_arg2)
	if not f361_local0 then
		return 0x0
	else
		return f361_local0[f361_arg1]
	end
end
CoD.HUDUtility.GetScriptBundleField = function(f362_arg0, f362_arg1, f362_arg2)
	return CoD.HUDUtility.GetScriptBundleStringField(f362_arg0, f362_arg1, f362_arg2)
end
CoD.HUDUtility.GiveFocus = function(f363_arg0, f363_arg1)
	if f363_arg0._readyForCustomFocus == false then
		return false
	elseif f363_arg0._customGainFocusWidgets then
		for f363_local3, f363_local4 in ipairs(f363_arg0._customGainFocusWidgets) do
			if CoD.HUDUtility.GiveFocus(f363_local4, f363_arg1) then
				return true
			end
		end
		return false
	elseif f363_arg0._readyForCustomFocus then
		return f363_arg0:processEvent({
			name = "gain_focus",
			controller = f363_arg1,
		})
	end
end
CoD.HUDUtility.GiveFocusToMenu = function(f364_arg0, f364_arg1)
	CoD.HUDUtility.GiveFocus(f364_arg0, f364_arg1)
end
CoD.HUDUtility.AddCustomGainFocusWidget = function(f365_arg0, f365_arg1)
	if not f365_arg0._customGainFocusWidgets then
		f365_arg0._customGainFocusWidgets = {}
	end
	if f365_arg1._readyForCustomFocus == nil then
		f365_arg1._readyForCustomFocus = true
	end
	table.insert(f365_arg0._customGainFocusWidgets, f365_arg1)
end
CoD.HUDUtility.ClearCustomGainFocusWidgets = function(f366_arg0)
	f366_arg0._customGainFocusWidgets = {}
end
CoD.HUDUtility.PushAllowButtonRepeats = function(f367_arg0, f367_arg1)
	if f367_arg0._allowingButtonRepeats then
		return
	else
		f367_arg0._allowingButtonRepeats = true
		Engine[0x8BD6378ACE0B73A](f367_arg1)
	end
end
CoD.HUDUtility.PopAllowButtonRepeats = function(f368_arg0, f368_arg1)
	if not f368_arg0._allowingButtonRepeats then
		return
	else
		f368_arg0._allowingButtonRepeats = nil
		Engine[0x582D5FD52C48523](f368_arg1)
	end
end
CoD.HUDUtility.SetAsCurrentMultiItemPickup = function(f369_arg0, f369_arg1)
	local f369_local0 = DataSources.MultiItemPickup.getModel(f369_arg0)
	f369_local0.currentSelection:set(f369_arg1:getModel())
end
CoD.HUDUtility.IsValidListToUpdateTabCount = function(f370_arg0, f370_arg1)
	local f370_local0 = function(f371_arg0, f371_arg1)
		return CoD.isPC and IsMouseOrKeyboard(f371_arg1) and f371_arg0.__isForKBM
	end
	local f370_local1 = function(f372_arg0, f372_arg1)
		return IsGamepad(f372_arg1) and f372_arg0.__isForGamepad
	end
	local f370_local2 = f370_local0(f370_arg0, f370_arg1)
	if not f370_local2 then
		f370_local2 = f370_local1(f370_arg0, f370_arg1)
	end
	return f370_local2
end
DataSourceHelpers.PerControllerDataSourceSetup(
	"MultiItemPickup",
	"hudItems.multiItemPickup",
	function(f373_arg0, f373_arg1)
		local f373_local0 = f373_arg0:create("count")
		f373_local0:set(0)
		f373_local0 = f373_arg0:create("status")
		f373_local0:set(Enum[0x163CDAE6010C493][0xE16E7DEBC8823D8])
		f373_local0 = f373_arg0:create("tabCount")
		f373_local0:set(1)
		f373_local0 = f373_arg0:create("currentTabIndex")
		f373_local0:set(1)
		f373_arg0:create("currentSelection")
		f373_arg0:create("forceNotifyActive")
		f373_arg0:create("forceNotifyAmmoList")
	end,
	false,
	{
		prepare = function(f374_arg0, f374_arg1, f374_arg2)
			if not f374_arg1._rootModel then
				f374_arg1._rootModel = DataSources.MultiItemPickup.getModel(f374_arg0)
				f374_arg1:subscribeToModel(f374_arg1._rootModel.count, function()
					if CoD.HUDUtility.IsValidListToUpdateTabCount(f374_arg1, f374_arg0) and f374_arg1.vCount > 1 then
						f374_arg1._rootModel.tabCount:set(math.ceil(math.ceil(f374_arg1._rootModel.count:get() / f374_arg1.hCount) / f374_arg1.vCount))
						f374_arg1._rootModel.currentTabIndex:set(1)
					end
					if IsIntDvarNonZero("tabbedMultiItemPickup") then
						CoD.WZUtility.HackUpdateListDataSourceAfterDelay(f374_arg1, true, false, false, 0)
					else
						f374_arg1:clearLayout()
						CoD.WZUtility.HackUpdateListDataSourceAfterDelay(f374_arg1, true, false, true, 0)
						if f374_arg1._currentSelectionId then
							f374_arg1:findItem({
								id = f374_arg1._currentSelectionId,
							}, nil, true, nil)
							f374_arg1._currentSelectionId = nil
						end
					end
				end, false)
				f374_arg1._dummyModel = f374_arg1._rootModel:create("dummyItem")
				local f374_local0 = f374_arg1._dummyModel:create("isDummy")
				f374_local0:set(true)
				f374_local0 = f374_arg1._dummyModel:create("icon")
				f374_local0:set(0x7615068F50B3D66)
				f374_local0 = f374_arg1._dummyModel:create("stackCount")
				f374_local0:set(0)
				f374_local0 = f374_arg1._dummyModel:create("stashStackSize")
				f374_local0:set(0)
				f374_local0 = f374_arg1._dummyModel:create("collapsed")
				f374_local0:set(false)
				f374_arg1._collapsedModel = f374_arg1._rootModel:create("collapsedItem")
				f374_local0 = f374_arg1._collapsedModel:create("collapsed")
				f374_local0:set(true)
				LUI.OverrideFunction_CallOriginalFirst(f374_arg1, "pageDown", function()
					f374_arg1._rootModel.currentTabIndex:set(math.ceil(f374_arg1.currentStartRow / f374_arg1.vCount))
				end)
				LUI.OverrideFunction_CallOriginalFirst(f374_arg1, "pageUp", function()
					f374_arg1._rootModel.currentTabIndex:set(math.ceil(f374_arg1.currentStartRow / f374_arg1.vCount))
				end)
			end
		end,
		getCount = function(f378_arg0)
			if f378_arg0.vCount > 1 then
				local f378_local0 = f378_arg0._rootModel.count:get()
				if IsMouseOrKeyboard(f378_arg0.controller) then
					return f378_local0
				end
				local f378_local1 = math.ceil(f378_local0 / f378_arg0.hCount)
				if f378_arg0.vCount < f378_local1 then
					f378_local1 = math.ceil(f378_local1 / f378_arg0.vCount) * f378_arg0.vCount
				end
				return math.max(f378_local1, f378_arg0.vCount) * f378_arg0.hCount
			else
				return f378_arg0._rootModel.count:get() + (IsMouseOrKeyboard(f378_arg0.controller) and 0 or math.floor(f378_arg0.hCount / 2))
			end
		end,
		getItem = function(f379_arg0, f379_arg1, f379_arg2)
			if f379_arg1.vCount > 1 then
				local f379_local0 = f379_arg1._rootModel.count:get()
				if IsMouseOrKeyboard(f379_arg1.controller) or f379_arg2 <= f379_local0 then
					local f379_local1 = f379_arg1._rootModel["item" .. f379_arg2 - 1]
					local f379_local2 = f379_local1:create("isDummy")
					f379_local2:set(false)
					f379_local2 = f379_local1:create("collapsed")
					f379_local2:set(false)
					return f379_arg1._rootModel["item" .. f379_arg2 - 1]
				else
					local f379_local1 = math.ceil(f379_arg2 / f379_arg1.hCount)
					local f379_local2 = math.ceil(f379_local0 / f379_arg1.hCount)
					if f379_local1 <= f379_local2 or f379_arg1.vCount < f379_local2 then
						return f379_arg1._dummyModel
					else
						return f379_arg1._collapsedModel
					end
				end
			elseif not IsMouseOrKeyboard(f379_arg0) and f379_arg2 < f379_arg1.hCount / 2 then
				return f379_arg1._dummyModel
			elseif IsMouseOrKeyboard(f379_arg0) then
				local f379_local3 = f379_arg2
			end
			return f379_arg1._rootModel["item" .. f379_local3 or f379_arg2 - math.floor(f379_arg1.hCount / 2) - 1]
		end,
		getSpacerAfterRow = function(f380_arg0, f380_arg1, f380_arg2)
			if f380_arg0.vCount > 1 and not IsMouseOrKeyboard(f380_arg0.controller) then
				local f380_local0 = math.ceil(f380_arg0._rootModel.count:get() / f380_arg0.hCount)
				if f380_local0 <= f380_arg1 and f380_local0 <= f380_arg0.vCount then
					return -f380_arg0.spacing
				end
			end
			return 0
		end,
	}
)
DataSourceHelpers.PerControllerDataSourceSetup("MultiItemPickupTab", "hudItems.multiItemPickup.tabs", function(f381_arg0, f381_arg1) end, false, {
	prepare = function(f382_arg0, f382_arg1, f382_arg2)
		if not f382_arg1._rootModel then
			f382_arg1._rootModel = DataSources.MultiItemPickupTab.getModel(f382_arg0)
			local f382_local0 = f382_arg1
			local f382_local1 = f382_arg1.subscribeToModel
			local f382_local2 = DataSources.MultiItemPickup.getModel(f382_arg0)
			f382_local1(f382_local0, f382_local2.tabCount, function()
				f382_arg1:clearLayout()
				CoD.WZUtility.HackUpdateListDataSourceAfterDelay(f382_arg1, false, false, false, 0)
			end, false)
			f382_local0 = f382_arg1
			f382_local1 = f382_arg1.subscribeToModel
			f382_local2 = DataSources.MultiItemPickup.getModel(f382_arg0)
			f382_local1(f382_local0, f382_local2.currentTabIndex, function()
				f382_arg1:clearLayout()
				CoD.WZUtility.HackUpdateListDataSourceAfterDelay(f382_arg1, false, false, false, 0)
			end, false)
			f382_arg1._unselectedTab = f382_arg1._rootModel:create("unselectedTab")
			f382_arg1._selectedTab = f382_arg1._rootModel:create("selectedTab")
			f382_local1 = f382_arg1._selectedTab:create("selected")
			f382_local1:set(true)
			f382_arg1._leftBumper = f382_arg1._rootModel:create("leftBumper")
			f382_local1 = f382_arg1._leftBumper:create("leftBumper")
			f382_local1:set(true)
			f382_arg1._rightBumper = f382_arg1._rootModel:create("rightBumper")
			f382_local1 = f382_arg1._rightBumper:create("rightBumper")
			f382_local1:set(true)
		end
	end,
	getCount = function(f385_arg0)
		local f385_local0 = DataSources.MultiItemPickup.getModel(f385_arg0.controller)
		f385_local0 = f385_local0.tabCount:get()
		if f385_local0 > 1 then
			return f385_local0 + 2
		else
			return 0
		end
	end,
	getItem = function(f386_arg0, f386_arg1, f386_arg2)
		if f386_arg2 == 1 then
			return f386_arg1._leftBumper
		else
			local f386_local0 = f386_arg2 - 1
			local f386_local1 = DataSources.MultiItemPickup.getModel(f386_arg0)
			if f386_local0 == f386_local1.currentTabIndex:get() then
				return f386_arg1._selectedTab
			else
				f386_local0 = f386_arg2 - 1
				f386_local1 = DataSources.MultiItemPickup.getModel(f386_arg1.controller)
				if f386_local1.tabCount:get() < f386_local0 then
					return f386_arg1._rightBumper
				else
					return f386_arg1._unselectedTab
				end
			end
		end
	end,
})
CoD.HUDUtility.SetDataSourceModelToSelectedIndex = function(f387_arg0, f387_arg1, f387_arg2, f387_arg3)
	local f387_local0 = f387_arg3.gridInfoTable.zeroBasedIndex
	local f387_local1 = DataSources[f387_arg1].getModel(f387_arg0)
	f387_local1[f387_arg2]:set(f387_local0)
end
CoD.HUDUtility.SetupMonitorForClipActive = function(f388_arg0)
	f388_arg0._isPlaying = nil
	f388_arg0:registerEventHandler("clip_over", function(element, event)
		element._isPlaying = nil
		LUI.UIElement.clipOver(element, event)
	end)
end
CoD.HUDUtility.RegisterArmorDamageStageClip = function(f390_arg0, f390_arg1, f390_arg2)
	if not f390_arg0._stageClips then
		f390_arg0._stageClips = {}
	end
	f390_arg0._stageClips[tonumber(f390_arg1)] = f390_arg2
end
CoD.HUDUtility.PlayArmorDamageClip = function(f391_arg0, f391_arg1)
	local f391_local0 = f391_arg1:get()
	if f391_arg0._stageClips and f391_arg0._stageClips[f391_local0] then
		local f391_local1 = f391_arg0._stageClips[f391_local0]
		if f391_arg0._isPlaying then
			f391_arg0.nextClip = f391_local1
		else
			f391_arg0._isPlaying = true
			f391_arg0:playClip(f391_local1)
		end
	end
end
CoD.HUDUtility.IsArmorAtFullHealth = function(f392_arg0)
	local f392_local0 = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f392_arg0))
	local f392_local1 = f392_local0.armor and f392_local0.armor:get() or 0
	local f392_local2 = f392_local0.armorMax and f392_local0.armorMax:get() or 0
	local f392_local3
	if f392_local2 <= 0 or f392_local1 ~= f392_local2 then
		f392_local3 = false
	else
		f392_local3 = true
	end
	return f392_local3
end
CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenAmmo = function(f393_arg0)
	if CoD.HUDUtility.HiddenAmmoWeapons == nil then
		local f393_local0 = {
			0xA13D89BA9FBCA24,
			0x386C26FBBB5544,
			0x3B55382AF4BD7AB,
			0xD333D04C24A8E0,
			0x7B0E02B21CA4B07,
			0x24A0E39E2CD5532,
			0x870EFC1575EBB12,
			0x3DF876F5EC00D2C,
			0x156A3B0E81C372F,
			0x5184D02E502ACD9,
			0x8A1C8291D55129D,
			0x30A5823B06EF289,
			0x13E51B223A9D0B5,
			0x65A2EBAA201D495,
			0x8D46D6D3C93330B,
			0x562979F67BFEFFF,
			0x26C5489CFFA7C30,
			0x2FBE0D2D902501,
			0x5616C6730A7DCC8,
			0x2EC0918F04F7165,
			0x5B9FCAA74732856,
			0x82ECE2084CFFB6D,
		}
		local f393_local1 = {
			0xC0D17BAD169557B,
			0xDA3712362F9CCBE,
		}
		CoD.HUDUtility.HiddenAmmoWeapons = {}
		local f393_local2 = string.lower(CoD.gameMode)
		for f393_local6, f393_local7 in ipairs(f393_local0) do
			CoD.HUDUtility.HiddenAmmoWeapons[f393_local7 .. "_" .. f393_local2] = true
		end
	end
	return CoD.HUDUtility.HiddenAmmoWeapons[CoD.SafeGetModelValue(DataSources.CurrentWeapon.getModel(f393_arg0), "viewmodelWeaponName")]
end
CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenDWAmmo = function(f394_arg0)
	if CoD.HUDUtility.HiddenDWAmmoWeapons == nil then
		local f394_local0 = {
			0xAB1184700CE0AA6,
			0x882E337D28EC4DF,
		}
		local f394_local1 = {
			0xC0D17BAD169557B,
		}
		CoD.HUDUtility.HiddenDWAmmoWeapons = {}
		local f394_local2 = string.lower(CoD.gameMode)
		for f394_local6, f394_local7 in ipairs(f394_local0) do
			CoD.HUDUtility.HiddenDWAmmoWeapons[f394_local7 .. "_" .. f394_local2] = true
		end
		for f394_local6, f394_local7 in ipairs(f394_local1) do
			CoD.HUDUtility.HiddenDWAmmoWeapons[f394_local7] = true
		end
	end
	return CoD.HUDUtility.HiddenDWAmmoWeapons[CoD.SafeGetModelValue(DataSources.CurrentWeapon.getModel(f394_arg0), "equippedWeaponReference")]
end
CoD.HUDUtility.GetArmorBarWipe = function(f395_arg0, f395_arg1, f395_arg2, f395_arg3, f395_arg4, f395_arg5)
	local f395_local0 = f395_arg0
	local f395_local1 = f395_arg0.armorMax
	if f395_local1 then
		f395_local1 = f395_local0 and f395_arg0.armorMax:get()
	end
	if f395_local1 and f395_local1 > 0 then
		return 0, math.min(1, math.max(0, f395_arg2 / f395_local1)), 0, 1
	else
		return 0, 0, 0, 0
	end
end
CoD.HUDUtility.PlayUltimateProgressPulseClip = function(f396_arg0, f396_arg1, f396_arg2, f396_arg3)
	if not f396_arg0:getModel() then
		return
	end
	local f396_local0 = f396_arg0:getModel()
	f396_local0 = f396_local0.powerRatio:get()
	if f396_local0 then
		local f396_local1 = f396_arg0
		local f396_local2 = nil
		if f396_local1[f396_arg1.elementName] then
			f396_local2 = f396_arg0[f396_arg1.elementName]
			f396_local2:playClip(f396_arg1.clipName)
			f396_local2._pulseTimer = LUI.UITimer.new(f396_arg2 * f396_local0, "pulse_finished", true, f396_local1)
			f396_local2:addElement(f396_local2._pulseTimer)
		else
			return
		end
	end
end
CoD.HUDUtility.RegisterUltimatePulseFinished = function(f397_arg0, f397_arg1)
	f397_arg0:registerEventHandler("pulse_finished", function()
		f397_arg0:playClip(f397_arg1)
	end)
end
DataSources.TeammateHealTargeting = {
	preparedForController = {},
	subscriptions = {},
	prepare = function(f399_arg0)
		if not DataSources.TeammateHealTargeting.preparedForController then
			DataSources.TeammateHealTargeting.preparedForController = {}
		end
		if not DataSources.TeammateHealTargeting.subscriptions[f399_arg0] then
			DataSources.TeammateHealTargeting.subscriptions[f399_arg0] = LUI.UIElement.new()
		end
		DataSources.TeammateHealTargeting.subscriptions[f399_arg0]:unsubscribeFromAllModels()
		DataSources.TeammateHealTargeting.preparedForController[f399_arg0] = true
		local f399_local0 = Engine[0x4DF5CFBC1771947](f399_arg0)
		f399_local0 = f399_local0:create("teammateHealTargeting")
		local f399_local1 = f399_local0:create("targetClient")
		DataSources.TeammateHealTargeting.subscriptions[f399_arg0]:subscribeToModel(f399_local0:create("targetClientNum"), function(model)
			local f400_local0 = model:get()
			if f400_local0 ~= LuaDefine.INVALID_CLIENT_INDEX then
				f399_local1:set(Engine[0xE4D2F32833CFA6C](f400_local0))
			end
		end, false)
	end,
	getModel = function(f401_arg0)
		if not DataSources.TeammateHealTargeting.preparedForController or not DataSources.TeammateHealTargeting.preparedForController[f401_arg0] then
			DataSources.TeammateHealTargeting.prepare(f401_arg0)
		end
		local f401_local0 = Engine[0x4DF5CFBC1771947](f401_arg0)
		return f401_local0.teammateHealTargeting
	end,
}
CoD.HUDUtility.InitTeammateHealTargeting = function(f402_arg0, f402_arg1)
	DataSources.TeammateHealTargeting.getModel(f402_arg1)
	f402_arg0:setupTeammateHealTargeting()
end
CoD.HUDUtility.InitTeammateHealTargetingScreen = function(f403_arg0, f403_arg1, f403_arg2)
	if not f403_arg0.__teammateHealTargetingScreen then
		f403_arg0.__teammateHealTargetingScreen = CoD.TabletTak5.new(f403_arg2, f403_arg1, 0, 0, 0, CoD.TabletTak5.__defaultWidth, 0, 0, 0, CoD.TabletTak5.__defaultHeight)
		f403_arg0:addElement(f403_arg0.__teammateHealTargetingScreen)
		f403_arg2:sendInitializationEvents(f403_arg1, f403_arg0.__teammateHealTargetingScreen)
		LUI.OverrideFunction_CallOriginalSecond(f403_arg0, "close", function()
			if f403_arg0.__teammateHealTargetingScreen then
				f403_arg0.__teammateHealTargetingScreen:close()
				f403_arg0.__teammateHealTargetingScreen = nil
			end
		end)
		LUI.OverrideFunction_CallOriginalSecond(f403_arg0.__teammateHealTargetingScreen, "close", function()
			f403_arg0.__teammateHealTargetingScreen = nil
		end)
	end
end
CoD.HUDUtility.IsTeammateHealTargeting = function(f406_arg0)
	local f406_local0 = DataSources.TeammateHealTargeting.getModel(f406_arg0)
	f406_local0 = f406_local0.status
	local f406_local1 = f406_local0 and f406_local0:get()
	if f406_local1 then
		return CoD.BitUtility.IsBitwiseAndNonZero(f406_local1, Enum[0x1E41697AC99B868][0x9A83688E2A4D78])
	else
		return false
	end
end
CoD.HUDUtility.IsTeammateHealTargetAlreadyBoosted = function(f407_arg0)
	local f407_local0 = DataSources.TeammateHealTargeting.getModel(f407_arg0)
	f407_local0 = f407_local0.targetClientNum
	local f407_local1 = f407_local0 and f407_local0:get()
	if f407_local1 and f407_local1 ~= LuaDefine.INVALID_CLIENT_INDEX then
		local f407_local2 = Engine[0xE4D2F32833CFA6C](f407_local1)
		return (f407_local2.health.maxHealth:get() or 0) < (f407_local2.health.maxHealthRegen:get() or 0)
	else
		return false
	end
end
CoD.HUDUtility.AbilityFlashIsFull = function(f408_arg0, f408_arg1)
	local f408_local0 = CoD.isWarzone
	if not f408_local0 then
		f408_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(f408_arg0, f408_arg1, "state", Enum[0xF0447219F15F7F3][0x1CF78BFE5F942F1], Enum[0xF0447219F15F7F3][0x194F4FEC53470DF])
	end
	return f408_local0
end
CoD.HUDUtility.CheckIfHoldOrToggle = function(f409_arg0, f409_arg1)
	if not CoD.isPC then
		return f409_arg1
	elseif f409_arg1 == CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_RADIATION_FIELD and Engine[0xB72F603CAC75B3A](f409_arg0, "radiation_toggle") == 1 then
		return CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_RADIATION_FIELD_PRESS
	elseif f409_arg1 == CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BATTLESHIELD then
		local f409_local0, f409_local1 = Engine[0x7C4C4DBF61B869E](f409_arg0, "+toggleads_throw", 0)
		if f409_local0 ~= "" then
			local f409_local2 = f409_local0
		end
		if (f409_local2 or f409_local1) ~= "" then
			return CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BATTLESHIELD_TOGGLE
		elseif Engine[0xB72F603CAC75B3A](f409_arg0, "altads_toggle") == 1 then
			return CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_BATTLESHIELD_PRESS
		end
	end
	return f409_arg1
end
CoD.HUDUtility.GetSpecialistWeaponHintString = function(f410_arg0, f410_arg1)
	return Engine[0xF9F1239CFD921FE](CoD.HUDUtility.SpecialistWeaponHints[CoD.HUDUtility.CheckIfHoldOrToggle(f410_arg0, f410_arg1)] or 0x0)
end
CoD.HUDUtility.GetSpecialistWeaponHintStringLower = function(f411_arg0, f411_arg1)
	local f411_local0 = CoD.HUDUtility.SpecialistWeaponHintsLower[f411_arg1]
	local f411_local1
	if f411_local0 then
		f411_local1 = f411_local0[f411_arg0]
		if not f411_local1 then
		else
			return Engine[0xF9F1239CFD921FE](f411_local1)
		end
	end
	f411_local1 = 0x0
end
CoD.HUDUtility.SpecialistWeaponHintStringLowerNumElements = function(f412_arg0, f412_arg1)
	local f412_local0 = DataSources.HUDItems.getModel(f412_arg0)
	f412_local0 = f412_local0.abilityHintIndex
	local f412_local1
	if f412_local0 then
		f412_local1 = f412_local0:get()
		if not f412_local1 then
		else
			local f412_local2 = CoD.HUDUtility.SpecialistWeaponHintsLower[f412_local1]
			return f412_local2 and #f412_local2 == f412_arg1
		end
	end
	f412_local1 = CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_NONE
end
CoD.HUDUtility.DisallowXButtonPressForTime = function(f413_arg0, f413_arg1, f413_arg2)
	f413_arg1._disallowXButtonPress = true
	f413_arg1:addElement(LUI.UITimer.newElementTimer(f413_arg2, true, function()
		f413_arg1._disallowXButtonPress = nil
	end))
end
CoD.HUDUtility.AreXButtonPressesDisallowed = function(f415_arg0)
	return f415_arg0._disallowXButtonPress
end
DataSources.KillcamEquipment = DataSourceHelpers.ListSetup(
	"KillcamEquipment",
	function(f416_arg0)
		local f416_local0 = {}
		local f416_local1 = {}
		local f416_local2 = {}
		local f416_local3 = {
			Enum[0xF0AA273B133F18C][0x2BA0618DA75FC65],
			Enum[0xF0AA273B133F18C][0x2BA0318DA75F74C],
			Enum[0xF0AA273B133F18C][0x2BA0418DA75F8FF],
			Enum[0xF0AA273B133F18C][0x2BC73D8834F0281],
			Enum[0xF0AA273B133F18C][0x513F5D8C15D723],
		}
		local f416_local4 = CoD.CACUtility.GetUnlockableItemTable()
		local f416_local5 = function(f417_arg0, f417_arg1)
			return f417_arg0.sortIndex < f417_arg1.sortIndex
		end
		local f416_local6 = function(f418_arg0)
			local f418_local0 = f416_local4[f418_arg0]
			if f418_local0 then
				local f418_local1 = {
					name = f418_local0.displayName,
					icon = f418_local0.previewImage,
					loadoutSlotIndex = f418_local0.loadoutSlotIndex,
					sortIndex = f418_local0[0xD909934375BE707],
				}
				if not f416_local2[f418_local0.loadoutSlotIndex] then
					f416_local2[f418_local0.loadoutSlotIndex] = 1
				else
					f416_local2[f418_local0.loadoutSlotIndex] = f416_local2[f418_local0.loadoutSlotIndex] + 1
				end
				table.insert(f416_local1, f418_local1)
			end
		end
		local f416_local7 = Engine[0x4DF5CFBC1771947](f416_arg0)
		f416_local7 = f416_local7.talents
		if f416_local7 then
			local f416_local8 = f416_local7.count
			local f416_local9 = f416_local7.count:get()
		end
		local f416_local10 = f416_local8 and f416_local9 or 0
		for f416_local11 = 0, f416_local10 - 1, 1 do
			local f416_local14 = f416_local7["talent" .. f416_local11]
			if f416_local14 then
				local f416_local15 = f416_local14.itemIndex
				if f416_local15 then
					f416_local15 = f416_local14.itemIndex:get()
				end
				f416_local6(f416_local15)
			end
		end
		local f416_local11 = DataSources.PlayerAbilities.getModel(f416_arg0)
		f416_local11 = f416_local11.playerGadget0
		local f416_local16 = f416_local11
		local f416_local12 = f416_local11.itemIndex
		if f416_local12 then
			f416_local12 = f416_local16 and f416_local11.itemIndex:get()
		end
		f416_local6(f416_local12)
		table.sort(f416_local1, f416_local5)
		for f416_local15, f416_local19 in pairs(f416_local3) do
			if f416_local2[f416_local19] and f416_local2[f416_local19] > 0 then
				local f416_local18 = "KillcamEquipmentGroup_" .. f416_local19
				DataSources[f416_local18] = DataSourceHelpers.ListSetup(f416_local18, function(f419_arg0)
					local f419_local0 = {}
					for f419_local4, f419_local5 in ipairs(f416_local1) do
						if f419_local5.loadoutSlotIndex == f416_local19 then
							table.insert(f419_local0, {
								models = {
									name = f419_local5.name,
									icon = f419_local5.icon,
								},
							})
						end
					end
					return f419_local0
				end, true)
				table.insert(f416_local0, {
					models = {
						groupDatasource = f416_local18,
					},
				})
			end
		end
		return f416_local0
	end,
	nil,
	nil,
	function(f420_arg0, f420_arg1, f420_arg2)
		if not f420_arg1.__killcamEquipmentListCustomSubscriptions then
			f420_arg1.__killcamEquipmentListCustomSubscriptions = true
			local f420_local0 = Engine[0x4DF5CFBC1771947](f420_arg0)
			f420_local0 = f420_local0.talents
			local f420_local1 = f420_local0 and f420_local0.anyTalentChanged
			if f420_local1 then
				f420_arg1:subscribeToModel(f420_local1, function(model)
					if CoD.SpawnSelectionUtility.IsKillcamActive(f420_arg0) then
						f420_arg1:clearLayout()
						f420_arg1:updateDataSource()
					end
				end)
			end
			local f420_local2 = DataSources.PlayerAbilities.getModel(f420_arg0)
			f420_local2 = f420_local2.playerGadget0
			local f420_local3 = f420_local2 and f420_local2.itemIndex
			if f420_local3 then
				f420_arg1:subscribeToModel(f420_local3, function(model)
					if CoD.SpawnSelectionUtility.IsKillcamActive(f420_arg0) then
						f420_arg1:clearLayout()
						f420_arg1:updateDataSource()
					end
				end)
			end
		end
	end
)
CoD.HUDUtility.GetKillcamAttackerClanTagAndName = function(f423_arg0, f423_arg1)
	if DataSources.Attacker then
		local f423_local0 = DataSources.Attacker.getModel(f423_arg0)
		if f423_local0 then
			local f423_local1 = f423_local0.clanTag
			if f423_local1 then
				f423_local1 = f423_local0.clanTag:get()
			end
			local f423_local2 = f423_local0.name
			if f423_local2 then
				f423_local2 = f423_local0.name:get()
			end
			return StringAsClanTag(f423_local1) .. f423_local2
		end
	end
	return f423_arg1
end
CoD.HUDUtility.GetKillcamVictimClanTagAndName = function(f424_arg0, f424_arg1)
	if DataSources.Victim then
		local f424_local0 = DataSources.Victim.getModel(f424_arg0)
		if f424_local0 then
			local f424_local1 = f424_local0.clanTag
			if f424_local1 then
				f424_local1 = f424_local0.clanTag:get()
			end
			local f424_local2 = f424_local0.name
			if f424_local2 then
				f424_local2 = f424_local0.name:get()
			end
			return StringAsClanTag(f424_local1) .. f424_local2
		end
	end
	return f424_arg1
end
CoD.HUDUtility.MatchOrRoundBeginsIn = function(f425_arg0)
	local f425_local0 = f425_arg0
	if f425_local0 ~= nil and f425_local0 > 0 then
		return 0xEF8CAA66D05D1B8
	else
		return 0x8E58CC95DB34427
	end
end
CoD.HUDUtility.OpenStartMenu = function(f426_arg0, f426_arg1)
	f426_arg0:dispatchEventToRoot({
		name = "open_ingame_menu",
		uiMenuCommand = Enum[0x52E616D9ABDBF0E][0x10B85D42D527608],
		menuName = "StartMenu_Main",
		controller = f426_arg1,
		unpausable = 0,
	})
end
CoD.HUDUtility.ForceStreamedSpraysAndGesturesImages = {}
DataSources.SpraysAndGestures = DataSourceHelpers.ListSetup("SpraysAndGestures", function(f427_arg0, f427_arg1)
	local f427_local0 = {}
	local f427_local1 = {}
	local f427_local2 = Engine[0xB2E4CCC119597B0]()
	for f427_local7, f427_local8 in ipairs(Engine[0x88987BA1B9D616B](f427_arg0, Engine[0x3EAC408F958FF05]())) do
		if f427_local7 ~= 1 then
			local f427_local6 = f427_local2[f427_local8]
			if f427_local6 then
				CoD.CACUtility.AddToTableIfNotEmpty(f427_local1, f427_local6[0xBFF4CC56C2092F0])
				table.insert(f427_local0, {
					models = {
						image = f427_local6[0xBFF4CC56C2092F0],
						displayName = f427_local6[0xA31296C0C1B6029],
						index = f427_local7 - 2,
						item_index = f427_local8 - 1,
						chosen = false,
						assetName = f427_local6[0x14C91FFB3BA4240],
					},
					properties = {},
				})
			else
				table.insert(f427_local0, {
					models = {
						image = 0x7615068F50B3D66,
						displayName = 0x0,
						index = f427_local7 - 2,
						item_index = 0,
						chosen = false,
						assetName = 0x0,
					},
					properties = {},
				})
			end
		end
	end
	CoD.HUDUtility.ForceStreamedSpraysAndGesturesImages = CoD.BaseUtility.ForceStreamHelper(CoD.HUDUtility.ForceStreamedSpraysAndGesturesImages, f427_local1)
	return f427_local0
end, nil)
CoD.HUDUtility.SetupQuickSprayModels = function(f428_arg0, f428_arg1)
	DataSources.QuickSpray.recreate(f428_arg0)
end
DataSourceHelpers.PerControllerDataSourceSetup("QuickSpray", "QuickSpray", function(f429_arg0, f429_arg1)
	f429_arg0:create("image")
	f429_arg0:create("displayName")
	f429_arg0:create("index")
	local f429_local0 = nil
	local f429_local1 = 0
	local f429_local2 = Engine[0x3EAC408F958FF05]()
	if f429_local2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or f429_local2 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		local f429_local3 = Engine[0xB2E4CCC119597B0]()
		local f429_local4 = Engine[0x88987BA1B9D616B](f429_arg1, f429_local2)
		f429_local1 = f429_local4[1]
		f429_local0 = f429_local3[f429_local1]
	end
	local f429_local3 = f429_arg0.image
	local f429_local4 = f429_local3
	f429_local3 = f429_local3.set
	local f429_local5
	if f429_local0 then
		f429_local5 = f429_local0[0xBFF4CC56C2092F0]
		if not f429_local5 then
		else
			f429_local3(f429_local4, f429_local5)
			f429_local3 = f429_arg0.displayName
			f429_local4 = f429_local3
			f429_local3 = f429_local3.set
			if f429_local0 then
				f429_local5 = f429_local0[0xA31296C0C1B6029]
				if not f429_local5 then
				else
					f429_local3(f429_local4, f429_local5)
					f429_local3 = f429_arg0.index
					f429_local4 = f429_local3
					f429_local3 = f429_local3.set
					if f429_local0 then
						f429_local5 = f429_local1 - 1
						if not f429_local5 then
						else
							f429_local3(f429_local4, f429_local5)
						end
					end
					f429_local5 = -1
				end
			end
			f429_local5 = 0x0
		end
	end
	f429_local5 = 0x7615068F50B3D66
end, false)
CoD.HUDUtility.MenuDelayedSetRightStickLock = function(f430_arg0, f430_arg1, f430_arg2, f430_arg3)
	if f430_arg0._delayedSetLockTimer ~= nil then
		f430_arg0._delayedSetLockTimer:close()
		f430_arg0._delayedSetLockTimer = nil
		if f430_arg0._isLocked == f430_arg3 then
			return
		end
	end
	if not f430_arg0._hasHidingRightStickUnlock then
		f430_arg0._hasHidingRightStickUnlock = true
		LUI.OverrideFunction_CallOriginalFirst(f430_arg0, "close", function()
			Engine[0x64C13158F7FF920](f430_arg1, false)
		end)
	end
	if f430_arg2 == 0 then
		Engine[0x64C13158F7FF920](f430_arg1, f430_arg3)
		f430_arg0._isLocked = f430_arg3
	else
		f430_arg0._delayedSetLockTimer = LUI.UITimer.newElementTimer(f430_arg2, true, function()
			Engine[0x64C13158F7FF920](f430_arg1, f430_arg3)
			f430_arg0._delayedSetLockTimer = nil
			f430_arg0._isLocked = f430_arg3
		end)
		f430_arg0:addElement(f430_arg0._delayedSetLockTimer)
	end
end
CoD.HUDUtility.UpdateStickSelectionModel = function(f433_arg0, f433_arg1, f433_arg2, f433_arg3, f433_arg4)
	if f433_arg0._gamepadSelectionEnabled or f433_arg4 then
		local f433_local0 = f433_arg2:getTotalCount()
		if f433_local0 ~= nil and f433_local0 > 0 then
			local f433_local1 = f433_arg3.Degrees
			if not f433_arg0._gamepadSelectionEnabled and f433_arg4 then
				local f433_local2 = Engine[0x4DF5CFBC1771947](f433_arg1)
				f433_local1 = f433_local2.hudItems.wheelPointerDegrees
			end
			local f433_local2 = 360 / f433_local0
			local f433_local3 = math.floor((f433_local1:get() + 270 + f433_local2 * 0.5) % 360 / f433_local2)
			if f433_arg3.SelectedWedge:set(f433_local3) then
				f433_arg2:playSound("wheel_changed")
			end
			local f433_local4 = Engine[0x4DF5CFBC1771947](f433_arg1)
			f433_local4.hudItems.wheelPointerDegrees:set(f433_local1:get())
			f433_arg2._lastSelectedWedgeIndex = f433_local3
		end
	else
		f433_arg3.SelectedWedge:set(-1)
	end
end
CoD.HUDUtility.UpdateSelectionModelFromDegrees = function(f434_arg0, f434_arg1, f434_arg2, f434_arg3)
	CoD.HUDUtility.UpdateStickSelectionModel(f434_arg1, f434_arg0, f434_arg2, f434_arg2:getStickModel(f434_arg0), f434_arg3)
end
CoD.HUDUtility.UpdateCurrentStickSelectionModelOnPC = function(f435_arg0, f435_arg1, f435_arg2)
	local f435_local0 = f435_arg2:getTotalCount()
	if f435_local0 ~= nil and f435_local0 > 0 then
		local f435_local1 = f435_arg2:getStickModel(f435_arg1)
		local f435_local2 = DataSources.FreeCursor.getModel(f435_arg1)
		local f435_local3, f435_local4 = f435_local2.position:get()
		local f435_local5 = f435_arg2:getCenter()
		if not f435_local5 then
			return
		elseif math.sqrt(math.pow(f435_local3 - f435_local5.x, 2) + math.pow(f435_local4 - f435_local5.y, 2)) < 50 then
			f435_local1.SelectedWedge:set(-1)
			local f435_local6 = Engine[0x4DF5CFBC1771947](f435_arg1)
			f435_local6.hudItems.wheelPointerDegrees:set(0)
			f435_arg2._lastSelectedWedgeIndex = -1
			return
		end
		local f435_local7 = math.atan2(f435_local3 - f435_local5.x, f435_local4 - f435_local5.y) * 180 / math.pi
		local f435_local8 = 360 / f435_local0
		local f435_local9 = math.floor((f435_local7 + 180 + f435_local8 * 0.5) % 360 / f435_local8)
		if f435_local1.SelectedWedge:set(f435_local9) then
			f435_arg2:playSound("wheel_changed")
		end
		local f435_local10 = (f435_local9 + 2) % f435_local0
		local f435_local11 = Engine[0x4DF5CFBC1771947](f435_arg1)
		f435_local11.hudItems.wheelPointerDegrees:set(f435_local10 * f435_local8)
		f435_arg2._lastSelectedWedgeIndex = f435_local9
	end
end
CoD.HUDUtility.UpdateSelectionModelFromLength = function(f436_arg0, f436_arg1, f436_arg2, f436_arg3, f436_arg4)
	local f436_local0 = f436_arg2:getStickModel(f436_arg0)
	local f436_local1 = f436_arg3:get()
	if f436_arg1._gamepadSelectionEnabled then
		if f436_local1 < 0.5 then
			f436_arg1._gamepadSelectionEnabled = false
			if not f436_arg4 then
				f436_local0.WheelSelectionEnabled:set(false)
			end
		end
	elseif f436_local1 > 0.9 then
		f436_arg1._gamepadSelectionEnabled = true
		f436_local0.WheelSelectionEnabled:set(true)
	end
	if f436_arg4 then
		f436_local0.WheelSelectionEnabled:set(true)
	end
	CoD.HUDUtility.UpdateStickSelectionModel(f436_arg1, f436_arg0, f436_arg2, f436_local0, f436_arg4)
end
CoD.HUDUtility.InitStickSelectionModel = function(f437_arg0, f437_arg1, f437_arg2, f437_arg3)
	local f437_local0 = f437_arg2:getStickModel(f437_arg1)
	f437_arg0._gamepadSelectionEnabled = false
	f437_local0.WheelSelectionEnabled:set(true)
	local f437_local1 = Engine[0x4DF5CFBC1771947](f437_arg1)
	f437_local1 = f437_local1:create("hudItems")
	f437_local1 = f437_local1:create("wheelPointerDegrees")
	f437_local1:set(f437_arg3)
	CoD.HUDUtility.UpdateStickSelectionModel(f437_arg0, f437_arg1, f437_arg2, f437_local0, true)
end
CoD.HUDUtility.ResetStickSelectionModel = function(f438_arg0, f438_arg1, f438_arg2, f438_arg3)
	local f438_local0 = f438_arg3:getTotalCount()
	if f438_local0 ~= nil and f438_local0 > 0 then
		local f438_local1 = 90
		if f438_arg0._lastSelectedWedge then
			f438_local1 = f438_arg0._lastSelectedWedge * 360 / f438_local0 - 270
		end
		CoD.HUDUtility.InitStickSelectionModel(f438_arg1, f438_arg2, f438_arg3, f438_local1)
	end
end
CoD.HUDUtility.EndStickSelectionModel = function(f439_arg0, f439_arg1)
	local f439_local0 = DataSources[f439_arg1].getModel(f439_arg0)
	f439_local0.SelectedWedge:set(-1)
end
CoD.HUDUtility.DisableWheelSelection = function(f440_arg0, f440_arg1, f440_arg2)
	local f440_local0 = f440_arg2:getStickModel(f440_arg0)
	f440_arg1._gamepadSelectionEnabled = false
	f440_local0.WheelSelectionEnabled:set(false)
	local f440_local1 = f440_local0.SelectedWedge:get()
	if f440_local1 < 0 and (f440_arg2._lastSelectedWedgeIndex or -1) >= 0 then
		local f440_local2 = f440_arg2:getElementAtZeroBasedIndex(f440_arg2._lastSelectedWedgeIndex)
		if f440_local2 and f440_local2.currentClipIsTransitionClip then
			f440_local1 = f440_arg2._lastSelectedWedgeIndex
			if f440_local0.SelectedWedge:set(f440_local1) then
				f440_arg2:playSound("wheel_changed")
			end
		end
	end
	if f440_local1 > -1 then
		local f440_local2 = f440_arg2:getModelForIndex(f440_local1 + 1)
		f440_local2.chosen:set(true)
		f440_local0.SelectedWedge:set(-1)
		f440_local2.chosen:set(false)
		f440_arg2._lastSelectedWedgeIndex = -1
		local f440_local3 = f440_arg2:getElementAtZeroBasedIndex(f440_local1)
		if f440_arg2._onChooseWedge then
			f440_arg2._onChooseWedge(f440_local1, f440_local3, f440_local2)
		end
	else
		f440_local0.SelectedWedge:set(-1)
	end
end
CoD.HUDUtility.IsCalloutsButtonPressed = function(f441_arg0)
	local f441_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f441_arg0, "ButtonBits.actionSlots.Flourish_Callouts", Enum[0xA3A4D6F29781E2C][0xDF43D93F8EF4FEA])
	if not f441_local0 then
		f441_local0 = CoD.ModelUtility.IsModelValueEqualTo(f441_arg0, "hudItems.PCWheels.calloutWheelKeyPressed", 1)
		if f441_local0 then
			f441_local0 = CoD.ModelUtility.IsModelValueEqualTo(f441_arg0, "hudItems.PCWheels.sprayGestureWheelKeyPressed", 0)
		end
	end
	return f441_local0
end
CoD.HUDUtility.IsWheelPointerVisible = function(f442_arg0)
	local f442_local0 = IsMouseOrKeyboard(f442_arg0)
	if not f442_local0 then
		f442_local0 = DataSources.RightStick.getModel(f442_arg0)
		if f442_local0.WheelSelectionEnabled:get() ~= true then
			f442_local0 = DataSources.LeftStick.getModel(f442_arg0)
			if f442_local0.WheelSelectionEnabled:get() ~= true then
				f442_local0 = false
			else
				f442_local0 = true
			end
		end
		f442_local0 = true
	end
	return f442_local0
end
CoD.HUDUtility.HideWheelInPrematch = function(f443_arg0)
	if IsWarzone() then
		return false
	else
		return IsInPrematchPeriod(f443_arg0)
	end
end
CoD.HUDUtility.EnableCalloutWheel = function()
	return true
end
CoD.HUDUtility.IsSpraysAndGesturesButtonHeld = function(f445_arg0)
	local f445_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f445_arg0, "ButtonBits.actionSlots.Sprays_Boasts", Enum[0xA3A4D6F29781E2C][0xDF43D93F8EF4FEA])
	if not f445_local0 then
		f445_local0 = CoD.ModelUtility.IsModelValueEqualTo(f445_arg0, "hudItems.PCWheels.sprayGestureWheelKeyPressed", 1)
		if f445_local0 then
			f445_local0 = CoD.ModelUtility.IsModelValueEqualTo(f445_arg0, "hudItems.PCWheels.calloutWheelKeyPressed", 0)
		end
	end
	return f445_local0
end
CoD.HUDUtility.IsSpraysAndGesturesButtonPressed = function(f446_arg0)
	local f446_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f446_arg0, "ButtonBits.actionSlots.Sprays_Boasts", Enum[0xA3A4D6F29781E2C][0x43535815622BB59])
	if not f446_local0 then
		f446_local0 = CoD.ModelUtility.IsModelValueEqualTo(f446_arg0, "hudItems.PCWheels.sprayGestureWheelKeyPressed", 1)
	end
	return f446_local0
end
CoD.HUDUtility.InitWheelPCForMouseDrag = function(f447_arg0, f447_arg1, f447_arg2, f447_arg3)
	if not CoD.isPC then
		return
	else
		local f447_local0 = f447_arg0
		local f447_local1 = f447_arg0.subscribeToModel
		local f447_local2 = DataSources.FreeCursor.getModel(f447_arg1)
		f447_local1(f447_local0, f447_local2.position, function(f448_arg0)
			if f447_arg0._mouseSelectionEnabled and not f447_arg0._gamepadSelectionEnabled then
				CoD.HUDUtility.UpdateCurrentStickSelectionModelOnPC(f447_arg0, f447_arg1, f447_arg3)
			end
		end, false)
		LUI.OverrideFunction_CallOriginalFirst(f447_arg0, "setState", function(element, controller, f449_arg2, f449_arg3, f449_arg4)
			if IsSelfInState(f447_arg0, "Visible") then
				if IsMouseOrKeyboard(controller) then
					CoD.HUDUtility.MenuDelayedSetRightStickLock(f447_arg2, controller, 0, true)
					Engine[0xD368E9CBCFAE9B0]()
					f447_arg0._mouseSelectionEnabled = true
					EnableMouseLockInputBinding(f447_arg2, controller, true, true)
				end
			else
				f447_arg0._mouseSelectionEnabled = false
				local f449_local0 = f447_arg3:getStickModel(controller)
				f449_local0.SelectedWedge:set(-1)
				EnableMouseLockInputBinding(f447_arg2, controller, false, true)
			end
		end)
	end
end
CoD.HUDUtility.InitWheelPCForMouseDragInFrontend = function(f450_arg0, f450_arg1, f450_arg2, f450_arg3)
	if not CoD.isPC then
		return
	else
		local f450_local0 = f450_arg0
		local f450_local1 = f450_arg0.subscribeToModel
		local f450_local2 = DataSources.FreeCursor.getModel(f450_arg1)
		f450_local1(f450_local0, f450_local2.position, function(f451_arg0)
			if f450_arg0._mouseSelectionEnabled and not f450_arg0._gamepadSelectionEnabled then
				CoD.HUDUtility.UpdateCurrentStickSelectionModelOnPC(f450_arg0, f450_arg1, f450_arg3)
			end
		end, false)
		f450_arg0._mouseSelectionEnabled = true
		f450_local1 = function(f452_arg0, f452_arg1, f452_arg2)
			local f452_local0 = f452_arg1:getTotalCount()
			if f452_local0 ~= nil and f452_local0 > 0 then
				local f452_local1 = f452_arg1:getStickModel(f452_arg0)
				local f452_local2 = f452_local1.SelectedWedge:get()
				if f452_local2 == -1 then
					local f452_local3 = 0
				end
				f452_local2 = f452_local3 or f452_local2 + f452_arg2
				local f452_local4 = false
				if f452_local0 <= f452_local2 then
					f452_local4 = f452_local1.SelectedWedge:set(0)
				elseif f452_local2 < 0 then
					f452_local4 = f452_local1.SelectedWedge:set(f452_local0)
				else
					f452_local4 = f452_local1.SelectedWedge:set(f452_local2)
				end
				if f452_local4 then
					f452_arg1:playSound("wheel_changed")
				end
				local f452_local5 = 360 / f452_local0
				local f452_local6 = (f452_local2 + 2) % f452_local0
				local f452_local7 = Engine[0x4DF5CFBC1771947](f452_arg0)
				f452_local7.hudItems.wheelPointerDegrees:set(f452_local6 * f452_local5)
				f452_arg1._lastSelectedWedgeIndex = f452_local2
			end
		end
		CoD.Menu.AddButtonCallbackFunction(f450_arg2, f450_arg0, f450_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_navleft", function(element, menu, controller, f453_arg3)
			f450_local1(controller, f450_arg3, 1)
			return true
		end)
		CoD.Menu.AddButtonCallbackFunction(f450_arg2, f450_arg0, f450_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_navright", function(element, menu, controller, f454_arg3)
			f450_local1(controller, f450_arg3, -1)
			return true
		end)
	end
end
CoD.HUDUtility.AddSprayGestureCallback = function(f455_arg0, f455_arg1)
	f455_arg1._onChooseWedge = function(f456_arg0, f456_arg1, f456_arg2)
		if f456_arg2.index:get() >= 0 then
			Engine[0x11C001DF63C3ABA](f455_arg0, f456_arg0 + 1, false)
			Engine[0xDE279ECDDDD966](f455_arg0, 0x8492A9F79B4D8E2, {
				[0xB53288C022B73A7] = f456_arg2.item_index:get() + 1,
				[0xE3755F8BEC75376] = Engine[0xB07E933C9E5CEB1](),
				[0x84CFBA3558B4604] = f456_arg2.assetName:get(),
			})
		end
	end
end
CoD.HUDUtility.AddQuickSprayCallback = function(f457_arg0)
	local f457_local0 = DataSources.QuickSpray.getModel(f457_arg0)
	if f457_local0.index:get() >= 0 then
		Engine[0x11C001DF63C3ABA](f457_arg0, 0, true)
	end
end
CoD.HUDUtility.GetCalloutWheel = function()
	if not CoD.HUDUtility.CachedCalloutWheel then
		CoD.HUDUtility.CachedCalloutWheel = Engine[0xA7E3CD65E63086F](0x499732DB058E6FB)
	end
	return CoD.HUDUtility.CachedCalloutWheel
end
DataSources.CalloutWheel = DataSourceHelpers.ListSetup("CalloutWheel", function(f459_arg0, f459_arg1)
	local f459_local0 = {}
	local f459_local1 = {
		[Enum[0x9EF92C53CE7E47E][0x8C3A83128A9E996]] = 0xA31296C0C1B6029,
		[Enum[0x9EF92C53CE7E47E][0x910C1D41C706A4B]] = 0x6190193FD8F6AFA,
		[Enum[0x9EF92C53CE7E47E][0xAEB3AFAF9D25FB8]] = 0x3100B5ED522BF50,
	}
	local f459_local2 = DataSources.PlayerAbilities.getModel(f459_arg0)
	local f459_local3 = {}
	local f459_local4 = Engine[0x4DF5CFBC1771947](f459_arg0)
	local f459_local5 = Engine[0xC53F8D38DF9042B](Engine[0x69811927938FCD7]())
	if CoD.HUDUtility.IsGameTypeEqualToString("dom") then
		f459_local4:create("CalloutWheel.dom_a.team")
		f459_local4:create("CalloutWheel.dom_b.team")
		f459_local4:create("CalloutWheel.dom_c.team")
	elseif CoD.HUDUtility.IsGameTypeEqualToString("control") then
		f459_local4:create("CalloutWheel.control_0.team")
		f459_local4:create("CalloutWheel.control_1.team")
	elseif CoD.HUDUtility.IsGameTypeEqualToString("sd") then
		f459_local4:create("CalloutWheel.sd_a.team")
		f459_local4:create("CalloutWheel.sd_b.team")
	elseif CoD.HUDUtility.IsGameTypeEqualToString("escort") then
		f459_local4:create("CalloutWheel.escort_robot.team")
	elseif CoD.HUDUtility.IsGameTypeEqualToString("koth") then
		f459_local4:create("CalloutWheel.koth_attacking.team")
		f459_local4:create("CalloutWheel.koth_defending.team")
		f459_local4:create("CalloutWheel.koth_moving.team")
	elseif CoD.HUDUtility.IsGameTypeEqualToString("warzone") then
		f459_local4:create("CalloutWheel.escort_robot.team")
	end
	local f459_local6 = function(f460_arg0)
		if f460_arg0 == nil or f460_arg0 == 0x0 then
			return true
		elseif f460_arg0 == 0x3F314215AE581AC then
			local f460_local0
			if not CoD.HUDUtility.IsGameTypeEqualToString("dm") then
				f460_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("gun")
			else
				f460_local0 = false
			end
			return f460_local0
		elseif f460_arg0 == 0x218F5B8A3D9D231 then
			local f460_local0 = CoD.HUDUtility.IsGameTypeEqualToString("dm")
			if not f460_local0 then
				f460_local0 = CoD.HUDUtility.IsGameTypeEqualToString("gun")
			end
			return f460_local0
		elseif f460_arg0 == 0x7106B9F4A1A8355 then
			local f460_local0 = CoD.HUDUtility.IsGameTypeEqualToString("tdm")
			if not f460_local0 then
				f460_local0 = CoD.HUDUtility.IsGameTypeEqualToString("conf")
				if not f460_local0 then
					f460_local0 = CoD.HUDUtility.IsGameTypeEqualToString("infect")
				end
			end
			return f460_local0
		elseif f460_arg0 == 0xA70255BA05F984C then
			local f460_local0 = CoD.HUDUtility.IsGameTypeEqualToString("control")
			if not f460_local0 then
				f460_local0 = CoD.HUDUtility.IsGameTypeEqualToString("sd")
			end
			return f460_local0
		elseif f460_arg0 == 0x57E90B1451515A7 then
			return CoD.isWarzone
		else
			local f460_local0
			if f459_local5 ~= f460_arg0 and f459_local5 ~= f460_arg0 .. "_cwl" and f459_local5 ~= f460_arg0 .. "_hc" then
				f460_local0 = false
			else
				f460_local0 = true
			end
		end
		return f460_local0
	end
	local f459_local7 = CoD.HUDUtility.GetCalloutWheel()
	local f459_local8 = Engine[0x3EAC408F958FF05]()
	local f459_local9 = Engine[0x4DF5CFBC1771947](f459_arg0)
	local f459_local10 = f459_local9.CalloutWheel
	for f459_local23, f459_local24 in ipairs(f459_local7) do
		local f459_local25 = #f459_local0 + 1
		if f459_local6(f459_local24[0x792C1F90C3A5C7F]) then
			local f459_local14 = f459_local24[0x4963972D2A614AA]
			if f459_local24[0x59DF2BAFFBFC38] then
				if f459_local10[f459_local24[0x59DF2BAFFBFC38]] then
					if not f459_arg1._hasGadgetSubscriptions then
						f459_local3[f459_local24[0x59DF2BAFFBFC38]] = f459_local10[f459_local24[0x59DF2BAFFBFC38]].team
					end
					local f459_local15 = 0
					local f459_local16 = Engine[0xF9F1239CFD921FE](f459_local24[0xA31296C0C1B6029])
					if f459_local10[f459_local24[0x59DF2BAFFBFC38]].team:get() == CoD.TeamUtility.GetTeamIDForController(f459_arg0) and f459_local24[0xCEF4564406075F8] ~= nil then
						f459_local15 = 100
						f459_local16 = Engine[0xF9F1239CFD921FE](f459_local24[0xCEF4564406075F8])
					end
					table.insert(f459_local0, {
						models = {
							image = f459_local24[0xBFF4CC56C2092F0],
							disabled = false,
							text = f459_local16,
							arrayIndex = f459_local23 - 1,
							index = f459_local25 - 1,
							chosen = false,
							addNumber = f459_local15,
							isSocialCallout = f459_local14,
						},
						properties = {},
					})
				end
			end
			local f459_local15 = nil
			local f459_local16 = 0
			local f459_local17 = false
			if f459_local24[0x4BCADBA8E631B86] == "sgc_warzone_item" then
				local f459_local18 = f459_local9.hudItems.showPickupHint
				local f459_local19 = f459_local9.hudItems.pickupHintText
				local f459_local20 = f459_local9.hudItems.pickupHintTextOverride
				local f459_local21 = f459_local20
				local f459_local22 = f459_local20:get()
				if f459_local22 then
					f459_local22 = f459_local21 and Engine[0x238317564B9D47B](f459_local20:get())
				end
				if f459_local22 then
					f459_local19 = f459_local20
				end
				if not f459_arg1._hasGadgetSubscriptions then
					f459_local3.showPickupHintModel = f459_local18
					f459_local3.pickupHintText = f459_local19
					f459_local3.pickupHintTextOverride = f459_local20
					f459_local3.pickupHintGold = f459_local9.hudItems.pickupHintGold
				end
				if f459_local19 and f459_local19:get() and (not (not f459_local18 or not f459_local18:get()) or f459_local22) then
					if f459_local9.hudItems.pickupHintGold:get() == 1 then
						f459_local15 = Engine[0xF9F1239CFD921FE](0x33C75DB9FD3177E, f459_local19:get())
					else
						f459_local15 = Engine[0xF9F1239CFD921FE](f459_local24[0xA31296C0C1B6029], f459_local19:get())
					end
				else
					f459_local15 = Engine[0xF9F1239CFD921FE](0xD39768E8FDB8F6A)
					f459_local17 = true
				end
			elseif f459_local24[0x6A3A04E156E3184] and f459_local24[0x6A3A04E156E3184] ~= 0 then
				if not f459_arg1._hasGadgetSubscriptions then
					f459_local3.inLastStand = f459_local9.hudItems.health.inLastStand
				end
				if f459_local9.hudItems.health.inLastStand:get() then
					f459_local15 = Engine[0xF9F1239CFD921FE](f459_local24[0xCEF4564406075F8])
					f459_local16 = 100
				else
					f459_local15 = Engine[0xF9F1239CFD921FE](f459_local24[0xA31296C0C1B6029])
				end
			else
				f459_local15 = Engine[0xF9F1239CFD921FE](f459_local24[0xA31296C0C1B6029])
			end
			table.insert(f459_local0, {
				models = {
					image = f459_local24[0xBFF4CC56C2092F0],
					disabled = f459_local17,
					text = f459_local15,
					arrayIndex = f459_local23 - 1,
					index = f459_local25 - 1,
					chosen = false,
					addNumber = f459_local16,
					isSocialCallout = f459_local14,
				},
				properties = {},
			})
		end
	end
	if not f459_arg1._hasGadgetSubscriptions then
		f459_arg1._hasGadgetSubscriptions = true
		for f459_local23, f459_local24 in pairs(f459_local3) do
			f459_arg1:subscribeToModel(f459_local24, function(model)
				f459_arg1:updateDataSource(true)
			end, false)
		end
	end
	return f459_local0
end, nil, nil, function(f462_arg0, f462_arg1, f462_arg2) end)
CoD.HUDUtility.AddCalloutWheelCallback = function(f463_arg0, f463_arg1)
	f463_arg1._onChooseWedge = function(f464_arg0, f464_arg1, f464_arg2)
		Engine[0x46C794158F47657](f463_arg0, 0x7177AF8D2789CE8, 0x3C44F5A1B0581D4, (f464_arg2.arrayIndex:get() or f464_arg0) + f464_arg2.addNumber:get())
	end
end
CoD.HUDUtility.ProcessPlayerCalloutInternal = function(f465_arg0, f465_arg1, f465_arg2, f465_arg3, f465_arg4, f465_arg5, f465_arg6, f465_arg7)
	if CoD.WZUtility.IsWarzoneUIHidden(f465_arg1, "wzHideConsoleUI", "warzoneHideConsole") then
		return
	end
	local f465_local0 = DataSources.HUDItems.getModel(f465_arg1)
	f465_local0 = f465_local0.console
	if f465_local0 and f465_arg3 and f465_arg4 then
		local f465_local1 = GetPlayerCalloutNameColor(f465_arg1, f465_arg4)
		local f465_local2 = GetClientNameAndClanTag(f465_arg1, f465_arg4)
		if f465_arg6 then
			f465_local2 = Engine[0xF9F1239CFD921FE](f465_arg6, f465_local2)
		end
		local f465_local3, f465_local4 = nil
		if f465_arg5 then
			f465_local3 = GetPlayerCalloutNameColor(f465_arg1, f465_arg5)
			f465_local4 = GetClientNameAndClanTag(f465_arg1, f465_arg5)
		end
		local f465_local5 = nil
		if f465_arg7 then
			f465_local5 = Engine[0xF9F1239CFD921FE](Engine[0xEFE2F6436680CF3](f465_arg3, "CS_LOCALIZED_STRINGS"), f465_arg7)
		else
			f465_local5 = Engine[0xF9F1239CFD921FE](Engine[0xEFE2F6436680CF3](f465_arg3, "CS_LOCALIZED_STRINGS"))
		end
		local f465_local6 = f465_local0["line" .. f465_local0.currentIndex:get()]
		if not CoD.isPC then
			if IsCurrentLanguageReversed() then
				if f465_arg5 then
					f465_local6.text2:set(f465_local4)
					f465_local6.text2color:set(f465_local3)
				end
				f465_local6.text1:set(f465_local2)
				f465_local6.text1color:set(f465_local1)
				f465_local6.text0:set(f465_local5)
				f465_local6.text0color:set(Enum[0x97A8DF5F2FA8BD5][0x4A8B270BE295E3E])
			else
				f465_local6.text0:set(f465_local2)
				f465_local6.text0color:set(f465_local1)
				f465_local6.text1:set(f465_local5)
				f465_local6.text1color:set(Enum[0x97A8DF5F2FA8BD5][0x4A8B270BE295E3E])
				if f465_arg5 then
					f465_local6.text2:set(f465_local4)
					f465_local6.text2color:set(f465_local3)
				else
					f465_local6.text2:set("")
				end
			end
			Engine[0x6A489878620F3BC](f465_local0)
		elseif f465_arg5 then
			CoD.PCUtility.ShowGameEvent("^" .. f465_local3 .. f465_local4 .. ": " .. f465_local5)
		else
			CoD.PCUtility.ShowGameEvent("^" .. f465_local1 .. f465_local2 .. ": " .. f465_local5)
		end
	end
end
CoD.HUDUtility.ProcessPlayerCalloutWithNumber = function(f466_arg0, f466_arg1, f466_arg2)
	local f466_local0 = CoD.GetScriptNotifyData(f466_arg2)
	CoD.HUDUtility.ProcessPlayerCalloutInternal(f466_arg0, f466_arg1, f466_arg2, f466_local0[1], f466_local0[2], nil, nil, f466_local0[3])
end
CoD.HUDUtility.ProcessPlayerCalloutWithColon = function(f467_arg0, f467_arg1, f467_arg2)
	local f467_local0 = CoD.GetScriptNotifyData(f467_arg2)
	local f467_local1 = f467_local0[1]
	local f467_local2 = f467_local0[2]
	local f467_local3 = f467_local0[3]
	local f467_local4
	if f467_local3 then
		f467_local4 = Engine[0xEFE2F6436680CF3](f467_local3, "CS_LOCALIZED_STRINGS")
		if not f467_local4 then
		else
			CoD.HUDUtility.ProcessPlayerCalloutInternal(f467_arg0, f467_arg1, f467_arg2, f467_local1, f467_local2, nil, 0xC2E0670713898AB, f467_local4)
		end
	end
	f467_local4 = 0x0
end
CoD.HUDUtility.ProcessPlayerCallout = function(f468_arg0, f468_arg1, f468_arg2)
	local f468_local0 = CoD.GetScriptNotifyData(f468_arg2)
	CoD.HUDUtility.ProcessPlayerCalloutInternal(f468_arg0, f468_arg1, f468_arg2, f468_local0[1], f468_local0[2], f468_local0[3])
end
CoD.HUDUtility.PositionDraftCharacterUnavailable = function(f469_arg0, f469_arg1)
	if f469_arg0:getModel() then
		local f469_local0 = f469_arg0:getModel()
		if f469_local0.unavailable then
			f469_local0 = f469_arg0:getModel()
			if f469_local0.unavailable:get() then
				return true
			end
		end
	end
	if CoD.HUDUtility.IsGameTypeEqualToString("bounty") or CoD.HUDUtility.IsGameTypeEqualToString("oic") or CoD.HUDUtility.IsGameTypeEqualToString("sd") or CoD.HUDUtility.IsGameTypeEqualToString("infect") or CoD.HUDUtility.IsGameTypeEqualToString("sas") or CoD.HUDUtility.IsGameTypeEqualToString("svz") then
		if Engine[0xDD333420C49E6D0](f469_arg1, Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]) or Engine[0xDD333420C49E6D0](f469_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) then
			return false
		end
		local f469_local0 = Engine[0x8DF2E5447F384B9]()
		return f469_local0.hudItems.specialistSwitchIsLethal:get() == 1
	end
	return false
end
CoD.HUDUtility.LoadingHeaderNotShown = function()
	local f470_local0 = LobbyData.GetCurrentMenuTarget()
	local f470_local1
	if f470_local0[0x8B72E07B55C3AC0] ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) then
		f470_local1 = IsSimulateCT()
	else
		f470_local1 = true
	end
	return f470_local1
end
CoD.HUDUtility.ShowRestartLevelPrompt = function()
	local f471_local0 = LobbyData.GetCurrentMenuTarget()
	if CoD.isZombie then
		if Engine[0x69811927938FCD7]() ~= "ztutorial" and ((Engine[0xC68FC14365BB66B](Enum[0x1DD23D27A61F09A][0x3E66A586897A605]) == true) or (Engine[0xC68FC14365BB66B](Enum[0x1DD23D27A61F09A][0xB674220A0C7377]) == true) or (f471_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE)) or f471_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM)) then
			return true
		end
	end
	return false
end
CoD.HUDUtility.HandleRestartPromptNotifies = function(f472_arg0, f472_arg1, f472_arg2, f472_arg3)
	local f472_local0 = LobbyData.GetCurrentMenuTarget()
	local f472_local1 = f472_local0[0xBF54BE1BB3D618B]
	if not Engine[0x573048F8D3B4E25]() then
		f472_local1 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2])
	end
	local f472_local2 = Engine[0xEA2BE00F49480D](f472_local1)
	if CoD.ModelUtility.IsParamModelEqualToHashString(f472_arg2, 0xAA743D9AD6C8E19) then
		SetState(f472_arg1, "DefaultState", f472_arg3)
	elseif CoD.ModelUtility.IsParamModelEqualToHashString(f472_arg2, 0xFC4832B89307895) then
		if CoD.HUDUtility.ShowRestartLevelPrompt() then
			if f472_local2 then
				SetState(f472_arg1, "Shown", f472_arg3)
			end
		else
			ResumeEndGame(f472_arg0, f472_arg3)
			SetState(f472_arg1, "DefaultState", f472_arg3)
		end
	end
end
CoD.HUDUtility.StartStreamHiding = function(f473_arg0, f473_arg1, f473_arg2, f473_arg3, f473_arg4, f473_arg5, f473_arg6)
	f473_arg0._streamReadyCount = 0
	f473_arg0._streamCheckTimeElapsed = 0
	if f473_arg3 > 0 and f473_arg4 > 0 and not f473_arg0.checkStreamerTimer then
		f473_arg0:setState(f473_arg1, "Obscuring")
		f473_arg0.checkStreamerTimer = LUI.UITimer.newElementTimer(f473_arg3, false, function(f474_arg0)
			f473_arg0._streamCheckTimeElapsed = f473_arg0._streamCheckTimeElapsed + (f474_arg0.timeElapsed or f473_arg3)
			if Engine[0x2FE089161DFD305](f473_arg5, f473_arg6) then
				f473_arg0._streamReadyCount = f473_arg0._streamReadyCount + 1
			else
				f473_arg0._streamReadyCount = 0
			end
			if f473_arg2 <= f473_arg0._streamReadyCount or f473_arg4 < f473_arg0._streamCheckTimeElapsed then
				f473_arg0:setState(f473_arg1, "DefaultState")
				f473_arg0.checkStreamerTimer:close()
				f473_arg0.checkStreamerTimer = nil
			end
		end)
		f473_arg0:addElement(f473_arg0.checkStreamerTimer)
	end
end
CoD.HUDUtility.IsMultiplayer = function()
	return CoD.isMultiplayer
end
CoD.HUDUtility.IsZombies = function()
	return CoD.isZombie
end
CoD.HUDUtility.IsWarzone = function()
	return CoD.isWarzone
end
CoD.HUDUtility.SetUseCylinderMapping = function(f478_arg0, f478_arg1)
	f478_arg0:setUseCylinderMapping(f478_arg1)
end
CoD.HUDUtility[0xDCC62D0D0DCD91E] = function(f479_arg0, f479_arg1, f479_arg2, f479_arg3)
	if f479_arg2 == 0x6A6D02304FE510 or f479_arg2 == 0xC27F02309A797C then
		if f479_arg1 and f479_arg1.newTabletIcePickGadget == nil then
			f479_arg1.newTabletIcePickGadget = CoD.TabletIcePickGadget.new(f479_arg1, f479_arg3, 0, 0, 0, CoD.TabletIcePickGadget.__defaultWidth, 0, 0, 0, CoD.TabletIcePickGadget.__defaultHeight)
			LUI.OverrideFunction_CallOriginalSecond(f479_arg1.newTabletIcePickGadget, "close", function()
				f479_arg1.newTabletIcePickGadget = nil
			end)
			f479_arg0:addForceClosedSafeAreaChild(f479_arg1.newTabletIcePickGadget, "newTabletIcePickGadget")
			f479_arg1.newTabletIcePickGadget.id = "newTabletIcePickGadget"
			f479_arg1:sendInitializationEvents(f479_arg0.controller, f479_arg1.newTabletIcePickGadget)
		end
	elseif f479_arg1 and f479_arg1.newTabletIcePickGadget then
		f479_arg1.newTabletIcePickGadget:close()
		f479_arg1.newTabletIcePickGadget = nil
	end
end
CoD.HUDUtility[0xE213B828E44EBE4] = function(f481_arg0, f481_arg1, f481_arg2)
	if f481_arg1._hasButtonBitSubscription then
		return
	end
	f481_arg1._hasButtonBitSubscription = true
	local f481_local0 = function(f482_arg0)
		local f482_local0 = f482_arg0:get() & Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464]
		if f482_local0 ~= f481_arg1._currentButtonPressedValue then
			CoD.BaseUtility.SendCustomMenuResponse(f481_arg2, "IcePick", "id", f482_local0)
			f481_arg1._currentButtonPressedValue = f482_local0
		end
		BlockGameFromKeyEvent(f481_arg2)
		return false
	end
	local f481_local1 = function(f483_arg0)
		local f483_local0 = f483_arg0:get() & Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464]
		if f483_local0 ~= f481_arg1._currentButtonPressedValue then
			CoD.BaseUtility.SendCustomMenuResponse(f481_arg2, "IcePick", "back", f483_local0)
			f481_arg1._currentButtonPressedValue = f483_local0
		end
		BlockGameFromKeyEvent(f481_arg2)
		return false
	end
	f481_arg1._currentButtonPressedValue = 0
	local f481_local2 = Engine[0x4DF5CFBC1771947](f481_arg2)
	local f481_local3 = f481_local2.ButtonBits[Enum[0x3DD78803F918E9D][0xC083113BC81F23F]]
	local f481_local4 = f481_local2.ButtonBits[Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A]]
	local f481_local5 = f481_local2:create("IcePickInfo.forceUse")
	f481_local5:set(0)
	f481_arg1:subscribeToModel(f481_local3, f481_local0, false)
	f481_arg1:subscribeToModel(f481_local4, f481_local1, false)
	f481_arg1:subscribeToModel(f481_local5, function(model)
		if model:get() == 1 then
			CoD.BaseUtility.SendCustomMenuResponse(f481_arg2, "IcePick", "id", 1)
			model:set(0)
		end
		return false
	end, false)
	if CoD.isPC then
		f481_arg1:subscribeToModel(Engine[0xA9FCAD7BE6FA349]("+activate", f481_arg2), f481_local0, false)
		f481_arg1:subscribeToModel(Engine[0xA9FCAD7BE6FA349]("+weapnext", f481_arg2), f481_local1, false)
	end
end
CoD.HUDUtility.SetIcePickCurrentHackingFlavorText = function(f485_arg0, f485_arg1)
	local f485_local0 = f485_arg0:getModel()
	local f485_local1 = f485_local0.hackableFlavorText:get()
	local f485_local2 = nil
	if f485_local0.hackableCategory:get() == CoD.HUDUtility.IcePickCategories.PLAYER then
		f485_local2 = Engine[0xF9F1239CFD921FE](0xB9E61460B564573, GetCharacterDisplayNameByIndex(CoD.PlayerRoleUtility.GetCharacterIndexForClientNum(f485_arg1, f485_local0.hackableID:get())))
	else
		f485_local2 = Engine[0xF9F1239CFD921FE](f485_local1)
	end
	local f485_local3 = Engine[0x4DF5CFBC1771947](f485_arg1)
	f485_local3 = f485_local3.IcePickInfo.currentHackFlavorText
	if not f485_local3:set(f485_local2) then
		Engine[0x6A489878620F3BC](f485_local3)
	end
end
CoD.HUDUtility.IcePickCategories = LuaEnum.createEnum("PLAYER", "EQUIPMENT", "VEHICLE")
CoD.HUDUtility.IcePickHackableStatuses = LuaEnum.createEnum("UNHACKED", "HACKING", "HACKED", "DESTROYED")
DataSourceHelpers.PerControllerDataSourceSetup(
	"IcePickHackables",
	"IcePickHackables",
	function(f486_arg0, f486_arg1)
		if not f486_arg0.hackablesCount then
			local f486_local0 = f486_arg0:create("hackablesCount")
			f486_local0:set(0)
			f486_local0 = f486_arg0:create("hackablesCategoryCounts")
			for f486_local1 = 0, #CoD.HUDUtility.IcePickCategories - 1, 1 do
				f486_local0:create(f486_local1)
			end
		end
	end,
	false,
	{
		prepare = function(f487_arg0, f487_arg1, f487_arg2)
			if not f487_arg1._rootModel then
				f487_arg1._rootModel = DataSources.IcePickHackables.getModel(f487_arg0)
				f487_arg1:subscribeToModel(f487_arg1._rootModel.hackablesCount, function()
					f487_arg1:updateDataSource(false, true)
				end, false)
				local f487_local0 = f487_arg1._rootModel.hackablesCategoryCounts
				for f487_local1 = 0, #CoD.HUDUtility.IcePickCategories - 1, 1 do
					f487_arg1:subscribeToModel(f487_local0["" .. f487_local1], function()
						f487_arg1:updateDataSource(false, true)
					end, false)
				end
			end
			f487_arg1._filteredItems = {}
			local f487_local0 = CoD.TeamUtility.GetPredictedTeamID(f487_arg0)
			local f487_local1 = f487_arg1._rootModel.hackablesCount:get()
			for f487_local2 = 0, f487_local1 - 1, 1 do
				local f487_local5 = f487_arg1._rootModel["item" .. f487_local2]
				if not f487_arg2 or f487_arg2(f487_local5) then
					if f487_local5.hackableCategory:get() == CoD.HUDUtility.IcePickCategories.PLAYER then
						local f487_local6 = Engine[0x2C6B07FD023877B](f487_arg0, f487_local2)
						if f487_local6 ~= f487_local0 and f487_local6 > 0 then
							table.insert(f487_arg1._filteredItems, f487_local5)
						end
					end
					table.insert(f487_arg1._filteredItems, f487_local5)
				end
			end
		end,
		getCount = function(f490_arg0)
			return #f490_arg0._filteredItems
		end,
		getItem = function(f491_arg0, f491_arg1, f491_arg2)
			return f491_arg1._filteredItems[f491_arg2]
		end,
	}
)
DataSources.IcePickInfo = {
	getModel = function(f492_arg0)
		local f492_local0 = Engine[0x4DF5CFBC1771947](f492_arg0)
		f492_local0 = f492_local0:create("IcePickInfo")
		local f492_local1 = function(f493_arg0, f493_arg1)
			if not f492_local0[f493_arg0] then
				local f493_local0 = f492_local0:create(f493_arg0)
				f493_local0:set(f493_arg1)
			end
		end
		f492_local1("currentHackProgress", 0)
		f492_local1("detectionProgress", 0)
		f492_local1("currentHackFlavorText", "")
		return f492_local0
	end,
}
CoD.HUDUtility.IcePickFeedType = "IcePickFeed"
CoD.HUDUtility.IcePickFeedInstanceType = CoD.HUDUtility.IcePickFeedType
CoD.HUDUtility.SetupIcePickHackFeed = function(f494_arg0, f494_arg1, f494_arg2, f494_arg3)
	CoD.FeedUtility.FeedTypes[CoD.HUDUtility.IcePickFeedType] = CoD.HUDUtility.IcePickFeedTable
	CoD.FeedUtility.SetupFeed(f494_arg0, f494_arg1, CoD.HUDUtility.IcePickFeedType, CoD.HUDUtility.IcePickFeedInstanceType, CoD.FeedUtility.FeedAxis.VERTICAL, CoD.FeedUtility.FeedDirections.NEGATIVE, CoD.FeedUtility.FeedInsertionSide.BEGINNING, f494_arg2, f494_arg3)
end
CoD.HUDUtility.IcePickAddItemToFeed = function(f495_arg0, f495_arg1, f495_arg2)
	local f495_local0 = f495_arg0
	if f495_local0 then
		if not f495_local0.addFeedItem or not f495_local0.feedSize or f495_arg1:get() == "" then
			return
		end
		f495_local0:addFeedItem({
			hackingText = f495_arg1:get(),
			[1] = f495_arg2,
		}, 0)
	end
end
CoD.HUDUtility.InitIcePickFeedItem = function(f496_arg0, f496_arg1, f496_arg2, f496_arg3)
	local f496_local0 = f496_arg0:create("item" .. f496_arg3)
	f496_local0:create("hackingText")
	local f496_local1 = CoD.IcePickHackFlavorTextItem.new(f496_arg1, f496_arg2, 0, 0, 0, CoD.IcePickHackFlavorTextItem.__defaultWidth, 0, 0, 0, CoD.IcePickHackFlavorTextItem.__defaultHeight)
	f496_local1:setModel(f496_local0, f496_arg2)
	return f496_local1
end
CoD.HUDUtility.PopulateIcePickFeedItem = function(f497_arg0, f497_arg1)
	local f497_local0 = f497_arg0:getModel()
	f497_local0.hackingText:set(f497_arg1.hackingText)
end
CoD.HUDUtility.IcePickFeedSize = {
	[CoD.HUDUtility.IcePickFeedInstanceType] = 15,
}
CoD.HUDUtility.IcePickFeedTable = {
	sizes = CoD.HUDUtility.IcePickFeedSize,
	createFeedItem = CoD.HUDUtility.InitIcePickFeedItem,
	onFeedItemInserted = CoD.HUDUtility.PopulateIcePickFeedItem,
}
DataSources.Escort = {
	getModel = function(f498_arg0)
		local f498_local0 = Engine[0x8DF2E5447F384B9]()
		f498_local0 = f498_local0:create("Escort")
		local f498_local1 = function(f499_arg0, f499_arg1)
			if not f498_local0[f499_arg0] then
				local f499_local0 = f498_local0:create(f499_arg0)
				f499_local0:set(f499_arg1)
			end
		end
		f498_local1("robotProgress", 0)
		f498_local1("robotProgressToBeat", 0)
		f498_local1("robotMoving", 0)
		f498_local1("robotObjective", nil)
		return f498_local0
	end,
}
CoD.HUDUtility.SetEscortRobotObjective = function(f500_arg0)
	local f500_local0 = f500_arg0
	local f500_local1 = f500_arg0.setModel
	local f500_local2 = Engine[0x8DF2E5447F384B9]()
	f500_local1(f500_local0, f500_local2.Escort.robotObjective:get())
end
CoD.HUDUtility.IsGameTypeEqualToString = function(f501_arg0)
	local f501_local0 = Dvar[0xFF54369D6573B91]:get()
	local f501_local1
	if f501_local0 == nil or f501_local0 ~= f501_arg0 and f501_local0 ~= f501_arg0 .. "_hc" and f501_local0 ~= f501_arg0 .. "_cwl" and f501_local0 ~= f501_arg0 .. "_bb" then
		f501_local1 = false
	else
		f501_local1 = true
	end
	return f501_local1
end
CoD.HUDUtility.IsDidYouKnowAssetValid = function(f502_arg0, f502_arg1)
	local f502_local0 = f502_arg1[f502_arg0 .. "_gtsName"]
	local f502_local1 = f502_arg1[f502_arg0 .. "_gtsOperator"]
	if f502_local0 == nil or f502_local0 == 0xC0D17BAD169557B then
		return true
	elseif f502_local1 == 0x8068707B4C6334F then
		return IsGametypeSettingsValue(f502_local0, f502_arg1[f502_arg0 .. "_gtsValue"])
	elseif f502_local1 == 0x7C28707B48C6683 then
		return not IsGametypeSettingsValue(f502_local0, f502_arg1[f502_arg0 .. "_gtsValue"])
	elseif f502_local1 == 0xF63B14C8601A37B then
		return Engine[0xDBC2AD5002B261B](f502_local0) < f502_arg1[f502_arg0 .. "_gtsValue"]
	elseif f502_local1 == 0xF63B34C8601A6E1 then
		return f502_arg1[f502_arg0 .. "_gtsValue"] < Engine[0xDBC2AD5002B261B](f502_local0)
	else
		return false
	end
end
CoD.HUDUtility.IsGameTypeWzAmbush = function()
	return string.find(Dvar[0xFF54369D6573B91]:get(), "warzone_ambush") ~= nil
end
CoD.HUDUtility.IsGameTypeWzRedeploy = function()
	return IsGametypeSettingsValue("deathCircleRespawn", 1)
end
CoD.HUDUtility.IsGameTypeWzSpectre = function()
	return IsGametypeSettingsValue("wzSpectreRising", 1)
end
CoD.HUDUtility.IsGameTypeWzGroundWar = function()
	return IsGametypeSettingsValue("wzBigTeamBattle", 1)
end
CoD.HUDUtility.IsGameTypeCWL = function()
	return string.find(Dvar[0xFF54369D6573B91]:get(), "_cwl") ~= nil
end
CoD.HUDUtility.IsGameTypeBareBones = function()
	return string.find(Dvar[0xFF54369D6573B91]:get(), "_bb") ~= nil
end
CoD.HUDUtility.SetHardpointObjective = function(f509_arg0)
	local f509_local0 = f509_arg0:getModel()
	local f509_local1 = Engine[0x8DF2E5447F384B9]()
	f509_local1 = f509_local1.hudItems:create("hardpointObj")
	f509_local1:set(f509_local0)
end
CoD.HUDUtility.SetScoreInfoHardpointObjective = function(f510_arg0, f510_arg1)
	local f510_local0 = Engine[0x8DF2E5447F384B9]()
	f510_local0 = f510_local0.hudItems.hardpointObj:get()
	if f510_local0 then
		f510_arg0:setModel(f510_local0)
	end
end
CoD.HUDUtility.IsScoreInfoObjectiveContested = function(f511_arg0, f511_arg1)
	local f511_local0 = f511_arg0:getModel()
	if f511_local0 then
		return CoD.WaypointUtility.ShouldShowWaypointAsContestedHelper(f511_arg1, Engine[0xBE25B67EDE3D9F9](f511_arg1, f511_local0.objId:get()), f511_local0.objId:get(), nil)
	else
	end
end
CoD.HUDUtility.StuckImages = {
	NONE = 0,
	SEMTEX = 1,
	SPARROW = 2,
}
CoD.HUDUtility.SetRemoteMissileLockonScale = function(f512_arg0, f512_arg1)
	local f512_local0 = f512_arg1:get()
	f512_arg0:setScale(f512_local0, f512_local0)
end
CoD.HUDUtility.ForceCloseOnClose = function(f513_arg0) end
CoD.HUDUtility.UpdateZMTowersCrowdMeterState = function(f514_arg0, f514_arg1, f514_arg2)
	if f514_arg1:get() then
		f514_arg0:setState(f514_arg2, "crowd_server_paused")
	elseif f514_arg0._restoreState then
		f514_arg0:setState(f514_arg2, f514_arg0._restoreState)
	end
end
CoD.HUDUtility.BlackhatStatus = {
	Scanning = 0,
	Breaching = 1,
	Hacking = 2,
}
CoD.HUDUtility.BlackHatPreLoad = function(f515_arg0, f515_arg1)
	local f515_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f515_arg1), "hudItems.blackhat")
	local f515_local1 = Engine[0xA798E4552F5E872](f515_local0, "perc")
	local f515_local2 = Engine[0xA798E4552F5E872](f515_local0, "offsetShaderValue")
	local f515_local3 = Engine[0xA798E4552F5E872](f515_local0, "status")
	Engine[0x83C9B5DE1D9371](f515_local1, 0)
	Engine[0x83C9B5DE1D9371](f515_local2, "0 0 0 0")
	Engine[0x83C9B5DE1D9371](f515_local3, 0)
end
CoD.HUDUtility.SetUpReticle = function(f516_arg0, f516_arg1)
	f516_arg0:setupReticle(f516_arg1)
end
CoD.HUDUtility.TempestPostLoad = function(f517_arg0, f517_arg1, f517_arg2)
	local f517_local0 = f517_arg0
	local f517_local1 = f517_arg0.subscribeToModel
	local f517_local2 = DataSources.CurrentWeapon.getModel(f517_arg1)
	f517_local1(f517_local0, f517_local2:create("lookingDownSights"), function(f518_arg0)
		if Engine[0x614D394F6F9A18D](f518_arg0) == true then
			if not f517_arg0.ui3d then
				f517_arg0.ui3d = CoD.TempestReticle_UI3D.new(f517_arg2, f517_arg1, 0, 0, 0, CoD.TempestReticle_UI3D.__defaultWidth, 0, 0, 0, CoD.TempestReticle_UI3D.__defaultHeight)
				f517_arg0:addElement(f517_arg0.ui3d)
				f517_arg2:sendInitializationEvents(f517_arg1, f517_arg0.ui3d)
			end
		elseif f517_arg0.ui3d then
			f517_arg0.ui3d:close()
			f517_arg0.ui3d = nil
		end
	end)
end
CoD.HUDUtility.UplinkBallReticlePreLoad = function(f519_arg0)
	DataSources.ReticleBindings.createModelsForActions(f519_arg0, {
		"speed_throw",
		"attack",
	})
end
DataSources.ZMPlayerList = {
	getModel = function(f520_arg0)
		return Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f520_arg0), "PlayerList")
	end,
}
CoD.HUDUtility.ZMScrPreLoad = function(f521_arg0, f521_arg1)
	local f521_local0 = DataSources.ZMPlayerList.getModel(f521_arg1)
	for f521_local1 = 0, 3, 1 do
		local f521_local4 = Engine[0xA798E4552F5E872](f521_local0, f521_local1)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f521_local4, "zombieInventoryIcon"), "blacktransparent")
		f521_local4:create("playerScore")
		f521_local4:create("playerIsDowned")
		f521_local4:create("zombiePlayerIcon")
	end
end
CoD.HUDUtility.ZMScrHideScoreEvent = function(f522_arg0)
	local f522_local0
	if Engine[0xDD333420C49E6D0](f522_arg0, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
		f522_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
	else
		f522_local0 = true
	end
	return f522_local0
end
CoD.HUDUtility.ZMScrEmitPoints = function(f523_arg0, f523_arg1, f523_arg2, f523_arg3, f523_arg4, f523_arg5)
	if f523_arg0.activeScoreElements > 10 then
		return
	elseif f523_arg1 == 0 or f523_arg1 < -10000 or f523_arg1 > 10000 then
		return
	elseif CoD.HUDUtility.ZMScrHideScoreEvent(f523_arg2) then
		return
	end
	local f523_local0 = CoD.ZMScr_PlusPointsContainer.new(f523_arg3, f523_arg2, 0, 0, 0, CoD.ZMScr_PlusPointsContainer.__defaultWidth, 0, 0, 0, CoD.ZMScr_PlusPointsContainer.__defaultHeight)
	if f523_arg1 > 0 then
		f523_local0.ZMScrPlusPoints.Label1:setText("+" .. f523_arg1)
		f523_local0.ZMScrPlusPoints.Label2:setText("+" .. f523_arg1)
		if f523_arg5 then
			f523_local0.ZMScrPlusPoints:playClip("BonusScore")
		else
			f523_local0.ZMScrPlusPoints:playClip("DefaultClip")
		end
	else
		f523_local0.ZMScrPlusPoints.Label1:setText(f523_arg1)
		f523_local0.ZMScrPlusPoints.Label2:setText(f523_arg1)
		f523_local0.ZMScrPlusPoints:playClip("NegativeScore")
	end
	if f523_arg4 then
		f523_local0:setScale(0.75)
	end
	f523_arg0.lastAnim = f523_arg0.lastAnim + 1
	f523_local0:setState(f523_arg2, "DefaultState")
	if not f523_local0:hasClip("Anim" .. f523_arg0.lastAnim) then
		f523_arg0.lastAnim = 1
	end
	f523_local0:registerEventHandler("clip_over", function(element, event)
		element:close()
		f523_arg0.activeScoreElements = f523_arg0.activeScoreElements - 1
	end)
	f523_arg0:addElement(f523_local0)
	f523_arg3:sendInitializationEvents(f523_arg2, f523_local0)
	f523_local0:playClip("Anim" .. f523_arg0.lastAnim)
	f523_arg0.activeScoreElements = f523_arg0.activeScoreElements + 1
end
CoD.HUDUtility.ZMScrSetupTrialsElementsForClient = function(f525_arg0, f525_arg1, f525_arg2)
	local f525_local0 = 0
	local f525_local1 = 1
	local f525_local2 = 2
	local f525_local3 = 3
	local f525_local4 = Engine[0xA798E4552F5E872](f525_arg2, "trialsCheckState")
	local f525_local5 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "ZMHudGlobal.trials.infoHidden")
	local f525_local6 = function()
		local f526_local0 = f525_local5:get()
		if f526_local0 ~= nil then
			if f526_local0 == true then
				f525_arg0:setState(f525_arg1, "HideForRoundSplash")
			else
				local f526_local1 = f525_local4:get()
				if f526_local1 ~= nil then
					if f526_local1 == f525_local0 then
						f525_arg0:setState(f525_arg1, "DefaultState")
					elseif f526_local1 == f525_local1 then
						f525_arg0:setState(f525_arg1, "Counter")
					elseif f526_local1 == f525_local2 then
						f525_arg0:setState(f525_arg1, "Unchecked")
					else
						f525_arg0:setState(f525_arg1, "Checked")
					end
				end
			end
		end
	end
	f525_arg0:subscribeToModel(f525_local4, function(model)
		f525_local6()
	end)
	f525_arg0:subscribeToModel(f525_local5, function(model)
		f525_local6()
	end)
	local f525_local7 = Engine[0x8DF2E5447F384B9]()
	local f525_local8 = Engine[0xA798E4552F5E872](f525_arg2, "trialsCounterValue")
	local f525_local9 = f525_local7:create("ZMHudGlobal.trials.playerCounterMax")
	local f525_local10 = function(f529_arg0)
		local f529_local0 = f525_local8:get()
		local f529_local1 = f525_local9:get()
		if f529_local0 ~= nil and f529_local1 ~= nil then
			f525_arg0.Counter:setText(Engine[0xF9F1239CFD921FE](0xB7D5EBBEC599C9A, f529_local0, f529_local1))
		end
	end
	f525_arg0:subscribeToModel(f525_local8, f525_local10)
	f525_arg0:subscribeToModel(f525_local9, f525_local10)
end
CoD.HUDUtility.ZMScrPostLoad = function(f530_arg0, f530_arg1, f530_arg2)
	local f530_local0 = 4
	if CoD.HUDUtility.IsAnyGameType(f530_arg1, "zstandard") then
		return
	end
	local f530_local1 = {
		damage10 = {
			score = 10,
			bonusPoints = false,
		},
		damage20 = {
			score = 20,
			bonusPoints = false,
		},
		damage30 = {
			score = 30,
			bonusPoints = false,
		},
		damage40 = {
			score = 40,
			bonusPoints = false,
		},
		damage50 = {
			score = 50,
			bonusPoints = false,
		},
		damage60 = {
			score = 60,
			bonusPoints = false,
		},
		damage70 = {
			score = 70,
			bonusPoints = false,
		},
		damage80 = {
			score = 80,
			bonusPoints = false,
		},
		damage90 = {
			score = 90,
			bonusPoints = false,
		},
		death_head = {
			score = 30,
			bonusPoints = true,
		},
		death_melee = {
			score = 60,
			bonusPoints = true,
		},
		transform_kill = {
			score = 50,
			bonusPoints = true,
		},
	}
	local f530_local2 = Engine[0x8DF2E5447F384B9]()
	local f530_local3 = Engine[0x4DF5CFBC1771947](f530_arg1)
	f530_arg0.pendingDelayedScores = 0
	local f530_local4 = Engine[0x761955642304848](f530_arg1)
	for f530_local5 = 0, f530_local0 - 1, 1 do
		local f530_local8 = f530_local5
		local f530_local9 = DataSources.PlayerListZM.clientNumToArrayIndex(f530_local8, f530_local4)
		local f530_local10 = f530_arg0["ZMScrPlusPoints" .. f530_local9]
		f530_local10.lastAnim = 0
		f530_local10.activeScoreElements = 0
		local f530_local11 = Engine[0xE4D2F32833CFA6C](f530_local8)
		local f530_local12 = f530_local11.clientNum:get()
		if f530_local12 ~= nil then
			local f530_local13 = f530_local2:create("PlayerList.client" .. f530_local12)
			if f530_local13 ~= nil then
				for f530_local17, f530_local18 in pairs(f530_local1) do
					f530_local10:registerEventHandler("delayed_score", function(element, event)
						CoD.HUDUtility.ZMScrEmitPoints(element, event.score, f530_arg1, f530_arg2, f530_local8 > 0, event.bonusPoints)
						f530_arg0.pendingDelayedScores = f530_arg0.pendingDelayedScores - 1
					end)
					f530_local10:subscribeToModel(Engine[0xA798E4552F5E872](f530_local13, "score_cf_" .. f530_local17), function(model)
						if Engine[0x614D394F6F9A18D](model) ~= nil and not CoD.HUDUtility.ZMScrHideScoreEvent(f530_arg1) then
							local f532_local0 = f530_local18.score
							local f532_local1 = Engine[0x40E824FE270E174](f530_local3, "hudItems.doublePointsActive")
							if f532_local1 ~= nil and Engine[0x614D394F6F9A18D](f532_local1) == 1 then
								f532_local0 = f530_local18.score * 2
							end
							if f530_local10.accountedForScore ~= nil then
								f530_local10.accountedForScore = f530_local10.accountedForScore + f532_local0
							end
							if f530_arg0.pendingDelayedScores < 500 then
								f530_arg0:addElement(LUI.UITimer.new(16 * Engine[0x614D394F6F9A18D](model) % 3, {
									name = "delayed_score",
									score = f532_local0,
									bonusPoints = f530_local18.bonusPoints,
								}, true, f530_local10))
								f530_arg0.pendingDelayedScores = f530_arg0.pendingDelayedScores + 1
							end
						end
					end)
				end
				if f530_local9 ~= 0 then
					f530_local14 = f530_arg0["Listing" .. f530_local9 + 1]
					if f530_local14 ~= nil then
						CoD.HUDUtility.ZMScrSetupTrialsElementsForClient(f530_local14.TrialsInfo, f530_arg1, f530_local13)
					end
				end
			end
		end
		local f530_local13 = f530_local11.scoreboard.score
		f530_local10.accountedForScore = Engine[0x614D394F6F9A18D](f530_local13)
		f530_local10:subscribeToModel(f530_local13, function(model)
			local f533_local0 = Engine[0x614D394F6F9A18D](model)
			if f530_local10.accountedForScore == nil then
				f530_local10.accountedForScore = f533_local0
			end
			if f533_local0 ~= f530_local10.accountedForScore then
				CoD.HUDUtility.ZMScrEmitPoints(f530_local10, f533_local0 - f530_local10.accountedForScore, f530_arg1, f530_arg2, f530_local8 > 0, false)
				f530_local10.accountedForScore = f533_local0
			end
		end)
	end
	Engine[0xA798E4552F5E872](f530_local3, "hudItems.doublePointsActive")
end
