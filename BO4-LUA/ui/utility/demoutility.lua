
CoD.DemoUtility = {}
CoD.DemoUtility.GetRoundedTimeScale = function ( f1_arg0, f1_arg1 )
	if not f1_arg0 then
		local f1_local0 = Engine[0x8DF2E5447F384B9]()
		f1_arg0 = f1_local0.demo.timescale:get()
	end
	if not f1_arg1 then
		f1_arg1 = 1
	end
	local f1_local0 = 10 ^ f1_arg1
	return math.floor( f1_arg0 * f1_local0 + 0.5 ) / f1_local0
end
CoD.DemoUtility.GetRoundedTimeScaleString = function ( f2_arg0 )
	if not f2_arg0 then
		f2_arg0 = CoD.DemoUtility.GetRoundedTimeScale()
	end
	return string.format( "%.1f", f2_arg0 )
end
CoD.DemoUtility.GetRoundedLightFloatParam = function ( f3_arg0 )
	return string.format( "%.1f", f3_arg0 )
end
CoD.DemoUtility.GetDemoContextMode = function ()
	local f4_local0 = Engine[0x8DF2E5447F384B9]()
	return f4_local0.demo.contextMode:get()
end
CoD.DemoUtility.SetDemoContextMode = function ( f5_arg0 )
	local f5_local0 = Engine[0x8DF2E5447F384B9]()
	f5_local0.demo.contextMode:set( f5_arg0 )
end
CoD.DemoUtility.GetEditingDollyCameraMarker = function ()
	local f6_local0 = Engine[0x8DF2E5447F384B9]()
	return f6_local0.demo.editingDollyCameraMarker:get()
end
CoD.DemoUtility.SetEditingDollyCameraMarker = function ( f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4 )
	if f7_arg3 == true then
		Engine[0x7C75E608EA39B5C]( f7_arg2, "demo_editdollycammarker 1" )
	else
		Engine[0x7C75E608EA39B5C]( f7_arg2, "demo_editdollycammarker 0" )
	end
end
CoD.DemoUtility.SwitchToDollyCamMarker = function ( f8_arg0, f8_arg1 )
	Engine[0x7C75E608EA39B5C]( f8_arg0, "demo_switchdollycammarker " .. f8_arg1 )
end
CoD.DemoUtility.RemoveDollyCamMarker = function ( f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4 )
	Engine[0x7C75E608EA39B5C]( f9_arg2, "demo_removedollycammarker " .. f9_arg3 )
end
CoD.DemoUtility.RepositionDollyCamMarker = function ( f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4 )
	Engine[0x7C75E608EA39B5C]( f10_arg2, "demo_repositiondollycammarker " .. f10_arg3 )
end
CoD.DemoUtility.RemoveCurrentDollyCamMarker = function ( f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4 )
	CoD.DemoUtility.RemoveDollyCamMarker( f11_arg0, f11_arg1, f11_arg2, Engine[0x5BF9DEAE9B81079](), f11_arg4 )
	CoD.DemoUtility.SetEditingDollyCameraMarker( f11_arg0, f11_arg1, f11_arg2, false, f11_arg4 )
end
CoD.DemoUtility.GetEditingLightmanMarker = function ()
	local f12_local0 = Engine[0x8DF2E5447F384B9]()
	return f12_local0.demo.editingLightmanMarker:get()
end
CoD.DemoUtility.SetEditingLightmanMarker = function ( f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4 )
	if f13_arg3 == true then
		Engine[0x7C75E608EA39B5C]( f13_arg2, "demo_editlightmanmarker 1" )
	else
		Engine[0x7C75E608EA39B5C]( f13_arg2, "demo_editlightmanmarker 0" )
	end
end
CoD.DemoUtility.SwitchToLightmanMarker = function ( f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4 )
	Engine[0x7C75E608EA39B5C]( f14_arg2, "demo_switchlightmanmarker " .. f14_arg3 )
end
CoD.DemoUtility.CycleLightmanMarker = function ( f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4 )
	local f15_local0 = -1
	if f15_arg3 == "forward" then
		f15_local0 = Engine[0x5BF9DEAE9B81079]() + 1
	elseif f15_arg3 == "back" then
		f15_local0 = Engine[0x5BF9DEAE9B81079]() - 1
	end
	if f15_local0 >= 0 then
		local f15_local1 = Engine[0x8DF2E5447F384B9]()
		if f15_local0 < f15_local1.demo.lightmanMarkerCount:get() then
			CoD.DemoUtility.SwitchToLightmanMarker( f15_arg0, f15_arg1, f15_arg2, f15_local0, f15_arg4 )
		end
	end
end
CoD.DemoUtility.RemoveLightmanMarker = function ( f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4 )
	Engine[0x7C75E608EA39B5C]( f16_arg2, "demo_removelightmanmarker " .. f16_arg3 )
end
CoD.DemoUtility.RepositionLightmanMarker = function ( f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4 )
	Engine[0x7C75E608EA39B5C]( f17_arg2, "demo_repositionlightmanmarker " .. f17_arg3 )
end
CoD.DemoUtility.RemoveCurrentLightmanMarker = function ( f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4 )
	CoD.DemoUtility.RemoveLightmanMarker( f18_arg0, f18_arg1, f18_arg2, Engine[0x5BF9DEAE9B81079](), f18_arg4 )
	CoD.DemoUtility.SetEditingLightmanMarker( f18_arg0, f18_arg1, f18_arg2, false, f18_arg4 )
end
CoD.DemoUtility.SetCurrentLightmanColor = function ( f19_arg0, f19_arg1 )
	local f19_local0 = CoD.ColorUtility.GetColorFromFormattedColorString( f19_arg1 )
	local f19_local1 = Engine[0x8DF2E5447F384B9]()
	f19_local1.demo.currentLightmanMarkerLightColorR:set( f19_local0.r )
	f19_local1 = Engine[0x8DF2E5447F384B9]()
	f19_local1.demo.currentLightmanMarkerLightColorG:set( f19_local0.g )
	f19_local1 = Engine[0x8DF2E5447F384B9]()
	f19_local1.demo.currentLightmanMarkerLightColorB:set( f19_local0.b )
	Engine[0x7C75E608EA39B5C]( f19_arg0, "demo_updatelightmanmarkerparameters " .. Engine[0x5BF9DEAE9B81079]() )
end
CoD.DemoUtility.RunPauseCommand = function ( f20_arg0 )
	CoD.DemoUtility.TogglePlayerPauseModelValue()
	Engine[0xB81A5136C5503E4]( f20_arg0, "demo_pause" )
end
CoD.DemoUtility.UnpauseIfPaused = function ( f21_arg0 )
	local f21_local0 = Engine[0x8DF2E5447F384B9]()
	if f21_local0.demo.isPaused:get() then
		CoD.DemoUtility.RunPauseCommand( f21_arg0 )
	end
end
CoD.DemoUtility.IsRestrictedBasicMode = function ()
	if Dvar[0x1CB961267A5A699]:exists() and Dvar[0x1CB961267A5A699]:get() ~= "0" then
		return false
	else
		return true
	end
end
CoD.DemoUtility.IsCameraCyclingDisabled = function ()
	local f23_local0 = Engine[0x8DF2E5447F384B9]()
	f23_local0 = f23_local0.demo.isCameraCyclingDisabled
	if f23_local0 then
		return f23_local0:get()
	else
		return false
	end
end
CoD.DemoUtility.IsFastForwardingDisabled = function ()
	local f24_local0 = Engine[0x8DF2E5447F384B9]()
	f24_local0 = f24_local0.demo.isFastForwardingDisabled
	if f24_local0 then
		return f24_local0:get()
	else
		return false
	end
end
CoD.DemoUtility.TakeScreenshot = function ( f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4 )
	Engine[0x7C75E608EA39B5C]( f25_arg2, "demo_screenshot" )
end
CoD.DemoUtility.DemoSwitchPlayer = function ( f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4 )
	if f26_arg3 == "forward" then
		Engine[0x7C75E608EA39B5C]( f26_arg2, "demo_switchplayer 0" )
	elseif f26_arg3 == "back" then
		Engine[0x7C75E608EA39B5C]( f26_arg2, "demo_switchplayer 1" )
	end
end
CoD.DemoUtility.UpdateDemoCameraMode = function ( f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4 )
	if f27_arg3 == nil or f27_arg3 == "" then
		return 
	end
	local f27_local0 = Engine[0x8DF2E5447F384B9]()
	f27_local0 = f27_local0.demo.cameraMode:get()
	local f27_local1 = nil
	if f27_arg3 == "next" or f27_arg3 == "cycle" then
		if f27_local0 == Enum[0xF432DF404208022][0x448CED16817146D] then
			f27_local1 = Enum[0xF432DF404208022][0xFCA80C27FBE8269]
		elseif f27_local0 == Enum[0xF432DF404208022][0xFCA80C27FBE8269] then
			f27_local1 = Enum[0xF432DF404208022][0x3B1995A6E46FA28]
		elseif f27_arg3 == "cycle" then
			f27_local1 = Enum[0xF432DF404208022][0x448CED16817146D]
		else
			return 
		end
	elseif f27_arg3 == "prev" then
		if f27_local0 == Enum[0xF432DF404208022][0xFCA80C27FBE8269] then
			f27_local1 = Enum[0xF432DF404208022][0x448CED16817146D]
		elseif f27_local0 == Enum[0xF432DF404208022][0x3B1995A6E46FA28] then
			f27_local1 = Enum[0xF432DF404208022][0xFCA80C27FBE8269]
		else
			return 
		end
	end
	Engine[0xCCDD5DEE6A7B3CE]( f27_local1 )
end
CoD.DemoUtility.UpdateDemoFastForward = function ( f28_arg0 )
	local f28_local0 = CoD.DemoUtility.GetRoundedTimeScale()
	local f28_local1 = nil
	if f28_local0 >= 6 then
		f28_local1 = 1
	elseif f28_local0 >= 4 then
		f28_local1 = 6
	elseif f28_local0 >= 2 then
		f28_local1 = 4
	elseif f28_local0 >= 1 then
		f28_local1 = 2
	else
		f28_local1 = 1
	end
	Engine[0xB81A5136C5503E4]( f28_arg0, "demo_timescale " .. f28_local1 )
	local f28_local2 = Engine[0x8DF2E5447F384B9]()
	f28_local2 = f28_local2.demo.timeScale
	if f28_local2 then
		f28_local2:set( f28_local1 )
	end
	return f28_local1
end
CoD.DemoUtility.UpdateDemoTimeScaleDelta = function ( f29_arg0, f29_arg1, f29_arg2, f29_arg3, f29_arg4 )
	local f29_local0 = 1
	local f29_local1 = CoD.DemoUtility.GetRoundedTimeScale()
	local f29_local2 = tonumber( f29_arg3 )
	local f29_local3 = f29_local1 + f29_arg3
	if not (f29_local0 > f29_local1 or f29_local3 > Dvar[0x65BE4626D4D30D0]:get() or f29_local2 <= 0) or f29_local1 <= f29_local0 and f29_local3 >= 0.1 and f29_local2 < 0 then
		Engine[0x7C75E608EA39B5C]( f29_arg2, "demo_timescale " .. f29_local3 )
	else
		Engine[0x7C75E608EA39B5C]( f29_arg2, "demo_timescale " .. f29_local0 )
	end
end
CoD.DemoUtility.UpdateDemoTimeScaleForTrigger = function ( f30_arg0, f30_arg1, f30_arg2, f30_arg3 )
	if f30_arg1 == nil then
		return 
	end
	local f30_local0 = f30_arg1.amount:get()
	local f30_local1 = f30_arg3 - f30_arg2
	if f30_local1 > 0 and CoD.DemoUtility.IsFastForwardingDisabled() then
		return 
	end
	local f30_local2 = CoD.DemoUtility.GetRoundedTimeScale( f30_arg2 + f30_local0 * f30_local1 )
	Engine[0xB81A5136C5503E4]( f30_arg0, "demo_timescale " .. f30_local2 )
	local f30_local3 = Engine[0x8DF2E5447F384B9]()
	f30_local3 = f30_local3.demo.timeScale
	if f30_local3 then
		f30_local3:set( f30_local2 )
	end
	return f30_local2
end
CoD.DemoUtility.DemoTimeJump = function ( f31_arg0, f31_arg1, f31_arg2, f31_arg3, f31_arg4 )
	if f31_arg3 == "forward" then
		if CoD.GameEndScoreUtility.IsInTransition( f31_arg2 ) then
			CoD.GameEndScoreUtility.ClearTransitionModels( f31_arg2 )
		end
		Engine[0x7C75E608EA39B5C]( f31_arg2, "demo_forward" )
	elseif f31_arg3 == "back" then
		if CoD.GameEndScoreUtility.IsInTransition( f31_arg2 ) then
			CoD.GameEndScoreUtility.ClearTransitionModels( f31_arg2 )
		end
		Engine[0x7C75E608EA39B5C]( f31_arg2, "demo_back" )
	end
end
CoD.DemoUtility.DemoToggleGameHud = function ( f32_arg0 )
	Engine[0x7C75E608EA39B5C]( f32_arg0, "demo_togglegamehud" )
end
CoD.DemoUtility.DemoToggleDemoHud = function ( f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4 )
	Engine[0x7C75E608EA39B5C]( f33_arg2, "demo_toggledemohud" )
	if CoD.isPC then
		f33_arg0.demoShowMouse = not f33_arg0.demoShowMouse
	end
end
CoD.DemoUtility.DemoCancelPreview = function ( f34_arg0, f34_arg1, f34_arg2, f34_arg3, f34_arg4 )
	Engine[0x7C75E608EA39B5C]( f34_arg2, "demo_cancelpreview" )
end
CoD.DemoUtility.DemoStartAutoDollyCamera = function ( f35_arg0, f35_arg1, f35_arg2, f35_arg3, f35_arg4 )
	CoD.DemoUtility.UnpauseIfPaused( f35_arg2 )
	Engine[0x7C75E608EA39B5C]( f35_arg2, "demo_startautodollycam" )
end
CoD.DemoUtility.DemoStopAutoDollyCamera = function ( f36_arg0, f36_arg1, f36_arg2, f36_arg3, f36_arg4 )
	Engine[0x7C75E608EA39B5C]( f36_arg2, "demo_stopautodollycam" )
end
CoD.DemoUtility.DemoAddDollyCameraMarker = function ( f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4 )
	Engine[0x7C75E608EA39B5C]( f37_arg2, "demo_adddollycammarker" )
end
CoD.DemoUtility.StartStopRecordClip = function ( f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4 )
	if Engine[0x5EC757FC8E459CB]() then
		Engine[0x7C75E608EA39B5C]( f38_arg2, "demo_pausecliprecord" )
	else
		if Engine[0xFCF13BF1C420FCE]() then
			CoD.DemoUtility.UnpauseIfPaused( f38_arg2 )
			Engine[0x18E18660B901CA0]( Enum[0x66BE675172715C][0xF3D42DF364CABF1] )
		end
		if Engine[0x3B799DC771E1BC2]( f38_arg2, 0x7B9CFAC708D387F ) then
			CoD.DemoUtility.UnpauseIfPaused( f38_arg2 )
		end
		Engine[0x7C75E608EA39B5C]( f38_arg2, "demo_startcliprecord" )
	end
end
CoD.DemoUtility.DemoTimeJumpDollyCameraMarker = function ( f39_arg0, f39_arg1, f39_arg2, f39_arg3, f39_arg4 )
	local f39_local0 = -1
	if f39_arg3 == "forward" then
		local f39_local1 = Engine[0x8DF2E5447F384B9]()
		f39_local0 = f39_local1.demo.dollyCamMarkerForJumpForward:get()
	elseif f39_arg3 == "back" then
		local f39_local1 = Engine[0x8DF2E5447F384B9]()
		f39_local0 = f39_local1.demo.dollyCamMarkerForJumpBack:get() - 1
	end
	if f39_local0 ~= -1 then
		CoD.DemoUtility.SwitchToDollyCamMarker( f39_arg2, f39_local0 )
	end
end
CoD.DemoUtility.DemoEditDollyCameraMarker = function ( f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4 )
	CoD.DemoUtility.SwitchToDollyCamMarker( f40_arg2, -1 )
	CoD.DemoUtility.SetEditingDollyCameraMarker( f40_arg0, f40_arg1, f40_arg2, true, f40_arg4 )
end
CoD.DemoUtility.DemoExitEditDollyCameraMarker = function ( f41_arg0, f41_arg1, f41_arg2, f41_arg3, f41_arg4 )
	Engine[0x7C75E608EA39B5C]( f41_arg2, "demo_updatedollycammarkerparameters " .. Engine[0x5BF9DEAE9B81079]() )
	CoD.DemoUtility.SetEditingDollyCameraMarker( f41_arg0, f41_arg1, f41_arg2, false, f41_arg4 )
end
CoD.DemoUtility.DemoPlaceDollyCameraMarker = function ( f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4 )
	Engine[0x7C75E608EA39B5C]( f42_arg2, "demo_applynewdollycammarkerposition 0" )
end
CoD.DemoUtility.DemoCancelPlaceDollyCameraMarker = function ( f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4 )
	Engine[0x7C75E608EA39B5C]( f43_arg2, "demo_applynewdollycammarkerposition 1" )
end
CoD.DemoUtility.UpdateDollyCameraTimeScaleMode = function ( f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4 )
	if f44_arg3 == nil or f44_arg3 == "" then
		return 
	end
	local f44_local0 = Engine[0x8DF2E5447F384B9]()
	f44_local0 = f44_local0.demo.currentDollyCamMarkerTimeScaleMode
	local f44_local1 = f44_local0:get()
	local f44_local2 = nil
	if f44_arg3 == "next" or f44_arg3 == "cycle" then
		if f44_local1 == Enum[0x253C21AFC0AAE25][0xB995D2A247B7393] then
			f44_local2 = Enum[0x253C21AFC0AAE25][0xB5BFD14EC391330]
		elseif f44_local1 == Enum[0x253C21AFC0AAE25][0xB5BFD14EC391330] then
			f44_local2 = Enum[0x253C21AFC0AAE25][0x6F50CE93BF28DA9]
		elseif f44_arg3 == "cycle" then
			f44_local2 = Enum[0x253C21AFC0AAE25][0xB995D2A247B7393]
		else
			return 
		end
	elseif f44_arg3 == "prev" then
		if f44_local1 == Enum[0x253C21AFC0AAE25][0xB5BFD14EC391330] then
			f44_local2 = Enum[0x253C21AFC0AAE25][0xB995D2A247B7393]
		elseif f44_local1 == Enum[0x253C21AFC0AAE25][0x6F50CE93BF28DA9] then
			f44_local2 = Enum[0x253C21AFC0AAE25][0xB5BFD14EC391330]
		else
			return 
		end
	end
	f44_local0:set( f44_local2 )
end
CoD.DemoUtility.UpdateDollyCameraTimeScale = function ( f45_arg0, f45_arg1, f45_arg2, f45_arg3, f45_arg4 )
	local f45_local0 = Engine[0x8DF2E5447F384B9]()
	f45_local0 = f45_local0.demo.currentDollyCamMarkerTimeScaleValue
	if not f45_local0 then
		return 
	end
	local f45_local1 = f45_local0:get()
	local f45_local2 = tonumber( f45_arg3 )
	local f45_local3 = f45_local1 + f45_local2
	if not (f45_local2 <= 0 or f45_local3 > Dvar[0x65BE4626D4D30D0]:get()) or f45_local2 < 0 and f45_local3 >= 0.1 then
		f45_local0:set( f45_local3 )
	end
end
CoD.DemoUtility.ToggleDollyCameraMode = function ( f46_arg0, f46_arg1, f46_arg2, f46_arg3, f46_arg4 )
	if Engine[0x82C36BC3D9A8635]() then
		Engine[0x18E18660B901CA0]( Enum[0x66BE675172715C][0xFA038EBA43002CB] )
	else
		CoD.DemoUtility.UnpauseIfPaused( f46_arg2 )
		Engine[0x18E18660B901CA0]( Enum[0x66BE675172715C][0xF3D42DF364CABF1] )
	end
end
CoD.DemoUtility.DemoFreeCameraLockOnObject = function ( f47_arg0, f47_arg1, f47_arg2, f47_arg3, f47_arg4 )
	Engine[0x7C75E608EA39B5C]( f47_arg2, "demo_activatefreecameralockon" )
end
CoD.DemoUtility.DemoFreeCameraUnlockObject = function ( f48_arg0, f48_arg1, f48_arg2, f48_arg3, f48_arg4 )
	Engine[0x7C75E608EA39B5C]( f48_arg2, "demo_deactivatefreecameralockon" )
end
CoD.DemoUtility.DemoAddLightmanMarker = function ( f49_arg0, f49_arg1, f49_arg2, f49_arg3, f49_arg4 )
	Engine[0x7C75E608EA39B5C]( f49_arg2, "demo_addlightmanmarker" )
end
CoD.DemoUtility.DemoEditLightmanMarker = function ( f50_arg0, f50_arg1, f50_arg2, f50_arg3, f50_arg4 )
	CoD.DemoUtility.SwitchToLightmanMarker( f50_arg0, f50_arg1, f50_arg2, -1, f50_arg4 )
	CoD.DemoUtility.SetEditingLightmanMarker( f50_arg0, f50_arg1, f50_arg2, true, f50_arg4 )
end
CoD.DemoUtility.DemoExitEditLightmanMarker = function ( f51_arg0, f51_arg1, f51_arg2, f51_arg3, f51_arg4 )
	Engine[0x7C75E608EA39B5C]( f51_arg2, "demo_updatelightmanmarkerparameters " .. Engine[0x5BF9DEAE9B81079]() )
	CoD.DemoUtility.SetEditingLightmanMarker( f51_arg0, f51_arg1, f51_arg2, false, f51_arg4 )
end
CoD.DemoUtility.DemoPlaceLightmanMarker = function ( f52_arg0, f52_arg1, f52_arg2, f52_arg3, f52_arg4 )
	Engine[0x7C75E608EA39B5C]( f52_arg2, "demo_applynewlightmanmarkerposition 0" )
end
CoD.DemoUtility.DemoCancelPlaceLightmanMarker = function ( f53_arg0, f53_arg1, f53_arg2, f53_arg3, f53_arg4 )
	Engine[0x7C75E608EA39B5C]( f53_arg2, "demo_applynewlightmanmarkerposition 1" )
end
CoD.DemoUtility.UpdateLightmanLightMode = function ( f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4 )
	if f54_arg3 == nil or f54_arg3 == "" then
		return 
	end
	local f54_local0 = Engine[0x8DF2E5447F384B9]()
	f54_local0 = f54_local0.demo.currentLightmanMarkerLightMode
	local f54_local1 = f54_local0:get()
	local f54_local2 = nil
	if f54_arg3 == "next" or f54_arg3 == "cycle" then
		if f54_local1 == Enum[0x18F5DBF6846E161][0x9B555BF182ED7E2] then
			f54_local2 = Enum[0x18F5DBF6846E161][0xF42C1DD963B204B]
		elseif f54_arg3 == "cycle" then
			f54_local2 = Enum[0x18F5DBF6846E161][0x9B555BF182ED7E2]
		else
			return 
		end
	elseif f54_arg3 == "prev" then
		if f54_local1 == Enum[0x18F5DBF6846E161][0xF42C1DD963B204B] then
			f54_local2 = Enum[0x18F5DBF6846E161][0x9B555BF182ED7E2]
		else
			return 
		end
	end
	f54_local0:set( f54_local2 )
	Engine[0x7C75E608EA39B5C]( f54_arg2, "demo_updatelightmanmarkerparameters " .. Engine[0x5BF9DEAE9B81079]() )
end
CoD.DemoUtility.UpdateLightmanFloatParam = function ( f55_arg0, f55_arg1, f55_arg2 )
	local f55_local0 = 0 < f55_arg2
	local f55_local1 = 0
	local f55_local2 = 20
	if not f55_arg1 then
		return 
	end
	local f55_local3 = f55_arg1:get() + f55_arg2
	if not (not f55_local0 or f55_local3 > f55_local2) or not f55_local0 and f55_local1 <= f55_local3 then
		f55_arg1:set( f55_local3 )
		Engine[0x7C75E608EA39B5C]( f55_arg0, "demo_updatelightmanmarkerparameters " .. Engine[0x5BF9DEAE9B81079]() )
	end
end
CoD.DemoUtility.UpdateLightmanIntensity = function ( f56_arg0, f56_arg1, f56_arg2, f56_arg3, f56_arg4 )
	local f56_local0 = CoD.DemoUtility.UpdateLightmanFloatParam
	local f56_local1 = f56_arg2
	local f56_local2 = Engine[0x8DF2E5447F384B9]()
	f56_local0( f56_local1, f56_local2.demo.currentLightmanMarkerLightIntensity, tonumber( f56_arg3 ) )
end
CoD.DemoUtility.UpdateLightmanRange = function ( f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4 )
	local f57_local0 = CoD.DemoUtility.UpdateLightmanFloatParam
	local f57_local1 = f57_arg2
	local f57_local2 = Engine[0x8DF2E5447F384B9]()
	f57_local0( f57_local1, f57_local2.demo.currentLightmanMarkerLightRange, tonumber( f57_arg3 ) )
end
CoD.DemoUtility.UpdateLightmanLightColor = function ( f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4 )
	OpenPopup( f58_arg4:getParent(), "LightmanColorPicker", f58_arg2 )
	local f58_local0 = Engine[0x8DF2E5447F384B9]()
	f58_local0.demo.showLightmanColorPicker:set( true )
end
CoD.DemoUtility.StoreCurrentLightmanColor = function ( f59_arg0, f59_arg1, f59_arg2, f59_arg3 )
	local f59_local0 = Engine[0x8DF2E5447F384B9]()
	f59_local0 = f59_local0.demo.currentLightmanMarkerLightColorR:get()
	local f59_local1 = Engine[0x8DF2E5447F384B9]()
	f59_local1 = f59_local1.demo.currentLightmanMarkerLightColorG:get()
	local f59_local2 = Engine[0x8DF2E5447F384B9]()
	CoD.DemoUtility.CurrentLightmanColor = string.format( "%d %d %d", f59_local0 * 255, f59_local1 * 255, f59_local2.demo.currentLightmanMarkerLightColorB:get() * 255 )
end
CoD.DemoUtility.SelectLightmanColor = function ( f60_arg0, f60_arg1, f60_arg2, f60_arg3 )
	local f60_local0 = f60_arg1:getModel()
	f60_local0 = f60_local0.color
	if f60_local0 then
		CoD.DemoUtility.SetCurrentLightmanColor( f60_arg2, f60_local0:get() )
	end
end
CoD.DemoUtility.CancelLightmanColorSelection = function ( f61_arg0, f61_arg1, f61_arg2, f61_arg3 )
	if not CoD.DemoUtility.CurrentLightmanColor then
		return 
	else
		CoD.DemoUtility.SetCurrentLightmanColor( f61_arg2, CoD.DemoUtility.CurrentLightmanColor )
	end
end
CoD.DemoUtility.CloseChooseModeSidebar = function ( f62_arg0, f62_arg1 )
	local f62_local0 = GoBack( f62_arg0, f62_arg1 )
	SetGlobalModelValueFalse( "demo.showChooseModeSidebar" )
	return f62_local0
end
CoD.DemoUtility.HandleDemoKeyboardComplete = function ( f63_arg0, f63_arg1 )
	if f63_arg0.keyboardName ~= nil then
		local f63_local0 = Engine[0x8DF2E5447F384B9]()
		if f63_local0.demo.keyboardModeName:get() == f63_arg0.keyboardName then
			f63_local0 = f63_arg0.Text
			local f63_local1 = f63_local0
			f63_local0 = f63_local0.setText
			local f63_local2 = Engine[0x8DF2E5447F384B9]()
			f63_local0( f63_local1, f63_local2.demo.keyboardText:get() )
		end
	end
end
CoD.DemoUtility.OpenDemoKeyboard = function ( f64_arg0, f64_arg1, f64_arg2, f64_arg3, f64_arg4 )
	if f64_arg4 and f64_arg4 ~= "" then
		Engine[0x7C75E608EA39B5C]( f64_arg2, "demo_keyboard " .. f64_arg3 .. " " .. f64_arg4 )
	else
		Engine[0x7C75E608EA39B5C]( f64_arg2, "demo_keyboard " .. f64_arg3 )
	end
	f64_arg1.keyboardName = f64_arg3
end
CoD.DemoUtility.OpenDemoSaveKeyboard = function ( f65_arg0, f65_arg1, f65_arg2, f65_arg3 )
	local f65_local0 = nil
	local f65_local1 = CoD.FileshareUtility.GetCurrentCategory()
	if f65_local1 == "clip_private" then
		if f65_arg3 == "name" then
			f65_local0 = "clipName"
		elseif f65_arg3 == "desc" then
			f65_local0 = "clipDesc"
		end
	elseif f65_local1 == "screenshot_private" then
		if f65_arg3 == "name" then
			f65_local0 = "screenshotName"
		elseif f65_arg3 == "desc" then
			f65_local0 = "screenshotDesc"
		end
	end
	if not f65_local0 then
		return 
	else
		CoD.DemoUtility.OpenDemoKeyboard( f65_arg0, f65_arg1, f65_arg2, f65_local0, "" )
	end
end
CoD.DemoUtility.SaveFileProperty = function ( f66_arg0, f66_arg1 )
	assert( f66_arg0.TextBox )
	Engine[0x5A2762E4E4589D9]( f66_arg0.TextBox:getText(), f66_arg1 )
end
CoD.DemoUtility.UploadClip_GoBack = function ( f67_arg0, f67_arg1, f67_arg2, f67_arg3 )
	local f67_local0 = GoBack( f67_arg0, f67_arg2 )
	ClearMenuSavedState( f67_arg0 )
	if f67_local0.menuName == "TimelineEditor" then
		Engine[0x7C75E608EA39B5C]( f67_arg2, "setupThumbnailsForManageSegments" )
	else
		ResetThumbnailViewer( f67_arg2 )
	end
	if Engine[0xE27188849954EC8]() == false and f67_local0.menuName == "EndDemoPopup" then
		GoBack( f67_local0, f67_arg2 )
	end
end
CoD.DemoUtility.UpdateNumHighlightReelMomentsElementColor = function ( f68_arg0, f68_arg1 )
	local f68_local0 = CoD.DemoUtility.GetNumHighlightReelMomentsModel()
	local f68_local1 = 0
	if f68_local0 then
		f68_local1 = Engine[0x614D394F6F9A18D]( f68_local0 )
	end
	if f68_local1 <= 0 then
		f68_arg0:setRGB( ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b )
	else
		f68_arg0:setRGB( 1, 1, 1 )
	end
end
CoD.DemoUtility.DemoCancelHighlightReelCreation = function ( f69_arg0, f69_arg1, f69_arg2, f69_arg3, f69_arg4 )
	Engine[0x7C75E608EA39B5C]( f69_arg2, "demo_cancelhighlightreelcreation" )
end
CoD.DemoUtility.OpenChooseModeSidebar = function ( f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4 )
	SetGlobalModelValueTrue( "demo.showChooseModeSidebar" )
	OpenPopup( f70_arg0, "ChooseModeSidebar", f70_arg2 )
end
CoD.DemoUtility.OpenDemoOverlay = function ( f71_arg0, f71_arg1, f71_arg2, f71_arg3, f71_arg4 )
	CoD.OverlayUtility.CreateOverlay( f71_arg2, f71_arg4:getParent(), f71_arg3 )
end
CoD.DemoUtility.ShouldStartAutoDollyCamera = function ( f72_arg0 )
	if not IsDemoContextDirectorMode() then
		return false
	elseif not Engine[0x3B799DC771E1BC2]( f72_arg0, 0x40A39D4129C3E15 ) then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueGreaterThan( "demo.highlightedDollyCamMarker", -1 ) then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueTrue( "demo.isRecordingDollyCameraPath" ) then
		return false
	else
		return true
	end
end
CoD.DemoUtility.ShouldStopAutoDollyCamera = function ( f73_arg0 )
	if not IsDemoContextDirectorMode() then
		return false
	elseif not Engine[0x3B799DC771E1BC2]( f73_arg0, 0x40A39D4129C3E15 ) then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue( "demo.isRecordingDollyCameraPath" ) then
		return false
	else
		return true
	end
end
CoD.DemoUtility.RunPauseCommandIfNotPlayerPause = function ( f74_arg0 )
	if not CoD.DemoUtility.GetPlayerPauseModelValue() then
		Engine[0xB81A5136C5503E4]( f74_arg0, "demo_pause" )
	end
end
CoD.DemoUtility.InitPlayerPauseModel = function ()
	local f75_local0 = Engine[0x83C9B5DE1D9371]
	local f75_local1 = Engine[0xA798E4552F5E872]
	local f75_local2 = Engine[0x8DF2E5447F384B9]()
	f75_local0( f75_local1( f75_local2.demo, "isPlayerPause" ), false )
end
CoD.DemoUtility.SetPlayerPauseModelValue = function ( f76_arg0 )
	local f76_local0 = Engine[0xA798E4552F5E872]
	local f76_local1 = Engine[0x8DF2E5447F384B9]()
	f76_local0 = f76_local0( f76_local1.demo, "isPlayerPause" )
	f76_local0:set( f76_arg0 )
end
CoD.DemoUtility.GetPlayerPauseModelValue = function ()
	local f77_local0 = Engine[0xA798E4552F5E872]
	local f77_local1 = Engine[0x8DF2E5447F384B9]()
	f77_local0 = f77_local0( f77_local1.demo, "isPlayerPause" )
	return f77_local0:get()
end
CoD.DemoUtility.TogglePlayerPauseModelValue = function ()
	if not CoD.isPC then
		return 
	else
		CoD.DemoUtility.SetPlayerPauseModelValue( not CoD.DemoUtility.GetPlayerPauseModelValue() )
	end
end
CoD.DemoUtility.GiveFocusToDemoEmptyFocusableOnPC = function ( f79_arg0, f79_arg1 )
	if CoD.isPC and f79_arg0.T7HudMenuGameMode and f79_arg0.T7HudMenuGameMode.Demo and f79_arg0.T7HudMenuGameMode.Demo.emptyFocusableNoCursorUpdate then
		if f79_arg0.T7HudMenuGameMode:getAlpha() < 1 then
			f79_arg0.T7HudMenuGameMode:setAlpha( 1 )
		end
		local f79_local0 = f79_arg0.T7HudMenuGameMode.Demo
		SetFocusToElement( f79_local0, f79_local0.emptyFocusableNoCursorUpdate.id, f79_arg1 )
	end
end
CoD.DemoUtility.SubscribeDemoToScoreboardVisibility = function ( f80_arg0, f80_arg1, f80_arg2, f80_arg3 )
	local f80_local0 = f80_arg0
	local f80_local1 = f80_arg0.subscribeToModel
	local f80_local2 = Engine[0x4DF5CFBC1771947]( f80_arg3 )
	f80_local1( f80_local0, f80_local2["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function ( f81_arg0 )
		if f81_arg0:get() == 0 then
			SetFocusToElement( f80_arg0, f80_arg1.id, f80_arg3 )
		end
	end, false )
end
CoD.DemoUtility.TriangleButtonAction = function ( f82_arg0, f82_arg1, f82_arg2, f82_arg3 )
	local f82_local0 = IsDemoClipPreviewRunning()
	local f82_local1 = IsDemoCreatingHighlightReel()
	local f82_local2 = IsDemoCapturingScreenshot()
	if IsDemoContextBasicOrHighlightReelMode() and not f82_local0 and not f82_local1 and not f82_local2 then
		CoD.DemoUtility.UpdateDemoCameraMode( f82_arg0, f82_arg1, f82_arg2, "cycle", f82_arg3 )
	elseif not f82_local0 and not f82_local1 and not f82_local2 and IsDemoContextDirectorMode() and IsEditingDollyCameraMarker( f82_arg2 ) and not IsRepositioningDollyCameraMarker( f82_arg2 ) then
		CoD.DemoUtility.RepositionDollyCamMarker( f82_arg0, f82_arg1, f82_arg2, Engine[0x5BF9DEAE9B81079](), f82_arg3 )
	elseif not f82_local0 and not f82_local1 and not f82_local2 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f82_arg2 ) and not IsRepositioningLightmanMarker( f82_arg2 ) then
		CoD.DemoUtility.RepositionLightmanMarker( f82_arg0, f82_arg1, f82_arg2, Engine[0x5BF9DEAE9B81079](), f82_arg3 )
	end
end
CoD.DemoUtility.CircleButtonAction = function ( f83_arg0, f83_arg1, f83_arg2, f83_arg3 )
	local f83_local0 = IsDemoClipPreviewRunning()
	local f83_local1 = IsDemoCreatingHighlightReel()
	local f83_local2 = IsEditingDollyCameraMarker( f83_arg2 )
	local f83_local3 = IsEditingLightmanMarker( f83_arg2 )
	local f83_local4 = IsDemoCapturingScreenshot()
	local f83_local5 = IsDemoContextLighterMode()
	local f83_local6 = IsRepositioningDollyCameraMarker( f83_arg2 )
	local f83_local7 = IsRepositioningLightmanMarker( f83_arg2 )
	if CoD.ModelUtility.IsGlobalModelValueTrue( "demo.networkProfiling" ) then
		
	elseif f83_local0 then
		CoD.DemoUtility.DemoCancelPreview( f83_arg0, f83_arg1, f83_arg2, nil, f83_arg3 )
	elseif f83_local1 then
		CoD.DemoUtility.DemoCancelHighlightReelCreation( f83_arg0, f83_arg1, f83_arg2, nil, f83_arg3 )
	elseif not IsDemoContextPlaybackMode() and not f83_local2 and not f83_local3 and not f83_local0 and not f83_local1 and not f83_local4 then
		CoD.DemoUtility.OpenChooseModeSidebar( f83_arg0, f83_arg1, f83_arg2, nil, f83_arg3 )
	elseif IsDemoContextDirectorMode() and f83_local2 and f83_local6 and not f83_local0 and not f83_local4 then
		CoD.DemoUtility.DemoCancelPlaceDollyCameraMarker( f83_arg0, f83_arg1, f83_arg2, nil, f83_arg3 )
	elseif f83_local5 and f83_local3 and f83_local7 and not f83_local0 and not f83_local4 then
		CoD.DemoUtility.DemoCancelPlaceLightmanMarker( f83_arg0, f83_arg1, f83_arg2, nil, f83_arg3 )
	elseif f83_local5 and f83_local3 and not f83_local6 and not f83_local0 and not f83_local4 then
		if f83_local7 then
			CoD.DemoUtility.DemoCancelPlaceDollyCameraMarker( f83_arg0, f83_arg1, f83_arg2, nil, f83_arg3 )
		else
			CoD.DemoUtility.UpdateLightmanLightColor( f83_arg0, f83_arg1, f83_arg2, nil, f83_arg3 )
		end
	end
end
CoD.DemoUtility.SquareButtonAction = function ( f84_arg0, f84_arg1, f84_arg2, f84_arg3 )
	local f84_local0 = IsDemoClipPreviewRunning()
	local f84_local1 = IsDemoCreatingHighlightReel()
	local f84_local2 = IsEditingDollyCameraMarker( f84_arg2 )
	local f84_local3 = IsEditingLightmanMarker( f84_arg2 )
	local f84_local4 = IsDemoCapturingScreenshot()
	if CoD.ModelUtility.IsGlobalModelValueTrue( "demo.networkProfiling" ) then
		
	elseif not f84_local0 and not f84_local1 and not f84_local2 and not f84_local3 and not IsDemoRestrictedBasicMode() and not IsDemoContextPlaybackMode() and not IsDemoContextHighlightReelMode() then
		CoD.DemoUtility.StartStopRecordClip( f84_arg0, f84_arg1, f84_arg2, nil, f84_arg3 )
	elseif not f84_local0 and not f84_local1 and not f84_local4 and IsDemoContextDirectorMode() and f84_local2 and not IsRepositioningDollyCameraMarker( f84_arg2 ) then
		CoD.DemoUtility.UpdateDollyCameraTimeScaleMode( f84_arg0, f84_arg1, f84_arg2, "cycle", f84_arg3 )
	elseif not f84_local0 and not f84_local1 and not f84_local4 and IsDemoContextLighterMode() and f84_local3 and not IsRepositioningLightmanMarker( f84_arg2 ) then
		CoD.DemoUtility.UpdateLightmanLightMode( f84_arg0, f84_arg1, f84_arg2, "cycle", f84_arg3 )
	end
end
CoD.DemoUtility.SquareButtonHoldAction = function ( f85_arg0, f85_arg1, f85_arg2, f85_arg3 )
	if not IsDemoClipPreviewRunning() and not IsDemoCreatingHighlightReel() and not IsEditingDollyCameraMarker( f85_arg2 ) and not IsEditingLightmanMarker( f85_arg2 ) and not IsDemoRestrictedBasicMode() then
		CoD.DemoUtility.TakeScreenshot( f85_arg0, f85_arg1, f85_arg2, nil, f85_arg3 )
	end
end
CoD.DemoUtility.CrossButtonAction = function ( f86_arg0, f86_arg1, f86_arg2, f86_arg3 )
	local f86_local0 = IsDemoClipPreviewRunning()
	local f86_local1 = IsDemoCreatingHighlightReel()
	local f86_local2 = IsDemoCapturingScreenshot()
	local f86_local3 = IsEditingDollyCameraMarker( f86_arg2 )
	local f86_local4 = IsEditingLightmanMarker( f86_arg2 )
	if not f86_local0 and not f86_local1 and not f86_local2 and not f86_local3 and not f86_local4 then
		CoD.DemoUtility.RunPauseCommand( f86_arg0, f86_arg1, f86_arg2, nil, f86_arg3 )
	elseif not f86_local0 and not f86_local1 and not f86_local2 and IsDemoContextDirectorMode() and f86_local3 and not IsRepositioningDollyCameraMarker( f86_arg2 ) then
		CoD.DemoUtility.RemoveCurrentDollyCamMarker( f86_arg0, f86_arg1, f86_arg2, nil, f86_arg3 )
	elseif not f86_local0 and not f86_local1 and not f86_local2 and IsDemoContextLighterMode() and f86_local4 and not IsRepositioningLightmanMarker( f86_arg2 ) then
		CoD.DemoUtility.RemoveCurrentLightmanMarker( f86_arg0, f86_arg1, f86_arg2, nil, f86_arg3 )
	end
end
CoD.DemoUtility.CrossButtonHoldAction = function ( f87_arg0, f87_arg1, f87_arg2, f87_arg3 )
	if not IsDemoClipPreviewRunning() and not IsDemoCreatingHighlightReel() then
		if IsDemoContextDirectorMode() then
			if IsEditingDollyCameraMarker( f87_arg2 ) then
				if not IsRepositioningDollyCameraMarker( f87_arg2 ) then
					CoD.DemoUtility.OpenDemoOverlay( f87_arg0, f87_arg1, f87_arg2, "DemoDeleteAllDollyCameraMarkers", f87_arg3 )
				end
			else
				CoD.DemoUtility.ToggleDollyCameraMode( f87_arg0, f87_arg1, f87_arg2, nil, f87_arg3 )
			end
		elseif IsDemoContextLighterMode() and IsEditingLightmanMarker( f87_arg2 ) and not IsRepositioningLightmanMarker( f87_arg2 ) then
			CoD.DemoUtility.OpenDemoOverlay( f87_arg0, f87_arg1, f87_arg2, "DemoDeleteAllLightmanMarkers", f87_arg3 )
		end
	end
end
CoD.DemoUtility.LeftBumperAction = function ( f88_arg0, f88_arg1, f88_arg2, f88_arg3 )
	local f88_local0 = IsDemoCreatingHighlightReel()
	local f88_local1 = IsDemoCapturingScreenshot()
	local f88_local2 = IsDemoClipPreviewRunning()
	if not IsDemoClipPlaying() and not CoD.ModelUtility.IsGlobalModelValueEqualToEnum( "demo.cameraMode", Enum[0xF432DF404208022][0x3B1995A6E46FA28] ) and IsDemoContextBasicOrHighlightReelMode() and not f88_local0 and not f88_local1 then
		CoD.DemoUtility.DemoSwitchPlayer( f88_arg0, f88_arg1, f88_arg2, "back", f88_arg3 )
	elseif not f88_local2 and not f88_local0 and not f88_local1 and IsDemoContextDirectorMode() and IsEditingDollyCameraMarker( f88_arg2 ) and not IsRepositioningDollyCameraMarker( f88_arg2 ) then
		CoD.DemoUtility.DemoTimeJumpDollyCameraMarker( f88_arg0, f88_arg1, f88_arg2, "back", f88_arg3 )
	elseif not f88_local2 and not f88_local0 and not f88_local1 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f88_arg2 ) and not IsRepositioningLightmanMarker( f88_arg2 ) then
		CoD.DemoUtility.CycleLightmanMarker( f88_arg0, f88_arg1, f88_arg2, "back", f88_arg3 )
	end
end
CoD.DemoUtility.RightBumperAction = function ( f89_arg0, f89_arg1, f89_arg2, f89_arg3 )
	local f89_local0 = IsDemoCreatingHighlightReel()
	local f89_local1 = IsDemoCapturingScreenshot()
	if not IsDemoClipPlaying() and not CoD.ModelUtility.IsGlobalModelValueEqualToEnum( "demo.cameraMode", Enum[0xF432DF404208022][0x3B1995A6E46FA28] ) and IsDemoContextBasicOrHighlightReelMode() and not f89_local0 and not f89_local1 then
		CoD.DemoUtility.DemoSwitchPlayer( f89_arg0, f89_arg1, f89_arg2, "forward", f89_arg3 )
	elseif not IsDemoClipPreviewRunning() and not f89_local0 and not f89_local1 and IsDemoContextDirectorMode() and IsEditingDollyCameraMarker( f89_arg2 ) and not IsRepositioningDollyCameraMarker( f89_arg2 ) then
		CoD.DemoUtility.DemoTimeJumpDollyCameraMarker( f89_arg0, f89_arg1, f89_arg2, "forward", f89_arg3 )
	elseif not IsDemoClipPreviewRunning() and not f89_local0 and not f89_local1 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f89_arg2 ) and not IsRepositioningLightmanMarker( f89_arg2 ) then
		CoD.DemoUtility.CycleLightmanMarker( f89_arg0, f89_arg1, f89_arg2, "forward", f89_arg3 )
	end
end
CoD.DemoUtility.LastLeftTriggerAmount = -1
CoD.DemoUtility.LastRightTriggerAmount = -1
CoD.DemoUtility.LeftTriggerAction = function ( f90_arg0, f90_arg1, f90_arg2, f90_arg3 )
	if not IsDemoClipPreviewRunning() and not IsDemoCreatingHighlightReel() and not CoD.ModelUtility.IsGlobalModelValueTrue( "demo.isCompleted" ) and not IsDemoCapturingScreenshot() then
		local f90_local0 = Engine[0x4DF5CFBC1771947]( f90_arg2 )
		f90_local0 = f90_local0.LeftTrigger
		CoD.DemoUtility.UpdateDemoTimeScaleForTrigger( f90_arg2, f90_local0, 1, 0.1 )
		if CoD.DemoUtility.LastLeftTriggerAmount < 0 and CoD.DemoUtility.LastRightTriggerAmount < 0 then
			CoD.DemoUtility.UnpauseIfPaused( f90_arg2 )
		end
		if f90_local0.amount:get() ~= 0 then
			CoD.DemoUtility.LastLeftTriggerAmount = f90_local0.amount:get()
		else
			CoD.DemoUtility.LastLeftTriggerAmount = -1
		end
	end
end
CoD.DemoUtility.RightTriggerAction = function ( f91_arg0, f91_arg1, f91_arg2, f91_arg3 )
	if not IsDemoClipPreviewRunning() and not IsDemoCreatingHighlightReel() and not CoD.ModelUtility.IsGlobalModelValueTrue( "demo.isCompleted" ) and not IsDemoCapturingScreenshot() then
		local f91_local0 = Engine[0x4DF5CFBC1771947]( f91_arg2 )
		f91_local0 = f91_local0.RightTrigger
		CoD.DemoUtility.UpdateDemoTimeScaleForTrigger( f91_arg2, f91_local0, 1, 6 )
		if CoD.DemoUtility.LastLeftTriggerAmount < 0 and CoD.DemoUtility.LastRightTriggerAmount < 0 then
			CoD.DemoUtility.UnpauseIfPaused( f91_arg2 )
		end
		if f91_local0.amount:get() ~= 0 then
			CoD.DemoUtility.LastRightTriggerAmount = f91_local0.amount:get()
		else
			CoD.DemoUtility.LastRightTriggerAmount = -1
		end
	end
end
CoD.DemoUtility.LeftStickAction = function ( f92_arg0, f92_arg1, f92_arg2, f92_arg3 )
	if not IsDemoClipPreviewRunning() and not IsDemoCreatingHighlightReel() and not IsDemoCapturingScreenshot() then
		CoD.DemoUtility.DemoToggleDemoHud( f92_arg0, f92_arg1, f92_arg2, nil, f92_arg3 )
	end
end
CoD.DemoUtility.RightStickAction = function ( f93_arg0, f93_arg1, f93_arg2, f93_arg3 )
	local f93_local0 = IsDemoContextDirectorMode()
	local f93_local1 = IsDemoClipPreviewRunning()
	local f93_local2 = IsDemoCapturingScreenshot()
	local f93_local3 = IsEditingDollyCameraMarker( f93_arg2 )
	local f93_local4 = IsRepositioningDollyCameraMarker( f93_arg2 )
	local f93_local5 = IsFreeCameraLockedOnEntity( f93_arg2 )
	local f93_local6 = IsEditingLightmanMarker( f93_arg2 )
	local f93_local7 = IsRepositioningLightmanMarker( f93_arg2 )
	if f93_local0 and CoD.DemoUtility.ShouldStartAutoDollyCamera( f93_arg2 ) and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoStartAutoDollyCamera( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif f93_local0 and CoD.DemoUtility.ShouldStopAutoDollyCamera( f93_arg2 ) and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoStopAutoDollyCamera( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif f93_local0 and ShouldAddDollyCameraMarker( f93_arg2 ) and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoAddDollyCameraMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif f93_local0 and ShouldEditDollyCameraMarker( f93_arg2 ) and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoEditDollyCameraMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif f93_local0 and f93_local3 and not f93_local4 and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoExitEditDollyCameraMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif f93_local0 and f93_local3 and f93_local4 and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoPlaceDollyCameraMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif IsDemoContextObjectLinkMode() and CanFreeCameraLockOnEntity( f93_arg2 ) and not f93_local5 and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoFreeCameraLockOnObject( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif IsDemoContextObjectLinkMode() and f93_local5 and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoFreeCameraUnlockObject( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif IsDemoContextLighterMode() and ShouldAddLightmanMarker( f93_arg2 ) and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoAddLightmanMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif IsDemoContextLighterMode() and ShouldEditLightmanMarker( f93_arg2 ) and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoEditLightmanMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif IsDemoContextLighterMode() and f93_local6 and not f93_local7 and not f93_local1 and not IsInLightmanColorPicker( f93_arg2 ) and not f93_local2 then
		CoD.DemoUtility.DemoExitEditLightmanMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	elseif IsDemoContextLighterMode() and f93_local6 and f93_local7 and not f93_local1 and not f93_local2 then
		CoD.DemoUtility.DemoPlaceLightmanMarker( f93_arg0, f93_arg1, f93_arg2, nil, f93_arg3 )
	end
end
CoD.DemoUtility.DPadLeftAction = function ( f94_arg0, f94_arg1, f94_arg2, f94_arg3 )
	local f94_local0 = IsDemoClipPreviewRunning()
	local f94_local1 = IsDemoCreatingHighlightReel()
	local f94_local2 = IsDemoCapturingScreenshot()
	if not f94_local0 and not f94_local1 and not f94_local2 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f94_arg2 ) and not IsRepositioningLightmanMarker( f94_arg2 ) then
		CoD.DemoUtility.UpdateLightmanIntensity( f94_arg0, f94_arg1, f94_arg2, "-0.5", f94_arg3 )
	elseif not f94_local0 and not f94_local1 and not f94_local2 then
		CoD.DemoUtility.DemoTimeJump( f94_arg0, f94_arg1, f94_arg2, "back", f94_arg3 )
	end
end
CoD.DemoUtility.DPadRightAction = function ( f95_arg0, f95_arg1, f95_arg2, f95_arg3 )
	local f95_local0 = IsDemoClipPreviewRunning()
	local f95_local1 = IsDemoCreatingHighlightReel()
	local f95_local2 = IsDemoCapturingScreenshot()
	if not f95_local0 and not f95_local1 and not f95_local2 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f95_arg2 ) and not IsRepositioningLightmanMarker( f95_arg2 ) then
		CoD.DemoUtility.UpdateLightmanIntensity( f95_arg0, f95_arg1, f95_arg2, "0.5", f95_arg3 )
	elseif not f95_local0 and not f95_local1 and not f95_local2 and not CoD.DemoUtility.IsFastForwardingDisabled() then
		CoD.DemoUtility.DemoTimeJump( f95_arg0, f95_arg1, f95_arg2, "forward", f95_arg3 )
	end
end
CoD.DemoUtility.DPadUpAction = function ( f96_arg0, f96_arg1, f96_arg2, f96_arg3 )
	local f96_local0 = IsDemoClipPreviewRunning()
	local f96_local1 = IsDemoCreatingHighlightReel()
	local f96_local2 = IsDemoCapturingScreenshot()
	local f96_local3 = IsDemoContextDirectorMode()
	local f96_local4 = IsEditingDollyCameraMarker( f96_arg2 )
	if not f96_local0 and not f96_local1 and not f96_local2 and f96_local3 and not f96_local4 then
		CoD.DemoUtility.DemoTimeJumpDollyCameraMarker( f96_arg0, f96_arg1, f96_arg2, "forward", f96_arg3 )
	else
		if not f96_local0 and not f96_local1 and not f96_local2 and f96_local3 and f96_local4 and not IsRepositioningDollyCameraMarker( f96_arg2 ) then
			local f96_local5 = Engine[0x8DF2E5447F384B9]()
			if f96_local5.demo.currentDollyCamMarkerTimeScaleMode:get() ~= Enum[0x253C21AFC0AAE25][0xB995D2A247B7393] then
				CoD.DemoUtility.UpdateDollyCameraTimeScale( f96_arg0, f96_arg1, f96_arg2, "0.1", f96_arg3 )
			elseif not f96_local0 and not f96_local1 and not f96_local2 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f96_arg2 ) and not IsRepositioningLightmanMarker( f96_arg2 ) then
				CoD.DemoUtility.UpdateLightmanRange( f96_arg0, f96_arg1, f96_arg2, "0.5", f96_arg3 )
			end
		end
		elseif not f96_local0 and not f96_local1 and not f96_local2 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f96_arg2 ) and not IsRepositioningLightmanMarker( f96_arg2 ) then
			CoD.DemoUtility.UpdateLightmanRange( f96_arg0, f96_arg1, f96_arg2, "0.5", f96_arg3 )
	end
end
CoD.DemoUtility.DPadDownAction = function ( f97_arg0, f97_arg1, f97_arg2, f97_arg3 )
	local f97_local0 = IsDemoClipPreviewRunning()
	local f97_local1 = IsDemoCreatingHighlightReel()
	local f97_local2 = IsDemoCapturingScreenshot()
	local f97_local3 = IsDemoContextDirectorMode()
	local f97_local4 = IsEditingDollyCameraMarker( f97_arg2 )
	local f97_local5 = Engine[0x8DF2E5447F384B9]()
	f97_local5 = f97_local5.demo.currentDollyCamMarkerTimeScaleMode:get() == Enum[0x253C21AFC0AAE25][0xB995D2A247B7393]
	if not f97_local0 and not f97_local1 and not f97_local2 and f97_local3 and not f97_local4 then
		CoD.DemoUtility.DemoTimeJumpDollyCameraMarker( f97_arg0, f97_arg1, f97_arg2, "back", f97_arg3 )
	elseif not f97_local0 and not f97_local1 and not f97_local2 and f97_local3 and f97_local4 and not IsRepositioningDollyCameraMarker( f97_arg2 ) and not f97_local5 then
		CoD.DemoUtility.UpdateDollyCameraTimeScale( f97_arg0, f97_arg1, f97_arg2, "-0.1", f97_arg3 )
	elseif not f97_local0 and not f97_local1 and not f97_local2 and IsDemoContextLighterMode() and IsEditingLightmanMarker( f97_arg2 ) and not IsRepositioningLightmanMarker( f97_arg2 ) then
		CoD.DemoUtility.UpdateLightmanRange( f97_arg0, f97_arg1, f97_arg2, "-0.5", f97_arg3 )
	end
end
CoD.DemoUtility.OpenSavePopup = function ( f98_arg0, f98_arg1 )
	local f98_local0 = nil
	local f98_local1 = f98_arg1.menuName
	local f98_local2 = f98_arg1.controller
	if f98_local1 == "demo_save_clip" then
		if CoD.isPC then
			OpenPopup( f98_arg0, "DemoSaveSegmentPopup", f98_local2 )
		else
			f98_local0 = CoD.OverlayUtility.CreateOverlay( f98_local2, f98_arg0, "DemoSaveClipPopup" )
		end
	else
		Engine[0xB81A5136C5503E4]( f98_local2, "setupThumbnailForFileshareSave screenshot" )
		CoD.FileshareUtility.OpenPrivateUploadPopup( f98_arg0, f98_local2, "screenshot_private", function ( f99_arg0 )
			Engine[0x45862A4598861C]( f99_arg0, false, 0 )
		end )
	end
	if f98_local0 then
		f98_local0:registerEventHandler( "demo_close_save_popup", function ( element, event, f100_arg2, f100_arg3 )
			GoBack( element, f100_arg2 )
		end )
	end
end
CoD.DemoUtility.OpenManageSegments = function ( f101_arg0, f101_arg1 )
	OpenPopup( f101_arg0, "TimelineEditor", f101_arg1.controller )
end
CoD.DemoUtility.StartMenuUploadClip = function ( f102_arg0, f102_arg1, f102_arg2, f102_arg3, f102_arg4 )
	local f102_local0 = Engine[0xF3230EBDE32BFB2]()
	if f102_local0 < 100 then
		LuaUtils.ShowMessageDialog( f102_arg2, Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B], Engine[0xF9F1239CFD921FE]( 0x166EE50B1458BCD, math.floor( f102_local0 ) ), Engine[0xF9F1239CFD921FE]( 0xA009F37E1567367 ) )
		return 
	else
		Engine[0xB81A5136C5503E4]( f102_arg2, "demo_updatesavepopupuimodels clip" )
		Engine[0xB81A5136C5503E4]( f102_arg2, "setupThumbnailForFileshareSave clip" )
		CoD.FileshareUtility.OpenPrivateUploadPopup( f102_arg0, f102_arg2, "clip_private", function ( f103_arg0 )
			Engine[0xB18D7E52686EAEE]( f103_arg0, 0 )
		end )
	end
end
CoD.DemoUtility.StartMenuOpenCustomizeHighlightReel = function ( f104_arg0, f104_arg1, f104_arg2, f104_arg3, f104_arg4 )
	CoD.OverlayUtility.CreateOverlay( f104_arg2, f104_arg0, "DemoCustomizeHighlightReelPopup" )
end
CoD.DemoUtility.StartMenuJumpToStart = function ( f105_arg0, f105_arg1, f105_arg2, f105_arg3, f105_arg4 )
	if CoD.GameEndScoreUtility.IsInTransition( f105_arg2 ) then
		CoD.GameEndScoreUtility.ClearTransitionModels( f105_arg2 )
	end
	Engine[0x7C75E608EA39B5C]( f105_arg2, "demo_jumptostart" )
	StartMenuGoBack( f105_arg4, f105_arg2 )
end
CoD.DemoUtility.StartMenuEndDemo = function ( f106_arg0, f106_arg1, f106_arg2, f106_arg3, f106_arg4 )
	local f106_local0 = f106_arg0
	while f106_local0 and not f106_local0.openMenu do
		f106_local0 = f106_local0:getParent()
	end
	if Engine[0xE27188849954EC8]() then
		CoD.OverlayUtility.CreateOverlay( f106_arg2, f106_local0, "EndDemoPopup" )
	else
		CoD.DemoUtility.EndDemo( f106_arg2 )
	end
end
CoD.DemoUtility.ProcessSettingsChange = function ( f107_arg0 )
	if Engine[0x3B799DC771E1BC2]( f107_arg0, 0xBC470BF66BA3C46 ) then
		Engine[0xB81A5136C5503E4]( f107_arg0, "demo_hidegamehud 0" )
	else
		Engine[0xB81A5136C5503E4]( f107_arg0, "demo_hidegamehud 1" )
	end
end
CoD.DemoUtility.EndDemo = function ( f108_arg0 )
	if not Engine[0xEA2BE00F49480D]( Enum[0xBF54BE1BB3D618B][0xA1647599284110] ) then
		Engine[0x17DCA54F4444D11]()
		Engine[0xD4AB56BD02E8D41]()
		Engine[0x7C75E608EA39B5C]( f108_arg0, "disconnect" )
	else
		Engine[0x7C75E608EA39B5C]( f108_arg0, "xpartystopdemo" )
	end
end
CoD.DemoUtility.LastActivatedInformationScreen = 0
CoD.DemoUtility.AnimateToAlpha = function ( f109_arg0, f109_arg1, f109_arg2 )
	f109_arg0:beginAnimation( "keyframe", f109_arg1, false, false, CoD.TweenType.Linear )
	f109_arg0:setAlpha( f109_arg2 )
end
CoD.DemoUtility.ActivateInformationScreen = function ( f110_arg0, f110_arg1 )
	CoD.DemoUtility.LastActivatedInformationScreen = f110_arg1.informationScreenType
	if LUI.roots.UIRootFull.demoInformationScreenBlackBackground == nil then
		return 
	elseif f110_arg1 == nil then
		return 
	end
	local f110_local0 = f110_arg1.targetAlpha or 0
	if f110_arg1.informationScreenType == Enum[0x8FCB311B4EA52F5][0xF888A2954A096C7] then
		return 
	elseif f110_arg1.informationScreenType == Enum[0x8FCB311B4EA52F5][0xBE38590EC5B7996] or f110_arg1.informationScreenType == Enum[0x8FCB311B4EA52F5][0x30934197B020D7] then
		CoD.DemoUtility.AnimateToAlpha( LUI.roots.UIRootFull.demoInformationScreenBlackBackground, f110_arg1.animationTime, f110_local0 )
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setText( Engine[0xF9F1239CFD921FE]( 0xBBD6582279C398D ) )
		CoD.DemoUtility.AnimateToAlpha( LUI.roots.UIRootFull.demoInformationScreenInformationText, f110_arg1.animationTime * 0.8, f110_local0 )
		CoD.DemoUtility.AnimateToAlpha( LUI.roots.UIRootFull.demoInformationScreenSpinner, f110_arg1.animationTime * 0.8, f110_local0 )
	end
	if f110_arg1.informationScreenType == Enum[0x8FCB311B4EA52F5][0x8EAED6859EFF4C6] then
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setText( "" )
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setAlpha( 0 )
		LUI.roots.UIRootFull.demoInformationScreenSpinner:setAlpha( 0 )
		LUI.roots.UIRootFull.demoInformationScreenBlackBackground:setAlpha( 1 )
		CoD.DemoUtility.AnimateToAlpha( LUI.roots.UIRootFull.demoInformationScreenBlackBackground, f110_arg1.animationTime, f110_local0 )
	end
	if f110_arg1.informationScreenType == Enum[0x8FCB311B4EA52F5][0xDA90BCE024C68A5] then
		CoD.DemoUtility.AnimateToAlpha( LUI.roots.UIRootFull.demoInformationScreenBlackBackground, f110_arg1.animationTime, 0 )
		CoD.DemoUtility.AnimateToAlpha( LUI.roots.UIRootFull.demoInformationScreenInformationText, f110_arg1.animationTime, f110_local0 )
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setText( Engine[0xF9F1239CFD921FE]( 0xD8B5675C766DBBB ) )
		CoD.DemoUtility.AnimateToAlpha( LUI.roots.UIRootFull.demoInformationScreenSpinner, f110_arg1.animationTime, f110_local0 )
	end
end
CoD.DemoUtility.AddInformationScreen = function ( f111_arg0 )
	if LUI.roots.UIRootFull.demoInformationScreenContainer then
		return 
	else
		local self = LUI.UIContainer.new()
		self:setPriority( 100 )
		local f111_local1 = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
		f111_local1:setRGB( 0, 0, 0 )
		f111_local1:setAlpha( 0 )
		LUI.roots.UIRootFull.demoInformationScreenBlackBackground = f111_local1
		self:addElement( f111_local1 )
		local f111_local2 = LUI.UIText.new( 0, 1, 0, 0, 0.5, 0.5, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2 )
		f111_local2:setFont( CoD.fonts.Condensed )
		f111_local2:setAlignment( LUI.Alignment.Center )
		f111_local2:setAlpha( 0 )
		LUI.roots.UIRootFull.demoInformationScreenInformationText = f111_local2
		self:addElement( f111_local2 )
		local f111_local3 = 60
		local f111_local4 = LUI.UIImage.new( 0.5, 0.5, -f111_local3 / 2, f111_local3 / 2, 0.5, 0.5, CoD.textSize.Condensed, CoD.textSize.Condensed + f111_local3 )
		f111_local4:setAlpha( 0 )
		f111_local4:setMaterial( RegisterMaterial( 0x1F04D6E9BDEC22D ) )
		f111_local4:setShaderVector( 0, 0, 0, 0, 0 )
		LUI.roots.UIRootFull.demoInformationScreenSpinner = f111_local4
		self:addElement( f111_local4 )
		LUI.roots.UIRootFull:addElement( self )
		LUI.roots.UIRootFull.demoInformationScreenContainer = self
	end
end
CoD.DemoUtility.SetupUIModels = function ( f112_arg0 )
	local f112_local0 = Engine[0x8DF2E5447F384B9]()
	f112_local0 = f112_local0:create( "demo" )
	local f112_local1 = f112_local0:create( "showChooseModeSidebar" )
	f112_local1:set( false )
	f112_local1 = f112_local0:create( "showOptionsSidebar" )
	f112_local1:set( false )
	f112_local1 = f112_local0:create( "showLightmanColorPicker" )
	f112_local1:set( false )
	f112_local1 = f112_local0:create( "numHighlightReelMoments" )
	f112_local1:set( 0 )
	f112_local1 = f112_local0:create( "restrictedBasicMode" )
	f112_local1:set( true )
	f112_local1 = f112_local0:create( "isDefaultCameraMode" )
	f112_local1:set( false )
	f112_local1 = f112_local0:create( "cameraMode" )
	f112_local1:set( Enum[0xF432DF404208022][0x448CED16817146D] )
	if Engine[0x4A884DF5CCCEB2E]() then
		f112_local1 = f112_local0:create( "contextMode" )
		f112_local1:set( Enum[0xAAAF4C9531ECF5E][0x4FDF8441F0D7CD4] )
	elseif Engine[0x7FF6BC9358B7BA5]() then
		f112_local1 = f112_local0:create( "contextMode" )
		f112_local1:set( Enum[0xAAAF4C9531ECF5E][0x699D1F37EAAA1E8] )
	else
		f112_local1 = f112_local0:create( "contextMode" )
		f112_local1:set( Enum[0xAAAF4C9531ECF5E][0x432E29CBD83BEB5] )
	end
	f112_local1 = Engine[0x8DF2E5447F384B9]()
	f112_local1 = f112_local1:create( "DemoSegments" )
	local f112_local2 = f112_local1:create( "refresh" )
	f112_local2:set( 0 )
end
CoD.DemoUtility.RegisterEventHandlers = function ( f113_arg0, f113_arg1 )
	if not Engine[0xA55C3ACD0D2BCF0]() then
		return 
	end
	f113_arg0:registerEventHandler( "open_demo_save_popup", CoD.DemoUtility.OpenSavePopup )
	f113_arg0:registerEventHandler( "open_demo_manage_segments", CoD.DemoUtility.OpenManageSegments )
	f113_arg0:registerEventHandler( "activate_demo_information_screen", CoD.DemoUtility.ActivateInformationScreen )
	CoD.DemoUtility.SetupUIModels( f113_arg1 )
	local f113_local0 = Engine[0x93B19E01B1FD1C7]( f113_arg1 )
	local f113_local1 = CoD.FileshareUtility.IsFileshareReady( f113_arg1 )
	if f113_local1 == 0 or f113_local1 == false or f113_local0 ~= CoD.FileshareUtility.GetCurrentUser() then
		CoD.FileshareUtility.FetchContentForUser( f113_arg1, f113_local0 )
		CoD.FileshareUtility.SetDirty()
	end
end
CoD.DemoUtility.AddHUDWidgets = function ( f114_arg0, f114_arg1 )
	local f114_local0 = Engine[0xA55C3ACD0D2BCF0]()
	local f114_local1 = f114_arg1.controller
	if f114_local0 then
		if f114_arg0 ~= nil and f114_arg0.Demo == nil then
			f114_arg0.Demo = CoD.Demo.new( f114_arg0, f114_local1 )
			f114_arg0.Demo:setLeftRight( true, true, 0, 0 )
			f114_arg0.Demo:setTopBottom( true, true, 0, 0 )
			f114_arg0.Demo:setModel( f114_arg0.buttonModel, f114_local1 )
			f114_arg0.Demo.ignoreCursor = true
			f114_arg0:addElement( f114_arg0.Demo )
			f114_arg0:sendInitializationEvents( f114_local1, f114_arg0.Demo )
			CoD.HUDUtility.AddCustomGainFocusWidget( f114_arg0, f114_arg0.Demo )
			f114_arg0.Demo:processEvent( {
				name = "gain_focus",
				controller = f114_local1
			} )
			LUI.OverrideFunction_CallOriginalSecond( f114_arg0.Demo, "close", function ( element )
				CoD.Menu.UnsubscribeFromControllerSubscriptionsForElement( f114_arg0, element )
			end )
		end
		if Engine[0x7FF6BC9358B7BA5]() then
			CoD.DemoUtility.AddHighlightReelWidget( f114_arg0, f114_local1 )
		end
		CoD.DemoUtility.AddInformationScreen( f114_arg0 )
		if f114_arg1.activateDemoStartScreen then
			if CoD.DemoUtility.LastActivatedInformationScreen ~= Enum[0x8FCB311B4EA52F5][0x30934197B020D7] then
				CoD.DemoUtility.ActivateInformationScreen( f114_arg0, {
					controller = f114_local1,
					informationScreenType = Enum[0x8FCB311B4EA52F5][0xBE38590EC5B7996],
					animationTime = 0,
					targetAlpha = 1
				} )
			end
		elseif f114_arg1.openHighlightStartScreen then
			CoD.DemoUtility.RebuildHighlightReelTimeline( f114_local1 )
			if Engine[0xDCCF490619F1876]() > 0 then
				Engine[0x7C75E608EA39B5C]( f114_local1, "demo_regeneratehighlightreel" )
			else
				LuaUtils.ShowMessageDialog( f114_local1, Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B], Engine[0xF9F1239CFD921FE]( 0x4F1B56A7BD9CDF ), Engine[0xF9F1239CFD921FE]( 0xA009F37E1567367 ) )
				Dvar[0xFF56845FD43D403]:set( true )
			end
		end
		if CoD.isPC then
			CoD.PCUtility.PushStickyElementsBeforeSiblings( f114_arg0, f114_local1 )
		end
	elseif f114_arg0 ~= nil and f114_arg0.Demo ~= nil then
		f114_arg0.Demo:close()
		f114_arg0.Demo = nil
	end
end
CoD.DemoUtility.SetupDemoSegmentModel = function ( f116_arg0 )
	local f116_local0 = ""
	local f116_local1 = ""
	local f116_local2 = ""
	local f116_local3 = 0
	local f116_local4 = 0
	local f116_local5 = true
	local f116_local6 = Engine[0x79618C46565F5A4]()
	local f116_local7 = Engine[0x8DF2E5447F384B9]()
	local f116_local8 = f116_local7.DemoSegments:create( f116_arg0 )
	local f116_local9 = f116_local8:create( "segmentNumber" )
	f116_local9:set( f116_arg0 + 1 )
	if f116_arg0 < f116_local6 then
		f116_local0 = Engine[0x61A661773462085]( f116_arg0, "name" )
		f116_local1 = Engine[0x61A661773462085]( f116_arg0, "durationTimeDisplay" )
		f116_local2 = Engine[0xF9F1239CFD921FE]( 0xCAD56C63DBCAC00 ) .. Engine[0x61A661773462085]( f116_arg0, "transition" )
		if Engine[0x7FF6BC9358B7BA5]() then
			local f116_local10 = tonumber( Engine[0x61A661773462085]( f116_arg0, "score" ) )
			local f116_local11 = tonumber( Engine[0x61A661773462085]( f116_arg0, "stars" ) )
			f116_local3 = f116_local10
			f116_local4 = f116_local11
		end
		f116_local5 = false
	end
	f116_local9 = f116_local8:create( "name" )
	f116_local9:set( f116_local0 )
	f116_local9 = f116_local8:create( "duration" )
	f116_local9:set( f116_local1 )
	f116_local9 = f116_local8:create( "transitionText" )
	f116_local9:set( f116_local2 )
	f116_local9 = f116_local8:create( "stars" )
	f116_local9:set( f116_local3 )
	f116_local9 = f116_local8:create( "score" )
	f116_local9:set( f116_local4 )
	f116_local9 = f116_local8:create( "disabled" )
	f116_local9:set( f116_local5 )
	f116_local9 = f116_local8:create( "selected" )
	f116_local9:set( false )
	return f116_local8
end
CoD.DemoUtility.Timeline_SetSelectedSegmentModel = function ( f117_arg0 )
	f117_arg0.selected:set( true )
end
CoD.DemoUtility.Timeline_GetSelectedSegmentModel = function ()
	local f118_local0 = Engine[0x79618C46565F5A4]()
	local f118_local1 = Engine[0x8DF2E5447F384B9]()
	f118_local1 = f118_local1.DemoSegments
	if f118_local1 then
		for f118_local2 = 1, f118_local0, 1 do
			local f118_local5 = Engine[0x40E824FE270E174]( f118_local1, f118_local2 - 1 )
			if f118_local5 then
				local f118_local6 = f118_local5.selected
				if f118_local6 and f118_local6:get() == true then
					return f118_local5
				end
			end
		end
	end
	return nil
end
CoD.DemoUtility.Timeline_GetHighlightedSegmentModel = function ()
	local f119_local0 = Engine[0x79618C46565F5A4]()
	local f119_local1 = Engine[0x8DF2E5447F384B9]()
	f119_local1 = f119_local1.DemoSegments
	if f119_local1 then
		for f119_local2 = 1, f119_local0, 1 do
			local f119_local5 = Engine[0x40E824FE270E174]( f119_local1, f119_local2 - 1 )
			if f119_local5 then
				local f119_local6 = f119_local5.highlighted
				if f119_local6 and f119_local6:get() == true then
					return f119_local5
				end
			end
		end
	end
	return nil
end
CoD.DemoUtility.PreviewSegment = function ( f120_arg0, f120_arg1 )
	Engine[0x7C75E608EA39B5C]( f120_arg1, "demo_previewsegment" )
	GoBack( f120_arg0, f120_arg1 )
end
CoD.DemoUtility.SaveSegment = function ( f121_arg0, f121_arg1 )
	Engine[0x7C75E608EA39B5C]( f121_arg1, "demo_savesegment 0" )
	GoBack( f121_arg0, f121_arg1 )
end
CoD.DemoUtility.previewWindowXpos = 0.67
CoD.DemoUtility.previewWindowYpos = 0.18
CoD.DemoUtility.previewWindowScale = 0.3
CoD.DemoUtility.DestroyAnimTimer = function ( f122_arg0 )
	if f122_arg0.animTimer then
		f122_arg0.animTimer:close()
		f122_arg0.animTimer = nil
	end
end
CoD.DemoUtility.AddHighlightReelWidget = function ( f123_arg0, f123_arg1 )
	local f123_local0 = CoD.DemoHighlightReel.new( f123_arg0, f123_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540 )
	LUI.roots["UIRoot" .. f123_arg1].addElement( REG3["UIRoot" .. f123_arg1], f123_local0 )
	f123_arg0:sendInitializationEvents( f123_arg1, f123_local0 )
end
CoD.DemoUtility.SetupHighlightReelPreviewWindow = function ( f124_arg0, f124_arg1, f124_arg2 )
	local f124_local0, f124_local1 = f124_arg0:getLocalSize()
	local f124_local2, f124_local3, f124_local4, f124_local5 = f124_arg1:getLocalRect()
	local f124_local6 = f124_local2 / f124_local0
	local f124_local7 = f124_local3 / f124_local1
	local f124_local8 = (f124_local4 - f124_local2 + 20) / f124_local0
	CoD.DemoUtility.previewWindowXpos = f124_local6
	CoD.DemoUtility.previewWindowYpos = f124_local7
	CoD.DemoUtility.previewWindowScale = f124_local8
	CoD.DemoUtility.TrySetViewport( f124_arg2, f124_local6, f124_local7, f124_local8 )
end
CoD.DemoUtility.RestoreNormalViewport = function ( f125_arg0, f125_arg1 )
	CoD.DemoUtility.DestroyAnimTimer( f125_arg0 )
	CoD.perController[f125_arg1].modifiedViewport = nil
	Engine[0x41BB55A1633C931]( f125_arg1 )
end
CoD.DemoUtility.TrySetViewport = function ( f126_arg0, f126_arg1, f126_arg2, f126_arg3 )
	CoD.perController[f126_arg0].modifiedViewport = {
		x = f126_arg1,
		y = f126_arg2,
		width = f126_arg3,
		height = f126_arg3
	}
	local f126_local0 = CoD.perController[f126_arg0].modifiedViewport
	Engine[0x8F1E2D5A7266B8]( f126_arg0, f126_local0.x, f126_local0.y, f126_local0.width, f126_local0.height )
end
CoD.DemoUtility.AnimateViewport = function ( f127_arg0, f127_arg1 )
	if not f127_arg0.viewportScaleTime then
		f127_arg0.viewportScaleTime = f127_arg1.timeElapsed
	else
		f127_arg0.viewportScaleTime = f127_arg0.viewportScaleTime + f127_arg1.timeElapsed
	end
	local f127_local0 = f127_arg0.viewportScaleTime / f127_arg1.scaleDuration
	if f127_local0 > 1 then
		f127_local0 = 1
		f127_arg0.viewportScaleTime = nil
		CoD.DemoUtility.DestroyAnimTimer( f127_arg0 )
	end
	local f127_local1 = f127_arg1.startScale + (f127_arg1.endScale - f127_arg1.startScale) * f127_local0
	local f127_local2 = f127_local0
	if f127_arg1.startScale < f127_arg1.endScale then
		f127_local2 = 1 - f127_local2
	end
	CoD.DemoUtility.TrySetViewport( f127_arg1.controller, CoD.DemoUtility.previewWindowXpos * f127_local2, CoD.DemoUtility.previewWindowYpos * f127_local2, f127_local1 )
end
CoD.DemoUtility.DoViewportAnimation = function ( f128_arg0, f128_arg1, f128_arg2, f128_arg3, f128_arg4 )
	if not f128_arg0.m_viewportAnimHandler then
		f128_arg0:registerEventHandler( "viewport_animation", CoD.DemoUtility.AnimateViewport )
		f128_arg0.m_viewportAnimHandler = true
	end
	CoD.DemoUtility.DestroyAnimTimer( f128_arg0 )
	f128_arg0.animTimer = LUI.UITimer.new( 1, {
		name = "viewport_animation",
		controller = f128_arg1,
		startScale = f128_arg2,
		endScale = f128_arg3,
		scaleDuration = f128_arg4
	}, false, f128_arg0 )
	f128_arg0:addElement( f128_arg0.killcamAnimTimer )
end
CoD.DemoUtility.Timeline_Container_LeftOffset = 154
CoD.DemoUtility.Timeline_Container_RightOffset = 234
CoD.DemoUtility.Timeline_Container_BottomOffset = 125
CoD.DemoUtility.Timeline_Container_Height = 20
CoD.DemoUtility.Timeline_Block_Spacing = 3
CoD.DemoUtility.TimelineEditor_AddTimeline = function ( f129_arg0 )
	local f129_local0 = Engine[0x79618C46565F5A4]()
	local f129_local1 = Engine[0x61A661773462085]( 0, "totalClipDuration" )
	if f129_local0 <= 0 then
		return 
	end
	f129_arg0.timelineContainer = LUI.UIContainer.new()
	local f129_local2 = 0
	local f129_local3 = 0
	if f129_arg0.TimelineContainerController ~= nil then
		f129_arg0.timelineContainer:setLeftRight( f129_arg0.TimelineContainerController:getLocalLeftRight() )
		f129_arg0.timelineContainer:setTopBottom( f129_arg0.TimelineContainerController:getLocalTopBottom() )
		f129_local2, f129_local3 = f129_arg0.TimelineContainerController:getLocalSize()
	else
		f129_arg0.timelineContainer:setLeftRight( true, true, CoD.DemoUtility.Timeline_Container_LeftOffset, -CoD.DemoUtility.Timeline_Container_RightOffset )
		f129_arg0.timelineContainer:setTopBottom( false, true, -CoD.DemoUtility.Timeline_Container_Height - CoD.DemoUtility.Timeline_Container_BottomOffset, -CoD.DemoUtility.Timeline_Container_BottomOffset )
		f129_local2 = 1920 - CoD.DemoUtility.Timeline_Container_LeftOffset + CoD.DemoUtility.Timeline_Container_RightOffset
		f129_local3 = CoD.DemoUtility.Timeline_Container_Height
	end
	f129_arg0:addElement( f129_arg0.timelineContainer )
	local f129_local4 = f129_local2 - CoD.DemoUtility.Timeline_Block_Spacing * (f129_local0 - 1)
	local f129_local5 = f129_local4 / f129_local0
	f129_arg0.timelineContainer.timeline = LUI.UIHorizontalList.new( 0, 0, 0, 0, 0, 0, 0, 0, CoD.DemoUtility.Timeline_Block_Spacing, false )
	f129_arg0.timelineContainer.timeline:setLeftRight( true, true, 0, 0 )
	f129_arg0.timelineContainer.timeline:setTopBottom( true, true, 0, 0 )
	f129_arg0.timelineContainer.timeline:setSpacing( CoD.DemoUtility.Timeline_Block_Spacing )
	f129_arg0.timelineContainer:addElement( f129_arg0.timelineContainer.timeline )
	local f129_local6 = 2
	for f129_local7 = 1, f129_local0, 1 do
		local f129_local10 = Engine[0x61A661773462085]( f129_local7 - 1, "duration" ) / f129_local1 * f129_local4
		local f129_local11 = CoD.DemoTimelineInternal.new()
		f129_local11:setLeftRight( true, false, 0, f129_local10 )
		f129_local11:setTopBottom( true, false, 0, f129_local3 )
		f129_arg0.timelineContainer.timeline[f129_local7] = f129_local11
		f129_arg0.timelineContainer.timeline:addElement( f129_local11 )
	end
end
CoD.DemoUtility.Timeline_RefreshState = function ( f130_arg0, f130_arg1, f130_arg2 )
	if not f130_arg1 then
		return 
	end
	local f130_local0 = CoD.DemoUtility.Timeline_GetSelectedSegmentModel()
	local f130_local1 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f130_arg1, "disabled" ) )
	local f130_local2 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f130_arg1, "segmentNumber" ) )
	if not f130_arg2 then
		if f130_arg1 == f130_local0 then
			f130_arg0.timelineContainer.timeline[f130_local2]:setState( 0, "SelectedState" )
		elseif not f130_local1 and f130_arg0.timelineContainer ~= nil then
			f130_arg0.timelineContainer.timeline[f130_local2]:setState( 0, "DefaultState" )
		end
	elseif f130_arg1 == f130_local0 then
		if f130_arg0.timelineContainer ~= nil then
			f130_arg0.timelineContainer.timeline[f130_local2]:setState( 0, "SelectedState" )
		end
	elseif not f130_local1 and f130_arg0.timelineContainer ~= nil then
		f130_arg0.timelineContainer.timeline[f130_local2]:setState( 0, "FocusState" )
	else
		
	end
end
CoD.DemoUtility.TimelineEditor_ReAddTimeline = function ( f131_arg0 )
	if f131_arg0.timelineContainer ~= nil then
		f131_arg0.timelineContainer:close()
	end
	CoD.DemoUtility.TimelineEditor_AddTimeline( f131_arg0 )
end
CoD.DemoUtility.Timeline_RefreshStateAfterMove = function ( f132_arg0, f132_arg1, f132_arg2, f132_arg3 )
	if f132_arg3 == true then
		CoD.DemoUtility.TimelineEditor_ReAddTimeline( f132_arg0 )
		CoD.DemoUtility.Timeline_RefreshState( f132_arg0, f132_arg2, false )
		CoD.DemoUtility.Timeline_RefreshState( f132_arg0, f132_arg1, true )
	else
		local f132_local0 = Engine[0x614D394F6F9A18D]
		local f132_local1 = Engine[0x40E824FE270E174]
		local f132_local2 = f132_arg2
		CoD.DemoUtility.Timeline_RefreshState( f132_arg0, f132_arg2, f132_arg0.timelineContainer.timeline[f132_local0( f132_local1( f132_arg2, "segmentNumber" ) )].focussed )
	end
end
CoD.DemoUtility.TimelineEditorPostLoad = function ( f133_arg0, f133_arg1 )
	local f133_local0 = function ( f134_arg0, f134_arg1 )
		if Engine[0x79618C46565F5A4]() <= 0 then
			if f134_arg0.ClipStartTime then
				f134_arg0.ClipStartTime:setAlpha( 0 )
			end
			if f134_arg0.ClipEndTime then
				f134_arg0.ClipEndTime:setAlpha( 0 )
			end
		else
			if f134_arg0.ClipStartTime then
				f134_arg0.ClipStartTime.Text:setText( "00:00" )
			end
			if f134_arg0.ClipEndTime then
				f134_arg0.ClipEndTime.Text:setText( Engine[0x61A661773462085]( 0, "totalClipDurationTimeDisplay" ) )
			end
		end
	end
	
	CoD.DemoUtility.TimelineEditor_AddTimeline( f133_arg0 )
	Engine[0x7C75E608EA39B5C]( f133_arg1, "setupThumbnailsForManageSegments" )
	f133_local0( f133_arg0, f133_arg1 )
	f133_arg0:subscribeToModel( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "DemoSegments.refresh" ), function ( model )
		UpdateElementDataSource( f133_arg0, "SegmentButtonList" )
		CoD.DemoUtility.TimelineEditor_ReAddTimeline( f133_arg0 )
		f133_local0( f133_arg0, f133_arg1 )
	end )
end
CoD.DemoUtility.TimelineEditorPlaceSegment = function ( f136_arg0, f136_arg1, f136_arg2, f136_arg3, f136_arg4 )
	local f136_local0 = CoD.DemoUtility.Timeline_GetSelectedSegmentModel()
	local f136_local1 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f136_local0, "segmentNumber" ) )
	if f136_arg3 == true then
		local f136_local2 = Engine[0x614D394F6F9A18D]( f136_arg1:getModel( f136_arg2, "segmentNumber" ) )
		local f136_local3 = f136_local1 - 1
		local f136_local4 = f136_local2 - 1
		if f136_local3 ~= f136_local4 then
			Engine[0xB81A5136C5503E4]( f136_arg4:getOwner(), "demo_movesegment " .. f136_local3 .. " " .. f136_local4 )
			for f136_local5 = 1, Engine[0x79618C46565F5A4](), 1 do
				CoD.DemoUtility.SetupDemoSegmentModel( f136_local5 - 1 )
			end
		end
	end
	Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f136_local0, "selected" ), false )
	CoD.DemoUtility.Timeline_RefreshStateAfterMove( f136_arg4, f136_arg1:getModel(), f136_local0, f136_arg3 )
end
CoD.DemoUtility.TimelineEditorSetupMoveSegment = function ( f137_arg0, f137_arg1, f137_arg2, f137_arg3 )
	local f137_local0 = f137_arg1:getModel()
	CoD.DemoUtility.Timeline_SetSelectedSegmentModel( f137_local0 )
	CoD.DemoUtility.Timeline_RefreshState( f137_arg3, f137_local0, true )
end
CoD.DemoUtility.TimelineEditorUpdateTimeline = function ( f138_arg0, f138_arg1, f138_arg2, f138_arg3, f138_arg4 )
	local f138_local0 = nil
	if f138_arg3 == "gain_focus" then
		f138_local0 = true
	else
		f138_local0 = false
	end
	CoD.DemoUtility.Timeline_RefreshState( f138_arg4, f138_arg1:getModel(), f138_local0 )
end
CoD.DemoUtility.SetNumHighlightReelMomentsModel = function ( f139_arg0 )
	Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "demo.numHighlightReelMoments" ), f139_arg0 )
end
CoD.DemoUtility.GetNumHighlightReelMomentsModel = function ()
	return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "demo.numHighlightReelMoments" )
end
CoD.DemoUtility.RebuildHighlightReelTimeline = function ( f141_arg0 )
	Engine[0xB81A5136C5503E4]( f141_arg0, "demo_rebuildhighlightreeltimeline" )
	CoD.DemoUtility.SetNumHighlightReelMomentsModel( Engine[0xDCCF490619F1876]() )
end
CoD.DemoUtility.Options_ItemSelected = function ( f142_arg0, f142_arg1, f142_arg2, f142_arg3, f142_arg4 )
	if Dvar[f142_arg3]:get() == f142_arg1.value then
		return 
	end
	Engine[0xB177D654FFB67BE]( f142_arg3, f142_arg1.value )
	if f142_arg1.valueChangedCallback then
		f142_arg1.valueChangedCallback( f142_arg4, f142_arg2, f142_arg3, f142_arg1.value )
	end
end
CoD.DemoUtility.Options_RevertItemSelected = function ( f143_arg0, f143_arg1, f143_arg2, f143_arg3, f143_arg4, f143_arg5 )
	local f143_local0 = CoD.OptionsUtility.GetCustomProfileSelection( f143_arg2, f143_arg1.options, Dvar[f143_arg3]:get() )
	local f143_local1, f143_local2 = f143_arg0.Slider:getRowAndColumnForIndex( Engine[0x614D394F6F9A18D]( f143_arg0:getModel( f143_arg2, "currentSelection" ) ) - 1 )
	f143_arg0.Slider:setActiveIndex( f143_local1, f143_local2, 0 )
end
CoD.DemoUtility.Options_GetProfileSelection = function ( f144_arg0, f144_arg1, f144_arg2 )
	return CoD.OptionsUtility.GetCustomProfileSelection( f144_arg0, f144_arg1, Dvar[f144_arg2]:get() )
end
CoD.DemoUtility.AddSubscriptionsToUpdatePlayerNameTextfield = function ( f145_arg0, f145_arg1 )
	f145_arg0:subscribeToGlobalModel( f145_arg1, "Demo", "cameraMode", function ( model )
		CoD.DemoUtility.UpdatePlayerNameTextField( f145_arg0, f145_arg1 )
	end )
	f145_arg0:subscribeToGlobalModel( f145_arg1, "Demo", "contextMode", function ( model )
		CoD.DemoUtility.UpdatePlayerNameTextField( f145_arg0, f145_arg1 )
	end )
	f145_arg0:subscribeToGlobalModel( f145_arg1, "Demo", "isFreeCameraLockedOnEntity", function ( model )
		CoD.DemoUtility.UpdatePlayerNameTextField( f145_arg0, f145_arg1 )
	end )
	f145_arg0:subscribeToGlobalModel( f145_arg1, "Demo", "editingDollyCameraMarker", function ( model )
		CoD.DemoUtility.UpdatePlayerNameTextField( f145_arg0, f145_arg1 )
	end )
	f145_arg0:subscribeToGlobalModel( f145_arg1, "Demo", "highlightedDollyCamMarker", function ( model )
		CoD.DemoUtility.UpdatePlayerNameTextField( f145_arg0, f145_arg1 )
	end )
	f145_arg0:subscribeToGlobalModel( f145_arg1, "Demo", "editingLightmanMarker", function ( model )
		CoD.DemoUtility.UpdatePlayerNameTextField( f145_arg0, f145_arg1 )
	end )
	f145_arg0:subscribeToGlobalModel( f145_arg1, "Demo", "highlightedLightmanMarker", function ( model )
		CoD.DemoUtility.UpdatePlayerNameTextField( f145_arg0, f145_arg1 )
	end )
end
CoD.DemoUtility.UpdatePlayerNameTextField = function ( f153_arg0, f153_arg1 )
	local f153_local0 = Engine[0x8DF2E5447F384B9]()
	f153_local0 = f153_local0.demo.cameraMode:get()
	local f153_local1 = ""
	local f153_local2 = false
	if f153_local0 ~= Enum[0xF432DF404208022][0x3B1995A6E46FA28] then
		local f153_local3 = Engine[0x8DF2E5447F384B9]()
		f153_local1 = GetClientNameAndClanTag( f153_arg1, f153_local3.demo.clientNum:get() )
	elseif IsDemoContextObjectLinkMode() and IsFreeCameraLockedOnEntity( f153_arg1 ) then
		f153_local1 = Engine[0xF9F1239CFD921FE]( 0x8903AE364895CE8 )
	elseif IsDemoContextDirectorMode() and IsEditingDollyCameraMarker( f153_arg1 ) then
		local f153_local3 = Engine[0xF9F1239CFD921FE]
		local f153_local4 = 0xA4EB256F6CA0980
		local f153_local5 = Engine[0x8DF2E5447F384B9]()
		f153_local1 = f153_local3( f153_local4, f153_local5.demo.highlightedDollycamMarker:get() + 1 )
	elseif IsDemoContextLighterMode() and IsEditingLightmanMarker( f153_arg1 ) then
		local f153_local3 = Engine[0xF9F1239CFD921FE]
		local f153_local4 = 0x67D7781E9B61375
		local f153_local5 = Engine[0x8DF2E5447F384B9]()
		f153_local1 = f153_local3( f153_local4, f153_local5.demo.highlightedLightmanMarker:get() + 1 )
	else
		f153_local1 = Engine[0xF9F1239CFD921FE]( 0x68CA5FCB835FB9 )
		f153_local2 = true
	end
	SetGlobalModelValue( "demo.isDefaultCameraMode", f153_local2 )
	f153_arg0:setText( f153_local1 )
end
CoD.DemoUtility.BasicDemoShortcutsKBM = {
	{
		models = {
			text = 0x597F5DD8A0C5760,
			keyprompt = LocalizeToUpperString( 0x49B065E66E9596C )
		}
	},
	{
		models = {
			text = 0x280131879E5ADC2,
			keyprompt = LocalizeToUpperString( 0x10F8E0BD934E07E )
		}
	},
	{
		models = {
			text = 0x8BF76F79E90F6CF,
			keyprompt = LocalizeToUpperString( 0x7CA4B50830721D )
		}
	},
	{
		models = {
			text = 0x6C0BE258C969BF4,
			keyprompt = LocalizeToUpperString( 0x63AA7B7405E74BC )
		}
	},
	{
		models = {
			text = 0xE2B2C0952894C4D,
			keyprompt = LocalizeToUpperString( 0xA4153A04CFECFE9 )
		}
	},
	{
		models = {
			text = 0xB038D9453F8C68E,
			keyprompt = "C"
		}
	},
	{
		models = {
			text = 0x11CF7B88D647093,
			keyprompt = LocalizeToUpperString( 0xC29CFDDA408A8E5 )
		}
	},
	{
		models = {
			text = 0x34BCA0ADE1DF991,
			keyprompt = "1"
		}
	},
	{
		models = {
			text = 0x587488246EAE3C5,
			keyprompt = "2"
		}
	},
	{
		models = {
			text = 0x6591FFDD273F91B,
			keyprompt = "Q"
		}
	},
	{
		models = {
			text = 0x26F3509075FC393,
			keyprompt = "E"
		}
	},
	{
		models = {
			text = 0xFC58B6B8A97659A,
			keyprompt = "R"
		}
	}
}
CoD.DemoUtility.DirectorDemoShortcutsKBM = {
	{
		models = {
			text = 0xE96BF79471D3219,
			keyprompt = "F"
		}
	},
	{
		models = {
			text = 0x8DB74DFF37EF57B,
			keyprompt = "3"
		}
	},
	{
		models = {
			text = 0x66C89284B58B93F,
			keyprompt = "4"
		}
	},
	{
		models = {
			text = 0x9BCF566EA52C59C,
			keyprompt = "V"
		}
	},
	{
		models = {
			text = 0xBF7B14675E7B617,
			keyprompt = "G"
		}
	},
	{
		models = {
			text = 0xBEF9CEBE3181BC3,
			keyprompt = "3"
		}
	},
	{
		models = {
			text = 0x746F3906C11C7FA,
			keyprompt = "4"
		}
	},
	{
		models = {
			text = 0xFEAAD540291163C,
			keyprompt = "R"
		}
	},
	{
		models = {
			text = 0xB72CAD1CD8CFC59,
			keyprompt = "V"
		}
	},
	{
		models = {
			text = 0xC1DB4098ABE577F,
			keyprompt = "X"
		}
	},
	{
		models = {
			text = 0xF2C7C1623D97559,
			keyprompt = "F"
		}
	}
}
CoD.DemoUtility.LighterDemoShortcutsKBM = {
	{
		models = {
			text = 0x6C6D9CEB8999A7F,
			keyprompt = "F"
		}
	},
	{
		models = {
			text = 0x553A6E21EAC0F39,
			keyprompt = "G"
		}
	},
	{
		models = {
			text = 0x2F28B777CF088A4,
			keyprompt = "1"
		}
	},
	{
		models = {
			text = 0xC158727862481D1,
			keyprompt = "2"
		}
	},
	{
		models = {
			text = 0x8D7B401DD98AEE0,
			keyprompt = "3"
		}
	},
	{
		models = {
			text = 0x780E9B4227D7F27,
			keyprompt = "4"
		}
	},
	{
		models = {
			text = 0x9D2A41CFBBDFEFC,
			keyprompt = "R"
		}
	},
	{
		models = {
			text = 0x356E6E2B670DBE9,
			keyprompt = "V"
		}
	},
	{
		models = {
			text = 0x9D2A41CFBBDFEFC,
			keyprompt = "X"
		}
	},
	{
		models = {
			text = 0x4F480EF7F95F9BF,
			keyprompt = "F"
		}
	}
}
CoD.DemoUtility.ObjectLinkDemoShortcutsKBM = {
	{
		models = {
			text = 0x47F55BF6C65FA,
			keyprompt = "X"
		}
	},
	{
		models = {
			text = 0x1AF6628A5C863B9,
			keyprompt = "F"
		}
	},
	{
		models = {
			text = 0xA071FF393D04E2E,
			keyprompt = "F"
		}
	}
}
DataSources.BasicDemoShortcutsKBM = DataSourceHelpers.ListSetup( "BasicDemoShortcutsKBM", function ( f154_arg0 )
	local f154_local0 = {}
	if IsDemoContextBasicMode() then
		f154_local0 = CoD.DemoUtility.BasicDemoShortcutsKBM
	elseif IsDemoContextDirectorMode() then
		f154_local0 = CoD.DemoUtility.DirectorDemoShortcutsKBM
	elseif IsDemoContextLighterMode() then
		f154_local0 = CoD.DemoUtility.LighterDemoShortcutsKBM
	elseif IsDemoContextObjectLinkMode() then
		f154_local0 = CoD.DemoUtility.ObjectLinkDemoShortcutsKBM
	end
	return f154_local0
end, true )
