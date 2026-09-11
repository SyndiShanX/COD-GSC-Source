
// Params 0
// Size: 0x1e
function init()
{
    scripts\mp\agents\agent_encounter_manager::init();
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "circle" );
    init_vfx();
    thread table_getaddblueprintattachments();
}

// Params 0
// Size: 0x2
function init_vfx()
{
    
}

// Params 0
// Size: 0xf
function table_getaddblueprintattachments()
{
    waitframe();
    tarmac_techo_start();
    thread raid_watch_for_start();
}

// Params 0
// Size: 0x6f
function tarmac_techo_start()
{
    level.yÎ®b9›3HxG´ = spawnstruct();
    level.yÎ®b9›3HxG´.––ÈÿãÓS7PeK‘[ = 0;
    level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( = 0;
    level.yÎ®b9›3HxG´.±c	³sCpóßã = [];
    level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘ = [];
    level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­· = [];
    level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà = [];
    level.yÎ®b9›3HxG´.«ÃÂõ½šYÆ:´ÎÊÍ×6{Ö86¬Ê‘ = [];
    init_map_variables();
    init_raid_variables();
}

// Params 0
// Size: 0x387
function init_map_variables()
{
    switch ( getdvar( "mapname" ) )
    {
        case "mp_sm_island_1":
            register_objective_location( "winery2", ( 3313, -398, 1385 ), ( 0, -2, 0 ) );
            register_objective_location( "radio", ( 3399, -3958, 1108 ), ( 0, 21, 0 ) );
            register_objective_location( "lighthouse", ( 7513, -5579, 565 ), ( 0, 331, 0 ) );
            register_objective_location( "winery", ( 7777, 512, 1070 ), ( 0, 195, 0 ) );
            register_objective_location( "grotto", ( -1300, -1331, 249 ), ( 0, 31, 0 ) );
            register_objective_location( "camp", ( -3496, -4755, 977 ), ( 0, 105, 0 ) );
            register_objective_location( "library", ( -6638, -244, 1249 ), ( 0, -2, 0 ) );
            register_objective_location( "graveyard", ( -4214, 2145, 1406 ), ( 0, 21, 0 ) );
            register_objective_location( "terraces", ( -1468, 6260, 1485 ), ( 0, 331, 0 ) );
            register_objective_location( "church", ( -1279, 3698, 1408 ), ( 0, 195, 0 ) );
            register_objective_location( "fort", ( 3142, 6800, 1180 ), ( 0, 31, 0 ) );
            register_objective_location( "airstrip", ( 11730, -3835, 555 ), ( 0, 105, 0 ) );
            register_objective_location( "clocktower_nest", ( -7243, 765, 1511 ), ( 0, -2, 0 ) );
            register_objective_location( "keep_west_nest", ( -2837, 4387, 2102 ), ( 0, 21, 0 ) );
            register_objective_location( "keep_east_nest", ( 3033, 1795, 1782 ), ( 0, 331, 0 ) );
            register_objective_location( "winery_nest", ( 6845, 79, 1703 ), ( 0, 195, 0 ) );
            register_objective_location( "lighthouse_nest", ( 6560, -5507, 1119 ), ( 0, 31, 0 ) );
            register_objective_location( "radio_nest", ( 3252, -4398, 1215 ), ( 0, 105, 0 ) );
            var0 = [ "winery2", "radio", "lighthouse", "winery", "grotto", "camp", "library", "graveyard", "terraces", "church", "fort", "airstrip" ];
            assign_objective_type_locations( "domination", var0 );
            assign_objective_type_locations( "sweep_and_clear", var0 );
            var0 = [ "clocktower_nest", "keep_west_nest", "keep_east_nest", "winery_nest", "lighthouse_nest", "radio_nest" ];
            assign_objective_type_locations( "overwatch", var0 );
            var0 = [ "airstrip", "clocktower_nest", "keep_west_nest", "keep_east_nest", "winery_nest", "lighthouse_nest", "radio_nest" ];
            assign_objective_type_locations( "assassination", var0 );
            break;
    }
}

// Params 0
// Size: 0x2b
function init_raid_variables()
{
    var0 = getdvar( "multisquad_pve_instance", "test" );
    
    switch ( var0 )
    {
        case "test":
            init_test_raid();
            break;
    }
}

// Params 0
// Size: 0x1b
function raid_watch_for_start()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    thread raid_start();
}

// Params 0
// Size: 0x2f
function raid_start()
{
    thread raid_watch_for_next_phase();
    thread raid_watch_for_raid_complete();
    thread raid_watch_for_raid_failed();
    level waittill( "infils_ready" );
    [[ level.yÎ®b9›3HxG´.±c	³sCpóßã[ 0 ] ]]();
}

// Params 0
// Size: 0x4b
function raid_watch_for_next_phase()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        level waittill( "raid_phase_complete" );
        
        if ( level.yÎ®b9›3HxG´.––ÈÿãÓS7PeK‘[ + 1 >= level.yÎ®b9›3HxG´.±c	³sCpóßã.size )
        {
            level notify( "raid_complete" );
            break;
        }
        
        thread raid_start_next_phase();
    }
}

// Params 1
// Size: 0x42
function raid_start_next_phase( var0 )
{
    if ( isdefined( var0 ) )
    {
        level.yÎ®b9›3HxG´.––ÈÿãÓS7PeK‘[ = var0;
    }
    else
    {
        level.yÎ®b9›3HxG´.––ÈÿãÓS7PeK‘[++;
    }
    
    [[ level.yÎ®b9›3HxG´.±c	³sCpóßã[ level.yÎ®b9›3HxG´.––ÈÿãÓS7PeK‘[ ] ]]();
}

// Params 0
// Size: 0x2a
function raid_watch_for_raid_complete()
{
    level endon( "raid_failed" );
    level waittill( "raid_complete" );
    level thread scripts\mp\gametypes\br::brendgame( "allies", game[ "end_reason" ][ "objective_complete" ] );
}

// Params 0
// Size: 0x31
function raid_watch_for_raid_failed()
{
    level endon( "raid_complete" );
    GscBinSkip4( 0x6e, level );
    // Unknown operator ( 0x6e, iw8, PC )
}

// Params 0
// Size: 0x51
function raid_watch_for_wipe()
{
    for ( ;; )
    {
        var0 = 1;
        
        foreach ( var2 in level.players )
        {
            if ( isalive( var2 ) )
            {
                var0 = 0;
            }
        }
        
        if ( var0 )
        {
            level notify( "raid_failed" );
            break;
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x2
function ___test()
{
    
}

// Params 0
// Size: 0x63
function init_test_raid()
{
    scripts\mp\agents\agent_encounter_manager::register_agent_class( "rifle_guy", "actor_enemy_lw_br", 0, undefined, 1 );
    scripts\mp\agents\agent_encounter_manager::register_agent_class( "heavy_rifle_guy", "actor_enemy_lw_br", 1, undefined, 1 );
    level.yÎ®b9›3HxG´.±c	³sCpóßã[ 0 ] = &test_raid_phase_0;
    level.yÎ®b9›3HxG´.±c	³sCpóßã[ 1 ] = &test_raid_phase_1;
    level.yÎ®b9›3HxG´.±c	³sCpóßã[ 2 ] = &test_raid_phase_2;
}

// Params 0
// Size: 0xf0
function test_raid_phase_0()
{
    var0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius( 0, 1100 );
    var1 = scripts\mp\agents\agent_encounter_manager::init_encounter_params_swarm( 12, undefined, "rifle_guy", var0 );
    start_objectives( "domination", 1, var1 );
    var0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius( 0, 1100 );
    var2 = [];
    GscBinSkip0( 0x2e, 0, scripts\mp\agents\agent_encounter_manager::make_wave( 12, 6, "rifle_guy", var0 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x103
function test_raid_phase_1()
{
    var0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius( 0, 1400 );
    var1 = scripts\mp\agents\agent_encounter_manager::init_encounter_params_swarm( 18, undefined, "heavy_rifle_guy", var0 );
    start_objectives( "domination", 1, var1 );
    
    while ( get_objectives_active().size > 1 )
    {
        wait 1;
    }
    
    wait 3;
    start_objectives( "domination", 1, var1 );
    var2 = get_objectives_active()[ scripts\engine\utility::cointoss() ];
    
    if ( !isdefined( var2 ) )
    {
        var2 = get_objectives_active()[ 0 ];
    }
    
    wait 3;
    var2.9Á‡²ÆxMmÙ¥s scripts\mp\agents\agent_encounter_manager::inrease_ai_budget_by( 12 );
    var3 = undefined;
    
    switch ( var2.9Á‡²ÆxMmÙ¥s.id )
    {
        case 0:
            var3 = "A";
            break;
        case 1:
            var3 = "B";
            break;
        case 2:
            var3 = "C";
            break;
        case 3:
            var3 = "D";
            break;
        case 4:
            var3 = "E";
            break;
    }
    
    while ( get_objectives_active().size > 0 )
    {
        wait 1;
    }
    
    wait 3;
    level notify( "raid_phase_complete" );
}

// Params 0
// Size: 0x54
function test_raid_phase_2()
{
    reset_objective_index();
    var0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius( 0, 2900 );
    var1 = scripts\mp\agents\agent_encounter_manager::init_encounter_params_swarm( 48, undefined, "rifle_guy", var0 );
    start_objectives( "domination", 1, var1 );
    set_as_final_objective( get_objectives_active()[ 0 ] );
    
    while ( get_objectives_active().size > 0 )
    {
        wait 1;
    }
    
    level notify( "raid_phase_complete" );
}

// Params 0
// Size: 0x2
function ___objectives()
{
    
}

// Params 3
// Size: 0x43
function register_objective_location( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.id = var0;
    var3.origin = var1;
    var3.angles = var2;
    level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘ = scripts\engine\utility::array_add( level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘, var3 );
}

// Params 2
// Size: 0x32
function assign_objective_type_locations( var0, var1 )
{
    level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­·[ var0 ] = var1;
    level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà[ var0 ] = [];
    level.yÎ®b9›3HxG´.«ÃÂõ½šYÆ:´ÎÊÍ×6{Ö86¬Ê‘[ var0 ] = [];
}

// Params 3
// Size: 0x20
function start_objectives( var0, var1, var2 )
{
    for ( var3 = 0; var3 < var1 ; var3++ )
    {
        start_objective( var0, var2 );
        wait 3;
    }
}

// Params 2
// Size: 0x106
function start_objective( var0, var1 )
{
    var2 = randomint( level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­·[ var0 ].size );
    var3 = level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­·[ var0 ][ var2 ];
    var4 = undefined;
    
    foreach ( var6 in level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘ )
    {
        if ( var6.id == var3 )
        {
            var4 = var6;
            break;
        }
    }
    
    var8 = objective_init( var0, var4 );
    mark_objective_active( var8 );
    
    switch ( var0 )
    {
        case "domination":
            objective_icon_init( "DOM_CAPTURE" );
            start_objective_domination( var8, var1 );
            break;
        case "overwatch":
            objective_icon_init( "OVERWATCH" );
            start_objective_overwatch( var8, var1 );
            break;
        case "sweep_and_clear":
            objective_icon_init( "SWEEP_AND_CLEAR" );
            start_objective_sweep_and_clear( var8, var1 );
            break;
        case "assassination":
            objective_icon_init( "ASSASSINATE" );
            start_objective_assassination( var8, var1 );
            break;
    }
}

// Params 2
// Size: 0xa8
function objective_init( var0, var1 )
{
    var2 = spawnstruct();
    var2.type = var0;
    var2.origin = scripts\engine\utility::ter_op( isdefined( var1.origin ), var1.origin, ( 0, 0, 0 ) );
    var2.angles = scripts\engine\utility::ter_op( isdefined( var1.angles ), var1.angles, ( 0, 0, 0 ) );
    var2.radius = 350;
    var2.height = 100;
    var2.¬åÂó›8±ûïr = 4.5;
    var2.±ŞÑ-ös×´# = var1.id;
    var2.¥Í>hrÛÏ§*%¸Ääq = 0;
    objective_icon_init( var0 );
    return var2;
}

// Params 1
// Size: 0xbb
function objective_icon_init( var0 )
{
    var1 = undefined;
    var2 = undefined;
    
    switch ( level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( )
    {
        case 0:
            var1 = "waypoint_captureneutral_br_a";
            var2 = "icon_waypoint_dom_a";
            break;
        case 1:
            var1 = "waypoint_captureneutral_br_b";
            var2 = "icon_waypoint_dom_b";
            break;
        case 2:
            var1 = "waypoint_captureneutral_br_c";
            var2 = "icon_waypoint_dom_c";
            break;
        case 3:
            var1 = "waypoint_captureneutral_br_d";
            var2 = "icon_waypoint_dom_d";
            break;
        case 4:
            var1 = "waypoint_captureneutral_br_e";
            var2 = "icon_waypoint_dom_e";
            break;
    }
    
    setdomflagiconinfo( var1, "neutral", "MP_BR_INGAME/" + var0, var2, 0 );
    scripts\mp\gametypes\br_dom_quest::ref_13239();
    thread ref_13bb1();
}

// Params 1
// Size: 0x121
function mark_objective_active( var0 )
{
    foreach ( var2 in level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­· )
    {
        foreach ( var4 in var2 )
        {
            if ( var4 == var0.±ŞÑ-ös×´# )
            {
                level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­·[ var0.type ] = scripts\engine\utility::array_remove( level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­·[ var0.type ], var4 );
                break;
            }
        }
    }
    
    foreach ( var8 in level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘ )
    {
        if ( var8.id == var0.±ŞÑ-ös×´# )
        {
            level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘ = scripts\engine\utility::array_remove( level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘, var8 );
            break;
        }
    }
    
    level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà[ var0.type ] = scripts\engine\utility::array_add( level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà[ var0.type ], var0 );
}

// Params 1
// Size: 0x76
function mark_objective_complete( var0 )
{
    if ( isdefined( var0.9Á‡²ÆxMmÙ¥s ) )
    {
        var0.9Á‡²ÆxMmÙ¥s scripts\mp\agents\agent_encounter_manager::end_encounter();
    }
    
    level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà[ var0.type ] = scripts\engine\utility::array_remove( level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà[ var0.type ], var0 );
    level.yÎ®b9›3HxG´.«ÃÂõ½šYÆ:´ÎÊÍ×6{Ö86¬Ê‘[ var0.type ] = scripts\engine\utility::array_add( level.yÎ®b9›3HxG´.«ÃÂõ½šYÆ:´ÎÊÍ×6{Ö86¬Ê‘[ var0.type ], var0 );
}

// Params 2
// Size: 0x85
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
            continue;
        }
        
        if ( !isdefined( var4 ) )
        {
            var4 = spawnstruct();
        }
        
        var4.intvar = var1;
        var4.ref_136f3 = var0;
        thread ref_12981( var3 );
    }
}

// Params 1
// Size: 0xad
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
    
    while ( isdefined( self ) && isdefined( self.isflagcarrymode ) && self.isflagcarrymode.size > 0 )
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
// Size: 0xf
function reset_objective_index()
{
    level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( = 0;
}

// Params 1
// Size: 0x25
function get_objective_locations_unused( var0 )
{
    if ( isdefined( var0 ) )
    {
        return level.yÎ®b9›3HxG´.‚€!ù·6P§›;–1‰’¹âßx ñd­·[ var0 ];
    }
    
    return level.yÎ®b9›3HxG´.±šØ¯¿’f;Ê/çPèŸGØç‹ˆR"‘;
}

// Params 1
// Size: 0x2a
function get_objectives_active( var0 )
{
    if ( isdefined( var0 ) )
    {
        return level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà[ var0 ];
    }
    
    return get_objectives_all( level.yÎ®b9›3HxG´.±AŸX¾ƒY{Òƒå¯¹pOìÁUà );
}

// Params 1
// Size: 0x2a
function get_objectives_completed( var0 )
{
    if ( isdefined( var0 ) )
    {
        return level.yÎ®b9›3HxG´.«ÃÂõ½šYÆ:´ÎÊÍ×6{Ö86¬Ê‘[ var0 ];
    }
    
    return get_objectives_all( level.yÎ®b9›3HxG´.«ÃÂõ½šYÆ:´ÎÊÍ×6{Ö86¬Ê‘ );
}

// Params 1
// Size: 0x33
function get_objectives_all( var0 )
{
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        var1 = scripts\engine\utility::array_combine( var1, var3 );
    }
    
    return var1;
}

// Params 0
// Size: 0x9
function set_as_final_objective()
{
    self.¥Í>hrÛÏ§*%¸Ääq = 1;
}

// Params 0
// Size: 0x2
function ___domination()
{
    
}

// Params 2
// Size: 0x235
function start_objective_domination( var0, var1 )
{
    var2 = [ "_a", "_b", "_c", "_d", "_e" ];
    var3 = var0.origin - ( 0, 0, var0.height / 3 );
    var4 = spawn( "trigger_radius", var3, 0, var0.radius, var0.height );
    var4.¬z8!½2†mûÛjv›Ğ( = level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ(;
    var4.script_label = var2[ level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( ];
    var4.iconname = var2[ level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( ];
    level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ(++;
    var5 = scripts\mp\gametypes\obj_dom::setupobjective( var4, "neutral" );
    var5.onuse = &ref_122b2;
    var5.onbeginuse = &ref_122a8;
    var5.onuseupdate = &ref_122b3;
    var5.onenduse = &ref_122aa;
    var5.oncontested = &ref_122a9;
    var5.onuncontested = &ref_122af;
    var5.onunoccupied = &ref_122b0;
    var5.onpinnedstate = &ref_122ad;
    var5.onunpinnedstate = &ref_122b1;
    var5.ref_138b2 = &ref_122ae;
    var5.stompprogressreward = &ref_122b8;
    var5.id = "domFlag";
    var5.pinobj = 1;
    var5.lockupdatingicons = 1;
    var5.trigger = var4;
    var5.get_current_bush_zone = 0;
    var5.get_current_building_obj_struct = var0.radius;
    var5.pos = var0.origin;
    var5 scripts\mp\gameobjects::setcapturebehavior( "persistent" );
    var5 scripts\mp\gameobjects::setusetime( var0.¬åÂó›8±ûïr );
    playencryptedcinematicforall( var5.objidnum, 1 );
    var5.ª°_¨>ZZ÷ = spawnstruct();
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 8, 0, 0, var0.origin );
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::ref_1316f( var0.radius );
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::ref_13369();
    var5 scripts\mp\objidpoolmanager::objective_teammask_addtomask( var5.objidnum, level.players[ 0 ].team );
    thread ref_122b9();
    thread ref_122ba();
    var5.objective = var0;
    var0.9Á‡²ÆxMmÙ¥s = scripts\mp\agents\agent_encounter_manager::start_encounter( var0.origin, var1 );
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

// Params 1
// Size: 0x1e
function ref_122ab( var0 )
{
    self.ref_1265b = scripts\engine\utility::array_add( self.ref_1265b, var0 );
    var0.truck_03_node = 1;
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

// Params 1
// Size: 0x1d
function ref_122ac( var0 )
{
    self.ref_1265b = scripts\engine\utility::array_remove( self.ref_1265b, var0 );
    var0.truck_03_node = 0;
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
// Size: 0x61
function ref_122a8( var0 )
{
    self.userate = 1;
    
    if ( !isdefined( self.ref_11f63 ) || !self.ref_11f63 )
    {
        self.ref_11f63 = 1;
        var1 = scripts\mp\utility\teams::getfriendlyplayers( var0.team, 0 );
        
        foreach ( var3 in var1 )
        {
            var3 notify( "calloutmarkerping_warzoneKillQuestIcon" );
        }
        
        return;
    }
}

// Params 4
// Size: 0x56
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
        return;
    }
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
    self.userate = level.endgametutorial_func.manualturret_watchturretusetimeout;
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
// Size: 0xa8
function ref_122a2( var0 )
{
    mark_objective_complete( self.objective );
    
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) )
        {
            if ( !self.objective.¥Í>hrÛÏ§*%¸Ääq )
            {
                var2 thread scripts\mp\hud_message::showsplash( "br_rumble_pe_dom_flag_captured_ally" );
            }
        }
    }
    
    foreach ( var5 in self.touchlist[ var0 ] )
    {
        var2 = var5.player;
        var2 thread scripts\mp\rank::giverankxp( "rumble_dom_flag_capture", 250, var2 getcurrentprimaryweapon() );
        var2 thread scripts\mp\rank::scoreeventpopup( "rumble_dom_flag_capture" );
    }
    
    thread ref_122a3( self );
}

// Params 0
// Size: 0x67
function ref_122b4()
{
    switch ( level.yÎ®b9›3HxG´.«ÃÂõ½šYÆ:´ÎÊÍ×6{Ö86¬Ê‘[ "domination" ].size )
    {
        case 1:
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_friendly_capture_1", self );
            break;
        case 2:
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_friendly_capture_2", self );
            break;
        case 3:
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "dom_point_friendly_capture_all", self );
            break;
    }
}

// Params 1
// Size: 0x18
function ref_122a3( var0 )
{
    var0.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::lastdirtyscore();
    scripts\mp\gametypes\obj_dom::removeobjective( var0 );
}

// Params 1
// Size: 0x97
function subwave_progression( var0 )
{
    setdomflagiconinfo( "waypoint_captureneutral_br_a", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0 );
    setdomflagiconinfo( "waypoint_captureneutral_br_b", "neutral", "MP_BR_INGAME/SWEEP_AND_CLEAR", "icon_waypoint_dom_b", 0 );
    setdomflagiconinfo( "waypoint_captureneutral_br_c", "neutral", "MP_BR_INGAME/ASSASSINATE", "icon_waypoint_dom_c", 0 );
    setdomflagiconinfo( "waypoint_captureneutral_br_d", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0 );
    setdomflagiconinfo( "waypoint_captureneutral_br_e", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0 );
    scripts\mp\gametypes\br_dom_quest::ref_13239();
    thread ref_13bb1();
}

// Params 5
// Size: 0x35
function setdomflagiconinfo( var0, var1, var2, var3, var4 )
{
    level.waypointcolors[ var0 ] = var1;
    level.waypointbgtype[ var0 ] = 0;
    level.waypointstring[ var0 ] = var2;
    level.waypointshader[ var0 ] = var3;
    level.waypointpulses[ var0 ] = var4;
}

// Params 0
// Size: 0x10
function ref_13bb1()
{
    level waittill( "br_dialog_initialized" );
    level.disableinitplayergameobjects = 0;
}

// Params 0
// Size: 0x2
function ___overwatch()
{
    
}

// Params 2
// Size: 0x234
function start_objective_overwatch( var0, var1 )
{
    var2 = [ "_a", "_b", "_c", "_d", "_e" ];
    var3 = var0.origin - ( 0, 0, var0.height / 3 );
    var4 = spawn( "trigger_radius", var3, 0, var0.radius, var0.height );
    var4.¬z8!½2†mûÛjv›Ğ( = level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ(;
    var4.script_label = var2[ level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( ];
    var4.iconname = var2[ level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( ];
    level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ(++;
    var5 = scripts\mp\gametypes\obj_dom::setupobjective( var4, "neutral" );
    var5.onuse = &ref_122b2;
    var5.onbeginuse = &ref_122a8;
    var5.onuseupdate = &ref_122b3;
    var5.onenduse = &ref_122aa;
    var5.oncontested = &ref_122a9;
    var5.onuncontested = &ref_122af;
    var5.onunoccupied = &ref_122b0;
    var5.onpinnedstate = &ref_122ad;
    var5.onunpinnedstate = &ref_122b1;
    var5.ref_138b2 = &ref_122ae;
    var5.stompprogressreward = &ref_122b8;
    var5.id = "domFlag";
    var5.pinobj = 0;
    var5.lockupdatingicons = 1;
    var5.trigger = var4;
    var5.get_current_bush_zone = 0;
    var5.get_current_building_obj_struct = var0.radius;
    var5.pos = var0.origin;
    var5 scripts\mp\gameobjects::setcapturebehavior( "persistent" );
    var5 scripts\mp\gameobjects::setusetime( var0.¬åÂó›8±ûïr );
    playencryptedcinematicforall( var5.objidnum, 1 );
    var5.ª°_¨>ZZ÷ = spawnstruct();
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 8, 0, 0, var0.origin );
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::ref_1316f( var0.radius );
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::ref_13369();
    var5 scripts\mp\objidpoolmanager::objective_teammask_addtomask( var5.objidnum, level.players[ 0 ].team );
    thread ref_122b9();
    thread ref_122ba();
    var5.objective = var0;
    var0.9Á‡²ÆxMmÙ¥s = scripts\mp\agents\agent_encounter_manager::start_encounter( var0.origin, var1 );
}

// Params 0
// Size: 0x2
function ___sweep_and_clear()
{
    
}

// Params 2
// Size: 0x188
function start_objective_sweep_and_clear( var0, var1 )
{
    var2 = [ "_a", "_b", "_c", "_d", "_e" ];
    var3 = var0.origin - ( 0, 0, var0.height / 3 );
    var4 = spawn( "trigger_radius", var3, 0, 1, 1 );
    var4.¬z8!½2†mûÛjv›Ğ( = level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ(;
    var4.script_label = var2[ level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( ];
    var4.iconname = var2[ level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( ];
    level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ(++;
    var0.radius = int( 1.1 * var1.ŠLİgYn[ 0 ].†‹¸ãAóÅá·Æ®:.– %Ïqqú¡°?w0 );
    var5 = scripts\mp\gametypes\obj_dom::setupobjective( var4, "neutral" );
    var5.id = "domFlag";
    var5.pinobj = 0;
    var5.lockupdatingicons = 1;
    var5.get_current_bush_zone = 1;
    var5.get_current_building_obj_struct = var0.radius;
    var5.pos = var0.origin;
    playencryptedcinematicforall( var5.objidnum, 1 );
    var5.ª°_¨>ZZ÷ = spawnstruct();
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 8, 0, 0, var0.origin );
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::ref_1316f( var0.radius );
    var5.ª°_¨>ZZ÷ scripts\mp\gametypes\br_quest_util::ref_13369();
    var5.objective = var0;
    thread sweep_and_clear_think();
    var0.9Á‡²ÆxMmÙ¥s = scripts\mp\agents\agent_encounter_manager::start_encounter( var0.origin, var1 );
}

// Params 0
// Size: 0x56
function sweep_and_clear_think()
{
    while ( !isdefined( self.objective.9Á‡²ÆxMmÙ¥s ) )
    {
        wait 0.05;
    }
    
    for ( ;; )
    {
        self.objective.9Á‡²ÆxMmÙ¥s waittill( "agent_death" );
        
        if ( self.objective.9Á‡²ÆxMmÙ¥s.agents.size == 0 )
        {
            break;
        }
    }
    
    thread ref_122a2( "allies" );
}

// Params 0
// Size: 0x2
function ___assassination()
{
    
}

// Params 2
// Size: 0x2e
function start_objective_assassination( var0, var1 )
{
    level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ(++;
    thread assassination_think();
    var0.9Á‡²ÆxMmÙ¥s = scripts\mp\agents\agent_encounter_manager::start_encounter( var0.origin, var1 );
}

// Params 0
// Size: 0x94
function assassination_think()
{
    while ( !isdefined( self.9Á‡²ÆxMmÙ¥s ) || self.9Á‡²ÆxMmÙ¥s.agents.size <= 0 )
    {
        wait 0.05;
    }
    
    var0 = self.9Á‡²ÆxMmÙ¥s.agents[ 0 ];
    assassination_quest_circle_setup( var0, 6000, 1000, 3 );
    thread assassination_target_distance_watcher();
    var0 waittill( "death" );
    self notify( "target_found" );
    scripts\mp\objidpoolmanager::returnreservedobjectiveid( self.ref_11f64 );
    self notify( "stop_circle_anim" );
    
    if ( isdefined( self.mapcircle ) )
    {
        scripts\mp\gametypes\br_quest_util::lastdirtyscore();
    }
    
    if ( isdefined( self.“ù{˜©ë¥lÛ7ë¶Şì¬N ) )
    {
        self.“ù{˜©ë¥lÛ7ë¶Şì¬N delete();
    }
    
    mark_objective_complete( self );
}

// Params 4
// Size: 0x1fd
function assassination_quest_circle_setup( var0, var1, var2, var3 )
{
    self.target = var0;
    var4 = var0.origin;
    self.­+[m5á—óÍ¿úõ©÷±ãÇÄ = scripts\engine\math::random_vector_2d() * randomfloatrange( 0, var1 * 0.9 );
    var5 = var4 + self.­+[m5á—óÍ¿úõ©÷±ãÇÄ;
    var6 = ( var5[ 0 ], var5[ 1 ], var1 );
    scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 8, 0, 0, var6 );
    scripts\mp\gametypes\br_quest_util::ref_13369();
    self.“=
z‘¯<«1a5; = [];
    var7 = var6 - var4;
    var8 = var2 / var1;
    var9 = var4 + var7 * var8;
    var9 = ( var9[ 0 ], var9[ 1 ], var2 );
    var10 = 1 / var3;
    
    for ( var11 = 0; var11 <= var3 ; var11++ )
    {
        self.“=
z‘¯<«1a5;[ var11 ] = vectorlerp( var6, var9, var10 * var11 );
    }
    
    self.ºá-õØZ'cV¾Íè¬8 = 0;
    self.›JïH}pàQ¦SÎ×‹% = self.“=
z‘¯<«1a5;[ 1 ];
    self.„ë‚ş €—SQ¥PM÷Àñ«#k>Ğ = squared( self.›JïH}pàQ¦SÎ×‹%[ 2 ] );
    var12 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( var12 > -1 )
    {
        self.“ù{˜©ë¥lÛ7ë¶Şì¬N = spawn( "script_model", var5 );
        objective_onentity( var12, self.“ù{˜©ë¥lÛ7ë¶Şì¬N );
        objective_state( var12, "current" );
        thread assasination_icon_hide_after_intro( var12 );
        objective_setplayintro( var12, 1 );
        objective_setshowoncompass( var12, 1 );
        objective_setshowdistance( var12, 0 );
        playencryptedcinematicforall( var12, 1 );
        getscriptcachecontents( var12, 0.5, 0.7 );
        var13 = level.yÎ®b9›3HxG´.¬z8!½2†mûÛjv›Ğ( - 1;
        self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ = undefined;
        
        switch ( var13 )
        {
            case 0:
                self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ = "icon_waypoint_dom_a";
                break;
            case 1:
                self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ = "icon_waypoint_dom_b";
                break;
            case 2:
                self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ = "icon_waypoint_dom_c";
                break;
            case 3:
                self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ = "icon_waypoint_dom_d";
                break;
            case 4:
                self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ = "icon_waypoint_dom_e";
                break;
        }
        
        objective_icon( var12, self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ );
        objective_setbackground( var12, 0 );
        objective_setlabel( var12, "MB_BR_INGAME/ASSASSINATE" );
        objective_setneutrallabel( var12, "MB_BR_INGAME/ASSASSINATE" );
        objective_setfriendlylabel( var12, "MB_BR_INGAME/ASSASSINATE" );
        objective_setenemylabel( var12, "MB_BR_INGAME/ASSASSINATE" );
        objective_setzoffset( var12, 100 );
        function_0442( var12, 1 );
        self.ref_11f64 = var12;
        return;
    }
}

// Params 1
// Size: 0x1b
function assasination_icon_hide_after_intro( var0 )
{
    level endon( "game_ended" );
    wait 2;
    objective_state( var0, "active" );
}

// Params 0
// Size: 0x66
function assassination_quest_circle_tick()
{
    self.ºá-õØZ'cV¾Íè¬8++;
    
    if ( self.ºá-õØZ'cV¾Íè¬8 + 1 < self.“=
z‘¯<«1a5;.size )
    {
        thread assassination_quest_circle_animate( self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 - 1 ], self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 ], 2 );
        self.›JïH}pàQ¦SÎ×‹% = self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 + 1 ];
        self.„ë‚ş €—SQ¥PM÷Àñ«#k>Ğ = squared( self.›JïH}pàQ¦SÎ×‹%[ 2 ] );
        return;
    }
    
    assassination_show_target();
}

// Params 4
// Size: 0x98
function assassination_quest_circle_animate( var0, var1, var2, var3 )
{
    self notify( "stop_circle_anim" );
    level endon( "game_ended" );
    self endon( "stop_circle_anim" );
    var4 = var2 * 1000;
    var5 = gettime() + var4;
    var6 = 0;
    self.“ù{˜©ë¥lÛ7ë¶Şì¬N moveto( ( var1[ 0 ], var1[ 1 ], self.target.origin[ 2 ] ), var2 );
    
    while ( var6 < 1 )
    {
        var6 = 1 - ( var5 - gettime() ) / var4;
        var7 = vectorlerp( var0, var1, var6 );
        var8 = var7;
        
        if ( istrue( var3 ) )
        {
            var8 = ( var7[ 0 ], var7[ 1 ], scripts\engine\math::lerp( var0[ 2 ], 0, var6 ) );
        }
        
        scripts\mp\gametypes\br_quest_util::ref_11dae( var8 );
        waitframe();
    }
}

// Params 0
// Size: 0xba
function assassination_show_target()
{
    thread assassination_quest_circle_animate( self.“=
z‘¯<«1a5;[ self.ºá-õØZ'cV¾Íè¬8 - 1 ], self.target.origin, 2, 1 );
    objective_state( self.ref_11f64, "current" );
    objective_setshowoncompass( self.ref_11f64, 0 );
    playencryptedcinematicforall( self.ref_11f64, 0 );
    function_0442( self.ref_11f64, 0 );
    objective_setshowdistance( self.ref_11f64, 1 );
    objective_icon( self.ref_11f64, self.–i³Ã’PÊ[3ÇÛ‚$+g˜é/ğ );
    objective_setbackground( self.ref_11f64, 0 );
    objective_setlabel( self.ref_11f64, "MB_BR_INGAME/ASSASSINATE" );
    objective_setneutrallabel( self.ref_11f64, "MB_BR_INGAME/ASSASSINATE" );
    objective_setfriendlylabel( self.ref_11f64, "MB_BR_INGAME/ASSASSINATE" );
    objective_setenemylabel( self.ref_11f64, "MB_BR_INGAME/ASSASSINATE" );
    objective_onentity( self.ref_11f64, self.target );
}

// Params 0
// Size: 0xe7
function assassination_target_distance_watcher()
{
    level endon( "game_ended" );
    self endon( "target_found" );
    var0 = level.players;
    var1 = squared( 1000 );
    var2 = squared( 10000 );
    
    for ( ;; )
    {
        foreach ( var4 in var0 )
        {
            if ( !isdefined( var4 ) || !isalive( var4 ) )
            {
                continue;
            }
            
            var5 = distancesquared( var4.origin, self.target.origin );
            
            if ( var5 < var1 )
            {
                assassination_show_target();
                self notify( "target_found" );
            }
        }
        
        var7 = var2;
        
        foreach ( var4 in var0 )
        {
            var7 = min( distance2dsquared( var4.origin, self.›JïH}pàQ¦SÎ×‹% ), var7 );
        }
        
        if ( var7 < self.„ë‚ş €—SQ¥PM÷Àñ«#k>Ğ )
        {
            assassination_quest_circle_tick();
        }
        
        wait 1;
    }
}

