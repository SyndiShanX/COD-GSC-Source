require("x64:53e8db3768fb02a")
require("x64:3050b56bc941c17")
require("x64:2f7767db3f402c")
require("x64:d0f84a2d7d94ca3")
require("x64:b370b3af9224bd0")
Lobby.Clans = {}
Lobby.Clans.data = {}
Lobby.Clans.DEFAULT_GROUP_KIND = 1
Lobby.Clans.DATA_STATUS = {
	NOT_NEEDED = "NOT_NEEDED",
	NOT_FETCHED = "NOT_FETCHED",
	FETCHED = "FETCHED",
	REFETCH_REQUEST = "REFETCH_REQUEST",
}
Lobby.Clans.ClanAction = {
	GO_BACK = "go_back",
}
local f0_local0 = 100
local f0_local1 = "membership_info"
local f0_local2 = "friends_membership_info"
local f0_local3 = "membership_proposals_user"
local f0_local4 = "membership_proposals_group"
local f0_local5 = "group_details"
local f0_local6 = "clan_members"
local f0_local7 = "group_action"
Lobby.Clans.REFETCHABLE_TASKS = {
	[f0_local1] = {
		taskDefault = Lobby.Clans.DATA_STATUS.NOT_FETCHED,
	},
	[f0_local2] = {
		taskDefault = Lobby.Clans.DATA_STATUS.NOT_NEEDED,
	},
	[f0_local3] = {
		taskDefault = Lobby.Clans.DATA_STATUS.NOT_NEEDED,
	},
	[f0_local4] = {
		taskDefault = Lobby.Clans.DATA_STATUS.NOT_NEEDED,
	},
	[f0_local6] = {
		taskDefault = Lobby.Clans.DATA_STATUS.NOT_NEEDED,
	},
	[f0_local5] = {
		taskDefault = Lobby.Clans.DATA_STATUS.NOT_NEEDED,
	},
}
Lobby.Clans.GROUP_ACTION = {
	CREATE = 1,
	UPDATE = 2,
	REMOVE = 3,
	JOIN = 4,
	ADD_OR_UPDATE = 5,
	INVITE = 6,
	ACCEPT_REQUEST = 7,
	REJECT_REQUEST = 8,
	FIND_GROUPS = 9,
}
local f0_local8 = function(f1_arg0, f1_arg1, f1_arg2)
	return f1_arg0[f1_arg1].fetchStatus == f1_arg2
end
Lobby.Clans.InitClanDataForController = function(f2_arg0)
	local f2_local0 = Engine[0x93B19E01B1FD1C7](f2_arg0)
	local f2_local1 = Engine[0x5065E759595C457](f2_local0)
	local f2_local2 = {
		controller = f2_arg0,
		xuid = f2_local0,
		xuidStr = f2_local1,
		liveBackoff = Engine[0xBDF857C8ED1376B](10, 3, 2, true),
	}
	local f2_local3 = function(f3_arg0)
		return {
			fetchInit = false,
			fetchStatus = f3_arg0,
			fetchedTime = 0,
			liveBackoff = Engine[0xBDF857C8ED1376B](10, 3, 2, true),
			data = {},
		}
	end
	local f2_local4 = function()
		return {
			process = false,
			liveBackoff = Engine[0xBDF857C8ED1376B](10, 3, 2, true),
			data = {},
		}
	end
	for f2_local8, f2_local9 in pairs(Lobby.Clans.REFETCHABLE_TASKS) do
		f2_local2[f2_local8] = f2_local3(f2_local9.taskDefault)
	end
	f2_local2[f0_local2].list = {}
	Lobby.Clans.InitFetchGroups(f2_local2)
	f2_local2[f0_local7] = f2_local4()
	Lobby.Clans.data[f2_local1] = f2_local2
	return Lobby.Clans.data[f2_local1]
end
Lobby.Clans.InitFetchGroups = function(f5_arg0)
	f5_arg0[f0_local5].groupTablesCreated = false
	f5_arg0[f0_local5].groupTables = {}
	f5_arg0[f0_local5].groupTableIndex = 1
end
Lobby.Clans.Pump = function(f6_arg0)
	if not Dvar[0xCA8E9EDE02C25E6]:get() then
		return
	elseif Engine[0x7B48C1ABFF0F764]() or Engine[0xE39F1F30B306065]() or Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] or not Engine[0xFD9E0D91D366130]() then
		return
	end
	for f6_local14, f6_local15 in pairs(Lobby.Clans.data) do
		local f6_local16 = f6_local15.controller
		if Engine[0xD7913D0F914DE47](f6_local16) then
			Lobby.Clans.CheckForDataRefetch(f6_local15)
			if f6_local15[f0_local1].fetchStatus == Lobby.Clans.DATA_STATUS.NOT_FETCHED and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x27F86ABF82F5269], f6_local16) then
				Lobby.Clans.GetMembershipsByUsers(f6_local15)
			end
			if f6_local15[f0_local2].fetchStatus == Lobby.Clans.DATA_STATUS.NOT_FETCHED and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x27F86ABF82F5269], f6_local16) then
				Lobby.Clans.GetMembershipsForFriends(f6_local15)
			end
			if f6_local15[f0_local3].fetchStatus == Lobby.Clans.DATA_STATUS.NOT_FETCHED and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0xF24C4FC86613A77], f6_local16) then
				Lobby.Clans.GetMembershipProposalsByUser(f6_local15)
			end
			if f6_local15[f0_local1].fetchStatus == Lobby.Clans.DATA_STATUS.FETCHED then
				if f6_local15[f0_local4].fetchStatus == Lobby.Clans.DATA_STATUS.NOT_FETCHED and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x83A96343789C2C7], f6_local16) then
					Lobby.Clans.GetMembershipProposalsByGroup(f6_local15)
				end
				if f6_local15[f0_local6].fetchStatus == Lobby.Clans.DATA_STATUS.NOT_FETCHED and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x77347ADE8055E9C], f6_local16) then
					Lobby.Clans.GetGroupMembers(f6_local15)
				end
			end
			if f6_local15[f0_local5].fetchStatus == Lobby.Clans.DATA_STATUS.NOT_FETCHED and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x8E32D633D0D4DE6], f6_local16) and f6_local15[f0_local1].fetchStatus == Lobby.Clans.DATA_STATUS.FETCHED and f6_local15[f0_local3].fetchStatus == Lobby.Clans.DATA_STATUS.FETCHED and f6_local15[f0_local6].fetchStatus == Lobby.Clans.DATA_STATUS.FETCHED and f6_local15[f0_local2].fetchStatus == Lobby.Clans.DATA_STATUS.FETCHED then
				if not f6_local15[f0_local5].groupTablesCreated then
					local f6_local3 = {}
					for f6_local7, f6_local8 in ipairs(f6_local15[f0_local1].data) do
						f6_local3[f6_local8.clansGroupIdentifier.IDstr] = f6_local8.clansGroupIdentifier
					end
					for f6_local7, f6_local8 in ipairs(f6_local15[f0_local3].data) do
						f6_local3[f6_local8.clansGroupIdentifier.IDstr] = f6_local8.clansGroupIdentifier
					end
					if f6_local15[f0_local6].data ~= nil then
						for f6_local7, f6_local8 in ipairs(f6_local15[f0_local6].data) do
							for f6_local9, f6_local10 in ipairs(f6_local8.clansGroupMembershipInfo) do
								f6_local3[f6_local10.clansGroupIdentifier.IDstr] = f6_local10.clansGroupIdentifier
							end
						end
					end
					for f6_local7, f6_local8 in pairs(f6_local15[f0_local2].data) do
						f6_local3[f6_local8.IDstr] = f6_local8
					end
					f6_local4 = {
						kinds = {},
						IDs = {},
						rootKinds = {},
						rootIDs = {},
					}
					f6_local5 = 1
					f6_local6 = 1
					for f6_local13, f6_local11 in pairs(f6_local3) do
						table.insert(f6_local4.kinds, f6_local11.kind)
						table.insert(f6_local4.IDs, f6_local11.ID)
						table.insert(f6_local4.rootKinds, f6_local11.rootKind)
						table.insert(f6_local4.rootIDs, f6_local11.rootID)
						f6_local6 = f6_local6 + 1
						if f6_local6 > 100 then
							f6_local6 = 1
							f6_local15[f0_local5].groupTables[f6_local5] = f6_local4
							f6_local5 = f6_local5 + 1
							f6_local4 = {
								kinds = {},
								IDs = {},
								rootKinds = {},
								rootIDs = {},
							}
						end
					end
					f6_local15[f0_local5].groupTables[f6_local5] = f6_local4
					f6_local15[f0_local5].groupTablesCreated = true
				end
				Lobby.Clans.GetGroupInfos(f6_local15)
			end
			if f6_local15[f0_local7].process then
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.CREATE and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x4B70AB52219B5AC], f6_local16) then
					Lobby.Clans.CreateGroup(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.UPDATE and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x2F172D800D65249], f6_local16) then
					Lobby.Clans.UpdateGroup(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.REMOVE and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0xCD28C4E40235DFB], f6_local16) then
					Lobby.Clans.RemoveGroupMember(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.JOIN and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x7365C66071C2B5E], f6_local16) then
					Lobby.Clans.AddOrUpdateGroupMember(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.ADD_OR_UPDATE and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x7365C66071C2B5E], f6_local16) then
					Lobby.Clans.AddOrUpdateGroupMember(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.ACCEPT_REQUEST and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x3E0CD00FDD11C0], f6_local16) then
					Lobby.Clans.AddOrUpdateGroupMember(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.INVITE and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x3E0CD00FDD11C0], f6_local16) then
					Lobby.Clans.ProposeMemberships(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.REJECT_REQUEST and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x9178AFAC78EB448], f6_local16) then
					Lobby.Clans.RemoveProposals(f6_local15)
				end
				if f6_local15[f0_local7].action == Lobby.Clans.GROUP_ACTION.FIND_GROUPS and not Engine[0xCE326D48856DEBC](Enum[0x273AD594AA15D05][0x9F9E42CFF7FF10], f6_local16) then
					Lobby.Clans.FindGroups(f6_local15)
				end
			end
		end
	end
end
Lobby.Clans.OnInit = function(f7_arg0)
	if not Dvar[0xCA8E9EDE02C25E6]:get() then
		return false
	end
	for f7_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
		if Engine[0xC3AA9424B651A7E](f7_local0) then
			Lobby.Clans.InitClanDataForController(f7_local0)
		end
	end
end
Lobby.Clans.OnChangeSigninState = function(f8_arg0)
	if not Dvar[0xCA8E9EDE02C25E6]:get() then
		return false
	elseif Lobby.Clans.data[localClientXuidStr] ~= nil and f8_arg0.onlineState ~= Enum[0x1F6577DCFF6E881][0x1675B607D4A7DAA] then
		table.remove(Lobby.Clans.data[CoDShared.GetXUID64StringForController(f8_arg0.controller)])
	else
		Lobby.Clans.InitClanDataForController(f8_arg0.controller)
	end
end
Lobby.Clans.PrintCallstack = function(f9_arg0)
	local f9_local0 = ""
	if debug and debug.traceback then
		f9_local0 = debug.traceback()
	end
	print("------------------------------------------------")
	if f9_arg0 then
		print(f9_arg0)
	end
	print(f9_local0)
	print("------------------------------------------------")
end
Lobby.Clans.PrintError = function(f10_arg0, f10_arg1)
	if not f10_arg1 then
		f10_arg1 = ""
	end
	if f10_arg0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA1C4971DA015C84], "Clan task failed. " .. f10_arg1 .. "\n")
	else
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA1C4971DA015C84], "Clan task failed: ErrorCode: " .. tostring(f10_arg0) .. ". " .. (LuaEnum.ClanErrorCodeDescriptions[f10_arg0] or "Not a Clan error, some other DW system error") .. ". " .. f10_arg1 .. "\n")
	end
	Lobby.Clans.PrintCallstack()
end
Lobby.Clans.PrintErrorToClientAndClearTaskIfNeeded = function(f11_arg0, f11_arg1, f11_arg2)
	if LuaEnum.ClanErrorCodeDescriptions[f11_arg1] then
		Lobby.Clans.ClearTask(f11_arg2)
		Engine[0xE1789115A2356E7]("open_toaster_popup", {
			toastType = "error",
			message = LuaEnum.ClanErrorCodeDescriptions[f11_arg1],
			isError = true,
			controller = f11_arg0,
			immediate = true,
		})
	end
end
Lobby.Clans.GetClanUserDataForController = function(f12_arg0)
	local f12_local0 = CoDShared.GetXUID64StringForController(f12_arg0)
	if Lobby.Clans.data[f12_local0] == nil then
		Lobby.Clans.InitClanDataForController(f12_arg0)
	end
	return Lobby.Clans.data[f12_local0]
end
Lobby.Clans.SetClanDataForController = function(f13_arg0, f13_arg1)
	Lobby.Clans.data[CoDShared.GetXUID64StringForController(f13_arg0)] = f13_arg1
end
Lobby.Clans.SetFetchedData = function(f14_arg0, f14_arg1, f14_arg2)
	f14_arg0[f14_arg1].fetchStatus = Lobby.Clans.DATA_STATUS.FETCHED
	f14_arg0[f14_arg1].fetchedTime = Engine[0x316595FEDC72451]()
	f14_arg0[f14_arg1].data = f14_arg2
end
Lobby.Clans.CheckForDataRefetch = function(f15_arg0)
	local f15_local0 = Engine[0x316595FEDC72451]()
	local f15_local1 = Dvar[0x504E380F2438452]:get()
	for f15_local8, f15_local9 in pairs(Lobby.Clans.REFETCHABLE_TASKS) do
		if f15_arg0[f15_local8].fetchStatus == Lobby.Clans.DATA_STATUS.FETCHED and f15_arg0[f15_local8].fetchedTime + f15_local1 < f15_local0 then
			local f15_local5 = f15_arg0[f15_local8]
			local f15_local6 = f15_local9.taskDefault
			local f15_local7 = Lobby.Clans.DATA_STATUS.NOT_FETCHED
			f15_local5.fetchStatus = REG11 and Lobby.Clans.DATA_STATUS.REFETCH_REQUEST or f15_local9.taskDefault
		end
	end
end
Lobby.Clans.GetClanInfoForUser = function(f16_arg0)
	if f16_arg0 == nil or f16_arg0[f0_local1].data == nil then
		return nil, nil
	end
	for f16_local3, f16_local4 in ipairs(f16_arg0[f0_local1].data) do
		if f16_local4.clansGroupIdentifier.kind == LuaEnum.CLAN_KINDS.CLAN then
			return f16_local4.clansGroupIdentifier.kind, f16_local4.clansGroupIdentifier.ID
		end
	end
	return nil, nil
end
Lobby.Clans.GetControllerClanModel = function(f17_arg0)
	local f17_local0 = Engine[0x8DF2E5447F384B9]()
	local f17_local1 = f17_local0.LobbyClients:create(f17_arg0, true)
	return f17_local1:create("clan")
end
Lobby.Clans.ClearTask = function(f18_arg0)
	f18_arg0.process = false
	f18_arg0.action = nil
end
Lobby.Clans.GetMembershipsByUsers = function(f19_arg0)
	if not Engine[0x88C82D2C4BED05](f19_arg0[f0_local1].liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f19_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.GetMembershipsByUsersComplete, {
		user = f19_arg0,
	})
	if not Engine[0xA0F0BC61EE66B5E](f19_local0, f19_arg0.controller, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, {
		f19_arg0.xuid,
	}, {}) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f19_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.GetMembershipsByUsersComplete = function(f20_arg0, f20_arg1, f20_arg2)
	local f20_local0 = f20_arg1.user
	local f20_local1 = f20_local0[f0_local1]
	if f20_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f20_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f20_local1.liveBackoff)
		Lobby.Clans.SetFetchedData(f20_local0, f0_local1, f20_arg2.clansGroupMemberInfo[1].clansGroupMembershipInfo)
		Lobby.Clans.FormatMembershipInfo(f20_local0)
		Lobby.Clans.ReadGroupMembershipFiles(f20_local0)
	elseif f20_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f20_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f20_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f20_arg2.errorCode)
	end
	return true
end
Lobby.Clans.GetMembershipsForFriends = function(f21_arg0)
	local f21_local0 = f21_arg0[f0_local2]
	local f21_local1 = f21_arg0.controller
	if not Engine[0x88C82D2C4BED05](f21_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	elseif not f21_local0.fetchInit then
		local f21_local2 = 0
		f21_local2 = Engine[0xE1E8FED08B06DF7](f21_local1)
		if f21_local2 == 0 then
			Lobby.Clans.SetFetchedData(f21_arg0, f0_local2, {})
			return
		end
		f21_local0.fetchInit = true
		f21_local0.fetchCount = f21_local2
		f21_local0.fetchOffSet = 0
	end
	local f21_local2 = {}
	if f21_local0.fetchOffSet < f21_local0.fetchCount then
		local f21_local3 = {}
		f21_local3 = Engine[0x5BC6F44500DD93D](f21_local1, f21_local0.fetchOffSet, f0_local0, Enum[0xEA28383B5DEC206][0x708B5057D80F5FF])
		f21_local0.fetchOffSet = f21_local0.fetchOffSet + f0_local0
		for f21_local7, f21_local8 in ipairs(f21_local3) do
			f21_local2[f21_local7] = f21_local8.xuid
		end
	end
	local f21_local3 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.GetMembershipsForFriendsComplete, {
		user = f21_arg0,
	})
	if not Engine[0xA0F0BC61EE66B5E](f21_local3, f21_local1, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f21_local2, {
		LuaEnum.CLAN_KINDS.CLAN,
	}) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f21_local3,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.GetMembershipsForFriendsComplete = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = f22_arg1.user
	local f22_local1 = f22_local0[f0_local2]
	if f22_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f22_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f22_local1.liveBackoff)
		if #f22_arg2.clansGroupMemberInfo > 0 then
			for f22_local5, f22_local6 in ipairs(f22_arg2.clansGroupMemberInfo) do
				if #f22_local6.clansGroupMembershipInfo > 0 then
					f22_local1.data[f22_local6.clansGroupMembershipInfo[1].clansGroupIdentifier.IDstr] = f22_local6.clansGroupMembershipInfo[1].clansGroupIdentifier
					f22_local1.list[#f22_local1.list + 1] = {
						xuid = f22_local6.userID,
						xuidStr = Engine[0x5065E759595C457](f22_local6.userID),
						IDstr = f22_local6.clansGroupMembershipInfo[1].clansGroupIdentifier.IDstr,
					}
				end
			end
		end
		if f22_local1.fetchCount <= f22_local1.fetchOffSet then
			f22_local1.fetchInit = false
			Lobby.Clans.SetFetchedData(f22_local0, f0_local2, f22_local1.data)
			Lobby.Clans.PopulateUIFriendClanModels(f22_local0)
		end
	elseif f22_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f22_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f22_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f22_arg2.errorCode)
	end
	return true
end
Lobby.Clans.GetGroupInfos = function(f23_arg0, f23_arg1)
	local f23_local0 = f23_arg0[f0_local5]
	if not Engine[0x88C82D2C4BED05](f23_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	elseif f23_local0.groupTables[f23_local0.groupTableIndex] == nil or #f23_local0.groupTables[f23_local0.groupTableIndex].kinds == 0 then
		Lobby.Clans.SetFetchedData(f23_arg0, f0_local5, {})
		Lobby.Clans.InitFetchGroups(f23_arg0)
		Lobby.Clans.PopulateUIMembershipModels(f23_arg0)
		Lobby.Clans.PopulateUIClanInfoModels(f23_arg0)
		return
	end
	local f23_local1 = f23_local0.groupTables[f23_local0.groupTableIndex]
	local f23_local2 = f23_arg0.controller
	local f23_local3 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.GetGroupInfosComplete, {
		user = f23_arg0,
	})
	if not Engine[0xD36C267A07DB296](f23_local3, f23_local2, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f23_local1.kinds, f23_local1.IDs, f23_local1.rootKinds, f23_local1.rootIDs) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f23_local3,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.GetGroupInfosComplete = function(f24_arg0, f24_arg1, f24_arg2)
	local f24_local0 = f24_arg1.user
	local f24_local1 = f24_local0[f0_local5]
	if f24_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f24_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f24_local1.liveBackoff)
		for f24_local5, f24_local6 in ipairs(f24_arg2.clansGroupInfos) do
			f24_local1.data[f24_local6.clansGroupIdentifier.IDstr] = f24_local6
		end
		f24_local1.groupTableIndex = f24_local1.groupTableIndex + 1
		if #f24_local1.groupTables < f24_local1.groupTableIndex then
			Lobby.Clans.SetFetchedData(f24_local0, f0_local5, f24_local1.data)
			Lobby.Clans.InitFetchGroups(f24_local0)
			Lobby.Clans.PopulateUIMembershipModels(f24_local0)
			Lobby.Clans.PopulateUIClanGroupInboxModels(f24_local0)
			Lobby.Clans.PopulateUIClanUserInboxModels(f24_local0)
			Lobby.Clans.PopulateUIClanInfoModels(f24_local0)
		end
	elseif f24_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f24_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f24_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f24_arg2.errorCode)
	end
	return true
end
Lobby.Clans.GetGroupMembers = function(f25_arg0)
	if not Engine[0x88C82D2C4BED05](f25_arg0[f0_local6].liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f25_local0, f25_local1 = Lobby.Clans.GetClanInfoForUser(f25_arg0)
	if f25_local0 == nil then
		Lobby.Clans.SetFetchedData(f25_arg0, f0_local6, {})
		return
	end
	local f25_local2 = f25_arg0.controller
	local f25_local3 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.GetGroupMembersComplete, {
		user = f25_arg0,
	})
	if not Engine[0x7899906EABDA3E1](f25_local3, f25_local2, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f25_local0, f25_local1, LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROOT_KIND, LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROOT_ID, LuaEnum.CLAN_OPTIONAL_PARAMETERS.XUIDS, LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROLES) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f25_local3,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.GetGroupMembersComplete = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = f26_arg1.user
	local f26_local1 = f26_local0[f0_local6]
	if f26_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f26_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f26_local1.liveBackoff)
		Lobby.Clans.SetFetchedData(f26_local0, f0_local6, f26_arg2.clansGroupMemberInfo)
		Lobby.Clans.PopulateUIClanMemberModels(f26_local0)
	elseif f26_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f26_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f26_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f26_arg2.errorCode)
	end
	return true
end
Lobby.Clans.GetMembershipProposalsByUser = function(f27_arg0)
	if not Engine[0x88C82D2C4BED05](f27_arg0[f0_local3].liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f27_local0 = f27_arg0.controller
	local f27_local1 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.GetMembershipProposalsByUserComplete, {
		user = f27_arg0,
	})
	if not Engine[0x1BBB39F76C1A04B](f27_local1, f27_local0, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f27_arg0.xuid, f27_arg0.xuid) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f27_local1,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.GetMembershipProposalsByUserComplete = function(f28_arg0, f28_arg1, f28_arg2)
	local f28_local0 = f28_arg1.user
	local f28_local1 = f28_local0[f0_local3]
	if f28_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f28_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f28_local1.liveBackoff)
		Lobby.Clans.SetFetchedData(f28_local0, f0_local3, f28_arg2.clansGroupMembershipProposals)
	elseif f28_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f28_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f28_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f28_arg2.errorCode)
	end
	return true
end
Lobby.Clans.GetMembershipProposalsByGroup = function(f29_arg0)
	local f29_local0 = f29_arg0[f0_local4]
	if not Engine[0x88C82D2C4BED05](f29_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	elseif #f29_arg0[f0_local1].data == 0 then
		Lobby.Clans.SetFetchedData(f29_arg0, f0_local4, {})
		return
	elseif not f29_local0.fetchInit then
		f29_local0.fetchCount = 0
		f29_local0.fetchList = {}
		for f29_local4, f29_local5 in ipairs(f29_arg0[f0_local1].data) do
			if f29_local5.role > Enum[0x10C0A769A29C38F][0xB17C2FE5CC7F0BC] then
				f29_local0.fetchList[f29_local0.fetchCount] = {
					kind = f29_local5.clansGroupIdentifier.kind,
					ID = f29_local5.clansGroupIdentifier.ID,
					rootKind = f29_local5.clansGroupIdentifier.rootKind,
					rootID = f29_local5.clansGroupIdentifier.rootID,
				}
				f29_local0.fetchCount = f29_local0.fetchCount + 1
			end
		end
		if f29_local0.fetchCount == 0 then
			Lobby.Clans.SetFetchedData(f29_arg0, f0_local4, {})
			return
		end
		f29_local0.fetchInit = true
		f29_local0.fetchOffSet = 0
	end
	local f29_local1 = f29_arg0.controller
	local f29_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.GetMembershipProposalsByGroupComplete, {
		user = f29_arg0,
	})
	local f29_local3 = f29_local0.fetchList[f29_local0.fetchOffSet]
	if not Engine[0xA12CA07097B822B](f29_local2, f29_local1, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f29_local3.kind, f29_local3.ID, f29_local3.rootKind, f29_local3.rootID) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f29_local2,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.GetMembershipProposalsByGroupComplete = function(f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = f30_arg1.user
	local f30_local1 = f30_local0[f0_local4]
	if f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f30_local1.liveBackoff)
		f30_local1.fetchOffSet = f30_local1.fetchOffSet + 1
		if #f30_arg2.clansGroupMembershipProposals > 0 then
			for f30_local5, f30_local6 in ipairs(f30_arg2.clansGroupMembershipProposals) do
				table.insert(f30_local1.data, f30_local6)
			end
		end
		if f30_local1.fetchCount <= f30_local1.fetchOffSet then
			f30_local1.fetchInit = false
			Lobby.Clans.SetFetchedData(f30_local0, f0_local4, f30_local1.data)
		end
	elseif f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f30_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f30_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f30_arg2.errorCode)
	end
	return true
end
Lobby.Clans.RemoveGroupMember = function(f31_arg0)
	local f31_local0 = f31_arg0[f0_local7]
	if not Engine[0x88C82D2C4BED05](f31_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f31_local1 = f31_local0.data
	local f31_local2 = f31_arg0.controller
	local f31_local3 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.RemoveGroupMemberComplete, {
		user = f31_arg0,
	})
	local f31_local4 = f31_local1.ID
	local f31_local5 = f31_local1.rootID
	if f31_local1.replacesGroupID and f31_local1.replacesGroupID ~= LuaDefine.ZERO_x64 then
		f31_local4 = f31_local1.replacesGroupID
		f31_local5 = f31_local1.replacesRootID
	end
	local f31_local6 = Engine[0x8DF2E5447F384B9]()
	f31_local6.socialRoot.clans.loaded:set(LuaEnum.CLAN_INFO_MODELS.DELETING_CLAN)
	if not Engine[0x5BBAEBE20B6669F](f31_local3, f31_local2, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f31_local1.kind, f31_local4, f31_local1.rootKind, f31_local5, f31_local1.user or 0, f31_local1.newOwner or 0) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f31_local3,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.RemoveGroupMemberComplete = function(f32_arg0, f32_arg1, f32_arg2)
	local f32_local0 = f32_arg1.user
	local f32_local1 = f32_local0[f0_local7]
	if f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f32_local1.liveBackoff)
		Lobby.Clans.ClearTask(f32_local1)
		local f32_local2 = f32_local1.data
		if not f32_local2.user then
			Engine[0xE1789115A2356E7]("open_toaster_popup", {
				toastType = "remove_user",
				message = Engine[0xF9F1239CFD921FE](0x8069015F62912FE),
				isError = false,
				controller = controller,
				immediate = true,
			})
		elseif f32_local2.user == Engine[0x93B19E01B1FD1C7](f32_local0.controller) and f32_local2.newOwner == 0 then
			Engine[0xE1789115A2356E7]("open_toaster_popup", {
				toastType = "remove_user",
				message = Engine[0xF9F1239CFD921FE](0xC147AE3BDB2BEC6),
				isError = false,
				controller = controller,
				immediate = true,
			})
		else
			Engine[0xE1789115A2356E7]("open_toaster_popup", {
				toastType = "remove_user",
				message = Engine[0xF9F1239CFD921FE](0x7B285A6F0614EC4),
				gamertag = f32_local2.user,
				isError = false,
				controller = controller,
				immediate = true,
			})
		end
		Lobby.Clans.DoClanAction(f32_local0.controller, Lobby.Clans.ClanAction.GO_BACK)
		if f32_local2.replacesGroupID and f32_local2.replacesGroupID ~= LuaDefine.ZERO_x64 then
			f32_local1.process = true
			f32_local1.action = Lobby.Clans.GROUP_ACTION.ACCEPT_REQUEST
		end
	elseif f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f32_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f32_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f32_arg2.errorCode)
		Lobby.Clans.PrintErrorToClientAndClearTaskIfNeeded(f32_local0.controller, f32_arg2.errorCode, f32_local1)
	end
	Lobby.Events.EventDispatcher("OnClanUIEvent", {
		controller = f32_local0.controller,
		event = LuaEnum.CLAN_UI_EVENT.REFETCH_ALL,
	})
	return true
end
Lobby.Clans.ProposeMemberships = function(f33_arg0)
	local f33_local0 = f33_arg0[f0_local7]
	if not Engine[0x88C82D2C4BED05](f33_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f33_local1 = f33_local0.data
	local f33_local2 = f33_arg0.controller
	local f33_local3 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.ProposeMembershipsComplete, {
		user = f33_arg0,
	})
	if not Engine[0xA31A6CCD8DCD181](f33_local3, f33_local2, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f33_local1.kind, f33_local1.ID, f33_local1.rootKind, f33_local1.rootID, f33_local1.xuids, f33_local1.roles) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f33_local3,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.ProposeMembershipsComplete = function(f34_arg0, f34_arg1, f34_arg2)
	local f34_local0 = f34_arg1.user
	local f34_local1 = f34_local0[f0_local7]
	if f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f34_local1.liveBackoff)
		Lobby.Clans.ClearTask(f34_local1)
	elseif f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f34_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f34_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f34_arg2.errorCode)
		Lobby.Clans.PrintErrorToClientAndClearTaskIfNeeded(f34_local0.controller, f34_arg2.errorCode, f34_local1)
	end
	return true
end
Lobby.Clans.CreateGroup = function(f35_arg0)
	local f35_local0 = f35_arg0[f0_local7]
	if not Engine[0x88C82D2C4BED05](f35_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f35_local1 = f35_arg0.controller
	local f35_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.CreateGroupComplete, {
		user = f35_arg0,
	})
	if f35_local0.data.kind ~= LuaEnum.CLAN_KINDS.CLAN then
		local f35_local3 = false
		for f35_local7, f35_local8 in ipairs(f35_arg0[f0_local1].data) do
			if f35_local8.clansGroupIdentifier.kind == LuaEnum.CLAN_KINDS.CLAN then
				f35_local0.data.rootKind = f35_local8.clansGroupIdentifier.kind
				f35_local0.data.rootID = f35_local8.clansGroupIdentifier.ID
				f35_local3 = true
				break
			end
		end
		if not f35_local3 then
		else
		end
	end
	local f35_local3 = f35_local0.data
	local f35_local4 = Engine[0x42C33FC244F1071]
	local f35_local5 = f35_local2
	local f35_local6 = f35_local1
	local f35_local7 = LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT
	local f35_local8 = f35_local3.kind
	local f35_local9 = f35_local3.name
	local f35_local10 = f35_local3.rootKind
	if not f35_local10 then
		f35_local10 = LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROOT_KIND
	end
	local f35_local11 = f35_local3.rootID
	if not f35_local11 then
		f35_local11 = LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROOT_ID
	end
	local f35_local12 = f35_local3.privacyLevel
	if not f35_local12 then
		f35_local12 = LuaEnum.CLAN_OPTIONAL_PARAMETERS.PRIVACY_LEVEL
	end
	if not f35_local4(f35_local5, f35_local6, f35_local7, f35_local8, f35_local9, f35_local10, f35_local11, f35_local12) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f35_local2,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.CreateGroupComplete = function(f36_arg0, f36_arg1, f36_arg2)
	local f36_local0 = f36_arg1.user
	local f36_local1 = f36_local0[f0_local7]
	if f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Lobby.Clans.CreateGroupDataFile(f36_local0, f36_arg2, f36_local1.data)
		Engine[0x299C3DC3A21873E](f36_local1.liveBackoff)
		Lobby.Clans.ClearTask(f36_local1)
		Lobby.Events.EventDispatcher("OnClanUIEvent", {
			controller = f36_local0.controller,
			event = LuaEnum.CLAN_UI_EVENT.REFETCH_ALL,
		})
	elseif f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f36_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f36_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f36_arg2.errorCode)
		Lobby.Clans.ClearTask(f36_local1)
	end
	return true
end
Lobby.Clans.UpdateGroup = function(f37_arg0)
	local f37_local0 = f37_arg0[f0_local7]
	if not Engine[0x88C82D2C4BED05](f37_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f37_local1 = f37_arg0.controller
	local f37_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.UpdateGroupComplete, {
		user = f37_arg0,
	})
	local f37_local3 = f37_local0.data
	if not Engine[0x881698562E943FA](f37_local2, f37_local1, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f37_local3.kind, f37_local3.ID, LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROOT_KIND, LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROOT_ID, "Jeff is a Spud", LuaEnum.CLAN_OPTIONAL_PARAMETERS.OWNER, LuaEnum.CLAN_OPTIONAL_PARAMETERS.PRIVACY_LEVEL) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f37_local2,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.UpdateGroupComplete = function(f38_arg0, f38_arg1, f38_arg2)
	local f38_local0 = user[f0_local7]
	local f38_local1 = f38_arg1.user
	if f38_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f38_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f38_local0.liveBackoff)
	elseif f38_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f38_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f38_local0.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f38_arg2.errorCode)
	end
end
Lobby.Clans.AddOrUpdateGroupMember = function(f39_arg0)
	local f39_local0 = f39_arg0[f0_local7]
	if not Engine[0x88C82D2C4BED05](f39_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f39_local1 = f39_local0.data
	local f39_local2 = f39_arg0.controller
	local f39_local3 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.AddOrUpdateGroupMemberComplete, {
		user = f39_arg0,
	})
	local f39_local4 = Engine[0x8DF2E5447F384B9]()
	f39_local4.socialRoot.clans.loaded:set(LuaEnum.CLAN_INFO_MODELS.JOINING_CLAN)
	f39_local4 = Engine[0x6F76A7726BAA362]
	local f39_local5 = f39_local3
	local f39_local6 = f39_local2
	local f39_local7 = LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT
	local f39_local8 = f39_local1.kind
	local f39_local9 = f39_local1.ID
	local f39_local10 = f39_local1.rootKind
	local f39_local11 = f39_local1.rootID
	local f39_local12 = f39_local1.role
	if not f39_local12 then
		f39_local12 = Enum[0x10C0A769A29C38F][0xB17C2FE5CC7F0BC]
	end
	if not f39_local4(f39_local5, f39_local6, f39_local7, f39_local8, f39_local9, f39_local10, f39_local11, f39_local12, f39_local1.xuid, f39_local1.replacesGroupID or 0) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f39_local3,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.AddOrUpdateGroupMemberComplete = function(f40_arg0, f40_arg1, f40_arg2)
	local f40_local0 = f40_arg1.user
	local f40_local1 = f40_local0.controller
	local f40_local2 = f40_local0[f0_local7]
	if f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f40_local2.liveBackoff)
		Lobby.Clans.ClearTask(f40_local2)
		f40_local0[f0_local1].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
		f40_local0[f0_local5].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
		f40_local0[f0_local6].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
		f40_local0[f0_local3].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
		f40_local0[f0_local4].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
		if f40_local2.action == Lobby.Clans.GROUP_ACTION.ACCEPT_REQUEST then
			Engine[0xE1789115A2356E7]("open_toaster_popup", {
				toastType = "clan_join",
				message = 0x985BB17C727067D,
				isError = false,
				controller = f40_local1,
				immediate = true,
			})
		end
	elseif f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f40_local2.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f40_arg2.errorCode)
		if f40_local2.action == Lobby.Clans.GROUP_ACTION.ACCEPT_REQUEST then
			Engine[0xE1789115A2356E7]("open_toaster_popup", {
				toastType = "clan_join",
				message = 0x26374B4FCED05C9,
				isError = true,
				controller = f40_local1,
				immediate = true,
			})
		end
	end
	return true
end
Lobby.Clans.RemoveProposals = function(f41_arg0)
	local f41_local0 = f41_arg0[f0_local7]
	if not Engine[0x88C82D2C4BED05](f41_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f41_local1 = f41_arg0.controller
	local f41_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.RemoveProposalsComplete, {
		user = f41_arg0,
	})
	f41_local0.data.cooldown = 0
	if not Engine[0x889A6176CDF642D](f41_local2, f41_local1, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, {
		f41_local0.data.targetUserID,
	}, {
		f41_local0.data.kind,
	}, {
		f41_local0.data.ID,
	}, {
		f41_local0.data.rootKind,
	}, {
		f41_local0.data.rootID,
	}, {
		f41_local0.data.cooldown,
	}) then
		Lobby.Clans.PrintError(nil, "Task failed to start")
		LobbyVM.ProcessCompleteFailure({
			actionId = f41_local2,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
	end
end
Lobby.Clans.RemoveProposalsComplete = function(f42_arg0, f42_arg1, f42_arg2)
	local f42_local0 = f42_arg1.user[f0_local7]
	if f42_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f42_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f42_local0.liveBackoff)
		Lobby.Clans.ClearTask(f42_local0)
	elseif f42_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f42_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f42_local0.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.PrintError(f42_arg2.errorCode)
	end
	return true
end
Lobby.Clans.FormatMembershipInfo = function(f43_arg0)
	local f43_local0 = 0
	local f43_local1 = 0
	local f43_local2 = f43_arg0[f0_local1]
	f43_local2.dataFormatted = {}
	f43_local2.dataFormatted.squads = {}
	f43_local2.dataFormatted.teams = {}
	for f43_local6, f43_local7 in ipairs(f43_local2.data) do
		local f43_local8 = f43_local7.clansGroupIdentifier.kind
		local f43_local9 = {
			role = f43_local7.role,
			kind = f43_local8,
			ID = f43_local7.clansGroupIdentifier.ID,
			IDstr = f43_local7.clansGroupIdentifier.IDstr,
			rootKind = f43_local7.clansGroupIdentifier.rootKind,
			rootID = f43_local7.clansGroupIdentifier.rootID,
			rootIDstr = f43_local7.clansGroupIdentifier.rootIDstr,
			owner = f43_local7.role == Enum[0x10C0A769A29C38F][0xE94BCDEEB8AE946],
		}
		if f43_local8 == LuaEnum.CLAN_KINDS.CLAN then
			f43_local2.dataFormatted.clan = f43_local9
		end
		if f43_local8 == LuaEnum.CLAN_KINDS.SQUAD then
			f43_local2.dataFormatted.squads[f43_local0 + 1] = f43_local9
		end
		if f43_local8 == LuaEnum.CLAN_KINDS.TEAM then
			f43_local2.dataFormatted.teams[f43_local1 + 1] = f43_local9
		end
	end
end
Lobby.Clans.FindGroups = function(f44_arg0)
	local f44_local0 = f44_arg0[f0_local7]
	if not Engine[0x88C82D2C4BED05](f44_local0.liveBackoff, Engine[0x316595FEDC72451]()) then
		return
	end
	local f44_local1 = f44_arg0.controller
	local f44_local2 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Clans.FindGroupsComplete, {
		user = f44_arg0,
	})
	local f44_local3 = Engine[0x4DF5CFBC1771947](f44_local1)
	local f44_local4 = f44_local0.data.search
	local f44_local5 = f44_local0.data.kind
	local f44_local6 = Engine[0x40E824FE270E174](f44_local3, "ClanSearchFields.publicOnly")
	local f44_local7
	if f44_local6:get() then
		f44_local7 = {
			Enum[0xC491AC72605E0C3][0xB91F60B176A25F1],
		}
		if not f44_local7 then
		else
			local f44_local8 = {
				f44_local5,
			}
			local f44_local9 = f44_local0.data
			if not Engine[0xB356BB0AF6EE665](f44_local2, f44_local1, LuaDefine.TASKMANAGER2_DEFAULT_TIMEOUT, f44_local8, f44_local4, f44_local7) then
				Lobby.Clans.PrintError(nil, "Task failed to start")
				LobbyVM.ProcessCompleteFailure({
					actionId = f44_local2,
					isError = true,
					returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
					returnCodeHex = "EVENT START ERROR",
				})
			end
		end
	end
	f44_local7 = {}
end
Lobby.Clans.FindGroupsComplete = function(f45_arg0, f45_arg1, f45_arg2)
	local f45_local0 = f45_arg1.user
	local f45_local1 = f45_local0[f0_local7]
	if f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[0x299C3DC3A21873E](f45_local1.liveBackoff)
		Lobby.Clans.PopulateUIClansSearchResults(f45_local0, f45_arg2)
		Lobby.Clans.ClearTask(f45_local1)
	elseif f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[0xF910D4EFAE3B0F3](f45_local1.liveBackoff, Engine[0x316595FEDC72451]())
		Lobby.Clans.ClearTask(f45_local1)
		Lobby.Clans.PrintError(f45_arg2.errorCode)
	end
end
Lobby.Clans.OnClanUIEvent = function(f46_arg0)
	local f46_local0 = f46_arg0.event
	local f46_local1 = f46_arg0.controller
	if f46_local1 == nil then
		error("LobbyVM: No menu called '" .. currentMenu .. "' found.")
		return
	end
	local f46_local2 = Lobby.Clans.GetClanUserDataForController(f46_local1)
	if f46_local0 == LuaEnum.CLAN_UI_EVENT.INIT_MODELS then
		Lobby.Clans.InitClanUIModelsForController(f46_local1)
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.FETCH_DATA then
		for f46_local6, f46_local7 in pairs(Lobby.Clans.REFETCHABLE_TASKS) do
			if f46_local2[f46_local6].fetchStatus == Lobby.Clans.DATA_STATUS.REFETCH_REQUEST then
				f46_local2[f46_local6].fetchStatus = Lobby.Clans.REFETCHABLE_TASKS[f46_local6].taskDefault
			end
		end
		for f46_local6, f46_local7 in ipairs({
			f0_local2,
			f0_local3,
			f0_local4,
			f0_local5,
			f0_local6,
		}) do
			if f46_local2[f46_local7].fetchStatus == Lobby.Clans.DATA_STATUS.NOT_NEEDED then
				f46_local2[f46_local7].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
			end
		end
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.REFETCH_ALL then
		for f46_local6, f46_local7 in pairs(Lobby.Clans.REFETCHABLE_TASKS) do
			f46_local2[f46_local6].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
		end
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.REQUEST_CLAN_SQUAD_TEAM_INFO then
		f46_local2[f0_local5].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
		f46_local2[f0_local6].fetchStatus = Lobby.Clans.DATA_STATUS.NOT_FETCHED
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.PROPOSAL_ACTION then
		f46_local2[f0_local7].data = f46_arg0
		f46_local2[f0_local7].process = true
		local f46_local3 = f46_local2[f0_local7]
		local f46_local4 = f46_arg0.action
		local f46_local5 = LuaEnum.POPUP_ACTION.ACCEPT
		f46_local3.action = REG15 and Lobby.Clans.GROUP_ACTION.ACCEPT_REQUEST or Lobby.Clans.GROUP_ACTION.REJECT_REQUEST
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.JOIN_CLAN_SQUAD_TEAM then
		f46_local2[f0_local7].data = f46_arg0
		f46_local2[f0_local7].process = true
		f46_local2[f0_local7].action = Lobby.Clans.GROUP_ACTION.JOIN
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.CREATE_GROUP then
		f46_local2[f0_local7].data = f46_arg0
		f46_local2[f0_local7].process = true
		f46_local2[f0_local7].action = Lobby.Clans.GROUP_ACTION.CREATE
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.UPDATE_GROUP then
		f46_local2[f0_local7].data = f46_arg0
		f46_local2[f0_local7].process = true
		f46_local2[f0_local7].action = Lobby.Clans.GROUP_ACTION.UPDATE
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.REMOVE_USER then
		f46_local2[f0_local7].data = f46_arg0
		f46_local2[f0_local7].process = true
		f46_local2[f0_local7].action = Lobby.Clans.GROUP_ACTION.REMOVE
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.ADD_OR_UPDATE_USER then
		f46_local2[f0_local7].data = f46_arg0
		f46_local2[f0_local7].process = true
		f46_local2[f0_local7].action = Lobby.Clans.GROUP_ACTION.ADD_OR_UPDATE
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.INVITE_TO_GROUP then
		if f46_arg0.inviteCount == 0 then
			return
		end
		local f46_local4 = f46_arg0.inviteType
		local f46_local5 = Lobby.Clans.GetControllerClanModel(f46_local2.xuidStr)
		if f46_local4 == "clan" then
			f46_local5 = f46_local5.clans.clan1
		elseif f46_local4 == "squad" then
			f46_local5 = f46_local5.squads.squad1
		elseif f46_local4 == "team" then
			f46_local5 = f46_local5.teams.team1
		end
		local f46_local6 = {
			kind = f46_local5.kind:get(),
			ID = f46_local5.ID:get(),
			rootKind = f46_local5.rootKind:get(),
			rootID = f46_local5.rootID:get(),
			count = f46_arg0.inviteCount,
			roles = {},
			xuids = {},
			gamertag = {},
		}
		for f46_local7 = 1, f46_arg0.inviteCount, 1 do
			f46_local6.roles[f46_local7] = f46_arg0.role
			f46_local6.xuids[f46_local7] = f46_arg0["xuid" .. f46_local7]
			f46_local6.gamertag[f46_local7] = f46_arg0["gamertag" .. f46_local7]
		end
		f46_local2[f0_local7].data = f46_local6
		f46_local2[f0_local7].process = true
		f46_local2[f0_local7].action = Lobby.Clans.GROUP_ACTION.INVITE
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.DATA_REQUEST then
		Lobby.Clans.DataRequestHandler(f46_local2, f46_arg0)
	elseif f46_local0 == LuaEnum.CLAN_UI_EVENT.FIND_GROUPS then
		f46_local2[f0_local7].data = f46_arg0
		f46_local2[f0_local7].process = true
		f46_local2[f0_local7].action = Lobby.Clans.GROUP_ACTION.FIND_GROUPS
	end
end
Lobby.Clans.getTableFromPath = function(f47_arg0, f47_arg1)
	local f47_local0 = f47_arg1 or _G
	for f47_local4 in string.gmatch(f47_arg0, "[^.]+") do
		f47_local0 = f47_local0[f47_local4]
		if f47_local0 == nil then
			return nil
		end
	end
	return f47_local0
end
Lobby.Clans.GetRootModelForRequest = function(f48_arg0, f48_arg1)
	if f48_arg0.rootModel == LuaEnum.CLAN_ROOT_MODEL.GLOBAL then
		return Engine[0x8DF2E5447F384B9]()
	else
		return Engine[0x4DF5CFBC1771947](f48_arg1)
	end
end
Lobby.Clans.CreateInboxModel = function(f49_arg0, f49_arg1, f49_arg2)
	local f49_local0 = f49_arg0:create("mail" .. f49_arg2)
	local f49_local1 = f49_local0:create("proposingUserID")
	f49_local1:set(f49_arg1.proposingUserID)
	f49_local1 = f49_local0:create("proposingUserAccountType")
	f49_local1:set(f49_arg1.proposingUserAccountType)
	f49_local1 = f49_local0:create("targetUserID")
	f49_local1:set(f49_arg1.targetUserID)
	f49_local1 = f49_local0:create("targetUserAccountType")
	f49_local1:set(f49_arg1.targetUserAccountType)
	f49_local1 = f49_local0:create("role")
	f49_local1:set(f49_arg1.role)
	f49_local1 = f49_local0:create("groupIdentifier")
	local f49_local2 = f49_local1:create("kind")
	f49_local2:set(f49_arg1.clansGroupIdentifier.kind)
	f49_local2 = f49_local1:create("ID")
	f49_local2:set(f49_arg1.clansGroupIdentifier.ID)
	f49_local2 = f49_local1:create("IDstr")
	f49_local2:set(f49_arg1.clansGroupIdentifier.IDstr)
	f49_local2 = f49_local1:create("rootKind")
	f49_local2:set(f49_arg1.clansGroupIdentifier.rootKind)
	f49_local2 = f49_local1:create("rootID")
	f49_local2:set(f49_arg1.clansGroupIdentifier.rootID)
	f49_local2 = f49_local1:create("rootIDstr")
	f49_local2:set(f49_arg1.clansGroupIdentifier.rootIDstr)
	f49_local2 = f49_local0:create("replacesGroupID")
	f49_local2:set(f49_arg1.replacesGroupID)
	f49_local2 = f49_local0:create("hasAttachment")
	f49_local2:set(f49_arg1.hasAttachment)
	if f49_arg1.hasAttachment then
		f49_local2 = f49_local0:create("attachmentSize")
		f49_local2:set(f49_arg1.attachmentSize)
		f49_local2 = f49_local0:create("attachment")
		f49_local2:set(f49_arg1.attachment)
	end
	f49_local2 = f49_local0:create("updatedTimestamp")
	f49_local2:set(f49_arg1.updatedTimestamp)
end
Lobby.Clans.HandleUIClanInboxModels = function(f50_arg0, f50_arg1)
	local f50_local0 = Lobby.Clans.getTableFromPath(f50_arg1.path, Lobby.Clans.GetRootModelForRequest(f50_arg1, f50_arg1.controller))
	local f50_local1 = #f50_arg0[f0_local3].data
	local f50_local2 = #f50_arg0[f0_local4].data
	local f50_local3 = 0
	if f50_local1 then
		for f50_local7, f50_local8 in ipairs(f50_arg0[f0_local3].data) do
			f50_local3 = f50_local3 + 1
			Lobby.Clans.CreateInboxModel(f50_local0, f50_local8, f50_local3)
		end
	end
	if f50_local2 then
		for f50_local7, f50_local8 in ipairs(f50_arg0[f0_local4].data) do
			f50_local3 = f50_local3 + 1
			Lobby.Clans.CreateInboxModel(f50_local0, f50_local8, f50_local3)
		end
	end
	local f50_local4 = f50_local0:create("modelCount")
	f50_local4:set(f50_local3)
	Engine[0x6A489878620F3BC](f50_local4)
end
Lobby.Clans.GetEmblemRenderInfo = function(f51_arg0, f51_arg1)
	local f51_local0 = Lobby.Clans.getTableFromPath(f51_arg1.path, Lobby.Clans.GetRootModelForRequest(f51_arg1, f51_arg1.controller))
	for f51_local5, f51_local6 in pairs(f51_arg0[f0_local5].data) do
		if f51_local6.clansGroupIdentifier.ID == f51_arg1.groupID then
			local f51_local4 = f51_local0:create("ownerID")
			f51_local4:set(f51_local6.ownerID)
			f51_local4 = f51_local0:create("rootID")
			f51_local4:set(f51_local6.clansGroupIdentifier.rootID)
			f51_local4 = f51_local0:create("groupKind")
			f51_local4:set(f51_local6.clansGroupIdentifier.kind)
			break
		end
	end
end
Lobby.Clans.DataRequestHandler = function(f52_arg0, f52_arg1)
	if f52_arg1.dataRequestType == LuaEnum.CLAN_DATA_REQUEST_TYPE.CLAN_INBOX then
		Lobby.Clans.HandleUIClanInboxModels(f52_arg0, f52_arg1)
	elseif f52_arg1.dataRequestType == LuaEnum.CLAN_DATA_REQUEST_TYPE.EMBLEM_RENDER_INFO then
		Lobby.Clans.GetEmblemRenderInfo(f52_arg0, f52_arg1)
	end
end
Lobby.Clans.ReadGroupMembershipFiles = function(f53_arg0)
	local f53_local0 = f53_arg0.controller
	local f53_local1 = f53_arg0[f0_local1]
	local f53_local2 = 1
	local f53_local3 = {}
	local f53_local4 = {}
	local f53_local5 = {}
	local f53_local6 = {}
	local f53_local7 = {}
	local f53_local8 = {}
	local f53_local9 = {}
	local f53_local10 = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4, f54_arg5, f54_arg6)
		f53_local3[f53_local2] = f54_arg0
		f53_local4[f53_local2] = f54_arg1
		f53_local5[f53_local2] = f54_arg2
		f53_local6[f53_local2] = f54_arg3
		f53_local7[f53_local2] = f54_arg4
		f53_local8[f53_local2] = f54_arg5
		f53_local9[f53_local2] = f54_arg6
		f53_local2 = f53_local2 + 1
	end
	local f53_local11 = function(f55_arg0, f55_arg1)
		return f53_local10(Enum[0xBBD4F9E70101BA8][0x6CA620BD75C97F4], f55_arg0, f55_arg1.kind, f55_arg1.ID, f55_arg1.rootKind, f55_arg1.rootID, LuaEnum.CLAN_STORAGE.DATA)
	end
	local f53_local12 = function(f56_arg0, f56_arg1)
		return f53_local10(Enum[0xBBD4F9E70101BA8][0x94DF15E8078D20A], f56_arg0, f56_arg1.kind, f56_arg1.ID, f56_arg1.rootKind, f56_arg1.rootID, LuaEnum.CLAN_STORAGE.EMBLEM)
	end
	local f53_local13 = function(f57_arg0, f57_arg1)
		return f53_local10(Enum[0xBBD4F9E70101BA8][0x423A66A665DE4DF], f57_arg0, f57_arg1.kind, f57_arg1.ID, f57_arg1.rootKind, f57_arg1.rootID, LuaEnum.CLAN_STORAGE.TEAM_DATA)
	end
	if f53_local1.dataFormatted.clan ~= nil then
		f53_local11(LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA, f53_local1.dataFormatted.clan)
	end
	for f53_local17, f53_local18 in ipairs(f53_local1.dataFormatted.teams) do
		f53_local13(LuaEnum.TEAM_STORAGE_SLOT.TEAM_1_DATA - 1 + f53_local17, f53_local18)
	end
	if f53_local1.dataFormatted.clan ~= nil then
		f53_local12(LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM, f53_local1.dataFormatted.clan)
	end
	for f53_local17, f53_local18 in ipairs(f53_local1.dataFormatted.squads) do
		f53_local12(LuaEnum.CLAN_STORAGE_SLOT.SQUAD_1_EMBLEM - 1 + f53_local17, f53_local18)
	end
	for f53_local17, f53_local18 in ipairs(f53_local1.dataFormatted.teams) do
		f53_local12(LuaEnum.CLAN_STORAGE_SLOT.TEAM_1_EMBLEM - 1 + f53_local17, f53_local18)
	end
	if #f53_local3 > 0 then
		Engine[0x7079182F35F6DF8](f53_local0, f53_local3, f53_local4, f53_local5, f53_local6, f53_local7, f53_local8, f53_local9)
		for f53_local14 = 1, #f53_local3 or 0, 1 do
			Engine[0x9C5F27295601778](f53_local0, f53_local3[f53_local14], f53_local4[f53_local14])
		end
	end
end
Lobby.Clans.CreateGroupDataFile = function(f58_arg0, f58_arg1, f58_arg2)
	local f58_local0 = f58_arg0.controller
	local f58_local1 = f58_arg0[f0_local7].data
	if f58_local1.kind == LuaEnum.CLAN_KINDS.CLAN then
		Engine[0x7079182F35F6DF8](f58_local0, {
			Enum[0xBBD4F9E70101BA8][0x6CA620BD75C97F4],
			Enum[0xBBD4F9E70101BA8][0x94DF15E8078D20A],
		}, {
			LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA,
			LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM,
		}, {
			f58_arg1.clansGroupIdentifier.kind,
			f58_arg1.clansGroupIdentifier.kind,
		}, {
			f58_arg1.clansGroupIdentifier.ID,
			f58_arg1.clansGroupIdentifier.ID,
		}, {
			f58_arg1.clansGroupIdentifier.rootKind,
			f58_arg1.clansGroupIdentifier.rootKind,
		}, {
			f58_arg1.clansGroupIdentifier.rootID,
			f58_arg1.clansGroupIdentifier.rootID,
		}, {
			LuaEnum.CLAN_STORAGE.DATA,
			LuaEnum.CLAN_STORAGE.EMBLEM,
		})
		Engine[0x7368A6035CE9089](f58_local0, Enum[0xBBD4F9E70101BA8][0x6CA620BD75C97F4], LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA)
		local f58_local2 = Engine[0x8BF970606552F4C](f58_local0, Enum[0xBBD4F9E70101BA8][0x6CA620BD75C97F4], LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA)
		if f58_local2 ~= nil then
			f58_local2.description:set(f58_local1.description)
			f58_local2.messageXuid:set(f58_arg0.xuid)
			f58_local2.message:set(Engine[0xF9F1239CFD921FE](0x48254D9AC546E95))
			Engine[0xFD581BCE55651E3](f58_local0, Enum[0xBBD4F9E70101BA8][0x6CA620BD75C97F4], LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA)
		end
		Engine[0x8A10CA2A2270D41](f58_local0, LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM, Enum[0xBBD4F9E70101BA8][0x94DF15E8078D20A])
	elseif f58_local1.kind == LuaEnum.CLAN_KINDS.TEAM then
		local f58_local2 = -1
		local f58_local3 = nil
		for f58_local4 = LuaEnum.TEAM_STORAGE_SLOT.TEAM_1_DATA, LuaEnum.TEAM_STORAGE_SLOT.TEAM_3_DATA, 1 do
			f58_local3 = Engine[0x8BF970606552F4C](f58_local0, Enum[0xBBD4F9E70101BA8][0x423A66A665DE4DF], f58_local4)
			if f58_local3 == nil then
				f58_local2 = f58_local4
				break
			end
		end
		local f58_local4 = LuaEnum.CLAN_STORAGE_SLOT.TEAM_1_EMBLEM + f58_local2
		assert(f58_local3 == nil)
		Engine[0x7079182F35F6DF8](f58_local0, {
			Enum[0xBBD4F9E70101BA8][0x423A66A665DE4DF],
			Enum[0xBBD4F9E70101BA8][0x94DF15E8078D20A],
		}, {
			f58_local2,
			f58_local4,
		}, {
			f58_arg1.clansGroupIdentifier.kind,
			f58_arg1.clansGroupIdentifier.kind,
		}, {
			f58_arg1.clansGroupIdentifier.ID,
			f58_arg1.clansGroupIdentifier.ID,
		}, {
			f58_arg1.clansGroupIdentifier.rootKind,
			f58_arg1.clansGroupIdentifier.rootKind,
		}, {
			f58_arg1.clansGroupIdentifier.rootID,
			f58_arg1.clansGroupIdentifier.rootID,
		}, {
			LuaEnum.CLAN_STORAGE.TEAM_DATA,
			LuaEnum.CLAN_STORAGE.EMBLEM,
		})
		Engine[0x7368A6035CE9089](f58_local0, Enum[0xBBD4F9E70101BA8][0x423A66A665DE4DF], f58_local2)
		if Engine[0x8BF970606552F4C](f58_local0, Enum[0xBBD4F9E70101BA8][0x423A66A665DE4DF], index) ~= nil then
			Engine[0xFD581BCE55651E3](f58_local0, Enum[0xBBD4F9E70101BA8][0x423A66A665DE4DF], f58_local2)
		end
		Engine[0x8A10CA2A2270D41](f58_local0, f58_local4, Enum[0xBBD4F9E70101BA8][0x94DF15E8078D20A])
	end
end
Lobby.Clans.InitClanUIModelsForController = function(f59_arg0)
	if not Dvar[0xCA8E9EDE02C25E6]:get() then
		return
	else
		local f59_local0 = Lobby.Clans.GetClanUserDataForController(f59_arg0)
		Lobby.Clans.PopulateUIMembershipModels(f59_local0)
		Lobby.Clans.PopulateUIClanInfoModels(f59_local0)
		Lobby.Clans.PopulateUIClanMemberModels(f59_local0)
		Lobby.Clans.PopulateUIFriendClanModels(f59_local0)
	end
end
Lobby.Clans.PopulateUIMembershipModels = function(f60_arg0)
	local f60_local0 = Lobby.Clans.GetControllerClanModel(f60_arg0.xuidStr)
	local f60_local1 = f60_local0:create("clans")
	local f60_local2 = f60_local0:create("squads")
	local f60_local3 = f60_local0:create("teams")
	local f60_local4 = Engine[0x8DF2E5447F384B9]()
	f60_local4 = f60_local4:create("socialRoot")
	local f60_local5 = f60_local4:create("clans")
	if #f60_arg0[f0_local1].data == 0 then
		if f60_local1.clan1 then
			Engine[0x8C7A8C4C5FD9892](f60_local1.clan1)
		end
		local f60_local6 = f60_local1:create("count")
		f60_local6:set(0)
		f60_local6 = f60_local2:create("count")
		f60_local6:set(0)
		f60_local6 = f60_local3:create("count")
		f60_local6:set(0)
		f60_local6 = f60_local5:create("countClan")
		f60_local6:set(0)
		f60_local6 = f60_local5:create("countSquad")
		f60_local6:set(0)
		f60_local6 = f60_local5:create("countTeam")
		f60_local6:set(0)
		f60_local6 = f60_local5:create("ownerClan")
		f60_local6:set(false)
		f60_local6 = f60_local5:create("ownerSquad")
		f60_local6:set(false)
		f60_local6 = f60_local5:create("ownerTeam")
		f60_local6:set(false)
		return
	end
	local f60_local6 = 0
	local f60_local7 = 0
	local f60_local8 = 0
	local f60_local9 = false
	local f60_local10 = false
	local f60_local11 = false
	for f60_local17, f60_local18 in ipairs(f60_arg0[f0_local1].data) do
		local f60_local15 = f60_local1
		local f60_local19 = f60_local18.clansGroupIdentifier.kind
		local f60_local20 = f60_local18.role == Enum[0x10C0A769A29C38F][0xE94BCDEEB8AE946]
		if f60_local19 == LuaEnum.CLAN_KINDS.CLAN then
			f60_local6 = f60_local6 + 1
			f60_local15 = f60_local1:create("clan" .. f60_local6)
			local f60_local16 = f60_local15:create("listId")
			f60_local16:set(f60_local6)
			f60_local9 = f60_local20 or f60_local9
		elseif f60_local19 == LuaEnum.CLAN_KINDS.SQUAD then
			f60_local7 = f60_local7 + 1
			f60_local15 = f60_local2:create("squad" .. f60_local7)
			local f60_local16 = f60_local15:create("listId")
			f60_local16:set(f60_local7)
			f60_local10 = f60_local20 or f60_local10
		elseif f60_local19 == LuaEnum.CLAN_KINDS.TEAM then
			f60_local8 = f60_local8 + 1
			f60_local15 = f60_local3:create("team" .. f60_local8)
			local f60_local16 = f60_local15:create("listId")
			f60_local16:set(f60_local8)
			f60_local11 = f60_local20 or f60_local11
		end
		local f60_local16 = f60_local15:create("role")
		f60_local16:set(f60_local18.role)
		f60_local16 = f60_local15:create("kind")
		f60_local16:set(f60_local19)
		f60_local16 = f60_local15:create("ID")
		f60_local16:set(f60_local18.clansGroupIdentifier.ID)
		f60_local16 = f60_local15:create("IDstr")
		f60_local16:set(f60_local18.clansGroupIdentifier.IDstr)
		f60_local16 = f60_local15:create("rootKind")
		f60_local16:set(f60_local18.clansGroupIdentifier.rootKind)
		f60_local16 = f60_local15:create("rootID")
		f60_local16:set(f60_local18.clansGroupIdentifier.rootID)
		f60_local16 = f60_local15:create("rootIDstr")
		f60_local16:set(f60_local18.clansGroupIdentifier.rootIDstr)
	end
	f60_local12 = f60_local1:create("count")
	f60_local12:set(f60_local6)
	f60_local12 = f60_local2:create("count")
	f60_local12:set(f60_local7)
	f60_local12 = f60_local3:create("count")
	f60_local12:set(f60_local8)
	f60_local12 = f60_local5:create("countClan")
	f60_local12:set(f60_local6)
	f60_local12 = f60_local5:create("countSquad")
	f60_local12:set(f60_local7)
	f60_local12 = f60_local5:create("countTeam")
	f60_local12:set(f60_local8)
	f60_local12 = f60_local5:create("ownerClan")
	f60_local12:set(f60_local9)
	f60_local12 = f60_local5:create("ownerSquad")
	f60_local12:set(f60_local10)
	f60_local12 = f60_local5:create("ownerTeam")
	f60_local12:set(f60_local11)
end
Lobby.Clans.PopulateUIClanUserInboxModels = function(f61_arg0)
	local f61_local0 = Lobby.Clans.GetControllerClanModel(f61_arg0.xuidStr)
	local f61_local1 = f61_local0:create("inbox")
	local f61_local2 = Engine[0x8DF2E5447F384B9]()
	f61_local2 = f61_local2:create("socialRoot")
	local f61_local3 = f61_local2:create("clans")
	local f61_local4 = f61_local3:create("countInbox")
	if #f61_arg0[f0_local3].data == 0 then
		local f61_local5 = f61_local1:create("count")
		f61_local5:set(0)
		f61_local4:set(0)
		Engine[0x6A489878620F3BC](f61_local4)
		return
	end
	local f61_local5 = 0
	for f61_local10, f61_local11 in ipairs(f61_arg0[f0_local3].data) do
		local f61_local12 = f61_local1
		f61_local5 = f61_local5 + 1
		f61_local12 = f61_local1:create("mail" .. f61_local5)
		local f61_local13 = f61_local12:create("proposingUserID")
		f61_local13:set(f61_local11.proposingUserID)
		f61_local13 = f61_local12:create("proposingUserAccountType")
		f61_local13:set(f61_local11.proposingUserAccountType)
		f61_local13 = f61_local12:create("targetUserID")
		f61_local13:set(f61_local11.targetUserID)
		f61_local13 = f61_local12:create("targetUserAccountType")
		f61_local13:set(f61_local11.targetUserAccountType)
		f61_local13 = f61_local12:create("role")
		f61_local13:set(f61_local11.role)
		f61_local13 = f61_local12:create("groupIdentifier")
		local f61_local9 = f61_local13:create("kind")
		f61_local9:set(f61_local11.clansGroupIdentifier.kind)
		f61_local9 = f61_local13:create("ID")
		f61_local9:set(f61_local11.clansGroupIdentifier.ID)
		f61_local9 = f61_local13:create("IDstr")
		f61_local9:set(f61_local11.clansGroupIdentifier.IDstr)
		f61_local9 = f61_local13:create("rootKind")
		f61_local9:set(f61_local11.clansGroupIdentifier.rootKind)
		f61_local9 = f61_local13:create("rootID")
		f61_local9:set(f61_local11.clansGroupIdentifier.rootID)
		f61_local9 = f61_local13:create("rootIDstr")
		f61_local9:set(f61_local11.clansGroupIdentifier.rootIDstr)
		f61_local9 = f61_local12:create("replacesGroupID")
		f61_local9:set(f61_local11.replacesGroupID)
		f61_local9 = f61_local12:create("hasAttachment")
		f61_local9:set(f61_local11.hasAttachment)
		if f61_local11.hasAttachment then
			f61_local9 = f61_local12:create("attachmentSize")
			f61_local9:set(f61_local11.attachmentSize)
			f61_local9 = f61_local12:create("attachment")
			f61_local9:set(f61_local11.attachment)
		end
		f61_local9 = f61_local12:create("updatedTimestamp")
		f61_local9:set(f61_local11.updatedTimestamp)
	end
	f61_local6 = f61_local1:create("count")
	f61_local6:set(f61_local5)
	f61_local4:set(f61_local5)
	Engine[0x6A489878620F3BC](f61_local4)
end
Lobby.Clans.PopulateUIClanGroupInboxModels = function(f62_arg0)
	local f62_local0 = Lobby.Clans.GetControllerClanModel(f62_arg0.xuidStr)
	local f62_local1 = f62_local0:create("inboxGroup")
	local f62_local2 = 0
	local f62_local3 = f62_local1:create("count")
	f62_local3:set(f62_local2)
	f62_local3 = Engine[0x8DF2E5447F384B9]()
	f62_local3 = f62_local3:create("socialRoot")
	local f62_local4 = f62_local3:create("clans")
	local f62_local5 = f62_local4:create("countInboxGroup")
	f62_local5:set(f62_local2)
	if #f62_arg0[f0_local4].data == 0 then
		Engine[0x6A489878620F3BC](f62_local5)
		return
	end
	for f62_local10, f62_local11 in ipairs(f62_arg0[f0_local4].data) do
		local f62_local12 = f62_local1
		f62_local2 = f62_local2 + 1
		f62_local12 = f62_local1:create("mail" .. f62_local2)
		local f62_local13 = f62_local12:create("isInvite")
		f62_local13:set(f62_local11.proposingUserID ~= f62_local11.targetUserID)
		f62_local13 = f62_local12:create("proposingUserID")
		f62_local13:set(f62_local11.proposingUserID)
		f62_local13 = f62_local12:create("proposingUserAccountType")
		f62_local13:set(f62_local11.proposingUserAccountType)
		f62_local13 = f62_local12:create("targetUserID")
		f62_local13:set(f62_local11.targetUserID)
		f62_local13 = f62_local12:create("targetUserAccountType")
		f62_local13:set(f62_local11.targetUserAccountType)
		f62_local13 = f62_local12:create("role")
		f62_local13:set(f62_local11.role)
		f62_local13 = f62_local12:create("groupIdentifier")
		local f62_local9 = f62_local13:create("kind")
		f62_local9:set(f62_local11.clansGroupIdentifier.kind)
		f62_local9 = f62_local13:create("ID")
		f62_local9:set(f62_local11.clansGroupIdentifier.ID)
		f62_local9 = f62_local13:create("IDstr")
		f62_local9:set(f62_local11.clansGroupIdentifier.IDstr)
		f62_local9 = f62_local13:create("rootKind")
		f62_local9:set(f62_local11.clansGroupIdentifier.rootKind)
		f62_local9 = f62_local13:create("rootID")
		f62_local9:set(f62_local11.clansGroupIdentifier.rootID)
		f62_local9 = f62_local13:create("rootIDstr")
		f62_local9:set(f62_local11.clansGroupIdentifier.rootIDstr)
		f62_local9 = f62_local12:create("replacesGroupID")
		f62_local9:set(f62_local11.replacesGroupID)
		f62_local9 = f62_local12:create("hasAttachment")
		f62_local9:set(f62_local11.hasAttachment)
		if f62_local11.hasAttachment then
			f62_local9 = f62_local12:create("attachmentSize")
			f62_local9:set(f62_local11.attachmentSize)
			f62_local9 = f62_local12:create("attachment")
			f62_local9:set(f62_local11.attachment)
		end
		f62_local9 = f62_local12:create("updatedTimestamp")
		f62_local9:set(f62_local11.updatedTimestamp)
	end
	f62_local6 = f62_local1:create("count")
	f62_local6:set(f62_local2)
	f62_local5:set(f62_local2)
	Engine[0x6A489878620F3BC](f62_local5)
end
Lobby.Clans.InitUIClanInfoModels = function()
	local f63_local0 = Engine[0x8DF2E5447F384B9]()
	f63_local0 = f63_local0:create("socialRoot")
	local f63_local1 = f63_local0:create("clans")
	if f63_local1.loaded == nil then
		local f63_local2 = f63_local1:create("loaded")
		f63_local2:set(LuaEnum.CLAN_INFO_MODELS.NOT_LOADED)
		f63_local2 = f63_local0:create("squads")
		f63_local2 = f63_local2:create("loaded")
		f63_local2:set(LuaEnum.CLAN_INFO_MODELS.NOT_LOADED)
		f63_local2 = f63_local0:create("teams")
		f63_local2 = f63_local2:create("loaded")
		f63_local2:set(LuaEnum.CLAN_INFO_MODELS.NOT_LOADED)
	end
	local f63_local2 = f63_local1:create("listClans")
	if f63_local2.count == nil then
		local f63_local3 = Engine[0x8DF2E5447F384B9]()
		f63_local3 = f63_local3.socialRoot.clans:create("ownerClan")
		f63_local3:set(false)
		f63_local3 = Engine[0x8DF2E5447F384B9]()
		f63_local3 = f63_local3.socialRoot.clans:create("ownerSquad")
		f63_local3:set(false)
		f63_local3 = Engine[0x8DF2E5447F384B9]()
		f63_local3 = f63_local3.socialRoot.clans:create("ownerTeam")
		f63_local3:set(false)
	end
	f63_local2 = f63_local1:create("listSquads")
	f63_local2 = f63_local1:create("listTeams")
end
Lobby.Clans.PopulateUIClanInfoModels = function(f64_arg0)
	if f64_arg0[f0_local5].fetchStatus ~= Lobby.Clans.DATA_STATUS.FETCHED then
		Lobby.Clans.InitUIClanInfoModels()
		return
	end
	local f64_local0 = Engine[0x8DF2E5447F384B9]()
	f64_local0 = f64_local0.socialRoot
	local f64_local1 = f64_local0:create("clans")
	local f64_local2 = f64_local1:create("loaded")
	local f64_local3 = f64_local0:create("teams")
	f64_local3 = f64_local3:create("loaded")
	local f64_local4 = f64_local0:create("squads")
	f64_local4 = f64_local4:create("loaded")
	local f64_local5 = f64_local1:create("listClans")
	local f64_local6 = f64_local1:create("listSquads")
	local f64_local7 = f64_local1:create("listTeams")
	local f64_local8 = 0
	local f64_local9 = 0
	local f64_local10 = 0
	for f64_local16, f64_local17 in pairs(f64_arg0[f0_local5].data) do
		local f64_local14 = f64_local5
		local f64_local18 = f64_local17.clansGroupIdentifier.kind
		if f64_local18 == LuaEnum.CLAN_KINDS.CLAN then
			f64_local14 = f64_local5
			f64_local8 = f64_local8 + 1
		elseif f64_local18 == LuaEnum.CLAN_KINDS.SQUAD then
			f64_local14 = f64_local6
			f64_local9 = f64_local9 + 1
		elseif f64_local18 == LuaEnum.CLAN_KINDS.TEAM then
			f64_local14 = f64_local7
			f64_local10 = f64_local10 + 1
		end
		f64_local14 = f64_local14:create(f64_local17.clansGroupIdentifier.IDstr)
		local f64_local15 = f64_local14:create("name")
		f64_local15:set(f64_local17.name)
		f64_local15 = f64_local14:create("ownerID")
		f64_local15:set(f64_local17.ownerID)
		f64_local15 = f64_local14:create("hasOwner")
		f64_local15:set(f64_local17.hasOwner)
		f64_local15 = f64_local14:create("privacyLevel")
		f64_local15:set(f64_local17.privacyLevel)
		f64_local15 = f64_local14:create("memberCount")
		f64_local15:set(f64_local17.memberCount)
		f64_local15 = f64_local14:create("memberOnlineCount")
		f64_local15:set(f64_local17.memberOnlineCount)
		f64_local15 = f64_local14:create("proposalCount")
		f64_local15:set(f64_local17.proposalCount)
		f64_local15 = f64_local14:create("createdTimestamp")
		f64_local15:set(f64_local17.createdTimestamp)
		f64_local15 = f64_local14:create("kind")
		f64_local15:set(f64_local17.clansGroupIdentifier.kind)
		f64_local15 = f64_local14:create("ID")
		f64_local15:set(f64_local17.clansGroupIdentifier.ID)
		f64_local15 = f64_local14:create("IDstr")
		f64_local15:set(f64_local17.clansGroupIdentifier.IDstr)
		f64_local15 = f64_local14:create("rootKind")
		f64_local15:set(f64_local17.clansGroupIdentifier.rootKind)
		f64_local15 = f64_local14:create("rootID")
		f64_local15:set(f64_local17.clansGroupIdentifier.rootID)
		f64_local15 = f64_local14:create("rootIDstr")
		f64_local15:set(f64_local17.clansGroupIdentifier.rootIDstr)
		if f64_local18 == LuaEnum.CLAN_KINDS.TEAM then
			Engine[0x6A489878620F3BC](f64_local7)
		end
	end
	f64_local12 = f64_local2
	f64_local11 = f64_local2.set
	if f64_local8 > 0 then
		f64_local13 = LuaEnum.CLAN_INFO_MODELS.LOADED
		if not f64_local13 then
		else
			f64_local11(f64_local12, f64_local13)
			f64_local12 = f64_local3
			f64_local11 = f64_local3.set
			if f64_local10 > 0 then
				f64_local13 = LuaEnum.CLAN_INFO_MODELS.LOADED
				if not f64_local13 then
				else
					f64_local11(f64_local12, f64_local13)
					f64_local12 = f64_local4
					f64_local11 = f64_local4.set
					if f64_local9 > 0 then
						f64_local13 = LuaEnum.CLAN_INFO_MODELS.LOADED
						if not f64_local13 then
						else
							f64_local11(f64_local12, f64_local13)
						end
					end
					f64_local13 = LuaEnum.CLAN_INFO_MODELS.LOADED_EMPTY
				end
			end
			f64_local13 = LuaEnum.CLAN_INFO_MODELS.LOADED_EMPTY
		end
	end
	f64_local13 = LuaEnum.CLAN_INFO_MODELS.LOADED_EMPTY
end
Lobby.Clans.PopulateUIClansSearchResults = function(f65_arg0, f65_arg1)
	local f65_local0 = Lobby.Clans.GetControllerClanModel(f65_arg0.xuidStr)
	local f65_local1 = f65_local0:create("findClansResults")
	local f65_local2 = f65_local1:create("list")
	local f65_local3 = f65_local1:create("listCount")
	local f65_local4 = 0
	for f65_local17, f65_local18 in ipairs(f65_arg1.clansGroupInfos) do
		f65_local4 = f65_local4 + 1
		local f65_local19 = f65_local2:create("group" .. f65_local4)
		for f65_local14, f65_local15 in pairs(f65_local18) do
			if f65_local14 == "clansGroupIdentifier" and f65_local15 then
				for f65_local11, f65_local12 in pairs(f65_local15) do
					local f65_local13 = f65_local19:create(f65_local11)
					f65_local13:set(f65_local12)
				end
			end
			if f65_local14 and f65_local15 then
				local f65_local8 = f65_local19:create(f65_local14)
				f65_local8:set(f65_local15)
			end
		end
	end
	f65_local3:set(f65_local4)
	Engine[0x6A489878620F3BC](f65_local3)
end
Lobby.Clans.PopulateUIClanMemberModels = function(f66_arg0)
	local f66_local0 = Lobby.Clans.GetControllerClanModel(f66_arg0.xuidStr)
	local f66_local1 = f66_local0:create("members")
	local f66_local2 = f66_local1:create("list")
	local f66_local3 = Engine[0x8DF2E5447F384B9]()
	f66_local3 = f66_local3:create("socialRoot")
	local f66_local4 = f66_local3:create("clans")
	if #f66_arg0[f0_local6].data == 0 then
		local f66_local5 = f66_local1:create("count")
		f66_local5:set(0)
		f66_local5 = f66_local4:create("countMember")
		f66_local5:set(0)
		return
	elseif #f66_arg0[f0_local6].data > 1 then
		for f66_local9, f66_local10 in ipairs(f66_arg0[f0_local6].data) do
			if f66_arg0.xuid == f66_local10.userID then
				local f66_local8 = f66_arg0[f0_local6].data[1]
				f66_arg0[f0_local6].data[1] = f66_arg0[f0_local6].data[f66_local9]
				f66_arg0[f0_local6].data[f66_local9] = f66_local8
				break
			end
		end
	end
	local f66_local5 = 0
	for f66_local10, f66_local8 in ipairs(f66_arg0[f0_local6].data) do
		local f66_local17 = Engine[0x5065E759595C457](f66_local8.userID)
		f66_local5 = f66_local5 + 1
		local f66_local18 = f66_local2:create("member" .. f66_local5)
		local f66_local19 = f66_local18:create("xuidStr")
		f66_local19:set(f66_local17)
		f66_local19 = f66_local1:create(f66_local17)
		local f66_local20 = f66_local19:create("xuid")
		f66_local20:set(f66_local8.userID)
		f66_local20 = f66_local19:create("clans")
		local f66_local21 = f66_local19:create("squads")
		local f66_local22 = f66_local19:create("teams")
		local f66_local23 = 0
		local f66_local24 = 0
		local f66_local25 = 0
		for f66_local13, f66_local14 in ipairs(f66_local8.clansGroupMembershipInfo) do
			local f66_local11 = f66_local20
			if f66_local14.clansGroupIdentifier.kind == LuaEnum.CLAN_KINDS.CLAN then
				f66_local11 = f66_local20:create("clan" .. f66_local23 + 1)
			elseif f66_local14.clansGroupIdentifier.kind == LuaEnum.CLAN_KINDS.SQUAD then
				f66_local11 = f66_local21:create("squad" .. f66_local24 + 1)
			elseif f66_local14.clansGroupIdentifier.kind == LuaEnum.CLAN_KINDS.TEAM then
				f66_local11 = f66_local22:create("team" .. f66_local25 + 1)
			end
			local f66_local12 = f66_local11:create("role")
			f66_local12:set(f66_local14.role)
			f66_local12 = f66_local11:create("ID")
			f66_local12:set(f66_local14.clansGroupIdentifier.ID)
		end
		f66_local16 = f66_local20:create("count")
		f66_local16:set(f66_local23)
		f66_local16 = f66_local21:create("count")
		f66_local16:set(f66_local24)
		f66_local16 = f66_local22:create("count")
		f66_local16:set(f66_local25)
	end
	f66_local6 = f66_local1:create("count")
	f66_local6:set(f66_local5)
	f66_local6 = f66_local4:create("countMember")
	f66_local6:set(f66_local5)
end
Lobby.Clans.PopulateUIFriendClanModels = function(f67_arg0)
	local f67_local0 = Engine[0x8DF2E5447F384B9]()
	local f67_local1 = f67_local0.socialRoot:create("clans")
	local f67_local2 = f67_local1:create("friendsClans")
	local f67_local3 = f67_local2:create("list")
	if #f67_arg0[f0_local2].list == 0 then
		local f67_local4 = f67_local2:create("count")
		f67_local4:set(0)
		return
	end
	local f67_local4 = 1
	for f67_local9, f67_local10 in ipairs(f67_arg0[f0_local2].list) do
		local f67_local11 = f67_local2:create(f67_local10.IDstr)
		if not f67_local11.count then
			local f67_local8 = f67_local3:create(f67_local4)
			f67_local8:set(f67_local10.IDstr)
			f67_local8 = f67_local11:create("count")
			f67_local8:set(0)
		end
		local f67_local8 = f67_local11:create("count")
		f67_local8:set(f67_local11.count:get() + 1)
		f67_local8 = f67_local11:create("member" .. f67_local11.count:get())
		f67_local8:set(f67_local10.xuid)
	end
	f67_local5 = f67_local2:create("count")
	f67_local5:set(f67_local4)
end
Lobby.Clans.DoClanAction = function(f68_arg0, f68_arg1)
	Engine[0xE1789115A2356E7]("clan_action", {
		controller = f68_arg0,
		actionType = f68_arg1,
		immediate = true,
	})
end
