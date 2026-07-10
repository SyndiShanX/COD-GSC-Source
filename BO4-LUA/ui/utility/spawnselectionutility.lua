
CoD.SpawnSelectionUtility = {}
local f0_local0 = -1
local f0_local1 = 3
local f0_local2 = 4
CoD.SpawnSelectionUtility.KillcamPipXpos = 0.67
CoD.SpawnSelectionUtility.KillcamPipYpos = 0.18
CoD.SpawnSelectionUtility.KillcamPipScale = 0.3
CoD.SpawnSelectionUtility.KillcamAnimTime = 200
CoD.SpawnSelectionUtility.SPAWNSELECT_TIMELIMIT_MS = 10000
CoD.SpawnSelectionUtility.MenuResponseName = "SpawnSelect"
CoD.SpawnSelectionUtility.SelectSpawnRegion = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4 )
	local f1_local0 = f1_arg0.SpawnRegionCursor
	if f1_local0 then
		local f1_local1, f1_local2 = f1_local0:getLocalSize()
		local f1_local3 = f1_local1 / 2
		local f1_local4 = f1_local2 / 2
		local f1_local5 = CoD.BaseUtility.GetElementCenterVec( f1_arg1 )
		local f1_local6 = f1_local5.x - f1_local3
		local f1_local7 = f1_local5.x + f1_local3
		local f1_local8 = f1_local5.y - f1_local4
		local f1_local9 = f1_local5.y + f1_local4
		local f1_local10 = function ( f2_arg0, f2_arg1 )
			if f1_arg4 then
				f1_local0:playClip( "Snap" )
			else
				f1_local0:playClip( "Acquire" )
			end
			local f2_local0 = f1_arg1:processEvent( {
				name = "gain_focus",
				controller = f1_arg2
			} )
			f1_arg0.selectedRegion = f1_arg1
			if Engine[@"getlobbymode"]( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] ) ) == Enum[@"lobbymode"][@"hash_3B3A1BBF18C0B176"] or IsSimulateCT() then
				Engine[@"sendmenuresponse"]( f1_arg2, CoD.SpawnSelectionUtility.MenuResponseName, "SpawnRegionFocus", f1_arg0.selectedRegion.objId )
			end
		end
		
		f1_local0:setAlpha( 1 )
		if f1_arg3 then
			f1_local0:playClip( "Release" )
			f1_local0:beginAnimation( "move", 50, true, true )
			f1_local0:setLeftRight( 0, 0, f1_local6, f1_local7 )
			f1_local0:setTopBottom( 0, 0, f1_local8, f1_local9 )
			f1_local0:registerEventHandler( "transition_complete_keyframe", f1_local10 )
		else
			f1_local0:setLeftRight( 0, 0, f1_local6, f1_local7 )
			f1_local0:setTopBottom( 0, 0, f1_local8, f1_local9 )
			f1_local10( f1_local0, nil )
		end
	end
end
CoD.SpawnSelectionUtility.DeselectSpawnRegion = function ( f3_arg0, f3_arg1, f3_arg2, f3_arg3 )
	f3_arg1:processEvent( {
		name = "lose_focus",
		controller = f3_arg2
	} )
	f3_arg1:playClip( "DefaultClip" )
	f3_arg0.selectedRegion = nil
	if not f3_arg3 then
		f3_arg0.SpawnRegionCursor:setAlpha( 0 )
	end
end
CoD.SpawnSelectionUtility.UpdateLeftStickVector = function ( f4_arg0, f4_arg1 )
	local f4_local0 = CoD.BaseUtility.GetLeftStickVector( f4_arg1 )
	f4_local0.y = -f4_local0.y
	f4_arg0.leftStickVector = f4_local0
end
CoD.SpawnSelectionUtility.FindTargetedSpawnBeacon = function ( f5_arg0, f5_arg1 )
	local f5_local0 = f5_arg0.selectedRegion
	if not f5_local0 then
		DebugPrint( "^1LUI - SpawnSelect: ^2invalid selectedRegion in FindTargetSpawnRegion" )
		if not f5_arg0.shouldHideAutoSpawn then
			local f5_local1 = f5_arg0.AutoSpawnMarker
		end
		f5_local0 = f5_local1 or nil
	end
	if not f5_local0 then
		return 
	end
	local f5_local2, f5_local3, f5_local4, f5_local5 = f5_local0:getLocalRect()
	local f5_local6 = CoD.BaseUtility.GetElementCenterVec( f5_local0 )
	local f5_local7 = f5_arg0.leftStickVector
	local f5_local8 = {}
	for f5_local12, f5_local13 in pairs( f5_arg0.beacons ) do
		local f5_local14 = CoD.BaseUtility.Vec2Sub( CoD.BaseUtility.GetElementCenterVec( f5_local13 ), f5_local6 )
		if CoD.BaseUtility.Vec2Dot( f5_local7, f5_local14 ) > 0 then
			table.insert( f5_local8, {
				marker = f5_local13,
				hitDist = CoD.BaseUtility.Vec2LenSq( CoD.BaseUtility.Vec2Reject( f5_local14, f5_local7 ) )
			} )
		end
	end
	if #f5_local8 > 0 then
		table.sort( f5_local8, function ( f6_arg0, f6_arg1 )
			return f6_arg0.hitDist < f6_arg1.hitDist
		end )
		return f5_local8[1].marker
	end
	return nil
end
CoD.SpawnSelectionUtility.FindBeaconTargetedByCursor = function ( f7_arg0, f7_arg1, f7_arg2 )
	local f7_local0 = {}
	local f7_local1 = f7_arg0:getRoot()
	for f7_local6, f7_local7 in pairs( f7_arg0.beacons ) do
		if Engine[@"ismouseinsideelement"]( f7_arg1, f7_local7, f7_local1.name, f7_arg2.x, f7_arg2.y ) then
			local f7_local5 = CoD.BaseUtility.GetElementCenterVec( f7_local7 )
			table.insert( f7_local0, {
				marker = f7_local7,
				hitDist = (f7_local5.x - f7_arg2.x) * (f7_local5.x - f7_arg2.x) + (f7_local5.y - f7_arg2.y) * (f7_local5.y - f7_arg2.y)
			} )
		end
	end
	if #f7_local0 > 0 then
		table.sort( f7_local0, function ( f8_arg0, f8_arg1 )
			return f8_arg0.hitDist < f8_arg1.hitDist
		end )
		return f7_local0[1].marker
	else
		return nil
	end
end
CoD.SpawnSelectionUtility.MoveSelectionToTargetedBeacon = function ( f9_arg0, f9_arg1, f9_arg2 )
	if not f9_arg0.SpawnSelectionMap then
		return 
	end
	local f9_local0 = f9_arg0.SpawnSelectionMap.selectedRegion
	local f9_local1 = CoD.SpawnSelectionUtility.FindTargetedSpawnBeacon( f9_arg0.SpawnSelectionMap, f9_arg1 )
	if f9_local1 then
		if f9_local0 then
			CoD.SpawnSelectionUtility.DeselectSpawnRegion( f9_arg0.SpawnSelectionMap, f9_local0, f9_arg1, f9_local1 )
		end
		CoD.SpawnSelectionUtility.SelectSpawnRegion( f9_arg0.SpawnSelectionMap, f9_local1, f9_arg1, f9_local0 )
		Engine[@"playsound"]( "uin_main_edit", f9_arg1 )
	end
end
CoD.SpawnSelectionUtility.PositionMarker = function ( f10_arg0, f10_arg1, f10_arg2, f10_arg3 )
	if f10_arg2 then
		local f10_local0, f10_local1 = f10_arg0:getLocalSize()
		local f10_local2, f10_local3, f10_local4, f10_local5 = Engine[@"getcompasscorners"]( f10_arg1 )
		local f10_local6, f10_local7 = Engine[@"getcompassnorth"]( f10_arg1 )
		local f10_local8, f10_local9 = f10_arg2:getLocalSize()
		local f10_local10, f10_local11 = nil
		if math.abs( f10_local6 ) > 0 then
			f10_local10 = (f10_arg3.y - f10_local3) / (f10_local5 - f10_local3) * f10_local0
			f10_local11 = (f10_arg3.x - f10_local2) / (f10_local4 - f10_local2) * f10_local1
		elseif math.abs( f10_local7 ) > 0 then
			f10_local10 = (f10_arg3.x - f10_local2) / (f10_local4 - f10_local2) * f10_local0
			f10_local11 = (f10_arg3.y - f10_local3) / (f10_local5 - f10_local3) * f10_local1
		end
		local f10_local12 = f10_local10 - f10_local8 * 0.5
		local f10_local13 = f10_local11 - f10_local9 * 0.5
		f10_arg2:setLeftRight( 0, 0, f10_local12, f10_local12 + f10_local8 )
		f10_arg2:setTopBottom( 0, 0, f10_local13, f10_local13 + f10_local9 )
	end
end
CoD.SpawnSelectionUtility.PositionObjectiveMarker = function ( f11_arg0, f11_arg1, f11_arg2, f11_arg3 )
	local f11_local0, f11_local1, f11_local2 = Engine[@"getobjectiveposition"]( f11_arg1, f11_arg3 )
	if f11_local0 and f11_local1 and f11_local2 then
		CoD.SpawnSelectionUtility.PositionMarker( f11_arg0, f11_arg1, f11_arg2, {
			x = f11_local0,
			y = f11_local1,
			z = f11_local2
		} )
	end
end
CoD.SpawnSelectionUtility.PositionSpawnBeacon = function ( f12_arg0, f12_arg1, f12_arg2 )
	CoD.SpawnSelectionUtility.PositionObjectiveMarker( f12_arg0, f12_arg1, f12_arg0.beacons[f12_arg2], f12_arg2 )
end
CoD.SpawnSelectionUtility.IsObjectiveInActiveState = function ( f13_arg0 )
	local f13_local0
	if f13_arg0 ~= Enum[@"objectivestate_t"][@"objst_active"] and f13_arg0 ~= Enum[@"objectivestate_t"][@"objst_invisible"] then
		f13_local0 = false
	else
		f13_local0 = true
	end
	return f13_local0
end
CoD.SpawnSelectionUtility.IsObjectiveSpawnBeacon = function ( f14_arg0, f14_arg1 )
	return Engine[@"getobjectivename"]( f14_arg0, f14_arg1 ) == @"spawnbeacon_objective"
end
CoD.SpawnSelectionUtility.IsObjectiveDeathMarker = function ( f15_arg0, f15_arg1 )
	return Engine[@"getobjectivename"]( f15_arg0, f15_arg1 ) == @"headicon_dead"
end
CoD.SpawnSelectionUtility.IsObjectiveSpawnGroup = function ( f16_arg0, f16_arg1 )
	if Engine[@"getobjectivename"]( f16_arg0, f16_arg1 ) then
		return false
	else
		return false
	end
end
CoD.SpawnSelectionUtility.IsObjectiveTeamOwned = function ( f17_arg0, f17_arg1 )
	return CoD.TeamUtility.GetTeamID( f17_arg0 ) == Engine[@"getobjectiveteam"]( f17_arg0, f17_arg1 )
end
CoD.SpawnSelectionUtility.IsSpawnEMPDisabled = function ( f18_arg0, f18_arg1 )
	if f18_arg1 ~= f0_local0 then
		return Engine[@"getobjectivegamemodeflags"]( f18_arg0, f18_arg1 ) == f0_local1
	else
		return false
	end
end
CoD.SpawnSelectionUtility.IsSpawnManualDisabled = function ( f19_arg0, f19_arg1 )
	if f19_arg1 ~= f0_local0 then
		return Engine[@"getobjectivegamemodeflags"]( f19_arg0, f19_arg1 ) == f0_local2
	else
		return false
	end
end
CoD.SpawnSelectionUtility.IsKillcamActive = function ( f20_arg0 )
	return CoD.ModelUtility.IsModelValueEqualTo( f20_arg0, "hudItems.killcamActive", 1 )
end
CoD.SpawnSelectionUtility.GetObjectiveModel = function ( f21_arg0, f21_arg1 )
	return Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f21_arg0 ), "objective" .. f21_arg1 )
end
CoD.SpawnSelectionUtility.ResizeSpawnRadius = function ( f22_arg0, f22_arg1, f22_arg2 )
	local f22_local0, f22_local1 = f22_arg0:getLocalSize()
	local f22_local2, f22_local3, f22_local4, f22_local5 = Engine[@"getcompasscorners"]( f22_arg2 )
	local f22_local6, f22_local7 = Engine[@"getcompassnorth"]( f22_arg2 )
	local f22_local8 = nil
	if math.abs( f22_local6 ) > 0 then
		f22_local8 = f22_local0 / math.abs( f22_local5 - f22_local3 )
	elseif math.abs( f22_local7 ) > 0 then
		f22_local8 = f22_local0 / math.abs( f22_local4 - f22_local2 )
	end
	local f22_local9 = Engine[@"hash_2E00B2F29271C60B"]( @"default_spawnbeacon_settings" )
	local f22_local10 = f22_local9[@"collectionradiusmax"]
	local f22_local11 = f22_local10 * f22_local8
	local f22_local12 = f22_arg1.SpawnSelectRadius
	if f22_local12 then
		f22_local12:setLeftRight( 0.5, 0.5, -f22_local11, f22_local11 )
		f22_local12:setTopBottom( 0.5, 0.5, -f22_local11, f22_local11 )
	end
	if f22_arg1.SpawnSelectRadius then
		f22_arg1.SpawnSelectRadius:playClip( "DefaultClip" )
		f22_arg1.SpawnSelectRadius.SpawnArea.MinimapSpawnRegion:setSpawnRegionData( f22_arg1.objId, f22_local10 )
	end
end
CoD.SpawnSelectionUtility.SetupKeyboardPrompt = function ( f23_arg0, f23_arg1 )
	if f23_arg0 ~= nil and f23_arg0.SpawnSelectionLabel ~= nil then
		local f23_local0 = IsMouseOrKeyboard( f23_arg1 )
		local f23_local1 = f23_arg0.SpawnSelectionLabel.SpawnPromptContainer
		local f23_local2 = f23_local1.Icon
		local f23_local3 = f23_local2
		f23_local2 = f23_local2.setAlpha
		local f23_local4
		if f23_local0 then
			f23_local4 = 0
			if not f23_local4 then
			
			else
				f23_local2( f23_local3, f23_local4 )
				f23_local2 = f23_local1.KeyPrompt
				f23_local3 = f23_local2
				f23_local2 = f23_local2.setAlpha
				if f23_local0 then
					f23_local4 = 1
					if not f23_local4 then
					
					else
						f23_local2( f23_local3, f23_local4 )
						f23_local1.KeyPrompt.keybind:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"key/space" ) )
						CoD.SpawnSelectionUtility.UpdateKeyboardPrompt( f23_arg0, f23_arg1 )
						f23_arg0:registerEventHandler( "input_source_changed", CoD.SpawnSelectionUtility.UpdateKeyboardPrompt )
					end
				end
				f23_local4 = 0
			end
		end
		f23_local4 = 1
	end
end
CoD.SpawnSelectionUtility.UpdateKeyboardPrompt = function ( f24_arg0, f24_arg1 )
	if f24_arg0.SpawnSelectionLabel ~= nil then
		local f24_local0 = IsMouseOrKeyboard( f24_arg1 )
		local f24_local1 = f24_arg0.SpawnSelectionLabel
		if f24_local0 and f24_local1.currentState == "DefaultState" then
			f24_local1:setState( f24_arg1, "DefaultStateKBM" )
		elseif not f24_local0 and f24_local1.currentState == "DefaultStateKBM" then
			f24_local1:setState( f24_arg1, "DefaultState" )
		end
	end
end
CoD.SpawnSelectionUtility.AddSpawnBeacon = function ( f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4, f25_arg5 )
	local f25_local0 = f25_arg0.beacons[f25_arg3]
	if not f25_local0 then
		if f25_arg4 then
			f25_local0 = CoD.SpawnGroupMarker.new( f25_arg2, f25_arg1, 0, 0, 0, CoD.SpawnGroupMarker.__defaultWidth, 0, 0, 0, CoD.SpawnGroupMarker.__defaultHeight )
		else
			f25_local0 = CoD.SpawnBeaconMarker.new( f25_arg2, f25_arg1, 0, 0, 0, CoD.SpawnGroupMarker.__defaultWidth, 0, 0, 0, CoD.SpawnGroupMarker.__defaultHeight )
		end
		f25_local0:makeFocusable( f25_arg1 )
		f25_local0.objId = f25_arg3
		f25_arg0.beacons[f25_arg3] = f25_local0
		f25_arg0:addElement( f25_local0 )
		f25_arg2:sendInitializationEvents( f25_arg1, f25_local0 )
	end
	f25_local0:setModel( CoD.SpawnSelectionUtility.GetObjectiveModel( f25_arg1, f25_arg3 ), f25_arg1 )
	CoD.SpawnSelectionUtility.PositionSpawnBeacon( f25_arg0, f25_arg1, f25_arg3 )
	if f25_arg5 then
		if f25_arg0.selectedRegion then
			CoD.SpawnSelectionUtility.DeselectSpawnRegion( f25_arg0, f25_arg0.selectedRegion, f25_arg1, f25_local0 )
		end
		CoD.SpawnSelectionUtility.SelectSpawnRegion( f25_arg0, f25_local0, f25_arg1, nil )
	end
	CoD.SpawnSelectionUtility.ResizeSpawnRadius( f25_arg0, f25_local0, f25_arg1 )
	if CoD.isPC and not f25_arg4 then
		CoD.SpawnSelectionUtility.SetupKeyboardPrompt( f25_local0, f25_arg1 )
	end
	CoD.SpawnSelectionUtility.AnimateMarkerPulse( f25_local0 )
end
CoD.SpawnSelectionUtility.RemoveSpawnBeacon = function ( f26_arg0, f26_arg1, f26_arg2 )
	local f26_local0 = f26_arg0.beacons[f26_arg2]
	if f26_local0 then
		f26_local0:close()
		f26_arg0.beacons[f26_arg2] = nil
		return true
	else
		return false
	end
end
CoD.SpawnSelectionUtility.SetupDeathMarker = function ( f27_arg0, f27_arg1, f27_arg2, f27_arg3 )
	local f27_local0 = f27_arg0.DeathMarker
	if f27_local0 and Engine[@"getpredictedclientnum"]( f27_arg1 ) == Engine[@"hash_4C43D7E71B1CA70B"]( f27_arg1, f27_arg3 ) then
		CoD.SpawnSelectionUtility.PositionObjectiveMarker( f27_arg0, f27_arg1, f27_arg0.DeathMarker, f27_arg3 )
		f27_local0:setState( f27_arg1, "Hidden" )
		local f27_local1 = CoD.SpawnSelectionUtility.GetObjectiveModel( f27_arg1, f27_arg3 )
		local f27_local2 = f27_local1.state
		f27_local0:unsubscribeFromAllModels()
		f27_local0:subscribeToModel( f27_local2, function ( model )
			if not CoD.SpawnSelectionUtility.IsObjectiveInActiveState( Engine[@"getmodelvalue"]( model ) ) then
				f27_local0:setState( f27_arg1, "DefaultState" )
				f27_local0:unsubscribeFromAllModels()
			end
		end )
	end
end
CoD.SpawnSelectionUtility.SetupSpawnBeacon = function ( f29_arg0, f29_arg1, f29_arg2, f29_arg3 )
	if not f29_arg0.beaconSubs[f29_arg3] then
		local f29_local0 = CoD.SpawnSelectionUtility.GetObjectiveModel( f29_arg1, f29_arg3 )
		f29_arg0.beaconSubs[f29_arg3] = f29_arg0:subscribeToModel( f29_local0.state, function ( model )
			if not CoD.SpawnSelectionUtility.IsObjectiveInActiveState( Engine[@"getmodelvalue"]( model ) ) then
				local f30_local0 = f29_arg0.beacons[f29_arg3]
				if f30_local0 and f29_arg0.selectedRegion == f30_local0 then
					local f30_local1
					if not f29_arg0.shouldHideAutoSpawn then
						f30_local1 = f29_arg0.AutoSpawnMarker
						if not f30_local1 then
						
						elseif f30_local1 then
							CoD.SpawnSelectionUtility.SelectSpawnRegion( f29_arg0, f30_local1, f29_arg1, nil, false )
						end
					end
					f30_local1 = nil
				end
			end
		end )
	end
end
CoD.SpawnSelectionUtility.GenerateSpawnBeacons = function ( f31_arg0, f31_arg1, f31_arg2 )
	for f31_local4, f31_local5 in pairs( f31_arg0.beaconSubs ) do
		local f31_local6 = CoD.SpawnSelectionUtility.GetObjectiveModel( f31_arg1, f31_local4 )
		local f31_local7 = CoD.SpawnSelectionUtility.IsObjectiveInActiveState( f31_local6.state:get() )
		local f31_local8 = CoD.SpawnSelectionUtility.IsObjectiveTeamOwned( f31_arg1, f31_local4 )
		local f31_local9 = CoD.SpawnSelectionUtility.IsObjectiveSpawnBeacon( f31_arg1, f31_local4 )
		local f31_local10 = CoD.SpawnSelectionUtility.IsObjectiveSpawnGroup( f31_arg1, f31_local4 )
		if f31_local7 and f31_local8 and (f31_local9 or f31_local10) then
			local f31_local3 = true
			if not f31_arg0.beacons[f31_local4] then
				CoD.SpawnSelectionUtility.AddSpawnBeacon( f31_arg0, f31_arg1, f31_arg2, f31_local4, f31_local10, f31_local3 )
			else
				CoD.SpawnSelectionUtility.RemoveSpawnBeacon( f31_arg0, f31_arg1, f31_local4 )
				CoD.SpawnSelectionUtility.AddSpawnBeacon( f31_arg0, f31_arg1, f31_arg2, f31_local4, f31_local10, f31_local3 )
				goto basicblock_10:
			end
		end
		CoD.SpawnSelectionUtility.RemoveSpawnBeacon( f31_arg0, f31_arg1, f31_local4 )
	end
	if CoD.isPC then
		f31_local0 = CoD.SpawnSelectionUtility.SetupKeyboardPrompt
		if not f31_arg0.shouldHideAutoSpawn then
			f31_local1 = f31_arg0.AutoSpawnMarker
			if not f31_local1 then
			
			else
				f31_local0( f31_local1, f31_arg1 )
			end
		end
		f31_local1 = nil
	end
end
CoD.SpawnSelectionUtility.IsKillcamFullscreen = function ( f32_arg0 )
	return f32_arg0.killcamFullscreen
end
CoD.SpawnSelectionUtility.IsKillcamAnimating = function ( f33_arg0 )
	return f33_arg0.killcamAnimTimer ~= nil
end
CoD.SpawnSelectionUtility.DestroyKillcamAnimTimer = function ( f34_arg0 )
	if f34_arg0.killcamAnimTimer then
		f34_arg0.killcamAnimTimer:close()
		f34_arg0.killcamAnimTimer = nil
	end
end
CoD.SpawnSelectionUtility.TrySetViewport = function ( f35_arg0, f35_arg1, f35_arg2, f35_arg3 )
	CoD.perController[f35_arg0].modifiedViewport = {
		x = f35_arg1,
		y = f35_arg2,
		width = f35_arg3,
		height = f35_arg3
	}
	if (CoD.perController[f35_arg0].viewportForcedFullscreen or 0) == 0 then
		local f35_local0 = CoD.perController[f35_arg0].modifiedViewport
		Engine[0x8F1E2D5A7266B8]( f35_arg0, f35_local0.x, f35_local0.y, f35_local0.width, f35_local0.height )
	end
end
CoD.SpawnSelectionUtility.AnimateViewport = function ( f36_arg0, f36_arg1 )
	if not f36_arg0.viewportScaleTime then
		f36_arg0.viewportScaleTime = f36_arg1.timeElapsed
	else
		f36_arg0.viewportScaleTime = f36_arg0.viewportScaleTime + f36_arg1.timeElapsed
	end
	local f36_local0 = f36_arg0.viewportScaleTime / f36_arg1.scaleDuration
	if f36_local0 > 1 then
		f36_local0 = 1
		f36_arg0.viewportScaleTime = nil
		CoD.SpawnSelectionUtility.DestroyKillcamAnimTimer( f36_arg0 )
	end
	local f36_local1 = f36_arg1.startScale + (f36_arg1.endScale - f36_arg1.startScale) * f36_local0
	local f36_local2 = f36_local0
	if f36_arg1.startScale < f36_arg1.endScale then
		f36_local2 = 1 - f36_local2
	end
	CoD.SpawnSelectionUtility.TrySetViewport( f36_arg1.controller, CoD.SpawnSelectionUtility.KillcamPipXpos * f36_local2, CoD.SpawnSelectionUtility.KillcamPipYpos * f36_local2, f36_local1 )
end
CoD.SpawnSelectionUtility.DoViewportAnimation = function ( f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4 )
	if not f37_arg0.m_viewportAnimHandler then
		f37_arg0:registerEventHandler( "viewport_animation", CoD.SpawnSelectionUtility.AnimateViewport )
		f37_arg0.m_viewportAnimHandler = true
	end
	CoD.SpawnSelectionUtility.DestroyKillcamAnimTimer( f37_arg0 )
	f37_arg0.killcamAnimTimer = LUI.UITimer.new( 1, {
		name = "viewport_animation",
		controller = f37_arg1,
		startScale = f37_arg2,
		endScale = f37_arg3,
		scaleDuration = f37_arg4
	}, false, f37_arg0 )
	f37_arg0:addElement( f37_arg0.killcamAnimTimer )
end
CoD.SpawnSelectionUtility.AnimateMarkerPulse = function ( f38_arg0 )
	local f38_local0 = f38_arg0.SpawnSelectPulse
	if f38_local0 then
		f38_local0:playClip( "DefaultClip" )
	end
end
CoD.SpawnSelectionUtility.AnimateMarkerSnap = function ( f39_arg0 )
	local f39_local0 = f39_arg0.SpawnSelectPulse
	if f39_local0 then
		f39_local0:playClip( "Snap" )
		f39_local0:beginAnimation( "pulse", 1200, true, true )
		f39_local0:registerEventHandler( "transition_complete_keyframe", function ( element, event )
			f39_local0:playClip( "DefaultClip" )
		end )
		f39_local0:registerEventHandler( "interrupted_keyframe", function ( element, event )
			f39_local0:playClip( "DefaultClip" )
		end )
	end
end
CoD.SpawnSelectionUtility.SetupSpawnSelectControls = function ( f42_arg0, f42_arg1, f42_arg2, f42_arg3 )
	local f42_local0 = function ()
		local f43_local0 = f42_arg2:getParent()
		f43_local0 = f43_local0.occludedBy
		if not f43_local0 then
			f43_local0 = f42_arg2.occludedBy
		end
		return f43_local0
	end
	
	f42_arg3:subscribeToGlobalModel( f42_arg1, "LeftStick", "Length", function ( model )
		if CoD.SpawnSelectionUtility.IsSpawnSelectActive( f42_arg1 ) and f42_arg3._readyForInput and not f42_local0() then
			local f44_local0 = model:get()
			if f42_arg3.primed then
				if f44_local0 < 0.2 then
					f42_arg3.primed = false
					CoD.SpawnSelectionUtility.MoveSelectionToTargetedBeacon( f42_arg0, f42_arg1, f42_arg2 )
				end
			elseif f44_local0 > 0.3 then
				CoD.SpawnSelectionUtility.UpdateLeftStickVector( f42_arg3, f42_arg1 )
				f42_arg3.primed = true
			end
		end
	end )
	f42_arg3:subscribeToGlobalModel( f42_arg1, "LeftStick", "Degrees", function ( model )
		if CoD.SpawnSelectionUtility.IsSpawnSelectActive( f42_arg1 ) and f42_arg3._readyForInput and not f42_local0() then
			CoD.SpawnSelectionUtility.UpdateLeftStickVector( f42_arg3, f42_arg1 )
		end
	end )
	local f42_local1 = function ( f46_arg0 )
		if CoD.SpawnSelectionUtility.IsSpawnSelectActive( f42_arg1 ) and f42_arg3._readyForInput and not f42_local0() and CoD.BitUtility.IsBitwiseAndNonZero( Engine[@"getmodelvalue"]( f46_arg0 ), Enum[@"luibuttonflags"][@"flag_down"] ) and not f42_arg2.m_disableAllButtonActions and not CoD.SpawnSelectionUtility.IsKillcamFullscreen( f42_arg0 ) and not CoD.SpawnSelectionUtility.IsKillcamAnimating( f42_arg0 ) then
			local f46_local0 = f42_arg3.selectedRegion
			if CoD.isPC and IsMouse( f42_arg1 ) then
				local f46_local1 = DataSources.FreeCursor.getModel( f42_arg1 )
				local f46_local1, f46_local2 = f46_local1.position:get()
				f46_local0 = CoD.SpawnSelectionUtility.FindBeaconTargetedByCursor( f42_arg0.SpawnSelectionMap, f42_arg1, {
					x = f46_local1,
					y = f46_local2
				} )
			end
			if CoD.isPC and f46_local0 and f46_local0 ~= f42_arg3.selectedRegion then
				if f42_arg3.selectedRegion then
					CoD.SpawnSelectionUtility.DeselectSpawnRegion( f42_arg0.SpawnSelectionMap, f42_arg3.selectedRegion, f42_arg1, nil )
				end
				CoD.SpawnSelectionUtility.SelectSpawnRegion( f42_arg0.SpawnSelectionMap, f46_local0, f42_arg1, nil )
				Engine[@"playsound"]( "uin_main_edit", f42_arg1 )
			elseif f46_local0 and f46_local0 == f42_arg3.selectedRegion then
				if not CoD.SpawnSelectionUtility.IsSpawnEMPDisabled( f42_arg1, f46_local0.objId ) and not CoD.SpawnSelectionUtility.IsSpawnManualDisabled( f42_arg1, f46_local0.objId ) and CoD.SpawnSelectionUtility.IsSpawnBeaconActive( f42_arg1, f46_local0 ) then
					if IsGameTypeCombatTraining() and IsPC() and not IsGamepad( f42_arg1 ) then
						Engine[@"sendmenuresponse"]( f42_arg1, CoD.SpawnSelectionUtility.MenuResponseName, "SpawnSelectKeyboard", f46_local0.objId )
					end
					Engine[@"sendmenuresponse"]( f42_arg1, CoD.SpawnSelectionUtility.MenuResponseName, "SpawnRegion", f46_local0.objId )
					local f46_local3 = f46_local0.objId == f0_local0
					f42_arg3.lastObjId = f46_local0.objId
					local f46_local4 = f42_arg3
					local f46_local5
					if not f46_local3 then
						f46_local5 = CoD.SpawnSelectionUtility.IsObjectiveSpawnBeacon( f42_arg1, f46_local0.objId )
					else
						f46_local5 = false
					end
					f46_local4.lastSelectedSpawnBeacon = f46_local5
					if f46_local3 then
						f42_arg3._activeBeaconsDuringLastSelection = {}
						for f46_local7, f46_local8 in pairs( f42_arg3.beacons ) do
							f42_arg3._activeBeaconsDuringLastSelection[f46_local7] = true
						end
					end
				end
			end
		end
	end
	
	f42_arg3:subscribeToModel( Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f42_arg1 ), "ButtonBits." .. Enum[@"luibutton"][@"lui_key_xba_pscross"] ), f42_local1, false )
	f42_arg3:subscribeToModel( Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f42_arg1 ), "ButtonBits." .. Enum[@"luibutton"][@"lui_key_xbx_pssquare"] ), f42_local1, false )
	if CoD.isPC then
		local f42_local2 = function ( f47_arg0, f47_arg1 )
			if CoD.SpawnSelectionUtility.IsSpawnSelectActive( f42_arg1 ) and f42_arg3._readyForInput then
				local f47_local0 = Engine[@"getmodelvalue"]( f47_arg0 )
				if not CoD.BitUtility.IsBitwiseAndNonZero( f47_local0, Enum[@"luibuttonflags"][@"flag_isrepeat"] ) and CoD.BitUtility.IsBitwiseAndNonZero( f47_local0, Enum[@"luibuttonflags"][@"flag_down"] ) then
					f42_arg3.leftStickVector = f47_arg1
					CoD.SpawnSelectionUtility.MoveSelectionToTargetedBeacon( f42_arg0, f42_arg1, f42_arg2 )
				end
			end
		end
		
		f42_arg3:subscribeToModel( Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f42_arg1 ), "KeyPressBits.ESCAPE" ), function ( model )
			local f48_local0 = Engine[@"getmodelvalue"]( model )
			local f48_local1 = CoD.BitUtility.IsBitwiseAndNonZero( f48_local0, Enum[@"luibuttonflags"][@"flag_down"] )
			local f48_local2 = CoD.BitUtility.IsBitwiseAndNonZero( f48_local0, Enum[@"luibuttonflags"][@"flag_isrepeat"] )
			if f48_local1 and CoD.SpawnSelectionUtility.IsSpawnSelectActive( f42_arg1 ) and f42_arg3._readyForInput then
				LockInputHUD( f42_arg0, f42_arg1, false )
				Engine[@"hash_1E06DCDAF717FCE0"]( f42_arg1 )
				LockInputHUD( f42_arg0, f42_arg1, true )
			end
		end, false )
		f42_arg3:subscribeToModel( Engine[@"hash_7A9FCAD7BE6FA349"]( "+forward", f42_arg1 ), function ( model )
			f42_local2( model, {
				x = 0,
				y = -1
			} )
		end, false )
		f42_arg3:subscribeToModel( Engine[@"hash_7A9FCAD7BE6FA349"]( "+back", f42_arg1 ), function ( model )
			f42_local2( model, {
				x = 0,
				y = 1
			} )
		end, false )
		f42_arg3:subscribeToModel( Engine[@"hash_7A9FCAD7BE6FA349"]( "+moveleft", f42_arg1 ), function ( model )
			f42_local2( model, {
				x = -1,
				y = 0
			} )
		end, false )
		f42_arg3:subscribeToModel( Engine[@"hash_7A9FCAD7BE6FA349"]( "+moveright", f42_arg1 ), function ( model )
			f42_local2( model, {
				x = 1,
				y = 0
			} )
		end, false )
		f42_arg3:subscribeToModel( Engine[@"hash_7A9FCAD7BE6FA349"]( "+activate", f42_arg1 ), f42_local1, false )
		f42_arg3:subscribeToModel( Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f42_arg1 ), "KeyPressBits.SPACE" ), f42_local1, false )
		f42_arg3:subscribeToModel( Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f42_arg1 ), "KeyPressBits.MOUSE1" ), f42_local1, false )
		if CursorInputEnabledForBuild( f42_arg1 ) then
			local f42_local3 = function ( f53_arg0 )
				if CoD.SpawnSelectionUtility.IsSpawnSelectActive( f42_arg1 ) and f42_arg3._readyForInput then
					local f53_local0, f53_local1 = f53_arg0:get()
					local f53_local2 = CoD.SpawnSelectionUtility.FindBeaconTargetedByCursor( f42_arg0.SpawnSelectionMap, f42_arg1, {
						x = f53_local0,
						y = f53_local1
					} )
					local f53_local3 = f42_arg0.SpawnSelectionMap.selectedRegion
					if f53_local3 ~= f53_local2 and f53_local2 then
						if f53_local3 then
							CoD.SpawnSelectionUtility.DeselectSpawnRegion( f42_arg0.SpawnSelectionMap, f53_local3, f42_arg1, f53_local2 )
						end
						CoD.SpawnSelectionUtility.SelectSpawnRegion( f42_arg0.SpawnSelectionMap, f53_local2, f42_arg1, f53_local3 )
						Engine[@"playsound"]( "uin_main_edit", f42_arg1 )
					end
				end
			end
			
			local f42_local4 = f42_arg0
			local f42_local5 = f42_arg0.subscribeToModel
			local f42_local6 = Engine[@"getmodelforcontroller"]( f42_arg1 )
			f42_local5( f42_local4, f42_local6.LastInput, function ( f54_arg0 )
				if CoD.SpawnSelectionUtility.IsSpawnSelectActive( f42_arg1 ) and f42_arg3._readyForInput and not f42_arg0.SpawnSelectionMap.selectedRegion and not Engine[@"lastinput_mouse"]() then
					local f54_local0 = f42_arg0.SpawnSelectionMap.beacons[f0_local0]
					if f54_local0 then
						CoD.SpawnSelectionUtility.SelectSpawnRegion( f42_arg0.SpawnSelectionMap, f54_local0, f42_arg1, nil )
					end
				end
			end, false )
		end
	end
end
CoD.SpawnSelectionUtility.SetupSpawnSelectionMap = function ( f55_arg0, f55_arg1, f55_arg2 )
	f55_arg0.beacons = {}
	f55_arg0.beaconSubs = {}
	local f55_local0 = f55_arg0.AutoSpawnMarker
	if f55_local0 then
		local f55_local1 = Engine[@"getglobalmodel"]()
		f55_local1 = f55_local1:create( "hideautospawnoption" )
		if f55_local1:get() == 1 then
			f55_local0:close()
			f55_arg0.shouldHideAutoSpawn = true
			f55_arg0.selectedRegion = nil
		else
			f55_local0:makeFocusable( f55_arg1 )
			f55_arg0.beacons[f0_local0] = f55_local0
		end
		f55_local0.objId = f0_local0
	end
	CoD.SpawnSelectionUtility.AnimateMarkerPulse( f55_local0 )
	if not f55_arg0.newObjSubscription then
		f55_arg0.newObjSubscription = f55_arg0:subscribeToModel( Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f55_arg1 ), "newObjective" ), function ( model )
			if not CoD.SpawnSelectionUtility.IsKillcamActive( f55_arg1 ) then
				local f56_local0 = Engine[@"getmodelvalue"]( model )
				if f56_local0 then
					local f56_local1 = CoD.SpawnSelectionUtility.IsObjectiveSpawnBeacon( f55_arg1, f56_local0 )
					local f56_local2 = CoD.SpawnSelectionUtility.IsObjectiveDeathMarker( f55_arg1, f56_local0 )
					local f56_local3 = CoD.SpawnSelectionUtility.IsObjectiveSpawnGroup( f55_arg1, f56_local0 )
					if CoD.SpawnSelectionUtility.IsObjectiveTeamOwned( f55_arg1, f56_local0 ) then
						if f56_local1 then
							CoD.SpawnSelectionUtility.SetupSpawnBeacon( f55_arg0, f55_arg1, f55_arg2, f56_local0 )
							CoD.SpawnSelectionUtility.AddSpawnBeacon( f55_arg0, f55_arg1, f55_arg2, f56_local0, true )
							local f56_local4 = CoD.SpawnSelectionUtility.GetObjectiveModel( f55_arg1, f56_local0 )
							f56_local4:create( "gamemodeFlags" )
							local f56_local5 = Engine[@"getmodelforcontroller"]( f55_arg1 )
							f56_local5 = f56_local5:create( "hudItems.SpawnBeaconObjective" )
							f56_local5:set( f56_local4 )
						elseif f56_local3 then
							CoD.SpawnSelectionUtility.SetupSpawnBeacon( f55_arg0, f55_arg1, f55_arg2, f56_local0 )
							CoD.SpawnSelectionUtility.AddSpawnBeacon( f55_arg0, f55_arg1, f55_arg2, f56_local0, true )
						end
					elseif f56_local2 then
						
					else
						
					end
				end
			end
		end )
	end
end
CoD.SpawnSelectionUtility.SetSpawnBeaconObjectiveModel = function ( f57_arg0, f57_arg1 )
	local f57_local0 = Engine[@"getmodelforcontroller"]( f57_arg1 )
	f57_local0 = f57_local0.hudItems.SpawnBeaconObjective:get()
	if f57_local0 ~= nil then
		f57_arg0:setModel( f57_local0, f57_arg1 )
	end
end
CoD.SpawnSelectionUtility.CloseAllMarkers = function ( f58_arg0, f58_arg1, f58_arg2 )
	for f58_local3, f58_local4 in pairs( f58_arg0.beaconSubs ) do
		CoD.SpawnSelectionUtility.RemoveSpawnBeacon( f58_arg0, f58_arg1, f58_local3 )
	end
end
CoD.SpawnSelectionUtility.SelectRecommendedSpawnRegion = function ( f59_arg0, f59_arg1, f59_arg2 )
	local f59_local0 = f59_arg0.AutoSpawnMarker
	for f59_local4, f59_local5 in pairs( f59_arg0.beacons ) do
		if f59_local4 ~= -1 then
			f59_local0 = f59_local5
		end
	end
	if f59_arg0.selectedRegion ~= f59_local0 then
		if f59_arg0.selectedRegion then
			CoD.SpawnSelectionUtility.DeselectSpawnRegion( f59_arg0, f59_arg0.selectedRegion, f59_arg1, f59_local0 )
		end
		if f59_local0 then
			CoD.SpawnSelectionUtility.SelectSpawnRegion( f59_arg0, f59_local0, f59_arg1, nil, true )
			CoD.SpawnSelectionUtility.AnimateMarkerSnap( f59_local0 )
		end
	elseif f59_local0 == f59_arg0.AutoSpawnMarker then
		CoD.SpawnSelectionUtility.SelectSpawnRegion( f59_arg0, f59_local0, f59_arg1, nil, true )
	end
end
CoD.SpawnSelectionUtility.SendMenuResponseForRecommendedRegion = function ( f60_arg0, f60_arg1, f60_arg2, f60_arg3 )
	if f60_arg3 then
		local f60_local0 = f0_local0
		local f60_local1 = f60_arg3.selectedRegion
		if f60_local1 then
			f60_local0 = f60_local1.objId
		end
		Engine[@"sendmenuresponse"]( f60_arg1, CoD.SpawnSelectionUtility.MenuResponseName, "SpawnRegion", f60_local0 )
	end
end
CoD.SpawnSelectionUtility.AddRecommendedSelectionTimer = function ( f61_arg0, f61_arg1, f61_arg2 )
	local f61_local0 = f61_arg0.SpawnSelectionMap
	if f61_local0 then
		f61_local0._readyForInput = nil
		CoD.SpawnSelectionUtility.GenerateSpawnBeacons( f61_local0, f61_arg1, f61_arg2 )
		local f61_local1 = f61_local0.AutoSpawnMarker
		if f61_local1 then
			f61_local1:playClip( "DefaultClip" )
		end
		f61_arg0:addElement( LUI.UITimer.newElementTimer( 250, true, function ( f62_arg0, f62_arg1 )
			CoD.SpawnSelectionUtility.SelectRecommendedSpawnRegion( f61_local0, f61_arg1, f61_arg2 )
		end ) )
		f61_arg0:addElement( LUI.UITimer.newElementTimer( 250, true, function ( f63_arg0, f63_arg1 )
			f61_local0._readyForInput = true
		end ) )
	end
end
CoD.SpawnSelectionUtility.ProcessMenuOpenedEventOnElement = function ( f64_arg0, f64_arg1, f64_arg2, f64_arg3 )
	if Engine[@"isdemoplaying"]() then
		return 
	else
		f64_arg2:menuOpened( f64_arg1, f64_arg2 )
		f64_arg2:sendInitializationEvents( f64_arg1, f64_arg3 )
	end
end
CoD.SpawnSelectionUtility.InitTimeLimit = function ( f65_arg0, f65_arg1, f65_arg2 )
	local f65_local0 = Engine[@"getdvarfloat"]( "spawnselect_timelimit_ms" )
	if not f65_local0 or f65_local0 == 0 then
		f65_local0 = CoD.SpawnSelectionUtility.SPAWNSELECT_TIMELIMIT_MS
	end
	local f65_local1 = Engine[@"getservertime"]( f65_arg1 )
	local f65_local2 = Engine[@"getmodelforcontroller"]( f65_arg1 )
	f65_local2.hudItems.spawnSelectEndTime:set( f65_local1 + f65_local0 )
end
CoD.SpawnSelectionUtility.RestoreNormalViewport = function ( f66_arg0, f66_arg1, f66_arg2 )
	CoD.SpawnSelectionUtility.DestroyKillcamAnimTimer( f66_arg0 )
	CoD.perController[f66_arg1].modifiedViewport = nil
	Engine[@"setviewport"]( f66_arg1 )
end
CoD.SpawnSelectionUtility.CalculateKillcamViewportSize = function ( f67_arg0, f67_arg1, f67_arg2, f67_arg3 )
	local f67_local0, f67_local1 = f67_arg0:getLocalSize()
	local f67_local2, f67_local3, f67_local4, f67_local5 = f67_arg3:getLocalRect()
	local f67_local6 = f67_local2 / f67_local0
	local f67_local7 = f67_local3 / f67_local1
	local f67_local8 = (f67_local4 - f67_local2 + 20) / f67_local0
	CoD.SpawnSelectionUtility.KillcamPipXpos = f67_local6
	CoD.SpawnSelectionUtility.KillcamPipYpos = f67_local7
	CoD.SpawnSelectionUtility.KillcamPipScale = f67_local8
end
CoD.SpawnSelectionUtility.ForceFullscreenViewportUntilClosed = function ( f68_arg0, f68_arg1 )
	CoD.perController[f68_arg1].viewportForcedFullscreen = (CoD.perController[f68_arg1].viewportForcedFullscreen or 0) + 1
	if CoD.perController[f68_arg1].modifiedViewport then
		Engine[@"setviewport"]( f68_arg1 )
	end
	LUI.OverrideFunction_CallOriginalSecond( f68_arg0, "close", function ()
		CoD.perController[f68_arg1].viewportForcedFullscreen = CoD.perController[f68_arg1].viewportForcedFullscreen - 1
		if CoD.perController[f68_arg1].viewportForcedFullscreen == 0 then
			local f69_local0 = CoD.perController[f68_arg1].modifiedViewport
			if f69_local0 ~= nil then
				Engine[0x8F1E2D5A7266B8]( f68_arg1, f69_local0.x, f69_local0.y, f69_local0.width, f69_local0.height )
			end
		end
	end )
end
CoD.SpawnSelectionUtility.SetupSpawnTimer = function ( f70_arg0, f70_arg1, f70_arg2 )
	local f70_local0 = function ()
		if f70_arg0._timer then
			f70_arg0._timer:close()
			f70_arg0._timer = nil
		end
	end
	
	local f70_local1 = function ()
		local f72_local0 = 10
		local f72_local1 = f70_arg0._endTime - Engine[@"getservertime"]( f70_arg1 )
		local f72_local2 = 1 - math.ceil( f72_local1 / f70_arg0._waitTime * f72_local0 ) / f72_local0
		if f70_arg0.Clock then
			f70_arg0.Clock:setShaderVector( 0, SetVectorComponent( 0, 0, 1, f72_local2, 0, 0 ) )
		end
		if f70_arg0.ClockGlow then
			f70_arg0.ClockGlow:setShaderVector( 0, SetVectorComponent( 0, 0, 1, f72_local2, 0, 0 ) )
		end
		if f72_local1 <= 0 then
			f70_local0()
		end
	end
	
	f70_arg0:subscribeToGlobalModel( f70_arg1, "HUDItems", "spawnSelectEndTime", function ( model )
		local f73_local0 = model:get()
		if f73_local0 ~= nil then
			local f73_local1 = f73_local0
			local f73_local2 = f73_local1 - Engine[@"getservertime"]( f70_arg1 )
			f70_arg0._endTime = f73_local1
			f70_arg0._waitTime = f73_local2
			if not f70_arg0._timer then
				local f73_local3 = LUI.UITimer.newElementTimer( 50, false, f70_local1 )
				f70_arg0:addElement( f73_local3 )
				f70_arg0._timer = f73_local3
			end
		end
	end )
end
CoD.SpawnSelectionUtility.IsSpawnSelectActive = function ( f74_arg0 )
	return CoD.ModelUtility.IsModelValueEqualTo( f74_arg0, "hudItems.showSpawnSelect", 1 )
end
CoD.SpawnSelectionUtility.IsSpawnGroupMarker = function ( f75_arg0, f75_arg1 )
	if f75_arg1.objId then
		return CoD.SpawnSelectionUtility.IsObjectiveSpawnGroup( f75_arg0, f75_arg1.objId )
	else
		return false
	end
end
CoD.SpawnSelectionUtility.IsSpawnBeaconActive = function ( f76_arg0, f76_arg1 )
	local f76_local0 = false
	if f76_arg1.objId == f0_local0 then
		f76_local0 = true
	end
	local f76_local1 = f76_arg1:getModel()
	if f76_local1 and CoD.SpawnSelectionUtility.IsObjectiveInActiveState( f76_local1.state:get() ) then
		f76_local0 = true
	end
	return f76_local0
end
CoD.SpawnSelectionUtility.IsSpawnBeaconDisabledOrDestroyed = function ( f77_arg0, f77_arg1 )
	if not CoD.SpawnSelectionUtility.IsSpawnBeaconActive( f77_arg0, f77_arg1 ) then
		return true
	else
		local f77_local0 = f77_arg1:getModel()
		if f77_local0 and f77_local0.gamemodeFlags then
			return f77_local0.gamemodeFlags:get() == f0_local2
		else
			return false
		end
	end
end
CoD.SpawnSelectionUtility.IsSpawnBeaconPromptHidden = function ( f78_arg0, f78_arg1 )
	if CoD.SpawnSelectionUtility.IsSpawnBeaconDisabledOrDestroyed( f78_arg0, f78_arg1 ) then
		return true
	else
		return CoD.ModelUtility.IsModelValueEqualTo( f78_arg0, "hudItems.spawnSelectHidePrompt", 1 )
	end
end
CoD.SpawnSelectionUtility.IsForwardSpawnTeamActive = function ( f79_arg0, f79_arg1 )
	local f79_local0 = CoD.TeamUtility.GetTeamID( f79_arg0 )
	local f79_local1 = Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "hudItems.war.forwardSpawnStatus" )
	return f79_local1:get() == f79_local0
end
CoD.SpawnSelectionUtility.IsForwardSpawnEnemyActive = function ( f80_arg0, f80_arg1 )
	local f80_local0 = 0
	local f80_local1 = 3
	local f80_local2 = CoD.TeamUtility.GetTeamID( f80_arg0 )
	local f80_local3 = Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "hudItems.war.forwardSpawnStatus" )
	f80_local3 = f80_local3:get()
	local f80_local4
	if f80_local2 == f80_local3 or f80_local3 == f80_local0 or f80_local3 == f80_local1 then
		f80_local4 = false
	else
		f80_local4 = true
	end
	return f80_local4
end
CoD.SpawnSelectionUtility.IsSpawnRegionVisible = function ( f81_arg0, f81_arg1 )
	local f81_local0 = f81_arg1:getModel()
	if f81_local0 and f81_local0.visStatus:get() == 1 then
		return true
	else
		return false
	end
end
CoD.SpawnSelectionUtility.IsSpawnRegionOwnedByTeam = function ( f82_arg0, f82_arg1 )
	local f82_local0 = f82_arg1:getModel()
	if f82_local0 then
		return CoD.TeamUtility.GetTeamID( f82_arg0 ) == f82_local0.team:get()
	else
		return false
	end
end
CoD.SpawnSelectionUtility.GetNameForSpawnUtilityIndex = function ( f83_arg0 )
	local f83_local0 = Engine[@"getglobalmodel"]()
	return CoD.SafeGetModelValue( f83_local0.spawngroupStatus, f83_arg0 .. ".regionName" ) or ""
end
CoD.SpawnSelectionUtility.KillcamWeaponPlusAlpha = function ( f84_arg0 )
	if locStringReturn and locStringReturn ~= "" then
		return 1
	else
		return 0
	end
end
