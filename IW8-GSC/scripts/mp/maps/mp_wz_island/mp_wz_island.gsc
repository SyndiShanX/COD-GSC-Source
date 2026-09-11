
// Params 0
// Size: 0x46e
function main()
{
    scripts\mp\maps\mp_wz_island\mp_wz_island_precache::main();
    scripts\mp\maps\mp_wz_island\gen\mp_wz_island_art::main();
    scripts\mp\maps\mp_wz_island\mp_wz_island_fx::main();
    scripts\mp\maps\mp_wz_island\mp_wz_island_lighting::main();
    scripts\cp_mp\utility\game_utility::ref_12b26();
    level.´l!á±™'{Õ˜wºH)ß+9suz{«¶É@Ýõ`& = &play_nag_players_hvt_callouts;
    scripts\mp\load::main();
    scripts\mp\compass::setupminimap( "compass_map_mp_wz_island", undefined, 16 );
    level thread scripts\engine\scriptable_door::system_init();
    level thread scripts\mp\gametypes\br_ai_encounters::init();
    level thread scripts\mp\gametypes\br_maphints::init();
    setdvar( "PKKMTTRQO", 8 );
    setdvar( "SRQLQNLMK", 1 );
    setdvar( "MTRRKPRML", 1 );
    
    if ( !isdefined( game[ "attackers" ] ) )
    {
        game[ "attackers" ] = "axis";
    }
    
    if ( !isdefined( game[ "defenders" ] ) )
    {
        game[ "defenders" ] = "allies";
    }
    
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    thread ref_12f90();
    level.flashpoint_usebigmapsettings = 1;
    level.c130spacing_usebigmapsettings = 1;
    level.groundspawning_usebigmapsettings = 1;
    level.mapsafecorners = [];
    level.mapsafecorners[ 0 ] = ( 43079, 41673, 200 );
    level.mapsafecorners[ 1 ] = ( -28589, -34322, 430 );
    
    if ( getdvarint( "scr_br_outOfBounds", 1 ) != 0 )
    {
        level.ref_12165 = getentarray( "OutOfBounds", "targetname" );
        spawnpeakpoioutofboundstrigger();
        level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
        level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    }
    
    var0 = scripts\mp\utility\game::getgametype() == "br";
    
    if ( var0 )
    {
        if ( getdvarint( "scr_br_custom_final_circle_override", 0 ) == 1 )
        {
            level.decoyassists = &groundz;
        }
        
        brinit();
        level.ref_12056 = &ref_12056;
        last_weapon_fired_time();
    }
    
    scripts\cp_mp\utility\game_utility::registerlargemap();
    initzonedata();
    
    if ( var0 && getdvarint( "scr_br_hide_fx_names", 0 ) == 0 )
    {
        thread logequipmentuse();
    }
    
    level.disable_oob_immunity_on_riders = 1;
    level thread scripts\mp\maps\mp_wz_island\mp_wz_island_util::ref_1326b();
    var1 = getdvarint( "scr_br_fd_spawn_in_script_enabled", 0 );
    
    if ( var1 > 0 )
    {
        thread ref_13af0( level );
    }
    
    var2 = getdvarint( "scr_br_bt_spawn_in_script_enabled", 0 );
    
    if ( var2 > 0 )
    {
        thread ref_13aef( level );
    }
    
    level.br_latejoininfilready = getdvarint( "scr_br_airplane_debug_functionality", 0 );
    
    if ( level.br_latejoininfilready )
    {
        level.delete_script_object = [];
        level.ref_12864 = [];
        level.prematchspawnoriginsforteams = undefined;
        level.delete_script_object = [ scripts\mp\gametypes\br::createspawnlocation( ( -17471, -17362, 5000 ), 0, 1100 ), scripts\mp\gametypes\br::createspawnlocation( ( -24676, -22933, 5000 ), 0, 1100 ) ];
        level.prematchspawnorigins = scripts\mp\gametypes\br::getprematchlocationspawnorigins();
        
        for ( var3 = 0; var3 < level.delete_script_object.size ; var3++ )
        {
            level.ref_12864[ level.ref_12864.size ] = 0;
        }
    }
    
    setdvarifuninitialized( "scr_br_verse", "ww2" );
    
    if ( getdvar( "scr_br_verse" ) == "modern" )
    {
        setdvarifuninitialized( "scr_allow_vehicle_jeep", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_tac_rover", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_atv", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_cargo_truck", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_little_bird", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_motorcycle", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_cargo_truck_susp", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_cargo_truck_susp_aa", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_open_jeep", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_veh_a10fd", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_veh_bt", 0 );
        setdvarifuninitialized( "aa_turrets_enabled", 1 );
    }
    else
    {
        setdvarifuninitialized( "scr_allow_vehicle_jeep", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_tac_rover", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_atv", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_cargo_truck", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_little_bird", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_motorcycle", 0 );
        setdvarifuninitialized( "scr_allow_vehicle_cargo_truck_susp", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_cargo_truck_susp_aa", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_open_jeep", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_veh_a10fd", 1 );
        setdvarifuninitialized( "scr_allow_vehicle_veh_bt", 1 );
        setdvarifuninitialized( "aa_turrets_enabled", 1 );
    }
    
    level thread scripts\cp_mp\utility\scriptable_door_utility::arenaballs();
    level thread scripts\mp\gametypes\br_skyhook::init();
    level thread scripts\mp\gametypes\br_gondola::unuseweapon();
    _calloutmarkerping_scriptableisusable::init();
    _computerrebootsequence_start::init();
    
    if ( getdvarint( "scr_wz320_ai_events", 0 ) == 1 )
    {
        _testing_ending::teamplunderexfiltimer();
        ac130_flight_path::registerscriptedagent();
        level thread _tryusehoverjetfromstructinternal::bot_allowed_to_try_last_loadout();
    }
    
    if ( getdvarint( "scr_br_morse_code_enabled", 0 ) == 1 )
    {
        level thread scripts\mp\subway_fast_travel\subway_car::init();
    }
    
    if ( getdvarint( "scr_br_doomstation_enabled", 0 ) == 1 )
    {
        _testing_ending::teamplunderexfiltimer();
        ac130_flight_path::registerscriptedagent();
        scripts\mp\gametypes\br_gametype_olaride::initdoomstation();
    }
    
    level thread scripts\mp\gametypes\ftd::init();
    setdvarifuninitialized( "scr_wz_tram_enable", 0 );
    
    if ( getdvarint( "scr_island_waterfall_camera", 1 ) == 1 )
    {
        level thread scripts\mp\maps\mp_wz_island\mp_wz_island_util::ref_14510();
    }
    
    level thread scripts\mp\gametypes\br_golden_bunker::init();
    thread setupsmokecolumn();
    thread initvolcanovisionset();
    thread initolaridevisionsetoverride();
    lastascenderusetime();
    
    if ( getdvarint( "scr_island_lava_triggers_enable", 1 ) == 1 )
    {
        level thread scripts\mp\gametypes\br_gametype_olaride::setuplavatriggers();
        return;
    }
}

// Params 2
// Size: 0x2e
function disablevehiclespawn( var0, var1 )
{
    if ( !isdefined( level.Ž´#ŠÂ(€#cèÀ±Ò)MÒŸ¯²1XGX[ var0 ] ) )
    {
        level.Ž´#ŠÂ(€#cèÀ±Ò)MÒŸ¯²1XGX[ var0 ] = [];
    }
    
    var2 = level.Ž´#ŠÂ(€#cèÀ±Ò)MÒŸ¯²1XGX[ var0 ].size;
    level.Ž´#ŠÂ(€#cèÀ±Ò)MÒŸ¯²1XGX[ var0 ][ var2 ] = var1;
}

// Params 0
// Size: 0x2c
function spawnpeakpoioutofboundstrigger()
{
    if ( getdvarint( "scr_br_peak_poi_outOfBounds_killswitch", 0 ) == 0 )
    {
        ref_13679( ( 7200, 11850, -2000 ), 1500, 4000, 1 );
        return;
    }
}

// Params 4
// Size: 0x7b
function ref_13679( var0, var1, var2, var3 )
{
    if ( getdvarint( "scr_br_spawnOOBKillswitch", 0 ) == 1 )
    {
        return;
    }
    
    if ( !isdefined( level.ref_12166 ) )
    {
        level.ref_12166 = [];
    }
    
    var4 = spawn( "trigger_radius", var0, 0, var1, var2 );
    var4.targetname = "OutOfBounds";
    var4.radius = var1;
    level.ref_12166[ level.ref_12166.size ] = var4;
    
    if ( istrue( var3 ) )
    {
        if ( !isdefined( level.´S‹Ûåª»€Õgµ-}†H'DPS7wÿÛ ) )
        {
            level.´S‹Ûåª»€Õgµ-}†H'DPS7wÿÛ = [];
        }
        
        level.´S‹Ûåª»€Õgµ-}†H'DPS7wÿÛ[ level.´S‹Ûåª»€Õgµ-}†H'DPS7wÿÛ.size ] = var4;
        return;
    }
}

// Params 2
// Size: 0xd2
function play_nag_players_hvt_callouts( var0, var1 )
{
    if ( !getdvarint( "scr_remove_bad_plane_spawns", 1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.Ž´#ŠÂ(€#cèÀ±Ò)MÒŸ¯²1XGX ) )
    {
        level.Ž´#ŠÂ(€#cèÀ±Ò)MÒŸ¯²1XGX = [];
        disablevehiclespawn( "veh_a10fd", ( 16807.7, -30381.7, 5585.12 ) );
    }
    
    var2 = level.Ž´#ŠÂ(€#cèÀ±Ò)MÒŸ¯²1XGX[ var0 ];
    
    if ( isdefined( var2 ) )
    {
        var3 = [];
        var4 = squared( 12 );
        
        foreach ( var6 in var1 )
        {
            var7 = 0;
            
            if ( isdefined( var6.origin ) )
            {
                foreach ( var9 in var2 )
                {
                    if ( distancesquared( var9, var6.origin ) < var4 )
                    {
                        var7 = 1;
                    }
                }
            }
            
            if ( var7 )
            {
                continue;
            }
            
            var3 = var6;
        }
        
        return var3;
    }
    
    return var7;
}

// Params 0
// Size: 0x47
function last_weapon_fired_time()
{
    if ( getdvarint( "scr_br_delete_sound_emitters", 1 ) == 0 )
    {
        return;
    }
    
    var0 = getentarray( "client_sound_line_emitter", "classname" );
    
    foreach ( var2 in var0 )
    {
        var2 delete();
    }
}

// Params 0
// Size: 0xff
function lastascenderusetime()
{
    if ( getdvarint( "scr_br_delete_script_models", 1 ) )
    {
        var0 = getentarray( "script_model", "classname" );
        
        foreach ( var2 in var0 )
        {
            if ( isdefined( var2.model ) )
            {
                switch ( var2.model )
                {
                    case "buildup_dirt_plaster_01_32_endpiece_left_32":
                    case "buildup_dirt_plaster_01_32_endpiece_right_32":
                    case "buildup_dirt_plaster_01_64":
                    case "lm_mkg_fence_reed_02":
                    case "lm_mkg_fence_reed_03":
                        lastapproachinstruct( var2 );
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
    if ( getdvarint( "scr_br_delete_script_brush_models", 1 ) )
    {
        var4 = getentarray( "script_brushmodel", "classname" );
        
        foreach ( var2 in var4 )
        {
            if ( !isdefined( var2.targetname ) && !isdefined( var2.script_noteworthy ) && !isdefined( var2.script_linkname ) )
            {
                lastapproachinstruct( var2 );
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x9
function lastapproachinstruct( var0 )
{
    var0 delete();
}

// Params 1
// Size: 0x3e3
function ref_13af0( var0 )
{
    if ( var0 == 1 )
    {
        level.ref_1217d = [];
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -29968, -27286, 970 ), ( 0, 315, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -30175, -28169, 980 ), ( 0, 7, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -29015, -26309, 965 ), ( 0, 342, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -25294, -26515, 960 ), ( 0, 76, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -28066, -25367, 970 ), ( 0, 311, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -15512, -17501, 1000 ), ( 0, 165, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -27171, -28550, 980 ), ( 0, 79, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -22806, -24406, 980 ), ( 0, 61, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -18698, -20588, 980 ), ( 0, 184, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -19435, -17604, 960 ), ( 0, 237, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( 12532, 16142, 9385 ), ( 0, 8, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -2035, 10825, 3846 ), ( 0, 82, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( 16733, -30340, 5574 ), ( 0, 35, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( 44514, 43533, 257 ), ( 0, 301, 0 ) );
        return;
    }
    
    if ( var0 == 2 )
    {
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -2053, 10406, 3846 ), ( 0, 84, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( 16733, -30340, 5574 ), ( 0, 35, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -25294, -26515, 960 ), ( 0, 76, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -27534, -28757, 980 ), ( 0, 69, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -15512, -17501, 1000 ), ( 0, 165, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( -22806, -24406, 980 ), ( 0, 61, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( 12532, 16142, 9385 ), ( 0, 8, 0 ) );
        level.ref_1217d[ level.ref_1217d.size ] = init_relic_laststand( ( 44514, 43533, 257 ), ( 0, 301, 0 ) );
        return;
    }
}

// Params 1
// Size: 0x1ad
function ref_13aef( var0 )
{
    if ( var0 == 1 )
    {
        level.ref_1218a = [];
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -30276, -29396, 980 ), ( 0, 45, 0 ) );
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -29981, -30330, 994 ), ( 0, 47, 0 ) );
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -14423, -14554, 975 ), ( 0, 222, 0 ) );
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -15479, -14382, 975 ), ( 0, 235, 0 ) );
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -22591, -20810, 980 ), ( 0, 23, 0 ) );
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -20066, -21723, 980 ), ( 0, 69, 0 ) );
        return;
    }
    
    if ( var0 == 2 )
    {
        level.ref_1218a = [];
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -30055, -30266, 994 ), ( 0, 47, 0 ) );
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -14865, -14223, 980 ), ( 0, 225, 0 ) );
        level.ref_1218a[ level.ref_1218a.size ] = init_reach_wind_room( ( -22591, -20810, 980 ), ( 0, 23, 0 ) );
        return;
    }
}

// Params 2
// Size: 0x4a
function init_relic_laststand( var0, var1 )
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
    
    var2.targetname = "veh_a10fd";
    return var2;
}

// Params 2
// Size: 0x4a
function init_reach_wind_room( var0, var1 )
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
    
    var2.targetname = "veh_bt";
    return var2;
}

// Params 0
// Size: 0x996
function brinit()
{
    level.br_level = spawnstruct();
    level.br_level.br_corners = [];
    level.br_level.br_corners[ 0 ] = ( 44259, -45371, 353 );
    level.br_level.br_corners[ 1 ] = ( -31516, 33428, 644 );
    var0 = scripts\mp\utility\game::round_vehicle_logic();
    var1 = 19000;
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        var2 = -1;
        thread init_locations();
        
        if ( getdvar( "scr_br_gametype", "" ) == "dmz" )
        {
            var2 = getdvarint( "scr_dmz_c130HeightOverride", 18000 );
        }
        else
        {
            var2 = getdvarint( "scr_dmz_c130HeightOverride", -1 );
        }
        
        if ( var2 != -1 )
        {
            var1 = var2;
        }
        
        if ( var0 == "rebirth" || var0 == "rebirth_reverse" || var0 == "rebirth_dbd" || var0 == "rebirth_dbd_reverse" )
        {
            level.br_level.c130_speedoverride = 3500;
        }
    }
    
    scripts\mp\gametypes\br_c130::setc130heightoverrides( var1, 150 );
    var3 = getdvarfloat( "scr_full_bounds_scale_mp_wz_island", 0.98 );
    var4 = level.mapcorners[ 0 ].origin[ 0 ] * var3;
    var5 = level.mapcorners[ 1 ].origin[ 0 ] * var3;
    var6 = level.mapcorners[ 1 ].origin[ 1 ] * var3;
    var7 = level.mapcorners[ 0 ].origin[ 1 ] * var3;
    level.br_level.delay_set_bomber_traversals = [];
    level.br_level.delay_set_bomber_traversals[ 0 ] = ( var5, var7, 0 );
    level.br_level.delay_set_bomber_traversals[ 1 ] = ( var4, var6, 0 );
    var3 = getdvarfloat( "scr_bounds_scale_mp_wz_island", 0.9 );
    var4 = level.mapcorners[ 0 ].origin[ 0 ] * var3;
    var5 = level.mapcorners[ 1 ].origin[ 0 ] * var3;
    var6 = level.mapcorners[ 1 ].origin[ 1 ] * var3;
    var7 = level.mapcorners[ 0 ].origin[ 1 ] * var3;
    level.br_level.br_mapbounds = [];
    level.br_level.br_mapbounds[ 0 ] = ( var5, var7, 0 );
    level.br_level.br_mapbounds[ 1 ] = ( var4, var6, 0 );
    level.br_level.br_mapcenter = ( ( var4 + var5 ) / 2, ( var6 + var7 ) / 2, 0 );
    level.br_level.br_mapsize = ( abs( var5 - var4 ), abs( var7 - var6 ), abs( level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride ) );
    level.br_level.ref_11a5b = -312;
    level.br_level.spawn_exfil_enemies = 10353;
    level.br_level.br_circleclosetimes = [ 270, 220, 170, 110, 70, 50, 50, 100 ];
    level.br_level.br_circledelaytimes = [ 220, 90, 75, 60, 60, 45, 30, 0 ];
    level.br_level.default_player_connect_black_screen = [ 220, 0, 0, 0, 0, 0, 0, 0 ];
    var8 = getdvar( "scr_br_verse", "" );
    
    if ( var8 == "modern" )
    {
        level.br_level.br_circleclosetimes = [ 270, 220, 170, 140, 110, 100, 90, 100 ];
        level.br_level.br_circledelaytimes = [ 150, 60, 60, 45, 45, 30, 30, 0 ];
        level.br_level.default_player_connect_black_screen = [ 150, 0, 0, 0, 0, 0, 0, 0 ];
    }
    else if ( var8 == "ww2" )
    {
        level.br_level.br_circleclosetimes = [ 270, 140, 130, 110, 110, 80, 80, 70 ];
        level.br_level.br_circledelaytimes = [ 210, 90, 60, 60, 30, 30, 30, 30 ];
        level.br_level.default_player_connect_black_screen = [ 210, 0, 0, 0, 0, 0, 0, 0 ];
    }
    
    if ( var0 == "rebirth" || var0 == "rebirth_reverse" || var0 == "rebirth_dbd" || var0 == "rebirth_dbd_reverse" )
    {
        if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0 )
        {
            level.br_level.br_circleclosetimes = [ 1, 90, 75, 60, 60, 30, 30 ];
            level.br_level.br_circledelaytimes = [ 1, 150, 120, 75, 60, 30, 0 ];
            level.br_level.default_player_connect_black_screen = [ 1, 0, 0, 0, 0, 0, 0 ];
        }
        else
        {
            level.br_level.br_circleclosetimes = [ 180, 200, 160, 105, 50, 30, 25 ];
            level.br_level.br_circledelaytimes = [ 1, 60, 60, 60, 45, 30, 0 ];
            level.br_level.default_player_connect_black_screen = [ 1, 0, 0, 0, 0, 0, 0 ];
        }
    }
    else if ( var0 == "mini" )
    {
        level.br_level.br_circleclosetimes = [ 1, 200, 130, 90, 50, 100 ];
        level.br_level.br_circledelaytimes = [ 1, 120, 75, 60, 45, 0 ];
        level.br_level.default_player_connect_black_screen = [ 1, 0, 0, 0, 0, 0 ];
    }
    
    level.br_level.default_suicidebomber_combat = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
    level.br_level.br_circleminimapradii = [ 10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500 ];
    level.br_level.br_circleradii = [ 81600, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0 ];
    
    if ( var8 == "modern" )
    {
        level.br_level.br_circleradii = [ 81600, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0 ];
    }
    else if ( var8 == "ww2" )
    {
        level.br_level.br_circleradii = [ 80000, 65000, 50000, 35000, 20000, 10000, 5000, 2000, 0 ];
    }
    
    if ( var0 == "rebirth" || var0 == "rebirth_reverse" || var0 == "rebirth_dbd" || var0 == "rebirth_dbd_reverse" )
    {
        level.br_level.default_suicidebomber_combat = [ 0, 0, 0, 0, 0, 0, 0 ];
        level.br_level.br_circleminimapradii = [ 10500, 10500, 10500, 10500, 9000, 8000, 5500 ];
        
        if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0 )
        {
            level.br_level.br_circleradii = [ 32000, 21000, 14000, 9000, 4500, 2000, 500, 0 ];
        }
        else
        {
            level.br_level.br_circleradii = [ 70000, 50000, 27000, 12000, 5000, 1500, 0 ];
        }
    }
    else if ( var0 == "mini" )
    {
        level.br_level.default_suicidebomber_combat = [ 0, 0, 0, 0, 0, 0 ];
        level.br_level.br_circleminimapradii = [ 10500, 10500, 10500, 9000, 8000, 5500 ];
        var9 = getdvarint( "scr_brmini_circle_setting", 0 );
        
        if ( var9 == 1 )
        {
            level.br_level.br_circleradii = [ 75000, 45000, 20000, 7000, 3500, 1500, 0 ];
        }
        else
        {
            level.br_level.br_circleradii = [ 60000, 30000, 15000, 7000, 3500, 1500, 0 ];
        }
    }
    
    if ( isdefined( level.decoyassists ) )
    {
        [[ level.decoyassists ]]();
    }
    
    scripts\mp\gametypes\br_circle::cacheentity();
    level.delete_script_object = [ scripts\mp\gametypes\br::createspawnlocation( ( -22000, 45000, 386 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 14000, 50000, 386 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 43000, 39000, 386 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( -41800, 11300, 1000 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( -38000, 23800, 1000 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( -7000, 15000, 2000 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 11800, 13000, 8615 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 45000, 20000, 386 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( -42000, -17000, 386 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( -21000, -24000, 1000 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 9000, -11000, 2000 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 44600, -22000, 350 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( -9000, -37000, 2000 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 21000, -50000, 500 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( 40000, -42000, 350 ), 0, 6000 ), scripts\mp\gametypes\br::createspawnlocation( ( -27595, 5273, 4000 ), 0, 6000 ) ];
    level.debug_vault_assault_retrieve_saw_obj_start = [ scripts\mp\gametypes\br_circle::init_safehouse_gunshop( ( -48230, 44787, 0 ), 18000 ), scripts\mp\gametypes\br_circle::init_safehouse_gunshop( ( -44417, -43743, 0 ), 18000 ) ];
    
    if ( getdvarint( "scr_br_ltm_tease_enabled", 0 ) )
    {
        thread teasecheck();
        return;
    }
}

// Params 0
// Size: 0xf6
function ref_12056()
{
    if ( !scripts\mp\gametypes\br::ref_11a5c() )
    {
        return;
    }
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "mini" )
    {
        level.br_level.br_circleradii = [ 57000, 27500, 12500, 6500, 3000, 1250, 0 ];
        level.br_level.br_circleclosetimes = [ 1, 190, 120, 80, 40, 90 ];
        level.br_level.br_circledelaytimes = [ 1, 110, 65, 50, 35, 0 ];
    }
    else
    {
        level.br_level.br_circleradii = [ 81000, 50000, 30000, 15000, 7500, 3750, 1500, 0 ];
        level.br_level.br_circleclosetimes = [ 270, 180, 150, 60, 60, 45, 90 ];
        level.br_level.br_circledelaytimes = [ 210, 60, 60, 60, 45, 30, 0 ];
    }
    
    scripts\mp\gametypes\br_circle::cacheentity();
}

// Params 3
// Size: 0x32
function getcoordsforflyinzone( var0, var1, var2 )
{
    var3 = int( tablelookupbyrow( var0, var1, var2 ) );
    var4 = int( tablelookupbyrow( var0, var1, var2 + 1 ) );
    var5 = int( tablelookupbyrow( var0, var1, var2 + 2 ) );
    return ( var3, var4, var5 );
}

// Params 2
// Size: 0x1f
function getcalloutindex( var0, var1 )
{
    if ( isdefined( var0.½4¥æ2+Ã&òÉÊ™[ var1 ] ) )
    {
        return var0.½4¥æ2+Ã&òÉÊ™[ var1 ];
    }
    
    return -1;
}

// Params 0
// Size: 0x57
function buildcalloutdata()
{
    var0 = "mp/map_callouts/mp_wz_island_callouts.csv";
    var1 = 0;
    var2 = 1;
    var3 = spawnstruct();
    var3.½4¥æ2+Ã&òÉÊ™ = [];
    
    for ( var4 = 0; var4 < tablelookupgetnumrows( var0 ) ; var4++ )
    {
        var5 = int( tablelookupbyrow( var0, var4, var1 ) );
        var6 = tablelookupbyrow( var0, var4, var2 );
        var3.½4¥æ2+Ã&òÉÊ™[ var6 ] = var5;
    }
    
    return var3;
}

// Params 0
// Size: 0x13d
function buildflyindata()
{
    var0 = "mp/map_callouts/mp_wz_island_flyInNames.csv";
    var1 = getdvar( "br_wz_island_flyinnames", var0 );
    
    if ( var1 == "" )
    {
        var1 = var0;
    }
    
    var2 = 0;
    var3 = 1;
    var4 = 2;
    var5 = 3;
    var6 = 4;
    level.player_waitforlanded = spawnstruct();
    level.player_waitforlanded.data = [];
    level.player_waitforlanded.ref_14729 = [];
    level.player_waitforlanded.ref_127d9 = [];
    var7 = "";
    
    for ( var8 = 0; var8 < tablelookupgetnumrows( var1 ) ; var8++ )
    {
        var9 = int( tablelookupbyrow( var1, var8, var2 ) );
        var9 = level.player_waitforlanded.data.size;
        var10 = spawnstruct();
        var10.ref_11a4a = tablelookupbyrow( var1, var8, var3 );
        var10.ref_127d8 = tablelookupbyrow( var1, var8, var4 );
        var10.player_parachute_watcher = tablelookupbyrow( var1, var8, var5 );
        var10.ignore_spawn_scoring_pois = getcoordsforflyinzone( var1, var8, var6 );
        var10.ref_11e2a = var10.ref_127d8;
        level.player_waitforlanded.data[ var9 ] = var10;
        level.player_waitforlanded.ref_14729[ var10.ref_11a4a ] = var8;
        
        if ( var7 != var10.ref_127d8 )
        {
            level.player_waitforlanded.ref_127d9[ var10.ref_127d8 ] = var8;
            var7 = var10.ref_127d8;
        }
    }
}

// Params 0
// Size: 0x137
function buildflashpointdata()
{
    if ( getdvarint( "LKTMLPRTO", 0 ) != 0 )
    {
        var0 = function_043a();
        var1 = buildcalloutdata();
        var2 = [];
        var3 = 0;
        
        foreach ( var5 in var0 )
        {
            var6 = function_043b( var5 );
            var7 = level.player_waitforlanded.ref_14729[ var6 ];
            var8 = level.player_waitforlanded.data[ var7 ].ref_127d8;
            var9 = level.player_waitforlanded.ref_127d9[ var8 ];
            var10 = level.player_waitforlanded.data[ var9 ];
            var11 = getcalloutindex( var1, var8 );
            
            if ( var11 >= 0 && var11 % 2 == 0 && !isdefined( var2[ var11 ] ) )
            {
                var2 = 1;
                var3 += int( pow( 2, int( var11 / 2 ) ) );
            }
            
            var12 = function_043c( var5 );
            level.player_waitforlanded.data[ var9 ].ref_11e2a = var10.player_parachute_watcher;
            level.player_waitforlanded.data[ var9 ].ignore_spawn_scoring_pois = ( var12.origin[ 0 ], var12.origin[ 1 ], var10.ignore_spawn_scoring_pois[ 2 ] );
        }
        
        setomnvar( "ui_br_flashpoint_area", var3 );
        return;
    }
}

// Params 0
// Size: 0xc
function initzonedata()
{
    buildflyindata();
    buildflashpointdata();
}

// Params 0
// Size: 0xac
function logequipmentuse()
{
    level waittill( "prematch_started" );
    
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    var0 = level.br_ac130.angles;
    var0 += ( 0, -90, 0 );
    level.ref_11e26 = [];
    
    foreach ( var2 in level.player_waitforlanded.ref_127d9 )
    {
        var2 = level.player_waitforlanded.ref_127d9[ var3 ];
        init_gasmask( level.player_waitforlanded.data[ var2 ].ref_11e2a, level.player_waitforlanded.data[ var2 ].ignore_spawn_scoring_pois, var0 );
    }
    
    thread laser_shut_down_interact_monitor();
}

// Params 3
// Size: 0x14
function init_gasmask( var0, var1, var2 )
{
    init_gastrap( var0, var1, var2, "name_fx" );
}

// Params 4
// Size: 0x52
function init_gastrap( var0, var1, var2, var3 )
{
    var1 += ( 0, 0, 500 );
    var4 = spawn( "script_model", var1 );
    var4 setmodel( "tag_origin_name_fx_island" );
    var4.angles = var2;
    level.ref_11e26[ level.ref_11e26.size ] = var4;
    var4 setscriptablepartstate( var3, var0 );
    var4 unmarkkeyframedmover( 1 );
}

// Params 0
// Size: 0x50
function laser_shut_down_interact_monitor()
{
    thread spawn_bomb_hostage();
    
    while ( isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    wait 90;
    level notify( "stop_fx_hide_func" );
    
    foreach ( var1 in level.ref_11e26 )
    {
        var1 delete();
    }
}

// Params 0
// Size: 0x95
function spawn_bomb_hostage()
{
    level endon( "game_ended" );
    level endon( "stop_fx_hide_func" );
    var0 = 10;
    var1 = 0.25;
    
    while ( level.ref_11e26.size > 0 )
    {
        var2 = level.players;
        
        for ( var3 = 0; var3 < var2.size ; var3++ )
        {
            var4 = var2[ var3 ];
            
            if ( isdefined( var4 ) && isalive( var4 ) )
            {
                if ( isdefined( var4.vehicle ) )
                {
                    for ( var5 = 0; var5 < level.ref_11e26.size ; var5++ )
                    {
                        level.ref_11e26[ var5 ] hidefromplayer( var4 );
                    }
                }
            }
            
            if ( var3 % var0 == 0 )
            {
                wait var1;
            }
        }
        
        wait 0.1;
    }
}

// Params 0
// Size: 0x17
function ref_12f90()
{
    thread player_fired_gun_monitor();
    thread fixmaphole();
    thread battle_tracks_stopbattletracksfromstandingonvehicle();
}

// Params 0
// Size: 0x2
function battle_tracks_stopbattletracksfromstandingonvehicle()
{
    
}

// Params 3
// Size: 0x40
function setlowermessageomnvarref( var0, var1, var2 )
{
    var3 = spawn( "trigger_radius", var0, 0, var1, var2 );
    
    for ( ;; )
    {
        var3 waittill( "trigger", var4 );
        
        if ( isplayer( var4 ) )
        {
            var4 dodamage( 10000, var4.origin, var3, var3, "MOD_TRIGGER_HURT" );
        }
    }
}

// Params 0
// Size: 0x5
function player_fired_gun_monitor()
{
    var0 = [];
}

// Params 3
// Size: 0x2d
function ref_13624( var0, var1, var2 )
{
    var3 = getent( var0, "targetname" );
    var4 = spawn( "script_model", var1 );
    var4.angles = var2;
    var4 clonebrushmodeltoscriptmodel( var3 );
    return var4;
}

// Params 0
// Size: 0x38
function fixmaphole()
{
    var0 = spawn( "script_model", ( 6460, 12457, 6822 ) );
    var0 setmodel( "rock_cliff_scotland_04_closed_ch3_lava_fullburnt" );
    var0.angles = ( 0, 346, 0 );
}

// Params 0
// Size: 0x120
function teasecheck()
{
    level endon( "game_ended" );
    level waittill( "prematch_fade_done" );
    
    if ( !isdefined( level.br_level.br_circledelaytimes ) || !isdefined( level.br_circle.circleindex ) )
    {
        return;
    }
    
    var0 = getdvarfloat( "scr_br_ltm_tease_shake_intensity", 0.4 );
    var1 = getdvarfloat( "scr_br_ltm_tease_shake_duration", 2 );
    var2 = getdvarint( "scr_br_ltm_tease_shake_radius", 75000 );
    var3 = getdvarfloat( "scr_br_ltm_tease_circleTimeRation", 1 );
    var4 = getdvarfloat( "scr_br_ltm_tease_probability", 1 );
    
    while ( level.br_level.br_circledelaytimes.size > level.br_circle.circleindex )
    {
        level waittill( "br_circle_set", var5 );
        var6 = level.br_level.br_circledelaytimes[ level.br_circle.circleindex ];
        
        if ( var6 < var1 || var6 <= 1 )
        {
            continue;
        }
        
        var7 = var6 * var3;
        
        if ( var7 > 0 )
        {
            var8 = int( var6 / var7 );
            
            for ( var9 = 0; var9 < var8 ; var9++ )
            {
                wait var7;
                
                if ( randomfloat( 1 ) <= var4 )
                {
                    scripts\mp\gametypes\br_gametype_olaride::startshake( var0, var1, 0, ( 8387, 15066, 8191 ), var2 );
                }
            }
        }
    }
}

// Params 0
// Size: 0xae
function init_locations()
{
    if ( level.mapname == "mp_wz_island" )
    {
        ref_12adf( "capital", 1, ( 21214, -50131, 0 ) );
        ref_12adf( "capital_tennis", 1, ( 30340, -47645, 0 ) );
        ref_12adf( "mines", 1, ( -6265, 17880, 0 ) );
        ref_12adf( "docks", 1, ( 16730, 53476, 0 ) );
        ref_12adf( "subpen", 1, ( 44500, -21338, 0 ) );
        return;
    }
    
    ref_12adf( "default", 1, ( 0, 0, 0 ) );
}

// Params 3
// Size: 0x65
function ref_12adf( var0, var1, var2 )
{
    if ( !isdefined( level.br_level.area_structs ) )
    {
        level.br_level.area_structs = [];
    }
    
    var1 = getdvarint( "scr_circle_location_weight_" + var0, var1 );
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    var3 = spawnstruct();
    var3.ref_13902 = var0;
    var3.spotlights = var1;
    var3.ref_140b7 = var2;
    level.br_level.area_structs[ var0 ] = var3;
}

// Params 0
// Size: 0x3c
function groundz()
{
    level.br_level.ref_12e2c = ref_12d7f();
    level.grouptorewards = scripts\mp\gametypes\br_circle::getrandompointincircle( level.br_level.ref_12e2c.ref_140b7, 5300, 0, 1, 0, 0 );
}

// Params 0
// Size: 0x148
function ref_12d7f()
{
    level.br_level.ref_13903 = getdvar( "scr_br_custom_circle_override_location", "random" );
    
    if ( isdefined( level.br_level.ref_13903 ) && level.br_level.ref_13903 != "random" )
    {
        foreach ( var1 in level.br_level.area_structs )
        {
            if ( level.br_level.ref_13903 == var2 )
            {
                return var1;
            }
        }
    }
    
    if ( level.br_level.area_structs.size == 1 )
    {
        return level.br_level.area_structs[ 0 ];
    }
    
    var3 = 0;
    
    foreach ( var1 in level.br_level.area_structs )
    {
        var3 += var1.spotlights;
    }
    
    var6 = randomintrange( 0, var3 );
    
    foreach ( var1 in level.br_level.area_structs )
    {
        if ( var6 < var1.spotlights )
        {
            return var1;
        }
        
        var6 -= var1.spotlights;
    }
    
    level.br_level.area_structs = scripts\engine\utility::array_randomize( level.br_level.area_structs );
    return level.br_level.area_structs[ 0 ];
}

// Params 0
// Size: 0x32
function setupsmokecolumn()
{
    level waittill( "prematch_fade_done" );
    level.Ž
ƒK‹_{8 Ò7 = scripts\engine\utility::ter_op( getdvarint( "scr_br_caldera_volcano_olaride_smoke", 0 ), "olaride_volcano_smoke_big", "olaride_volcano_smoke_small" );
    scripts\engine\utility::exploder( level.Ž
ƒK‹_{8 Ò7 );
}

// Params 0
// Size: 0x27
function initvolcanovisionset()
{
    level waittill( "prematch_fade_done" );
    function_0448( ( 8333, 14999, 8851 ), "mp_wz_island_s05_ltm_volcanpit", 3000, 800, 0 );
}

// Params 0
// Size: 0x3c
function initolaridevisionsetoverride()
{
    level endon( "prematch_fade_done" );
    
    if ( getdvar( "scr_br_gametype", "" ) == "olaride" )
    {
        for ( ;; )
        {
            level waittill( "connected", var0 );
            thread overridevisionset( var0, 0 );
        }
        
        return;
    }
}

// Params 2
// Size: 0x14
function overridevisionset( var0, var1 )
{
    self waittill( "spawned_player" );
    self method_87e3( var0, var1 );
}

