
CoD.SocialUtility = {}
CoD.SocialUtility.PartyPrivacyOptions = {
	{
		name = Engine[0xF9F1239CFD921FE]( 0xD7568CAE1BE3F6B ),
		value = Enum[0x70DC6CE53EF2D31][0x9ACC1F9917ADDE9]
	},
	{
		name = Engine[0xF9F1239CFD921FE]( 0xD5B11C63C41C427 ),
		value = Enum[0x70DC6CE53EF2D31][0xBE1A36D69A39221]
	},
	{
		name = Engine[0xF9F1239CFD921FE]( 0x4D4EA9B2703EF9 ),
		value = Enum[0x70DC6CE53EF2D31][0x2507221A765592F]
	},
	{
		name = Engine[0xF9F1239CFD921FE]( 0x980DDEA2FD1615B ),
		value = Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5]
	}
}
CoD.SocialUtility.VoiceChatChannelOptions = {}
CoD.SocialUtility.VoiceChatChannelOptions = {
	{
		name = Engine[0xF9F1239CFD921FE]( 0x4B8B52C6A6E8972 ),
		value = 0
	},
	{
		name = Engine[0xF9F1239CFD921FE]( 0x2ED1CE9B3CDBA91 ),
		value = 2
	}
}
CoD.SocialUtility.GetRankIcons = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3 )
	if not f1_arg1 then
		return "t7_icon_rank_" .. f1_arg0 .. "_ghost_level_01"
	elseif f1_arg0 == "mp" then
		if f1_arg3 > 0 then
			return Engine[0xE21763E1EB756F8]( f1_arg3, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
		else
			return Engine[0xD4A9B159BE44163]( f1_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
		end
	elseif f1_arg0 == "zm" then
		if f1_arg3 > 0 then
			return Engine[0xE21763E1EB756F8]( f1_arg3, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
		else
			return Engine[0xD4A9B159BE44163]( f1_arg2, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
		end
	elseif f1_arg0 == "wz" then
		if f1_arg3 > 0 then
			return Engine[0xE21763E1EB756F8]( f1_arg3, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
		else
			return Engine[0xD4A9B159BE44163]( f1_arg2, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
		end
	elseif f1_arg0 == "cp" then
		return 0x7615068F50B3D66
	else
		return Engine[0xD4A9B159BE44163]( f1_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
	end
end
CoD.SocialUtility.freerunGametypeId = nil
CoD.SocialUtility.GetFreerunGametypeId = function ()
	if CoD.SocialUtility.freerunGametypeId == nil then
		local f2_local0 = Engine[0xEA74FA7EE46E195]( "fr" )
		CoD.SocialUtility.freerunGametypeId = f2_local0.uniqueID
	end
	return CoD.SocialUtility.freerunGametypeId
end
CoD.SocialUtility.GetRecentPlayersCount = function ( f3_arg0 )
	if Engine[0x9E5BE3B4BBA4E0E]( "recentPlayerListEnabled" ) then
		local f3_local0 = Engine[0x8BF970606552F4C]( f3_arg0, Enum[0xBBD4F9E70101BA8][0x2C45CE6FD0D4539] )
		if f3_local0 then
			return f3_local0.count:get()
		end
	end
	return 0
end
CoD.SocialUtility.GetRecentPlayersParty = function ( f4_arg0, f4_arg1 )
	local f4_local0 = Engine[0x8BF970606552F4C]( f4_arg0, Enum[0xBBD4F9E70101BA8][0x2C45CE6FD0D4539] )
	if f4_local0 and f4_arg1 < f4_local0.count:get() then
		local f4_local1 = Engine[0x90B6BCE69A8E08B]( f4_local0.playersMet[f4_arg1].xuid:get() )
		return Engine[0x76AF615B56E40B5]( f4_local1, Engine[0x1FB3481C8114A9A]( f4_local1 ) )
	else
		return nil
	end
end
CoD.SocialUtility.GetRecentPlayerInfo = function ( f5_arg0, f5_arg1, f5_arg2, f5_arg3 )
	local f5_local0 = f5_arg1.playersMet[f5_arg2]
	local f5_local1 = Engine[0x90B6BCE69A8E08B]( f5_local0.xuid:get() )
	if f5_local1 ~= 0 then
		local f5_local2 = Engine[0x83DD7A7721E8089]( f5_local1, f5_arg0, f5_arg3 )
		if f5_local2 then
			f5_local2.index = f5_arg2
			f5_local2.xuid = f5_local1
			f5_local2.gamertag = Engine[0x1FB3481C8114A9A]( f5_local1 )
			f5_local2.clantag = ""
			f5_local2.time = f5_local0.time:get()
			f5_local2.titlePresence = Engine[0xCB211F53F96C674]( f5_local0.time:get() )
			return f5_local2
		end
	end
	return nil
end
CoD.SocialUtility.GetRecentPlayerInfoNoUpdate = function ( f6_arg0, f6_arg1, f6_arg2, f6_arg3 )
	local f6_local0 = f6_arg1.playersMet[f6_arg2]
	local f6_local1 = Engine[0x90B6BCE69A8E08B]( f6_local0.xuid:get() )
	if f6_local1 ~= 0 then
		return {
			xuid = f6_local1,
			time = f6_local0.time:get()
		}
	else
		return nil
	end
end
CoD.SocialUtility.GetPartyPlayersList = function ()
	local f7_local0 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
	local f7_local1 = Engine[0x3E68E350BEFE50D]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] )
	local f7_local2 = nil
	if f7_local1 and f7_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] then
		f7_local2 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] )
	else
		f7_local2 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110] )
	end
	return f7_local2.sessionClients
end
CoD.SocialUtility.GetRecentPlayersList = function ( f8_arg0, f8_arg1, f8_arg2, f8_arg3 )
	local f8_local0 = {}
	f8_arg3 = Enum[0xEA28383B5DEC206][0x708B5057D80F5FF]
	if Engine[0x9E5BE3B4BBA4E0E]( "recentPlayerListEnabled" ) then
		local f8_local1 = Engine[0x8BF970606552F4C]( f8_arg0, Enum[0xBBD4F9E70101BA8][0x2C45CE6FD0D4539] )
		if f8_local1 then
			if f8_local1.isSorted:get() ~= 0 then
				local f8_local2 = math.min( f8_arg1 + f8_arg2, f8_local1.count:get() ) - 1
				for f8_local3 = f8_arg1, f8_local2, 1 do
					local f8_local6 = CoD.SocialUtility.GetRecentPlayerInfo( f8_arg0, f8_local1, f8_local3, f8_arg3 )
					if f8_local6 then
						table.insert( f8_local0, f8_local6 )
					end
				end
			else
				local f8_local2 = {}
				for f8_local3 = 0, f8_local1.count:get() - 1, 1 do
					local f8_local6 = nil
					local f8_local7 = CoD.SocialUtility.GetRecentPlayerInfo
					if f8_arg3 == Enum[0xEA28383B5DEC206][0x708B5057D80F5FF] then
						f8_local7 = CoD.SocialUtility.GetRecentPlayerInfoNoUpdate
					end
					local f8_local8 = f8_local7( f8_arg0, f8_local1, f8_local3, f8_arg3 )
					if f8_local8 then
						f8_local8.ddlIndex = f8_local3
						table.insert( f8_local2, f8_local8 )
					end
				end
				table.sort( f8_local2, function ( f9_arg0, f9_arg1 )
					if f9_arg0.xuid == 0 then
						return f9_arg1.xuid == 0
					elseif f9_arg1.xuid == 0 then
						return true
					else
						return f9_arg1.time < f9_arg0.time
					end
				end )
				if f8_arg3 == Enum[0xEA28383B5DEC206][0x708B5057D80F5FF] then
					for f8_local4 = 1, #f8_local2, 1 do
						local f8_local7 = f8_local4 - 1
						f8_local1.playersMet[f8_local7].time:set( f8_local2[f8_local4].time )
						f8_local1.playersMet[f8_local7].xuid:set( f8_local2[f8_local4].xuid )
						if f8_arg1 <= f8_local7 and f8_local7 < f8_arg2 then
							table.insert( f8_local0, CoD.SocialUtility.GetRecentPlayerInfo( f8_arg0, f8_local1, f8_local2[f8_local4].ddlIndex, f8_arg3 ) )
						end
					end
					f8_local1.isSorted:set( 1 )
				end
				local f8_local4 = math.min( f8_arg1 + f8_arg2, #f8_local2 )
				for f8_local5 = f8_arg1 + 1, f8_local4, 1 do
					local f8_local8 = CoD.SocialUtility.GetRecentPlayerInfo( f8_arg0, f8_local1, f8_local2[f8_local5].ddlIndex, f8_arg3 )
					if f8_local8 then
						table.insert( f8_local0, f8_local8 )
					end
				end
			end
		end
	end
	return f8_local0
end
CoD.SocialUtility.OnPartyEventUpdate = function ( f10_arg0, f10_arg1 )
	local f10_local0 = {}
	local f10_local1 = Engine[0x8DF2E5447F384B9]()
	f10_local1 = f10_local1.PartyPrivacy.maxPlayers
	local f10_local2 = Engine[0x8DF2E5447F384B9]()
	f10_local2 = f10_local2.PartyPrivacy.privacy
	local f10_local3 = Engine[0x8DF2E5447F384B9]()
	f10_local3 = f10_local3.lobbyRoot.privateClient.update
	f10_local0[1] = f10_local1
	f10_local0[2] = f10_local2
	f10_local0[3] = f10_local3
	CoD.SocialUtility.AddRefreshListSubscription( f10_arg0, f10_arg1, f10_local0, "refreshListPartySubscriptions" )
end
CoD.SocialUtility.AddRefreshListSubscription = function ( f11_arg0, f11_arg1, f11_arg2, f11_arg3 )
	for f11_local3, f11_local4 in ipairs( f11_arg2 ) do
		local f11_local5 = "_" .. f11_arg3 .. f11_local3
		if f11_arg1[f11_local5] then
			f11_arg1:removeSubscription( f11_arg1[f11_local5] )
		end
		f11_arg1[f11_local5] = f11_arg1:subscribeToModel( f11_local4, function ()
			RefreshListFindSelectedXuid( f11_arg0, f11_arg1 )
		end, false )
	end
end
CoD.SocialUtility.AddUpdateDatasourceOnTabUpdate = function ( f13_arg0, f13_arg1 )
	if not f13_arg1._hasTabSubscription then
		local f13_local0 = DataSources.SocialRoot.getModel( f13_arg0 )
		f13_arg1:subscribeToModel( f13_local0.tab, function ()
			f13_arg1:updateDataSource( nil, false )
		end, false )
		f13_arg1._hasTabSubscription = true
	end
end
CoD.SocialUtility.SetSelfInviteTypeToSocialRoot = function ( f15_arg0, f15_arg1 )
	local f15_local0 = DataSources.SocialRoot.getModel( f15_arg1 )
	f15_local0 = f15_local0:create( "inviteType" )
	f15_local0:set( f15_arg0.inviteType or "" )
end
CoD.SocialUtility.PresenceToIcon = function ( f16_arg0 )
	local f16_local0 = tonumber( f16_arg0 )
	if f16_local0 == Enum[0x4BBA402DE649132][0x1CF21FD793411B9] then
		return 0xC4CF58835C4A472
	elseif f16_local0 == Enum[0x4BBA402DE649132][0xA2184EBB293AF2D] then
		return 0xC4CF58835C4A472
	elseif f16_local0 == Enum[0x4BBA402DE649132][0xC14960E60DA36B7] then
		return 0xC4CF58835C4A472
	elseif f16_local0 >= Enum[0x4BBA402DE649132][0x69F9F19327AE3B3] and f16_local0 <= Enum[0x4BBA402DE649132][0x59DAD56E9325476] then
		return 0xC4CF58835C4A472
	elseif f16_local0 >= Enum[0x4BBA402DE649132][0x1DB40BC5D7A26F2] and f16_local0 <= Enum[0x4BBA402DE649132][0xDD9D1D4A601036C] then
		return LuaUtils.GetPresenceImageForEMode( Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
	elseif f16_local0 >= Enum[0x4BBA402DE649132][0x1632587246C118A] and f16_local0 <= Enum[0x4BBA402DE649132][0xEDDB0D016B3F54] then
		return LuaUtils.GetPresenceImageForEMode( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
	elseif f16_local0 >= Enum[0x4BBA402DE649132][0x61619C03C7E6934] and f16_local0 <= Enum[0x4BBA402DE649132][0x886E7F57ED1ED3A] then
		return LuaUtils.GetPresenceImageForEMode( Enum[0x9C0C2196D8313A0][0x60063C67132EB69] )
	elseif f16_local0 >= Enum[0x4BBA402DE649132][0x79F90DEF3681532] and f16_local0 <= Enum[0x4BBA402DE649132][0x35923F6DC7C09AC] then
		return LuaUtils.GetPresenceImageForEMode( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
	elseif f16_local0 >= Enum[0x4BBA402DE649132][0x5EEADE3AFEF0F50] and f16_local0 <= Enum[0x4BBA402DE649132][0xAE1F1FC5A87498E] then
		return LuaUtils.GetPresenceImageForEMode( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
	else
		return 0x7615068F50B3D66
	end
end
CoD.SocialUtility.PrimaryPresenceToLocalizedString = function ( f17_arg0 )
	local f17_local0 = tonumber( f17_arg0 )
	if f17_local0 == Enum[0x5904C991C9847C2][0xDB6E2B269A58541] then
		return 0x72BB745FED1CD7E
	elseif f17_local0 == Enum[0x5904C991C9847C2][0xABAD15ABC044995] then
		return 0x8E783C525F2FA8
	elseif f17_local0 == Enum[0x5904C991C9847C2][0x44579D7D4E7C795] then
		return 0x8E783C525F2FA8
	elseif f17_local0 == Enum[0x5904C991C9847C2][0x5BE7ACD6487188] then
		return 0x8E783C525F2FA8
	else
		return 0x72BB745FED1CD7E
	end
end
CoD.SocialUtility.PrimaryPresenceToLocalizedStringDependingOnPlatform = function ( f18_arg0 )
	if CoD.isPC and CoD.PCUtility.IsBGSEnabled() then
		return CoD.PCBattlenetUtility.BattlenetPresenceToLocalizedString( f18_arg0 )
	else
		return CoD.SocialUtility.PrimaryPresenceToLocalizedString( f18_arg0 )
	end
end
CoD.SocialUtility.PushCurrentSocialTab = function ( f19_arg0 )
	local f19_local0 = Engine[0x8DF2E5447F384B9]()
	f19_arg0._currentTab = f19_local0.socialRoot.tab:get()
end
CoD.SocialUtility.PopCurrentSocialTab = function ( f20_arg0 )
	local f20_local0 = Engine[0x8DF2E5447F384B9]()
	f20_local0.socialRoot.tab:set( f20_arg0._currentTab )
end
CoD.SocialUtility.CheckedInvitees = {}
CoD.SocialUtility.UpdateSelectedCount = function ()
	local f21_local0 = Engine[0x8DF2E5447F384B9]()
	f21_local0.socialRoot.selectedCount:set( LUI.CountFields( CoD.SocialUtility.CheckedInvitees ) )
end
CoD.SocialUtility.ClearCheckedInvitees = function ()
	DataSources.SocialRoot.getModel()
	CoD.SocialUtility.CheckedInvitees = {}
	CoD.SocialUtility.UpdateSelectedCount()
end
CoD.SocialUtility.UpdateCheckedInvitees = function ( f23_arg0 )
	local f23_local0 = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "socialRoot.leaderboardsPlayerListActive" )
	if f23_local0 and f23_local0:get() == true then
		return 
	end
	local f23_local1 = {}
	local f23_local2 = 0
	for f23_local6, f23_local7 in pairs( CoD.SocialUtility.CheckedInvitees ) do
		if CoD.canInviteToGame( f23_arg0, Engine[0xDB51D1F28E70A50]( f23_local6 ) ) then
			f23_local1[f23_local6] = f23_local7
			f23_local2 = f23_local2 + 1
		end
	end
	f23_local3 = Engine[0x8DF2E5447F384B9]()
	f23_local3.socialRoot.selectedCount:set( f23_local2 )
	CoD.SocialUtility.CheckedInvitees = f23_local1
end
CoD.SocialUtility.ToggleInviteCheckbox = function ( f24_arg0, f24_arg1 )
	local f24_local0 = f24_arg1:getModel()
	if not f24_local0 or not f24_local0.checked then
		return 
	end
	local f24_local1 = Engine[0x5065E759595C457]( f24_local0.xuid:get() )
	if f24_local0.checked:get() then
		CoD.SocialUtility.CheckedInvitees[f24_local1] = nil
		f24_local0.checked:set( false )
	else
		CoD.SocialUtility.CheckedInvitees[f24_local1] = f24_local0.gamertag:get()
		f24_local0.checked:set( true )
	end
	CoD.SocialUtility.UpdateSelectedCount()
end
CoD.SocialUtility.CanSendInvites = function ( f25_arg0 )
	return CoD.canSendInvites( f25_arg0 )
end
CoD.SocialUtility.SendInvites = function ( f26_arg0, f26_arg1 )
	local f26_local0 = {
		controller = f26_arg1,
		inviteCount = 0
	}
	if CoD.isPC and not CoD.canSendInvites( f26_arg1 ) then
		LuaUtils.UI_ShowErrorMessageDialog( f26_arg1, 0x1B3BB99254ECCCC, 0x127999393F1681 )
		return 
	elseif f26_arg0.inviteType then
		for f26_local4, f26_local5 in pairs( CoD.SocialUtility.CheckedInvitees ) do
			local f26_local6 = Engine[0xDB51D1F28E70A50]( f26_local4 )
			if f26_local6 ~= LuaDefine.INVALID_XUID_X64 then
				f26_local0.inviteCount = f26_local0.inviteCount + 1
				f26_local0["xuid" .. f26_local0.inviteCount] = f26_local6
				f26_local0["gamertag" .. f26_local0.inviteCount] = f26_local5
			else
				DebugPrint( "^1LUI: ^2Couldn't send invite to " .. f26_local5 .. "." )
			end
		end
		f26_local0.role = Enum[0x10C0A769A29C38F][0xB17C2FE5CC7F0BC]
		f26_local0.inviteType = f26_arg0.inviteType
		f26_local0.event = LuaEnum.CLAN_UI_EVENT.INVITE_TO_GROUP
		Engine[0x87AE7E64BA5AD61]( "OnClanUIEvent", f26_local0 )
		return 
	end
	for f26_local4, f26_local5 in pairs( CoD.SocialUtility.CheckedInvitees ) do
		local f26_local6 = Engine[0xDB51D1F28E70A50]( f26_local4 )
		if f26_local6 == LuaDefine.INVALID_XUID_X64 then
			return 
		elseif CoD.canInviteToGame( f26_arg1, f26_local6 ) then
			if CoD.isPC then
				CoD.invitePlayer( f26_arg1, f26_local6 )
			else
				f26_local0.inviteCount = f26_local0.inviteCount + 1
				f26_local0["xuid" .. f26_local0.inviteCount] = f26_local6
				f26_local0["gamertag" .. f26_local0.inviteCount] = f26_local5
				goto basicblock_20:
			end
		end
		DebugPrint( "^1LUI: ^2cannot send invite." )
	end
	if f26_local0.inviteCount > 0 then
		Engine[0x87AE7E64BA5AD61]( "OnInvite", f26_local0 )
	end
end
CoD.SocialUtility.ToggleAddCheckbox = function ( f27_arg0, f27_arg1 )
	local f27_local0 = f27_arg1:getModel()
	if not f27_local0 or not f27_local0.checked then
		return 
	end
	local f27_local1 = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "socialRoot" )
	local f27_local2 = f27_local1.leaderboardsPlayerListActive:get()
	local f27_local3 = f27_local1.showPlayersList:get()
	local f27_local4 = Engine[0xA798E4552F5E872]( f27_local1, "playersListFull" )
	local f27_local5 = Engine[0x5065E759595C457]( f27_local0.xuid:get() )
	if f27_local0.checked:get() then
		CoD.SocialUtility.CheckedInvitees[f27_local5] = nil
		f27_local0.checked:set( false )
		f27_local4:set( false )
	else
		if f27_local2 == true and f27_local3 == false and f27_local4:get() == true then
			return 
		end
		CoD.SocialUtility.CheckedInvitees[f27_local5] = f27_local0.gamertag:get()
		f27_local0.checked:set( true )
		if f27_local2 == true and f27_local3 == false and Engine[0x3B1FD53757FE607]( f27_arg0 ) - f27_local1.selectedCount:get() + 1 <= 0 then
			f27_local4:set( true )
		end
	end
	CoD.SocialUtility.UpdateSelectedCount()
end
CoD.SocialUtility.AddPlayers = function ( f28_arg0 )
	for f28_local3, f28_local4 in pairs( CoD.SocialUtility.CheckedInvitees ) do
		local f28_local5 = Engine[0xDB51D1F28E70A50]( f28_local3 )
		if f28_local5 ~= LuaDefine.INVALID_XUID_X64 then
			Engine[0xE0E82C19290148C]( f28_arg0, f28_local5 )
		end
	end
	Engine[0x36CB393696695AC]( f28_arg0 )
end
CoD.SocialUtility.RemovePlayers = function ( f29_arg0 )
	local f29_local0 = false
	for f29_local4, f29_local5 in pairs( CoD.SocialUtility.CheckedInvitees ) do
		local f29_local6 = Engine[0xDB51D1F28E70A50]( f29_local4 )
		if f29_local6 ~= LuaDefine.INVALID_XUID_X64 then
			Engine[0xE63AE850C330DF4]( f29_arg0, f29_local6 )
			f29_local0 = true
		end
	end
	if f29_local0 then
		f29_local2 = Engine[0xA798E4552F5E872]( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "socialRoot" ), "playersListFull" )
		f29_local2:set( false )
	end
	Engine[0x36CB393696695AC]( f29_arg0 )
end
CoD.SocialUtility.BootPlayer = function ( f30_arg0, f30_arg1 )
	local f30_local0 = f30_arg1:getModel()
	f30_local0 = f30_local0.xuid:get()
	if Engine[0xDC69CBBED0500B4]( f30_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110] ) and Engine[0x93B19E01B1FD1C7]( f30_arg0 ) ~= f30_local0 then
		Engine[0xE75D3BFE7A2FD4]( f30_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f30_local0, Enum[0x3EB01916743DF12][0x75E935EEE527F8B] )
		if CoD.isPC then
			CoD.PCUtility.ShowPlayerKickGameEvent( f30_local0 )
		end
	end
end
CoD.SocialUtility.GetPartyModel = function ( f31_arg0, f31_arg1, f31_arg2, f31_arg3 )
	local f31_local0 = {
		total = 0,
		available = 0,
		leader = "",
		partySize = 0,
		partyMax = 0
	}
	if CoD.isPC and CoD.PCUtility.IsBGSEnabled() and CoD.PCBattlenetUtility.GetBattlenetPresence( f31_arg0.xuid ) == Enum[0x8811A60F2FF3ADA][0xD7B6D45F00CF380] then
		return f31_local0
	elseif f31_arg1 then
		f31_local0.total = f31_arg1.total
		f31_local0.available = f31_arg1.available
		f31_local0.leader = f31_arg1.leader
		f31_local0.partySize = #f31_arg1.members
		f31_local0.partyMax = f31_arg1.max
		if #f31_arg1.members then
			f31_local0.members = {}
			for f31_local1 = 1, #f31_arg1.members, 1 do
				f31_local0.members[f31_local1] = {}
				f31_local0.members[f31_local1].gamertag = f31_arg1.members[f31_local1].gamertag
				f31_local0.members[f31_local1].leader = f31_arg1.members[f31_local1].leader
				if #f31_arg1.members > 1 and f31_arg1.members[f31_local1].gamertag == f31_arg2 then
					if not f31_arg3[f31_arg1.leader] then
						f31_arg3[f31_arg1.leader] = 1
					else
						f31_arg3[f31_arg1.leader] = f31_arg3[f31_arg1.leader] + 1
					end
					if f31_arg3[f31_arg1.leader] == 1 then
						f31_local0.partyBarType = CoD.SocialUtility.PartyBarType.FIRST
					end
					if f31_arg3[f31_arg1.leader] == #f31_arg1.members then
						f31_local0.partyBarType = CoD.SocialUtility.PartyBarType.LAST
					else
						f31_local0.partyBarType = CoD.SocialUtility.PartyBarType.MIDDLE
					end
				end
			end
		end
	end
	return f31_local0
end
CoD.SocialUtility.AddRankData = function ( f32_arg0 )
	f32_arg0.mpRankIcon = 0x214ECBA8C04D44C
	f32_arg0.zmRankIcon = 0x214ECBA8C04D44C
	f32_arg0.wzRankIcon = 0x214ECBA8C04D44C
	f32_arg0.cpRankIcon = 0x214ECBA8C04D44C
	f32_arg0.arenaRankIcon = 0x214ECBA8C04D44C
	f32_arg0.mpRank = f32_arg0.mpRank or 0
	f32_arg0.zmRank = f32_arg0.zmRank or 0
	f32_arg0.wzRank = f32_arg0.wzRank or 0
	f32_arg0.cpRank = f32_arg0.cpRank or 0
	f32_arg0.arenaRank = f32_arg0.arenaRank or 0
	f32_arg0.wzRankString = tostring( f32_arg0.wzRank )
	f32_arg0.wzPrestige = f32_arg0.wzPrestige or 0
	f32_arg0.mpParagon = false
	if LuaUtils.MultiplayerModeAvailable() then
		if f32_arg0.mpPrestige == CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) and IsGameModeParagonCapable( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) then
			f32_arg0.mpRankIcon = CoD.SocialUtility.GetRankIcons( "mp", true, f32_arg0.mpParagonRank, f32_arg0.mpPrestige )
			f32_arg0.mpRank = Engine[0x801A572E417CC01]( f32_arg0.mpParagonRank, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
			if f32_arg0.mpParagonIconId and f32_arg0.mpParagonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
				f32_arg0.mpRankIcon = Engine[0x142BF2BEA87722E]( f32_arg0.mpParagonIconId, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
			end
		else
			f32_arg0.mpRankIcon = CoD.SocialUtility.GetRankIcons( "mp", true, f32_arg0.mpRank, f32_arg0.mpPrestige )
			f32_arg0.mpRank = Engine[0xE1DE4A6CE92B4FD]( f32_arg0.mpRank, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
		end
		local f32_local0
		if f32_arg0.mpPrestige == nil or f32_arg0.mpPrestige ~= CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) then
			f32_local0 = false
		else
			f32_local0 = true
		end
		f32_arg0.mpParagon = f32_local0
		if f32_arg0.mpParagon and f32_arg0.mpParagonIconId ~= nil and f32_arg0.mpParagonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
			f32_arg0.mpRankIcon = Engine[0x142BF2BEA87722E]( f32_arg0.mpParagonIconId, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
		end
	end
	f32_arg0.zmParagon = false
	if LuaUtils.ZombiesModeAvailable() then
		f32_arg0.zmRankIcon = CoD.SocialUtility.GetRankIcons( "zm", true, f32_arg0.zmRank, f32_arg0.zmPrestige )
		if f32_arg0.zmPrestige == CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] ) then
			if IsGameModeParagonCapable( Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] ) then
				f32_arg0.zmRank = Engine[0x801A572E417CC01]( f32_arg0.zmParagonRank, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
			end
		else
			f32_arg0.zmRank = Engine[0xE1DE4A6CE92B4FD]( f32_arg0.zmRank, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
		end
		local f32_local0
		if f32_arg0.zmPrestige == nil or f32_arg0.zmPrestige ~= CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] ) then
			f32_local0 = false
		else
			f32_local0 = true
		end
		f32_arg0.zmParagon = f32_local0
		if f32_arg0.zmParagon and f32_arg0.zmParagonIconId ~= nil and f32_arg0.zmParagonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
			f32_arg0.zmRankIcon = Engine[0x142BF2BEA87722E]( f32_arg0.zmParagonIconId, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
		end
	end
	f32_arg0.wzParagon = false
	if LuaUtils.WarzoneModeAvailable() then
		f32_arg0.wzRankString = CoD.WZUtility.GetDecoratedStringForRank( f32_arg0.wzRank, f32_arg0.wzParagonRank, f32_arg0.wzPrestige )
		if f32_arg0.wzPrestige == CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] ) and IsGameModeParagonCapable( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] ) then
			f32_arg0.wzRankIcon = CoD.SocialUtility.GetRankIcons( "wz", true, f32_arg0.wzParagonRank, f32_arg0.wzPrestige )
		else
			f32_arg0.wzRankIcon = CoD.SocialUtility.GetRankIcons( "wz", true, f32_arg0.wzRank, f32_arg0.wzPrestige )
		end
		f32_arg0.wzRank = Engine[0xE1DE4A6CE92B4FD]( f32_arg0.wzRank, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
		f32_arg0.wzRankName = CoD.GetRankName( f32_arg0.wzRank, 0, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
		if f32_arg0.wzPrestige ~= nil and f32_arg0.wzPrestige == CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] ) and f32_arg0.wzParagonIconId ~= nil and f32_arg0.wzParagonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
			f32_arg0.wzParagon = true
			f32_arg0.wzRankIcon = Engine[0x142BF2BEA87722E]( f32_arg0.wzParagonIconId, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
		end
	end
	if LuaUtils.ArenaModeAvailable() then
		f32_arg0.arenaRank, f32_arg0.arenaRankIcon = CoD.ArenaLeaguePlayUtility.GetRankAndIcon( f32_arg0.arenaLeaguePlayPoints, f32_arg0.arenaLeaguePlayBestSubdivisionRank, f32_arg0.arenaLeaguePlayFirstSubdivisionRankTotal )
		local f32_local0 = Engine[0x2000A30A9678274]( f32_arg0.xuid )
		f32_arg0.arenaWinStreak = f32_local0.bestFirstSubdivisionRankStreak
		f32_arg0.firstSubdivisionRankStreak = f32_local0.firstSubdivisionRankStreak
		f32_arg0.arenaBestGameWinStreak = f32_local0.bestCurrentEventGameStreak
		local f32_local1, f32_local2 = CoD.ArenaLeaguePlayUtility.GetRubies( f32_arg0.arenaLeaguePlayPoints )
		f32_arg0.rubiesUnlocked = f32_local2
	end
	CoD.SocialUtility.AddRankNamesIfAvailable( f32_arg0 )
	local f32_local0 = CoD.RankUtility.GetCurrentRankMode()
	CoD.RankUtility.UpdateMPRankForClient( f32_arg0.xuid, f32_arg0.mpRank, f32_arg0.mpRankIcon, f32_arg0.mpRankName, f32_arg0.mpParagon, f32_local0 == CoD.RankUtility.RankMode.Multiplayer )
	CoD.RankUtility.UpdateWZRankForClient( f32_arg0.xuid, f32_arg0.wzRankString, f32_arg0.wzRankIcon, f32_arg0.wzRankName, f32_arg0.wzParagon, f32_local0 == CoD.RankUtility.RankMode.Warzone )
	CoD.RankUtility.UpdateZMRankForClient( f32_arg0.xuid, f32_arg0.zmRank, f32_arg0.zmRankIcon, f32_arg0.zmRankName, f32_arg0.zmParagon, f32_local0 == CoD.RankUtility.RankMode.Zombies )
	CoD.RankUtility.UpdateArenaRankForClient( f32_arg0.xuid, f32_arg0.arenaRank, f32_arg0.arenaRankIcon, f32_arg0.arenaRankName, false, f32_arg0.arenaWinStreak, f32_arg0.firstSubdivisionRankStreak, f32_arg0.rubiesUnlocked, CoD.ArenaLeaguePlayUtility.GetClientSkillDivisionIconSmall( f32_arg0.xuid ), f32_local0 == CoD.RankUtility.RankMode.Arena )
	return f32_arg0
end
CoD.SocialUtility.AddRankNamesIfAvailable = function ( f33_arg0 )
	if f33_arg0.mpRank ~= nil and f33_arg0.mpPrestige ~= nil then
		f33_arg0.mpRankName = CoD.GetRankName( f33_arg0.mpRank - 1, f33_arg0.mpPrestige, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
	end
	if f33_arg0.wzRank ~= nil then
		f33_arg0.wzRankName = CoD.GetRankName( f33_arg0.wzRank - 1, 0, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
	end
	if f33_arg0.zmRank ~= nil and f33_arg0.zmPrestige ~= nil then
		f33_arg0.zmRankName = CoD.GetRankName( f33_arg0.zmRank - 1, f33_arg0.zmPrestige, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
	end
	if f33_arg0.arenaRank ~= nil then
		local f33_local0, f33_local1 = CoD.ArenaLeaguePlayUtility.GetBanner( f33_arg0.arenaLeaguePlayPoints, f33_arg0.arenaLeaguePlayBestSubdivisionRank, f33_arg0.arenaLeaguePlayFirstSubdivisionRankTotal )
		f33_arg0.arenaRankName = Engine[0xF9F1239CFD921FE]( f33_local1 )
	end
	return f33_arg0
end
DataSources.SocialRoot = {
	getModel = function ( f34_arg0 )
		local f34_local0 = Engine[0x8DF2E5447F384B9]()
		f34_local0 = f34_local0:create( "socialRoot" )
		if not f34_local0.selectedCount then
			local f34_local1 = f34_local0:create( "selectedCount" )
			f34_local1:set( 0 )
		end
		if not f34_local0.visibleCount then
			local f34_local1 = f34_local0:create( "visibleCount" )
			f34_local1:set( 0 )
		end
		if not f34_local0.ClanInbox then
			local f34_local1 = f34_local0:create( "ClanInbox" )
			if not f34_local1.count then
				local f34_local2 = f34_local1:create( "count", true )
				f34_local2:set( 0 )
			end
		end
		f34_local0:create( "leaderboardsPlayerListActive" )
		f34_local0:create( "playersListFull" )
		f34_local0:create( "showPlayersList" )
		local f34_local1 = f34_local0:create( "clans" )
		local f34_local2 = f34_local1:create( "currentTeamId" )
		f34_local2:set( 1 )
		f34_local2 = f34_local1:create( "currentSquadId" )
		f34_local2:set( 1 )
		f34_local0:create( "teams" )
		f34_local0:create( "squads" )
		return f34_local0
	end
}
DataSources.SocialPlayerInfo = {
	getModel = function ( f35_arg0 )
		local f35_local0 = Engine[0x4DF5CFBC1771947]( f35_arg0 )
		local f35_local1 = f35_local0:create( "socialPlayerInfo" )
		local f35_local2 = f35_local1:create( "identityBadge" )
		local f35_local3 = f35_local0:create( "Social.selectedFriendXUID" )
		local f35_local4 = f35_local3:get()
		local f35_local5 = f35_local0:create( "Social.selectedFriendGamertag" )
		local f35_local6 = f35_local5:get()
		if f35_local4 ~= nil then
			local f35_local7 = {
				Rank = 0,
				ParagonRank = 0,
				RankIcon = 0x7615068F50B3D66,
				Prestige = 0,
				Played = false,
				Paragon = false
			}
			local f35_local8 = Engine[0xDC3B811A6]( f35_arg0, f35_local4 )
			if f35_local8 ~= nil then
				local f35_local9 = LUI.ShallowCopy( f35_local7 )
				local f35_local10 = LUI.ShallowCopy( f35_local7 )
				local f35_local11 = LUI.ShallowCopy( f35_local7 )
				local f35_local12 = LUI.ShallowCopy( f35_local7 )
				local f35_local13 = LUI.ShallowCopy( f35_local7 )
				if LuaUtils.MultiplayerModeAvailable() then
					f35_local9.Played = true
					f35_local9.Rank = Engine[0xE1DE4A6CE92B4FD]( f35_local8.info.mp.rank, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
					f35_local9.RankName = CoD.GetRankName( f35_local8.info.mp.rank, f35_local8.info.mp.prestige, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
					f35_local9.RankIcon = CoD.SocialUtility.GetRankIcons( "mp", f35_local9.Played, f35_local8.info.mp.rank, f35_local8.info.mp.prestige )
					f35_local9.Prestige = f35_local8.info.mp.prestige
					if f35_local9.Prestige == CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) and IsGameModeParagonCapable( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) then
						f35_local9.Paragon = true
						f35_local9.Rank = Engine[0x801A572E417CC01]( f35_local8.info.mp.rank, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
						if f35_local8.info.mp.paragonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
							f35_local9.RankIcon = Engine[0x142BF2BEA87722E]( f35_local8.info.mp.paragonIconId, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
						end
					end
				end
				if LuaUtils.ZombiesModeAvailable() then
					f35_local10.Played = true
					f35_local10.Rank = Engine[0xE1DE4A6CE92B4FD]( f35_local8.info.zm.rank, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
					f35_local10.RankName = CoD.GetRankName( f35_local8.info.zm.rank, f35_local8.info.zm.prestige, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
					f35_local10.RankIcon = CoD.SocialUtility.GetRankIcons( "zm", f35_local10.Played, f35_local8.info.zm.rank, f35_local8.info.zm.prestige )
					f35_local10.Prestige = f35_local8.info.zm.prestige
					if IsGameModeParagonCapable( Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] ) and f35_local8.info.zm.prestige == CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] ) then
						f35_local10.Paragon = true
						f35_local10.Rank = Engine[0x801A572E417CC01]( f35_local8.info.zm.rank, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
						if f35_local8.info.zm.paragonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
							f35_local10.RankIcon = Engine[0x142BF2BEA87722E]( f35_local8.info.zm.paragonIconId, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
						end
					end
				end
				if LuaUtils.WarzoneModeAvailable() then
					f35_local11.Played = true
					f35_local11.ParagonRank = f35_local8.info.wz.paragonRank
					f35_local11.Rank = CoD.WZUtility.GetDecoratedStringForRank( f35_local8.info.wz.rank, f35_local8.info.wz.paragonRank, f35_local8.info.wz.prestige )
					f35_local11.RankName = CoD.GetRankName( f35_local8.info.wz.rank, 0, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
					f35_local11.RankIcon = CoD.SocialUtility.GetRankIcons( "wz", f35_local11.Played, f35_local8.info.wz.rank, f35_local8.info.wz.prestige )
					f35_local11.Prestige = f35_local8.info.wz.prestige
					if IsGameModeParagonCapable( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] ) and f35_local8.info.wz.prestige == CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] ) then
						f35_local11.Paragon = true
						if f35_local8.info.wz.paragonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
							f35_local11.RankIcon = Engine[0x142BF2BEA87722E]( f35_local8.info.wz.paragonIconId, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
						end
					end
				end
				if LuaUtils.ArenaModeAvailable() then
					local f35_local14 = Engine[0x2000A30A9678274]( f35_local4 )
					f35_local13.Played = true
					f35_local13.Rank, f35_local13.RankIcon = CoD.ArenaLeaguePlayUtility.GetRankAndIcon( f35_local14.points, f35_local14.bestSubdivisionRank, f35_local14.firstSubdivisionRankTotal )
					local f35_local15, f35_local16 = CoD.ArenaLeaguePlayUtility.GetBanner( f35_local14.points, f35_local14.bestSubdivisionRank, f35_local14.firstSubdivisionRankTotal )
					f35_local13.RankName = Engine[0xF9F1239CFD921FE]( f35_local16 )
					f35_local13.Prestige = 0
					f35_local13.bestFirstSubdivisionRankStreak = f35_local8.info.arena.bestFirstSubdivisionRankStreak
					f35_local13.firstSubdivisionRankStreak = f35_local8.info.arena.firstSubdivisionRankStreak
					f35_local13.arenaBestGameWinStreak = f35_local8.info.arena.bestCurrentEventGameStreak
					local f35_local17, f35_local18 = CoD.ArenaLeaguePlayUtility.GetRubies( f35_local14.points )
					f35_local13.rubiesUnlocked = f35_local18
				end
				if f35_local8.info.gamertag == "" then
					f35_local8.info.gamertag = f35_local6
				end
				local f35_local14 = f35_local2:create( "xuid" )
				f35_local14:set( f35_local8.info.xuid )
				f35_local14 = f35_local2:create( "gamertag" )
				f35_local14:set( f35_local8.info.gamertag )
				f35_local14 = f35_local2:create( "clantag" )
				f35_local14:set( f35_local8.info.clantag )
				f35_local14 = CoD.RankUtility.GetCurrentRankMode()
				CoD.RankUtility.UpdateMPRankForClient( f35_local4, f35_local9.Rank, f35_local9.RankIcon, f35_local9.RankName, f35_local9.Paragon, f35_local14 == CoD.RankUtility.RankMode.Multiplayer )
				CoD.RankUtility.UpdateWZRankForClient( f35_local4, f35_local11.Rank, f35_local11.RankIcon, f35_local11.RankName, f35_local11.Paragon, f35_local14 == CoD.RankUtility.RankMode.Warzone )
				CoD.RankUtility.UpdateZMRankForClient( f35_local4, f35_local10.Rank, f35_local10.RankIcon, f35_local10.RankName, f35_local10.Paragon, f35_local14 == CoD.RankUtility.RankMode.Zombies )
				CoD.RankUtility.UpdateArenaRankForClient( f35_local4, f35_local13.Rank, f35_local13.RankIcon, f35_local13.RankName, false, f35_local13.bestFirstSubdivisionRankStreak, f35_local13.firstSubdivisionRankStreak, f35_local13.rubiesUnlocked, CoD.ArenaLeaguePlayUtility.GetClientSkillDivisionIconSmall( f35_local4 ), f35_local14 == CoD.RankUtility.RankMode.Arena )
				local f35_local16 = f35_local1:create( "rankInfo" )
				f35_local16:set( CoD.RankUtility.GetClientRankInfoModel( f35_local4 ) )
				f35_local16 = f35_local1:create( "rubiesUnlocked" )
				f35_local16:set( f35_local13.rubiesUnlocked )
				f35_local16 = f35_local1:create( "emblemBacking" )
				f35_local16:set( f35_local8.info.emblemBacking )
				f35_local16 = f35_local1:create( "presence" )
				f35_local16:set( f35_local8.info.presence )
				f35_local16 = f35_local1:create( "joinable" )
				f35_local16:set( f35_local8.info.joinable )
				f35_local16 = f35_local1:create( "inGameLobby" )
				f35_local16:set( f35_local8.info.inGameLobby )
				f35_local16 = f35_local1:create( "inPrivateLobby" )
				f35_local16:set( f35_local8.info.inPrivateLobby )
				f35_local16 = f35_local1:create( "isSelf" )
				f35_local16:set( f35_local8.info.isSelf )
				f35_local16 = f35_local1:create( "isLocal" )
				f35_local16:set( f35_local8.info.isLocal )
				f35_local16 = f35_local1:create( "isMemberLeader" )
				f35_local16:set( f35_local8.info.isMemberLeader or 0 )
				f35_local16 = f35_local1:create( "presence" )
				f35_local16:set( f35_local8.info.presence )
				f35_local16 = f35_local1:create( "presenceString" )
				f35_local16:set( GetPresenceString( f35_local8.info ) )
				f35_local16 = f35_local1:create( "activity" )
				f35_local16:set( f35_local8.info.activity )
				f35_local16 = f35_local1:create( "activityString" )
				f35_local16:set( GetPresenceActivityString( f35_local8.info ) )
				f35_local16 = f35_local1:create( "context" )
				f35_local16:set( f35_local8.info.context )
				f35_local16 = f35_local1:create( "contextString" )
				f35_local16:set( GetPresenceContextString( f35_local8.info ) )
				f35_local16 = f35_local1:create( "gametype" )
				f35_local16:set( f35_local8.info.gametype )
				f35_local16 = f35_local1:create( "mapId" )
				f35_local16:set( f35_local8.info.mapid )
				f35_local16 = f35_local1:create( "modeparam" )
				f35_local16:set( f35_local8.info.modeparam )
				f35_local16 = f35_local1:create( "difficulty" )
				f35_local16:set( f35_local8.info.difficulty )
				f35_local16 = f35_local1:create( "playlist" )
				f35_local16:set( f35_local8.info.playlist )
				f35_local16 = f35_local1:create( "isFriend" )
				f35_local16:set( f35_local8.info.isFriend )
				f35_local16 = f35_local1:create( "trial" )
				f35_local16:set( f35_local8.info.trial )
				f35_local16 = f35_local1:create( "blackopsPass" )
				f35_local16:set( f35_local8.info.blackopsPass )
				f35_local16 = f35_local1:create( "lobbyDLCBits" )
				f35_local16:set( f35_local8.info.lobbyDLCBits )
			end
		end
		return f35_local1
	end
}
CoD.SocialUtility.GetFriendsButtonOptions = function ( f36_arg0, f36_arg1, f36_arg2, f36_arg3, f36_arg4, f36_arg5, f36_arg6 )
	local f36_local0 = {}
	local f36_local1 = Engine[0x4DF5CFBC1771947]( f36_arg0 )
	local f36_local2 = f36_arg2 == Engine[0x93B19E01B1FD1C7]( f36_arg0 )
	if f36_arg2 == nil then
		return f36_local0
	end
	local f36_local3 = Engine[0x5CB8E6B7FBBFFD5]( f36_arg2 )
	local f36_local4 = function ()
		if 0 < #f36_local0 then
			f36_local0[#f36_local0].lastInGroup = true
		end
	end
	
	local f36_local5 = Engine[0xDC3B811A6]( f36_arg0, f36_arg2 )
	local f36_local6 = Engine[0x86E64DD1C270046]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], f36_arg2 )
	local f36_local7 = Engine[0x86E64DD1C270046]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f36_arg2 )
	if f36_local2 == false and IsInFileshare( f36_arg0 ) == false then
		if Engine[0x86E64DD1C270046]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], f36_arg2 ) then
			if Engine[0xDC69CBBED0500B4]( f36_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110] ) then
				if ShouldShowPromotePlayer( f36_arg0 ) and not f36_local3 then
					table.insert( f36_local0, {
						text = 0x431AAED2A65A9AC,
						id = "promoteToLeader",
						disabled = CoD.DirectorUtility.DisableForCurrentMilestone(),
						action = PromoteToLeader,
						params = {
							controller = f36_arg0,
							xuid = f36_arg2
						}
					} )
				end
				if Engine[0x41DC2CF4139D7]( f36_arg2 ) == false then
					table.insert( f36_local0, {
						text = 0xFEF051FC818F01B,
						id = "removeFromParty",
						disabled = false,
						action = DisconnectClient,
						params = {
							controller = f36_arg0,
							xuid = f36_arg2
						}
					} )
				end
			end
		else
			if f36_arg4 == true then
				local f36_local8 = Engine[0x3176B986956D1B3]( f36_arg0, f36_arg2 )
				if f36_local5.info.joinable == Enum[0xCA6AE10CC343A4F][0x1FD2A499E7CD0E4] or f36_local8 and f36_local5.info.joinable == Enum[0xCA6AE10CC343A4F][0xBFB4278A2E811D] then
					local f36_local9 = true
					if f36_local5.info.mapid then
						local f36_local10 = f36_local5.info.mapid
						if f36_local10 then
							f36_local10 = CoD.BaseUtility.GetMapDataFromMapID( f36_local5.info.mapid )
						end
						local f36_local11 = f36_local10 and f36_local10.session_mode
						if f36_local11 and f36_local11 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
							local f36_local12 = Engine[0x3C915544ECCD34B]( f36_arg0 )
						end
						f36_local9 = f36_local12 or CoD.MapUtility.LobbyHasMap( f36_local5.info.mapid )
					end
					if f36_local9 then
						if f36_local8 then
							table.insert( f36_local0, {
								text = 0xE49D0B0BAC3E752,
								id = "joinGame",
								disabled = false,
								action = SocialJoin,
								params = {
									controller = f36_arg0,
									xuid = f36_arg2,
									joinType = Enum[0xC018C5F55467EB1][0xC21E48130C4B82B],
									goBack = true
								}
							} )
						else
							table.insert( f36_local0, {
								text = 0xE49D0B0BAC3E752,
								id = "joinGame",
								disabled = false,
								action = SocialJoin,
								params = {
									controller = f36_arg0,
									xuid = f36_arg2,
									joinType = Enum[0xC018C5F55467EB1][0x4F9C7D45FC8CB0],
									goBack = true
								}
							} )
						end
					end
				end
			end
			if (not CoD.isPC or f36_arg4) and CoD.canInviteToGame( f36_arg0, f36_arg2, true ) and not f36_local6 and not f36_local7 then
				table.insert( f36_local0, {
					text = 0x2EA47C1D2988981,
					id = "inviteToParty",
					disabled = false,
					action = LobbyInviteFriendGoBack,
					params = {
						controller = f36_arg0,
						xuid = f36_arg2,
						gamertag = f36_arg3
					}
				} )
			end
		end
	end
	f36_local4()
	if f36_local5.info.hasEverPlayed == true and not f36_local3 and (not (not f36_arg1 or not f36_arg1.menu or f36_arg1.menu.disableInspection or IsInGame()) or IsPC() and not IsInGame() and f36_arg5 and f36_arg6 ~= "SinglePlayerInspection" and f36_arg6 ~= "LobbyInspection") then
		table.insert( f36_local0, {
			text = 0xFF0DBCF80106E7B,
			id = "inspectPlayer",
			disabled = false,
			action = function ( f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4 )
				SetSelectedFriendXUID( f38_arg0, f38_arg1, f38_arg2 )
				OpenOverlay( f38_arg4, "SinglePlayerInspection", f38_arg2 )
			end,
			params = nil
		} )
	end
	if not IsPC() and not f36_local3 then
		table.insert( f36_local0, {
			text = 0x250EFC225EDF7D0,
			id = "platformProfile",
			disabled = false,
			action = OpenPlatformProfile,
			params = {
				controller = f36_arg0,
				gamertag = f36_arg3,
				xuid = f36_arg2
			}
		} )
	end
	f36_local4()
	if f36_local2 == false and not f36_local3 then
		local f36_local8 = Engine[0xC6A35140B35CF47]( f36_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f36_arg2 )
		if Engine[0x3E68E350BEFE50D]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] ) then
			f36_local8 = Engine[0xC6A35140B35CF47]( f36_arg0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f36_arg2 )
		end
		if IsGroupsEnabled( f36_arg0 ) then
			
		else
			
		end
		if not Engine[0x3176B986956D1B3]( f36_arg0, f36_arg2 ) then
			if IsDurango() then
				table.insert( f36_local0, {
					text = 0xAE669C3D0CBB316,
					id = "sendFriendRequest",
					disabled = false,
					action = OpenPlatformFriendRequest,
					params = {
						controller = f36_arg0,
						gamertag = f36_arg3,
						xuid = f36_arg2
					}
				} )
			elseif not CoD.isPC or not CoD.PCBattlenetUtility.HasSentFriendInvite( f36_arg3 ) then
				table.insert( f36_local0, {
					text = 0x71470E8042D087C,
					id = "sendFriendRequest",
					disabled = false,
					action = OpenPlatformFriendRequest,
					params = {
						controller = f36_arg0,
						gamertag = f36_arg3,
						xuid = f36_arg2
					}
				} )
			end
		end
		f36_local4()
		local f36_local9 = Engine[0x3176B986956D1B3]( f36_arg0, f36_arg2 )
		if not f36_local9 or f36_local5.info.hasEverBootedGame and f36_local9 then
			table.insert( f36_local0, {
				text = 0x74834ABE9827A3,
				id = "reportPlayer",
				disabled = false,
				action = ShowReportPlayerDialog,
				params = {
					controller = f36_arg0,
					gamertag = f36_arg3,
					xuid = f36_arg2
				}
			} )
		end
		if f36_local6 or f36_local7 then
			if f36_local8 then
				table.insert( f36_local0, {
					text = 0x39685D9366015DB,
					id = "unmutePlayer",
					disabled = false,
					action = UnMutePlayer,
					params = {
						controller = f36_arg0,
						xuid = f36_arg2
					}
				} )
			else
				table.insert( f36_local0, {
					text = 0x12FAB6BE7D9F2EA,
					id = "mutePlayer",
					disabled = false,
					action = MutePlayer,
					params = {
						controller = f36_arg0,
						xuid = f36_arg2
					}
				} )
			end
		end
	end
	CoD.ClanUtility.AddMemberActions( f36_arg0, f36_arg1, f36_local0, {
		selectedXuid = f36_arg2
	} )
	return f36_local0
end
DataSources.SocialPlayerDetailsButtons = ListHelper_SetupDataSource( "SocialPlayerDetailsButtons", function ( f39_arg0, f39_arg1 )
	local f39_local0 = Engine[0x4DF5CFBC1771947]( f39_arg0 )
	local f39_local1 = f39_local0:create( "Social.selectedFriendXUID" )
	f39_local1 = f39_local1:get()
	local f39_local2 = f39_local0:create( "Social.selectedFriendGamertag" )
	f39_local2 = f39_local2:get()
	local f39_local3 = Engine[0xA798E4552F5E872]( f39_local0, "Social.selectedFriendInTitle" )
	f39_local3 = f39_local3:get()
	local f39_local4 = {}
	f39_local4 = CoD.SocialUtility.GetFriendsButtonOptions( f39_arg0, f39_arg1, f39_local1, f39_local2, f39_local3, false, "" )
	local f39_local5 = {}
	if not CoD.isPC then
		for f39_local9, f39_local10 in ipairs( f39_local4 ) do
			if not f39_local10.disabled or not CoD.DirectorUtility.DisableForCurrentMilestone() then
				table.insert( f39_local5, {
					models = {
						displayText = f39_local10.text,
						customId = f39_local10.customId
					},
					properties = {
						disabled = f39_local10.disabled,
						action = f39_local10.action,
						actionParam = f39_local10.params,
						isLastButtonInGroup = f39_local10.lastInGroup
					}
				} )
			end
		end
	end
	if CoD.isPC then
		local f39_local6 = CoD.PCWidgetUtility.PlayerContextualMenuOptionsIDOrder
		if not InFrontend() then
			f39_local6 = CoD.PCWidgetUtility.InGamePlayerContextualMenuOptionsIDOrder
		end
		for f39_local10, f39_local16 in ipairs( f39_local6 ) do
			for f39_local11, f39_local12 in ipairs( f39_local4 ) do
				if f39_local12.id == f39_local16 and (not f39_local12.disabled or not CoD.DirectorUtility.DisableForCurrentMilestone()) then
					table.insert( f39_local5, {
						models = {
							displayText = f39_local12.text,
							customId = f39_local12.customId
						},
						properties = {
							disabled = f39_local12.disabled,
							action = f39_local12.action,
							actionParam = f39_local12.params,
							isLastButtonInGroup = f39_local12.lastInGroup
						}
					} )
				end
			end
			for f39_local12, f39_local15 in pairs( CoD.PCWidgetUtility.PlayerContextualMenuExtraOptionsData ) do
				if f39_local15.id == f39_local16 and f39_local15.visibilityFct( f39_arg0, f39_arg1.menu, f39_local1 ) then
					table.insert( f39_local5, {
						models = {
							displayText = f39_local15.name
						},
						properties = {
							disabled = false,
							action = f39_local15.clickFct
						}
					} )
				end
			end
		end
	end
	return f39_local5
end, nil, nil, function ( f40_arg0, f40_arg1, f40_arg2 )
	
end, function ( f41_arg0, f41_arg1, f41_arg2 )
	if f41_arg0.SocialPlayerDetailsButtons[f41_arg1].properties.isLastButtonInGroup then
		return 16
	else
		return 0
	end
end )
DataSources.SocialTabs = ListHelper_SetupDataSource( "SocialTabs", function ( f42_arg0 )
	local f42_local0 = Engine[0x8DF2E5447F384B9]()
	f42_local0 = f42_local0:create( "socialRoot" )
	local f42_local1 = f42_local0:create( "tab" )
	local f42_local2 = nil
	if CoD.isPC then
		f42_local2 = "party"
	else
		f42_local2 = f42_local1:get() or "friends"
	end
	local f42_local3 = {}
	if Engine[0x7B48C1ABFF0F764]() == false then
		table.insert( f42_local3, {
			models = {
				tabName = Engine[0xF9F1239CFD921FE]( 0x7AE9A3B9A819A37 ),
				tabWidget = "CoD.Social_Party",
				showInQuickInvite = false
			},
			properties = {
				tabId = "party",
				selectIndex = false,
				disabled = not Dvar[0xE52CB4B7B32961A]:get()
			}
		} )
	end
	table.insert( f42_local3, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0xD851B47994EA820 ),
			tabWidget = "CoD.Social_Friends",
			showInQuickInvite = true
		},
		properties = {
			tabId = "friends",
			selectIndex = false
		}
	} )
	if Dvar.live_clansEnabled:get() == true then
		table.insert( f42_local3, {
			models = {
				tabName = LocalizeToUpperString( 0x1FE0279942E5652 ),
				tabWidget = "CoD.Social_Clan",
				showInQuickInvite = false
			},
			properties = {
				tabId = "clan",
				selectIndex = false,
				disabled = IsInGame()
			}
		} )
	end
	if IsGroupsEnabled( f42_arg0 ) then
		table.insert( f42_local3, {
			models = {
				tabName = Engine[0xF9F1239CFD921FE]( 0x170F22DBA800B37 ),
				tabWidget = "CoD.Social_Groups",
				showInQuickInvite = true
			},
			properties = {
				tabId = "groups",
				selectIndex = false,
				disabled = true
			}
		} )
	end
	table.insert( f42_local3, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0xBBFF142690C3D4D ),
			tabWidget = "CoD.Social_RecentPlayers",
			showInQuickInvite = true
		},
		properties = {
			tabId = "recent",
			selectIndex = false,
			disabled = false
		}
	} )
	if Dvar.live_clansEnabled:get() == true then
		table.insert( f42_local3, {
			models = {
				tabName = LocalizeToUpperString( 0x91511506A6D8036 ),
				tabWidget = "CoD.Social_Inbox",
				showInQuickInvite = false
			},
			properties = {
				tabId = "inbox",
				selectIndex = false,
				disabled = IsInGame()
			}
		} )
	end
	for f42_local4 = 1, #f42_local3, 1 do
		if f42_local3[f42_local4].properties ~= nil then
			if f42_local3[f42_local4].properties.tabId == f42_local2 then
				f42_local3[f42_local4].properties.selectIndex = true
			else
				f42_local3[f42_local4].properties.selectIndex = false
			end
		end
	end
	return f42_local3
end, true )
DataSources.PlayersListTabs = ListHelper_SetupDataSource( "PlayersListTabs", function ( f43_arg0 )
	local f43_local0 = Engine[0x8DF2E5447F384B9]()
	f43_local0 = f43_local0:create( "socialRoot" )
	local f43_local1 = f43_local0:create( "tab" )
	local f43_local2 = f43_local1:get()
	if f43_local2 == nil then
		f43_local2 = "friends"
	end
	local f43_local3 = {}
	table.insert( f43_local3, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0xD851B47994EA820 ),
			tabWidget = "CoD.Social_Friends",
			showInQuickInvite = false
		},
		properties = {
			tabId = "friendsPlayersList",
			selectIndex = false
		}
	} )
	if IsGroupsEnabled( f43_arg0 ) then
		table.insert( f43_local3, {
			models = {
				tabName = Engine[0xF9F1239CFD921FE]( 0x170F22DBA800B37 ),
				tabWidget = "CoD.Social_Groups",
				showInQuickInvite = false
			},
			properties = {
				tabId = "groups",
				selectIndex = false,
				disabled = true
			}
		} )
	end
	table.insert( f43_local3, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0xBBFF142690C3D4D ),
			tabWidget = "CoD.Social_RecentPlayers",
			showInQuickInvite = false
		},
		properties = {
			tabId = "recentPlayersList",
			selectIndex = false,
			disabled = false
		}
	} )
	for f43_local4 = 1, #f43_local3, 1 do
		if f43_local3[f43_local4].properties ~= nil then
			if f43_local3[f43_local4].properties.tabId == f43_local2 then
				f43_local3[f43_local4].properties.selectIndex = true
			else
				f43_local3[f43_local4].properties.selectIndex = false
			end
		end
	end
	return f43_local3
end, true )
CoD.SocialUtility.PartyBarType = LuaEnum.createEnum( "FIRST", "MIDDLE", "LAST", "NONE" )
DataSources.SocialOnlinePlayersList = ListHelper_SetupDataSource( "SocialOnlinePlayersList", function ( f44_arg0 )
	local f44_local0 = {}
	local f44_local1 = Enum[0xD75FB136CB17239][0x14916BC7C01AE13] | Enum[0xD75FB136CB17239][0x5BC71242ADF26CC]
	local f44_local2 = {}
	local f44_local3 = false
	local f44_local4 = false
	local f44_local5 = Engine[0x8DF2E5447F384B9]()
	f44_local5 = f44_local5:create( "socialRoot" )
	local f44_local6 = f44_local5.tab:get()
	if f44_local6 == "friends" then
		f44_local3 = false
		f44_local4 = false
		f44_local2 = Engine[0x5BC6F44500DD93D]( f44_arg0, 0, 7, f44_local1 )
	elseif f44_local6 == "recent" then
		f44_local3 = true
		f44_local4 = true
		f44_local2 = CoD.SocialUtility.GetRecentPlayersList( f44_arg0, 0, 7, f44_local1 )
	elseif f44_local6 == "party" then
		f44_local3 = false
		f44_local4 = false
		local f44_local7 = CoD.SocialUtility.GetPartyPlayersList()
		local f44_local8 = Engine[0xDBBEBBD8453B447]( Engine[0xA5B9C0111291A8B]() )
		for f44_local18, f44_local19 in ipairs( f44_local7 ) do
			f44_local2[f44_local18] = {}
			local f44_local20 = f44_local2[f44_local18]
			f44_local20.xuid = f44_local19.xuid
			f44_local20.gamertag = f44_local19.gamertag
			f44_local20.clantag = f44_local19.clantag
			f44_local20.isLocal = f44_local19.isLocal
			f44_local20.isLeader = f44_local19.isLeader
			f44_local20.presence = f44_local8.presence
			f44_local20.activity = f44_local8.activity
			f44_local20.context = f44_local8.context
			f44_local20.joinable = Enum[0xCA6AE10CC343A4F][0x8FCE6A0B08CD559]
			f44_local20.gametype = f44_local8.gametype
			f44_local20.mapid = f44_local8.mapid
			f44_local20.modeparam = f44_local8.modeparam
			f44_local20.friend = 1
			f44_local20.trial = f44_local19.trial
			f44_local20.blackopsPass = f44_local8.blackopsPass
			f44_local20.titlePresence = ""
			f44_local20.lobbyDLCBits = f44_local19.lobbyDLCBits
			f44_local20.mpParagon = false
			if f44_local19.mpRank ~= nil then
				if CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) <= f44_local19.mpPrestige then
					f44_local20.mpRank = Engine[0x801A572E417CC01]( f44_local19.mpRank, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
					f44_local20.mpParagon = true
				else
					f44_local20.mpRank = Engine[0xE1DE4A6CE92B4FD]( f44_local19.mpRank, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
				end
				f44_local20.mpRankName = CoD.GetRankName( f44_local19.mpRank, f44_local19.mpPrestige, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
				f44_local20.mpRankIcon = IsMultiplayer() and f44_local19.rankIcon or f44_local19.mpRankIcon
			end
			f44_local20.wzParagon = false
			if f44_local19.wzRank ~= nil then
				f44_local20.wzRankString = CoD.WZUtility.GetDecoratedStringForRank( f44_local19.wzRank, f44_local19.wzParagonRank, f44_local19.wzPrestige )
				f44_local20.wzPrestige = f44_local19.wzPrestige
				f44_local20.wzRank = f44_local19.wzRank
				f44_local20.wzRankName = CoD.GetRankName( f44_local19.wzRank, 0, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
				f44_local20.wzRankIcon = f44_local19.wzRankIcon
				f44_local20.wzParagonRank = f44_local19.wzParagonRank
				local f44_local12 = IsGameModeParagonCapable( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] )
				if f44_local12 then
					f44_local12 = Engine[0x1C875FDC0D5417E]( Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] ) <= f44_local19.wzPrestige
				end
				f44_local20.wzParagon = f44_local12
			end
			f44_local20.zmParagon = false
			if f44_local19.zmRank ~= nil then
				if CoD.PrestigeUtility.GetPrestigeCap( Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] ) <= f44_local19.zmPrestige then
					f44_local20.zmParagon = true
					f44_local20.zmRank = Engine[0x801A572E417CC01]( f44_local19.zmRank, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
				else
					f44_local20.zmRank = Engine[0xE1DE4A6CE92B4FD]( f44_local19.zmRank, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
				end
				f44_local20.zmRankName = CoD.GetRankName( f44_local19.zmRank, f44_local19.zmPrestige, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )
				f44_local20.zmRankIcon = IsZombies() and f44_local19.rankIcon or f44_local19.zmRankIcon
			end
			if f44_local19.arenaLeaguePlayPoints ~= nil then
				local f44_local12, f44_local13 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon( f44_local19.arenaLeaguePlayPoints, f44_local19.arenaLeaguePlayBestSubdivisionRank, f44_local19.arenaLeaguePlayFirstSubdivisionRankTotal )
				local f44_local14, f44_local15 = CoD.ArenaLeaguePlayUtility.GetBanner( f44_local19.arenaLeaguePlayPoints, f44_local19.arenaLeaguePlayBestSubdivisionRank, f44_local19.arenaLeaguePlayFirstSubdivisionRankTotal )
				f44_local20.arenaRank = f44_local12
				f44_local20.arenaRankIcon = f44_local13
				f44_local20.arenaRankName = Engine[0xF9F1239CFD921FE]( f44_local15 )
				local f44_local16, f44_local17 = CoD.ArenaLeaguePlayUtility.GetRubies( f44_local19.arenaLeaguePlayPoints )
				f44_local20.rubiesUnlocked = f44_local17
				f44_local20.arenaLeaguePlayPoints = f44_local19.arenaLeaguePlayPoints
			end
		end
	else
		f44_local2 = Engine[0x5BC6F44500DD93D]( f44_arg0, 0, 7, f44_local1 )
	end
	for f44_local7 = 1, #f44_local2, 1 do
		local f44_local11 = f44_local2[f44_local7]
		local f44_local18 = ""
		local f44_local19 = string.format( "%s %s", f44_local18, f44_local11.gamertag )
		local f44_local20 = ""
		if f44_local4 then
			f44_local20 = f44_local11.titlePresence
		end
		local f44_local12 = "0"
		if f44_local11.isLocal == 1 then
			f44_local12 = "1"
		end
		local f44_local13 = CoD.RankUtility.GetCurrentRankMode()
		local f44_local14 = CoD.RankUtility.UpdateMPRankForClient
		local f44_local15 = f44_local11.xuid
		local f44_local16 = f44_local11.mpRank
		if not f44_local16 then
			f44_local16 = 0
		end
		local f44_local17 = f44_local11.mpRankIcon
		if not f44_local17 then
			f44_local17 = 0x7615068F50B3D66
		end
		local f44_local21 = f44_local11.mpRankName
		if not f44_local21 then
			f44_local21 = ""
		end
		f44_local14( f44_local15, f44_local16, f44_local17, f44_local21, f44_local11.mpParagon, f44_local13 == CoD.RankUtility.RankMode.Multiplayer )
		f44_local14 = CoD.RankUtility.UpdateWZRankForClient
		f44_local15 = f44_local11.xuid
		f44_local16 = f44_local11.wzRankString
		f44_local17 = f44_local11.wzRankIcon
		if not f44_local17 then
			f44_local17 = 0x7615068F50B3D66
		end
		f44_local21 = f44_local11.wzRankName
		if not f44_local21 then
			f44_local21 = ""
		end
		f44_local14( f44_local15, f44_local16, f44_local17, f44_local21, f44_local11.wzParagon, f44_local13 == CoD.RankUtility.RankMode.Warzone )
		f44_local14 = CoD.RankUtility.UpdateZMRankForClient
		f44_local15 = f44_local11.xuid
		f44_local16 = f44_local11.zmRank
		if not f44_local16 then
			f44_local16 = 0
		end
		f44_local17 = f44_local11.zmRankIcon
		if not f44_local17 then
			f44_local17 = 0x7615068F50B3D66
		end
		f44_local21 = f44_local11.zmRankName
		if not f44_local21 then
			f44_local21 = ""
		end
		f44_local14( f44_local15, f44_local16, f44_local17, f44_local21, f44_local11.zmParagon, f44_local13 == CoD.RankUtility.RankMode.Zombies )
		f44_local14 = CoD.ArenaLeaguePlayUtility.GetClientSkillDivisionIconSmall( f44_local11.xuid )
		f44_local15 = Engine[0x2000A30A9678274]( f44_local11.xuid )
		f44_local11.arenaWinStreak = f44_local15.bestFirstSubdivisionRankStreak
		f44_local11.firstSubdivisionRankStreak = f44_local15.firstSubdivisionRankStreak
		f44_local11.arenaBestGameWinStreak = f44_local15.bestCurrentEventGameStreak
		f44_local16 = CoD.RankUtility.UpdateArenaRankForClient
		f44_local17 = f44_local11.xuid
		f44_local21 = f44_local11.arenaRank
		if not f44_local21 then
			f44_local21 = 0
		end
		local f44_local22 = f44_local11.arenaRankIcon
		if not f44_local22 then
			f44_local22 = 0x7615068F50B3D66
		end
		local f44_local23 = f44_local11.arenaRankName
		if not f44_local23 then
			f44_local23 = ""
		end
		f44_local16( f44_local17, f44_local21, f44_local22, f44_local23, false, f44_local11.arenaWinStreak, f44_local11.firstSubdivisionRankStreak, f44_local11.arenaLeaguePlayPoints, f44_local14, f44_local13 == CoD.RankUtility.RankMode.Arena )
		f44_local16 = table.insert
		f44_local17 = f44_local0
		f44_local21 = {}
		f44_local22 = {
			["identityBadge.xuid"] = f44_local11.xuid,
			["identityBadge.gamertag"] = f44_local11.gamertag,
			["identityBadge.clantag"] = f44_local18,
			xuid = f44_local11.xuid,
			gamertag = f44_local11.gamertag,
			clantag = f44_local18,
			fullname = f44_local19,
			isLocal = f44_local12,
			isMemberLeader = f44_local11.isLeader,
			presence = f44_local11.presence,
			presenceString = GetPresenceString( f44_local11 ),
			activity = f44_local11.activity,
			activityString = GetPresenceActivityString( f44_local11 ),
			context = f44_local11.context,
			difficulty = f44_local11.difficulty,
			playlist = f44_local11.playlist,
			joinable = f44_local11.joinable,
			gametype = f44_local11.gametype,
			mapid = f44_local11.mapid,
			modeparam = f44_local11.modeparam,
			friend = f44_local11.friend,
			trial = f44_local11.trial,
			blackopsPass = f44_local11.blackopsPass,
			titlePresence = f44_local20,
			rankInfo = CoD.RankUtility.GetClientRankInfoModel( f44_local11.xuid )
		}
		f44_local23 = f44_local11.rubiesUnlocked
		if not f44_local23 then
			f44_local23 = 0
		end
		f44_local22.rubiesUnlocked = f44_local23
		f44_local23 = f44_local11.arenaPoints
		if not f44_local23 then
			f44_local23 = 0
		end
		f44_local22.arenaPoints = f44_local23
		f44_local22.empty = false
		f44_local22.partyBarType = CoD.SocialUtility.PartyBarType.NONE
		f44_local22.lobbyDLCBits = f44_local11.lobbyDLCBits
		f44_local21.models = f44_local22
		f44_local21.properties = {
			xuid = f44_local11.xuid,
			showyourfriend = f44_local3,
			showlastmet = f44_local4,
			gametype = f44_local11.gametype,
			mapid = f44_local11.mapid,
			modeparam = f44_local11.modeparam,
			difficulty = f44_local11.difficulty,
			playlist = f44_local11.playlist,
			lobbyDLCBits = f44_local11.lobbyDLCBits
		}
		f44_local16( f44_local17, f44_local21 )
	end
	if #f44_local2 < CoD.LobbyUtility.GetMaxClientCount() then
		local f44_local7 = Engine[0x8DF2E5447F384B9]()
		if f44_local7.PartyPrivacy.privacy:get() ~= Enum[0x70DC6CE53EF2D31][0x8B288F48084ABC5] then
			table.insert( f44_local0, {
				models = {
					empty = true,
					xuid = LuaDefine.INVALID_XUID_X64,
					fullname = "",
					gamertag = "",
					clantag = "",
					isMemberLeader = 0,
					presence = 0,
					presenceString = "",
					activity = -1,
					activityString = "",
					["identityBadge.xuid"] = LuaDefine.INVALID_XUID_X64,
					["identityBadge.gamertag"] = "",
					["identityBadge.clantag"] = "",
					partyBarType = CoD.SocialUtility.PartyBarType.NONE,
					rankInfo = CoD.RankUtility.GetClientRankInfoModel( LuaDefine.INVALID_XUID_X64 ),
					rubiesUnlocked = 0
				},
				properties = {}
			} )
		end
	end
	return f44_local0
end, nil, nil, function ( f45_arg0, f45_arg1, f45_arg2 )
	local f45_local0 = Engine[0x8DF2E5447F384B9]()
	f45_local0 = f45_local0.socialRoot
	local f45_local1 = f45_local0.tab:get()
	local f45_local2 = f45_local0.friends
	if f45_local1 == "friends" then
		f45_local2 = f45_local0.friends
	elseif f45_local1 == "recent" then
		f45_local2 = f45_local0.recentPlayers
	elseif f45_local1 == "party" then
		f45_local2 = f45_local0.party
	end
	CoD.SocialUtility.AddUpdateDatasourceOnTabUpdate( f45_arg0, f45_arg1 )
	local f45_local3 = CoD.SocialUtility.AddRefreshListSubscription
	local f45_local4 = f45_arg0
	local f45_local5 = f45_arg1
	local f45_local6 = {}
	local f45_local7 = Engine[0x8DF2E5447F384B9]()
	f45_local7 = f45_local7.lobbyRoot.rankMode
	local f45_local8 = f45_local2.update
	f45_local6[1] = f45_local7
	f45_local6[2] = f45_local8
	f45_local3( f45_local4, f45_local5, f45_local6, "refreshListTabSubscriptions" )
	CoD.SocialUtility.OnPartyEventUpdate( f45_arg0, f45_arg1, f45_arg2 )
end )
DataSources.SocialMainMenu = {
	getModel = function ( f46_arg0 )
		local f46_local0 = Engine[0x8DF2E5447F384B9]()
		return f46_local0.SocialMainMenu
	end
}
DataSources.SocialPlayersList = {
	prepare = function ( f47_arg0, f47_arg1, f47_arg2 )
		f47_arg1.numElementsInList = f47_arg1.vCount
		f47_arg1.controller = f47_arg0
		local f47_local0 = f47_arg1._presenceFilter
		if not f47_local0 then
			f47_local0 = Enum[0xEA28383B5DEC206][0x708B5057D80F5FF]
		end
		f47_arg1._presenceFilter = f47_local0
		f47_local0 = DataSources.SocialRoot.getModel( f47_arg0 )
		local f47_local1 = f47_local0.tab:get()
		local f47_local2 = f47_arg1.playerCount
		local f47_local3 = Engine[0xA798E4552F5E872]( f47_local0, "showPlayersList" )
		f47_local3 = f47_local3:get()
		local f47_local4 = Engine[0xA798E4552F5E872]( f47_local0, "leaderboardsPlayerListActive" )
		local f47_local5 = false
		f47_arg1.GetFilteredList = nil
		if f47_local1 == "friends" then
			f47_arg1.showyourfriend = false
			f47_arg1.showlastmet = false
			f47_arg1.GetList = Engine[0xF14B7D0A8CB7818]
			f47_arg1.GetParty = Engine[0xE940BDCC0375A9D]
			f47_arg1.playerCount = Engine[0xE1E8FED08B06DF7]( f47_arg0, f47_arg1._presenceFilter )
			f47_arg1.socialSubModel = f47_local0.friends
		elseif f47_local1 == "recent" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = true
			f47_arg1.GetList = CoD.SocialUtility.GetRecentPlayersList
			f47_arg1.GetParty = CoD.SocialUtility.GetRecentPlayersParty
			f47_arg1.playerCount = CoD.SocialUtility.GetRecentPlayersCount( f47_arg0 )
			f47_arg1.socialSubModel = f47_local0.recentPlayers
		elseif f47_local1 == "groupMembers" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = false
			f47_arg1.showGroupMemberStatus = true
			f47_arg1.GetList = Engine[0x6AA203B0B1C32E4]
			f47_arg1.GetParty = Engine[0x90B5194CF1EA260]
			f47_arg1.playerCount = Engine[0x4F60F2B1AED8E23]( f47_arg0, f47_arg1._presenceFilter )
			f47_arg1.socialSubModel = f47_local0.groupMembers
		elseif f47_local1 == "groupApplications" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = false
			f47_arg1.GetList = Engine[0xDCA2718259594D2]
			f47_arg1.playerCount = Engine[0xA8903EF90609215]( f47_arg0, f47_arg1._presenceFilter )
			f47_arg1.socialSubModel = f47_local0.groupApplications
		elseif f47_local1 == "clan" or f47_local1 == "clan_Members" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = true
			f47_arg1.GetList = CoD.ClanUtility.GetMembersList
			f47_arg1.GetFilteredList = CoD.ClanUtility.GetClanMembersFilteredList
			f47_arg1.GetParty = CoD.ClanUtility.GetPlayersParty
			f47_arg1.playerCount = CoD.ClanUtility.GetClanMembersCount( f47_arg0, f47_local1 )
			local f47_local6 = CoDShared.GetXUID64StringForController( f47_arg0 )
			local f47_local7 = Engine[0x8DF2E5447F384B9]()
			f47_arg1.socialSubModel = f47_local7.LobbyClients[f47_local6].clan.members
		elseif f47_local1 == "clan_Squad" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = true
			f47_arg1.GetList = CoD.ClanUtility.GetMembersList
			f47_arg1.GetFilteredList = CoD.ClanUtility.GetSquadMembersFilteredList
			f47_arg1.GetParty = CoD.ClanUtility.GetPlayersParty
			f47_arg1.playerCount = CoD.ClanUtility.GetClanMembersCount( f47_arg0, f47_local1 )
			local f47_local6 = CoDShared.GetXUID64StringForController( f47_arg0 )
			local f47_local7 = Engine[0x8DF2E5447F384B9]()
			f47_arg1.socialSubModel = f47_local7.LobbyClients[f47_local6].clan.members
		elseif f47_local1 == "clan_Team" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = true
			f47_arg1.GetList = CoD.ClanUtility.GetMembersList
			f47_arg1.GetFilteredList = CoD.ClanUtility.GetTeamMembersFilteredList
			f47_arg1.GetParty = CoD.ClanUtility.GetPlayersParty
			f47_arg1.playerCount = CoD.ClanUtility.GetClanMembersCount( f47_arg0, f47_local1 )
			local f47_local6 = CoDShared.GetXUID64StringForController( f47_arg0 )
			local f47_local7 = Engine[0x8DF2E5447F384B9]()
			f47_arg1.socialSubModel = f47_local7.LobbyClients[f47_local6].clan.members
		elseif f47_local3 ~= nil and f47_local3 == true then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = false
			f47_arg1.GetList = Engine[0x4D6DD81541D4853]
			f47_arg1.playerCount = Engine[0x469E79D58A190B2]( f47_arg0 )
			f47_arg1.socialSubModel = Engine[0xA798E4552F5E872]( f47_local0, "playersList.update" )
			f47_arg1.GetParty = nil
			f47_local5 = true
		elseif f47_local1 == "friendsPlayersList" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = false
			f47_arg1.GetList = Engine[0xD945852E5338613]
			f47_arg1.playerCount = Engine[0xF370A83B2819E94]( f47_arg0 )
			f47_arg1.socialSubModel = f47_local0.friends
			f47_arg1.GetParty = nil
			f47_local5 = true
		elseif f47_local1 == "recentPlayersList" then
			f47_arg1.showyourfriend = true
			f47_arg1.showlastmet = true
			f47_arg1.GetList = CoD.LeaderboardUtility.GetRecentPlayersList
			f47_arg1.playerCount = CoD.LeaderboardUtility.GetRecentPlayersCount( f47_arg0 )
			f47_arg1.socialSubModel = f47_local0.recentPlayers
			f47_arg1.GetParty = nil
			f47_local5 = true
		else
			f47_arg1.showyourfriend = false
			f47_arg1.showlastmet = false
			f47_arg1.GetList = Engine[0xF14B7D0A8CB7818]
			f47_arg1.GetParty = Engine[0xE940BDCC0375A9D]
			f47_arg1.playerCount = Engine[0xE1E8FED08B06DF7]( f47_arg0, f47_arg1._presenceFilter )
			f47_arg1.socialSubModel = f47_local0.friends
		end
		f47_local4:set( f47_local5 )
		local f47_local6 = Engine[0xA798E4552F5E872]( f47_local0, "playersListFull" )
		if f47_local5 and not f47_local3 then
			local f47_local7 = f47_local0.selectedCount
			local f47_local8 = 0
			if f47_local8 ~= nil then
				f47_local8 = f47_local7:get()
			end
			f47_local6:set( Engine[0x3B1FD53757FE607]( f47_arg0 ) - f47_local8 <= 0 )
		end
		if f47_local2 ~= f47_arg1.playerCount and f47_arg1._onDataSourceListCountChanged then
			f47_arg1:_onDataSourceListCountChanged()
		end
		if f47_arg1.GetFilteredList ~= nil then
			f47_arg1.filteredList = f47_arg1.GetFilteredList( f47_arg0 )
		end
		f47_local0.visibleCount:set( f47_arg1.playerCount )
		local f47_local7 = Engine[0x9073FBE2D48C156]( "0" )
		f47_arg1.players = {}
		local f47_local8 = {
			["identityBadge.xuid"] = 0,
			["identityBadge.gamertag"] = "",
			["identityBadge.clantag"] = "",
			xuid = f47_local7,
			gamertag = "",
			clantag = "",
			emblemBacking = 0,
			fullname = "",
			presence = 0,
			activity = 0,
			context = 0,
			difficulty = 0,
			playlist = 1,
			joinable = 0,
			gametype = 0,
			mapid = 0,
			modeparam = 0,
			friend = 0,
			trial = false,
			blackopsPass = false,
			primaryPresence = Enum[0x5904C991C9847C2][0xDB6E2B269A58541],
			titlePresence = "",
			platformPresence = "",
			rankInfo = CoD.RankUtility.GetClientRankInfoModel( LuaDefine.INVALID_XUID_X64 ),
			partySize = 1,
			partyMax = 9,
			selected = false,
			playerCount = 0,
			groupMemberStatus = 0,
			rubiesUnlocked = 0,
			lobbyDLCBits = 0
		}
		local f47_local9 = {
			xuid = f47_local7,
			showyourfriend = false,
			showlastmet = false,
			gametype = 0,
			mapid = 0,
			modeparam = 0,
			difficulty = 0,
			playlist = 1,
			party = {
				members = {},
				total = 1,
				available = 1,
				leader = "",
				lobbyDLCBits = 0
			}
		}
		for f47_local10 = 1, f47_arg1.numElementsInList, 1 do
			f47_arg1.players[f47_local10] = {}
			f47_arg1.players[f47_local10].root = f47_arg1.socialSubModel:create( "player_" .. f47_local10 )
			f47_arg1.players[f47_local10].model = f47_arg1.players[f47_local10].root:create( "model" )
			f47_arg1.players[f47_local10].properties = {
				xuid = f47_local7,
				showyourfriend = 0,
				showlastmet = 0,
				gametype = 0,
				mapid = 0,
				modeparam = 0,
				difficulty = 0,
				playlist = 1,
				lobbyDLCBits = 0
			}
			for f47_local16, f47_local17 in pairs( f47_local8 ) do
				local f47_local18 = f47_arg1.players[f47_local10].model:create( f47_local16 )
			end
		end
		f47_arg1.updateModels = function ( f48_arg0, f48_arg1, f48_arg2, f48_arg3 )
			if not f48_arg1.GetList then
				return 
			end
			local f48_local0 = {}
			f48_local0 = f48_arg1.GetList( f48_arg0, f48_arg2, f48_arg3, f48_arg1._presenceFilter, f48_arg1.filteredList )
			local f48_local1 = {}
			local f48_local2 = DataSources.SocialRoot.getModel( f48_arg0 )
			local f48_local3 = f48_local2.tab:get()
			local f48_local4 = f48_local2.showPlayersList:get()
			local f48_local5 = 0
			if f48_local3 == "friends" then
				f48_local5 = Engine[0xE1E8FED08B06DF7]( f48_arg0, f48_arg1._presenceFilter )
			elseif f48_local3 == "recent" then
				f48_local5 = CoD.SocialUtility.GetRecentPlayersCount( f48_arg0 )
			elseif f48_local3 == "groupMembers" then
				f48_local5 = Engine[0x4F60F2B1AED8E23]( f48_arg0, f48_arg1._presenceFilter )
			elseif f48_local3 == "groupApplications" then
				f48_local5 = Engine[0xA8903EF90609215]( f48_arg0, f48_arg1._presenceFilter )
			elseif f48_local3 == "clan" or f48_local3 == "clan_Members" or f48_local3 == "clan_Squad" or f48_local3 == "clan_Team" then
				f48_local5 = CoD.ClanUtility.GetClanMembersCount( f48_arg0, f48_local3 )
			elseif f48_local4 ~= nil and f48_local4 == true then
				f48_local5 = Engine[0x469E79D58A190B2]( f48_arg0 )
			elseif f48_local3 == "friendsPlayersList" then
				f48_local5 = Engine[0xF370A83B2819E94]( f48_arg0 )
			elseif f48_local3 == "recentPlayersList" then
				f48_local5 = CoD.LeaderboardUtility.GetRecentPlayersCount( f48_arg0 )
			else
				f48_local5 = Engine[0xE1E8FED08B06DF7]( f48_arg0, f48_arg1._presenceFilter )
			end
			if f48_local5 ~= f48_arg1.playerCount then
				f48_arg1.playerCount = f48_local5
				if f48_arg1._onDataSourceListCountChanged then
					f48_arg1:_onDataSourceListCountChanged()
				end
				f48_local2.visibleCount:set( f48_arg1.playerCount )
			end
			for f48_local6 = 1, #f48_local0, 1 do
				local f48_local9 = f48_local0[f48_local6]
				local f48_local10 = (f48_arg2 + f48_local6 - 1) % f48_arg1.numElementsInList + 1
				f48_local9.xuid = f48_local9.xuid or f47_local7
				f48_local9.clantag = ""
				f48_local9.fullname = string.format( "%s%s", f48_local9.clantag, f48_local9.gamertag )
				f48_local9["identityBadge.xuid"] = f48_local9.xuid
				f48_local9["identityBadge.gamertag"] = f48_local9.gamertag
				f48_local9["identityBadge.clantag"] = f48_local9.clantag
				if f48_arg1.showlastmet == 0 then
					f48_local9.titlePresence = ""
				end
				if f48_arg1.showGroupMemberStatus then
					f48_local9.groupMemberStatus = Engine[0x13B8AD42FDF5311]( f48_local9.xuid )
				end
				f48_local9 = CoD.SocialUtility.AddRankData( f48_local9 )
				f48_local9.rankInfo = CoD.RankUtility.GetClientRankInfoModel( f48_local9.xuid )
				f48_local9.selected = Engine[0x98FF418E4BF6055]( f48_local9.xuid )
				f48_local9.playerCount = f48_arg1.playerCount
				if f48_local9.mapid then
					local f48_local11 = f48_local9.mapid
					if f48_local11 then
						f48_local11 = CoD.BaseUtility.GetMapDataFromMapID( f48_local9.mapid )
					end
					local f48_local12 = f48_local11 and f48_local11.session_mode
					local f48_local13
					if f48_local12 and f48_local12 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
						f48_local13 = Engine[0x3C915544ECCD34B]( f48_arg0 )
						if not f48_local13 then
						
						else
							local f48_local14
							if f48_local13 then
								f48_local14 = f48_local9.joinable
								if not f48_local14 then
								
								else
									f48_local9.joinable = f48_local14
								end
							end
							f48_local14 = 10
						end
					end
					f48_local13 = CoD.MapUtility.LobbyHasMap( f48_local9.mapid )
				end
				if f48_local9.joinable and CoD.LobbyUtility.IsPlayerInMyParty( f48_local9.xuid ) then
					f48_local9.joinable = Enum[0xCA6AE10CC343A4F][0x8FCE6A0B08CD559]
				end
				local f48_local11 = Engine[0xA798E4552F5E872]( f48_local2, "leaderboardsPlayerListActive" )
				if f48_local11:get() then
					f48_local9.joinable = Enum[0xCA6AE10CC343A4F][0x449F4A7CB58D3D5]
				end
				f48_local9 = CoD.SocialUtility.AddRankNamesIfAvailable( f48_local9 )
				for f48_local15, f48_local16 in pairs( f48_local9 ) do
					local f48_local17 = f48_arg1.players[f48_local10].model[f48_local15]
					if f48_local17 ~= nil then
						f48_local17:set( f48_local16 )
					end
					if f48_arg1.players[f48_local10].properties[f48_local15] ~= nil then
						f48_arg1.players[f48_local10].properties[f48_local15] = f48_local16
					end
				end
				if CoD.isPC and CoD.PCUtility.IsBGSEnabled() and f48_local3 == "friends" then
					f48_local12 = CoD.PCBattlenetUtility.GetBattlenetPresence( f48_local9.xuid )
					if f48_local12 == Enum[0x8811A60F2FF3ADA][0xD7B6D45F00CF380] then
						f48_local13 = f48_arg1.players[f48_local10].model:create( "presence" )
						f48_local13:set( Enum[0x4BBA402DE649132][0x1CF21FD793411B9] )
					end
					f48_local13 = f48_arg1.players[f48_local10].model:create( "primaryPresence" )
					f48_local13:set( f48_local12 )
					f48_local13 = f48_arg1.players[f48_local10].model:create( "presenceString" )
					f48_local13:set( CoD.PCBattlenetUtility.GetBattlenetRichPresenceString( f48_local9 ) )
				else
					f48_local12 = f48_arg1.players[f48_local10].model:create( "presenceString" )
					f48_local12:set( GetPresenceString( f48_local9 ) )
				end
				f48_local12 = f48_arg1.players[f48_local10].model:create( "isMemberLeader" )
				f48_local13 = f48_local12
				f48_local12 = f48_local12.set
				f48_local14 = f48_local9.isMemberLeader
				if not f48_local14 then
					f48_local14 = 0
				end
				f48_local12( f48_local13, f48_local14 )
				f48_local12 = f48_arg1.players[f48_local10].model:create( "activityString" )
				f48_local12:set( GetPresenceActivityString( f48_local9 ) )
				f48_local12 = f48_arg1.players[f48_local10].model:create( "contextString" )
				f48_local12:set( GetPresenceContextString( f48_local9 ) )
				if CoD.isPC and CoD.PCUtility.IsBGSEnabled() then
					f48_local12 = f48_arg1.players[f48_local10].model:create( "partyInviteStatus" )
					f48_local12:set( CoD.PCBattlenetUtility.GetPartyInviteStatus( f48_arg0, f48_local9.xuid ) )
				end
				f48_local12 = Engine[0x5065E759595C457]( f48_local9.xuid )
				f48_local13 = f48_arg1.players[f48_local10].model:create( "checked" )
				f48_local14 = f48_local13
				f48_local13 = f48_local13.set
				if CoD.SocialUtility.CheckedInvitees[f48_local12] then
					f48_local15 = true
				else
					f48_local15 = false
				end
				f48_local13( f48_local14, f48_local15 )
				f48_arg1.players[f48_local10].properties.showlastmet = f48_arg1.showlastmet
				f48_arg1.players[f48_local10].properties.showyourfriend = f48_arg1.showyourfriend
				if #f48_local0 > 1 then
					if not f48_arg1.players[f48_local10].model.partyBarType then
						f48_arg1.players[f48_local10].model:create( "partyBarType" )
					end
					f48_arg1.players[f48_local10].model.partyBarType:set( CoD.SocialUtility.PartyBarType.NONE )
				end
				if f48_arg1.GetParty then
					f48_local15 = CoD.SocialUtility.GetPartyModel( f48_local9, f48_arg1.GetParty( f48_arg0, f48_arg2 + f48_local6 - 1, f48_arg1._presenceFilter ), f48_arg1.players[f48_local10].model.gamertag:get(), f48_local1 )
					if not f48_local15 then
						f48_local16 = f48_arg1.players[f48_local10].model:create( "partySize" )
						f48_local16:set( 0 )
					else
						f48_arg1.players[f48_local10].properties.party = f48_local15
						f48_local16 = f48_arg1.players[f48_local10].model:create( "partySize" )
						f48_local16:set( f48_local15.partySize )
						f48_local16 = f48_arg1.players[f48_local10].model:create( "partyBarType" )
						f48_local16:set( f48_local15.partyBarType )
					end
				end
			end
		end
		
		f47_arg1.updateModels( f47_arg0, f47_arg1, 0, f47_arg1.numElementsInList )
		if not f47_arg1._elementTimer then
			f47_arg1._elementTimer = LUI.UITimer.newElementTimer( 150, false, function ()
				CoD.SocialUtility.UpdateCheckedInvitees( f47_arg0 )
			end )
			f47_arg1:addElement( f47_arg1._elementTimer )
		end
		CoD.SocialUtility.AddUpdateDatasourceOnTabUpdate( f47_arg0, f47_arg1 )
		local f47_local10 = CoD.SocialUtility.AddRefreshListSubscription
		local f47_local11 = f47_arg0
		local f47_local12 = f47_arg1
		local f47_local19 = {}
		local f47_local13 = Engine[0x8DF2E5447F384B9]()
		f47_local13 = f47_local13.lobbyRoot.rankMode
		local f47_local14 = f47_arg1.socialSubModel.update
		local f47_local15 = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "socialRoot.showPlayersList" )
		f47_local10( f47_local11, f47_local12, f47_local13, "socialUpdateSubscription" )
	end,
	getCount = function ( f50_arg0 )
		return f50_arg0.playerCount
	end,
	getItem = function ( f51_arg0, f51_arg1, f51_arg2 )
		f51_arg1.updateModels( f51_arg0, f51_arg1, f51_arg2 - 1, 1 )
		local f51_local0 = (f51_arg2 - 1)
		return f51_arg1.players[(f51_arg2 - 1) % f51_arg1.numElementsInList + 1].model
	end,
	getCustomPropertiesForItem = function ( f52_arg0, f52_arg1 )
		local f52_local0 = (f52_arg1 - 1)
		return f52_arg0.players[(f52_arg1 - 1) % f52_arg0.numElementsInList + 1].properties
	end
}
DataSources.SocialPlayerPartyList = {
	prepare = function ( f53_arg0, f53_arg1, f53_arg2 )
		f53_arg1.numElementsInList = f53_arg1.vCount
		f53_arg1.controller = f53_arg0
		local f53_local0 = Engine[0x8DF2E5447F384B9]()
		f53_local0 = f53_local0.socialRoot
		local f53_local1 = f53_local0:create( "cache" )
		f53_arg1.xuidModel = f53_local1:create( "xuid" )
		local f53_local2 = f53_local0.party
		f53_arg1.partyUpdate = f53_local2:create( "update" )
		local f53_local3 = Engine[0x9073FBE2D48C156]( "0" )
		local f53_local4 = f53_local2:create( "available" )
		local f53_local5 = f53_local2:create( "total" )
		local f53_local6 = f53_local2:create( "leader" )
		local f53_local7 = f53_local2:create( "partyBarType" )
		local f53_local8 = f53_arg1.xuidModel:create( "xuid" )
		f53_arg1.xuid = f53_local8:get() or f53_local3
		f53_arg1.available = f53_local4:get()
		f53_arg1.total = f53_local5:get()
		f53_arg1.leader = f53_local6:get()
		f53_arg1.partyMembers = {}
		for f53_local8 = 1, 18, 1 do
			f53_arg1.partyMembers[f53_local8] = Engine[0x40E824FE270E174]( f53_local2, "pm_" .. f53_local8 )
		end
		if f53_arg1.selectedPlayerSubscription then
			f53_arg1:removeSubscription( f53_arg1.selectedPlayerSubscription )
		end
		f53_arg1.selectedPlayerSubscription = f53_arg1:subscribeToModel( f53_arg1.partyUpdate, function ()
			f53_arg1:updateDataSource()
		end, false )
	end,
	getCount = function ( f55_arg0 )
		return CoD.SafeGetModelValue( Engine[0x8DF2E5447F384B9](), "socialRoot.party.available" ) or 0
	end,
	getItem = function ( f56_arg0, f56_arg1, f56_arg2 )
		return f56_arg1.partyMembers[f56_arg2]
	end
}
local f0_local0 = function ( f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4, f57_arg5 )
	local f57_local0 = CoD.OptionsUtility.GetProfileSelection( f57_arg2, f57_arg1.options, f57_arg3 )
	local f57_local1, f57_local2 = f57_arg0.Slider:getRowAndColumnForIndex( Engine[0x614D394F6F9A18D]( f57_arg0:getModel( f57_arg2, "currentSelection" ) ) - 1 )
	f57_arg0.Slider:setActiveIndex( f57_local1, f57_local2, 0 )
end
local f0_local1 = function ( f58_arg0 )
	local f58_local0 = "voice_favored_channel"
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE]( 0x8713D707716544B ),
			desc = Engine[0xF9F1239CFD921FE]( 0x9A27D679EC11266 ),
			optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource( f58_arg0, "PartyOptions_VoiceChatChannel", CoD.SocialUtility.VoiceChatChannelOptions, f58_local0, function ( f59_arg0 )
				Engine[0x280E4C1191CC53D]( f58_arg0, "voice_favored_channel", f59_arg0 )
				if CoD.isPC then
					CoD.PCOptionsUtility.SyncOptionModel( f58_arg0, 0x877C6F1A42405D7 )
				end
			end
			, nil, f0_local0 ),
			currentSelection = CoD.OptionsUtility.GetProfileSelection( f58_arg0, CoD.SocialUtility.VoiceChatChannelOptions, f58_local0 ),
			buttonOnly = false
		},
		properties = {
			hideArrows = true,
			disabled = false
		}
	}
end
DataSources.PartyControlsList = DataSourceHelpers.ListSetup( "PartyControlsList", function ( f60_arg0, f60_arg1 )
	if not f60_arg1._partySizeSubscription then
		local f60_local0 = f60_arg1
		local f60_local1 = f60_arg1.subscribeToModel
		local f60_local2 = Engine[0x8DF2E5447F384B9]()
		f60_arg1._partySizeSubscription = f60_local1( f60_local0, f60_local2.lobbyRoot.privateClient.count, function ()
			f60_arg1:clearLayout()
			f60_arg1:updateDataSource()
		end, false )
	end
	local f60_local1 = function ( f62_arg0 )
		local f62_local0 = "party_privacyStatus"
		return {
			models = {
				name = Engine[0xF9F1239CFD921FE]( 0xC66ADDE88E8D222 ),
				desc = Engine[0xF9F1239CFD921FE]( 0x1E6C0A18FB50FF2 ),
				optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource( f62_arg0, "PartyOptions_PartyPrivacy", CoD.SocialUtility.PartyPrivacyOptions, f62_local0, function ( f63_arg0 )
					if Engine[0x9455799AABED509] then
						Engine[0x9455799AABED509]( Enum[0xBF54BE1BB3D618B][0xA1647599284110], f63_arg0 )
					end
					local f63_local0 = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "PartyPrivacy" )
					Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f63_local0, "privacy" ), f63_arg0 )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f63_local0, "privacyStatus" ), PartyPrivacy( f63_arg0 ) )
				end
				, nil, f0_local0 ),
				currentSelection = CoD.OptionsUtility.GetProfileSelection( f62_arg0, CoD.SocialUtility.PartyPrivacyOptions, f62_local0 ),
				buttonOnly = false
			},
			properties = {
				hideArrows = true,
				disabled = false
			}
		}
	end
	
	local f60_local0 = function ( f64_arg0 )
		local f64_local0 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
		local f64_local1 = f64_local0[0xEE71E4EE12BC453]
		local f64_local2 = Engine[0x44FC97037CE42ED]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F] )
		local f64_local3 = {}
		for f64_local4 = f64_local2, f64_local1, 1 do
			table.insert( f64_local3, {
				name = tostring( f64_local4 ),
				value = f64_local4
			} )
		end
		local f64_local4 = function ( f65_arg0, f65_arg1, f65_arg2, f65_arg3, f65_arg4 )
			local f65_local0 = Engine[0x22EAAB59AA27E9B]( f65_arg3 )
			local f65_local1 = f65_arg1.value
			if Engine[0xEA2BE00F49480D]( Enum[0xBF54BE1BB3D618B][0xA1647599284110] ) then
				local f65_local2 = Engine[0x44FC97037CE42ED]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F] )
				if f65_local1 < f65_local2 then
					return f65_local2
				end
				Dvar[0x4FF45B41C6046F8]:set( f65_local1 )
				Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "PartyPrivacy" ), "maxPlayers" ), f65_local1 )
			end
		end
		
		if f64_local1 < Dvar[0x4FF45B41C6046F8]:get() then
			Dvar[0x4FF45B41C6046F8]:set( f64_local1 )
		end
		return {
			models = {
				name = Engine[0xF9F1239CFD921FE]( 0x9F579200DA477FE ),
				desc = Engine[0xF9F1239CFD921FE]( 0xA7923E2180D5E4E ),
				optionsDatasource = CoD.OptionsUtility.CreateDvarSettingsDataSourceCustom( f64_arg0, "PartyOptions_PartyMaxSize", f64_local3, "lobbyPrivateLobbyMax", false, f64_local4 ),
				buttonOnly = false
			},
			properties = {
				hideArrows = true,
				disabled = false
			}
		}
	end
	
	local f60_local2 = function ( f66_arg0, f66_arg1, f66_arg2, f66_arg3, f66_arg4 )
		return {
			models = {
				name = Engine[0xF9F1239CFD921FE]( f66_arg1 ),
				desc = 0x0,
				image = f66_arg2,
				buttonOnly = true,
				selected = false,
				altText = f66_arg3
			},
			properties = {
				hideArrows = true,
				disabled = false,
				action = f66_arg4,
				customWidgetOverride = CoD.CustomGames_SettingButton
			}
		}
	end
	
	local f60_local3 = {}
	if ShouldShowPartyPrivacy( f60_arg0 ) then
		table.insert( f60_local3, f60_local1( f60_arg0 ) )
		table.insert( f60_local3, f60_local0( f60_arg0 ) )
		table.insert( f60_local3, f0_local1( f60_arg0 ) )
	end
	if (CoD.isPC or not CoD.DirectorUtility.DisableForCurrentMilestone( f60_arg0 )) and ShouldShowLeaveParty( f60_arg0 ) then
		table.insert( f60_local3, f60_local2( f60_arg0, 0xBC2011402700EA4, "uie_t7_menu_social_leave_party", 0xEF2D3320785B51A, function ( f67_arg0, f67_arg1, f67_arg2, f67_arg3, f67_arg4 )
			if not CoD.isPC then
				CoD.OverlayUtility.CreateOverlay( f67_arg2, f67_arg4, "LobbyLeavePopup", LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE )
			else
				CoD.OverlayUtility.CreateOverlay( f67_arg2, f67_arg4, "LeaveLobbyPopupPC", LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE )
			end
		end ) )
	end
	return f60_local3
end, true )
DataSources.PartyVoiceChatControl = DataSourceHelpers.ListSetup( "PartyVoiceChatControl", function ( f68_arg0, f68_arg1 )
	if not f68_arg1._partySizeSubscription then
		local f68_local0 = f68_arg1
		local f68_local1 = f68_arg1.subscribeToModel
		local f68_local2 = Engine[0x8DF2E5447F384B9]()
		f68_arg1._partySizeSubscription = f68_local1( f68_local0, f68_local2.lobbyRoot.privateClient.count, function ()
			f68_arg1:clearLayout()
			f68_arg1:updateDataSource()
		end, false )
	end
	local f68_local1 = {}
	if ShouldShowPartyPrivacy( f68_arg0 ) then
		table.insert( f68_local1, f0_local1( f68_arg0 ) )
	end
	return f68_local1
end, true )
CoD.SocialUtility.CleanGamerTag = function ( f70_arg0 )
	if CoD.isPC and CoD.PCUtility.IsBGSEnabled() then
		if type( f70_arg0 ) == "xhash" then
			return Engine[0xF9F1239CFD921FE]( f70_arg0 )
		else
			return CoD.PCBattlenetUtility.StripBattleTagNumber( f70_arg0 )
		end
	else
		return f70_arg0
	end
end
CoD.SocialUtility.GetCurrentPlayerLimitString = function ( f71_arg0 )
	local f71_local0 = LobbyData.GetLobbyMenuByID( Engine[0x9882F293C327557]() )
	local f71_local1 = f71_local0[0xEE71E4EE12BC453]
	return Engine[0xF9F1239CFD921FE]( f71_arg0, tostring( Dvar[0x4FF45B41C6046F8]:get() ) )
end
CoD.SocialUtility.GetCurrentPartySettingString = function ( f72_arg0, f72_arg1, f72_arg2 )
	local f72_local0 = nil
	local f72_local1 = ""
	if f72_arg1 == "party_privacyStatus" then
		f72_local0 = CoD.SocialUtility.PartyPrivacyOptions
	elseif f72_arg1 == "voice_favored_channel" then
		f72_local0 = CoD.SocialUtility.VoiceChatChannelOptions
	end
	if f72_local0 then
		local f72_local2 = f72_local0[CoD.OptionsUtility.GetProfileSelection( f72_arg0, f72_local0, f72_arg1 )]
		if f72_local2 and f72_local2.name then
			f72_local1 = f72_local2.name
		end
	end
	return Engine[0xF9F1239CFD921FE]( f72_arg2, f72_local1 )
end
CoD.SocialUtility.GetSocialRankStringForModeFromRank = function ( f73_arg0, f73_arg1 )
	return CoD.RankUtility.GetRankStringForModeFromRank( f73_arg0, f73_arg1 - 1 )
end
CoD.SocialUtility.UpdateIdentityClanTag = function ( f74_arg0 )
	if DataSources.PerController then
		local f74_local0 = LUI.getTableFromPath( "identityBadge.clantag", DataSources.PerController.getModel( f74_arg0 ) )
		if f74_local0 then
			f74_local0:set( Engine[0x290CFCDAE13C54]( f74_arg0 ) )
		end
	end
end
CoD.SocialUtility.IsPartyMissingRequiredDLCForSelectedPlaylist = function ( f75_arg0 )
	local f75_local0 = DataSources.LobbyRoot.getModel( f75_arg0 )
	f75_local0 = f75_local0.playlistId
	if f75_local0 then
		f75_local0 = f75_local0:get()
	end
	if f75_local0 then
		local f75_local1 = Engine[0x3ACB99DBAD24D55]( f75_local0 )
		return f75_local1 and f75_local1.lockState == Enum[0xDACBB5C5F26BCD9][0xFFA783827E8E485]
	else
		return false
	end
end
CoD.SocialUtility.IsPartyMissingRequiredDLCForElementPlaylist = function ( f76_arg0, f76_arg1 )
	local f76_local0 = f76_arg1:getModel( f76_arg0, "playlist" )
	local f76_local1 = f76_local0 and f76_local0:get()
	if f76_local1 then
		local f76_local2 = Engine[0x3ACB99DBAD24D55]( f76_local1 )
		return f76_local2 and f76_local2.lockState == Enum[0xDACBB5C5F26BCD9][0xFFA783827E8E485]
	else
		return false
	end
end
CoD.SocialUtility.IsUserMissingRequiredDLCForSelectedPlaylist = function ( f77_arg0, f77_arg1 )
	local f77_local0 = CoD.SafeGetModelValue( DataSources.LobbyRoot.getModel( f77_arg0 ), "playlistId" )
	if f77_local0 then
		local f77_local1 = Engine[0x3ACB99DBAD24D55]( f77_local0 )
		local f77_local2 = CoD.SafeGetModelValue( f77_arg1 and f77_arg1:getModel(), "dlcBits" )
		if f77_local1 and f77_local2 then
			local f77_local3
			if f77_local1.requiredDLCMask & f77_local2 ~= f77_local1.requiredDLCMask then
				if f77_local1.mainMode == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
					f77_local3 = not Engine[0x3C915544ECCD34B]( f77_arg0 )
				else
					f77_local3 = true
				end
			else
				f77_local3 = false
			end
			return f77_local3
		end
		local f77_local3 = CoD.SafeGetModelValue( f77_arg1 and f77_arg1:getModel(), "blackopsPass" )
		if f77_local3 ~= nil then
			local f77_local4
			if f77_local1.requiredDLCMask > 0 then
				f77_local4 = not f77_local3
			else
				f77_local4 = false
			end
			return f77_local4
		end
	end
	return false
end
CoD.SocialUtility.IsSelfMissingRequiredDLCForSelectedPlaylist = function ( f78_arg0, f78_arg1 )
	local f78_local0 = CoD.SafeGetModelValue( DataSources.LobbyRoot.getModel( f78_arg0 ), "playlistId" )
	local f78_local1 = Engine[0x93AC5277B70CF75]()
	if f78_local0 then
		local f78_local2 = Engine[0x3ACB99DBAD24D55]( f78_local0 )
		local f78_local3 = f78_local2
		local f78_local4
		if f78_local2.requiredDLCMask & f78_local1 ~= f78_local2.requiredDLCMask then
			if f78_local2.mainMode == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
				f78_local4 = not Engine[0x3C915544ECCD34B]( f78_arg0 )
			else
				f78_local4 = f78_local3 and true
			end
		else
			f78_local4 = false
		end
		return f78_local4
	else
		return false
	end
end
CoD.SocialUtility.IsSelfMissingRequiredDLCForElementPlaylist = function ( f79_arg0, f79_arg1 )
	local f79_local0 = f79_arg1:getModel( f79_arg0, "playlist" )
	local f79_local1 = f79_local0 and f79_local0:get()
	if f79_local1 then
		local f79_local2 = Engine[0x93AC5277B70CF75]()
		local f79_local3 = Engine[0x3ACB99DBAD24D55]( f79_local1 )
		local f79_local4 = f79_local3
		local f79_local5
		if f79_local3.requiredDLCMask & f79_local2 ~= f79_local3.requiredDLCMask then
			if f79_local3.mainMode == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
				f79_local5 = not Engine[0x3C915544ECCD34B]( f79_arg0 )
			else
				f79_local5 = f79_local4 and true
			end
		else
			f79_local5 = false
		end
		return f79_local5
	else
		return false
	end
end
CoD.SocialUtility.IsPartyMissingUsedDLCForSelectedPlaylist = function ( f80_arg0 )
	local f80_local0 = DataSources.LobbyRoot.getModel( f80_arg0 )
	f80_local0 = f80_local0.playlistId
	if f80_local0 then
		f80_local0 = f80_local0:get()
	end
	if f80_local0 then
		local f80_local1 = Engine[0x3ACB99DBAD24D55]( f80_local0 )
		return f80_local1 and not CoD.MapUtility.AllMembersHaveDLCMask( CoD.LobbyUtility.GetClientList(), f80_local1.usedDLCMask, f80_local1.mainMode )
	else
		return false
	end
end
CoD.SocialUtility.IsPartyMissingUsedDLCForElementPlaylist = function ( f81_arg0, f81_arg1 )
	local f81_local0 = f81_arg1:getModel( f81_arg0, "playlist" )
	local f81_local1 = f81_local0 and f81_local0:get()
	if f81_local1 then
		local f81_local2 = Engine[0x3ACB99DBAD24D55]( f81_local1 )
		return f81_local2 and not CoD.MapUtility.AllMembersHaveDLCMask( CoD.LobbyUtility.GetClientList(), f81_local2.usedDLCMask, f81_local2.mainMode )
	else
		return false
	end
end
CoD.SocialUtility.IsUserMissingUsedDLCForSelectedPlaylist = function ( f82_arg0, f82_arg1 )
	local f82_local0 = CoD.SafeGetModelValue( DataSources.LobbyRoot.getModel( f82_arg0 ), "playlistId" )
	if f82_local0 then
		local f82_local1 = Engine[0x3ACB99DBAD24D55]( f82_local0 )
		local f82_local2 = CoD.SafeGetModelValue( f82_arg1 and f82_arg1:getModel(), "dlcBits" )
		if f82_local1 and f82_local2 then
			local f82_local3
			if f82_local1.usedDLCMask & f82_local2 ~= f82_local1.usedDLCMask then
				if f82_local1.mainMode == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
					f82_local3 = not Engine[0x3C915544ECCD34B]( f82_arg0 )
				else
					f82_local3 = true
				end
			else
				f82_local3 = false
			end
			return f82_local3
		end
		local f82_local3 = CoD.SafeGetModelValue( f82_arg1 and f82_arg1:getModel(), "blackopsPass" )
		if f82_local3 ~= nil then
			local f82_local4
			if f82_local1.usedDLCMask ~= Enum[0xE2A6806BB83D51C][0x8F57745D21DF973] then
				f82_local4 = not f82_local3
			else
				f82_local4 = false
			end
			return f82_local4
		end
	end
	return false
end
CoD.SocialUtility.IsSelfMissingUsedDLCForSelectedPlaylist = function ( f83_arg0, f83_arg1 )
	local f83_local0 = CoD.SafeGetModelValue( DataSources.LobbyRoot.getModel( f83_arg0 ), "playlistId" )
	local f83_local1 = Engine[0x93AC5277B70CF75]()
	if f83_local0 then
		local f83_local2 = Engine[0x3ACB99DBAD24D55]( f83_local0 )
		local f83_local3 = f83_local2
		local f83_local4
		if f83_local2.usedDLCMask & f83_local1 ~= f83_local2.usedDLCMask then
			if f83_local2.mainMode == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
				f83_local4 = not Engine[0x3C915544ECCD34B]( f83_arg0 )
			else
				f83_local4 = f83_local3 and true
			end
		else
			f83_local4 = false
		end
		return f83_local4
	else
		return false
	end
end
CoD.SocialUtility.IsSelfMissingUsedDLCForElementPlaylist = function ( f84_arg0, f84_arg1 )
	local f84_local0 = f84_arg1:getModel( f84_arg0, "playlist" )
	local f84_local1 = f84_local0 and f84_local0:get()
	if f84_local1 then
		local f84_local2 = Engine[0x93AC5277B70CF75]()
		local f84_local3 = Engine[0x3ACB99DBAD24D55]( f84_local1 )
		local f84_local4 = f84_local3
		local f84_local5
		if f84_local3.usedDLCMask & f84_local2 ~= f84_local3.usedDLCMask then
			if f84_local3.mainMode == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
				f84_local5 = not Engine[0x3C915544ECCD34B]( f84_arg0 )
			else
				f84_local5 = f84_local4 and true
			end
		else
			f84_local5 = false
		end
		return f84_local5
	else
		return false
	end
end
CoD.SocialUtility.IsMissingDLCForPlaylist = function ( f85_arg0, f85_arg1 )
	local f85_local0 = Engine[0x3ACB99DBAD24D55]( f85_arg0 )
	if f85_local0 and (f85_arg1 or CoDShared.GetLobbyDLCBits( Engine[0x80964E6C43E0C4B](), Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110] )) & f85_local0.usedDLCMask ~= f85_local0.usedDLCMask then
		return true
	else
		return false
	end
end
CoD.SocialUtility.IsPartyMissingDLCFriendUsing = function ( f86_arg0, f86_arg1 )
	local f86_local0 = CoD.SafeGetModelValue( f86_arg1 and f86_arg1:getModel(), "lobbyDLCBits" )
	local f86_local1 = CoD.SafeGetModelValue( f86_arg1 and f86_arg1:getModel(), "playlist" )
	if f86_local1 and CoD.SocialUtility.IsMissingDLCForPlaylist( f86_local1, f86_local0 ) then
		return true
	else
		local f86_local2 = CoD.SafeGetModelValue( f86_arg1 and f86_arg1:getModel(), "mapId" )
		local f86_local3 = f86_local2 and CoD.BaseUtility.GetMapDataFromMapID( f86_local2 )
		local f86_local4 = f86_local3 and f86_local3.session_mode
		if f86_local4 and f86_local4 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and Engine[0x3C915544ECCD34B]( f86_arg0 ) then
			return false
		else
			return not CoD.MapUtility.LobbyHasMap( f86_local2, f86_local0 )
		end
	end
end
CoD.SocialUtility.IsPartyMissingDLCFriendRequires = function ( f87_arg0, f87_arg1 )
	local f87_local0 = CoD.SafeGetModelValue( f87_arg1 and f87_arg1:getModel(), "lobbyDLCBits" )
	local f87_local1 = CoD.SafeGetModelValue( f87_arg1 and f87_arg1:getModel(), "playlist" )
	if f87_local1 then
		local f87_local2 = Engine[0x3ACB99DBAD24D55]( f87_local1 )
		if f87_local2 and (f87_local0 or CoDShared.GetLobbyDLCBits( Engine[0x80964E6C43E0C4B](), Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110] )) & f87_local2.requiredDLCMask ~= f87_local2.requiredDLCMask then
			return true
		end
	end
	local f87_local2 = CoD.SafeGetModelValue( f87_arg1 and f87_arg1:getModel(), "mapId" )
	local f87_local3 = f87_local2 and CoD.BaseUtility.GetMapDataFromMapID( f87_local2 )
	local f87_local4 = f87_local3 and f87_local3.session_mode
	if f87_local4 and f87_local4 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and Engine[0x3C915544ECCD34B]( f87_arg0 ) then
		return false
	end
	return not CoD.MapUtility.LobbyHasMap( f87_local2, f87_local0 )
end
CoD.SocialUtility.IsLocalXUID = function ( f88_arg0 )
	local f88_local0 = CoD.SafeGetModelValue( f88_arg0 and f88_arg0:getModel(), "xuid" )
	if f88_local0 then
		return Engine[0x41DC2CF4139D7]( f88_local0 )
	else
		return false
	end
end
CoD.SocialUtility.SocialPlayerInfoIsTrial = function ( f89_arg0, f89_arg1 )
	local f89_local0 = f89_arg0:getModel( f89_arg1, "trial" )
	local f89_local1 = f89_arg0:getModel( f89_arg1, "presence" )
	if f89_local0 and f89_local1 then
		return f89_local0:get() and f89_local1:get() ~= Enum[0x4BBA402DE649132][0xC14960E60DA36B7]
	else
		return false
	end
end
CoD.SocialUtility.DirectorLobbyMemberIsTrial = function ( f90_arg0, f90_arg1 )
	local f90_local0 = f90_arg0:getModel( f90_arg1, "trial" )
	if f90_local0 then
		return Engine[0x614D394F6F9A18D]( f90_local0 )
	else
		return false
	end
end
CoD.SocialUtility.SocialPlayersListPreLoad = function ( f91_arg0, f91_arg1 )
	f91_arg0.socialRootModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "socialRoot" )
	f91_arg0.cacheRootModel = Engine[0xA798E4552F5E872]( f91_arg0.socialRootModel, "cache" )
	f91_arg0.cacheXuid = Engine[0xA798E4552F5E872]( f91_arg0.cacheRootModel, "xuid" )
	f91_arg0.cacheGametype = Engine[0xA798E4552F5E872]( f91_arg0.cacheRootModel, "gametype" )
	f91_arg0.cacheMapid = Engine[0xA798E4552F5E872]( f91_arg0.cacheRootModel, "mapId" )
	f91_arg0.cacheModeparam = Engine[0xA798E4552F5E872]( f91_arg0.cacheRootModel, "modeparam" )
	f91_arg0.cacheDifficulty = Engine[0xA798E4552F5E872]( f91_arg0.cacheRootModel, "difficulty" )
	f91_arg0.cachePlaylist = Engine[0xA798E4552F5E872]( f91_arg0.cacheRootModel, "playlist" )
	f91_arg0.cacheParty = Engine[0xA798E4552F5E872]( f91_arg0.socialRootModel, "party" )
	f91_arg0.cachePartyUpdate = Engine[0xA798E4552F5E872]( f91_arg0.cacheParty, "update" )
	f91_arg0.cachePartyTotal = Engine[0xA798E4552F5E872]( f91_arg0.cacheParty, "total" )
	f91_arg0.cachePartyAvailable = Engine[0xA798E4552F5E872]( f91_arg0.cacheParty, "available" )
	f91_arg0.cachePartyLeader = Engine[0xA798E4552F5E872]( f91_arg0.cacheParty, "leader" )
	f91_arg0.cachePartyGamertags = {}
	for f91_local0 = 1, 18, 1 do
		f91_arg0.cachePartyGamertags[f91_local0] = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( f91_arg0.cacheParty, "pm_" .. f91_local0 ), "gamertag" )
		Engine[0x83C9B5DE1D9371]( f91_arg0.cachePartyGamertags[f91_local0], "" )
	end
	Engine[0x83C9B5DE1D9371]( f91_arg0.cacheXuid, Engine[0x9073FBE2D48C156]( "0" ) )
	Engine[0x83C9B5DE1D9371]( f91_arg0.cachePartyUpdate, 0 )
	Engine[0x83C9B5DE1D9371]( f91_arg0.cachePartyTotal, 0 )
	Engine[0x83C9B5DE1D9371]( f91_arg0.cachePartyAvailable, 0 )
	Engine[0x83C9B5DE1D9371]( f91_arg0.cachePartyLeader, "" )
end
