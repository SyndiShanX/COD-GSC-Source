
// Params 0
// Size: 0xceb
function main()
{
    level.ref_14434 = 1;
    level.nobroshot = 1;
    level.clearstockondrop = 1;
    level.loadoutdefaultfiresalediscount = 1;
    level.armoronweaponswitchlongpress = 1;
    level.iscacprimaryweapongroup = 1;
    level.noweaponfalloff = 0;
    level.half_size = 2;
    level.vehicle_occupancy_forceweaponswitchallowed = 1;
    level.client_activate = 0;
    level.debug_safehouse_regroup_start = getdvarint( "scr_br_allowLoadout", 0 );
    level.debug_show2dvotext = getdvarint( "scr_br_allowLoadoutOnlyInPreLobby", 0 );
    level.delay_spawn_room_soldiers = getdvarint( "scr_br_meleefinisher_clamp", 0 );
    level.delay_spawn_tanks = getdvarint( "scr_br_meleefinisher_damage", 120 );
    level.deletehistoryhud = getdvarfloat( "scr_br_s4shotgun_scalar", 1 );
    level.deletecrateimmediate = getdvarfloat( "scr_br_s4pistol_scalar", 1 );
    level.deleteallglass = getdvarint( "scr_br_remove_stimregen_onhit", 0 );
    level.deleteable = getdvarint( "scr_br_remove_natregen_onhit", 1 );
    level.deletescriptableinstanceaftertime_proc = getdvarint( "scr_br_stim_cancel_threshold", 1 );
    level.deletesecretstashhud = getdvarfloat( "scr_br_stim_movespeed_scalar", 1.2 );
    level.delay_show_balloon = getdvarint( "scr_br_me_proj_head_dmg", 300 );
    level.delay_show_marker_to_tv_station = getdvarint( "scr_br_me_proj_neck_dmg", 300 );
    level.delay_spawn_nav_repulsor = getdvarint( "scr_br_me_proj_utorso_dmg", 300 );
    level.delay_show_player_clip = getdvarint( "scr_br_me_proj_uarm_dmg", 300 );
    level.åyæ7ª˛∏7cIq°S+›)¶è9¿à' = getdvarint( "scr_br_fixed_sniper_hsdmg", 0 );
    level.∂KBh7–£O3v∞∫Û´4Úú#?‡?~™π≥5 = getdvarint( "scr_br_speedboost_pickup_enable", 1 );
    level.decide_new_code = getdvarint( "scr_br_circle_frailty_enabled", 0 );
    
    if ( level.decide_new_code == 1 )
    {
        level.decoy_clearaithreatbiasgroup = getdvarfloat( "scr_player_gas_timer_mult_time_1", 60 );
        level.decoy_giveassistpoint = getdvarfloat( "scr_player_gas_timer_mult_time_2", 90 );
        level.decoy_delaystoptrackingassist = getdvarfloat( "scr_player_gas_timer_mult_time_3", 120 );
        level.decoy_aicanseeanyplayer = getdvarfloat( "scr_br_circle_frailty_multi_1", 1.1 );
        level.decoy_canseeplayer = getdvarfloat( "scr_br_circle_frailty_multi_2", 1.2 );
        level.decoy_aiseenplayerrecently = getdvarfloat( "scr_br_circle_frailty_multi_3", 1.3 );
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    
    if ( level.∂KBh7–£O3v∞∫Û´4Úú#?‡?~™π≥5 == 1 )
    {
        _keypadscriptableused_bunkeralt::init();
        _keypadscriptableused::init();
        scripts\mp\utility\sound::besttime( "mp_tu_canteen_sfx" );
    }
    
    setdvarifuninitialized( "wsow_event_dvar_hot_reload", 0 );
    scripts\mp\gametypes\br_gametypes::init();
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "allowLateJoiners" ) )
    {
        level.brkillchainchance = 1;
    }
    
    level.defend_spawn_crates = getdvarint( "scr_br_death_watch", 1.5 );
    GscBinSkip1( 0x45, 0, scripts\mp\utility\game::getgametype() );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 0
// Size: 0x43
function ref_12803()
{
    scripts\mp\gametypes\br_alt_mode_inflation::init();
    thread scripts\mp\gametypes\br_zones::init();
    thread scripts\mp\gametypes\br_c130airdrop::init();
    thread scripts\mp\gametypes\br_jugg_common::init();
    thread scripts\mp\gametypes\br_dev::init();
    scripts\mp\utility\sound::besttime( "weapon_turret_aa" );
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "postMainInit" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e05( "postMainInit" );
        return;
    }
}

// Params 0
// Size: 0x2c
function waitthensetstatgroupreadonly()
{
    self endon( "game_ended" );
    wait 1;
    
    if ( isdefined( level.playerstats ) )
    {
        scripts\mp\playerstats_interface::makeplayerstatgroupreadonly( "losses" );
        scripts\mp\playerstats_interface::makeplayerstatgroupreadonly( "winLoss" );
        return;
    }
}

// Params 0
// Size: 0x35
function entcleanup()
{
    for ( var0 = 1; var0 < 10 ; var0++ )
    {
        _delete_ents( "script_noteworthy", "locale_" + var0 );
    }
    
    _delete_ents( "script_noteworthy", "locale_99" );
}

// Params 2
// Size: 0x16
function _delete_ents( var0, var1 )
{
    var2 = getentarray( var1, var0 );
    scripts\engine\utility::array_call( var2, &delete );
}

// Params 1
// Size: 0x47a
function totalroundtime( var0 )
{
    var1 = tablelookupgetnumcols( "mp/classtable_br.csv" ) - 1;
    GscBinSkip1( 0x45, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 3
// Size: 0xdc
function searchcircleorigin( var0, var1, var2 )
{
    if ( !isdefined( level.deletescriptableinstanceaftertime ) )
    {
        level.deletescriptableinstanceaftertime = totalroundtime( var0 );
    }
    
    self.pers[ "gamemodeLoadout" ] = level.deletescriptableinstanceaftertime;
    self.class = "gamemode";
    self.prevweaponobj = undefined;
    var3 = scripts\mp\class::loadout_getclassstruct();
    var3 = scripts\mp\class::loadout_updateclass( var3, "gamemode" );
    scripts\mp\class::preloadandqueueclassstruct( var3, 1, 1 );
    self takeallweapons();
    scripts\mp\class::giveloadout( self.team, "gamemode", var1, var1 );
    
    if ( !issubstr( var3.loadoutprimaryobject.basename, "fist" ) )
    {
        self givestartammo( var3.loadoutprimaryobject );
    }
    
    if ( !issubstr( var3.loadoutprimaryobject.basename, "fist" ) )
    {
        self givestartammo( var3.loadoutsecondaryobject );
    }
    
    scriptednode( self );
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    
    if ( !istrue( var2 ) )
    {
        scripts\mp\gametypes\br_weapons::delay_add_to_chopper_boss_drone_target_array();
    }
    
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( self );
    self notify( "ammo_update" );
}

// Params 0
// Size: 0xad
function ref_11e23()
{
    if ( disable_collect_leads() )
    {
        var0 = 0;
        
        if ( istrue( self.shouldhumanspawntags ) )
        {
            return;
        }
        
        var1 = isdefined( self.shouldhumanspawntags ) && !self.shouldhumanspawntags;
        
        if ( var1 )
        {
            var0 = 1;
        }
        
        var2 = disablealltablets();
        searchcircleorigin( var2, var0 );
        
        if ( var1 )
        {
            self.shouldhumanspawntags = 1;
        }
    }
    else if ( disable_fulton_group_interactions() )
    {
        givematchloadoutfordropbags();
    }
    else if ( disable_cinematic_skip() )
    {
        var3 = disable_usability_for_duration();
        var4 = disable_timer();
        givematchloadout( var3, var4 );
    }
    else
    {
        scripts\mp\utility\script::laststand_dogtags( "The naked-drop loadout was not provided. Probably because the drop function should be overridden or scr_br_allowLoadoutOnlyInPreLobby should be set to 0. See IWH-426702." );
    }
    
    if ( isdefined( level.obit_activation ) && level.obit_activation.ref_129da == 1 )
    {
        disablearmorykiosk();
        return;
    }
}

// Params 0
// Size: 0x65
function nakeddrop()
{
    var0 = scripts\mp\gametypes\br_gulag::set_solution();
    
    if ( var0 && scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerAdditionalGulagDropLogic" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e05( "playerAdditionalGulagDropLogic" );
    }
    
    if ( !var0 && istrue( level.br_prematchstarted ) && !istrue( self.gulag ) )
    {
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerNakedDropLoadout" ) )
        {
            scripts\mp\gametypes\br_gametypes::ref_12e05( "playerNakedDropLoadout" );
        }
        else
        {
            ref_11e23();
        }
    }
    
    thread defend_wave_2();
}

// Params 0
// Size: 0xe4
function ref_1195b()
{
    if ( istrue( self.use_armor ) )
    {
        self.use_armor = undefined;
        return;
    }
    
    var0 = self.class;
    
    if ( istrue( self.thrownspecialcount ) )
    {
        if ( istrue( level.scriptedphysicaldofenabled ) )
        {
            if ( isdefined( self.wam_sequence ) )
            {
                var0 = self.wam_sequence;
            }
        }
        else
        {
            self.pers[ "gamemodeLoadout" ] = level.br_respawn_loadout;
            var0 = "gamemode";
        }
    }
    
    var1 = scripts\mp\class::preloadandqueueclass( var0, 1 );
    thread scripts\mp\class::swaploadout();
    
    if ( var0 != "gamemode" )
    {
        scripts\cp_mp\utility\inventory_utility::_takeweapon( "iw8_fists_mp" );
    }
    
    self.ref_13bcc = 0;
    
    if ( !istrue( self.ref_1285b ) )
    {
        if ( istrue( level.scriptedphysicaldofenabled ) )
        {
            disablearmorykiosk();
        }
    }
    
    self.ref_1285b = 1;
    
    if ( !istrue( self.thrownspecialcount ) )
    {
        if ( istrue( level.br_prematchstarted ) )
        {
            if ( istrue( level.scriptedphysicaldofenabled ) )
            {
                disablearmorykiosk();
            }
            
            self.thrownspecialcount = 1;
        }
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerDropLoadout" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e05( "playerDropLoadout" );
    }
    
    thread defend_wave_2();
}

// Params 4
// Size: 0x171
function managerespawnfade( var0, var1, var2, var3 )
{
    var4 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    var5 = 70;
    var6 = var1.origin - var0.origin;
    var7 = ( var6[ 0 ], var6[ 1 ], 0 );
    var8 = 0;
    
    if ( length2d( var7 ) > 0.001 )
    {
        var9 = vectornormalize( var7 );
        var10 = vectortoangles( var9 );
        var8 = angleclamp180( var10[ 1 ] );
    }
    
    var11 = var0.origin;
    var12 = ( cos( var8 ), sin( var8 ), 0 );
    var12 = vectornormalize( var12 );
    var12 *= var5;
    var13 = scripts\mp\gametypes\br_public::ref_12a1c( var11, var12[ 0 ], var12[ 1 ], var2, var3, var4, var0 );
    
    if ( var13[ "fraction" ] < 1 )
    {
        var14 = var13[ "position" ] + ( 0, 0, 0.001 );
        var15 = var11 + ( 0, 0, 30 );
        var16 = scripts\engine\trace::ray_trace( var15, var14, var0, var4 );
        
        if ( var16[ "fraction" ] >= 1 )
        {
            var1 setorigin( var14 );
            return;
        }
    }
    
    var13 = scripts\mp\gametypes\br_public::ref_12a1c( var11, 0, 0, var2, var3, var4 );
    
    if ( var13[ "fraction" ] < 1 )
    {
        var17 = var13[ "position" ] + ( 0, 0, 0.2 );
        var18 = var13[ "position" ] + ( 0, 0, 1 );
        var19 = playerphysicstrace( var17, var18 );
        
        if ( var19 == var18 )
        {
            var1 setorigin( var13[ "position" ] );
            return;
        }
    }
    
    var1 kill( var0.origin );
}

// Params 0
// Size: 0x3e
function disablearmorykiosk()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "giveStartFieldUpgrade" ) )
    {
        return;
    }
    
    if ( istrue( level.allowsupers ) )
    {
        var0 = scripts\mp\supers::getcurrentsuper();
        
        if ( isdefined( var0 ) )
        {
            scripts\mp\supers::givesuperpoints( scripts\mp\supers::getsuperpointsneeded() );
            return;
        }
        
        return;
    }
    
    scripts\mp\gametypes\br_pickups::forcegivesuper( self.ref_11954 );
}

// Params 2
// Size: 0x58, Type: bool
function emp_drone( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isalive( var0 ) )
    {
        return false;
    }
    
    if ( istrue( var0.gulag ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.team ) )
    {
        return false;
    }
    
    if ( isdefined( var1 ) && var1.team != var0.team )
    {
        return false;
    }
    
    if ( isdefined( var1 ) && var1 == var0 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x128
function emp_drone_clean_up( var0 )
{
    if ( !isdefined( var0 ) || !isdefined( var0.pers[ "squadMemberIndex" ] ) || !isdefined( var0.ref_13ab3 ) )
    {
        return;
    }
    
    var1 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var0.team, 1 );
    var2 = "outline_nodepth_brplayer" + var0.pers[ "squadMemberIndex" ];
    var3 = getdvarint( "scr_br_hudoutlineForTeammatesDistance", 1024 );
    var4 = squared( var3 );
    var5 = emp_drone( var0 );
    
    foreach ( var7 in var1 )
    {
        var8 = var7 getentitynumber();
        var9 = var5 && emp_drone( var7, var0 );
        
        if ( var9 )
        {
            var10 = distancesquared( var0.origin, var7.origin );
            
            if ( var10 > var4 )
            {
                var9 = 0;
            }
        }
        
        if ( !var9 )
        {
            if ( isdefined( var0.ref_13ab3[ var8 ] ) )
            {
                scripts\mp\utility\outline::outlinedisable( var0.ref_13ab3[ var8 ], var0 );
                var0.ref_13ab3[ var8 ] = undefined;
            }
            
            continue;
        }
        
        if ( !isdefined( var0.ref_13ab3[ var8 ] ) )
        {
            var0.ref_13ab3[ var8 ] = scripts\mp\utility\outline::outlineenableforplayer( var0, var7, var2, "level_script" );
        }
    }
}

// Params 1
// Size: 0x1d
function emp_drone_clean_up_func( var0 )
{
    var0 endon( "disconnect" );
    
    for ( ;; )
    {
        level waittill( "update_circle_hide" );
        emp_drone_clean_up( var0 );
    }
}

// Params 1
// Size: 0x4c
function emissive( var0 )
{
    var0 endon( "disconnect" );
    
    if ( !isdefined( var0.pers[ "squadMemberIndex" ] ) )
    {
        return;
    }
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        var0 waittill( "infil_jump_done" );
    }
    
    var0.ref_13ab3 = [];
    thread emp_drone_clean_up_func( var0 );
    
    for ( ;; )
    {
        emp_drone_clean_up( var0 );
        wait 1;
    }
}

// Params 0
// Size: 0x12
function initializetweakableoverrides()
{
    if ( !isdefined( level.tweakablesinitialized ) )
    {
        thread scripts\mp\tweakables::init();
        return;
    }
}

// Params 0
// Size: 0xcc
function initializematchrules()
{
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( "scr_br_brLoadouts", getmatchrulesdata( "brData", "brLoadouts" ) );
    setdynamicdvar( "scr_br_crateDropTimer", getmatchrulesdata( "brData", "crateDropTimer" ) );
    setdynamicdvar( "scr_br_infilC130", getmatchrulesdata( "brData", "infilC130" ) );
    setdynamicdvar( "scr_br_gulag", getmatchrulesdata( "brData", "gulag" ) );
    setdynamicdvar( "scr_br_circleDamageMultiplier", getmatchrulesdata( "brData", "circleDamageMultiplier" ) );
    setdynamicdvar( "scr_br_startingWeapon", getmatchrulesdata( "brData", "startingWeapon" ) );
    setdynamicdvar( "scr_br_roundlimit", 1 );
    scripts\mp\utility\game::registerroundlimitdvar( "br", 1 );
    setdynamicdvar( "scr_br_winlimit", 1 );
    scripts\mp\utility\game::registerwinlimitdvar( "br", 1 );
    setdynamicdvar( "scr_br_promode", 0 );
    scripts\mp\utility\game::registerlaststandinvulntimerdvar( 0 );
}

// Params 0
// Size: 0xda
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
    level.numendgame = scripts\mp\utility\dvars::dvarintvalue( "numEndGame", 4, 0, 20 );
    level.brloadouts = scripts\mp\utility\dvars::dvarintvalue( "brLoadouts", 0, 0, 5 );
    level.cratedroptimer = scripts\mp\utility\dvars::dvarintvalue( "crateDropTimer", 60, 0, 300 );
    level.goalenabletimer = scripts\mp\utility\dvars::dvarfloatvalue( "goalEnableTimer", 60, 0, 300 );
    level.goalmovetimer = scripts\mp\utility\dvars::dvarfloatvalue( "goalMoveTimer", 0, 0, 300 );
    level.radarendgame = scripts\mp\utility\dvars::dvarfloatvalue( "radarEndGame", 1, 0, 1 );
    level.infilcanusec130 = scripts\mp\utility\dvars::dvarfloatvalue( "infilC130", 1, 0, 1 );
    level.usegulag = scripts\mp\utility\dvars::dvarfloatvalue( "gulag", 1, 0, 1 );
    level.circledamagemultiplier = scripts\mp\utility\dvars::dvarfloatvalue( "circleDamageMultiplier", 1, 0.5, 4 );
    level.startingweapon = scripts\mp\utility\dvars::dvarintvalue( "startingWeapon", 0, 0, 8 );
    level.timetoadd = 30;
}

// Params 0
// Size: 0x71
function ref_12341()
{
    var0 = "";
    
    if ( !istrue( level.br_prematchstarted ) && istrue( level.br_prematchffa ) )
    {
        var0 = ref_1234a();
    }
    else
    {
        var1 = level.br_loadouts[ "default" ];
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "getDefaultLoadout" ) )
        {
            var1 = scripts\mp\gametypes\br_gametypes::ref_12e05( "getDefaultLoadout" );
        }
        
        self.pers[ "gamemodeLoadout" ] = var1;
        var0 = "gamemode";
    }
    
    self.pers[ "class" ] = var0;
    return var0;
}

// Params 0
// Size: 0x3c
function binoculars_clearpendingtimer()
{
    if ( self calloutmarkerping_getent() )
    {
        if ( self.pers[ "gamemodeLoadout" ][ "loadoutEquipmentPrimary" ] == "equip_molotov" )
        {
            self.pers[ "gamemodeLoadout" ][ "loadoutEquipmentPrimary" ] = "equip_frag";
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0xe9
function ref_14290()
{
    wait 5;
    iprintln( "Loadout verification starting in 10 seconds." );
    wait 5;
    iprintln( "5 seconds to start." );
    wait 5;
    iprintln( "Verification start!" );
    
    for ( var0 = 0; var0 < level.ref_1195f ; var0++ )
    {
        iprintln( "Loadout: " + var0 );
        self.pers[ "gamemodeLoadout" ] = level.ref_1285d[ level.ref_12861[ var0 ] ];
        self.class = "gamemode";
        scripts\mp\class::preloadandqueueclass( self.pers[ "class" ] );
        scripts\mp\class::swaploadout();
        scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
        wait 5;
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon( self.secondaryweapon );
        wait 4;
    }
    
    self.pers[ "gamemodeLoadout" ] = level.ref_1285d[ level.ref_12861[ 0 ] ];
    self.class = "gamemode";
    scripts\mp\class::preloadandqueueclass( self.pers[ "class" ] );
    scripts\mp\class::swaploadout();
    scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
    iprintln( "Verification done!" );
}

// Params 0
// Size: 0xf8
function ref_1234a()
{
    var0 = "";
    
    if ( getdvarint( "scr_br_use_set_loadouts", 1 ) )
    {
        if ( !isdefined( level.ref_12861 ) )
        {
            level.ref_12861 = [];
            
            for ( var1 = 0; var1 < level.ref_1195f ; var1++ )
            {
                level.ref_12861[ level.ref_12861.size ] = var1;
            }
            
            if ( getdvar( "scr_br_prematch_loadout_override" ) == "" && getdvarint( "scr_br_verify_prematch_loadouts", 0 ) == 0 )
            {
                level.ref_12861 = scripts\engine\utility::array_randomize( level.ref_12861 );
            }
            
            self.ref_1285c = level.ref_1195f - 2;
        }
        
        if ( !isdefined( self.ref_1285c ) || self.ref_1285c < 0 || self.ref_1285c >= level.ref_1195f - 1 )
        {
            self.ref_1285c = 0;
        }
        else
        {
            self.ref_1285c++;
        }
        
        self.pers[ "gamemodeLoadout" ] = level.ref_1285d[ level.ref_12861[ self.ref_1285c ] ];
        var0 = "gamemode";
        binoculars_clearpendingtimer();
    }
    else
    {
        var0 = "default" + randomint( 10 ) + 1;
    }
    
    return var0;
}

// Params 0
// Size: 0x83
function ref_12858()
{
    level endon( "game_ended" );
    
    while ( !isdefined( level.weaponlootmapdata ) )
    {
        waitframe();
    }
    
    level.ref_1285d = [];
    var0 = [];
    GscBinSkip0( 0x2e, "classIdxPrimaryArray", [] );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x12d
function firstinfectedsplash( var0 )
{
    var1 = 0;
    var2 = 2;
    var3 = 2;
    var4 = 1;
    var5 = 1;
    var6 = 2;
    var7 = 2;
    var8 = [ var2, var3, var4, var5, var6, var7 ];
    
    while ( var1 < var8.size )
    {
        var9 = 0;
        var10 = 0;
        var11 = 5;
        
        while ( var9 < var8[ var1 ] )
        {
            var12 = search_turret_fire_think( var1 );
            
            if ( !scripts\engine\utility::array_contains( var0[ "classIdxPrimaryArray" ], var12 ) || var10 >= var11 )
            {
                var9++;
                var10 = 0;
                var0[ var0[ "classIdxPrimaryArray" ].size ] = var12;
                continue;
            }
            
            var10++;
        }
        
        var1++;
    }
    
    var13 = 0;
    
    for ( var14 = 0; var14 < var0[ "classIdxPrimaryArray" ].size ; var14++ )
    {
        if ( var13 < 3 )
        {
            if ( randomint( 4 ) == 1 )
            {
                var15 = search_turret_fire_think( 6 );
            }
            else
            {
                var15 = search_turret_fire_think( 5 );
            }
            
            var13++;
        }
        else
        {
            var15 = search_turret_fire_think( 7 );
        }
        
        var0[ var0[ "classIdxSecondaryArray" ].size ] = var15;
    }
    
    var0 = scripts\engine\utility::array_randomize( var0[ "classIdxPrimaryArray" ] );
    var0 = scripts\engine\utility::array_randomize( var0[ "classIdxSecondaryArray" ] );
    return var0;
}

// Params 0
// Size: 0x50
function ref_1285a()
{
    level endon( "game_ended" );
    
    while ( !isdefined( level.weaponlootmapdata ) )
    {
        waitframe();
    }
    
    level.ref_1285d = [];
    var0 = "mp/classtable_br_eventbp.csv";
    var1 = 0;
    var2 = tablelookupgetnumcols( var0 ) - 1;
    
    while ( var1 < var2 )
    {
        level.ref_1285d[ level.ref_1285d.size ] = ref_1402f( var0, var1 );
        var1++;
    }
}

// Params 1
// Size: 0xc2
function search_turret_fire_think( var0 )
{
    var1 = 0;
    
    switch ( var0 )
    {
        case 0:
            var1 = 0 + randomint( 10 );
            break;
        case 1:
            var1 = 10 + randomint( 7 );
            break;
        case 2:
            var1 = 23 + randomint( 5 );
            break;
        case 3:
            var1 = 28 + randomint( 8 );
            break;
        case 4:
            var1 = 36 + randomint( 6 );
            break;
        case 5:
            var1 = randomint( 42 );
            break;
        case 6:
            var1 = 42 + randomint( 3 );
            break;
        case 7:
            var1 = 17 + randomint( 6 );
            break;
        default:
            break;
    }
    
    return var1;
}

// Params 3
// Size: 0x352
function ref_1400b( var0, var1, var2 )
{
    if ( var1 == var2 )
    {
        if ( var2 > 0 )
        {
            var2--;
        }
        else
        {
            var2 = 1;
        }
    }
    
    var3 = [];
    GscBinSkip0( 0x2e, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 2
// Size: 0x30f
function ref_1402f( var0, var1 )
{
    var2 = [];
    GscBinSkip0( 0x2e, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0xa6
function riskspawn_getspawnlocationsbytier( var0 )
{
    var1 = [];
    
    if ( var0 == "lethal" )
    {
        var1 = [ "equip_at_mine", "equip_claymore", "equip_c4", "equip_frag", "equip_molotov", "equip_semtex", "equip_thermite", "equip_throwing_knife", "equip_throwing_knife_fire", "equip_throwing_knife_electric", "equip_throwing_knife_drill" ];
    }
    else if ( var0 == "tactical" )
    {
        var1 = [ "equip_adrenaline", "equip_concussion", "equip_decoy", "equip_flash", "equip_gas_grenade", "equip_hb_sensor", "equip_smoke", "equip_snapshot_grenade" ];
    }
    
    var2 = var1[ randomint( var1.size ) ];
    return var2;
}

// Params 1
// Size: 0x11d
function ref_12859( var0 )
{
    var1 = tablelookupgetnumcols( var0 ) - 1;
    level.ref_1285d = [];
    var2 = 0;
    
    if ( getdvar( "scr_br_prematch_loadout_override" ) != "" )
    {
        var3 = strtok( getdvar( "scr_br_prematch_loadout_override" ), " " );
        var4 = [];
        
        for ( var5 = 0; var5 < var3.size ; var5++ )
        {
            var4 = int( var3[ var4.size ] );
        }
        
        for ( var6 = 0; var6 < var4.size ; var6++ )
        {
            level.ref_1285d[ level.ref_1285d.size ] = init_swivelroom_currsolution_marquee( var4[ var6 ], var0 );
        }
        
        level.ref_1195f = var4.size;
        return;
    }
    else if ( getdvarint( "scr_br_use_set_loadouts", 1 ) )
    {
        if ( getdvarint( "scr_br_verify_prematch_loadouts", 0 ) == 1 && getdvarint( "scr_br_prematch_loadout_set", -1 ) == -1 )
        {
            var6 = 0;
            level.ref_1195f = var5;
        }
        else
        {
            var6 = int( randomint( var5 - 1 ) * 0.1 ) * 10;
            
            if ( getdvarint( "scr_br_prematch_loadout_set", -1 ) != -1 )
            {
                var6 = getdvarint( "scr_br_prematch_loadout_set", -1 );
            }
            
            var5 = var6 + 10;
        }
    }
    
    for ( var7 = var6; var7 < var5 ; var7++ )
    {
        level.ref_1285d[ level.ref_1285d.size ] = init_swivelroom_currsolution_marquee( var7, var4 );
    }
}

// Params 2
// Size: 0x24c
function init_swivelroom_currsolution_marquee( var0, var1 )
{
    GscBinSkip1( 0x45, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 0
// Size: 0x236
function defineplayerloadout()
{
    level.br_loadouts[ "default" ][ "loadoutArchetype" ] = "archetype_assault";
    level.br_loadouts[ "default" ][ "loadoutPrimary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryAttachment" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryCamo" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryReticle" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryAttachment" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryCamo" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryReticle" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutMeleeSlot" ] = "iw8_fists_mp";
    level.br_loadouts[ "default" ][ "loadoutEquipmentPrimary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutEquipmentSecondary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutStreakType" ] = "assault";
    level.br_loadouts[ "default" ][ "loadoutKillstreak1" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutKillstreak2" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutKillstreak3" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSuper" ] = "super_br_extract";
    level.br_loadouts[ "default" ][ "loadoutPerks" ] = [ "specialty_null" ];
    level.br_loadouts[ "default" ][ "loadoutGesture" ] = "playerData";
    level.br_loadouts[ "allies" ] = level.br_loadouts[ "default" ];
    level.br_loadouts[ "axis" ] = level.br_loadouts[ "default" ];
    level.br_respawn_loadout = level.br_loadouts[ "default" ];
    level.br_respawn_loadout[ "loadoutSecondary" ] = "iw8_pi_t9semiauto";
}

// Params 0
// Size: 0x7a
function onprecachegametype()
{
    level._effect[ "vfx_gas_ring_player" ] = loadfx( "vfx/iw8_cp/br_ring/vfx_gas_ring_player.vfx" );
    level._effect[ "vfx_gas_ring_puffy" ] = loadfx( "vfx/iw8_cp/br_ring/vfx_gas_ring_puffy.vfx" );
    level._effect[ "vfx_br_infil_jump_smoke_01" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx" );
    level._effect[ "vfx_br_infil_jump_wisp_01" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx" );
    level._effect[ "vfx_br_infil_jump_wisp_02" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx" );
    level._effect[ "vfx_gas_mask_break" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_gasmask_dest.vfx" );
}

// Params 0
// Size: 0x369
function onstartgametype()
{
    level.blockweapondrops = 1;
    level.customlaststandactionset = "brlaststand";
    scripts\mp\playeractions::registeractionset( level.customlaststandactionset, [ "usability", "weapon_switch", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "crouch", "prone", "melee", "fire" ] );
    level.graceperiod = 3;
    level.ingraceperiod = level.graceperiod;
    level.prematchperiodend = 0;
    
    if ( !level.allowsupers )
    {
        level.setsuperweapondisabled = &ref_131c8;
    }
    
    setclientnamemode( "auto_change" );
    
    foreach ( var1 in level.teamnamelist )
    {
        scripts\mp\utility\game::setobjectivetext( var1, &"OBJECTIVES/DM" );
        
        if ( level.splitscreen )
        {
            scripts\mp\utility\game::setobjectivescoretext( var1, &"OBJECTIVES/DM" );
        }
        else
        {
            scripts\mp\utility\game::setobjectivescoretext( var1, &"OBJECTIVES/DM_SCORE" );
        }
        
        scripts\mp\utility\game::setobjectivehinttext( var1, &"OBJECTIVES/DM_HINT" );
    }
    
    initspawns();
    
    if ( !ref_11a5c() )
    {
        scripts\mp\gametypes\br_circle::initcircle();
    }
    
    scripts\mp\gametypes\br_weapons::br_ammo_init();
    scripts\mp\gametypes\br_c130::init();
    scripts\mp\gametypes\br_pickups::delete_objective_on_death_safe();
    scripts\mp\gametypes\br_pickups::initpickupusability();
    scripts\mp\gametypes\br_callouts::init();
    scripts\mp\gametypes\br_functional_poi::init();
    
    if ( !ref_11a5c() )
    {
        scripts\mp\gametypes\br_quest_util::init_quest_util();
    }
    
    scripts\cp_mp\vehicles\vehicle_compass::calloutmarkerping_init();
    scripts\mp\gametypes\br_lootcache::brlootcache_init();
    scripts\mp\gametypes\br_loot_cache_trapped::init();
    scripts\mp\gametypes\br_publicevents::init();
    scripts\mp\gametypes\br_challenges::init();
    scripts\mp\gametypes\br_alt_mode_escape::init();
    scripts\mp\gametypes\br_alt_mode_gxp::init();
    scripts\mp\gametypes\br_alt_mode_zai::init();
    scripts\mp\gametypes\br_alt_mode_zxp::init();
    scripts\mp\gametypes\br_containmentprotocol::init();
    scripts\mp\gametypes\br_satellite_hunt::init();
    scripts\mp\gametypes\br_alt_mode_bblitz::init();
    scripts\mp\gametypes\br_alt_mode_brshot::init();
    level.br_pickups.crates = [];
    level.br_pickups.∫~0À√õ‡ıÒÇ£`∑« = [];
    level.br_pickups.outercrates = [];
    scripts\mp\gametypes\br_gulag::initgulag();
    scripts\cp_mp\utility\script_utility::registersharedfunc( "vehicle_compass", "shouldBeVisibleToPlayer", &ref_1411d );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "br", "superSlotCleanUp", &scripts\mp\gametypes\br_pickups::ref_1398a );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "br", "challengeEvaluator", &scripts\mp\gametypes\br_challenges::getallspawninstances );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "registerCrateForCleanup", &airdrop_registercrateforcleanup );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "brLoadoutCrateFirstActivation", &br_ammorestock_playeruse );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "makeWeaponFromCrate", &airdrop_makeweaponfromcrate );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "makeItemFromCrate", &airdrop_makeitemfromcrate );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "makeItemsFromCrate", &airdrop_makeitemsfromcrate );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "br_giveDropBagLoadout", &airdrop_br_givedropbagloadout );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "brOnLoadoutCrateDestroyed", &br_armor_repair_end );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "gasmask", "breakGasMaskBR", &scripts\mp\gametypes\br_pickups::disable_near_snake_cam_after_open );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "game", "skipPlayerVO", &ending_viewing_players_setup );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "game", "playSoundToSquad", &scripts\mp\gametypes\br_public::ref_1276a );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "game", "getSquadPlayers", &scripts\mp\gametypes\br_public::round_enemy_stuck_logic );
    _hidesafecircleui::stopusingbomb();
    initloot();
    thread onprematchstarted();
    thread turnofftimer();
    thread watchprematchdone();
    level thread scripts\mp\gametypes\br_vehicles::brvehiclesonstartgametype();
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "rat_race" )
    {
        thread scripts\mp\gametypes\br_gametype_rat_race::ref_14363();
    }
    else
    {
        thread scripts\mp\gametypes\br_gametype_dmz::ref_14363();
    }
    
    thread updateplayerlocationcallouts();
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &brdpadcallback );
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &setup_teleport_rooms );
    
    if ( getdvarint( "scr_disableLoadout", 0 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "drogBagLoadout" );
    }
    
    if ( disable_fulton_group_interactions() )
    {
        thread scripts\mp\gametypes\br_rewards::initdropbagsystem();
        thread cleanupdropbagsoncircle();
    }
    
    level.killstreakbeginusefunc = &display_hint_single;
    scripts\mp\gametypes\br_gametypes::ref_12e05( "onStartGameType" );
}

// Params 2
// Size: 0x8, Type: bool
function ref_1411d( var0, var1 )
{
    return true;
}

// Params 0
// Size: 0x59
function has_focus_fire_objective()
{
    var0 = getentarray( "grenade", "classname" );
    
    foreach ( var2 in var0 )
    {
        if ( isdefined( var2 ) && isdefined( var2.weapon_name ) && var2.weapon_name == "molotov_mp" )
        {
            thread scripts\mp\equipment\molotov::ref_11cb5( var2 );
        }
    }
}

// Params 0
// Size: 0x1a2
function ref_12076()
{
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    
    if ( getdvarint( "scr_br_bigFallModeEnabled", 0 ) )
    {
        level.client_activate = 1;
    }
    
    if ( scripts\cp_mp\utility\game_utility::tutorialzoneenter() )
    {
        scripts\mp\gametypes\br_ww2::ref_145ee();
    }
    
    if ( !istrue( level.ref_133e0 ) )
    {
        thread resetalldoors( level );
        level thread scripts\cp\vehicles\little_bird_mg_cp::fulton_destroy( 1 );
        level thread scripts\mp\gametypes\br_vehicles::brvehicleonprematchstarted();
        level thread scripts\mp\equipment\binoculars::teamuseonly();
    }
    
    level thread scripts\mp\gametypes\br_functional_poi::onprematchdone();
    
    if ( !istrue( level.ref_133e0 ) )
    {
        has_focus_fire_objective();
        scripts\mp\gametypes\br_vehicles::emptyallvehicles();
        
        if ( !istrue( level.br_infils_disabled ) )
        {
            foreach ( var1 in level.players )
            {
                var1 scripts\mp\gametypes\br_infils::setplayerprematchallows();
                var1 thread scripts\mp\gametypes\br_pickups::resetplayerinventory();
                
                if ( istrue( var1.hasspawned ) )
                {
                    if ( istrue( var1.usingascender ) )
                    {
                        var1 scripts\cp_mp\auto_ascender::canseesafecircleui();
                    }
                    
                    var1 thread scripts\mp\weapons::deleteplacedequipment( 1 );
                }
            }
        }
        
        foreach ( var1 in level.players )
        {
            if ( isdefined( var1.burninginfo ) )
            {
                var1 scripts\mp\equipment\molotov::molotov_clear_burning();
            }
            
            var1 scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
        }
        
        level notify( "prematch_cleanup" );
    }
    
    level.little_bird_mp_initmines = 0;
    
    foreach ( var6 in level.br_prematchloot )
    {
        var6 setscriptablepartstate( level.br_prematchlootparts[ var7 ], "visible" );
    }
    
    level.br_prematchloot = undefined;
    level.br_prematchlootparts = undefined;
    
    if ( !scripts\mp\gametypes\br_public::isusinginfilselection() && disable_flag() )
    {
        scripts\mp\gametypes\br_infils::classselectionbeginnonexclusion();
    }
    
    var8 = getdvarint( "wsow_event_dvar_hot_reload", 0 );
    
    if ( istrue( var8 ) )
    {
        ref_12bb7();
    }
    
    if ( !istrue( level.br_circle_disabled ) )
    {
        level thread scripts\mp\gametypes\br_circle::ref_12e09( 1 );
        return;
    }
}

// Params 0
// Size: 0x5c
function ref_12bb7()
{
    if ( !istrue( getdvarint( "scr_br_gulag", 1 ) ) )
    {
        if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "gulag" ) )
        {
            level scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
        }
        
        level.usegulag = 0;
        setomnvar( "ui_gulag_state", 0 );
        setomnvar( "ui_gulag_show_closing_state", 2 );
    }
    
    if ( !istrue( level.br_circle_disabled ) )
    {
        level scripts\mp\gametypes\br_circle::cacheentity();
        level thread scripts\mp\gametypes\br_circle::allplayers_setphysicaldof();
        return;
    }
}

// Params 0
// Size: 0x37b
function onprematchstarted()
{
    thread ref_12076();
    var0 = undefined;
    
    if ( !istrue( level.br_infils_disabled ) && !scripts\mp\gametypes\br_public::isusinginfilselection() )
    {
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "createC130PathStruct" ) )
        {
            var0 = scripts\mp\gametypes\br_gametypes::ref_12e05( "createC130PathStruct" );
        }
        else
        {
            var0 = scripts\mp\gametypes\br_c130::createtestc130path();
        }
    }
    
    if ( !istrue( level.ref_133e0 ) && !scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        foreach ( var2 in level.teamnamelist )
        {
            setteamradar( var2, 1 );
            setteamradarstrength( var2, 1 );
        }
    }
    
    if ( scripts\mp\utility\game::round_vehicle_logic() != "zxp" )
    {
        thread scripts\mp\music_and_dialog::stopsuspensemusic();
    }
    
    level waittill( "prematch_started" );
    
    if ( ref_11a5c() )
    {
        scripts\mp\gametypes\br_circle::initcircle();
        scripts\mp\gametypes\br_quest_util::init_quest_util();
    }
    
    if ( !istrue( level.ref_133e0 ) )
    {
        var4 = getdvarint( "scr_br_radar_strength", 0 );
        
        foreach ( var2 in level.teamnamelist )
        {
            if ( var4 )
            {
                setteamradar( var2, 1 );
                setteamradarstrength( var2, var4 );
                continue;
            }
            
            setteamradar( var2, 0 );
            setteamradarstrength( var2, 0 );
        }
    }
    
    if ( istrue( level.debug_safehouse_regroup_start ) && istrue( level.debug_show2dvotext ) )
    {
        setomnvarforallclients( "ui_options_menu", 0 );
    }
    
    var7 = 0;
    level.debugnextpropindex = 0;
    level.delay_music_reinforcements = 0;
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        if ( !istrue( level.infilcanusec130 ) && !istrue( level.infilcanusemap ) )
        {
            level.infilcanusec130 = 1;
        }
        
        if ( istrue( level.infilcanusemap ) )
        {
            if ( disable_fulton_group_interactions() && !dialog_mount_nag_watcher() )
            {
                scripts\mp\gametypes\br_rewards::ref_1284d( 1 );
            }
            
            scripts\mp\gametypes\br_infils::spawnselectioninfil( "player" );
            waitframe();
            
            foreach ( var9 in level.players )
            {
                var9 stopanimscriptsceneevent();
                var9 notify( "infil_jump_done" );
                
                if ( !var9.brmapselectionafk )
                {
                    var9 thread scripts\mp\gametypes\br_infils::ref_13aec();
                    continue;
                }
                
                thread sendafksquadmembertogulag();
            }
        }
        
        setdvarifuninitialized( "scr_br_use_script_model_infil", 0 );
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "infilSequence" ) )
        {
            scripts\mp\gametypes\br_gametypes::ref_12e05( "infilSequence" );
        }
        else if ( istrue( level.infilcanusec130 ) && !istrue( level.infilcanusemap ) )
        {
            var11 = undefined;
            
            if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "getInfilPlayers" ) )
            {
                var11 = scripts\mp\gametypes\br_gametypes::ref_12e05( "getInfilPlayers" );
            }
            
            if ( !getdvarint( "scr_br_use_script_model_infil", 0 ) )
            {
                scripts\mp\gametypes\br_infils::clear_tier_lights( var0, "player", var11 );
            }
            else
            {
                scripts\mp\gametypes\br_infils::clear_tier_lights( var0, "script_model" );
                
                if ( isdefined( level.infilstruct ) && isdefined( level.infilstruct.transporttime ) )
                {
                    var7 = level.infilstruct.transporttime;
                }
            }
            
            level thread scripts\mp\gametypes\br_c130::waittoplayinfildialog();
        }
    }
    else
    {
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "skipInfilSequence" ) )
        {
            scripts\mp\gametypes\br_gametypes::ref_12e05( "skipInfilSequence" );
        }
        
        scripts\mp\flags::gameflagset( "prematch_fade_done" );
        waitframe();
        level.allowprematchdamage = 0;
        var11 = undefined;
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "getInfilPlayers" ) )
        {
            var11 = scripts\mp\gametypes\br_gametypes::ref_12e05( "getInfilPlayers" );
        }
        
        if ( !isdefined( var11 ) || var11.size > 0 )
        {
            scripts\mp\gametypes\br_infils::ref_1435f( var11 );
        }
        
        foreach ( var9 in level.players )
        {
            var9.plotarmor = undefined;
            
            if ( istrue( level.client_activate ) )
            {
                var9 skydive_setdeploymentstatus( 1 );
                var9 skydive_setbasejumpingstatus( 1 );
                continue;
            }
            
            var9 skydive_setdeploymentstatus( 0 );
            var9 skydive_setbasejumpingstatus( 0 );
        }
        
        scripts\mp\flags::gameflagset( "br_ready_to_jump" );
    }
    
    thread setup_player_killstreak_loadouts();
    thread setup_weapons_at_pos();
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "teamSpectate" ) )
    {
        level thread scripts\mp\gametypes\br_spectate::spectate_init();
    }
    
    level.br_prematchstarted = 1;
    level notify( "infils_ready" );
}

// Params 0
// Size: 0x58
function setup_weapons_at_pos()
{
    if ( scripts\mp\utility\game::updatex1stashhud() )
    {
        return;
    }
    
    scripts\mp\scoreboard::ref_128b0();
    
    if ( getdvarint( "MTKSQRQLKN" ) != 0 )
    {
        if ( scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch() )
        {
            setclientmatchdata( "isPublicMatch", 1 );
        }
        else
        {
            setclientmatchdata( "isPublicMatch", 0 );
        }
    }
    
    level scripts\engine\utility::waittill_notify_or_timeout( "br_c130_left_bounds", 120 );
    scripts\mp\scoreboard::ref_128b0();
}

// Params 0
// Size: 0x54
function setup_player_killstreak_loadouts()
{
    level endon( "game_ended" );
    
    if ( disable_fulton_group_interactions() && dialog_mount_nag_watcher() )
    {
        if ( !scripts\mp\gametypes\br_public::validtousesticker() && !scripts\mp\gametypes\br_public::tutorial_playsound() )
        {
            var0 = disable_weapon_swap_until_swap_finished();
            scripts\mp\gametypes\br_rewards::kioskreviveplayer( var0 );
            
            if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "dropBagLoop" ) )
            {
                for ( ;; )
                {
                    scripts\mp\gametypes\br_rewards::kioskreviveplayer( var0 );
                }
            }
        }
    }
    
    level.dropbagstruct = undefined;
}

// Params 1
// Size: 0x1a
function resetalldoors( var0 )
{
    level endon( "game_ended" );
    
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    difficulty_update_time( 200 );
}

// Params 2
// Size: 0x20
function setup_teleport_rooms( var0, var1 )
{
    if ( isdefined( var0 ) && var0 == "exit_squad_eliminated" )
    {
        self setclientomnvar( "ui_br_squad_eliminated_active", 0 );
        return;
    }
}

// Params 0
// Size: 0x142
function updateplayerlocationcallouts()
{
    level endon( "game_ended" );
    
    if ( !isdefined( level.calloutglobals.calloutzones ) )
    {
        level.calloutglobals.calloutzones = getentarray( "location_volume", "targetname" );
    }
    
    jumpiftrue(level.calloutglobals.calloutzones.size) LOC_00000040;
    return;
}

// Params 0
// Size: 0x4, Type: bool
function getusingproxdoors()
{
    return false;
}

// Params 0
// Size: 0x159
function watchprematchdone()
{
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    level notify( "br_prematchEnded" );
    var0 = scripts\mp\utility\game::getlivingplayers();
    level.totalplayers = var0.size;
    var1 = 0;
    
    foreach ( var3 in level.teamnamelist )
    {
        if ( scripts\mp\utility\teams::getteamdata( var3, "aliveCount" ) > 0 )
        {
            var1++;
        }
    }
    
    level.ref_1385e = max( 1, var1 );
    level.ref_12855 = gettime();
    level.recordfinalkillcam = 1;
    level.ignorescoring = 0;
    level.disableweaponstats = 0;
    level.disablestattracking = 0;
    level.prematchaddkillfunc = undefined;
    level.getarenapickupattachmentoverrides = 0;
    difficulty_think();
    
    foreach ( var6 in level.players )
    {
        ref_12c6f( var6 );
    }
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "allowLateJoiners" ) )
    {
        level.allowlatecomers = 0;
        setnojiptime( 1, 1 );
        setnojipscore( 1, 1 );
    }
    
    vehicle_getarrayinradius();
    setomnvar( "scriptable_loot_hide", 0 );
    
    foreach ( var6 in level.players )
    {
        var6 setclientdvar( "MQNNLTKNTS", 1 );
        
        if ( isalive( var6 ) )
        {
            var6.health = var6.maxhealth;
            var6 scripts\cp\vehicles\vehicle_compass_cp::ref_1383b( "alive_not_downed" );
        }
    }
    
    scripts\mp\gametypes\br_analytics::detonatedripfx( var0.size );
    ref_1319b( level );
}

// Params 0
// Size: 0x10
function turnofftimer()
{
    wait 1;
    setomnvar( "ui_match_timer_hidden", 1 );
}

// Params 0
// Size: 0x53
function initspawns()
{
    scripts\mp\spawnlogic::setactivespawnlogic( "FreeForAll", "Crit_Default" );
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

// Params 0
// Size: 0x3c
function tolerance()
{
    if ( !scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_dm_spawn_start" );
        
        if ( level.startingspawns.size == 0 )
        {
            level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
        }
        
        level.prematchspawnorigins = getprematchlocationspawnorigins();
        return;
    }
}

// Params 0
// Size: 0x4f
function debugspawnlocations()
{
    for ( ;; )
    {
        foreach ( var1 in level.prematchspawnorigins )
        {
            var2 = getprematchradius( var1 );
            var3 = var2[ 0 ];
            var4 = var2[ 1 ];
            var2 = undefined;
            
            if ( var3 > 0 )
            {
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x39, Type: bool
function ref_14070()
{
    var0 = getdvarint( "scr_useProfileSpawn", 0 ) != 0;
    return ( !istrue( level.br_prematchstarted ) || istrue( level.debug_safehouse_gunshop_start ) ) && !istrue( level.skipprematchdropspawn ) && !var0 && !istrue( level.stop_end_breach_fx );
}

// Params 1
// Size: 0x18b
function getspawnpoint( var0 )
{
    if ( isdefined( self.ref_1286f ) )
    {
        var1 = self.ref_1286f;
        self.ref_1286f = undefined;
        return var1;
    }
    
    if ( isdefined( self.thrust_fx_model ) )
    {
        var1 = self.thrust_fx_model;
        return var1;
    }
    
    if ( !isdefined( level.prematchspawnorigins ) )
    {
        tolerance();
    }
    
    if ( istrue( var1 ) || ref_14070() )
    {
        var2 = ( 0, randomintrange( 0, 360 ), 0 );
        var4 = getprematchspawnorigin();
        var5 = getprematchradius( var4 );
        var6 = var5[ 0 ];
        var7 = var5[ 1 ];
        var5 = undefined;
        var8 = randomfloatrange( var6, var7 );
        
        if ( getdvarint( "scr_br_streamFurthestInitial", 0 ) == 1 )
        {
            var10 = vectortoangles( var4.origin );
            var2 = ( 0, var10[ 1 ], 0 ) * -1;
            var8 = var7;
        }
        
        if ( isdefined( var4.angles ) )
        {
            var2 = var4.angles;
        }
        
        var11 = anglestoforward( var2 ) * -1;
        var12 = var11 * var8;
        var13 = var4.origin + var12;
        var13 = scripts\mp\gametypes\br_c130::ref_1342e( var4.origin, var13, 30 );
        
        if ( isdefined( self.setspawnpoint ) )
        {
            var14 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
            var13 = self.setspawnpoint.playerspawnpos + ( 0, 0, var14 );
            var2 = self.setspawnpoint.playerspawnangles;
            scripts\mp\equipment\tac_insert::ref_13681( 0, 1 );
        }
        
        var1 = spawnstruct();
        var1.origin = var13;
        var1.angles = var2;
        var1.index = -1;
        return var1;
    }
    
    var15 = level.startingspawns;
    var1 = scripts\mp\spawnlogic::getspawnpoint_random( var15 );
    
    if ( !isdefined( var1 ) )
    {
        var1 = spawnstruct();
        var1.origin = ( 0, 0, 0 );
        var1.angles = ( 0, 0, 0 );
        var1.index = -1;
    }
    
    return var1;
}

// Params 3
// Size: 0x28
function createspawnlocation( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.origin = var0;
    var3.minradius = var1;
    var3.radius = var2;
    return var3;
}

// Params 0
// Size: 0x158
function getprematchlocationspawnorigins()
{
    var0 = 0;
    var1 = scripts\engine\utility::getstructarray( "br_prematch_insertion_point", "targetname" );
    
    if ( isdefined( level.delete_script_object ) )
    {
        var0 = 1;
        var1 = level.delete_script_object;
    }
    else if ( !var1.size )
    {
        var0 = 1;
        var1 = getentarray( "vehicle_volume", "script_noteworthy" );
    }
    
    foreach ( var3 in var1 )
    {
        var3.groundorigin = var3.origin;
        
        if ( !isdefined( var3.radius ) )
        {
            var3.radius = 5000;
        }
        
        if ( !isdefined( var3.minradius ) )
        {
            var3.minradius = 500;
        }
    }
    
    var5 = scripts\mp\gametypes\br_gametypes::ref_12e05( "prematchSpawnMaxLocations" );
    
    if ( !isdefined( var5 ) )
    {
        var5 = getdvarint( "scr_br_maxprematchlocations", 5 );
    }
    
    if ( var5 > 0 && var5 < var1.size )
    {
        var1 = scripts\engine\utility::array_slice( scripts\engine\utility::array_randomize( var1 ), 0, var5 );
    }
    
    foreach ( var3 in var1 )
    {
        if ( var0 )
        {
            var3.origin = getoffsetspawnorigin( var3.origin );
            continue;
        }
        
        var7 = getoffsetspawnorigin( var3.origin )[ 2 ];
        
        if ( var3.origin[ 2 ] < var7 )
        {
            var3.origin = ( var3.origin[ 0 ], var3.origin[ 1 ], var7 );
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x67
function getoffsetspawnorigin( var0, var1 )
{
    var2 = scripts\engine\trace::create_default_contents( 1 );
    var3 = ( 0, 0, 5000 );
    var4 = var0 + var3;
    var5 = var0 - var3;
    var6 = scripts\engine\trace::ray_trace( var4, var5, undefined, var2 );
    var7 = var0;
    
    if ( var6[ "hittype" ] != "hittype_none" )
    {
        var7 = var6[ "position" ];
    }
    
    if ( !isdefined( var1 ) )
    {
        var8 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
        var1 = ( 0, 0, var8 );
    }
    
    return var7 + var1;
}

// Params 2
// Size: 0x30
function resetcircuitbreakers( var0, var1 )
{
    var2 = 5000;
    var3 = -5000;
    var4 = scripts\mp\gametypes\br_public::modifyplayer_damage( var0, var2, var3 );
    
    if ( !isdefined( var1 ) )
    {
        var5 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
        var1 = ( 0, 0, var5 );
    }
    
    return var4 + var1;
}

// Params 0
// Size: 0x10
function relic_squadlink_toofar_hud_logic()
{
    var0 = int( 150 / scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect() );
    return var0;
}

// Params 0
// Size: 0x16f
function getprematchspawnorigin()
{
    var0 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "doFirstUnusedPrematchSpawnOrigin" );
    
    if ( istrue( var0 ) && isdefined( level.ref_12864 ) )
    {
        var1 = 0;
        
        for ( var2 = 0; var2 < level.prematchspawnorigins.size ; var2++ )
        {
            if ( level.ref_12864[ var2 ] < level.ref_12864[ var1 ] )
            {
                var1 = var2;
            }
        }
        
        level.ref_12864[ var1 ]++;
        var3 = level.prematchspawnorigins[ var1 ];
        return var3;
    }
    
    if ( !isdefined( level.prematchspawnoriginnextidx ) )
    {
        if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "randomizePrematchSpawnOriginNextIdx" ) )
        {
            level.prematchspawnoriginnextidx = 0;
        }
        else
        {
            level.prematchspawnoriginnextidx = randomint( level.prematchspawnorigins.size );
        }
        
        level.ref_12865 = [];
        
        for ( var2 = 0; var2 < level.prematchspawnorigins.size ; var2++ )
        {
            level.ref_12865[ var2 ] = 0;
        }
    }
    
    var3 = scripts\mp\gametypes\br_public::round_at_max( self.sessionteam, self.squadindex, "prematchSpawnOrigin" );
    
    if ( !isdefined( var3 ) )
    {
        var3 = level.prematchspawnorigins[ level.prematchspawnoriginnextidx ];
        scripts\mp\gametypes\br_public::ref_131c3( self.sessionteam, self.squadindex, "prematchSpawnOrigin", var3 );
        level.ref_12865[ level.prematchspawnoriginnextidx ]++;
        var4 = scripts\mp\gametypes\br_gametypes::ref_12e05( "prematchSpawnNumTeamsPerLocation" );
        
        if ( !isdefined( var4 ) )
        {
            var5 = relic_squadlink_toofar_hud_logic();
            var4 = int( var5 / level.prematchspawnorigins.size );
        }
        
        if ( level.ref_12865[ level.prematchspawnoriginnextidx ] >= var4 )
        {
            level.prematchspawnoriginnextidx = ( level.prematchspawnoriginnextidx + 1 ) % level.prematchspawnorigins.size;
        }
    }
    
    var6 = getdvarint( "scr_br_overrideprematchspawn", -1 );
    
    if ( var6 >= 0 && var6 < level.prematchspawnorigins.size )
    {
        var3 = level.prematchspawnorigins[ var6 ];
    }
    
    return var3;
}

// Params 1
// Size: 0x159
function onplayerconnect( var0 )
{
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var0.ui_dom_securing = undefined;
    var0.ui_dom_stalemate = undefined;
    var0.needtoplayintro = undefined;
    var0.br_infil_type = undefined;
    var0.equipment = [];
    var0.delay_give_tactical_grenade = 1;
    var0 thread scripts\mp\gametypes\br_weapons::br_ammo_player_init();
    var0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerWelcomeSplashes" ) )
    {
        var0 thread scripts\mp\gametypes\br_gametypes::ref_12e05( "playerWelcomeSplashes" );
    }
    else
    {
        thread ref_126f1();
    }
    
    ref_12c6f( var0 );
    scripts\mp\gametypes\br_gametypes::ref_12e05( "onPlayerConnect", var0 );
    
    if ( scripts\mp\gametypes\br_gametype_olaride::arefactionpointsenabled() )
    {
        var0 thread scripts\mp\gametypes\br_gametype_olaride::loadplayerhvveventpoints();
    }
    
    if ( !istrue( level.prematchstarted ) )
    {
        var0.radarmode = "slow_radar";
        level waittill( "prematch_started" );
        wait 1.4;
    }
    
    if ( !isdefined( var0.streakdata ) )
    {
        waittillframeend();
    }
    
    if ( isdefined( var0 ) )
    {
        if ( !scripts\mp\gametypes\br_public::uniquelootitemid() && !scripts\mp\gametypes\br_public::validtousesticker() && !scripts\mp\gametypes\br_public::tutorial_playsound() && !scripts\mp\utility\game::updatex1stashhud() )
        {
            if ( !istrue( level.ref_133e0 ) )
            {
                var0 scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
                var0 scripts\mp\gametypes\br_pickups::resetplayerinventory();
            }
            
            var0 scripts\cp_mp\utility\game_utility::startkeyearning();
        }
        
        thread ref_11d22();
        var1 = getdvar( "scr_br_radar_mode", "" );
        
        if ( var1 != "" )
        {
            var0.radarmode = var1;
        }
        else
        {
            var0.radarmode = "normal_radar";
        }
        
        scripts\mp\gametypes\br_quest_util::onplayerconnect( var0 );
        threat_sight_monitor( var0 );
        var0 scripts\mp\gametypes\br_gulag::updatecanusegulag();
        return;
    }
}

// Params 0
// Size: 0x9b
function ref_126f1()
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    wait 1;
    
    if ( !istrue( game[ "liveLobbyCompleted" ] ) )
    {
        scripts\mp\hud_message::showsplash( "br_prematch_welcome" );
        
        if ( istrue( level.vehicle_collision_getleveldata ) )
        {
            self setplayermusicstate( "event01_lobby" );
        }
    }
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        self waittill( "br_jump" );
        
        if ( isdefined( game[ "dialog" ][ "match_desc" ] ) )
        {
            scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "match_desc", self, 0 );
        }
        
        while ( !self isonground() )
        {
            waitframe();
        }
    }
    else
    {
        level waittill( "prematch_done" );
    }
    
    scripts\mp\gametypes\br_analytics::detachriotshield( self );
    wait 1;
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "primary_objective", self, 0 );
}

// Params 0
// Size: 0x123
function onspawnplayer()
{
    self notify( "br_spawned" );
    var0 = istrue( self.gulag );
    scripts\mp\gametypes\br_pickups::initplayer( var0 );
    scripts\mp\gametypes\br_functional_poi::initplayer();
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "armor" ) )
    {
        scripts\mp\gametypes\br_armor::teamfriendlyto();
    }
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "teamSpectate" ) )
    {
        scripts\mp\gametypes\br_spectate::initplayer();
    }
    
    self.oldprimarygun = undefined;
    self.newprimarygun = undefined;
    self.healthregendisabled = 0;
    self.br_lastscenecheck = gettime();
    self.needtoplayintro = undefined;
    self.gunnlessweapon = undefined;
    self.disable_hotjoining_after_time = undefined;
    self.ref_12885 = undefined;
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "waitLoadoutDone" ) )
    {
        thread waitloadoutdone();
    }
    
    level.superdelay = 0;
    level.superpointsmod = 1;
    self.br_perks = [ 0, 0, 0, 0, 0 ];
    self.br_perkpoints = 0;
    
    if ( level.ref_121c8 )
    {
        self getclientomnvar();
    }
    else
    {
        self weaponswitchbuttonpressed();
    }
    
    if ( level.ref_121c9 )
    {
        self skydive_cutautodeployon();
    }
    else
    {
        self skydive_cutautodeployoff();
    }
    
    if ( getdvarint( "scr_br_hudoutlineForTeammates", 0 ) > 0 )
    {
        thread emissive( level );
    }
    
    if ( getdvarint( "scr_game_hcmode" ) == 1 )
    {
        self.healthregendisabled = 1;
    }
    
    scripts\mp\gametypes\br_public::ref_1319e( 0 );
    scripts\mp\gametypes\br_public::ref_1319c( 0 );
    ref_1401f( self, self, 0, 1 );
    thread ref_14006();
}

// Params 2
// Size: 0x34
function waittill_return( var0, var1 )
{
    if ( var0 != "death" )
    {
        self endon( "death" );
    }
    
    var1 endon( "die" );
    self waittill( var0, var2, var3 );
    var1 notify( "returned", var2, var3, var0 );
}

// Params 3
// Size: 0x97
function waittill_confirm_or_cancel( var0, var1, var2 )
{
    if ( ( !isdefined( var0 ) || var0 != "death" ) && ( !isdefined( var1 ) || var1 != "death" ) )
    {
        self endon( "death" );
    }
    
    var3 = spawnstruct();
    
    if ( isdefined( var0 ) )
    {
        GscBinSkip4( 0x35, var0, var3 );
        // Unknown operator ( 0x35, iw8, PC )
    }
    
    if ( isdefined( var1 ) )
    {
        GscBinSkip4( 0x35, var1, var3 );
        // Unknown operator ( 0x35, iw8, PC )
    }
    
    jumpiffalse(isdefined( var2 )) LOC_00000058;
    GscBinSkip4( 0x35, var2, var3 );
    // Unknown operator ( 0x35, iw8, PC )
    var3 waittill( "returned", var4, var5, var6 );
    var3 notify( "die" );
    var7 = spawnstruct();
    var7.location = var4;
    var7.angles = var5;
    var7.string = var6;
    return var7;
}

// Params 1
// Size: 0x5c
function ref_13c34( var0 )
{
    var1 = var0 + ( 0, 0, 10000 );
    var2 = var0 - ( 0, 0, 10000 );
    var3 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
    var4 = level.activekillstreaks;
    var5 = scripts\engine\utility::array_combine( var3, var4 );
    var6 = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 0, 0, 0, 0 );
    return scripts\engine\trace::ray_trace( var1, var2, var5, var6, 0, 1 );
}

// Params 0
// Size: 0x26
function giveprematchloadout()
{
    self endon( "death_or_disconnect" );
    
    if ( !istrue( level.br_prematchffa ) )
    {
        return;
    }
    
    if ( isdefined( level.calculateclientmatchdataextrainfopayload ) )
    {
        self [[ level.calculateclientmatchdataextrainfopayload ]]();
        return;
    }
}

// Params 0
// Size: 0x66
function calculateclientmatchdataextrainfopayload()
{
    var0 = getdvarint( "scr_br_allow_prematch_perks", 0 ) == 1;
    
    if ( !var0 )
    {
        thread scripts\mp\class::loadout_clearperks();
    }
    
    waitframe();
    
    if ( !level.allowsupers && !istrue( level.scriptedphysicaldofenabled ) || getdvar( "scr_br_gametype", "" ) == "reveal" || getdvarint( "scr_br_force_prematch_ammo_drop", 1 ) == 1 )
    {
        scripts\mp\gametypes\br_pickups::ref_12c81();
        scripts\mp\gametypes\br_pickups::forcegivesuper( "super_ammo_drop", 0 );
        return;
    }
}

// Params 2
// Size: 0x153
function givematchloadout( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 0.5;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = 20;
    }
    
    var2 = self;
    var3 = var2 scripts\mp\class::loadout_getorbuildclassstruct( var2.class );
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    var2.prevweaponobj = undefined;
    var2 scripts\mp\class::loadout_clearperks();
    var2 scripts\mp\class::loadout_updateplayerperks( var3 );
    scriptednode( var2 );
    var4 = 0;
    
    if ( isdefined( var3.loadoutsecondaryobject ) && !nullweapon( var3.loadoutsecondaryobject ) )
    {
        scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon( var2, var3.loadoutsecondaryobject, var3.loadoutsecondaryfullname, var3.loadoutsecondary, var0, var1 );
        var4++;
    }
    
    if ( isdefined( var3.loadoutprimaryobject ) && !nullweapon( var3.loadoutprimaryobject ) )
    {
        scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon( var2, var3.loadoutprimaryobject, var3.loadoutprimaryfullname, var3.loadoutprimary, var0, var1 );
        var4++;
    }
    
    if ( var4 > 1 )
    {
        var2 takeweapon( "iw8_fists_mp" );
    }
    
    var5 = [];
    
    if ( isdefined( var3.loadoutequipmentprimary ) )
    {
        GscBinSkip0( 0x2e, var5.size, var3.loadoutequipmentprimary );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    if ( isdefined( var3.loadoutequipmentsecondary ) )
    {
        GscBinSkip0( 0x2e, var5.size, var3.loadoutequipmentsecondary );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    foreach ( var7 in var5 )
    {
        if ( isdefined( level.br_pickups.br_equipnametoscriptable[ var7 ] ) )
        {
            var8 = level.br_pickups.br_equipnametoscriptable[ var7 ];
            scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var2, var8, 1 );
        }
    }
}

// Params 0
// Size: 0x1a
function givematchloadoutfordropbags()
{
    var0 = self;
    var0.prevweaponobj = undefined;
    var0 scripts\mp\class::loadout_clearperks();
    scriptednode( var0 );
}

// Params 0
// Size: 0x29
function prematchdeployparachute()
{
    self endon( "disconnect" );
    
    while ( self.sessionstate != "playing" )
    {
        waitframe();
    }
    
    thread scripts\cp_mp\parachute::startfreefall( 2, 0, undefined, undefined, 1, 0 );
}

// Params 1
// Size: 0x51
function getprematchradius( var0 )
{
    var1 = var0.radius;
    var2 = var0.minradius;
    var3 = getdvarint( "scr_br_prematch_spawn_max_radius", -1 );
    
    if ( var3 >= 0 )
    {
        var1 = var3;
    }
    
    var3 = getdvarint( "scr_br_prematch_spawn_min_radius", -1 );
    
    if ( var3 >= 0 )
    {
        var2 = var3;
    }
    
    if ( var2 >= var1 )
    {
        var1 = var2 + 1;
    }
    
    return [ var2, var1 ];
}

// Params 1
// Size: 0x72
function scriptednode( var0 )
{
    if ( istrue( level.playerkillstreakgetownerlookatignoreents ) )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    var1 = level.maxteamsize == 1;
    var2 = istrue( var0.shouldgetnewspawnpoint );
    
    if ( var1 && !var2 && !istrue( level.brking_initpostmain ) )
    {
        return;
    }
    
    if ( !tvstation_fastrope_init( var0 ) )
    {
        return;
    }
    
    if ( var0 scripts\mp\utility\perk::_hasperk( "specialty_pistoldeath" ) )
    {
        return;
    }
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        return;
    }
    
    var0 scripts\mp\utility\perk::giveperk( "specialty_pistoldeath" );
}

// Params 1
// Size: 0x2d
function search_update_delay( var0 )
{
    if ( !tvstation_fastrope_init( var0 ) )
    {
        return;
    }
    
    if ( !var0 scripts\mp\gametypes\br_public::shouldlink() )
    {
        return;
    }
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        return;
    }
    
    var0 scripts\mp\perks\perks::bears();
}

// Params 0
// Size: 0x158
function waitloadoutdone()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self waittill( "giveLoadout" );
    
    if ( scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        scripts\mp\gametypes\br_armor::searchcirclesize();
        return;
    }
    
    if ( !istrue( level.br_prematchstarted ) )
    {
        thread giveprematchloadout();
        scripts\mp\gametypes\br_armor::searchcirclesize();
        
        if ( !istrue( self.ref_12860 ) )
        {
            self.ref_12860 = 1;
            scripts\engine\utility::delaythread( 1, &scripts\mp\gametypes\br_public::dmztut_endgamewithreward, "prematch_enter", self );
            var0 = game[ "music" ][ "br_lobby_intro" ].size - 1;
            var1 = randomint( var0 );
            self setplayermusicstate( game[ "music" ][ "br_lobby_intro" ][ var1 ] );
        }
        
        var2 = getdvarint( "scr_useProfileSpawn", 0 ) != 0;
        
        if ( istrue( level.infilcanusemap ) && !var2 )
        {
            level waittill( "begin_infil_map_selection" );
            scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
            scripts\mp\gametypes\br_pickups::resetplayerinventory();
        }
        
        level waittill( "infils_ready" );
        
        if ( level.allowsupers )
        {
            scripts\mp\supers::clearsuper( 0 );
        }
    }
    
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    var3 = istrue( self.gulag ) || scripts\mp\gametypes\br_public::validtousesticker() || istrue( self.ref_12ca8 );
    scripts\mp\gametypes\br_pickups::resetplayerinventory( var3 );
    
    if ( !var3 )
    {
        scripts\mp\gametypes\br_armor::searchcirclesize();
    }
    
    scriptednode( self );
    
    if ( istrue( self.isrespawn ) )
    {
        return;
    }
    
    if ( istrue( self.gulag ) || istrue( self.ref_12ca8 ) )
    {
        return;
    }
    
    if ( !istrue( level.br_infils_disabled ) && !istrue( self.watch_for_usb_notetrack_switchoff ) )
    {
        thread scripts\mp\gametypes\br_infils::setplayerprematchallows();
        return;
    }
}

// Params 4
// Size: 0x9
function onplayerscore( var0, var1, var2, var3 )
{
    return var2;
}

// Params 11
// Size: 0x60f
function brmodifyplayerdamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    var11 = var3;
    
    if ( level.tacticalmode )
    {
        var3 = scripts\mp\damage::gamemodemodifyplayerdamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
    }
    
    if ( var1 scripts\mp\gametypes\br_public::isplayeringulag() && istrue( var1.gulagarena ) && getdvarint( "scr_gulag_mp_damage", 1 ) )
    {
        return var3;
    }
    
    if ( !isdefined( var10 ) )
    {
        var10 = var3;
    }
    
    if ( var3 > 0 )
    {
        if ( istrue( var1.tracking_max_health ) )
        {
            var1 notify( "br_try_armor_cancel" );
        }
        
        var12 = scripts\mp\utility\weapon::getweaponrootname( var5 );
        var13 = scripts\mp\utility\weapon::getweaponbasenamescript( var5 );
        var14 = weaponclass( var5 );
        
        if ( var4 == "MOD_FALLING" )
        {
            if ( isdefined( level.ref_11c94 ) )
            {
                var3 = var1 [[ level.ref_11c94 ]]( var3 );
            }
            else if ( var1 scripts\mp\utility\killstreak::isjuggernaut() )
            {
            }
            else if ( getdvarint( "scr_br_alt_mode_rocketjump", 0 ) )
            {
                if ( var1 isskydiving() )
                {
                    var1 skydive_interrupt();
                }
                
                var3 = 0;
            }
            else if ( isdefined( self.br_maxarmorhealth ) )
            {
                var3 = self.maxhealth + self.br_maxarmorhealth;
            }
            else
            {
                var3 = self.maxhealth;
            }
        }
        else if ( isdefined( var0 ) && var0 scripts\cp_mp\vehicles\vehicle::isvehicle() && !istrue( var0.stadium_one_death_func ) )
        {
            if ( isdefined( level.ref_11c96 ) )
            {
                var3 = var1 [[ level.ref_11c96 ]]( var3 );
            }
            else if ( var1 scripts\mp\utility\killstreak::isjuggernaut() )
            {
            }
            else
            {
                var15 = self.maxhealth;
                
                if ( isdefined( self.br_maxarmorhealth ) )
                {
                    var15 += self.br_maxarmorhealth;
                }
                
                var3 = scripts\mp\utility\script::roundup( var3 * var15 / level.ref_12602 );
            }
        }
        else if ( var12 == "iw8_sn_crossbow" && var4 != "MOD_PISTOL_BULLET" )
        {
        }
        else if ( var4 == "MOD_MELEE" )
        {
            var3 = int( var10 );
            var3 = ref_11c9c( var3, var5 );
            
            if ( isdefined( var0 ) )
            {
                if ( var0 scripts\mp\utility\perk::_hasperk( "serum_gadget" ) )
                {
                    var16 = _findnewlocaleplacement::randomoffsetmortar();
                    var3 = int( var3 * var16 );
                }
            }
        }
        else if ( scripts\mp\utility\weapon::iskillstreakweapon( var5 ) )
        {
            if ( istrue( var1.inlaststand ) && scripts\mp\utility\killstreak::getkillstreaknamefromweapon( var5 ) == "precision_airstrike" )
            {
                if ( isdefined( var1.disable_hotjoining_after_time ) )
                {
                    var17 = gettime() - var1.disable_hotjoining_after_time < 5000;
                    
                    if ( var17 )
                    {
                        var3 = 0;
                    }
                }
            }
        }
        else if ( var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE_SPLASH" || var4 == "MOD_PROJECTILE_SPLASH" || var4 == "MOD_FIRE" )
        {
            if ( getdvarint( "scr_br_alt_mode_rocketjump", 0 ) && isdefined( var0 ) )
            {
                var3 = 0;
                thread debug_showcardlocs( var1 );
            }
            
            if ( var12 == "claymore_mp" || var12 == "claymore_radial_mp" )
            {
                var3 = int( var3 * 1.5 );
            }
        }
        else if ( getdvarint( "scr_br_alt_mode_gg", 0 ) && var4 != "MOD_TRIGGER_HURT" )
        {
            var3 = difficulty_allowseekafterthreshold( var9, var14, var12, var8, var3 );
        }
        else if ( getdvarint( "scr_br_clamp_step_damage", istrue( level.half_size ) ) && var4 != "MOD_TRIGGER_HURT" )
        {
            var3 = died_poorly_funcs( var9, var14, var12, var8, var10, var3, var5, var4 );
        }
        
        if ( isdefined( var5 ) )
        {
            if ( var5.type == "grenade" )
            {
                switch ( var5.basename )
                {
                    case "frag_grenade_mp":
                        var3 = int( var3 * getdvarfloat( "scr_br_lethal_frag_multiplier", 2 ) );
                        break;
                    case "claymore_mp":
                        var3 = int( var3 * getdvarfloat( "scr_br_lethal_claymore_multiplier", 1.667 ) );
                        break;
                    case "semtex_mp":
                        var3 = int( var3 * getdvarfloat( "scr_br_lethal_semtex_multiplier", 1.5 ) );
                        break;
                    case "at_mine_ap_mp":
                        var3 = int( var3 * getdvarfloat( "scr_br_atMine_multiplier", 1.4 ) );
                        break;
                    case "molotov_mp":
                        var3 = int( var3 * getdvarfloat( "scr_br_molotov_multiplier", 1.45 ) );
                        break;
                    case "throwingknife_drill_mp":
                    case "throwingknife_electric_mp":
                    case "throwingknife_fire_mp":
                    case "throwingknife_mp":
                        if ( var8 == "head" || var8 == "helmet" )
                        {
                            var3 = getdvarint( "scr_br_lethal_throwingKnife_set", 300 );
                        }
                        else
                        {
                            var3 = getdvarint( "scr_br_lethal_throwingKnife_set", 200 );
                        }
                        
                        break;
                }
            }
        }
        
        if ( disablebunker11cachelocations( var1 ) )
        {
            if ( var12 != "rock_mp" )
            {
                var3 = 0;
                
                if ( isdefined( var2 ) )
                {
                    var2 thread scripts\mp\damagefeedback::updatedamagefeedback( "standard", 0, 0, "standard", 0 );
                }
            }
            else
            {
                var3 = 1;
            }
            
            if ( var1.health - var3 <= 0 )
            {
                var3 = 0;
            }
        }
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "modifyPlayerDamage" ) )
        {
            var18 = scripts\cp_mp\utility\damage_utility::packdamagedata( var2, self, var3, var5, var4, var0, var6, var7 );
            var18.shitloc = var8;
            var18.idflags = var9;
            var3 = thread scripts\mp\gametypes\br_gametypes::ref_12e05( "modifyPlayerDamage", var18 );
        }
        
        if ( var3 == 10000 && level.delay_spawn_room_soldiers == 1 )
        {
            var3 = int( level.delay_spawn_tanks );
        }
        
        if ( level.decide_new_code == 1 && istrue( self.unset_relic_shieldsonly ) && isdefined( var4 ) && var4 != "MOD_TRIGGER_HURT" )
        {
            var3 = guard_shack_mantle( var3, var1 );
        }
        
        if ( var13 == "s4_me_icepick_mp" || var13 == "s4_me_axe_mp" )
        {
            switch ( var8 )
            {
                case "none":
                    break;
                case "head":
                    var3 = level.delay_show_balloon;
                    break;
                case "neck":
                    var3 = level.delay_show_marker_to_tv_station;
                    break;
                case "torso_upper":
                    var3 = level.delay_spawn_nav_repulsor;
                    break;
                case "right_arm_upper":
                    var3 = level.delay_show_player_clip;
                    break;
                case "left_arm_upper":
                    var3 = level.delay_show_player_clip;
                    break;
            }
        }
        
        if ( isdefined( var0 ) && isdefined( var0.objweapon ) )
        {
            if ( var0.objweapon.basename == "tur_gun_fd_mp_seeking" )
            {
                var3 = int( var3 * level.pipe_room_dogtag_revive );
            }
            else if ( var0.objweapon.basename == "tur_gun_bt_mp" )
            {
                var3 = int( var3 * level.pipe_room_dogtag_revive );
            }
        }
    }
    
    if ( isdefined( var2 ) && isplayer( var2 ) && var2 method_87da( 1 ) )
    {
        if ( var3 > var11 )
        {
            var3 = var11;
        }
    }
    
    return var3;
}

// Params 2
// Size: 0x33
function ref_11c9c( var0, var1 )
{
    if ( isdefined( level.player_equip_regen ) )
    {
        var2 = scripts\mp\utility\weapon::getweaponrootname( var1.basename );
        
        if ( var2 == "iw8_fists" )
        {
            return ( var0 * level.player_equip_regen );
        }
        
        return;
    }
    
    return var1;
}

// Params 1
// Size: 0x3c
function elevator_lower( var0 )
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "modifyVehicleDamage" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "modifyVehicleDamage", var0 );
    }
    else if ( isdefined( level.playerbrsquadleaderscore ) )
    {
        return [[ level.playerbrsquadleaderscore ]]( var0 );
    }
    
    return var0.damage;
}

// Params 1
// Size: 0x1f
function ref_11c66( var0 )
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "allowMeleeVehicleDamage" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "allowMeleeVehicleDamage", var0 );
    }
    
    return 0;
}

// Params 1
// Size: 0x1e
function ref_120ab( var0 )
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "onVehicleDamaged" ) )
    {
        thread scripts\mp\gametypes\br_gametypes::ref_12e05( "onVehicleDamaged", var0 );
        return;
    }
}

// Params 1
// Size: 0x1f
function ref_11c6b( var0 )
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "ignoreVehicleExplosiveDamage" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "ignoreVehicleExplosiveDamage", var0 );
    }
    
    return 0;
}

// Params 1
// Size: 0x20
function ref_11c82( var0 )
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "shouldLastStandDamageScale" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "shouldLastStandDamageScale", var0 );
    }
    
    return 1;
}

// Params 1
// Size: 0x51, Type: bool
function ref_11c67( var0 )
{
    if ( isdefined( var0 ) )
    {
        switch ( var0 )
        {
            case "supply_c130_loot":
            case "heavy_weapon_crate":
            case "battle_royale_chopper_loot":
            case "kiosk_drop":
            case "battle_royale_loadout":
            case "battle_royale_c130_loot":
            case "battle_royale_juggernaut":
                return true;
            default:
                return false;
        }
    }
    
    return false;
}

// Params 2
// Size: 0x14a, Type: bool
function ref_11c87( var0, var1 )
{
    if ( isdefined( var1 ) )
    {
        var2 = istrue( var1.managerespawnfade );
        
        if ( !var2 )
        {
            var2 = isdefined( var1.cratetype ) && ref_11c67( var1.cratetype );
        }
        
        if ( var2 )
        {
            managerespawnfade( var1, var0, 75, -75 );
            return true;
        }
    }
    
    if ( isscriptabledefined() )
    {
        var3 = undefined;
        
        if ( isdefined( var1 ) )
        {
            var3 = getclosestpointonnavmesh( var1.origin );
            
            if ( isdefined( var3 ) )
            {
                var4 = var3 + ( 0, 0, 5 );
                var5 = playerphysicstrace( var3, var4 );
                
                if ( var5 != var4 )
                {
                    var3 = undefined;
                }
            }
        }
        
        if ( !isdefined( var3 ) )
        {
            var6 = scripts\mp\gametypes\br_public::modifyplayer_damage( var0.origin, 30 );
            var3 = getclosestpointonnavmesh( var6 );
        }
        
        if ( isdefined( var3 ) && isdefined( var1 ) && istrue( var1.manageprematchfade ) )
        {
            var7 = [];
            
            if ( isdefined( var1.stage1accradius ) && isarray( var1.stage1accradius ) )
            {
                var7 = var1.stage1accradius;
            }
            
            var8 = scripts\engine\trace::create_contents( 1, 1, 1, 1, 1, 1 );
            var9 = scripts\engine\trace::ray_trace( var0 gettagorigin( "tag_eye" ), var3, scripts\engine\utility::array_add( var7, var1 ), var8 );
            
            if ( isdefined( var9[ "hittype" ] ) && var9[ "hittype" ] != "hittype_none" || !canspawn( var3 ) )
            {
                var3 = undefined;
            }
        }
        
        if ( isdefined( var3 ) )
        {
            var0 setorigin( var3 );
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0xed
function debug_showcardlocs( var0 )
{
    var1 = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 36 );
    
    if ( self isonground() )
    {
        var2 = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 20 );
        self setorigin( var2 );
    }
    
    var3 = var1 - var0.origin;
    var3 = vectornormalize( var3 );
    var4 = getdvarfloat( "scr_br_alt_mode_rocketjump_mult", 1300 );
    var5 = undefined;
    
    if ( var3[ 2 ] > -0.3 )
    {
        var5 = getdvarfloat( "scr_br_alt_mode_rocketjump_minz", 600 );
    }
    
    var6 = distance2d( var0.origin, self.origin ) - 20;
    var7 = clamp( var6, 0, 80 ) / 100 * 0.5;
    var8 = 1;
    var9 = var8 - var7;
    var3 = var3 * var4 * var9;
    
    if ( isdefined( var5 ) )
    {
        var10 = var8 - var7 * 0.5;
        var5 *= var10;
        var3 = ( var3[ 0 ], var3[ 1 ], max( var5, var3[ 2 ] ) );
    }
    
    self setvelocity( var3 );
}

// Params 5
// Size: 0x9a
function difficulty_allowseekafterthreshold( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var0 ) && var0 & level.idflags_penetration )
    {
        var5 = 1;
    }
    else
    {
        var5 = 0;
    }
    
    if ( !var5 )
    {
        switch ( var2 )
        {
            case "pistol":
                if ( var3 == "iw8_pi_decho" || var3 == "iw8_pi_cpapa" )
                {
                    if ( var4 == "head" || var4 == "helmet" )
                    {
                        var5 = 250;
                    }
                    else
                    {
                        var5 = 150;
                    }
                }
                
                break;
            case "sniper":
                if ( var3 == "iw8_sn_crossbowx" )
                {
                    var5 = 250;
                }
                
                break;
            default:
                break;
        }
    }
    
    return var5;
}

// Params 1
// Size: 0x12, Type: bool
function tutzonetriggerlogic( var0 )
{
    return isdefined( var0 ) && var0 & level.idflags_penetration;
}

// Params 1
// Size: 0x34, Type: bool
function usefailvehiclemsg( var0 )
{
    return var0 == "iw8_sn_delta" || var0 == "iw8_sn_golf28" || var0 == "iw8_sn_mike14" || var0 == "iw8_sn_sbeta" || var0 == "iw8_sn_sksierra";
}

// Params 1
// Size: 0x2a, Type: bool
function use_respawn_rules( var0 )
{
    return var0 == "s4_mr_gecho43" || var0 == "s4_mr_m1golf" || var0 == "s4_mr_svictor40" || var0 == "s4_mr_malpha1916";
}

// Params 3
// Size: 0x1f, Type: bool
function vehicle_collision_handleevent( var0, var1, var2 )
{
    return var0 == "iw8_sn_xmike109" && var1 == "MOD_PISTOL_BULLET" && var2 == 1;
}

// Params 1
// Size: 0x3e, Type: bool
function unset_maze_ai_stealth_settings( var0 )
{
    return var0 == "iw8_sh_oscar12" || var0 == "iw8_sh_aalpha12" || var0 == "iw8_sh_t9fullauto" || var0 == "iw8_sh_dpapa12" || var0 == "iw8_sh_t9semiauto" || var0 == "s4_sh_bromeo5";
}

// Params 8
// Size: 0x3a0
function died_poorly_funcs( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = tutzonetriggerlogic( var0 );
    
    if ( !var8 )
    {
        switch ( var1 )
        {
            case "rifle":
                var9 = var5 / var4;
                
                if ( getweaponammopoolname( var6 ) == "WEAPON/AMMO_SLUGS" )
                {
                    if ( level.deletescavengerhud >= 0 )
                    {
                        var9 = var5 / var4;
                        var5 = min( var5, level.deletescavengerhud );
                        var5 = int( var9 * var5 );
                    }
                    
                    break;
                }
                
                if ( scripts\cp_mp\utility\weapon_utility::tv_station_boss( var1 ) )
                {
                    var10 = 1;
                }
                else if ( usefailvehiclemsg( var2 ) )
                {
                    if ( var3 == "head" || var3 == "helmet" )
                    {
                        var5 = getdvarint( "scr_br_min_snprsemi_headshot_dmg", 175 );
                        break;
                    }
                    
                    var10 = 1;
                }
                else if ( var2 == "iw8_ar_kilo433" || var2 == "iw8_ar_t9accurate" || var2 == "iw8_sn_t9precisionsemi" )
                {
                    var10 = level.half_size + 1;
                }
                else
                {
                    var10 = level.half_size;
                }
                
                var6 = difficulty_init( var5, var7, var10 );
                var6 = int( var10 * var6 );
                break;
            case "pistol":
            case "mg":
                if ( var3 == "iw8_pi_mike" && var7 hasattachment( "barauto_mike" ) )
                {
                    return ( var6 * 0.9 );
                }
                else if ( var3 == "iw8_pi_t9fullauto" )
                {
                    return var6;
                }
                else if ( var3 == "iw8_pi_papa320" && var7 hasattachment( "akimbo_papa320" ) )
                {
                    return ( var6 * 0.9 );
                }
                else
                {
                    var9 = var6 / var5;
                    var6 = difficulty_init( var5, var7, level.half_size );
                    var6 = int( var9 * var6 );
                }
                
                break;
            case "sniper":
                if ( level.åyæ7ª˛∏7cIq°S+›)¶è9¿à' == 0 )
                {
                    break;
                }
                
                if ( var4 == "head" || var4 == "helmet" )
                {
                    if ( vehicle_collision_handleevent( var3, var8, var6 ) )
                    {
                        var6 = 75;
                    }
                    else if ( usefailvehiclemsg( var3 ) )
                    {
                        var6 = getdvarint( "scr_br_min_snprsemi_headshot_dmg", 175 );
                    }
                    else if ( use_respawn_rules( var3 ) )
                    {
                        return var6;
                    }
                    else
                    {
                        var6 = getdvarint( "scr_br_min_snpr_headshot_dmg", 250 );
                    }
                }
                else if ( vehicle_collision_handleevent( var3, var8, var6 ) )
                {
                    return var6;
                }
                else
                {
                    var9 = var6 / var5;
                    
                    if ( usefailvehiclemsg( var3 ) || var3 == "iw8_sn_kilo98" )
                    {
                        var11 = 1;
                    }
                    else if ( var4 == "iw8_sn_romeo700" )
                    {
                        var11 = 3;
                    }
                    else
                    {
                        var11 = level.half_size;
                    }
                    
                    var8 = difficulty_init( var7, var10, var11 );
                    var8 = int( var11 * var8 );
                }
                
                break;
            case "smg":
                if ( var5 == "iw8_sm_t9cqb" || var5 == "iw8_sm_t9flechette" && var9 == "MOD_EXPLOSIVE_BULLET" )
                {
                    return var8;
                }
                else if ( scripts\cp_mp\utility\weapon_utility::tv_station_boss( var5 ) )
                {
                    var12 = 1;
                    
                    if ( var5 == "iw8_sm_t9burst" )
                    {
                        var12 = 2;
                    }
                }
                else
                {
                    var12 = 3;
                }
                
                var9 = var10 / var8;
                var10 = difficulty_init( var8, var9, var12 );
                var10 = int( var9 * var10 );
                
                if ( var9 hasattachment( "calcust_mpapa5" ) && var10 >= 30 && var10 != 36 )
                {
                    var10 *= 0.92;
                }
                
                break;
            case "spread":
                if ( var6 == "iw8_pi_t9pistolshot" && var9 hasattachment( "akimbo_pi_t9pistolshot" ) && var9 hasattachment( "extclip_pi_t9pistolshot01" ) )
                {
                    return ( var10 * 0.95 );
                }
                
                if ( var6 == "iw8_pi_t9pistolshot" )
                {
                    return var10;
                }
                
                if ( level.delete_door_clip >= 0 )
                {
                    if ( unset_maze_ai_stealth_settings( var6 ) && level.delete_dropped_weapon >= 0 )
                    {
                        var13 = level.delete_dropped_weapon;
                    }
                    else
                    {
                        var13 = level.delete_door_clip;
                    }
                    
                    var9 /= var10;
                    var9 = min( var9, var13 );
                    var9 = int( var9 * var9 );
                }
            default:
                break;
        }
    }
    
    return var9;
}

// Params 1
// Size: 0x19, Type: bool
function disablebunker11cachelocations( var0 )
{
    return istrue( var0.gulag ) && !istrue( var0.gulagarena );
}

// Params 3
// Size: 0x69
function difficulty_init( var0, var1, var2 )
{
    var3 = 0;
    
    if ( var2 == 4 )
    {
        var3 = var1 clearvehiclesticker();
    }
    else if ( var2 == 3 )
    {
        var3 = var1 getweaponclassint();
    }
    else if ( var2 == 2 )
    {
        var3 = var1 getmid3damage();
    }
    
    if ( var3 <= 0 )
    {
        var3 = var1.mindamage;
    }
    
    if ( var2 == 1 || var3 <= 0 )
    {
        var3 = var1.maxdamage;
    }
    
    if ( var0 < var3 )
    {
        return int( var3 );
    }
    
    return var0;
}

// Params 14
// Size: 0x20e
function onplayerdamaged( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 )
{
    if ( scripts\mp\utility\weapon::iskillstreakweapon( var6 ) )
    {
        if ( scripts\mp\utility\killstreak::getkillstreaknamefromweapon( var6 ) == "precision_airstrike" && istrue( level.vehicle_collision_getleveldata ) )
        {
            return;
        }
    }
    
    if ( isdefined( var1 ) && var1 != var2 && isplayer( var1 ) )
    {
        if ( var3 >= var7 )
        {
            var3 = var7;
        }
        
        if ( var3 > 0 )
        {
            var14 = scripts\mp\utility\weapon::getweaponbasenamescript( var6 );
            
            if ( var14 == "rock_mp" && isalive( var2 ) )
            {
                var2 playlocalsound( "br_gulag_rock_player_impact" );
            }
            
            if ( ( var14 == "snowball_mp" || var14 == "coal_mp" ) && isalive( var2 ) )
            {
                scripts\mp\gametypes\br_alt_mode_hh::airstrike_watchownerdisown( var14, var1, var2 );
            }
        }
        
        var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "damageDealt", var1.pers[ "damage" ] );
    }
    else if ( isdefined( var0 ) && var0 scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        var15 = var0;
        
        if ( isdefined( var15.owner ) && isplayer( var15.owner ) && var15.owner != var2 )
        {
            var15.owner scripts\mp\gametypes\br_public::updatebrscoreboardstat( "damageDealt", var15.owner.pers[ "damage" ] );
        }
    }
    else if ( isdefined( var0 ) && var0 _calloutmarkerping_isvehicleoccupiedbyenemy::unrescuable_fail() )
    {
        var16 = var0;
        
        if ( isdefined( var16.owner ) && isplayer( var16.owner ) && var16.owner != var2 )
        {
            var16.owner scripts\mp\gametypes\br_public::updatebrscoreboardstat( "damageDealt", var16.owner.pers[ "damage" ] );
        }
    }
    
    if ( isdefined( var6 ) && scripts\mp\utility\weapon::iskillstreakweapon( var6 ) )
    {
        var17 = var3 >= var7 && scripts\mp\utility\killstreak::getkillstreaknamefromweapon( var6 ) == "precision_airstrike";
        var18 = istrue( var2.inlaststand );
        
        if ( var17 && var18 )
        {
            var2.disable_hotjoining_after_time = gettime();
        }
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "onPlayerDamaged" ) )
    {
        var19 = scripts\cp_mp\utility\damage_utility::packdamagedata( var1, var2, var3, var6, var5, var0, undefined, var9 );
        thread scripts\mp\gametypes\br_gametypes::ref_12e05( "onPlayerDamaged", var19 );
        return;
    }
}

// Params 6
// Size: 0x169
function onnormaldeath( var0, var1, var2, var3, var4, var5 )
{
    if ( !istrue( level.br_prematchstarted ) )
    {
        return;
    }
    
    scripts\mp\gametypes\common::oncommonnormaldeath( var0, var1, var2, var3, var4, var5 );
    var0.hostdamagepercenthigh = 0;
    var6 = scripts\mp\utility\game::round_vehicle_logic();
    
    if ( var6 == "dmz" || var6 == "rat_race" || var6 == "risk" || var6 == "kingslayer" || var6 == "rumble" || var6 == "payload" || var6 == "rumble_invasion" || var6 == "gold_war" )
    {
        return;
    }
    
    var7 = scripts\mp\utility\game::getlivingplayers();
    
    if ( isdefined( level.numendgame ) )
    {
        if ( var7.size <= level.numendgame )
        {
            thread startendgame( level );
        }
    }
    
    var8 = level.totalplayers - var7.size;
    var9 = 0;
    
    foreach ( var11 in level.players )
    {
        if ( isdefined( var11.score ) && var11.score > var9 )
        {
            var9 = var11.score;
        }
        
        if ( isdefined( var11.petwatch ) && isalive( var11 ) )
        {
            var12 = 1 - var8 / level.totalplayers;
            var11 scripts\cp_mp\pet_watch::ref_13e23( var12, 5 );
        }
    }
    
    if ( !level.teambased )
    {
        var0.score = level.totalplayers - var7.size;
        
        foreach ( var11 in var7 )
        {
            var11.score = var0.score + 1;
        }
        
        return;
    }
}

// Params 1
// Size: 0xcb
function getalivecount( var0 )
{
    var1 = 0;
    jumpiffalse(istrue( var0 )) LOC_00000046;
    
    foreach ( var3 in level.teamnamelist )
    {
        var1 += scripts\mp\utility\teams::getteamdata( var3, "aliveCount" );
    }
    
    goto LOC_000000c8;
}

// Params 2
// Size: 0x6d
function doplayerkilledsplashes( var0, var1 )
{
    if ( istrue( level.usegulag ) && var0 scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        return;
    }
    
    var2 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( var0.team, var0.squadindex );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        if ( var4 != var0 )
        {
            var4 thread scripts\mp\hud_message::showsplash( "br_teammate_dead", undefined, var0 );
        }
    }
}

// Params 0
// Size: 0x40
function ref_13387()
{
    if ( istrue( level.usegulag ) && !istrue( level.gulag.shutdown ) )
    {
        var0 = getalivecount( 0 );
        
        if ( var0 <= getdvarint( "scr_br_fc_num_players_disable", -1 ) )
        {
            scripts\mp\gametypes\br_gulag::shutdowngulag( "player_count", var0 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x4a
function ref_13388()
{
    if ( istrue( level.usegulag ) && !istrue( level.gulag.shutdown ) )
    {
        var0 = getdvarint( "scr_br_fc_num_teams_disable", -1 );
        
        if ( var0 < 0 )
        {
            return;
        }
        
        var1 = ref_11f43( 0 );
        
        if ( var1 <= var0 )
        {
            scripts\mp\gametypes\br_gulag::shutdowngulag( "team_count", var1 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x1c1
function onplayerdisconnect( var0 )
{
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "teamSpectate" ) )
    {
        thread scripts\mp\gametypes\br_spectate::ref_11be2( var0, undefined, 0 );
    }
    
    if ( istrue( level.br_prematchstarted ) )
    {
        thread ref_13387();
        thread ref_13388();
        thread scripts\mp\gametypes\br_gulag::onplayerdisconnect( var0 );
        
        if ( isdefined( var0 ) && istrue( var0.inlaststand ) && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war" )
        {
            var0 thread scripts\mp\gametypes\br_pickups::droponplayerdeath();
            
            if ( isdefined( var0.watch_for_attack ) )
            {
                var0.watch_for_attack thread scripts\mp\damage::ref_125e3();
            }
        }
    }
    
    thread scripts\mp\gametypes\br_analytics::destpoint( var0, int( scripts\mp\utility\player::isreallyalive( var0 ) ) );
    
    if ( isdefined( var0 ) )
    {
        if ( isdefined( var0.team ) )
        {
            var1 = scripts\mp\utility\teams::getenemyteams( var0.team );
            var2 = [];
            
            foreach ( var4 in var1 )
            {
                if ( scripts\mp\utility\teams::getteamdata( var4, "aliveCount" ) )
                {
                    var2 = var4;
                }
            }
            
            var6 = var2.size + 1;
            
            if ( scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                var7 = forceunsetdemeanor( var6 );
                var8 = var7[ 0 ];
                var9 = var7[ 1 ];
                var10 = var7[ 2 ];
                var7 = undefined;
                
                if ( var8 > 0 )
                {
                    scriptableusepart( var0, var8, undefined, "disconnect" );
                    var0.matchbonus = var9;
                    var0.ref_12394 = var10;
                }
                
                ref_1319a( var0, var6 );
                var0 scripts\cp_mp\utility\game_utility::ref_13168( var6 );
                scripts\mp\gamelogic::ammobox_onplayerholduse( var0, var6 );
                var0 scripts\mp\gametypes\br_challenges::ref_11e53();
            }
            
            thread setup_intel( var0 );
        }
        
        if ( scripts\mp\flags::gameflag( "prematch_done" ) )
        {
            ref_138d6( var0 );
            ref_13fcc( var0 );
        }
    }
    
    thread ref_14006();
}

// Params 1
// Size: 0x27
function ref_13fcc( var0 )
{
    scripts\mp\gamelogic::ref_128af( var0 );
    scripts\mp\scoreboard::ref_128a8( var0 );
    var1 = getdvarint( "MTKSQRQLKN", 0 );
    
    if ( var1 )
    {
        var0 setshowinrealism();
        return;
    }
}

// Params 10
// Size: 0x241
function onplayerkilled( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    if ( istrue( level.br_prematchstarted ) )
    {
        if ( var3 == "MOD_EXECUTION" )
        {
            self.ref_14436 = 1;
        }
        else
        {
            self.ref_14436 = 0;
        }
        
        scripts\mp\gametypes\br_pickups::droponplayerdeath( var1 );
        doplayerkilledsplashes( self, var1 );
        ref_13387();
        ref_13388();
        ref_12641( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
    }
    
    scripts\mp\gametypes\br_jugg_common::onplayerkilled( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    scripts\mp\gametypes\br_pickups::resetplayerinventory();
    onplayerscore( "kill", var1, 0, self );
    
    if ( isdefined( self.watch_for_molotov_ambush_and_spawners ) )
    {
        scripts\mp\utility\outline::outlinedisable( self.watch_for_molotov_ambush_and_spawners, self );
        self.watch_for_molotov_ambush_and_spawners = undefined;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "onPlayerKilled" ) )
    {
        var10 = scripts\cp_mp\utility\damage_utility::packdamagedata( var1, self, var2, var4, var3, var0, undefined, var5 );
        var10.hitloc = var6;
        thread scripts\mp\gametypes\br_gametypes::ref_12e05( "onPlayerKilled", var10 );
    }
    
    searchradiusmax( var0, var1, var4 );
    
    if ( !istrue( level.br_prematchstarted ) )
    {
        scripts\mp\gametypes\br_plunder::playerplunderlivelobbydropondeath( var3 );
        return;
    }
    
    thread scripts\mp\gametypes\br_quest_util::onplayerkilled( var1, self );
    thread scripts\mp\gametypes\br_respawn::playerdied( var1, var4 );
    scripts\mp\gametypes\br_public::ref_1319e( 0 );
    scripts\mp\gametypes\br_public::ref_1319c( 0 );
    ref_1401f( self, self, 0, 1 );
    
    if ( istrue( self.inlaststand ) )
    {
        if ( isplayer( var1 ) )
        {
            incrementcleanupsstat( var1 );
        }
    }
    
    var11 = scripts\mp\gametypes\br_gametypes::ref_12e05( "markPlayerAsEliminatedOnKilled" );
    
    if ( !isdefined( var11 ) )
    {
        var11 = !istrue( level.usegulag );
    }
    
    if ( var11 )
    {
        ref_11b15( self, "onPlayerKilled" );
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        if ( isbot( self ) && isplayer( var1 ) && !istrue( var1 scripts\mp\gametypes\br_public::isplayeringulag() ) )
        {
            var1 notify( "killed_enemy" );
        }
    }
    
    if ( istrue( level.disable_super_in_turret.brmayconsiderplayerdead ) )
    {
        self.ref_1443f = scripts\mp\gametypes\br_public::ref_125f3();
    }
    
    if ( istrue( level.disable_super_in_turret.brlootchoppercratecapturecallback ) )
    {
        self.ref_14438 = scripts\mp\gametypes\br_public::ref_125ec();
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "kiosk_onPlayerKilled" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e05( "kiosk_onPlayerKilled", self );
    }
    
    var12 = getdvarint( "scr_spawn_hvv_tokens", 0 ) > 0;
    var13 = scripts\mp\gametypes\br_public::isplayeringulag();
    
    if ( var12 && !var13 )
    {
        var14 = getdvarfloat( "scr_br_hvv_token_chance_on_death", 0.5 );
        
        if ( randomfloat( 1 ) < var14 )
        {
            scripts\mp\gametypes\br_gametype_olaride::spawnherovillaintoken( self.origin, var1.angles + ( 0, 90, 0 ), self );
        }
    }
    
    thread ref_14006();
}

// Params 2
// Size: 0x2f
function ref_11b15( var0, var1 )
{
    ref_12640( var0, 1, var1 );
    var0.delay_enter_combat_after_investigating_grenade = 1;
    level notify( "br_player_eliminated" );
    ref_14007( var0 );
    var0 scripts\mp\gamelogic::updateplayerleaderboardstats();
}

// Params 2
// Size: 0x26
function ref_13f21( var0, var1 )
{
    ref_12640( var0, 0, var1 );
    var0.delay_enter_combat_after_investigating_grenade = 0;
    var0 scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    ref_14007( var0 );
}

// Params 10
// Size: 0xa7
function ref_12641( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    if ( getdvarint( "scr_br_print_alive_count", 1 ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) )
    {
        var10 = "*-- Kill: " + gettime() + ", ";
        var10 += scripts\engine\utility::ter_op( isdefined( var1 ) && !isstruct( var1 ), var1 getentitynumber(), "?" ) + scripts\engine\utility::ter_op( isdefined( var0 ), "," + var0 getentitynumber(), "" ) + "->";
        var10 += scripts\engine\utility::ter_op( isdefined( self ), self getentitynumber(), "?" );
        var10 += scripts\engine\utility::ter_op( isdefined( var3 ), ", " + var3, "" );
        logstring( var10 );
        return;
    }
}

// Params 2
// Size: 0x6c
function ref_12640( var0, var1 )
{
    if ( getdvarint( "scr_br_print_alive_count", 1 ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) )
    {
        var2 = scripts\engine\utility::ter_op( istrue( var0 ), "*-- Mark: ", "*-- Unmark: " ) + gettime() + ", ";
        var2 += scripts\engine\utility::ter_op( isdefined( self ), self getentitynumber(), "?" ) + ", ";
        var2 += scripts\engine\utility::ter_op( isdefined( var1 ), var1, "gamemode" );
        logstring( var2 );
        return;
    }
}

// Params 3
// Size: 0x75
function ref_1263f( var0, var1, var2 )
{
    if ( getdvarint( "scr_br_print_alive_count", 1 ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) )
    {
        var3 = scripts\engine\utility::ter_op( istrue( var0 ), "*-- Add: ", "*-- Remove: " ) + gettime() + ", ";
        var3 += scripts\engine\utility::ter_op( isdefined( self ), self getentitynumber(), "?" ) + ", " + var1 + ", ";
        var3 += scripts\engine\utility::ter_op( isdefined( var2 ), var2, "none" );
        logstring( var3 );
        return;
    }
}

// Params 1
// Size: 0x88
function getglobalbattlepassxpmultiplier( var0 )
{
    if ( getdvarint( "scr_br_print_alive_count", 1 ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) )
    {
        foreach ( var2 in level.players )
        {
            if ( isalive( var2 ) && !istrue( var2.delay_enter_combat_after_investigating_grenade ) && !var2 scripts\mp\gametypes\br_public::ref_125ec() && !var2 scripts\mp\gametypes\br_public::ref_125f3() && var2.team != var0 )
            {
                scripts\mp\utility\script::laststand_dogtags( "Player isn't eliminated and didn't win: " + var2 getentitynumber() );
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x11d
function ref_14007()
{
    var0 = self;
    var1 = 0;
    var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
    
    foreach ( var4 in var2 )
    {
        if ( istrue( var4.delay_enter_combat_after_investigating_grenade ) )
        {
            var1 |= 1 << var4.pers[ "squadMemberIndex" ] - 1;
        }
    }
    
    foreach ( var4 in var2 )
    {
        var4 setclientomnvar( "ui_br_eliminated", var1 );
    }
    
    if ( istrue( level.matchmakingmatch ) )
    {
        var8 = var0 getfireteammembers();
        
        if ( isdefined( var8 ) && var8.size > 0 )
        {
            var9 = 2;
            
            foreach ( var4 in var8 )
            {
                if ( isdefined( var4 ) && !istrue( var4.delay_enter_combat_after_investigating_grenade ) )
                {
                    var9 = 0;
                    break;
                }
            }
            
            var0 setclientomnvar( "ui_br_squad_eliminated_active", var9 );
            
            foreach ( var4 in var8 )
            {
                var4 setclientomnvar( "ui_br_squad_eliminated_active", var9 );
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x35
function incrementcleanupsstat()
{
    var0 = self;
    
    if ( !isdefined( var0.br_cleanups ) )
    {
        var0.br_cleanups = 0;
    }
    
    var0.br_cleanups++;
    var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "cleanups", var0.br_cleanups );
}

// Params 1
// Size: 0x1e
function registercrateforcleanup( var0 )
{
    level.br_pickups.crates[ level.br_pickups.crates.size ] = var0;
}

// Params 1
// Size: 0x4
function dropshield( var0 )
{
    
}

// Params 1
// Size: 0xb4
function makeitemsfromcrate( var0 )
{
    var1 = self.data;
    
    if ( var1.type == "personal" )
    {
        makepersonalweaponfromcrate( var0 );
        return;
    }
    
    if ( var1.type == "weapon" )
    {
        var2 = randomintrange( 2, 4 );
        var3 = 6 - var2;
    }
    else
    {
        var2 = randomintrange( 1, 2 );
        var3 = 6 - var2;
    }
    
    var4 = 0;
    
    for ( var5 = 0; var5 < var2 && var4 < level.br_pickups.br_dropoffsets.size ; var5++ )
    {
        if ( isdefined( makeweaponfromcrate( var4 ) ) )
        {
            var4++;
        }
    }
    
    for ( var5 = 0; var5 < var3 && var4 < level.br_pickups.br_dropoffsets.size ; var5++ )
    {
        if ( isdefined( makeitemfromcrate( var4 ) ) )
        {
            var4++;
        }
    }
}

// Params 1
// Size: 0x84
function makeweaponfromcrate( var0 )
{
    var1 = scripts\engine\utility::random( level.br_pickups.br_crateguns );
    var2 = scripts\mp\gametypes\br_pickups::relics_monitor_on_player( var1 );
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var3 = scripts\engine\utility::drop_to_ground( self.origin + level.br_pickups.br_dropoffsets[ var0 ], 50, -200, ( 0, 0, 1 ) ) + ( 0, 0, 24 );
    var4 = scripts\mp\gametypes\br_weapons::createspawnweaponatpos( var3, ( 0, 0, 90 ), var2 );
    
    if ( isdefined( var4 ) )
    {
        var4.isweaponfromcrate = 1;
    }
    
    return var4;
}

// Params 1
// Size: 0x74
function makeitemfromcrate( var0 )
{
    var1 = scripts\engine\utility::drop_to_ground( self.origin + level.br_pickups.br_dropoffsets[ var0 ], 50, -200, ( 0, 0, 1 ) ) + ( 0, 0, 12 );
    var2 = scripts\engine\utility::random( level.br_pickups.br_crateitems );
    var3 = var2;
    var4 = scripts\mp\gametypes\br_pickups::remove_roof_nodes( var1, ( 0, 0, 90 ) );
    var5 = scripts\mp\gametypes\br_pickups::spawnpickup( var3, var4, 1 );
    return var5;
}

// Params 1
// Size: 0x5f
function ref_11aa0( var0 )
{
    var1 = scripts\engine\utility::drop_to_ground( self.origin + level.br_pickups.br_dropoffsets[ 0 ], 50, -200, ( 0, 0, 1 ) ) + ( 0, 0, 12 );
    var2 = scripts\mp\gametypes\br_pickups::remove_roof_nodes( var1, ( 0, 0, 90 ) );
    var3 = scripts\mp\gametypes\br_pickups::spawnpickup( var0, var2, 1 );
    return var3;
}

// Params 1
// Size: 0x72
function makepersonalweaponfromcrate( var0 )
{
    var1 = self.data;
    var2 = scripts\engine\utility::drop_to_ground( self.origin + ( 0, 0, 6 ), 50, -200, ( 0, 0, 1 ) ) + ( 0, 0, 24 );
    var3 = scripts\mp\gametypes\br_weapons::createspawnweaponatposfromname( var2, var1.personalweaponfullname );
    
    if ( isdefined( var3 ) )
    {
        var3.isweaponfromcrate = 1;
        var0 loadweaponsforplayer( [ var1.personalweaponfullname ] );
    }
    
    return var3;
}

// Params 2
// Size: 0x5
function iconvisall( var0, var1 )
{
    
}

// Params 1
// Size: 0xb
function objvisall( var0 )
{
    scripts\mp\objidpoolmanager::objective_playermask_showtoall( var0 );
}

// Params 0
// Size: 0x1cf
function initloot()
{
    level.br_weaponweights = [];
    level.br_weaponweights[ "iw8_ar_mike4" ] = 20;
    level.br_weaponweights[ "iw8_sm_mpapa5" ] = 40;
    level.br_weaponweights[ "iw8_sh_dpapa12" ] = 40;
    level.br_weaponweights[ "iw8_la_gromeo" ] = 30;
    level.br_weaponweights[ "iw8_lm_kilo121" ] = 10;
    level.br_weaponweights[ "iw8_sn_alpha50" ] = 10;
    level.br_weaponweights[ "iw8_knife" ] = 5;
    level.br_weaponweights[ "iw8_pi_golf21" ] = 50;
    level.br_weaponweights[ "iw8_ar_akilo47" ] = 20;
    level.br_weaponweighttotal = 0;
    
    foreach ( var1 in level.br_weaponweights )
    {
        level.br_weaponweighttotal += var1;
    }
    
    level.attachmentmap = [];
    level.attachmentmap[ "iw8_ar_mike4" ] = [];
    level.attachmentmap[ "iw8_ar_akilo47" ] = [];
    level.attachmentmap[ "iw8_sm_mpapa5" ] = [];
    level.attachmentmap[ "iw8_lm_kilo121" ] = [];
    level.attachmentmap[ "iw8_sn_alpha50" ] = [];
    level.attachmentmap[ "iw8_pi_golf21" ] = [];
    level.attachmentmap[ "iw8_ar_akilo47" ] = [];
    level.baseraritymap = [];
    level.baseraritymap[ "iw8_ar_mike4" ] = 1;
    level.baseraritymap[ "iw8_ar_akilo47" ] = 1;
    level.baseraritymap[ "iw8_sm_mpapa5" ] = 1;
    level.baseraritymap[ "iw8_sh_dpapa12" ] = 1;
    level.baseraritymap[ "iw8_la_gromeo" ] = 1;
    level.baseraritymap[ "iw8_lm_kilo121" ] = 1;
    level.baseraritymap[ "iw8_sn_alpha50" ] = 3;
    level.baseraritymap[ "iw8_knife" ] = 0;
    level.baseraritymap[ "iw8_pi_golf21" ] = 0;
    level.attachraritymap = [];
    level.attachraritymap[ "holo" ] = 1;
    level.attachraritymap[ "silencer" ] = 2;
    level.attachraritymap[ "gl" ] = 2;
}

// Params 2
// Size: 0x8a, Type: bool
function weaponlocallowed( var0, var1 )
{
    foreach ( var3 in var1 )
    {
        var4 = var3.origin[ 2 ] - 24;
        var5 = var3.origin[ 2 ] + 90 - 24;
        
        if ( scripts\engine\utility::distance_2d_squared( var3.origin, var0.origin ) < 147456 && var0.origin[ 2 ] >= var4 && var0.origin[ 2 ] <= var5 )
        {
            return false;
        }
    }
    
    return true;
}

// Params 1
// Size: 0x22
function startendgame( var0 )
{
    if ( istrue( level.br_debugsolotest ) )
    {
        return;
    }
    
    scripts\mp\gamelogic::pausetimer();
    level.timepausestart = gettime();
    level.timelimitoverride = 1;
}

// Params 1
// Size: 0x118
function debugtestcirclevfx( var0 )
{
    if ( isdefined( level.circleemitters ) )
    {
        destroyemitters( level.circleemitters );
    }
    
    level notify( "runDebugVFXCircleTest" );
    waitframe();
    
    switch ( var0 )
    {
        case 1:
            thread rundebugvfxcircletest( level, 1000, 0, 15 );
            break;
        case 2:
            thread rundebugvfxcircletest( level, 2500, 1000, 20 );
            break;
        case 3:
            thread rundebugvfxcircletest( level, 4500, 2500, 25 );
            break;
        case 4:
            thread rundebugvfxcircletest( level, 7000, 4500, 40 );
            break;
        case 5:
            thread rundebugvfxcircletest( level, 10500, 7000, 70 );
            break;
        case 6:
            thread rundebugvfxcircletest( level, 15000, 10500, 80 );
            break;
        case 7:
            thread rundebugvfxcircletest( level, 20000, 15000, 80 );
            break;
        case 8:
            thread rundebugvfxcircletest( level, 50000, 20000, 80 );
            break;
    }
}

// Params 1
// Size: 0x6c
function groundraycast( var0 )
{
    var1 = scripts\engine\trace::create_contents( 0, 1, 0, 0, 1, 1 );
    var2 = var0 + ( 0, 0, 10000 );
    var3 = var2 + ( 0, 0, -20000 );
    var4 = physics_raycast( var2, var3, var1, undefined, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( var4 ) && var4.size > 0 )
    {
        return var4[ 0 ][ "position" ];
    }
    
    return ( 0, 0, 0 );
}

// Params 0
// Size: 0xa3
function debugplayercirclevfx()
{
    for ( ;; )
    {
        waitframe();
        
        if ( !isdefined( level.circledebugpos ) || !isdefined( level.circledebugradius ) )
        {
            continue;
        }
        
        var0 = distance2d( self.origin, level.circledebugpos ) < level.circledebugradius;
        
        if ( istrue( self.debugcircleincircle ) )
        {
            if ( !var0 && level.debugcircleplayerfx == 0 )
            {
                playfxontag( level._effect[ "vfx_gas_ring_player" ], self, "tag_eye" );
                level.debugcircleplayerfx = 1;
                self.debugcircleincircle = 0;
            }
            
            continue;
        }
        
        if ( var0 && !self.debugcircleincircle )
        {
            self.debugcircleincircle = 1;
            stopfxontag( level._effect[ "vfx_gas_ring_player" ], self, "tag_eye" );
            level.debugcircleplayerfx = 0;
        }
    }
}

// Params 4
// Size: 0xf6
function rundebugvfxcircletest( var0, var1, var2, var3 )
{
    level endon( "game_ended" );
    level endon( "runDebugVFXCircleTest" );
    
    if ( !istrue( level.debugcircleplayerfx ) )
    {
        thread debugplayercirclevfx();
    }
    
    var4 = 5;
    var5 = groundraycast( level.players[ 0 ], level.players[ 0 ].origin );
    level.circleemitters = spawnentsincircle( var5, var0, var3 );
    level.circledebugpos = var5;
    wait 0.1;
    spawnvfxincircle( level.circleemitters );
    var6 = var2;
    
    while ( var2 > 0 )
    {
        var7 = var2 / var6;
        var8 = var1 + ( var0 - var1 ) * var7;
        
        if ( var4 < 0 )
        {
            destroyemitters( level.circleemitters );
            
            if ( var8 <= 0 )
            {
                return;
            }
            
            level.circledebugradius = var8;
            var4 = 5;
            level.circleemitters = spawnentsincircle( var5, var8, var3 );
            wait 0.1;
            spawnvfxincircle( level.circleemitters );
        }
        else
        {
            updateemitterpositions( var5, var8, level.circleemitters );
        }
        
        var2 -= level.framedurationseconds;
        var4 -= level.framedurationseconds;
        waitframe();
    }
}

// Params 1
// Size: 0x39
function destroyemitters( var0 )
{
    for ( var1 = 0; var1 < var0.size ; var1++ )
    {
        if ( isdefined( var0[ var1 ] ) )
        {
            stopfxontag( level._effect[ "vfx_gas_ring_puffy" ], var0[ var1 ], "tag_origin" );
            var0[ var1 ] delete();
        }
    }
}

// Params 3
// Size: 0x73
function updateemitterpositions( var0, var1, var2 )
{
    var3 = var2.size;
    var4 = 6.2831 * var1;
    var5 = 360 / var3;
    
    for ( var6 = 0; var6 < var3 ; var6++ )
    {
        var7 = var5 * var6;
        var8 = sin( var7 ) * var1;
        var9 = cos( var7 ) * var1;
        var10 = groundraycast( var0 + ( var9, var8, 0 ) );
        var2[ var6 ].origin = var10;
        var2[ var6 ].angles = ( 0, var7 + 180, 0 );
    }
}

// Params 3
// Size: 0xce
function spawnentsincircle( var0, var1, var2 )
{
    var3 = [];
    var4 = 6.2831 * var1;
    var5 = var4 / var2;
    
    if ( var5 < 200 )
    {
        iprintlnbold( "Using " + int( var5 ) + " emitters" );
    }
    else
    {
        iprintlnbold( "Can't use " + int( var5 ) + " emitters, using 200 instead" );
    }
    
    var5 = min( var5, 200 );
    var6 = 360 / var5;
    
    for ( var7 = 0; var7 < var5 ; var7++ )
    {
        var8 = var6 * var7;
        var9 = sin( var8 ) * var1;
        var10 = cos( var8 ) * var1;
        var11 = groundraycast( var0 + ( var10, var9, 0 ) );
        var3 = spawn( "script_model", var11 );
        var3[ var7 ] setmodel( "tag_origin" );
        var3[ var7 ].origin = var11;
        var3[ var7 ].angles = ( 0, var8 + 180, 0 );
    }
    
    return var3;
}

// Params 1
// Size: 0x2b
function spawnvfxincircle( var0 )
{
    for ( var1 = 0; var1 < var0.size ; var1++ )
    {
        playfxontag( level._effect[ "vfx_gas_ring_puffy" ], var0[ var1 ], "tag_origin" );
    }
}

// Params 0
// Size: 0x3b
function debuggiveperkpoints()
{
    var0 = scripts\mp\utility\game::getlivingplayers();
    
    foreach ( var2 in var0 )
    {
        var2.br_perkpoints += 5;
    }
}

// Params 0
// Size: 0x1a
function ontimelimit()
{
    if ( isdefined( level.numendgame ) )
    {
        thread startendgame( level );
    }
    
    level.numendgame = undefined;
}

// Params 1
// Size: 0x59
function onplayerjointeam( var0 )
{
    if ( !isdefined( var0.team ) )
    {
        scripts\mp\utility\script::laststand_dogtags( "onPlayerJoinTeam: !IsDefined( player.team ) - " + var0.name );
    }
    
    if ( !scripts\mp\utility\teams::isgameplayteam( var0.team ) )
    {
        scripts\mp\utility\script::laststand_dogtags( "onPlayerJoinTeam: !isGameplayTeam( player.team ) - " + var0.name + " " + var0.team );
    }
    
    thread ref_1206e( var0 );
}

// Params 1
// Size: 0x14e
function ref_1206e( var0 )
{
    self endon( "disconnect" );
    waittillframeend();
    
    if ( level.teambased )
    {
        var1 = [];
        
        for ( var2 = 1; var2 < scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect() + 1 ; var2++ )
        {
            var1 = var2;
        }
        
        var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
        var4 = 1;
        
        foreach ( var6 in var3 )
        {
            if ( istrue( var6.unicornpoints ) )
            {
                continue;
            }
            
            if ( istrue( var6.tutorial_usingparachute ) )
            {
                var4 = 0;
            }
            
            if ( isdefined( var6.pers[ "squadMemberIndex" ] ) )
            {
                var1 = scripts\engine\utility::array_remove( var1, var6.pers[ "squadMemberIndex" ] );
            }
        }
        
        if ( var1.size == 0 && !isdefined( var0.pers[ "squadMemberIndex" ] ) )
        {
            scripts\mp\utility\script::laststand_dogtags( "No pers[\"squadMemberIndex\"] available, things are broken! - squadsize = " + scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect() + ", team = " + var0.team + ", squadIndex = " + var0.squadindex + ", team size = " + var3.size );
            return;
        }
        
        var8 = undefined;
        
        if ( isdefined( var0.pers[ "squadMemberIndex" ] ) )
        {
            var8 = var0.pers[ "squadMemberIndex" ];
        }
        else
        {
            var8 = var1[ 0 ];
        }
        
        if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "squadLeader" ) )
        {
            ref_1319d( var0, var4 );
        }
        
        ref_131a8( var0, var8 );
        return;
    }
}

// Params 1
// Size: 0xf9
function ondeadevent( var0 )
{
    if ( istrue( level.br_debugsolotest ) || scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war" )
    {
        return;
    }
    
    if ( isdefined( var0 ) && var0 != "all" )
    {
        thread ref_1209a( var0 );
        var1 = [];
        
        foreach ( var3 in scripts\mp\utility\teams::getenemyteams( var0 ) )
        {
            if ( scripts\mp\utility\teams::getteamdata( var3, "aliveCount" ) )
            {
                var1 = var3;
            }
        }
        
        var5 = var1.size + 1;
        
        foreach ( var7 in scripts\mp\utility\teams::getteamdata( var0, "players" ) )
        {
            var7 scripts\cp_mp\utility\game_utility::ref_13168( var5 );
            ref_138d6( var7 );
        }
        
        scripts\mp\gamelogic::default_ondeadevent( var0 );
        return;
    }
}

// Params 1
// Size: 0x9f
function ref_11f43( var0 )
{
    var1 = 0;
    var2 = level.teamnamelist;
    
    foreach ( var4 in var2 )
    {
        if ( scripts\mp\utility\teams::getteamdata( var4, "aliveCount" ) )
        {
            if ( var0 )
            {
                var1++;
                continue;
            }
            
            var5 = 0;
            var6 = scripts\mp\utility\teams::getteamdata( var4, "players" );
            
            foreach ( var8 in var6 )
            {
                if ( isdefined( var8 ) && !var8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
                {
                    var5 = 1;
                    break;
                }
            }
            
            if ( var5 )
            {
                var1++;
            }
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x92
function ref_1209a( var0 )
{
    var1 = [];
    var2 = 0;
    
    foreach ( var4 in level.teamnamelist )
    {
        if ( var4 == var0 )
        {
            continue;
        }
        
        var5 = scripts\mp\utility\teams::getteamdata( var4, "aliveCount" );
        
        if ( var5 )
        {
            var1 = var4;
            var6 = var5;
            
            if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "remainingPlayersAliveOnTeam" ) )
            {
                var6 = scripts\mp\gametypes\br_gametypes::ref_12e05( "remainingPlayersAliveOnTeam", var4 );
            }
            
            var2 += var5;
        }
    }
    
    var8 = var1.size + 1;
    ref_1209b( var0, var8, var2, 0 );
    wait 20;
    thread scripts\mp\gamelogic::setupelevatordoor();
}

// Params 6
// Size: 0x174
function ref_1209b( var0, var1, var2, var3, var4, var5 )
{
    soundsettimescalefactorfromtable( var0, var1 );
    scripts\mp\gametypes\br_analytics::dialog_monitor_getoffground( var0, var1 );
    var6 = forceunsetdemeanor( var1 );
    var7 = var6[ 0 ];
    var8 = var6[ 1 ];
    var9 = var6[ 2 ];
    var6 = undefined;
    var10 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    foreach ( var12 in var10 )
    {
        if ( isdefined( var12 ) )
        {
            scriptableusepart( var12, var7, undefined, "squadEliminated" );
            var12.ref_1287a = var7;
            var12.matchbonus = var8;
            var12.ref_12394 = var9;
        }
    }
    
    if ( !istrue( var4 ) )
    {
        wait 1.5;
    }
    
    if ( !istrue( level.vehicle_collision_getleveldata ) )
    {
        if ( !istrue( var3 ) && var2 < 5 )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "top_5_lose", 0, var10, 1 );
        }
        else if ( !istrue( var3 ) && var2 < 10 )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "top_10_lose", 0, var10, 1 );
        }
        else if ( !istrue( var3 ) && var2 < 25 )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "top_25_lose", 0, var10, 1 );
        }
        
        if ( !istrue( var5 ) )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "team_loss", 0, var10, 1 );
        }
    }
    
    foreach ( var12 in var10 )
    {
        if ( isdefined( var12 ) )
        {
            thread setup_intel( var12 );
            ref_1319a( var12, var1 );
            ref_138d6( var12 );
            scripts\mp\gamelogic::ammobox_onplayerholduse( var12, var1 );
            ref_13fcc( var12 );
        }
    }
    
    ref_13120( var0 );
}

// Params 1
// Size: 0x9e
function setup_intel( var0 )
{
    var1 = self;
    var1 endon( "disconnnect" );
    
    if ( var0 < 4 )
    {
        var1 scripts\cp_mp\pet_watch::below_player_eye_allowance();
    }
    
    var2 = gettime();
    var1 setclientomnvar( "ui_br_player_position", var0 );
    
    if ( !istrue( var1.br_spectatorinitialized ) && !var1 scripts\mp\gametypes\br_public::ref_125f3() && !var1 scripts\mp\gametypes\br_public::ref_125ec() )
    {
        var1 waittill( "br_spectatorInitialized" );
    }
    
    var1 setclientomnvar( "ui_br_squad_eliminated_active", 1 );
    var1 setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "defeat" ] );
    var1 setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "br_eliminated" ] );
    var1 scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    var1 notify( "br_team_fully_eliminated" );
}

// Params 1
// Size: 0x89
function ref_1319a( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1 ) || istrue( var1.ref_12396 ) )
    {
        return;
    }
    
    var1.ref_12396 = 1;
    var1.ref_13ab8 = var0;
    
    if ( var0 <= 25 )
    {
        var1 scripts\mp\utility\stats::incpersstat( "topTwentyFive", 1 );
        
        if ( var0 <= 10 )
        {
            var1 scripts\mp\utility\stats::incpersstat( "topTen", 1 );
            
            if ( var0 <= 5 )
            {
                var1 scripts\mp\utility\stats::incpersstat( "topFive", 1 );
                
                if ( var0 == 1 )
                {
                    var1 scripts\mp\utility\stats::incpersstat( "wins", 1 );
                }
            }
        }
        
        var1 scripts\mp\gamelogic::updateplayerleaderboardstats();
        return;
    }
}

// Params 1
// Size: 0xdf
function forceunsetdemeanor( var0 )
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "calculateBRBonusXP" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "calculateBRBonusXP", var0 );
    }
    
    if ( usingtacmap() )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( isdefined( level.ref_133c0 ) && istrue( level.ref_133c0 ) )
    {
        return [ 0, 0, 0 ];
    }
    
    var1 = getdvarfloat( "scr_br_time_XP_milisecond", 0.0039 );
    
    if ( !isdefined( level.ref_13864 ) || !isdefined( var0 ) || !isdefined( level.ref_14676 ) || level.ref_13864 <= 0 || var0 <= 0 || level.ref_14676 <= 0 )
    {
        return [ 0, 0, 0 ];
    }
    
    var2 = gettime() - level.ref_13864;
    var3 = int( var1 * var2 + 0.5 );
    var4 = level.ref_14676 * ( level.ref_14678 - var0 + 1 );
    var5 = var3 + var4;
    return [ var5, var3, var4 ];
}

// Params 0
// Size: 0x15
function usingtacmap()
{
    return getdvarint( "scr_subType_overrideRespawnTest", scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) );
}

// Params 0
// Size: 0xf
function usingobject()
{
    return getdvarint( "scr_subType_overrideBigTeamTest", scripts\mp\menus::ref_13733() );
}

// Params 0
// Size: 0x23
function ref_12c6f()
{
    scripts\cp\vehicles\vehicle_compass_cp::ref_12c6e( "driving" );
    scripts\cp\vehicles\vehicle_compass_cp::ref_12c6e( "alive_in_gas" );
    scripts\cp\vehicles\vehicle_compass_cp::ref_12c6e( "alive_not_downed" );
}

// Params 0
// Size: 0x23
function ref_138d6()
{
    scripts\cp\vehicles\vehicle_compass_cp::ref_138d5( "driving" );
    scripts\cp\vehicles\vehicle_compass_cp::ref_138d5( "alive_in_gas" );
    scripts\cp\vehicles\vehicle_compass_cp::ref_138d5( "alive_not_downed" );
}

// Params 3
// Size: 0x8a
function searchradiusmax( var0, var1, var2 )
{
    var3 = self;
    
    if ( isdefined( var1 ) && var1 _calloutmarkerping_handleluinotify_mappingdeletemarker::updateexpiredlootleader() )
    {
        if ( isdefined( var3.team ) && isdefined( var1.team ) && var3.team != var1.team )
        {
            if ( isdefined( var2 ) && isdefined( var2.basename ) && var2.basename == "tur_gun_bt_mp" )
            {
                var4 = var1.vehicle.owner;
                
                if ( isdefined( var4 ) && var4 != var1 )
                {
                    var4 thread scripts\mp\utility\points::sec_sys_struct_1( "br_bt_turret_assist" );
                    return;
                }
                
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x15e
function scriptableusepart( var0, var1, var2 )
{
    if ( !isdefined( self ) || isbot( self ) || initmaxspeedforpathlengthtable( self ) )
    {
        return;
    }
    
    if ( !game[ "timePassed" ] )
    {
        return;
    }
    
    if ( !( scripts\mp\utility\game::matchmakinggame() || getdvarint( "OSPNSPSKL" ) ) )
    {
        return;
    }
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "allowEndGameXPBonus" ) && ( usingtacmap() || usingobject() ) )
    {
        return;
    }
    
    if ( !getdvarint( "scr_rebirth_bonus_xp_allowed", 1 ) )
    {
        var3 = scripts\mp\utility\game::round_vehicle_logic();
        
        if ( var3 == "rebirth" || var3 == "rebirth_reverse" || var3 == "treasure_hunt" || var3 == "rebirth_dbd" || var3 == "rebirth_dbd_reverse" )
        {
            return;
        }
    }
    
    if ( isdefined( self.dialog_wait_ready ) && self.dialog_wait_ready == 0 )
    {
        return;
    }
    
    var4 = 0;
    var5 = 0;
    
    if ( !isdefined( var2 ) )
    {
        var2 = "undefined";
    }
    
    switch ( var2 )
    {
        case "disconnect":
            var4 = 1;
            var5 = 1;
            break;
        case "squadEliminated":
            var4 = 1;
            var5 = 1;
            break;
        case "endGame":
        case "winner":
            var4 = 1;
            var5 = 1;
            break;
        case "undefined":
        default:
            var4 = 0;
            var5 = 1;
            break;
    }
    
    if ( isdefined( self.ref_1287a ) )
    {
        var0 -= self.ref_1287a;
    }
    
    if ( var0 > 0 )
    {
        scripts\mp\rank::giverankxp( "br_timeXPBonus", var0, var1, var4, var5 );
        scripts\mp\gametypes\br_analytics::deregisterscriptableinstance( var0, var2 );
    }
    
    self.dialog_wait_ready = 0;
}

// Params 0
// Size: 0xb3
function ref_1319b()
{
    var0 = 545000;
    var1 = var0;
    var2 = max( 1, level.maxteamsize );
    var3 = 0;
    
    foreach ( var5 in level.teamnamelist )
    {
        if ( scripts\mp\utility\teams::getteamdata( var5, "teamCount" ) )
        {
            var3++;
        }
    }
    
    var3 = max( 1, var3 );
    var7 = 200;
    var8 = 25;
    var9 = int( var3 * ( var3 + 1 ) / 2 );
    var9 = max( var9, 1 );
    var10 = int( var1 / var9 * var2 + 0.9 );
    var10 = int( clamp( var10, var8, var7 ) );
    var11 = getdvarint( "scr_br_placement_XP_share", var10 );
    level.ref_14676 = var11;
    level.ref_14678 = var3;
    level.ref_13864 = gettime();
}

// Params 1
// Size: 0x39
function searchradiusidealmax( var0 )
{
    if ( !isdefined( level.ref_145a5 ) )
    {
        level.ref_145a5 = freight_lift_combat();
    }
    
    var1 = self.lastnormalweaponobj;
    var2 = int( var0 * level.ref_145a5 );
    scriptableusestate( "", var2, var1, 1, 0 );
}

// Params 0
// Size: 0x21
function freight_lift_combat()
{
    var0 = getdvarfloat( "scr_br_weapon_XP_milsecond" );
    
    if ( var0 != 0 )
    {
        return var0;
    }
    
    var1 = 0.0031;
    return var1;
}

// Params 5
// Size: 0x8d
function scriptableusestate( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var2 ) || scripts\mp\utility\weapon::iskillstreakweapon( var2 ) || scripts\mp\utility\weapon::isvehicleweapon( var2 ) )
    {
        return;
    }
    
    if ( isdefined( self.owner ) && !isbot( self ) )
    {
        scriptableusestate( self.owner, var0, var1, var2 );
        return;
    }
    
    if ( isai( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( var1 ) || var1 <= 0 )
    {
        return;
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = 0;
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = 0;
    }
    
    if ( !var3 )
    {
        scripts\mp\utility\points::displayscoreeventpoints( var1, var0 );
    }
    
    if ( !level.playerxpenabled )
    {
        return;
    }
    
    thread ref_1435e( var0, var1, var2, var4 );
}

// Params 4
// Size: 0xb1
function ref_1435e( var0, var1, var2, var3 )
{
    self endon( "disconnect" );
    
    if ( !isdefined( var3 ) )
    {
        var3 = 0;
    }
    
    if ( !var3 )
    {
        waitframe();
        scripts\mp\utility\script::waittillslowprocessallowed();
    }
    
    var4 = 0;
    
    if ( !isdefined( var2 ) || !scripts\mp\weaponrank::weaponshouldgetxp( var2.basename ) )
    {
        return;
    }
    
    var4 = var1;
    var4 *= scripts\mp\weaponrank::getweaponrankxpmultipliertotal();
    var4 = int( var4 );
    scripts\mp\rank::incrankxp( 0, var2, var4, "brWeaponXp" );
    
    if ( level.playerxpenabled && !isai( self ) )
    {
        if ( isdefined( var2 ) && ( scripts\mp\utility\weapon::iscacprimaryweapon( var2 ) || scripts\mp\utility\weapon::iscacsecondaryweapon( var2 ) ) )
        {
            if ( !scripts\mp\utility\weapon::ispickedupweapon( var2 ) || scripts\mp\utility\game::getgametype() == "br" )
            {
                scripts\common\utility::ref_13e0a( level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname( var2 ), "xp_earned", var4, -1, var2 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x42
function freeze_bomb_vest_timer( var0 )
{
    var1 = 100;
    var2 = 1;
    
    if ( usingtacmap() )
    {
        var2 = 0.6;
    }
    else
    {
        var2 = 20;
    }
    
    var3 = int( var1 + var0 * var2 * 80 / ( 40 + var0 ) );
    var4 = 50;
    var3 = var3 - var3 % var4 + var4;
    return var3;
}

// Params 0
// Size: 0x43
function resetpostgamestateonjoinedspectators()
{
    self endon( "disconnect" );
    var0 = gettime();
    
    if ( !istrue( self.br_spectatorinitialized ) )
    {
        self waittill( "br_spectatorInitialized" );
    }
    
    var1 = 3;
    var2 = ( gettime() - var0 ) / 1000;
    
    if ( var2 < var1 )
    {
        wait var1 - var2;
    }
    
    self setclientomnvar( "post_game_state", 0 );
}

// Params 1
// Size: 0x73
function ononeleftevent( var0 )
{
    if ( istrue( level.br_debugsolotest ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        var1 = scripts\mp\utility\game::getlastlivingplayer( var0 );
        
        if ( isdefined( var1 ) )
        {
            if ( istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "disableLastManStandingDialog", var1 ) ) )
            {
                return;
            }
            
            var1 scripts\engine\utility::delaythread( 0.5, &scripts\mp\gametypes\br_public::brleaderdialog, "last_man_standing", 0, [ var1 ] );
            return;
        }
        
        return;
    }
    
    level.lastplayerwins = scripts\mp\utility\game::getlastlivingplayer();
    level thread scripts\mp\gamelogic::endgame( level.lastplayerwins, game[ "end_reason" ][ "enemies_eliminated" ] );
}

// Params 1
// Size: 0xac
function onsuicidedeath( var0 )
{
    if ( !level.teambased )
    {
        var1 = scripts\mp\utility\game::getlivingplayers();
        var0.score = level.totalplayers - var1.size;
        
        foreach ( var3 in var1 )
        {
            var3.score = var0.score + 1;
        }
    }
    
    if ( !isgamebattlematch() && istrue( var0.elevator_manager ) )
    {
        if ( !isdefined( var0.hostdamagepercenthigh ) )
        {
            var0.hostdamagepercenthigh = 1;
        }
        else
        {
            var0.hostdamagepercenthigh++;
        }
        
        if ( var0.hostdamagepercenthigh >= getdvarint( "scr_br_kick_consecutive_suicides", 5 ) )
        {
            level thread scripts\mp\teams::vehomn_controlsarefadedoutorhidden( var0 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x1b, Type: bool
function ref_11e38()
{
    if ( isdefined( level.forcedend ) )
    {
        return ( scripts\mp\gametypes\br_public::tutorial_playsound() && level.forcedend );
    }
    
    return false;
}

// Params 4
// Size: 0x6c3
function brendgame( var0, var1, var2, var3 )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( var1 ) )
    {
        logstring( "[KEY_MOMENT] BrEndGame " + var1 );
    }
    else
    {
        logstring( "[KEY_MOMENT] BrEndGame" );
    }
    
    if ( !istrue( var3 ) )
    {
        getglobalbattlepassxpmultiplier( var0 );
    }
    
    level.gameendtime = gettime();
    level.gameended = 1;
    level notify( "game_ended", var0 );
    
    if ( scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        if ( var1 == 25 )
        {
            level.defensefactormod = 0;
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "DMZTut", "empty" ) )
            {
                var4 = scripts\cp_mp\utility\script_utility::getsharedfunc( "DMZTut", "empty" );
                level.defenderflagreset = var4;
            }
        }
        else if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "DMZTut", "endGameVO" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "DMZTut", "endGameVO" ) ]]();
        }
    }
    
    scripts\mp\gametypes\br_gulag::shutdowngulag( "end_game", 0, 1 );
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        level.playerzombiethermalupdate = 1;
    }
    
    if ( !isdefined( level.get_rid_of_minigun ) )
    {
        scripts\mp\gametypes\br_vehicles::emptyallvehicles();
    }
    
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "endGame", var0 );
    
    if ( ref_11e38() )
    {
        scripts\mp\gamelogic::endgame_regularmp( var0, var1, game[ "end_reason" ][ "br_eliminated" ] );
        return;
    }
    
    setomnvarforallclients( "ui_br_transition_type", 0 );
    var5 = undefined;
    jumpiffalse(isdefined( var0 ) && var0 != "tie") LOC_000002f8;
    var5 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    ref_145cb( var5 );
    level scripts\engine\utility::delaythread( 1, &scripts\mp\gametypes\br_challenges::ref_11b1d, var0 );
    
    if ( !isdefined( var2 ) )
    {
        var2 = 1;
    }
    
    if ( scripts\mp\gametypes\br_public::uniquelootitemid() && scripts\engine\utility::is_equal( var1, 25 ) )
    {
        var2 = 0;
    }
    
    if ( isdefined( level.ö‰òèK´ˇ;H=≥¶271¶¯∏Ô£ìc≤£Õø ) && var2 )
    {
        scripts\mp\gametypes\br_public::brleaderdialog( "team_victory", 0, var5, undefined, undefined, undefined, level.ö‰òèK´ˇ;H=≥¶271¶¯∏Ô£ìc≤£Õø );
        goto LOC_000001a4;
    }
    
    jumpiffalse(var2) LOC_000001a4;
    scripts\mp\gametypes\br_public::brleaderdialog( "team_victory", 0, var5 );
    var6 = forceunsetdemeanor( 1 );
    var7 = var6[ 0 ];
    var8 = var6[ 1 ];
    var9 = var6[ 2 ];
    var6 = undefined;
    scripts\mp\gametypes\br_analytics::dialog_monitor_getoffground( var0, 1 );
    scripts\mp\gametypes\br_ending::ref_13fbc( var5 );
    
    foreach ( var11 in var5 )
    {
        if ( !isdefined( var11 ) )
        {
            continue;
        }
        
        if ( istrue( var11.inlaststand ) )
        {
            if ( var11 scripts\mp\laststand::playanim_aibegindismountturret( "self_revive_on_kill_success", var11 ) )
            {
                var11 scripts\mp\laststand::onrevive( 1 );
            }
        }
        
        var11 scripts\mp\gametypes\br_pickups::hangar_doors_opening_quadrace();
        
        if ( istrue( var11.tracking_max_health ) )
        {
            var11 notify( "br_try_armor_cancel" );
        }
        
        var11 scripts\mp\gametypes\br_gulag::gulagfadefromblack();
        var11.spawnprotection = 1;
        var11 setclientomnvar( "ui_br_player_position", 1 );
        scriptableusepart( var11, var7, undefined, "winner" );
        var11.matchbonus = var8;
        var11.ref_12394 = var9;
        var11 scripts\cp_mp\pet_watch::below_player_eye_allowance();
        scripts\mp\gametypes\br_analytics::destroyscorelaunchonly( var11, "player_win" );
        ref_1319a( var11, 1 );
        var11 scripts\cp_mp\utility\game_utility::ref_13168( 1 );
        ref_138d6( var11 );
        scripts\mp\gamelogic::ammobox_onplayerholduse( var11, 0 );
        var11 scripts\mp\gamelogic::updateplayerleaderboardstats();
        ref_13fcc( var11 );
        
        if ( var11 ispcplayer() )
        {
            var11 setclientomnvar( "nVidiaHighlights_events", 23 );
        }
        
        if ( scripts\mp\gametypes\br_public::tutorial_playsound() && !isbot( var11 ) )
        {
            var11 thread [[ level.mover_init ]]();
        }
    }
    
    ref_13120( var0 );
    goto LOC_000005a4;
}

// Params 1
// Size: 0x45
function ref_145cb( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    foreach ( var2 in var0 )
    {
        if ( !isdefined( var2 ) || !isplayer( var2 ) )
        {
            continue;
        }
        
        var2 scripts\mp\gametypes\br_ending::namehud();
    }
}

// Params 1
// Size: 0xb5
function handleendgamesplash( var0 )
{
    var1 = [];
    
    if ( isdefined( var0 ) && var0 != "tie" )
    {
        var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    }
    
    var2 = scripts\mp\gamelogic::reinforcement_icon_objective_id();
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war" )
    {
        thread scripts\mp\music_and_dialog::ref_12789( var1 );
    }
    
    foreach ( var4 in var1 )
    {
        var4 setclientomnvar( "post_game_state", var2 );
        var4 setclientomnvar( "ui_br_end_game_splash_type", 1 );
    }
}

// Params 1
// Size: 0x95
function setup_player_stealth( var0 )
{
    if ( isdefined( var0 ) && var0 != "tie" )
    {
        var1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();
        
        foreach ( var3 in level.players )
        {
            if ( isdefined( var3.ref_126cc ) && var3.ref_126cc.team == var0 && var3.team != var0 && !isdefined( var3.shoulddropbrprimary ) )
            {
                var3 setclientomnvar( "post_game_state", var1 );
                var3 setclientomnvar( "ui_br_end_game_splash_type", 1 );
                var3.shoulddropbrprimary = 1;
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x78
function setup_player_marks( var0 )
{
    if ( isdefined( var0 ) && var0 != "tie" )
    {
        var1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();
        
        foreach ( var3 in level.players )
        {
            if ( var3.team != var0 && !isdefined( var3.shoulddropbrprimary ) )
            {
                var3 setclientomnvar( "post_game_state", var1 );
                var3 setclientomnvar( "ui_br_end_game_splash_type", 1 );
                var3.shoulddropbrprimary = 1;
            }
        }
        
        return;
    }
}

// Params 2
// Size: 0xeb
function brdpadcallback( var0, var1 )
{
    if ( istrue( level.stop_end_breach_fx ) )
    {
        return;
    }
    
    if ( isdefined( var0 ) )
    {
        switch ( var0 )
        {
            case "dpad_slot_down":
                if ( scripts\mp\gametypes\br_public::uniquelootitemid() && var1 == 0 )
                {
                    if ( isdefined( level.lootchopper_spawn ) )
                    {
                        self thread [[ level.lootchopper_spawn ]]( var0, var1 );
                    }
                    
                    break;
                }
                
                thread scripts\mp\gametypes\br_pickups::ref_1298f( var1 );
                break;
            case "dpad_slot_up":
                scripts\mp\gametypes\br_pickups::useitemfrominventory( var1 );
                break;
            case "dpad_perk_buy":
                scripts\mp\gametypes\br_perks::buyperkinslot( var1 );
                break;
            case "dpad_mayday":
                thread scripts\cp\vehicles\little_bird_mg_cp::fulton_hostage_vo();
                break;
            case "try_use_heal_slot":
                var2 = var1;
                scripts\mp\gametypes\br_pickups::ref_126e1( var2 );
                break;
            case "br_drop_all":
                if ( scripts\mp\gametypes\br_public::uniquelootitemid() && var1 == 0 )
                {
                    if ( isdefined( level.lootchopper_spawn ) )
                    {
                        self thread [[ level.lootchopper_spawn ]]( var0, var1 );
                    }
                    
                    break;
                }
                
                scripts\mp\gametypes\br_pickups::ref_12988( var1 );
                break;
            default:
                break;
        }
    }
}

// Params 1
// Size: 0x10
function get_int_or_0( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    return int( var0 );
}

// Params 0
// Size: 0x8a
function parachutecomplete()
{
    if ( disable_fulton_group_interactions() && !dialog_mount_nag_watcher() && !istrue( self.dropbagspawned ) && !istrue( level.ref_1284c ) )
    {
        if ( scripts\mp\gametypes\br_public::updatedragonsbreath() )
        {
            thread scripts\mp\gametypes\br_rewards::spawndropbagonlanding();
            
            foreach ( var1 in level.teamdata[ self.team ][ "players" ] )
            {
                var1.dropbagspawned = 1;
            }
        }
    }
    
    if ( scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        thread scripts\mp\gametypes\br_armory_kiosk::ref_1334a( 5 );
    }
    
    thread scripts\cp_mp\gestures::ref_13e1a();
}

// Params 2
// Size: 0x40
function spawnintermission( var0, var1 )
{
    scripts\mp\playerlogic::setspawnvariables();
    self freezecontrols( 1 );
    scripts\mp\utility\player::updatesessionstate( "intermission" );
    scripts\mp\utility\player::clearkillcamstate();
    self.friendlydamage = undefined;
    self spawn( var0, var1 );
    scripts\mp\utility\player::ref_12898( "playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + var0 );
    scripts\mp\utility\player::setdof_spectator();
}

// Params 1
// Size: 0xc2
function emp_drone_proximity_explode( var0 )
{
    if ( !isdefined( self.ref_1286f ) || self calloutmarkerping_getent() )
    {
        if ( !istrue( game[ "switchedsides" ] ) )
        {
            self setclientomnvar( "ui_br_extended_load_screen", 0 );
        }
        
        return;
    }
    
    thread emp_drone_should_take_damage();
    
    if ( !isdefined( self.thrust_fx_model ) )
    {
        var1 = self.ref_1286f.origin;
        var2 = scripts\mp\gametypes\br_public::ref_126b8( var1 );
        var3 = getdvarint( "scr_br_drop_prespawn_timeout_ms", 9000 );
        scripts\mp\gametypes\br_public::ref_126b9( var2, var3, 1 );
        
        if ( !istrue( level.ref_14623 ) && !istrue( self.ref_14623 ) )
        {
            ending_fade_in();
            self setclientomnvar( "ui_br_transition_type", 4 );
        }
        
        wait 0.5;
        spawnintermission( var2, self.ref_1286f.angles );
        scripts\mp\spectating::setdisabled();
    }
    else
    {
        self.thrust_fx_model = undefined;
    }
    
    scripts\mp\gametypes\br_public::ref_126ed();
    self freezecontrols( 0 );
}

// Params 0
// Size: 0x41
function emp_drone_should_take_damage()
{
    self endon( "disconnect" );
    self waittill( "brWaitAndSpawnClientComplete" );
    self clearpredictedstreampos();
    
    if ( !istrue( level.ref_14623 ) )
    {
        self setclientomnvar( "ui_br_transition_type", 0 );
    }
    
    if ( !istrue( game[ "switchedsides" ] ) )
    {
        self setclientomnvar( "ui_br_extended_load_screen", 0 );
        return;
    }
}

// Params 0
// Size: 0x9
function brprematchaddkill()
{
    self.kills++;
}

// Params 1
// Size: 0x2b
function eliminate_drone_attack_max_cooldown( var0 )
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        self.pers[ "damage" ] = self.pers[ "damage" ] + var0;
        return;
    }
}

// Params 0
// Size: 0x98
function difficulty_think()
{
    foreach ( var1 in level.players )
    {
        var1.kills = 0;
        var1.pers[ "kills" ] = 0;
        var1.score = 0;
        var1.pers[ "score" ] = 0;
        var1.egress_landlord_vo = 0;
        var1.pers[ "contracts" ] = 0;
        var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "missionsCompleted", 0 );
        var1.pers[ "damage" ] = 0;
        var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "damageDealt", 0 );
    }
}

// Params 1
// Size: 0x68
function difficulty_update_time( var0 )
{
    level endon( "game_ended" );
    var1 = getentitylessscriptablearrayinradius( undefined, undefined, undefined, undefined, "door" );
    var2 = 0;
    var3 = isdefined( var0 ) && isint( var0 );
    
    foreach ( var5 in var1 )
    {
        if ( !var5 scriptabledoorisclosed() )
        {
            var5 vehicle_getinputvalue();
            
            if ( var3 )
            {
                var2++;
                
                if ( var2 >= var0 )
                {
                    var2 = 0;
                    waitframe();
                }
            }
        }
    }
}

// Params 1
// Size: 0x28
function ref_126eb( var0 )
{
    var1 = spawnstruct();
    thread ref_143f1( var1 );
    thread ref_143fc( var1, var0 );
    var1 waittill( "waittill_proc" );
    return var1.result;
}

// Params 1
// Size: 0x30
function ref_143f1( var0 )
{
    var0 endon( "waittill_proc" );
    self waittill( "luinotifyserver", var1, var2 );
    var0.result = [ var1, var2 ];
    var0 notify( "waittill_proc" );
}

// Params 2
// Size: 0x16
function ref_143fc( var0, var1 )
{
    var0 endon( "waittill_proc" );
    wait var1;
    var0 notify( "waittill_proc" );
}

// Params 0
// Size: 0x1d5
function playerselectspawnclass()
{
    self endon( "death_or_disconnect" );
    self endon( "last_stand_start" );
    self endon( "halo_kick_c130" );
    level endon( "game_ended" );
    level endon( "end_spawn_selection" );
    
    if ( getdvarint( "scr_force_cac_sre_callstack", 0 ) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war" )
    {
        var0 = isdefined( level.allowclasschoicefunc ) && istrue( self [[ level.allowclasschoicefunc ]]() );
        scripts\mp\utility\script::laststand_dogtags( "playerSelectSpawnClass() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var0 );
    }
    
    self setclientomnvar( "ui_options_menu", 2 );
    var1 = "custom1";
    self.pers[ "class" ] = var1;
    self.class = var1;
    scripts\mp\class::preloadandqueueclass( var1 );
    var2 = getdvarfloat( "scr_dropbag_timeout", 10 );
    var3 = 0;
    var4 = var2 > 0;
    
    for ( ;; )
    {
        var5 = undefined;
        var6 = undefined;
        
        if ( var4 )
        {
            var7 = ref_126eb( 1 );
            
            if ( !isdefined( var7 ) )
            {
                var3 += 1;
                
                if ( var3 > var2 )
                {
                    self setclientomnvar( "ui_options_menu", 0 );
                    return 0;
                }
                
                self setclientomnvar( "ui_options_menu", 2 );
                continue;
            }
            
            var5 = var7[ 0 ];
            var6 = var7[ 1 ];
        }
        else
        {
            self waittill( "luinotifyserver", var5, var6 );
        }
        
        if ( var5 == "exit_loadout_bag" )
        {
            return 0;
        }
        else if ( var5 != "class_select" )
        {
            continue;
        }
        
        var8 = 0;
        
        if ( var6 >= 0 )
        {
            var9 = scripts\mp\menus::getclasschoice( var6 );
            self.pers[ "class" ] = var9;
            self.class = var9;
            scripts\mp\class::preloadandqueueclass( var9 );
            var8 = 1;
        }
        
        self setclientomnvar( "ui_options_menu", 0 );
        return var8;
    }
}

// Params 0
// Size: 0x86
function playerselectspawnsequence()
{
    var0 = self;
    var0.issquadleader = undefined;
    var0.br_infilstarted = 0;
    var0 endon( "disconnect" );
    scripts\mp\gametypes\br_vehicles::emptyallvehicles();
    var1 = 1;
    var2 = scripts\mp\gametypes\br_infils::getspawnselectionlockedtimer();
    var3 = getdvarint( "scr_br_match_timer", 25 );
    var4 = var2 + 0.5 + var3;
    var0 thread scripts\mp\gametypes\br_infils::infilallfadetoblack( var1, var4, 1 );
    wait var1;
    var0 freezecontrols( 1 );
    thread monitorjumpmasterclaim();
    
    if ( disable_flag() )
    {
        playerselectspawnclass( var0 );
    }
    
    playerselectspawnlocation( var0 );
    var0 setclientomnvar( "ui_options_menu", 0 );
    var0 freezecontrols( 0 );
}

// Params 0
// Size: 0x32
function playerstartselectspawnclassnonexclusion()
{
    var0 = self;
    var0 endon( "disconnect" );
    var0 freezecontrols( 1 );
    
    if ( disable_flag() )
    {
        playerselectspawnclass( var0 );
    }
    
    var0 setclientomnvar( "ui_options_menu", 0 );
    var0 freezecontrols( 0 );
}

// Params 0
// Size: 0x5b
function playerselectspawnlocation()
{
    var0 = self;
    var0 beginlocationselection( 0, 0, 0, 0, 4 );
    
    while ( !scripts\mp\flags::gameflag( "end_spawn_selection" ) )
    {
        var1 = waittill_confirm_or_cancel( "confirm_location_alt", "cancel_location" );
        
        if ( !isdefined( var1 ) || var1.string == "cancel_location" )
        {
            continue;
        }
        
        waittillframeend();
        scripts\mp\gametypes\br_infils::handleinfillocationselection( var1 );
        waitframe();
    }
    
    var0 endlocationselection();
}

// Params 0
// Size: 0xff
function monitorjumpmasterclaim()
{
    var0 = self;
    var0 endon( "disconnect" );
    thread listenforjumpmasterclaimluanotify();
    
    for ( var1 = 0; !scripts\mp\flags::gameflag( "end_spawn_selection" ) ; var1 = 1 )
    {
        var2 = var0 scripts\engine\utility::waittill_any_ents_return( var0, "attempt_jumpmaster_claim", var0, "squad_jumpmaster_claimed", level, "end_spawn_selection" );
        
        if ( var2 == "attempt_jumpmaster_claim" )
        {
            if ( !var1 )
            {
                var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", 2 );
                var0.issquadleader = 1;
                var0 scripts\mp\utility\lower_message::setlowermessageomnvar( 48 );
                var3 = scripts\mp\utility\teams::getfriendlyplayers( var0.team, 0 );
                
                foreach ( var5 in var3 )
                {
                    if ( var5 != var0 )
                    {
                        var5.issquadleader = 0;
                        var5 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", 0 );
                        var5 notify( "squad_jumpmaster_claimed" );
                        var5 scripts\mp\utility\lower_message::setlowermessageomnvar( 49 );
                    }
                }
            }
            else
            {
                var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", 1 );
                var0 scripts\mp\utility\lower_message::setlowermessageomnvar( 53 );
            }
            
            continue;
        }
        
        if ( var2 == "squad_jumpmaster_claimed" )
        {
        }
    }
}

// Params 0
// Size: 0x4a
function listenforjumpmasterclaimluanotify()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var0 notify( "listenClaimJumpMaster" );
    var0 endon( "listenClaimJumpMaster" );
    level endon( "end_spawn_selection" );
    
    for ( ;; )
    {
        var0 waittill( "luinotifyserver", var1 );
        
        if ( var1 == "attempt_jumpmaster_claim" )
        {
            var0 notify( "attempt_jumpmaster_claim" );
        }
    }
}

// Params 0
// Size: 0x33
function sendafksquadmembertogulag()
{
    var0 = self;
    var0.br_infilstarted = 1;
    var0 setclientomnvar( "ui_br_infil_started", 1 );
    var0 setclientomnvar( "ui_br_infiled", 1 );
    var0 playershow( 1 );
    var0 kill();
}

// Params 0
// Size: 0x26
function defend_wave_2()
{
    self endon( "disconnect" );
    self setclientomnvar( "ui_br_display_perk_info", 1 );
    wait 0.1;
    self setclientomnvar( "ui_br_display_perk_info", 0 );
}

// Params 3
// Size: 0x277
function delay_delete_reinforcement_called_icon( var0, var1, var2 )
{
    var0.gettingloadout = 1;
    var3 = undefined;
    
    if ( isdefined( var0.preloadedclassstruct ) )
    {
        var3 = var0.preloadedclassstruct;
        var0.preloadedclassstruct = undefined;
    }
    else
    {
        var3 = var0 scripts\mp\class::loadout_getclassstruct();
        var3 = var0 scripts\mp\class::loadout_updateclass( var3, var0.class );
    }
    
    var0.classstruct = var3;
    var4 = istrue( var0.inlaststand );
    var5 = defaultbreakeraction( var0, var1, var2 );
    var0.prevweaponobj = undefined;
    var0 scripts\mp\class::loadout_clearperks( 1 );
    var0 scripts\mp\class::loadout_updateplayerperks( var3 );
    scriptednode( var0 );
    
    if ( isdefined( var0.classstruct.loadoutsecondaryobject ) )
    {
        scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon( var0, var0.classstruct.loadoutsecondaryobject, var0.classstruct.loadoutsecondaryfullname, var0.classstruct.loadoutsecondary );
    }
    
    if ( isdefined( var0.classstruct.loadoutprimaryobject ) )
    {
        scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon( var0, var0.classstruct.loadoutprimaryobject, var0.classstruct.loadoutprimaryfullname, var0.classstruct.loadoutprimary );
    }
    
    var6 = [];
    
    if ( isdefined( var0.classstruct.loadoutequipmentprimary ) )
    {
        GscBinSkip0( 0x2e, var6.size, var0.classstruct.loadoutequipmentprimary );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    if ( isdefined( var0.classstruct.loadoutequipmentsecondary ) )
    {
        GscBinSkip0( 0x2e, var6.size, var0.classstruct.loadoutequipmentsecondary );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    foreach ( var8 in var6 )
    {
        if ( isdefined( level.br_pickups.br_equipnametoscriptable[ var8 ] ) )
        {
            var9 = level.br_pickups.br_equipnametoscriptable[ var8 ];
            scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var0, var9, 1 );
            
            if ( isdefined( var5.nvgwatcher ) && var5.nvgwatcher.type == var9 )
            {
                scripts\mp\gametypes\br_pickups::lootused( var5.nvgwatcher, undefined, "visible", var0, 1 );
            }
            else if ( isdefined( var5.nvidiaansel_allowduringcinematic ) && var5.nvidiaansel_allowduringcinematic.type == var9 )
            {
                scripts\mp\gametypes\br_pickups::lootused( var5.nvidiaansel_allowduringcinematic, undefined, "visible", var0, 1 );
            }
        }
    }
    
    var0.gettingloadout = 0;
    var0 notify( "giveLoadout" );
    thread defend_wave_2();
    
    if ( var4 )
    {
        var11 = var0 getcurrentprimaryweapon();
        
        if ( !issameweapon( var11 ) )
        {
            var11 = getcompleteweaponname( var11 );
        }
        
        self.laststandoldweaponobj = var11;
        var12 = brchooselaststandweapon( var0 );
        
        if ( !issameweapon( var12 ) )
        {
            var12 = getcompleteweaponname( var12 );
        }
        
        var0 scripts\mp\laststand::givelaststandweapon( var12 );
        
        if ( !var0 scripts\mp\utility\perk::_hasperk( "specialty_pistoldeath" ) )
        {
            var0 scripts\mp\utility\perk::giveperk( "specialty_pistoldeath" );
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x2b0
function defaultbreakeraction( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.ml_p3_to_safehouse_transition = 0;
    var3.ref_14598 = [];
    var3.nvgwatcher = undefined;
    var3.nvidiaansel_allowduringcinematic = undefined;
    
    if ( istrue( var2 ) )
    {
        var3.ml_p3_to_safehouse_transition = int( 6.5 );
        
        if ( getdvarint( "scr_br_dropBehindDistant", 0 ) )
        {
            var3.ml_p3_to_safehouse_transition += 14;
        }
    }
    
    foreach ( var5 in var0.equippedweapons )
    {
        var6 = scripts\mp\utility\weapon::getweaponrootname( var5.basename );
        
        if ( issameweapon( var5 ) && var5.inventorytype == "primary" )
        {
            if ( var6 != "iw8_fists" && var6 != "iw8_knifestab" )
            {
                var7 = var0 scripts\mp\gametypes\br_extract_quest::operatorsfxalias( var5 );
                
                if ( istrue( var1 ) && !var7 )
                {
                    var8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var3, var0.origin, var0.angles, var0 );
                    var9 = scripts\mp\gametypes\br_weapons::weaponspawn( var5, var0, var8, 0, 1 );
                    
                    if ( isdefined( var9 ) )
                    {
                        var10 = var0 getweaponammoclip( var5 );
                        var11 = var0 getweaponammoclip( var5, "left" );
                        var12 = 0;
                        
                        if ( var5.hasalternate )
                        {
                            var13 = var5 getaltweapon();
                            
                            if ( !scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train( var5, var13 ) )
                            {
                                var12 = var0 getweaponammoclip( var13 );
                            }
                        }
                        
                        scripts\mp\gametypes\br_pickups::ref_119f5( var9, var10, var11, var12 );
                        var3.ref_14598[ var3.ref_14598.size ] = var9;
                    }
                }
            }
            
            var0 scripts\cp_mp\utility\inventory_utility::_takeweapon( var5 );
        }
    }
    
    if ( isdefined( var0.equipment[ "primary" ] ) )
    {
        if ( istrue( var1 ) )
        {
            var15 = var0 scripts\mp\equipment::getequipmentslotammo( "primary" );
            var16 = scripts\engine\utility::array_find( level.br_pickups.br_equipname, var0.equipment[ "primary" ] );
            
            if ( isdefined( var16 ) && var15 > 0 )
            {
                var8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var3, var0.origin, var0.angles, var0 );
                var9 = scripts\mp\gametypes\br_pickups::spawnpickup( var16, var8, var15, 1 );
                
                if ( isdefined( var9 ) )
                {
                    var3.nvgwatcher = var9;
                }
            }
        }
        
        var0 scripts\mp\equipment::takeequipment( "primary" );
    }
    
    if ( isdefined( var0.equipment[ "secondary" ] ) )
    {
        if ( istrue( var1 ) )
        {
            var15 = var0 scripts\mp\equipment::getequipmentslotammo( "secondary" );
            var16 = scripts\engine\utility::array_find( level.br_pickups.br_equipname, var0.equipment[ "secondary" ] );
            
            if ( isdefined( var16 ) && var15 > 0 )
            {
                var8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var3, var0.origin, var0.angles, var0 );
                var9 = scripts\mp\gametypes\br_pickups::spawnpickup( var16, var8, var15, 1 );
                
                if ( isdefined( var9 ) )
                {
                    var3.nvidiaansel_allowduringcinematic = var9;
                    var9 scripts\mp\gametypes\br_pickups::modeloadoutupdateammo( var0, var9.type );
                }
            }
        }
        
        var0 scripts\mp\equipment::takeequipment( "secondary" );
    }
    
    var0 giveweapon( getcompleteweaponname( "iw8_fists_mp" ) );
    return var3;
}

// Params 0
// Size: 0x40
function deleteobjective()
{
    self endon( "disconnect" );
    self freezecontrols( 1 );
    self setclientomnvar( "ui_open_loadout_bag", 1 );
    var0 = playerselectspawnclass();
    self setclientomnvar( "ui_options_menu", 0 );
    self setclientomnvar( "ui_open_loadout_bag", 0 );
    self freezecontrols( 0 );
    return var0;
}

// Params 1
// Size: 0xd9
function br_givedropbagloadout( var0 )
{
    if ( istrue( self.tracking_max_health ) )
    {
        var0 notify( "br_try_armor_cancel" );
    }
    
    var1 = deleteobjective( var0 );
    
    if ( istrue( var1 ) )
    {
        scripts\cp_mp\killstreaks\airdrop::dropspecialistbonus( var0 );
    }
    else
    {
        return;
    }
    
    delay_delete_reinforcement_called_icon( var0, 1, 1 );
    var2 = scripts\engine\utility::ter_op( isstartstr( var0.class, "custom" ), 1, 0 );
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12053( var2 );
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        var3 = self.origin;
        var0 endon( "disconnect" );
        wait 0.5;
        scripts\mp\gametypes\br_analytics::destroy_intro_tank( var0, var3, self );
        scripts\mp\gametypes\br_analytics::destroyscorelaunchonly( var0, "dropbag_used" );
        
        if ( isdefined( var0.primaryweaponobj ) )
        {
            var0.primaryweaponobj.customweaponname = createheadicon( var0.primaryweaponobj );
        }
        
        if ( isdefined( var0.secondaryweaponobj ) )
        {
            var0.secondaryweaponobj.customweaponname = createheadicon( var0.secondaryweaponobj );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x30
function eliminate_drone_attack_min_cooldown( var0 )
{
    level notify( "dropbag_kill_callout_" + self.origin );
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        scripts\mp\gametypes\br_analytics::destroy_bad_traversals( self.team, self.origin );
        return;
    }
}

// Params 0
// Size: 0xa3
function cleanupdropbagsoncircle()
{
    if ( !getdvarint( "scr_br_cleanup_drop_bags_on_first_circle", 0 ) )
    {
        return;
    }
    
    level waittill( "br_circle_started" );
    
    while ( level.br_pickups.crates.size > 0 )
    {
        var0 = [];
        
        foreach ( var2 in level.br_pickups.crates )
        {
            if ( isdefined( var2 ) && ( !isdefined( var2.curprogress ) || var2.curprogress == 0 ) )
            {
                var2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
                continue;
            }
            
            var0 = var2;
        }
        
        level.br_pickups.crates = var0;
        var0 = undefined;
        wait 1;
    }
}

// Params 0
// Size: 0x1a
function brchooselaststandweapon()
{
    var0 = self;
    var1 = var0 scripts\mp\gametypes\br_public::ref_12570();
    
    if ( !isdefined( var1 ) )
    {
        var1 = "iw8_gunless";
    }
    
    return var1;
}

// Params 1
// Size: 0x16
function ref_12551( var0 )
{
    _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "laststand" );
    scripts\mp\gametypes\br_gulag::ref_12551( var0 );
}

// Params 9
// Size: 0x48, Type: bool
function ref_11c6f( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    var9 = scripts\cp_mp\utility\damage_utility::packdamagedata( var1, self, var2, var4, var3, var0, undefined, var5 );
    var9.hitloc = var6;
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "lastStandAllowed" ) && !scripts\mp\gametypes\br_gametypes::ref_12e05( "lastStandAllowed", var9 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x2d, Type: bool
function vandalize_internal( var0 )
{
    var1 = var0.attacker;
    
    if ( !isdefined( var1 ) )
    {
        return false;
    }
    
    if ( istrue( var0.assistedsuicide ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x4f
function enemy_mines_init( var0 )
{
    if ( !vandalize_internal( var0 ) )
    {
        var0.dokillcam = 0;
    }
    
    if ( !var0.dokillcam )
    {
        var0.victim clearpredictedstreampos();
    }
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "teamSpectate" ) )
    {
        scripts\mp\gametypes\br_spectate::ref_11be2( var0.victim, var0.attacker, 1 );
        return;
    }
}

// Params 1
// Size: 0x31, Type: bool
function tvstation_fastrope_init( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isalive( var0 ) )
    {
        return false;
    }
    
    if ( istrue( var0.gulag ) )
    {
        return false;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x46
function rpg_think( var0 )
{
    var1 = [];
    var2 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    foreach ( var4 in var2 )
    {
        if ( tvstation_fastrope_init( var4 ) )
        {
            var1 = var4;
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x6a
function ref_12046( var0, var1 )
{
    var2 = scripts\mp\gametypes\br_public::ref_12570();
    
    if ( tvstation_fastrope_init( var1 ) && !isdefined( var2 ) )
    {
        var3 = rpg_think( var1.team );
        
        if ( var3.size < 2 && !istrue( level.watch_for_icbm_spawners ) )
        {
            if ( var1 scripts\mp\utility\perk::_hasperk( "specialty_pistoldeath" ) )
            {
                var1 scripts\mp\utility\perk::removeperk( "specialty_pistoldeath" );
            }
        }
        
        if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "armor" ) )
        {
            var1 scripts\mp\gametypes\br_armor::disable_map_ammo_munitions();
            return;
        }
        
        return;
    }
}

// Params 13
// Size: 0x36
function emp_drone_pick_up_use_think( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12 )
{
    if ( isdefined( var1 ) && var1 != var2 && var3 >= var2.health )
    {
        ref_12046( var1, var2 );
        return;
    }
}

// Params 1
// Size: 0x6f
function disableallarmorykiosks( var0 )
{
    switch ( var0 )
    {
        case "nothing":
            return 0;
        case "noammo":
            return 1;
        case "limitedammo":
            return 2;
        case "standardammo":
            return 3;
        case "dropbag":
            return 4;
        case "dropbagtime":
            return 5;
        case "pistolarmordropbagtime":
            return 6;
        case "pistolarmor":
            return 7;
        case "altmodegoldengun":
            return 8;
        default:
            return 0;
    }
}

// Params 0
// Size: 0x22
function disabledfeatures()
{
    var0 = "pistolarmordropbagtime";
    var1 = getdvar( "scr_br_loadout_option", var0 );
    var2 = disableallarmorykiosks( var1 );
    level.delay_put_players_in_black_screen = var2;
}

// Params 0
// Size: 0x2a, Type: bool
function disable_flag()
{
    return isdefined( level.delay_put_players_in_black_screen ) && ( level.delay_put_players_in_black_screen == 1 || level.delay_put_players_in_black_screen == 2 || level.delay_put_players_in_black_screen == 3 );
}

// Params 0
// Size: 0x39, Type: bool
function disable_fulton_group_interactions()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "drogBagLoadout" ) )
    {
        return false;
    }
    
    return isdefined( level.delay_put_players_in_black_screen ) && ( level.delay_put_players_in_black_screen == 4 || level.delay_put_players_in_black_screen == 5 || level.delay_put_players_in_black_screen == 6 );
}

// Params 0
// Size: 0x2e, Type: bool
function dialog_mount_nag_watcher()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "drogBagLoadout" ) )
    {
        return false;
    }
    
    return isdefined( level.delay_put_players_in_black_screen ) && ( level.delay_put_players_in_black_screen == 5 || level.delay_put_players_in_black_screen == 6 );
}

// Params 0
// Size: 0xa0
function disable_weapon_swap_until_swap_finished()
{
    var0 = [];
    
    if ( !isdefined( level.br_level ) )
    {
        GscBinSkip0( 0x2e, var0.size, 1 );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    var1 = scripts\mp\gametypes\br_gametypes::reinforcement_manager( "dropBagDelay" );
    
    if ( isdefined( var1 ) )
    {
        var0 = var1;
        return var0;
    }
    
    var2 = -15;
    var3 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player( 0 );
    var4 = max( 0, var3 + var2 );
    var5 = getdvarfloat( "scr_br_dropbag_delay", var4 );
    
    if ( var5 < 0 )
    {
        var5 = var4;
    }
    
    var0 = var5;
    
    if ( getdvarint( "scr_br_dropbag2_enabled", 0 ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "dropBagLoop" ) )
    {
        var6 = 15;
        var7 = scripts\mp\gametypes\br_gulag::run_hud_logic();
        var8 = max( 0, var7 + var6 );
        var9 = getdvarfloat( "scr_br_dropbag2_delay", var8 );
        var0 = var9;
    }
    
    return var0;
}

// Params 0
// Size: 0x2a, Type: bool
function disable_collect_leads()
{
    return isdefined( level.delay_put_players_in_black_screen ) && ( level.delay_put_players_in_black_screen == 6 || level.delay_put_players_in_black_screen == 7 || level.delay_put_players_in_black_screen == 8 );
}

// Params 0
// Size: 0x2d
function disablealltablets()
{
    switch ( level.delay_put_players_in_black_screen )
    {
        case 8:
        case 7:
        case 6:
            return 0;
        default:
            break;
    }
}

// Params 0
// Size: 0x2a, Type: bool
function disable_cinematic_skip()
{
    return isdefined( level.delay_put_players_in_black_screen ) && ( level.delay_put_players_in_black_screen == 1 || level.delay_put_players_in_black_screen == 2 || level.delay_put_players_in_black_screen == 3 );
}

// Params 0
// Size: 0x38
function disable_usability_for_duration()
{
    if ( isdefined( level.delay_put_players_in_black_screen ) )
    {
        if ( level.delay_put_players_in_black_screen == 2 )
        {
            return 0.5;
        }
        else if ( level.delay_put_players_in_black_screen == 3 )
        {
            return 1;
        }
    }
    
    return 0;
}

// Params 0
// Size: 0x1a
function disable_timer()
{
    if ( isdefined( level.delay_put_players_in_black_screen ) )
    {
        if ( level.delay_put_players_in_black_screen == 2 )
        {
            return 20;
        }
    }
}

// Params 0
// Size: 0x256
function ref_125fc()
{
    var0 = spawnstruct();
    var0.ref_12889 = [];
    var0.brtdm_config = [];
    var0.brtruck_cleanupents = [];
    var0.brtruck_ontimelimit = [];
    var0.offhands = [];
    var0.nvidiaansel_overridecollisionradius = [];
    var1 = [];
    var2 = self getweaponslistprimaries();
    
    foreach ( var4 in var2 )
    {
        if ( !scripts\mp\utility\weapon::update_health_bar_to_player( var4 ) && !issubstr( var4.basename, "iw8_fists_mp" ) && !scripts\mp\utility\weapon::unset_relic_mythic( var4.basename ) )
        {
            var1 = var4;
        }
    }
    
    foreach ( var7 in var1 )
    {
        var8 = createheadicon( var7 );
        var0.brtdm_config[ var8 ] = weaponclipsize( var7 );
        var0.brtruck_ontimelimit[ var8 ] = self getweaponammostock( var7 );
        
        if ( scripts\mp\utility\weapon::turnexfiltoside( var7 ) )
        {
            var0.brtruck_cleanupents[ var8 ] = self getweaponammoclip( var7, "left" );
        }
        
        if ( getsubstr( var8, 0, 4 ) == "alt_" )
        {
            continue;
        }
        
        var0.ref_12889[ var0.ref_12889.size ] = var7;
    }
    
    if ( self.lastcacweaponobj != getcompleteweaponname( "none" ) )
    {
        foreach ( var4 in var0.ref_12889 )
        {
            if ( self.lastcacweaponobj == var4 )
            {
                var0.current = self.lastcacweaponobj;
                break;
            }
        }
    }
    
    var12 = self getweaponslistoffhands();
    
    foreach ( var14 in var12 )
    {
        if ( var14.basename == "bandage_br" )
        {
            continue;
        }
        
        var15 = self getweaponammoclip( var14 );
        
        if ( var15 <= 0 )
        {
            continue;
        }
        
        var0.offhands[ var0.offhands.size ] = var14;
        var16 = createheadicon( var14 );
        var0.brtdm_config[ var16 ] = var15;
    }
    
    foreach ( var19 in self.equipment )
    {
        var0.nvidiaansel_overridecollisionradius[ var19 ] = var20;
    }
    
    var0.super = undefined;
    
    if ( isdefined( self.super ) && !self.super.usepercent )
    {
        var0.super = self.equipment[ "super" ];
    }
    
    self.ref_12eb0 = var0;
}

// Params 0
// Size: 0x277
function ref_125fb()
{
    self takeallweapons( 0, 1 );
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    self.equipment[ "primary" ] = undefined;
    self.equipment[ "secondary" ] = undefined;
    self.equipment[ "health" ] = undefined;
    self.equipment[ "super" ] = undefined;
    var0 = getcompleteweaponname( "iw8_fists_mp" );
    
    if ( self.ref_12eb0.ref_12889.size < 2 )
    {
        self giveweapon( var0 );
    }
    
    var1 = 0;
    
    foreach ( var3 in self.ref_12eb0.ref_12889 )
    {
        var4 = createheadicon( var3 );
        scripts\cp_mp\utility\inventory_utility::_giveweapon( var3 );
        
        if ( !var1 )
        {
            self assignweaponprimaryslot( var4 );
            scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var3 );
            var1 = 1;
        }
        
        scripts\mp\weapons::fixupplayerweapons( self, var4 );
    }
    
    foreach ( var7 in self.ref_12eb0.offhands )
    {
        var8 = scripts\mp\equipment::getequipmentreffromweapon( var7 );
        
        if ( !isdefined( var8 ) )
        {
            continue;
        }
        
        var9 = self.ref_12eb0.nvidiaansel_overridecollisionradius[ var8 ];
        
        if ( !isdefined( var9 ) )
        {
            continue;
        }
        
        scripts\mp\equipment::giveequipment( var8, var9 );
    }
    
    foreach ( var4, var12 in self.ref_12eb0.brtruck_ontimelimit )
    {
        self setweaponammostock( var4, var12 );
        var3 = getcompleteweaponname( getweaponbasename( var4 ) );
        var13 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var3 );
        
        if ( isdefined( var13 ) )
        {
            self.br_ammo[ var13 ] = var12;
            scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype( var13 );
        }
    }
    
    foreach ( var4, var12 in self.ref_12eb0.brtdm_config )
    {
        self setweaponammoclip( var4, var12 );
    }
    
    foreach ( var4, var12 in self.ref_12eb0.brtruck_cleanupents )
    {
        self setweaponammoclip( var4, var12, "left" );
    }
    
    waitframe();
    var16 = var0;
    
    if ( isdefined( self.ref_12eb0.current ) )
    {
        var16 = self.ref_12eb0.current;
    }
    else if ( isdefined( self.ref_12eb0.ref_12889[ 0 ] ) )
    {
        var16 = self.ref_12eb0.ref_12889[ 0 ];
    }
    
    self switchtoweaponimmediate( var16 );
    
    if ( isdefined( self.ref_12eb0.super ) )
    {
        var17 = level.br_pickups.br_superreference[ level.br_pickups.br_equipnametoscriptable[ self.ref_12eb0.super ] ];
        scripts\mp\gametypes\br_pickups::forcegivesuper( var17, 0 );
    }
    
    thread scripts\cp_mp\gestures::ref_13e1a();
    self.ref_12eb0 = undefined;
}

// Params 0
// Size: 0x4a
function ending_player_disconnect_thread()
{
    foreach ( var1 in level.players )
    {
        if ( isplayer( var1 ) && var1 scripts\mp\utility\player::isinkillcam() )
        {
            var1 notify( "abort_killcam" );
            var1.cancelkillcam = 1;
        }
    }
}

// Params 1
// Size: 0x37
function disabled_seats_for_vehicle( var0 )
{
    var1 = getdvarint( "scr_br_invulnerability_time", 30 );
    
    if ( var1 > var0 )
    {
        var1 = var0;
    }
    
    wait var0 - var1;
    level.allowprematchdamage = 0;
    wait var1 / 2;
    ending_player_disconnect_thread();
    wait var1 / 2;
}

// Params 0
// Size: 0x1a
function ref_11b81()
{
    var0 = scripts\mp\gametypes\br_gametypes::ref_12e05( "maySpawn" );
    
    if ( isdefined( var0 ) )
    {
        return var0;
    }
    
    return scripts\mp\playerlogic::mayspawn();
}

// Params 1
// Size: 0x1f4
function spawnclientbr( var0 )
{
    self endon( "disconnect" );
    self.ref_13b4f = undefined;
    
    if ( scripts\mp\gametypes\br_public::iswaitingtoentergulag( self ) )
    {
        self notify( "attempted_spawn" );
        scripts\mp\gametypes\br_gulag::entergulag( self );
        self.waitingtospawn = 0;
        return;
    }
    
    if ( istrue( self.waitingtospawnamortize ) || scripts\mp\gametypes\br_public::use_csm( self ) || istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "spawnHandled", self ) ) )
    {
        self notify( "attempted_spawn" );
        self.waitingtospawn = 0;
        return;
    }
    
    if ( !ref_11b81() )
    {
        waitframe();
        self notify( "attempted_spawn" );
        
        if ( istrue( level.stop_visited_once ) || istrue( level.snatchspawnalltoc130done ) || istrue( level.debugnextpropindex ) )
        {
            if ( isdefined( level.brlatespawnplayer ) )
            {
                self thread [[ level.brlatespawnplayer ]]();
            }
            
            return;
        }
        
        return;
    }
    
    if ( istrue( var0 ) )
    {
        level.snatchspawnalltoc130done = 0;
    }
    
    if ( istrue( level.stop_visited_once ) || istrue( level.snatchspawnalltoc130done ) || istrue( level.debugnextpropindex ) )
    {
        if ( isdefined( level.brlatespawnplayer ) )
        {
            self thread [[ level.brlatespawnplayer ]]();
        }
        
        return;
    }
    
    if ( !istrue( level.debug_safehouse_regroup_start ) )
    {
        if ( isdefined( level.bypassclasschoicefunc ) )
        {
            self.class = self [[ level.bypassclasschoicefunc ]]();
        }
        else
        {
            self.class = ref_12341();
        }
    }
    
    if ( getdvarint( "scr_br_verify_prematch_loadouts", 0 ) == 1 )
    {
        thread ref_14290();
    }
    
    var1 = getdvarint( "scr_br_drop_prespawn", 1 );
    var2 = var1 && ref_14070() && !isbot( self );
    
    if ( var1 > 1 )
    {
        var2 = var2 && !istrue( self.hasspawned );
    }
    
    if ( var2 )
    {
        self.ref_1286f = getspawnpoint( var2 );
    }
    
    scripts\mp\playerlogic::waitandspawnclient( var0 );
    self freezecontrols( 1 );
    
    if ( ref_14070() )
    {
        thread prematchdeployparachute();
    }
    
    waitframe();
    self skydive_setdeploymentstatus( 0 );
    self skydive_setbasejumpingstatus( 0 );
    var3 = !self calloutmarkerping_getent();
    var4 = scripts\mp\teams::getcustomization()[ "body" ];
    var5 = gettime();
    
    if ( var3 )
    {
        while ( isalive( self ) && isdefined( self.weaponlist ) && !self hasloadedcustomizationviewmodels( var4 ) && !self hasloadedviewweapons( self.weaponlist ) )
        {
            if ( var5 + 3000 < gettime() )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    self notify( "brWaitAndSpawnClientComplete" );
    self.waitingtospawn = 0;
    self freezecontrols( 0 );
}

// Params 3
// Size: 0xca
function didgasmaskpipschange( var0, var1, var2 )
{
    var3 = 360 / var0.size;
    var4 = getdvarint( "scr_br_x1OpsFinalCircleRadiusOffset", 10000 );
    var5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var6 = 0;
    
    if ( isdefined( var2 ) )
    {
        var6 = var2;
    }
    else
    {
        var6 = scripts\mp\gametypes\br_circle::getdangercircleradius() - var4;
    }
    
    for ( var7 = 0; var7 < var0.size ; var7++ )
    {
        var8 = var6 * cos( var3 * var7 );
        var9 = var6 * sin( var3 * var7 );
        var10 = var5[ 0 ] + var8;
        var11 = var5[ 1 ] + var9;
        var12 = 0;
        var13 = ( var10, var11, var12 );
        
        if ( var1 )
        {
            foreach ( var15 in var0 )
            {
                var15.emp_target_list = var13;
            }
            
            continue;
        }
        
        var0[ var7 ].emp_target_list = var13;
    }
}

// Params 0
// Size: 0x1e
function ref_1254d()
{
    if ( scripts\cp_mp\execution::hasexecution() )
    {
        self.ref_12eae = self.executionref;
        scripts\cp_mp\execution::_clearexecution();
        self disableexecutionattack();
        return;
    }
}

// Params 0
// Size: 0x22
function ref_1254e()
{
    if ( isdefined( self.ref_12eae ) )
    {
        scripts\cp_mp\execution::_giveexecution( self.ref_12eae );
        self enableexecutionattack();
        self.ref_12eae = undefined;
        return;
    }
}

// Params 0
// Size: 0x10f
function ref_144ae()
{
    level endon( "game_ended" );
    self notify( "br_squad_leader_shift" );
    self endon( "br_squad_leader_shift" );
    var0 = self;
    var1 = var0.team;
    var2 = var0.squadindex;
    var3 = scripts\mp\utility\game::round_vehicle_logic();
    
    for ( ;; )
    {
        var4 = "";
        
        if ( var3 == "dmz" || var3 == "rat_race" || var3 == "sandbox" || var3 == "risk" || var3 == "rumble" || var3 == "payload" || var3 == "gold_war" )
        {
            var4 = var0 scripts\engine\utility::ref_143b4( "disconnect", "br_pass_squad_leader" );
        }
        else
        {
            var4 = var0 scripts\engine\utility::ref_143b6( "death", "disconnect", "remove_from_alive_count", "br_pass_squad_leader" );
        }
        
        if ( var4 == "br_pass_squad_leader" )
        {
            if ( !ref_13aae( var1 ) )
            {
                var0 playlocalsound( "br_pickup_deny" );
                continue;
            }
        }
        
        if ( var4 != "disconnect" )
        {
            if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                continue;
            }
            
            if ( !istrue( var0.br_infilstarted ) )
            {
                continue;
            }
        }
        
        if ( arenastpday( var0, var1, var2 ) )
        {
            return;
        }
    }
}

// Params 1
// Size: 0x30
function ref_131a8( var0 )
{
    var1 = self;
    var1.pers[ "squadMemberIndex" ] = var0;
    var2 = var1.game_extrainfo & 65528;
    var2 |= var0;
    var1.game_extrainfo = var2;
}

// Params 1
// Size: 0x4e
function ref_1319d( var0 )
{
    var1 = self;
    
    if ( var0 == var1 scripts\mp\gametypes\br_public::updatedragonsbreath() )
    {
        return;
    }
    
    var1.tutorial_usingparachute = var0;
    
    if ( var0 )
    {
        var1.game_extrainfo |= 64;
        thread ref_144ae();
        return;
    }
    
    var1.game_extrainfo &= ~64;
}

// Params 2
// Size: 0xd8
function arenastpday( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( var0 ) )
    {
        var0 = var2.team;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = var2.squadindex;
    }
    
    if ( isdefined( var2 ) && !var2 scripts\mp\gametypes\br_public::updatedragonsbreath() )
    {
        return 0;
    }
    
    if ( isdefined( var2 ) )
    {
        var2.should_update_track_timer = 1;
    }
    
    var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0, var2.squadindex );
    var4 = 0;
    var5 = undefined;
    
    foreach ( var7 in var3 )
    {
        var8 = ref_12512( var7 );
        
        if ( var8 > var4 )
        {
            var4 = var8;
            var5 = var7;
        }
    }
    
    var10 = 0;
    
    if ( isdefined( var5 ) )
    {
        if ( isdefined( var2 ) )
        {
            ref_1319d( var2, 0 );
        }
        
        ref_1319d( var5, 1 );
        var10 = 1;
        
        if ( !istrue( level.debugnextpropindex ) )
        {
            level scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "deploy_squad_leader", var5, 1, 0 );
        }
    }
    
    ref_1401e( var0, var1 );
    return var10;
}

// Params 2
// Size: 0x8b
function ref_13aae( var0, var1 )
{
    var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0, var1 );
    var3 = 0;
    
    foreach ( var5 in var2 )
    {
        if ( !isdefined( var5 ) || var5 scripts\mp\gametypes\br_public::updatedragonsbreath() )
        {
            continue;
        }
        
        if ( !isalive( var5 ) )
        {
            continue;
        }
        
        if ( var5 ismlgspectator() || var5 isspectatingplayer() )
        {
            continue;
        }
        
        if ( var5 scripts\mp\gametypes\br_public::isplayeringulag() )
        {
            continue;
        }
        
        if ( !istrue( var5.should_update_track_timer ) )
        {
            var3 = 1;
            break;
        }
    }
    
    return var3;
}

// Params 2
// Size: 0x43
function ref_1401e( var0, var1 )
{
    var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0, var1 );
    var3 = ref_13aae( var0, var1 );
    
    foreach ( var5 in var2 )
    {
        var5 setclientomnvar( "ui_br_squad_leader_can_pass", var3 );
    }
}

// Params 1
// Size: 0x56
function ref_12512( var0 )
{
    if ( !isdefined( var0 ) || var0 scripts\mp\gametypes\br_public::updatedragonsbreath() || var0 ismlgspectator() || var0 isspectatingplayer() || !isalive( var0 ) )
    {
        return 0;
    }
    
    if ( var0 scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        return 1;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return 2;
    }
    
    if ( istrue( var0.should_update_track_timer ) )
    {
        return 3;
    }
    
    return 4;
}

// Params 4
// Size: 0x4c
function ref_13ac7( var0, var1, var2, var3 )
{
    var4 = scripts\mp\utility\teams::getteamdata( var2, "players" );
    
    foreach ( var6 in var4 )
    {
        if ( !istrue( var6.gulag ) )
        {
            var6 thread scripts\mp\hud_message::showsplash( var0, var3, var1 );
        }
    }
}

// Params 1
// Size: 0x4c
function ref_131c8( var0 )
{
    self.issuperdisabled = var0;
    
    if ( !var0 )
    {
        new_agent_def_main();
        return;
    }
    
    var1 = scripts\mp\supers::getcurrentsuper();
    
    if ( isdefined( var1 ) )
    {
        var2 = var1.staticdata.weapon;
        var3 = self getweaponammoclip( var2 );
        self.loadoutextraperksfromgamemode = var3;
    }
    
    self notify( "super_disable_start" );
    thread scripts\mp\supers::watchsuperdisableplayer();
}

// Params 0
// Size: 0x60
function new_agent_def_main()
{
    var0 = "super_delay_mp";
    var1 = scripts\mp\supers::getcurrentsuper();
    
    if ( isdefined( var1 ) )
    {
        var2 = var1.staticdata.weapon;
        var3 = 0;
        
        if ( isdefined( self.loadoutextraperksfromgamemode ) )
        {
            var3 = self.loadoutextraperksfromgamemode;
            self.loadoutextraperksfromgamemode = undefined;
        }
        
        scripts\cp_mp\utility\inventory_utility::_giveweapon( var2 );
        self setweaponammoclip( var2, var3 );
        self assignweaponoffhandspecial( var2 );
        scripts\cp_mp\utility\inventory_utility::_takeweapon( var0 );
    }
    
    self notify( "super_disable_end" );
}

// Params 0
// Size: 0x21
function roundnumber()
{
    if ( !istrue( self.issuperdisabled ) )
    {
        return 0;
    }
    
    var0 = 0;
    
    if ( isdefined( self.loadoutextraperksfromgamemode ) )
    {
        var0 = self.loadoutextraperksfromgamemode;
    }
    
    return var0;
}

// Params 1
// Size: 0x19e, Type: bool
function ref_12099( var0 )
{
    var1 = var0 getweaponslistprimaries();
    
    if ( var0 scripts\mp\utility\killstreak::isjuggernaut() )
    {
        if ( !isdefined( var1 ) || var1.size == 0 )
        {
            var2 = var0 getcurrentweapon();
            var3 = var0 getcurrentweaponclipammo();
            var4 = weaponclipsize( var2 );
            
            if ( var3 < var4 )
            {
                var0 setweaponammoclip( var2, var4 );
                var0 scripts\mp\damagefeedback::hudicontype( "br_ammo" );
                var0 playlocalsound( "iw8_support_box_use" );
                return true;
            }
        }
    }
    
    foreach ( var6 in var1 )
    {
        var7 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var6 );
        
        if ( var6.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase( var6.underbarrel ) == "ubshtgn" )
        {
            var8 = weaponclipsize( var6 );
            var9 = int( var8 );
            var0 setweaponammoclip( var6, var9 );
            var6.ref_12cc1 = 1;
            continue;
        }
        else if ( scripts\mp\utility\weapon::update_health_on_spawn( var6 ) )
        {
            var0 setweaponammoclip( var6, var6.clipsize );
            var6.ref_12cc1 = 1;
            continue;
        }
        else if ( !isdefined( var7 ) )
        {
            continue;
        }
        
        var10 = int( level.br_ammo_max[ var7 ] / level.br_ammo_clipsize[ var7 ] );
        var0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon( var6, var10 );
        var6.ref_12cc1 = 1;
    }
    
    if ( isdefined( var0.equipment[ "primary" ] ) )
    {
        var0 scripts\mp\equipment::incrementequipmentammo( var0.equipment[ "primary" ], 2 );
    }
    
    if ( isdefined( var0.equipment[ "secondary" ] ) )
    {
        var0 scripts\mp\equipment::incrementequipmentammo( var0.equipment[ "secondary" ], 2 );
    }
    
    var0 scripts\mp\damagefeedback::hudicontype( "ammobox" );
    scripts\mp\equipment\support_box::ref_139ae( var0 );
    thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
    return true;
}

// Params 1
// Size: 0x45, Type: bool
function ref_11ffe( var0 )
{
    var1 = var0 scripts\mp\equipment::getequipmentmaxammo( "equip_armorplate" );
    
    if ( var1 <= 0 )
    {
        return false;
    }
    
    scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( var0, "brloot_armor_plate", 1, var1, 0 );
    var0 scripts\mp\damagefeedback::hudicontype( "br_armor" );
    scripts\mp\equipment\support_box::ref_139ae( var0 );
    thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
    return true;
}

// Params 1
// Size: 0xb
function airdrop_registercrateforcleanup( var0 )
{
    registercrateforcleanup( var0 );
}

// Params 1
// Size: 0xb
function br_ammorestock_playeruse( var0 )
{
    dropshield( var0 );
}

// Params 0
// Size: 0x7
function airdrop_makeweaponfromcrate()
{
    makeweaponfromcrate();
}

// Params 0
// Size: 0x7
function airdrop_makeitemfromcrate()
{
    makeitemfromcrate();
}

// Params 1
// Size: 0xb
function airdrop_makeitemsfromcrate( var0 )
{
    makeitemsfromcrate( var0 );
}

// Params 1
// Size: 0xb
function airdrop_br_givedropbagloadout( var0 )
{
    br_givedropbagloadout( var0 );
}

// Params 1
// Size: 0xb
function br_armor_repair_end( var0 )
{
    eliminate_drone_attack_min_cooldown( var0 );
}

// Params 1
// Size: 0x10
function br_armor_plate_used( var0 )
{
    scripts\mp\gametypes\br_gametypes::ref_12e05( "initCrateData", var0 );
}

// Params 1
// Size: 0x1e
function ref_12082( var0 )
{
    var1 = var0 getcurrentprimaryweapon();
    var0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon( var1 );
    var0 scripts\mp\gametypes\br_plunder::ref_12627( level.ô€s«õü8˘J#ó’x£
ÈC–„k› );
}

// Params 2
// Size: 0x12
function ref_1205c( var0, var1 )
{
    var0 scripts\mp\gametypes\br_pickups::setup_train_array( var1, "primary" );
}

// Params 2
// Size: 0x86
function ref_1203b( var0, var1 )
{
    switch ( var0 )
    {
        case "iw8_fulton_bag_mp":
            thread _debug_rooftopobjstart::playerwager( var1 );
            break;
        case "slinger_br":
            thread scripts\mp\equipment\slinger::slinger_used( var1 );
            break;
        case "rock_mp":
            thread scripts\mp\gametypes\br_gulag::rock_used( var1 );
            break;
        case "coal_mp":
            var1 thread scripts\mp\gametypes\br_alt_mode_hh::airstrike_watchgameend();
            break;
        default:
            break;
    }
    
    if ( var0 == "rock_mp" && istrue( self.ref_13b4f ) )
    {
        var1 delete();
        self.ref_13b4f = undefined;
        return;
    }
}

// Params 1
// Size: 0xb
function ref_120b0( var0 )
{
    scripts\mp\gametypes\br_weapons::takeweaponpickup( var0 );
}

// Params 1
// Size: 0xb
function ref_120af( var0 )
{
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( self );
}

// Params 0
// Size: 0x40
function ref_12691()
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerShouldRespawn" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "playerShouldRespawn" );
    }
    
    if ( !istrue( level.br_prematchstarted ) )
    {
        return 1;
    }
    
    if ( scripts\mp\gametypes\br_public::iswaitingtoentergulag( self ) )
    {
        return 1;
    }
    
    if ( scripts\mp\gametypes\br_public::use_csm( self ) )
    {
        return 1;
    }
    
    return 0;
}

// Params 2
// Size: 0x1ea
function emp_drone_damage_monitor( var0, var1 )
{
    var2 = scripts\mp\gametypes\br_gametypes::ref_12e05( "playerKilledSpawn", var0, var1 );
    
    if ( isdefined( var2 ) )
    {
        return var2;
    }
    else if ( scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war" )
    {
        if ( getdvarint( "scr_bmo_use_spawn_fix", 1 ) == 1 )
        {
            if ( scripts\mp\utility\game::updatehistoryhud( self ) )
            {
                return 1;
            }
            
            if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                return 0;
            }
            
            if ( istrue( var0.victim.hasrespawntoken ) || istrue( level.ref_14062 ) )
            {
                if ( scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    if ( isbot( var0.victim ) )
                    {
                        return 1;
                    }
                }
                
                if ( scripts\mp\utility\game::round_vehicle_logic() == "rat_race" )
                {
                    var0.victim thread scripts\mp\gametypes\br_gametype_rat_race::playerrespawn();
                }
                else
                {
                    var0.victim thread scripts\mp\gametypes\br_gametype_dmz::playerrespawn();
                }
                
                var3 = scripts\mp\utility\teams::getteamdata( var0.victim.team, "teamCount" );
                
                if ( var3 > 1 )
                {
                    var0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator( var0, var1, 1 );
                }
                
                return 1;
            }
        }
        else
        {
            if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                return 0;
            }
            
            if ( istrue( var1.victim.hasrespawntoken ) || istrue( level.ref_14062 ) )
            {
                if ( scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    if ( isbot( var1.victim ) )
                    {
                        return 1;
                    }
                }
                else if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
                {
                    var1.victim thread scripts\mp\playerlogic::respawn_asspectator( var1.victim.origin + ( 0, 0, 60 ), var1.victim.angles );
                }
                
                var1.victim thread scripts\mp\gametypes\br_gametype_dmz::playerrespawn();
                return 1;
            }
        }
    }
    else if ( !ref_12691() )
    {
        if ( !scripts\mp\utility\damage::playershoulddofauxdeath( 0 ) )
        {
            var1.victim thread scripts\mp\gametypes\br_spectate::spawnspectator( var1, var2 );
        }
        
        return 1;
    }
    
    return 0;
}

// Params 1
// Size: 0x1f
function dyn_door( var0 )
{
    var1 = scripts\mp\gametypes\br_gametypes::ref_12e05( "mayConsiderPlayerDead", var0 );
    
    if ( isdefined( var1 ) )
    {
        return var1;
    }
    
    return dynamic_door( var0 );
}

// Params 1
// Size: 0x2d, Type: bool
function dynamic_door( var0 )
{
    var1 = var0 scripts\mp\gametypes\br_gulag::trygulagspawn();
    
    if ( scripts\mp\flags::gameflag( "prematch_done" ) && !var1 )
    {
        ref_11b15( var0, "considerPlayerDead" );
    }
    
    return !var1;
}

// Params 0
// Size: 0x2
function ref_13f24()
{
    
}

// Params 0
// Size: 0xaa
function ref_11d22()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var0 = gettime();
    
    for ( ;; )
    {
        self waittill( "weapon_change" );
        var1 = gettime();
        var2 = var1 - var0;
        var0 = var1;
        
        if ( ref_13301() && var2 > 3000 )
        {
            thread searchradiusidealmax( var2 );
        }
        
        var3 = self.lastnormalweaponobj;
        
        if ( isdefined( var3 ) )
        {
            var4 = int( var2 / 1000 );
            var5 = getweaponvariantindex( var3 );
            var6 = var3.basename;
            
            if ( getsubstr( var6, 0, 4 ) == "iw8_" || getsubstr( var6, 0, 3 ) == "s4_" )
            {
                var6 = scripts\mp\utility\weapon::getweaponrootname( var3 );
            }
            
            scripts\common\utility::ref_13e0a( level.ref_11b31, var6, "time_used_s", var4, var5, var3 );
        }
    }
}

// Params 0
// Size: 0x3c, Type: bool
function ref_13301()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "weaponXpOverTime" ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "weaponXpOverTime" ) )
    {
        return true;
    }
    
    if ( scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid() || scripts\mp\utility\game::updatex1stashhud() )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x13
function weaponshouldgetxp( var0 )
{
    var1 = scripts\mp\utility\weapon::getweaponrootname( var0 );
    return weaponhasranks( var1 );
}

// Params 1
// Size: 0x2a
function weaponhasranks( var0 )
{
    if ( !isdefined( level.weaponranktable.maxweaponranks[ var0 ] ) )
    {
        return 0;
    }
    
    var1 = level.weaponranktable.maxweaponranks[ var0 ] > 0;
    return var1;
}

// Params 0
// Size: 0xb4
function bush_zones()
{
    var0 = scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war" || istrue( level.vehicle_collision_getleveldata ) || isdefined( level.ref_12d05 ) || isdefined( level.ref_12ce8 );
    
    if ( var0 )
    {
        return;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "playerCountLandmarks" ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    level waittill( "prematch_started" );
    var1 = scripts\mp\utility\game::round_vehicle_logic() == "rebirth_reverse";
    ref_1269d( level, 50, var1 );
    ref_1269d( level, 25, var1 );
    ref_1269d( level, 10, var1 );
    ref_1269d( level, 5, var1 );
}

// Params 2
// Size: 0x73
function ref_1269d( var0, var1 )
{
    level endon( "game_ended" );
    var2 = reinforcement_type();
    
    while ( var2.size > var0 )
    {
        level scripts\engine\utility::waittill_either( "br_player_eliminated", "players_remaining_changed" );
        var2 = reinforcement_type();
        
        if ( var2.size <= var0 )
        {
            var3 = !istrue( level.usegulag ) || istrue( level.gulag.shutdown );
            
            if ( var1 || var3 )
            {
                scripts\mp\gametypes\br_public::brleaderdialog( "top_" + var0, 0, undefined, 1 );
            }
            
            break;
        }
    }
}

// Params 0
// Size: 0x72
function reinforcement_type()
{
    var0 = [];
    
    foreach ( var2 in level.players )
    {
        if ( istrue( var2.delay_enter_combat_after_investigating_grenade ) )
        {
            continue;
        }
        
        if ( var2 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            continue;
        }
        
        if ( var2 scripts\mp\gametypes\br_public::ref_125ec() )
        {
            continue;
        }
        
        if ( level.codcasterenabled )
        {
            if ( var2 ismlgspectator() )
            {
                continue;
            }
        }
        
        var0 = var2;
    }
    
    return var0;
}

// Params 1
// Size: 0x7e
function ref_12c6a( var0 )
{
    if ( isdefined( var0.gulaguses ) && var0.gulaguses > 0 )
    {
        return;
    }
    
    if ( istrue( var0.play_cinderblock_broken_fx ) && !istrue( level.ref_133bf ) )
    {
        return;
    }
    
    var1 = var0 scripts\mp\persistence::statgetchildbuffered( "round", "timePlayed", 0 );
    var0.pers[ "afkResetTime" ] = var1;
    var0.pers[ "distTrackingPassed" ] = undefined;
    var0.pers[ "totalDistTraveledAFK" ] = undefined;
    var0 thread scripts\mp\playerlogic::totaldisttracking( var0.origin, 1 );
}

// Params 1
// Size: 0x2c
function ref_12036( var0 )
{
    ref_12c6a( var0 );
    
    if ( isalive( var0 ) && !istrue( var0.inlaststand ) )
    {
        var0.elevator_manager = undefined;
    }
    
    var0 scripts\cp_mp\vehicles\vehicle_compass::fulton_initanims();
}

// Params 4
// Size: 0x111
function ref_1401f( var0, var1, var2, var3 )
{
    if ( isdefined( var0.pers[ "squadMemberIndex" ] ) )
    {
        if ( !isdefined( level.deletescriptableinstance ) )
        {
            level.deletescriptableinstance = [];
        }
        
        var4 = get_int_or_0( level.deletescriptableinstance[ var0.team ] );
        
        if ( !isalive( var0 ) )
        {
            var3 = 1;
            var2 = 0;
        }
        
        var5 = var0 == var1;
        var6 = var0.pers[ "squadMemberIndex" ];
        var7 = int( ceil( clamp( var2, 0, 1 ) * 128 ) );
        var8 = var7;
        
        if ( istrue( var3 ) )
        {
            var0 scripts\mp\gametypes\br_public::ref_131a6( 0 );
        }
        else if ( var5 )
        {
            var0 scripts\mp\gametypes\br_public::ref_131a6( 1 );
        }
        
        var9 = var6 * 8;
        var10 = ( var8 & 255 ) << var9;
        var11 = ~( 255 << var9 );
        var12 = var4 & var11;
        var13 = var12 + var10;
        level.deletescriptableinstance[ var0.team ] = var13;
        var14 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
        
        if ( isdefined( var14 ) && var14.size > 0 )
        {
            foreach ( var16 in var14 )
            {
                var16 setclientomnvar( "ui_br_squad_revive_status", var13 );
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0xf5
function forest_barrel_damage_watch( var0 )
{
    var1 = [ 0, 0, 0, 0 ];
    
    if ( isdefined( var0 ) && isdefined( var0.ejectplayerfromturret ) )
    {
        var2 = 0;
        
        foreach ( var4 in var0.ejectplayerfromturret )
        {
            var5 = scripts\mp\gametypes\br_quest_util::getquesttableindex( var7 );
            var6 = int( clamp( var4, 0, 15 ) ) << 4;
            var1 = var6 + var5;
            var2++;
            
            if ( var2 >= 4 )
            {
                break;
            }
        }
    }
    
    var8 = [];
    GscBinSkip0( 0x2e, 0, ( var1[ 0 ] << 8 ) + var1[ 1 ] );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x117, Type: bool
function ref_12065()
{
    if ( !isdefined( self.sessionteam ) || self.sessionteam == "spectator" || self.sessionteam == "none" || isdefined( self.thrust_fx_model ) || self calloutmarkerping_getent() )
    {
        return false;
    }
    
    if ( scripts\mp\menus::shouldmodesetsquads() && !isdefined( self.squadindex ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() && !isbot( self ) )
    {
        self setclientomnvar( "ui_br_extended_load_screen", 1 );
        return false;
    }
    
    if ( !ref_14070() )
    {
        return true;
    }
    
    var0 = scripts\mp\gametypes\br_gametypes::ref_12e05( "onConnectSpawnPoint" );
    
    if ( !isdefined( var0 ) )
    {
        var0 = getspawnpoint();
    }
    
    self.thrust_fx_model = var0;
    var1 = scripts\mp\gametypes\br_gametypes::ref_12e05( "initialPrespawnZOffset" );
    
    if ( isdefined( var1 ) )
    {
        self.thrust_fx_model.origin += ( 0, 0, var1 );
    }
    
    if ( istrue( game[ "switchedsides" ] ) )
    {
        setomnvar( "ui_current_round", 1 );
    }
    
    self setclientomnvar( "ui_br_extended_load_screen", 1 );
    var2 = scripts\mp\gametypes\br_public::ref_126b8( var0.origin );
    spawnintermission( var2, var0.angles );
    var3 = getdvarint( "scr_br_initial_stream_timeout_ms", 15000 );
    scripts\mp\gametypes\br_public::ref_126b9( var2, var3, 1, 1 );
    return false;
}

// Params 0
// Size: 0x18, Type: bool
function ref_125f1()
{
    return self.sessionstate == "intermission" && isdefined( self.thrust_fx_model );
}

// Params 0
// Size: 0x23
function waittillmatch_wait()
{
    var0 = -1;
    
    if ( isdefined( self.lastdroppableweaponobj ) )
    {
        var0 = getaltbunkerindexforname( self.lastdroppableweaponobj );
    }
    
    self setclientomnvar( "ui_br_last_droppable_weapon", var0 );
}

// Params 1
// Size: 0x1c
function endgame_luidecisionreceived( var0 )
{
    var1 = scripts\mp\gametypes\br_gametypes::ref_12e05( "regenHealthAdd", var0 );
    
    if ( isdefined( var1 ) )
    {
        return var1;
    }
    
    return var0;
}

// Params 1
// Size: 0x1c
function endgame_finitewaves_vo( var0 )
{
    var1 = scripts\mp\gametypes\br_gametypes::ref_12e05( "regenDelaySpeed", var0 );
    
    if ( isdefined( var1 ) )
    {
        return var1;
    }
    
    return var0;
}

// Params 3
// Size: 0x1e
function elements_hidden( var0, var1, var2 )
{
    scripts\mp\gametypes\br_gametypes::ref_12e05( "addToTeamLives", var0, var1 );
    ref_1263f( var0, 1, var1, var2 );
}

// Params 3
// Size: 0x1d
function elevator_doors_open( var0, var1, var2 )
{
    scripts\mp\gametypes\br_gametypes::ref_12e05( "removeFromTeamLives", var0, var1 );
    ref_1263f( var0, 0, var1, var2 );
}

// Params 0
// Size: 0xf0
function ref_14006()
{
    level notify( "updatePlayerAndTeamCountUI" );
    level endon( "updatePlayerAndTeamCountUI" );
    waittillframeend();
    var0 = level.players.size;
    var1 = 0;
    var2 = 0;
    var3 = [];
    var4 = [];
    
    for ( var5 = 0; var5 < var0 ; var5++ )
    {
        var6 = level.players[ var5 ];
        
        if ( !istrue( var6.delay_enter_combat_after_investigating_grenade ) )
        {
            if ( istrue( var6.iszombie ) || istrue( var6.unset_relic_gun_game ) )
            {
                var2++;
            }
            else
            {
                var1++;
                var3 = 1;
                var4 = var6.team;
            }
        }
        
        if ( !scripts\engine\utility::array_contains_key( var3, var6.team ) )
        {
            var7 = scripts\mp\gametypes\br_gametypes::ref_12e05( "isTeamEliminated", var6.team );
            
            if ( isdefined( var7 ) )
            {
                if ( !var7 )
                {
                    var3 = 1;
                    var4 = var6.team;
                }
            }
        }
    }
    
    var9 = ( var2 << 16 ) + ( var3.size << 8 ) + var1;
    setomnvar( "ui_br_match_stats", var9 );
}

// Params 0
// Size: 0x5e4
function demo_debug_nuke()
{
    var0 = 0;
    level.teamswithplayers = [];
    var1 = 0;
    
    foreach ( var3 in level.teamnamelist )
    {
        var4 = scripts\mp\utility\teams::getteamdata( var3, "teamCount" );
        
        if ( var4 )
        {
            var0 += var4;
            var1++;
            level.teamswithplayers[ level.teamswithplayers.size ] = var3;
            
            if ( var1 > 1 )
            {
                break;
            }
        }
    }
    
    if ( scripts\mp\utility\game::matchmakinggame() && !level.ingraceperiod && ( !isdefined( level.disableforfeit ) || !level.disableforfeit ) && !scripts\mp\menus::brking_updateteamscore() )
    {
        if ( level.teambased )
        {
            if ( level.teamswithplayers.size == 1 && game[ "state" ] == "playing" )
            {
                thread scripts\mp\gamelogic::onforfeit( level.teamswithplayers[ 0 ] );
                return;
            }
            
            if ( level.teamswithplayers.size > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
        else
        {
            if ( var0 == 1 && level.maxplayercount > 1 )
            {
                thread scripts\mp\gamelogic::onforfeit();
                return;
            }
            
            if ( var0 > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( "abort_forfeit" );
            }
        }
    }
    
    if ( level.teamswithplayers.size == 1 && istrue( level.br_debugsolotest ) )
    {
        return;
    }
    
    if ( !scripts\mp\utility\game::getgametypenumlives() && ( !isdefined( level.disablespawning ) || !level.disablespawning ) )
    {
        return;
    }
    
    if ( !scripts\mp\utility\game::gamehasstarted() )
    {
        return;
    }
    
    if ( level.ingraceperiod && !isdefined( level.overrideingraceperiod ) )
    {
        return;
    }
    
    debugprintvipstates();
    debugthink();
    
    if ( level.teambased )
    {
        var6 = [];
        var7 = 0;
        var8 = 0;
        var9 = [];
        var10 = [];
        
        foreach ( var12 in level.teamnamelist )
        {
            var6 = 0;
            
            if ( !istrue( level.disablespawning ) )
            {
                foreach ( var14 in scripts\mp\utility\teams::getteamdata( var12, "players" ) )
                {
                    if ( !istrue( var14.hasspawned ) || var14.team == "spectator" || var14.team == "follower" || var14.team == "free" )
                    {
                        continue;
                    }
                    
                    if ( var14.pers[ "lives" ] )
                    {
                        var6 = var6[ var12 ] + var14.pers[ "lives" ];
                        var7 = 1;
                    }
                }
            }
            
            var16 = scripts\mp\utility\teams::getteamdata( var12, "aliveCount" );
            
            if ( !var8 && var16 > 0 )
            {
                var8 = 1;
            }
            
            var17 = 1;
            var18 = scripts\mp\gametypes\br_gametypes::ref_12e05( "isTeamEliminated", var12 );
            
            if ( isdefined( var18 ) )
            {
                if ( !var18 )
                {
                    var17 = 0;
                }
            }
            
            if ( var17 && scripts\mp\utility\teams::getteamdata( var12, "hasSpawned" ) && var16 <= 0 && !var6[ var12 ] && !scripts\mp\utility\teams::getteamdata( var12, "deathEvent" ) )
            {
                var9 = var12;
                continue;
            }
            
            if ( var16 == 2 && !scripts\mp\utility\teams::getteamdata( var12, "twoLeft" ) )
            {
                if ( scripts\mp\utility\game::round_vehicle_logic() != "brdov" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war" )
                {
                    var19 = scripts\mp\utility\teams::getteamdata( var12, "alivePlayers" );
                    var20 = scripts\engine\utility::random( var19 );
                    level thread scripts\mp\battlechatter_mp::trysaylocalsound( var20, "inform_last_two" );
                }
                
                scripts\mp\utility\teams::setteamdata( var12, "twoLeft", 1 );
                continue;
            }
            
            if ( var16 == 1 )
            {
                if ( gettime() > scripts\mp\utility\teams::getteamdata( var12, "oneLeftTime" ) + 5000 && !scripts\mp\utility\teams::getteamdata( var12, "oneLeft" ) )
                {
                    var21 = 0;
                    var19 = scripts\mp\utility\teams::getteamdata( var12, "players" );
                    
                    foreach ( var14 in var19 )
                    {
                        if ( !isalive( var14 ) )
                        {
                            var21 += var14.pers[ "lives" ];
                        }
                    }
                    
                    if ( var21 == 0 )
                    {
                        scripts\mp\utility\teams::setteamdata( var12, "oneLeftTime", gettime() );
                        scripts\mp\utility\teams::setteamdata( var12, "oneLeft", 1 );
                        
                        if ( var19.size > 1 )
                        {
                            [[ level.ononeleftevent ]]( var12 );
                        }
                    }
                }
                
                continue;
            }
            
            scripts\mp\utility\teams::setteamdata( var12, "oneLeft", 0 );
        }
        
        if ( !var8 && !var7 )
        {
            if ( istrue( level.postgameexfil ) && level.gameended )
            {
                level notify( "exfil_continue_game_end" );
            }
            
            if ( istrue( level.nukeincoming ) )
            {
                return;
            }
            
            return [[ level.ondeadevent ]]( "all" );
        }
        
        if ( istrue( level.postgameexfil ) && level.gameended )
        {
            level notify( "exfil_continue_game_end" );
        }
        
        if ( !istrue( level.skipondeadevent ) && !istrue( level.nukeincoming ) )
        {
            foreach ( var12 in var9 )
            {
                if ( level.multiteambased )
                {
                    scripts\mp\utility\teams::setteamdata( var12, "deathEvent", 1 );
                    [[ level.ondeadevent ]]( var12 );
                    continue;
                }
                
                return [[ level.ondeadevent ]]( var12 );
            }
        }
    }
    else
    {
        var6 = 0;
        
        foreach ( var14 in level.players )
        {
            if ( var14.team == "spectator" || var14.team == "follower" )
            {
                continue;
            }
            
            var6 += var14.pers[ "lives" ];
        }
        
        var29 = 0;
        
        foreach ( var12 in level.teamnamelist )
        {
            var29 += scripts\mp\utility\teams::getteamdata( var12, "aliveCount" );
        }
        
        if ( !var29 && !var6 )
        {
            if ( istrue( level.nukeincoming ) )
            {
                return;
            }
            
            return [[ level.ondeadevent ]]( "all" );
        }
        
        var32 = scripts\mp\utility\game::getpotentiallivingplayers();
        
        if ( var32.size == 1 )
        {
            return [[ level.ononeleftevent ]]( "all" );
        }
    }
    
    scripts\mp\gametypes\br_gametypes::ref_12e05( "postUpdateGameEvents" );
}

// Params 0
// Size: 0x17, Type: bool
function ref_11a5c()
{
    return istrue( level.ref_11a5d ) && getdvarint( "br_lowpop_allow_tweaks", 1 );
}

// Params 1
// Size: 0x26, Type: bool
function delay_loading_screen_omnvar( var0 )
{
    var1 = istrue( var0 ) && scripts\mp\gametypes\br_gulag::checkgulagusecount();
    return istrue( self.inlaststand ) && !istrue( self.shouldgetnewspawnpoint ) && !var1;
}

// Params 0
// Size: 0x1f3
function delay_delete_tv_station_boss_icon()
{
    var0 = [];
    var1 = [];
    var2 = isdefined( level.gulag ) && !istrue( level.gulag.shutdown );
    jumpiffalse(level.teambased) LOC_00000135;
    
    foreach ( var4 in level.teamnamelist )
    {
        var5 = 0;
        
        foreach ( var7 in level.teamdata[ var4 ][ "alivePlayers" ] )
        {
            if ( delay_loading_screen_omnvar( var7, var2 ) )
            {
                continue;
            }
            
            var5 = 1;
            break;
        }
        
        if ( var5 )
        {
            foreach ( var7 in level.teamdata[ var4 ][ "alivePlayers" ] )
            {
                if ( delay_loading_screen_omnvar( var7, var2 ) )
                {
                    continue;
                }
                
                var0 = var7;
            }
            
            continue;
        }
        
        foreach ( var7 in level.teamdata[ var4 ][ "alivePlayers" ] )
        {
            if ( delay_loading_screen_omnvar( var7, var2 ) )
            {
                var1 = var7;
            }
        }
    }
    
    goto LOC_0000017e;
}

// Params 0
// Size: 0x18b
function debugprintvipstates()
{
    if ( !getdvarint( "scr_br_laststandfinisher", 0 ) )
    {
        return;
    }
    
    if ( istrue( level.watch_for_flash_detonation ) )
    {
        return;
    }
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war" )
    {
        return;
    }
    
    var0 = isdefined( level.gulag ) && !istrue( level.gulag.shutdown );
    var1 = 0;
    var2 = 0;
    jumpiffalse(level.teambased) LOC_00000120;
    
    foreach ( var4 in level.teamnamelist )
    {
        var5 = 0;
        
        foreach ( var7 in level.teamdata[ var4 ][ "alivePlayers" ] )
        {
            if ( delay_loading_screen_omnvar( var7, var0 ) )
            {
                var2 = 1;
                continue;
            }
            
            var5 = 1;
            break;
        }
        
        if ( var5 )
        {
            var1++;
            
            if ( var1 > 1 )
            {
                return;
            }
        }
    }
    
    goto LOC_00000172;
}

// Params 2
// Size: 0x322
function debugthink( var0, var1 )
{
    if ( !istrue( level.delay_makeuseable ) )
    {
        return 0;
    }
    
    if ( istrue( scripts\mp\gametypes\br_public::tutorial_playsound() ) )
    {
        return 0;
    }
    
    if ( isdefined( level.start_escape_silo ) )
    {
        return 0;
    }
    
    level.start_escape_silo = 1;
    var2 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "ignoreZombiesLastStandWipe" );
    var3 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "ignoreGhostsLastStandWipe" );
    var4 = isdefined( level.gulag ) && !istrue( level.gulag.shutdown );
    var5 = [];
    var6 = 0;
    var7 = [];
    
    foreach ( var9 in level.teamnamelist )
    {
        var10 = 1;
        var5 = [];
        var11 = 0;
        var12 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic( var9 );
        
        for ( var13 = 0; var13 < var12.size ; var13++ )
        {
            var14 = var12[ var13 ];
            var15 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( var9, var14 );
            
            foreach ( var17 in var15 )
            {
                var18 = istrue( var4 ) && var17 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
                
                if ( var18 )
                {
                    continue;
                }
                
                if ( var2 && var17 scripts\mp\gametypes\br_public::ref_125f3() )
                {
                    continue;
                }
                
                if ( var3 && var17 scripts\mp\gametypes\br_public::ref_125ec() )
                {
                    continue;
                }
                
                if ( istrue( var1 ) && isdefined( var0 ) && var0 == var17 )
                {
                    var11 = 1;
                    continue;
                }
                
                var19 = istrue( var17.inlaststand ) || isdefined( var0 ) && var0 == var17;
                
                if ( var19 && !istrue( var17.shouldgetnewspawnpoint ) && !var17 scripts\mp\gametypes\br_public::ref_125f3() && !var17 scripts\mp\gametypes\br_public::ref_125ec() )
                {
                    var5 = var17;
                    continue;
                }
                
                var10 = 0;
                break;
            }
        }
        
        if ( var10 && ( var5.size > 0 || istrue( var1 ) && var11 ) )
        {
            var21 = [];
            
            foreach ( var17 in var5 )
            {
                if ( isdefined( self.watch_for_attack ) && !scripts\engine\utility::array_contains( var21, self.watch_for_attack ) )
                {
                    self.watch_for_attack.ref_145d0 = self.watch_for_player_enter_puddle_trigger;
                    var21 = self.watch_for_attack;
                }
                
                if ( isdefined( var0 ) && var0 == var17 )
                {
                    var6 = 1;
                }
                
                var17 notify( "squad_wipe_death" );
                var17.ref_13749 = 1;
                var17 scripts\mp\utility\damage::_suicide( 0 );
            }
            
            if ( istrue( var1 ) && isdefined( var0 ) && isdefined( var0.watch_for_attack ) && !scripts\engine\utility::array_contains( var21, var0.watch_for_attack ) )
            {
                if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "assignLastStandAttacker" ) )
                {
                    var0 scripts\mp\gametypes\br_gametypes::ref_12e05( "assignLastStandAttacker", var21 );
                }
                else
                {
                    var21 = var0.watch_for_attack;
                }
            }
            
            foreach ( var25 in var21 )
            {
                var25 thread scripts\mp\events::killeventtextpopup( "team_wiped", 0 );
                var25 thread scripts\mp\utility\points::giveunifiedpoints( "team_wiped", var25.ref_145d0 );
                var25.ref_145d0 = undefined;
                thread ref_13ad0( var25, var0, var25 );
                
                if ( !isdefined( var7[ var25.team ] ) )
                {
                    var7 = 1;
                    var25 playsoundtoteam( "ui_team_wipe_splash", var25.team );
                }
            }
        }
    }
    
    level.start_escape_silo = undefined;
    return var6;
}

// Params 3
// Size: 0x3a
function ref_13ad0( var0, var1, var2 )
{
    waitframe();
    
    if ( getdvarint( "scr_disable_br_teamwiped_message", 1 ) )
    {
        if ( isdefined( var0 ) )
        {
            obituary( var0, var1, var2, "MOD_TEAM_WIPED", scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( var1.team, var1.squadindex ) );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x1b, Type: bool
function disable_all_turrets_permanently( var0 )
{
    if ( disablebunker11cachelocations( var0 ) )
    {
        return false;
    }
    
    if ( isagent( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0xbf
function threat_sight_monitor( var0 )
{
    if ( var0 scripts\mp\utility\game::rankingenabled() && var0 hasplayerdata() )
    {
        var0 setplayerdata( "mp", "aarValue", 0, 0 );
        var0 setplayerdata( "mp", "aarValue", 1, 0 );
        var0 setplayerdata( "mp", "aarValue", 2, 0 );
        var0 setplayerdata( "mp", "aarValue", 3, 0 );
        var0 setplayerdata( "mp", "aarValue", 4, 0 );
        var0 setplayerdata( "mp", "aarValue", 5, 0 );
        var1 = var0 getplayerdata( "common", "mpProgression", "playerLevel", "xp" );
        var0 setplayerdata( "mp", "aarValue", 6, var1 );
        var0 setplayerdata( "mp", "aarValue", 7, var1 );
        return;
    }
}

// Params 1
// Size: 0x172
function ref_13120( var0 )
{
    var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    foreach ( var3 in var1 )
    {
        if ( !var3 scripts\mp\utility\game::rankingenabled() || !var3 hasplayerdata() )
        {
            continue;
        }
        
        var4 = var3.pers[ "combatXP" ];
        
        if ( !isdefined( var4 ) )
        {
            var4 = 0;
        }
        
        var3 setplayerdata( "mp", "aarValue", 0, var4 );
        var5 = var3.pers[ "missionXP" ];
        
        if ( !isdefined( var5 ) )
        {
            var5 = 0;
        }
        
        var3 setplayerdata( "mp", "aarValue", 1, var5 );
        var6 = var3.pers[ "lootingXP" ];
        
        if ( !isdefined( var6 ) )
        {
            var6 = 0;
        }
        
        var3 setplayerdata( "mp", "aarValue", 2, var6 );
        var7 = 0;
        
        if ( isdefined( var3.matchbonus ) )
        {
            var7 = int( var3.matchbonus );
        }
        
        var3 setplayerdata( "mp", "aarValue", 4, var7 );
        var8 = 0;
        
        if ( isdefined( var3.ref_12394 ) )
        {
            var8 = int( var3.ref_12394 );
        }
        
        var3 setplayerdata( "mp", "aarValue", 5, var8 );
        var9 = var3 getplayerdata( "mp", "aarValue", 6 );
        var10 = var9 + var3.pers[ "summary" ][ "xp" ];
        var3 setplayerdata( "mp", "aarValue", 7, var10 );
    }
}

// Params 2
// Size: 0x28, Type: bool
function disabledvehicles( var0, var1 )
{
    if ( isdefined( self.vehicle ) )
    {
        var2 = var0.streakname;
        
        if ( var2 == "manual_turret" )
        {
            return false;
        }
    }
    
    return true;
}

// Params 1
// Size: 0x4f
function display_hint_single( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    var1 = var0.owner;
    
    if ( !isdefined( var1 ) )
    {
        return 0;
    }
    
    if ( !istrue( var0.ref_133ce ) && !var1 scripts\mp\gametypes\br_pickups::make_chair_ai_spawner( var0 ) )
    {
        return 0;
    }
    
    var2 = scripts\mp\gametypes\br_gametypes::ref_12e05( "onKillstreakBeginUseFunc", var0 );
    
    if ( isdefined( var2 ) )
    {
        return var2;
    }
    
    return scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse( var0 );
}

// Params 1
// Size: 0x9, Type: bool
function elevator_init( var0 )
{
    return var0 == 1;
}

// Params 0
// Size: 0x47
function votes()
{
    var0 = self.currentprimaryweapon;
    
    if ( isdefined( var0 ) && isdefined( var0.basename ) && ( var0.basename == "iw8_spotter_scope_mp" || var0.basename == "iw8_spotter_scope_mp_ch3" ) )
    {
        self setweaponammoclip( var0, self getcurrentweaponclipammo() + 1 );
        return;
    }
}

// Params 1
// Size: 0x3a, Type: bool
function ending_viewing_players_setup( var0 )
{
    if ( !isdefined( var0.operatorcustomization ) || !isdefined( var0.operatorcustomization.voice ) || var0 scripts\mp\gametypes\br_public::ref_125f3() || var0 scripts\mp\gametypes\br_public::ref_125ec() )
    {
        return true;
    }
    
    return false;
}

// Params 3
// Size: 0xd7
function ending_fade_in( var0, var1, var2 )
{
    if ( isdefined( var0 ) && isdefined( var1 ) && isdefined( var2 ) )
    {
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_cursor_pos_override_x", var0 );
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_cursor_pos_override_y", var1 );
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_size_override", var2 );
        return;
    }
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_cursor_pos_override_x", level.br_circle.dangercircleent.origin[ 0 ] );
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_cursor_pos_override_y", level.br_circle.dangercircleent.origin[ 1 ] );
        _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_size_override", level.br_circle.dangercircleent.origin[ 2 ] );
        return;
    }
    
    _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_cursor_pos_override_x", 0 );
    _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_cursor_pos_override_y", 0 );
    _calloutmarkerping_handleluinotify_added::ref_13133( "ui_compass_tacopsmap_size_override", 0 );
}

// Params 0
// Size: 0xf8, Type: bool
function prematchperiod()
{
    if ( istrue( game[ "switchedsides" ] ) )
    {
        level.connectingplayers = getdvarint( "NKSQNMMRRQ" );
        
        if ( getdvarint( "scr_live_lobby", 0 ) == 1 && !istrue( level.ref_133e0 ) )
        {
            game[ "inLiveLobby" ] = 0;
            game[ "liveLobbyCompleted" ] = 1;
            level.allowprematchdamage = 1;
            
            if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "allowLateJoiners" ) )
            {
                setnojipscore( 1, 1 );
                setnojiptime( 1, 1 );
                level.nojip = 1;
            }
            
            level scripts\mp\gamelogic::livelobbymatchstarttimer( "match_starting_in", 15 );
            level notify( "start_prematch" );
            level.prematchperiod = 0;
        }
        else if ( !istrue( level.ref_133e0 ) )
        {
            level.allowprematchdamage = 1;
            level scripts\mp\gamelogic::livelobbymatchstarttimer( "match_starting_in", 15 );
        }
        
        if ( istrue( level.ref_133e0 ) )
        {
            while ( !level.players.size )
            {
                waitframe();
            }
        }
        
        level notify( "prematch_started" );
        physics_raycastents( scripts\mp\gamelogic::gettimeremaining(), 2 );
        level.prematchstarted = 1;
        level.prematchperiodend = 0;
        scripts\mp\gamelogic::matchstarttimerskip();
        physics_raycastents( scripts\mp\gamelogic::gettimeremaining(), 0 );
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x5e
function risk_flagspawncountchange()
{
    if ( isdefined( level.defend_main ) )
    {
        return level.defend_main;
    }
    
    var0 = [ "iw8_me_t9loadout", "iw8_me_t9mace", "iw8_me_t9etool", "iw8_me_t9machete", "iw8_me_t9mace", "iw8_me_t9bat", "iw8_me_t9sledgehammer", "iw8_me_t9sai", "iw8_me_t9battleaxe" ];
    var1 = randomint( var0.size );
    var2 = var0[ var1 ];
    level.defend_main = var2;
    return var2;
}

// Params 0
// Size: 0x3a
function risktokencount()
{
    if ( isdefined( level.delete_undeployed_subway_cars ) )
    {
        return level.delete_undeployed_subway_cars;
    }
    
    var0 = [ "s4_me_knife", "s4_me_katana", "s4_me_leiomano" ];
    var1 = randomint( var0.size );
    var2 = var0[ var1 ];
    level.delete_undeployed_subway_cars = var2;
    return var2;
}

// Params 0
// Size: 0x40
function riskspawn_initialset()
{
    if ( isdefined( level.demoforcesre ) )
    {
        return level.demoforcesre;
    }
    
    var0 = [ "s4_mg_bromeo37", "s4_mg_dpapa27", "s4_mg_mgolf42", "s4_mg_tyankee11" ];
    var1 = randomint( var0.size );
    var2 = var0[ var1 ];
    level.demoforcesre = var2;
    return var2;
}

// Params 0
// Size: 0x40
function risktokencountondeath()
{
    if ( isdefined( level.demotehvt ) )
    {
        return level.demotehvt;
    }
    
    var0 = [ "s4_sh_becho", "s4_sh_bromeo5", "s4_sh_lindia98", "s4_sh_mike97" ];
    var1 = randomint( var0.size );
    var2 = var0[ var1 ];
    level.demotehvt = var2;
    return var2;
}

// Params 0
// Size: 0xf
function ending_fade_out()
{
    var0 = getdvarint( "scr_br_recheckAFK", 0 );
    return var0;
}

// Params 2
// Size: 0x83
function guard_shack_mantle( var0, var1 )
{
    if ( !isdefined( var1.ref_125e4 ) )
    {
        return var0;
    }
    
    var2 = var0;
    var3 = ( gettime() - var1.ref_125e4 ) * 0.001;
    
    if ( var3 >= level.decoy_clearaithreatbiasgroup && var3 < level.decoy_giveassistpoint )
    {
        var2 *= level.decoy_aicanseeanyplayer;
        return var2;
    }
    
    if ( var3 >= level.decoy_giveassistpoint && var3 < level.decoy_delaystoptrackingassist )
    {
        var2 *= level.decoy_canseeplayer;
        return var2;
    }
    
    if ( var3 >= level.decoy_delaystoptrackingassist )
    {
        var2 *= level.decoy_aiseenplayerrecently;
        return var2;
    }
    
    return var2;
}

