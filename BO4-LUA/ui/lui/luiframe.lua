LUI.UIFrame = InheritFrom(LUI.UIElement)
LUI.UIFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local self = LUI.UIElement.new()
	self:setClass(LUI.UIFrame)
	self.controller = f1_arg1
	self.framedWidget = nil
	self.widgetType = nil
	self.menu = f1_arg0
	self.horizontalPadding = f1_arg2
	self.verticalPadding = f1_arg3
	self.m_focusable = true
	self.anyChildUsesUpdateState = true
	self.scaleWithWidget = f1_arg4
	self.backingWidget = nil
	self.backingXPadding = 0
	self.backingYPadding = 0
	f1_arg0:addElementToPendingUpdateStateList(self)
	self._on_menuOpened = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		self:menuOpened(f2_arg1, f2_arg2, f2_arg3)
	end
	f1_arg0:addMenuOpenedCallback(self._on_menuOpened)
	return self
end
LUI.UIFrame.close = function(f3_arg0)
	if f3_arg0.framedWidget ~= nil then
		CoD.Menu.RemoveFromCurrMenuNameList(f3_arg0.framedWidget.idForMenuList)
		f3_arg0.framedWidget:close()
	end
	f3_arg0:removeCurrentBackingWidget()
	f3_arg0.menu:removeMenuOpenedCallback(f3_arg0._on_menuOpened)
	LUI.UIElement.close(f3_arg0)
end
LUI.UIFrame.setFrameScale = function(f4_arg0)
	if f4_arg0.framedWidget and f4_arg0.scaleWithWidget then
		local f4_local0, f4_local1, f4_local2, f4_local3 = f4_arg0.framedWidget:getLocalRect()
		f4_arg0:setWidth(f4_local2 - f4_local0 + f4_arg0.horizontalPadding * 2)
		f4_arg0:setHeight(f4_local3 - f4_local1 + f4_arg0.verticalPadding * 2)
	end
end
LUI.UIFrame.scaleFramedWidgetToParent = function(f5_arg0)
	local f5_local0 = function(f6_arg0, f6_arg1)
		local f6_local0, f6_local1, f6_local2, f6_local3 = f6_arg1(f6_arg0)
		if f6_local1 == f6_local0 then
			return f6_local3 - f6_local2
		else
			local f6_local4 = f6_arg0:getParent()
			if not f6_local4 then
				return nil
			else
				local f6_local5 = f5_local0(f6_local4, f6_arg1)
				return f6_local5 * f6_local1 + f6_local3 - f6_local5 * f6_local0 + f6_local2
			end
		end
	end
	if f5_arg0 and f5_arg0.framedWidget then
		local f5_local1 = f5_local0(f5_arg0.framedWidget, f5_arg0.framedWidget.getLocalLeftRight)
		local f5_local2 = f5_local0(f5_arg0.framedWidget, f5_arg0.framedWidget.getLocalTopBottom)
		local f5_local3 = f5_local1 / f5_arg0.framedWidget.__defaultWidth
		local f5_local4 = f5_local2 / f5_arg0.framedWidget.__defaultHeight
		f5_arg0.framedWidget:setScale(f5_local3, f5_local4)
		local f5_local5 = 0.5 * (1 - f5_local3)
		local f5_local6, f5_local7, f5_local8, f5_local9 = f5_arg0.framedWidget:getLocalLeftRight()
		f5_arg0.framedWidget:setLeftRight(f5_local6 - f5_local5, f5_local7 - f5_local5, f5_local8, f5_local9)
		local f5_local10 = 0.5 * (1 - f5_local4)
		local f5_local11, f5_local12, f5_local13, f5_local14 = f5_arg0.framedWidget:getLocalTopBottom()
		f5_arg0.framedWidget:setTopBottom(f5_local11 - f5_local10, f5_local12 - f5_local10, f5_local13, f5_local9)
	end
end
LUI.UIFrame.createFrameWidget = function(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.hasFrameFocus
	if f7_arg0.framedWidget then
		CoD.Menu.RemoveFromCurrMenuNameList(f7_arg0.framedWidget.idForMenuList)
		f7_arg0.__defaultFocus = nil
		f7_arg0.framedWidget:close()
		f7_arg0.framedWidget = nil
	end
	if not f7_arg0.widgetType or not f7_arg0.widgetType.new or not f7_arg0.__receivedMenuOpenedEvent then
		return
	end
	f7_arg0.menu.__loaded = nil
	f7_arg0.framedWidget = f7_arg0.widgetType.new(f7_arg0.menu, f7_arg0.controller, 0, 1, f7_arg0.horizontalPadding, -f7_arg0.horizontalPadding, 0, 1, f7_arg0.verticalPadding, -f7_arg0.verticalPadding)
	f7_arg0.framedWidget.idForMenuList = f7_arg0.framedWidget.id
	f7_arg0.framedWidget.id = "framedWidget"
	f7_arg0:setFrameScale()
	CoD.Menu.AddToCurrMenuNameList(f7_arg0.framedWidget.idForMenuList)
	f7_arg0.framedWidget.m_disableNavigation = true
	if f7_arg0.customFramedWidgetSetup then
		f7_arg0:customFramedWidgetSetup(f7_arg0.framedWidget)
	end
	f7_arg0:addElement(f7_arg0.framedWidget)
	f7_arg0.menu.__loaded = true
	if f7_arg0.isWidgetBasedCallingCard then
		f7_arg0:scaleFramedWidgetToParent()
	end
	f7_arg0.framedWidget:linkToElementModel(f7_arg0, nil, false, function(model)
		f7_arg0.framedWidget:setModel(model, f7_arg0.controller)
	end)
	f7_arg0.__defaultFocus = f7_arg0.framedWidget
	f7_arg0.menu:sendInitializationEvents(f7_arg0.controller, f7_arg0.framedWidget)
	if f7_local0 and not f7_arg1 and not f7_arg0.__defaultFocusTimer then
		f7_arg0.__defaultFocusTimer = LUI.UITimer.newElementTimer(0, true, function()
			f7_arg0.__defaultFocusTimer = nil
			if f7_arg0.framedWidget then
				f7_arg0.framedWidget:processEvent({
					name = "gain_focus",
					controller = f7_arg0.controller,
					menu = f7_arg0.menu,
					moveCursor = true,
				})
			end
		end)
		f7_arg0:addElement(f7_arg0.__defaultFocusTimer)
	end
end
LUI.UIFrame.changeFrameWidget = function(f10_arg0, f10_arg1, f10_arg2)
	if type(f10_arg1) == "string" then
		f10_arg1 = LUI.getTableFromPath(f10_arg1)
	end
	if f10_arg0.widgetType == f10_arg1 then
		return
	else
		f10_arg0.widgetType = f10_arg1
		f10_arg0:createFrameWidget(f10_arg2)
	end
end
LUI.UIFrame.setWidgetType = function(f11_arg0, f11_arg1)
	f11_arg0:changeFrameWidget(f11_arg1)
end
LUI.UIFrame.updateFrameEvent = function(f12_arg0, f12_arg1)
	f12_arg0:changeFrameWidget(f12_arg1.widget)
	return true
end
LUI.UIFrame.updateScaleEvent = function(f13_arg0, f13_arg1)
	f13_arg0:setFrameScale()
	return true
end
LUI.UIFrame.gainFocus = function(f14_arg0, f14_arg1)
	if f14_arg1.saveEvent and f14_arg1.saveEvent.originalEvent and f14_arg1.saveEvent.originalEvent.idStack[1] == "framedWidget" and f14_arg0.framedWidget then
		f14_arg1.saveEvent.originalEvent.idStack[1] = f14_arg0.framedWidget.id
		f14_arg0.hasFrameFocus = f14_arg0:dispatchEventToChildren({
			name = "restore_focus",
			saveEvent = f14_arg1.saveEvent.originalEvent,
			controller = f14_arg1.controller,
		})
	elseif not CoD.isPC or not f14_arg0.handleHasFrameFocusInRecordFocus then
		f14_arg0.hasFrameFocus = f14_arg0:dispatchEventToChildren(f14_arg1)
	end
	if not CoD.isPC then
		f14_arg0.hasFrameFocus = true
	end
	return f14_arg0.hasFrameFocus
end
LUI.UIFrame.loseFocus = function(f15_arg0, f15_arg1)
	f15_arg0.hasFrameFocus = false
	return f15_arg0:dispatchEventToChildren(f15_arg1)
end
LUI.UIFrame.RecordCurrFocusedElemID = function(f16_arg0, f16_arg1)
	f16_arg0.hasFrameFocus = true
	if f16_arg0.hasFrameFocus and f16_arg0.framedWidget then
		f16_arg1.idStack[1] = "framedWidget"
		return f16_arg0:dispatchEventToParent({
			name = f16_arg1.name,
			controller = f16_arg1.controller,
			id = f16_arg0.id,
			idStack = {
				f16_arg0.id,
			},
			originalEvent = f16_arg1,
			leaf = f16_arg1.leaf,
			disableUpdateCursorFocus = f16_arg1.disableUpdateCursorFocus,
		})
	else
		return false
	end
end
LUI.UIFrame.ClearRecordedFocus = function(f17_arg0, f17_arg1)
	f17_arg0.hasFrameFocus = false
	return f17_arg0:dispatchEventToParent(f17_arg1)
end
LUI.UIFrame.childFocusGained = function(f18_arg0)
	f18_arg0.hasFrameFocus = true
	f18_arg0.super:childFocusGained()
end
LUI.UIFrame.childFocusLost = function(f19_arg0)
	f19_arg0.hasFrameFocus = false
	f19_arg0.super:childFocusLost()
end
LUI.UIFrame.removeCurrentBackingWidget = function(f20_arg0)
	if f20_arg0.backingWidget then
		f20_arg0.backingWidget:close()
		f20_arg0.backingWidget = nil
	end
end
LUI.UIFrame.setBackingWidget = function(f21_arg0, f21_arg1)
	f21_arg0:removeCurrentBackingWidget()
	if f21_arg1 and f21_arg1.new then
		f21_arg0.backingWidget = f21_arg1.new(f21_arg0.menu, f21_arg0.controller, 0, 1, -f21_arg0.backingXPadding, f21_arg0.backingXPadding, 0, 1, -f21_arg0.backingYPadding, f21_arg0.backingYPadding)
		f21_arg0.backingWidget:setPriority(-100)
		f21_arg0:addElement(f21_arg0.backingWidget)
	end
end
LUI.UIFrame.setBackingWidgetXPadding = function(f22_arg0, f22_arg1)
	f22_arg0.backingXPadding = f22_arg1
	if f22_arg0.backingWidget then
		f22_arg0.backingWidget:setLeftRight(0, 1, -f22_arg0.backingXPadding, f22_arg0.backingXPadding)
	end
end
LUI.UIFrame.setBackingWidgetYPadding = function(f23_arg0, f23_arg1)
	f23_arg0.backingYPadding = f23_arg1
	if f23_arg0.backingWidget then
		f23_arg0.backingWidget:setTopBottom(0, 1, -f23_arg0.backingYPadding, f23_arg0.backingYPadding)
	end
end
LUI.UIFrame.menuLoaded = function(f24_arg0, f24_arg1)
	f24_arg0.__receivedMenuLoadedEvent = true
	f24_arg0:dispatchEventToChildren(f24_arg1)
end
LUI.UIFrame.menuOpened = function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
	if not f25_arg0.__receivedMenuOpenedEvent then
		f25_arg0.__receivedMenuOpenedEvent = true
		f25_arg0:createFrameWidget(false)
	end
end
LUI.UIFrame.setActive = function(f26_arg0, f26_arg1)
	if f26_arg0.framedWidget then
		f26_arg0.m_active = true
		f26_arg0:dispatchEventToChildren(f26_arg1)
	end
end
LUI.UIFrame.setInactive = function(f27_arg0, f27_arg1)
	if f27_arg0.framedWidget then
		f27_arg0.m_active = nil
		f27_arg0:dispatchEventToChildren(f27_arg1)
	end
end
LUI.UIFrame:registerEventHandler("gain_active", LUI.UIFrame.setActive)
LUI.UIFrame:registerEventHandler("lose_active", LUI.UIFrame.setInactive)
LUI.UIFrame:registerEventHandler("menu_loaded", LUI.UIFrame.menuLoaded)
LUI.UIFrame:registerEventHandler("gain_focus", LUI.UIFrame.gainFocus)
LUI.UIFrame:registerEventHandler("lose_focus", LUI.UIFrame.loseFocus)
LUI.UIFrame:registerEventHandler("update_frame", LUI.UIFrame.updateFrameEvent)
LUI.UIFrame:registerEventHandler("update_scale", LUI.UIFrame.updateScaleEvent)
LUI.UIFrame:registerEventHandler("record_curr_focused_elem_id", LUI.UIFrame.RecordCurrFocusedElemID)
LUI.UIFrame.id = "LUIFrame"
