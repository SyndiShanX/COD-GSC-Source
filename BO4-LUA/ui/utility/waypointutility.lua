CoD.WaypointUtility = {}
CoD.WaypointUtility.IsObjectiveRequirementLabelHidden = function(f1_arg0, f1_arg1)
	if f1_arg0.objective[0xE9970BB9777A47E] == 1 then
		return false
	end
	local f1_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f1_arg1), "interactivePrompt.activeObjectiveID")
	if f1_local0 then
		f1_local0 = Engine[0x614D394F6F9A18D](f1_local0)
	end
	if f1_local0 and f1_arg0.objId == f1_local0 then
		return false
	elseif f1_arg0.objId then
		local f1_local1 = Engine[0x2C6B07FD023877B](f1_arg1, Engine[0x869E84B826141D2](f1_arg1))
		if CoD.HUDUtility.IsPlayerUsingWaypoint(f1_arg0, f1_arg1, Engine[0x532E31F2015143B](f1_arg1, f1_arg0.objId, f1_local1), Engine[0x3E1BD98D6F60CC3](f1_arg1, f1_arg0.objId, f1_local1)) then
			return false
		end
	end
	return true
end
CoD.WaypointUtility.ShouldShowWaypointFrame = function(f2_arg0, f2_arg1)
	if f2_arg1.objective[0xC89FB9D9D1E0F33] == 1 or f2_arg1.objective[0xE614D1FE7F77CDF] == 1 then
		return false
	end
	local f2_local0 = Engine[0x2C6B07FD023877B](f2_arg0, Engine[0x869E84B826141D2](f2_arg0))
	local f2_local1 = Engine[0x532E31F2015143B](f2_arg0, f2_arg1.objId, f2_local0)
	local f2_local2 = Engine[0x3E1BD98D6F60CC3](f2_arg0, f2_arg1.objId, f2_local0)
	if not CoD.HUDUtility.IsPlayerUsingWaypoint(f2_arg1, f2_arg0, f2_local1, f2_local2) and (not f2_local1 or not f2_local2) and f2_arg1.objective[0x61856A88046E4AE] ~= 1 and (not f2_local1 or f2_arg1.objective[0xF9D561CC4D4EBEB] ~= 1) then
		return false
	end
	local f2_local3 = CoD.SafeGetModelValue(f2_arg1:getModel(), "progress")
	local f2_local4
	if not f2_local3 or f2_local3 <= 0 then
		local f2_local5 = f2_local1
		f2_local4 = f2_local2
	else
		f2_local4 = f2_local5 and true
	end
	return f2_local4
end
CoD.WaypointUtility.IsFriendlyUsing = function(f3_arg0, f3_arg1)
	local f3_local0 = Engine[0x2C6B07FD023877B](f3_arg1, Engine[0x869E84B826141D2](f3_arg1))
	local f3_local1 = Engine[0x532E31F2015143B]
	local f3_local2 = f3_arg1
	local f3_local3 = f3_arg0:getModel()
	return f3_local1(f3_local2, f3_local3.objId:get(), f3_local0)
end
CoD.WaypointUtility.ShouldShowWaypointIcon = function(f4_arg0, f4_arg1)
	if not CoD.ModelUtility.IsSelfModelValueNonEmptyString(f4_arg1, f4_arg0, "icon") then
		return false
	elseif f4_arg1.objective[0xA8F7A3EDE89CCD7] and CoD.CodCasterUtility.CodCasterIsInAerialCam(f4_arg0) then
		return true
	else
		local f4_local0
		if f4_arg1.objective[0x93D42E7917D43BD] == 1 then
			f4_local0 = not f4_arg1.snappedToCenter
		else
			f4_local0 = true
		end
	end
	return f4_local0
end
CoD.WaypointUtility.ShouldShowWaypointAsContestedHelper = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	if GetObjectiveXHashProperty(0x3F152058C30382, f5_arg1) == 1 then
		return false
	elseif f5_arg3 and CoD.CodCasterUtility.CodCasterIsInAerialCam(f5_arg0) then
		return false
	else
		local f5_local0 = Engine[0x2C6B07FD023877B](f5_arg0, Engine[0x869E84B826141D2](f5_arg0))
		return Engine[0x532E31F2015143B](f5_arg0, f5_arg2, f5_local0) and Engine[0x3E1BD98D6F60CC3](f5_arg0, f5_arg2, f5_local0)
	end
end
CoD.WaypointUtility.ShouldShowWaypointAsContested = function(f6_arg0, f6_arg1)
	return CoD.WaypointUtility.ShouldShowWaypointAsContestedHelper(f6_arg0, f6_arg1.objective.id, f6_arg1.objId, f6_arg1.objective[0xA8F7A3EDE89CCD7])
end
CoD.WaypointUtility.ShouldShowWaypointAsProtect = function(f7_arg0, f7_arg1)
	local f7_local0 = Engine[0x12267460B50F00A](f7_arg0, f7_arg1.objId) or 0
	if f7_local0 > 0 then
		local f7_local1
		if Engine[0x4C77EAF5F088DC3](f7_arg0, f7_arg1.objId) ~= Engine[0x2C6B07FD023877B](f7_arg0, Engine[0x869E84B826141D2](f7_arg0)) or f7_arg1.objective[0xD24079C4886368B .. f7_local0] ~= 1 then
			f7_local1 = false
		else
			f7_local1 = true
		end
		return f7_local1
	else
		return false
	end
end
CoD.WaypointUtility.ShouldShowWaypointAsPulsing = function(f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1:getParent()
	if not f8_local0 or not f8_local0.objective or f8_local0.objective[0x528BA0C66DF2DFE] ~= 1 or not f8_local0.objId then
		return false
	elseif f8_local0.objective[0xFE5A27608B78BD9] ~= 1 then
		local f8_local1 = Engine[0x4A91602186AE14D](f8_arg0, f8_local0.objId)
		if f8_local1 == 0 then
			return false
		elseif f8_local0.objective[0xEFFC4867F3CA257] == 1 then
			local f8_local2 = f8_local0.objective[0x74BD46E9CEA006]
			for f8_local3 = 1, f8_local2 - 1, 1 do
				if f8_local1 == f8_local3 / f8_local2 then
					return false
				end
			end
		end
	end
	return Engine[0x7A01BC612811EFE](f8_arg0, f8_local0.objId) == 1
end
CoD.WaypointUtility.ShouldShowWaypointFlatProgressBar = function(f9_arg0, f9_arg1)
	if f9_arg1.objective[0xA8F7A3EDE89CCD7] and CoD.CodCasterUtility.CodCasterIsInAerialCam(f9_arg0) then
		return false
	else
		local f9_local0
		if f9_arg1.objective[0x89F12D51F50A71] == 1 then
			f9_local0 = f9_arg1.snappedToCenter
		else
			f9_local0 = false
		end
	end
	return f9_local0
end
CoD.WaypointUtility.ShouldShowProgressOnIcon = function(f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1:getModel()
	local f10_local1 = f10_local0
	local f10_local2 = f10_local0.objId
	if f10_local2 then
		f10_local2 = f10_local1 and f10_local0.objId:get()
	end
	if f10_local2 then
		local f10_local3 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f10_arg0, f10_local2))
		local f10_local4 = f10_local3
		local f10_local5
		if f10_local3[0xC89FB9D9D1E0F33] ~= 0 or f10_local3[0xE614D1FE7F77CDF] ~= 1 then
			f10_local5 = false
		else
			f10_local5 = f10_local4 and true
		end
		return f10_local5
	else
		return false
	end
end
CoD.WaypointUtility.ShouldShowRadialTimerOnIcon = function(f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1:getModel()
	local f11_local1 = f11_local0
	local f11_local2 = f11_local0.objId
	if f11_local2 then
		f11_local2 = f11_local1 and f11_local0.objId:get()
	end
	if f11_local2 then
		local f11_local3 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f11_arg0, f11_local2))
		if f11_local3 and f11_local3[0x758ECC3699C3FDC] == 1 then
			if f11_local3[0x46D19887AADFEB7] == 1 then
				return Engine[0xDD333420C49E6D0](f11_arg0, Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2])
			else
				return Engine[0xDD333420C49E6D0](f11_arg0, Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F])
			end
		end
	end
	return false
end
CoD.WaypointUtility.ShouldShowPulsingProgressOnIcon = function(f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1:getModel()
	local f12_local1 = f12_local0
	local f12_local2 = f12_local0.objId
	if f12_local2 then
		f12_local2 = f12_local1 and f12_local0.objId:get()
	end
	if f12_local2 then
		local f12_local3 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f12_arg0, f12_local2))
		if f12_local3 and f12_local3[0xC89FB9D9D1E0F33] == 0 and f12_local3[0xE614D1FE7F77CDF] == 1 and f12_local3[0x254042508436EDA] == 1 then
			local f12_local4 = f12_local0.progress and f12_local0.progress:get() or 0
			if f12_local4 > 0 then
				return f12_local4 < f12_local3[0xD21C49136F5621B]
			end
		end
	end
	return false
end
CoD.WaypointUtility.IsWeaponPickupActive = function(f13_arg0, f13_arg1)
	local f13_local0 = DataSources.HUDItems.getModel(f13_arg0)
	local f13_local1 = f13_local0.showPickupHint:get()
	local f13_local2 = f13_local0.inventory.open:get()
	local f13_local3 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f13_arg0), "interactivePrompt.activeObjectiveID")
	f13_local3 = f13_local3:get()
	local f13_local4 = f13_local1
	local f13_local5
	if f13_local2 or f13_local3 ~= -1 then
		f13_local5 = false
	else
		f13_local5 = f13_local4 and true
	end
	return f13_local5
end
CoD.WaypointUtility.IsWeaponPickupInRange = function(f14_arg0, f14_arg1)
	local f14_local0 = DataSources.HUDItems.getModel(f14_arg0)
	local f14_local1 = f14_local0.showPickupHint:get()
	local f14_local2 = f14_local0.inventory.open:get()
	local f14_local3 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f14_arg0), "interactivePrompt.activeObjectiveID")
	f14_local3 = f14_local3:get()
	local f14_local4 = f14_arg1:getModel(f14_arg0, "isOffscreen")
	local f14_local5
	if f14_local2 or (f14_local4 and f14_local4:get()) or f14_local1 and f14_local3 == -1 then
		f14_local5 = false
	else
		f14_local5 = true
	end
	return f14_local5
end
CoD.WaypointUtility.SetIconProgressMeter = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = 1 - f15_arg2
	if f15_arg1 then
		return f15_local0, 1, 0, 0
	else
		return 0, f15_local0, 0, 0
	end
end
CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded = function(f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f16_arg0, f16_arg2))
	if f16_local0 and f16_local0[0xEFFC4867F3CA257] == 1 then
		return f16_local0[0x74BD46E9CEA006], f16_arg1, 1, 0
	else
		return 0, 0, 0, 0
	end
end
CoD.WaypointUtility.SetHealthMeterSegmentationIfNeeded = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f17_arg0, f17_arg2))
	if (f17_local0[0x437D7B32AC35178] or 0) > 0 then
		return f17_local0[0x437D7B32AC35178], f17_arg1, 1, 0
	else
		return 0, 0, 0, 0
	end
end
CoD.WaypointUtility.ShouldBypassFiltersForMinimap = function(f18_arg0, f18_arg1)
	if f18_arg0.objective[0xAAC8CB98C8D8A34] ~= nil and f18_arg0.objective[0xAAC8CB98C8D8A34] ~= "" and not Engine[0x4B80DF7F86F7002](f18_arg1, f18_arg0.objective[0xAAC8CB98C8D8A34]) then
		return f18_arg0.objective[0x55883052FE10427] == 1
	else
		return false
	end
end
CoD.WaypointUtility.ConvertToColorInternal = function(f19_arg0, f19_arg1)
	local f19_local0 = ColorSet[f19_arg0]
	if not f19_local0 then
		f19_local0 = ColorSet[f19_arg1]
	end
	return f19_local0.r, f19_local0.g, f19_local0.b
end
CoD.WaypointUtility.ConvertToBaseColor = function(f20_arg0)
	return CoD.ColorUtility.ConvertColorFromTable(ColorSet[f20_arg0])
end
CoD.WaypointUtility.ConvertToMutedColor = function(f21_arg0)
	return CoD.WaypointUtility.ConvertToColorInternal(f21_arg0 .. "_Muted", f21_arg0)
end
CoD.WaypointUtility.ConvertToBrightColor = function(f22_arg0)
	return CoD.WaypointUtility.ConvertToColorInternal(f22_arg0 .. "_Bright", f22_arg0)
end
CoD.WaypointUtility.ShouldHideWaypointAndMinimapIcon = function(f23_arg0, f23_arg1)
	if f23_arg0.objective then
		if not IsObjectiveVisibleForMyTeam(f23_arg1, f23_arg0.objId) then
			return true
		end
		local f23_local0 = Engine[0x869E84B826141D2](f23_arg1)
		if f23_arg0.objective[0xD4D7F1719DFA984] == 1 then
			return f23_local0 == Engine[0x626F871BFD9CF11](f23_arg1, f23_arg0.objId)
		elseif f23_arg0.objective[0x3587AE58E18B34] == 1 then
			return Engine[0x869E84B826141D2](f23_arg1) == Engine[0xC43D7E71B1CA70B](f23_arg1, f23_arg0.objId)
		elseif f23_arg0.objective[0xAAC8CB98C8D8A34] ~= nil and f23_arg0.objective[0xAAC8CB98C8D8A34] ~= "" and not Engine[0x4B80DF7F86F7002](f23_arg1, f23_arg0.objective[0xAAC8CB98C8D8A34]) then
			return true
		elseif f23_arg0.objective[0x67F5E53382B3161] == 1 and Engine[0xDD333420C49E6D0](f23_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) then
			return true
		elseif CoD.isCampaign and not Engine[0xDD333420C49E6D0](f23_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
			return true
		end
	end
	if CoD.SafeGetModelValue(f23_arg0:getModel(), "state") == Enum[0xA2C16942D15B316][0x59FDE7D12BCC045] then
		return true
	end
	return false
end
CoD.WaypointUtility.ShouldHideMinimapIcon = function(f24_arg0, f24_arg1)
	if CoD.WaypointUtility.ShouldHideWaypointAndMinimapIcon(f24_arg0, f24_arg1) and not CoD.WaypointUtility.ShouldBypassFiltersForMinimap(f24_arg0, f24_arg1) then
		return true
	elseif f24_arg0.objective[0x8113640727D2288] == 1 then
		return Engine[0x4C77EAF5F088DC3](f24_arg1, f24_arg0.objId) ~= Engine[0x2C6B07FD023877B](f24_arg1, Engine[0x869E84B826141D2](f24_arg1))
	else
		return false
	end
end
CoD.WaypointUtility.ShouldHideWaypoint = function(f25_arg0, f25_arg1)
	if CoD.WaypointUtility.ShouldHideWaypointAndMinimapIcon(f25_arg0, f25_arg1) then
		return true
	elseif f25_arg0.objective then
		local f25_local0 = Engine[0x869E84B826141D2](f25_arg1)
		local f25_local1
		if f25_arg0.objective[0xB78F04652A4E122] ~= 1 and f25_arg0.objective[0x29FF873E6357558] ~= 1 and f25_arg0.objective[0xD6D209C87C35EEA] ~= 1 then
			f25_local1 = false
		else
			f25_local1 = true
		end
		if f25_local1 and Engine[0x1DE3FFB9566D7E7](f25_arg1, f25_arg0.objId, f25_local0) then
			local f25_local2 = Engine[0x2C6B07FD023877B](f25_arg1, f25_local0)
			local f25_local3 = Engine[0x532E31F2015143B](f25_arg1, f25_arg0.objId, f25_local2) and Engine[0x3E1BD98D6F60CC3](f25_arg1, f25_arg0.objId, f25_local2)
			if f25_local3 and f25_arg0.objective[0xD6D209C87C35EEA] == 1 then
				return true
			elseif CoD.HUDUtility.IsWaypointOwnedByMyTeam(f25_arg0, f25_arg1) then
				if f25_arg0.objective[0xB78F04652A4E122] == 1 and not f25_local3 then
					return true
				end
			elseif f25_arg0.objective[0x29FF873E6357558] == 1 and not f25_local3 then
				return true
			end
		end
		if f25_arg0.objective[0xBBC97D237FCBEA6] == 1 then
			local f25_local2 = f25_arg0:getModel(f25_arg1, "isOffscreen")
			if f25_local2 and f25_local2:get() and CoD.WaypointUtility.IsObjectiveRequirementLabelHidden(f25_arg0, f25_arg1) then
				return true
			end
		end
		local f25_local2 = Engine[0x4DF5CFBC1771947](f25_arg1)
		if Engine[0xDD333420C49E6D0](f25_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870]) or f25_local2.hudItems.hacked:get() > 0 then
			return f25_arg0.objective[0x61B460B26283391] == 1
		elseif Engine[0xDD333420C49E6D0](f25_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]) then
			return f25_arg0.objective[0x29120244683F1CF] == 1
		end
	end
	return false
end
CoD.WaypointUtility.SetupWaypointCloseShowMessageListener = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = Engine[0x4DF5CFBC1771947](f26_arg2)
	f26_arg0:subscribeToModel(f26_local0:create("onWaypointClose"), function(model)
		f26_arg1:setText(model:get() or "")
		f26_arg0:playClip("ShowMessage")
	end)
end
CoD.WaypointUtility.ShowMessageOnCloseIfNeeded = function(f28_arg0, f28_arg1)
	local f28_local0 = f28_arg1.objective
	local f28_local1 = f28_local0[0x3853F0A0E60B64D]
	if f28_local1 then
		local f28_local2 = true
		if f28_local0[0x4E9883B54B9B7C] and f28_local0[0x4E9883B54B9B7C] ~= "Any" then
			f28_local2 = f28_arg1.currentState == f28_local0[0x4E9883B54B9B7C]
		end
		if f28_local2 then
			local f28_local3 = Engine[0x4DF5CFBC1771947](f28_arg0)
			f28_local3 = f28_local3:create("onWaypointClose")
			if not f28_local3:set(Engine[0xED84C33EC5F01EA](f28_local1)) then
				f28_local3:forceNotifySubscriptions()
			end
		end
	end
end
CoD.WaypointUtility.GetCarryIcon = function(f29_arg0, f29_arg1)
	if not f29_arg1 or f29_arg1 == -1 then
		return "blacktransparent"
	else
		local f29_local0 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f29_arg0, f29_arg1))
		if f29_local0 and f29_local0[0x366BE37A5AE3011] and f29_local0[0x366BE37A5AE3011] ~= "" then
			return f29_local0[0x366BE37A5AE3011]
		else
			return "blacktransparent"
		end
	end
end
CoD.WaypointUtility.ShouldShowCarryIconBadge = function(f30_arg0)
	local f30_local0 = DataSources.HUDItems.getModel(f30_arg0)
	f30_local0 = f30_local0.heldObjectiveId:get()
	if f30_local0 == -1 then
		return false
	else
		local f30_local1 = CoD.HUDUtility.GetCachedObjective(Engine[0xBE25B67EDE3D9F9](f30_arg0, f30_local0))
		return f30_local1 and f30_local1[0x590212E3CB9EE11] == 1
	end
end
CoD.WaypointUtility.GetContributedCaptureText = function(f31_arg0, f31_arg1)
	local f31_local0 = CoD.HUDUtility.GetCachedObjective(f31_arg1)
	if f31_local0 then
		return f31_local0[0x2F6637F605A66D2] or 0x0
	else
		return 0x0
	end
end
