
CoD.WarUtility = {}
CoD.WarUtility.MissionInfo = {
	mission_koth = {
		header = 0xA4AD68698439FF7,
		icon = "war_mission_koth_icon"
	},
	mission_ctf = {
		header = 0xC58388518FEFF2E,
		icon = "war_mission_ctf_icon"
	},
	mission_escort = {
		header = 0x7AD430E2CB8B585,
		icon = "war_mission_escort_icon"
	}
}
CoD.WarUtility.InitializeWarDataSource = function ( f1_arg0 )
	local f1_local0 = true
	if not DataSources.WarData.subscriptionElement then
		DataSources.WarData.subscriptionElement = {}
	end
	if not DataSources.WarData.subscriptionElement[f1_arg0] then
		DataSources.WarData.subscriptionElement[f1_arg0] = LUI.UIElement.new()
		f1_local0 = false
	end
	if not DataSources.WarData.WarInfo then
		DataSources.WarData.WarInfo = {
			completionBonus = {},
			zoneInfo = {},
			tierInfo = {}
		}
		local f1_local1 = Engine[0xE00B2F29271C60B]( 0x3B8FE87B3F2F84E )
		for f1_local2 = 1, f1_local1[0x869549C59B6EDEB], 1 do
			DataSources.WarData.WarInfo.completionBonus[f1_local2] = {
				time = f1_local1[Engine[0xC53F8D38DF9042B]( string.format( "completionSeconds%02d", f1_local2 ) )],
				score = f1_local1[Engine[0xC53F8D38DF9042B]( string.format( "completionScore%02d", f1_local2 ) )]
			}
		end
		for f1_local2 = 1, f1_local1[0x64BD41DBBCBF9D0], 1 do
			DataSources.WarData.WarInfo.tierInfo[f1_local2] = {
				icon = f1_local1[0x61AD72F0B9A1E3D .. f1_local2],
				name = f1_local1[0x4BCADBA8E631B86 .. f1_local2]
			}
		end
		for f1_local2 = 1, f1_local1[0x433BE2DB6264E7E], 1 do
			DataSources.WarData.WarInfo.zoneInfo[f1_local2] = {
				tiers = {}
			}
			for f1_local5 = 1, f1_local1[0x64BD41DBBCBF9D0], 1 do
				DataSources.WarData.WarInfo.zoneInfo[f1_local2].tiers[f1_local5] = {
					time = f1_local1[0xBDAF86117F49DE7 .. f1_local2 .. "TimeLimit" .. f1_local5] or 0,
					score = f1_local1[0xBDAF86117F49DE7 .. f1_local2 .. "Score" .. f1_local5] or 0
				}
			end
		end
		f1_local0 = false
	end
	if f1_local0 then
		return 
	end
	local f1_local1 = Engine[0x6F8027A8BC75673]()
	local f1_local2 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "hudItems.war" )
	local f1_local3 = {}
	local f1_local4 = f1_local2:create( "team1" )
	local f1_local8 = f1_local2:create( "team2" )
	f1_local3 = f1_local4
	f1_local4 = 3
	if f1_local1 ~= "war" then
		f1_local4 = 1
	end
	f1_local8 = nil
	if f1_local1 == "war" then
		f1_local8 = "CoD.WarScoreInfo_Notifications_ThreeStage"
	elseif f1_local1 == "control" or f1_local1 == "dom" then
		f1_local8 = "CoD.SingleScoreNotification_Waypoint"
	elseif f1_local1 == "koth" then
		f1_local8 = "CoD.HardpointObjectiveNotification"
	elseif f1_local1 == "sd" then
		f1_local8 = "CoD.SDDemObjectiveNotification"
	elseif IsObjectiveBasedGametype() then
		f1_local8 = "CoD.SingleScoreNotification"
	end
	local f1_local5 = f1_local2:create( "notificationWidget" )
	f1_local5:set( f1_local8 )
	f1_local5 = {}
	for f1_local6 = 1, f1_local4, 1 do
		table.insert( f1_local5, f1_local2:create( "zone" .. f1_local6 ) )
	end
	f1_local2:create( "attackingDeaths" )
	f1_local2:create( "forwardSpawnStatus" )
	for f1_local12, f1_local13 in pairs( {
		attackingTeam = 0,
		currentZone = 0,
		currentZoneProgress = 0,
		currentZoneStartTime = 0,
		objectiveHeldByAttackingTeam = false,
		objectiveHeldByDefendingTeam = false,
		batteryState = ""
	} ) do
		if not f1_local2[f1_local12] then
			local f1_local11 = f1_local2:create( f1_local12 )
			f1_local11:set( f1_local13 )
		end
	end
	f1_local7 = function ( f2_arg0 )
		if f2_arg0 == 0 then
			return 0
		end
		for f2_local3, f2_local4 in ipairs( DataSources.WarData.WarInfo.completionBonus ) do
			if f2_local4.time <= f2_arg0 - 1 then
				return f2_local4.score
			end
		end
		return 0
	end
	
	f1_local9 = f1_local2:create( "ticketsToBeat" )
	f1_local10 = function ()
		local f3_local0 = 0
		local f3_local1 = f1_local2.attackingTeam:get()
		if f3_local1 == 1 or f3_local1 == 2 then
			local f3_local2 = f1_local2.currentZone:get()
			if f3_local1 == 1 then
				f3_local0 = CoD.SafeGetModelValue( f1_local2, "team2.zone" .. f3_local2 ) or 0
			else
				f3_local0 = CoD.SafeGetModelValue( f1_local2, "team1.zone" .. f3_local2 ) or 0
			end
			if 0 < f3_local2 and 0 < f3_local0 then
				f3_local0 = f3_local0 - tonumber( Engine[0xDBC2AD5002B261B]( 0xA3759A7DF86C135 .. f3_local2 - 1 ) )
			end
		end
		f1_local9:set( f3_local0 )
	end
	
	for f1_local14, f1_local15 in ipairs( f1_local5 ) do
		f1_local15:create( "zoneGametype" )
		f1_local15:create( "teamObjective" )
		f1_local15:create( "progressWidget" )
		f1_local15:create( "objectiveIcon" )
		f1_local15:create( "objId" )
		if f1_local1 == "war" then
			if f1_local14 == 1 or Engine[0x22EAAB59AA27E9B]( "bg_warmode_version" ) <= 1 then
				f1_local15.zoneGametype:set( "koth" )
				f1_local15.progressWidget:set( "CoD.WarScoreInfo_Capture_ProgressBar" )
				f1_local15.objectiveIcon:set( "hud_common_core_score_waricon" )
			end
			if f1_local14 == 2 then
				f1_local15.zoneGametype:set( "infil" )
				f1_local15.progressWidget:set( "CoD.WarScoreInfo_Deliver_ProgressBar" )
				f1_local15.objectiveIcon:set( "hud_common_core_score_fuelcellicon" )
			else
				f1_local15.zoneGametype:set( "payload" )
				f1_local15.progressWidget:set( "CoD.WarScoreInfo_Escort_ProgressBar" )
				f1_local15.objectiveIcon:set( "hud_common_core_score_boticon" )
				goto basicblock_56:
			end
		end
		if f1_local1 == "control" then
			f1_local15.zoneGametype:set( "control" )
			f1_local15.progressWidget:set( "CoD.ScoreNotificationWaypoint" )
		end
		if f1_local1 == "infil" then
			f1_local15.zoneGametype:set( "infil" )
			f1_local15.progressWidget:set( "CoD.WarScoreInfo_Deliver_ProgressBar" )
		end
		if f1_local1 == "payload" then
			f1_local15.zoneGametype:set( "payload" )
			f1_local15.progressWidget:set( "CoD.WarScoreInfo_Escort_ProgressBar" )
		else
			f1_local15.zoneGametype:set( f1_local1 )
		end
	end
	f1_local12 = function ()
		local f4_local0 = "DEFEND"
		if CoD.ModelUtility.IsGlobalModelValueEqualToSelfTeam( f1_arg0, "hudItems.war.attackingTeam" ) then
			f4_local0 = "ATTACK"
		end
		for f4_local5, f4_local6 in ipairs( f1_local5 ) do
			local f4_local7 = f4_local6.zoneGametype:get()
			if not IsGametypeNewStyle() then
				f4_local6.teamObjective:set( "MPUI_" .. f4_local7 )
			end
			local f4_local4 = "CAPTURE"
			if f4_local7 == "infil" then
				f4_local4 = "DELIVER"
			elseif f4_local7 == "payload" then
				f4_local4 = "ESCORT"
			end
			f4_local6.teamObjective:set( "MPUI_WAR_" .. f4_local4 .. "_" .. f4_local0 )
		end
	end
	
	f1_local13 = function ()
		f1_local10()
		f1_local12()
	end
	
	DataSources.WarData.subscriptionElement[f1_arg0]:subscribeToModel( f1_local2.currentZone, f1_local10, false )
	DataSources.WarData.subscriptionElement[f1_arg0]:subscribeToModel( f1_local2.attackingTeam, f1_local13, true )
	DataSources.WarData.subscriptionElement[f1_arg0]:subscribeToModel( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f1_arg0 ), "factions.playerFactionTeamEnum" ), f1_local12 )
	for f1_local19, f1_local20 in ipairs( f1_local3 ) do
		local f1_local21 = function ()
			f1_local20.total:set( tonumber( f1_local20.zone1:get() or 0 ) + tonumber( f1_local20.zone2:get() or 0 ) + tonumber( f1_local20.zone3:get() or 0 ) + f1_local7( f1_local20.bonus:get() or 0 ) )
		end
		
		local f1_local22 = function ()
			f1_local20.bonusScore:set( f1_local7( f1_local20.bonus:get() or 0 ) )
		end
		
		local f1_local23 = f1_local20:create( "bonus" )
		local f1_local24 = {
			f1_local20:create( "zone1" ),
			f1_local20:create( "zone2" ),
			f1_local20:create( "zone3" ),
			f1_local23
		}
		local f1_local25 = f1_local20:create( "progress" )
		f1_local20:create( "bonusScore" )
		f1_local20:create( "tickets" )
		f1_local20:create( "total" )
		for f1_local16, f1_local17 in ipairs( f1_local24 ) do
			DataSources.WarData.subscriptionElement[f1_arg0]:subscribeToModel( f1_local17, f1_local21, false )
		end
		f1_local21()
		DataSources.WarData.subscriptionElement[f1_arg0]:subscribeToModel( f1_local23, f1_local22, true )
	end
end
DataSources.WarData = {
	getModel = function ( f8_arg0 )
		CoD.WarUtility.InitializeWarDataSource( f8_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "hudItems.war" )
	end,
	getCount = function ( f9_arg0 )
		return #f9_arg0.models
	end,
	getItem = function ( f10_arg0, f10_arg1, f10_arg2 )
		return f10_arg1.models[i]
	end
}
