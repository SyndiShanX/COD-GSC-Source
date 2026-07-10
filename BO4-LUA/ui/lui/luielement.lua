LUI.UIElement = {
	id = "LUIElement",
	m_defaultAnimationState = {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftPct = 0.5,
		topPct = 0.5,
		bottomPct = 0.5,
		rightPct = 0.5,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		leftAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		rightAnchor = false,
	},
}
LUI.UIContainer = {}
LUI.UIElement.unsubscribeFromAllModels = function(f1_arg0)
	f1_arg0:unregisterAllElementModelBindings()
	f1_arg0:unsubscribeFromGlobalModels()
	f1_arg0:unsubscribeFromAllModelsInC()
end
LUI.UIElement.setModel = function(f2_arg0, f2_arg1, f2_arg2)
	if f2_arg1 ~= f2_arg0:getModel() then
		f2_arg0:setModelInC(f2_arg1)
		if f2_arg0.linkedElementModels then
			for f2_local3, f2_local4 in pairs(f2_arg0.linkedElementModels) do
				f2_local3:updateElementLinkedModels(f2_arg0)
			end
		end
	end
	for f2_local0 = 1, #LUI.currentMouseFocus, 1 do
		if f2_arg0 == LUI.currentMouseFocus[f2_local0] then
			DataSources.FreeCursor.setupContext(f2_arg2, f2_arg1)
			break
		end
	end
end
LUI.UIElement.SetModelFromEvent = function(f3_arg0, f3_arg1)
	f3_arg0:setModel(f3_arg1.model, f3_arg1.controller)
	return true
end
LUI.UIElement.registerElementModelBinding = function(f4_arg0, f4_arg1)
	if not f4_arg0.linkedElementModels then
		f4_arg0.linkedElementModels = {
			[f4_arg1] = 1,
		}
	elseif not f4_arg0.linkedElementModels[f4_arg1] then
		f4_arg0.linkedElementModels[f4_arg1] = 1
	else
		f4_arg0.linkedElementModels[f4_arg1] = f4_arg0.linkedElementModels[f4_arg1] + 1
	end
end
LUI.UIElement.removeElementModelBinding = function(f5_arg0, f5_arg1)
	f5_arg0.linkedElementModels[f5_arg1] = nil
end
LUI.UIElement.unregisterAllElementModelBindings = function(f6_arg0)
	f6_arg0:unsubscribeFromAllElementBindings()
	if f6_arg0.linkedElementModels then
		for f6_local3, f6_local4 in pairs(f6_arg0.linkedElementModels) do
			f6_local3:unsubscribeFromElementBindings(f6_arg0)
		end
	end
end
LUI.UIElement.bindElementModel = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = f7_arg1:getModel()
	local f7_local1 = nil
	if f7_local0 and f7_arg2.modelPath then
		f7_local1 = Engine[@"getmodel"](f7_local0, f7_arg2.modelPath)
	else
		f7_local1 = f7_local0
	end
	if f7_arg2.requiresSubscription then
		if f7_local1 then
			f7_arg2.subscription = f7_arg0:subscribeToModel(f7_local1, f7_arg2.updateFn, not f7_arg3)
		end
	else
		f7_arg2.updateFn(f7_local1, f7_arg1)
	end
end
LUI.UIElement.subscribeToElementModel = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	f8_arg0:linkToElementModel(f8_arg1, f8_arg2, true, f8_arg3)
end
LUI.UIElement.linkToElementModel = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5)
	f9_arg1:registerElementModelBinding(f9_arg0)
	local f9_local0 = {
		modelPath = f9_arg2,
		requiresSubscription = f9_arg3,
		updateFn = f9_arg4,
	}
	if not f9_arg0.elementModelBindings then
		f9_arg0.elementModelBindings = {
			[f9_arg1] = {
				f9_local0,
			},
		}
	elseif not f9_arg0.elementModelBindings[f9_arg1] then
		f9_arg0.elementModelBindings[f9_arg1] = {
			f9_local0,
		}
	else
		table.insert(f9_arg0.elementModelBindings[f9_arg1], f9_local0)
	end
	f9_arg0:bindElementModel(f9_arg1, f9_local0, f9_arg5)
end
LUI.UIElement.unsubscribeFromAllElementBindings = function(f10_arg0)
	if f10_arg0.elementModelBindings then
		for f10_local6, f10_local7 in pairs(f10_arg0.elementModelBindings) do
			for f10_local3, f10_local4 in ipairs(f10_local7) do
				if f10_local4.subscription ~= nil then
					f10_arg0:removeSubscription(f10_local4.subscription)
				end
			end
			f10_local6:removeElementModelBinding(f10_arg0)
		end
		f10_arg0.elementModelBindings = nil
	end
end
LUI.UIElement.unsubscribeFromElementBindings = function(f11_arg0, f11_arg1)
	if f11_arg0.elementModelBindings and f11_arg0.elementModelBindings[f11_arg1] then
		for f11_local3, f11_local4 in ipairs(f11_arg0.elementModelBindings[f11_arg1]) do
			if f11_local4.subscription ~= nil then
				f11_arg0:removeSubscription(f11_local4.subscription)
			end
		end
		f11_arg0.elementModelBindings[f11_arg1] = nil
		f11_arg1:removeElementModelBinding(f11_arg0)
	end
end
LUI.UIElement.updateElementLinkedModels = function(f12_arg0, f12_arg1)
	if not f12_arg0.elementModelBindings or not f12_arg0.elementModelBindings[f12_arg1] then
		return
	end
	for f12_local3, f12_local4 in ipairs(f12_arg0.elementModelBindings[f12_arg1]) do
		if f12_local4.subscription ~= nil then
			f12_arg0:removeSubscription(f12_local4.subscription)
		end
		f12_arg0:bindElementModel(f12_arg1, f12_local4)
	end
end
LUI.UIElement.bindGlobalModel = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	local f13_local0 = DataSources[f13_arg2.dataSource]
	if f13_local0 and f13_local0.getModel then
		local f13_local1 = f13_local0.getModel(f13_arg1)
		if f13_local1 then
			local f13_local2 = nil
			if f13_arg2.modelPath then
				f13_local2 = Engine[@"getmodel"](f13_local1, f13_arg2.modelPath)
			else
				f13_local2 = f13_local1
			end
			if f13_local2 then
				f13_arg2.subscription = f13_arg0:subscribeToModel(f13_local2, f13_arg2.updateFn, not f13_arg3)
			end
		end
	end
end
LUI.UIElement.subscribeToGlobalModel = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5)
	if not f14_arg0.globalModelBindings then
		f14_arg0.globalModelBindings = {}
	end
	local f14_local0 = {
		dataSource = f14_arg2,
		modelPath = f14_arg3,
		updateFn = f14_arg4,
	}
	table.insert(f14_arg0.globalModelBindings, f14_local0)
	f14_arg0:bindGlobalModel(f14_arg1, f14_local0, f14_arg5)
	return f14_local0.subscription
end
LUI.UIElement.unsubscribeFromGlobalModels = function(f15_arg0)
	if not f15_arg0.globalModelBindings then
		return
	end
	for f15_local3, f15_local4 in ipairs(f15_arg0.globalModelBindings) do
		if f15_local4.subscription ~= nil then
			f15_arg0:removeSubscription(f15_local4.subscription)
		end
	end
	f15_arg0.globalModelBindings = nil
end
LUI.UIElement.isClosed = function(f16_arg0)
	return f16_arg0:getParent() == nil
end
LUI.UIElement.close = function(f17_arg0)
	for f17_local0 = 1, #LUI.currentMouseFocus, 1 do
		if LUI.currentMouseFocus[f17_local0] == f17_arg0 then
			LUI.currentMouseFocus[f17_local0] = false
		end
	end
	f17_arg0:unsubscribeFromAllModels()
	local f17_local0 = f17_arg0.controller
	if not f17_local0 then
		local f17_local1 = f17_arg0:getParent()
		while f17_local1 and not f17_local0 do
			f17_local0 = f17_local1.controller or f17_local1.m_ownerController
			f17_local1 = f17_local1:getParent()
		end
		if not f17_local0 then
			f17_local0 = Engine[@"getprimarycontroller"]()
		end
	end
	if f17_arg0 == Engine[0x4B06D9D6B673AA](f17_local0) then
		Engine[@"hash_718F7786899BA625"](f17_local0)
	end
	if CoD.isPC then
		f17_local1 = f17_arg0:getMenu()
		if f17_arg0:isInFocus() and IsKeyboard(f17_local0) then
			f17_arg0:dispatchEventToParent({
				name = "delayed_clear_recorded_focus",
				controller = f17_local0,
			})
		end
		if f17_local1 and f17_local1.currentInputFocus == f17_arg0 then
			f17_local1:ChangeInputFocus(f17_local0, nil)
		end
	end
	f17_local1 = f17_arg0:getParent()
	if f17_local1 ~= nil then
		f17_local1:removeElement(f17_arg0)
	end
	f17_arg0:closeElementInC()
end
LUI.UIElement.getFullID = function(f18_arg0)
	local f18_local0 = f18_arg0.id
	local f18_local1 = f18_arg0:getParent()
	while f18_local1 do
		f18_local0 = f18_local1.id .. "/" .. f18_local0
		f18_local1 = f18_local1:getParent()
	end
	return f18_local0
end
LUI.UIElement.isInputDisabledOnChain = function(f19_arg0)
	while f19_arg0 do
		if f19_arg0.m_inputDisabled then
			return true
		end
		f19_arg0 = f19_arg0:getParent()
	end
	return false
end
LUI.UIElement.getSoundSet = function(f20_arg0)
	local f20_local0 = f20_arg0
	while f20_local0 do
		if f20_local0.soundSet then
			return f20_local0.soundSet
		end
		f20_local0 = f20_local0:getParent()
	end
end
LUI.UIElement.findSoundAlias = function(f21_arg0, f21_arg1)
	local f21_local0 = f21_arg0
	while f21_local0 do
		if f21_local0.soundSet and SoundSet[f21_local0.soundSet] and SoundSet[f21_local0.soundSet][f21_arg1] then
			return SoundSet[f21_local0.soundSet][f21_arg1]
		end
		f21_local0 = f21_local0:getParent()
	end
end
LUI.UIElement.setPlaySoundDirect = function(f22_arg0, f22_arg1)
	f22_arg0.playSoundDirect = f22_arg1
end
LUI.UIElement.setIgnorePlaySound = function(f23_arg0, f23_arg1)
	f23_arg0.ignorePlaySound = f23_arg1
end
LUI.UIElement.playSound = function(f24_arg0, f24_arg1, f24_arg2)
	if f24_arg0.ignorePlaySound then
		return
	elseif not f24_arg0.playSoundDirect then
		local f24_local0 = f24_arg0:findSoundAlias(f24_arg1)
		if f24_local0 then
			if f24_arg2 ~= nil then
				Engine[@"playsound"](f24_local0, f24_arg2)
			else
				Engine[@"playsound"](f24_local0)
			end
			return true
		end
	elseif f24_arg2 ~= nil then
		Engine[@"playsound"](f24_arg1, f24_arg2)
	else
		Engine[@"playsound"](f24_arg1)
	end
end
LUI.UIElement.playActionSFX = function(f25_arg0)
	f25_arg0:playSound("action")
end
LUI.UIElement.getLocalSize = function(f26_arg0)
	local f26_local0, f26_local1, f26_local2, f26_local3 = nil
	if f26_arg0.getNextRect then
		f26_local0, f26_local1, f26_local2, f26_local3 = f26_arg0:getNextRect()
	else
		f26_local0, f26_local1, f26_local2, f26_local3 = f26_arg0:getLocalRect()
	end
	return f26_local2 - f26_local0, f26_local3 - f26_local1
end
LUI.UIElement.getCenter = function(f27_arg0)
	local f27_local0, f27_local1, f27_local2, f27_local3 = nil
	f27_local0, f27_local1, f27_local2, f27_local3 = f27_arg0:getRect()
	if not f27_local0 then
		return nil
	else
		return {
			x = (f27_local2 + f27_local0) / 2,
			y = (f27_local3 + f27_local1) / 2,
		}
	end
end
LUI.UIElement.setMouseDisabled = function(f28_arg0, f28_arg1)
	f28_arg0.m_mouseDisabled = f28_arg1
	f28_arg0.handleMouseMove = not f28_arg1
	f28_arg0.handleMouseButton = not f28_arg1
end
LUI.UIElement.toggleMouse = function(f29_arg0)
	f29_arg0.m_mouseDisabled = not f29_arg0.m_mouseDisabled
end
LUI.UIElement.setHandleMouse = function(f30_arg0, f30_arg1)
	f30_arg0.handleMouseMove = f30_arg1
	f30_arg0.handleMouseButton = f30_arg1
end
LUI.UIElement.toggleHandleMouse = function(f31_arg0)
	f31_arg0.handleMouseMove = not f31_arg0.handleMouseMove
	f31_arg0.handleMouseButton = not f31_arg0.handleMouseButton
end
LUI.UIElement.setHandleMouseMove = function(f32_arg0, f32_arg1)
	f32_arg0.handleMouseMove = f32_arg1
end
LUI.UIElement.toggleHandleMouseMove = function(f33_arg0)
	f33_arg0.handleMouseMove = not f33_arg0.handleMouseMove
end
LUI.UIElement.setHandleMouseButton = function(f34_arg0, f34_arg1)
	f34_arg0.handleMouseButton = f34_arg1
end
LUI.UIElement.toggleHandleMouseButton = function(f35_arg0)
	f35_arg0.handleMouseButton = not f35_arg0.handleMouseButton
end
LUI.UIElement.setForceMouseEventDispatch = function(f36_arg0, f36_arg1)
	f36_arg0.m_forceMouseEventDispatch = f36_arg1
end
LUI.UIElement.GetMouseEventElementIntersection = function(f37_arg0, f37_arg1)
	if f37_arg1.x == nil or f37_arg1.y == nil then
		return false
	elseif Engine[@"lastinput_mouse"](f37_arg1.controller) then
		return Engine[@"ismouseinsideelement"](f37_arg1.controller, f37_arg0, f37_arg1.rootName, f37_arg1.x, f37_arg1.y) and 1 or 0
	else
		return Engine[@"getcircleinsideelement"](f37_arg1.controller, f37_arg0, f37_arg1.rootName, f37_arg1.x, f37_arg1.y)
	end
end
LUI.UIElement.IsMouseEventInsideElement = function(f38_arg0, f38_arg1)
	return f38_arg0:GetMouseEventElementIntersection(f38_arg1) > 0
end
LUI.UIElement.IsMouseInsideElement = function(f39_arg0, f39_arg1)
	if not IsFreeCursorActive(f39_arg1) then
		return false
	end
	return f39_local2.name and f39_local3 and f39_arg0:IsMouseEventInsideElement({
		controller = f39_arg1,
		rootName = f39_local2.name,
		x = f39_local0,
		y = f39_local1,
	})
end
LUI.UIElement.allowsCursorMove = function(f40_arg0)
	local f40_local0
	if not f40_arg0.disabled and not f40_arg0.m_inputDisabled and not f40_arg0.m_mouseDisabled then
		f40_local0 = f40_arg0:isVisible()
	else
		f40_local0 = false
	end
	return f40_local0
end
LUI.UIElement.cursorInsideElementPerc = function(f41_arg0, f41_arg1, f41_arg2, f41_arg3, f41_arg4)
	if IsGamepad(f41_arg1) then
		return Engine[@"getcircleinsideelement"](f41_arg1, f41_arg0, f41_arg2, f41_arg3, f41_arg4)
	else
		return Engine[@"ismouseinsideelement"](f41_arg1, f41_arg0, f41_arg2, f41_arg3, f41_arg4) and 1 or 0
	end
end
LUI.UIElement.cursorDistanceToElement = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4)
	if IsGamepad(f42_arg1) then
		return Engine[@"hash_34EC51B8F2565913"](f42_arg1, f42_arg0, f42_arg2, f42_arg3, f42_arg4)
	else
		return nil, Engine[@"ismouseinsideelement"](f42_arg1, f42_arg0, f42_arg2, f42_arg3, f42_arg4) and 1 or 0
	end
end
local f0_local0 = function(f43_arg0, f43_arg1)
	return f43_arg0 and not f43_arg1.elem
end
LUI.UIElement.cursorMoved = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4, f44_arg5, f44_arg6, f44_arg7)
	if not f44_arg0:allowsCursorMove() then
		return
	elseif f44_arg0:isFocusable() and not f44_arg0.onlyChildrenFocusable then
		if #f44_arg4 > 0 then
			local f44_local0 = f44_arg0.id
			local f44_local1 = "Element "
			if LUI.DEV then
				f44_local1 = f44_local1 .. LUI.DEV.DebugElementPath(f44_arg0)
			else
				f44_local1 = f44_local1 .. f44_arg0.id
			end
			f44_local1 = f44_local1 .. " is focusable but has a focusable child which is not allowed.\nFocusable Children:\n"
			for f44_local5, f44_local6 in ipairs(f44_arg4) do
				f44_local1 = f44_local1 .. "\t" .. f44_local6.id .. "\n"
			end
			error(f44_local1)
		end
		if f44_arg0 ~= f44_arg6.elem then
			if not f0_local0(f44_arg7, f44_arg6) and f44_arg0._yieldFocus and f44_arg6.elem and f44_arg0:getParent() then
				local f44_local0 = f44_arg0:getParent()
				if not f44_local0:isParentOf(f44_arg6.elem) then
				else
				end
			end
			local f44_local0, f44_local1 = nil
			if f0_local0(f44_arg7, f44_arg6) then
				f44_local1, f44_local0 = f44_arg0:cursorDistanceToElement(f44_arg1, f44_arg5, f44_arg2, f44_arg3)
			else
				f44_local0 = f44_arg0:cursorInsideElementPerc(f44_arg1, f44_arg5, f44_arg2, f44_arg3)
			end
			if f44_arg6.insidePerc < f44_local0 then
				f44_arg6.insidePerc = f44_local0
				f44_arg6.elem = f44_arg0
			elseif f44_arg6.elem and f44_local0 > 0 then
				local f44_local2 = CoD.PCUtility.HasStickyParent(f44_arg0, f44_arg1)
				if f44_arg6.elem._yieldFocus then
					local f44_local3 = f44_arg6.elem:getParent()
					if not f44_local3:isParentOf(f44_arg0) then
						if f44_arg0._seizeFocus then
							local f44_local3 = f44_arg0:getParent()
							if not f44_local3:isParentOf(f44_arg6.elem) then
							else
								f44_arg6.insidePerc = 1
								f44_arg6.elem = f44_arg0
							end
						end
						if f44_local2 and IsGamepad(f44_arg1) then
						elseif not f44_arg6.elem and f44_local1 and (not f44_arg7.nearestDistance or f44_local1 < f44_arg7.nearestDistance) then
							f44_arg7.elem = f44_arg0
							f44_arg7.nearestDistance = f44_local1
						end
					end
				else
					if f44_arg0._seizeFocus then
						local f44_local3 = f44_arg0:getParent()
						if not f44_local3:isParentOf(f44_arg6.elem) then
						else
							f44_arg6.insidePerc = 1
							f44_arg6.elem = f44_arg0
						end
					end
					if f44_local2 and IsGamepad(f44_arg1) then
					elseif not f44_arg6.elem and f44_local1 and (not f44_arg7.nearestDistance or f44_local1 < f44_arg7.nearestDistance) then
						f44_arg7.elem = f44_arg0
						f44_arg7.nearestDistance = f44_local1
					end
				end
				f44_arg6.insidePerc = 1
				f44_arg6.elem = f44_arg0
			end
		elseif not f44_arg6.elem and f44_local1 and (not f44_arg7.nearestDistance or f44_local1 < f44_arg7.nearestDistance) then
			f44_arg7.elem = f44_arg0
			f44_arg7.nearestDistance = f44_local1
		end
	elseif f44_arg0.m_forceMouseEventDispatch or #f44_arg4 < 2 or f0_local0(f44_arg7, f44_arg6) or f44_arg0:cursorInsideElementPerc(f44_arg1, f44_arg5, f44_arg2, f44_arg3) > 0 then
		for f44_local3, f44_local4 in ipairs(f44_arg4) do
			local f44_local5 = f44_arg0[f44_local4.id]
			if f44_local5 then
				f44_local5:cursorMoved(f44_arg1, f44_arg2, f44_arg3, f44_local4.focusableElementPaths, f44_arg5, f44_arg6, f44_arg7)
			end
		end
	end
end
LUI.UIElement.isParentOf = function(f45_arg0, f45_arg1)
	local f45_local0 = f45_arg1:getParent()
	while f45_local0 do
		if f45_local0 == f45_arg0 then
			return true
		end
		f45_local0 = f45_local0:getParent()
	end
	return false
end
LUI.UIElement.AcceptGamePadButtonInput = function(f46_arg0, f46_arg1)
	if f46_arg0.m_inputDisabled or f46_arg0.occludedBy then
		return false
	elseif not f46_arg0.m_ownerController or f46_arg0.m_ownerController == f46_arg1.controller or f46_arg0.anyControllerAllowed or Engine[@"iscontrollerbeingused"](f46_arg1.controller) then
		return true
	elseif f46_arg0.m_ownerController and f46_arg0.m_ownerController ~= f46_arg1.controller then
		local f46_local0 = f46_arg1.name
		f46_arg1.name = "unused_gamepad_button"
		f46_arg0:processEvent(f46_arg1)
		f46_arg0:dispatchEventToChildren(f46_arg1)
		f46_arg1.name = f46_local0
	end
end
LUI.UIElement.AcceptGamePadButtonInputFromModelCallback = function(f47_arg0, f47_arg1)
	if f47_arg0.m_inputDisabled or f47_arg0.occludedBy then
		return false
	elseif not f47_arg0.m_ownerController or f47_arg0.m_ownerController == f47_arg1 or f47_arg0.anyControllerAllowed or Engine[@"iscontrollerbeingused"](f47_arg1) then
		return true
	else
		return false
	end
end
LUI.UIElement.GetCorrespondingGamepadButtonForKey = function(f48_arg0)
	if f48_arg0 == "DOWNARROW" or f48_arg0 == "MWHEELDOWN" or f48_arg0 == "ui_navdown" then
		return "down"
	elseif f48_arg0 == "UPARROW" or f48_arg0 == "MWHEELUP" or f48_arg0 == "ui_navup" then
		return "up"
	elseif f48_arg0 == "RIGHTARROW" or f48_arg0 == "ui_navright" then
		return "right"
	elseif f48_arg0 == "LEFTARROW" or f48_arg0 == "ui_navleft" then
		return "left"
	elseif f48_arg0 == "ui_confirm" then
		return "primary"
	else
		return nil
	end
end
LUI.UIElement.GetCorrespondingGamepadButtonString = function(f49_arg0)
	if f49_arg0 == Enum[@"luibutton"][@"lui_key_down"] then
		return "down"
	elseif f49_arg0 == Enum[@"luibutton"][@"lui_key_up"] then
		return "up"
	elseif f49_arg0 == Enum[@"luibutton"][@"lui_key_left"] then
		return "left"
	elseif f49_arg0 == Enum[@"luibutton"][@"lui_key_right"] then
		return "right"
	else
		return nil
	end
end
LUI.UIElement.setActive = function(f50_arg0, f50_arg1)
	if f50_arg0.m_preventFromBeingActive or not f50_arg0:hasClip("Active") and (not f50_arg0.internal or not f50_arg0.internal:hasClip("Active")) then
		return
	else
		f50_arg0.m_active = true
		f50_arg0:PlayMainBuiltinClip(true)
		f50_arg0:dispatchEventToChildren(f50_arg1)
	end
end
LUI.UIElement.__builtInClipTransitions = {
	DefaultClip = {
		Focus = "GainFocus",
		ChildFocus = "GainChildFocus",
		Active = "GainActive",
		ActiveAndFocus = "GainActiveAndFocus",
		ActiveAndChildFocus = "GainActiveAndChildFocus",
	},
	Focus = {
		DefaultClip = "LoseFocus",
		ActiveAndFocus = {
			"FocusToActiveAndFocus",
			"GainActiveAndFocus",
		},
	},
	ChildFocus = {
		DefaultClip = "LoseChildFocus",
		ActiveAndChildFocus = {
			"ChildFocusToActiveAndChildFocus",
			"GainActiveAndChildFocus",
		},
	},
	Active = {
		DefaultClip = "LoseActive",
		ActiveAndFocus = {
			"ActiveToActiveAndFocus",
			"GainActiveAndFocus",
		},
		ActiveAndChildFocus = {
			"ActiveToActiveAndChildFocus",
			"GainActiveAndChildFocus",
		},
	},
	ActiveAndFocus = {
		DefaultClip = "LoseActiveAndFocus",
		Active = {
			"ActiveAndFocusToActive",
			"LoseActiveAndFocus",
		},
		Focus = {
			"ActiveAndFocusToFocus",
			"LoseActiveAndFocus",
		},
	},
	ActiveAndChildFocus = {
		DefaultClip = "LoseActiveAndFocus",
		Active = {
			"ActiveAndChildFocusToActive",
			"LoseActiveAndChildFocus",
		},
		ChildFocus = {
			"ActiveAndChildFocusToChildFocus",
			"LoseActiveAndChildFocus",
		},
	},
}
LUI.UIElement.PlayMainBuiltinClip = function(f51_arg0, f51_arg1)
	assert(f51_arg1 ~= nil)
	local f51_local0 = nil
	local f51_local1 = false
	if f51_arg0.m_active then
		f51_local0 = "Active"
		if f51_arg0:isInFocus() and f51_arg0:hasClip("ActiveAndFocus") then
			f51_local0 = "ActiveAndFocus"
		elseif f51_arg0.__hasChildFocus and f51_arg0:hasClip("ActiveAndChildFocus") then
			f51_local0 = "ActiveAndChildFocus"
		end
	elseif f51_arg0.hasInputFocus and f51_arg0:hasClip("InputFocus") then
		f51_local0 = "InputFocus"
	elseif f51_arg0:isInFocus() then
		f51_local0 = "Focus"
	elseif f51_arg0.__hadChildInputFocus and f51_arg0:hasClip("ChildInputFocus") then
		f51_local0 = "ChildInputFocus"
	elseif f51_arg0.__hasChildFocus then
		f51_local0 = "ChildFocus"
	else
		f51_local0 = "DefaultClip"
	end
	if f51_local0 == nil or not f51_arg0:hasClip(f51_local0) then
		return false
	elseif f51_arg0.__lastClipPlayedState ~= f51_arg0.currentState then
		f51_arg1 = false
	end
	if not f51_arg1 then
		if f51_arg0:hasClip(f51_local0) then
			f51_local1 = f51_arg0:playClip(f51_local0, nil, true)
		end
		return f51_local1
	end
	local f51_local2 = nil
	local f51_local3 = LUI.UIElement.__builtInClipTransitions[f51_arg0.__lastClipPlayedName]
	if f51_local3 ~= nil then
		f51_local3 = f51_local3[f51_local0]
		if type(f51_local3) == "table" then
			for f51_local7, f51_local8 in ipairs(f51_local3) do
				if f51_arg0:hasClip(f51_local8) then
					f51_local2 = f51_local8
				end
			end
		else
			f51_local2 = f51_local3
		end
	end
	return f51_arg0:playClip(f51_local0, f51_local2, true)
end
LUI.UIElement.setInactive = function(f52_arg0, f52_arg1)
	if f52_arg0.m_preventFromBeingActive and not f52_arg0.m_active then
		return
	else
		f52_arg0.m_active = nil
		f52_arg0:PlayMainBuiltinClip(true)
		f52_arg0:dispatchEventToChildren(f52_arg1)
	end
end
LUI.UIElement.dispatchRecordElemFocusToParent = function(f53_arg0, f53_arg1, f53_arg2)
	f53_arg0:dispatchEventToParent({
		name = "record_curr_focused_elem_id",
		id = f53_arg0.id,
		controller = f53_arg1,
		idStack = {
			f53_arg0.id,
		},
		leaf = f53_arg0,
		disableUpdateCursorFocus = f53_arg2,
	})
end
LUI.UIElement.gainFocus = function(f54_arg0, f54_arg1)
	local f54_local0 = false
	if f54_arg0.__defaultFocus and f54_arg0.__defaultFocus:processEvent(f54_arg1) then
		f54_local0 = true
	elseif f54_arg0.m_focusable and not f54_arg0.onlyChildrenFocusable then
		f54_arg0:setFocus(true)
		f54_arg0.lastFocusedTimestamp = Engine[@"milliseconds"]()
		if f54_arg0.m_active then
			f54_local0 = true
		else
			f54_local0 = f54_arg0:hasClip("Focus")
		end
		f54_arg0:PlayMainBuiltinClip(not f54_arg1.skipGainFocus)
		if f54_local0 then
			if CursorInputEnabledForBuild(f54_arg1.controller) and (not IsFreeCursorActive(f54_arg1.controller) or f54_arg1.moveCursor and f54_arg1.menu and not f54_arg1.menu.ignoreCursor and IsGamepad(f54_arg1.controller) and IsFreeCursorActive(f54_arg1.controller)) then
				f54_arg0:centerFreeCursorOnElement(f54_arg1.controller)
				if not IsFreeCursorActiveAndVisible(f54_arg1.controller) then
					CoD.BaseSetMouseFocus(f54_arg1.controller, f54_arg0)
				end
			elseif CursorInputEnabledForBuild(f54_arg1.controller) and (not CoD.isPC or IsUsingKeyboardNavigation(f54_arg1.controller)) then
				CoD.BaseSetMouseFocus(f54_arg1.controller, f54_arg0)
			end
			f54_arg0:dispatchRecordElemFocusToParent(f54_arg1.controller, f54_arg1.disableUpdateCursorFocus == true)
		end
	elseif not f54_arg0.m_focusable then
		return false
	end
	if f54_local0 then
		return true
	end
	return f54_arg0:dispatchEventToChildren(f54_arg1)
end
LUI.UIElement.childFocusLost = function(f55_arg0)
	f55_arg0.__hasChildFocus = false
	f55_arg0:PlayMainBuiltinClip(true)
end
LUI.UIElement.childFocusGained = function(f56_arg0)
	f56_arg0.__hasChildFocus = true
	f56_arg0:PlayMainBuiltinClip(true)
end
LUI.UIElement.loseFocus = function(f57_arg0, f57_arg1)
	if f57_arg0.m_focusable and (f57_arg0:isInFocus() or f57_arg1.ignoreFocusCheck) then
		f57_arg0:setFocus(false)
		for f57_local0 = 1, #LUI.currentMouseFocus, 1 do
			if f57_arg0 == LUI.currentMouseFocus[f57_local0] then
				if CoD.isPC then
					if not f57_arg1.fromRecordCurrFocusedElem then
						f57_arg0:dispatchEventToParent({
							name = "clear_recorded_focus",
							disableUpdateCursorFocus = true,
						})
					end
				end
				LUI.currentMouseFocus[f57_local0] = false
			end
		end
		f57_arg0:PlayMainBuiltinClip(not f57_arg1.skipLoseFocus)
	end
	f57_arg0:dispatchEventToChildren(f57_arg1)
end
LUI.UIElement.dispatchRecordElemPCInputFocusToParent = function(f58_arg0, f58_arg1)
	f58_arg0:dispatchEventToParent({
		name = "record_inputfocus_elem_id",
		id = f58_arg0.id,
		controller = f58_arg1,
		idStack = {
			f58_arg0.id,
		},
	})
end
LUI.UIElement.gainInputFocus = function(f59_arg0, f59_arg1)
	local f59_local0 = false
	if f59_arg0:canTakeInputFocus() then
		f59_arg0.hasInputFocus = true
		f59_local0 = f59_arg0:hasClip("InputFocus")
		f59_arg0:PlayMainBuiltinClip(true)
		if f59_local0 then
			f59_arg0:dispatchRecordElemPCInputFocusToParent(f59_arg1.controller)
		end
		return true
	else
		return false
	end
end
LUI.UIElement.loseInputFocus = function(f60_arg0, f60_arg1)
	f60_arg0.hasInputFocus = false
	f60_arg0:PlayMainBuiltinClip(true)
	return true
end
LUI.UIElement.childPCInputFocusGained = function(f61_arg0)
	f61_arg0.__hadChildInputFocus = true
	f61_arg0:PlayMainBuiltinClip(false)
end
LUI.UIElement.childPCInputFocusLost = function(f62_arg0)
	f62_arg0.__hadChildInputFocus = false
	f62_arg0:PlayMainBuiltinClip(false)
end
LUI.UIElement.isInPCInputFocus = function(f63_arg0)
	local f63_local0 = f63_arg0:getMenu()
	if f63_local0 ~= nil then
		return f63_arg0 == f63_local0.currentInputFocus
	else
		return false
	end
end
LUI.UIElement.processEvent = function(f64_arg0, f64_arg1)
	local f64_local0 = f64_arg0.m_eventHandlers[f64_arg1.name]
	if f64_local0 ~= nil then
		return f64_local0(f64_arg0, f64_arg1)
	else
		return f64_arg0:dispatchEventToChildren(f64_arg1)
	end
end
LUI.UIElement.processEventToParent = function(f65_arg0, f65_arg1)
	local f65_local0 = f65_arg0.m_eventHandlers[f65_arg1.name]
	if f65_local0 ~= nil then
		return f65_local0(f65_arg0, f65_arg1)
	else
		return f65_arg0:dispatchEventToParent(f65_arg1)
	end
end
LUI.UIElement.getRoot = function(f66_arg0)
	if not f66_arg0 then
		return
	end
	local f66_local0 = f66_arg0:getParent()
	while f66_local0 do
		f66_arg0 = f66_local0
		f66_local0 = f66_local0:getParent()
	end
	return f66_arg0
end
LUI.UIElement.dispatchEventToRoot = function(f67_arg0, f67_arg1)
	local f67_local0 = f67_arg0:getParent()
	while f67_local0 do
		local f67_local1 = f67_local0:getParent()
		if f67_local1 == nil then
			local f67_local2 = f67_local0.m_eventHandlers[f67_arg1.name]
			if f67_local2 ~= nil then
				f67_local2(f67_local0, f67_arg1)
			end
			f67_local0:dispatchEventToChildren(f67_arg1)
			return
		end
		f67_local0 = f67_local1
	end
end
LUI.UIElement.dispatchEventToParent = function(f68_arg0, f68_arg1)
	local f68_local0 = f68_arg0:getParent()
	while f68_local0 do
		local f68_local1 = f68_local0.m_eventHandlers[f68_arg1.name]
		if f68_local1 then
			return f68_local1(f68_local0, f68_arg1)
		end
		f68_local0 = f68_local0:getParent()
	end
end
LUI.UIElement.dispatchEventToParentWithSelf = function(f69_arg0, f69_arg1)
	local f69_local0 = f69_arg0:getParent()
	while f69_local0 do
		local f69_local1 = f69_local0.m_eventHandlers[f69_arg1.name]
		if f69_local1 then
			return f69_local1(f69_arg0, f69_arg1)
		end
		f69_local0 = f69_local0:getParent()
	end
end
LUI.UIElement.dispatchEventToParentWithElement = function(f70_arg0, f70_arg1, f70_arg2)
	local f70_local0 = f70_arg0
	while f70_local0 do
		local f70_local1 = f70_local0.m_eventHandlers[f70_arg1.name]
		if f70_local1 then
			return f70_local1(f70_arg2, f70_arg1)
		end
		f70_local0 = f70_local0:getParent()
	end
end
LUI.UIElement.dispatchEventToChildren = function(f71_arg0, f71_arg1)
	local f71_local0 = f71_arg0:getFirstChild()
	if f71_local0 == nil then
		return
	end
	while f71_local0 ~= nil do
		local f71_local1 = f71_local0:getNextSibling()
		local f71_local2 = f71_local0:processEvent(f71_arg1)
		if f71_local2 then
			return f71_local2
		end
		f71_local0 = f71_local1
	end
end
LUI.UIElement.registerEventHandler = function(f72_arg0, f72_arg1, f72_arg2)
	f72_arg0.m_eventHandlers[f72_arg1] = f72_arg2
end
LUI.UIElement.appendEventHandler = function(f73_arg0, f73_arg1, f73_arg2)
	if not f73_arg0.m_eventHandlers[f73_arg1] then
		f73_arg0:registerEventHandler(f73_arg1, f73_arg2)
	else
		local f73_local0 = f73_arg0.m_eventHandlers[f73_arg1]
		f73_arg0.m_eventHandlers[f73_arg1] = function(f74_arg0, f74_arg1)
			return f73_arg2(f74_arg0, f74_arg1) or f73_local0(f74_arg0, f74_arg1)
		end
	end
end
LUI.UIElement.getMenu = function(f75_arg0)
	local f75_local0 = f75_arg0
	while f75_local0 and not f75_local0.menuName do
		f75_local0 = f75_local0:getParent()
	end
	return f75_local0
end
LUI.UIElement.isFocusable = function(f76_arg0)
	return f76_arg0.m_focusable
end
LUI.UIElement.anyChildFocusable = function(f77_arg0)
	if f77_arg0:isFocusable() then
		return true
	elseif f77_arg0.onlyChildrenFocusable then
		local f77_local0 = f77_arg0:getFirstChild()
		while f77_local0 ~= nil do
			if f77_local0:anyChildFocusable() then
				return true
			end
			f77_local0 = f77_local0:getNextSibling()
		end
	end
	return false
end
LUI.UIElement.canTakeInputFocus = function(f78_arg0)
	return f78_arg0:hasClip("InputFocus")
end
LUI.UIElement.makeFocusable = function(f79_arg0, f79_arg1)
	if f79_arg0.__forceFocusable then
		return
	elseif f79_arg0.m_focusable ~= true then
		f79_arg0.m_focusable = true
	end
	f79_arg0:dispatchEventToParent({
		name = "register_focusable_element",
		idStack = {
			f79_arg0.id,
		},
	})
	if CoD.GetMouseFocus(f79_arg1) == f79_arg0 or Engine[0x4B06D9D6B673AA](f79_arg1) then
		CoD.FreeCursorUtility.RetriggerCursorPosition(f79_arg0, f79_arg1)
	end
end
LUI.UIElement.makeFocusableWithoutResettingNavigation = function(f80_arg0, f80_arg1)
	if f80_arg0.__forceFocusable then
		return
	elseif f80_arg0.m_focusable ~= true then
		f80_arg0.m_focusable = true
	end
	f80_arg0:dispatchEventToParent({
		name = "register_focusable_element",
		idStack = {
			f80_arg0.id,
		},
	})
	local f80_local0 = CoD.GetMouseFocus(f80_arg1) == f80_arg0
	if f80_arg0 == Engine[0x4B06D9D6B673AA](f80_arg1) then
		f80_local0 = true
		Engine[@"hash_718F7786899BA625"](f80_arg1)
	end
	if f80_local0 then
		CoD.FreeCursorUtility.RetriggerCursorPosition(f80_arg0, f80_arg1)
	end
end
LUI.UIElement.makeNotFocusable = function(f81_arg0, f81_arg1)
	if f81_arg0.__forceFocusable then
		return
	elseif f81_arg0:isInFocus() then
		f81_arg0:processEvent({
			name = "lose_focus",
			controller = f81_arg1,
			ignoreFocusCheck = true,
		})
	end
	if f81_arg0.m_focusable then
		f81_arg0.m_focusable = false
		f81_arg0:dispatchEventToParent({
			name = "unregister_focusable_element",
			idStack = {
				f81_arg0.id,
			},
		})
	end
	local f81_local0 = CoD.GetMouseFocus(f81_arg1) == f81_arg0
	if f81_arg0 == Engine[0x4B06D9D6B673AA](f81_arg1) then
		f81_local0 = true
		Engine[@"hash_718F7786899BA625"](f81_arg1)
	end
	if f81_local0 then
		CoD.FreeCursorUtility.RetriggerCursorPosition(f81_arg0, f81_arg1)
	end
end
LUI.UIElement.updateFocusabilityFromState = function(f82_arg0, f82_arg1)
	if f82_arg0:hasClip("Focus") then
		f82_arg0:makeFocusableWithoutResettingNavigation(f82_arg1)
	else
		f82_arg0:makeNotFocusable(f82_arg1)
	end
end
LUI.UIElement.isIDNamed = function(f83_arg0)
	if string.find(f83_arg0.id, ".") then
		return true
	else
		return false
	end
end
LUI.UIElement.getFirstInFocus = function(f84_arg0)
	if f84_arg0:isInFocus() then
		return f84_arg0
	end
	local f84_local0 = f84_arg0:getFirstChild()
	while f84_local0 do
		local f84_local1 = f84_local0:getFirstInFocus()
		if f84_local1 then
			return f84_local1
		end
		f84_local0 = f84_local0:getNextSibling()
	end
	local f84_local1 = f84_arg0:getNextSibling()
	if f84_local1 then
		return f84_local1:getFirstInFocus()
	end
end
LUI.UIElement.doesElementOrChildHaveFocus = function(f85_arg0)
	if f85_arg0:isInFocus() then
		return true
	end
	local f85_local0 = f85_arg0:getFirstChild()
	while f85_local0 do
		if f85_local0:doesElementOrChildHaveFocus() then
			return true
		end
		f85_local0 = f85_local0:getNextSibling()
	end
	return false
end
LUI.UIElement.hasChildWithID = function(f86_arg0, f86_arg1)
	if f86_arg0.id == f86_arg1 then
		return true
	end
	local f86_local0 = f86_arg0:getFirstChild()
	while f86_local0 do
		if f86_local0:hasChildWithID(f86_arg1) then
			return true
		end
		f86_local0 = f86_local0:getNextSibling()
	end
	return false
end
LUI.UIElement.restoreFocus = function(f87_arg0, f87_arg1)
	local f87_local0 = f87_arg1.saveEvent
	if f87_local0 and f87_local0.idStack and #f87_local0.idStack > 0 and f87_arg0.id == f87_local0.idStack[1] then
		if #f87_local0.idStack == 1 then
			return f87_arg0:processEvent({
				name = "gain_focus",
				controller = f87_arg1.controller,
				saveEvent = f87_local0,
				moveCursor = true,
			})
		else
			table.remove(f87_local0.idStack, 1)
			return f87_arg0:dispatchEventToChildren(f87_arg1)
		end
	else
		return false
	end
end
LUI.UIElement.hide = function(f88_arg0)
	f88_arg0:setAlpha(0)
end
LUI.UIElement.show = function(f89_arg0)
	f89_arg0:setAlpha(1)
end
LUI.UIElement.UpdateSafeArea = function(f90_arg0, f90_arg1, f90_arg2, f90_arg3)
	if f90_arg1 ~= nil and f90_arg2 == nil then
		f90_arg2 = f90_arg1.controller
	end
	if f90_arg3 == nil then
		f90_arg3 = false
	end
	local f90_local0, f90_local1, f90_local2, f90_local3 = Engine[@"getusersafeareaforcontroller"](f90_arg2, f90_arg3)
	f90_arg0:setLeftRight(false, false, f90_local0, f90_local2)
	f90_arg0:setTopBottom(false, false, f90_local1, f90_local3)
end
LUI.UIElement.UpdateHUDArea = function(f91_arg0, f91_arg1, f91_arg2)
	f91_arg0:UpdateSafeArea(f91_arg1, f91_arg2, true)
end
LUI.UIElement.sizeToSafeArea = function(f92_arg0, f92_arg1, f92_arg2)
	f92_arg0:UpdateSafeArea(nil, f92_arg1, f92_arg2)
	if f92_arg2 and CoD.isPC then
		f92_arg0:registerEventHandler("update_safe_area", f92_arg0.UpdateHUDArea)
	else
		f92_arg0:registerEventHandler("update_safe_area", f92_arg0.UpdateSafeArea)
	end
end
LUI.UIElement.UpdateScreenSize = function(f93_arg0, f93_arg1, f93_arg2)
	if f93_arg1 ~= nil and f93_arg2 == nil then
		f93_arg2 = f93_arg1.controller
	end
	local f93_local0, f93_local1, f93_local2 = Engine[@"hash_6913E41040C17FD"](f93_arg2)
	local f93_local3 = 1920
	local f93_local4 = 0
	local f93_local5 = f93_local3
	if f93_local2 >= 1.78 then
		local f93_local6 = (1080 * f93_local2 - f93_local3) / 2
		f93_local4 = -f93_local6
		f93_local5 = f93_local3 + f93_local6
	end
	local f93_local7, f93_local8, f93_local6, f93_local9 = f93_arg0:getLocalLeftRight()
	f93_arg0:setLeftRight(f93_local7, f93_local8, f93_local4, f93_local5)
end
LUI.UIElement.sizeToWidthOfScreen = function(f94_arg0, f94_arg1)
	if CoD.isPC or IsSplitscreenAndInGame(f94_arg1) then
		f94_arg0:UpdateScreenSize(f94_arg0, f94_arg1)
		f94_arg0:registerEventHandler("update_safe_area", f94_arg0.UpdateScreenSize)
	end
end
LUI.UIElement.setStateByHash = function(f95_arg0, f95_arg1, f95_arg2, f95_arg3, f95_arg4)
	if f95_arg0.__clipsPerState then
		for f95_local3, f95_local4 in pairs(f95_arg0.__clipsPerState) do
			if f95_arg2 == Engine[@"converttoxhash"](f95_local3) then
				f95_arg0:setState(f95_arg1, f95_local3, f95_arg3, f95_arg4)
				break
			end
		end
	end
end
LUI.UIElement.setState = function(f96_arg0, f96_arg1, f96_arg2, f96_arg3, f96_arg4)
	if f96_arg0.currentState == f96_arg2 and not f96_arg0.ignoreCurrentStateCheck and not f96_arg4 then
		return false
	end
	local f96_local0 = f96_arg0.currentState
	local f96_local1
	if not f96_arg3 then
		f96_local1 = f96_arg0:hasClip(f96_arg2)
	else
		f96_local1 = false
	end
	f96_arg0.currentState = f96_arg2
	local f96_local2 = f96_local1
	local f96_local3 = "DefaultClip"
	local f96_local4 = nil
	if f96_arg0:isInFocus() and f96_arg0:hasClip("Focus") then
		f96_local3 = "Focus"
		f96_local1 = false
		f96_local2 = false
	elseif f96_arg0:hasClip("Selected") and f96_arg0.gridInfoTable and f96_arg0.gridInfoTable.parentGrid.currentSelection == f96_arg0 then
		f96_local3 = "Selected"
		f96_local2 = false
	elseif not f96_local0 and f96_arg0:hasClip("Intro") then
		f96_local3 = "DefaultClip"
		f96_local4 = "Intro"
		f96_local1 = false
	elseif f96_arg0.__hasChildFocus and f96_arg0:hasClip("ChildFocus") then
		f96_local3 = "ChildFocus"
		f96_local1 = false
		f96_local2 = false
	end
	f96_arg0:updateFocusabilityFromState(f96_arg1)
	if f96_local1 then
		f96_arg0.nextClip = f96_local3
		f96_arg0.currentClipIsTransitionClip = f96_local2
		f96_arg0.__clipsPerState[f96_local0][f96_arg2](f96_arg0, f96_arg1)
		if f96_arg0.elementsPlayingClips > 0 then
			f96_arg0.nextClip = f96_local3
			f96_arg0.currentClipIsTransitionClip = f96_local2
		end
		if LUI.DEV and f96_arg0.elementsPlayingClips > 0 and Dvar[@"hash_6418FCB2A75FD098"]:get() then
			f96_arg0._clipNameSentToDevhost = f96_local0 .. "." .. f96_arg2
			Engine[@"hash_4E8C680715D701AE"](LUI.DEV.DebugElementPath(f96_arg0), f96_arg0._clipNameSentToDevhost, true)
		end
	else
		f96_arg0:playClip(f96_local3, f96_local4)
	end
	return true
end
LUI.UIElement.mergeStateConditions = function(f97_arg0, f97_arg1, f97_arg2)
	if not f97_arg2 then
		if not f97_arg0.stateConditions then
			f97_arg0.stateConditions = {}
		end
		f97_arg2 = f97_arg0.stateConditions
	end
	local f97_local0 = function(f98_arg0)
		for f98_local3, f98_local4 in ipairs(f97_arg2) do
			if f98_local4.stateName == f98_arg0 then
				return f98_local3
			end
		end
		return nil
	end
	for f97_local4, f97_local5 in ipairs(f97_arg1) do
		local f97_local6 = f97_local0(f97_local5.stateName)
		if f97_local6 == nil then
			table.insert(f97_arg2, LUI.ShallowCopy(f97_local5))
		else
			f97_arg2[f97_local6] = LUI.ShallowCopy(f97_local5)
		end
	end
end
LUI.UIElement.clipOver = function(f99_arg0, f99_arg1)
	if LUI.DEV and f99_arg0._clipNameSentToDevhost then
		if Dvar[@"hash_6418FCB2A75FD098"]:get() then
			Engine[@"hash_4E8C680715D701AE"](LUI.DEV.DebugElementPath(f99_arg0), f99_arg0._clipNameSentToDevhost, false)
		end
		f99_arg0._clipNameSentToDevhost = nil
	end
	if f99_arg0.nextClip then
		f99_arg0:playClip(f99_arg0.nextClip)
	end
end
LUI.UIElement.playClip = function(f100_arg0, f100_arg1, f100_arg2, f100_arg3)
	if not f100_arg0.currentState then
		f100_arg0.currentState = "DefaultState"
	end
	local f100_local0 = LUI.getTableFromPath("__clipsPerState." .. f100_arg0.currentState, f100_arg0)
	if f100_local0 then
		local f100_local1 = f100_arg0.m_ownerController
		if not f100_local1 then
			f100_local1 = Engine[@"getprimarycontroller"]()
		end
		if f100_arg3 and f100_local0[f100_arg1] == f100_arg0.__lastClipPlayed then
			return false
		end
		f100_arg0.nextClip = nil
		f100_arg0.currentClipIsTransitionClip = false
		if f100_local0[f100_arg2] then
			f100_arg0.nextClip = f100_arg1
			f100_local0[f100_arg2](f100_arg0, f100_local1)
			f100_arg0.__lastClipPlayed = f100_local0[f100_arg1]
			f100_arg0.__lastClipPlayedName = f100_arg1
			f100_arg0.__lastClipPlayedState = f100_arg0.currentState
		elseif f100_local0[f100_arg1] then
			f100_local0[f100_arg1](f100_arg0, f100_local1)
			f100_arg0.__lastClipPlayed = f100_local0[f100_arg1]
			f100_arg0.__lastClipPlayedName = f100_arg1
			f100_arg0.__lastClipPlayedState = f100_arg0.currentState
		else
			return false
		end
		if LUI.DEV and f100_arg0.elementsPlayingClips > 0 and Dvar[@"hash_6418FCB2A75FD098"]:get() then
			local f100_local2 = f100_arg0.currentState
			local f100_local3 = "."
			if f100_local0[f100_arg2] then
				local f100_local4 = f100_arg2
			end
			f100_arg0._clipNameSentToDevhost = f100_local2 .. f100_local3 .. (f100_local4 or f100_arg1)
			Engine[@"hash_4E8C680715D701AE"](LUI.DEV.DebugElementPath(f100_arg0), f100_arg0._clipNameSentToDevhost, true)
		end
		return true
	else
		f100_arg0.nextClip = nil
		f100_arg0.currentClipIsTransitionClip = false
		return false
	end
end
LUI.UIElement.hasClip = function(f101_arg0, f101_arg1)
	if f101_arg0.__clipsPerState and f101_arg0.__clipsPerState[f101_arg0.currentState] and f101_arg0.__clipsPerState[f101_arg0.currentState][f101_arg1] then
		return true
	else
		return false
	end
end
LUI.UIElement.setupElementClipCounter = function(f102_arg0, f102_arg1)
	f102_arg0.elementsPlayingClips = f102_arg1
	if f102_arg0.elementsPlayingClips == 0 then
		f102_arg0:processEvent({
			name = "clip_over",
		})
	end
end
LUI.UIElement.childClipFinished = function(f103_arg0)
	f103_arg0.elementsPlayingClips = f103_arg0.elementsPlayingClips - 1
	if f103_arg0.elementsPlayingClips == 0 then
		f103_arg0:processEvent({
			name = "clip_over",
		})
	end
end
LUI.UIElement.clipInterrupted = function(f104_arg0, f104_arg1)
	f104_arg0:registerEventHandler("interrupted_keyframe", nil)
	local f104_local0 = f104_arg0:getParent()
	if f104_local0 ~= nil and f104_local0.currentClipIsTransitionClip then
		f104_local0:childClipFinished()
	end
end
LUI.UIElement.clipFinished = function(f105_arg0, f105_arg1)
	f105_arg0:registerEventHandler("interrupted_keyframe", nil)
	local f105_local0 = f105_arg0:getParent()
	if f105_local0 ~= nil then
		f105_local0:childClipFinished()
	end
end
LUI.UIElement.updateState = function(f106_arg0, f106_arg1)
	local f106_local0 = f106_arg1.menu or f106_arg0
	while f106_local0 do
		if f106_local0.updateElementState then
			f106_arg1.menu = f106_local0
			f106_local0:updateElementState(f106_arg0, f106_arg1)
			if f106_arg1.forceDispatch then
				f106_arg0:dispatchEventToChildren(f106_arg1)
			end
			return
		end
		f106_local0 = f106_local0:getParent()
	end
end
LUI.UIElement.RecordCurrFocusedElemID = function(f107_arg0, f107_arg1)
	if not f107_arg1.idStack then
		error("LUI Error: " .. f107_arg1.name .. " processed without event.idStack ")
	end
	table.insert(f107_arg1.idStack, 1, f107_arg0.id)
	return f107_arg0:dispatchEventToParent(f107_arg1)
end
LUI.UIElement.RecordCurrPCInputFocusElemID = function(f108_arg0, f108_arg1)
	if not f108_arg1.idStack then
		error("LUI Error: " .. f108_arg1.name .. " processed without event.idStack ")
	end
	table.insert(f108_arg1.idStack, 1, f108_arg0.id)
	return f108_arg0:dispatchEventToParent(f108_arg1)
end
LUI.UIElement.RecordCurrOverElemID = function(f109_arg0, f109_arg1)
	if not f109_arg1.idStack then
		error("LUI Error: " .. f109_arg1.name .. " processed without event.idStack ")
	end
	table.insert(f109_arg1.idStack, 1, f109_arg0.id)
	return f109_arg0:dispatchEventToParent(f109_arg1)
end
LUI.UIElement.newIndexMeta = function(f110_arg0, f110_arg1, f110_arg2)
	if f110_arg0.__varWatchers and f110_arg0.__varWatchers[f110_arg1] then
		for f110_local3, f110_local4 in ipairs(f110_arg0.__varWatchers[f110_arg1]) do
			f110_local4(f110_arg0, f110_arg1, f110_arg0[f110_arg1], f110_arg2)
		end
	end
	rawset(f110_arg0, f110_arg1, f110_arg2)
end
LUI.UIElement.defaultVarWatcherCallback = function(f111_arg0, f111_arg1, f111_arg2, f111_arg3)
	print((f111_arg0.id or "<unnamed>") .. '[ "' .. f111_arg1 .. '" ] change from ' .. tostring(f111_arg2) .. " to " .. tostring(f111_arg3))
	if debug and debug.traceback then
		print(debug.traceback())
	end
end
LUI.UIElement.addDebugVariableWatcher = function(f112_arg0, f112_arg1, f112_arg2)
	if not f112_arg0.__varWatchers then
		f112_arg0.__varWatchers = {}
	end
	if not f112_arg0.__varWatchers[f112_arg1] then
		f112_arg0.__varWatchers[f112_arg1] = {}
	end
	if f112_arg2 then
		table.insert(f112_arg0.__varWatchers[f112_arg1], f112_arg2)
	elseif f112_arg0.__varWatchers[f112_arg1][1] ~= LUI.UIElement.defaultVarWatcherCallback then
		table.insert(f112_arg0.__varWatchers[f112_arg1], 1, LUI.UIElement.defaultVarWatcherCallback)
	end
end
LUI.UIElement.setInitialClass = function(f113_arg0, f113_arg1)
	local f113_local0 = getmetatable(f113_arg0)
	local f113_local1 = f113_local0.__newindex
	if LUI.DEV then
		setmetatable(f113_local1, {
			__index = f113_arg1,
			__newindex = LUI.UIElement.newIndexMeta,
		})
	else
		setmetatable(f113_local1, {
			__index = f113_arg1,
		})
	end
	setmetatable(f113_local1.m_eventHandlers, {
		__index = f113_arg1.m_eventHandlers,
	})
end
LUI.UIElement.setClass = function(f114_arg0, f114_arg1)
	local f114_local0 = getmetatable(f114_arg0)
	local f114_local1 = f114_local0.__newindex
	local f114_local2 = getmetatable(f114_local1)
	if not f114_local2 then
		setmetatable(f114_local1, {
			__index = f114_arg1,
		})
	else
		f114_local2.__index = f114_arg1
	end
	local f114_local3 = getmetatable(f114_local1.m_eventHandlers)
	if not f114_local3 then
		setmetatable(f114_local1.m_eventHandlers, {
			__index = f114_arg1.m_eventHandlers,
		})
	else
		f114_local3.__index = f114_arg1.m_eventHandlers
	end
end
LUI.UIElement.getParentMenu = function(f115_arg0)
	local f115_local0 = f115_arg0
	while f115_local0 ~= nil and not f115_local0.menuName do
		f115_local0 = f115_local0:getParent()
	end
	return f115_local0
end
LUI.UIElement.getPreviousFocusableSibling = function(f116_arg0)
	local f116_local0 = f116_arg0:getPreviousSibling()
	while f116_local0 do
		if f116_local0.m_focusable or f116_local0.onlyChildrenFocusable then
			return f116_local0
		end
		f116_local0 = f116_local0:getPreviousSibling()
	end
	return nil
end
LUI.UIElement.getNextFocusableSibling = function(f117_arg0)
	local f117_local0 = f117_arg0:getNextSibling()
	while f117_local0 do
		if f117_local0.m_focusable or f117_local0.onlyChildrenFocusable then
			return f117_local0
		end
		f117_local0 = f117_local0:getNextSibling()
	end
	return nil
end
LUI.UIElement.RegisterFocusableElement = function(f118_arg0, f118_arg1)
	table.insert(f118_arg1.idStack, 1, f118_arg0.id)
	return f118_arg0:dispatchEventToParent(f118_arg1)
end
LUI.UIElement.UnregisterFocusableElement = function(f119_arg0, f119_arg1)
	table.insert(f119_arg1.idStack, 1, f119_arg0.id)
	return f119_arg0:dispatchEventToParent(f119_arg1)
end
LUI.UIElement.AddContextualMenuAction = function(f120_arg0, f120_arg1, f120_arg2, f120_arg3, f120_arg4)
	if not CoD.isPC then
		return
	elseif f120_arg1.__ignoreContextualMenu then
		return
	elseif not f120_arg0.__contextualMenuActions then
		f120_arg0.__contextualMenuActions = {}
	end
	table.insert(f120_arg0.__contextualMenuActions, {
		actionName = f120_arg3,
		getActionFunction = f120_arg4,
	})
	if f120_arg0.__contextualMenuRightMouseEventRegistered == nil then
		f120_arg0.__contextualMenuRightMouseEventRegistered = {}
	end
	if not f120_arg0.__contextualMenuRightMouseEventRegistered[f120_arg1] then
		f120_arg0.__contextualMenuRightMouseEventRegistered[f120_arg1] = true
		f120_arg1:AddButtonCallbackFunction(f120_arg0, f120_arg2, Enum[@"luibutton"][@"lui_key_none"], "MOUSE2", function(element, menu, controller, model)
			CoD.PCWidgetUtility.CloseContextualMenu(menu, controller)
			if f120_arg0.__contextualMenuTitleModelPath then
				CoD.PCWidgetUtility.ContextualMenuTitleModel = CoD.ModelUtility.GetSelfModelPath(element, f120_arg0.__contextualMenuTitleModelPath)
			else
				CoD.PCWidgetUtility.ContextualMenuTitleModel = nil
			end
			if f120_arg0.__contextualMenuSecondLineModelPath and f120_arg0.__contextualMenuSecondLineModelPath ~= "" then
				CoD.PCWidgetUtility.ContextualMenuSecondLineModel = CoD.ModelUtility.GetSelfModelPath(element, f120_arg0.__contextualMenuSecondLineModelPath)
			else
				CoD.PCWidgetUtility.ContextualMenuSecondLineModel = nil
			end
			if f120_arg0.__contextualMenuXuidModelPath and f120_arg0.__contextualMenuXuidModelPath ~= "" then
				CoD.PCWidgetUtility.ContextualMenuXuidModel = CoD.ModelUtility.GetSelfModelPath(element, f120_arg0.__contextualMenuXuidModelPath)
			else
				CoD.PCWidgetUtility.ContextualMenuXuidModel = nil
			end
			CoD.PCWidgetUtility.PrepareContextualMenuActions(element, menu, controller, model, f120_arg0.__contextualMenuActions)
			if #CoD.PCWidgetUtility.ContextualMenuActions == 0 then
				return false
			end
			menu.ContextualMenu = CoD.ContextualMenu.new(menu, controller, 0, 0, 0, 0, 0, 0, 0, 0)
			menu.ContextualMenu:setPriority(2000)
			menu:addElement(menu.ContextualMenu)
			menu:ChangeFocusedElement(controller, nil, false)
			local f121_local0 = menu.ContextualMenu.ActionList
			f121_local0:setVerticalCount(#CoD.PCWidgetUtility.ContextualMenuActions)
			f121_local0:setAutoScaleContentHeight(false)
			menu.ContextualMenu:processEvent({
				name = "update_state",
				controller = controller,
				menu = menu,
			})
			local f121_local1, f121_local2, f121_local3, f121_local4 = f121_local0:getLocalRect()
			LUI.GridLayout.menuOpened(f121_local0)
			local f121_local5 = 1
			local f121_local6 = 1
			local f121_local7, f121_local8 = Engine[@"getscreensize"](controller)
			local f121_local9, f121_local10, f121_local11, f121_local12 = menu:getRect()
			if f121_local9 ~= nil then
				f121_local5 = f121_local7 / (f121_local11 - f121_local9)
				f121_local6 = f121_local8 / (f121_local12 - f121_local10)
			end
			local f121_local13 = DataSources.FreeCursor.getModel(controller)
			local f121_local13, f121_local14 = f121_local13.position:get()
			local f121_local15 = f121_local13 * f121_local5
			local f121_local16 = f121_local14 * f121_local6
			local f121_local17 = math.max(CoD.ContextualMenu.__defaultWidth, menu.ContextualMenu:GetLargestTextWidth() + 20)
			local f121_local18 = f121_local0.height + CoD.ContextualMenu.__defaultHeight - f121_local4 - f121_local2
			local f121_local19 = f121_local15 + f121_local17
			if f121_local7 < f121_local19 then
				local f121_local20 = math.min(f121_local19 - f121_local7, f121_local15)
				f121_local15 = f121_local15 - f121_local20
				f121_local19 = f121_local19 - f121_local20
			end
			local f121_local20 = f121_local16 + f121_local18
			if f121_local8 < f121_local20 then
				local f121_local21 = math.min(f121_local20 - f121_local8, f121_local16)
				f121_local16 = f121_local16 - f121_local21
				f121_local20 = f121_local20 - f121_local21
			end
			menu.ContextualMenu:setLeftRight(0, 0, f121_local15, f121_local19)
			menu.ContextualMenu:setTopBottom(0, 0, f121_local16, f121_local20)
			for f121_local24, f121_local25, f121_local26 in f121_local0:forEachElement() do
				menu:AddButtonCallbackFunction(f121_local26, controller, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
					local f122_local0 = CoD.SafeGetModelValue(f121_local26:getModel(), "getActionFunction")
					local f122_local1 = f122_local0 and f122_local0(element, menu, controller, model)
					if f122_local1 then
						f122_local1(element, menu, controller, model)
					end
					CoD.PCWidgetUtility.CloseContextualMenu(menu, controller)
					return true
				end, nil, false)
			end
			menu:AddButtonCallbackFunction(menu.ContextualMenu, controller, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
				CoD.PCWidgetUtility.CloseContextualMenu(menu, controller)
				return true
			end, nil, false)
			menu.ContextualMenu:registerEventHandler("input_source_changed", function(element, event)
				CoD.PCWidgetUtility.CloseContextualMenu(menu, controller)
				return true
			end)
			LUI.OverrideFunction_CallOriginalSecond(f120_arg0, "close", function()
				CoD.PCWidgetUtility.CloseContextualMenu(menu, controller)
			end)
			LUI.OverrideFunction_CallOriginalSecond(element, "close", function()
				CoD.PCWidgetUtility.CloseContextualMenu(menu, controller)
			end)
			if CoD.PCWidgetUtility.ContextualMenuTitleModel and not CoD.PCWidgetUtility.ContextualMenuXuidModel then
				menu.ContextualMenu:subscribeToModel(CoD.PCWidgetUtility.ContextualMenuTitleModel, function(model, f127_arg1)
					CoD.PCWidgetUtility.CloseContextualMenu(menu, controller)
				end, false)
			end
			return true
		end, nil, false)
	end
end
LUI.UIElement.GetLargestTextWidth = function(f128_arg0)
	local f128_local0 = f128_arg0:getTextWidth()
	local f128_local1 = f128_arg0:getFirstChild()
	while f128_local1 do
		f128_local0 = math.max(f128_local0, f128_local1:GetLargestTextWidth())
		f128_local1 = f128_local1:getNextSibling()
	end
	return f128_local0
end
LUI.UIElement.MouseButtonEvent = function(f129_arg0, f129_arg1)
	if f129_arg0.disabled or f129_arg0.m_inputDisabled or f129_arg0.m_mouseDisabled or not f129_arg0:isVisible() then
		return
	elseif f129_arg0.handleMouseButton then
		local f129_local0 = LUI.UIElement.IsMouseInsideElement(f129_arg0, f129_arg1.controller)
		local f129_local1 = DataSources.FreeCursor.getModel(f129_arg1.controller)
		local f129_local1, f129_local2 = f129_local1.position:get()
		if f129_arg1.name == "mouseup" then
			if f129_arg1.button == "left" and f129_arg0.m_leftMouseDown ~= nil then
				f129_arg0.m_leftMouseDown = nil
				if f129_arg0.m_eventHandlers.leftmouseup ~= nil then
					local f129_local3 = f129_arg0.m_eventHandlers:leftmouseup({
						name = "leftmouseup",
						controller = f129_arg1.controller,
						root = f129_arg1.root,
						x = f129_local1,
						y = f129_local2,
						inside = f129_local0,
					})
					if f129_local3 then
						return f129_local3
					end
				end
			end
			if f129_arg1.button == "right" and f129_arg0.m_rightMouseDown ~= nil then
				f129_arg0.m_rightMouseDown = nil
				if f129_arg0.m_eventHandlers.rightmouseup ~= nil then
					local f129_local3 = f129_arg0.m_eventHandlers:rightmouseup({
						name = "rightmouseup",
						controller = f129_arg1.controller,
						root = f129_arg1.root,
						x = f129_local1,
						y = f129_local2,
						inside = f129_local0,
					})
					if f129_local3 then
						return f129_local3
					end
				end
			end
		end
		if f129_local0 and f129_arg1.name == "mousedown" then
			if f129_arg1.button == "left" and f129_arg0.m_eventHandlers.leftmousedown ~= nil and f129_arg0.m_leftMouseDown == nil then
				f129_arg0.m_leftMouseDown = true
				local f129_local3 = f129_arg0.m_eventHandlers:leftmousedown({
					name = "leftmousedown",
					controller = f129_arg1.controller,
					root = f129_arg1.root,
					x = f129_local1,
					y = f129_local2,
					inside = f129_local0,
				})
				if f129_local3 then
					return f129_local3
				end
			end
			if f129_arg1.button == "right" and f129_arg0.m_eventHandlers.rightmousedown ~= nil and f129_arg0.m_rightMouseDown == nil then
				f129_arg0.m_rightMouseDown = true
				local f129_local3 = f129_arg0.m_eventHandlers:rightmousedown({
					name = "rightmousedown",
					controller = f129_arg1.controller,
					root = f129_arg1.root,
					x = f129_local1,
					y = f129_local2,
					inside = f129_local0,
				})
				if f129_local3 then
					return f129_local3
				end
			end
		end
	end
end
LUI.UIElement.m_eventHandlers = {
	gain_focus = LUI.UIElement.gainFocus,
	lose_focus = LUI.UIElement.loseFocus,
	gain_active = LUI.UIElement.setActive,
	lose_active = LUI.UIElement.setInactive,
	restore_focus = LUI.UIElement.restoreFocus,
	close = LUI.UIElement.close,
	clip_over = LUI.UIElement.clipOver,
	update_state = LUI.UIElement.updateState,
	record_curr_focused_elem_id = LUI.UIElement.RecordCurrFocusedElemID,
	record_inputfocus_elem_id = LUI.UIElement.RecordCurrPCInputFocusElemID,
	gain_input_focus = LUI.UIElement.gainInputFocus,
	lose_input_focus = LUI.UIElement.loseInputFocus,
	register_focusable_element = LUI.UIElement.RegisterFocusableElement,
	unregister_focusable_element = LUI.UIElement.UnregisterFocusableElement,
	set_model = LUI.UIElement.SetModelFromEvent,
}
LUI.UIElement.new = function(f130_arg0, f130_arg1, f130_arg2, f130_arg3, f130_arg4, f130_arg5, f130_arg6, f130_arg7)
	local f130_local0
	if f130_arg0 then
		f130_local0 = ConstructLUIElement(f130_arg0, f130_arg1, f130_arg2, f130_arg3, f130_arg4, f130_arg5, f130_arg6, f130_arg7)
		if not f130_local0 then
		else
			LUI.UIElement.setInitialClass(f130_local0, LUI.UIElement)
			return f130_local0
		end
	end
	f130_local0 = ConstructLUIElement(LUI.UIElement.m_defaultAnimationState)
end
LUI.UIElement.fakeElemMetaTable = {
	__index = function(f131_arg0, f131_arg1)
		if f131_arg1 == "__isFake" then
			return true
		else
			return f131_arg0
		end
	end,
	__call = function()
		return nil
	end,
	__newIndex = function() end,
}
LUI.UIElement.createFake = function()
	return setmetatable({}, LUI.UIElement.fakeElemMetaTable)
end
LUI.UIElement.showDebugTimer = function(f135_arg0, f135_arg1)
	local f135_local0 = f135_arg0.playClip
	f135_arg0.playClip = function(f136_arg0, f136_arg1)
		f135_local0(f136_arg0, f136_arg1)
		if f136_arg0.elementsPlayingClips ~= nil and f136_arg0.elementsPlayingClips > 0 then
			f136_arg0._debugTimerIndex = Engine[@"setdebugtimerinfo"](f136_arg0.id .. ":" .. f136_arg0.currentState .. ":" .. f136_arg1, f136_arg0._debugTimerIndex)
		end
	end
	f135_arg0:registerEventHandler("clip_over", function(element, event)
		if element._debugTimerIndex ~= nil then
			Engine[@"setdebugtimerinfo"]("", element._debugTimerIndex)
			element._debugTimerIndex = nil
		end
		LUI.UIElement.clipOver(element, event)
	end)
	local f135_local1 = f135_arg0.close
	f135_arg0.close = function(f138_arg0)
		f135_local1(f138_arg0)
		if f138_arg0._debugTimerIndex ~= nil then
			Engine[@"setdebugtimerinfo"]("", f138_arg0._debugTimerIndex)
			f138_arg0._debugTimerIndex = nil
		end
	end
end
LUI.UIElement.ContainerState = {
	left = 0,
	top = 0,
	right = 0,
	bottom = 0,
	leftPct = 0,
	topPct = 0,
	rightPct = 1,
	bottomPct = 1,
	leftAnchor = true,
	topAnchor = true,
	rightAnchor = true,
	bottomAnchor = true,
}
LUI.UIContainer.new = function()
	return LUI.UIElement.new(LUI.UIElement.ContainerState)
end
