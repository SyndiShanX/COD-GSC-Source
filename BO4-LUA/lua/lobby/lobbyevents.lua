require("x64:53e8db3768fb02a")
require("x64:4b27017ec234a36")
require("x64:b56af127bf10bec")
Lobby.Events = {}
local f0_local0 = function() end
Lobby.Events.OnInit = {
	Lobby.ProcessQueue.Init,
	Lobby.TeamSelection.Init,
	LobbyData.InitLobbyNav,
	Lobby.Platform.OnInit,
	Lobby.Debug.OnInit,
	Lobby.Anticheat.OnInit,
	Lobby.MatchmakingAsync.Init,
	Lobby.Clans.OnInit,
}
Lobby.Events.OnUILoad = {
	Lobby.Stats.OnUILoad,
	Lobby.Debug.OnUILoad,
	Lobby.MapVote.Init,
	LobbyVM.OnUILoad,
}
Lobby.Events.OnSessionStart = {
	Lobby.MapVote.OnSessionStart,
	Lobby.PartyPrivacy.OnSessionStart,
	Lobby.Theater.OnSessionStart,
	Lobby.Timer.OnSessionStart,
	Lobby.TeamSelection.OnSessionStart,
	Lobby.Platform.OnSessionStart,
	Lobby.Debug.OnSessionStart,
}
Lobby.Events.OnSessionEnd = {
	Lobby.Hopper.OnSessionEnd,
	Lobby.TeamSelection.OnSessionEnd,
	Lobby.Theater.OnSessionEnd,
	Lobby.Timer.OnSessionEnd,
	Lobby.MapVote.OnSessionEnd,
	Lobby.Platform.OnSessionEnd,
	Lobby.Debug.OnSessionEnd,
}
Lobby.Events.OnClientAdded = {
	LobbyVM.OnClientAdded,
	Lobby.MatchmakingAsync.OnClientAdded,
	Lobby.CharacterSelection.OnClientAdded,
}
Lobby.Events.OnClientRemoved = {
	LobbyVM.OnClientRemoved,
	Lobby.MatchmakingAsync.OnClientRemoved,
}
Lobby.Events.OnMatchStart = {
	Lobby.MatchmakingAsync.OnMatchStart,
	Lobby.Timer.OnMatchStart,
	Lobby.Stats.OnMatchStart,
	Lobby.Matchmaking.OnMatchStart,
	Lobby.Platform.OnMatchStart,
	Lobby.Debug.OnMatchStart,
	Lobby.RecentPlayers.OnMatchStart,
	function(f2_arg0)
		Engine[@"allowvoicechatforall"](Enum[@"lobbytype"][@"lobby_type_game"])
	end,
	LuaUtils.CycleContracts,
	LuaUtils.UI_ClearErrorMessageDialog,
	LuaUtils.UpdateAllCallings,
}
Lobby.Events.OnWarzoneMatchStart = {
	Lobby.RecentPlayers.OnWarzoneMatchStart,
	Lobby.Stats.OnWarzoneMatchStart,
}
Lobby.Events.OnMatchEnd = {
	LobbyVM.OnMatchEnd,
}
Lobby.Events.OnMatchLaunchClient = {
	Lobby.Stats.OnMatchLaunchClient,
	function(f3_arg0)
		Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_5ACF4E8AA288B3A5", {
			[@"lobby_module"] = f3_arg0.lobbyModule,
			[@"lobby_type"] = f3_arg0.lobbyType,
			[@"lobby_mode"] = f3_arg0.lobbyMode,
		})
	end,
}
Lobby.Events.OnMatchRecordStart = {
	function(f4_arg0)
		Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_374FC8134F6D21DF", {
			[@"match_id"] = f4_arg0.matchId,
		})
	end,
}
Lobby.Events.OnJoinComplete = {
	function(f5_arg0)
		if not Engine[@"isdedicatedserver"]() then
			local f5_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hostGamertag"), Engine[@"getlobbyhostgamertag"](f5_local0))
			Engine[@"luivm_event"]("lobby_leader_activity_changed", {
				lobbyType = f5_local0,
				activity = Engine[@"getleaderactivity"](),
			})
		end
	end,
	Lobby.Join.OnJoinComplete,
	Lobby.Matchmaking.OnJoinComplete,
	Lobby.MatchmakingAsync.OnJoinComplete,
	Lobby.Debug.OnJoinComplete,
}
Lobby.Events.OnGametypeSettingsChange = {
	Lobby.TeamSelection.OnGametypeSettingsChange,
	function(f6_arg0)
		LuaUtils.ForceLobbyButtonUpdate()
	end,
	Lobby.PartyPrivacy.OnGametypeSettingsChange,
}
Lobby.Events.OnSetGametype = {
	Lobby.CharacterSelection.OnSetGametype,
}
Lobby.Events.OnPartyPrivacyChange = {}
Lobby.Events.OnErrorShutdown = {
	LobbyVM.OnErrorShutdown,
}
Lobby.Events.OnKVSFlush = {
	LobbyVM.LogGlobalData,
}
Lobby.Events.OnPreExecFFOTD = {
	LobbyVM.OnPreExecFFOTD,
	Lobby.MatchmakingAsync.OnPreExecFFOTD,
}
Lobby.Events.OnPostExecFFOTD = {
	LobbyVM.LogGlobalData,
	Lobby.Platform.OnPostExecFFOTD,
	Lobby.MatchmakingAsync.OnPostExecFFOTD,
	Lobby.ProcessNavigate.OnPostExecFFOTD,
}
Lobby.Events.OnUpdateLobbyStatusInfo = {
	Lobby.Timer.UpdateLobbyStatusInfo,
	Lobby.Pregame.UpdateLobbyStatusInfo,
	Lobby.MatchmakingAsync.ClientSearchStatusInfo,
}
Lobby.Events.OnLobbyClientPromoteToHost = {
	LobbyVM.OnLobbyClientPromoteToHost,
}
Lobby.Events.OnLobbyMatchmakingStart = {
	LobbyVM.OnLobbyAsyncMatchmakerStart,
}
Lobby.Events.OnRunTest = {
	LobbyVM.TestChangeWhereIAm,
}
Lobby.Events.OnChangeSigninState = {
	LobbyVM.OnChangeSigninState,
	Lobby.MatchmakingAsync.OnChangeSigninState,
	Lobby.Clans.OnChangeSigninState,
}
Lobby.Events.OnPrivateLobbyServerDataUpdate = {
	LobbyVM.OnPrivateLobbyServerDataUpdate,
	Lobby.CharacterSelection.OnPrivateLobbyServerDataUpdate,
}
Lobby.Events.OnGameLobbyGameServerDataUpdate = {
	LobbyVM.OnGameLobbyGameServerDataUpdate,
	Lobby.CharacterSelection.OnGameLobbyGameServerDataUpdate,
}
Lobby.Events.OnChangePlaylist = {
	LobbyVM.OnChangePlaylist,
}
Lobby.Events.OnClientSplitscreenSignin = {
	Lobby.MatchmakingAsync.OnClientSplitscreenSignin,
}
Lobby.Events.eventHandlers = {}
Lobby.Events.eventHandlers.OnInit = Lobby.Events.OnInit
Lobby.Events.eventHandlers.OnUILoad = Lobby.Events.OnUILoad
Lobby.Events.eventHandlers.OnPump = LobbyVM.OnPump
Lobby.Events.eventHandlers.OnPreExecFFOTD = Lobby.Events.OnPreExecFFOTD
Lobby.Events.eventHandlers.OnPostExecFFOTD = Lobby.Events.OnPostExecFFOTD
Lobby.Events.eventHandlers.OnSessionStart = Lobby.Events.OnSessionStart
Lobby.Events.eventHandlers.OnSessionEnd = Lobby.Events.OnSessionEnd
Lobby.Events.eventHandlers.OnMatchStart = Lobby.Events.OnMatchStart
Lobby.Events.eventHandlers.OnWarzoneMatchStart = Lobby.Events.OnWarzoneMatchStart
Lobby.Events.eventHandlers.OnMatchEnd = Lobby.Events.OnMatchEnd
Lobby.Events.eventHandlers.OnClientAdded = Lobby.Events.OnClientAdded
Lobby.Events.eventHandlers.OnMutableClientInfoChanged = f0_local0
Lobby.Events.eventHandlers.OnPreClientRemoved = f0_local0
Lobby.Events.eventHandlers.OnClientRemoved = Lobby.Events.OnClientRemoved
Lobby.Events.eventHandlers.OnHostLaunch = Lobby.Launch.OnHostLaunch
Lobby.Events.eventHandlers.OnClientLaunch = Lobby.Launch.OnClientLaunch
Lobby.Events.eventHandlers.OnMessageReceived = LobbyVM.OnMessageReceived
Lobby.Events.eventHandlers.OnJoin = Lobby.Join.OnJoin
Lobby.Events.eventHandlers.OnJoinSystemlink = Lobby.Join.OnJoinSystemlink
Lobby.Events.eventHandlers.OnJoinComplete = Lobby.Events.OnJoinComplete
Lobby.Events.eventHandlers.OnEnableJoins = Lobby.Join.OnEnableJoins
Lobby.Events.eventHandlers.OnInGameJoin = Lobby.Join.OnInGameJoin
Lobby.Events.eventHandlers.OnInvite = Lobby.Platform.Invite
Lobby.Events.eventHandlers.OnStorageOperationReadResult = Lobby.Anticheat.OnStorageOperationReadResult
Lobby.Events.eventHandlers.OnStorageRead = Lobby.Storage.OnStorageRead
Lobby.Events.eventHandlers.OnStorageWrite = Lobby.Storage.OnStorageWrite
Lobby.Events.eventHandlers.OnStorageWriteDispatch = Lobby.Storage.OnStorageWriteDispatch
Lobby.Events.eventHandlers.OnUpdateUI = LobbyVM.OnUpdateUI
Lobby.Events.eventHandlers.OnForceToMenu = LobbyVM.OnForceToMenu
Lobby.Events.eventHandlers.OnUILevelRunningChanged = LobbyVM.OnUILevelRunningChanged
Lobby.Events.eventHandlers.OnDisconnect = LobbyVM.OnDisconnect
Lobby.Events.eventHandlers.OnDWConnect = f0_local0
Lobby.Events.eventHandlers.OnDWDisconnect = LobbyVM.OnDWDisconnect
Lobby.Events.eventHandlers.OnComError = LobbyVM.OnComError
Lobby.Events.eventHandlers.OnErrorShutdown = Lobby.Events.OnErrorShutdown
Lobby.Events.eventHandlers.OnDevmap = LobbyVM.OnDevmap
Lobby.Events.eventHandlers.OnDevmapClient = LobbyVM.OnDevmapClient
Lobby.Events.eventHandlers.OnFeatureBan = Lobby.Anticheat.OnFeatureBan
Lobby.Events.eventHandlers.OnPlayerBanned = Lobby.Anticheat.OnPlayerBanned
Lobby.Events.eventHandlers.OnPopAnticheatMessage = Lobby.Anticheat.OnPopAnticheatMessage
Lobby.Events.eventHandlers.OnCheckPrestigeFeatureBan = Lobby.Anticheat.OnCheckPrestigeFeatureBan
Lobby.Events.eventHandlers.OnLogonTimeProhibited = Lobby.Anticheat.OnLogonTimeProhibited
Lobby.Events.eventHandlers.onLogonTimeProhibitedWarning = Lobby.Anticheat.onLogonTimeProhibitedWarning
Lobby.Events.eventHandlers.OnPlatformJoin = Lobby.Platform.OnPlatformJoin
Lobby.Events.eventHandlers.OnPlatformPlayTogether = Lobby.Platform.OnPlatformPlayTogether
Lobby.Events.eventHandlers.OnPlatformResume = Lobby.Platform.OnPlatformResume
Lobby.Events.eventHandlers.OnPlatformSessionDataUpdate = Lobby.Platform.OnPlatformSessionDataUpdate
Lobby.Events.eventHandlers.OnPlatformSessionMultiplayerSessionChanged = Lobby.Platform.OnPlatformSessionMultiplayerSessionChanged
Lobby.Events.eventHandlers.OnPlatformSessionMultiplayerSubscriptionLost = Lobby.Platform.OnPlatformSessionMultiplayerSubscriptionLost
Lobby.Events.eventHandlers.OnPlatformSuspend = Lobby.Platform.OnPlatformSuspend
Lobby.Events.eventHandlers.OnPopulateMutableClientDDLBuff = LobbyVM.OnPopulateMutableClientDDLBuff
Lobby.Events.eventHandlers.OnReceiveMutableClientDDLBuff = LobbyVM.OnReceiveMutableClientDDLBuff
Lobby.Events.eventHandlers.OnDemoEndFinished = LobbyVM.OnDemoEndFinished
Lobby.Events.eventHandlers.OnGameLobbyClientCharacterChanged = Lobby.CharacterSelection.OnGameLobbyClientCharacterChanged
Lobby.Events.eventHandlers.OnGameLobbyClientDataUpdate = LobbyVM.OnGameLobbyClientDataUpdate
Lobby.Events.eventHandlers.OnGameLobbyGameServerDataUpdate = Lobby.Events.OnGameLobbyGameServerDataUpdate
Lobby.Events.eventHandlers.OnInitilizeZMLoadoutBuffer = Lobby.Storage.OnInitilizeZMLoadoutBuffer
Lobby.Events.eventHandlers.OnLobbyClientLeftEvent = LobbyVM.OnLobbyClientLeftEvent
Lobby.Events.eventHandlers.OnLobbyClientPromoteToHost = Lobby.Events.OnLobbyClientPromoteToHost
Lobby.Events.eventHandlers.OnLobbyHostClientSelectionReceived = Lobby.CharacterSelection.OnClientSelectionReceived
Lobby.Events.eventHandlers.OnLobbyHostLeftInGameMigrateFinished = LobbyVM.OnLobbyHostLeftInGameMigrateFinished
Lobby.Events.eventHandlers.OnLobbyHostLeftMigrateFinished = LobbyVM.OnLobbyHostLeftMigrateFinished
Lobby.Events.eventHandlers.OnLobbyHostLeftNoMigration = LobbyVM.OnLobbyHostLeftNoMigration
Lobby.Events.eventHandlers.OnLobbySettings = LobbyVM.OnLobbySettings
Lobby.Events.eventHandlers.OnClientSelectionReceived = Lobby.CharacterSelection.OnClientSelectionReceived
Lobby.Events.eventHandlers.OnDediQosReady = LobbyVM.OnDediQosReady
Lobby.Events.eventHandlers.OnSetGametype = Lobby.Events.OnSetGametype
Lobby.Events.eventHandlers.OnGametypeSettingsChange = Lobby.Events.OnGametypeSettingsChange
Lobby.Events.eventHandlers.OnInitializeStats = Lobby.Storage.OnInitializeStats
Lobby.Events.eventHandlers.OnKVSFlush = Lobby.Events.OnKVSFlush
Lobby.Events.eventHandlers.OnLeaveWithParty = LobbyVM.OnLobbyLeaveWithParty
Lobby.Events.eventHandlers.OnLobbyOnlineUpdate = Lobby.Matchmaking.OnLobbyOnlineUpdate
Lobby.Events.eventHandlers.OnMatchChangeMap = LobbyVM.OnMatchChangeMap
Lobby.Events.eventHandlers.OnChangePlaylist = Lobby.Events.OnChangePlaylist
Lobby.Events.eventHandlers.OnMatchLaunchClient = Lobby.Events.OnMatchLaunchClient
Lobby.Events.eventHandlers.OnMatchRecordStart = Lobby.Events.OnMatchRecordStart
Lobby.Events.eventHandlers.OnPartyPrivacyChange = Lobby.Events.OnPartyPrivacyChange
Lobby.Events.eventHandlers.OnUpdateAdvertising = LobbyVM.OnUpdateAdvertising
Lobby.Events.eventHandlers.OnPrivateLobbyServerDataUpdate = Lobby.Events.OnPrivateLobbyServerDataUpdate
Lobby.Events.eventHandlers.OnUpdateLobbyStatusInfo = Lobby.Events.OnUpdateLobbyStatusInfo
Lobby.Events.eventHandlers.OnChangeSigninState = Lobby.Events.OnChangeSigninState
Lobby.Events.eventHandlers.OnErrorShutdown = LobbyVM.OnErrorShutdown
Lobby.Events.eventHandlers.OnGoBack = LobbyVM.OnGoBack
Lobby.Events.eventHandlers.OnGoForward = LobbyVM.OnGoForward
Lobby.Events.eventHandlers.OnLaunchDemo = Lobby.Timer.LaunchGame
Lobby.Events.eventHandlers.OnLaunchGame = Lobby.Timer.LaunchGame
Lobby.Events.eventHandlers.OnManagePartyLeave = LobbyVM.OnManagePartyLeave
Lobby.Events.eventHandlers.OnMatchmakingPriorityQuit = Lobby.MatchmakingPriority.OnMatchmakingPriorityQuit
Lobby.Events.eventHandlers.OnNetworkModeChanged = LobbyVM.OnNetworkModeChanged
Lobby.Events.eventHandlers.OnSessionModeChange = LobbyVM.OnSessionModeChange
Lobby.Events.eventHandlers.OnSessionSQJRefreshInfo = Lobby.Debug.SessionSQJRefreshInfo
Lobby.Events.eventHandlers.OnStopLobbyTimer = Lobby.Timer.HostingLobbyEnd
Lobby.Events.eventHandlers.OnSwitchTeam = Lobby.TeamSelection.SwitchTeam
Lobby.Events.eventHandlers.OnPublisherVarScript = LobbyVM.OnPublisherVarScript
Lobby.Events.eventHandlers.OnTestClientPacket = LobbyMsg.OnTestClientPacket
Lobby.Events.eventHandlers.OnAsyncMatchMakingMsg = Lobby.MatchmakingAsync.Event
Lobby.Events.eventHandlers.OnDedicatedOnlineFrame = Lobby.MatchmakingAsync.OnDedicatedOnlineFrame
Lobby.Events.eventHandlers.OnCreateDedicatedLANLobby = LobbyVM.OnCreateDedicatedLANLobby
Lobby.Events.eventHandlers.OnCreateDedicatedLobby = LobbyVM.OnCreateDedicatedLobby
Lobby.Events.eventHandlers.OnToggleAsyncMatchmaking = Lobby.MatchmakingAsync.ToggleAsyncMatchmaking
Lobby.Events.eventHandlers.OnAsyncMatchmakingStart = Lobby.Events.OnLobbyMatchmakingStart
Lobby.Events.eventHandlers.TestFFOTDFnOverride = LobbyVM.TestFFOTDFnOverride
Lobby.Events.eventHandlers.ResetClientLoadouts = LobbyVM.ResetClientLoadouts
Lobby.Events.eventHandlers.RunLobbyTest = Lobby.Events.OnRunTest
Lobby.Events.eventHandlers.ToggleLobbyOpen = Lobby.MatchmakingAsync.ToggleAdverting
Lobby.Events.eventHandlers.TriggerPlayerEncounter = Lobby.Platform.PlatformSessionDurangoS2SEncounter
Lobby.Events.eventHandlers.OnClanUIEvent = Lobby.Clans.OnClanUIEvent
Lobby.Events.eventHandlers.OnRequestDedicatedShutdown = Lobby.MatchmakingAsync.OnRequestDedicatedShutdown
Lobby.Events.eventHandlers.OpenLootDrop = Lobby.BlackMarket.OpenLootDrop
Lobby.Events.eventHandlers.OpenZombieLootDrop = Lobby.BlackMarket.OpenZombieLootDrop
Lobby.Events.eventHandlers.OnPrePrestige = Lobby.Stats.OnPrePrestige
Lobby.Events.eventHandlers.OnPostPrestige = Lobby.Stats.OnPostPrestige
Lobby.Events.eventHandlers.OnPrePrestigeFreshStart = Lobby.Stats.OnPrePrestigeFreshStart
Lobby.Events.eventHandlers.OnPrestigeFreshStartSuccess = Lobby.Stats.OnPrestigeFreshStartSuccess
Lobby.Events.eventHandlers.OnPrestigeFreshStartFailure = Lobby.Stats.OnPrestigeFreshStartFailure
Lobby.Events.eventHandlers.OnPrestigeFreshStartPreRestart = Lobby.Stats.OnPrestigeFreshStartPreRestart
Lobby.Events.eventHandlers.OnClearValidationToken = Lobby.Leaderboard.OnClearValidationToken
Lobby.Events.eventHandlers.ontwitchserveropen = Lobby.MatchmakingAsync.ToggleAdvertingTWITCHCON
Lobby.Events.eventHandlers.OnLocalClientObituary = Lobby.RecentPlayers.OnLocalClientObituary
Lobby.Events.eventHandlers.OnDedicatedBotTest = Lobby.Debug.StartDedicatedBotTest
Lobby.Events.eventHandlers.UpdatePlayerInfo = Lobby.MatchmakingAsync.UpdatePlayerInfo
Lobby.Events.eventHandlers.OnProcessLeagueAEEvent = Lobby.Arena.OnProcessLeagueAEEvent
Lobby.Events.eventHandlers.OnLobbyAsyncMatchmakerRedeploy = LobbyVM.OnLobbyAsyncMatchmakerRedeploy
Lobby.Events.eventHandlers.OnClientSplitscreenSignin = Lobby.Events.OnClientSplitscreenSignin
Lobby.Events.EventDispatcher = function(f7_arg0, f7_arg1)
	if Lobby.Events.eventHandlers[f7_arg0] then
		if type(Lobby.Events.eventHandlers[f7_arg0]) == "function" then
			Lobby.Events.eventHandlers[f7_arg0](f7_arg1)
			return
		elseif type(Lobby.Events.eventHandlers[f7_arg0]) == "table" then
			for f7_local3, f7_local4 in ipairs(Lobby.Events.eventHandlers[f7_arg0]) do
				f7_local4(f7_arg1)
			end
			return
		end
	end
	if not Engine[@"isshipbuild"]() then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "Lobby.Events.EventDispatcher() - invalid event: " .. f7_arg0 .. ".\n")
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "Lobby.Events.EventDispatcher() - invalid event: " .. f7_arg0 .. ".\n")
	end
end
Lobby.Events.eventReturnHandlers = {}
Lobby.Events.eventReturnHandlers.OnHostLaunch = Lobby.Launch.OnHostLaunch
Lobby.Events.eventReturnHandlers.OnClientLaunch = Lobby.Launch.OnClientLaunch
Lobby.Events.eventReturnHandlers.OnJoinPartyPrivacyCheck = Lobby.PartyPrivacy.OnJoinPartyPrivacyCheck
Lobby.Events.eventReturnHandlers.OnCanFitLobbys = Lobby.TeamSelection.OnCanFitLobbys
Lobby.Events.eventReturnHandlers.OnCanBroadcastHostInfo = LobbyVM.OnCanBroadcastHostInfo
Lobby.Events.eventReturnHandlers.OnJoinableCheck = Lobby.Join.OnJoinableCheck
Lobby.Events.eventReturnHandlers.OnCanLobbyCanMigrate = LobbyVM.OnCanLobbyCanMigrate
Lobby.Events.eventReturnHandlers.OnLobbyLocalClientLeave = LobbyVM.OnLobbyLocalClientLeave
Lobby.Events.eventReturnHandlers.OnIsFeatureBanned = LobbyVM.OnIsFeatureBanned
Lobby.Events.eventReturnHandlers.OnIsPermaBanned = Lobby.Anticheat.OnIsPermaBanned
Lobby.Events.eventReturnHandlers.OnGetAnticheatReputation = Lobby.Anticheat.OnGetAnticheatReputation
Lobby.Events.eventReturnHandlers.OnPushAnticheatMessageToUI = Lobby.Anticheat.OnPushAnticheatMessageToUI
Lobby.Events.eventReturnHandlers.OnEmblemsGenerateForceDefault = Lobby.UGC.EmblemsGenerateForceDefault
Lobby.Events.eventReturnHandlers.OnBuyCrate = LobbyVM.OnBuyCrate
Lobby.Events.eventReturnHandlers.OnSpendVials = LobbyVM.OnSpendVials
Lobby.Events.eventReturnHandlers.OnHopperClientJoin = Lobby.Hopper.OnClientJoin
Lobby.Events.eventReturnHandlers.OnHopperIsParked = Lobby.Hopper.OnIsParked
Lobby.Events.eventReturnHandlers.OnLeaderboardCalculateLBColValue = Lobby.Leaderboard.OnCalculateLBColValue
Lobby.Events.eventReturnHandlers.OnShouldWriteLeaderboard = Lobby.Leaderboard.OnShouldWriteLeaderboard
Lobby.Events.eventReturnHandlers.OnShouldWriteValidationToken = Lobby.Leaderboard.OnShouldWriteValidationToken
Lobby.Events.eventReturnHandlers.OnLobbyMessage = LobbyMsg.OnLobbyMessage
Lobby.Events.eventReturnHandlers.OnAsyncMatchmaking = Lobby.MatchmakingAsync.OnAsyncMatchmaking
Lobby.Events.eventReturnHandlers.OnGetMapName = LobbyVM.OnGetMapName
Lobby.Events.eventReturnHandlers.OnCanFitPlayers = LobbyVM.OnCanFitPlayers
Lobby.Events.eventReturnHandlers.OnGetLobbyID = Lobby.MatchmakingAsync.OnGetLobbyID
Lobby.Events.eventReturnHandlers.OnGetAdvertStatus = Lobby.MatchmakingAsync.OnGetAdvertStatus
Lobby.Events.eventReturnHandlers.OnSettingDDLConversionInt = Lobby.Storage.OnSettingDDLConversionInt
Lobby.Events.eventReturnHandlers.OnSettingDDLConversionFloat = Lobby.Storage.OnSettingDDLConversionFloat
Lobby.Events.eventReturnHandlers.OnRequestGroupInfo = Lobby.Clans.OnRequestGroupInfo
Lobby.Events.ReturnEventDispatcher = function(f8_arg0, f8_arg1)
	if Lobby.Events.eventReturnHandlers[f8_arg0] then
		return Lobby.Events.eventReturnHandlers[f8_arg0](f8_arg1)
	elseif not Engine[@"isshipbuild"]() then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "Lobby.Events.ReturnEventDispatcher() - invalid event: " .. f8_arg0 .. ".\n")
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "Lobby.Events.ReturnEventDispatcher() - invalid event: " .. f8_arg0 .. ".\n")
	end
end
