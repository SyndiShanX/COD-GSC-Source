CoD.StartMenuUtility = {}
CoD.StartMenuUtility.GetSessionModeFromLobby = function()
	local f1_local0 = Engine[0x8DF2E5447F384B9]()
	f1_local0 = f1_local0["lobbyRoot.lobbyMainMode"]
	local f1_local1 = nil
	if f1_local0 then
		f1_local1 = LuaUtils.GetEModeForLobbyMainMode(f1_local0:get())
	end
	if not f1_local1 then
		f1_local1 = Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE]
	end
	return f1_local1
end
CoD.StartMenuUtility.InitDataForStartMenu = function(f2_arg0, f2_arg1, f2_arg2)
	CoD.SpawnSelectionUtility.ForceFullscreenViewportUntilClosed(f2_arg0, f2_arg2)
	SetProperty(f2_arg0, "disableLeaderChangePopupShutdown", true)
	CoD.BaseUtility.InitControllerModel(f2_arg2, "forceScoreboard", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f2_arg2, "PlayerSettingsUpdate", "")
	CoD.BaseUtility.InitControllerModelEnumIfNotSet(f2_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_NONE)
	CoD.StartMenuUtility.SetModeForStartMenu(f2_arg1)
	CoD.StartMenuUtility.SetStorageBufferForMenu(f2_arg1, f2_arg2)
	CoD.StartMenuUtility.SetLoadoutStorageBufferForMenu(f2_arg1, f2_arg2)
	CoD.BreadcrumbUtility.SetClientStorageBufferForMode(f2_arg1, f2_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
	CoD.LobbyUtility.SetMenuControllerRestriction(f2_arg0, f2_arg2, 1)
end
CoD.StartMenuUtility.OpenStartMenuOverlay = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	return OpenOverlay(f3_arg0, f3_arg3, f3_arg2, {
		_sessionMode = f3_arg1._sessionMode,
		_storageBuffer = f3_arg1._storageBuffer,
	})
end
CoD.StartMenuUtility.OpenSpecialistOverlay = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.BaseUtility.GetMenuSessionMode(f4_arg1)
	local f4_local1 = "MPSpecialistHUB"
	if f4_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f4_local1 = "ZMPersonalizeCharacterMain"
	elseif f4_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f4_local1 = "WZPersonalizeCharacterMain"
	end
	return OpenOverlay(f4_arg0, f4_local1, f4_arg2, {
		_sessionMode = f4_local0,
	})
end
CoD.StartMenuUtility.OpenLeaderboardMain = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	OpenOverlay(f5_arg0, f5_arg3, f5_arg2, {
		_sessionMode = CoD.BaseUtility.GetMenuSessionMode(f5_arg1),
	})
	if CoD.LeaderboardUtility.LeaderboardsDownForMaintanence() then
		CoD.LeaderboardUtility.OpenLeaderboardMaintanencePopup(f5_arg1, f5_arg2)
	end
end
CoD.StartMenuUtility.SetModeForStartMenu = function(f6_arg0)
	CoD.BaseUtility.SetMenuSessionMode(f6_arg0, CoD.StartMenuUtility.GetSessionModeFromLobby())
end
CoD.StartMenuUtility.SetStorageBufferForMenu = function(f7_arg0, f7_arg1)
	local f7_local0 = CoD.BaseUtility.GetMenuSessionMode(f7_arg0)
	local f7_local1 = Enum[0xBBD4F9E70101BA8][0xD5A7695E03A7A90]
	if f7_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f7_local1 = Enum[0xBBD4F9E70101BA8][0xA57D6164B91A8FC]
	elseif f7_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f7_local1 = Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC]
	end
	f7_arg0._storageBuffer = Engine[0x8BF970606552F4C](f7_arg1, f7_local1)
end
CoD.StartMenuUtility.SetLoadoutStorageBufferForMenu = function(f8_arg0, f8_arg1)
	local f8_local0 = CoD.BaseUtility.GetMenuSessionMode(f8_arg0)
	local f8_local1 = Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA]
	if f8_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f8_local1 = Enum[0xBBD4F9E70101BA8][0x9E5D6DF436F1EE]
	elseif f8_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f8_local1 = Enum[0xBBD4F9E70101BA8][0xDF87425733853AE]
	end
	local f8_local2 = Engine[0x8BF970606552F4C](f8_arg1, f8_local1)
	if f8_local2 then
		f8_arg0._storageLoadoutBuffer = f8_local2[0x766CE60E25569A3]
	end
end
CoD.StartMenuUtility.CleanUpBarracksTab = function(f9_arg0, f9_arg1)
	CoD.PlayerStatsUtility.EarnedMedalsListTable = nil
	CoD.PlayerStatsUtility.MedalsListTable = nil
end
CoD.StartMenuUtility.CachedClassSelectSlideoutInfo = {}
CoD.StartMenuUtility.SetupMidMatchClassSelect = function(f10_arg0)
	local f10_local0 = CoD.StartMenuUtility.CachedClassSelectSlideoutInfo[f10_arg0]
	if not f10_local0.menu:getParent() then
		return
	end
	local f10_local1 = f10_local0.menu:getParent()
	f10_local1._addedClassSelectPopup = false
	if f10_local0 and f10_local0.menu then
		f10_local1 = f10_local0.menu:getParent()
		f10_local1:removeElement(f10_local0.menu)
	end
end
CoD.StartMenuUtility.AddClassSelectSlideout = function(f11_arg0, f11_arg1)
	if not CoD.StartMenuUtility.CachedClassSelectSlideoutInfo[f11_arg1] then
		CoD.StartMenuUtility.CachedClassSelectSlideoutInfo[f11_arg1] = {
			refCount = 0,
		}
	end
	local f11_local0 = CoD.StartMenuUtility.CachedClassSelectSlideoutInfo[f11_arg1]
	local f11_local1 = Engine[0x4DF5CFBC1771947](f11_arg1)
	local f11_local2 = f11_local1.StartMenu_Main:create("ShowClassSelect")
	f11_local2:set(false)
	f11_local2 = f11_local1.StartMenu_Main:create("clear_transition")
	f11_local2:set(false)
	if not f11_local0.menu then
		f11_local0.menu = CoD.Menu.safeCreateMenu("ClassSelectSlideoutPopup", f11_arg1, nil)
	end
	f11_local0.refCount = f11_local0.refCount + 1
	f11_arg0.ClassSelectPopup = f11_local0.menu
	f11_arg0.ClassSelectPopup.m_disableAllButtonActions = true
	f11_arg0._addedClassSelectPopup = false
	f11_arg0.ClassSelectPopup.ignoreCursor = true
	f11_arg0.ClassSelectPopup:menuOpened(f11_arg1, f11_arg0.ClassSelectPopup)
	LUI.OverrideFunction_CallOriginalSecond(f11_arg0, "close", function(element)
		f11_local0.refCount = f11_local0.refCount - 1
		if f11_local0.refCount == 0 then
			f11_local0.menu = nil
			f11_arg0.ClassSelectPopup:close()
		else
			if f11_local1.StartMenu_Main.ShowClassSelect:get() then
				CoD.StartMenuUtility.HideClassSelectSlideout(f11_arg0.ClassSelectPopup, f11_arg1)
			end
			if f11_arg0._addedClassSelectPopup then
				f11_arg0:removeElement(f11_arg0.ClassSelectPopup)
				f11_arg0._addedClassSelectPopup = false
			end
		end
		f11_arg0.ClassSelectPopup = nil
	end)
end
CoD.StartMenuUtility.ShowClassSelectSlideout = function(f13_arg0, f13_arg1)
	if not f13_arg0._addedClassSelectPopup then
		f13_arg0._addedClassSelectPopup = true
		f13_arg0.ClassSelectPopup:setPriority(1000)
		f13_arg0:addElement(f13_arg0.ClassSelectPopup)
	end
	local f13_local0 = Engine[0x4DF5CFBC1771947](f13_arg1)
	if f13_arg0.ClassSelectPopup then
		CoD.Menu.SetAsPriority(f13_arg0.ClassSelectPopup, f13_arg1)
		f13_arg0.ClassSelectPopup.m_disableAllButtonActions = nil
		f13_arg0.ClassSelectPopup.ignoreCursor = false
	end
	f13_local0.StartMenu_Main.ShowClassSelect:set(true)
end
CoD.StartMenuUtility.HideClassSelectSlideout = function(f14_arg0, f14_arg1)
	local f14_local0 = Engine[0x4DF5CFBC1771947](f14_arg1)
	f14_arg0.m_disableAllButtonActions = true
	CoD.Menu.SetAsNotPriority(f14_arg0, f14_arg1)
	f14_arg0.ignoreCursor = true
	f14_local0.StartMenu_Main.ShowClassSelect:set(false)
end
CoD.StartMenuUtility.CanChangeWZStatsFilter = function(f15_arg0, f15_arg1, f15_arg2)
	if InFrontend() then
		return f15_arg1.framedWidget and f15_local0 and f15_arg1.framedWidget.isWZBarracks
	else
		return false
	end
end
CoD.StartMenuUtility.IsClassSelectSlideoutOpen = function(f16_arg0)
	local f16_local0 = Engine[0x4DF5CFBC1771947](f16_arg0)
	local f16_local1
	if not CoD.isFrontend then
		local f16_local2 = f16_local0
		f16_local1 = f16_local0.StartMenu_Main
		if f16_local1 then
			f16_local1 = f16_local0.StartMenu_Main.ShowClassSelect
			if f16_local1 then
				f16_local1 = f16_local0.StartMenu_Main.ShowClassSelect:get()
			end
		end
	else
		f16_local1 = false
	end
	return f16_local1
end
DataSources.StartMenuTabs = ListHelper_SetupDataSource("StartMenuTabs", function(f17_arg0, f17_arg1)
	local f17_local0 = {}
	local f17_local1 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	local f17_local2 = Engine[0x4DF5CFBC1771947](f17_arg0)
	if Engine[0xA55C3ACD0D2BCF0]() then
		table.insert(f17_local0, {
			models = {
				name = Engine[0xF9F1239CFD921FE](0x4C78B93031D0F44),
				tabWidget = "CoD.StartMenu_Theater",
			},
			properties = {
				tabId = "theater",
			},
		})
	elseif Engine[0x7B48C1ABFF0F764]() then
		if Engine[0x8EF5BEFA0AE50FE]() then
			table.insert(f17_local0, {
				models = {
					name = SessionModeToUnlocalizedSessionModeCaps(Engine[0x3EAC408F958FF05]()),
					tabWidget = "CoD.StartMenu_GameOptions_ZM",
				},
				properties = {
					tabId = "gameOptions",
				},
			})
			if CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and IsPublicOnlineGame() then
				table.insert(f17_local0, {
					models = {
						name = 0x616EBD2B8F67E64,
						tabWidget = "CoD.StartMenu_Contracts",
					},
					properties = {
						tabId = "contracts",
					},
				})
			end
		else
			if CoD.isWarzone then
				table.insert(f17_local0, {
					models = {
						name = 0x315E0B90BD1F6DD,
						tabWidget = "CoD.StartMenu_WZTeamScoreboard",
					},
					properties = {
						tabId = "teamScoreboard",
					},
				})
				local f17_local3 = f17_local2.deadSpectator.playerIndex
				local f17_local4
				if f17_local3:get() == Engine[0x761955642304848](f17_arg0) or f17_local3:get() == -1 then
					f17_local4 = false
				else
					f17_local4 = true
				end
				f17_arg1._isPlayerSpectating = f17_local4
				if not f17_arg1._isPlayerSpectating then
					f17_local4 = Engine[0x4DF5CFBC1771947](f17_arg0)
					if f17_local4.hudItems.playerOnInfectedPlatoon:get() == 0 then
						table.insert(f17_local0, {
							models = {
								name = 0x1346019482BDC3C,
								tabWidget = "CoD.StartMenu_Inventory",
							},
							properties = {
								tabId = "inventory",
								selectIndex = true,
							},
						})
					end
				end
				if CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and IsPublicOnlineGame() then
					table.insert(f17_local0, {
						models = {
							name = 0x616EBD2B8F67E64,
							tabWidget = "CoD.StartMenu_Contracts",
						},
						properties = {
							tabId = "contracts",
						},
					})
				end
			elseif CoD.isCampaign then
				table.insert(f17_local0, {
					models = {
						name = SessionModeToUnlocalizedSessionModeCaps(Engine[0x3EAC408F958FF05]()),
						tabWidget = "CoD.StartMenu_GameOptions_ZM",
					},
					properties = {
						tabId = "gameOptions",
					},
				})
			elseif IsGameTypeCombatTraining() then
				table.insert(f17_local0, {
					models = {
						name = 0x8B0D8B4A861BBC5,
						tabWidget = "CoD.StartMenu_ChangeSpecialist_CT",
					},
					properties = {
						tabId = "changeSpecialist",
					},
				})
			elseif not CoD.CodCasterUtility.IsCodCasterOrAssigned(f17_arg0) then
				local f17_local3 = Engine[0x4DF5CFBC1771947](f17_arg0)
				if f17_local3.PositionDraft.stage:get() ~= CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_DRAFT then
					table.insert(f17_local0, {
						models = {
							name = 0x8B0D8B4A861BBC5,
							tabWidget = "CoD.StartMenu_ChangeSpecialist",
						},
						properties = {
							tabId = "changeSpecialist",
						},
					})
				end
				if CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and IsPublicOnlineGame() then
					table.insert(f17_local0, {
						models = {
							name = 0x616EBD2B8F67E64,
							tabWidget = "CoD.StartMenu_Contracts",
						},
						properties = {
							tabId = "contracts",
						},
					})
				end
			end
			if Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x95910ACF90F64AD]) == false and Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F]) == false and (not CoD.CodCasterUtility.IsCodCasterOrAssigned(f17_arg0) or Engine[0x22EAAB59AA27E9B]("allow_shoutcaster_team_switch") == 1) and not Engine[0xDD333420C49E6D0](f17_arg0, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]) and not Engine[0xDD333420C49E6D0](f17_arg0, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]) and not Engine[0xDD333420C49E6D0](f17_arg0, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) and CoD.IsTeamChangeAllowed(f17_arg0) then
				table.insert(f17_local0, {
					models = {
						name = 0xE3B1996EF83F7ED,
						tabWidget = "CoD.StartMenu_ChangeTeam",
					},
					properties = {
						tabId = "changeTeam",
					},
				})
			end
		end
	elseif not LuaUtils.OfflineOnlyDemo() and not IsPlayerAGuest(f17_arg0) then
		local f17_local4 = LobbyData.GetCurrentMenuTarget()
		local f17_local5 = f17_local4[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING)
		local f17_local6 = DataSources.StartMenuBreadcrumbs.getModel(f17_arg0)
		DataSources.StartMenuBreadcrumbs.recreateStartTabBreadcrumbModelsIfNeeded(f17_arg0, f17_local1, f17_local6)
		if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[0xCB675CA7856DA25]()) and f17_local1 ~= Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] and not f17_local5 then
			local f17_local7 = "CoD.StartMenu_Barracks"
			if f17_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
				f17_local7 = "CoD.StartMenu_Barracks_ZM"
			elseif f17_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
				f17_local7 = "CoD.StartMenu_Barracks_WZ"
			elseif IsArenaMode() then
				f17_local7 = "CoD.StartMenu_Barracks_WL"
			end
			if not IsCustomLobby() then
				table.insert(f17_local0, {
					models = {
						name = 0x10B1AA71AB55844,
						tabWidget = f17_local7,
					},
					properties = {
						tabId = "barracks",
					},
				})
			end
		end
		if not CoD.DirectorUtility.DisableForCurrentMilestone(f17_arg0) or Engine[0xCB675CA7856DA25]() then
			if not IsLobbyNetworkModeLAN() and (not IsCustomLobby() or f17_local5) then
				if f17_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
					if f17_local5 then
						table.insert(f17_local0, {
							models = {
								name = 0xE66423FDAAC9FBF,
								tabWidget = "CoD.Challenges_MP_Stickerbook_CombatTraining",
							},
							properties = {
								tabId = "challenges",
							},
						})
					else
						table.insert(f17_local0, {
							models = {
								name = 0xE66423FDAAC9FBF,
								tabWidget = "CoD.Challenges_MP_Summary",
							},
							properties = {
								tabId = "challenges",
							},
						})
					end
				elseif f17_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
					table.insert(f17_local0, {
						models = {
							name = 0xE66423FDAAC9FBF,
							tabWidget = "CoD.Challenges_ZM_Summary",
						},
						properties = {
							tabId = "challenges",
						},
					})
				elseif f17_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
					table.insert(f17_local0, {
						models = {
							name = 0xE66423FDAAC9FBF,
							tabWidget = "CoD.ChallengesWZSummary",
						},
						properties = {
							tabId = "challenges",
						},
					})
				else
					table.insert(f17_local0, {
						models = {
							name = 0xE66423FDAAC9FBF,
							tabWidget = "CoD.ChallengesGlobalStickerbook",
						},
						properties = {
							tabId = "challenges",
						},
					})
				end
			end
			if not f17_local5 then
				table.insert(f17_local0, {
					models = {
						name = 0xF635C8E33C499F,
						tabWidget = "CoD.StartMenu_Identity",
						breadcrumb = f17_local6.identity,
					},
					properties = {
						tabId = "identity",
					},
				})
			end
		end
	end
	if IsGameTypeDOA() and Engine[0x7B48C1ABFF0F764]() then
		local f17_local3 = table.insert
		local f17_local4 = f17_local0
		local f17_local5 = {
			models = {
				name = 0xCD4D3B3B862F8C1,
				tabWidget = "CoD.StartMenu_Options_DOA",
			},
		}
		local f17_local6 = {
			tabId = "options",
		}
		local f17_local7 = Dvar[0xE017690F8837DD6]:get()
		if f17_local7 then
			f17_local7 = not Engine[0x7B48C1ABFF0F764]()
		end
		f17_local6.selectIndex = f17_local7
		f17_local5.properties = f17_local6
		f17_local3(f17_local4, f17_local5)
	elseif not CoD.isPC then
		local f17_local3 = table.insert
		local f17_local4 = f17_local0
		local f17_local5 = {
			models = {
				name = 0xCD4D3B3B862F8C1,
				tabWidget = "CoD.StartMenu_Options",
			},
		}
		local f17_local6 = {
			tabId = "options",
		}
		local f17_local7 = Dvar[0xF52444CC548D39F]:get()
		if f17_local7 then
			f17_local7 = not Engine[0x7B48C1ABFF0F764]()
		end
		f17_local6.selectIndex = f17_local7
		f17_local5.properties = f17_local6
		f17_local3(f17_local4, f17_local5)
	end
	local f17_local3 = false
	for f17_local7, f17_local8 in ipairs(f17_local0) do
		if f17_local8.properties and f17_local8.properties.selectIndex then
			f17_local3 = true
			break
		end
	end
	if not f17_local3 and #f17_local0 > 0 then
		if not f17_local0[1].properties then
			tablList[1].properties = {}
		end
		f17_local0[1].properties.selectIndex = true
	end
	if not f17_arg1._hasSubscriptions then
		f17_arg1._hasSubscriptions = true
		if Engine[0x7B48C1ABFF0F764]() and CoD.isMultiplayer then
			f17_local4 = f17_local2.PositionDraft.stage
			f17_arg1:subscribeToModel(f17_local4, function()
				local f18_local0 = f17_local4:get() == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_DRAFT
				if f17_arg1._isPositionDraftStageDraft ~= f18_local0 then
					f17_arg1._isPositionDraftStageDraft = f18_local0
					f17_arg1:updateDataSource()
				end
			end, false)
		end
		if Engine[0x7B48C1ABFF0F764]() and CoD.isWarzone then
			f17_local4 = f17_local2.deadSpectator.playerIndex
			f17_arg1:subscribeToModel(f17_local4, function()
				local f19_local0
				if f17_local4:get() == Engine[0x761955642304848](f17_arg0) or f17_local4:get() == -1 then
					f19_local0 = false
				else
					f19_local0 = true
				end
				if f17_arg1._isPlayerSpectating ~= f19_local0 then
					f17_arg1:updateDataSource()
				end
			end)
		end
	end
	return f17_local0
end, true)
DataSources.WZTrialUpsellOptions = ListHelper_SetupDataSource("WZTrialUpsellOptions", function(f20_arg0)
	local f20_local0 = {}
	table.insert(f20_local0, {
		models = {
			displayText = 0x624939A0A9E40C3,
		},
		properties = {
			action = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
				local f21_local0 = f21_arg4.occludedMenu
				GoBack(f21_arg0, f21_arg2)
				if f21_local0 then
					OpenStore(f21_arg0, f21_arg1, f21_arg2, f21_arg4.menuName, f21_local0)
				end
			end,
			actionParam = true,
		},
	})
	return f20_local0
end, true)
CoD.StartMenuUtility.GetArenaQuitPenaltyText = function(f22_arg0, f22_arg1)
	local f22_local0 = CoD.TeamUtility.GetTeamCount(CoD.TeamUtility.GetTeamID(f22_arg0))
	local f22_local1 = Engine[0xE00B2F29271C60B](0xEF165671949ADD6)
	if f22_local1 then
		if f22_local1[0xA1ACED8DDF5F039] < f22_local0 then
			return tostring(-CoD.StartMenuUtility.GetArenaQuitPenalty(f22_local1, true))
		else
			return tostring(-CoD.StartMenuUtility.GetArenaQuitPenalty(f22_local1, false))
		end
	else
		return "0"
	end
end
CoD.StartMenuUtility.GetArenaQuitPenalty = function(f23_arg0, f23_arg1)
	local f23_local0 = 0
	if f23_arg0 then
		f23_local0 = f23_arg0.losepointstreak[1][0x3FEAB3544C345B1]
		if f23_arg1 then
			f23_local0 = f23_local0 + f23_arg0[0xA210A5E11BA587C]
		end
	end
	return f23_local0
end
CoD.StartMenuUtility.GetArenaQuitDeservesExtraPenalty = function(f24_arg0)
	if LuaUtils.IsArenaPublicGame() then
		local f24_local0 = CoD.TeamUtility.GetTeamCount(CoD.TeamUtility.GetTeamID(f24_arg0))
		local f24_local1 = Engine[0xE00B2F29271C60B](0xEF165671949ADD6)
		if f24_local1 then
			return f24_local1[0xA1ACED8DDF5F039] < f24_local0
		end
	end
	return false
end
CoD.StartMenuUtility.GetArenaQuitPopupDesc = function(f25_arg0)
	local f25_local0 = Engine[0xE00B2F29271C60B](0xEF165671949ADD6)
	if f25_local0 then
		if CoD.StartMenuUtility.GetArenaQuitDeservesExtraPenalty(f25_arg0) then
			return Engine[0xF9F1239CFD921FE](0xBB9A12E59003F27, f25_local0[0xA1ACED8DDF5F039] + 1, CoD.StartMenuUtility.GetArenaQuitPenalty(f25_local0, true))
		else
			return Engine[0xF9F1239CFD921FE](0x2F64488102F358D, f25_local0[0xA1ACED8DDF5F039], CoD.StartMenuUtility.GetArenaQuitPenalty(f25_local0, false))
		end
	else
		return Engine[0xF9F1239CFD921FE](0x896B29D6A289A61)
	end
end
CoD.StartMenuUtility.QuitGameWarningPrompt = function(f26_arg0, f26_arg1)
	CoD.OverlayUtility.AddAutoDetectOverlay("QuitWarningPopup", {
		title = function()
			local f27_local0 = 0xD6D98060CE88B87
			if not CoD.isOnlineGame() then
				f27_local0 = 0x954494EB4C452D3
			end
			return Engine[0xF9F1239CFD921FE](f27_local0)
		end,
		description = function(f28_arg0)
			local f28_local0 = 0x0
			if Engine[0x32ABAFDCA93FDF9]() then
				if LuaUtils.IsArenaPublicGame() then
					return CoD.StartMenuUtility.GetArenaQuitPopupDesc(f26_arg0)
				elseif CoD.isPublicOnlineGame() then
					f28_local0 = 0xFC9034400BFB613
				end
			elseif Engine[0x56B4618D857143D]() and CoD.isOnlineGame() then
				f28_local0 = 0xFDE0D4400D2231B
			end
			return Engine[0xF9F1239CFD921FE](f28_local0)
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		getGoBackFn = function()
			return function(f30_arg0, f30_arg1)
				QuitGame_MP(f30_arg0, f30_arg0, f30_arg1, nil, GoBack(f30_arg0, f30_arg1))
			end
		end,
		frameWidget = function()
			if LuaUtils.IsArenaPublicGame() then
				return "CoD.systemOverlay_QuitLeaguePlay"
			else
				return nil
			end
		end,
		options = function(f32_arg0, f32_arg1)
			local f32_local0 = {}
			table.insert(f32_local0, {
				action = GoBack,
				text = 0xC2E92C54C2BE289,
				isCancelOption = true,
			})
			local f32_local1 = 0xAD8B52FCDEF75D6
			if not CoD.isOnlineGame() then
				f32_local1 = 0x954494EB4C452D3
			end
			table.insert(f32_local0, {
				action = CoD.OverlayUtility.Overlays.QuitWarningPopup.getGoBackFn(),
				text = f32_local1,
			})
			return f32_local0
		end,
	})
	CoD.OverlayUtility.CreateOverlay(f26_arg0, f26_arg1, "QuitWarningPopup")
end
CoD.StartMenuUtility.QuitGameWZ = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4)
	StartMenuGoBack(f33_arg4, f33_arg2)
	local f33_local0 = 0
	local f33_local1 = Engine[0x370E918BE7B2017]() - 1
	for f33_local2 = f33_local0, f33_local1, 1 do
		if Engine[0xF285055A1A895A1](f33_local2) then
			CoDShared.QuitGame(f33_local2)
		end
	end
end
