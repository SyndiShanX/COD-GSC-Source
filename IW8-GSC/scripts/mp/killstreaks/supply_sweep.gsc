
// Params 0
// Size: 0x69
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "supply_sweep", &tryusesupplysweepfromstruct );
    teleportplayertoselection();
    
    for ( var0 = 0; var0 < level.teamnamelist.size ; var0++ )
    {
        level.teamdata[ level.teamnamelist[ var0 ] ][ "activeSupplySweeps" ] = [];
        level.teamdata[ level.teamnamelist[ var0 ] ][ "supplySweepEndTime" ] = 0;
        level.teamdata[ level.teamnamelist[ var0 ] ][ "numSupplySweepKillstreakStarted" ] = 0;
    }
}

// Params 0
// Size: 0x28
function teleportplayertoselection()
{
    game[ "dialog" ][ "supply_sweep_start" ] = "trials_killstreak_supplysweep_start";
    game[ "dialog" ][ "supply_sweep_end" ] = "trials_killstreak_supplysweep_end";
}

// Params 1
// Size: 0xae, Type: bool
function tryusesupplysweepfromstruct( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var1 = undefined;
    
    if ( istrue( level.ˆ¾èé{•À£ð¶ƒPŸ©w‹‹û ) )
    {
        var1 = "MP_BR_INGAME_TU_WZ335/AUAVSCAN_IN_PROGRESS";
    }
    else if ( istrue( self.hasradar ) )
    {
        var1 = "MP_BR_INGAME_TU_WZ350/UAV_SCAN_IN_PROGRESS";
    }
    
    if ( isdefined( var1 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var1 );
        }
        
        return false;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( var0 ) )
        {
            return false;
        }
    }
    
    var2 = playcallingesture( var0 );
    
    if ( !istrue( var2 ) )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( var0 ) )
        {
            return false;
        }
    }
    
    thread launchsupplysweep( level, self );
    return true;
}

// Params 1
// Size: 0x49, Type: bool
function playcallingesture( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !istrue( var0.ref_133cc ) )
    {
        var1 = "ks_gesture_generic_mp";
        
        if ( scripts\cp_mp\utility\game_utility::ref_140a9() )
        {
            var1 = "ks_gesture_generic_mp_ch3";
        }
        
        var2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy( var0, getcompleteweaponname( var1 ) );
        
        if ( !istrue( var2 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 2
// Size: 0x217
function launchsupplysweep( var0, var1 )
{
    var2 = var0.team;
    onstartsupplysweep( var0, var2, var1 );
    var3 = getdvarint( "scr_supply_sweep_duration", 20 );
    var4 = level.teamdata[ var2 ][ "activeSupplySweeps" ].size > 0;
    var5 = undefined;
    
    if ( var4 )
    {
        var5 = level.teamdata[ var2 ][ "supplySweepEndTime" ] + var3 * 1000;
    }
    else
    {
        var5 = gettime() + var3 * 1000;
    }
    
    level.teamdata[ var2 ][ "activeSupplySweeps" ] = scripts\engine\utility::array_add( level.teamdata[ var2 ][ "activeSupplySweeps" ], var1 );
    level.teamdata[ var2 ][ "supplySweepEndTime" ] = var5;
    var6 = scripts\mp\utility\teams::getteamdata( var2, "players" );
    
    foreach ( var8 in var6 )
    {
        if ( isdefined( var8 ) && !var8 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            var8 method_87ec( 1 );
            var8 playsoundtoplayer( "activate_supply_sweep", var8 );
        }
    }
    
    var10 = level.teamdata[ var2 ][ "activeSupplySweeps" ].size >= 3;
    advancedsupplysweepsetenabled( var10, var2 );
    var11 = max( ( var5 - gettime() ) / 1000, 0.1 );
    scripts\engine\utility::ref_143b9( var11, "game_ended" );
    level.teamdata[ var2 ][ "activeSupplySweeps" ] = scripts\engine\utility::array_remove( level.teamdata[ var2 ][ "activeSupplySweeps" ], var1 );
    var10 = level.teamdata[ var2 ][ "activeSupplySweeps" ].size >= 3;
    advancedsupplysweepsetenabled( var10, var2 );
    var12 = level.teamdata[ var2 ][ "activeSupplySweeps" ].size == 0;
    
    if ( var12 )
    {
        var6 = scripts\mp\utility\teams::getteamdata( var2, "players" );
        
        foreach ( var8 in var6 )
        {
            if ( isdefined( var8 ) )
            {
                var8 method_87ec( 0 );
            }
        }
    }
    else
    {
        while ( !var12 && !level.gameended )
        {
            var5 = level.teamdata[ var2 ][ "supplySweepEndTime" ];
            var11 = max( ( var5 - gettime() ) / 1000, 0.1 );
            scripts\engine\utility::ref_143b9( var11, "game_ended" );
            var12 = level.teamdata[ var2 ][ "activeSupplySweeps" ].size == 0;
        }
    }
    
    onendsupplysweep( var0, var2, var1 );
}

// Params 3
// Size: 0x88
function onstartsupplysweep( var0, var1, var2 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "logKillstreakEvent" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "logKillstreakEvent" ) ]]( var2.streakname, var0.origin );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
    {
        level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "used_supply_sweep", var0 );
    }
    
    if ( !istrue( level.gameended ) )
    {
        playsupplysweepoperatordialog( var1, "supply_sweep_start" );
    }
    
    level.teamdata[ var1 ][ "numSupplySweepKillstreakStarted" ]++;
}

// Params 3
// Size: 0x9a
function onendsupplysweep( var0, var1, var2 )
{
    level.teamdata[ var1 ][ "numSupplySweepKillstreakStarted" ]--;
    
    if ( level.teamdata[ var1 ][ "numSupplySweepKillstreakStarted" ] == 0 && !istrue( level.gameended ) )
    {
        playsupplysweepoperatordialog( var1, "supply_sweep_end" );
    }
    
    if ( isdefined( level.killstreakfinishusefunc ) )
    {
        level thread [[ level.killstreakfinishusefunc ]]( var2 );
    }
    
    if ( isdefined( var0 ) && !istrue( level.ref_12aa4 ) )
    {
        var0 scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var2 );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "printGameAction" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "printGameAction" ) ]]( "killstreak ended - " + var2.streakname, var0 );
        return;
    }
}

// Params 2
// Size: 0x48
function advancedsupplysweepsetenabled( var0, var1 )
{
    var2 = scripts\mp\utility\teams::getteamdata( var1, "players" );
    
    foreach ( var4 in var2 )
    {
        if ( isdefined( var4 ) && !var4 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            var4 method_87ed( var0 );
        }
    }
}

// Params 2
// Size: 0x6a
function playsupplysweepoperatordialog( var0, var1 )
{
    if ( istrue( level.little_bird_mg_mp_init ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "dialog" ][ var1 ] ) )
    {
        return;
    }
    
    var2 = "dx_bra_pilo_" + game[ "dialog" ][ var1 ];
    var3 = level.teamdata[ var0 ][ "players" ];
    
    foreach ( var5 in var3 )
    {
        thread supplysweepdialogplayer( var2, var1, var5, 1, 0 );
    }
}

// Params 6
// Size: 0x62
function supplysweepdialogplayer( var0, var1, var2, var3, var4, var5 )
{
    level endon( "game_ended" );
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var2 endon( "death_or_disconnect" );
    
    if ( !isalive( var2 ) && !istrue( var4 ) )
    {
        return;
    }
    
    if ( var2 scripts\mp\gametypes\br_public::ref_11c7d( var1, var3 ) )
    {
        return;
    }
    
    if ( isdefined( var0 ) )
    {
        var0 = tolower( var0 );
        var6 = lookupsoundlength( var0, 1 ) / 1000;
        
        if ( isdefined( var5 ) )
        {
            wait var5;
        }
        
        var2 queuedialogforplayer( var0, var1, var6 );
        return;
    }
}

