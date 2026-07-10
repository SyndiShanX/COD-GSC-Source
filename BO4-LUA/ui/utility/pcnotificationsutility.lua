CoD.PCNotificationsUtility = {}
CoD.PCNotificationsUtility.NOTIFICATION_DURATION = Engine[0xB967FCFEEBA55D]()
CoD.PCNotificationsUtility.COOLDOWN_NOTIFICATION_CHECK = 1
CoD.PCNotificationsUtility.NotificationType = {
	UNKNOWN = {
		id = 0,
		appearStringHash = @"hash_0",
		acceptStringHash = @"hash_0",
		declineStringHash = @"hash_0",
		timeoutStringHash = @"hash_0",
	},
	PARTY = {
		id = 1,
		appearStringHash = @"hash_131321BF4043DCB5",
		acceptStringHash = @"hash_2D31E3DAE77119F7",
		declineStringHash = @"hash_6800F381ED7D3D20",
		timeoutStringHash = @"hash_4D34D861A52CB5AE",
	},
	FRIEND = {
		id = 2,
		appearStringHash = @"hash_CAD0D75E6830A9B",
		acceptStringHash = @"hash_0",
		declineStringHash = @"hash_36319CDC4EB1032",
	},
}
CoD.PCNotificationsUtility.MockupData = {}
CoD.PCNotificationsUtility.MockupDataFriends = {}
DataSources.CurrentNotification = {
	prepare = function(f1_arg0)
		local f1_local0 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f1_arg0), "PC.CurrentNotification")
		local f1_local1 = Engine[@"createmodel"](f1_local0, "notificationEvent")
		f1_local1:set("")
		f1_local1 = Engine[@"createmodel"](f1_local0, "inviteResponseEvent")
		f1_local1:set("")
		f1_local1 = Engine[@"createmodel"](f1_local0, "visibility")
		f1_local1:set(false)
		f1_local1 = Engine[@"createmodel"](f1_local0, "hideNotificationsTimestamp")
		f1_local1:set(Engine[@"milliseconds"]() - CoD.PCNotificationsUtility.NOTIFICATION_DURATION * 1000)
		f1_local1 = Engine[@"createmodel"](f1_local0, "chooseOffDurationStateVisible")
		f1_local1:set(false)
		f1_local1 = Engine[@"createmodel"](f1_local0, "type")
		f1_local1:set(0)
		f1_local1 = Engine[@"createmodel"](f1_local0, "senderXuid")
		f1_local1:set(nil)
		f1_local1 = Engine[@"createmodel"](f1_local0, "senderGamertag")
		f1_local1:set("")
		f1_local1 = Engine[@"createmodel"](f1_local0, "requestIndex")
		f1_local1:set(0)
		f1_local1 = Engine[@"createmodel"](f1_local0, "remainingTime")
		f1_local1:set(0)
		f1_local1 = Engine[@"createmodel"](f1_local0, "timestamp")
		f1_local1:set(0)
		return f1_local0
	end,
	getModel = function(f2_arg0)
		local f2_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f2_arg0), "PC.CurrentNotification")
		if f2_local0 == nil then
			return DataSources.CurrentNotification.prepare(f2_arg0)
		else
			return f2_local0
		end
	end,
}
local f0_local0 = function(f3_arg0, f3_arg1)
	local f3_local0 = Engine[@"hash_592F1FB0C7454E9C"](f3_arg0)
	local f3_local1 = {}
	if #f3_local0 > 0 then
		for f3_local5, f3_local6 in pairs(f3_local0) do
			if f3_arg1 < f3_local6.timestamp then
				table.insert(f3_local1, {
					gamertag = f3_local6.gamertag,
					xuid = f3_local6.xuid,
					timestamp = f3_local6.timestamp,
				})
			end
		end
	end
	return f3_local1
end
local f0_local1 = function(f4_arg0, f4_arg1)
	if #CoD.PCNotificationsUtility.MockupData == 0 then
		local f4_local0 = Engine[@"getfriends"](f4_arg0)
		if #f4_local0 > 0 then
			local f4_local1 = 0
			for f4_local5, f4_local6 in pairs(f4_local0) do
				local f4_local7 = Engine[@"getplayerinfo"](f4_arg0, f4_local6.xuid)
				table.insert(CoD.PCNotificationsUtility.MockupData, {
					xuid = f4_local6.xuid,
					timestamp = Engine[@"milliseconds"]() + f4_local1 * 10,
					gamertag = f4_local6.gamertag,
				})
				f4_local1 = f4_local1 + 1
			end
		end
	else
		table.remove(CoD.PCNotificationsUtility.MockupData, 1)
	end
	return CoD.PCNotificationsUtility.MockupData
end
local f0_local2 = function(f5_arg0, f5_arg1)
	local f5_local0 = Engine[@"hash_23841AB6604548A6"]()
	local f5_local1 = {}
	if #f5_local0 > 0 then
		local f5_local2 = 0
		local f5_local3 = 0
		for f5_local7, f5_local8 in pairs(f5_local0) do
			f5_local3 = Engine[@"hash_7C2FD1248BB2B850"](f5_local8.timestamp) * 1000
			if f5_arg1 < f5_local3 then
				table.insert(f5_local1, {
					gamertag = f5_local8.gamertag,
					timestamp = f5_local3,
					requestIndex = f5_local8.requestIndex,
				})
				f5_local2 = f5_local2 + 1
			end
		end
	end
	return f5_local1
end
local f0_local3 = function(f6_arg0, f6_arg1)
	if #CoD.PCNotificationsUtility.MockupDataFriends == 0 then
		local f6_local0 = Engine[@"getfriends"](f6_arg0)
		if #f6_local0 > 0 then
			local f6_local1 = 0
			for f6_local5, f6_local6 in pairs(f6_local0) do
				local f6_local7 = Engine[@"getplayerinfo"](f6_arg0, f6_local6.xuid)
				table.insert(CoD.PCNotificationsUtility.MockupDataFriends, {
					gamertag = f6_local6.gamertag,
					timestamp = Engine[@"milliseconds"]() + f6_local1 * 10,
					requestIndex = f6_local1,
				})
				f6_local1 = f6_local1 + 1
			end
		end
	else
		table.remove(CoD.PCNotificationsUtility.MockupDataFriends, 1)
	end
	return CoD.PCNotificationsUtility.MockupDataFriends
end
local f0_local4 = function(f7_arg0, f7_arg1)
	local f7_local0 = DataSources.CurrentNotification.getModel(f7_arg1)
	if f7_local0.visibility:get() then
		local f7_local1 = (f7_local0.timestamp:get() + CoD.PCNotificationsUtility.NOTIFICATION_DURATION * 1000 - Engine[@"milliseconds"]()) / 1000
		local f7_local2
		if f7_local1 < 0 then
			f7_local2 = 0
			if not f7_local2 then
			else
				return f7_local2
			end
		end
		f7_local2 = f7_local1
	else
		return 0
	end
end
local f0_local5 = function(f8_arg0)
	for f8_local3, f8_local4 in pairs(CoD.PCNotificationsUtility.NotificationType) do
		if f8_local4.id == f8_arg0 then
			return f8_local4
		end
	end
	return CoD.PCNotificationsUtility.NotificationType.UNKNOWN
end
local f0_local6 = function(f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = DataSources.CurrentNotification.getModel(f9_arg1)
	local f9_local1 = f9_local0.hideNotificationsTimestamp:get()
	local f9_local2 = {}
	if Engine[@"getprofilevarint"](f9_arg1, @"show_party_notifications") ~= 0 then
		if IsBooleanDvarSet("ui_fakeInviteData") then
			local f9_local3 = f0_local1(f9_arg1, f9_local1)
		end
		f9_local2 = f9_local3 or f0_local0(f9_arg1, f9_local1)
	end
	if #f9_local2 > 0 and f9_arg2 then
		local f9_local4 = f9_local2[1]
		local f9_local5 = CoD.PCNotificationsUtility.NotificationType.PARTY.id
		f9_local0.type:set(f9_local5)
		f9_local0.senderXuid:set(f9_local4.xuid)
		f9_local0.senderGamertag:set(f9_local4.gamertag)
		f9_local0.requestIndex:set(f9_local4.requestIndex)
		f9_local0.timestamp:set(Engine[@"milliseconds"]())
		f9_local0.visibility:set(true)
		f9_local0.hideNotificationsTimestamp:set(f9_local4.timestamp)
		f9_local0.remainingTime:set(f0_local4(f9_local0, f9_arg1))
		f9_arg0.quickTimerActivated = true
		f9_arg0:playSound("menu_open", f9_arg1)
		local f9_local6 = CoD.PCUtility.ShowGameEvent
		local f9_local7 = Engine[@"localize"]
		local f9_local8 = f0_local5(f9_local5)
		f9_local6(f9_local7(f9_local8.appearStringHash, CoD.SocialUtility.CleanGamerTag(f9_local4.gamertag)))
		CoD.PCUtility.FlashWindowDefault()
	else
		local f9_local4 = {}
		if Engine[@"getprofilevarint"](f9_arg1, @"show_friends_notifications") ~= 0 then
			if IsBooleanDvarSet("ui_fakeFriendsInviteData") then
				local f9_local9 = f0_local3(f9_arg1, f9_local1)
			end
			f9_local4 = f9_local9 or f0_local2(f9_arg1, f9_local1)
		end
		if #f9_local4 > 0 then
			local f9_local5 = f9_local4[1]
			local f9_local6 = CoD.PCNotificationsUtility.NotificationType.FRIEND.id
			f9_local0.type:set(f9_local6)
			f9_local0.senderXuid:set(nil)
			f9_local0.senderGamertag:set(f9_local5.gamertag)
			f9_local0.requestIndex:set(f9_local5.requestIndex)
			f9_local0.timestamp:set(Engine[@"milliseconds"]())
			f9_local0.visibility:set(true)
			f9_local0.hideNotificationsTimestamp:set(f9_local5.timestamp)
			f9_local0.remainingTime:set(f0_local4(f9_local0, f9_arg1))
			f9_arg0.quickTimerActivated = true
			f9_arg0:playSound("menu_open", f9_arg1)
			local f9_local7 = CoD.PCUtility.ShowGameEvent
			local f9_local8 = Engine[@"localize"]
			local f9_local10 = f0_local5(f9_local6)
			f9_local7(f9_local8(f9_local10.appearStringHash, CoD.SocialUtility.CleanGamerTag(f9_local5.gamertag)))
			CoD.PCUtility.FlashWindowDefault()
		else
			f9_arg0.quickTimerActivated = false
			f9_local0.visibility:set(false)
			f9_local0.type:set(0)
			f9_local0.senderXuid:set(nil)
			f9_local0.senderGamertag:set("")
			f9_local0.requestIndex:set(0)
			f9_local0.timestamp:set(0)
			f9_local0.remainingTime:set(0)
		end
	end
end
CoD.PCNotificationsUtility.AutoCancelOldPartyInvites = function(f10_arg0)
	local f10_local0 = Engine[@"hash_592F1FB0C7454E9C"](f10_arg0)
	if #f10_local0 > 0 then
		local f10_local1 = Engine[@"milliseconds"]()
		local f10_local2 = DataSources.CurrentNotification.getModel(f10_arg0)
		local f10_local3 = f10_local2.type:get()
		local f10_local4 = f10_local2.senderXuid:get()
		for f10_local11, f10_local12 in pairs(f10_local0) do
			if f10_local12.timestamp + CoD.PCNotificationsUtility.NOTIFICATION_DURATION * 1000 < f10_local1 and (f10_local3 ~= CoD.PCNotificationsUtility.NotificationType.PARTY.id or f10_local4 ~= f10_local12.xuid) then
				Engine[@"hash_6E7B086418037B6F"](f10_arg0, f10_local12.xuid, Enum[@"hash_12E338C10A793F0C"][@"hash_2302E5C8D977EF94"])
				local f10_local8 = CoD.PCUtility.ShowGameEvent
				local f10_local9 = Engine[@"localize"]
				local f10_local10 = f0_local5(f10_local3)
				f10_local8(f10_local9(f10_local10.timeoutStringHash))
			end
		end
	end
end
CoD.PCNotificationsUtility.CancelAllPartyInvites = function(f11_arg0)
	local f11_local0 = Engine[@"hash_592F1FB0C7454E9C"](f11_arg0)
	if #f11_local0 > 0 then
		for f11_local4, f11_local5 in pairs(f11_local0) do
			Engine[@"hash_1AA762AFC32A0F8D"](f11_arg0, f11_local5.xuid)
		end
	end
end
local f0_local7 = function(f12_arg0, f12_arg1)
	local f12_local0 = Engine[@"hash_250DB05DAB6E91C2"]()
	if f12_local0 then
		CoD.PCNotificationsUtility.AutoCancelOldPartyInvites(f12_arg1)
	else
		Engine[@"hash_5B0CD10D545EABFC"](f12_arg1, CoD.PCNotificationsUtility.COOLDOWN_NOTIFICATION_CHECK * 1000)
	end
	if CoD.PCNotificationsUtility.IsNotificationCurrentlyHidden(f12_arg1) then
		return
	end
	local f12_local1 = DataSources.CurrentNotification.getModel(f12_arg1)
	if not f12_local1.visibility:get() then
		f0_local6(f12_arg0, f12_arg1, f12_local0)
	end
end
local f0_local8 = function(f13_arg0, f13_arg1)
	local f13_local0 = DataSources.CurrentNotification.getModel(f13_arg1)
	if f13_local0.visibility:get() then
		local f13_local1 = f0_local4(f13_local0, f13_arg1)
		if f13_local1 == 0 then
			CoD.PCNotificationsUtility.CurrentNotificationTimedOut(f13_arg0, f13_arg1, f13_local0)
		else
			f13_local0.remainingTime:set(f13_local1)
		end
	elseif f13_arg0.quickTimerActivated then
		f13_arg0.quickTimerActivated = false
	end
end
CoD.PCNotificationsUtility.UpdateNotifToSafeArea = function(f14_arg0, f14_arg1)
	local f14_local0, f14_local1, f14_local2, f14_local3 = Engine[@"getusersafeareaforcontroller"](f14_arg1, true)
	local f14_local4, f14_local5, f14_local6, f14_local7 = f14_arg0:getLocalRect()
	local f14_local8, f14_local9 = Engine[@"getscreensize"](f14_arg1)
	local f14_local10, f14_local11, f14_local12 = Engine[@"hash_6913E41040C17FD"](f14_arg1)
	f14_arg0:setLeftRight(false, false, f14_local2 - f14_local6 - f14_local4 - 25, f14_local2 - 25)
end
CoD.PCNotificationsUtility.PreSetupNotificationWidget = function(f15_arg0, f15_arg1, f15_arg2)
	DataSources.CurrentNotification.prepare(f15_arg2)
	CoD.PCUtility.RegisterStickyElement(f15_arg0, f15_arg1)
	if not CoD.isFrontend then
		f15_arg0:appendEventHandler("update_safe_area", function(f16_arg0, f16_arg1)
			CoD.PCNotificationsUtility.UpdateNotifToSafeArea(f16_arg0, f15_arg2)
		end)
		CoD.PCNotificationsUtility.UpdateNotifToSafeArea(f15_arg0, f15_arg2)
	end
end
CoD.PCNotificationsUtility.AcceptCurrentInvite = function(f17_arg0, f17_arg1)
	local f17_local0 = DataSources.CurrentNotification.getModel(f17_arg1)
	local f17_local1 = f17_local0.type:get()
	if f17_local1 == CoD.PCNotificationsUtility.NotificationType.PARTY.id then
		local f17_local2 = f17_local0.senderXuid:get()
		if LobbyQuickJoinWithXuid(f17_arg0, f17_arg1, f17_local2) then
			Engine[@"hash_6E7B086418037B6F"](f17_arg1, f17_local2, Enum[@"hash_12E338C10A793F0C"][@"hash_28B7FB4BFD13E7FD"])
			CoD.PCNotificationsUtility.CancelAllPartyInvites(f17_arg1)
			local f17_local3 = CoD.PCUtility.ShowGameEvent
			local f17_local4 = Engine[@"localize"]
			local f17_local5 = f0_local5(f17_local1)
			f17_local3(f17_local4(f17_local5.acceptStringHash))
		else
			LuaUtils.UI_ShowErrorMessageDialog(f17_arg1, @"menu/join_result_not_joinable")
			f17_local0.visibility:set(false)
			return
		end
	elseif f17_local1 == CoD.PCNotificationsUtility.NotificationType.FRIEND.id then
		CoD.PCUtility.AcceptFriendRequestWrapper(f17_local0.requestIndex:get())
	end
	f17_local0.visibility:set(false)
end
CoD.PCNotificationsUtility.DeclineCurrentInvite = function(f18_arg0)
	local f18_local0 = DataSources.CurrentNotification.getModel(f18_arg0)
	local f18_local1 = f18_local0.type:get()
	if f18_local1 == CoD.PCNotificationsUtility.NotificationType.PARTY.id then
		Engine[@"hash_6E7B086418037B6F"](f18_arg0, f18_local0.senderXuid:get(), Enum[@"hash_12E338C10A793F0C"][@"hash_498C8DC20F909A0F"])
	elseif f18_local1 == CoD.PCNotificationsUtility.NotificationType.FRIEND.id then
		Engine[@"hash_21AE51B8C2493C18"](f18_local0.requestIndex:get())
	end
	f18_local0.visibility:set(false)
	local f18_local2 = CoD.PCUtility.ShowGameEvent
	local f18_local3 = Engine[@"localize"]
	local f18_local4 = f0_local5(f18_local1)
	f18_local2(f18_local3(f18_local4.declineStringHash))
end
CoD.PCNotificationsUtility.CurrentNotificationTimedOut = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = f19_arg2.type:get()
	if f19_local0 == CoD.PCNotificationsUtility.NotificationType.PARTY.id then
		Engine[@"hash_6E7B086418037B6F"](f19_arg1, f19_arg2.senderXuid:get(), Enum[@"hash_12E338C10A793F0C"][@"hash_2302E5C8D977EF94"])
		local f19_local1 = CoD.PCUtility.ShowGameEvent
		local f19_local2 = Engine[@"localize"]
		local f19_local3 = f0_local5(f19_local0)
		f19_local1(f19_local2(f19_local3.timeoutStringHash))
	elseif f19_local0 == CoD.PCNotificationsUtility.NotificationType.FRIEND.id then
	else
	end
	local f19_local4 = DataSources.CurrentNotification.getModel(f19_arg1)
	f19_local4.visibility:set(false)
	f19_local4.chooseOffDurationStateVisible:set(false)
end
CoD.PCNotificationsUtility.PrepareNotificationContainer = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	f20_arg0.refreshNotificationsTimer = LUI.UITimer.newElementTimer(CoD.PCNotificationsUtility.COOLDOWN_NOTIFICATION_CHECK * 1000, false, function(f21_arg0)
		f0_local7(f20_arg0, f20_arg1)
	end)
	f20_arg0:addElement(f20_arg0.refreshNotificationsTimer)
	f20_arg0.quickRefreshNotificationTimer = LUI.UITimer.newElementTimer(100, false, function(f22_arg0)
		if f20_arg0.quickTimerActivated then
			f0_local8(f20_arg0, f20_arg1)
		end
	end)
	f20_arg0:addElement(f20_arg0.quickRefreshNotificationTimer)
	CoD.Menu.AddButtonCallbackFunction(f20_arg2, f20_arg3.KeyPrompts.KeyPromptAccept, f20_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, f23_arg3)
		if CoD.PCNotificationsUtility.IsNotificationWidgetVisible(controller) then
			CoD.PCNotificationsUtility.AcceptCurrentInvite(menu, controller)
			return true
		else
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f20_arg2, f20_arg3.KeyPrompts.KeyPromptDecline, f20_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, f24_arg3)
		if CoD.PCNotificationsUtility.IsNotificationWidgetVisible(controller) then
			CoD.PCNotificationsUtility.DeclineCurrentInvite(controller)
			return true
		else
		end
	end)
	local f20_local0 = f20_arg0
	local f20_local1 = f20_arg0.subscribeToModel
	local f20_local2 = DataSources.CurrentNotification.getModel(f20_arg1)
	f20_local1(f20_local0, f20_local2.notificationEvent, function(f25_arg0)
		for f25_local4, f25_local5 in pairs(Engine[@"hash_4BAB20DE2C57A68A"](f20_arg1)) do
			if f25_local5.notifSubType == Enum[@"hash_12E338C10A793F0C"][@"hash_33C49BDD8B9BD217"] then
				local f25_local3 = DataSources.CurrentNotification.getModel(f20_arg1)
				if f25_local3.type:get() == CoD.PCNotificationsUtility.NotificationType.PARTY.id and f25_local3.senderXuid:get() == f25_local5.senderXuid then
					f25_local3.visibility:set(false)
				end
			end
			if f25_local5.notifSubType == Enum[@"hash_12E338C10A793F0C"][@"hash_28B7FB4BFD13E7FD"] then
				CoD.PCUtility.ShowGameEventFromEnum(CoD.PCUtility.GameEventStrings.PARTY_INVITE_ACCEPTED)
			end
			if f25_local5.notifSubType == Enum[@"hash_12E338C10A793F0C"][@"hash_498C8DC20F909A0F"] then
				CoD.PCUtility.ShowGameEventFromEnum(CoD.PCUtility.GameEventStrings.PARTY_INVITE_DISMISS)
			end
			if f25_local5.notifSubType == Enum[@"hash_12E338C10A793F0C"][@"hash_2302E5C8D977EF94"] then
				CoD.PCUtility.ShowGameEventFromEnum(CoD.PCUtility.GameEventStrings.PARTY_INVITE_TIMEOUT)
			end
		end
	end, false)
	f20_local0 = f20_arg0
	f20_local1 = f20_arg0.subscribeToModel
	f20_local2 = DataSources.CurrentNotification.getModel(f20_arg1)
	f20_local1(f20_local0, f20_local2.inviteResponseEvent, function(f26_arg0, f26_arg1)
		if CoD.PCNotificationsUtility.IsNotificationWidgetVisible(f20_arg1) then
			if f26_arg0:get() == "accept" then
				CoD.PCNotificationsUtility.AcceptCurrentInvite(f26_arg1, f20_arg1)
			else
				CoD.PCNotificationsUtility.DeclineCurrentInvite(f20_arg1)
			end
		end
	end, false)
end
CoD.PCNotificationsUtility.RemainingTimePercentage = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4)
	return f0_local4(DataSources.CurrentNotification.getModel(f27_arg0), f27_arg0) / CoD.PCNotificationsUtility.NOTIFICATION_DURATION, f27_arg2, f27_arg3, f27_arg4
end
CoD.PCNotificationsUtility.IsNotificationWidgetVisible = function(f28_arg0)
	local f28_local0 = DataSources.CurrentNotification.getModel(f28_arg0)
	return f28_local0.visibility:get()
end
CoD.PCNotificationsUtility.HideNotificationWidget = function(f29_arg0)
	local f29_local0 = DataSources.CurrentNotification.getModel(f29_arg0)
	f29_local0.visibility:set(false)
end
CoD.PCNotificationsUtility.HideNotificationWidgetWithDuration = function(f30_arg0, f30_arg1)
	local f30_local0 = DataSources.CurrentNotification.getModel(f30_arg0)
	f30_local0.hideNotificationsTimestamp:set(Engine[@"milliseconds"]() + f30_arg1 * 1000)
	f30_local0.visibility:set(false)
end
CoD.PCNotificationsUtility.IsNotificationCurrentlyHidden = function(f31_arg0)
	local f31_local0 = DataSources.CurrentNotification.getModel(f31_arg0)
	local f31_local1 = f31_local0.hideNotificationsTimestamp:get()
	local f31_local2
	if f31_local1 ~= -1 and f31_local1 <= Engine[@"milliseconds"]() then
		f31_local2 = false
	else
		f31_local2 = true
	end
	return f31_local2
end
CoD.PCNotificationsUtility.HideNotificationWidgetForSession = function(f32_arg0)
	local f32_local0 = DataSources.CurrentNotification.getModel(f32_arg0)
	f32_local0.hideNotificationsTimestamp:set(-1)
	f32_local0.visibility:set(false)
end
CoD.PCNotificationsUtility.SetChooseOffDurationStateVisibility = function(f33_arg0, f33_arg1)
	local f33_local0 = DataSources.CurrentNotification.getModel(f33_arg0)
	f33_local0.chooseOffDurationStateVisible:set(f33_arg1)
end
CoD.PCNotificationsUtility.IsChooseOffDurationStateVisible = function(f34_arg0)
	local f34_local0 = DataSources.CurrentNotification.getModel(f34_arg0)
	return f34_local0.chooseOffDurationStateVisible:get()
end
CoD.PCNotificationsUtility.IsCurrentInviteFromType = function(f35_arg0, f35_arg1)
	local f35_local0 = DataSources.CurrentNotification.getModel(f35_arg0)
	return f35_local0.type:get() == f35_arg1
end
CoD.PCNotificationsUtility.HideNotificationWidgetInLoadingWZ = function()
	return IsBooleanDvarSet(@"hash_41D01AF0AFACBDF3")
end
