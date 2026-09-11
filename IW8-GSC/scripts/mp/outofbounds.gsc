
// Params 2
// Size: 0xe
function registerentforoob( var0, var1 )
{
    var0.oobref = var1;
}

// Params 1
// Size: 0xb
function deregisterentforoob( var0 )
{
    var0.oobref = undefined;
}

// Params 2
// Size: 0x16
function registeroobentercallback( var0, var1 )
{
    var2 = getoobdata();
    var2.entercallbacks[ var0 ] = var1;
}

// Params 2
// Size: 0x16
function registeroobexitcallback( var0, var1 )
{
    var2 = getoobdata();
    var2.exitcallbacks[ var0 ] = var1;
}

// Params 2
// Size: 0x16
function registerooboutoftimecallback( var0, var1 )
{
    var2 = getoobdata();
    var2.outoftimecallbacks[ var0 ] = var1;
}

// Params 2
// Size: 0x16
function registeroobclearcallback( var0, var1 )
{
    var2 = getoobdata();
    var2.clearcallbacks[ var0 ] = var1;
}

// Params 1
// Size: 0x2b
function unset_relic_rocket_kill_ammo( var0 )
{
    if ( scripts\mp\utility\game::unset_relic_grounded() && isdefined( level.¨›i«¿cèœW0ÍÍs@`cÿ“@/ ) )
    {
        return [[ level.¨›i«¿cèœW0ÍÍs@`cÿ“@/ ]]( var0, 0, 1 );
    }
    
    return !ispointinoutofbounds( var0 );
}

// Params 2
// Size: 0x36, Type: bool
function isoob( var0, var1 )
{
    if ( isoobimmune( var0 ) )
    {
        return false;
    }
    
    if ( istrue( var1 ) && isoobimmune( var0 ) )
    {
        return false;
    }
    
    return isdefined( var0.oob ) && var0.oob > 0;
}

// Params 1
// Size: 0x4f
function enableoob( var0 )
{
    if ( !isdefined( var0.oob ) )
    {
        var0.oob = 0;
    }
    
    var0.oob++;
    
    if ( var0.oob == 1 )
    {
        if ( !isdefined( var0.oobimmunity ) || var0.oobimmunity <= 0 )
        {
            onenteroob( var0 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x42
function disableoob( var0 )
{
    var0.oob--;
    
    if ( var0.oob == 0 )
    {
        var0.oob = undefined;
        
        if ( !isdefined( var0.oobimmunity ) || var0.oobimmunity <= 0 )
        {
            onexitoob( var0, 0 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x19, Type: bool
function isoobimmune( var0 )
{
    return isdefined( var0.oobimmunity ) && var0.oobimmunity > 0;
}

// Params 1
// Size: 0x4f
function enableoobimmunity( var0 )
{
    if ( !isdefined( var0.oobimmunity ) )
    {
        var0.oobimmunity = 0;
    }
    
    var0.oobimmunity++;
    
    if ( var0.oobimmunity == 1 )
    {
        if ( isdefined( var0.oob ) && var0.oob > 0 )
        {
            onexitoob( var0, 0 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x40
function disableoobimmunity( var0 )
{
    var0.oobimmunity--;
    
    if ( var0.oobimmunity == 0 )
    {
        var0.oobimmunity = undefined;
        
        if ( isdefined( var0.oob ) && var0.oob > 0 )
        {
            onenteroob( var0 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x11b
function clearoob( var0, var1 )
{
    var0 notify( "clear_oob" );
    
    if ( isoob( var0, 1 ) )
    {
        onexitoob( var0, var1, 1 );
    }
    
    var2 = undefined;
    
    if ( isplayer( var0 ) )
    {
        var2 = &playerclearcallback;
    }
    else if ( isdefined( var0.oobref ) )
    {
        var3 = getoobdata();
        var2 = var3.clearcallbacks[ var0.oobref ];
    }
    
    if ( isdefined( var2 ) )
    {
        var0 [[ var2 ]]();
    }
    
    var0.oobref = undefined;
    var0.oob = undefined;
    var0.oobimmunity = undefined;
    var0.oobtimeleft = undefined;
    var0.oobendtime = undefined;
    var0.oobtriggertype = undefined;
    
    if ( isdefined( var0.oobtriggers ) )
    {
        foreach ( var5 in var0.oobtriggers )
        {
            var5.entstouching[ var0 getentitynumber() ] = undefined;
        }
        
        var0.oobtriggers = undefined;
    }
    
    if ( isdefined( var0.oobsupressiontriggers ) )
    {
        foreach ( var5 in var0.oobsupressiontriggers )
        {
            var5.entstouching[ var0 getentitynumber() ] = undefined;
        }
        
        var0.oobsupressiontriggers = undefined;
        return;
    }
}

// Params 0
// Size: 0x63, Type: bool
function istouchingoobtrigger()
{
    if ( istrue( self.allowedintrigger ) )
    {
        return false;
    }
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return false;
    }
    
    foreach ( var1 in level.outofboundstriggers )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        if ( !interactswithgivenoobtrigger( var1, self ) )
        {
            continue;
        }
        
        if ( self istouching( var1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 2
// Size: 0x70
function ispointinoutofbounds( var0, var1 )
{
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return 0;
    }
    
    foreach ( var3 in level.outofboundstriggers )
    {
        if ( isdefined( var3 ) && ispointinvolume( var0, var3 ) )
        {
            if ( isdefined( var3.script_team ) && isdefined( var1 ) && var3.script_team != var1 )
            {
                continue;
            }
            
            return 1;
        }
    }
    
    return 0;
}

// Params 1
// Size: 0x75, Type: bool
function useshouldsucceedcallback( var0 )
{
    var1 = 16;
    var2 = physics_createcontents( [ "physicscontents_playertrigger" ] );
    var3 = physics_spherecast( var0, var0, var1, var2, undefined, "physicsquery_all" );
    
    foreach ( var5 in var3 )
    {
        var6 = var5[ "entity" ];
        
        if ( isdefined( var6 ) && isdefined( var6.targetname ) && var6.targetname == "OutOfBounds" )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x8
function initoob()
{
    thread watchoobtriggers();
}

// Params 1
// Size: 0x103
function onenteroob( var0 )
{
    var1 = undefined;
    var2 = getlastoobtrigger( var0 );
    var3 = gettriggertype( var0, var2 );
    
    if ( isplayer( var0 ) )
    {
        if ( isdefined( level.ref_11c7b ) )
        {
            var1 = level.ref_11c7b;
        }
        else
        {
            var1 = &playerentercallback;
        }
    }
    else if ( isdefined( var0.oobref ) )
    {
        var4 = getoobdata();
        var1 = var4.entercallbacks[ var0.oobref ];
    }
    
    var0 notify( "oob_cooldown_end" );
    
    if ( isdefined( var0.oobtimeleft ) && previouslytouchedtriggertype( var0, var3 ) )
    {
        var5 = var0.oobtimeleft / 1000;
        var0.oobendtime = int( gettime() + var0.oobtimeleft );
        var0.oobtimeleft = undefined;
        thread watchooboutoftime( var0, var5 );
    }
    else
    {
        var1.oobtimeleft = undefined;
        var1.oobtriggertype = var5;
        var5 = getoutofboundstime( var5, var1 );
        var1.oobendtime = int( gettime() + var5 * 1000 );
        thread watchooboutoftime( var1, var5 );
    }
    
    if ( isdefined( var2 ) )
    {
        var1 thread [[ var2 ]]( "exit_oob", "clear_oob", var5 );
        return;
    }
}

// Params 3
// Size: 0xc9
function onexitoob( var0, var1, var2 )
{
    var0 notify( "exit_oob" );
    var3 = undefined;
    
    if ( isplayer( var0 ) )
    {
        if ( isdefined( level.ref_11c7c ) )
        {
            var3 = level.ref_11c7c;
        }
        else
        {
            var3 = &playerexitcallback;
        }
    }
    else if ( isdefined( var0.oobref ) )
    {
        var4 = getoobdata();
        var3 = var4.exitcallbacks[ var0.oobref ];
    }
    
    var0 notify( "oob_timeout_end" );
    
    if ( !istrue( var2 ) )
    {
        if ( isdefined( var0.oobendtime ) )
        {
            var0.oobtimeleft = int( max( 0, var0.oobendtime - gettime() ) );
            var0.oobendtime = undefined;
            var5 = getlastoobtrigger( var0 );
            var6 = gettriggertype( var0, var5 );
            var7 = getcooldowntime( var6 );
            thread watchoobcooldown( var0, var7 );
        }
    }
    
    if ( isdefined( var3 ) )
    {
        var0 thread [[ var3 ]]( var1, var2, "clear_oob" );
        return;
    }
}

// Params 1
// Size: 0x90
function onooboutoftime( var0 )
{
    var1 = undefined;
    
    if ( isplayer( var0 ) )
    {
        var2 = 1;
        
        if ( level.gametype == "br" )
        {
            if ( istrue( level.stop_end_breach_fx ) )
            {
                var2 = 0;
            }
            else if ( isdefined( level.matchcountdowntime ) && level.matchcountdowntime < 2 )
            {
                var2 = 0;
            }
        }
        
        if ( var2 )
        {
            var1 = &playeroutoftimecallback;
        }
    }
    else if ( isdefined( var0.oobref ) )
    {
        var3 = getoobdata();
        var1 = var3.outoftimecallbacks[ var0.oobref ];
    }
    
    if ( isdefined( var1 ) )
    {
        var0 thread [[ var1 ]]( "oob_timeout_end", "clear_oob" );
        return;
    }
}

// Params 2
// Size: 0x3e
function watchooboutoftime( var0, var1 )
{
    if ( isplayer( var0 ) )
    {
        var0 endon( "death_or_disconnect" );
    }
    else
    {
        var0 endon( "death" );
    }
    
    var0 notify( "oob_timeout_end" );
    var0 endon( "oob_timeout_end" );
    var0 endon( "clear_oob" );
    wait var1;
    thread onooboutoftime( var0 );
}

// Params 2
// Size: 0x45
function watchoobcooldown( var0, var1 )
{
    if ( isplayer( var0 ) )
    {
        var0 endon( "death_or_disconnect" );
    }
    else
    {
        var0 endon( "death" );
    }
    
    var0 notify( "oob_cooldown_end" );
    var0 endon( "oob_cooldown_end" );
    var0 endon( "clear_oob" );
    wait var1;
    var0.oobtimeleft = undefined;
    var0.oobtriggertype = undefined;
}

// Params 3
// Size: 0x4b
function playerentercallback( var0, var1, var2 )
{
    var3 = 1;
    
    if ( scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isdefined( var2 ) && var2 == "restricted" )
    {
        var3 = 2;
    }
    
    self setclientomnvar( "ui_out_of_bounds_type", var3 );
    self setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
}

// Params 3
// Size: 0x1c
function playerexitcallback( var0, var1, var2 )
{
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Params 2
// Size: 0x43
function playeroutoftimecallback( var0, var1 )
{
    var2 = getlastoobtrigger( self );
    var3 = gettriggertype( self, var2 );
    
    if ( var3 == "minefield" )
    {
        thread playeroutoftimeminefield( var0, var1 );
        return;
    }
    
    if ( !isdefined( self.plotarmor ) || !self.plotarmor )
    {
        scripts\mp\utility\damage::_suicide();
        return;
    }
}

// Params 1
// Size: 0x1a
function playerclearcallback( var0 )
{
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Params 2
// Size: 0x9a
function playeroutoftimeminefield( var0, var1 )
{
    var2 = self.origin;
    var3 = scripts\engine\trace::ray_trace( self.origin, self.origin - ( 0, 0, 1000 ), self );
    
    if ( isdefined( var3[ "hittype" ] != "hittype_none" ) && isdefined( var3[ "position" ] ) )
    {
        var2 = var3[ "position" ];
    }
    
    var4 = spawn( "script_model", var2 );
    var4 setmodel( "ks_minefield_mp" );
    var4 setentityowner( self );
    var4 setotherent( self );
    var4 setscriptablepartstate( "warning_click", "on", 0 );
    var5 = playeroutoftimeminefieldinternal( var4, var0, var1 );
    
    if ( istrue( var5 ) )
    {
        wait 2;
    }
    
    var4 delete();
}

// Params 3
// Size: 0x5b, Type: bool
function playeroutoftimeminefieldinternal( var0, var1, var2 )
{
    self endon( "death_or_disconnect" );
    
    if ( isdefined( var1 ) )
    {
        self endon( var1 );
    }
    
    if ( isdefined( var2 ) )
    {
        self endon( var2 );
    }
    
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.3 );
    var0 setscriptablepartstate( "explosion", "on", 0 );
    wait 0.05;
    self dodamage( 2000, self.origin, self, var0, "MOD_EXPLOSIVE", "minefield_mp" );
    return true;
}

// Params 3
// Size: 0x5d
function killstreakentercallback( var0, var1, var2 )
{
    var3 = 1;
    
    if ( scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isdefined( var2 ) && var2 == "restricted" )
    {
        var3 = 2;
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", var3 );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
        return;
    }
}

// Params 3
// Size: 0x2e
function killstreakexitcallback( var0, var1, var2 )
{
    if ( isdefined( self.owner ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", 0 );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
        return;
    }
}

// Params 2
// Size: 0x44
function killstreakoutoftimecallback( var0, var1 )
{
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        var2 = "nuke_mp";
    }
    else
    {
        var2 = "danger_circle_br";
    }
    
    scripts\mp\utility\killstreak::dodamagetokillstreak( 10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", var2 );
}

// Params 0
// Size: 0x2a
function killstreakclearcallback()
{
    if ( isdefined( self.owner ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", 0 );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
        return;
    }
}

// Params 0
// Size: 0x3e
function killstreakregisteroobcallbacks()
{
    registeroobentercallback( "killstreak", &killstreakentercallback );
    registeroobexitcallback( "killstreak", &killstreakexitcallback );
    registerooboutoftimecallback( "killstreak", &killstreakoutoftimecallback );
    registeroobclearcallback( "killstreak", &killstreakclearcallback );
}

// Params 0
// Size: 0x8e
function watchoobtriggers()
{
    if ( scripts\mp\utility\game::lpcfeaturegated() && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "br" )
    {
        return;
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( var1 in level.outofboundstriggers )
        {
            thread watchoobtrigger( var1 );
        }
        
        if ( isdefined( level.outofboundstriggerpatches ) )
        {
            foreach ( var1 in level.outofboundstriggerpatches )
            {
                thread watchoobsuppressiontrigger( var1 );
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x33
function watchoobtrigger( var0 )
{
    var0.entstouching = [];
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        scripts\mp\flags::gameflagwait( "prematch_done" );
    }
    
    thread watchoobtriggerexit( var0 );
    thread watchoobtriggerenter( var0 );
}

// Params 1
// Size: 0xd1
function watchoobtriggerenter( var0 )
{
    level endon( "game_ended" );
    var0 endon( "clearOOB" );
    var0 endon( "death" );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        
        if ( isplayer( var1 ) )
        {
            if ( scripts\mp\utility\game::updatehistoryhud( var1 ) )
            {
                continue;
            }
            else if ( isdefined( var1.vehicle ) && isdefined( var1.vehicle.turrets ) )
            {
                foreach ( var3 in var1.vehicle.turrets )
                {
                    if ( scripts\engine\utility::is_equal( var3.owner, var1 ) )
                    {
                        var1 = var1.vehicle;
                        break;
                    }
                }
            }
        }
        
        if ( !interactswithgivenoobtrigger( var0, var1 ) )
        {
            continue;
        }
        
        if ( !interactswithoobtriggers( var1 ) )
        {
            continue;
        }
        
        onenteroobtrigger( var0, var1 );
    }
}

// Params 1
// Size: 0x6f
function watchoobtriggerexit( var0 )
{
    level endon( "game_ended" );
    var0 endon( "clearOOB" );
    var0 endon( "death" );
    
    for ( ;; )
    {
        var1 = var0.entstouching;
        
        foreach ( var3 in var1 )
        {
            if ( !isdefined( var3 ) )
            {
                var0.entstouching[ var4 ] = undefined;
            }
            
            if ( isdefined( var3 ) && !var0 istouching( var3 ) )
            {
                onexitoobtrigger( var0, var3 );
            }
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x7a
function onenteroobtrigger( var0, var1 )
{
    var2 = var1 getentitynumber();
    
    if ( isdefined( var0.entstouching[ var2 ] ) )
    {
        return;
    }
    
    var0.entstouching[ var2 ] = var1;
    
    if ( !isdefined( var1.oobtriggers ) )
    {
        var1.oobtriggers = [];
    }
    
    var3 = [ var0 ];
    
    foreach ( var5 in var1.oobtriggers )
    {
        var3 = var5;
    }
    
    var1.oobtriggers = var3;
    enableoob( var1 );
}

// Params 2
// Size: 0x45
function onexitoobtrigger( var0, var1 )
{
    var2 = var1 getentitynumber();
    var0.entstouching[ var2 ] = undefined;
    disableoob( var1 );
    var1.oobtriggers = scripts\engine\utility::array_remove( var1.oobtriggers, var0 );
    
    if ( var1.oobtriggers.size == 0 )
    {
        var1.oobtriggers = undefined;
        return;
    }
}

// Params 1
// Size: 0x26
function watchoobsuppressiontrigger( var0 )
{
    var0.entstouching = [];
    scripts\mp\flags::gameflagwait( "prematch_done" );
    thread watchoobsuppressiontriggerexit( var0 );
    thread watchoobsupressiontriggerenter( var0 );
}

// Params 1
// Size: 0x30
function watchoobsupressiontriggerenter( var0 )
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        
        if ( !interactswithoobtriggers( var1 ) )
        {
            continue;
        }
        
        onenteroobsuppressiontrigger( var0, var1 );
    }
}

// Params 1
// Size: 0x64
function watchoobsuppressiontriggerexit( var0 )
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var1 = var0.entstouching;
        
        if ( isdefined( var1 ) )
        {
            foreach ( var3 in var1 )
            {
                if ( !isdefined( var3 ) )
                {
                    var0.entstouching[ var4 ] = undefined;
                }
                
                if ( isdefined( var3 ) && !var0 istouching( var3 ) )
                {
                    onexitoobsupressiontrigger( var0, var3 );
                }
            }
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x7a
function onenteroobsuppressiontrigger( var0, var1 )
{
    var2 = var1 getentitynumber();
    
    if ( isdefined( var0.entstouching[ var2 ] ) )
    {
        return;
    }
    
    var0.entstouching[ var2 ] = var1;
    
    if ( !isdefined( var1.oobsupressiontriggers ) )
    {
        var1.oobsupressiontriggers = [];
    }
    
    var3 = [ var0 ];
    
    foreach ( var5 in var1.oobsupressiontriggers )
    {
        var3 = var5;
    }
    
    var1.oobsupressiontriggers = var3;
    enableoobimmunity( var1 );
}

// Params 2
// Size: 0x3b
function onexitoobsupressiontrigger( var0, var1 )
{
    var2 = var1 getentitynumber();
    var0.entstouching[ var2 ] = undefined;
    var1.oobsupressiontriggers[ var0 getentitynumber() ] = undefined;
    
    if ( var1.oobsupressiontriggers.size == 0 )
    {
        var1.oobsupressiontriggers = undefined;
    }
    
    disableoobimmunity( var1 );
}

// Params 2
// Size: 0xf3, Type: bool
function interactswithgivenoobtrigger( var0, var1 )
{
    if ( isdefined( var0.script_team ) )
    {
        if ( scripts\mp\utility\game::unset_relic_landlocked() )
        {
            return false;
        }
        
        var2 = 0;
        
        if ( var1 scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            var2 = 1;
        }
        
        if ( var2 )
        {
            if ( var2 && isdefined( var1.team ) && var1.team != "neutral" && var1.team != var0.script_team )
            {
                return false;
            }
            
            if ( var2 && isdefined( var1.owner ) && var1.owner.team != var0.script_team )
            {
                return false;
            }
            
            if ( var2 && isdefined( var1.occupants ) )
            {
                foreach ( var4 in var1.occupants )
                {
                    if ( var4.team != var0.script_team )
                    {
                        return false;
                    }
                }
            }
        }
        else if ( var1.team != var0.script_team )
        {
            return false;
        }
    }
    
    return true;
}

// Params 1
// Size: 0x64, Type: bool
function interactswithoobtriggers( var0 )
{
    if ( isdefined( var0 ) )
    {
        if ( isplayer( var0 ) )
        {
            if ( var0 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                return true;
            }
        }
        
        if ( isdefined( var0.oobref ) )
        {
            if ( var0 scripts\cp_mp\vehicles\vehicle::isvehicle() )
            {
                if ( !istrue( var0.isdestroyed ) )
                {
                    return true;
                }
            }
            
            if ( isdefined( var0.streakinfo ) && iskillstreakaffectedbyobb( var0.streakinfo.streakname ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 0
// Size: 0x3e
function getoobdata()
{
    var0 = level.oobdata;
    
    if ( !isdefined( var0 ) )
    {
        var0 = spawnstruct();
        var0.entercallbacks = [];
        var0.exitcallbacks = [];
        var0.outoftimecallbacks = [];
        var0.clearcallbacks = [];
        level.oobdata = var0;
    }
    
    return var0;
}

// Params 1
// Size: 0x2f
function iskillstreakaffectedbyobb( var0 )
{
    var1 = 0;
    
    switch ( var0 )
    {
        case "radar_drone_recon":
        case "rcxd_rad":
        case "pac_sentry":
            var1 = 1;
            break;
    }
    
    return var1;
}

// Params 2
// Size: 0x8b
function gettriggertype( var0, var1 )
{
    var2 = "default";
    
    if ( level.gametype == "br" )
    {
        return "br";
    }
    
    if ( isdefined( var1 ) && isdefined( var1.script_team ) )
    {
        return "restricted";
    }
    
    if ( isdefined( var0 ) && var0 scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        return "default";
    }
    
    if ( isdefined( var0 ) && isdefined( var0.streakinfo ) )
    {
        return "default";
    }
    
    if ( isdefined( var1 ) && isdefined( var1.script_noteworthy ) && var1.script_noteworthy == "MineField" )
    {
        var2 = "minefield";
    }
    
    return var2;
}

// Params 1
// Size: 0x30
function getcooldowntime( var0 )
{
    switch ( var0 )
    {
        case "restricted":
        case "minefield":
        case "br":
        case "default":
            return scripts\mp\utility\game::getmaxoutofboundscooldown();
    }
    
    return undefined;
}

// Params 2
// Size: 0x7c
function getoutofboundstime( var0, var1 )
{
    var2 = var1.ref_12cce;
    
    if ( istrue( var2 ) )
    {
        return scripts\mp\utility\game::repair_grill_stop_exit_foley_sfx();
    }
    
    if ( isdefined( var2 ) && !var2 )
    {
        return scripts\mp\utility\game::repair_grill_start_enter_foley_sfx();
    }
    
    if ( var1 scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        var3 = var1 scripts\mp\utility\game::runbrgametypefunc();
        
        if ( isdefined( var3 ) )
        {
            return var3;
        }
    }
    
    switch ( var0 )
    {
        case "minefield":
            return scripts\mp\utility\game::getmaxoutofboundsminefieldtime();
        case "restricted":
            return scripts\mp\utility\game::getmaxoutofboundsrestrictedtime();
        case "br":
            return scripts\mp\utility\game::repair_grill_fixing_short_sfx();
        case "default":
            return scripts\mp\utility\game::getmaxoutofboundstime();
    }
    
    return undefined;
}

// Params 1
// Size: 0x1b
function getlastoobtrigger( var0 )
{
    if ( isdefined( var0.oobtriggers ) )
    {
        return var0.oobtriggers[ 0 ];
    }
    
    return undefined;
}

// Params 2
// Size: 0x5b
function previouslytouchedtriggertype( var0, var1 )
{
    var2 = 0;
    
    if ( isdefined( var0.oobtriggertype ) )
    {
        var3 = var0.oobtriggertype;
        
        if ( var1 == var3 )
        {
            var2 = 1;
        }
        else if ( ( var1 == "default" || var1 == "minefield" ) && ( var3 == "default" || var3 == "minefield" ) )
        {
            var2 = 1;
        }
    }
    
    return var2;
}

