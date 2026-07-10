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
		local f3_local3 = f3_local2[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING)
		if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[0xCB675CA7856DA25]()) and f3_local1 ~= Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] and not f3_local3 then
			local f3_local4 = "CoD.StartMenu_Barracks"
			if f3_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
				f3_local4 = "CoD.StartMenu_Barracks_ZM"
			elseif f3_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
				f3_local4 = "CoD.StartMenu_Barracks_WZ"
			elseif IsArenaMode() then
				f3_local4 = "CoD.StartMenu_Barracks_WL"
			end
			if not IsCustomLobby() then
				table.insert(f3_local0, {
					models = {
						name = 0x10B1AA71AB55844,
						tabWidget = f3_local4,
						available = true,
					},
					properties = {
						tabId = "barracks",
					},
				})
			end
		end
		if not CoD.DirectorUtility.DisableForCurrentMilestone(f3_arg0) or Engine[0xCB675CA7856DA25]() then
			if not f3_local3 then
				table.insert(f3_local0, {
					models = {
						name = 0xF635C8E33C499F,
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
					if f3_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
						if not f3_local3 then
							table.insert(f3_local0, {
								models = {
									name = 0xE66423FDAAC9FBF,
									tabWidget = "CoD.Challenges_MP_Summary",
									available = true,
								},
								properties = {
									tabId = "challenges",
								},
							})
						end
					elseif f3_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
						table.insert(f3_local0, {
							models = {
								name = 0xE66423FDAAC9FBF,
								tabWidget = "CoD.ChallengesWZSummary",
								available = true,
							},
							properties = {
								tabId = "challenges",
							},
						})
					end
				elseif f3_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
					if f3_local3 then
						table.insert(f3_local0, {
							models = {
								name = 0xE66423FDAAC9FBF,
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
								name = 0xE66423FDAAC9FBF,
								tabWidget = "CoD.Challenges_MP_Summary",
								available = true,
							},
							properties = {
								tabId = "challenges",
							},
						})
					end
				elseif f3_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
					table.insert(f3_local0, {
						models = {
							name = 0xE66423FDAAC9FBF,
							tabWidget = "CoD.Challenges_ZM_Summary",
							available = true,
						},
						properties = {
							tabId = "challenges",
						},
					})
				elseif f3_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
					table.insert(f3_local0, {
						models = {
							name = 0xE66423FDAAC9FBF,
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
							name = 0xE66423FDAAC9FBF,
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
					name = 0x2A6EA2811A2E0F1,
					tabWidget = "CoD.PC_Achievements",
					available = true,
				},
				properties = {
					tabId = "achievements",
				},
			})
			table.insert(f3_local0, {
				models = {
					name = 0x2E61B49D5A9BACD,
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
