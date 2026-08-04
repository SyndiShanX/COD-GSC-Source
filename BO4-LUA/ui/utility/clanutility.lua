require("ui/utility/overlayutility")
CoD.ClanUtility = {}
CoD.ClanUtility.clan_privacy_levels = {
	{
		display_string = @"hash_640B0BA5E6EC0A0F",
		value = Enum[@"hash_6C491AC72605E0C3"][@"hash_4B91F60B176A25F1"],
	},
	{
		display_string = @"hash_19CB638F61EA2233",
		value = Enum[@"hash_6C491AC72605E0C3"][@"hash_76C66A50C1991611"],
	},
	{
		display_string = "clan/privacy_invite_only",
		value = Enum[@"hash_6C491AC72605E0C3"][@"hash_54A7DCCE66FFD267"],
	},
	{
		display_string = @"hash_11EBDB3A744A37C8",
		value = Enum[@"hash_6C491AC72605E0C3"][0xC009B7E8A40812],
	},
}
CoD.ClanUtility.clan_styles = {
	{
		display_string = "clan/none",
		value = LuaEnum.CLAN_STYLE.NONE,
	},
	{
		display_string = "clan/casual",
		value = LuaEnum.CLAN_STYLE.CASUAL,
	},
	{
		display_string = "clan/competitive",
		value = LuaEnum.CLAN_STYLE.COMPETITIVE,
	},
}
CoD.ClanUtility.updateTime = nil
CoD.ClanUtility.GetControllerClanModel = function(f1_arg0)
	return f1_local1[f1_local0] and f1_local1[f1_local0]:create("clan")
end
CoD.ClanUtility.Social_MainPreLoad = function(f2_arg0)
	Engine[@"lobbyevent"]("OnClanUIEvent", {
		controller = f2_arg0,
		event = LuaEnum.CLAN_UI_EVENT.INIT_MODELS,
	})
end
CoD.ClanUtility.Social_ClanPreLoad = function(f3_arg0)
	Engine[@"lobbyevent"]("OnClanUIEvent", {
		controller = f3_arg0,
		event = LuaEnum.CLAN_UI_EVENT.FETCH_DATA,
	})
end
CoD.ClanUtility.InboxPreLoad = function(f4_arg0)
	Engine[@"lobbyevent"]("OnClanUIEvent", {
		controller = f4_arg0,
		event = LuaEnum.CLAN_UI_EVENT.REFETCH_ALL,
	})
	local f4_local0 = Engine.GetGlobalModel()
	f4_local0 = f4_local0.socialRoot:create("ClanInbox")
	local f4_local1 = f4_local0:create("loadedGroupInbox")
	f4_local1:set(false)
	f4_local1 = f4_local0:create("loadedUserInbox")
	f4_local1:set(false)
	f4_local1 = f4_local0:create("fullyLoaded")
	f4_local1:set(false)
end
CoD.ClanUtility.UInt64ToString = function(f5_arg0)
	if f5_arg0 == nil or f5_arg0 == "" then
		return ""
	else
		return Engine[@"xuidtostring"](f5_arg0)
	end
end
CoD.ClanUtility.CurrentGroupFinderString = function(f6_arg0)
	local f6_local0 = CoD.ClanUtility.GetCurrentGroupKindDependingOnCurrentTab()
	if f6_local0 == LuaEnum.CLAN_KINDS.TEAM then
		return "clan/team_finder"
	elseif f6_local0 == LuaEnum.CLAN_KINDS.SQUAD then
		return "clan/squad_finder"
	else
		return "clan/clan_finder"
	end
end
CoD.ClanUtility.GetGroupPrivacyString = function(f7_arg0)
	local f7_local0 = math.floor(tonumber(f7_arg0))
	f7_arg0 = 0x0
	if f7_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_4B91F60B176A25F1"] then
		f7_arg0 = @"hash_640B0BA5E6EC0A0F"
	elseif f7_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_76C66A50C1991611"] then
		f7_arg0 = @"hash_19CB638F61EA2233"
	elseif f7_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_54A7DCCE66FFD267"] then
		f7_arg0 = "clan/privacy_invite_only"
	elseif f7_local0 == Enum[@"hash_6C491AC72605E0C3"][0xC009B7E8A40812] then
		f7_arg0 = 0x0
	end
	return f7_arg0
end
CoD.ClanUtility.GetGroupMemberRoleString = function(f8_arg0)
	local f8_local0 = math.floor(tonumber(f8_arg0))
	f8_arg0 = 0x0
	if f8_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4B17C2FE5CC7F0BC"] then
		f8_arg0 = 0x0
	elseif f8_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_29B9CAA2877C8082"] then
		f8_arg0 = @"hash_3B6A6E92CD2A9A42"
	elseif f8_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
		f8_arg0 = @"hash_5CE060CF2E578D06"
	end
	return f8_arg0
end
CoD.ClanUtility.GetClanJoinPopupTitle = function(f9_arg0)
	local f9_local0 = math.floor(tonumber(f9_arg0))
	f9_arg0 = 0x0
	if f9_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_4B91F60B176A25F1"] then
		f9_arg0 = @"hash_22D45A9F09D391D1"
	elseif f9_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_76C66A50C1991611"] then
		f9_arg0 = @"hash_5AAC117F1AF404AD"
	elseif f9_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_54A7DCCE66FFD267"] then
		f9_arg0 = @"hash_7F35B82EA88A7D5"
	elseif f9_local0 == Enum[@"hash_6C491AC72605E0C3"][0xC009B7E8A40812] then
		f9_arg0 = 0x0
	end
	return f9_arg0
end
CoD.ClanUtility.GetClanJoinPopupDescription = function(f10_arg0, f10_arg1)
	local f10_local0 = math.floor(tonumber(f10_arg1))
	f10_arg1 = 0x0
	if f10_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_4B91F60B176A25F1"] then
		if LuaEnum.CLAN_GROUP_MAX_SIZE[f10_arg0.kind:get()] < f10_arg0.memberCount:get() then
			f10_arg1 = @"hash_6354D07C0FDBED43"
		else
			f10_arg1 = @"hash_147873959E777CD1"
		end
	elseif f10_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_76C66A50C1991611"] then
		f10_arg1 = @"hash_E8C09967BA181E5"
	elseif f10_local0 == Enum[@"hash_6C491AC72605E0C3"][@"hash_54A7DCCE66FFD267"] then
		f10_arg1 = @"hash_1C4AEDECF4F5AE8D"
	elseif f10_local0 == Enum[@"hash_6C491AC72605E0C3"][0xC009B7E8A40812] then
		f10_arg1 = 0x0
	end
	return f10_arg1
end
CoD.ClanUtility.GetMailTitle = function(f11_arg0, f11_arg1)
	local f11_local0 = true
	if f11_arg0.proposingUserID:get() == f11_arg0.targetUserID:get() then
		f11_local0 = false
	end
	local f11_local1 = f11_arg0.groupIdentifier.kind:get()
	f11_arg1 = 0x0
	if f11_local1 == LuaEnum.CLAN_KINDS.CLAN then
		if f11_local0 then
			local f11_local2 = @"hash_73DE0E78E533C055"
		end
		f11_arg1 = f11_local2 or @"hash_5316F70429D838E8"
	elseif f11_local1 == LuaEnum.CLAN_KINDS.SQUAD then
		if f11_local0 then
			local f11_local3 = @"hash_7E75B7DB1589701F"
		end
		f11_arg1 = f11_local3 or @"hash_3C9E9B04C052AB84"
	elseif f11_local1 == LuaEnum.CLAN_KINDS.TEAM then
		if f11_local0 then
			local f11_local4 = @"hash_5CD19407891245A4"
		end
		f11_arg1 = f11_local4 or @"hash_3A978559CAF5378D"
	end
	local f11_local5 = f11_arg0.groupInfo:get()
	return Engine[@"hash_4F9F1239CFD921FE"](f11_arg1, f11_local5.name:get())
end
CoD.ClanUtility.GetMailMessage = function(f12_arg0, f12_arg1)
	local f12_local0 = true
	if f12_arg0.proposingUserID:get() == f12_arg0.targetUserID:get() then
		f12_local0 = false
	end
	local f12_local1 = f12_arg0.groupIdentifier.kind:get()
	f12_arg1 = 0x0
	if f12_local1 == LuaEnum.CLAN_KINDS.CLAN then
		if f12_local0 then
			local f12_local2 = @"hash_48DE650F395FECD"
		end
		f12_arg1 = f12_local2 or @"hash_18D90AA929A729B1"
	elseif f12_local1 == LuaEnum.CLAN_KINDS.SQUAD then
		if f12_local0 then
			local f12_local3 = @"hash_3D80410F3DEA6F16"
		end
		f12_arg1 = f12_local3 or @"hash_7B496EBE8B002409"
	elseif f12_local1 == LuaEnum.CLAN_KINDS.TEAM then
		if f12_local0 then
			local f12_local4 = @"hash_16B059B6B2DFA729"
		end
		f12_arg1 = f12_local4 or @"hash_25A082CBA7746AD8"
	end
	local f12_local5 = f12_arg0.groupInfo:get()
	return Engine[@"hash_4F9F1239CFD921FE"](f12_arg1, f12_local5.name:get())
end
CoD.ClanUtility.GetClanEmblemSlotParams = function(f13_arg0, f13_arg1)
	if Dvar[@"hash_3CA8E9EDE02C25E6"]:get() then
		local f13_local0 = CoDShared.GetXUID64StringForController(f13_arg0)
		local f13_local1 = Engine.GetGlobalModel()
		local f13_local2 = f13_local1.LobbyClients[f13_local0]:create("clan")
		if f13_local2.clans ~= nil then
			for f13_local3 = 1, f13_local2.clans.count:get() or 0, 1 do
				local f13_local6 = f13_local2.clans
				local f13_local7 = "clan"
				if f13_arg1 == f13_local6["clan" .. f13_local3].ID:get() then
					return f13_arg0, LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM - 1 + f13_local3, Enum.StorageFileType[@"hash_394DF15E8078D20A"]
				end
			end
			for f13_local3 = 1, f13_local2.squads.count:get() or 0, 1 do
				local f13_local6 = f13_local2.squads
				local f13_local7 = "squad"
				if f13_arg1 == f13_local6["squad" .. f13_local3].ID:get() then
					return f13_arg0, LuaEnum.CLAN_STORAGE_SLOT.SQUAD_1_EMBLEM - 1 + f13_local3, Enum.StorageFileType[@"hash_394DF15E8078D20A"]
				end
			end
			for f13_local3 = 1, f13_local2.teams.count:get() or 0, 1 do
				local f13_local6 = f13_local2.teams
				local f13_local7 = "team"
				if f13_arg1 == f13_local6["team" .. f13_local3].ID:get() then
					return f13_arg0, LuaEnum.CLAN_STORAGE_SLOT.TEAM_1_EMBLEM - 1 + f13_local3, Enum.StorageFileType[@"hash_394DF15E8078D20A"]
				end
			end
		end
	end
	return f13_arg0, LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM, Enum.StorageFileType[@"hash_394DF15E8078D20A"]
end
DataSources.GroupRenderInfo = {
	getModel = function()
		local f14_local0 = Engine.GetGlobalModel()
		f14_local0 = f14_local0.GroupRenderInfo
		if not f14_local0 then
			local f14_local1 = Engine.GetGlobalModel()
			f14_local0 = f14_local1:create("GroupRenderInfo")
			f14_local1 = f14_local0:create("ownerID")
			f14_local1:set(LuaDefine.ZERO_X64)
			f14_local1 = f14_local0:create("rootID")
			f14_local1:set(LuaDefine.ZERO_X64)
			f14_local1 = f14_local0:create("groupKind")
			f14_local1:set(0)
		end
		return f14_local0
	end,
}
CoD.ClanUtility.GetClanEmblemRenderParams = function(f15_arg0, f15_arg1)
	local f15_local0 = DataSources.GroupRenderInfo:getModel()
	Engine[@"lobbyevent"]("OnClanUIEvent", {
		dataRequestType = LuaEnum.CLAN_DATA_REQUEST_TYPE.EMBLEM_RENDER_INFO,
		rootModel = LuaEnum.CLAN_ROOT_MODEL.GLOBAL,
		path = "GroupRenderInfo",
		controller = f15_arg0,
		event = LuaEnum.CLAN_UI_EVENT.DATA_REQUEST,
		groupID = f15_arg1,
	})
	return f15_arg1, f15_local0.ownerID:get(), f15_local0.rootID:get(), f15_local0.groupKind:get()
end
CoD.ClanUtility.IsClanMember = function(f16_arg0)
	local f16_local0 = CoD.ClanUtility.GetControllerClanModel(f16_arg0)
	f16_local0 = f16_local0.clans
	if f16_local0.count == nil or f16_local0.count:get() == 0 then
		return false
	else
		return true
	end
end
CoD.ClanUtility.IsClanAdminOrOwner = function(f17_arg0)
	local f17_local0 = CoD.ClanUtility.GetControllerClanModel(f17_arg0)
	if f17_local0 then
		local f17_local1 = f17_local0.clans:create("clan1")
		if f17_local1 then
			local f17_local2 = f17_local1.role and f17_local1.role:get() or nil
			local f17_local3
			if f17_local2 ~= Enum[@"hash_610C0A769A29C38F"][@"hash_29B9CAA2877C8082"] and f17_local2 ~= Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
				f17_local3 = false
			else
				f17_local3 = true
			end
			return f17_local3
		end
	end
	return false
end
CoD.ClanUtility.IsTeamAdminOrOwner = function(f18_arg0)
	local f18_local0 = CoD.ClanUtility.GetControllerClanModel(f18_arg0)
	local f18_local1 = f18_local0:get("teams")
	if f18_local1 and f18_local1.count:get() > 0 then
		for f18_local2 = 1, f18_local1.count:get(), 1 do
			local f18_local5 = "team"
			f18_local5 = f18_local1["team" .. f18_local2].role and f18_local1.role["team" .. f18_local2]:get() or nil
			if f18_local5 == Enum[@"hash_610C0A769A29C38F"][@"hash_29B9CAA2877C8082"] or f18_local5 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
				return true
			end
		end
	end
	return false
end
CoD.ClanUtility.ShowClanOptionPrompt = function(f19_arg0)
	local f19_local0 = Engine.GetGlobalModel()
	f19_local0 = f19_local0["socialRoot.tab"]
	local f19_local1 = CoD.ClanUtility.GetControllerClanModel(f19_arg0)
	if f19_local0:get() == "clan" and f19_local1 and f19_local1.clans and f19_local1.clans.clan1 and f19_local1.clans.clan1.groupinfo then
		return true
	else
		return false
	end
end
CoD.ClanUtility.ShowSquadOptionPrompt = function(f20_arg0)
	local f20_local0 = Engine.GetGlobalModel()
	if f20_local0["socialRoot.tab"]:get() == "clan_Squad" then
		return true
	else
		return false
	end
end
CoD.ClanUtility.ShowTeamOptionPrompt = function(f21_arg0)
	local f21_local0 = Engine.GetGlobalModel()
	if f21_local0["socialRoot.tab"]:get() == "clan_Team" then
		return true
	else
		return false
	end
end
CoD.ClanUtility.GetCurrentGroupKindDependingOnCurrentTab = function()
	local f22_local0 = Engine.GetGlobalModel()
	f22_local0 = f22_local0["socialRoot.tab"]
	if f22_local0:get() == "clan_Team" then
		return LuaEnum.CLAN_KINDS.TEAM
	elseif f22_local0:get() == "clan_Squad" then
		return LuaEnum.CLAN_KINDS.SQUAD
	else
		return LuaEnum.CLAN_KINDS.CLAN
	end
end
CoD.ClanUtility.GetGroupKindStr = function(f23_arg0)
	if f23_arg0 == LuaEnum.CLAN_KINDS.TEAM then
		return "TEAM"
	elseif f23_arg0 == LuaEnum.CLAN_KINDS.SQUAD then
		return "SQUAD"
	else
		return "CLAN"
	end
end
CoD.ClanUtility.GetGroupInfoFromModel = function(f24_arg0)
	return f24_arg0.groupInfo and f24_arg0.groupInfo:get()
end
CoD.ClanUtility.IsInClan = function(f25_arg0)
	local f25_local0 = CoD.ClanUtility.GetControllerClanModel(f25_arg0)
	return f25_local0.clans.count:get() > 0
end
CoD.ClanUtility.GetYourClanID = function(f26_arg0)
	local f26_local0 = CoD.ClanUtility.GetControllerClanModel(f26_arg0)
	local f26_local1 = f26_local0.clans.clan1
	if f26_local1 then
		f26_local1 = f26_local0.clans.clan1.ID
		if f26_local1 then
			f26_local1 = f26_local0.clans.clan1.ID:get()
		end
	end
	return f26_local1
end
CoD.ClanUtility.IsInASquad = function(f27_arg0)
	return f27_local1.count and f27_local2 and f27_local1.count:get() > 0
end
CoD.ClanUtility.IsAtSquadLimit = function(f28_arg0)
	return f28_local1.count and f28_local2 and f28_local1.count:get() == LuaEnum.KIND_MEMBERSHIP_CAP.SQUAD
end
CoD.ClanUtility.IsInATeam = function(f29_arg0)
	return f29_local1.count and f29_local2 and f29_local1.count:get() > 0
end
CoD.ClanUtility.IsAtTeamLimit = function(f30_arg0)
	return f30_local1.count and f30_local2 and f30_local1.count:get() == LuaEnum.KIND_MEMBERSHIP_CAP.TEAM
end
CoD.ClanUtility.IsInvite = function(f31_arg0, f31_arg1)
	return f31_arg0 ~= f31_arg1
end
CoD.ClanUtility.IsRequest = function(f32_arg0, f32_arg1)
	return f32_arg0 == f32_arg1
end
CoD.ClanUtility.GetProposalPopupTitle = function(f33_arg0)
	local f33_local0 = true
	if f33_arg0.proposingUserID:get() == f33_arg0.targetUserID:get() then
		f33_local0 = false
	end
	local f33_local1 = f33_arg0.groupIdentifier.kind:get()
	local f33_local2 = 0x0
	if f33_local1 == LuaEnum.CLAN_KINDS.CLAN then
		if f33_local0 then
			local f33_local3 = @"hash_3CCFAE77A99C4D2F"
		end
		f33_local2 = f33_local3 or @"hash_153541DE7BF4E764"
	elseif f33_local1 == LuaEnum.CLAN_KINDS.SQUAD then
		if f33_local0 then
			local f33_local4 = @"hash_43DD3B807EBABBD9"
		end
		f33_local2 = f33_local4 or @"hash_76219861E920EB1E"
	else
		if f33_local0 then
			local f33_local5 = @"hash_316CF37A800D9B04"
		end
		f33_local2 = f33_local5 or @"hash_358AF808D349E877"
	end
	return f33_local2
end
CoD.ClanUtility.GetProposalPopupDescription = function(f34_arg0)
	local f34_local0 = true
	if f34_arg0.proposingUserID:get() == f34_arg0.targetUserID:get() then
		f34_local0 = false
	end
	local f34_local1 = f34_arg0.groupIdentifier.kind:get()
	local f34_local2 = 0x0
	if f34_local1 == LuaEnum.CLAN_KINDS.CLAN then
		if f34_local0 then
			local f34_local3 = @"hash_2570239D24E2A232"
		end
		f34_local2 = f34_local3 or @"hash_791EFB07CBB14BE3"
	elseif f34_local1 == LuaEnum.CLAN_KINDS.SQUAD then
		if f34_local0 then
			local f34_local4 = @"hash_7EFC49B496D15B0"
		end
		f34_local2 = f34_local4 or @"hash_5502ACC8B5882C9"
	else
		if f34_local0 then
			local f34_local5 = @"hash_6141FD471FDD6C03"
		end
		f34_local2 = f34_local5 or @"hash_EFC3A1F0954312A"
	end
	return f34_local2
end
CoD.ClanUtility.GetAcceptProposalButtonPrompt = function(f35_arg0, f35_arg1)
	local f35_local0 = f35_arg1.groupIdentifier.kind:get()
	local f35_local1 = @"menu/accept"
	if f35_local0 == LuaEnum.CLAN_KINDS.CLAN and CoD.ClanUtility.IsInClan(f35_arg0) then
		f35_local1 = @"hash_1C0E086801BD8156"
	end
	return f35_local1
end
CoD.ClanUtility.GetAcceptProposalButtonHint = function(f36_arg0, f36_arg1)
	local f36_local0 = f36_arg1.groupIdentifier.kind:get()
	local f36_local1 = ""
	if f36_local0 == LuaEnum.CLAN_KINDS.CLAN and CoD.ClanUtility.IsInClan(f36_arg0) then
		f36_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4C52898523CBEEC0")
	end
	return f36_local1
end
CoD.ClanUtility.GetDeclineProposalButtonInfo = function(f37_arg0, f37_arg1)
	local f37_local0 = f37_arg1.groupIdentifier.kind:get()
	if f37_local0 == LuaEnum.CLAN_KINDS.CLAN then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EB69DF28EC53161", "clan")
	elseif f37_local0 == LuaEnum.CLAN_KINDS.SQUAD then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EB69DF28EC53161", "squad")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EB69DF28EC53161", "team")
	end
end
CoD.ClanUtility.IsAcceptProposalButtonDisabled = function(f38_arg0, f38_arg1)
	local f38_local0 = f38_arg1.groupIdentifier.kind:get()
	if f38_local0 == LuaEnum.CLAN_KINDS.CLAN then
		return false
	elseif f38_local0 == LuaEnum.CLAN_KINDS.SQUAD then
		return CoD.ClanUtility.IsAtSquadLimit(f38_arg0)
	else
		return CoD.ClanUtility.IsAtTeamLimit(f38_arg0)
	end
end
CoD.ClanUtility.GetGroupIDToReplace = function(f39_arg0, f39_arg1)
	local f39_local0 = f39_arg1.groupIdentifier.kind:get()
	if f39_local0 == LuaEnum.CLAN_KINDS.CLAN then
		return CoD.ClanUtility.GetYourClanID(f39_arg0)
	elseif f39_local0 == LuaEnum.CLAN_KINDS.SQUAD then
		return LuaDefine.ZERO_X64
	else
		return LuaDefine.ZERO_X64
	end
end
CoD.ClanUtility.GetWarningProposalPrompt = function(f40_arg0, f40_arg1)
	local f40_local0 = 0x0
	if CoD.ClanUtility.IsTeamAdminOrOwner(f40_arg0) then
		f40_local0 = @"hash_B5AC2259A5C0DAE"
	elseif CoD.ClanUtility.IsClanAdminOrOwner(f40_arg0) then
		f40_local0 = @"hash_11497D2F448196BF"
	end
	if f40_arg1 then
		local f40_local1 = f40_arg1.groupInfo
		if f40_local1 then
			f40_local1 = f40_arg1.groupInfo:get()
		end
		if f40_local1 and LuaEnum.CLAN_GROUP_MAX_SIZE[f40_local1.kind:get()] <= f40_local1.memberCount:get() then
			f40_local0 = @"hash_3F182F0BC7C7C48A"
		end
	end
	return f40_local0
end
CoD.ClanUtility.SetOverlayWarningText = function(f41_arg0, f41_arg1)
	local f41_local0 = f41_arg0 and f41_arg0:getModel(f41_arg1, "warningText")
	if f41_local0 and f41_local0:get() then
		local f41_local1 = DataSources.GroupOverlayInfo.getModel()
		f41_local1.warningText:set(f41_local0:get())
	else
		local f41_local1 = DataSources.GroupOverlayInfo.getModel()
		f41_local1.warningText:set("")
	end
end
CoD.ClanUtility.SetOverlayInfoText = function(f42_arg0, f42_arg1)
	local f42_local0 = f42_arg0 and f42_arg0:getModel(f42_arg1, "infoText")
	if f42_local0 and f42_local0:get() then
		local f42_local1 = DataSources.GroupOverlayInfo.getModel()
		f42_local1.infoText:set(f42_local0:get())
	else
		local f42_local1 = DataSources.GroupOverlayInfo.getModel()
		f42_local1.infoText:set("")
	end
end
CoD.ClanUtility.ClanAcceptCancelInboxProposal = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4)
	local f43_local0 = f43_arg1:getModel()
	local f43_local1 = CoD.ClanUtility.GetProposalPopupTitle(f43_local0)
	local f43_local2 = CoD.ClanUtility.GetWarningProposalPrompt(f43_arg2, f43_local0)
	if f43_local2 ~= 0x0 then
		OpenGenericSmallPopup(f43_arg0, f43_arg2, Engine[@"hash_4F9F1239CFD921FE"](f43_local1), Engine[@"hash_4F9F1239CFD921FE"](f43_local2), nil, Engine[@"hash_4F9F1239CFD921FE"](@"menu/ok"))
		return
	else
		CoD.OverlayUtility.CreateOverlay(f43_arg2, f43_arg4, "GroupProposalOverlay", {
			_model = f43_local0,
			_title = f43_local1,
			_desc = CoD.ClanUtility.GetProposalPopupDescription(f43_local0),
		})
	end
end
CoD.ClanUtility.IsInboxEmpty = function()
	return CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.ClanInbox.count", 0)
end
DataSources.GroupOverlayInfo = {
	getModel = function()
		local f45_local0 = Engine.GetGlobalModel()
		f45_local0 = f45_local0.GroupOverlayInfo
		if not f45_local0 then
			local f45_local1 = Engine.GetGlobalModel()
			f45_local0 = f45_local1:create("GroupOverlayInfo")
			f45_local1 = f45_local0:create("warningText")
			f45_local1:set("")
			f45_local1 = f45_local0:create("infoText")
			f45_local1:set("")
		end
		return f45_local0
	end,
}
CoD.OverlayUtility.AddSystemOverlay("GroupProposalOverlay", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_GroupFrame",
	title = function(f46_arg0)
		return Engine[@"hash_4F9F1239CFD921FE"](f46_arg0._title)
	end,
	description = function(f47_arg0)
		return Engine[@"hash_4F9F1239CFD921FE"](f47_arg0._desc)
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = "ClanInboxButtonList",
	groupName = function(f48_arg0)
		local f48_local0 = CoD.ClanUtility.GetGroupInfoFromModel(f48_arg0._model)
		return f48_local0.name:get()
	end,
	groupId = function(f49_arg0)
		local f49_local0 = CoD.ClanUtility.GetGroupInfoFromModel(f49_arg0._model)
		return f49_local0.id:get()
	end,
	preCreateStep = function(f50_arg0, f50_arg1, f50_arg2)
		f50_arg0._model = f50_arg2._model
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
})
DataSources.ClanInboxButtonList = DataSourceHelpers.ListSetup("ClanInboxButtonList", function(f51_arg0, f51_arg1)
	local f51_local0 = CoD.BaseUtility.GetMenuModel(f51_arg1.menu)
	local f51_local1 = f51_local0.groupInfo:get()
	local f51_local2 = true
	if f51_local0.proposingUserID:get() == f51_local0.targetUserID:get() then
		f51_local2 = false
	end
	local f51_local3 = {
		action = LuaEnum.POPUP_ACTION.ACCEPT,
		emblem = f51_local0.emblem:get(),
		name = f51_local1.name:get(),
		isInvite = f51_local2,
		proposingUserID = f51_local0.proposingUserID:get(),
		proposingUserAccountType = f51_local0.proposingUserAccountType:get(),
		xuid = f51_local0.targetUserID:get(),
		targetUserID = f51_local0.targetUserID:get(),
		targetUserAccountType = f51_local0.targetUserAccountType:get(),
		role = f51_local0.role:get(),
		kind = f51_local0.groupIdentifier.kind:get(),
		ID = f51_local0.groupIdentifier.ID:get(),
		rootKind = f51_local0.groupIdentifier.rootKind:get(),
		rootID = f51_local0.groupIdentifier.rootID:get(),
		privacyLevel = f51_local1.privacyLevel:get(),
		memberCount = f51_local1.memberCount:get(),
		replacesGroupID = CoD.ClanUtility.GetGroupIDToReplace(f51_arg0, f51_local0),
		replacesRootID = CoD.ClanUtility.GetYourClanID(f51_arg0),
		hasAttachment = f51_local0.hasAttachment:get(),
		updatedTimestamp = f51_local0.updatedTimestamp:get(),
	}
	local f51_local4 = LUI.ShallowCopy(f51_local3)
	f51_local4.action = LuaEnum.POPUP_ACTION.REJECT
	local f51_local5 = {}
	table.insert(f51_local5, {
		displayText = CoD.ClanUtility.GetAcceptProposalButtonPrompt(f51_arg0, f51_local0),
		warningText = CoD.ClanUtility.GetAcceptProposalButtonHint(f51_arg0, f51_local0),
		action = CoD.ClanUtility.ClanAcceptCancelInboxProposalPopupButtonPress,
		params = f51_local3,
		disabled = CoD.ClanUtility.IsAcceptProposalButtonDisabled(f51_arg0, f51_local0),
	})
	local f51_local6 = table.insert
	local f51_local7 = f51_local5
	local f51_local8 = {}
	local f51_local9
	if f51_local2 then
		f51_local9 = "clan/delete"
		if not f51_local9 then
		else
			f51_local8.displayText = f51_local9
			f51_local8.infoText = CoD.ClanUtility.GetDeclineProposalButtonInfo(f51_arg0, f51_local0)
			f51_local8.action = CoD.ClanUtility.ClanAcceptCancelInboxProposalPopupButtonPress
			f51_local8.params = f51_local4
			f51_local8.disabled = false
			f51_local6(f51_local7, f51_local8)
			f51_local6 = {}
			for f51_local10, f51_local11 in ipairs(f51_local5) do
				table.insert(f51_local6, {
					models = {
						displayText = f51_local11.displayText,
						warningText = f51_local11.warningText,
						infoText = f51_local11.infoText,
						proposalModel = f51_local0,
					},
					properties = {
						action = f51_local11.action,
						actionParam = f51_local11.params,
						disabled = f51_local11.disabled,
					},
				})
			end
			return f51_local6
		end
	end
	f51_local9 = "clan/reject"
end)
CoD.ClanUtility.AssignEmblemsToClanSquadTeam = function(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = 0
	local f52_local1 = CoD.ClanUtility.GetControllerClanModel(f52_arg2)
	local f52_local2 = f52_local1.clans:create("clan1")
	local f52_local3 = {
		Enum.StorageFileType[@"hash_394DF15E8078D20A"],
	}
	local f52_local4 = {
		LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM,
	}
	local f52_local5 = {}
	f52_local5 = f52_local2.kind:get()
	local f52_local6 = {}
	f52_local6 = f52_local2.ID:get()
	local f52_local7 = {}
	f52_local7 = f52_local2.rootKind:get()
	local f52_local8 = {}
	f52_local8 = f52_local2.rootID:get()
	local f52_local9 = {
		LuaEnum.CLAN_STORAGE.EMBLEM,
	}
	Engine.UploadEmblemData(f52_arg2, LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM, Enum.StorageFileType[@"hash_394DF15E8078D20A"])
	local f52_local10 = f52_local1.squads
	for f52_local11 = 1, f52_local10.count:get() or 0, 1 do
		local f52_local14 = f52_local10["squad" .. f52_local11]
		table.insert(f52_local3, Enum.StorageFileType[@"hash_394DF15E8078D20A"])
		table.insert(f52_local4, LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM + f52_local11)
		table.insert(f52_local5, f52_local14.kind:get())
		table.insert(f52_local6, f52_local14.ID:get())
		table.insert(f52_local7, f52_local14.rootKind:get())
		table.insert(f52_local8, f52_local14.rootID:get())
		table.insert(f52_local9, LuaEnum.CLAN_STORAGE.EMBLEM)
		f52_local0 = f52_local0 + 1
		Engine.SetupEmblemData(f52_arg2, f52_local0, Enum.StorageFileType[@"storage_default_emblems"], Enum.CustomizationType[@"customization_type_emblem"])
		Engine.UploadEmblemData(f52_arg2, LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM + f52_local11, Enum.StorageFileType[@"hash_394DF15E8078D20A"])
	end
	f52_local10 = f52_local1.teams
	for f52_local11 = 1, f52_local10.count:get() or 0, 1 do
		local f52_local14 = f52_local10["team" .. f52_local11]
		table.insert(f52_local3, Enum.StorageFileType[@"hash_394DF15E8078D20A"])
		table.insert(f52_local4, LuaEnum.CLAN_STORAGE_SLOT.SQUAD_3_EMBLEM + f52_local11)
		table.insert(f52_local5, f52_local14.kind:get())
		table.insert(f52_local6, f52_local14.ID:get())
		table.insert(f52_local7, f52_local14.rootKind:get())
		table.insert(f52_local8, f52_local14.rootID:get())
		table.insert(f52_local9, LuaEnum.CLAN_STORAGE.EMBLEM)
		f52_local0 = f52_local0 + 1
		Engine.SetupEmblemData(f52_arg2, f52_local0, Enum.StorageFileType[@"storage_default_emblems"], Enum.CustomizationType[@"customization_type_emblem"])
		Engine.UploadEmblemData(f52_arg2, LuaEnum.CLAN_STORAGE_SLOT.SQUAD_3_EMBLEM + f52_local11, Enum.StorageFileType[@"hash_394DF15E8078D20A"])
	end
	Engine[@"hash_37079182F35F6DF8"](f52_arg2, f52_local3, f52_local4, f52_local5, f52_local6, f52_local7, f52_local8, f52_local9)
end
CoD.ClanUtility.JoinClan = function(f53_arg0, f53_arg1, f53_arg2, f53_arg3, f53_arg4)
	OpenOverlay(f53_arg0, "ClanJoinPopup", f53_arg2, {
		_model = f53_arg1:getModel(),
	})
end
CoD.ClanUtility.ClanButtonPress = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4)
	local f54_local0 = f54_arg3.event
	if f54_local0 == "friends_clans" then
	elseif f54_local0 == "clan_finder" then
	elseif f54_local0 == "search_for_player" then
	elseif f54_local0 == "clan_overview" then
	elseif f54_local0 == "join_request" then
	elseif f54_local0 == "create_clan" then
	elseif f54_local0 == "teams_and_squads" then
	elseif f54_local0 == "admin_privileges" then
	elseif f54_local0 == "message_settings" then
	elseif f54_local0 == "clan_overview" then
	elseif f54_local0 == "transfer_ownership" then
	elseif f54_local0 == "banned_players" then
	elseif f54_local0 == "leave_clan" then
		CoD.ClanUtility.ConfirmLeaveGroup(f54_arg2, f54_arg3, nil, LuaEnum.CLAN_KINDS.CLAN, 1)
		GoBack(f54_arg0, f54_arg2)
	elseif f54_local0 == "delete_clan" then
		CoD.ClanUtility.ConfirmRemoveUserFromGroup(f54_arg2, Engine.GetXUID64(f54_arg2), f54_arg3, 0, LuaEnum.CLAN_KINDS.CLAN, 1)
		GoBack(f54_arg0, f54_arg2)
	end
end
CoD.ClanUtility.ConfirmLeaveGroup = function(f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4)
	CoD.ClanUtility.ConfirmRemoveUserFromGroup(f55_arg0, nil, f55_arg1, f55_arg2, f55_arg3, f55_arg4)
end
CoD.ClanUtility.ConfirmRemoveUserFromGroup = function(f56_arg0, f56_arg1, f56_arg2, f56_arg3, f56_arg4, f56_arg5)
	local f56_local0 = Engine[@"xuidtostring"](Engine.GetXUID64(f56_arg0))
	local f56_local1 = Engine.GetGlobalModel()
	local f56_local2 = f56_local1.LobbyClients[f56_local0]:create("clan")
	local f56_local3 = nil
	local f56_local4 = f56_local2.clans:create("clan1")
	if f56_arg4 == LuaEnum.CLAN_KINDS.CLAN then
		f56_local3 = f56_local2.clans:create("clan" .. f56_arg5)
	elseif f56_arg4 == LuaEnum.CLAN_KINDS.TEAM then
		f56_local3 = f56_local2.teams:create("team" .. f56_arg5)
	elseif f56_arg4 == LuaEnum.CLAN_KINDS.SQUAD then
		f56_local3 = f56_local2.squads:create("squad" .. f56_arg5)
	end
	f56_arg2.role = f56_local3.role:get()
	f56_arg2.kind = f56_local3.kind:get()
	f56_arg2.ID = f56_local3.ID:get()
	f56_arg2.IDstr = f56_local3.IDstr:get()
	f56_arg2.rootKind = f56_local3.rootKind:get()
	f56_arg2.rootID = f56_local3.rootID:get()
	f56_arg2.rootIDstr = f56_local3.rootIDstr:get()
	if f56_arg1 then
		f56_arg2.user = f56_arg1
	end
	if f56_arg3 then
		f56_arg2.newOwner = f56_arg3
	end
	f56_arg2.controller = f56_arg0
	f56_arg2.event = LuaEnum.CLAN_UI_EVENT.REMOVE_USER
	Engine[@"lobbyevent"]("OnClanUIEvent", f56_arg2)
end
CoD.ClanUtility.SquadAdminButtonPress = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4)
	local f57_local0 = f57_arg3.event
	local f57_local1 = CoD.ClanUtility.GetCurrentSquadId()
	if f57_local0 == "friends_squads" then
	elseif f57_local0 == "squad_finder" then
	elseif f57_local0 == "search_for_player" then
	elseif f57_local0 == "join_request" then
	elseif f57_local0 == "create_squad" then
	elseif f57_local0 == "transfer_ownership" then
	elseif f57_local0 == "banned_players" then
	elseif f57_local0 == "leave_squad" then
		CoD.ClanUtility.ConfirmLeaveGroup(f57_arg2, f57_arg3, nil, LuaEnum.CLAN_KINDS.SQUAD, f57_local1)
		GoBack(f57_arg0, f57_arg2)
	elseif f57_local0 == "delete_squad" then
		CoD.ClanUtility.ConfirmRemoveUserFromGroup(f57_arg2, Engine.GetXUID64(f57_arg2), f57_arg3, 0, LuaEnum.CLAN_KINDS.SQUAD, f57_local1)
		GoBack(f57_arg0, f57_arg2)
	end
end
CoD.ClanUtility.TeamAdminButtonPress = function(f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4)
	local f58_local0 = f58_arg3.event
	local f58_local1 = CoD.ClanUtility.GetCurrentTeamId()
	if f58_local0 == "friends_teams" then
	elseif f58_local0 == "team_finder" then
	elseif f58_local0 == "search_for_player" then
	elseif f58_local0 == "join_request" then
	elseif f58_local0 == "create_team" then
	elseif f58_local0 == "transfer_ownership" then
	elseif f58_local0 == "banned_players" then
	elseif f58_local0 == "leave_team" then
		CoD.ClanUtility.ConfirmLeaveGroup(f58_arg2, f58_arg3, nil, LuaEnum.CLAN_KINDS.TEAM, f58_local1)
		GoBack(f58_arg0, f58_arg2)
	elseif f58_local0 == "delete_team" then
		CoD.ClanUtility.ConfirmRemoveUserFromGroup(f58_arg2, Engine.GetXUID64(f58_arg2), f58_arg3, 0, LuaEnum.CLAN_KINDS.TEAM, f58_local1)
		GoBack(f58_arg0, f58_arg2)
	end
end
CoD.ClanUtility.ClanJoinPopupButtonPress = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3, f59_arg4)
	if f59_arg3.action == LuaEnum.POPUP_ACTION.ACCEPT then
		f59_arg3.controller = f59_arg2
		f59_arg3.event = LuaEnum.CLAN_UI_EVENT.JOIN_CLAN_SQUAD_TEAM
		Engine[@"lobbyevent"]("OnClanUIEvent", f59_arg3)
	end
	GoBack(f59_arg0, f59_arg2)
end
CoD.ClanUtility.ClanAcceptCancelInboxProposalPopupButtonPress = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3, f60_arg4)
	local f60_local0 = f60_arg3.action
	if f60_local0 == LuaEnum.POPUP_ACTION.ACCEPT or f60_local0 == LuaEnum.POPUP_ACTION.REJECT then
		f60_arg3.controller = f60_arg2
		if f60_local0 == LuaEnum.POPUP_ACTION.ACCEPT then
			local f60_local1 = f60_arg1:getModel()
			f60_local1 = f60_local1.proposalModel:get()
			f60_local1 = f60_local1:create("accepted")
			f60_local1:set(true)
		end
		if f60_arg3.replacesGroupID and f60_arg3.replacesGroupID ~= LuaDefine.ZERO_X64 then
			f60_arg3.event = LuaEnum.CLAN_UI_EVENT.REMOVE_USER
		else
			f60_arg3.event = LuaEnum.CLAN_UI_EVENT.PROPOSAL_ACTION
		end
		Engine[@"lobbyevent"]("OnClanUIEvent", f60_arg3)
	end
	GoBack(f60_arg0, f60_arg2)
end
CoD.ClanUtility.CreateClanNameDescHandleKeyboardComplete = function(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
	local f61_local0 = f61_arg2.input
	local f61_local1 = f61_arg3.createClanFormStrings
	local f61_local2 = DataSources.CreateClanForm.getModel(f61_arg1)
	if f61_local0 == nil then
		return
	end
	local f61_local3 = 0
	if f61_arg2.type == Enum.KeyboardType[@"hash_6C1A9F6974AA1C28"] then
		f61_local2.name:set(f61_local0)
		f61_local3 = 1
	elseif f61_arg2.type == Enum.KeyboardType[@"hash_73E8DD5E8D7F1377"] then
		f61_local2.description:set(f61_local0)
		f61_local3 = 2
	end
	local f61_local4 = DataSources.CreateClanNameDescription.getItem(f61_arg1, f61_local1, f61_local3)
	f61_local4.currentText:set(f61_local0)
end
CoD.ClanUtility.SearchClanNameHandleKeyboardComplete = function(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
	local f62_local0 = f62_arg2.input
	local f62_local1 = DataSources.ClanSearchFields.getModel(f62_arg1)
	if f62_local0 == nil then
		return
	else
		f62_local1.search:set(f62_local0)
		local f62_local2 = DataSources.SearchClanNameDescription.getItem(f62_arg1, f62_arg3, 1)
		f62_local2.currentText:set(f62_local0)
	end
end
CoD.ClanUtility.SetupEditBoxClanCreation = function(f63_arg0, f63_arg1, f63_arg2, f63_arg3, f63_arg4)
	CoD.ClanUtility.SetupEditBox(f63_arg0, f63_arg1, f63_arg2, f63_arg3, f63_arg4, DataSources.CreateClanForm)
end
CoD.ClanUtility.SetupEditBoxSquadCreation = function(f64_arg0, f64_arg1, f64_arg2, f64_arg3, f64_arg4)
	CoD.ClanUtility.SetupEditBoxControlWithDatasource(f64_arg0, f64_arg1, f64_arg2, f64_arg3, f64_arg4, DataSources.CreateSquadForm)
end
CoD.ClanUtility.SetupEditBoxTeamCreation = function(f65_arg0, f65_arg1, f65_arg2, f65_arg3, f65_arg4)
	CoD.ClanUtility.SetupEditBoxControlWithDatasource(f65_arg0, f65_arg1, f65_arg2, f65_arg3, f65_arg4, DataSources.CreateTeamForm)
end
CoD.ClanUtility.SetupEditBoxClanSearch = function(f66_arg0, f66_arg1, f66_arg2, f66_arg3, f66_arg4)
	CoD.ClanUtility.SetupEditBox(f66_arg0, f66_arg1.CurrentText, f66_arg2, f66_arg3, f66_arg4, DataSources.ClanSearchFields)
end
CoD.ClanUtility.SetupEditBoxControlWithDatasource = function(f67_arg0, f67_arg1, f67_arg2, f67_arg3, f67_arg4, f67_arg5, f67_arg6)
	local f67_local0 = Engine.GetModel(f67_arg5.getModel(f67_arg2), f67_arg4)
	if not f67_local0:get() then
		f67_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f67_arg1.CurrentText, f67_arg2, f67_arg3, f67_local0, nil, nil, f67_arg6)
end
CoD.ClanUtility.SetupEditBox = function(f68_arg0, f68_arg1, f68_arg2, f68_arg3, f68_arg4, f68_arg5)
	local f68_local0 = Engine.GetModel(f68_arg5.getModel(f68_arg2), f68_arg4)
	if not f68_local0:get() then
		f68_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f68_arg1, f68_arg2, f68_arg3, f68_local0, nil, nil, false)
end
CoD.ClanUtility.CreateSquadNameDescHandleKeyboardComplete = function(f69_arg0, f69_arg1, f69_arg2, f69_arg3)
	local f69_local0 = f69_arg2.input
	local f69_local1 = f69_arg3.createClanFormStrings
	local f69_local2 = DataSources.CreateSquadForm.getModel(f69_arg1)
	if f69_local0 == nil then
		return
	end
	local f69_local3 = 0
	if f69_arg2.type == Enum.KeyboardType[@"hash_6C1A9F6974AA1C28"] then
		f69_local2.name:set(f69_local0)
		f69_local3 = 1
	end
	local f69_local4 = DataSources.CreateSquadNameDescription.getItem(f69_arg1, f69_local1, f69_local3)
	f69_local4.currentText:set(f69_local0)
end
CoD.ClanUtility.CreateTeamNameDescHandleKeyboardComplete = function(f70_arg0, f70_arg1, f70_arg2, f70_arg3)
	local f70_local0 = f70_arg2.input
	local f70_local1 = f70_arg3.createClanFormStrings
	local f70_local2 = DataSources.CreateTeamForm.getModel(f70_arg1)
	if f70_local0 == nil then
		return
	end
	local f70_local3 = 0
	if f70_arg2.type == Enum.KeyboardType[@"hash_6C1A9F6974AA1C28"] then
		f70_local2.name:set(f70_local0)
		f70_local3 = 1
	end
	local f70_local4 = DataSources.CreateTeamNameDescription.getItem(f70_arg1, f70_local1, f70_local3)
	f70_local4.currentText:set(f70_local0)
end
CoD.ClanUtility.ClanEmblem_GainFocus = function(f71_arg0, f71_arg1, f71_arg2)
	CoD.perController[f71_arg2].selectedEmblemModel = f71_arg1:getModel()
	Engine.SetupEmblemData(f71_arg2, Engine.GetModelValue(f71_arg1:getModel(f71_arg2, "emblemIndex")), Enum.StorageFileType[@"storage_emblems"], Enum.CustomizationType[@"customization_type_emblem"])
end
CoD.ClanUtility.SearchCurrentGroupKind = function(f72_arg0)
	CoD.ClanUtility.SearchGroup(f72_arg0, CoD.ClanUtility.GetCurrentGroupKindDependingOnCurrentTab())
end
CoD.ClanUtility.SearchGroup = function(f73_arg0, f73_arg1)
	local f73_local0 = Engine.GetModelForController(f73_arg0)
	local f73_local1 = Engine.GetModel(f73_local0, "ClanSearchFields.friendsOnly")
	f73_local1 = f73_local1:get()
	local f73_local2 = Engine.GetModel(f73_local0, "ClanSearchFields.search")
	f73_local2 = f73_local2:get()
	if f73_local1 then
		local f73_local3 = Engine.GetModel(f73_local0, "ClanSearchFields.publicOnly")
		if not f73_local3:get() or not {
			Enum[@"hash_6C491AC72605E0C3"][@"hash_4B91F60B176A25F1"],
		} then
			local f73_local4 = {}
		end
		local f73_local5 = DataSources.ClanSearchFields.getFriendsClans(f73_arg0)
	else
		Engine[@"lobbyevent"]("OnClanUIEvent", {
			controller = f73_arg0,
			event = LuaEnum.CLAN_UI_EVENT.FIND_GROUPS,
			search = f73_local2,
			kind = f73_arg1,
		})
	end
end
CoD.ClanUtility.OpenGroupEmblemSelect = function(f74_arg0, f74_arg1, f74_arg2, f74_arg3, f74_arg4)
	CoD.SetCustomization(f74_arg2, Enum.CustomizationType[@"hash_1AB847C1A0E71617"], "type")
	if CoD.CraftUtility.Groups.ParseDDL(f74_arg2) then
		OpenOverlay(f74_arg0, "EmblemSelect", f74_arg2, {
			_isEditor = "false",
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f74_arg2, Enum.eModes.mode_multiplayer),
			_isClan = true,
		})
	end
end
CoD.ClanUtility.SetCreateGroupEmblem = function(f75_arg0, f75_arg1, f75_arg2)
	if IsLive() and not IsUserContentRestricted(f75_arg2) then
		local f75_local0 = f75_arg1:getModel()
		CoD.ClanUtility.PopulateClanEmblemData(f75_local0)
		Engine.SetupEmblemData(f75_arg2, f75_local0.emblemIndex:get(), f75_local0.storageFileType:get(), Enum.CustomizationType[@"customization_type_emblem"])
	else
	end
	GoBack(f75_arg0, f75_arg2)
end
CoD.ClanUtility.ClearGroupEmblem = function(f76_arg0)
	Engine.StorageReset(f76_arg0, Enum.StorageFileType[@"hash_394DF15E8078D20A"], LuaEnum.CLAN_STORAGE_SLOT.EMBLEM)
	CoD.ClanUtility.PopulateClanEmblemData()
end
CoD.ClanUtility.PopulateClanEmblemData = function(f77_arg0)
	if not f77_arg0 then
		f77_arg0 = {}
	end
	local f77_local0 = Engine.GetGlobalModel()
	f77_local0 = f77_local0:create("ClanEmblem")
	for f77_local4, f77_local5 in pairs({
		isNonClickableEmblem = 0,
		emblemTitle = "",
		setName = "",
		emblemTextEntry = "",
		subTitle = "",
		createTime = "",
		sortIndex = 0,
		emblemIndex = 0,
		isUsed = false,
		hintText = "",
		storageFileType = 0,
		renderInfo = "",
		xuid = LuaDefine.INVALID_XUID_X64,
		owned = false,
		readOnly = false,
	}) do
		if not f77_local0[f77_local4] then
			f77_local0:create(f77_local4)
		end
		f77_local0[f77_local4]:set(type(f77_arg0[f77_local4]) and f77_arg0[f77_local4]:get() or f77_local5)
	end
end
DataSources.ClanSearchFields = {
	getModel = function(f78_arg0)
		local f78_local0 = Engine.CreateModel(Engine.GetModelForController(f78_arg0), "ClanSearchFields")
		local f78_local1 = Engine.CreateModel(f78_local0, "search")
		f78_local1:set("")
		f78_local1 = Engine.CreateModel(f78_local0, "friendsOnly")
		f78_local1:set(false)
		f78_local1 = Engine.CreateModel(f78_local0, "publicOnly")
		f78_local1:set(false)
		return f78_local0
	end,
	getFriendsClans = function(f79_arg0)
		local f79_local0 = Engine.GetGlobalModel()
		f79_local0 = f79_local0.socialRoot
		local f79_local1 = Engine.GetModel(f79_local0, "clans.friendsClans.count")
		local f79_local2 = Engine.GetModel(f79_local0, "clans.friendsClans.list")
		local f79_local3 = {}
		for f79_local4 = 1, f79_local1:get() or 0, 1 do
			f79_local3[f79_local4] = f79_local2[f79_local4]:get()
		end
		return f79_local3
	end,
}
CoD.ClanUtility.HasFindClansNoResult = function(f80_arg0)
	local f80_local0 = CoD.ClanUtility.GetControllerClanModel(f80_arg0)
	f80_local0 = f80_local0:create("findClansResults")
	f80_local0 = f80_local0:create("listCount")
	return f80_local0:get() == 0
end
CoD.ClanUtility.GetFriendsCountByClanIndexArrayMap = function(f81_arg0)
	local f81_local0 = Engine.GetGlobalModel()
	f81_local0 = f81_local0.socialRoot
	local f81_local1 = Engine.GetModel(f81_local0, "clans.friendsClans.count")
	local f81_local2 = Engine.GetModel(f81_local0, "clans.friendsClans.list")
	local f81_local3 = {}
	for f81_local4 = 1, f81_local1:get() or 0, 1 do
		local f81_local7 = f81_local2[f81_local4]:get()
		f81_local3[f81_local7] = (f81_local3[f81_local7] or 0) + 1
	end
	return f81_local3
end
CoD.ClanUtility.GetFindClansResults = function(f82_arg0)
	local f82_local0 = CoD.ClanUtility.GetControllerClanModel(f82_arg0)
	local f82_local1 = f82_local0:create("findClansResults")
	local f82_local2 = {}
	local f82_local3 = nil
	local f82_local4 = CoD.ClanUtility.GetFriendsCountByClanIndexArrayMap(f82_arg0)
	if f82_local1.list then
		local f82_local5 = f82_local1.listCount:get()
		for f82_local6 = 1, f82_local5, 1 do
			f82_local3 = f82_local1.list["group" .. f82_local6]
			table.insert(f82_local2, {
				models = {
					name = f82_local3.name:get(),
					privacyLevel = f82_local3.privacyLevel:get(),
					memberCount = f82_local3.memberCount:get(),
					memberOnlineCount = f82_local3.memberOnlineCount:get(),
					createdTimestamp = f82_local3.createdTimestamp:get(),
					ownerId = f82_local3.ownerId:get(),
					hasOwner = f82_local3.hasOwner:get(),
					ownerAccountType = f82_local3.ownerAccountType:get(),
					proposalCount = f82_local3.proposalCount:get(),
					ID = f82_local3.ID:get(),
					kind = f82_local3.kind:get(),
					rootID = f82_local3.rootID:get(),
					rootKind = f82_local3.rootKind:get(),
					friendsCount = f82_local4[Engine[@"xuidtostring"](f82_local3.ID:get())] or 0,
				},
			})
		end
	end
	return f82_local2
end
DataSources.FindClansResults = DataSourceHelpers.ListSetup("FindClansResults", CoD.ClanUtility.GetFindClansResults, true, nil, function(f83_arg0, f83_arg1, f83_arg2)
	if not f83_arg1.onResultUpdate then
		f83_arg1.onResultUpdate = true
		local f83_local0 = CoD.ClanUtility.GetControllerClanModel(f83_arg0)
		f83_local0 = f83_local0:create("findClansResults")
		f83_arg1:subscribeToModel(f83_local0:create("listCount"), function(model)
			f83_arg1:updateDataSource()
		end, false)
	end
end)
DataSources.ClanTabs = ListHelper_SetupDataSource("ClanTabs", function(f85_arg0)
	local f85_local0 = Engine.GetGlobalModel()
	f85_local0 = f85_local0:create("socialRoot")
	local f85_local1 = f85_local0:create("clanTab")
	local f85_local2 = f85_local1:get()
	if f85_local2 == nil then
		if CoD.isPC then
			f85_local2 = "clanHQ"
		else
			f85_local2 = "clanHQ"
		end
	end
	local f85_local3 = {}
	table.insert(f85_local3, {
		models = {
			tabName = LocalizeToUpperString("clan/clan_hq"),
			tabWidget = "CoD.Clan_HQ",
			showInQuickInvite = true,
		},
		properties = {
			tabId = "clan_HQ",
			selectIndex = false,
		},
	})
	table.insert(f85_local3, {
		models = {
			tabName = LocalizeToUpperString("clan/squad"),
			tabWidget = "CoD.Clan_Squad",
			showInQuickInvite = true,
		},
		properties = {
			tabId = "clan_Squad",
			selectIndex = false,
		},
	})
	table.insert(f85_local3, {
		models = {
			tabName = LocalizeToUpperString("clan/team"),
			tabWidget = "CoD.Clan_Team",
			showInQuickInvite = true,
		},
		properties = {
			tabId = "clan_Team",
			selectIndex = false,
		},
	})
	table.insert(f85_local3, {
		models = {
			tabName = LocalizeToUpperString("clan/members"),
			tabWidget = "CoD.Clan_Members",
			showInQuickInvite = true,
		},
		properties = {
			tabId = "clan_Members",
			selectIndex = false,
		},
	})
	table.insert(f85_local3, {
		models = {
			tabName = LocalizeToUpperString("clan/leaderboards"),
			tabWidget = "CoD.Clan_Leaderboards",
			showInQuickInvite = true,
		},
		properties = {
			tabId = "clan_Leaderboards",
			selectIndex = false,
		},
	})
	table.insert(f85_local3, {
		models = {
			tabName = LocalizeToUpperString("clan/inbox"),
			tabWidget = "CoD.Clan_Inbox",
			showInQuickInvite = true,
		},
		properties = {
			tabId = "clan_Inbox",
			selectIndex = false,
		},
	})
	table.insert(f85_local3, {
		models = {
			tabName = LocalizeToUpperString("clan/admin"),
			tabWidget = "CoD.Clan_Admin",
			showInQuickInvite = true,
		},
		properties = {
			tabId = "clan_Admin",
			selectIndex = false,
		},
	})
	for f85_local4 = 1, #f85_local3, 1 do
		if f85_local3[f85_local4].properties ~= nil then
			if f85_local3[f85_local4].properties.tabId == f85_local2 then
				f85_local3[f85_local4].properties.selectIndex = true
			else
				f85_local3[f85_local4].properties.selectIndex = false
			end
		end
	end
	return f85_local3
end, true)
DataSources.ClanInfo = {
	getModel = function(f86_arg0)
		local f86_local0 = CoD.ClanUtility.GetControllerClanModel(f86_arg0)
		local f86_local1 = Engine.GetGlobalModel()
		local f86_local2 = f86_local1.socialRoot.clans:create("listClans")
		local f86_local3 = {}
		if f86_local0.clans ~= nil and f86_local0.clans.clan1 ~= nil then
			f86_local3 = f86_local0.clans.clan1
			if f86_local0.clans.count:get() > 0 and f86_local2[f86_local3.IDstr:get()] ~= nil then
				local f86_local4 = f86_local2[f86_local3.IDstr:get()]
				local f86_local5 = f86_local3:create("groupInfo")
				f86_local5:set(f86_local4)
			end
		else
			f86_local3 = f86_local0:create("junk")
			f86_local3 = f86_local3:create("groupInfo")
		end
		return f86_local3
	end,
}
DataSources.ClanSquadInfo = {
	getModel = function(f87_arg0)
		local f87_local0 = CoD.ClanUtility.GetControllerClanModel(f87_arg0)
		local f87_local1 = {}
		if f87_local0.squads ~= nil and f87_local0.squads.squad1 ~= nil then
			f87_local1 = f87_local0.squads.squad1
			local f87_local2 = Engine.GetGlobalModel()
			local f87_local3 = f87_local2.socialRoot.clans:create("listSquads")
			if f87_local1.IDstr and f87_local3[f87_local1.IDstr:get()] ~= nil then
				f87_local1.groupInfo:set(f87_local3[f87_local1.IDstr:get()])
			end
		else
			f87_local1 = f87_local0:create("junk")
			local f87_local2 = f87_local1:create("name")
			f87_local2:set("")
			f87_local2 = f87_local1:create("privacyLevel")
			f87_local2:set(0)
			f87_local2 = f87_local1:create("ID")
			f87_local2:set(-1)
		end
		return f87_local1
	end,
}
DataSources.ClanTeamInfo = {
	getModel = function(f88_arg0)
		local f88_local0 = CoD.ClanUtility.GetControllerClanModel(f88_arg0)
		local f88_local1 = {}
		local f88_local2 = Engine.GetGlobalModel()
		f88_local2 = f88_local2.socialRoot.clans
		local f88_local3 = f88_local2.currentTeamId:get() or 1
		if f88_local0.teams ~= nil and f88_local0.teams["team" .. f88_local3] then
			f88_local1 = f88_local0.teams["team" .. f88_local3]
			local f88_local4 = f88_local2:create("listTeams")
			if f88_local1.IDstr and f88_local4[f88_local1.IDstr:get()] ~= nil then
				local f88_local5 = f88_local4[f88_local1.IDstr:get()]
				local f88_local6 = f88_local1:create("groupInfo")
				f88_local6:set(f88_local5)
			end
		else
			f88_local1 = f88_local0:create("junk")
			local f88_local4 = f88_local1:create("name")
			f88_local4:set("")
			f88_local4 = f88_local1:create("privacyLevel")
			f88_local4:set(0)
			f88_local4 = f88_local1:create("ID")
			f88_local4:set(-1)
		end
		return f88_local1
	end,
}
DataSourceHelpers.GlobalDataSourceSetup("ClanSquads", "LobbyClients", function(f89_arg0, f89_arg1) end, false, {
	prepare = function(f90_arg0, f90_arg1, f90_arg2)
		local f90_local0 = CoD.ClanUtility.GetControllerClanModel(f90_arg0)
		local f90_local1 = f90_local0.squads
		f90_arg1._items = {}
		if not f90_arg1._countSub then
			f90_arg1._countSub = f90_arg1:subscribeToModel(f90_local1:create("count"), function()
				f90_arg1:updateDataSource()
			end, false)
		end
		local f90_local2 = Engine.GetGlobalModel()
		local f90_local3 = f90_local2.socialRoot.clans:create("listSquads")
		for f90_local4 = 1, f90_local1.count:get() or 0, 1 do
			local f90_local7 = f90_local1["squad" .. f90_local4]
			local f90_local8 = f90_local7.IDstr
			if f90_local8 then
				f90_local8 = f90_local3[f90_local7.IDstr:get()]
			end
			if f90_local8 ~= nil then
				local f90_local9 = f90_local7:create("emblem")
				f90_local9:set("ui_host")
				f90_local9 = f90_local7:create("groupInfo")
				f90_local9:set(f90_local8)
				table.insert(f90_arg1._items, f90_local7)
			end
		end
	end,
	getCount = function(f92_arg0)
		return f92_arg0._items and #f92_arg0._items or 0
	end,
	getItem = function(f93_arg0, f93_arg1, f93_arg2)
		return f93_arg1._items[f93_arg2]
	end,
})
DataSourceHelpers.GlobalDataSourceSetup("ClanTeams", "LobbyClients", function(f94_arg0, f94_arg1) end, false, {
	prepare = function(f95_arg0, f95_arg1, f95_arg2)
		local f95_local0 = CoD.ClanUtility.GetControllerClanModel(f95_arg0)
		local f95_local1 = f95_local0.teams
		f95_arg1._items = {}
		if not f95_arg1._countSub then
			f95_arg1._countSub = f95_arg1:subscribeToModel(f95_local1:create("count"), function()
				f95_arg1:updateDataSource()
			end, false)
		end
		local f95_local2 = Engine.GetGlobalModel()
		local f95_local3 = f95_local2.socialRoot.clans:create("listTeams")
		for f95_local4 = 1, f95_local1.count:get() or 0, 1 do
			local f95_local7 = f95_local1["team" .. f95_local4]
			local f95_local8 = f95_local7.IDstr
			if f95_local8 then
				f95_local8 = f95_local3[f95_local7.IDstr:get()]
			end
			if f95_local8 ~= nil then
				local f95_local9 = f95_local7:create("emblem")
				f95_local9:set("ui_host")
				f95_local9 = f95_local7:create("groupInfo")
				f95_local9:set(f95_local8)
				table.insert(f95_arg1._items, f95_local7)
			end
		end
	end,
	getCount = function(f97_arg0)
		return f97_arg0._items and #f97_arg0._items or 0
	end,
	getItem = function(f98_arg0, f98_arg1, f98_arg2)
		return f98_arg1._items[f98_arg2]
	end,
})
DataSourceHelpers.GlobalDataSourceSetup("ClanMembers", "LobbyClients", function(f99_arg0, f99_arg1) end, false, {
	prepare = function(f100_arg0, f100_arg1, f100_arg2)
		local f100_local0 = CoD.ClanUtility.GetControllerClanModel(f100_arg0)
		local f100_local1 = f100_local0:create("members")
		f100_arg1._items = {}
		if not f100_arg1._countSub then
			f100_arg1._countSub = f100_arg1:subscribeToModel(f100_local1:create("count"), function()
				f100_arg1:updateDataSource()
			end, false)
		end
		local f100_local2 = f100_local1:create("list")
		for f100_local3 = 1, f100_local1.count:get() or 0, 1 do
			local f100_local6 = "member"
			table.insert(f100_arg1._items, f100_local1[f100_local2["member" .. f100_local3].xuidStr:get()])
		end
	end,
	getCount = function(f102_arg0)
		return f102_arg0._items and #f102_arg0._items or 0
	end,
	getItem = function(f103_arg0, f103_arg1, f103_arg2)
		return f103_arg1._items[f103_arg2]
	end,
})
CoD.ClanUtility.RequestDataClanInbox = function(f104_arg0)
	local f104_local0 = Engine.GetGlobalModel()
	if f104_local0.socialRoot.ClanInbox.loadedGroupInbox:get() then
		f104_local0 = Engine.GetGlobalModel()
		if f104_local0.socialRoot.ClanInbox.loadedUserInbox:get() then
			Engine[@"lobbyevent"]("OnClanUIEvent", {
				dataRequestType = LuaEnum.CLAN_DATA_REQUEST_TYPE.CLAN_INBOX,
				rootModel = LuaEnum.CLAN_ROOT_MODEL.GLOBAL,
				path = "socialRoot.ClanInbox",
				controller = f104_arg0,
				event = LuaEnum.CLAN_UI_EVENT.DATA_REQUEST,
			})
		end
	end
end
DataSourceHelpers.GlobalDataSourceSetup("ClanInbox", "LobbyClients", function(f105_arg0, f105_arg1) end, false, {
	prepare = function(f106_arg0, f106_arg1, f106_arg2)
		f106_arg1._items = {}
		local f106_local0 = Engine.GetGlobalModel()
		f106_local0 = f106_local0.socialRoot
		f106_arg1._rootListModel = f106_local0:create("ClanInbox")
		local f106_local1 = Engine.GetXUID64(f106_arg0)
		if not f106_arg1._countSubUserInboxCount then
			f106_arg1._countSubUserInboxCount = f106_arg1:subscribeToModel(f106_local0.clans:create("countInbox"), function()
				f106_arg1._rootListModel.loadedUserInbox:set(true)
				CoD.ClanUtility.RequestDataClanInbox(f106_arg0)
			end, false)
		end
		if not f106_arg1._countSubGroupInboxCount then
			f106_arg1._countSubGroupInboxCount = f106_arg1:subscribeToModel(f106_local0.clans:create("countInboxGroup"), function()
				f106_arg1._rootListModel.loadedGroupInbox:set(true)
				CoD.ClanUtility.RequestDataClanInbox(f106_arg0)
			end, false)
		end
		if not f106_arg1._countSubInboxTotalCount then
			f106_arg1._countSubInboxTotalCount = f106_arg1:subscribeToModel(f106_arg1._rootListModel:create("modelCount"), function()
				f106_arg1:updateDataSource()
				local f109_local0 = Engine.GetGlobalModel()
				f109_local0.socialRoot.ClanInbox.fullyLoaded:set(true)
			end, false)
		end
		local f106_local2 = function(f110_arg0)
			return false
		end
		if f106_arg1.clanMenuID == "Social_Inbox" then
			f106_local2 = function(f111_arg0)
				local f111_local0 = f111_arg0.proposingUserID:get()
				local f111_local1 = f111_arg0.targetUserID:get()
				local f111_local2 = CoD.ClanUtility.IsInvite(f111_local0, f111_local1)
				if f111_local2 then
					if f106_local1 ~= f111_local1 or f111_arg0.groupIdentifier.kind:get() ~= LuaEnum.CLAN_KINDS.CLAN then
						f111_local2 = false
					else
						f111_local2 = true
					end
				end
				return f111_local2
			end
		elseif f106_arg1.clanMenuID == "Clan_Inbox" then
			f106_local2 = function(f112_arg0)
				return CoD.ClanUtility.IsInvite(f112_local0, f112_local1) and f106_local1 == f112_local1
			end
		elseif f106_arg1.clanMenuID == "JoinRequestFrame" then
			f106_local2 = function(f113_arg0)
				return CoD.ClanUtility.IsRequest(f113_local0, f113_local1) and f106_local1 == f113_local1
			end
		end
		local f106_local3 = CoD.ClanUtility.GetControllerClanModel(f106_arg0)
		local f106_local4 = f106_local0.clans:create("listClans")
		local f106_local5 = f106_local0.clans:create("listSquads")
		local f106_local6 = f106_local0.clans:create("listTeams")
		local f106_local7 = 1
		for f106_local8 = 1, f106_arg1._rootListModel.modelCount and f106_arg1._rootListModel.modelCount:get() or 0, 1 do
			local f106_local11 = f106_arg1._rootListModel["mail" .. f106_local8]
			local f106_local12 = f106_local11.proposingUserID:get()
			local f106_local13 = f106_local11.targetUserID:get()
			if f106_local2(f106_local11) then
				local f106_local14 = f106_local11.groupIdentifier.IDstr:get()
				local f106_local15 = f106_local11.groupIdentifier.kind:get()
				local f106_local16 = nil
				if f106_local15 == LuaEnum.CLAN_KINDS.CLAN then
					f106_local16 = f106_local4[f106_local14]
				elseif f106_local15 == LuaEnum.CLAN_KINDS.SQUAD then
					f106_local16 = f106_local5[f106_local14]
				else
					f106_local16 = f106_local6[f106_local14]
				end
				if f106_local16 then
					local f106_local17 = f106_local11:create("groupInfo", true)
					f106_local17:set(f106_local16)
					f106_local17 = f106_local11:create("emblem", true)
					f106_local17:set("ui_host")
					table.insert(f106_arg1._items, f106_local11)
					f106_local7 = f106_local7 + 1
				end
			end
		end
		local f106_local8 = f106_arg1._rootListModel:create("count")
		f106_local8:set(f106_local7 - 1)
	end,
	getCount = function(f114_arg0)
		return f114_arg0._items and #f114_arg0._items or 0
	end,
	getItem = function(f115_arg0, f115_arg1, f115_arg2)
		return f115_arg1._items[f115_arg2]
	end,
	cleanup = function(f116_arg0, f116_arg1)
		Engine.UnsubscribeAndFreeModel(f116_arg0._rootListModel)
	end,
})
CoD.ClanUtility.GetLocalEmblemData = function(f117_arg0)
	local f117_local0 = {}
	local f117_local1 = Engine.StorageGetBuffer(f117_arg0, Enum.StorageFileType[@"hash_394DF15E8078D20A"])
	if f117_local1 then
		f117_local0.emblemIndex = f117_local1.emblemIndex and f117_local1.emblemIndex:get() or 0
		f117_local0.isUsed = f117_local1.isUsed:get()
		f117_local0.sortIndex = f117_local1.sortIndex:get()
		f117_local0.readOnly = f117_local1.readOnly:get()
		f117_local0.emblemName = f117_local1.emblemName:get()
		if f117_local1.createTime ~= nil then
			f117_local0.createTime = Engine[@"hash_65F9B38A7698EBB1"](f117_local1.createTime:get())
		end
	end
	return f117_local0
end
DataSources.GroupEmblem = {
	getModel = function(f118_arg0, f118_arg1, f118_arg2)
		local f118_local0 = Engine.GetGlobalModel()
		f118_local0 = f118_local0:create("ClanEmblem")
		CoD.ClanUtility.PopulateClanEmblemData(CoD.ClanUtility.GetLocalEmblemData(f118_arg0))
		return f118_local0
	end,
}
DataSources.ClanSocialOptionsButtonList = ListHelper_SetupDataSource("ClanSocialOptionsButtonList", function(f119_arg0, f119_arg1)
	local f119_local0 = Engine.GetGlobalModel()
	f119_local0 = f119_local0.socialRoot.clans.ownerClan:get()
	local f119_local1 = {}
	table.insert(f119_local1, {
		displayText = "clan/clan_finder",
		displayImage = "ui_host",
		action = CoD.ClanUtility.ClanButtonPress,
		frameWidget = "CoD.ClanFinderFrame",
		params = {
			event = "clan_finder",
		},
	})
	table.insert(f119_local1, {
		displayText = "clan/join_request",
		displayImage = "ui_host",
		action = CoD.ClanUtility.ClanButtonPress,
		frameWidget = "CoD.JoinRequestFrame",
		params = {
			event = "join_request",
		},
	})
	table.insert(f119_local1, {
		displayText = "clan/create_clan",
		displayImage = "ui_host",
		action = CoD.ClanUtility.ClanButtonPress,
		frameWidget = "CoD.CreateClanFrame",
		disabled = f119_local0,
		params = {
			event = "create_clan",
		},
		open_create = true,
		clanCreate = true,
	})
	local f119_local2 = {}
	for f119_local6, f119_local7 in ipairs(f119_local1) do
		table.insert(f119_local2, {
			models = {
				displayText = f119_local7.displayText,
				icon = f119_local7.displayImage,
				hintText = f119_local7.displayDesc,
				frameWidget = f119_local7.frameWidget,
				createType = LuaEnum.CLAN_KINDS.CLAN,
			},
			properties = {
				disabled = f119_local7.disabled or false,
				action = f119_local7.action,
				actionParam = f119_local7.params,
				open_create = f119_local7.open_create,
			},
		})
	end
	return f119_local2
end)
DataSources.ClanSquadOptionsButtonList = ListHelper_SetupDataSource("ClanSquadOptionsButtonList", function(f120_arg0, f120_arg1)
	local f120_local0 = Engine.GetGlobalModel()
	f120_local0 = f120_local0.socialRoot.clans.ownerSquad:get()
	local f120_local1 = {}
	table.insert(f120_local1, {
		displayText = "clan/friends_squads",
		displayImage = "ui_host",
		action = CoD.ClanUtility.SquadAdminButtonPress,
		frameWidget = "CoD.FriendsClansFrame",
		params = {
			event = "friends_squads",
		},
	})
	table.insert(f120_local1, {
		displayText = "clan/squad_finder",
		displayImage = "ui_host",
		action = CoD.ClanUtility.SquadAdminButtonPress,
		frameWidget = "CoD.ClanFinderFrame",
		params = {
			event = "squad_finder",
		},
	})
	table.insert(f120_local1, {
		displayText = "clan/search_for_player",
		displayImage = "ui_host",
		action = CoD.ClanUtility.SquadAdminButtonPress,
		frameWidget = "CoD.SearchForPlayerFrame",
		params = {
			event = "search_for_player",
		},
	})
	table.insert(f120_local1, {
		displayText = "clan/join_request",
		displayImage = "ui_host",
		action = CoD.ClanUtility.SquadAdminButtonPress,
		frameWidget = "CoD.JoinRequestFrame",
		params = {
			event = "join_request",
		},
	})
	table.insert(f120_local1, {
		displayText = "clan/create_squad",
		displayImage = "ui_host",
		action = CoD.ClanUtility.SquadAdminButtonPress,
		frameWidget = "CoD.CreateClanFrame",
		disabled = f120_local0,
		params = {
			event = "create_squad",
		},
		open_create = true,
	})
	local f120_local2 = {}
	for f120_local6, f120_local7 in ipairs(f120_local1) do
		table.insert(f120_local2, {
			models = {
				displayText = f120_local7.displayText,
				icon = f120_local7.displayImage,
				hintText = f120_local7.displayDesc,
				frameWidget = f120_local7.frameWidget,
				createType = LuaEnum.CLAN_KINDS.SQUAD,
			},
			properties = {
				disabled = f120_local7.disabled or false,
				action = f120_local7.action,
				actionParam = f120_local7.params,
				open_create = f120_local7.open_create,
			},
		})
	end
	return f120_local2
end)
DataSources.ClanTeamOptionsButtonList = ListHelper_SetupDataSource("ClanTeamOptionsButtonList", function(f121_arg0, f121_arg1)
	local f121_local0 = Engine.GetGlobalModel()
	f121_local0 = f121_local0.socialRoot.clans.ownerTeam:get()
	local f121_local1 = {}
	table.insert(f121_local1, {
		displayText = "clan/friends_teams",
		displayImage = "ui_host",
		action = CoD.ClanUtility.TeamAdminButtonPress,
		frameWidget = "CoD.FriendsClansFrame",
		params = {
			event = "friends_teams",
		},
	})
	table.insert(f121_local1, {
		displayText = "clan/team_finder",
		displayImage = "ui_host",
		action = CoD.ClanUtility.TeamAdminButtonPress,
		frameWidget = "CoD.ClanFinderFrame",
		params = {
			event = "team_finder",
		},
	})
	table.insert(f121_local1, {
		displayText = "clan/search_for_player",
		displayImage = "ui_host",
		action = CoD.ClanUtility.TeamAdminButtonPress,
		frameWidget = "CoD.SearchForPlayerFrame",
		params = {
			event = "search_for_player",
		},
	})
	table.insert(f121_local1, {
		displayText = "clan/join_request",
		displayImage = "ui_host",
		action = CoD.ClanUtility.TeamAdminButtonPress,
		frameWidget = "CoD.JoinRequestFrame",
		params = {
			event = "join_request",
		},
	})
	table.insert(f121_local1, {
		displayText = "clan/create_team",
		displayImage = "ui_host",
		action = CoD.ClanUtility.TeamAdminButtonPress,
		frameWidget = "CoD.CreateClanFrame",
		disabled = f121_local0,
		params = {
			event = "create_team",
		},
		open_create = true,
	})
	local f121_local2 = {}
	for f121_local6, f121_local7 in ipairs(f121_local1) do
		table.insert(f121_local2, {
			models = {
				displayText = f121_local7.displayText,
				icon = f121_local7.displayImage,
				hintText = f121_local7.displayDesc,
				frameWidget = f121_local7.frameWidget,
				createType = LuaEnum.CLAN_KINDS.TEAM,
			},
			properties = {
				disabled = f121_local7.disabled or false,
				action = f121_local7.action,
				actionParam = f121_local7.params,
				open_create = f121_local7.open_create,
			},
		})
	end
	return f121_local2
end)
DataSources.ClanJoinButtonList = ListHelper_SetupDataSource("ClanJoinButtonList", function(f122_arg0, f122_arg1)
	local f122_local0 = f122_arg1.menu:getModel()
	local f122_local1 = f122_local0.privacyLevel:get()
	local f122_local2 = {
		action = LuaEnum.POPUP_ACTION.ACCEPT,
		xuid = LuaEnum.CLAN_OPTIONAL_PARAMETERS.XUID,
		role = LuaEnum.CLAN_OPTIONAL_PARAMETERS.ROLE,
		replacesGroupID = LuaEnum.CLAN_OPTIONAL_PARAMETERS.REPLACE_GROUP_ID,
		name = f122_local0.name:get(),
		ownerID = f122_local0.ownerID:get(),
		hasOwner = f122_local0.hasOwner:get(),
		privacyLevel = f122_local0.privacyLevel:get(),
		memberCount = f122_local0.memberCount:get(),
		memberOnlineCount = f122_local0.memberOnlineCount:get(),
		proposalCount = f122_local0.proposalCount:get(),
		kind = f122_local0.kind:get(),
		ID = f122_local0.ID:get(),
		rootKind = f122_local0.rootKind:get(),
		rootID = f122_local0.rootID:get(),
	}
	local f122_local3 = {}
	if f122_local1 == Enum[@"hash_6C491AC72605E0C3"][@"hash_4B91F60B176A25F1"] then
		if LuaEnum.CLAN_GROUP_MAX_SIZE[f122_local2.kind] < f122_local2.memberCount then
			table.insert(f122_local3, {
				displayText = @"menu/ok",
				action = CoD.ClanUtility.ClanJoinPopupButtonPress,
				params = {
					event = LuaEnum.POPUP_ACTION.CANCEL,
				},
			})
		else
			if f122_local2.kind ~= LuaEnum.CLAN_KINDS.CLAN and CoD.ClanUtility.GetClanId(f122_arg0) ~= f122_local2.rootID then
			else
			end
			local f122_local4 = "clan/join_clan"
			if f122_local2.kind == LuaEnum.CLAN_KINDS.TEAM then
				f122_local4 = @"hash_3FDDCF7F9CBFF616"
			elseif f122_local2.kind == LuaEnum.CLAN_KINDS.SQUAD then
				f122_local4 = @"hash_26FD1AAE79AE5F73"
			end
			table.insert(f122_local3, {
				displayText = f122_local4,
				action = CoD.ClanUtility.ClanJoinPopupButtonPress,
				params = f122_local2,
			})
			table.insert(f122_local3, {
				displayText = @"menu/cancel",
				action = CoD.ClanUtility.ClanJoinPopupButtonPress,
				params = {
					event = LuaEnum.POPUP_ACTION.CANCEL,
				},
			})
		end
	elseif f122_local1 == Enum[@"hash_6C491AC72605E0C3"][@"hash_76C66A50C1991611"] then
		table.insert(f122_local3, {
			displayText = @"hash_66E0DA751A3C33DB",
			action = CoD.ClanUtility.ClanJoinPopupButtonPress,
			params = f122_local2,
		})
		table.insert(f122_local3, {
			displayText = @"menu/cancel",
			action = CoD.ClanUtility.ClanJoinPopupButtonPress,
			params = {
				event = LuaEnum.POPUP_ACTION.CANCEL,
			},
		})
	elseif f122_local1 == Enum[@"hash_6C491AC72605E0C3"][@"hash_54A7DCCE66FFD267"] then
		table.insert(f122_local3, {
			displayText = @"menu/ok",
			action = CoD.ClanUtility.ClanJoinPopupButtonPress,
			params = {
				event = LuaEnum.POPUP_ACTION.CANCEL,
			},
		})
	end
	local f122_local4 = {}
	for f122_local8, f122_local9 in ipairs(f122_local3) do
		table.insert(f122_local4, {
			models = {
				displayText = f122_local9.displayText,
				icon = f122_local9.displayImage,
				hintText = f122_local9.displayDesc,
			},
			properties = {
				action = f122_local9.action,
				actionParam = f122_local9.params,
			},
		})
	end
	return f122_local4
end)
DataSources.ClanAdminOptionsButtonList = ListHelper_SetupDataSource("ClanAdminOptionsButtonList", function(f123_arg0)
	local f123_local0 = CoD.ClanUtility.GetClanRank(f123_arg0)
	local f123_local1 = {}
	if f123_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
		table.insert(f123_local1, {
			displayText = "clan/transfer_ownership",
			displayImage = "ui_host",
			displayDesc = "clan/transfer_ownership_desc",
			action = CoD.ClanUtility.ClanButtonPress,
			params = {
				event = "transfer_ownership",
			},
		})
	end
	table.insert(f123_local1, {
		displayText = "clan/leave_clan",
		displayImage = "ui_host",
		displayDesc = "clan/leave_clan_desc",
		action = CoD.ClanUtility.ClanButtonPress,
		params = {
			event = "leave_clan",
		},
	})
	if f123_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
		table.insert(f123_local1, {
			displayText = "clan/delete_clan",
			displayImage = "ui_host",
			displayDesc = "clan/delete_clan_desc",
			action = CoD.ClanUtility.ClanButtonPress,
			params = {
				event = "delete_clan",
			},
		})
	end
	local f123_local2 = {}
	for f123_local6, f123_local7 in ipairs(f123_local1) do
		table.insert(f123_local2, {
			models = {
				displayText = f123_local7.displayText,
				icon = f123_local7.displayImage,
				hintText = f123_local7.displayDesc,
			},
			properties = {
				action = f123_local7.action,
				actionParam = f123_local7.params,
			},
		})
	end
	return f123_local2
end)
DataSources.TeamAdminOptionsButtonList = ListHelper_SetupDataSource("TeamAdminOptionsButtonList", function(f124_arg0)
	local f124_local0 = CoD.ClanUtility.GetTeamRank(f124_arg0, CoD.ClanUtility.GetCurrentTeamId())
	local f124_local1 = {}
	if f124_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
		table.insert(f124_local1, {
			displayText = "clan/transfer_ownership",
			displayImage = "ui_host",
			action = CoD.ClanUtility.TeamAdminButtonPress,
			params = {
				event = "transfer_ownership",
			},
		})
	end
	table.insert(f124_local1, {
		displayText = "clan/leave_team",
		displayImage = "ui_host",
		action = CoD.ClanUtility.TeamAdminButtonPress,
		params = {
			event = "leave_team",
		},
	})
	if f124_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
		table.insert(f124_local1, {
			displayText = "clan/delete_team",
			displayImage = "ui_host",
			action = CoD.ClanUtility.TeamAdminButtonPress,
			params = {
				event = "delete_team",
			},
		})
	end
	local f124_local2 = {}
	for f124_local6, f124_local7 in ipairs(f124_local1) do
		table.insert(f124_local2, {
			models = {
				displayText = f124_local7.displayText,
				icon = f124_local7.displayImage,
			},
			properties = {
				action = f124_local7.action,
				actionParam = f124_local7.params,
			},
		})
	end
	return f124_local2
end)
DataSources.SquadAdminOptionsButtonList = ListHelper_SetupDataSource("SquadAdminOptionsButtonList", function(f125_arg0)
	local f125_local0 = CoD.ClanUtility.GetSquadRank(f125_arg0, CoD.ClanUtility.GetCurrentSquadId())
	local f125_local1 = {}
	if f125_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
		table.insert(f125_local1, {
			displayText = "clan/transfer_ownership",
			displayImage = "ui_host",
			action = CoD.ClanUtility.SquadAdminButtonPress,
			params = {
				event = "transfer_ownership",
			},
		})
	end
	table.insert(f125_local1, {
		displayText = "clan/leave_squad",
		displayImage = "ui_host",
		action = CoD.ClanUtility.SquadAdminButtonPress,
		params = {
			event = "leave_squad",
		},
	})
	if f125_local0 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
		table.insert(f125_local1, {
			displayText = "clan/delete_squad",
			displayImage = "ui_host",
			action = CoD.ClanUtility.SquadAdminButtonPress,
			params = {
				event = "delete_squad",
			},
		})
	end
	local f125_local2 = {}
	for f125_local6, f125_local7 in ipairs(f125_local1) do
		table.insert(f125_local2, {
			models = {
				displayText = f125_local7.displayText,
				icon = f125_local7.displayImage,
			},
			properties = {
				action = f125_local7.action,
				actionParam = f125_local7.params,
			},
		})
	end
	return f125_local2
end)
CoD.ClanUtility.OnCreateClanFormItemFocusChange = function(f126_arg0, f126_arg1, f126_arg2)
	local f126_local0 = f126_arg2:getModel()
	if f126_local0 then
		local f126_local1 = f126_local0.displayText
		local f126_local2 = Engine[@"hash_4F9F1239CFD921FE"](f126_local0.displayText:get())
	end
	local f126_local3 = f126_local1 and f126_local2 or ""
	local f126_local4 = f126_arg0:getModel()
	f126_local4.hintTitle:set(f126_local3)
	f126_local4 = f126_arg0:getModel()
	f126_local4.hintText:set(CoD.CoDAccountUtility.GetElementDescription(f126_arg2))
end
CoD.ClanUtility.OnCreateSquadFormItemFocusChange = function(f127_arg0, f127_arg1, f127_arg2)
	local f127_local0 = DataSources.CreateSquadForm.getModel(f127_arg1)
	f127_local0.hintText:set(CoD.CoDAccountUtility.GetElementDescription(f127_arg2))
end
CoD.ClanUtility.OnCreateTeamFormItemFocusChange = function(f128_arg0, f128_arg1, f128_arg2)
	local f128_local0 = DataSources.CreateTeamForm.getModel(f128_arg1)
	f128_local0.hintText:set(CoD.CoDAccountUtility.GetElementDescription(f128_arg2))
end
DataSources.SearchClanNameDescription = ListHelper_SetupDataSource("SearchClanNameDescription", function(f129_arg0)
	local f129_local0 = {}
	if not CoD.isPC then
		table.insert(
			f129_local0,
			CoD.CoDAccountUtility.packageOptionsButtonData(@"hash_56264D0536BC9414", "clan/clan_name_desc", "", function(f130_arg0, f130_arg1, f130_arg2, f130_arg3, f130_arg4)
				ShowKeyboard(f130_arg0, f130_arg1, f130_arg2, "KEYBOARD_TYPE_CLAN_NAME")
			end, {
				actionType = "name",
			})
		)
	end
	return f129_local0
end, true)
DataSources.CreateClanForm = {
	getModel = function(f131_arg0)
		local f131_local0 = Engine.GetModel(Engine.GetModelForController(f131_arg0), "CreateClanForm")
		if f131_local0 == nil then
			local f131_local1 = Engine.GetModelForController(f131_arg0)
			f131_local0 = f131_local1:create("CreateClanForm")
			f131_local0:create("name")
			f131_local0:create("description")
			f131_local1 = f131_local0:create("type")
			f131_local1:set(1)
			f131_local1 = f131_local0:create("style")
			f131_local1:set(1)
			f131_local1 = f131_local0:create("modeMultiplayer")
			f131_local1:set(false)
			f131_local1 = f131_local0:create("modeArena")
			f131_local1:set(false)
			f131_local1 = f131_local0:create("modeZombies")
			f131_local1:set(false)
			f131_local1 = f131_local0:create("modeBlackout")
			f131_local1:set(false)
			f131_local0:create("hintTitle")
			f131_local0:create("hintText")
		end
		return f131_local0
	end,
}
DataSources.CreateClanNameDescription = ListHelper_SetupDataSource("CreateClanNameDescription", function(f132_arg0)
	local f132_local0 = {}
	if not CoD.isPC then
		local f132_local1 = function(f133_arg0, f133_arg1, f133_arg2, f133_arg3, f133_arg4)
			ShowKeyboard(f133_arg0, f133_arg1, f133_arg2, "KEYBOARD_TYPE_CLAN_NAME")
		end
		local f132_local2 = function(f134_arg0, f134_arg1, f134_arg2, f134_arg3, f134_arg4)
			ShowKeyboard(f134_arg0, f134_arg1, f134_arg2, "KEYBOARD_TYPE_CLAN_DESCRIPTION")
		end
		table.insert(
			f132_local0,
			CoD.CoDAccountUtility.packageOptionsButtonData(@"hash_56264D0536BC9414", "clan/clan_name_desc", "", f132_local1, {
				actionType = "name",
			})
		)
		table.insert(
			f132_local0,
			CoD.CoDAccountUtility.packageOptionsButtonData("clan/description", "clan/description_desc", "", f132_local2, {
				actionType = "description",
			})
		)
	end
	return f132_local0
end, true)
DataSources.CreateClanType = ListHelper_SetupDataSource("CreateClanType", function(f135_arg0)
	local f135_local0 = {}
	local f135_local1 = function(f136_arg0, f136_arg1, f136_arg2, f136_arg3)
		local f136_local0 = DataSources.CreateClanForm.getModel(f136_arg2)
		f136_local0 = f136_local0.type
		local f136_local1 = (f136_local0:get() - 1) % #CoD.ClanUtility.clan_privacy_levels
		if f136_local1 == 0 then
			f136_local1 = #CoD.ClanUtility.clan_privacy_levels or f136_local1
		end
		f136_local0:set(f136_local1)
		local f136_local2 = f136_arg0:getModel(f136_arg2, "currentNum")
		f136_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f136_local1].display_string))
	end
	local f135_local2 = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3)
		local f137_local0 = DataSources.CreateClanForm.getModel(f137_arg2)
		f137_local0 = f137_local0.type
		local f137_local1 = (f137_local0:get() + 1) % #CoD.ClanUtility.clan_privacy_levels
		if f137_local1 == 0 then
			f137_local1 = #CoD.ClanUtility.clan_privacy_levels or f137_local1
		end
		f137_local0:set(f137_local1)
		local f137_local2 = f137_arg0:getModel(f137_arg2, "currentNum")
		f137_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f137_local1].display_string))
	end
	local f135_local3 = DataSources.CreateClanForm.getModel(f135_arg0)
	f135_local3 = f135_local3.type:get()
	table.insert(f135_local0, CoD.CoDAccountUtility.packageNumOptionsButtonData(@"hash_1CB5C04C1EAE13CF", "clan/clan_type_desc", Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f135_local3.type:get()].display_string), f135_local1, f135_local2))
	return f135_local0
end, true)
DataSources.CreateClanStyle = ListHelper_SetupDataSource("CreateClanStyle", function(f138_arg0)
	local f138_local0 = {}
	local f138_local1 = function(f139_arg0, f139_arg1, f139_arg2, f139_arg3)
		local f139_local0 = DataSources.CreateClanForm.getModel(f139_arg2)
		f139_local0 = f139_local0.style
		local f139_local1 = (f139_local0:get() - 1) % #CoD.ClanUtility.clan_styles
		if f139_local1 == 0 then
			f139_local1 = #CoD.ClanUtility.clan_styles or f139_local1
		end
		f139_local0:set(f139_local1)
		local f139_local2 = f139_arg0:getModel(f139_arg2, "currentNum")
		f139_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_styles[f139_local1].display_string))
	end
	local f138_local2 = function(f140_arg0, f140_arg1, f140_arg2, f140_arg3)
		local f140_local0 = DataSources.CreateClanForm.getModel(f140_arg2)
		f140_local0 = f140_local0.style
		local f140_local1 = (f140_local0:get() + 1) % #CoD.ClanUtility.clan_styles
		if f140_local1 == 0 then
			f140_local1 = #CoD.ClanUtility.clan_styles or f140_local1
		end
		f140_local0:set(f140_local1)
		local f140_local2 = f140_arg0:getModel(f140_arg2, "currentNum")
		f140_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_styles[f140_local1].display_string))
	end
	local f138_local3 = DataSources.CreateClanForm.getModel(f138_arg0)
	f138_local3 = f138_local3.style:get()
	table.insert(f138_local0, CoD.CoDAccountUtility.packageNumOptionsButtonData("clan/style", "clan/style_desc", Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_styles[f138_local3.style:get()].display_string), f138_local1, f138_local2))
	return f138_local0
end, true)
DataSources.CreateClanModes = ListHelper_SetupDataSource("CreateClanModes", function(f141_arg0)
	local f141_local0 = {}
	local f141_local1 = function(f142_arg0, f142_arg1, f142_arg2, f142_arg3, f142_arg4)
		return {
			models = {
				displayText = f142_arg0,
				description = f142_arg1,
				currentValue = f142_arg2,
			},
			properties = {
				action = f142_arg3,
				actionParam = f142_arg4,
			},
		}
	end
	local f141_local2 = function(f143_arg0, f143_arg1, f143_arg2, f143_arg3, f143_arg4)
		local f143_local0 = nil
		if f143_arg3.toggle == "Multiplayer" then
			local f143_local1 = DataSources.CreateClanForm.getModel(f143_arg2)
			f143_local0 = f143_local1.modeMultiplayer
		elseif f143_arg3.toggle == "Arena" then
			local f143_local1 = DataSources.CreateClanForm.getModel(f143_arg2)
			f143_local0 = f143_local1.modeArena
		elseif f143_arg3.toggle == "Zombies" then
			local f143_local1 = DataSources.CreateClanForm.getModel(f143_arg2)
			f143_local0 = f143_local1.modeZombies
		elseif f143_arg3.toggle == "Blackout" then
			local f143_local1 = DataSources.CreateClanForm.getModel(f143_arg2)
			f143_local0 = f143_local1.modeBlackout
		end
		local f143_local1 = not f143_local0:get()
		f143_local0:set(f143_local1)
		local f143_local2 = f143_arg1:getModel(f143_arg2, "currentValue")
		f143_local2:set(f143_local1)
	end
	local f141_local3 = table.insert
	local f141_local4 = f141_local0
	local f141_local5 = f141_local1
	local f141_local6 = "exe/cod_multiplayer"
	local f141_local7 = 0x0
	local f141_local8 = DataSources.CreateClanForm.getModel(f141_arg0)
	f141_local3(
		f141_local4,
		f141_local5(f141_local6, f141_local7, f141_local8.modeMultiplayer:get(), f141_local2, {
			toggle = "Multiplayer",
		})
	)
	f141_local3 = table.insert
	f141_local4 = f141_local0
	f141_local5 = f141_local1
	f141_local6 = 0x7D527CD96A3419
	f141_local7 = 0x0
	f141_local8 = DataSources.CreateClanForm.getModel(f141_arg0)
	f141_local3(
		f141_local4,
		f141_local5(f141_local6, f141_local7, f141_local8.modeArena:get(), f141_local2, {
			toggle = "Arena",
		})
	)
	f141_local3 = table.insert
	f141_local4 = f141_local0
	f141_local5 = f141_local1
	f141_local6 = "menu/zombie"
	f141_local7 = 0x0
	f141_local8 = DataSources.CreateClanForm.getModel(f141_arg0)
	f141_local3(
		f141_local4,
		f141_local5(f141_local6, f141_local7, f141_local8.modeZombies:get(), f141_local2, {
			toggle = "Zombies",
		})
	)
	f141_local3 = table.insert
	f141_local4 = f141_local0
	f141_local5 = f141_local1
	f141_local6 = @"hash_1F9BF174CCFAA519"
	f141_local7 = 0x0
	f141_local8 = DataSources.CreateClanForm.getModel(f141_arg0)
	f141_local3(
		f141_local4,
		f141_local5(f141_local6, f141_local7, f141_local8.modeBlackout:get(), f141_local2, {
			toggle = "Blackout",
		})
	)
	return f141_local0
end, true)
DataSources.CreateClanConfirmation = ListHelper_SetupDataSource("CreateClanConfirmation", function(f144_arg0)
	local f144_local0 = {}
	table.insert(
		f144_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData("clan/create_clan", "clan/create_clan_desc", nil, function(f145_arg0, f145_arg1, f145_arg2, f145_arg3, f145_arg4)
			local f145_local0 = DataSources.CreateClanForm.getModel(f145_arg2)
			local f145_local1 = f145_local0.name:get()
			local f145_local2 = f145_local0.description:get()
			local f145_local3 = f145_local0.type
			f145_local3 = CoD.ClanUtility.clan_privacy_levels[REG8:get()].value
			local f145_local4 = f145_local0.style
			f145_local4 = CoD.ClanUtility.clan_styles[REG10:get()].value
			local f145_local5 = f145_local0.modeMultiplayer:get()
			local f145_local6 = f145_local0.modeArena:get()
			local f145_local7 = f145_local0.modeZombies:get()
			local f145_local8 = f145_local0.modeBlackout:get()
			if not f145_local1 or string.len(f145_local1) == 0 then
				LuaUtils.UI_ShowErrorMessageDialog(f145_arg2, @"hash_5419BBF769DD4724", "menu/notice_caps")
				return
			elseif not f145_local2 or string.len(f145_local2) == 0 then
				LuaUtils.UI_ShowErrorMessageDialog(f145_arg2, @"hash_16319AECC843F92B", "menu/notice_caps")
				return
			elseif not f145_local5 and not f145_local6 and not f145_local7 and not f145_local8 then
				LuaUtils.UI_ShowErrorMessageDialog(f145_arg2, @"hash_29071218D66BA869", "menu/notice_caps")
				return
			elseif CoD.CraftUtility.IsClanEmblemEmpty(f145_arg2) then
				LuaUtils.UI_ShowErrorMessageDialog(f145_arg2, @"hash_6719ACB7DA0AACF9", "menu/notice_caps")
				return
			else
				local f145_local9 = Engine.GetGlobalModel()
				f145_local9.socialRoot.clans.loaded:set(LuaEnum.CLAN_INFO_MODELS.CREATING_CLAN)
				Engine[@"lobbyevent"]("OnClanUIEvent", {
					name = f145_local1,
					description = f145_local2,
					privacyLevel = f145_local3,
					style = f145_local4,
					modeMultiplayer = f145_local5,
					modeArena = f145_local6,
					modeZombies = f145_local7,
					modeBlackout = f145_local8,
					controller = f145_arg2,
					event = LuaEnum.CLAN_UI_EVENT.CREATE_GROUP,
					kind = LuaEnum.CLAN_KINDS.CLAN,
				})
				Engine.UploadEmblemData(f145_arg2, LuaEnum.CLAN_STORAGE_SLOT.CLAN_EMBLEM, Enum.StorageFileType[@"hash_394DF15E8078D20A"])
				GoBack(f145_arg4, f145_arg2)
			end
		end)
	)
	return f144_local0
end, true)
DataSources.CreateSquadForm = {
	getModel = function(f146_arg0)
		local f146_local0 = Engine.GetModel(Engine.GetModelForController(f146_arg0), "CreateSquadForm")
		if f146_local0 == nil then
			f146_local0 = Engine.CreateModel(Engine.GetModelForController(f146_arg0), "CreateSquadForm")
			Engine.CreateModel(f146_local0, "name")
			Engine.SetModelValue(Engine.CreateModel(f146_local0, "type"), 1)
			Engine.CreateModel(f146_local0, "hintTitle")
			Engine.CreateModel(f146_local0, "hintText")
		end
		return f146_local0
	end,
}
DataSources.CreateSquadNameDescription = ListHelper_SetupDataSource("CreateSquadNameDescription", function(f147_arg0)
	local f147_local0 = {}
	table.insert(
		f147_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData("clan/squad_name", @"hash_76CEB4714E89FA9E", "", function(f148_arg0, f148_arg1, f148_arg2, f148_arg3, f148_arg4)
			ShowKeyboard(f148_arg0, f148_arg1, f148_arg2, "KEYBOARD_TYPE_CLAN_NAME")
		end, {
			actionType = "name",
		})
	)
	return f147_local0
end, true)
DataSources.CreateSquadType = ListHelper_SetupDataSource("CreateSquadType", function(f149_arg0)
	local f149_local0 = {}
	local f149_local1 = function(f150_arg0, f150_arg1, f150_arg2, f150_arg3)
		local f150_local0 = DataSources.CreateSquadForm.getModel(f150_arg2)
		f150_local0 = f150_local0.type
		local f150_local1 = (f150_local0:get() - 1) % #CoD.ClanUtility.clan_privacy_levels
		if f150_local1 == 0 then
			f150_local1 = #CoD.ClanUtility.clan_privacy_levels or f150_local1
		end
		f150_local0:set(f150_local1)
		local f150_local2 = f150_arg0:getModel(f150_arg2, "currentNum")
		f150_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f150_local1].display_string))
	end
	local f149_local2 = function(f151_arg0, f151_arg1, f151_arg2, f151_arg3)
		local f151_local0 = DataSources.CreateSquadForm.getModel(f151_arg2)
		f151_local0 = f151_local0.type
		local f151_local1 = (f151_local0:get() + 1) % #CoD.ClanUtility.clan_privacy_levels
		if f151_local1 == 0 then
			f151_local1 = #CoD.ClanUtility.clan_privacy_levels or f151_local1
		end
		f151_local0:set(f151_local1)
		local f151_local2 = f151_arg0:getModel(f151_arg2, "currentNum")
		f151_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f151_local1].display_string))
	end
	local f149_local3 = DataSources.CreateSquadForm.getModel(f149_arg0)
	f149_local3 = f149_local3.type:get()
	table.insert(f149_local0, CoD.CoDAccountUtility.packageNumOptionsButtonData(@"hash_141ABC196E1EEBE5", "clan/squad_type_desc", Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f149_local3.type:get()].display_string), f149_local1, f149_local2))
	return f149_local0
end, true)
DataSources.CreateSquadConfirmation = ListHelper_SetupDataSource("CreateSquadConfirmation", function(f152_arg0)
	local f152_local0 = {}
	table.insert(
		f152_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData("clan/create_squad", "clan/create_squad_desc", nil, function(f153_arg0, f153_arg1, f153_arg2, f153_arg3, f153_arg4)
			local f153_local0 = DataSources.CreateSquadForm.getModel(f153_arg2)
			local f153_local1 = f153_local0.name:get()
			local f153_local2 = f153_local0.type
			f153_local2 = CoD.ClanUtility.clan_privacy_levels[REG7:get()].value
			if not f153_local1 or string.len(f153_local1) == 0 then
				LuaUtils.UI_ShowErrorMessageDialog(f153_arg2, @"hash_5419BBF769DD4724", "menu/notice_caps")
				return
			elseif CoD.CraftUtility.IsClanEmblemEmpty(f153_arg2) then
				LuaUtils.UI_ShowErrorMessageDialog(f153_arg2, @"hash_6719ACB7DA0AACF9", "menu/notice_caps")
				return
			else
				local f153_local3 = Engine.GetGlobalModel()
				f153_local3.socialRoot.squads.loaded:set(LuaEnum.CLAN_INFO_MODELS.CREATING_SQUAD)
				Engine[@"lobbyevent"]("OnClanUIEvent", {
					name = f153_local1,
					privacyLevel = f153_local2,
					controller = f153_arg2,
					event = LuaEnum.CLAN_UI_EVENT.CREATE_GROUP,
					kind = LuaEnum.CLAN_KINDS.SQUAD,
				})
				GoBack(f153_arg4, f153_arg2)
			end
		end)
	)
	return f152_local0
end, true)
DataSources.CreateTeamForm = {
	getModel = function(f154_arg0)
		local f154_local0 = Engine.GetModel(Engine.GetModelForController(f154_arg0), "CreateTeamForm")
		if f154_local0 == nil then
			f154_local0 = Engine.CreateModel(Engine.GetModelForController(f154_arg0), "CreateTeamForm")
			Engine.CreateModel(f154_local0, "name")
			Engine.SetModelValue(Engine.CreateModel(f154_local0, "type"), 1)
			Engine.CreateModel(f154_local0, "hintTitle")
			Engine.CreateModel(f154_local0, "hintText")
		end
		return f154_local0
	end,
}
DataSources.CreateTeamNameDescription = ListHelper_SetupDataSource("CreateTeamNameDescription", function(f155_arg0)
	local f155_local0 = {}
	table.insert(
		f155_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData("clan/team_name", "clan/team_name_desc", "", function(f156_arg0, f156_arg1, f156_arg2, f156_arg3, f156_arg4)
			ShowKeyboard(f156_arg0, f156_arg1, f156_arg2, "KEYBOARD_TYPE_CLAN_NAME")
		end, {
			actionType = "name",
		})
	)
	return f155_local0
end, true)
DataSources.CreateTeamType = ListHelper_SetupDataSource("CreateTeamType", function(f157_arg0)
	local f157_local0 = {}
	local f157_local1 = function(f158_arg0, f158_arg1, f158_arg2, f158_arg3)
		local f158_local0 = DataSources.CreateTeamForm.getModel(f158_arg2)
		f158_local0 = f158_local0.type
		local f158_local1 = (f158_local0:get() - 1) % #CoD.ClanUtility.clan_privacy_levels
		if f158_local1 == 0 then
			f158_local1 = #CoD.ClanUtility.clan_privacy_levels or f158_local1
		end
		f158_local0:set(f158_local1)
		local f158_local2 = f158_arg0:getModel(f158_arg2, "currentNum")
		f158_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f158_local1].display_string))
	end
	local f157_local2 = function(f159_arg0, f159_arg1, f159_arg2, f159_arg3)
		local f159_local0 = DataSources.CreateTeamForm.getModel(f159_arg2)
		f159_local0 = f159_local0.type
		local f159_local1 = (f159_local0:get() + 1) % #CoD.ClanUtility.clan_privacy_levels
		if f159_local1 == 0 then
			f159_local1 = #CoD.ClanUtility.clan_privacy_levels or f159_local1
		end
		f159_local0:set(f159_local1)
		local f159_local2 = f159_arg0:getModel(f159_arg2, "currentNum")
		f159_local2:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f159_local1].display_string))
	end
	local f157_local3 = DataSources.CreateTeamForm.getModel(f157_arg0)
	f157_local3 = f157_local3.type:get()
	table.insert(f157_local0, CoD.CoDAccountUtility.packageNumOptionsButtonData(@"hash_66985D51346D79E8", "clan/team_type_desc", Engine[@"hash_4F9F1239CFD921FE"](CoD.ClanUtility.clan_privacy_levels[f157_local3.type:get()].display_string), f157_local1, f157_local2))
	return f157_local0
end, true)
DataSources.CreateTeamConfirmation = ListHelper_SetupDataSource("CreateTeamConfirmation", function(f160_arg0)
	local f160_local0 = {}
	table.insert(
		f160_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData("clan/create_team", "clan/create_team_desc", nil, function(f161_arg0, f161_arg1, f161_arg2, f161_arg3, f161_arg4)
			local f161_local0 = DataSources.CreateTeamForm.getModel(f161_arg2)
			local f161_local1 = f161_local0.name:get()
			local f161_local2 = f161_local0.type
			f161_local2 = CoD.ClanUtility.clan_privacy_levels[REG7:get()].value
			if not f161_local1 or string.len(f161_local1) == 0 then
				LuaUtils.UI_ShowErrorMessageDialog(f161_arg2, @"hash_5419BBF769DD4724", "menu/notice_caps")
				return
			else
				local f161_local3 = Engine.GetGlobalModel()
				f161_local3.socialRoot.teams.loaded:set(LuaEnum.CLAN_INFO_MODELS.CREATING_TEAM)
				if CoD.CraftUtility.IsClanEmblemEmpty(f161_arg2) then
					LuaUtils.UI_ShowErrorMessageDialog(f161_arg2, @"hash_6719ACB7DA0AACF9", "menu/notice_caps")
					return
				else
					Engine[@"lobbyevent"]("OnClanUIEvent", {
						name = f161_local1,
						privacyLevel = f161_local2,
						controller = f161_arg2,
						event = LuaEnum.CLAN_UI_EVENT.CREATE_GROUP,
						kind = LuaEnum.CLAN_KINDS.TEAM,
					})
					GoBack(f161_arg4, f161_arg2)
				end
			end
		end)
	)
	return f160_local0
end, true)
DataSources.SocialPlayerDetailsButtons = ListHelper_SetupDataSource(
	"SocialPlayerDetailsButtons",
	function(f162_arg0, f162_arg1)
		local f162_local0 = Engine.GetModelForController(f162_arg0)
		local f162_local1 = f162_local0:create("Social.selectedFriendXUID")
		f162_local1 = f162_local1:get()
		local f162_local2 = f162_local0:create("Social.selectedFriendGamertag")
		f162_local2 = f162_local2:get()
		local f162_local3 = Engine.CreateModel(f162_local0, "Social.selectedFriendInTitle")
		f162_local3 = f162_local3:get()
		local f162_local4 = {}
		f162_local4 = CoD.SocialUtility.GetFriendsButtonOptions(f162_arg0, f162_arg1, f162_local1, f162_local2, f162_local3, false, "")
		local f162_local5 = {}
		if not CoD.isPC then
			for f162_local9, f162_local10 in ipairs(f162_local4) do
				if not f162_local10.disabled or not CoD.DirectorUtility.DisableForCurrentMilestone() then
					table.insert(f162_local5, {
						models = {
							displayText = f162_local10.text,
							customId = f162_local10.customId,
						},
						properties = {
							disabled = f162_local10.disabled,
							action = f162_local10.action,
							actionParam = f162_local10.params,
							isLastButtonInGroup = f162_local10.lastInGroup,
						},
					})
				end
			end
		end
		if CoD.isPC then
			local f162_local6 = CoD.PCWidgetUtility.PlayerContextualMenuOptionsIDOrder
			if not InFrontend() then
				f162_local6 = CoD.PCWidgetUtility.InGamePlayerContextualMenuOptionsIDOrder
			end
			for f162_local10, f162_local16 in ipairs(f162_local6) do
				for f162_local11, f162_local12 in ipairs(f162_local4) do
					if f162_local12.id == f162_local16 and (not f162_local12.disabled or not CoD.DirectorUtility.DisableForCurrentMilestone()) then
						table.insert(f162_local5, {
							models = {
								displayText = f162_local12.text,
								customId = f162_local12.customId,
							},
							properties = {
								disabled = f162_local12.disabled,
								action = f162_local12.action,
								actionParam = f162_local12.params,
								isLastButtonInGroup = f162_local12.lastInGroup,
							},
						})
					end
				end
				for f162_local12, f162_local15 in pairs(CoD.PCWidgetUtility.PlayerContextualMenuExtraOptionsData) do
					if f162_local15.id == f162_local16 and f162_local15.visibilityFct(f162_arg0, f162_arg1.menu, f162_local1) then
						table.insert(f162_local5, {
							models = {
								displayText = f162_local15.name,
							},
							properties = {
								disabled = false,
								action = f162_local15.clickFct,
							},
						})
					end
				end
			end
		end
		return f162_local5
	end,
	nil,
	nil,
	function(f163_arg0, f163_arg1, f163_arg2) end,
	function(f164_arg0, f164_arg1, f164_arg2)
		if f164_arg0.SocialPlayerDetailsButtons[f164_arg1].properties.isLastButtonInGroup then
			return 16
		else
			return 0
		end
	end
)
CoD.ClanUtility.GetFirstTeamAndSquadID = function(f165_arg0)
	local f165_local0 = CoD.ClanUtility.GetControllerClanModel(f165_arg0)
	local f165_local1 = f165_local0.squads
	local f165_local2 = 0
	if f165_local1.count:get() > 0 then
		local f165_local3 = "squad"
		f165_local2 = f165_local1["squad" .. 1].ID:get()
	end
	local f165_local3 = f165_local0.teams
	local f165_local4 = 0
	if f165_local3.count:get() > 0 then
		local f165_local5 = "team"
		f165_local4 = f165_local3["team" .. 1].ID:get()
	end
	return f165_local2, f165_local4
end
CoD.ClanUtility.GetClanMembersCount = function(f166_arg0, f166_arg1)
	if Engine[@"getdvarbool"]("live_clansEnabled") then
		local f166_local0 = CoD.ClanUtility.GetControllerClanModel(f166_arg0)
		local f166_local1 = f166_local0:create("members")
		if f166_local1.count == nil or f166_local1.count:get() == 0 then
			return 0
		end
		local f166_local2 = f166_local1:create("list")
		local f166_local3, f166_local4 = CoD.ClanUtility.GetFirstTeamAndSquadID(f166_arg0)
		if f166_arg1 == "clan_Team" or f166_arg1 == "clan_Squad" then
			local f166_local5 = 0
			local f166_local6 = f166_arg1 == "clan_Team"
			for f166_local7 = 1, f166_local1.count:get() or 0, 1 do
				local f166_local10 = "member"
				local f166_local11 = f166_local1[f166_local2["member" .. f166_local7].xuidStr:get()]
				local f166_local12 = f166_local11
				local f166_local13 = f166_local11.create
				local f166_local14
				if f166_local6 then
					f166_local14 = "teams"
					if not f166_local14 then
					else
						f166_local13 = f166_local13(f166_local12, f166_local14)
						for f166_local12 = 1, f166_local13.count:get() or 0, 1 do
							local f166_local16
							if f166_local6 then
								f166_local16 = "team"
								if not f166_local16 then
								else
									f166_local16 = f166_local13[f166_local16 .. f166_local12]
									if f166_local6 then
										local f166_local17 = f166_local4
									end
									if (f166_local17 or f166_local3) == f166_local16.ID:get() then
										f166_local5 = f166_local5 + 1
									end
								end
							end
							f166_local16 = "squad"
						end
					end
				end
				f166_local14 = "squads"
			end
			return f166_local5
		else
			return f166_local1.count:get()
		end
	else
		return 0
	end
end
CoD.ClanUtility.GetPlayerInfo = function(f167_arg0, f167_arg1, f167_arg2, f167_arg3)
	if f167_arg1 ~= 0 then
		local f167_local0 = Engine[@"hash_483DD7A7721E8089"](f167_arg1, f167_arg0, f167_arg3)
		if f167_local0 then
			f167_local0.index = f167_arg2
			f167_local0.xuid = f167_arg1
			f167_local0.gamertag = Engine[@"hash_61FB3481C8114A9A"](f167_arg1)
			f167_local0.clantag = ""
			f167_local0.time = 0
			f167_local0.titlePresence = Engine[@"hash_2CB211F53F96C674"](f167_local0.time)
			return f167_local0
		end
	end
	return nil
end
CoD.ClanUtility.GetPlayersParty = function(f168_arg0, f168_arg1)
	local f168_local0 = CoD.ClanUtility.GetControllerClanModel(f168_arg0)
	local f168_local1 = f168_local0:create("members")
	if f168_arg1 < f168_local1.count:get() then
		local f168_local2 = f168_local1:create("list")
		local f168_local3 = "member"
		local f168_local4 = f168_local2["member" .. f168_arg1 + 1].xuidStr
		local f168_local5 = f168_local1[f168_local3:get()].xuid:get()
		return Engine.GetGetRecentPlayerParty(f168_local5, Engine[@"hash_61FB3481C8114A9A"](f168_local5))
	else
		return nil
	end
end
CoD.ClanUtility.GetClanRank = function(f169_arg0)
	local f169_local0 = CoD.ClanUtility.GetControllerClanModel(f169_arg0)
	return f169_local0.clans.clan1.role:get()
end
CoD.ClanUtility.GetClanId = function(f170_arg0)
	local f170_local0 = CoD.ClanUtility.GetControllerClanModel(f170_arg0)
	local f170_local1 = f170_local0.clans.clan1
	local f170_local2
	if f170_local1 then
		f170_local2 = f170_local1.ID:get()
		if not f170_local2 then
		else
			return f170_local2
		end
	end
	f170_local2 = nil
end
CoD.ClanUtility.GetTeamRank = function(f171_arg0, f171_arg1)
	local f171_local0 = CoD.ClanUtility.GetControllerClanModel(f171_arg0)
	local f171_local1 = f171_local0.teams["team" .. f171_arg1]
	local f171_local2
	if f171_local1 then
		f171_local2 = f171_local1.role:get()
		if not f171_local2 then
		else
			return f171_local2
		end
	end
	f171_local2 = nil
end
CoD.ClanUtility.GetSquadRank = function(f172_arg0, f172_arg1)
	local f172_local0 = CoD.ClanUtility.GetControllerClanModel(f172_arg0)
	local f172_local1 = f172_local0.squads["squad" .. f172_arg1]
	local f172_local2
	if f172_local1 then
		f172_local2 = f172_local1.role:get()
		if not f172_local2 then
		else
			return f172_local2
		end
	end
	f172_local2 = nil
end
CoD.ClanUtility.GetCurrentTeamId = function()
	local f173_local0 = Engine.GetGlobalModel()
	f173_local0 = f173_local0.socialRoot.clans.currentTeamId
	local f173_local1
	if f173_local0 then
		f173_local1 = f173_local0:get()
		if not f173_local1 then
		else
			return f173_local1
		end
	end
	f173_local1 = 1
end
CoD.ClanUtility.GetCurrentSquadId = function()
	local f174_local0 = Engine.GetGlobalModel()
	f174_local0 = f174_local0.socialRoot.clans.currentSquadId
	local f174_local1
	if f174_local0 then
		f174_local1 = f174_local0:get()
		if not f174_local1 then
		else
			return f174_local1
		end
	end
	f174_local1 = 1
end
CoD.ClanUtility.TriggerClanUIEvent = function(f175_arg0, f175_arg1, f175_arg2, f175_arg3, f175_arg4)
	Engine[@"lobbyevent"]("OnClanUIEvent", f175_arg3)
end
CoD.ClanUtility.AddMemberActions = function(f176_arg0, f176_arg1, f176_arg2, f176_arg3)
	if not Dvar[@"hash_3CA8E9EDE02C25E6"]:get() then
		return
	end
	local f176_local0 = Engine.GetXUID64(f176_arg0)
	local f176_local1 = Engine[@"xuidtostring"](f176_local0)
	local f176_local2 = Engine.GetGlobalModel()
	f176_local2 = f176_local2.LobbyClients
	if not f176_local2[f176_local1] or not f176_local2[f176_local1].clan or not f176_local2[f176_local1].clan.clans then
		return
	end
	local f176_local3 = CoD.ClanUtility.GetControllerClanModel(f176_arg0)
	local f176_local4 = f176_local3.clans.clan1
	if f176_arg1 and f176_arg1.menu.GroupType and f176_arg1.menu.GroupType == "clan" and f176_local4 then
		local f176_local5 = f176_local4.role:get()
		local f176_local6 = f176_arg3.selectedXuid
		if f176_local0 == f176_local6 then
			return
		end
		local f176_local7 = Engine[@"xuidtostring"](f176_local6)
		local f176_local8 = f176_local3:create("members")
		local f176_local9 = f176_local8[f176_local7].clans.clan1.role:get()
		if f176_local5 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] or f176_local5 == Enum[@"hash_610C0A769A29C38F"][@"hash_29B9CAA2877C8082"] then
			local f176_local10 = f176_local4.kind:get()
			local f176_local11 = f176_local4.ID:get()
			local f176_local12 = f176_local4.rootKind:get()
			local f176_local13 = f176_local4.rootID:get()
			if f176_local9 ~= Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
				table.insert(f176_arg2, {
					text = @"hash_670AED9E4CE592E5",
					id = "remove",
					disabled = false,
					action = CoD.ClanUtility.TriggerClanUIEvent,
					params = {
						controller = f176_arg0,
						event = LuaEnum.CLAN_UI_EVENT.REMOVE_USER,
						kind = f176_local10,
						ID = f176_local11,
						rootKind = f176_local12,
						rootID = f176_local13,
						user = f176_local6,
						newOwner = 0,
					},
				})
			end
			if f176_local9 == Enum[@"hash_610C0A769A29C38F"][@"hash_4B17C2FE5CC7F0BC"] then
				table.insert(f176_arg2, {
					text = @"hash_5DA92135781670E5",
					id = "promote",
					disabled = false,
					action = CoD.ClanUtility.TriggerClanUIEvent,
					params = {
						controller = f176_arg0,
						event = LuaEnum.CLAN_UI_EVENT.ADD_OR_UPDATE_USER,
						kind = f176_local10,
						ID = f176_local11,
						rootKind = f176_local12,
						rootID = f176_local13,
						role = Enum[@"hash_610C0A769A29C38F"][@"hash_29B9CAA2877C8082"],
						xuid = f176_local6,
					},
				})
			end
			if f176_local9 == Enum[@"hash_610C0A769A29C38F"][@"hash_29B9CAA2877C8082"] then
				table.insert(f176_arg2, {
					text = @"hash_610EDC2E3F8322E1",
					id = "demote",
					disabled = false,
					action = CoD.ClanUtility.TriggerClanUIEvent,
					params = {
						controller = f176_arg0,
						event = LuaEnum.CLAN_UI_EVENT.ADD_OR_UPDATE_USER,
						kind = f176_local10,
						ID = f176_local11,
						rootKind = f176_local12,
						rootID = f176_local13,
						role = Enum[@"hash_610C0A769A29C38F"][@"hash_4B17C2FE5CC7F0BC"],
						xuid = f176_local6,
					},
				})
			end
			if f176_local5 == Enum[@"hash_610C0A769A29C38F"][@"hash_4E94BCDEEB8AE946"] then
				table.insert(f176_arg2, {
					text = @"hash_65D97D3BA7259C1C",
					id = "transfer_ownership",
					disabled = false,
					action = CoD.ClanUtility.TriggerClanUIEvent,
					params = {
						controller = f176_arg0,
						event = LuaEnum.CLAN_UI_EVENT.REMOVE_USER,
						kind = f176_local10,
						ID = f176_local11,
						rootKind = f176_local12,
						rootID = f176_local13,
						user = 0,
						newOwner = f176_local6,
					},
				})
			end
		end
	end
end
CoD.ClanUtility.GetClanMembersFilteredList = function(f177_arg0)
	return CoD.ClanUtility.GetMembersFilteredList(f177_arg0)
end
CoD.ClanUtility.GetSquadMembersFilteredList = function(f178_arg0)
	local f178_local0 = CoD.ClanUtility.GetControllerClanModel(f178_arg0)
	if f178_local0.squads.count:get() == 0 then
		return {}
	else
		local f178_local1 = f178_local0.squads.squad1
		return CoD.ClanUtility.GetMembersFilteredList(f178_arg0, f178_local1.kind:get(), f178_local1.ID:get())
	end
end
CoD.ClanUtility.GetTeamMembersFilteredList = function(f179_arg0)
	local f179_local0 = CoD.ClanUtility.GetControllerClanModel(f179_arg0)
	if f179_local0.teams.count:get() == 0 then
		return {}
	else
		local f179_local1 = f179_local0.teams.team1
		return CoD.ClanUtility.GetMembersFilteredList(f179_arg0, f179_local1.kind:get(), f179_local1.ID:get())
	end
end
CoD.ClanUtility.GetMembersFilteredList = function(f180_arg0, f180_arg1, f180_arg2)
	local f180_local0 = {}
	if Engine[@"getdvarbool"]("live_clansEnabled") then
		local f180_local1 = CoD.ClanUtility.GetControllerClanModel(f180_arg0)
		local f180_local2 = f180_local1:create("members")
		if f180_local2.count == nil or f180_local2.count:get() == 0 then
			return f180_local0
		end
		local f180_local3 = f180_local2:create("list")
		for f180_local4 = 1, f180_local2.count:get() or 0, 1 do
			local f180_local7 = "member"
			local f180_local8 = f180_local2[f180_local3["member" .. f180_local4].xuidStr:get()]
			local f180_local9 = f180_local8.xuid:get()
			local f180_local10 = false
			if f180_arg1 then
				local f180_local11 = f180_arg1 == LuaEnum.CLAN_KINDS.SQUAD
				local f180_local12
				if f180_local11 then
					f180_local12 = f180_local8.squads
					if not f180_local12 then
					else
						for f180_local13 = 1, f180_local12.count:get() or 0, 1 do
							local f180_local16
							if f180_local11 then
								f180_local16 = "squad"
								if not f180_local16 then
								elseif f180_arg2 == f180_local12[f180_local16 .. f180_local13].ID:get() then
									f180_local10 = true
								end
							end
							f180_local16 = "team"
						end
					end
				end
				f180_local12 = f180_local8.teams
			else
				f180_local10 = true
			end
			if f180_local10 then
				table.insert(f180_local0, f180_local9)
			end
		end
	end
	return f180_local0
end
CoD.ClanUtility.GetMembersList = function(f181_arg0, f181_arg1, f181_arg2, f181_arg3, f181_arg4)
	local f181_local0 = {}
	if Engine[@"getdvarbool"]("live_clansEnabled") then
		if f181_arg4 == nil then
			return f181_local0
		elseif f181_arg4 ~= nil and #f181_arg4 > 0 then
			local f181_local1 = math.min(f181_arg1 + f181_arg2, #f181_arg4) - 1
			for f181_local2 = f181_arg1, f181_local1, 1 do
				local f181_local5 = CoD.ClanUtility.GetPlayerInfo(f181_arg0, f181_arg4[f181_local2 + 1], f181_local2, f181_arg3)
				if f181_local5 then
					table.insert(f181_local0, f181_local5)
				end
			end
		end
	end
	return f181_local0
end
DataSources.ClanData = {
	getModel = function(f182_arg0)
		local f182_local0 = Engine.CreateModel(Engine.GetModelForController(f182_arg0), "ClanData")
		local f182_local1 = Engine.StorageGetBuffer(f182_arg0, Enum.StorageFileType[@"hash_56CA620BD75C97F4"], LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA)
		if f182_local1 then
			local f182_local2 = f182_local0:create("description")
			f182_local2:set(f182_local1.description:get())
			f182_local2 = f182_local0:create("messageXuid")
			f182_local2:set(Engine[@"hash_690B6BCE69A8E08B"](f182_local1.messageXuid:get()))
			f182_local2 = f182_local0:create("message")
			f182_local2:set(f182_local1.message:get())
		else
			local f182_local2 = f182_local0:create("description")
			f182_local2:set("")
			f182_local2 = f182_local0:create("messageXuid")
			f182_local2:set(LuaDefine.ZERO_X64)
			f182_local2 = f182_local0:create("message")
			f182_local2:set("")
		end
		return f182_local0
	end,
}
CoD.ClanUtility.UploadClanDataFile = function(f183_arg0)
	local f183_local0 = CoD.ClanUtility.GetControllerClanModel(f183_arg0)
	if f183_local0 then
		local f183_local1 = f183_local0.clans:create("clan1")
		if f183_local1 then
			local f183_local2 = {
				Enum.StorageFileType[@"hash_56CA620BD75C97F4"],
			}
			local f183_local3 = {
				LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA,
			}
			local f183_local4 = {}
			f183_local4 = f183_local1.kind:get()
			local f183_local5 = {}
			f183_local5 = f183_local1.ID:get()
			local f183_local6 = {}
			f183_local6 = f183_local1.rootKind:get()
			local f183_local7 = {}
			Engine[@"hash_37079182F35F6DF8"](f183_arg0, f183_local2, f183_local3, f183_local4, f183_local5, f183_local6, f183_local1.rootID:get(), {
				LuaEnum.CLAN_STORAGE.DATA,
			})
			Engine[@"hash_7FD581BCE55651E3"](f183_arg0, Enum.StorageFileType[@"hash_56CA620BD75C97F4"], LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA)
			return true
		end
	end
	return false
end
CoD.ClanUtility.HandleMessageKeyboardComplete = function(f184_arg0, f184_arg1, f184_arg2, f184_arg3)
	if f184_arg3.type == Enum.KeyboardType[@"hash_73E8DD5E8D7F1377"] then
		local f184_local0 = Engine.StorageGetBuffer(f184_arg2, Enum.StorageFileType[@"hash_56CA620BD75C97F4"], LuaEnum.CLAN_STORAGE_SLOT.CLAN_DATA)
		if f184_local0 then
			local f184_local1 = Engine.GetXUID64(f184_arg2)
			f184_local0.message:set(f184_arg3.input)
			f184_local0.messageXuid:set(f184_local1)
			CoD.ClanUtility.UploadClanDataFile(f184_arg2)
			local f184_local2 = DataSources.ClanData.getModel(f184_arg2)
			if f184_local2 then
				f184_local2.message:set(f184_arg3.input)
				f184_local2.messageXuid:set(f184_local1)
			end
		end
	end
end
CoD.ClanUtility.SetCurrentTeamId = function(f185_arg0, f185_arg1, f185_arg2)
	local f185_local0 = f185_arg2:getModel()
	f185_local0 = f185_local0.listId:get()
	local f185_local1 = Engine.GetGlobalModel()
	f185_local1.socialRoot.clans.currentTeamId:set(f185_local0)
end
CoD.ClanUtility.SetCurrentSquadId = function(f186_arg0, f186_arg1, f186_arg2)
	local f186_local0 = f186_arg2:getModel()
	f186_local0 = f186_local0.listId:get()
	local f186_local1 = Engine.GetGlobalModel()
	f186_local1.socialRoot.clans.currentSquadId:set(f186_local0)
end
