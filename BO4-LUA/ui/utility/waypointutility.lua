CoD.WaypointUtility = {}
CoD.WaypointUtility.IsObjectiveRequirementLabelHidden = function(f1_arg0, f1_arg1)
	if f1_arg0.objective[@"hash_1E9970BB9777A47E"] == 1 then
		return false
	end
	local f1_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f1_arg1), "interactivePrompt.activeObjectiveID")
	if f1_local0 then
		f1_local0 = Engine[@"getmodelvalue"](f1_local0)
	end
	if f1_local0 and f1_arg0.objId == f1_local0 then
		return false
	elseif f1_arg0.objId then
		local f1_local1 = Engine[@"getteamid"](f1_arg1, Engine[@"getpredictedclientnum"](f1_arg1))
		if CoD.HUDUtility.IsPlayerUsingWaypoint(f1_arg0, f1_arg1, Engine[@"objectiveisteamusing"](f1_arg1, f1_arg0.objId, f1_local1), Engine[@"objectiveisanyotherteamusing"](f1_arg1, f1_arg0.objId, f1_local1)) then
			return false
		end
	end
	return true
end
CoD.WaypointUtility.ShouldShowWaypointFrame = function(f2_arg0, f2_arg1)
	if f2_arg1.objective[@"hash_C89FB9D9D1E0F33"] == 1 or f2_arg1.objective[@"hash_2E614D1FE7F77CDF"] == 1 then
		return false
	end
	local f2_local0 = Engine[@"getteamid"](f2_arg0, Engine[@"getpredictedclientnum"](f2_arg0))
	local f2_local1 = Engine[@"objectiveisteamusing"](f2_arg0, f2_arg1.objId, f2_local0)
	local f2_local2 = Engine[@"objectiveisanyotherteamusing"](f2_arg0, f2_arg1.objId, f2_local0)
	if not CoD.HUDUtility.IsPlayerUsingWaypoint(f2_arg1, f2_arg0, f2_local1, f2_local2) and (not f2_local1 or not f2_local2) and f2_arg1.objective[@"hash_761856A88046E4AE"] ~= 1 and (not f2_local1 or f2_arg1.objective[@"hash_5F9D561CC4D4EBEB"] ~= 1) then
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
	local f3_local0 = Engine[@"getteamid"](f3_arg1, Engine[@"getpredictedclientnum"](f3_arg1))
	local f3_local1 = Engine[@"objectiveisteamusing"]
	local f3_local2 = f3_arg1
	local f3_local3 = f3_arg0:getModel()
	return f3_local1(f3_local2, f3_local3.objId:get(), f3_local0)
end
CoD.WaypointUtility.ShouldShowWaypointIcon = function(f4_arg0, f4_arg1)
	if not CoD.ModelUtility.IsSelfModelValueNonEmptyString(f4_arg1, f4_arg0, "icon") then
		return false
	elseif f4_arg1.objective[@"hash_A8F7A3EDE89CCD7"] and CoD.CodCasterUtility.CodCasterIsInAerialCam(f4_arg0) then
		return true
	else
		local f4_local0
		if f4_arg1.objective[@"hash_193D42E7917D43BD"] == 1 then
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
		local f5_local0 = Engine[@"getteamid"](f5_arg0, Engine[@"getpredictedclientnum"](f5_arg0))
		return Engine[@"objectiveisteamusing"](f5_arg0, f5_arg2, f5_local0) and Engine[@"objectiveisanyotherteamusing"](f5_arg0, f5_arg2, f5_local0)
	end
end
CoD.WaypointUtility.ShouldShowWaypointAsContested = function(f6_arg0, f6_arg1)
	return CoD.WaypointUtility.ShouldShowWaypointAsContestedHelper(f6_arg0, f6_arg1.objective.id, f6_arg1.objId, f6_arg1.objective[@"hash_A8F7A3EDE89CCD7"])
end
CoD.WaypointUtility.ShouldShowWaypointAsProtect = function(f7_arg0, f7_arg1)
	local f7_local0 = Engine[@"getobjectivegamemodeflags"](f7_arg0, f7_arg1.objId) or 0
	if f7_local0 > 0 then
		local f7_local1
		if Engine[@"getobjectiveteam"](f7_arg0, f7_arg1.objId) ~= Engine[@"getteamid"](f7_arg0, Engine[@"getpredictedclientnum"](f7_arg0)) or f7_arg1.objective[@"hash_2D24079C4886368B" .. f7_local0] ~= 1 then
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
	if not f8_local0 or not f8_local0.objective or f8_local0.objective[@"pulse"] ~= 1 or not f8_local0.objId then
		return false
	elseif f8_local0.objective[@"hash_FE5A27608B78BD9"] ~= 1 then
		local f8_local1 = Engine[@"getobjectiveprogress"](f8_arg0, f8_local0.objId)
		if f8_local1 == 0 then
			return false
		elseif f8_local0.objective[@"hash_7EFFC4867F3CA257"] == 1 then
			local f8_local2 = f8_local0.objective[@"hash_74BD46E9CEA006"]
			for f8_local3 = 1, f8_local2 - 1, 1 do
				if f8_local1 == f8_local3 / f8_local2 then
					return false
				end
			end
		end
	end
	return Engine[@"objectivegetteamusingcount"](f8_arg0, f8_local0.objId) == 1
end
CoD.WaypointUtility.ShouldShowWaypointFlatProgressBar = function(f9_arg0, f9_arg1)
	if f9_arg1.objective[@"hash_A8F7A3EDE89CCD7"] and CoD.CodCasterUtility.CodCasterIsInAerialCam(f9_arg0) then
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
		local f10_local3 = CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f10_arg0, f10_local2))
		local f10_local4 = f10_local3
		local f10_local5
		if f10_local3[@"hash_C89FB9D9D1E0F33"] ~= 0 or f10_local3[@"hash_2E614D1FE7F77CDF"] ~= 1 then
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
		local f11_local3 = CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f11_arg0, f11_local2))
		if f11_local3 and f11_local3[@"hash_7758ECC3699C3FDC"] == 1 then
			if f11_local3[@"hash_546D19887AADFEB7"] == 1 then
				return Engine[@"isvisibilitybitset"](f11_arg0, Enum[@"uivisibilitybit"][@"bit_bomb_timer_b"])
			else
				return Engine[@"isvisibilitybitset"](f11_arg0, Enum[@"uivisibilitybit"][@"bit_bomb_timer_a"])
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
		local f12_local3 = CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f12_arg0, f12_local2))
		if f12_local3 and f12_local3[@"hash_C89FB9D9D1E0F33"] == 0 and f12_local3[@"hash_2E614D1FE7F77CDF"] == 1 and f12_local3[@"hash_254042508436EDA"] == 1 then
			local f12_local4 = f12_local0.progress and f12_local0.progress:get() or 0
			if f12_local4 > 0 then
				return f12_local4 < f12_local3[@"hash_4D21C49136F5621B"]
			end
		end
	end
	return false
end
CoD.WaypointUtility.IsWeaponPickupActive = function(f13_arg0, f13_arg1)
	local f13_local0 = DataSources.HUDItems.getModel(f13_arg0)
	local f13_local1 = f13_local0.showPickupHint:get()
	local f13_local2 = f13_local0.inventory.open:get()
	local f13_local3 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f13_arg0), "interactivePrompt.activeObjectiveID")
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
	local f14_local3 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f14_arg0), "interactivePrompt.activeObjectiveID")
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
	local f16_local0 = CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f16_arg0, f16_arg2))
	if f16_local0 and f16_local0[@"hash_7EFFC4867F3CA257"] == 1 then
		return f16_local0[@"hash_74BD46E9CEA006"], f16_arg1, 1, 0
	else
		return 0, 0, 0, 0
	end
end
CoD.WaypointUtility.SetHealthMeterSegmentationIfNeeded = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f17_arg0, f17_arg2))
	if (f17_local0[@"hash_7437D7B32AC35178"] or 0) > 0 then
		return f17_local0[@"hash_7437D7B32AC35178"], f17_arg1, 1, 0
	else
		return 0, 0, 0, 0
	end
end
CoD.WaypointUtility.ShouldBypassFiltersForMinimap = function(f18_arg0, f18_arg1)
	if f18_arg0.objective[@"requiredweapon"] ~= nil and f18_arg0.objective[@"requiredweapon"] ~= "" and not Engine[@"hash_54B80DF7F86F7002"](f18_arg1, f18_arg0.objective[@"requiredweapon"]) then
		return f18_arg0.objective[@"hash_555883052FE10427"] == 1
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
		local f23_local0 = Engine[@"getpredictedclientnum"](f23_arg1)
		if f23_arg0.objective[@"hash_2D4D7F1719DFA984"] == 1 then
			return f23_local0 == Engine[@"getobjectiveentity"](f23_arg1, f23_arg0.objId)
		elseif f23_arg0.objective[0x3587AE58E18B34] == 1 then
			return Engine[@"getpredictedclientnum"](f23_arg1) == Engine[@"hash_4C43D7E71B1CA70B"](f23_arg1, f23_arg0.objId)
		elseif f23_arg0.objective[@"requiredweapon"] ~= nil and f23_arg0.objective[@"requiredweapon"] ~= "" and not Engine[@"hash_54B80DF7F86F7002"](f23_arg1, f23_arg0.objective[@"requiredweapon"]) then
			return true
		elseif f23_arg0.objective[@"hash_567F5E53382B3161"] == 1 and Engine[@"isvisibilitybitset"](f23_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) then
			return true
		elseif CoD.isCampaign and not Engine[@"isvisibilitybitset"](f23_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
			return true
		end
	end
	if CoD.SafeGetModelValue(f23_arg0:getModel(), "state") == Enum[@"objectivestate_t"][@"objst_invisible"] then
		return true
	end
	return false
end
CoD.WaypointUtility.ShouldHideMinimapIcon = function(f24_arg0, f24_arg1)
	if CoD.WaypointUtility.ShouldHideWaypointAndMinimapIcon(f24_arg0, f24_arg1) and not CoD.WaypointUtility.ShouldBypassFiltersForMinimap(f24_arg0, f24_arg1) then
		return true
	elseif f24_arg0.objective[@"hash_38113640727D2288"] == 1 then
		return Engine[@"getobjectiveteam"](f24_arg1, f24_arg0.objId) ~= Engine[@"getteamid"](f24_arg1, Engine[@"getpredictedclientnum"](f24_arg1))
	else
		return false
	end
end
CoD.WaypointUtility.ShouldHideWaypoint = function(f25_arg0, f25_arg1)
	if CoD.WaypointUtility.ShouldHideWaypointAndMinimapIcon(f25_arg0, f25_arg1) then
		return true
	elseif f25_arg0.objective then
		local f25_local0 = Engine[@"getpredictedclientnum"](f25_arg1)
		local f25_local1
		if f25_arg0.objective[@"hash_3B78F04652A4E122"] ~= 1 and f25_arg0.objective[@"hash_429FF873E6357558"] ~= 1 and f25_arg0.objective[@"hash_2D6D209C87C35EEA"] ~= 1 then
			f25_local1 = false
		else
			f25_local1 = true
		end
		if f25_local1 and Engine[@"objectiveisplayerusing"](f25_arg1, f25_arg0.objId, f25_local0) then
			local f25_local2 = Engine[@"getteamid"](f25_arg1, f25_local0)
			local f25_local3 = Engine[@"objectiveisteamusing"](f25_arg1, f25_arg0.objId, f25_local2) and Engine[@"objectiveisanyotherteamusing"](f25_arg1, f25_arg0.objId, f25_local2)
			if f25_local3 and f25_arg0.objective[@"hash_2D6D209C87C35EEA"] == 1 then
				return true
			elseif CoD.HUDUtility.IsWaypointOwnedByMyTeam(f25_arg0, f25_arg1) then
				if f25_arg0.objective[@"hash_3B78F04652A4E122"] == 1 and not f25_local3 then
					return true
				end
			elseif f25_arg0.objective[@"hash_429FF873E6357558"] == 1 and not f25_local3 then
				return true
			end
		end
		if f25_arg0.objective[@"hash_5BBC97D237FCBEA6"] == 1 then
			local f25_local2 = f25_arg0:getModel(f25_arg1, "isOffscreen")
			if f25_local2 and f25_local2:get() and CoD.WaypointUtility.IsObjectiveRequirementLabelHidden(f25_arg0, f25_arg1) then
				return true
			end
		end
		local f25_local2 = Engine[@"getmodelforcontroller"](f25_arg1)
		if Engine[@"isvisibilitybitset"](f25_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"]) or f25_local2.hudItems.hacked:get() > 0 then
			return f25_arg0.objective[@"hash_761B460B26283391"] == 1
		elseif Engine[@"isvisibilitybitset"](f25_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]) then
			return f25_arg0.objective[@"hash_729120244683F1CF"] == 1
		end
	end
	return false
end
CoD.WaypointUtility.SetupWaypointCloseShowMessageListener = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = Engine[@"getmodelforcontroller"](f26_arg2)
	f26_arg0:subscribeToModel(f26_local0:create("onWaypointClose"), function(model)
		f26_arg1:setText(model:get() or "")
		f26_arg0:playClip("ShowMessage")
	end)
end
CoD.WaypointUtility.ShowMessageOnCloseIfNeeded = function(f28_arg0, f28_arg1)
	local f28_local0 = f28_arg1.objective
	local f28_local1 = f28_local0[@"hash_3853F0A0E60B64D"]
	if f28_local1 then
		local f28_local2 = true
		if f28_local0[0x4E9883B54B9B7C] and f28_local0[0x4E9883B54B9B7C] ~= "Any" then
			f28_local2 = f28_arg1.currentState == f28_local0[0x4E9883B54B9B7C]
		end
		if f28_local2 then
			local f28_local3 = Engine[@"getmodelforcontroller"](f28_arg0)
			f28_local3 = f28_local3:create("onWaypointClose")
			if not f28_local3:set(Engine[@"localize"](f28_local1)) then
				f28_local3:forceNotifySubscriptions()
			end
		end
	end
end
CoD.WaypointUtility.GetCarryIcon = function(f29_arg0, f29_arg1)
	if not f29_arg1 or f29_arg1 == -1 then
		return "blacktransparent"
	else
		local f29_local0 = CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f29_arg0, f29_arg1))
		if f29_local0 and f29_local0[@"carryicon"] and f29_local0[@"carryicon"] ~= "" then
			return f29_local0[@"carryicon"]
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
		local f30_local1 = CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f30_arg0, f30_local0))
		return f30_local1 and f30_local1[@"hash_590212E3CB9EE11"] == 1
	end
end
CoD.WaypointUtility.GetContributedCaptureText = function(f31_arg0, f31_arg1)
	local f31_local0 = CoD.HUDUtility.GetCachedObjective(f31_arg1)
	if f31_local0 then
		return f31_local0[@"hash_12F6637F605A66D2"] or 0x0
	else
		return 0x0
	end
end
