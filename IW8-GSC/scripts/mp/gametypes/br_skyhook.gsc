
// Params 0
// Size: 0x6c
function init()
{
    if ( !getdvarint( "scr_skyhooks_enabled", 0 ) )
    {
        return;
    }
    
    isplatepouch();
    initanimtree();
    tr_vis_radius_override_lod2();
    scripts\cp_mp\utility\script_utility::registersharedfunc( "skyhook", "precision_airstrike_damage", &ref_1284a );
    scripts\engine\scriptable::ref_12f5b( "skyhook", &ref_13409 );
    scripts\engine\scriptable::ref_12f5b( "skyhook_interact", &skyhookplacedscriptableused );
    scripts\engine\scriptable::ref_12f5a( &scriptable_skyhook_placed_damaged );
    scripts\mp\utility\sound::besttime( "equip_skyhook" );
    thread ref_13406();
}

// Params 0
// Size: 0x2ab
function tr_vis_radius_override_lod2()
{
    level.ref_13400 = spawnstruct();
    level.ref_13400.chopper_boss_destroyed_func = getdvarint( "scr_skyhooks_enabled", 0 );
    level.ref_13400.card_angles = getdvarint( "scr_skyhook_ascent_height", 3500 );
    level.ref_13400.cardstruct = getdvarint( "scr_skyhook_ascent_time", 2.8 );
    level.ref_13400.card_origin = getdvarint( "scr_skyhook_ascent_speed", 1500 );
    level.ref_13400.car_think = getdvarfloat( "scr_skyhook_ascent_acceleration", 1 );
    level.ref_13400.watch_rpg_use = getdvarfloat( "scr_skyhook_launch_forward_scalar", 2000 );
    level.ref_13400.watchbombuseinternal = getdvarfloat( "scr_skyhook_launch_z_scalar", 1500 );
    level.ref_13400.watchbombuse = getdvarfloat( "scr_skyhook_launch_time", 1 );
    level.ref_13400.playerhumanprestream = getdvarint( "scr_skyhook_force_parachute", 1 );
    level.ref_13400.bullets_can_damage = getdvarint( "scr_skyhook_bullets_damage_balloon", 1 );
    level.ref_13400.chopperexfil_sh060_start = getdvarint( "scr_skyhook_balloon_health", 2000 );
    level.ref_13400.ref_12c2d = getdvarint( "scr_skyhook_repair_cost", 5 );
    level.ref_13400.open_door_to_next_objective = getdvarfloat( "scr_skyhook_balloon_explosives_multiplier", 4 );
    level.ref_13400.arenaflag_previewflag = getdvarfloat( "scr_skyhook_balloon_aa_turret_multiplier", 6 );
    level.ref_13400.ref_12928 = getdvarfloat( "scr_skyhook_balloon_spawn_protection_duration", 0 );
    level.ref_13400.ref_12929 = getdvarfloat( "scr_skyhook_balloon_spawn_protection_scalar", 0.5 );
    level.ref_13400.iskillstreakvehicleinflictor = loadfx( "vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_explosion" );
    level.ref_13400.ref_12c32 = loadfx( "vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_repair" );
    level.ref_13400.cantakedamage = loadfx( "vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_scrnfx" );
    level.ref_13400.ref_12c33 = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_barrier_construct_base" );
    level.ref_13400.ref_12c34 = loadfx( "vfx/iw8_br/gameplay/vfx_br_cash_fulton_fillup" );
    level.ref_13400.–‚ãBÍ˜Yñ3Ç``ë? = getdvarint( "scr_parachute_overhead_warning_radius", 2000 );
    level.ref_13400.¬…Ø›¶J=T9ìMÛbH£ = getdvarint( "scr_parachute_overhead_warning_height", 3000 );
    level.ref_13400.¢Î»°9¹Z›võKÖYÛW:¾kÜ = getdvarint( "scr_parachute_overhead_warning_timeout_ms", 45000 );
    level.ref_13400.ref_1284a = getdvarint( "scr_skyhook_precision_airstrike_damage", 200 );
    level.ref_13400.º°ÉÀı˜Å÷±ˆx = getdvarint( "scr_skyhook_thermite_dps", 100 );
    level.ref_13400.aq_ontimerexpired = reader();
    level.ref_13400.areas_remaining = [];
    level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X = getentitylessscriptablearrayinradius( "scriptable_scriptable_skyhook_placed", "classname" );
    level.ref_13400.­¥K¾¹[—†íŞµ×²›ÑÜ}ÚÂá = getdvarfloat( "scr_skyhook_ents_max", -1 );
    setdvarifuninitialized( "scr_ascender_disable_concurrent_use", 0 );
}

// Params 0
// Size: 0x1e6
function reader()
{
    var0 = [];
    
    if ( isdefined( level.ref_12178 ) )
    {
        foreach ( var3, var2 in level.ref_12178 )
        {
            var0 = var2;
        }
        
        return var0;
    }
    
    switch ( getdvar( "mapname" ) )
    {
        case "mp_wz_island":
            break;
        case "mp_hmsisle_test":
            GscBinSkip0( 0x2e, var3.size, [ ( 770, -527, 502 ), ( 0, 0, 0 ) ] );
            // Unknown operator ( 0x2e, iw8, PC )
        case "mp_sm_island_1":
            break;
        case "mp_br_hms_ltm":
            GscBinSkip0( 0x2e, var3.size, [ ( 0, -1870, -2 ), ( 0, 45, 0 ) ] );
            // Unknown operator ( 0x2e, iw8, PC )
        case "mp_br_mechanics":
            GscBinSkip0( 0x2e, var3.size, [ ( 288, -2209, -2 ), ( 0, 0, 0 ) ] );
            // Unknown operator ( 0x2e, iw8, PC )
        case "mp_escape4_s5":
        case "mp_escape4":
            GscBinSkip0( 0x2e, var3.size, [ ( -6062.5, -329, 83 ), ( 0, 17, 0 ) ] );
            // Unknown operator ( 0x2e, iw8, PC )
    }
    
    return var3;
}

// Params 0
// Size: 0x95
function ref_13406()
{
    waitframe();
    ref_135d3();
    
    if ( !getdvarint( "scr_skyhooks_enabled_placed_disabled", 0 ) )
    {
        spawn_skyhooks_placed();
    }
    
    while ( !isdefined( level.matchcountdowntime ) && !scripts\mp\flags::gameflag( "prematch_fade_done" ) )
    {
        wait 1;
    }
    
    level.ref_13400.choosejuggernautcratemodel = 1;
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    level.ref_13400.choosejuggernautcratemodel = undefined;
    level notify( "respawn_skyhooks" );
    
    if ( getdvarint( "scr_skyhook_balloon_start_destroyed", 0 ) == 1 )
    {
        ref_12c94();
        respawn_skyhooks_destroyed_placed();
        return;
    }
    
    ref_12c93();
    
    if ( !getdvarint( "scr_skyhooks_enabled_placed_disabled", 0 ) )
    {
        respawn_skyhooks_placed();
        return;
    }
}

// Params 0
// Size: 0x204
function ref_135d3()
{
    if ( !level.ref_13400.aq_ontimerexpired.size )
    {
        return;
    }
    
    level.ref_13400.aq_ontimerexpired = scripts\engine\utility::array_randomize( level.ref_13400.aq_ontimerexpired );
    var0 = 0;
    
    if ( getdvarint( "scr_skyhook_randomize_spawns", 0 ) )
    {
        var0 = randomintrange( 1, level.ref_13400.aq_ontimerexpired.size + 1 );
    }
    else if ( getdvarfloat( "scr_skyhook_spawn_percentage", 1 ) )
    {
        var0 = getdvarfloat( "scr_skyhook_spawn_percentage", 1 ) * level.ref_13400.aq_ontimerexpired.size;
    }
    
    if ( var0 > 0 )
    {
        for ( var1 = level.ref_13400.aq_ontimerexpired.size - 1; var1 >= var0 ; var1-- )
        {
            level.ref_13400.aq_ontimerexpired = scripts\engine\utility::array_remove_index( level.ref_13400.aq_ontimerexpired, var1 );
        }
    }
    
    foreach ( var3 in level.ref_13400.aq_ontimerexpired )
    {
        if ( level.ref_13400.­¥K¾¹[—†íŞµ×²›ÑÜ}ÚÂá > -1 )
        {
            if ( var6 >= level.ref_13400.­¥K¾¹[—†íŞµ×²›ÑÜ}ÚÂá )
            {
                break;
            }
        }
        
        var4 = easepower( "scriptable_skyhook", var3[ 0 ] );
        var4 setscriptablepartstate( "skyhook", "on" );
        var4 setscriptablepartstate( "sfx", "idle" );
        var5 = spawn( "script_model", var3[ 0 ] );
        var5 setmodel( "lm_military_skyhook_extraction_01_ch3" );
        var5.angles = var3[ 1 ];
        var4.chopperexfil_sfx_before_sh070 = var5;
        var4.chopperexfil_skip_ascend0 = var5.angles;
        var5.ref_133fa = var4;
        ref_13401( var5 );
        var5.animname = "script_model";
        var5 scripts\common\anim::setanimtree();
        var5 thread scripts\common\anim::anim_single_solo( var5, "redeploy_loop" );
        chopperexfil_sitting_wind( var5 );
        thread skyhookrepairwatcher();
        thread modevalidatekillcam();
        level.ref_13400.areas_remaining[ level.ref_13400.areas_remaining.size ] = var4;
    }
    
    if ( !isdefined( level.ref_13beb ) )
    {
        level.ref_13beb = 0;
    }
    
    level.ref_13beb += level.ref_13400.areas_remaining.size;
}

// Params 0
// Size: 0x127
function spawn_skyhooks_placed()
{
    if ( !level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X.size )
    {
        return;
    }
    
    level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X = scripts\engine\utility::array_randomize( level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X );
    var0 = 0;
    
    if ( getdvarint( "scr_skyhook_randomize_spawns", 0 ) )
    {
        var0 = randomintrange( 1, level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X.size + 1 );
    }
    else if ( getdvarfloat( "scr_skyhook_spawn_percentage", 1 ) )
    {
        var0 = getdvarfloat( "scr_skyhook_spawn_percentage", 1 ) * level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X.size;
    }
    
    if ( var0 > 0 )
    {
        level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X = scripts\engine\utility::array_randomize( level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X );
        
        for ( var1 = level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X.size - 1; var1 >= var0 ; var1-- )
        {
            level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X = scripts\engine\utility::array_remove_index( level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X, var1 );
        }
    }
    
    foreach ( var3 in level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X )
    {
        set_skyhook_placed_available( var3 );
        health_init( var3 );
        thread skyhook_repair_watcher_placed();
        thread modevalidatekillcam();
    }
}

// Params 0
// Size: 0x11
function set_skyhook_placed_available()
{
    self setscriptablepartstate( "skyhook", "available" );
}

// Params 0
// Size: 0x11
function set_skyhook_placed_broken()
{
    self setscriptablepartstate( "skyhook", "broken" );
}

// Params 0
// Size: 0x10b
function ref_12c93()
{
    foreach ( var1 in level.ref_13400.areas_remaining )
    {
        if ( isdefined( var1.chopperexfil_sfx_before_sh070 ) )
        {
            var1.chopperexfil_sfx_before_sh070 delete();
        }
    }
    
    foreach ( var1 in level.ref_13400.areas_remaining )
    {
        var1 setscriptablepartstate( "skyhook", "on" );
        var1 setscriptablepartstate( "sfx", "idle" );
        var4 = spawn( "script_model", var1.origin );
        var4 setmodel( "lm_military_skyhook_extraction_01_ch3" );
        var4.angles = var1.chopperexfil_skip_ascend0;
        var4.ref_133fa = var1;
        var1.chopperexfil_sfx_before_sh070 = var4;
        ref_13401( var1.chopperexfil_sfx_before_sh070 );
        var4.animname = "script_model";
        var4 scripts\common\anim::setanimtree();
        var4 thread scripts\common\anim::anim_single_solo( var4, "redeploy_loop" );
        chopperexfil_sitting_wind( var4 );
        thread skyhookrepairwatcher();
        thread modevalidatekillcam();
    }
}

// Params 0
// Size: 0x49
function respawn_skyhooks_placed()
{
    foreach ( var1 in level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X )
    {
        set_skyhook_placed_available( var1 );
        health_init( var1 );
        thread skyhook_repair_watcher_placed();
        thread modevalidatekillcam();
    }
}

// Params 0
// Size: 0xcf
function ref_12c94()
{
    foreach ( var1 in level.ref_13400.areas_remaining )
    {
        if ( isdefined( var1.chopperexfil_sfx_before_sh070 ) )
        {
            var1.chopperexfil_sfx_before_sh070 delete();
        }
    }
    
    foreach ( var1 in level.ref_13400.areas_remaining )
    {
        var1 setscriptablepartstate( "skyhook", "broken" );
        var4 = spawn( "script_model", var1.origin );
        var4 setmodel( "br_skyhook_extraction_base_01_ch3" );
        var4 setscriptablepartstate( "objective", "broken" );
        var4.angles = var1.chopperexfil_skip_ascend0;
        var4.ref_133fa = var1;
        var1.chopperexfil_sfx_before_sh070 = var4;
        thread skyhookrepairwatcher();
    }
}

// Params 0
// Size: 0x3b
function respawn_skyhooks_destroyed_placed()
{
    foreach ( var1 in level.ref_13400.¦õa¹‡öĞéKçÛHÍpJ?ÛH¢/=X )
    {
        set_skyhook_placed_broken( var1 );
        thread skyhook_repair_watcher_placed();
    }
}

// Params 0
// Size: 0x5b
function chopperexfil_sitting_wind()
{
    self setcandamage( 1 );
    self.health = level.ref_13400.chopperexfil_sh060_start;
    self.maxhealth = level.ref_13400.chopperexfil_sh060_start;
    thread chopperexfil_sh010_start();
    thread balloon_collision_watcher();
    self physics_registerforcollisioncallback();
    self method_87de( 1 );
    
    if ( level.ref_13400.ref_12928 )
    {
        thread ref_135b8();
        return;
    }
}

// Params 0
// Size: 0x37
function health_init()
{
    self.health = level.ref_13400.chopperexfil_sh060_start;
    self.maxhealth = level.ref_13400.chopperexfil_sh060_start;
    
    if ( level.ref_13400.ref_12928 )
    {
        thread ref_135b8();
        return;
    }
}

// Params 0
// Size: 0x2a
function ref_135b8()
{
    self notify( "start_spawn_protection" );
    self endon( "start_spawn_protection" );
    self.chopper_boss_drone_target_array = 1;
    wait level.ref_13400.ref_12928;
    self.chopper_boss_drone_target_array = undefined;
}

// Params 0
// Size: 0x6e
function modevalidatekillcam()
{
    level endon( "respawn_skyhooks" );
    self.capacity = [];
    self waittill( "balloon_destroyed" );
    
    foreach ( var1 in self.capacity )
    {
        var2 = var1 getentitynumber();
        ref_133fc( self.¥â—ñrŸss÷HxG›ûf¨—*;[ var2 ], var1 );
        self.¥â—ñrŸss÷HxG›ûf¨—*;[ var2 ] stoploopsound( "br_auto_ascender_device_lp_npc" );
        playerstartarenasetcontrols( var1, var1 getentitynumber(), self );
    }
}

// Params 5
// Size: 0x91
function ref_13409( var0, var1, var2, var3, var4 )
{
    if ( var2 != "off" )
    {
        if ( var2 == "broken" && var3.plundercount >= level.ref_13400.ref_12c2d )
        {
            var3 thread scripts\mp\hud_message::showsplash( "redeploy_balloon_repaired" );
            ref_13401( var0.chopperexfil_sfx_before_sh070 );
            var0 notify( "player_repaired", var3 );
            return;
        }
        
        if ( var2 != "on" || istrue( var3.ref_140af ) || !get_any_player_spectating( var0, var3 ) )
        {
            playsoundatpos( var0.origin, "skyhook_repair_denied" );
            return;
        }
        
        thread atv_vehicle( level, var0 );
        return;
    }
}

// Params 5
// Size: 0x84
function skyhookplacedscriptableused( var0, var1, var2, var3, var4 )
{
    if ( var2 != "off" )
    {
        if ( var2 == "broken" && var3.plundercount >= level.ref_13400.ref_12c2d )
        {
            var3 thread scripts\mp\hud_message::showsplash( "redeploy_balloon_repaired" );
            var0 notify( "player_repaired", var3 );
            return;
        }
        
        if ( var2 != "on" || istrue( var3.ref_140af ) || !get_any_player_spectating( var0, var3 ) )
        {
            playsoundatpos( var0.origin, "skyhook_repair_denied" );
            return;
        }
        
        thread atv_vehicle( level, var0 );
        return;
    }
}

// Params 0
// Size: 0x100
function skyhookrepairwatcher()
{
    level endon( "game_ended" );
    level endon( "respawn_skyhooks" );
    self waittill( "player_repaired", var0 );
    var0 scripts\mp\gametypes\br_plunder::ref_1261e( level.ref_13400.ref_12c2d );
    playsoundatpos( self.origin, "skyhook_repair" );
    playfx( level.ref_13400.ref_12c32, self.origin + ( 0, 0, 4000 ) );
    playfx( level.ref_13400.ref_12c34, self.origin + ( 0, 0, 16 ) );
    wait 0.25;
    playfx( level.ref_13400.ref_12c33, self.origin );
    self setscriptablepartstate( "skyhook", "on" );
    self setscriptablepartstate( "sfx", "idle" );
    chopperexfil_sitting_wind( self.chopperexfil_sfx_before_sh070 );
    self.chopperexfil_sfx_before_sh070.animname = "script_model";
    self.chopperexfil_sfx_before_sh070 scripts\common\anim::setanimtree();
    self.chopperexfil_sfx_before_sh070 thread scripts\common\anim::anim_single_solo( self.chopperexfil_sfx_before_sh070, "redeploy_loop" );
    thread skyhookrepairwatcher();
    thread modevalidatekillcam();
}

// Params 0
// Size: 0xb0
function skyhook_repair_watcher_placed()
{
    level endon( "game_ended" );
    level endon( "respawn_skyhooks" );
    self waittill( "player_repaired", var0 );
    var0 scripts\mp\gametypes\br_plunder::ref_1261e( level.ref_13400.ref_12c2d );
    playsoundatpos( self.origin, "skyhook_repair" );
    playfx( level.ref_13400.ref_12c32, self.origin + ( 0, 0, 4000 ) );
    playfx( level.ref_13400.ref_12c34, self.origin + ( 0, 0, 16 ) );
    wait 0.25;
    playfx( level.ref_13400.ref_12c33, self.origin );
    set_skyhook_placed_available();
    health_init();
    thread skyhook_repair_watcher_placed();
    thread modevalidatekillcam();
}

// Params 2
// Size: 0x412
function atv_vehicle( var0, var1 )
{
    if ( !get_any_player_spectating( var0, var1 ) )
    {
        return;
    }
    
    if ( getdvarint( "scr_skyhook_carriable_interaction_enabled", 1 ) )
    {
        if ( isdefined( var1.get_search_turret_target_player ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "carriable_useSkyhook" ) )
            {
                var1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "carriable_useSkyhook" ) ]]( var0 );
                return 0;
            }
        }
    }
    
    scripts\mp\gametypes\br_analytics::branalytics_skyhookredeploy( var1 );
    level endon( "game_ended" );
    var0 endon( "balloon_destroyed" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "last_stand_start" );
    var0.capacity[ var0.capacity.size ] = var1;
    var1.ref_140af = 1;
    var1.shouldskiplaststand = 1;
    
    if ( isdefined( var1.get_search_turret_target_player ) )
    {
        var1.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_subway_train_hit_damage_multiplier( 0 );
    }
    
    var2 = var1 getentitynumber();
    var3 = spawn( "script_model", var0.origin );
    var3 scripts\cp_mp\ent_manager::registerspawncount( 1 );
    var3 setmodel( "tag_origin" );
    
    if ( !isdefined( var0.¥â—ñrŸss÷HxG›ûf¨—*; ) )
    {
        var0.¥â—ñrŸss÷HxG›ûf¨—*; = [];
    }
    
    var0.¥â—ñrŸss÷HxG›ûf¨—*;[ var2 ] = var3;
    ref_1246f( var1 );
    thread ref_13405();
    var1.usingascender = 1;
    level.initpostmain++;
    var1 scripts\common\utility::allow_usability( 0 );
    var4 = var0.ascendstructend;
    var5 = var0.ascendstructout;
    var3 dontinterpolate();
    var3.origin = var0.origin + ( 0, 0, 28 );
    var3.angles = var1.angles;
    var6 = spawn( "script_model", var0.origin );
    var6 scripts\cp_mp\ent_manager::registerspawncount( 1 );
    var6 setmodel( "misc_vm_ascender_ch3" );
    var6 showonlytoplayer( var1 );
    var7 = spawn( "script_model", var0.origin );
    var7 scripts\cp_mp\ent_manager::registerspawncount( 1 );
    var7 setmodel( "misc_vm_ascender_ch3" );
    var7 hide();
    
    if ( !isdefined( var0.ƒê·ÙI¸qO•‰Ğ‚2`/u3" ) )
    {
        var0.ƒê·ÙI¸qO•‰Ğ‚2`/u3" = [];
    }
    
    var0.ƒê·ÙI¸qO•‰Ğ‚2`/u3"[ var2 ] = var6;
    
    if ( !isdefined( var0.„,¯²×¹±•72+'ÚÛÈVİ{äÆF ) )
    {
        var0.„,¯²×¹±•72+'ÚÛÈVİ{äÆF = [];
    }
    
    var0.„,¯²×¹±•72+'ÚÛÈVİ{äÆF[ var2 ] = var7;
    thread ascenddeathlistener( var1, var0 );
    var1.chopper_boss_damage_monitor = 0;
    var8 = ref_133fb( var3, var1, var6, var7 );
    
    if ( !var8 )
    {
        playerstartarenasetcontrols( var1, var2, var0 );
        playsoundatpos( var0.origin, "skyhook_repair_denied" );
        return;
    }
    
    GscBinSkip4( 0x6e, var1, var2, var0 );
    // Unknown operator ( 0x6e, iw8, PC )
}

// Params 0
// Size: 0x31
function ref_133fe()
{
    self endon( "kill_skyhook_ascend_earthquake" );
    
    for ( ;; )
    {
        self earthquakeforplayer( 0.2, 1.5, self.origin, 1000 );
        wait randomfloatrange( 0.5, 1 );
    }
}

// Params 0
// Size: 0x1c
function ref_13405()
{
    level endon( "game_ended" );
    self.inuse = 1;
    wait 1;
    self.inuse = undefined;
}

// Params 0
// Size: 0x3d
function ref_12505()
{
    self setclientomnvar( "ui_br_altimeter_state", 3 );
    
    while ( isalive( self ) )
    {
        if ( self isonground() )
        {
            self setclientomnvar( "ui_br_altimeter_state", 0 );
            return;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_br_altimeter_state", 0 );
        return;
    }
}

// Params 3
// Size: 0x10d
function playerstartarenasetcontrols( var0, var1, var2 )
{
    if ( isdefined( var0 ) )
    {
        var0 setscriptablepartstate( "skydiveVfx", "default", 0 );
        var0 setisinfilskydive( 0 );
    }
    
    if ( isdefined( var2.ƒê·ÙI¸qO•‰Ğ‚2`/u3"[ var1 ] ) )
    {
        var2.ƒê·ÙI¸qO•‰Ğ‚2`/u3"[ var1 ] scripts\cp_mp\ent_manager::deregisterspawn();
        var2.ƒê·ÙI¸qO•‰Ğ‚2`/u3"[ var1 ] delete();
    }
    
    if ( isdefined( var2.„,¯²×¹±•72+'ÚÛÈVİ{äÆF[ var1 ] ) )
    {
        var2.„,¯²×¹±•72+'ÚÛÈVİ{äÆF[ var1 ] scripts\cp_mp\ent_manager::deregisterspawn();
        var2.„,¯²×¹±•72+'ÚÛÈVİ{äÆF[ var1 ] delete();
    }
    
    thread cleanupascenduse( var2 );
    thread handleownervisibility( var2, var0 );
    
    if ( isdefined( var0 ) )
    {
        if ( !istrue( level.client_activate ) )
        {
            var0 skydive_setbasejumpingstatus( 1 );
        }
        
        var0.player_rig stopanimscripted();
        var0.usingascender = 0;
        var0.ref_140af = 0;
    }
    
    level.initpostmain--;
    
    if ( isdefined( var0 ) )
    {
        if ( isdefined( var0.ref_140bc ) )
        {
            var0 setvelocity( var0.ref_140bc );
        }
        
        var0.ref_140bc = undefined;
        
        if ( istrue( var0.chopper_boss_damage_monitor ) && !istrue( level.client_activate ) && !scripts\mp\utility\player::unset_relic_trex( var0 ) )
        {
            var0 skydive_beginfreefall();
        }
        
        var0 notify( "skyhook_complete" );
        return;
    }
}

// Params 1
// Size: 0x86
function ref_1246f( var0 )
{
    if ( var0 getstance() != "stand" )
    {
        var0 setstance( "stand" );
    }
    
    var0 allowmelee( 0 );
    var0 allowads( 0 );
    var0 allowfire( 0 );
    
    if ( istrue( var0.isjuggernaut ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
        {
            var1 = var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();
            
            if ( istrue( var1 ) )
            {
                var0 disableweaponswitch();
                return;
            }
            
            return;
        }
        
        return;
    }
    
    var1 disableoffhandweapons();
    var1 scripts\common\utility::allow_killstreaks( 0 );
    var1 scripts\common\utility::allow_supers( 0 );
    var1 disableweaponswitch();
}

// Params 2
// Size: 0xd2, Type: bool
function get_any_player_spectating( var0, var1 )
{
    if ( istrue( level.ref_13400.choosejuggernautcratemodel ) )
    {
        return false;
    }
    
    if ( istrue( var0.inuse ) )
    {
        return false;
    }
    
    if ( var1 isswitchingweapon() )
    {
        return false;
    }
    
    if ( var1.currentweapon.basename == "iw8_spotter_scope_mp_ch3" )
    {
        return false;
    }
    
    if ( var1 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( istrue( var1.tracking_max_health ) )
    {
        return false;
    }
    
    if ( istrue( var1.inlaststand ) )
    {
        return false;
    }
    
    if ( istrue( var1.isreviving ) )
    {
        return false;
    }
    
    if ( istrue( var1.isjuggernaut ) )
    {
        return false;
    }
    
    if ( var1 isskydiving() )
    {
        return false;
    }
    
    if ( var1 isparachuting() )
    {
        return false;
    }
    
    if ( istrue( var1.iszombie ) )
    {
        return false;
    }
    
    var2 = max( level.ref_13beb, 30 );
    var3 = getdvarint( "scr_ascender_override_max_active", var2 );
    
    if ( var3 != -1 )
    {
        var2 = var3;
    }
    
    if ( level.initpostmain >= var2 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0xce
function cleanupascenduse( var0 )
{
    if ( isdefined( var0 ) )
    {
        var0 allowmelee( 1 );
        var0 allowads( 1 );
        var0 allowfire( 1 );
        
        if ( istrue( var0.isjuggernaut ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
            {
                var1 = var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();
                
                if ( istrue( var1 ) )
                {
                    var0 enableweaponswitch();
                }
            }
        }
        else if ( !istrue( var0.inlaststand ) )
        {
            var0 enableoffhandweapons();
            var0 enableweaponswitch();
            var0 scripts\common\utility::allow_killstreaks( 1 );
            var0 scripts\common\utility::allow_supers( 1 );
        }
        else
        {
            thread watch_for_ashes_achievement();
        }
    }
    
    waitframe();
    
    if ( isdefined( var0 ) )
    {
        if ( !istrue( var0.ˆ÷rO¯ gèg‰ÚæTï¨ëX‘ ) )
        {
            var0 allowmelee( 1 );
            var0 enableweaponswitch();
            var0 method_87e5();
            var0 thread scripts\mp\utility\infilexfil::takegunless();
        }
        
        var0 notify( "remove_rig" );
        var0 scripts\common\utility::allow_usability( 1 );
        return;
    }
}

// Params 0
// Size: 0x58
function watch_for_ashes_achievement()
{
    level endon( "game_ended" );
    self.ˆ÷rO¯ gèg‰ÚæTï¨ëX‘ = 1;
    self allowmelee( 0 );
    scripts\engine\utility::ref_143a5( "death_or_disconnect", "last_stand_finished" );
    self allowmelee( 1 );
    self enableoffhandweapons();
    self enableweaponswitch();
    self method_87e5();
    scripts\common\utility::allow_killstreaks( 1 );
    scripts\common\utility::allow_supers( 1 );
    thread scripts\mp\utility\infilexfil::takegunless();
    self.ˆ÷rO¯ gèg‰ÚæTï¨ëX‘ = undefined;
}

// Params 2
// Size: 0x5e
function ascenddeathlistener( var0, var1 )
{
    self endon( "skyhook_complete" );
    scripts\engine\utility::waittill_any_ents( self, "death_or_disconnect", self, "last_stand_start", level, "game_ended" );
    
    if ( isdefined( self ) )
    {
        self stopanimscriptsceneevent();
    }
    
    var0.¥â—ñrŸss÷HxG›ûf¨—*;[ var1 ] stoploopsound( "br_auto_ascender_device_lp_npc" );
    var0.capacity = scripts\engine\utility::array_remove( var0.capacity, self );
    playerstartarenasetcontrols( self, var1, var0 );
}

// Params 2
// Size: 0x45
function handleownervisibility( var0, var1 )
{
    if ( isdefined( var0 ) )
    {
        var0 unlink();
        
        if ( !var0 scripts\common\utility::can_be_executed() )
        {
            var0 scripts\common\utility::allow_execution_victim( 1 );
        }
    }
    
    if ( isdefined( self.¥â—ñrŸss÷HxG›ûf¨—*;[ var1 ] ) )
    {
        self.¥â—ñrŸss÷HxG›ûf¨—*;[ var1 ] scripts\cp_mp\ent_manager::deregisterspawn();
        self.¥â—ñrŸss÷HxG›ûf¨—*;[ var1 ] delete();
        return;
    }
}

// Params 0
// Size: 0x82
function balloon_collision_watcher()
{
    level endon( "game_ended" );
    level endon( "respawn_skyhooks" );
    self endon( "balloon_destroyed" );
    
    for ( ;; )
    {
        self waittill( "collision", var0, var1, var2, var3, var4, var5, var6, var7 );
        
        if ( var4[ 2 ] > self.origin[ 2 ] + 2500 && isdefined( var7 ) && var7 scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            thread kill_vehicle_delayed( var7 );
            self dodamage( self.health + 1, var4, var7, var7, "MOD_CRUSH" );
        }
    }
}

// Params 1
// Size: 0x24
function kill_vehicle_delayed( var0 )
{
    self endon( "death" );
    wait 0.15;
    
    if ( isalive( self ) )
    {
        self dodamage( 99999, var0 );
        return;
    }
}

// Params 0
// Size: 0x36c
function chopperexfil_sh010_start()
{
    level endon( "game_ended" );
    level endon( "respawn_skyhooks" );
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
        
        if ( isdefined( var9 ) && isdefined( var9.magazine ) )
        {
            switch ( var9.magazine )
            {
                case "calcust1_xmike109":
                    var0 = 300;
                    break;
                case "calcust2_xmike109":
                    if ( var3[ 2 ] >= self.origin[ 2 ] + 2500 )
                    {
                        thread fake_thermite_damage_duration( 3, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
                    }
                    
                    break;
            }
        }
        
        if ( var0 < 2 )
        {
            continue;
        }
        
        if ( var3[ 2 ] <= self.origin[ 2 ] + 2500 )
        {
            self.health += var0;
            continue;
        }
        
        if ( istrue( self.ref_133fa.chopper_boss_drone_target_array ) )
        {
            var0 = int( var0 * level.ref_13400.ref_12929 );
        }
        
        if ( isplayer( var1 ) )
        {
            var1 scripts\mp\damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
        }
        else if ( isdefined( var1.owner ) && isplayer( var1.owner ) )
        {
            var1.owner scripts\mp\damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
        }
        
        if ( isdefined( var1 ) && isdefined( var1.currentweapon ) && isdefined( var1.currentweapon.basename ) && var1.currentweapon.basename == "manual_turret_flak_mp" )
        {
            self.health -= int( var0 * ( level.ref_13400.arenaflag_previewflag - 1 ) );
        }
        
        if ( isdefined( var4 ) && var4 == "MOD_PROJECTILE" || var4 == "MOD_GRENADE" || var4 == "MOD_EXPLOSIVE" || var4 == "MOD_EXPLOSIVE_BULLET" )
        {
            self.health -= int( var0 * ( level.ref_13400.open_door_to_next_objective - 1 ) );
        }
        
        if ( isdefined( var9 ) && isdefined( var9.basename ) && var9.basename == "toma_proj_mp" )
        {
            self.health = 0;
        }
        
        if ( self.health <= 0 )
        {
            break;
        }
        
        if ( isdefined( var9 ) && isdefined( var9.magazine ) )
        {
            switch ( var9.magazine )
            {
                case "boltexplo_crossbow":
                    thread fake_explosion_damage_delayed( 2.05, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
                    break;
                case "boltfire_crossbow":
                    thread fake_thermite_damage_duration( 4, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
                    break;
            }
        }
    }
    
    if ( isdefined( var1.model ) && var1.model == "veh_s4_mil_air_dalpha_wz_turret_attach" && isdefined( var1.owner ) && isplayer( var1.owner ) )
    {
        var1.owner thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "rank", "giveRankXP" ) ]]( "kill", 500 );
    }
    
    if ( isdefined( var1 ) && isplayer( var1 ) && isdefined( var1.currentweapon ) && isdefined( var1.currentweapon.basename ) && var1.currentweapon.basename == "tur_gun_bt_mp" )
    {
        var1 thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "rank", "giveRankXP" ) ]]( "kill", 500 );
    }
    
    chopperexfil_sh050_start();
}

// Params 11
// Size: 0x308
function scriptable_skyhook_placed_damaged( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    if ( !isdefined( var2 ) || !isdefined( var2.classname ) || var2.classname != "scriptable_scriptable_skyhook_placed" )
    {
        return;
    }
    
    if ( var3 < 2 )
    {
        return;
    }
    
    if ( var8[ 2 ] <= var2.origin[ 2 ] + 4450 || var8[ 2 ] >= var2.origin[ 2 ] + 4900 )
    {
        return;
    }
    
    if ( istrue( var2.chopper_boss_drone_target_array ) )
    {
        var3 = int( var3 * level.ref_13400.ref_12929 );
    }
    
    if ( isplayer( var1 ) )
    {
        var1 scripts\mp\damagefeedback::updatehitmarker( "standard", var2.health == 0, 0, 1, "hitequip" );
    }
    else if ( isdefined( var1.owner ) && isplayer( var1.owner ) )
    {
        var1.owner scripts\mp\damagefeedback::updatehitmarker( "standard", var2.health == 0, 0, 1, "hitequip" );
    }
    
    if ( isdefined( var1.model ) && var1.model == "veh_s4_mil_air_dalpha_wz" || var1.model == "veh_s4_mil_air_bomber_wz" || var1.model == "veh8_mil_air_lbravo_mp_flyable" || var1.model == "veh8_mil_air_lbravo_mp_flyable_mg" )
    {
        thread vfx_htown_stab_blink_1( level, var1 );
    }
    
    if ( isdefined( var1 ) && isdefined( var1.currentweapon ) && isdefined( var1.currentweapon.basename ) && var1.currentweapon.basename == "manual_turret_flak_mp" )
    {
        var3 = int( var3 * level.ref_13400.arenaflag_previewflag );
    }
    
    if ( isdefined( var5 ) && var5 == 3 || var5 == 4 || var5 == 5 || var5 == 6 || var5 == 7 || var5 == 16 )
    {
        var3 = int( var3 * level.ref_13400.open_door_to_next_objective );
    }
    
    if ( isdefined( var0 ) && isdefined( var0.model ) && var0.model == "ks_airstrike_target_br_ch3" )
    {
        var3 = level.ref_13400.ref_1284a;
    }
    
    var2.health -= var3;
    
    if ( isdefined( var6 ) && isdefined( var6.basename ) && var6.basename == "toma_proj_mp" )
    {
        var2.health = 0;
    }
    
    if ( var2.health <= 0 )
    {
        if ( isdefined( var1.model ) && var1.model == "veh_s4_mil_air_dalpha_wz_turret_attach" && isdefined( var1.owner ) && isplayer( var1.owner ) )
        {
            var1.owner thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "rank", "giveRankXP" ) ]]( "kill", 500 );
        }
        
        if ( isdefined( var1 ) && isplayer( var1 ) && isdefined( var1.currentweapon ) && isdefined( var1.currentweapon.basename ) && var1.currentweapon.basename == "tur_gun_bt_mp" )
        {
            var1 thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "rank", "giveRankXP" ) ]]( "kill", 500 );
        }
        
        balloon_placed_destroyed( var2, var0, var1 );
        return;
    }
}

// Params 12
// Size: 0x2a
function fake_explosion_damage_delayed( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 )
{
    self endon( "balloon_destroyed" );
    wait var0;
    self dodamage( var1, var4, var2, undefined, undefined, undefined, var4 );
}

// Params 12
// Size: 0x74
function fake_thermite_damage_duration( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 )
{
    self endon( "balloon_destroyed" );
    var12 = 0;
    
    while ( var12 < var0 )
    {
        wait 0.25;
        
        if ( scripts\mp\utility\player::isreallyalive( var2 ) )
        {
            var2 scripts\mp\damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
        }
        
        var12 += 0.25;
    }
    
    self dodamage( level.ref_13400.º°ÉÀı˜Å÷±ˆx * var0, var4, var2, undefined, undefined, undefined, var4 );
}

// Params 3
// Size: 0xec
function ref_1284a( var0, var1, var2 )
{
    if ( getdvarint( "scr_skyhooks_enabled", 0 ) )
    {
        if ( isdefined( var0[ "hittype" ] ) && var0[ "hittype" ] == "hittype_entity" && isdefined( var0[ "entity" ] ) && isdefined( var0[ "entity" ].model ) && var0[ "entity" ].model == "lm_military_skyhook_extraction_01_ch3" )
        {
            wait 0.3;
            
            if ( var0[ "position" ][ 2 ] > var0[ "entity" ].origin[ 2 ] + 2500 )
            {
                if ( isdefined( var2 ) )
                {
                    var0[ "entity" ] dodamage( level.ref_13400.ref_1284a, var0[ "position" ], undefined, var2 );
                }
                else
                {
                    var0[ "entity" ] dodamage( level.ref_13400.ref_1284a, var0[ "position" ] );
                }
                
                if ( var0[ "entity" ].health <= 0 )
                {
                    var2.brattractions++;
                    return;
                }
                
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x91
function chopperexfil_sh050_start()
{
    self.ref_133fa setscriptablepartstate( "skyhook", "broken" );
    ref_13402( self.ref_133fa );
    playfx( level.ref_13400.iskillstreakvehicleinflictor, self.ref_133fa.origin + ( 0, 0, 4500 ) );
    self.ref_133fa setscriptablepartstate( "sfx", "expl_sfx" );
    self.ref_133fa notify( "balloon_destroyed" );
    radiusdamage( self.origin + ( 0, 0, 4500 ), 512, 100, 100, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp" );
}

// Params 2
// Size: 0x92
function balloon_placed_destroyed( var0, var1 )
{
    self setscriptablepartstate( "skyhook", "broken" );
    playfx( level.ref_13400.iskillstreakvehicleinflictor, self.origin + ( 0, 0, 4500 ) );
    self notify( "balloon_destroyed" );
    
    if ( isdefined( var0 ) && isdefined( var0.model ) && var0.model == "ks_airstrike_target_br_ch3" )
    {
        var1.brattractions++;
    }
    
    waitframe();
    radiusdamage( self.origin + ( 0, 0, 4500 ), 512, 100, 100, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp" );
}

// Params 2
// Size: 0x1e
function vfx_htown_stab_blink_1( var0, var1 )
{
    wait 0.15;
    
    if ( scripts\mp\utility\player::isreallyalive( var0 ) )
    {
        var0 dodamage( 9999, var1 );
        return;
    }
}

#using_animtree( "" );

// Params 0
// Size: 0x22b
function initanimtree()
{
    level.scr_animtree[ "script_model" ] = #animtree;
    level.scr_anim[ "script_model" ][ "redeploy_loop" ] = $wm_redeploy_balloon_idle;
    level.scr_animname[ "script_model" ][ "redeploy_loop" ] = "wm_redeploy_balloon_idle";
    level.scr_eventanim[ "script_model" ][ "redeploy_loop" ] = "redeploy_loop";
    level.scr_animtree[ "player" ] = #animtree;
    level.scr_anim[ "player" ][ "redeploy_enter" ] = %vm_eq_redeploy_enter_plr;
    level.scr_animname[ "player" ][ "redeploy_enter" ] = "vm_eq_redeploy_enter_plr";
    level.scr_eventanim[ "player" ][ "redeploy_enter" ] = "redeploy_enter";
    level.scr_anim[ "player" ][ "redeploy_loop" ] = %vm_eq_redeploy_loop_plr;
    level.scr_animname[ "player" ][ "redeploy_loop" ] = "vm_eq_redeploy_loop_plr";
    level.scr_eventanim[ "player" ][ "redeploy_loop" ] = "redeploy_loop";
    level.scr_anim[ "player" ][ "redeploy_exit" ] = %vm_eq_redeploy_exit_plr;
    level.scr_animname[ "player" ][ "redeploy_exit" ] = "vm_eq_redeploy_exit_plr";
    level.scr_eventanim[ "player" ][ "redeploy_exit" ] = "redeploy_exit";
    level.scr_animtree[ "device" ] = #animtree;
    level.scr_anim[ "device" ][ "redeploy_enter" ] = %wm_eq_redeploy_enter_ascender;
    level.scr_animname[ "device" ][ "redeploy_enter" ] = "wm_eq_redeploy_enter_ascender";
    level.scr_eventanim[ "device" ][ "redeploy_enter" ] = "redeploy_enter";
    level.scr_anim[ "device" ][ "redeploy_loop" ] = %wm_eq_redeploy_loop_ascender;
    level.scr_animname[ "device" ][ "redeploy_loop" ] = "wm_eq_redeploy_loop_ascender";
    level.scr_eventanim[ "device" ][ "redeploy_loop" ] = "redeploy_loop";
    level.scr_anim[ "device" ][ "redeploy_exit" ] = %wm_eq_redeploy_exit_ascender;
    level.scr_animname[ "device" ][ "redeploy_exit" ] = "wm_eq_redeploy_exit_ascender";
    level.scr_eventanim[ "device" ][ "redeploy_exit" ] = "redeploy_exit";
}

// Params 3
// Size: 0x292, Type: bool
function ref_133fb( var0, var1, var2 )
{
    var0 endon( "death_or_disconnect" );
    var0 endon( "ascender_cancel" );
    thread ref_13404( var0, "player", var0.origin );
    var1.animname = "device";
    var1 scripts\common\anim::setanimtree();
    var2.animname = "device";
    var2 scripts\common\anim::setanimtree();
    var2 hide();
    var3 = "TAG_ACCESSORY_RIGHT";
    var4 = "redeploy_enter";
    var5 = var0.origin - self.origin;
    var6 = vectornormalize( var5 ) * length( ( -16.12, 9.073, 0 ) );
    var7 = rotatevector( ( -16.12, 9.073, 0 ), ( 0, var0.angles[ 1 ] - -35.985, 0 ) );
    var8 = self.origin + var7;
    var0 scripts\common\utility::allow_execution_victim( 0 );
    self.ref_140bb = self.origin;
    self.origin = var0.origin;
    self moveto( self.ref_140bb, 0.4, 0.1, 0.1 );
    self.ref_140b3 = self.angles;
    self.angles = var0 getplayerangles();
    self rotateto( self.ref_140b3, 0.4, 0.1, 0.1 );
    var0.player_rig moveto( var8, 0.4, 0.1, 0.1 );
    var9 = vectortoangles( -1 * ( var6[ 0 ], var6[ 1 ], 0 ) );
    var0.player_rig rotateto( var9, 0.4, 0.1, 0.1 );
    var10 = var0 scripts\mp\utility\infilexfil::givegunless();
    
    if ( !var10 )
    {
        return false;
    }
    
    var0 disableweaponswitch();
    var0 method_87e4();
    var0.player_rig linkto( self, "tag_origin", -1 * var6, ( 0, 0, 0 ) );
    var1 linkto( var0.player_rig, var3, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var0.player_rig showonlytoplayer( var0 );
    scripts\common\anim::anim_first_frame_solo( var0.player_rig, var4 );
    thread scripts\mp\anim::anim_player_solo( var0, var0.player_rig, var4 );
    waitframe();
    thread scripts\common\anim::anim_single_solo( var2, var4 );
    var11 = 0.1;
    wait var11;
    var2 show();
    
    if ( !getdvarint( "scr_skyhook_show_thirdperson_ascender", 0 ) )
    {
        var2 hidefromplayer( var0 );
    }
    
    var12 = getanimlength( level.scr_anim[ "player" ][ var4 ] ) - var11;
    wait var12 * 0.55;
    var0 earthquakeforplayer( 0.1, 0.25, var0.origin, 1000 );
    wait var12 * 0.45;
    return true;
}

// Params 3
// Size: 0x136
function ref_13404( var0, var1, var2 )
{
    self.animname = var0;
    
    if ( !isdefined( var1 ) )
    {
        var1 = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = ( 0, 0, 0 );
    }
    
    self predictstreampos( var1 );
    var3 = spawn( "script_arms", var1, 0, 0, self );
    var3.angles = var2;
    var3.player = self;
    self.player_rig = var3;
    self.player_rig hide( 1 );
    self.player_rig.animname = var0;
    self.player_rig useanimtree( #animtree );
    self.player_rig.updatedversion = 1;
    self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
    self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
    self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;
    self playerlinktodelta( self.player_rig, "tag_player", 1, 70, 70, 30, 30, 1 );
    self notify( "rig_created" );
    scripts\engine\utility::ref_143a5( "remove_rig", "player_free_spot" );
    
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        
        if ( !istrue( self.ˆ÷rO¯ gèg‰ÚæTï¨ëX‘ ) )
        {
            self allowmelee( 1 );
            self enableweaponswitch();
            self method_87e5();
            thread scripts\mp\utility\infilexfil::takegunless();
        }
    }
    
    if ( isdefined( var3 ) )
    {
        var3 delete();
        return;
    }
}

// Params 0
// Size: 0x1b
function ref_13401()
{
    self setmodel( "lm_military_skyhook_extraction_01_ch3" );
    self setscriptablepartstate( "objective", "available" );
}

// Params 0
// Size: 0x23
function ref_13402()
{
    self.chopperexfil_sfx_before_sh070 setmodel( "br_skyhook_extraction_base_01_ch3" );
    self.chopperexfil_sfx_before_sh070 setscriptablepartstate( "objective", "broken" );
}

// Params 3
// Size: 0x32
function ref_133fd( var0, var1, var2 )
{
    var3 = "redeploy_loop";
    scripts\common\anim::anim_first_frame_solo( var0.player_rig, var3 );
    thread scripts\mp\anim::anim_player_solo( var0, var0.player_rig, var3 );
    thread scripts\common\anim::anim_single_solo( var2, var3 );
}

// Params 3
// Size: 0x3c
function ref_133fc( var0, var1, var2 )
{
    var3 = "redeploy_exit";
    scripts\common\anim::anim_first_frame_solo( var0.player_rig, var3 );
    thread scripts\mp\anim::anim_player_solo( var0, var0.player_rig, var3 );
    
    if ( isdefined( var2 ) )
    {
        var2 scripts\cp_mp\ent_manager::deregisterspawn();
        var2 delete();
        return;
    }
}

// Params 0
// Size: 0x14b
function ref_13403()
{
    self endon( "death_or_disconnect" );
    
    while ( !self isonground() )
    {
        var0 = scripts\common\utility::playersincylinder( self.origin, level.ref_13400.–‚ãBÍ˜Yñ3Ç``ë?, undefined, level.ref_13400.¬…Ø›¶J=T9ìMÛbH£ );
        var1 = self.team;
        
        foreach ( var3 in var0 )
        {
            if ( scripts\mp\utility\game::updatehistoryhud( var3 ) )
            {
                continue;
            }
            
            var4 = var1 == var3.team;
            
            if ( var4 )
            {
                continue;
            }
            
            var5 = !scripts\mp\utility\player::isreallyalive( var3 ) || istrue( var3.inlaststand );
            
            if ( var5 )
            {
                continue;
            }
            
            var6 = var3 isparachuting() || var3 isinfreefall();
            
            if ( var6 )
            {
                continue;
            }
            
            var7 = gettime();
            var8 = isdefined( var3.showteamlittlebirds ) && var7 - var3.showteamlittlebirds < level.ref_13400.¢Î»°9¹Z›võKÖYÛW:¾kÜ;
            
            if ( var8 )
            {
                continue;
            }
            
            var3.showteamlittlebirds = var7;
            
            if ( var3 scripts\cp_mp\utility\game_utility::ref_140a8() )
            {
                var9 = "bchr";
            }
            else
            {
                var10 = scripts\mp\gametypes\br_public::disableannouncer( var3 );
                var9 = game[ "voice" ][ var10 ];
            }
            
            var3 queuedialogforplayer( level.audio_railyard_fires[ var9 ], "respawning_enemy_in_area", 2 );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x13
function isplatepouch()
{
    scripts\mp\gametypes\br_dev::ref_12b21( &isplacementplayerobstructed );
    thread isplayerbrsquadleader();
}

// Params 0
// Size: 0x16
function isplayerbrsquadleader()
{
    level endon( "game_ended" );
    
    while ( !isdefined( level.player ) )
    {
        waitframe();
    }
}

// Params 2
// Size: 0x45
function isplacementplayerobstructed( var0, var1 )
{
    switch ( var0 )
    {
        case "skyhook_spawn":
            level.ref_13400.aq_ontimerexpired = [ [ level.players[ 0 ].origin, level.players[ 0 ].angles ] ];
            ref_135d3();
            break;
    }
}

// Params 3
// Size: 0x41
function debug_destroy_balloon_delayed( var0, var1, var2 )
{
    wait var2;
    
    if ( isdefined( var0.chopperexfil_sfx_before_sh070 ) )
    {
        var0.chopperexfil_sfx_before_sh070 dodamage( 999999, var1.origin + ( 0, 0, 4000 ) );
        return;
    }
    
    balloon_placed_destroyed( var0 );
}

