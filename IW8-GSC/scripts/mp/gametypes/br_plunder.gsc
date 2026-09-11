
// Params 0
// Size: 0x1d4
function init()
{
    level.br_plunder_enabled = getdvarint( "scr_br_plunder", 1 ) != 0;
    
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    thread setupplunderextractionsites();
    thermite_linktostuck();
    thermite_watchglstuck();
    level._effect[ "vfx_extract_smoke" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker" );
    
    if ( scripts\mp\gametypes\br_public::shouldusegoldbarassets() )
    {
        level._effect[ "vfx_br_cashLeaderBag" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_gold_backpack.vfx" );
    }
    else
    {
        level._effect[ "vfx_br_cashLeaderBag" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx" );
    }
    
    level.br_plunder_lobby = getdvarint( "scr_br_plunder_lobby", 0 ) != 0 && istrue( level.allowprematchdamage );
    level.br_plunder = spawnstruct();
    level.br_plunder.ref_127bf = 65535;
    level.br_plunder.ref_12790 = 0;
    level.br_plunder.ref_127ad = 0;
    level.br_plunder.ref_1278f = 0;
    level.br_plunder.ref_127ac = 0;
    level.br_plunder.wait_for_all_players_in_airlock = 0;
    level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes = 0;
    level.br_plunder.oscope_freq_think = 0;
    level.br_plunder.oscope_freq = 0;
    level.br_plunder.oscope_sign_think = 0;
    level.br_plunder.oscope_sign = 0;
    level.br_plunder.ref_12784 = 0;
    level.delete_on_unloaded = getdvarfloat( "scr_br_plunder_death_tax_pct", 3 );
    level.delete_on_track_delete = getdvarfloat( "scr_br_plunder_death_keep_pct", 2 );
    level.delete_on_exit_icon_trigger_pre_race = getdvarfloat( "scr_br_plunder_death_drop_pct", 5 );
    setupquantities();
    tracegroundheightexfil();
    toggle_wind();
    level.br_depots = [];
    thread ref_12788();
    thread ref_1278d();
    
    if ( inplunderlivelobby() )
    {
        level.br_plunder_ents = [];
        thread plunderlivelobby();
    }
    
    toggle_trap();
    ref_1278e();
    _debug_rooftopobjstart::playertimestamp();
    scripts\mp\gametypes\br_rat_race_base::ref_140f9();
    touchdown_origin();
    thermite_watchstucktoterrain();
    
    if ( getdvarint( "scr_enablePlunderPileOverrides", 0 ) == 1 )
    {
        ref_128a7();
        return;
    }
}

// Params 3
// Size: 0x3f
function ref_12788( var0, var1, var2 )
{
    level endon( "game_ended" );
    level waittill( "prematch_started" );
    
    for ( ;; )
    {
        level waittill( "br_circle_started" );
        var3 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray( level.players, level.questinfo.defaultfilter );
        scripts\mp\gametypes\br_analytics::destroy_jammer_relocate( var3 );
    }
}

// Params 0
// Size: 0x47
function ref_1278d()
{
    var0 = getdvarint( "scr_br_plunder_start_amount", 0 );
    
    if ( !var0 )
    {
        return;
    }
    
    level waittill( "infils_ready" );
    
    foreach ( var2 in level.players )
    {
        playersetplundercount( var2, var0 );
    }
}

// Params 2
// Size: 0x2b
function ref_11c91( var0, var1 )
{
    if ( level.br_plunder_enabled )
    {
        level.br_plunder.vehicle_collision_updateinstance[ var0 ] += var1;
        return;
    }
}

// Params 0
// Size: 0x30b
function setupquantities()
{
    level.br_plunder.ref_12954 = [];
    level.br_plunder.names = [];
    level.br_plunder.vehicle_collision_updateinstance = [];
    
    foreach ( var2, var1 in level.br_pickups.counts )
    {
        if ( !issubstr( var2, "brloot_plunder_cash" ) )
        {
            continue;
        }
        
        level.br_plunder.names[ level.br_plunder.names.size ] = var2;
    }
    
    for ( var3 = 0; var3 < level.br_plunder.names.size ; var3++ )
    {
        level.br_plunder.ref_12954[ var3 ] = level.br_pickups.counts[ level.br_plunder.names[ var3 ] ];
    }
    
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_common_1" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_common_1" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_uncommon_1" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_uncommon_1" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_uncommon_2" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_uncommon_2" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_uncommon_3" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_uncommon_3" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_rare_1" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_rare_1" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_rare_2" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_rare_2" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_epic_1" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_epic_1" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_epic_2" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_epic_2" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_plunder_cash_legendary_1" ] = getscriptablelootspawnedcountbyrarity( "brloot_plunder_cash_legendary_1" );
    level.br_plunder.vehicle_collision_updateinstance[ "br_loot_cache" ] = getscriptablelootspawnedcountbyrarity( "br_loot_cache" );
    level.br_plunder.vehicle_collision_updateinstance[ "brloot_mission_tablet" ] = getscriptablelootspawnedcountbyrarity( "brloot_mission_tablet" );
    
    foreach ( var2, var1 in level.br_plunder.names )
    {
        if ( !isdefined( level.br_plunder.ref_12954[ var2 ] ) )
        {
            level.br_plunder.vehicle_collision_updateinstance[ var2 ] = getscriptablelootspawnedcountbyrarity( var2 );
        }
    }
    
    if ( level.br_plunder.names.size <= 1 )
    {
        return;
    }
    
    var5 = 0;
    
    while ( var5 == 0 )
    {
        var5 = 1;
        
        for ( var3 = 0; var3 < level.br_plunder.names.size - 1 ; var3++ )
        {
            if ( level.br_plunder.ref_12954[ var3 ] > level.br_plunder.ref_12954[ var3 + 1 ] )
            {
                var5 = 0;
                var6 = level.br_plunder.ref_12954[ var3 ];
                level.br_plunder.ref_12954[ var3 ] = level.br_plunder.ref_12954[ var3 + 1 ];
                level.br_plunder.ref_12954[ var3 + 1 ] = var6;
                var7 = level.br_plunder.names[ var3 ];
                level.br_plunder.names[ var3 ] = level.br_plunder.names[ var3 + 1 ];
                level.br_plunder.names[ var3 + 1 ] = var7;
            }
        }
    }
}

// Params 0
// Size: 0x61
function tracegroundheightexfil()
{
    game[ "dialog" ][ "plunder_extract_requested" ] = "plunder_plunder_extract_requested";
    game[ "dialog" ][ "plunder_extract_chopper_arrive" ] = "plunder_plunder_extract_chopper_arrive";
    game[ "dialog" ][ "plunder_extract_chopper_leave" ] = "plunder_plunder_extract_chopper_leave";
    game[ "dialog" ][ "plunder_extract_success" ] = "plunder_plunder_extract_success";
    game[ "dialog" ][ "plunder_extract_fail_chopper" ] = "plunder_plunder_extract_fail_chopper";
}

// Params 0
// Size: 0x14
function toggle_wind()
{
    level.ref_127c5 = getentarray( "extract_pad", "targetname" );
}

// Params 0
// Size: 0x3e
function playerplaybankanim()
{
    if ( self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() )
    {
        return;
    }
    
    scripts\mp\gametypes\br_public::ref_12616( "iw8_ges_plyr_cash_handoff", 1.84 );
}

// Params 0
// Size: 0x3e
function playerremoveplunderfrominventory()
{
    foreach ( var1 in self.br_inventory_slots )
    {
        if ( var1.scriptablename == "brloot_plunder_cash_uncommon_1" )
        {
            scripts\mp\gametypes\br_public::removeitemfrominventory( var2 );
            return;
        }
    }
}

// Params 1
// Size: 0x3c
function disablealldepotsforplayer( var0 )
{
    for ( var1 = 0; var1 < level.br_depots.size ; var1++ )
    {
        var2 = level.br_depots[ var1 ];
        
        if ( isdefined( var2 ) && !istrue( var2.disabled ) )
        {
            depotmakeunusabletoplayer( var2, var0 );
        }
    }
}

// Params 1
// Size: 0x3c
function enablealldepotsforplayer( var0 )
{
    for ( var1 = 0; var1 < level.br_depots.size ; var1++ )
    {
        var2 = level.br_depots[ var1 ];
        
        if ( isdefined( var2 ) && !istrue( var2.disabled ) )
        {
            depotmakeusabletoplayer( var2, var0 );
        }
    }
}

// Params 1
// Size: 0x20
function depotmakeusabletoplayer( var0 )
{
    self enableplayeruse( var0 );
    
    if ( isdefined( self.objectiveiconid ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, var0 );
        return;
    }
}

// Params 1
// Size: 0x20
function depotmakeunusabletoplayer( var0 )
{
    self disableplayeruse( var0 );
    
    if ( isdefined( self.objectiveiconid ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, var0 );
        return;
    }
}

// Params 0
// Size: 0x27
function depotmakeunsabletoall()
{
    self makeunusable();
    
    if ( isdefined( self.objectiveiconid ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
        scripts\mp\objidpoolmanager::returnobjectiveid( self.objectiveiconid );
        return;
    }
}

// Params 0
// Size: 0x4b
function initplayer()
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    if ( !isdefined( self.plundercount ) )
    {
        self.plundercount = 0;
    }
    
    if ( !isdefined( self.plunderbanked ) )
    {
        self.plunderbanked = 0;
    }
    
    if ( !isdefined( self.haspickedupplunderyet ) )
    {
        self.haspickedupplunderyet = 0;
    }
    
    if ( self.plundercount == 0 )
    {
        playersetplundercount( 0 );
        return;
    }
}

// Params 0
// Size: 0x13
function playerdropplunder()
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    playersetplundercount( 0 );
}

// Params 0
// Size: 0x54
function bankplunderongameended()
{
    level waittill( "game_ended" );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1.plundercount ) && var1.plundercount > 0 )
        {
            ref_12618( var1, var1.plundercount );
        }
    }
}

// Params 2
// Size: 0xb7
function playerdropplunderondeath( var0, var1 )
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    if ( istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "playerDropPlunderOnDeath", var0, var1 ) ) )
    {
        return;
    }
    
    var2 = level.delete_on_track_delete + level.delete_on_unloaded + level.delete_on_exit_icon_trigger_pre_race;
    var3 = level.delete_on_track_delete / var2;
    var4 = level.delete_on_unloaded / var2;
    var5 = level.delete_on_exit_icon_trigger_pre_race / var2;
    
    if ( isdefined( self.plundercount ) && self.plundercount > 0 )
    {
        var6 = self.plundercount;
    }
    else
    {
        var6 = 0;
    }
    
    var7 = int( min( var6, max( 2, int( var6 * var4 ) ) ) + 0.5 );
    var8 = int( max( 1, int( var6 * var6 ) ) );
    self.plundercountondeath = var7;
    playersetplundercount( var7 );
    
    if ( var8 <= 0 )
    {
        return;
    }
    
    ml_p3_func( var8, var1 );
}

// Params 1
// Size: 0xea
function takeplunderpickup( var0 )
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    var1 = 1;
    
    if ( isdefined( var0.count ) )
    {
        var1 = var0.count;
    }
    
    if ( var1 < 0 )
    {
        scripts\mp\utility\script::laststand_dogtags( "takePlunderPickup - amount less than 0: " + var1 + ", pickupEnt.scriptableName: " + var0.scriptablename );
    }
    
    if ( scripts\engine\utility::array_contains( level.br_plunder.names, var0.scriptablename ) )
    {
        ref_12627( var1 );
        level.br_plunder.ref_12790 += 1;
        level.br_plunder.ref_127ad += var1;
        ref_11c91( var0.scriptablename, -1 );
        var2 = "loot";
        
        if ( isdefined( var0.tracknonoobplayerlocation.ref_11a40 ) )
        {
            var2 = var0.tracknonoobplayerlocation.ref_11a40;
        }
        
        scripts\mp\gametypes\br_analytics::ref_13c44( self, var2, var1 );
        return;
    }
    
    scripts\mp\gametypes\br_pickups::trypickupitem( var0.scriptablename, var1 );
}

// Params 1
// Size: 0x21
function registerpostplundercallback( var0 )
{
    if ( !isdefined( level.∫f3H◊3Î®•vtµ≥æ®ö∫Ä_™ ) )
    {
        level.∫f3H◊3Î®•vtµ≥æ®ö∫Ä_™ = [];
    }
    
    level.∫f3H◊3Î®•vtµ≥æ®ö∫Ä_™[ level.∫f3H◊3Î®•vtµ≥æ®ö∫Ä_™.size ] = var0;
}

// Params 0
// Size: 0x67
function toggle_trap()
{
    var0 = [];
    GscBinSkip0( 0x2e, 1, "ui_br_plunder_pickedup" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 2
// Size: 0x10
function ref_12627( var0, var1 )
{
    return ref_1261f( var0, 1, undefined, var1 );
}

// Params 3
// Size: 0x11
function playerplundersteal( var0, var1, var2 )
{
    return ref_1261f( var0, 8, var1, var2 );
}

// Params 3
// Size: 0x11
function ref_1261c( var0, var1, var2 )
{
    return ref_1261f( var0, 2, var1, var2 );
}

// Params 3
// Size: 0x11
function ref_12618( var0, var1, var2 )
{
    return ref_1261f( var0, 3, var1, var2 );
}

// Params 2
// Size: 0x10
function ref_12623( var0, var1 )
{
    return ref_1261f( var0, 4, undefined, var1 );
}

// Params 3
// Size: 0x11
function ref_1261a( var0, var1, var2 )
{
    return ref_1261f( var0, 5, var1, var2 );
}

// Params 3
// Size: 0x11
function ref_12625( var0, var1, var2 )
{
    return ref_1261f( var0, 6, var1, var2 );
}

// Params 2
// Size: 0x10
function ref_12622( var0, var1 )
{
    return ref_1261f( var0, 4, undefined, var1 );
}

// Params 2
// Size: 0x10
function ref_1261e( var0, var1 )
{
    return ref_1261f( var0, 4, undefined, var1 );
}

// Params 4
// Size: 0x37b
function ref_1261f( var0, var1, var2, var3 )
{
    if ( !istrue( level.br_plunder_enabled ) || !isdefined( self.plundercount ) )
    {
        return;
    }
    
    if ( var1 == 7 )
    {
        if ( self.team == var2.team )
        {
            var1 = 2;
        }
        else
        {
            var1 = 8;
        }
    }
    
    if ( var0 < 0 )
    {
        scripts\mp\utility\script::laststand_dogtags( "playerPlunderEvent - amount less than 0: " + var0 + ", type: " + var1 );
    }
    
    if ( var1 == 2 || var1 == 3 || var1 == 4 )
    {
        var0 = int( min( self.plundercount, var0 ) );
    }
    else if ( var1 == 8 )
    {
        var0 = int( min( var2.ref_127d0, var0 ) );
    }
    
    if ( !isdefined( self.ref_127b8 ) )
    {
        self.ref_127b8 = [];
    }
    
    if ( !isdefined( self.ref_127b9 ) )
    {
        self.ref_127b9 = [];
    }
    
    if ( !isdefined( self.warningclearcallbacks ) )
    {
        self.warningclearcallbacks = 0;
    }
    
    var5 = scripts\engine\utility::ter_op( var1 == 5, 3, var1 );
    var6 = level.ref_12621[ var5 ];
    var7 = self.ref_127b9[ var1 ];
    var8 = self.ref_127b8[ var1 ];
    
    if ( !isdefined( var8 ) || gettime() - var8 > 2000 )
    {
        var7 = 0;
    }
    
    var7 += var0;
    
    if ( isplayer( self ) && isdefined( var6 ) )
    {
        var9 = int( min( var7, self.plundercount + var0 ) );
        self setclientomnvar( var6, var9 );
    }
    
    self.warningclearcallbacks = var1;
    self.ref_127b8[ var1 ] = gettime();
    self.ref_127b9[ var1 ] = var7;
    var10 = level.ref_12620[ var1 ];
    
    if ( isdefined( var10 ) )
    {
        var3 = self [[ var10 ]]( var0, var2, var3 );
    }
    
    if ( isdefined( var3 ) )
    {
        if ( isdefined( var3.player ) && !var3.player scripts\mp\gametypes\br_public::isplayeringulag() )
        {
            if ( isdefined( var3.ref_126af ) && var3.ref_126af != "none" )
            {
                if ( var3.ref_126af != "br_plunder_first_pickup" || !istrue( var3.player.haspickedupplunderyet ) )
                {
                    if ( isdefined( level.ref_127cd ) )
                    {
                        if ( var0 + self.plundercount > level.ref_127cd )
                        {
                            var3.player thread scripts\mp\hud_message::showsplash( var3.ref_126af );
                            
                            if ( var3.ref_126af == "br_plunder_first_pickup" )
                            {
                                var3.player.haspickedupplunderyet = 1;
                            }
                        }
                    }
                    else
                    {
                        var3.player thread scripts\mp\hud_message::showsplash( var3.ref_126af );
                        
                        if ( var3.ref_126af == "br_plunder_first_pickup" )
                        {
                            var3.player.haspickedupplunderyet = 1;
                        }
                    }
                }
            }
            
            if ( isdefined( var3.ref_12667 ) && ( !isdefined( var3.ref_12668 ) || var3.ref_12668 > 0 ) )
            {
                var3.player thread scripts\mp\utility\points::giveunifiedpoints( var3.ref_12667, undefined, var3.ref_12668 );
            }
        }
        
        if ( istrue( var3.ref_1244d ) )
        {
            if ( var1 == 3 )
            {
                thread playerplaybankanim();
            }
            else if ( var1 == 2 || var1 == 8 )
            {
                thread ref_12615();
            }
        }
        
        if ( isdefined( var3.amount ) )
        {
            var0 = var3.amount;
        }
        
        if ( istrue( var3.ref_1275c ) )
        {
            var11 = scripts\engine\utility::ter_op( isdefined( var3.ref_127cc ), var3.ref_127cc, var0 );
            ref_1275d( self, var11 );
        }
    }
    
    switch ( var1 )
    {
        case 4:
        case 3:
        case 2:
            var0 *= -1;
            break;
        case 8:
        case 6:
        case 5:
            var0 = 0;
            break;
        case 1:
            break;
    }
    
    if ( isdefined( var0 ) )
    {
        var3.ref_127b4 = var0;
        thread playersetplundercount( self.plundercount + var0, var3 );
    }
    
    scripts\mp\gametypes\br_gametype_dmz::ref_121b6();
    return var3;
}

// Params 1
// Size: 0x58
function ref_140d2( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    switch ( var0 )
    {
        case 8:
        case 7:
        case 6:
        case 5:
        case 4:
        case 3:
        case 2:
        case 1:
            return 1;
        default:
            return 0;
    }
}

// Params 3
// Size: 0x37
function ref_12628( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars( self );
    }
    
    if ( !istrue( self.haspickedupplunderyet ) )
    {
        var2.ref_126af = "br_plunder_first_pickup";
        thread scripts\mp\gametypes\br_armory_kiosk::ref_1334a();
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_12060( var0 );
    return var2;
}

// Params 3
// Size: 0x90
function playerplunderstealcallback( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars( self );
    }
    
    if ( !isdefined( var2.ref_1275c ) )
    {
        var2.ref_1275c = 1;
        var2.ref_127cc = undefined;
    }
    
    if ( !isdefined( var2.ref_1244d ) )
    {
        var2.ref_1244d = 1;
    }
    
    if ( isdefined( var1 ) )
    {
        var3 = ref_1278c( var1.ref_127c8 );
        thread scripts\mp\gametypes\br::ref_13ac7( "br_gametype_rat_race_your_team_stole_from_enemy_base", undefined, self.team );
        thread scripts\mp\gametypes\br::ref_13ac7( "br_gametype_rat_race_enemy_stole_from_your_base", undefined, var1.team );
        entityplunderlosedeposited( var1, var0, 1, var3.ö>#{ãR≈¿´ÖÀ@†KËïÎßÁ5Àú®1:U{h/æ_/Q, var2 );
    }
    
    return var2;
}

// Params 3
// Size: 0x1db
function ref_1261d( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars( self );
    }
    
    if ( !isdefined( var2.ref_1275c ) )
    {
        var2.ref_1275c = 1;
        var2.ref_127cc = undefined;
    }
    
    if ( !isdefined( var2.ref_1244d ) )
    {
        var2.ref_1244d = 1;
    }
    
    if ( isdefined( var1 ) )
    {
        var3 = ref_1278c( var1.ref_127c8 );
        
        if ( isdefined( var3.get_closest_enemy_near_turret ) && var3.get_closest_enemy_near_turret > 0 )
        {
            var4 = var1.ref_127d0 + var0 - var3.get_closest_enemy_near_turret;
            
            if ( var4 >= 0 )
            {
                var0 -= var4;
                
                if ( !istrue( var1.ref_127ae ) )
                {
                    ref_12799( var1 );
                }
            }
        }
        
        var5 = 1;
        
        foreach ( var7 in var1.plunder )
        {
            var8 = var7.player;
            
            if ( isdefined( var8 ) && var8 == self )
            {
                var7.plundercount += var0;
                var5 = 0;
                break;
            }
        }
        
        if ( var5 )
        {
            var7 = spawnstruct();
            var7.player = self;
            var7.team = self.team;
            var7.plundercount = var0;
            var10 = var1.plunder.size;
            
            for ( var11 = 0; var11 < var1.plunder.size ; var11++ )
            {
                if ( !isdefined( var1.plunder[ var11 ] ) )
                {
                    var10 = var11;
                    break;
                }
            }
            
            var1.plunder[ var10 ] = var7;
        }
    }
    
    var2.amount = var0;
    var1.ref_127d0 += var0;
    
    if ( !isdefined( level.teamdata[ self.team ][ "plunderInDeposit" ] ) )
    {
        level.teamdata[ self.team ][ "plunderInDeposit" ] = int( var0 );
    }
    else
    {
        level.teamdata[ self.team ][ "plunderInDeposit" ] = level.teamdata[ self.team ][ "plunderInDeposit" ] + int( var0 );
    }
    
    return var2;
}

// Params 3
// Size: 0x1b9
function ref_12619( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars( self );
    }
    
    if ( !isdefined( var2.ref_126af ) )
    {
        var2.ref_126af = "br_plunder_banked";
    }
    
    if ( !isdefined( var2.ref_12667 ) )
    {
        var2.ref_12667 = scripts\engine\utility::ter_op( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" || getdvar( "scr_br_gametype", "" ) == "gold_war", "plunder_cash_blood_money", "plunder_cash" );
    }
    
    if ( !isdefined( var2.ref_12668 ) )
    {
        var2.ref_12668 = int( scripts\mp\rank::getscoreinfovalue( var2.ref_12667 ) * var0 / 10 );
    }
    
    if ( !isdefined( var2.ref_1275c ) )
    {
        var2.ref_1275c = 1;
        var2.ref_127cc = undefined;
    }
    
    if ( !isdefined( var2.ref_1244d ) )
    {
        var2.ref_1244d = 1;
    }
    
    self.plunderbanked += var0;
    
    if ( self.plunderbanked > level.br_plunder.ref_127bf )
    {
        self.plunderbanked = level.br_plunder.ref_127bf;
    }
    
    if ( !isdefined( level.teamdata[ self.team ][ "plunderBanked" ] ) )
    {
        level.teamdata[ self.team ][ "plunderBanked" ] = var0;
    }
    else
    {
        level.teamdata[ self.team ][ "plunderBanked" ] = level.teamdata[ self.team ][ "plunderBanked" ] + var0;
    }
    
    foreach ( var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex ) )
    {
        var4 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "dmz_bank", var0 );
    }
    
    return var2;
}

// Params 3
// Size: 0x14
function ref_12624( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars( self );
    }
    
    return var2;
}

// Params 3
// Size: 0x22d
function ref_1261b( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars( self );
    }
    
    if ( !isdefined( var2.ref_127cc ) )
    {
        var2.ref_127cc = 0;
    }
    
    var2.ref_131ab = 1;
    var3 = self.team;
    
    if ( isdefined( var1 ) && isdefined( var1.plunder ) )
    {
        foreach ( var5 in var1.plunder )
        {
            if ( isdefined( var5.player ) && var5.player == self )
            {
                var3 = var5.team;
                
                if ( !isdefined( var0 ) )
                {
                    var0 = var5.plundercount;
                }
                else
                {
                    var0 = min( var0, var5.plundercount );
                }
                
                var5.plundercount -= var0;
                
                if ( var5.plundercount == 0 )
                {
                    var1.plunder[ var6 ] = undefined;
                }
                
                self.plunderbanked += var0;
                
                if ( self.plunderbanked > level.br_plunder.ref_127bf )
                {
                    self.plunderbanked = level.br_plunder.ref_127bf;
                }
                
                break;
            }
        }
        
        if ( !isdefined( var2.ref_12667 ) )
        {
            var2.ref_12667 = scripts\engine\utility::ter_op( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" || getdvar( "scr_br_gametype", "" ) == "gold_war", "plunder_cash_blood_money", "plunder_cash" );
        }
        
        if ( !isdefined( var2.ref_12668 ) )
        {
            var2.ref_12668 = int( scripts\mp\rank::getscoreinfovalue( var2.ref_12667 ) * var0 / 10 );
        }
    }
    
    var0 = int( var0 );
    level.teamdata[ var3 ][ "plunderInDeposit" ] = level.teamdata[ var3 ][ "plunderInDeposit" ] - var0;
    level.teamdata[ var3 ][ "plunderBanked" ] = level.teamdata[ var3 ][ "plunderBanked" ] + var0;
    
    foreach ( var8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex ) )
    {
        var8 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "dmz_bank", var0 );
    }
    
    return var2;
}

// Params 3
// Size: 0xef
function ref_12626( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars( self );
    }
    
    var2.ref_131ab = 1;
    var3 = self.team;
    
    if ( isdefined( var1 ) && isdefined( var1.plunder ) )
    {
        foreach ( var5 in var1.plunder )
        {
            if ( isdefined( var5.player ) && var5.player == self )
            {
                var3 = var5.team;
                
                if ( !isdefined( var0 ) )
                {
                    var0 = var5.plundercount;
                }
                else
                {
                    var0 = min( var0, var5.plundercount );
                }
                
                var5.plundercount -= var0;
                
                if ( var5.plundercount == 0 )
                {
                    var1.plunder[ var6 ] = undefined;
                }
                
                break;
            }
        }
    }
    
    var0 = int( var0 );
    level.teamdata[ var3 ][ "plunderInDeposit" ] = level.teamdata[ var3 ][ "plunderInDeposit" ] - var0;
    return var2;
}

// Params 1
// Size: 0x253
function num_players_in_safehouse( var0 )
{
    var1 = istrue( level.¢ã#“‹Öâ6+8±’‹2≤'â¬7≠KÕù );
    
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = init_subway_cars();
    }
    
    var0.brwatchforminplayersmatchstart = 0;
    var0.teams = [];
    var0.ref_11f3a = 0;
    
    foreach ( var3 in self.plunder )
    {
        if ( isdefined( var3.player ) || var3.plundercount <= 0 )
        {
            continue;
        }
        
        var4 = var3.team;
        var5 = var3.plundercount;
        
        if ( !var1 )
        {
            level.teamdata[ var4 ][ "plunderInDeposit" ] = level.teamdata[ var4 ][ "plunderInDeposit" ] - var5;
            level.teamdata[ var4 ][ "plunderBanked" ] = level.teamdata[ var4 ][ "plunderBanked" ] + var5;
        }
        
        var0.brwatchforminplayersmatchstart += var5;
        var0.teams[ var0.teams.size ] = var4;
        self.plunder[ var6 ] = undefined;
    }
    
    foreach ( var3 in self.plunder )
    {
        if ( var3.plundercount <= 0 )
        {
            continue;
        }
        
        var8 = var3.player;
        var4 = var3.team;
        var5 = var3.plundercount;
        var9 = undefined;
        
        if ( isdefined( var0 ) )
        {
            var9 = ignoregulagredeploysplash( var0, var8, var4 );
        }
        
        if ( !var1 )
        {
            var9 = ref_1261a( var8, var5, self, var9 );
        }
        
        if ( isdefined( var9 ) && isdefined( var9.amount ) )
        {
            var5 = var9.amount;
        }
        
        var0.brwatchforminplayersmatchstart += var5;
        var0.teams[ var0.teams.size ] = var4;
        var0.ref_11f3a++;
    }
    
    var0.teams = scripts\engine\utility::array_remove_duplicates( var0.teams );
    var11 = 0;
    
    if ( var0.teams.size > 1 )
    {
        var11 = 1;
    }
    else if ( var0.teams.size == 1 && var0.teams[ 0 ] != self.team )
    {
        var11 = 1;
    }
    
    var12 = ref_1278c( self.ref_127c8, undefined, 1 );
    
    if ( isdefined( var12 ) && isdefined( var12.outline_enemy_ai_for_duration ) )
    {
        scripts\mp\gametypes\br_analytics::detonatefx( var0.ref_11f3a, var0.brwatchforminplayersmatchstart, var12.outline_enemy_ai_for_duration, var11, self.origin );
    }
    
    self.plunder = [];
    return var0;
}

// Params 4
// Size: 0x23b
function entityplunderlosedeposited( var0, var1, var2, var3 )
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = init_subway_cars();
    }
    
    var3.brwatchforminplayersmatchstart = 0;
    var3.teams = [];
    var4 = var0;
    
    foreach ( var6 in self.plunder )
    {
        if ( var4 <= 0 )
        {
            break;
        }
        
        if ( isdefined( var6.player ) || var6.plundercount <= 0 )
        {
            continue;
        }
        
        var7 = var6.team;
        var8 = min( var6.plundercount, var4 );
        var6.plundercount -= var8;
        level.teamdata[ var7 ][ "plunderInDeposit" ] = level.teamdata[ var7 ][ "plunderInDeposit" ] - var8;
        var4 -= var8;
        self.ref_127d0 -= var8;
        var3.brwatchforminplayersmatchstart += var8;
        var3.teams[ var3.teams.size ] = var7;
        
        if ( var6.plundercount == 0 )
        {
            self.plunder[ var9 ] = undefined;
        }
    }
    
    foreach ( var6 in self.plunder )
    {
        if ( var4 <= 0 )
        {
            break;
        }
        
        if ( var6.plundercount <= 0 )
        {
            continue;
        }
        
        var11 = var6.player;
        var7 = var6.team;
        var8 = min( var6.plundercount, var4 );
        var12 = undefined;
        
        if ( isdefined( var3 ) )
        {
            var12 = ignoregulagredeploysplash( var3, var11, var7 );
        }
        
        ref_12625( var11, var8, self, var12 );
        
        if ( isdefined( var12 ) && isdefined( var12.amount ) )
        {
            var8 = var12.amount;
        }
        
        var4 -= var8;
        self.ref_127d0 -= var8;
        var3.brwatchforminplayersmatchstart += var8;
        var3.teams[ var3.teams.size ] = var7;
    }
    
    if ( istrue( var1 ) )
    {
        var14 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        dropplunderbyrarity( var0, var14, var2 );
    }
    
    if ( self.ref_127d0 <= 0 )
    {
        self.ref_127d0 = 0;
        var3.amount = 0;
    }
    
    if ( level.teamdata[ self.team ][ "plunderInDeposit" ] < 0 )
    {
        level.teamdata[ self.team ][ "plunderInDeposit" ] = 0;
    }
    
    return var3;
}

// Params 3
// Size: 0x1a9
function num_rocket_per_attack( var0, var1, var2 )
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = init_subway_cars();
    }
    
    var2.brwatchforminplayersmatchstart = 0;
    var2.teams = [];
    var3 = 0;
    
    foreach ( var5 in self.plunder )
    {
        if ( isdefined( var5.player ) || var5.plundercount <= 0 )
        {
            continue;
        }
        
        var6 = var5.team;
        var7 = var5.plundercount;
        level.teamdata[ var6 ][ "plunderInDeposit" ] = level.teamdata[ var6 ][ "plunderInDeposit" ] - var7;
        var2.brwatchforminplayersmatchstart += var7;
        var2.teams[ var2.teams.size ] = var6;
        self.plunder[ var8 ] = undefined;
    }
    
    foreach ( var5 in self.plunder )
    {
        if ( var5.plundercount <= 0 )
        {
            continue;
        }
        
        var10 = var5.player;
        var6 = var5.team;
        var7 = var5.plundercount;
        var11 = undefined;
        
        if ( isdefined( var2 ) )
        {
            var11 = ignoregulagredeploysplash( var2, var10, var6 );
        }
        
        ref_12625( var10, var7, self, var11 );
        
        if ( isdefined( var11 ) && isdefined( var11.amount ) )
        {
            var7 = var11.amount;
        }
        
        var2.brwatchforminplayersmatchstart += var7;
        var2.teams[ var2.teams.size ] = var6;
        var3 += var7;
    }
    
    self.plunder = [];
    
    if ( istrue( var0 ) )
    {
        var13 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        dropplunderbyrarity( var2.brwatchforminplayersmatchstart, var13, var1 );
    }
    
    return var2;
}

// Params 2
// Size: 0x52
function init_subway_cars( var0, var1 )
{
    var2 = spawnstruct();
    var2.player = undefined;
    
    if ( isdefined( var0 ) )
    {
        var2.player = var0;
    }
    
    var2.ref_126af = undefined;
    var2.ref_12667 = undefined;
    var2.ref_12668 = undefined;
    var2.ref_131ab = undefined;
    var2.ref_1275c = undefined;
    var2.ref_127cc = undefined;
    var2.ref_1244d = undefined;
    return var2;
}

// Params 3
// Size: 0xfa
function ignoregulagredeploysplash( var0, var1, var2 )
{
    var3 = init_subway_cars();
    
    if ( isdefined( var0.player ) )
    {
        var3.player = var0.player;
        var1 = var0.player;
    }
    else if ( isdefined( var1 ) )
    {
        var3.player = var1;
    }
    
    if ( isdefined( var0.ref_126af ) )
    {
        var3.ref_126af = var0.ref_126af;
    }
    
    if ( isdefined( var0.ref_12667 ) )
    {
        var3.ref_12667 = var0.ref_12667;
    }
    
    if ( isdefined( var0.ref_12668 ) )
    {
        var3.ref_12668 = var0.ref_12668;
    }
    
    if ( isdefined( var0.ref_131ab ) )
    {
        var3.ref_131ab = var0.ref_131ab;
    }
    
    if ( isdefined( var0.ref_1275c ) )
    {
        var3.ref_1275c = var0.ref_1275c;
    }
    
    if ( isdefined( var0.ref_127cc ) )
    {
        var3.ref_127cc = var0.ref_127cc;
    }
    
    if ( isdefined( var0.ref_1244d ) )
    {
        var3.ref_1244d = var0.ref_1244d;
    }
    
    return var3;
}

// Params 2
// Size: 0x1c6
function playersetplundercount( var0, var1 )
{
    if ( !isdefined( self.plundercount ) )
    {
        self.plundercount = 0;
    }
    
    var2 = self.plundercount;
    var3 = var0 - self.plundercount;
    
    if ( ( !isdefined( var1 ) || !istrue( var1.ref_131ab ) ) && var3 == 0 )
    {
        return;
    }
    
    self.plundercount = var0;
    
    if ( self.plundercount > level.br_plunder.ref_127bf )
    {
        scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED" );
        self.plundercount = level.br_plunder.ref_127bf;
    }
    
    if ( isdefined( self.petwatch ) )
    {
        scripts\cp_mp\pet_watch::ref_1206d();
    }
    
    var4 = self.plundercount;
    ref_1268a( var4 );
    
    if ( var0 > 0 )
    {
        if ( istrue( level.ref_127d4 ) && var3 != 0 )
        {
            ref_12781( self, 1, 1 );
        }
        
        enablealldepotsforplayer( self );
        
        if ( inplunderlivelobby() && var0 >= 10 )
        {
            thread playerdelayautobankplunder();
        }
    }
    else
    {
        if ( istrue( level.ref_127d4 ) && var3 != 0 )
        {
            ref_12781( self, 0, 1 );
        }
        
        disablealldepotsforplayer( self );
    }
    
    if ( isdefined( level.teamdata[ self.team ][ "plunderTeamTotal" ] ) && isdefined( var1 ) && isdefined( var1.ref_127b4 ) )
    {
        if ( getdvar( "scr_br_gametype", "" ) == "rat_race" )
        {
            level.teamdata[ self.team ][ "plunderTeamTotal" ] = level.teamdata[ self.team ][ "plunderTeamTotal" ] + self.plundercount - var2;
        }
        else
        {
            level.teamdata[ self.team ][ "plunderTeamTotal" ] = level.teamdata[ self.team ][ "plunderTeamTotal" ] + var1.ref_127b4;
        }
    }
    
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "postPlunder", var1 );
    
    if ( isdefined( level.∫f3H◊3Î®•vtµ≥æ®ö∫Ä_™ ) )
    {
        foreach ( var6 in level.∫f3H◊3Î®•vtµ≥æ®ö∫Ä_™ )
        {
            [[ var6 ]]( var1 );
        }
        
        return;
    }
}

// Params 1
// Size: 0xa1
function ref_1268a( var0 )
{
    var1 = ref_12577();
    var2 = var1[ 0 ];
    var3 = var1[ 1 ];
    var4 = var1[ 2 ];
    var1 = undefined;
    var5 = scripts\mp\gametypes\br_public::round_at_max( self.team, self.squadindex, var4 );
    
    if ( !isdefined( var5 ) )
    {
        var5 = 0;
    }
    
    var6 = respawn_used_once( var0, var5, var2, var3 );
    scripts\mp\gametypes\br_public::ref_131c3( self.team, self.squadindex, var4, var6 );
    var7 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
    
    foreach ( var9 in var7 )
    {
        if ( isbot( var9 ) && scripts\mp\gametypes\br_public::validtousesticker() )
        {
            continue;
        }
        
        var9 setclientomnvar( var4, var6 );
    }
}

// Params 4
// Size: 0x2e
function respawn_used_once( var0, var1, var2, var3 )
{
    var4 = int( pow( 2, var3 ) ) - 1;
    var5 = ( var0 & var4 ) << var2;
    var6 = ~( var4 << var2 );
    var7 = var1 & var6;
    var8 = var7 + var5;
    return var8;
}

// Params 0
// Size: 0xf0
function ref_12577()
{
    var0 = 0;
    var1 = 0;
    var2 = "";
    
    switch ( self.pers[ "squadMemberIndex" ] )
    {
        case 1:
            var3 = [ 0, 16, "ui_br_plunder_count" ];
            var0 = var3[ 0 ];
            var1 = var3[ 1 ];
            var2 = var3[ 2 ];
            var3 = undefined;
            break;
        case 2:
            var4 = [ 16, 16, "ui_br_plunder_count" ];
            var0 = var4[ 0 ];
            var1 = var4[ 1 ];
            var2 = var4[ 2 ];
            var4 = undefined;
            break;
        case 3:
            var5 = [ 0, 16, "ui_br_plunder_count2" ];
            var0 = var5[ 0 ];
            var1 = var5[ 1 ];
            var2 = var5[ 2 ];
            var5 = undefined;
            break;
        case 4:
            var6 = [ 16, 16, "ui_br_plunder_count2" ];
            var0 = var6[ 0 ];
            var1 = var6[ 1 ];
            var2 = var6[ 2 ];
            var6 = undefined;
            break;
        default:
            break;
    }
    
    return [ var0, var1, var2 ];
}

// Params 2
// Size: 0xc2
function dangercircletick( var0, var1 )
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    var2 = var1 * var1;
    
    for ( var3 = 0; var3 < level.br_depots.size ; var3++ )
    {
        var4 = level.br_depots[ var3 ];
        
        if ( isdefined( var4 ) && !istrue( var4.disabled ) && distance2dsquared( var0, var4.origin ) > var2 )
        {
            var4.disabled = 1;
            depotmakeunsabletoall( var4 );
        }
    }
    
    for ( var3 = 0; var3 < level.br_plunder_sites.size ; var3++ )
    {
        var5 = level.br_plunder_sites[ var3 ];
        
        if ( isdefined( var5 ) && !istrue( var5.disabled ) && distance2dsquared( var0, var5.origin ) > var2 )
        {
            var5.disabled = 1;
            var5 setscriptablepartstate( var5.type, var5.load_relics_from_playlistdvars );
        }
    }
}

// Params 0
// Size: 0x2a
function ref_12615()
{
    self endon( "death_or_disconnect" );
    
    if ( !scripts\mp\gametypes\br_public::ref_12518() || self isgestureplaying() )
    {
        return;
    }
    
    scripts\mp\gametypes\br_public::ref_12616( "iw8_ges_plyr_cash_handoff", 1.84 );
}

// Params 0
// Size: 0x54
function cratedropplunder()
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    var0 = 0;
    
    for ( var1 = 0; var1 < self.plunder.size ; var1++ )
    {
        var0 += self.plunder[ var1 ].plundercount;
    }
    
    self.angles = ( 0, 0, 0 );
    var2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    dropplunderbyrarity( var0, var2 );
}

// Params 2
// Size: 0xb8
function dropplundersounds( var0, var1 )
{
    if ( var1 <= 0 )
    {
        return;
    }
    
    var2 = var0 + ( 0, 0, 24 );
    var3 = "";
    wait 0.5;
    
    switch ( var1 )
    {
        case 0:
            break;
        case 1:
            var3 = "br_drop_plunder_01";
            break;
        case 2:
            var3 = "br_drop_plunder_02";
            break;
        case 3:
            var3 = "br_drop_plunder_03";
            break;
        case 4:
            var3 = "br_drop_plunder_04";
            break;
        case 5:
            var3 = "br_drop_plunder_05";
            break;
        case 6:
        default:
            var3 = "br_drop_plunder_06";
            break;
    }
    
    playsoundatpos( var2, var3 );
}

// Params 4
// Size: 0x195
function dropplunderbyrarity( var0, var1, var2, var3 )
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    var4 = [];
    var5 = [];
    var6 = 0;
    var7 = 6;
    
    if ( isdefined( var2 ) )
    {
        var7 = var2;
    }
    
    for ( var8 = level.br_plunder.ref_12954.size - 1; var8 >= 0 ; var8-- )
    {
        var5 = int( var0 / level.br_plunder.ref_12954[ var8 ] );
        var5 = int( clamp( var5[ var8 ], 0, var7 - var6 ) );
        var6 += var5[ var8 ];
        
        if ( var0 <= 0 || var6 >= var7 )
        {
            break;
        }
        
        var0 -= var5[ var8 ] * level.br_plunder.ref_12954[ var8 ];
    }
    
    for ( var9 = level.br_plunder.ref_12954.size - 1; var9 >= 0 ; var9-- )
    {
        if ( !isdefined( var5[ var9 ] ) )
        {
            continue;
        }
        
        for ( var10 = 0; var10 < var5[ var9 ] ; var10++ )
        {
            var11 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var1, self.origin, self.angles, self, var3 );
            var12 = scripts\mp\gametypes\br_pickups::spawnpickup( level.br_plunder.names[ var9 ], var11, level.br_plunder.ref_12954[ var9 ], 1 );
            ref_11c91( level.br_plunder.names[ var9 ], 1 );
            
            if ( isdefined( var12 ) )
            {
                var4 = var12;
                
                if ( inplunderlivelobby() )
                {
                    level.br_plunder_ents[ level.br_plunder_ents.size ] = var12;
                }
            }
        }
    }
    
    level.br_plunder.ref_1278f += var6;
    level.br_plunder.ref_127ac += var0;
    thread dropplundersounds( level, self.origin );
    return var4;
}

// Params 2
// Size: 0xe7
function ml_p3_func( var0, var1 )
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    var2 = [];
    var3 = [];
    var4 = 0;
    
    for ( var5 = level.br_plunder.names.size - 1; var5 >= 0 ; var5-- )
    {
        if ( var0 >= level.br_plunder.ref_12954[ var5 ] )
        {
            var4 = var5;
            break;
        }
    }
    
    var6 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var1, self.origin, self.angles, self );
    var7 = scripts\mp\gametypes\br_pickups::spawnpickup( level.br_plunder.names[ var4 ], var6, var0, 1 );
    ref_11c91( level.br_plunder.names[ var4 ], 1 );
    
    if ( isdefined( var7 ) )
    {
        var2 = var7;
        
        if ( inplunderlivelobby() )
        {
            level.br_plunder_ents[ level.br_plunder_ents.size ] = var7;
        }
    }
    
    level.br_plunder.ref_1278f++;
    level.br_plunder.ref_127ac += var0;
    thread dropplundersounds( level, self.origin );
    return var2;
}

// Params 0
// Size: 0x31, Type: bool
function updateplayerspawninputtype()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "plunderSites" ) )
    {
        return false;
    }
    
    return istrue( level.br_plunder_enabled ) && level.br_plunder_sites.size != 0 && getdvarint( "scr_br_plunder_sites", 0 ) != 0;
}

#using_animtree( "" );

// Params 0
// Size: 0x53
function thermite_linktostuck()
{
    level.scr_anim[ "plunder_extract_heli" ][ "heli_in" ] = %iw8_br_plunder_heli_in;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_loop" ] = $iw8_br_plunder_heli_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_out" ] = %iw8_br_plunder_heli_out;
}

// Params 0
// Size: 0x13c
function thermite_watchglstuck()
{
    level.scr_animtree[ "plunder_extract_heli" ] = #animtree;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_in" ] = $iw8_br_plunder_heli_rope_in;
    level.scr_animname[ "plunder_extract_heli" ][ "rope_in" ] = "iw8_br_plunder_heli_rope_in";
    level.scr_anim[ "plunder_extract_heli" ][ "rope_loop" ] = %iw8_br_plunder_heli_rope_loop;
    level.scr_animname[ "plunder_extract_heli" ][ "rope_loop" ] = "iw8_br_plunder_heli_rope_loop";
    level.scr_anim[ "plunder_extract_heli" ][ "rope_out" ] = %iw8_br_plunder_heli_rope_out;
    level.scr_animname[ "plunder_extract_heli" ][ "rope_out" ] = "iw8_br_plunder_heli_rope_out";
    level.scr_anim[ "plunder_extract_heli" ][ "bag_in" ] = %iw8_br_plunder_heli_bag_in;
    level.scr_animname[ "plunder_extract_heli" ][ "bag_in" ] = "iw8_br_plunder_heli_bag_in";
    level.scr_anim[ "plunder_extract_heli" ][ "bag_loop" ] = %iw8_br_plunder_heli_bag_loop;
    level.scr_animname[ "plunder_extract_heli" ][ "bag_loop" ] = "iw8_br_plunder_heli_bag_loop";
    level.scr_anim[ "plunder_extract_heli" ][ "bag_out" ] = %iw8_br_plunder_heli_bag_out;
    level.scr_animname[ "plunder_extract_heli" ][ "bag_out" ] = "iw8_br_plunder_heli_bag_out";
}

// Params 0
// Size: 0x174
function thermite_watchstucktoterrain()
{
    var0 = [];
    var1 = ref_1278c( "plunderHelipad1", 1 );
    var1.ref_12f7d = "brloot_plunder_extraction_site_01";
    var0 = var1;
    var1 = ref_1278c( "plunderHelipad2", 1 );
    var1.ref_12f7d = "brloot_plunder_extraction_site_02";
    var0 = var1;
    var1 = ref_1278c( "extractHelipadPlunder", 1 );
    var1.ref_12f7d = "brloot_quest_extract_site_plunder";
    var0 = var1;
    var1 = ref_1278c( "extractHelipadBR", 1 );
    var1.ref_12f7d = "brloot_quest_extract_site_br";
    var0 = var1;
    
    foreach ( var1 in var0 )
    {
        var1.type = 1;
        var1.usetime = 0;
        var1.ref_14077 = 3;
        var1.ref_14075 = getdvarint( "scr_plunderHeliUseAmount", 20000 );
        var1.ref_13acc = 0;
        var1.ref_14078 = "MP/CANNOT_DEPOSIT_CASH_HELI_FULL";
        var1.ref_14079 = "MP/CANNOT_DEPOSIT_CASH_HELI_LEAVING";
        var1.ref_12f7e = "activedepositcurrent";
        var1.ref_12f77 = "visiblecurrent";
        var1.origin_delta = 0;
        var1.overrideviewkickscaledmr = getdvarint( "scr_plunderHeliCountdown", 30 );
        var1.original_disablelongdeath = "MP/CASH_HELI_LEAVING_IN_N";
        var1.get_closest_enemy_near_turret = 0;
        var1.impactwatcher = &smokekill;
        var1.org_in_bad_place = &snowfx;
        var1.carriable_error_messsage_watch = &smodelcollections;
        var1.outline_enemy_ai_for_duration = "little_bird";
    }
}

// Params 0
// Size: 0x121
function retrieve_data_objective()
{
    var0 = [];
    
    if ( scripts\cp_mp\utility\game_utility::unlink_on_ai_death() )
    {
        var0 = getentitylessscriptablearrayinradius( "extract_pad", "targetname" );
        var1 = getentitylessscriptablearrayinradius( "extract_pad_boneyard", "targetname" );
        
        if ( var1.size > 0 )
        {
            var0 = scripts\engine\utility::array_combine( var0, var1 );
        }
    }
    else
    {
        var2 = getentitylessscriptablearrayinradius( "plunder_extraction_01", "targetname" );
        var3 = getentitylessscriptablearrayinradius( "plunder_extraction_02", "targetname" );
        var0 = scripts\engine\utility::array_combine( var2, var3 );
    }
    
    if ( var0.size > 0 )
    {
        foreach ( var6, var5 in var0 )
        {
            var5.audio_shf_kill_hangar_lights = "active";
            var5.audio_jugg_spawn = "activeCurrent";
            var5.load_relics_from_playlistdvars = "visible";
            var5.little_bird_onexitheavydamagestate = "visible";
        }
        
        return var0;
    }
    
    var6 = getentitylessscriptablearrayinradius( "plunder_extraction", "targetname" );
    
    foreach ( var5 in var6 )
    {
        var5.audio_shf_kill_hangar_lights = "visible";
        var5.audio_jugg_spawn = "visibleCurrent";
        var5.load_relics_from_playlistdvars = "hidden";
    }
    
    return var6;
}

// Params 0
// Size: 0x22b
function setupplunderextractionsites()
{
    level.br_plunder_sites = retrieve_data_objective();
    level.delete_old_gate = [];
    level.delete_old_gate[ level.delete_old_gate.size ] = "brloot_plunder_extraction_site";
    level.delete_old_gate[ level.delete_old_gate.size ] = "brloot_plunder_extraction_site_01";
    level.delete_old_gate[ level.delete_old_gate.size ] = "brloot_plunder_extraction_site_02";
    level.delete_old_gate[ level.delete_old_gate.size ] = "brloot_quest_extract_site_br";
    level.delete_old_gate[ level.delete_old_gate.size ] = "brloot_quest_extract_site_plunder";
    level.delete_on_death_or_dissconnect = [];
    level.delete_on_death_or_dissconnect[ level.delete_on_death_or_dissconnect.size ] = "active";
    level.delete_on_death_or_dissconnect[ level.delete_on_death_or_dissconnect.size ] = "active2";
    level.delete_on_death_or_dissconnect[ level.delete_on_death_or_dissconnect.size ] = "activecurrent";
    level.delete_on_death_or_dissconnect[ level.delete_on_death_or_dissconnect.size ] = "activecurrentnight";
    level.delete_on_death_or_dissconnect[ level.delete_on_death_or_dissconnect.size ] = "visiblecurrent";
    
    if ( !updateplayerspawninputtype() )
    {
        var0 = getentarray( "plunder_extraction_visual", "targetname" );
        
        foreach ( var2 in var0 )
        {
            var2 delete();
        }
        
        foreach ( var5 in level.br_plunder_sites )
        {
            var5 setscriptablepartstate( var5.type, "hidden" );
        }
        
        level.br_plunder_sites = [];
        return;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    scripts\engine\scriptable::scriptable_addusedcallback( &plundersiteused );
    
    if ( isdefined( level.ref_11b3f ) && level.ref_11b3f > 0 && !istrue( level.ref_14086 ) )
    {
        wait level.ref_11b3f;
    }
    else if ( istrue( level.ref_14086 ) )
    {
        scripts\mp\flags::gameflagwait( "activate_cash_lzs" );
    }
    
    foreach ( var8 in level.players )
    {
        if ( isdefined( var8 ) )
        {
            if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
            {
                var8 scripts\mp\hud_message::showsplash( "bm_extract_heli_start" );
            }
        }
    }
    
    foreach ( var5 in level.br_plunder_sites )
    {
        var11 = scripts\engine\utility::ter_op( istrue( level.ref_13368 ) && !istrue( level.ref_13363 ), var5.audio_jugg_spawn, var5.audio_shf_kill_hangar_lights );
        var5 setscriptablepartstate( var5.type, var11 );
    }
}

// Params 0
// Size: 0x12
function register_vfx()
{
    if ( !updateplayerspawninputtype() )
    {
        return;
    }
    
    var0 = retrieve_data_objective();
    return var0;
}

// Params 1
// Size: 0x4a
function ref_1314b( var0 )
{
    foreach ( var2 in level.br_plunder_sites )
    {
        if ( !scripts\engine\utility::array_contains( var0, var2 ) )
        {
            var2 setscriptablepartstate( var2.type, "hidden" );
        }
    }
    
    level.br_plunder_sites = var0;
}

// Params 1
// Size: 0x6b
function isspecialistbonus( var0 )
{
    var1 = spawn( "script_model", var0.origin + ( 0, 0, 1000 ) );
    var1 setmodel( "veh8_mil_air_mindia8_plunder_x" );
    var2 = var0.origin[ 0 ];
    var3 = var0.origin[ 1 ];
    var4 = 800;
    var5 = tracegroundpoint( var1, var2, var3 );
    var6 = var5 + var4;
    var7 = ( var2, var3, var6 );
    var1.origin = var7;
    
    for ( ;; )
    {
        waitframe();
    }
}

// Params 5
// Size: 0xbd
function plundersiteused( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0 ) || !isdefined( var3 ) )
    {
        return;
    }
    
    if ( !isdefined( level.delete_old_gate ) || !isdefined( level.delete_on_death_or_dissconnect ) )
    {
        return;
    }
    
    var5 = 1;
    
    foreach ( var7 in level.delete_old_gate )
    {
        if ( var7 != var1 )
        {
            continue;
        }
        
        var5 = 0;
        break;
    }
    
    if ( var5 )
    {
        return;
    }
    
    var5 = 1;
    
    foreach ( var10 in level.delete_on_death_or_dissconnect )
    {
        if ( var10 != var2 )
        {
            continue;
        }
        
        var5 = 0;
        break;
    }
    
    if ( var5 )
    {
        return;
    }
    
    thread plundersiteusedinternal( var0, var1, var2, var3 );
}

// Params 4
// Size: 0x1ed
function plundersiteusedinternal( var0, var1, var2, var3 )
{
    if ( isdefined( var0.disabled ) )
    {
        return;
    }
    
    if ( isdefined( var0.heli ) )
    {
        playerdenyextraction( var3, undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        return;
    }
    
    var4 = scripts\engine\utility::ter_op( istrue( level.ref_13368 ) && !istrue( level.ref_13363 ), "inuseCurrent", "inuse" );
    var0 setscriptablepartstate( var0.type, var4 );
    var5 = getgroundposition( var0.origin, 1 ) + ( 0, 0, 2 );
    var6 = playerspawnextractchopper( var3, var5, var0 );
    
    if ( isdefined( var6 ) )
    {
        var6.site = var0;
        var0.heli = var6;
        var0.team = var3.team;
        thread init_trap_room_spawning_module( var5 );
        ref_126c7( var3 );
        
        if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_requested", var3.team, 1 );
        }
        
        level thread scripts\mp\gametypes\br::ref_13ac7( "br_extract_heli_incoming", var3, var3.team );
        thread so_endgame( var6 );
    }
    else
    {
        playerdenyextraction( undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        var4 = scripts\engine\utility::ter_op( istrue( level.ref_13368 ) && !istrue( level.ref_13363 ), var0.audio_jugg_spawn, var0.audio_shf_kill_hangar_lights );
        var0 setscriptablepartstate( var0.type, var4 );
        return;
    }
    
    if ( istrue( level.ref_127ba ) )
    {
        var7 = scripts\common\utility::playersincylinder( var0.origin, 15000 );
        var8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var3.team, var3.squadindex );
        
        foreach ( var10 in var7 )
        {
            if ( !scripts\engine\utility::array_contains( var8, var10 ) )
            {
                var10 thread scripts\mp\hud_message::showsplash( "br_extract_heli_incoming_them", undefined, var3 );
            }
        }
    }
    
    if ( istrue( level.ref_11dad ) )
    {
        var0.disabled = 1;
        var4 = scripts\engine\utility::ter_op( istrue( level.ref_13368 ) && !istrue( level.ref_13363 ), var0.little_bird_onexitheavydamagestate, var0.load_relics_from_playlistdvars );
        var0 setscriptablepartstate( var0.type, var4 );
        level thread scripts\mp\gametypes\br_gametype_dmz::play_tape_machine_animations( var0 );
    }
}

// Params 0
// Size: 0x19
function ref_126c7()
{
    self endon( "death_or_disconnect" );
    scripts\mp\gametypes\br_public::ref_12616( "iw8_ges_plyr_plunder_smoke", 1.867 );
}

// Params 2
// Size: 0x2c
function playerdenyextraction( var0, var1 )
{
    self iprintlnbold( var1 );
    self playlocalsound( "br_pickup_deny" );
    
    if ( isdefined( var0 ) )
    {
        var2 = self getweaponammoclip( var0 );
        self setweaponammoclip( var0, var2 + 1 );
        return;
    }
}

// Params 1
// Size: 0x8d
function init_trap_room_spawning_module( var0 )
{
    wait 1.35;
    var1 = spawn( "script_model", var0 );
    var1 setmodel( "scr_smoke_grenade" );
    var1.angles = ( 0, 90, 90 );
    var1 playsound( "smoke_carepackage_expl_trans" );
    var1 playloopsound( "smoke_carepackage_smoke_lp" );
    var1 setscriptablepartstate( "smoke", "on" );
    wait 17;
    var1 endon( "death" );
    var1 setscriptablepartstate( "smoke", "dissipate" );
    var1 playsound( "smoke_canister_tail_dissipate" );
    wait 1;
    var1 stoploopsound();
    wait 4.5;
    var1 delete();
}

// Params 2
// Size: 0x11e
function playerspawnextractchopper( var0, var1 )
{
    var2 = var0;
    var3 = var2 + ( 0, 0, 2000 );
    var4 = var2 + ( 0, 0, 8000 );
    var5 = var2 + ( 0, 0, 800 );
    var6 = 0;
    var7 = ( 0, 0, 0 );
    var8 = getdvarint( "scr_dmz_plunder_use_structs", 0 );
    
    if ( var8 )
    {
        var9 = relic_squadlink_turn_team_headobjectives( var2 );
        
        if ( isdefined( var9 ) )
        {
            var10 = var9.script_noteworthy;
            var7 = var10.angles;
        }
        else
        {
            var6 = relic_award_one_bullet( var1, var4, var3 );
            var7 = ( 0, var6, 0 );
        }
    }
    else
    {
        var6 = relic_award_one_bullet( var1, var4, var3 );
        var7 = ( 0, var6, 0 );
    }
    
    if ( getdvarint( "scr_br_plunder_heli_adjust_bag", 0 ) == 1 )
    {
        var11 = -100;
        var12 = 60;
        var13 = anglestoforward( var7 );
        var14 = anglestoright( var7 );
        var2 = var2 + var13 * var11 + var14 * var12;
        var3 = var2 + ( 0, 0, 2000 );
        var5 = var2 + ( 0, 0, 800 );
    }
    
    var15 = var4 - anglestoforward( var7 ) * 20000;
    var16 = spawnheli( self, var15, var3, var5, var2 );
    return var16;
}

// Params 1
// Size: 0x4d
function relic_squadlink_turn_team_headobjectives( var0 )
{
    var1 = undefined;
    
    foreach ( var3 in level.ref_127c5 )
    {
        if ( isdefined( var3 ) && distance2dsquared( var3.origin, var0 ) <= 10000 )
        {
            var1 = var3;
            break;
        }
    }
    
    return var1;
}

// Params 3
// Size: 0xad
function relic_award_one_bullet( var0, var1, var2 )
{
    if ( isdefined( var0 ) && isdefined( var0.player_respawn ) )
    {
        return var0.player_respawn;
    }
    
    var3 = 10;
    var4 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1, 0 );
    var5 = 0;
    var6 = 0;
    
    while ( var6 < 360 )
    {
        var5 += var6;
        var7 = ( 0, var5, 0 );
        var8 = var1 - anglestoforward( var7 ) * 20000;
        var9 = var2;
        var10 = scripts\engine\trace::sphere_trace( var8, var9, 100, undefined, var4, 1 );
        
        if ( var10[ "fraction" ] == 1 )
        {
            if ( isdefined( var0 ) )
            {
                var0.player_respawn = var5;
            }
            
            return var5;
        }
        
        if ( var6 % 3 == 0 )
        {
            waitframe();
        }
        
        var6 += var3;
    }
    
    return var5;
}

// Params 1
// Size: 0xe0
function drophelicrate( var0 )
{
    if ( !isdefined( var0.plunder ) )
    {
        return;
    }
    
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_fail_chopper", self.team, 1 );
    ref_12782( self.crate, 0 );
    var1 = self.crate;
    self.crate = undefined;
    var1.plunder = var0.plunder;
    var2 = var1.origin;
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
    num_rocket_per_attack( var1, 1 );
    thread smokinggunprogress( var1 );
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
    var1 = frag_crate_spawn( 20000, 100, 125 );
    var2 = frag_crate_spawn( var0, 25, 31.25 );
    var3 = var1 + var2;
    return var3;
}

// Params 1
// Size: 0x8d
function so_endgame( var0 )
{
    self endon( "death" );
    self endon( "leaving" );
    var1 = self.originalangle[ 2 ];
    var2 = self.lastweaponfiretimeend[ 2 ] - var1;
    self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo( var2 );
    thread heliwatchgameendleave();
    self.ref_1287c = 1;
    helidescend();
    self.ref_1287c = undefined;
    self setscriptablepartstate( "vector_field", "on" );
    
    if ( !istrue( level.gameended ) )
    {
        if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_chopper_arrive", self.team, 1 );
        }
        
        thread sound_distraction_mechanic_init( var0 );
        return;
    }
    
    thread sol_3_4_pool( 1 );
}

// Params 1
// Size: 0xa2
function sound_distraction_mechanic_init( var0 )
{
    var1 = undefined;
    
    if ( var0.type == "brloot_plunder_extraction_site_01" )
    {
        var1 = "plunderHelipad1";
    }
    else if ( var0.type == "brloot_plunder_extraction_site_02" )
    {
        var1 = "plunderHelipad2";
    }
    else if ( var0.type == "brloot_quest_extract_site_plunder" )
    {
        var1 = "extractHelipadPlunder";
    }
    else if ( var0.type == "brloot_quest_extract_site_br" )
    {
        var1 = "extractHelipadBR";
    }
    
    ref_12796( var0, var1 );
    var2 = undefined;
    
    if ( isdefined( self.team ) )
    {
        var2 = scripts\mp\utility\teams::getfriendlyplayers( self.team );
    }
    
    thread ref_127a4( var0, var2 );
    ref_127aa( var0, var2 );
}

// Params 1
// Size: 0x7a
function smoke_door( var0 )
{
    if ( !istrue( level.gameended ) && !scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_success", self.team, 1 );
    }
    
    var1 = num_players_in_safehouse( var0 );
    
    if ( isdefined( var1 ) && isdefined( var1.brwatchforminplayersmatchstart ) && var1.brwatchforminplayersmatchstart > 0 )
    {
        level.br_plunder.oscope_sign_think += var1.brwatchforminplayersmatchstart;
        level.br_plunder.oscope_sign++;
        return;
    }
}

// Params 1
// Size: 0xf2
function ref_13694( var0 )
{
    var1 = spawn( "script_model", ( 0, 0, 0 ) );
    var1 setmodel( "misc_rapelling_rope_01_fiber_br" );
    var1 linkto( var0, "origin_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var1.animname = var0.animname;
    var1 scripts\common\anim::setanimtree();
    var0 scripts\common\anim::anim_first_frame_solo( var1, "rope_in", "origin_animate_jnt" );
    var2 = spawn( "script_model", ( 0, 0, 0 ) );
    var2 setmodel( "br_plunder_extraction_delivery_bag" );
    var2 linkto( var0, "origin_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.animname = var0.animname;
    var2 scripts\common\anim::setanimtree();
    var0 scripts\common\anim::anim_first_frame_solo( var2, "bag_in", "origin_animate_jnt" );
    var0.rope = var1;
    var0.crate = var2;
}

// Params 5
// Size: 0x216
function spawnheli( var0, var1, var2, var3, var4 )
{
    var5 = 1;
    var6 = vectortoangles( var2 * ( 1, 1, 0 ) - var1 * ( 1, 1, 0 ) );
    var7 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter( var0, var1, var6, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x" );
    
    if ( !isdefined( var7 ) )
    {
        return;
    }
    
    var7.damagecallback = &callback_vehicledamage;
    var7.speed = 100;
    var7.accel = 125;
    var7.health = scripts\engine\utility::ter_op( scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war", level.overheatlimit, 1000 );
    var7.maxhealth = var7.health;
    var7.team = var0.team;
    var7.owner = var0;
    var7.lifeid = 0;
    var7.flaresreservecount = var5;
    var7.nuke_vault_riotshield_internal = var1;
    var7.lastweaponfiretimeend = var2;
    var7.spawn_sentries_from_targetname = var3;
    var7.originalangle = var4;
    var7.ref_12ee8 = var6;
    var7.vehiclename = "magma_plunder_chopper";
    var7.animname = "plunder_extract_heli";
    var7 setcandamage( 1 );
    var7 setmaxpitchroll( 10, 25 );
    var7 vehicle_setspeed( var7.speed, var7.accel );
    var7 sethoverparams( 1, 1, 1 );
    var7 setturningability( 0.05 );
    var7 setyawspeed( 45, 25, 25, 0.5 );
    var7 setotherent( var0 );
    var7 setscriptablepartstate( "engine", "on" );
    var7 setscriptablepartstate( "tail_light", "red" );
    var7 setscriptablepartstate( "cockpit_light", "on" );
    var7 setscriptablepartstate( "infil_lights", "on" );
    var7.scenenode = spawn( "script_model", var7.originalangle );
    var7.scenenode.angles = var7.ref_12ee8;
    var7.scenenode setmodel( "tag_origin" );
    var7.scenenode scripts\common\anim::anim_first_frame_solo( var7, "heli_in" );
    ref_13694( var7 );
    return var7;
}

// Params 1
// Size: 0x22
function smokinggunprogress( var0 )
{
    ref_12786( self );
    self hide();
    
    if ( isdefined( var0 ) )
    {
        var0.crate = undefined;
    }
    
    waitframe();
    self delete();
}

// Params 0
// Size: 0xc5
function smuggler_post_tele_kill()
{
    self endon( "heli_gone" );
    var0 = self.owner;
    self waittill( "death", var1, var2, var3, var4 );
    var5 = 0;
    
    if ( isdefined( self.plunder ) )
    {
        foreach ( var7 in self.plunder )
        {
            var5 += var7.plundercount;
        }
    }
    
    scripts\mp\gametypes\br_analytics::detonatefunc( var5, "little_bird", self.originalangle, self.origin );
    thread drophelicrate( self );
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
    
    snowballfighthint( var1 );
}

// Params 0
// Size: 0x3c
function smoke_enemy_think()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        thread smokinggunprogress( self.crate );
    }
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode delete();
        return;
    }
}

// Params 1
// Size: 0xab
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
    level thread scripts\mp\gametypes\br::ref_13ac7( "br_extract_heli_shot_down", self.owner, self.team );
    smuggler_killed_early();
}

// Params 0
// Size: 0xe
function smuggler_killed_early()
{
    smoke_enemy_think();
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle( self );
}

// Params 1
// Size: 0x40
function smokesignal( var0 )
{
    self endon( "explode" );
    self notify( "heli_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( var0, var0, var0 );
}

// Params 13
// Size: 0xfd
function callback_vehicledamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12 )
{
    if ( isdefined( var1 ) )
    {
        if ( isdefined( var1.owner ) )
        {
            var1 = var1.owner;
        }
    }
    
    if ( istrue( level.overheatreductionamount ) )
    {
        return;
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

// Params 1
// Size: 0x140
function sol_3_4_pool( var0 )
{
    if ( istrue( self.ref_13e15 ) || istrue( self.leaving ) )
    {
        return;
    }
    
    self endon( "death" );
    self notify( "try_to_leave" );
    self.ref_13e15 = 1;
    
    if ( !istrue( level.gameended ) && !scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( "plunder_extract_chopper_leave", self.team, 1 );
    }
    
    var1 = self.site;
    
    if ( isdefined( var1 ) )
    {
        ref_1279a( var1 );
        smoke_door( var1 );
        
        if ( isdefined( var1.heli ) && var1.heli == self )
        {
            var1.heli = undefined;
            var1.team = undefined;
            var1 notify( "heli_left" );
        }
        
        thread skip_charge_plant( var1 );
        self.site = undefined;
    }
    
    self.ref_12a47 = 1;
    self waittill( "ready_to_leave" );
    self notify( "leaving" );
    self.leaving = 1;
    self.ref_13e15 = undefined;
    var2 = getanimlength( level.scr_anim[ self.animname ][ "heli_out" ] );
    self.scenenode thread scripts\common\anim::anim_single_solo( self, "heli_out" );
    thread scripts\common\anim::anim_single_solo( self.rope, "rope_out", "origin_animate_jnt" );
    thread scripts\common\anim::anim_single_solo( self.crate, "bag_out", "origin_animate_jnt" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var2 );
    self stoploopsound();
    self notify( "heli_gone" );
    smuggler_killed_early();
}

// Params 1
// Size: 0x5c
function skip_charge_plant( var0 )
{
    var1 = scripts\engine\utility::ter_op( istrue( level.ref_13368 ) && !istrue( level.ref_13363 ), "inuseCurrent", "inuse" );
    self setscriptablepartstate( var0, var1 );
    wait 6;
    
    if ( isdefined( self ) )
    {
        var1 = scripts\engine\utility::ter_op( istrue( level.ref_13368 ) && !istrue( level.ref_13363 ), self.audio_jugg_spawn, self.audio_shf_kill_hangar_lights );
        self setscriptablepartstate( var0, var1 );
        return;
    }
}

// Params 0
// Size: 0x73
function helidescend()
{
    self endon( "death" );
    var0 = getanimlength( level.scr_anim[ self.animname ][ "heli_in" ] );
    self.scenenode thread scripts\common\anim::anim_single_solo( self, "heli_in" );
    thread scripts\common\anim::anim_single_solo( self.rope, "rope_in", "origin_animate_jnt" );
    thread scripts\common\anim::anim_single_solo( self.crate, "bag_in", "origin_animate_jnt" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var0 );
    thread soldier_agent_lwfn9();
    thread sololink();
    thread soldier_encounter_test();
}

// Params 0
// Size: 0x60
function soldier_agent_lwfn9()
{
    self endon( "death" );
    self.scenenode endon( "death" );
    var0 = getanimlength( level.scr_anim[ self.animname ][ "heli_loop" ] );
    
    for ( ;; )
    {
        self.scenenode thread scripts\common\anim::anim_single_solo( self, "heli_loop" );
        wait var0;
        
        if ( istrue( self.ref_12a47 ) && !istrue( self.ref_1287c ) )
        {
            self notify( "ready_to_leave" );
            break;
        }
    }
}

// Params 0
// Size: 0x47
function sololink()
{
    self endon( "death" );
    var0 = getanimlength( level.scr_anim[ self.animname ][ "rope_loop" ] );
    
    for ( ;; )
    {
        thread scripts\common\anim::anim_single_solo( self.rope, "rope_loop", "origin_animate_jnt" );
        wait var0;
        
        if ( istrue( self.ref_12a47 ) )
        {
            break;
        }
    }
}

// Params 0
// Size: 0x47
function soldier_encounter_test()
{
    self endon( "death" );
    var0 = getanimlength( level.scr_anim[ self.animname ][ "bag_loop" ] );
    
    for ( ;; )
    {
        thread scripts\common\anim::anim_single_solo( self.crate, "bag_loop", "origin_animate_jnt" );
        wait var0;
        
        if ( istrue( self.ref_12a47 ) )
        {
            break;
        }
    }
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
// Size: 0x18
function tracegroundheight( var0 )
{
    var1 = 800;
    var2 = tracegroundpoint( var0 );
    var3 = var2 + var1;
    return var3;
}

// Params 1
// Size: 0x5b
function tracegroundpoint( var0 )
{
    self endon( "death" );
    self endon( "leaving" );
    var1 = -99999;
    var2 = ( var0[ 0 ], var0[ 1 ], var1 );
    var3 = [ self ];
    var4 = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 0, 1, 1, 0 );
    var5 = scripts\engine\trace::sphere_trace( var0, var2, 100, var3, var4, 1 );
    var6 = var5[ "position" ][ 2 ];
    return var6;
}

// Params 0
// Size: 0x1f
function heliwatchgameendleave()
{
    self endon( "death" );
    self endon( "try_to_leave" );
    level waittill( "game_ended" );
    thread sol_3_4_pool( 0 );
}

// Params 2
// Size: 0xc
function smokekill( var0, var1 )
{
    ref_1279d( var0 );
}

// Params 1
// Size: 0x1f
function snowfx( var0 )
{
    if ( isdefined( var0.heli ) )
    {
        thread sol_3_4_pool( var0.heli );
        return;
    }
}

// Params 1
// Size: 0x4
function smodelcollections( var0 )
{
    
}

// Params 0
// Size: 0x8
function plunderlivelobby()
{
    thread autopickupplunder();
}

// Params 0
// Size: 0x20, Type: bool
function inplunderlivelobby()
{
    return istrue( level.br_plunder_enabled ) && istrue( level.br_plunder_lobby ) && !scripts\mp\flags::gameflag( "prematch_done" );
}

// Params 0
// Size: 0xa7
function autopickupplunder()
{
    var0 = 0.1;
    var1 = 25;
    var2 = var1 * var1;
    
    while ( inplunderlivelobby() )
    {
        for ( var3 = 0; var3 < level.br_plunder_ents.size ; var3++ )
        {
            var4 = level.br_plunder_ents[ var3 ];
            
            if ( !isdefined( var4 ) )
            {
                continue;
            }
            
            var5 = var4.origin;
            
            for ( var6 = 0; var6 < level.players.size ; var6++ )
            {
                var7 = level.players[ var6 ];
                
                if ( !isalive( var7 ) )
                {
                    continue;
                }
                
                var8 = distancesquared( var7.origin, var5 );
                
                if ( var8 < var2 )
                {
                    var7 scripts\mp\gametypes\br_pickups::brpickupsusecallback( var4, var7 );
                    break;
                }
            }
        }
        
        wait var0;
    }
}

// Params 0
// Size: 0x34
function playerdelayautobankplunder()
{
    self notify( "playerDelayAutoBankPlunder" );
    self endon( "playerDelayAutoBankPlunder" );
    self endon( "death" );
    level endon( "prematch_done" );
    level endon( "game_ended" );
    wait 2;
    ref_12618( self.plundercount );
}

// Params 1
// Size: 0x77
function playerplunderlivelobbydropondeath( var0 )
{
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    if ( inplunderlivelobby() )
    {
        var1 = var0 == "MOD_MELEE";
        var2 = 1;
        
        if ( var1 && isdefined( self.plundercount ) && self.plundercount > 1 )
        {
            var2 = self.plundercount;
            playersetplundercount( 0 );
        }
        
        if ( var2 <= 0 )
        {
            return;
        }
        
        if ( level.br_plunder_ents.size > 0 )
        {
            level.br_plunder_ents = scripts\engine\utility::array_removeundefined( level.br_plunder_ents );
        }
        
        var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        return ml_p3_func( var2, var3 );
    }
}

// Params 0
// Size: 0xbb
function touchdown_origin()
{
    foreach ( var1 in level.teamnamelist )
    {
        level.teamdata[ var1 ][ "plunderTeamTotal" ] = 0;
        level.teamdata[ var1 ][ "plunderInDeposit" ] = 0;
        level.teamdata[ var1 ][ "plunderBanked" ] = 0;
    }
    
    if ( getdvar( "scr_br_gametype", "" ) == "risk" )
    {
        foreach ( var1 in level.teamnamelist )
        {
            level.teamdata[ var1 ][ "tokensTeamTotal" ] = 0;
            level.teamdata[ var1 ][ "tokensInDeposit" ] = 0;
            level.teamdata[ var1 ][ "tokensBanked" ] = 0;
        }
        
        return;
    }
}

// Params 1
// Size: 0x58
function retry_no_votes( var0 )
{
    var1 = level.br_plunder.names[ 0 ];
    
    for ( var2 = level.br_plunder.ref_12954.size - 1; var2 > 0 ; var2-- )
    {
        if ( var0 >= level.br_plunder.ref_12954[ var2 ] )
        {
            var1 = level.br_plunder.names[ var2 ];
            break;
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x24
function ref_1275d( var0, var1 )
{
    if ( var1 == 0 )
    {
        return;
    }
    
    var2 = retry_no_votes( var1 );
    var3 = scripts\mp\gametypes\br_pickups::getcashsoundaliasforplayer( var0, var2 );
    var0 playsoundtoplayer( var3, self );
}

// Params 0
// Size: 0xf6
function ref_128a7()
{
    var0 = getdvarint( "scr_plunderPileOverride_scalar", 1 );
    
    if ( var0 <= 1 )
    {
        return;
    }
    
    foreach ( var9, var2 in level.br_pickups.counts )
    {
        if ( !issubstr( var9, "brloot_plunder_cash" ) )
        {
            continue;
        }
        
        var3 = level.br_pickups.counts[ var9 ];
        var4 = var3 * var0;
        level.br_pickups.counts[ var9 ] = var4;
        var5 = getentitylessscriptablearrayinradius( var9 );
        
        if ( var5.size >= 1 )
        {
            foreach ( var7 in var5 )
            {
                var7.count = var4;
            }
        }
    }
    
    for ( var10 = 0; var10 < level.br_plunder.names.size ; var10++ )
    {
        level.br_plunder.ref_12954[ var10 ] = level.br_pickups.counts[ level.br_plunder.names[ var10 ] ];
    }
}

// Params 1
// Size: 0xb3
function ref_128a6( var0 )
{
    foreach ( var7, var2 in level.br_plunder.names )
    {
        level.br_plunder.ref_12954[ var7 ] = int( float( level.br_plunder.ref_12954[ var7 ] ) * var0 );
        level.br_pickups.counts[ var2 ] = level.br_plunder.ref_12954[ var7 ];
        var3 = getentitylessscriptablearrayinradius( var2 );
        
        foreach ( var5 in var3 )
        {
            var5.count = level.br_plunder.ref_12954[ var7 ];
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x57
function ismountconfigenabled()
{
    var0 = 0;
    
    foreach ( var2 in level.br_plunder.names )
    {
        var3 = getentitylessscriptablearrayinradius( var2 );
        var0 += var3.size * level.br_pickups.counts[ var2 ];
    }
    
    var0 *= 100;
    level.ref_13bec = var0;
}

// Params 0
// Size: 0xc6
function ref_1278e()
{
    level.ref_127c7 = spawnstruct();
    level.ref_127c7.data = [];
    level.ref_127c7.instances = [];
    level.ref_127c7.uniqueinstanceid = 0;
    level.ref_127c7.ref_13aa6 = [];
    level.ref_127c7.ref_13aa3 = [];
    level.ref_127c7.ref_13aa4 = [];
    
    for ( var0 = 1; var0 <= 4 ; var0++ )
    {
        level.ref_127c7.ref_13aa3[ var0 ] = "ui_br_plunder_repo_ent_" + var0;
        level.ref_127c7.ref_13aa4[ var0 ] = "ui_br_plunder_repo_info_" + var0;
    }
    
    scripts\common\interactive::interactive_addusedcallback( &ref_127a1, "plunderRepository" );
    scripts\engine\scriptable::scriptable_addusedcallback( &ref_127a3 );
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &ref_12795 );
    level.ref_127d4 = getdvarint( "scr_br_plunderUseDisabledWhenEmpty", 0 ) > 0;
}

// Params 3
// Size: 0x115
function ref_1278c( var0, var1, var2 )
{
    var3 = level.ref_127c7;
    var4 = var3.data[ var0 ];
    
    if ( !isdefined( var4 ) )
    {
        if ( istrue( var1 ) )
        {
            var4 = spawnstruct();
            var3.data[ var0 ] = var4;
            var4.usetime = 0.75;
            var4.ref_14077 = 2;
            var4.ref_14075 = 250;
            var4.ref_13acc = 1;
            var4.ref_13aa5 = 0;
            var4.ref_1407a = "MP/CANNOT_DEPOSIT_LS";
            var4.ref_1407c = "MP/CANNOT_DEPOSIT_VEHICLE";
            var4.ref_14078 = "MP/PLACEHOLDER_CANNOT_DEPOSIT_FULL";
            var4.ref_1407b = "MP/CANNOT_DEPOSIT_NO_CASH";
            var4.ref_14079 = "MP/PLACEHOLDER_CANNOT_DEPOSIT_LEAVING";
            var4.ref_12f7d = undefined;
            var4.ref_12f7e = undefined;
            var4.ref_12f77 = undefined;
            var4.origin_delta = 60;
            var4.overrideviewkickscaledmr = 0;
            var4.original_disablelongdeath = "MP/PLACEHOLDER_LEAVING_IN_N";
            var4.get_closest_enemy_near_turret = 2000;
            var4.ref_14098 = undefined;
            var4.ref_14068 = &ref_1279f;
            var4.impactwatcher = undefined;
            var4.org_in_bad_place = undefined;
            var4.outline_enemy_ai_for_duration = undefined;
        }
    }
    
    return var4;
}

// Params 2
// Size: 0x9f
function ref_12796( var0, var1 )
{
    var2 = level.ref_127c7;
    var3 = ref_1278c( var1 );
    var0.ref_127c8 = var1;
    var0.startorigin = var0.origin;
    var0.plunder = [];
    var0.ref_127d0 = 0;
    var0.ref_127bd = level.ref_127c7.uniqueinstanceid;
    level.ref_127c7.uniqueinstanceid++;
    var0.ref_126be = [];
    var2.instances[ var0.ref_127bd ] = var0;
    ref_12780( var0 );
    
    if ( !isdefined( var3.ref_12f7d ) )
    {
        var0 scripts\common\interactive::interactive_addusedcallbacktoentity( "plunderRepository" );
    }
    
    ref_12782( var0, 1 );
}

// Params 1
// Size: 0x7d
function ref_12786( var0 )
{
    var1 = level.ref_127c7;
    var0 notify( "plunder_instance_deregistered" );
    ref_12782( var0, 0, 1 );
    var0.ref_127c8 = undefined;
    var0.ref_127d3 = undefined;
    var0.ref_127ae = undefined;
    var0.startorigin = undefined;
    var0.plunder = undefined;
    var0.ref_127d0 = undefined;
    ref_1279a( var0 );
    var0.ref_126be = undefined;
    
    if ( isdefined( var0.ref_127bd ) )
    {
        var1.instances[ var0.ref_127bd ] = undefined;
    }
    
    ref_12797( var0 );
    var0 scripts\common\interactive::interactive_removeusedcallbackfromentity();
}

// Params 1
// Size: 0x39, Type: bool
function ref_1279e( var0 )
{
    var1 = level.ref_127c7;
    
    if ( !isdefined( var1 ) )
    {
        return false;
    }
    
    var2 = undefined;
    
    if ( isdefined( var0.ref_127bd ) )
    {
        var2 = var1.instances[ var0.ref_127bd ];
    }
    
    return isdefined( var2 ) && var2 == var0;
}

// Params 3
// Size: 0xed
function ref_12782( var0, var1, var2 )
{
    var0 notify( "plunder_allowRepositoryUse" );
    var3 = undefined;
    
    if ( isdefined( var0.ref_127c8 ) )
    {
        var3 = ref_1278c( var0.ref_127c8, undefined, var2 );
    }
    
    if ( isdefined( var3 ) )
    {
        if ( isdefined( var3.ref_12f7d ) )
        {
            if ( var1 )
            {
                var0 setscriptablepartstate( var3.ref_12f7d, var3.ref_12f7e, 0 );
            }
            else
            {
                var0 setscriptablepartstate( var3.ref_12f7d, var3.ref_12f77, 0 );
            }
        }
        else if ( var1 )
        {
            var0 makeusable();
        }
        else
        {
            var0 makeunusable();
        }
        
        var4 = istrue( var0.ref_127d3 );
        var0.ref_127d3 = scripts\engine\utility::ter_op( var1, var1, undefined );
        
        if ( !var4 )
        {
            if ( var1 )
            {
                foreach ( var6 in level.players )
                {
                    ref_12783( var0, var6, ref_12793( var0, var6 ) );
                }
                
                return;
            }
            
            return;
        }
        
        if ( !var4 )
        {
            var3 notify( "repository_use_disabled" );
            return;
        }
        
        return;
    }
}

// Params 4
// Size: 0x83
function ref_12783( var0, var1, var2, var3 )
{
    var4 = undefined;
    
    if ( isdefined( var0.ref_127c8 ) )
    {
        var4 = ref_1278c( var0.ref_127c8, undefined, var3 );
    }
    
    if ( isdefined( var4 ) )
    {
        if ( isdefined( var4.ref_12f7d ) )
        {
            if ( var2 )
            {
                var0 enablescriptablepartplayeruse( var4.ref_12f7d, var1 );
            }
            else
            {
                var0 disablescriptablepartplayeruse( var4.ref_12f7d, var1 );
            }
        }
        else if ( var2 )
        {
            var0 enableplayeruse( var1 );
        }
        else
        {
            var0 disableplayeruse( var1 );
        }
    }
    
    if ( !var2 )
    {
        var0 notify( "repository_use_disabled_for_" + var1 getentitynumber() );
        return;
    }
}

// Params 3
// Size: 0x45
function ref_12781( var0, var1, var2 )
{
    var3 = level.ref_127c7;
    
    foreach ( var5 in var3.instances )
    {
        if ( isdefined( var5 ) )
        {
            ref_12783( var5, var0, var1, 1 );
        }
    }
}

// Params 2
// Size: 0x65, Type: bool
function ref_12793( var0, var1 )
{
    if ( var1 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( scripts\mp\utility\player::unset_relic_trex( var1 ) )
    {
        return false;
    }
    
    var2 = ref_1278c( var0.ref_127c8 );
    var3 = istrue( var2.ref_13acc ) || istrue( var0.playerplunderbankdepositcallback );
    
    if ( var3 && isdefined( var0.team ) && var1.team != var0.team )
    {
        return false;
    }
    
    return true;
}

// Params 3
// Size: 0x2c9
function ref_12794( var0, var1, var2 )
{
    var3 = ref_1278c( var0.ref_127c8 );
    
    if ( !istrue( var0.ref_127d3 ) )
    {
        return 0;
    }
    
    if ( var3.ref_14077 == 7 )
    {
        if ( var0.team != var1.team )
        {
            if ( !isdefined( var3.brking_ispointinmovingcircle ) || !istrue( var3.brking_ispointinmovingcircle ) )
            {
                var1 playlocalsound( "br_plunder_atm_cancel" );
                
                if ( isdefined( var3.è÷™HäπàAŸ‡`#7 ) && var3.è÷™HäπàAŸ‡`#7 != "" )
                {
                    var1 scripts\mp\hud_message::showerrormessage( var3.è÷™HäπàAŸ‡`#7 );
                }
                
                return 0;
            }
            
            if ( var0.ref_127d0 <= 0 )
            {
                var1 playlocalsound( "br_plunder_atm_cancel" );
                var1 scripts\mp\hud_message::showerrormessage( var3.è÷™HäπàAŸ‡`#7 );
                return 0;
            }
        }
        else if ( var0.team == var1.team && ( !isdefined( var1.plundercount ) || var1.plundercount <= 0 ) )
        {
            if ( istrue( var2 ) && isdefined( var3.ref_1407b ) && var3.ref_1407b != "" )
            {
                var1 playlocalsound( "br_plunder_atm_cancel" );
                var1 scripts\mp\hud_message::showerrormessage( var3.ref_1407b );
            }
            
            return 0;
        }
    }
    
    if ( var3.ref_14077 == 2 || var3.ref_14077 == 3 )
    {
        if ( !isdefined( var1.plundercount ) || var1.plundercount <= 0 && ( !isdefined( var1.overheatreductiontime ) || isdefined( var1.override_minimap_hide ) && isdefined( var0.index ) && var1.override_minimap_hide != var0.index ) )
        {
            if ( istrue( var2 ) && isdefined( var3.ref_1407b ) && var3.ref_1407b != "" )
            {
                var1 playlocalsound( "br_plunder_atm_cancel" );
                var1 scripts\mp\hud_message::showerrormessage( var3.ref_1407b );
            }
            
            return 0;
        }
        else if ( istrue( var0.ref_127ae ) )
        {
            if ( istrue( var2 ) && isdefined( var3.ref_14078 ) && var3.ref_14078 != "" )
            {
                var1 playlocalsound( "br_plunder_atm_cancel" );
                var1 scripts\mp\hud_message::showerrormessage( var3.ref_14078 );
            }
            
            return 0;
        }
    }
    
    if ( var1 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        if ( istrue( var2 ) && isdefined( var3.ref_1407c ) && var3.ref_1407c != "" )
        {
            var1 playlocalsound( "br_plunder_atm_cancel" );
            var1 scripts\mp\hud_message::showerrormessage( var3.ref_1407c );
        }
        
        return 0;
    }
    
    if ( scripts\mp\utility\player::unset_relic_trex( var1 ) )
    {
        if ( istrue( var2 ) && isdefined( var3.ref_1407a ) && var3.ref_1407a != "" )
        {
            var1 playlocalsound( "br_plunder_atm_cancel" );
            var1 scripts\mp\hud_message::showerrormessage( var3.ref_1407a );
        }
        
        return 0;
    }
    
    if ( var1 isparachuting() || var1 isskydiving() )
    {
        return 0;
    }
    
    if ( var1 isinexecutionattack() || var1 isinexecutionvictim() )
    {
        return 0;
    }
    
    if ( isdefined( var3.ref_14098 ) )
    {
        return [[ var3.ref_14098 ]]( var0, var1, var2 );
    }
    
    return 1;
}

// Params 5
// Size: 0x7e
function ref_127a3( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var5 = var0.entity;
    
    if ( !isdefined( var5 ) || isdefined( var5.playermaxheath ) )
    {
        var5 = var0;
    }
    
    if ( !ref_1279e( var5 ) )
    {
        return;
    }
    
    var6 = ref_1278c( var5.ref_127c8 );
    
    if ( !isdefined( var6.ref_12f7d ) )
    {
        return;
    }
    
    if ( var1 != var6.ref_12f7d )
    {
        return;
    }
    
    if ( var2 != var6.ref_12f7e )
    {
        return;
    }
    
    if ( !ref_12794( var5, var3, 1 ) )
    {
        return;
    }
    
    thread ref_127a2( var5, var3 );
}

// Params 2
// Size: 0x24
function ref_127a1( var0, var1 )
{
    if ( !ref_1279e( var0 ) )
    {
        return;
    }
    
    if ( !ref_12794( var0, var1, 1 ) )
    {
        return;
    }
    
    thread ref_127a2( var0, var1 );
}

// Params 2
// Size: 0x10e
function ref_127a2( var0, var1 )
{
    var2 = var1 getentitynumber();
    var3 = gettime();
    ref_1279b( var1, 1 );
    ref_12783( var0, var1, 0 );
    ref_127a5( var0, var1 );
    
    if ( isdefined( var1 ) )
    {
        if ( isdefined( var0 ) )
        {
            ref_12783( var0, var1, 1 );
        }
        
        if ( var1 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            ref_1279b( var1, 0 );
        }
        
        var1.ref_127c9 = undefined;
        
        if ( isplayer( var1 ) )
        {
            var4 = 0;
            var5 = undefined;
            
            if ( !var4 && var1 scripts\cp_mp\utility\player_utility::_isalive() && !var1 scripts\cp_mp\utility\player_utility::isinvehicle() && !scripts\mp\utility\player::unset_relic_trex( var1 ) )
            {
                if ( istrue( var0.oscope_ampl ) )
                {
                    var5 = 2;
                }
                else if ( isdefined( var1.ref_127ca ) && isdefined( var1.ref_127ca.ref_14076 ) && var1.ref_127ca.ref_14076 - gettime() <= 1.5 )
                {
                    var5 = 1.5;
                }
            }
            
            thread ref_12785( var1, var5 );
        }
    }
    
    if ( isdefined( var0 ) && isdefined( var0.ref_126be ) )
    {
        var0.ref_126be[ var2 ] = undefined;
    }
    
    if ( isdefined( var1 ) && isplayer( var1 ) )
    {
        ref_127aa( var0, var1 );
        return;
    }
}

// Params 2
// Size: 0x17a
function ref_127a5( var0, var1 )
{
    var1 endon( "death_or_disconnect" );
    var1 endon( "last_stand_start" );
    var0 endon( "death" );
    var0 endon( "repository_use_disabled" );
    var0 endon( "repository_use_disabled_for_" + var1 getentitynumber() );
    level endon( "game_ended" );
    var2 = ref_1278c( var0.ref_127c8 );
    var0.ref_126be[ var1 getentitynumber() ] = var1;
    ref_127ab( var1, var0.ref_127bd, var2.type, 1, var0.ref_127af, var0.ref_127d0 );
    ref_127a6( var1 );
    ref_127aa( var0, var1 );
    var3 = 0;
    var4 = 0;
    var5 = var2.usetime;
    var6 = 0;
    var7 = 0;
    
    while ( var1 usebuttonpressed() )
    {
        var8 = undefined;
        
        if ( var3 )
        {
            var3 = 0;
            var8 = 0;
        }
        else
        {
            var8 = 1;
        }
        
        if ( !ref_12794( var0, var1, var8 ) )
        {
            return;
        }
        
        if ( var4 >= var5 )
        {
            if ( var2.ref_14077 == 7 && var0.team != var1.team )
            {
                var7 = int( var2.ß>_y=ö‰à–≠3®¯ );
                var5 = var4 + var2.æ≈
x<7ÓÏÛBJU;
            }
            else
            {
                var7 = int( min( var1.plundercount, var2.ref_14075 ) );
                var5 = var4 + var2.usetime;
            }
            
            if ( isdefined( var2.ref_14068 ) )
            {
                GscBinSkip1( 0x74, var2.ref_14068, var0, var1, var7 );
                // Unknown operator ( 0x74, iw8, PC )
            }
            
            var6 = var4;
            
            if ( isdefined( var1.ref_127ca ) )
            {
                var1.ref_127ca.ref_14076 = gettime();
            }
            
            var3 = 1;
        }
        
        wait 0.05;
        var4 += 0.05;
    }
}

// Params 3
// Size: 0x60
function ref_1279f( var0, var1, var2 )
{
    var3 = ref_1278c( var0.ref_127c8 );
    var4 = ref_1261f( var1, var2, var3.ref_14077, var0 );
    
    if ( isdefined( var4 ) && isdefined( var4.amount ) )
    {
        var2 = var4.amount;
    }
    
    if ( var2 > 0 )
    {
        ref_127ab( var1, undefined, undefined, undefined, undefined, var0.ref_127d0, var2 );
        ref_127a6( var1 );
        return;
    }
}

// Params 2
// Size: 0xac
function ref_1279b( var0, var1 )
{
    var2 = [ "movement", "usability", "weapon_switch", "equipment", "supers", "killstreaks", "fire", "melee", "reload", "ads", "mantle", "mount_top", "mount_side", "execution_attack", "vehicle_use", "cough_gesture" ];
    
    if ( istrue( var0.ref_127c9 ) && var1 )
    {
        return;
    }
    
    if ( !istrue( var0.ref_127c9 ) && !var1 )
    {
        return;
    }
    
    var0 scripts\common\utility::allow_array( var2, !var1 );
    
    if ( var1 )
    {
        var0.ref_127c9 = 1;
        return;
    }
    
    var0.ref_127c9 = undefined;
}

// Params 2
// Size: 0x192
function ref_127a4( var0, var1 )
{
    var0 endon( "death" );
    var0 endon( "plunder_instance_deregistered" );
    var0 notify( "plunder_repositoryWatchCountdown" );
    var0 endon( "plunder_repositoryWatchCountdown" );
    level endon( "game_ended" );
    var2 = ref_1278c( var0.ref_127c8 );
    
    if ( !isdefined( var0.ref_127b1 ) )
    {
        var0.ref_127b1 = [];
        var0.ref_127b2 = 0;
        var3 = scripts\engine\utility::ter_op( isdefined( var2.overrideviewkickscaledmr ), var2.overrideviewkickscaledmr, 0 );
        var4 = scripts\engine\utility::ter_op( isdefined( var2.origin_delta ), var2.origin_delta, 0 );
        var0.ref_127cb = gettime() + var3 * 1000;
        var0.ref_127af = gettime() + ( var3 + var4 ) * 1000;
    }
    
    if ( isdefined( var1 ) )
    {
        if ( !isarray( var1 ) )
        {
            var1 = [ var1 ];
        }
        
        foreach ( var6 in var1 )
        {
            if ( isdefined( var6 ) && isplayer( var6 ) )
            {
                var0.ref_127b1[ var6 getentitynumber() ] = var6;
            }
        }
    }
    
    while ( gettime() <= var0.ref_127af )
    {
        if ( gettime() - var0.ref_127b2 >= 1000 )
        {
            if ( gettime() > var0.ref_127cb )
            {
                var8 = int( max( 0, ( var0.ref_127af - gettime() ) / 1000 ) );
                
                foreach ( var6 in var0.ref_127b1 )
                {
                    if ( isdefined( var6 ) )
                    {
                        thread ref_127a0( var6, var0, var8 );
                    }
                }
            }
            
            var0.ref_127b2 = gettime();
        }
        
        wait 0.05;
    }
    
    thread ref_1279c( var0, 1 );
}

// Params 2
// Size: 0x32
function ref_1279c( var0, var1 )
{
    ref_1279a( var0 );
    var2 = ref_1278c( var0.ref_127c8 );
    
    if ( isdefined( var2.impactwatcher ) )
    {
        [[ var2.impactwatcher ]]( var0, var1 );
        return;
    }
}

// Params 1
// Size: 0x21
function ref_1279a( var0 )
{
    var0 notify( "plunder_repositoryWatchCountdown" );
    var0.ref_127b1 = undefined;
    var0.ref_127af = undefined;
    var0.ref_127b2 = undefined;
}

// Params 3
// Size: 0x100
function ref_127a0( var0, var1, var2 )
{
    var0 endon( "disconnect" );
    var0 notify( "plunder_repositorySendCountdownMessage" );
    var0 endon( "plunder_repositorySendCountdownMessage" );
    level endon( "game_ended" );
    
    if ( !isdefined( var0.ref_127b0 ) )
    {
        var0.ref_127b0 = [];
    }
    
    var3 = ref_1278c( var1.ref_127c8 );
    
    if ( isdefined( var3.original_disablelongdeath ) )
    {
        var4 = spawnstruct();
        var4.origin = var1.origin;
        var4.msg = var3.original_disablelongdeath;
        var4.value = var2;
        var0.ref_127b0[ var0.ref_127b0.size ] = var4;
    }
    
    waittillframeend();
    
    if ( !var0 scripts\mp\gametypes\br_public::isplayeringulag() && var0 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        var5 = undefined;
        var6 = 2147483647;
        
        foreach ( var4 in var0.ref_127b0 )
        {
            var8 = distance2dsquared( var0.origin, var4.origin );
            
            if ( var8 < var6 )
            {
                var6 = var8;
                var5 = var4;
            }
        }
    }
    
    var0.ref_127b0 = undefined;
}

// Params 1
// Size: 0x49
function ref_1279d( var0 )
{
    var0.oscope_ampl = 1;
    ref_1279a( var0 );
    ref_12782( var0, 0 );
    ref_12797( var0 );
    var1 = ref_1278c( var0.ref_127c8 );
    
    if ( isdefined( var1.org_in_bad_place ) )
    {
        [[ var1.org_in_bad_place ]]( var0 );
        return;
    }
}

// Params 1
// Size: 0x3b
function ref_12799( var0 )
{
    var0.ref_127ae = 1;
    ref_12782( var0, 0 );
    var1 = ref_1278c( var0.ref_127c8 );
    
    if ( isdefined( var1.carriable_error_messsage_watch ) )
    {
        [[ var1.carriable_error_messsage_watch ]]( var0 );
        return;
    }
}

// Params 0
// Size: 0xd
function ref_12795()
{
    ref_12781( self, 1, 1 );
}

// Params 7
// Size: 0x183
function ref_127ab( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( isdefined( var3 ) && !var3 )
    {
        ref_12785( var0 );
        return;
    }
    
    var7 = var0.ref_127ca;
    
    if ( !isdefined( var7 ) )
    {
        var7 = spawnstruct();
        var0.ref_127ca = var7;
        var7.ref_127bd = var1;
        var7.type = var2;
        var7.visible = 0;
        var7.endtime = undefined;
        var7.ref_127d0 = undefined;
        var7.ref_127b7 = undefined;
        var7.timestamp = undefined;
    }
    else if ( isdefined( var1 ) && isdefined( var7.ref_127bd ) && var1 != var7.ref_127bd )
    {
        return;
    }
    
    var8 = 0;
    
    if ( istrue( var3 ) )
    {
        var8 = !var7.visible;
        var7.visible = 1;
    }
    
    if ( isdefined( var4 ) )
    {
        var7.endtime = var4;
    }
    
    if ( isdefined( var5 ) )
    {
        var7.ref_127d0 = var5;
    }
    
    if ( isdefined( var6 ) )
    {
        var7.ref_127b7 = var6;
        var9 = level.ref_127c7.instances[ var7.ref_127bd ];
        
        foreach ( var11 in var9.ref_126be )
        {
            if ( var11 != var0 )
            {
                ref_127ab( var0, undefined, undefined, undefined, undefined, var5, undefined );
                ref_127a6( var0 );
            }
        }
        
        if ( isdefined( var9.team ) )
        {
            ref_127aa( var9, scripts\mp\utility\teams::getfriendlyplayers( var9.team ) );
        }
    }
    else if ( isdefined( var7.timestamp ) && var7.timestamp < gettime() )
    {
        var7.ref_127b7 = undefined;
    }
    
    var7.timestamp = gettime();
}

// Params 2
// Size: 0x32
function ref_12785( var0, var1 )
{
    var0 endon( "disconnect" );
    var0 endon( "plunder_sendRepositoryWidgetOmnvar" );
    var0.ref_127ca = undefined;
    
    if ( isdefined( var1 ) && var1 > 0 )
    {
        wait var1;
    }
    
    var0 setclientomnvar( "ui_br_plunder_repository", 0 );
}

// Params 1
// Size: 0x16f
function ref_127a6( var0 )
{
    var0 notify( "plunder_sendRepositoryWidgetOmnvar" );
    var1 = var0.ref_127ca;
    
    if ( !isdefined( var1 ) )
    {
        var0 setclientomnvar( "ui_br_plunder_repository", 0 );
        return;
    }
    
    var2 = 0;
    var3 = 0;
    var4 = var1.visible;
    var5 = 1;
    
    if ( isdefined( var4 ) )
    {
        var2 |= int( var4 ) << var3;
    }
    
    var3 += var5;
    var4 = var1.type;
    var5 = 1;
    
    if ( isdefined( var4 ) )
    {
        var2 |= int( var4 ) << var3;
    }
    
    var3 += var5;
    var4 = var1.endtime;
    var5 = 14;
    
    if ( isdefined( var4 ) )
    {
        var4 = int( var4 / 250 );
        var4 &= 16383;
        var2 |= int( var4 ) << var3;
    }
    
    var3 += var5;
    var6 = getdvar( "scr_br_gametype", "" ) == "gold_war";
    
    if ( var1.type == 0 )
    {
        var4 = var1.ref_127d0;
        var5 = 9;
        
        if ( isdefined( var4 ) )
        {
            var7 = 5;
            
            if ( var6 )
            {
                var7 = 50;
            }
            
            var4 = int( var4 / var7 );
            var4 &= 511;
            var2 |= int( var4 ) << var3;
        }
        
        var3 += var5;
        var4 = var1.ref_127b7;
        var5 = 6;
        
        if ( isdefined( var4 ) )
        {
            var7 = 5;
            
            if ( var6 )
            {
                var7 = 50;
            }
            
            var4 = int( var4 / var7 );
            var4 &= 63;
            var2 |= int( var4 ) << var3;
        }
    }
    else
    {
        var4 = var1.ref_127b7;
        var5 = 15;
        
        if ( isdefined( var4 ) )
        {
            var4 = int( var4 / 5 );
            var4 &= 32767;
            var2 |= int( var4 ) << var3;
        }
    }
    
    var0 setclientomnvar( "ui_br_plunder_repository", var2 );
}

// Params 1
// Size: 0x147
function ref_12780( var0 )
{
    var1 = level.ref_127c7;
    var2 = ref_1278c( var0.ref_127c8 );
    
    if ( !istrue( var2.ref_13aa5 ) )
    {
        return;
    }
    
    if ( !isdefined( var1.ref_13aa6[ var0.team ] ) )
    {
        var1.ref_13aa6[ var0.team ] = [];
    }
    
    var3 = [];
    
    for ( var4 = 1; var4 <= 4 ; var4++ )
    {
        var3 = var4;
    }
    
    foreach ( var6 in var1.ref_13aa6[ var0.team ] )
    {
        var3[ var6.building_magic_grenade_damage ] = undefined;
    }
    
    foreach ( var9 in var3 )
    {
        var0.building_magic_grenade_damage = var9;
        break;
    }
    
    if ( isdefined( var0.building_magic_grenade_damage ) )
    {
        var1.ref_13aa6[ var0.team ] = scripts\engine\utility::array_add( var1.ref_13aa6[ var0.team ], var0 );
        var11 = var1.ref_13aa3[ var0.building_magic_grenade_damage ];
        
        foreach ( var13 in scripts\mp\utility\teams::getfriendlyplayers( var0.team ) )
        {
            var13 setclientomnvar( var11, var0 getentitynumber() );
        }
        
        return;
    }
}

// Params 1
// Size: 0xbb
function ref_12797( var0 )
{
    var1 = level.ref_127c7;
    var2 = var0.building_magic_grenade_damage;
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var0.building_magic_grenade_damage = undefined;
    var1.ref_13aa6[ var0.team ] = scripts\engine\utility::array_remove( var1.ref_13aa6[ var0.team ], var0 );
    
    if ( var1.ref_13aa6[ var0.team ].size == 0 )
    {
        var1.ref_13aa6[ var0.team ] = undefined;
    }
    
    var3 = var1.ref_13aa3[ var2 ];
    var4 = var1.ref_13aa4[ var2 ];
    
    foreach ( var6 in scripts\mp\utility\teams::getfriendlyplayers( var0.team ) )
    {
        var6 setclientomnvar( var3, -1 );
        var6 setclientomnvar( var4, 0 );
    }
}

// Params 2
// Size: 0xf9
function ref_127aa( var0, var1 )
{
    var2 = level.ref_127c7;
    
    if ( !isdefined( var0.building_magic_grenade_damage ) )
    {
        return;
    }
    
    if ( !isarray( var1 ) )
    {
        var1 = [ var1 ];
    }
    
    if ( var1.size == 0 )
    {
        return;
    }
    
    var3 = 0;
    var4 = 0;
    var5 = 1;
    var6 = 1;
    var3 += var5;
    var4 += var6;
    var5 = var0.ref_127af;
    var6 = 14;
    
    if ( isdefined( var5 ) )
    {
        var5 /= 250;
        var5 = int( min( var5, 16383 ) );
        var3 += var5 << var4;
    }
    
    var4 += var6;
    var5 = var0.ref_127d0;
    var6 = 9;
    
    if ( isdefined( var5 ) )
    {
        var5 /= 5;
        var5 = int( min( var5, 511 ) );
        var3 += var5 << var4;
    }
    
    var7 = var2.ref_13aa4[ var0.building_magic_grenade_damage ];
    
    foreach ( var9 in var1 )
    {
        if ( scripts\engine\utility::array_contains( var0.ref_126be, var9 ) )
        {
            var9 setclientomnvar( var7, var3 & ~1 );
            continue;
        }
        
        var9 setclientomnvar( var7, var3 );
    }
}

