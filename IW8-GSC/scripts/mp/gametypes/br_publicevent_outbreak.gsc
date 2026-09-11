
// Params 0
// Size: 0x8f
function init()
{
    var0 = spawnstruct();
    var0.weight = getdvarfloat( "scr_br_pe_outbreak_weight", 1 );
    var0.ref_140cf = &ref_140cf;
    var0.attackerswaittime = &attackerswaittime;
    var0.ref_14382 = &ref_14382;
    var0.‹Á¿ø{ÏXX;â# / = &postinitfunc;
    var0.ref_11b78 = getdvarint( "scr_br_pe_outbreak_max_times", 0 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "outbreak", "0    20  20  20          0   0   0   0" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "outbreak" );
    scripts\mp\gametypes\br_publicevents::ref_12b35( 19, var0 );
}

// Params 0
// Size: 0xf6
function postinitfunc()
{
    game[ "dialog" ][ "zmb_outbreak_meter_25percent" ] = "outbreak_meter1";
    game[ "dialog" ][ "zmb_outbreak_meter_50percent" ] = "outbreak_meter2";
    game[ "dialog" ][ "zmb_outbreak_meter_75percent" ] = "outbreak_meter3";
    game[ "dialog" ][ "zmb_outbreak_announcement" ] = "outbreak_announcement";
    game[ "dialog" ][ "zmb_outbreak_redeploy" ] = "outbreak_redeploy";
    game[ "dialog" ][ "zmb_outbreak_redeploy_spectator" ] = "outbreak_redeploy_spectator";
    var0 = createoutbreakmeterstate( 1, "zmb_outbreak_announcement", 2.5, 1 );
    var1 = createoutbreakmeterstate( 0.75, "zmb_outbreak_meter_75percent", 1.5, 0 );
    var2 = createoutbreakmeterstate( 0.5, "zmb_outbreak_meter_50percent", 1.5, 1 );
    var3 = createoutbreakmeterstate( 0.1, "zmb_outbreak_meter_25percent", 1.5, 2 );
    level.disable_super_in_turret.ºãíW˜'•¶Ú•è¬97£°è¬n = [ var0, var1, var2, var3 ];
    level.disable_super_in_turret.’ÄÛ®Ñ&œYÂm­+¬äs+á£7,£¬KÍ¬< = 3;
}

// Params 0
// Size: 0x4f
function ref_140cf()
{
    var0 = level scripts\mp\utility\game::round_vehicle_logic();
    var1 = var0 == "zxp" || var0 == "brz" || var0 == "gxp";
    var2 = 0;
    var3 = istrue( level.usegulag ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "gulag" );
    
    if ( var1 && !var3 )
    {
        var2 = 1;
    }
    
    return var2;
}

// Params 0
// Size: 0x18
function ref_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var0 = forest_combat();
    wait var0;
}

// Params 0
// Size: 0x170
function attackerswaittime()
{
    level endon( "game_ended" );
    var0 = 3.5;
    var1 = getdvarfloat( "scr_br_pe_outbreak_duration", 15 );
    thread init_lbravo_spawn_after_level_restart( var0 + var1 );
    showsplashtoaliveplayers( "br_pe_outbreak_incoming" );
    wait var0;
    var2 = gettime() + var1 * 1000;
    setomnvar( "ui_publicevent_timer_type", 12 );
    setomnvar( "ui_publicevent_timer", var2 );
    var3 = spawn( "script_origin", ( 0, 0, 0 ) );
    var3 hide();
    var4 = undefined;
    var5 = undefined;
    var6 = getdvarint( "scr_br_pe_outbreak_include_eliminated_teams", 1 );
    
    if ( var1 > 5 )
    {
        wait var1 - 5;
        var7 = fix_badcover_atend( var6 );
        var4 = var7[ 0 ];
        var5 = var7[ 1 ];
        var7 = undefined;
        thread preemtiverespawnplayers( var4 );
        
        for ( var8 = 0; var8 < 5 ; var8++ )
        {
            var3 playsound( "ui_mp_fire_sale_timer" );
            wait 1;
        }
    }
    
    scripts\mp\gametypes\br_publicevents::ref_13371( "br_pe_outbreak_active" );
    setomnvar( "ui_publicevent_timer_type", 0 );
    var3 delete();
    var9 = fix_badcover_atend( var6 );
    var10 = var9[ 0 ];
    var5 = var9[ 1 ];
    var9 = undefined;
    
    if ( isdefined( var4 ) )
    {
        var10 = scripts\engine\utility::array_remove_array( var10, var4 );
        var5 = scripts\engine\utility::array_remove_array( var5, var4 );
    }
    
    thread ref_12cad( var10 );
    
    foreach ( var12 in var5 )
    {
        if ( !isdefined( var12 ) )
        {
            continue;
        }
        
        if ( scripts\mp\utility\player::isreallyalive( var12 ) && !istrue( var12.iszombie ) )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "zmb_outbreak_redeploy", var12, 1, 0, 2 );
        }
    }
}

// Params 1
// Size: 0x15
function preemtiverespawnplayers( var0 )
{
    level endon( "game_ended" );
    wait 3;
    ref_12cad( var0 );
}

// Params 0
// Size: 0x30
function forest_combat()
{
    var0 = getdvarfloat( "scr_br_pe_outbreak_starttime_min", 795 );
    var1 = getdvarfloat( "scr_br_pe_outbreak_starttime_max", 1110 );
    
    if ( var1 > var0 )
    {
        return randomfloatrange( var0, var1 );
    }
    
    return var0;
}

// Params 1
// Size: 0xd5
function fix_badcover_atend( var0 )
{
    var1 = [];
    var2 = [];
    
    foreach ( var4 in level.teamnamelist )
    {
        var5 = level.teamdata[ var4 ];
        var6 = var5[ "teamCount" ];
        var7 = var5[ "aliveCount" ];
        var8 = undefined;
        
        if ( var0 )
        {
            var8 = var6 > 0 && var7 != var6;
        }
        else
        {
            var8 = var6 > 0 && var7 > 0 && var7 != var6;
        }
        
        foreach ( var10 in var5[ "players" ] )
        {
            if ( var8 && !isalive( var10 ) )
            {
                var1 = var10;
                continue;
            }
            
            var2 = var10;
        }
    }
    
    return [ var1, var2 ];
}

// Params 1
// Size: 0x73
function ref_12cad( var0 )
{
    level endon( "game_ended" );
    var1 = getdvarint( "scr_br_pe_outbreak_include_eliminated_teams", 1 );
    
    foreach ( var3 in var0 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        if ( var1 )
        {
            var3 scripts\mp\gametypes\br_publicevent_jailbreak::ref_12c78();
        }
        
        var3.—e³¿€ç1)7Ê¸y*?ÍÓz = 1;
        var3 thread scripts\mp\gametypes\br_alt_mode_zxp::ref_12723( 0, 1 );
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "zmb_outbreak_redeploy_spectator", var3, 1, 1 );
        waitframe();
    }
}

// Params 1
// Size: 0x42
function showsplashtoaliveplayers( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( scripts\mp\utility\player::isreallyalive( var2 ) || var2 ismlgspectator() )
        {
            var2 scripts\mp\hud_message::showsplash( var0 );
        }
    }
}

// Params 4
// Size: 0x32
function createoutbreakmeterstate( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.«œ°èKö = var0;
    var4.dialog = var1;
    var4.‡#K…Æ·ì#¬Ë = var2;
    var4.“…u£³ÛŠUÌs›'Q = var3;
    return var4;
}

// Params 0
// Size: 0x8e
function manageoutbreakmeterdialog()
{
    var0 = scripts\mp\gametypes\br_publicevents_meter::getmetercurrentratio();
    var1 = level.disable_super_in_turret.’ÄÛ®Ñ&œYÂm­+¬äs+á£7,£¬KÍ¬<;
    
    if ( isdefined( level.disable_super_in_turret.ºãíW˜'•¶Ú•è¬97£°è¬n ) )
    {
        foreach ( var3 in level.disable_super_in_turret.ºãíW˜'•¶Ú•è¬97£°è¬n )
        {
            if ( var0 >= var3.«œ°èKö && var1 >= var4 )
            {
                scripts\mp\gametypes\br_public::brleaderdialog( var3.dialog, 1, undefined, 1, var3.‡#K…Æ·ì#¬Ë );
                level.disable_super_in_turret.’ÄÛ®Ñ&œYÂm­+¬äs+á£7,£¬KÍ¬< = var3.“…u£³ÛŠUÌs›'Q;
                return;
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x5c
function init_lbravo_spawn_after_level_restart( var0 )
{
    level notify( "create_siren" );
    var1 = spawn( "script_model", ( 370, -2679, 3000 ) );
    var1 setmodel( "rebirth_fx" );
    waitframe();
    var1 setscriptablepartstate( "sfx", "cine_escape2_infil_siren" );
    level.ref_12a76 = 1;
    level scripts\engine\utility::waittill_notify_or_timeout( "create_siren", var0 );
    var1 delete();
    level.ref_12a76 = 0;
}

