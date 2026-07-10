LUI.UITimer = {}
LUI.UITimer.priority = 10000
LUI.UITimer.create = function(menu, controller)
	local self = LUI.UIElement.new(0, 0, 0, 0, 0, 0, 0, 0)
	self.id = "LUITimer"
	self:setPriority(LUI.UITimer.priority)
	self.reset = LUI.UITimer.Reset
	self.processNow = LUI.UITimer.ProcessNow
	self.interval = math.max(1, menu)
	self.disposable = controller
	return self
end
LUI.UITimer.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = LUI.UITimer.create(f2_arg0, f2_arg2)
	if type(f2_arg1) == "string" then
		f2_local0.timerEvent = {
			name = f2_arg1,
			timer = f2_local0,
		}
	else
		f2_arg1.timer = f2_local0
		f2_local0.timerEvent = f2_arg1
	end
	f2_local0.timerEventTarget = f2_arg3
	f2_local0:reset()
	return f2_local0
end
LUI.UITimer.newElementTimer = function(f3_arg0, f3_arg1, f3_arg2, ...)
	local f3_local0 = LUI.UITimer.create(f3_arg0, f3_arg1)
	local f3_local1 = {
		n = select("#", ...),
		...,
	}
	f3_local0.timerEventFunction = function(f4_arg0)
		local f4_local0 = LUI.ShallowCopy(f3_local1)
		table.insert(f4_local0, f4_arg0)
		f3_arg2(unpack(f4_local0))
	end
	f3_local0:reset()
	return f3_local0
end
LUI.UITimer.Reset = function(f5_arg0)
	f5_arg0:registerEventHandler("transition_complete_keyframe", nil)
	f5_arg0:beginAnimation("keyframe", f5_arg0.interval, false, false, CoD.TweenType.Linear)
	f5_arg0:registerEventHandler("transition_complete_keyframe", LUI.UITimer.Tick)
end
LUI.UITimer.Tick = function(f6_arg0, f6_arg1)
	local f6_local0 = nil
	if f6_arg0.timerEventTarget ~= nil then
		f6_local0 = f6_arg0.timerEventTarget
	else
		f6_local0 = f6_arg0:getParent()
	end
	local f6_local1 = f6_arg0.timerEvent or {}
	f6_local1.timeElapsed = f6_arg0.interval + f6_arg1.lateness
	if f6_arg0.timerEventFunction then
		f6_arg0.timerEventFunction(f6_local1)
	elseif f6_local1 then
		f6_local0:processEvent(f6_local1)
	end
	if f6_arg0.disposable then
		f6_arg0:close()
	else
		f6_arg0:reset()
	end
end
LUI.UITimer.ProcessNow = function(f7_arg0)
	local f7_local0 = nil
	if f7_arg0.timerEventTarget ~= nil then
		f7_local0 = f7_arg0.timerEventTarget
	else
		f7_local0 = f7_arg0:getParent()
	end
	local f7_local1 = f7_arg0.timerEvent or {}
	f7_local1.timeElapsed = f7_arg0.interval
	if f7_arg0.timerEventFunction then
		f7_arg0.timerEventFunction(f7_local1)
	elseif f7_local1 then
		f7_local0:processEvent(f7_local1)
	end
	if f7_arg0.disposable then
		f7_arg0:close()
	else
		f7_arg0:reset()
	end
end
