
require( "x64:3d34eb545cb19f0" )
Lobby.ProcessQueue = {}
Lobby.ProcessQueue.INVALID_ACTION_ID = 0
Lobby.ProcessQueue.EVENT_START_ERROR = -1
Lobby.ProcessQueue.ACTIONSTATE = {
	PENDING = 0,
	RUNNING = 1,
	SUCCESS = 2,
	FAILURE = 3,
	ERROR = 4,
	UPDATE = 5,
	THROTTLED = 6
}
Lobby.ProcessQueue.queue = nil
Lobby.ProcessQueue.actionId = 1
Lobby.ProcessQueue.queueSize = 10
Lobby.ProcessQueue.ClearQueue = function ()
	Lobby.ProcessQueue.queue = {
		processName = "",
		head = nil,
		history = nil,
		interrupt = nil,
		cancellable = nil
	}
	Lobby.ProcessQueue.SetQueueEmptyModel( true )
end
Lobby.ProcessQueue.SetQueueEmptyModel = function ( f2_arg0 )
	Engine[@"setmodelvalue"]( Engine[@"createmodel"]( Engine[@"createmodel"]( Engine[@"getglobalmodel"](), "lobbyRoot", true ), "queueEmpty", true ), f2_arg0 )
end
Lobby.ProcessQueue.ReplaceWith = function ( f3_arg0 )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyProcessQueue: Process: '" .. Lobby.ProcessQueue.queue.processName .. "', Replacing '" .. Lobby.ProcessQueue.queue.head.name .. "' with '" .. f3_arg0.name .. "' in process queue.\n" )
	f3_arg0.state = Lobby.ProcessQueue.ACTIONSTATE.PENDING
	Lobby.ProcessQueue.queue.head = f3_arg0
end
Lobby.ProcessQueue.CreateInterrupt = function ( f4_arg0, f4_arg1 )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyProcessQueue: Process: '" .. Lobby.ProcessQueue.queue.processName .. "', '" .. Lobby.ProcessQueue.queue.head.name .. "' is interrupted in process queue.\n" )
	local f4_local0 = f4_arg1:createFuncPtr( f4_arg0 )
	return f4_local0.head
end
Lobby.ProcessQueue.Init = function ()
	Lobby.ProcessQueue.ClearQueue()
	Lobby.ProcessQueue.TaskHistory = {}
end
Lobby.ProcessQueue.IsQueueEmpty = function ()
	if Lobby.ProcessQueue.queue.head ~= nil then
		return false
	else
		return true
	end
end
Lobby.ProcessQueue.CopyProcess = function ( f7_arg0 )
	local f7_local0 = type( f7_arg0 )
	local f7_local1 = nil
	if f7_local0 == "table" then
		f7_local1 = {}
		local f7_local2 = next
		local f7_local3 = f7_arg0
		local f7_local4 = nil
		goto basicblock_6:
		local f7_local5, f7_local6 = f7_local2( f7_local3, f7_local4 )
		while f7_local5 ~= nil do
			f7_local4 = f7_local5
			if f7_local5 ~= "parent" then
				f7_local1[Lobby.ProcessQueue.CopyProcess( f7_local5 )] = Lobby.ProcessQueue.CopyProcess( f7_local6 )
			else
				f7_local1 = f7_arg0
			end
		end
		setmetatable( f7_local1, Lobby.ProcessQueue.CopyProcess( getmetatable( f7_arg0 ) ) )
	else
		f7_local1 = f7_arg0
	end
	return f7_local1
end
Lobby.ProcessQueue.GetQueueHead = function ()
	return Lobby.ProcessQueue.queue.head
end
Lobby.ProcessQueue.SetCancellable = function ( f9_arg0 )
	Lobby.ProcessQueue.queue.cancellable = f9_arg0
end
Lobby.ProcessQueue.GetCurrentRunningProcessName = function ()
	if Lobby.ProcessQueue.queue == nil or Lobby.ProcessQueue.queue.processName == nil then
		return ""
	else
		return Lobby.ProcessQueue.queue.processName
	end
end
Lobby.ProcessQueue.AddToQueue = function ( f11_arg0, f11_arg1 )
	if f11_arg1 == nil then
		return 
	elseif Lobby.ProcessQueue.IsQueueEmpty() then
		Lobby.ProcessQueue.ClearQueue()
		f11_arg1.head.state = Lobby.ProcessQueue.ACTIONSTATE.PENDING
		Lobby.ProcessQueue.queue.processName = f11_arg0
		Lobby.ProcessQueue.queue.history = f11_arg1.head
		Lobby.ProcessQueue.queue.head = f11_arg1.head
		Lobby.ProcessQueue.queue.interrupt = f11_arg1.interrupt
		Lobby.ProcessQueue.queue.cancellable = f11_arg1.cancellable
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "****************PROCESS QUEUE START****************\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyProcessQueue: Adding process: '" .. f11_arg0 .. "', head action: '" .. f11_arg1.head.name .. "' to queue.\n" )
		Lobby.Debug.OnProcessStart( f11_arg0 )
	elseif Lobby.ProcessQueue.queue.cancellable == true or f11_arg1.force == true then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "****************PROCESS QUEUE CHANGE****************\n" )
		Engine[@"printwarning"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyProcessQueue: Adding process '" .. f11_arg0 .. "' when process '" .. Lobby.ProcessQueue.queue.processName .. "' is currently running.\n" )
		Engine[@"printwarning"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Will finish process '" .. Lobby.ProcessQueue.queue.processName .. "' current running action '" .. Lobby.ProcessQueue.queue.head.name .. "', then proceed with process '" .. f11_arg0 .. "'.\n" )
		Lobby.Debug.OnProcessComplete()
		Lobby.Debug.OnProcessStart( f11_arg0 )
		Lobby.ProcessQueue.queue.processName = f11_arg0
		Lobby.ProcessQueue.queue.history = f11_arg1.head
		Lobby.Process.OverWriteAction( Lobby.ProcessQueue.queue.head, f11_arg1.head )
		Lobby.ProcessQueue.queue.interrupt = f11_arg1.interrupt
		if nil ~= Lobby.ProcessQueue.queue.head.cancelFuncPtr then
			Engine[@"printwarning"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Cancelling action: '" .. Lobby.ProcessQueue.queue.head.name .. "'.\n" )
			Lobby.ProcessQueue.queue.head.canceled = true
			Lobby.ProcessQueue.queue.head:cancelFuncPtr()
		else
			Engine[@"printwarning"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "No cancel func (cancelFuncPtr) defined for action: '" .. Lobby.ProcessQueue.queue.head.name .. "'.\n" )
		end
	end
	Lobby.ProcessQueue.SetQueueEmptyModel( false )
	Lobby.Debug.AddDebugProcess()
	Lobby.ProcessQueue.Pump()
end
Lobby.ProcessQueue.ErrorShutdown = function ()
	if Lobby.ProcessQueue.queue.head ~= nil and Lobby.ProcessQueue.queue.head.cancelFuncPtr ~= nil then
		Engine[@"printwarning"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Cancelling action: '" .. Lobby.ProcessQueue.queue.head.name .. "'.\n" )
		Lobby.ProcessQueue.queue.head.canceled = true
		Lobby.ProcessQueue.queue.head:cancelFuncPtr()
	end
	Engine[@"setmodelvalue"]( Engine[@"createmodel"]( Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive" ), false )
	Lobby.ProcessQueue.ClearQueue()
end
Lobby.ProcessQueue.Pump = function ()
	if not Engine[@"ismainthreadorproxy"]() then
		return 
	end
	local f13_local0 = Lobby.ProcessQueue.queue.head
	if f13_local0 == nil then
		Lobby.MatchmakingAsync.CheckEventQueue()
		while f13_local0 ~= nil do
			if f13_local0.state == Lobby.ProcessQueue.ACTIONSTATE.PENDING or f13_local0.state == Lobby.ProcessQueue.ACTIONSTATE.THROTTLED then
				if not Lobby.ProcessQueue.TaskHistory[f13_local0.name] then
					Lobby.ProcessQueue.TaskHistory[f13_local0.name] = {}
					Lobby.ProcessQueue.TaskHistory[f13_local0.name].count = 0
					Lobby.ProcessQueue.TaskHistory[f13_local0.name].lastRunTime = 0
				end
				if Lobby.ProcessQueue.TaskHistory[f13_local0.name].lastRunTime > 0 and f13_local0.throttle ~= nil and f13_local0.throttle > 0 then
					local f13_local1 = Engine[@"milliseconds"]()
					if f13_local1 < Lobby.ProcessQueue.TaskHistory[f13_local0.name].lastRunTime + f13_local0.throttle then
						if f13_local0.state == Lobby.ProcessQueue.ACTIONSTATE.PENDING then
							Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyAction: Throttling '" .. f13_local0.name .. "' [ID:" .. tostring( Lobby.ProcessQueue.actionId ) .. " for: " .. tostring( Lobby.ProcessQueue.TaskHistory[f13_local0.name].lastRunTime + f13_local0.throttle - f13_local1 ) .. " ms ]...\n" )
							f13_local0.state = Lobby.ProcessQueue.ACTIONSTATE.THROTTLED
						end
						return 
					end
				end
				f13_local0.state = Lobby.ProcessQueue.ACTIONSTATE.RUNNING
				f13_local0.actionId = Lobby.ProcessQueue.actionId
				f13_local0.startTime = Engine[@"milliseconds"]()
				Lobby.ProcessQueue.actionId = Lobby.ProcessQueue.actionId + 1
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyAction: Executing '" .. f13_local0.name .. "' [ID:" .. tostring( f13_local0.actionId ) .. "]...\n" )
				Lobby.Debug.AddDebugAction( f13_local0 )
				if f13_local0.startFuncPtr ~= nil then
					f13_local0:startFuncPtr()
				end
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyAction: '" .. f13_local0.name .. "' [ID:" .. tostring( f13_local0.actionId ) .. "] is asynchronous.\n" )
				Lobby.ProcessQueue.TaskHistory[f13_local0.name].count = Lobby.ProcessQueue.TaskHistory[f13_local0.name].count + 1
				Lobby.ProcessQueue.TaskHistory[f13_local0.name].lastRunTime = f13_local0.startTime
			end
			if f13_local0.state == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
				if f13_local0.pumpFuncPtr ~= nil then
					f13_local0:pumpFuncPtr()
				end
				Lobby.Debug.UpdateProcessQueue()
				return 
			end
			local f13_local1 = nil
			local f13_local2 = -1
			if f13_local0.startTime ~= nil then
				f13_local2 = Engine[@"milliseconds"]() - f13_local0.startTime
			end
			if f13_local0.endFuncPtr ~= nil then
				f13_local0:endFuncPtr()
			end
			if f13_local0.state == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyAction: '" .. f13_local0.name .. "' [ID:" .. tostring( f13_local0.actionId ) .. "] completed successfully in " .. tostring( f13_local2 ) .. "ms.\n" )
				if f13_local0.success ~= nil and f13_local0.success.isInterrupt == true then
					Lobby.Debug.OnActionComplete( f13_local0, Lobby.ProcessQueue.CreateInterrupt( f13_local0, f13_local0.success ), true )
				else
					Lobby.Debug.OnActionComplete( f13_local0, f13_local0.success, false )
				end
				Lobby.Debug.UpdateProcessQueue()
			elseif f13_local0.state == Lobby.ProcessQueue.ACTIONSTATE.FAILURE then
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyAction: '" .. f13_local0.name .. "' [ID:" .. tostring( f13_local0.actionId ) .. "] completed with failure in " .. tostring( f13_local2 ) .. "ms.\n" )
				if f13_local0.failure ~= nil and f13_local0.failure.isInterrupt == true then
					Lobby.Debug.OnActionComplete( f13_local0, Lobby.ProcessQueue.CreateInterrupt( f13_local0, f13_local0.failure ), true )
				else
					Lobby.Debug.OnActionComplete( f13_local0, f13_local0.failure, false )
				end
				Lobby.Debug.UpdateProcessQueue()
			elseif f13_local0.state == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyAction: '" .. f13_local0.name .. "' [ID:" .. tostring( f13_local0.actionId ) .. "] completed with error in " .. tostring( f13_local2 ) .. "ms.\n" )
				if f13_local0.error ~= nil and f13_local0.error.isInterrupt == true then
					Lobby.Debug.OnActionComplete( f13_local0, Lobby.ProcessQueue.CreateInterrupt( f13_local0, f13_local0.error ), true )
				else
					Lobby.Debug.OnActionComplete( f13_local0, f13_local0.error, false )
				end
				Lobby.Debug.UpdateProcessQueue()
			end
			if f13_local1 ~= nil then
				Lobby.ProcessQueue.ReplaceWith( f13_local1 )
			else
				Lobby.ProcessQueue.ClearQueue()
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyAction: Process tree complete.\n" )
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "****************PROCESS QUEUE END****************\n" )
				Lobby.Debug.OnProcessComplete()
			end
			f13_local0 = Lobby.ProcessQueue.queue.head
		end
	end
end
Lobby.ProcessQueue.CompleteEvent = function ( f14_arg0, f14_arg1, f14_arg2 )
	local f14_local0 = Lobby.ProcessQueue.queue.head
	local f14_local1 = f14_arg2.actionId
	if f14_local1 <= Lobby.ProcessQueue.INVALID_ACTION_ID then
		Lobby.ProcessQueue.ProcessEvent( f14_local1, f14_arg0, f14_arg2 )
		return 
	elseif f14_local0 == nil then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "^6LobbyAction: received a task completed " .. f14_arg1 .. " event but the action queue is empty. actionId: " .. tostring( f14_local1 ) .. ".\n" )
	else
		local f14_local2 = "LobbyAction: task completed " .. f14_arg1 .. " event. Head: " .. f14_local0.name .. ", actionId: " .. tostring( f14_local0.actionId ) .. ".\n"
		if f14_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE then
			Engine[@"printwarning"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], f14_local2 )
		elseif f14_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "***********************************************************************\n" )
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], f14_local2 )
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "***********************************************************************\n" )
		else
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], f14_local2 )
		end
		if f14_local0.actionId ~= f14_local1 then
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "^6LobbyAction: mismatched task completed " .. f14_arg1 .. " event. Head: " .. f14_local0.name .. " was at actionId: " .. tostring( f14_local0.actionId ) .. " but we received actionId: " .. tostring( f14_local1 ) .. ".\n" )
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "LOBBY VM ERROR: Please copy full log and email to codcoreonline@treyarch.com" )
			if Engine[@"isshipbuild"]() == false then
				Engine[@"comerror"]( Enum[@"errorcode"][@"error_softrestart"], "Lobby process queue error occurred, please email your logs to codcoreonline@treyarch.com" )
			else
				Engine[@"comerror"]( Enum[@"errorcode"][@"error_softrestart"], Engine[@"hash_4F9F1239CFD921FE"]( @"hash_244F5E7E813DBEAB", LuaUtils.ValueToHex( LuaEnum.ERROR_CODE.TASK_MISMATCHED ) ) )
			end
			return 
		elseif f14_local0.state ~= Lobby.ProcessQueue.ACTIONSTATE.RUNNING and (not f14_local0.canceled or f14_local0.canceled == false) then
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "^6LobbyAction: received a task completed " .. f14_arg1 .. " event for non-running action queue head: " .. f14_local0.name .. ", actionId: " .. tostring( f14_local0.actionId ) .. ".\n" )
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "LOBBY VM ERROR: Please copy full log and email to codcoreonline@treyarch.com" )
			if Engine[@"isshipbuild"]() == false then
				Engine[@"comerror"]( Enum[@"errorcode"][@"error_softrestart"], "Lobby process queue error occurred, please email your logs to codcoreonline@treyarch.com" )
			else
				Engine[@"comerror"]( Enum[@"errorcode"][@"error_softrestart"], Engine[@"hash_4F9F1239CFD921FE"]( @"hash_244F5E7E813DBEAB", LuaUtils.ValueToHex( LuaEnum.ERROR_CODE.NONRUNNING_TASK ) ) )
			end
			return 
		end
		f14_local0.state = f14_arg0
		f14_local0.retData = f14_arg2
	end
	Lobby.Debug.UpdateProcessQueue()
end
Lobby.ProcessQueue.Success = function ( f15_arg0 )
	Lobby.ProcessQueue.CompleteEvent( Lobby.ProcessQueue.ACTIONSTATE.SUCCESS, "success", f15_arg0 )
	Lobby.Debug.UpdateProcessQueue()
end
Lobby.ProcessQueue.Failure = function ( f16_arg0 )
	Lobby.ProcessQueue.CompleteEvent( Lobby.ProcessQueue.ACTIONSTATE.FAILURE, "failure", f16_arg0 )
	Lobby.Debug.UpdateProcessQueue()
end
Lobby.ProcessQueue.Error = function ( f17_arg0 )
	Lobby.ProcessQueue.CompleteEvent( Lobby.ProcessQueue.ACTIONSTATE.ERROR, "error", f17_arg0 )
	Lobby.Debug.UpdateProcessQueue()
end
Lobby.ProcessQueue.PushEventUpdate = function ( f18_arg0 )
	if Lobby.ProcessQueue.IsQueueEmpty() then
		return 
	else
		local f18_local0 = Lobby.ProcessQueue.queue.head
		if f18_local0.eventsEnabled ~= true then
			return 
		else
			f18_arg0.actionId = f18_local0.actionId
			Lobby.ProcessQueue.Update( f18_arg0 )
		end
	end
end
Lobby.ProcessQueue.Update = function ( f19_arg0 )
	local f19_local0 = Lobby.ProcessQueue.queue.head
	local f19_local1 = f19_arg0.actionId
	if f19_local1 <= Lobby.ProcessQueue.INVALID_ACTION_ID then
		Lobby.ProcessQueue.ProcessEvent( f19_local1, Lobby.ProcessQueue.ACTIONSTATE.UPDATE, f19_arg0 )
		return 
	elseif f19_local0 == nil then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "LobbyAction: received an update but the action queue is empty. actionId: " .. tostring( f19_local1 ) .. ".\n" )
	else
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "LobbyAction: Lobby.ProcessQueue.Update. Head:" .. f19_local0.name .. ", actionId: " .. tostring( f19_local0.actionId ) .. ".\n" )
		if f19_local0.actionId ~= f19_local1 then
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "LobbyAction: mismatched update. Head: " .. f19_local0.name .. " was at actionId: " .. tostring( f19_local0.actionId ) .. " but we received actionId: " .. tostring( f19_local1 ) .. ".\n" )
		end
		if f19_local0.state ~= Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "LobbyAction: received a update for non-running action queue head: " .. f19_local0.name .. ", actionId: " .. tostring( f19_local0.actionId ) .. ".\n" )
		end
		if f19_local0.updateFuncPtr == nil then
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "LobbyAction: received a update for an action at head that doesn't have a head:updateFuncPtr() defined. Head: " .. f19_local0.name .. ", actionId: " .. tostring( f19_local0.actionId ) .. "\n" )
		end
		f19_local0:updateFuncPtr( f19_arg0 )
	end
	Lobby.Debug.UpdateProcessQueue()
end
Lobby.ProcessQueue.eventHandlerActionId = Lobby.ProcessQueue.INVALID_ACTION_ID
Lobby.ProcessQueue.eventHandler = {}
Lobby.ProcessQueue.RegisterEventHandler = function ( f20_arg0, f20_arg1 )
	Lobby.ProcessQueue.eventHandlerActionId = Lobby.ProcessQueue.eventHandlerActionId + 1
	Lobby.ProcessQueue.eventHandler[Lobby.ProcessQueue.eventHandlerActionId] = {
		callbackFunction = f20_arg0,
		eventData = f20_arg1
	}
	return Lobby.ProcessQueue.eventHandlerActionId * -1
end
Lobby.ProcessQueue.UnRegisterEventHandler = function ( f21_arg0 )
	if f21_arg0 == Lobby.ProcessQueue.INVALID_ACTION_ID then
		return false
	else
		f21_arg0 = math.abs( f21_arg0 )
		if Lobby.ProcessQueue.eventHandler[f21_arg0] == nil then
			return false
		else
			Lobby.ProcessQueue.eventHandler[f21_arg0] = nil
			return true
		end
	end
end
Lobby.ProcessQueue.ProcessEvent = function ( f22_arg0, f22_arg1, f22_arg2 )
	if f22_arg0 == Lobby.ProcessQueue.INVALID_ACTION_ID then
		return false
	else
		f22_arg0 = math.abs( f22_arg0 )
		if Lobby.ProcessQueue.eventHandler[f22_arg0] == nil then
			return false
		elseif Lobby.ProcessQueue.eventHandler[f22_arg0].callbackFunction( f22_arg1, Lobby.ProcessQueue.eventHandler[f22_arg0].eventData, f22_arg2 ) == false then
			return false
		else
			Lobby.ProcessQueue.eventHandler[f22_arg0] = nil
			return true
		end
	end
end
