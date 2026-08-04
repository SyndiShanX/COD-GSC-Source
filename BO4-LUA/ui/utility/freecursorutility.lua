CoD.FreeCursorUtility = {}
CoD.FreeCursorUtility.TooltipArchetypes = LuaEnum.createEnum("DEFAULT", "ACTION_PROMPT", "FEATURE_TITLE", "IDENTITY")
CoD.FreeCursorUtility.LockTypes = LuaEnum.createEnum("PENDINGLOCK", "LOCKED")
CoD.FreeCursorUtility.SetAllowFreeCursor = function(f1_arg0)
	if Engine[@"usingfreecursor"]() then
		Dvar[@"ui_usingfreecursor"]:set(f1_arg0)
	end
end
CoD.FreeCursorUtility.AddLockedFocusLeftOrRightNavigation = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0, f2_local1, f2_local2, f2_local3 = f2_arg2:getLocalLeftRight()
	local f2_local4, f2_local5, f2_local6, f2_local7 = f2_arg3:getLocalLeftRight()
	local f2_local8
	if f2_local2 < f2_local6 then
		f2_local8 = "right"
		if not f2_local8 then
		else
			local f2_local9
			if f2_local2 < f2_local6 then
				f2_local9 = "left"
				if not f2_local9 then
				else
					if not f2_arg2._lockedFocusNavigation then
						f2_arg2._lockedFocusNavigation = {}
					end
					if not f2_arg3._lockedFocusNavigation then
						f2_arg3._lockedFocusNavigation = {}
					end
					f2_arg2._lockedFocusNavigation[f2_local8] = f2_arg3
					f2_arg3._lockedFocusNavigation[f2_local9] = f2_arg2
				end
			end
			f2_local9 = "right"
		end
	end
	f2_local8 = "left"
end
CoD.FreeCursorUtility.AddLockedFocusLeftRightSliderNavigation = function(f3_arg0, f3_arg1, f3_arg2)
	f3_arg0._sliderNavigationWidgetName = f3_arg2
end
CoD.FreeCursorUtility.FlyoutGainFocus = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = function()
		f4_arg0:originalChildLostFocusFn()
		f4_arg0:setForceMouseEventDispatch(false)
		f4_arg0:setState(f4_arg1, f4_arg2)
		f4_arg0.childFocusLost = f4_arg0.originalChildLostFocusFn
		f4_arg0.originalChildLostFocusFn = nil
	end
	f4_arg0:setForceMouseEventDispatch(true)
	f4_arg0:setState(f4_arg1, f4_arg3)
	if not f4_arg0.originalChildLostFocusFn then
		f4_arg0.originalChildLostFocusFn = f4_arg0.childFocusLost
		f4_arg0.childFocusLost = f4_local0
	end
end
CoD.FreeCursorUtility.RegisterFlyout = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	CoD.FreeCursorUtility.RegisterFlyoutAdvanced(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, "DefaultState", "Flyout", "")
end
CoD.FreeCursorUtility.RegisterFlyoutAdvanced = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5, f7_arg6, f7_arg7)
	local f7_local0 = LUI.getTableFromPath(f7_arg3, f7_arg1)
	local f7_local1 = LUI.getTableFromPath(f7_arg4, f7_arg1)
	if f7_local0 and f7_local1 then
		f7_arg1.handleMouseMove = true
		local f7_local2 = f7_local0.m_eventHandlers.gain_focus
		f7_local0:registerEventHandler("gain_focus", function(element, event)
			if f7_local2(element, event) then
				if f7_local1.itemCount >= 1 and (f7_arg7 == "" or not IsElementInState(element, f7_arg7)) then
					CoD.FreeCursorUtility.FlyoutGainFocus(f7_arg1, f7_arg2, f7_arg5, f7_arg6)
					f7_local1:updateLayout()
				end
				return true
			else
			end
		end)
	end
end
CoD.FreeCursorUtility.RegisterButtonFlyout = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3, ...)
	CoD.FreeCursorUtility.RegisterButtonFlyoutAdvanced(f9_arg0, f9_arg1, f9_arg2, "DefaultState", "Flyout", "", f9_arg3, ...)
end
CoD.FreeCursorUtility.RegisterButtonFlyoutAdvanced = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5, f10_arg6, ...)
	local f10_local0 = LUI.getTableFromPath(f10_arg6, f10_arg1)
	if f10_local0 and 0 < #{
		n = select("#", ...),
		...,
	} then
		f10_arg1.handleMouseMove = true
		local f10_local1 = f10_local0.m_eventHandlers.gain_focus
		f10_local0:registerEventHandler("gain_focus", function(element, event)
			if f10_local1(element, event) and (f10_arg5 == "" or not IsElementInState(element, f10_arg5)) then
				CoD.FreeCursorUtility.FlyoutGainFocus(f10_arg1, f10_arg2, f10_arg3, f10_arg4)
				return true
			else
			end
		end)
	end
end
CoD.FreeCursorUtility.UpdateSetupContext = function(f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0:getModel()
	if f12_local0 then
		DataSources.FreeCursor.setupContext(f12_arg1, f12_local0)
	end
end
CoD.FreeCursorUtility.RetriggerCursorPositionNoDelay = function(f13_arg0, f13_arg1)
	if Engine[@"hash_267ACA658A43FBD"](f13_arg1) then
		return
	elseif IsFreeCursorActive(f13_arg1) then
		local f13_local0 = f13_arg0:getRoot()
		assert(f13_local0)
		if f13_local0 and not f13_local0.__waitingForCursorUpdate then
			f13_local0.__waitingForCursorUpdate = true
			local f13_local1 = DataSources.FreeCursor.getModel(f13_arg1)
			f13_local1.position:forceNotifySubscriptions()
			f13_local0.__waitingForCursorUpdate = false
		end
	end
end
CoD.FreeCursorUtility.RetriggerCursorPosition = function(f14_arg0, f14_arg1)
	if IsFreeCursorActive(f14_arg1) then
		local f14_local0 = f14_arg0:getRoot()
		local f14_local1 = function(f15_arg0)
			local f15_local0 = DataSources.FreeCursor.getModel(f14_arg1)
			f15_local0.position:forceNotifySubscriptions()
			if f15_arg0 then
				f15_arg0.__waitingForCursorUpdate = false
			end
		end
		if f14_local0 then
			if not f14_local0.__waitingForCursorUpdate then
				f14_local0.__waitingForCursorUpdate = true
				f14_local0:addElement(LUI.UITimer.newElementTimer(0, true, f14_local1, f14_local0))
			end
		else
			f14_local1(nil)
		end
	end
end
CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor = function(f16_arg0, f16_arg1)
	f16_arg0.__ignoreFreeCursorForFocus = true
end
CoD.FreeCursorUtility.AnimateToHorizontalLeftLayout = function(f17_arg0, f17_arg1)
	if not f17_arg0:getParent() then
		return
	end
	local f17_local0 = f17_arg0:getFirstChild()
	if not f17_local0 then
		return
	end
	local f17_local1 = 0
	while f17_local0 ~= nil do
		if f17_local0:getAlpha() > 0 and not f17_local0.skipHorizontalLayout then
			local f17_local2
			if f17_local0.customGetWidth then
				f17_local2 = f17_local0:customGetWidth()
				if not f17_local2 then
				else
					if f17_local0.__targetLeftPx ~= f17_local1 or f17_local0.__targetWidth ~= f17_local2 then
						if f17_local0.__targetLeftPx ~= f17_local1 then
							f17_local0:beginAnimation(f17_arg1)
						end
						f17_local0:setLeftRight(0, 0, f17_local1, f17_local1 + f17_local2)
						f17_local0.__targetLeftPx = f17_local1
						f17_local0.__targetWidth = f17_local2
					end
					f17_local1 = f17_local1 + f17_local2
				end
			end
			f17_local2 = f17_local0:getWidth()
		end
		f17_local0 = f17_local0:getNextSibling()
	end
	f17_arg0:setWidth(f17_local1)
end
CoD.FreeCursorUtility.AnimateToVerticalTopLayout = function(f18_arg0, f18_arg1, f18_arg2)
	if not f18_arg0:getParent() then
		return
	end
	local f18_local0 = f18_arg0:getFirstChild()
	if not f18_local0 then
		return
	end
	local f18_local1 = function()
		local f19_local0 = f18_arg0._customPadding and f18_arg0._customPadding.height or 0
		local f19_local1 = f19_local0 * 0.5
		while f18_local0 ~= nil do
			if f18_local0:getAlpha() > 0 and not f18_local0.skipVerticalLayout then
				local f19_local2 = f18_local0.customGetHeight and f18_local0:customGetHeight() or f18_local0:getHeight()
				local f19_local3
				if f19_local2 > 0 then
					if f18_arg0._customPadding then
						f19_local3 = f18_arg0._customPadding.height
						if not f19_local3 then
						else
							f19_local2 = f19_local2 + f19_local3
							if f18_local0.__targetTopPx ~= f19_local0 or f18_local0.__targetHeight ~= f19_local2 then
								if f18_local0.__targetTopPx ~= f19_local0 then
									f18_local0:beginAnimation(f18_arg2)
								end
								f18_local0:setTopBottom(0, 0, f19_local0, f19_local0 + f19_local2)
								f18_local0.__targetTopPx = f19_local0
								f18_local0.__targetHeight = f19_local2
							end
							f19_local0 = f19_local0 + f19_local2
						end
					end
					f19_local3 = 0
					if not f19_local3 then
						f19_local3 = 0
					end
				else
					f19_local3 = 0
				end
				f19_local2 = f19_local2 + f19_local3
				if f18_local0.__targetTopPx ~= f19_local0 or f18_local0.__targetHeight ~= f19_local2 then
					if f18_local0.__targetTopPx ~= f19_local0 then
						f18_local0:beginAnimation(f18_arg2)
					end
					f18_local0:setTopBottom(0, 0, f19_local0, f19_local0 + f19_local2)
					f18_local0.__targetTopPx = f19_local0
					f18_local0.__targetHeight = f19_local2
				end
				f19_local0 = f19_local0 + f19_local2
			end
			f18_local0 = f18_local0:getNextSibling()
		end
		local f19_local2 = f18_arg0._customPadding and f18_arg0._customPadding.height or 0
		local f19_local4 = f19_local2 * 0.5
		f19_local0 = f19_local0 + f19_local2
		if f18_arg0.__targetTopPx ~= f19_local0 then
			if f18_arg2 > 0 and (f18_arg0.__targetTopPx or 0) < f19_local0 then
				f18_arg0:beginAnimation(f18_arg2)
			end
			f18_arg0.__targetTopPx = f19_local0
			f18_arg0:setHeight(f19_local0)
		end
	end
	if IsGamepad(f18_arg1) then
		if f18_arg0.__animateToVerticalTopTimer then
			f18_arg0.__animateToVerticalTopTimer:close()
			f18_arg0.__animateToVerticalTopTimer = nil
		end
		f18_arg0.__animateToVerticalTopTimer = LUI.UITimer.newElementTimer(0, true, function()
			f18_arg0.__animateToVerticalTopTimer = nil
			f18_local1()
		end)
		f18_arg0:addElement(f18_arg0.__animateToVerticalTopTimer)
	else
		f18_local1()
	end
end
CoD.FreeCursorUtility.GetWidthBySavedWidth = function(f21_arg0)
	local f21_local0 = f21_arg0.savedWidth
	if not f21_local0 then
		f21_local0 = CoD.FreeCursorUtility.GetWidthByLocalLeftRight(f21_arg0)
	end
	return f21_local0
end
CoD.FreeCursorUtility.GetWidthByLocalLeftRight = function(f22_arg0)
	local f22_local0, f22_local1, f22_local2, f22_local3 = f22_arg0:getLocalLeftRight()
	return f22_local3 - f22_local2
end
CoD.FreeCursorUtility.GetHeightByLocalTopBottom = function(f23_arg0)
	local f23_local0, f23_local1, f23_local2, f23_local3 = f23_arg0:getLocalTopBottom()
	return f23_local3 - f23_local2
end
CoD.FreeCursorUtility.GetWidthByVisibleChildrenWidth = function(f24_arg0, f24_arg1)
	local f24_local0 = f24_arg0:getFirstChild()
	local f24_local1 = 0
	while f24_local0 ~= nil do
		if f24_local0:getAlpha() > 0 and not f24_local0.skipHorizontalLayout and (not f24_arg1 or f24_local0[f24_arg1]) then
			local f24_local2
			if f24_local0.customGetWidth then
				f24_local2 = f24_local0:customGetWidth(f24_arg1)
				if not f24_local2 then
				else
					f24_local1 = f24_local1 + f24_local2
				end
			end
			f24_local2 = f24_local0:getWidth()
		end
		f24_local0 = f24_local0:getNextSibling()
	end
	return f24_local1
end
CoD.FreeCursorUtility.GetHeightByVisibleChildrenHeight = function(f25_arg0, f25_arg1)
	local f25_local0 = f25_arg0:getFirstChild()
	local f25_local1 = 0
	while f25_local0 ~= nil do
		if f25_local0:getAlpha() > 0 and not f25_local0.skipVerticalLayout and (not f25_arg1 or f25_local0[f25_arg1]) then
			local f25_local2
			if f25_local0.customGetHeight then
				f25_local2 = f25_local0:customGetHeight(f25_arg1)
				if not f25_local2 then
				else
					f25_local1 = f25_local1 + f25_local2
				end
			end
			f25_local2 = f25_local0:getHeight()
		end
		f25_local0 = f25_local0:getNextSibling()
	end
	local f25_local2
	if f25_local1 > 0 then
		if f25_arg0._customPadding then
			f25_local2 = f25_arg0._customPadding.height
			if not f25_local2 then
			else
				return f25_local1 + f25_local2
			end
		end
		f25_local2 = 0
		if not f25_local2 then
			f25_local2 = 0
		end
	else
		f25_local2 = 0
	end
	return f25_local1 + f25_local2
end
CoD.FreeCursorUtility.GetWidthByMaxVisibleChild = function(f26_arg0, f26_arg1)
	local f26_local0 = f26_arg0:getFirstChild()
	local f26_local1 = 0
	while f26_local0 ~= nil do
		if f26_local0:getAlpha() > 0 and not f26_local0.skipHorizontalLayout and (not f26_arg1 or f26_local0[f26_arg1]) then
			local f26_local2
			if f26_local0.customGetWidth then
				f26_local2 = f26_local0:customGetWidth(f26_arg1)
				if not f26_local2 then
				else
					f26_local1 = math.max(f26_local1, f26_local2)
				end
			end
			f26_local2 = f26_local0:getWidth()
		end
		f26_local0 = f26_local0:getNextSibling()
	end
	local f26_local2
	if f26_local1 > 0 then
		if f26_arg0._customPadding then
			f26_local2 = f26_arg0._customPadding.width
			if not f26_local2 then
			else
				return f26_local1 + f26_local2
			end
		end
		f26_local2 = 0
		if not f26_local2 then
			f26_local2 = 0
		end
	else
		f26_local2 = 0
	end
	return f26_local1 + f26_local2
end
CoD.FreeCursorUtility.GetHeightByMaxVisibleChild = function(f27_arg0, f27_arg1)
	local f27_local0 = f27_arg0:getFirstChild()
	local f27_local1 = 0
	while f27_local0 ~= nil do
		if f27_local0:getAlpha() > 0 and not f27_local0.skipVerticalLayout and (not f27_arg1 or f27_local0[f27_arg1]) then
			local f27_local2
			if f27_local0.customGetHeight then
				f27_local2 = f27_local0:customGetHeight(f27_arg1)
				if not f27_local2 then
				else
					f27_local1 = math.max(f27_local1, f27_local2)
				end
			end
			f27_local2 = f27_local0:getHeight()
		end
		f27_local0 = f27_local0:getNextSibling()
	end
	return f27_local1
end
CoD.FreeCursorUtility.ForceCloseDetailedView = function(f28_arg0, f28_arg1)
	CoD.FreeCursorUtility.TryCloseDetailedViewTimer(f28_arg0, f28_arg1)
	CoD.FreeCursorUtility.CloseDetailedViewPC(f28_arg0, f28_arg1)
	DataSources.FreeCursor.setupContext(f28_arg1, nil)
end
CoD.FreeCursorUtility.MakeResizingHorizontalLayout = function(f29_arg0)
	f29_arg0:setupResizingUIHorizontalList()
	f29_arg0.customGetWidth = CoD.FreeCursorUtility.GetWidthByVisibleChildrenWidth
end
CoD.FreeCursorUtility.UseVisibleChildrenWidth = function(f30_arg0)
	f30_arg0.customGetWidth = CoD.FreeCursorUtility.GetWidthByVisibleChildrenWidth
end
CoD.FreeCursorUtility.UseMaxVisibleChildWidth = function(f31_arg0)
	f31_arg0.customGetWidth = CoD.FreeCursorUtility.GetWidthByMaxVisibleChild
end
CoD.FreeCursorUtility.UseMaxVisibleChildHeight = function(f32_arg0)
	f32_arg0.customGetHeight = CoD.FreeCursorUtility.GetHeightByMaxVisibleChild
end
CoD.FreeCursorUtility.UseVisibleChildrenHeight = function(f33_arg0)
	f33_arg0.customGetHeight = CoD.FreeCursorUtility.GetHeightByVisibleChildrenHeight
end
CoD.FreeCursorUtility.SetCustomPadding = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3, f34_arg4, f34_arg5)
	if not IsMouseOrKeyboard(f34_arg1) then
		f34_arg0._customPadding = {
			width = f34_arg2,
			height = f34_arg2,
		}
	else
		f34_arg0._customPadding = {
			width = f34_arg4,
			height = f34_arg5,
		}
	end
end
CoD.FreeCursorUtility.UseSelfWidthIfElementVisible = function(f35_arg0, f35_arg1)
	f35_arg0.customGetWidth = function(f36_arg0)
		if not f35_arg0._originalWidth then
			f35_arg0._originalWidth = CoD.FreeCursorUtility.GetWidthByLocalLeftRight(f35_arg0, f36_arg0)
		end
		if f35_arg1:getAlpha() > 0 then
			return f35_arg0._originalWidth
		else
			return 0
		end
	end
end
CoD.FreeCursorUtility.UseSelfHeightIfElementVisible = function(f37_arg0, f37_arg1)
	f37_arg0.customGetHeight = function(f38_arg0)
		if not f37_arg0._originalHeight then
			f37_arg0._originalHeight = CoD.FreeCursorUtility.GetHeightByLocalTopBottom(f37_arg0, f38_arg0)
		end
		if f37_arg1:getAlpha() > 0 then
			return f37_arg0._originalHeight
		else
			return 0
		end
	end
end
CoD.FreeCursorUtility.UseLocalHeight = function(f39_arg0)
	f39_arg0.customGetHeight = function(f40_arg0)
		return CoD.FreeCursorUtility.GetHeightByLocalTopBottom(f39_arg0, f40_arg0)
	end
end
CoD.FreeCursorUtility.SetIgnoredByHorizontalLayout = function(f41_arg0)
	f41_arg0.skipHorizontalLayout = true
end
CoD.FreeCursorUtility.SetIgnoredByVerticalLayout = function(f42_arg0)
	f42_arg0.skipVerticalLayout = true
end
CoD.FreeCursorUtility.ConfinePositionToScreenSafe = function(f43_arg0, f43_arg1)
	local f43_local0 = f43_arg0:getFirstChild()
	local f43_local1 = DataSources.FreeCursor.getModel(f43_arg1)
	f43_local1 = f43_local1.contextualInfo.detailedView
	local f43_local2 = function()
		if IsMouseOrKeyboard(f43_arg1) then
			return
		end
		local f44_local0 = DataSources.FreeCursor.getModel(f43_arg1)
		f44_local0 = f44_local0.position
		local f44_local1 = not f43_local1:get()
		local f44_local2, f44_local3 = f44_local0:get()
		f44_local2 = math.floor(f44_local2 + 0.5)
		f44_local3 = math.floor(f44_local3 + 0.5)
		local f44_local4, f44_local5 = Engine[@"getscreensize"](f43_arg1)
		if CoD.isPC then
			local f44_local6 = f43_arg0:getMenu()
			if f44_local6 then
				local f44_local7, f44_local8, f44_local9, f44_local10 = f44_local6:getRect()
				if f44_local7 then
					f44_local2 = f44_local2 * f44_local4 / (f44_local9 - f44_local7)
					f44_local3 = f44_local3 * f44_local5 / (f44_local10 - f44_local8)
				end
			end
		end
		local f44_local6 = f43_local0:customGetWidth()
		local f44_local7, f44_local8, f44_local9, f44_local10 = f43_arg0:getLocalLeftRight()
		local f44_local11 = f43_arg0._startX
		local f44_local12 = math.floor(f44_local4 * 0.95)
		if f44_local12 < f43_arg0._startX + f44_local2 + f44_local6 then
			f44_local11 = f44_local12 - f44_local2 + f44_local6
		end
		local f44_local13 = f43_local0
		local f44_local14 = f44_local13
		f44_local13 = f44_local13.customGetHeight
		local f44_local15
		if f44_local1 then
			f44_local15 = "inCompactView"
			if not f44_local15 then
			else
				f44_local13 = f44_local13(f44_local14, f44_local15)
				f44_local14, f44_local15, f44_local16, f44_local17 = f43_arg0:getLocalTopBottom()
				local f44_local18 = f43_arg0._startY
				local f44_local19 = math.floor(f44_local5 * 0.95)
				if f44_local19 < f43_arg0._startY + f44_local3 + f44_local13 then
					f44_local18 = f44_local19 - f44_local3 + f44_local13
				end
				if f43_arg0._currentX ~= f44_local11 then
					f43_arg0._currentX = f44_local11
					f43_arg0:setLeftRight(f44_local7, f44_local8, f44_local11, f44_local11)
				end
				if f43_arg0._currentY ~= f44_local18 then
					f43_arg0._currentY = f44_local18
					if f43_arg0._previousHeight ~= f44_local13 then
						f43_arg0._previousHeight = f44_local13
						f43_arg0:beginAnimation(200)
					end
					f43_arg0:setTopBottom(f44_local14, f44_local15, f44_local18, f44_local18)
				end
				if f43_arg0._currentWidth ~= f44_local6 then
					f43_arg0._currentWidth = f44_local6
					f43_local0:setLeftRight(0, 0, 0, f44_local6)
				end
			end
		end
		f44_local15 = nil
	end
	local f43_local3 = nil
	f43_local3, f43_local3, f43_arg0._startX, f43_local3 = f43_arg0:getLocalLeftRight()
	f43_local3, f43_local3, f43_arg0._startY, f43_local3 = f43_arg0:getLocalTopBottom()
	f43_arg0:subscribeToGlobalModel(f43_arg1, "FreeCursor", "position", f43_local2)
	f43_arg0:subscribeToGlobalModel(f43_arg1, "FreeCursor", "contextualInfo.detailedView", f43_local2)
	f43_local0._onSizeChanged = f43_local2
end
CoD.FreeCursorUtility.SetVisibilityToAnyContextualButtonVisible = function(f45_arg0, f45_arg1, f45_arg2)
	local f45_local0 = f45_arg1:getModel()
	f45_local0 = f45_local0.buttonPrompts:get()
	if not f45_local0 then
		f45_arg2:setAlpha(0)
		return
	end
	for f45_local4, f45_local5 in ipairs({
		Enum.LUIButton[@"lui_key_xby_pstriangle"],
		Enum.LUIButton[@"lui_key_xbx_pssquare"],
		Enum.LUIButton[@"lui_key_xba_pscross"],
	}) do
		if f45_local0[f45_local5] and f45_local0[f45_local5]:get() == Enum.LUIButtonPromptStates[@"flag_enable_prompts"] and f45_local0[f45_local5].flags and CoD.BitUtility.IsBitwiseAndNonZero(f45_local0[f45_local5].flags:get(), Enum[@"luibuttonpromptflags"][@"bpf_contextual"]) then
			f45_arg2:setAlpha(1)
			return
		end
	end
	f45_arg2:setAlpha(0)
end
CoD.FreeCursorUtility.RecenterFreeCursorPosition = function(f46_arg0)
	Engine[@"hash_BDC053F9831198A"](f46_arg0)
end
CoD.FreeCursorUtility.IsTooltipInDetailedView = function(f47_arg0, f47_arg1)
	local f47_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(f47_arg0, f47_arg1, "detailedDescription")
	if f47_local0 then
		f47_local0 = CoD.ModelUtility.AreButtonModelValueBitsSet(f47_arg1, Enum.LUIButton[@"lui_key_rtrig"], Enum.LUIButtonFlags[@"flag_down"])
		if not f47_local0 then
			f47_local0 = CoD.FreeCursorUtility.IsDetailedViewPCActive(f47_arg1)
		end
	end
	return f47_local0
end
CoD.FreeCursorUtility.IsTooltipTitleVisible = function(f48_arg0, f48_arg1)
	if not CoD.ModelUtility.IsSelfModelValueNonEmptyString(f48_arg0, f48_arg1, "title") then
		return false
	else
		local f48_local0 = CoD.SafeGetModelValue(f48_arg0:getModel(), "tooltipArchetype")
		if not f48_local0 then
			return false
		elseif f48_local0 == CoD.FreeCursorUtility.TooltipArchetypes.DEFAULT then
			local f48_local1 = CoD.ModelUtility.AreButtonModelValueBitsSet(f48_arg1, Enum.LUIButton[@"lui_key_rtrig"], Enum.LUIButtonFlags[@"flag_down"])
			if not f48_local1 then
				f48_local1 = CoD.FreeCursorUtility.IsDetailedViewPCActive(f48_arg1)
			end
			return f48_local1
		else
			return true
		end
	end
end
CoD.FreeCursorUtility.ShowingContextualPromptForFlags = function(f49_arg0, f49_arg1)
	local f49_local0
	if not IsMouseOrKeyboard() then
		f49_local0 = IsFreeCursorActiveAndVisible(f49_arg1)
		if f49_local0 then
		else
			return f49_local0
		end
	end
	f49_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(f49_arg0, f49_arg1, "flags", Enum[@"luibuttonpromptflags"][@"bpf_contextual"])
end
CoD.FreeCursorUtility.XUIDToClientName = function(f50_arg0, f50_arg1)
	local f50_local0 = Engine[@"hash_334E2C136520C3C8"](Enum.LobbyModule[@"lobby_module_client"], f50_arg1)
	local f50_local1
	if f50_local0 then
		f50_local1 = f50_local0.client.gamertag
		if not f50_local1 then
		else
			return f50_local1
		end
	end
	f50_local1 = ""
end
CoD.FreeCursorUtility.XUIDToClanTag = function(f51_arg0, f51_arg1)
	local f51_local0 = Engine[@"hash_334E2C136520C3C8"](Enum.LobbyModule[@"lobby_module_client"], f51_arg1)
	local f51_local1
	if f51_local0 then
		f51_local1 = f51_local0.client.clantag
		if not f51_local1 then
		else
			return f51_local1
		end
	end
	f51_local1 = ""
end
CoD.FreeCursorUtility.XUIDToEmblemBackgroundId = function(f52_arg0)
	local f52_local0 = f52_arg0
	local f52_local1
	if f52_local0 then
		f52_local1 = Engine[@"hash_72BA5D66D21186AD"](f52_local0)
		if not f52_local1 then
		else
			return f52_local1
		end
	end
	f52_local1 = 0
end
DataSources.FreeCursor = {
	getModel = function(f53_arg0)
		f53_arg0 = CoD.FreeCursorUtility.GetCursorControllerIndex(f53_arg0)
		if not DataSources.FreeCursor.models[f53_arg0] then
			local f53_local0 = Engine.GetModelForController(f53_arg0)
			f53_local0 = f53_local0:create("FreeCursor")
			local f53_local1 = f53_local0:create("hasFocus")
			f53_local1:set(false)
			f53_local1 = f53_local0:create("hasLockedFocus")
			f53_local1:set(false)
			f53_local0:create("position")
			f53_local1 = f53_local0:create("hidden")
			f53_local1:set(0)
			f53_local0:create("usingCursorInput")
			f53_local1 = f53_local0:create("contextualInfo")
			f53_local1:create("buttonPrompts")
			f53_local1:create("updateActivePrompts")
			local f53_local2 = f53_local1:create("updated")
			f53_local2:set(true)
			f53_local2 = f53_local1:create("detailedView")
			f53_local2:set(true)
			for f53_local5, f53_local6 in ipairs(DataSources.FreeCursor.modelDefs) do
				local f53_local7 = f53_local1:create(f53_local6.name)
				f53_local7:set(f53_local6.default)
			end
			DataSources.FreeCursor.models[f53_arg0] = f53_local0
			if DataSources.FreeCursor.subscriptionElements[f53_arg0] == nil then
				DataSources.FreeCursor.subscriptionElements[f53_arg0] = LUI.UIElement.new()
				if not CoD.isPC then
					DataSources.FreeCursor.subscriptionElements[f53_arg0]:subscribeToGlobalModel(f53_arg0, "PerController", "ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"], function(model)
						f53_local1.detailedView:set(CoD.BitUtility.IsBitwiseAndNonZero(model:get(), Enum.LUIButtonFlags[@"flag_down"]))
					end)
				end
			end
			if CoD.isPC then
				f53_local2 = f53_local1:create("detailedViewPC")
				f53_local2:set(false)
				f53_local1:create("updateContextualPromptPC")
				f53_local2 = f53_local1:create("hasContextualPrompts")
				f53_local2:set(false)
				if IsWarzone() then
					f53_local2 = f53_local1:create("isStashFocused")
					f53_local2:set(0x0)
					f53_local2 = f53_local1:create("pickupHintWarzone")
					f53_local2:set(0x0)
				end
			end
		end
		return DataSources.FreeCursor.models[f53_arg0]
	end,
	setupContext = function(f55_arg0, f55_arg1)
		local f55_local0 = DataSources.FreeCursor.getModel(f55_arg0)
		f55_local0 = f55_local0.contextualInfo
		local f55_local1 = f55_arg1
		local f55_local2 = f55_arg1.noContextWidget
		if f55_local2 then
			f55_local2 = f55_local1 and f55_arg1.noContextWidget:get() == true
		end
		if f55_arg1 and f55_arg1.contextWidgetModel then
			f55_arg1 = f55_arg1.contextWidgetModel:get()
		end
		local f55_local3 = false
		for f55_local14, f55_local15 in ipairs(DataSources.FreeCursor.modelDefs) do
			local f55_local16 = f55_local0[f55_local15.name]
			if f55_local16 then
				local f55_local7 = f55_local15.default
				if not f55_local2 and f55_arg1 then
					for f55_local11, f55_local12 in ipairs(f55_local15.paths) do
						local f55_local13 = f55_arg1[f55_local12]
						if f55_local13 and type(f55_local13:get()) == type(f55_local7) then
							f55_local7 = f55_local13:get()
							break
						end
					end
				end
				f55_local16:set(f55_local7)
				f55_local3 = true
			end
		end
		if f55_local3 then
			f55_local0.updated:forceNotifySubscriptions()
		end
	end,
	registerButtonPrompts = function(f56_arg0, f56_arg1)
		local f56_local0 = DataSources.FreeCursor.getModel(f56_arg0)
		f56_local0.contextualInfo.buttonPrompts:set(f56_arg1)
		DataSources.FreeCursor.updateActivePrompts(f56_arg0)
	end,
	getButtonPromptsModel = function(f57_arg0)
		local f57_local0 = DataSources.FreeCursor.getModel(f57_arg0)
		return f57_local0.contextualInfo.buttonPrompts:get()
	end,
	updateActivePrompts = function(f58_arg0)
		local f58_local0 = DataSources.FreeCursor.getModel(f58_arg0)
		f58_local0.contextualInfo.updateActivePrompts:forceNotifySubscriptions()
	end,
	updateContextualPromptPC = function(f59_arg0)
		local f59_local0 = DataSources.FreeCursor.getModel(f59_arg0)
		f59_local0.contextualInfo.updateContextualPromptPC:forceNotifySubscriptions()
	end,
	models = DataSources.FreeCursor and DataSources.FreeCursor.models or {},
	subscriptionElements = DataSources.FreeCursor and DataSources.FreeCursor.subscriptionElements or {},
	modelDefs = {
		{
			name = "tooltipArchetype",
			paths = {
				"tooltipArchetype",
			},
			default = CoD.FreeCursorUtility.TooltipArchetypes.ACTION_PROMPT,
		},
		{
			name = "title",
			paths = {
				"freeCursorTitle",
				"displayName",
				"name",
			},
			default = 0x0,
		},
		{
			name = "description",
			paths = {
				"desc",
				"description",
			},
			default = 0x0,
		},
		{
			name = "detailedDescription",
			paths = {
				"detailedDesc",
				"detailedDescription",
			},
			default = "",
		},
		{
			name = "header",
			paths = {
				"headerName",
			},
			default = 0x0,
		},
		{
			name = "headerUseString",
			paths = {
				"headerUseString",
			},
			default = 0x0,
		},
		{
			name = "attachmentDataSource",
			paths = {
				"attachmentDataSource",
			},
			default = "",
		},
		{
			name = "cost",
			paths = {
				"cost",
			},
			default = -1,
		},
		{
			name = "unlockDescription",
			paths = {
				"unlockDescription",
				"levelUnlockDescription",
			},
			default = 0x0,
		},
		{
			name = "cautionDescription",
			paths = {
				"cautionDesc",
				"cautionDescription",
			},
			default = 0x0,
		},
		{
			name = "characterIndex",
			paths = {
				"characterIndex",
			},
			default = 0,
		},
		{
			name = "characterTraitSummary",
			paths = {
				"characterTraitSummary",
			},
			default = 0x0,
		},
		{
			name = "clientNum",
			paths = {
				"clientNum",
			},
			default = -1,
		},
		{
			name = "xuid",
			paths = {
				"xuid",
			},
			default = LuaDefine.INVALID_XUID_X64,
		},
		{
			name = "isLeader",
			paths = {
				"isLeader",
			},
			default = false,
		},
		{
			name = "playerListDataSource",
			paths = {
				"playerListDataSource",
			},
			default = "PlayerListDataSourceDefault",
		},
	},
}
CoD.FreeCursorUtility.RecreateButtonPromptContainer = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3, f60_arg4, f60_arg5)
	if (CoD.isMultiplayer or CoD.isZombie) and CoDShared.IsInGame() then
		return
	elseif not CoD[f60_arg5] then
		return
	else
		local f60_local0, f60_local1, f60_local2, f60_local3 = f60_arg0[f60_arg3]:getLocalLeftRight()
		local f60_local4, f60_local5, f60_local6, f60_local7 = f60_arg0[f60_arg3]:getLocalTopBottom()
		f60_arg0[f60_arg3]:close()
		f60_arg0[f60_arg3] = nil
		local f60_local8 = CoD[f60_arg5].new(f60_arg2, f60_arg1)
		f60_local8:setLeftRight(f60_local0, f60_local1, f60_local2, f60_local3)
		f60_local8:setTopBottom(f60_local4, f60_local5, f60_local6, f60_local7)
		f60_local8:setModel(f60_arg4 and f60_arg4:get(), f60_arg1)
		f60_arg0:addElement(f60_local8)
		f60_arg0[f60_arg3] = f60_local8
		f60_arg2:sendInitializationEvents(f60_arg1, f60_local8)
	end
end
CoD.FreeCursorUtility.RecreateNoLabelButtonPromptContainerAndLinkToSelfModelValue = function(f61_arg0, f61_arg1, f61_arg2, f61_arg3, f61_arg4)
	CoD.FreeCursorUtility.RecreateButtonPromptContainer(f61_arg0, f61_arg1, f61_arg2, f61_arg3, f61_arg4, "freeCursorNoLabelButtonPromptContainer")
end
CoD.FreeCursorUtility.RecreateButtonPromptContainerAndLinkToSelfModelValue = function(f62_arg0, f62_arg1, f62_arg2, f62_arg3, f62_arg4)
	CoD.FreeCursorUtility.RecreateButtonPromptContainer(f62_arg0, f62_arg1, f62_arg2, f62_arg3, f62_arg4, "freeCursorButtonPromptContainer")
end
CoD.FreeCursorUtility.SetAllowFreeCursorSnappingWithinDistance = function(f63_arg0, f63_arg1)
	f63_arg0.__freeCursorSnapDistance = f63_arg1
end
CoD.FreeCursorUtility.SetAllowFreeCursorSnappingUnlimitedDistance = function(f64_arg0)
	f64_arg0.__freeCursorSnapDistance = CoD.Menu.__infiniteFreeCursorSnapDistance
end
CoD.FreeCursorUtility.DisableFreeCursorSnapping = function(f65_arg0, f65_arg1)
	f65_arg0.__freeCursorSnapDistance = nil
	if not f65_arg0.occludedBy then
		Engine[@"hash_718F7786899BA625"](f65_arg1)
	end
end
CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus = function(f66_arg0, f66_arg1, f66_arg2)
	if IsGamepadOrKeyboardNavigation(f66_arg2) then
		if f66_arg0.__customFocusTimer then
			f66_arg0.__customFocusTimer:close()
		end
		f66_arg0.__customFocusTimer = LUI.UITimer.newElementTimer(0, true, function()
			f66_arg0.__customFocusTimer = nil
			f66_arg1:processEvent({
				name = "gain_focus",
				controller = f66_arg2,
				menu = f66_arg0,
				moveCursor = true,
			})
		end)
		f66_arg0:addElement(f66_arg0.__customFocusTimer)
	end
end
CoD.FreeCursorUtility.ShouldHideCursor = function(f68_arg0)
	local f68_local0 = DataSources.FreeCursor.getModel(f68_arg0)
	local f68_local1 = f68_local0.hidden:get()
	if not f68_local1 then
		f68_local1 = not f68_local0.usingCursorInput:get()
	end
	return f68_local1
end
CoD.FreeCursorUtility.UpdateFreeCursorState = function(f69_arg0, f69_arg1, f69_arg2)
	if Engine[@"usingfreecursor"]() then
		local f69_local0 = DataSources.FreeCursor.getModel(f69_arg1)
		if f69_arg2 ~= nil then
			local f69_local1 = DataSources.FreeCursor.setupContext
			local f69_local2 = f69_arg1
			local f69_local3
			if f69_arg0 then
				f69_local3 = f69_arg2:getModel()
				if not f69_local3 then
				else
					f69_local1(f69_local2, f69_local3)
					if not CoD.FreeCursorUtility.IsDetailedViewPCActive(f69_arg1) and CoD.FreeCursorUtility.CanOpenTooltip(f69_arg1) then
						CoD.FreeCursorUtility.DetailedViewTimerPC(f69_arg0, f69_arg1, true)
					elseif CoD.FreeCursorUtility.IsDetailedViewPCActive(f69_arg1) and not CoD.FreeCursorUtility.CanOpenTooltip(f69_arg1) then
						CoD.FreeCursorUtility.DetailedViewTimerPC(f69_arg0, f69_arg1, false)
					end
				end
			end
			f69_local3 = nil
		elseif CoD.FreeCursorUtility.IsDetailedViewPCActive(f69_arg1) then
			CoD.FreeCursorUtility.DetailedViewTimerPC(f69_arg0, f69_arg1, false)
		end
	end
end
CoD.FreeCursorUtility.IsDetailedViewPCActive = function(f70_arg0)
	if CoD.isPC then
		local f70_local0 = Engine.GetModelForController(f70_arg0)
		f70_local0 = f70_local0:create("FreeCursor")
		local f70_local1 = f70_local0:create("contextualInfo")
		return f70_local1.detailedViewPC:get()
	else
		return false
	end
end
CoD.FreeCursorUtility.TryCloseDetailedViewTimer = function(f71_arg0, f71_arg1)
	local f71_local0 = CoD.GetMouseFocus(f71_arg1)
	if f71_arg0 == nil and f71_local0 then
		f71_arg0 = f71_local0:getMenu()
	end
	if f71_arg0 and f71_arg0.__detailedViewTimer then
		f71_arg0.__detailedViewTimer:close()
		f71_arg0.__detailedViewTimer = nil
	end
end
CoD.FreeCursorUtility.OpenContextualPromptPC = function(f72_arg0)
	f72_arg0:setAlpha(0.01)
	local f72_local0 = f72_arg0:getMenu()
	local f72_local1 = 1250
	if f72_arg0.isContextualPromptOpened then
		f72_arg0:setAlpha(1)
		if f72_local0.__closeContextualTimer then
			f72_local0.__closeContextualTimer:close()
		end
	elseif f72_arg0.__openContextualTimer == nil then
		f72_arg0.__openContextualTimer = LUI.UITimer.newElementTimer(f72_local1, true, function()
			f72_arg0:setAlpha(1)
			f72_arg0.isContextualPromptOpened = true
			f72_arg0.__openContextualTimer:close()
			f72_arg0.__openContextualTimer = nil
		end)
		f72_arg0:addElement(f72_arg0.__openContextualTimer)
	else
		f72_arg0.__openContextualTimer:reset()
	end
end
CoD.FreeCursorUtility.CloseContextualPromptPC = function(f74_arg0)
	f74_arg0:setAlpha(0)
	local f74_local0 = 1
	if f74_arg0.isContextualPromptOpened == true then
		local f74_local1 = f74_arg0:getMenu()
		if f74_local1.__closeContextualTimer == nil then
			f74_local1.__closeContextualTimer = LUI.UITimer.newElementTimer(f74_local0, true, function()
				f74_arg0.isContextualPromptOpened = false
				f74_local1.__closeContextualTimer:close()
				f74_local1.__closeContextualTimer = nil
			end)
			f74_local1:addElement(f74_local1.__closeContextualTimer)
		else
			f74_local1.__closeContextualTimer:reset()
		end
	end
end
CoD.FreeCursorUtility.DetailedViewTimerPC = function(f76_arg0, f76_arg1, f76_arg2)
	local f76_local0 = 0
	local f76_local1 = 150
	if not f76_arg0.__detailedViewTimer then
		local f76_local2 = LUI.UITimer.newElementTimer
		if f76_arg2 == true then
			local f76_local3 = f76_local0
		end
		f76_arg0.__detailedViewTimer = f76_local2(f76_local3 or f76_local1, true, function()
			CoD.FreeCursorUtility.ToggleDetailedViewPC(f76_arg0, f76_arg1, f76_arg2)
			f76_arg0.__detailedViewTimer:close()
			f76_arg0.__detailedViewTimer = nil
		end)
		f76_arg0:addElement(f76_arg0.__detailedViewTimer)
	else
		f76_arg0.__detailedViewTimer:reset()
	end
end
CoD.FreeCursorUtility.CanOpenTooltip = function(f78_arg0)
	local f78_local0 = CoD.GetMouseFocus(f78_arg0)
	local f78_local1 = DataSources.FreeCursor.getModel(f78_arg0)
	if f78_local0 == nil or f78_local1 == nil then
		return false
	end
	local f78_local2 = f78_local1.contextualInfo.detailedDescription:get()
	local f78_local3 = f78_local2
	local f78_local4
	if f78_local2 == "" or f78_local2 == 0x0 then
		f78_local4 = false
	else
		f78_local4 = f78_local3 and true
	end
	local f78_local5 = CoD.ModelUtility.IsModelValueNonEmptyString(f78_arg0, "FreeCursor.contextualInfo.title")
	local f78_local6 = CoD.PCUtility.MenuChatIsActive(f78_arg0)
	local f78_local7 = CoD.HUDUtility.IsWarzone()
	if f78_local7 then
		f78_local7 = CoD.WZUtility.IsPCSplitterOpen(f78_arg0)
	end
	if not f78_local4 then
		local f78_local8 = f78_local5
	end
	local f78_local9
	if not f78_local6 then
		f78_local9 = not f78_local7
	else
		f78_local9 = false
	end
	return f78_local9
end
CoD.FreeCursorUtility.ToggleDetailedViewPC = function(f79_arg0, f79_arg1, f79_arg2)
	if f79_arg2 and CoD.FreeCursorUtility.CanOpenTooltip(f79_arg1) then
		CoD.FreeCursorUtility.OpenDetailedViewPC(f79_arg0, f79_arg1)
	elseif not f79_arg2 and not CoD.FreeCursorUtility.CanOpenTooltip(f79_arg1) then
		CoD.FreeCursorUtility.CloseDetailedViewPC(f79_arg0, f79_arg1)
	end
end
CoD.FreeCursorUtility.OpenDetailedViewPC = function(f80_arg0, f80_arg1)
	local f80_local0 = Engine.GetModelForController(f80_arg1)
	f80_local0 = f80_local0:create("FreeCursor")
	local f80_local1 = f80_local0:create("contextualInfo")
	if CoD.FreeCursorUtility.CanOpenTooltip(f80_arg1) and not f80_local1.detailedViewPC:get() then
		f80_local1.detailedViewPC:set(true)
		f80_local1.detailedView:set(true)
		f80_local1.updated:forceNotifySubscriptions()
	end
end
CoD.FreeCursorUtility.CloseDetailedViewPC = function(f81_arg0, f81_arg1)
	local f81_local0 = Engine.GetModelForController(f81_arg1)
	f81_local0 = f81_local0:create("FreeCursor")
	local f81_local1 = f81_local0:create("contextualInfo")
	if f81_local1.detailedViewPC:get() then
		f81_local1.detailedViewPC:set(false)
		f81_local1.detailedView:set(false)
		f81_local1.updated:forceNotifySubscriptions()
	end
end
CoD.FreeCursorUtility.PrepareTooltipPC = function(f82_arg0, f82_arg1, f82_arg2)
	local f82_local0 = function()
		local f83_local0 = f82_arg2:getMenu()
		local f83_local1 = f82_arg0:getParent()
		if f83_local1 and f83_local0 and f83_local1 ~= f82_arg0 then
			f83_local1:removeElement(f82_arg0)
			f83_local0:addElement(f82_arg0)
		end
	end
	local f82_local1 = function(f84_arg0, f84_arg1, f84_arg2, f84_arg3)
		local f84_local0, f84_local1 = Engine[@"getscreensize"](f82_arg1)
		local f84_local2 = f84_arg0:customGetHeight(nil)
		local f84_local3 = f84_arg0:customGetWidth()
		local f84_local4 = math.floor(f84_local1 * 0.8)
		local f84_local5 = math.floor(f84_local0 * 1)
		local f84_local6 = 0
		local f84_local7 = 0
		if f84_local5 < f84_arg1 + f84_local3 then
			f84_local6 = f84_arg1 + f84_local3 - f84_local5
		end
		if f84_local4 < f84_arg2 + f84_local2 then
			f84_local7 = f84_arg0:customGetHeight(nil) + f84_arg2 - f84_arg3
		end
		return f84_local6, f84_local7
	end
	local f82_local2 = function()
		local f85_local0 = CoD.GetMouseFocus(f82_arg1)
		local f85_local1 = f82_arg2:getMenu()
		if f85_local0 and f85_local1 then
			f82_local0()
			local f85_local2 = f82_arg0:getFirstChild()
			if f85_local2 then
				f85_local2:setAlpha(1)
			end
			if f85_local0.tooltipArea then
				f85_local0 = f85_local0.tooltipArea
			end
			local f85_local3, f85_local4, f85_local5, f85_local6 = f85_local1:getRect()
			local f85_local7, f85_local8, f85_local9, f85_local10 = Engine[@"hash_3695399A0E06EC35"](f82_arg1, f85_local0)
			if f85_local3 ~= nil then
				local f85_local11, f85_local12 = Engine[@"getscreensize"](f82_arg1)
				f85_local7 = f85_local7 * f85_local11 / (f85_local5 - f85_local3)
				f85_local9 = f85_local9 * f85_local11 / (f85_local5 - f85_local3)
				f85_local8 = f85_local8 * f85_local12 / (f85_local6 - f85_local4)
				f85_local10 = f85_local10 * f85_local12 / (f85_local6 - f85_local4)
				local f85_local13 = f85_local9 - f85_local7
				local f85_local14 = 0
				local f85_local15 = 0
				f85_local15, f85_local14 = f82_local1(f85_local2, f85_local7, f85_local10, f85_local8)
				f82_arg0:setLeftRight(0, 0, f85_local7 - f85_local15, f85_local7 - f85_local15)
				f82_arg0:setTopBottom(0, 0, f85_local10 - f85_local14, f85_local10 - f85_local14)
			end
		end
	end
	f82_arg0:subscribeToGlobalModel(f82_arg1, "FreeCursor", "contextualInfo.updated", f82_local2)
	f82_arg0:subscribeToGlobalModel(f82_arg1, "FreeCursor", "contextualInfo.detailedViewPC", f82_local2)
	f82_arg0:subscribeToGlobalModel(f82_arg1, "ChatGlobal", "MenuChatInActiveMode", function(model)
		CoD.FreeCursorUtility.ForceCloseDetailedView(f82_arg2, f82_arg1)
	end)
end
CoD.FreeCursorUtility.SetupHideContextualPromptPC = function(f87_arg0, f87_arg1)
	f87_arg0:subscribeToGlobalModel(f87_arg1, "ChatGlobal", "MenuChatInActiveMode", function(model)
		HideWidget(f87_arg0)
	end)
end
CoD.FreeCursorUtility.RegisterButtonPromptsForMenu = function(f89_arg0, f89_arg1)
	DataSources.FreeCursor.registerButtonPrompts(f89_arg1, f89_arg0.buttonModel)
end
CoD.FreeCursorUtility.CanShowContextualButtonPromptPC = function(f90_arg0, f90_arg1)
	local f90_local0 = CoD.PCUtility.MenuChatIsActive(f90_arg1)
	local f90_local1 = CoD.HUDUtility.IsWarzone()
	if f90_local1 then
		f90_local1 = CoD.WZUtility.IsPCSplitterOpen(f90_arg1)
	end
	local f90_local2
	if not f90_local0 then
		f90_local2 = not f90_local1
	else
		f90_local2 = false
	end
	return f90_local2
end
CoD.FreeCursorUtility.GetCursorControllerIndex = function(f91_arg0)
	if CoD.isFrontend then
		return Engine.GetPrimaryController()
	else
		return f91_arg0
	end
end
CoD.FreeCursorUtility.UpdateContextualPromptModelPC = function(f92_arg0, f92_arg1)
	DataSources.FreeCursor.updateContextualPromptPC(f92_arg1)
end
CoD.FreeCursorUtility.SetIsShowingContextualPromptsModelPC = function(f93_arg0, f93_arg1, f93_arg2)
	local f93_local0 = Engine.GetModelForController(f93_arg1)
	f93_local0 = f93_local0:create("FreeCursor")
	local f93_local1 = f93_local0:create("contextualInfo")
	f93_arg0:subscribeToGlobalModel(f93_arg1, "FreeCursor", "contextualInfo.updateContextualPromptPC", function()
		f93_local1.hasContextualPrompts:set(AnyContextualButtonPrompts(f93_arg0, f93_arg1))
	end)
end
