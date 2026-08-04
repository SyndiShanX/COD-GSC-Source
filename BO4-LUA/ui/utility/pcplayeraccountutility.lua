CoD.PCPlayerAccountUtility = {}
CoD.PCPlayerAccountUtility.SetupPlayerDataForBarrack = function(f1_arg0, f1_arg1)
	CoD.BaseUtility.SetMenuSessionMode(f1_arg0, CoD.StartMenuUtility.GetSessionModeFromLobby())
	CoD.StartMenuUtility.SetStorageBufferForMenu(f1_arg0, f1_arg1)
end
CoD.PCPlayerAccountUtility.IsSignedIn = function(f2_arg0)
	return CoD.SafeGetModelValue(DataSources.UNOAccountInfo.getModel(f2_arg0), "bSignedIn") == true
end
DataSources.PCPlayerAccountTabs = ListHelper_SetupDataSource("PCPlayerAccountTabs", function(f3_arg0, f3_arg1)
	local f3_local0 = {}
	local f3_local1 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	if not LuaUtils.OfflineOnlyDemo() and not IsPlayerAGuest(f3_arg0) then
		local f3_local2 = LobbyData.GetCurrentMenuTarget()
		local f3_local3 = f3_local2.id == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING)
		if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[@"hash_5CB675CA7856DA25"]()) and f3_local1 ~= Enum.eModes.mode_invalid and not f3_local3 then
			local f3_local4 = "CoD.StartMenu_Barracks"
			if f3_local1 == Enum.eModes.mode_zombies then
				f3_local4 = "CoD.StartMenu_Barracks_ZM"
			elseif f3_local1 == Enum.eModes.mode_warzone then
				f3_local4 = "CoD.StartMenu_Barracks_WZ"
			elseif IsArenaMode() then
				f3_local4 = "CoD.StartMenu_Barracks_WL"
			end
			if not IsCustomLobby() then
				table.insert(f3_local0, {
					models = {
						name = "menu/tab_barracks_caps",
						tabWidget = f3_local4,
						available = true,
					},
					properties = {
						tabId = "barracks",
					},
				})
			end
		end
		if not CoD.DirectorUtility.DisableForCurrentMilestone(f3_arg0) or Engine[@"hash_5CB675CA7856DA25"]() then
			if not f3_local3 then
				table.insert(f3_local0, {
					models = {
						name = "menu/tab_identity_caps",
						tabWidget = "CoD.StartMenu_Identity",
						available = true,
					},
					properties = {
						tabId = "identity",
					},
				})
			end
			if not IsLobbyNetworkModeLAN() and (not IsCustomLobby() or f3_local3) then
				if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
					if f3_local1 == Enum.eModes.mode_multiplayer then
						if not f3_local3 then
							table.insert(f3_local0, {
								models = {
									name = "menu/tab_challenges_caps",
									tabWidget = "CoD.Challenges_MP_Summary",
									available = true,
								},
								properties = {
									tabId = "challenges",
								},
							})
						end
					elseif f3_local1 == Enum.eModes.mode_warzone then
						table.insert(f3_local0, {
							models = {
								name = "menu/tab_challenges_caps",
								tabWidget = "CoD.ChallengesWZSummary",
								available = true,
							},
							properties = {
								tabId = "challenges",
							},
						})
					end
				elseif f3_local1 == Enum.eModes.mode_multiplayer then
					if f3_local3 then
						table.insert(f3_local0, {
							models = {
								name = "menu/tab_challenges_caps",
								tabWidget = "CoD.Challenges_MP_Stickerbook_CombatTraining",
								available = true,
							},
							properties = {
								tabId = "challenges",
							},
						})
					else
						table.insert(f3_local0, {
							models = {
								name = "menu/tab_challenges_caps",
								tabWidget = "CoD.Challenges_MP_Summary",
								available = true,
							},
							properties = {
								tabId = "challenges",
							},
						})
					end
				elseif f3_local1 == Enum.eModes.mode_zombies then
					table.insert(f3_local0, {
						models = {
							name = "menu/tab_challenges_caps",
							tabWidget = "CoD.Challenges_ZM_Summary",
							available = true,
						},
						properties = {
							tabId = "challenges",
						},
					})
				elseif f3_local1 == Enum.eModes.mode_warzone then
					table.insert(f3_local0, {
						models = {
							name = "menu/tab_challenges_caps",
							tabWidget = "CoD.ChallengesWZSummary",
							available = true,
						},
						properties = {
							tabId = "challenges",
						},
					})
				else
					table.insert(f3_local0, {
						models = {
							name = "menu/tab_challenges_caps",
							tabWidget = "CoD.ChallengesGlobalStickerbook",
							available = true,
						},
						properties = {
							tabId = "challenges",
						},
					})
				end
			end
			table.insert(f3_local0, {
				models = {
					name = "menu/tab_achievements_caps",
					tabWidget = "CoD.PC_Achievements",
					available = true,
				},
				properties = {
					tabId = "achievements",
				},
			})
			table.insert(f3_local0, {
				models = {
					name = "menu/info_caps",
					tabWidget = "CoD.PC_CoDAccount",
					available = true,
				},
				properties = {
					tabId = "account",
				},
			})
		end
	end
	return f3_local0
end)
