LUI.WheelLayout = InheritFrom(LUI.UIElement)
LUI.WheelLayout.__trackedLists = {}
LUI.WheelLayout.new = function(f1_arg0, f1_arg1, f1_arg2)
	local self = LUI.UIElement.new()
	self:setClass(LUI.WheelLayout)
	self.itemStencil = LUI.UIElement.new(0, 1, 0, 0, 0, 1, 0, 0)
	self.itemStencil.anyChildUsesUpdateState = true
	self.itemStencil.id = "itemStencil"
	self:addElement(self.itemStencil)
	self.menu = f1_arg0
	self.elementStateConditions = {}
	self.filter = f1_arg2
	self.Count = 1
	self.controller = f1_arg1
	self.itemCount = 0
	self.layoutItems = {}
	self.activeWidget = nil
	self.lastActiveWidget = nil
	self.widgetType = nil
	self.isWheelLayout = true
	self.anyChildUsesUpdateState = true
	self.prepared = false
	self.indexMap = {}
	self.__updateChildrenOnStateUpdate = true
	self._on_menuOpened = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		self:menuOpened(f2_arg1, f2_arg2, f2_arg3)
	end
	f1_arg0:addMenuOpenedCallback(self._on_menuOpened)
	return self
end
LUI.WheelLayout.forceMenuOpenedEvent = function(f3_arg0, f3_arg1, f3_arg2)
	f3_arg0:menuOpened(f3_arg1, f3_arg2, true)
end
LUI.WheelLayout.removeDataSourceLink = function(f4_arg0, f4_arg1)
	if f4_arg0.dataSourceName and DataSources[f4_arg0.dataSourceName] and LUI.WheelLayout.__trackedLists[f4_arg0.dataSourceName] then
		LUI.WheelLayout.__trackedLists[f4_arg0.dataSourceName][f4_arg0] = nil
		if not f4_arg1 and DataSources[f4_arg0.dataSourceName].cleanup and LuaUtils.IsHashTableEmpty(LUI.WheelLayout.__trackedLists[f4_arg0.dataSourceName]) then
			DataSources[f4_arg0.dataSourceName].cleanup(f4_arg0, f4_arg0.controller)
			LUI.WheelLayout.__trackedLists[f4_arg0.dataSourceName] = nil
		end
	end
end
LUI.WheelLayout.addDataSourceLink = function(f5_arg0)
	if f5_arg0.dataSourceName and DataSources[f5_arg0.dataSourceName] then
		if not LUI.WheelLayout.__trackedLists[f5_arg0.dataSourceName] then
			LUI.WheelLayout.__trackedLists[f5_arg0.dataSourceName] = {}
		end
		LUI.WheelLayout.__trackedLists[f5_arg0.dataSourceName][f5_arg0] = true
	end
end
LUI.WheelLayout.setDataSource = function(f6_arg0, f6_arg1)
	if f6_arg0.dataSourceName ~= f6_arg1 then
		f6_arg0:removeDataSourceLink(true)
		local f6_local0 = DataSources[f6_arg1]
		f6_arg0.dataSourceName = f6_arg1
		f6_arg0:addDataSourceLink()
		if f6_local0 and f6_local0.prepare then
			f6_arg0:updateDataSource(nil, true)
		else
			f6_arg0:clearLayout()
		end
	end
end
LUI.WheelLayout.setCount = function(f7_arg0, f7_arg1, f7_arg2)
	f7_arg0.Count = f7_arg1
	f7_arg0:updateDataSource(nil, f7_arg2, true)
end
LUI.WheelLayout.getElementAtZeroBasedIndex = function(f8_arg0, f8_arg1)
	return f8_arg0.layoutItems[f8_arg1 + 1]
end
LUI.WheelLayout.getTotalCount = function(f9_arg0)
	local f9_local0 = f9_arg0:getDataSource()
	if f9_local0 then
		return f9_local0.getCount(f9_arg0)
	else
		return f9_arg0.Count
	end
end
LUI.WheelLayout.getDataSource = function(f10_arg0)
	return DataSources[f10_arg0.dataSourceName]
end
LUI.WheelLayout.setWidgetType = function(f11_arg0, f11_arg1)
	f11_arg0.widgetType = f11_arg1
	f11_arg0:clearLayout()
end
LUI.WheelLayout.mergeStateConditions = function(f12_arg0, f12_arg1)
	f12_arg0.elementStateConditions = {}
	LUI.WheelLayout.super.mergeStateConditions(f12_arg0, f12_arg1, f12_arg0.elementStateConditions)
	f12_arg0:clearLayout()
	f12_arg0:updateLayout()
end
LUI.WheelLayout.clearLayout = function(f13_arg0, f13_arg1)
	for f13_local3, f13_local4 in pairs(f13_arg0.layoutItems) do
		f13_arg0.layoutItems[f13_local3]:close()
		f13_arg0.layoutItems[f13_local3] = nil
	end
	f13_arg0.layoutItems = {}
	if f13_arg1 then
		f13_arg0:updateLayout()
	end
end
LUI.WheelLayout.updateLayout = function(f14_arg0, f14_arg1)
	if f14_arg0.__closing or not f14_arg0.__receivedMenuOpenedEvent or f14_arg0._layoutTimer then
		return
	end
	local f14_local0 = f14_arg1 or 0
	local f14_local1 = f14_arg0:getDataSource()
	if not f14_local1 then
		f14_arg0:clearLayout(false)
		return
	elseif f14_local1.prepare and not f14_arg0.prepared then
		f14_arg0:updateDataSource(true, true, false)
	end
	local f14_local2 = math.min(f14_arg0.Count, f14_local1.getCount(f14_arg0))
	local f14_local3 = 0
	local f14_local4 = 360 / f14_local2
	for f14_local5 = 1, f14_local2, 1 do
		local f14_local8 = f14_arg0:getModelForIndex(f14_local5)
		local f14_local9 = f14_local8:create("zRot")
		f14_local9:set(f14_local3)
		f14_local9 = f14_local8:create("angleWidth")
		f14_local9:set(f14_local4)
		if not f14_arg0.layoutItems[f14_local5] then
			f14_local9 = f14_arg0:createWidgetForPosition(f14_local5)
			f14_arg0.layoutItems[f14_local5] = f14_local9
			f14_arg0.itemStencil:addElement(f14_local9)
		else
			f14_arg0.layoutItems[f14_local5]:setModel(f14_local8, f14_arg0.controller)
			if f14_arg0.layoutItems[f14_local5] == f14_arg0.activeWidget then
				f14_arg0:setModel(f14_local8, f14_arg0.controller)
			end
			f14_arg0:updateCustomWidgetProperties(f14_local5, f14_arg0.layoutItems[f14_local5])
		end
		f14_arg0.layoutItems[f14_local5]:setZRot(f14_local3)
		f14_local3 = f14_local3 + f14_local4
	end
end
LUI.WheelLayout.createWidget = function(f15_arg0, f15_arg1, f15_arg2)
	if not f15_arg2 then
		return
	end
	local f15_local0 = f15_arg2.new(f15_arg0.menu, f15_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	if not f15_local0 then
		return
	elseif f15_arg2 == f15_arg0.widgetType then
		f15_local0:mergeStateConditions(f15_arg0.elementStateConditions)
	end
	f15_arg0.itemStencil[f15_local0.id] = f15_local0
	LUI.OverrideFunction_CallOriginalFirst(f15_local0, "close", function()
		f15_arg0.itemStencil[f15_local0.id] = nil
		local f16_local0 = f15_arg0:getDataSource()
		if f16_local0 and f16_local0.destroyItem and f15_local0.gridInfoTable then
			f16_local0.destroyItem(f15_arg0.controller, f15_arg0, f15_local0.gridInfoTable.zeroBasedIndex)
		end
	end)
	return f15_local0
end
LUI.WheelLayout.getModelForIndex = function(f17_arg0, f17_arg1)
	local f17_local0 = f17_arg0:getDataSource()
	if not f17_arg0.prepared or not f17_local0 or not f17_local0.getCount then
		return nil
	elseif f17_arg1 and f17_arg1 <= f17_local0.getCount(f17_arg0) then
		return f17_local0.getItem(f17_arg0.controller, f17_arg0, f17_arg1)
	else
		return nil
	end
end
LUI.WheelLayout.getModelForPosition = function(f18_arg0, f18_arg1, f18_arg2)
	return f18_arg0:getModelForIndex(f18_arg0:GetTableIndexForPosition(f18_arg1, f18_arg2))
end
LUI.WheelLayout.getPropertiesForIndex = function(f19_arg0, f19_arg1)
	local f19_local0 = f19_arg0:getDataSource()
	if not f19_local0 or not f19_local0.getCount or not f19_local0.getCustomPropertiesForItem then
		return nil
	elseif f19_arg1 <= f19_local0.getCount(f19_arg0) then
		return f19_local0.getCustomPropertiesForItem(f19_arg0, f19_arg1)
	else
		return nil
	end
end
LUI.WheelLayout.updateCustomWidgetProperties = function(f20_arg0, f20_arg1, f20_arg2)
	if not f20_arg2 then
		return
	end
	local f20_local0 = f20_arg0:getPropertiesForIndex(f20_arg1)
	if f20_local0 then
		for f20_local4, f20_local5 in pairs(f20_local0) do
			if f20_local4 == "id" then
				LUI_WheelLayout_ChangeWidgetId(f20_arg0.itemStencil, f20_arg2, f20_local5)
			else
				f20_arg2[f20_local4] = f20_local5
			end
		end
	end
end
LUI.WheelLayout.getWidgetForIndex = function(f21_arg0, f21_arg1)
	return LUI.GridLayout.getWidgetForIndex(f21_arg0, f21_arg1)
end
LUI.WheelLayout.createWidgetForPosition = function(f22_arg0, f22_arg1)
	local f22_local0 = f22_arg0:getDataSource()
	if not f22_arg0.prepared or not f22_local0 or not f22_local0.getCount then
		return nil
	end
	local f22_local1 = f22_local0.getCount(f22_arg0)
	local f22_local2 = f22_arg1
	if f22_local2 and f22_local2 <= f22_local1 then
		local f22_local3 = f22_arg0:getModelForIndex(f22_local2)
		local f22_local4 = f22_arg0:getWidgetForIndex(f22_arg1)
		local f22_local5 = f22_arg0:getPropertiesForIndex(f22_local2)
		local f22_local6 = f22_arg0:createWidget(f22_arg0.controller, f22_local4)
		if f22_local6 ~= nil then
			f22_arg0:updateCustomWidgetProperties(f22_arg1, f22_local6)
			if f22_local3 then
				f22_local6:setModel(f22_local3, f22_arg0.controller, true)
			end
			if f22_local3 then
				local f22_local7 = Engine.GetModel(f22_local3, "customId")
				if f22_local7 then
					LUI_WheelLayout_ChangeWidgetId(f22_arg0.itemStencil, f22_local6, Engine.GetModelValue(f22_local7))
				end
			end
			f22_arg0.menu:sendInitializationEvents(f22_arg0.controller, f22_local6)
			return f22_local6
		end
	end
	return nil
end
LUI.WheelLayout.updateDataSource = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
	f23_arg0.itemCount = 0
	if not f23_arg0.__receivedMenuOpenedEvent then
		return
	end
	local f23_local0 = f23_arg0:getDataSource()
	if not f23_local0 or not f23_local0.getCount or not f23_local0.getItem then
		return
	elseif not f23_arg0.widgetType then
		return
	elseif f23_local0.prepare and (not f23_arg0.prepared or not f23_arg3) then
		f23_arg0.prepared = false
		f23_local0.prepare(f23_arg0.controller, f23_arg0, f23_arg0.filter)
		f23_arg0.prepared = true
	end
	if f23_arg0.Count > 1 then
		f23_arg0.itemCount = f23_local0.getCount(f23_arg0)
		f23_arg0:updateLayout()
		f23_arg0:dispatchEventToParent({
			name = "grid_updated",
			grid = f23_arg0,
			controller = f23_arg0.controller,
		})
		return true
	end
end
LUI.WheelLayout.close = function(f24_arg0)
	f24_arg0.__closing = true
	f24_arg0:unsubscribeFromAllModels()
	f24_arg0:clearLayout(false)
	f24_arg0:removeDataSourceLink()
	f24_arg0.menu:removeMenuOpenedCallback(f24_arg0._on_menuOpened)
	LUI.WheelLayout.super.close(f24_arg0)
end
LUI.WheelLayout.updateState = function(f25_arg0, f25_arg1)
	if not f25_arg0.__closing then
		LUI.WheelLayout.super.updateState(f25_arg0, f25_arg1)
		f25_arg0:updateLayout(0)
	end
end
LUI.WheelLayout:registerEventHandler("update_state", LUI.WheelLayout.updateState)
LUI.WheelLayout.menuLoaded = function(f26_arg0, f26_arg1)
	f26_arg0.__receivedMenuLoadedEvent = true
	f26_arg0:dispatchEventToChildren(f26_arg1)
end
LUI.WheelLayout:registerEventHandler("menu_loaded", LUI.WheelLayout.menuLoaded)
LUI.WheelLayout.menuOpened = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
	if not f27_arg0.__receivedMenuOpenedEvent then
		f27_arg0.__receivedMenuOpenedEvent = true
		f27_arg0:updateDataSource()
	end
end
LUI.WheelLayout.getStickModel = function(f28_arg0, f28_arg1)
	if f28_arg0._useLeftStick then
		return DataSources.LeftStick.getModel(f28_arg1)
	else
		return DataSources.RightStick.getModel(f28_arg1)
	end
end
LUI.WheelLayout.setActiveOnUpdate = true
LUI.WheelLayout.id = "LUIWheelLayout"
