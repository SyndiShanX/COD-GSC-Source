
// Params 0
// Size: 0x3b
function init()
{
    thread enabledfeatures();
    thread enabledskipdeathshield();
    thread enable_traversals_for_bombers();
    thread enabledbasejumping();
    setdvarifuninitialized( "scr_br_rebirth_circle_setting", 0 );
    setdvar( "scr_br_project_kick", 1500 );
    thread enabledskiplaststand();
}

// Params 1
// Size: 0x294
function enabledskiplaststand( var0 )
{
    var1 = getdvar( "scr_br_gametype" );
    
    if ( scripts\cp_mp\utility\game_utility::tutorialzoneenter() )
    {
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_ww2.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle2_ww2.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle3_ww2.csv" );
    }
    else if ( var1 == "rebirth_dbd" )
    {
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_dbd.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle2_dbd.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle3_dbd.csv" );
    }
    else
    {
        timeoutonabandoneddelay( "mp/classtable_br_rebirth.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle2.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle3.csv" );
    }
    
    level.disable_super_in_turret.ref_140a3 = getdvarint( "scr_br_use_tracked_teams", 1 );
    level.disable_super_in_turret.ref_140a5 = getdvarint( "scr_br_use_vengeance", 1 );
    level.disable_super_in_turret.ref_1428b = getdvarint( "scr_br_vengeance_use_any_kill", 0 );
    level.disable_super_in_turret.ref_140a6 = getdvarint( "scr_br_use_vengeance_decrease_respawn_timer", 1 );
    level.disable_super_in_turret.ref_14094 = getdvarint( "scr_br_use_respawn_waves", 0 );
    level.disable_super_in_turret.ref_1408d = getdvarint( "scr_br_use_points_to_reduce_respawn_time", 1 );
    level.disable_super_in_turret.botpickskinid = getdvarfloat( "scr_br_rebirth_aircraft_max_allowed", 30 );
    level.disable_super_in_turret.br_ammo_player_is_maxed_out = getdvarfloat( "scr_br_rebirth_aircraft_type", 1 );
    level.disable_super_in_turret.ëFﬂÉä5{p⁄πG√«KıÒ›à…! = getdvarint( "scr_br_rebirth_starting_loadout_index", 0 );
    level.ref_12ca7 = getdvarint( "scr_bmo_respawnHeightOverride", 7500 );
    level.disable_super_in_turret.ref_12c92 = getdvarint( "scr_br_rebirth_respawn_should_wait_prestreaming_end", 0 );
    level.disable_super_in_turret.ref_12c91 = getdvarint( "scr_br_rebirth_respawn_should_notify_started_spawn", 1 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "circleTimer", &circletimer );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "mayConsiderPlayerDead", &empty_function );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "triggerRespawnOverlay", &end_silo_thrust );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerNakedDropLoadout", &end_intro_obj );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerDropLoadout", &brrebirth_playerdroploadout );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "getDefaultLoadout", &enable_spawner );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "kioskRevivePlayer", &enablejuggernautcrateobjective );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "dropOnPlayerDeath", &droponplayerdeath );
    
    if ( getdvarint( "scr_br_custom_final_circle_override", 0 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "mapCenterFinalCircle", &ref_12181 );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "getFinalCircleCenter", &ref_12181 );
    }
    
    if ( !istrue( level.tryupdategenericprogress ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerKilled", &end_game_tutorial_func );
    }
    
    if ( istrue( var0 ) )
    {
        brrebirth_initneverendingresurgence();
    }
    
    waittillframeend();
    
    if ( level.disable_super_in_turret.ref_1408d )
    {
        level.ref_12073 = &end_game_win;
    }
    
    scripts\mp\gametypes\br_skydive_protection::init();
    tomastrike_findoptimallaunchpos();
    thread end_paratroopers_group();
    thread end_reach_exhaust_waste();
    thread end_reach_icbm_launch();
    thread end_origin_final();
    thread end_pipe_room();
}

// Params 0
// Size: 0x62
function enabledfeatures()
{
    if ( getdvarint( "scr_br_rebirth_debug", 0 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "allowLateJoiners" );
    }
    
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "randomizeCircleCenter" );
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "planeSnapToOOB" );
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "planeUseCircleRadius" );
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "circleEarlyStart" );
        return;
    }
}

// Params 0
// Size: 0x9c
function enabledskipdeathshield()
{
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0 )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "createC130PathStruct", &enable_leaderboard );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "addToC130Infil", &emp_target_monitor );
        
        if ( getdvarint( "scr_rebirth_shouldSetInitalDropDelay", 1 ) == 1 )
        {
            thread end_nuke_vault();
        }
    }
    
    waittillframeend();
    level.ontimelimit = &end_gates;
    enable_keypad_interaction();
    level.ref_140d9 = [];
    level.ref_140d9[ 0 ] = "assassination";
    level.ref_140d9[ 1 ] = "domination";
    level.ref_140d9[ 2 ] = "scavenger";
    scripts\mp\rank::ref_12189( "kill", 100 );
    scripts\mp\rank::ref_12189( "br_cacheOpen", 200 );
}

// Params 4
// Size: 0x8c
function loop( var0, var1, var2, var3 )
{
    var4 = var0 getentitynumber();
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = 0;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var5 = 4;
    var6 = var5;
    var7 = 8;
    var8 = var6 + var7;
    var9 = 16;
    var10 = 0;
    var11 = var8 + var9;
    
    foreach ( var13 in var3 )
    {
        var10 |= var13 << var11;
        var11++;
    }
    
    var15 = 0;
    var15 = var10 | var2 << var8 | var4 << var6 | var1;
    self setclientomnvar( "ui_br_expanded_obit_message", var15 );
}

// Params 5
// Size: 0x3f
function loop_emp_spark_vfx( var0, var1, var2, var3, var4 )
{
    foreach ( var6 in scripts\mp\utility\teams::getteamdata( var0, "players" ) )
    {
        loop( var6, var1, var2, var3, var4 );
    }
}

// Params 3
// Size: 0xfb
function end_game_cheer( var0, var1, var2 )
{
    if ( getdvarint( "scr_br_notify_team_vengeance", 1 ) == 0 )
    {
        return;
    }
    
    var3 = var1 getentitynumber();
    var4 = var0 getentitynumber();
    var5 = [];
    var6 = 1;
    var7 = scripts\mp\utility\teams::getteamdata( level.players[ var4 ].team, "players" );
    
    foreach ( var9 in var7 )
    {
        if ( var9 == level.players[ var4 ] )
        {
            var5 = 0;
            var6++;
            continue;
        }
        
        var5 = 0;
        
        foreach ( var11 in var2 )
        {
            if ( var9 == var11 )
            {
                var5 = 1;
                break;
            }
        }
        
        var6++;
    }
    
    for ( var14 = var6; var14 < 4 ; var14++ )
    {
        var5 = 0;
    }
    
    loop_emp_spark_vfx( level.players[ var4 ].team, level.players[ var4 ], 13, var3, var5 );
}

// Params 0
// Size: 0xd5
function enable_traversals_for_bombers()
{
    level endon( "game_ended" );
    level waittill( "br_dialog_initialized" );
    
    if ( level.disable_super_in_turret.name == "rebirth_dbd" )
    {
        game[ "dialog" ][ "match_desc" ] = "gametype_desc_resurgence_trials";
    }
    else
    {
        game[ "dialog" ][ "match_desc" ] = "gametype_desc_resurgence";
    }
    
    game[ "dialog" ][ "match_start" ] = "gametype_resurgence";
    game[ "dialog" ][ "last_man_standing" ] = "rsrg_squad_last_alive";
    game[ "dialog" ][ "rebirth_avenge_teammate" ] = "rebirth_avenge_teammate";
    game[ "dialog" ][ "rebirth_redeploy" ] = "rebirth_redeploy";
    game[ "dialog" ][ "rebirth_disabled" ] = "rebirth_reinforcement_disabled";
    game[ "dialog" ][ "rebirth_ending" ] = "rebirth_reinforcement_ending";
    game[ "dialog" ][ "rebirth_teammate_respawn" ] = "rebirth_teammate_respawn";
}

// Params 0
// Size: 0x15
function brrebirth_initdialogrespawndisabled()
{
    game[ "dialog" ][ "last_man_standing" ] = "rebirth_last_alive";
}

// Params 0
// Size: 0x39
function enable_keypad_interaction()
{
    scripts\cp_mp\utility\game_utility::ref_12c10( "delete_on_load", "targetname" );
    scripts\cp_mp\utility\game_utility::ref_12c11( "door_prison_cell_metal_mp", 1 );
    scripts\cp_mp\utility\game_utility::ref_12c11( "door_wooden_panel_mp_01", 1 );
    scripts\cp_mp\utility\game_utility::ref_12c11( "me_electrical_box_street_01", 1 );
}

// Params 0
// Size: 0x2
function enabledbasejumping()
{
    
}

// Params 0
// Size: 0x2d
function end_paratroopers_group()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    level.disable_super_in_turret.ref_12ca4 = 1;
}

// Params 0
// Size: 0xc2
function end_reach_exhaust_waste()
{
    waittillframeend();
    var0 = level.allteamnamelist;
    
    foreach ( var2 in var0 )
    {
        level.teamdata[ var2 ][ "index" ] = var3;
    }
    
    var4 = getdvarint( "scr_br_tracked_teams_for_entire_team", 0 );
    
    if ( istrue( var4 ) )
    {
        foreach ( var2 in level.teamdata )
        {
            level.teamdata[ var6 ][ "trackedTeams" ] = [];
        }
        
        return;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    
    foreach ( var8 in level.players )
    {
        var8.ref_13c4b = [];
    }
}

// Params 0
// Size: 0x35
function end_reach_icbm_launch()
{
    foreach ( var1 in level.teamdata )
    {
        level.teamdata[ var2 ][ "deadPlayers" ] = [];
    }
}

// Params 0
// Size: 0x1a
function end_gates()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread scripts\mp\gametypes\br::startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Params 1
// Size: 0x3f, Type: bool
function empty_function( var0 )
{
    if ( scripts\mp\flags::gameflag( "prematch_done" ) && scripts\mp\flags::gameflag( "prematch_fade_done" ) )
    {
        thread end_unlock_silo();
        
        if ( !istrue( level.disable_super_in_turret.ä≥ãUS∑@3rmÕ8|ãå
[”∂?Ô∏'ù ) )
        {
            scripts\mp\gametypes\br::ref_11b15( var0 );
        }
    }
    
    return true;
}

// Params 1
// Size: 0x64
function end_freight_lift( var0 )
{
    foreach ( var2 in scripts\mp\utility\teams::getteamdata( var0.team, "players" ) )
    {
        if ( !istrue( var2.shouldgamelobbyremainintact ) && isalive( var2 ) && var0 != var2 )
        {
            var2.shouldgamelobbyremainintact = 1;
            var2 thread scripts\mp\hud_message::showsplash( "br_rebirth_first_dead" );
        }
    }
}

// Params 0
// Size: 0x37
function end_health()
{
    if ( !isdefined( self.endgame_finitewaves_music ) )
    {
        self.endgame_finitewaves_music = 0;
    }
    
    var0 = self.endgame_finitewaves_music;
    
    if ( var0 > 255 )
    {
        var0 = 255;
    }
    
    self.extrascore0 = var0;
    self.pers[ "extrascore0" ] = var0;
    return var0;
}

// Params 2
// Size: 0xc0
function end_trans_1_obj( var0, var1 )
{
    var2 = !istrue( level.teamdata[ self.team ][ "teamHadFirstRevive" ] );
    
    if ( var2 )
    {
        level.teamdata[ self.team ][ "teamHadFirstRevive" ] = 1;
    }
    
    foreach ( var4 in var0 )
    {
        if ( !isdefined( var4.endgame_finitewaves_music ) )
        {
            var4.endgame_finitewaves_music = 0;
        }
        
        var4.endgame_finitewaves_music++;
        
        if ( scripts\mp\utility\game::round_vehicle_logic() != "mendota" )
        {
            var4 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "reviveCount", var4.endgame_finitewaves_music );
            end_health( var4 );
        }
        
        var5 = !isdefined( var1 ) || var4 != var1;
        var6 = var2 && var5;
        
        if ( var6 )
        {
            var4 thread scripts\mp\hud_message::showsplash( "br_rebirth_first_revive" );
        }
    }
}

// Params 2
// Size: 0x37
function enablejuggernautcrateobjective( var0, var1 )
{
    var2 = self;
    var2 thread scripts\mp\gametypes\br_gulag::playergulagautowin( "rebirth", var0, var1 );
    end_trans_1_obj( var2, level.teamdata[ var2.team ][ "alivePlayers" ], var0 );
    end_jugg_maze();
}

// Params 1
// Size: 0x24, Type: bool
function droponplayerdeath( var0 )
{
    if ( istrue( level.disable_super_in_turret.ì‘ OøKx®∏C¡É[HsÄ ) && !isdefined( self.ref_12eb0 ) )
    {
        scripts\mp\gametypes\br::ref_125fc();
    }
    
    return false;
}

// Params 1
// Size: 0xd1
function end_game_tutorial_func( var0 )
{
    if ( !istrue( level.br_prematchstarted ) )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( var0.victim ) )
    {
        return;
    }
    
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "preOnPlayerKilled", var0 );
    thread end_freight_lift( var0.victim );
    
    if ( !isdefined( var0.attacker ) || !isplayer( var0.attacker ) || var0.attacker == var0.victim )
    {
        return;
    }
    
    var1 = scripts\mp\utility\teams::getteamdata( var0.attacker.team, "aliveCount" );
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    end_this_module( var0.attacker, var0.attacker.team, var0.victim.team );
    thread end_slow_mode_safe( var0.attacker, var0.attacker.team );
}

// Params 2
// Size: 0x1c
function end_this_module( var0, var1 )
{
    if ( !level.disable_super_in_turret.ref_140a3 )
    {
        return;
    }
    
    end_silo_jump( var0, var1 );
}

// Params 2
// Size: 0x67
function end_slow_mode_safe( var0, var1 )
{
    level endon( "game_ended" );
    
    if ( !level.disable_super_in_turret.ref_140a5 )
    {
        return;
    }
    
    if ( !istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        return;
    }
    
    var2 = scripts\mp\utility\teams::getteamdata( var0, "aliveCount" );
    
    if ( var2 <= 0 )
    {
        return;
    }
    
    var3 = level.teamdata[ var0 ][ "deadPlayers" ];
    
    if ( var3.size <= 0 )
    {
        return;
    }
    
    var4 = enable_super( var3, var1 );
    empty_collision_handler( var4, var1 );
}

// Params 2
// Size: 0xb8
function enable_super( var0, var1 )
{
    var2 = [];
    jumpiffalse(istrue( level.disable_super_in_turret.ref_1428b )) LOC_00000056;
    
    foreach ( var4 in var0 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var2 = scripts\engine\utility::array_add( var2, var4 );
        break;
    }
    
    goto LOC_000000b5;
}

// Params 2
// Size: 0x70
function empty_collision_handler( var0, var1 )
{
    if ( var0.size <= 0 )
    {
        return;
    }
    
    foreach ( var3 in var0 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        empendearly( var3 );
    }
    
    if ( !istrue( level.disable_super_in_turret.ref_140a6 ) )
    {
        end_game_cheer( self, var1, var0 );
    }
    
    thread scripts\mp\events::killeventtextpopup( "br_rebirth_vengeance", 0, 0 );
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "rebirth_avenge_teammate", self );
}

// Params 1
// Size: 0x4b
function empendearly( var0 )
{
    if ( istrue( level.disable_super_in_turret.ref_140a6 ) )
    {
        var0.ref_12ca1 -= getdvarint( "scr_br_vengeance_decrease_respawn_delay", 5 );
        return;
    }
    
    thread enable_oob_immunity_on_riders( var0, 1 );
}

// Params 1
// Size: 0x49
function play_track_damage_screen_vfx( var0 )
{
    var1 = -1;
    var2 = 2147483647;
    
    foreach ( var4 in var0 )
    {
        if ( var4[ "startTime" ] < var2 )
        {
            var1 = var5;
            var2 = var4[ "startTime" ];
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x12
function getteamindex( var0 )
{
    return level.teamdata[ var0 ][ "index" ];
}

// Params 2
// Size: 0x3f
function start_reach_pipe_room( var0, var1 )
{
    var2 = -1;
    
    foreach ( var4 in var0 )
    {
        if ( var4[ "name" ] == var1 )
        {
            var2 = var5;
            break;
        }
    }
    
    return var2;
}

// Params 3
// Size: 0x3a
function ref_14023( var0, var1, var2 )
{
    var3 = int( pow( 2, 8 ) );
    var4 = 8 * var2;
    var5 = var3 - 1;
    var5 <<= var4;
    var6 = ~var5;
    var0 &= var6;
    var7 = var1 << var4;
    var0 |= var7;
    return var0;
}

// Params 3
// Size: 0x56
function ref_14029( var0, var1, var2 )
{
    var3 = -1;
    
    foreach ( var5 in var0 )
    {
        if ( isdefined( var5 ) )
        {
            if ( var3 < 0 )
            {
                var3 = var5 calloutmarkerping_entityzoffset( "rebirth_tracked_teams" );
                var3 = ref_14023( var3, var1, var2 );
            }
            
            var5 setclientomnvar( "rebirth_tracked_teams", var3 );
        }
    }
}

// Params 0
// Size: 0x41
function run_lbravo_spawner()
{
    var0 = getdvarint( "scr_br_tracked_teams_for_entire_team", 0 );
    var1 = [];
    
    if ( istrue( var0 ) )
    {
        var1 = scripts\mp\utility\teams::getteamdata( self.team, "trackedTeams" );
    }
    else
    {
        if ( !isdefined( self.ref_13c4b ) )
        {
            self.ref_13c4b = [];
        }
        
        var1 = self.ref_13c4b;
    }
    
    return var1;
}

// Params 2
// Size: 0x4e
function end_silo_jump( var0, var1 )
{
    var2 = -1;
    var3 = run_lbravo_spawner();
    var2 = start_reach_pipe_room( var3, var1 );
    
    if ( var2 < 0 )
    {
        if ( var3.size == 4 )
        {
            var2 = play_track_damage_screen_vfx( var3 );
        }
        else
        {
            var2 = var3.size;
        }
    }
    
    if ( var2 < 0 || var2 >= 4 )
    {
        return;
    }
    
    thread end_silo_elevator( var0, var1, var2 );
}

// Params 3
// Size: 0xb4
function end_silo_elevator( var0, var1, var2 )
{
    if ( var2 < 0 || var2 >= 4 )
    {
        return;
    }
    
    var3 = "trackTeam" + var0 + var2;
    var4 = [];
    var5 = [];
    GscBinSkip0( 0x2e, "name", var1 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x126
function end_origin_final()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) == 0 )
    {
        level waittill( "infils_ready" );
    }
    
    var0 = rocket_attack_min_cooldown();
    var1 = 0;
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) )
    {
        var1 = 1;
    }
    
    for ( var2 = 0; var2 < var0 ; var2++ )
    {
        var1 += level.br_level.br_circleclosetimes[ var2 ] + level.br_level.br_circledelaytimes[ var2 ];
    }
    
    var3 = int( var1 * 1000 );
    var4 = gettime();
    var5 = var4 + var3;
    setomnvarforallclients( "ui_br_plunder_extract_end_time", var5 );
    level.ally_movement_defend_0 = var1;
    var6 = var3;
    var7 = getdvarint( "scr_br_rebirth_show_respawn_closed_timer_max_time", 90000 );
    thread end_mine_caves( var6 / 1000 );
    
    while ( var6 > var7 )
    {
        wait ( var6 - var7 ) / 1000;
        var8 = gettime() - var4;
        var6 = var3 - var8;
    }
    
    setomnvarforallclients( "ui_br_plunder_extract_end_time", int( gettime() + var6 ) );
    
    foreach ( var10 in level.players )
    {
        if ( !isdefined( var10 ) )
        {
            continue;
        }
        
        var10 thread scripts\mp\hud_message::showsplash( "br_rebirth_reinforcement_closing" );
    }
}

// Params 1
// Size: 0x14
function end_mine_caves( var0 )
{
    wait var0 - 90;
    scripts\mp\gametypes\br_public::brleaderdialog( "rebirth_ending" );
}

// Params 0
// Size: 0x9e
function end_pipe_room()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    level.disable_super_in_turret.ref_12ca1 = [];
    level.disable_super_in_turret.ref_14093 = getdvarint( "scr_br_use_respawn_delay_per_circle", 1 );
    
    if ( level.disable_super_in_turret.ref_14093 )
    {
        var0 = rocket_attack_min_cooldown();
        
        for ( var1 = 0; var1 < var0 ; var1++ )
        {
            level.disable_super_in_turret.ref_12ca1[ var1 ] = getdvarint( "scr_br_rebirth_respawn_delay_circle" + var1 + 1, 30 );
        }
        
        return;
    }
    
    level.disable_super_in_turret.ref_12ca1[ 0 ] = getdvarint( "scr_br_rebirth_respawn_delay", 30 );
}

// Params 0
// Size: 0x20
function brrebirth_hiderebirthrespawntimer()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer" );
    var1 = var0 & ~16384;
    self setclientomnvar( "ui_rebirthRespawnTimer", var1 );
}

// Params 0
// Size: 0x1f
function brrebirth_showrebirthrespawntimer()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer" );
    var1 = var0 | 16384;
    self setclientomnvar( "ui_rebirthRespawnTimer", var1 );
}

// Params 0
// Size: 0x1f
function brrebirth_setrebirthrespawntimervengeanceflag()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer" );
    var1 = var0 | 32768;
    self setclientomnvar( "ui_rebirthRespawnTimer", var1 );
}

// Params 0
// Size: 0x20
function brrebirth_resetrebirthrespawntimervengeanceflag()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer" );
    var1 = var0 & ~32768;
    self setclientomnvar( "ui_rebirthRespawnTimer", var1 );
}

// Params 1
// Size: 0x27
function brrebirth_setrebirthrespawntimervalue( var0 )
{
    var1 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer" );
    var2 = var1 & ~16383;
    var3 = var2 | var0;
    self setclientomnvar( "ui_rebirthRespawnTimer", var3 );
}

// Params 1
// Size: 0x4a
function brrebirth_setrebirthrespawntimerdeltavalue( var0 )
{
    var1 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer" );
    var2 = var1 & ~2147418112;
    var3 = var1 & 1073741824;
    
    if ( var3 != 0 )
    {
        var3 = 0;
    }
    else
    {
        var3 = 1073741824;
    }
    
    var4 = var2 | var0 << 16 | var3;
    self setclientomnvar( "ui_rebirthRespawnTimer", var4 );
}

// Params 1
// Size: 0x6b, Type: bool
function carriable_init( var0 )
{
    var1 = scripts\mp\utility\teams::getteamdata( var0.team, "players" );
    
    foreach ( var3 in var1 )
    {
        var4 = var3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
        var5 = isalive( var3 ) && !istrue( var3.inlaststand );
        
        if ( var3 != var0 && var5 && !var4 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x5f
function end_ml_p3_exfil()
{
    var0 = self;
    
    if ( var0 scripts\mp\gametypes\br_gulag::ref_12517() )
    {
        end_trans_1_obj( var0, level.teamdata[ var0.team ][ "alivePlayers" ] );
        end_jugg_maze();
        var0 scripts\mp\playerlogic::addtoalivecount( "rebirth1" );
        scripts\mp\gametypes\br::ref_13f21( var0, "rebirth1" );
        var1 = scripts\mp\gametypes\br::dynamic_door( var0 );
        
        if ( !var1 )
        {
            scripts\mp\gametypes\br_gulag::entergulag( var0 );
        }
        
        self.waitingtospawn = 0;
        return;
    }
}

// Params 0
// Size: 0x8c
function empty_vo_func()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "doingRespawn" );
    
    if ( istrue( level.disable_super_in_turret.ref_14081 ) )
    {
        while ( carriable_init( self ) )
        {
            waitframe();
        }
        
        brrebirth_hiderebirthrespawntimer();
        self notify( "squad_wiped" );
        waitframe();
        end_ml_p3_exfil();
        return;
    }
    
    for ( var0 = scripts\mp\utility\teams::getteamdata( self.team, "aliveCount" ); var0 > 0 ; var0 = scripts\mp\utility\teams::getteamdata( self.team, "aliveCount" ) )
    {
        waitframe();
    }
    
    brrebirth_hiderebirthrespawntimer();
    scripts\mp\gametypes\br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
    self notify( "squad_wiped" );
}

// Params 4
// Size: 0x288
function end_game_win( var0, var1, var2, var3 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( !isalive( var0 ) )
    {
        return;
    }
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) || !scripts\mp\flags::gameflag( "prematch_fade_done" ) )
    {
        return;
    }
    
    if ( isdefined( var2 ) && isdefined( var3 ) && var2 == "br_kioskBuy" && var3 == "br_team_revive" )
    {
        var4 = scripts\mp\utility\teams::getteamdata( var0.team, "aliveCount" );
        var5 = scripts\mp\utility\teams::getteamdata( var0.team, "teamCount" );
        var6 = var5 - var4;
        
        if ( var6 == 1 )
        {
            return;
        }
    }
    
    var7 = getdvarfloat( "scr_br_rebirth_points_to_second_ratio", 0.02 );
    var8 = getdvarint( "scr_br_rebirth_points_to_first_second_offset", 50 );
    var9 = int( floor( ( var1 + var8 ) * var7 ) );
    
    if ( isdefined( var2 ) )
    {
        if ( var2 == "br_kioskBuy" )
        {
            var10 = getdvarfloat( "scr_br_rebirth_points_to_second_kiosk_buy_ratio", 0.3 );
            var9 = int( ceil( var9 * var10 ) );
        }
        else if ( var2 == "kill" )
        {
            var9 = int( floor( ( 250 + var8 ) * var7 ) );
        }
        else if ( var2 == "br_cacheOpen" )
        {
            var9 = int( floor( ( 100 + var8 ) * var7 ) );
        }
    }
    
    if ( var9 <= 0 )
    {
        return;
    }
    
    var11 = level.teamdata[ var0.team ];
    
    if ( !isdefined( var11 ) )
    {
        return;
    }
    
    if ( isdefined( level.obit_activation ) && isdefined( level.obit_activation.ref_121ad ) && isdefined( level.obit_activation.ref_129d1 ) && var0.team == level.obit_activation.ref_129d1 )
    {
        var9 *= level.obit_activation.ref_121ad;
    }
    
    var12 = var11[ "deadPlayers" ];
    
    if ( !isdefined( var12 ) )
    {
        return;
    }
    
    var13 = 0;
    
    foreach ( var15 in var12 )
    {
        if ( isdefined( var15 ) && isdefined( var15.player ) && var15.player != var0 )
        {
            if ( var15.player.ref_12ca1 > 0 )
            {
                var15.player.ref_12ca1 = int( max( 0, var15.player.ref_12ca1 - var9 ) );
                
                if ( !isdefined( var15.player.ref_12ca3 ) )
                {
                    var15.player.ref_12ca3 = 0;
                }
                
                var15.player.ref_12ca3 += var9;
                var13 = 1;
            }
        }
    }
    
    if ( var13 )
    {
        if ( istrue( var0.alternate_breach_anim_func ) )
        {
            var0.ally_spawns += var9;
            return;
        }
        
        var0.alternate_breach_anim_func = 1;
        var0.ally_spawns = var9;
        thread end_reach_wind_room();
        return;
    }
}

// Params 0
// Size: 0x47
function end_reach_wind_room()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "squad_wiped" );
    wait 0.5;
    
    if ( isdefined( self.ally_spawns ) && self.ally_spawns > 0 )
    {
        brrebirth_setrebirthrespawntimerdeltavalue( self.ally_spawns );
    }
    
    self.ally_spawns = undefined;
    self.alternate_breach_anim_func = 0;
}

// Params 0
// Size: 0x327
function end_unlock_silo()
{
    if ( !istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        return;
    }
    
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var0 endon( "squad_wiped" );
    var0 endon( "force_stop_respawn" );
    
    if ( !istrue( level.disable_super_in_turret.ä≥ãUS∑@3rmÕ8|ãå
[”∂?Ô∏'ù ) )
    {
        thread empty_vo_func();
    }
    
    thread enable_motionblur();
    
    if ( isdefined( level.disable_super_in_turret.ref_12a7b ) )
    {
        var0.ref_12ca1 = level.disable_super_in_turret.ref_12a7b;
    }
    else
    {
        var1 = int( min( level.br_circle.circleindex, level.disable_super_in_turret.ref_12ca1.size - 1 ) );
        var1 = int( max( var1, 0 ) );
        var0.ref_12ca1 = level.disable_super_in_turret.ref_12ca1[ var1 ];
        
        if ( istrue( level.disable_super_in_turret.ref_14094 ) )
        {
            var0.ref_12ca1 = level.disable_super_in_turret.ref_1452f;
        }
    }
    
    if ( !isdefined( var0.ref_12ca1 ) )
    {
        var2 = "Respawn delay was not properly set. scr_br_rebirth_respawn_delay or scr_br_rebirth_respawn_delay_circle should have been set. Defaulting to 30 'level.br_circle.circleIndex' is set to " + scripts\engine\utility::ter_op( isdefined( level.br_circle.circleindex ), level.br_circle.circleindex, "undefined" ) + " " + "'level.brGametype.rebirthDelayOverride' is set to " + scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.ref_12a7b ), level.disable_super_in_turret.ref_12a7b, "undefined" );
        var3 = "\n";
        var4 = getarraykeys( game[ "flags" ] );
        
        foreach ( var6 in var4 )
        {
            var3 += var6 + " -> " + game[ "flags" ][ var6 ] + "\n";
        }
        
        var2 += var3;
        scripts\mp\utility\script::laststand_dogtags( var2 );
        var0.ref_12ca1 = 30;
    }
    
    if ( getdvarint( "rebirth_no_respawn_bug_check", 1 ) == 1 && isalive( var0 ) )
    {
        scripts\mp\utility\script::laststand_dogtags( "Alive player added to rebirth countdown. IsAlive: " + isalive( var0 ) + ". Sessionstate: " + var0.sessionstate );
        waitframe();
        scripts\mp\utility\script::laststand_dogtags( "Alive player added to rebirth countdown - after waitframe. IsAlive: " + isalive( var0 ) + ". Sessionstate: " + var0.sessionstate );
    }
    
    brrebirth_resetrebirthrespawntimervengeanceflag( var0 );
    brrebirth_showrebirthrespawntimer( var0 );
    brrebirth_setrebirthrespawntimervalue( var0, var0.ref_12ca1 );
    var0.ref_12ca3 = 0;
    
    while ( var0.ref_12ca1 > 0 )
    {
        if ( isalive( var0 ) )
        {
            var0.ref_12ca1 = 0;
        }
        else
        {
            brrebirth_setrebirthrespawntimervalue( var0, var0.ref_12ca1 );
        }
        
        brrebirth_setrebirthrespawntimerdeltavalue( var0, var0.ref_12ca3 );
        var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "respawnInSeconds", var0.ref_12ca1 );
        var0.ref_12ca3 = 0;
        wait 1;
        var0.ref_12ca1--;
    }
    
    brrebirth_hiderebirthrespawntimer( var0 );
    brrebirth_setrebirthrespawntimerdeltavalue( var0, 0 );
    var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
    
    if ( !isalive( var0 ) )
    {
        if ( isdefined( var0.team ) )
        {
            scripts\mp\gametypes\br_quest_util::lookforvehicles( var0.team, var0, 12, 1 );
            
            foreach ( var9 in level.teamdata[ var0.team ][ "alivePlayers" ] )
            {
                if ( !istrue( var9.showteamtanks ) )
                {
                    thread enable_nvgs();
                }
            }
        }
        
        thread enable_oob_immunity_on_riders( var0, 0 );
        return;
    }
}

// Params 0
// Size: 0x25
function enable_nvgs()
{
    level endon( "game_ended" );
    self.showteamtanks = 1;
    thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "rebirth_teammate_respawn", self );
    wait 5;
    self.showteamtanks = undefined;
}

// Params 0
// Size: 0x16
function enable_motionblur()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    waitframe();
    empdrone_gameendedthink();
}

// Params 0
// Size: 0xb5
function empdrone_gameendedthink()
{
    if ( istrue( level.disable_super_in_turret.fly_to_laser_trap_start_pos ) )
    {
        return;
    }
    
    var0 = self;
    
    if ( !istrue( level.disable_super_in_turret.ref_1428b ) )
    {
        var0 = spawnstruct();
        var0.player = self;
        var0.viphud_hidefromplayer = self.lastkilledby;
    }
    
    var1 = [];
    var2 = level.teamdata[ self.team ][ "deadPlayers" ];
    
    foreach ( var4 in var2 )
    {
        if ( isdefined( var4 ) )
        {
            var1 = var4.player.name;
        }
    }
    
    level.teamdata[ self.team ][ "deadPlayers" ] = scripts\engine\utility::array_add( level.teamdata[ self.team ][ "deadPlayers" ], var0 );
}

// Params 0
// Size: 0x94
function end_jugg_maze()
{
    if ( istrue( level.disable_super_in_turret.fly_to_laser_trap_start_pos ) )
    {
        return;
    }
    
    var0 = level.teamdata[ self.team ][ "deadPlayers" ];
    
    if ( istrue( level.disable_super_in_turret.ref_1428b ) )
    {
        var0 = scripts\engine\utility::array_remove( var0, self );
    }
    else
    {
        var1 = [];
        
        foreach ( var3 in var0 )
        {
            if ( isdefined( var3 ) && var3.player != self )
            {
                var1 = var3;
            }
        }
        
        var0 = var1;
    }
    
    level.teamdata[ self.team ][ "deadPlayers" ] = var0;
}

// Params 2
// Size: 0x13b
function enable_oob_immunity_on_riders( var0, var1 )
{
    var2 = self;
    level endon( "game_ended" );
    var2 endon( "disconnect" );
    var2 notify( "doingRespawn" );
    
    if ( istrue( var2.respawningfromtoken ) )
    {
        return;
    }
    
    var2.respawningfromtoken = 1;
    
    if ( istrue( level.disable_super_in_turret.ref_12c91 ) )
    {
        var2 notify( "started_spawnPlayer" );
    }
    
    if ( istrue( var0 ) )
    {
        brrebirth_setrebirthrespawntimervengeanceflag( var2 );
        var2 thread scripts\mp\events::killeventtextpopup( "br_rebirth_vengeance", 0, 0 );
        wait 1.5;
    }
    
    end_trans_1_obj( var2, var1 );
    end_jugg_maze();
    var2 scripts\mp\playerlogic::addtoalivecount( "rebirth2" );
    scripts\mp\gametypes\br::ref_13f21( var2, "rebirth2" );
    var2 scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
    var3 = 0;
    
    if ( istrue( level.disable_super_in_turret.ref_12c92 ) )
    {
        var3 = var2 scripts\mp\gametypes\br_gulag::ref_126e8();
    }
    
    var4 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
    var5 = scripts\mp\gametypes\br_gulag::ref_125be( 0, var4 );
    var6 = scripts\mp\gametypes\br_gulag::ref_1263e( var5 );
    self.forcespawnorigin = var6;
    
    if ( var3 )
    {
        var2 scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    }
    
    var7 = 1;
    var2 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    wait var7;
    brrebirth_hiderebirthrespawntimer( var2 );
    var2 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
    var2 scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    var2 scripts\cp_mp\execution::_clearexecution();
    var2 scripts\mp\gametypes\br_pickups::initplayer();
    var2 scripts\mp\gametypes\br_spectate::ref_1252a();
    var2.respawningfromtoken = undefined;
    brrebirth_resetrebirthrespawntimervengeanceflag( var2 );
    var2 thread scripts\mp\gametypes\br_gulag::ref_13dcb( 20 );
    end_loop_emp_spark_vfx( var2, var5, var6 );
}

// Params 0
// Size: 0xb, Type: bool
function end_silo_thrust()
{
    wait 0.5;
    return true;
}

// Params 2
// Size: 0x299
function end_loop_emp_spark_vfx( var0, var1 )
{
    level notify( "update_circle_hide" );
    
    if ( isdefined( self.oobimmunity ) )
    {
        scripts\mp\outofbounds::disableoobimmunity( self );
    }
    
    scripts\mp\gametypes\br::scriptednode( self );
    ref_12a7d();
    
    if ( !isdefined( var0 ) )
    {
        var0 = scripts\mp\gametypes\br_gulag::ref_125be();
    }
    
    var2 = var0.origin;
    var3 = var0.angles;
    var4 = var2;
    
    if ( isdefined( var1 ) )
    {
        var4 = var1;
    }
    
    scripts\mp\gametypes\br_gulag::set_scriptable_states();
    self setorigin( var4, 1 );
    self setplayerangles( var3 );
    var5 = spawn( "script_model", var4 );
    var5 setmodel( "tag_origin" );
    var5.angles = var3;
    var5 hide();
    var5 showtoplayer( self );
    self playerlinktoabsolute( var5, "tag_origin" );
    self playerhide();
    thread scripts\mp\gametypes\br_gulag::ref_12524( var5 );
    waitframe();
    ref_1264e();
    
    if ( getdvarint( "scr_skip_respawn_gate", 1 ) == 0 )
    {
        scripts\mp\gametypes\br_public::ref_126ed();
    }
    
    scripts\mp\gametypes\br_public::ref_1252b();
    
    if ( isdefined( var1 ) )
    {
        var5.origin = var2;
    }
    
    var5 playsoundtoplayer( "br_ac130_flyby", self );
    wait 1.5;
    self unlink();
    self clearsoundsubmix( "deaths_door_mp" );
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        self clearsoundsubmix( "iw8_br_gulag_tutorial", 2 );
    }
    else
    {
        self clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 2 );
    }
    
    self clearclienttriggeraudiozone( 1 );
    self playershow();
    ref_12677( 1 );
    var6 = 0;
    
    if ( isdefined( level.ref_121cc ) )
    {
        var6 = level.ref_121cc;
    }
    
    if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        thread scripts\cp_mp\parachute::startfreefall( var6, 0, undefined, undefined, 1 );
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        self setclientomnvar( "ui_show_spectateHud", -1 );
    }
    
    scripts\mp\gametypes\br_gulag::ref_12c7a();
    scripts\mp\gametypes\br_armor::searchcirclesize();
    scripts\mp\gametypes\br_quest_util::ref_12072();
    scripts\mp\gametypes\br_rewards::ref_12072();
    scripts\mp\gametypes\br_pickups::removerespawntoken();
    scripts\mp\gametypes\br_gametypes::ref_12e05( "giveStartingPlunder" );
    var7 = level.ph_setfinalkillcamwinner > 0 && randomfloat( 1 ) < level.ph_setfinalkillcamwinner;
    
    if ( istrue( var7 ) && isdefined( level.disable_super_in_turret ) && isdefined( level.disable_super_in_turret.br_ammo_player_is_maxed_out ) )
    {
        var8 = 0;
        
        if ( isdefined( level.vehicle.instances[ "veh_a10fd" ] ) )
        {
            var8 = level.vehicle.instances[ "veh_a10fd" ].size;
        }
        
        if ( var8 < level.disable_super_in_turret.botpickskinid )
        {
            thread ref_1268c( var2 );
            wait 1.5;
        }
    }
    
    wait 0.5;
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        thread scripts\mp\gametypes\br_gulag::ref_12523();
    }
    
    waitframe();
    var5 delete();
    
    if ( istrue( level.ref_133ef ) )
    {
        scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused( 1 );
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        self notify( "respawn_from_gulag" );
    }
    
    self notify( "can_show_splashes" );
    
    if ( !istrue( level.stage ) )
    {
        thread scripts\mp\hud_message::showsplash( "br_rebirth_redeploy", 20 );
    }
    
    if ( level.disable_super_in_turret.name == "olaride" )
    {
        scripts\mp\hud_message::showsplash( "br_olaride_objectiveReminder" );
    }
    
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "rebirth_redeploy", self );
}

// Params 0
// Size: 0x2f
function ref_1264e()
{
    self notify( "rebirthRespawn" );
    self.health = self.maxhealth;
    scripts\mp\healthoverlay::onexitdeathsdoor( 1 );
    scripts\mp\utility\player::enableplayerforspawnlogic( 0 );
    scripts\mp\gametypes\br_public::updatebrscoreboardstat( "isRespawning", 0 );
}

// Params 0
// Size: 0x22
function ref_12a7d()
{
    if ( isdefined( level.deletescriptableinstanceaftertime ) || getdvarint( "scr_br_fc_loadouts", 1 ) != 0 )
    {
        self.set_shouldrespawn = 1;
        return;
    }
}

// Params 1
// Size: 0x1e
function ref_12677( var0 )
{
    if ( var0 )
    {
        self enableoffhandweapons();
        self enableusability();
        return;
    }
    
    self disableoffhandweapons();
    self disableusability();
}

// Params 0
// Size: 0x8c
function enable_spawner()
{
    var0 = level.deletescriptableinstanceaftertime;
    
    if ( isdefined( level.ref_12a7d ) )
    {
        var1 = 0;
        
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            var2 = 0;
            
            if ( isdefined( level.disable_super_in_turret.ëFﬂÉä5{p⁄πG√«KıÒ›à…! ) )
            {
                var2 = level.disable_super_in_turret.ëFﬂÉä5{p⁄πG√«KıÒ›à…!;
            }
            
            var1 = min( level.br_circle.circleindex + var2, level.ref_12a7d.size );
            var1 = int( var1 );
        }
        
        if ( isdefined( level.±¨{@N√ª@Kwê9ËõC#*n0[ var1 ] ) )
        {
            var0 = level.ref_12a7d[ var1 ][ level.±¨{@N√ª@Kwê9ËõC#*n0[ var1 ] ];
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x44
function enable_spawner_after_vehicle_death()
{
    var0 = 0;
    
    if ( isdefined( level.ref_12a7d ) )
    {
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            if ( level.br_circle.circleindex == level.ref_12a7d.size - 1 )
            {
                var0 = 1;
            }
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x66, Type: bool
function end_intro_obj()
{
    if ( istrue( level.disable_super_in_turret.ì‘ OøKx®∏C¡É[HsÄ ) && isdefined( self.ref_12eb0 ) )
    {
        scripts\mp\gametypes\br::ref_125fb();
    }
    else
    {
        level.deletescriptableinstanceaftertime = enable_spawner();
        var0 = enable_spawner_after_vehicle_death();
        scripts\mp\gametypes\br::searchcircleorigin( 0, 1, var0 );
    }
    
    if ( isdefined( level.obit_activation ) && level.obit_activation.ref_129da == 1 )
    {
        scripts\mp\gametypes\br::disablearmorykiosk();
    }
    
    brrebirth_playerdroploadout();
    return false;
}

// Params 0
// Size: 0x7b
function brrebirth_playerdroploadout()
{
    if ( !scripts\mp\flags::gameflag( "prematch_fade_done" ) )
    {
        return;
    }
    
    if ( !isdefined( self.player_enable_invulnerability ) )
    {
        self.player_enable_invulnerability = 1;
        var0 = getdvarint( "scr_br_give_self_revive_on_spawn", 1 );
        
        if ( var0 )
        {
            scripts\mp\gametypes\br_pickups::bdroppingshield( 1 );
        }
        
        var1 = getdvarint( "scr_br_give_specialist_on_spawn", 0 );
        
        if ( var1 )
        {
            scripts\mp\perks\perks::bears();
            return;
        }
        
        return;
    }
    
    var0 = getdvarint( "scr_br_give_self_revive_on_respawn", 0 );
    
    if ( var0 )
    {
        scripts\mp\gametypes\br_pickups::bdroppingshield( 1 );
    }
    
    var1 = getdvarint( "scr_br_give_specialist_on_spawn", 0 );
    
    if ( var1 )
    {
        scripts\mp\perks\perks::bears();
        return;
    }
}

// Params 0
// Size: 0xd
function rocket_attack_min_cooldown()
{
    return getdvarint( "scr_br_rebirth_stop_respawn_circle_index", 3 );
}

// Params 1
// Size: 0x26
function circletimer( var0 )
{
    if ( istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        var1 = rocket_attack_min_cooldown();
        
        if ( var0 >= var1 )
        {
            loadoutcustomperkdiscount();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x8a
function loadoutcustomperkdiscount()
{
    level.disable_super_in_turret.ref_12ca4 = 0;
    level.disable_super_in_turret.ä≥ãUS∑@3rmÕ8|ãå
[”∂?Ô∏'ù = undefined;
    brrebirth_initdialogrespawndisabled();
    scripts\mp\gametypes\br_gametypes::ref_12e05( "rebirthDisable" );
    
    foreach ( var1 in level.players )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        scripts\mp\gametypes\br_killstreaks::isbrsquadleader( var1, "respawn_disabled", undefined, 2 );
        var1 setclientomnvar( "ui_br_plunder_extract_end_time", 0 );
        var1 scripts\mp\gametypes\br_gametypes::ref_12e05( "playerRebirthDisable" );
    }
    
    scripts\mp\gametypes\br_public::brleaderdialog( "rebirth_disabled" );
}

// Params 1
// Size: 0xaa
function timeoutonabandoneddelay( var0 )
{
    if ( !isdefined( level.ref_12a7d ) )
    {
        level.ref_12a7d = [];
    }
    
    var1 = level.ref_12a7d.size;
    var2 = tablelookupgetnumcols( var0 ) - 1;
    level.ref_12a7d[ var1 ] = [];
    
    for ( var3 = 0; var3 < var2 ; var3++ )
    {
        level.ref_12a7d[ var1 ][ level.ref_12a7d[ var1 ].size ] = init_structs_mp_don3( var3, var0 );
    }
    
    level.±¨{@N√ª@Kwê9ËõC#*n0 = [];
    
    foreach ( var6, var5 in level.ref_12a7d )
    {
        if ( isdefined( level.ref_12a7d[ var6 ] ) && level.ref_12a7d[ var6 ].size > 0 )
        {
            level.±¨{@N√ª@Kwê9ËõC#*n0[ var6 ] = randomintrange( 0, level.ref_12a7d[ var6 ].size );
        }
    }
}

// Params 2
// Size: 0x24c
function init_structs_mp_don3( var0, var1 )
{
    GscBinSkip1( 0x45, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 0
// Size: 0x3a
function tomastrike_findoptimallaunchpos()
{
    if ( !istrue( level.disable_super_in_turret.ref_14094 ) )
    {
        return;
    }
    
    if ( !isdefined( level.disable_super_in_turret.ref_1452e ) )
    {
        level.disable_super_in_turret.ref_1452e = [ 60, 30 ];
    }
    
    thread ref_14013();
}

// Params 0
// Size: 0xad
function ref_14013()
{
    level endon( "game_ended" );
    var0 = 0;
    level.disable_super_in_turret.ref_1452f = level.disable_super_in_turret.ref_1452e[ var0 ];
    scripts\mp\flags::gameflagwait( "prematch_done" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    level waittill( "infils_ready" );
    
    while ( level.disable_super_in_turret.ref_12ca4 )
    {
        while ( level.disable_super_in_turret.ref_1452f > 0 )
        {
            wait 1;
            level.disable_super_in_turret.ref_1452f--;
        }
        
        wait 1;
        var0 = int( min( var0 + 1, level.disable_super_in_turret.ref_1452e.size - 1 ) );
        level.disable_super_in_turret.ref_1452f = level.disable_super_in_turret.ref_1452e[ var0 ];
    }
}

// Params 0
// Size: 0x30
function end_breach_fx_structs()
{
    self endon( "death_or_disconnect" );
    self endon( "rebirth_remove_spawn_protection" );
    self.ref_12a78 = 1;
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.ref_12a78 = 0;
    self notify( "rebirth_remove_spawn_protection" );
}

// Params 0
// Size: 0x30
function enablesplitscreen()
{
    self endon( "death_or_disconnect" );
    self endon( "rebirth_remove_launcher_protection" );
    self.ref_12a75 = 1;
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.ref_12a75 = 0;
    self notify( "rebirth_remove_launcher_protection" );
}

// Params 0
// Size: 0x2d
function end_chopper_boss()
{
    self endon( "death_or_disconnect" );
    self endon( "rebirth_remove_spawn_protection" );
    self.ref_12a78 = 1;
    self waittill( "weapon_fired" );
    self.ref_12a78 = 0;
    self notify( "rebirth_remove_spawn_protection" );
}

// Params 11
// Size: 0xa5
function end_flares( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    if ( level.ref_12a78 )
    {
        if ( isdefined( var1.ref_12a78 ) && var1.ref_12a78 == 1 )
        {
            var3 *= level.ref_12a79;
        }
        
        if ( isdefined( var2 ) && isdefined( var2.ref_12a75 ) && var2.ref_12a75 == 1 )
        {
            switch ( var4 )
            {
                case "MOD_EXPLOSIVE":
                case "MOD_GRENADE_SPLASH":
                case "MOD_GRENADE":
                case "MOD_PROJECTILE_SPLASH":
                    var3 *= level.ref_12a77;
                    break;
            }
        }
    }
    
    var3 = scripts\mp\gametypes\br::brmodifyplayerdamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
    return var3;
}

// Params 0
// Size: 0x42
function enable_leaderboard()
{
    var0 = ( level.br_level.default_class_chosen[ 1 ][ 0 ], level.br_level.default_class_chosen[ 1 ][ 1 ], 0 );
    var1 = level.br_level.br_circleradii[ 1 ];
    var2 = scripts\mp\gametypes\br_c130::createtestc130path( var0, var1 );
    return var2;
}

// Params 0
// Size: 0x8
function emp_target_monitor()
{
    thread enablefeature();
}

// Params 0
// Size: 0x9e
function enablefeature()
{
    level endon( "game_ended" );
    self endon( "death" );
    var0 = distance( self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor );
    var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
    wait var1;
    
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3 ) && isdefined( var3.br_infil_type ) && var3.br_infil_type == "c130" && !isdefined( var3.jumptype ) )
        {
            var3.jumptype = "outOfBounds";
            var3 notify( "halo_kick_c130" );
        }
    }
}

// Params 0
// Size: 0x2f
function end_nuke_vault()
{
    var0 = -15;
    var1 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player( 1 );
    var2 = max( 0, var1 + var0 );
    var3 = getdvarfloat( "scr_br_dropbag_delay", var2 );
    scripts\mp\gametypes\br_gametypes::ref_12b10( "dropBagDelay", var3 );
}

// Params 0
// Size: 0x13
function ref_12181()
{
    var0 = getdvarvector( "br_final_circle_override", level.grouptorewards );
    return var0;
}

// Params 1
// Size: 0x134
function ref_1268c( var0 )
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "circle" ) )
    {
        return;
    }
    
    var1 = level.br_circle.circleindex + 1;
    
    if ( !isdefined( level.br_level.default_class_chosen[ var1 ] ) )
    {
        var1 = level.br_circle.circleindex;
    }
    
    var2 = vectortoyaw( level.br_level.default_class_chosen[ var1 ] - var0 );
    var3 = spawnstruct();
    var3.origin = ( var0[ 0 ], var0[ 1 ], var0[ 2 ] + 4000 );
    var3.angles = ( 0, var2, 0 );
    var3.cannotbesuspended = 1;
    var4 = spawnstruct();
    var5 = "veh_a10fd";
    
    if ( randomfloat( 1 ) > level.disable_super_in_turret.br_ammo_player_is_maxed_out )
    {
        var5 = "veh_bt";
    }
    
    var3.targetname = var5;
    
    switch ( var5 )
    {
        case "veh_bt":
            var3.modelname = "veh_s4_mil_air_bomber_wz";
            var3.vehicletype = "bt_mp";
            var6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle( var3, var4 );
            break;
        case "veh_a10fd":
            var4.modelname = "veh_s4_mil_air_dalpha_wz";
            var4.vehicletype = "a10_warthog_fd";
            var6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role( var4, var5 );
            break;
        default:
            return;
    }
    
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( var6, "pilot", self );
}

// Params 0
// Size: 0x26
function brrebirth_initneverendingresurgence()
{
    scripts\mp\gametypes\br_gametypes::ref_12b11( "isTeamEliminated", &brrebirth_isteameliminated );
    level.disable_super_in_turret.ä≥ãUS∑@3rmÕ8|ãå
[”∂?Ô∏'ù = 1;
    level.ÇkÚ∑∞F©›«-w·3≈˚∏"N|∏î%C¡PŸä≈ = 1;
}

// Params 1
// Size: 0x12, Type: bool
function brrebirth_isteameliminated( var0 )
{
    return !istrue( level.disable_super_in_turret.ä≥ãUS∑@3rmÕ8|ãå
[”∂?Ô∏'ù );
}

