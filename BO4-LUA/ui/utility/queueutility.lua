CoD.QueueUtility = {}
CoD.QueueUtility.TimedFnQueuePriority = {
	AbilityCallout = 1,
	WaypointCaptured = 1,
	EqualPriority = 1,
}
CoD.QueueUtility.TimedFnQueueMaxSize = 5
CoD.QueueUtility.PumpTimedFnQueue = function(f1_arg0)
	if not f1_arg0.timedFnQueue then
		return
	elseif #f1_arg0.timedFnQueue > 0 then
		local f1_local0 = f1_arg0.timedFnQueueNextItemIndex > CoD.QueueUtility.TimedFnQueueMaxSize
		local f1_local1 = 10
		local f1_local2 = -1
		for f1_local3 = 1, #f1_arg0.timedFnQueue, 1 do
			if f1_arg0.timedFnQueue[f1_local3].priority < f1_local1 then
				f1_local1 = f1_arg0.timedFnQueue[f1_local3].priority
				f1_local2 = f1_local3
			end
		end
		if f1_local1 == 10 or f1_local2 < 1 then
			error("Incorrect priority " .. f1_local1 .. " or queueIndex " .. f1_local2 .. " in Timed Fn Queue System. ")
		end
		local f1_local3 = f1_arg0.timedFnQueue[f1_local2]
		f1_arg0.timedFnQueuePumping = true
		table.remove(f1_arg0.timedFnQueue, f1_local2)
		f1_local3.callback(f1_arg0, f1_local2, f1_local3.paramData)
		if f1_local3.paramData.clipBased then
		elseif f1_local3.paramData.pumpTime then
			f1_arg0:addElement(LUI.UITimer.newElementTimer(f1_local3.paramData.pumpTime, true, function()
				CoD.QueueUtility.PumpTimedFnQueue(f1_arg0)
			end))
		end
		error("Invalid Timing Type in Timed Fn Queue System")
	else
		f1_arg0.timedFnQueuePumping = false
	end
end
CoD.QueueUtility.InitTimedFnQueue = function(f3_arg0)
	if not f3_arg0.timedFnQueue then
		f3_arg0.timedFnQueue = {}
	end
	if not f3_arg0.timedFnQueueNextItemIndex then
		f3_arg0.timedFnQueueNextItemIndex = 1
	end
	if not f3_arg0.timedFnQueuePumping then
		f3_arg0.timedFnQueuePumping = false
	end
end
CoD.QueueUtility.AddToTimedFnQueue = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	CoD.QueueUtility.InitTimedFnQueue(f4_arg0)
	table.insert(f4_arg0.timedFnQueue, {
		priority = f4_arg1,
		callback = f4_arg2,
		paramData = f4_arg3,
	})
	if f4_arg0.timedFnQueuePumping == false then
		CoD.QueueUtility.PumpTimedFnQueue(f4_arg0)
	end
end
