require("x64:4083528baeb2f3d")
require("x64:fc4b916e71c9ca9")
LUI.UIList = InheritFrom(LUI.GridLayout)
local f0_local0 = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = f1_arg0.m_eventHandlers[f1_arg1]
	if f1_local0 then
		f1_arg0:registerEventHandler(f1_arg1, function(element, event)
			f1_local0(element, event)
			return f1_arg2(element, event)
		end)
	else
		f1_arg0:registerEventHandler(f1_arg1, f1_arg2)
	end
end
local f0_local1 = function(f3_arg0, f3_arg1)
	if CoD.isPC and not f3_arg0.__enablePCListSelectionBehavior then
		f3_arg1.m_preventFromBeingActive = true
	end
	f3_arg1:appendEventHandler("gain_focus", function(f4_arg0, f4_arg1)
		if not f3_arg0.m_managedItemPriority then
			f4_arg0:setPriority(100)
		end
		if not f4_arg1.sourceType or f4_arg1.sourceType ~= "list" then
			if f3_arg0.__disableActiveOnFocus then
				return true
			elseif f4_arg1.isMouse then
				if not f3_arg0.hasListFocus then
					f3_arg0:processEvent({
						name = "gain_focus",
						controller = f4_arg1.controller,
						selectIndex = f4_arg0.gridInfoTable.zeroBasedIndex,
					})
				end
				f3_arg0.super:setActiveItem(f4_arg0)
				f3_arg0:setListItemInFocus(f3_arg1, nil, f4_arg1.isMouse)
				if not IsFreeCursorActiveAndVisible(f3_arg0.controller) and not f3_arg0:playSound("list_up") then
					f3_arg0:playSound("list_right")
				end
			else
				f3_arg0:setActiveItem(f4_arg0)
			end
			return true
		else
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(f3_arg1, "childFocusGained", function(element)
		if not f3_arg0.m_managedItemPriority then
			element:setPriority(100)
		end
		if not f3_arg0.__disableActiveOnFocus and element ~= f3_arg0.activeWidget then
			f3_arg0:setActiveItem(element)
		end
	end)
	f3_arg1:appendEventHandler("lose_focus", function(f6_arg0, f6_arg1)
		if not f3_arg0.m_managedItemPriority then
			f6_arg0:setPriority(0)
		end
		local f6_local0 = LUI.ShallowCopy(f6_arg1)
		f6_local0.keepSelected = f6_arg0 == f3_arg0.currentSelection
		f6_arg0:loseFocus(f6_local0)
		f6_local0 = LUI.ShallowCopy(f6_arg1)
		f6_local0.name = "list_item_lose_focus"
		f3_arg0:dispatchEventToParentWithElement(f6_local0, f6_arg0)
		if f6_arg0 == f3_arg0.activeWidget then
			if f3_arg0.currentSelection then
				f3_arg0:setActiveItem(f3_arg0.currentSelection)
			end
			if not f6_arg1.isMouse then
				f3_arg0:processEvent({
					name = "lose_focus",
					controller = f6_arg1.controller,
				})
			end
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(f3_arg1, "childFocusLost", function(element)
		if not f3_arg0.m_managedItemPriority then
			element:setPriority(0)
		end
		f3_arg0:dispatchEventToParentWithElement({
			name = "list_item_lose_focus",
			controller = f3_arg0.controller,
		}, element)
	end)
end
LUI.UIList.addUpDownNavigation = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	if f8_arg0._hasUpDownNav then
		return
	else
		f8_arg0._hasUpDownNav = true
		f8_arg3 = (f8_arg3 or 0) | LUI.GridLayout.NavigationFlags.CHANGE_FOCUS
		CoD.Menu.AddButtonCallbackFunction(f8_arg1, f8_arg0, f8_arg2, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], "ui_navup", function(element, menu, controller, f9_arg3)
			if not f8_arg0.m_disableNavigation and (not (not f8_arg0.dpadDisabled or not IsDpadButton(f9_arg3)) or f8_arg0:navigateItemUp(f8_arg3)) then
				return true
			else
			end
		end)
		CoD.Menu.AddButtonCallbackFunction(f8_arg1, f8_arg0, f8_arg2, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], "ui_navdown", function(element, menu, controller, f10_arg3)
			if not f8_arg0.m_disableNavigation and (not (not f8_arg0.dpadDisabled or not IsDpadButton(f10_arg3)) or f8_arg0:navigateItemDown(f8_arg3)) then
				return true
			else
			end
		end)
	end
end
LUI.UIList.addLeftRightNavigation = function(f11_arg0, f11_arg1, f11_arg2)
	if f11_arg0._hasLeftRightNav then
		return
	else
		f11_arg0._hasLeftRightNav = true
		local f11_local0 = LUI.GridLayout.NavigationFlags.CHANGE_FOCUS
		CoD.Menu.AddButtonCallbackFunction(f11_arg1, f11_arg0, f11_arg2, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], "ui_navleft", function(element, menu, controller, f12_arg3)
			if not f11_arg0.m_disableNavigation and (not (not f11_arg0.dpadDisabled or not IsDpadButton(f12_arg3)) or f11_arg0:navigateItemLeft(f11_local0)) then
				return true
			else
			end
		end)
		CoD.Menu.AddButtonCallbackFunction(f11_arg1, f11_arg0, f11_arg2, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], "ui_navright", function(element, menu, controller, f13_arg3)
			if not f11_arg0.m_disableNavigation and (not (not f11_arg0.dpadDisabled or not IsDpadButton(f13_arg3)) or f11_arg0:navigateItemRight(f11_local0)) then
				return true
			else
			end
		end)
	end
end
LUI.UIList.new = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5, f14_arg6, f14_arg7, f14_arg8)
	local f14_local0 = LUI.GridLayout.new(f14_arg0, f14_arg1, true, 0, 0, f14_arg2, f14_arg3, f0_local1, f14_arg4, f14_arg5, f14_arg6, f14_arg7, f14_arg8)
	f14_local0:setClass(LUI.UIList)
	f14_local0.isUIList = true
	f14_local0.m_focusable = true
	CoD.Menu.AddButtonCallbackFunction(f14_arg0, f14_local0, f14_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, f15_arg3)
		if element == f14_local0.activeWidget and CoD.Menu.AnyButtonConditionTrue(element, menu, controller, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F]) then
			f14_local0:playSound("list_action")
		end
		return false
	end)
	f14_local0:addUpDownNavigation(f14_arg0, f14_arg1)
	f14_local0:addLeftRightNavigation(f14_arg0, f14_arg1)
	if CoD.isPC then
		CoD.Menu.AddButtonCallbackFunction(f14_arg0, f14_local0, f14_arg1, Enum[0x3DD78803F918E9D][0x3C68CCBB77C781C], "MWHEELUP", function(element, menu, controller, f16_arg3)
			if not f14_local0.m_disableNavigation then
				return f14_local0:scrollUp()
			else
			end
		end)
		CoD.Menu.AddButtonCallbackFunction(f14_arg0, f14_local0, f14_arg1, Enum[0x3DD78803F918E9D][0x32EBED6749E6EE9], "MWHEELDOWN", function(element, menu, controller, f17_arg3)
			if not f14_local0.m_disableNavigation then
				return f14_local0:scrollDown()
			else
			end
		end)
	end
	return f14_local0
end
LUI.UIList.isWidgetSelectable = function(f18_arg0, f18_arg1)
	local f18_local0 = f18_arg1:hasClip("Focus")
	if not f18_local0 then
		if f18_arg1.onlyChildrenFocusable then
			if f18_arg0._checkChildFocusForSelectability then
				f18_local0 = f18_arg1:anyChildFocusable()
				if not f18_local0 then
				else
					return f18_local0
				end
			else
				f18_local0 = true
			end
		end
		f18_local0 = f18_arg0.super:isWidgetSelectable(f18_arg1)
	end
	return f18_local0
end
LUI.UIList.setListItemInFocus = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	if f19_arg0.hasListFocus then
		if f19_arg1 and (not f19_arg1.gridInfoTable or f19_arg1.gridInfoTable.parentGrid ~= f19_arg0) then
			f19_arg1 = nil
		end
		if f19_arg1 and f19_arg1:getModel() then
			if (IsUsingKeyboardNavigation(f19_arg0.controller) or IsGamepad(f19_arg0.controller) and not IsFreeCursorActiveAndVisible(f19_arg0.controller)) and not f19_arg1:doesElementOrChildHaveFocus() then
				f19_arg1:processEvent({
					name = "gain_focus",
					controller = f19_arg0.controller,
					sourceType = "list",
					skipGainFocus = f19_arg2,
					isMouse = f19_arg3,
				})
			elseif IsUsingKeyboardNavigation(f19_arg0.controller) or IsGamepad(f19_arg0.controller) and not IsFreeCursorActiveAndVisible(f19_arg0.controller) then
				f19_arg1:dispatchEventToParentWithSelf({
					name = "list_item_gain_focus",
					controller = f19_arg0.controller,
				})
			end
			f19_arg0:dispatchEventToParent({
				name = "list_focus_changed",
				list = f19_arg0,
				model = f19_arg1:getModel(),
			})
		end
		return f19_arg1
	else
		return nil
	end
end
LUI.UIList.setActiveItem = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3, f20_arg4)
	local f20_local0 = f20_arg0.activeWidget
	f20_arg0.super:setActiveItem(f20_arg1, f20_arg2)
	if not IsFreeCursorActiveAndVisible(f20_arg0.controller) or f20_arg0.__ignoreFreeCursorForFocus or CoD.isPC then
		f20_arg0:setListItemInFocus(f20_arg1, f20_arg3)
	end
	if f20_local0 and f20_local0 ~= f20_arg0.activeWidget then
		f20_local0:processEvent({
			name = "lose_focus",
			controller = f20_arg0.controller,
			skipLoseFocus = f20_arg4,
		})
	end
end
LUI.UIList.setRetainedFocusElement = function(f21_arg0, f21_arg1)
	if f21_arg0.currentSelection ~= f21_arg1 then
		if f21_arg0.currentSelection then
			f21_arg0.currentSelection:playClip("DefaultClip")
		end
		f21_arg0.currentSelection = f21_arg1
	end
end
LUI.UIList.gainFocus = function(f22_arg0, f22_arg1)
	local f22_local0 = f22_arg0.vCount == 1
	local f22_local1 = f22_arg0.hCount == 1
	local f22_local2
	if not f22_arg0.ignoreSavedActive then
		if f22_arg1.button and (not f22_local1 or f22_arg1.button ~= "left" and f22_arg1.button ~= "right") then
			local f22_local3 = f22_local0
			if f22_arg1.button ~= "up" and f22_arg1.button ~= "down" then
				f22_local2 = false
			end
		end
		f22_local2 = f22_local3 and true
	end
	f22_local2 = false
end
LUI.UIList.loseFocus = function(f23_arg0, f23_arg1)
	if f23_arg0.hasListFocus then
		local f23_local0 = f23_arg0.activeWidget
		f23_arg0.hasListFocus = false
		if f23_arg0.activeWidget then
			f23_arg0.activeWidget:processEvent(f23_arg1)
		end
		f23_arg0:processEvent({
			name = "update_state",
			controller = f23_arg0.controller,
			menu = f23_arg0.menu,
		})
		if not f23_arg0.__disableActiveOnFocus then
			f23_arg0.super:setActiveItem(f23_local0)
		end
		f23_arg0:processEventToParent({
			name = "lose_list_focus",
			controller = f23_arg0.controller,
		})
		return true
	else
		return false
	end
end
LUI.UIList.RecordCurrFocusedElemID = function(f24_arg0, f24_arg1)
	local f24_local0 = nil
	if Engine[0x8069F5969D47DEF]() then
		if not f24_arg0.hasListFocus then
			f24_arg0.hasListFocus = true
			f24_arg0:processEventToParent({
				name = "gain_list_focus",
				controller = f24_arg0.controller,
			})
		end
		if #f24_arg1.idStack >= 2 and f24_arg0[f24_arg1.idStack[1]] then
			if f24_arg1.idStack[1] == "itemStencil" then
				f24_local0 = f24_arg0[f24_arg1.idStack[1]][f24_arg1.idStack[2]]
				if not f24_arg0.__disableActiveOnFocus then
					f24_arg0.super:setActiveItem(f24_local0, 0)
				end
			else
				f24_arg0:dispatchEventToParent({
					name = f24_arg1.name,
					controller = f24_arg0.controller,
					id = f24_arg0.id,
					idStack = {
						f24_arg0.id,
					},
					listFocus = f24_arg1.id,
					originalEvent = f24_arg1,
					leaf = f24_arg1.leaf,
					disableUpdateCursorFocus = f24_arg1.disableUpdateCursorFocus,
				})
				return true
			end
		elseif f24_arg0.backingWidget == f24_arg0[f24_arg1.idStack[1]] then
			f24_arg0:dispatchEventToParent({
				name = f24_arg1.name,
				controller = f24_arg0.controller,
				id = f24_arg0.id,
				idStack = {
					f24_arg0.id,
				},
				listFocus = f24_arg1.id,
				originalEvent = f24_arg1,
				leaf = f24_arg1.leaf,
				disableUpdateCursorFocus = f24_arg1.disableUpdateCursorFocus,
			})
			return true
		end
	else
		f24_local0 = f24_arg0.activeWidget
	end
	if f24_local0 then
		f24_arg0:dispatchEventToParent({
			name = f24_arg1.name,
			controller = f24_arg0.controller,
			id = f24_arg0.id,
			idStack = {
				f24_arg0.id,
			},
			listFocus = f24_arg1.id,
			focusRow = f24_local0.gridInfoTable.gridRowIndex,
			focusColumn = f24_local0.gridInfoTable.gridColIndex,
			originalEvent = f24_arg1,
			leaf = f24_arg1.leaf,
			disableUpdateCursorFocus = f24_arg1.disableUpdateCursorFocus,
		})
		local f24_local1 = LUI.ShallowCopy(f24_arg1)
		f24_local1.name = "list_item_gain_focus"
		f24_local0:dispatchEventToParentWithSelf(f24_local1)
		return true
	end
	return false
end
LUI.UIList.RecordCurrPCInputFocusElemID = function(f25_arg0, f25_arg1)
	f25_arg0:dispatchEventToParent({
		name = f25_arg1.name,
		controller = f25_arg0.controller,
		id = f25_arg0.id,
		idStack = {
			f25_arg0.id,
		},
		listFocus = f25_arg1.id,
		originalEvent = f25_arg1,
	})
end
LUI.UIList.childFocusLost = function(f26_arg0)
	if f26_arg0.hasListFocus then
		f26_arg0:loseFocus({
			name = "lose_focus",
			controller = f26_arg0.controller,
		})
	end
	f26_arg0.super:childFocusLost()
end
LUI.UIList.processButtonAction = function(f27_arg0, f27_arg1)
	if f27_arg0.hasListFocus then
		return f27_arg0:dispatchEventToChildren(f27_arg1)
	else
		return false
	end
end
LUI.UIList.disableDPadNav = function(f28_arg0, f28_arg1)
	f28_arg0.dpadDisabled = f28_arg1
end
LUI.UIList:registerEventHandler("gain_focus", LUI.UIList.gainFocus)
LUI.UIList:registerEventHandler("lose_focus", LUI.UIList.loseFocus)
LUI.UIList:registerEventHandler("record_curr_focused_elem_id", LUI.UIList.RecordCurrFocusedElemID)
LUI.UIList:registerEventHandler("record_inputfocus_elem_id", LUI.UIList.RecordCurrPCInputFocusElemID)
LUI.UIList:registerEventHandler("button_action", LUI.UIList.processButtonAction)
LUI.UIList.id = "LUIList"
LUI.UIList.setActiveOnUpdate = false
