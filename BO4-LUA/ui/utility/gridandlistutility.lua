CoD.GridAndListUtility = {}
CoD.GridAndListUtility.DoBumperGridButtonAction = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = 0
	if f1_arg0.m_disableGridNavigation then
		return false
	end
	for f1_local4, f1_local5 in ipairs(f1_arg0._BumperGrids[f1_arg2]) do
		if (not f1_local5.ignoreGamepadBumperAction or not IsGamepad(f1_arg1)) and (not f1_local5.ignoreKeyboardBumperAction or not IsKeyboard(f1_arg1) and not IsMouse(f1_arg1)) then
			if f1_local5.__hasChildFocus then
				f1_local0 = f1_local0 | LUI.GridLayout.NavigationFlags.CHANGE_FOCUS
			else
				f1_local0 = 0
			end
			if f1_arg3 then
				if not f1_local5.m_disableNavigation and f1_local5:navigateItemLeft(f1_local0) then
					if f1_arg2 == "bumpers" then
						ProcessListAction(f1_local5, f1_local5.activeWidget, f1_arg1)
					end
					if f1_local5._cycleTimer ~= nil and not f1_local5._disableAutoScrolling then
						f1_local5._skipNextAutoCycle = true
					end
					return true
				end
			end
			if not f1_local5.m_disableNavigation and f1_local5:navigateItemRight(f1_local0) then
				if f1_arg2 == "bumpers" then
					ProcessListAction(f1_local5, f1_local5.activeWidget, f1_arg1)
				end
				if f1_local5._cycleTimer ~= nil and not f1_local5._disableAutoScrolling then
					f1_local5._skipNextAutoCycle = true
				end
				return true
			end
		end
	end
	return false
end
CoD.GridAndListUtility.AddKeyboardGridTabNavigationInternal = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	f2_arg0:AddButtonCallbackFunction(f2_arg0, f2_arg2, Enum.LUIButton[@"lui_key_none"], "ui_prevtab", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		if f2_arg4 and not f2_arg4(f3_arg2) then
			return
		elseif f3_arg1.m_disableGridNavigation then
			return
		elseif not f2_arg1.m_disableNavigation and f2_arg1:navigateItemLeft() then
			f2_arg1:setActiveItem(f2_arg1.activeWidget)
			ProcessListAction(f2_arg1, f2_arg1.activeWidget, f3_arg2)
		end
		return true
	end)
	f2_arg0:AddButtonCallbackFunction(f2_arg0, f2_arg2, Enum.LUIButton[@"lui_key_none"], "ui_nexttab", function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		if f2_arg4 and not f2_arg4(f4_arg2) then
			return
		elseif f4_arg1.m_disableGridNavigation then
			return
		elseif not f2_arg1.m_disableNavigation and f2_arg1:navigateItemRight() then
			f2_arg1:setActiveItem(f2_arg1.activeWidget)
			ProcessListAction(f2_arg1, f2_arg1.activeWidget, f4_arg2)
		end
		return true
	end)
	CoD.GridAndListUtility.MakeBumperGridKeyboardNavigable(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
end
CoD.GridAndListUtility.MakeBumperGridKeyboardNavigable = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = LUI.GridLayout.NavigationFlags.CHANGE_FOCUS
	f5_arg0:AddButtonCallbackFunction(f5_arg1, f5_arg2, Enum.LUIButton[@"lui_key_none"], "ui_navleft", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		if f5_arg4 and not f5_arg4(f6_arg2) then
			return
		elseif f6_arg1.m_disableGridNavigation then
			return
		elseif not f5_arg1.m_disableNavigation and f5_arg1:navigateItemLeft(f5_local0) then
			f5_arg1:setActiveItem(f5_arg1.activeWidget)
			ProcessListAction(f5_arg1, f5_arg1.activeWidget, f6_arg2)
		end
		return true
	end)
	f5_arg0:AddButtonCallbackFunction(f5_arg1, f5_arg2, Enum.LUIButton[@"lui_key_none"], "ui_navright", function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		if f5_arg4 and not f5_arg4(f7_arg2) then
			return
		elseif f7_arg1.m_disableGridNavigation then
			return
		elseif not f5_arg1.m_disableNavigation and f5_arg1:navigateItemRight(f5_local0) then
			f5_arg1:setActiveItem(f5_arg1.activeWidget)
			ProcessListAction(f5_arg1, f5_arg1.activeWidget, f7_arg2)
		end
		return true
	end)
	CoD.PCUtility.SetListOrGridAsAcceptingFocusToActiveElement(f5_arg1)
	if not f5_arg1.__enablePCListSelectionBehavior then
		f5_arg0:AddButtonCallbackFunction(f5_arg1, f5_arg2, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
			if f5_arg4 and not f5_arg4(f8_arg2) then
				return
			elseif f8_arg1.m_disableGridNavigation then
				return
			elseif not f5_arg1.m_disableNavigation then
				f5_arg1:setActiveItem(f8_arg0)
				ProcessListAction(f5_arg1, f8_arg0, f8_arg2, f8_arg1)
				f8_arg0:playSound(f5_arg1.__bumperGridKeyboardMouseConfirmSound and f5_arg1.__bumperGridKeyboardMouseConfirmSound or "list_right", f8_arg2)
			end
			return true
		end)
	end
end
CoD.GridAndListUtility.AddGenericNavigationInternal = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5, f9_arg6, f9_arg7, f9_arg8, f9_arg9)
	if f9_arg0._BumperGrids == nil then
		f9_arg0._BumperGrids = {}
	end
	if f9_arg0._BumperGrids[f9_arg7] ~= nil and #f9_arg0._BumperGrids[f9_arg7] > 0 then
		table.insert(f9_arg0._BumperGrids[f9_arg7], f9_arg1)
	else
		f9_arg0._BumperGrids[f9_arg7] = {
			f9_arg1,
		}
		local f9_local0 = "ui_prevtab"
		if f9_arg1.__gridKeyboardNavDisabled then
			f9_local0 = nil
		end
		f9_arg0:AddButtonCallbackFunction(f9_arg0, f9_arg2, f9_arg5, f9_local0, function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
			if CoD.isPC and f10_arg0.__gridNavFrame == Engine[@"hash_4C60FB88F484616D"]() then
				return
			elseif not f9_arg8 and IsRepeatButtonPress(f10_arg3) then
				return
			end
			f10_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
			if not f9_arg1.m_disableNavigation and f9_arg3 then
				f9_arg3()
				CoD.FreeCursorUtility.RetriggerCursorPosition(f10_arg1, f10_arg2)
			end
			if f9_arg4 and not f9_arg4(f10_arg2) then
				return
			elseif f10_arg1.m_disableGridNavigation then
				return
			end
			local f10_local0 = CoD.GridAndListUtility.DoBumperGridButtonAction(f10_arg1, f10_arg2, f9_arg7, true)
			CoD.FreeCursorUtility.RetriggerCursorPosition(f10_arg1, f10_arg2)
			if f9_arg9 then
				f9_arg9()
			end
			return f10_local0
		end, AlwaysFalse, false)
		f9_local0 = "ui_nexttab"
		if f9_arg1.__gridKeyboardNavDisabled then
			f9_local0 = nil
		end
		f9_arg0:AddButtonCallbackFunction(f9_arg0, f9_arg2, f9_arg6, f9_local0, function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
			if CoD.isPC and f11_arg0.__gridNavFrame == Engine[@"hash_4C60FB88F484616D"]() then
				return
			elseif not f9_arg8 and IsRepeatButtonPress(f11_arg3) then
				return
			end
			f11_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
			if not f9_arg1.m_disableNavigation and f9_arg3 then
				f9_arg3()
				CoD.FreeCursorUtility.RetriggerCursorPosition(f11_arg1, f11_arg2)
			end
			if f9_arg4 and not f9_arg4(f11_arg2) then
				return
			elseif f11_arg1.m_disableGridNavigation then
				return
			end
			local f11_local0 = CoD.GridAndListUtility.DoBumperGridButtonAction(f11_arg1, f11_arg2, f9_arg7, false)
			CoD.FreeCursorUtility.RetriggerCursorPosition(f11_arg1, f11_arg2)
			if f9_arg9 then
				f9_arg9()
			end
			return f11_local0
		end, AlwaysFalse, false)
	end
	if CoD.isPC then
		CoD.GridAndListUtility.MakeBumperGridKeyboardNavigable(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
	end
end
CoD.GridAndListUtility.RemoveGridElementFromBumperGridType = function(f12_arg0, f12_arg1, f12_arg2)
	if not f12_arg0._BumperGrids or not f12_arg0._BumperGrids[f12_arg2] then
		return
	end
	local f12_local0 = nil
	for f12_local4, f12_local5 in ipairs(f12_arg0._BumperGrids[f12_arg2]) do
		if f12_local5 == f12_arg1 then
			f12_local0 = f12_local4
			break
		end
	end
	if f12_local0 then
		table.remove(f12_arg0._BumperGrids[f12_arg2], f12_local0)
	end
end
CoD.GridAndListUtility.AddBumperNavigationInternal = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5)
	local f13_local0 = "bumpers"
	if f13_arg5 then
		f13_local0 = f13_local0 .. "_noAction"
	end
	return CoD.GridAndListUtility.AddGenericNavigationInternal(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, Enum.LUIButton[@"lui_key_lb"], Enum.LUIButton[@"lui_key_rb"], f13_local0, true)
end
CoD.GridAndListUtility.AddTriggerNavigation = function(f14_arg0, f14_arg1, f14_arg2)
	return CoD.GridAndListUtility.AddGenericNavigationInternal(f14_arg0, f14_arg1, f14_arg2, nil, nil, Enum.LUIButton[@"lui_key_ltrig"], Enum.LUIButton[@"lui_key_rtrig"], "triggers", false)
end
CoD.GridAndListUtility.AddKeyboardGridTabNavigation = function(f15_arg0, f15_arg1, f15_arg2)
	return CoD.GridAndListUtility.AddKeyboardGridTabNavigationInternal(f15_arg0, f15_arg1, f15_arg2, nil, nil)
end
CoD.GridAndListUtility.AddBumperNavigationDontProcessAction = function(f16_arg0, f16_arg1, f16_arg2)
	CoD.GridAndListUtility.AddBumperNavigationInternal(f16_arg0, f16_arg1, f16_arg2, nil, nil, true)
end
CoD.GridAndListUtility.AddBumperNavigation = function(f17_arg0, f17_arg1, f17_arg2)
	CoD.GridAndListUtility.AddBumperNavigationInternal(f17_arg0, f17_arg1, f17_arg2, nil)
end
CoD.GridAndListUtility.AddHostOnlyBumperNavigation = function(f18_arg0, f18_arg1, f18_arg2)
	CoD.GridAndListUtility.AddBumperNavigationInternal(f18_arg0, f18_arg1, f18_arg2, nil, function(f19_arg0)
		local f19_local0 = LobbyData.GetCurrentMenuTarget()
		local f19_local1 = IsLobbyHostOfCurrentMenu()
		if f19_local1 then
			if CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) or f19_local0.name == LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY then
				f19_local1 = false
			else
				f19_local1 = true
			end
		end
		return f19_local1
	end)
end
CoD.GridAndListUtility.AddOptionsBumperNavigation = function(f20_arg0, f20_arg1, f20_arg2)
	if f20_arg0._BumperGrids ~= nil then
		table.insert(f20_arg0._BumperGrids, f20_arg1)
	else
		f20_arg0._BumperGrids = {
			f20_arg1,
		}
		f20_arg0:AddButtonCallbackFunction(f20_arg0, f20_arg2, Enum.LUIButton[@"lui_key_lb"], "ui_prevtab", function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
			if CoD.isPC and f21_arg0.__gridNavFrame == Engine[@"hash_4C60FB88F484616D"]() then
				return
			elseif CoD.PCOptionsUtility.AreOptionsDirty(f21_arg2) and CoD.PCOptionsUtility.IsGraphicsOptions(f21_arg2) then
				CoD.OverlayUtility.CreateOverlay(f21_arg2, f21_arg1, "PendingChangesOnQuitOptionsMenu", function()
					f21_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
					CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, -1)
				end)
			else
				f21_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
				CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, -1)
			end
			return true
		end)
		f20_arg0:AddButtonCallbackFunction(f20_arg0, f20_arg2, Enum.LUIButton[@"lui_key_rb"], "ui_nexttab", function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
			if CoD.isPC and f23_arg0.__gridNavFrame == Engine[@"hash_4C60FB88F484616D"]() then
				return
			elseif CoD.PCOptionsUtility.AreOptionsDirty(f23_arg2) and CoD.PCOptionsUtility.IsGraphicsOptions(f23_arg2) then
				CoD.OverlayUtility.CreateOverlay(f23_arg2, f23_arg1, "PendingChangesOnQuitOptionsMenu", function()
					f23_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
					CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, 1)
				end)
			else
				f23_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
				CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, 1)
			end
			return true
		end)
	end
	f20_arg0:AddButtonCallbackFunction(f20_arg1, f20_arg2, Enum.LUIButton[@"lui_key_none"], "ui_navleft", function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
		if CoD.isPC and f25_arg0.__gridNavFrame == Engine[@"hash_4C60FB88F484616D"]() then
			return
		elseif CoD.PCOptionsUtility.AreOptionsDirty(f25_arg2) and CoD.PCOptionsUtility.IsGraphicsOptions(f25_arg2) then
			CoD.OverlayUtility.CreateOverlay(f25_arg2, f25_arg1, "PendingChangesOnQuitOptionsMenu", function()
				f25_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
				CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, -1)
			end)
		else
			f25_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
			CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, -1)
		end
		return true
	end)
	f20_arg0:AddButtonCallbackFunction(f20_arg1, f20_arg2, Enum.LUIButton[@"lui_key_none"], "ui_navright", function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		if CoD.isPC and f27_arg0.__gridNavFrame == Engine[@"hash_4C60FB88F484616D"]() then
			return
		elseif CoD.PCOptionsUtility.AreOptionsDirty(f27_arg2) and CoD.PCOptionsUtility.IsGraphicsOptions(f27_arg2) then
			CoD.OverlayUtility.CreateOverlay(f27_arg2, f27_arg1, "PendingChangesOnQuitOptionsMenu", function()
				f27_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
				CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, 1)
			end)
		else
			f27_arg0.__gridNavFrame = Engine[@"hash_4C60FB88F484616D"]()
			CoD.GridAndListUtility.ActivateNextOptionTab(f20_arg1, 1)
		end
		return true
	end)
	f20_arg0:AddButtonCallbackFunction(f20_arg1, f20_arg2, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
		if not f20_arg1.m_disableNavigation and f20_arg1.activeWidget ~= f29_arg0 then
			if CoD.PCOptionsUtility.AreOptionsDirty(f29_arg2) and CoD.PCOptionsUtility.IsGraphicsOptions(f29_arg2) then
				CoD.OverlayUtility.CreateOverlay(f29_arg2, f29_arg1, "PendingChangesOnQuitOptionsMenu", function()
					f20_arg1:setActiveItem(f29_arg0)
					f20_arg1:playSound("list_right")
					ProcessListAction(f20_arg1, f29_arg0, f29_arg2, f29_arg1)
				end)
			else
				f20_arg1:setActiveItem(f29_arg0)
				f20_arg1:playSound("list_right")
				ProcessListAction(f20_arg1, f29_arg0, f29_arg2, f29_arg1)
			end
		end
		return true
	end)
end
CoD.GridAndListUtility.ActivateNextOptionTab = function(f31_arg0, f31_arg1)
	local f31_local0 = f31_arg0.activeWidget and f31_arg0.activeWidget.gridInfoTable.gridColIndex or 1
	local f31_local1 = 1
	local f31_local2 = nil
	while not f31_local2 do
		f31_local0 = (f31_local0 + f31_arg1) % (f31_arg0.requestedColumnCount + 1)
		local f31_local3 = f31_arg0:getItemAtPosition(f31_local1, f31_local0, true)
		if f31_local3 and not CoD.PCUtility.IsUnavailable(f31_local3, f31_arg0.controller) then
			f31_local2 = f31_local3
		end
	end
	f31_arg0:setActiveItem(f31_local2)
	local f31_local4 = f31_arg0
	local f31_local3 = f31_arg0.playSound
	local f31_local5
	if f31_arg1 > 0 then
		f31_local5 = "list_right"
		if not f31_local5 then
		else
			f31_local3(f31_local4, f31_local5)
		end
	end
	f31_local5 = "list_left"
end
CoD.GridAndListUtility.AddBumperPaging = function(f32_arg0, f32_arg1, f32_arg2)
	f32_arg1:AddBumperPaging(f32_arg0, f32_arg2)
end
CoD.GridAndListUtility.SetGridIgnoreGamepadBumperAction = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3)
	f33_arg1.ignoreGamepadBumperAction = f33_arg3
end
CoD.GridAndListUtility.SetGridIgnoreKeyboardBumperAction = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
	f34_arg1.ignoreKeyboardBumperAction = f34_arg3
end
CoD.GridAndListUtility.SetBumperGridKeyboardMouseConfirmSound = function(f35_arg0, f35_arg1)
	f35_arg0.__bumperGridKeyboardMouseConfirmSound = f35_arg1
end
CoD.GridAndListUtility.HideSubListIfParentListIsEmpty = function(f36_arg0, f36_arg1, f36_arg2)
	if f36_arg0:getModel() then
		f36_arg1:setAlpha(1)
	else
		f36_arg1:setAlpha(0)
	end
end
CoD.GridAndListUtility.AddRightStickSingleItemControl = function(f37_arg0, f37_arg1, f37_arg2)
	local f37_local0 = f37_arg1
	if IsFreeCursorActive(f37_arg2) then
		f37_arg0:AddButtonCallbackFunction(f37_local0, f37_arg2, Enum.LUIButton[@"lui_key_left"], nil, function(f38_arg0, f38_arg1, f38_arg2, f38_arg3)
			if IsFreeCursorActive(f38_arg2) and not IsDpadButton(f38_arg3) and not PropertyIsTrue(f37_local0, "m_disableNavigation") then
				f37_local0:navigateItemLeft()
				if ScoreboardVisible(f38_arg2) then
					BlockGameFromKeyEvent(f38_arg2)
				end
			end
		end, AlwaysFalse, false)
		f37_arg0:AddButtonCallbackFunction(f37_local0, f37_arg2, Enum.LUIButton[@"lui_key_right"], nil, function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
			if IsFreeCursorActive(f39_arg2) and not IsDpadButton(f39_arg3) and not PropertyIsTrue(f37_local0, "m_disableNavigation") then
				f37_local0:navigateItemRight()
				if ScoreboardVisible(f39_arg2) then
					BlockGameFromKeyEvent(f39_arg2)
				end
			end
		end, AlwaysFalse, false)
	end
end
CoD.GridAndListUtility.AddGlobalRightStickSingleItemControl = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	local f40_local0 = f40_arg1
	if IsFreeCursorActive(f40_arg2) then
		f40_arg0:AddButtonCallbackFunction(f40_arg0, f40_arg2, Enum.LUIButton[@"lui_key_left"], nil, function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
			if IsFreeCursorActive(f41_arg2) and not IsDpadButton(f41_arg3) and not PropertyIsTrue(f40_local0, "m_disableNavigation") then
				f40_local0:navigateItemLeft()
				if ScoreboardVisible(f41_arg2) then
					BlockGameFromKeyEvent(f41_arg2)
				end
			end
		end, AlwaysFalse, false)
		f40_arg0:AddButtonCallbackFunction(f40_arg0, f40_arg2, Enum.LUIButton[@"lui_key_right"], nil, function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
			if IsFreeCursorActive(f42_arg2) and not IsDpadButton(f42_arg3) and not PropertyIsTrue(f40_local0, "m_disableNavigation") then
				f40_local0:navigateItemRight()
				if ScoreboardVisible(f42_arg2) then
					BlockGameFromKeyEvent(f42_arg2)
				end
			end
		end, AlwaysFalse, false)
		f40_arg0:AddButtonCallbackFunction(f40_arg0, f40_arg2, Enum.LUIButton[@"lui_key_up"], nil, function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
			if IsFreeCursorActive(f43_arg2) and not IsDpadButton(f43_arg3) and not PropertyIsTrue(f40_local0, "m_disableNavigation") then
				f40_local0:navigateItemUp()
				if ScoreboardVisible(f43_arg2) then
					BlockGameFromKeyEvent(f43_arg2)
				end
			end
		end, AlwaysFalse, false)
		f40_arg0:AddButtonCallbackFunction(f40_arg0, f40_arg2, Enum.LUIButton[@"lui_key_down"], nil, function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
			if IsFreeCursorActive(f44_arg2) and not IsDpadButton(f44_arg3) and not PropertyIsTrue(f40_local0, "m_disableNavigation") then
				f40_local0:navigateItemDown()
				if ScoreboardVisible(f44_arg2) then
					BlockGameFromKeyEvent(f44_arg2)
				end
			end
		end, AlwaysFalse, false)
	end
	if f40_arg3 and IsPC() then
		CoD.GridAndListUtility.AddBumperNavigationInternal(f40_arg0, f40_arg1, f40_arg2, nil)
	end
end
CoD.GridAndListUtility.AddListUpDownNavigation = function(f45_arg0, f45_arg1, f45_arg2)
	if IsFreeCursorActive(f45_arg2) then
		f45_arg1:addUpDownNavigation(f45_arg0, f45_arg2)
	end
end
CoD.GridAndListUtility.AddListLeftRightNavigation = function(f46_arg0, f46_arg1, f46_arg2)
	if IsFreeCursorActive(f46_arg2) then
		f46_arg1:addLeftRightNavigation(f46_arg0, f46_arg2)
	end
end
CoD.GridAndListUtility.AddActiveLeftRightNavigation = function(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
	f47_arg1:addLeftRightActiveNavigation(f47_arg0, f47_arg2, f47_arg3)
end
CoD.GridAndListUtility.AddActiveUpDownNavigation = function(f48_arg0, f48_arg1, f48_arg2)
	f48_arg1:addUpDownActiveNavigation(f48_arg0, f48_arg2)
end
CoD.GridAndListUtility.NavigateGridItem = function(f49_arg0, f49_arg1, f49_arg2)
	if f49_arg2 then
		f49_arg0:navigateItemRight()
	else
		f49_arg0:navigateItemLeft()
	end
	if not f49_arg0._disableAutoScrolling then
		f49_arg0._skipNextAutoCycle = true
	end
end
CoD.GridAndListUtility.NavigateGridItemInChild = function(f50_arg0, f50_arg1, f50_arg2, f50_arg3)
	CoD.GridAndListUtility.NavigateGridItem(f50_arg0[f50_arg2], f50_arg1, f50_arg3)
end
CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList = function(f51_arg0, f51_arg1, f51_arg2)
	local f51_local0 = f51_arg0
	local f51_local1 = f51_arg0.gridInfoTable
	if f51_local1 then
		f51_local1 = f51_local0 and f51_arg0.gridInfoTable.parentGrid
	end
	if f51_local1 == nil then
		f51_local1 = f51_arg0 and f51_arg0.listWidget
	end
	if f51_local1 then
		local f51_local2 = 0
		if f51_local1.__hasChildFocus then
			f51_local2 = LUI.GridLayout.NavigationFlags.CHANGE_FOCUS
		end
		if f51_arg2 then
			f51_local1:navigateItemRight(f51_local2)
		else
			f51_local1:navigateItemLeft(f51_local2)
		end
		if not f51_local1._disableAutoScrolling then
			f51_local1._skipNextAutoCycle = true
		end
	end
end
CoD.GridAndListUtility.DisableAutoScrolling = function(f52_arg0, f52_arg1)
	f52_arg1._disableAutoScrolling = true
end
CoD.GridAndListUtility.ReEnableAutoScrolling = function(f53_arg0, f53_arg1)
	f53_arg1._disableAutoScrolling = nil
end
CoD.GridAndListUtility.CycleThroughItems = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3)
	f54_arg2._cycleTimer = LUI.UITimer.newElementTimer(f54_arg3 * 1000, false, function(f55_arg0)
		if f54_arg2._disableAutoScrolling then
		elseif f54_arg2._skipNextAutoCycle then
			f54_arg2._skipNextAutoCycle = nil
		else
			if f54_arg2.activeWidget == nil then
				f54_arg2.activeWidget = f54_arg2:getItemAtPosition(1, 1, false)
			end
			f54_arg2:navigateItemRight(nil, true)
			f54_arg2:addElement(LUI.UITimer.newElementTimer(30, true, function(f56_arg0)
				CoD.FreeCursorUtility.RetriggerCursorPosition(f54_arg0, f54_arg1)
			end))
		end
	end)
	f54_arg2._disableAutoScrolling = false
	f54_arg2:addElement(f54_arg2._cycleTimer)
end
CoD.GridAndListUtility.DisableKeyboardNavigationOnGridCounters = function(f57_arg0)
	if f57_arg0 then
		if f57_arg0.verticalCounter then
			DisableKeyboardNavigationByElement(f57_arg0.verticalCounter)
		end
		if f57_arg0.horizontalCounter then
			DisableKeyboardNavigationByElement(f57_arg0.horizontalCounter)
		end
	end
end
CoD.GridAndListUtility.SetHorizontalCounterPadding = function(f58_arg0, f58_arg1)
	if f58_arg0.horizontalCounter then
		f58_arg0.horizontalCounter:setTopBottom(1, 1, f58_arg1, f58_arg1 + f58_arg0.horizontalCounter.__defaultHeight)
	end
end
CoD.GridAndListUtility.KeepSelectedItemsInSync = function(f59_arg0, f59_arg1, f59_arg2)
	local f59_local0 = f59_arg0[f59_arg1]
	local f59_local1 = f59_arg0[f59_arg2]
	LUI.OverrideFunction_CallOriginalFirst(f59_local0, "setActiveItem", function(element, controller, f60_arg2)
		if element.savedActiveIndex and element.hasListFocus then
			f59_local1.savedActiveIndex = math.min(f59_local1.requestedRowCount * f59_local1.requestedColumnCount - 1, element.savedActiveIndex)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(f59_local1, "setActiveItem", function(element, controller, f61_arg2)
		if element.savedActiveIndex and element.hasListFocus then
			f59_local0.savedActiveIndex = math.min(f59_local0.requestedRowCount * f59_local0.requestedColumnCount - 1, element.savedActiveIndex)
		end
	end)
end
CoD.GridAndListUtility.AlignElementToListItem = function(f62_arg0, f62_arg1, f62_arg2)
	local f62_local0, f62_local1, f62_local2, f62_local3 = f62_arg1:getLocalLeftRight()
	local f62_local4 = f62_arg1:getParent()
	f62_local4 = f62_local4:getParent()
	local f62_local4, f62_local5, f62_local6, f62_local7 = f62_local4:getLocalLeftRight()
	f62_arg2:setLeftRight(f62_local0 + f62_local4, f62_local1 + f62_local5, f62_local2 + f62_local6, f62_local3 + f62_local6)
end
CoD.GridAndListUtility.AlignElementToListItem2D = function(f63_arg0, f63_arg1, f63_arg2)
	local f63_local0, f63_local1, f63_local2, f63_local3 = f63_arg1:getLocalLeftRight()
	local f63_local4 = f63_arg1:getParent()
	f63_local4 = f63_local4:getParent()
	local f63_local4, f63_local5, f63_local6, f63_local7 = f63_local4:getLocalLeftRight()
	f63_arg2:setLeftRight(f63_local0 + f63_local4, f63_local1 + f63_local5, f63_local2 + f63_local6, f63_local3 + f63_local6)
	local f63_local8, f63_local9, f63_local10, f63_local11 = f63_arg1:getLocalTopBottom()
	local f63_local12 = f63_arg1:getParent()
	f63_local12 = f63_local12:getParent()
	local f63_local12, f63_local13, f63_local14, f63_local15 = f63_local12:getLocalTopBottom()
	f63_arg2:setTopBottom(f63_local8 + f63_local12, f63_local9 + f63_local13, f63_local10 + f63_local14, f63_local11 + f63_local14)
end
CoD.GridAndListUtility.AlignElementToListItem2D_NextRect = function(f64_arg0, f64_arg1, f64_arg2)
	if not f64_arg1.getNextLocalLeftRight then
		CoD.GridAndListUtility.AlignElementToListItem2D(f64_arg0, f64_arg1, f64_arg2)
		return
	else
		local f64_local0, f64_local1, f64_local2, f64_local3 = f64_arg1:getNextLocalLeftRight()
		local f64_local4 = f64_arg1:getParent()
		f64_local4 = f64_local4:getParent()
		local f64_local4, f64_local5, f64_local6, f64_local7 = f64_local4:getNextLocalLeftRight()
		f64_arg2:setLeftRight(f64_local0 + f64_local4, f64_local1 + f64_local5, f64_local2 + f64_local6, f64_local3 + f64_local6)
		local f64_local8, f64_local9, f64_local10, f64_local11 = f64_arg1:getNextLocalTopBottom()
		local f64_local12 = f64_arg1:getParent()
		f64_local12 = f64_local12:getParent()
		local f64_local12, f64_local13, f64_local14, f64_local15 = f64_local12:getNextLocalTopBottom()
		f64_arg2:setTopBottom(f64_local8 + f64_local12, f64_local9 + f64_local13, f64_local10 + f64_local14, f64_local11 + f64_local14)
	end
end
CoD.GridAndListUtility.KeepSelectedItemCentered = function(f65_arg0, f65_arg1)
	f65_arg0.__centerActiveWidget = f65_arg1
end
CoD.GridAndListUtility.GetListSortModelValues = function(f66_arg0, f66_arg1, f66_arg2)
	local f66_local0 = f66_arg1
	local f66_local1 = {}
	local f66_local2 = f66_local0:getDataSource()
	if f66_local2 then
		for f66_local3 = 1, f66_local2.getCount(f66_local0), 1 do
			local f66_local6 = f66_local2.getItem(f66_arg0, f66_local0, f66_local3)
			local f66_local7 = f66_local6 and f66_local6[f66_local0["_sortByModel" .. f66_arg2]]
			local f66_local8
			if f66_local7 then
				f66_local8 = f66_local7:get()
				if not f66_local8 then
				else
					f66_local1[f66_local3] = f66_local8
				end
			end
			f66_local8 = 0
		end
	end
	return f66_local1
end
CoD.GridAndListUtility.DataSourceSortOrderChanged = function(f67_arg0, f67_arg1, f67_arg2)
	local f67_local0 = f67_arg1
	local f67_local1 = false
	local f67_local2 = CoD.GridAndListUtility.GetListSortModelValues(f67_arg0, f67_local0, f67_arg2)
	if #f67_local2 > 0 then
		local f67_local3 = f67_local2[1]
		for f67_local7, f67_local8 in ipairs(f67_local2) do
			if f67_local3 < f67_local8 then
				return true
			end
			f67_local3 = f67_local8
		end
	end
	return false
end
CoD.GridAndListUtility.UpdateDataSource = function(f68_arg0, f68_arg1, f68_arg2, f68_arg3)
	f68_arg0:updateDataSource(not f68_arg1, not f68_arg2, not f68_arg3)
end
CoD.GridAndListUtility.UpdateLayoutForList = function(f69_arg0)
	local f69_local0 = f69_arg0:getParent()
	if f69_local0 then
		f69_local0 = f69_local0:getParent()
	end
	if f69_local0 then
		f69_local0:updateLayout(0)
	end
end
CoD.GridAndListUtility.SetupListSortSubscription = function(f70_arg0, f70_arg1, f70_arg2, f70_arg3)
	local f70_local0 = Engine.GetModelForController(f70_arg1)
	local f70_local1 = f70_local0[f70_arg2]
	if not f70_arg0._sortPathSubscriptions then
		f70_arg0._sortPathSubscriptions = {}
	end
	if f70_arg0._sortPathSubscriptions[f70_arg3] then
		f70_arg0:removeSubscription(f70_arg0._sortPathSubscriptions[f70_arg3])
		f70_arg0._sortPathSubscriptions[f70_arg3] = nil
	end
	if f70_local1 then
		f70_arg0._sortPathSubscriptions[f70_arg3] = f70_arg0:subscribeToModel(f70_local1, function()
			f70_arg0["_sortByModel" .. f70_arg3] = f70_local1 and f70_local1:get() or nil
			f70_arg0:updateDataSource()
		end)
	end
end
CoD.GridAndListUtility.SortListByControllerModelKeys = function(f72_arg0, f72_arg1, f72_arg2, f72_arg3, f72_arg4)
	CoD.GridAndListUtility.SetupListSortSubscription(f72_arg1, f72_arg0, f72_arg2, "Primary")
	CoD.GridAndListUtility.SetupListSortSubscription(f72_arg1, f72_arg0, f72_arg3, "Secondary")
	CoD.GridAndListUtility.SetupListSortSubscription(f72_arg1, f72_arg0, f72_arg4, "Tertiary")
end
CoD.GridAndListUtility.ResetCurrentRowAndColumn = function(f73_arg0)
	f73_arg0:resetCurrentRowAndColumn()
end
CoD.GridAndListUtility.SetFocusToFirstSelectableItem = function(f74_arg0)
	f74_arg0:getFirstSelectableItem(true)
end
CoD.GridAndListUtility.SelectNextItemOrPrevious = function(f75_arg0)
	local f75_local0 = f75_arg0.itemCount
	local f75_local1 = (f75_arg0.savedActiveIndex or 0) + 1
	if f75_arg0.savedActiveIndex == f75_local0 - 1 then
		f75_local1 = f75_arg0.savedActiveIndex - 1
	end
	local f75_local2 = f75_arg0:getItemAtPosition(1, f75_local1 + 1, false)
	if f75_local2 then
		f75_arg0._currentSelectionId = CoD.SafeGetModelValue(f75_local2:getModel(), "id")
		f75_arg0:setActiveItem(f75_local2)
	end
end
CoD.GridAndListUtility.SetFocusToRowAndColumn = function(f76_arg0, f76_arg1, f76_arg2)
	local f76_local0 = f76_arg0:getItemAtPosition(f76_arg1, f76_arg2, true)
	if f76_local0 and f76_arg0:isWidgetSelectable(f76_local0) then
		f76_arg0:setActiveItem(f76_local0)
	end
end
CoD.GridAndListUtility.UpdateWidthInListFunc = function(f77_arg0, f77_arg1, f77_arg2, f77_arg3, f77_arg4)
	f77_arg0.getWidthInList = function(f78_arg0, f78_arg1)
		local f78_local0 = nil
		if f78_arg0.currentState == f77_arg1 then
			f78_local0 = f77_arg2:getTextWidth()
		else
			f78_local0 = f77_arg3:getTextWidth()
		end
		return f78_local0 + f77_arg4
	end
	f77_arg0:setHandleMouse(true)
end
CoD.GridAndListUtility.SetVerticalScrollbar = function(f79_arg0, f79_arg1)
	f79_arg0:setVerticalScrollbar(CoD[f79_arg1])
end
DataSources.PipWidgets = {
	prepare = function() end,
	getCount = function(f81_arg0)
		return f81_arg0._parentItemCount
	end,
	getItem = function()
		return nil
	end,
}
CoD.GridAndListUtility.ReplayStaggeredIntro = function(f83_arg0)
	f83_arg0:playStaggeredIntro()
end
CoD.GridAndListUtility.PlayClipWithDelayBetweenElements = function(f84_arg0, f84_arg1, f84_arg2, f84_arg3)
	local f84_local0 = f84_arg2
	if f84_arg0.gridInfoTable and f84_arg0.gridInfoTable.parentGrid then
		for f84_local4, f84_local5, f84_local6 in f84_arg0.gridInfoTable.parentGrid:forEachElement() do
			f84_local6:addElement(LUI.UITimer.newElementTimer(f84_local0, true, function()
				f84_local6:playClip(f84_arg1)
			end))
			f84_local0 = f84_local0 + f84_arg3
		end
	end
end
CoD.GridAndListUtility.SetGridScrolling = function(f86_arg0, f86_arg1, f86_arg2)
	if CoD.isPC then
		CoD.Menu.AddButtonCallbackFunction(f86_arg0, f86_arg1, f86_arg2, Enum.LUIButton[@"lui_key_pckey_mwheelup"], "MWHEELUP", function(f87_arg0)
			if not f86_arg1.m_disableNavigation then
				return f86_arg1:scrollUp()
			else
			end
		end)
		CoD.Menu.AddButtonCallbackFunction(f86_arg0, f86_arg1, f86_arg2, Enum.LUIButton[@"lui_key_pckey_mwheeldown"], "MWHEELDOWN", function(f88_arg0)
			if not f86_arg1.m_disableNavigation then
				return f86_arg1:scrollDown()
			else
			end
		end)
	end
end
CoD.GridAndListUtility.RefreshActiveItem = function(f89_arg0)
	if f89_arg0 then
		f89_arg0:setActiveItem(f89_arg0.activeWidget)
	end
end
CoD.GridAndListUtility.DoBumperGridButton = function(f90_arg0, f90_arg1, f90_arg2)
	CoD.GridAndListUtility.DoBumperGridButtonAction(f90_arg0, f90_arg1, "bumpers", f90_arg2)
end
CoD.GridAndListUtility.ValidateActiveItemVisibility = function(f91_arg0)
	f91_arg0:validateActiveItemVisibility()
end
CoD.GridAndListUtility.ScrollUp = function(f92_arg0)
	f92_arg0:scrollUp()
end
CoD.GridAndListUtility.ScrollDown = function(f93_arg0)
	f93_arg0:scrollDown()
end
CoD.GridAndListUtility.ScrollLeft = function(f94_arg0)
	f94_arg0:scrollLeft()
end
CoD.GridAndListUtility.ScrollRight = function(f95_arg0)
	f95_arg0:scrollRight()
end
CoD.GridAndListUtility.MakeStencilAutoScaleWidth = function(f96_arg0)
	LUI.GridLayout.MakeStencilAutoScaleWidth(f96_arg0)
end
CoD.GridAndListUtility.ActivateListPCSelectionBehavior = function(f97_arg0)
	if CoD.isPC then
		CoD.PCUtility.ActivateListPCSelectionBehavior(f97_arg0)
	end
end
CoD.GridAndListUtility.SetListActiveOnFocusPCBehavior = function(f98_arg0, f98_arg1)
	if not CoD.isPC then
		return
	elseif IsMouseOrKeyboard(f98_arg1) then
		CoD.GridAndListUtility.DisableListActiveOnFocus(f98_arg0)
	else
		CoD.GridAndListUtility.EnableListActiveOnFocus(f98_arg0)
	end
end
CoD.GridAndListUtility.EnableListActiveOnFocus = function(f99_arg0)
	f99_arg0.__disableActiveOnFocus = nil
end
CoD.GridAndListUtility.DisableListActiveOnFocus = function(f100_arg0)
	f100_arg0.__disableActiveOnFocus = true
end
CoD.GridAndListUtility.SetFocusableBackingWidgetOnPC = function(f101_arg0)
	if CoD.isPC then
		f101_arg0.__focusableBackingWidget = true
		f101_arg0:setBackingWidget(CoD.emptyFocusableNoCursorUpdate)
	end
end
CoD.GridAndListUtility.RemoveVerticalCounter = function(f102_arg0, f102_arg1)
	f102_arg1:setVerticalCounter(nil)
end
CoD.GridAndListUtility.RemoveHorizontalCounter = function(f103_arg0, f103_arg1)
	f103_arg1:setHorizontalCounter(nil)
end
CoD.GridAndListUtility.RemoveVerticalScrollbar = function(f104_arg0, f104_arg1)
	f104_arg1:setVerticalScrollbar(nil)
end
CoD.GridAndListUtility.RemoveHorizontalScrollbar = function(f105_arg0, f105_arg1)
	f105_arg1:setHorizontalScrollbar(nil)
end
CoD.GridAndListUtility.HideScrollbarsForGamepad = function(f106_arg0, f106_arg1, f106_arg2)
	local f106_local0 = function(f107_arg0, f107_arg1)
		if IsGamepad(f107_arg0) then
			if f107_arg1.verticalScrollbar then
				HideWidget(f107_arg1.verticalScrollbar)
			end
			if f107_arg1.horizontalScrollbar then
				HideWidget(f107_arg1.horizontalScrollbar)
			end
		else
			if f107_arg1.verticalScrollbar then
				ShowWidget(f107_arg1.verticalScrollbar)
			end
			if f107_arg1.horizontalScrollbar then
				ShowWidget(f107_arg1.horizontalScrollbar)
			end
		end
	end
	f106_arg2:appendEventHandler("input_source_changed", function(f108_arg0, f108_arg1)
		f106_local0(f106_arg1, f108_arg0)
	end)
	local f106_local1 = f106_arg2
	local f106_local2 = f106_arg2.subscribeToModel
	local f106_local3 = Engine.GetModelForController(f106_arg1)
	f106_local2(f106_local1, f106_local3.LastInput, function(f109_arg0)
		f106_local0(f106_arg1, f106_arg2)
	end, false)
	f106_local0(f106_arg1, f106_arg2)
end
CoD.GridAndListUtility.SetupDraggableScrollbar = function(f110_arg0, f110_arg1, f110_arg2, f110_arg3)
	if CoD.isPC and f110_arg1.slider then
		f110_arg1.slider:setHandleMouse(true)
		local f110_local0 = 0
		local f110_local1 = 0
		local f110_local2 = function(f111_arg0)
			local f111_local0, f111_local1, f111_local2, f111_local3 = f110_arg1:getRect()
			if f110_arg3 then
				return LUI.clamp((f111_arg0 - f111_local1) / (f111_local3 - f111_local1), 0, 1)
			else
				return LUI.clamp((f111_arg0 - f111_local0) / (f111_local2 - f111_local0), 0, 1)
			end
		end
		local f110_local3 = function(f112_arg0, f112_arg1)
			f110_arg0:CaptureMouseAndLockFocus(f110_arg2, f112_arg0)
			SetProperty(f110_arg0, "preserveLuiButton", {
				[Enum.LUIButton[@"lui_key_xba_pscross"]] = true,
			})
			SetProperty(f110_arg0, "preserveLuiButton", {
				ui_confirm = true,
			})
			SetProperty(f110_arg0, "preserveLuiButton", {
				MOUSE1 = true,
			})
			f112_arg0.__lockedFocus = true
			if f110_arg3 then
				f110_local0 = f110_arg1.listWidget:getCurrentRowPercentage()
				f110_local1 = f110_local2(f112_arg1.y)
			else
				f110_local0 = f110_arg1.listWidget:getCurrentColumnPercentage()
				f110_local1 = f110_local2(f112_arg1.x)
			end
		end
		local f110_local4 = function(f113_arg0)
			if f113_arg0.__lockedFocus then
				if f110_arg0:GetLockedFocusElement() == f113_arg0 then
					f110_arg0:CaptureMouseAndLockFocus(f110_arg2, nil)
				end
				SetProperty(f110_arg0, "preserveLuiButton", {
					[Enum.LUIButton[@"lui_key_xba_pscross"]] = nil,
				})
				SetProperty(f110_arg0, "preserveLuiButton", {
					ui_confirm = nil,
				})
				SetProperty(f110_arg0, "preserveLuiButton", {
					MOUSE1 = nil,
				})
				f113_arg0.__lockedFocus = false
			end
		end
		local f110_local5 = function(f114_arg0, f114_arg1)
			if f114_arg0.__lockedFocus then
				f110_local4(f114_arg0)
				SetLoseFocusToSelf(f114_arg0, f110_arg2)
			end
		end
		local f110_local6 = function(f115_arg0, f115_arg1)
			local f115_local0 = f110_arg1.listWidget
			if f115_local0 and f115_arg0.__lockedFocus then
				local f115_local1 = LUI.clamp(f110_local0 + f110_local2(f110_arg3 and f115_arg1.y or f115_arg1.x) - f110_local1, 0, 1)
				if f110_arg3 then
					f115_local0:updateLayoutBasedOnVScrollbarPercentage(f115_local1)
				else
					f115_local0:updateLayoutBasedOnHScrollbarPercentage(f115_local1)
				end
			end
		end
		f110_arg1.slider:registerEventHandler("leftmousedown", f110_local3)
		f110_arg1.slider:registerEventHandler("leftmouseup", f110_local5)
		f110_arg1.slider:registerEventHandler("leftmousedrag", f110_local6)
		f110_arg1.slider:registerEventHandler("lose_focus", f110_local4)
		f110_arg1.slider:registerEventHandler("mouse_capture_lost", f110_local4)
		LUI.OverrideFunction_CallOriginalSecond(f110_arg1.slider, "close", f110_local4)
	end
end
CoD.GridAndListUtility.UpdateStateOnGridLayoutUpdate = function(f116_arg0, f116_arg1, f116_arg2)
	LUI.OverrideFunction_CallOriginalFirst(f116_arg2, "updateLayout", function(element)
		UpdateSelfState(f116_arg1, f116_arg0)
	end)
end
CoD.GridAndListUtility.ListElementHasAtLeastNumElements = function(f118_arg0, f118_arg1)
	if f118_arg0 and f118_arg0.getDataSource then
		local f118_local0 = f118_arg0:getDataSource()
		if f118_local0 then
			return f118_arg1 <= f118_local0.getCount(f118_arg0)
		end
	end
	return false
end
CoD.GridAndListUtility.IsElementWithinIndexOfActiveElement = function(f119_arg0, f119_arg1)
	if f119_arg0.gridInfoTable and f119_arg0.gridInfoTable.parentGrid then
		local f119_local0 = f119_arg0.gridInfoTable.parentGrid.activeWidget
		if f119_local0 and f119_local0.gridInfoTable then
			return math.abs(f119_arg0.gridInfoTable.zeroBasedIndex - f119_local0.gridInfoTable.zeroBasedIndex) <= f119_arg1
		end
	end
	return false
end
CoD.GridAndListUtility.IsActiveElementWithinIndexOfFirstElement = function(f120_arg0, f120_arg1)
	local f120_local0 = f120_arg0.activeWidget
	if f120_local0 and f120_local0.gridInfoTable then
		local f120_local1 = f120_arg0:getFirstSelectableItem()
		if f120_local1 and f120_local1.gridInfoTable then
			return math.abs(f120_local0.gridInfoTable.zeroBasedIndex - f120_local1.gridInfoTable.zeroBasedIndex) <= f120_arg1
		end
	end
	return false
end
CoD.GridAndListUtility.IsActiveElementWithinIndexOfLastElement = function(f121_arg0, f121_arg1)
	local f121_local0 = f121_arg0.activeWidget
	if f121_local0 and f121_local0.gridInfoTable then
		local f121_local1 = f121_arg0:getLastSelectableItem()
		if f121_local1 and f121_local1.gridInfoTable then
			return math.abs(f121_local0.gridInfoTable.zeroBasedIndex - f121_local1.gridInfoTable.zeroBasedIndex) <= f121_arg1
		end
	end
	return false
end
CoD.GridAndListUtility.IsLastElementInGrid = function(f122_arg0)
	if f122_arg0.gridInfoTable and f122_arg0:getParent() then
		local f122_local0 = f122_arg0:getParent()
		if not f122_local0:getParent() then
		else
			f122_local0 = f122_arg0.gridInfoTable.zeroBasedIndex
			local f122_local1 = f122_arg0:getParent()
			f122_local1 = f122_local1:getParent()
			return f122_local0 == f122_local1.itemCount - 1
		end
	end
	return false
end
CoD.GridAndListUtility.IsElementAtRowIndex = function(f123_arg0, f123_arg1)
	if not f123_arg0.gridInfoTable then
		return false
	else
		return f123_arg0.gridInfoTable.gridRowIndex == f123_arg1
	end
end
CoD.GridAndListUtility.IsElementAtColumnIndex = function(f124_arg0, f124_arg1)
	if not f124_arg0.gridInfoTable then
		return false
	else
		return f124_arg0.gridInfoTable.gridColIndex == f124_arg1
	end
end
CoD.GridAndListUtility.IsElementInFirstVisibleRow = function(f125_arg0)
	return f125_arg0.isInFirstVisibleRow and f125_arg0:isInFirstVisibleRow()
end
CoD.GridAndListUtility.ShowTabArrows = function(f126_arg0, f126_arg1)
	if CoD.isPC then
		if f126_arg1.grid and f126_arg1.grid.hCount < f126_arg1.grid.itemCount then
			return true
		else
			return false
		end
	else
		return false
	end
end
CoD.GridAndListUtility.UpdateDataSourceNextFrame = function(f127_arg0, f127_arg1)
	if not f127_arg0._updateDataSourcePending then
		f127_arg0._updateDataSourcePending = true
		f127_arg0:addElement(LUI.UITimer.newElementTimer(f127_arg1, true, function()
			f127_arg0._updateDataSourcePending = nil
			f127_arg0:updateDataSource(false, true)
		end))
	end
end
CoD.GridAndListUtility.SetKeepSelectedPositionOnPagination = function(f129_arg0, f129_arg1)
	f129_arg0._keepSelectionPositionWhenPaging = f129_arg1
end
