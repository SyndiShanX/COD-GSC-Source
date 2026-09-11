
// Params 0
// Size: 0x49
function init()
{
    level.delete_pipe_ents = spawnstruct();
    level.delete_pipe_ents.scriptables = [];
    level.í≥Ì'Î¬»Œw=ÄCx¿Ë|cc=ãI3Êœ = getdvarint( "scr_br_maxPortableKiosksPerTeam", 2 );
    level.ãƒ£†z◊V˚j¢ç%Ù¿/≥õ7h≈ª˜– = getdvarint( "scr_br_maxPortableKiosksGlobal", 20 );
    level._effect[ "vfx_br3_pbs_dmg" ] = loadfx( "vfx/iw8_br/island/gameplay/vfx_br3_pbs_dmg.vfx" );
}

// Params 1
// Size: 0xa0
function wait_between_combat_action( var0 )
{
    var1 = self;
    var1 endon( "disconnect" );
    var1 endon( "grenade_OOB" );
    var0 endon( "explode_end" );
    var0 thread scripts\mp\utility\script::notifyafterframeend( "death", "explode_end" );
    thread vfx_htown_hadirj_blink( var1 );
    thread wait_between_stations( var1 );
    var0 waittill( "explode", var2 );
    var1 notify( "kiosk_drop_finished" );
    thread wait_at_station( var2 );
    
    if ( scripts\mp\outofbounds::ispointinoutofbounds( var2 ) )
    {
        if ( isdefined( var0 ) )
        {
            var0 delete();
        }
        
        if ( isdefined( var1.super ) )
        {
            var1 scripts\mp\supers::superusefinished( 1 );
        }
        
        return;
    }
    
    ref_1366a( var1, var2 );
    
    if ( isdefined( var1.super ) )
    {
        var1 scripts\mp\supers::superusefinished( undefined, undefined, undefined, 1 );
        return;
    }
}

// Params 1
// Size: 0xe2
function ref_1366a( var0 )
{
    cleanupallbutxkiosksforteam( self.team );
    manageglobalkioskcount();
    var1 = 4096;
    
    if ( istrue( self.umbra ) )
    {
        var1 = 10000;
    }
    
    var2 = spawn( "script_model", var0 + ( 0, 0, var1 ) );
    var2 setmodel( "lm_buy_station_crate_wood_01_ww2" );
    var2 physicslaunchserver();
    var2 setscriptablepartstate( "br_plunder_box", "visible", 0 );
    scripts\mp\gametypes\br_pickups::ref_12b3a( var2 );
    var2.visible = 1;
    var2.õ;+BõG€‰êÁpèsÏ = 1;
    var2.managerespawnfade = 1;
    var2.team = self.team;
    level.delete_pipe_ents.scriptables[ level.delete_pipe_ents.scriptables.size ] = var2;
    thread ref_11cfe();
    thread ref_11d0b();
    thread ref_11d17();
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
    {
        level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "used_airdrop", self );
        return;
    }
}

// Params 1
// Size: 0x8f
function cleanupallbutxkiosksforteam( var0 )
{
    var1 = [];
    
    foreach ( var3 in level.delete_pipe_ents.scriptables )
    {
        if ( !isdefined( var3 ) || !isdefined( var3.team ) || var3.team != var0 )
        {
            continue;
        }
        
        var1 = var3;
    }
    
    var5 = var1.size - level.í≥Ì'Î¬»Œw=ÄCx¿Ë|cc=ãI3Êœ - 1;
    
    if ( var5 <= 0 )
    {
        return;
    }
    
    for ( var6 = var5 - 1; var6 >= 0 ; var6-- )
    {
        var7 = var1[ var6 ];
        destroyportablekiosk( var7 );
    }
}

// Params 0
// Size: 0x2b
function manageglobalkioskcount()
{
    if ( level.delete_pipe_ents.scriptables.size >= level.ãƒ£†z◊V˚j¢ç%Ù¿/≥õ7h≈ª˜– )
    {
        destroyportablekiosk( level.delete_pipe_ents.scriptables[ 0 ] );
        return;
    }
}

// Params 2
// Size: 0x7f
function dangercircletick( var0, var1 )
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "kiosk" ) || getdvarint( "scr_br_kiosk_ignore_circle", 0 ) == 1 )
    {
        return;
    }
    
    var2 = var1 * var1;
    
    foreach ( var4 in level.delete_pipe_ents.scriptables )
    {
        if ( isdefined( var4.visible ) && isdefined( var4.origin ) && distance2dsquared( var4.origin, var0 ) > var2 )
        {
            destroyportablekiosk( var4 );
        }
    }
}

// Params 1
// Size: 0x83
function destroyportablekiosk( var0 )
{
    var0 setscriptablepartstate( "br_plunder_box", "disabled" );
    var0.visible = undefined;
    var0.disabled = 1;
    var0 notify( "portableKiosk_disabled" );
    
    if ( var0 scripts\mp\gametypes\br_quest_util::gethelispawns() )
    {
        var0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
    }
    
    playfx( scripts\engine\utility::getfx( "vfx_br3_pbs_dmg" ), var0.origin );
    playsoundatpos( var0.origin, "mp_equip_destroyed" );
    level.delete_pipe_ents.scriptables = scripts\engine\utility::array_remove( level.delete_pipe_ents.scriptables, var0 );
    var0 delete();
}

// Params 0
// Size: 0xcd
function ref_11d17()
{
    ref_11d18();
    self endon( "death" );
    self endon( "monitorPlayerImpactEnd" );
    var0 = self;
    
    if ( isdefined( self.mountmantlemodel ) )
    {
        var0 = self.mountmantlemodel;
    }
    
    var1 = undefined;
    jumpiffalse(isdefined( self.owner )) LOC_00000038;
    var1 = self.owner;
    
    while ( isdefined( var0 ) )
    {
        var0 waittill( "player_pushed", var2, var3 );
        
        if ( isdefined( var2 ) && ( isplayer( var2 ) || isagent( var2 ) ) && var2 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            var4 = var3[ 2 ] <= -8;
            var5 = 0;
            var6 = undefined;
            
            if ( var2 tagexists( "j_mainroot" ) )
            {
                var6 = var2 gettagorigin( "j_mainroot" );
                var7 = self.origin + anglestoup( self.angles ) * 27.5;
                var5 = var6[ 2 ] <= var7[ 2 ];
            }
            
            if ( var4 && var5 )
            {
                var8 = var1;
                
                if ( !isdefined( var8 ) )
                {
                    var8 = var2;
                }
            }
        }
    }
}

// Params 0
// Size: 0xa
function ref_11d18()
{
    self notify( "monitorPlayerImpactEnd" );
}

// Params 4
// Size: 0x5b
function ref_1273b( var0, var1, var2, var3 )
{
    playfx( scripts\engine\utility::getfx( "airdrop_crate_impact" ), var0, var1 );
    
    if ( var2 < 150 )
    {
        self playsurfacesound( "mp_care_package_low_impact", var3 );
    }
    else if ( var2 < 300 )
    {
        self playsurfacesound( "mp_care_package_med_impact", var3 );
    }
    else
    {
        self playsurfacesound( "mp_care_package_high_impact", var3 );
    }
    
    self stoploopsound( "mp_care_package_drop_lp" );
}

// Params 0
// Size: 0x129
function ref_11cfe()
{
    self endon( "death" );
    self notify( "monitorAverageVelocityAndUpdate" );
    self endon( "monitorAverageVelocityAndUpdate" );
    var0 = 0.1;
    thread scripts\cp_mp\killstreaks\airdrop::ref_11cfd( var0, 8 );
    var1 = 0;
    var2 = 0;
    var3 = undefined;
    var4 = undefined;
    jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "lpcFeatureGated" )) LOC_00000055;
    var4 = scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "lpcFeatureGated" );
    
    for ( ;; )
    {
        var5 = scripts\cp_mp\killstreaks\airdrop::registeronplayerjointeamnospectatorcallback();
        var6 = scripts\cp_mp\killstreaks\airdrop::registeronplayerdisconnect();
        
        if ( isdefined( var5 ) && isdefined( var6 ) )
        {
            if ( var5 <= 5 && var6 <= 1 )
            {
                var1++;
                var2 = 0;
                
                if ( var1 == 6 )
                {
                    self.ref_12332 = 1;
                    var3 = self.origin;
                    
                    if ( isdefined( var4 ) && [[ var4 ]]() )
                    {
                        ref_11d0c();
                        
                        if ( isdefined( self.killcament ) )
                        {
                            self.killcament delete();
                        }
                    }
                    
                    var0 = 0.1;
                    thread scripts\cp_mp\killstreaks\airdrop::ref_11cfd( var0, 3, 3 );
                }
            }
            else
            {
                if ( isdefined( var3 ) )
                {
                    if ( distancesquared( self.origin, var3 ) <= 2500 )
                    {
                        wait var0;
                        continue;
                    }
                }
                
                var2++;
                var1 = 0;
                
                if ( var2 == 1 )
                {
                    self.ref_12332 = undefined;
                    var0 = 0.1;
                    thread scripts\cp_mp\killstreaks\airdrop::ref_11cfd( var0, 8 );
                }
            }
            
            wait var0;
            continue;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x39
function ref_11d0b( var0 )
{
    ref_11d0c();
    self endon( "monitorImpactEnd" );
    self.ref_11d0e = 1;
    self playloopsound( "mp_care_package_drop_lp" );
    self physics_registerforcollisioncallback();
    ref_11d0d( var0 );
    
    if ( isdefined( self ) )
    {
        thread ref_11d0c();
        return;
    }
}

// Params 1
// Size: 0xb0
function ref_11d0d( var0 )
{
    self endon( "death" );
    
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    var1 = 0;
    
    for ( ;; )
    {
        self waittill( "collision", var2, var3, var4, var5, var6, var7, var8, var9 );
        
        if ( isdefined( var9 ) && scripts\cp_mp\killstreaks\airdrop::start_chants_on_movement( var9 ) )
        {
            if ( var9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks() )
            {
                var9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
            }
        }
        
        if ( gettime() - var1 >= 2 )
        {
            var1 = gettime();
            var10 = physics_getsurfacetypefromflags( var5 );
            var11 = getsubstr( var10[ "name" ], 9 );
            
            if ( var11 == "user_terrain1" )
            {
                var11 = "user_terrain_1";
            }
            
            if ( var11 == "user_terrain5" )
            {
                var11 = "user_terrain_5";
            }
            
            ref_1273b( var6, var7, var8, var11 );
        }
    }
}

// Params 0
// Size: 0x29
function ref_11d0c()
{
    if ( !istrue( self.ref_11d0e ) )
    {
        return;
    }
    
    self notify( "monitorImpactEnd" );
    self.ref_11d0e = undefined;
    self stoploopsound( "mp_care_package_drop_lp" );
    self physics_unregisterforcollisioncallback();
}

// Params 1
// Size: 0x31
function vfx_htown_hadirj_blink( var0 )
{
    var1 = self;
    var1 endon( "disconnect" );
    var0 endon( "explode" );
    var0 endon( "explode_end" );
    wait 10;
    
    if ( isdefined( var0 ) )
    {
        var0 delete();
    }
    
    var1 notify( "grenade_OOB" );
}

// Params 1
// Size: 0x33
function wait_between_stations( var0 )
{
    var1 = self;
    var1 endon( "disconnect" );
    var1 endon( "kiosk_drop_finished" );
    var0 waittill( "death" );
    waitframe();
    
    if ( isdefined( var1.super ) )
    {
        var1 scripts\mp\supers::superusefinished( 1 );
        return;
    }
}

// Params 1
// Size: 0x38
function wait_at_station( var0 )
{
    var1 = spawn( "script_origin", var0 );
    var1 playloopsound( "smoke_carepackage_smoke_lp" );
    wait 21;
    var1 playsound( "smoke_canister_tail_dissipate" );
    var1 stoploopsound( "smoke_carepackage_smoke_lp" );
    wait 5;
    var1 delete();
}

