
// Params 0
// Size: 0x88
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "greenbay_strike", &ref_13e2a, &ongreenbaystrikekillstreakavailable );
    scripts\common\ui::lui_registercallback( "ui_mv_on_new_killstreak_selected", &ref_1266a );
    super_enemy_spawning();
    super_has_targets();
    scripts\common\utility::allow_register_set( "greenbay_strike_restrictions", [ "usability", "weapon_switch", "weapon_pickup", "sprint", "mantle", "fire", "ads", "melee", "execution_attack", "execution_victim", "vehicle_use", "crate_use", "ascender_use" ] );
}

// Params 0
// Size: 0x1f4
function super_enemy_spawning()
{
    level.sentry_shouldshoot = spawnstruct();
    level.sentry_shouldshoot.inuse = 0;
    level.sentry_shouldshoot.stab_blink_black_fade = 0;
    level.sentry_shouldshoot.triggers = [];
    level.sentry_shouldshoot.ref_13dc5 = 0;
    level.sentry_shouldshoot.playersintrigger = [];
    level.sentry_shouldshoot.±u`ã°zÓÜˇ[3 = getdvarint( "scr_br_mxp_g_width", 2000 );
    level.sentry_shouldshoot.ã 4Û®åxÌ˝9#s = getdvarint( "scr_br_mxp_g_limit_z_delta", 1 );
    level.sentry_shouldshoot.ñ~
†¿Â8C = getdvarfloat( "scr_br_mxp_g_max_z_delta", 100 );
    level.sentry_shouldshoot.©„rË}á?˚µ˙·À = getdvarfloat( "scr_br_mxp_g_min_dist_attack", 2500 );
    level.sentry_shouldshoot.äÈµ¥‹åZÕGÖ—ËÖ±∂ = level.sentry_shouldshoot.©„rË}á?˚µ˙·À + getdvarint( "scr_br_mxp_g_length", 8000 ) / 2;
    level.vehicle_shoulddocollisiondamagetoplayer = spawnstruct();
    level.vehicle_shoulddocollisiondamagetoplayer.inuse = 0;
    level.vehicle_shoulddocollisiondamagetoplayer.±u`ã°zÓÜˇ[3 = getdvarint( "scr_br_mxp_k_radius", 4000 );
    level.vehicle_shoulddocollisiondamagetoplayer.¨L	/–“≤uÔ = getdvarint( "scr_br_mxp_k_mid_range", 10000 );
    level.vehicle_shoulddocollisiondamagetoplayer.áV
6ﬁõÏ',Õùï = getdvarint( "scr_br_mxp_k_long_range", 30000 );
    level.vehicle_shoulddocollisiondamagetoplayer.°\WÉ—ã⁄kX(7 = getdvarint( "scr_br_mxp_k_longer_range", 50000 );
    level.vehicle_shoulddocollisiondamagetoplayer.Öé”›«ß_(hQfÑ€À°C{˛Í!†ﬂ' = getdvarint( "scr_br_mxp_k_rock_gravity_mid_range", 12000 );
    level.vehicle_shoulddocollisiondamagetoplayer.ô8N{çµÎŸìX;“:ÚÎÿÌ7ÏØì,π≥V = getdvarint( "scr_br_mxp_k_rock_gravity_long_range", 9000 );
    level.vehicle_shoulddocollisiondamagetoplayer.•¬√`Œ¬~‚∫`r$¯ÿœ1·⁄¢àÿ≠ = getdvarint( "scr_br_mxp_k_rock_gravity_longer_range", 5000 );
    level.vehicle_shoulddocollisiondamagetoplayer.∂È¢– S¡úÕß√√=kØÄ8]o	ÙônÉìè3 = getdvarint( "scr_br_mxp_k_rock_gravity_longest_range", 2500 );
    level.vehicle_shoulddocollisiondamagetoplayer.ålíàsÔÎ3Ω=)Æ_ö8∑˚˚P7‡ = getdvarint( "scr_br_mxp_k_rock_speed_mid_range", 6000 );
    level.vehicle_shoulddocollisiondamagetoplayer.Öà≥
wB	2ò+¥ÿ‚n;rÎå+ = getdvarint( "scr_br_mxp_k_rock_speed_long_range", 6000 );
    level.vehicle_shoulddocollisiondamagetoplayer.£ìÛØc™{ë›!a6∞2NÀ¯@;"w: = getdvarint( "scr_br_mxp_k_rock_speed_longer_range", 7000 );
    level.vehicle_shoulddocollisiondamagetoplayer.è8c}Á∑°ÿKMÏY]w[ZØÛò6™πkz = getdvarint( "scr_br_mxp_k_rock_speed_longest_range", 9000 );
}

// Params 0
// Size: 0x3e
function super_has_targets()
{
    level._effect[ "greenbay_impact" ] = loadfx( "vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_impact" );
    level._effect[ "greenbay_impact_linger" ] = loadfx( "vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_impact_linger" );
    level._effect[ "greenbay_impact_player" ] = loadfx( "vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_impact_player" );
}

// Params 1
// Size: 0x110, Type: bool
function ref_13e2a( var0 )
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
    
    var1 = getcompleteweaponname( "ks_remote_oshkosh_mp" );
    var2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy( var0, var1, 1, &ref_14587, undefined, &playerswitchweaponback );
    
    if ( !istrue( var2 ) )
    {
        return false;
    }
    
    var3 = undefined;
    
    if ( !isdefined( var0.ref_13a81 ) )
    {
        if ( getdvarint( "scr_br_mxp_greenbaystrike_movement_disable", 1 ) )
        {
            scripts\common\utility::allow_movement( 0 );
        }
        
        var3 = ref_14582( var0, var1, undefined );
        
        if ( getdvarint( "scr_br_mxp_greenbaystrike_movement_disable", 1 ) )
        {
            scripts\common\utility::allow_movement( 1 );
        }
        
        if ( !isdefined( var3 ) || !istrue( var3.success ) )
        {
            var0 notify( "killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( var0 ) )
        {
            return false;
        }
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "logKillstreakEvent" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "logKillstreakEvent" ) ]]( var0.streakname, self.origin );
    }
    
    thread ref_1384d( var3, var0 );
    
    if ( isdefined( level.killstreakfinishusefunc ) )
    {
        level thread [[ level.killstreakfinishusefunc ]]( var0 );
    }
    
    return true;
}

// Params 1
// Size: 0x27
function ongreenbaystrikekillstreakavailable( var0 )
{
    if ( scripts\engine\utility::cointoss() )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "scream_device_acquired", self );
        return;
    }
    
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "scream_device_acquired_desc", self );
}

// Params 3
// Size: 0xc3
function playerswitchweaponback( var0, var1, var2 )
{
    self endon( "disconnect" );
    self endon( "death" );
    
    if ( istrue( var0.failed ) || !isdefined( var0.ref_13923 ) )
    {
        scripts\cp_mp\utility\inventory_utility::getridofweapon( var2 );
    }
    else
    {
        var3 = "ks_remote_oshkosh_greenbay_mp";
        
        if ( var0.ref_13923 == 1 )
        {
            var3 = "ks_remote_oshkosh_kenosha_mp";
        }
        
        var4 = getcompleteweaponname( var3 );
        self giveweapon( var4, 0, 0, -1, 1 );
        self switchtoweaponimmediate( var4 );
        scripts\common\utility::allow_set( "greenbay_strike_restrictions", 0, "greenbay_toggle_anim" );
        var5 = 4.3;
        wait var5;
        scripts\cp_mp\utility\inventory_utility::getridofweapon( var2 );
        scripts\common\utility::allow_set( "greenbay_strike_restrictions", 1, "greenbay_toggle_anim" );
        scripts\cp_mp\utility\inventory_utility::getridofweapon( var4, 1 );
    }
    
    var6 = self getcurrentweapon();
    
    if ( var6.basename == "none" )
    {
        scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        return;
    }
}

// Params 3
// Size: 0x11
function serverroomdogtagrevive( var0, var1, var2 )
{
    strikeatlocation( var0, var1, var2, 2 );
}

// Params 3
// Size: 0x11
function greenbaystrikeatpoint( var0, var1, var2 )
{
    strikeatlocation( var0, var1, var2, 3 );
}

// Params 3
// Size: 0x11
function vehicle_spawn_cp_gamemodesupportsabandonedtimeout( var0, var1, var2 )
{
    strikeatlocation( var0, var1, var2, 1 );
}

// Params 4
// Size: 0xa5
function strikeatlocation( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.origin = var0;
    var4.angles = var1;
    var4.pers = [];
    var4.team = "neutral";
    var4.defaultoperatorteam = "neutral";
    var4.classname = "worldspawn";
    var5 = var4 scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "greenbay_strike", var4 );
    var5.owner = var4;
    var5.ref_13923 = var3;
    var5.radius = var2;
    var6 = spawnstruct();
    var6.location = var0;
    var6.angles = var1;
    var6.string = "confirm_location";
    thread ref_1384d( var4, var6 );
}

// Params 1
// Size: 0x8a, Type: bool
function ref_14587( var0 )
{
    if ( scripts\mp\gametypes\br_publicevent_fresno::isfresnoactive() )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "BR_MENDOTA/FRENZY_UNAVAILABLE" );
        }
        
        var0 notify( "killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( sequence_interaction_activate() && vehicle_showvalidlittlebirds() )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "BR_MENDOTA/TOMAH_UNAVAILABLE" );
        }
        
        var0 notify( "killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    server_triggered( var0 );
    return true;
}

// Params 3
// Size: 0x26a
function ref_14582( var0, var1, var2 )
{
    var3 = 2.1;
    var4 = scripts\engine\utility::waittill_any_ents_or_timeout_return( var3, level, "fresno_start" );
    
    if ( !isdefined( var4 ) )
    {
        var0.failed = 1;
        return undefined;
    }
    else if ( var4 == "fresno_start" )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "BR_MENDOTA/FRENZY_UNAVAILABLE" );
        }
        
        var0.failed = 1;
        return undefined;
    }
    
    var5 = seq3_warning_room_c( var0 );
    var6 = 1;
    
    if ( isdefined( var0.ref_13923 ) )
    {
        var6 = var0.ref_13923;
    }
    else if ( isdefined( self.ref_1300b ) && self.ref_1300b != 0 )
    {
        var6 = self.ref_1300b;
    }
    
    var0.ref_13923 = var6;
    
    if ( var0.ref_13923 == 2 && sequence_interaction_activate() )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "BR_MENDOTA/GREENBAY_UNAVAILABLE" );
        }
        
        var0 notify( "killstreak_finished_with_deploy_weapon" );
        var0.failed = 1;
        return undefined;
    }
    else if ( var0.ref_13923 == 1 && vehicle_showvalidlittlebirds() )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "BR_MENDOTA/KENOSHA_UNAVAILABLE" );
        }
        
        var0 notify( "killstreak_finished_with_deploy_weapon" );
        var0.failed = 1;
        return undefined;
    }
    
    if ( !isdefined( var5 ) || !istrue( var5.success ) )
    {
        if ( isdefined( var5 ) && !istrue( var5.success ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            if ( var5.string == "oob" )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/INVALID_POINT" );
            }
            else if ( var5.string == "fresno_start" )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "BR_MENDOTA/FRENZY_UNAVAILABLE" );
            }
        }
        
        var0.failed = 1;
        return undefined;
    }
    
    if ( scripts\cp_mp\emp_debuff::is_empd() )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/CANNOT_BE_USED" );
        }
        
        var0.failed = 1;
        return undefined;
    }
    
    var7 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "sound", "playKillstreakDeployDialog" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "sound", "playKillstreakDeployDialog" ) ]]( self, var0.streakname );
        var7 = 2;
    }
    
    return var5;
}

// Params 3
// Size: 0x57
function seq3_warning_room_c( var0, var1, var2 )
{
    scripts\common\utility::allow_weapon_switch( 0 );
    self setsoundsubmix( "mp_killstreak_overlay" );
    var3 = ref_125c2();
    
    if ( !isdefined( var3 ) || !istrue( var3.success ) )
    {
        scripts\common\utility::allow_weapon_switch( 1 );
        self clearsoundsubmix( "mp_killstreak_overlay" );
        return var3;
    }
    
    scripts\common\utility::allow_weapon_switch( 1 );
    self clearsoundsubmix( "mp_killstreak_overlay" );
    return var3;
}

// Params 0
// Size: 0x21
function playerwaittillmapselectcomplete()
{
    level endon( "fresno_start" );
    var0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel( "confirm_location", "cancel_location", "last_stand_start" );
    return var0;
}

// Params 0
// Size: 0xd6
function ref_125c2()
{
    self setclientomnvar( "ui_br_show_tac_map", 1 );
    self beginlocationselection( 0, 0, 0, 0, 4 );
    thread playerlocselectendgamecleanup();
    var0 = playerwaittillmapselectcomplete();
    self notify( "greenbay_strike_selection_done" );
    
    if ( !isdefined( var0 ) )
    {
        var0 = spawnstruct();
        var0.string = "fresno_start";
    }
    
    var0.success = 0;
    self endlocationselection();
    
    if ( isdefined( var0 ) && var0.string == "confirm_location" )
    {
        if ( scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var0.location, 1 ) )
        {
            var1 = scripts\mp\gametypes\br::ref_13c34( var0.location );
            var2 = var1[ "position" ];
            
            if ( scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var2, 1 ) )
            {
                var0.success = 1;
            }
            else
            {
                var0.string = "oob";
            }
        }
        else
        {
            var0.string = "oob";
        }
    }
    
    self setclientomnvar( "ui_br_show_tac_map", 0 );
    return var0;
}

// Params 0
// Size: 0x32
function playerlocselectendgamecleanup()
{
    var0 = self;
    var0 endon( "death" );
    var0 endon( "disconnect" );
    var0 endon( "greenbay_strike_selection_done" );
    level waittill( "game_ended" );
    var0 endlocationselection();
    var0 setclientomnvar( "ui_br_show_tac_map", 0 );
}

// Params 1
// Size: 0xd
function server_triggered( var0 )
{
    scripts\mp\killstreaks\mapselect::startmapselectsequence( 0, 0, 0 );
}

// Params 2
// Size: 0x95
function ref_1384d( var0, var1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var2 = 1;
    
    if ( isdefined( var1.ref_13923 ) )
    {
        var2 = var1.ref_13923;
    }
    
    var1.player = self;
    var1.starttime = gettime();
    
    if ( var2 == 2 )
    {
        thread seq3_tvnums_str( var0, var1 );
    }
    else if ( var2 == 3 )
    {
        thread greenbaystrike_attackray( var0, var1 );
    }
    else
    {
        thread vehicle_showteamtanks( var0, var1 );
    }
    
    if ( isplayer( self ) )
    {
        self.©”√Wãå–∫<˜ÅÎkYÖ = var2;
    }
    
    var1 notify( "killstreak_finished_with_deploy_weapon" );
    scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "mv_event_intel_2" );
    thread server_unlocked( var1 );
}

// Params 2
// Size: 0x146
function seq3_tvnums_str( var0, var1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "drone_target_placed" );
    greenbaystrike_cleanupinterruptedstreak();
    
    if ( isplayer( self ) )
    {
        sequence_progression( 1 );
    }
    
    var1.ref_134e3 = scripts\mp\gametypes\br_alt_mode_mxp::sandbox_combat_area();
    greenbaystrike_setuptarget( var0, var1 );
    var2 = var0.location;
    greenbaystrike_createmarker( var2 );
    greenbaystrike_preparestreakinfo( var1, var0 );
    greenbaystrike_debugprint( var1 );
    var3 = var2 - var1.ref_134e3;
    var3 = vectornormalize( ( var3[ 0 ], var3[ 1 ], 0 ) );
    var4 = -1 * var3;
    var5 = getdvarint( "scr_br_mxp_g_length", 8000 );
    var1.startorigin = var2 + var4 * var5 / 2;
    var1.endorigin = var2 + var3 * var5 / 2;
    var1.dir = vectornormalize( var1.endorigin - var1.startorigin );
    var6 = scripts\mp\gametypes\br_public::semtex_used();
    var1.ö˘s[ü.∞◊zﬂûˇ†ˆg¬àX = skytracetoworld( var1.startorigin, var6 );
    var1.ÑˇpïXÎﬂÕk∫”Á = makepreviewimpactcircle( var1.startorigin, var1.origin, var1.endorigin, var3, var1.change_keypad_display_digit, var5 );
    var1.start_area_fx_end = seq3_warning_room_a( var1.startorigin );
    
    if ( isplayer( self ) )
    {
        var1.start_area_fx_end setscriptabledamageowner( self );
        thread scripts\mp\hud_message::showsplash( "br_gametype_mendota_greenbay_streak" );
    }
    
    scripts\mp\gametypes\br_alt_mode_mxp::set_number_of_subway_cars_on_track( var1 );
}

// Params 2
// Size: 0x83
function greenbaystrike_attackray( var0, var1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "drone_target_placed" );
    greenbaystrike_cleanupinterruptedstreak();
    var1.ref_134e3 = scripts\mp\gametypes\br_alt_mode_mxp::sandbox_combat_area();
    greenbaystrike_attackray_getend( var0, var1 );
    var2 = greenbaystrike_setuptarget( var0, var1 );
    
    if ( var2 )
    {
        greenbaystrike_attackray_getend( var0, var1 );
    }
    
    var3 = var0.location;
    greenbaystrike_createmarker( var3 );
    greenbaystrike_preparestreakinfo( var1, var0 );
    greenbaystrike_debugprint( var1 );
    var1.start_area_fx_end = seq3_warning_room_a( var1.startorigin );
    scripts\mp\gametypes\br_alt_mode_mxp::set_number_of_subway_cars_on_track( var1 );
}

// Params 2
// Size: 0x57
function greenbaystrike_attackray_getend( var0, var1 )
{
    var2 = vectornormalize( var0.location - var1.ref_134e3 );
    var3 = getdvarint( "scr_br_mxp_g_length_ray", 200000 );
    var4 = var1.ref_134e3;
    var5 = var1.ref_134e3 + var2 * var3;
    var6 = scripts\engine\trace::ray_trace( var4, var5, undefined, scripts\engine\trace::create_world_contents() );
    greenbaystrike_updateinforay( var0, var1, var6, var2 );
}

// Params 4
// Size: 0x6c
function greenbaystrike_updateinforay( var0, var1, var2, var3 )
{
    var4 = var2[ "position" ];
    var0.location = var4;
    var1.startorigin = var4;
    var1.endorigin = var4;
    var1.dir = var3;
    
    if ( var2[ "hittype" ] != "hittype_none" )
    {
        var1.ö˘s[ü.∞◊zﬂûˇ†ˆg¬àX = var4;
        var1.∏Àﬂ˘ø+|8≥-≥(¯æ2és; = var2[ "normal" ];
        return;
    }
    
    var1.ö˘s[ü.∞◊zﬂûˇ†ˆg¬àX = undefined;
    var1.∏Àﬂ˘ø+|8≥-≥(¯æ2és; = undefined;
}

// Params 0
// Size: 0x43
function greenbaystrike_cleanupinterruptedstreak()
{
    if ( !isdefined( level.ref_11e18.setincomingremovedcallback.vo_one_remain ) )
    {
        return;
    }
    
    var0 = level.ref_11e18.setincomingremovedcallback.vo_one_remain;
    level.ref_11e18.setincomingremovedcallback.vo_one_remain = undefined;
    greenbaystrike_cleanuppreviewentities( var0 );
}

// Params 2
// Size: 0xe9, Type: bool
function greenbaystrike_setuptarget( var0, var1 )
{
    var2 = var0.location;
    var3 = level.ref_11e18.setincomingremovedcallback.origin;
    
    if ( scripts\mp\gametypes\br_alt_mode_mxp::ginwalkingstate() )
    {
        var4 = scripts\mp\gametypes\br_alt_mode_mxp::ggetnextindexorigin();
        var5 = var4[ 0 ];
        var3 = var4[ 1 ];
        var4 = undefined;
    }
    
    var6 = distance2d( var2, var3 );
    var7 = level.sentry_shouldshoot.äÈµ¥‹åZÕGÖ—ËÖ±∂;
    
    if ( var1.ref_13923 == 3 )
    {
        var7 = level.sentry_shouldshoot.©„rË}á?˚µ˙·À;
    }
    
    if ( var6 <= var7 )
    {
        var8 = scripts\mp\gametypes\br_alt_mode_mxp::sandbox_combat_area( var3 );
        var9 = var2 - var8;
        var9 = vectornormalize( ( var9[ 0 ], var9[ 1 ], 0 ) );
        var10 = var8 + var9 * var7;
        var1.ref_134e3 = var8;
        var0.location = ( var10[ 0 ], var10[ 1 ], var2[ 2 ] );
        
        if ( var1.ref_13923 == 3 && isdefined( var1.∏Àﬂ˘ø+|8≥-≥(¯æ2és; ) )
        {
            var11 = scripts\mp\gametypes\br_public::semtex_used();
            var0.location = skytracetoworld( var0.location, var11 );
        }
        
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x67
function greenbaystrike_createmarker( var0 )
{
    if ( getdvarint( "scr_br_mxp_ks_marker", 0 ) != 1 )
    {
        return;
    }
    
    var1 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "requestObjectiveID" ) )
    {
        var1 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "requestObjectiveID" ) ]]( 99 );
    }
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    server_activate( var1, "ui_mp_br_hud_icon_greenbay", self, var0 + ( 0, 0, 50 ) );
    thread greenbaystrike_handlemarker( level );
}

// Params 2
// Size: 0x4c
function greenbaystrike_preparestreakinfo( var0, var1 )
{
    var0.shots_fired++;
    var0.origin = var1.location;
    
    if ( isdefined( var0.radius ) )
    {
        var0.change_keypad_display_digit = var0.radius;
        return;
    }
    
    var0.change_keypad_display_digit = level.sentry_shouldshoot.±u`ã°zÓÜˇ[3;
}

// Params 1
// Size: 0x6e
function greenbaystrike_debugprint( var0 )
{
    var1 = "greenbay attack: " + var0.ref_134e3[ 0 ] + " " + var0.ref_134e3[ 1 ] + " " + var0.ref_134e3[ 2 ] + " " + var0.origin[ 0 ] + " " + var0.origin[ 1 ] + " " + var0.origin[ 2 ];
    logprint( var1 );
}

// Params 1
// Size: 0x22
function seq3_warning_room_a( var0 )
{
    var1 = spawn( "script_model", var0 );
    var1 setmodel( "ks_greenbay_impact" );
    var1 unmarkkeyframedmover( 1 );
    return var1;
}

// Params 1
// Size: 0x131
function server_structs( var0 )
{
    level endon( "game_ended" );
    sequence_progression( 0 );
    scripts\mp\gametypes\br_alt_mode_mxp::gendkillstreak();
    var0.circleent = ref_11a9f( var0.startorigin, var0.change_keypad_display_digit, 0, 2 );
    var1 = greenbaystrike_getattacktime( var0 );
    var0.start_area_fx_end setscriptablepartstate( "root", "enabled" );
    var0.start_area_fx_end setscriptablepartstate( "rumble", "on" );
    var0.circleent moveto( ( var0.endorigin[ 0 ], var0.endorigin[ 1 ], var0.change_keypad_display_digit ), var1, 0.1, 0.1 );
    var2 = var0.owner;
    
    if ( !isplayer( var2 ) )
    {
        var2 = level.ref_11e18.setincomingremovedcallback;
    }
    else
    {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "g_attack_used", var2 );
    }
    
    var3 = greenbaystrike_continueattack( var0, var1, var2 );
    var0.start_area_fx_end setscriptablepartstate( "damage", "stop" );
    var0.start_area_fx_end setscriptablepartstate( "root", "disabled" );
    greenbaystrike_cleanuppreviewentities( var0, 1 );
    thread kiosk_spent_total( var0.circleent, 1 );
    
    if ( isdefined( var2 ) && isplayer( var2 ) )
    {
        var2 notify( "greenbay_strike_finished" );
        var2 scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var0 );
    }
    
    return var3;
}

// Params 1
// Size: 0x28
function greenbaystrike_getdamagestate( var0 )
{
    if ( var0.change_keypad_display_digit == level.sentry_shouldshoot.±u`ã°zÓÜˇ[3 )
    {
        return "start_large";
    }
    
    return "start_small";
}

// Params 3
// Size: 0x131, Type: bool
function greenbaystrike_continueattack( var0, var1, var2 )
{
    level.ref_11e18.setincomingremovedcallback endon( "gk_driven_off" );
    var3 = greenbaystrike_getdamagestate( var0 );
    var4 = 256;
    var5 = 128;
    var6 = 30;
    
    if ( isdefined( var0.ref_13923 ) && var0.ref_13923 == 3 )
    {
        thread greenbayburn_spawnrayburn( var0, var4, var0.ö˘s[ü.∞◊zﬂûˇ†ˆg¬àX, var0.∏Àﬂ˘ø+|8≥-≥(¯æ2és;, var5, var2 );
    }
    
    var7 = gettime() + var1 * 1000;
    
    while ( gettime() < var7 )
    {
        var8 = getnextgreenbayaimdamagepos( var0 );
        var9 = var8[ 0 ];
        var10 = var8[ 1 ];
        var8 = undefined;
        scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_state( var10 );
        var0.start_area_fx_end.origin = var10;
        var11 = getgroundnormal( var10 );
        
        if ( isdefined( var11 ) )
        {
            var12 = vectorcross( var11, ( 1, 0, 0 ) );
            var13 = vectortoangles( var12 );
            var0.start_area_fx_end.angles = var13;
        }
        
        var0.start_area_fx_end setscriptablepartstate( "damage", var3 );
        seq3_sequence( var0, var4, var10, var0.start_area_fx_end.angles, var5, 0, var2, var6 );
        greenbaystrike_trylaserdamage( var0, var10, var2 );
        waitframe();
        
        if ( isdefined( var0.ö˘s[ü.∞◊zﬂûˇ†ˆg¬àX ) )
        {
            var0.±ú¨ÏK∑∫õÏ…{’π∑…•;-õ = var9;
        }
    }
    
    return true;
}

// Params 2
// Size: 0x45
function greenbaystrike_trylaserdamage( var0, var1 )
{
    if ( !isdefined( self.•~Ì≈â;Ï©SÄÅ’“m ) )
    {
        self.•~Ì≈â;Ï©SÄÅ’“m = gettime();
    }
    
    if ( self.•~Ì≈â;Ï©SÄÅ’“m <= gettime() )
    {
        greenbaystrike_laserdamage( var0, var1 );
        self.•~Ì≈â;Ï©SÄÅ’“m = gettime() + getdvarfloat( "scr_br_mxp_g_laserDamageFreq", 0.125 ) * 1000;
        return;
    }
}

// Params 2
// Size: 0x41
function greenbaystrike_laserdamage( var0, var1 )
{
    var2 = self.change_keypad_display_digit;
    var3 = 1000;
    isaltbunkerscriptable( var0, var2, var3, var1, "MOD_EXPLOSIVE", getcompleteweaponname( "greenbay_strike" ), level.ref_11e18.setincomingremovedcallback.clear_look_at_ent.origin, 1 );
}

// Params 1
// Size: 0x27
function greenbaystrike_getattacktime( var0 )
{
    if ( var0.ref_13923 == 3 )
    {
        return getdvarfloat( "scr_br_mxp_g_time_ray", 6 );
    }
    
    return getdvarfloat( "scr_br_mxp_g_time", 6 );
}

// Params 2
// Size: 0x29
function greenbaystrike_cleanuppreviewentities( var0, var1 )
{
    if ( isdefined( var0.ÑˇpïXÎﬂÕk∫”Á ) )
    {
        var0.ÑˇpïXÎﬂÕk∫”Á delete();
    }
    
    thread kiosk_spent_total( var0.start_area_fx_end, var1 );
}

// Params 1
// Size: 0x11c
function getnextgreenbayaimdamagepos( var0 )
{
    var1 = distance2d( var0.startorigin, var0.circleent.origin );
    var2 = var0.startorigin + var0.dir * var1;
    
    if ( var0.ref_13923 == 2 )
    {
        if ( isdefined( var0.±ú¨ÏK∑∫õÏ…{’π∑…•;-õ ) )
        {
            var2 += ( 0, 0, var0.±ú¨ÏK∑∫õÏ…{’π∑…•;-õ[ 2 ] );
        }
        else if ( isdefined( var0.ö˘s[ü.∞◊zﬂûˇ†ˆg¬àX ) )
        {
            var2 += ( 0, 0, var0.ö˘s[ü.∞◊zﬂûˇ†ˆg¬àX[ 2 ] );
        }
    }
    
    var3 = var2;
    var4 = var2;
    
    if ( var0.ref_13923 == 2 )
    {
        var3 = skytracetoworld( var2, getdvarint( "scr_br_mxp_g_beam_z_trace", 2500 ) );
        var4 = snapaimpostonavmesh( var3 );
        
        if ( istrue( level.sentry_shouldshoot.ã 4Û®åxÌ˝9#s ) )
        {
            var4 = limitzdelta( var4, var0.±ú¨ÏK∑∫õÏ…{’π∑…•;-õ, level.sentry_shouldshoot.ñ~
†¿Â8C );
        }
        
        var4 = smoothaimposz( var0, var4 );
    }
    
    if ( !isdefined( var0.ô”¡¸ŸPñË ) )
    {
        var0.ô”¡¸ŸPñË = [];
        var0.ΩXHõfßôIT# = [];
    }
    
    var0.ô”¡¸ŸPñË[ var0.ô”¡¸ŸPñË.size ] = var4;
    var0.ΩXHõfßôIT#[ var0.ΩXHõfßôIT#.size ] = var3;
    return [ var3, var4 ];
}

// Params 1
// Size: 0x23
function getgroundnormal( var0 )
{
    var1 = scripts\engine\trace::create_contents( 0, 1 );
    var2 = scripts\mp\gametypes\br_public::modifytriggerlocation( var0, 100, -200, var1 );
    return var2[ "normal" ];
}

// Params 2
// Size: 0x1c
function skytracetoworld( var0, var1 )
{
    var2 = scripts\engine\trace::create_contents( 0, 1 );
    var3 = scripts\mp\gametypes\br_public::modifyplayer_damage( var0, var1, undefined, var2 );
    return var3;
}

// Params 1
// Size: 0x56
function snapaimpostonavmesh( var0 )
{
    if ( isscriptabledefined() )
    {
        var1 = getclosestpointonnavmesh( var0 );
        var2 = distance2d( var0, var1 );
        
        if ( var2 < getdvarint( "scr_br_mxp_g_beam_xy_nav_offset", 500 ) )
        {
            var3 = var1[ 2 ] - var0[ 2 ];
            
            if ( var3 < getdvarint( "scr_br_mxp_g_beam_z_nav_offset", 1000 ) )
            {
                var0 = ( var0[ 0 ], var0[ 1 ], var1[ 2 ] );
            }
        }
    }
    
    return var0;
}

// Params 3
// Size: 0x6b
function limitzdelta( var0, var1, var2 )
{
    if ( !isdefined( var1 ) )
    {
        return var0;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var3 = var0[ 2 ] - var1[ 2 ];
    
    if ( abs( var3 ) > var2 )
    {
        if ( !isdefined( level.ref_11e18.™ı€∞k√ÛPE@ √Y ) || level.ref_11e18.™ı€∞k√ÛPE@ √Y < abs( var3 ) )
        {
            level.ref_11e18.™ı€∞k√ÛPE@ √Y = var3;
        }
        
        var4 = scripts\engine\utility::sign( var3 );
        return ( var1 + ( 0, 0, var4 * var2 ) );
    }
    
    return var1;
}

// Params 2
// Size: 0x58
function smoothaimposz( var0, var1 )
{
    var2 = 0.5;
    
    if ( isdefined( var0.ô”¡¸ŸPñË ) )
    {
        var3 = var0.ô”¡¸ŸPñË[ var0.ô”¡¸ŸPñË.size - 1 ];
        var4 = var1[ 2 ] - var3[ 2 ];
        var5 = var4 * getdvarfloat( "scr_br_mxp_g_beam_z_smooth", var2 );
        var1 = ( var1[ 0 ], var1[ 1 ], var3[ 2 ] + var5 );
    }
    
    return var1;
}

// Params 2
// Size: 0x17
function kiosk_spent_total( var0, var1 )
{
    if ( isdefined( var1 ) && var1 > 0 )
    {
        wait var1;
    }
    
    var0 delete();
}

// Params 8
// Size: 0x186
function isaltbunkerscriptable( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    if ( !istrue( var7 ) )
    {
        radiusdamage( var0, var1, var2, var2, var3, var4, var5, 0, 1, 1 );
    }
    
    if ( getdvarint( "scr_br_mxp_damage_vehicles", 1 ) )
    {
        var8 = tablesort( var0 + ( 0, 0, -100 ), var1, 400 );
        
        foreach ( var10 in var8 )
        {
            if ( isalive( var10 ) && var10.health > 1 )
            {
                var10 dodamage( var10.health, var6, var3, var3, var4, var5 );
            }
        }
    }
    
    var12 = float( var1 * var1 );
    
    if ( isdefined( level.cratedata ) && isdefined( level.cratedata.crates ) )
    {
        foreach ( var14 in level.cratedata.crates )
        {
            if ( isdefined( var14 ) )
            {
                var15 = distance2dsquared( var14.origin, var0 );
                
                if ( var15 < var12 )
                {
                    if ( isdefined( var14.trial_flares ) )
                    {
                        var14 thread scripts\mp\gametypes\br_gametype_mendota::train_get_anim_ents_index();
                    }
                    else
                    {
                        thread destroycrate();
                    }
                }
            }
        }
    }
    
    if ( istrue( var7 ) )
    {
        var17 = scripts\engine\trace::create_contents( 1, 1, 0, 1, 0, 1, 0 );
        var18 = scripts\engine\trace::ray_trace( var6, var0, [ var3 ], var17 );
        
        if ( isdefined( var18[ "entity" ] ) )
        {
            var19 = var18[ "entity" ];
            
            if ( isalive( var19 ) && ( isplayer( var19 ) || nuke_vault_suicidebombers( var19 ) ) )
            {
                var19 dodamage( var2, var6, var3, var3, var4, var5 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x2d
function destroycrate()
{
    if ( isdefined( self.molotov_delete_oldest_trigger ) )
    {
        self.molotov_delete_oldest_trigger delete();
    }
    
    playfx( level.conf_fx[ "vanish" ], self.origin );
    scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

// Params 7
// Size: 0x21
function seq3_gate( var0, var1, var2, var3, var4, var5, var6 )
{
    seq3_cypher_tagorigin( var1, var2, var6 );
    seq3_puzzle_attempts( var0, var1, var2, var3, var4, var5, var6 );
}

// Params 3
// Size: 0x28
function seq3_cypher_tagorigin( var0, var1, var2 )
{
    var3 = spawnfx( scripts\engine\utility::getfx( "greenbay_impact_linger" ), var0, anglestoforward( var1 ), anglestoup( var1 ) );
    thread seq3_crate_usable( var3, var2 );
    return var3;
}

// Params 2
// Size: 0x11
function seq3_crate_usable( var0, var1 )
{
    triggerfx( var0 );
    wait var1;
    var0 delete();
}

// Params 7
// Size: 0x30
function seq3_puzzle_attempts( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = seq3_keypad_init( var0, var1, var2, var3, var4, var5 );
    thread seq3_reset_switch();
    thread seq3_russian_cypher_str();
    thread seq3_puzzle_complete( var7 );
    return var7;
}

// Params 6
// Size: 0x89
function seq3_keypad_init( var0, var1, var2, var3, var4, var5 )
{
    if ( !isdefined( var4 ) )
    {
        var4 = 0;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = 0;
    }
    
    if ( !isdefined( var5 ) )
    {
        var5 = level.ref_11e18.setincomingremovedcallback;
    }
    
    var6 = var1 - anglestoup( var2 ) * var4;
    var7 = spawn( "trigger_radius", var6, 0, var0, var3 );
    var7.angles = var2;
    var7.count = 0;
    var7.attacker = var5;
    var7.inflictor = var5;
    var7 hide();
    seq3_numbers_array( var7 );
    return var7;
}

// Params 0
// Size: 0x4b
function seq3_reset_switch()
{
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "trigger", var0 );
        
        if ( !isplayer( var0 ) || !isalive( var0 ) )
        {
            continue;
        }
        
        server_interact_used_think( var0 );
        seq3_has_seen_tiers( var0, self.attacker, self.inflictor, self.killcament, self );
    }
}

// Params 0
// Size: 0x7f
function seq3_russian_cypher_str()
{
    self endon( "death" );
    
    for ( ;; )
    {
        if ( self.count > 0 )
        {
            foreach ( var1 in level.sentry_shouldshoot.playersintrigger )
            {
                if ( !isdefined( var1 ) )
                {
                    continue;
                }
                
                if ( !isplayer( var1 ) || !isalive( var1 ) )
                {
                    continue;
                }
                
                if ( var1 istouching( self ) )
                {
                    continue;
                }
                
                server_rack_clip( var1 );
                seq3_keyboards( var1, self );
            }
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x48
function seq3_puzzle_complete( var0 )
{
    seq3_cleanup_leftovers( var0 );
    
    foreach ( var2 in level.sentry_shouldshoot.playersintrigger )
    {
        if ( isdefined( var2 ) )
        {
            server_rack_clip( var2 );
        }
    }
    
    thread seq3_monitor_2_spawned();
}

// Params 4
// Size: 0x1d
function seq3_has_seen_tiers( var0, var1, var2, var3 )
{
    seq3_computersused( var0, var1, var2 );
    sentry_trap_structs( var3 );
    thread seq3_sequences();
}

// Params 1
// Size: 0x11
function seq3_keyboards( var0 )
{
    seq3_emergency_lights( var0.id );
}

// Params 3
// Size: 0x82
function seq3_computersused( var0, var1, var2 )
{
    if ( !isdefined( self.seq3_thermitetank_settings ) )
    {
        var3 = spawnstruct();
        var3.timeon = 0;
        var3.timeoff = 0;
        var3.timetodamage = 0;
        var3.updatetimestamp = 0;
        var3.firstdamagedone = 0;
        var3.victim = self;
        var3.sources = [];
        self.seq3_thermitetank_settings = var3;
    }
    
    self.seq3_thermitetank_settings.attacker = var0;
    self.seq3_thermitetank_settings.inflictor = var1;
    self.seq3_thermitetank_settings.killcament = var2;
}

// Params 0
// Size: 0xfc
function seq3_sequences()
{
    self endon( "death_or_disconnect" );
    self endon( "clear_burning" );
    level endon( "game_ended" );
    self notify( "update_burning" );
    self endon( "update_burning" );
    thread sentryturret_allowpickupofturret();
    
    if ( gettime() <= self.seq3_thermitetank_settings.updatetimestamp )
    {
        waitframe();
    }
    
    var0 = undefined;
    
    for ( ;; )
    {
        foreach ( var2 in self.seq3_thermitetank_settings.sources )
        {
            if ( isdefined( var2 ) && seq3_elevator_init( var2, self ) )
            {
                if ( !isdefined( var0 ) || var2.id > var0.id )
                {
                    var0 = var2;
                }
                
                continue;
            }
            
            seq3_emergency_lights( var3 );
        }
        
        var4 = seq3_spawners_intro( self );
        
        switch ( var4 )
        {
            case "damage":
                seq3_sequences_correct( self, var0 );
                break;
            case "clear":
                thread seq3_computer_interaction();
                break;
            case "nothing":
            default:
                break;
        }
        
        wait 0.05;
    }
}

// Params 1
// Size: 0xf7
function seq3_spawners_intro( var0 )
{
    var1 = "nothing";
    
    if ( !isdefined( var0.seq3_thermitetank_settings ) )
    {
        return var1;
    }
    
    if ( var0.seq3_thermitetank_settings.timetodamage <= 0 )
    {
        var1 = "damage";
        var0.seq3_thermitetank_settings.timetodamage = 0.25;
    }
    else
    {
        var0.seq3_thermitetank_settings.timetodamage -= 0.05;
    }
    
    if ( sequence_interaction_hint( var0 ) )
    {
        var0.seq3_thermitetank_settings.timeoff = 0;
        var0.seq3_thermitetank_settings.timeon += 0.05;
    }
    else
    {
        var0.seq3_thermitetank_settings.timeoff += 0.05;
        
        if ( var0.seq3_thermitetank_settings.timeoff >= 0.25 )
        {
            var1 = "clear";
        }
    }
    
    var0.seq3_thermitetank_settings.updatetimestamp = gettime();
    return var1;
}

// Params 2
// Size: 0x8a
function seq3_sequences_correct( var0, var1 )
{
    if ( !isdefined( var0.seq3_thermitetank_settings ) || !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = 25;
    var3 = var1.attacker.origin;
    var4 = var1.attacker;
    var5 = var1.attacker;
    var0 dodamage( var2, var3, var4, var5, "MOD_EXPLOSIVE", getcompleteweaponname( "greenbay_strike" ) );
    
    if ( !istrue( var0.seq3_thermitetank_settings.firstdamagedone ) )
    {
        playfxontagforclients( scripts\engine\utility::getfx( "greenbay_impact_player" ), var0, "tag_eye", var0 );
    }
    
    var0.seq3_thermitetank_settings.firstdamagedone = 1;
}

// Params 1
// Size: 0x2b, Type: bool
function seq3_elevator_init( var0 )
{
    if ( !sequence_interaction_hint( var0 ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.seq3_thermitetank_settings.sources[ self.id ] ) )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x1d
function sentryturret_allowpickupofturret()
{
    self notify( "cleanup_burning" );
    self endon( "cleanup_burning" );
    GscBinSkip4( 0x35 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 0
// Size: 0x25
function sentryturret_canpickup()
{
    self endon( "disconnect" );
    self endon( "clear_burning" );
    level endon( "game_ended" );
    self waittill( "death" );
    thread seq3_computer_interaction();
}

// Params 0
// Size: 0x1e
function sentryturret_watchgameend()
{
    self endon( "death_or_disconnect" );
    self endon( "clear_burning" );
    level waittill( "game_ended" );
    thread seq3_computer_interaction();
}

// Params 1
// Size: 0xd
function seq3_cleanup_leftovers( var0 )
{
    self endon( "death" );
    wait var0;
}

// Params 0
// Size: 0x78
function seq3_computer_interaction()
{
    self notify( "clear_burning" );
    
    if ( isdefined( self.seq3_thermitetank_settings ) && isdefined( self.seq3_thermitetank_settings.sources ) )
    {
        foreach ( var1 in self.seq3_thermitetank_settings.sources )
        {
            seq3_emergency_lights( var1.id );
        }
    }
    
    stopfxontagforclients( scripts\engine\utility::getfx( "greenbay_impact_player" ), self, "tag_eye", self );
    self.seq3_thermitetank_settings = undefined;
}

// Params 1
// Size: 0x23
function sentry_trap_structs( var0 )
{
    if ( !isdefined( self.seq3_thermitetank_settings ) )
    {
        return;
    }
    
    self.seq3_thermitetank_settings.sources[ var0.id ] = var0;
}

// Params 1
// Size: 0x1b
function seq3_emergency_lights( var0 )
{
    if ( !isdefined( self.seq3_thermitetank_settings ) )
    {
        return;
    }
    
    self.seq3_thermitetank_settings.sources[ var0 ] = undefined;
}

// Params 0
// Size: 0x1a
function seq3_digits_display_array()
{
    if ( !isdefined( self.seq3_thermitetank_settings ) )
    {
        return 0;
    }
    
    return self.seq3_thermitetank_settings.sources.size;
}

// Params 1
// Size: 0x24, Type: bool
function seq3_displaymodels( var0 )
{
    return seq3_digits_display_array() == 1 && isdefined( self.seq3_thermitetank_settings.sources[ var0.id ] );
}

// Params 0
// Size: 0x1b
function seq3_numbers_array()
{
    self.id = seq3_warning_tier();
    self.stab_blink_black_fade = seq3_warning_room_b();
    seq3_tier( self );
}

// Params 0
// Size: 0xe
function seq3_monitor_2_spawned()
{
    sequence_interaction_init( self );
    self delete();
}

// Params 7
// Size: 0x9c
function seq3_sequence( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( self.ref_13923 != 2 )
    {
        return;
    }
    
    if ( !isdefined( self.é“8_ãxiéJ˝+É+- ) )
    {
        self.é“8_ãxiéJ˝+É+- = gettime();
    }
    
    if ( !isdefined( self.±˘s˚É≥8ôs=ì·
‹´õ ) )
    {
        self.±˘s˚É≥8ôs=ì·
‹´õ = gettime();
    }
    
    if ( self.é“8_ãxiéJ˝+É+- <= gettime() )
    {
        seq3_cypher_tagorigin( var1, var2, var6 );
        self.é“8_ãxiéJ˝+É+- = gettime() + getdvarfloat( "scr_br_mxp_g_burnSpotFreq_effect", 0.25 ) * 1000;
    }
    
    if ( self.±˘s˚É≥8ôs=ì·
‹´õ <= gettime() )
    {
        seq3_puzzle_attempts( var0, var1, var2, var3, var4, var5, var6 );
        self.±˘s˚É≥8ôs=ì·
‹´õ = gettime() + getdvarfloat( "scr_br_mxp_g_burnSpotFreq_trigger", 0.25 ) * 1000;
        return;
    }
}

// Params 6
// Size: 0xbb
function greenbayburn_spawnrayburn( var0, var1, var2, var3, var4, var5 )
{
    if ( !isdefined( var1 ) || !isdefined( var2 ) || !isdefined( self.∏Àﬂ˘ø+|8≥-≥(¯æ2és; ) )
    {
        return;
    }
    
    wait 3;
    var6 = 256;
    var7 = 60;
    var8 = 448;
    var9 = anglestoforward( var2 ) * var8;
    seq3_gate( var0, var1, var2, var3, 0, var4, var5 );
    
    for ( var10 = 0; var10 < 6 ; var10++ )
    {
        var11 = rotatepointaroundvector( self.∏Àﬂ˘ø+|8≥-≥(¯æ2és;, var9, var7 * var10 );
        var12 = skytracetoworld( var1 + var11, 250 );
        
        if ( !isdefined( var12 ) )
        {
            continue;
        }
        
        var13 = limitzdelta( var12, var1, var6 );
        
        if ( var13[ 2 ] != var12[ 2 ] )
        {
            continue;
        }
        
        seq3_gate( var0, var12, var2, var3, 0, var4, var5 );
    }
}

// Params 1
// Size: 0x1d
function sequence_progression( var0 )
{
    level.sentry_shouldshoot.inuse = var0;
    ref_13186( "g", var0 );
}

// Params 0
// Size: 0xe
function sequence_interaction_activate()
{
    return level.sentry_shouldshoot.inuse;
}

// Params 0
// Size: 0x2a
function seq3_warning_room_b()
{
    if ( !isdefined( level.sentry_shouldshoot.stab_blink_black_fade ) )
    {
        level.sentry_shouldshoot.stab_blink_black_fade = 0;
    }
    
    return level.sentry_shouldshoot.stab_blink_black_fade;
}

// Params 0
// Size: 0x1f
function seq3_wheelson_starts()
{
    if ( !isdefined( level.sentry_shouldshoot.stab_blink_black_fade ) )
    {
        level.sentry_shouldshoot.stab_blink_black_fade = 0;
        return;
    }
}

// Params 0
// Size: 0x1e
function seq3_warning_tier()
{
    var0 = level.sentry_shouldshoot.ref_13dc5;
    level.sentry_shouldshoot.ref_13dc5++;
    return var0;
}

// Params 1
// Size: 0x21
function seq3_tier( var0 )
{
    level.sentry_shouldshoot.triggers = scripts\engine\utility::array_add( level.sentry_shouldshoot.triggers, var0 );
}

// Params 1
// Size: 0x21
function sequence_interaction_init( var0 )
{
    level.sentry_shouldshoot.triggers = scripts\engine\utility::array_remove( level.sentry_shouldshoot.triggers, var0 );
}

// Params 1
// Size: 0x2a
function server_interact_used_think( var0 )
{
    if ( seq3_elevator_init( var0 ) )
    {
        return;
    }
    
    self.count++;
    var1 = var0 getentitynumber();
    level.sentry_shouldshoot.playersintrigger[ var1 ] = var0;
}

// Params 1
// Size: 0x34
function server_rack_clip( var0 )
{
    if ( !seq3_elevator_init( var0 ) )
    {
        return;
    }
    
    self.count--;
    
    if ( seq3_digits_display_array( var0 ) <= 0 )
    {
        var1 = var0 getentitynumber();
        level.sentry_shouldshoot.playersintrigger[ var1 ] = undefined;
        return;
    }
}

// Params 1
// Size: 0x22, Type: bool
function sequence_interaction_hint( var0 )
{
    if ( !isdefined( var0.seq3_thermitetank_settings ) )
    {
        return false;
    }
    
    return var0.seq3_thermitetank_settings.sources.size > 0;
}

// Params 0
// Size: 0x25, Type: bool
function nuke_vault_suicidebombers()
{
    return isalive( self ) && ( scripts\common\vehicle::isvehicle() || isdefined( self.classname ) && self.classname == "script_vehicle" );
}

// Params 6
// Size: 0xf5
function makepreviewimpactcircle( var0, var1, var2, var3, var4, var5 )
{
    var6 = var4 * 2;
    var7 = 2 + int( ceil( ( var5 - var6 ) / var6 ) );
    var8 = var4 + getdvarint( "scr_br_mxp_g_extend", 500 );
    var9 = var5 + var4 + var4;
    var10 = vectortoangles( var3 );
    var11 = float( var9 ) / var4;
    
    for ( var12 = 0; var12 < var7 - 1 ; var12++ )
    {
        var13 = var0 + var3 * var12 * var6;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "dangerNotifyPlayersInRange" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "dangerNotifyPlayersInRange" ) ]]( var13, var8, "greenbay_strike", 0 );
        }
        
        thread gplaykillstreakincomingdialog( var13, var8 );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "dangerNotifyPlayersInRange" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "dangerNotifyPlayersInRange" ) ]]( var2, var8, "greenbay_strike", 0 );
    }
    
    thread gplaykillstreakincomingdialog( var2, var8 );
    var14 = ref_11a9f( var1, var4, 1, 6 );
    var14.angles = ( var11, var10[ 1 ], 0 );
    return var14;
}

// Params 4
// Size: 0x28
function ref_11a9f( var0, var1, var2, var3 )
{
    var4 = getmaxobjectivecount( var0[ 0 ], var0[ 1 ], var1 );
    var4 setmapcirclecolorindex( var2 );
    var4 setmapcircleiconindex( 0 );
    var4 setmapcirclestyleindex( var3 );
    return var4;
}

// Params 2
// Size: 0x195
function vehicle_showteamtanks( var0, var1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    kenoshastrike_cleanupinterruptedstreak();
    
    if ( isplayer( self ) )
    {
        vehicle_spawn_abandonedtimeoutcallback( 1 );
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "k_attack_used", self );
    }
    
    var1.shots_fired++;
    var2 = var0.location;
    kenoshastrike_setuptarget( var0, var1 );
    
    if ( getdvarint( "scr_br_mxp_ks_marker", 0 ) == 1 )
    {
        var3 = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "requestObjectiveID" ) )
        {
            var3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "requestObjectiveID" ) ]]( 99 );
        }
        
        if ( isdefined( var3 ) )
        {
            server_activate( var3, "ui_mp_br_hud_icon_kenosha", self, var1.origin + ( 0, 0, 50 ) );
            thread greenbaystrike_handlemarker( level );
        }
    }
    
    var1.ref_134e3 = scripts\mp\gametypes\br_alt_mode_mxp::vehiclespawn_littlebirdmg();
    var4 = var2 - var1.ref_134e3;
    var4 = vectornormalize( ( var4[ 0 ], var4[ 1 ], 0 ) );
    var5 = -1 * var4;
    var6 = getdvarint( "scr_br_mxp_g_extend", 500 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "dangerNotifyPlayersInRange" ) )
    {
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "dangerNotifyPlayersInRange" ) ]]( var1.origin, var1.change_fronttruck_label + var6, "kenosha_strike", 0 );
    }
    
    thread kplaykillstreaksentdialog( var1.origin, var1.change_fronttruck_label + var6 );
    var1.startorigin = var1.ref_134e3;
    var1.endorigin = var1.origin;
    var1.start_area_fx_end = ref_11a9f( var1.endorigin, var1.change_fronttruck_label, 1, 5 );
    
    if ( isplayer( self ) )
    {
        thread scripts\mp\hud_message::showsplash( "br_gametype_mendota_kenosha_streak" );
    }
    
    scripts\mp\gametypes\br_alt_mode_mxp::waitfor_firstgroup_killedoffenough( var1 );
}

// Params 2
// Size: 0x10a
function kenoshastrike_setuptarget( var0, var1 )
{
    var2 = var0.location;
    var1.origin = var2;
    var1.change_goal_radius_weapons_free_internal = "long";
    var1.change_fronttruck_label = level.vehicle_shoulddocollisiondamagetoplayer.±u`ã°zÓÜˇ[3;
    
    if ( isdefined( var1.radius ) )
    {
        var1.change_fronttruck_label = var1.radius;
    }
    
    var3 = level.ref_11e18.wait_for_next_hack_complete.origin;
    
    if ( scripts\mp\gametypes\br_alt_mode_mxp::kinjumpstate() )
    {
        var4 = scripts\mp\gametypes\br_alt_mode_mxp::kgetnextindexorigin();
        var5 = var4[ 0 ];
        var3 = var4[ 1 ];
        var4 = undefined;
    }
    else
    {
        var6 = scripts\mp\gametypes\br_alt_mode_mxp::khastomoveforkillstreak();
        var7 = var6[ 0 ];
        var8 = var6[ 1 ];
        var6 = undefined;
        
        if ( var7 )
        {
            var3 = scripts\mp\gametypes\br_alt_mode_mxp::kgetindexorigin( var8 );
        }
    }
    
    var9 = distance2d( var2, var3 );
    
    if ( var9 <= level.vehicle_shoulddocollisiondamagetoplayer.±u`ã°zÓÜˇ[3 )
    {
        var1.origin = var3;
        var1.change_fronttruck_label = level.vehicle_shoulddocollisiondamagetoplayer.±u`ã°zÓÜˇ[3;
        var1.change_goal_radius_weapons_free_internal = 2;
        return;
    }
    
    if ( var9 <= level.vehicle_shoulddocollisiondamagetoplayer.¨L	/–“≤uÔ )
    {
        var1.change_goal_radius_weapons_free_internal = 1;
        return;
    }
    
    var1.change_goal_radius_weapons_free_internal = 0;
}

// Params 0
// Size: 0x43
function kenoshastrike_cleanupinterruptedstreak()
{
    if ( !isdefined( level.ref_11e18.wait_for_next_hack_complete.vo_one_remain ) )
    {
        return;
    }
    
    var0 = level.ref_11e18.wait_for_next_hack_complete.vo_one_remain;
    level.ref_11e18.wait_for_next_hack_complete.vo_one_remain = undefined;
    kenoshastrike_cleanuppreviewentities( var0 );
}

// Params 1
// Size: 0x2cc
function vehicle_spawn_cancelpendingrespawns( var0 )
{
    level endon( "game_ended" );
    vehicle_spawn_abandonedtimeoutcallback( 0 );
    scripts\mp\gametypes\br_alt_mode_mxp::kendkillstreak();
    var1 = level.ref_11e18.wait_for_next_hack_complete;
    
    if ( var0.change_goal_radius_weapons_free_internal == 0 || var0.change_goal_radius_weapons_free_internal == 1 )
    {
        var1 setscriptablepartstate( "rumble", "light", 0 );
        var2 = var1 gettagorigin( "tag_sync" );
        var3 = spawn( "script_model", var2 );
        var3 setmodel( "lm_rock_boulder_02_kenosha_s3" );
        var0.äì{6m = var3;
        var3 linkto( var1, "tag_sync", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var3 dontinterpolate();
        var3 unmarkkeyframedmover( 1 );
        level.ref_11e18.wait_for_next_hack_complete scripts\engine\utility::waittill_notify_or_timeout( "kenosha_throw_rock", 2.25 );
        var0.circleent = ref_11a9f( var0.startorigin, var0.change_fronttruck_label, 0, 2 );
        var4 = distance2d( var0.startorigin, var0.endorigin );
        var5 = kcalculaterockthrowvalues( var4 );
        var6 = var5[ 0 ];
        var7 = var5[ 1 ];
        var5 = undefined;
        var8 = var4 / var6;
        var3 unlink();
        var9 = -1 * var7;
        var10 = trajectorycalculateinitialvelocity( var3.origin, var0.origin, ( 0, 0, var9 ), var8 );
        var3 movegravity( var10, var8, var7 );
        var3 setscriptablepartstate( "trail", "active", 0 );
        var0.circleent moveto( ( var0.endorigin[ 0 ], var0.endorigin[ 1 ], var0.change_fronttruck_label ), var8, 0.1, 0.1 );
        wait var8;
        var3 setscriptablepartstate( "explode", "active", 0 );
        thread vehicle_spawn_abandonedtimeout();
    }
    
    var11 = var0.owner;
    
    if ( !isplayer( var11 ) )
    {
        var11 = var1;
    }
    
    isaltbunkerscriptable( var0.origin + ( 0, 0, 100 ), var0.change_fronttruck_label, 1000, var11, "MOD_EXPLOSIVE", getcompleteweaponname( "kenosha_strike" ), var0.ref_134e3 );
    isaltbunkerscriptable( var0.origin + ( 0, 0, 500 ), var0.change_fronttruck_label, 1000, var11, "MOD_EXPLOSIVE", getcompleteweaponname( "kenosha_strike" ), var0.ref_134e3 );
    isaltbunkerscriptable( var0.origin + ( 0, 0, 1000 ), var0.change_fronttruck_label, 1000, var11, "MOD_EXPLOSIVE", getcompleteweaponname( "kenosha_strike" ), var0.ref_134e3 );
    
    if ( isdefined( var11 ) && isplayer( var11 ) )
    {
        var11 notify( "greenbay_strike_finished" );
        var11 scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var0 );
    }
    
    kenoshastrike_cleanuppreviewentities( var0 );
    
    if ( var0.change_goal_radius_weapons_free_internal == 0 || var0.change_goal_radius_weapons_free_internal == 1 )
    {
        wait 1;
        
        if ( isdefined( var0.circleent ) )
        {
            var0.circleent delete();
        }
        
        wait 1.5;
        
        if ( isdefined( var0.äì{6m ) )
        {
            var0.äì{6m delete();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0xa9
function kcalculaterockthrowvalues( var0 )
{
    var1 = level.vehicle_shoulddocollisiondamagetoplayer.ålíàsÔÎ3Ω=)Æ_ö8∑˚˚P7‡;
    var2 = level.vehicle_shoulddocollisiondamagetoplayer.Öé”›«ß_(hQfÑ€À°C{˛Í!†ﬂ';
    
    if ( var0 > level.vehicle_shoulddocollisiondamagetoplayer.°\WÉ—ã⁄kX(7 )
    {
        var1 = level.vehicle_shoulddocollisiondamagetoplayer.è8c}Á∑°ÿKMÏY]w[ZØÛò6™πkz;
        var2 = level.vehicle_shoulddocollisiondamagetoplayer.∂È¢– S¡úÕß√√=kØÄ8]o	ÙônÉìè3;
    }
    else if ( var0 > level.vehicle_shoulddocollisiondamagetoplayer.áV
6ﬁõÏ',Õùï )
    {
        var1 = level.vehicle_shoulddocollisiondamagetoplayer.£ìÛØc™{ë›!a6∞2NÀ¯@;"w:;
        var2 = level.vehicle_shoulddocollisiondamagetoplayer.•¬√`Œ¬~‚∫`r$¯ÿœ1·⁄¢àÿ≠;
    }
    else if ( var0 > level.vehicle_shoulddocollisiondamagetoplayer.¨L	/–“≤uÔ )
    {
        var1 = level.vehicle_shoulddocollisiondamagetoplayer.Öà≥
wB	2ò+¥ÿ‚n;rÎå+;
        var2 = level.vehicle_shoulddocollisiondamagetoplayer.ô8N{çµÎŸìX;“:ÚÎÿÌ7ÏØì,π≥V;
    }
    
    return [ var1, var2 ];
}

// Params 1
// Size: 0xf
function kenoshastrike_cleanuppreviewentities( var0 )
{
    var0.start_area_fx_end delete();
}

// Params 1
// Size: 0x1d
function vehicle_spawn_abandonedtimeoutcallback( var0 )
{
    level.vehicle_shoulddocollisiondamagetoplayer.inuse = var0;
    ref_13186( "k", var0 );
}

// Params 0
// Size: 0xe
function vehicle_showvalidlittlebirds()
{
    return level.vehicle_shoulddocollisiondamagetoplayer.inuse;
}

// Params 0
// Size: 0x26
function vehicle_spawn_abandonedtimeout()
{
    self endon( "death" );
    wait 0.05;
    self setscriptablepartstate( "trail", "neutral", 0 );
    self hide( 1 );
}

// Params 4
// Size: 0x69
function server_activate( var0, var1, var2, var3 )
{
    objective_icon( var0, var1 );
    objective_showtoplayersinmask( var0 );
    
    if ( isplayer( var2 ) )
    {
        objective_addclienttomask( var0, var2 );
    }
    
    objective_position( var0, var3 );
    objective_setplayintro( var0, 0 );
    objective_setplayoutro( var0, 0 );
    objective_setbackground( var0, 1 );
    
    if ( level.teambased || !isplayer( var2 ) )
    {
        objective_setownerteam( var0, var2.team );
    }
    else
    {
        objective_setownerclient( var0, var2 );
    }
    
    objective_state( var0, "current" );
}

// Params 1
// Size: 0x32
function greenbaystrike_handlemarker( var0 )
{
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 10 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "returnObjectiveID" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "returnObjectiveID" ) ]]( var0 );
        return;
    }
}

// Params 1
// Size: 0x21
function server_unlocked( var0 )
{
    self endon( "greenbay_strike_finished" );
    self endon( "disconnect" );
    level waittill( "game_ended" );
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7( var0 );
}

// Params 1
// Size: 0xa
function ref_1266a( var0 )
{
    self.ref_1300b = var0;
}

// Params 2
// Size: 0x6f
function gplaykillstreakincomingdialog( var0, var1 )
{
    var2 = self.team != "neutral";
    var3 = scripts\common\utility::playersincylinder( var0, var1 );
    
    foreach ( var5 in var3 )
    {
        if ( var2 && var5.team != self.team )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "g_incoming_attack_player", var5 );
            continue;
        }
        
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "g_incoming_attack", var5 );
    }
}

// Params 2
// Size: 0x6f
function kplaykillstreaksentdialog( var0, var1 )
{
    var2 = self.team != "neutral";
    var3 = scripts\common\utility::playersincylinder( var0, var1 );
    
    foreach ( var5 in var3 )
    {
        if ( var2 && var5.team != self.team )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "k_incoming_attack_player", var5 );
            continue;
        }
        
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "k_incoming_attack", var5 );
    }
}

// Params 2
// Size: 0x51
function ref_13186( var0, var1 )
{
    var2 = 0;
    
    if ( var0 == "k" )
    {
        var2 = 1;
    }
    
    var3 = 0;
    
    if ( istrue( var1 ) )
    {
        var3 = 1;
    }
    
    var4 = 1;
    var5 = var2;
    var6 = var3 << var5;
    var7 = ~( 1 << var5 );
    var8 = getomnvar( "ui_mendota_killstreaks" );
    var9 = var8 & var7;
    var10 = var9 + var6;
    setomnvar( "ui_mendota_killstreaks", var10 );
}

