
// Params 0
// Size: 0x9c
function init()
{
    var0 = spawnstruct();
    var0.ref_140cf = &ref_140cf;
    var0.weight = getdvarfloat( "scr_br_pe_fresno_weight", 100 );
    var0.ref_14382 = &ref_14382;
    var0.attackerswaittime = &attackerswaittime;
    var0.isfeaturedisabled = &players_approach_puzzle_monitor;
    var0.‹Á¿ø{ÏXX;â# / = &postinitfunc;
    var0.ref_11b78 = getdvarint( "scr_br_pe_fresno_max_times", 2 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "fresno", "0    95  10  75          100 0   0   0" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "fresno" );
    scripts\mp\gametypes\br_publicevents::ref_12b35( 16, var0 );
}

// Params 0
// Size: 0xd9
function postinitfunc()
{
    var0 = self;
    game[ "dialog" ][ "public_events_fresno_start" ] = "gametype_desc_titans";
    game[ "dialog" ][ "public_events_fresno_top_reward" ] = "oshkosh_reward";
    game[ "dialog" ][ "public_events_g_staggered" ] = "greenbay_titan_retreat";
    game[ "dialog" ][ "public_events_k_staggered" ] = "kenosha_titan_retreat";
    var0.secondsbeforeplacementupdates = getdvarint( "scr_br_pe_fresno_health_per", 2000 );
    level.ref_11e18.playerredeploy = getdvarint( "scr_br_pe_fresno_frenzy_radius", 11000 );
    level.£`Eò©øÅ+qrÃñkß+˜ÈK = 0;
    setdvarifuninitialized( "scr_br_pe_fresno_hwc_fadestart", 5000 );
    setdvarifuninitialized( "scr_br_pe_fresno_hwc_fadeend", 7000 );
    thread begineventcountdown();
    level.ref_11e18.ˆZÌ9²›ôò×±Şê¹è = 0;
    level.ref_11e18.cöu¸s#Në“tO‡xGaváP = getdvarint( "scr_br_pe_fresno_screamer_trigger", 0 );
    thread strip_node_flag_wait();
    init_reward_crates();
    thread monitor_circles();
    thread set_real_time();
}

// Params 0
// Size: 0x28
function set_real_time()
{
    level.ref_11e18.basetime = gettime();
    level waittill( "prematch_done" );
    level.ref_11e18.basetime = gettime();
}

// Params 0
// Size: 0x16
function get_real_time()
{
    return ( gettime() - level.ref_11e18.basetime ) / 1000;
}

// Params 0
// Size: 0x69
function monitor_circles()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        level waittill( "br_circle_set", var0 );
        var1 = level.br_level.br_circledelaytimes[ var0 - 1 ];
        var2 = level.br_level.br_circleclosetimes[ var0 - 1 ];
        var3 = level.br_level.br_circledelaytimes[ var0 ];
        level.ref_11e18.Œ„ß¡ÿ±§sz óù·Ø5§œch' = gettime() + 1000 * ( var1 + var2 + var3 );
    }
}

// Params 0
// Size: 0x57
function begineventcountdown()
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    level.ref_11e18.¶²³²›è›G°“GÑ–k²æ = tokenizefloatsfromstring( getdvar( "scr_br_pe_fresno_activation_time", "140.0 290.0" ) );
    level.ref_11e18.Œ0²ÎÊ›w°É7ÒÍ³´¶Ê› = tokenizefloatsfromstring( getdvar( "scr_br_pe_fresno_incoming_time", "30.0 30.0" ) );
    calculateeventcircles();
    eventcountdown_internal();
}

// Params 1
// Size: 0x4a
function tokenizefloatsfromstring( var0 )
{
    var1 = [];
    
    if ( var0 != "" )
    {
        var2 = strtok( var0, " " );
        
        foreach ( var4 in var2 )
        {
            var1 = float( var4 );
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x9d
function calculateeventcircles()
{
    level.ref_11e18.¦:£İËkGáâ_À÷w = [];
    
    for ( var0 = 0; var0 < level.ref_11e18.¶²³²›è›G°“GÑ–k²æ.size ; var0++ )
    {
        var1 = level.ref_11e18.¶²³²›è›G°“GÑ–k²æ[ var0 ];
        var2 = 0;
        var3 = -1;
        
        for ( var4 = 0; var4 < level.br_level.br_circledelaytimes.size ; var4++ )
        {
            var2 += level.br_level.br_circledelaytimes[ var4 ] + level.br_level.br_circleclosetimes[ var4 ];
            
            if ( var1 <= var2 )
            {
                var3 = var4;
                break;
            }
        }
        
        level.ref_11e18.¦:£İËkGáâ_À÷w[ var0 ] = var3;
    }
}

// Params 0
// Size: 0x4c
function eventcountdown_internal()
{
    for ( var0 = 0; var0 < level.ref_11e18.¶²³²›è›G°“GÑ–k²æ.size ; var0++ )
    {
        var1 = level.ref_11e18.¶²³²›è›G°“GÑ–k²æ[ var0 ];
        var2 = level.ref_11e18.Œ0²ÎÊ›w°É7ÒÍ³´¶Ê›[ var0 ];
        var1 -= var2;
        wait var1;
        launchevent( var2 );
    }
}

// Params 1
// Size: 0xd4
function launchevent( var0 )
{
    if ( !isdefined( level.ref_11e18 ) )
    {
        return;
    }
    
    if ( isdefined( level.ref_11e18.§<u=»æø–ê7Ix) ) )
    {
        iprintln( "Warning: Fresno is ignoring activation request, it is already running." );
        return;
    }
    
    if ( isdefined( level.ref_11e18.setincomingremovedcallback ) && isdefined( level.ref_11e18.setincomingremovedcallback.ref_12930 ) || isdefined( level.ref_11e18.wait_for_next_hack_complete ) && isdefined( level.ref_11e18.wait_for_next_hack_complete.ref_12930 ) )
    {
        iprintln( "Warning: Fresno is ignoring activation request, it is already running." );
        return;
    }
    
    scripts\mp\gametypes\br_publicevents::ref_13371( "br_pe_fresno_inc" );
    level notify( "fresno_start" );
    thread activatetomahs( var0 );
    wait 8;
    setomnvar( "ui_publicevent_timer_type", 0 );
    setomnvar( "ui_publicevent_timer_type", 11 );
    var0 -= 8;
    var1 = gettime() + var0 * 1000;
    setomnvar( "ui_publicevent_timer", var1 );
    wait var0;
    thread activateevent();
}

// Params 0
// Size: 0xa
function attackerswaittime()
{
    launchevent( 14 );
}

// Params 0
// Size: 0x17, Type: bool
function ref_140cf()
{
    return scripts\mp\utility\game::round_vehicle_logic() == "mendota" && isdefined( level.ref_11e18 );
}

// Params 0
// Size: 0x2
function ref_14382()
{
    
}

// Params 1
// Size: 0x15f
function activatetomahs( var0 )
{
    level endon( "game_ended" );
    self.active = 1;
    var1 = gettime() + ( var0 + getdvarfloat( "scr_br_pe_fresno_lifetime", 120 ) ) * 1000;
    level.ref_11e18.ºË§!jÚ `ğU% = var1;
    level.ref_1406f = 1;
    level.ref_11a1f = [];
    level.ref_1395a = [];
    scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata();
    
    if ( isdefined( level.ref_11e18.setincomingremovedcallback ) && isdefined( level.ref_11e18.wait_for_next_hack_complete ) )
    {
        var2 = getdvar( "scr_br_pe_fresno_die_roll" );
        
        if ( var2.size == 0 )
        {
            level.ref_11e18.setincomingremovedcallback.ref_12930 = &sentry_init_done;
            level.ref_11e18.wait_for_next_hack_complete.ref_12930 = &vehicle_rider_think;
            return;
        }
        
        var3 = randomint( 10 );
        var4 = int( var2 );
        
        if ( var4 > -1 )
        {
            var3 = var4;
        }
        
        if ( var3 < 3 || var3 >= 6 )
        {
            level.ref_11e18.setincomingremovedcallback.ref_12930 = &sentry_init_done;
        }
        
        if ( var3 >= 3 )
        {
            level.ref_11e18.wait_for_next_hack_complete.ref_12930 = &vehicle_rider_think;
            return;
        }
        
        return;
    }
    
    var5 = "Both Fresno actors were unavailable!!";
    
    if ( isdefined( level.ref_11e18.setincomingremovedcallback ) )
    {
        level.ref_11e18.setincomingremovedcallback.ref_12930 = &sentry_init_done;
        return;
    }
    
    if ( isdefined( level.ref_11e18.wait_for_next_hack_complete ) )
    {
        level.ref_11e18.wait_for_next_hack_complete.ref_12930 = &vehicle_rider_think;
        return;
    }
}

// Params 0
// Size: 0x122
function activateevent()
{
    level endon( "game_ended" );
    level.ref_11e18.ref_12f14 = &lootleadermarksizedynamic;
    scripts\mp\gametypes\br_publicevents::ref_13371( "br_pe_fresno_start" );
    level thread scripts\mp\gametypes\br_public::brleaderdialog( "public_events_fresno_start" );
    setomnvar( "ui_publicevent_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", 8 );
    setomnvar( "ui_publicevent_timer", level.ref_11e18.ºË§!jÚ `ğU% );
    thread ref_11cdc( level.ref_11e18.ºË§!jÚ `ğU% );
    var0 = register_vehicle_spawn_override();
    var1 = 0;
    
    foreach ( var3 in var0 )
    {
        if ( istrue( level.disable_super_in_turret.ref_12ca4 ) )
        {
            var4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var3 );
        }
        else
        {
            var4 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( var3 );
        }
        
        var1 += var4.size;
    }
    
    self.secondwindthink = var1 * self.secondsbeforeplacementupdates;
    teamlist();
    totaldamage();
    thread ref_13fd0();
    level.ref_11e18.players_grenade_fire_monitor = 0;
    
    if ( level.ref_11e18.cöu¸s#Në“tO‡xGaváP != 0 )
    {
        scripts\mp\gametypes\fresno\fresno_screamer::choosescreamertitan();
    }
    
    level.ref_11e18.ˆZÌ9²›ôò×±Şê¹è++;
    level.ref_11e18.§<u=»æø–ê7Ix) = 1;
    level waittill( "fresno_end" );
}

// Params 2
// Size: 0x6d
function attackerisinflictorforradiusexplosiveweapon( var0, var1 )
{
    if ( getdvarint( "scr_br_pe_fresno_disable_drops", 0 ) )
    {
        return;
    }
    
    var2 = spawn( "trigger_radius", var0, 0, level.ref_11e18.playerredeploy, 50000 );
    var2.radius = level.ref_11e18.playerredeploy;
    var1.cashtorefund = var2;
    
    if ( scripts\mp\outofbounds::unset_relic_rocket_kill_ammo( var2.origin ) )
    {
        ref_136b1( var2 );
        ref_136a3( var2 );
        addweaponvehicledropcircle( var2 );
        return;
    }
}

// Params 2
// Size: 0x107
function activatescreamerdrop( var0, var1 )
{
    if ( level.ref_11e18.cöu¸s#Në“tO‡xGaváP < 0 || level.ref_11e18.cöu¸s#Në“tO‡xGaváP > 0 && level.ref_11e18.cöu¸s#Në“tO‡xGaváP == level.ref_11e18.ˆZÌ9²›ôò×±Şê¹è )
    {
        if ( var1 < var0.radius )
        {
            var2 = var1 / var0.radius;
            var3 = max( var2, 0.95 );
            var4 = scripts\mp\gametypes\br_circle::getrandompointincircle( var0.origin, var0.radius, var2, var3, 0, 0 );
            
            if ( scripts\mp\gametypes\br_circle::getdangercircleradius() > 0 )
            {
                if ( scripts\mp\gametypes\br_circle::updateprestreamrespawn( var4 ) == 0 )
                {
                    var4 = ( var4[ 0 ] * -1, var4[ 1 ], var4[ 2 ] );
                    
                    if ( scripts\mp\gametypes\br_circle::updateprestreamrespawn( var4 ) == 0 )
                    {
                        var4 = ( var4[ 0 ], var4[ 1 ] * -1, var4[ 2 ] );
                        
                        if ( scripts\mp\gametypes\br_circle::updateprestreamrespawn( var4 ) == 0 )
                        {
                            var4 = ( var4[ 0 ] * -1, var4[ 1 ], var4[ 2 ] );
                            
                            if ( scripts\mp\gametypes\br_circle::updateprestreamrespawn( var4 ) == 0 )
                            {
                                var4 = undefined;
                                iprintln( "Failed to spawn screamer crate" );
                            }
                        }
                    }
                }
            }
            
            if ( isdefined( var4 ) )
            {
                var4 = scripts\mp\gametypes\br_public::modifyplayer_damage( var4 );
                scripts\mp\gametypes\fresno\fresno_screamer::spawnmalfunctioningscreamerdevice( var0.origin, var4 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x17
function ref_136b1( var0 )
{
    level.ref_11a1f[ level.ref_11a1f.size ] = var0;
    scripts\mp\gametypes\br_publicevent_lootcratedrop::aud_breached_exit_wind();
}

// Params 1
// Size: 0xb6
function ref_136a3( var0 )
{
    var1 = getdvarint( "scr_br_pe_fresno_aa", 5 );
    
    for ( var2 = 0; var2 < var1 ; var2++ )
    {
        var3 = spawnstruct();
        var3.origin = scripts\mp\gametypes\br_publicevent_lootcratedrop::return_same_module_as_next_module( var0.origin, var0.radius );
        var3.origin = ( var3.origin[ 0 ], var3.origin[ 1 ], var3.origin[ 2 ] + getdvarfloat( "scr_br_fresno_truck_height", 6000 ) );
        var3.angles = var0.angles;
        var4 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle( "cargo_truck_susp_aa", var3, "alwaysSpawn", undefined );
        
        if ( isdefined( var4 ) )
        {
            level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4( var4, var3.origin, var3.angles, 1 );
        }
    }
}

// Params 0
// Size: 0x49
function table_parseweaponvariantidvalue()
{
    if ( istrue( level.ref_11e18.players_grenade_fire_monitor ) )
    {
        return;
    }
    
    level.ref_11e18.players_grenade_fire_monitor = 1;
    var0 = gettime() + getdvarfloat( "scr_br_pe_fresno_lifetime", 120 ) * 1000;
    level.ref_11e18.playerregenhealthadd = var0;
    clearweaponvehicledropcircles();
}

// Params 0
// Size: 0x16f
function strip_node_flag_wait()
{
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    waittillframeend();
    var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "heavy_weapon_crate" );
    var0.©„àRc½nŞ‘+©Ù‚Ú¸ø:p = 1;
    var0.“·W¢Ú0è¸Éƒz = 1;
    var0.…o; ´œy„‹ˆÈúÃãİƒÊ]¨ = "heavy_weapon_mendota";
    level.«³‰'úàV¯“°:•úÕ›V–µ¬{Ù²'É–È¬ = var0.ownerusetime;
    level.delaystreamtomovingplane = 1;
    level.shrink_poi_into_the_bank.besttimestate = 0;
    level.shrink_poi_into_the_bank.ref_13eff = [ [ "brloot_weapon_lm_dblmg_lege", "brloot_ammo_762" ], [ "brloot_weapon_rebirth_lm_iw8", "brloot_ammo_762" ], [ "brloot_weapon_rebirth_lm_t9", "brloot_ammo_762" ] ];
    level.shrink_poi_into_the_bank.chopper_gunner = [ [ "brloot_weapon_s4_la_palpha42_epic", "brloot_ammo_rocket" ], [ "brloot_weapon_s4_la_palpha_epic", "brloot_ammo_rocket" ], [ "brloot_weapon_s4_la_m1bravo_rare", "brloot_ammo_rocket" ] ];
    level.shrink_poi_into_the_bank.waypoints = [ [ "brloot_weapon_s4_mg_dpapa27_lege", "brloot_ammo_762" ], [ "brloot_weapon_s4_mg_mgolf42_lege", "brloot_ammo_762" ], [ "brloot_weapon_s4_mg_tyankee11_lege", "brloot_ammo_762" ], [ "brloot_weapon_s4_mg_bromeo37_lege", "brloot_ammo_762" ], [ "brloot_weapon_mendota_sn_xmike109", "brloot_ammo_50cal" ], [ "brloot_weapon_mendota_mr_ptango41", "brloot_ammo_50cal" ] ];
    level.shrink_poi_into_the_bank.waypoint_icon = level.shrink_poi_into_the_bank.waypoints;
    level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911 = [ [ "brloot_offhand_molotov", 2 ], [ "brloot_offhand_thermite", 2 ], [ "brloot_offhand_frag", 2 ] ];
}

// Params 0
// Size: 0x9a
function tac_cover_spawn_with_door()
{
    game[ "dialog" ][ "match_start" ] = "gametype_resurgence";
    game[ "dialog" ][ "match_desc" ] = "gametype_desc_resurgence";
    game[ "dialog" ][ "last_man_standing" ] = "rsrg_squad_last_alive";
    game[ "dialog" ][ "rebirth_avenge_teammate" ] = "rebirth_avenge_teammate";
    game[ "dialog" ][ "rebirth_redeploy" ] = "rebirth_redeploy";
    game[ "dialog" ][ "rebirth_disabled" ] = "rebirth_reinforcement_disabled";
    game[ "dialog" ][ "rebirth_ending" ] = "rebirth_reinforcement_ending";
    game[ "dialog" ][ "rebirth_teammate_respawn" ] = "rebirth_teammate_respawn";
}

// Params 1
// Size: 0x2d
function ref_11cdc( var0 )
{
    level endon( "game_ended" );
    level endon( "fresno_end" );
    
    for ( ;; )
    {
        var1 = gettime();
        
        if ( var1 >= var0 )
        {
            break;
        }
        
        waitframe();
    }
    
    thread playerrespawncleanup();
}

// Params 1
// Size: 0x15a
function vehicle_rider_think( var0 )
{
    scripts\mp\gametypes\fresno\fresno_state_machines::kheadtofrenzypoint( var0 );
    var0 thread scripts\mp\gametypes\fresno\fresno_state_machines::trunidlewait( "s4_mp_kenosha_idle_lookaround_01" );
    
    while ( !istrue( level.ref_11e18.§<u=»æø–ê7Ix) ) )
    {
        waitframe();
    }
    
    table_parseweaponvariantidvalue();
    
    if ( !isdefined( var0.cashtorefund ) )
    {
        var1 = spawn( "trigger_radius", var0.origin, 0, level.ref_11e18.playerredeploy, 50000 );
        var1.radius = level.ref_11e18.playerredeploy;
        var0.cashtorefund = var1;
    }
    else
    {
        var1 = var1.cashtorefund;
    }
    
    var1.„ÛCZJ[å( = undefined;
    
    if ( isdefined( level.ref_11e18.«÷n“²ÂkVÉ­[ ) )
    {
        thread activatescreamerdrop( level, var1 );
    }
    
    var1 setscriptablepartstate( "objective", "objective_enable_danger", 0 );
    scripts\mp\gametypes\fresno\fresno_state_machines::wait_juggernaut_announce( var1 );
    
    while ( scripts\mp\gametypes\fresno\fresno_state_machines::vehicle_occupancy_showcashbag( var1 ) )
    {
        scripts\mp\gametypes\fresno\fresno_state_machines::wait_for_tank_death( var1 );
        
        if ( scripts\mp\gametypes\fresno\fresno_state_machines::vehicle_occupancy_showcashbag( var1 ) )
        {
            scripts\mp\gametypes\fresno\fresno_state_machines::wait_for_tanks_almost_gone( var1 );
        }
    }
    
    var1 setscriptablepartstate( "objective", "objective_enable", 0 );
    scripts\mp\gametypes\fresno\fresno_state_machines::kreturntonormal( var1 );
    
    if ( isdefined( level.ref_11e18.«÷n“²ÂkVÉ­[ ) )
    {
        level.ref_11e18.«÷n“²ÂkVÉ­[ = undefined;
        level thread scripts\mp\gametypes\fresno\fresno_screamer::destroyscreamer();
    }
    
    var1.ref_11ea7 = 1;
    var1.cashtorefund = undefined;
    level.ref_11e18.wait_for_next_hack_complete.ref_12930 = undefined;
    
    if ( !isdefined( level.ref_11e18.setincomingremovedcallback.ref_12930 ) )
    {
        thread playerrespawncleanup();
        return;
    }
}

// Params 1
// Size: 0x1a1
function sentry_init_done( var0 )
{
    var1 = getdvarfloat( "scr_br_pe_fresno_gz_offset", 1.16667 );
    var2 = vectornormalize( scripts\mp\gametypes\br_circle::getsafecircleorigin() - var0.origin );
    var3 = level.ref_11e18.playerredeploy * var1;
    var4 = var0.origin + var2 * var3;
    level.ref_11e18.score_event_headshot = undefined;
    scripts\mp\gametypes\fresno\fresno_state_machines::gheadtofrenzypoint( var0 );
    var0 thread scripts\mp\gametypes\fresno\fresno_state_machines::trunidlewait( "s4_mp_greenbay_idle_lookaround_01" );
    
    while ( !istrue( level.ref_11e18.§<u=»æø–ê7Ix) ) && scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think( 16 ) )
    {
        waitframe();
    }
    
    table_parseweaponvariantidvalue();
    var0 setscriptablepartstate( "objective", "objective_enable_danger", 0 );
    
    if ( !isdefined( var0.cashtorefund ) )
    {
        var5 = spawn( "trigger_radius", var4, 0, level.ref_11e18.playerredeploy, 50000 );
        var5.radius = level.ref_11e18.playerredeploy;
        var0.cashtorefund = var5;
    }
    else
    {
        var5 = var1.cashtorefund;
    }
    
    var1.„ÛCZJ[å( = undefined;
    
    if ( isdefined( level.ref_11e18.÷sÇ_¹¹;RÁ ) )
    {
        thread activatescreamerdrop( level, var5 );
    }
    
    scripts\mp\gametypes\fresno\fresno_state_machines::set_dvars( var1 );
    
    while ( scripts\mp\gametypes\fresno\fresno_state_machines::post_blockade_breadcrumb_struct( var1 ) )
    {
        scripts\mp\gametypes\fresno\fresno_state_machines::select_woods_two_spawners( var1 );
        
        if ( scripts\mp\gametypes\fresno\fresno_state_machines::post_blockade_breadcrumb_struct( var1 ) )
        {
            scripts\mp\gametypes\fresno\fresno_state_machines::send_munition_used_notify( var1 );
        }
    }
    
    var1 setscriptablepartstate( "objective", "objective_enable", 0 );
    scripts\mp\gametypes\fresno\fresno_state_machines::set_door_open( var1 );
    
    if ( isdefined( level.ref_11e18.÷sÇ_¹¹;RÁ ) )
    {
        level.ref_11e18.÷sÇ_¹¹;RÁ = undefined;
        level thread scripts\mp\gametypes\fresno\fresno_screamer::destroyscreamer();
    }
    
    var1.ref_11ea7 = 1;
    var1.cashtorefund = undefined;
    level.ref_11e18.setincomingremovedcallback.ref_12930 = undefined;
    
    if ( !isdefined( level.ref_11e18.wait_for_next_hack_complete.ref_12930 ) )
    {
        thread playerrespawncleanup();
        return;
    }
}

// Params 0
// Size: 0x1a
function playerrespawncleanup()
{
    ref_11ec4();
    level.ref_11e18.ºË§!jÚ `ğU% = undefined;
    scripts\mp\gametypes\br_publicevents::neurotoxin_mask_monitor( 16 );
}

// Params 0
// Size: 0x3b
function players_approach_puzzle_monitor()
{
    setomnvar( "ui_publicevent_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    wait 0.1;
    mp_port2_gw_patch();
    scripts\mp\gametypes\fresno\fresno_screamer::endevent_malfunctioningscreamerdevice();
    recordeventendanalytics();
    print_event_logs();
    level.ref_11e18.§<u=»æø–ê7Ix) = undefined;
}

// Params 0
// Size: 0xa
function ref_11ec4()
{
    level notify( "fresno_end" );
}

// Params 0
// Size: 0x100
function post_safeges_weapon()
{
    var0 = [];
    GscBinSkip0( 0x2e, var0.size, ( -6969, -62217, -628 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x89
function teamlist()
{
    var0 = getdvar( "scr_be_fresno_attack_odds_table", "30 50 70" );
    var1 = strtok( var0, " " );
    
    if ( var1.size != 3 )
    {
        var1 = strtok( "30 50 70", " " );
    }
    
    level.ref_11e18.cave_barrels = [];
    level.ref_11e18.cave_barrels[ "best_team" ] = int( var1[ 0 ] );
    level.ref_11e18.cave_barrels[ "random_team" ] = int( var1[ 1 ] );
    level.ref_11e18.cave_barrels[ "tomah_anger" ] = int( var1[ 2 ] );
}

// Params 2
// Size: 0x15e
function propspectating( var0, var1 )
{
    if ( !isdefined( level.ref_11e18.cave_barrels ) )
    {
        return undefined;
    }
    
    level.ref_11e18.ref_12f14 = &lootleadermarksizedynamic;
    var2 = undefined;
    var3 = randomint( 100 );
    var3 = getdvarint( "scr_br_pe_fresno_attack_die_roll", var3 );
    
    if ( var3 < level.ref_11e18.cave_barrels[ "random_team" ] )
    {
        var4 = scripts\mp\gametypes\_mxp_target::recharge_equipment_init( var3 < level.ref_11e18.cave_barrels[ "best_team" ] );
        
        if ( isdefined( var4 ) )
        {
            var5 = self.cashtorefund scripts\mp\gametypes\_mxp_target::quarry2_ambient_sound_load( var4 );
            
            if ( isdefined( var1 ) )
            {
                var6 = var1.team;
                var7 = var1 getsquadindex();
                var8 = var5;
                var5 = [];
                
                foreach ( var10 in var8 )
                {
                    if ( var10.team != var6 || var10 getsquadindex() != var7 )
                    {
                        var5 = var10;
                    }
                }
            }
            
            if ( var5.size > 0 )
            {
                var12 = randomint( var5.size );
                var2 = var5[ var12 ];
            }
        }
    }
    
    if ( !isdefined( var2 ) && var3 < level.ref_11e18.cave_barrels[ "tomah_anger" ] )
    {
        var2 = scripts\mp\gametypes\br_alt_mode_mxp::tgetnextangertarget( self );
        
        if ( isdefined( var2 ) )
        {
        }
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = self.cashtorefund scripts\mp\gametypes\_mxp_target::printspawnmessage( var0, level.ref_11e18.playerredeploy, var1 );
        
        if ( isdefined( var2 ) )
        {
        }
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = self.cashtorefund scripts\mp\gametypes\_mxp_target::pristinestatehealthadd( var0, level.ref_11e18.playerredeploy );
    }
    
    return var2;
}

// Params 0
// Size: 0xf5
function totaldamage()
{
    level.ref_13aaa = [];
    
    foreach ( var1 in level.teamnamelist )
    {
        if ( isdefined( level.teamdata[ var1 ] ) && isdefined( level.teamdata[ var1 ][ "aliveCount" ] ) && level.teamdata[ var1 ][ "aliveCount" ] > 0 )
        {
            level.ref_13aaa[ var1 ] = 0;
        }
    }
    
    foreach ( var4 in level.players )
    {
        if ( isdefined( var4 ) )
        {
            var5 = spawnstruct();
            var5.ref_13bee = 0;
            var5.ref_14239 = 0;
            var5.open_cac_slot = 0;
            var5.ref_1457e = 0;
            var4.ref_12532 = var5;
        }
    }
    
    level.ref_11e18.ref_13bef = [];
    level.ref_11e18.ref_13bef[ "actor_kenosha" ] = 0;
    level.ref_11e18.ref_13bef[ "actor_greenbay" ] = 0;
}

// Params 0
// Size: 0x120
function ref_13fd0()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    level endon( "fresno_end" );
    var0 = 0.1;
    var1 = level.delayedeventtypes[ 16 ].secondwindthink * 2;
    var2 = 1;
    
    for ( ;; )
    {
        var3 = relic_mythic_should_do_pain();
        var4 = var3[ 0 ][ 0 ];
        var5 = var3[ 0 ][ 1 ];
        var6 = var3[ 1 ][ 0 ];
        var7 = var3[ 1 ][ 1 ];
        var8 = level.ref_11e18.ref_13bef[ "actor_greenbay" ] + level.ref_11e18.ref_13bef[ "actor_kenosha" ];
        var9 = var8 / var1;
        setomnvar( "ui_pe_fresno_total_damage", var9 );
        var2 = var5 / var1;
        setomnvar( "ui_pe_fresno_first_place_squad_damage", var2 );
        
        foreach ( var11 in level.players )
        {
            var12 = updateplayerandteamcountui( var11 );
            var11 setclientomnvar( "ui_pe_fresno_is_in_range", 1 );
            var2 = 0;
            var13 = level.ref_13aaa[ var11.team ];
            
            if ( isdefined( var13 ) )
            {
                var2 = var13 / var1;
            }
            
            var11 setclientomnvar( "ui_pe_fresno_player_squad_damage", var2 );
        }
        
        wait var0;
    }
}

// Params 14
// Size: 0x2c9
function sec_sys_struct_3( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 )
{
    var14 = var1;
    
    if ( isdefined( var1.classname ) && ( var1.classname == "script_vehicle" || var1.classname == "misc_turret" ) )
    {
        if ( isdefined( var1.owner ) )
        {
            var14 = var1.owner;
        }
    }
    
    if ( isplayer( var14 ) )
    {
        var14 scripts\mp\gametypes\br_alt_mode_mxp::playerupdatetomahdamage( self, var2, var4, var5, 1 );
        
        if ( !istrue( level.ref_11e18.§<u=»æø–ê7Ix) ) || level.ref_11e18.ref_13bef[ self.agent_type ] >= level.delayedeventtypes[ 16 ].secondwindthink )
        {
            return;
        }
        
        if ( !isdefined( level.ref_13aaa[ var14.team ] ) )
        {
            level.ref_13aaa[ var14.team ] = 0;
        }
        
        if ( !isdefined( var14.ref_12532 ) )
        {
            var15 = spawnstruct();
            var15.ref_13bee = 0;
            var15.ref_14239 = 0;
            var15.open_cac_slot = 0;
            var15.ref_1457e = 0;
            var14.ref_12532 = var15;
        }
        
        if ( vault_assault_infil( var0, var1 ) )
        {
            var2 = ref_11ca1( var2, var0, var1 );
            var2 = clampdamageforhealth( var2 );
            var14.ref_12532.ref_14239 += var2;
        }
        else if ( isexplosivedamage( var4 ) )
        {
            var2 *= getdvarfloat( "scr_br_pe_fresno_expl_dmgmult", 5 );
            var2 = clampdamageforhealth( var2 );
            var14.ref_12532.open_cac_slot += var2;
        }
        else
        {
            var2 *= getdvarfloat( "scr_br_pe_fresno_weap_dmgmult", 1 );
            var2 = clampdamageforhealth( var2 );
            var14.ref_12532.ref_1457e += var2;
        }
        
        level.ref_13aaa[ var14.team ] += var2;
        var14.ref_12532.ref_13bee += var2;
        var14 scripts\mp\damagefeedback::updatedamagefeedback( "standard", 0, 0, "standard", 0, 1 );
        var14.players_in_aggro = self.agent_type;
        level.ref_11e18.ref_13bef[ self.agent_type ] += var2;
        
        if ( level.ref_11e18.ref_13bef[ self.agent_type ] > level.delayedeventtypes[ 16 ].secondwindthink )
        {
            self notify( "gk_driven_off" );
        }
        
        var16 = level.ref_11e18.ref_13bef[ self.agent_type ] / level.delayedeventtypes[ 16 ].secondwindthink;
        
        if ( self.agent_type == "actor_kenosha" )
        {
            setomnvar( "ui_pe_fresno_progress_kenosha", var16 );
            return;
        }
        
        if ( self.agent_type == "actor_greenbay" )
        {
            setomnvar( "ui_pe_fresno_progress_greenbay", var16 );
            return;
        }
        
        return;
    }
}

// Params 15
// Size: 0x12
function secondaryweaponbackup( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    
}

// Params 0
// Size: 0xe7
function relic_mythic_should_do_pain()
{
    if ( !isdefined( self.is_wave_exist ) )
    {
        self.is_wave_exist = [ [ "none", -1 ], [ "none", -1 ], [ "none", -1 ], [ "none", -1 ] ];
    }
    
    foreach ( var5, var1 in level.ref_13aaa )
    {
        for ( var2 = 0; var2 < self.is_wave_exist.size ; var2++ )
        {
            var3 = self.is_wave_exist[ var2 ][ 0 ];
            var4 = self.is_wave_exist[ var2 ][ 1 ];
            
            if ( var1 > var4 || var3 == var5 )
            {
                if ( var5 != var3 && var2 + 1 < self.is_wave_exist.size )
                {
                    self.is_wave_exist[ var2 + 1 ] = self.is_wave_exist[ var2 ];
                }
                
                self.is_wave_exist[ var2 ][ 0 ] = var5;
                self.is_wave_exist[ var2 ][ 1 ] = var1;
                break;
            }
        }
    }
    
    return self.is_wave_exist;
}

// Params 3
// Size: 0x7c
function ref_11ca1( var0, var1, var2 )
{
    if ( var1.classname == "script_model" && var1.model == "lm_ach_gp_bomb_600lb_01_gameplay" )
    {
        var0 = getdvarfloat( "scr_br_pe_fresno_bt_dmg", 5000 );
    }
    else if ( var1.classname == "misc_turret" && var1.model == "veh_s4_mil_lnd_turret_quad_aa_wz" )
    {
        var0 = getdvarfloat( "scr_br_pe_fresno_flak_dmg", 100 );
    }
    else
    {
        var0 *= getdvarfloat( "scr_br_pe_fresno_veh_dmgmult", 1 );
    }
    
    return var0;
}

// Params 1
// Size: 0x37
function clampdamageforhealth( var0 )
{
    var1 = level.delayedeventtypes[ 16 ].secondwindthink;
    var2 = level.ref_11e18.ref_13bef[ self.agent_type ];
    
    if ( var0 + var2 > var1 )
    {
        return ( var1 - var2 );
    }
    
    return var0;
}

// Params 0
// Size: 0x162
function mp_port2_gw_patch()
{
    var0 = relic_mythic_should_do_pain();
    var1 = [ "br_pe_1st_place", "br_pe_2nd_place", "br_pe_3rd_place", "br_pe_4th_place" ];
    
    for ( var2 = 0; var2 < var0.size ; var2++ )
    {
        var3 = var0[ var2 ][ 0 ];
        
        if ( var3 == "none" )
        {
            continue;
        }
        
        var4 = scripts\mp\utility\teams::getfriendlyplayers( var3, 0 );
        
        foreach ( var6 in var4 )
        {
            var6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "mv_event_intel_12" );
        }
        
        showsplashtoteam( var3, var1[ var2 ] );
        
        if ( var2 == 0 )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "public_events_fresno_top_reward", var3 );
            thread endevent_spawnrewardcache( level, "fresno_reward_lege" );
            
            foreach ( var6 in var4 )
            {
                var6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "mv_event_intel_7" );
            }
            
            continue;
        }
        
        thread endevent_spawnrewardcache( level, "fresno_reward_rare" );
    }
    
    foreach ( var6 in level.players )
    {
        if ( isdefined( var6 ) && isalive( var6 ) )
        {
            var11 = 0;
            
            for ( var2 = 0; var2 < var0.size ; var2++ )
            {
                if ( var6.team == var0[ var2 ][ 0 ] )
                {
                    var11 = 1;
                    break;
                }
            }
            
            if ( !var11 )
            {
                var6 thread scripts\mp\hud_message::showsplash( "br_pe_unranked" );
            }
        }
    }
}

// Params 2
// Size: 0x126
function endevent_spawnrewardcache( var0, var1 )
{
    wait 2;
    var2 = undefined;
    var3 = scripts\mp\utility\teams::getfriendlyplayers( var1, 1 );
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var2 ) || var5.ref_12532.ref_13bee > var2.ref_12532.ref_13bee && scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var5.origin ) )
        {
            var2 = var5;
        }
    }
    
    if ( isdefined( var2 ) )
    {
        var7 = getdvarfloat( "scr_br_pe_fresno_reward_offset", 2000 );
        var8 = vectornormalize( scripts\mp\gametypes\br_circle::getsafecircleorigin() - var2.origin );
        var9 = var2.origin + var8 * var7;
        var10 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( var9, 500, 0.5, 0.9, 1 );
        var10 = getclosestpointonnavmesh( var10, var2 );
        var11 = ( var10[ 0 ], var10[ 1 ], var10[ 2 ] + 2000 );
        var12 = scripts\cp_mp\killstreaks\airdrop::dropcrate( undefined, undefined, "fresno_crate", var11, ( 0, randomint( 360 ), 0 ), var10 );
        var13 = getdvarfloat( "scr_br_pe_fresno_reward_duration", 90 );
        var12.expiretime = gettime() + var13 * 1000;
        var12.‚™Ëß¾ûĞc‹HPë = var0;
        thread reward_crate_fx();
        thread reward_crate_icon();
        thread reward_crate_cleanup();
        return;
    }
}

// Params 0
// Size: 0x3e
function gz_onkilled()
{
    if ( istrue( self.„ÛCZJ[å( ) )
    {
        return;
    }
    
    self.„ÛCZJ[å( = 1;
    scripts\mp\gametypes\br_publicevents::ref_13371( "br_pe_fresno_greenbay_down" );
    level thread scripts\mp\gametypes\br_public::brleaderdialog( "public_events_g_staggered" );
    wait 1;
    thread tdownchallenges( "gz" );
    thread spawnintelcrates();
}

// Params 0
// Size: 0x3e
function kk_onkilled()
{
    if ( istrue( self.„ÛCZJ[å( ) )
    {
        return;
    }
    
    self.„ÛCZJ[å( = 1;
    scripts\mp\gametypes\br_publicevents::ref_13371( "br_pe_fresno_kenosha_down" );
    level thread scripts\mp\gametypes\br_public::brleaderdialog( "public_events_k_staggered" );
    wait 1;
    thread tdownchallenges( "kk" );
    thread spawnintelcrates();
}

// Params 1
// Size: 0x82
function tdownchallenges( var0 )
{
    var1 = "mv_event_intel_10";
    
    if ( var0 == "kk" )
    {
        var1 = "mv_event_intel_11";
    }
    
    foreach ( var3 in level.ref_13aaa )
    {
        var4 = scripts\mp\utility\teams::getfriendlyplayers( var8, 0 );
        
        if ( isdefined( var4 ) && var4.size > 0 )
        {
            foreach ( var6 in var4 )
            {
                var6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( var1 );
            }
        }
    }
}

// Params 0
// Size: 0x26d
function spawnintelcrates()
{
    var0 = [];
    var1 = getdvarint( "scr_br_pe_fresno_num_intel_crate", 5 );
    var2 = undefined;
    
    if ( isdefined( self.agent_type ) && self.agent_type == "actor_kenosha" )
    {
        var2 = "k";
        var3 = level.ref_11e18.wait_for_open;
    }
    else if ( isdefined( self.agent_type ) && self.agent_type == "actor_greenbay" )
    {
        var3 = "g";
        var3 = level.ref_11e18.setlastdroppableweaponobj;
    }
    else
    {
        return;
    }
    
    if ( isdefined( self.cashtorefund ) )
    {
        var4 = self.cashtorefund.origin;
    }
    else
    {
        var4 = self.origin;
    }
    
    for ( var5 = 0; var5 < var3 ; var5++ )
    {
        var6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( var4, level.ref_11e18.playerredeploy, 0.1, 0.9, 1 );
        var7 = spawnstruct();
        var7.origin = var6;
        var7.type = var3;
        var7.index = var4;
        var2 = var7;
    }
    
    for ( var8 = 0; var8 < var2.size ; var8++ )
    {
        var9 = randomint( 360 );
        
        for ( var10 = 0; var10 < level.ref_11bce.ref_11f1e ; var10++ )
        {
            var11 = var9 + 90;
            var12 = 0;
            var13 = undefined;
            var14 = 0;
            
            while ( var14 < 360 )
            {
                var15 = ( 0, var11 + var14, 0 );
                var16 = anglestoforward( var15 );
                var7 = var2[ var8 ];
                var13 = var7.origin + var16 * level.ref_11bce.train_get_num_of_anim_ents[ var7.type ];
                
                if ( !scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var13 ) || scripts\mp\gametypes\br_gametype_mendota::updatesquadleaderpassstateforteam( var13 ) )
                {
                }
                else if ( !isdefined( level.br_circle.dangercircleent ) || scripts\mp\gametypes\br_circle::updateprestreamrespawn( var13 ) )
                {
                    var12 = 1;
                    break;
                }
                
                var14 += 10;
            }
            
            if ( !var12 )
            {
                break;
            }
            
            var9 = var11;
            var17 = scripts\mp\gametypes\br_public::modifyplayer_damage( var13 );
            var17 += ( 0, 0, 2000 );
            var18 = scripts\cp_mp\killstreaks\airdrop::dropcrate( undefined, undefined, "intel_crate", var17, ( 0, randomint( 360 ), 0 ) );
            var18.trial_flares = var2[ var8 ];
            var19 = randomfloatrange( level.ref_11bce.trial_fetch_mission_table, level.ref_11bce.trial_explosive_clear ) * 1000;
            var18.trial_flares.expiretime = gettime() + var19;
            level.train_hurt_damage_watcher[ level.train_hurt_damage_watcher.size ] = var18;
            var18 thread scripts\mp\gametypes\br_gametype_mendota::train_handle_collide_mines();
            var18 thread scripts\mp\gametypes\br_gametype_mendota::train_horn_sfx();
        }
    }
}

// Params 3
// Size: 0x72
function players_camera_fly_to_start_pos( var0, var1, var2 )
{
    var3 = getdvarint( "scr_br_pe_fresno_intel_min", 3 );
    var4 = getdvarint( "scr_br_pe_fresno_intel_max", 6 );
    var5 = getdvarint( "scr_br_pe_fresno_intel_stack_min", 3 );
    var6 = getdvarint( "scr_br_pe_fresno_intel_stack_max", 5 );
    var7 = randomintrange( var3, var4 );
    var8 = randomintrange( var5, var6 );
    
    for ( var9 = 0; var9 < var8 ; var9++ )
    {
        var10 = scripts\mp\gametypes\br_lootcache::ref_11a41( "brloot_mendota_intel", var0, var1, var2, 0, 0 );
        var10.count = var7;
    }
}

// Params 0
// Size: 0xb4
function init_reward_crates()
{
    var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "fresno_crate" );
    var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
    var0.dummymodel = "military_carepackage_02_br";
    var0.friendlymodel = undefined;
    var0.enemymodel = undefined;
    var0.mountmantlemodel = undefined;
    var0.supportsownercapture = 0;
    var0.headicon = undefined;
    var0.minimapicon = undefined;
    var0.usepriority = -1;
    var0.usefov = 180;
    var0.timeout = undefined;
    var0.friendlyuseonly = 0;
    var0.ownerusetime = 0.5;
    var0.otherusetime = 0.5;
    var0.activatecallback = &rewardcrateactivatecallback;
    var0.capturecallback = &rewardcratecapturecallback;
    var0.destroyoncapture = 1;
}

// Params 1
// Size: 0x30
function rewardcrateactivatecallback( var0 )
{
    if ( istrue( var0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x9c
function rewardcratecapturecallback( var0 )
{
    self notify( "captured" );
    var1 = randomint( 10 );
    var2 = verifybunkercode( self.‚™Ëß¾ûĞc‹HPë, var1 );
    var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var3.´ÿÛ¥ˆêJÃ~‚™râİ = 1;
    
    foreach ( var5 in var2 )
    {
        var6 = scripts\mp\gametypes\br_lootcache::ref_11a41( var5, var3, self.origin, self.angles, 0, 1 );
    }
    
    if ( isdefined( self.objectiveiconid ) )
    {
        objective_delete( self.objectiveiconid );
    }
    
    playfx( level.conf_fx[ "vanish" ], self.molotov_delete_oldest_trigger.origin );
    self.molotov_delete_oldest_trigger delete();
}

// Params 0
// Size: 0x64
function reward_crate_fx()
{
    var0 = scripts\mp\gametypes\br_public::modifyplayer_damage( self.origin, 50, -3000 );
    self.molotov_delete_oldest_trigger = spawn( "script_model", var0 + ( 0, 0, 3 ) );
    self.molotov_delete_oldest_trigger setmodel( "scr_smoke_grenade" );
    wait 1;
    self.molotov_delete_oldest_trigger playloopsound( "mp_flare_burn_lp" );
    self.molotov_delete_oldest_trigger setscriptablepartstate( "smoke", "on" );
}

// Params 0
// Size: 0x12
function reward_crate_icon()
{
    self setscriptablepartstate( "objective_map", "pe_chopper_crate", 0 );
}

// Params 0
// Size: 0x61
function reward_crate_cleanup()
{
    self endon( "captured" );
    level endon( "game_ended" );
    
    while ( isdefined( self ) && !istrue( self.isdestroyed ) && gettime() < self.expiretime )
    {
        waitframe();
    }
    
    if ( isdefined( self ) && !istrue( self.isdestroyed ) )
    {
        self.molotov_delete_oldest_trigger delete();
        playfx( level.conf_fx[ "vanish" ], self.origin );
        scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
        return;
    }
}

// Params 1
// Size: 0xba
function redeployspawns( var0 )
{
    var1 = gettime();
    var2 = 1;
    
    if ( !isdefined( level.ref_11e18.waittill_player_collects_death_cash ) || var1 - level.ref_11e18.waittill_player_collects_death_cash >= 1000 )
    {
        var2 = 0;
    }
    
    if ( !isdefined( level.ref_11e18.ref_140c2 ) )
    {
        level.ref_11e18.ref_140c2 = [];
        var2 = 0;
    }
    
    if ( !var2 || istrue( var0 ) )
    {
        var3 = self.origin;
        
        if ( isdefined( self.cashtorefund ) )
        {
            var3 = self.cashtorefund.origin;
        }
        
        level.ref_11e18.ref_140c2 = getentarrayinradius( "player", "classname", var3, level.ref_11e18.playerredeploy );
        level.ref_11e18.waittill_player_collects_death_cash = var1;
    }
    
    return level.ref_11e18.ref_140c2;
}

// Params 1
// Size: 0x9d
function sec_sys_struct_2( var0 )
{
    var1 = redeployspawns();
    var2 = scripts\engine\utility::array_contains( var1, var0 );
    
    if ( !var2 && getdvarint( "scr_br_pe_fresno_distance_check_fallback", 1 ) )
    {
        var3 = self.origin;
        
        if ( isdefined( self.cashtorefund ) )
        {
            var3 = self.cashtorefund.origin;
        }
        
        var2 = distance2d( var0.origin, var3 ) <= level.ref_11e18.playerredeploy;
        
        if ( var2 )
        {
            level.ref_11e18.ref_140c2 = scripts\engine\utility::array_add( level.ref_11e18.ref_140c2, var0 );
        }
    }
    
    if ( var2 )
    {
        var0.players_in_aggro = self.agent_type;
    }
    else
    {
        var0.players_in_aggro = undefined;
    }
    
    return var2;
}

// Params 1
// Size: 0x55
function updateplayerandteamcountui( var0 )
{
    var1 = 0;
    
    if ( isdefined( level.ref_11e18.setincomingremovedcallback ) )
    {
        var1 = var1 || sec_sys_struct_2( level.ref_11e18.setincomingremovedcallback, var0 );
    }
    
    if ( isdefined( level.ref_11e18.wait_for_next_hack_complete ) )
    {
        var1 = var1 || sec_sys_struct_2( level.ref_11e18.wait_for_next_hack_complete, var0 );
    }
    
    return var1;
}

// Params 2
// Size: 0x82, Type: bool
function vault_assault_infil( var0, var1 )
{
    if ( isdefined( var1.classname ) && ( var1.classname == "script_vehicle" || var1.classname == "misc_turret" ) )
    {
        return true;
    }
    
    if ( isdefined( var0 ) && var0 != var1 && isdefined( var0.classname ) )
    {
        if ( var0.classname == "misc_turret" )
        {
            return true;
        }
        
        if ( var0.classname == "script_model" && var0.model == "lm_ach_gp_bomb_600lb_01_gameplay" )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x3e, Type: bool
function isexplosivedamage( var0 )
{
    return var0 == "MOD_GRENADE" || var0 == "MOD_EXPLOSIVE" || var0 == "MOD_GRENADE_SPLASH" || var0 == "MOD_EXPLOSIVE_BULLET" || var0 == "MOD_PROJECTILE" || var0 == "MOD_PROJECTILE_SPLASH";
}

// Params 1
// Size: 0x7d, Type: bool
function unset_relic_nobulletdamage( var0 )
{
    var1 = createheadicon( var0 );
    var2 = level.br_pickups.br_weapontoscriptable[ var1 ];
    
    if ( isdefined( var2 ) )
    {
        if ( can_be_seen_by_any_player( level.shrink_poi_into_the_bank.ref_13eff, var2 ) )
        {
            return true;
        }
        
        if ( can_be_seen_by_any_player( level.shrink_poi_into_the_bank.chopper_gunner, var2 ) )
        {
            return true;
        }
        
        if ( can_be_seen_by_any_player( level.shrink_poi_into_the_bank.waypoints, var2 ) )
        {
            return true;
        }
    }
    
    if ( scripts\mp\utility\weapon::getweapongroup( var0.basename ) == "weapon_lmg" )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x51, Type: bool
function can_be_seen_by_any_player( var0, var1 )
{
    if ( var0.size <= 0 )
    {
        return false;
    }
    
    foreach ( var3 in var0 )
    {
        if ( isarray( var3 ) )
        {
            if ( var3[ 0 ] == var1 )
            {
                return true;
            }
            
            continue;
        }
        
        if ( var3 == var1 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 5
// Size: 0x28
function lootleadermarksizedynamic( var0, var1, var2, var3, var4 )
{
    var5 = randomfloatrange( 0.5, 1 );
    
    if ( istrue( var4 ) )
    {
        var5 *= 1.5;
    }
    
    return var0 * var5;
}

// Params 2
// Size: 0x38
function showsplashtoteam( var0, var1 )
{
    var2 = scripts\mp\utility\teams::getfriendlyplayers( var0, 1 );
    
    foreach ( var4 in var2 )
    {
        var4 thread scripts\mp\hud_message::showsplash( var1 );
    }
}

// Params 0
// Size: 0x60
function register_vehicle_spawn_override()
{
    var0 = [];
    
    foreach ( var2 in level.teamnamelist )
    {
        if ( isdefined( level.teamdata[ var2 ] ) && isdefined( level.teamdata[ var2 ][ "aliveCount" ] ) && level.teamdata[ var2 ][ "aliveCount" ] > 0 )
        {
            var0 = var2;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x2b, Type: bool
function isfresnoactive()
{
    return isdefined( level.ref_11e18.setincomingremovedcallback.ref_12930 ) || isdefined( level.ref_11e18.wait_for_next_hack_complete.ref_12930 );
}

// Params 0
// Size: 0x30
function getfresnotimeremaining()
{
    if ( !isdefined( level.ref_11e18.ºË§!jÚ `ğU% ) )
    {
        return 0;
    }
    
    var0 = gettime();
    return ( level.ref_11e18.ºË§!jÚ `ğU% - var0 ) / 1000;
}

// Params 0
// Size: 0x52
function clearweaponvehicledropcircles()
{
    if ( isdefined( level.ref_11e18.­Œ¿ÚXªß¨“ºx«GÅ…q¦ˆ³ZÛê^Å ) )
    {
        foreach ( var1 in level.ref_11e18.­Œ¿ÚXªß¨“ºx«GÅ…q¦ˆ³ZÛê^Å )
        {
            var1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
        }
    }
    
    level.ref_11e18.­Œ¿ÚXªß¨“ºx«GÅ…q¦ˆ³ZÛê^Å = [];
}

// Params 1
// Size: 0x61
function addweaponvehicledropcircle( var0 )
{
    if ( !isdefined( level.ref_11e18.­Œ¿ÚXªß¨“ºx«GÅ…q¦ˆ³ZÛê^Å ) )
    {
        level.ref_11e18.­Œ¿ÚXªß¨“ºx«GÅ…q¦ˆ³ZÛê^Å = [];
    }
    
    var0 scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 3, 0, 0, var0.origin );
    var0 scripts\mp\gametypes\br_quest_util::ref_1316f( var0.radius );
    var0 scripts\mp\gametypes\br_quest_util::ref_13369();
    level.ref_11e18.­Œ¿ÚXªß¨“ºx«GÅ…q¦ˆ³ZÛê^Å[ level.ref_11e18.­Œ¿ÚXªß¨“ºx«GÅ…q¦ˆ³ZÛê^Å.size ] = var0;
}

// Params 0
// Size: 0xea
function recordeventendanalytics()
{
    var0 = 0;
    var1 = 0;
    var2 = 0;
    
    foreach ( var4 in level.players )
    {
        if ( isdefined( var4 ) && isdefined( var4.ref_12532 ) )
        {
            var0 += var4.ref_12532.ref_14239;
            var1 += var4.ref_12532.open_cac_slot;
            var2 += var4.ref_12532.ref_1457e;
        }
    }
    
    getentitylessscriptablearray( "dlog_event_br_pe_fresno_end", [ "gk_maxhealth", level.delayedeventtypes[ 16 ].secondwindthink, "g_totaldamage", int( level.ref_11e18.ref_13bef[ "actor_greenbay" ] ), "k_totaldamage", int( level.ref_11e18.ref_13bef[ "actor_kenosha" ] ), "expl_damage", int( var1 ), "veh_damage", int( var0 ), "weap_damage", int( var2 ) ] );
}

// Params 0
// Size: 0x173
function print_event_logs()
{
    if ( getdvarint( "fresno_debug_logs", 0 ) == 0 )
    {
        return;
    }
    
    var0 = "===================================\n";
    var1 = level.delayedeventtypes[ 16 ].secondwindthink;
    var0 += "gkMaxHealth: " + var1 + "\n";
    var0 += "gDamage: " + level.ref_11e18.ref_13bef[ "actor_greenbay" ] + "\n";
    var0 += "kDamage: " + level.ref_11e18.ref_13bef[ "actor_kenosha" ] + "\n";
    var2 = 0;
    var3 = 0;
    var4 = 0;
    
    foreach ( var6 in level.players )
    {
        if ( isdefined( var6 ) && isdefined( var6.ref_12532 ) )
        {
            var2 += var6.ref_12532.ref_14239;
            var3 += var6.ref_12532.open_cac_slot;
            var4 += var6.ref_12532.ref_1457e;
        }
    }
    
    var0 += "Total Vehicle Damage: " + var2 + "\n";
    var0 += "Total Explosive Damage: " + var3 + "\n";
    var0 += "Total Weapon Damage: " + var4 + "\n";
    var8 = level.delayedeventtypes[ 16 ].is_wave_exist;
    
    for ( var9 = 0; var9 < var8.size ; var9++ )
    {
        var0 += "Damage Leader " + var9 + 1 + " Total: " + var8[ var9 ][ 1 ] + "\n";
    }
    
    println_wrapper( var0 + "===================================" );
}

// Params 1
// Size: 0xf
function println_wrapper( var0 )
{
    logstring( "FRESNO DEBUG:: " + var0 );
}

