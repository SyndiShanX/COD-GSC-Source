
// Params 0
// Size: 0x352
function init()
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "uav", "init" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "uav", "init" ) ]]();
    }
    
    var0 = getentarray( "minimap_corner", "targetname" );
    
    if ( var0.size )
    {
        var1 = var0[ 0 ].origin;
        var2 = var0[ 1 ].origin;
        var3 = ( 0, 0, 0 );
        var3 = var2 - var1;
        var3 = ( var3[ 0 ] / 2, var3[ 1 ] / 2, var3[ 2 ] / 2 ) + var1;
        level.uavrotationorigin = var3;
    }
    else
    {
        level.uavrotationorigin = ( 0, 0, 0 );
    }
    
    level.uavrig = spawn( "script_model", level.uavrotationorigin );
    level.uavrig setmodel( "tag_origin" );
    level.uavrig.angles = ( 0, 115, 0 );
    level.uavrig hide();
    level.uavrig.targetname = "uavrig_script_model";
    thread rotateuavrig( level.uavrig );
    level.uavrigslow = spawn( "script_model", level.uavrotationorigin );
    level.uavrigslow setmodel( "tag_origin" );
    level.uavrigslow.angles = ( 0, 115, 0 );
    level.uavrigslow hide();
    level.uavrigslow.targetname = "uavrig_script_model";
    thread rotateuavrig( level.uavrigslow );
    level.counteruavrig = spawn( "script_model", level.uavrotationorigin );
    level.counteruavrig setmodel( "tag_origin" );
    level.counteruavrig.angles = ( 0, 115, 0 );
    level.counteruavrig hide();
    level.counteruavrig.targetname = "counteruavrig_script_model";
    thread rotateuavrig( level.counteruavrig );
    level.advanceduavrig = spawn( "script_model", level.uavrotationorigin );
    level.advanceduavrig setmodel( "tag_origin" );
    level.advanceduavrig.angles = ( 0, 115, 0 );
    level.advanceduavrig hide();
    level.advanceduavrig.targetname = "advanceduavrig_script_model";
    thread rotateuavrig( level.advanceduavrig );
    level.ref_13ede = getuavstrengthmin();
    level.ref_13ed9 = getuavstrengthmax();
    level.ref_13eda = getuavstrengthlevelshowenemydirectional();
    level.ref_13edc = getuavstrengthlevelneutral();
    level.ref_13edb = getuavstrengthlevelshowenemyfastsweep();
    
    if ( !isdefined( level.ref_13edd ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) )
    {
        level.ref_13edd = level [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]() && getdvarint( "scr_uav_for_squad_only", 1 );
    }
    
    if ( level.teambased && !istrue( level.ref_13edd ) )
    {
        for ( var4 = 0; var4 < level.teamnamelist.size ; var4++ )
        {
            level.radarmode[ level.teamnamelist[ var4 ] ] = "normal_radar";
            level.activeuavs[ level.teamnamelist[ var4 ] ] = 0;
            level.activecounteruavs[ level.teamnamelist[ var4 ] ] = 0;
            level.activeadvanceduavs[ level.teamnamelist[ var4 ] ] = 0;
            level.uavmodels[ level.teamnamelist[ var4 ] ] = [];
        }
    }
    else
    {
        level.radarmode = [];
        level.activeuavs = [];
        level.activecounteruavs = [];
        level.activeadvanceduavs = [];
        level.uavmodels = [];
    }
    
    level.totalactiveuavs = 0;
    level.totalactivecounteruavs = 0;
    level.audio_heli_end_fade_out = 0;
    thread onplayerconnect();
    thread uavtracker();
    game[ "dialog" ][ "uav_destroyed" ] = "uav_destroyed";
}

// Params 0
// Size: 0x86
function onplayerconnect()
{
    var0 = getuavstrengthlevelneutral();
    var1 = level.teambased && istrue( level.ref_13edd );
    
    for ( ;; )
    {
        level waittill( "connected", var2 );
        
        if ( var1 )
        {
            thread ref_12090();
            continue;
        }
        
        level.activeuavs[ var2.guid ] = 0;
        level.activeuavs[ var2.guid + "_radarStrength" ] = var0;
        level.activecounteruavs[ var2.guid ] = 0;
        level.radarmode[ var2.guid ] = "normal_radar";
        var2.radarstrength = var0;
    }
}

// Params 0
// Size: 0x8c
function ref_12090()
{
    self endon( "disconnect" );
    
    while ( !isdefined( self.squadindex ) )
    {
        waitframe();
    }
    
    var0 = self.team + self.squadindex;
    
    if ( !isdefined( level.radarmode[ var0 ] ) )
    {
        level.radarmode[ var0 ] = "normal_radar";
    }
    
    if ( !isdefined( level.activeuavs[ var0 ] ) )
    {
        level.activeuavs[ var0 ] = 0;
    }
    
    if ( !isdefined( level.activecounteruavs[ var0 ] ) )
    {
        level.activecounteruavs[ var0 ] = 0;
    }
    
    if ( !isdefined( level.activeadvanceduavs[ var0 ] ) )
    {
        level.activeadvanceduavs[ var0 ] = 0;
    }
    
    if ( !isdefined( level.uavmodels[ var0 ] ) )
    {
        level.uavmodels[ var0 ] = [];
        return;
    }
}

// Params 0
// Size: 0xa
function onplayerspawned()
{
    level notify( "uav_update" );
}

// Params 3
// Size: 0x2d
function rotateuavrig( var0, var1, var2 )
{
    if ( isdefined( var2 ) )
    {
        self endon( var2 );
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = 60;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = -360;
    }
    
    for ( ;; )
    {
        self rotateyaw( var1, var0 );
        wait var0;
    }
}

// Params 1
// Size: 0x14
function tryuseuav( var0 )
{
    var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( var0, self );
    return tryuseuavfromstruct( var1 );
}

// Params 1
// Size: 0x145, Type: bool
function tryuseuavfromstruct( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( var0 ) )
        {
            return false;
        }
    }
    
    if ( istrue( level.àæËÈ{ï¿£∂ÉPü©wãã˚ù ) )
    {
        var1 = "MP_BR_INGAME_TU_WZ335/AUAVSCAN_IN_PROGRESS";
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var1 );
        }
        
        return false;
    }
    
    var2 = 0;
    
    if ( level.teambased && isdefined( level.teamdata ) && isdefined( level.teamdata[ self.team ] ) && isdefined( level.teamdata[ self.team ][ "activeSupplySweeps" ] ) )
    {
        var3 = level.teamdata[ self.team ][ "activeSupplySweeps" ].size;
        var2 = var3 > 0;
    }
    
    if ( var2 )
    {
        var1 = "MP_BR_INGAME_TU_WZ350/SUPPLY_SWEEP_IN_PROGRESS";
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var1 );
        }
        
        return false;
    }
    
    if ( !istrue( var2.ref_133cc ) )
    {
        var4 = "ks_gesture_generic_mp";
        
        if ( scripts\cp_mp\utility\game_utility::ref_140a9() )
        {
            var4 = "ks_gesture_generic_mp_ch3";
        }
        
        var5 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy( var2, getcompleteweaponname( var4 ) );
        
        if ( !istrue( var5 ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( var2 ) )
        {
            return false;
        }
    }
    
    var1 = useuav( var2.streakname, var2 );
    return istrue( var1 );
}

// Params 2
// Size: 0x165, Type: bool
function useuav( var0, var1 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "logKillstreakEvent" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "logKillstreakEvent" ) ]]( var0, self.origin );
    }
    
    var2 = self.pers[ "team" ];
    var3 = self.squadindex;
    var4 = level.uavsettings[ var0 ].timeout;
    var5 = 0;
    
    if ( level.gametype == "br" )
    {
        var5 = 1;
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f( "t9_ch_global_call_in_uav_for_operator_mission", 1 );
    scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f( "t9_ch_global_call_in_uav_for_operator_mission_op2", 1 );
    
    if ( getdvarint( "LRTSSKLKPK", 1 ) >= 8 )
    {
        scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f( "t9_ch_global_call_in_uav_for_operator_mission_op3", 1 );
    }
    
    thread launchuav( level, self, var0, var1 );
    
    switch ( var0 )
    {
        case "counter_uav":
            self notify( "used_counter_uav" );
            break;
        case "harp":
        case "directional_uav":
            self.radarshowenemydirection = 1;
            
            if ( level.teambased )
            {
                foreach ( var7 in level.players )
                {
                    if ( var7.pers[ "team" ] == var2 )
                    {
                        var7.radarshowenemydirection = 1;
                    LOC_0000011a:
                    }
                LOC_0000011a:
                }
            }
            
            self notify( "used_directional_uav" );
            break;
        default:
            self notify( "used_uav" );
            break;
    }
    
    return true;
}

// Params 1
// Size: 0x81, Type: bool
function ref_13320( var0 )
{
    if ( level.gametype != "br" )
    {
        return false;
    }
    
    if ( var0 != "uav" )
    {
        return false;
    }
    
    var1 = undefined;
    
    if ( level.teambased )
    {
        var1 = self.team;
        
        if ( istrue( level.ref_13edd ) )
        {
            var1 = self.team + self.squadindex;
        }
    }
    else
    {
        var1 = self.guid;
    }
    
    var2 = level.activeadvanceduavs[ var1 ] > 0;
    
    if ( var2 )
    {
        return false;
    }
    
    var3 = level.activeuavs[ var1 ];
    var4 = _getradarstrength( var3 + 1, 0, 0 );
    var5 = getuavstrengthlevelshowenemydirectional();
    return var4 >= var5;
}

// Params 4
// Size: 0x8ac
function launchuav( var0, var1, var2, var3 )
{
    var4 = var0.team;
    var5 = var0.squadindex;
    var6 = getuavrig( var1 );
    
    if ( scripts\cp_mp\utility\game_utility::islargemap() )
    {
        if ( level.gametype == "arm" )
        {
            if ( isdefined( level.hqmidpoint ) )
            {
                var6.origin = level.hqmidpoint;
            }
        }
        else
        {
            var6.origin = var0.origin;
        }
    }
    
    var7 = undefined;
    
    if ( istrue( var3 ) )
    {
        var7 = spawnstruct();
        var7.damagetaken = 0;
    }
    else
    {
        var7 = spawn( "script_model", var6 gettagorigin( "tag_origin" ) + ( 0, 0, 5000 ) );
    }
    
    var8 = level.uavsettings[ var1 ].modelbase;
    
    if ( scripts\cp_mp\utility\player_utility::getplayersuperfaction( var0 ) && isdefined( level.uavsettings[ var1 ].modelbasealt ) )
    {
        var8 = level.uavsettings[ var1 ].modelbasealt;
    }
    
    var9 = level.uavsettings[ var1 ].timeout;
    var11 = level.uavsettings[ var1 ].maxhealth;
    var12 = level.uavsettings[ var1 ].teamsplash;
    var13 = var2.streakname;
    
    if ( ref_13320( var0, var1 ) )
    {
        var13 = "directional_uav";
    }
    
    var14 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "sound", "playKillstreakDeployDialog" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "sound", "playKillstreakDeployDialog" ) ]]( var0, var13 );
        var14 = 2;
    }
    
    if ( level.gametype == "br" )
    {
        ref_13ed5( var0, var4, 15000, var13 );
    }
    
    if ( var1 == "harp" )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "harpSpawned" ) )
        {
            var7 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "harpSpawned" ) ]]( var0 );
        }
    }
    
    var0 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "use_" + var13, 1, var14 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
    {
        level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( var12, var0 );
    }
    
    if ( isent( var7 ) )
    {
        var7 setmodel( var8 );
    }
    
    var7.team = var4;
    var7.owner = var0;
    var7.timetoadd = 0;
    var7.uavtype = var1;
    var7.health = level.uavsettings[ var1 ].health;
    var7.maxhealth = var11;
    var7.streakinfo = var2;
    thread monitorowner();
    thread restorestrengthafterhostmigration();
    thread watchgameend();
    
    if ( isent( var7 ) )
    {
        var7 setotherent( var0 );
        var7 scriptmoveroutline();
        var7 scriptmoverthermal();
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "addToActiveKillstreakList" ) )
        {
            var7 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "addToActiveKillstreakList" ) ]]( var1, "Killstreak_Air", var0 );
        }
        
        thread damagetracker();
        thread handleincomingstinger();
        thread perkengineer_manageminimap();
        thread trackvelocity();
        var7 setscriptablepartstate( "lights", "on", 0 );
        var15 = randomintrange( 6000, 6500 );
        
        if ( var7.uavtype == "directional_uav" || var7.uavtype == "harp" )
        {
            var15 = randomintrange( 30000, 31000 );
        }
        
        if ( isdefined( level.spawnpoints ) )
        {
            var16 = level.spawnpoints;
        }
        else
        {
            var16 = level.startspawnpoints;
        }
        
        if ( !isdefined( var16 ) )
        {
            var17 = spawnstruct();
            var17.origin = ( var1.origin[ 0 ], var1.origin[ 1 ], 6969 );
            var16 = [ var17 ];
        }
        
        var18 = var16[ 0 ];
        
        foreach ( var17 in var16 )
        {
            if ( var17.origin[ 2 ] < var18.origin[ 2 ] )
            {
                var18 = var17;
            }
        }
        
        var21 = var18.origin[ 2 ];
        var22 = var7.origin[ 2 ];
        
        if ( var21 < 0 )
        {
            var22 += var21 * -1;
            var21 = 0;
        }
        
        var23 = randomint( 360 );
        var24 = randomint( 1000 );
        
        if ( var8.uavtype == "directional_uav" || var8.uavtype == "harp" )
        {
            var24 = randomintrange( 20000, 22000 );
        }
        
        var25 = var24 + 4000;
        var26 = cos( var23 ) * var25;
        var27 = sin( var23 ) * var25;
        var28 = vectornormalize( ( var26, var27, var16 ) );
        var28 *= var16;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
        {
            var29 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]();
            
            if ( var29 == "br" )
            {
                var30 = ( 0, 0, 3000 );
                var28 += var30;
            }
        }
        
        var8 linkto( var7, "tag_origin", var28, ( 0, var23 - 90, 0 ) );
        thread updateuavmodelvisibility();
    }
    
    var8 [[ level.uavsettings[ var2 ].addfunc ]]();
    
    if ( var2 == "uav" || var2 == "directional_uav" || var8.uavtype == "harp" )
    {
        revealminimapforteam( var8, 1 );
        thread applymapenableonspawn();
    }
    
    if ( isdefined( level.activeuavs[ var5 ] ) && level.activeuavs[ var5 ] > 0 )
    {
        if ( isent( var8 ) )
        {
            foreach ( var32 in level.uavmodels[ var5 ] )
            {
                if ( isdefined( var32.timetoadd ) )
                {
                    var32.timetoadd += 5;
                LOC_0000052d:
                }
            LOC_0000052d:
            }
        }
        else
        {
            var8.timetoadd = 5 * ( level.activeuavs[ var5 ] - 1 );
        }
    }
    
    thread handlewiretap();
    level notify( "uav_update" );
    var8 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause( "death", var11 );
    
    if ( isdefined( var8 ) && var8.damagetaken < var8.maxhealth )
    {
        if ( isent( var8 ) )
        {
            var8 unlink();
            var8.lb_dmg_factor_fuselage = var8.origin + anglestoforward( var8.angles ) * 50000;
            var8 moveto( var8.lb_dmg_factor_fuselage, 50 );
            
            if ( isdefined( level.uavsettings[ var2 ].fxid_leave ) && isdefined( level.uavsettings[ var2 ].fx_leave_tag ) )
            {
                playfxontag( level.uavsettings[ var2 ].fxid_leave, var8, level.uavsettings[ var2 ].fx_leave_tag );
            }
        }
        
        if ( isdefined( var1 ) && !istrue( level.gameended ) )
        {
            var1 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( level.uavsettings[ var8.uavtype ].votimeout, 1 );
        }
        
        var8 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause( "death", 3 );
        
        if ( isdefined( var8 ) && var8.damagetaken < var8.maxhealth )
        {
            var8 notify( "leaving" );
            var8.isleaving = 1;
            
            if ( var2 == "harp" )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "harpTimeout" ) )
                {
                    var8 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "harpTimeout" ) ]]( var1 );
                }
            }
            
            if ( isent( var8 ) )
            {
                var8 moveto( var8.lb_dmg_factor_fuselage, 15 );
            }
            
            var8 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause( "death", 4 + var8.timetoadd );
            
            if ( isdefined( var8 ) && var8.damagetaken < var8.maxhealth )
            {
                var8.leftplayspace = 1;
            }
        }
    }
    
    if ( isdefined( var8 ) )
    {
        var8.owner notify( "uav_finished" );
        
        if ( var2 == "uav" || var2 == "directional_uav" || var2 == "harp" )
        {
            revealminimapforteam( var8, level.minimaponbydefault );
        }
        
        var8 [[ level.uavsettings[ var2 ].removefunc ]]();
        
        if ( isdefined( level.killstreakfinishusefunc ) )
        {
            level thread [[ level.killstreakfinishusefunc ]]( var3 );
        }
        
        if ( isdefined( var8.enemyobjid ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "returnObjectiveID" ) )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "returnObjectiveID" ) ]]( var8.enemyobjid );
            }
            
            var8 notify( "uav_deleteObjective" );
        }
        
        var8.streakinfo.onspray = !istrue( var8.leftplayspace );
        
        if ( !istrue( self.ref_12aa4 ) )
        {
            var8.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var8.streakinfo );
        }
        
        if ( isent( var8 ) )
        {
            var8 delete();
        }
        else
        {
            var8 notify( "death" );
        }
    }
    
    if ( var2 == "directional_uav" )
    {
        if ( isdefined( var1 ) )
        {
            var1.radarshowenemydirection = 0;
        }
        
        if ( level.teambased )
        {
            foreach ( var35 in level.players )
            {
                if ( isdefined( var35 ) && var35.pers[ "team" ] == var5 )
                {
                    var35.radarshowenemydirection = 0;
                LOC_00000867:
                }
            LOC_00000867:
            }
        }
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "printGameAction" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "printGameAction" ) ]]( "killstreak ended - " + var2, var1 );
    }
    
    level notify( "uav_update" );
}

// Params 0
// Size: 0x80
function monitorowner()
{
    self endon( "death" );
    self.owner scripts\engine\utility::ref_143a5( "disconnect", "joined_team" );
    
    if ( isent( self ) )
    {
        self hide();
        var0 = anglestoright( self.angles ) * 200;
        playfx( level.uavsettings[ self.uavtype ].fxid_explode, self.origin, var0 );
        playsoundatpos( self.origin, level.uavsettings[ self.uavtype ].sound_explode );
        self.damagetaken = self.maxhealth;
    }
    
    self notify( "death" );
}

// Params 0
// Size: 0xa5
function restorestrengthafterhostmigration()
{
    self endon( "death" );
    
    for ( ;; )
    {
        level waittill( "host_migration_end" );
        
        if ( level.teambased )
        {
            foreach ( var1 in level.teamnamelist )
            {
                if ( istrue( level.ref_13edd ) )
                {
                    foreach ( var3 in level.squaddata[ var1 ] )
                    {
                        var4 = var1 + var6;
                        var5 = aigroundturret_cancel( var4 );
                        ammobox_showattachmentflyout( var1, var6, var5 );
                    }
                    
                    continue;
                }
                
                var5 = aigroundturret_mountcompleted( var1 );
                _setteamradarstrength( var1, var5 );
            }
        }
    }
}

// Params 0
// Size: 0x8b
function updateuavmodelvisibility()
{
    self endon( "death" );
    
    for ( ;; )
    {
        level scripts\engine\utility::waittill_either( "joined_team", "uav_update" );
        self hide();
        
        foreach ( var1 in level.players )
        {
            if ( level.teambased )
            {
                if ( var1.team != self.team )
                {
                    self showtoplayer( var1 );
                }
                
                continue;
            }
            
            if ( isdefined( self.owner ) && var1 == self.owner )
            {
                continue;
            }
            
            self showtoplayer( var1 );
        }
    }
}

// Params 0
// Size: 0x3ce
function damagetracker()
{
    level endon( "game_ended" );
    self setcandamage( 1 );
    self.damagetaken = 0;
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "mapWeapon" ) )
        {
            var9 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "mapWeapon" ) ]]( var9, var13 );
        }
        
        if ( !isplayer( var1 ) )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            continue;
        }
        
        if ( ( self.uavtype == "directional_uav" || self.uavtype == "harp" ) && ( var4 == "MOD_RIFLE_BULLET" || var4 == "MOD_PISTOL_BULLET" || var4 == "MOD_EXPLOSIVE_BULLET" ) )
        {
            continue;
        }
        
        if ( isdefined( var8 ) && var8 & level.idflags_penetration )
        {
            self.wasdamagedfrombulletpenetration = 1;
        }
        
        if ( isdefined( var8 ) && var8 & level.idflags_ricochet )
        {
            self.wasdamagedfrombulletricochet = 1;
        }
        
        self.wasdamaged = 1;
        var14 = var0;
        
        if ( isplayer( var1 ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "updateDamageFeedback" ) )
            {
                var1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "updateDamageFeedback" ) ]]( "hitequip" );
            }
            
            if ( var4 == "MOD_RIFLE_BULLET" || var4 == "MOD_PISTOL_BULLET" )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
                {
                    if ( var1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_armorpiercing" ) )
                    {
                        var14 += var0 * level.armorpiercingmod;
                    }
                }
            }
        }
        
        var15 = 1;
        var16 = 1;
        var17 = 1;
        var18 = 0;
        var19 = 3;
        
        if ( self.uavtype == "directional_uav" || self.uavtype == "harp" )
        {
            var15 = 5;
            var16 = 6;
            var17 = 7;
            var18 = 0;
            var19 = 0;
        }
        
        if ( isdefined( var9 ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "getModifiedAntiKillstreakDamage" ) )
            {
                var14 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "getModifiedAntiKillstreakDamage" ) ]]( var1, var9, var4, var14, self.maxhealth, var15, var16, var17, var18, var19 );
            }
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "killstreakHit" ) )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "killstreakHit" ) ]]( var1, var9, self, var4, var14 );
            }
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "logAttackerKillstreak" ) )
            {
                self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "logAttackerKillstreak" ) ]]( self, var0, var1, var2, var3, var4, var5, var6, var7, var8, createheadicon( var9 ) );
            }
        }
        
        self.damagetaken += var14;
        
        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( var1 ) && ( !isdefined( self.owner ) || var1 != self.owner ) )
            {
                var20 = level.uavsettings[ self.uavtype ].calloutdestroyed;
                var21 = "destroyed_" + self.uavtype;
                
                if ( self.uavtype == "uav" )
                {
                    var21 = undefined;
                    self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "uav_destroyed", 1 );
                }
                
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "onKillstreakKilled" ) )
                {
                    self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "onKillstreakKilled" ) ]]( self.uavtype, var1, var9, var4, var0, "destroyed_" + self.uavtype, var21, var20 );
                }
                
                if ( isdefined( self.uavremotemarkedby ) && self.uavremotemarkedby != var1 )
                {
                    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "uav", "remoteUAV_processTaggedAssist" ) )
                    {
                        self.uavremotemarkedby thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "uav", "remoteUAV_processTaggedAssist" ) ]]();
                    }
                }
            }
            
            self hide();
            var22 = anglestoright( self.angles ) * 200;
            playfx( level.uavsettings[ self.uavtype ].fxid_explode, self.origin, var22 );
            playsoundatpos( self.origin, level.uavsettings[ self.uavtype ].sound_explode );
            self notify( "death" );
            return;
        }
    }
}

// Params 0
// Size: 0x9b
function uavtracker()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        level waittill( "uav_update" );
        
        if ( level.teambased )
        {
            foreach ( var1 in level.teamnamelist )
            {
                if ( istrue( level.ref_13edd ) )
                {
                    if ( isdefined( level.squaddata ) )
                    {
                        foreach ( var3 in level.squaddata[ var1 ] )
                        {
                            ref_14020( var1, var4 );
                        }
                    }
                    
                    continue;
                }
                
                updateteamuavstatus( var1 );
            }
            
            continue;
        }
        
        updateplayersuavstatus();
    }
}

// Params 0
// Size: 0xa8
function handlewiretap()
{
    foreach ( var1 in level.players )
    {
        if ( isdefined( self.streakname ) && ( self.streakname == "directional_uav" || self.streakname == "counter_uav" || self.uavtype == "harp" ) )
        {
            return;
        }
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
        {
            if ( !var1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_expanded_minimap" ) )
            {
                continue;
            }
        }
        
        if ( var1.team == self.team )
        {
            continue;
        }
        
        thread executewiretapsweeps( var1 );
    }
}

// Params 1
// Size: 0x24
function executewiretapsweeps( var0 )
{
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    triggeroneoffradarsweep( var0 );
    self waittill( "death" );
    triggeroneoffradarsweep( var0 );
}

// Params 1
// Size: 0x5a
function aigroundturret_cancel( var0 )
{
    var1 = scripts\engine\utility::ter_op( isdefined( level.activeuavs[ var0 ] ), level.activeuavs[ var0 ], 0 );
    var2 = scripts\engine\utility::ter_op( isdefined( level.activeadvanceduavs[ var0 ] ), level.activeadvanceduavs[ var0 ], 0 );
    var3 = scripts\engine\utility::ter_op( isdefined( level.activecounteruavs[ var0 ] ), level.activecounteruavs[ var0 ], 0 );
    var3 = level.totalactivecounteruavs - var3;
    return _getradarstrength( var1, var2, var3 );
}

// Params 1
// Size: 0x2e
function aigroundturret_mountcompleted( var0 )
{
    var1 = level.activeuavs[ var0 ];
    var2 = level.activeadvanceduavs[ var0 ];
    var3 = level.totalactivecounteruavs - level.activecounteruavs[ var0 ];
    return _getradarstrength( var1, var2, var3 );
}

// Params 3
// Size: 0x7c
function _getradarstrength( var0, var1, var2 )
{
    var3 = getuavstrengthmin();
    var4 = getuavstrengthmax();
    
    if ( var1 )
    {
        var0 = var4 - getuavstrengthlevelneutral();
    }
    
    if ( level.gametype == "br" )
    {
        var5 = int( clamp( var0 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemydirectional() ) );
    }
    else if ( var3 > 0 )
    {
        var5 = var4;
    }
    else if ( var3 > 0 )
    {
        var5 = var5;
    }
    else
    {
        var5 = int( clamp( var3 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep() ) );
    }
    
    var5 = int( clamp( var5, var5, var5 ) );
    return var5;
}

// Params 2
// Size: 0xd
function _setteamradarstrength( var0, var1 )
{
    updateteamuavstatus( var0, var1 );
}

// Params 3
// Size: 0xf
function ammobox_showattachmentflyout( var0, var1, var2 )
{
    ref_14020( var0, var1, var2 );
}

// Params 2
// Size: 0x22
function updateteamuavstatus( var0, var1 )
{
    if ( isdefined( var1 ) )
    {
        var2 = var1;
    }
    else
    {
        var2 = aigroundturret_mountcompleted( var1 );
    }
    
    ref_13fdf( var2, var1 );
}

// Params 3
// Size: 0x2d
function ref_14020( var0, var1, var2 )
{
    jumpiffalse(isdefined( var2 )) LOC_00000012;
    var3 = var2;
    goto LOC_00000023;
}

// Params 3
// Size: 0x171
function ref_13fdf( var0, var1, var2 )
{
    var0 = int( max( min( var0, level.ref_13ed9 ), level.ref_13ede ) );
    var3 = var0 == level.ref_13ede;
    var4 = !var3;
    var5 = var0 >= level.ref_13eda;
    var6 = !var3;
    
    if ( var0 == level.ref_13edc )
    {
        var7 = "normal_radar";
        var4 = 0;
    }
    else if ( var1 == level.ref_13ed9 || var6 )
    {
        var7 = "constant_radar";
    }
    else if ( var2 == level.ref_13edb )
    {
        var7 = "fast_radar";
    }
    else
    {
        var7 = "normal_radar";
    }
    
    var8 = level.players;
    
    if ( isdefined( var5 ) )
    {
        var8 = level.squaddata[ var4 ][ var5 ].players;
    }
    else if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getTeamData" ) )
    {
        var8 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getTeamData" ) ]]( var4, "players" );
    }
    
    foreach ( var10 in var8 )
    {
        if ( !isdefined( var10 ) )
        {
            continue;
        }
        
        if ( istrue( var10.tracking_obit ) )
        {
            continue;
        }
        
        if ( istrue( var10.ref_133e9 ) )
        {
            continue;
        }
        
        var10.radarstrength = var3;
        var10.isradarblocked = var6;
        var10.hasradar = var7;
        var10.radarshowenemydirection = var7;
        
        if ( var10.radarshowenemydirection )
        {
            var10.radarmode = "constant_radar";
            continue;
        }
        
        var10.radarmode = var7;
    }
}

// Params 0
// Size: 0x16a
function updateplayersuavstatus()
{
    foreach ( var1 in level.players )
    {
        if ( istrue( var1.tracking_obit ) )
        {
            continue;
        }
        
        var2 = level.activeuavs[ var1.guid + "_radarStrength" ];
        var3 = level.totalactivecounteruavs - level.activecounteruavs[ var1.guid ];
        
        if ( var3 > 0 )
        {
            var2 = level.ref_13ede;
        }
        
        var2 = int( max( min( var2, level.ref_13ed9 ), level.ref_13ede ) );
        var1.radarstrength = var2;
        var4 = var1.team == "spectator" || var1.team == "follower" || var1.team == "free";
        
        if ( var2 <= level.ref_13edc || var4 )
        {
            var1.hasradar = 0;
            var1.radarshowenemydirection = 0;
            
            if ( isdefined( var1.radarmode ) && var1.radarmode == "constant_radar" )
            {
                var1.radarmode = "normal_radar";
            }
            
            continue;
        }
        
        if ( var2 >= level.ref_13edb )
        {
            var1.radarmode = "fast_radar";
        }
        else
        {
            var1.radarmode = "normal_radar";
        }
        
        var1.radarshowenemydirection = var2 >= level.ref_13eda;
        
        if ( istrue( var1.radarshowenemydirection ) )
        {
            var1.radarmode = "constant_radar";
        }
        
        var1.hasradar = 1;
    }
}

// Params 0
// Size: 0x41
function handleincomingstinger()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        level waittill( "stinger_fired", var0, var1, var2 );
        
        if ( !isdefined( var2 ) || var2 != self )
        {
            continue;
        }
        
        thread stingerproximitydetonate( var1, var2 );
    }
}

// Params 0
// Size: 0x4b
function trackvelocity()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.velocity = ( 0, 0, 0 );
    
    for ( ;; )
    {
        self.lastorigin = self.origin;
        wait 0.05;
        self.velocity = ( self.origin - self.lastorigin ) / 0.05;
    }
}

// Params 0
// Size: 0x33
function watchgameend()
{
    self endon( "death" );
    self.owner endon( "uav_finished" );
    level waittill( "game_ended" );
    self.ref_12aa4 = 1;
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7( self.streakinfo );
}

// Params 2
// Size: 0xa2
function stingerproximitydetonate( var0, var1 )
{
    self endon( "death" );
    var2 = distance( self.origin, var0 getpointinbounds( 0, 0, 0 ) );
    var3 = var0 getpointinbounds( 0, 0, 0 );
    
    for ( ;; )
    {
        if ( !isdefined( var0 ) )
        {
            var4 = var3;
        }
        else
        {
            var4 = var0 getpointinbounds( 0, 0, 0 );
        }
        
        var3 = var4;
        var5 = distance( self.origin, var4 );
        
        if ( var5 < var2 )
        {
            var2 = var5;
        }
        
        if ( var5 > var2 )
        {
            if ( var5 > 1536 )
            {
                return;
            }
            
            radiusdamage( self.origin, 1536, 600, 600, var1, "MOD_EXPLOSIVE", "iw8_la_gromeo_mp" );
            self hide();
            self notify( "deleted" );
            waitframe();
            self delete();
            var1 notify( "killstreak_destroyed" );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x8e
function adduavmodel()
{
    if ( level.teambased )
    {
        if ( istrue( level.ref_13edd ) )
        {
            self.squadindex = self.owner.squadindex;
            self.é]øêßXxÚı±)s = self.team + self.owner.squadindex;
            level.uavmodels[ self.é]øêßXxÚı±)s ][ level.uavmodels[ self.é]øêßXxÚı±)s ].size ] = self;
            return;
        }
        
        level.uavmodels[ self.team ][ level.uavmodels[ self.team ].size ] = self;
        return;
    }
    
    level.uavmodels[ self.owner.guid + "_" + gettime() ] = self;
}

// Params 0
// Size: 0xf3
function removeuavmodel()
{
    var0 = [];
    jumpiffalse(level.teambased) LOC_000000b6;
    var1 = self.team;
    var2 = self.owner.squadindex;
    
    if ( istrue( level.ref_13edd ) )
    {
        foreach ( var4 in level.uavmodels[ self.é]øêßXxÚı±)s ] )
        {
            if ( !isdefined( var4 ) )
            {
                continue;
            }
            
            var0 = var4;
        }
        
        level.uavmodels[ self.é]øêßXxÚı±)s ] = var0;
        return;
    }
    
    foreach ( var4 in level.uavmodels[ var1 ] )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var0 = var4;
    }
    
    level.uavmodels[ var1 ] = var0;
    return;
}

// Params 0
// Size: 0x144
function addactiveuav()
{
    level.totalactiveuavs++;
    
    if ( level.teambased )
    {
        var0 = self.team;
        
        if ( istrue( level.ref_13edd ) )
        {
            self.squadindex = self.owner.squadindex;
            self.é]øêßXxÚı±)s = self.team + self.owner.squadindex;
            var0 = self.é]øêßXxÚı±)s;
        }
        
        level.activeuavs[ var0 ]++;
        
        if ( self.uavtype == "directional_uav" || self.uavtype == "harp" )
        {
            level.activeadvanceduavs[ var0 ]++;
            level.audio_heli_end_fade_out++;
            return;
        }
        
        return;
    }
    
    level.activeuavs[ self.owner.guid ]++;
    level.activeuavs[ self.owner.guid + "_radarStrength" ]++;
    
    if ( self.uavtype == "directional_uav" || self.uavtype == "harp" )
    {
        level.activeuavs[ self.owner.guid + "_radarStrength" ] = level.activeuavs[ self.owner.guid + "_radarStrength" ] + 2;
        
        if ( !isdefined( level.activeadvanceduavs[ self.owner.guid ] ) )
        {
            level.activeadvanceduavs[ self.owner.guid ] = 0;
        }
        
        level.activeadvanceduavs[ self.owner.guid ]++;
        level.audio_heli_end_fade_out++;
        return;
    }
}

// Params 0
// Size: 0x77
function addactivecounteruav()
{
    if ( level.teambased )
    {
        if ( istrue( level.ref_13edd ) )
        {
            self.squadindex = self.owner.squadindex;
            self.é]øêßXxÚı±)s = self.team + self.owner.squadindex;
            level.activecounteruavs[ self.é]øêßXxÚı±)s ]++;
        }
        else
        {
            level.activecounteruavs[ self.team ]++;
        }
    }
    else
    {
        level.activecounteruavs[ self.owner.guid ]++;
    }
    
    level.totalactivecounteruavs++;
}

// Params 0
// Size: 0x107
function removeactiveuav()
{
    if ( level.teambased )
    {
        var0 = self.team;
        
        if ( istrue( level.ref_13edd ) )
        {
            var0 = self.é]øêßXxÚı±)s;
        }
        
        level.activeuavs[ var0 ]--;
        level.totalactiveuavs--;
        
        if ( self.uavtype == "directional_uav" || self.uavtype == "harp" )
        {
            level.activeadvanceduavs[ var0 ]--;
            level.audio_heli_end_fade_out--;
            return;
        }
        
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        level.activeuavs[ self.owner.guid ]--;
        level.totalactiveuavs--;
        level.activeuavs[ self.owner.guid + "_radarStrength" ]--;
        
        if ( self.uavtype == "directional_uav" || self.uavtype == "harp" )
        {
            level.activeuavs[ self.owner.guid + "_radarStrength" ] = level.activeuavs[ self.owner.guid + "_radarStrength" ] - 2;
            level.activeadvanceduavs[ self.owner.guid ]--;
            level.audio_heli_end_fade_out--;
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x5a
function removeactivecounteruav()
{
    if ( level.teambased )
    {
        if ( istrue( level.ref_13edd ) )
        {
            level.activecounteruavs[ self.é]øêßXxÚı±)s ]--;
        }
        else
        {
            level.activecounteruavs[ self.team ]--;
        }
    }
    else if ( isdefined( self.owner ) )
    {
        level.activecounteruavs[ self.owner.guid ]--;
    }
    
    level.totalactivecounteruavs--;
}

// Params 4
// Size: 0x5a
function watchhighlightfadetime( var0, var1, var2, var3 )
{
    if ( isdefined( var3 ) )
    {
        var3 endon( "death" );
    }
    
    self endon( "disconnect" );
    level endon( "game_ended" );
    scripts\engine\utility::ref_143bf( var2, "leave" );
    
    if ( isdefined( var1 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "outline", "outlineDisable" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "outline", "outlineDisable" ) ]]( var0, var1 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x5b
function getuavrig( var0 )
{
    var1 = undefined;
    
    switch ( var0 )
    {
        case "uav":
            var1 = level.uavrig;
            break;
        case "counter_uav":
            var1 = level.counteruavrig;
            break;
        case "harp":
        case "directional_uav":
            var1 = level.advanceduavrig;
            break;
        case "default":
            break;
    }
    
    return var1;
}

// Params 0
// Size: 0x155
function perkengineer_manageminimap()
{
    self.owner endon( "disconnect" );
    self endon( "uav_deleteObjective" );
    
    switch ( self.uavtype )
    {
        case "uav":
            var0 = "icon_minimap_uav";
            break;
        case "counter_uav":
            var0 = "icon_minimap_counter_uav_enemy";
            break;
        case "harp":
        case "directional_uav":
            var0 = "icon_minimap_auav";
            break;
        default:
            var0 = "icon_minimap_uav";
            break;
    }
    
    var1 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "createObjective" ) )
    {
        var1 = scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "createObjectiveEngineer" );
    }
    
    if ( isdefined( var1 ) )
    {
        self.enemyobjid = self [[ var1 ]]( var0, 1, 1 );
    }
    
    var2 = 0;
    
    for ( ;; )
    {
        var3 = level.players.size;
        
        for ( var4 = 0; var4 < 10 ; var4++ )
        {
            if ( var2 >= level.players.size )
            {
                var2 = 0;
            }
            
            var5 = level.players[ var2 ];
            var2++;
            
            if ( !isdefined( var5 ) )
            {
                continue;
            }
            
            if ( self.enemyobjid != -1 )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
                {
                    if ( var5 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_engineer" ) && istrue( scripts\cp_mp\utility\player_utility::playersareenemies( var5, self.owner ) ) )
                    {
                        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( self.enemyobjid, var5 );
                        continue;
                    }
                    
                    scripts\mp\objidpoolmanager::objective_playermask_hidefrom( self.enemyobjid, var5 );
                }
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0xb1
function startsystemshutdown()
{
    level endon( "game_ended" );
    
    foreach ( var1 in level.players )
    {
        if ( !var1 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        if ( level.teambased && var1.team == self.owner.team )
        {
            continue;
        }
        
        if ( !level.teambased && var1 == self.owner )
        {
            continue;
        }
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
        {
            if ( !var1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_empimmune" ) )
            {
                thread shutdownenemysystem( var1 );
            }
        }
    }
    
    thread applyshutdownonspawn();
}

// Params 1
// Size: 0x117
function givefriendlyperks( var0 )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "givePerk" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "givePerk" ) ]]( "specialty_coldblooded" );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "givePerk" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "givePerk" ) ]]( "specialty_tracker_jammer" );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "givePerk" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "givePerk" ) ]]( "specialty_noscopeoutline" );
    }
    
    var0 waittill( "death" );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "removePerk" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "removePerk" ) ]]( "specialty_coldblooded" );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "removePerk" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "removePerk" ) ]]( "specialty_tracker_jammer" );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "removePerk" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "removePerk" ) ]]( "specialty_noscopeoutline" );
        return;
    }
}

// Params 1
// Size: 0x27
function shutdownenemysystem( var0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self setuavjammed( 1 );
    var0 waittill( "death" );
    self setuavjammed( 0 );
}

// Params 0
// Size: 0x8c
function applyshutdownonspawn()
{
    self endon( "death" );
    level endon( "game_ended" );
    var0 = self.owner;
    var1 = var0.team;
    
    for ( ;; )
    {
        level waittill( "player_spawned", var2 );
        
        if ( var2 == var0 )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( istrue( level.ref_13edd ) )
            {
                if ( var2.team == var1 && var2.squadindex == var0.squadindex )
                {
                    continue;
                }
            }
            else if ( var2.team == var1 )
            {
                continue;
            }
        }
        
        thread shutdownenemysystem( var2 );
    }
}

// Params 0
// Size: 0xfc
function startemppulse()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait 2;
    self playsound( "jammer_drone_charge" );
    playfxontag( scripts\engine\utility::getfx( "jammer_drone_charge" ), self, "tag_origin" );
    wait 1.5;
    stopfxontag( scripts\engine\utility::getfx( "jammer_drone_charge" ), self, "tag_origin" );
    playfxontag( scripts\engine\utility::getfx( "jammer_drone_shockwave" ), self, "tag_origin" );
    self playsound( "jammer_drone_shockwave" );
    
    foreach ( var1 in level.players )
    {
        if ( !var1 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        thread applyuavshellshock();
    }
    
    var3 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getEnemyTeams" ) )
    {
        var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getEnemyTeams" ) ]]( self.team );
    }
    
    foreach ( var5 in var3 )
    {
        destroyactiveobjects( var5, self.owner );
    }
}

// Params 0
// Size: 0x2c
function applyuavshellshock()
{
    self playloopsound( "emp_nade_lp" );
    thread applyuavshellshockvisionset();
    wait 0.5;
    self playsound( "emp_nade_lp_end" );
    self stoploopsound( "emp_nade_lp" );
}

// Params 0
// Size: 0x29
function applyuavshellshockvisionset()
{
    visionsetnaked( "coup_sunblind", 0.05 );
    waitframe();
    visionsetnaked( "coup_sunblind", 0 );
    visionsetnaked( "", 0.5 );
}

// Params 2
// Size: 0xb2
function destroyactiveobjects( var0, var1 )
{
    var2 = "nuke_mp";
    var3 = level.activekillstreaks;
    var4 = [[ level.getactiveequipmentarray ]]();
    var5 = undefined;
    
    if ( isdefined( var3 ) && isdefined( var4 ) )
    {
        var5 = scripts\engine\utility::array_combine_unique( var3, var4 );
    }
    else if ( isdefined( var3 ) )
    {
        var5 = var3;
    }
    else if ( isdefined( var4 ) )
    {
        var5 = var4;
    }
    
    if ( isdefined( var5 ) )
    {
        foreach ( var7 in var5 )
        {
            if ( isdefined( var7 ) )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "doDamageToKillstreak" ) )
                {
                    var7 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "doDamageToKillstreak" ) ]]( 10000, var1, var1, var0, var7.origin, "MOD_EXPLOSIVE", var2 );
                }
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0xff
function revealminimapforteam( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( isai( var2 ) )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( istrue( level.ref_13edd ) )
            {
                if ( self.squadindex != var2.squadindex || self.team != var2.team )
                {
                    continue;
                }
            }
            else if ( self.team != var2.team )
            {
                continue;
            }
        }
        
        if ( !level.teambased && self.owner != var2 )
        {
            continue;
        }
        
        if ( !var2 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        if ( istrue( var0 ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "showMiniMap" ) )
            {
                var2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "showMiniMap" ) ]]();
            }
            
            continue;
        }
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "hideMiniMap" ) )
        {
            var2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "hideMiniMap" ) ]]();
        }
    }
}

// Params 0
// Size: 0x125
function applymapenableonspawn()
{
    self.owner endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    var0 = self.owner.guid;
    
    if ( level.teambased )
    {
        if ( istrue( level.ref_13edd ) )
        {
            var0 = self.team + self.owner.squadindex;
        }
        else
        {
            var0 = self.team;
        }
    }
    
    level notify( "uav_show_minimap_" + var0 );
    level endon( "uav_show_minimap_" + var0 );
    jumpiffalse(istrue( level.istacops )) LOC_00000072;
    return;
}

// Params 2
// Size: 0x1d4
function setforceradars( var0, var1 )
{
    if ( isdefined( var1 ) )
    {
        wait var1;
    }
    
    var2 = getdvarint( "scr_game_forceuav" );
    var3 = "normal_radar";
    var4 = 1;
    var5 = 0;
    
    switch ( var2 )
    {
        case 3:
            var3 = "normal_radar";
            break;
        case 5:
            var3 = "fast_radar";
            var4 = 2;
            break;
        case 6:
            var3 = "constant_radar";
            var5 = 1;
            break;
        default:
            break;
    }
    
    if ( level.teambased )
    {
        if ( istrue( level.ref_13edd ) )
        {
            var6 = 0;
            
            foreach ( var8 in level.teamnamelist )
            {
                foreach ( var12, var10 in level.squaddata[ var8 ] )
                {
                    var11 = var8 + var12;
                    level.radarmode[ var11 ] = var3;
                    level.activeuavs[ var11 ] = var4;
                    level.activeadvanceduavs[ var11 ] = var5;
                    var6++;
                    ammobox_showattachmentflyout( var8, var12, var2 );
                }
            }
            
            level.audio_heli_end_fade_out = var6;
            return;
        }
        
        foreach ( var16, var15 in level.teamnamelist )
        {
            level.radarmode[ var15 ] = var3;
            level.activeuavs[ var15 ] = var4;
            level.activeadvanceduavs[ var15 ] = var5;
            level.audio_heli_end_fade_out = level.teamnamelist.size;
            _setteamradarstrength( var15, var2 );
        }
        
        return;
    }
    
    var15 = scripts\engine\utility::ter_op( var16 > 0, level.ref_13ed9, level.ref_13edc + var15 );
    level.radarmode[ var3.guid ] = var14;
    var3.radarstrength = var15;
    level.activeuavs[ var3.guid + "_radarStrength" ] = var15;
    level.activeadvanceduavs[ var3.guid ] = var16;
    level.audio_heli_end_fade_out = level.teamnamelist.size;
    updateplayersuavstatus();
}

// Params 3
// Size: 0x5f
function ref_13ed5( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var3 = ref_13ed6( var0, var1 );
    
    foreach ( var5 in var3 )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "dangerNotifyPlayer" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "dangerNotifyPlayer" ) ]]( var5, var2, 1 );
        }
    }
}

// Params 2
// Size: 0xc9
function ref_13ed6( var0, var1 )
{
    var2 = [];
    var3 = level.teamdata[ var0 ][ "players" ];
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var5 ) || !var5 scripts\cp_mp\utility\player_utility::_isalive() || var5 scripts\cp_mp\utility\player_utility::_isalive() && istrue( var5.gulag ) )
        {
            continue;
        }
        
        var6 = scripts\common\utility::playersincylinder( var5.origin, var1, var3 );
        
        foreach ( var8 in var6 )
        {
            if ( var2.size > 0 )
            {
                var9 = ref_13ed7( var8, var2 );
                
                if ( istrue( var9 ) )
                {
                    continue;
                }
            }
            
            var2 = var8;
        }
    }
    
    return var2;
}

// Params 2
// Size: 0x3f
function ref_13ed7( var0, var1 )
{
    var2 = 0;
    
    foreach ( var4 in var1 )
    {
        if ( isdefined( var4 ) && var0 == var4 )
        {
            var2 = 1;
            break;
        }
    }
    
    return var2;
}

