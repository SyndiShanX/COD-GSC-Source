CoD.LocationSelectorUtility = {}
CoD.LocationSelectorUtility.MenuResponseName = "LocationSelector"
CoD.LocationSelectorUtility.PlayerFakeObjId = 999
CoD.LocationSelectorUtility.ControlFakeObjId = 998
CoD.LocationSelectorUtility.PositionObjectiveMarker = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0, f1_local1, f1_local2 = Engine[@"getobjectiveentityposition"](f1_arg1, f1_arg3)
	if f1_local0 and f1_local1 and f1_local2 then
		CoD.SpawnSelectionUtility.PositionMarker(f1_arg0, f1_arg1, f1_arg2, {
			x = f1_local0,
			y = f1_local1,
			z = f1_local2,
		})
	end
end
CoD.LocationSelectorUtility.AddDatapadLocation = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	if not f2_arg0.markers[f2_arg3] then
		local f2_local0 = CoD.TabletLocationSelector_PointMarker.new(f2_arg2, f2_arg1, 0, 0, 0, CoD.TabletLocationSelector_PointMarker.__defaultWidth, 0, 0, 0, CoD.TabletLocationSelector_PointMarker.__defaultHeight)
		f2_local0.objId = f2_arg3
		f2_arg0.markers[f2_arg3] = f2_local0
		f2_arg0:addElement(f2_local0)
		f2_arg2:sendInitializationEvents(f2_arg1, f2_local0)
	end
	CoD.SpawnSelectionUtility.PositionObjectiveMarker(f2_arg0, f2_arg1, f2_arg0.markers[f2_arg3], f2_arg3)
end
CoD.LocationSelectorUtility.AddDatapadPatrolLocation = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	if not f3_arg0.markers[f3_arg3] then
		local f3_local0 = CoD.TabletLocationSelector_PatrolMarker.new(f3_arg2, f3_arg1, 0, 0, 0, CoD.TabletLocationSelector_PatrolMarker.__defaultWidth, 0, 0, 0, CoD.TabletLocationSelector_PatrolMarker.__defaultHeight)
		f3_local0.objId = f3_arg3
		f3_arg0.markers[f3_arg3] = f3_local0
		f3_arg0:addElement(f3_local0)
		f3_arg2:sendInitializationEvents(f3_arg1, f3_local0)
	end
	CoD.SpawnSelectionUtility.PositionObjectiveMarker(f3_arg0, f3_arg1, f3_arg0.markers[f3_arg3], f3_arg3)
end
CoD.LocationSelectorUtility.AddDatapadPlayerLocation = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.LocationSelectorUtility.PlayerFakeObjId
	local f4_local1 = f4_arg0.markers[f4_local0]
	if not f4_local1 then
		f4_local1 = CoD.TabletLocationSelector_PlayerMarker.new(f4_arg2, f4_arg1, 0, 0, 0, CoD.TabletLocationSelector_PlayerMarker.__defaultWidth, 0, 0, 0, CoD.TabletLocationSelector_PlayerMarker.__defaultHeight)
		f4_local1.objId = f4_local0
		f4_arg0.markers[f4_local0] = f4_local1
		f4_arg0:addElement(f4_local1)
		f4_arg2:sendInitializationEvents(f4_arg1, f4_local1)
	end
	CoD.SpawnSelectionUtility.PositionMarker(f4_arg0, f4_arg1, f4_local1, Engine[@"hash_4E1D6BCF7D3131C5"](f4_arg1))
end
CoD.LocationSelectorUtility.AddDatapadObjectiveLocation = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	if not f5_arg0.markers[f5_arg3] then
		local f5_local0 = CoD.TabletLocationSelector_PlayerMarker.new(f5_arg2, f5_arg1, 0, 0, 0, CoD.TabletLocationSelector_PlayerMarker.__defaultWidth, 0, 0, 0, CoD.TabletLocationSelector_PlayerMarker.__defaultHeight)
		f5_local0.objId = f5_arg3
		f5_arg0.markers[f5_arg3] = f5_local0
		f5_arg0:addElement(f5_local0)
		f5_arg2:sendInitializationEvents(f5_arg1, f5_local0)
	end
	CoD.LocationSelectorUtility.PositionObjectiveMarker(f5_arg0, f5_arg1, f5_arg0.markers[f5_arg3], f5_arg3)
end
CoD.LocationSelectorUtility.UpdateLeftStickVector = function(f6_arg0, f6_arg1)
	local f6_local0 = CoD.BaseUtility.GetLeftStickVector(f6_arg1)
	f6_local0.y = -f6_local0.y
	f6_arg0.leftStickVector = f6_local0
end
CoD.LocationSelectorUtility.FindTargetedMarker = function(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.selectedMarker
	if not f7_local0 then
		DebugPrint("^1LUI - SpawnSelect: ^2invalid selectedRegion in FindTargetSpawnRegion")
		return
	end
	local f7_local1, f7_local2, f7_local3, f7_local4 = f7_local0:getLocalRect()
	local f7_local5 = CoD.BaseUtility.GetElementCenterVec(f7_local0)
	local f7_local6 = f7_arg0.leftStickVector
	local f7_local7 = {}
	for f7_local11, f7_local12 in pairs(f7_arg0.markers) do
		local f7_local13 = CoD.BaseUtility.Vec2Sub(CoD.BaseUtility.GetElementCenterVec(f7_local12), f7_local5)
		if CoD.BaseUtility.Vec2Dot(f7_local6, f7_local13) > 0 then
			table.insert(f7_local7, {
				marker = f7_local12,
				hitDist = CoD.BaseUtility.Vec2LenSq(CoD.BaseUtility.Vec2Reject(f7_local13, f7_local6)),
			})
		end
	end
	if #f7_local7 > 0 then
		table.sort(f7_local7, function(f8_arg0, f8_arg1)
			return f8_arg0.hitDist < f8_arg1.hitDist
		end)
		return f7_local7[1].marker
	end
	return nil
end
CoD.LocationSelectorUtility.SelectMarker = function(f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = f9_arg0.MarkerCursor
	if f9_local0 then
		local f9_local1, f9_local2 = f9_local0:getLocalSize()
		local f9_local3 = f9_local1 / 2
		local f9_local4 = f9_local2 / 2
		local f9_local5 = CoD.BaseUtility.GetElementCenterVec(f9_arg1)
		local f9_local6 = f9_local5.x - f9_local3
		local f9_local7 = f9_local5.x + f9_local3
		local f9_local8 = f9_local5.y - f9_local4
		local f9_local9 = f9_local5.y + f9_local4
		f9_local0:setState(f9_arg2, "DefaultState")
		local f9_local10 = function(f10_arg0, f10_arg1)
			f9_local0:playClip("Acquire")
			local f10_local0 = f9_arg1:processEvent({
				name = "gain_focus",
				controller = f9_arg2,
			})
			f9_arg0.selectedMarker = f9_arg1
		end
		f9_local0:playClip("Release")
		f9_local0:beginAnimation("move", CoD.isPC and 0 or 100, true, true)
		f9_local0:setLeftRight(0, 0, f9_local6, f9_local7)
		f9_local0:setTopBottom(0, 0, f9_local8, f9_local9)
		f9_local0:registerEventHandler("transition_complete_keyframe", f9_local10)
	end
end
CoD.LocationSelectorUtility.DeselectMarker = function(f11_arg0, f11_arg1)
	f11_arg0:processEvent({
		name = "lose_focus",
		controller = f11_arg1,
	})
	f11_arg0:playClip("DefaultClip")
end
CoD.LocationSelectorUtility.MoveSelectionToTargetedMarker = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = f12_arg0.selectedMarker
	local f12_local1 = CoD.LocationSelectorUtility.FindTargetedMarker(f12_arg0, f12_arg1)
	if f12_local0 and f12_local1 then
		CoD.LocationSelectorUtility.DeselectMarker(f12_local0, f12_arg1)
		CoD.LocationSelectorUtility.SelectMarker(f12_arg0, f12_local1, f12_arg1)
		Engine.playsound("uin_main_edit", f12_arg1)
	end
end
CoD.LocationSelectorUtility.SelectCurrentMarker = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	if CoD.LocationSelectorUtility.IsLocationSelectorActive(f13_arg1) and not f13_arg3.occludedBy and CoD.BitUtility.IsBitwiseAndNonZero(Engine.GetModelValue(f13_arg2), Enum.LUIButtonFlags[@"flag_down"]) and not f13_arg3.m_disableAllButtonActions then
		local f13_local0 = f13_arg0.selectedMarker
		if f13_local0 then
			local f13_local1 = "marker_location"
			if f13_local0.objId == CoD.LocationSelectorUtility.PlayerFakeObjId then
				f13_local1 = "player_location"
			elseif f13_local0.objId == CoD.LocationSelectorUtility.ControlFakeObjId then
				f13_local1 = "take_control"
			end
			Engine.SendMenuResponse(f13_arg1, CoD.LocationSelectorUtility.MenuResponseName, f13_local1, f13_local0.objId)
			CoD.LocationSelectorUtility.DeselectMarker(f13_local0, f13_arg1)
		end
	end
end
CoD.LocationSelectorUtility.SetupDatapadLocationMap = function(f14_arg0, f14_arg1, f14_arg2)
	if f14_arg0.LocationMarker then
		f14_arg0.LocationMarker:close()
	end
	if f14_arg0.PatrolMarker then
		f14_arg0.PatrolMarker:close()
	end
	if f14_arg0.PlayerMarker then
		f14_arg0.PlayerMarker:close()
	end
	if not f14_arg0.markers then
		f14_arg0.markers = {}
		local f14_local0 = "datapad_location"
		local f14_local1 = CoD.LocationSelectorUtility.AddDatapadLocation
		local f14_local2 = CoD.LocationSelectorUtility.IsLocSelInCommandMode(f14_arg1)
		if f14_local2 then
			f14_local0 = "datapad_patrol_location"
			f14_local1 = CoD.LocationSelectorUtility.AddDatapadPatrolLocation
		end
		local f14_local3 = Engine.GetModelForController(f14_arg1)
		for f14_local4 = 0, 63, 1 do
			local f14_local7 = Engine.GetModel(f14_local3, "objective" .. f14_local4)
			if f14_local7 and f14_local7.id and f14_local7.objID then
				local f14_local8 = Engine.GetModelValue(Engine.GetModel(f14_local7, "id"))
				if f14_local8 == f14_local0 then
					local f14_local9 = Engine.GetModelValue(Engine.GetModel(f14_local7, "objID"))
					if f14_local9 then
						f14_local1(f14_arg0, f14_arg1, f14_arg2, f14_local9)
					end
				end
				if f14_local2 and CoD.LocationSelectorUtility.IsObjectiveCommandLocation(f14_local8) then
					local f14_local9 = Engine.GetModelValue(Engine.GetModel(f14_local7, "objID"))
					if f14_local9 then
						CoD.LocationSelectorUtility.AddDatapadObjectiveLocation(f14_arg0, f14_arg1, f14_arg2, f14_local9)
					end
				end
			end
		end
		if f14_local2 then
			CoD.LocationSelectorUtility.AddDatapadPlayerLocation(f14_arg0, f14_arg1, f14_arg2)
			f14_local4 = f14_arg0.markers[CoD.LocationSelectorUtility.PlayerFakeObjId]
			if f14_local4 then
				CoD.LocationSelectorUtility.SelectMarker(f14_arg0, f14_local4, f14_arg1)
			end
			if f14_arg0.TakeControlMarker then
				f14_local5 = CoD.LocationSelectorUtility.ControlFakeObjId
				f14_arg0.TakeControlMarker.objId = f14_local5
				f14_arg0.markers[f14_local5] = f14_arg0.TakeControlMarker
			end
			if f14_arg0.TakeControlMarker then
				CoD.LocationSelectorUtility.SelectMarker(f14_arg0, f14_arg0.TakeControlMarker, f14_arg1)
			end
		end
		local f14_local4, f14_local5, f14_local6 = pairs(f14_arg0.markers)
		local f14_local10, f14_local7 = f14_local4(f14_local5, f14_local6)
		if f14_local10 ~= nil then
			f14_local6 = f14_local10
			CoD.LocationSelectorUtility.SelectMarker(f14_arg0, f14_local7, f14_arg1)
		else
		end
		if f14_arg0.TakeControlMarker then
			f14_arg0.TakeControlMarker:close()
		end
	end
	LUI.OverrideFunction_CallOriginalFirst(f14_arg0, "close", function(element)
		if f14_arg0.markers then
			for f15_local3, f15_local4 in pairs(f14_arg0.markers) do
				f15_local4:close()
			end
		end
	end)
end
CoD.LocationSelectorUtility.SetupLocationSelectorControls = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
	f16_arg3:subscribeToGlobalModel(f16_arg1, "LeftStick", "Length", function(model)
		if CoD.LocationSelectorUtility.IsLocationSelectorActive(f16_arg1) then
			local f17_local0 = model:get()
			if CoD.isPC then
				CoD.LocationSelectorUtility.UpdateLeftStickVector(f16_arg3, f16_arg1)
				CoD.LocationSelectorUtility.MoveSelectionToTargetedMarker(f16_arg0, f16_arg1, f16_arg2)
			elseif f16_arg3.primed then
				if f17_local0 < 0.2 then
					f16_arg3.primed = false
					CoD.LocationSelectorUtility.MoveSelectionToTargetedMarker(f16_arg0, f16_arg1, f16_arg2)
				end
			elseif f17_local0 > 0.3 then
				CoD.LocationSelectorUtility.UpdateLeftStickVector(f16_arg3, f16_arg1)
				f16_arg3.primed = true
			end
		end
	end)
	f16_arg3:subscribeToGlobalModel(f16_arg1, "LeftStick", "Degrees", function(model)
		if CoD.LocationSelectorUtility.IsLocationSelectorActive(f16_arg1) then
			CoD.LocationSelectorUtility.UpdateLeftStickVector(f16_arg3, f16_arg1)
		end
	end)
	f16_arg3:subscribeToModel(Engine.GetModel(Engine.GetModelForController(f16_arg1), "ButtonBits." .. Enum.LUIButton[@"lui_key_xba_pscross"]), function(model)
		CoD.LocationSelectorUtility.SelectCurrentMarker(f16_arg3, f16_arg1, model, f16_arg2)
	end, false)
	f16_arg3:subscribeToModel(Engine.GetModel(Engine.GetModelForController(f16_arg1), "KeyPressBits.MOUSE1"), function(model)
		CoD.LocationSelectorUtility.SelectCurrentMarker(f16_arg3, f16_arg1, model, f16_arg2)
	end, false)
	f16_arg3:subscribeToModel(Engine.GetModel(Engine.GetModelForController(f16_arg1), "ButtonBits." .. Enum.LUIButton[@"lui_key_xbb_pscircle"]), function(model)
		if CoD.LocationSelectorUtility.IsLocationSelectorActive(f16_arg1) and not f16_arg2.occludedBy and CoD.BitUtility.IsBitwiseAndNonZero(Engine.GetModelValue(model), Enum.LUIButtonFlags[@"flag_down"]) and not f16_arg2.m_disableAllButtonActions then
			Engine.SendMenuResponse(f16_arg1, CoD.LocationSelectorUtility.MenuResponseName, "cancel", 0)
		end
	end, false)
end
CoD.LocationSelectorUtility.IsLocationSelectorActive = function(f22_arg0)
	return Engine.IsVisibilityBitSet(f22_arg0, Enum.UIVisibilityBit[@"bit_selecting_locational_killstreak"])
end
CoD.LocationSelectorUtility.IsLocSelInCommandMode = function(f23_arg0)
	local f23_local0 = Engine.GetModel(Engine.GetModelForController(f23_arg0), "locSel.commandMode")
	return f23_local0 and Engine.GetModelValue(f23_local0) == 1
end
CoD.LocationSelectorUtility.IsObjectiveCommandLocation = function(f24_arg0)
	local f24_local0 = LUI.startswith(f24_arg0, "control_")
	if not f24_local0 then
		f24_local0 = LUI.startswith(f24_arg0, "dom_")
	end
	return f24_local0
end
