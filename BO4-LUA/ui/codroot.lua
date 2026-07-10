LUI.CoDRoot = {}
LUI.CoDRoot.ProcessEvent = function(f1_arg0, f1_arg1)
	if f1_arg1.immediate == true then
		LUI.CoDRoot.ProcessEventNow(f1_arg0, f1_arg1)
	else
		local f1_local0 = f1_arg0.eventQueue
		table.insert(f1_local0, f1_arg1)
		local f1_local1 = #f1_local0
		if f1_local1 > 20 then
			DebugPrint("LUI WARNING: Event queue exceeded 20 events! " .. f1_arg1.name .. ". Size is " .. f1_local1)
		end
	end
end
LUI.CoDRoot.ProcessEvents = function(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.eventQueue
	local f2_local1 = 0
	local f2_local2 = #f2_local0
	if f2_local2 > 60 then
		f2_local1 = f2_local2
		DebugPrint("LUI WARNING: Event queue reached " .. f2_local1 .. "!. ** Emergency event processing kicked off. ** ")
	elseif f2_local2 > 40 then
		f2_local1 = math.floor(f2_local2 / 10)
		DebugPrint("LUI WARNING: Event queue reached " .. f2_local2 .. ". Processing " .. f2_local1 .. " events this frame.")
	else
		f2_local1 = 1
	end
	for f2_local3 = 1, f2_local1, 1 do
		local f2_local6 = f2_local3
		local f2_local7 = f2_local0[1]
		if f2_local7 ~= nil then
			table.remove(f2_local0, 1)
			LUI.CoDRoot.ProcessEventNow(f2_arg0, f2_local7)
		end
	end
end
LUI.CoDRoot.ProcessEventNow = function(f3_arg0, f3_arg1)
	if f3_arg1.name ~= "process_events" then
		Engine[0x6E447857BE70BC1](f3_arg1.name)
		Engine[0xDE5D6CFE3B945DD]()
	end
	local f3_local0 = f3_arg0:propagateEvent(f3_arg1)
	if f3_local0 then
		Engine[0x66E2713AD003565]()
		return f3_local0
	end
	local f3_local1 = LUI.UIElement.processEvent(f3_arg0, f3_arg1)
	if f3_arg1.name ~= "process_events" then
		Engine[0x66E2713AD003565]()
	end
	return f3_local1
end
LUI.CoDRoot.DontPropagateEvent = function(f4_arg0, f4_arg1) end
LUI.CoDRoot.PropagateEventToPrimaryRoot = function(f5_arg0, f5_arg1)
	if LUI.primaryRoot ~= nil and LUI.primaryRoot ~= f5_arg0 and f5_arg1.name ~= "addmenu" then
		return LUI.UIElement.processEvent(LUI.primaryRoot, f5_arg1)
	else
	end
end
LUI.CoDRoot.CloseAll = function(f6_arg0, f6_arg1)
	f6_arg0:removeAllChildren()
	return true
end
LUI.CoDRoot.CloseMenu = function(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0:getFirstChild()
	while f7_local0 ~= nil do
		if f7_local0.menuName == f7_arg1.menuName then
			f7_local0:close()
		end
		f7_local0 = f7_local0:getNextSibling()
	end
	return true
end
LUI.CoDRoot.PrintElementTree = function(f8_arg0, f8_arg1)
	if f8_arg1.depth < f8_arg1.maxDepth then
		local f8_local0 = ""
		for f8_local1 = 1, f8_arg1.depth, 1 do
			local f8_local4 = f8_local1
			f8_local0 = f8_local0 .. "\t"
		end
		f8_arg1.depth = f8_arg1.depth + 1
		print(f8_local0, f8_arg0.id)
		local f8_local1 = f8_arg0:getFirstChild()
		while f8_local1 do
			local f8_local2 = f8_local1:getNextSibling()
			LUI.CoDRoot.PrintElementTree(f8_local1, f8_arg1)
			f8_local1 = f8_local2
		end
	end
end
LUI.CoDRoot.new = function(menu, controller)
	local self = LUI.UIRoot.new(menu, controller)
	self.eventQueue = {}
	self.numEvents = 0
	self:registerEventHandler("process_events", LUI.CoDRoot.ProcessEvents)
	self:registerEventHandler("close_all", LUI.CoDRoot.CloseAll)
	self:registerEventHandler("close_menu", LUI.CoDRoot.CloseMenu)
	self:registerEventHandler("print_element_tree", LUI.CoDRoot.PrintElementTree)
	self.propagateEvent = LUI.CoDRoot.PropagateEventToPrimaryRoot
	self.processEvent = LUI.CoDRoot.ProcessEvent
	if LUI.primaryRoot == nil then
		LUI.primaryRoot = self
		if LUI.DEV then
			LUI.DEV.InitEventHandlers(self)
		end
	end
	if Rat and Rat.InitLui then
		Rat.InitLui()
	end
	return self
end
