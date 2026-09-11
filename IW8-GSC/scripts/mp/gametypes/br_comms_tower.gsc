
// Params 0
// Size: 0x6a
function init()
{
    level endon( "game_ended" );
    level._effect[ "vfx_esc4_tower_button" ] = loadfx( "vfx/iw8_br/mp_escape4/vfx_esc4_tower_button.vfx" );
    level._effect[ "vfx_esc4_tower_red_blink_light" ] = loadfx( "vfx/iw8_br/mp_escape4/vfx_esc4_infil_container_smk.vfx" );
    game[ "dialog" ][ "comm_tower_activated_nearby" ] = "public_events_comm_tower_brdcst";
    game[ "dialog" ][ "comm_tower_activated_team" ] = "public_events_comm_tower_sweep";
    waitframe();
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    thread initcommstowers();
}

// Params 0
// Size: 0xaf
function initcommstowers()
{
    if ( getdvarint( "scr_br_comms_tower_enabled", 1 ) == 0 )
    {
        return;
    }
    
    scripts\mp\gametypes\br_plunder::registerpostplundercallback( &towerpostplunder );
    level.¨hpÍ≥Í…:∆/«E‹M = spawnstruct();
    level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ = [];
    level.¨hpÍ≥Í…:∆/«E‹M.ref_13671 = gettowersspawnlocation();
    level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á = getdvarint( "scr_br_comms_tower_price", 1500 );
    level.¨hpÍ≥Í…:∆/«E‹M.usecooldown = getdvarint( "scr_br_comms_tower_cd", 45 );
    level.¨hpÍ≥Í…:∆/«E‹M.Ü2(Ûµ„	-qeæ = getdvarint( "scr_br_comms_tower_radius", 2500 );
    level.¨hpÍ≥Í…:∆/«E‹M.•‡û˛2˝soá Ä+ôH = getdvarint( "scr_br_comms_tower_sweeptime", 3000 );
    spawntowers();
    thread watchfiresaleevent();
    thread disabletowersingas();
}

// Params 1
// Size: 0x53
function playdialog( var0 )
{
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "comm_tower_activated_team", var0.team, 1 );
    var1 = scripts\mp\utility\teams::getfriendlyplayers( var0.team, 1 );
    var2 = scripts\mp\utility\player::getplayersinradius( var0.origin, 2500, undefined, var1 );
    
    if ( var2.size > 0 )
    {
        level thread scripts\mp\gametypes\br_public::brleaderdialog( "comm_tower_activated_nearby", 1, var2 );
        return;
    }
}

// Params 0
// Size: 0x224
function gettowersspawnlocation()
{
    var0 = [];
    
    switch ( getdvar( "mapname" ) )
    {
        case "mp_wz_island":
            break;
        case "mp_sm_island_1":
            GscBinSkip0( 0x2e, var0.size, [ ( 3280, -4426.5, 1258 ), ( 3271, -4392, 1251 ), ( 0, 285, 0 ) ] );
            // Unknown operator ( 0x2e, iw8, PC )
        case "mp_br_mechanics":
            GscBinSkip0( 0x2e, var0.size, [ ( 2048, -2649, 50.25 ), ( 2048, -2688, 0 ), ( 0, 0, 0 ) ] );
            // Unknown operator ( 0x2e, iw8, PC )
        case "mp_escape4_s5":
        case "mp_escape4":
            GscBinSkip0( 0x2e, var0.size, [ ( -2924.25, -10759, 584.75 ), ( -2952.25, -10732, 533.75 ), ( 0, 45, 0 ) ] );
            // Unknown operator ( 0x2e, iw8, PC )
    }
    
    return var0;
}

// Params 0
// Size: 0x193
function spawntowers()
{
    var0 = 0;
    
    foreach ( var2 in level.¨hpÍ≥Í…:∆/«E‹M.ref_13671 )
    {
        var3 = spawn( "script_model", var2[ 0 ] );
        var3 setmodel( "tag_origin" );
        var4 = easepower( "comms_tower_ee", var2[ 0 ] );
        var5 = spawn( "script_model", var2[ 1 ] );
        var5.angles = var2[ 2 ];
        var5 setmodel( "comms_tower_indicator" );
        var3.useprompt = scripts\mp\gameobjects::createhintobject( var3.origin, "HINT_BUTTON", undefined, &"WZ_MP_ESCAPE_TU_WZ325/PURCHASE_COMMS_TOWER_ENABLED", undefined, undefined, undefined, 0, 0, 65, 90 );
        var3.useprompt.¥ç

9∞‡´0[ª£ = scripts\mp\gameobjects::createhintobject( var3.origin, "HINT_BUTTON", undefined, &"WZ_MP_ESCAPE_TU_WZ325/PURCHASE_COMMS_TOWER_DISABLED", undefined, undefined, undefined, 0, 0, 65, 90 );
        var3.useprompt.inuse = 0;
        level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ[ level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ.size ] = var3.useprompt;
        var3.id = var0;
        var0++;
        var3.useprompt sethintstringparams( level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á );
        var3.useprompt.¥ç

9∞‡´0[ª£ sethintstringparams( level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á );
        thread managetowerpromptinteraction( var3, var3.useprompt, var4 );
        thread manageredpromptinteraction( var3 );
    }
    
    foreach ( var8 in level.players )
    {
        thread ref_126e0();
    }
}

// Params 3
// Size: 0x10d
function managetowerpromptinteraction( var0, var1, var2 )
{
    level endon( "game_ended" );
    waitframe();
    var1 setscriptablepartstate( "light", "button_on" );
    var2 setscriptablepartstate( "light", "indicator_off" );
    var3 = 15;
    
    for ( ;; )
    {
        var0 waittill( "trigger", var4 );
        
        if ( ref_1392a( var0, var4 ) )
        {
            thread doscan( var4 );
            thread playdialog( level );
            commstowersanalytics( var4, self.id );
            var4 thread scripts\mp\utility\points::giveunifiedpoints( "br_comm_tower_activated" );
            var0.inuse = 1;
            disabletowerpromptuse( var0 );
            
            if ( !scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think( 2 ) )
            {
                var5 = int( level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á / 100 );
                var4 scripts\mp\gametypes\br_plunder::playersetplundercount( var4.plundercount - var5 );
            }
            
            var1 setscriptablepartstate( "light", "button_off" );
            var2 setscriptablepartstate( "light", "indicator_on" );
            wait var3;
            var2 setscriptablepartstate( "light", "indicator_off" );
            wait level.¨hpÍ≥Í…:∆/«E‹M.usecooldown;
            var1 setscriptablepartstate( "light", "button_on" );
            var0.inuse = 0;
            enabletowerpromptuse( var0 );
        }
    }
}

// Params 1
// Size: 0x25
function manageredpromptinteraction( var0 )
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        self playsoundtoplayer( "ui_screen_edge_deny", var1 );
    }
}

// Params 1
// Size: 0x40
function doscan( var0 )
{
    for ( var1 = 0; var1 < 5 ; var1++ )
    {
        triggerportableradarpingteam( self.origin, var0.team, level.¨hpÍ≥Í…:∆/«E‹M.Ü2(Ûµ„	-qeæ, level.¨hpÍ≥Í…:∆/«E‹M.•‡û˛2˝soá Ä+ôH );
        wait 3;
    }
}

// Params 1
// Size: 0x1f
function towerpostplunder( var0 )
{
    if ( !scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think( 2 ) )
    {
        if ( playerplunderupdate( var0 ) )
        {
            thread ref_126e0();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x91
function playerplunderupdate( var0 )
{
    var1 = int( level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á / 100 );
    
    if ( !isdefined( var0 ) || !isdefined( var0.player ) )
    {
        return 1;
    }
    
    if ( var0.player.plundercount >= var1 && var0.player.plundercount - var0.ref_127b4 >= var1 )
    {
        return 0;
    }
    
    if ( var0.player.plundercount < var1 && var0.player.plundercount - var0.ref_127b4 < var1 )
    {
        return 0;
    }
    
    return 1;
}

// Params 0
// Size: 0x34
function ref_126e0()
{
    foreach ( var1 in level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ )
    {
        ref_126df( var1 );
    }
}

// Params 0
// Size: 0x2e
function playersupdatestructures()
{
    foreach ( var1 in level.players )
    {
        thread ref_126e0();
    }
}

// Params 1
// Size: 0x40
function disabletowerpromptuse( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) )
        {
            var0 disableplayeruse( var2 );
            var0.¥ç

9∞‡´0[ª£ disableplayeruse( var2 );
        }
    }
}

// Params 1
// Size: 0x36
function enabletowerpromptuse( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) )
        {
            ref_126df( var2, var0 );
        }
    }
}

// Params 1
// Size: 0x97
function ref_126df( var0 )
{
    if ( var0.inuse )
    {
        return;
    }
    
    if ( istrue( self.iszombie ) )
    {
        var0 disableplayeruse( self );
        var0.¥ç

9∞‡´0[ª£ disableplayeruse( self );
        return;
    }
    
    var1 = int( level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á / 100 );
    
    if ( isdefined( self.plundercount ) && self.plundercount >= var1 || scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think( 2 ) )
    {
        var0 enableplayeruse( self );
        var0.¥ç

9∞‡´0[ª£ disableplayeruse( self );
        return;
    }
    
    if ( !isdefined( self.plundercount ) || self.plundercount < var1 )
    {
        var0 disableplayeruse( self );
        var0.¥ç

9∞‡´0[ª£ enableplayeruse( self );
        return;
    }
}

// Params 1
// Size: 0x35, Type: bool
function ref_1392a( var0 )
{
    if ( scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think( 2 ) )
    {
        return true;
    }
    
    var1 = int( level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á / 100 );
    
    if ( var0.plundercount < var1 )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x94
function watchfiresaleevent()
{
    for ( ;; )
    {
        level waittill( "public_event_firesale_start" );
        
        foreach ( var1 in level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ )
        {
            var1 sethintstringparams( 0 );
        }
        
        thread playersupdatestructures();
        level waittill( "public_event_firesale_end" );
        
        foreach ( var1 in level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ )
        {
            var1 sethintstringparams( level.¨hpÍ≥Í…:∆/«E‹M.Ñ¢gyœ≥uC?ìSÈãë'Á );
        }
        
        thread playersupdatestructures();
    }
}

// Params 0
// Size: 0x7b
function disabletowersingas()
{
    for ( ;; )
    {
        level waittill( "br_circle_set", var0 );
        
        foreach ( var2 in level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ )
        {
            if ( !scripts\mp\gametypes\br_circle::updateprestreamrespawn( var2.origin ) )
            {
                var2 istacmapactive();
                var2.¥ç

9∞‡´0[ª£ istacmapactive();
                level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ = scripts\engine\utility::array_remove( level.¨hpÍ≥Í…:∆/«E‹M.è€H∞“Ì{K0»œÎ, var2 );
            }
        }
    }
}

// Params 1
// Size: 0x69
function commstowersanalytics( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = [];
    var3 = var0;
    var2 = "comms_towers_id";
    var2 = var3;
    
    if ( isdefined( level.br_circle ) )
    {
        var4 = scripts\mp\gametypes\br_quest_util::relic_mythic_modifyplayerdamage();
        var2 = "comms_towers_circle_index";
        var2 = var4;
    }
    
    var5 = scripts\mp\matchdata::gettimefrommatchstart( gettime() );
    var2 = "time_msfrommatchstart";
    var2 = var5;
    var1 dlog_recordplayerevent( "dlog_event_comms_towers", var2 );
}

