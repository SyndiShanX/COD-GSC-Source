CoD.TeamUtility = {}
CoD.TeamUtility.TeamName = {}
CoD.TeamUtility.TeamName[Enum[@"team_t"][@"team_free"]] = @"mpui/autoassign"
CoD.TeamUtility.TeamName[Enum[@"team_t"][@"team_neutral"]] = @"mpui/neutral"
CoD.TeamUtility.TeamName[Enum[@"team_t"][@"team_spectator"]] = @"mpui/shoutcaster"
if not CoD.isMultiplayer then
	CoD.TeamUtility.TeamName[Enum[@"team_t"][@"team_neutral"]] = @"mpui/neutral"
	CoD.TeamUtility.TeamName[Enum[@"team_t"][@"team_dead"]] = @"hash_3E283EA5896DD5A6"
end
CoD.TeamUtility.GetTeam = function(f1_arg0)
	if IsCodCaster(f1_arg0) then
		return CoD.ShoutcasterProfileVarValue(f1_arg0, "shoutcaster_team")
	else
		return Engine[@"getlobbyteamid"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"getclientnum"](f1_arg0))
	end
end
CoD.TeamUtility.GetTeams = function()
	CoD.TeamUtility.Teams = {}
	local f2_local0 = Engine[@"getteams"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	local f2_local1 = {}
	for f2_local5, f2_local6 in pairs(f2_local0.clientTeams) do
		if not f2_local1[f2_local6.team] and CoD.TeamUtility.IsValidPlayerTeam(f2_local6.team) then
			f2_local1[f2_local6.team] = true
			table.insert(CoD.TeamUtility.Teams, f2_local6.team)
		end
	end
	return CoD.TeamUtility.Teams
end
CoD.TeamUtility.ShouldUseCustomTeamIdentity = function(f3_arg0)
	if not CoD.CodCasterUtility.IsCodCasterOrAssigned(f3_arg0) then
		return false
	elseif not CoDShared.IsGametypeTeamBased() then
		return false
	elseif not CoD.ShoutcasterProfileVarBool(f3_arg0, "shoutcaster_fe_team_identity") then
		return false
	else
		return true
	end
end
CoD.TeamUtility.ShouldUseBlankTeamIdentity = function(f4_arg0)
	if not CoD.IsShoutcaster(f4_arg0) then
		return false
	elseif not CoDShared.IsGametypeTeamBased() then
		return false
	elseif CoD.ShoutcasterProfileVarBool(f4_arg0, "shoutcaster_ds_team_identity") then
		return false
	else
		return true
	end
end
CoD.TeamUtility.GetDefaultCodCasterTeamName = function(f5_arg0)
	if f5_arg0 == "team2" then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_139A9E427416E0C7")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_139A9F427416E27A")
	end
end
CoD.TeamUtility.IsValidPlayerTeam = function(f6_arg0, f6_arg1)
	if not f6_arg0 then
		return false
	elseif CoDShared.IsGametypeTeamBased(f6_arg1) then
		local f6_local0 = {
			[Enum[@"team_t"][@"team_allies"]] = true,
			[Enum[@"team_t"][@"team_axis"]] = true,
		}
		return f6_local0[f6_arg0] ~= nil
	else
		local f6_local0
		if f6_arg0 <= Enum[@"team_t"][@"team_free"] or f6_arg0 >= Enum[@"team_t"][@"team_spectator"] then
			f6_local0 = false
		else
			f6_local0 = true
		end
	end
	return f6_local0
end
CoD.TeamUtility.GetOppositeTeamAxisAllies = function(f7_arg0)
	if f7_arg0 == Enum[@"team_t"][@"team_allies"] then
		return Enum[@"team_t"][@"team_axis"]
	elseif f7_arg0 == Enum[@"team_t"][@"team_axis"] then
		return Enum[@"team_t"][@"team_allies"]
	else
		return f7_arg0
	end
end
CoD.TeamUtility.GetTeamColor = function(f8_arg0, f8_arg1)
	if CoD.IsShoutcaster(f8_arg0) and CoD.ShoutcasterProfileVarBool(f8_arg0, "shoutcaster_ds_flip_scorepanel") then
		f8_arg1 = CoD.TeamUtility.GetOppositeTeamAxisAllies(f8_arg1)
	end
	return CoD.TeamUtility.GetTeamFactionColor(f8_arg1)
end
CoD.TeamUtility.GetTeamIDForController = function(f9_arg0)
	local f9_local0 = Engine[@"getteamidbyxuid"](Engine[@"getxuid64"](f9_arg0))
	if f9_local0 then
		return f9_local0
	end
	local f9_local1 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	if f9_local1 and f9_local1.sessionClients then
		for f9_local5, f9_local6 in ipairs(f9_local1.sessionClients) do
			local f9_local7 = f9_local6.team
			if Engine[@"getxuid64"](f9_arg0) == f9_local6.xuid then
				return f9_local7
			end
		end
	end
	return Enum[@"team_t"][@"team_bad"]
end
CoD.TeamUtility.GetPredictedTeamID = function(f10_arg0)
	local f10_local0 = CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f10_arg0), "factions.playerFactionTeamEnum")
	if f10_local0 then
		return f10_local0
	else
		return CoD.TeamUtility.GetTeamIDForController(f10_arg0)
	end
end
CoD.TeamUtility.GetTeamID = function(f11_arg0)
	return CoD.TeamUtility.GetPredictedTeamID(f11_arg0)
end
CoD.TeamUtility.GetDefaultTeamName = function(f12_arg0)
	if IsMultiplayer() then
		if f12_arg0 == Enum[@"team_t"][@"team_allies"] then
			return @"mpui/allies"
		elseif f12_arg0 == Enum[@"team_t"][@"team_axis"] then
			return @"mpui/axis"
		end
	elseif IsCampaign() then
		if f12_arg0 == Enum[@"team_t"][@"team_allies"] then
			return @"hash_42B048C5B8811227"
		elseif f12_arg0 == Enum[@"team_t"][@"team_axis"] then
			return @"hash_38223F843A2C25CC"
		end
	end
	return CoD.TeamUtility.TeamName[f12_arg0] or 0x0
end
CoD.TeamUtility.TeamDevStringToEnumTable = {
	allies = Enum[@"team_t"][@"team_allies"],
	axis = Enum[@"team_t"][@"team_axis"],
}
CoD.TeamUtility.TeamDevStringToEnum = function(f13_arg0)
	local f13_local0 = CoD.TeamUtility.TeamDevStringToEnumTable[f13_arg0]
	if not f13_local0 then
		f13_local0 = Enum[@"team_t"][@"team_bad"]
	end
	return f13_local0
end
CoD.TeamUtility.GetDefaultTeamShortName = function(f14_arg0)
	if IsMultiplayer() then
		if f14_arg0 == Enum[@"team_t"][@"team_allies"] then
			return @"hash_EDCCEFE94375E18"
		elseif f14_arg0 == Enum[@"team_t"][@"team_axis"] then
			return @"hash_5FFCFA8A74D3E077"
		end
	elseif IsCampaign() then
		if f14_arg0 == Enum[@"team_t"][@"team_allies"] then
			return @"hash_64A981F51DACF0A"
		elseif f14_arg0 == Enum[@"team_t"][@"team_axis"] then
			return 0x258ADD73950461
		end
	end
	return CoD.TeamUtility.TeamName[f14_arg0] or 0x0
end
CoD.TeamUtility.GetDefaultTeamFactionDescription = function(f15_arg0)
	if IsMultiplayer() then
		if f15_arg0 == Enum[@"team_t"][@"team_allies"] then
			return @"hash_4F61ADAF3651241F"
		elseif f15_arg0 == Enum[@"team_t"][@"team_axis"] then
			return @"hash_2A8BCD7E744625EA"
		end
	elseif IsCampaign() then
		if f15_arg0 == Enum[@"team_t"][@"team_allies"] then
			return @"hash_5712156435B5EBF9"
		elseif f15_arg0 == Enum[@"team_t"][@"team_axis"] then
			return @"hash_42FED463C97B0434"
		end
	end
	return CoD.TeamUtility.TeamName[f15_arg0] or 0x0
end
CoD.TeamUtility.GetDefaultTeamFactionColor = function(f16_arg0)
	local f16_local0 = ColorSet.CodCaster
	if f16_arg0 == Enum[@"team_t"][@"team_allies"] then
		f16_local0 = ColorSet.FriendlyBlue
	elseif f16_arg0 == Enum[@"team_t"][@"team_axis"] then
		f16_local0 = ColorSet.EnemyOrange
	elseif f16_arg0 == Enum[@"team_t"][@"team_three"] then
		f16_local0 = ColorSet.WarzoneCustomTeam3
	elseif f16_arg0 == Enum[@"team_t"][@"team_four"] then
		f16_local0 = ColorSet.WarzoneCustomTeam4
	elseif f16_arg0 == Enum[@"team_t"][@"team_five"] then
		f16_local0 = ColorSet.WarzoneCustomTeam5
	elseif f16_arg0 == Enum[@"team_t"][@"team_six"] then
		f16_local0 = ColorSet.WarzoneCustomTeam6
	elseif f16_arg0 == Enum[@"team_t"][@"team_spectator"] then
		f16_local0 = ColorSet.CodCaster
	end
	return string.format("%d %d %d", f16_local0.r * 255, f16_local0.g * 255, f16_local0.b * 255)
end
CoD.TeamUtility.GetDefaultTeamFactionIcon = function(f17_arg0)
	if IsCampaign() then
		if f17_arg0 == Enum[@"team_t"][@"team_allies"] then
			return "cp_icon_faction_allies"
		elseif f17_arg0 == Enum[@"team_t"][@"team_axis"] then
			return "cp_icon_faction_axis"
		end
	elseif f17_arg0 == Enum[@"team_t"][@"team_allies"] then
		return "faction_allies"
	elseif f17_arg0 == Enum[@"team_t"][@"team_axis"] then
		return "faction_axis"
	end
	return ""
end
CoD.TeamUtility.GetSimplifiedTeamFactionIcon = function(f18_arg0)
	if IsCampaign() then
		if f18_arg0 == Enum[@"team_t"][@"team_allies"] then
			return "uie_t8_cp_faction_allies"
		elseif f18_arg0 == Enum[@"team_t"][@"team_axis"] then
			return "uie_t8_cp_faction_axis"
		end
	end
	return ""
end
CoD.TeamUtility.GetTeamName = function(f19_arg0)
	local f19_local0 = Engine[@"getprimarycontroller"]()
	if CoD.IsShoutcaster(f19_local0) or CoD.CodCasterUtility.AreCodCasterAssigned(f19_local0) then
		if CoD.TeamUtility.ShouldUseCustomTeamIdentity(f19_local0) then
			return CoD.GetCodCasterTeamName(f19_local0, f19_arg0)
		else
			return Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamName(f19_arg0))
		end
	else
		return Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamName(f19_arg0))
	end
end
CoD.TeamUtility.GetTeamFactionColor = function(f20_arg0)
	local f20_local0 = Engine[@"getprimarycontroller"]()
	if CoD.CodCasterUtility.IsCodCasterOrAssigned(f20_local0) then
		if CoD.TeamUtility.ShouldUseCustomTeamIdentity(f20_local0) then
			return CoD.GetCodCasterTeamColor(f20_local0, f20_arg0)
		end
		local f20_local1 = ColorSet.CodCaster
		if f20_arg0 == Enum[@"team_t"][@"team_allies"] then
			f20_local1 = ColorSet.FriendlyBlue
		elseif f20_arg0 == Enum[@"team_t"][@"team_spectator"] then
			f20_local1 = ColorSet.CodCaster
		else
			f20_local1 = ColorSet.EnemyOrange
		end
		return string.format("%d %d %d", f20_local1.r * 255, f20_local1.g * 255, f20_local1.b * 255)
	end
	local f20_local1 = nil
	if IsInGame() then
		f20_local1 = CoDShared.IsGametypeTeamBased()
	elseif IsWarzone() then
		f20_local1 = not IsMaxTeamPlayersEqualTo(1)
	else
		f20_local1 = IsTeamBasedGameMode(f20_local0)
	end
	if not f20_local1 then
		local f20_local2 = ColorSet.CodCaster
		return string.format("%d %d %d", f20_local2.r * 255, f20_local2.g * 255, f20_local2.b * 255)
	end
	return CoD.TeamUtility.GetDefaultTeamFactionColor(f20_arg0)
end
CoD.TeamUtility.GetTeamFactionIcon = function(f21_arg0)
	local f21_local0 = Engine[@"getprimarycontroller"]()
	if CoD.CodCasterUtility.IsCodCasterOrAssigned(f21_local0) then
		if CoD.TeamUtility.ShouldUseBlankTeamIdentity(f21_local0) then
			return "blacktransparent"
		elseif CoD.TeamUtility.ShouldUseCustomTeamIdentity(f21_local0) then
			return CoD.CodCasterUtility.GetCodCasterFactionIcon(f21_local0, f21_arg0)
		else
			return CoD.CodCasterUtility.GetDefaultCodCasterFactionIcon(f21_arg0)
		end
	else
		return CoD.TeamUtility.GetDefaultTeamFactionIcon(f21_arg0)
	end
end
CoD.TeamUtility.GetTeamNameCaps = function(f22_arg0)
	if Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_league"]) then
		if f22_arg0 == Enum[@"team_t"][@"team_allies"] and Dvar[@"g_customteamname_allies"]:get() ~= "" then
			return Engine[@"toupper"](Dvar[@"g_customteamname_allies"]:get())
		elseif f22_arg0 == Enum[@"team_t"][@"team_axis"] and Dvar[@"g_customteamname_axis"]:get() ~= "" then
			return Engine[@"toupper"](Dvar[@"g_customteamname_axis"]:get())
		end
	end
	if CoD.CodCasterUtility.IsCodCasterOrAssigned(Engine[@"getprimarycontroller"]()) then
		local f22_local0 = CoD.TeamUtility.GetTeamName(f22_arg0)
		if f22_local0 ~= "" then
			return Engine[@"toupper"](f22_local0)
		else
			return f22_local0
		end
	end
	local f22_local0 = CoD.TeamUtility.GetTeamName(f22_arg0)
	if f22_arg0 == Enum[@"team_t"][@"team_spectator"] then
		f22_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_379A28BE744E24FB")
	end
	return ToUpper(f22_local0)
end
CoD.TeamUtility.GetColorSetNameFriendlyColor = function(f23_arg0, f23_arg1)
	local f23_local0 = "White"
	if CoD.IsShoutcaster(f23_arg0) then
		if f23_arg1 == Enum[@"team_t"][@"team_allies"] then
			f23_local0 = "CodCasterFactionAllies"
		elseif f23_arg1 == Enum[@"team_t"][@"team_axis"] then
			f23_local0 = "CodCasterFactionAxis"
		end
	else
		f23_local0 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f23_arg0, "FriendlyBlue")
	end
	return f23_local0
end
CoD.TeamUtility.GetColorSetFriendlyColor = function(f24_arg0, f24_arg1)
	return ColorSet[CoD.TeamUtility.GetColorSetNameFriendlyColor(f24_arg0, f24_arg1)]
end
CoD.TeamUtility.GetColorSetNameEnemyColor = function(f25_arg0, f25_arg1)
	local f25_local0 = "White"
	if CoD.IsShoutcaster(f25_arg0) then
		if f25_arg1 == Enum[@"team_t"][@"team_allies"] then
			f25_local0 = "CodCasterFactionAllies"
		elseif f25_arg1 == Enum[@"team_t"][@"team_axis"] then
			f25_local0 = "CodCasterFactionAxis"
		end
	else
		f25_local0 = CoD.ColorUtility.GetColorBlindColorNameForPlayer(f25_arg0, "EnemyOrange")
	end
	return f25_local0
end
CoD.TeamUtility.GetColorSetEnemyColor = function(f26_arg0, f26_arg1)
	return ColorSet[CoD.TeamUtility.GetColorSetNameEnemyColor(f26_arg0, f26_arg1)]
end
CoD.TeamUtility.GetColorSetFriendlyOrShoutCasterColor = function(f27_arg0)
	local f27_local0 = nil
	if CoD.IsShoutcaster(f27_arg0) then
		f27_local0 = ColorSet.CodCasterFactionAllies
	else
		f27_local0 = CoD.ColorUtility.GetColorBlindColorForPlayer(f27_arg0, "FriendlyBlue")
	end
	return f27_local0
end
CoD.TeamUtility.GetColorSetEnemyOrShoutCasterColor = function(f28_arg0)
	local f28_local0 = nil
	if CoD.IsShoutcaster(f28_arg0) then
		f28_local0 = ColorSet.CodCasterFactionAxis
	else
		f28_local0 = CoD.ColorUtility.GetColorBlindColorForPlayer(f28_arg0, "EnemyOrange")
	end
	return f28_local0
end
CoD.TeamUtility.IsTeamLivesLow = function(f29_arg0)
	local f29_local0 = 0
	local f29_local1 = 0
	if f29_arg0 == Enum[@"team_t"][@"team_allies"] then
		local f29_local2 = Engine[@"getglobalmodel"]()
		f29_local0 = f29_local2.hudItems.team1.livesCount:get()
		f29_local2 = Engine[@"getglobalmodel"]()
		f29_local1 = f29_local2.scoreboard.team1.count:get()
	elseif f29_arg0 == Enum[@"team_t"][@"team_axis"] then
		local f29_local2 = Engine[@"getglobalmodel"]()
		f29_local0 = f29_local2.hudItems.team2.livesCount:get()
		f29_local2 = Engine[@"getglobalmodel"]()
		f29_local1 = f29_local2.scoreboard.team2.count:get()
	end
	return f29_local0 <= f29_local1
end
CoD.TeamUtility.GetTeamCount = function(f30_arg0)
	local f30_local0 = 0
	if f30_arg0 == Enum[@"team_t"][@"team_allies"] then
		local f30_local1 = Engine[@"getglobalmodel"]()
		f30_local0 = f30_local1.scoreboard.team1.count:get()
	elseif f30_arg0 == Enum[@"team_t"][@"team_axis"] then
		local f30_local1 = Engine[@"getglobalmodel"]()
		f30_local0 = f30_local1.scoreboard.team2.count:get()
	end
	return f30_local0
end
CoD.TeamUtility.IsMyTeamLivesLow = function(f31_arg0)
	return CoD.TeamUtility.IsTeamLivesLow(CoD.TeamUtility.GetTeamID(f31_arg0))
end
CoD.TeamUtility.IsEnemyTeamLivesLow = function(f32_arg0)
	local f32_local0 = CoD.TeamUtility.GetTeamID(f32_arg0)
	local f32_local1 = Enum[@"team_t"][@"team_allies"]
	if f32_local1 == f32_local0 then
		f32_local1 = Enum[@"team_t"][@"team_axis"]
	end
	return CoD.TeamUtility.IsTeamLivesLow(f32_local1)
end
CoD.TeamUtility.IsLastLivesDataLivesLow = function(f33_arg0, f33_arg1)
	local f33_local0 = f33_arg0:getModel(f33_arg1, "numPlayersAlive")
	local f33_local1 = f33_local0 and f33_local0:get()
	local f33_local2 = f33_arg0:getModel(f33_arg1, "teamSize")
	local f33_local3 = f33_local2 and f33_local2:get()
	if f33_local1 and f33_local3 then
		return f33_local1 <= f33_local3
	else
		return false
	end
end
CoD.TeamUtility.IsClientSameTeam = function(f34_arg0, f34_arg1)
	local f34_local0 = CoD.SafeGetModelValue(f34_arg0:getModel(), "clientNum")
	if not f34_local0 or f34_local0 < 0 or f34_local0 >= LuaDefine.MAX_CLIENTS then
		return false
	else
		return Engine[@"getteamid"](f34_arg1, f34_local0) == CoD.TeamUtility.GetTeamID(f34_arg1)
	end
end
CoD.TeamUtility.GetTeamNameForTeamEnum = function(f35_arg0, f35_arg1)
	return CoD.TeamUtility.GetTeamName(f35_arg1)
end
CoD.TeamUtility.GetTeamNameForPlayer = function(f36_arg0, f36_arg1)
	return CoD.TeamUtility.GetDefaultTeamName(CoD.TeamUtility.GetTeamID(f36_arg0))
end
CoD.TeamUtility.GetTeamImageForTeamEnum = function(f37_arg0, f37_arg1)
	return CoD.TeamUtility.GetTeamFactionIcon(f37_arg1)
end
CoD.TeamUtility.GetTeamImageForPlayer = function(f38_arg0, f38_arg1)
	return CoD.TeamUtility.GetDefaultTeamFactionIcon(CoD.TeamUtility.GetTeamID(f38_arg0))
end
DataSources.InGamePlayerListRowData = DataSourceHelpers.ListSetup("InGamePlayerListRowData", function(f39_arg0)
	local f39_local0 = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4, f40_arg5)
		return {
			models = {
				teamBGColor = f40_arg1,
				rankText = f40_arg2,
				rankIcon = f40_arg3,
				playerNameText = f40_arg4,
				playerNameColor = f40_arg5,
			},
			properties = {},
		}
	end
	local f39_local1 = function(f41_arg0, f41_arg1, f41_arg2)
		local f41_local0 = CoD.TeamUtility.GetTeamNameCaps(f41_arg2)
		local f41_local1 = Engine[@"getingameplayerlist"](f41_arg0, f41_arg2)
		if not f41_local1 or #f41_local1 == 0 then
			return
		end
		local f41_local2 = 0.75
		local f41_local3 = {
			r = 1,
			g = 1,
			b = 1,
		}
		local f41_local4 = CoD.TeamUtility.GetTeamColor(f41_arg0, f41_arg2)
		local f41_local5 = {}
		for f41_local9 in string.gmatch(f41_local4, "%S+") do
			table.insert(f41_local5, f41_local9)
		end
		f41_local6 = {
			r = tonumber(f41_local5[1]) / 255,
			g = tonumber(f41_local5[2]) / 255,
			b = tonumber(f41_local5[3]) / 255,
		}
		for f41_local16, f41_local17 in pairs(f41_local1) do
			local f41_local10 = CoD.ColorUtility.ConvertColor(f41_local6.r, f41_local6.g, f41_local6.b)
			if f41_local16 % 2 == 1 then
				f41_local10 = CoD.ColorUtility.ConvertColor(f41_local6.r * f41_local2, f41_local6.g * f41_local2, f41_local6.b * f41_local2)
			end
			local f41_local11 = f41_local17.rank
			local f41_local12 = Engine[@"getrankicon"](f41_local11, 0)
			local f41_local13 = f41_local17.playerName
			local f41_local14 = CoD.ColorUtility.ConvertColor(f41_local3.r, f41_local3.g, f41_local3.b)
			local f41_local15 = {
				r = 0.9,
				g = 0.69,
				b = 0.2,
			}
			if f41_local17.isSelf then
				f41_local14 = CoD.ColorUtility.ConvertColor(f41_local15.r, f41_local15.g, f41_local15.b)
			end
			table.insert(f41_arg1, f39_local0(f41_arg0, f41_local10, f41_local11, f41_local12, f41_local13, f41_local14))
		end
	end
	local f39_local2 = {}
	local f39_local3 = Engine[@"getgametypesetting"](@"teamcount")
	for f39_local4 = 1, f39_local3, 1 do
		f39_local1(f39_arg0, f39_local2, f39_local4)
	end
	return f39_local2
end, true)
DataSources.ChangeTeamOptions = DataSourceHelpers.ListSetup("ChangeTeamOptions", function(f42_arg0)
	local f42_local0 = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4, f43_arg5)
		local f43_local0 = 0
		local f43_local1 = f43_arg1
		if f43_arg4 ~= "" then
			f43_local0 = 1
			f43_local1 = 0x0
		end
		return {
			models = {
				displayText = f43_local1,
				name = f43_arg1,
				desc = f43_arg3,
				disabled = f43_arg5,
				icon = f43_arg4,
				iconVisible = f43_local0,
				action = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4)
					HUD_IngameMenuClosed()
					SendMenuResponse(f44_arg0, "ChangeTeam", f43_arg2, f44_arg2)
					if f44_arg4.previousMenuId then
						LUI.savedMenuStates[f44_arg4.previousMenuId] = nil
					end
					local f44_local0 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f44_arg2), "factions.isCoDCaster")
					if f43_arg2 == "spectator" then
						Engine[@"lockinput"](f44_arg2, false)
						Engine[@"setuiactive"](f44_arg2, false)
						Engine[@"setmodelvalue"](f44_local0, true)
					else
						Engine[@"setmodelvalue"](f44_local0, false)
					end
					Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f44_arg2), "CodCaster"), "showCodCasterScoreboard"), false)
					SetControllerModelValue(f44_arg2, "forceScoreboard", 0)
					if IsIntDvarNonZero("mp_prototype") then
						StartMenuGoBack(f44_arg4, f44_arg2)
					end
				end,
				param = {},
			},
			properties = {},
		}
	end
	local f42_local1 = function(f45_arg0, f45_arg1)
		local f45_local0 = CoD.PlayerRoleUtility.GetHeroList(Engine[@"currentsessionmode"]())
		local f45_local1 = Engine[@"getgametypesettings"]()
		local f45_local2 = Engine[@"hash_4FCDE749B09C3D6"](f45_arg0)
		local f45_local3 = 1
		for f45_local7, f45_local8 in pairs(f45_local2) do
			if f45_local8 == f45_arg1 and Engine[@"getcharacterindexforclientnum"](f45_arg0, f45_local7) == 0 then
				f45_local3 = f45_local3 + 1
			end
		end
		f45_local4 = 0
		for f45_local8, f45_local9 in ipairs(f45_local0) do
			if Engine[@"getcharactercountforteam"](f45_arg0, f45_local9.bodyIndex, f45_arg1) < f45_local1.maxUniqueRolesPerTeam[f45_local9.bodyIndex]:get() then
				f45_local4 = f45_local4 + 1
			end
		end
		return f45_local3 <= f45_local4
	end
	local f42_local2 = {}
	local f42_local3 = Engine[@"team"](f42_arg0, "index")
	local f42_local4
	if Engine[@"getgametypesetting"](@"spectatetype") >= 1 and Engine[@"getgametypesetting"](@"allowspectating") == 1 then
		f42_local4 = not Engine[@"issplitscreen"]()
	else
		f42_local4 = false
	end
	if f42_local4 then
		if CoD.DirectorUtility.IsOfflineOnlyDemo() then
			f42_local4 = IsLobbyHost()
		else
			f42_local4 = true
		end
	end
	if f42_local4 then
		f42_local4 = CoD.CodCasterUtility.IsCodCasterEnabled()
	end
	if f42_local4 then
		f42_local4 = Engine[@"getdvarint"]("allow_shoutcaster_team_switch") == 1
	end
	local f42_local5 = function(f46_arg0)
		local f46_local0 = CoD.TeamUtility.GetTeamNameCaps(f46_arg0)
		if f46_local0 == "" then
			f46_local0 = Engine[@"toupper"](CoD.TeamUtility.GetDefaultTeamName(f46_arg0))
		end
		return f46_local0
	end
	if CoDShared.IsGametypeTeamBased() == true and CoD.IsTeamChangeAllowed(f42_arg0) then
		if f42_local3 ~= Enum[@"team_t"][@"team_allies"] then
			if f42_local1(f42_arg0, Enum[@"team_t"][@"team_allies"]) then
				table.insert(f42_local2, f42_local0(f42_arg0, @"mpui/allies", "allies", @"hash_617E759991A40568", CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_allies"]), false))
			else
				table.insert(f42_local2, f42_local0(f42_arg0, @"mpui/allies", "allies", @"hash_6A3EE0239CF6265D", CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_allies"]), true))
			end
		end
		if f42_local3 ~= Enum[@"team_t"][@"team_axis"] then
			if f42_local1(f42_arg0, Enum[@"team_t"][@"team_axis"]) then
				table.insert(f42_local2, f42_local0(f42_arg0, @"mpui/axis", "axis", @"hash_46838CD03F01BF13", CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_axis"]), false))
			else
				table.insert(f42_local2, f42_local0(f42_arg0, @"mpui/axis", "axis", @"hash_6A3EE0239CF6265D", CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_axis"]), true))
			end
		end
	end
	if CoDShared.IsGametypeTeamBased() == true or f42_local3 == Enum[@"team_t"][@"team_spectator"] then
		table.insert(f42_local2, f42_local0(f42_arg0, @"hash_2AD8F376215AE5D7", "autoassign", @"hash_38BFAF5D14337A27", ""))
	end
	if f42_local3 ~= Enum[@"team_t"][@"team_spectator"] and f42_local4 == true then
		table.insert(f42_local2, f42_local0(f42_arg0, @"hash_379A28BE744E24FB", "spectator", @"hash_6E6B92255B28A2BF", "", false))
	end
	if true == Dvar[@"ui_autocontrolledplayer"]:get() then
		table.insert(f42_local2, f42_local0(f42_arg0, "MENU_AUTO_CONTROL_PLAYER", "autocontrol", "MENU_AUTO_CONTROL_PLAYER_DESC", "", false))
	end
	return f42_local2
end, true)
DataSources.Factions = {
	prepared = false,
	preparedForController = {},
	factionSubscription = {},
	prepare = function(f47_arg0, f47_arg1, f47_arg2)
		if not DataSources.Factions.preparedForController then
			DataSources.Factions.preparedForController = {}
		end
		if not DataSources.Factions.factionSubscription[f47_arg0] then
			DataSources.Factions.factionSubscription[f47_arg0] = LUI.UIElement.new()
		end
		local f47_local0 = Engine[@"getmodelforcontroller"](f47_arg0)
		local f47_local1 = Engine[@"createmodel"](f47_local0, "factions")
		local f47_local2 = Engine[@"createmodel"](f47_local1, "isCoDCaster")
		local f47_local3 = Engine[@"createmodel"](f47_local1, "playerFactionTeamEnum")
		local f47_local4 = Engine[@"createmodel"](f47_local1, "playerFactionName")
		local f47_local5 = Engine[@"createmodel"](f47_local1, "playerFactionDisplayName")
		local f47_local6 = Engine[@"createmodel"](f47_local1, "playerFactionIcon")
		local f47_local7 = Engine[@"createmodel"](f47_local1, "playerFactionColor")
		local f47_local8 = Engine[@"createmodel"](f47_local1, "playerFactionFlagColor")
		local f47_local9 = Engine[@"createmodel"](f47_local1, "playerFactionModel")
		local f47_local10 = f47_local1:create("actualTeam")
		local f47_local11 = Engine[@"createmodel"](f47_local1, "enemyFactionTeamEnum")
		local f47_local12 = Engine[@"createmodel"](f47_local1, "enemyFactionName")
		local f47_local13 = Engine[@"createmodel"](f47_local1, "enemyFactionDisplayName")
		local f47_local14 = Engine[@"createmodel"](f47_local1, "enemyFactionIcon")
		local f47_local15 = Engine[@"createmodel"](f47_local1, "enemyFactionColor")
		local f47_local16 = Engine[@"createmodel"](f47_local1, "enemyFactionFlagColor")
		local f47_local17 = Engine[@"createmodel"](f47_local1, "enemyFactionModel")
		DataSources.Factions.factionSubscription[f47_arg0]:unsubscribeFromAllModels()
		DataSources.Factions.preparedForController[f47_arg0] = true
		DataSources.Factions.factionSubscription[f47_arg0]:subscribeToModel(f47_local3, function(model)
			local f48_local0 = Engine[@"getmodelvalue"](model)
			if f48_local0 then
				if CoD.IsShoutcaster(f47_arg0) then
					f48_local0 = Enum[@"team_t"][@"team_allies"]
					local f48_local1 = f47_local0:create("factionList")
					f48_local1 = f48_local1:create("faction" .. f48_local0)
					f48_local1:create("factionScore")
					f47_local9:set(f48_local1)
					f47_local6:set(CoD.TeamUtility.GetTeamFactionIcon(f48_local0))
				else
					local f48_local1 = CoD.TeamUtility.GetTeamIDForController(f47_arg0)
					local f48_local2 = f47_local0:create("factionList")
					f48_local2 = f48_local2:create("faction" .. f48_local1)
					f48_local2:create("factionScore")
					f47_local9:set(f48_local2)
					f47_local6:set(CoD.TeamUtility.GetTeamFactionIcon(f48_local1))
				end
				Engine[@"setmodelvalue"](f47_local5, CoD.TeamUtility.GetTeamNameCaps(f48_local0))
				Engine[@"setmodelvalue"](f47_local7, CoD.TeamUtility.GetTeamFactionColor(f48_local0))
				local f48_local1 = CoD.ColorUtility.GetColorBlindColorForPlayer(f47_arg0, "FriendlyBlue")
				local f48_local2 = string.format("%d %d %d", f48_local1.r * 255, f48_local1.g * 255, f48_local1.b * 255)
				if CoD.IsShoutcaster(f47_arg0) then
					local f48_local3 = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_allies"])
					if not CoDShared.IsGametypeTeamBased() then
						f48_local3 = f48_local2
					end
					CoD.ColorUtility.UpdateColorSet("CodCasterFriendly", f48_local3)
					CoD.ColorUtility.UpdateColorSet("CodCasterFriendlyEffect", f48_local3)
					Engine[@"setupcompasscolors"](f47_arg0)
					f48_local2 = f48_local3
				end
				Engine[@"setmodelvalue"](f47_local8, f48_local2)
			end
		end)
		DataSources.Factions.factionSubscription[f47_arg0]:subscribeToModel(f47_local11, function(model)
			local f49_local0 = Engine[@"getmodelvalue"](model)
			if f49_local0 then
				if CoD.IsShoutcaster(f47_arg0) then
					f49_local0 = Enum[@"team_t"][@"team_axis"]
					local f49_local1 = f47_local0:create("factionList")
					f49_local1 = f49_local1:create("faction" .. f49_local0)
					f49_local1:create("factionScore")
					f47_local17:set(f49_local1)
					Engine[@"setmodelvalue"](f47_local14, CoD.TeamUtility.GetTeamFactionIcon(f49_local0))
				else
					local f49_local1 = CoD.TeamUtility.GetOppositeTeamAxisAllies(CoD.TeamUtility.GetTeamIDForController(f47_arg0))
					local f49_local2 = f47_local0:create("factionList")
					f49_local2 = f49_local2:create("faction" .. f49_local1)
					f49_local2:create("factionScore")
					f47_local17:set(f49_local2)
					Engine[@"setmodelvalue"](f47_local14, CoD.TeamUtility.GetTeamFactionIcon(f49_local1))
				end
				Engine[@"setmodelvalue"](f47_local13, CoD.TeamUtility.GetTeamNameCaps(f49_local0))
				Engine[@"setmodelvalue"](f47_local15, CoD.TeamUtility.GetTeamFactionColor(f49_local0))
				local f49_local1 = CoD.ColorUtility.GetColorBlindColorForPlayer(f47_arg0, "EnemyOrange")
				local f49_local2 = string.format("%d %d %d", f49_local1.r * 255, f49_local1.g * 255, f49_local1.b * 255)
				if CoD.IsShoutcaster(f47_arg0) then
					local f49_local3 = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_axis"])
					if not CoDShared.IsGametypeTeamBased() then
						f49_local3 = f49_local2
					end
					CoD.ColorUtility.UpdateColorSet("CodCasterEnemy", f49_local3)
					CoD.ColorUtility.UpdateColorSet("CodCasterEnemyEffect", f49_local3)
					Engine[@"setupcompasscolors"](f47_arg0)
					f49_local2 = f49_local3
				end
				Engine[@"setmodelvalue"](f47_local16, f49_local2)
			end
		end)
		local f47_local18 = {
			name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_allies"]),
			icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_allies"]),
			color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_allies"]),
		}
		local f47_local19 = {
			name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_axis"]),
			icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_axis"]),
			color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_axis"]),
		}
		if CoD.IsShoutcaster(f47_arg0) and CoD.ShoutcasterProfileVarBool(f47_arg0, "shoutcaster_ds_flip_scorepanel") then
			f47_local19 = {
				name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_allies"]),
				icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_allies"]),
				color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_allies"]),
			}
			f47_local18 = {
				name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_axis"]),
				icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_axis"]),
				color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_axis"]),
			}
		end
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f47_local1, "axisFactionDisplayName"), f47_local19.name)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f47_local1, "axisFactionIcon"), f47_local19.icon)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f47_local1, "axisFactionColor"), f47_local19.color)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f47_local1, "alliesFactionDisplayName"), f47_local18.name)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f47_local1, "alliesFactionIcon"), f47_local18.icon)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f47_local1, "alliesFactionColor"), f47_local18.color)
		if CoD.IsShoutcaster(f47_arg0) then
			CoD.ColorUtility.UpdateColorSet("CodCasterFactionAllies", f47_local18.color)
			CoD.ColorUtility.UpdateColorSet("CodCasterFactionAxis", f47_local19.color)
			Engine[@"setupcompasscolors"](f47_arg0)
		end
		local f47_local20 = Engine[@"getmodel"](f47_local0, "team")
		if f47_local20 then
			DataSources.Factions.factionSubscription[f47_arg0]:subscribeToModel(f47_local20, function(model)
				DataSources.Factions.preparedForController[f47_arg0] = false
				DataSources.Factions.prepare(f47_arg0)
			end, false)
		end
		local f47_local21 = Engine[@"getmodel"](f47_local0, "CodCaster.profileSettingsUpdated")
		if f47_local21 then
			DataSources.Factions.factionSubscription[f47_arg0]:subscribeToModel(f47_local21, function(model)
				DataSources.Factions.preparedForController[f47_arg0] = false
				DataSources.Factions.prepare(f47_arg0)
			end, false)
		end
		local f47_local22 = Engine[@"getmodel"](f47_local0, "profile.colorblindMode")
		if f47_local22 then
			DataSources.Factions.factionSubscription[f47_arg0]:subscribeToModel(f47_local22, function(model)
				DataSources.Factions.preparedForController[f47_arg0] = false
				DataSources.Factions.prepare(f47_arg0)
			end, false)
		end
	end,
	getModel = function(f53_arg0)
		if not DataSources.Factions.preparedForController or not DataSources.Factions.preparedForController[f53_arg0] then
			DataSources.Factions.prepare(f53_arg0)
		end
		if not f53_arg0 then
			f53_arg0 = Engine[@"getprimarycontroller"]()
		end
		return Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f53_arg0), "factions")
	end,
}
DataSources.FactionsGlobal = {
	prepare = function(f54_arg0, f54_arg1, f54_arg2)
		local f54_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "factions")
		local f54_local1 = Engine[@"getmodelforcontroller"](f54_arg0)
		if not DataSources.FactionsGlobal.factionSubscription then
			DataSources.FactionsGlobal.factionSubscription = LUI.UIElement.new()
		end
		DataSources.FactionsGlobal.factionSubscription:unsubscribeFromAllModels()
		local f54_local2 = {
			name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_allies"]),
			icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_allies"]),
			color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_allies"]),
		}
		local f54_local3 = {
			name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_axis"]),
			icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_axis"]),
			color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_axis"]),
		}
		if CoD.IsShoutcaster(f54_arg0) and CoD.ShoutcasterProfileVarBool(f54_arg0, "shoutcaster_ds_flip_scorepanel") then
			f54_local3 = {
				name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_allies"]),
				icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_allies"]),
				color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_allies"]),
			}
			f54_local2 = {
				name = CoD.TeamUtility.GetTeamNameCaps(Enum[@"team_t"][@"team_axis"]),
				icon = CoD.TeamUtility.GetTeamFactionIcon(Enum[@"team_t"][@"team_axis"]),
				color = CoD.TeamUtility.GetTeamFactionColor(Enum[@"team_t"][@"team_axis"]),
			}
		end
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f54_local0, "axisFactionDisplayName"), f54_local3.name)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f54_local0, "axisFactionIcon"), f54_local3.icon)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f54_local0, "axisFactionColor"), f54_local3.color)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f54_local0, "alliesFactionDisplayName"), f54_local2.name)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f54_local0, "alliesFactionIcon"), f54_local2.icon)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f54_local0, "alliesFactionColor"), f54_local2.color)
		local f54_local4 = Engine[@"getmodel"](f54_local1, "team")
		if f54_local4 then
			DataSources.FactionsGlobal.factionSubscription:subscribeToModel(f54_local4, function(model)
				DataSources.FactionsGlobal.prepared = false
				DataSources.FactionsGlobal.prepare(f54_arg0)
			end, false)
		end
		local f54_local5 = Engine[@"getmodel"](f54_local1, "CodCaster.profileSettingsUpdated")
		if f54_local5 then
			DataSources.FactionsGlobal.factionSubscription:subscribeToModel(f54_local5, function(model)
				DataSources.FactionsGlobal.prepared = false
				DataSources.FactionsGlobal.prepare(f54_arg0)
			end, false)
		end
		local f54_local6 = Engine[@"getmodel"](f54_local1, "profile.colorblindMode")
		if f54_local6 then
			DataSources.FactionsGlobal.factionSubscription:subscribeToModel(f54_local6, function(model)
				DataSources.FactionsGlobal.prepared = false
				DataSources.FactionsGlobal.prepare(f54_arg0)
			end, false)
		end
		DataSources.FactionsGlobal.prepared = true
	end,
	getModel = function(f58_arg0)
		if not DataSources.FactionsGlobal.prepared then
			DataSources.FactionsGlobal.prepare(f58_arg0)
		end
		return Engine[@"createmodel"](Engine[@"getglobalmodel"](), "factions")
	end,
}
DataSources.FactionList = {
	prepare = function(f59_arg0, f59_arg1, f59_arg2)
		f59_arg1.factions = {}
		local f59_local0 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f59_arg0), "factionList")
		for f59_local4, f59_local5 in ipairs(Engine[@"getteampositions"](f59_arg0)) do
			local f59_local6 = Engine[@"getfactionforteam"](f59_local4)
			f59_arg1.factions[f59_local4] = Engine[@"createmodel"](f59_local0, "faction" .. f59_local4)
			local f59_local7 = 0
			local f59_local8 = "faction_" .. f59_local6
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f59_arg1.factions[f59_local4], "factionName"), f59_local6)
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f59_arg1.factions[f59_local4], "factionIcon"), f59_local8)
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f59_arg1.factions[f59_local4], "factionScore"), f59_local7)
		end
	end,
	getCount = function(f60_arg0)
		return #f60_arg0.factions
	end,
	getItem = function(f61_arg0, f61_arg1, f61_arg2)
		return f61_arg1.factions[f61_arg2]
	end,
}
