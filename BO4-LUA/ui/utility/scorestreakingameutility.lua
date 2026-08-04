CoD.ScorestreakInGameUtility = {}
CoD.ScorestreakInGameUtility.HealthBoostMenuResponseName = "HealthBoost"
CoD.ScorestreakInGameUtility.ArrowState = {
	NONE = 0,
	UP = 1,
	DOWN = 2,
	BOTH = 3,
}
CoD.ScorestreakInGameUtility.HealthBoostPlayerSelected = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = f1_arg1:getModel()
	local f1_local1 = Engine.GetClientNum(f1_arg2)
	if f1_local0 then
		Engine.SendMenuResponse(f1_arg2, CoD.ScorestreakInGameUtility.HealthBoostMenuResponseName, "select_player", f1_local0.clientNum:get())
	end
end
CoD.ScorestreakInGameUtility.AddScorestreakListNavigation = function(f2_arg0, f2_arg1, f2_arg2)
	if Engine[@"isdemoplaying"]() then
		return
	end
	local f2_local0 = 0
	if CoD.isPC then
		f2_local0 = f2_local0 | LUI.GridLayout.NavigationFlags.CHANGE_FOCUS
	end
	local f2_local1 = function()
		if f2_arg1.menu._focusTimer == nil then
			f2_arg1.menu._focusTimer = LUI.UITimer.newElementTimer(0, true, function()
				f2_arg1.menu:removeElement(f2_arg1.menu._focusTimer)
				f2_arg1.menu._focusTimer = nil
				f2_arg1.hasListFocus = true
				f2_arg1:getFirstSelectableItem(true)
			end)
			f2_arg1.menu:addElement(f2_arg1.menu._focusTimer)
		end
	end
	f2_arg1:appendEventHandler("register_focusable_element", f2_local1)
	f2_arg1:appendEventHandler("unregister_focusable_element", f2_local1)
	CoD.Menu.AddButtonCallbackFunction(f2_arg0, f2_arg1, f2_arg2, Enum.LUIButton[@"lui_key_up"], "ui_navup", function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		if not f5_arg0.m_disableNavigation and (not (not f2_arg1.dpadDisabled or not IsDpadButton(f5_arg3)) or f2_arg1:navigateItemUp(f2_local0)) then
			return true
		else
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f2_arg0, f2_arg1, f2_arg2, Enum.LUIButton[@"lui_key_down"], "ui_navdown", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		if not f6_arg0.m_disableNavigation and (not (not f2_arg1.dpadDisabled or not IsDpadButton(f6_arg3)) or f2_arg1:navigateItemDown(f2_local0)) then
			return true
		else
		end
	end)
end
CoD.ScorestreakInGameUtility.SetScorestreakSelectedSlot = function(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0:getModel(f7_arg1, "rewardSlot")
	local f7_local1 = f7_local0 and f7_local0:get()
	if f7_local1 then
		Engine.ActionSlotSelectWeapon(f7_arg1, f7_local1)
	else
		Engine.ActionSlotSelectWeapon(f7_arg1, -1)
	end
	local f7_local2 = Engine.GetModelForController(f7_arg1)
	local f7_local3 = f7_local2.hudItems.currentHCStreakName
	local f7_local4 = f7_local3
	f7_local3 = f7_local3.set
	local f7_local5 = f7_arg0:getModel()
	f7_local3(f7_local4, f7_local5.rewardName:get())
end
CoD.ScorestreakInGameUtility.UpdateScorestreakArrowState = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = f8_arg0:getModel(f8_arg2, "arrowState")
	if not f8_local0 then
		return
	end
	local f8_local1 = false
	local f8_local2 = false
	local f8_local3 = true
	for f8_local7, f8_local8, f8_local9 in f8_arg1:forEachElement() do
		if f8_local9 == f8_arg0 then
			f8_local3 = false
		end
		if f8_local9.currentState == f8_arg3 then
			if f8_local3 then
				f8_local1 = true
			else
				f8_local2 = true
			end
		end
	end
	f8_local4 = CoD.ScorestreakInGameUtility.ArrowState.NONE
	if f8_local1 and f8_local2 then
		f8_local4 = CoD.ScorestreakInGameUtility.ArrowState.BOTH
	elseif f8_local1 then
		f8_local4 = CoD.ScorestreakInGameUtility.ArrowState.UP
	elseif f8_local2 then
		f8_local4 = CoD.ScorestreakInGameUtility.ArrowState.DOWN
	end
	f8_local0:set(f8_local4)
end
CoD.ScorestreakInGameUtility.InitScorestreakUpdateListener = function(f9_arg0, f9_arg1, f9_arg2)
	f9_arg0:registerEventHandler("scorestreak_state_update", function(element, event)
		for f10_local3, f10_local4, f10_local5 in f9_arg0:forEachElement() do
			if f10_local5.currentState == f9_arg2 then
				CoD.ScorestreakInGameUtility.UpdateScorestreakArrowState(f10_local5, f9_arg0, f9_arg1, f9_arg2)
			end
		end
	end)
end
CoD.ScorestreakInGameUtility.EarningTowardsThisScorestreak = function(f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1:getModel()
	local f11_local1 = Engine.GetModelForController(f11_arg0)
	local f11_local2 = Engine.GetModel(f11_local1, "rewardMomentum")
	local f11_local3 = Engine.GetModel(f11_local0, "momentumCost")
	local f11_local4 = Engine.GetModel(f11_local1, "killstreaks")
	if not f11_local3 or not f11_local2 or not f11_local4 then
		return false
	end
	local f11_local5 = f11_local3:get()
	local f11_local6 = f11_local2:get()
	if f11_local6 == nil or f11_local5 == nil or f11_local5 < f11_local6 then
		return false
	end
	for f11_local7 = 0, CoD.ScorestreakSelectUtility.GetMaxAllowedScorestreaks(), 1 do
		local f11_local10 = CoD.SafeGetModelValue(f11_local4, "killstreak" .. f11_local7 .. ".momentumCost")
		local f11_local11 = CoD.SafeGetModelValue(f11_local4, "killstreak" .. f11_local7 .. ".rewardImage")
		if f11_local10 and f11_local6 < f11_local10 then
			return f11_local11 == f11_local0.rewardImage:get()
		end
	end
	return false
end
CoD.ScorestreakInGameUtility.ScorestreakIsUsable = function(f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1:getModel()
	f12_local0 = f12_local0.rewardImage:get()
	local f12_local1 = Engine.GetModel(Engine.GetModelForController(f12_arg0), "killstreaks")
	return f12_local0 == f12_local1.killstreak3.rewardImage:get()
end
CoD.ScorestreakInGameUtility.IsScorestreakDiscountActive = function(f13_arg0)
	if IsMultiplayer() then
		return (Engine[@"hash_4330A0AE3BC3A6E9"](f13_arg0) or 1) < 0.99
	else
		return false
	end
end
DataSources.HealthBoostPlayerList = {
	friendlyCount = 6,
	clientSort = function(f14_arg0, f14_arg1)
		if f14_arg0.currentHealth ~= f14_arg1.currentHealth then
			return f14_arg0.currentHealth < f14_arg1.currentHealth
		else
			return f14_arg0.clientNum < f14_arg1.clientNum
		end
	end,
	prepare = function(f15_arg0, f15_arg1, f15_arg2)
		local f15_local0 = nil
		f15_arg1.clients = {}
		local f15_local1 = Engine.GetModelForController(f15_arg0)
		if CoD.IsShoutcaster(f15_arg0) then
			local f15_local2 = Engine.GetModel(f15_local1, "deadSpectator.playerIndex")
			f15_local0 = f15_local2:get()
		else
			f15_local0 = Engine.GetClientNum(f15_arg0)
		end
		local f15_local2 = Engine.GetTeamID(f15_arg0, f15_local0)
		for f15_local9, f15_local10 in pairs(Engine[@"hash_F9C4C8A66F9CB02"](f15_arg0)) do
			if f15_local2 == f15_local10 and f15_local9 ~= f15_local0 then
				local f15_local6 = Engine[@"getmodelforclient"](f15_local9)
				if f15_local6.health then
					local f15_local7 = f15_local6.health.healthValue
					local f15_local8 = f15_local6.health.healthValue:get()
				end
				table.insert(f15_arg1.clients, {
					clientNum = f15_local9,
					currentHealth = f15_local7 and f15_local8 or 0,
				})
			end
		end
		while #f15_arg1.clients < DataSources.HealthBoostPlayerList.friendlyCount - 1 do
			table.insert(f15_arg1.clients, {
				clientNum = -1,
				currentHealth = 0,
			})
		end
		table.sort(f15_arg1.clients, DataSources.HealthBoostPlayerList.clientSort)
		f15_arg1.clients[DataSources.HealthBoostPlayerList.friendlyCount] = {
			clientNum = f15_local0,
			currentHealth = 0,
		}
		if not f15_arg1.clientCountSubscription then
			f15_local4 = f15_arg1
			f15_local3 = f15_arg1.subscribeToModel
			f15_local5 = Engine.GetModelForController(f15_arg0)
			f15_arg1.clientCountSubscription = f15_local3(f15_local4, f15_local5:create("Clients.clientCount"), function()
				f15_arg1:updateDataSource(true, true)
			end, false)
		end
		if not f15_arg1.clientChangedTeamSubscription then
			f15_local4 = f15_arg1
			f15_local3 = f15_arg1.subscribeToModel
			f15_local5 = Engine.GetModelForController(f15_arg0)
			f15_arg1.clientChangedTeamSubscription = f15_local3(f15_local4, f15_local5:create("Clients.clientChangedTeam"), function()
				f15_arg1:updateDataSource(true, true)
			end, false)
		end
	end,
	getCount = function(f18_arg0)
		return #f18_arg0.clients
	end,
	getItem = function(f19_arg0, f19_arg1, f19_arg2)
		if f19_arg1.clients[f19_arg2] and f19_arg1.clients[f19_arg2].clientNum then
			return Engine[@"getmodelforclient"](f19_arg1.clients[f19_arg2].clientNum)
		else
			return Engine[@"getmodelforclient"](-1)
		end
	end,
}
