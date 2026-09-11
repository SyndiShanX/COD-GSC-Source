
// Params 6
// Size: 0x7c
function ref_1380c( var0, var1, var2, var3, var4, var5 )
{
    if ( !isdefined( var5 ) )
    {
        var5 = 1;
    }
    
    ammo_manager();
    
    if ( !ammo_cache_used() )
    {
        return;
    }
    
    if ( isdefined( self.ref_136e6 ) )
    {
        if ( isdefined( self.ref_136e6.type ) && self.ref_136e6.type == var0 )
        {
            ref_12cbb( var0, var1 );
            return;
        }
        else
        {
            if ( isdefined( var4 ) )
            {
                self.ref_136e6.ä‡õœo#∏Å(OÀp√H{âx≤àï = undefined;
            }
            
            ref_138c8();
        }
    }
    
    _init_speed_boost_struct( var0 );
    thread ammo_crate_think( var0, var1, var2, var3, var4, var5 );
}

// Params 1
// Size: 0x2f
function _init_speed_boost_struct( var0 )
{
    self.ref_136e6 = spawnstruct();
    self.ref_136e6.type = var0;
    self.ref_136e6.´>ÛEy^_6jrFîxWôx˘Hd«U = undefined;
    self.ref_136e6.ä‡õœo#∏Å(OÀp√H{âx≤àï = undefined;
}

// Params 0
// Size: 0x29
function preinfilstreamfunc()
{
    if ( isdefined( self.ref_136e6 ) && isdefined( self.ref_136e6.type ) )
    {
        return self.ref_136e6.type;
    }
    
    return undefined;
}

// Params 2
// Size: 0x30
function ref_12cbb( var0, var1 )
{
    if ( isdefined( self.ref_136e6 ) && isdefined( self.ref_136e6.type ) )
    {
        self notify( "speed_boost_" + var0 + "_timer_reset", var1 );
        return;
    }
}

// Params 0
// Size: 0x3e
function ref_138c8()
{
    if ( isdefined( self.ref_136e6 ) && isdefined( self.ref_136e6.type ) )
    {
        ammo_crate_spawn();
        var0 = self.ref_136e6.type;
        self.ref_136e6 = undefined;
        self notify( "stop_speed_boost_" + var0 );
        return;
    }
}

// Params 6
// Size: 0x5c
function ammo_crate_think( var0, var1, var2, var3, var4, var5 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "stop_speed_boost_" + var0 );
    self notify( "start_speed_boost_" + var0 );
    
    if ( istrue( var5 ) )
    {
        GscBinSkip4( 0x35 );
        // Unknown operator ( 0x35, iw8, PC )
    }
    
    GscBinSkip4( 0x35 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 0
// Size: 0x18
function ammo_crates()
{
    scripts\engine\utility::ref_143a5( "death", "player_set_infinate_super_sprint" );
    thread ref_138c8();
}

// Params 0
// Size: 0x63
function ammo_crate_trial_think()
{
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
        
        if ( level.gametype == "br" && ( var4 == "MOD_TRIGGER_HURT" || var4 == "MOD_UNKNOWN" ) )
        {
            continue;
        }
        
        thread ref_138c8();
        return;
    }
}

// Params 0
// Size: 0x14
function ammo_crate_use()
{
    level scripts\engine\utility::ref_143a5( "game_ended" );
    thread ref_138c8();
}

// Params 2
// Size: 0x36
function ammobox_bufferedattachmentweapon( var0, var1 )
{
    var2 = ref_143cc( "speed_boost_" + var0 + "_timer_reset", var1 );
    
    if ( isstring( var2 ) && var2 == "timeout" )
    {
        return;
    }
    
    ammobox_bufferedattachmentweapon( var0, var2 );
}

// Params 3
// Size: 0x61
function ammo_cache_setup( var0, var1, var2 )
{
    self.movespeedscaler = var0;
    scripts\mp\weapons::updatemovespeedscale();
    
    if ( !scripts\mp\gametypes\br_public::shouldlink() )
    {
        scripts\mp\utility\perk::giveperk( "specialty_sprintmelee" );
        scripts\mp\utility\perk::giveperk( "specialty_sprintads" );
        scripts\mp\utility\perk::giveperk( "specialty_marathon" );
    }
    
    GscBinSkip4( 0x35, var1 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 0
// Size: 0x8f
function ammo_crate_spawn()
{
    if ( ammo_cache_used() )
    {
        if ( scripts\mp\utility\perk::_hasperk( "specialty_lightweight" ) )
        {
            self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
        }
        else
        {
            self.movespeedscaler = 1;
        }
        
        scripts\mp\weapons::updatemovespeedscale();
    }
    
    if ( !scripts\mp\gametypes\br_public::shouldlink() )
    {
        scripts\mp\utility\perk::removeperk( "specialty_sprintmelee" );
        scripts\mp\utility\perk::removeperk( "specialty_sprintads" );
        scripts\mp\utility\perk::removeperk( "specialty_marathon" );
    }
    
    if ( isdefined( self.ref_136e6.´>ÛEy^_6jrFîxWôx˘Hd«U ) )
    {
        thread ammo_restock();
    }
    
    if ( ammo_cache_think() && isdefined( self.ref_136e6.ä‡õœo#∏Å(OÀp√H{âx≤àï ) )
    {
        self lerpfovbypreset( "default_2seconds" );
        return;
    }
}

// Params 1
// Size: 0x89
function ammobox_addrandomweapon( var0 )
{
    while ( isdefined( self.vehicle ) )
    {
        waitframe();
    }
    
    if ( isdefined( self.ref_136e6.´>ÛEy^_6jrFîxWôx˘Hd«U ) )
    {
        self.ref_136e6.´>ÛEy^_6jrFîxWôx˘Hd«U = var0;
        self.operatorcustomization.suit = var0;
        scripts\mp\utility\player::_setsuit( var0 );
        return;
    }
    
    if ( !isdefined( self.ref_12147 ) && is_custom_suit_valid( var0 ) )
    {
        self.ref_12147 = self.operatorcustomization.suit;
        self.ref_136e6.´>ÛEy^_6jrFîxWôx˘Hd«U = var0;
        self.operatorcustomization.suit = var0;
        scripts\mp\utility\player::_setsuit( var0 );
        return;
    }
}

// Params 0
// Size: 0xa6
function ammo_restock()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var0 = self.ref_136e6.´>ÛEy^_6jrFîxWôx˘Hd«U;
    
    while ( isdefined( self.ref_136e6 ) )
    {
        waitframe();
    }
    
    while ( isdefined( self.vehicle ) )
    {
        waitframe();
    }
    
    if ( isdefined( self.ref_136e6 ) )
    {
        self.ref_136e6.´>ÛEy^_6jrFîxWôx˘Hd«U = var0;
        return;
    }
    
    var1 = isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.suit ) && self.operatorcustomization.suit == var0;
    
    if ( isdefined( self.ref_12147 ) && var1 )
    {
        self.operatorcustomization.suit = self.ref_12147;
        scripts\mp\utility\player::_setsuit( self.ref_12147 );
        self.ref_12147 = undefined;
        return;
    }
}

// Params 0
// Size: 0x65, Type: bool
function ammo_cache_used()
{
    if ( ( !isdefined( self.isjuiced ) || !istrue( self.isjuiced ) ) && ( !isdefined( self.cranked ) || !istrue( self.cranked ) ) && ( !isdefined( self.isjuggernaut ) || !istrue( self.isjuggernaut ) ) && ( !isdefined( self.adrenalinepoweractive ) || !istrue( self.adrenalinepoweractive ) ) && !allassassin_initteamlist_timed( "speed_boost" ) )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x24, Type: bool
function is_custom_suit_valid( var0 )
{
    var1 = isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.suit );
    return isdefined( var0 ) && var1;
}

// Params 0
// Size: 0x29, Type: bool
function ammo_cache_think()
{
    if ( ( !isdefined( self.adrenalinepoweractive ) || !istrue( self.adrenalinepoweractive ) ) && !allassassin_initteamlist_timed( "speed_boost" ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x81
function ammo_manager()
{
    if ( allassassin_initteamlist_timed( "speed_boost" ) )
    {
        if ( isdefined( level.ref_12838 ) && isdefined( level.ref_12838.area1_targets ) )
        {
            foreach ( var1 in level.ref_12838.area1_targets )
            {
                if ( var1.ref_138fd == "speed_boost" )
                {
                    var2 = _keypadscriptableused_bunkeralt::ref_1249c( var1.ref_138fd );
                    
                    if ( isdefined( var2 ) )
                    {
                        var2 thread _keypadscriptableused_bunkeralt::isempdamage();
                    }
                }
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x44, Type: bool
function allassassin_initteamlist_timed( var0 )
{
    if ( !isdefined( level.ref_12838 ) || !isdefined( level.ref_12838.applyquest ) )
    {
        return false;
    }
    
    var1 = level.ref_12838.applyquest[ var0 ];
    
    if ( isdefined( var1 ) && scripts\engine\utility::array_contains( var1, self ) )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x28
function ref_143cc( var0, var1 )
{
    var2 = spawnstruct();
    thread ref_143cd( var2, var0 );
    thread scripts\engine\utility::waittill_timeout_proc( var2, var1 );
    var2 waittill( "waittill_proc", var3 );
    return var3;
}

// Params 2
// Size: 0x1d
function ref_143cd( var0, var1 )
{
    var0 endon( "waittill_proc" );
    self waittill( var1, var2 );
    var0 notify( "waittill_proc", var2 );
}

