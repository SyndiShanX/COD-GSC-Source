
// Params 0
// Size: 0x45f
function init()
{
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "randomizeCircleCenter" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "planeSnapToOOB" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "match_start_VO" );
    
    if ( getdvarint( "scr_br_zxp_disableHeli", 1 ) != 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "littleBirdSpawns" );
    }
    
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "planeUseCircleRadius" );
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "circleEarlyStart" );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerShouldRespawn", &ref_12691 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "createC130PathStruct", &init_relic_aggressive_melee );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "addToC130Infil", &being_hacked );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerSkipLootPickup", &ref_1269c );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerSkipKioskUse", &ref_1269b );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerKilled", &onplayerkilled );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "vipRespawnPlayer", &ref_142cc );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "circleTimerNext", &gulagisspawnpositionwithindangercircle );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "markPlayerAsEliminatedOnKilled", &ref_11b16 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerKilledSpawn", &ref_125f7 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "addToTeamLives", &addtoteamlives );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "removeFromTeamLives", &removefromteamlives );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerWelcomeSplashes", &ref_126f1 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "allowMeleeVehicleDamage", &brking_cleanupents );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerNakedDropLoadout", &ref_12604 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "dropOnPlayerDeath", &droponplayerdeath );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "shouldLastStandDamageScale", &ref_13308 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "dangerCircleTick", &dangercircletick );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "exfilStart", &onnewequipmentpickup );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onInfilSequenceEnd", &ref_14691 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onLeaveAC130", &ref_12051 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onJuggCrateUse", &ref_1472e );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "gulagWinnerRespawn", &gulagwinnerrespawn );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerConnect", &onplayerconnect );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "remainingPlayersAliveOnTeam", &scripts\mp\gametypes\br_alt_mode_zxp::ref_12bba );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "spawnHandled", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1365d );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "mayConsiderPlayerDead", &scripts\mp\gametypes\br_alt_mode_zxp::ref_11b80 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "modifyPlayerDamage", &scripts\mp\gametypes\br_alt_mode_zxp::modifyplayerdamage );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "modifyVehicleDamage", &scripts\mp\gametypes\br_alt_mode_zxp::ref_11ca1 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "ignoreVehicleExplosiveDamage", &scripts\mp\gametypes\br_alt_mode_zxp::standard_health );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "regenHealthAdd", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1264b );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "regenDelaySpeed", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1264a );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "postUpdateGameEvents", &scripts\mp\gametypes\br_alt_mode_zxp::ref_12810 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "lastStandAllowed", &scripts\mp\gametypes\br_alt_mode_zxp::watch_flight_collision );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "kioskRevivePlayer", &scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerDamaged", &scripts\mp\gametypes\br_alt_mode_zxp::onplayerdamaged );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "endGame", &scripts\mp\gametypes\br_alt_mode_zxp::spawnangle );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "isValidSpectateTarget", &scripts\mp\gametypes\br_alt_mode_zxp::vandalize_target_think );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "canTakePickupLoot", &scripts\mp\gametypes\br_alt_mode_zxp::get_chopper_minigun_start_node );
    level.disable_super_in_turret.ref_133d0 = getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 );
    level.disable_super_in_turret.ref_146c6 = 0;
    level.disable_super_in_turret.ref_11b76 = getdvarint( "scr_br_zxp_maxTagsVisible", 10 );
    level.disable_super_in_turret.ref_11b74 = getdvarfloat( "scr_br_zxp_maxRadius", 0 );
    level.disable_super_in_turret.ref_11b75 = level.disable_super_in_turret.ref_11b74 * level.disable_super_in_turret.ref_11b74;
    level.disable_super_in_turret.ref_13a25 = getdvarint( "scr_br_zxp_autoPickup", 1 );
    level.disable_super_in_turret.spawndomplates = getdvarint( "scr_br_zxp_human_powers", 0 );
    level.disable_super_in_turret.ref_146b2 = getdvarint( "scr_br_zxp_zombie_drop_tags", 1 );
    level.disable_super_in_turret.½s¦Pc’ºyÆ·
Xí$5£Ðœ = getdvarint( "scr_br_zxp_human_nb_syringe_drop_on_death", 2 );
    level.disable_super_in_turret.ref_11b5b = getdvarint( "scr_br_zxp_max_tags", 100 );
    level.disable_super_in_turret.spawndomplateflagtestmap = getdvarint( "scr_br_zxp_human_loadout_restore", 1 );
    level.disable_super_in_turret.showdogtagstohumans = getdvarint( "scr_br_zxp_show_tags_to_humans", 1 );
    level.disable_super_in_turret.ref_12cb0 = [];
    level.disable_super_in_turret.ref_12cb1 = [];
    level.disable_super_in_turret.respawnitems = [];
    level.disable_super_in_turret.©oº-•èKRÃÑëÚX8 × = getdvarint( "scr_br_zxp_zombieai_killed_loot_chance", 20 );
    level._effect[ "stim_pickup" ] = loadfx( "vfx/iw8_br/gameplay/zombie/vfx_zmb_stim_pickup" );
    game[ "dialog" ][ "zmb_opening" ] = "gametype_zombieroyale";
    game[ "dialog" ][ "zmb_infil_tutorial_01" ] = "zombie_game_start";
    game[ "dialog" ][ "zmb_infil_tutorial_02" ] = "zombie_close_gas_warning";
    game[ "dialog" ][ "zmb_teammate_back_human" ] = "zombie_teammate_back_human";
    level.br_infils_disabled = 0;
    thread initzombieais();
    thread toggleusbstickinhand();
}

// Params 0
// Size: 0x48
function toggleusbstickinhand()
{
    waittillframeend();
    
    if ( level.disable_super_in_turret.ref_133d0 )
    {
        thread gulagisfaded();
    }
    
    thread ref_13284();
    thread ref_13252();
    thread ref_13148();
    thread scripts\mp\gametypes\br_alt_mode_zxp::ref_1472d();
    scripts\mp\gametypes\br_pickups::ref_12b33( "brloot_zmb_stim", &lootsyringespawnedcallback );
    scripts\mp\gametypes\br_pickups::registerpickupremovedforspacecallback( &lootsyringefreedcallback );
}

// Params 0
// Size: 0x8a
function ref_126f1()
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    wait 1;
    
    if ( !istrue( game[ "liveLobbyCompleted" ] ) )
    {
        scripts\mp\hud_message::showsplash( "br_gametype_zxp_prematch_welcome" );
    }
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        self waittill( "br_jump" );
        
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
    
    if ( isalive( self ) && !scripts\mp\gametypes\br_public::ref_125f3() )
    {
        thread ref_125db();
    }
    
    wait 1;
    scripts\mp\hud_message::showsplash( "br_gametype_zxp_welcome" );
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "primary_objective", self, 0 );
}

// Params 1
// Size: 0x24
function onplayerconnect( var0 )
{
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    thread playerupdatetagobjectives();
}

// Params 0
// Size: 0x2f
function ref_13148()
{
    var0 = -15;
    var1 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player( 1 );
    var2 = max( 0, var1 + var0 );
    var3 = getdvarfloat( "scr_br_dropbag_delay", var2 );
    scripts\mp\gametypes\br_gametypes::ref_12b10( "dropBagDelay", var3 );
}

// Params 1
// Size: 0x21
function ref_14691( var0 )
{
    scripts\mp\gametypes\br_public::brleaderdialog( "zmb_opening", 0, var0 );
    wait 1;
    scripts\mp\gametypes\br_public::brleaderdialog( "zmb_infil_tutorial_01", 0, var0 );
}

// Params 0
// Size: 0x28
function ref_12051()
{
    self endon( "disconnect" );
    var0 = self;
    wait 3;
    
    while ( !var0 isonground() )
    {
        wait 2;
    }
    
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "zmb_infil_tutorial_02", var0 );
}

// Params 0
// Size: 0x7
function ref_11b16()
{
    return scripts\mp\gametypes\br_alt_mode_zxp::ref_11b16();
}

// Params 2
// Size: 0xd
function ref_125f7( var0, var1 )
{
    return scripts\mp\gametypes\br_alt_mode_zxp::ref_125f7( var0, var1 );
}

// Params 1
// Size: 0x15
function ref_12691( var0 )
{
    if ( !istrue( level.br_prematchstarted ) )
    {
        return 1;
    }
    
    return scripts\mp\gametypes\br_public::ref_125f3();
}

// Params 1
// Size: 0x4c
function ref_1269c( var0 )
{
    if ( istrue( level.disable_super_in_turret.zombiecanseeandopenloot ) )
    {
        if ( isdefined( var0.type ) && var0.type == "brloot_zmb_stim" )
        {
            return !scripts\mp\gametypes\br_public::ref_125f3();
        }
        
        return ( scripts\mp\gametypes\br_public::ref_125f3() && !scripts\mp\gametypes\br_pickups::islootcache( var0 ) );
    }
    
    return scripts\mp\gametypes\br_public::ref_125f3();
}

// Params 1
// Size: 0x9
function ref_1269b( var0 )
{
    return scripts\mp\gametypes\br_public::ref_125f3();
}

// Params 1
// Size: 0x5a, Type: bool
function ref_13308( var0 )
{
    var1 = isplayer( var0.attacker ) && var0.attacker scripts\mp\gametypes\br_public::ref_125f3();
    var2 = isplayer( var0.victim ) && var0.victim scripts\mp\gametypes\br_public::ref_125f3();
    
    if ( var1 && !var2 && var0.meansofdeath == "MOD_MELEE" )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x22
function brking_cleanupents( var0 )
{
    var1 = isplayer( var0.attacker ) && var0.attacker scripts\mp\gametypes\br_public::ref_125f3();
    return var1;
}

// Params 0
// Size: 0x102
function ref_12728()
{
    playfx( scripts\engine\utility::getfx( "zombie_trans" ), self.origin );
    self notify( "endSuperJumpFov" );
    ref_1272e( 0 );
    var0 = gettime() + 3000;
    
    while ( self isgestureplaying() && var0 > gettime() )
    {
        self stopgestureviewmodel();
        waitframe();
    }
    
    while ( var0 > gettime() && ( self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "isPlayerADS" ) ]]() ) )
    {
        waitframe();
    }
    
    self enableoffhandweapons();
    self giveandfireoffhand( "stim_zmb_mp" );
    wait 0.5;
    self lerpfovbypreset( "default_2seconds" );
    
    if ( level.disable_super_in_turret.ref_1470d )
    {
        thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
    }
    
    if ( level.disable_super_in_turret.ref_1470c )
    {
        scripts\mp\gametypes\br_alt_mode_zxp::ref_125da();
        
        if ( !level.disable_super_in_turret.ref_1470d )
        {
            self setscriptablepartstate( "headVFX", "neutral" );
        }
        
        scripts\mp\utility\player::restorebasevisionset( 2 );
    }
    
    wait 1.5;
}

// Params 1
// Size: 0x30
function ref_1272e( var0 )
{
    self allowfire( var0 );
    self allowmovement( var0 );
    self allowmelee( var0 );
    
    if ( var0 )
    {
        self playershow();
        self enableoffhandweapons();
        return;
    }
    
    self playerhide();
    self disableoffhandweapons();
}

// Params 1
// Size: 0x339
function ref_126fa( var0 )
{
    level endon( "game_ended" );
    
    if ( !istrue( var0 ) && !scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return;
    }
    
    var1 = self.origin;
    var2 = self.origin;
    var3 = self getplayerangles();
    var4 = 0;
    
    if ( level.disable_super_in_turret.spawndragonsbreathstruct )
    {
        var5 = ref_125dd();
        var2 = var5[ 0 ];
        var3 = var5[ 1 ];
        var1 = var5[ 2 ];
        var5 = undefined;
    }
    else
    {
        var6 = ref_125de();
        var2 = var6[ 0 ];
        var3 = var6[ 1 ];
        var4 = var6[ 2 ];
        var6 = undefined;
        var1 = var2;
    }
    
    ref_12728();
    var7 = scripts\mp\gametypes\br_public::ref_125f3() || istrue( self.ref_1443f );
    scripts\mp\gametypes\br_alt_mode_zxp::ref_12681( 0 );
    scripts\mp\gametypes\br_alt_mode_zxp::ref_12727( 0 );
    
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self method_87aa( "female" );
    }
    else
    {
        self method_87aa( "" );
    }
    
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.clothtype ) && self.operatorcustomization.clothtype != "" )
    {
        self setclothtype( self.operatorcustomization.clothtype );
    }
    else
    {
        self setclothtype( "vestlight" );
    }
    
    self.operatorcustomization = undefined;
    scripts\cp_mp\execution::_clearexecution();
    self.ref_12ca8 = 1;
    self.plotarmor = 1;
    self setscriptablepartstate( "zombie", "off" );
    self setscriptablepartstate( "compassicon", "defaulticon" );
    self setscriptablepartstate( "skydiveVfx", "default", 0 );
    
    if ( isdefined( self.team ) )
    {
        scripts\mp\gametypes\br_quest_util::lookforvehicles( self.team, self, 12, 1 );
    }
    
    if ( !var4 )
    {
        scripts\mp\gametypes\br_gulag::gulagfadetoblack();
        wait 1;
    }
    else
    {
        waitframe();
    }
    
    scripts\mp\gametypes\br::ref_13f21( self, "zombieRevived" );
    thread playerupdatetagobjectives();
    playerupdatedogtagsoutline();
    scripts\mp\gametypes\br_alt_mode_zxp::playerhumanhudoutlineenable();
    scripts\mp\class::loadout_emptycacheofloadout( "gamemode" );
    self.pers[ "gamemodeLoadout" ] = level.br_respawn_loadout;
    self.pers[ "class" ] = "gamemode";
    self.class = "gamemode";
    self.forcespawnangles = var3;
    self.forcespawnorigin = var1;
    scripts\mp\utility\player::_setsuit( "iw8_defaultsuit_mp" );
    scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    self skydive_deployparachute();
    thread scripts\mp\gametypes\br::defend_wave_2();
    ref_1272e( 1 );
    self enableexecutionvictim();
    
    if ( level.disable_super_in_turret.spawndragonsbreathstruct )
    {
        self.plotarmor = undefined;
        scripts\mp\gametypes\br_alt_mode_zxp::ref_126bd( var2, var3, var1 );
    }
    else
    {
        if ( !var4 )
        {
            scripts\mp\gametypes\br_public::ref_126ed();
            scripts\mp\gametypes\br_public::ref_1252b();
            playfx( scripts\engine\utility::getfx( "zombie_trans" ), self.origin );
        }
        
        if ( !var4 )
        {
            scripts\mp\gametypes\br_gulag::gulagfadefromblack();
        }
        
        thread ref_1252c();
    }
    
    if ( istrue( level.disable_super_in_turret.spawndomplateflagtestmap ) && scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa() )
    {
        ref_125fb();
    }
    else
    {
        var8 = scripts\mp\gametypes\br::disablealltablets();
        scripts\mp\gametypes\br::searchcircleorigin( var8, 0 );
    }
    
    scripts\mp\gametypes\br_armor::searchcirclesize();
    thread scripts\mp\gametypes\br::defend_wave_2();
    scripts\mp\gametypes\br_alt_mode_zxp::ref_1262b( 0 );
    
    if ( istrue( level.ref_133ef ) )
    {
        scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused( 1 );
    }
    
    if ( var7 )
    {
        scripts\mp\hud_message::showsplash( "br_gametype_zxp_change_human" );
    }
    
    self.plotarmor = undefined;
    thread ref_125d9();
    self.ref_12ca8 = undefined;
    
    if ( var7 )
    {
        foreach ( var10 in level.teamdata[ self.team ][ "players" ] )
        {
            if ( self != var10 )
            {
                scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "zmb_teammate_back_human", var10 );
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x3f
function ref_125dd()
{
    var0 = getdvarint( "scr_br_zxp_spawnheightoffset", 3000 );
    var1 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
    var2 = scripts\mp\gametypes\br_gulag::ref_125be( 0, var1, var0 );
    var3 = scripts\mp\gametypes\br_gulag::ref_1263e( var2 );
    return [ var2.origin, var2.angles, var3 ];
}

// Params 0
// Size: 0x2e
function ref_125de()
{
    var0 = ref_125d8();
    var1 = var0[ 0 ];
    var2 = var0[ 1 ];
    var3 = var0[ 2 ];
    var0 = undefined;
    
    if ( !var3 )
    {
        scripts\mp\gametypes\br_public::ref_126b9( var1 );
    }
    
    return [ var1, var2, var3 ];
}

// Params 0
// Size: 0xf9
function ref_125d8()
{
    var0 = 500;
    var1 = 10000;
    var2 = 5;
    
    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.dangercircleent ) )
    {
        return [ self.origin, self getplayerangles(), 1 ];
    }
    
    var3 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var4 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var5 = distance2dsquared( self.origin, var4 );
    
    if ( var5 <= var3 * var3 )
    {
        return [ self.origin, self getplayerangles(), 1 ];
    }
    
    var6 = undefined;
    var7 = undefined;
    var8 = ( self.origin[ 0 ], self.origin[ 1 ], 0 );
    var9 = vectornormalize( var8 - var4 );
    
    for ( var10 = 1; var10 <= var2 ; var10++ )
    {
        var11 = var3 - var0 * var10;
        
        if ( var11 < 0 )
        {
            break;
        }
        
        var12 = remove_marker_when_player_disconnects( var4, var9, var11 );
        var6 = var12[ 0 ];
        var7 = var12[ 1 ];
        var12 = undefined;
        
        if ( isdefined( var6 ) )
        {
            break;
        }
    }
    
    if ( !isdefined( var6 ) )
    {
        var6 = var4;
        var7 = self getplayerangles();
    }
    
    var13 = scripts\mp\gametypes\br_public::modifyplayer_damage( var6, var1 );
    return [ var13, var7, 0 ];
}

// Params 3
// Size: 0x38
function remove_marker_when_player_disconnects( var0, var1, var2 )
{
    var3 = var0 + var1 * var2;
    var4 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
    
    if ( scripts\mp\gametypes\br_gulag::set_relic_rocket_kill_ammo( var3, var4 ) )
    {
        var5 = vectortoangles( var1 * -1 );
        return [ var3, var5 ];
    }
    
    return [ undefined, undefined ];
}

// Params 0
// Size: 0x28
function ref_125d9()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_set" );
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    thread ref_125db();
}

// Params 0
// Size: 0x26a
function ref_125fb()
{
    self takeallweapons( 0, 1 );
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    self.equipment[ "primary" ] = undefined;
    self.equipment[ "secondary" ] = undefined;
    self.equipment[ "health" ] = undefined;
    self.equipment[ "super" ] = undefined;
    var0 = getcompleteweaponname( "iw8_fists_mp" );
    
    if ( self.ref_1472f.ref_12889.size < 2 )
    {
        self giveweapon( var0 );
    }
    
    var1 = 0;
    
    foreach ( var3 in self.ref_1472f.ref_12889 )
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
    
    foreach ( var7 in self.ref_1472f.offhands )
    {
        var8 = scripts\mp\equipment::getequipmentreffromweapon( var7 );
        
        if ( !isdefined( var8 ) )
        {
            continue;
        }
        
        var9 = self.ref_1472f.nvidiaansel_overridecollisionradius[ var8 ];
        
        if ( !isdefined( var9 ) )
        {
            continue;
        }
        
        scripts\mp\equipment::giveequipment( var8, var9 );
    }
    
    foreach ( var4, var12 in self.ref_1472f.brtruck_ontimelimit )
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
    
    foreach ( var4, var12 in self.ref_1472f.brtdm_config )
    {
        self setweaponammoclip( var4, var12 );
    }
    
    foreach ( var4, var12 in self.ref_1472f.brtruck_cleanupents )
    {
        self setweaponammoclip( var4, var12, "left" );
    }
    
    waitframe();
    var16 = var0;
    
    if ( isdefined( self.ref_1472f.current ) && self.ref_1472f.current != getcompleteweaponname( "none" ) )
    {
        var16 = self.ref_1472f.current;
    }
    
    self switchtoweaponimmediate( var16 );
    
    if ( isdefined( self.ref_1472f.super ) )
    {
        var17 = level.br_pickups.br_superreference[ level.br_pickups.br_equipnametoscriptable[ self.ref_1472f.super ] ];
        scripts\mp\gametypes\br_pickups::forcegivesuper( var17, 0 );
    }
    
    thread scripts\cp_mp\gestures::ref_13e1a();
    self.ref_1472f = undefined;
}

// Params 2
// Size: 0xe
function addtoteamlives( var0, var1 )
{
    var0 scripts\mp\gametypes\br_alt_mode_zxp::addtoteamlives( var0, var1 );
}

// Params 2
// Size: 0xe
function removefromteamlives( var0, var1 )
{
    var0 scripts\mp\gametypes\br_alt_mode_zxp::removefromteamlives( var0, var1 );
}

// Params 1
// Size: 0x24
function ref_1472e( var0 )
{
    if ( level.disable_super_in_turret.spawndomplateflagtestmap && !var0 scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa() )
    {
        var0 scripts\mp\gametypes\br_alt_mode_zxp::ref_125fc();
        return;
    }
}

// Params 1
// Size: 0x20
function gulagwinnerrespawn( var0 )
{
    if ( level.disable_super_in_turret.spawndomplateflagtestmap && scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa() )
    {
        ref_125fb();
        return;
    }
}

// Params 0
// Size: 0x3f
function ref_12702()
{
    self.itemsdropped = 0;
    var0 = level.disable_super_in_turret.ref_146c6 % 10;
    level.disable_super_in_turret.ref_146c6++;
    var1 = verifybunkercode( "zombie_death", var0 );
    
    if ( isdefined( var1 ) )
    {
        var2 = scripts\mp\gametypes\br_lootcache::ref_11a42( var1, 0 );
        return;
    }
}

// Params 0
// Size: 0x11
function ref_12604()
{
    if ( scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return;
    }
    
    scripts\mp\gametypes\br::ref_11e23();
}

// Params 1
// Size: 0x2d, Type: bool
function droponplayerdeath( var0 )
{
    if ( scripts\mp\gametypes\br_public::ref_125f3() || istrue( self.isjuggernaut ) )
    {
        return true;
    }
    
    if ( level.disable_super_in_turret.spawndomplateflagtestmap )
    {
        scripts\mp\gametypes\br_alt_mode_zxp::ref_125fc();
    }
    
    return false;
}

// Params 1
// Size: 0x10e
function onplayerkilled( var0 )
{
    if ( !istrue( level.br_prematchstarted ) )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    var1 = var0.victim;
    var2 = var0.attacker;
    
    if ( !isdefined( var2 ) || !isplayer( var2 ) || !isdefined( var1 ) )
    {
        return;
    }
    
    if ( ref_13302( var1, var2, var0.meansofdeath ) )
    {
        thread spawnhumanlootsyringes( var1, var1 );
    }
    
    if ( istrue( level.disable_super_in_turret.ref_146b2 ) && ref_1332e( var1, var2 ) )
    {
        thread spawnzombielootsyringes( var1, var1 );
    }
    
    if ( ref_13326( var1, var2 ) )
    {
        thread ref_12702();
    }
    
    if ( ref_13306( var2, var0 ) )
    {
        var2 thread scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "zxp_execution" );
        thread ref_126fa();
    }
    
    var3 = var0.hitloc;
    
    if ( isdefined( var3 ) && var1 scripts\mp\gametypes\br_public::ref_125f3() && ( var3 == "head" || var3 == "helmet" ) )
    {
        var4 = 0;
        var2 thread scripts\mp\damagefeedback::updatedamagefeedback( "hitzombieheadshot", var4, 1 );
    }
    
    if ( var1 scripts\mp\gametypes\br_public::ref_125f3() )
    {
        scripts\mp\gametypes\br_publicevents_meter::increasepubliceventmeter( 1 );
        scripts\mp\gametypes\br_publicevent_outbreak::manageoutbreakmeterdialog();
    }
    
    var1 setscriptablepartstate( "skydiveVfx", "default", 0 );
}

// Params 1
// Size: 0x6e, Type: bool
function ref_13306( var0 )
{
    if ( !level.disable_super_in_turret.zombierespawnonexecute )
    {
        return false;
    }
    
    if ( var0.meansofdeath != "MOD_EXECUTION" )
    {
        return false;
    }
    
    if ( var0.victim scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return false;
    }
    
    if ( !level.disable_super_in_turret.zombierespawnonlaststandexecute && istrue( var0.victim.inlaststand ) )
    {
        return false;
    }
    
    if ( !var0.attacker scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x84, Type: bool
function ref_13325( var0, var1 )
{
    if ( isdefined( var0 ) && var0 == self )
    {
        return istrue( var1 );
    }
    
    if ( level.teambased && isdefined( var0 ) && isdefined( var0.team ) && var0.team == self.team )
    {
        return false;
    }
    
    if ( isdefined( var0 ) && !isdefined( var0.team ) && ( var0.classname == "trigger_hurt" || var0.classname == "worldspawn" ) )
    {
        return false;
    }
    
    if ( isagent( self ) || isagent( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x1b, Type: bool
function ref_13326( var0 )
{
    if ( !ref_13325( var0 ) )
    {
        return false;
    }
    
    if ( !scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x4d, Type: bool
function ref_13302( var0, var1 )
{
    if ( !ref_13325( var0, 1 ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return false;
    }
    
    if ( var1 == "MOD_EXECUTION" && var0 scripts\mp\gametypes\br_public::ref_125f3() )
    {
        if ( !level.disable_super_in_turret.zombierespawnonlaststandexecute && !istrue( self.inlaststand ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 0
// Size: 0x4d
function resetdangercircleorigin()
{
    var0 = undefined;
    
    foreach ( var2 in level.disable_super_in_turret.ref_12cb0 )
    {
        if ( !isdefined( var0 ) || var2.lastusedtime < var0.lastusedtime )
        {
            var0 = var2;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x5a
function playerupdatedogtagsoutline()
{
    foreach ( var1 in level.disable_super_in_turret.ref_12cb0 )
    {
        if ( scripts\mp\gametypes\br_public::ref_125f3() )
        {
            var1.visuals[ 0 ] hudoutlineenableforclient( self, "outline_nodepth_stim" );
            continue;
        }
        
        var1.visuals[ 0 ] hudoutlinedisableforclient( self );
    }
}

// Params 0
// Size: 0x21f
function spawndogtags()
{
    var0 = 16;
    var1 = undefined;
    var2 = 0;
    var3 = undefined;
    
    if ( level.disable_super_in_turret.ref_12cb1.size > 0 )
    {
        var4 = level.disable_super_in_turret.ref_12cb1.size - 1;
        var1 = level.disable_super_in_turret.ref_12cb1[ var4 ];
        level.disable_super_in_turret.ref_12cb1[ var4 ] = undefined;
        loadoutprimaryaddblueprintattachments( var1 );
        var2 = 1;
        var3 = var1.trigger;
        var5 = var1.visuals;
    }
    else
    {
        jumpiffalse(level.disable_super_in_turret.ref_12cb0.size >= level.disable_super_in_turret.ref_11b5b) LOC_000000b4;
        var2 = resetdangercircleorigin();
        loadoutprimaryaddblueprintattachments( var2 );
        var3 = 1;
        var5 = var2.trigger;
        var5 = var2.visuals;
        goto LOC_00000158;
    }
    
LOC_00000158:
    foreach ( var8 in level.players )
    {
        if ( isdefined( var8 ) && var8 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            var5[ 0 ] hudoutlineenableforclient( var8, "outline_nodepth_stim" );
        }
    }
    
    var10 = "any";
    var11 = 0;
    var3 = scripts\mp\gameobjects::createuseobject( var10, var5, var5, ( 0, 0, var2 ), undefined, var5 );
    var3.ref_133e5 = 1;
    var3.onuse = &onuse;
    var3 scripts\mp\gameobjects::setusetime( var11 );
    var3 scripts\mp\gametypes\br_public::timeoutonabandonedcallback();
    var3.inuse = 1;
    var3.lastusedtime = gettime();
    var3.start_reach_wind_room = "e" + var3 getentitynumber();
    level.disable_super_in_turret.ref_12cb0[ var3.start_reach_wind_room ] = var3;
    return var3;
}

// Params 2
// Size: 0xce
function ref_13238( var0, var1 )
{
    var2 = scripts\mp\gametypes\br_public::modifyplayer_damage( var1, 30 );
    var3 = var2 + ( 0, 0, 24 );
    var0.curorigin = var3;
    
    if ( level.disable_super_in_turret.ref_13a25 )
    {
        var0.trigger.origin = var3;
    }
    
    var0.visuals[ 0 ].origin = var3;
    var0 scripts\mp\gameobjects::initializetagpathvariables();
    var0.interactteam = "any";
    ref_1337a( var0.visuals[ 0 ] );
    var0.ownerteam = "neutral";
    var0.trigger triggerenable();
    
    if ( isdefined( var0.objidnum ) )
    {
        if ( var0.objidnum != -1 )
        {
            setupstimobjectiveicon( var0, var2 );
        }
    }
    
    playsoundatpos( var3, "mp_killconfirm_tags_drop" );
    var0.visuals[ 0 ] scriptmodelplayanim( "mp_dogtag_spin" );
}

// Params 4
// Size: 0xbc
function spawnlootsyringe( var0, var1, var2, var3 )
{
    var4 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var5 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var4, var0, var1, var2, undefined, undefined, 0 );
    
    if ( isdefined( var2 ) && ( !isdefined( var5 ) || var5.origin == ( 0, 0, 0 ) ) )
    {
        var0 = var2.origin;
    }
    
    for ( var6 = 0; var6 < var3 ; var6++ )
    {
        var7 = var0;
        var8 = scripts\engine\utility::ter_op( var6 % 2 == 0, 1, -1 );
        var9 = int( var6 / 2 ) + 1;
        var10 = ( 5, 0, 0 ) * var9;
        var10 *= var8;
        var5.origin = var7 + var10;
        scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_zmb_stim", var5, 1, 1, undefined, level.disable_super_in_turret.ref_13a25 );
    }
}

// Params 0
// Size: 0x8
function lootsyringespawnedcallback()
{
    thread setuplootsyringe();
}

// Params 0
// Size: 0xe0
function setuplootsyringe()
{
    self.start_reach_wind_room = "s" + self.index;
    self.init_weapon_placements = 1;
    self.ownerteam = "neutral";
    
    for ( var0 = self getscriptablepartstate( "brloot_zmb_stim" ); var0 != "visible" && var0 != "delayauto" && var0 != "noauto" ; var0 = self getscriptablepartstate( "brloot_zmb_stim" ) )
    {
        waitframe();
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    var1 = scripts\mp\gametypes\br_public::modifyplayer_damage( self.origin, 30 );
    var2 = var1 + ( 0, 0, 24 );
    self.origin = var2;
    var3 = self method_87b9();
    
    if ( !var3 )
    {
        self.angles = ( 45, self.angles[ 1 ], self.angles[ 2 ] );
    }
    
    ref_1337a();
    self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    setupstimobjectiveicon( var1 );
    level.disable_super_in_turret.respawnitems[ self.start_reach_wind_room ] = self;
    playsoundatpos( self.origin, "mp_killconfirm_tags_drop" );
}

// Params 1
// Size: 0x95
function setupstimobjectiveicon( var0 )
{
    scripts\mp\objidpoolmanager::update_objective_state( self.objidnum, "active" );
    scripts\mp\objidpoolmanager::update_objective_position( self.objidnum, var0 + ( 0, 0, 24 ) );
    scripts\mp\objidpoolmanager::update_objective_setbackground( self.objidnum, 1 );
    scripts\mp\objidpoolmanager::objective_set_play_intro( self.objidnum, 0 );
    scripts\mp\objidpoolmanager::objective_set_play_outro( self.objidnum, 0 );
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_dogtags_friendly", "waypoint_dogtags" );
    scripts\mp\gameobjects::setvisibleteam( "any" );
    objective_icon( self.objidnum, "icon_minimap_syringe" );
    objective_setminimapiconsize( self.objidnum, "icon_regular" );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.objidnum );
}

// Params 0
// Size: 0x21
function lootsyringefreedcallback()
{
    if ( isdefined( self.type ) && self.type == "brloot_zmb_stim" )
    {
        removelootsyringe( self );
        return;
    }
}

// Params 2
// Size: 0x10c
function ref_13662( var0, var1 )
{
    if ( istrue( var0.isjuggernaut ) )
    {
        var2 = 2;
        var3 = getdvarint( "scr_br_zxp_numDropJugg", var2 );
        var4 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        
        for ( var5 = 1; var5 < var3 ; var5++ )
        {
            var6 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var4, var0.origin, var0.angles, var0, undefined, undefined, 0 );
            
            if ( !isdefined( var6 ) || var6.origin == ( 0, 0, 0 ) )
            {
                var6.origin = var0.origin;
            }
            
            var7 = spawndogtags();
            ref_13238( var7, var6.origin );
        }
        
        return;
    }
    
    for ( var5 = 0; var5 < level.disable_super_in_turret.½s¦Pc’ºyÆ·
Xí$5£Ðœ ; var5++ )
    {
        var8 = var5.origin;
        var9 = scripts\engine\utility::ter_op( var5 % 2 == 0, 1, -1 );
        var10 = int( var5 / 2 ) + 1;
        var11 = ( 5, 0, 0 ) * var10;
        var11 *= var9;
        var8 += var11;
        var7 = spawndogtags();
        ref_13238( var7, var8 );
    }
}

// Params 2
// Size: 0x44
function spawnhumanlootsyringes( var0, var1 )
{
    var2 = level.disable_super_in_turret.½s¦Pc’ºyÆ·
Xí$5£Ðœ;
    
    if ( istrue( var0.isjuggernaut ) )
    {
        var3 = 2;
        var2 = getdvarint( "scr_br_zxp_numDropJugg", var3 );
    }
    
    spawnlootsyringe( var0.origin, var0.angle, var0, var2 );
}

// Params 1
// Size: 0x27, Type: bool
function ref_1332e( var0 )
{
    if ( !ref_13325( var0, 1 ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::ref_125f3() && self.ref_11f39 > 0 )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x9c
function ref_136ba( var0, var1 )
{
    var2 = spawndogtags();
    ref_13238( var2, var0.origin );
    
    if ( self.ref_11f39 > 1 )
    {
        var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        
        for ( var4 = 1; var4 < self.ref_11f39 ; var4++ )
        {
            var5 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var3, var0.origin, var0.angles, var0, undefined, undefined, 0 );
            
            if ( !isdefined( var5 ) || var5.origin == ( 0, 0, 0 ) )
            {
                var5.origin = var0.origin;
            }
            
            var2 = spawndogtags();
            ref_13238( var2, var5.origin );
        }
        
        return;
    }
}

// Params 2
// Size: 0x1f
function spawnzombielootsyringes( var0, var1 )
{
    spawnlootsyringe( var0.origin, var0.angle, var0, self.ref_11f39 );
}

// Params 1
// Size: 0xac
function loadoutprimaryaddblueprintattachments( var0 )
{
    var0.visuals[ 0 ] hudoutlinedisable();
    var0.visuals[ 0 ] dontinterpolate();
    var0.visuals[ 0 ] hide();
    var0.trigger triggerdisable();
    var0.trigger notify( "deleted" );
    var0 scripts\mp\gameobjects::allowuse( "none" );
    var0.inuse = 0;
    var0.©D
³0Md(˜£ = undefined;
    var0.visuals[ 0 ].origin = ( 0, 0, 0 );
    var0.trigger.origin = ( 0, 0, 0 );
    headlessinfilplayers( var0 );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var0.objidnum );
}

// Params 2
// Size: 0x6f
function removetags( var0, var1 )
{
    if ( !isent( var0 ) )
    {
        removelootsyringe( var0, var1 );
        return;
    }
    
    loadoutprimaryaddblueprintattachments( var0 );
    level.disable_super_in_turret.ref_12cb0[ var0.start_reach_wind_room ] = undefined;
    level.disable_super_in_turret.ref_12cb1[ level.disable_super_in_turret.ref_12cb1.size ] = var0;
    playfx( level._effect[ "stim_pickup" ], var0.curorigin );
    playsoundatpos( var0.curorigin, "zmb_pickup_syringe" );
}

// Params 3
// Size: 0x65
function removelootsyringe( var0, var1, var2 )
{
    scripts\mp\objidpoolmanager::returnobjectiveid( var0.objidnum );
    level.disable_super_in_turret.respawnitems[ var0.start_reach_wind_room ] = undefined;
    playfx( level._effect[ "stim_pickup" ], var0.origin );
    
    if ( isdefined( var2 ) )
    {
        var2 playsoundtoplayer( "zmb_pickup_syringe", var2 );
        var2 thread scripts\mp\utility\points::giveunifiedpoints( "br_syringeLooted" );
    }
    
    if ( istrue( var1 ) )
    {
        var0 scripts\mp\gametypes\br_pickups::lastgoodjobplayer();
        return;
    }
}

// Params 1
// Size: 0x5d
function headlessinfilplayers( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( !var2 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            continue;
        }
        
        var3 = var2 getnodeoffset_code( 7 );
        
        if ( var3 != -1 && var3 == var0.objidnum )
        {
            var2 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 7 );
        }
    }
}

// Params 1
// Size: 0xa7
function ref_126e6( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.ref_12cb0 )
    {
        if ( isdefined( var2 ) && isdefined( var2.visuals[ 0 ] ) )
        {
            ref_12cb2( var2.visuals[ 0 ], self );
            respawntagusability( var2.visuals[ 0 ], self );
        }
    }
    
    foreach ( var5 in level.disable_super_in_turret.respawnitems )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        ref_12cb2( var5, self );
        respawntagusability( var5, self );
    }
}

// Params 1
// Size: 0x33
function ref_12cb2( var0 )
{
    if ( isent( self ) )
    {
        if ( istrue( level.disable_super_in_turret.showdogtagstohumans ) || var0 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            self showtoplayer( var0 );
            return;
        }
        
        self hidefromplayer( var0 );
        return;
    }
}

// Params 1
// Size: 0x40
function respawntagusability( var0 )
{
    if ( !isent( self ) )
    {
        self disablescriptableplayeruse( var0 );
        thread lootsyringeusability( var0 );
        return;
    }
    
    if ( !level.disable_super_in_turret.ref_13a25 )
    {
        if ( var0 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            self enableplayeruse( var0 );
            return;
        }
        
        self disableplayeruse( var0 );
        return;
    }
}

// Params 1
// Size: 0x43
function lootsyringeusability( var0 )
{
    for ( var1 = self getscriptablepartstate( "brloot_zmb_stim" ); var1 != "visible" && var1 != "noauto" ; var1 = self getscriptablepartstate( "brloot_zmb_stim" ) )
    {
        waitframe();
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    if ( isdefined( var0 ) )
    {
        self enablescriptableplayeruse( var0 );
        return;
    }
}

// Params 0
// Size: 0x77
function ref_1337a()
{
    if ( isent( self ) )
    {
        self hide();
        
        if ( !level.disable_super_in_turret.ref_13a25 )
        {
            self makeusable();
            self setcursorhint( "HINT_NOICON" );
            self sethintstring( &"MP_ZXP/PICKUP" );
            self setuseprioritymax();
        }
    }
    
    foreach ( var1 in level.players )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        ref_12cb2( var1 );
        respawntagusability( var1 );
    }
}

// Params 1
// Size: 0xb
function onuse( var0 )
{
    scripts\mp\gametypes\br_alt_mode_zxp::onuse( var0 );
}

// Params 0
// Size: 0x19b
function playerupdatetagobjectives()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    
    if ( !istrue( level.disable_super_in_turret.ref_146b2 ) )
    {
        return;
    }
    
    if ( !istrue( level.disable_super_in_turret.showdogtagstohumans ) && !scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return;
    }
    
    var0 = 0.5;
    
    for ( ;; )
    {
        var1 = self getnodeoffset_code( 7 );
        var2 = scripts\engine\utility::array_combine_non_integer_indices( level.disable_super_in_turret.ref_12cb0, level.disable_super_in_turret.respawnitems );
        var3 = [];
        
        foreach ( var5 in var2 )
        {
            if ( isdefined( var5 ) )
            {
                var3 = var5;
            }
        }
        
        var3 = scripts\engine\utility::array_sort_with_func( var3, &sortlocationsbydistance2d );
        var7 = 0;
        
        foreach ( var5 in var3 )
        {
            var9 = undefined;
            
            if ( var7 < level.disable_super_in_turret.ref_11b76 && level.disable_super_in_turret.ref_11b75 > 0 )
            {
                var9 = distance2dsquared( self.origin, var5.origin );
            }
            
            if ( var7 < level.disable_super_in_turret.ref_11b76 && ( level.disable_super_in_turret.ref_11b75 == 0 || var9 < level.disable_super_in_turret.ref_11b75 ) )
            {
                var7++;
                scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( var5.objidnum, self );
                continue;
            }
            
            var7 = level.disable_super_in_turret.ref_11b76;
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom( var5.objidnum, self );
            
            if ( var1 != -1 && var1 == var5.objidnum )
            {
                scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 7 );
            }
        }
        
        wait var0;
    }
}

// Params 0
// Size: 0x74
function ref_125ce()
{
    foreach ( var1 in level.disable_super_in_turret.ref_12cb0 )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( var1.objidnum, self );
    }
    
    foreach ( var4 in level.disable_super_in_turret.respawnitems )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( var4.objidnum, self );
    }
}

// Params 1
// Size: 0x3d
function gulagisspawnpositionwithindangercircle( var0 )
{
    if ( istrue( level.disable_super_in_turret.ref_146e7 ) )
    {
        if ( getdvarint( "scr_br_zxp_respawn_can_shutdown", 0 ) == 0 )
        {
            return;
        }
        
        var1 = scripts\mp\gametypes\br_gulag::remove_engineer_class();
        
        if ( var0 >= var1 )
        {
            level.disable_super_in_turret.ref_146e7 = 0;
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0xdd
function ref_13284()
{
    if ( istrue( level.br_circle_disabled ) )
    {
        return;
    }
    
    if ( getdvarint( "scr_br_zxp_respawn_can_shutdown", 0 ) == 0 )
    {
        return;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    var0 = "hudsmall";
    var1 = 0.8;
    var2 = -100;
    var3 = -290;
    var4 = 90;
    var5 = scripts\mp\gametypes\br_gulag::run_hud_logic();
    var6 = init_relic_trex( var0, var1 );
    var6 scripts\mp\hud_util::setpoint( "RIGHT", "CENTER", var3, var2 );
    var6.label = &"MP_ZXP/RESPAWN_ALLOWED";
    var7 = scripts\mp\hud_util::createservertimer( var0, var1 );
    var7 scripts\mp\hud_util::setpoint( "LEFT", "CENTER", var3, var2 );
    var7 settenthstimer( var5 );
    var8 = getdvarint( "scr_br_display_gulag_close_message", var4 );
    var9 = var5 - var8;
    
    if ( var9 > 0 )
    {
        wait var9;
        var7.color = ( 1, 0, 0 );
        var7 thread scripts\mp\gametypes\br_alt_mode_zxp::spawn_vindia_assault3();
        wait var8;
    }
    else
    {
        wait var5;
    }
    
    wait 2;
    var7 destroy();
    var6 destroy();
}

// Params 2
// Size: 0x1d
function ref_142cc( var0, var1 )
{
    if ( !isalive( self ) || scripts\mp\gametypes\br_public::ref_125f3() )
    {
        scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning( var0 );
        return;
    }
}

// Params 3
// Size: 0xac
function init_relic_trex( var0, var1, var2 )
{
    if ( isdefined( var2 ) )
    {
        var3 = newteamhudelem( var2 );
    }
    else
    {
        var3 = newhudelem();
    }
    
    var3.elemtype = "font";
    var3.font = var1;
    var3.fontscale = var2;
    var3.basefontscale = var2;
    var3.x = 0;
    var3.y = 0;
    var3.width = 0;
    var3.height = int( level.fontheight * var2 );
    var3.xoffset = 0;
    var3.yoffset = 0;
    var3.children = [];
    var3 scripts\mp\hud_util::setparent( level.uiparent );
    var3.hidden = 0;
    var3.alpha = 1;
    return var3;
}

// Params 0
// Size: 0x4e
function gulagisfaded()
{
    level.br_level.br_circledelaytimes[ 1 ] = level.br_level.br_circledelaytimes[ 0 ];
    level.br_level.br_circledelaytimes[ 0 ] = 1;
    level.br_level.br_circleclosetimes[ 0 ] = 1;
    level.br_level.default_player_connect_black_screen[ 0 ] = 1;
}

// Params 0
// Size: 0x5f
function init_relic_aggressive_melee()
{
    if ( level.disable_super_in_turret.ref_133d0 )
    {
        var0 = ( level.br_level.default_class_chosen[ 1 ][ 0 ], level.br_level.default_class_chosen[ 1 ][ 1 ], 0 );
        var1 = level.br_level.br_circleradii[ 1 ];
        var2 = scripts\mp\gametypes\br_c130::createtestc130path( var0, var1 );
    }
    else
    {
        var2 = scripts\mp\gametypes\br_c130::createtestc130path();
    }
    
    return var2;
}

// Params 0
// Size: 0x8
function being_hacked()
{
    thread vehomn_getleveldata();
}

// Params 0
// Size: 0x9e
function vehomn_getleveldata()
{
    level endon( "game_ended" );
    self endon( "death" );
    var0 = distance( self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor );
    var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
    wait var1;
    
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3 ) && isdefined( var3.br_infil_type ) && var3.br_infil_type == "c130" && !isdefined( var3.jumptype ) )
        {
            var3.jumptype = "outOfBounds";
            var3 notify( "halo_kick_c130" );
        }
    }
}

// Params 1
// Size: 0xbb
function onnewequipmentpickup( var0 )
{
    foreach ( var2 in level.players )
    {
        var2 hudoutlinedisable();
        
        if ( var2 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            var2 setscriptablepartstate( "compassicon", "defaulticon" );
            var2 unsetperk( "specialty_radarblip", 1 );
            
            if ( level.disable_super_in_turret.ref_1470c )
            {
                if ( !level.disable_super_in_turret.ref_1470d )
                {
                    var2 setscriptablepartstate( "headVFX", "neutral" );
                }
                
                var2 visionsetnakedforplayer( "", 0 );
            }
            
            if ( !isdefined( scripts\engine\utility::array_find( var0, var2 ) ) )
            {
                var2 playerhide();
                var2 setscriptablepartstate( "zombie", "off" );
                continue;
            }
            
            var2 setscriptablepartstate( "zombie", "exfil_nosmoke" );
        }
    }
}

// Params 0
// Size: 0x6b
function ref_13252()
{
    if ( !istrue( level.disable_super_in_turret.spawndomplates ) )
    {
        return;
    }
    
    level.disable_super_in_turret.human = spawnstruct();
    level.disable_super_in_turret.human.powers = [];
    scripts\mp\gametypes\br_alt_mode_zxp::battlepassxpmultipliers( level.disable_super_in_turret.human, "push", [ "+stance", "+movedown" ], &ref_125d5, 1, undefined, &ref_125d6, undefined, &"MP_ZXP/PUSH", undefined, 60 );
}

// Params 0
// Size: 0x23
function ref_125db()
{
    if ( !istrue( level.disable_super_in_turret.spawndomplates ) )
    {
        return;
    }
    
    thread scripts\mp\gametypes\br_alt_mode_zxp::ref_126b4( level.disable_super_in_turret.human );
}

// Params 2
// Size: 0x62
function ref_125d5( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_set" );
    var2 = 750;
    
    if ( istrue( self.hoopty_truck_initomnvars ) )
    {
        var3 = getdvarint( "scr_br_zxp_push_double_tap_ms", var2 );
        var4 = gettime() - self.hoopty_truck_initomnvars;
        
        if ( var4 <= var3 )
        {
            ref_1252c();
            thread scripts\mp\gametypes\br_alt_mode_zxp::ref_1262c( var0, var1 );
            self.hoopty_truck_initomnvars = undefined;
            return;
        }
    }
    
    self.hoopty_truck_initomnvars = gettime();
}

// Params 0
// Size: 0xc8
function ref_1252c()
{
    if ( !getdvarint( "scr_br_zxp_human_spawn_concuss", 0 ) )
    {
        return;
    }
    
    var0 = 650;
    var1 = getdvarint( "scr_br_zxp_push_radius", var0 );
    var2 = incrementpersistentstat( level.players, self.origin, var1 );
    
    foreach ( var4 in var2 )
    {
        if ( var4 scripts\mp\gametypes\br_public::ref_125f3() && var4.team != self.team && isalive( var4 ) )
        {
            scripts\mp\gametypes\br_alt_mode_zxp::ref_125d7( var4, var1 );
        }
    }
    
    var6 = anglestoforward( self.angles );
    playfx( level.disable_super_in_turret.start_coop_defuse_infiltrate, self.origin, var6 );
    playsoundatpos( self.origin, "sentry_explode_smoke" );
    playrumbleonposition( "grenade_rumble", self.origin );
    earthquake( 0.5, 1.5, self.origin, var1 );
}

// Params 2
// Size: 0xb
function ref_125d6( var0, var1 )
{
    self.hoopty_truck_initomnvars = undefined;
}

// Params 2
// Size: 0x51
function ref_11ba8( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = var0.meansofdeath;
    }
    
    var2 = var0.victim;
    var3 = var0.hitloc;
    
    if ( isplayer( var2 ) && var2 scripts\mp\gametypes\br_public::ref_125f3() && ( var3 == "head" || var3 == "helmet" ) )
    {
        var1 = "MOD_HEAD_SHOT_ZOMBIE";
    }
    
    return var1;
}

// Params 2
// Size: 0xa7
function dangercircletick( var0, var1 )
{
    var2 = var1 * var1;
    
    foreach ( var4 in level.disable_super_in_turret.ref_12cb0 )
    {
        if ( isdefined( var4.visuals ) && distance2dsquared( var4.origin, var0 ) > var2 )
        {
            removetags( var4 );
        }
    }
    
    foreach ( var7 in level.disable_super_in_turret.respawnitems )
    {
        if ( !isdefined( var7 ) )
        {
            continue;
        }
        
        if ( distance2dsquared( var7.origin, var0 ) > var2 )
        {
            removelootsyringe( var7, 1 );
        }
    }
}

// Params 0
// Size: 0x56
function initzombieais()
{
    if ( getdvarint( "scr_br_zxp_pvpve_enabled", 1 ) <= 0 )
    {
        return;
    }
    
    _testing_ending::teamplunderexfiltimer();
    access_card::initzombievariables();
    level.ref_13304 = &zai_ignoreent;
    level.¶pOÞ­Ä¥¬,Ñ:…6­n4Ûº†¥GlÆØ¶ = &zai_zombieattackshouldhitcallback;
    level.agent_funcs[ "zombie" ][ "gametype_on_damaged" ] = &zai_gametypeondamaged;
    waitframe();
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    waitframe();
    zai_populatepoi();
}

// Params 0
// Size: 0x377
function zai_populatepoi()
{
    if ( level.mapname == "mp_escape4" )
    {
        zai_tryspawnzombie( ( 530, -7486, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 502, -7420, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 448, -7455, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 461, -7368, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 407, -7495, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 398, -7374, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 361, -7427, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 317, -7462, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 329, -7370, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 578, -7409, 100 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2450, -2915, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2501, -2864, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2448, -2827, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2534, -2806, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2396, -2804, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2505, -2750, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2442, -2736, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2483, -2685, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2393, -2708, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( 2540, -2930, 50 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3375, 4404, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3420, 4459, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3478, 4375, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3485, 4432, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3474, 4498, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3543, 4399, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3532, 4496, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3584, 4454, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3586, 4368, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        zai_tryspawnzombie( ( -3350, 4491, -17 ), ( 0, randomintrange( 0, 360 ), 0 ) );
        return;
    }
}

// Params 2
// Size: 0x42
function zai_tryspawnzombie( var0, var1 )
{
    var2 = _testing_ending::spawnnewzombieagent( var0, var1, 0, "enemy_lw_zombie_default", level.ref_1469d );
    
    if ( isdefined( var2 ) )
    {
        var2.entered_playspace = 1;
        var2.intelused = &zai_ondeathcallback;
        var2 accesscard::ref_13173( "sprint" );
    }
    
    return var2;
}

// Params 1
// Size: 0x12, Type: bool
function zai_ignoreent( var0 )
{
    if ( var0 scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x11
function zai_zombieattackshouldhitcallback( var0 )
{
    if ( var0 scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return 0;
    }
    
    return undefined;
}

// Params 12
// Size: 0x1d
function zai_gametypeondamaged( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 )
{
    if ( var1 scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return 0;
    }
    
    return undefined;
}

// Params 9
// Size: 0x26
function zai_ondeathcallback( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( randomint( 100 ) <= level.disable_super_in_turret.©oº-•èKRÃÑëÚX8 × )
    {
        ref_12702();
        return;
    }
}

// Params 2
// Size: 0x25, Type: bool
function sortlocationsbydistance2d( var0, var1 )
{
    return distance2dsquared( var0.origin, self.origin ) < distance2dsquared( var1.origin, self.origin );
}

