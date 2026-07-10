CoD.PCBattlenetUtility = {}
require("x64:f3c5259f470592d")
CoD.PCBattlenetUtility.BattleNetStatusColor = {
	[Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"]] = ColorSet.Disabled,
	[Enum[@"hash_28811A60F2FF3ADA"][@"hash_AF6B7B618097742"]] = ColorSet.SelectedGreen,
	[Enum[@"hash_28811A60F2FF3ADA"][@"hash_4EB39E1DBA4A0581"]] = ColorSet.T8__RED,
	[Enum[@"hash_28811A60F2FF3ADA"][0xBDC39BBB7981F3]] = ColorSet.Orange,
	[Enum[@"hash_28811A60F2FF3ADA"][@"hash_51442D86F5EAE084"]] = ColorSet.T8_PC_FRIENDLIST_STATUS_APPEAROFFLINE,
}
CoD.PCBattlenetUtility.SocialBNetStatusOptions = {
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_18674F2AD2F7E63"),
		value = Enum[@"hash_28811A60F2FF3ADA"][@"hash_AF6B7B618097742"],
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2493C9E36F36FA5A"),
		value = Enum[@"hash_28811A60F2FF3ADA"][0xBDC39BBB7981F3],
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_415F728F9607EFB6"),
		value = Enum[@"hash_28811A60F2FF3ADA"][@"hash_4EB39E1DBA4A0581"],
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](0xA8F50E1CF8319D),
		value = Enum[@"hash_28811A60F2FF3ADA"][@"hash_51442D86F5EAE084"],
	},
}
CoD.PCBattlenetUtility.SortEnum = {
	NONE = 0,
	ALPHABETICALLY_ASC = 1,
	ALPHABETICALLY_DESC = 2,
	STARTUPTIME_ASC = 3,
	STARTUPTIME_DESC = 4,
}
CoD.PCBattlenetUtility.Filters = {
	NONE = 0,
	ONLINE_PLAYERS = 1,
	OFFLINE_PLAYERS = 2,
	AVAILABLE_PLAYERS = 3,
	INVITABLE_PLAYERS = 4,
	AVAILABLE_NOT_IN_PARTY_PLAYERS = 5,
}
DataSources.SocialBNetStatus = DataSourceHelpers.ListSetup("PC.SocialBNetStatus", function(f1_arg0)
	local f1_local0 = {}
	for f1_local4, f1_local5 in pairs(CoD.PCBattlenetUtility.SocialBNetStatusOptions) do
		table.insert(f1_local0, {
			models = f1_local5,
		})
	end
	return f1_local0
end, true)
DataSources.SocialPlayerBNetStatusSelection = {
	getModel = function(f2_arg0)
		local f2_local0 = Engine[@"getglobalmodel"]()
		local f2_local1 = f2_local0.SocialPlayerBNetStatusSelection
		if not f2_local1 then
			f2_local1 = f2_local0:create("SocialPlayerBNetStatusSelection")
			local f2_local2 = f2_local1:create("name")
			f2_local2:set(Engine[@"hash_4F9F1239CFD921FE"](0x9711F8DC125AA9))
			f2_local2 = f2_local1:create("optionsDataSource")
			f2_local2:set("SocialBNetStatus")
			f2_local2 = f2_local1:create("text")
			f2_local2:set("")
			f2_local2 = f2_local1:create("isOpen")
			f2_local2:set(false)
		end
		return f2_local1
	end,
}
local f0_local0 = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	return {
		models = {
			identityBadge = {
				gamertag = f3_arg2,
				xuid = f3_arg3,
			},
			inviteStatus = f3_arg1,
			isLeader = f3_arg4,
		},
		properties = {},
	}
end
CoD.PCBattlenetUtility.PrepareSocialStatusDropdownProperties = function(f4_arg0, f4_arg1)
	local f4_local0 = nil
	f4_arg0._optionProperties = {}
	f4_arg0._optionProperties._options = CoD.PCBattlenetUtility.SocialBNetStatusOptions
	f4_arg0._optionProperties._setCurrentValue = function(f5_arg0, f5_arg1, f5_arg2)
		Engine[@"hash_42B8D6EFEDD52BA1"](f5_arg2)
		f4_arg0.immediateUpdateValue = f5_arg2
		local f5_local0 = f4_arg0:getModel()
		f5_local0.currentValue:set(f4_arg0._optionProperties._getCurrentValue())
	end
	f4_arg0._optionProperties._getCurrentValue = function()
		if f4_arg0.immediateUpdateValue then
			local f6_local0 = f4_arg0.immediateUpdateValue
			f4_arg0.immediateUpdateValue = nil
			return f6_local0
		else
			return Engine[@"getbattlenetpresence"](Engine[@"getxuid64"](f4_arg1))
		end
	end
	local f4_local1 = DataSources.SocialPlayerBNetStatusSelection:getModel()
	if f4_local1 then
		local f4_local2 = f4_local1:create("currentValue")
		f4_local2:set(f4_arg0._optionProperties._getCurrentValue())
	end
	local f4_local3 = f4_arg0
	local f4_local2 = f4_arg0.subscribeToModel
	local f4_local4 = DataSources.BattlenetGlobal.getModel(f4_arg1)
	f4_local2(f4_local3, f4_local4.PresenceStatus, function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		f4_arg0.immediateUpdateValue = f7_local0
		local f7_local1 = f4_arg0:getModel()
		f7_local1.currentValue:set(f7_local0)
	end, false)
	f4_local3 = f4_arg0
	f4_local2 = f4_arg0.subscribeToModel
	f4_local4 = DataSources.BattlenetGlobal.getModel(f4_arg1)
	f4_local2(f4_local3, f4_local4.AFK, function(f8_arg0)
		local f8_local0 = DataSources.BattlenetGlobal.getModel(f4_arg1)
		f8_local0.PresenceStatus:set(f8_arg0:get() and Enum[@"hash_28811A60F2FF3ADA"][0xBDC39BBB7981F3] or Engine[@"getbattlenetpresence"](Engine[@"getxuid64"](f4_arg1)))
	end, false)
end
CoD.PCBattlenetUtility.BattleNetStatusToColor = function(f9_arg0)
	local f9_local0 = CoD.PCBattlenetUtility.BattleNetStatusColor[f9_arg0]
	return "" .. f9_local0.r * 255 .. " " .. f9_local0.g * 255 .. " " .. f9_local0.b * 255
end
CoD.PCBattlenetUtility.BattlenetPresenceToLocalizedString = function(f10_arg0)
	local f10_local0 = tonumber(f10_arg0)
	if f10_local0 == Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"] or f10_local0 == Enum[@"hash_28811A60F2FF3ADA"][@"hash_51442D86F5EAE084"] then
		return @"menu/offline"
	elseif f10_local0 == Enum[@"hash_28811A60F2FF3ADA"][@"hash_AF6B7B618097742"] then
		return @"hash_18674F2AD2F7E63"
	elseif f10_local0 == Enum[@"hash_28811A60F2FF3ADA"][@"hash_4EB39E1DBA4A0581"] then
		return @"hash_415F728F9607EFB6"
	elseif f10_local0 == Enum[@"hash_28811A60F2FF3ADA"][0xBDC39BBB7981F3] then
		return @"hash_2493C9E36F36FA5A"
	else
		return @"menu/offline"
	end
end
CoD.PCBattlenetUtility.GetBattlenetPresence = function(f11_arg0)
	local f11_local0 = Engine[@"getbattlenetpresence"](f11_arg0)
	if Engine[@"hash_2F6571B0C7CBC89F"](f11_arg0) and f11_local0 ~= Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"] then
		f11_local0 = Enum[@"hash_28811A60F2FF3ADA"][0xBDC39BBB7981F3]
	end
	return f11_local0
end
CoD.PCBattlenetUtility.GetBattlenetRichPresenceString = function(f12_arg0)
	if Engine[@"getbattlenetpresence"](f12_arg0.xuid) == Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"] then
		return Engine[@"hash_4F9F1239CFD921FE"](CoD.LobbyUtility.Presence.Strings[Enum[@"presencetitle"][@"hash_51CF21FD793411B9"]])
	else
		local f12_local0 = Engine[@"hash_9F39CCC1A10CFD3"](f12_arg0.xuid)
		if f12_local0 and f12_local0.presencestring ~= nil and f12_local0.presencestring ~= "" then
			return f12_local0.presencestring
		else
			return GetPresenceString(f12_arg0)
		end
	end
end
local f0_local1 = function(f13_arg0, f13_arg1, f13_arg2)
	if not f13_arg1.liveFriendsUpdateRegistered then
		f13_arg1.liveFriendsUpdateRegistered = true
		local f13_local0 = f13_arg1
		local f13_local1 = f13_arg1.subscribeToModel
		local f13_local2 = DataSources.BattlenetGlobal.getModel(f13_arg0)
		f13_local1(f13_local0, f13_local2.FriendUpdateEvent, function(f14_arg0)
			if not f13_arg1.liveFriendUpdateTimer then
				f13_arg1.liveFriendUpdateTimer = LUI.UITimer.newElementTimer(250, true, function(f15_arg0)
					f13_arg1:updateDataSource()
					f13_arg1.liveFriendUpdateTimer = nil
				end)
				f13_arg1:addElement(f13_arg1.liveFriendUpdateTimer)
			end
		end, false)
	end
end
local f0_local2 = function(f16_arg0, f16_arg1, f16_arg2)
	if not f16_arg1.recentplayersUpdateRegistered then
		f16_arg1.recentplayersUpdateRegistered = true
		local f16_local0 = f16_arg1
		local f16_local1 = f16_arg1.subscribeToModel
		local f16_local2 = Engine[@"getglobalmodel"]()
		f16_local1(f16_local0, f16_local2["pcache.presenceFetched"], function(f17_arg0)
			if not f16_arg1.recentplayerUpdateTimer then
				f16_arg1.recentplayerUpdateTimer = LUI.UITimer.newElementTimer(250, true, function(f18_arg0)
					f16_arg1:updateDataSource()
					f16_arg1.recentplayerUpdateTimer = nil
				end)
				f16_arg1:addElement(f16_arg1.recentplayerUpdateTimer)
			end
		end, false)
	end
end
local f0_local3 = function(f19_arg0, f19_arg1, f19_arg2)
	f0_local1(f19_arg0, f19_arg1, f19_arg2)
	CoD.SocialUtility.AddUpdateDatasourceOnTabUpdate(f19_arg0, f19_arg1)
	CoD.SocialUtility.UpdateCheckedInvitees(f19_arg0)
end
local f0_local4 = function(f20_arg0, f20_arg1, f20_arg2)
	if not f20_arg1._partySizeSubscription then
		local f20_local0 = f20_arg1
		local f20_local1 = f20_arg1.subscribeToModel
		local f20_local2 = Engine[@"getglobalmodel"]()
		f20_arg1._partySizeSubscription = f20_local1(f20_local0, f20_local2.lobbyRoot.privateClient.count, function()
			f20_arg1:clearLayout()
			f20_arg1:updateDataSource()
		end, false)
	end
	CoD.SocialUtility.OnPartyEventUpdate(f20_arg0, f20_arg1)
end
local f0_local5 = function(f22_arg0, f22_arg1, f22_arg2)
	if not f22_arg1.liveFriendsUpdateRegistered then
		f22_arg1.liveFriendsUpdateRegistered = true
		local f22_local0 = f22_arg1
		local f22_local1 = f22_arg1.subscribeToModel
		local f22_local2 = DataSources.BattlenetGlobal.getModel(f22_arg0)
		f22_local1(f22_local0, f22_local2.FriendUpdateEvent, function(f23_arg0)
			if not f22_arg1.liveFriendUpdateTimer then
				f22_arg1.liveFriendUpdateTimer = LUI.UITimer.newElementTimer(250, true, function(f24_arg0)
					for f24_local0 = 1, f22_arg1.vCount, 1 do
						local f24_local3 = f22_arg1:getItemAtPosition(f24_local0, 1, false)
						f24_local3.ElementList:updateDataSource()
					end
					f22_arg1.liveFriendUpdateTimer = nil
				end)
				f22_arg1:addElement(f22_arg1.liveFriendUpdateTimer)
			end
		end, false)
	end
end
local f0_local6 = function(f25_arg0, f25_arg1)
	local f25_local0 = Engine[@"getbattlenetpresence"](f25_arg1)
	local f25_local1 = Engine[@"getplayerinfo"](f25_arg0, f25_arg1)
	if f25_local1 and f25_local1.info then
		if not f25_local1.info.joinable then
			local f25_local2 = Enum[@"lobbyjoinable"][@"lobby_joinable_no"]
		end
		if f25_local1.info.playlist and CoD.SocialUtility.IsMissingDLCForPlaylist(f25_local1.info.playlist) then
			local f25_local2 = Enum[@"lobbyjoinable"][@"lobby_joinable_no_you_need_dlc"]
		end
		if f25_local1.info.mapid and not CoD.MapUtility.LobbyHasMap(f25_local1.info.mapid) then
			local f25_local2 = Enum[@"lobbyjoinable"][@"lobby_joinable_no_you_need_dlc"]
		end
		return f25_local0, f25_local2
	else
		return f25_local0, Enum[@"lobbyjoinable"][@"lobby_joinable_no"]
	end
end
CoD.PCBattlenetUtility.GetPartyInviteStatus = function(f26_arg0, f26_arg1)
	local f26_local0, f26_local1 = f0_local6(f26_arg0, f26_arg1)
	if Engine[@"hash_5AE0FCE9E5D69F01"](f26_arg0, f26_arg1) then
		return CoD.PCWidgetUtility.PartyInviteStatus.PENDING
	elseif Engine[@"hash_D3DDFE2224597C2"](f26_arg0, f26_arg1) then
		return CoD.PCWidgetUtility.PartyInviteStatus.RECEIVED
	elseif f26_local0 == Enum[@"hash_28811A60F2FF3ADA"][@"hash_AF6B7B618097742"] then
		return CoD.PCWidgetUtility.PartyInviteStatus.NOT_SENT
	else
		return CoD.PCWidgetUtility.PartyInviteStatus.UNAVAILABLE
	end
end
local f0_local7 = function(f27_arg0, f27_arg1)
	return f27_arg0.models.identityBadge.gamertag:lower() < f27_arg1.models.identityBadge.gamertag:lower()
end
local f0_local8 = function(f28_arg0, f28_arg1)
	if (f28_arg0.models.battlenetProgramId == LuaDefine.BATTLENET_CURRENTGAME_FOURCC or f28_arg1.models.battlenetProgramId == LuaDefine.BATTLENET_CURRENTGAME_FOURCC) and f28_arg0.models.battlenetProgramId ~= f28_arg1.models.battlenetProgramId then
		return f28_arg0.models.battlenetProgramId == LuaDefine.BATTLENET_CURRENTGAME_FOURCC
	else
		return f28_arg0.models.identityBadge.gamertag:lower() < f28_arg1.models.identityBadge.gamertag:lower()
	end
end
local f0_local9 = function(f29_arg0, f29_arg1)
	return f29_arg1.models.identityBadge.gamertag:lower() < f29_arg0.models.identityBadge.gamertag:lower()
end
local f0_local10 = function(f30_arg0, f30_arg1)
	return f30_arg0.models.startupTimestamp < f30_arg1.models.startupTimestamp
end
local f0_local11 = function(f31_arg0, f31_arg1)
	return f31_arg1.models.startupTimestamp < f31_arg0.models.startupTimestamp
end
local f0_local12 = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3, f32_arg4)
	if f32_arg1 == CoD.PCBattlenetUtility.Filters.ONLINE_PLAYERS and f32_arg3 == Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"] then
		return true
	elseif f32_arg1 == CoD.PCBattlenetUtility.Filters.OFFLINE_PLAYERS and f32_arg3 ~= Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"] then
		return true
	elseif (f32_arg1 == CoD.PCBattlenetUtility.Filters.AVAILABLE_PLAYERS or f32_arg1 == CoD.PCBattlenetUtility.Filters.AVAILABLE_NOT_IN_PARTY_PLAYERS) and (not (f32_arg3 ~= Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"] and Engine[@"isplayerintitle"](f32_arg0, f32_arg2) and (f32_arg4 or CoD.canInviteToGame(f32_arg0, f32_arg2))) or f32_arg1 == CoD.PCBattlenetUtility.Filters.AVAILABLE_NOT_IN_PARTY_PLAYERS and CoD.LobbyUtility.IsPlayerInMyParty(f32_arg2)) then
		return true
	elseif f32_arg1 == CoD.PCBattlenetUtility.Filters.INVITABLE_PLAYERS and not Engine[@"isplayerinvitable"](f32_arg0, f32_arg2) then
		return true
	else
		return false
	end
end
local f0_local13 = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4, f33_arg5, f33_arg6, f33_arg7)
	local f33_local0 = f33_arg2(f33_arg0, 0, 200, Enum[@"presencefilter"][@"presence_filter_all"], f33_arg4)
	local f33_local1 = {}
	local f33_local2 = {}
	local f33_local3 = 0
	if 0 < #f33_local0 then
		local f33_local4 = Engine[@"getprofilevarint"](f33_arg0, @"show_real_names") ~= 0
		for f33_local28, f33_local25 in pairs(f33_local0) do
			local f33_local9, f33_local8 = f0_local6(f33_arg0, f33_local25.xuid)
			if CoD.LobbyUtility.IsPlayerInMyParty(f33_local25.xuid) then
				f33_local8 = Enum[@"lobbyjoinable"][@"hash_78FCE6A0B08CD559"]
			end
			if Engine[@"hash_65CB8E6B7FBBFFD5"](f33_local25.xuid) then
				f33_local9 = Enum[@"hash_28811A60F2FF3ADA"][@"hash_AF6B7B618097742"]
			elseif f33_arg2 == CoD.SocialUtility.GetRecentPlayersList then
				if f33_local25.primaryPresence ~= 0 or f33_local8 == 1 then
					f33_local9 = Enum[@"hash_28811A60F2FF3ADA"][@"hash_AF6B7B618097742"]
				end
			elseif Engine[@"hash_2F6571B0C7CBC89F"](f33_local25.xuid) and f33_local9 ~= Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"] then
				f33_local9 = Enum[@"hash_28811A60F2FF3ADA"][0xBDC39BBB7981F3]
			end
			if not f0_local12(f33_arg0, f33_arg1, f33_local25.xuid, f33_local9, f33_local8) then
				local f33_local10 = Engine[@"getplayerinfo"](f33_arg0, f33_local25.xuid)
				local f33_local11 = f33_local25.realname
				local f33_local12 = ""
				local f33_local13 = ""
				if f33_local10 ~= nil then
					f33_local12 = GetPresenceContextString(f33_local10.info)
					f33_local13 = GetPresenceActivityString(f33_local10.info)
					if not f33_local11 and f33_local10.info then
						f33_local11 = f33_local10.info.realname
					end
				end
				local f33_local14 = Engine[@"hash_9F39CCC1A10CFD3"](f33_local25.xuid)
				local f33_local15
				if f33_local14 then
					f33_local15 = f33_local14.programFourCC
					if not f33_local15 then
					else
						local f33_local16 = ""
						if f33_local14 == nil or f33_arg2 == CoD.SocialUtility.GetRecentPlayersList and f33_local15 ~= LuaDefine.BATTLENET_CURRENTGAME_FOURCC then
							f33_local16 = f33_local25.titlePresence
						else
							f33_local16 = CoD.PCBattlenetUtility.GetBattlenetRichPresenceString(f33_local10.info)
						end
						local f33_local17 = Enum[@"presencetitle"][@"hash_51CF21FD793411B9"]
						if f33_local14 ~= nil and f33_local14.programFourCC == LuaDefine.BATTLENET_CURRENTGAME_FOURCC and f33_local10 ~= nil and f33_local10.info ~= nil then
							f33_local17 = f33_local10.info.presence
						end
						local f33_local18, f33_local19 = CoD.ArenaLeaguePlayUtility.GetRubies(f33_local25.arenaLeaguePlayPoints)
						local f33_local20 = {}
						local f33_local21 = {}
						local f33_local22 = {
							gamertag = f33_local25.gamertag,
							xuid = f33_local25.xuid,
							clantag = f33_local25.clantag,
						}
						if f33_local4 then
							local f33_local23 = f33_local11
						end
						f33_local22.realName = f33_local23 or ""
						f33_local21.identityBadge = f33_local22
						f33_local21.backgroundId = f33_local25.backgroundId
						f33_local21.gamertag = f33_local25.gamertag
						if f33_local4 then
							local f33_local24 = f33_local11
						end
						f33_local21.realName = f33_local24 or ""
						f33_local21.xuid = f33_local25.xuid
						f33_local21.joinable = f33_local8
						f33_local21.inviteStatus = CoD.PCWidgetUtility.SocialInviteStatus.IN_PARTY
						f33_local21.partyInviteStatus = CoD.PCBattlenetUtility.GetPartyInviteStatus(f33_arg0, f33_local25.xuid)
						f33_local21.isLeader = false
						f33_local21.battlenetPresence = f33_local9
						f33_local21.presence = f33_local17
						f33_local21.primaryPresence = f33_local9
						f33_local21.presenceString = f33_local16
						f33_local21.battlenetProgramId = f33_local15
						f33_local21.partySize = 0
						f33_local21.isMemberLeader = f33_local25.isLeader
						f33_local21.empty = false
						f33_local21.isBot = Engine[@"hash_65CB8E6B7FBBFFD5"](f33_local25.xuid)
						f33_local21.startupTimestamp = f33_local25.startupTimestamp
						f33_local21.trial = f33_local25.trial
						f33_local21.playlist = f33_local25.playlist
						f33_local21.mapid = f33_local25.mapid
						f33_local21.rubiesUnlocked = f33_local19
						f33_local21.blackopsPass = f33_local25.blackopsPass
						f33_local21.lobbyDLCBits = f33_local25.lobbyDLCBits
						f33_local20.models = f33_local21
						f33_local20.properties = {}
						if f33_arg6 then
							f33_local25 = CoD.SocialUtility.AddRankData(f33_local25)
							f33_local25.rankInfo = CoD.RankUtility.GetClientRankInfoModel(f33_local25.xuid)
							f33_local21 = {
								"cpRank",
								"mpRank",
								"wzRank",
								"zmRank",
								"arenaRank",
								"cpRankIcon",
								"mpRankIcon",
								"wzRankIcon",
								"zmRankIcon",
								"arenaRankIcon",
								"cpRankName",
								"mpRankName",
								"wzRankName",
								"zmRankName",
								"arenaRankName",
								"wzRankString",
								"rankInfo",
							}
							for f33_local22 = 1, #f33_local21, 1 do
								f33_local20.models[f33_local21[f33_local22]] = f33_local25[f33_local21[f33_local22]]
							end
							if f33_arg3 then
								local f33_local26 = CoD.SocialUtility.GetPartyModel(f33_local10.info, f33_arg3(f33_arg0, f33_local3), f33_local25.gamertag, f33_local2)
								if f33_local26 then
									f33_local20.properties.party = f33_local26
									f33_local20.models.partySize = f33_local26.partySize
									f33_local20.models.partyMax = f33_local26.partyMax
									f33_local20.models.partyBarType = f33_local26.partyBarType
								end
								f33_local20.properties.party = {}
							end
						end
						table.insert(f33_local1, f33_local20)
					end
				end
				f33_local15 = "DEFAULT"
			end
		end
		if f33_arg7 then
			table.sort(f33_local1, f0_local7)
		else
			return f33_local1
		end
		f33_local3 = f33_local3 + 1
	end
	return f33_local1
end
local f0_local14 = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3, f34_arg4)
	return f0_local13(f34_arg0, f34_arg2, CoD.ClanUtility.GetMembersList, CoD.ClanUtility.GetPlayersParty, CoD.ClanUtility.GetClanMembersFilteredList(f34_arg0), CoD.ClanUtility.GetClanMembersCount(f34_arg0, f34_arg1), f34_arg3, f34_arg4)
end
local f0_local15 = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
	return f0_local13(f35_arg0, f35_arg1, Engine[@"getfriends"], Engine[@"hash_E940BDCC0375A9D"], nil, Engine[@"getfriendscount"](f35_arg0, Enum[@"presencefilter"][@"presence_filter_all"]), f35_arg2, f35_arg3)
end
local f0_local16 = function(f36_arg0, f36_arg1, f36_arg2, f36_arg3)
	return f0_local13(f36_arg0, f36_arg1, CoD.SocialUtility.GetRecentPlayersList, CoD.SocialUtility.GetRecentPlayersParty, nil, CoD.SocialUtility.GetRecentPlayersCount(f36_arg0), f36_arg2, f36_arg3)
end
local f0_local17 = function(f37_arg0, f37_arg1, f37_arg2)
	return f0_local13(f37_arg0, f37_arg1, CoD.SocialUtility.GetPartyPlayersList, nil, nil, nil, true, f37_arg2)
end
local f0_local18 = function(f38_arg0)
	return f0_local15(f38_arg0, CoD.PCBattlenetUtility.Filters.NONE, false, true)
end
local f0_local19 = function(f39_arg0)
	local f39_local0 = f0_local15(f39_arg0, CoD.PCBattlenetUtility.Filters.ONLINE_PLAYERS, false, false)
	table.sort(f39_local0, f0_local8)
	return f39_local0
end
local f0_local20 = function(f40_arg0)
	return f0_local15(f40_arg0, CoD.PCBattlenetUtility.Filters.OFFLINE_PLAYERS, false, true)
end
local f0_local21 = function(f41_arg0)
	return f0_local15(f41_arg0, CoD.PCBattlenetUtility.Filters.NONE, true, true)
end
local f0_local22 = function(f42_arg0)
	local f42_local0 = f0_local15(f42_arg0, CoD.PCBattlenetUtility.Filters.AVAILABLE_PLAYERS, true, false)
	local f42_local1 = DataSources.SocialRoot.getModel(f42_arg0)
	f42_local1.visibleCount:set(#f42_local0)
	if #f42_local0 > 0 then
		CoD.PCBattlenetUtility.SortArrayUsingCurrentSort(f42_arg0, f42_local0)
	end
	return f42_local0
end
local f0_local23 = function(f43_arg0)
	local f43_local0 = f0_local15(f43_arg0, CoD.PCBattlenetUtility.Filters.AVAILABLE_NOT_IN_PARTY_PLAYERS, true, false)
	local f43_local1 = DataSources.SocialRoot.getModel(f43_arg0)
	f43_local1.visibleCount:set(#f43_local0)
	if #f43_local0 > 0 then
		table.sort(f43_local0, f0_local7)
	end
	return f43_local0
end
local f0_local24 = function(f44_arg0)
	return f0_local16(f44_arg0, CoD.PCBattlenetUtility.Filters.INVITABLE_PLAYERS, true)
end
local f0_local25 = function(f45_arg0)
	return f0_local16(f45_arg0, CoD.PCBattlenetUtility.Filters.NONE, true)
end
local f0_local26 = function(f46_arg0, f46_arg1)
	return f0_local14(f46_arg0, f46_arg1, CoD.PCBattlenetUtility.Filters.NONE, true)
end
local f0_local27 = function(f47_arg0)
	local f47_local0 = f0_local17(f47_arg0, CoD.PCBattlenetUtility.Filters.NONE, true)
	if CoD.canSendInvites(f47_arg0) then
		local f47_local1 = #f47_local0
		local f47_local2 = Engine[@"getglobalmodel"]()
		if f47_local1 < f47_local2.PartyPrivacy.maxPlayers:get() then
			f47_local1 = Engine[@"getglobalmodel"]()
			if f47_local1.PartyPrivacy.privacy:get() ~= Enum[@"partyprivacy"][@"party_privacy_closed"] then
				table.insert(f47_local0, {
					models = {
						empty = true,
					},
					properties = {},
				})
			end
		end
	end
	return f47_local0
end
local f0_local28 = function(f48_arg0)
	local f48_local0 = {}
	local f48_local1 = DataSources.SocialRoot.getModel(f48_arg0)
	local f48_local2 = f48_local1.tab:get()
	local f48_local3 = f48_local1.inviteType
	if f48_local3 then
		f48_local3 = f48_local1.inviteType:get()
	end
	if f48_local2 == "friends" then
		if f48_local3 ~= "" then
			f48_local0 = f0_local21(f48_arg0)
		else
			f48_local0 = f0_local23(f48_arg0)
		end
	elseif f48_local2 == "recent" then
		if f48_local3 ~= "" then
			f48_local0 = f0_local25(f48_arg0)
		else
			f48_local0 = f0_local24(f48_arg0)
		end
	elseif f48_local2 == "clan" or f48_local2 == "clan_Members" then
		f48_local0 = f0_local26(f48_arg0, f48_local2)
	elseif f48_local2 == "clan_Squad" then
	elseif f48_local2 == "clan_Team" then
	else
	end
	for f48_local8, f48_local9 in pairs(f48_local0) do
		local f48_local10 = f48_local9.models
		local f48_local7
		if CoD.SocialUtility.CheckedInvitees[Engine[@"xuidtostring"](f48_local9.models.xuid)] then
			f48_local7 = true
		else
			f48_local7 = false
		end
		f48_local10.checked = f48_local7
	end
	f48_local1.visibleCount:set(#f48_local0)
	return f48_local0
end
DataSources.SocialFriendsList = DataSourceHelpers.ListSetup("PC.SocialFriendsList", f0_local18, true)
DataSources.SocialOnlineFriendsList = DataSourceHelpers.ListSetup("PC.SocialOnlineFriendsList", f0_local19, true)
DataSources.SocialOfflineFriendsList = DataSourceHelpers.ListSetup("PC.SocialOfflineFriendsList", f0_local20, true)
DataSources.SocialAvailableFriendsList = DataSourceHelpers.ListSetup("PC.SocialAvailableFriendsList", f0_local22, true, nil, f0_local1)
DataSources.SocialRecentPlayersList = DataSourceHelpers.ListSetup("PC.SocialRecentPlayersList", f0_local25, true, nil, f0_local2)
DataSources.SocialPartyPlayersList = DataSourceHelpers.ListSetup("PC.SocialPartyPlayersList", f0_local27, true, nil, f0_local4)
DataSources.SocialInvitePlayersList = DataSourceHelpers.ListSetup("PC.SocialInvitePlayersList", f0_local28, true, nil, f0_local3)
DataSources.BattlenetFriendsCategories = DataSourceHelpers.ListSetup("PC.BattlenetFriendsCategories", function(f49_arg0)
	local f49_local0 = {}
	table.insert(f49_local0, {
		models = {
			name = @"hash_1293E9A0FF05994F",
			widgetType = "expander",
			optionsDatasource = "SocialFriendRequestReceivedList",
			frameWidget = "PC_BattlenetFriend_ReceiveInvite",
			isOpen = true,
			listCount = 0,
			hideIfEmpty = true,
		},
	})
	table.insert(f49_local0, {
		models = {
			name = @"hash_72CE507688648CE1",
			widgetType = "expander",
			optionsDatasource = "SocialOnlineFriendsList",
			frameWidget = "PC_BattlenetFriend_Online",
			isOpen = true,
			listCount = 0,
			hideIfEmpty = false,
		},
	})
	table.insert(f49_local0, {
		models = {
			name = @"hash_69C0AE137E2F6A87",
			widgetType = "expander",
			optionsDatasource = "SocialOfflineFriendsList",
			frameWidget = "PC_BattlenetFriend_Offline",
			isOpen = true,
			listCount = 0,
			hideIfEmpty = false,
		},
	})
	table.insert(f49_local0, {
		models = {
			name = @"hash_6C1AD2743678BA04",
			widgetType = "expander",
			optionsDatasource = "SocialFriendRequestSentList",
			frameWidget = "PC_BattlenetFriend_SentInvite",
			isOpen = true,
			listCount = 0,
			hideIfEmpty = true,
		},
	})
	return f49_local0
end, true, nil, f0_local5)
DataSources.SocialFriendRequestReceivedList = DataSourceHelpers.ListSetup("PC.SocialFriendRequestReceivedList", function(f50_arg0)
	local f50_local0 = Engine[@"hash_23841AB6604548A6"]()
	local f50_local1 = {}
	if #f50_local0 > 0 then
		for f50_local5, f50_local6 in pairs(f50_local0) do
			table.insert(f50_local1, {
				models = {
					identityBadge = {
						gamertag = f50_local6.gamertag,
					},
					inviteStatus = CoD.PCWidgetUtility.SocialInviteStatus.RECEIVED,
					requestIndex = f50_local6.requestIndex,
				},
				properties = {},
			})
		end
	end
	table.sort(f50_local1, f0_local7)
	return f50_local1
end, true)
DataSources.SocialFriendRequestSentList = DataSourceHelpers.ListSetup("PC.SocialFriendRequestSentList", function(f51_arg0)
	local f51_local0 = Engine[@"hash_112E30D380C03F77"]()
	local f51_local1 = {}
	if #f51_local0 > 0 then
		for f51_local5, f51_local6 in pairs(f51_local0) do
			table.insert(f51_local1, {
				models = {
					identityBadge = {
						gamertag = f51_local6.gamertag,
					},
					inviteStatus = CoD.PCWidgetUtility.SocialInviteStatus.PENDING,
					requestIndex = f51_local6.requestIndex,
				},
				properties = {},
			})
		end
	end
	table.sort(f51_local1, f0_local7)
	return f51_local1
end, true)
DataSources.SocialPartyInviteList = DataSourceHelpers.ListSetup("PC.PartyInviteList", function(f52_arg0)
	local f52_local0 = Engine[@"hash_592F1FB0C7454E9C"](f52_arg0)
	local f52_local1 = {}
	if #f52_local0 > 0 then
		for f52_local6, f52_local7 in pairs(f52_local0) do
			local f52_local8 = Engine[@"getbattlenetpresence"](f52_local7.xuid)
			local f52_local9 = Engine[@"getplayerinfo"](f52_arg0, f52_local7.xuid)
			local f52_local10 = table.insert
			local f52_local11 = f52_local1
			local f52_local12 = {}
			local f52_local13 = {
				identityBadge = {
					gamertag = f52_local9.info.gamertag,
					xuid = f52_local7.xuid,
				},
				xuid = f52_local7.xuid,
			}
			local f52_local5 = f52_local9.info.joinable
			if not f52_local5 then
				f52_local5 = Enum[@"lobbyjoinable"][@"lobby_joinable_no"]
			end
			f52_local13.joinable = f52_local5
			f52_local13.battlenetPresence = f52_local8
			f52_local13.inviteStatus = CoD.PCWidgetUtility.SocialInviteStatus.IN_PARTY
			f52_local13.partyInviteStatus = CoD.PCBattlenetUtility.GetPartyInviteStatus(f52_arg0, f52_local7.xuid)
			f52_local12.models = f52_local13
			f52_local10(f52_local11, f52_local12)
		end
	end
	return f52_local1
end, true)
DataSources.SocialTitleTabs = DataSourceHelpers.ListSetup("SocialTitleTabs", function(f53_arg0, f53_arg1)
	local f53_local0 = {}
	table.insert(f53_local0, {
		models = {
			name = @"hash_7AC7CB771618A995",
			available = true,
			tabContent = "CoD.PC_SocialMenu_FriendTabContent",
		},
	})
	table.insert(f53_local0, {
		models = {
			name = @"hash_18F2C8CBB96C1826",
			available = true,
			tabContent = "CoD.PC_SocialMenu_PartyInvitesTab",
		},
	})
	return f53_local0
end, true)
CoD.PCBattlenetUtility.SetSortFunction = function(f54_arg0, f54_arg1)
	local f54_local0 = DataSources.BattlenetGlobal.getModel(f54_arg0)
	if f54_local0 and f54_local0.CurrentSort and f54_local0.FriendUpdateEvent and f54_arg1 then
		f54_local0.CurrentSort:set(f54_arg1)
		Engine[@"forcenotifymodelsubscriptions"](f54_local0.FriendUpdateEvent)
	end
end
CoD.PCBattlenetUtility.SortArrayUsingCurrentSort = function(f55_arg0, f55_arg1)
	local f55_local0 = DataSources.BattlenetGlobal.getModel(f55_arg0)
	f55_local0 = f55_local0.CurrentSort:get()
	if f55_local0 == CoD.PCBattlenetUtility.SortEnum.ALPHABETICALLY_ASC then
		table.sort(f55_arg1, f0_local7)
	elseif f55_local0 == CoD.PCBattlenetUtility.SortEnum.ALPHABETICALLY_DESC then
		table.sort(f55_arg1, f0_local9)
	elseif f55_local0 == CoD.PCBattlenetUtility.SortEnum.STARTUPTIME_ASC then
		table.sort(f55_arg1, f0_local10)
	elseif f55_local0 == CoD.PCBattlenetUtility.SortEnum.STARTUPTIME_DESC then
		table.sort(f55_arg1, f0_local11)
	end
	return f55_arg1
end
CoD.OverlayUtility.AddSystemOverlay("RemoveFriendConfirmation", {
	menuName = "SystemOverlay_Compact",
	title = Engine[@"localize"](@"hash_62ABB014B7887052"),
	description = function(f56_arg0, f56_arg1)
		return Engine[@"localize"](@"hash_6303418D0232357A", CoD.SocialUtility.CleanGamerTag(f56_arg1.gamertag))
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
	listDatasource = function(f57_arg0, f57_arg1)
		DataSources.RemoveFriendConfirmation_List = DataSourceHelpers.ListSetup("RemoveFriendConfirmation_List", function(f58_arg0)
			return {
				{
					models = {
						displayText = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"menu/confirm")),
					},
					properties = {
						actionParam = f57_arg1,
						action = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3, f59_arg4)
							Engine[@"removefriend"](f59_arg3.xuid)
							GoBack(f59_arg4, f59_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"menu/cancel")),
					},
					properties = {
						action = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3, f60_arg4)
							GoBack(f60_arg4, f60_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "RemoveFriendConfirmation_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f61_arg0, f61_arg1)
		return function(f62_arg0, f62_arg1)
			Engine[@"removefriend"](f61_arg1.xuid)
			GoBack(f62_arg0, f62_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = @"menu/confirm",
	[CoD.OverlayUtility.bCirclePromptFn] = function()
		return function(f64_arg0, f64_arg1)
			GoBack(f64_arg0, f64_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = @"menu/cancel",
})
CoD.PCBattlenetUtility.HasSentFriendInvite = function(f65_arg0)
	for f65_local3, f65_local4 in pairs(Engine[@"hash_112E30D380C03F77"]()) do
		if f65_arg0 == f65_local4.gamertag then
			return true
		end
	end
	return false
end
CoD.PCBattlenetUtility.StripBattleTagNumber = function(f66_arg0)
	local f66_local0, f66_local1 = string.find(f66_arg0, "#")
	if f66_local0 ~= nil then
		f66_arg0 = string.sub(f66_arg0, 1, f66_local0 - 1)
	end
	return f66_arg0
end
CoD.PCBattlenetUtility.MenuHasBattlenetMenu = function(f67_arg0, f67_arg1)
	return CoD.PCUtility.FrontendBattlenetContainer ~= nil
end
CoD.PCBattlenetUtility.MenuBattlenetIsActive = function(f68_arg0)
	local f68_local0 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel(f68_arg0)
	return f68_local0:get()
end
CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive = function(f69_arg0)
	local f69_local0 = CoD.PCBattlenetUtility.GetBattlenetAddFriendMenuVisibilityModel(f69_arg0)
	return f69_local0:get()
end
CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel = function(f70_arg0)
	local f70_local0 = DataSources.BattlenetGlobal.getModel(f70_arg0)
	return f70_local0.BattlenetMenuVisibility
end
CoD.PCBattlenetUtility.GetBattlenetAddFriendMenuVisibilityModel = function(f71_arg0)
	local f71_local0 = DataSources.BattlenetGlobal.getModel(f71_arg0)
	return f71_local0.BattlenetAddFriendMenuVisibility
end
CoD.PCBattlenetUtility.ShowIfInViper = function(f72_arg0, f72_arg1)
	local f72_local0
	if f72_arg0 == LuaDefine.BATTLENET_CURRENTGAME_FOURCC then
		f72_local0 = 1
		if not f72_local0 then
		else
			return f72_local0
		end
	end
	f72_local0 = 0
end
CoD.PCBattlenetUtility.ToggleBattlenetAddFriendMenuVisibility = function(f73_arg0)
	local f73_local0 = CoD.PCBattlenetUtility.GetBattlenetAddFriendMenuVisibilityModel(f73_arg0)
	f73_local0:set(not f73_local0:get())
end
CoD.PCBattlenetUtility.SetupAddFriendEditBox = function(f74_arg0, f74_arg1, f74_arg2)
	f74_arg2:subscribeToModel(CoD.PCBattlenetUtility.GetBattlenetAddFriendMenuVisibilityModel(f74_arg1), function(model, f75_arg1)
		local f75_local0 = f75_arg1:getMenu()
		if model and model:get() and f75_local0 and f75_local0.occludedBy == nil and f75_local0.currentInputFocus ~= f75_arg1 then
			f75_local0:ChangeInputFocus(f74_arg1, f75_arg1)
		end
	end)
end
CoD.PCBattlenetUtility.PreSetupMenuBattlenet = function(f76_arg0, f76_arg1, f76_arg2)
	CoD.PCUtility.FrontendBattlenetContainer = f76_arg0
	DataSources.BattlenetGlobal.prepare(f76_arg2)
	CoD.PCUtility.RegisterStickyElement(f76_arg0, f76_arg1)
	f76_arg0:subscribeToModel(CoD.ChatClientUtility.GetCurrentChattingModel(f76_arg2), function(model, f77_arg1)
		CoD.PCBattlenetUtility.CloseBattlenetMenu(f77_arg1, f76_arg1, f76_arg2, false)
	end)
	f76_arg0:subscribeToModel(CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel(f76_arg2), function(model, f78_arg1)
		if model:get() then
			local f78_local0 = CoD.ChatClientUtility.GetCurrentChattingModel(f76_arg2)
			f78_local0:set(false)
		end
	end)
end
CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility = function(f79_arg0, f79_arg1, f79_arg2)
	local f79_local0 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel(f79_arg2)
	if not f79_local0:get() and CoD.StartMenuUtility.IsClassSelectSlideoutOpen(f79_arg2) then
		CoD.StartMenuUtility.HideClassSelectSlideout(f79_arg1, f79_arg2)
	end
	CoD.PCBattlenetUtility.SetBattlenetMenuVisibility(f79_arg0, f79_arg1, f79_arg2, f79_local0, not f79_local0:get(), true)
end
CoD.PCBattlenetUtility.CloseBattlenetMenu = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
	CoD.PCBattlenetUtility.SetBattlenetMenuVisibility(f80_arg0, f80_arg1, f80_arg2, CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel(f80_arg2), false, f80_arg3)
end
CoD.PCBattlenetUtility.SetBattlenetMenuVisibility = function(f81_arg0, f81_arg1, f81_arg2, f81_arg3, f81_arg4, f81_arg5)
	if not f81_arg3 then
		f81_arg3 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel(f81_arg2)
	end
	if not f81_arg3 or f81_arg3:get() == f81_arg4 then
		return
	elseif f81_arg5 then
		f81_arg0:playSound("menu_open", f81_arg2)
	end
	f81_arg3:set(f81_arg4)
	if f81_arg4 then
		local f81_local0 = Engine[@"forcenotifymodelsubscriptions"]
		local f81_local1 = DataSources.BattlenetGlobal.getModel(f81_arg2)
		f81_local0(f81_local1.FriendUpdateEvent)
	else
		local f81_local0 = Engine[@"getmodelforcontroller"](f81_arg2)
		f81_local0 = f81_local0["EditBoxGlobal.BattlenetFriendsFilter"]
		if f81_local0 then
			f81_local0:set("")
		end
	end
end
