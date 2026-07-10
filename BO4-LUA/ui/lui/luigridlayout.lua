LUI.GridLayout = InheritFrom(LUI.UIElement)
LUI.GridLayout.__trackedLists = {}
LUI.GridLayout.NavigationFlags = {
	CHANGE_FOCUS = 1,
	MOVE_CURSOR = 2,
}
local f0_local0 = function(f1_arg0)
	return f1_arg0.gridInfoTable.gridRowIndex + f1_arg0.gridInfoTable.gridRowSpan - 1
end
local f0_local1 = function(f2_arg0)
	return f2_arg0.gridInfoTable.gridColIndex + f2_arg0.gridInfoTable.gridColSpan - 1
end
local f0_local2 = function(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0, f3_local1 = nil
	if f3_arg1.getWidthInList then
		f3_local0 = f3_arg1:getWidthInList(f3_arg2)
		if f3_arg1.getHeightInList then
			return f3_local0, f3_arg1:getHeightInList(f3_arg2)
		end
	elseif f3_arg1.getHeightInList then
		f3_local1 = f3_arg1:getHeightInList(f3_arg2)
	elseif f3_arg1.sizeElement then
		if not f3_arg1.sizeElement.__sizeElementAffectsList then
			f3_arg1.sizeElement.__sizeElementAffectsList = true
			LUI.OverrideFunction_CallOriginalFirst(f3_arg1.sizeElement, "beginAnimation", function(element, controller)
				f3_arg0.__sizeElementAnimTime = controller
			end)
			LUI.OverrideFunction_CallOriginalFirst(f3_arg1.sizeElement, "completeAnimation", function(element, controller)
				f3_arg0.__sizeElementAnimTime = 0
			end)
			LUI.OverrideFunction_CallOriginalFirst(f3_arg1.sizeElement, "setLeftRight", function(element, controller, f6_arg2, f6_arg3, f6_arg4)
				if (element._lp ~= controller or element._rp ~= f6_arg2 or element._lx ~= f6_arg3 or element._rx ~= f6_arg4) and f3_arg0._layoutTimer == nil then
					f3_arg0._layoutTimer = LUI.UITimer.newElementTimer(0, true, function()
						f3_arg0._layoutTimer = nil
						f3_arg0:updateLayout(f3_arg0.__sizeElementAnimTime or 0)
					end)
					f3_arg0:addElement(f3_arg0._layoutTimer)
				end
				local f6_local0 = controller
				local f6_local1 = f6_arg2
				local f6_local2 = f6_arg3
				element._rx = f6_arg4
				element._lx = f6_local2
				element._rp = f6_local1
				element._lp = f6_local0
			end)
		end
		local f3_local2, f3_local3 = f3_arg1.sizeElement:getLocalSize()
		return f3_local0 or f3_local2, f3_local1 or f3_local3
	elseif f3_arg1._useLocalSize then
		f3_local0, f3_local1 = f3_arg1:getLocalSize()
	end
	if not f3_local0 then
		f3_local0 = f3_arg1.__defaultWidth
	end
	if not f3_local1 then
		f3_local1 = f3_arg1.__defaultHeight
	end
	return f3_local0, f3_local1
end
LUI.GridLayout.addLeftRightActiveNavigation = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	CoD.Menu.AddButtonCallbackFunction(f8_arg1, f8_arg1, f8_arg2, Enum[@"luibutton"][@"lui_key_left"], "ui_navleft", function(element, menu, controller, f9_arg3)
		if not f8_arg0.m_disableNavigation then
			if not (not f8_arg0.dpadDisabled or not IsDpadButton(f9_arg3)) or f8_arg0:navigateItemLeft() then
				return true
			elseif f8_arg3 and f8_arg0:getLastSelectableItem(true) then
				return true
			end
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f8_arg1, f8_arg1, f8_arg2, Enum[@"luibutton"][@"lui_key_right"], "ui_navright", function(element, menu, controller, f10_arg3)
		if not f8_arg0.m_disableNavigation then
			if not (not f8_arg0.dpadDisabled or not IsDpadButton(f10_arg3)) or f8_arg0:navigateItemRight() then
				return true
			elseif f8_arg3 and f8_arg0:getFirstSelectableItem(true) then
				return true
			end
		end
	end)
end
LUI.GridLayout.AddBumperPaging = function(f11_arg0, f11_arg1, f11_arg2)
	CoD.Menu.AddButtonCallbackFunction(f11_arg1, f11_arg0, f11_arg2, Enum[@"luibutton"][@"lui_key_lb"], "ui_pageup", function(element, menu, controller, f12_arg3)
		if not f11_arg0.m_disableNavigation then
			BlockGameFromKeyEvent(controller)
			if f11_arg0:pageUp() then
				return true
			end
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f11_arg1, f11_arg0, f11_arg2, Enum[@"luibutton"][@"lui_key_rb"], "ui_pagedown", function(element, menu, controller, f13_arg3)
		if not f11_arg0.m_disableNavigation then
			BlockGameFromKeyEvent(controller)
			if f11_arg0:pageDown() then
				return true
			end
		end
	end)
end
LUI.GridLayout.new = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5, f14_arg6, f14_arg7, f14_arg8, f14_arg9, f14_arg10, f14_arg11, f14_arg12)
	local self = LUI.UIElement.new()
	self:setClass(LUI.GridLayout)
	f14_arg0:addElementToPendingUpdateStateList(self)
	self.itemStencil = LUI.UIElement.new(0.5, 0.5, 0, 0, 0.5, 0.5, 0, 0)
	self.itemStencil.anyChildUsesUpdateState = true
	self.itemStencil.id = "itemStencil"
	self.itemStencil.__passButtonPress = true
	self.itemStencil:setForceMouseEventDispatch(true)
	f14_arg0:addElementToPendingUpdateStateList(self.itemStencil)
	if f14_arg12 then
		self.itemStencil:setUseStencil(true)
	end
	self:addElement(self.itemStencil)
	self.usingStencil = f14_arg12
	self.menu = f14_arg0
	self.elementStateConditions = {}
	self.m_focusable = f14_arg2
	self.filter = f14_arg8
	self.minimumRowHeight = f14_arg3
	self.minimumColumnWidth = f14_arg4
	self.hCount = 1
	self.vCount = 1
	self.spacing = f14_arg5
	self.controller = f14_arg1
	self.layoutItems = {}
	self.__cachedSizes = {}
	self.activeWidget = nil
	self.lastActiveWidget = nil
	self.loopEdges = f14_arg9 or false
	self:resetCurrentRowAndColumn()
	self.requestedRowCount = self.vCount
	self.requestedColumnCount = self.hCount
	self.itemCount = 0
	self.customWidgetSetup = f14_arg7
	self.scrollAnimationTime = f14_arg6 or 0
	self.widgetType = nil
	self.isGridLayout = true
	self.activeWidgetInPlace = f14_arg10 or false
	self.firstElementXOffset = 0
	self.firstElementYOffset = 0
	self.accumlatingRowXOffset = 0
	self.accumlatingColumnYOffset = 0
	self.placeMovedElementOnEnd = f14_arg11 or false
	self.anyChildUsesUpdateState = true
	self.prepared = false
	self.backingWidget = nil
	self.backingXPadding = 0
	self.backingYPadding = 0
	self.rowColumnIndexMap = {}
	self.autoScaleContent = false
	self.__updateChildrenOnStateUpdate = true
	self.__staggeredIntroTimeDelay = 0
	self.__staggeredElementsPlayingClips = {}
	self.__centerActiveWidget = false
	self.getDefaultFocus = function()
		return self:getFirstSelectableItem(false)
	end
	self._on_menuOpened = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		self:menuOpened(f16_arg1, f16_arg2, f16_arg3)
	end
	f14_arg0:addMenuOpenedCallback(self._on_menuOpened)
	return self
end
LUI.GridLayout.forceMenuOpenedEvent = function(f17_arg0, f17_arg1, f17_arg2)
	f17_arg0:menuOpened(f17_arg1, f17_arg2, true)
end
LUI.GridLayout.forEachElement = function(f18_arg0)
	local f18_local0 = {}
	local f18_local1 = {}
	for f18_local8, f18_local9 in pairs(f18_arg0.layoutItems) do
		table.insert(f18_local0, f18_local8)
		for f18_local5, f18_local6 in pairs(f18_local9) do
			if not LuaUtils.FindItemInArray(f18_local1, f18_local5) then
				table.insert(f18_local1, f18_local5)
			end
		end
	end
	table.sort(f18_local0)
	table.sort(f18_local1)
	f18_local2 = 1
	f18_local3 = 1
	return function()
		while f18_local2 <= #f18_local0 do
			local f19_local0 = f18_arg0.layoutItems[f18_local2]
			if f19_local0 then
			else
				f18_local2 = f18_local2 + 1
				f18_local3 = 1
			end
			while f18_local3 <= #f18_local1 do
				local f19_local1 = f18_local3
				f18_local3 = f18_local3 + 1
				if f19_local0[f19_local1] then
					return f18_local2, f19_local1, f19_local0[f19_local1]
				end
			end
			f18_local2 = f18_local2 + 1
			f18_local3 = 1
		end
		return nil
	end
end
LUI.GridLayout.addDataSourceLink = function(f20_arg0)
	if f20_arg0.dataSourceName and DataSources[f20_arg0.dataSourceName] then
		if not LUI.GridLayout.__trackedLists[f20_arg0.dataSourceName] then
			LUI.GridLayout.__trackedLists[f20_arg0.dataSourceName] = {}
		end
		LUI.GridLayout.__trackedLists[f20_arg0.dataSourceName][f20_arg0] = true
	end
end
LUI.GridLayout.removeDataSourceLink = function(f21_arg0, f21_arg1)
	if f21_arg0.dataSourceName and DataSources[f21_arg0.dataSourceName] and LUI.GridLayout.__trackedLists[f21_arg0.dataSourceName] then
		LUI.GridLayout.__trackedLists[f21_arg0.dataSourceName][f21_arg0] = nil
		if not f21_arg1 and DataSources[f21_arg0.dataSourceName].cleanup and LuaUtils.IsHashTableEmpty(LUI.GridLayout.__trackedLists[f21_arg0.dataSourceName]) then
			DataSources[f21_arg0.dataSourceName].cleanup(f21_arg0, f21_arg0.controller)
			LUI.GridLayout.__trackedLists[f21_arg0.dataSourceName] = nil
		end
	end
end
LUI.GridLayout.setDataSource = function(f22_arg0, f22_arg1)
	if f22_arg0.dataSourceName ~= f22_arg1 then
		f22_arg0:removeDataSourceLink(true)
		local f22_local0 = DataSources[f22_arg1]
		f22_arg0.dataSourceName = f22_arg1
		f22_arg0:addDataSourceLink()
		if f22_local0 and f22_local0.prepare then
			f22_arg0:updateDataSource(nil, true)
		else
			f22_arg0:clearLayout()
		end
	end
end
LUI.GridLayout.setFilter = function(f23_arg0, f23_arg1)
	f23_arg0.filter = f23_arg1
	f23_arg0:updateDataSource()
end
LUI.GridLayout.loopEdges = function(f24_arg0, f24_arg1)
	f24_arg0.loopEdges = f24_arg1
end
LUI.GridLayout.setBalanceGridRows = function(f25_arg0, f25_arg1)
	f25_arg0.__balanceGridRows = f25_arg1
end
LUI.GridLayout.setHorizontalCount = function(f26_arg0, f26_arg1, f26_arg2)
	f26_arg0.hCount = f26_arg1
	f26_arg0:updateDataSource(nil, f26_arg2, true)
end
LUI.GridLayout.setVerticalCount = function(f27_arg0, f27_arg1, f27_arg2)
	f27_arg0.vCount = f27_arg1
	f27_arg0:updateDataSource(nil, f27_arg2, true)
end
LUI.GridLayout.setAutoScaleContent = function(f28_arg0, f28_arg1, f28_arg2)
	f28_arg0.autoScaleContentWidth = f28_arg1
	f28_arg0.autoScaleContentHeight = f28_arg1
	f28_arg0:updateDataSource(nil, f28_arg2, true)
end
LUI.GridLayout.setAutoScaleContentWidth = function(f29_arg0, f29_arg1, f29_arg2)
	f29_arg0.autoScaleContentWidth = f29_arg1
	f29_arg0:updateDataSource(nil, f29_arg2, true)
end
LUI.GridLayout.setAutoScaleContentHeight = function(f30_arg0, f30_arg1, f30_arg2)
	f30_arg0.autoScaleContentHeight = f30_arg1
	f30_arg0:updateDataSource(nil, f30_arg2, true)
end
LUI.GridLayout.getTotalCount = function(f31_arg0)
	return f31_arg0.hCount * f31_arg0.vCount
end
LUI.GridLayout.setFirstElementXOffset = function(f32_arg0, f32_arg1)
	f32_arg0.firstElementXOffset = f32_arg1
end
LUI.GridLayout.setFirstElementYOffset = function(f33_arg0, f33_arg1)
	f33_arg0.firstElementYOffset = f33_arg1
end
LUI.GridLayout.setAccumulatingRowXOffset = function(f34_arg0, f34_arg1)
	f34_arg0.accumlatingRowXOffset = f34_arg1
end
LUI.GridLayout.setAccumulatingColumnYOffset = function(f35_arg0, f35_arg1)
	f35_arg0.accumlatingColumnYOffset = f35_arg1
end
LUI.GridLayout.getDataSource = function(f36_arg0)
	return DataSources[f36_arg0.dataSourceName]
end
LUI.GridLayout.setSpacing = function(f37_arg0, f37_arg1)
	if f37_arg0.spacing ~= f37_arg1 then
		f37_arg0.spacing = f37_arg1
		f37_arg0:updateLayout(0)
	end
end
LUI.GridLayout.removeCurrentBackingWidget = function(f38_arg0)
	if f38_arg0.backingWidget then
		if f38_arg0.__focusableBackingWidget then
			f38_arg0[f38_arg0.backingWidget.id] = nil
		end
		f38_arg0.backingWidget:close()
		f38_arg0.backingWidget = nil
	end
end
LUI.GridLayout.setBackingWidget = function(f39_arg0, f39_arg1)
	f39_arg0:removeCurrentBackingWidget()
	if f39_arg1 and f39_arg1.new then
		f39_arg0.backingWidget = f39_arg1.new(f39_arg0.menu, f39_arg0.controller, 0, 1, -f39_arg0.backingXPadding, f39_arg0.backingXPadding, 0, 1, -f39_arg0.backingYPadding, f39_arg0.backingYPadding)
		f39_arg0.backingWidget:setPriority(-100)
		f39_arg0:addElement(f39_arg0.backingWidget)
		f39_arg0.backingWidget.__doNotPassButtonPressToGridLayout = true
	end
end
LUI.GridLayout.setBackingWidgetXPadding = function(f40_arg0, f40_arg1)
	f40_arg0.backingXPadding = f40_arg1
	if f40_arg0.backingWidget then
		f40_arg0.backingWidget:setLeftRight(0, 1, -f40_arg0.backingXPadding, f40_arg0.backingXPadding)
	end
end
LUI.GridLayout.setBackingWidgetYPadding = function(f41_arg0, f41_arg1)
	f41_arg0.backingYPadding = f41_arg1
	if f41_arg0.backingWidget then
		f41_arg0.backingWidget:setTopBottom(0, 1, -f41_arg0.backingYPadding, f41_arg0.backingYPadding)
	end
end
LUI.GridLayout.setStaggeredIntroTime = function(f42_arg0, f42_arg1)
	f42_arg0.__staggeredIntroTimeDelay = f42_arg1
end
LUI.GridLayout.updateCurrentPosition = function(f43_arg0, f43_arg1, f43_arg2)
	f43_arg0.previousStartColumn = f43_arg0.currentStartColumn
	f43_arg0.previousStartRow = f43_arg0.currentStartRow
	f43_arg0.currentStartColumn = f43_arg2
	f43_arg0.currentStartRow = f43_arg1
end
LUI.GridLayout.setWidgetType = function(f44_arg0, f44_arg1)
	f44_arg0.widgetType = f44_arg1
	f44_arg0:clearLayout()
end
LUI.GridLayout.mergeStateConditions = function(f45_arg0, f45_arg1)
	f45_arg0.elementStateConditions = {}
	LUI.GridLayout.super.mergeStateConditions(f45_arg0, f45_arg1, f45_arg0.elementStateConditions)
	f45_arg0:clearLayout()
	f45_arg0:updateLayout()
end
LUI.GridLayout.setVerticalScrollbar = function(f46_arg0, f46_arg1)
	if f46_arg0.verticalScrollbar then
		f46_arg0.verticalScrollbar:close()
		f46_arg0.verticalScrollbar = nil
	end
	if f46_arg1 and f46_arg1.new then
		f46_arg0:setForceMouseEventDispatch(true)
		f46_arg0.verticalScrollbar = f46_arg1.new(f46_arg0.menu, f46_arg0.controller, 1, 1, 5, 5 + f46_arg1.__defaultWidth, 0, 1, 0, 0)
		f46_arg0.verticalScrollbar.listWidget = f46_arg0
		f46_arg0:addElement(f46_arg0.verticalScrollbar)
		f46_arg0.verticalScrollbar.id = "verticalScrollbar"
		f46_arg0.verticalScrollbar.__doNotPassButtonPressToGridLayout = true
	end
	f46_arg0:updateScrollbars()
end
LUI.GridLayout.addCustomVerticalCounter = function(f47_arg0, f47_arg1)
	if f47_arg0.customVerticalCounter then
		return
	else
		f47_arg0.customVerticalCounter = f47_arg1
		f47_arg0.customVerticalCounter.listWidget = f47_arg0
		f47_arg0.customVerticalCounter.__doNotPassButtonPressToGridLayout = true
		f47_arg0:updateVerticalCounter(f47_arg0.customVerticalCounter)
	end
end
LUI.GridLayout.setVerticalCounter = function(f48_arg0, f48_arg1)
	if f48_arg0.verticalCounter then
		f48_arg0.verticalCounter:close()
		f48_arg0.verticalCounter = nil
	end
	if f48_arg1 and f48_arg1.new then
		f48_arg0:setForceMouseEventDispatch(true)
		f48_arg0.verticalCounter = f48_arg1.new(f48_arg0.menu, f48_arg0.controller, 0, 1, 0, 0, 1, 1, 5, 5 + f48_arg1.__defaultHeight)
		f48_arg0.verticalCounter:setForceMouseEventDispatch(true)
		f48_arg0.verticalCounter.listWidget = f48_arg0
		f48_arg0:addElement(f48_arg0.verticalCounter)
		f48_arg0.verticalCounter.__doNotPassButtonPressToGridLayout = true
	end
	f48_arg0:updateScrollbars()
end
LUI.GridLayout.setHorizontalScrollbar = function(f49_arg0, f49_arg1)
	if f49_arg0.horizontalScrollbar then
		f49_arg0.horizontalScrollbar:close()
		f49_arg0.horizontalScrollbar = nil
	end
	if f49_arg1 and f49_arg1.new then
		f49_arg0:setForceMouseEventDispatch(true)
		f49_arg0.horizontalScrollbar = f49_arg1.new(f49_arg0.menu, f49_arg0.controller, 0, 1, 0, 0, 1, 1, 5, 5 + f49_arg1.__defaultHeight)
		f49_arg0.horizontalScrollbar.listWidget = f49_arg0
		f49_arg0:addElement(f49_arg0.horizontalScrollbar)
		f49_arg0.horizontalScrollbar.id = "horizontalScrollbar"
		f49_arg0.horizontalScrollbar.__doNotPassButtonPressToGridLayout = true
	end
	f49_arg0:updateScrollbars()
end
LUI.GridLayout.addCustomHorizontalCounter = function(f50_arg0, f50_arg1)
	if f50_arg0.customHorizontalCounter then
		return
	else
		f50_arg0.customHorizontalCounter = f50_arg1
		f50_arg0.customHorizontalCounter.listWidget = f50_arg0
		f50_arg0.customHorizontalCounter.__doNotPassButtonPressToGridLayout = true
		f50_arg0:updateScrollbars()
	end
end
LUI.GridLayout.setHorizontalCounter = function(f51_arg0, f51_arg1)
	if f51_arg0.horizontalCounter then
		f51_arg0.horizontalCounter:close()
		f51_arg0.horizontalCounter = nil
	end
	if f51_arg1 and f51_arg1.new then
		f51_arg0:setForceMouseEventDispatch(true)
		f51_arg0.horizontalCounter = f51_arg1.new(f51_arg0.menu, f51_arg0.controller, 0, 1, 0, 0, 1, 1, 5, 5 + f51_arg1.__defaultHeight)
		f51_arg0.horizontalCounter:setForceMouseEventDispatch(true)
		f51_arg0.horizontalCounter.listWidget = f51_arg0
		f51_arg0:addElement(f51_arg0.horizontalCounter)
		f51_arg0.horizontalCounter.__doNotPassButtonPressToGridLayout = true
	end
	f51_arg0:updateScrollbars()
end
LUI.GridLayout.setHorizontalPips = function(f52_arg0, f52_arg1)
	if f52_arg0.horizontalPips then
		f52_arg0.horizontalPips:close()
		f52_arg0.horizontalPips = nil
	end
	if f52_arg1 and f52_arg1.new then
		f52_arg0.horizontalPips = f52_arg1.new(f52_arg0.menu, f52_arg0.controller, 0, 1, 0, 0, 1, 1, 5, 5 + f52_arg1.__defaultHeight)
		f52_arg0.horizontalPips.listWidget = f52_arg0
		f52_arg0:addElement(f52_arg0.horizontalPips)
	end
	f52_arg0:updateCounters()
end
LUI.GridLayout.addCustomHorizontalPips = function(f53_arg0, f53_arg1)
	if f53_arg0.customHorizontalPips then
		f53_arg0.customHorizontalPips:close()
		f53_arg0.customHorizontalPips = nil
	end
	if f53_arg1 and f53_arg1.new then
		f53_arg0.customHorizontalPips = f53_arg1.new(f53_arg0.menu, f53_arg0.controller, 0, 1, 0, 0, 1, 1, 5, 5 + f53_arg1.__defaultHeight)
		f53_arg0.customHorizontalPips.listWidget = f53_arg0
		f53_arg0:addElement(f53_arg0.customHorizontalPips)
	end
	f53_arg0:updateCounters()
end
local f0_local3 = function(f54_arg0)
	return math.floor(f54_arg0 + 0.5)
end
LUI.GridLayout.validateActiveItemVisibility = function(f55_arg0)
	if not f55_arg0.activeWidget then
		return
	end
	local f55_local0 = f55_arg0.activeWidget.gridInfoTable.gridRowIndex
	local f55_local1 = f55_arg0.activeWidget.gridInfoTable.gridColIndex
	local f55_local2 = f55_arg0.currentStartRow
	local f55_local3 = f55_arg0.currentStartRow + f55_arg0.vCount - 1
	local f55_local4 = f55_arg0.currentStartColumn
	local f55_local5 = f55_arg0.currentStartColumn + f55_arg0.hCount - 1
	local f55_local6 = LUI.clamp(f55_local0, f55_local2, f55_local3)
	local f55_local7 = LUI.clamp(f55_local1, f55_local4, f55_local5)
	if f55_local6 ~= f55_local0 or f55_local7 ~= f55_local1 then
		f55_arg0:setActiveIndex(f55_local6, f55_local7)
	end
end
LUI.GridLayout.updateLayoutBasedOnVScrollbarMovement = function(f56_arg0, f56_arg1)
	if f56_arg0.verticalScrollbar.slider.dragStartBarTop then
		local f56_local0 = f56_arg0.verticalScrollbar.slider.dragStartBarTop + f56_arg1
		local f56_local1 = f56_local0 + f56_arg0.verticalScrollbar.slider.barHeight
		if f56_arg0.verticalScrollbar.sliderTop < f56_local0 and f56_local1 < f56_arg0.verticalScrollbar.sliderTop + f56_arg0.verticalScrollbar.sliderHeight then
			f56_arg0.verticalScrollbar.slider:setTopBottom(true, false, f56_local0, f56_local1)
			f56_arg0.verticalScrollbar.slider.currentBarTop = f56_local0
			f56_arg0.currentStartRow = f0_local3((f56_local0 - f56_arg0.verticalScrollbar.sliderTop) / f56_arg0.verticalScrollbar.sliderHeight * f56_arg0.requestedRowCount) + 1
			f56_arg0:updateLayout()
		end
	end
end
LUI.GridLayout.updateLayoutBasedOnVScrollbarPercentage = function(f57_arg0, f57_arg1)
	f57_arg0.currentStartRow = math.min(f0_local3(f57_arg1 * f57_arg0.requestedRowCount) + 1, f57_arg0.requestedRowCount - f57_arg0.vCount + 1)
	f57_arg0:updateLayout()
	f57_arg0:validateActiveItemVisibility()
end
LUI.GridLayout.updateLayoutBasedOnHScrollbarPercentage = function(f58_arg0, f58_arg1)
	f58_arg0.currentStartColumn = math.min(f0_local3(f58_arg1 * f58_arg0.requestedColumnCount) + 1, f58_arg0.requestedColumnCount - f58_arg0.hCount + 1)
	f58_arg0:updateLayout()
	f58_arg0:validateActiveItemVisibility()
end
LUI.GridLayout.scrollBarDragStart = function(f59_arg0)
	f59_arg0.scrollbarDragging = true
end
LUI.GridLayout.scrollBarDragStop = function(f60_arg0)
	f60_arg0.scrollbarDragging = false
	f60_arg0.verticalScrollbar.slider.dragStartBarTop = f60_arg0.verticalScrollbar.slider.currentBarTop
end
LUI.GridLayout.scrollUp = function(f61_arg0)
	if f61_arg0.vCount < f61_arg0.requestedRowCount then
		f61_arg0.currentStartRow = math.max(f61_arg0.currentStartRow - 1, 1)
		f61_arg0:updateLayout()
		return true
	else
		return false
	end
end
LUI.GridLayout.scrollDown = function(f62_arg0)
	if f62_arg0.vCount < f62_arg0.requestedRowCount then
		f62_arg0.currentStartRow = math.min(f62_arg0.currentStartRow + 1, f62_arg0.requestedRowCount - f62_arg0.vCount + 1)
		f62_arg0:updateLayout()
		return true
	else
		return false
	end
end
LUI.GridLayout.scrollLeft = function(f63_arg0)
	if f63_arg0.hCount < f63_arg0.requestedColumnCount then
		f63_arg0.currentStartColumn = math.max(f63_arg0.currentStartColumn - 1, 1)
		f63_arg0:updateLayout()
		return true
	else
		return false
	end
end
LUI.GridLayout.scrollRight = function(f64_arg0)
	if f64_arg0.hCount < f64_arg0.requestedColumnCount then
		f64_arg0.currentStartColumn = math.min(f64_arg0.currentStartColumn + 1, f64_arg0.requestedColumnCount - f64_arg0.hCount + 1)
		f64_arg0:updateLayout()
		return true
	else
		return false
	end
end
LUI.GridLayout.getCurrentRowPercentage = function(f65_arg0)
	return (f65_arg0.currentStartRow - 1) / f65_arg0.requestedRowCount
end
LUI.GridLayout.getCurrentColumnPercentage = function(f66_arg0)
	return (f66_arg0.currentStartColumn - 1) / f66_arg0.requestedColumnCount
end
LUI.GridLayout.updateScrollbars = function(f67_arg0)
	local f67_local0, f67_local1 = f67_arg0:getLocalSize()
	if f67_arg0.verticalScrollbar then
		if f67_arg0.requestedRowCount <= f67_arg0.vCount then
			f67_arg0.verticalScrollbar:close()
		elseif not f67_arg0.verticalScrollbar:getParent() then
			f67_arg0:addElement(f67_arg0.verticalScrollbar)
		end
	end
	if f67_arg0.verticalScrollbar and not f67_arg0.scrollbarDragging then
		local f67_local2 = "DefaultState"
		if f67_arg0.requestedRowCount <= f67_arg0.vCount then
			f67_local2 = "AtTopAndBottom"
		elseif f67_arg0.currentStartRow == 1 and not f67_arg0.loopEdges then
			f67_local2 = "AtTop"
		elseif f67_arg0.requestedRowCount < f67_arg0.currentStartRow + f67_arg0.vCount and not f67_arg0.loopEdges then
			f67_local2 = "AtBottom"
		end
		if f67_arg0.verticalScrollbar.slider then
			if f67_arg0.verticalScrollbar.sliderHeight == nil then
				local f67_local3, f67_local4, f67_local5, f67_local6 = f67_arg0.verticalScrollbar.slider:getLocalRect()
				f67_arg0.verticalScrollbar.sliderHeight = f67_local1 - f67_local4 + f67_local6
				f67_arg0.verticalScrollbar.sliderTop = f67_local4
			end
			local f67_local3 = math.min(f67_arg0.vCount / f67_arg0.requestedRowCount, 1)
			local f67_local5 = f67_arg0:getCurrentRowPercentage() * f67_arg0.verticalScrollbar.sliderHeight
			local f67_local6 = f67_local3 * f67_arg0.verticalScrollbar.sliderHeight
			local f67_local7 = f67_arg0.verticalScrollbar.sliderTop + f67_local5
			f67_arg0.verticalScrollbar.slider:beginAnimation("update_position")
			f67_arg0.verticalScrollbar.slider:setTopBottom(true, false, f67_local7, f67_local7 + f67_local6)
			f67_arg0.verticalScrollbar.slider.barHeight = f67_local6
			f67_arg0.verticalScrollbar.slider.dragStartBarTop = f67_local7
		end
		f67_arg0.verticalScrollbar:setState(f67_arg0.controller, f67_local2)
	end
	if f67_arg0.horizontalScrollbar then
		local f67_local2 = "DefaultState"
		if f67_arg0.requestedColumnCount <= f67_arg0.hCount then
			f67_local2 = "AtLeftAndRight"
		elseif f67_arg0.currentStartColumn == 1 then
			f67_local2 = "AtLeft"
		elseif f67_arg0.requestedColumnCount < f67_arg0.currentStartColumn + f67_arg0.hCount then
			f67_local2 = "AtRight"
		end
		if f67_arg0.horizontalScrollbar.slider then
			if f67_arg0.horizontalScrollbar.sliderWidth == nil then
				local f67_local3, f67_local4, f67_local5, f67_local6 = f67_arg0.horizontalScrollbar.slider:getLocalRect()
				f67_arg0.horizontalScrollbar.sliderWidth = f67_local0 - f67_local3 + f67_local5
				f67_arg0.horizontalScrollbar.sliderLeft = f67_local3
			end
			local f67_local3 = math.min(f67_arg0.hCount / f67_arg0.requestedColumnCount, 1)
			local f67_local5 = f67_arg0:getCurrentColumnPercentage() * f67_arg0.horizontalScrollbar.sliderWidth
			local f67_local6 = f67_local3 * f67_arg0.horizontalScrollbar.sliderWidth
			local f67_local7 = f67_arg0.horizontalScrollbar.sliderLeft + f67_local5
			f67_arg0.horizontalScrollbar.slider:beginAnimation("update_position")
			f67_arg0.horizontalScrollbar.slider:setLeftRight(true, false, f67_local7, f67_local7 + f67_local6)
			f67_arg0.horizontalScrollbar.slider.barWidth = f67_local6
		end
		f67_arg0.horizontalScrollbar:setState(f67_arg0.controller, f67_local2)
	end
end
LUI.GridLayout.updateVerticalCounter = function(f68_arg0, f68_arg1)
	if f68_arg1 then
		local f68_local0 = "DefaultState"
		if f68_arg0.requestedRowCount <= f68_arg0.vCount then
			f68_local0 = "AtTopAndBottom"
		elseif f68_arg0.currentStartRow == 1 then
			f68_local0 = "AtTop"
		elseif f68_arg0.requestedRowCount < f68_arg0.currentStartRow + f68_arg0.vCount then
			f68_local0 = "AtBottom"
		end
		if f68_arg1.currentItem then
			local f68_local1 = 1
			if f68_arg0.activeWidget then
				f68_local1 = f68_arg0.activeWidget.gridInfoTable.zeroBasedIndex + 1
			end
			f68_arg1.currentItem:setText(f68_local1)
		end
		if f68_arg1.count then
			local f68_local1 = f68_arg0.itemCount
			if not f68_local1 then
				f68_local1 = 0
			end
			f68_arg1.count:setText(f68_local1)
			if f68_local1 == 0 and f68_arg1.__clipsPerState and f68_arg1.__clipsPerState.NoItems then
				f68_local0 = "NoItems"
			end
		end
		if f68_arg1.pageText then
			f68_arg1.pageText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A205700391CF3AD", math.ceil(f68_arg0.currentStartRow / f68_arg0.vCount), math.ceil(f68_arg0.requestedRowCount / f68_arg0.vCount)))
		end
		f68_arg1:setState(f68_arg0.controller, f68_local0)
	end
end
LUI.GridLayout.updateHorizontalCounter = function(f69_arg0, f69_arg1)
	if f69_arg1 then
		local f69_local0 = "DefaultState"
		if f69_arg0.requestedColumnCount <= f69_arg0.hCount then
			if not CoD.isPC then
				local f69_local1 = "AtLeftAndRight"
			end
			f69_local0 = f69_local1 or "AtLeftAndRightPC"
		elseif f69_arg0.activeWidget then
			if f69_arg0.activeWidget.gridInfoTable.gridColIndex == 1 then
				f69_local0 = "AtLeft"
			elseif f69_arg0.requestedColumnCount <= f0_local1(f69_arg0.activeWidget) then
				f69_local0 = "AtRight"
			end
		end
		if f69_arg1.currentItem then
			local f69_local2 = 1
			if f69_arg0.activeWidget then
				f69_local2 = f69_arg0.activeWidget.gridInfoTable.zeroBasedIndex + 1
			end
			f69_arg1.currentItem:setText(f69_local2)
		end
		if f69_arg1.count then
			local f69_local2 = f69_arg0.itemCount
			if not f69_local2 then
				f69_local2 = 0
			end
			f69_arg1.count:setText(f69_local2)
			if f69_local2 == 0 and f69_arg1.__clipsPerState and f69_arg1.__clipsPerState.NoItems then
				f69_local0 = "NoItems"
			end
		end
		f69_arg1:setState(f69_arg0.controller, f69_local0)
	end
end
LUI.GridLayout.updateHorizontalPips = function(f70_arg0, f70_arg1)
	if f70_arg1 then
		f70_arg1.backing:setShaderVector(1, f70_arg0.itemCount, 1, 0, 0)
		local f70_local0 = f70_arg0.activeWidget and f70_arg0.activeWidget.gridInfoTable.zeroBasedIndex + 1 or 1
		local f70_local1 = 1 / f70_arg0.itemCount
		local f70_local2 = (f70_local0 - 1) * f70_local1
		local f70_local3 = f70_local2 + f70_local1
		f70_arg1.current:setShaderVector(1, f70_arg0.itemCount, 1, 0, 0)
		f70_arg1.current:setShaderVector(2, f70_local2, f70_local3, 0, 1)
	end
end
LUI.GridLayout.updateCounters = function(f71_arg0)
	f71_arg0:updateVerticalCounter(f71_arg0.verticalCounter)
	f71_arg0:updateVerticalCounter(f71_arg0.customVerticalCounter)
	f71_arg0:updateHorizontalCounter(f71_arg0.horizontalCounter)
	f71_arg0:updateHorizontalCounter(f71_arg0.customHorizontalCounter)
	f71_arg0:updateHorizontalPips(f71_arg0.horizontalPips)
	f71_arg0:updateHorizontalPips(f71_arg0.customHorizontalPips)
end
LUI.GridLayout.resetCurrentRowAndColumn = function(f72_arg0)
	f72_arg0.currentStartRow = 1
	f72_arg0.currentStartColumn = 1
	f72_arg0.previousStartRow = 1
	f72_arg0.previousStartColumn = 1
end
LUI.GridLayout.isWidgetSelectable = function(f73_arg0, f73_arg1)
	if f73_arg1.internal then
		return f73_arg1.internal:hasClip("Active")
	else
		return f73_arg1:hasClip("Active")
	end
end
LUI.GridLayout.getWidgetVisiblePosition = function(f74_arg0, f74_arg1)
	local f74_local0 = 0
	local f74_local1 = 0
	if f74_arg1.gridInfoTable.gridRowIndex < f74_arg0.currentStartRow then
		f74_local0 = f74_arg1.gridInfoTable.gridRowIndex - f74_arg0.currentStartRow
	elseif f74_arg0.currentStartRow + f74_arg0.vCount <= f0_local0(f74_arg1) then
		f74_local0 = f0_local0(f74_arg1) - f74_arg0.currentStartRow + f74_arg0.vCount + 1
	end
	if f74_arg1.gridInfoTable.gridColIndex < f74_arg0.currentStartColumn then
		f74_local1 = f74_arg1.gridInfoTable.gridColIndex - f74_arg0.currentStartColumn
	elseif f74_arg0.currentStartColumn + f74_arg0.hCount <= f0_local1(f74_arg1) then
		f74_local1 = f0_local1(f74_arg1) - f74_arg0.currentStartColumn + f74_arg0.hCount + 1
	end
	return f74_local0, f74_local1
end
LUI.GridLayout.setActiveItem = function(f75_arg0, f75_arg1, f75_arg2)
	if f75_arg0.activeWidget then
		f75_arg0.activeWidget:processEvent({
			name = "lose_active",
			controller = f75_arg0.controller,
		})
	end
	f75_arg0.lastActiveWidget = f75_arg0.activeWidget
	f75_arg0.activeWidget = f75_arg1
	if f75_arg0.activeWidget then
		f75_arg0.savedActiveIndex = f75_arg0.activeWidget.gridInfoTable.zeroBasedIndex
		f75_arg0.activeWidget:processEvent({
			name = "gain_active",
			controller = f75_arg0.controller,
		})
		f75_arg0.activeWidget:dispatchEventToParentWithSelf({
			name = "list_active_changed",
			list = f75_arg0,
			model = f75_arg0.activeWidget:getModel(),
		})
		if f75_arg0.activeWidgetInPlace then
			local f75_local0 = f75_arg1.gridInfoTable.gridColIndex
			if (f75_arg0.loopEdges or f75_arg0.__centerActiveWidget) and f75_arg0.hCount > 1 and f75_arg0.hCount % 2 == 1 then
				f75_local0 = f75_local0 - (f75_arg0.hCount - 1) / 2
			end
			if f75_arg0.currentStartRow ~= f75_arg1.gridInfoTable.gridRowIndex or f75_arg0.currentStartColumn ~= f75_local0 then
				f75_arg0:updateCurrentPosition(f75_arg1.gridInfoTable.gridRowIndex, f75_local0)
				f75_arg0:updateLayout(f75_arg2 or f75_arg0.scrollAnimationTime)
			else
				f75_arg0:updateLayout(0)
			end
		else
			local f75_local0, f75_local1 = f75_arg0:getWidgetVisiblePosition(f75_arg1)
			f75_arg0:updateCurrentPosition(f75_arg0.currentStartRow + f75_local0, f75_arg0.currentStartColumn + f75_local1)
			if f75_local0 ~= 0 or f75_local1 ~= 0 then
				local f75_local2 = f75_arg2
				local f75_local3
				if math.abs(f75_local0) <= 1 and math.abs(f75_local1) <= 1 then
					f75_local3 = f75_arg0.scrollAnimationTime
					if not f75_local3 then
					else
						f75_arg0:updateLayout(f75_local3)
					end
				end
				f75_local3 = f75_local2 or 0
			end
		end
		f75_arg0:setModel(f75_arg0.activeWidget:getModel(), f75_arg0.controller)
	else
		f75_arg0:setModel(nil, f75_arg0.controller)
		if f75_arg0.hasListFocus and f75_arg0.updateButtonPromptsWhenEmptied then
			CoD.Menu.UpdateAllButtonPrompts(f75_arg0.menu, f75_arg0.controller)
		end
	end
	f75_arg0:dispatchEventToParent({
		name = "grid_item_changed",
		grid = f75_arg0,
	})
	f75_arg0:updateCounters()
end
LUI.GridLayout.clearSavedActiveIndex = function(f76_arg0)
	f76_arg0.savedActiveIndex = nil
end
LUI.GridLayout.findItem = function(f77_arg0, f77_arg1, f77_arg2, f77_arg3, f77_arg4)
	for f77_local0 = 1, f77_arg0.requestedRowCount, 1 do
		for f77_local3 = 1, f77_arg0.requestedColumnCount, 1 do
			local f77_local6 = true
			if f77_arg1 then
				local f77_local7 = f77_arg0:getModelForPosition(f77_local0, f77_local3)
				if f77_local7 then
					for f77_local11, f77_local12 in pairs(f77_arg1) do
						local f77_local13 = Engine[@"getmodel"](f77_local7, f77_local11)
						if not f77_local13 or Engine[@"getmodelvalue"](f77_local13) ~= f77_local12 then
							f77_local6 = false
						end
					end
				else
					f77_local6 = false
				end
			end
			if f77_local6 and f77_arg2 then
				local f77_local8 = f77_arg0:getItemAtPosition(f77_local0, f77_local3, false) or f77_arg0:getPropertiesForPosition(f77_local0, f77_local3)
				if f77_local8 then
					for f77_local12, f77_local13 in pairs(f77_arg2) do
						if f77_local8[f77_local12] ~= f77_local13 then
							f77_local6 = false
						end
					end
				else
					f77_local6 = false
				end
			end
			if f77_local6 then
				local f77_local7 = f77_arg0:getItemAtPosition(f77_local0, f77_local3, true)
				if f77_arg3 then
					f77_arg0:setActiveItem(f77_local7, f77_arg4)
				end
				return f77_local7
			end
		end
	end
	return nil
end
LUI.GridLayout.findVisibleItem = function(f78_arg0, f78_arg1, f78_arg2)
	for f78_local14, f78_local15 in LUI.IterateTableBySortedKeys(f78_arg0.layoutItems) do
		for f78_local11, f78_local12 in LUI.IterateTableBySortedKeys(f78_local15) do
			local f78_local7 = true
			if f78_arg1 then
				local f78_local3 = f78_local12:getModel()
				if f78_local3 then
					for f78_local8, f78_local9 in pairs(f78_arg1) do
						local f78_local10 = Engine[@"getmodel"](f78_local3, f78_local8)
						if not f78_local10 or Engine[@"getmodelvalue"](f78_local10) ~= f78_local9 then
							f78_local7 = false
						end
					end
				else
					f78_local7 = false
				end
			end
			if f78_local7 and f78_arg2 then
				for f78_local6, f78_local8 in pairs(f78_arg2) do
					if f78_local12[f78_local6] ~= f78_local8 then
						f78_local7 = false
						break
					end
				end
			end
			if f78_local7 then
				return f78_local12
			end
		end
	end
	return nil
end
LUI.GridLayout.getItemAtPosition = function(f79_arg0, f79_arg1, f79_arg2, f79_arg3)
	local f79_local0 = nil
	local f79_local1 = f79_arg0.layoutItems[f79_arg1]
	if f79_local1 then
		f79_local0 = f79_local1[f79_arg2]
	end
	if not f79_local0 and f79_arg3 then
		f79_local0 = f79_arg0:createWidgetForPosition(f79_arg1, f79_arg2, f79_arg0.currentStartRow, f79_arg0.currentStartColumn)
	end
	return f79_local0
end
LUI.GridLayout.setActiveIndex = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3, f80_arg4)
	if not f80_arg1 or not f80_arg2 then
		return false
	elseif f80_arg1 < 1 or f80_arg0.requestedRowCount < f80_arg1 or f80_arg2 < 1 or f80_arg0.requestedColumnCount < f80_arg2 then
		return false
	else
		local f80_local0 = f80_arg0:getItemAtPosition(f80_arg1, f80_arg2, true)
		if f80_local0 and (f80_arg4 or f80_arg0:isWidgetSelectable(f80_local0)) then
			f80_arg0:setActiveItem(f80_local0, f80_arg3)
			return true
		else
			return false
		end
	end
end
LUI.GridLayout.getRowAndColumnForIndex = function(f81_arg0, f81_arg1)
	local f81_local0, f81_local1 = nil
	if f81_arg0.vCount == 1 then
		f81_local0 = 1
		f81_local1 = f81_arg1 + 1
	else
		f81_local0 = math.floor(f81_arg1 / f81_arg0.hCount) + 1
		f81_local1 = f81_arg1 % f81_arg0.hCount + 1
	end
	return f81_local0, f81_local1
end
LUI.GridLayout.SetNavigationItem = function(f82_arg0, f82_arg1, f82_arg2, f82_arg3)
	if not f82_arg3 then
		f82_arg3 = 0
	end
	if f82_arg1 and f82_arg0:isWidgetSelectable(f82_arg1) then
		f82_arg0:setActiveItem(f82_arg1)
		if CoD.BitUtility.IsBitwiseAndNonZero(f82_arg3, LUI.GridLayout.NavigationFlags.CHANGE_FOCUS) and f82_arg0.menu then
			if not f82_arg1:isFocusable() then
				f82_arg1 = CoD.BaseUtility.FindSingleFocusableDescendant(f82_arg1, true)
				if not f82_arg1 then
					return true
				end
			end
			f82_arg0.menu:ChangeFocusedElement(f82_arg0.controller, f82_arg1, true)
			if CoD.BitUtility.IsBitwiseAndNonZero(f82_arg3, LUI.GridLayout.NavigationFlags.MOVE_CURSOR) then
				f82_arg1:addElement(LUI.UITimer.newElementTimer(0, true, function()
					f82_arg1:centerFreeCursorOnElement(f82_arg0.controller)
				end))
			end
		end
		if f82_arg2 ~= nil then
			f82_arg1:playSound(f82_arg2)
		end
		return true
	else
		return false
	end
end
LUI.GridLayout.navigateItemLeft = function(f84_arg0, f84_arg1, f84_arg2)
	f84_arg0.lastDirection = "left"
	local f84_local0
	if not f84_arg2 then
		f84_local0 = "list_left"
		if not f84_local0 then
		else
			local f84_local1 = f84_arg0.activeWidget
			if f84_local1 and f84_local1.gridInfoTable ~= nil then
				if LUI.DEV then
					local f84_local2 = assert
					local f84_local3
					if f84_local1:getParent() ~= nil then
						f84_local3 = f84_local1:getParent()
						f84_local3 = f84_local3:getParent()
						if f84_local3.id ~= f84_arg0.id then
							f84_local3 = false
						end
					end
					f84_local3 = true
				end
				local f84_local2 = f84_local1.gridInfoTable.gridRowIndex
				local f84_local3 = f84_local1.gridInfoTable.gridColIndex - 1
				for f84_local4 = f84_local3, 1, -1 do
					for f84_local7 = 0, f84_local1.gridInfoTable.gridRowSpan - 1, 1 do
						if f84_arg0:SetNavigationItem(f84_arg0:getItemAtPosition(f84_local2 + f84_local7, f84_local4, true), f84_local0, f84_arg1) then
							return true
						end
					end
				end
				if f84_arg0.loopEdges then
					if f84_arg0.__loopOnSameRow then
						f84_local4 = f84_arg0.__allowCreateOnLoop or false
						local f84_local5 = f84_arg0.hCount
						if f84_local4 then
							f84_local5 = f84_arg0.requestedColumnCount
						end
						local f84_local6 = f84_arg0:getItemAtPosition(f84_local2, f84_local5, f84_local4)
						if f84_local6 and f84_arg0:SetNavigationItem(f84_local6, f84_local0, f84_arg1) then
							return true
						end
					elseif f84_arg0.hCount > 1 and f84_arg0.vCount > 1 then
						for f84_local4 = f84_arg0.requestedColumnCount, 1, -1 do
							for f84_local7 = f84_local2 - 1, 1, -1 do
								if f84_arg0:SetNavigationItem(f84_arg0:getItemAtPosition(f84_local7, f84_local4, true), f84_local0, f84_arg1) then
									return true
								end
							end
						end
					end
					return false
				end
				for f84_local4 = f84_local3, 1, -1 do
					for f84_local7 = f84_arg0.requestedRowCount, 1, -1 do
						if f84_arg0:SetNavigationItem(f84_arg0:getItemAtPosition(f84_local7, f84_local4, true), f84_local0, f84_arg1) then
							return true
						end
					end
				end
				if f84_arg0.loopEdges and (f84_arg0.hCount == 1 or f84_arg0.vCount == 1) then
					for f84_local4 = f84_arg0.requestedColumnCount, f0_local1(f84_local1) + 1, -1 do
						for f84_local7 = f84_local2, 1, -1 do
							if f84_arg0:SetNavigationItem(f84_arg0:getItemAtPosition(f84_local7, f84_local4, true), f84_local0, f84_arg1) then
								return true
							end
						end
					end
					if CoD.isPC and f84_arg0.requestedRowCount == 1 and f84_arg0.requestedColumnCount == 1 then
						return true
					end
				end
				if f84_arg0.CustomNavigation then
					local f84_local4 = f84_arg0.CustomNavigation.left
					if f84_local4 then
						if f84_local4 == f84_arg0 then
							return true
						elseif f84_local4:processEvent({
							name = "gain_focus",
							controller = f84_arg0.controller,
						}) then
							f84_arg0:processEvent({
								name = "lose_focus",
								controller = f84_arg0.controller,
							})
							return true
						end
					end
				end
			end
			return false
		end
	end
	f84_local0 = nil
end
LUI.GridLayout.getItemAtOffset = function(f85_arg0, f85_arg1, f85_arg2)
	if f85_arg0.activeWidget ~= nil then
		local f85_local0 = f85_arg0:getItemAtPosition(f85_arg0.activeWidget.gridInfoTable.gridRowIndex + f85_arg1, f0_local1(f85_arg0.activeWidget) + f85_arg2, false)
		if f85_local0 and f85_arg0:isWidgetSelectable(f85_local0) then
			return f85_local0
		end
	end
end
LUI.GridLayout.navigateItemRight = function(f86_arg0, f86_arg1, f86_arg2)
	f86_arg0.lastDirection = "right"
	local f86_local0
	if not f86_arg2 then
		f86_local0 = "list_right"
		if not f86_local0 then
		else
			local f86_local1 = f86_arg0.activeWidget
			if f86_local1 and f86_local1.gridInfoTable ~= nil then
				if LUI.DEV then
					local f86_local2 = assert
					local f86_local3
					if f86_local1:getParent() ~= nil then
						f86_local3 = f86_local1:getParent()
						f86_local3 = f86_local3:getParent()
						if f86_local3.id ~= f86_arg0.id then
							f86_local3 = false
						end
					end
					f86_local3 = true
				end
				local f86_local2 = f86_local1.gridInfoTable.gridRowIndex
				local f86_local3 = f0_local1(f86_local1) + 1
				for f86_local4 = f86_local3, f86_arg0.requestedColumnCount, 1 do
					for f86_local7 = 0, f86_local1.gridInfoTable.gridRowSpan - 1, 1 do
						if f86_arg0:SetNavigationItem(f86_arg0:getItemAtPosition(f86_local2 + f86_local7, f86_local4, true), f86_local0, f86_arg1) then
							return true
						end
					end
				end
				if f86_arg0.loopEdges then
					if f86_arg0.__loopOnSameRow then
						local f86_local5 = f86_arg0:getItemAtPosition(f86_local2, 1, f86_arg0.__allowCreateOnLoop or false)
						if f86_local5 and f86_arg0:SetNavigationItem(f86_local5, f86_local0, f86_arg1) then
							return true
						end
					elseif f86_arg0.hCount > 1 and f86_arg0.vCount > 1 then
						for f86_local4 = 1, f86_arg0.requestedColumnCount, 1 do
							for f86_local7 = f0_local0(f86_local1) + 1, f86_arg0.requestedRowCount, 1 do
								if f86_arg0:SetNavigationItem(f86_arg0:getItemAtPosition(f86_local7, f86_local4, true), f86_local0, f86_arg1) then
									return true
								end
							end
						end
					end
					return false
				end
				for f86_local4 = f86_local3, f86_arg0.requestedColumnCount, 1 do
					for f86_local7 = f86_arg0.requestedRowCount, 1, -1 do
						if f86_arg0:SetNavigationItem(f86_arg0:getItemAtPosition(f86_local7, f86_local4, true), f86_local0, f86_arg1) then
							return true
						end
					end
				end
				if f86_arg0.loopEdges and (f86_arg0.hCount == 1 or f86_arg0.vCount == 1) then
					for f86_local4 = 1, f86_local1.gridInfoTable.gridColIndex - 1, 1 do
						for f86_local7 = f86_local2, 1, -1 do
							if f86_arg0:SetNavigationItem(f86_arg0:getItemAtPosition(f86_local7, f86_local4, true), f86_local0, f86_arg1) then
								return true
							end
						end
					end
					if CoD.isPC and f86_arg0.requestedRowCount == 1 and f86_arg0.requestedColumnCount == 1 then
						return true
					end
				end
				if f86_arg0.CustomNavigation then
					local f86_local4 = f86_arg0.CustomNavigation.right
					if f86_local4 then
						if f86_local4 == f86_arg0 then
							return true
						elseif f86_local4:processEvent({
							name = "gain_focus",
							controller = f86_arg0.controller,
						}) then
							f86_arg0:processEvent({
								name = "lose_focus",
								controller = f86_arg0.controller,
							})
							return true
						end
					end
				end
			end
			return false
		end
	end
	f86_local0 = nil
end
LUI.GridLayout.navigateItemUp = function(f87_arg0, f87_arg1)
	f87_arg0.lastDirection = "up"
	local f87_local0 = f87_arg0.activeWidget
	if f87_local0 and f87_local0.gridInfoTable ~= nil then
		if LUI.DEV then
			local f87_local1 = assert
			local f87_local2
			if f87_local0:getParent() ~= nil then
				f87_local2 = f87_local0:getParent()
				f87_local2 = f87_local2:getParent()
				if f87_local2.id ~= f87_arg0.id then
					f87_local2 = false
				end
			end
			f87_local2 = true
		end
		local f87_local1 = f87_local0.gridInfoTable.gridRowIndex
		local f87_local2 = f87_arg0:getAlignment()
		local f87_local3 = #f87_arg0.rowColumnIndexMap[f87_local1]
		f87_local1 = f87_local1 - 1
		local f87_local4 = f87_local0.gridInfoTable.gridColIndex
		local f87_local5 = 1
		if f87_arg0.__disableVerticalNavigationScroll then
			f87_local5 = f87_arg0.currentStartRow
		end
		for f87_local6 = f87_local1, f87_local5, -1 do
			local f87_local9 = f87_local4
			if CoD.BitUtility.IsBitwiseAndNonZero(f87_local2, Enum[@"luialignment"][@"lui_alignment_center"]) then
				f87_local9 = f87_local9 + math.floor((#f87_arg0.rowColumnIndexMap[f87_local6] - f87_local3) / 2)
			elseif CoD.BitUtility.IsBitwiseAndNonZero(f87_local2, Enum[@"luialignment"][@"lui_alignment_right"]) then
				f87_local9 = f87_local9 + #f87_arg0.rowColumnIndexMap[f87_local5] - f87_local3
			end
			for f87_local10 = 0, f87_local0.gridInfoTable.gridColSpan - 1, 1 do
				if f87_arg0:SetNavigationItem(f87_arg0:getItemAtPosition(f87_local6, f87_local9 + f87_local10, true), "list_up", f87_arg1) then
					return true
				end
			end
		end
		for f87_local6 = f87_local1, f87_local5, -1 do
			for f87_local9 = f87_arg0.requestedColumnCount, 1, -1 do
				if f87_arg0:SetNavigationItem(f87_arg0:getItemAtPosition(f87_local6, f87_local9, true), "list_up", f87_arg1) then
					return true
				end
			end
		end
		if f87_arg0.loopEdges then
			if f87_arg0.__loopOnSameCol then
				local f87_local6 = f87_arg0:getItemAtPosition(f87_arg0.currentStartRow + f87_arg0.vCount - 1, f87_local4, false)
				if f87_local6 and f87_arg0:SetNavigationItem(f87_local6, "list_up", f87_arg1) then
					return true
				end
			elseif f87_arg0.hCount == 1 or f87_arg0.vCount == 1 then
				for f87_local6 = f87_arg0.requestedRowCount, f0_local0(f87_local0) + 1, -1 do
					for f87_local9 = f87_local4, 1, -1 do
						if f87_arg0:SetNavigationItem(f87_arg0:getItemAtPosition(f87_local6, f87_local9, true), "list_up", f87_arg1) then
							return true
						end
					end
				end
			end
			if CoD.isPC and f87_arg0.requestedRowCount == 1 and f87_arg0.requestedColumnCount == 1 then
				return true
			end
		end
		if (f87_arg0.blockTopEdge or f87_arg0.blockEdges) and f87_local1 == 1 then
			return true
		elseif f87_arg0.CustomNavigation then
			f87_local6 = f87_arg0.CustomNavigation.up
			if f87_local6 then
				if f87_local6 == f87_arg0 then
					return true
				elseif f87_local6:processEvent({
					name = "gain_focus",
					controller = f87_arg0.controller,
				}) then
					f87_arg0:processEvent({
						name = "lose_focus",
						controller = f87_arg0.controller,
					})
					return true
				end
			end
		end
	end
	return false
end
LUI.GridLayout.navigateItemDown = function(f88_arg0, f88_arg1)
	f88_arg0.lastDirection = "down"
	local f88_local0 = f88_arg0.activeWidget
	if f88_local0 and f88_local0.gridInfoTable ~= nil then
		if LUI.DEV then
			local f88_local1 = assert
			local f88_local2
			if f88_local0:getParent() ~= nil then
				f88_local2 = f88_local0:getParent()
				f88_local2 = f88_local2:getParent()
				if f88_local2.id ~= f88_arg0.id then
					f88_local2 = false
				end
			end
			f88_local2 = true
		end
		local f88_local1 = f0_local0(f88_local0)
		local f88_local2 = f88_arg0:getAlignment()
		local f88_local3 = #f88_arg0.rowColumnIndexMap[f88_local1]
		f88_local1 = f88_local1 + 1
		local f88_local4 = f88_local0.gridInfoTable.gridColIndex
		local f88_local5 = f88_arg0.requestedRowCount
		if f88_arg0.__disableVerticalNavigationScroll then
			f88_local5 = f88_arg0.currentStartRow + f88_arg0.vCount - 1
		end
		for f88_local6 = f88_local1, f88_local5, 1 do
			local f88_local9 = f88_local4
			if CoD.BitUtility.IsBitwiseAndNonZero(f88_local2, Enum[@"luialignment"][@"lui_alignment_center"]) then
				f88_local9 = f88_local9 - math.floor((f88_local3 - #f88_arg0.rowColumnIndexMap[f88_local6]) / 2)
			elseif CoD.BitUtility.IsBitwiseAndNonZero(f88_local2, Enum[@"luialignment"][@"lui_alignment_right"]) then
				f88_local9 = f88_local9 - f88_local3 - #f88_arg0.rowColumnIndexMap[f88_local5]
			end
			for f88_local10 = 0, f88_local0.gridInfoTable.gridColSpan - 1, 1 do
				if f88_arg0:SetNavigationItem(f88_arg0:getItemAtPosition(f88_local6, f88_local9 + f88_local10, true), "list_down", f88_arg1) then
					return true
				end
			end
		end
		for f88_local6 = f88_local1, f88_local5, 1 do
			for f88_local9 = f88_arg0.requestedColumnCount, 1, -1 do
				if f88_arg0:SetNavigationItem(f88_arg0:getItemAtPosition(f88_local6, f88_local9, true), "list_down", f88_arg1) then
					return true
				end
			end
		end
		if f88_arg0.loopEdges then
			if f88_arg0.__loopOnSameCol then
				local f88_local6 = f88_arg0:getItemAtPosition(f88_arg0.currentStartRow, f88_local4, false)
				if f88_local6 and f88_arg0:SetNavigationItem(f88_local6, "list_down", f88_arg1) then
					return true
				end
			elseif f88_arg0.hCount == 1 or f88_arg0.vCount == 1 then
				for f88_local6 = 1, f88_local0.gridInfoTable.gridRowIndex - 1, 1 do
					for f88_local9 = f88_local4, 1, -1 do
						if f88_arg0:SetNavigationItem(f88_arg0:getItemAtPosition(f88_local6, f88_local9, true), "list_down", f88_arg1) then
							return true
						end
					end
				end
			end
			if CoD.isPC and f88_arg0.requestedRowCount == 1 and f88_arg0.requestedColumnCount == 1 then
				return true
			end
		end
		if (f88_arg0.blockBottomEdge or f88_arg0.blockEdges) and f88_local1 == f88_arg0.requestedRowCount then
			return true
		elseif f88_arg0.CustomNavigation then
			f88_local6 = f88_arg0.CustomNavigation.down
			if f88_local6 then
				if f88_local6 == f88_arg0 then
					return true
				elseif f88_local6:processEvent({
					name = "gain_focus",
					controller = f88_arg0.controller,
				}) then
					f88_arg0:processEvent({
						name = "lose_focus",
						controller = f88_arg0.controller,
					})
					return true
				end
			end
		end
	end
	return false
end
LUI.GridLayout.EnsureValidRowBounds = function(f89_arg0, f89_arg1)
	return math.max(1, math.min(f89_arg0.requestedRowCount - f89_arg0.vCount + 1, f89_arg1))
end
LUI.GridLayout.pageDown = function(f90_arg0)
	local f90_local0 = f90_arg0:EnsureValidRowBounds(f90_arg0.currentStartRow + f90_arg0.vCount)
	if f90_arg0.currentStartRow == f90_local0 then
		return
	end
	f90_arg0.lastDirection = "down"
	local f90_local1 = f90_local0
	local f90_local2 = f90_arg0.currentStartColumn
	if f90_arg0._keepSelectionPositionWhenPaging and f90_arg0.activeWidget then
		f90_local1 = f90_local1 + f90_arg0.activeWidget.gridInfoTable.gridRowIndex - f90_arg0.currentStartRow
		f90_local2 = f90_arg0.activeWidget.gridInfoTable.gridColIndex
	end
	f90_arg0.currentStartRow = f90_local0
	f90_arg0:playSound("list_down")
	f90_arg0:updateLayout()
	local f90_local3 = f90_arg0:getItemAtPosition(f90_local1, f90_local2, true)
	if IsFreeCursorActiveAndVisible(f90_arg0.controller) then
		LUI.GridLayout.setActiveItem(f90_arg0, f90_local3)
	else
		f90_arg0:setActiveItem(f90_local3)
	end
end
LUI.GridLayout.pageUp = function(f91_arg0)
	local f91_local0 = f91_arg0:EnsureValidRowBounds(f91_arg0.currentStartRow - f91_arg0.vCount)
	if f91_arg0.currentStartRow == f91_local0 then
		return
	end
	f91_arg0.lastDirection = "up"
	local f91_local1 = f91_local0
	local f91_local2 = f91_arg0.currentStartColumn
	if f91_arg0._keepSelectionPositionWhenPaging and f91_arg0.activeWidget then
		f91_local1 = f91_local1 + f91_arg0.activeWidget.gridInfoTable.gridRowIndex - f91_arg0.currentStartRow
		f91_local2 = f91_arg0.activeWidget.gridInfoTable.gridColIndex
	end
	f91_arg0.currentStartRow = f91_local0
	f91_arg0:playSound("list_down")
	f91_arg0:updateLayout()
	local f91_local3 = f91_arg0:getItemAtPosition(f91_local1, f91_local2, true)
	if IsFreeCursorActiveAndVisible(f91_arg0.controller) then
		LUI.GridLayout.setActiveItem(f91_arg0, f91_local3)
	else
		f91_arg0:setActiveItem(f91_local3)
	end
end
LUI.GridLayout.EnsureValidColunmBounds = function(f92_arg0, f92_arg1)
	return math.max(1, math.min(f92_arg0.requestedColumnCount - f92_arg0.hCount + 1, f92_arg1))
end
LUI.GridLayout.pageRight = function(f93_arg0)
	local f93_local0 = f93_arg0:EnsureValidColunmBounds(f93_arg0.currentStartColumn + f93_arg0.hCount)
	if f93_arg0.currentStartColumn == f93_local0 then
		return
	end
	f93_arg0.lastDirection = "right"
	local f93_local1 = f93_arg0.currentStartRow
	local f93_local2 = f93_local0
	if f93_arg0._keepSelectionPositionWhenPaging and f93_arg0.activeWidget then
		f93_local1 = f93_arg0.activeWidget.gridInfoTable.gridRowIndex
		f93_local2 = f93_local2 + f93_arg0.activeWidget.gridInfoTable.gridColIndex - f93_arg0.currentStartColumn
	end
	f93_arg0.currentStartColumn = f93_local0
	f93_arg0:playSound("list_down")
	f93_arg0:updateLayout()
	local f93_local3 = f93_arg0:getItemAtPosition(f93_local1, f93_local2, true)
	if IsFreeCursorActiveAndVisible(f93_arg0.controller) then
		LUI.GridLayout.setActiveItem(f93_arg0, f93_local3)
	else
		f93_arg0:setActiveItem(f93_local3)
	end
end
LUI.GridLayout.pageLeft = function(f94_arg0)
	local f94_local0 = f94_arg0:EnsureValidColunmBounds(f94_arg0.currentStartColumn - f94_arg0.hCount)
	if f94_arg0.currentStartColumn == f94_local0 then
		return
	end
	f94_arg0.lastDirection = "left"
	local f94_local1 = f94_arg0.currentStartRow
	local f94_local2 = f94_local0
	if f94_arg0._keepSelectionPositionWhenPaging and f94_arg0.activeWidget then
		f94_local1 = f94_arg0.activeWidget.gridInfoTable.gridRowIndex
		f94_local2 = f94_local2 + f94_arg0.activeWidget.gridInfoTable.gridColIndex - f94_arg0.currentStartColumn
	end
	f94_arg0.currentStartColumn = f94_local0
	f94_arg0:playSound("list_down")
	f94_arg0:updateLayout()
	local f94_local3 = f94_arg0:getItemAtPosition(f94_local1, f94_local2, true)
	if IsFreeCursorActiveAndVisible(f94_arg0.controller) then
		LUI.GridLayout.setActiveItem(f94_arg0, f94_local3)
	else
		f94_arg0:setActiveItem(f94_local3)
	end
end
LUI.GridLayout.GetTableIndexForPosition = function(f95_arg0, f95_arg1, f95_arg2)
	local f95_local0 = f95_arg0.rowColumnIndexMap[f95_arg1]
	if f95_local0 then
		f95_local0 = f95_arg0.rowColumnIndexMap[f95_arg1][f95_arg2]
		if f95_local0 then
			f95_local0 = f95_arg0.rowColumnIndexMap[f95_arg1][f95_arg2].index
		end
	end
	return f95_local0
end
local f0_local4 = function(f96_arg0)
	return f96_arg0.gridInfoTable.zeroBasedIndex == 0
end
local f0_local5 = function(f97_arg0)
	local f97_local0 = f97_arg0.gridInfoTable.parentGrid:getDataSource()
	return f97_local0 and f97_arg0.gridInfoTable.zeroBasedIndex + 1 == f97_local0.getCount(f97_arg0.gridInfoTable.parentGrid)
end
local f0_local6 = function(f98_arg0)
	local f98_local0, f98_local1 = f98_arg0.gridInfoTable.parentGrid:getRowAndColumnForIndex(f98_arg0.gridInfoTable.zeroBasedIndex + 1)
	return f98_local0 == f98_arg0.gridInfoTable.parentGrid.currentStartRow
end
local f0_local7 = function(f99_arg0, f99_arg1)
	local f99_local0 = 1
	local f99_local1 = 1
	if not f99_arg0:isLastItem() then
		f99_local0, f99_local1 = f99_arg0.gridInfoTable.parentGrid:getRowAndColumnForIndex(f99_arg0.gridInfoTable.zeroBasedIndex + 1)
	elseif not f99_arg1 then
		return nil
	end
	return f99_arg0.gridInfoTable.parentGrid:getItemAtPosition(f99_local0, f99_local1, true)
end
local f0_local8 = function(f100_arg0, f100_arg1)
	local f100_local0 = 1
	local f100_local1 = 1
	if not f100_arg0:isFirstItem() then
		f100_local0, f100_local1 = f100_arg0.gridInfoTable.parentGrid:getRowAndColumnForIndex(f100_arg0.gridInfoTable.zeroBasedIndex - 1)
	elseif f100_arg1 then
		local f100_local2 = f100_arg0.gridInfoTable.parentGrid:getDataSource()
		if not f100_local2 then
			return nil
		end
		f100_local0, f100_local1 = f100_arg0.gridInfoTable.parentGrid:getRowAndColumnForIndex(f100_local2.getCount(f100_arg0.gridInfoTable.parentGrid) - 1)
	else
		return nil
	end
	return f100_arg0.gridInfoTable.parentGrid:getItemAtPosition(f100_local0, f100_local1, true)
end
local f0_local9 = function(f101_arg0, f101_arg1)
	f101_arg0.gridInfoTable.parentGrid:setActiveItem(f101_arg0, f101_arg1)
end
local f0_local10 = function(f102_arg0, f102_arg1, f102_arg2)
	f102_arg0[f102_arg1.id] = nil
	f102_arg1.id = f102_arg2
	f102_arg0[f102_arg1.id] = f102_arg1
end
local f0_local11 = function(f103_arg0, f103_arg1, f103_arg2, f103_arg3, f103_arg4, f103_arg5)
	local f103_local0 = (f103_arg2 - 1) * f103_arg0.requestedColumnCount + f103_arg3 - 1
	f103_arg1.isFirstItem = f0_local4
	f103_arg1.isLastItem = f0_local5
	f103_arg1.getNextItem = f0_local7
	f103_arg1.isInFirstVisibleRow = f0_local6
	f103_arg1.getPreviousItem = f0_local8
	f103_arg1.setAsActiveItem = f0_local9
	f103_arg1.gridInfoTable = {}
	f103_arg1.gridInfoTable.gridRowIndex = f103_arg2
	f103_arg1.gridInfoTable.gridColIndex = f103_arg3
	f103_arg1.gridInfoTable.gridRowSpan = f103_arg4
	f103_arg1.gridInfoTable.gridColSpan = f103_arg5
	f103_arg1.gridInfoTable.parentGrid = f103_arg0
	f103_arg1.gridInfoTable.zeroBasedIndex = f103_local0
	f0_local10(f103_arg0.itemStencil, f103_arg1, f103_arg1.id .. f103_local0)
end
LUI.GridLayout.addItemToNextAvailable = function(f104_arg0, f104_arg1, f104_arg2)
	local f104_local0 = 1
	local f104_local1 = 1
	local f104_local2 = function(f105_arg0, f105_arg1, f105_arg2)
		f0_local11(f104_arg0, f105_arg0, f105_arg1, f105_arg2, 1, 1)
		f104_arg0.layoutItems[f105_arg1][f105_arg2] = f105_arg0
		f104_arg0.itemStencil:addElement(f105_arg0)
		if f104_arg0.customWidgetSetup then
			f104_arg0:customWidgetSetup(f105_arg0)
		end
		if f104_arg2 then
			f104_arg0:updateLayout()
		end
	end
	while f104_local0 <= f104_arg0.vCount or f104_arg0.hCount == 1 do
		while f104_local1 <= f104_arg0.hCount or f104_arg0.vCount == 1 do
			if not f104_arg0.layoutItems[f104_local0] then
				f104_arg0.layoutItems[f104_local0] = {}
			end
			if not f104_arg0.layoutItems[f104_local0][f104_local1] then
				f104_local2(f104_arg1, f104_local0, f104_local1)
				return true
			end
			f104_local1 = f104_local1 + 1
		end
		f104_local1 = 1
		f104_local0 = f104_local0 + 1
	end
	while f104_local1 <= f104_arg0.hCount or f104_arg0.vCount == 1 do
		if not f104_arg0.layoutItems[f104_local0] then
			f104_arg0.layoutItems[f104_local0] = {}
		end
		if not f104_arg0.layoutItems[f104_local0][f104_local1] then
			f104_local2(f104_arg1, f104_local0, f104_local1)
			return true
		end
		f104_local1 = f104_local1 + 1
	end
	f104_local1 = 1
	f104_local0 = f104_local0 + 1
end
LUI.GridLayout.setItemAtPosition = function(f106_arg0, f106_arg1, f106_arg2, f106_arg3, f106_arg4, f106_arg5, f106_arg6, f106_arg7, f106_arg8)
	if not f106_arg7 then
		f106_arg7 = 1
	end
	if not f106_arg8 then
		f106_arg8 = 1
	end
	if 1 <= f106_arg2 and f106_arg2 + f106_arg7 - 1 <= f106_arg0.requestedRowCount and 1 <= f106_arg3 and f106_arg3 + f106_arg8 - 1 <= f106_arg0.requestedColumnCount then
		f0_local11(f106_arg0, f106_arg1, f106_arg2, f106_arg3, f106_arg7, f106_arg8)
		if f106_arg0._renderFirstItemOnTop and f106_arg0.itemStencil:getFirstChild() then
			f106_arg1:addElementBefore(f106_arg0.itemStencil:getFirstChild())
		else
			f106_arg0.itemStencil:addElement(f106_arg1)
		end
		if f106_arg0.customWidgetSetup then
			f106_arg0:customWidgetSetup(f106_arg1)
		end
		for f106_local0 = f106_arg2, f106_arg2 + f106_arg7 - 1, 1 do
			for f106_local3 = f106_arg3, f106_arg3 + f106_arg8 - 1, 1 do
				if not f106_arg0.layoutItems[f106_local0] then
					f106_arg0.layoutItems[f106_local0] = {}
				end
				f106_arg0.layoutItems[f106_local0][f106_local3] = f106_arg1
			end
		end
		f106_arg0:positionElementWithStart(f106_arg1, f106_arg5, f106_arg6)
		if f106_arg4 then
			f106_arg0:updateLayout()
		end
		return true
	else
		return false
	end
end
LUI.GridLayout.removeItem = function(f107_arg0, f107_arg1, f107_arg2)
	local f107_local0 = false
	for f107_local7, f107_local8 in pairs(f107_arg0.layoutItems) do
		for f107_local4, f107_local5 in pairs(f107_local8) do
			if f107_arg1 == f107_local5 then
				f107_local0 = true
				f107_local8[f107_local4] = nil
			end
		end
	end
	f107_arg1:close()
	if f107_local0 and f107_arg2 then
		f107_arg0:updateLayout()
	end
end
LUI.GridLayout.getLastSelectableItem = function(f108_arg0, f108_arg1)
	if f108_arg0.prepared then
		for f108_local0 = f108_arg0.requestedRowCount, 1, -1 do
			for f108_local3 = f108_arg0.requestedColumnCount, 1, -1 do
				local f108_local6 = f108_arg0:getItemAtPosition(f108_local0, f108_local3, true)
				if f108_local6 and f108_arg0:isWidgetSelectable(f108_local6) then
					if f108_arg1 then
						f108_arg0:setActiveItem(f108_local6)
					end
					return f108_local6
				end
			end
		end
	end
	return nil
end
LUI.GridLayout.giveFocusToActiveWidget = function(f109_arg0)
	if f109_arg0.activeWidget then
		f109_arg0.activeWidget:processEvent({
			name = "gain_focus",
			controller = f109_arg0.controller,
		})
	end
end
LUI.GridLayout.getFirstSelectableItem = function(f110_arg0, f110_arg1)
	if f110_arg0.prepared then
		for f110_local0 = 1, f110_arg0.requestedRowCount, 1 do
			for f110_local3 = 1, f110_arg0.requestedColumnCount, 1 do
				local f110_local6 = f110_arg0:getItemAtPosition(f110_local0, f110_local3, true)
				if f110_local6 and f110_arg0:isWidgetSelectable(f110_local6) then
					if f110_arg1 then
						f110_arg0:setActiveItem(f110_local6)
					end
					return f110_local6
				end
			end
		end
	end
	return nil
end
LUI.GridLayout.getItemAt = function(f111_arg0, f111_arg1)
	local f111_local0 = 0
	for f111_local1 = 1, f111_arg0.requestedRowCount, 1 do
		for f111_local4 = 1, f111_arg0.requestedColumnCount, 1 do
			local f111_local7 = false
			local f111_local8 = f111_arg0:getItemAtPosition(f111_local1, f111_local4, false)
			if not f111_local8 then
				f111_local7 = true
				f111_local8 = f111_arg0:getItemAtPosition(f111_local1, f111_local4, true)
			end
			if f111_local8 then
				f111_local0 = f111_local0 + 1
				if f111_local0 == f111_arg1 then
					return f111_local8
				elseif f111_local7 then
					f111_arg0:removeItem(f111_local8, false)
				end
			end
		end
	end
	return nil
end
LUI.GridLayout.clearLayout = function(f112_arg0, f112_arg1)
	f112_arg0:clearStaggeredIntro()
	for f112_local6, f112_local7 in pairs(f112_arg0.layoutItems) do
		for f112_local3, f112_local4 in pairs(f112_local7) do
			if f112_local4.gridInfoTable.gridRowIndex == f112_local6 and f112_local4.gridInfoTable.gridColIndex == f112_local3 then
				f112_local7[f112_local3]:close()
			end
			f112_local7[f112_local3] = nil
		end
	end
	f112_arg0.layoutItems = {}
	f112_arg0:resetCurrentRowAndColumn()
	f112_arg0:setActiveItem(nil, 0)
	if f112_arg1 then
		f112_arg0:updateLayout()
	end
end
LUI.GridLayout.positionElementWithStart = function(f113_arg0, f113_arg1, f113_arg2, f113_arg3)
	local f113_local0 = f113_arg1.gridInfoTable.gridRowIndex
	local f113_local1 = f113_arg1.gridInfoTable.gridColIndex
	local f113_local2 = 1
	if f113_local1 < f113_arg3 then
		f113_local2 = -1
	end
	local f113_local3 = f113_arg0.firstElementXOffset + f113_arg0.accumlatingRowXOffset * (f113_local0 - f113_arg2)
	for f113_local4 = f113_arg3, f113_local1, f113_local2 do
		if (f113_local2 == -1 or f113_local4 ~= f113_local1) and f113_arg0.__cachedSizes[f113_local0] and f113_arg0.__cachedSizes[f113_local0][f113_local4] then
			f113_local3 = f113_local3 + f113_arg0.__cachedSizes[f113_local0][f113_local4].fullWidth * f113_local2
		end
	end
	local f113_local4 = 1
	if f113_local0 < f113_arg2 then
		f113_local4 = -1
	end
	local f113_local5 = f113_arg0.firstElementYOffset + f113_arg0.accumlatingColumnYOffset * (f113_local1 - f113_arg3)
	for f113_local6 = f113_arg2, f113_local0, f113_local4 do
		if (f113_local4 == -1 or f113_local6 ~= f113_local0) and f113_arg0.__cachedSizes[f113_local6] and f113_arg0.__cachedSizes[f113_local6][f113_local1] then
			f113_local5 = f113_local5 + f113_arg0.__cachedSizes[f113_local6][f113_local1].fullHeight * f113_local2
		end
	end
	local f113_local6, f113_local7 = f0_local2(f113_arg0, f113_arg1, f113_arg0.controller)
	f113_arg1:beginAnimation("position")
	if f113_arg0.autoScaleContentWidth and f113_arg0.hCount <= 1 then
		f113_arg1:setLeftRight(0, 1, 0, 0)
	else
		f113_arg1:setLeftRight(true, false, f113_local3, f113_local3 + f113_local6)
	end
	if f113_arg0.autoScaleContentHeight and f113_arg0.vCount <= 1 then
		f113_arg1:setTopBottom(0, 1, 0, 0)
	else
		f113_arg1:setTopBottom(true, false, f113_local5, f113_local5 + f113_local7)
	end
end
LUI.GridLayout.updateLayout = function(f114_arg0, f114_arg1)
	if f114_arg0.__closing or not f114_arg0.__receivedMenuOpenedEvent or f114_arg0._layoutTimer then
		return
	elseif f114_arg0.originalListWidth == nil then
		local f114_local0, f114_local1, f114_local2, f114_local3 = f114_arg0:getLocalLeftRight()
		if f114_local0 + f114_local1 == 0 then
			f114_arg0.originalListWidth = f114_local3 - f114_local2
		elseif f114_local0 == 0 and f114_local1 == 1 then
			local f114_local4 = f114_arg0:getParent()
			if f114_local4 then
				local f114_local5, f114_local6, f114_local7, f114_local8 = f114_local4:getLocalLeftRight()
				f114_arg0.originalListWidth = f114_local8 - f114_local7 - f114_local2 + f114_local3
			end
		end
	end
	local f114_local0 = f114_arg1 or 0
	local f114_local1 = f114_arg0:getDataSource()
	if not f114_local1 then
		f114_arg0:clearLayout(false)
		return
	elseif f114_local1.prepare and not f114_arg0.prepared then
		f114_arg0:updateDataSource(true, true, false)
	end
	f114_arg0:clearStaggeredIntro()
	local f114_local2 = IsFreeCursorActiveAndVisible(f114_arg0.controller)
	if f114_local2 then
		f114_local2 = f114_arg0:IsMouseInsideElement(f114_arg0.controller)
	end
	local f114_local3 = function(f115_arg0)
		if f114_arg0.loopEdges and f114_arg0.activeWidgetInPlace then
			if f115_arg0 < 1 then
				return f115_arg0 + f114_arg0.requestedColumnCount
			elseif f114_arg0.requestedColumnCount < f115_arg0 then
				return f115_arg0 - f114_arg0.requestedColumnCount
			end
		end
		return f115_arg0
	end
	f114_arg0.__cachedSizes = {}
	local f114_local4 = function(f116_arg0, f116_arg1, f116_arg2)
		local f116_local0 = f114_local3(f116_arg2)
		if not f114_arg0.__cachedSizes[f116_arg1] then
			f114_arg0.__cachedSizes[f116_arg1] = {}
		end
		local f116_local1, f116_local2 = f0_local2(f114_arg0, f116_arg0, f114_arg0.controller)
		local f116_local3 = f114_arg0.spacing
		local f116_local4 = f114_arg0.spacing
		if f114_local1.getSpacerAfterColumn then
			f116_local3 = f116_local3 + f114_local1.getSpacerAfterColumn(f114_arg0, f116_local0, f116_local1)
		end
		if f114_local1.getSpacerAfterRow then
			f116_local4 = f116_local4 + f114_local1.getSpacerAfterRow(f114_arg0, f116_arg1, f116_local2)
		end
		f114_arg0.__cachedSizes[f116_arg1][f116_arg2] = {
			width = f116_local1,
			height = f116_local2,
			wSpacing = f116_local3,
			hSpacing = f116_local4,
			fullWidth = f116_local1 + f116_local3,
			fullHeight = f116_local2 + f116_local4,
		}
		return f116_local1 + f116_local3, f116_local2 + f116_local4
	end
	local f114_local5 = f114_arg0.currentStartRow
	local f114_local6 = f114_arg0.currentStartColumn
	if f114_arg0.firstElementYOffset > 0 then
		local f114_local7 = f114_arg0.firstElementYOffset - f114_arg0.spacing
		for f114_local8 = f114_arg0.currentStartRow - 1, 1, -1 do
			local f114_local11 = 0
			for f114_local12 = 1, f114_arg0.hCount, 1 do
				local f114_local15 = f114_arg0.currentStartColumn + f114_local12 - 1
				local f114_local16 = f114_arg0:getItemAtPosition(f114_local8, f114_local15, false)
				if not f114_local16 then
					f114_local16 = f114_arg0:createWidgetForPosition(f114_local8, f114_local15, f114_arg0.previousStartRow, f114_arg0.previousStartColumn)
				end
				if f114_local16 then
					local f114_local17, f114_local18 = f114_local4(f114_local16, f114_local8, f114_local15)
					f114_local11 = math.max(f114_local11, f114_local18)
				end
			end
			if f114_local11 == 0 then
			end
			f114_local7 = f114_local7 - f114_local11
			f114_local5 = f114_local8
			if f114_local7 <= 0 then
			end
			f114_local7 = f114_local7 - f114_arg0.spacing
		end
	end
	if f114_arg0.firstElementXOffset > 0 then
		local f114_local7 = f114_arg0.firstElementXOffset - f114_arg0.spacing
		for f114_local8 = f114_arg0.currentStartColumn - 1, 1, -1 do
			local f114_local11 = 0
			for f114_local12 = 1, f114_arg0.vCount, 1 do
				local f114_local15 = f114_arg0.currentStartRow + f114_local12 - 1
				local f114_local16 = f114_arg0:getItemAtPosition(f114_local15, f114_local8, false)
				if not f114_local16 then
					f114_local16 = f114_arg0:createWidgetForPosition(f114_local15, f114_local8, f114_arg0.previousStartRow, f114_arg0.previousStartColumn)
				end
				if f114_local16 then
					local f114_local17, f114_local18 = f114_local4(f114_local16, f114_local15, f114_local8)
					f114_local11 = math.max(f114_local11, f114_local17)
				end
			end
			if f114_local11 == 0 then
			end
			f114_local7 = f114_local7 - f114_local11
			f114_local6 = f114_local8
			if f114_local7 <= 0 then
			end
			f114_local7 = f114_local7 - f114_arg0.spacing
		end
	end
	for f114_local7 = f114_local5, math.min(f114_arg0.requestedRowCount, f114_local5 + f114_arg0.vCount - 1), 1 do
		if not f114_arg0.layoutItems[f114_local7] then
			f114_arg0.layoutItems[f114_local7] = {}
		end
		local f114_local19 = f114_arg0.layoutItems[f114_local7]
		local f114_local11 = f114_arg0.requestedColumnCount
		if f114_arg0.loopEdges then
			local f114_local20 = f114_arg0.activeWidgetInPlace
			local f114_local21 = (f114_arg0.hCount - 1) / 2
		end
		f114_local11 = f114_local11 + (f114_local20 and f114_local21 or 0)
		for f114_local12 = f114_local6, math.min(f114_local11, f114_local6 + f114_arg0.hCount - 1), 1 do
			local f114_local15 = f114_local12
			local f114_local22 = f114_local3(f114_local12)
			if f114_arg0.rowColumnIndexMap[f114_local7] and f114_arg0.rowColumnIndexMap[f114_local7][f114_local22] then
				if not f114_local19[f114_local15] then
					local f114_local16 = f114_local19[f114_local22]
					local f114_local17 = f114_arg0:createWidgetForPosition(f114_local7, f114_local22, f114_arg0.previousStartRow, f114_arg0.previousStartColumn)
					if f114_local17 then
						if f114_local15 ~= f114_local22 then
							local f114_local18 = f114_local19[f114_local22]
							f114_local19[f114_local22] = f114_local16
							f114_local19[f114_local15] = f114_local18
						end
						f114_local4(f114_local17, f114_local7, f114_local15)
					end
				end
				local f114_local16 = f114_arg0:getModelForPosition(f114_local7, f114_local22)
				if f114_local16 and f114_local16.skipGridLayoutModelUpdate == nil then
					f114_local19[f114_local15]:setModel(f114_local16, f114_arg0.controller)
					if f114_local19[f114_local15] == f114_arg0.activeWidget then
						f114_arg0:setModel(f114_local16, f114_arg0.controller)
					end
				end
				f114_arg0:updateCustomWidgetProperties(f114_local7, f114_local22, f114_local19[f114_local15])
				f114_local4(f114_local19[f114_local15], f114_local7, f114_local15)
			end
		end
	end
	local f114_local7 = function(f117_arg0)
		local f117_local0 = nil
		for f117_local4, f117_local5 in pairs(f117_arg0) do
			if not f117_local0 then
				f117_local0 = f117_local4
			else
				f117_local0 = math.max(f117_local0, f117_local4)
			end
		end
		return f117_local0
	end
	local f114_local8 = -1
	for f114_local11, f114_local12 in pairs(f114_arg0.__cachedSizes) do
		f114_local8 = math.max(f114_local8, f114_local11)
		local f114_local13 = f114_local7(f114_local12)
		if f114_local13 then
			f114_local12[f114_local13].fullWidth = f114_local12[f114_local13].fullWidth - f114_local12[f114_local13].wSpacing
			f114_local12[f114_local13].wSpacing = 0
		end
	end
	if f114_arg0.__cachedSizes[f114_local8] then
		for f114_local11, f114_local12 in pairs(f114_arg0.__cachedSizes[f114_local8]) do
			f114_local12.fullHeight = f114_local12.fullHeight - f114_local12.hSpacing
			f114_local12.hSpacing = 0
		end
	end
	f114_local9 = {}
	f114_local10 = {}
	f114_local19 = {}
	f114_local11 = {}
	f114_local12 = 0
	local f114_local13 = 0
	for f114_local16, f114_local17 in pairs(f114_arg0.__cachedSizes) do
		f114_local9[f114_local16] = 0
		f114_local10[f114_local16] = 0
		f114_local12 = math.max(f114_local12, f114_local16)
		for f114_local23, f114_local24 in pairs(f114_local17) do
			f114_local13 = math.max(f114_local13, f114_local23)
			if not f114_local19[f114_local23] then
				f114_local19[f114_local23] = 0
				f114_local11[f114_local23] = 0
			end
			f114_local9[f114_local16] = math.max(f114_local9[f114_local16], f114_local24.fullHeight)
			f114_local10[f114_local16] = f114_local10[f114_local16] + f114_local24.fullWidth
			f114_local19[f114_local23] = f114_local19[f114_local23] + f114_local24.fullHeight
			f114_local11[f114_local23] = math.max(f114_local11[f114_local23], f114_local24.fullWidth)
		end
	end
	f114_local14 = 0
	f114_local22 = 0
	if f114_arg0.doNotResizeOnUpdateLayout then
		local f114_local15, f114_local16, f114_local17, f114_local18 = f114_arg0:getLocalRect()
		f114_local14 = f114_local17 - f114_local15
		f114_local22 = f114_local18 - f114_local16
	else
		f114_local15, f114_local16 = nil
		for f114_local17 = 1, math.min(f114_arg0.hCount, f114_arg0.requestedColumnCount), 1 do
			if f114_local11[f114_arg0.currentStartColumn + f114_local17 - 1] then
				f114_local15 = f114_arg0.currentStartColumn + f114_local17 - 1
				f114_local14 = f114_local14 + f114_local11[f114_arg0.currentStartColumn + f114_local17 - 1]
			end
		end
		for f114_local17 = 1, math.min(f114_arg0.vCount, f114_arg0.requestedRowCount), 1 do
			if f114_local9[f114_arg0.currentStartRow + f114_local17 - 1] then
				f114_local16 = f114_arg0.currentStartRow + f114_local17 - 1
				f114_local22 = f114_local22 + f114_local9[f114_arg0.currentStartRow + f114_local17 - 1]
			end
		end
		if f114_local15 then
			f114_local17 = 0
			for f114_local23, f114_local24 in pairs(f114_arg0.__cachedSizes) do
				if f114_local24[f114_local15] then
					f114_local17 = math.max(f114_local17, f114_local24[f114_local15].wSpacing)
				end
			end
			f114_local14 = f114_local14 - f114_local17
		end
		if f114_local16 then
			f114_local17 = 0
			for f114_local23, f114_local24 in pairs(f114_arg0.__cachedSizes[f114_local16]) do
				f114_local17 = math.max(f114_local17, f114_local24.hSpacing)
			end
			f114_local22 = f114_local22 - f114_local17
		end
		f114_local14 = math.max(f114_local14, 0)
		f114_local22 = math.max(f114_local22, 0)
	end
	f114_local15 = f114_arg0:getAlignment()
	f114_local16 = f114_arg0.lastFirstVisibleRow or f114_arg0.currentStartRow
	f114_local17 = f114_arg0.lastFirstVisibleColumn or f114_arg0.currentStartColumn
	local f114_local18 = function(f118_arg0, f118_arg1, f118_arg2)
		local f118_local0 = f114_arg0.firstElementXOffset + f114_arg0.accumlatingRowXOffset * (f118_arg1 - f114_arg0.currentStartRow)
		local f118_local1 = f114_arg0.firstElementYOffset + f114_arg0.accumlatingColumnYOffset * (f118_arg2 - f114_arg0.currentStartColumn)
		if f114_arg0.currentStartColumn < f118_arg2 then
			for f118_local2 = f114_arg0.currentStartColumn, f118_arg2 - 1, 1 do
				f118_local0 = f118_local0 + (f114_local11[f118_local2] or 0)
			end
		elseif f118_arg2 < f114_arg0.currentStartColumn then
			for f118_local2 = f118_arg2, f114_arg0.currentStartColumn - 1, 1 do
				f118_local0 = f118_local0 - (f114_local11[f118_local2] or 0)
			end
		end
		if f114_arg0.currentStartRow < f118_arg1 then
			for f118_local2 = f114_arg0.currentStartRow, f118_arg1 - 1, 1 do
				f118_local1 = f118_local1 + (f114_local9[f118_local2] or 0)
			end
		elseif f118_arg1 < f114_arg0.currentStartRow then
			for f118_local2 = f118_arg1, f114_arg0.currentStartRow - 1, 1 do
				f118_local1 = f118_local1 - (f114_local9[f118_local2] or 0)
			end
		end
		if f114_local15 & Enum[@"luialignment"][@"lui_alignment_center"] ~= 0 then
			f118_local0 = f118_local0 + (f114_local14 - f114_local10[f118_arg1]) / 2
		elseif f114_local15 & Enum[@"luialignment"][@"lui_alignment_right"] ~= 0 then
			f118_local0 = f118_local0 + f114_local14 - f114_local10[f118_arg1]
		end
		return f118_local0, f118_local1
	end
	local f114_local26 = function(f119_arg0, f119_arg1, f119_arg2, f119_arg3, f119_arg4)
		if not f119_arg1 or not f119_arg2 then
			return false
		elseif not f114_local9[f119_arg3] or not f114_local11[f119_arg4] then
			return false
		end
		local f119_local0 = f114_arg0.requestedColumnCount
		if f114_arg0.loopEdges then
			local f119_local1 = f114_arg0.activeWidgetInPlace
			local f119_local2 = (f114_arg0.hCount - 1) / 2
		end
		if f119_arg1 <= f0_local0(f119_arg0) and f119_arg3 < f119_arg1 + math.min(f114_arg0.vCount, f114_arg0.requestedRowCount) and f119_arg2 <= f119_arg4 + f119_arg0.gridInfoTable.gridColSpan - 1 and f119_arg4 < f119_arg2 + math.min(f114_arg0.hCount, f119_local0 + (f119_local1 and f119_local2 or 0)) then
			return true
		elseif f119_arg1 + math.min(f114_arg0.vCount, f114_arg0.requestedRowCount) <= f119_arg3 or f119_arg2 + math.min(f114_arg0.hCount, f114_arg0.requestedColumnCount) <= f119_arg4 then
			return false
		elseif f114_arg0.firstElementXOffset > 0 or f114_arg0.firstElementYOffset > 0 then
			local f119_local3, f119_local4 = f114_local18(f119_arg0, f119_arg3, f119_arg4)
			if f119_local3 + f114_arg0.__cachedSizes[f119_arg3][f119_arg4].width > 0 and f119_local4 + f114_arg0.__cachedSizes[f119_arg3][f119_arg4].height > 0 then
				return true
			end
		end
		return false
	end
	local f114_local25 = {}
	local f114_local23 = function(f120_arg0, f120_arg1, f120_arg2, f120_arg3, f120_arg4, f120_arg5, f120_arg6)
		f120_arg0:beginAnimation("keyframe", f114_local0)
		if f120_arg5 ~= nil then
			f120_arg0:setAlpha(f120_arg5)
		end
		if f114_arg0.autoScaleContentWidth and f114_arg0.hCount <= 1 then
			f120_arg0:setLeftRight(0, 1, 0, 0)
		else
			f120_arg0:setLeftRight(true, false, f120_arg1, f120_arg1 + f120_arg3)
		end
		if f114_arg0.autoScaleContentHeight and f114_arg0.vCount <= 1 then
			f120_arg0:setTopBottom(0, 1, 0, 0)
		else
			f120_arg0:setTopBottom(true, false, f120_arg2, f120_arg2 + f120_arg4)
		end
		if f120_arg6 then
			f120_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
				f114_arg0:removeItem(element)
			end)
		else
			f120_arg0:registerEventHandler("transition_complete_keyframe", nil)
		end
	end
	local f114_local24 = 0
	for f114_local38, f114_local39 in LUI.IterateTableBySortedKeys(f114_arg0.layoutItems) do
		for f114_local35, f114_local36 in LUI.IterateTableBySortedKeys(f114_local39) do
			if f114_local36.gridInfoTable.gridRowIndex == f114_local38 and f114_local36.gridInfoTable.gridColIndex == f114_local3(f114_local35) then
				local f114_local30 = 0
				local f114_local31 = 0
				if f114_arg0.__cachedSizes[f114_local38] and f114_arg0.__cachedSizes[f114_local38][f114_local35] then
					f114_local30 = f114_arg0.__cachedSizes[f114_local38][f114_local35].width
					f114_local31 = f114_arg0.__cachedSizes[f114_local38][f114_local35].height
				end
				local f114_local32 = 0
				if f114_arg0.usingStencil then
					f114_local32 = 1
				end
				if f114_arg0.itemCount <= f114_local24 then
					table.insert(f114_local25, f114_local36)
				elseif f114_local26(f114_local36, f114_local5, f114_local6, f114_local38, f114_local35) then
					local f114_local33, f114_local34 = f114_local18(f114_local36, f114_local38, f114_local35)
					f114_local23(f114_local36, f114_local33, f114_local34, f114_local30, f114_local31, 1)
				elseif f114_local26(f114_local36, f114_local16, f114_local17, f114_local38, f114_local35) then
					if f114_local0 == 0 then
						table.insert(f114_local25, f114_local36)
					else
						local f114_local33, f114_local34 = f114_local18(f114_local36, f114_local38, f114_local35)
						f114_local23(f114_local36, f114_local33, f114_local34, f114_local30, f114_local31, f114_local32, true)
					end
				else
					table.insert(f114_local25, f114_local36)
				end
				f114_local24 = f114_local24 + 1
			end
		end
	end
	f114_local27 = function(f122_arg0, f122_arg1)
		for f122_local3, f122_local4 in pairs(f122_arg1) do
			if LuaUtils.GetTableKeyForElement(f122_local4, f122_arg0) then
				return true
			end
		end
		return false
	end
	f114_local28 = f114_arg0.itemStencil:getFirstChild()
	while f114_local28 do
		if not LuaUtils.GetTableKeyForElement(f114_local25, f114_local28) and not f114_local27(f114_local28, f114_arg0.layoutItems) then
			error("list/grid was updated recursively and the values changed")
		end
		f114_local28 = f114_local28:getNextSibling()
	end
	f114_local29 = false
	for f114_local41, f114_local37 in ipairs(f114_local25) do
		f114_arg0:removeItem(f114_local37)
	end
	if not f114_arg0.scrollbarDragging then
		f114_arg0.itemStencil:beginAnimation("update_size", f114_local0)
		if f114_arg0.autoScaleContentWidth and f114_arg0.hCount <= 1 then
			f114_arg0.itemStencil:setLeftRight(0, 1, 0, 0)
		else
			f114_arg0.itemStencil:setWidth(f114_local14)
			f114_arg0:setWidth(f114_local14)
		end
		if f114_arg0.autoScaleContentHeight and f114_arg0.vCount <= 1 then
			f114_arg0.itemStencil:setTopBottom(0, 1, 0, 0)
		else
			f114_arg0.itemStencil:setHeight(f114_local22)
			f114_arg0:setHeight(f114_local22)
		end
	end
	f114_arg0.width = f114_local14
	f114_arg0.height = f114_local22
	f114_arg0.lastFirstVisibleRow = f114_local5
	f114_arg0.lastFirstVisibleColumn = f114_local6
	f114_arg0:updateScrollbars()
	if f114_local2 or IsFreeCursorActiveAndVisible(f114_arg0.controller) and f114_arg0:IsMouseInsideElement(f114_arg0.controller) then
		CoD.FreeCursorUtility.RetriggerCursorPosition(f114_arg0.menu, f114_arg0.controller)
	end
end
LUI.GridLayout.createWidget = function(f123_arg0, f123_arg1, f123_arg2)
	if not f123_arg2 then
		return
	end
	local f123_local0 = f123_arg2.new(f123_arg0.menu, f123_arg1, 0, 0, 0, f123_arg2.__defaultWidth or 0, 0, 0, 0, f123_arg2.__defaultHeight or 0)
	if not f123_local0 then
		return
	elseif f123_arg2 == f123_arg0.widgetType then
		f123_local0:mergeStateConditions(f123_arg0.elementStateConditions)
	end
	f123_arg0.itemStencil[f123_local0.id] = f123_local0
	LUI.OverrideFunction_CallOriginalFirst(f123_local0, "close", function()
		local f124_local0 = LuaUtils.FindItemInArray(f123_arg0.__staggeredElementsPlayingClips, f123_local0)
		if f124_local0 then
			table.remove(f123_arg0.__staggeredElementsPlayingClips, f124_local0)
		end
		f123_arg0.itemStencil[f123_local0.id] = nil
	end)
	return f123_local0
end
LUI.GridLayout.getModelForIndex = function(f125_arg0, f125_arg1)
	local f125_local0 = f125_arg0:getDataSource()
	if not f125_arg0.prepared or not f125_local0 or not f125_local0.getCount then
		return nil
	elseif f125_arg1 and f125_arg1 <= f125_local0.getCount(f125_arg0) then
		return f125_local0.getItem(f125_arg0.controller, f125_arg0, f125_arg1)
	else
		return nil
	end
end
LUI.GridLayout.getModelForPosition = function(f126_arg0, f126_arg1, f126_arg2)
	return f126_arg0:getModelForIndex(f126_arg0:GetTableIndexForPosition(f126_arg1, f126_arg2))
end
LUI.GridLayout.getPropertiesForIndex = function(f127_arg0, f127_arg1)
	local f127_local0 = f127_arg0:getDataSource()
	if not f127_local0 or not f127_local0.getCount or not f127_local0.getCustomPropertiesForItem then
		return nil
	elseif f127_arg1 <= f127_local0.getCount(f127_arg0) then
		return f127_local0.getCustomPropertiesForItem(f127_arg0, f127_arg1)
	else
		return nil
	end
end
LUI.GridLayout.getPropertiesForPosition = function(f128_arg0, f128_arg1, f128_arg2)
	return f128_arg0:getPropertiesForIndex(f128_arg0:GetTableIndexForPosition(f128_arg1, f128_arg2))
end
LUI.GridLayout.updateCustomWidgetProperties = function(f129_arg0, f129_arg1, f129_arg2, f129_arg3)
	if not f129_arg3 then
		return
	elseif f129_arg3.gridInfoTable.customProperties then
		for f129_local3, f129_local4 in ipairs(f129_arg3.gridInfoTable.customProperties) do
			f129_arg3[f129_local4] = nil
		end
	end
	local f129_local0 = f129_arg0:getPropertiesForPosition(f129_arg1, f129_arg2)
	if f129_local0 then
		f129_arg3.gridInfoTable.customProperties = {}
		for f129_local4, f129_local5 in pairs(f129_local0) do
			if f129_local4 == "id" then
				f0_local10(f129_arg0.itemStencil, f129_arg3, f129_local5)
			else
				f129_arg3[f129_local4] = f129_local5
			end
		end
	end
end
LUI.GridLayout.getWidgetForIndex = function(f130_arg0, f130_arg1)
	local f130_local0 = f130_arg0:getDataSource()
	if not f130_arg0.prepared or not f130_local0 or not f130_local0.getCount then
		return nil
	end
	if f130_arg1 and f130_arg1 <= f130_local0.getCount(f130_arg0) then
		local f130_local1 = nil
		local f130_local2 = f130_arg0:getPropertiesForIndex(f130_arg1)
		if f130_local2 and f130_local2.customWidgetOverride then
			f130_local1 = f130_local2.customWidgetOverride
		elseif f130_local0.getWidgetTypeForItem then
			f130_local1 = f130_local0.getWidgetTypeForItem(f130_arg0, f130_arg0:getModelForIndex(f130_arg1), f130_arg1)
		end
		if type(f130_local1) == "string" then
			f130_local1 = LUI.getTableFromPath(f130_local1)
		elseif type(f130_local1) == "function" then
			f130_local1 = f130_local1(f130_arg0, f130_arg1)
		end
		if f130_local1 and f130_local1.new then
			return f130_local1
		elseif not f130_arg0.widgetType then
			return nil
		elseif type(f130_arg0.widgetType) == "string" then
			if CoD[f130_arg0.widgetType] then
				return CoD[f130_arg0.widgetType]
			end
			local f130_local3 = Engine[@"getmodel"](f130_arg0:getModelForIndex(f130_arg1), f130_arg0.widgetTypeDataSource)
			if f130_local3 ~= nil then
				return LUI.getTableFromPath(Engine[@"getmodelvalue"](f130_local3))
			end
		elseif type(f130_arg0.widgetType) == "table" then
			return f130_arg0.widgetType
		end
	end
	return nil
end
LUI.GridLayout.getWidgetTableForPosition = function(f131_arg0, f131_arg1, f131_arg2)
	return LUI.GridLayout.getWidgetForIndex(f131_arg0, f131_arg0:GetTableIndexForPosition(f131_arg1, f131_arg2))
end
LUI.GridLayout.createWidgetForPosition = function(f132_arg0, f132_arg1, f132_arg2, f132_arg3, f132_arg4)
	local f132_local0 = f132_arg0:getDataSource()
	if not f132_arg0.prepared or not f132_local0 or not f132_local0.getCount then
		return nil
	end
	local f132_local1 = f132_local0.getCount(f132_arg0)
	local f132_local2 = f132_arg0:GetTableIndexForPosition(f132_arg1, f132_arg2)
	if f132_local2 and f132_local2 <= f132_local1 then
		local f132_local3 = f132_arg0:getModelForIndex(f132_local2)
		local f132_local4 = f132_arg0:getWidgetTableForPosition(f132_arg1, f132_arg2)
		local f132_local5 = f132_arg0:getPropertiesForIndex(f132_local2)
		local f132_local6 = f132_arg0:createWidget(f132_arg0.controller, f132_local4)
		if f132_local6 ~= nil then
			if not f132_arg0.rowColumnIndexMap[f132_arg1] then
				f132_local6:close()
				return
			else
				local f132_local7
				if f132_local5 then
					f132_local7 = f132_local5.rowSpan
					if not f132_local7 then
					else
						local f132_local8
						if f132_local5 then
							f132_local8 = f132_local5.columnSpan
							if not f132_local8 then
							else
								if not f132_arg0:setItemAtPosition(f132_local6, f132_arg0.rowColumnIndexMap[f132_arg1][f132_arg2].startRow, f132_arg0.rowColumnIndexMap[f132_arg1][f132_arg2].startColumn, false, f132_arg3, f132_arg4, f132_local7, f132_local8) then
									f132_local6:close()
									return nil
								end
								f132_arg0:updateCustomWidgetProperties(f132_arg1, f132_arg2, f132_local6)
								if f132_local3 then
									f132_local6:setModel(f132_local3, f132_arg0.controller, true)
								end
								if f132_local3 then
									local f132_local9 = Engine[@"getmodel"](f132_local3, "customId")
									if f132_local9 then
										f0_local10(f132_arg0.itemStencil, f132_local6, Engine[@"getmodelvalue"](f132_local9))
									end
								end
								f132_arg0.menu:sendInitializationEvents(f132_arg0.controller, f132_local6)
								return f132_local6
							end
						end
						f132_local8 = 1
					end
				end
			end
			f132_local7 = 1
		end
	end
	return nil
end
LUI.GridLayout.MakeStencilAutoScaleWidth = function(f133_arg0)
	if f133_arg0.itemStencil then
		f133_arg0.itemStencil:setLeftRight(0, 1, 0, 0)
	end
end
LUI.GridLayout.updateDataSource = function(f134_arg0, f134_arg1, f134_arg2, f134_arg3)
	f134_arg0.itemCount = 0
	local f134_local0 = f134_arg0.rowColumnIndexMap
	f134_arg0.rowColumnIndexMap = {}
	if not f134_arg0.__receivedMenuOpenedEvent then
		return
	end
	local f134_local1 = f134_arg0:getDataSource()
	if not f134_local1 or not f134_local1.getCount or not f134_local1.getItem then
		return
	elseif not f134_arg0.widgetType then
		return
	elseif f134_local1.prepare and (not f134_arg0.prepared or not f134_arg3) then
		f134_arg0.prepared = false
		f134_local1.prepare(f134_arg0.controller, f134_arg0, f134_arg0.filter)
		f134_arg0.prepared = true
	end
	if f134_arg0.hCount > 1 and f134_arg0.vCount > 1 then
		f134_arg0.itemCount = f134_local1.getCount(f134_arg0)
		f134_arg0.requestedRowCount = 1
		f134_arg0.requestedColumnCount = 0
	elseif f134_arg0.vCount > 1 then
		f134_arg0.itemCount = f134_local1.getCount(f134_arg0)
		f134_arg0.requestedRowCount = 0
		f134_arg0.requestedColumnCount = 1
	elseif f134_arg0.hCount >= 1 then
		f134_arg0.itemCount = f134_local1.getCount(f134_arg0)
		f134_arg0.requestedRowCount = 1
		f134_arg0.requestedColumnCount = 0
	else
		return
	end
	local f134_local2, f134_local3, f134_local4 = nil
	local f134_local5 = 1
	local f134_local6 = 1
	local f134_local7 = function(f135_arg0, f135_arg1, f135_arg2, f135_arg3, f135_arg4)
		local f135_local0 = f134_arg0:getWidgetForIndex(f135_arg0)
		local f135_local1 = {
			index = f135_arg0,
			startRow = f135_arg1,
			startColumn = f135_arg2,
			widgetType = f135_local0,
			rowSpan = f135_arg3,
			columnSpan = f135_arg4,
		}
		for f135_local2 = f135_arg1, f135_arg1 + f135_arg3 - 1, 1 do
			if not f134_arg0.rowColumnIndexMap[f135_local2] then
				f134_arg0.rowColumnIndexMap[f135_local2] = {}
			end
			for f135_local5 = f135_arg2, f135_arg2 + f135_arg4 - 1, 1 do
				if f134_local0 and f134_local0[f135_local2] then
					local f135_local8 = f134_local0[f135_local2][f135_local5]
					if f135_local8 and not f135_local8._previouslyClosed and (f135_local8.startRow ~= f135_arg1 or f135_local8.startColumn ~= f135_arg2 or f135_local8.widgetType ~= f135_local0 or f135_local8.rowSpan ~= f135_arg3 or f135_local8.columnSpan ~= f135_arg4) then
						f135_local8._previouslyClosed = true
						for f135_local9 = f135_local8.startRow, f135_local8.startRow + f135_local8.rowSpan - 1, 1 do
							for f135_local12 = f135_local8.startColumn, f135_local8.startColumn + f135_local8.columnSpan - 1, 1 do
								if f134_arg0.layoutItems[f135_local9] and f134_arg0.layoutItems[f135_local9][f135_local12] then
									f134_arg0.layoutItems[f135_local9][f135_local12]:close()
									f134_arg0.layoutItems[f135_local9][f135_local12] = nil
								end
							end
						end
					end
				end
				f134_arg0.rowColumnIndexMap[f135_local2][f135_local5] = f135_local1
			end
		end
	end
	for f134_local8 = 1, f134_arg0.itemCount, 1 do
		local f134_local11 = f134_arg0:getPropertiesForIndex(f134_local8)
		local f134_local12 = 1
		local f134_local13 = 1
		local f134_local14 = false
		if f134_local11 then
			if not f134_local3 and f134_local11.selectIndex then
				f134_local11.selectIndex = f134_arg0.persistSelectedIndex
				f134_local3 = f134_local5
				f134_local4 = f134_local6
				f134_local14 = true
			end
			f134_local12 = f134_local11.rowSpan or 1
			f134_local13 = f134_local11.columnSpan or 1
		end
		if f134_arg0.hCount > 1 and f134_arg0.vCount > 1 then
			if f134_arg0.__balanceGridRows and f134_arg0.itemCount <= f134_arg0.hCount * f134_arg0.vCount then
				local f134_local15, f134_local16 = math.modf(f134_arg0.itemCount / f134_arg0.vCount)
				local f134_local17
				if f134_local5 <= f134_local16 * f134_arg0.vCount then
					f134_local17 = 1
					if not f134_local17 then
					elseif f134_local15 + f134_local17 < f134_local6 + f134_local13 - 1 then
						f134_local5 = f134_local5 + 1
						if f134_arg0.rowColumnIndexMap[f134_local5] then
							local f134_local18 = #f134_arg0.rowColumnIndexMap[f134_local5] + 1
						end
						f134_local6 = f134_local18 or 1
					end
				end
				f134_local17 = 0
			elseif f134_arg0.hCount < f134_local6 + f134_local13 - 1 then
				f134_local5 = f134_local5 + 1
				if f134_arg0.rowColumnIndexMap[f134_local5] then
					local f134_local19 = #f134_arg0.rowColumnIndexMap[f134_local5] + 1
				end
				f134_local6 = f134_local19 or 1
				if f134_arg0.hCount < f134_local6 then
					f134_local6 = 1
				end
			end
			if f134_local14 then
				f134_local3 = f134_local5
				f134_local4 = f134_local6
			end
			f134_local7(f134_local8, f134_local5, f134_local6, f134_local12, f134_local13)
			f134_local6 = f134_local6 + f134_local13
			f134_arg0.requestedColumnCount = math.max(f134_arg0.requestedColumnCount, f134_local6 - 1)
			f134_arg0.requestedRowCount = math.max(f134_arg0.requestedRowCount, f134_local5 + f134_local12 - 1)
		end
		if f134_arg0.vCount > 1 then
			f134_local7(f134_local8, f134_local5, f134_local6, f134_local12, f134_local13)
			f134_local5 = f134_local5 + f134_local12
			f134_arg0.requestedRowCount = f134_local5 - 1
		end
		if f134_arg0.hCount >= 1 then
			f134_local7(f134_local8, f134_local5, f134_local6, f134_local12, f134_local13)
			f134_local6 = f134_local6 + f134_local13
			f134_arg0.requestedColumnCount = f134_local6 - 1
		end
	end
	f134_arg0:updateLayout()
	if f134_local3 then
		f134_local2 = f134_arg0:getItemAtPosition(f134_local3, f134_local4, true)
		if f134_local2 and not f134_arg0:isWidgetSelectable(f134_local2) then
			f134_local2 = nil
		end
	end
	if f134_arg0.savedActiveIndex and f134_arg0.itemCount and f134_arg0.itemCount > 0 then
		f134_arg0.savedActiveIndex = math.min(f134_arg0.savedActiveIndex, f134_arg0.itemCount - 1)
	end
	if not f134_local2 and f134_arg0.savedActiveIndex and not f134_arg1 then
		local f134_local8, f134_local9 = f134_arg0:getRowAndColumnForIndex(f134_arg0.savedActiveIndex)
		f134_local2 = f134_arg0:getItemAtPosition(f134_local8, f134_local9, true)
		if f134_local2 and not f134_arg0:isWidgetSelectable(f134_local2) then
			f134_local2 = nil
		end
	end
	if not f134_local2 and (f134_arg0.hasListFocus or f134_arg0.setActiveOnUpdate) and not f134_arg1 then
		if f134_arg0.savedActiveIndex and f134_arg0.itemCount <= f134_arg0.savedActiveIndex and f134_arg0.__selectFromEndIfLastElementRemoved then
			f134_local2 = f134_arg0:getLastSelectableItem()
		else
			f134_local2 = f134_arg0:getFirstSelectableItem()
		end
	end
	if not f134_local2 and not f134_arg0.activeWidget and f134_arg0.linkedElementModels then
		f134_local2 = f134_arg0:getFirstSelectableItem()
	end
	if f134_local2 then
		f134_local8 = nil
		if f134_local3 ~= nil then
			f134_local8 = 0
		end
		if not f134_arg0.__ignoreSelectionWidget then
			f134_arg0:setActiveItem(f134_local2, f134_local8)
		end
	else
		f134_arg0:updateScrollbars()
		f134_arg0:updateCounters()
		if f134_arg0.itemCount == 0 then
			f134_arg0:setActiveItem(nil, 0)
		end
	end
	f134_arg0:dispatchEventToParent({
		name = "grid_updated",
		grid = f134_arg0,
		controller = f134_arg0.controller,
	})
	return true
end
LUI.GridLayout.close = function(f136_arg0)
	f136_arg0.__closing = true
	f136_arg0:unsubscribeFromAllModels()
	f136_arg0:clearLayout(false)
	f136_arg0:removeDataSourceLink()
	f136_arg0.menu:removeMenuOpenedCallback(f136_arg0._on_menuOpened)
	LUI.GridLayout.super.close(f136_arg0)
	if f136_arg0.verticalScrollbar then
		f136_arg0.verticalScrollbar:close()
		f136_arg0.verticalScrollbar = nil
	end
	if f136_arg0.verticalCounter then
		f136_arg0.verticalCounter:close()
		f136_arg0.verticalCounter = nil
	end
	if f136_arg0.horizontalScrollbar then
		f136_arg0.horizontalScrollbar:close()
		f136_arg0.horizontalScrollbar = nil
	end
	if f136_arg0.horizontalCounter then
		f136_arg0.horizontalCounter:close()
		f136_arg0.horizontalCounter = nil
	end
	if f136_arg0.horizontalPips then
		f136_arg0.horizontalPips:close()
		f136_arg0.horizontalPips = nil
	end
	f136_arg0:removeCurrentBackingWidget()
end
LUI.GridLayout.updateState = function(f137_arg0, f137_arg1)
	if not f137_arg0.__closing then
		LUI.GridLayout.super.updateState(f137_arg0, f137_arg1)
		f137_arg0:updateLayout(0)
	end
end
LUI.GridLayout:registerEventHandler("update_state", LUI.GridLayout.updateState)
LUI.GridLayout.menuLoaded = function(f138_arg0, f138_arg1)
	f138_arg0.__receivedMenuLoadedEvent = true
	f138_arg0:dispatchEventToChildren(f138_arg1)
	if f138_arg0.backingWidget and f138_arg0.__focusableBackingWidget then
		f138_arg0[f138_arg0.backingWidget.id] = f138_arg0.backingWidget
		f138_arg0.backingWidget:processEvent({
			name = "update_state",
			controller = f138_arg1.controller,
			menu = f138_arg1.menu,
			initialSetup = true,
		})
	end
end
LUI.GridLayout:registerEventHandler("menu_loaded", LUI.GridLayout.menuLoaded)
LUI.GridLayout.menuOpened = function(f139_arg0, f139_arg1, f139_arg2, f139_arg3)
	if not f139_arg0.__receivedMenuOpenedEvent then
		f139_arg0.__receivedMenuOpenedEvent = true
		f139_arg0:updateDataSource()
		f139_arg0:playStaggeredIntro()
	end
end
LUI.GridLayout.clearStaggeredIntro = function(f140_arg0)
	if f140_arg0.__playingStaggeredIntroTimer then
		f140_arg0.__playingStaggeredIntroTimer:close()
		f140_arg0.__playingStaggeredIntroTimer = nil
	end
	for f140_local3, f140_local4 in ipairs(f140_arg0.__staggeredElementsPlayingClips) do
		f140_local4:updateFocusabilityFromState(f140_arg0.controller)
	end
	f140_arg0.__staggeredElementsPlayingClips = {}
end
LUI.GridLayout.playStaggeredIntro = function(f141_arg0)
	f141_arg0:clearStaggeredIntro()
	for f141_local3, f141_local4, f141_local5 in f141_arg0:forEachElement() do
		if f141_local5:hasClip("StaggeredIntro") then
			f141_local5:makeNotFocusable(f141_arg0.controller)
			f141_local5:setAlpha(0)
			table.insert(f141_arg0.__staggeredElementsPlayingClips, f141_local5)
			f141_local5:appendEventHandler("clip_over", function()
				if f141_local5.__staggeringIntro then
					f141_local5:updateFocusabilityFromState(f141_arg0.controller)
					f141_local5.__staggeringIntro = false
				end
			end)
		end
	end
	f141_local0 = function(f143_arg0)
		if f143_arg0:hasClip("StaggeredIntro") then
			f143_arg0:setAlpha(1)
			f143_arg0.__staggeringIntro = true
			if f141_arg0.activeWidget == f143_arg0 and f143_arg0:hasClip("StaggeredIntroActive") then
				f143_arg0:playClip("StaggeredIntroActive")
			else
				f143_arg0:playClip("StaggeredIntro")
			end
		end
	end
	if #f141_arg0.__staggeredElementsPlayingClips > 0 then
		if f141_arg0.__staggeredIntroTimeDelay <= 0 then
			for f141_local4, f141_local5 in ipairs(f141_arg0.__staggeredElementsPlayingClips) do
				f141_local0(f141_local5)
			end
			f141_arg0.__staggeredElementsPlayingClips = {}
		else
			f141_arg0.__playingStaggeredIntroTimer = LUI.UITimer.newElementTimer(f141_arg0.__staggeredIntroTimeDelay, false, function()
				local f144_local0 = nil
				f144_local0 = table.remove(f141_arg0.__staggeredElementsPlayingClips, 1)
				while f144_local0:hasClip("StaggeredIntro") or #f141_arg0.__staggeredElementsPlayingClips == 0 do
					f141_local0(f144_local0)
					if #f141_arg0.__staggeredElementsPlayingClips == 0 then
						f141_arg0:clearStaggeredIntro()
						return
					else
					end
				end
				f141_local0(f144_local0)
				if #f141_arg0.__staggeredElementsPlayingClips == 0 then
					f141_arg0:clearStaggeredIntro()
					return
				else
				end
			end)
			f141_arg0:addElement(f141_arg0.__playingStaggeredIntroTimer)
		end
	end
end
LUI.GridLayout.setActiveOnUpdate = true
LUI.GridLayout.id = "LUIGridLayout"
