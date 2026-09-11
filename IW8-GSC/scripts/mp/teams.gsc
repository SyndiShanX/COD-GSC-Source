
// Params 0
// Size: 0x85a
function init()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "teams", "createOperatorCustomization", &createoperatorcustomization );
    level.teambalance = getdvarint( "scr_teambalance" );
    level.maxclients = getmaxclients();
    var0 = [ "free", "axis", "allies", "team_three", "team_four", "team_five", "team_six", "team_seven", "team_eight", "team_nine", "team_ten", "team_eleven", "team_twelve", "team_thirteen", "team_fourteen", "team_fifteen", "team_sixteen", "team_seventeen", "team_eighteen", "team_nineteen", "team_twenty", "team_twenty_one", "team_twenty_two", "team_twenty_three", "team_twenty_four", "team_twenty_five", "team_twenty_six", "team_twenty_seven", "team_twenty_eight", "team_twenty_nine", "team_thirty", "team_thirty_one", "team_thirty_two", "team_thirty_three", "team_thirty_four", "team_thirty_five", "team_thirty_six", "team_thirty_seven", "team_thirty_eight", "team_thirty_nine", "team_forty", "team_forty_one", "team_forty_two", "team_forty_three", "team_forty_four", "team_forty_five", "team_forty_six", "team_forty_seven", "team_forty_eight", "team_forty_nine", "team_fifty", "team_fifty_one", "team_fifty_two", "team_fifty_three", "team_fifty_four", "team_fifty_five", "team_fifty_six", "team_fifty_seven", "team_fifty_eight", "team_fifty_nine", "team_sixty", "team_sixty_one", "team_sixty_two", "team_sixty_three", "team_sixty_four", "team_sixty_five", "team_sixty_six", "team_sixty_seven", "team_sixty_eight", "team_sixty_nine", "team_seventy", "team_seventy_one", "team_seventy_two", "team_seventy_three", "team_seventy_four", "team_seventy_five", "team_seventy_six", "team_seventy_seven", "team_seventy_eight", "team_seventy_nine", "team_eighty", "team_eighty_one", "team_eighty_two", "team_eighty_three", "team_eighty_four", "team_eighty_five", "team_eighty_six", "team_eighty_seven", "team_eighty_eight", "team_eighty_nine", "team_ninety", "team_ninety_one", "team_ninety_two", "team_ninety_three", "team_ninety_four", "team_ninety_five", "team_ninety_six", "team_ninety_seven", "team_ninety_eight", "team_ninety_nine", "team_hundred", "team_hundred_one", "team_hundred_two", "team_hundred_three", "team_hundred_four", "team_hundred_five", "team_hundred_six", "team_hundred_seven", "team_hundred_eight", "team_hundred_nine", "team_hundred_ten", "team_hundred_eleven", "team_hundred_twelve", "team_hundred_thirteen", "team_hundred_fourteen", "team_hundred_fifteen", "team_hundred_sixteen", "team_hundred_seventeen", "team_hundred_eightteen", "team_hundred_nineteen", "team_hundred_twenty", "team_hundred_twenty_one", "team_hundred_twenty_two", "team_hundred_twenty_three", "team_hundred_twenty_four", "team_hundred_twenty_five", "team_hundred_twenty_six", "team_hundred_twenty_seven", "team_hundred_twenty_eight", "team_hundred_twenty_nine", "team_hundred_thirty", "team_hundred_thirty_one", "team_hundred_thirty_two", "team_hundred_thirty_three", "team_hundred_thirty_four", "team_hundred_thirty_five", "team_hundred_thirty_six", "team_hundred_thirty_seven", "team_hundred_thirty_eight", "team_hundred_thirty_nine", "team_hundred_forty", "team_hundred_forty_one", "team_hundred_forty_two", "team_hundred_forty_three", "team_hundred_forty_four", "team_hundred_forty_five", "team_hundred_forty_six", "team_hundred_forty_seven", "team_hundred_forty_eight", "team_hundred_forty_nine", "team_hundred_fifty", "team_hundred_fifty_one", "team_hundred_fifty_two", "team_hundred_fifty_three", "team_hundred_fifty_four", "team_hundred_fifty_five", "team_hundred_fifty_six", "team_hundred_fifty_seven", "team_hundred_fifty_eight", "team_hundred_fifty_nine", "team_hundred_sixty", "team_hundred_sixty_one", "team_hundred_sixty_two", "team_hundred_sixty_three", "team_hundred_sixty_four", "team_hundred_sixty_five", "team_hundred_sixty_six", "team_hundred_sixty_seven", "team_hundred_sixty_eight", "team_hundred_sixty_nine", "team_hundred_seventy", "team_hundred_seventy_one", "team_hundred_seventy_two", "team_hundred_seventy_three", "team_hundred_seventy_four", "team_hundred_seventy_five", "team_hundred_seventy_six", "team_hundred_seventy_seven", "team_hundred_seventy_eight", "team_hundred_seventy_nine", "team_hundred_eighty", "team_hundred_eighty_one", "team_hundred_eighty_two", "team_hundred_eighty_three", "team_hundred_eighty_four", "team_hundred_eighty_five", "team_hundred_eighty_six", "team_hundred_eighty_seven", "team_hundred_eighty_eight", "team_hundred_eighty_nine", "team_hundred_ninety", "team_hundred_ninety_one", "team_hundred_ninety_two", "team_hundred_ninety_three", "team_hundred_ninety_four", "team_hundred_ninety_five", "team_hundred_ninety_six", "team_hundred_ninety_seven", "team_hundred_ninety_eight", "team_hundred_ninety_nine", "team_two_hundred", "spectator", "follower" ];
    level.allteamnamelist = var0;
    var1 = [ "axis", "allies" ];
    var2 = [ "SAS", "RUSF", "USMC", "SABF" ];
    var3 = scripts\mp\utility\teams::getcustomgametypeteammax();
    var3 = min( var3, getdvarint( "scr_" + scripts\mp\utility\game::getgametype() + "_teamcount", -1 ) );
    
    if ( !isdefined( level.teammaxfill ) )
    {
        if ( getdvarint( "scr_" + scripts\mp\utility\game::getgametype() + "_teammaxfill", -1 ) != -1 )
        {
            level.teammaxfill = getdvarint( "scr_" + scripts\mp\utility\game::getgametype() + "_teammaxfill", 1 ) > 0;
        }
        else
        {
            level.teammaxfill = var3 == 50;
        }
    }
    
    level.maxteamsize = getdvarint( "scr_" + scripts\mp\utility\game::getgametype() + "_teamsize", 0 );
    level.maxsquadsize = getdvarint( "scr_" + scripts\mp\utility\game::getgametype() + "_squadsize", 4 );
    var4 = 1;
    var5 = -1;
    
    if ( var3 >= 3 )
    {
        for ( var6 = 3; var6 < var3 + var4 ; var6++ )
        {
            var1 = level.allteamnamelist[ var6 ];
            
            if ( !isdefined( game[ level.allteamnamelist[ var6 ] ] ) )
            {
                game[ level.allteamnamelist[ var6 ] ] = var2[ ( var6 + var5 ) % var2.size ];
            }
        }
    }
    
    var7 = ref_132e6();
    
    if ( var7 && !scripts\engine\utility::array_contains( var1, "team_two_hundred" ) )
    {
        level.teamnamelist = scripts\engine\utility::array_add( var1, "team_two_hundred" );
    }
    else
    {
        level.teamnamelist = var1;
    }
    
    level.multiteambased = level.teamnamelist.size > 2 || scripts\mp\utility\game::getgametype() == "br" && scripts\mp\menus::ref_13733();
    level.teamdata = [];
    
    foreach ( var9 in var0 )
    {
        level.teamdata[ var9 ] = [];
        level.teamdata[ var9 ][ "players" ] = [];
        level.teamdata[ var9 ][ "alivePlayers" ] = [];
        level.teamdata[ var9 ][ "teamCount" ] = 0;
        level.teamdata[ var9 ][ "aliveCount" ] = 0;
        level.teamdata[ var9 ][ "livesCount" ] = 0;
        level.teamdata[ var9 ][ "hasSpawned" ] = 0;
        level.teamdata[ var9 ][ "oneLeftTime" ] = 0;
        level.teamdata[ var9 ][ "twoLeft" ] = 0;
        level.teamdata[ var9 ][ "oneLeft" ] = 0;
        
        if ( level.multiteambased )
        {
            level.teamdata[ var9 ][ "deathEvent" ] = 0;
        }
    }
    
    foreach ( var9 in var1 )
    {
        scripts\mp\utility\teams::rpgafterspawnfunc( var9 );
        scripts\mp\utility\teams::getteamname( var9 );
        scripts\mp\utility\teams::getteamshortname( var9 );
        scripts\mp\utility\teams::getteamicon( var9 );
        scripts\mp\utility\teams::getteamheadicon( var9 );
        scripts\mp\utility\teams::getteamvoiceinfix( var9 );
    }
    
    level.teambased = var3 > 1;
    
    if ( scripts\mp\utility\game::unset_relic_grounded() )
    {
    }
    
    setdvar( "ui_numteams", level.teamnamelist.size );
    
    if ( getdvarint( "scr_game_forceuav" ) > 1 && level.teambased )
    {
        level thread scripts\cp_mp\killstreaks\uav::setforceradars( undefined, 1 );
    }
    
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    thread onplayerconnect();
    thread trackplayedtime();
    initoperatorcustomization();
    initnightvisionheadoverrides();
    wait 0.15;
    thread updateplayertimes();
    thread finalizeplayertimes();
    
    if ( level.teambased )
    {
        thread updateteambalance();
    }
    
    if ( scripts\mp\utility\game::matchmakinggame() && !dotournamentendgame() && !getdvarint( "scr_disable_anti_afk", 0 ) )
    {
        thread watchafk();
    }
    
    if ( isdefined( level.playerentersafearea ) )
    {
        level thread [[ level.playerentersafearea ]]();
    }
    
    if ( getdvarint( "scr_debug_teams", 0 ) == 1 )
    {
        thread istempsfxent();
        return;
    }
}

// Params 0
// Size: 0x83
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", var0 );
        var0.timeplayed = [];
        var0.timeplayed[ "game" ] = 0;
        var0.timeplayed[ "total" ] = 0;
        var0.timeplayed[ "missionTeam" ] = 0;
        var0.timeplayed[ "other" ] = 0;
        var0.timeplayed[ "timeDead" ] = 0;
        var0.timeplayed[ "gulag" ] = 0;
        var0.timeplayed[ "rebirthRespawn" ] = 0;
    }
}

// Params 1
// Size: 0xb
function onjoinedteam( var0 )
{
    updateteamtime( var0 );
}

// Params 1
// Size: 0x1d
function onjoinedspectators( var0 )
{
    if ( isdefined( var0.pers ) )
    {
        var0.pers[ "teamTime" ] = undefined;
        return;
    }
}

// Params 0
// Size: 0x54
function trackplayedtime()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    while ( !level.gameended )
    {
        wait 1;
        
        foreach ( var1 in level.players )
        {
            trackplayedtimeupdate( var1 );
        }
    }
}

// Params 0
// Size: 0x87
function trackplayedtimeupdate()
{
    if ( isdefined( self.timeplayed ) )
    {
        var0 = self.sessionteam;
        
        if ( !isdefined( self.timeplayed[ "game" ] ) )
        {
            self.timeplayed[ "game" ] = 0;
        }
        else
        {
            self.timeplayed[ "game" ]++;
        }
        
        if ( var0 != "spectator" && var0 != "follower" )
        {
            self.timeplayed[ "total" ]++;
            self.timeplayed[ "missionTeam" ]++;
            
            if ( !scripts\mp\utility\player::isreallyalive( self ) )
            {
                self.timeplayed[ "timeDead" ]++;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x66
function updateplayertimes()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var0 = level.players.size;
        var1 = 0;
        
        while ( var1 < var0 )
        {
            scripts\mp\hostmigration::waittillhostmigrationdone();
            
            for ( var2 = 0; var2 < 20 ; var2++ )
            {
                var3 = var1 + var2;
                var4 = level.players[ var3 ];
                
                if ( isdefined( var4 ) )
                {
                    updateplayedtime( var4 );
                }
            }
            
            waitframe();
            var1 += 20;
        }
        
        wait 10;
    }
}

// Params 0
// Size: 0x54
function finalizeplayertimes()
{
    while ( !level.gameended )
    {
        wait 2;
    }
    
    foreach ( var1 in level.players )
    {
        updateplayedtime( var1 );
        
        if ( !scripts\mp\utility\game::runleanthreadmode() )
        {
            var1 scripts\mp\persistence::writebufferedstats();
            var1 scripts\mp\persistence::updateweaponbufferedstats();
        }
    }
}

// Params 0
// Size: 0xc6
function updateplayedtime()
{
    if ( isai( self ) )
    {
        return;
    }
    
    scripts\mp\playerstats_interface::addtoplayerstatbuffered( self.timeplayed[ "game" ], "matchStats", "timePlayedTotal" );
    scripts\mp\persistence::stataddchildbuffered( "round", "timePlayed", self.timeplayed[ "game" ], 1 );
    
    if ( scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        self.timeplayed[ "gulag" ] = self.timeplayed[ "gulag" ] + self.timeplayed[ "game" ];
    }
    else if ( scripts\mp\gametypes\br_public::isplayerwaitingrebirthrespawn() )
    {
        self.timeplayed[ "rebirthRespawn" ] = self.timeplayed[ "rebirthRespawn" ] + self.timeplayed[ "game" ];
    }
    
    if ( game[ "state" ] == "postgame" )
    {
        return;
    }
    
    self.timeplayed[ "game" ] = 0;
    self.timeplayed[ "missionTeam" ] = 0;
}

// Params 0
// Size: 0x22
function updateteamtime()
{
    if ( game[ "state" ] != "playing" )
    {
        return;
    }
    
    self.pers[ "teamTime" ] = gettime();
}

// Params 0
// Size: 0x2a
function updateteambalancedvar()
{
    for ( ;; )
    {
        var0 = getdvarint( "scr_teambalance" );
        
        if ( level.teambalance != var0 )
        {
            level.teambalance = getdvarint( "scr_teambalance" );
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0xb2
function updateteambalance()
{
    thread updateteambalancedvar();
    wait 0.15;
    
    if ( level.teambalance && scripts\mp\utility\game::isroundbased() )
    {
        if ( isdefined( game[ "BalanceTeamsNextRound" ] ) )
        {
            scripts\mp\hud_message::showerrormessagetoallplayers( "MP/AUTOBALANCE_NEXT_ROUND" );
        }
        
        level waittill( "restarting" );
        
        if ( isdefined( game[ "BalanceTeamsNextRound" ] ) )
        {
            balanceteams( level );
            game[ "BalanceTeamsNextRound" ] = undefined;
            return;
        }
        
        if ( !getteambalance() )
        {
            game[ "BalanceTeamsNextRound" ] = 1;
            return;
        }
        
        return;
    }
    
    level endon( "game_ended" );
    
    for ( ;; )
    {
        if ( level.teambalance )
        {
            if ( !getteambalance() )
            {
                scripts\mp\hud_message::showerrormessagetoallplayers( "MP/AUTOBALANCE_SECONDS", 15 );
                wait 15;
                
                if ( !getteambalance() )
                {
                    balanceteams( level );
                }
            }
            
            wait 59;
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0xce
function getteambalance()
{
    GscBinSkip1( 0x45, "allies", 0 );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 0
// Size: 0x241
function balanceteams()
{
    iprintlnbold( game[ "strings" ][ "autobalance" ] );
    var0 = [];
    var1 = [];
    var2 = level.players;
    
    for ( var3 = 0; var3 < var2.size ; var3++ )
    {
        if ( !isdefined( var2[ var3 ].pers[ "teamTime" ] ) )
        {
            continue;
        }
        
        if ( isdefined( var2[ var3 ].pers[ "team" ] ) && var2[ var3 ].pers[ "team" ] == "allies" )
        {
            var0 = var2[ var3 ];
            continue;
        }
        
        if ( isdefined( var2[ var3 ].pers[ "team" ] ) && var2[ var3 ].pers[ "team" ] == "axis" )
        {
            var1 = var2[ var3 ];
        }
    }
    
    var4 = undefined;
    
    while ( var0.size > var1.size + 1 || var1.size > var0.size + 1 )
    {
        if ( var0.size > var1.size + 1 )
        {
            for ( var5 = 0; var5 < var0.size ; var5++ )
            {
                if ( isdefined( var0[ var5 ].dont_auto_balance ) )
                {
                    continue;
                }
                
                if ( !isdefined( var4 ) )
                {
                    var4 = var0[ var5 ];
                    continue;
                }
                
                if ( var0[ var5 ].pers[ "teamTime" ] > var4.pers[ "teamTime" ] )
                {
                    var4 = var0[ var5 ];
                }
            }
            
            var4 [[ level.onteamselection ]]( "axis" );
        }
        else if ( var1.size > var0.size + 1 )
        {
            for ( var5 = 0; var5 < var1.size ; var5++ )
            {
                if ( isdefined( var1[ var5 ].dont_auto_balance ) )
                {
                    continue;
                }
                
                if ( !isdefined( var4 ) )
                {
                    var4 = var1[ var5 ];
                    continue;
                }
                
                if ( var1[ var5 ].pers[ "teamTime" ] > var4.pers[ "teamTime" ] )
                {
                    var4 = var1[ var5 ];
                }
            }
            
            var4 [[ level.onteamselection ]]( "allies" );
        }
        
        var4 = undefined;
        var0 = [];
        var1 = [];
        var2 = level.players;
        
        for ( var3 = 0; var3 < var2.size ; var3++ )
        {
            if ( isdefined( var2[ var3 ].pers[ "team" ] ) && var2[ var3 ].pers[ "team" ] == "allies" )
            {
                var0 = var2[ var3 ];
                continue;
            }
            
            if ( isdefined( var2[ var3 ].pers[ "team" ] ) && var2[ var3 ].pers[ "team" ] == "axis" )
            {
                var1 = var2[ var3 ];
            }
        }
    }
}

// Params 2
// Size: 0x5
function playermodelforweapon( var0, var1 )
{
    
}

// Params 0
// Size: 0xba
function countplayers()
{
    var0 = [];
    
    for ( var1 = 0; var1 < level.teamnamelist.size ; var1++ )
    {
        var0 = 0;
    }
    
    for ( var1 = 0; var1 < level.players.size ; var1++ )
    {
        if ( level.players[ var1 ] == self )
        {
            continue;
        }
        
        if ( level.players[ var1 ].pers[ "team" ] == "spectator" )
        {
            continue;
        }
        
        if ( level.players[ var1 ].pers[ "team" ] == "follower" )
        {
            continue;
        }
        
        if ( isdefined( level.players[ var1 ].pers[ "team" ] ) )
        {
            var0++;
        }
    }
    
    return var0;
}

// Params 3
// Size: 0x56
function setcharactermodels( var0, var1, var2 )
{
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
    }
    
    if ( !isagent( self ) )
    {
        var0 = self getcustomizationbody();
        var1 = self getcustomizationhead();
        var2 = self getcustomizationviewmodel();
    }
    
    self setmodel( var0 );
    self setviewmodel( var2 );
    
    if ( isdefined( var1 ) )
    {
        self attach( var1, "", 1 );
        self.headmodel = var1;
        return;
    }
}

// Params 1
// Size: 0xf4
function forcecustomization( var0 )
{
    var1 = undefined;
    var2 = undefined;
    var3 = [];
    
    switch ( var0 )
    {
        case 1:
            var1 = "mp_warfighter_body_1_3";
            var2 = "mp_warfighter_head_1_3";
            break;
        case 2:
            var1 = "mp_body_heavy_1_2";
            var2 = "mp_head_heavy_1_2";
            break;
        case 3:
            if ( scripts\mp\utility\game::getgametype() == "infect" )
            {
                var1 = "mp_synaptic_body_1_4";
                var2 = "mp_synaptic_head_1_4";
            }
            else
            {
                var1 = "mp_synaptic_body_1_1";
                var2 = "mp_synaptic_head_1_1";
            }
            
            break;
        case 4:
            var1 = "mp_ftl_body_3_1";
            var2 = "mp_ftl_head_5_1";
            break;
        case 5:
            var1 = "mp_stryker_body_2_1";
            var2 = "mp_stryker_head_3_1";
            break;
        case 6:
            var1 = "mp_ghost_body_1_3";
            var2 = "mp_ghost_head_1_1";
            break;
    }
    
    self setcustomization( var1, var2 );
    var4 = self getcustomizationbody();
    var5 = self getcustomizationhead();
    var6 = self getcustomizationviewmodel();
    setcharactermodels( var4, var5, var6 );
}

// Params 0
// Size: 0x58
function getcustomization()
{
    var0 = [];
    
    if ( isdefined( self.operatorcustomization ) )
    {
        GscBinSkip0( 0x2e, "body", self.operatorcustomization.body );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    [ var0 ] = getoperatorcustomization();
    var0 = var1[ 1 ];
    return var0;
}

// Params 0
// Size: 0x36
function setmodelfromcustomization()
{
    var0 = getcustomization();
    self setcustomization( var0[ "body" ], var0[ "head" ] );
    var1 = self getcustomizationbody();
    var2 = self getcustomizationhead();
    var3 = self getcustomizationviewmodel();
    setcharactermodels( var1, var2, var3 );
}

// Params 0
// Size: 0x7
function getplayercustomization()
{
    return getoperatorcustomization();
}

// Params 0
// Size: 0xc
function getplayerbodymodel()
{
    var0 = getoperatorcustomization();
    return var0[ 0 ];
}

// Params 0
// Size: 0xd
function getplayerheadmodel()
{
    var0 = getoperatorcustomization();
    return var0[ 1 ];
}

// Params 1
// Size: 0x2b
function getplayerviewmodelfrombody( var0 )
{
    var1 = tablelookup( "mp/cac/bodies.csv", 1, var0, 3 );
    
    if ( !isdefined( var1 ) || var1 == "" )
    {
        var1 = "viewhands_mp_base_iw8";
    }
    
    return var1;
}

// Params 1
// Size: 0x12
function getplayerfoleytype( var0 )
{
    return tablelookup( "mp/cac/bodies.csv", 1, var0, 5 );
}

// Params 1
// Size: 0x11
function getplayermodelname( var0 )
{
    return tablelookup( "mp/cac/bodies.csv", 0, var0, 1 );
}

// Params 0
// Size: 0x133
function setupplayermodel()
{
    var0 = 1;
    
    if ( istrue( var0 ) )
    {
        var1 = undefined;
        var2 = undefined;
        
        if ( !isdefined( self.operatorcustomization ) || self.operatorcustomization.rebuild == 1 )
        {
            createoperatorcustomization();
        }
        
        setcharactermodels( self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm );
        scripts\mp\utility\player::_setsuit( self.operatorcustomization.suit );
        scripts\cp_mp\execution::_giveexecution( self.operatorcustomization.execution );
        return;
    }
    
    if ( isai( self ) )
    {
        var3 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef( self.loadoutarchetype ) + 1;
    }
    else if ( isdefined( self.changedarchetypeinfo ) )
    {
        var3 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef( self.changedarchetypeinfo.archetype ) + 1;
    }
    else
    {
        var3 = getdvarint( "forceArchetype", 0 );
    }
    
    if ( scripts\mp\utility\game::getgametype() == "infect" && self.team == "axis" )
    {
        var3 = 3;
    }
    
    if ( isplayer( self ) && var3 == 0 )
    {
        setmodelfromcustomization();
    }
    else
    {
        forcecustomization( var3 );
    }
    
    self.voice = "delta";
    
    if ( scripts\mp\utility\game::isanymlgmatch() && !isai( self ) )
    {
        var4 = getplayerbodymodel();
        
        if ( issubstr( var4, "fullbody_sniper" ) )
        {
            thread forcedefaultmodel();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x76
function setuppingspecificvars( var0 )
{
    self endon( "disconnect" );
    self notify( "handleUltraOperatorSkins" );
    self endon( "handleUltraOperatorSkins" );
    var1 = "ultra_operators";
    var2 = "neutral";
    
    if ( !self isscriptable() || !self getscriptablehaspart( var1 ) )
    {
        return;
    }
    
    var3 = tablelookup( "operatorskins.csv", 0, var0, 26 );
    
    if ( isdefined( var3 ) && var3 != "" )
    {
        self setscriptablepartstate( var1, var3 );
        self waittill( "death" );
        self setscriptablepartstate( var1, var2 );
        return;
    }
    
    self setscriptablepartstate( var1, var2 );
}

// Params 0
// Size: 0x496
function createoperatorcustomization()
{
    if ( isai( self ) && scripts\mp\utility\game::getgametype() != "br" )
    {
        self.botoperatorref = undefined;
        self.botoperatorteam = undefined;
        self.botskinid = undefined;
    }
    
    var0 = getoperatorcustomization();
    var1 = var0[ 0 ];
    var2 = var0[ 1 ];
    var3 = var0[ 2 ];
    
    if ( !isagent( self ) )
    {
        self setcustomization( var1, var2 );
        var4 = self getcustomizationbody();
        var5 = self getcustomizationhead();
        var6 = self getcustomizationviewmodel();
        var7 = getplayerviewmodelfrombody( var1 );
    }
    else if ( level.gametype == "br" )
    {
        var4 = "fullbody_usmc_ar_br_infil";
        var5 = undefined;
        var6 = "viewhands_mp_base_iw8";
        var7 = "viewhands_mp_base_iw8";
    }
    else
    {
        var4 = "body_opforce_london_terrorist_1_2";
        var5 = "head_male_bc_03";
        var6 = "viewmodel_mp_base_iw8";
        var7 = "viewmodel_mp_base_iw8";
    }
    
    var8 = lookupcurrentoperator( self.team );
    var9 = lookupcurrentoperatorskin( self.team );
    
    if ( scripts\mp\utility\game::getgametype() == "infect" && self.team == "axis" )
    {
        var8 = "kreuger_eastern";
        var9 = 218;
    }
    
    var10 = spawnstruct();
    var10.operatorref = var8;
    var10.skinref = var9;
    var10.body = var5;
    var10.defaultbody = var4;
    var10.head = var6;
    var10.defaulthead = var5;
    var10.vm = var7;
    var10.defaultvm = var6;
    var10.gender = getoperatorgender( var8 );
    var10.voice = getoperatorvoice( var8, var9 );
    var10.title = resettimeronpickup( var8 );
    var10.clothtype = resetplayermovespeedscale( var9 );
    var10.superfaction = getoperatorsuperfaction( var8 );
    var10.execution = getoperatorexecution( var8 );
    var10.oic_rewardammo = resetposition( var8 );
    var10.oicvariantid = resetscorefeedcontrolomnvar( var8 );
    var10.suit = var7;
    var10.rebuild = 0;
    var10.spawn_carriables_from_prefabs_percentage = update_timer_for_bomb_vest_detonator_holder( var5 );
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        var11 = resetplayerdataforrespawningplayer( var9 );
        
        if ( var11 != "" )
        {
            var10.disabledebugdialogue = var11;
        }
        
        thread setuppingspecificvars( var9 );
        
        if ( resetsuper( var8 ) == "s4" )
        {
            self.ref_12e3a = 1;
        }
    }
    
    var12 = spawnstruct();
    var12.apc = runbrgametypefunc6( "apc" );
    var12.c4_pick_up_listener = rundomplateskybeam( "apc" );
    var12.check_cannot_spawn_tank = runbrgametypefunc6( "atv" );
    var12.get_extra_focus_fire_multipler = runbrgametypefunc6( "cargo_truck" );
    var12.vehicle_damage_endburndown = runbrgametypefunc6( "jeep" );
    var12.x1opsenableelimination = runbrgametypefunc6( "little_bird" );
    var12.ref_139f7 = runbrgametypefunc6( "tac_rover" );
    var12.ref_13a47 = runbrgametypefunc6( "tank_east" );
    var12.ref_13a48 = rundomplateskybeam( "tank_east" );
    var12.ref_13a52 = runbrgametypefunc6( "tank_west" );
    var12.ref_13a53 = rundomplateskybeam( "tank_west" );
    var12.ref_11d4d = runbrgametypefunc6( "motorcycle" );
    var12.br_is_allowed_armor_insert = runbrgametypefunc6( "airplane" );
    var12.create_head_icon_for_crate = runbrgametypefunc6( "bomber" );
    var12.ëıg?©ª)-ÿ∫„!ûs£(Û = runbrgametypefunc6( "open_jeep_carpoc" );
    var12.åÔ®è†`cíªY/'bßÔ4sà>gõ = rundomplateskybeam( "open_jeep_carpoc" );
    var12.c130airdrop_heightoverride = runcircles( "apc", 4 );
    var12.check_carrier_status = runcircles( "atv", 6 );
    var12.get_fake_digit_from_pool = runcircles( "cargo_truck", 8 );
    var12.vehicle_damage_enginevisualclearcallback = runcircles( "jeep", 10 );
    var12.x1opsendgame = runcircles( "little_bird", 12 );
    var12.ref_139f8 = runcircles( "tac_rover", 14 );
    var12.ref_11d5f = runcircles( "motorcycle", 16 );
    var12.Öåßﬂ≠_@–—`	™Jsyx˛l/Æ˚ = runcircles( "open_jeep_carpoc", 18 );
    var12.check_for_damage_scalar_change = runcontrolledcallback( "atv" );
    var12.ref_139fc = runcontrolledcallback( "tac_rover" );
    var12.zombieingas = runcontrolledcallback( "little_bird" );
    var12.ref_11d70 = runcontrolledcallback( "motorcycle" );
    var12.br_isplayerbeforeinitialinfildeploy = runcontrolledcallback( "airplane" );
    var12.createjuggdroplocation = runcontrolledcallback( "bomber" );
    
    if ( istrue( game[ "isLaunchChunk" ] ) )
    {
        if ( isbot( self ) )
        {
            if ( self.team == "allies" )
            {
                var10.voice = "ukft1";
            }
            else
            {
                var10.voice = "ruft1";
            }
        }
    }
    
    self.operatorcustomization = var10;
    self.ref_14238 = var12;
}

// Params 1
// Size: 0x19
function respawntokenenabled( var0 )
{
    return self getplayerdata( level.loadoutsgroup, "customizationSetup", "operators", var0 );
}

// Params 1
// Size: 0xec
function respawntokendisabled( var0 )
{
    if ( getlocalestructarray() )
    {
        var1 = scripts\engine\utility::ter_op( var0 == 0, "allies", "axis" );
        
        if ( isdefined( self.pers[ "restrictedOperatorInfo" ] ) )
        {
            var2 = self.pers[ "restrictedOperatorInfo" ][ var1 ];
            
            if ( isdefined( var2 ) )
            {
                return var2.operatorref;
            }
        }
        
        var3 = respawntokenenabled( var0 );
        
        if ( update_track_operational_status( var3 ) )
        {
            if ( !isdefined( self.pers[ "restrictedOperatorInfo" ] ) )
            {
                self.pers[ "restrictedOperatorInfo" ] = [];
            }
            
            var2 = spawnstruct();
            var4 = getarraykeys( level.operatorcustomization[ var1 ] );
            var3 = scripts\engine\utility::random( var4 );
            var2.operatorref = var3;
            var5 = getarraykeys( level.operatorcustomization[ var1 ][ var3 ] );
            var6 = scripts\engine\utility::random( var5 );
            var2.ref_12137 = int( tablelookup( "operatorskins.csv", 1, var6, 0 ) );
            self.pers[ "restrictedOperatorInfo" ][ var1 ] = var2;
        }
    }
    else
    {
        var3 = respawntokenenabled( var3 );
    }
    
    return var3;
}

// Params 1
// Size: 0x5a
function restart_watcher( var0 )
{
    if ( getlocalestructarray() )
    {
        if ( isdefined( self.pers[ "restrictedOperatorInfo" ] ) )
        {
            var1 = getoperatorteambyref( var0 );
            var2 = self.pers[ "restrictedOperatorInfo" ][ var1 ];
            
            if ( isdefined( var2 ) )
            {
                return var2.ref_12137;
            }
        }
    }
    
    return self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorCustomization", var0, "skin" );
}

// Params 0
// Size: 0x9b
function getlocalestructarray()
{
    if ( !isdefined( level.ref_12134 ) )
    {
        level.ref_12134 = spawnstruct();
        var0 = getdvar( "scr_operator_restrict_sources" );
        level.ref_12134.sources = strtok( var0, "," );
        
        if ( scripts\mp\utility\game::getgametype() != "br" )
        {
            level.ref_12134.sources = [ "t9", "s4" ];
        }
        
        level.ref_12134.enabled = !!level.ref_12134.sources.size;
        
        if ( level.ref_12134.enabled )
        {
            level.ref_12134.use_emp_drone_func = [];
        }
    }
    
    return level.ref_12134.enabled;
}

// Params 1
// Size: 0x78
function update_track_operational_status( var0 )
{
    if ( !getlocalestructarray() )
    {
        return 0;
    }
    
    var1 = level.ref_12134.use_emp_drone_func[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
        var2 = resetsuper( var0 );
        
        foreach ( var4 in level.ref_12134.sources )
        {
            if ( var2 == var4 )
            {
                var1 = 1;
                break;
            }
        }
        
        level.ref_12134.use_emp_drone_func[ var0 ] = var1;
    }
    
    return var1;
}

// Params 1
// Size: 0xad
function lookupotheroperator( var0 )
{
    if ( !isplayer( self ) && !isai( self ) )
    {
        return "";
    }
    
    var1 = scripts\engine\utility::ter_op( var0 == "allies", 1, 0 );
    var2 = self getentitynumber();
    var3 = "";
    var0 = scripts\engine\utility::ter_op( var0 == "allies", "axis", "allies" );
    
    if ( level.gametype != "br" )
    {
        if ( level.teambased && !isai( self ) )
        {
            if ( !isdefined( level.playercustomizationdata[ var2 ][ var0 ] ) )
            {
                var4 = spawnstruct();
                var4.operatorref = respawntokendisabled( var1 );
                level.playercustomizationdata[ var2 ][ var0 ] = var4;
            }
            
            var3 = level.playercustomizationdata[ var2 ][ var0 ].operatorref;
        }
    }
    
    return var3;
}

// Params 1
// Size: 0x4df
function lookupcurrentoperator( var0 )
{
    if ( !isplayer( self ) && !isai( self ) )
    {
        return "";
    }
    
    var1 = scripts\engine\utility::ter_op( var0 == "allies", 0, 1 );
    var2 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";
    
    if ( !level.teambased || var2 )
    {
        var3 = undefined;
        
        if ( isai( self ) )
        {
            var3 = self.botoperatorteam;
        }
        else
        {
            var3 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex" );
        }
        
        var1 = var3;
        
        if ( !isai( self ) && !isdefined( self.defaultoperatorteam ) )
        {
            if ( var1 == 0 )
            {
                self.defaultoperatorteam = "allies";
            }
            else
            {
                self.defaultoperatorteam = "axis";
            }
        }
    }
    
    if ( !isdefined( level.playercustomizationdata ) )
    {
        level.playercustomizationdata = [];
    }
    
    var4 = self getentitynumber();
    
    if ( !isdefined( level.playercustomizationdata[ var4 ] ) )
    {
        level.playercustomizationdata[ var4 ] = [];
    }
    
    var5 = undefined;
    
    if ( level.gametype == "infect" && var0 == "axis" )
    {
        var6 = spawnstruct();
        var6.operatorref = "kreuger_eastern";
        level.playercustomizationdata[ var4 ][ var0 ] = var6;
    }
    else if ( !isdefined( level.playercustomizationdata[ var4 ][ var0 ] ) )
    {
        var6 = spawnstruct();
        
        if ( isai( self ) )
        {
            var6.operatorref = self.botoperatorref;
        }
        else
        {
            var6.operatorref = respawntokendisabled( var1 );
        }
        
        level.playercustomizationdata[ var4 ][ var0 ] = var6;
    }
    
    var5 = level.playercustomizationdata[ var4 ][ var0 ].operatorref;
    
    if ( getdvarint( "scr_forceHeadlessCustomization", 1 ) == 1 && !isagent( self ) && self calloutmarkerping_getent() )
    {
        var7 = getarraykeys( level.operatorcustomization );
        
        if ( !isdefined( self.showempminimap ) )
        {
            foreach ( var9 in var7 )
            {
                var10 = getarraykeys( level.operatorcustomization[ var9 ] );
                
                if ( !isdefined( level.showing_ui_record ) )
                {
                    level.showing_ui_record = [];
                }
                
                if ( !isdefined( level.showing_ui_record[ var9 ] ) || level.showing_ui_record[ var9 ] > var10.size )
                {
                    level.showing_ui_record[ var9 ] = 0;
                }
                
                for ( var11 = var10[ level.showing_ui_record[ var9 ] ]; isdefined( var11 ) && ( var11 == "default_western" || var11 == "default_eastern" ) ; var11 = var10[ level.showing_ui_record[ var9 ] ] )
                {
                    level.showing_ui_record[ var9 ] += 1;
                    
                    if ( level.showing_ui_record[ var9 ] > var10.size )
                    {
                        level.showing_ui_record[ var9 ] = 0;
                    }
                }
                
                level.showing_ui_record[ var9 ] += 1;
                level.playercustomizationdata[ var4 ][ var9 ] = spawnstruct();
                level.playercustomizationdata[ var4 ][ var9 ].operatorref = var11;
            }
            
            self.showempminimap = 1;
        }
        
        if ( isdefined( level.operatorcustomization[ var0 ] ) )
        {
            var5 = level.playercustomizationdata[ var4 ][ var0 ].operatorref;
        }
        else
        {
            if ( !isdefined( self.botoperatorteam ) )
            {
                self.botoperatorteam = scripts\engine\utility::random( var7 );
            }
            
            if ( getdvarint( "scr_log_headless_customization", 0 ) == 1 )
            {
                logprint( "name            = " + self.name );
                logprint( "clientNum       = " + var4 );
                logprint( "botOperatorTeam = " + self.botoperatorteam );
                logprint( "operatorRef     = " + var5 );
            }
            
            if ( isdefined( level.playercustomizationdata[ var4 ][ self.botoperatorteam ] ) )
            {
                var5 = level.playercustomizationdata[ var4 ][ self.botoperatorteam ].operatorref;
            }
        }
    }
    
    if ( isai( self ) || !isdefined( var5 ) || var5 == "" )
    {
        if ( isai( self ) )
        {
            if ( isdefined( self.botoperatorref ) )
            {
                if ( isdefined( level.playercustomizationdata[ var4 ][ var0 ].operatorref ) )
                {
                    var5 = level.playercustomizationdata[ var4 ][ var0 ].operatorref;
                }
                else
                {
                    var5 = self.botoperatorref;
                }
            }
            else
            {
                initoperatorcustomization();
                
                if ( !isdefined( self.botoperatorteam ) )
                {
                    self.botoperatorteam = self.team;
                    
                    if ( !isdefined( level.operatorcustomization[ self.botoperatorteam ] ) )
                    {
                        var7 = getarraykeys( level.operatorcustomization );
                        self.botoperatorteam = scripts\engine\utility::random( var7 );
                    }
                }
                
                var0 = self.botoperatorteam;
                var3 = undefined;
                
                if ( !isdefined( self.pers[ "operatorIndex" ] ) )
                {
                    if ( getdvarint( "scr_forceBotCustomization", 1 ) == 1 )
                    {
                        var3 = randomint( level.operatorcustomization[ var0 ].size );
                        self.pers[ "operatorIndex" ] = var3;
                    }
                    else
                    {
                        var13 = 0;
                        
                        foreach ( var16, var15 in level.operatorcustomization[ var0 ] )
                        {
                            if ( issubstr( var16, "default" ) )
                            {
                                var3 = var13;
                                self.pers[ "operatorIndex" ] = var13;
                                self.botoperatorref = var16;
                                var5 = var16;
                                break;
                            }
                            
                            var13++;
                        }
                    }
                }
                else
                {
                    var3 = self.pers[ "operatorIndex" ];
                }
                
                if ( !isdefined( self.botoperatorref ) )
                {
                    var13 = 0;
                    
                    foreach ( var16, var15 in level.operatorcustomization[ var0 ] )
                    {
                        if ( var13 == var3 )
                        {
                            self.botoperatorref = var16;
                            var5 = var16;
                            break;
                        }
                        
                        var13++;
                    }
                }
            }
        }
        else
        {
            var5 = "wyatt_western";
        }
    }
    
    return var5;
}

// Params 1
// Size: 0x1db
function lookupcurrentoperatorskin( var0 )
{
    var1 = lookupcurrentoperator( var0 );
    var2 = undefined;
    var3 = self getentitynumber();
    
    if ( scripts\mp\utility\game::getgametype() == "infect" && var0 == "axis" )
    {
        var4 = spawnstruct();
        var4.operatorref = "kreuger_eastern";
        level.playercustomizationdata[ var3 ][ var0 ] = var4;
        self.pers[ "operatorSkinIndex" ] = 218;
        var2 = 218;
    }
    else
    {
        if ( getdvarint( "scr_forceHeadlessCustomization", 1 ) == 1 && !isagent( self ) && self calloutmarkerping_getent() )
        {
            if ( !isdefined( level.playercustomizationdata[ var3 ][ var0 ].operatorskinindex ) )
            {
                if ( !isdefined( level.showing_bomb_wire_pair_to_player ) )
                {
                    thermite_doradiusdamage();
                }
                
                var5 = level.showing_bomb_wire_pair_to_player[ var1 ][ "curIndex" ];
                level.playercustomizationdata[ var3 ][ var0 ].operatorskinindex = level.showing_bomb_wire_pair_to_player[ var1 ][ "lootIDs" ][ var5 ];
                level.showing_bomb_wire_pair_to_player[ var1 ][ "curIndex" ] = level.showing_bomb_wire_pair_to_player[ var1 ][ "curIndex" ] + 1;
                
                if ( level.showing_bomb_wire_pair_to_player[ var1 ][ "curIndex" ] >= level.showing_bomb_wire_pair_to_player[ var1 ][ "maxIndex" ] )
                {
                    level.showing_bomb_wire_pair_to_player[ var1 ][ "curIndex" ] = 0;
                }
            }
        }
        else if ( !isdefined( level.playercustomizationdata[ var3 ][ var0 ].operatorskinindex ) )
        {
            if ( isai( self ) )
            {
                if ( !isdefined( self.botskinid ) )
                {
                    debug_interaction_toggle( var1 );
                }
                
                level.playercustomizationdata[ var3 ][ var0 ].operatorskinindex = self.botskinid;
            }
            else
            {
                level.playercustomizationdata[ var3 ][ var0 ].operatorskinindex = restart_watcher( var1 );
            }
        }
        
        var2 = level.playercustomizationdata[ var3 ][ var0 ].operatorskinindex;
        
        if ( isai( self ) && ( !isdefined( var2 ) || var2 == 0 ) || !isdefined( var2 ) || var2 == 0 )
        {
            if ( isai( self ) )
            {
                if ( isdefined( self.botskinid ) )
                {
                    var2 = self.botskinid;
                }
                else
                {
                    debug_interaction_toggle( var1 );
                }
            }
            else
            {
                var2 = 1;
            }
        }
    }
    
    return var2;
}

// Params 1
// Size: 0xad
function debug_interaction_toggle( var0 )
{
    var1 = self.team;
    
    if ( isdefined( self.botoperatorteam ) )
    {
        var1 = self.botoperatorteam;
    }
    
    if ( !isdefined( self.pers[ "operatorSkinIndex" ] ) )
    {
        var2 = randomint( level.operatorcustomization[ var1 ][ var0 ].size );
        self.pers[ "operatorSkinIndex" ] = var2;
    }
    else
    {
        var2 = self.pers[ "operatorSkinIndex" ];
    }
    
    var3 = 0;
    
    foreach ( var5 in level.operatorcustomization[ var2 ][ var1 ] )
    {
        if ( var3 == var2 )
        {
            var6 = int( tablelookup( "operatorskins.csv", 1, var8, 0 ) );
            self.botskinid = var6;
            var7 = var6;
            break;
        }
        
        var3++;
    }
}

// Params 1
// Size: 0x67
function picklaunchchunkoperatorskin( var0 )
{
    if ( !isdefined( level.launchchunkskins ) )
    {
        level.launchchunkskins = [];
        level.launchchunkskins[ "allies" ] = 0;
        level.launchchunkskins[ "axis" ] = 0;
    }
    
    if ( !isdefined( self.launchchunkcustomizationindex ) )
    {
        if ( level.launchchunkskins[ var0 ] == 2 )
        {
            level.launchchunkskins[ var0 ] = 0;
        }
        
        self.launchchunkcustomizationindex = level.launchchunkskins[ var0 ];
        level.launchchunkskins[ var0 ]++;
    }
    
    return self.launchchunkcustomizationindex;
}

// Params 0
// Size: 0x2b8
function getoperatorcustomization()
{
    var0 = lookupcurrentoperator( self.team );
    var1 = lookupcurrentoperatorskin( self.team );
    
    if ( isdefined( level.ref_11c6a ) )
    {
        var2 = [[ level.ref_11c6a ]]( self, var0, var1 );
        var0 = var2[ 0 ];
        var1 = var2[ 1 ];
        var2 = undefined;
    }
    
    var3 = undefined;
    var4 = undefined;
    var5 = undefined;
    
    if ( istrue( game[ "isLaunchChunk" ] ) )
    {
        initlaunchchunkoperatorskins();
        
        if ( !isdefined( self.pers[ "defaultOperatorSkinIndex" ] ) )
        {
            self.pers[ "defaultOperatorSkinIndex" ] = picklaunchchunkoperatorskin( self.team );
        }
        
        var3 = level.defaultoperatorskins[ self.team ][ "body" ][ self.pers[ "defaultOperatorSkinIndex" ] ];
        var4 = level.defaultoperatorskins[ self.team ][ "head" ][ self.pers[ "defaultOperatorSkinIndex" ] ];
        var5 = level.defaultoperatorskins[ self.team ][ "suit" ][ 0 ];
        var6 = [];
        GscBinSkip0( 0x2e, 0, var3 );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    if ( ( var1 == "default_western" || var1 == "default_eastern" ) && ( var3 == 274 || var3 == 275 ) )
    {
        initdefaultoperatorskins();
        var7 = level.teambased && scripts\mp\utility\game::getgametype() != "br";
        
        if ( !isdefined( self.defaultoperatorteam ) || var7 && self.defaultoperatorteam != self.team && ( self.team == "allies" || self.team == "axis" ) )
        {
            self.defaultoperatorteam = self.team;
            
            if ( self.team != "allies" && self.team != "axis" )
            {
                self.defaultoperatorteam = scripts\engine\utility::ter_op( scripts\engine\utility::cointoss(), "allies", "axis" );
            }
        }
        
        if ( !isdefined( self.pers[ "defaultOperatorSkinIndex" ] ) )
        {
            self.pers[ "defaultOperatorSkinIndex" ] = 0;
        }
        
        var8 = self.defaultoperatorteam;
        var9 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";
        
        if ( var9 )
        {
            if ( var1 == "default_western" )
            {
                var8 = "allies";
            }
            else
            {
                var8 = "axis";
            }
        }
        
        var10 = self.pers[ "defaultOperatorSkinIndex" ];
        var4 = level.defaultoperatorskins[ var8 ][ "body" ][ var10 ];
        var11 = level.defaultoperatorskins[ var8 ][ "head" ][ var10 ];
        
        if ( !isdefined( self.pers[ "defaultOperatorHeadIndex" ] ) )
        {
            self.pers[ "defaultOperatorHeadIndex" ] = randomint( var11.size );
        }
        
        var12 = self.pers[ "defaultOperatorHeadIndex" ];
        
        if ( var12 >= var11.size )
        {
            var12 = 0;
        }
        
        var5 = var11[ var12 ];
        var6 = "iw8_suit_mp_wyatt";
    }
    else
    {
        var4 = tablelookup( "operatorskins.csv", 0, var3, 4 );
        var5 = tablelookup( "operatorskins.csv", 0, var3, 5 );
        var6 = tablelookup( "operators.csv", 1, var1, 19 );
    }
    
    self.bodymodelname = var4;
    self.backuphead = var5;
    self.backupsuit = var6;
    var6 = [];
    GscBinSkip0( 0x2e, 0, var4 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0xda
function initlaunchchunkoperatorskins()
{
    if ( isdefined( level.defaultoperatorskins ) )
    {
        return;
    }
    
    level.defaultoperatorskins = [];
    level.defaultoperatorskins[ "allies" ] = [];
    level.defaultoperatorskins[ "allies" ][ "body" ] = [ "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_ar_1_1_lod1" ];
    level.defaultoperatorskins[ "allies" ][ "head" ] = [ "head_mp_western_fireteam_west_dmr_2_1", "head_mp_western_fireteam_west_ar_1_1" ];
    level.defaultoperatorskins[ "allies" ][ "suit" ] = [ "iw8_suit_mp_wyatt" ];
    level.defaultoperatorskins[ "axis" ] = [];
    level.defaultoperatorskins[ "axis" ][ "body" ] = [ "body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_lmg_lod1" ];
    level.defaultoperatorskins[ "axis" ][ "head" ] = [ "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_lmg" ];
    level.defaultoperatorskins[ "axis" ][ "suit" ] = [ "iw8_suit_mp_wyatt" ];
}

// Params 0
// Size: 0x770
function initdefaultoperatorskins()
{
    if ( isdefined( level.defaultoperatorskins ) )
    {
        return;
    }
    
    level.defaultoperatorskins = [];
    level.defaultoperatorskins[ "allies" ] = [];
    level.defaultoperatorskins[ "axis" ] = [];
    
    switch ( game[ "allies_outfit" ] )
    {
        case "urban":
            level.defaultoperatorskins[ "allies" ][ "body" ] = [ "body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 0 ] = [ "head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 1 ] = [ "head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 2 ] = [ "head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 3 ] = [ "head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 4 ] = [ "head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1" ];
            break;
        case "desert":
            level.defaultoperatorskins[ "allies" ][ "body" ] = [ "body_mp_western_fireteam_west_ar_1_2_lod1", "body_mp_western_fireteam_west_smg_1_2_lod1", "body_mp_western_fireteam_west_dmr_1_2_lod1", "body_mp_western_fireteam_west_lmg_1_2_lod1", "body_mp_western_fireteam_west_sg_1_2_lod1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 0 ] = [ "head_mp_western_fireteam_west_ar_1_2", "head_mp_western_fireteam_west_ar_2_2" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 1 ] = [ "head_mp_western_fireteam_west_smg_1_2", "head_mp_western_fireteam_west_smg_2_2" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 2 ] = [ "head_mp_western_fireteam_west_dmr_1_2", "head_mp_western_fireteam_west_dmr_2_2" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 3 ] = [ "head_mp_western_fireteam_west_lmg_1_2", "head_mp_western_fireteam_west_lmg_2_2" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 4 ] = [ "head_mp_western_fireteam_west_sg_1_2", "head_mp_western_fireteam_west_sg_2_2" ];
            break;
        case "woodland":
            level.defaultoperatorskins[ "allies" ][ "body" ] = [ "body_mp_western_fireteam_west_ar_1_3_lod1", "body_mp_western_fireteam_west_smg_1_3_lod1", "body_mp_western_fireteam_west_dmr_1_3_lod1", "body_mp_western_fireteam_west_lmg_1_3_lod1", "body_mp_western_fireteam_west_sg_1_3_lod1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 0 ] = [ "head_mp_western_fireteam_west_ar_1_3", "head_mp_western_fireteam_west_ar_2_3" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 1 ] = [ "head_mp_western_fireteam_west_smg_1_3", "head_mp_western_fireteam_west_smg_2_3" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 2 ] = [ "head_mp_western_fireteam_west_dmr_1_3", "head_mp_western_fireteam_west_dmr_2_3" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 3 ] = [ "head_mp_western_fireteam_west_lmg_1_3", "head_mp_western_fireteam_west_lmg_2_3" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 4 ] = [ "head_mp_western_fireteam_west_sg_1_3", "head_mp_western_fireteam_west_sg_2_3" ];
            break;
        default:
            level.defaultoperatorskins[ "allies" ][ "body" ] = [ "body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 0 ] = [ "head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 1 ] = [ "head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 2 ] = [ "head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 3 ] = [ "head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1" ];
            level.defaultoperatorskins[ "allies" ][ "head" ][ 4 ] = [ "head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1" ];
            break;
    }
    
    switch ( game[ "axis_outfit" ] )
    {
        case "urban":
            level.defaultoperatorskins[ "axis" ][ "body" ] = [ "body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 0 ] = [ "head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 1 ] = [ "head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 2 ] = [ "head_mp_eastern_fireteam_east_dmr" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 3 ] = [ "head_mp_eastern_fireteam_east_lmg" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 4 ] = [ "head_mp_eastern_fireteam_east_sg" ];
            break;
        case "desert":
            level.defaultoperatorskins[ "axis" ][ "body" ] = [ "body_mp_eastern_fireteam_east_ar_2_lod1", "body_mp_eastern_fireteam_east_smg_2_lod1", "body_mp_eastern_fireteam_east_dmr_2_lod1", "body_mp_eastern_fireteam_east_lmg_2_lod1", "body_mp_eastern_fireteam_east_sg_2_lod1" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 0 ] = [ "head_mp_eastern_fireteam_east_ar_1_2", "head_mp_eastern_fireteam_east_ar_2_2", "head_mp_eastern_fireteam_east_ar_3_2", "head_mp_eastern_fireteam_east_ar_4_2" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 1 ] = [ "head_mp_eastern_fireteam_east_smg_1_2", "head_mp_eastern_fireteam_east_smg_2_2", "head_mp_eastern_fireteam_east_smg_3_2" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 2 ] = [ "head_mp_eastern_fireteam_east_dmr" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 3 ] = [ "head_mp_eastern_fireteam_east_lmg" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 4 ] = [ "head_mp_eastern_fireteam_east_sg" ];
            break;
        case "woodland":
            level.defaultoperatorskins[ "axis" ][ "body" ] = [ "body_mp_eastern_fireteam_east_ar_3_lod1", "body_mp_eastern_fireteam_east_smg_3_lod1", "body_mp_eastern_fireteam_east_dmr_3_lod1", "body_mp_eastern_fireteam_east_lmg_3_lod1", "body_mp_eastern_fireteam_east_sg_3_lod1" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 0 ] = [ "head_mp_eastern_fireteam_east_ar_1_3", "head_mp_eastern_fireteam_east_ar_2_3", "head_mp_eastern_fireteam_east_ar_3_3", "head_mp_eastern_fireteam_east_ar_4_3" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 1 ] = [ "head_mp_eastern_fireteam_east_smg_1_3", "head_mp_eastern_fireteam_east_smg_2_3", "head_mp_eastern_fireteam_east_smg_3_3" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 2 ] = [ "head_mp_eastern_fireteam_east_dmr" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 3 ] = [ "head_mp_eastern_fireteam_east_lmg" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 4 ] = [ "head_mp_eastern_fireteam_east_sg" ];
            break;
        default:
            level.defaultoperatorskins[ "axis" ][ "body" ] = [ "body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 0 ] = [ "head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 1 ] = [ "head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 2 ] = [ "head_mp_eastern_fireteam_east_dmr" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 3 ] = [ "head_mp_eastern_fireteam_east_lmg" ];
            level.defaultoperatorskins[ "axis" ][ "head" ][ 4 ] = [ "head_mp_eastern_fireteam_east_sg" ];
            break;
    }
}

// Params 1
// Size: 0x8e
function pickdefaultoperatorskin( var0 )
{
    var1 = 0;
    
    if ( isdefined( var0 ) )
    {
        var2 = scripts\mp\utility\weapon::getweapongroup( var0 );
        
        switch ( var2 )
        {
            case "weapon_assault":
            case "weapon_tactical":
                var1 = 0;
                break;
            case "weapon_smg":
                var1 = 1;
                break;
            case "weapon_dmr":
            case "weapon_sniper":
                var1 = 2;
                break;
            case "weapon_lmg":
                var1 = 3;
                break;
            case "weapon_shotgun":
                var1 = 4;
                break;
            default:
                var1 = 1;
                break;
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x253
function getglcustomization()
{
    var0 = self.primaryweapon;
    var1 = scripts\mp\utility\weapon::getweapongroup( var0 );
    var2 = self.loadoutequipmentprimary;
    var3 = undefined;
    var4 = undefined;
    var5 = undefined;
    
    if ( var2 == "equip_helmet" )
    {
        var5 = "_blstk";
    }
    else
    {
        var5 = "";
    }
    
    switch ( self.team )
    {
        case "allies":
            var6 = "usmc";
            
            if ( scripts\mp\flags::gameflag( "infil_will_run" ) && !scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                var7 = "_wind";
            }
            else
            {
                var7 = "";
            }
            
            switch ( var2 )
            {
                case "weapon_shotgun":
                case "weapon_smg":
                    var4 = "_cqc";
                    var5 = "_cqc";
                    break;
                case "weapon_assault":
                case "weapon_tactical":
                    var4 = "_ar";
                    var5 = "_ar";
                    break;
                case "weapon_lmg":
                    var4 = "_ar";
                    var5 = "_lmg";
                    break;
                case "weapon_dmr":
                case "weapon_sniper":
                    var4 = "_cqc";
                    var5 = "_cqc";
                    break;
                default:
                    var4 = "_ar";
                    var5 = "_ar";
                    break;
            }
            
            break;
        case "axis":
            var6 = "sa_militia";
            var7 = "";
            
            switch ( var4 )
            {
                case "weapon_shotgun":
                case "weapon_smg":
                    var6 = "_cqc";
                    var7 = "_cqc";
                    break;
                case "weapon_assault":
                case "weapon_tactical":
                    var6 = "_ar";
                    var7 = "_ar";
                    break;
                case "weapon_lmg":
                    var6 = "_lmg";
                    var7 = "_lmg";
                    break;
                case "weapon_dmr":
                case "weapon_sniper":
                    var6 = "_ar";
                    var7 = "_ar";
                    break;
                default:
                    var6 = "_ar";
                    var7 = "_ar";
                    break;
            }
            
            break;
        default:
            var6 = "usmc";
            var7 = "";
            var7 = "_ar";
            var6 = "_ar";
            break;
    }
    
    var8 = "body_" + var6 + var7 + var7;
    var9 = "head_" + var6 + var6 + var7;
    self.backuphead = "head_" + var6 + var6;
    self.bodymodelname = "body_" + var6 + var7;
    var10 = [];
    GscBinSkip0( 0x2e, 0, var8 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x21a
function getglcustomizationhackney()
{
    var0 = self.primaryweapon;
    var1 = scripts\mp\utility\weapon::getweapongroup( var0 );
    var2 = self.loadoutequipmentprimary;
    var3 = undefined;
    var4 = undefined;
    var5 = undefined;
    
    if ( var2 == "equip_helmet" )
    {
        var5 = "_blstk";
    }
    else
    {
        var5 = "";
    }
    
    switch ( self.team )
    {
        case "allies":
            var6 = "sas_urban";
            
            if ( scripts\mp\flags::gameflag( "infil_will_run" ) && !scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                var7 = "";
            }
            else
            {
                var7 = "_rain";
            }
            
            switch ( var2 )
            {
                case "weapon_shotgun":
                case "weapon_smg":
                    var4 = "_cqc";
                    var5 = "_mp_cqc";
                    break;
                case "weapon_assault":
                case "weapon_tactical":
                    var4 = "_ar";
                    var5 = "_ar";
                    break;
                case "weapon_lmg":
                    var4 = "_lmg";
                    var5 = "_lmg";
                    break;
                case "weapon_dmr":
                case "weapon_sniper":
                    var4 = "_dmr";
                    var5 = "_mp_dmr";
                    break;
                default:
                    var4 = "_ar";
                    var5 = "_ar";
                    break;
            }
            
            break;
        case "axis":
            var6 = "al_qatala";
            var7 = "";
            
            switch ( var4 )
            {
                case "weapon_shotgun":
                case "weapon_lmg":
                case "weapon_dmr":
                case "weapon_sniper":
                case "weapon_assault":
                case "weapon_smg":
                case "weapon_tactical":
                    var6 = "_1_ar";
                    var7 = "_ar";
                    break;
                default:
                    var6 = "_1_ar";
                    var7 = "_ar";
                    break;
            }
            
            break;
        default:
            var6 = "usmc";
            var7 = "";
            var7 = "_ar";
            var6 = "_ar";
            break;
    }
    
    var8 = "body_" + var6 + var7 + var7;
    var9 = "head_" + var6 + var6 + var7;
    self.backuphead = "head_" + var6 + var6;
    self.bodymodelname = "body_" + var6 + var7;
    var10 = [];
    GscBinSkip0( 0x2e, 0, var8 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x80
function forcedefaultmodel()
{
    if ( self.team == "axis" )
    {
        self setmodel( "mp_fullbody_heavy" );
        self setviewmodel( "viewmodel_mp_base_iw8" );
    }
    else
    {
        self setmodel( "mp_body_infected_a" );
        self setviewmodel( "viewmodel_mp_base_iw8" );
    }
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel, "" );
        self.headmodel = undefined;
    }
    
    self attach( "head_mp_infected", "", 1 );
    self.headmodel = "head_mp_infected";
    self setclothtype( "cloth" );
}

// Params 0
// Size: 0x64
function watchafk()
{
    if ( getdvarint( "debug_stopAFKCheck", 0 ) == 1 )
    {
        return;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var0 = 0;
    
    for ( ;; )
    {
        var0++;
        
        if ( var0 >= level.players.size )
        {
            var0 = 0;
        }
        
        if ( isdefined( level.players[ var0 ] ) )
        {
            if ( isai( level.players[ var0 ] ) )
            {
                waitframe();
                continue;
            }
            
            checkforafk( level.players[ var0 ] );
        }
        
        waitframe();
        scripts\mp\hostmigration::waittillhostmigrationdone();
    }
}

// Params 0
// Size: 0x389
function checkforafk()
{
    if ( istrue( level.gameended ) || !istrue( self.hasspawned ) )
    {
        return;
    }
    
    var0 = 0;
    var1 = scripts\mp\persistence::statgetchildbuffered( "round", "timePlayed", 0 );
    var1 = int( max( var1 - self.timeplayed[ "timeDead" ], 0 ) );
    
    if ( istrue( self.elevator_manager ) )
    {
        return;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        if ( self.sessionstate == "spectator" || self.sessionstate == "intermission" )
        {
            return;
        }
        
        if ( scripts\mp\gametypes\br_public::isplayeringulag() )
        {
            return;
        }
        
        if ( scripts\mp\utility\game::round_vehicle_logic() == "truckwar" )
        {
            if ( isdefined( self.vehicle ) && self.vehicle.vehiclename == "cargo_truck_mg" )
            {
                var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant( self.vehicle, "gunner" );
                
                if ( isdefined( var2 ) && var2 == self )
                {
                    return;
                }
            }
        }
        
        if ( istrue( self.txt_nag ) )
        {
            return;
        }
        
        var1 -= self.timeplayed[ "gulag" ];
        var1 -= self.timeplayed[ "rebirthRespawn" ];
    }
    
    if ( istrue( self.shoulddeleteimmediately ) )
    {
        return;
    }
    
    if ( !isdefined( self.timeplayedonfirstspawn ) )
    {
        return;
    }
    
    var3 = self.timeplayedonfirstspawn;
    var4 = self.pers[ "kills" ];
    var5 = self.pers[ "assists" ];
    var6 = self.pers[ "downs" ];
    var7 = var4 == 0 && var5 == 0 && ( !isdefined( var6 ) || isdefined( var6 ) && var6 == 0 );
    var8 = isdefined( self.lastdamagetime ) && self.lastdamagetime + 60000 > gettime();
    var9 = var1 - var3;
    var9 -= self.pers[ "afkResetTime" ];
    var10 = 60;
    
    if ( scripts\mp\utility\game::getgametype() == "arena" )
    {
        var10 = 15;
    }
    
    var11 = getdvarfloat( "scr_afkDistTimeOverride", 0 );
    
    if ( scripts\mp\utility\game::getgametype() == "br" && istrue( self.display_hint_for_player_single ) )
    {
        self.display_hint_for_player_single = undefined;
        var10 = 30;
    }
    else if ( var11 > 0 )
    {
        var10 = var11;
    }
    
    if ( scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::getgametype() != "ctf" )
    {
        var12 = var7 || level.gametype == "arena";
        
        if ( level.gametype != "arena" )
        {
            if ( var7 && var9 > 120 )
            {
                if ( !var8 )
                {
                    switch ( level.gametype )
                    {
                        case "gun":
                            if ( istrue( level.kick_afk_check ) )
                            {
                                var0 = 1;
                            }
                            
                            break;
                    }
                }
            }
        }
        
        if ( var12 && !isdefined( self.pers[ "distTrackingPassed" ] ) && var9 >= var10 )
        {
            if ( scripts\mp\utility\game::getgametype() == "infect" )
            {
                if ( self.team == "axis" )
                {
                    var0 = 1;
                }
            }
            else if ( !isdefined( self.laststancechangetime ) || gettime() - self.laststancechangetime > 11000 )
            {
                var0 = 1;
            }
        }
        
        if ( !isdefined( self.pers[ "roundsAFK" ] ) )
        {
            self.pers[ "roundsAFK" ] = 0;
        }
        
        if ( var0 && !isgamebattlematch() && !istrue( self.binoculars_onstatemarkedexit ) )
        {
            self.binoculars_onstatemarkedexit = 1;
            self.pers[ "roundsAFK" ]++;
            
            if ( scripts\mp\utility\game::getgametype() == "br" || self.pers[ "roundsAFK" ] > 1 )
            {
                thread vehomn_controlsarefadedoutorhidden( level );
            }
        }
        
        return;
    }
    else
    {
        if ( var8 && !var9 && var10 >= var11 )
        {
            if ( !isdefined( self.pers[ "distTrackingPassed" ] ) )
            {
                if ( scripts\mp\utility\game::getgametype() == "infect" )
                {
                    if ( self.team == "axis" )
                    {
                        var1 = 1;
                    }
                }
                else
                {
                    var1 = 1;
                }
            }
        }
        
        if ( var8 && var10 > 120 )
        {
            if ( !var9 )
            {
                switch ( level.gametype )
                {
                    case "gun":
                        if ( istrue( level.kick_afk_check ) )
                        {
                            var1 = 1;
                        }
                        
                        break;
                }
            }
        }
    }
    
    if ( var1 && !isgamebattlematch() )
    {
        thread vehomn_controlsarefadedoutorhidden( level );
        return;
    }
}

// Params 1
// Size: 0x25
function vehomn_controlsarefadedoutorhidden( var0 )
{
    var0 endon( "disconnect" );
    var0 notify( "afk_disconnection_imminent" );
    wait 1;
    kick( var0 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1 );
}

// Params 1
// Size: 0x169
function getjointeampermissions( var0 )
{
    var1 = 0;
    var2 = 0;
    var3 = level.players;
    
    for ( var4 = 0; var4 < var3.size ; var4++ )
    {
        var5 = var3[ var4 ];
        
        if ( isdefined( var5.pers[ "team" ] ) && var5.pers[ "team" ] == var0 )
        {
            var1++;
            
            if ( isbot( var5 ) )
            {
                var2++;
            }
        }
    }
    
    if ( level.maxteamsize == 0 || var1 < level.maxteamsize )
    {
        return 1;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "vip" && istrue( isagent( self ) ) )
    {
        return 1;
    }
    
    if ( var2 > 0 )
    {
        return 1;
    }
    
    if ( !scripts\mp\utility\game::matchmakinggame() )
    {
        return 1;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "infect" )
    {
        return 1;
    }
    
    if ( scripts\mp\menus::brking_updateteamscore() )
    {
        return 1;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" && ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" ) || getdvar( "scr_br_gametype", "" ) == "gold_war" )
    {
        return 1;
    }
    
    getentitylessscriptablearray( "mp_exceeded_team_max_error", [ "player_xuid", self getxuid(), "isHost", self ishost() ] );
    
    if ( self ishost() )
    {
        wait 1.5;
    }
    
    kick( self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM" );
    return 0;
}

// Params 0
// Size: 0x4c
function onplayerspawned()
{
    if ( !isdefined( self.timeplayedonfirstspawn ) )
    {
        self.timeplayedonfirstspawn = scripts\mp\persistence::statgetchildbuffered( "round", "timePlayed" );
    }
    
    if ( getdvarint( "scr_team_outlines", 0 ) == 1 && !scripts\mp\utility\game::runleanthreadmode() )
    {
        if ( scripts\mp\utility\game::issquadmode() )
        {
            thread outlinesquad_apply();
            return;
        }
        
        thread outlinefriendly_apply();
        return;
    }
}

// Params 0
// Size: 0x84
function outlinefriendly_apply()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( getdvarint( "scr_friendly_outlines", 1 ) == 0 )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        return;
    }
    
    if ( scripts\mp\flags::gameflag( "infil_will_run" ) && !istrue( scripts\mp\flags::gameflag( "prematch_done" ) ) )
    {
        level waittill( "prematch_over" );
    }
    
    var0 = scripts\engine\utility::ter_op( scripts\cp_mp\utility\game_utility::isnightmap(), "outline_ally_night", "outline_ally" );
    var1 = scripts\mp\utility\outline::outlineenableforteam( self, self.team, var0, "level_script" );
    thread outlinefriendly_remove( var1 );
}

// Params 1
// Size: 0x23
function outlinefriendly_remove( var0 )
{
    level endon( "game_ended" );
    scripts\engine\utility::ref_143a5( "death_or_disconnect", "joined_team" );
    scripts\mp\utility\outline::outlinedisable( var0, self );
}

// Params 0
// Size: 0x91
function outlinesquad_apply()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( scripts\mp\utility\game::runleanthreadmode() )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( getdvarint( "scr_squad_outlines", 1 ) == 0 )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        return;
    }
    
    if ( scripts\mp\flags::gameflag( "infil_will_run" ) && !istrue( scripts\mp\flags::gameflag( "prematch_done" ) ) )
    {
        level waittill( "prematch_over" );
    }
    
    var0 = scripts\engine\utility::ter_op( scripts\cp_mp\utility\game_utility::isnightmap(), "outline_squad_night", "outline_squad" );
    var1 = scripts\mp\utility\outline::outlineenableforsquad( self, self.team, self.squadindex, var0, "level_script" );
    thread outlinesquad_remove( var1 );
}

// Params 1
// Size: 0x28
function outlinesquad_remove( var0 )
{
    level endon( "game_ended" );
    scripts\engine\utility::ref_143a6( "death_or_disconnect", "joined_team", "joined_squad" );
    scripts\mp\utility\outline::outlinedisable( var0, self );
}

// Params 1
// Size: 0x35
function resetsuper( var0 )
{
    var1 = scripts\engine\utility::multitablelookup( [ "mp/itemsourcetable.csv", "mp/itemsourcetable_ch2.csv" ], 2, var0, 3 );
    
    if ( !isdefined( var1 ) || var1 == "" )
    {
        var1 = "iw8";
    }
    
    return var1;
}

// Params 1
// Size: 0x193
function getoperatorexecution( var0 )
{
    if ( isdefined( self.executionref ) )
    {
        self.loadoutexecution = self.executionref;
    }
    else
    {
        jumpiffalse(getdvarint( "scr_forceHeadlessCustomization", 1 ) == 1 && !isagent( self ) && self calloutmarkerping_getent() && level.gametype == "br") LOC_00000128;
        var1 = getarraykeys( level.execution.table );
        
        if ( !isdefined( self.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ ) )
        {
            if ( !isdefined( level.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ ) )
            {
                var2 = randomint( var1.size );
                level.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ = var2;
                level.¥ÈPr¶ÃMõ7-@‡ø≥€òjòÎüä° = [];
            }
            else
            {
                for ( var3 = 0; var3 < var1.size ; var3++ )
                {
                    var4 = var1[ level.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ ];
                    var5 = level.execution.table[ var4 ];
                    
                    if ( isdefined( var5 ) && isdefined( var5.propweapon ) && !scripts\engine\utility::array_contains( level.¥ÈPr¶ÃMõ7-@‡ø≥€òjòÎüä°, var5.propweapon ) )
                    {
                        level.¥ÈPr¶ÃMõ7-@‡ø≥€òjòÎüä°[ level.¥ÈPr¶ÃMõ7-@‡ø≥€òjòÎüä°.size ] = var5.propweapon;
                        break;
                    }
                    
                    level.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√++;
                    
                    if ( level.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ >= var1.size )
                    {
                        level.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ = 0;
                    }
                }
            }
            
            self.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ = level.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√;
        }
        
        var4 = var1[ self.æJ4¨#±+õõV√YçÍ:¥ÌÕ•Õ2¨√ ];
        self.loadoutexecution = var4;
        goto LOC_0000018a;
    }
    
    return self.loadoutexecution;
}

// Params 1
// Size: 0x6d
function resetposition( var0 )
{
    var1 = 0;
    
    if ( !isagent( self ) )
    {
        var1 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorCustomization", var0, "taunt" );
    }
    
    if ( var1 == 0 )
    {
        var2 = tablelookup( "operators.csv", 1, var0, 23 );
        self.ref_1195c = tablelookup( "operatorquips.csv", 1, var2, 6 );
    }
    else
    {
        self.ref_1195c = tablelookup( "operatorquips.csv", 0, var1, 6 );
    }
    
    return self.ref_1195c;
}

// Params 1
// Size: 0x20
function resetscorefeedcontrolomnvar( var0 )
{
    self.ref_1195d = tablelookup( "mp_cp/executiontable.csv", 1, self.loadoutexecution, 19 );
    return self.ref_1195d;
}

// Params 1
// Size: 0x18
function getoperatorsuperfaction( var0 )
{
    var1 = tablelookup( "operators.csv", 1, var0, 3 );
    return int( var1 );
}

// Params 2
// Size: 0x4b
function getoperatorvoice( var0, var1 )
{
    if ( var0 == "default_eastern" || var0 == "default_western" )
    {
        var2 = tablelookup( "operatorskins.csv", 0, var1, 24 );
        
        if ( isdefined( var2 ) && var2 != "" )
        {
            return var2;
        }
    }
    
    var2 = tablelookup( "operators.csv", 1, var0, 10 );
    return var2;
}

// Params 1
// Size: 0x33
function resettimeronpickup( var0 )
{
    if ( isstartstr( var0, "s4" ) )
    {
        return "s4";
    }
    else if ( isstartstr( var0, "t9" ) )
    {
        return "t9";
    }
    
    return "iw8";
}

// Params 1
// Size: 0x13
function resetplayermovespeedscale( var0 )
{
    var1 = tablelookupbyrow( "operatorskins.csv", var0, 22 );
    return var1;
}

// Params 1
// Size: 0x2a
function getoperatorgender( var0 )
{
    var1 = scripts\engine\utility::ter_op( tablelookup( "operators.csv", 1, var0, 11 ) == "0", "male", "female" );
    return var1;
}

// Params 1
// Size: 0x14
function resetplayerdataforrespawningplayer( var0 )
{
    var1 = tablelookup( "operatorskins.csv", 0, var0, 23 );
    return var1;
}

// Params 1
// Size: 0x18
function resetunresolvedcollision( var0 )
{
    var1 = tablelookup( "operators.csv", 1, var0, 31 );
    return int( var1 );
}

// Params 1
// Size: 0x20, Type: bool
function update_timer_for_bomb_vest_detonator_holder( var0 )
{
    var1 = tablelookup( "mp/cac/bodies.csv", 1, var0, 24 );
    return isdefined( var1 ) && var1 == "1";
}

// Params 1
// Size: 0x39
function runbrgametypefunc6( var0 )
{
    var1 = 0;
    
    if ( !isagent( self ) )
    {
        var1 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "camo" );
    }
    
    var2 = tablelookup( "mp_cp/vehiclecamos.csv", 6, var1, 4 );
    return var2;
}

// Params 1
// Size: 0x39
function rundomplateskybeam( var0 )
{
    var1 = 0;
    
    if ( !isagent( self ) )
    {
        var1 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "camo" );
    }
    
    var2 = tablelookup( "mp_cp/vehiclecamos.csv", 6, var1, 5 );
    return var2;
}

// Params 2
// Size: 0x38
function runcircles( var0, var1 )
{
    var2 = 0;
    
    if ( !isagent( self ) )
    {
        var2 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "horn" );
    }
    
    var3 = tablelookup( "mp_cp/vehiclehorns.csv", 0, var2, var1 );
    return var3;
}

// Params 1
// Size: 0x39
function runcontrolledcallback( var0 )
{
    var1 = 0;
    
    if ( !isagent( self ) )
    {
        var1 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "camo" );
    }
    
    var2 = tablelookup( "mp_cp/vehiclecamos.csv", 6, var1, 10 );
    return var2;
}

// Params 0
// Size: 0x12e
function initnightvisionheadoverrides()
{
    if ( !scripts\cp_mp\utility\game_utility::isnightmap() )
    {
        return;
    }
    
    level.nvgheadoverrides = [];
    
    for ( var0 = 0;  ; var0++ )
    {
        var1 = tablelookupbyrow( "operatorskins.csv", var0, 5 );
        var2 = tablelookupbyrow( "operatorskins.csv", var0, 17 );
        var3 = tablelookupbyrow( "operatorskins.csv", var0, 16 );
        
        if ( !isdefined( var1 ) || var1 == "" )
        {
            break;
        }
        
        if ( var2 != "" )
        {
            level.nvgheadoverrides[ var1 ][ "up" ] = var2;
        }
        
        if ( var3 != "" )
        {
            level.nvgheadoverrides[ var1 ][ "down" ] = var3;
        }
    }
    
    level.nvgheadoverrides[ "head_mp_eastern_fireteam_east_ar_1" ][ "up" ] = "none";
    level.nvgheadoverrides[ "head_mp_eastern_fireteam_east_ar_1_2" ][ "up" ] = "none";
    level.nvgheadoverrides[ "head_mp_eastern_fireteam_east_ar_1_3" ][ "up" ] = "none";
    level.nvgheadoverrides[ "head_mp_eastern_fireteam_east_ar_2" ][ "up" ] = "none";
    level.nvgheadoverrides[ "head_mp_eastern_fireteam_east_ar_2_2" ][ "up" ] = "none";
    level.nvgheadoverrides[ "head_mp_eastern_fireteam_east_ar_2_3" ][ "up" ] = "none";
    level.nvgheadoverrides[ "head_mp_eastern_fireteam_east_lmg" ][ "up" ] = "none";
}

// Params 0
// Size: 0xd1
function thermite_doradiusdamage()
{
    if ( isdefined( level.showing_bomb_wire_pair_to_player ) )
    {
        return;
    }
    
    level.showing_bomb_wire_pair_to_player = [];
    var0 = tablelookupgetnumrows( "operatorskins.csv" );
    
    for ( var1 = 0; var1 < var0 ; var1++ )
    {
        if ( tablelookupbyrow( "operatorskins.csv", var1, 18 ) != "" )
        {
            var2 = tablelookupbyrow( "operatorskins.csv", var1, 2 );
            var3 = tablelookupbyrow( "operatorskins.csv", var1, 0 );
            
            if ( !isdefined( level.showing_bomb_wire_pair_to_player[ var2 ] ) )
            {
                level.showing_bomb_wire_pair_to_player[ var2 ][ "lootIDs" ] = [];
                level.showing_bomb_wire_pair_to_player[ var2 ][ "curIndex" ] = 0;
                level.showing_bomb_wire_pair_to_player[ var2 ][ "maxIndex" ] = 0;
            }
            
            level.showing_bomb_wire_pair_to_player[ var2 ][ "lootIDs" ][ level.showing_bomb_wire_pair_to_player[ var2 ][ "lootIDs" ].size ] = int( var3 );
            level.showing_bomb_wire_pair_to_player[ var2 ][ "maxIndex" ] = level.showing_bomb_wire_pair_to_player[ var2 ][ "maxIndex" ] + 1;
        }
    }
}

// Params 0
// Size: 0x20c
function initoperatorcustomization()
{
    if ( isdefined( level.operatorcustomization ) )
    {
        return;
    }
    
    level.operatorcustomization = [];
    var0 = getlocalestructarray();
    setdvar( "cl_streamSync_devNoLatch", 1 );
    
    for ( var1 = 0;  ; var1++ )
    {
        var2 = tablelookupbyrow( "operators.csv", var1, 1 );
        var3 = getoperatorsuperfaction( var2 );
        var4 = scripts\engine\utility::ter_op( var3 == 0, "allies", "axis" );
        
        if ( !isdefined( var2 ) || var2 == "" )
        {
            break;
        }
        
        var5 = int( tablelookupbyrow( "operators.csv", var1, 8 ) );
        var6 = resetunresolvedcollision( var2 );
        var7 = var0 && update_track_operational_status( var2 );
        
        if ( var5 && var6 && !var7 )
        {
            if ( !isdefined( level.operatorcustomization[ var4 ] ) )
            {
                level.operatorcustomization[ var4 ] = [];
            }
            
            level.operatorcustomization[ var4 ][ var2 ] = [];
        }
    }
    
    var8 = 0;
    
    for ( ;; )
    {
        var9 = int( tablelookupbyrow( "operatorskins.csv", var8, 20 ) );
        var10 = tablelookupbyrow( "operatorskins.csv", var8, 1 );
        
        if ( !isdefined( var10 ) || var10 == "" )
        {
            break;
        }
        
        if ( var9 )
        {
            var2 = tablelookupbyrow( "operatorskins.csv", var8, 2 );
            var11 = tablelookupbyrow( "operatorskins.csv", var8, 4 );
            var12 = tablelookupbyrow( "operatorskins.csv", var8, 5 );
            var4 = getoperatorteambyref( var2 );
            
            if ( !isdefined( var4 ) )
            {
                var8++;
                continue;
            }
            
            var13 = [];
            GscBinSkip0( 0x2e, 0, var11 );
            // Unknown operator ( 0x2e, iw8, PC )
        }
        
        var9++;
    }
    
    if ( getdvarint( "scr_customization_missing_skins_fixup", 1 ) == 1 )
    {
        for ( var2 = 0;  ; var2++ )
        {
            var3 = tablelookupbyrow( "operators.csv", var2, 1 );
            var4 = getoperatorsuperfaction( var3 );
            var5 = scripts\engine\utility::ter_op( var4 == 0, "allies", "axis" );
            
            if ( !isdefined( var3 ) || var3 == "" )
            {
                break;
            }
            
            var6 = int( tablelookupbyrow( "operators.csv", var2, 8 ) );
            
            if ( var6 && isdefined( level.operatorcustomization[ var5 ][ var3 ] ) && level.operatorcustomization[ var5 ][ var3 ].size == 0 )
            {
                level.operatorcustomization[ var5 ][ var3 ] = undefined;
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x58
function getoperatorteambyref( var0 )
{
    foreach ( var2 in level.operatorcustomization )
    {
        foreach ( var4 in var2 )
        {
            if ( var5 == var0 )
            {
                return var6;
            }
        }
    }
    
    return undefined;
}

// Params 2
// Size: 0x75
function getnextoperatorindex( var0, var1 )
{
    if ( !var1 )
    {
        var2 = 0;
        
        foreach ( var4 in level.operatorcustomization[ self.team ] )
        {
            if ( var0 == var5 )
            {
                break;
            }
            
            var2++;
        }
        
        var6 = undefined;
        var7 = var2 + 1;
        
        if ( var7 == level.operatorcustomization[ self.team ].size )
        {
            var7 = 0;
        }
        
        return var7;
    }
    
    return randomint( level.operatorcustomization[ self.team ].size );
}

// Params 2
// Size: 0x11e
function getnextskinindex( var0, var1 )
{
    if ( !var1 )
    {
        var2 = self getentitynumber();
        
        if ( !isdefined( level.playercustomizationdata ) )
        {
            level.playercustomizationdata = [];
        }
        
        var3 = undefined;
        
        if ( !isdefined( level.playercustomizationdata[ var2 ] ) )
        {
            level.playercustomizationdata[ var2 ] = [];
        }
        
        if ( !isdefined( level.playercustomizationdata[ var2 ][ self.team ] ) )
        {
            var4 = spawnstruct();
            var4.operatorref = var0;
            
            if ( isai( self ) )
            {
                var4.operatorskinindex = self.botskinid;
            }
            else
            {
                var4.operatorskinindex = restart_watcher( var0 );
            }
            
            level.playercustomizationdata[ var2 ][ self.team ] = var4;
        }
        
        var3 = level.playercustomizationdata[ var2 ][ self.team ].operatorskinindex;
        var5 = tablelookup( "operatorskins.csv", 0, var3, 1 );
        var6 = 0;
        
        foreach ( var8 in level.operatorcustomization[ self.team ][ var0 ] )
        {
            if ( var5 == var9 )
            {
                break;
            }
            
            var6++;
        }
        
        var10 = var6 + 1;
        
        if ( var10 == level.operatorcustomization[ self.team ][ var0 ].size )
        {
            var10 = 0;
        }
        
        return var10;
    }
    
    return randomint( level.operatorcustomization[ self.team ][ var9 ].size );
}

// Params 0
// Size: 0x59
function getplayerlookattarget()
{
    var0 = self geteye();
    var1 = self getplayerangles();
    var2 = anglestoforward( var1 );
    var3 = var0 + var2 * 10000;
    var4 = [ "physicscontents_player" ];
    var5 = physics_createcontents( var4 );
    var6 = scripts\engine\trace::sphere_trace( var0, var3, 5, self, var5, 0 );
    var7 = var6[ "entity" ];
    
    if ( isdefined( var7 ) && isplayer( var7 ) )
    {
        return var7;
    }
    
    return undefined;
}

// Params 0
// Size: 0x87
function devmonitoroperatorcustomizationprint()
{
    for ( ;; )
    {
        waitframe();
        var0 = [];
        
        if ( getdvarint( "scr_operator_print_all", 0 ) != 0 )
        {
            initoperatorcustomization();
            var0 = level.players;
        }
        
        if ( getdvarint( "scr_operator_print_target", 0 ) != 0 )
        {
            initoperatorcustomization();
            var1 = getplayerlookattarget( level.players[ 0 ] );
            
            if ( !isdefined( var1 ) )
            {
                continue;
            }
            
            var0 = var1;
        }
        
        if ( var0.size > 0 )
        {
            foreach ( var3 in var0 )
            {
                printcustomization( var3 );
            }
        }
    }
}

// Params 0
// Size: 0x16
function printcustomization()
{
    if ( !scripts\mp\utility\teams::isgameplayteam( self.team ) )
    {
        return;
    }
    
    var0 = getoperatorcustomization();
}

// Params 0
// Size: 0xa1
function ref_12304()
{
    var0 = undefined;
    var1 = 1;
    
    if ( istrue( level.onlinegame ) )
    {
        var2 = self getfireteammembers();
        var1 = var2.size;
        
        if ( isdefined( var2 ) && var2.size > 0 )
        {
            foreach ( var4 in var2 )
            {
                if ( isdefined( var4 ) && scripts\mp\utility\teams::isgameplayteam( var4.team ) )
                {
                    var0 = var4.team;
                    self.ref_13ac9 = var4.ref_13ac9;
                    break;
                }
            }
        }
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = play_reset_priming_anim( var1 );
    }
    
    if ( !isdefined( self.ref_13ac9 ) )
    {
        self.ref_13ac9 = gettime();
    }
    
    thread scripts\mp\menus::setteam( var0 );
}

// Params 1
// Size: 0x9d
function play_reset_priming_anim( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    var1 = undefined;
    
    foreach ( var3 in level.teamnamelist )
    {
        var4 = scripts\mp\utility\teams::getteamcount( var3 );
        var5 = level.maxteamsize - var4;
        
        if ( var5 < var0 )
        {
            continue;
        }
        
        if ( var4 > 0 )
        {
            var6 = scripts\mp\utility\teams::getteamdata( var3, "players" );
            
            if ( isdefined( var6[ 0 ].ref_13ac9 ) && gettime() > var6[ 0 ].ref_13ac9 + 300000 )
            {
                continue;
            }
        }
        
        var1 = var3;
        break;
    }
    
    return var1;
}

// Params 0
// Size: 0xd6
function istempsfxent()
{
    var0 = 25;
    
    for ( ;; )
    {
        if ( isdefined( level.teamdata ) )
        {
            var1 = 400;
            var2 = 200;
            var3 = 1;
            var4 = 0;
            
            foreach ( var6 in level.teamnamelist )
            {
                var3 = 1;
                var3++;
                
                foreach ( var8 in level.teamdata[ var6 ][ "players" ] )
                {
                    var9 = ( 1, 1, 1 );
                    
                    if ( istrue( var8.squadassignedfromlobby ) )
                    {
                        var9 = ( 0, 1, 0 );
                    }
                    
                    var3++;
                }
                
                var2 += 100;
                var4++;
                
                if ( var4 > 6 )
                {
                    var4 = 0;
                    var1 += 200;
                    var2 = 200;
                }
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x24, Type: bool
function ref_132e6()
{
    return getdvarint( "scr_br_zombie_encounters", 0 ) > 0 || getdvarint( "scr_br_alt_mode_fiend", 0 ) > 0 || scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe();
}

