
// Params 0
// Size: 0xc9
function init()
{
    if ( !isenabled() )
    {
        return;
    }
    
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚ = spawnstruct();
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢H‰sÁ;“8Xÿ€&.ñ = [];
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû = [];
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.‡×sÊ‡GõX,K±°ÄÊ¾– = 0;
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.²ßkÃ¾Œ-æÁÊ¹¹²F = getdvarint( "scr_plunder_dispenser_max_dispensed", 0 );
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¾ß"ØÀ‡b(ïdyÅˆáÓıĞzëf&' = getdvarint( "scr_plunder_dispenser_min_restart_delay_sec", 0 );
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.ºÁ=æ¨R¢c:’C	·)ã‹ = getdvarint( "scr_plunder_dispenser_max_restart_delay_sec", 0 );
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.‡§×˜1WÂ—o¢ö›º = getdvarfloat( "scr_plunder_dispenser_percent_spawn", 1 );
    scripts\engine\scriptable::scriptable_addusedcallback( &scriptable_used );
    scripts\engine\scriptable::ref_12f57( &scriptable_used );
    scripts\mp\gametypes\br_pickups::registerpickupremovedforspacecallback( &removed_for_space );
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.conf_fx[ "sparks" ] = loadfx( "vfx/iw8_br/gameplay/vfx_sparks_atm.vfx" );
}

// Params 0
// Size: 0x1f, Type: bool
function isenabled()
{
    if ( getdvarint( "scr_broken_atm_disabled", 1 ) )
    {
        return false;
    }
    
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return false;
    }
    
    return true;
}

// Params 3
// Size: 0x53
function registerandstartupdatingdispenser( var0, var1, var2 )
{
    var0.´~Çğ@¨‚ø/Wsc• = level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.‡×sÊ‡GõX,K±°ÄÊ¾–;
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.‡×sÊ‡GõX,K±°ÄÊ¾–++;
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢H‰sÁ;“8Xÿ€&.ñ[ var0.´~Çğ@¨‚ø/Wsc• ] = [];
    var0 setscriptablepartstate( "broken_atm", "disabled" );
    thread dispenser_spawn_plunder( var0, var1 );
}

// Params 0
// Size: 0x95
function onprematchdone()
{
    if ( !isenabled() )
    {
        return;
    }
    
    var0 = getentitylessscriptablearrayinradius( "scriptable_broken_atm_scriptable", "classname" );
    var1 = int( var0.size * level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.‡§×˜1WÂ—o¢ö›º );
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.­X¾7É¯XÖ›õƒÆX±Ê2 = scripts\mp\gametypes\br_functional_poi::ai_shooting_watch( var0, var1 );
    var2 = getdvarfloat( "scr_plunder_dispenser_spawn_plunder_interval_seconds", 5 );
    var3 = getdvarint( "scr_plunder_dispenser_spawned_plunder_limit", 3 );
    
    foreach ( var5 in level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.­X¾7É¯XÖ›õƒÆX±Ê2 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        registerandstartupdatingdispenser( var5, var2, var3 );
    }
}

// Params 4
// Size: 0x26
function dispenser_create( var0, var1, var2, var3 )
{
    if ( !isenabled() )
    {
        return;
    }
    
    var4 = easepower( "broken_atm_scriptable", var0, var1 );
    registerandstartupdatingdispenser( var4, var2, var3 );
    return var4;
}

// Params 2
// Size: 0x352
function dispenser_spawn_plunder( var0, var1 )
{
    level endon( "game_ended" );
    level endon( "force_end" );
    var2 = getdvarfloat( "scr_plunder_dispenser_roundstart_wait_seconds", 0 );
    
    if ( var2 > 0 )
    {
        wait var2;
    }
    
    self setscriptablepartstate( "broken_atm", "visible" );
    var3 = self.angles[ 1 ];
    level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ] = [ var3 ];
    
    if ( var1 > 1 )
    {
        var4 = 360 / var1;
        
        for ( var5 = 1; var5 < var1 ; var5++ )
        {
            var6 = var3 + var4;
            var3 = scripts\engine\utility::ter_op( var6 > 360, var6 - 360, var6 );
            level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ] = scripts\engine\utility::array_add( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ], var3 );
        }
    }
    
    var7 = 1;
    var8 = 0;
    var9 = 0;
    
    for ( ;; )
    {
        wait var0;
        var10 = level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢H‰sÁ;“8Xÿ€&.ñ[ self.´~Çğ@¨‚ø/Wsc• ].size;
        
        if ( var10 >= var1 )
        {
            continue;
        }
        
        if ( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.²ßkÃ¾Œ-æÁÊ¹¹²F > 0 && var8 >= level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.²ßkÃ¾Œ-æÁÊ¹¹²F )
        {
            if ( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¾ß"ØÀ‡b(ïdyÅˆáÓıĞzëf&' > 0 || level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.ºÁ=æ¨R¢c:’C	·)ã‹ > 0 )
            {
                if ( var9 == 0 )
                {
                    var11 = randomintrange( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¾ß"ØÀ‡b(ïdyÅˆáÓıĞzëf&', level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.ºÁ=æ¨R¢c:’C	·)ã‹ );
                    var9 = gettime() + var11 * 1000;
                    continue;
                }
                else if ( var9 < gettime() )
                {
                    var9 = 0;
                    var8 = 0;
                    var7 = 1;
                    self setscriptablepartstate( "broken_atm", "visible" );
                }
                else
                {
                    continue;
                }
            }
            else
            {
                return;
            }
        }
        
        var12 = isdefined( level.br_plunder ) && isdefined( level.br_plunder.ref_12954 ) && level.br_plunder.ref_12954.size > 0;
        
        if ( !var12 )
        {
            continue;
        }
        
        var13 = level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ][ level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ].size - 1 ];
        level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ] = scripts\engine\utility::array_remove_index( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ], level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ].size - 1 );
        var14 = int( clamp( getdvarint( "scr_plunder_dispenser_spawned_plunder_rarity_index", 4 ), 0, level.br_plunder.ref_12954.size - 1 ) );
        var15 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        var16 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var15, self.origin, self.angles, undefined, var13 );
        var17 = scripts\mp\gametypes\br_pickups::spawnpickup( level.br_plunder.names[ var14 ], var16, level.br_plunder.ref_12954[ var14 ], 1 );
        var18 = scripts\mp\gametypes\br_public::shouldusegoldbarassets();
        var19 = "br_drop_plunder_";
        var20 = "cash";
        
        if ( var18 )
        {
            var20 = "gold";
        }
        
        playsoundatpos( self.origin, var19 + var20 );
        
        if ( isdefined( var17 ) )
        {
            var17.´~Çğ@¨‚ø/Wsc• = self.´~Çğ@¨‚ø/Wsc•;
            var17.¶yÃ¸[Ç½™ = var13;
            level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢H‰sÁ;“8Xÿ€&.ñ[ self.´~Çğ@¨‚ø/Wsc• ] = scripts\engine\utility::array_add( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢H‰sÁ;“8Xÿ€&.ñ[ self.´~Çğ@¨‚ø/Wsc• ], var17 );
            var8++;
        }
        
        if ( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.²ßkÃ¾Œ-æÁÊ¹¹²F > 0 && var8 >= level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.²ßkÃ¾Œ-æÁÊ¹¹²F && var7 )
        {
            var7 = 0;
            self setscriptablepartstate( "broken_atm", "disabled" );
        }
    }
}

// Params 5
// Size: 0x5a
function scriptable_used( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var0.´~Çğ@¨‚ø/Wsc• ) )
    {
        if ( isdefined( level.br_plunder ) && isdefined( level.br_plunder.ref_127bf ) && isdefined( var3 ) && isdefined( var3.plundercount ) && var3.plundercount >= level.br_plunder.ref_127bf )
        {
            return;
        }
        
        removeinstacefromplunderdata( var0 );
        return;
    }
}

// Params 0
// Size: 0x11
function removed_for_space()
{
    if ( isdefined( self.´~Çğ@¨‚ø/Wsc• ) )
    {
        removeinstacefromplunderdata();
        return;
    }
}

// Params 0
// Size: 0x8f
function removeinstacefromplunderdata()
{
    if ( isdefined( self.´~Çğ@¨‚ø/Wsc• ) )
    {
        if ( isdefined( self.¶yÃ¸[Ç½™ ) )
        {
            if ( !scripts\engine\utility::array_contains( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ], self.¶yÃ¸[Ç½™ ) )
            {
                level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ] = scripts\engine\utility::array_add_safe( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢@Çëb£à	ë8x¯!Û÷z—F]Ãû[ self.´~Çğ@¨‚ø/Wsc• ], self.¶yÃ¸[Ç½™ );
            }
        }
        
        level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢H‰sÁ;“8Xÿ€&.ñ[ self.´~Çğ@¨‚ø/Wsc• ] = scripts\engine\utility::array_remove( level.ˆCqüÓøµ[áò—wh­[Óí‹1ğ{‚.¢H‰sÁ;“8Xÿ€&.ñ[ self.´~Çğ@¨‚ø/Wsc• ], self );
        return;
    }
}

