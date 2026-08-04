CoD.CTUtility = {}
CoD.CTUtility.CTChallengeTable = "gamedata/tables/mp/mp_combat_training_challenges.csv"
CoD.CTUtility.NumCTChallenges = 12
CoD.CTUtility.CTMasterChallengeIndex = 13
CoD.CTUtility.SpecialistHeadquartersLaunchStates = LuaEnum.createEnum("STATE_PLAY", "STATE_CONTINUE", "STATE_PLAY_SKIRMISH", "STATE_REPLAY_SKIRMISH")
CoD.CTUtility.SpecialistHeadquartersNavigationMethod = LuaEnum.createEnum("FROM_FRONTEND", "FROM_TUTORIAL_SKIRMISH", "FROM_COMBAT_TRAINING")
CoD.CTUtility.LocalizeMillisecondsTimeIntoString = function(f1_arg0, f1_arg1)
	local f1_local0 = f1_arg1 * 100
	local f1_local1 = math.floor(f1_local0 % 1000)
	local f1_local2 = math.floor(f1_local0 / 1000)
	local f1_local3 = math.floor(f1_local2 / 60)
	if 100 < f1_local1 then
		f1_local1 = f1_local1 / 10
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f1_arg0, string.format("%02d:%02d:%02d", math.floor(f1_local3 % 60), math.floor(f1_local2 % 60), f1_local1))
end
CoD.CTUtility.LocalizeTimeBonus = function(f2_arg0, f2_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f2_arg0, string.format("%d", f2_arg1))
end
CoD.CTUtility.LocalizeTimePenalty = function(f3_arg0, f3_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f3_arg0, string.format("- %d", f3_arg1))
end
CoD.CTUtility.LocalizeDynObjPoints = function(f4_arg0, f4_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f4_arg0, string.format("- %d", f4_arg1))
end
CoD.CTUtility.AllCTUnlocked = function()
	return Engine[@"getdvarbool"]("ui_unlock_all_ct")
end
DataSourceHelpers.PerControllerDataSourceSetup("SpecialistDossier", "SpecialistDossier", function(f6_arg0, f6_arg1)
	local f6_local0 = DataSources.SpecialistHeadquarters.getModel(f6_arg1)
	local f6_local1 = f6_local0.ChosenSpecialistID:get()
	local f6_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum.eModes.mode_multiplayer, f6_local1)
	if not f6_local2 then
		return
	end
	local f6_local3 = f6_arg0:create("callsign")
	f6_local3:set(CoD.CTUtility.PlayerRoleIndexToName(f6_local1))
	f6_local3 = f6_arg0:create("name")
	f6_local3:set(f6_local2[@"realname"] or @"hash_809987FB09FEBF2")
	f6_local3 = f6_arg0:create("DOB")
	f6_local3:set(f6_local2[@"dob"] or @"hash_809987FB09FEBF2")
	f6_local3 = f6_arg0:create("nationality")
	f6_local3:set(f6_local2[@"nationality"] or @"hash_809987FB09FEBF2")
	f6_local3 = f6_arg0:create("designation")
	f6_local3:set(CoD.CTUtility.PlayerRoleIndexToJobTitle(f6_local1))
	f6_local3 = true
	if f6_local3 then
		CoD.CTUtility.CreateVideoModel(f6_arg0, "introVideo", {
			title = f6_local2[@"hash_13C8379C2B98A9C6"],
			desc = @"hash_663DB2EE0FBFA5AF",
			unlocked = f6_local3,
			matureContent = f6_local2[@"hash_11288EC6AF158524"] ~= 0,
			video = {
				stillPreview = f6_local2[@"hash_38EA74CAD0150CDF"],
				lowResVideo = {
					movieName = "",
					isStreamed = false,
					isLooping = false,
				},
				hiResVideo = {
					movieName = f6_local2[@"intromovie"],
					isStreamed = f6_local2[@"hash_7699F7FD98F479BA"] ~= 0,
					isLooping = false,
				},
			},
		})
	else
		local f6_local4 = CoD.CTUtility.GetArchivesBundle()
		CoD.CTUtility.CreateClassifiedVideo(f6_arg0, "introVideo", f6_local4[@"hash_5D9736E875A1DF6B"])
	end
	local f6_local4 = true
	if f6_local4 then
		CoD.CTUtility.CreateVideoModel(f6_arg0, "backstoryVideo", {
			title = f6_local2[@"hash_24D5E917994D529C"],
			desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4CDBA359B2F22447", CoD.CTUtility.PlayerRoleIndexToName(f6_local1)),
			unlocked = f6_local4,
			matureContent = f6_local2[@"hash_4159D83F5ABD12F6"] ~= 0,
			video = {
				stillPreview = f6_local2[@"hash_39BAAA080C62D5E5"],
				lowResVideo = {
					movieName = "",
					isStreamed = false,
					isLooping = false,
				},
				hiResVideo = {
					movieName = f6_local2[@"hash_231A246ACAB5A0A5"],
					isStreamed = f6_local2[@"hash_529AB388882BA5BC"] ~= 0,
					isLooping = false,
				},
			},
		})
	else
		local f6_local5 = CoD.CTUtility.GetArchivesBundle()
		CoD.CTUtility.CreateClassifiedVideo(f6_arg0, "backstoryVideo", f6_local5[@"hash_5D9736E875A1DF6B"])
	end
	local f6_local5 = f6_arg0:create("bioPreview")
	f6_local5:set(f6_local2[@"biopreview"] or @"hash_809987FB09FEBF2")
	f6_local5 = f6_arg0:create("bioFull")
	f6_local5:set(f6_local2[@"biofull"] or @"hash_809987FB09FEBF2")
end, false)
CoD.CTUtility.UpdateSpecialistDossier = function(f7_arg0)
	DataSourceHelperRecreate(f7_arg0, "SpecialistDossier")
end
CoD.CTUtility.UpdateChosenSpecialistStars = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5)
	local f8_local0 = f8_arg0:create("ShouldShowStars")
	f8_local0:set(true)
	f8_local0 = CoD.CTUtility.GetArchivesBundle()
	if not f8_local0 then
		return
	else
		local f8_local1
		if not f8_arg3 then
			f8_local1 = f8_local0[0x59E33E621BA5C9]
			if not f8_local1 then
			else
				f8_arg0:create("recruitStars")
				local f8_local2 = f8_arg0.recruitStars:create("starImage")
				f8_local2:set(f8_local1 or "blacktransparent")
				f8_local2 = f8_arg0.recruitStars:create("header")
				f8_local2:set(f8_local0[@"hash_4EE9D30C4FF6408B"] or 0x0)
				if not f8_arg4 then
					f8_local2 = f8_local0[@"hash_1837781ED9D28DFE"]
					if not f8_local2 then
					else
						f8_arg0:create("regularStars")
						local f8_local3 = f8_arg0.regularStars:create("starImage")
						f8_local3:set(f8_local2 or "blacktransparent")
						f8_local3 = f8_arg0.regularStars:create("header")
						f8_local3:set(f8_local0[@"hash_6B9793AA447A56D6"] or 0x0)
						if not f8_arg5 then
							f8_local3 = f8_local0[@"hash_32A86A3123124448"]
							if not f8_local3 then
							else
								f8_arg0:create("veteranStars")
								local f8_local4 = f8_arg0.veteranStars:create("starImage")
								f8_local4:set(f8_local3 or "blacktransparent")
								f8_local4 = f8_arg0.veteranStars:create("header")
								f8_local4:set(f8_local0[@"hash_57B08A6C17B1A530"] or 0x0)
							end
						end
						f8_local3 = f8_local0[@"hash_7F27D1AD2C9B5996"]
					end
				end
				f8_local2 = f8_local0[0xB33A692CA73C2C]
			end
		end
	end
	f8_local1 = f8_local0[@"hash_7B01945311AF5ACD"]
end
DataSourceHelpers.PerControllerDataSourceSetup("SpecialistHeadquarters", "SpecialistHeadquarters", function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:create("LaunchState")
	f9_local0:set(CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_PLAY)
	f9_local0 = f9_arg0:create("MainInfoText")
	f9_local0:set("")
	f9_local0 = f9_arg0:create("SideInfoText")
	f9_local0:set("")
	f9_local0 = f9_arg0:create("ChosenSpecialistID")
	f9_local0:set(0)
	f9_local0 = f9_arg0:create("HasChosenSpecialist")
	f9_local0:set(false)
	f9_local0 = f9_arg0:create("HasSetDefaultSpecialist")
	f9_local0:set(false)
	f9_local0 = f9_arg0:create("ShowPlayButtonInSpecialistSelect")
	f9_local0:set(true)
	f9_local0 = f9_arg0:create("StartFullscreenBlack")
	f9_local0:set(false)
	f9_arg0:create("ChosenSpecialistListModel")
	f9_local0 = f9_arg0:create("ShowChosenSpecialistList")
	f9_local0:set(false)
	f9_local0 = f9_arg0:create("StarCount")
	f9_local0:set(0)
	CoD.CTUtility.UpdateChosenSpecialistStars(f9_arg0, false, false, false, false)
end, false)
CoD.CTUtility.SetLaunchState = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	local f10_local0 = DataSources.SpecialistHeadquarters.getModel(f10_arg0)
	local f10_local1 = f10_local0.LaunchState
	if f10_arg1 then
		f10_local1:set(CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_REPLAY_SKIRMISH)
	elseif f10_arg2 then
		f10_local1:set(CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_PLAY_SKIRMISH)
	elseif f10_arg3 then
		f10_local1:set(CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_CONTINUE)
	else
		f10_local1:set(CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_PLAY)
	end
end
CoD.CTUtility.UpdateLaunchState = function(f11_arg0)
	local f11_local0 = false
	local f11_local1 = false
	local f11_local2 = false
	local f11_local3, f11_local4, f11_local5 = CoD.CTUtility.GetOverallSpecialistProgress(f11_arg0)
	if f11_local3 then
		if f11_local5 then
			f11_local0 = true
		elseif f11_local4 then
			f11_local1 = true
		else
			f11_local2 = true
		end
	end
	CoD.CTUtility.SetLaunchState(f11_arg0, f11_local0, f11_local1, f11_local2)
end
CoD.CTUtility.SetInfoTextModel = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = DataSources.SpecialistHeadquarters.getModel(f12_arg0)
	f12_local0[f12_arg1]:set(f12_arg2)
end
CoD.CTUtility.SetPlayButtonInfoText = function(f13_arg0)
	local f13_local0 = DataSources.SpecialistHeadquarters.getModel(f13_arg0)
	local f13_local1 = f13_local0.ChosenSpecialistID:get()
	local f13_local2, f13_local3, f13_local4, f13_local5, f13_local6 = CoD.CTUtility.GetSpecialistProgress(f13_arg0, f13_local1)
	local f13_local7 = CoD.CTUtility.GetArchivesBundle()
	local f13_local8 = ""
	if f13_local6 then
		f13_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_48283C331D648B5A", CoD.CTUtility.PlayerRoleIndexToName(f13_local1), f13_local7[@"hash_57B08A6C17B1A530"] or 0x0)
	elseif f13_local5 then
		f13_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_A7B89E2AEC76923", CoD.CTUtility.PlayerRoleIndexToName(f13_local1), f13_local7[@"hash_57B08A6C17B1A530"] or 0x0, @"hash_5F2055D8B8959CC7")
	elseif f13_local4 then
		f13_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_A7B89E2AEC76923", CoD.CTUtility.PlayerRoleIndexToName(f13_local1), f13_local7[@"hash_6B9793AA447A56D6"] or 0x0, @"hash_53D62410EFA3F83D")
	elseif f13_local3 then
		f13_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_A7B89E2AEC76923", CoD.CTUtility.PlayerRoleIndexToName(f13_local1), f13_local7[@"hash_4EE9D30C4FF6408B"] or 0x0, @"hash_6BEE80133950C1BE")
	else
		f13_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6EDA885F0BB2915A", CoD.CTUtility.PlayerRoleIndexToName(f13_local1))
	end
	CoD.CTUtility.SetInfoTextModel(f13_arg0, "MainInfoText", f13_local8)
	CoD.CTUtility.ClearInfoText(f13_arg0, "SideInfoText")
end
CoD.CTUtility.SetSpecialistsButtonInfoText = function(f14_arg0)
	CoD.CTUtility.SetInfoTextModel(f14_arg0, "MainInfoText", Engine[@"hash_4F9F1239CFD921FE"](@"hash_6C7C0D9FC82A3E84"))
	CoD.CTUtility.ClearInfoText(f14_arg0, "SideInfoText")
end
CoD.CTUtility.SetArchivesButtonInfoText = function(f15_arg0)
	CoD.CTUtility.SetInfoTextModel(f15_arg0, "SideInfoText", Engine[@"hash_4F9F1239CFD921FE"](@"hash_72BCFF4522F11355"))
	CoD.CTUtility.ClearInfoText(f15_arg0, "MainInfoText")
end
CoD.CTUtility.SetDossierButtonInfoText = function(f16_arg0)
	local f16_local0 = DataSources.SpecialistHeadquarters.getModel(f16_arg0)
	local f16_local1 = f16_local0.ChosenSpecialistID:get()
	local f16_local2 = @"hash_549B4D96973CDC59"
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		f16_local2 = @"hash_33546489B5BFCE8F"
	end
	CoD.CTUtility.SetInfoTextModel(f16_arg0, "SideInfoText", Engine[@"hash_4F9F1239CFD921FE"](f16_local2, CoD.CTUtility.PlayerRoleIndexToName(f16_local1)))
	CoD.CTUtility.ClearInfoText(f16_arg0, "MainInfoText")
end
CoD.CTUtility.SetInfoText = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = f17_arg1:getModel()
	if f17_local0 and f17_local0.infoText and f17_local0.infoText:get() then
		CoD.CTUtility.SetInfoTextModel(f17_arg0, f17_arg2, f17_local0.infoText:get())
	end
end
CoD.CTUtility.ClearInfoText = function(f18_arg0, f18_arg1)
	CoD.CTUtility.SetInfoTextModel(f18_arg0, f18_arg1, "")
end
CoD.CTUtility.SetChosenSpecialist = function(f19_arg0, f19_arg1)
	local f19_local0 = CoD.SafeGetModelValue(f19_arg1:getModel(), "characterIndex")
	local f19_local1 = CoD.SafeGetModelValue(f19_arg1:getModel(), "gametype")
	local f19_local2 = CoD.SafeGetModelValue(f19_arg1:getModel(), "map")
	local f19_local3 = CoD.SafeGetModelValue(f19_arg1:getModel(), "difficulty")
	local f19_local4, f19_local5, f19_local6, f19_local7, f19_local8 = CoD.CTUtility.GetSpecialistProgress(f19_arg0, f19_local0)
	if not f19_local4 then
		f19_local1 = CoD.SafeGetModelValue(f19_arg1:getModel(), "ctGametype")
		f19_local2 = CoD.SafeGetModelValue(f19_arg1:getModel(), "ctMap")
		f19_local3 = CoD.SafeGetModelValue(f19_arg1:getModel(), "ctDifficulty")
	end
	if f19_local0 and f19_local1 and f19_local2 and f19_local3 then
		CoD.CTUtility.SetChosenSpecialistParams(f19_arg0, f19_local0, true, f19_local1, f19_local2, f19_local3)
	end
end
CoD.CTUtility.SetReplayTutorial = function(f20_arg0)
	local f20_local0 = DataSources.SpecialistHeadquarters.getModel(f20_arg0)
	local f20_local1 = f20_local0.ChosenSpecialistID:get()
	local f20_local2, f20_local3, f20_local4 = CoD.CTUtility.GetTutorialGameTypeMapDifficulty(f20_local1, Engine.CurrentSessionMode())
	if f20_local1 and f20_local2 and f20_local3 and f20_local4 then
		CoD.CTUtility.SetChosenSpecialistParams(f20_arg0, f20_local1, true, f20_local2, f20_local3, f20_local4)
	end
end
CoD.CTUtility.SetChosenSpecialistParams = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4, f21_arg5)
	local f21_local0 = DataSources.SpecialistHeadquarters.getModel(f21_arg0)
	f21_local0.ChosenSpecialistID:set(f21_arg1)
	CoD.CTUtility.SetLastPlayedSpecialist(f21_arg0, f21_arg1)
	if f21_arg2 then
		f21_local0.HasChosenSpecialist:set(true)
	end
	SetGameType(f21_arg0, f21_arg3)
	SetMap(f21_arg0, Engine[@"converttoxhash"](f21_arg4))
	Engine.SetDvar("overrideDifficulty", f21_arg5)
	CoD.CTUtility.SetBotDifficulty(f21_arg5)
	if f21_arg5 == "tutorial" then
		CoD.CTUtility.SetNavMethodTutorial(f21_arg0)
	else
		CoD.CTUtility.SetNavMethodCT(f21_arg0)
	end
	CoD.CTUtility.UpdateChosenSpecialistStars(f21_local0, CoD.CTUtility.GetSpecialistProgress(f21_arg0, f21_arg1))
	CoD.CTUtility.UpdateLaunchState(f21_arg0)
end
CoD.CTUtility.GetLaunchStateLocString = function(f22_arg0, f22_arg1)
	local f22_local0 = DataSources.SpecialistHeadquarters.getModel(f22_arg0)
	if f22_arg1 == CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_REPLAY_SKIRMISH then
		return @"hash_248CA806830288A9"
	elseif f22_arg1 == CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_PLAY_SKIRMISH then
		return @"hash_3800C003407636A2"
	elseif f22_arg1 == CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_CONTINUE then
		return @"menu/continue"
	else
		return @"menu/play"
	end
end
CoD.CTUtility.GetChosenSpecialistIDLocString = function(f23_arg0, f23_arg1)
	local f23_local0, f23_local1, f23_local2 = CoD.CTUtility.GetOverallSpecialistProgress(f23_arg0)
	local f23_local3, f23_local4, f23_local5, f23_local6, f23_local7 = CoD.CTUtility.GetSpecialistProgress(f23_arg0, f23_arg1)
	if not f23_local0 then
		return @"menu/play"
	elseif f23_local7 then
		return @"hash_248CA806830288A9"
	elseif f23_local3 then
		return @"hash_3800C003407636A2"
	else
		return @"menu/continue"
	end
end
CoD.CTUtility.PlayerRoleIndexToName = function(f24_arg0)
	return CoD.PlayerRoleUtility.GetCharacterDisplayNameByIndex(f24_arg0, Enum.eModes.mode_multiplayer)
end
CoD.CTUtility.PlayerRoleIndexToJobTitle = function(f25_arg0)
	return CoD.PlayerRoleUtility.GetCharacterTraitTitle(Enum.eModes.mode_multiplayer, f25_arg0)
end
CoD.CTUtility.PlayerRoleIndexToBioHeaderImage = function(f26_arg0)
	if f26_arg0 == nil then
		return "$blacktransparent"
	else
		local f26_local0 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum.eModes.mode_multiplayer, f26_arg0)
		if f26_local0 == nil or f26_local0[@"hash_215AC9DAAD709DE1"] == nil then
			return "$blacktransparent"
		else
			return f26_local0[@"hash_215AC9DAAD709DE1"]
		end
	end
end
CoD.CTUtility.UpdateShownSpecialist = function(f27_arg0)
	local f27_local0 = DataSources.SpecialistHeadquarters.getModel(f27_arg0)
	local f27_local1 = f27_local0.ChosenSpecialistID
	if f27_local1 and f27_local1:get() and f27_local1:get() > 0 then
		SendCustomClientScriptMenuStateChangeNotify(f27_arg0, "directorTraining", true, f27_local1:get())
	end
end
CoD.CTUtility.HideShownSpecialist = function(f28_arg0)
	SendClientScriptMenuChangeNotifyHelper(f28_arg0, "directorTraining", false)
end
CoD.CTUtility.GetSkirmishGameTypeMapDifficulty = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3, f29_arg4, f29_arg5, f29_arg6)
	local f29_local0 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f29_arg1, f29_arg0)
	local f29_local1, f29_local2, f29_local3 = nil
	if f29_arg6 then
		f29_local1 = f29_local0[@"hash_35A873E17692CBFE"] or ""
		f29_local2 = f29_local0[@"hash_4900353EF4FD693A"] or ""
		f29_local3 = "hard"
	elseif f29_arg5 then
		f29_local1 = f29_local0[@"hash_35A873E17692CBFE"] or ""
		f29_local2 = f29_local0[@"hash_4900353EF4FD693A"] or ""
		f29_local3 = "hard"
	elseif f29_arg4 then
		f29_local1 = f29_local0[@"hash_5717A425BAC088AC"] or ""
		f29_local2 = f29_local0[0x8007A05053F4C8] or ""
		f29_local3 = "medium"
	elseif f29_arg3 then
		f29_local1 = f29_local0[@"hash_154F17CD8640E051"] or ""
		f29_local2 = f29_local0[@"hash_7AD2DE1A3F24B1CB"] or ""
		f29_local3 = "easy"
	else
		f29_local1 = f29_local0[@"hash_383F1393783AB755"] or ""
		f29_local2 = f29_local0[@"hash_6C03A3925B7BCA37"] or ""
		f29_local3 = "tutorial"
	end
	return f29_local1, f29_local2, f29_local3
end
CoD.CTUtility.GetTutorialGameTypeMapDifficulty = function(f30_arg0, f30_arg1)
	local f30_local0 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f30_arg1, f30_arg0)
	local f30_local1, f30_local2, f30_local3 = nil
	return f30_local0[@"ctgametype"], f30_local0[@"ctmap"], "tutorial"
end
CoD.CTUtility.GetBaseGameTypeMapDifficulty = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3, f31_arg4, f31_arg5, f31_arg6)
	if f31_arg2 then
		return CoD.CTUtility.GetSkirmishGameTypeMapDifficulty(f31_arg0, f31_arg1, f31_arg2, f31_arg3, f31_arg4, f31_arg5, f31_arg6)
	else
		return CoD.CTUtility.GetTutorialGameTypeMapDifficulty(f31_arg0, f31_arg1)
	end
end
DataSources.SpecialistHeadquartersLoadoutList = ListHelper_SetupDataSource("SpecialistHeadquartersLoadoutList", function(f32_arg0, f32_arg1)
	local f32_local0 = {}
	local f32_local1 = Engine.CurrentSessionMode()
	if f32_arg1.menu and CoD.BaseUtility.GetMenuSessionMode(f32_arg1.menu) then
		f32_local1 = CoD.BaseUtility.GetMenuSessionMode(f32_arg1.menu)
	end
	local f32_local2 = f32_arg1.menu._selectIndex
	if not f32_local2 then
		local f32_local3 = DataSources.SpecialistHeadquarters.getModel(f32_arg0)
		local f32_local4 = f32_local3.ChosenSpecialistID
		if f32_local4 and f32_local4:get() and f32_local4:get() > 0 then
			f32_local2 = f32_local4:get()
		end
	end
	local f32_local3 = CoD.CTUtility.GetArchivesBundle()
	return CoD.PlayerRoleUtility.GetPlayerRolesListHelper(f32_arg1, f32_arg0, f32_local1, function(f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4)
		local f33_local0 = f33_arg4.models.characterIndex
		local f33_local1 = f33_arg4.properties.character
		if f33_local1.iscombattrainingenabled == 0 then
			return false
		end
		local f33_local2 = CoD.PlayerRoleUtility.GetPositionRoleDefaultInfo(f33_arg2, f33_local0)
		f33_arg4.models.noContextWidget = true
		f33_arg4.models.detailedDesc = Engine[@"hash_4F9F1239CFD921FE"](CoD.PlayerRoleUtility.GetCharacterTraitSummary(f33_arg2, f33_local0))
		f33_arg4.properties.selectIndex = f32_local2 == f33_local0
		f33_arg4.models.bio = f33_local1[@"bio"] or 0x0
		f33_arg4.models.bioHeader = f33_local1[@"bioheader"] or 0x0
		f33_arg4.models.bioHeaderImage = f33_local1[@"hash_215AC9DAAD709DE1"] or "blacktransparent"
		f33_arg4.models.brandingImage = f33_local1.branding or "blacktransparent"
		f33_arg4.models.equipment = f33_local2.equipment
		f33_arg4.models.ability = f33_local2.ability
		local f33_local3, f33_local4, f33_local5, f33_local6, f33_local7 = CoD.CTUtility.GetSpecialistProgress(f33_arg1, f33_local0)
		f33_arg4.models.finishedTutorial = f33_local3
		f33_arg4.models.complete = f33_local4
		local f33_local8
		if not f33_local5 then
			f33_local8 = f32_local3[0x59E33E621BA5C9]
			if not f33_local8 then
			else
				f33_arg4.models.recruitStars = {
					starImage = f33_local8 or "blacktransparent",
					header = f32_local3[@"hash_4EE9D30C4FF6408B"] or 0x0,
				}
				local f33_local9
				if not f33_local6 then
					f33_local9 = f32_local3[@"hash_1837781ED9D28DFE"]
					if not f33_local9 then
					else
						f33_arg4.models.regularStars = {
							starImage = f33_local9 or "blacktransparent",
							header = f32_local3[@"hash_6B9793AA447A56D6"] or 0x0,
						}
						local f33_local10
						if not f33_local7 then
							f33_local10 = f32_local3[@"hash_32A86A3123124448"]
							if not f33_local10 then
							else
								f33_arg4.models.veteranStars = {
									starImage = f33_local10 or "blacktransparent",
									header = f32_local3[@"hash_57B08A6C17B1A530"] or 0x0,
								}
								local f33_local11 = f33_arg4.models
								local f33_local12 = f33_arg4.models
								local f33_local13 = f33_arg4.models
								f33_local11.gametype, f33_local12.map, f33_local13.difficulty = CoD.CTUtility.GetSkirmishGameTypeMapDifficulty(f33_local0, f33_arg2, f33_local3, f33_local4, f33_local5, f33_local6, f33_local7)
								f33_local11 = f33_arg4.models
								f33_local12 = f33_arg4.models
								f33_local13 = f33_arg4.models
								f33_local11.ctGametype, f33_local12.ctMap, f33_local13.ctDifficulty = CoD.CTUtility.GetTutorialGameTypeMapDifficulty(f33_local0, f33_arg2)
								return true
							end
						end
						f33_local10 = f32_local3[@"hash_7F27D1AD2C9B5996"]
					end
				end
				f33_local9 = f32_local3[0xB33A692CA73C2C]
			end
		end
		f33_local8 = f32_local3[@"hash_7B01945311AF5ACD"]
	end)
end, false)
CoD.CTUtility.GetArchivesBundle = function()
	if not CoD.CTUtility.ArchivesBundle then
		CoD.CTUtility.ArchivesBundle = Engine[@"hash_2E00B2F29271C60B"]("t8_specialist_archives")
	end
	return CoD.CTUtility.ArchivesBundle
end
CoD.CTUtility.CreateVideoModel = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = f35_arg0:create(f35_arg1 .. "Title")
	f35_local0:set(f35_arg2.title)
	f35_local0 = f35_arg0:create(f35_arg1 .. "Desc")
	f35_local0:set(f35_arg2.desc)
	f35_local0 = f35_arg0:create(f35_arg1 .. "Unlocked")
	f35_local0:set(f35_arg2.unlocked)
	f35_local0 = f35_arg0:create(f35_arg1 .. "MatureContent")
	f35_local0:set(f35_arg2.matureContent)
	f35_arg0:create(f35_arg1)
	f35_local0 = f35_arg0[f35_arg1]:create("stillPreview")
	f35_local0:set(f35_arg2.video.stillPreview)
	f35_arg0[f35_arg1]:create("lowResVideo")
	f35_local0 = f35_arg0[f35_arg1].lowResVideo:create("movieName")
	f35_local0:set(f35_arg2.video.lowResVideo.movieName)
	f35_local0 = f35_arg0[f35_arg1].lowResVideo:create("isStreamed")
	f35_local0:set(f35_arg2.video.lowResVideo.isStreamed)
	f35_local0 = f35_arg0[f35_arg1].lowResVideo:create("isLooping")
	f35_local0:set(f35_arg2.video.lowResVideo.isLooping)
	f35_arg0[f35_arg1]:create("hiResVideo")
	f35_local0 = f35_arg0[f35_arg1].hiResVideo:create("movieName")
	f35_local0:set(f35_arg2.video.hiResVideo.movieName)
	f35_local0 = f35_arg0[f35_arg1].hiResVideo:create("isStreamed")
	f35_local0:set(f35_arg2.video.hiResVideo.isStreamed)
	f35_local0 = f35_arg0[f35_arg1].hiResVideo:create("isLooping")
	f35_local0:set(f35_arg2.video.hiResVideo.isLooping)
end
CoD.CTUtility.CreateClassifiedVideo = function(f36_arg0, f36_arg1, f36_arg2)
	local f36_local0 = CoD.CTUtility.GetClassifiedVideo(f36_arg2)
	CoD.CTUtility.CreateVideoModel(f36_arg0, f36_arg1, f36_local0.models)
end
CoD.CTUtility.GetClassifiedVideo = function(f37_arg0)
	local f37_local0 = CoD.CTUtility.GetArchivesBundle()
	return {
		models = {
			title = f37_local0[@"classifiedtitle"],
			desc = f37_arg0,
			unlocked = false,
			matureContent = false,
			video = {
				stillPreview = f37_local0.classifiedstillpreview,
				lowResVideo = {
					movieName = "",
					isStreamed = false,
					isLooping = false,
				},
				hiResVideo = {
					movieName = "",
					isStreamed = false,
					isLooping = false,
				},
			},
		},
		properties = {
			selectIndex = false,
		},
	}
end
DataSources.ArchivesVideoList = ListHelper_SetupDataSource("ArchivesVideoList", function(f38_arg0, f38_arg1)
	local f38_local0 = {}
	local f38_local1 = CoD.CTUtility.GetArchivesBundle()
	local f38_local2 = true
	if f38_local2 then
		table.insert(f38_local0, {
			models = {
				title = f38_local1[@"hash_3B9F9B5916459069"],
				desc = f38_local1[@"hash_57D1A480BB3A9CC0"],
				unlocked = f38_local2,
				matureContent = f38_local1[@"hash_641FF0587D0A3B33"] ~= 0,
				video = {
					stillPreview = f38_local1[@"hash_44FBDE8BF1BD0004"],
					lowResVideo = {
						movieName = "",
						isStreamed = false,
						isLooping = false,
					},
					hiResVideo = {
						movieName = f38_local1[@"hash_7C873FF231AABAE6"],
						isStreamed = f38_local1[@"hash_62EDACFCAA4E38C7"] ~= 0,
						isLooping = false,
					},
				},
			},
			properties = {
				selectIndex = true,
			},
		})
	else
		table.insert(f38_local0, CoD.CTUtility.GetClassifiedVideo(f38_local1[@"hash_92EF4A2BFB1B67F"]))
		f38_local0[1].properties.selectIndex = true
	end
	local f38_local3 = true
	if f38_local3 then
		table.insert(f38_local0, {
			models = {
				title = f38_local1[0x1686694219F5A8],
				desc = f38_local1[@"hash_31E6F480EBA7B1EF"],
				unlocked = f38_local3,
				matureContent = f38_local1.isintrotutorialmoviematurecontent ~= 0,
				video = {
					stillPreview = f38_local1[@"hash_DC263F4717B5D99"],
					lowResVideo = {
						movieName = "",
						isStreamed = false,
						isLooping = false,
					},
					hiResVideo = {
						movieName = f38_local1.introtutorialmovie,
						isStreamed = f38_local1.isintrotutorialmoviestreamed ~= 0,
						isLooping = false,
					},
				},
			},
			properties = {
				selectIndex = false,
			},
		})
	else
		table.insert(f38_local0, CoD.CTUtility.GetClassifiedVideo(f38_local1[@"hash_43F9E31256148ABC"]))
	end
	for f38_local4 = 1, #f38_local1.interstitiallist, 1 do
		local f38_local7 = f38_local1.interstitiallist[f38_local4]
		local f38_local8 = CoD.CTUtility.HasSeenInterstitial(f38_arg0, f38_local4)
		if not f38_local8 then
			f38_local8 = CoD.CTUtility.AllCTUnlocked()
		end
		if f38_local8 then
			table.insert(f38_local0, {
				models = {
					title = f38_local7[@"videotitle"],
					desc = f38_local7[@"hash_1E7843CB3928558D"],
					unlocked = f38_local8,
					matureContent = false,
					video = {
						stillPreview = f38_local7[@"stillpreview"],
						lowResVideo = {
							movieName = "",
							isStreamed = false,
							isLooping = false,
						},
						hiResVideo = {
							movieName = f38_local7[@"movie"],
							isStreamed = f38_local7[@"hash_46A7910E9CDC80BE"] ~= 0,
							isLooping = false,
						},
					},
				},
				properties = {
					selectIndex = false,
				},
			})
		else
			table.insert(f38_local0, CoD.CTUtility.GetClassifiedVideo(f38_local7[@"hash_63168F93CEF4835A"]))
		end
	end
	local f38_local4, f38_local5, f38_local6 = CoD.CTUtility.GetOverallSpecialistProgress(f38_arg0)
	local f38_local9 = CoD.CTUtility.HasSeenMovie(f38_arg0, "story_outro")
	if not f38_local9 then
		f38_local9 = f38_local5 or CoD.CTUtility.AllCTUnlocked()
	end
	if f38_local9 then
		table.insert(f38_local0, {
			models = {
				title = f38_local1[0x9301D995E3462],
				desc = f38_local1[@"hash_551125A3EE94A935"],
				unlocked = f38_local9,
				matureContent = f38_local1[@"hash_22F18C36176E53B0"] ~= 0,
				video = {
					stillPreview = f38_local1[@"hash_62E2A3A8E466ED43"],
					lowResVideo = {
						movieName = "",
						isStreamed = false,
						isLooping = false,
					},
					hiResVideo = {
						movieName = f38_local1[@"hash_336E2B225B641667"],
						isStreamed = f38_local1[@"hash_5B8491CC31D691C6"] ~= 0,
						isLooping = false,
					},
				},
			},
			properties = {
				selectIndex = false,
			},
		})
	else
		table.insert(f38_local0, CoD.CTUtility.GetClassifiedVideo(f38_local1[@"hash_4832787480D8552"]))
	end
	local f38_local7 = CoD.CTUtility.HasSeenMovie(f38_arg0, "woods_outro")
	if not f38_local7 then
		f38_local7 = CoD.CTUtility.AllCTUnlocked()
	end
	if f38_local7 then
		table.insert(f38_local0, {
			models = {
				title = f38_local1[@"hash_64775A9844E7EF0D"],
				desc = f38_local1[@"hash_4605D675D630A78C"],
				unlocked = f38_local7,
				matureContent = f38_local1[@"hash_3515E45AD81B9327"] ~= 0,
				video = {
					stillPreview = f38_local1[0xEF31CF4BCA6610],
					lowResVideo = {
						movieName = "",
						isStreamed = false,
						isLooping = false,
					},
					hiResVideo = {
						movieName = f38_local1.outrotutorialmovie,
						isStreamed = f38_local1[@"hash_734B4156EBE6988B"] ~= 0,
						isLooping = false,
					},
				},
			},
			properties = {
				selectIndex = false,
			},
		})
	else
		table.insert(f38_local0, CoD.CTUtility.GetClassifiedVideo(f38_local1[@"hash_7EA2980B60C4D28B"]))
	end
	return f38_local0
end, false)
DataSources.ArchivesExtraList = ListHelper_SetupDataSource("ArchivesExtraList", function(f39_arg0, f39_arg1)
	local f39_local0 = {}
	local f39_local1 = CoD.CTUtility.GetArchivesBundle()
	if f39_local1.onboardinglist and #f39_local1.onboardinglist > 0 then
		for f39_local2 = 1, #f39_local1.onboardinglist, 1 do
			local f39_local5 = f39_local1.onboardinglist[f39_local2]
			table.insert(f39_local0, {
				models = {
					title = f39_local5[@"videotitle"],
					desc = f39_local5[@"hash_1E7843CB3928558D"] or 0x0,
					unlocked = true,
					matureContent = f39_local5[@"hash_7F86C2144EEF36A8"] ~= 0,
					video = {
						stillPreview = f39_local5[@"stillpreview"],
						lowResVideo = {
							movieName = "",
							isStreamed = false,
							isLooping = false,
						},
						hiResVideo = {
							movieName = f39_local5[@"movie"],
							isStreamed = f39_local5[@"hash_46A7910E9CDC80BE"] ~= 0,
							isLooping = false,
						},
					},
				},
				properties = {
					selectIndex = false,
				},
			})
		end
		f39_local0[1].properties.selectIndex = true
	end
	return f39_local0
end, false)
DataSources.ArchivesAudioList = ListHelper_SetupDataSource("ArchivesAudioList", function(f40_arg0, f40_arg1)
	local f40_local0 = {}
	local f40_local1 = CoD.CTUtility.GetArchivesBundle()
	if f40_local1.intellist and #f40_local1.intellist > 0 then
		for f40_local2 = 1, #f40_local1.intellist, 1 do
			local f40_local5 = f40_local1.intellist[f40_local2]
			local f40_local6 = f40_local5.audiochallengedesc
			local f40_local7 = CoD.CTUtility.IsCTCallingCardUnlocked(f40_arg0, f40_local6)
			local f40_local8 = f40_local5[@"hash_3F98B530FF7CFBE4"]
			local f40_local9 = f40_local5.audio
			local f40_local10 = CoD.CTUtility.GetCallingCardID(f40_local6)
			if not f40_local7 then
				f40_local8 = f40_local6
				f40_local9 = ""
				f40_local10 = 0
			end
			table.insert(f40_local0, {
				models = {
					title = f40_local5[@"audiotitle"],
					desc = f40_local8,
					unlocked = f40_local7,
					matureContent = f40_local5[@"hash_23E2313142ABE602"] ~= 0,
					alias = f40_local9,
					icon = CoD.ChallengesUtility.GetBackgroundByID(f40_local10),
				},
				properties = {
					selectIndex = false,
				},
			})
		end
		f40_local0[1].properties.selectIndex = true
	end
	return f40_local0
end, false)
CoD.CTUtility.ShouldLaunchImmediately = function(f41_arg0)
	local f41_local0 = DataSources.SpecialistHeadquarters.getModel(f41_arg0)
	return f41_local0.LaunchState:get() == CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_PLAY
end
CoD.CTUtility.CTDifficultyToDesc = function(f42_arg0)
	local f42_local0 = CoD.CTUtility.GetArchivesBundle()
	if f42_arg0 == "tutorial" or f42_arg0 == "easy" then
		return f42_local0.easydiffdesc or 0x0
	elseif f42_arg0 == "medium" then
		return f42_local0.mediumdiffdesc or 0x0
	elseif f42_arg0 == "hard" then
		return f42_local0.harddiffdesc or 0x0
	else
		return 0x0
	end
end
CoD.CTUtility.CTDifficultyToSkirmishName = function(f43_arg0)
	local f43_local0 = CoD.CTUtility.GetArchivesBundle()
	local f43_local1 = 0x0
	if f43_arg0 == "tutorial" or f43_arg0 == "easy" then
		f43_local1 = f43_local0[@"hash_4EE9D30C4FF6408B"] or 0x0
	elseif f43_arg0 == "medium" then
		f43_local1 = f43_local0[@"hash_6B9793AA447A56D6"] or 0x0
	elseif f43_arg0 == "hard" then
		f43_local1 = f43_local0[@"hash_57B08A6C17B1A530"] or 0x0
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7B200A16DFDCF3F7", f43_local1)
end
CoD.CTUtility.SubscribeForDefaultSpecialistSelection = function(f44_arg0, f44_arg1)
	local f44_local0 = function()
		CoD.CTUtility.SetDefaultSpecialist(f44_arg0, f44_arg1)
	end
	if not f44_arg0._hasLobbyNavSubscription then
		f44_arg0._hasLobbyNavSubscription = true
		f44_arg0:subscribeToModel(Engine.CreateModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyNav"), f44_local0, false)
		local f44_local1 = f44_arg0
		local f44_local2 = f44_arg0.subscribeToModel
		local f44_local3 = Engine.GetGlobalModel()
		f44_local2(f44_local1, f44_local3["lobbyRoot.privateClient.update"], f44_local0, false)
	end
end
CoD.CTUtility.CharacterIndexValid = function(f46_arg0)
	if f46_arg0 == nil then
		return false
	end
	for f46_local3, f46_local4 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Enum.eModes.mode_multiplayer)) do
		if f46_arg0 == f46_local4.bodyIndex and f46_local4.iscombattrainingenabled ~= 0 then
			return true
		end
	end
	return false
end
CoD.CTUtility.SetDefaultSpecialist = function(f47_arg0, f47_arg1)
	local f47_local0 = DataSources.SpecialistHeadquarters.getModel(f47_arg1)
	local f47_local1 = LobbyData.GetCurrentMenuTarget()
	if f47_local1.id == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) then
		CoD.CTUtility.UpdateStarCount(f47_arg1)
		if f47_local0.HasSetDefaultSpecialist:get() then
			return
		end
		local f47_local2 = Engine.GetGlobalModel()
		f47_local2 = f47_local2:create("CTNavMethod", true)
		f47_local2 = f47_local2:get()
		local f47_local3, f47_local4 = false
		if f47_local0.HasChosenSpecialist:get() then
			f47_local3 = false
			f47_local4 = f47_local0.ChosenSpecialistID:get()
		else
			local f47_local5, f47_local6, f47_local7 = CoD.CTUtility.GetOverallSpecialistProgress(f47_arg1)
			if f47_local2 == CoD.CTUtility.SpecialistHeadquartersNavigationMethod.FROM_FRONTEND then
				if f47_local6 then
					f47_local4 = CoD.CTUtility.GetLastPlayedSpecialist(f47_arg1)
				elseif f47_local5 then
					f47_local4 = CoD.CTUtility.GetNewSpecialist(f47_arg1)
				else
					f47_local4 = 1
				end
			elseif f47_local2 == CoD.CTUtility.SpecialistHeadquartersNavigationMethod.FROM_TUTORIAL_SKIRMISH then
				f47_local3 = true
				if f47_local6 then
					f47_local4 = CoD.CTUtility.GetLastPlayedSpecialist(f47_arg1)
				else
					f47_local4 = CoD.CTUtility.GetNewSpecialist(f47_arg1)
				end
			elseif f47_local2 == CoD.CTUtility.SpecialistHeadquartersNavigationMethod.FROM_COMBAT_TRAINING then
				f47_local3 = true
				f47_local4 = CoD.CTUtility.GetLastPlayedSpecialist(f47_arg1)
			end
		end
		if not CoD.CTUtility.CharacterIndexValid(f47_local4) then
			f47_local4 = 1
		end
		if f47_local4 then
			CoD.CTUtility.SetChosenSpecialistParams(f47_arg1, f47_local4, false, CoD.CTUtility.GetBaseGameTypeMapDifficulty(f47_local4, Enum.eModes.mode_multiplayer, CoD.CTUtility.GetSpecialistProgress(f47_arg1, f47_local4)))
			f47_local0.HasSetDefaultSpecialist:set(true)
			if f47_local3 then
				f47_local0.HasChosenSpecialist:set(true)
				f47_local0.ShowPlayButtonInSpecialistSelect:set(true)
				OpenOverlay(f47_arg0, "SpecialistHeadquartersSelectSpecialist", f47_arg1)
			end
		end
		if f47_local2 == CoD.CTUtility.SpecialistHeadquartersNavigationMethod.FROM_FRONTEND and CoD.CTUtility.ShouldPlayIntroStoryMovie(f47_arg1) then
			CoD.FTUEUtility.ShowFTUESequence(f47_arg0, f47_arg1, "SpecialistHQIntroduction")
		end
	elseif f47_local0.HasSetDefaultSpecialist:get() then
		f47_local0.HasSetDefaultSpecialist:set(false)
		f47_local0.StartFullscreenBlack:set(false)
		MenuUnhideFreeCursor(f47_arg0, f47_arg1)
		CoD.CTUtility.HideShownSpecialist(f47_arg1)
		Engine.SetDvar("bot_difficulty", 1)
	end
end
CoD.CTUtility.ShouldPlayIntroStoryMovie = function(f48_arg0)
	if not CoD.CTUtility.HasSeenMovie(f48_arg0, "story_intro") then
		return true
	else
		return false
	end
end
CoD.CTUtility.ShouldPlayIntroTutorialMovie = function(f49_arg0)
	local f49_local0 = CoD.CTUtility.HasSeenMovie(f49_arg0, "woods_intro")
	local f49_local1 = CoD.CTUtility.GetArchivesBundle()
	if not f49_local0 and f49_local1.introtutorialmovie ~= nil and f49_local1.introtutorialmovie ~= "" and CoD.CTUtility.CanPlayVideo(f49_arg0, f49_local1.isintrotutorialmoviematurecontent) then
		return true
	else
		return false
	end
end
CoD.CTUtility.InitSpecialistHeadquarters = function(f50_arg0, f50_arg1)
	f50_arg0:addElement(LUI.UITimer.newElementTimer(0, true, function()
		CoD.CTUtility.SetDefaultSpecialist(f50_arg0, f50_arg1)
	end))
end
CoD.CTUtility.GetSpecialistProgress = function(f52_arg0, f52_arg1)
	local f52_local0 = CoD.CTUtility.GetCTStatsBuffer(f52_arg0)
	if not f52_local0 then
		return false, false, false, false, false
	end
	local f52_local1 = f52_local0.specialistStats[f52_arg1]
	local f52_local2 = f52_local1.trainingState:get()
	local f52_local3 = f52_local1.combatImmersionStars.gold:get() == 1
	local f52_local4
	if f52_local1.combatImmersionStars.silver:get() ~= 1 then
		f52_local4 = f52_local3
	else
		f52_local4 = true
	end
	local f52_local5
	if f52_local1.combatImmersionStars.bronze:get() ~= 1 then
		f52_local5 = f52_local4
	else
		f52_local5 = true
	end
	local f52_local6
	if f52_local2 ~= "skirmish_completed" then
		f52_local6 = f52_local5
	else
		f52_local6 = true
	end
	local f52_local7
	if f52_local2 ~= "tutorial_completed" then
		f52_local7 = f52_local6
	else
		f52_local7 = true
	end
	return f52_local7, f52_local6, f52_local5, f52_local4, f52_local3
end
CoD.CTUtility.GetOverallSpecialistProgress = function(f53_arg0)
	local f53_local0 = CoD.PlayerRoleUtility.GetHeroList(Enum.eModes.mode_multiplayer)
	local f53_local1 = false
	local f53_local2 = true
	local f53_local3 = true
	for f53_local12, f53_local13 in ipairs(f53_local0) do
		local f53_local14 = f53_local13.bodyIndex
		if f53_local13.iscombattrainingenabled ~= 0 then
			local f53_local7, f53_local8, f53_local9, f53_local10, f53_local11 = CoD.CTUtility.GetSpecialistProgress(f53_arg0, f53_local14)
			if f53_local2 then
				f53_local2 = f53_local8
			end
			if f53_local3 then
				f53_local3 = f53_local11
			end
			if not f53_local1 then
				f53_local1 = f53_local7
			end
		end
	end
	return f53_local1, f53_local2, f53_local3
end
CoD.CTUtility.GetNewSpecialist = function(f54_arg0)
	for f54_local8, f54_local9 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Enum.eModes.mode_multiplayer)) do
		local f54_local10 = f54_local9.bodyIndex
		if f54_local9.iscombattrainingenabled ~= 0 then
			local f54_local3, f54_local4, f54_local5, f54_local6, f54_local7 = CoD.CTUtility.GetSpecialistProgress(f54_arg0, f54_local10)
			if not f54_local4 then
				return f54_local10
			end
		end
	end
	return nil
end
DataSources.SpecialistNarrativeTabs = ListHelper_SetupDataSource("SpecialistNarrativeTabs", function(f55_arg0, f55_arg1)
	local f55_local0 = {}
	if not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
		table.insert(f55_local0, {
			models = {
				name = @"hash_196C1401113DAD5C",
				tabWidget = "CoD.Archives_Videos",
				available = true,
			},
			properties = {
				tabId = "videos",
				selectIndex = true,
			},
		})
	end
	table.insert(f55_local0, {
		models = {
			name = @"hash_34AB5E7779411DAE",
			tabWidget = "CoD.Archives_Audio",
			available = true,
		},
		properties = {
			tabId = "audio",
			selectIndex = false,
		},
	})
	table.insert(f55_local0, {
		models = {
			name = @"hash_80C2DA6CBFB7347",
			tabWidget = "CoD.Archives_Extras",
			available = true,
		},
		properties = {
			tabId = "extras",
			selectIndex = false,
		},
	})
	return f55_local0
end)
CoD.CTUtility.SetNavMethodFrontend = function(f56_arg0)
	local f56_local0 = Engine.GetGlobalModel()
	f56_local0 = f56_local0:create("CTNavMethod", true)
	f56_local0:set(CoD.CTUtility.SpecialistHeadquartersNavigationMethod.FROM_FRONTEND)
end
CoD.CTUtility.SetNavMethodTutorial = function(f57_arg0)
	local f57_local0 = Engine.GetGlobalModel()
	f57_local0 = f57_local0:create("CTNavMethod", true)
	f57_local0:set(CoD.CTUtility.SpecialistHeadquartersNavigationMethod.FROM_TUTORIAL_SKIRMISH)
end
CoD.CTUtility.SetNavMethodCT = function(f58_arg0)
	local f58_local0 = Engine.GetGlobalModel()
	f58_local0 = f58_local0:create("CTNavMethod", true)
	f58_local0:set(CoD.CTUtility.SpecialistHeadquartersNavigationMethod.FROM_COMBAT_TRAINING)
end
CoD.CTUtility.LaunchGame = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
	LaunchGamePrototype(f59_arg1, f59_arg2, f59_arg3)
end
CoD.CTUtility.PlaySkippableVideo = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3, f60_arg4)
	local f60_local0 = Enum[@"hash_6C47FC1BD2E5CCEE"][@"hash_390B07394D69C5F4"]
	if f60_arg3 then
		f60_local0 = Enum[@"hash_6C47FC1BD2E5CCEE"][@"hash_655550017F21A53C"]
	end
	local f60_local1 = DataSources.VoDViewer.getModel(f60_arg0)
	f60_local1.stream:set(CoD.VideoStreamingUtility.GetMoviePlayerParams(f60_local0, f60_arg2, false, false))
	DelayOpenOverlay(f60_arg1, "SkippableVoDViewer", f60_arg0, f60_arg4)
end
CoD.CTUtility.ShowReplayTutorial = function(f61_arg0)
	local f61_local0 = DataSources.SpecialistHeadquarters.getModel(f61_arg0)
	local f61_local1, f61_local2, f61_local3, f61_local4, f61_local5 = CoD.CTUtility.GetSpecialistProgress(f61_arg0, f61_local0.ChosenSpecialistID:get())
	return f61_local1
end
CoD.CTUtility.IsMatureContent = function(f62_arg0)
	return CoD.OptionsUtility.IsProfileIntValue(f62_arg0, "cg_mature", 1)
end
CoD.CTUtility.CanPlayVideo = function(f63_arg0, f63_arg1)
	local f63_local0 = CoD.CTUtility.IsMatureContent(f63_arg0)
	if not f63_local0 then
		if CoD.CTUtility.IsMatureContent(f63_arg0) or f63_arg1 ~= 0 then
			f63_local0 = false
		else
			f63_local0 = true
		end
	end
	return f63_local0
end
CoD.CTUtility.UnhideFreeCursor = function(f64_arg0, f64_arg1)
	f64_arg0:addElement(LUI.UITimer.newElementTimer(0, true, function()
		MenuUnhideFreeCursor(f64_arg0, f64_arg1)
	end))
end
CoD.CTUtility.GetLoadingMovie = function(f66_arg0, f66_arg1, f66_arg2)
	local f66_local0 = nil
	local f66_local1 = false
	local f66_local2 = false
	local f66_local3 = CoD.PlayerRoleUtility.GetHeroList(f66_arg2)
	for f66_local4 = 1, #f66_local3, 1 do
		local f66_local7 = f66_local3[f66_local4]
		if f66_local7.iscombattrainingenabled ~= 0 and f66_local7[@"ctgametype"] == f66_arg1 then
			f66_local0 = f66_local7[@"intromovie"]
			f66_local2 = true
			break
		end
	end
	if f66_local2 and CoD.CTUtility.ShouldPlayIntroTutorialMovie(f66_arg0) and (not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus()) then
		f66_local4 = CoD.CTUtility.GetArchivesBundle()
		f66_local0 = f66_local4.introtutorialmovie
		f66_local1 = true
	else
		local f66_local4 = Engine[@"getgametypeinfo"](f66_arg1)
		local f66_local5 = f66_local4[@"tutorialmovie"]
		if f66_local5 and f66_local5 ~= "" and f66_local5 ~= 0x0 then
			f66_local0 = f66_local5
		end
		if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
			f66_local1 = CoD.CTUtility.ShouldPlayIntroTutorialMovie(f66_arg0)
		end
	end
	return f66_local0, f66_local1
end
CoD.CTUtility.GetCTStatsBuffer = function(f67_arg0)
	return Engine.StorageGetBuffer(f67_arg0, Enum.StorageFileType[@"hash_77FA8C2EEB2B6F7A"])
end
CoD.CTUtility.UpdateCTStats = function(f68_arg0)
	Engine.StorageWrite(f68_arg0, Enum.StorageFileType[@"hash_77FA8C2EEB2B6F7A"])
end
CoD.CTUtility.HasSeenMovie = function(f69_arg0, f69_arg1)
	local f69_local0 = CoD.CTUtility.GetCTStatsBuffer(f69_arg0)
	if not f69_local0 then
		return false
	elseif Dvar[@"livestats_skipfirsttime"]:get() then
		return true
	else
		return f69_local0.videosWatched[f69_arg1]:get() == 1
	end
end
CoD.CTUtility.SetSeenMovie = function(f70_arg0, f70_arg1)
	local f70_local0 = CoD.CTUtility.GetCTStatsBuffer(f70_arg0)
	if not f70_local0 then
		return
	else
		f70_local0.videosWatched[f70_arg1]:set(1)
		CoD.CTUtility.UpdateCTStats(f70_arg0)
	end
end
CoD.CTUtility.GetLastPlayedSpecialist = function(f71_arg0)
	local f71_local0 = CoD.CTUtility.GetCTStatsBuffer(f71_arg0)
	if not f71_local0 then
		return 1
	else
		return f71_local0.selectedSpecialist:get()
	end
end
CoD.CTUtility.SetLastPlayedSpecialist = function(f72_arg0, f72_arg1)
	local f72_local0 = CoD.CTUtility.GetCTStatsBuffer(f72_arg0)
	if not f72_local0 then
		return
	else
		f72_local0.selectedSpecialist:set(f72_arg1)
		CoD.CTUtility.UpdateCTStats(f72_arg0)
	end
end
CoD.CTUtility.HasSeenInterstitial = function(f73_arg0, f73_arg1)
	local f73_local0 = CoD.CTUtility.GetCTStatsBuffer(f73_arg0)
	if not f73_local0 then
		return false
	end
	local f73_local1 = function()
		local f74_local0 = 0
		for f74_local9, f74_local10 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Enum.eModes.mode_multiplayer)) do
			local f74_local11 = f74_local10.bodyIndex
			if f74_local10.iscombattrainingenabled ~= 0 then
				local f74_local4, f74_local5, f74_local6, f74_local7, f74_local8 = CoD.CTUtility.GetSpecialistProgress(f73_arg0, f74_local11)
				if f74_local5 then
					f74_local0 = f74_local0 + 1
				end
			end
		end
		return f74_local0
	end
	local f73_local2
	if f73_arg1 > f73_local0.interstitialsWatched:get() and f73_arg1 > f73_local1() then
		f73_local2 = false
	else
		f73_local2 = true
	end
	return f73_local2
end
CoD.CTUtility.PlayArchivesAudio = function(f75_arg0, f75_arg1, f75_arg2)
	CoD.CTUtility.StopArchivesAudio(f75_arg0, f75_arg1, f75_arg2)
	local f75_local0 = CoD.SafeGetModelValue(f75_arg2:getModel(), "alias")
	if f75_local0 and f75_local0 ~= "" then
		Engine.playsound(f75_local0)
		f75_arg0._ArchivesAudioAlias = f75_local0
	end
end
CoD.CTUtility.StopArchivesAudio = function(f76_arg0, f76_arg1, f76_arg2)
	if f76_arg0._ArchivesAudioAlias then
		Engine.stopsound(f76_arg0._ArchivesAudioAlias)
		f76_arg0._ArchivesAudioAlias = nil
	end
end
CoD.CTUtility.GetCTChallengeRows = function()
	local f77_local0 = function(f78_arg0)
		local f78_local0 = 4
		local f78_local1 = Engine.GetTableRowCount(CoD.CTUtility.CTChallengeTable)
		for f78_local2 = 0, f78_local1 - 1, 1 do
			if Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f78_local2, f78_local0) == f78_arg0 then
				return true
			end
		end
		return false
	end
	if CoD.CTUtility.CTChallengeRows == nil then
		CoD.CTUtility.CTChallengeRows = {}
		local f77_local1 = 4
		local f77_local2 = Engine.GetTableRowCount(CoD.backgroundsTable)
		for f77_local3 = 0, f77_local2 - 1, 1 do
			if f77_local0(Engine[@"hash_4C6F8EC444864600"](CoD.backgroundsTable, f77_local3, f77_local1)) then
				table.insert(CoD.CTUtility.CTChallengeRows, f77_local3)
			end
		end
	end
	return CoD.CTUtility.CTChallengeRows
end
CoD.CTUtility.GetCallingCardID = function(f79_arg0)
	local f79_local0 = 1
	local f79_local1 = 4
	local f79_local2 = CoD.CTUtility.GetCTChallengeRows()
	for f79_local3 = 1, #f79_local2, 1 do
		local f79_local6 = f79_local2[f79_local3]
		if Engine[@"hash_4C6F8EC444864600"](CoD.backgroundsTable, f79_local6, f79_local1) == f79_arg0 then
			return Engine[@"hash_4C6F8EC444864600"](CoD.backgroundsTable, f79_local6, f79_local0)
		end
	end
	return 0
end
CoD.CTUtility.GetCTChallenge = function(f80_arg0, f80_arg1)
	local f80_local0 = 0
	local f80_local1 = 1
	local f80_local2 = 2
	local f80_local3 = 3
	local f80_local4 = 4
	local f80_local5 = 5
	local f80_local6 = Engine.TableFindRows(CoD.CTUtility.CTChallengeTable, f80_local0, f80_arg1)
	f80_local6 = f80_local6[1]
	local f80_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f80_local6, f80_local2)
	local f80_local8 = nil
	local f80_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f80_local6, f80_local1)
	local f80_local10 = CoD.CTUtility.GetCTStatsBuffer(f80_arg0)
	if f80_local10 then
		if f80_local7 == "weapon_class_" then
			local f80_local11 = {
				@"hash_683D7DFC8782D6B9",
				"weapon_class_kills_lmg",
				"weapon_class_kills_smg",
				"weapon_class_kills_sniper",
				@"hash_4D4A62396C1EC8",
			}
			f80_local8 = 0
			for f80_local15, f80_local16 in ipairs(f80_local11) do
				if f80_local9 <= f80_local10.challengeProgress[f80_local16]:get() then
					f80_local8 = f80_local8 + 1
				end
			end
			f80_local9 = #f80_local11
		elseif f80_local7 ~= 0x0 and f80_local10.challengeProgress[f80_local7] ~= nil then
			f80_local8 = f80_local10.challengeProgress[f80_local7]:get()
		end
	end
	local f80_local11 = nil
	if f80_local8 ~= nil and f80_local9 ~= nil then
		f80_local11 = f80_local9 <= f80_local8
	end
	local f80_local12 = Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f80_local6, f80_local3)
	local f80_local13 = Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f80_local6, f80_local4)
	return f80_local8, f80_local9, f80_local11, f80_local12, f80_local13, CoD.CTUtility.GetCallingCardID(f80_local13)
end
CoD.CTUtility.GetCTMasterChallenge = function(f81_arg0)
	local f81_local0 = 0
	for f81_local1 = 1, CoD.CTUtility.NumCTChallenges, 1 do
		local f81_local4, f81_local5, f81_local6, f81_local7, f81_local8, f81_local9 = CoD.CTUtility.GetCTChallenge(f81_arg0, f81_local1)
		if f81_local6 then
			f81_local0 = f81_local0 + 1
		end
	end
	local f81_local1, f81_local2, f81_local3, f81_local10, f81_local4, f81_local5 = CoD.CTUtility.GetCTChallenge(f81_arg0, CoD.CTUtility.CTMasterChallengeIndex)
	return f81_local0, CoD.CTUtility.NumCTChallenges, f81_local10, f81_local4, f81_local5
end
CoD.CTUtility.IsCTCallingCardUnlocked = function(f82_arg0, f82_arg1)
	if CoD.CTUtility.AllCTUnlocked() then
		return true
	end
	local f82_local0 = 0
	local f82_local1 = 4
	local f82_local2 = Engine.GetTableRowCount(CoD.CTUtility.CTChallengeTable)
	for f82_local3 = 0, f82_local2 - 1, 1 do
		if Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f82_local3, f82_local1) == f82_arg1 then
			local f82_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f82_local3, f82_local0)
			if f82_local6 == CoD.CTUtility.CTMasterChallengeIndex then
				local f82_local7, f82_local8, f82_local9, f82_local10, f82_local11 = CoD.CTUtility.GetCTMasterChallenge(f82_arg0)
				return f82_local8 <= f82_local7
			end
			local f82_local7, f82_local8, f82_local9, f82_local10, f82_local11, f82_local12 = CoD.CTUtility.GetCTChallenge(f82_arg0, f82_local6)
			return f82_local9
		end
	end
	return false
end
CoD.CTUtility.GetCTCallingCardName = function(f83_arg0)
	local f83_local0 = 3
	local f83_local1 = 4
	local f83_local2 = Engine.GetTableRowCount(CoD.CTUtility.CTChallengeTable)
	for f83_local3 = 0, f83_local2 - 1, 1 do
		if Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f83_local3, f83_local1) == f83_arg0 then
			return Engine[@"hash_4C6F8EC444864600"](CoD.CTUtility.CTChallengeTable, f83_local3, f83_local0)
		end
	end
	return nil
end
CoD.CTUtility.UpdateStarCount = function(f84_arg0)
	local f84_local0 = DataSources.SpecialistHeadquarters.getModel(f84_arg0)
	local f84_local1 = 0
	for f84_local10, f84_local11 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Enum.eModes.mode_multiplayer)) do
		local f84_local12 = f84_local11.bodyIndex
		if f84_local11.iscombattrainingenabled ~= 0 then
			local f84_local5, f84_local6, f84_local7, f84_local8, f84_local9 = CoD.CTUtility.GetSpecialistProgress(f84_arg0, f84_local12)
			if f84_local7 then
				f84_local1 = f84_local1 + 1
			end
			if f84_local8 then
				f84_local1 = f84_local1 + 1
			end
			if f84_local9 then
				f84_local1 = f84_local1 + 1
			end
		end
	end
	f84_local0.StarCount:set(f84_local1)
end
CoD.CTUtility.SetBotDifficulty = function(f85_arg0)
	if f85_arg0 == "tutorial" or f85_arg0 == "easy" then
		Engine.SetDvar("bot_difficulty", 0)
	elseif f85_arg0 == "medium" then
		Engine.SetDvar("bot_difficulty", 1)
	elseif f85_arg0 == "hard" then
		Engine.SetDvar("bot_difficulty", 2)
	end
end
CoD.CTUtility.UpdatedChosenSpecialistListModel = function(f86_arg0, f86_arg1)
	local f86_local0 = DataSources.SpecialistHeadquarters.getModel(f86_arg0)
	local f86_local1 = DataSources.SpecialistHeadquartersLoadoutList.getCount(f86_arg1)
	for f86_local2 = 1, f86_local1, 1 do
		local f86_local5 = DataSources.SpecialistHeadquartersLoadoutList.getItem(f86_arg0, f86_arg1, f86_local2)
		if f86_local5.characterIndex:get() == f86_local0.ChosenSpecialistID:get() then
			f86_local0.ChosenSpecialistListModel:set(f86_local5)
			return
		end
	end
end
CoD.CTUtility.SetShowChosenSpecialistListModel = function(f87_arg0, f87_arg1)
	local f87_local0 = DataSources.SpecialistHeadquarters.getModel(f87_arg0)
	f87_local0.ShowChosenSpecialistList:set(f87_arg1)
end
CoD.CTUtility.StartSkipTimer = function(f88_arg0, f88_arg1)
	local f88_local0 = Engine.GetGlobalModel()
	f88_local0 = f88_local0:create("cutsceneSkippable")
	f88_local0:set(false)
	f88_arg0:addElement(LUI.UITimer.newElementTimer(f88_arg1, true, function()
		f88_local0:set(true)
	end))
end
CoD.CTUtility.RefreshChosenSpecialistParams = function(f90_arg0)
	local f90_local0 = DataSources.SpecialistHeadquarters.getModel(f90_arg0)
	local f90_local1 = f90_local0.ChosenSpecialistID:get()
	CoD.CTUtility.SetChosenSpecialistParams(f90_arg0, f90_local1, false, CoD.CTUtility.GetBaseGameTypeMapDifficulty(f90_local1, Enum.eModes.mode_multiplayer, CoD.CTUtility.GetSpecialistProgress(f90_arg0, f90_local1)))
end
