
// Params 0
// Size: 0xbf
function init()
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "init" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "init" ) ]]();
    }
    
    level._effect[ "airstrike_tracer" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_a10_tracer_sep.vfx" );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "airstrike_params" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "airstrike_params" ) ]]();
    }
    
    init_airstrike_flyby_anims();
    init_airstrike_vo();
    level.audio_heli_fade_up = [];
    level.brareloadoutdropbagsdelayed = 0;
    level.ƒ@ž|ÃšmÀB-ãç*¿»Œó‹`Ü = getdvarint( "scr_br_airstrike_default_side", 1 );
    level.²þÙk(bþàbŠKVoÚÿB)X = getdvarint( "scr_br_airstrike_use_scoring", 1 );
    level.—üÂ´N7èN-µ+Œ7Ù¬Éœ°¥®æ = getdvarint( "scr_br_airstrike_danger_radius", 1000 );
    level.º‘w
S}ºïJÄ˜øB_‹Â»‡ðër~ = getdvarint( "scr_br_airstrike_danger_center", 0 );
    level.²/(²ºÏ£ûQŠõ4ß¨¿'«¨8J•ØÛEŽ = getdvarint( "scr_br_airstrike_danger_sites", 1 );
}

#using_animtree( "" );

// Params 0
// Size: 0xe0
function init_airstrike_flyby_anims()
{
    var0 = %mp_alfa10_flyin;
    var1 = "mp_alfa10_flyin";
    
    if ( scripts\cp_mp\utility\game_utility::ref_140aa() )
    {
        var0 = $mp_alfa10_flyin_br;
        var1 = "mp_alfa10_flyin_br";
    }
    
    level.scr_animtree[ "precision_airstrike" ] = #animtree;
    level.scr_anim[ "precision_airstrike" ][ "airstrike_flyby" ] = var0;
    level.scr_animname[ "precision_airstrike" ][ "airstrike_flyby" ] = var1;
    level.scr_animtree[ "multi_airstrike" ] = #animtree;
    level.scr_anim[ "multi_airstrike" ][ "airstrike_flyby" ] = %mp_alfa10_flyin;
    level.scr_animname[ "multi_airstrike" ][ "airstrike_flyby" ] = "mp_alfa10_flyin";
    level.scr_animtree[ "fuel_airstrike" ] = #animtree;
    level.scr_anim[ "fuel_airstrike" ][ "airstrike_flyby" ] = %mp_alfa10_flyin;
    level.scr_animname[ "fuel_airstrike" ][ "airstrike_flyby" ] = "mp_alfa10_flyin";
}

// Params 0
// Size: 0x28
function init_airstrike_vo()
{
    game[ "dialog" ][ "airstrike_good_hit" ] = "precision_airstrike_hit";
    game[ "dialog" ][ "airstrike_bad_hit" ] = "precision_airstrike_miss";
}

// Params 1
// Size: 0xca, Type: bool
function weapongivenairstrike( var0 )
{
    var1 = getdvarint( "scr_airstrike_type", 2 );
    var2 = branalytics_secondwind( self.origin );
    
    if ( var2 != "success" )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var2 );
        }
        
        return false;
    }
    
    if ( var0.streakname == "multi_airstrike" )
    {
        var3 = 1;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "startMapSelectSequence" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "startMapSelectSequence" ) ]]( 0, 1, var3 );
        }
    }
    else if ( var0.streakname == "fuel_airstrike" )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "startMapSelectSequence" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "startMapSelectSequence" ) ]]();
        }
    }
    
    return true;
}

// Params 2
// Size: 0x45
function weaponswitchendedairstrike( var0, var1 )
{
    var2 = getdvarint( "scr_airstrike_type", 2 );
    
    if ( istrue( var1 ) )
    {
        if ( var0.streakname == "precision_airstrike" )
        {
            if ( var2 == 1 )
            {
                self laseron();
                return;
            }
            
            if ( var2 == 2 )
            {
                thread airstrike_watchforads( var0 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x132
function weaponfiredairstrike( var0, var1, var2 )
{
    if ( !isdefined( var0.ref_13a81 ) )
    {
        var3 = airstrike_getownerlookatpos( self );
        var4 = branalytics_secondwind( var3 );
        
        if ( var4 != "success" )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var4 );
            }
            
            return "continue";
        }
    }
    
    if ( isdefined( level.gametype ) )
    {
        if ( level.gametype == "br" && isdefined( self.scrambledby ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "MP_BR_INGAME_TU_WZ335/JAMMED" );
            }
            
            return "continue";
        }
    }
    
    if ( scripts\cp_mp\emp_debuff::is_empd() )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/CANNOT_BE_USED" );
        }
        
        return "continue";
    }
    
    var5 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "sound", "playKillstreakDeployDialog" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "sound", "playKillstreakDeployDialog" ) ]]( self, var0.streakname );
        var5 = 2;
    }
    
    thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "use_" + var0.streakname, 1, var5 );
    return "success";
}

// Params 1
// Size: 0x14
function tryuseairstrike( var0 )
{
    var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( var0, self );
    return tryuseairstrikefromstruct( var1 );
}

// Params 1
// Size: 0x164, Type: bool
function tryuseairstrikefromstruct( var0 )
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
    
    var1 = undefined;
    var2 = level.airstrikesettings[ var0.streakname ].deployweaponobj;
    
    switch ( var0.streakname )
    {
        case "precision_airstrike":
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
            {
                var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]();
                
                if ( var3 == "br" && isdefined( self.waitandunloadinfils ) )
                {
                    var0.ref_13a81 = self.waitandunloadinfils;
                    self.waitandunloadinfils = undefined;
                }
            }
            
            if ( isdefined( var0.ref_13a81 ) )
            {
                var4 = weaponfiredairstrike( var0, undefined, undefined );
                var1 = var4 == "success";
            }
            else
            {
                var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy( var0, var2, "weapon_fired", &weapongivenairstrike, &weaponswitchendedairstrike, &weaponfiredairstrike );
            }
            
            break;
        case "multi_airstrike":
        case "fuel_airstrike":
            var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy( var0, var2, 1, &weapongivenairstrike, &weaponswitchendedairstrike );
            break;
    }
    
    if ( !istrue( var1 ) )
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
    
    var5 = selectairstrikelocation( var0 );
    
    if ( !istrue( var5 ) )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "munitionUsed" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "munitionUsed" ) ]]();
    }
    
    return true;
}

// Params 1
// Size: 0x2b9, Type: bool
function selectairstrikelocation( var0 )
{
    var1 = ( 0, 0, 0 );
    var2 = undefined;
    var3 = undefined;
    var4 = undefined;
    var5 = spawn( "script_origin", self.origin );
    var6 = "used_" + var0.streakname;
    
    if ( var0.streakname == "precision_airstrike" )
    {
        if ( isdefined( var0.ref_13a81 ) )
        {
            var1 = var0.ref_13a81;
        }
        else
        {
            var1 = airstrike_getownerlookatpos( self, 1 );
        }
    }
    else if ( var0.streakname == "multi_airstrike" )
    {
        var7 = 3;
        var4 = 1;
        scripts\common\utility::allow_weapon_switch( 0 );
        self setsoundsubmix( "mp_killstreak_overlay" );
        var2 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "getSelectMapPoint" ) )
        {
            var2 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "getSelectMapPoint" ) ]]( var0, var7, 1 );
        }
        
        scripts\common\utility::allow_weapon_switch( 1 );
    }
    else if ( var0.streakname == "fuel_airstrike" )
    {
        var7 = 3;
        scripts\common\utility::allow_weapon_switch( 0 );
        self setsoundsubmix( "mp_killstreak_overlay" );
        var2 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "getSelectMapPoint" ) )
        {
            var2 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "getSelectMapPoint" ) ]]( var0, var7 );
        }
        
        scripts\common\utility::allow_weapon_switch( 1 );
    }
    
    if ( isdefined( var2 ) )
    {
        var8 = branalytics_secondwind( var2 );
        
        if ( var8 != "success" )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var8 );
            }
            
            return false;
        }
        
        thread finishmapselectairstrikeusage( var2, var4, var1, var3, var0 );
        self clearsoundsubmix( "mp_killstreak_overlay" );
    }
    else if ( !isdefined( var2 ) && ( var0.streakname == "multi_airstrike" || var0.streakname == "fuel_airstrike" ) )
    {
        if ( isdefined( var5 ) )
        {
            var5 stoploopsound( "" );
            var5 delete();
        }
        
        self clearsoundsubmix( "mp_killstreak_overlay" );
        return false;
    }
    else if ( var0.streakname == "precision_airstrike" )
    {
        thread finishstandardairstrikeusage( var1, var3, var0 );
    }
    
    if ( isdefined( var5 ) )
    {
        var5 stoploopsound( "" );
        var5 delete();
    }
    
    var0 notify( "killstreak_finished_with_deploy_weapon" );
    self notify( "successful_fire" );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
    {
        GscBinSkip1( 0x74, scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "teamPlayerCardSplash" ), var6, self );
        // Unknown operator ( 0x74, iw8, PC )
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "logKillstreakEvent" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "logKillstreakEvent" ) ]]( var0.streakname, var1 );
    }
    
    if ( level.gametype == "br" && level.º‘w
S}ºïJÄ˜øB_‹Â»‡ðër~ )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "dangerNotifyPlayersInRange" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "dangerNotifyPlayersInRange" ) ]]( var1, level.—üÂ´N7èN-µ+Œ7Ù¬Éœ°¥®æ, var0.streakname );
        }
    }
    
    return true;
}

// Params 5
// Size: 0x13b
function finishmapselectairstrikeusage( var0, var1, var2, var3, var4 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var5 = level.scr_anim[ var4.streakname ][ "airstrike_flyby" ];
    var6 = getanimlength( var5 );
    var7 = scripts\engine\utility::get_notetrack_time( var5, "attack" );
    var8 = branalytics_respawn( self.origin, self );
    thread airstrike_watchkills( var7 * 2, var8 );
    thread watchairstrikeowner( var8 );
    thread branalytics_teameliminated( var4, var8 );
    
    foreach ( var10 in var0 )
    {
        var2 = var10.location;
        var11 = self.angles[ 1 ];
        
        if ( istrue( var1 ) )
        {
            var11 = var10.angles;
        }
        
        finishairstrikeusage( var2, var11, var3, var4, var5, var8 );
        
        if ( var0.size > 1 && var12 < var0.size - 1 )
        {
            wait randomfloatrange( 0.8, 1 );
        }
    }
    
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var6 );
    
    if ( isdefined( level.killstreakfinishusefunc ) )
    {
        level thread [[ level.killstreakfinishusefunc ]]( var4 );
    }
    
    branalytics_seteventdelayedstate( self, var8 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "printGameAction" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "printGameAction" ) ]]( "killstreak ended - " + var4.streakname, self );
    }
    
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var4 );
}

// Params 3
// Size: 0xc8
function finishstandardairstrikeusage( var0, var1, var2 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var3 = level.scr_anim[ var2.streakname ][ "airstrike_flyby" ];
    var4 = getanimlength( var3 );
    var5 = scripts\engine\utility::get_notetrack_time( var3, "attack" );
    var6 = branalytics_respawn( var0, self );
    thread airstrike_watchkills( var5 * 2, var6 );
    thread watchairstrikeowner( var6 );
    thread branalytics_teameliminated( var2, var6 );
    finishairstrikeusage( var0, undefined, var1, var2, var3, var6 );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var4 );
    
    if ( isdefined( level.killstreakfinishusefunc ) )
    {
        level thread [[ level.killstreakfinishusefunc ]]( var2 );
    }
    
    branalytics_seteventdelayedstate( self, var6 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "printGameAction" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "printGameAction" ) ]]( "killstreak ended - " + var2.streakname, self );
    }
    
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var2 );
}

// Params 6
// Size: 0x31
function finishairstrikeusage( var0, var1, var2, var3, var4, var5 )
{
    self notify( "used" );
    self notify( "airstrike_used" );
    doairstrike( var0, var1, self, self.pers[ "team" ], var2, var3, var4, var5 );
}

// Params 8
// Size: 0x1b
function doairstrike( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    thread callstrike( level, var2, var0, var1, var4, var5, var6 );
}

// Params 1
// Size: 0x2c
function watchairstrikeowner( var0 )
{
    self endon( "airstrike_finished_" + var0 );
    level endon( "game_ended" );
    scripts\engine\utility::ref_143a5( "disconnect", "joined_team" );
    branalytics_seteventdelayedstate( self, var0 );
}

// Params 7
// Size: 0x12f
function callstrike( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = 0;
    var8 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    var9 = 24000;
    var10 = 6500;
    var11 = 2500;
    var7 = 1500;
    
    if ( isdefined( var8 ) )
    {
        var11 = var8.origin[ 2 ];
    }
    
    var12 = scripts\cp_mp\utility\game_utility::getlocaleid();
    
    if ( isdefined( var12 ) && var12 == "locale_6" )
    {
        var11 += 500;
    }
    
    if ( level.mapname == "mp_br_mechanics" || scripts\cp_mp\utility\game_utility::unlink_on_ai_death() )
    {
        var11 += 2500;
    }
    
    var7 = getexplodedistance( var11 );
    var14 = undefined;
    var15 = undefined;
    
    if ( isdefined( var2 ) )
    {
        var14 = ( 0, var2, 0 );
    }
    else
    {
        var14 = callstrike_findoptimaldirection( var0, var1, var11 );
        var15 = 1;
    }
    
    var16 = getflightpath( var1, var14, var9, var8, var11, var10, var7, var4.streakname, var15 );
    
    if ( var4.streakname == "precision_airstrike" )
    {
        for ( var17 = 0; var17 < 2 ; var17++ )
        {
            var11 += randomintrange( 200, 300 );
            thread doplanestrike( level, var1, var16[ "startPoint" ], var16[ "endPoint" ], var11, var3, var4, var5, var0 );
            wait 3;
        }
        
        return;
    }
    
    thread doplanestrike( level, var1, var16[ "startPoint" ], var16[ "endPoint" ], var11, var3, var4, var5, var0 );
}

// Params 3
// Size: 0x209
function callstrike_findoptimaldirection( var0, var1, var2 )
{
    var3 = anglestoforward( var0 getplayerangles() );
    var4 = scripts\engine\trace::create_default_contents( 1 );
    var5 = scripts\engine\trace::ray_trace( var1 - var3 * 30, var1 + var3 * 1000, undefined, var4 );
    var1 = var5[ "position" ] + var5[ "normal" ] * 20;
    var6 = var1;
    var7 = var2 * 3;
    var8 = anglestoforward( var0.angles );
    var9 = anglestoright( var0.angles );
    var10 = 0;
    var11 = [ var6 + var8 * 100, var6 - var8 * 100, var6 + var9 * 100, var6 - var9 * 100, var6 + ( var8 + var9 ) * 100, var6 + ( var8 - var9 ) * 100, var6 + ( var9 - var8 ) * 100, var6 + ( -1 * var8 - var9 ) * 100 ];
    
    if ( level.gametype == "br" && level.ƒ@ž|ÃšmÀB-ãç*¿»Œó‹`Ü )
    {
        var12 = vectornormalize( var11[ 2 ] - var6 );
    }
    else
    {
        var12 = vectornormalize( var12[ 0 ] - var7 );
    }
    
    var13 = 0;
    var14 = 0;
    
    foreach ( var16 in var12 )
    {
        var17 = vectornormalize( var16 - var7 );
        var18 = var7 + ( 0, 0, var8 ) - var17 * 25000;
        var19 = [ var7, var7 - var17 * 512, var7 - var17 * 256, var7 + var17 * 256, var7 + var17 * 512 ];
        var20 = 0;
        
        foreach ( var22 in var19 )
        {
            var23 = scripts\engine\trace::ray_trace( var18, var22, undefined, var5 );
            var24 = var23[ "fraction" ] == 1;
            
            if ( level.gametype == "br" && level.²þÙk(bþàbŠKVoÚÿB)X )
            {
                if ( var23[ "fraction" ] > var14 )
                {
                    var12 = var17;
                    var14 = var23[ "fraction" ];
                }
            }
            
            if ( !istrue( var24 ) )
            {
                wait 0.05;
                break;
            }
            
            var20++;
            wait 0.05;
        }
        
        if ( var20 > var13 )
        {
            var12 = var17;
            var13 = var20;
            
            if ( var20 >= 3 )
            {
                break;
            }
        }
    }
    
    return var12;
}

// Params 2
// Size: 0x38
function ref_144b7( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "air_strike_complete" );
    var1 waittill( "disconnect" );
    
    if ( isdefined( var0.player_waittilljumpedfromc130 ) )
    {
        var0.player_waittilljumpedfromc130 delete();
    }
    
    ref_123ae( var0 );
}

// Params 9
// Size: 0x4ec
function doplanestrike( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( !isdefined( var7 ) )
    {
        return;
    }
    
    var7 endon( "disconnect" );
    level endon( "game_ended" );
    var9 = level.airstrikesettings[ var5.streakname ];
    var10 = getanimlength( var6 );
    var11 = scripts\engine\utility::get_notetrack_time( var6, "attack" );
    var12 = var0 + ( 0, 0, var3 );
    var13 = vectornormalize( var2 - var1 );
    var14 = var9.modelbase;
    
    if ( scripts\cp_mp\utility\player_utility::getplayersuperfaction( var7 ) && isdefined( var9.modelbasealt ) )
    {
        var14 = var9.modelbasealt;
    }
    
    var15 = spawn( "script_model", var12 );
    var15 setmodel( var14 );
    var15.angles = vectortoangles( var13 );
    var15.flightdir = var13;
    var15.flightheight = var3;
    var15.owner = var7;
    var16 = istrue( level.vehicle_collision_getleveldata ) && isdefined( level.ref_14603 ) && level.ref_14603 == 6;
    var17 = var16 || istrue( var5.brmini_ontimelimit );
    
    if ( var17 )
    {
        var15.team = "team_ninety_nine";
    }
    else
    {
        var15.team = var7.team;
    }
    
    var15.lifeid = var5.lifeid;
    var15.streakinfo = var5;
    var15.brbonusxpallowed = var8;
    
    if ( !istrue( var5.ref_133de ) )
    {
        var15 setotherent( var7 );
    }
    
    var15 scriptmoveroutline();
    var15 scriptmoverthermal();
    var15 scriptmoverplane();
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "addToActiveKillstreakList" ) )
    {
        var15 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "addToActiveKillstreakList" ) ]]( var5.streakname, "Killstreak_Air", var7, 0, 1, 100 );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "br", "challengeEvaluator" ) )
    {
        var18 = spawnstruct();
        var18.ref_123a1 = var15;
        var18.ref_13a8a = var0;
        var7 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "br", "challengeEvaluator" ) ]]( "br_mastery_pointBlank_airstrike", var18 );
    }
    
    var19 = "icon_minimap_airstrike";
    
    if ( var5.streakname == "fuel_airstrike" )
    {
        var19 = "icon_minimap_fuelairstrike";
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "createObjective" ) )
    {
        var15.minimapid = var15 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "createObjective" ) ]]( var19, var15.team, undefined, 1, 1 );
    }
    
    var20 = var11 - 0.75;
    var21 = var11;
    var22 = 8.596;
    var23 = var20 + var22;
    
    if ( var5.streakname == "fuel_airstrike" )
    {
        var20 = var11 + 1;
    }
    
    if ( !istrue( var5.setuptimelimit ) )
    {
        thread airstrike_playplaneattackfx( level, var15, var20 );
    }
    
    if ( istrue( var5.ref_12186 ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "overridePlayFlyFX" ) )
    {
        level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "overridePlayFlyFX" ) ]]( var15, var1, var13, var21, var22, var10, var5 );
    }
    else
    {
        thread airstrike_playflyfx( level, var15, var1, var13, var21, var22, var10 );
    }
    
    var15.bulletpoint = spawn( "script_model", var15.origin );
    var15.bulletpoint setmodel( "ks_airstrike_target_mp" );
    
    if ( scripts\cp_mp\utility\game_utility::ref_140aa() )
    {
        var15.bulletpoint setmodel( "ks_airstrike_target_br_ch3" );
    }
    
    var15.bulletpoint setentityowner( var7 );
    var15.bulletpoint.weapon_name = "artillery_mp";
    var15.bulletpoint.streakinfo = var5;
    var15.bulletpoint.angles = var15.angles;
    var15.bulletpoint dontinterpolate();
    var15.animname = var5.streakname;
    var15 scripts\common\anim::setanimtree();
    var15.scenenode = spawn( "script_model", var12 );
    var15.scenenode.angles = var15.angles;
    var15.scenenode setmodel( "tag_origin" );
    
    if ( istrue( var5.setuptimelimit ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "harmlessAirstrikeEffect" ) )
        {
            level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "harmlessAirstrikeEffect" ) ]]( var15, var20, var10, var0, var7 );
        }
    }
    else if ( var5.streakname == "precision_airstrike" || var5.streakname == "multi_airstrike" )
    {
        thread callstrike_precisionbulleteffect( level, var15, var20, var10, var0, var7 );
    }
    else if ( var5.streakname == "fuel_airstrike" )
    {
    }
    
    var25 = scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) && [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]() == "br";
    var26 = scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) && [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]() == "brtdm";
    thread ref_144b7( var15, var7 );
    
    if ( var25 || var26 )
    {
        var15.scenenode childthread scripts\common\anim::anim_single_solo( var15, "airstrike_flyby" );
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "postAirstrikeAnim" ) )
        {
            var15 childthread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "postAirstrikeAnim" ) ]]();
        }
        
        wait var23;
    }
    else
    {
        var15.scenenode scripts\common\anim::anim_single_solo( var15, "airstrike_flyby" );
    }
    
    var15 notify( "air_strike_complete" );
    ref_123ae( var15 );
}

// Params 1
// Size: 0xb1
function ref_123ae( var0 )
{
    if ( isdefined( var0.minimapid ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "returnObjectiveID" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "returnObjectiveID" ) ]]( var0.minimapid );
        }
    }
    
    var0 notify( "delete" );
    
    if ( isdefined( var0.turrettarget ) )
    {
        var0.turrettarget delete();
    }
    
    if ( isdefined( var0.bulletpoint ) )
    {
        var0.bulletpoint delete();
        
        if ( isdefined( var0.bulletpoint.killcament ) )
        {
            var0.bulletpoint.killcament delete();
        }
    }
    
    if ( isdefined( var0.scenenode ) )
    {
        var0.scenenode delete();
    }
    
    if ( isdefined( var0 ) )
    {
        var0 delete();
        return;
    }
}

// Params 3
// Size: 0x64
function airstrike_playplaneattackfx( var0, var1, var2 )
{
    var0 endon( "death" );
    level endon( "game_ended" );
    
    if ( var2.streakname == "fuel_airstrike" )
    {
        return;
    }
    
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var1 );
    playsoundatpos( var0.origin, "ks_a10_fire_dist_crack" );
    var0 setscriptablepartstate( "fire", "on", 0 );
    var0 waittill( "fire_finished" );
    var0 setscriptablepartstate( "fire", "off", 0 );
}

// Params 7
// Size: 0xb8
function airstrike_playflyfx( var0, var1, var2, var3, var4, var5, var6 )
{
    var0 endon( "death" );
    level endon( "game_ended" );
    thread airstrike_delayplayscriptable( var0 );
    var0.player_waittilljumpedfromc130 = spawn( "script_model", var1 );
    var0.player_waittilljumpedfromc130 setmodel( "ks_airstrike_mp" );
    
    if ( scripts\cp_mp\utility\game_utility::ref_140aa() )
    {
        var0.player_waittilljumpedfromc130 setmodel( "ks_airstrike_br_ch3" );
    }
    
    var0.player_waittilljumpedfromc130 dontinterpolate();
    thread airstrike_playapproachfx( var0.player_waittilljumpedfromc130 );
    thread airstrike_playflybyfx( var0.player_waittilljumpedfromc130 );
    thread airstrike_playflyoutfx( var0.player_waittilljumpedfromc130 );
    thread airstrike_handleflyoutfxdeath( var0.player_waittilljumpedfromc130 );
    thread branalytics_selfrevive( var0.player_waittilljumpedfromc130 );
}

// Params 1
// Size: 0x29
function airstrike_playapproachfx( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var0 );
    self setscriptablepartstate( "approach", "on", 0 );
}

// Params 1
// Size: 0x29
function airstrike_playflybyfx( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var0 );
    self setscriptablepartstate( "flyby", "on", 0 );
}

// Params 1
// Size: 0x29
function airstrike_playflyoutfx( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var0 );
    self setscriptablepartstate( "flyout", "on", 0 );
}

// Params 1
// Size: 0x21
function airstrike_handleflyoutfxdeath( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var0 + 10 );
    self delete();
}

// Params 1
// Size: 0x33
function branalytics_selfrevive( var0 )
{
    self endon( "death" );
    self endon( "stop_update_fx_movement" );
    level endon( "game_ended" );
    
    while ( isdefined( var0 ) )
    {
        self.origin = var0.origin;
        wait 0.05;
    }
}

// Params 2
// Size: 0x8d
function airstrike_watchkills( var0, var1 )
{
    self endon( "disconnect" );
    self notify( "airstrike_watch_kills" );
    self endon( "airstrike_watch_kills" );
    self.brattractions = 0;
    var2 = "airstrike_finished_" + var1;
    GscBinSkip4( 0x35, var2 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 1
// Size: 0x36
function airstrike_watchkillscount( var0 )
{
    self endon( var0 );
    self.airstrikekillcount = 0;
    
    for ( ;; )
    {
        self waittill( "update_rapid_kill_buffered", var1, var2 );
        
        if ( isdefined( var2 ) && var2 == "artillery_mp" )
        {
            self.airstrikekillcount++;
        }
    }
}

// Params 1
// Size: 0x14
function testsoundplacement( var0 )
{
    var0 endon( "death" );
    
    for ( ;; )
    {
        wait 0.05;
    }
}

// Params 6
// Size: 0x38d
function callstrike_precisionbulleteffect( var0, var1, var2, var3, var4, var5 )
{
    var0 endon( "death" );
    var6 = var0.flightdir;
    var7 = var3 + ( 0, 0, var0.flightheight + 750 );
    var8 = var7 - var6 * 15000;
    var9 = var7 - var6 * 500;
    var10 = var7;
    var11 = istrue( level.vehicle_collision_getleveldata ) && isdefined( level.ref_14603 ) && level.ref_14603 == 6;
    
    if ( !var11 )
    {
        var12 = spawn( "script_model", var8 );
        thread airstrike_killcammove( var12, var1 - 3, var9 );
        var0.bulletpoint.killcament = var12;
    }
    
    var13 = [ var3 - var6 * 512, var3 - var6 * 256, var3, var3 + var6 * 256, var3 + var6 * 512 ];
    
    if ( level.gametype == "br" && level.²/(²ºÏ£ûQŠõ4ß¨¿'«¨8J•ØÛEŽ )
    {
        foreach ( var15 in var13 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "dangerNotifyPlayersInRange" ) )
            {
                var4 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "dangerNotifyPlayersInRange" ) ]]( var15, level.—üÂ´N7èN-µ+Œ7Ù¬Éœ°¥®æ, var5.streakname );
            }
        }
    }
    
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var1 );
    
    if ( !isdefined( var4 ) )
    {
        return;
    }
    
    var17 = 5;
    var18 = ( 0, 0, 0 );
    var19 = var18;
    var0.bulletpoint setscriptablepartstate( "bullet_impact", "on", 0 );
    var20 = 0;
    var21 = 0;
    
    foreach ( var15 in var13 )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "addSpawnDangerZone" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "addSpawnDangerZone" ) ]]( var15, 512, 512, var4.team, 5, var4, 1 );
        }
    }
    
    var28 = var3[ 2 ] + var0.flightheight * 3;
    
    for ( var29 = 0; var29 < var17 ; var29++ )
    {
        var30 = -50;
        var31 = 150;
        
        while ( var20 < var21 + 4 )
        {
            var32 = callstrike_getrandomshotoffset( var30, var31, var13[ var29 ], var0.angles );
            var33 = var0 gettagorigin( "tag_turret_fx" ) * ( 1, 1, 0 ) + ( 0, 0, var28 ) + var6 * 1000;
            var35 = vectornormalize( var32 - var33 );
            var36 = var32 + var35 * 30000;
            var37 = scripts\engine\trace::ray_trace( var33, var36, undefined, scripts\engine\trace::create_contents( 0, 1, 0, 1, 0, 1, 0 ) );
            var38 = var37[ "position" ];
            var39 = var37[ "normal" ];
            var40 = var38 + var39 * 10;
            var41 = vectornormalize( var38 - var0 gettagorigin( "tag_turret_fx" ) );
            var42 = vectorcross( var41, ( 0, 0, 1 ) );
            var43 = vectorcross( var42, var41 );
            thread callstrike_playmultitracerfx( var0, scripts\engine\utility::getfx( "airstrike_tracer" ), var40, var41 );
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "skyhook", "precision_airstrike_damage" ) )
            {
                level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "skyhook", "precision_airstrike_damage" ) ]]( var37, var0, var4 );
            }
            
            thread moveanddamagepoint( var0.bulletpoint, var20 + 1 );
            var19 = var38;
            var20++;
            var0.bulletpoint.streakinfo.shots_fired++;
            var30 += 20;
            var31 += 40;
            var28 -= 200;
            
            if ( var28 < var0.flightheight )
            {
                var28 = var0.flightheight;
            }
            
            wait 0.05;
        }
        
        var21 = var20;
    }
    
LOC_0000036d:
    var0 notify( "fire_finished" );
    var0.bulletpoint setscriptablepartstate( "bullet_impact", "off", 0 );
}

// Params 4
// Size: 0x4c
function callstrike_getrandomshotoffset( var0, var1, var2, var3 )
{
    var3 *= ( 0, 1, 0 );
    var4 = anglestoforward( var3 );
    var5 = anglestoright( var3 );
    var6 = randomintrange( var0, var1 );
    var7 = randomint( 80 ) - 40;
    var8 = var4 * cos( var7 ) * var6;
    return var2 + var8 + var5 * sin( var7 ) * var6;
}

// Params 4
// Size: 0x4c
function callstrike_playmultitracerfx( var0, var1, var2, var3 )
{
    self endon( "death" );
    var4 = 0;
    var5 = 3;
    
    while ( var4 < var5 )
    {
        var6 = randomintrange( 25, 50 );
        var7 = randomintrange( 25, 50 );
        playfx( var0, var1 + ( var6, var7, 0 ), var2, var3 );
        var4++;
        wait 0.05;
    }
}

// Params 2
// Size: 0x49
function moveanddamagepoint( var0, var1 )
{
    self endon( "death" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 0.18 );
    self.origin = var1;
    self setscriptablepartstate( "explode" + var0, "active", 0 );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 5 );
    self setscriptablepartstate( "explode" + var0, "neutral", 0 );
}

// Params 5
// Size: 0x118
function callstrike_fuelbombeffect( var0, var1, var2, var3, var4 )
{
    var0 endon( "death" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var1 );
    
    if ( !isdefined( var4 ) )
    {
        return;
    }
    
    var5 = var0.flightdir;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airstrike", "addSpawnDangerZone" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airstrike", "addSpawnDangerZone" ) ]]( var3, 650, 650, var4.team, var2, var4, 1 );
    }
    
    var7 = var3 + ( 0, 0, 2500 );
    var8 = var3 - ( 0, 0, 10000 );
    var9 = scripts\engine\trace::ray_trace( var7, var8, undefined, scripts\engine\trace::create_contents( 0, 1, 0, 1, 0, 1, 0 ) );
    var10 = var9[ "position" ];
    var11 = var9[ "normal" ];
    var12 = var10 + var11 * 10;
    var13 = spawn( "script_model", var12 + ( 0, 0, 400 ) );
    var13 setmodel( "ks_fuelstrike_mp" );
    var13 setscriptablepartstate( "release", "on", 0 );
    var14 = spawn( "script_model", var12 );
    var14 setmodel( "ks_fuelstrike_mp" );
    var14 setscriptablepartstate( "ignite", "on", 0 );
    var14 setentityowner( var4 );
    thread delaydeletefxents( level, var13 );
}

// Params 2
// Size: 0x22
function delaydeletefxents( var0, var1 )
{
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 10 );
    
    if ( isdefined( var0 ) )
    {
        var0 delete();
    }
    
    if ( isdefined( var1 ) )
    {
        var1 delete();
        return;
    }
}

// Params 9
// Size: 0xbf
function getflightpath( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    var9 = undefined;
    
    if ( istrue( var8 ) )
    {
        var9 = var1;
    }
    else
    {
        var9 = anglestoforward( var1 );
    }
    
    var10 = var0 + var9 * -1 * var2;
    
    if ( isdefined( var3 ) )
    {
        var10 *= ( 1, 1, 0 );
    }
    
    var10 += ( 0, 0, var4 );
    var11 = var0 + var9 * var2;
    
    if ( isdefined( var3 ) )
    {
        var11 *= ( 1, 1, 0 );
    }
    
    var11 += ( 0, 0, var4 );
    var12 = length( var10 - var11 );
    var13 = var12 / var5;
    var12 = abs( var12 / 2 + var6 );
    var14 = var12 / var5;
    GscBinSkip1( 0x45, "startPoint", var10 );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 1
// Size: 0x1a
function getexplodedistance( var0 )
{
    var1 = 850;
    var2 = 1500;
    var3 = var1 / var0;
    var4 = var3 * var2;
    return var4;
}

// Params 2
// Size: 0x90
function airstrike_getownerlookatpos( var0, var1 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "aim_override" ) )
    {
        return var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "aim_override" ) ]]();
    }
    
    var2 = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicleclip" ];
    var3 = physics_createcontents( var2 );
    var4 = var0 getvieworigin();
    var5 = var4 + anglestoforward( var0 getplayerangles() ) * 50000;
    var6 = var0 scripts\cp_mp\utility\killstreak_utility::ref_125f8();
    var7 = scripts\engine\trace::ray_trace( var4, var5, var6, var3 );
    var8 = var7[ "position" ];
    
    if ( var7[ "hittype" ] == "hittype_none" )
    {
        var8 = undefined;
    }
    
    return var8;
}

// Params 2
// Size: 0x19c
function airstrike_watchforads( var0, var1 )
{
    self endon( "death_or_disconnect" );
    self endon( "deploy_cancelled" );
    self endon( "deploy_fired" );
    var2 = spawn( "script_model", self.origin );
    var2 setmodel( "ks_airstrike_marker_mp" );
    
    if ( scripts\cp_mp\utility\game_utility::ref_140aa() )
    {
        var2 setmodel( "ks_airstrike_marker_br_ch3" );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "requestObjectiveID" ) )
    {
        var2.objidnum = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "requestObjectiveID" ) ]]( 99 );
    }
    
    var2 setotherent( self );
    var2 dontinterpolate();
    var2 hide();
    var3 = scripts\cp_mp\utility\script_utility::ref_140de( "game", "isGameTypeBR", 0 );
    
    if ( var3 )
    {
        var4 = "icon_waypoint_airstrike_ww2";
    }
    else
    {
        var4 = "icon_waypoint_airstrike";
    }
    
    if ( isdefined( var2 ) )
    {
        var4 = var2;
    }
    
    airstrike_setmarkerobjective( var3, var3.objidnum, var4, self, 50 );
    thread branalytics_validation( var3 );
    thread airstrike_watchdeployended( var3 );
    thread branalytics_spawntablet( var3 );
    var3.updatemarker = 0;
    scripts\common\utility::allow_fire( 0 );
    
    for ( ;; )
    {
        var5 = self playerads();
        var6 = var5 == 1;
        var7 = var5 < 1;
        var8 = scripts\cp_mp\emp_debuff::is_empd();
        var9 = istrue( var3.updatemarker );
        
        if ( !var9 && !var8 && var6 )
        {
            scripts\common\utility::allow_fire( 1 );
            var3 show();
            var3 setscriptablepartstate( "marker_scope", "on", 0 );
            thread airstrike_updatemarkerpos( var3 );
            var3.updatemarker = 1;
        }
        else if ( var9 && ( var7 || var8 ) )
        {
            scripts\common\utility::allow_fire( 0 );
            var3 hide();
            var3 setscriptablepartstate( "marker_scope", "off", 0 );
            self notify( "stop_update_marker" );
            var3.updatemarker = 0;
        }
        
        waitframe();
    }
}

// Params 4
// Size: 0x60
function airstrike_setmarkerobjective( var0, var1, var2, var3 )
{
    objective_icon( var0, var1 );
    objective_showtoplayersinmask( var0 );
    objective_addclienttomask( var0, var2 );
    objective_onentity( var0, self );
    objective_setzoffset( var0, var3 );
    objective_setplayintro( var0, 0 );
    objective_setplayoutro( var0, 0 );
    objective_setbackground( var0, 1 );
    
    if ( level.teambased )
    {
        objective_setownerteam( var0, var2.team );
    }
    else
    {
        objective_setownerclient( var0, var2 );
    }
    
    objective_state( var0, "done" );
}

// Params 1
// Size: 0x140
function airstrike_updatemarkerpos( var0 )
{
    var0 notify( "stop_update_marker" );
    var0 endon( "stop_update_marker" );
    self endon( "death" );
    var0 endon( "deploy_cancelled" );
    var0 endon( "deploy_fired" );
    var0 endon( "death_or_disconnect" );
    var1 = 0;
    var0 setclientomnvar( "ui_spotter_scope_danger", 0 );
    
    for ( ;; )
    {
        var2 = airstrike_getownerlookatpos( var0 );
        var3 = -1;
        var4 = -1;
        var5 = -1;
        var6 = isdefined( var2 );
        
        if ( var6 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "isPointInBounds" ) )
            {
                var6 &= level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "isPointInBounds" ) ]]( var2 );
            }
        }
        
        if ( var6 )
        {
            self.origin = var2;
            var3 = int( self.origin[ 0 ] );
            var4 = int( self.origin[ 1 ] );
            var5 = int( self.origin[ 2 ] );
        }
        
        var0 setclientomnvar( "ui_ac130_coord3_posx", var3 );
        var0 setclientomnvar( "ui_ac130_coord3_posy", var4 );
        var0 setclientomnvar( "ui_ac130_coord3_posz", var5 );
        
        if ( isdefined( var2 ) )
        {
            if ( !istrue( var1 ) && distance2dsquared( var0.origin, var2 ) <= 1638400 )
            {
                var0 setclientomnvar( "ui_spotter_scope_danger", 1 );
                var1 = 1;
            }
            else if ( istrue( var1 ) && distance2dsquared( var0.origin, var2 ) > 1638400 )
            {
                var0 setclientomnvar( "ui_spotter_scope_danger", 0 );
                var1 = 0;
            }
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x1f
function branalytics_validation( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var0 waittill( "death_or_disconnect" );
    airstrike_removemarker();
}

// Params 1
// Size: 0xea
function airstrike_watchdeployended( var0 )
{
    var0 endon( "death_or_disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    var1 = var0 scripts\engine\utility::ref_143ad( "cancel_fire", "successful_fire" );
    
    if ( isdefined( var1 ) && var1 == "successful_fire" )
    {
        var0 notify( "deploy_fired" );
        self setscriptablepartstate( "marker_scope", "off", 0 );
        var2 = anglestoforward( var0 getplayerangles() );
        var3 = self.origin - var2 * 500;
        var4 = self.origin + var2 * 20;
        var5 = scripts\engine\trace::ray_trace( var3, var4, self );
        var6 = var5[ "normal" ];
        self.angles = generateaxisanglesfromupvector( var6, self.angles );
        self setscriptablepartstate( "marker_placed", "on", 0 );
        objective_state( self.objidnum, "current" );
        thread airstrike_removemarker( 7 );
        return;
    }
    
    var0 notify( "deploy_cancelled" );
    
    if ( !var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "isPlayerADS" ) ]]() )
    {
        var0 scripts\common\utility::allow_fire( 1 );
    }
    
    airstrike_removemarker();
}

// Params 1
// Size: 0x39
function branalytics_spawntablet( var0 )
{
    var0 endon( "death_or_disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    var1 = var0 getcurrentweapon();
    
    for ( ;; )
    {
        if ( var0 getcurrentweapon() != var1 )
        {
            break;
        }
        
        waitframe();
    }
    
    var0 notify( "cancel_fire" );
}

// Params 1
// Size: 0x55
function airstrike_removemarker( var0 )
{
    if ( isdefined( var0 ) )
    {
        self endon( "death" );
        level endon( "game_ended" );
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var0 );
    }
    
    if ( isdefined( self.objidnum ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "returnObjectiveID" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "returnObjectiveID" ) ]]( self.objidnum );
        }
    }
    
    self delete();
}

// Params 1
// Size: 0x24
function airstrike_delayplayscriptable( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait var0;
    self setscriptablepartstate( "bodyfx", "on", 0 );
}

// Params 3
// Size: 0x2f
function airstrike_killcammove( var0, var1, var2 )
{
    self endon( "death" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var0 );
    self moveto( var1, 4 );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 3.95 );
    self moveto( var2, 5 );
}

// Params 2
// Size: 0x24
function branalytics_teameliminated( var0, var1 )
{
    self endon( "airstrike_finished_" + var1 );
    self endon( "disconnect" );
    level waittill( "game_ended" );
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var0 );
}

// Params 2
// Size: 0x55
function branalytics_respawn( var0, var1 )
{
    level.brareloadoutdropbagsdelayed++;
    var2 = spawnstruct();
    var2.origin = var0;
    var2.owner = var1;
    var2.id = var1.name + "_" + level.brareloadoutdropbagsdelayed;
    level.audio_heli_fade_up[ var2.id ] = var2;
    return var2.id;
}

// Params 2
// Size: 0x27
function branalytics_seteventdelayedstate( var0, var1 )
{
    level.audio_heli_fade_up = scripts\engine\utility::array_remove_index( level.audio_heli_fade_up, var1, 1 );
    
    if ( isdefined( var0 ) )
    {
        var0 notify( "airstrike_finished_" + var1 );
        return;
    }
}

// Params 1
// Size: 0xa1
function branalytics_secondwind( var0 )
{
    var1 = "success";
    var2 = 625000000;
    
    if ( isdefined( var0 ) )
    {
        if ( level.audio_heli_fade_up.size > 0 )
        {
            var3 = 1;
            var4 = level.gametype == "br";
            
            if ( var4 )
            {
                var3 = 3;
            }
            
            if ( level.audio_heli_fade_up.size >= var3 )
            {
                var1 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED";
            }
            else
            {
                foreach ( var6 in level.audio_heli_fade_up )
                {
                    if ( distance2dsquared( var6.origin, var0 ) <= var2 )
                    {
                        var1 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA";
                    }
                }
            }
        }
    }
    else
    {
        var1 = "KILLSTREAKS/INVALID_POINT";
    }
    
    return var1;
}

// Params 4
// Size: 0x9a
function game_end_watcher( var0, var1, var2, var3 )
{
    var4 = self;
    var5 = spawnstruct();
    var5.streakname = "precision_airstrike";
    var5.owner = var4;
    var5.score = 0;
    var5.shots_fired = 0;
    var5.hits = 0;
    var5.damage = 0;
    var5.kills = 0;
    var5.setuptimelimit = istrue( var1 );
    var5.brmini_ontimelimit = istrue( var2 );
    var6 = var3;
    var7 = undefined;
    var8 = %mp_alfa10_flyin;
    
    if ( scripts\cp_mp\utility\game_utility::ref_140aa() )
    {
        var8 = %mp_alfa10_flyin_br;
    }
    
    var9 = undefined;
    thread callstrike( level, var4, var0, var6, var7, var5, var8 );
}

