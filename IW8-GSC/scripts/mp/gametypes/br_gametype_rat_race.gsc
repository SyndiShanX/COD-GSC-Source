
// Params 0
// Size: 0x2
function activate_laser_trap_parent()
{
    
}

// Params 0
// Size: 0x9b6
function init()
{
    if ( getdvar( "mapname" ) == "mp_wz_island" )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "movingCircle" );
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "randomizeCircleCenter" );
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "circleEarlyStart" );
        level.decoyassists = &groundz;
        scripts\mp\gametypes\br_gametypes::ref_12b11( "getFinalCircleCenter", &relic_steelballs_health_boost );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "mapCenterFinalCircle", &relic_steelballs_health_boost );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "dangerCircleTick", &dangercircletick );
    }
    else
    {
        level.deletequestobjicon = 1;
    }
    
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "dropbag" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "kioskXP" );
    level.ô∞[+†ˇÂ±íAÿˆ&“Ì¿¯(≤≈H:¢	_< = getdvarint( "scr_rat_race_heli_extraction_enabled", 1 );
    
    if ( !level.ô∞[+†ˇÂ±íAÿˆ&“Ì¿¯(≤≈H:¢	_< )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "plunderSites" );
    }
    
    if ( getdvarint( "scr_bmo_use_spawn_fix", 1 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "teamSpectate" );
    }
    
    if ( getdvarint( "scr_br_rat_race_latejoin", 1 ) != 0 )
    {
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "allowLateJoiners" );
    }
    
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "oneLife" );
    
    if ( getdvarint( "scr_bmo_useKiosks", 1 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "kiosk" );
    }
    
    if ( getdvarint( "scr_bmo_enableTabletReplace", 1 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "tabletReplace" );
    }
    
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerDropPlunderOnDeath", &playerdropplunderondeath );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerShouldRespawn", &ref_12691 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerWelcomeSplashes", &ref_126f1 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "spawnHandled", &ref_1365d );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "infilSequence", &manage_fakebody_hides );
    level.ref_13abd = getdvarint( "scr_dmz_teamPlunder", 0 );
    level.disable_super_in_turret.ref_11b5d = getdvarint( "scr_br_extract_max_extractions", 5 );
    level.disable_super_in_turret.ref_11f3b = 0;
    level.disable_super_in_turret.player_enemy_cooldown = "tie";
    level.br_prematchffa = 0;
    setdvar( "scr_br_allowLoadout", 1 );
    level.ref_13be1 = [];
    level.ref_11a32 = [];
    level.onstun = [];
    level.fuckwithgravity = 0;
    level.fuel_stability_event_init = 0;
    level.fuel_stability_event_start = 0;
    var0 = getdvarint( "scr_dmz_win_cost", 3000 );
    
    if ( var0 > 0 )
    {
        var0 *= 10;
        var0 *= 100;
        setdvar( "scr_br_scorelimit", var0 );
        scripts\mp\utility\game::registerscorelimitdvar( scripts\mp\utility\game::getgametype(), var0 );
    }
    
    setdvar( "scr_br_magcount", 3 );
    setdvar( "scr_br_loadout_option", "nothing" );
    setomnvar( "ui_br_circle_state", 4 );
    setomnvar( "ui_gulag_state", 1 );
    setomnvar( "ui_hide_redeploy_timer", 1 );
    setdvarifuninitialized( "scr_br_bank_alarm", 1 );
    level.scriptedphysicaldofenabled = getdvarint( "scr_dmz_giveLoadoutEveryTime", 1 );
    level.trackriotshield_tryreset = getdvarint( "scr_bmo_instantBleedOutSquadWipe", 1 );
    level.debug_kill_tromeo = getdvarint( "scr_bmo_bottomPercentageToAdjustEconomy", 50 );
    level.ref_13bdf = getdvarint( "scr_bmo_topPercentageToAdjustEconomy", 5 );
    level.ref_14086 = getdvarint( "scr_bmo_useMilestonePhases", 1 );
    level.ref_11be6 = getdvarint( "scr_rat_race_milestonePhase_VIPs", 0 );
    level.ref_11be5 = getdvarint( "scr_bmo_milestonePhase_LZs", 30 );
    level.ref_11be3 = getdvarint( "scr_bmo_milestonePhase_Drops", 50 );
    level.ref_11be4 = getdvarint( "scr_bmo_milestonePhase_Helis", 75 );
    level.br_checkforlaststandwipe = getdvarint( "scr_rat_race_airdrop_base_cash_amount", 2500 );
    level.br_circle_init_func = getdvarint( "scr_rat_race_airdrop_max_cash_pickup_count", 25 );
    level.spawn_default_player_spawns = getdvarint( "scr_bmo_hidePlacementUntilPercent", 10 );
    level.spawn_convoy_and_move = getdvarint( "scr_bmo_hideLeaderHashUntilPercent", 0 );
    level.ref_13366 = getdvarint( "scr_bmo_progressSplashesAndMusic", 1 );
    level.ref_12fb3 = getdvarint( "scr_bmo_secondsBeforePlacementUpdates", 60 );
    level.loadout_updateclassdefault_headlessgetweaponn = getdvarint( "scr_bmo_disable_perc_announcements", 0 );
    level.Ü©—V∞k≠∞Ëïÿ{Ì:ç≤Ö¨9≠¬'≠≤Õ,L±Y2 = getdvarint( "scr_rat_race_teammate_loot_leader_mark_enabled", 1 );
    level.íOËV[≠Ö—¨∆ˆˆ£± ∞»V…['÷±∑’sé = getdvarint( "scr_rat_race_teammate_loot_leader_mark_count", 3 );
    level.ref_11a27 = getdvarint( "scr_rat_race_loot_leader_mark_count", 6 );
    level.ref_11b62 = getdvarint( "scr_rat_race_loot_leader_mark_count", 6 );
    level.ref_11a2a = getdvarint( "scr_bmo_loot_leader_mark_size", 750 );
    level.ref_11a31 = getdvarint( "scr_dmz_loot_leader_one_per_team", 0 ) == 1;
    level.ref_11a37 = getdvarfloat( "scr_rat_race_loot_leader_update_interval", 5 );
    level.ref_11a38 = getdvarfloat( "scr_rat_race_loot_leader_update_interval_blink", 2 );
    level.ref_11a3b = getdvarint( "scr_rat_race_circle_pulse_start", 800 );
    level.ref_11a3a = getdvarint( "scr_rat_race_circle_pulse_end", 200 );
    level.ref_11a2b = getdvarint( "scr_bmo_loot_leader_mark_size_dynamic", 1 );
    level.ref_11a2d = getdvarint( "scr_bmo_loot_leader_mark_info_strong_size", 250 );
    level.ref_11a2e = getdvarint( "scr_bmo_loot_leader_mark_info_strong_value", 5000 );
    level.ref_11a2f = getdvarint( "scr_bmo_loot_leader_mark_info_weak_size", 750 );
    level.ref_11a30 = getdvarint( "scr_bmo_loot_leader_mark_info_weak_value", 2500 );
    level.ref_11a35 = getdvarint( "scr_rat_race_loot_leader_mark_random_distance_offset_min", 100 );
    level.ref_11a34 = getdvarint( "scr_rat_race_loot_leader_mark_random_distance_offset_max", 250 );
    level.onsquadeliminatedplacement = getdvarint( "scr_bmo_loot_leader_expired_enabled", 0 ) == 1;
    level.ref_11a2c = getdvarint( "scr_bmo_loot_leader_mark_top_teams", 0 );
    level.ref_127c0 = getdvarfloat( "scr_bmo_music_first", 0.3 );
    level.ref_127c2 = getdvarfloat( "scr_bmo_music_second", 0.5 );
    level.ref_127c3 = getdvarfloat( "scr_bmo_music_third", 0.75 );
    level.ref_127c1 = getdvarfloat( "scr_bmo_music_fourth", 0.9 );
    level.ref_14062 = getdvarint( "scr_dmz_useAutoRespawn", 1 );
    level.checkpoint_objective_id = getdvarint( "scr_dmz_autoRespawnWaitTime", 20 );
    level.ref_13bcd = getdvarint( "scr_dmz_tokenRespawnWaitTime", level.checkpoint_objective_id );
    level.start_persistent_turbulence = getdvarint( "scr_dmz_respawn_penalty", 0 );
    level.start_pipe_room = getdvarfloat( "scr_dmz_respawn_penalty_max", 15 );
    level.ref_12ca7 = getdvarint( "scr_bmo_respawnHeightOverride", 5000 );
    level.ref_12cb4 = getdvarint( "scr_dmz_respawn_time_disable", 0 );
    level.ref_121cc = getdvarfloat( "scr_bmo_parachuteDeployDelay", 0.5 );
    level.current_trigger = getdvarint( "scr_dmz_bonusDeathPlunder", 0 );
    level.current_volume_allies = getdvarint( "scr_dmz_bonusDeathPlunder_ot", 0 );
    level.ref_11b6c = getdvarint( "scr_bmo_maxPlunderDropOnDeath", 20000 );
    level.ref_11c40 = getdvarint( "scr_bmo_minPlunderDropOnDeath", 0 );
    level.ref_122f5 = getdvarint( "scr_bmo_percentagePlunderDrop", 80 );
    level.ref_127bc = getdvarint( "scr_bmo_plunderFXOnDropThreashold", 750 );
    level.ref_11b6b = getdvarint( "scr_bmo_maxPlunderDropInOvertime", 20000 );
    level.oic_loadouts = getdvarfloat( "scr_bmo_executionCashMultiplier", 1 );
    level.checkforcorrectinstance = getdvarint( "scr_rat_race_autoAssignFirstQuest", 0 );
    level.ref_12966 = getdvarint( "scr_rat_race_questDomDistMin", 5000 );
    level.ref_12965 = getdvarint( "scr_rat_race_questDomDistMax", 10000 );
    level.ref_12962 = getdvarint( "scr_rat_race_questAssDistMin", 2500 );
    level.ref_12961 = getdvarint( "scr_rat_race_questAssDistMax", 30000 );
    level.ref_12968 = getdvarint( "scr_rat_race_questScavDistMin", 5000 );
    level.ref_12967 = getdvarint( "scr_rat_race_questScavDistMax", 10000 );
    level.ref_1296a = getdvarint( "scr_rat_race_questScavDistMin", 5000 );
    level.ref_12969 = getdvarint( "scr_rat_race_questScavDistMax", 30000 );
    level.ref_139ea = getdvarfloat( "scr_rat_race_questTabletReplaceEveryN", 1.5 );
    level.ref_133ea = getdvarint( "scr_bmo_skipWeaponDropOnDeath", 0 );
    level.ref_133cd = getdvarint( "scr_bmo_skipEquipmentDropOnDeath", 1 );
    level.playerismatchedplayerready = getdvarint( "scr_bmo_forceArmorDropOnDeath", 1 );
    level.brjuggsettings = getdvarint( "scr_bmo_allowFultonDropOnDeath", 1 );
    level.ref_13ab9 = getdvarint( "scr_bmo_score_exfil", 0 ) == 1;
    level.ref_13aba = getdvarint( "scr_bmo_exfil_showvipteamonly", 0 ) == 1;
    level.ref_13abc = getdvarint( "scr_bmo_vipteam_uav", 0 ) == 1;
    level.ref_13abb = getdvarint( "scr_bmo_exfil_timer", 180 );
    level.ref_13368 = getdvarint( "scr_bmo_plunderextract_objicon_inworld", 1 ) == 1;
    level.ref_13363 = getdvarint( "scr_bmo_extract_objicon_nonscriptable", 0 );
    level.ref_13b85 = getdvarint( "scr_bmo_timeout_plunderextract", 0 );
    level.ref_11dad = getdvarint( "scr_bmo_move_plunderextract_onuse", 0 ) == 1;
    level.overheatlimit = int( getdvarint( "scr_bmo_extract_heli_health", 999 ) * 100 );
    level.overheatreductionamount = getdvarint( "scr_bmo_extract_heli_invulnerable", 1 );
    level.choppergunner_handledangerzone = getdvarint( "scr_bmo_extract_plunder_instant", 1 );
    level.ref_127ba = getdvarint( "scr_bmo_plunder_extract_alert", 1 );
    level.ref_11b3f = getdvarint( "scr_bmo_matchstart_extractsitedelay", 120 );
    level.spawn_boss_wave_suicidebombers = getdvarint( "scr_bmo_plunderextract_hide_unused", 1 );
    level.ref_1323e = scripts\engine\utility::ter_op( getdvar( "mapname" ) == "mp_br_mechanics", 0, getdvarint( "scr_bmo_plunderextract_distribution", 1 ) );
    level.ref_12f10 = getdvarint( "scr_bmo_score_requires_banking", 0 );
    level.¢ã#“‹Öâ6+8±’‹2≤'â¬7≠KÕù = getdvarint( "scr_rat_race_score_uses_deposited_plunder_only", 1 );
    level.locale_defaults = getdvarint( "scr_bmo_disable_win_on_score", 0 );
    level.make_bomb_detonator_interact = getdvarint( "scr_bmo_eom_ot_timer", 30 );
    level.ref_13124 = level.make_bomb_detonator_interact > 0;
    level.ref_12191 = getdvarint( "scr_bmo_ot_as_match_time", 1 );
    level.chopperexif_fx_init = getdvarint( "scr_bmo_eom_bank_to_end", 0 );
    level.ref_11adc = getdvarint( "scr_dmz_mapEdgeExtractionLocs", 0 );
    level.ref_11c85 = &ref_126a6;
    level.needs_controller = getdvarint( "scr_bmo_endMatchCameraTransitions", 1 );
    level.ref_12192 = getdvarfloat( "scr_bmo_overtimeCashMultiplier", 2 );
    setomnvar( "ui_br_overtime_cash_multiplier", level.ref_12192 );
    level.loadout_updatebrammo = getdvarint( "scr_bmo_disable_one_mil_announce", 0 );
    level.lootchopper_modifyweapondamage = getdvarint( "scr_dmz_loot_leader_update_on_pickup", 0 ) == 1;
    level.lootcontentsadjusteconomy_bottomtier = getdvarint( "scr_dmz_win_cost", 3000 ) * 1000;
    level.lootchopper_isnearbyoccupiedspawns = getdvarint( "scr_br_extract_cost", 300 );
    level.lootchopper_oncrateuse = getdvarint( "scr_br_extract_cost_min", 40 );
    level.lootchopper_managespawns = getdvarint( "scr_br_extract_cost_decrease", 20 );
    level.ref_11c41 = getdvarint( "br_min_plunder_extractions", 7 );
    level.ref_11b6d = getdvarint( "br_max_plunder_extractions", 7 );
    level.disable_back_light = 1;
    level.ref_12a12 = spawnstruct();
    level.ref_12a12.ref_1404c = getdvarint( "scr_rat_race_use_alternative_map_location_variant", 0 ) != 0;
    level.play_nag_players_hvt_callouts = &play_nag_intro_vo;
    ref_13208();
    ref_13209();
    level.ref_12a12.maphints = getdvarint( "scr_rat_race_pe_dom_radius", 750 );
    level.ref_12a12.ref_122a1 = getdvarint( "scr_rat_race_pe_dom_capture_time", 90 );
    level.ref_12a12.manualturret_watchturretusetimeout = getdvarfloat( "scr_rat_race_pe_dom_stompRate", 2 );
    level.ref_12a12.ref_1229c = getdvarint( "scr_rat_race_pe_cash_drops_total_count", 10 );
    level.ref_12a12.ref_12296 = getdvarint( "scr_rat_race_pe_cash_drops_first_wave_count", 5 );
    level.spawn_set_jugg_value = spawnstruct();
    level.spawn_set_jugg_value.chosen = undefined;
    level.spawn_set_jugg_value.choppersupport_watchtargetrange = undefined;
    level.ref_12a12.ref_13a9b = [];
    level.ref_12a12.ref_12482 = [];
    thread toggleusbstickinhand();
    thread teleportplayertoselection();
    thread subscribedlocale();
}

// Params 0
// Size: 0x385
function toggleusbstickinhand()
{
    waittillframeend();
    level.uavsettings[ "uav" ].timeout = 60;
    scripts\mp\flags::gameflaginit( "collect_done", 0 );
    scripts\mp\flags::gameflaginit( "helipad_wait_done", 0 );
    scripts\mp\flags::gameflaginit( "placement_updates_allowed", 0 );
    scripts\mp\flags::gameflaginit( "activate_cash_lzs", 0 );
    scripts\mp\flags::gameflaginit( "activate_cash_drops", 0 );
    scripts\mp\flags::gameflaginit( "activate_cash_helis", 0 );
    scripts\mp\flags::gameflaginit( "infil_complete", 0 );
    
    if ( getdvar( "mapname" ) != "mp_wz_island" )
    {
        level.ref_12a12.ref_12e2c = put_objective_on_guy( "default" );
        tank_x1_capacity();
    }
    
    subwave_progression();
    thread init_plunder_heli_overrides();
    thread init_plunder_fulton_overrides();
    level.ref_11c76 = &dyn_door;
    level.elevator_lights_toggle = &ref_11c50;
    level.ononeleftevent = &ononeleftevent;
    level.onplayerkilled = &onplayerkilled;
    level.ref_12075 = &ref_12075;
    level.ref_13b7e = &ref_13b66;
    level.ontimelimit = &ontimelimit;
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &ref_12601 );
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    thread ref_1325e();
    level.ref_11a29 = [];
    level.onstompeenemyprogressupdate = [];
    
    for ( var0 = 0; var0 < level.ref_11a27 ; var0++ )
    {
        var1 = 1;
        var2 = scripts\engine\utility::ter_op( level.ref_11a2c > 0 && var0 == 0, 5, 4 );
        var3 = spawnstruct();
        var3.modifier = "";
        var3 scripts\mp\gametypes\br_quest_util::init_tactical_boxes( var1, var2 );
        var3 scripts\mp\gametypes\br_quest_util::ref_1316f( level.ref_11a2a );
        level.ref_11a29[ var0 ] = var3;
        var3 = spawnstruct();
        var3.modifier = "";
        var3 scripts\mp\gametypes\br_quest_util::init_tactical_boxes( var1, var2, 2 );
        var3 scripts\mp\gametypes\br_quest_util::ref_1316f( level.ref_11a2a );
        level.onstompeenemyprogressupdate[ var0 ] = var3;
    }
    
    level.ô
ÄSnX˘m±w0≥Âb/⁄∏@À∆ = [];
    
    foreach ( var5 in level.teamnamelist )
    {
        if ( level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent( var5 ) )
        {
            continue;
        }
        
        level.ô
ÄSnX˘m±w0≥Âb/⁄∏@À∆[ var5 ] = [];
        
        for ( var0 = 0; var0 < level.íOËV[≠Ö—¨∆ˆˆ£± ∞»V…['÷±∑’sé ; var0++ )
        {
            var3 = spawnstruct();
            var3.modifier = "";
            init_tape_machine_animations( var3, "ui_mp_br_mapmenu_icon_teammate_loot_leader_objective", "invisible" );
            scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var3.objectiveiconid );
            scripts\mp\objidpoolmanager::update_objective_setzoffset( var3.objectiveiconid, 75 );
            scripts\mp\objidpoolmanager::objective_set_play_intro( var3.objectiveiconid, 0 );
            scripts\mp\objidpoolmanager::objective_set_play_outro( var3.objectiveiconid, 0 );
            objective_setshowdistance( var3.objectiveiconid, 0 );
            level.ô
ÄSnX˘m±w0≥Âb/⁄∏@À∆[ var5 ][ var0 ] = var3;
        }
    }
    
    if ( !istrue( level.ref_14086 ) )
    {
        thread ref_12397();
    }
    
    thread ref_14364();
    level thread scripts\mp\gametypes\br_analytics::teamvehicles();
    cleanupents();
    
    if ( level.ref_13abd )
    {
        if ( level.ref_11a37 > 0 )
        {
            thread ref_13ff1();
        }
    }
    
    if ( level.ref_13368 && level.ref_13363 )
    {
        thread init_relic_team_proximity();
    }
    
    if ( level.ref_13b85 > 0 )
    {
        scripts\mp\flags::gameflagwait( "prematch_done" );
        
        if ( level.ref_11b3f > 0 )
        {
            wait level.ref_11b3f;
        }
        
        thread ref_1386c();
    }
    
    if ( istrue( level.ref_11adc ) )
    {
        thread test_trigger_spawn();
    }
    
    level.ref_140d9 = [];
    level.ref_140d9[ 0 ] = "assassination";
    level.ref_140d9[ 1 ] = "domination";
    level.ref_140d9[ 2 ] = "scavenger";
    thread numextractions();
    
    if ( istrue( level.needs_controller ) )
    {
        thread test_pipe_fire();
    }
    
    var7 = getdvarint( "scr_bmo_c130OverrideSpeed", -1 );
    
    if ( var7 > 0 )
    {
        level.br_level.c130_speedoverride = var7;
    }
    
    if ( level.make_bomb_detonator_interact && level.ref_12191 )
    {
        thread getburnfxstatepriority();
    }
    
    thread syringe_out();
}

// Params 0
// Size: 0x26
function syringe_out()
{
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    scripts\mp\flags::gameflagwait( "infil_complete" );
    thread ref_13eee();
    thread ref_13fa8();
}

// Params 0
// Size: 0x4a
function getburnfxstatepriority()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var0 = getdvarint( "scr_br_timelimit" );
    var1 = int( max( var0 - level.make_bomb_detonator_interact, 0 ) );
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    wait var1;
    level notify( "end_circlestate_timer" );
    thread ref_13dc8( level, undefined, undefined );
}

// Params 0
// Size: 0xae
function ref_14363()
{
    level endon( "game_ended" );
    level.audio_railyard_fires = [];
    level.audio_railyard_fires[ "uktl" ] = "dx_bra_uktl_respawning_enemy_in_area";
    level.audio_railyard_fires[ "rutl" ] = "dx_bra_rutl_respawning_enemy_in_area";
    level.audio_railyard_fires[ "bchr" ] = "dx_bra_bchr_respawning_enemy_in_area";
    level.ref_121d0 = getdvarint( "scr_parachute_overhead_warning_timeout_ms", 45000 );
    level.ref_121ce = getdvarint( "scr_parachute_overhead_warning_prematch_timeout_ms", 20000 );
    level.ref_121cf = getdvarint( "scr_parachute_overhead_warning_radius", 2000 );
    level.ref_121cd = getdvarint( "scr_parachute_overhead_warning_height", 3000 );
    thread ref_144eb( level );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level notify( "cancel_watch_parachuters_overhead" );
    waitframe();
    thread ref_144eb( level );
}

// Params 0
// Size: 0x1a
function ref_14364()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    thread ref_127c6();
}

// Params 0
// Size: 0x39
function cleanupents()
{
    scripts\cp_mp\utility\game_utility::ref_12c10( "delete_on_load", "targetname" );
    scripts\cp_mp\utility\game_utility::ref_12c11( "door_prison_cell_metal_mp", 1 );
    scripts\cp_mp\utility\game_utility::ref_12c11( "door_wooden_panel_mp_01", 1 );
    scripts\cp_mp\utility\game_utility::ref_12c11( "me_electrical_box_street_01", 1 );
}

// Params 1
// Size: 0x50
function onplayerdisconnect( var0 )
{
    if ( isdefined( var0 ) && scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        var0 scripts\mp\gametypes\br_pickups::droponplayerdeath();
        
        if ( isdefined( level.lootchopper_initspawninfo ) )
        {
            if ( level.teamdata[ var0.team ][ "players" ].size == 0 )
            {
                level.lootchopper_initspawninfo--;
                return;
            }
            
            return;
        }
        
        scripts\mp\gametypes\br_gametype_dmz::freefallfromplanestatemachine();
        return;
    }
}

// Params 1
// Size: 0x4
function ononeleftevent( var0 )
{
    
}

// Params 1
// Size: 0x54
function ref_126f1( var0 )
{
    self endon( "disconnect" );
    self waittill( "do_welcome_splashes" );
    wait 2;
    level thread scripts\mp\gametypes\br_gametype_dmz::freefallfromplanestatemachine();
    scripts\mp\hud_message::showsplash( "br_gametype_rat_race_welcome" );
    
    if ( istrue( level.checkforcorrectinstance ) && istrue( level.br_prematchstarted ) )
    {
        scripts\mp\gametypes\br_gametype_dmz::checkforlaststandwipe( self );
    }
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    scripts\mp\gametypes\br_analytics::detachriotshield( self );
}

// Params 1
// Size: 0x5b, Type: bool
function ref_1365d( var0 )
{
    if ( istrue( level.dmztut_endgametransition ) && scripts\mp\flags::gameflag( "prematch_done" ) && level.mapname != "mp_br_mechanics" )
    {
        var1 = rear_door_collision( var0 );
        var2 = spawnstruct();
        var0.ref_1286f = var1;
        var0.ref_1286f.index = -1;
        thread ref_126a4( var0 );
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0xc3
function ref_126a4( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var1 = level.teamdata[ self.team ][ "nextRespawn" ];
    var2 = scripts\mp\utility\teams::getteamdata( self.team, "teamCount" );
    
    if ( var2 > 1 && !istrue( level.gameended ) )
    {
        thread scripts\mp\gametypes\br_spectate::spawnspectator( var0, undefined, 1 );
    }
    
    if ( istrue( level.gameended ) )
    {
        level waittill( "forever" );
    }
    
    self.waitingtospawn = 1;
    scripts\mp\gametypes\br::emp_drone_proximity_explode( 0 );
    self.waitingtospawn = 0;
    thread scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    
    if ( !istrue( level.skipprematchdropspawn ) )
    {
        thread ref_1253a();
    }
    
    while ( !isalive( self ) )
    {
        waitframe();
    }
    
    self notify( "brWaitAndSpawnClientComplete" );
    self.waitingtospawn = 0;
    scripts\mp\gametypes\br::ref_13f21( self );
    scripts\mp\damage::resetplayervariables();
    scripts\mp\gametypes\br::ending_fade_in();
    thread ref_13ee7();
    thread init_infil();
}

// Params 0
// Size: 0x2e
function ref_1253a()
{
    self endon( "disconnect" );
    
    while ( self.sessionstate != "playing" )
    {
        waitframe();
    }
    
    thread scripts\cp_mp\parachute::startfreefall( 0, 1, undefined, undefined, 1, 0 );
    self skydive_deployparachute();
}

// Params 0
// Size: 0x2
function relic_oneclip_stock_adjustment_monitor()
{
    
}

// Params 0
// Size: 0x18f
function ref_13c61()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var0 = 0;
    var1 = 0;
    var2 = 0;
    jumpiffalse(scripts\mp\gametypes\br_public::uniquelootitemid()) LOC_00000024;
    return;
}

// Params 0
// Size: 0x52
function play_quarry_intro_vo()
{
    var0 = getarraykeys( level.teamdata );
    
    foreach ( var2 in var0 )
    {
        if ( level.teamdata[ var2 ][ "alivePlayers" ].size > 0 )
        {
            return level.teamdata[ var2 ][ "alivePlayers" ][ 0 ];
        }
    }
    
    return undefined;
}

// Params 0
// Size: 0x48
function play_train_speaker_vo_internal()
{
    var0 = getarraykeys( level.teamdata );
    
    foreach ( var2 in var0 )
    {
        if ( level.teamdata[ var2 ][ "players" ].size == 0 )
        {
            return var2;
        }
    }
    
    return "tie";
}

// Params 10
// Size: 0xc7
function onplayerkilled( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    scripts\mp\gametypes\br::onplayerkilled( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
    
    if ( scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        return;
    }
    
    var10 = getdvarint( "scr_bmo_mode_splash_window", 7500 );
    
    if ( isdefined( level.ref_136f9 ) && level.ref_136f9 + var10 > gettime() )
    {
        scripts\mp\hud_message::showsplash( "bm_vips_marked" );
    }
    
    if ( isdefined( level.ref_136f8 ) && level.ref_136f8 + var10 > gettime() )
    {
        scripts\mp\hud_message::showsplash( "bm_extract_heli_start" );
    }
    
    if ( isdefined( level.ref_136f6 ) && level.ref_136f6 + var10 > gettime() )
    {
        scripts\mp\hud_message::showsplash( "br_c130airdrop_incoming" );
    }
    
    if ( isdefined( level.ref_136f7 ) && level.ref_136f7 + var10 > gettime() )
    {
        scripts\mp\hud_message::showsplash( "br_lootchopper_incoming" );
    }
    
    ref_122a7( var1, self );
}

// Params 0
// Size: 0x2
function activate_trap_from_interaction()
{
    
}

// Params 1
// Size: 0x7, Type: bool
function dyn_door( var0 )
{
    return true;
}

// Params 0
// Size: 0x33f
function playerrespawn()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    if ( getdvarint( "scr_bmo_use_spawn_fix", 1 ) == 1 )
    {
        self endon( "brWaitAndSpawnClientComplete" );
    }
    
    var0 = scripts\mp\utility\teams::getteamdata( self.team, "teamCount" );
    
    if ( !istrue( self.ref_13749 ) || var0 == 1 )
    {
        var1 = 1;
        wait var1;
    }
    
    if ( istrue( self.hasrespawntoken ) && isdefined( level.ref_13bcd ) )
    {
        var2 = level.ref_13bcd;
    }
    else if ( level.start_persistent_turbulence > 0 )
    {
        var2 = clamp( self.pers[ "deaths" ] * level.start_persistent_turbulence, 0, level.start_pipe_room );
    }
    else if ( isdefined( level.checkpoint_objective_id ) )
    {
        var2 = level.checkpoint_objective_id;
    }
    else
    {
        var2 = getdvarint( "scr_br_extract_spawn_wait", 20 );
    }
    
    var3 = getdvarfloat( "scr_bmo_respawn_predict_hint_time", 10 );
    
    if ( var2 < var3 )
    {
        var2 = var3;
    }
    
    if ( level.ref_12cb4 != 0 )
    {
        var2 = 0;
    }
    
    var4 = getdvarfloat( "scr_bmo_squad_wiped_stream_time", 5 );
    scripts\engine\utility::ent_flag_init( "playerRespawn_intermission_spawned" );
    self.trial_moving_target_think = undefined;
    self.trial_other_team = undefined;
    
    if ( istrue( self.ref_13749 ) || var2 == 1 )
    {
        var5 = scripts\mp\gametypes\br_gulag::ref_125be();
        var6 = scripts\mp\gametypes\br_gulag::ref_1263e( var5 );
        thread patchfix( 0, var2 > 1 );
        wait var4;
    }
    else if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        scripts\mp\utility\lower_message::setlowermessageomnvar( 9, int( gettime() + var2 * 1000 ) );
        var7 = var2 - var3;
        var8 = var2 - var7;
        var9 = var2 - getdvarfloat( "scr_bmo_respawn_intermission_time", 6 );
        thread patchfix( var9 );
        var10 = scripts\engine\utility::waittill_notify_or_timeout_return( "squad_wipe_death", var7 );
        
        if ( var10 == "squad_wipe_death" )
        {
            var5 = scripts\mp\gametypes\br_gulag::ref_125be();
            var6 = scripts\mp\gametypes\br_gulag::ref_1263e( var5 );
            thread patchfix( 0, 1 );
            wait var4;
        }
        else
        {
            thread ref_1400c();
            var10 = scripts\engine\utility::waittill_notify_or_timeout_return( "squad_wipe_death", var8 );
            
            if ( var10 == "squad_wipe_death" )
            {
                var5 = scripts\mp\gametypes\br_gulag::ref_125be();
                var6 = scripts\mp\gametypes\br_gulag::ref_1263e( var5 );
                thread patchfix( 0, 1 );
                wait var4;
            }
        }
    }
    
    self notify( "stop_updatePrestreamRespawn" );
    var5 = spawnstruct();
    
    if ( getdvarint( "scr_br_rat_race_respawn_to_squad", 1 ) == 1 )
    {
        var5 = scripts\mp\gametypes\br_gulag::ref_125be();
    }
    else
    {
        var5 = rear_door_collision();
    }
    
    var6 = scripts\mp\gametypes\br_gulag::ref_1263e( var5 );
    
    if ( istrue( self.ref_13749 ) )
    {
        self.ref_13749 = 0;
        
        if ( var2 > 1 && !scripts\mp\gametypes\br_public::uniquelootitemid() )
        {
            scripts\mp\hud_message::showsplash( "bm_your_squad_wiped" );
        }
    }
    
    if ( validate_demeanor( self.team ) )
    {
        return;
    }
    
    if ( istrue( self.hasrespawntoken ) )
    {
        thread scripts\mp\gametypes\br_gulag::ref_13dcb( 4 );
        self.ref_13bcc = 1;
        scripts\mp\gametypes\br_pickups::removerespawntoken();
    }
    
    if ( validate_demeanor( self.team ) )
    {
        return;
    }
    
    if ( getdvarint( "scr_skip_respawn_gate", 1 ) == 0 )
    {
        scripts\mp\gametypes\br_public::ref_126ed();
    }
    
    scripts\engine\utility::ent_flag_clear( "playerRespawn_intermission_spawned" );
    self.trial_moving_target_think = undefined;
    self.trial_other_team = undefined;
    scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    scripts\cp_mp\execution::_clearexecution();
    scripts\mp\gametypes\br_pickups::initplayer();
    
    if ( scripts\mp\gametypes\br_public::uniquelootitemid() && isdefined( level.ref_124e7 ) )
    {
        var5 = scripts\engine\utility::getstruct( level.ref_124e7, "targetname" );
    }
    
    scripts\mp\gametypes\br_gulag::gulagwinnerrespawn( 1, undefined, var5, 1, var6, 1 );
    scripts\mp\gametypes\br::ref_13f21( self );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "player_respawn" );
    _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_transition_type", 0 );
    scripts\mp\damage::resetplayervariables();
    thread ref_13ee7();
}

// Params 1
// Size: 0x7, Type: bool
function ref_12691( var0 )
{
    return true;
}

// Params 0
// Size: 0x7e
function ref_1400c()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "stop_updatePrestreamRespawn" );
    
    for ( ;; )
    {
        if ( scripts\engine\utility::ent_flag( "playerRespawn_intermission_spawned" ) )
        {
            var0 = scripts\mp\gametypes\br_gulag::ref_125be();
            var1 = gettime();
            
            if ( var1 - self.trial_other_team >= getdvarfloat( "scr_bmo_spawn_fallback_hint_delay", 2 ) * 1000 )
            {
                var0 = scripts\mp\gametypes\br_gulag::ref_125be( 1 );
                var2 = scripts\mp\gametypes\br_gulag::ref_1263e( var0 );
            }
        }
        else
        {
            var0 = scripts\mp\gametypes\br_gulag::ref_125be();
            var2 = scripts\mp\gametypes\br_gulag::ref_1263e( var0 );
        }
        
        wait 1;
    }
}

// Params 2
// Size: 0xd3
function patchfix( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self notify( "fadeToGearingUp" );
    self endon( "fadeToGearingUp" );
    
    if ( isdefined( var0 ) && var0 > 0 )
    {
        wait var0;
    }
    
    var2 = 1;
    thread fadeoutin();
    wait var2 - 0.25;
    scripts\mp\gametypes\br::ending_fade_in();
    
    if ( istrue( var1 ) )
    {
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_transition_type", 6 );
    }
    else
    {
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_transition_type", 2 );
    }
    
    wait 0.25;
    
    if ( getdvarint( "scr_bmo_use_spawn_intermission_fix", 1 ) == 1 )
    {
        scripts\mp\gametypes\br_public::ref_1252b();
        var3 = scripts\mp\gametypes\br_gulag::ref_125be();
        scripts\mp\gametypes\br_spectate::ref_1252a();
        scripts\mp\gametypes\br::spawnintermission( var3.origin, var3.angles );
        scripts\mp\spectating::setdisabled();
        self.trial_moving_target_think = var3.origin;
        self.trial_other_team = gettime();
        scripts\engine\utility::ent_flag_set( "playerRespawn_intermission_spawned" );
        return;
    }
}

// Params 0
// Size: 0x22
function fadeoutin()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    self waittill( "spawned_player" );
    scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

// Params 0
// Size: 0x2
function activate_javelin_ammo_refill()
{
    
}

// Params 0
// Size: 0x18
function ref_1325e()
{
    level.disable_super_in_turret.overheatreductionrate = relic_squadlink_vision_debuff();
    thread ref_11a9e();
}

// Params 0
// Size: 0x7d
function relic_squadlink_vision_debuff()
{
    var0 = 2500;
    var1 = level.br_level.br_mapcenter;
    var2 = ( 0, randomfloatrange( 0, 360 ), 0 );
    var3 = anglestoforward( var2 );
    var4 = level.br_level.br_circleradii[ 0 ] * 2;
    var5 = var1 + var3 * var4;
    var5 = scripts\mp\gametypes\br_c130::ref_1342e( var1, var5 );
    var6 = getent( "airstrikeheight", "targetname" );
    var7 = ( var5[ 0 ], var5[ 1 ], var6.origin[ 2 ] );
    var8 = tracegroundpoint( var7 );
    var5 = var8 + ( 0, 0, var0 );
    return var5;
}

// Params 0
// Size: 0x4b
function ref_11a9e()
{
    var0 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    level.disable_super_in_turret.objectiveiconid = var0;
    
    if ( var0 != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var0, "current", level.disable_super_in_turret.overheatreductionrate, "icon_waypoint_koth" );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var0, 0 );
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var0 );
        return;
    }
}

// Params 0
// Size: 0x54
function ref_1325f()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var0 = relic_mythic_should_ai_play_pain();
    var1 = scripts\mp\gametypes\br_quest_util::getquesttableindex( "gt_extract_1" );
    
    foreach ( var3 in level.players )
    {
        var3 scripts\mp\gametypes\br_quest_util::ref_131ae( var1 );
        var3 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter( var0 );
    }
}

// Params 0
// Size: 0x48
function relic_mythic_should_ai_play_pain()
{
    var0 = getdvarint( "scr_br_extract_xp", 5000 );
    var1 = getdvarint( "scr_br_extract_xp_min", 2000 );
    var2 = getdvarint( "scr_br_extract_xp_decrease", 200 );
    
    if ( var1 > 0 )
    {
        var0 = int( max( var1, var0 - level.disable_super_in_turret.ref_11f3b * var2 ) );
    }
    
    return var0;
}

// Params 1
// Size: 0x46
function ref_13354( var0 )
{
    var1 = level.teamdata[ var0 ][ "players" ];
    
    foreach ( var3 in var1 )
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.disable_super_in_turret.objectiveiconid, var3 );
    }
}

// Params 1
// Size: 0x46
function spawn_carriables_from_prefabs_min_max( var0 )
{
    var1 = level.teamdata[ var0 ][ "players" ];
    
    foreach ( var3 in var1 )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( level.disable_super_in_turret.objectiveiconid, var3 );
    }
}

// Params 0
// Size: 0x103
function maxvehicledamagedivisor()
{
    level.disable_super_in_turret.ref_11f3b++;
    level.disable_super_in_turret.spawn_weapon setvalue( level.disable_super_in_turret.ref_11f3b );
    thread spawn_vindia_assault3();
    thread spawn_vindia_assault3();
    var0 = relic_healthpacks_think();
    level.disable_super_in_turret.spawn_trucks setvalue( var0 * 100 );
    
    foreach ( var2 in level.teamdata )
    {
        if ( isdefined( var2[ "teamCount" ] ) && var2[ "teamCount" ] > 0 )
        {
            ref_14024( var3 );
        LOC_000000a9:
        }
    LOC_000000a9:
    }
    
    var4 = relic_mythic_should_ai_play_pain();
    
    foreach ( var6 in level.players )
    {
        if ( !validate_demeanor( var6.team ) )
        {
            var6 thread scripts\mp\hud_message::showsplash( "br_gametype_extract_extracted" );
            var6 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter( var4 );
        }
    }
}

// Params 1
// Size: 0x14
function ref_131ca( var0 )
{
    level.teamdata[ var0 ][ "extracted" ] = 1;
}

// Params 1
// Size: 0x13, Type: bool
function validate_demeanor( var0 )
{
    return istrue( level.teamdata[ var0 ][ "extracted" ] );
}

// Params 0
// Size: 0x38
function brendgame()
{
    wait 1.5;
    handleendgamesplash();
    scripts\mp\gamelogic::endgame_regularmp( level.disable_super_in_turret.player_enemy_cooldown, game[ "end_reason" ][ "objective_completed" ], game[ "end_reason" ][ "br_eliminated" ] );
}

// Params 0
// Size: 0x44
function handleendgamesplash()
{
    foreach ( var1 in level.players )
    {
        if ( !validate_demeanor( var1.team ) )
        {
            var1 _calloutmarkerping_handleluinotify_added::ref_13133( "post_game_state", 2 );
        }
    }
}

// Params 0
// Size: 0x17b
function ref_1327a()
{
    level endon( "game_ended" );
    var0 = 120;
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        level waittill( "br_ready_to_jump" );
    }
    
    waitframe();
    var1 = init_relic_trex( &"MP_BR_INGAME/EXTRACT_COLLECT_PLUNDER", undefined, "CENTER", "CENTER", 0, -170 );
    var1.alpha = 1;
    var2 = scripts\mp\hud_util::createservertimer( "default", 1.5 );
    var2 scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, -150 );
    var3 = getdvarint( "scr_br_extract_timecollect", 180 );
    
    if ( var3 > 0 )
    {
        setomnvar( "ui_hardpoint_timer", gettime() + int( var3 * 1000 ) );
        var2 settimer( var3 );
        wait var3;
    }
    
    scripts\mp\flags::gameflagset( "collect_done" );
    var4 = getdvarint( "scr_br_extract_timewaitactive", 180 );
    
    if ( var4 > 0 )
    {
        var1.label = &"MP_BR_INGAME/EXTRACT_HELIPADS_ACTIVE";
        thread spawn_vindia_assault3();
        setomnvar( "ui_hardpoint_timer", gettime() + int( var4 * 1000 ) );
        var2 settimer( var4 );
        wait var4;
    }
    
    scripts\mp\flags::gameflagset( "helipad_wait_done" );
    var5 = getdvarint( "scr_br_extract_timeextract", 840 );
    var1.label = &"MP_BR_INGAME/EXTRACT_HELIPAD";
    thread spawn_vindia_assault3();
    setomnvar( "ui_hardpoint_timer", gettime() + int( var5 * 1000 ) );
    var2 settimer( var5 );
    var6 = max( var5 - var0, 0 );
    wait var6;
    var7 = max( var5 - var6, 0 );
    var2.color = ( 1, 0, 0 );
    thread spawn_vindia_assault3();
    thread heli_assault2_death_watcher( var7 );
    wait var7;
    var2 destroy();
    thread brendgame();
}

// Params 1
// Size: 0x8e
function heli_assault2_death_watcher( var0 )
{
    level endon( "game_ended" );
    
    while ( var0 > 0 )
    {
        var1 = 0;
        var2 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc( var0 );
        
        if ( var0 > 60 && var0 % 10 == 0 || var0 <= 60 && var0 > 30 && var0 % 2 == 0 || var0 <= 30 )
        {
            var1 = 1;
        }
        
        if ( var1 )
        {
            foreach ( var4 in level.players )
            {
                var4 playlocalsound( var2 );
            }
        }
        
        var0 -= 1;
        wait 1;
    }
}

// Params 0
// Size: 0x2
function activate_stealth_settings()
{
    
}

// Params 0
// Size: 0x220
function ref_13278()
{
    var0 = 155;
    var1 = 15;
    var2 = -3;
    var3 = 3;
    
    if ( level.ref_13abd )
    {
        var4 = safehouse_regroup();
        var5 = &"MP_BR_INGAME/WIN_COST_TEXT";
        var6 = var4;
    }
    else
    {
        var4 = relic_healthpacks_think();
        var5 = &"MP_BR_INGAME/EXTRACT_COST_TEXT";
        var6 = var4 * 100;
    }
    
    level.disable_super_in_turret.spawn_tugofwar_tank = init_relic_trex( var5, undefined, "LEFT", "CENTER", var6, var3, undefined, undefined, 1 );
    level.disable_super_in_turret.spawn_trucks = init_relic_trex( &"MP_BR_INGAME/EXTRACT_COST_MILLION", undefined, "LEFT", "CENTER", 65 + var6, var3, undefined, undefined, 1 );
    level.disable_super_in_turret.spawncrossbowbolt = init_relic_trex( &"MP_BR_INGAME/YOUR_TEAM_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", 5 + var5, var3, undefined, undefined, 1 );
    var7 = 0;
    level.disable_super_in_turret.water_immunity_time = init_relic_trex( &"MP_BR_INGAME/LEADER_PLUNDER_TEXT", var7, "CENTER", "CENTER", 0, var3 + var4, undefined, undefined, 1 );
    
    foreach ( var9 in level.teamnamelist )
    {
        var10 = init_relic_trex( &"MP_BR_INGAME/EXTRACT_PLUNDER", 0, "RIGHT", "CENTER", 70 + var5, var3, undefined, var9, 1 );
        var11 = init_relic_trex( &"MP_BR_INGAME/ST_PLACE", undefined, "RIGHT", "CENTER", -65 + var5, var3, undefined, var9, 1 );
        var11 setvalue( 1 );
        var10.placement = var11;
        ref_131ce( var9, var10 );
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        level waittill( "br_ready_to_jump" );
    }
    
    level.disable_super_in_turret.spawn_tugofwar_tank.alpha = 1;
    level.disable_super_in_turret.spawn_trucks.alpha = 1;
    level.disable_super_in_turret.spawncrossbowbolt.alpha = 1;
    level.disable_super_in_turret.water_immunity_time.alpha = 1;
    
    foreach ( var9 in level.teamnamelist )
    {
        var10 = run_cleanup_funcs_for_unused_objectives( var9 );
        var10.alpha = 1;
        var10.placement.alpha = 1;
    }
}

// Params 2
// Size: 0x26
function ref_131ce( var0, var1 )
{
    level.teamdata[ var0 ][ "hudPlunder" ] = var1;
    var1.plundercount = 0;
    var1.ref_127b3 = 0;
}

// Params 1
// Size: 0x12
function run_cleanup_funcs_for_unused_objectives( var0 )
{
    return level.teamdata[ var0 ][ "hudPlunder" ];
}

// Params 10
// Size: 0x10b
function init_relic_trex( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    if ( !isdefined( var8 ) )
    {
        var8 = 1.5;
    }
    
    if ( isdefined( var7 ) )
    {
        var10 = newteamhudelem( var7 );
    }
    else if ( isdefined( var10 ) )
    {
        var10 = newclienthudelem( var10 );
    }
    else
    {
        var10 = newhudelem();
    }
    
    var10.elemtype = "font";
    var10.font = "default";
    var10.fontscale = var10;
    var10.basefontscale = var10;
    var10.x = 0;
    var10.y = 0;
    var10.width = 0;
    var10.height = int( level.fontheight * var10 );
    var10.xoffset = 0;
    var10.yoffset = 0;
    var10.children = [];
    var10 scripts\mp\hud_util::setparent( level.uiparent );
    var10.hidden = 0;
    var10.alpha = 0;
    var10 scripts\mp\hud_util::setpoint( var4, var5, var6, var7 );
    
    if ( isdefined( var2 ) )
    {
        var10.label = var2;
    }
    
    if ( isdefined( var3 ) )
    {
        var10 setvalue( var3 );
    }
    
    if ( isdefined( var8 ) )
    {
        var10.color = var8;
    }
    
    return var10;
}

// Params 0
// Size: 0x48
function replace_access_card_on_deathordisconnect()
{
    var0 = level.br_plunder.ref_12954[ level.br_plunder.ref_12954.size - 1 ] * 100;
    var1 = int( ceil( level.lootcontentsadjusteconomy_bottomtier / var0 ) );
    var2 = getdvarint( "scr_rat_race_max_plunder_scriptable_drops_at_one_time_override", 50 );
    
    if ( var1 > var2 )
    {
        var1 = var2;
    }
    
    return var1;
}

// Params 1
// Size: 0x12
function run_common_functions_solider_stealth( var0 )
{
    return level.teamdata[ var0 ][ "plunderInDeposit" ];
}

// Params 1
// Size: 0x23
function run_died_poorly_funcs( var0 )
{
    if ( isdefined( level.ref_12a12.ref_13a9b ) )
    {
        return level.ref_12a12.ref_13a9b[ var0 ];
    }
    
    return undefined;
}

// Params 1
// Size: 0x41
function run_blima_exfil_sequence( var0 )
{
    var1 = 0;
    
    if ( !level.ref_12f10 )
    {
        var1 += level.teamdata[ var0 ][ "plunderTeamTotal" ];
        var1 += level.teamdata[ var0 ][ "plunderInDeposit" ];
    }
    
    var1 += level.teamdata[ var0 ][ "plunderBanked" ];
    return var1;
}

// Params 1
// Size: 0x12
function rpg_shoot_at_trigs( var0 )
{
    return level.teamdata[ var0 ][ "plunderTeamTotal" ];
}

// Params 1
// Size: 0x12
function registerontimerupdate( var0 )
{
    return level.teamdata[ var0 ][ "plunderBanked" ];
}

// Params 2
// Size: 0x9, Type: bool
function ref_134d8( var0, var1 )
{
    return var0 > var1;
}

// Params 2
// Size: 0x1b
function setobjectivecallbacks( var0, var1 )
{
    var2 = int( min( var1, 131072 ) );
    _calloutmarkerping_handleluinotify_added::ref_13133( var0, var2 );
}

// Params 2
// Size: 0x1b
function setoutputfunc( var0, var1 )
{
    var2 = int( min( var1, 131072 ) );
    _calloutmarkerping_handleluinotify_added::ref_13134( var0, var2 );
}

// Params 0
// Size: 0x9b3
function ref_127c6()
{
    level endon( "game_ended" );
    var0 = 0;
    var1 = [];
    var2 = 0;
    var3 = 0;
    var4 = 0;
    var5 = 0;
    var6 = 0;
    var7 = 0;
    var8 = level.spawn_convoy_and_move != 0;
    level.ref_136f9 = undefined;
    level.ref_136f8 = undefined;
    level.ref_136f6 = undefined;
    level.ref_136f7 = undefined;
    var9 = gettime();
    var10 = getdvarfloat( "scr_dmz_print_error_cutoff", 30 );
    
    for ( ;; )
    {
        waittillframeend();
        var11 = ( gettime() - var9 ) / 1000;
        var12 = level.fuckwithgravity && level.fuel_stability_event_init && level.fuel_stability_event_start;
        var13 = safehouse_regroup();
        var0 += level.framedurationseconds;
        
        if ( istrue( level.ref_14086 ) )
        {
            var14 = scripts\mp\flags::gameflag( "placement_updates_allowed" );
        }
        else
        {
            var14 = var0 > level.ref_12fb3;
        }
        
        var15 = level.ref_13366 && var14;
        var16 = scripts\mp\gamescore::run_common_functions_stealth();
        var17 = level.ref_13abd;
        var18 = undefined;
        var19 = undefined;
        var20 = undefined;
        var21 = [];
        var22 = [];
        var23 = [];
        var24 = "none";
        var25 = "none";
        var26 = -1;
        var27 = -1;
        
        foreach ( var29 in level.teamnamelist )
        {
            if ( level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent( var29 ) )
            {
                continue;
            }
            
            var30 = run_blima_exfil_sequence( var29 );
            var31 = scripts\engine\utility::ter_op( level.¢ã#“‹Öâ6+8±’‹2≤'â¬7≠KÕù, run_common_functions_solider_stealth( var29 ), var30 );
            var32 = registerontimerupdate( var29 );
            var33 = ref_14025( var31, var29, level.disable_super_in_turret.player_enemy_cooldown );
            var34 = revive_or_disconnect_monitor( var29 );
            var35 = var16[ var29 ];
            
            if ( var31 > var26 )
            {
                if ( var26 > var27 )
                {
                    var27 = var26;
                    var25 = var24;
                }
                
                var26 = var31;
                var24 = var29;
            }
            else if ( var24 != "none" )
            {
                if ( var31 > var27 )
                {
                    var27 = var31;
                    var25 = var29;
                }
            }
            
            var36 = ( var30 - var32 ) * 100;
            var37 = var30 * 100;
            var38 = var37 - var36;
            
            if ( var38 > 0 )
            {
            }
            
            if ( var36 < 0 )
            {
                var36 = 0;
            }
            
            var39 = var31 * 100;
            
            if ( var39 >= var13 * 0.9 )
            {
                var18 = var29;
            }
            else if ( var39 >= var13 * 0.75 )
            {
                var19 = var29;
            }
            else if ( var39 >= var13 * 0.5 )
            {
                var20 = var29;
            }
            
            if ( var39 >= var13 * level.ref_127c1 )
            {
                thread scripts\mp\music_and_dialog::ref_12791();
            }
            else if ( var39 >= var13 * level.ref_127c3 )
            {
                thread scripts\mp\music_and_dialog::ref_127a7();
            }
            else if ( var39 >= var13 * level.ref_127c2 )
            {
                thread scripts\mp\music_and_dialog::ref_1278b();
            }
            else if ( var39 >= var13 * level.ref_127c0 )
            {
                thread scripts\mp\music_and_dialog::ref_127a9();
            }
            
            var40 = scripts\mp\utility\teams::getfriendlyplayers( var29, 0 );
            
            foreach ( var42 in var40 )
            {
                var35 = var16[ var42.team ];
                
                if ( !var6 )
                {
                    var35 = 155;
                }
                
                var42 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_team_placement", var35 );
                var42 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_player_position", var35 );
                setobjectivecallbacks( var42, "ui_br_team_cash_banked", int( var38 * 0.01 ) );
                setobjectivecallbacks( var42, "ui_br_team_cash_pockets", int( var36 * 0.01 ) );
                var22 = var42.plundercount;
                var23 = var42;
            }
            
            if ( var15 )
            {
                if ( var35 == 1 )
                {
                    var21 = var29;
                }
                else if ( var35 <= 5 )
                {
                    if ( var34 > 5 )
                    {
                        showsplashtoteam( var29, "bm_top_5" );
                    }
                }
                else if ( var35 <= 10 )
                {
                    if ( var34 > 10 )
                    {
                        showsplashtoteam( var29, "bm_top_10" );
                    }
                }
            }
            
            if ( var39 >= var13 )
            {
                if ( var17 && level.make_bomb_detonator_interact > 0 && !level.locale_defaults )
                {
                    thread ref_13dc8( level, var29 );
                    continue;
                }
                
                if ( var17 && level.make_bomb_detonator_interact > 0 && level.locale_defaults )
                {
                    level.time_before_shoot = var29;
                    continue;
                }
                
                if ( level.ref_13ab9 && !istrue( level.exfilactive ) )
                {
                    level.exfilactive = 1;
                    thread ref_13839( level );
                    continue;
                }
                
                if ( !level.ref_13ab9 && var17 && !level.locale_defaults )
                {
                    thread searchradiusidealmin( level );
                }
            }
        }
        
        var45 = [];
        var46 = [];
        
        if ( level.ref_11a2c == 1 )
        {
            var45 = setteamplacement( game[ "teamPlacements" ], "up" );
        }
        else if ( level.ref_11a2c == 2 )
        {
            var45 = var24;
            var46 = setteamplacement( var22, "down" );
        }
        else
        {
            var46 = setteamplacement( var22, "down" );
        }
        
        level.disable_super_in_turret.player_enemy_cooldown = var24;
        
        if ( var24 == "none" )
        {
            var1 = [];
            waitframe();
            continue;
        }
        
        if ( var25 != "none" )
        {
            setoutputfunc( "ui_br_cash_second", int( var27 ) );
        }
        
        setoutputfunc( "ui_br_cash_leader", int( var26 ) );
        
        if ( !var8 && var26 * 100 >= var13 * level.spawn_convoy_and_move * 0.01 )
        {
            setomnvar( "ui_br_leader_hash_percentage_hit", 1 );
            var8 = 1;
        }
        
        if ( !istrue( var7 ) && istrue( level.ref_14086 ) )
        {
            if ( !var2 && var26 * 100 >= var13 * level.ref_11be6 * 0.01 )
            {
                var2 = 1;
                level.ref_136f9 = gettime();
                scripts\mp\flags::gameflagset( "placement_updates_allowed" );
                
                if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    ref_13371( "bm_vips_marked" );
                }
            }
            
            if ( !var3 && ( level.ref_12f10 || var26 * 100 >= var13 * level.ref_11be5 * 0.01 ) )
            {
                var3 = 1;
                level.ref_136f8 = gettime();
                scripts\mp\flags::gameflagset( "activate_cash_lzs" );
                
                if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    scripts\mp\gametypes\br_public::brleaderdialog( "extract_enabled", 0, undefined, undefined, undefined, "bm" );
                }
            }
            
            var4 = 1;
            var5 = 1;
            
            if ( !var6 && var26 * 100 >= var13 * level.spawn_default_player_spawns * 0.01 )
            {
                var6 = 1;
            }
            
            if ( var2 && var3 && var4 && var5 )
            {
                var7 = 1;
            }
        }
        
        if ( !var15 )
        {
            waitframe();
            continue;
        }
        
        if ( level.ref_11a2c > 0 )
        {
            if ( level.lootchopper_modifyweapondamage || istrue( level.ref_127d2 ) )
            {
                ref_13ff0( var22, var46, var23, var45 );
                level.ref_127d2 = 0;
            }
        }
        else if ( level.lootchopper_modifyweapondamage || istrue( level.ref_127d2 ) )
        {
            ref_13ff0( var22, var46, var23 );
            level.ref_127d2 = 0;
        }
        
        if ( var46.size != var22.size )
        {
            var46 = setteamplacement( var22, "down" );
        }
        
        updateteammatelootleadermarks( var22, var46, var23 );
        
        if ( var26 == 0 )
        {
            waitframe();
            continue;
        }
        
        foreach ( var29 in var21 )
        {
            if ( !scripts\engine\utility::array_contains( var1, var29 ) )
            {
                if ( istrue( level.ref_13be1[ var29 ] ) )
                {
                    if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                    {
                        showsplashtoteam( var29, "bm_top_team_regained" );
                    }
                    
                    continue;
                }
                
                if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    showsplashtoteam( var29, "bm_top_team" );
                }
                
                level.ref_13be1[ var29 ] = 1;
            }
        }
        
        if ( var21.size > 0 )
        {
            foreach ( var29 in var1 )
            {
                if ( !scripts\engine\utility::array_contains( var21, var29 ) )
                {
                    showsplashtoteam( var29, "bm_top_team_lost" );
                }
            }
        }
        
        var1 = var21;
        level.ref_13be0 = var24;
        level.ref_12884 = var16;
        
        if ( !var12 )
        {
            if ( !level.fuel_stability_event_start && isdefined( var18 ) )
            {
                level.fuel_stability_event_start = 1;
                
                if ( var11 < var10 )
                {
                    ref_12892( level, "90 Percent", var11 );
                }
                
                if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    if ( !level.loadout_updateclassdefault_headlessgetweaponn )
                    {
                        ref_13372( var18, "bm_first_to_90_them" );
                        showsplashtoteam( var18, "bm_first_to_90_us" );
                        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "gamestate_90_perc_first", var18, 1, undefined, "bm" );
                        
                        foreach ( var52 in level.teamnamelist )
                        {
                            if ( var52 != var18 )
                            {
                                level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "gamestate_90_perc_enemy", var52, 1, undefined, "bm" );
                            }
                        }
                    }
                }
            }
            else if ( !level.fuel_stability_event_init && isdefined( var19 ) )
            {
                level.fuel_stability_event_init = 1;
                
                if ( var11 < var10 )
                {
                    ref_12892( level, "75 Percent", var11 );
                }
                
                if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    if ( !level.loadout_updateclassdefault_headlessgetweaponn )
                    {
                        ref_13372( var19, "bm_first_to_75_them" );
                        showsplashtoteam( var19, "bm_first_to_75_us" );
                        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "gamestate_75_perc_first", var19, 1, undefined, "bm" );
                        
                        foreach ( var52 in level.teamnamelist )
                        {
                            if ( var52 != var19 )
                            {
                                level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "gamestate_75_perc_enemy", var52, 1, undefined, "bm" );
                            }
                        }
                    }
                }
            }
            else if ( !level.fuckwithgravity && isdefined( var20 ) )
            {
                level.fuckwithgravity = 1;
                
                if ( var11 < var10 )
                {
                    ref_12892( level, "50 Percent", var11 );
                }
                
                if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    if ( !level.loadout_updateclassdefault_headlessgetweaponn )
                    {
                        ref_13372( var20, "bm_first_to_50_them" );
                        showsplashtoteam( var20, "bm_first_to_50_us" );
                        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "gamestate_50_perc_first", var20, 1, undefined, "bm" );
                        
                        foreach ( var52 in level.teamnamelist )
                        {
                            if ( var52 != var20 )
                            {
                                level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "gamestate_50_perc_enemy", var52, 1, undefined, "bm" );
                            }
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x94
function checkforovertime( var0 )
{
    if ( !isdefined( level.checkformatchend ) )
    {
        level.checkformatchend = [];
    }
    
    if ( scripts\engine\utility::array_contains( level.checkformatchend, var0 ) )
    {
        return;
    }
    
    var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    var2 = scripts\mp\gametypes\br_plunder::init_subway_cars();
    var2.ref_1244d = 0;
    
    foreach ( var4 in var1 )
    {
        if ( isdefined( var4.plundercount ) && var4.plundercount > 0 )
        {
            var4 scripts\mp\gametypes\br_plunder::ref_12618( var4.plundercount, undefined, var2 );
        }
    }
    
    level.checkformatchend[ level.checkformatchend.size ] = var0;
}

// Params 0
// Size: 0xe
function ref_12192()
{
    level thread scripts\mp\gametypes\br_plunder::ref_128a6( level.ref_12192 );
}

// Params 0
// Size: 0x27
function ref_12397()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( isdefined( level.ref_12fb3 ) )
    {
        wait level.ref_12fb3;
    }
    
    scripts\mp\flags::gameflagset( "placement_updates_allowed" );
}

// Params 1
// Size: 0x18
function revive_or_disconnect_monitor( var0 )
{
    if ( isdefined( level.ref_12884 ) )
    {
        return level.ref_12884[ var0 ];
    }
    
    return -1;
}

// Params 1
// Size: 0x31
function ref_13371( var0 )
{
    foreach ( var2 in level.players )
    {
        var2 scripts\mp\hud_message::showsplash( var0 );
    }
}

// Params 2
// Size: 0x3a
function showsplashtoteam( var0, var1 )
{
    foreach ( var3 in level.teamdata[ var0 ][ "players" ] )
    {
        var3 scripts\mp\hud_message::showsplash( var1 );
    }
}

// Params 2
// Size: 0x43
function ref_13372( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3 ) && var3.team != var0 )
        {
            var3 scripts\mp\hud_message::showsplash( var1 );
        }
    }
}

// Params 1
// Size: 0x53
function ref_13dc6( var0 )
{
    scripts\mp\gamelogic::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    var1 = getdvarfloat( "scr_bmo_900k_timer", 10 );
    var2 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
    level.watchdvars[ var2 ].value = var1;
    level.overridewatchdvars[ var2 ] = var1;
}

// Params 1
// Size: 0x88
function ref_14024( var0 )
{
    var1 = run_cleanup_funcs_for_unused_objectives( var0 );
    var2 = run_blima_exfil_sequence( var0 );
    var3 = relic_healthpacks_think();
    
    if ( var2 >= var3 && var1.color != ( 0, 1, 0 ) )
    {
        var1.color = ( 0, 1, 0 );
        var4 = level.teamdata[ var0 ][ "players" ];
        
        foreach ( var6 in var4 )
        {
            var6 playlocalsound( "br_plunder_atm_deposit_gtr" );
        }
        
        return;
    }
}

// Params 2
// Size: 0x96
function makepickup( var0, var1 )
{
    var2 = level.teamdata[ var1 ][ "players" ];
    
    foreach ( var4 in var2 )
    {
        if ( var0 > 0 )
        {
            if ( isdefined( var4.spawncorpsehider ) )
            {
                var5 = gettime() - var4.spawncorpsehider;
                
                if ( var5 <= 6000 )
                {
                    break;
                }
            }
            
            var3.spawncorpsehider = gettime();
            
            if ( isalive( var3 ) )
            {
                var3 playlocalsound( "br_plunder_atm_use" );
            }
            
            continue;
        }
        
        var3.spawncorpsehider = undefined;
        var3 stoplocalsound( "br_plunder_atm_use" );
    }
    
    var2 = undefined;
    var4 = undefined;
}

// Params 1
// Size: 0x4a
function searchradiusidealmin( var0 )
{
    if ( istrue( level.ref_13dc0 ) )
    {
        return;
    }
    
    if ( !istrue( level.ref_13dc0 ) )
    {
        thread ref_12893();
    }
    
    level.ref_13dc0 = 1;
    level thread scripts\mp\gamelogic::endgame( var0, game[ "end_reason" ][ "dmz_plunder_win" ], game[ "end_reason" ][ "dmz_plunder_loss" ], 0, 1 );
}

// Params 2
// Size: 0x285, Type: bool
function playerdropplunderondeath( var0, var1 )
{
    if ( scripts\mp\utility\game::updatehistoryhud( self ) )
    {
        return true;
    }
    
    if ( istrue( level.gameended ) )
    {
        return true;
    }
    
    if ( istrue( self.unicornpoints ) )
    {
        var2 = self.plundercount;
        var3 = self.plundercount;
        var4 = 0;
    }
    else
    {
        jumpiffalse(isdefined( level.ref_11c40 ) && self.plundercount < level.ref_11c40) LOC_0000006c;
        var4 = 0;
        var2 = self.plundercount;
        var3 = self.plundercount;
        goto LOC_00000095;
    }
    
    self.plundercountondeath = var4;
    
    if ( var3 > 0 )
    {
        scripts\mp\gametypes\br_plunder::ref_1261e( var3 );
    }
    
    if ( var2 >= level.ref_127bc )
    {
        playfx( scripts\engine\utility::getfx( "money" ), self.origin + ( 0, 0, 32 ) );
    }
    
    var5 = var2;
    
    if ( istrue( self.ref_14436 ) )
    {
        var5 = int( var2 * level.oic_loadouts );
    }
    
    var6 = var5;
    
    if ( istrue( level.convoy_handle_stuck_compromise ) && ( !isdefined( var4 ) || self != var4 ) )
    {
        var6 = int( var5 * level.ref_12192 );
        
        if ( isdefined( level.ref_11b6b ) && var6 > level.ref_11b6b )
        {
            var6 = level.ref_11b6b;
        }
    }
    
    if ( scripts\mp\gametypes\br_public::uniquelootitemid() && istrue( self.get_vehicle_ai_spawner ) )
    {
        var6 = int( var6 + self.get_vehicle_ai_spawner );
    }
    
    if ( var6 > 0 )
    {
        var7 = replace_access_card_on_deathordisconnect();
        var8 = scripts\mp\gametypes\br_plunder::dropplunderbyrarity( var6, var3, var7 );
        
        foreach ( var10 in var8 )
        {
            var10.ref_11a40 = "combat";
        }
        
        if ( scripts\mp\gametypes\br_public::uniquelootitemid() )
        {
            level notify( "victim_death_drop", self, var4, var8 );
        }
    }
    
    if ( isdefined( var4 ) && self == var4 || !level.killcam )
    {
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_plunder_dropped", var3 );
    }
    else
    {
        self.ref_12801 = var3;
    }
    
    scripts\mp\gametypes\br_analytics::ref_13c44( self, "combat", var3 * -1 );
    
    if ( isdefined( level.ref_11a32 ) && scripts\engine\utility::array_contains( level.ref_11a32, self ) )
    {
        playfx( scripts\engine\utility::getfx( "money" ), self.origin + ( 0, 0, 64 ) );
    }
    
    return true;
}

// Params 0
// Size: 0x25
function ref_12075()
{
    if ( isdefined( self.ref_12801 ) )
    {
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_plunder_dropped", int( self.ref_12801 ) );
        self.ref_12801 = undefined;
        return;
    }
}

// Params 0
// Size: 0x38
function relic_healthpacks_think()
{
    if ( level.lootchopper_oncrateuse > 0 )
    {
        var0 = int( max( level.lootchopper_oncrateuse, level.lootchopper_isnearbyoccupiedspawns - level.disable_super_in_turret.ref_11f3b * level.lootchopper_managespawns ) );
    }
    
    return level.lootchopper_isnearbyoccupiedspawns;
}

// Params 0
// Size: 0x8
function safehouse_regroup()
{
    return level.lootcontentsadjusteconomy_bottomtier;
}

// Params 1
// Size: 0x3e
function ref_126c1( var0 )
{
    if ( self.plundercount < var0 )
    {
        var0 = self.plundercount;
    }
    
    if ( !isdefined( self.ref_127bb ) )
    {
        self.ref_127bb = 0;
    }
    
    self.ref_127bb += var0;
    scripts\mp\gametypes\br_plunder::playersetplundercount( self.plundercount - var0 );
    return var0;
}

// Params 1
// Size: 0x3d
function ref_13aa8( var0 )
{
    var1 = level.teamdata[ var0 ][ "players" ];
    
    foreach ( var3 in var1 )
    {
        var3.ref_127bb = 0;
    }
}

// Params 1
// Size: 0x60
function ref_13abf( var0 )
{
    var1 = level.teamdata[ var0 ][ "players" ];
    
    foreach ( var3 in var1 )
    {
        if ( isdefined( var3.ref_127bb ) )
        {
            var3 scripts\mp\gametypes\br_plunder::ref_12627( var3.ref_127bb );
            var3.ref_127bb = 0;
            var3 iprintlnbold( "Extraction refunded, chopper shot down." );
        }
    }
}

// Params 0
// Size: 0x4c
function spawn_vindia_assault3()
{
    self endon( "death" );
    
    if ( istrue( self.ref_1293b ) )
    {
        return;
    }
    
    var0 = 0.5;
    var1 = 4;
    self.ref_1293b = 1;
    var2 = self.fontscale;
    self changefontscaleovertime( var0 );
    self.fontscale = var1;
    wait var0;
    self changefontscaleovertime( var0 );
    self.fontscale = var2;
    self.ref_1293b = undefined;
}

// Params 1
// Size: 0xae
function drophelicrate( var0 )
{
    var1 = spawn( "script_model", var0.origin );
    var1 setmodel( "military_skyhook_backpack" );
    var2 = var0.origin;
    var3 = ( var2[ 0 ], var2[ 1 ], -12000 );
    var4 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    var5 = scripts\engine\trace::ray_trace( var2, var3, var0, var4 );
    var6 = var5[ "position" ];
    var7 = var2[ 2 ] - var6[ 2 ];
    
    if ( var7 > 0 )
    {
        var8 = sqrt( 2 * var7 / 800 );
        var1 moveto( var6, var8, var8, 0 );
        wait var8;
    }
    
    var1.origin = var6;
    playfx( scripts\engine\utility::getfx( "airdrop_crate_impact" ), var6 );
    cratedropplunder( var1 );
    var1 delete();
}

// Params 0
// Size: 0x1d
function cratedropplunder()
{
    var0 = relic_healthpacks_think();
    var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var2 = replace_access_card_on_deathordisconnect();
    scripts\mp\gametypes\br_plunder::dropplunderbyrarity( var0, var1, var2 );
}

// Params 3
// Size: 0x4a
function frag_crate_spawn( var0, var1, var2 )
{
    var3 = var0 * 1.57828e-05;
    var4 = 0.5 * var2;
    var5 = var1;
    var6 = -1 * var3;
    var7 = ( -1 * var5 + sqrt( var5 * var5 - 4 * var4 * var6 ) ) / 2 * var4;
    var7 *= 3600;
    var7 += 1.5;
    return var7;
}

// Params 1
// Size: 0x2b
function frag_crate_player_at_max_ammo( var0 )
{
    var1 = frag_crate_spawn( 30000, 100, 125 );
    var2 = frag_crate_spawn( var0, 25, 31.25 );
    var3 = var1 + var2;
    return var3;
}

// Params 2
// Size: 0x62
function sortplayerplunderscores( var0, var1 )
{
    var2 = gettime() + int( var1 * 1000 );
    var3 = level.teamdata[ self.team ][ "alivePlayers" ];
    
    foreach ( var5 in var3 )
    {
        var5 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_plunder_extract_state", var0 );
        var5 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_plunder_extract_end_time", var2 );
    }
}

// Params 0
// Size: 0xb2
function smoke_door()
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_success", self.team, 1 );
    var0 = 0;
    var1 = 0;
    
    foreach ( var3 in self.plunder )
    {
        var0 += var3.plundercount;
        
        if ( var3.player.team != self.team )
        {
            var1 = 1;
        }
    }
    
    scripts\mp\gametypes\br_analytics::detonatefx( self.plunder.size, var0, "little_bird", var1, self.endpoint );
    level.br_plunder.oscope_sign_think += var0;
    level.br_plunder.oscope_sign++;
    scripts\mp\gametypes\br_plunder::num_players_in_safehouse();
}

// Params 0
// Size: 0x26
function heliusecleanup()
{
    if ( isdefined( self.usable ) )
    {
        level.br_depots = scripts\engine\utility::array_remove( level.br_depots, self.usable );
        self.usable = undefined;
        return;
    }
}

// Params 1
// Size: 0x24
function helicleanupdepotonleaving( var0 )
{
    self.usable endon( "death" );
    scripts\engine\utility::waittill_either( "leaving", "death" );
    heliusecleanup();
}

// Params 1
// Size: 0x5a
function helicreateextractvfx( var0 )
{
    self.vfxent = spawn( "script_model", var0 );
    self.vfxent setmodel( "scr_smoke_grenade" );
    self.vfxent.angles = ( 0, 90, 90 );
    self.vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    self.vfxent setscriptablepartstate( "smoke", "on" );
}

// Params 1
// Size: 0x4e
function helicleanupextract( var0 )
{
    if ( isdefined( self.vfxent ) )
    {
        self.vfxent stoploopsound();
        self.vfxent delete();
    }
    
    if ( istrue( var0 ) && isdefined( self.site ) )
    {
        self.site setscriptablepartstate( self.site.type, self.site.audio_shf_kill_hangar_lights );
        return;
    }
}

// Params 0
// Size: 0x5d
function snapshot_crate_spawn()
{
    self endon( "death" );
    
    if ( !isdefined( self.vfxent ) )
    {
        return;
    }
    
    wait 5;
    self.vfxent endon( "death" );
    self.vfxent setscriptablepartstate( "smoke", "dissipate" );
    self.vfxent playsound( "smoke_canister_tail_dissipate" );
    wait 1;
    self.vfxent stoploopsound();
    wait 4.5;
    self.vfxent delete();
}

// Params 4
// Size: 0x159
function spawnheli( var0, var1, var2, var3 )
{
    var4 = vectortoangles( var2 - var1 );
    var5 = 99;
    var6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter( var0, var1, var4, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x" );
    
    if ( !isdefined( var6 ) )
    {
        return;
    }
    
    var7 = var2 * ( 1, 1, 0 );
    var6.damagecallback = &callback_vehicledamage;
    var6.speed = 50;
    var6.accel = 99999;
    var6.health = 1000;
    var6.maxhealth = var6.health;
    var6.team = var0.team;
    var6.owner = var0;
    var6.defendloc = var2;
    var6.lifeid = 0;
    var6.flaresreservecount = var5;
    var6.pathgoal = var2;
    var6.ref_121ff = var3;
    var6.endpoint = var7;
    var6.select_mountain_two_spawners = var4[ 1 ];
    var6.vehiclename = "magma_plunder_chopper";
    var6 setcandamage( 1 );
    var6 setmaxpitchroll( 10, 25 );
    var6 vehicle_setspeed( var6.speed, var6.accel );
    var6 sethoverparams( 50, 100, 50 );
    var6 setturningability( 0.05 );
    var6 setyawspeed( 45, 25, 25, 0.5 );
    var6 setotherent( var0 );
    ref_13693( var6 );
    var6 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger( undefined, undefined );
    thread showquestcircletoplayer();
    thread handledestroydamage();
    thread smuggler_post_tele_kill();
    return var6;
}

// Params 1
// Size: 0xa2
function ref_13693( var0 )
{
    var1 = spawn( "script_model", ( 0, 0, 0 ) );
    var1 setmodel( "br_plunder_extraction_delivery_rope" );
    var1 linkto( var0, "side_door_l_jnt", ( 11, 20, 42 ), ( 0, 180, 0 ) );
    var2 = spawn( "script_model", ( 0, 0, 0 ) );
    var2 setmodel( "br_plunder_extraction_delivery_bag" );
    var2 linkto( var1, "dyn_rope_end", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var0.rope = var1;
    var0.crate = var2;
}

// Params 0
// Size: 0x7f
function smuggler_post_tele_kill()
{
    self endon( "heli_gone" );
    self endon( "swapped" );
    var0 = self.owner;
    var1 = self.team;
    self waittill( "death", var2, var3, var4, var5 );
    ref_13abf( var1 );
    smoke_enemy_think();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.largeprojectiledamage ) && !istrue( self.isdepot ) )
    {
        self vehicle_setspeed( 25, 5 );
        thread smokesignal( 75 );
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    snowballfighthint( var2 );
}

// Params 0
// Size: 0x27
function smoke_enemy_think()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        self.crate delete();
        return;
    }
}

// Params 1
// Size: 0xb9
function snowballfighthint( var0 )
{
    var1 = self gettagorigin( "tag_origin" ) + ( 0, 0, 40 );
    self radiusdamage( var1, 256, 140, 70, var0, "MOD_EXPLOSIVE" );
    playfx( scripts\engine\utility::getfx( "little_bird_explode" ), var1, anglestoforward( self.angles ), anglestoup( self.angles ) );
    playsoundatpos( var1, "veh_chopper_support_crash" );
    earthquake( 0.4, 800, var1, 0.7 );
    playrumbleonposition( "grenade_rumble", var1 );
    physicsexplosionsphere( var1, 500, 200, 1 );
    self notify( "explode" );
    wait 0.35;
    level thread scripts\mp\gametypes\br::ref_13ac7( "br_gametype_extract_heli_shot_down", self.owner, self.owner.team );
    helicleanupextract( 1 );
    smuggler_killed_early();
}

// Params 0
// Size: 0x9
function smuggler_killed_early()
{
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle( self );
}

// Params 1
// Size: 0x55
function smokesignal( var0 )
{
    self endon( "explode" );
    self notify( "heli_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( var0, var0, var0 );
    self settargetyaw( self.angles[ 1 ] + var0 * 2.5 );
}

// Params 0
// Size: 0xbc
function handledestroydamage()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "swapped" );
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
        var9 = scripts\mp\utility\weapon::mapweapon( var9, var13 );
        
        if ( ( var9.basename == "aamissile_projectile_mp" || var9.basename == "nuke_mp" ) && var4 == "MOD_EXPLOSIVE" && var0 >= self.health )
        {
            callback_vehicledamage( var1, var1, 9001, 0, var4, var9, var3, var2, var3, 0, 0, var7 );
            helicleanupextract( 1 );
        }
    }
}

// Params 13
// Size: 0xf3
function callback_vehicledamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12 )
{
    if ( isdefined( var1 ) )
    {
        if ( isdefined( var1.owner ) )
        {
            var1 = var1.owner;
        }
    }
    
    if ( ( var1 == self || isdefined( var1.pers ) && var1.pers[ "team" ] == self.team && !level.friendlyfire && level.teambased ) && var1 != self.owner )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    var2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage( var1, var5, var4, var2, self.maxhealth, 3, 4, 5 );
    scripts\mp\killstreaks\killstreaks::killstreakhit( var1, var5, self, var4, var2 );
    var1 scripts\mp\damagefeedback::updatedamagefeedback( "" );
    
    if ( self.health - var2 <= 900 && ( !isdefined( self.smoking ) || !self.smoking ) )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 );
}

// Params 0
// Size: 0x8f
function sol_3_4_pool()
{
    self endon( "death" );
    self notify( "leaving" );
    self.leaving = 1;
    self setvehgoalpos( self.pathgoal, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    sortplayerplunderscores( 3, self.player_weapon_fired_monitor );
    self waittill( "goal" );
    self vehicle_setspeed( self.speed, self.accel );
    self setvehgoalpos( self.ref_121ff, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    self waittill( "goal" );
    self stoploopsound();
    smoke_door();
    sortplayerplunderscores( 0, 0 );
    self notify( "heli_gone" );
    smuggler_killed_early();
}

// Params 2
// Size: 0x69
function helidescend( var0, var1 )
{
    self endon( "death" );
    var2 = var0[ 0 ];
    var3 = var0[ 1 ];
    var4 = ( var2, var3, var1 );
    self setvehgoalpos( var4, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    self vehicle_setspeed( 25, 31.25 );
    thread snapplayertotoppos();
    thread snappointtooutofboundstriggertrace();
    self waittill( "goal" );
    self sethoverparams( 1, 1 );
    wait 1;
    self sethoverparams( 25, 20, 10 );
}

// Params 0
// Size: 0x25, Type: bool
function nuke_vault_suicidebomber_internal()
{
    return isalive( self ) && ( scripts\common\vehicle::isvehicle() || isdefined( self.classname ) && self.classname == "script_vehicle" );
}

// Params 0
// Size: 0x46
function snapplayertotoppos()
{
    self endon( "leaving" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "touch", var0 );
        
        if ( isdefined( var0 ) && nuke_vault_suicidebomber_internal( var0 ) )
        {
            var0 dodamage( var0.health, self.origin, var0, var0, "MOD_CRUSH" );
        }
    }
}

// Params 0
// Size: 0x1cc
function snappointtooutofboundstriggertrace()
{
    self endon( "leaving" );
    self endon( "death" );
    var0 = 70;
    var1 = -80;
    var2 = 150;
    var3 = 25;
    var4 = -100;
    
    for ( ;; )
    {
        var5 = getentarrayinradius( "script_vehicle", "classname", self.origin, getdvarfloat( "test_radius", 400 ) );
        
        if ( var5.size <= 1 )
        {
            wait 0.5;
            continue;
        }
        
        var6 = scripts\engine\trace::create_vehicle_contents();
        var7 = anglestoforward( self.angles );
        var8 = self.origin + var7 * getdvarfloat( "test_f", var2 ) + ( 0, 0, getdvarfloat( "test_d", var1 ) );
        var9 = scripts\engine\trace::sphere_trace( var8, var8 + ( 0, 0, 1 ), var0, self, var6 );
        var10 = var9[ "entity" ];
        
        if ( isdefined( var10 ) && nuke_vault_suicidebomber_internal( var10 ) )
        {
            var10 dodamage( var10.health, self.origin, var10, var10, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        var8 = self.origin + var7 * getdvarfloat( "test_m", var3 ) + ( 0, 0, getdvarfloat( "test_d", var1 ) );
        var9 = scripts\engine\trace::sphere_trace( var8, var8 + ( 0, 0, 1 ), var0, self, var6 );
        var10 = var9[ "entity" ];
        
        if ( isdefined( var10 ) && nuke_vault_suicidebomber_internal( var10 ) )
        {
            var10 dodamage( var10.health, self.origin, var10, var10, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        var8 = self.origin + var7 * getdvarfloat( "test_b", var4 ) + ( 0, 0, getdvarfloat( "test_d", var1 ) );
        var9 = scripts\engine\trace::sphere_trace( var8, var8 + ( 0, 0, 1 ), var0, self, var6 );
        var10 = var9[ "entity" ];
        
        if ( isdefined( var10 ) && nuke_vault_suicidebomber_internal( var10 ) )
        {
            var10 dodamage( var10.health, self.origin, var10, var10, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x22
function tracegroundheight( var0 )
{
    var1 = 125;
    var2 = tracegroundpoint( var0, 100, [ self ] );
    var3 = var2[ 2 ];
    var4 = var3 + var1;
    return var4;
}

// Params 3
// Size: 0x4a
function tracegroundpoint( var0, var1, var2 )
{
    var3 = -99999;
    var4 = ( var0[ 0 ], var0[ 1 ], var3 );
    var5 = scripts\engine\trace::create_world_contents();
    var6 = undefined;
    
    if ( isdefined( var1 ) )
    {
        var6 = scripts\engine\trace::sphere_trace( var0, var4, var1, var2, var5 );
    }
    else
    {
        var6 = scripts\engine\trace::ray_trace( var0, var4, var2, var5 );
    }
    
    return var6[ "position" ];
}

// Params 0
// Size: 0x1e
function heliwatchgameendleave()
{
    self endon( "death" );
    self endon( "leaving" );
    level waittill( "game_ended" );
    thread sol_3_4_pool();
}

// Params 0
// Size: 0x2
function activate_gasmask()
{
    
}

// Params 0
// Size: 0x148
function test_trigger_spawn()
{
    var0 = [];
    
    if ( scripts\cp_mp\utility\game_utility::unlink_on_ai_death() )
    {
        GscBinSkip0( 0x2e, var0.size, ( -33750, -36000, 155 ) );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    switch ( level.mapname )
    {
        case "mp_br_mechanics":
            GscBinSkip0( 0x2e, var0.size, ( 1500, 1500, 0 ) );
            // Unknown operator ( 0x2e, iw8, PC )
        case "mp_mb_tut":
            break;
    }
    
    level.outer = var0;
    level.oscope_ampl_think = [];
    thread ref_11d07();
}

// Params 1
// Size: 0x4
function init_relic_noks( var0 )
{
    
}

// Params 0
// Size: 0x175
function ref_11d07()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( var1 in level.outer )
    {
        var2 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
        
        if ( var2 != -1 )
        {
            scripts\mp\objidpoolmanager::objective_add_objective( var2, "active", var1, "icon_waypoint_flag" );
            scripts\mp\objidpoolmanager::update_objective_setbackground( var2, 0 );
            scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var2 );
            scripts\mp\objidpoolmanager::objective_playermask_showtoall( var2 );
        }
        
        thread ref_1364f( level );
    }
    
    for ( ;; )
    {
        foreach ( var1 in level.outer )
        {
            var5 = scripts\mp\utility\player::getplayersinradius( var1, 300 );
            
            foreach ( var7 in var5 )
            {
                if ( !scripts\engine\utility::array_contains( level.oscope_ampl_think, var7 ) && !istrue( var7.oscope_temp ) )
                {
                    open_spots_and_spawn_truck( var7, var1 );
                }
            }
        }
        
        foreach ( var7 in level.oscope_ampl_think )
        {
            if ( distancesquared( var7.origin, var7.oscope_temps_think ) > 90000 )
            {
                open_selected_doors( var7 );
                continue;
            }
            
            var7.outline_ent_index -= level.framedurationseconds;
            
            if ( var7.outline_ent_index <= 0 )
            {
                open_sliding_door( var7 );
            }
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x64
function ref_1364f( var0 )
{
    var1 = scripts\engine\utility::drop_to_ground( var0, 50, -200, ( 0, 0, 1 ) );
    var2 = spawn( "script_model", var1 + ( 0, 0, 3 ) );
    var2 setmodel( "scr_smoke_grenade" );
    wait 1;
    playfxontag( scripts\engine\utility::getfx( "vfx_smk_signal_red" ), var2, "tag_fx" );
    var2 playloopsound( "mp_flare_burn_lp" );
}

// Params 1
// Size: 0x31
function open_spots_and_spawn_truck( var0 )
{
    self iprintlnbold( "Extraction Start!" );
    level.oscope_ampl_think = scripts\engine\utility::array_add( level.oscope_ampl_think, self );
    self.oscope_temps_think = var0;
    self.outline_ent_index = 10;
    thread ref_13355();
}

// Params 0
// Size: 0x35
function ref_13355()
{
    self endon( "death_or_disconnect" );
    self endon( "extactionCancel" );
    
    while ( self.outline_ent_index > 0 )
    {
        self iprintlnbold( "Extracting in " + scripts\engine\math::round_float( self.outline_ent_index, 1 ) );
        waitframe();
    }
}

// Params 0
// Size: 0x30
function open_selected_doors()
{
    self notify( "extactionCancel" );
    self iprintlnbold( "Extraction Canceled!" );
    level.oscope_ampl_think = scripts\engine\utility::array_remove( level.oscope_ampl_think, self );
    self.oscope_temps_think = undefined;
    self.outline_ent_index = undefined;
}

// Params 0
// Size: 0x30
function open_sliding_door()
{
    self iprintlnbold( "Extraction Complete!" );
    level.oscope_ampl_think = scripts\engine\utility::array_remove( level.oscope_ampl_think, self );
    self.oscope_temp = 1;
    kick( self getentitynumber(), "EXE/PLAYERKICKED_EXTRACTED" );
}

// Params 1
// Size: 0xf2
function checkforlaststandwipe( var0 )
{
    if ( !isdefined( level.questinfo.teamsonquests ) || scripts\engine\utility::array_contains( level.questinfo.teamsonquests, var0.team ) )
    {
        return;
    }
    
    var1 = [];
    
    foreach ( var3 in level.ref_140d9 )
    {
        var1 = scripts\engine\utility::array_combine( var1, getlootscriptablearrayinradius( "brloot_" + var3 + "_tablet" ) );
    }
    
    var1 = scripts\engine\utility::array_randomize( var1 );
    var5 = undefined;
    var6 = undefined;
    
    foreach ( var8 in var1 )
    {
        var9 = scripts\engine\utility::distance_2d_squared( var0.origin, var8.origin );
        
        if ( var9 <= 16777216 && var9 >= 16384 )
        {
            var0 scripts\mp\gametypes\br_quest_util::ref_13a38( var8 );
            return;
        }
        
        if ( !isdefined( var5 ) || var9 < var6 )
        {
            var5 = var8;
            var6 = var9;
        }
    }
    
    if ( isdefined( var5 ) )
    {
        var0 scripts\mp\gametypes\br_quest_util::ref_13a38( var5 );
        return;
    }
}

// Params 1
// Size: 0x3d
function ref_11c50( var0 )
{
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        if ( var4 == "circle_peek" )
        {
            continue;
        }
        
        var1 = var3;
    }
    
    return var1;
}

// Params 1
// Size: 0x9a
function setupextractionsites( var0 )
{
    var1 = [];
    
    if ( isdefined( var0 ) && var0 != "tie" )
    {
        var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    }
    
    var2 = scripts\mp\gamelogic::reinforcement_icon_objective_id();
    
    foreach ( var4 in level.players )
    {
        if ( var1.size > 0 && scripts\engine\utility::array_contains( var1, var4 ) )
        {
            var4 _calloutmarkerping_handleluinotify_added::ref_13133( "post_game_state", var2 );
            var4 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_end_game_splash_type", 11 );
            continue;
        }
        
        var4 _calloutmarkerping_handleluinotify_added::ref_13133( "post_game_state", var2 );
        var4 _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_end_game_splash_type", 12 );
    }
}

// Params 3
// Size: 0x38
function ref_14025( var0, var1, var2 )
{
    var3 = scripts\mp\gamescore::_getteamscore( var1 );
    var4 = var0 - var3;
    
    if ( var4 != 0 )
    {
        var5 = scripts\engine\utility::ter_op( scripts\mp\gametypes\br_public::uniquelootitemid(), 1, undefined );
        level thread scripts\mp\gamescore::giveteamscoreforobjective( var1, var4, 0, undefined, var5, var2 );
    }
    
    return var4;
}

// Params 0
// Size: 0xd0
function ref_13ff1()
{
    level notify( "restartLootLeaders" );
    level endon( "restartLootLeaders" );
    level endon( "game_ended" );
    var0 = level.ref_11a37;
    var1 = level.ref_11a38;
    var2 = level.ref_11a3b;
    var3 = level.ref_11a39;
    var4 = var0 - var1;
    scripts\mp\flags::gameflagwait( "placement_updates_allowed" );
    
    for ( ;; )
    {
        level.ref_127d2 = 1;
        scripts\engine\utility::waittill_notify_or_timeout( "bmo_overtime_start", var4 );
        
        if ( var1 > 0 )
        {
            foreach ( var6 in level.ref_11a29 )
            {
                var6.mapcircle setmapcirclestyleindex( 2 );
            }
            
            scripts\engine\utility::waittill_notify_or_timeout( "bmo_overtime_start", var1 );
            
            foreach ( var6 in level.ref_11a29 )
            {
                var6.mapcircle setmapcirclestyleindex( 0 );
            }
        }
    }
}

// Params 3
// Size: 0x79
function ref_13fcb( var0, var1, var2 )
{
    var3 = gettime();
    var2 *= 1000;
    var4 = int( var3 + var2 );
    var5 = abs( var0 - var1 );
    
    for ( ;; )
    {
        var3 = gettime();
        var6 = clamp( 1 - ( var4 - var3 ) / var2, 0, 1 );
        var7 = scripts\engine\utility::ter_op( var0 < var1, var5 * var6 + var0, var0 - var5 * var6 );
        setdvar( "PPRTMPMQM", var7 );
        
        if ( var6 == 1 )
        {
            break;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x2
function activate_pressure_sensor()
{
    
}

// Params 4
// Size: 0x46d
function ref_13ff0( var0, var1, var2, var3 )
{
    level.ref_11a36 = level.ref_11a32;
    level.ref_11a32 = [];
    level.ref_11a33 = [];
    
    if ( level.ref_11a31 )
    {
        if ( istrue( level.convoy_handle_stuck_compromise ) )
        {
            level.ref_11a27 = binoculars_checkpendingtimer();
            
            foreach ( var5 in level.ref_11a29 )
            {
                var5.mapcircle hide();
            }
        }
    }
    
    if ( level.ref_11a2c == 1 )
    {
        for ( var7 = 0; var7 < level.ref_11a27 ; var7++ )
        {
            var8 = removeplatepouch( var7, var0, var3 );
            
            if ( isdefined( var8 ) )
            {
                level.ref_11a32[ level.ref_11a32.size ] = var2[ var8 ];
                
                if ( istrue( level.onsquadeliminatedplacement ) )
                {
                    if ( isdefined( var2[ var8 ].onstim ) )
                    {
                        ref_12c17( var2[ var8 ].onstim );
                    }
                }
            }
        }
    }
    else
    {
        jumpiffalse(level.ref_11a2c == 2) LOC_000001b4;
        var8 = removeplatepouch( 0, var0, var3 );
        
        if ( isdefined( var8 ) )
        {
            level.ref_11a32[ 0 ] = var2[ var8 ];
            
            if ( istrue( level.onsquadeliminatedplacement ) )
            {
                if ( isdefined( var2[ var8 ].onstim ) )
                {
                    ref_12c17( var2[ var8 ].onstim );
                }
            }
        }
        
        foreach ( var10 in var1 )
        {
            var11 = var2[ var10 ];
            var12 = var0[ var10 ];
            
            if ( var12 == 0 )
            {
                break;
            }
            
            if ( scripts\engine\utility::array_contains( level.ref_11a32, var11 ) )
            {
                continue;
            }
            
            level.ref_11a32[ level.ref_11a32.size ] = var11;
            
            if ( istrue( level.onsquadeliminatedplacement ) )
            {
                if ( isdefined( var11.onstim ) )
                {
                    ref_12c17( var11.onstim );
                }
            }
            
            if ( level.ref_11a32.size == level.ref_11a27 )
            {
                break;
            }
        }
        
        goto LOC_0000029d;
    }
    
    foreach ( var11 in level.ref_11a36 )
    {
        if ( isdefined( var11 ) && !scripts\engine\utility::array_contains( level.ref_11a32, var11 ) )
        {
            ref_12c18( var11 );
        }
    }
    
    for ( var7 = 0; var7 < level.ref_11a27 ; var7++ )
    {
        var22 = level.ref_11a29[ var7 ];
        
        if ( isdefined( level.ref_11a32[ var7 ] ) )
        {
            var22.targetplayer = level.ref_11a32[ var7 ];
            var22.targetplayer.ref_11a26 = var22;
            var23 = ( var22.targetplayer.origin[ 0 ], var22.targetplayer.origin[ 1 ], level.ref_11a2a );
            
            if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
            {
                var23 += scripts\engine\math::random_vector_2d() * randomfloatrange( level.ref_11a35, level.ref_11a34 );
            }
            
            var22 scripts\mp\gametypes\br_quest_util::ref_11dae( var23 );
            
            if ( istrue( level.ref_11a2b ) )
            {
                ref_13fef( var22 );
            }
            
            var24 = scripts\engine\utility::array_contains( level.ref_11a32, var22.targetplayer ) && !scripts\engine\utility::array_contains( level.ref_11a36, var22.targetplayer );
            var25 = scripts\mp\utility\teams::getenemyplayers( var22.targetplayer.team, 0 );
            
            foreach ( var11 in var25 )
            {
                var22 scripts\mp\gametypes\br_quest_util::ref_1336a( var11 );
            }
            
            var28 = scripts\mp\utility\teams::getfriendlyplayers( var22.targetplayer.team, 0 );
            
            foreach ( var11 in var28 )
            {
                var22 scripts\mp\gametypes\br_quest_util::spawn_dogtags( var11 );
            }
            
            if ( var24 )
            {
                battle_tracks_updatebattletracks( var22 );
            }
            
            continue;
        }
        
        var22.targetplayer = undefined;
        
        foreach ( var11 in level.players )
        {
            var22 scripts\mp\gametypes\br_quest_util::spawn_dogtags( var11 );
        }
    }
}

// Params 3
// Size: 0x89
function removeplatepouch( var0, var1, var2 )
{
    var3 = var2[ var0 ];
    var4 = 0;
    var5 = 0;
    
    if ( level.teamdata[ var3 ][ "players" ].size == 0 )
    {
        return undefined;
    }
    
    var6 = level.teamdata[ var3 ][ "players" ][ 0 ].guid;
    
    foreach ( var8 in level.teamdata[ var3 ][ "players" ] )
    {
        var4 = var1[ var8.guid ];
        
        if ( var4 > var5 )
        {
            var5 = var4;
            var6 = var8.guid;
        }
    }
    
    return var6;
}

// Params 1
// Size: 0x43
function battle_tracks_updatebattletracks( var0 )
{
    var1 = var0.targetplayer;
    
    if ( scripts\mp\utility\player::isreallyalive( var1 ) )
    {
        if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
        {
            var1 scripts\mp\hud_message::showsplash( "bm_player_marked" );
        }
        
        get_valid_seats( var1 );
        
        if ( istrue( level.onsquadeliminatedplacement ) )
        {
            thread watchforplayerdeath( var1 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x9a
function ref_12c18( var0 )
{
    if ( isdefined( var0.carriable_set_dropped ) )
    {
        get_valid_starting_station_name_on_track( var0 );
    }
    
    if ( isdefined( var0.ref_11a26 ) )
    {
        foreach ( var2 in level.players )
        {
            var0.ref_11a26 scripts\mp\gametypes\br_quest_util::spawn_dogtags( var2 );
        }
        
        var4 = var0.ref_11a26.guard_spawners;
        
        if ( istrue( level.onsquadeliminatedplacement ) )
        {
            battle_tracks_trystopdrivertogglethink( var0, var4 );
        }
        
        var0.ref_11a26.targetplayer = undefined;
        var0.ref_11a26 = undefined;
    }
    
    level.ref_11a32 = scripts\engine\utility::array_remove( level.ref_11a32, var0 );
}

// Params 1
// Size: 0x2f
function watchforplayerdeath( var0 )
{
    self endon( "disconnect" );
    self waittill( "death" );
    var1 = self.ref_11a26.guard_spawners;
    ref_12c18( self );
    battle_tracks_trystopdrivertogglethink( self, var1 );
}

// Params 2
// Size: 0x1c0
function battle_tracks_trystopdrivertogglethink( var0, var1 )
{
    if ( scripts\engine\utility::array_contains( level.onstun, var0 ) )
    {
        return;
    }
    
    level.onstun = scripts\engine\utility::array_add( level.onstun, var0 );
    var2 = undefined;
    
    foreach ( var4 in level.onstompeenemyprogressupdate )
    {
        if ( !isdefined( var4.targetplayer ) )
        {
            var2 = var4;
            break;
        }
    }
    
    if ( !isdefined( var2 ) )
    {
        var6 = undefined;
        
        foreach ( var4 in level.onstompeenemyprogressupdate )
        {
            if ( !isdefined( var6 ) || var4.lastusedtime < var6 )
            {
                var6 = var4.lastusedtime;
                var2 = var4;
            }
        }
        
        var2.targetplayer notify( "stop_update" );
    }
    
    var2.targetplayer = var0;
    var2.lastusedtime = gettime();
    var0.onstim = var2;
    
    if ( isdefined( var1 ) )
    {
        var2 scripts\mp\gametypes\br_quest_util::ref_11dae( var1 );
    }
    else
    {
        var9 = ( var2.targetplayer.origin[ 0 ], var2.targetplayer.origin[ 1 ], level.ref_11a2a );
        var9 += scripts\engine\math::random_vector_2d() * randomfloatrange( level.ref_11a35, level.ref_11a34 );
        var2 scripts\mp\gametypes\br_quest_util::ref_11dae( var9 );
    }
    
    if ( istrue( level.ref_11a2b ) )
    {
        ref_13fef( var2 );
    }
    
    var10 = scripts\mp\utility\teams::getenemyplayers( var2.targetplayer.team, 0 );
    
    foreach ( var4 in var10 )
    {
        var2 scripts\mp\gametypes\br_quest_util::ref_1336a( var4 );
    }
    
    var13 = scripts\mp\utility\teams::getfriendlyplayers( var2.targetplayer.team, 0 );
    
    foreach ( var4 in var13 )
    {
        var2 scripts\mp\gametypes\br_quest_util::spawn_dogtags( var4 );
    }
    
    thread ref_13fd5( var2 );
}

// Params 1
// Size: 0x1e
function ref_13fd5( var0 )
{
    var0.targetplayer endon( "stop_update" );
    wait 5;
    ref_12c17( var0 );
}

// Params 1
// Size: 0x6c
function ref_12c17( var0 )
{
    var1 = var0.targetplayer;
    level.onstun = scripts\engine\utility::array_remove( level.onstun, var0.targetplayer );
    var0.targetplayer.onstim = undefined;
    var0.targetplayer = undefined;
    
    foreach ( var3 in level.players )
    {
        var0 scripts\mp\gametypes\br_quest_util::spawn_dogtags( var3 );
    }
    
    var1 notify( "stop_update" );
}

// Params 3
// Size: 0x2a4
function updateteammatelootleadermarks( var0, var1, var2 )
{
    if ( !isdefined( var0 ) || !isdefined( var1 ) || !isdefined( var2 ) || !level.Ü©—V∞k≠∞Ëïÿ{Ì:ç≤Ö¨9≠¬'≠≤Õ,L±Y2 )
    {
        return;
    }
    
    var3 = [];
    var4 = getdvarint( "scr_rat_race_teammate_loot_leader_mark_min_plunder", 2000 );
    
    foreach ( var6 in var1 )
    {
        var7 = var2[ var6 ];
        var8 = var0[ var6 ];
        
        if ( var8 < var4 )
        {
            break;
        }
        
        if ( !isdefined( var7 ) || scripts\mp\gametypes\br_public::updatelootleadersonfixedinterval( var7 ) )
        {
            continue;
        }
        
        if ( !isdefined( var3[ var7.team ] ) )
        {
            var3 = [];
        }
        
        if ( var3[ var7.team ].size >= level.íOËV[≠Ö—¨∆ˆˆ£± ∞»V…['÷±∑’sé )
        {
            continue;
        }
        
        var3[ var3[ var7.team ].size ] = var7;
    }
    
    foreach ( var11 in level.teamnamelist )
    {
        if ( !isdefined( level.ô
ÄSnX˘m±w0≥Âb/⁄∏@À∆[ var11 ] ) )
        {
            continue;
        }
        
        var12 = var3[ var11 ];
        var13 = [];
        var14 = gettime();
        
        for ( var15 = 0; var15 < level.ô
ÄSnX˘m±w0≥Âb/⁄∏@À∆[ var11 ].size ; var15++ )
        {
            var16 = level.ô
ÄSnX˘m±w0≥Âb/⁄∏@À∆[ var11 ][ var15 ];
            
            if ( isdefined( var16.nextupdatetime ) && var16.nextupdatetime >= var14 )
            {
                continue;
            }
            
            if ( isdefined( var16.player ) )
            {
                var17 = 1;
                
                if ( isdefined( var12 ) && scripts\engine\utility::array_contains( var12, var16.player ) )
                {
                    if ( isdefined( var16.player.ß˚€πUŸ#ÒÈù∫!–∑ˇb0'Ç∂R-Éˇ ) && var16.player.ß˚€πUŸ#ÒÈù∫!–∑ˇb0'Ç∂R-Éˇ == var15 )
                    {
                        var17 = 0;
                    }
                }
                
                if ( var17 )
                {
                    var16.player.ß˚€πUŸ#ÒÈù∫!–∑ˇb0'Ç∂R-Éˇ = undefined;
                    var16.player = undefined;
                }
            }
            
            if ( !isdefined( var16.player ) )
            {
                scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var16.objectiveiconid );
                var13 = var15;
            }
        }
        
        if ( !isdefined( var12 ) )
        {
            continue;
        }
        
        var18 = 1000;
        
        foreach ( var7 in var12 )
        {
            if ( !isdefined( var7 ) )
            {
                continue;
            }
            
            if ( isdefined( var7.ß˚€πUŸ#ÒÈù∫!–∑ˇb0'Ç∂R-Éˇ ) )
            {
                continue;
            }
            
            if ( var13.size > 0 )
            {
                var20 = var13[ 0 ];
                var16 = level.ô
ÄSnX˘m±w0≥Âb/⁄∏@À∆[ var11 ][ var20 ];
                scripts\mp\objidpoolmanager::update_objective_onentity( var16.objectiveiconid, var7 );
                scripts\mp\objidpoolmanager::objective_teammask_addtomask( var16.objectiveiconid, var11 );
                var16.nextupdatetime = var14 + var18;
                var7.ß˚€πUŸ#ÒÈù∫!–∑ˇb0'Ç∂R-Éˇ = var20;
                var16.player = var7;
                var13 = scripts\engine\utility::array_remove( var13, var20 );
                continue;
            }
            
            break;
        }
    }
}

// Params 0
// Size: 0x46
function get_valid_seats()
{
    self attach( "accessory_money_bag_large_closed_player", "tag_stowed_back3", 1, 1 );
    self.carriable_set_dropped = "accessory_money_bag_large_closed_player";
    
    if ( self tagexists( "j_bag_left" ) )
    {
        playfxontag( level._effect[ "vfx_br_cashLeaderBag" ], self, "j_bag_left" );
    }
    
    thread get_type_to_drop();
}

// Params 0
// Size: 0x4f
function get_valid_starting_station_name_on_track()
{
    if ( isdefined( self ) && isdefined( self.carriable_set_dropped ) )
    {
        if ( self tagexists( "j_bag_left" ) )
        {
            killfxontag( level._effect[ "vfx_br_cashLeaderBag" ], self, "j_bag_left" );
        }
        
        self detach( self.carriable_set_dropped, "tag_stowed_back3" );
        self.carriable_set_dropped = undefined;
    }
    
    self notify( "killthread_bagModelSwap" );
}

// Params 0
// Size: 0x25
function get_type_to_drop()
{
    self notify( "cashleader_trackDeath" );
    self endon( "cashleader_trackDeath" );
    self endon( "killthread_bagModelSwap" );
    self waittill( "death" );
    get_valid_starting_station_name_on_track();
}

// Params 0
// Size: 0x4f
function get_unique_id()
{
    level endon( "game_ended" );
    self notify( "cashleader_trackVehicleEnter" );
    self endon( "cashleader_trackVehicleEnter" );
    self endon( "death" );
    get_valid_starting_station_name_on_track();
    self waittill( "player_vehicle_exit" );
    
    if ( isdefined( self ) && isdefined( level.ref_11a32 ) && scripts\engine\utility::array_contains( level.ref_11a32, self ) )
    {
        get_valid_seats();
        return;
    }
}

// Params 1
// Size: 0x95
function ref_121b6( var0 )
{
    var1 = scripts\mp\utility\game::round_vehicle_logic();
    
    if ( var1 == "kingslayer" || var1 == "payload" || var1 == "mendota" )
    {
        return;
    }
    
    var2 = 0;
    var3 = 0;
    
    if ( isdefined( self.plundercount ) )
    {
        var3 += self.plundercount;
    }
    
    if ( isdefined( self.plunderbanked ) )
    {
        var3 += self.plunderbanked;
    }
    
    var3 = int( var3 / 10 );
    
    if ( var3 > 4095 )
    {
        var3 = 4095;
    }
    
    var2 = var3;
    var4 = 0;
    
    if ( isdefined( self.ref_11c4f ) )
    {
        var4 += self.ref_11c4f;
    }
    
    if ( var4 > 15 )
    {
        var4 = 15;
    }
    
    var2 += var4 << 12;
    scripts\mp\utility\stats::setextrascore0( var2 );
}

// Params 0
// Size: 0x69
function ref_121b4()
{
    var0 = 0;
    var1 = 0;
    
    if ( isdefined( self.plundercount ) )
    {
        var1 += self.plundercount;
    }
    
    if ( isdefined( self.plunderbanked ) )
    {
        var1 += self.plunderbanked;
    }
    
    var1 = int( var1 / 10 );
    
    if ( var1 > 4095 )
    {
        var1 = 4095;
    }
    
    var0 = var1;
    var2 = 0;
    
    if ( isdefined( self.ref_11c4f ) )
    {
        var2 += self.ref_11c4f;
    }
    
    if ( var2 > 15 )
    {
        var2 = 15;
    }
    
    var0 += var2 << 12;
    return var0;
}

// Params 0
// Size: 0x32
function ref_12601()
{
    self endon( "disconnect" );
    
    if ( isdefined( level.ref_11a32 ) && scripts\engine\utility::array_contains( level.ref_11a32, self ) )
    {
        scripts\mp\hud_message::showsplash( "bm_player_marked" );
        get_valid_seats();
        return;
    }
}

// Params 1
// Size: 0x73
function ref_13fef( var0 )
{
    if ( isdefined( var0.targetplayer.plundercount ) )
    {
        var1 = var0.targetplayer.plundercount;
    }
    else
    {
        var1 = 0;
    }
    
    var1 = clamp( var1, level.ref_11a30, level.ref_11a2e );
    var2 = level.ref_11a2e - level.ref_11a30;
    var3 = ( var1 - level.ref_11a30 ) / var2;
    var4 = level.ref_11a2f - level.ref_11a2d;
    var5 = level.ref_11a2f - var3 * var4;
    var1 scripts\mp\gametypes\br_quest_util::ref_1316f( var5 );
}

// Params 1
// Size: 0xa4
function binoculars_checkpendingtimer( var0 )
{
    var1 = 0;
    var0 = scripts\mp\gamescore::run_common_functions_stealth();
    var2 = safehouse_regroup();
    
    for ( var3 = 1; var3 < level.ref_11b62 + 1 ; var3++ )
    {
        foreach ( var5 in level.teamnamelist )
        {
            if ( level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent( var5 ) )
            {
                continue;
            }
            
            if ( var0[ var5 ] != var3 )
            {
                continue;
            }
            
            var6 = run_blima_exfil_sequence( var5 ) * 100;
            
            if ( var6 >= var2 || var0[ var5 ] == 1 )
            {
                var1++;
            }
        }
    }
    
    if ( var1 > level.ref_11b62 )
    {
        var1 = level.ref_11b62;
    }
    
    return var1;
}

// Params 2
// Size: 0x149
function longdeathtracker( var0, var1 )
{
    var2 = 0;
    var3 = 0;
    var4 = 20;
    var1 *= 100;
    var5 = var0.plundercount * 100;
    var6 = var5 + var1;
    var7 = var6;
    var8 = var5;
    var9 = var8 - var6;
    var10 = scripts\engine\utility::sign( var9 );
    var11 = var9 / 2;
    var12 = int( var11 * 2 * level.framedurationseconds );
    
    if ( var12 == 0 )
    {
        return;
    }
    
    var13 = init_relic_trex( &"MP_BR_INGAME/PLUNDER_DEATH_LOSS", var1, "RIGHT", "CENTER", var2 + 46, var3, undefined, undefined, 1.25, var0 );
    var13.alpha = 1;
    var14 = init_relic_trex( &"MP_BR_INGAME/YOUR_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", var2, var3 + var4, undefined, undefined, 1.25, var0 );
    var14.alpha = 1;
    var15 = init_relic_trex( &"MP_BR_INGAME/EXTRACT_PLUNDER", var6, "LEFT", "CENTER", var2 + 45, var3 + var4, undefined, undefined, 1.25, var0 );
    var15.alpha = 1;
    wait 1;
    
    while ( var7 != var8 )
    {
        var7 += var12;
        
        if ( var10 > 0 && var7 > var8 || var10 < 0 && var7 < var8 )
        {
            var7 = var8;
        }
        
        var15 setvalue( var7 );
        wait level.framedurationseconds;
    }
    
    wait 3;
    var13 destroy();
    var14 destroy();
    var15 destroy();
}

// Params 0
// Size: 0x2
function activate_station()
{
    
}

// Params 3
// Size: 0x265
function ai_shooting_timer( var0, var1, var2 )
{
    if ( var0.size == 0 || var1 == 0 )
    {
        return;
    }
    
    var3 = [];
    var4 = [];
    
    if ( var0.size > 0 )
    {
        var0 = scripts\engine\utility::array_randomize( var0 );
        var4 = int( min( var1, var0.size ) );
    }
    
    if ( level.ref_1323e )
    {
        var5 = 0;
        jumpiffalse(level.binoculars_checkexpirationtimer > 0 && istrue( var2 )) LOC_000000d8;
        var6 = 0;
        
        for ( var7 = 0; var7 < var4 ; var7++ )
        {
            if ( var6 > level.ref_121bb.size - 1 )
            {
                var6 = 0;
            }
            
            var8 = level.ref_121bb[ var6 ];
            
            foreach ( var10 in var0 )
            {
                if ( ref_127dd( var10.origin, var8, level.ref_127de ) )
                {
                    var3 = var10;
                    var0 = scripts\engine\utility::array_remove( var0, var10 );
                    break;
                }
            }
            
            var6++;
        }
        
        goto LOC_000001e2;
    }
    else if ( var4.size > 0 )
    {
        var4 = scripts\engine\utility::array_randomize( var4 );
        var8 = int( min( var5, var4.size ) );
        
        for ( var7 = 0; var7 < var8 ; var7++ )
        {
            var7 = var4[ var7 ];
        }
    }
    
    if ( istrue( level.spawn_boss_wave_suicidebombers ) )
    {
        foreach ( var21 in var4 )
        {
            if ( !scripts\engine\utility::array_contains( var7, var21 ) )
            {
                var21 setscriptablepartstate( var21.type, "hidden" );
            }
        }
    }
    
    return var7;
}

// Params 3
// Size: 0x44, Type: bool
function ref_127dd( var0, var1, var2 )
{
    var3 = var1[ 0 ] - var2;
    var4 = var1[ 0 ] + var2;
    var5 = var1[ 1 ] - var2;
    var6 = var1[ 1 ] + var2;
    return var0[ 0 ] >= var3 && var0[ 0 ] <= var4 && var0[ 1 ] >= var5 && var0[ 1 ] <= var6;
}

// Params 2
// Size: 0x53
function ai_weapons_free( var0, var1 )
{
    if ( var0.size == 0 || var1 == 0 )
    {
        return;
    }
    
    var2 = undefined;
    
    if ( var0.size > 0 )
    {
        var0 = scripts\engine\utility::array_randomize( var0 );
        
        for ( var3 = 0; var3 < var0.size ; var3++ )
        {
            if ( !scripts\engine\utility::array_contains( level.br_plunder_sites, var0[ var3 ] ) )
            {
                var2 = var0[ var3 ];
                break;
            }
        }
    }
    
    return var2;
}

// Params 1
// Size: 0xdc
function play_tape_machine_animations( var0 )
{
    var1 = ai_weapons_free( scripts\mp\gametypes\br_plunder::register_vfx(), level.ref_11b6d );
    var1.disabled = undefined;
    var1.snapshot_crate_player_at_max_ammo = undefined;
    var2 = scripts\engine\utility::ter_op( level.ref_13368 && !level.ref_13363, var1.audio_jugg_spawn, var1.audio_shf_kill_hangar_lights );
    var1 setscriptablepartstate( var1.type, var2 );
    
    if ( level.ref_13368 && level.ref_13363 )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var0.locale.objectiveiconid );
        var0.locale.objectiveiconid = -1;
        var3 = spawnstruct();
        init_tape_machine_animations( var3, "ui_mp_br_mapmenu_icon_atm", "current", var1.origin + ( 0, 0, 200 ) );
        var1.locale = var3;
    }
    
    level.br_plunder_sites = scripts\engine\utility::array_remove( level.br_plunder_sites, var0 );
    level.br_plunder_sites = scripts\engine\utility::array_add( level.br_plunder_sites, var1 );
}

// Params 0
// Size: 0x98
function ref_1386c()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    waitframe();
    
    foreach ( var1 in level.br_plunder_sites )
    {
        var1.disabled = undefined;
        var2 = scripts\engine\utility::ter_op( level.ref_13368 && !level.ref_13363, var1.audio_jugg_spawn, var1.audio_shf_kill_hangar_lights );
        var1 setscriptablepartstate( var1.type, var2 );
        thread ref_12e1e();
        
        if ( level.ref_13368 && level.ref_13363 )
        {
            thread ref_13b86();
        }
    }
    
    thread ref_12e0e();
}

// Params 0
// Size: 0x25
function ref_12e1e()
{
    wait level.ref_13b85;
    self.disabled = 1;
    self.snapshot_crate_player_at_max_ammo = 1;
    self setscriptablepartstate( self.type, self.load_relics_from_playlistdvars );
}

// Params 0
// Size: 0x3d
function ref_12e0e()
{
    wait level.ref_13b85 + 1;
    level.br_plunder_sites = ai_shooting_timer( scripts\mp\gametypes\br_plunder::register_vfx(), level.ref_11b6d );
    
    if ( level.ref_13368 && level.ref_13363 )
    {
        thread init_relic_team_proximity();
    }
    
    thread ref_1386c();
}

// Params 0
// Size: 0x2
function activate_scout_drone()
{
    
}

// Params 0
// Size: 0x68
function init_relic_team_proximity()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( var1 in level.br_plunder_sites )
    {
        var2 = spawnstruct();
        init_tape_machine_animations( var2, "ui_mp_br_mapmenu_icon_atm", "current", var1.origin + ( 0, 0, 200 ) );
        var1.locale = var2;
    }
}

// Params 0
// Size: 0x71
function ref_13b86()
{
    var0 = level.ref_13b85;
    var1 = level.framedurationseconds;
    var2 = var1 * 1000;
    var3 = var0 * 1000;
    var4 = var3 - var2;
    var5 = gettime() + var3;
    
    while ( gettime() < var5 )
    {
        var6 = var4 / var3;
        scripts\mp\objidpoolmanager::objective_show_progress( self.objectiveiconid, 1 );
        scripts\mp\objidpoolmanager::objective_set_progress( self.objectiveiconid, var6 );
        var4 = max( var4 - var2, 1 );
        waitframe();
    }
    
    scripts\mp\objidpoolmanager::returnobjectiveid( self.objectiveiconid );
    self.objectiveiconid = -1;
}

// Params 3
// Size: 0x69
function init_tape_machine_animations( var0, var1, var2 )
{
    self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( self.objectiveiconid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( self.objectiveiconid, var1, ( 0, 0, 0 ), var0 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( self.objectiveiconid, 1 );
        objective_showtoplayersinmask( self.objectiveiconid );
        scripts\mp\objidpoolmanager::objective_set_play_intro( self.objectiveiconid, 1 );
        
        if ( isdefined( var2 ) )
        {
            ref_11db0( var2 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x10
function ref_11db0( var0 )
{
    scripts\mp\objidpoolmanager::update_objective_position( self.objectiveiconid, var0 );
}

// Params 1
// Size: 0xe
function ref_1336c( var0 )
{
    objective_addclienttomask( self.objectiveiconid, var0 );
}

// Params 1
// Size: 0x9
function ref_1336b( var0 )
{
    objective_addalltomask( var0 );
}

// Params 1
// Size: 0xe
function spawn_downed_friendly( var0 )
{
    objective_removeclientfrommask( self.objectiveiconid, var0 );
}

// Params 0
// Size: 0x18
function lastdropedtime()
{
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
    scripts\mp\objidpoolmanager::returnobjectiveid( self.objectiveiconid );
}

// Params 0
// Size: 0x2
function achievement_id()
{
    
}

// Params 1
// Size: 0x41
function ref_13839( var0 )
{
    ref_1314a( level );
    thread ref_13353( level );
    
    if ( level.ref_13abc )
    {
        thread ref_13881( level );
    }
    
    if ( level.ref_13aba )
    {
        thread ref_12c13();
    }
    
    thread ref_13847();
    thread ref_11ef5( level );
}

// Params 0
// Size: 0x51
function ref_1314a()
{
    scripts\mp\gamelogic::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    var0 = getdvarfloat( "scr_bmo_exfil_timer", 180 );
    var1 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
    level.watchdvars[ var1 ].value = var0;
    level.overridewatchdvars[ var1 ] = var0;
}

// Params 1
// Size: 0x72
function ref_13353( var0 )
{
    foreach ( var2 in level.teamnamelist )
    {
        scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_requested", var2 );
    }
    
    foreach ( var5 in level.players )
    {
        var5 thread scripts\mp\hud_message::showsplash( "callout_bmo_exfil_winners" );
        var5 scripts\mp\utility\lower_message::setlowermessageomnvar( 71, undefined, 20 );
    }
}

// Params 1
// Size: 0x2d
function ref_13881( var0 )
{
    level.radarmode[ var0 ] = "normal_radar";
    level.activeuavs[ var0 ] = 1;
    level.activeadvanceduavs[ var0 ] = 0;
    scripts\cp_mp\killstreaks\uav::_setteamradarstrength( var0, 4 );
}

// Params 0
// Size: 0x2f
function ref_12c13()
{
    level.ref_11a27 = 1;
    
    if ( getdvarint( "scr_dmz_loot_leader_update_on_pickup", 0 ) == 1 )
    {
        if ( level.ref_11a37 > 0 )
        {
            thread ref_13ff1();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0xd5
function ref_13847()
{
    foreach ( var1 in level.br_plunder_sites )
    {
        var1 setscriptablepartstate( var1.type, "inuse" );
        var2 = getgroundposition( var1.origin, 1 ) + ( 0, 0, 2 );
        var3 = level.players[ 0 ];
        
        for ( var4 = 0; var4 < 200 ; var4++ )
        {
            var3 = play_quarry_intro_vo();
            
            if ( isplayer( var3 ) )
            {
                break;
            }
        }
        
        var2 = getgroundposition( var1.origin, 1 ) + ( 0, 0, 2 );
        var5 = ref_126a8( var3, var2, var1 );
        
        if ( isdefined( var5 ) )
        {
            var5.site = var1;
            var1.heli = var5;
            helicreateextractvfx( var5, var2 );
            thread outro_main();
        }
    }
}

// Params 2
// Size: 0x82
function ref_126a8( var0, var1 )
{
    var2 = var0;
    var3 = var2 + ( 0, 0, 2500 );
    var4 = play_skit_and_watch_for_endons( var3, var1 );
    var5 = ( 0, var4, 0 );
    
    if ( getdvarint( "scr_br_plunder_heli_adjust_bag", 1 ) == 1 )
    {
        var6 = -100;
        var7 = 60;
        var8 = anglestoforward( var5 );
        var9 = anglestoright( var5 );
        var2 = var2 + var8 * var6 + var9 * var7;
    }
    
    var10 = var3 + -1 * anglestoforward( var5 ) * 30000;
    var11 = var3 + anglestoforward( var5 ) * 30000;
    var12 = spawnheli( self, var10, var3, var11 );
    return var12;
}

// Params 0
// Size: 0x11d
function outro_main()
{
    self endon( "death" );
    self endon( "leaving" );
    self setvehgoalpos( self.pathgoal, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    var0 = ref_13c30( self.pathgoal );
    var1 = self.pathgoal[ 2 ] - var0;
    self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo( var1 );
    sortplayerplunderscores( 1, self.player_weapon_fired_monitor );
    self waittill( "goal" );
    
    foreach ( var3 in level.players )
    {
        var3 scripts\mp\utility\lower_message::setlowermessageomnvar( 72, undefined, 20 );
    }
    
    thread heliwatchgameendleave();
    thread snapshot_crate_spawn();
    helidescend( self.endpoint, var0 );
    
    foreach ( var6 in level.teamnamelist )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_chopper_arrive", var6, 1 );
    }
    
    soldier_agent_lwfn0();
    helicleanupextract();
    
    foreach ( var6 in level.teamnamelist )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_chopper_leave", var6, 1 );
    }
    
    thread sol_3_4_pool();
}

// Params 0
// Size: 0xb2
function soldier_agent_lwfn0()
{
    self.isdepot = 1;
    self.usable = self.crate;
    var0 = self.usable;
    var0 makeusable();
    var0 setcursorhint( "HINT_NOICON" );
    var0 setuseholdduration( "duration_medium" );
    var0 sethintrequiresholding( 1 );
    var0 setuserange( 230 );
    var0 sethintstring( &"MP/BR_USE_EXFIL_CHOPPER" );
    var1 = level.br_depots.size;
    level.br_depots[ var1 ] = var0;
    
    foreach ( var3 in level.players )
    {
        if ( !isdefined( var3 ) )
        {
        }
    }
    
    thread helicleanupdepotonleaving();
    thread snowballfight( var0 );
    sortplayerplunderscores( 2, 300 );
    wait 300;
    self.isdepot = 0;
    heliusecleanup();
}

// Params 1
// Size: 0x9b
function snowballfight( var0 )
{
    self endon( "death" );
    var0 endon( "death" );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        var1 scripts\mp\hud_message::showsplash( "callout_exfil_success" );
        var1 playerhide();
        var1 vehiclepinonminimap( 0 );
        var1 allowmovement( 0 );
        var1 allowfire( 0 );
        var1 disableoffhandprimaryweapons( 0 );
        var1 disableoffhandsecondaryweapons( 0 );
        var1 disableweapons( 0 );
        var1 disableweaponswitch( 0 );
        var1 setcamerathirdperson( 1 );
        var1 allowcrouch( 0 );
        var1 allowmelee( 0 );
        var1 allowjump( 0 );
        var1 allowprone( 0 );
        var1 scripts\common\utility::allow_killstreaks( 0 );
        var1 scripts\common\utility::allow_supers( 0 );
        var1.ref_12e54 = 1;
        var0 disableplayeruse( var1 );
    }
}

// Params 0
// Size: 0x64
function showquestcircletoplayer()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "swapped" );
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
        self.health = 99999;
    }
}

// Params 1
// Size: 0x23
function ref_13c30( var0 )
{
    var1 = 256;
    var2 = tracegroundpoint( var0, 100, [ self ] );
    var3 = var2[ 2 ];
    var4 = var3 + var1;
    return var4;
}

// Params 2
// Size: 0xb7
function play_skit_and_watch_for_endons( var0, var1 )
{
    if ( isdefined( var1 ) && isdefined( var1.player_respawn ) )
    {
        return var1.player_respawn;
    }
    
    var2 = 10;
    var3 = scripts\engine\trace::create_world_contents();
    var4 = 0;
    
    while ( var4 < 360 )
    {
        var5 = ( 0, var4, 0 );
        var6 = var0 + -1 * anglestoforward( var5 ) * 30000;
        var7 = var0 + anglestoforward( var5 ) * 30000;
        var8 = scripts\engine\trace::sphere_trace( var0, var7, 100, undefined, var3, 1 );
        
        if ( var8[ "fraction" ] == 1 )
        {
            if ( isdefined( var1 ) )
            {
                var1.player_respawn = var4;
            }
            
            return var4;
        }
        
        if ( var4 % 3 == 0 )
        {
            waitframe();
        }
        
        var4 += var2;
    }
    
    var4 = randomfloat( 360 );
    
    if ( isdefined( var1 ) )
    {
        var1.player_respawn = var4;
    }
    
    return var4;
}

// Params 1
// Size: 0xb4
function ref_11ef5( var0 )
{
    level notify( "mercy_ending_timer_started" );
    level endon( "mercy_ending_triggered" );
    _calloutmarkerping_handleluinotify_added::ref_13191( "ui_nuke_data", 9, 2, 1 );
    _calloutmarkerping_handleluinotify_added::ref_13191( "ui_nuke_data", 0, 9, level.ref_13abb );
    _calloutmarkerping_handleluinotify_added::ref_13191( "ui_nuke_data", 11, 1, 1 );
    var1 = gettime();
    var2 = level.ref_13abb * 1000 + var1;
    setomnvar( "ui_nuke_end_milliseconds", level.ref_13abb * 1000 + var1 );
    
    for ( ;; )
    {
        waitframe();
        
        if ( gettime() > var2 )
        {
            break;
        }
    }
    
    level thread scripts\mp\gamelogic::endgame( var0, game[ "end_reason" ][ "dmz_plunder_win" ], game[ "end_reason" ][ "dmz_plunder_loss" ], 0, 1 );
    _calloutmarkerping_handleluinotify_added::ref_13191( "ui_nuke_data", 11, 1, 0 );
}

// Params 0
// Size: 0x2
function activate_gas_trap_cloud_parent()
{
    
}

// Params 3
// Size: 0x21d
function ref_13dc8( var0, var1, var2 )
{
    if ( istrue( level.convoy_handle_stuck_compromise ) )
    {
        if ( istrue( level.chopperexif_fx_init ) && istrue( var1 ) )
        {
            thread convoy_anim_sequence();
        }
        
        return;
    }
    
    level.convoy_handle_stuck_compromise = 1;
    level notify( "cancel_announcer_dialog" );
    thread scripts\mp\music_and_dialog::ref_12792();
    scripts\mp\gametypes\br_publicevents::generic_waittill_button_press();
    thread ref_12192();
    var3 = scripts\engine\utility::ter_op( level.ref_12192 >= 1, "bm_overtime_double_cash_num", "bm_overtime_double_cash_perc" );
    
    if ( isdefined( var0 ) && ( level.locale_defaults || !level.loadout_updatebrammo ) )
    {
        level.time_before_shoot = var0;
        ref_13372( var0, "bm_overtime_start_them" );
        showsplashtoteam( var0, "bm_overtime_start_us" );
        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "bm_gamestate_overtime", var0 );
        
        foreach ( var5 in level.teamnamelist )
        {
            if ( var5 != var0 )
            {
                level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "bm_gamestate_overtime_enemy", var5 );
            }
        }
    }
    else
    {
        level.time_before_shoot = remove_padding_damage();
    }
    
    if ( !isdefined( var2 ) )
    {
        scripts\mp\gamelogic::resumetimer();
        level.starttime = gettime();
        level.discardtime = 0;
        level.timerpausetime = 0;
        var7 = scripts\engine\utility::ter_op( level.loadout_updatebrammo || istrue( var2 ), 7, 12 );
        var8 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
        level.watchdvars[ var8 ].value = var7;
        level.overridewatchdvars[ var8 ] = var7;
        
        if ( !level.loadout_updatebrammo )
        {
            wait 5;
        }
        
        scripts\mp\gametypes\br_gametype_dmz::ref_13371( var3 );
        wait 5;
        level.ontimelimitgraceperiod = level.make_bomb_detonator_interact;
        level.currenttimelimitdelay = 0;
        level.canprocessot = 1;
        level notify( "bmo_overtime_start" );
    }
    else
    {
        level.ontimelimitgraceperiod = level.make_bomb_detonator_interact;
        level.currenttimelimitdelay = 0;
        level.canprocessot = 1;
        level notify( "bmo_overtime_start" );
        level.playerparachutedetachresetomnvars = 1;
        level.playerplaygestureweaponanim = 1;
        scripts\mp\gametypes\br_gametype_dmz::ref_13371( var3 );
        wait 5;
    }
    
    level.playerparachutedetachresetomnvars = undefined;
    scripts\mp\flags::gameflagwait( "overtime_started" );
    setomnvar( "ui_br_circle_state", 7 );
    var9 = gettime() + int( level.make_bomb_detonator_interact * 1000 );
    setomnvar( "ui_hardpoint_timer", var9 );
    wait int( max( level.make_bomb_detonator_interact - getdvarint( "scr_rat_race_ot_ending_wait" ), 60 ) );
    setomnvar( "ui_br_circle_state", 8 );
}

// Params 0
// Size: 0x4c
function remove_padding_damage()
{
    var0 = "";
    
    foreach ( var2 in level.teamnamelist )
    {
        var3 = game[ "teamPlacements" ][ var2 ];
        
        if ( var3 == 1 )
        {
            var0 = var2;
            break;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x7c
function ontimelimit()
{
    if ( level.ref_13abd && level.make_bomb_detonator_interact > 0 && !istrue( level.convoy_handle_stuck_compromise ) )
    {
        if ( !isdefined( level.time_before_shoot ) )
        {
            level.time_before_shoot = remove_padding_damage();
        }
        
        thread ref_13dc8( level, level.time_before_shoot );
        level waittill( "bmo_overtime_start" );
        
        while ( level.currenttimelimitdelay < level.ontimelimitgraceperiod )
        {
            wait level.framedurationseconds;
        }
    }
    
    thread convoy_anim_sequence();
}

// Params 0
// Size: 0x42
function convoy_anim_sequence()
{
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    thread setup_heli_starts_deep();
    level thread scripts\mp\gamelogic::endgame( level.disable_super_in_turret.player_enemy_cooldown, game[ "end_reason" ][ "dmz_plunder_win" ], game[ "end_reason" ][ "dmz_plunder_loss" ], 0, 1 );
}

// Params 0
// Size: 0x3a
function setup_heli_starts_deep()
{
    var0 = scripts\mp\gamelogic::reinforcement_icon_objective_id();
    
    foreach ( var2 in level.players )
    {
        var2 _calloutmarkerping_handleluinotify_added::ref_13133( "post_game_state", var0 );
    }
}

// Params 0
// Size: 0xac, Type: bool
function ref_126a6()
{
    if ( !istrue( self.controlsfrozen ) )
    {
        scripts\mp\utility\player::_freezecontrols( 1, undefined, "spawnEndOfGame" );
    }
    
    var0 = spawnstruct();
    var1 = self getspectatingplayer();
    
    if ( !isdefined( var1 ) )
    {
        var1 = self;
    }
    
    var0.origin = var1.origin;
    var0.angles = var1.angles;
    
    if ( !var1 isonground() )
    {
        var2 = scripts\engine\trace::create_default_contents( 1 );
        var0.origin = scripts\engine\utility::drop_to_ground( var0.origin, 0, -20000, undefined, var2 );
    }
    
    var0.origin += ( 0, 0, 100 );
    
    if ( !isdefined( level.needs_antenna ) )
    {
        level.needs_antenna = 1;
        thread ref_13db9();
    }
    
    return true;
}

// Params 0
// Size: 0x2e2
function numextractions()
{
    level waittill( "give_match_bonus" );
    waitframe();
    var0 = getdvarfloat( "scr_bmo_eom_held_cash_scalar", 1 );
    var1 = getdvarfloat( "scr_bmo_eom_banked_cash_scalar", 1 );
    var2 = getdvarint( "scr_bmo_eom_initial_winner_bonus", 10000 );
    var3 = getdvarint( "scr_bmo_eom_over_wincost_bonus", 7500 );
    var4 = getdvarint( "scr_bmo_eom_top10_bonus", 5000 );
    
    foreach ( var6 in level.teamnamelist )
    {
        if ( level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent( var6 ) )
        {
            continue;
        }
        
        var7 = run_blima_exfil_sequence( var6 ) * 100;
        var8 = var7 >= safehouse_regroup();
        var9 = game[ "teamPlacements" ][ var6 ];
        var10 = 0;
        
        if ( var8 )
        {
            var10 = var3;
        }
        else if ( var9 <= 10 )
        {
            var10 = var4;
        }
        
        var11 = scripts\mp\utility\teams::getteamdata( var6, "players" );
        
        foreach ( var13 in var11 )
        {
            var13 scripts\mp\gametypes\br::ref_138d6();
            var13 scripts\cp_mp\utility\game_utility::ref_13168( var9 );
            
            if ( !var13 scripts\mp\utility\game::rankingenabled() || !var13 hasplayerdata() )
            {
                continue;
            }
            
            var13 scripts\mp\utility\stats::incpersstat( "cash", int( var7 / 10000 ) );
            var14 = var13.pers[ "combatXP" ];
            
            if ( !isdefined( var14 ) )
            {
                var14 = 0;
            }
            
            var13 setplayerdata( "mp", "aarValue", 0, var14 );
            var15 = var13.pers[ "missionXP" ];
            
            if ( !isdefined( var15 ) )
            {
                var15 = 0;
            }
            
            var13 setplayerdata( "mp", "aarValue", 1, var15 );
            var16 = var13.pers[ "lootingXP" ];
            
            if ( !isdefined( var16 ) )
            {
                var16 = 0;
            }
            
            var13 setplayerdata( "mp", "aarValue", 2, var16 );
            var17 = 0;
            
            if ( isdefined( var13.plundercount ) )
            {
                var17 = int( var13.plundercount * var0 );
            }
            
            var18 = 0;
            
            if ( isdefined( var13.plunderbanked ) )
            {
                var18 = int( var13.plunderbanked * var1 );
            }
            
            var19 = var17 + var18;
            
            if ( var19 > 0 )
            {
                var13 scripts\mp\rank::giverankxp( "cash_conversion_bonus", var19, undefined, 1, 1 );
            }
            
            var13 setplayerdata( "mp", "aarValue", 3, var19 );
            var20 = 0;
            
            if ( isdefined( var13.matchbonus ) )
            {
                var20 = int( var13.matchbonus );
            }
            
            var13 setplayerdata( "mp", "aarValue", 4, var20 );
            
            if ( var10 > 0 )
            {
                var13 scripts\mp\rank::giverankxp( "placement_bonus", var10, undefined, 1, 1 );
            }
            
            var13 setplayerdata( "mp", "aarValue", 5, var10 );
            var21 = var13 getplayerdata( "mp", "aarValue", 6 );
            var22 = var21 + var13.pers[ "summary" ][ "xp" ];
            var13 setplayerdata( "mp", "aarValue", 7, var22 );
        }
    }
}

// Params 0
// Size: 0x2
function activate_gas_trap_cloud()
{
    
}

// Params 0
// Size: 0x4a2
function test_pipe_fire()
{
    var0 = [];
    level.mp_m_trench_patch = [];
    level.mp_m_speedball_patch = [];
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        level.mp_m_trench_patch[ 0 ] = ( 8682, -1036, 427 );
        level.mp_m_speedball_patch[ 0 ] = ( 14, 163, 0 );
        level.mp_m_trench_patch[ 1 ] = ( -1139, -3425, 1116 );
        level.mp_m_speedball_patch[ 1 ] = ( 33, 75, 0 );
        level.mp_m_trench_patch[ 2 ] = ( -5567, -4786, 1116 );
        level.mp_m_speedball_patch[ 2 ] = ( 37, 192, 0 );
    }
    else
    {
        level.mp_m_trench_patch[ 0 ] = ( -36548, -31983, 2400 );
        level.mp_m_speedball_patch[ 0 ] = ( 12, 72, 0 );
        level.mp_m_trench_patch[ 1 ] = ( -17592, -36440, 1379 );
        level.mp_m_speedball_patch[ 1 ] = ( 17, 90, 0 );
        level.mp_m_trench_patch[ 2 ] = ( -3520, -34298, 1217 );
        level.mp_m_speedball_patch[ 2 ] = ( 11, 110, 0 );
        level.mp_m_trench_patch[ 3 ] = ( -9577, -25957, 360 );
        level.mp_m_speedball_patch[ 3 ] = ( 357, 82, 0 );
        level.mp_m_trench_patch[ 4 ] = ( 23022, -26926, 1359 );
        level.mp_m_speedball_patch[ 4 ] = ( 16, 101, 0 );
        level.mp_m_trench_patch[ 5 ] = ( 31261, -29753, 1359 );
        level.mp_m_speedball_patch[ 5 ] = ( 27, 52, 0 );
        level.mp_m_trench_patch[ 6 ] = ( 44843, -41261, 3220 );
        level.mp_m_speedball_patch[ 6 ] = ( 16, 52, 0 );
        level.mp_m_trench_patch[ 7 ] = ( 44229, -15403, 1331 );
        level.mp_m_speedball_patch[ 7 ] = ( 13, 72, 0 );
        level.mp_m_trench_patch[ 8 ] = ( 44491, 3484, 1638 );
        level.mp_m_speedball_patch[ 8 ] = ( 23, 11, 0 );
        level.mp_m_trench_patch[ 9 ] = ( 16047, -3206, 2613 );
        level.mp_m_speedball_patch[ 9 ] = ( 27, 309, 0 );
        level.mp_m_trench_patch[ 10 ] = ( 5668, -5905, 1614 );
        level.mp_m_speedball_patch[ 10 ] = ( 23, 304, 0 );
        level.mp_m_trench_patch[ 11 ] = ( -13412, -20443, 1033 );
        level.mp_m_speedball_patch[ 11 ] = ( 11, 109, 0 );
        level.mp_m_trench_patch[ 12 ] = ( -30369, -7811, 1680 );
        level.mp_m_speedball_patch[ 12 ] = ( 31, 339, 0 );
        level.mp_m_trench_patch[ 13 ] = ( -26278, 4081, 142 );
        level.mp_m_speedball_patch[ 13 ] = ( 6, 110, 0 );
        level.mp_m_trench_patch[ 14 ] = ( -16429, 6021, 847 );
        level.mp_m_speedball_patch[ 14 ] = ( 21, 57, 0 );
        level.mp_m_trench_patch[ 15 ] = ( -7525, 11672, 1082 );
        level.mp_m_speedball_patch[ 15 ] = ( 14, 46, 0 );
        level.mp_m_trench_patch[ 16 ] = ( 8356, 15296, 2021 );
        level.mp_m_speedball_patch[ 16 ] = ( 12, 38, 0 );
        level.mp_m_trench_patch[ 17 ] = ( 26010, 29975, 2716 );
        level.mp_m_speedball_patch[ 17 ] = ( 13, 68, 0 );
        level.mp_m_trench_patch[ 18 ] = ( 12043, 30910, 3081 );
        level.mp_m_speedball_patch[ 18 ] = ( 21, 88, 0 );
        level.mp_m_trench_patch[ 19 ] = ( 7127, 52592, 2100 );
        level.mp_m_speedball_patch[ 19 ] = ( 28, 241, 0 );
        level.mp_m_trench_patch[ 20 ] = ( -6693, 56481, 4026 );
        level.mp_m_speedball_patch[ 20 ] = ( 16, 246, 0 );
        level.mp_m_trench_patch[ 21 ] = ( -21394, 37175, 757 );
        level.mp_m_speedball_patch[ 21 ] = ( 2, 124, 0 );
        level.mp_m_trench_patch[ 22 ] = ( -26151, 25577, 271 );
        level.mp_m_speedball_patch[ 22 ] = ( 357, 10, 0 );
    }
    
    if ( false )
    {
        mp_m_stack_patch();
        return;
    }
}

// Params 0
// Size: 0x4c
function ref_13db9()
{
    var0 = 0;
    
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) )
        {
            thread ref_12753( var2, var2 );
            var0++;
        }
        
        if ( var0 == 5 )
        {
            waitframe();
            var0 = 0;
        }
    }
}

// Params 0
// Size: 0x3e
function mp_m_stack_patch()
{
    for ( ;; )
    {
        var0 = getdvarint( "scr_bmo_testEndCamera", -1 );
        
        if ( var0 > -1 )
        {
            ref_12753( level.players[ 0 ], registerquestcategorytablevalues( level.players[ 0 ] ) );
            setdvar( "scr_bmo_testEndCamera", -1 );
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x5d
function registerquestcategorytablevalues( var0 )
{
    var1 = undefined;
    var2 = undefined;
    
    foreach ( var4 in level.mp_m_trench_patch )
    {
        var5 = distance2dsquared( var0.origin, var4 );
        
        if ( var5 <= 9000000 )
        {
            return var6;
        }
        
        if ( !isdefined( var2 ) || var2 > var5 )
        {
            var2 = var5;
            var1 = var6;
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x6e
function ref_12753( var0, var1 )
{
    var2 = level.mp_m_trench_patch[ var1 ];
    var3 = level.mp_m_speedball_patch[ var1 ];
    var4 = var2 + anglestoright( var3 ) * 1000;
    var5 = var3;
    var6 = spawn( "script_model", var2 );
    var6 setmodel( "tag_origin" );
    var6.angles = var3;
    var0 cameralinkto( var6, "tag_origin" );
    var6 moveto( var4, 60 );
    var6 rotateto( var5, 60 );
    
    if ( false )
    {
        wait 5;
        var0 cameraunlink();
        return;
    }
}

// Params 0
// Size: 0x51
function ref_12893()
{
    wait 1;
    var0 = safehouse_regroup();
    var1 = setteamplacement( game[ "teamPlacements" ], "up" );
    
    for ( var2 = 0; var2 < var1.size - 1 ; var2++ )
    {
        if ( isdefined( level.teamdata[ var1[ var2 ] ][ "plunderTeamTotal" ] ) )
        {
            var3 = run_blima_exfil_sequence( var1[ var2 ] ) * 100;
        }
    }
}

// Params 0
// Size: 0x3e1
function teleportplayertoselection()
{
    wait 1;
    game[ "dialog" ][ "gametype" ] = "gametype_bmo_plunder";
    game[ "dialog" ][ "match_start" ] = "gametype_bmo_plunder";
    game[ "dialog" ][ "boost_short" ] = "boost_bmo_short";
    game[ "dialog" ][ "offense_obj" ] = "boost_bmo";
    game[ "dialog" ][ "defense_obj" ] = "boost_bmo";
    game[ "dialog" ][ "contract_hold_area" ] = "bm_contract_hold_area";
    game[ "dialog" ][ "contract_loot_chests" ] = "bm_contract_loot_chests";
    game[ "dialog" ][ "contract_kill_target" ] = "bm_contract_kill_target";
    game[ "dialog" ][ "event_chopper" ] = "bm_event_chopper";
    game[ "dialog" ][ "event_airdrop" ] = "bm_event_airdrop";
    game[ "dialog" ][ "extract_enabled" ] = "bm_extract_enabled";
    game[ "dialog" ][ "gamestate_25_perc" ] = "bm_gamestate_25_perc";
    game[ "dialog" ][ "gamestate_50_perc" ] = "bm_gamestate_50_perc";
    game[ "dialog" ][ "gamestate_75_perc" ] = "bm_gamestate_75_perc";
    game[ "dialog" ][ "gamestate_90_perc" ] = "bm_gamestate_90_perc";
    game[ "dialog" ][ "gamestate_25_perc_enemy" ] = "bm_gamestate_25_perc_enemy";
    game[ "dialog" ][ "gamestate_50_perc_enemy" ] = "bm_gamestate_50_perc_enemy";
    game[ "dialog" ][ "gamestate_75_perc_enemy" ] = "bm_gamestate_75_perc_enemy";
    game[ "dialog" ][ "gamestate_90_perc_enemy" ] = "bm_gamestate_90_perc_enemy";
    game[ "dialog" ][ "gamestate_25_perc_first" ] = "bm_gamestate_25_perc_first";
    game[ "dialog" ][ "gamestate_50_perc_first" ] = "bm_gamestate_50_perc_first";
    game[ "dialog" ][ "gamestate_75_perc_first" ] = "bm_gamestate_75_perc_first";
    game[ "dialog" ][ "gamestate_90_perc_first" ] = "bm_gamestate_90_perc_first";
    game[ "dialog" ][ "lead_lost" ] = "bm_gamestate_lead_lost";
    game[ "dialog" ][ "lead_taken" ] = "bm_gamestate_lead_taken";
    game[ "dialog" ][ "mission_failure" ] = "bm_gamestate_lost";
    game[ "dialog" ][ "mission_success" ] = "bm_gamestate_win";
    game[ "dialog" ][ "gamestate_top_3" ] = "bm_gamestate_top_3";
    game[ "dialog" ][ "gamestate_top_5" ] = "bm_gamestate_top_5";
    game[ "dialog" ][ "gamestate_top_10" ] = "bm_gamestate_top_10";
    game[ "dialog" ][ "bm_gamestate_overtime" ] = "bm_gamestate_overtime_million_cash_deposited";
    game[ "dialog" ][ "bm_gamestate_overtime_enemy" ] = "bm_tut_get_cash";
    game[ "dialog" ][ "bm_tut_get_cash" ] = "bm_tut_get_cash";
    game[ "dialog" ][ "bm_tut_earn_cash" ] = "bm_tut_earn_cash";
    game[ "dialog" ][ "bm_tut_loot_cash" ] = "bm_tut_loot_cash";
    game[ "dialog" ][ "event_bank" ] = "event_bank";
    game[ "dialog" ][ "exfil_arrived" ] = "exfil_arrived";
    game[ "dialog" ][ "exfil_failed" ] = "exfil_failed";
    game[ "dialog" ][ "exfil_inbound" ] = "exfil_inbound";
    game[ "dialog" ][ "exfil_leaving" ] = "exfil_leaving";
    game[ "dialog" ][ "exfil_start_generic" ] = "exfil_start_generic";
    game[ "dialog" ][ "exfil_start_win" ] = "exfil_start_win";
    game[ "dialog" ][ "exfil_start_win_lz" ] = "exfil_start_win_lz";
    game[ "dialog" ][ "exfil_success_full" ] = "exfil_success_full";
    game[ "dialog" ][ "exfil_success_partial" ] = "exfil_success_partial";
    game[ "dialog" ][ "dom_point_friendly_capture_1" ] = "dom_point_friendly_capture_1";
    game[ "dialog" ][ "dom_point_friendly_capture_2" ] = "dom_point_friendly_capture_2";
    game[ "dialog" ][ "dom_point_friendly_capture_all" ] = "dom_point_friendly_capture_all";
    game[ "dialog" ][ "dom_point_enemy_capture_single" ] = "dom_point_enemy_capture";
    game[ "dialog" ][ "dom_point_enemy_capture_1" ] = "dom_point_enemy_capture_1";
    game[ "dialog" ][ "dom_point_enemy_capture_2" ] = "dom_point_enemy_capture_2";
    game[ "dialog" ][ "dom_point_enemy_capture_all" ] = "dom_point_enemy_capture_all";
}

// Params 1
// Size: 0x1c4
function ref_144eb( var0 )
{
    level endon( "game_ended" );
    level endon( "cancel_watch_parachuters_overhead" );
    
    for ( ;; )
    {
        var1 = 0;
        var2 = scripts\mp\utility\game::round_vehicle_logic();
        
        if ( var2 == "payload" )
        {
            var1 = scripts\mp\flags::gameflag( "prematch_done" ) && !scripts\mp\flags::gameflag( "infil_complete" );
        }
        
        if ( var1 )
        {
            waitframe();
            continue;
        }
        
        foreach ( var4 in level.audio_player_stop_mud_loop )
        {
            if ( !isdefined( var4 ) || !scripts\mp\utility\player::isreallyalive( var4 ) || !( var4 isparachuting() || var4 isinfreefall() ) )
            {
                level.audio_player_stop_mud_loop[ var17 ] = undefined;
                continue;
            }
            
            var5 = scripts\common\utility::playersincylinder( var4.origin, level.ref_121cf, undefined, level.ref_121cd );
            var6 = var4.team;
            
            foreach ( var8 in var5 )
            {
                if ( scripts\mp\utility\game::updatehistoryhud( var8 ) )
                {
                    continue;
                }
                
                var9 = var6 == var8.team;
                
                if ( var9 )
                {
                    continue;
                }
                
                var10 = !scripts\mp\utility\player::isreallyalive( var8 ) || istrue( var8.inlaststand );
                
                if ( var10 )
                {
                    continue;
                }
                
                var11 = var8 isparachuting() || var8 isinfreefall();
                
                if ( var11 )
                {
                    continue;
                }
                
                var12 = gettime();
                var13 = isdefined( var8.showteamlittlebirds ) && var12 - var8.showteamlittlebirds < var0;
                
                if ( var13 )
                {
                    continue;
                }
                
                var8.showteamlittlebirds = var12;
                
                if ( var8 scripts\cp_mp\utility\game_utility::ref_140a8() )
                {
                    var14 = "bchr";
                }
                else
                {
                    var15 = scripts\mp\gametypes\br_public::disableannouncer( var8 );
                    var14 = game[ "voice" ][ var15 ];
                }
                
                var8 queuedialogforplayer( level.audio_railyard_fires[ var14 ], "respawning_enemy_in_area", 2 );
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0xb
function ref_12892( var0, var1 )
{
    var2 = scripts\mp\gamescore::run_common_functions_stealth();
}

// Params 1
// Size: 0x46
function play_nag_intro_vo( var0 )
{
    var1 = getdvarint( "scr_rat_race_should_filter_vehicle_spawn_structs", 0 ) != 0;
    
    if ( var1 == 0 )
    {
        return var0;
    }
    
    var2 = "open_jeep_carpoc_spawn";
    var3 = level.br_vehtargetnametoref[ var2 ];
    
    if ( var0.size > 0 )
    {
        var4 = scripts\mp\gametypes\br_vehicles::vars_update( var0[ 0 ], var2, var3 );
        
        if ( var4 )
        {
            return var0;
        }
    }
    
    return [];
}

// Params 2
// Size: 0x67
function baitedbydecoy( var0, var1 )
{
    var2 = spawnstruct();
    var2.origin = var0;
    
    if ( isdefined( var1 ) )
    {
        var2.angles = var1;
    }
    else
    {
        var2.angles = ( 0, 0, 0 );
    }
    
    var2.targetname = "open_jeep_carpoc_spawn";
    
    if ( !isdefined( level.ref_1218b ) )
    {
        level.ref_1218b = [];
    }
    
    level.ref_1218b[ level.ref_1218b.size ] = var2;
    return var2;
}

// Params 0
// Size: 0x837
function ref_13208()
{
    if ( level.mapname != "mp_wz_island" )
    {
        return;
    }
    
    if ( level.ref_12a12.ref_1404c )
    {
        baitedbydecoy( ( 21829, -56164, 242 ), ( 0, 352.5, 0 ) );
        baitedbydecoy( ( 23273.7, -52382.6, 366 ), ( 0, 120, 0 ) );
        baitedbydecoy( ( 29059.9, -47273.2, 524.897 ), ( 0, 182.5, 0 ) );
        baitedbydecoy( ( 26132.2, -43407.8, 690 ), ( 0, 212.5, 0 ) );
        baitedbydecoy( ( 27337.9, -40774.9, 653.864 ), ( 0, 35, 0 ) );
        baitedbydecoy( ( 18872.8, -49149.1, 642.25 ), ( 0, 212.5, 0 ) );
        baitedbydecoy( ( 26485, -49953.8, 535.335 ), ( 0, 125, 0 ) );
        baitedbydecoy( ( 14641.5, -50754.1, 443 ), ( 0, 205, 0 ) );
        baitedbydecoy( ( 18177.9, -52511.3, 296.52 ), ( 0, 5, 0 ) );
        baitedbydecoy( ( 31340.1, -51236.2, 485.647 ), ( 0, 212.5, 0 ) );
        baitedbydecoy( ( 26923.4, -53985.7, 341.472 ), ( 0, 215, 0 ) );
        baitedbydecoy( ( 15814.4, -33847.7, 4961.59 ), ( 0, 2.5, 0 ) );
        baitedbydecoy( ( 13140.3, -33986.8, 5062 ), ( 0, 12.5, 0 ) );
        baitedbydecoy( ( 20237.7, -46707.8, 749.25 ), ( 0, 120, 0 ) );
        baitedbydecoy( ( 18673.2, -46929.3, 750.987 ), ( 0, 212.5, 0 ) );
        baitedbydecoy( ( 28218.5, -56839.5, 323 ), ( 0, 170, 0 ) );
        baitedbydecoy( ( 29638.9, -56025.7, 308.468 ), ( 0, 262.5, 0 ) );
        baitedbydecoy( ( 8788.77, -54637.7, 561 ), ( 0, 307.5, 0 ) );
        baitedbydecoy( ( 10261.7, -54162.6, 561.477 ), ( 0, 302.5, 0 ) );
        baitedbydecoy( ( 10794.8, -53842.6, 563.362 ), ( 0, 265, 0 ) );
        baitedbydecoy( ( 10175.3, -54896.7, 561.123 ), ( 0, 70, 0 ) );
        baitedbydecoy( ( 9113.54, -55194.9, 562.331 ), ( 0, 30, 0 ) );
        baitedbydecoy( ( 11842.2, -53605.4, 556.825 ), ( 0, 57.5, 0 ) );
        baitedbydecoy( ( 29493.2, -37091.4, 733.981 ), ( 0, 167.5, 0 ) );
        baitedbydecoy( ( 28995.2, -37095.5, 731.408 ), ( 0, 257.5, 0 ) );
        baitedbydecoy( ( 29229.3, -37784.2, 723.448 ), ( 0, 225, 0 ) );
        baitedbydecoy( ( 28802.7, -37644.4, 727.448 ), ( 0, 352.5, 0 ) );
        baitedbydecoy( ( 29023.5, -38650.6, 676.476 ), ( 0, 22.5, 0 ) );
        baitedbydecoy( ( 29001.4, -39083.9, 681.896 ), ( 0, 167.5, 0 ) );
        return;
    }
    
    baitedbydecoy( ( -28582, -19482, 889 ) );
    baitedbydecoy( ( -22569, -20732, 888 ) );
    baitedbydecoy( ( -20408, -23435, 888 ) );
    baitedbydecoy( ( -28679, -22099, 884 ) );
    baitedbydecoy( ( -27214, -25240, 888 ) );
    baitedbydecoy( ( -24989, -22957, 888 ) );
    baitedbydecoy( ( -26014, 21203, 2232 ) );
    baitedbydecoy( ( -20201, 25508, 2664 ) );
    baitedbydecoy( ( -22648, 24464, 2560 ) );
    baitedbydecoy( ( -17014, 24577, 3003 ) );
    baitedbydecoy( ( -21303, 18168, 3500 ) );
    baitedbydecoy( ( -21657, 22420, 2972 ) );
    baitedbydecoy( ( -43032, -2120, 412 ) );
    baitedbydecoy( ( -41880, -6515, 431 ) );
    baitedbydecoy( ( -26135, 3610, 3525 ) );
    baitedbydecoy( ( -30175, 7359, 3250 ) );
    baitedbydecoy( ( -9877, 6187, 952 ) );
    baitedbydecoy( ( -13139, 5492, 797 ) );
    baitedbydecoy( ( -17087.2, -10702, 888 ), ( 0, 310, 0 ) );
    baitedbydecoy( ( -2039.2, -18554, 2105.75 ), ( 0, 100, 0 ) );
    baitedbydecoy( ( -2238.8, -29194.7, 2545.96 ), ( 0, 129, 0 ) );
    baitedbydecoy( ( -20306.8, -30970.7, 858.08 ), ( 0, 134, 0 ) );
    baitedbydecoy( ( -26450.8, -4834.7, 1707.32 ), ( 0, 194, 0 ) );
    baitedbydecoy( ( -4102.8, -2402.7, 1810.69 ), ( 0, 265, 0 ) );
    baitedbydecoy( ( -47416, -11744, 218.24 ), ( 0, 0, 0 ) );
    baitedbydecoy( ( -34408, -13224, 158 ), ( 0, 240, 0 ) );
    baitedbydecoy( ( -48480, -17928, 150 ), ( 0, 360, 0 ) );
    baitedbydecoy( ( -42152, -24152, 190.792 ), ( 0, 105, 0 ) );
    baitedbydecoy( ( -34520, -27640, 275.981 ), ( 0, 135, 0 ) );
    baitedbydecoy( ( -38032, -4328, 1219.71 ), ( 0, 255, 0 ) );
    baitedbydecoy( ( -2072, 10824, 3806.23 ), ( 0, 90, 0 ) );
    baitedbydecoy( ( -12560, 12648, 2910.61 ), ( 0, 15, 0 ) );
    baitedbydecoy( ( -2304, 20544, 2335.33 ), ( 0, 165, 0 ) );
    baitedbydecoy( ( -13688, 26992, 3002.13 ), ( 0, 300, 0 ) );
    baitedbydecoy( ( -28672, 12536, 2053 ), ( 0, 75, 0 ) );
    baitedbydecoy( ( -26904, 28496, 2054 ), ( 0, 315, 0 ) );
    baitedbydecoy( ( -2560, 29808, 1057.95 ), ( 0, 195, 0 ) );
    baitedbydecoy( ( -48256, 8688, 151.32 ), ( 0, 345, 0 ) );
    baitedbydecoy( ( -36184, 15440, 1184 ), ( 0, 300, 0 ) );
    baitedbydecoy( ( -44896, 19200, 1563.34 ), ( 0, 285, 0 ) );
    baitedbydecoy( ( -37352, 27304, 1878.76 ), ( 0, 30, 0 ) );
    baitedbydecoy( ( -46088, 568, 578.53 ), ( 0, 75, 0 ) );
    baitedbydecoy( ( -37400, 20480, 2695.61 ), ( 0, 360, 0 ) );
}

// Params 0
// Size: 0xda
function ref_13209()
{
    level.ref_12178 = [];
    level.ref_12178[ level.ref_12178.size ] = [ ( 18405.7, -42293, 828 ), ( 0, 32.4992, 0 ) ];
    level.ref_12178[ level.ref_12178.size ] = [ ( 27560.9, -42692.7, 671.782 ), ( 0, 32.5, 0 ) ];
    level.ref_12178[ level.ref_12178.size ] = [ ( 30719.7, -55871.3, 317.407 ), ( 0, 352.5, 0 ) ];
    level.ref_12178[ level.ref_12178.size ] = [ ( 14293.1, -50606.7, 447.147 ), ( 0, 9.99992, 0 ) ];
    level.ref_12178[ level.ref_12178.size ] = [ ( 24952.3, -51440.4, 395.131 ), ( 0, 302.499, 0 ) ];
}

// Params 0
// Size: 0x2
function activate_precision_use_lua()
{
    
}

// Params 1
// Size: 0x53b
function put_objective_on_guy( var0 )
{
    var1 = spawnstruct();
    var1.ref_13904 = var0;
    var2 = 0;
    var3 = 60;
    var4 = 3000;
    var5 = 0;
    var6 = 10;
    var7 = 0.75;
    var8 = 0.9;
    var9 = 300;
    var10 = 3000;
    var11 = 0;
    var12 = 10;
    var13 = 0.75;
    var14 = 0.9;
    
    if ( level.mapname == "mp_wz_island" )
    {
        if ( level.ref_12a12.ref_1404c )
        {
            var1.ground_detection_think = ( 23079, -53205, 3525 );
            var1.circle_radius = 32000;
            level.spawn_set_jugg_value.choppersupport_watchtargetrange = ( 10162, -54045, 561 );
            level.spawn_set_jugg_value.chosen = ( 28689, -37165, 760 );
            var3 = 170;
            var4 = 3000;
            var5 = 0;
            var6 = 7;
            var7 = 0.5;
            var8 = 0.65;
            var9 = 55;
            var10 = 3000;
            var11 = 0;
            var12 = 7;
            var13 = 0.55;
            var14 = 0.7;
            ref_12af0( var1, 0, ( 28868, -55849, 309 ) );
            ref_12af0( var1, 0, ( 18402, -45320, 888 ) );
            ref_12af0( var1, 0, ( 13942, -34146, 5040 ) );
            ref_12aef( var1, ( 8186, -45544, 2411 ) );
            ref_12aef( var1, ( 40081, -46767, 315 ) );
            ref_12aef( var1, ( 21653, -50408, 440 ) );
            ref_12aef( var1, ( 35786.4, -39525.1, 530.743 ) );
            ref_12aef( var1, ( 4680, -35440, 4438 ) );
            ref_12aef( var1, ( 15320, -41043, 2441 ) );
            ref_12aef( var1, ( 31359, -47372, 528 ) );
            ref_12aef( var1, ( 17844, -27418, 5516 ) );
            ref_12aef( var1, ( 21777, -57498, 378 ) );
            ref_12aef( var1, ( 31763, -56480, 326 ) );
        }
        else
        {
            var1.ground_detection_think = ( -23030, 659, 0 );
            var1.circle_radius = 32000;
            level.spawn_set_jugg_value.choppersupport_watchtargetrange = ( -22010, 24680, 3022 );
            level.spawn_set_jugg_value.chosen = ( -24170, -23620, 3022 );
            ref_12af0( var1, 0, ( -42744, -7333, 473 ) );
            ref_12af0( var1, 0, ( -27836, 4897, 3279 ) );
            ref_12af0( var1, 0, ( -9169, 6657, 965 ) );
            ref_12af0( var1, 1, ( -8516, 16084, 2060 ) );
        }
        
        if ( getdvarint( "scr_rat_race_force_spawn_angles_above_factions", 0 ) )
        {
            var1.ref_134ff = his_removequestinstance( level.spawn_set_jugg_value.choppersupport_watchtargetrange, var1.ground_detection_think );
            var1.ref_13500 = his_removequestinstance( level.spawn_set_jugg_value.chosen, var1.ground_detection_think );
        }
        
        if ( level.ô∞[+†ˇÂ±íAÿˆ&“Ì¿¯(≤≈H:¢	_< )
        {
            level.spawn_set_jugg_value.æÀ„ıÖÄ≈™À∑¡è‚õ∏)Oé{]Î = ( 26975.3, -52773.1, 383.928 );
            level.spawn_set_jugg_value.ìÀ†k¶äÓ	¸]!í`1Gœ(Å = ( 357.394, 34.9914, -1.08173 );
        }
    }
    else
    {
        level.spawn_set_jugg_value.choppersupport_watchtargetrange = ( 8244, -2576, 3022 );
        level.spawn_set_jugg_value.chosen = ( -4791, -1707, 3022 );
        
        if ( level.ô∞[+†ˇÂ±íAÿˆ&“Ì¿¯(≤≈H:¢	_< )
        {
            level.spawn_set_jugg_value.æÀ„ıÖÄ≈™À∑¡è‚õ∏)Oé{]Î = ( 1726.5, -3760, 3022 );
            level.spawn_set_jugg_value.ìÀ†k¶äÓ	¸]!í`1Gœ(Å = ( 0, 0, 0 );
        }
    }
    
    var1.ref_1354f = getdvarint( "scr_rat_race_spawn_face_enemy", var2 );
    var1.ref_134ff = getdvarint( "scr_rat_race_spawn_angle_allies", var3 );
    var1.ref_13564 = getdvarint( "scr_rat_race_spawn_height_allies", var4 );
    var1.∏LgI”Œaπ_X7ä˚ùOß……zΩX = getdvarint( "scr_rat_race_spawn_angle_min_allies", var5 );
    var1.ñÆ{«B„9I%'¿©kØê9)R,ç# = getdvarint( "scr_rat_race_spawn_angle_max_allies", var6 );
    var1.æ~G°Ár'≠¸rç±(	á£@-k = getdvarfloat( "scr_rat_race_spawn_dist_min_allies", var7 );
    var1.©öﬁÔÉ≠°:»”Isô#èoŸl∑âﬂ = getdvarfloat( "scr_rat_race_spawn_dist_max_allies", var8 );
    var1.ref_13500 = getdvarint( "scr_rat_race_spawn_angle_axis", var9 );
    var1.ref_13565 = getdvarint( "scr_rat_race_spawn_height_axis", var10 );
    var1.Ø«[cﬂØÌÅCÊ˜Aàys‚
£Á = getdvarint( "scr_rat_race_spawn_angle_min_axis", var11 );
    var1.àón∞›sÎs;∆+æ÷∞áØ<“õ = getdvarint( "scr_rat_race_spawn_angle_max_axis", var12 );
    var1.ô{π›õ}#-πGæ≠“πØÖZπ = getdvarfloat( "scr_rat_race_spawn_dist_min_axis", var13 );
    var1.çZ7XªÕØFZõ:Î≠¬}K7 = getdvarfloat( "scr_rat_race_spawn_dist_max_axis", var14 );
    
    if ( !isdefined( var1.circle_radius ) || !isdefined( var1.ground_detection_think ) )
    {
        power_wave_mode_reset_playerdata( var1, level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange );
    }
    
    if ( !isdefined( var1.arena_bot_seek_dropped_weapon ) )
    {
        poweron_warnings( var1, level.ref_12a12.ref_1229c, level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange );
    }
    
    if ( !isdefined( var1.manualturret_toggleallowuseactions ) )
    {
        var15 = scripts\engine\trace::create_default_contents( 1 );
        var16 = scripts\engine\utility::drop_to_ground( var1.ground_detection_think, 10000, -20000, undefined, var15 );
        ref_12af0( var1, 0, var16 );
    }
    
    return var1;
}

// Params 2
// Size: 0x4a
function his_removequestinstance( var0, var1 )
{
    if ( isdefined( var0 ) && isdefined( var1 ) )
    {
        var2 = ( var0[ 0 ], var0[ 1 ], 0 );
        var3 = ( var1[ 0 ], var1[ 1 ], 0 );
        
        if ( distancesquared( var2, var3 ) > squared( 0.1 ) )
        {
            var4 = var2 - var3;
            var4 = vectornormalize( var4 );
            return vectortoyaw( var4 );
        }
    }
    
    return 0;
}

// Params 2
// Size: 0x7c
function power_wave_mode_reset_playerdata( var0, var1 )
{
    if ( isdefined( var0 ) && isdefined( var1 ) )
    {
        var2 = ( var1[ 0 ], var1[ 1 ], 0 );
        var3 = ( var0[ 0 ], var0[ 1 ], 0 );
        
        if ( distancesquared( var2, var3 ) > squared( 0.1 ) )
        {
            var4 = var3 - var2;
            var5 = length( var4 );
            var4 = vectornormalize( var4 );
            self.circle_radius = int( var5 * 0.5 );
            self.ground_detection_think = var2 + var4 * self.circle_radius;
            self.ref_134ff = vectortoyaw( -1 * var4 );
            self.ref_13500 = vectortoyaw( var4 );
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x131
function poweron_warnings( var0, var1, var2 )
{
    var3 = [];
    var4 = ( 0, 0, 0 );
    var5 = ( 1, 0, 0 );
    var6 = 3000;
    var7 = ( 0, 1, 0 );
    var8 = 1000;
    
    if ( isdefined( self.ground_detection_think ) )
    {
        var4 = self.ground_detection_think;
    }
    
    if ( isdefined( self.circle_radius ) )
    {
        var6 = self.circle_radius;
        var8 = int( min( var8, self.circle_radius ) );
    }
    
    if ( isdefined( var2 ) && isdefined( var1 ) )
    {
        var9 = ( var2[ 0 ], var2[ 1 ], 0 );
        var10 = ( var1[ 0 ], var1[ 1 ], 0 );
        
        if ( distancesquared( var9, var10 ) > squared( 0.1 ) )
        {
            var7 = vectornormalize( var10 - var9 );
            var5 = vectorcross( var7, ( 0, 0, 1 ) );
        }
    }
    
    var11 = scripts\engine\trace::create_default_contents( 1 );
    
    for ( var12 = 0; var12 < var0 ; var12++ )
    {
        var13 = randomint( var6 ) * scripts\engine\utility::ter_op( scripts\engine\utility::cointoss(), 1, -1 );
        var14 = randomint( var8 ) * scripts\engine\utility::ter_op( scripts\engine\utility::cointoss(), 1, -1 );
        var15 = var4 + var13 * var5 + var14 * var7;
        var15 = scripts\engine\utility::drop_to_ground( var15, 10000, -20000, undefined, var11 );
        var3 = var15;
    }
    
    self.arena_bot_seek_dropped_weapon = var3;
}

// Params 0
// Size: 0x2
function activate_subway_track_trigger_hurt()
{
    
}

// Params 0
// Size: 0x194
function ref_13b66()
{
    level endon( "game_ended" );
    var0 = 0;
    var1 = 0;
    var2 = 0;
    var3 = scripts\engine\utility::ter_op( scripts\mp\utility\game::isanymlgmatch(), 5, 2 );
    scripts\mp\flags::gameflagwait( "infil_complete" );
    
    while ( game[ "state" ] == "playing" )
    {
        if ( !level.timerstopped && scripts\mp\utility\game::gettimelimit() )
        {
            var4 = scripts\mp\gamelogic::gettimeremaining() / 1000;
            var5 = int( var4 + 0.5 );
            var6 = 0;
            
            if ( var3 == 2 && var5 % 2 == 1 )
            {
                var6 = 1;
            }
            
            var7 = getdvarint( "scr_rat_race_pe_dom_flag_start_time_sec", 840 ) + 20;
            var8 = getdvarint( "scr_rat_race_pe_cash_drops_start_time_sec", 1020 ) + 20;
            var9 = getdvarint( "scr_rat_race_pe_cash_drops_start_time_sec_2", 660 ) + 20;
            
            if ( !var0 && ( var6 == 1 && var5 == var7 + 1 || var6 == 0 && var5 == var7 ) )
            {
                if ( getdvarint( "scr_rat_race_pe_dom_flag_enabled", 1 ) )
                {
                    thread ref_122c0( level );
                }
                
                var0 = 1;
            }
            else if ( !var1 && ( var6 == 1 && var5 == var8 + 1 || var6 == 0 && var5 == var8 ) )
            {
                if ( getdvarint( "scr_rat_race_pe_cash_drop_enabled", 1 ) )
                {
                    thread ref_1229b();
                }
                
                var1 = 1;
            }
            else if ( !var2 && ( var6 == 1 && var5 == var9 + 1 || var6 == 0 && var5 == var9 ) )
            {
                if ( getdvarint( "scr_rat_race_pe_cash_drop_enabled", 1 ) )
                {
                    thread ref_1229a();
                }
                
                var2 = 1;
            }
            
            if ( var4 - floor( var4 ) >= 0.05 )
            {
                wait var4 - floor( var4 );
                continue;
            }
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x2
function activate_target()
{
    
}

// Params 4
// Size: 0x7f
function ref_12af0( var0, var1, var2, var3 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = level.ref_12a12.maphints;
    }
    
    if ( !isdefined( self.manualturret_toggleallowuseactions ) )
    {
        self.manualturret_toggleallowuseactions = [];
    }
    
    if ( !isdefined( self.manualturret_toggleallowuseactions[ var0 ] ) )
    {
        self.manualturret_toggleallowuseactions[ var0 ] = [];
    }
    
    var4 = spawnstruct();
    var4.ref_135ce = var0;
    var4.location = getgroundposition( var1, 5 );
    var4.get_current_building_obj_struct = var2;
    var4.mid_bosses = var3;
    self.manualturret_toggleallowuseactions[ var0 ] = scripts\engine\utility::array_add( self.manualturret_toggleallowuseactions[ var0 ], var4 );
}

// Params 1
// Size: 0xc9
function ref_122c0( var0 )
{
    level endon( "game_ended" );
    
    if ( !isdefined( level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions ) || var0 >= level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions.size )
    {
        return;
    }
    
    var1 = level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions[ var0 ];
    level.ref_12a12.ref_12e2c.ref_122b5 = var0;
    
    if ( !isdefined( var1 ) || var1.size <= 0 )
    {
        return;
    }
    
    ref_122bf();
    level.objectivescaler = 1;
    
    if ( getdvarint( "scr_rat_race_skip_event_wait_times", 0 ) == 0 )
    {
        level thread scripts\mp\gametypes\br_public::brleaderdialog( "dom_point_incoming", 0 );
        ref_12424( "br_rumble_pe_dom_flags_incoming" );
        wait 20;
    }
    
    level thread scripts\mp\gametypes\br_public::brleaderdialog( "dom_point_started", 0 );
    ref_12424( "br_rumble_pe_dom_flags_online" );
    wait 3;
    thread ref_122be();
}

// Params 0
// Size: 0x51
function ref_122bf()
{
    var0 = level.ref_12a12.ref_12e2c.ref_122b5;
    var1 = level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions[ var0 ];
    
    foreach ( var3 in var1 )
    {
        thread ref_122b7();
    }
}

// Params 0
// Size: 0x338
function ref_122be()
{
    var0 = [ "_a", "_b", "_c", "_d", "_e" ];
    
    if ( !isdefined( level.ref_12a12.are_all_players_in_region ) )
    {
        level.ref_12a12.are_all_players_in_region = [];
        level.ref_12a12.are_all_players_in_region[ "allies" ] = 0;
        level.ref_12a12.are_all_players_in_region[ "axis" ] = 0;
    }
    
    if ( !isdefined( level.ref_12a12.spawnsecretstashlootcache ) )
    {
        level.ref_12a12.spawnsecretstashlootcache = 0;
    }
    
    var1 = level.ref_12a12.ref_12e2c.ref_122b5;
    var2 = level.ref_12a12.ref_12e2c.manualturret_toggleallowuseactions[ var1 ];
    
    foreach ( var8, var4 in var2 )
    {
        var5 = scripts\engine\utility::ter_op( isdefined( var4.get_current_building_obj_struct ), var4.get_current_building_obj_struct, level.ref_12a12.maphints );
        var6 = spawn( "trigger_radius", var4.location, 0, int( var5 ), int( level.defend_wave_3 ) );
        var6.script_label = var0[ level.ref_12a12.spawnsecretstashlootcache ];
        var6.iconname = var0[ level.ref_12a12.spawnsecretstashlootcache ];
        level.ref_12a12.spawnsecretstashlootcache++;
        var2[ var8 ].trigger = var6;
        var7 = scripts\mp\gametypes\obj_dom::setupobjective( var2[ var8 ].trigger, "neutral" );
        var7.onuse = &ref_122b2;
        var7.onbeginuse = &ref_122a8;
        var7.onuseupdate = &ref_122b3;
        var7.onenduse = &ref_122aa;
        var7.oncontested = &ref_122a9;
        var7.onuncontested = &ref_122af;
        var7.onunoccupied = &ref_122b0;
        var7.onpinnedstate = &ref_122ad;
        var7.onunpinnedstate = &ref_122b1;
        var7.ref_138b2 = &ref_122ae;
        var7.stompprogressreward = &ref_122b8;
        var7.id = "domFlag";
        var7.pinobj = 1;
        var7.lockupdatingicons = 1;
        var7.trigger = var6;
        var7.get_current_bush_zone = 0;
        var7.get_current_building_obj_struct = var5;
        var7.pos = var4.location;
        var7.vfxent = var4.vfxent;
        var7 scripts\mp\gameobjects::setcapturebehavior( "persistent" );
        var7 scripts\mp\gameobjects::setusetime( level.ref_12a12.ref_122a1 );
        playencryptedcinematicforall( var7.objidnum, 1 );
        var7.ref_11ad0 = [];
        var7.ref_11ad0[ "ally" ] = spawnstruct();
        var7.ref_11ad0[ "enemy" ] = spawnstruct();
        var7.ref_11ad0[ "neutral" ] = spawnstruct();
        var7.waittill_pickup_or_timeout = "undefined";
        ref_122a4( var7.ref_11ad0[ "neutral" ], 9, var7.curorigin, var5 );
        ref_122a4( var7.ref_11ad0[ "ally" ], 8, var7.curorigin, var5 );
        ref_122a4( var7.ref_11ad0[ "enemy" ], 0, var7.curorigin, var5 );
        ref_122bb( var7, "neutral" );
        thread ref_122b9();
        thread ref_122ba();
        var2[ var8 ].manned_turret_operator_validation_func = var7;
        wait 0.5;
    }
}

// Params 1
// Size: 0x1e
function ref_122ab( var0 )
{
    self.ref_1265b = scripts\engine\utility::array_add( self.ref_1265b, var0 );
    var0.truck_03_node = 1;
}

// Params 1
// Size: 0x1d
function ref_122ac( var0 )
{
    self.ref_1265b = scripts\engine\utility::array_remove( self.ref_1265b, var0 );
    var0.truck_03_node = 0;
}

// Params 0
// Size: 0x4f
function ref_122b9()
{
    level endon( "game_ended" );
    self.ref_1265b = [];
    
    while ( !self.get_current_bush_zone )
    {
        self.trigger waittill( "trigger", var0 );
        
        if ( ( isplayer( var0 ) || isbot( var0 ) ) && !scripts\engine\utility::array_contains( self.ref_1265b, var0 ) )
        {
            ref_122ab( var0 );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x88
function ref_122ba()
{
    level endon( "game_ended" );
    
    while ( !self.get_current_bush_zone )
    {
        foreach ( var1 in self.ref_1265b )
        {
            if ( !var1 istouching( self.trigger ) || !isalive( var1 ) )
            {
                ref_122ac( var1 );
            }
        }
        
        wait 0.1;
    }
    
    foreach ( var1 in self.ref_1265b )
    {
        ref_122ac( var1 );
    }
}

// Params 2
// Size: 0x64
function ref_122a7( var0, var1 )
{
    if ( istrue( var1.truck_03_node ) )
    {
        var0 thread scripts\mp\rank::giverankxp( "rumble_dom_flag_enemy_kill", 20, var0.weapon, 0, 1 );
        var0 thread scripts\mp\rank::scoreeventpopup( "rumble_dom_flag_enemy_kill" );
    }
    
    if ( istrue( var0.truck_03_node ) )
    {
        var0 thread scripts\mp\rank::giverankxp( "rumble_dom_flag_defend_kill", 20, var0.weapon, 0, 1 );
        var0 thread scripts\mp\rank::scoreeventpopup( "rumble_dom_flag_defend_kill" );
        return;
    }
}

// Params 3
// Size: 0x1a
function ref_122a4( var0, var1, var2 )
{
    scripts\mp\gametypes\br_quest_util::init_tactical_boxes( var0, 0, 0, var1 );
    scripts\mp\gametypes\br_quest_util::ref_1316f( int( var2 ) );
}

// Params 1
// Size: 0xe9
function ref_122bb( var0 )
{
    if ( var0 != self.waittill_pickup_or_timeout )
    {
        self.waittill_pickup_or_timeout = var0;
        
        foreach ( var2 in self.ref_11ad0 )
        {
            var2 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
        }
        
        var4 = self.waittill_pickup_or_timeout != "axis" && self.waittill_pickup_or_timeout != "allies";
        var5 = undefined;
        
        foreach ( var7 in level.players )
        {
            var8 = var7.team == self.waittill_pickup_or_timeout;
            
            if ( var4 )
            {
                var5 = self.ref_11ad0[ "neutral" ];
            }
            else
            {
                var5 = scripts\engine\utility::ter_op( var8, self.ref_11ad0[ "ally" ], self.ref_11ad0[ "enemy" ] );
            }
            
            if ( isdefined( var5 ) )
            {
                var5 scripts\mp\gametypes\br_quest_util::ref_1336a( var7 );
            }
        }
        
        if ( isdefined( var5 ) )
        {
            scripts\mp\objidpoolmanager::objective_teammask_addtomask( self.objidnum, var0 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x2e
function ref_122a5()
{
    foreach ( var1 in self.ref_11ad0 )
    {
        var1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
    }
}

// Params 1
// Size: 0x52
function ref_122b2( var0 )
{
    var1 = var0.team;
    self.get_current_station_signage_structs = var1;
    self.capturetime = gettime();
    self.get_current_bush_zone = 1;
    
    if ( self.touchlist[ var1 ].size == 0 && isdefined( self.oldtouchlist ) )
    {
        self.touchlist = self.oldtouchlist;
    }
    
    self notify( "pe_dom_flag_end" );
    thread ref_122a2( var1 );
}

// Params 1
// Size: 0x71
function ref_122a8( var0 )
{
    self.userate = 1;
    
    if ( !isdefined( self.ref_11f63 ) || !self.ref_11f63 )
    {
        self.ref_11f63 = 1;
        scripts\mp\gametypes\br_quest_util::ref_140b1( self.curorigin, "dom" );
        var1 = scripts\mp\utility\teams::getfriendlyplayers( var0.team, 0 );
        
        foreach ( var3 in var1 )
        {
            var3 notify( "calloutmarkerping_warzoneKillQuestIcon" );
        }
        
        return;
    }
}

// Params 4
// Size: 0x5c
function ref_122b3( var0, var1, var2, var3 )
{
    self.userate = 1;
    
    if ( var1 < 1 && !level.gameended && !istrue( self.get_current_bush_zone ) )
    {
        ref_12427( var1, var0 );
    }
    
    if ( var1 > 0.05 && var2 && !istrue( self.didstatusnotify ) )
    {
        self.didstatusnotify = 1;
    }
    
    ref_122bb( var0 );
}

// Params 3
// Size: 0xf
function ref_122aa( var0, var1, var2 )
{
    scripts\mp\gametypes\obj_dom::dompoint_onuseend( var0, var1, var2 );
}

// Params 0
// Size: 0x2b
function ref_122a9()
{
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_contested" );
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    level thread scripts\mp\gametypes\br_public::brleaderdialog( "exfil_contested" );
    var0 = scripts\mp\gameobjects::getownerteam();
}

// Params 1
// Size: 0xd1
function ref_122af( var0 )
{
    var1 = scripts\mp\gameobjects::getownerteam();
    var2 = undefined;
    var3 = ref_122a6();
    
    if ( var3 <= 1 )
    {
        foreach ( var5 in level.teamnamelist )
        {
            var6 = self.teamprogress[ var5 ];
            
            if ( var6 > 0 )
            {
                var2 = var5;
                break;
            }
        }
        
        if ( isdefined( var2 ) )
        {
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var2 );
        }
        else if ( var1 != "neutral" )
        {
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var1 );
        }
        else if ( var0 != "none" )
        {
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var0 );
        }
        
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
        
        if ( var0 == "none" || var1 == "neutral" )
        {
            self.didstatusnotify = 0;
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x38
function ref_122b0()
{
    var0 = scripts\mp\gameobjects::getownerteam();
    
    if ( var0 == "neutral" )
    {
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_captureneutral" );
    }
    else
    {
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
    }
    
    self.didstatusnotify = 0;
}

// Params 1
// Size: 0x3a
function ref_122ad( var0 )
{
    if ( self.ownerteam != "neutral" && self.numtouching[ self.ownerteam ] && !self.stalemate )
    {
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defending", "waypoint_capture" );
        return;
    }
}

// Params 1
// Size: 0x3b
function ref_122b1( var0 )
{
    if ( self.ownerteam != "neutral" && !self.numtouching[ self.ownerteam ] && !self.stalemate )
    {
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
        return;
    }
}

// Params 1
// Size: 0x5a
function ref_122ae( var0 )
{
    self.userate = level.ref_12a12.manualturret_watchturretusetimeout;
    var1 = scripts\mp\utility\teams::getenemyteams( var0 );
    var2 = undefined;
    
    foreach ( var4 in var1 )
    {
        var5 = self.teamprogress[ var4 ];
        
        if ( var5 > 0 )
        {
            var2 = var5 / self.usetime;
        }
    }
}

// Params 1
// Size: 0x30
function ref_122b8( var0 )
{
    var0 thread scripts\mp\utility\points::giveunifiedpoints( "obj_prog_defend" );
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defending", "waypoint_capture" );
    
    if ( isdefined( self.lastprogressteam ) )
    {
        self.lastprogressteam = undefined;
        return;
    }
}

// Params 2
// Size: 0x57
function ref_12427( var0, var1 )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        var2 = "";
        var0 = int( floor( var0 * 10 ) );
        var2 = "mp_dom_capturing_tick_0" + var0;
        self.visuals[ 0 ] playsoundtoteam( var2, var1 );
        return;
    }
}

// Params 1
// Size: 0x171
function ref_122a2( var0 )
{
    if ( isdefined( var0 ) && var0 != "tie" )
    {
        level.ref_12a12.are_all_players_in_region[ var0 ] += 1;
        level scripts\mp\gamescore::giveteamscoreforobjective( var0, 15, 0 );
        
        foreach ( var2 in level.players )
        {
            if ( isdefined( var2 ) && isdefined( var2.team ) && var2.team == var0 )
            {
                thread ref_122b4( var2, 1 );
                var2 thread scripts\mp\hud_message::showsplash( "br_rat_race_point_captured_ally" );
                continue;
            }
            
            if ( isdefined( var2 ) && isdefined( var2.team ) && var2.team != var0 )
            {
                thread ref_122b4( var2, 0 );
                var2 thread scripts\mp\hud_message::showsplash( "br_rat_race_point_captured_enemy" );
            }
        }
        
        var4 = undefined;
        
        foreach ( var6 in self.touchlist[ var0 ] )
        {
            var2 = var6.player;
            var2 thread scripts\mp\rank::giverankxp( "rumble_dom_flag_capture", 250, var2 getcurrentprimaryweapon() );
            var2 thread scripts\mp\rank::scoreeventpopup( "rumble_dom_flag_capture" );
            
            if ( !isdefined( var4 ) )
            {
                var4 = var2;
            }
        }
        
        if ( isdefined( var4 ) )
        {
            var8 = getdvarint( "scr_rat_race_pe_dom_plunder_on_capture", 10000 );
            var9 = scripts\mp\gametypes\br_plunder::init_subway_cars();
            var9.ref_1244d = 0;
            var4 thread scripts\mp\gametypes\br_plunder::ref_12627( var8, var9 );
            var4 thread scripts\mp\gametypes\br_plunder::ref_1261c( var8, run_died_poorly_funcs( var0 ), var9 );
        }
        
        thread ref_122b6( self.pos );
        thread ref_122a3( self );
        return;
    }
}

// Params 2
// Size: 0xaa
function ref_122b4( var0, var1 )
{
    var2 = level.ref_12a12.are_all_players_in_region[ var1 ];
    
    switch ( var2 )
    {
        case 1:
            if ( var0 )
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_friendly_capture_1", self );
            }
            else
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_enemy_capture_1", self );
            }
            
            break;
        case 2:
            if ( var0 )
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_friendly_capture_2", self );
            }
            else
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_enemy_capture_2", self );
            }
            
            break;
        case 3:
            if ( var0 )
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_friendly_capture_all", self );
            }
            else
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_enemy_capture_all", self );
            }
            
            break;
    }
}

// Params 1
// Size: 0x37
function ref_122a3( var0 )
{
    stopfxontag( scripts\engine\utility::getfx( "vfx_smk_signal_green" ), var0.vfxent, "tag_origin" );
    var0.vfxent delete();
    ref_122a5( var0 );
    scripts\mp\gametypes\obj_dom::removeobjective( var0 );
}

// Params 0
// Size: 0x49
function ref_122b7()
{
    var0 = spawn( "script_model", self.location - ( 0, 0, 3 ) );
    var0 setmodel( "tag_origin" );
    self.vfxent = var0;
    wait 1;
    playfxontag( scripts\engine\utility::getfx( "vfx_smk_signal_green" ), var0, "tag_origin" );
}

// Params 1
// Size: 0x4
function ref_122b6( var0 )
{
    
}

// Params 0
// Size: 0x47
function ref_122a6()
{
    var0 = 0;
    
    foreach ( var2 in self.numtouching )
    {
        if ( var2 > 0 && ( !isstring( var3 ) || var3 != "none" ) )
        {
            var0++;
        }
    }
    
    return var0;
}

// Params 2
// Size: 0x5c
function ref_12424( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var4 = undefined;
        
        if ( isalive( var3 ) )
        {
            if ( isdefined( var1 ) )
            {
                var4 = spawnstruct();
                var4.intvar = var1;
            }
            
            scripts\mp\gametypes\br_quest_util::displayplayersplash( var3, var0, var4 );
        }
    }
}

// Params 1
// Size: 0xa2
function ref_12981( var0 )
{
    self notify( "dead_splash_queue_triggered" );
    self endon( "dead_splash_queue_triggered" );
    level endon( "game_ended" );
    level endon( "disconnect" );
    
    if ( !isdefined( self.isflagcarrymode ) )
    {
        self.isflagcarrymode = [];
    }
    
    self.isflagcarrymode = scripts\engine\utility::array_add( self.isflagcarrymode, var0 );
    
    while ( self.isflagcarrymode.size > 0 )
    {
        if ( isalive( self ) )
        {
            wait 0.5;
            
            foreach ( var2 in self.isflagcarrymode )
            {
                scripts\mp\gametypes\br_quest_util::displayplayersplash( self, var2.ref_136f3, var2 );
            }
            
            self.isflagcarrymode = [];
            break;
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x108
function spawn_br_plunder_dispensers()
{
    var0 = getdvarint( "scr_rat_race_broken_atm_interval", 10 );
    var1 = getdvarint( "scr_rat_race_broken_atm_instance_limit", 6 );
    
    if ( level.mapname == "mp_wz_island" )
    {
        scripts\mp\gametypes\br_plunder_dispenser::dispenser_create( scripts\common\utility::groundpos( ( 28868, -55849, 311 ) ), ( 0, 180, 0 ), var0, var1 );
        scripts\mp\gametypes\br_plunder_dispenser::dispenser_create( scripts\common\utility::groundpos( ( 18402, -45320, 890 ) ), ( 0, 0, 0 ), var0, var1 );
        scripts\mp\gametypes\br_plunder_dispenser::dispenser_create( scripts\common\utility::groundpos( ( 13942, -34146, 5043 ) ), ( 0, 0, 0 ), var0, var1 );
        return;
    }
    
    var2 = scripts\engine\trace::create_default_contents( 1 );
    var3 = scripts\engine\utility::drop_to_ground( level.ref_12a12.ref_12e2c.ground_detection_think, 10000, -20000, undefined, var2 );
    scripts\mp\gametypes\br_plunder_dispenser::dispenser_create( var3, ( 0, 45, 0 ), var0, var1 );
    var4 = var3 + ( -95, -130, 0 );
    scripts\mp\gametypes\br_plunder_dispenser::dispenser_create( var4, ( 0, 60, 0 ), var0, var1 + 3 );
}

// Params 0
// Size: 0x77
function ref_13514()
{
    var0 = "allies";
    var1 = level.spawn_set_jugg_value.choppersupport_watchtargetrange;
    level.ref_12a12.ref_13a9b[ var0 ] = scripts\mp\gametypes\br_rat_race_base::ref_140f5( scripts\common\utility::groundpos( var1 ), ( 0, 0, 0 ), var0 );
    var0 = "axis";
    var1 = level.spawn_set_jugg_value.chosen;
    level.ref_12a12.ref_13a9b[ var0 ] = scripts\mp\gametypes\br_rat_race_base::ref_140f5( scripts\common\utility::groundpos( var1 ), ( 0, 0, 0 ), var0 );
}

// Params 0
// Size: 0x3db
function subwave_progression()
{
    _setdomflagiconinfo( "waypoint_captureneutral_br_a", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0 );
    _setdomflagiconinfo( "waypoint_captureneutral_br_b", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_b", 0 );
    _setdomflagiconinfo( "waypoint_captureneutral_br_c", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_c", 0 );
    _setdomflagiconinfo( "waypoint_captureneutral_br_d", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0 );
    _setdomflagiconinfo( "waypoint_captureneutral_br_e", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0 );
    _setdomflagiconinfo( "waypoint_capture_br_a", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0 );
    _setdomflagiconinfo( "waypoint_capture_br_b", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_b", 0 );
    _setdomflagiconinfo( "waypoint_capture_br_c", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_c", 0 );
    _setdomflagiconinfo( "waypoint_capture_br_d", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0 );
    _setdomflagiconinfo( "waypoint_capture_br_e", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0 );
    _setdomflagiconinfo( "waypoint_defend_br_a", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0 );
    _setdomflagiconinfo( "waypoint_defend_br_b", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0 );
    _setdomflagiconinfo( "waypoint_defend_br_c", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0 );
    _setdomflagiconinfo( "waypoint_defend_br_d", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0 );
    _setdomflagiconinfo( "waypoint_defend_br_e", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0 );
    _setdomflagiconinfo( "waypoint_defending_br_a", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0 );
    _setdomflagiconinfo( "waypoint_defending_br_b", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0 );
    _setdomflagiconinfo( "waypoint_defending_br_c", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0 );
    _setdomflagiconinfo( "waypoint_defending_br_d", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0 );
    _setdomflagiconinfo( "waypoint_defending_br_e", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0 );
    _setdomflagiconinfo( "waypoint_contested_br_a", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1 );
    _setdomflagiconinfo( "waypoint_contested_br_b", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1 );
    _setdomflagiconinfo( "waypoint_contested_br_c", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1 );
    _setdomflagiconinfo( "waypoint_contested_br_d", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1 );
    _setdomflagiconinfo( "waypoint_contested_br_e", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1 );
    _setdomflagiconinfo( "waypoint_taking_br_a", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1 );
    _setdomflagiconinfo( "waypoint_taking_br_b", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1 );
    _setdomflagiconinfo( "waypoint_taking_br_c", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1 );
    _setdomflagiconinfo( "waypoint_taking_br_d", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1 );
    _setdomflagiconinfo( "waypoint_taking_br_e", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1 );
    _setdomflagiconinfo( "waypoint_losing_br_a", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1 );
    _setdomflagiconinfo( "waypoint_losing_br_b", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1 );
    _setdomflagiconinfo( "waypoint_losing_br_c", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1 );
    _setdomflagiconinfo( "waypoint_losing_br_d", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1 );
    _setdomflagiconinfo( "waypoint_losing_br_e", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1 );
    level._effect[ "vfx_smk_signal_green" ] = loadfx( "vfx/iw8_cp/prop/vfx_smk_signal_green" );
    scripts\mp\gametypes\br_dom_quest::ref_13239();
}

// Params 5
// Size: 0x35
function _setdomflagiconinfo( var0, var1, var2, var3, var4 )
{
    level.waypointcolors[ var0 ] = var1;
    level.waypointbgtype[ var0 ] = 0;
    level.waypointstring[ var0 ] = var2;
    level.waypointshader[ var0 ] = var3;
    level.waypointpulses[ var0 ] = var4;
}

// Params 0
// Size: 0x2
function activate_switch_cooldown()
{
    
}

// Params 1
// Size: 0x21
function ref_12aef( var0 )
{
    if ( !isdefined( self.arena_bot_seek_dropped_weapon ) )
    {
        self.arena_bot_seek_dropped_weapon = [];
    }
    
    self.arena_bot_seek_dropped_weapon[ self.arena_bot_seek_dropped_weapon.size ] = var0;
}

// Params 0
// Size: 0x61
function ref_1229b()
{
    level endon( "game_ended" );
    ref_12297();
    thread ref_12299( level );
    
    if ( getdvarint( "scr_rat_race_skip_event_wait_times", 0 ) == 0 )
    {
        ref_12424( "br_gametype_rat_race_airdrop_incoming" );
        wait 20;
    }
    
    ref_12424( "br_gametype_rat_race_bonus_gold_crates_online" );
    wait 3;
    var0 = level.ref_12a12.ref_12296;
    ref_122ee( var0 );
}

// Params 0
// Size: 0x7e
function ref_12297()
{
    level.ref_12a12.ref_12e2a = spawnstruct();
    level.ref_12a12.ref_12e2a.aq_playerdisconnect = [];
    level.ref_12a12.ref_12e2a.are_all_alive_players_touching_plane = [];
    level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon = scripts\engine\utility::array_randomize( level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon );
    var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "battle_royale_c130_loot" );
    var0.capturecallback = &ref_12295;
    var0.timeout = undefined;
}

// Params 2
// Size: 0x45
function ref_12299( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    for ( var2 = 0; var2 < var0 ; var2++ )
    {
        if ( !isdefined( level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon[ var2 + var1 ] ) )
        {
            return;
        }
        
        thread ref_12298( level );
        wait 2;
    }
}

// Params 1
// Size: 0x25
function ref_12298( var0 )
{
    var1 = level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon[ var0 ];
    scripts\mp\gametypes\br_quest_util::ref_140b1( var1, "dom" );
}

// Params 0
// Size: 0x4a
function ref_1229a()
{
    level endon( "game_ended" );
    var0 = level.ref_12a12.ref_12296;
    var1 = level.ref_12a12.ref_1229c - var0;
    thread ref_12299( level, var1 );
    wait 20;
    ref_12424( "br_gametype_rat_race_bonus_gold_crates_online" );
    wait 3;
    ref_122ee( var1, var0 );
}

// Params 2
// Size: 0xa6
function ref_122ee( var0, var1 )
{
    level endon( "game_ended" );
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    for ( var2 = 0; var2 < var0 ; var2++ )
    {
        var3 = level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon[ var2 + var1 ];
        var4 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc( var3 + ( 0, 0, 2000 ), var3, ( 0, randomint( 360 ), 0 ), "battle_royale_c130_loot" );
        level.ref_12a12.ref_12e2a.aq_playerdisconnect[ level.ref_12a12.ref_12e2a.aq_playerdisconnect.size ] = var4;
        scripts\engine\utility::array_remove( level.ref_12a12.ref_12e2c.arena_bot_seek_dropped_weapon, var2 );
        wait 2.5;
    }
}

// Params 1
// Size: 0x46
function ref_12295( var0 )
{
    thread scripts\cp_mp\killstreaks\airdrop::dialog_wait_think_civ( var0 );
    level.ref_12a12.ref_12e2a.aq_playerdisconnect = scripts\engine\utility::array_remove( level.ref_12a12.ref_12e2a.aq_playerdisconnect, self );
    showsplashtoteam( var0.team, "br_gametype_rat_race_bonus_gold_crate_captured_ally" );
}

// Params 0
// Size: 0x2
function activate_laser_shut_down_interaction()
{
    
}

// Params 0
// Size: 0x40a
function ref_13eee()
{
    var0 = "any";
    var1 = level.ref_12a12.ref_12e2c.ground_detection_think + vectornormalize( level.ref_12a12.ref_12e2c.ref_136a8[ "axis" ] ) * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631[ "axis" ];
    var2 = scripts\mp\gameobjects::createobjidobject( var1, "neutral", ( 0, 0, 0 ), undefined, var0, 0 );
    var2.origin = var1;
    scripts\mp\objidpoolmanager::update_objective_ownerteam( var2.objidnum, "axis" );
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( var2.objidnum, "axis" );
    scripts\mp\objidpoolmanager::objective_set_play_intro( var2.objidnum, 0 );
    var2.lockupdatingicons = 0;
    scripts\mp\objidpoolmanager::objective_pin_global( var2.objidnum, 0 );
    scripts\mp\objidpoolmanager::update_objective_icon( var2.objidnum, "icon_waypoint_hq_friendly" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( var2.objidnum, 6 );
    objective_state( var2.objidnum, "active" );
    var2.lockupdatingicons = 1;
    var2.team = "axis";
    level.spawn_set_jugg_value.choosecrouchorstandtac = var2;
    thread ref_13ef2();
    var2 = scripts\mp\gameobjects::createobjidobject( var1, "neutral", ( 0, 0, 0 ), undefined, var0, 0 );
    var2.origin = var1;
    scripts\mp\objidpoolmanager::update_objective_ownerteam( var2.objidnum, "axis" );
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( var2.objidnum, "allies" );
    scripts\mp\objidpoolmanager::objective_set_play_intro( var2.objidnum, 0 );
    var2.lockupdatingicons = 0;
    scripts\mp\objidpoolmanager::objective_pin_global( var2.objidnum, 0 );
    scripts\mp\objidpoolmanager::update_objective_icon( var2.objidnum, "icon_waypoint_hq_enemy" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( var2.objidnum, 6 );
    objective_state( var2.objidnum, "active" );
    var2.lockupdatingicons = 1;
    var2.team = "axis";
    level.spawn_set_jugg_value.choosebestpropforkillcam = var2;
    thread ref_13ef2();
    var1 = level.ref_12a12.ref_12e2c.ground_detection_think + vectornormalize( level.ref_12a12.ref_12e2c.ref_136a8[ "allies" ] ) * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631[ "allies" ];
    var2 = scripts\mp\gameobjects::createobjidobject( var1, "neutral", ( 0, 0, 0 ), undefined, var0, 0 );
    var2.origin = var1;
    scripts\mp\objidpoolmanager::update_objective_ownerteam( var2.objidnum, "allies" );
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( var2.objidnum, "allies" );
    scripts\mp\objidpoolmanager::objective_set_play_intro( var2.objidnum, 0 );
    var2.lockupdatingicons = 0;
    scripts\mp\objidpoolmanager::objective_pin_global( var2.objidnum, 0 );
    scripts\mp\objidpoolmanager::update_objective_icon( var2.objidnum, "icon_waypoint_hq_friendly" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( var2.objidnum, 6 );
    objective_state( var2.objidnum, "active" );
    var2.lockupdatingicons = 1;
    var2.team = "allies";
    level.spawn_set_jugg_value.brjugg_cleanupents = var2;
    thread ref_13ef2();
    var2 = scripts\mp\gameobjects::createobjidobject( var1, "neutral", ( 0, 0, 0 ), undefined, var0, 0 );
    var2.origin = var1;
    scripts\mp\objidpoolmanager::update_objective_ownerteam( var2.objidnum, "allies" );
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( var2.objidnum, "axis" );
    scripts\mp\objidpoolmanager::objective_set_play_intro( var2.objidnum, 0 );
    var2.lockupdatingicons = 0;
    scripts\mp\objidpoolmanager::objective_pin_global( var2.objidnum, 0 );
    scripts\mp\objidpoolmanager::update_objective_icon( var2.objidnum, "icon_waypoint_hq_enemy" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( var2.objidnum, 6 );
    objective_state( var2.objidnum, "active" );
    var2.lockupdatingicons = 1;
    var2.team = "allies";
    level.spawn_set_jugg_value.briskillstreakallowed = var2;
    thread ref_13ef2();
}

// Params 0
// Size: 0x49
function ref_13ef2()
{
    level endon( "game_ended" );
    var0 = scripts\engine\utility::ter_op( self.team == "axis", level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    self.origin = var0;
    scripts\mp\objidpoolmanager::update_objective_position( self.objidnum, var0 );
}

// Params 0
// Size: 0x81
function ref_13ee7()
{
    self endon( "disconnect" );
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( self.team == "allies" )
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.spawn_set_jugg_value.brjugg_cleanupents.objidnum, self );
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.spawn_set_jugg_value.choosebestpropforkillcam.objidnum, self );
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.spawn_set_jugg_value.briskillstreakallowed.objidnum, self );
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.spawn_set_jugg_value.choosecrouchorstandtac.objidnum, self );
}

// Params 0
// Size: 0x2
function activate_all_targets()
{
    
}

// Params 0
// Size: 0x14
function relic_steelballs_health_boost()
{
    return level.ref_12a12.ref_12e2c.ground_detection_think;
}

// Params 2
// Size: 0x5
function dangercircletick( var0, var1 )
{
    
}

// Params 0
// Size: 0x20e
function groundz()
{
    level.br_level.ref_13884 = 1;
    level.ref_12a12.ref_12e2c = put_objective_on_guy( "default" );
    level.grouptorewards = level.ref_12a12.ref_12e2c;
    level.br_level.default_class_chosen = [ level.grouptorewards ];
    var0 = getdvarint( "scr_br_timelimit" );
    level.br_level.br_circledelaytimes = [ var0 * 2 ];
    level.br_level.br_circleclosetimes = [ var0 * 2 ];
    level.br_level.br_circleradii = [ level.ref_12a12.ref_12e2c.circle_radius, level.ref_12a12.ref_12e2c.circle_radius ];
    level.br_level.br_circleminimapradii = [ int( level.ref_12a12.ref_12e2c.circle_radius / 2 ) ];
    level.br_level.default_player_connect_black_screen = [ 0 ];
    level.br_level.default_suicidebomber_combat = [ 0 ];
    tank_x1_capacity();
    
    if ( !isdefined( level.br_circle ) )
    {
        level.br_circle = spawnstruct();
    }
    
    level.br_circle.circleindex = 0;
    level.br_circle.starttime = gettime();
    level.br_circle.dangercircleent = spawnstruct();
    level.br_circle.dangercircleent.origin = [ level.ref_12a12.ref_12e2c.ground_detection_think[ 0 ], level.ref_12a12.ref_12e2c.ground_detection_think[ 1 ], level.ref_12a12.ref_12e2c.circle_radius ];
    level.br_circle.safecircleent = spawnstruct();
    level.br_circle.safecircleent.origin = [ level.ref_12a12.ref_12e2c.ground_detection_think[ 0 ], level.ref_12a12.ref_12e2c.ground_detection_think[ 1 ], level.ref_12a12.ref_12e2c.circle_radius ];
    setomnvar( "ui_br_minimap_radius", level.br_level.br_circleminimapradii[ 0 ] );
    var1 = level.br_level.br_circleradii.size;
    
    if ( isdefined( var1 ) && var1 > 0 )
    {
        scripts\mp\gametypes\br_circle::teleport_entities_inside_subway_car( var1 );
        return;
    }
}

// Params 0
// Size: 0x2
function activatemeleeblood()
{
    
}

// Params 0
// Size: 0x2fa
function tank_x1_capacity()
{
    level.ref_12a12.ref_12e2c.ref_1365e[ "allies" ] = level.ref_12a12.ref_12e2c.ref_13564;
    level.ref_12a12.ref_12e2c.ref_1365e[ "axis" ] = level.ref_12a12.ref_12e2c.ref_13565;
    level.ref_12a12.ref_12e2c.ref_136a8[ "allies" ] = anglestoforward( ( 0, level.ref_12a12.ref_12e2c.ref_134ff, 0 ) );
    level.ref_12a12.ref_12e2c.ref_136a8[ "axis" ] = anglestoforward( ( 0, level.ref_12a12.ref_12e2c.ref_13500, 0 ) );
    level.ref_12a12.ref_12e2c.ref_13608[ "allies" ] = level.ref_12a12.ref_12e2c.∏LgI”Œaπ_X7ä˚ùOß……zΩX;
    level.ref_12a12.ref_12e2c.ref_13608[ "axis" ] = level.ref_12a12.ref_12e2c.Ø«[cﬂØÌÅCÊ˜Aàys‚
£Á;
    level.ref_12a12.ref_12e2c.ref_13607[ "allies" ] = level.ref_12a12.ref_12e2c.ñÆ{«B„9I%'¿©kØê9)R,ç#;
    level.ref_12a12.ref_12e2c.ref_13607[ "axis" ] = level.ref_12a12.ref_12e2c.àón∞›sÎs;∆+æ÷∞áØ<“õ;
    level.ref_12a12.ref_12e2c.ref_13631[ "allies" ] = level.ref_12a12.ref_12e2c.æ~G°Ár'≠¸rç±(	á£@-k;
    level.ref_12a12.ref_12e2c.ref_13631[ "axis" ] = level.ref_12a12.ref_12e2c.ô{π›õ}#-πGæ≠“πØÖZπ;
    level.ref_12a12.ref_12e2c.ref_13630[ "allies" ] = level.ref_12a12.ref_12e2c.©öﬁÔÉ≠°:»”Isô#èoŸl∑âﬂ;
    level.ref_12a12.ref_12e2c.ref_13630[ "axis" ] = level.ref_12a12.ref_12e2c.çZ7XªÕØFZõ:Î≠¬}K7;
    level.ref_12a12.ref_12e2c.spawnorigin[ "allies" ] = level.ref_12a12.ref_12e2c.ground_detection_think + level.ref_12a12.ref_12e2c.ref_136a8[ "allies" ] * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631[ "allies" ];
    level.ref_12a12.ref_12e2c.spawnorigin[ "axis" ] = level.ref_12a12.ref_12e2c.ground_detection_think + level.ref_12a12.ref_12e2c.ref_136a8[ "axis" ] * level.ref_12a12.ref_12e2c.circle_radius * level.ref_12a12.ref_12e2c.ref_13631[ "axis" ];
    level.ref_12a12.ref_12e2c.passes_final_capsule_check = level.ref_12a12.ref_12e2c.ref_1354f;
    thread ref_1283f();
}

// Params 0
// Size: 0x2cc
function ref_1283f()
{
    level.ref_12ab4 = [];
    level.ref_12ab4[ "allies" ] = [];
    level.ref_12ab4[ "axis" ] = [];
    var0 = getdvarint( "scr_br_teamsize", 50 );
    var1 = getdvarint( "scr_rat_race_spawn_trace_count", 5 );
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    var2 = 0;
    var3 = scripts\mp\teams::ref_132e6();
    
    foreach ( var5 in level.teamnamelist )
    {
        if ( var3 && var5 == "team_two_hundred" )
        {
            continue;
        }
        
        for ( var6 = 0; var6 < var0 ; var6++ )
        {
            var7 = spawnstruct();
            var8 = vectortoangles( level.ref_12a12.ref_12e2c.ref_136a8[ var5 ] );
            var9 = randomfloatrange( level.ref_12a12.ref_12e2c.ref_13608[ var5 ], level.ref_12a12.ref_12e2c.ref_13607[ var5 ] );
            var10 = anglestoforward( ( 0, var8[ 1 ] + scripts\engine\utility::ter_op( scripts\engine\utility::cointoss(), var9, var9 * -1 ), 0 ) );
            var11 = randomfloatrange( level.ref_12a12.ref_12e2c.ref_13631[ var5 ], level.ref_12a12.ref_12e2c.ref_13630[ var5 ] );
            var12 = level.ref_12a12.ref_12e2c.ground_detection_think + var10 * level.ref_12a12.ref_12e2c.circle_radius * var11;
            
            if ( istrue( level.ref_12a12.ref_12e2c.passes_final_capsule_check ) )
            {
                var13 = level.ref_12a12.ref_12e2c.spawnorigin[ scripts\mp\utility\game::getotherteam( var5 )[ 0 ] ] - var12;
                var8 = vectortoangles( var13 );
            }
            else
            {
                var8 = vectortoangles( var10 * -1 );
            }
            
            var14 = scripts\engine\trace::create_default_contents( 1 );
            var15 = 0;
            var16 = 0;
            var17 = 10;
            var18 = [];
            
            for ( var19 = 0; var19 < var1 ; var19++ )
            {
                var20 = scripts\engine\trace::ray_trace( var12 + ( 0, 0, 10000 ), var12 - ( 0, 0, 20000 ) + anglestoforward( var8 ) * var19 * 2000, undefined, var14 )[ "position" ];
                var18 = var20;
                
                if ( var20[ 2 ] > var15 )
                {
                    var15 = var20[ 2 ];
                    var16 = var19;
                }
                
                var2++;
                
                if ( var2 == 5 )
                {
                    waitframe();
                    var2 = 0;
                }
            }
            
            var12 = ( var12[ 0 ], var12[ 1 ], var15 + level.ref_12a12.ref_12e2c.ref_1365e[ var5 ] );
            var7.origin = var12;
            var7.ref_13c33 = var18;
            var7.spawn_exfil_heli = var16;
            var7.angles = var8;
            var7.time = gettime();
            var7.team = var5;
            var7.index = -1;
            level.ref_12ab4[ var5 ][ level.ref_12ab4[ var5 ].size ] = var7;
        }
    }
}

// Params 0
// Size: 0x4b
function rear_door_collision()
{
    if ( !isdefined( self.ref_12ab3 ) )
    {
        self.ref_12ab3 = spawnstruct();
        return ppkteamnoflag();
    }
    
    if ( self.ref_12ab3.team != self.team || self.ref_12ab3.lifeid != self.lifeid )
    {
        return ppkteamnoflag();
    }
    
    return self.ref_12ab3;
}

// Params 0
// Size: 0x8d
function ppkteamnoflag()
{
    var0 = randomint( level.ref_12ab4[ self.team ].size );
    var1 = level.ref_12ab4[ self.team ][ var0 ];
    self.ref_12ab3.origin = var1.origin;
    self.ref_12ab3.angles = var1.angles;
    self.ref_12ab3.time = gettime();
    self.ref_12ab3.team = self.team;
    self.ref_12ab3.index = -1;
    self.ref_12ab3.lifeid = self.lifeid;
    return self.ref_12ab3;
}

// Params 0
// Size: 0x2
function activate_laser_trap()
{
    
}

// Params 0
// Size: 0x107
function manage_fakebody_hides()
{
    scripts\mp\deathicons::ref_12bfd();
    
    for ( var0 = 0; var0 < level.players.size ; var0++ )
    {
        var1 = level.players[ var0 ];
        
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        if ( !isalive( var1 ) )
        {
            var1 scripts\mp\playerlogic::spawnplayer( 0 );
        }
        
        if ( istrue( var1.delay_enter_combat_after_investigating_grenade ) )
        {
            scripts\mp\gametypes\br::ref_13f21( var1 );
        }
        
        var1 setclientomnvar( "ui_br_infil_started", 1 );
        var1 setclientomnvar( "ui_br_infiled", 1 );
        var1 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
        var2 = rear_door_collision( var1 );
        var3 = var1 scripts\mp\gametypes\br_gulag::ref_1263e( var2 );
    }
    
    level.dmztut_endgametransition = 1;
    wait 2;
    
    foreach ( var1 in level.players )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        thread ref_12496();
    }
    
    thread ref_138cc();
    scripts\mp\flags::gameflagset( "prematch_fade_done" );
    scripts\mp\flags::gameflagset( "infil_complete" );
    waitframe();
    
    if ( isdefined( level.br_pickups ) )
    {
        spawn_br_plunder_dispensers();
    }
    
    ref_13514();
    setomnvar( "ui_br_circle_state", 4 );
}

// Params 0
// Size: 0x13
function ref_138cc()
{
    level endon( "game_ended" );
    wait 10;
    level thread scripts\mp\music_and_dialog::stopsuspensemusic();
}

// Params 0
// Size: 0x72
function ref_12496()
{
    self endon( "disconnect" );
    scripts\mp\gametypes\br_public::ref_1264c();
    self.ref_133e7 = 1;
    self.ref_12ca8 = 1;
    self.plotarmor = 1;
    
    if ( !isalive( self ) )
    {
        scripts\mp\playerlogic::spawnplayer( 0 );
    }
    
    if ( istrue( self.delay_enter_combat_after_investigating_grenade ) )
    {
        scripts\mp\gametypes\br::ref_13f21( self );
    }
    
    waitframe();
    thread patch_far_wait();
    scripts\mp\gametypes\br_public::ref_126ed();
    self.plotarmor = undefined;
    self.ref_12ca8 = undefined;
    self.elevator_manager = 1;
    self freezecontrols( 1 );
    self playerhide();
    thread ref_12495();
}

// Params 0
// Size: 0x1d
function patch_far_wait()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

// Params 0
// Size: 0x91
function ref_12495()
{
    self endon( "disconnect" );
    scripts\cp_mp\execution::_clearexecution();
    scripts\mp\gametypes\br_pickups::initplayer();
    var0 = rear_door_collision();
    var1 = scripts\mp\gametypes\br_gulag::ref_1263e( var0 );
    scripts\mp\gametypes\br_gulag::gulagwinnerrespawn( 1, undefined, var0, 1, var1, 1, undefined, undefined, undefined, 1 );
    
    if ( istrue( self.delay_enter_combat_after_investigating_grenade ) )
    {
        scripts\mp\gametypes\br::ref_13f21( self );
    }
    
    _calloutmarkerping_handleluinotify_added::ref_13133( "ui_br_transition_type", 0 );
    scripts\mp\damage::resetplayervariables();
    waittillframeend();
    self clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
    self clearsoundsubmix( "deaths_door_mp", 1 );
    self.ref_133e7 = 0;
    scripts\mp\gametypes\br::ending_fade_in();
    thread ref_13ee7();
    thread init_infil();
    self notify( "do_welcome_splashes" );
}

// Params 0
// Size: 0x2
function ____fulton_extraction_logic()
{
    
}

// Params 0
// Size: 0x26
function init_plunder_fulton_overrides()
{
    var0 = "equip_mp_fulton";
    var1 = scripts\mp\gametypes\br_plunder::ref_1278c( var0 );
    
    if ( level.¢ã#“‹Öâ6+8±’‹2≤'â¬7≠KÕù )
    {
        var1.ref_14068 = &plunder_repositoryplayerplundereventcallback_vaulttransfer;
        return;
    }
}

// Params 0
// Size: 0x2
function ____helicopter_helipad_extraction_logic()
{
    
}

// Params 0
// Size: 0xf1
function init_plunder_heli_overrides()
{
    if ( level.ô∞[+†ˇÂ±íAÿˆ&“Ì¿¯(≤≈H:¢	_< )
    {
        GscBinSkip1( 0x45, 0, scripts\mp\gametypes\br_plunder::ref_1278c( "plunderHelipad1" ) );
        // Unknown operator ( 0x45, iw8, PC )
    }
}

// Params 0
// Size: 0x2
function ____extraction_object_utility_logic()
{
    
}

// Params 3
// Size: 0x52
function plunder_repositoryplayerplundereventcallback_vaulttransfer( var0, var1, var2 )
{
    var2 = get_amount_considering_capacity_overfill( var0, var2 );
    var3 = run_died_poorly_funcs( var1.team );
    var4 = get_plundercount_for_player( var3.plunder, var1 );
    scripts\mp\gametypes\br_plunder::ref_1279f( var3, var1, var2 );
    var5 = get_plundercount_for_player( var3.plunder, var1 );
    var6 = var5 - var4;
    add_amount_to_plunder_array( var0, var1, var6 );
}

// Params 2
// Size: 0x47
function find_index_of_player_in_plunder_array( var0, var1 )
{
    if ( isdefined( var0 ) )
    {
        foreach ( var3 in var0 )
        {
            if ( isdefined( var3.player ) && var3.player == var1 )
            {
                return var4;
            }
        }
    }
    
    return undefined;
}

// Params 2
// Size: 0x4d
function get_plundercount_for_player( var0, var1 )
{
    if ( isdefined( var0 ) )
    {
        foreach ( var3 in var0 )
        {
            if ( isdefined( var3.player ) && var3.player == var1 )
            {
                return var3.plundercount;
            }
        }
    }
    
    return 0;
}

// Params 2
// Size: 0x8b
function get_amount_considering_capacity_overfill( var0, var1 )
{
    var2 = scripts\mp\gametypes\br_plunder::ref_1278c( var0.ref_127c8 );
    
    if ( isdefined( var2.get_closest_enemy_near_turret ) && var2.get_closest_enemy_near_turret > 0 )
    {
        var3 = 0;
        
        if ( isdefined( var0.plunder ) )
        {
            foreach ( var5 in var0.plunder )
            {
                var3 += var5.plundercount;
            }
        }
        
        var7 = var2.get_closest_enemy_near_turret - var3;
        
        if ( var1 >= var7 )
        {
            var1 = var7;
            scripts\mp\gametypes\br_plunder::ref_12799( var0 );
        }
    }
    
    return var1;
}

// Params 3
// Size: 0x89
function add_amount_to_plunder_array( var0, var1, var2 )
{
    if ( !isdefined( var0.plunder ) )
    {
        var0.plunder = [];
    }
    
    var3 = find_index_of_player_in_plunder_array( var0.plunder, var1 );
    
    if ( isdefined( var3 ) )
    {
        var0.plunder[ var3 ].plundercount += var2;
        return;
    }
    
    var4 = spawnstruct();
    var4.player = var1;
    var4.team = var1.team;
    var4.plundercount = var2;
    var0.plunder[ var0.plunder.size ] = var4;
}

// Params 0
// Size: 0x2
function activate_emp_drone_func()
{
    
}

// Params 0
// Size: 0xe
function subscribedlocale()
{
    thread issidehouseobjective();
    thread debug_watch_for_rat_race_print_match_info_to_console_dvar();
}

// Params 0
// Size: 0xe0
function issidehouseobjective()
{
    self endon( "game_ended" );
    var0 = "src_br_gametype_rat_race_spawn_vehicle_for_everyone_without_one";
    var1 = "";
    setdvar( var0, var1 );
    
    for ( ;; )
    {
        if ( getdvar( var0, var1 ) != var1 )
        {
            foreach ( var3 in level.players )
            {
                if ( !scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicles( var3 ) )
                {
                    continue;
                }
                
                var4 = var3.origin + ( 300, 300, 100 );
                var5 = var3.angles * ( 0, 1, 0 );
                var6 = spawnstruct();
                var6.origin = var4;
                var6.angles = var5;
                var6.owner = var3;
                var6.spawntype = "DEVGUI";
                var6.immediate = 1;
                var7 = _calloutmarkerping_predicted_isanypingactive::ref_120c1( var6 );
            }
            
            setdvar( var0, var1 );
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x38
function debug_watch_for_rat_race_print_match_info_to_console_dvar()
{
    self endon( "game_ended" );
    var0 = "src_br_gametype_rat_race_print_match_info_to_console";
    var1 = "";
    setdvar( var0, var1 );
    
    for ( ;; )
    {
        if ( getdvar( var0, var1 ) != var1 )
        {
            rat_race_print_match_info_to_console();
            setdvar( var0, var1 );
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x157
function init_infil()
{
    if ( !isdefined( self ) || isai( self ) )
    {
        return;
    }
    
    var0 = spawnstruct();
    var0.player = self;
    var1 = scripts\mp\hud_util::createfontstring( "default", 1.2 );
    var1 scripts\mp\hud_util::setpoint( "TOP", "TOP", 0, 80 );
    var1.color = ( 1, 1, 1 );
    var1.alpha = 0;
    var1.hidewheninmenu = 1;
    var1.label = &"BR_RAT_RACE/PLUNDER_CASH_HUD_TEAM_POCKET_CASH_TITLE";
    var0.ref_121d8 = var1;
    var2 = scripts\mp\hud_util::createfontstring( "default", 1.2 );
    var2 scripts\mp\hud_util::setparent( var1 );
    var2 scripts\mp\hud_util::setpoint( "TOPRIGHT", "TOP", -50, 0 );
    var2.color = ( 0, 0, 1 );
    var2.alpha = 0;
    var2.hidewheninmenu = 1;
    var0.playersetattractionextradata = var2;
    var2 = scripts\mp\hud_util::createfontstring( "default", 1.2 );
    var2 scripts\mp\hud_util::setparent( var1 );
    var2 scripts\mp\hud_util::setpoint( "TOPLEFT", "TOP", 50, 0 );
    var2.color = ( 1, 0, 0 );
    var2.alpha = 0;
    var2.hidewheninmenu = 1;
    var0.nuke_abortkillcamonspawn = var2;
    level.ref_12a12.ref_12482[ level.ref_12a12.ref_12482.size ] = var0;
}

// Params 0
// Size: 0x1d7
function ref_13fa8()
{
    while ( !level.gameended )
    {
        if ( isdefined( level.ref_12a12.ref_12482 ) )
        {
            var0 = getdvarint( "scr_rat_race_plunder_debug_enabled", 1 );
            var1 = [];
            
            for ( var2 = 0; var2 < level.ref_12a12.ref_12482.size ; var2++ )
            {
                var3 = level.ref_12a12.ref_12482[ var2 ];
                var4 = var3.player;
                
                if ( !isdefined( var4 ) )
                {
                    var1 = var3;
                    continue;
                }
                
                if ( isdefined( var3.ref_121d8 ) )
                {
                    var3.ref_121d8.alpha = scripts\engine\utility::ter_op( var0, 1, 0 );
                }
                
                if ( isdefined( var3.playersetattractionextradata ) )
                {
                    ref_13fa9( var3.playersetattractionextradata, rpg_shoot_at_trigs( var4.team ) * 100 );
                    var3.playersetattractionextradata.alpha = scripts\engine\utility::ter_op( var0, 1, 0 );
                }
                
                if ( isdefined( var3.nuke_abortkillcamonspawn ) )
                {
                    var5 = scripts\mp\utility\teams::getenemyteams( var4.team );
                    
                    for ( var6 = 0; var6 < var5.size ; var6++ )
                    {
                        if ( !level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent( var5[ var6 ] ) )
                        {
                            ref_13fa9( var3.nuke_abortkillcamonspawn, rpg_shoot_at_trigs( var5[ var6 ] ) * 100 );
                            var3.nuke_abortkillcamonspawn.alpha = scripts\engine\utility::ter_op( var0, 1, 0 );
                            break;
                        }
                    }
                }
            }
            
            for ( var2 = 0; var2 < var1.size ; var2++ )
            {
                if ( isdefined( var1[ var2 ] ) )
                {
                    handledropbags( var1[ var2 ] );
                }
            }
            
            level.ref_12a12.ref_12482 = scripts\engine\utility::array_remove_array( level.ref_12a12.ref_12482, var1 );
        }
        
        waitframe();
    }
    
    if ( isdefined( level.ref_12a12.ref_12482 ) )
    {
        for ( var2 = 0; var2 < level.ref_12a12.ref_12482.size ; var2++ )
        {
            if ( isdefined( level.ref_12a12.ref_12482[ var2 ] ) )
            {
                handledropbags( level.ref_12a12.ref_12482[ var2 ] );
            }
        }
        
        level.ref_12a12.ref_12482 = undefined;
        return;
    }
}

// Params 1
// Size: 0x5e
function ref_13fa9( var0 )
{
    var1 = 1000000;
    var2 = 1000;
    
    if ( var0 >= var1 )
    {
        var3 = var0 / var1;
        self.label = &"BR_RAT_RACE/PLUNDER_CASH_HUD_IN_MILLIONS";
        self setvalue( var3 );
        return;
    }
    
    if ( var0 >= var2 )
    {
        var3 = var0 / var2;
        self.label = &"BR_RAT_RACE/PLUNDER_CASH_HUD_IN_THOUSANDS";
        self setvalue( var3 );
        return;
    }
    
    self.label = &"MP_BR_INGAME/EXTRACT_PLUNDER";
    self setvalue( var0 );
}

// Params 0
// Size: 0x3f
function handledropbags()
{
    if ( isdefined( self.ref_121d8 ) )
    {
        self.ref_121d8 scripts\mp\hud_util::destroyelem();
    }
    
    if ( isdefined( self.playersetattractionextradata ) )
    {
        self.playersetattractionextradata scripts\mp\hud_util::destroyelem();
    }
    
    if ( isdefined( self.nuke_abortkillcamonspawn ) )
    {
        self.nuke_abortkillcamonspawn scripts\mp\hud_util::destroyelem();
        return;
    }
}

// Params 2
// Size: 0x2c
function build_formatted_key_value_string( var0, var1 )
{
    var2 = "" + var0 + ": ";
    
    if ( isdefined( var1 ) )
    {
        var2 += var1;
    }
    else
    {
        var2 += "undefined";
    }
    
    return var2;
}

// Params 0
// Size: 0x39
function get_game_state_debug_strings()
{
    var0 = spawnstruct();
    var0.é7Ày“æ”Í{A"v` = get_misc_state_list();
    var0.ß˝[üÁCJªËËØõ = get_team_state_list();
    var0.Ü8©˚ZÛx*ÇÎAkÂË#ìc = get_player_state_list();
    var0.ó20ç≈nÃ’+„ {C±í`gm«†≈@òì≥ = get_plunder_repository_state_list();
    return var0;
}

// Params 1
// Size: 0x90
function get_plunder_event_type_as_string( var0 )
{
    switch ( var0 )
    {
        case 1:
            return "PICKUP";
        case 2:
            return "DEPOSIT";
        case 3:
            return "BANK";
        case 4:
            return "LOSE";
        case 5:
            return "BANK_DEPOSIT";
        case 6:
            return "LOSE_DEPOSIT";
        case 7:
            return "DEPOSIT_OR_STEAL";
        case 8:
            return "STEAL";
        case 0:
            return "NONE";
    }
    
    return "Unknown (" + var0 + ")";
}

// Params 0
// Size: 0x79
function get_misc_state_list()
{
    var0 = [];
    GscBinSkip0( 0x2e, var0.size, build_formatted_key_value_string( "Time", gettime() ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x195
function get_team_state_list()
{
    var0 = [];
    
    if ( !isdefined( level.teamnamelist ) )
    {
        return var0;
    }
    
    foreach ( var2 in level.teamnamelist )
    {
        var3 = [];
        var3 = build_formatted_key_value_string( "Team", var2 );
        var3 = build_formatted_key_value_string( "\t Placement       ", game[ "teamPlacements" ][ var2 ] );
        var3 = build_formatted_key_value_string( "\t Score           ", game[ "teamScores" ][ var2 ] );
        var3 = build_formatted_key_value_string( "\t plunderTeamTotal", level.teamdata[ var2 ][ "plunderTeamTotal" ] );
        var3 = build_formatted_key_value_string( "\t plunderInDeposit", level.teamdata[ var2 ][ "plunderInDeposit" ] );
        var3 = build_formatted_key_value_string( "\t plunderBanked   ", level.teamdata[ var2 ][ "plunderBanked" ] );
        var4 = run_died_poorly_funcs( var2 );
        
        if ( !isdefined( var4 ) )
        {
            var3 = build_formatted_key_value_string( "\t Vault           ", "undefined" );
        }
        else
        {
            var3 = build_formatted_key_value_string( "\t Vault           ", var4.ref_127bd );
        }
        
        var5 = scripts\mp\utility\teams::getfriendlyplayers( var2 );
        var3 = build_formatted_key_value_string( "\t Players", var5.size );
        
        foreach ( var7 in var5 )
        {
            var3 = build_formatted_key_value_string( "\t\t Name", var7.name );
        }
        
        if ( !isdefined( var0[ var2 ] ) )
        {
            var0 = [];
        }
        
        var0[ var0[ var2 ].size ] = var3;
    }
    
    return var0;
}

// Params 0
// Size: 0x26d
function get_player_state_list()
{
    var0 = [];
    
    if ( !isdefined( level.players ) )
    {
        return var0;
    }
    
    foreach ( var2 in level.players )
    {
        var3 = [];
        var3 = build_formatted_key_value_string( "Player", var2.name );
        var3 = build_formatted_key_value_string( "\t score        ", var2.score );
        var3 = build_formatted_key_value_string( "\t team         ", var2.team );
        var3 = build_formatted_key_value_string( "\t br_cash_count", var2.br_cash_count );
        var3 = build_formatted_key_value_string( "\t plunderbanked", var2.plunderbanked );
        var3 = build_formatted_key_value_string( "\t plundercount ", var2.plundercount );
        var4 = [];
        
        if ( isdefined( var2.ref_127b9 ) )
        {
            foreach ( var6 in getarraykeys( var2.ref_127b9 ) )
            {
                if ( !isdefined( var4[ var6 ] ) )
                {
                    var4 = spawnstruct();
                }
                
                var4[ var6 ].ref_127b9 = var2.ref_127b9[ var6 ];
            }
        }
        
        if ( isdefined( var2.ref_127b8 ) )
        {
            foreach ( var6 in getarraykeys( var2.ref_127b8 ) )
            {
                if ( !isdefined( var4[ var6 ] ) )
                {
                    var4 = spawnstruct();
                }
                
                var4[ var6 ].ref_127b8 = var2.ref_127b8[ var6 ];
            }
        }
        
        var3 = build_formatted_key_value_string( "\t plunderEvents", var4.size );
        
        foreach ( var6 in getarraykeys( var4 ) )
        {
            var11 = var4[ var6 ];
            
            if ( !isdefined( var11.ref_127b9 ) )
            {
                var11.ref_127b9 = "undefined";
            }
            
            if ( !isdefined( var11.ref_127b8 ) )
            {
                var11.ref_127b8 = "undefined";
            }
            
            var12 = "V" + var11.ref_127b9 + ", T" + var11.ref_127b8 + ", " + get_plunder_event_type_as_string( var6 );
            var3 = build_formatted_key_value_string( "\t\t ", var12 );
        }
        
        var3 = "";
        
        if ( !isdefined( var0[ var2.team ] ) )
        {
            var0 = [];
        }
        
        var0[ var0[ var2.team ].size ] = var3;
    }
    
    return var0;
}

// Params 0
// Size: 0x260
function get_plunder_repository_state_list()
{
    var0 = [];
    
    if ( !isdefined( level.ref_127c7 ) )
    {
        return var0;
    }
    
    foreach ( var2 in level.ref_127c7.instances )
    {
        var3 = [];
        var3 = build_formatted_key_value_string( "Repository", var2.ref_127c8 );
        var3 = build_formatted_key_value_string( "\t team         ", var2.team );
        var3 = build_formatted_key_value_string( "\t ID           ", var2.ref_127bd );
        var3 = build_formatted_key_value_string( "\t plundertotal ", var2.ref_127d0 );
        var3 = build_formatted_key_value_string( "\t plunderusable", var2.ref_127d3 );
        var3 = build_formatted_key_value_string( "\t playersusing", var2.ref_126be.size );
        
        foreach ( var5 in var2.ref_126be )
        {
            var3 = build_formatted_key_value_string( "\t\t Player", var5.name );
        }
        
        var3 = build_formatted_key_value_string( "\t plunder", var2.plunder.size );
        
        foreach ( var8 in var2.plunder )
        {
            var3 = build_formatted_key_value_string( "\t\t Player", var8.player.name );
            var3 = build_formatted_key_value_string( "\t\t\t plundercount", var8.plundercount );
            var3 = build_formatted_key_value_string( "\t\t\t team        ", var8.team );
        }
        
        if ( !isdefined( var2.ref_127b1 ) )
        {
            var3 = build_formatted_key_value_string( "\t plundercountdownplayers", 0 );
        }
        else
        {
            var3 = build_formatted_key_value_string( "\t plundercountdownplayers", var2.ref_127b1.size );
            
            foreach ( var5 in var2.ref_127b1 )
            {
                var3 = build_formatted_key_value_string( "\t\t Player", var5.name );
            }
        }
        
        var3 = "";
        
        if ( isdefined( var2.team ) )
        {
            var12 = var2.team;
        }
        else
        {
            var12 = "undefined";
        }
        
        if ( !isdefined( var0[ var12 ] ) )
        {
            var0 = [];
        }
        
        var0[ var0[ var12 ].size ] = var3;
    }
    
    return var0;
}

// Params 2
// Size: 0x7d
function print_game_state_list_to_console( var0, var1 )
{
    foreach ( var3 in var0 )
    {
        var4 = 0;
        
        foreach ( var6 in var3 )
        {
            foreach ( var8 in var6 )
            {
            }
        }
    }
}

// Params 0
// Size: 0x50
function rat_race_print_match_info_to_console()
{
    var0 = get_game_state_debug_strings();
    print_game_state_list_to_console( var0.é7Ày“æ”Í{A"v`, "Misc" );
    print_game_state_list_to_console( var0.ß˝[üÁCJªËËØõ, "Team" );
    print_game_state_list_to_console( var0.Ü8©˚ZÛx*ÇÎAkÂË#ìc, "Player" );
    print_game_state_list_to_console( var0.ó20ç≈nÃ’+„ {C±í`gm«†≈@òì≥, "Plunder" );
}

