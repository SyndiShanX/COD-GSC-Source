
// Params 1
// Size: 0x14d
function main( var0 )
{
    GscBinSkip0( 0x2e, var0.size, "airdrop_pallet" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x19
function init()
{
    level.numgametypereservedobjectives = 0;
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    thread getleveltriggers();
}

// Params 0
// Size: 0x57
function onplayerspawned()
{
    if ( isbot( self ) )
    {
        level.botsenabled = 1;
    }
    
    var0 = !istrue( level.disableinitplayergameobjects );
    
    if ( scripts\mp\utility\game::getgametype() == "war" )
    {
        var0 = 0;
    }
    
    if ( getdvarint( "scr_forceGameObjectPlayerInit", 0 ) == 1 )
    {
        var0 = 1;
    }
    
    if ( var0 )
    {
        if ( isdefined( self.gameobject_fauxspawn ) )
        {
            self.gameobject_fauxspawn = undefined;
            return;
        }
        
        init_player_gameobjects();
    }
}

// Params 0
// Size: 0x22
function init_player_gameobjects()
{
    thread ondeathordisconnect();
    self.touchtriggers = [];
    self.carryobject = undefined;
    self.canpickupobject = 1;
    self.initialized_gameobject_vars = 1;
}

// Params 0
// Size: 0x16
function ondeathordisconnect()
{
    level endon( "game_ended" );
    self waittill( "death_or_disconnect" );
    _ondeathordisconnectinternal();
}

// Params 0
// Size: 0x17
function _ondeathordisconnectinternal()
{
    if ( isdefined( self.carryobject ) )
    {
        thread setdropped();
        return;
    }
}

// Params 0
// Size: 0x21
function onjuggernaut()
{
    waittillframeend();
    
    if ( isdefined( self.carryobject ) )
    {
        thread setdropped();
        self switchtoweapon( scripts\mp\juggernaut::vehicle_damage_setweaponclassmoddamageforvehicle() );
        return;
    }
}

// Params 2
// Size: 0xc5
function createtrackedobject( var0, var1 )
{
    var2 = spawn( "script_model", self.origin );
    var2 setmodel( "tag_origin" );
    var3 = spawnstruct();
    var3.type = "carryObject";
    var3.carrier = var0;
    var3.curorigin = var0.origin;
    var3.entnum = var2 getentitynumber();
    var3.ownerteam = var0.team;
    var3.offset3d = var1;
    var3.triggertype = "none";
    var3.compassicons = [];
    var3.objidpingfriendly = 0;
    var3.objidpingenemy = 0;
    var3.carriervisible = 0;
    var3.visibleteam = "none";
    requestid( var3, 1, 1 );
    thread updatecarryobjectorigin();
    thread deletetrackedobjectoncarrierdisconnect();
    return var3;
}

// Params 0
// Size: 0x13
function deletetrackedobjectoncarrierdisconnect()
{
    self.carrier waittill( "disconnect" );
    deletetrackedobject();
}

// Params 0
// Size: 0x67
function deletetrackedobject()
{
    if ( self.type != "carryObject" )
    {
        return;
    }
    
    var0 = self;
    var0.type = undefined;
    var0.carrier = undefined;
    var0.curorigin = undefined;
    var0.entnum = undefined;
    var0.ownerteam = undefined;
    var0.compassicons = undefined;
    var0.objidpingfriendly = undefined;
    var0.objidpingenemy = undefined;
    var0.carriervisible = undefined;
    var0.visibleteam = undefined;
    releaseid();
    self notify( "gameobject_deleted" );
}

// Params 6
// Size: 0x2e2
function createcarryobject( var0, var1, var2, var3, var4, var5 )
{
    var6 = spawnstruct();
    var6.type = "carryObject";
    var6.curorigin = var1.origin;
    var6.ownerteam = var0;
    var6.useifproximity = var4;
    var6.entnum = var1 getentitynumber();
    
    if ( issubstr( var1.classname, "use" ) )
    {
        var6.triggertype = "use";
    }
    else
    {
        var6.triggertype = "proximity";
    }
    
    var1.gameobject = var6;
    var1.baseorigin = var1.origin;
    var6.trigger = var1;
    
    if ( !isdefined( var1.linktoenabledflag ) )
    {
        var1.linktoenabledflag = 1;
        var1 enablelinkto();
    }
    
    var6.useweapon = undefined;
    
    if ( !isdefined( var3 ) )
    {
        var3 = ( 0, 0, 0 );
    }
    
    var6.offset3d = var3;
    
    for ( var7 = 0; var7 < var2.size ; var7++ )
    {
        var2[ var7 ].baseorigin = var2[ var7 ].origin;
        var2[ var7 ].baseangles = var2[ var7 ].angles;
    }
    
    var6.visuals = var2;
    var6.compassicons = [];
    var6.objidpingfriendly = 0;
    var6.objidpingenemy = 0;
    
    if ( !isdefined( var5 ) )
    {
        requestid( var6, 1, 1 );
    }
    
    var6.carrier = undefined;
    var6.isresetting = 0;
    var6.interactteam = "none";
    var6.allowweapons = 0;
    var6.carriervisible = 0;
    var6.visibleteam = "none";
    var6.carryicon = undefined;
    var6.ondrop = undefined;
    var6.onpickup = undefined;
    var6.onreset = undefined;
    var6.ref_12355 = [];
    
    if ( var6.triggertype == "use" )
    {
        thread carryobjectusethink();
    }
    else
    {
        var6.curprogress = 0;
        var6.teamprogress = [];
        var6.teamprogress[ "none" ] = 0;
        var6.usetime = 0;
        var6.userate = 0;
        var6.useratemultiplier = 1;
        var6.mustmaintainclaim = 0;
        var6.cancontestclaim = 0;
        var6.teamusetimes = [];
        var6.teamusetexts = [];
        var6.numtouching[ "neutral" ] = 0;
        var6.touchlist[ "neutral" ] = [];
        var6.numtouching[ "none" ] = 0;
        var6.touchlist[ "none" ] = [];
        
        foreach ( var9 in level.teamnamelist )
        {
            var6.teamprogress[ var9 ] = 0;
            var6.numtouching[ var9 ] = 0;
            var6.touchlist[ var9 ] = [];
        }
        
        var6.claimteam = "none";
        var6.claimplayer = undefined;
        var6.lastclaimteam = "none";
        var6.lastclaimtime = 0;
        thread carryobjectproxthink();
    }
    
    thread updatecarryobjectorigin();
    return var6;
}

// Params 1
// Size: 0x12
function ref_12b13( var0 )
{
    self.ref_12355[ self.ref_12355.size ] = var0;
}

// Params 1
// Size: 0x37
function getfullweaponobjfromscriptablename( var0 )
{
    var1 = 1;
    
    foreach ( var3 in self.ref_12355 )
    {
        var1 &= [[ var3 ]]( var0 );
    }
    
    return var1;
}

// Params 0
// Size: 0x170
function deletecarryobject()
{
    if ( self.type != "carryObject" )
    {
        return;
    }
    
    var0 = self;
    var0.type = undefined;
    var0.curorigin = undefined;
    var0.ownerteam = undefined;
    var0.entnum = undefined;
    var0.triggertype = undefined;
    var0.trigger unlink();
    var0.trigger = undefined;
    var0.useweapon = undefined;
    var0.offset3d = undefined;
    
    foreach ( var2 in var0.visuals )
    {
        var2 delete();
    }
    
    var0.visuals = undefined;
    var0.compassicons = undefined;
    var0.objidpingfriendly = undefined;
    var0.objidpingenemy = undefined;
    var0.objpingdelay = undefined;
    releaseid();
    var0.carrier = undefined;
    var0.isresetting = undefined;
    var0.interactteam = undefined;
    var0.allowweapons = undefined;
    var0.keepprogress = undefined;
    var0.carriervisible = undefined;
    var0.visibleteam = undefined;
    var0.carryicon = undefined;
    var0.ondrop = undefined;
    var0.onpickup = undefined;
    var0.onreset = undefined;
    var0.curprogress = undefined;
    var0.usetime = undefined;
    var0.userate = undefined;
    var0.useratemultiplier = 1;
    var0.mustmaintainclaim = undefined;
    var0.cancontestclaim = undefined;
    var0.teamusetimes = undefined;
    var0.teamusetexts = undefined;
    var0.numtouching = undefined;
    var0.touchlist = undefined;
    var0.claimteam = undefined;
    var0.claimplayer = undefined;
    var0.lastclaimteam = undefined;
    var0.lastclaimtime = undefined;
    var0 notify( "death" );
    var0 notify( "deleted" );
}

// Params 0
// Size: 0x152
function carryobjectusethink()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self.trigger waittill( "trigger", var0 );
        
        if ( !isplayer( var0 ) )
        {
            continue;
        }
        
        if ( var0 ismeleeing() )
        {
            continue;
        }
        
        var1 = var0 getcurrentweapon();
        
        if ( scripts\mp\utility\killstreak::isremotekillstreakweapon( var1.basename ) )
        {
            continue;
        }
        
        if ( var0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress() )
        {
            var2 = var0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();
            
            if ( scripts\mp\utility\killstreak::isremotekillstreakweapon( var2.basename ) )
            {
                continue;
            }
        }
        
        if ( istrue( var0.inlaststand ) )
        {
            continue;
        }
        
        if ( self.isresetting )
        {
            continue;
        }
        
        if ( !scripts\mp\utility\player::isreallyalive( var0 ) )
        {
            continue;
        }
        
        if ( !caninteractwith( var0.pers[ "team" ], var0 ) )
        {
            continue;
        }
        
        if ( !var0.canpickupobject )
        {
            continue;
        }
        
        if ( isdefined( var0.nopickuptime ) && var0.nopickuptime > gettime() )
        {
            continue;
        }
        
        if ( !isdefined( var0.initialized_gameobject_vars ) )
        {
            continue;
        }
        
        if ( !unset_relic_bang_and_boom() && var0 scripts\mp\utility\weapon::grenadeinpullback() )
        {
            var3 = var0 getheldoffhand();
            
            if ( !scripts\mp\utility\weapon::isgesture( var3 ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.carrier ) )
        {
            continue;
        }
        
        if ( var0 scripts\mp\utility\player::isusingremote() )
        {
            continue;
        }
        
        if ( !proxtriggerlos( var0 ) )
        {
            continue;
        }
        
        setpickedup( var0 );
    }
}

// Params 0
// Size: 0x34
function carryobjectproxthink()
{
    if ( scripts\mp\utility\game::getgametype() == "ball" || scripts\mp\utility\game::getgametype() == "tdef" || istrue( self.useifproximity ) )
    {
        thread carryobjectusethink();
        return;
    }
    
    thread carryobjectproxthinkdelayed();
}

// Params 0
// Size: 0x1c5
function carryobjectproxthinkdelayed()
{
    level endon( "game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( "move_gameobject" );
    }
    
    thread proxtriggerthink();
    
    for ( ;; )
    {
        if ( self.usetime && self.teamprogress[ self.claimteam ] >= self.usetime )
        {
            self.curprogress = 0;
            self.teamprogress[ self.claimteam ] = self.curprogress;
            var0 = getearliestclaimplayer();
            setclaimteam( "none" );
            self.claimplayer = undefined;
            
            if ( isdefined( self.onenduse ) )
            {
                self [[ self.onenduse ]]( getlastclaimteam(), var0, isdefined( var0 ) );
            }
            
            if ( isdefined( var0 ) )
            {
                setpickedup( var0 );
            }
        }
        
        if ( self.claimteam != "none" )
        {
            if ( self.usetime )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( getlastclaimteam(), self.claimplayer, 0 );
                    }
                }
                else
                {
                    self.curprogress += level.frameduration * self.userate;
                    self.teamprogress[ self.claimteam ] = self.curprogress;
                    var1 = scripts\mp\utility\teams::getenemyteams( self.claimteam );
                    
                    foreach ( var3 in var1 )
                    {
                        if ( self.ownerteam != var3 )
                        {
                            self.teamprogress[ var3 ] = 0;
                        }
                    }
                    
                    if ( isdefined( self.onuseupdate ) )
                    {
                        self [[ self.onuseupdate ]]( getclaimteam(), self.curprogress / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer );
                    }
                }
            }
            else
            {
                if ( scripts\mp\utility\player::isreallyalive( self.claimplayer ) )
                {
                    setpickedup( self.claimplayer );
                }
                
                setclaimteam( "none" );
                self.claimplayer = undefined;
            }
        }
        
        waitframe();
        scripts\mp\hostmigration::waittillhostmigrationdone();
    }
}

// Params 1
// Size: 0x61
function pickupobjectdelay( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self.canpickupobject = 0;
    
    if ( isdefined( var0.ballindex ) )
    {
        var1 = 1024;
    }
    else
    {
        var1 = 4096;
    }
    
    for ( ;; )
    {
        if ( distancesquared( self.origin, var1.trigger.origin ) > var1 )
        {
            break;
        }
        
        wait 0.2;
    }
    
    self.canpickupobject = 1;
}

// Params 3
// Size: 0x108
function setpickedup( var0, var1, var2 )
{
    if ( isai( var0 ) && isdefined( var0.owner ) )
    {
        return;
    }
    
    if ( isdefined( var0.carryobject ) || isdefined( self.carryweapon ) && !var0 scripts\common\utility::is_weapon_allowed() || !getfullweaponobjfromscriptablename( var0 ) )
    {
        if ( isdefined( self.onpickupfailed ) )
        {
            self [[ self.onpickupfailed ]]( var0 );
        }
        
        return;
    }
    
    giveobject( var0, self );
    setcarrier( var0 );
    
    if ( isdefined( self.trigger getlinkedparent() ) )
    {
        for ( var3 = 0; var3 < self.visuals.size ; var3++ )
        {
            self.visuals[ var3 ] unlink();
        }
        
        self.trigger unlink();
    }
    
    for ( var3 = 0; var3 < self.visuals.size ; var3++ )
    {
        self.visuals[ var3 ] hide();
    }
    
    self.trigger.origin += ( 0, 0, 10000 );
    self.trigger scripts\mp\movers::stop_handling_moving_platforms();
    self notify( "pickup_object" );
    
    if ( isdefined( self.onpickup ) )
    {
        self [[ self.onpickup ]]( var0, var1, var2 );
        return;
    }
}

// Params 0
// Size: 0x92
function updatecurorigin()
{
    self endon( "gameobject_deleted" );
    level endon( "game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( "move_gameobject" );
    }
    
    if ( scripts\mp\utility\game::getgametype() == "front" )
    {
        self.carrier endon( "disconnect" );
    }
    
    for ( ;; )
    {
        if ( isdefined( self.carrier ) )
        {
            self.curorigin = self.carrier.origin + ( 0, 0, 75 );
            self.curcarrierorigin = self.carrier.origin;
        }
        else
        {
            self.curorigin = self.trigger.origin;
            self.curcarrierorigin = undefined;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x216
function updatecarryobjectorigin()
{
    self endon( "gameobject_deleted" );
    level endon( "game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( "move_gameobject" );
    }
    
    thread updatecurorigin();
    
    if ( !isdefined( self.objpingdelay ) )
    {
        self.objpingdelay = 4;
    }
    
    for ( ;; )
    {
        if ( self.objpingdelay == 0 )
        {
            break;
        }
        
        if ( isdefined( self.carrier ) )
        {
            foreach ( var1 in level.teamnamelist )
            {
                if ( ( self.visibleteam == "friendly" || self.visibleteam == "any" ) && !isfriendlyteam( var1 ) && self.objidpingfriendly )
                {
                    if ( self.showworldicon )
                    {
                        if ( isdefined( self.pingobjidnum ) )
                        {
                            scripts\mp\objidpoolmanager::update_objective_position( self.pingobjidnum, self.curorigin );
                            
                            if ( istrue( self.pingplayers ) )
                            {
                                objective_setpings( self.pingobjidnum, 1 );
                            }
                            else
                            {
                                objective_setpingsforteam( self.pingobjidnum, var1 );
                            }
                            
                            objective_ping( self.pingobjidnum );
                            continue;
                        }
                        
                        if ( istrue( self.pingplayers ) )
                        {
                            objective_setpings( self.objidnum, 1 );
                        }
                        else
                        {
                            objective_setpingsforteam( self.objidnum, var1 );
                        }
                        
                        objective_ping( self.objidnum );
                    }
                }
            }
            
            foreach ( var1 in level.teamnamelist )
            {
                if ( ( self.visibleteam == "enemy" || self.visibleteam == "any" ) && isfriendlyteam( var1 ) && self.objidpingenemy )
                {
                    if ( self.showworldicon )
                    {
                        if ( isdefined( self.pingobjidnum ) )
                        {
                            scripts\mp\objidpoolmanager::update_objective_position( self.pingobjidnum, self.curorigin );
                            
                            if ( istrue( self.pingplayers ) )
                            {
                                objective_setpings( self.pingobjidnum, 1 );
                            }
                            else
                            {
                                objective_setpingsforteam( self.pingobjidnum, var1 );
                            }
                            
                            objective_ping( self.pingobjidnum );
                            continue;
                        }
                        
                        if ( istrue( self.pingplayers ) )
                        {
                            objective_setpings( self.objidnum, 1 );
                        }
                        else
                        {
                            objective_setpingsforteam( self.objidnum, var1 );
                        }
                        
                        objective_ping( self.objidnum );
                    }
                }
            }
            
            scripts\engine\utility::ref_143c0( self.objpingdelay, "dropped", "reset" );
            continue;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x2f
function hidecarryiconongameend()
{
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    level waittill( "game_ended" );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
        return;
    }
}

// Params 0
// Size: 0x1e
function gameobjects_getcurrentprimaryweapon()
{
    var0 = self getcurrentweapon();
    var1 = self getcurrentprimaryweapon();
    var2 = var1 getaltweapon();
    
    if ( var2 == var0 )
    {
        return var0;
    }
    
    return var1;
}

// Params 1
// Size: 0x45
function watchcarryobjectweaponswitch( var0 )
{
    self endon( "goal_scored" );
    var1 = gettime();
    var2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var0, 1 );
    
    if ( isdefined( var2 ) )
    {
        if ( var2 == 0 )
        {
            if ( var1 == gettime() )
            {
                waittillframeend();
            }
            
            if ( isdefined( self.carryobject ) )
            {
                thread setdropped();
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x11a
function giveobject( var0 )
{
    self.carryobject = var0;
    thread trackcarrier();
    
    if ( isdefined( var0.carryweapon ) )
    {
        var0.carrierweaponcurrent = gameobjects_getcurrentprimaryweapon();
        var0.carrierhascarryweaponinloadout = self hasweapon( var0.carryweapon );
        
        if ( isdefined( var0.carryweaponthink ) )
        {
            self thread [[ var0.carryweaponthink ]]();
        }
        
        self giveweapon( var0.carryweapon );
        thread watchcarryobjectweaponswitch( var0.carryweapon );
        self disableweaponpickup();
        scripts\common\utility::allow_weapon_switch( 0 );
    }
    else if ( !var0.allowweapons )
    {
        scripts\common\utility::allow_weapon( 0 );
        thread manualdropthink();
    }
    
    if ( isdefined( var0.carryicon ) )
    {
        if ( level.splitscreen )
        {
            self.carryicon = scripts\mp\hud_util::createicon( var0.carryicon, 33, 33 );
            self.carryicon scripts\mp\hud_util::setpoint( "BOTTOM LEFT", "BOTTOM LEFT", -50, -78 );
        }
        else
        {
            self.carryicon = scripts\mp\hud_util::createicon( var0.carryicon, 50, 50 );
            self.carryicon scripts\mp\hud_util::setpoint( "BOTTOM LEFT", "BOTTOM LEFT", 175, -30 );
        }
        
        self.carryicon.hidewheninmenu = 1;
        thread hidecarryiconongameend();
        return;
    }
}

// Params 0
// Size: 0x134
function returnhome()
{
    self.isresetting = 1;
    self notify( "reset" );
    
    for ( var0 = 0; var0 < self.visuals.size ; var0++ )
    {
        var1 = self.visuals[ var0 ] getlinkedparent();
        
        if ( isdefined( var1 ) )
        {
            self.visuals[ var0 ] unlink();
        }
        
        if ( isbombmode() && self.visuals[ var0 ].targetname == "sd_bomb" )
        {
            self.visuals[ var0 ].origin = level.bombrespawnpoint;
            self.visuals[ var0 ].angles = level.bombrespawnangles;
        }
        else
        {
            self.visuals[ var0 ].origin = self.visuals[ var0 ].baseorigin;
            self.visuals[ var0 ].angles = self.visuals[ var0 ].baseangles;
        }
        
        self.visuals[ var0 ] show();
    }
    
    var1 = self.trigger getlinkedparent();
    
    if ( isdefined( var1 ) )
    {
        self.trigger unlink();
    }
    
    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.origin;
    
    if ( isdefined( self.onreset ) )
    {
        self [[ self.onreset ]]();
    }
    
    clearcarrier();
    updatecompassicons();
    self.isresetting = 0;
    self notify( "reset_done" );
}

// Params 0
// Size: 0x26, Type: bool
function ishome()
{
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( self.curorigin != self.trigger.baseorigin )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0xa0
function setposition( var0, var1 )
{
    self.isresetting = 1;
    
    for ( var2 = 0; var2 < self.visuals.size ; var2++ )
    {
        self.visuals[ var2 ].origin = var0;
        self.visuals[ var2 ].angles = var1;
        self.visuals[ var2 ] show();
    }
    
    self.trigger.origin = var0;
    
    if ( scripts\mp\utility\game::getgametype() == "ball" || scripts\mp\utility\game::getgametype() == "tdef" )
    {
        self.trigger linkto( self.visuals[ 0 ] );
    }
    
    self.curorigin = self.trigger.origin;
    clearcarrier();
    updatecompassicons();
    self.isresetting = 0;
}

// Params 1
// Size: 0x53
function carryobject_overridemovingplatformdeath( var0 )
{
    for ( var1 = 0; var1 < var0.carryobject.visuals.size ; var1++ )
    {
        var0.carryobject.visuals[ var1 ] unlink();
    }
    
    var0.carryobject.trigger unlink();
    thread setdropped( var0.carryobject );
}

// Params 2
// Size: 0x6b4
function setdropped( var0, var1 )
{
    if ( isdefined( self.setdropped ) )
    {
        if ( [[ self.setdropped ]]() )
        {
            return;
        }
    }
    
    self.isresetting = 1;
    self.resetnow = undefined;
    self notify( "dropped" );
    
    foreach ( var3 in self.visuals )
    {
        var3 notsolid();
    }
    
    if ( isdefined( self.carrier ) )
    {
        var5 = self.carrier.origin;
    }
    else
    {
        var5 = self.curorigin;
    }
    
    if ( istrue( level.botsenabled ) || touchingdroptonavmeshtrigger( var5 ) || level.mapname == "mp_junk" && level.gametype == "ctf" && !touchingarbitraryuptrigger( self.carrier ) )
    {
        var5 = getclosestpointonnavmesh( var5 );
    }
    
    if ( isdefined( level.bombdroploc ) )
    {
        var5 = level.bombdroploc;
        level.bombdroploc = undefined;
    }
    
    if ( isdefined( var2 ) )
    {
        var6 = var2;
    }
    else
    {
        var6 = 20;
    }
    
    var7 = 4000;
    var8 = ( 0, 0, 0 );
    var9 = var6 + ( 0, 0, var6 );
    var10 = var6 - ( 0, 0, var7 );
    var11 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    var12 = [];
    GscBinSkip0( 0x2e, var12.size, self.visuals[ 0 ] );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x19
function ref_143fb( var0 )
{
    self endon( "pickup_object" );
    var0 waittill( "death" );
    thread setdropped();
}

// Params 1
// Size: 0x10
function setcarrier( var0 )
{
    self.carrier = var0;
    thread updatevisibilityaccordingtoradar();
}

// Params 0
// Size: 0x2c
function clearcarrier()
{
    if ( !isdefined( self.carrier ) )
    {
        return;
    }
    
    thread takeobject( self.carrier );
    self.carrier = undefined;
    self.curcarrierorigin = undefined;
    self notify( "carrier_cleared" );
}

// Params 0
// Size: 0x184
function pickuptimeout()
{
    self endon( "pickup_object" );
    self endon( "reset_done" );
    waitframe();
    
    if ( isdefined( self.resetnow ) )
    {
        self.resetnow = undefined;
        returnhome();
        return;
    }
    
    for ( var0 = 0; var0 < level.radtriggers.size ; var0++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.radtriggers[ var0 ] ) )
        {
            continue;
        }
        
        returnhome();
        return;
    }
    
    for ( var0 = 0; var0 < level.minetriggers.size ; var0++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.minetriggers[ var0 ] ) )
        {
            continue;
        }
        
        returnhome();
        return;
    }
    
    for ( var0 = 0; var0 < level.hurttriggers.size ; var0++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.hurttriggers[ var0 ] ) )
        {
            continue;
        }
        
        returnhome();
        return;
    }
    
    if ( istrue( level.ballallowedtriggers.size ) )
    {
        self.allowedintrigger = 0;
        
        foreach ( var2 in level.ballallowedtriggers )
        {
            if ( self.visuals[ 0 ] istouching( var2 ) )
            {
                self.allowedintrigger = 1;
                break;
            }
        }
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( var2 in level.outofboundstriggers )
        {
            if ( istrue( self.allowedintrigger ) )
            {
                break;
            }
            
            if ( !self.visuals[ 0 ] istouching( var2 ) )
            {
                continue;
            }
            
            returnhome();
            return;
        }
    }
    
    if ( isdefined( self.autoresettime ) )
    {
        wait self.autoresettime;
        
        if ( !isdefined( self.carrier ) )
        {
            returnhome();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x102
function takeobject( var0 )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon scripts\mp\hud_util::destroyelem();
    }
    
    if ( isdefined( self ) )
    {
        self.carryobject = undefined;
    }
    
    self notify( "drop_object" );
    
    if ( var0.triggertype == "proximity" )
    {
        thread pickupobjectdelay( var0 );
    }
    
    if ( scripts\mp\utility\player::isreallyalive( self ) && !var0.allowweapons )
    {
        if ( isdefined( var0.carryweapon ) )
        {
            var1 = isdefined( var0.keepcarryweapon ) && var0.keepcarryweapon;
            
            if ( !var0.carrierhascarryweaponinloadout && !var1 )
            {
                if ( isdefined( var0.ballindex ) )
                {
                    wait 0.25;
                }
                
                self notify( "clear_carrier" );
                
                if ( scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( var0.carryweapon ) )
                {
                    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( var0.carryweapon );
                }
                else
                {
                    scripts\cp_mp\utility\inventory_utility::_takeweapon( var0.carryweapon );
                }
                
                thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon( self.lastdroppableweaponobj );
            }
            
            self enableweaponpickup();
            scripts\common\utility::allow_weapon_switch( 1 );
            return;
        }
        
        if ( !var0.allowweapons )
        {
            scripts\common\utility::allow_weapon( 1 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x8b
function trackcarrier()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    
    while ( isdefined( self.carryobject ) && scripts\mp\utility\player::isreallyalive( self ) )
    {
        if ( self isonground() )
        {
            var0 = scripts\engine\trace::_bullet_trace( self.origin + ( 0, 0, 20 ), self.origin - ( 0, 0, 20 ), 0, undefined );
            
            if ( var0[ "fraction" ] < 1 )
            {
                self.carryobject.safeorigin = var0[ "position" ];
            }
        }
        
        wait 0.05;
    }
}

// Params 0
// Size: 0x85
function manualdropthink()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    
    for ( ;; )
    {
        while ( self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            wait 0.05;
        }
        
        while ( !self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            wait 0.05;
        }
        
        if ( isdefined( self.carryobject ) && !self usebuttonpressed() )
        {
            thread setdropped();
        }
    }
}

// Params 0
// Size: 0x1e
function deleteuseobject()
{
    releaseid();
    self.trigger delete();
    self.trigger = undefined;
    self notify( "deleted" );
}

// Params 8
// Size: 0x327
function createuseobject( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    if ( istrue( var1.vampirepoints ) )
    {
        var8 = var1;
    }
    else
    {
        var8 = spawnstruct();
    }
    
    var8.type = "useObject";
    var8.curorigin = var2.origin;
    var8.ownerteam = var1;
    var8.entnum = var2 getentitynumber();
    var8.keyobject = undefined;
    
    if ( issubstr( var2.classname, "use" ) || istrue( var2.usetype ) )
    {
        var8.triggertype = "use";
    }
    else
    {
        var8.triggertype = "proximity";
    }
    
    var2.gameobject = var8;
    var8.trigger = var2;
    
    for ( var9 = 0; var9 < var3.size ; var9++ )
    {
        var3[ var9 ].baseorigin = var3[ var9 ].origin;
        var3[ var9 ].baseangles = var3[ var9 ].angles;
    }
    
    var8.visuals = var3;
    
    if ( !isdefined( var4 ) )
    {
        var4 = ( 0, 0, 0 );
    }
    
    var8.offset3d = var4;
    var8.compassicons = [];
    
    if ( !istrue( var6 ) )
    {
        requestid( var8, 1, 1, var5, var7 );
    }
    
    var8.interactteam = "none";
    var8.visibleteam = "none";
    var8.onuse = undefined;
    var8.oncantuse = undefined;
    var8.usetext = "default";
    var8.usetime = 10000;
    var8.curprogress = 0;
    var8.majoritycapprogress = 0;
    var8.wasmajoritycapprogress = 0;
    var8.stalemate = 0;
    var8.wasstalemate = 0;
    var8.exclusiveuse = 1;
    var8.teamprogress = [];
    var8.teamprogress[ "none" ] = 0;
    
    if ( var8.triggertype == "proximity" )
    {
        var8.teamusetimes = [];
        var8.teamusetexts = [];
        var8.numtouching[ "neutral" ] = 0;
        var8.touchlist[ "neutral" ] = [];
        var8.numtouching[ "none" ] = 0;
        var8.touchlist[ "none" ] = [];
        
        foreach ( var11 in level.teamnamelist )
        {
            var8.teamprogress[ var11 ] = 0;
            var8.numtouching[ var11 ] = 0;
            var8.touchlist[ var11 ] = [];
            var8.assisttouchlist[ var11 ] = [];
        }
        
        var8.userate = 0;
        var8.useratemultiplier = 1;
        var8.claimteam = "none";
        var8.claimplayer = undefined;
        var8.lastclaimteam = "none";
        var8.lastclaimtime = 0;
        var8.mustmaintainclaim = 0;
        var8.cancontestclaim = 0;
        
        if ( isdefined( var8 ) )
        {
            var8.brking_givepoints = var8;
        }
        
        thread useobjectproxthink();
    }
    else
    {
        foreach ( var14 in level.teamnamelist )
        {
            var8.teamprogress[ var14 ] = 0;
        }
        
        var8.userate = 1;
        var8.useratemultiplier = 1;
        thread useobjectusethink();
    }
    
    return var8;
}

// Params 4
// Size: 0x195
function createholduseobject( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.type = "useObject";
    var4.curorigin = var1.origin;
    var4.ownerteam = var0;
    var4.entnum = var1 getentitynumber();
    var4.keyobject = undefined;
    var4.triggertype = "use";
    var1.gameobject = var4;
    var4.trigger = var1;
    
    for ( var5 = 0; var5 < var2.size ; var5++ )
    {
        var2[ var5 ].baseorigin = var2[ var5 ].origin;
        var2[ var5 ].baseangles = var2[ var5 ].angles;
    }
    
    var4.visuals = var2;
    
    if ( !isdefined( var3 ) )
    {
        var3 = ( 0, 0, 0 );
    }
    
    var4.offset3d = var3;
    var4.compassicons = [];
    var4.interactteam = "none";
    var4.visibleteam = "none";
    var4.onuse = undefined;
    var4.oncantuse = undefined;
    var4.usetext = "default";
    var4.usetime = 10000;
    var4.curprogress = 0;
    var4.stalemate = 0;
    var4.wasstalemate = 0;
    var4.exclusiveuse = 1;
    var4.teamprogress = [];
    var4.teamprogress[ "none" ] = 0;
    
    foreach ( var7 in level.teamnamelist )
    {
        var4.teamprogress[ var7 ] = 0;
    }
    
    var4.userate = 1;
    var4.useratemultiplier = 1;
    thread useobjectusethink();
    return var4;
}

// Params 4
// Size: 0x17a
function createdynamicholduseobject( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.type = "useObject";
    var4.curorigin = var1;
    var4.ownerteam = var0;
    var4.keyobject = undefined;
    var4.triggertype = "use";
    
    for ( var5 = 0; var5 < var2.size ; var5++ )
    {
        var2[ var5 ].baseorigin = var2[ var5 ].origin;
        var2[ var5 ].baseangles = var2[ var5 ].angles;
    }
    
    var4.visuals = var2;
    
    if ( !isdefined( var3 ) )
    {
        var3 = ( 0, 0, 0 );
    }
    
    var4.offset3d = var3;
    var4.compassicons = [];
    var4.interactteam = "none";
    var4.visibleteam = "none";
    var4.onuse = undefined;
    var4.oncantuse = undefined;
    var4.usetext = "default";
    var4.usetime = 10000;
    var4.curprogress = 0;
    var4.stalemate = 0;
    var4.wasstalemate = 0;
    var4.exclusiveuse = 1;
    var4.teamprogress = [];
    var4.teamprogress[ "none" ] = 0;
    
    foreach ( var7 in level.teamnamelist )
    {
        var4.teamprogress[ var7 ] = 0;
    }
    
    var4.userate = 1;
    var4.useratemultiplier = 1;
    var2[ 0 ] makeusable();
    thread usedynamicobjectusethink();
    return var4;
}

// Params 1
// Size: 0xa
function setkeyobject( var0 )
{
    self.keyobject = var0;
}

// Params 0
// Size: 0x119
function usedynamicobjectusethink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    
    for ( ;; )
    {
        self waittill( "trigger", var0 );
        
        if ( !scripts\mp\utility\player::isreallyalive( var0 ) )
        {
            continue;
        }
        
        if ( !caninteractwith( var0.pers[ "team" ], var0 ) )
        {
            continue;
        }
        
        if ( !var0 isonground() )
        {
            continue;
        }
        
        if ( var0 scripts\mp\utility\player::isusingremote() )
        {
            continue;
        }
        
        if ( scripts\mp\utility\weapon::iskillstreakweapon( var0 getcurrentweapon() ) )
        {
            continue;
        }
        
        if ( isdefined( self.usecondition ) )
        {
            if ( !self [[ self.usecondition ]]( var0 ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.keyobject ) && ( !isdefined( var0.carryobject ) || var0.carryobject != self.keyobject ) )
        {
            if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( var0 );
            }
            
            continue;
        }
        
        if ( isdefined( self.useweapon ) && var0 hasweapon( self.useweapon ) )
        {
            continue;
        }
        
        if ( !var0 scripts\common\utility::is_weapon_allowed() )
        {
            continue;
        }
        
        if ( !self.exclusiveuse && !isdefined( self.exclusiveclaim ) )
        {
            thread useholdloop( var0 );
            continue;
        }
        
        useholdloop( var0 );
    }
}

// Params 0
// Size: 0x142
function useobjectusethink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    
    for ( ;; )
    {
        self.trigger waittill( "trigger", var0 );
        
        if ( !scripts\mp\utility\player::isreallyalive( var0 ) )
        {
            continue;
        }
        
        if ( !caninteractwith( var0.pers[ "team" ], var0 ) )
        {
            continue;
        }
        
        if ( !var0 isonground() )
        {
            continue;
        }
        
        if ( var0 scripts\mp\utility\player::isusingremote() )
        {
            continue;
        }
        
        if ( scripts\mp\utility\weapon::iskillstreakweapon( var0 getcurrentweapon() ) && !istrue( var0.isjuggernaut ) )
        {
            continue;
        }
        
        if ( isdefined( level.ref_11c89 ) )
        {
            if ( ![[ level.ref_11c89 ]]( var0 ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.usecondition ) )
        {
            if ( !self [[ self.usecondition ]]( var0 ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.keyobject ) && ( !isdefined( var0.carryobject ) || var0.carryobject != self.keyobject ) )
        {
            if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( var0 );
            }
            
            continue;
        }
        
        if ( isdefined( self.useweapon ) && var0 hasweapon( self.useweapon ) )
        {
            continue;
        }
        
        if ( !var0 scripts\common\utility::is_weapon_allowed() )
        {
            continue;
        }
        
        if ( !self.exclusiveuse && !isdefined( self.exclusiveclaim ) )
        {
            thread useholdloop( var0 );
            continue;
        }
        
        useholdloop( var0 );
    }
}

// Params 1
// Size: 0x8c
function useholdloop( var0 )
{
    var1 = 1;
    
    if ( self.usetime > 0 )
    {
        if ( isdefined( self.onbeginuse ) )
        {
            updateuiprogress( var0, self, 0 );
            self [[ self.onbeginuse ]]( var0 );
        }
        
        if ( !isdefined( self.keyobject ) )
        {
            thread cantusehintthink();
        }
        
        var2 = var0.pers[ "team" ];
        var1 = useholdthink( var0 );
        self notify( "finished_use" );
        
        if ( isdefined( self.onenduse ) )
        {
            self [[ self.onenduse ]]( var2, var0, var1 );
        }
    }
    
    if ( var1 )
    {
        if ( isdefined( self.onuse ) )
        {
            self [[ self.onuse ]]( var0 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x48, Type: bool
function checkobjectiskeyobject( var0 )
{
    var1 = self.keyobject;
    
    if ( !isarray( var1 ) )
    {
        var1 = [ var1 ];
    }
    
    foreach ( var3 in var1 )
    {
        if ( var3 istouching( self.trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x48, Type: bool
function checkplayercarrykeyobject( var0 )
{
    var1 = self.keyobject;
    
    if ( !isarray( var1 ) )
    {
        var1 = [ var1 ];
    }
    
    foreach ( var3 in var1 )
    {
        if ( var3 == var0.carryobject )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x70
function cantusehintthink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self endon( "finished_use" );
    jumpiftrue(isdefined( self.trigger )) LOC_00000020;
    return;
}

// Params 0
// Size: 0x11f
function getearliestclaimplayer()
{
    var0 = self.claimteam;
    var1 = self.claimplayer;
    
    if ( isdefined( self.playerzombiedestroyhud ) && istrue( self.getinventoryslotvo ) )
    {
        if ( self.playerzombiedestroyhud[ var0 ].size > 0 )
        {
            var2 = undefined;
            var3 = getarraykeys( self.playerzombiedestroyhud[ var0 ] );
            
            for ( var4 = 0; var4 < var3.size ; var4++ )
            {
                var5 = self.playerzombiedestroyhud[ var0 ][ var3[ var4 ] ];
                
                if ( scripts\mp\utility\player::isreallyalive( var5.player ) && ( !isdefined( var2 ) || var5.starttime < var2 ) )
                {
                    var1 = var5.player;
                    var2 = var5.starttime;
                }
            }
        }
        
        self.getinventoryslotvo = 0;
        level endon( "stop_watching_trigger" );
        return var1;
    }
    
    if ( isdefined( self.touchlist[ var0 ] ) && self.touchlist[ var0 ].size > 0 )
    {
        var2 = undefined;
        var3 = getarraykeys( self.touchlist[ var0 ] );
        
        for ( var4 = 0; var4 < var3.size ; var4++ )
        {
            var5 = self.touchlist[ var0 ][ var3[ var4 ] ];
            
            if ( scripts\mp\utility\player::isreallyalive( var5.player ) && ( !isdefined( var2 ) || var5.starttime < var2 ) )
            {
                var1 = var5.player;
                var2 = var5.starttime;
            }
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x48, Type: bool
function isteamtouching()
{
    var0 = "none";
    
    foreach ( var2 in level.teamnamelist )
    {
        if ( self.numtouching[ var2 ] )
        {
            var0 = var2;
            break;
        }
    }
    
    return var0 != "none";
}

// Params 0
// Size: 0x70d
function useobjectproxthink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    thread proxtriggerthink();
    jumpiftrue(isdefined( self.ignorestomp )) LOC_00000024;
    self.ignorestomp = 0;
    
    for ( ;; )
    {
        if ( self.interactteam == "none" )
        {
            waitframe();
            scripts\mp\hostmigration::waittillhostmigrationdone();
            continue;
        }
        
        self.wasuncontested = 0;
        
        if ( self.cancontestclaim )
        {
            if ( self.stalemate != self.wasstalemate )
            {
                if ( self.stalemate )
                {
                    if ( isdefined( self.oncontested ) )
                    {
                        self [[ self.oncontested ]]();
                    }
                }
                else
                {
                    var0 = "none";
                    
                    foreach ( var2 in level.teamnamelist )
                    {
                        if ( self.numtouching[ var2 ] )
                        {
                            var0 = var2;
                            break;
                        }
                    }
                    
                    if ( var0 == "none" && self.ownerteam != "neutral" )
                    {
                        var0 = self.ownerteam;
                    }
                    
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    foreach ( var0 in level.teamnamelist )
                    {
                        if ( self.touchlist[ var0 ].size )
                        {
                            var5 = self.touchlist[ var0 ];
                            var6 = getarraykeys( var5 );
                            
                            for ( var7 = 0; var7 < var6.size ; var7++ )
                            {
                                var8 = var5[ var6[ var7 ] ].player;
                                var8 setclientomnvar( "ui_objective_state", 0 );
                            }
                            
                            break;
                        }
                    }
                    
                    if ( isdefined( self.onuncontested ) )
                    {
                        self [[ self.onuncontested ]]( var0 );
                    }
                    
                    self.wasuncontested = 1;
                }
                
                self.wasstalemate = self.stalemate;
            }
            
            if ( !self.stalemate && self.majoritycapprogress != self.wasmajoritycapprogress )
            {
                self.wasmajoritycapprogress = self.majoritycapprogress;
            }
        }
        
        if ( !self.stalemate && !self.majoritycapprogress && !self.wasuncontested )
        {
            if ( self.mustmaintainclaim && !istrue( self.isunoccupied ) )
            {
                if ( self.ownerteam != "neutral" && !self.numtouching[ self.ownerteam ] )
                {
                    if ( isdefined( self.onunoccupied ) )
                    {
                        self [[ self.onunoccupied ]]();
                    }
                    
                    self.isunoccupied = 1;
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                }
                else if ( self.ownerteam == "neutral" )
                {
                    if ( !isteamtouching() )
                    {
                        if ( isdefined( self.onunoccupied ) )
                        {
                            self [[ self.onunoccupied ]]();
                        }
                        
                        self.isunoccupied = 1;
                        setclaimteam( "none" );
                        self.claimplayer = undefined;
                    }
                    else if ( isdefined( self.numtouchrequireduse ) )
                    {
                        self [[ self.numtouchrequireduse ]]( self.claimplayer.team );
                    }
                }
            }
            else if ( !istrue( self.isunoccupied ) && isdefined( self.onunoccupied ) )
            {
                var0 = "none";
                
                foreach ( var2 in level.teamnamelist )
                {
                    if ( self.numtouching[ var2 ] )
                    {
                        var0 = var2;
                        break;
                    }
                }
                
                if ( var0 == "none" )
                {
                    self.isunoccupied = 1;
                    self [[ self.onunoccupied ]]();
                }
            }
        }
        
        var12 = 1;
        
        if ( isdefined( self.numtouchrequired ) && self.numtouchrequired > self.numtouching[ self.claimteam ] )
        {
            var12 = 0;
        }
        
        if ( self.claimteam != "none" && var12 )
        {
            if ( !self.usetime )
            {
                if ( !self.stalemate )
                {
                    var13 = getearliestclaimplayer();
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( self.onuse ) )
                    {
                        self [[ self.onuse ]]( var13 );
                    }
                }
            }
            else if ( self.usetime && self.teamprogress[ self.claimteam ] >= self.usetime )
            {
                self.curprogress = 0;
                self.teamprogress[ self.claimteam ] = self.curprogress;
                var13 = getearliestclaimplayer();
                setclaimteam( "none" );
                self.claimplayer = undefined;
                
                if ( isdefined( self.onenduse ) )
                {
                    self [[ self.onenduse ]]( self.claimteam, var13, isdefined( var13 ) );
                }
                
                if ( isdefined( var13 ) && isdefined( self.onuse ) )
                {
                    self [[ self.onuse ]]( var13 );
                }
            }
            else if ( !self.stalemate && self.usetime && ( self.ownerteam != self.claimteam || istrue( self.majoritycapprogress ) ) )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( self.claimteam, self.claimplayer, 0 );
                    }
                }
                else if ( canstompprogresswithstalemate( self.claimteam ) && self.ownerteam == "neutral" )
                {
                    if ( self.lastclaimteam == self.claimteam && istrue( self.majoritycapprogress ) )
                    {
                        if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else
                        {
                            self.lastprogressteam = self.claimteam;
                            applycaptureprogressanduseupdate();
                        }
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam == "neutral" && self.lastclaimteam != self.claimteam )
                {
                    if ( self.lastclaimteam != self.claimteam )
                    {
                        if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else
                        {
                            self.lastprogressteam = self.claimteam;
                            applycaptureprogressanduseupdate();
                        }
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam == self.claimteam )
                {
                    if ( isdefined( self.lastprogressteam ) && self.lastprogressteam == self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                    else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                }
                else if ( self.ownerteam != self.claimteam )
                {
                    self.setblocking = 0;
                    self.setdefending = 0;
                    applycaptureprogressanduseupdate();
                }
                else if ( self.ownerteam == self.claimteam && istrue( self.majoritycapprogress ) )
                {
                    var14 = getnumtouchingexceptteam( self.claimteam );
                    
                    if ( var14 && !istrue( self.setblocking ) )
                    {
                        self.setblocking = 1;
                        self.setdefending = 0;
                        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS" );
                        scripts\mp\objidpoolmanager::update_objective_setenemylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                    }
                    else if ( !var14 && !istrue( self.setdefending ) )
                    {
                        self.setblocking = 0;
                        self.setdefending = 1;
                        setobjectivestatusicons( level.icondefending, level.iconcapture );
                    }
                }
            }
        }
        else if ( canstompprogress( self.ownerteam ) && self.ownerteam != "neutral" )
        {
            stompenemyteamprogress( self.ownerteam );
        }
        
        waitframe();
        scripts\mp\hostmigration::waittillhostmigrationdone();
    }
}

// Params 1
// Size: 0x2d, Type: bool
function canstompprogress( var0 )
{
    return !istrue( self.ignorestomp ) && self.touchlist[ var0 ].size > 0 && !istrue( self.stalemate ) && self.curprogress > 0;
}

// Params 1
// Size: 0x2b, Type: bool
function canstompprogresswithstalemate( var0 )
{
    return !istrue( self.ignorestomp ) && self.touchlist[ var0 ].size > 0 && self.majoritycapprogress && self.curprogress > 0;
}

// Params 0
// Size: 0x87
function applycaptureprogressanduseupdate()
{
    if ( isdefined( self.ref_128b9 ) )
    {
        var0 = self [[ self.ref_128b9 ]]( 1 );
        
        if ( !var0 )
        {
            return;
        }
    }
    
    applycaptureprogress( self.claimteam, level.frameduration * self.userate );
    
    if ( isdefined( self.onuseupdate ) )
    {
        self [[ self.onuseupdate ]]( self.claimteam, self.teamprogress[ self.claimteam ] / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer );
    }
    
    if ( isdefined( self.ref_12079 ) )
    {
        self [[ self.ref_12079 ]]( 1 );
        return;
    }
}

// Params 1
// Size: 0x154
function stompenemyteamprogress( var0 )
{
    if ( isdefined( self.ref_138b2 ) )
    {
        self [[ self.ref_138b2 ]]( var0 );
    }
    
    var1 = level.frameduration * self.userate;
    var2 = scripts\mp\utility\teams::getenemyteams( var0 );
    
    foreach ( var4 in var2 )
    {
        var5 = self.teamprogress[ var4 ];
        
        if ( var5 > 0 )
        {
            if ( var5 < var1 )
            {
                self.teamprogress[ var4 ] = 0;
                self.curprogress = self.teamprogress[ var4 ];
                scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
                scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, 0 );
                var1 -= var5;
                continue;
            }
            
            self.isunoccupied = 0;
            self.teamprogress[ var4 ] -= var1;
            var1 = 0;
            self.curprogress = self.teamprogress[ var4 ];
            scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var4 );
            scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS" );
        }
    }
    
    if ( self.curprogress <= 0 )
    {
        foreach ( var8 in self.touchlist[ self.ownerteam ] )
        {
            if ( isdefined( self.stompprogressreward ) )
            {
                [[ self.stompprogressreward ]]( var8.player );
            }
        }
        
        self.lastprogressteam = undefined;
        return;
    }
}

// Params 1
// Size: 0x21a
function useobjectdecay( var0 )
{
    if ( getcapturebehavior() != "normal" && scripts\mp\utility\game::getgametype() != "arm" )
    {
        return;
    }
    
    level endon( "game_ended" );
    self endon( "deleted" );
    self notify( "useObjectDecay" );
    self endon( "useObjectDecay" );
    var1 = 0;
    
    for ( ;; )
    {
        waitframe();
        var2 = self.objidnum;
        
        if ( self.stalemate )
        {
            var1 = 0;
        }
        
        if ( self.claimteam == "none" || istrue( self.playerkilled_washitbyvehicle ) )
        {
            if ( self.usetime )
            {
                if ( !self.stalemate )
                {
                    if ( istrue( self.decaygraceperiod ) && var1 < self.decaygraceperiod )
                    {
                        var1 += level.framedurationseconds;
                        continue;
                    }
                    
                    if ( isdefined( self.permcapturethresholds ) )
                    {
                        if ( !isdefined( self.decaythreshold ) )
                        {
                            self.decaythreshold = 0;
                        }
                        
                        var3 = self.curprogress / self.usetime;
                        
                        foreach ( var5 in self.permcapturethresholds )
                        {
                            if ( var3 >= var5 && var5 > self.decaythreshold )
                            {
                                self.decaythreshold = var5;
                            }
                        }
                        
                        if ( !isdefined( self.decayrate ) )
                        {
                            self.decayrate = self.usetime * 0.025 * level.framedurationseconds;
                        }
                        
                        if ( var3 > self.decaythreshold )
                        {
                            self.curprogress -= self.decayrate;
                        }
                    }
                    else
                    {
                        var7 = 1;
                        
                        if ( isdefined( self.forest_barrels ) )
                        {
                            var7 = [[ self.forest_barrels ]]();
                        }
                        
                        self.curprogress -= 0.1 * var7 * level.frameduration;
                        
                        if ( isdefined( self.ref_12079 ) )
                        {
                            self [[ self.ref_12079 ]]( 0 );
                        }
                    }
                }
                
                self.teamprogress[ var0 ] = self.curprogress;
            }
            
            if ( self.teamprogress[ var0 ] <= 0 )
            {
                self.curprogress = 0;
                self.teamprogress[ var0 ] = self.curprogress;
                scripts\mp\objidpoolmanager::objective_show_progress( var2, 0 );
                break;
            }
            
            scripts\mp\hostmigration::waittillhostmigrationdone();
            
            if ( isdefined( self.objidnum ) )
            {
                if ( isdefined( self.overrideprogressteam ) )
                {
                    var3 = self.teamprogress[ self.overrideprogressteam ] / self.usetime;
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, var3 );
                }
                else
                {
                    var3 = self.teamprogress[ self.lastclaimteam ] / self.usetime;
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, var3 );
                }
            }
        }
    }
}

// Params 1
// Size: 0xdb, Type: bool
function canclaim( var0 )
{
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( self.cancontestclaim )
    {
        var1 = getnumtouchingforteam( var0.pers[ "team" ] );
        var2 = getnumtouchingexceptteam( var0.pers[ "team" ] );
        
        if ( var1 && !var2 || var1 && var2 && var1 != var2 && !istrue( self.ref_133a5 ) )
        {
            self.majoritycapprogress = 1;
            self.wasmajoritycapprogress = 0;
            return true;
        }
        
        if ( var1 && var2 && ( var1 == var2 || istrue( self.ref_133a5 ) ) )
        {
            self.stalemate = 1;
            self.majoritycapprogress = 0;
            self.wasmajoritycapprogress = 1;
            return false;
        }
    }
    
    if ( !isdefined( self.keyobject ) )
    {
        return true;
    }
    
    if ( isdefined( self.nocarryobject ) )
    {
        if ( checkobjectiskeyobject( var0 ) )
        {
            return true;
        }
    }
    
    if ( isdefined( var0.carryobject ) )
    {
        if ( checkplayercarrykeyobject( var0 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x3db
function proxtriggerthink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    var0 = self.entnum;
    
    for ( ;; )
    {
        self.trigger waittill( "trigger", var1 );
        
        if ( istrue( self.brking_givepoints ) )
        {
            if ( isdefined( var1.classname ) && var1.classname == "script_vehicle" )
            {
                if ( !istrue( var1.isempty ) && isdefined( var1.occupants[ "driver" ] ) )
                {
                    var1 = var1.occupants[ "driver" ];
                }
            }
        }
        
        if ( !scripts\mp\utility\player::isreallyalive( var1 ) )
        {
            continue;
        }
        
        if ( istrue( self.trigger.trigger_off ) )
        {
            continue;
        }
        
        if ( isagent( var1 ) )
        {
            continue;
        }
        
        if ( !scripts\mp\utility\entity::isgameparticipant( var1 ) )
        {
            continue;
        }
        
        if ( isdefined( self.carrier ) )
        {
            continue;
        }
        
        if ( istrue( self.tv_station_gas_rise ) && ( var1 scripts\mp\utility\player::isusingremote() || isdefined( var1.spawningafterremotedeath ) ) )
        {
            continue;
        }
        
        if ( istrue( var1.inlaststand ) && !istrue( self.trigger.brkillstreakbeginusefunc ) )
        {
            continue;
        }
        
        if ( isdefined( var1.classname ) && var1.classname == "script_vehicle" )
        {
            continue;
        }
        
        if ( !isdefined( var1.initialized_gameobject_vars ) )
        {
            continue;
        }
        
        if ( isdefined( self.usecondition ) )
        {
            if ( !self [[ self.usecondition ]]( var1 ) )
            {
                continue;
            }
        }
        
        var2 = getrelativeteam( var1.pers[ "team" ] );
        
        if ( isdefined( self.teamusetimes[ var2 ] ) && self.teamusetimes[ var2 ] < 0 )
        {
            continue;
        }
        
        if ( scripts\mp\utility\player::isreallyalive( var1 ) && !isdefined( var1.touchtriggers[ var0 ] ) )
        {
            var3 = var1.pers[ "team" ];
            self.numtouching[ var3 ]++;
            var4 = var1.guid;
            var5 = spawnstruct();
            var5.player = var1;
            var5.starttime = gettime();
            self.touchlist[ var3 ][ var4 ] = var5;
            
            if ( isdefined( self.assisttouchlist ) )
            {
                if ( !isdefined( self.assisttouchlist[ var3 ][ var4 ] ) )
                {
                    self.assisttouchlist[ var3 ][ var4 ] = var5;
                }
            }
        }
        
        if ( self.cancontestclaim )
        {
            var6 = getnumtouchingforteam( var1.pers[ "team" ] );
            var7 = getnumtouchingexceptteam( var1.pers[ "team" ] );
            
            if ( var6 && !var7 || var6 && var7 && var6 != var7 )
            {
                self.majoritycapprogress = 1;
                self.isunoccupied = 0;
            }
        }
        
        if ( self.claimteam == "none" || !istrue( self.allowcapture ) || istrue( self.majoritycapprogress ) )
        {
            if ( caninteractwith( var1.pers[ "team" ], var1 ) )
            {
                if ( canclaim( var1 ) )
                {
                    if ( !proxtriggerlos( var1 ) )
                    {
                        continue;
                    }
                    
                    if ( istrue( self.majoritycapprogress ) )
                    {
                        if ( isdefined( self.mostnumtouching ) && isdefined( self.mostnumtouchingteam ) )
                        {
                            setclaimteam( self.mostnumtouchingteam );
                            var8 = getearliestclaimplayer();
                            self.claimplayer = var8;
                        }
                    }
                    else
                    {
                        setclaimteam( var1.pers[ "team" ] );
                        self.claimplayer = var1;
                    }
                    
                    if ( isdefined( self.teamusetimes[ var2 ] ) )
                    {
                        self.usetime = self.teamusetimes[ var2 ];
                    }
                    
                    self.allowcapture = 1;
                    
                    if ( isdefined( self.numtouchrequired ) && self.numtouchrequired > self.numtouching[ self.claimteam ] )
                    {
                        self.allowcapture = 0;
                    }
                    
                    if ( self.usetime && isdefined( self.onbeginuse ) && self.allowcapture && self.ownerteam != self.claimteam )
                    {
                        self.isunoccupied = 0;
                        
                        if ( isdefined( self.didstatusnotify ) && !self.didstatusnotify )
                        {
                            self [[ self.onbeginuse ]]( self.claimplayer );
                        }
                        else if ( !isdefined( self.didstatusnotify ) )
                        {
                            self [[ self.onbeginuse ]]( self.claimplayer );
                        }
                    }
                }
                else if ( isdefined( self.oncantuse ) )
                {
                    self [[ self.oncantuse ]]( var1 );
                }
            }
        }
        
        if ( scripts\mp\utility\player::isreallyalive( var1 ) && !isdefined( var1.touchtriggers[ var0 ] ) )
        {
            thread triggertouchthink( var1 );
        }
    }
}

// Params 1
// Size: 0x169, Type: bool
function proxtriggerlos( var0 )
{
    if ( !isdefined( self.requireslos ) )
    {
        return true;
    }
    
    var1 = var0 geteye();
    var2 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 0 );
    var3 = [];
    
    if ( scripts\mp\utility\game::getgametype() == "tdef" || istrue( level.devball ) )
    {
        var4 = self.trigger.origin + ( 0, 0, 16 );
        var5 = 0;
        var3 = self.visuals[ 0 ];
    }
    else if ( scripts\mp\utility\game::getgametype() == "ball" || istrue( level.debughostagegame ) )
    {
        var4 = self.trigger.origin + ( 0, 0, 8 );
        var5 = 0;
        var5 = self.visuals[ 0 ];
    }
    else
    {
        var4 = self.trigger.origin + ( 0, 0, 32 );
        var5 = 1;
        var5 = self.visuals;
    }
    
    var5 = self.carrier;
    var6 = scripts\engine\trace::ray_trace( var5, var4, var5, var4, 0 );
    
    if ( var6[ "fraction" ] != 1 && var5 )
    {
        var4 = self.trigger.origin + ( 0, 0, 16 );
        var6 = scripts\engine\trace::ray_trace( var5, var4, var5, var4, 0 );
    }
    
    if ( var6[ "fraction" ] != 1 )
    {
        var4 = self.trigger.origin + ( 0, 0, 0 );
        var6 = scripts\engine\trace::ray_trace( var5, var4, var5, var4, 0 );
    }
    
    return var6[ "fraction" ] == 1;
}

// Params 1
// Size: 0x74
function setclaimteam( var0 )
{
    if ( getcapturebehavior() == "normal" )
    {
        if ( !isdefined( self.claimgracetime ) )
        {
            self.claimgracetime = 1000;
        }
        
        if ( !istrue( self.ignorestomp ) && scripts\mp\utility\teams::isgameplayteam( var0 ) )
        {
            if ( self.lastclaimteam != "none" )
            {
                if ( !isdefined( self.lastprogressteam ) )
                {
                    self.lastprogressteam = self.lastclaimteam;
                }
            }
        }
    }
    
    self.lastclaimteam = self.claimteam;
    self.lastclaimtime = gettime();
    self.claimteam = var0;
    updateuserate();
}

// Params 0
// Size: 0x8
function getclaimteam()
{
    return self.claimteam;
}

// Params 0
// Size: 0x8
function getlastclaimteam()
{
    return self.lastclaimteam;
}

// Params 1
// Size: 0x353
function triggertouchthink( var0 )
{
    var1 = self.pers[ "team" ];
    
    if ( istrue( var0.pinobj ) )
    {
        scripts\mp\objidpoolmanager::objective_pin_player( var0.objidnum, self );
        self.pinnedobjid = var0.objidnum;
        
        if ( isdefined( var0.onpinnedstate ) )
        {
            var0 [[ var0.onpinnedstate ]]();
        }
    }
    
    if ( !isdefined( self.touchinggameobjects ) )
    {
        self.touchinggameobjects = [];
    }
    
    var2 = var0.trigger getentitynumber();
    self.touchinggameobjects[ var2 ] = var0;
    
    if ( !isdefined( var0.nousebar ) )
    {
        var0.nousebar = 0;
    }
    
    self.touchtriggers[ var0.entnum ] = var0.trigger;
    updateuserate( var0 );
    
    while ( scripts\mp\utility\player::isreallyalive( self ) && isdefined( var0.trigger ) && self istouching( var0.trigger ) && !level.gameended )
    {
        if ( isdefined( var0.checkinteractteam ) && var0.team != var1 )
        {
            break;
        }
        
        if ( istrue( self.inlaststand ) && !istrue( var0.trigger.brkillstreakbeginusefunc ) )
        {
            break;
        }
        
        if ( isdefined( var0.interactsquads ) && !isdefined( var0.interactsquads[ self.team ] ) || isdefined( var0.interactsquads ) && !scripts\engine\utility::array_contains( var0.interactsquads[ self.team ], self.squadindex ) )
        {
            break;
        }
        
        if ( istrue( var0.trigger.trigger_off ) )
        {
            break;
        }
        
        if ( istrue( var0.getrandompointincirclewithindistance ) && isdefined( var0.usecondition ) && !var0 [[ var0.usecondition ]]( self ) )
        {
            break;
        }
        
        if ( !scripts\mp\utility\player::isusingremote() && istrue( self.remoteunpinned ) )
        {
            scripts\mp\objidpoolmanager::objective_pin_player( var0.objidnum, self );
            self.remoteunpinned = undefined;
        }
        
        if ( isplayer( self ) && var0.usetime > 50 )
        {
            updateuiprogress( var0, 1 );
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        if ( var0.usetime > 50 )
        {
            if ( isplayer( self ) )
            {
                updateuiprogress( var0, 0 );
            }
            
            self.touchtriggers[ var0.entnum ] = undefined;
        }
        else
        {
            self.touchtriggers[ var0.entnum ] = undefined;
        }
        
        self.touchinggameobjects[ var2 ] = undefined;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    var0.oldtouchlist = var0.touchlist;
    
    if ( isdefined( var0.touchlist[ var1 ] ) )
    {
        if ( isdefined( self ) )
        {
            var0.touchlist[ var1 ][ self.guid ] = undefined;
        }
        else
        {
            var3 = [];
            
            foreach ( var6, var5 in var0.touchlist[ var1 ] )
            {
                if ( !isdefined( var5.player ) )
                {
                    var3 = var6;
                }
            }
            
            foreach ( var6 in var3 )
            {
                var0.touchlist[ var1 ][ var6 ] = undefined;
            }
        }
    }
    
    if ( isdefined( self ) && isdefined( var0.objidnum ) )
    {
        scripts\mp\objidpoolmanager::objective_unpin_player( var0.objidnum, self, var0.showoncompass );
        self.pinnedobjid = undefined;
        
        if ( var0.lastclaimteam == "none" )
        {
            if ( isdefined( var0.capturebehavior ) && var0.capturebehavior == "persistent" )
            {
                scripts\mp\objidpoolmanager::objective_show_progress( var0.objidnum, 0 );
            }
        }
    }
    
    var0.numtouching[ var1 ]--;
    updateuserate( var0 );
    
    if ( isdefined( var0.onunpinnedstate ) )
    {
        var0 [[ var0.onunpinnedstate ]]();
        return;
    }
}

// Params 1
// Size: 0x3f
function migrationcapturereset( var0 )
{
    var0.migrationcapturereset = 1;
    level waittill( "host_migration_begin" );
    
    if ( !isdefined( var0 ) || !isdefined( self ) )
    {
        return;
    }
    
    var0 setclientomnvar( "ui_securing", 0 );
    var0 setclientomnvar( "ui_securing_progress", 0 );
    self.migrationcapturereset = undefined;
}

// Params 1
// Size: 0xc
function getnumtouchingforteam( var0 )
{
    return self.numtouching[ var0 ];
}

// Params 1
// Size: 0x8b
function getnumtouchingexceptteam( var0 )
{
    var1 = 0;
    var2 = 0;
    self.mostnumtouching = 0;
    self.mostnumtouchingteam = "none";
    
    foreach ( var4 in level.teamnamelist )
    {
        if ( level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent( var4 ) )
        {
            continue;
        }
        
        var2 += self.numtouching[ var4 ];
        
        if ( var2 > 0 && var2 > self.mostnumtouching )
        {
            self.mostnumtouching = var2;
            self.mostnumtouchingteam = var4;
            var2 = 0;
        }
        
        if ( var4 != var0 )
        {
            var1 += self.numtouching[ var4 ];
        }
    }
    
    return var1;
}

// Params 3
// Size: 0xc7e
function updateuiprogress( var0, var1, var2 )
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        if ( isdefined( var0.interactteam ) && var0.interactteam == "none" )
        {
            self setclientomnvar( "ui_objective_state", 0 );
            return;
        }
        
        if ( !isdefined( var2 ) )
        {
            var2 = var0;
        }
        
        var3 = undefined;
        
        if ( isdefined( var0.objidnum ) )
        {
            var3 = var0.objidnum;
        }
        
        var4 = 0;
        
        if ( isdefined( var0.teamprogress ) && isdefined( var0.claimteam ) )
        {
            if ( var0.teamprogress[ var0.claimteam ] > var2.usetime )
            {
                var0.teamprogress[ var0.claimteam ] = var2.usetime;
            }
            
            var4 = var0.teamprogress[ var0.claimteam ] / var2.usetime;
        }
        else
        {
            if ( var2.curprogress > var2.usetime )
            {
                var2.curprogress = var2.usetime;
            }
            
            var4 = var2.curprogress / var2.usetime;
            
            if ( var2.usetime <= 1000 )
            {
                var4 = min( var4 + 0.05, 1 );
            }
            else
            {
                var4 = min( var4 + 0.01, 1 );
            }
        }
        
        if ( ( scripts\mp\utility\game::getgametype() == "ctf" || scripts\mp\utility\game::getgametype() == "tdef" || scripts\mp\utility\game::getgametype() == "blitz" ) && !isdefined( var0.id ) )
        {
            if ( var1 && istrue( var0.stalemate ) )
            {
                if ( !isdefined( self.ui_ctf_stalemate ) )
                {
                    if ( !isdefined( self.ui_ctf_securing ) )
                    {
                        self.ui_ctf_securing = 1;
                    }
                    
                    self setclientomnvar( "ui_objective_state", -1 );
                    self.ui_ctf_stalemate = 1;
                }
                
                var4 = 0.01;
            }
            else if ( var1 && isdefined( self.ui_ctf_securing ) && isdefined( var0.stalemate ) && !var0.stalemate && var0.ownerteam != self.team )
            {
                self setclientomnvar( "ui_objective_state", 1 );
                self.ui_ctf_securing = 1;
                self.ui_ctf_stalemate = undefined;
            }
            else if ( var1 && isdefined( self.ui_ctf_securing ) && isdefined( var0.stalemate ) && !var0.stalemate && var0.ownerteam == self.team )
            {
                self setclientomnvar( "ui_objective_state", 2 );
                self.ui_ctf_securing = 1;
                self.ui_ctf_stalemate = undefined;
            }
            else
            {
                if ( !var1 && isdefined( self.ui_ctf_stalemate ) )
                {
                    self setclientomnvar( "ui_objective_state", 0 );
                    self.ui_ctf_securing = undefined;
                }
                
                if ( var1 && !isdefined( self.ui_ctf_stalemate ) && var0.ownerteam == self.team )
                {
                    self setclientomnvar( "ui_objective_state", 0 );
                    self.ui_ctf_securing = undefined;
                }
                
                if ( var1 && !isdefined( self.ui_ctf_securing ) )
                {
                    if ( var0.ownerteam != self.team )
                    {
                        self setclientomnvar( "ui_objective_state", 1 );
                        self.ui_ctf_securing = 1;
                    }
                    else if ( var0.interactteam == "any" )
                    {
                        self setclientomnvar( "ui_objective_state", 2 );
                        self.ui_ctf_securing = 1;
                    }
                }
                
                self.ui_ctf_stalemate = undefined;
            }
            
            if ( !var1 )
            {
                var4 = 0.01;
                self setclientomnvar( "ui_objective_state", 0 );
                self.ui_ctf_securing = undefined;
            }
            
            if ( var4 != 0 )
            {
                scripts\mp\objidpoolmanager::objective_set_progress_team( var3, self.team );
                scripts\mp\objidpoolmanager::objective_show_progress( var3, 1 );
                scripts\mp\objidpoolmanager::objective_set_progress( var3, var4 );
            }
        }
        
        if ( hasdomflags() && isdefined( var0.id ) && ( var0.id == "domFlag" || var0.id == "hardpoint" || var0.id == "bomb_site" || var0.id == "rugby_jugg" ) )
        {
            if ( var1 && isdefined( var0.stalemate ) && var0.stalemate && !istrue( var0.majoritycapprogress ) )
            {
                if ( !isdefined( self.ui_dom_stalemate ) )
                {
                    if ( !isdefined( self.ui_dom_securing ) )
                    {
                        self.ui_dom_securing = 1;
                    }
                    
                    self.ui_dom_stalemate = 1;
                    self setclientomnvar( "ui_objective_state", 3 );
                }
            }
            else if ( var1 && isdefined( self.ui_dom_securing ) && isdefined( var0.stalemate ) && !var0.stalemate && !istrue( var0.majoritycapprogress ) && var0.ownerteam != self.team )
            {
                self.ui_dom_securing = 1;
                self.ui_dom_stalemate = undefined;
                
                if ( scripts\mp\utility\game::getgametype() == "hq" )
                {
                    if ( var0.ownerteam == "neutral" )
                    {
                        self setclientomnvar( "ui_objective_state", 1 );
                    }
                    else
                    {
                        self setclientomnvar( "ui_objective_state", 2 );
                    }
                }
                else if ( istrue( var0.neutralizing ) && var0.ownerteam != self.team && var0.ownerteam != "neutral" )
                {
                    self setclientomnvar( "ui_objective_state", var0 scripts\mp\gametypes\obj_dom::relic_nuketimer_timerloop() );
                }
                else
                {
                    self setclientomnvar( "ui_objective_state", 1 );
                }
            }
            else
            {
                if ( !var1 && isdefined( self.ui_dom_stalemate ) )
                {
                    if ( isdefined( var0.overrideprogressteam ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( var3, var0.overrideprogressteam );
                    }
                    else if ( isdefined( var0.lastprogressteam ) && var0.lastprogressteam != var0.claimteam )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( var3, var0.lastprogressteam );
                    }
                    else if ( var0.claimteam != "none" )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( var3, var0.claimteam );
                    }
                    
                    self.ui_dom_securing = undefined;
                    self setclientomnvar( "ui_objective_state", 0 );
                }
                else if ( var1 && istrue( var0.majoritycapprogress ) && isdefined( var0.lastprogressteam ) && var0.lastprogressteam == var0.claimteam )
                {
                    if ( isdefined( var0.overrideprogressteam ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( var3, var0.overrideprogressteam );
                    }
                    else if ( var0.ownerteam != "neutral" && var0.claimteam == var0.ownerteam )
                    {
                        self setclientomnvar( "ui_objective_state", 0 );
                    }
                    else if ( var0.claimteam != "none" )
                    {
                        if ( istrue( level.spawn_lot_paratroopers ) )
                        {
                        }
                        else if ( scripts\mp\utility\game::getgametype() == "hq" )
                        {
                            if ( var0.ownerteam == "neutral" )
                            {
                                self setclientomnvar( "ui_objective_state", 1 );
                            }
                            else
                            {
                                self setclientomnvar( "ui_objective_state", 2 );
                            }
                        }
                        else if ( istrue( var0.neutralizing ) && var0.ownerteam != self.team && var0.ownerteam != "neutral" )
                        {
                            self setclientomnvar( "ui_objective_state", var0 scripts\mp\gametypes\obj_dom::relic_nuketimer_timerloop() );
                        }
                        else
                        {
                            self setclientomnvar( "ui_objective_state", 1 );
                        }
                        
                        scripts\mp\objidpoolmanager::objective_set_progress_team( var3, var0.claimteam );
                    }
                }
                else if ( scripts\mp\utility\game::getgametype() == "rugby" )
                {
                    if ( !isdefined( var0.claimteam ) || var0.claimteam == "none" )
                    {
                        var0.numtouching[ self.team ] = 1;
                        
                        if ( !isdefined( var0.lastclaimteam ) )
                        {
                            var0.lastclaimteam = "none";
                        }
                        
                        setclaimteam( var0, self.pers[ "team" ] );
                        setownerteam( var0, self.pers[ "team" ] );
                    }
                    
                    if ( var1 )
                    {
                        if ( var0.claimteam != "none" )
                        {
                            self setclientomnvar( "ui_objective_state", 1 );
                            scripts\mp\objidpoolmanager::objective_set_progress_team( var3, var0.claimteam );
                            scripts\mp\objidpoolmanager::objective_show_progress( var3, 1 );
                            scripts\mp\objidpoolmanager::objective_set_progress( var0.objidnum, var4 );
                        }
                    }
                    else
                    {
                        var0.claimteam = "none";
                    }
                }
                
                if ( var1 && !isdefined( self.ui_dom_stalemate ) && var0.ownerteam == self.team )
                {
                    self.ui_dom_securing = undefined;
                    self setclientomnvar( "ui_objective_state", 0 );
                }
                
                if ( var1 && !isdefined( self.ui_dom_securing ) && var0.ownerteam != self.team )
                {
                    self.ui_dom_securing = 1;
                }
                
                self.ui_dom_stalemate = undefined;
            }
            
            if ( scripts\mp\utility\game::getgametype() != "rush" )
            {
                if ( !var1 || !caninteractwith( var0, self.team, self ) && ( !isdefined( var0.stalemate ) || isdefined( var0.stalemate ) && !var0.stalemate ) )
                {
                    if ( var2.curprogress == 0 )
                    {
                        scripts\mp\objidpoolmanager::objective_show_progress( var3, 0 );
                    }
                    
                    self.ui_dom_securing = undefined;
                    self setclientomnvar( "ui_objective_state", 0 );
                }
            }
            
            if ( var4 != 0 )
            {
                if ( showspecificteamprogress( var0 ) )
                {
                    scripts\mp\objidpoolmanager::objective_show_team_progress( var3, var0.claimteam );
                }
                else
                {
                    scripts\mp\objidpoolmanager::objective_show_progress( var3, 1 );
                }
                
                if ( level.teambased && isdefined( var0.teamprogress ) && isdefined( var0.claimteam ) && var1 )
                {
                    if ( !var0.stalemate )
                    {
                        if ( isdefined( var0.overrideprogressteam ) )
                        {
                            scripts\mp\objidpoolmanager::objective_set_progress_team( var0.objidnum, var0.overrideprogressteam );
                            scripts\mp\objidpoolmanager::objective_set_progress( var0.objidnum, var0.teamprogress[ var0.overrideprogressteam ] / var2.usetime );
                        }
                        else
                        {
                            scripts\mp\objidpoolmanager::objective_set_progress_team( var0.objidnum, var0.claimteam );
                            scripts\mp\objidpoolmanager::objective_set_progress( var0.objidnum, var4 );
                        }
                        
                        if ( self.team == var0.claimteam )
                        {
                            if ( istrue( level.spawn_lot_paratroopers ) )
                            {
                                return;
                            }
                            
                            if ( scripts\mp\utility\game::getgametype() == "hq" )
                            {
                                if ( var0.ownerteam == "neutral" )
                                {
                                    self setclientomnvar( "ui_objective_state", 1 );
                                    return;
                                }
                                
                                self setclientomnvar( "ui_objective_state", 2 );
                                return;
                            }
                            
                            if ( istrue( var0.neutralizing ) && var0.ownerteam != self.team && var0.ownerteam != "neutral" )
                            {
                                self setclientomnvar( "ui_objective_state", var0 scripts\mp\gametypes\obj_dom::relic_nuketimer_timerloop() );
                                return;
                            }
                            
                            self setclientomnvar( "ui_objective_state", 1 );
                            return;
                        }
                        
                        self setclientomnvar( "ui_objective_state", 5 );
                        return;
                    }
                    
                    if ( var0.stalemate && istrue( var0.majoritycapprogress ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( var0.objidnum, var0.claimteam );
                        scripts\mp\objidpoolmanager::objective_set_progress( var0.objidnum, var4 );
                        
                        if ( self.team == var0.claimteam )
                        {
                            if ( scripts\mp\utility\game::getgametype() == "hq" )
                            {
                                if ( var0.ownerteam == "neutral" )
                                {
                                    self setclientomnvar( "ui_objective_state", 1 );
                                    return;
                                }
                                
                                self setclientomnvar( "ui_objective_state", 2 );
                                return;
                            }
                            
                            if ( istrue( var0.neutralizing ) && var0.ownerteam != self.team && var0.ownerteam != "neutral" )
                            {
                                self setclientomnvar( "ui_objective_state", 6 );
                                return;
                            }
                            
                            self setclientomnvar( "ui_objective_state", 1 );
                            return;
                        }
                        
                        self setclientomnvar( "ui_objective_state", 5 );
                        return;
                    }
                    
                    scripts\mp\objidpoolmanager::objective_set_progress_team( var3, undefined );
                    return;
                }
                
                if ( !level.teambased )
                {
                    scripts\mp\objidpoolmanager::objective_set_progress_client( var3, self );
                    return;
                }
                
                return;
            }
            
            return;
        }
        
        if ( isbombmode() && isdefined( var0.id ) && ( var0.id == "bomb_zone" || var0.id == "defuse_object" ) )
        {
            if ( isdefined( self ) )
            {
                if ( var1 && isdefined( self ) )
                {
                    if ( !isdefined( self.ui_bomb_planting_defusing ) )
                    {
                        var5 = 0;
                        
                        if ( var0.id == "bomb_zone" )
                        {
                            var5 = 1;
                        }
                        else if ( var0.id == "defuse_object" )
                        {
                            var5 = 2;
                        }
                        
                        self.ui_bomb_planting_defusing = 1;
                    }
                }
                else
                {
                    self.ui_bomb_planting_defusing = undefined;
                    
                    if ( !isdefined( var0.resetprogress ) || istrue( var0.resetprogress ) )
                    {
                        var4 = 0.01;
                    }
                }
                
                if ( var4 != 0 )
                {
                    if ( !isdefined( var0.showprogressforteam ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( var3, self.team );
                        scripts\mp\objidpoolmanager::objective_show_team_progress( var3, self.team );
                        var0.showprogressforteam = self.team;
                    }
                    
                    scripts\mp\objidpoolmanager::objective_set_progress( var3, var4 );
                    setomnvar( "ui_bomb_progress", var4 );
                    return;
                }
                
                return;
            }
            
            return;
        }
        
        if ( isdefined( var0.id ) )
        {
            var5 = 0;
            
            switch ( var0.id )
            {
                case "care_package":
                case "bradley":
                    var5 = 1;
                    break;
                case "intel":
                    var5 = 2;
                    break;
                case "support_box":
                    var5 = 3;
                    break;
                case "deployable_weapon_crate":
                    var5 = 4;
                    break;
                case "laststand_reviver":
                    var5 = 5;
                    break;
                case "laststand_revivee":
                    var5 = 6;
                    break;
                case "breach":
                    var5 = 7;
                    break;
                case "use":
                    var5 = 8;
                    break;
                case "breach_defuse":
                    var5 = 9;
                    break;
                case "bounty":
                    var5 = 10;
                    break;
                case "hack":
                    var5 = 13;
                    break;
                case "hvt_search":
                    var5 = 15;
                    break;
                case "build":
                    var5 = 21;
                    break;
                case "destroy":
                    var5 = 22;
                    break;
                case "weapon_trade":
                    var5 = 23;
                    break;
                case "planting_explosive":
                    var5 = 24;
                    break;
            }
            
            updateuisecuring( var4, var1, var5, var0, var2.usetime );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x2e, Type: bool
function showspecificteamprogress( var0 )
{
    switch ( scripts\mp\utility\game::getgametype() )
    {
        case "vip":
            if ( var0.claimteam == game[ "attackers" ] )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Params 0
// Size: 0x8c, Type: bool
function hasdomflags()
{
    switch ( scripts\mp\utility\game::getgametype() )
    {
        case "cmd":
        case "grnd":
        case "grind":
        case "koth":
        case "defcon":
        case "rugby":
        case "rush":
        case "btm":
        case "hq":
        case "pill":
        case "mtmc":
        case "siege":
        case "dom":
        case "arena":
        case "br":
        case "arm":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Params 5
// Size: 0x288
function updateuisecuring( var0, var1, var2, var3, var4 )
{
    var5 = undefined;
    
    if ( var1 )
    {
        if ( !isdefined( var3.usedby ) )
        {
            var3.usedby = [];
        }
        
        if ( !isdefined( self.migrationcapturereset ) )
        {
            thread migrationcapturereset( var3 );
        }
        
        if ( !existinarray( self, var3.usedby ) )
        {
            var3.usedby[ var3.usedby.size ] = self;
        }
        
        if ( !isdefined( self.ui_securing ) )
        {
            self setclientomnvar( "ui_securing", var2 );
            self.ui_securing = 1;
            
            if ( isdefined( var3.trigger ) && isrevivetrigger( var3.trigger ) )
            {
                if ( isdefined( var3.trigger.owner ) )
                {
                    var3.trigger.owner setclientomnvar( "ui_reviver_id", self getentitynumber() );
                    var3.trigger.owner setclientomnvar( "ui_securing", 6 );
                }
            }
        }
        
        if ( scripts\mp\utility\game::getgametype() == "br" && var3.id == "laststand_reviver" )
        {
            var6 = undefined;
            
            if ( isdefined( var3.trigger ) && isrevivetrigger( var3.trigger ) )
            {
                var6 = var3.trigger.owner;
            }
            
            if ( isdefined( var6 ) && self == var6 )
            {
                self setclientomnvar( "ui_securing", 16 );
            }
            
            scripts\mp\gametypes\br::ref_1401f( var6, self, var0 );
        }
    }
    else
    {
        if ( isdefined( var3.usedby ) && existinarray( self, var3.usedby ) )
        {
            var3.usedby = scripts\engine\utility::array_remove( var3.usedby, self );
        }
        
        self setclientomnvar( "ui_securing", 0 );
        self.ui_securing = undefined;
        
        if ( isdefined( var3.trigger ) && isrevivetrigger( var3.trigger ) )
        {
            if ( isdefined( var3.trigger.owner ) )
            {
                var3.trigger.owner setclientomnvar( "ui_reviver_id", -1 );
                var3.trigger.owner setclientomnvar( "ui_securing", 0 );
            }
        }
        
        var0 = 0.01;
        
        if ( isdefined( var3.objidnum ) )
        {
            var5 = var3.objidnum;
        }
    }
    
    if ( var4 == 500 )
    {
        var0 = min( var0 + 0.15, 1 );
    }
    
    if ( var0 != 0 )
    {
        self setclientomnvar( "ui_securing_progress", var0 );
        
        if ( isdefined( var3.trigger ) && isrevivetrigger( var3.trigger ) )
        {
            if ( isdefined( var3.trigger.owner ) )
            {
                var3.trigger.owner setclientomnvar( "ui_securing_progress", var0 );
            }
        }
        
        if ( isdefined( var3.objidnum ) && !istrue( var3.“rc³Í³àOð’ZÃ¦;l|“kòxOhc ) )
        {
            scripts\mp\objidpoolmanager::objective_set_progress( var3.objidnum, var0 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x3a, Type: bool
function existinarray( var0, var1 )
{
    if ( var1.size > 0 )
    {
        foreach ( var3 in var1 )
        {
            if ( var3 == var0 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 0
// Size: 0x20e
function updateuserate()
{
    if ( self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any" )
    {
        var0 = self.ownerteam;
    }
    else
    {
        var0 = self.claimteam;
    }
    
    var1 = self.numtouching[ var0 ];
    var2 = 0;
    var3 = 0;
    
    foreach ( var5 in level.teamnamelist )
    {
        if ( level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent( var5 ) )
        {
            continue;
        }
        
        if ( var0 != var5 )
        {
            var2 += self.numtouching[ var5 ];
        }
    }
    
    if ( isdefined( self.touchlist[ var0 ] ) )
    {
        foreach ( var8 in self.touchlist[ var0 ] )
        {
            if ( !isdefined( var8.player ) )
            {
                continue;
            }
            
            if ( var8.player.pers[ "team" ] != var0 )
            {
                continue;
            }
            
            if ( var8.player.objectivescaler == 1 )
            {
                continue;
            }
            
            var1 *= var8.player.objectivescaler;
            var3 = var8.player.objectivescaler;
        }
    }
    
    if ( !istrue( self.ref_133e5 ) )
    {
        self.stalemate = scripts\engine\utility::ter_op( istrue( self.alwaysstalemate ), var1 && var2, var1 && var2 && var1 == var2 );
    }
    
    if ( !var1 && !var2 )
    {
        self.majoritycapprogress = 0;
    }
    
    if ( isdefined( self.triggertype ) && self.triggertype == "use" )
    {
    }
    else
    {
        self.userate = 0;
    }
    
    if ( var1 )
    {
        if ( var1 > var2 )
        {
            self.userate = min( var1 - var2, scripts\engine\utility::ter_op( isdefined( level.objectivescaler ), level.objectivescaler, 4 ) );
            
            if ( self.userate > 1 )
            {
                self.userate *= self.useratemultiplier;
            }
        }
    }
    
    if ( isdefined( self.isarena ) && self.isarena && var3 != 0 )
    {
        self.userate = 1 * var3;
        return;
    }
    
    if ( isdefined( self.isarena ) && self.isarena )
    {
        self.userate = 1;
        return;
    }
}

// Params 1
// Size: 0x42b, Type: bool
function useholdthink( var0 )
{
    var0 notify( "use_hold" );
    
    if ( self.exclusiveuse )
    {
        var0 clientclaimtrigger( self.trigger );
    }
    
    var0 allowmovement( 0 );
    var1 = isdefined( self.id ) && ( self.id == "traversalassist" || self.id == "breach" || self.id == "care_package" );
    
    if ( isbombmode() )
    {
        if ( var1 || level.gametype == "cyber" )
        {
        }
        else if ( scripts\mp\utility\game::isanymlgmatch() || istrue( level.silentplant ) )
        {
            var0 setentitysoundcontext( "silent_plant", "on" );
            
            if ( istrue( var0.isdefusing ) )
            {
                self.useweapon = getcompleteweaponname( "briefcase_defuse_silent_mp" );
            }
            else
            {
                self.useweapon = getcompleteweaponname( "briefcase_silent_mp" );
            }
        }
    }
    
    var2 = self.useweapon;
    var3 = var0 getcurrentweapon();
    
    if ( isdefined( var2 ) )
    {
        var4 = 0;
        
        if ( var3.basename == "iw8_cyberemp_mp" )
        {
            var4 = 1;
        }
        
        if ( var3 == var2 )
        {
            var3 = var0.lastnonuseweapon;
        }
        
        var0.lastnonuseweapon = var3;
        var5 = 0;
        var6 = 0;
        
        if ( scripts\mp\utility\game::getgametype() == "cyber" )
        {
            var5 = 1;
            var6 = 0;
        }
        
        var0 scripts\cp_mp\utility\inventory_utility::_giveweapon( var2, undefined, undefined, 0 );
        var0 setweaponammostock( var2, var5 );
        var0 setweaponammoclip( var2, var5 );
        thread switchtouseweapon( var0, var2 );
    }
    else if ( !var1 )
    {
        if ( isdefined( self.trigger ) && isrevivetrigger( self.trigger ) || isdefined( self.id ) && self.id == "rugby_jugg" )
        {
            if ( !var0 scripts\mp\utility\perk::_hasperk( "specialty_revive_use_weapon" ) )
            {
                var0.weaponsdisabledwhilereviving = 1;
                
                if ( !level.allowreviveweapons )
                {
                    thread playerplunderdepositcallback( var0 );
                    var0 scripts\common\utility::allow_sprint( 0 );
                    var0 scripts\common\utility::allow_fire( 0 );
                    var0 scripts\common\utility::allow_ads( 0 );
                    var0 scripts\common\utility::allow_offhand_weapons( 0 );
                }
                else
                {
                    var0 scripts\mp\playeractions::allowactionset( "reviveShoot", 0 );
                }
            }
        }
        else
        {
            var0 scripts\common\utility::allow_weapon( 0 );
        }
    }
    
    if ( !isdefined( var0.usinggameobjects ) )
    {
        var0.usinggameobjects = [];
    }
    
    var7 = self.trigger getentitynumber();
    var0.usinggameobjects[ var7 ] = self;
    
    if ( !isdefined( self.resetprogress ) || istrue( self.resetprogress ) )
    {
        self.curprogress = 0;
    }
    
    self.inuse = 1;
    self.userate = 0;
    var8 = useholdthinkloop( var0, var3 );
    
    if ( isdefined( var0 ) )
    {
        var0.usinggameobjects[ var7 ] = undefined;
        detachusemodels( var0 );
        var0 notify( "done_using" );
    }
    
    if ( isdefined( var2 ) && isdefined( var0 ) )
    {
        if ( scripts\mp\utility\game::getgametype() == "cyber" && !isrevivetrigger() && !istrue( var8 ) )
        {
            var0 setweaponammostock( var2, 0 );
            var0 setweaponammoclip( var2, 0 );
        }
        
        var0 scripts\mp\supers::unstowsuperweapon();
        
        if ( var0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( var2 ) )
        {
            var0 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( var2 );
            var0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( var3 );
        }
        else if ( scripts\mp\utility\game::getgametype() == "sd" )
        {
            if ( !istrue( var8 ) )
            {
                var0 setweaponammostock( var2, 1 );
                var0 setweaponammoclip( var2, 1 );
            }
            
            if ( var0 scripts\mp\utility\killstreak::isjuggernaut() )
            {
                var0 scripts\cp_mp\utility\inventory_utility::_takeweapon( var2 );
                var0 scripts\mp\utility\inventory::switchtolastweapon();
            }
            else
            {
                var0 thread scripts\cp_mp\utility\inventory_utility::getridofweapon( var2 );
            }
        }
        else if ( var0 scripts\mp\utility\killstreak::isjuggernaut() )
        {
            var0 scripts\cp_mp\utility\inventory_utility::_takeweapon( var2 );
            var0 scripts\mp\utility\inventory::switchtolastweapon();
        }
        else
        {
            var0 thread scripts\cp_mp\utility\inventory_utility::getridofweapon( var2 );
        }
    }
    
    if ( istrue( var8 ) )
    {
        var0 allowmovement( 1 );
        return true;
    }
    else if ( !istrue( var8 ) )
    {
        if ( !isdefined( self.resetprogress ) || istrue( self.resetprogress ) )
        {
            self.curprogress = 0;
        }
        else
        {
            managecurprogress( var0 );
        }
    }
    
    if ( isdefined( var0 ) )
    {
        if ( !isdefined( var2 ) && !var1 )
        {
            if ( isdefined( self.trigger ) && isrevivetrigger( self.trigger ) || isdefined( self.id ) && self.id == "rugby_jugg" )
            {
                if ( istrue( var0.weaponsdisabledwhilereviving ) )
                {
                    var0.weaponsdisabledwhilereviving = undefined;
                    
                    if ( !level.allowreviveweapons )
                    {
                        thread playerplunderdepositcallback( var0 );
                        var0 scripts\common\utility::allow_sprint( 1 );
                        var0 scripts\common\utility::allow_fire( 1 );
                        var0 scripts\common\utility::allow_ads( 1 );
                        var0 scripts\common\utility::allow_offhand_weapons( 1 );
                    }
                    else
                    {
                        var0 scripts\mp\playeractions::allowactionset( "reviveShoot", 1 );
                    }
                }
            }
            else
            {
                var0 scripts\common\utility::allow_weapon( 1 );
            }
        }
        
        var0 allowmovement( 1 );
    }
    
    self.inuse = 0;
    
    if ( self.exclusiveuse && isdefined( self.trigger ) )
    {
        self.trigger releaseclaimedtrigger();
    }
    
    return false;
}

// Params 1
// Size: 0x54
function playerplunderdepositcallback( var0 )
{
    self endon( "death" );
    self notify( "forceDemeanorSafe" );
    self endon( "forceDemeanorSafe" );
    
    if ( var0 )
    {
        while ( self issprinting() )
        {
            wait 0.5;
        }
        
        self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe" );
        return;
    }
    
    var1 = 0;
    
    while ( !var1 )
    {
        var1 = self setdemeanorviewmodel( "normal" );
        waitframe();
    }
}

// Params 1
// Size: 0x174
function managecurprogress( var0 )
{
    if ( !isdefined( self.prevprogress ) )
    {
        self.prevprogress = 0;
    }
    
    var1 = self.curprogress - self.prevprogress;
    
    if ( var1 <= 1000 )
    {
        self.curprogress = self.prevprogress;
    }
    
    var2 = self.usetime - self.curprogress;
    
    if ( var2 < 1000 )
    {
        if ( self.usetime <= 1000 )
        {
            self.curprogress = self.usetime;
        }
        else
        {
            self.curprogress = self.usetime - 1000;
        }
    }
    
    var1 = 0;
    
    if ( self.curprogress > 0 )
    {
        if ( isdefined( self.teamprogress ) && isdefined( self.claimteam ) )
        {
            if ( self.teamprogress[ self.claimteam ] > self.usetime )
            {
                self.teamprogress[ self.claimteam ] = self.usetime;
            }
            
            var1 = self.teamprogress[ self.claimteam ] / self.usetime;
        }
        else
        {
            if ( self.curprogress > self.usetime )
            {
                self.curprogress = self.usetime;
            }
            
            var1 = self.curprogress / self.usetime;
            
            if ( self.usetime <= 1000 )
            {
                var1 = min( var1 + 0.05, 1 );
            }
            else
            {
                var1 = min( var1 + 0.01, 1 );
            }
        }
    }
    
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var0.team );
    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, var1 );
    
    if ( self.curprogress > 0 )
    {
        scripts\mp\objidpoolmanager::objective_show_team_progress( self.objidnum, var0.team );
    }
    else
    {
        scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    self.prevprogress = self.curprogress;
}

// Params 0
// Size: 0x21
function detachusemodels()
{
    if ( isdefined( self.attachedusemodel ) )
    {
        self detach( self.attachedusemodel, "tag_inhand" );
        self.attachedusemodel = undefined;
        return;
    }
}

// Params 2
// Size: 0x37
function switchtouseweapon( var0, var1 )
{
    scripts\mp\supers::allowsuperweaponstow();
    var2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var0, var1 );
    
    if ( !istrue( var2 ) )
    {
        scripts\mp\supers::unstowsuperweapon();
        
        if ( scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( var0 ) )
        {
            scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( var0 );
            return;
        }
        
        scripts\cp_mp\utility\inventory_utility::_takeweapon( var0 );
        return;
    }
}

// Params 4
// Size: 0x146, Type: bool
function usetest( var0, var1, var2, var3 )
{
    if ( !scripts\mp\utility\player::isreallyalive( var0 ) )
    {
        return false;
    }
    
    if ( !var0 scripts\common\utility::is_usability_allowed() )
    {
        return false;
    }
    
    if ( !isdefined( self.skiptouching ) && isdefined( self.trigger ) && !var0 istouching( self.trigger ) )
    {
        return false;
    }
    
    if ( !level.allowreviveweapons && !var0 usebuttonpressed( 1 ) )
    {
        return false;
    }
    
    if ( var0 scripts\mp\utility\weapon::grenadeinpullback() )
    {
        return false;
    }
    
    if ( var0 meleebuttonpressed() )
    {
        return false;
    }
    
    if ( var0 isinexecutionattack() )
    {
        return false;
    }
    
    if ( var0 isinexecutionvictim() )
    {
        return false;
    }
    
    if ( isdefined( self.trigger ) && isdefined( self.trigger.ref_1408a ) && distance2dsquared( self.trigger.origin, var0.origin ) >= self.trigger.ref_1408a )
    {
        return false;
    }
    
    if ( self.curprogress >= self.usetime )
    {
        return false;
    }
    
    if ( !self.userate && !var1 )
    {
        return false;
    }
    
    if ( var1 && var2 > var3 )
    {
        return false;
    }
    
    if ( istrue( self.getrandompointincirclewithindistance ) && isdefined( self.usecondition ) && !self [[ self.usecondition ]]( var0 ) )
    {
        return false;
    }
    
    if ( isdefined( self.useweapon ) )
    {
        if ( var0 getcurrentweapon() != self.useweapon && !var0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( self.useweapon ) )
        {
            return false;
        }
    }
    
    if ( isrevivetrigger( self.trigger ) )
    {
        if ( !var0 isonground() )
        {
            return false;
        }
    }
    
    return true;
}

// Params 2
// Size: 0x21b
function useholdthinkloop( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disabled" );
    var2 = self.useweapon;
    var3 = 1;
    
    if ( isdefined( self.waitforweapononuse ) )
    {
        var3 = self.waitforweapononuse;
    }
    
    if ( !var3 )
    {
        self.userate = 1 * var0.objectivescaler;
    }
    
    var4 = 0;
    var5 = 1.5;
    var6 = level.framedurationseconds;
    var7 = var6 * 1000;
    var8 = undefined;
    
    while ( usetest( var0, var3, var4, var5 ) )
    {
        if ( isdefined( self.objidnum ) )
        {
            scripts\mp\objidpoolmanager::objective_pin_player( self.objidnum, var0 );
        }
        
        var4 += var6;
        
        if ( !var3 || !isdefined( var2 ) || var0 getcurrentweapon() == var2 )
        {
            self.curprogress += var7 * self.userate;
            self.userate = 1 * var0.objectivescaler;
            var3 = 0;
        }
        else
        {
            self.userate = 0;
        }
        
        updateuiprogress( var0, self, 1 );
        
        if ( self.curprogress >= self.usetime )
        {
            self.inuse = 0;
            
            if ( self.exclusiveuse )
            {
                var0 clientreleasetrigger( self.trigger );
            }
            
            var9 = isdefined( self.id ) && ( self.id == "traversalassist" || self.id == "breach" || self.id == "care_package" );
            
            if ( !isdefined( var2 ) && !var9 )
            {
                if ( isrevivetrigger( self.trigger ) || isdefined( self.id ) && self.id == "rugby_jugg" )
                {
                    if ( istrue( var0.weaponsdisabledwhilereviving ) )
                    {
                        var0.weaponsdisabledwhilereviving = undefined;
                        
                        if ( !level.allowreviveweapons )
                        {
                            thread playerplunderdepositcallback( var0 );
                            var0 scripts\common\utility::allow_sprint( 1 );
                            var0 scripts\common\utility::allow_fire( 1 );
                            var0 scripts\common\utility::allow_ads( 1 );
                            var0 scripts\common\utility::allow_offhand_weapons( 1 );
                        }
                        else
                        {
                            var0 scripts\mp\playeractions::allowactionset( "reviveShoot", 1 );
                        }
                    }
                }
                else
                {
                    var0 scripts\common\utility::allow_weapon( 1 );
                }
            }
            
            var0 unlink();
            
            if ( isdefined( self.objidnum ) )
            {
                scripts\mp\objidpoolmanager::objective_unpin_player( self.objidnum, var0 );
            }
            
            return scripts\mp\utility\player::isreallyalive( var0 );
        }
        
        wait var7;
        scripts\mp\hostmigration::waittillhostmigrationdone();
    }
    
    if ( isdefined( self.objidnum ) )
    {
        scripts\mp\objidpoolmanager::objective_unpin_player( self.objidnum, var1 );
    }
    
    updateuiprogress( var1, self, 0 );
    return 0;
}

// Params 0
// Size: 0x1a2
function updatetrigger()
{
    if ( self.triggertype != "use" )
    {
        return;
    }
    
    if ( self.trigger.classname != "trigger_use" && self.trigger.classname != "trigger_use_touch" )
    {
        return;
    }
    
    if ( self.interactteam == "none" )
    {
        self.trigger.origin -= ( 0, 0, 10000 );
        
        if ( isdefined( self.trigger.classname ) && self.trigger.classname != "script_model" )
        {
            self.trigger setteamfortrigger( "none" );
            return;
        }
        
        return;
    }
    
    if ( self.interactteam == "any" )
    {
        self.trigger.origin = self.curorigin;
        self.trigger setteamfortrigger( "none" );
        return;
    }
    
    if ( self.interactteam == "friendly" )
    {
        self.trigger.origin = self.curorigin;
        
        if ( scripts\engine\utility::array_contains( level.teamnamelist, self.ownerteam ) )
        {
            self.trigger setteamfortrigger( self.ownerteam );
            return;
        }
        
        self.trigger.origin -= ( 0, 0, 50000 );
        return;
    }
    
    if ( self.interactteam == "enemy" )
    {
        self.trigger.origin = self.curorigin;
        
        if ( self.ownerteam == "allies" )
        {
            self.trigger setteamfortrigger( "axis" );
            return;
        }
        
        if ( self.ownerteam == "axis" )
        {
            self.trigger setteamfortrigger( "allies" );
            return;
        }
        
        self.trigger setteamfortrigger( "none" );
        return;
    }
}

// Params 1
// Size: 0x47
function getmlgteamcolor( var0 )
{
    if ( var0 == "allies" )
    {
        return game[ "colors" ][ "friendly" ];
    }
    else if ( var0 == "axis" )
    {
        return game[ "colors" ][ "enemy" ];
    }
    
    return ( 1, 1, 1 );
}

// Params 3
// Size: 0xfd
function setobjpointteamcolor( var0, var1, var2 )
{
    if ( var1 == "mlg_allies" )
    {
        var0 setmlgdraw( 1, 0 );
        var3 = self.objiconscolor[ var2 ];
        
        if ( var3 == "friendly" )
        {
            var0.color = getmlgteamcolor( "allies" );
            return;
        }
        
        if ( var3 == "enemy" )
        {
            var0.color = getmlgteamcolor( "axis" );
            return;
        }
        
        var0.color = game[ "colors" ][ var3 ];
        return;
    }
    
    if ( var1 == "mlg_axis" )
    {
        var0 setmlgdraw( 1, 0 );
        var3 = self.objiconscolor[ var2 ];
        
        if ( var3 == "friendly" )
        {
            var0.color = getmlgteamcolor( "axis" );
            return;
        }
        
        if ( var3 == "enemy" )
        {
            var0.color = getmlgteamcolor( "allies" );
            return;
        }
        
        var0.color = game[ "colors" ][ var3 ];
        return;
    }
    
    var0.color = game[ "colors" ][ self.objiconscolor[ var2 ] ];
    var0 setmlgdraw( 0, 1 );
}

// Params 0
// Size: 0x2c
function hideworldiconongameend()
{
    self notify( "hideWorldIconOnGameEnd" );
    self endon( "hideWorldIconOnGameEnd" );
    self endon( "death" );
    level waittill( "game_ended" );
    
    if ( isdefined( self ) )
    {
        self.alpha = 0;
        return;
    }
}

// Params 2
// Size: 0x5
function updatetimer( var0, var1 )
{
    
}

// Params 5
// Size: 0x93
function ref_1317f( var0, var1, var2, var3, var4 )
{
    if ( istrue( self.lockupdatingicons ) )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = var1;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = var0;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    if ( level.codcasterenabled )
    {
        if ( !isdefined( var2 ) )
        {
            self.compassicons[ "codcaster" ] = undefined;
        }
        else
        {
            self.compassicons[ "codcaster" ] = var2 + self.iconname;
        }
    }
    
    self.compassicons[ "friendly" ] = var0 + self.iconname;
    self.compassicons[ "enemy" ] = var1 + self.iconname;
    updatecompassicons( var3, var4 );
}

// Params 5
// Size: 0x69
function setobjectivestatusicons( var0, var1, var2, var3, var4 )
{
    if ( istrue( self.lockupdatingicons ) )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = var1;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = var0;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    self.compassicons[ "friendly" ] = var0 + self.iconname;
    self.compassicons[ "enemy" ] = var1 + self.iconname;
    
    if ( !istrue( var4 ) )
    {
        updatecompassicons( var2, var3 );
        return;
    }
}

// Params 3
// Size: 0x43
function ref_13172( var0, var1, var2 )
{
    if ( !level.codcasterenabled )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    self.compassicons[ "codcaster" ] = var0 + self.iconname;
    updatecompassicons( var1, var2 );
}

// Params 2
// Size: 0x18
function ref_12c75( var0, var1 )
{
    self.compassicons[ "codcaster" ] = undefined;
    updatecompassicons( var0, var1 );
}

// Params 2
// Size: 0x24
function updatecompassicons( var0, var1 )
{
    var2 = self.visibleteam;
    
    if ( !isdefined( self.visibleteam ) )
    {
        var2 = "none";
    }
    
    updatecompassicon( var2, var0, var1 );
}

// Params 3
// Size: 0x5a5
function updatecompassicon( var0, var1, var2 )
{
    var3 = var0 == "any";
    var4 = var0 == "none";
    jumpiffalse(var3 || var4) LOC_0000002c;
    var5 = level.teamnamelist;
    goto LOC_00000041;
}

// Params 1
// Size: 0x37, Type: bool
function shouldpingobject( var0 )
{
    if ( var0 == "friendly" && self.objidpingenemy )
    {
        return true;
    }
    else if ( var0 == "enemy" && self.objidpingfriendly )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x174
function getupdateteams( var0 )
{
    var1 = spawnstruct();
    var1.teams = [];
    
    foreach ( var3 in level.teamnamelist )
    {
        var4 = var1.teams.size;
        var1.teams[ var4 ] = spawnstruct();
        
        if ( var0 == "any" )
        {
            var1.teams[ var4 ].team = var3;
            var1.teams[ var4 ].showtoteam = 1;
            continue;
        }
        
        if ( var0 == "friendly" )
        {
            if ( isfriendlyteam( var3 ) )
            {
                var1.teams[ var4 ].team = var3;
                var1.teams[ var4 ].showtoteam = 1;
            }
            else
            {
                var1.teams[ var4 ].team = var3;
                var1.teams[ var4 ].showtoteam = 0;
            }
            
            continue;
        }
        
        if ( var0 == "enemy" )
        {
            if ( isfriendlyteam( var3 ) )
            {
                var1.teams[ var4 ].team = var3;
                var1.teams[ var4 ].showtoteam = 0;
            }
            else
            {
                var1.teams[ var4 ].team = var3;
                var1.teams[ var4 ].showtoteam = 1;
            }
            
            continue;
        }
        
        if ( var0 == "none" )
        {
            var1.teams[ var4 ].team = var3;
            var1.teams[ var4 ].showtoteam = 0;
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x43
function getobjectivestate( var0, var1 )
{
    if ( var0 == "contest" || var1 == "contest" )
    {
        return "contest";
    }
    
    if ( var0 == "neutral" || var1 == "neutral" )
    {
        return "neutral";
    }
    
    return "claimed";
}

// Params 1
// Size: 0x28
function shouldshowcompassduetoradar( var0 )
{
    if ( !isdefined( self.carrier ) )
    {
        return 0;
    }
    
    if ( self.carrier scripts\mp\utility\perk::_hasperk( "specialty_gpsjammer" ) )
    {
        return 0;
    }
    
    return getteamradar( var0 );
}

// Params 0
// Size: 0x20
function updatevisibilityaccordingtoradar()
{
    self endon( "death" );
    self endon( "carrier_cleared" );
    
    for ( ;; )
    {
        level waittill( "radar_status_change" );
        updatecompassicons();
    }
}

// Params 1
// Size: 0x25
function setownerteam( var0 )
{
    self.ownerteam = var0;
    updatetrigger();
    updatecompassicons();
    
    if ( var0 != "neutral" )
    {
        self.prevownerteam = var0;
        return;
    }
}

// Params 0
// Size: 0x8
function getownerteam()
{
    return self.ownerteam;
}

// Params 1
// Size: 0x11
function setusetime( var0 )
{
    self.usetime = int( var0 * 1000 );
}

// Params 0
// Size: 0x9
function pinobjiconontriggertouch()
{
    self.pinobj = 1;
}

// Params 1
// Size: 0xa
function setwaitweaponchangeonuse( var0 )
{
    self.waitforweapononuse = var0;
}

// Params 1
// Size: 0xa
function setusetext( var0 )
{
    self.usetext = var0;
}

// Params 2
// Size: 0x15
function setteamusetime( var0, var1 )
{
    self.teamusetimes[ var0 ] = int( var1 * 1000 );
}

// Params 2
// Size: 0xe
function setteamusetext( var0, var1 )
{
    self.teamusetexts[ var0 ] = var1;
}

// Params 1
// Size: 0xe
function setusehinttext( var0 )
{
    self.trigger sethintstring( var0 );
}

// Params 1
// Size: 0xa
function allowcarry( var0 )
{
    self.interactteam = var0;
}

// Params 1
// Size: 0xf
function allowuse( var0 )
{
    self.interactteam = var0;
    updatetrigger();
}

// Params 2
// Size: 0x4b
function squadallowuse( var0, var1 )
{
    if ( !isdefined( self.interactsquads ) )
    {
        self.interactsquads = [];
    }
    
    if ( !isdefined( self.interactsquads[ var0 ] ) )
    {
        self.interactsquads[ var0 ] = [];
    }
    
    if ( !scripts\engine\utility::array_contains( self.interactsquads[ var0 ], var1 ) )
    {
        self.interactsquads[ var0 ][ self.interactsquads[ var0 ].size ] = var1;
        return;
    }
}

// Params 2
// Size: 0x4e
function squaddenyuse( var0, var1 )
{
    if ( !isdefined( self.interactsquads ) )
    {
        self.interactsquads = [];
    }
    
    if ( !isdefined( self.interactsquads[ var0 ] ) )
    {
        self.interactsquads[ var0 ] = [];
    }
    
    if ( scripts\engine\utility::array_contains( self.interactsquads[ var0 ], var1 ) )
    {
        self.interactsquads[ var0 ] = scripts\engine\utility::array_remove( self.interactsquads[ var0 ], var1 );
        return;
    }
}

// Params 3
// Size: 0x19
function setvisibleteam( var0, var1, var2 )
{
    self.visibleteam = var0;
    
    if ( !istrue( var2 ) )
    {
        updatecompassicons( var1 );
        return;
    }
}

// Params 1
// Size: 0x102
function setmodelvisibility( var0 )
{
    if ( var0 )
    {
        for ( var1 = 0; var1 < self.visuals.size ; var1++ )
        {
            self.visuals[ var1 ] show();
            
            if ( self.visuals[ var1 ].classname == "script_brushmodel" || self.visuals[ var1 ].classname == "script_model" )
            {
                foreach ( var3 in level.players )
                {
                    if ( var3 istouching( self.visuals[ var1 ] ) )
                    {
                        var3 scripts\mp\utility\damage::_suicide();
                    }
                }
                
                thread makesolid();
            }
        }
        
        return;
    }
    
    for ( var1 = 0; var1 < self.visuals.size ; var1++ )
    {
        self.visuals[ var1 ] hide();
        
        if ( self.visuals[ var1 ].classname == "script_brushmodel" || self.visuals[ var1 ].classname == "script_model" )
        {
            self.visuals[ var1 ] notify( "changing_solidness" );
            self.visuals[ var1 ] notsolid();
        }
    }
}

// Params 0
// Size: 0x5e
function makesolid()
{
    self endon( "death" );
    self notify( "changing_solidness" );
    self endon( "changing_solidness" );
    
    for ( ;; )
    {
        for ( var0 = 0; var0 < level.players.size ; var0++ )
        {
            if ( level.players[ var0 ] istouching( self ) )
            {
                break;
            }
        }
        
        if ( var0 == level.players.size )
        {
            self solid();
            break;
        }
        
        wait 0.05;
    }
}

// Params 1
// Size: 0xa
function setcarriervisible( var0 )
{
    self.carriervisible = var0;
}

// Params 1
// Size: 0xa
function setcanuse( var0 )
{
    self.useteam = var0;
}

// Params 1
// Size: 0x1a
function getwaypointshader( var0 )
{
    var1 = level.waypointshader[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return "icon_waypoint_dom_a";
    }
    
    return var1;
}

// Params 1
// Size: 0x16
function getwaypointbackgroundtype( var0 )
{
    var1 = level.waypointbgtype[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return 0;
    }
    
    return var1;
}

// Params 1
// Size: 0x1a
function getwaypointbackgroundcolor( var0 )
{
    var1 = level.waypointcolors[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return "neutral";
    }
    
    return var1;
}

// Params 1
// Size: 0x1a
function getwaypointstring( var0 )
{
    var1 = level.waypointstring[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return "MP_INGAME_ONLY/MISSING_STRING";
    }
    
    return var1;
}

// Params 1
// Size: 0x16
function getwaypointobjpulse( var0 )
{
    var1 = level.waypointpulses[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return 0;
    }
    
    return var1;
}

// Params 2
// Size: 0xe
function set3duseicon( var0, var1 )
{
    self.worlduseicons[ var0 ] = var1;
}

// Params 1
// Size: 0xa
function setcarryicon( var0 )
{
    self.carryicon = var0;
}

// Params 0
// Size: 0x64
function disableobject()
{
    self notify( "disabled" );
    
    if ( self.type == "carryObject" )
    {
        if ( isdefined( self.carrier ) )
        {
            takeobject( self.carrier, self );
        }
        
        for ( var0 = 0; var0 < self.visuals.size ; var0++ )
        {
            self.visuals[ var0 ] hide();
        }
    }
    
    self.trigger scripts\engine\utility::trigger_off();
    setvisibleteam( "none" );
}

// Params 0
// Size: 0x47
function enableobject()
{
    if ( self.type == "carryObject" )
    {
        for ( var0 = 0; var0 < self.visuals.size ; var0++ )
        {
            self.visuals[ var0 ] show();
        }
    }
    
    self.trigger scripts\engine\utility::trigger_on();
    setvisibleteam( "any" );
}

// Params 1
// Size: 0x1c
function getrelativeteam( var0 )
{
    if ( var0 == self.ownerteam )
    {
        return "friendly";
    }
    
    return "enemy";
}

// Params 1
// Size: 0x48, Type: bool
function isfriendlyteam( var0 )
{
    if ( self.ownerteam == "any" )
    {
        return true;
    }
    
    if ( self.ownerteam == var0 )
    {
        return true;
    }
    
    if ( self.ownerteam == "neutral" && isdefined( self.prevownerteam ) && self.prevownerteam == var0 )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0xa1
function caninteractwith( var0, var1 )
{
    if ( isdefined( var1 ) && isdefined( self.interactsquads ) )
    {
        return ( isdefined( self.interactsquads[ var1.team ] ) && scripts\engine\utility::array_contains( self.interactsquads[ var1.team ], var1.squadindex ) );
    }
    
    switch ( self.interactteam )
    {
        case "none":
            return 0;
        case "any":
            return 1;
        case "friendly":
            if ( var0 == self.ownerteam )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        case "enemy":
            if ( var0 != self.ownerteam )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            return 0;
    }
}

// Params 1
// Size: 0x5b, Type: bool
function isteam( var0 )
{
    if ( var0 == "neutral" )
    {
        return true;
    }
    
    if ( var0 == "any" )
    {
        return true;
    }
    
    if ( var0 == "none" )
    {
        return true;
    }
    
    foreach ( var2 in level.teamnamelist )
    {
        if ( var0 == var2 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x3a, Type: bool
function isrelativeteam( var0 )
{
    if ( var0 == "friendly" )
    {
        return true;
    }
    
    if ( var0 == "enemy" )
    {
        return true;
    }
    
    if ( var0 == "any" )
    {
        return true;
    }
    
    if ( var0 == "none" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x25
function getlabel()
{
    if ( !isdefined( self.trigger.script_label ) )
    {
        return "";
    }
    
    return self.trigger.script_label;
}

// Params 0
// Size: 0x14
function initializetagpathvariables()
{
    self.nearest_node = undefined;
    self.calculated_nearest_node = 0;
    self.on_path_grid = undefined;
}

// Params 1
// Size: 0xa
function mustmaintainclaim( var0 )
{
    self.mustmaintainclaim = var0;
}

// Params 1
// Size: 0xa
function cancontestclaim( var0 )
{
    self.cancontestclaim = var0;
}

// Params 0
// Size: 0x74
function getleveltriggers()
{
    level.minetriggers = getentarray( "minefield", "targetname" );
    level.hurttriggers = getentarray( "trigger_hurt", "classname" );
    level.radtriggers = getentarray( "radiation", "targetname" );
    level.ballallowedtriggers = getentarray( "uplinkAllowedOOB", "targetname" );
    level.nozonetriggers = getentarray( "uplink_nozone", "targetname" );
    level.droptonavmeshtriggers = getentarray( "dropToNavMesh", "targetname" );
    thread scripts\mp\arbitrary_up::initarbitraryuptriggers();
}

// Params 0
// Size: 0x4b
function isbombmode()
{
    switch ( scripts\mp\utility\game::getgametype() )
    {
        case "to_dd":
        case "cmd":
        case "btm":
        case "dd":
        case "cyber":
        case "sr":
        case "sd":
            return 1;
        default:
            return 0;
    }
}

// Params 0
// Size: 0x28
function unset_relic_bang_and_boom()
{
    switch ( scripts\mp\utility\game::getgametype() )
    {
        case "tdef":
        case "ctf":
            return 1;
        default:
            return 0;
    }
}

// Params 1
// Size: 0x9e, Type: bool
function touchingdroptonavmeshtrigger( var0 )
{
    if ( level.droptonavmeshtriggers.size > 0 )
    {
        if ( isbombmode() || scripts\mp\utility\game::getgametype() == "ctf" || scripts\mp\utility\game::getgametype() == "tdef" )
        {
            self.visuals[ 0 ].origin = var0;
        }
        
        foreach ( var2 in level.droptonavmeshtriggers )
        {
            foreach ( var4 in self.visuals )
            {
                if ( var4 istouching( var2 ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Params 0
// Size: 0x41, Type: bool
function touchingarbitraryuptrigger()
{
    if ( level.arbitraryuptriggers.size > 0 )
    {
        foreach ( var1 in level.arbitraryuptriggers )
        {
            if ( self istouching( var1 ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 0
// Size: 0x39
function resetcaptureprogress()
{
    if ( isdefined( self.teamprogress ) )
    {
        foreach ( var1 in self.teamprogress )
        {
            self.teamprogress[ var2 ] = 0;
        }
        
        return;
    }
}

// Params 0
// Size: 0x52
function getcaptureprogress()
{
    if ( isdefined( self.teamprogress ) && isdefined( self.claimteam ) )
    {
        if ( self.claimteam != "none" )
        {
            return ( self.teamprogress[ self.claimteam ] / self.usetime );
        }
        else
        {
            return ( self.teamprogress[ self.lastclaimteam ] / self.usetime );
        }
    }
    
    return 0;
}

// Params 5
// Size: 0xf4
function requestid( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var2 ) )
    {
        self.objidnum = scripts\mp\objidpoolmanager::requestreservedid( var2 );
    }
    else
    {
        self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    }
    
    if ( self.objidnum != -1 )
    {
        var5 = "done";
        
        if ( var0 && var1 )
        {
            var5 = "current";
        }
        else if ( var0 )
        {
            var5 = "active";
        }
        else if ( var1 )
        {
            var5 = "invisible";
        }
        
        scripts\mp\objidpoolmanager::objective_add_objective( self.objidnum, var5, self.curorigin + self.offset3d );
        
        if ( getdvarint( "scr_game_objOnNavBar", 0 ) == 1 )
        {
            if ( isdefined( var3 ) && var3 == 0 )
            {
                objective_setshowoncompass( self.objidnum, 0 );
                self.showoncompass = 0;
            }
            else
            {
                objective_setshowoncompass( self.objidnum, 1 );
            }
        }
        
        if ( isdefined( var4 ) )
        {
            scripts\mp\objidpoolmanager::objective_set_play_intro( self.objidnum, var4 );
            scripts\mp\objidpoolmanager::objective_set_play_outro( self.objidnum, var4 );
        }
        
        self.showworldicon = 0;
        scripts\mp\objidpoolmanager::objective_playermask_showtoall( self.objidnum );
        
        if ( var1 )
        {
            self.showworldicon = 1;
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x2d
function releaseid( var0, var1 )
{
    if ( istrue( var0 ) )
    {
        scripts\mp\objidpoolmanager::returnreservedobjectiveid( self.objidnum, var1 );
    }
    else
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.objidnum );
    }
    
    self.objidnum = -1;
}

// Params 0
// Size: 0x1c
function getcapturebehavior()
{
    if ( !isdefined( self.capturebehavior ) )
    {
        setcapturebehavior( "normal" );
    }
    
    return self.capturebehavior;
}

// Params 1
// Size: 0xa
function setcapturebehavior( var0 )
{
    self.capturebehavior = var0;
}

// Params 2
// Size: 0x497
function applycaptureprogress( var0, var1 )
{
    var2 = scripts\mp\utility\teams::getenemyteams( var0 );
    
    switch ( getcapturebehavior() )
    {
        case "single_progress":
            self.teamprogress[ var0 ] += level.frameduration;
            self.curprogress = self.teamprogress[ var0 ];
            break;
        case "persistent":
            self.teamprogress[ var0 ] += var1;
            self.curprogress = self.teamprogress[ var0 ];
            break;
        case "contest_only":
            if ( !isdefined( self.ownerteam ) || self.ownerteam == var0 )
            {
                return;
            }
            
            break;
        case "neutralize":
            foreach ( var4 in var2 )
            {
                var5 = self.teamprogress[ var4 ];
                
                if ( var5 > 0 )
                {
                    if ( var5 < var1 )
                    {
                        self.teamprogress[ var4 ] = 0;
                        var1 -= var5;
                        continue;
                    }
                    
                    self.teamprogress[ var4 ] -= var1;
                    var1 = 0;
                    self.curprogress = self.teamprogress[ var4 ];
                    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
                }
            }
            
            if ( var1 > 0 )
            {
                self.teamprogress[ var0 ] += var1;
                self.curprogress = self.teamprogress[ var0 ];
            }
            
            break;
        case "only_associated_teams":
            if ( !isdefined( self.associatedteams ) || !scripts\engine\utility::array_contains( self.associatedteams, var0 ) )
            {
                return;
            }
            
            foreach ( var4 in var2 )
            {
                var5 = self.teamprogress[ var4 ];
                
                if ( var5 > 0 )
                {
                    if ( var5 < var1 )
                    {
                        self.teamprogress[ var4 ] = 0;
                        var1 -= var5;
                        continue;
                    }
                    
                    self.teamprogress[ var4 ] -= var1;
                    var1 = 0;
                    self.curprogress = self.teamprogress[ var4 ];
                    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
                }
            }
            
            if ( var1 > 0 )
            {
                self.teamprogress[ var0 ] += var1;
                self.curprogress = self.teamprogress[ var0 ];
            }
            
            break;
        case "one_way_contest_only":
            if ( var0 != self.team )
            {
                return;
            }
            
            if ( var0 == self.team )
            {
                foreach ( var10 in var2 )
                {
                    if ( self.numtouching[ var10 ] > 0 )
                    {
                        return;
                    }
                }
            }
            
            self.teamprogress[ var0 ] += var1;
            self.curprogress = self.teamprogress[ var0 ];
            break;
        default:
            var12 = self.teamprogress[ var0 ];
            var12 += var1;
            var13 = 0;
            var14 = getnumtouchingforteam( var0 );
            var15 = getnumtouchingexceptteam( var0 );
            
            if ( var14 && var15 && var14 != var15 )
            {
                var13 = 1;
            }
            
            if ( istrue( self.majoritycapprogress ) && var12 >= self.usetime * 0.95 && istrue( var13 ) )
            {
                if ( self.ownerteam == "neutral" )
                {
                    foreach ( var0 in level.teamnamelist )
                    {
                        if ( self.touchlist[ var0 ].size )
                        {
                            var17 = self.touchlist[ var0 ];
                            var18 = getarraykeys( var17 );
                            
                            for ( var19 = 0; var19 < var18.size ; var19++ )
                            {
                                var20 = var17[ var18[ var19 ] ].player;
                                var20 setclientomnvar( "ui_objective_state", 4 );
                            }
                            
                            break;
                        }
                    }
                    
                    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::update_objective_setneutrallabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                }
                else
                {
                    foreach ( var0 in level.teamnamelist )
                    {
                        if ( var0 == self.ownerteam )
                        {
                            if ( self.touchlist[ var0 ].size )
                            {
                                var17 = self.touchlist[ var0 ];
                                var18 = getarraykeys( var17 );
                                
                                for ( var19 = 0; var19 < var18.size ; var19++ )
                                {
                                    var20 = var17[ var18[ var19 ] ].player;
                                    var20 setclientomnvar( "ui_objective_state", 4 );
                                }
                                
                                break;
                            }
                        }
                    }
                    
                    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS" );
                    scripts\mp\objidpoolmanager::update_objective_setenemylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                }
            }
            else
            {
                if ( self.ownerteam != "neutral" )
                {
                    if ( self.ownerteam != var0 )
                    {
                        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
                    }
                }
                
                self.teamprogress[ var0 ] += var1;
                self.curprogress = self.teamprogress[ var0 ];
            }
            
            break;
    }
}

// Params 11
// Size: 0x101
function createhintobject( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    var11 = spawn( "script_model", var0 );
    var11 makeusable();
    
    if ( isdefined( var1 ) )
    {
        var11 setcursorhint( var1 );
    }
    else
    {
        var11 setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( var2 ) )
    {
        var11 sethinticon( var2 );
    }
    
    if ( isdefined( var3 ) )
    {
        var11 sethintstring( var3 );
    }
    
    if ( isdefined( var4 ) )
    {
        var11 setusepriority( var4 );
    }
    else
    {
        var11 setusepriority( 0 );
    }
    
    if ( isdefined( var5 ) )
    {
        var11 setuseholdduration( var5 );
    }
    else
    {
        var11 setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( var6 ) )
    {
        var11 sethintonobstruction( var6 );
    }
    else
    {
        var11 sethintonobstruction( "hide" );
    }
    
    if ( isdefined( var7 ) )
    {
        var11 sethintdisplayrange( var7 );
    }
    else
    {
        var11 sethintdisplayrange( 200 );
    }
    
    if ( isdefined( var8 ) )
    {
        var11 sethintdisplayfov( var8 );
    }
    else
    {
        var11 sethintdisplayfov( 160 );
    }
    
    if ( isdefined( var9 ) )
    {
        var11 setuserange( var9 );
    }
    else
    {
        var11 setuserange( 50 );
    }
    
    if ( isdefined( var10 ) )
    {
        var11 setusefov( var10 );
    }
    else
    {
        var11 setusefov( 120 );
    }
    
    return var11;
}

// Params 11
// Size: 0x105
function sethintobject( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        var3 = undefined;
    }
    
    self makeusable();
    
    if ( isdefined( var0 ) )
    {
        self sethinttag( var0 );
    }
    
    if ( isdefined( var1 ) )
    {
        self setcursorhint( var1 );
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( var2 ) )
    {
        self sethinticon( var2 );
    }
    
    if ( isdefined( var3 ) )
    {
        self sethintstring( var3 );
    }
    
    if ( isdefined( var4 ) )
    {
        self setusepriority( var4 );
    }
    else
    {
        self setusepriority( 0 );
    }
    
    if ( isdefined( var5 ) )
    {
        self setuseholdduration( var5 );
    }
    else
    {
        self setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( var6 ) )
    {
        self sethintonobstruction( var6 );
    }
    else
    {
        self sethintonobstruction( "hide" );
    }
    
    if ( isdefined( var7 ) )
    {
        self sethintdisplayrange( var7 );
    }
    else
    {
        self sethintdisplayrange( 200 );
    }
    
    if ( isdefined( var8 ) )
    {
        self sethintdisplayfov( var8 );
    }
    else
    {
        self sethintdisplayfov( 160 );
    }
    
    if ( isdefined( var9 ) )
    {
        self setuserange( var9 );
    }
    else
    {
        self setuserange( 50 );
    }
    
    if ( isdefined( var10 ) )
    {
        self setusefov( var10 );
        return;
    }
    
    self setusefov( 120 );
}

// Params 6
// Size: 0x90
function createobjidobject( var0, var1, var2, var3, var4, var5 )
{
    var6 = spawnstruct();
    var6.type = "useObject";
    var6.curorigin = var0;
    var6.ownerteam = var1;
    
    if ( !isdefined( var2 ) )
    {
        var2 = ( 0, 0, 0 );
    }
    
    var6.offset3d = var2;
    requestid( var6, 1, 1, var3, var5 );
    var6.compassicons = [];
    var6.interactteam = "none";
    
    if ( isdefined( var4 ) )
    {
        var6.visibleteam = var4;
    }
    else
    {
        var6.visibleteam = "none";
    }
    
    return var6;
}

// Params 0
// Size: 0x1e, Type: bool
function isrevivetrigger()
{
    if ( isdefined( self.id ) && self.id == "laststand_reviver" )
    {
        return true;
    }
    
    return false;
}

