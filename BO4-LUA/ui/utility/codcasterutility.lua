CoD.CodCasterUtility = {}
CoD.CodCasterUtility.codcasterTeamIdentityColorTable = "mp_codcaster_color_list"
CoD.CodCasterUtility.codcasterTeamIdentityLogoTable = "mp_codcaster_logo_list"
CoD.CodCasterUtility.TeamIdentity = {}
CoD.CodCasterUtility.Announcement = {}
CoD.CodCasterUtility.Announcement.BannerSetting = LuaEnum.createEnum("All", "MajorOnly", "MinorOnly", "Off")
local f0_local0 = 4
local f0_local1 = 112
CoD.CodCasterUtility.GetAttackingTeamColor = function(f1_arg0)
	local f1_local0 = nil
	if f1_arg0 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		f1_local0 = CoD.TeamUtility.GetTeamFactionColor(Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68])
	else
		f1_local0 = CoD.TeamUtility.GetTeamFactionColor(Enum[0x13A4717E5AC547][0x2A34B055ADD98AB])
	end
	return f1_local0
end
CoD.CodCasterUtility.GetCodCasterTeamColorList = function(f2_arg0)
	local f2_local0 = {}
	local f2_local1 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f2_arg0), "TeamIdentity.ColorList")
	local f2_local2 = Engine[0xA517ED98860212F](CoD.CodCasterUtility.codcasterTeamIdentityColorTable)
	for f2_local3 = 0, f2_local2 - 1, 1 do
		local f2_local6 = Engine[0x7ECEFBF8EF24F77](CoD.CodCasterUtility.codcasterTeamIdentityColorTable, "id", f2_local3, "colorR")
		local f2_local7 = Engine[0x7ECEFBF8EF24F77](CoD.CodCasterUtility.codcasterTeamIdentityColorTable, "id", f2_local3, "colorG")
		local f2_local8 = Engine[0x7ECEFBF8EF24F77](CoD.CodCasterUtility.codcasterTeamIdentityColorTable, "id", f2_local3, "colorB")
		local f2_local9 = Engine[0xA798E4552F5E872](f2_local1, "color_" .. f2_local3)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f2_local9, "id"), f2_local3)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f2_local9, "color"), string.format("%d %d %d", f2_local6, f2_local7, f2_local8))
		table.insert(f2_local0, f2_local9)
	end
	return f2_local0
end
CoD.CodCasterUtility.GetCodCasterTeamColorInformation = function(f3_arg0, f3_arg1, f3_arg2)
	if not CoD.CodCasterUtility.TeamIdentity.ColorList then
		CoD.CodCasterUtility.TeamIdentity.ColorList = CoD.CodCasterUtility.GetCodCasterTeamColorList(f3_arg0)
	end
	local f3_local0 = Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f3_arg0), "TeamIdentity.ColorList"), "color_" .. f3_arg1)
	if not f3_local0 then
		return nil
	else
		local f3_local1 = Engine[0x40E824FE270E174](f3_local0, f3_arg2)
		if not f3_local1 then
			return nil
		else
			return Engine[0x614D394F6F9A18D](f3_local1)
		end
	end
end
CoD.CodCasterUtility.GetCodCasterTeamLogoList = function(f4_arg0)
	local f4_local0 = {}
	local f4_local1 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f4_arg0), "TeamIdentity.LogoList")
	local f4_local2 = Engine[0xA517ED98860212F](CoD.CodCasterUtility.codcasterTeamIdentityLogoTable)
	for f4_local3 = 0, f4_local2 - 1, 1 do
		local f4_local6 = Engine[0x1C6D5C5915588E3](CoD.CodCasterUtility.codcasterTeamIdentityLogoTable, "id", f4_local3, "logo_name")
		local f4_local7 = Engine[0x1C6D5C5915588E3](CoD.CodCasterUtility.codcasterTeamIdentityLogoTable, "id", f4_local3, "logo_icon")
		local f4_local8 = Engine[0xA798E4552F5E872](f4_local1, "logo_" .. f4_local3)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f4_local8, "id"), f4_local3)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f4_local8, "name"), f4_local6)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f4_local8, "ref"), f4_local7)
		table.insert(f4_local0, f4_local8)
	end
	return f4_local0
end
CoD.CodCasterUtility.GetCodCasterTeamLogoInformation = function(f5_arg0, f5_arg1, f5_arg2)
	if not CoD.CodCasterUtility.TeamIdentity.LogoList then
		CoD.CodCasterUtility.TeamIdentity.LogoList = CoD.CodCasterUtility.GetCodCasterTeamLogoList(f5_arg0)
	end
	local f5_local0 = Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f5_arg0), "TeamIdentity.LogoList"), "logo_" .. f5_arg1)
	if not f5_local0 then
		return nil
	else
		local f5_local1 = Engine[0x40E824FE270E174](f5_local0, f5_arg2)
		if not f5_local1 then
			return nil
		else
			return Engine[0x614D394F6F9A18D](f5_local1)
		end
	end
end
CoD.CodCasterUtility.GetCodCasterFactionIcon = function(f6_arg0, f6_arg1)
	local f6_local0 = nil
	if f6_arg1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		f6_local0 = "team1"
	elseif f6_arg1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		f6_local0 = "team2"
	end
	if f6_local0 then
		local f6_local1 = CoD.CodCasterUtility.GetCodCasterTeamLogoInformation(f6_arg0, CoD.ShoutcasterProfileVarValue(f6_arg0, "shoutcaster_fe_" .. f6_local0 .. "_icon"), "ref")
		if f6_local1 ~= nil then
			return f6_local1
		end
	end
	return CoD.CodCasterUtility.GetDefaultCodCasterFactionIcon(f6_arg1)
end
CoD.CodCasterUtility.GetDefaultCodCasterFactionIcon = function(f7_arg0)
	if f7_arg0 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		return "uie_t7_codcaster_faction1"
	elseif f7_arg0 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
		return "uie_t7_codcaster_faction2"
	else
		return ""
	end
end
CoD.CodCasterUtility.GetStandardOrCodCasterTeam = function(f8_arg0)
	local f8_local0 = nil
	if IsCodCaster(f8_arg0) then
		f8_local0 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
	else
		local f8_local1 = DataSources.Factions.getModel(f8_arg0)
		f8_local1 = f8_local1.actualTeam:get()
		if f8_local1 then
			f8_local0 = f8_local1
		else
			f8_local0 = CoD.TeamUtility.GetTeamIDForController(f8_arg0)
		end
	end
	return f8_local0
end
DataSourceHelpers.PerControllerDataSourceSetup(
	"CodCaster",
	"CodCaster",
	function(f9_arg0, f9_arg1)
		f9_arg0:create("showLoadout")
		f9_arg0:create("showFullscreenMap")
		f9_arg0:create("showKeyboard")
		f9_arg0:create("showPortraitList")
		f9_arg0:create("showPlayerList")
		f9_arg0:create("showSettingsSideBar")
		f9_arg0:create("showQuickSettingsSideBar")
		f9_arg0:create("profileSettingsUpdated")
		f9_arg0:create("showCodCasterScoreboard")
		DataSources.CodCaster.initialize(f9_arg1)
	end,
	false,
	{
		initialize = function(f10_arg0)
			local f10_local0 = DataSources.CodCaster.getModel(f10_arg0)
			f10_local0.showLoadout:set(false)
			f10_local0.showFullscreenMap:set(false)
			f10_local0.showKeyboard:set(false)
			f10_local0.showPortraitList:set(true)
			f10_local0.showPlayerList:set(false)
			f10_local0.showSettingsSideBar:set(0)
			f10_local0.showQuickSettingsSideBar:set(0)
			f10_local0.profileSettingsUpdated:set(0)
		end,
	}
)
CoD.CodCasterUtility.SetupUIModels = function(f11_arg0)
	DataSources.CodCaster.initialize(f11_arg0)
end
CoD.CodCasterUtility.Options_ItemSelected = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	if CoD.ShoutcasterProfileVarValue(f12_arg2, f12_arg3) == f12_arg1.value then
		return
	end
	CoD.SetShoutcasterProfileVarValue(f12_arg2, f12_arg3, f12_arg1.value)
	if f12_arg1.valueChangedCallback then
		f12_arg1.valueChangedCallback(f12_arg4, f12_arg2, f12_arg3, f12_arg1.value)
	end
end
CoD.CodCasterUtility.Options_RevertItemSelected = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5)
	local f13_local0 = CoD.OptionsUtility.GetCustomProfileSelection(f13_arg2, f13_arg1.options, CoD.ShoutcasterProfileVarValue(f13_arg2, f13_arg3))
	local f13_local1, f13_local2 = f13_arg0.Slider:getRowAndColumnForIndex(Engine[0x614D394F6F9A18D](f13_arg0:getModel(f13_arg2, "currentSelection")) - 1)
	f13_arg0.Slider:setActiveIndex(f13_local1, f13_local2, 0)
end
CoD.CodCasterUtility.Options_GetProfileSelection = function(f14_arg0, f14_arg1, f14_arg2)
	return CoD.OptionsUtility.GetCustomProfileSelection(f14_arg0, f14_arg1, CoD.ShoutcasterProfileVarValue(f14_arg0, f14_arg2))
end
CoD.CodCasterUtility.CodCasterEnabledAndProfileVarEqualTo = function(f15_arg0, f15_arg1, f15_arg2)
	return CoD.IsShoutcaster(f15_arg0) and CoD.ShoutcasterProfileVarBool(f15_arg0, f15_arg1) == f15_arg2
end
CoD.CodCasterUtility.CodCasterIsInAerialCam = function(f16_arg0)
	local f16_local0 = Engine[0xDD333420C49E6D0](f16_arg0, Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA])
	if not f16_local0 then
		f16_local0 = Engine[0x2548878F5D63D47](f16_arg0)
	end
	return f16_local0
end
CoD.CodCasterUtility.IsAerialCamAllowed = function()
	return Engine[0xEA8900B6E5F7DAE]()
end
CoD.CodCasterUtility.CodCasterShowPlayerList = function(f18_arg0, f18_arg1)
	local f18_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f18_arg1), "CodCaster.showPlayerList")
	local f18_local1 = f18_local0:get()
	if Engine[0xDD333420C49E6D0](f18_arg1, Enum[0x7F032C2EF103A1A][0x3DA38CAFF843C18]) and f18_arg0.CodCasterPlayerList.currentState == "DefaultState" then
		if not f18_local1 then
			ToggleControllerModelValueBoolean(f18_arg1, "codcaster.showPlayerList")
		end
		return true
	else
		return f18_local1
	end
end
CoD.CodCasterUtility.CodCasterShowPortraitList = function(f19_arg0)
	local f19_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f19_arg0), "CodCaster.showPortraitList")
	local f19_local1 = f19_local0:get()
	if Engine[0xDD333420C49E6D0](f19_arg0, Enum[0x7F032C2EF103A1A][0x3DA38CAFF843C18]) then
		return false
	else
		return f19_local1
	end
end
CoD.CodCasterUtility.CharacterIndexForClientNum = function(f20_arg0, f20_arg1)
	if f20_arg1 == -1 then
		return 0
	else
		local f20_local0 = Engine[0x40145EEB2E913D2](f20_arg0, f20_arg1)
		if f20_local0 ~= nil then
			return f20_local0
		else
			return 0
		end
	end
end
CoD.CodCasterUtility.GetPrimaryWeaponImage = function(f21_arg0, f21_arg1)
	local f21_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f21_arg0), "primaryWeapon.item")
	return f21_local0:get()
end
CoD.CodCasterUtility.GetSecondaryWeaponImage = function(f22_arg0, f22_arg1)
	local f22_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f22_arg0), "secondaryWeapon.item")
	return f22_local0:get()
end
CoD.CodCasterUtility.GetPrimaryWeaponName = function(f23_arg0, f23_arg1)
	local f23_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f23_arg0), "primaryWeapon.itemIndex")
	return Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f23_local0:get(), Enum[0x6EB546760F890D2][0x3057ABF96AF8289], Engine[0x3EAC408F958FF05]()))
end
CoD.CodCasterUtility.GetSecondaryWeaponName = function(f24_arg0, f24_arg1)
	local f24_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f24_arg0), "secondaryWeapon.indexIndex")
	return Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f24_local0:get(), Enum[0x6EB546760F890D2][0x3057ABF96AF8289], Engine[0x3EAC408F958FF05]()))
end
CoD.CodCasterUtility.GetPrimaryWeaponAttachment0 = function(f25_arg0, f25_arg1)
	local f25_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f25_arg0), "primaryWeapon.attachment0")
	return Engine[0xF9F1239CFD921FE](f25_local0:get())
end
CoD.CodCasterUtility.GetPerkImage = function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
	local f26_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f26_arg0), "perks.perk" .. f26_arg1 .. "_" .. f26_arg2 .. ".image")
	return f26_local0:get()
end
CoD.CodCasterUtility.IsCodCasterEnabled = function()
	return true
end
CoD.CodCasterUtility.AreCodCasterAssigned = function(f28_arg0)
	local f28_local0 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]))
	for f28_local4, f28_local5 in ipairs(f28_local0.sessionClients) do
		if f28_local5.team == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			return true
		end
	end
	return false
end
CoD.CodCasterUtility.IsCodCasterAssigned = function(f29_arg0)
	local f29_local0 = Engine[0x4DF5CFBC1771947](f29_arg0)
	local f29_local1 = Engine[0xE4D2F32833CFA6C](CoD.AARUtility.GetInGameClientNum(f29_arg0))
	if f29_local1.team:get() == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
		return true
	else
		return false
	end
end
CoD.CodCasterUtility.IsCodCasterOrAssigned = function(f30_arg0)
	local f30_local0 = IsCodCaster(f30_arg0)
	if not f30_local0 then
		f30_local0 = CoD.CodCasterUtility.IsCodCasterAssigned(f30_arg0)
	end
	return f30_local0
end
CoD.CodCasterUtility.IsCodCasterSupportedGameType = function(f31_arg0)
	local f31_local0 = Engine[0x8DF2E5447F384B9]()
	f31_local0 = f31_local0["MapVote.mapVoteGameModeNext"].get(f31_local0["MapVote.mapVoteGameModeNext"])
	if f31_local0 == 0x8915B07B53BB7FA or f31_local0 == 0x5194D18FAD99705 then
		return false
	else
		return true
	end
end
CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo = function(f32_arg0, f32_arg1, f32_arg2)
	if not CoD.IsShoutcaster(f32_arg0) then
		return false
	end
	local f32_local0 = CoD.ShoutcasterProfileVarValue(f32_arg0, f32_arg1)
	local f32_local1
	if f32_local0 == nil or f32_local0 ~= f32_arg2 then
		f32_local1 = false
	else
		f32_local1 = true
	end
	return f32_local1
end
CoD.CodCasterUtility.Announcement.DisplayQueued = function(f33_arg0, f33_arg1, f33_arg2)
	return function()
		if f33_arg0.nextAnnouncement == nil then
			return
		else
			CoD.CodCasterUtility.Announcement.ShowAnnouncement(f33_arg0, f33_arg1, f33_arg0.nextAnnouncement.announcementInfo, f33_arg2)
			f33_arg0.nextAnnouncement = nil
		end
	end
end
CoD.CodCasterUtility.Announcement.ExtraDataToStringParameter = function(f35_arg0, f35_arg1)
	if f35_arg0 <= 0 then
		return nil
	elseif f35_arg1 == 0xE6607166B31C6DD then
		if f35_arg0 == 1 then
			return "A"
		elseif f35_arg0 == 2 then
			return "B"
		elseif f35_arg0 == 3 then
			return "C"
		elseif f35_arg0 == 4 then
			return "D"
		end
	elseif f35_arg1 == 0x3E164CE08D58747 then
		return Engine[0xF9F1239CFD921FE](Engine[0xEFE2F6436680CF3](f35_arg0, "CS_LOCALIZED_STRINGS"))
	end
	return f35_arg0
end
CoD.CodCasterUtility.Announcement.ModelValueToData = function(f36_arg0, f36_arg1, f36_arg2)
	local f36_local0, f36_local1, f36_local2, f36_local3 = unpack(CoD.GetScriptNotifyData(f36_arg2))
	return f36_local0, CoD.TeamUtility.GetTeamFactionColor(f36_local1), f36_local2, f36_local3, f36_local1
end
CoD.CodCasterUtility.Announcement.Data = nil
CoD.CodCasterUtility.Announcement.OnNewAnnouncement = function(f37_arg0, f37_arg1, f37_arg2)
	return function(f38_arg0)
		if f38_arg0:get() ~= 0xF8D0153AA606F7D then
			return
		end
		local f38_local0 = {}
		f38_local0.announcementID, f38_local0.teamColor, f38_local0.playerClientNum, f38_local0.extraData, f38_local0.teamId = CoD.CodCasterUtility.Announcement.ModelValueToData(f37_arg0, f37_arg1, f38_arg0)
		if CoD.CodCasterUtility.Announcement.Data == nil then
			CoD.CodCasterUtility.Announcement.Data = Engine[0xE00B2F29271C60B](0xBAC2BE54C1FC57A)
		end
		local f38_local1 = CoD.CodCasterUtility.Announcement.Data.announcementslist[f38_local0.announcementID]
		if f38_local1 == nil then
			return
		end
		local f38_local2 = f38_local1[0x5B6EA8C35AC1E89]
		if f38_local2 == nil then
			error("LUI Error: invalid broadcaster announcement ID " .. f38_local0.announcementID)
			return
		elseif f38_local2 < 0 then
			return
		elseif f37_arg0.lastPriority == -1 then
			CoD.CodCasterUtility.Announcement.ShowAnnouncement(f37_arg0, f37_arg1, f38_local0, f37_arg2)
			f37_arg0.lastPriority = f38_local2
		else
			local f38_local3 = {
				announcementInfo = f38_local0,
				priority = f38_local2,
			}
			if not (f37_arg0.nextAnnouncement == nil or f37_arg0.nextAnnouncement.priority > f38_local2) or f37_arg0.lastPriority <= f38_local2 then
				f37_arg0.nextAnnouncement = f38_local3
			end
		end
	end
end
CoD.CodCasterUtility.PostLoad = function(f39_arg0, f39_arg1)
	f39_arg0.nextAnnouncement = nil
	f39_arg0.lastPriority = -1
	local f39_local0 = {
		announcementFeedHeader = f39_arg0.AnnouncementFeedText.AnnouncementFeedHeader,
		announcementFeed = f39_arg0.AnnouncementFeedText.AnnouncementFeed,
	}
	f39_arg0.AnnouncementImageBackground:setAlpha(0)
	f39_local0.announcementImageBackground = f39_arg0.AnnouncementImageBackground
	f39_arg0.AnnouncementImageHighlightRight:setAlpha(0)
	f39_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
	f39_local0.announcementImageHighlightRight = f39_arg0.AnnouncementImageHighlightRight
	f39_local0.announcementImageHighlightLeft = f39_arg0.AnnouncementImageHighlightLeft
	f39_arg0:subscribeToGlobalModel(f39_arg1, "PerController", "scriptNotify", CoD.CodCasterUtility.Announcement.OnNewAnnouncement(f39_arg0, f39_arg1, f39_local0))
end
CoD.CodCasterUtility.Announcement.ShowAnnouncement = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	local f40_local0 = CoD.CodCasterUtility.Announcement.Data.announcementslist[f40_arg2.announcementID]
	if f40_local0 == nil then
		return
	end
	local f40_local1 = f40_arg3.announcementImageBackground:getParent()
	local f40_local2 = f40_local0[0xDE167907C171A]
	local f40_local3 = f40_local0[0x8A3366583423D67]
	local f40_local4 = math.floor(f40_local0[0x1C74A75EBDD8D38] * 1000) + 400
	local f40_local5 = nil
	local f40_local6 = CoD.CodCasterUtility.Announcement.ExtraDataToStringParameter(f40_arg2.extraData, f40_local0[0xFA4B83BCF32178])
	if f40_local6 then
		f40_local5 = Engine[0xED84C33EC5F01EA](f40_local2, f40_local6)
	else
		f40_local5 = Engine[0xED84C33EC5F01EA](f40_local2)
	end
	f40_arg3.announcementFeed:setText(f40_local5)
	local f40_local7 = ""
	if f40_arg2.playerClientNum >= 0 then
		f40_local7 = Engine[0xF152471A3D15A55](f40_arg1, f40_arg2.playerClientNum) .. GetClientName(f40_arg1, f40_arg2.playerClientNum) .. " "
		local f40_local8 = nil
		local f40_local9 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f40_arg1), "deadSpectator.playerIndex")
		if f40_local9 then
			f40_local8 = Engine[0x614D394F6F9A18D](f40_local9)
		end
		if f40_local8 ~= nil and f40_local8 == f40_arg2.playerClientNum then
			f40_arg3.announcementFeedHeader:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
		else
			f40_arg3.announcementFeedHeader:setRGB(f40_arg2.teamColor)
		end
	elseif f40_arg2.teamId == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] or f40_arg2.teamId == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
		f40_local7 = CoD.TeamUtility.GetTeamNameForTeamEnum(f40_arg1, f40_arg2.teamId) .. " "
		f40_arg3.announcementFeedHeader:setRGB(f40_arg2.teamColor)
	end
	f40_arg3.announcementFeedHeader:setText(f40_local7)
	local f40_local8 = f40_arg3.announcementFeedHeader:getTextWidth()
	local f40_local9 = f40_arg3.announcementFeed:getTextWidth()
	local f40_local10, f40_local11, f40_local12, f40_local13 = f40_arg0:getLocalLeftRight()
	local f40_local14, f40_local15 = f40_arg0:getLocalSize()
	local f40_local16 = (f40_local14 - f40_local8 - f40_local9) / 2
	local f40_local17, f40_local18, f40_local19, f40_local20 = f40_arg3.announcementFeedHeader:getLocalLeftRight()
	f40_arg3.announcementFeedHeader:setLeftRight(f40_local10, f40_local11, f40_local12 + f40_local16, f40_local12 + f40_local16 + f40_local8)
	f40_arg3.announcementFeed:setLeftRight(f40_local10, f40_local11, f40_local13 - f40_local16 - f40_local9, f40_local13 - f40_local16)
	if not ScoreboardVisible(f40_arg1) and IsCodCasterProfileValueEqualTo(f40_arg1, "shoutcaster_ds_teamscore", 1) and IsCodCasterProfileValueEqualTo(f40_arg1, "shoutcaster_qs_playerlist", 1) and IsCodCasterProfileValueEqualTo(f40_arg1, "shoutcaster_ds_notification_announcements", 1) then
		if f40_arg2.teamId == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f40_arg3.announcementImageHighlightRight:setRGB(f40_arg2.teamColor)
			f40_local1:playClip("OnTeam2")
		elseif f40_arg2.teamId == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f40_arg3.announcementImageHighlightLeft:setRGB(f40_arg2.teamColor)
			f40_local1:playClip("OnTeam1")
		end
	end
	f40_arg0:addElement(LUI.UITimer.newElementTimer(f40_local4, true, function()
		if f40_arg2.teamId == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f40_arg3.announcementImageHighlightRight:setRGB(f40_arg2.teamColor)
			f40_local1:playClip("OffTeam2")
		elseif f40_arg2.teamId == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f40_arg3.announcementImageHighlightLeft:setRGB(f40_arg2.teamColor)
			f40_local1:playClip("OffTeam1")
		end
		f40_arg0.announcementWaitTween = nil
		f40_arg0.lastPriority = -1
		f40_arg0:addElement(LUI.UITimer.newElementTimer(200, true, CoD.CodCasterUtility.Announcement.DisplayQueued(f40_arg0, f40_arg1, f40_arg3)))
	end))
end
DataSources.KillstreakList = {
	getCount = function(f42_arg0)
		return 3
	end,
	getItem = function(f43_arg0, f43_arg1, f43_arg2)
		local f43_local0 = f43_arg2 - 1
		local f43_local1 = Engine[0x40E824FE270E174]
		local f43_local2 = f43_arg1:getParent()
		return f43_local1(f43_local2:getModel(), "killstreaks.killstreak" .. f43_local0)
	end,
	prepare = function() end,
}
DataSources.TalentList = {
	prepare = function(f45_arg0, f45_arg1, f45_arg2)
		f45_arg1.talents = {}
		local f45_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f45_arg0), "talents")
		local f45_local1 = Engine[0x40E824FE270E174](f45_local0, "count")
		local f45_local2 = f45_local1:get()
		for f45_local3 = 0, f45_local2 - 1, 1 do
			table.insert(f45_arg1.talents, Engine[0x40E824FE270E174](f45_local0, "talent" .. f45_local3))
		end
	end,
	getCount = function(f46_arg0)
		return #f46_arg0.talents
	end,
	getItem = function(f47_arg0, f47_arg1, f47_arg2)
		return f47_arg1.talents[f47_arg2]
	end,
}
DataSources.PerkList = {
	prepare = function(f48_arg0, f48_arg1, f48_arg2)
		f48_arg1.perks = {}
		local f48_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f48_arg0), "talents")
		local f48_local1 = Engine[0x40E824FE270E174](f48_local0, "count")
		local f48_local2 = f48_local1:get()
		for f48_local3 = 0, f48_local2 - 1, 1 do
			local f48_local6 = Engine[0x40E824FE270E174](f48_local0, "talent" .. f48_local3)
			local f48_local7 = Engine[0x40E824FE270E174](f48_local6, "isPerk")
			if f48_local7:get() then
				table.insert(f48_arg1.perks, f48_local6)
			end
		end
	end,
	getCount = function(f49_arg0)
		return #f49_arg0.perks
	end,
	getItem = function(f50_arg0, f50_arg1, f50_arg2)
		return f50_arg1.perks[f50_arg2]
	end,
}
DataSources.EquipmentList = {
	prepare = function(f51_arg0, f51_arg1, f51_arg2)
		f51_arg1.equipments = {}
		local f51_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f51_arg0), "talents")
		local f51_local1 = Engine[0x40E824FE270E174](f51_local0, "count")
		local f51_local2 = f51_local1:get()
		for f51_local3 = 0, f51_local2 - 1, 1 do
			local f51_local6 = Engine[0x40E824FE270E174](f51_local0, "talent" .. f51_local3)
			local f51_local7 = Engine[0x40E824FE270E174](f51_local6, "isPerk")
			f51_local7 = f51_local7:get()
			local f51_local8 = Engine[0x40E824FE270E174](f51_local6, "isSpecialIssue")
			if not f51_local7 and not f51_local8:get() then
				table.insert(f51_arg1.equipments, f51_local6)
			end
		end
	end,
	getCount = function(f52_arg0)
		return #f52_arg0.equipments
	end,
	getItem = function(f53_arg0, f53_arg1, f53_arg2)
		return f53_arg1.equipments[f53_arg2]
	end,
}
CoD.CodCasterUtility.FillAttachmentList = function(f54_arg0, f54_arg1)
	local f54_local0 = Engine[0x40E824FE270E174](f54_arg0, "attachmentCount")
	local f54_local1 = f54_local0:get()
	if f54_local1 then
		for f54_local2 = 0, f54_local1 - 1, 1 do
			table.insert(f54_arg1, Engine[0x40E824FE270E174](f54_arg0, "attachmentImage" .. f54_local2))
		end
	end
end
DataSources.PrimaryWeaponAttachmentImageList = {
	prepare = function(f55_arg0, f55_arg1, f55_arg2)
		f55_arg1.attachments = {}
		CoD.CodCasterUtility.FillAttachmentList(Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f55_arg0), "primaryWeapon"), f55_arg1.attachments)
	end,
	getCount = function(f56_arg0)
		return #f56_arg0.attachments
	end,
	getItem = function(f57_arg0, f57_arg1, f57_arg2)
		return f57_arg1.attachments[f57_arg2]
	end,
}
DataSources.SecondaryWeaponAttachmentImageList = {
	prepare = function(f58_arg0, f58_arg1, f58_arg2)
		f58_arg1.attachments = {}
		CoD.CodCasterUtility.FillAttachmentList(Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f58_arg0), "secondaryWeapon"), f58_arg1.attachments)
	end,
	getCount = function(f59_arg0)
		return #f59_arg0.attachments
	end,
	getItem = function(f60_arg0, f60_arg1, f60_arg2)
		return f60_arg1.attachments[f60_arg2]
	end,
}
CoD.CodCasterUtility.GetWildcardsList = function(f61_arg0, f61_arg1, f61_arg2)
	local f61_local0 = {}
	local f61_local1 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f61_arg0), "wildcards")
	local f61_local2 = Engine[0x40E824FE270E174](f61_local1, "count")
	local f61_local3 = f61_local2:get()
	for f61_local4 = 0, f61_local3 - 1, 1 do
		local f61_local7 = Engine[0x40E824FE270E174](f61_local1, "wildcard" .. f61_local4)
		local f61_local8 = Engine[0x40E824FE270E174](f61_local7, "name")
		f61_local8 = f61_local8:get()
		if f61_arg1 then
			if f61_arg1(f61_local8) then
				table.insert(f61_local0, f61_local7)
			end
		end
		table.insert(f61_local0, f61_local7)
	end
	if f61_arg2 ~= nil then
		local f61_local4 = f61_local1:create(f61_arg2)
		f61_local4:set(#f61_local0)
	end
	return f61_local0
end
DataSources.WildcardList = {
	prepare = function(f62_arg0, f62_arg1, f62_arg2)
		f62_arg1.wildcards = CoD.CodCasterUtility.GetWildcardsList(f62_arg0)
	end,
	getCount = function(f63_arg0)
		return #f63_arg0.wildcards
	end,
	getItem = function(f64_arg0, f64_arg1, f64_arg2)
		return f64_arg1.wildcards[f64_arg2]
	end,
}
DataSources.WildcardPrimaryList = {
	prepare = function(f65_arg0, f65_arg1, f65_arg2)
		f65_arg1.wildcards = CoD.CodCasterUtility.GetWildcardsList(f65_arg0, CoD.BonuscardUtility.IsBonuscardPrimary, "primaryCount")
	end,
	getCount = function(f66_arg0)
		return #f66_arg0.wildcards
	end,
	getItem = function(f67_arg0, f67_arg1, f67_arg2)
		return f67_arg1.wildcards[f67_arg2]
	end,
}
DataSources.WildcardSecondaryList = {
	prepare = function(f68_arg0, f68_arg1, f68_arg2)
		f68_arg1.wildcards = CoD.CodCasterUtility.GetWildcardsList(f68_arg0, CoD.BonuscardUtility.IsBonuscardSecondary, "secondaryCount")
	end,
	getCount = function(f69_arg0)
		return #f69_arg0.wildcards
	end,
	getItem = function(f70_arg0, f70_arg1, f70_arg2)
		return f70_arg1.wildcards[f70_arg2]
	end,
}
DataSources.WildcardPerksList = {
	prepare = function(f71_arg0, f71_arg1, f71_arg2)
		f71_arg1.wildcards = CoD.CodCasterUtility.GetWildcardsList(f71_arg0, CoD.BonuscardUtility.IsBonuscardPerk, "customCount")
	end,
	getCount = function(f72_arg0)
		return #f72_arg0.wildcards
	end,
	getItem = function(f73_arg0, f73_arg1, f73_arg2)
		return f73_arg1.wildcards[f73_arg2]
	end,
}
CoD.CodCasterUtility.GetPortraitListHoverAndSelectedIndices = function(f74_arg0, f74_arg1, f74_arg2)
	local f74_local0 = nil
	for f74_local1 = 1, f74_arg0.itemCount, 1 do
		local f74_local4 = f74_arg0.layoutItems[1][f74_local1]
		if f74_local4 == nil then
			return nil, nil
		elseif f74_local4.PlayerPortraitFocusTop.currentState == "PlayerSelected" then
			f74_arg1 = f74_local1 + f74_arg2
		end
		if f74_local4.hovered then
			f74_local0 = f74_local1 + f74_arg2
		end
	end
	return f74_local0, f74_arg1
end
CoD.CodCasterUtility.GetPlayerListNextSelectedInNonTeamBased = function(f75_arg0, f75_arg1)
	local f75_local0 = LuaDefine.INVALID_CLIENT_INDEX
	local f75_local1 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f75_arg1), "hudItems.codcaster.nextClient")
	f75_local0 = f75_local1:get()
	if f75_local0 == LuaDefine.INVALID_CLIENT_INDEX then
		local f75_local2 = Engine[0x4DF5CFBC1771947](f75_arg1)
		f75_local0 = f75_local2.deadSpectator.playerIndex:get()
	end
	for f75_local2 = 1, f75_arg0.itemCount, 1 do
		if Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f75_arg0.layoutItems[f75_local2][1]:getModel(), "clientNum")) == f75_local0 then
			return f75_local2
		end
	end
	return LuaDefine.INVALID_CLIENT_INDEX
end
CoD.CodCasterUtility.GetPortraitListHoverIndex = function(f76_arg0, f76_arg1)
	local f76_local0, f76_local1 = CoD.CodCasterUtility.GetPortraitListHoverAndSelectedIndices(f76_arg0, nil, 0)
	if f76_local0 == nil then
		f76_local0, f76_local1 = CoD.CodCasterUtility.GetPortraitListHoverAndSelectedIndices(f76_arg1, f76_local1, f76_arg0.itemCount)
	end
	if f76_local0 == nil then
		f76_local0 = f76_local1
	end
	return f76_local0
end
CoD.CodCasterUtility.SetPortraitHoverState = function(f77_arg0, f77_arg1, f77_arg2)
	f77_arg1.hovered = f77_arg2
	if f77_arg2 then
		local f77_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f77_arg1:getModel(), "clientNum"))
		Dvar[0x69E29B87C17AED9]:set(f77_local0)
		local f77_local1 = Engine[0x4DF5CFBC1771947](f77_arg0)
		local f77_local2 = f77_local1:create("hudItems.codcaster.nextClient")
		f77_local2:set(f77_local0)
		f77_arg1.PlayerPortraitHoverTop.topselector:setAlpha(0.5)
		f77_arg1.PlayerPortraitHoverBottom.bottomselector:setAlpha(0.5)
	else
		f77_arg1.PlayerPortraitHoverTop.topselector:setAlpha(0)
		f77_arg1.PlayerPortraitHoverBottom.bottomselector:setAlpha(0)
	end
end
CoD.CodCasterUtility.OnDpadLeft = function(f78_arg0, f78_arg1)
	if CoDShared.IsGametypeTeamBased() then
		CoD.CodCasterUtility.OnDpadLeftTeamBased(f78_arg0, f78_arg1)
	else
		CoD.CodCasterUtility.OnDpadLeftNonTeamBased(f78_arg0, f78_arg1)
	end
end
CoD.CodCasterUtility.WrapAroundValue = function(f79_arg0, f79_arg1, f79_arg2)
	assert(f79_arg1 <= f79_arg2)
	if f79_arg0 < f79_arg1 then
		f79_arg0 = f79_arg2 - (f79_arg1 - f79_arg0 - 1) % (f79_arg2 - f79_arg1 + 1)
	elseif f79_arg2 < f79_arg0 then
		f79_arg0 = f79_arg1 + (f79_arg0 - f79_arg2 - 1) % (f79_arg2 - f79_arg1 + 1)
	end
	return f79_arg0
end
CoD.CodCasterUtility.IsPlayerAtIndexAlive = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3, f80_arg4)
	local f80_local0 = nil
	if f80_arg2.itemCount < f80_arg4 then
		f80_local0 = f80_arg3.layoutItems[1][f80_arg4 - f80_arg2.itemCount]
	elseif f80_arg3 ~= nil then
		f80_local0 = f80_arg2.layoutItems[1][f80_arg4]
	else
		f80_local0 = f80_arg2.layoutItems[f80_arg4][1]
	end
	local f80_local1 = Engine[0xE4D2F32833CFA6C](Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f80_local0:getModel(), "clientNum")))
	f80_local1 = f80_local1:create("health.healthValue")
	return f80_local1:get() > 0
end
CoD.CodCasterUtility.FindNextAlivePlayer = function(f81_arg0, f81_arg1, f81_arg2, f81_arg3, f81_arg4, f81_arg5)
	local f81_local0 = f81_arg2.itemCount
	local f81_local1 = 0
	if f81_arg3 ~= nil then
		f81_local1 = f81_arg3.itemCount
	end
	for f81_local2 = 1, f81_local0 + f81_local1, 1 do
		local f81_local5 = CoD.CodCasterUtility.WrapAroundValue(f81_arg4 + f81_local2 * f81_arg5, 1, f81_local0 + f81_local1)
		if CoD.CodCasterUtility.IsPlayerAtIndexAlive(f81_arg0, f81_arg1, f81_arg2, f81_arg3, f81_local5) then
			return f81_local5
		end
	end
end
CoD.CodCasterUtility.OnDpadLeftTeamBased = function(f82_arg0, f82_arg1)
	local f82_local0 = f82_arg0.CodCasterPortraitPlayerList.Team1PortraitList
	local f82_local1 = f82_arg0.CodCasterPortraitPlayerList.Team2PortraitList
	local f82_local2 = CoD.CodCasterUtility.GetPortraitListHoverIndex(f82_local0, f82_local1)
	if f82_local2 ~= nil then
		if f82_local2 <= f82_local0.itemCount then
			CoD.CodCasterUtility.SetPortraitHoverState(f82_arg1, f82_local0.layoutItems[1][f82_local2], false)
		else
			CoD.CodCasterUtility.SetPortraitHoverState(f82_arg1, f82_local1.layoutItems[1][f82_local2 - f82_local0.itemCount], false)
		end
		local f82_local3 = CoD.CodCasterUtility.FindNextAlivePlayer(f82_arg0, f82_arg1, f82_local0, f82_local1, f82_local2, -1)
		if f82_local3 <= f82_local0.itemCount then
			CoD.CodCasterUtility.SetPortraitHoverState(f82_arg1, f82_local0.layoutItems[1][f82_local3], true)
		else
			CoD.CodCasterUtility.SetPortraitHoverState(f82_arg1, f82_local1.layoutItems[1][f82_local3 - f82_local0.itemCount], true)
		end
	end
end
CoD.CodCasterUtility.OnDpadLeftNonTeamBased = function(f83_arg0, f83_arg1)
	local f83_local0 = f83_arg0.CodCasterPlayerList.CodcasterNonTeamBasedPlayerListInternal.FreeTeam
	local f83_local1 = CoD.CodCasterUtility.GetPlayerListNextSelectedInNonTeamBased(f83_local0, f83_arg1)
	local f83_local2 = CoD.CodCasterUtility.FindNextAlivePlayer
	local f83_local3 = f83_arg0
	local f83_local4 = f83_arg1
	local f83_local5 = f83_local0
	local f83_local6 = nil
	local f83_local7 = f83_local1
	f83_local4 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f83_local0.layoutItems[f83_local2(f83_local3, f83_local4, f83_local5, f83_local6, f83_local1, -1)][1]:getModel(), "clientNum"))
	f83_local5 = Engine[0x4DF5CFBC1771947](f83_arg1)
	f83_local6 = f83_local5:create("hudItems.codcaster.nextClient")
	f83_local6:set(f83_local4)
end
CoD.CodCasterUtility.OnDpadRight = function(f84_arg0, f84_arg1)
	if CoDShared.IsGametypeTeamBased() then
		CoD.CodCasterUtility.OnDpadRightTeamBased(f84_arg0, f84_arg1)
	else
		CoD.CodCasterUtility.OnDpadRightNonTeamBased(f84_arg0, f84_arg1)
	end
end
CoD.CodCasterUtility.OnDpadRightTeamBased = function(f85_arg0, f85_arg1)
	local f85_local0 = f85_arg0.CodCasterPortraitPlayerList.Team1PortraitList
	local f85_local1 = f85_arg0.CodCasterPortraitPlayerList.Team2PortraitList
	local f85_local2 = CoD.CodCasterUtility.GetPortraitListHoverIndex(f85_local0, f85_local1)
	if f85_local2 ~= nil then
		if f85_local2 <= f85_local0.itemCount then
			CoD.CodCasterUtility.SetPortraitHoverState(f85_arg1, f85_local0.layoutItems[1][f85_local2], false)
		else
			CoD.CodCasterUtility.SetPortraitHoverState(f85_arg1, f85_local1.layoutItems[1][f85_local2 - f85_local0.itemCount], false)
		end
		local f85_local3 = CoD.CodCasterUtility.FindNextAlivePlayer(f85_arg0, f85_arg1, f85_local0, f85_local1, f85_local2, 1)
		if f85_local3 <= f85_local0.itemCount then
			CoD.CodCasterUtility.SetPortraitHoverState(f85_arg1, f85_local0.layoutItems[1][f85_local3], true)
		else
			CoD.CodCasterUtility.SetPortraitHoverState(f85_arg1, f85_local1.layoutItems[1][f85_local3 - f85_local0.itemCount], true)
		end
	end
end
CoD.CodCasterUtility.OnDpadRightNonTeamBased = function(f86_arg0, f86_arg1)
	local f86_local0 = f86_arg0.CodCasterPlayerList.CodcasterNonTeamBasedPlayerListInternal.FreeTeam
	local f86_local1 = CoD.CodCasterUtility.GetPlayerListNextSelectedInNonTeamBased(f86_local0, f86_arg1)
	local f86_local2 = CoD.CodCasterUtility.FindNextAlivePlayer
	local f86_local3 = f86_arg0
	local f86_local4 = f86_arg1
	local f86_local5 = f86_local0
	local f86_local6 = nil
	local f86_local7 = f86_local1
	f86_local4 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f86_local0.layoutItems[f86_local2(f86_local3, f86_local4, f86_local5, f86_local6, f86_local1, 1)][1]:getModel(), "clientNum"))
	f86_local5 = Engine[0x4DF5CFBC1771947](f86_arg1)
	f86_local6 = f86_local5:create("hudItems.codcaster.nextClient")
	f86_local6:set(f86_local4)
end
CoD.CodCasterUtility.SpectatePlayer = function(f87_arg0, f87_arg1)
	if CoDShared.IsGametypeTeamBased() then
		CoD.CodCasterUtility.SpectateHoveredPlayer(f87_arg0, f87_arg1)
	else
		CoD.CodCasterUtility.SpectateHoveredPlayerNonTeamBased(f87_arg0, f87_arg1)
	end
end
CoD.CodCasterUtility.SpectateHoveredPlayer = function(f88_arg0, f88_arg1)
	local f88_local0 = f88_arg0.CodCasterPortraitPlayerList.Team1PortraitList
	local f88_local1 = f88_arg0.CodCasterPortraitPlayerList.Team2PortraitList
	local f88_local2 = CoD.CodCasterUtility.GetPortraitListHoverIndex(f88_local0, f88_local1)
	if f88_local2 ~= nil then
		local f88_local3 = nil
		if f88_local2 <= f88_local0.itemCount then
			f88_local3 = f88_local0.layoutItems[1][f88_local2]
		else
			f88_local3 = f88_local1.layoutItems[1][f88_local2 - f88_local0.itemCount]
		end
		f88_local3.PlayerPortraitHoverTop.topselector:setAlpha(0)
		f88_local3.PlayerPortraitHoverBottom.bottomselector:setAlpha(0)
		Engine[0xC554A8C36EF7EFF](f88_arg1, "spectate", "clientNum", Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f88_local3:getModel(), "clientNum")))
	end
	local f88_local3 = Engine[0x4DF5CFBC1771947](f88_arg1)
	local f88_local4 = f88_local3:create("hudItems.codcaster.nextClient")
	f88_local4:set(LuaDefine.INVALID_CLIENT_INDEX)
end
CoD.CodCasterUtility.SpectateHoveredPlayerNonTeamBased = function(f89_arg0, f89_arg1)
	local f89_local0 = LuaDefine.INVALID_CLIENT_INDEX
	local f89_local1 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f89_arg1), "hudItems.codcaster.nextClient")
	if f89_local1 ~= nil then
		f89_local0 = Engine[0x614D394F6F9A18D](f89_local1)
	end
	if f89_local0 ~= nil and f89_local0 ~= LuaDefine.INVALID_CLIENT_INDEX then
		Engine[0xC554A8C36EF7EFF](f89_arg1, "spectate", "clientNum", f89_local0)
	end
	local f89_local2 = Engine[0x4DF5CFBC1771947](f89_arg1)
	local f89_local3 = f89_local2:create("hudItems.codcaster.nextClient")
	f89_local3:set(LuaDefine.INVALID_CLIENT_INDEX)
end
CoD.CodCasterUtility.SpectatePlayerNumber = function(f90_arg0, f90_arg1, f90_arg2)
	local f90_local0 = tonumber(f90_arg2)
	local f90_local1 = f90_arg0.CodCasterPortraitPlayerList.Team1PortraitList
	local f90_local2 = f90_arg0.CodCasterPortraitPlayerList.Team2PortraitList
	if f90_local1.itemCount + f90_local2.itemCount < f90_local0 then
		return
	end
	local f90_local3 = nil
	if f90_local0 <= f90_local1.itemCount then
		f90_local3 = f90_local1.layoutItems[1][f90_local0]
	else
		f90_local3 = f90_local2.layoutItems[1][f90_local0 - f90_local1.itemCount]
	end
	Engine[0xC554A8C36EF7EFF](f90_arg1, "spectate", "clientNum", Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f90_local3:getModel(), "clientNum")))
	local f90_local4 = Engine[0x4DF5CFBC1771947](f90_arg1)
	local f90_local5 = f90_local4:create("hudItems.codcaster.nextClient")
	f90_local5:set(LuaDefine.INVALID_CLIENT_INDEX)
end
CoD.CodCasterUtility.SetPortraitListIndexes = function(f91_arg0, f91_arg1)
	local f91_local0 = f91_arg0.Team1PortraitList
	local f91_local1 = f91_arg0.Team2PortraitList
	CoD.CodCasterUtility.SetPortraitListPlayerListEntryId(f91_local0, 0)
	CoD.CodCasterUtility.SetPortraitListPlayerListEntryId(f91_local1, f91_local0.itemCount)
end
CoD.CodCasterUtility.SetPortraitListPlayerListEntryId = function(f92_arg0, f92_arg1)
	for f92_local0 = 1, f92_arg0.itemCount, 1 do
		local f92_local3 = f92_arg0.layoutItems[1][f92_local0]
		if f92_local3 then
			local f92_local4 = f92_local0 + f92_arg1
			if f92_local4 == 10 then
				f92_local4 = 0
			elseif f92_local4 > 10 then
				f92_local4 = ""
			end
			f92_local3.PlayerListEntryId.Id:setText(f92_local4)
		end
	end
end
CoD.CodCasterUtility.HasButtonFocus = function(f93_arg0)
	return not HasAnyChildWithID(f93_arg0:getRoot(), "Menu.StartMenu_Main")
end
CoD.CodCasterUtility.GetTeamPlayerCount = function(f94_arg0, f94_arg1)
	local f94_local0 = 0
	local f94_local1 = Engine[0x4DF5CFBC1771947](f94_arg0)
	f94_local1 = f94_local1:create("Clients.clientCount")
	f94_local1 = f94_local1:get()
	for f94_local2 = 0, f94_local1 - 1, 1 do
		local f94_local5 = Engine[0xE4D2F32833CFA6C](f94_local2)
		if f94_local5.team:get() == f94_arg1 then
			f94_local0 = f94_local0 + 1
		end
	end
	return f94_local0
end
CoD.CodCasterUtility.InitDataSources = function(f95_arg0, f95_arg1)
	local f95_local0 = Engine[0x4DF5CFBC1771947](f95_arg1)
	local f95_local1 = f95_local0:create("HUDItems.codcaster.ObjectiveA.color")
	f95_local1:set("255 255 255")
	f95_local1 = f95_local0:create("HUDItems.codcaster.ObjectiveB.color")
	f95_local1:set("255 255 255")
	f95_local1 = f95_local0:create("HUDItems.codcaster.ObjectiveC.color")
	f95_local1:set("255 255 255")
	f95_local1 = f95_local0:create("HUDItems.codcaster.ObjectiveA.progress")
	f95_local1:set(0)
	f95_local1 = f95_local0:create("HUDItems.codcaster.ObjectiveB.progress")
	f95_local1:set(0)
	f95_local1 = f95_local0:create("HUDItems.codcaster.BombA")
	f95_local1:set(0)
	f95_local1 = f95_local0:create("HUDItems.codcaster.BombB")
	f95_local1:set(0)
	f95_local1 = f95_local0:create("HUDItems.codcaster.attackTeamColor")
	f95_local1:set("0 0 0")
	f95_local1 = f95_local0:create("hudItems.codcaster.ObjectiveA.text")
	f95_local1:set("")
	f95_local1 = f95_local0:create("hudItems.codcaster.ObjectiveB.text")
	f95_local1:set("")
	f95_local1 = f95_local0:create("hudItems.codcaster.hardpointVisibility")
	f95_local1:set(0)
	f95_local1 = f95_local0:create("hudItems.codcaster.nextClient")
	f95_local1:set(LuaDefine.INVALID_CLIENT_INDEX)
end
CoD.CodCasterUtility.InitPortraitObjectiveStatus = function(f96_arg0, f96_arg1)
	f96_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "objectivesUpdated"), function(model)
		local f97_local0 = f96_arg0:getModel()
		if f97_local0 then
			local f97_local1 = Engine[0x40E824FE270E174](f97_local0, "clientNum")
			if f97_local1 then
				local f97_local2 = Engine[0x614D394F6F9A18D](f97_local1)
				f96_arg0.ObjectiveStatusImage:setImage(RegisterImage(GetPlayerListObjectiveMinimapImage(f96_arg1, f97_local2)))
				f96_arg0.ObjectiveStatusImage:setRGB(GetPlayerListObjectiveColor(f96_arg1, f97_local2))
			end
		end
	end)
end
CoD.CodCasterUtility.AreCodCasterOptionsDefault = function(f98_arg0, f98_arg1)
	if f98_arg0 then
		for f98_local3, f98_local4 in ipairs(Engine[0xA7E3CD65E63086F](f98_arg0)) do
			if CoD.ShoutcasterProfileVarValue(f98_arg1, f98_local4[0x6E183377E0C37F4]) ~= CoD.OptionsUtility.GetPlayerSettingDefaultValueFromOptionInfo(f98_arg1, f98_local4) then
				return false
			end
		end
	end
	return true
end
CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare = function(f99_arg0, f99_arg1)
	local f99_local0 = {}
	for f99_local10, f99_local11 in ipairs(f99_arg1) do
		local f99_local12 = nil
		local f99_local13 = {}
		if f99_local11.options and not (f99_arg0 ~= Engine[0xA5B9C0111291A8B]() and IsInGame()) then
			for f99_local7, f99_local8 in ipairs(f99_local11.options) do
				local f99_local9 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f99_local8))
				if f99_local9 and not CoD.OptionsUtility.ExcludeOption(f99_arg0, f99_local9) then
					table.insert(f99_local13, f99_local8)
				end
			end
			if #f99_local13 > 0 then
				for f99_local7, f99_local8 in ipairs(f99_local13) do
					local f99_local9 = CoD.OptionsUtility.CreatePlayerSettingsDatasource(f99_arg0, f99_local8, f99_local11.additionalProperties)
					if f99_local9 then
						table.insert(f99_local0, f99_local9)
					end
				end
			end
		end
		if f99_local11.additionalProperties and f99_local11.additionalProperties.action then
			local f99_local4 = f99_local11.additionalProperties
			table.insert(f99_local0, CoD.CodCasterUtility.CreateCodCasterSettingsButtonDatasource(f99_local4.name, f99_local4.hintText, f99_local4.buttonPromptText, f99_local4))
		end
	end
	return f99_local0
end
CoD.CodCasterUtility.CreateCodCasterSettingsButtonDatasource = function(f100_arg0, f100_arg1, f100_arg2, f100_arg3)
	local f100_local0 = {
		models = {
			name = f100_arg0 or "",
			hintText = f100_arg1 or "",
			buttonPromptText = f100_arg2 or "",
		},
		properties = {
			customWidgetOverride = CoD.StartMenu_Options_SettingButton,
		},
	}
	if f100_arg3 then
		for f100_local4, f100_local5 in pairs(f100_arg3) do
			f100_local0.properties[f100_local4] = f100_local5
		end
	end
	return f100_local0
end
CoD.CodCasterUtility.CodCasterSettingsItemSelected = function(f101_arg0, f101_arg1, f101_arg2, f101_arg3, f101_arg4)
	local f101_local0 = f101_arg1.index
	if f101_local0 and f101_arg0.__lastSelectedIndex ~= f101_local0 then
		f101_arg0.__lastSelectedIndex = f101_local0
		CoD.SetShoutcasterProfileVarValue(f101_arg2, f101_arg3, f101_arg1.value)
		SelectItemIfPossible(f101_arg0, f101_arg1, f101_arg2)
		local f101_local1 = f101_arg0:getModel(f101_arg2, "currentSelection")
		if f101_local1 then
			f101_local1:set(f101_local0)
		end
		local f101_local2 = f101_arg0:getModel(f101_arg2, "optionAssetName")
		if f101_local2 then
			CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f101_arg2, f101_local2:get())
		end
		if Engine[0x7B48C1ABFF0F764]() and f101_arg3 == "shoutcaster_ds_thirdperson" then
			Engine[0xB81A5136C5503E4](f101_arg2, "shoutcaster_thirdperson " .. CoD.ShoutcasterProfileVarValue(f101_arg2, f101_arg3))
		end
	end
end
CoD.CodCasterUtility.CodCasterSettingsQuickSettings = function(f102_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f102_arg0, CoD.CodCasterUtility.QuickSettings)
end
CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsXray = function(f103_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f103_arg0, CoD.CodCasterUtility.DisplaySettingsXray)
end
CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsOverhead = function(f104_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f104_arg0, CoD.CodCasterUtility.DisplaySettingsOverhead)
end
CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsNotifications = function(f105_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f105_arg0, CoD.CodCasterUtility.DisplaySettingsNotifications)
end
CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsTeamPlayer = function(f106_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f106_arg0, CoD.CodCasterUtility.DisplaySettingsTeamPlayer)
end
CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsOthers = function(f107_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f107_arg0, CoD.CodCasterUtility.DisplaySettingsOthers)
end
CoD.CodCasterUtility.CodCasterSettingsLoadoutSettingsPrimaryWeapon = function(f108_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f108_arg0, CoD.CodCasterUtility.LoadoutSettingsPrimaryWeapon)
end
CoD.CodCasterUtility.CodCasterSettingsLoadoutSettingsSecondaryWeapon = function(f109_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f109_arg0, CoD.CodCasterUtility.LoadoutSettingsSecondaryWeapon)
end
CoD.CodCasterUtility.CodCasterSettingsLoadoutSettingsPerksAndEquipment = function(f110_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f110_arg0, CoD.CodCasterUtility.LoadoutSettingsPerksAndEquipment)
end
CoD.CodCasterUtility.CodCasterSettingsTeamSettingsTeamIdentity = function(f111_arg0)
	return CoD.CodCasterUtility.CodCasterSettingsGroupListPrepare(f111_arg0, CoD.CodCasterUtility.TeamSettingsTeamIdentity)
end
DataSources.CodCasterQuickSettingsList = DataSourceHelpers.ListSetup("CodCasterQuickSettingsList", CoD.CodCasterUtility.CodCasterSettingsQuickSettings, true)
CoD.CodCasterUtility.QuickSettings = {
	{
		options = {
			"codcaster_qs_xray",
			"codcaster_qs_listen_in",
			"codcaster_qs_specialists_voices",
			"codcaster_qs_player_list",
			"codcaster_qs_player_hud",
			"codcaster_qs_player_card",
			"codcaster_qs_loadout",
		},
	},
}
CoD.CodCasterUtility.DisplaySettingsXray = {
	{
		options = {
			"codcaster_ds_xray_1p_allies",
			"codcaster_ds_xray_1p_enemies",
			"codcaster_ds_xray_air_allies",
			"codcaster_ds_xray_air_enemies",
		},
	},
}
CoD.CodCasterUtility.DisplaySettingsOverhead = {
	{
		options = {
			"codcaster_ds_overhead_name_allies",
			"codcaster_ds_overhead_name_enemies",
			"codcaster_ds_overhead_health_allies",
			"codcaster_ds_overhead_health_enemies",
		},
	},
}
CoD.CodCasterUtility.DisplaySettingsNotifications = {
	{
		options = {
			"codcaster_ds_notification_callout",
			"codcaster_ds_notification_kills",
			"codcaster_ds_notification_announcements",
		},
	},
}
CoD.CodCasterUtility.DisplaySettingsTeamPlayer = {
	{
		options = {
			"codcaster_ds_teamscore",
			"codcaster_ds_team_identity",
			"codcaster_ds_player_numbers",
			"codcaster_ds_map_numbers",
			"codcaster_ds_portrait_scorestreaks",
			"codcaster_ds_portrait_statistics",
			"codcaster_ds_objective_status",
			"codcaster_ds_scorestreaks",
			"codcaster_ds_scorestreaks_notification",
			"codcaster_ds_player_notifications",
			"codcaster_ds_inventory",
			"codcaster_ds_voip_dock",
			"codcaster_ds_show_equipment",
		},
	},
}
CoD.CodCasterUtility.DisplaySettingsOthers = {
	{
		options = {
			"codcaster_ds_third_person",
			"codcaster_ds_minimap",
			"codcaster_ds_killfeed",
			"codcaster_ds_waypoint_markers",
			"codcaster_ds_toolbar",
		},
	},
}
CoD.CodCasterUtility.LoadoutSettingsPrimaryWeapon = {
	{
		options = {
			"codcaster_ls_primary_attachments",
			"codcaster_ls_primary_wildcards",
		},
	},
}
CoD.CodCasterUtility.LoadoutSettingsSecondaryWeapon = {
	{
		options = {
			"codcaster_ls_secondary_wpn",
			"codcaster_ls_secondary_attachments",
			"codcaster_ls_secondary_wildcards",
		},
	},
}
CoD.CodCasterUtility.LoadoutSettingsPerksAndEquipment = {
	{
		options = {
			"codcaster_ls_equipment",
			"codcaster_ls_perks",
			"codcaster_ls_wildcards",
		},
	},
}
CoD.CodCasterUtility.TeamSettingsTeamIdentity = {
	{
		options = {
			"codcaster_fe_team_identity",
		},
	},
}
CoD.CodCasterUtility.CodCasterProfileSettings = {
	"codcaster_ds_inventory",
	"codcaster_ds_killfeed",
	"codcaster_ds_map_numbers",
	"codcaster_ds_minimap",
	"codcaster_ds_notification_announcements",
	"codcaster_ds_notification_callout",
	"codcaster_ds_notification_commands",
	"codcaster_ds_notification_kills",
	"codcaster_ds_objective_status",
	"codcaster_ds_overhead_health_allies",
	"codcaster_ds_overhead_health_enemies",
	"codcaster_ds_overhead_name_allies",
	"codcaster_ds_overhead_name_enemies",
	"codcaster_ds_player_notifications",
	"codcaster_ds_player_numbers",
	"codcaster_ds_portrait_scorestreaks",
	"codcaster_ds_portrait_statistics",
	"codcaster_ds_scorestreaks",
	"codcaster_ds_scorestreaks_notification",
	"codcaster_ds_specialist_notifications",
	"codcaster_ds_team_identity",
	"codcaster_ds_teamscore",
	"codcaster_ds_third_person",
	"codcaster_ds_toolbar",
	"codcaster_ds_voip_dock",
	"codcaster_ds_waypoint_markers",
	"codcaster_ds_xray_1p_allies",
	"codcaster_ds_xray_1p_enemies",
	"codcaster_ds_xray_air_allies",
	"codcaster_ds_xray_air_enemies",
	"codcaster_ds_show_equipment",
	"codcaster_ls_equipment",
	"codcaster_ls_perks",
	"codcaster_ls_primary_attachments",
	"codcaster_ls_primary_wildcards",
	"codcaster_ls_secondary_attachments",
	"codcaster_ls_secondary_wildcards",
	"codcaster_ls_secondary_wpn",
	"codcaster_ls_wildcards",
	"codcaster_qs_battle_chatter",
	"codcaster_qs_listen_in",
	"codcaster_qs_specialists_voices",
	"codcaster_qs_loadout",
	"codcaster_qs_player_card",
	"codcaster_qs_player_hud",
	"codcaster_qs_player_list",
	"codcaster_qs_xray",
	"codcaster_fe_team_identity",
}
CoD.CodCasterUtility.CodCasterSettings = {}
CoD.CodCasterUtility.CodCasterSettings.DisplaySettingsCategories = {
	{
		ref = "Xray",
		groupName = 0xC110A89F1CE335C,
		datasourceNameHeader = "CodCasterDisplaySettingsXrayList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsXray,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0x44FA69478105CE1,
	},
	{
		ref = "Overhead",
		groupName = 0xE12AB7E02A89FD4,
		datasourceNameHeader = "CodCasterDisplaySettingsOverheadList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsOverhead,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0xAAF36052A208E4D,
	},
	{
		ref = "Notifications",
		groupName = 0x327F84DADEB4AF4,
		datasourceNameHeader = "CodCasterDisplaySettingsNotificationsList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsNotifications,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0x42B60A37FF48367,
	},
	{
		ref = "TeamPlayer",
		groupName = 0xD8F9FD91C10A5DB,
		datasourceNameHeader = "CodCasterDisplaySettingsTeamPlayerList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsTeamPlayer,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0xE8C69A54979157C,
	},
	{
		ref = "Others",
		groupName = 0x75F36048B8E4C83,
		datasourceNameHeader = "CodCasterDisplaySettingsOthersList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsDisplaySettingsOthers,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0x5261D4C1CC84BAA,
	},
}
CoD.CodCasterUtility.CodCasterSettings.LoadoutSettingsCategories = {
	{
		ref = "PrimaryWeapon",
		groupName = 0xCB2D4EFE37D882B,
		datasourceNameHeader = "CodCasterLoadoutSettingsPrimaryWeaponList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsLoadoutSettingsPrimaryWeapon,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0x12873C4C532BBF9,
	},
	{
		ref = "SecondaryWeapon",
		groupName = 0xA305350B533949F,
		datasourceNameHeader = "CodCasterLoadoutSettingsSecondaryWeaponList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsLoadoutSettingsSecondaryWeapon,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0xD709462D88E5C91,
	},
	{
		ref = "PerksAndEquipment",
		groupName = 0x2222AFABB2A1BF8,
		datasourceNameHeader = "CodCasterLoadoutSettingsPerksAndEquipmentList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsLoadoutSettingsPerksAndEquipment,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0x8C3FD997749A371,
	},
}
CoD.CodCasterUtility.CodCasterSettings.TeamSettingsCategories = {
	{
		ref = "TeamIdentity",
		groupName = 0x7A023700261F0B2,
		datasourceNameHeader = "CodCasterTeamSettingsTeamIdentityList",
		datasourceFunc = CoD.CodCasterUtility.CodCasterSettingsTeamSettingsTeamIdentity,
		isDefaultCondition = CoD.CodCasterUtility.AreCodCasterOptionsDefault,
		gameSettingListName = 0xCA6CC9B782E2463,
	},
	{
		ref = "Team1Settings",
		groupName = 0x30692B7DE1E3032,
	},
	{
		ref = "Team2Settings",
		groupName = 0xE3E43881DB13D15,
	},
}
CoD.CodCasterUtility.CodCasterSettings.QuickSettingsCategories = {
	{
		gameSettingListName = 0xDE2BF5462B82D4D,
	},
}
CoD.CodCasterUtility.SettingsUpdate = function(f112_arg0, f112_arg1, f112_arg2)
	local f112_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "CodCasterSettings"), "Update")
	if f112_arg1.updateSubscription then
		f112_arg1:removeSubscription(f112_arg1.updateSubscription)
	end
	f112_arg1.updateSubscription = f112_arg1:subscribeToModel(f112_local0, function()
		f112_arg1:updateDataSource(false, true)
	end, false)
end
CoD.CodCasterUtility.PrepareSettingsCategories = function(f114_arg0, f114_arg1, f114_arg2)
	local f114_local0 = {}
	for f114_local8, f114_local9 in ipairs(f114_arg1) do
		local f114_local10 = f114_arg2 .. f114_local9.ref .. "List"
		local f114_local4 = f114_local9.datasourceFunc
		if not f114_local4 then
			f114_local4 = CoD.OptionsUtility.PrepareCustomGameOptions
		end
		DataSources[f114_local10] = DataSourceHelpers.ListSetup(f114_local10, f114_local4, true)
		DataSources[f114_local10]._datasourceNameHeader = f114_local9.datasourceNameHeader
		DataSources[f114_local10]._gameSettingListName = f114_local9.gameSettingListName
		local f114_local5 = {
			models = {
				groupName = f114_local9.groupName,
				optionsListDatasource = f114_local10,
			},
		}
		local f114_local6 = {}
		local f114_local7 = f114_local9.isDefaultCondition
		if not f114_local7 then
			f114_local7 = CoD.OptionsUtility.AreCustomGameOptionsDefault
		end
		f114_local6.isDefaultCondition = f114_local7
		f114_local6.gameSettingListName = f114_local9.gameSettingListName
		f114_local5.properties = f114_local6
		table.insert(f114_local0, f114_local5)
	end
	return f114_local0
end
CoD.CodCasterUtility.PrepareSettingsTeamCategories = function(f115_arg0, f115_arg1, f115_arg2)
	local f115_local0 = {}
	for f115_local12, f115_local13 in ipairs(f115_arg1) do
		local f115_local14 = f115_arg2 .. f115_local13.ref .. "List"
		local f115_local4 = f115_local13.datasourceFunc
		if not f115_local4 then
			f115_local4 = CoD.OptionsUtility.PrepareCustomGameOptions
		end
		DataSources[f115_local14] = DataSourceHelpers.ListSetup(f115_local14, f115_local4, true)
		DataSources[f115_local14]._datasourceNameHeader = f115_local13.datasourceNameHeader
		DataSources[f115_local14]._gameSettingListName = f115_local13.gameSettingListName
		local f115_local5 = false
		if f115_local13.ref ~= "TeamIdentity" then
			f115_local5 = CoD.OptionsUtility.IsPlayerSettingDefault(f115_arg0, "codcaster_fe_team_identity")
		end
		local f115_local6 = false
		local f115_local7 = false
		local f115_local8 = nil
		if f115_local13.ref == "Team1Settings" then
			f115_local6 = true
			f115_local8 = "team1"
		elseif f115_local13.ref == "Team2Settings" then
			f115_local7 = true
			f115_local8 = "team2"
		else
			f115_local6 = true
			f115_local7 = true
		end
		local f115_local9 = {
			models = {
				groupName = f115_local13.groupName,
				optionsListDatasource = f115_local14,
				showTeam1Info = f115_local6,
				showTeam2Info = f115_local7,
			},
		}
		local f115_local10 = {}
		local f115_local11 = f115_local13.isDefaultCondition
		if not f115_local11 then
			f115_local11 = CoD.OptionsUtility.AreCustomGameOptionsDefault
		end
		f115_local10.isDefaultCondition = f115_local11
		f115_local10.gameSettingListName = f115_local13.gameSettingListName
		f115_local10.disabled = f115_local5
		f115_local10.actionTeam = f115_local8
		f115_local9.properties = f115_local10
		table.insert(f115_local0, f115_local9)
	end
	return f115_local0
end
CoD.CodCasterUtility.PrepareSettingsCategoriesDisplay = function(f116_arg0)
	return CoD.CodCasterUtility.PrepareSettingsCategories(f116_arg0, CoD.CodCasterUtility.CodCasterSettings.DisplaySettingsCategories, "CodCasterDisplaySettings")
end
CoD.CodCasterUtility.PrepareSettingsCategoriesLoadout = function(f117_arg0)
	return CoD.CodCasterUtility.PrepareSettingsCategories(f117_arg0, CoD.CodCasterUtility.CodCasterSettings.LoadoutSettingsCategories, "CodCasterLoadoutSettings")
end
CoD.CodCasterUtility.PrepareSettingsCategoriesTeam = function(f118_arg0)
	return CoD.CodCasterUtility.PrepareSettingsTeamCategories(f118_arg0, CoD.CodCasterUtility.CodCasterSettings.TeamSettingsCategories, "CodCasterTeamSettings")
end
DataSources.CodCasterDisplaySettingsCategories = DataSourceHelpers.ListSetup("CodCasterDisplaySettingsCategories", CoD.CodCasterUtility.PrepareSettingsCategoriesDisplay, nil, nil, CoD.CodCasterUtility.SettingsUpdate)
DataSources.CodCasterLoadoutSettingsCategories = DataSourceHelpers.ListSetup("CodCasterLoadoutSettingsCategories", CoD.CodCasterUtility.PrepareSettingsCategoriesLoadout, nil, nil, CoD.CodCasterUtility.SettingsUpdate)
DataSources.CodCasterTeamSettingsCategories = DataSourceHelpers.ListSetup("CodCasterTeamSettingsCategories", CoD.CodCasterUtility.PrepareSettingsCategoriesTeam, nil, nil, CoD.CodCasterUtility.SettingsUpdate)
CoD.CodCasterUtility.NonTeamBasedPreLoad = function(f119_arg0, f119_arg1)
	local f119_local0 = Engine[0x4DF5CFBC1771947](f119_arg1)
	if not Engine[0x40E824FE270E174](f119_local0, "selfPlayerInfo") then
		Engine[0xA798E4552F5E872](f119_local0, "selfPlayerInfo")
		Engine[0xA798E4552F5E872](f119_local0, "selfPlayerInfo.intop3")
	end
end
CoD.CodCasterUtility.NonTeamBasedPostLoad = function(f120_arg0, f120_arg1)
	local f120_local0 = Engine[0xEA74FA7EE46E195](Engine[0xFC38819EA2193BA]())
	f120_arg0.ModeAndMapName:setText(Engine[0xF9F1239CFD921FE](f120_local0.nameRef))
	f120_arg0.Widget1Portrait:setImage(RegisterImage(0x7615068F50B3D66))
	f120_arg0.Widget2Portrait:setImage(RegisterImage(0x7615068F50B3D66))
	f120_arg0.Widget3Portrait:setImage(RegisterImage(0x7615068F50B3D66))
end
DataSources.CodCasterSideBarSettingsTabs = ListHelper_SetupDataSource("CodCasterSideBarSettingsTabs", function(f121_arg0)
	local f121_local0 = {}
	table.insert(f121_local0, {
		models = {
			tabName = 0xE2311AD89D11E7C,
			tabWidget = "CoD.CodCasterSettingsSideBarDisplaySettings",
			tabIcon = "",
		},
		properties = {
			tabId = "display_settings",
			optionCategoriesTable = CoD.CodCasterUtility.CodCasterSettings.DisplaySettingsCategories,
		},
	})
	table.insert(f121_local0, {
		models = {
			tabName = 0xDC89C646FCB3342,
			tabWidget = "CoD.CodCasterSettingsSideBarLoadoutSettings",
			tabIcon = "",
		},
		properties = {
			tabId = "loadout_settings",
			optionCategoriesTable = CoD.CodCasterUtility.CodCasterSettings.LoadoutSettingsCategories,
		},
	})
	return f121_local0
end, true)
CoD.CodCasterUtility.GetCodCasterSettingsModel = function(f122_arg0)
	local f122_local0 = Engine[0x8DF2E5447F384B9]()
	local f122_local1 = f122_local0:create("CodCasterSettings")
	if f122_arg0 then
		return f122_local1:create(f122_arg0)
	else
		return f122_local1
	end
end
CoD.CodCasterUtility.GetCurrentCodCasterSettingsTab = function()
	local f123_local0 = CoD.CodCasterUtility.GetCodCasterSettingsModel("tabId")
	return f123_local0:get()
end
CoD.CodCasterUtility.CodCasterSettingsTabChanged = function(f124_arg0, f124_arg1, f124_arg2)
	local f124_local0 = CoD.CodCasterUtility.GetCodCasterSettingsModel("tabId")
	f124_local0:set(f124_arg1.tabId)
end
CoD.CodCasterUtility.CodCasterSettingsButtonGainFocus = function(f125_arg0, f125_arg1, f125_arg2)
	CoD.OptionsUtility.UpdateInfoModels(f125_arg1)
end
CoD.CodCasterUtility.RealignLoadoutLeftSide = function(f126_arg0, f126_arg1, f126_arg2, f126_arg3, f126_arg4, f126_arg5, f126_arg6)
	if IsCodCasterProfileValueEqualTo(f126_arg0, "shoutcaster_ls_equipment", 1) and IsCodCasterProfileValueEqualTo(f126_arg0, "shoutcaster_qs_playercard", 1) then
		f126_arg1:setAlpha(1)
	else
		f126_arg2 = 0
		f126_arg1:setAlpha(0)
	end
	local f126_local0, f126_local1, f126_local2, f126_local3 = f126_arg1:getLocalLeftRight()
	local f126_local4 = f126_local2 + f126_arg2
	f126_arg1:setLeftRight(f126_local0, f126_local1, f126_local2, f126_local4)
	f126_arg1.CodCasterLoadoutEquipmentBackground:setLeftRight(f126_local0, f126_local1, 0, f126_arg2)
	if f126_arg2 == 0 then
		f126_arg1.CodCasterLoadoutEquipmentBackground:setAlpha(0)
	else
		f126_arg1.CodCasterLoadoutEquipmentBackground:setAlpha(1)
	end
	if IsCodCasterProfileValueEqualTo(f126_arg0, "shoutcaster_ls_perks", 1) and IsCodCasterProfileValueEqualTo(f126_arg0, "shoutcaster_qs_playercard", 1) then
		f126_arg3:setAlpha(1)
	else
		f126_arg4 = 0
		f126_arg3:setAlpha(0)
	end
	local f126_local5, f126_local6, f126_local7, f126_local8 = f126_arg3:getLocalLeftRight()
	local f126_local9 = f126_local4
	if f126_arg2 > 0 then
		f126_local9 = f126_local9 + f0_local0
	end
	local f126_local10 = f126_local9 + f126_arg4
	f126_arg3:setLeftRight(f126_local5, f126_local6, f126_local9, f126_local10)
	f126_arg3.CodCasterLoadoutPerkBackground:setLeftRight(f126_local5, f126_local6, 0, f126_arg4)
	if f126_arg4 == 0 then
		f126_arg3.CodCasterLoadoutPerkBackground:setAlpha(0)
	else
		f126_arg3.CodCasterLoadoutPerkBackground:setAlpha(1)
	end
	if IsCodCasterProfileValueEqualTo(f126_arg0, "shoutcaster_ls_wildcard", 1) and IsCodCasterProfileValueEqualTo(f126_arg0, "shoutcaster_qs_playercard", 1) then
		f126_arg5:setAlpha(1)
	else
		f126_arg6 = 0
		f126_arg5:setAlpha(0)
	end
	local f126_local11, f126_local12, f126_local13, f126_local14 = f126_arg5:getLocalLeftRight()
	local f126_local15 = f126_local10
	if f126_arg4 > 0 then
		f126_local15 = f126_local15 + f0_local0
	end
	f126_arg5:setLeftRight(f126_local11, f126_local12, f126_local15, f126_local15 + f126_arg6)
	f126_arg5.CodCasterLoadoutWildcardBackground:setLeftRight(f126_local11, f126_local12, 0, f126_arg6)
	if f126_arg6 == 0 then
		f126_arg5.CodCasterLoadoutWildcardBackground:setAlpha(0)
	else
		f126_arg5.CodCasterLoadoutWildcardBackground:setAlpha(1)
	end
end
CoD.CodCasterUtility.UpdateTalentsListSizeAndModel = function(f127_arg0, f127_arg1, f127_arg2)
	local f127_local0 = f127_arg1:getParent()
	if f127_local0 == nil then
		return
	end
	local f127_local1 = f127_local0.CodCasterLoadoutModuleEquipment
	local f127_local2 = f127_local0.CodCasterLoadoutModulePerk
	local f127_local3 = f127_local0.CodCasterLoadoutModulePerkWildcard
	local f127_local4 = Engine[0x4DF5CFBC1771947](f127_arg2)
	local f127_local5 = f127_local4:create("talents.talentEquipmentCount")
	f127_local5 = f127_local5:get()
	local f127_local6 = f127_local4:create("talents.perkCount")
	f127_local6 = f127_local6:get()
	local f127_local7 = f127_local4:create("wildcards.customCount")
	f127_local7 = f127_local7:get()
	local f127_local8 = f127_local3.CodCasterLoadoutWildcardList
	if f127_local7 ~= nil and LUI.GridLayout.getTotalCount(f127_local8) ~= f127_local7 then
		f127_local8:setHorizontalCount(f127_local7)
	end
	local f127_local9 = 0
	if f127_local5 ~= nil and f127_local5 > 0 then
		f127_local9 = f127_local5 * 60 + f0_local0
	end
	local f127_local10 = 0
	if f127_local6 ~= nil and f127_local6 > 0 then
		f127_local10 = f127_local6 * 55 + f0_local0 + 6
	end
	local f127_local11 = 0
	if f127_local7 ~= nil and f127_local7 > 0 then
		f127_local11 = f127_local7 * 35 + f0_local0
		if f127_local7 == 1 then
			f127_local11 = f127_local11 + f0_local0
		end
	end
	f127_local1.CodCasterLoadoutEquipmentBackground:setWidth(f127_local9)
	f127_local2.CodCasterLoadoutPerkBackground:setWidth(f127_local10)
	f127_local3.CodCasterLoadoutWildcardBackground:setWidth(f127_local11)
	CoD.CodCasterUtility.RealignLoadoutLeftSide(f127_arg2, f127_local1, f127_local9, f127_local2, f127_local10, f127_local3, f127_local11)
end
CoD.CodCasterUtility.HideAllWeapons = function(f128_arg0)
	local f128_local0 = IsCodCasterProfileValueEqualTo(f128_arg0, "shoutcaster_qs_playerhud", 0)
	if not f128_local0 then
		f128_local0 = IsCodCasterProfileValueEqualTo(f128_arg0, "shoutcaster_ds_inventory", 0)
		if not f128_local0 then
			f128_local0 = IsCodCasterProfileValueEqualTo(f128_arg0, "shoutcaster_qs_loadout", 0)
		end
	end
	return f128_local0
end
CoD.CodCasterUtility.ShowCurrentWeaponAttachments = function(f129_arg0, f129_arg1)
	if CoD.CodCasterUtility.HideAllWeapons(f129_arg0) then
		return false
	elseif f129_arg1 then
		return IsCodCasterProfileValueEqualTo(f129_arg0, "shoutcaster_ls_primary_attachments", 1)
	end
	return IsCodCasterProfileValueEqualTo(f129_arg0, "shoutcaster_ls_secondary_attachments", 1) and IsCodCasterProfileValueEqualTo(f129_arg0, "shoutcaster_ls_secondary_weapon", 1)
end
CoD.CodCasterUtility.ShowCurrentWeaponWildcards = function(f130_arg0, f130_arg1)
	if CoD.CodCasterUtility.HideAllWeapons(f130_arg0) then
		return false
	elseif f130_arg1 then
		return IsCodCasterProfileValueEqualTo(f130_arg0, "shoutcaster_ls_primary_wildcards", 1)
	end
	return IsCodCasterProfileValueEqualTo(f130_arg0, "shoutcaster_ls_secondary_wildcards", 1) and IsCodCasterProfileValueEqualTo(f130_arg0, "shoutcaster_ls_secondary_weapon", 1)
end
CoD.CodCasterUtility.IsPrimaryWeaponOnHand = function(f131_arg0)
	local f131_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f131_arg0), "secondaryWeapon.indexIndex")
	return CoD.SafeGetModelValue(DataSources.CurrentWeapon.getModel(f131_arg0), "weapon") ~= f131_local0:get()
end
CoD.CodCasterUtility.RealignLoadoutPrimaryWeapon = function(f132_arg0, f132_arg1, f132_arg2, f132_arg3, f132_arg4, f132_arg5, f132_arg6)
	if CoD.CodCasterUtility.ShowCurrentWeaponAttachments(f132_arg0, f132_arg6) then
		f132_arg3:setAlpha(1)
	else
		f132_arg4 = 0
		f132_arg3:setAlpha(0)
	end
	local f132_local0, f132_local1, f132_local2, f132_local3 = f132_arg3:getLocalLeftRight()
	local f132_local4 = f132_arg5 - f132_arg4
	f132_arg3:setLeftRight(f132_local0, f132_local1, f132_local4, f132_arg5)
	f132_arg3.CodCasterLoadoutAttachmentsBackground:setLeftRight(f132_local0, f132_local1, 0, f132_arg4)
	if f132_arg4 == 0 then
		f132_arg3.CodCasterLoadoutAttachmentsBackground:setAlpha(0)
	else
		f132_arg3.CodCasterLoadoutAttachmentsBackground:setAlpha(1)
	end
	if CoD.CodCasterUtility.ShowCurrentWeaponWildcards(f132_arg0, f132_arg6) then
		f132_arg1:setAlpha(1)
	else
		f132_arg2 = 0
		f132_arg1:setAlpha(0)
	end
	local f132_local5, f132_local6, f132_local7, f132_local8 = f132_arg1:getLocalLeftRight()
	local f132_local9 = f132_local4
	if f132_arg4 > 0 then
		f132_local9 = f132_local9 - f0_local0
	end
	f132_arg1:setLeftRight(f132_local5, f132_local6, f132_local9 - f132_arg2, f132_local9)
	f132_arg1.CodCasterLoadoutWildcardBackground:setLeftRight(f132_local5, f132_local6, 0, f132_arg2)
	if f132_arg2 == 0 then
		f132_arg1.CodCasterLoadoutWildcardBackground:setAlpha(0)
	else
		f132_arg1.CodCasterLoadoutWildcardBackground:setAlpha(1)
	end
end
CoD.CodCasterUtility.OnHandLoadoutLeft = -823
CoD.CodCasterUtility.OnHandLoadoutRight = -322
CoD.CodCasterUtility.OnHandLoadoutTop = -99
CoD.CodCasterUtility.OnHandLoadoutBottom = -24
CoD.CodCasterUtility.OffHandLoadoutLeft = -705
CoD.CodCasterUtility.OffHandLoadoutRight = -204
CoD.CodCasterUtility.OffHandLoadoutTop = -176
CoD.CodCasterUtility.OffHandLoadoutBottom = -101
CoD.CodCasterUtility.UpdateWeaponListSizeAndModel = function(f133_arg0, f133_arg1, f133_arg2)
	local f133_local0 = f133_arg1:getParent()
	if f133_local0 == nil then
		return
	end
	local f133_local1 = f133_local0.CodCasterLoadoutModulePrimaryWildcard
	local f133_local2 = f133_local0.CodCasterLoadoutModulePrimaryAttachments
	local f133_local3 = Engine[0x4DF5CFBC1771947](f133_arg2)
	local f133_local4 = f133_local3:create("wildcards.primaryCount")
	f133_local4 = f133_local4:get()
	local f133_local5 = f133_local3:create("primaryWeapon.attachmentCount")
	f133_local5 = f133_local5:get()
	local f133_local6 = f133_local1.CodCasterLoadoutWildcards
	if f133_local4 ~= nil and LUI.GridLayout.getTotalCount(f133_local6) ~= f133_local4 then
		f133_local6:setHorizontalCount(f133_local4)
	end
	local f133_local7 = 0
	if f133_local4 ~= nil and f133_local4 > 0 then
		f133_local7 = f133_local4 * 35 + f0_local0
		if f133_local4 == 1 then
			f133_local7 = f133_local7 + f0_local0
		end
	end
	local f133_local8 = 0
	if f133_local5 ~= nil and f133_local5 > 0 then
		f133_local8 = f133_local5 * 61 + f0_local0
	end
	f133_local1.CodCasterLoadoutWildcardBackground:setWidth(f133_local7)
	f133_local2.CodCasterLoadoutAttachmentsBackground:setWidth(f133_local8)
	local f133_local9 = Engine[0x40E824FE270E174](f133_local3, "primaryWeapon.itemIndex")
	local f133_local10 = f133_local9:get()
	local f133_local11 = Engine[0x40E824FE270E174](f133_local3, "secondaryWeapon.indexIndex")
	local f133_local12 = f133_local11:get()
	local f133_local13 = 389
	local f133_local14 = false
	local f133_local15 = CoD.SafeGetModelValue(DataSources.CurrentWeapon.getModel(f133_arg2), "weapon")
	if f133_local15 ~= nil and f133_local15 == f133_local12 then
		if f133_local10 == 0 then
			f133_local0.CodCasterLoadoutModulePrimaryWeapon.WeaponBackground:setWidth(0)
			f133_local0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(0)
		else
			f133_local0:setLeftRight(1, 1, CoD.CodCasterUtility.OffHandLoadoutLeft, CoD.CodCasterUtility.OffHandLoadoutRight)
			f133_local0:setTopBottom(1, 1, CoD.CodCasterUtility.OffHandLoadoutTop, CoD.CodCasterUtility.OffHandLoadoutBottom)
			f133_local0:setPriority(100)
			f133_local0.CodCasterLoadoutModulePrimaryWeapon.WeaponBackground:setWidth(f0_local1)
			f133_local0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(1)
			f133_local13 = f133_local13 - f0_local0
			if IsCodCasterProfileValueEqualTo(f133_arg2, "shoutcaster_ls_secondary_weapon", 1) and not CoD.CodCasterUtility.HideAllWeapons(f133_arg2) then
				f133_local0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(1)
			else
				f133_local0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(0)
			end
		end
	else
		f133_local13 = f133_local13 + 112
		f133_local14 = true
		f133_local0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(0)
		f133_local0:setLeftRight(1, 1, CoD.CodCasterUtility.OnHandLoadoutLeft, CoD.CodCasterUtility.OnHandLoadoutRight)
		f133_local0:setTopBottom(1, 1, CoD.CodCasterUtility.OnHandLoadoutTop, CoD.CodCasterUtility.OnHandLoadoutBottom)
		f133_local0:setPriority(200)
	end
	CoD.CodCasterUtility.RealignLoadoutPrimaryWeapon(f133_arg2, f133_local1, f133_local7, f133_local2, f133_local8, f133_local13, f133_local14)
end
CoD.CodCasterUtility.RealignLoadoutSecondaryWeapon = function(f134_arg0, f134_arg1, f134_arg2, f134_arg3, f134_arg4, f134_arg5, f134_arg6)
	if CoD.CodCasterUtility.ShowCurrentWeaponAttachments(f134_arg0, f134_arg6) then
		f134_arg3:setAlpha(1)
	else
		f134_arg4 = 0
		f134_arg3:setAlpha(0)
	end
	local f134_local0, f134_local1, f134_local2, f134_local3 = f134_arg3:getLocalLeftRight()
	local f134_local4 = f134_arg5 - f134_arg4
	f134_arg3:setLeftRight(f134_local0, f134_local1, f134_local4, f134_arg5)
	f134_arg3.CodCasterLoadoutAttachmentsBackground:setLeftRight(f134_local0, f134_local1, 0, f134_arg4)
	if f134_arg4 == 0 then
		f134_arg3.CodCasterLoadoutAttachmentsBackground:setAlpha(0)
	else
		f134_arg3.CodCasterLoadoutAttachmentsBackground:setAlpha(1)
	end
	if CoD.CodCasterUtility.ShowCurrentWeaponWildcards(f134_arg0, f134_arg6) then
		f134_arg1:setAlpha(1)
	else
		f134_arg2 = 0
		f134_arg1:setAlpha(0)
	end
	local f134_local5, f134_local6, f134_local7, f134_local8 = f134_arg1:getLocalLeftRight()
	local f134_local9 = f134_local4
	if f134_arg4 > 0 then
		f134_local9 = f134_local9 - f0_local0
	end
	f134_arg1:setLeftRight(f134_local5, f134_local6, f134_local9 - f134_arg2, f134_local9)
	f134_arg1.CodCasterLoadoutWildcardBackground:setLeftRight(f134_local5, f134_local6, 0, f134_arg2)
	if f134_arg2 == 0 then
		f134_arg1.CodCasterLoadoutWildcardBackground:setAlpha(0)
	else
		f134_arg1.CodCasterLoadoutWildcardBackground:setAlpha(1)
	end
end
CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel = function(f135_arg0, f135_arg1, f135_arg2)
	local f135_local0 = f135_arg1:getParent()
	if f135_local0 == nil then
		return
	end
	local f135_local1 = f135_local0.CodCasterLoadoutModuleSecondaryWildcard
	local f135_local2 = f135_local0.CodCasterLoadoutModuleSecondaryAttachments
	local f135_local3 = Engine[0x4DF5CFBC1771947](f135_arg2)
	local f135_local4 = f135_local3:create("wildcards.secondaryCount")
	f135_local4 = f135_local4:get()
	local f135_local5 = f135_local3:create("secondaryWeapon.attachmentCount")
	f135_local5 = f135_local5:get()
	local f135_local6 = f135_local1.CodCasterLoadoutWildcards
	if f135_local4 ~= nil and LUI.GridLayout.getTotalCount(f135_local6) ~= f135_local4 then
		f135_local6:setHorizontalCount(f135_local4)
	end
	local f135_local7 = 0
	if f135_local4 ~= nil and f135_local4 > 0 then
		f135_local7 = f135_local4 * 35 + f0_local0
		if f135_local4 == 1 then
			f135_local7 = f135_local7 + f0_local0
		end
	end
	local f135_local8 = 0
	if f135_local5 ~= nil and f135_local5 > 0 then
		f135_local8 = f135_local5 * 61 + f0_local0
	end
	f135_local1.CodCasterLoadoutWildcardBackground:setWidth(f135_local7)
	f135_local2.CodCasterLoadoutAttachmentsBackground:setWidth(f135_local8)
	local f135_local9 = 389
	local f135_local10 = false
	local f135_local11 = CoD.SafeGetModelValue(DataSources.CurrentWeapon.getModel(f135_arg2), "weapon")
	local f135_local12 = Engine[0x40E824FE270E174](f135_local3, "secondaryWeapon.indexIndex")
	local f135_local13 = f135_local12:get()
	if f135_local13 == 0 then
		f135_local0.CodCasterLoadoutModuleSecondaryWeapon.WeaponBackground:setWidth(0)
		f135_local0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(0)
	elseif f135_local11 ~= nil and f135_local11 == f135_local13 then
		f135_local9 = f135_local9 + 112
		f135_local10 = true
		f135_local0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(0)
		f135_local0:setLeftRight(1, 1, CoD.CodCasterUtility.OnHandLoadoutLeft, CoD.CodCasterUtility.OnHandLoadoutRight)
		f135_local0:setTopBottom(1, 1, CoD.CodCasterUtility.OnHandLoadoutTop, CoD.CodCasterUtility.OnHandLoadoutBottom)
		f135_local0:setPriority(200)
	else
		f135_local0:setLeftRight(1, 1, CoD.CodCasterUtility.OffHandLoadoutLeft, CoD.CodCasterUtility.OffHandLoadoutRight)
		f135_local0:setTopBottom(1, 1, CoD.CodCasterUtility.OffHandLoadoutTop, CoD.CodCasterUtility.OffHandLoadoutBottom)
		f135_local0:setPriority(100)
		f135_local0.CodCasterLoadoutModuleSecondaryWeapon.WeaponBackground:setWidth(f0_local1)
		f135_local9 = f135_local9 - f0_local0
		if IsCodCasterProfileValueEqualTo(f135_arg2, "shoutcaster_ls_secondary_weapon", 1) and not CoD.CodCasterUtility.HideAllWeapons(f135_arg2) then
			f135_local0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(1)
		else
			f135_local0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(0)
		end
	end
	CoD.CodCasterUtility.RealignLoadoutSecondaryWeapon(f135_arg2, f135_local1, f135_local7, f135_local2, f135_local8, f135_local9, f135_local10)
end
CoD.CodCasterUtility.LoadoutLocation = {
	NONE = 0,
	TALENT_EQUIPMENT = 1,
	TALENT_PERK = 2,
	TALENT_WILDCARD = 3,
	MID_HEAL = 4,
	MID_ULTIMATE = 5,
	MID_ABILITY = 6,
	ONHAND_WILDCARD = 7,
	ONHAND_ATTACHMENT = 8,
	ONHAND_WEAPON = 9,
	OFFHAND_WILDCARD = 10,
	OFFHAND_ATTACHMENT = 11,
	OFFHAND_WEAPON = 12,
}
CoD.CodCasterUtility.GetLoadoutElementsVisibility = function(f136_arg0)
	local f136_local0 = {}
	local f136_local1 = CoD.CodCasterUtility.LoadoutLocation.TALENT_EQUIPMENT
	local f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_ls_equipment", 1)
	if f136_local2 then
		f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_playercard", 1)
		if f136_local2 then
			f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_loadout", 1)
		end
	end
	f136_local0[f136_local1] = f136_local2
	f136_local1 = CoD.CodCasterUtility.LoadoutLocation.TALENT_PERK
	f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_ls_perks", 1)
	if f136_local2 then
		f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_playercard", 1)
		if f136_local2 then
			f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_loadout", 1)
		end
	end
	f136_local0[f136_local1] = f136_local2
	f136_local1 = CoD.CodCasterUtility.LoadoutLocation.TALENT_WILDCARD
	f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_ls_wildcard", 1)
	if f136_local2 then
		f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_playercard", 1)
		if f136_local2 then
			f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_loadout", 1)
		end
	end
	f136_local0[f136_local1] = f136_local2
	f136_local1 = CoD.CodCasterUtility.LoadoutLocation.MID_HEAL
	f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_ds_inventory", 1)
	if f136_local2 then
		f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_playerhud", 1)
	end
	f136_local0[f136_local1] = f136_local2
	f136_local1 = CoD.CodCasterUtility.LoadoutLocation.MID_ULTIMATE
	f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_ds_inventory", 1)
	if f136_local2 then
		f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_playerhud", 1)
	end
	f136_local0[f136_local1] = f136_local2
	f136_local1 = CoD.CodCasterUtility.LoadoutLocation.MID_ABILITY
	f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_ds_inventory", 1)
	if f136_local2 then
		f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_qs_playerhud", 1)
	end
	f136_local0[f136_local1] = f136_local2
	f136_local0[CoD.CodCasterUtility.LoadoutLocation.ONHAND_WILDCARD] = CoD.CodCasterUtility.ShowCurrentWeaponWildcards(f136_arg0, true)
	f136_local0[CoD.CodCasterUtility.LoadoutLocation.ONHAND_ATTACHMENT] = CoD.CodCasterUtility.ShowCurrentWeaponAttachments(f136_arg0, true)
	f136_local0[CoD.CodCasterUtility.LoadoutLocation.ONHAND_WEAPON] = false
	f136_local0[CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WILDCARD] = CoD.CodCasterUtility.ShowCurrentWeaponWildcards(f136_arg0, false)
	f136_local0[CoD.CodCasterUtility.LoadoutLocation.OFFHAND_ATTACHMENT] = CoD.CodCasterUtility.ShowCurrentWeaponAttachments(f136_arg0, false)
	f136_local1 = CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WEAPON
	if not CoD.CodCasterUtility.HideAllWeapons(f136_arg0) then
		f136_local2 = IsCodCasterProfileValueEqualTo(f136_arg0, "shoutcaster_ls_secondary_weapon", 1)
	else
		f136_local2 = false
	end
	f136_local0[f136_local1] = f136_local2
	return f136_local0
end
CoD.CodCasterUtility.GetLoadoutListSelection = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3, f137_arg4, f137_arg5, f137_arg6, f137_arg7)
	local f137_local0 = f137_arg7
	if f137_arg0[f137_arg1] then
		local f137_local1 = LUI.GridLayout.getTotalCount(f137_arg2)
		for f137_local2 = 1, f137_local1, 1 do
			local f137_local5 = LUI.GridLayout.getItemAt(f137_arg2, f137_local2)
			if f137_arg3 == nil then
				if f137_local5.CodCasterLoadoutSelection:getAlpha() > 0 then
					local f137_local6 = f137_local5
					f137_local0 = f137_arg1
					f137_arg3 = f137_local6
				end
				f137_arg5 = f137_local5
				if f137_arg4 == nil then
					f137_arg4 = f137_local5
				end
			end
			if f137_arg6 == nil then
				f137_arg6 = f137_local5
				break
			end
		end
	end
	return f137_arg3, f137_local0, f137_arg4, f137_arg5, f137_arg6
end
CoD.CodCasterUtility.GetLoadoutSelection = function(f138_arg0, f138_arg1, f138_arg2, f138_arg3, f138_arg4, f138_arg5, f138_arg6, f138_arg7)
	local f138_local0 = f138_arg7
	if f138_arg0[f138_arg1] then
		if f138_arg3 == nil then
			if f138_arg2.CodCasterLoadoutSelection:getAlpha() > 0 then
				local f138_local1 = f138_arg2
				f138_local0 = f138_arg1
				f138_arg3 = f138_local1
			else
				f138_arg5 = f138_arg2
				if f138_arg4 == nil then
					f138_arg4 = f138_arg2
				end
			end
		elseif f138_arg6 == nil then
			f138_arg6 = f138_arg2
		end
	end
	return f138_arg3, f138_local0, f138_arg4, f138_arg5, f138_arg6
end
CoD.CodCasterUtility.ClearLoadoutListSelection = function(f139_arg0)
	local f139_local0 = LUI.GridLayout.getTotalCount(f139_arg0)
	for f139_local1 = 1, f139_local0, 1 do
		local f139_local4 = LUI.GridLayout.getItemAt(f139_arg0, f139_local1)
		if f139_local4 ~= nil then
			f139_local4.CodCasterLoadoutSelection:setAlpha(0)
		end
	end
end
CoD.CodCasterUtility.GetLeftMostOffhandItem = function(f140_arg0, f140_arg1, f140_arg2, f140_arg3)
	local f140_local0 = CoD.CodCasterUtility.GetLoadoutElementsVisibility(f140_arg0)
	local f140_local1 = LUI.GridLayout.getTotalCount(f140_arg1)
	local f140_local2 = LUI.GridLayout.getTotalCount(f140_arg2)
	local f140_local3 = nil
	if not f140_local0[CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WEAPON] then
		return f140_local3
	elseif f140_local1 > 0 and f140_local0[CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WILDCARD] then
		f140_local3 = LUI.GridLayout.getItemAt(f140_arg1, 1)
	elseif f140_local2 > 0 and f140_local0[CoD.CodCasterUtility.LoadoutLocation.OFFHAND_ATTACHMENT] then
		f140_local3 = LUI.GridLayout.getItemAt(f140_arg2, 1)
	else
		local f140_local4 = Engine[0x4DF5CFBC1771947](f140_arg0)
		local f140_local5 = CoD.CodCasterUtility.IsPrimaryWeaponOnHand(f140_arg0) and Engine[0x40E824FE270E174](f140_local4, "secondaryWeapon.indexIndex") or Engine[0x40E824FE270E174](f140_local4, "primaryWeapon.itemIndex")
		if f140_local5:get() ~= 0 then
			f140_local3 = f140_arg3
		end
	end
	return f140_local3
end
CoD.CodCasterUtility.GetRightMostOnhandItem = function(f141_arg0, f141_arg1, f141_arg2, f141_arg3)
	local f141_local0 = CoD.CodCasterUtility.GetLoadoutElementsVisibility(f141_arg0)
	local f141_local1 = LUI.GridLayout.getTotalCount(f141_arg1)
	local f141_local2 = LUI.GridLayout.getTotalCount(f141_arg2)
	local f141_local3 = nil
	if f141_local2 > 0 and f141_local0[CoD.CodCasterUtility.LoadoutLocation.ONHAND_ATTACHMENT] then
		f141_local3 = LUI.GridLayout.getItemAt(f141_arg2, f141_local2)
	elseif f141_local1 > 0 and f141_local0[CoD.CodCasterUtility.LoadoutLocation.ONHAND_WILDCARD] then
		f141_local3 = LUI.GridLayout.getItemAt(f141_arg1, f141_local1)
	elseif f141_local0[CoD.CodCasterUtility.LoadoutLocation.MID_ABILITY] then
		f141_local3 = f141_arg3
	end
	return f141_local3
end
CoD.CodCasterUtility.SetLoadoutTalentsText = function(f142_arg0)
	local f142_local0 = LUI.GridLayout.getTotalCount(f142_arg0)
	for f142_local1 = 1, f142_local0, 1 do
		local f142_local4 = LUI.GridLayout.getItemAt(f142_arg0, f142_local1)
		if f142_local4 ~= nil then
			local f142_local5 = Engine[0x40E824FE270E174](f142_local4:getModel(), "itemShortName")
			f142_local4.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](f142_local5:get()))
		end
	end
end
CoD.CodCasterUtility.SetLoadoutWildcardsText = function(f143_arg0)
	local f143_local0 = LUI.GridLayout.getTotalCount(f143_arg0)
	for f143_local1 = 1, f143_local0, 1 do
		local f143_local4 = LUI.GridLayout.getItemAt(f143_arg0, f143_local1)
		if f143_local4 ~= nil then
			local f143_local5 = Engine[0x40E824FE270E174](f143_local4:getModel(), "name")
			f143_local4.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](Engine[0xD97229B24C685D5](f143_local5:get(), Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]), Enum[0x6EB546760F890D2][0x1A949B83CC070B0], Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])))
		end
	end
end
CoD.CodCasterUtility.SetLoadoutAttachmentsText = function(f144_arg0, f144_arg1, f144_arg2)
	local f144_local0 = LUI.GridLayout.getTotalCount(f144_arg1)
	for f144_local1 = 1, f144_local0, 1 do
		local f144_local4 = LUI.GridLayout.getItemAt(f144_arg1, f144_local1)
		if f144_local4 ~= nil then
			local f144_local5 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f144_arg0), f144_arg2 .. "Weapon.attachment" .. f144_local1 - 1)
			if f144_local5 ~= nil then
				f144_local4.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](f144_local5:get()))
			end
		end
	end
end
CoD.CodCasterUtility.SetLoadoutElementsTextWithDelay = function(f145_arg0, f145_arg1, f145_arg2)
	f145_arg0:addElement(LUI.UITimer.newElementTimer(300, true, function()
		CoD.CodCasterUtility.SetLoadoutElementsText(f145_arg0, f145_arg1, f145_arg2)
	end))
end
CoD.CodCasterUtility.SetLoadoutElementsText = function(f147_arg0, f147_arg1, f147_arg2)
	local f147_local0 = f147_arg0
	local f147_local1 = f147_arg1
	local f147_local2 = f147_local0.CodCasterLoadoutTalents
	CoD.CodCasterUtility.SetLoadoutTalentsText(f147_local2.CodCasterLoadoutModuleEquipment.CodCasterLoadoutEquipmentList)
	CoD.CodCasterUtility.SetLoadoutTalentsText(f147_local2.CodCasterLoadoutModulePerk.CodCasterLoadoutPerkList)
	CoD.CodCasterUtility.SetLoadoutWildcardsText(f147_local2.CodCasterLoadoutModulePerkWildcard.CodCasterLoadoutWildcardList)
	local f147_local3 = f147_local1:getParent()
	local f147_local4 = f147_local3.T7HudMenuGameMode.HudMPSafeAreaContainer.AmmoWidgetMPUltimate
	f147_local4.HealCooldown.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](0x8CADD3D78C04519))
	local f147_local5 = Engine[0x40E824FE270E174](f147_local4.UltimateRadialMeterwipe:getModel(), "name")
	f147_local4.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](f147_local5:get()))
	local f147_local6 = Engine[0x40E824FE270E174](f147_local4.AmmoWidgetMPAbilityItem:getModel(), "name")
	f147_local4.AmmoWidgetMPAbilityItem.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](f147_local6:get()))
	local f147_local7 = f147_local0.CodCasterLoadoutPrimary
	CoD.CodCasterUtility.SetLoadoutWildcardsText(f147_local7.CodCasterLoadoutModulePrimaryWildcard.CodCasterLoadoutWildcards)
	CoD.CodCasterUtility.SetLoadoutAttachmentsText(f147_arg2, f147_local7.CodCasterLoadoutModulePrimaryAttachments.CodCasterLoadoutAttachments, "primary")
	local f147_local8 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f147_arg2), "primaryWeapon.itemIndex")
	f147_local8 = f147_local8:get()
	local f147_local9 = nil
	if f147_local8 ~= nil then
		f147_local7.CodCasterLoadoutModulePrimaryWeapon.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f147_local8, Enum[0x6EB546760F890D2][0x569E84652131CD7], Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])))
	end
	local f147_local10 = f147_local0.CodCasterLoadoutSecondary
	CoD.CodCasterUtility.SetLoadoutWildcardsText(f147_local10.CodCasterLoadoutModuleSecondaryWildcard.CodCasterLoadoutWildcards)
	CoD.CodCasterUtility.SetLoadoutAttachmentsText(f147_arg2, f147_local10.CodCasterLoadoutModuleSecondaryAttachments.CodCasterLoadoutAttachments, "secondary")
	local f147_local11 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f147_arg2), "secondaryWeapon.indexIndex")
	f147_local8 = f147_local11:get()
	if f147_local8 ~= nil then
		f147_local10.CodCasterLoadoutModuleSecondaryWeapon.CodCasterLoadoutSelection.ItemName:setText(Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f147_local8, Enum[0x6EB546760F890D2][0x569E84652131CD7], Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])))
	end
end
CoD.CodCasterUtility.ClearSelectedLoadoutElement = function(f148_arg0, f148_arg1, f148_arg2)
	local f148_local0 = f148_arg0
	local f148_local1 = f148_arg1
	local f148_local2 = f148_local0.CodCasterLoadoutTalents
	CoD.CodCasterUtility.ClearLoadoutListSelection(f148_local2.CodCasterLoadoutModuleEquipment.CodCasterLoadoutEquipmentList)
	CoD.CodCasterUtility.ClearLoadoutListSelection(f148_local2.CodCasterLoadoutModulePerk.CodCasterLoadoutPerkList)
	CoD.CodCasterUtility.ClearLoadoutListSelection(f148_local2.CodCasterLoadoutModulePerkWildcard.CodCasterLoadoutWildcardList)
	local f148_local3 = f148_local1:getParent()
	local f148_local4 = f148_local3.T7HudMenuGameMode.HudMPSafeAreaContainer.AmmoWidgetMPUltimate
	f148_local4.HealCooldown.CodCasterLoadoutSelection:setAlpha(0)
	f148_local4.CodCasterLoadoutSelection:setAlpha(0)
	f148_local4.AmmoWidgetMPAbilityItem.CodCasterLoadoutSelection:setAlpha(0)
	local f148_local5 = f148_local0.CodCasterLoadoutPrimary
	CoD.CodCasterUtility.ClearLoadoutListSelection(f148_local5.CodCasterLoadoutModulePrimaryWildcard.CodCasterLoadoutWildcards)
	CoD.CodCasterUtility.ClearLoadoutListSelection(f148_local5.CodCasterLoadoutModulePrimaryAttachments.CodCasterLoadoutAttachments)
	f148_local5.CodCasterLoadoutModulePrimaryWeapon.CodCasterLoadoutSelection:setAlpha(0)
	local f148_local6 = f148_local0.CodCasterLoadoutSecondary
	CoD.CodCasterUtility.ClearLoadoutListSelection(f148_local6.CodCasterLoadoutModuleSecondaryWildcard.CodCasterLoadoutWildcards)
	CoD.CodCasterUtility.ClearLoadoutListSelection(f148_local6.CodCasterLoadoutModuleSecondaryAttachments.CodCasterLoadoutAttachments)
	f148_local6.CodCasterLoadoutModuleSecondaryWeapon.CodCasterLoadoutSelection:setAlpha(0)
end
CoD.CodCasterUtility.GetSelectedLoadoutElement = function(f149_arg0, f149_arg1, f149_arg2)
	local f149_local0 = CoD.CodCasterUtility.GetLoadoutElementsVisibility(f149_arg2)
	local f149_local1, f149_local2, f149_local3, f149_local4, f149_local5, f149_local6 = nil
	local f149_local7 = CoD.CodCasterUtility.LoadoutLocation.NONE
	local f149_local8 = f149_arg0.CodCasterLoadoutTalents
	local f149_local9 = f149_local8.CodCasterLoadoutModuleEquipment.CodCasterLoadoutEquipmentList
	local f149_local10 = f149_local8.CodCasterLoadoutModulePerk.CodCasterLoadoutPerkList
	local f149_local11 = f149_local8.CodCasterLoadoutModulePerkWildcard.CodCasterLoadoutWildcardList
	local f149_local12, f149_local13, f149_local14, f149_local15, f149_local16 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.TALENT_EQUIPMENT, f149_local9, f149_local6, f149_local1, f149_local2, f149_local3, f149_local7)
	f149_local12, f149_local13, f149_local14, f149_local15, f149_local16 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.TALENT_PERK, f149_local10, f149_local12, f149_local14, f149_local15, f149_local16, f149_local13)
	f149_local6, f149_local7, f149_local1, f149_local2, f149_local3 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.TALENT_WILDCARD, f149_local11, f149_local12, f149_local14, f149_local15, f149_local16, f149_local13)
	f149_local12 = f149_arg1:getParent()
	f149_local15 = f149_local12.T7HudMenuGameMode.HudMPSafeAreaContainer.AmmoWidgetMPUltimate
	local f149_local16, f149_local17, f149_local18, f149_local19, f149_local20 = CoD.CodCasterUtility.GetLoadoutSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.MID_HEAL, f149_local15.HealCooldown, f149_local6, f149_local1, f149_local2, f149_local3, f149_local7)
	f149_local16, f149_local17, f149_local18, f149_local19, f149_local20 = CoD.CodCasterUtility.GetLoadoutSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.MID_ULTIMATE, f149_local15, f149_local16, f149_local18, f149_local19, f149_local20, f149_local17)
	f149_local6, f149_local7, f149_local1, f149_local2, f149_local3 = CoD.CodCasterUtility.GetLoadoutSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.MID_ABILITY, f149_local15.AmmoWidgetMPAbilityItem, f149_local16, f149_local18, f149_local19, f149_local20, f149_local17)
	f149_local16 = f149_arg0.CodCasterLoadoutPrimary
	f149_local17 = f149_arg0.CodCasterLoadoutSecondary
	local f149_local18, f149_local19, f149_local20, f149_local21, f149_local22, f149_local23 = nil
	if CoD.CodCasterUtility.IsPrimaryWeaponOnHand(f149_arg2) then
		f149_local18 = f149_local16.CodCasterLoadoutModulePrimaryWildcard.CodCasterLoadoutWildcards
		f149_local19 = f149_local16.CodCasterLoadoutModulePrimaryAttachments.CodCasterLoadoutAttachments
		f149_local20 = f149_local16.CodCasterLoadoutModulePrimaryWeapon
		f149_local21 = f149_local17.CodCasterLoadoutModuleSecondaryWildcard.CodCasterLoadoutWildcards
		f149_local22 = f149_local17.CodCasterLoadoutModuleSecondaryAttachments.CodCasterLoadoutAttachments
		f149_local23 = f149_local17.CodCasterLoadoutModuleSecondaryWeapon
	else
		f149_local18 = f149_local17.CodCasterLoadoutModuleSecondaryWildcard.CodCasterLoadoutWildcards
		f149_local19 = f149_local17.CodCasterLoadoutModuleSecondaryAttachments.CodCasterLoadoutAttachments
		f149_local20 = f149_local17.CodCasterLoadoutModuleSecondaryWeapon
		f149_local21 = f149_local16.CodCasterLoadoutModulePrimaryWildcard.CodCasterLoadoutWildcards
		f149_local22 = f149_local16.CodCasterLoadoutModulePrimaryAttachments.CodCasterLoadoutAttachments
		f149_local23 = f149_local16.CodCasterLoadoutModulePrimaryWeapon
	end
	local f149_local24, f149_local25, f149_local26, f149_local27, f149_local28 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.ONHAND_WILDCARD, f149_local18, f149_local6, f149_local1, f149_local2, f149_local3, f149_local7)
	f149_local24, f149_local25, f149_local26, f149_local27, f149_local28 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.ONHAND_ATTACHMENT, f149_local19, f149_local24, f149_local26, f149_local27, f149_local28, f149_local25)
	f149_local6, f149_local7, f149_local1, f149_local2, f149_local3 = CoD.CodCasterUtility.GetLoadoutSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.ONHAND_WEAPON, f149_local20, f149_local24, f149_local26, f149_local27, f149_local28, f149_local25)
	f149_local24 = f149_local2
	if f149_local6 == nil then
		local f149_local25, f149_local26, f149_local27, f149_local28, f149_local29 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WILDCARD, f149_local21, f149_local6, f149_local4, nil, nil, f149_local7)
		f149_local25, f149_local26, f149_local27, f149_local28, f149_local29 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.OFFHAND_ATTACHMENT, f149_local22, f149_local25, f149_local27, f149_local28, f149_local29, f149_local26)
		f149_local6, f149_local7, f149_local4, f149_local2, f149_local3 = CoD.CodCasterUtility.GetLoadoutSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WEAPON, f149_local23, f149_local25, f149_local27, f149_local28, f149_local29, f149_local26)
		if f149_local6 ~= nil then
			f149_local4 = f149_local6
			local f149_local29, f149_local30, f149_local31, f149_local32, f149_local33 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.ONHAND_WILDCARD, f149_local18, nil, nil, f149_local5, nil, nil)
			f149_local29, f149_local30, f149_local31, f149_local32, f149_local33 = CoD.CodCasterUtility.GetLoadoutListSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.ONHAND_ATTACHMENT, f149_local19, f149_local29, f149_local31, f149_local32, f149_local33, f149_local30)
			f149_local25, f149_local26, f149_local27, f149_local5, f149_local28 = CoD.CodCasterUtility.GetLoadoutSelection(f149_local0, CoD.CodCasterUtility.LoadoutLocation.ONHAND_WEAPON, f149_local20, f149_local29, f149_local31, f149_local32, f149_local33, f149_local30)
		else
			f149_local2 = f149_local1
			f149_local3 = f149_local24
			f149_local5 = f149_local1
		end
	elseif f149_local7 == CoD.CodCasterUtility.LoadoutLocation.ONHAND_WILDCARD or f149_local7 == CoD.CodCasterUtility.LoadoutLocation.ONHAND_ATTACHMENT or f149_local7 == CoD.CodCasterUtility.LoadoutLocation.ONHAND_WEAPON then
		f149_local4 = CoD.CodCasterUtility.GetLeftMostOffhandItem(f149_arg2, f149_local21, f149_local22, f149_local23)
	end
	if (f149_local7 == CoD.CodCasterUtility.LoadoutLocation.MID_ABILITY or f149_local7 == CoD.CodCasterUtility.LoadoutLocation.ONHAND_ATTACHMENT or f149_local7 == CoD.CodCasterUtility.LoadoutLocation.ONHAND_WILDCARD) and f149_local3 == nil then
		f149_local3 = CoD.CodCasterUtility.GetLeftMostOffhandItem(f149_arg2, f149_local21, f149_local22, f149_local23)
	end
	if (f149_local7 == CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WILDCARD or f149_local7 == CoD.CodCasterUtility.LoadoutLocation.OFFHAND_ATTACHMENT or f149_local7 == CoD.CodCasterUtility.LoadoutLocation.OFFHAND_WEAPON) and f149_local2 == nil then
		f149_local2 = CoD.CodCasterUtility.GetRightMostOnhandItem(f149_arg2, f149_local18, f149_local19, f149_local15.AmmoWidgetMPAbilityItem)
	end
	return f149_local2, f149_local3, f149_local4, f149_local5
end
CoD.CodCasterUtility.NavigateLoadoutLeft = function(f150_arg0, f150_arg1, f150_arg2)
	local f150_local0, f150_local1, f150_local2, f150_local3 = CoD.CodCasterUtility.GetSelectedLoadoutElement(f150_arg0, f150_arg1, f150_arg2)
	if f150_local0 ~= nil then
		CoD.CodCasterUtility.ClearSelectedLoadoutElement(f150_arg0, f150_arg1, f150_arg2)
		f150_local0.CodCasterLoadoutSelection:setAlpha(1)
		CoD.CodCasterUtility.SetLoadoutElementsText(f150_arg0, f150_arg1, f150_arg2)
	end
end
CoD.CodCasterUtility.NavigateLoadoutRight = function(f151_arg0, f151_arg1, f151_arg2)
	local f151_local0, f151_local1, f151_local2, f151_local3 = CoD.CodCasterUtility.GetSelectedLoadoutElement(f151_arg0, f151_arg1, f151_arg2)
	if f151_local1 ~= nil then
		CoD.CodCasterUtility.ClearSelectedLoadoutElement(f151_arg0, f151_arg1, f151_arg2)
		f151_local1.CodCasterLoadoutSelection:setAlpha(1)
		CoD.CodCasterUtility.SetLoadoutElementsText(f151_arg0, f151_arg1, f151_arg2)
	end
end
CoD.CodCasterUtility.NavigateLoadoutUp = function(f152_arg0, f152_arg1, f152_arg2)
	local f152_local0, f152_local1, f152_local2, f152_local3 = CoD.CodCasterUtility.GetSelectedLoadoutElement(f152_arg0, f152_arg1, f152_arg2)
	if f152_local2 ~= nil then
		CoD.CodCasterUtility.ClearSelectedLoadoutElement(f152_arg0, f152_arg1, f152_arg2)
		f152_local2.CodCasterLoadoutSelection:setAlpha(1)
		CoD.CodCasterUtility.SetLoadoutElementsText(f152_arg0, f152_arg1, f152_arg2)
	end
end
CoD.CodCasterUtility.NavigateLoadoutDown = function(f153_arg0, f153_arg1, f153_arg2)
	local f153_local0, f153_local1, f153_local2, f153_local3 = CoD.CodCasterUtility.GetSelectedLoadoutElement(f153_arg0, f153_arg1, f153_arg2)
	if f153_local3 ~= nil then
		CoD.CodCasterUtility.ClearSelectedLoadoutElement(f153_arg0, f153_arg1, f153_arg2)
		f153_local3.CodCasterLoadoutSelection:setAlpha(1)
		CoD.CodCasterUtility.SetLoadoutElementsText(f153_arg0, f153_arg1, f153_arg2)
	end
end
CoD.CodCasterUtility.HealthColor = function(f154_arg0)
	local f154_local0 = {
		r = 1,
		g = 1,
		b = 1,
	}
	if f154_arg0 == 0 then
		f154_local0 = ColorSet.WoundBar
	elseif f154_arg0 >= 151 then
		f154_local0 = ColorSet.CleanseBar
	end
	return f154_local0.r, f154_local0.g, f154_local0.b
end
CoD.CodCasterUtility.CurrentSpectatedTeamEqualTo = function(f155_arg0, f155_arg1)
	local f155_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f155_arg0), "deadSpectator.playerTeam")
	return f155_local0:get() == f155_arg1
end
CoD.CodCasterUtility.IsSelfNext = function(f156_arg0, f156_arg1)
	local f156_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f156_arg1), "hudItems.codcaster.nextClient")
	local f156_local1 = f156_arg0:getModel(f156_arg1, "clientNum")
	return f156_local0:get() == f156_local1:get()
end
CoD.CodCasterUtility.ToggleCodCasterProfileValue = function(f157_arg0, f157_arg1)
	if not CoD.ShoutcasterProfileVarBool(f157_arg0, f157_arg1) then
		CoD.SetShoutcasterProfileVarValue(f157_arg0, f157_arg1, 1)
	else
		CoD.SetShoutcasterProfileVarValue(f157_arg0, f157_arg1, 0)
	end
	if Engine[0x7B48C1ABFF0F764]() and f157_arg1 == "shoutcaster_ds_thirdperson" then
		Engine[0xB81A5136C5503E4](f157_arg0, "shoutcaster_thirdperson " .. CoD.ShoutcasterProfileVarValue(f157_arg0, f157_arg1))
	end
end
CoD.CodCasterUtility.ForcePortraitUpdate = function(f158_arg0, f158_arg1)
	local f158_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f158_arg0:getModel(), "clientNum"))
	f158_arg0.CodCasterPortraitPlayerListEntryExtra.PlayerListEntryKD:setText(GetCodcasterPlayerListKD(f158_arg1, f158_local0))
	f158_arg0.ObjectiveStatus.ObjectiveStatusImage:setImage(RegisterImage(GetPlayerListObjectiveMinimapImage(f158_arg1, f158_local0)))
end
CoD.CodCasterUtility.ForcePlayerListEntryUpdate = function(f159_arg0, f159_arg1)
	local f159_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f159_arg0:getModel(), "clientNum"))
	f159_arg0.Score01:setText(GetCodcasterPlayerListKD(f159_arg1, f159_local0))
	f159_arg0.ObjectiveStatus.ObjectiveStatusImage:setImage(RegisterImage(GetPlayerListObjectiveMinimapImage(f159_arg1, f159_local0)))
end
CoD.CodCasterUtility.SetFocusToFirstSelectableItemInButtonList = function(f160_arg0, f160_arg1)
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f160_arg1.ButtonList)
end
CoD.CodCasterUtility.InitScores = function(f161_arg0, f161_arg1)
	f161_arg0.teamleft.score:setText(0)
	f161_arg0.teamleft.score2:setText(0)
	f161_arg0.teamright.score:setText(0)
	f161_arg0.teamright.score2:setText(0)
	local f161_local0, f161_local1 = nil
	if CoD.AARUtility.IsGameTypeEqualToString("escort", f161_arg1) then
		local f161_local2 = Engine[0x8DF2E5447F384B9]()
		f161_local0 = f161_local2.hudItems.team1.roundsWon
		f161_local2 = Engine[0x8DF2E5447F384B9]()
		f161_local1 = f161_local2.hudItems.team2.roundsWon
	else
		local f161_local2 = Engine[0x4DF5CFBC1771947](f161_arg1)
		f161_local0 = f161_local2.GameScore.alliesScore
		f161_local2 = Engine[0x4DF5CFBC1771947](f161_arg1)
		f161_local1 = f161_local2.GameScore.axisScore
	end
	f161_arg0.teamleft:subscribeToModel(f161_local0, function(model)
		local f162_local0 = model:get()
		if f162_local0 ~= nil then
			f161_arg0.teamleft.score:setText(f162_local0)
			f161_arg0.teamleft.score2:setText(f162_local0)
		end
	end, false)
	f161_arg0.teamright:subscribeToModel(f161_local1, function(model)
		local f163_local0 = model:get()
		if f163_local0 ~= nil then
			f161_arg0.teamright.score:setText(f163_local0)
			f161_arg0.teamright.score2:setText(f163_local0)
		end
	end, false)
end
CoD.CodCasterUtility.ScoreByGametype = function(f164_arg0, f164_arg1)
	local f164_local0 = f164_arg1
	if CoD.CodCasterUtility.IsGameTypeOrHCVariant("sd") then
		local f164_local1 = Engine[0xE4D2F32833CFA6C](f164_local0)
		f164_local1 = f164_local1["scoreboard.footer1"]
		local f164_local2 = Engine[0xE4D2F32833CFA6C](f164_local0)
		f164_local2 = f164_local2["scoreboard.footer2"]
		local f164_local3 = 0
		if f164_local1 ~= nil then
			f164_local3 = f164_local1:get()
		end
		local f164_local4 = 0
		if f164_local2 ~= nil then
			f164_local4 = f164_local2:get()
		end
		return f164_local3 .. "/" .. f164_local4
	elseif CoD.CodCasterUtility.IsGameTypeOrHCVariant("tdm") then
		local f164_local1 = Engine[0xE4D2F32833CFA6C](f164_local0)
		f164_local1 = f164_local1["scoreboard.damageDone"]
		local f164_local2 = nil
		if f164_local1 ~= nil then
			f164_local2 = f164_local1:get()
		end
		if f164_local2 ~= nil then
			return f164_local2
		end
	end
	local f164_local1 = Engine[0xE4D2F32833CFA6C](f164_local0)
	f164_local1 = f164_local1["scoreboard.col2"]
	local f164_local2 = 0
	if f164_local1 ~= nil then
		f164_local2 = f164_local1:get()
	end
	return f164_local2
end
CoD.CodCasterUtility.ScoreByGametypeInit = function(f165_arg0)
	if f165_arg0.InitDone then
		return
	elseif CoD.CodCasterUtility.IsGameTypeOrHCVariant("sd") then
		f165_arg0:setText("0/0")
	else
		f165_arg0:setText("0")
	end
	f165_arg0.InitDone = true
end
CoD.CodCasterUtility.IsGameTypeOrHCVariant = function(f166_arg0)
	local f166_local0 = Engine[0x6F8027A8BC75673]()
	if f166_local0 == f166_arg0 or f166_local0 == f166_arg0 .. "_hc" then
		return true
	else
		return false
	end
end
DataSources.CodCasterDirectorSettingsTabs = ListHelper_SetupDataSource("CodCasterDirectorSettingsTabs", function(f167_arg0)
	local f167_local0 = {}
	table.insert(f167_local0, {
		models = {
			tabName = 0x4EA93CFFE505B27,
			tabWidget = "CoD.DirectorCodCasterQuickSettings",
			tabIcon = "",
		},
		properties = {
			tabId = "quick_settings",
		},
	})
	table.insert(f167_local0, {
		models = {
			tabName = 0xE2311AD89D11E7C,
			tabWidget = "CoD.DirectorCodCasterDisplaySettings",
			tabIcon = "",
		},
		properties = {
			tabId = "display_settings",
			optionCategoriesTable = CoD.CodCasterUtility.CodCasterSettings.DisplaySettingsCategories,
		},
	})
	table.insert(f167_local0, {
		models = {
			tabName = 0xDC89C646FCB3342,
			tabWidget = "CoD.DirectorCodCasterLoadoutSettings",
			tabIcon = "",
		},
		properties = {
			tabId = "loadout_settings",
			optionCategoriesTable = CoD.CodCasterUtility.CodCasterSettings.LoadoutSettingsCategories,
		},
	})
	table.insert(f167_local0, {
		models = {
			tabName = 0x4D1595123C780BD,
			tabWidget = "CoD.DirectorCodCasterTeamSettings",
			tabIcon = "",
		},
		properties = {
			tabId = "team_settings",
			optionCategoriesTable = CoD.CodCasterUtility.CodCasterSettings.TeamSettingsCategories,
		},
	})
	return f167_local0
end, true)
CoD.CodCasterUtility.ResetPlayerSettingsCategoryListToDefault = function(f168_arg0, f168_arg1)
	for f168_local10, f168_local11, f168_local12 in f168_arg1:forEachElement() do
		local f168_local13 = f168_local12:getModel()
		local f168_local3 = f168_local13.optionsListDatasource
		if f168_local3 then
			f168_local3 = f168_local13.optionsListDatasource:get()
		end
		if f168_local3 then
			local f168_local4 = DataSources[f168_local3]._gameSettingListName
			if f168_local4 then
				for f168_local8, f168_local9 in ipairs(Engine[0xA7E3CD65E63086F](f168_local4)) do
					CoD.SetShoutcasterProfileVarValue(f168_arg0, f168_local9[0x6E183377E0C37F4], CoD.OptionsUtility.GetPlayerSettingDefaultValueFromOptionInfo(f168_arg0, f168_local9))
				end
			end
		end
	end
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Update"))
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Reset"))
end
CoD.CodCasterUtility.ShouldShowOverheadInfo = function(f169_arg0, f169_arg1, f169_arg2)
	local f169_local0 = false
	local f169_local1 = f169_arg0:getModel(f169_arg1, "team")
	local f169_local2 = f169_local1:get()
	local f169_local3 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f169_arg1), "deadSpectator.playerTeam")
	if f169_local2 == f169_local3:get() then
		f169_local0 = IsCodCasterProfileValueEqualTo(f169_arg1, f169_arg2 .. "_allies", 1)
	else
		f169_local0 = IsCodCasterProfileValueEqualTo(f169_arg1, f169_arg2 .. "_enemies", 1)
	end
	return f169_local0
end
CoD.CodCasterUtility.PreLoadCodCasterTeamSettings = function(f170_arg0, f170_arg1)
	local f170_local0 = Engine[0xA798E4552F5E872](DataSources.TeamIdentity.getModel(f170_arg1), "team")
	if not Engine[0x614D394F6F9A18D](f170_local0) then
		Engine[0x83C9B5DE1D9371](f170_local0, "team")
	end
	CoD.CodCasterUtility.UpdateTeamIdentity(f170_arg0, f170_arg1)
end
CoD.CodCasterUtility.UpdateTeamIdentity = function(f171_arg0, f171_arg1, f171_arg2)
	CoD.SetupTeamIdentityInformation(f171_arg0, f171_arg1, "team1")
	CoD.SetupTeamIdentityInformation(f171_arg0, f171_arg1, "team2")
	if f171_arg2 then
		Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Update"))
		Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Reset"))
	end
end
CoD.CodCasterUtility.OpenCodCasterEditTeamSettings = function(f172_arg0, f172_arg1, f172_arg2)
	local f172_local0 = function(f173_arg0, f173_arg1)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](DataSources.TeamIdentity.getModel(f173_arg0), "team"), f173_arg1)
	end
	f172_local0(f172_arg2, f172_arg1.actionTeam)
	OpenPopup(f172_arg0, "DirectorCodCasterTeamIdentitySettings", f172_arg2)
end
CoD.CodCasterUtility.IsSelfOrSpectatedClient = function(f174_arg0, f174_arg1)
	local f174_local0 = LuaDefine.INVALID_CLIENT_INDEX
	if IsCodCaster(f174_arg0) then
		local f174_local1 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f174_arg0), "deadSpectator.playerIndex")
		f174_local0 = f174_local1:get()
	else
		f174_local0 = CoD.AARUtility.GetInGameClientNum(f174_arg0)
	end
	return f174_local0 == CoD.SafeGetModelValue(f174_arg1:getModel(), "clientNum")
end
CoD.CodCasterUtility.ScoreboardSetFocus = function(f175_arg0, f175_arg1)
	if IsCodCaster(f175_arg1) then
		local f175_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f175_arg1), "deadSpectator.playerIndex")
		local f175_local1 = f175_local0:get()
		local f175_local2 = f175_arg0.YourTeamScores:findItem({
			clientNum = f175_local1,
		}, nil, true, nil)
		local f175_local3 = f175_arg0.EnemyTeamScores:findItem({
			clientNum = f175_local1,
		}, nil, true, nil)
		local f175_local4 = LuaDefine.INVALID_CLIENT_INDEX
		if f175_local2 ~= nil then
			f175_local4 = f175_local2:getModel()
			f175_local2:processEvent({
				name = "gain_focus",
				controller = f175_arg1,
			})
			f175_local2._readyForCustomFocus = true
		elseif f175_local3 ~= nil then
			f175_local4 = f175_local3:getModel()
			f175_local3:processEvent({
				name = "gain_focus",
				controller = f175_arg1,
			})
			f175_local3._readyForCustomFocus = true
		end
		local f175_local5 = Engine[0x4DF5CFBC1771947](f175_arg1)
		if f175_local5.currentFocusedClient and f175_local4 ~= LuaDefine.INVALID_CLIENT_INDEX then
			f175_local5.currentFocusedClient:set(f175_local4)
		end
	end
end
CoD.CodCasterUtility.TeamSettings_RenameTeam = function(f176_arg0, f176_arg1)
	local f176_local0 = Engine[0x4DF5CFBC1771947](f176_arg1)
	f176_local0 = f176_local0.RenameEmblemText:get()
	if not Engine[0xE3FC4BECF450A06](f176_arg1, f176_local0, Enum[0x85FCE2AA5391A7C][0x24364F159D318D1]) then
		local f176_local1 = f176_arg0:getModel(f176_arg1, "inputText")
		if f176_local1 then
			Engine[0x83C9B5DE1D9371](f176_local1, f176_local0)
		end
		local f176_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.TeamIdentity.getModel(f176_arg1), "team"))
		local f176_local3 = Engine[0x40E824FE270E174](DataSources.TeamIdentityInformation.getModel(f176_arg1, f176_local2), "teamName")
		local f176_local4 = "shoutcaster_fe_" .. f176_local2 .. "_name"
		if f176_local3 then
			Engine[0x83C9B5DE1D9371](f176_local3, f176_local0)
			CoD.SetShoutcasterProfileVarValue(f176_arg1, f176_local4, f176_local0)
		end
	end
end
CoD.CodCasterUtility.OpenResetCodCasterSettingsPopup = function(f177_arg0, f177_arg1, f177_arg2, f177_arg3, f177_arg4)
	f177_arg4:saveState(f177_arg2)
	local f177_local0 = CoD.OverlayUtility.CreateOverlay(f177_arg2, f177_arg0, "ResetCodCasterSettingsPC", f177_arg4.menuName)
	f177_local0:setPriority(400)
end
CoD.CodCasterUtility.ResetCodcasterSettingsGamepad = function(f178_arg0, f178_arg1)
	if f178_arg1 then
		CoD.CodCasterUtility.ResetCodcasterSettings(f178_arg0, f178_arg1.menuName)
	end
end
CoD.CodCasterUtility.ResetCodcasterSettings = function(f179_arg0, f179_arg1)
	if f179_arg0 and f179_arg1 then
		if f179_arg1 == "DirectorCodCasterSettings" then
			CoD.CodCasterUtility.ResetCodCasterSettingsDefault(f179_arg0, CoD.CodCasterUtility.CodCasterSettings.QuickSettingsCategories)
			CoD.CodCasterUtility.ResetCodCasterSettingsDefault(f179_arg0, CoD.CodCasterUtility.CodCasterSettings.DisplaySettingsCategories)
			CoD.CodCasterUtility.ResetCodCasterSettingsDefault(f179_arg0, CoD.CodCasterUtility.CodCasterSettings.LoadoutSettingsCategories)
			CoD.CodCasterUtility.ResetCodCasterSettingsDefault(f179_arg0, CoD.CodCasterUtility.CodCasterSettings.TeamSettingsCategories)
		elseif f179_arg1 == "CodCasterQuickSettingsSideBar" then
			CoD.CodCasterUtility.ResetCodCasterSettingsDefault(f179_arg0, CoD.CodCasterUtility.CodCasterSettings.QuickSettingsCategories)
		elseif f179_arg1 == "CodCasterSettingsSideBar" then
			CoD.CodCasterUtility.ResetCodCasterSettingsDefault(f179_arg0, CoD.CodCasterUtility.CodCasterSettings.DisplaySettingsCategories)
			CoD.CodCasterUtility.ResetCodCasterSettingsDefault(f179_arg0, CoD.CodCasterUtility.CodCasterSettings.LoadoutSettingsCategories)
		end
	end
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Update"))
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Reset"))
end
CoD.CodCasterUtility.ResetCodCasterSettingsDefault = function(f180_arg0, f180_arg1)
	for f180_local0 = 1, #f180_arg1, 1 do
		local f180_local3 = f180_arg1[f180_local0].gameSettingListName
		if f180_local3 then
			for f180_local7, f180_local8 in ipairs(Engine[0xA7E3CD65E63086F](f180_local3)) do
				CoD.SetShoutcasterProfileVarValue(f180_arg0, f180_local8[0x6E183377E0C37F4], CoD.OptionsUtility.GetPlayerSettingDefaultValueFromOptionInfo(f180_arg0, f180_local8))
				CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f180_arg0, f180_local8[0x4BCADBA8E631B86])
				if Engine[0x7B48C1ABFF0F764]() and f180_local8[0x6E183377E0C37F4] == "shoutcaster_ds_thirdperson" then
					Engine[0xB81A5136C5503E4](f180_arg0, "shoutcaster_thirdperson " .. CoD.ShoutcasterProfileVarValue(f180_arg0, f180_local8[0x6E183377E0C37F4]))
				end
			end
		end
	end
end
CoD.CodCasterUtility.GetObituaryPlayerTeamColor = function(f181_arg0, f181_arg1)
	if CoD.IsShoutcaster(f181_arg0) then
		return TeamColorFromPlayerIndex(f181_arg0, f181_arg1)
	else
		return ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b
	end
end
CoD.CodCasterUtility.ForceListDataSourceUpdate = function(f182_arg0, f182_arg1)
	if CoD.CodCasterUtility.IsCodCasterOrAssigned(f182_arg0) and not IsGametypeTeambased() then
		f182_arg1.menu:addElement(LUI.UITimer.newElementTimer(500, false, function()
			f182_arg1:updateDataSource(true, true)
		end))
	end
end
CoD.CodCasterUtility.CodcasterTeamIdentityShowingTeamSetting = function(f184_arg0, f184_arg1)
	local f184_local0 = CoD.isPC and f184_arg1.categoryTabsListPC.savedActiveIndex or f184_arg1.categoryTabsList.savedActiveIndex
	if f184_local0 == nil then
		return false
	else
		return f184_local0 == 3
	end
end
CoD.CodCasterUtility.UseCustomTeamIdentity = function(f185_arg0)
	return CoD.ShoutcasterProfileVarBool(f185_arg0, "shoutcaster_fe_team_identity")
end
CoD.CodCasterUtility.GetAllShoutcasterProfileVar = function(f186_arg0, f186_arg1)
	return CoD.ShoutcasterProfileVarValue(f186_arg0, "shoutcaster_fe_" .. f186_arg1 .. "_color"), CoD.ShoutcasterProfileVarValue(f186_arg0, "shoutcaster_fe_" .. f186_arg1 .. "_icon"), CoD.ShoutcasterProfileVarValue(f186_arg0, "shoutcaster_fe_" .. f186_arg1 .. "_name")
end
CoD.CodCasterUtility.SetAllShoutcasterProfileVar = function(f187_arg0, f187_arg1, f187_arg2, f187_arg3, f187_arg4)
	CoD.SetShoutcasterProfileVarValue(f187_arg0, "shoutcaster_fe_" .. f187_arg1 .. "_color", f187_arg2)
	CoD.SetShoutcasterProfileVarValue(f187_arg0, "shoutcaster_fe_" .. f187_arg1 .. "_icon", f187_arg3)
	CoD.SetShoutcasterProfileVarValue(f187_arg0, "shoutcaster_fe_" .. f187_arg1 .. "_name", f187_arg4)
end
CoD.CodCasterUtility.SwapTeamIdentity = function(f188_arg0, f188_arg1)
	if CoD.ShoutcasterProfileVarBool(f188_arg1, "shoutcaster_fe_team_identity") then
		local f188_local0, f188_local1, f188_local2 = CoD.CodCasterUtility.GetAllShoutcasterProfileVar(f188_arg1, "team1")
		local f188_local3, f188_local4, f188_local5 = CoD.CodCasterUtility.GetAllShoutcasterProfileVar(f188_arg1, "team2")
		CoD.CodCasterUtility.SetAllShoutcasterProfileVar(f188_arg1, "team1", f188_local3, f188_local4, f188_local5)
		CoD.CodCasterUtility.SetAllShoutcasterProfileVar(f188_arg1, "team2", f188_local0, f188_local1, f188_local2)
		CoD.CodCasterUtility.UpdateTeamIdentity(f188_arg0, f188_arg1, true)
		Engine[0x28A466EF7723621](f188_arg1, Enum[0xBBD4F9E70101BA8][0xED1503A2D3DAE6])
	end
end
CoD.CodCasterUtility.HandleListenInForPlayer = function(f189_arg0, f189_arg1)
	if not CoD.ShoutcasterProfileVarBool(f189_arg0, "shoutcaster_qs_listen_in") then
		return
	elseif f189_arg1 < 0 then
		return
	end
	local f189_local0 = Engine[0x2C6B07FD023877B](f189_arg0, f189_arg1)
	if f189_local0 ~= -1 then
		Engine[0x7C75E608EA39B5C](f189_arg0, "shoutcastSetListenInTeam " .. f189_local0)
	end
end
CoD.CodCasterUtility.HandleListenInForProfileChange = function(f190_arg0)
	if not CoD.ShoutcasterProfileVarBool(f190_arg0, "shoutcaster_qs_listen_in") then
		Engine[0x7C75E608EA39B5C](f190_arg0, "shoutcastSetListenInTeam " .. Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC])
		return
	end
	local f190_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f190_arg0), "deadSpectator.playerIndex")
	if f190_local0 then
		CoD.CodCasterUtility.HandleListenInForPlayer(f190_arg0, Engine[0x614D394F6F9A18D](f190_local0))
	end
end
CoD.CodCasterUtility.PostLoadFunc = function(f191_arg0, f191_arg1, f191_arg2)
	if CoD.isPC then
		f191_arg0:processEvent({
			name = "input_source_changed",
			controller = f191_arg1,
		})
	end
	f191_arg0:subscribeToModel(Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f191_arg1), "deadSpectator.playerIndex"), function(model)
		CoD.CodCasterUtility.HandleListenInForPlayer(f191_arg1, Engine[0x614D394F6F9A18D](model))
	end)
	f191_arg0:subscribeToModel(Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f191_arg1), "CodCaster.profileSettingsUpdated"), function(model)
		CoD.CodCasterUtility.HandleListenInForProfileChange(f191_arg1)
	end)
	f191_arg0:subscribeToModel(Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f191_arg1), "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]), function(model)
		f191_arg0:processEvent({
			name = "gain_focus",
			controller = f191_arg1,
		})
		f191_arg0:gainFocus({
			controller = f191_arg1,
		})
	end)
end
