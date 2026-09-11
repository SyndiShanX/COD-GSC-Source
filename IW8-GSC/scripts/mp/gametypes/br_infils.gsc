
// Params 0
// Size: 0x9d
function main()
{
    level.brlatespawnplayer = &latespawnplayer;
    level.stop_wave = ref_1300f();
    setdvarifuninitialized( "br_infil_anim_enable_third_camera", 1 );
    setdvarifuninitialized( "br_infil_play_jump_anims", 1 );
    setdvarifuninitialized( "br_infil_bot_jumpmaster", 0 );
    level.infilselectionmethod = "";
    level.infilcanusemap = 0;
    
    if ( istrue( getdvarint( "br_spawnSelectionInfil", 0 ) ) )
    {
        level.infilselectionmethod = getdvar( "scr_br_infilselectionmethod", "exclusion" );
        level.infilcanusemap = 1;
        level.get_bomb_interaction_ent_cut_hint = getdvarint( "scr_br_canSoloJump", 1 );
    }
    
    if ( istrue( level.br_infils_disabled ) && scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        thread laser_vfx_think( level, undefined );
    }
    
    initspawnexclusionpois();
    initinfillocationselectionhandlers();
}

// Params 0
// Size: 0xa6
function ref_1300f()
{
    var0 = 2;
    var1 = getdvarint( "scr_br_infilType", var0 );
    
    if ( var1 == 1 )
    {
        if ( level.mapname != "mp_don4" && level.mapname != "mp_don4_pm" && level.mapname != "mp_br_mechanics" && !scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent() )
        {
            var1 = 2;
        }
    }
    else if ( var1 == 2 )
    {
        if ( level.mapname == "mp_don4" || scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent() )
        {
            var1 = 1;
        }
        else if ( level.mapname != "mp_wz_island" && level.mapname != "mp_br_mechanics" )
        {
            var1 = 0;
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x4d
function remove_munition_on_use()
{
    var0 = undefined;
    var1 = undefined;
    
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        var0 = 0;
        var1 = 0;
    }
    else if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        var0 = 0.45;
        var1 = 0.6;
    }
    else
    {
        var0 = 3.45;
        var1 = 0.6;
    }
    
    return [ var0, var1 ];
}

// Params 0
// Size: 0x1d
function setplayerprematchallows()
{
    scripts\mp\utility\player::enableplayerforspawnlogic( 0 );
    self allowmelee( 0 );
    self disableoffhandweapons();
    level.freefallstartcb = &freefallstartfunc;
}

// Params 0
// Size: 0x14
function freefallstartfunc()
{
    self allowmelee( 1 );
    self enableoffhandweapons();
    thread scripts\cp_mp\parachute::ref_126cb();
}

// Params 0
// Size: 0x5e
function stop_player_trigger_monitor()
{
    self endon( "disconnect" );
    
    if ( self.class == "" )
    {
        self.class = "custom1";
        self.pers[ "class" ] = "custom1";
    }
    
    scripts\mp\playerlogic::spawnplayer( 0 );
    self.br_infilstarted = 1;
    self notify( "brWaitAndSpawnClientComplete" );
    self setclientomnvar( "ui_br_transition_type", 0 );
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
}

// Params 3
// Size: 0x1de
function ref_1435f( var0, var1, var2 )
{
    var3 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        neurotoxin_damage_loop( var5 );
        var5 setmlgdamagedone();
        
        if ( !istrue( level.br_infils_disabled ) )
        {
            var5 scripts\mp\gametypes\br::ref_1254d();
        }
        
        if ( !isalive( var5 ) && !istrue( var5.waitingtospawnamortize ) )
        {
            if ( isdefined( var1 ) )
            {
                var5.forcespawnorigin = var1;
            }
            
            stop_player_trigger_monitor( var5 );
        }
        else
        {
            var5.br_infilstarted = 1;
            
            if ( isdefined( var1 ) )
            {
                var5 setorigin( var1 );
            }
        }
        
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        if ( isdefined( var2 ) )
        {
            var5 playerlinkto( var2 );
        }
        
        if ( istrue( var5.delay_enter_combat_after_investigating_grenade ) )
        {
            scripts\mp\gametypes\br::ref_13f21( var5, "waitAndForceSpawnAllPlayers" );
        }
        
        var5 notify( "beginC130" );
    }
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "squadLeader" ) )
    {
        if ( level.teambased )
        {
            foreach ( var8 in level.teamnamelist )
            {
                var9 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic( var8 );
                
                for ( var10 = 0; var10 < var9.size ; var10++ )
                {
                    var11 = var9[ var10 ];
                    var12 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var8, var11 );
                    var13 = ref_1322c( var12 );
                    
                    if ( isdefined( var13 ) )
                    {
                        ref_12b12( var13 );
                        thread ref_14494( var13, var8 );
                    }
                    
                    scripts\mp\gametypes\br::ref_1401e( var8, var11 );
                }
            }
        }
        else
        {
            var3 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
            
            foreach ( var5 in var3 )
            {
                if ( isdefined( var5 ) )
                {
                    ref_12b12( var5 );
                }
            }
        }
    }
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) )
    {
        level.disablespawning = 1;
        setdynamicdvar( "scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1 );
    }
    
    level.snatchspawnalltoc130done = 1;
}

// Params 0
// Size: 0x2d
function neurotoxin_damage_loop()
{
    var0 = self;
    var0 skydive_setdeploymentstatus( 0 );
    var0 skydive_setbasejumpingstatus( 0 );
    
    if ( isdefined( var0.play_disguise_vo ) )
    {
        var0.play_disguise_vo = 5;
    }
    
    var0 scripts\cp_mp\parachute::ref_121ca();
}

// Params 1
// Size: 0x46
function ref_12b12( var0 )
{
    if ( !istrue( var0.vehicle_occupancy_monitorcontrols ) )
    {
        var0.vehicle_occupancy_monitorcontrols = 1;
        var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", 2 );
        var0 notifyonplayercommand( "halo_jump_c130", "+gostand" );
        var0 notifyonplayercommand( "br_break_squad", "+breath_sprint" );
        return;
    }
}

// Params 2
// Size: 0x3c
function ref_14494( var0, var1 )
{
    scripts\engine\utility::ref_143a5( "death", "disconnect" );
    var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0, var1 );
    var3 = ref_1322c( var2 );
    
    if ( isdefined( var3 ) )
    {
        ref_12b12( var3 );
        thread ref_14494( var3, var0 );
        return;
    }
}

// Params 0
// Size: 0x65
function performfailsafeinfil()
{
    var0 = ( 0, 0, 3000 );
    
    if ( isdefined( level.prematchspawnorigins ) && level.prematchspawnorigins.size > 0 )
    {
        var1 = scripts\engine\utility::random( level.prematchspawnorigins );
        var0 = var1.origin;
    }
    
    var2 = ( 0, randomintrange( 0, 360 ), 0 );
    self setorigin( var0, 1 );
    self setplayerangles( var2 );
    wait 0.2;
    thread scripts\cp_mp\parachute::startfreefall( 0, 1 );
}

// Params 0
// Size: 0x101
function latespawnplayer()
{
    self endon( "disconnect" );
    var0 = self;
    var1 = scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid();
    
    if ( getdvar( "scr_br_lateSpawnFallback" ) != "" || var1 )
    {
        ref_11fcc();
    }
    else if ( !isalive( var0 ) )
    {
        if ( !istrue( level.debugnextpropindex ) )
        {
            var2 = isbot( var0 ) && scripts\mp\gametypes\br_public::tutorial_playsound();
            
            while ( !istrue( level.delay_music_reinforcements ) && !var2 )
            {
                if ( !var2 )
                {
                    var0 scripts\mp\gametypes\br::ending_fade_in();
                    var0 setclientomnvar( "ui_br_transition_type", 4 );
                }
                
                wait 0.3;
            }
            
            thread watch_for_usb_notetrack();
        }
        else
        {
            var0.delay_explosion_fx = 0;
            var0.br_infilstarted = 1;
            
            if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "squadLeader" ) )
            {
                var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
                
                if ( !isdefined( var3 ) || var3.size == 0 )
                {
                    var3 = [ self ];
                }
                
                ref_1322c( var3 );
            }
            
            thread ref_11c49();
        }
    }
    
    var0 setclientomnvar( "ui_br_transition_type", 0 );
    var0 setclientomnvar( "ui_br_extended_load_screen", 0 );
}

// Params 0
// Size: 0x225
function watch_for_usb_notetrack()
{
    var0 = self;
    var0 endon( "disconnect" );
    
    if ( !isalive( var0 ) )
    {
        var0.watch_for_usb_notetrack_switchoff = 1;
        var0 scripts\mp\playerlogic::spawnplayer( 0 );
    }
    
    var0 playerhide();
    var0.watch_for_usb_notetrack_switchoff = undefined;
    var0 freezecontrols( 1 );
    var1 = 1;
    
    if ( isdefined( var0.team ) && isdefined( var0.squadindex ) )
    {
        var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
        var1 = var2.size == 1;
    }
    
    var0.stop_counter_beep_sfx_on_bomb_vests = var1;
    
    if ( var0 scripts\mp\gametypes\br_public::updatedragonsbreath() )
    {
        var0.infilanimindex = 1;
    }
    
    if ( !isdefined( var0.infilanimindex ) && level.teambased )
    {
        var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
        var3 = fivecontracts( var2.size );
        
        for ( var4 = 0; var4 < var3.size ; var4++ )
        {
            var5 = 0;
            
            foreach ( var7 in var2 )
            {
                if ( var7 != var0 && var7 scripts\mp\gametypes\br_public::updatedragonsbreath() )
                {
                    continue;
                }
                
                if ( isdefined( var7.infilanimindex ) && isdefined( var3[ var4 ] ) && var7.infilanimindex == var3[ var4 ] )
                {
                    var5 = 1;
                    break;
                }
            }
            
            if ( !var5 )
            {
                var0.infilanimindex = var3[ var4 ];
                break;
            }
        }
    }
    
    playerjoininfil( var0 );
    playerlinktopositionent( var0, level.watch_for_total_counts_below_num );
    scripts\mp\utility\game::ref_131a3( var0, 1 );
    var9 = remove_objective_on_flag( level.watch_for_total_counts_below_num );
    var0 setorigin( var9.origin );
    playerplayinfilloopanim( var0, level.watch_for_total_counts_below_num );
    waitframe();
    var10 = 0;
    
    if ( !var10 )
    {
        if ( isdefined( var0.team ) && level.teambased )
        {
            var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
            
            foreach ( var12 in var2 )
            {
                var0 showtoplayer( var12 );
                var12 showtoplayer( var0 );
            }
        }
    }
    
    if ( !isbot( var0 ) )
    {
        scripts\mp\gametypes\br_public::orbitcam( level.br_ac130 );
    }
    
    wait 0.5;
    var0 freezecontrols( 0 );
    var0 setclientomnvar( "ui_br_transition_type", 0 );
    var0.br_infilstarted = 1;
}

// Params 1
// Size: 0x23
function fivecontracts( var0 )
{
    var1 = [];
    
    for ( var2 = 0; var2 < var0 - 1 ; var2++ )
    {
        var1 = var2 + 2;
    }
    
    return var1;
}

// Params 0
// Size: 0x34
function ref_11c49()
{
    var0 = self;
    var0.br_infilstarted = 1;
    var0 scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
    var0 scripts\mp\gametypes\br_gulag::playergulagautowin( "missedInfilPlayerHandler", undefined, undefined, 1 );
    var0 scripts\mp\playerlogic::addtoalivecount( "spawnPlayer" );
}

// Params 0
// Size: 0x95
function ref_11fcc()
{
    self endon( "disconnect" );
    var0 = self;
    
    if ( !isalive( var0 ) )
    {
        var0 scripts\mp\playerlogic::spawnplayer( 0 );
    }
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "squadLeader" ) )
    {
        if ( level.teambased )
        {
            var1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
            
            if ( !isdefined( var1 ) || var1.size == 0 )
            {
                var1 = [ self ];
            }
            
            var2 = ref_1322c( var1 );
            
            if ( isdefined( var2 ) )
            {
                ref_12b12( var2 );
            }
        }
        else
        {
            var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", 2 );
            ref_12b12( var0 );
        }
    }
    
    var0.br_infilstarted = 1;
}

// Params 1
// Size: 0x127
function takeloadoutatinfilend( var0 )
{
    self takeweapon( self.weaponlist[ 0 ] );
    var1 = getcompleteweaponname( "ks_remote_map_snatch" );
    var2 = self getweaponslistall();
    
    foreach ( var4 in var2 )
    {
        if ( scripts\mp\utility\weapon::isgesture( var4 ) )
        {
            continue;
        }
        
        if ( isnullweapon( var1, var4 ) )
        {
            continue;
        }
        
        scripts\cp_mp\utility\inventory_utility::_takeweapon( var4 );
    }
    
    self.primaryweaponobj = undefined;
    self.primaryweapon = "none";
    self.pers[ "primaryWeapon" ] = self.primaryweapon;
    self.secondaryweaponobj = undefined;
    self.secondaryweapon = "none";
    self.pers[ "secondaryWeapon" ] = self.secondaryweapon;
    
    if ( !istrue( var0 ) )
    {
        var6 = getforcedloadoutweapon();
        scripts\cp_mp\utility\inventory_utility::_giveweapon( var6, 1 );
        thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var6 );
        self setspawnweapon( var6, 1 );
        
        if ( level.magcount == 0 )
        {
            self setweaponammoclip( var6, 0 );
            self setweaponammostock( var6, 0 );
        }
        else
        {
            self setweaponammoclip( var6, weaponclipsize( var6 ) );
            self setweaponammostock( var6, weaponclipsize( var6 ) * ( level.magcount - 1 ) );
        }
        
        self.secondaryweaponobj = var6;
        self.secondaryweapon = createheadicon( self.secondaryweaponobj );
        self.pers[ "secondaryWeapon" ] = self.secondaryweapon;
        return;
    }
}

// Params 0
// Size: 0x3e
function getforcedloadoutweapon()
{
    return scripts\mp\class::buildweapon( "iw8_pi_golf21", [ "reflex", "none", "none", "none", "none" ], "none", "none", -1, undefined, undefined, undefined, undefined, undefined, 0 );
}

// Params 1
// Size: 0x167
function ref_1322c( var0 )
{
    if ( var0.size == 0 )
    {
        return undefined;
    }
    
    var1 = undefined;
    
    foreach ( var3 in var0 )
    {
        if ( isdefined( var3 ) && var3 scripts\mp\gametypes\br_public::updatedragonsbreath() )
        {
            return var3;
        }
    }
    
    foreach ( var3 in var0 )
    {
        if ( level.onlinegame && var3 isfireteamleader() )
        {
            var1 = var3;
            break;
        }
    }
    
    if ( !isdefined( var1 ) )
    {
        var7 = 0;
        var8 = 0;
        
        foreach ( var3 in var0 )
        {
            var10 = var7 == isbot( var3 );
            
            if ( var10 )
            {
                var8++;
                var11 = 1 / var8;
                
                if ( randomfloat( 1 ) < var11 )
                {
                    var1 = var3;
                }
            }
        }
    }
    
    if ( !isdefined( var1 ) )
    {
        foreach ( var3 in var0 )
        {
            var1 = var3;
            break;
        }
    }
    
    if ( !isdefined( var1 ) )
    {
        return undefined;
    }
    
    var1 scripts\mp\gametypes\br::ref_1319d( 1 );
    
    foreach ( var3 in var0 )
    {
        if ( var3 != var1 )
        {
            var3 scripts\mp\gametypes\br::ref_1319d( 0 );
        }
        
        var16 = scripts\engine\utility::ter_op( var3 scripts\mp\gametypes\br_public::updatedragonsbreath(), 2, 1 );
        scripts\mp\gametypes\br_c130::setteammateomnvarsforplayer( var3, var0, var16 );
    }
    
    return var1;
}

// Params 2
// Size: 0x2f
function firespoutwatch( var0, var1 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        return firesaleforplayers( var0, var1 );
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        return fix_collision( var0, var1 );
    }
    
    return buildac130infilanimstruct( var0, var1 );
}

// Params 2
// Size: 0x44f
function buildac130infilanimstruct( var0, var1 )
{
    var2 = spawnstruct();
    
    if ( isdefined( var0 ) )
    {
        var0.animstruct = var2;
        var2.movingc130 = var0;
    }
    
    var2.staticc130 = getent( "infil_plane", "script_noteworthy" );
    
    if ( isdefined( var2.staticc130 ) )
    {
        var2.staticc130 show();
    }
    else
    {
        var2.staticc130 = spawn( "script_model", getdvarvector( "br_infil_anim_pos", ( 0, 0, 0 ) ) );
        var2.staticc130 setmodel( "veh8_mil_air_acharlie130_magma_animated" );
        var2.staticc130.cleanme = 1;
    }
    
    var2.cameraent = spawn( "script_model", var2.staticc130.origin );
    var2.cameraent setmodel( "generic_prop_x5" );
    
    if ( isdefined( var0 ) )
    {
        var0 unmarkkeyframedmover( 1 );
        var2.gas_trigger = spawn( "script_model", var2.movingc130.origin );
        var2.gas_trigger setmodel( "generic_prop_x5" );
        var2.gas_trigger linkto( var2.movingc130, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.gas_trigger unmarkkeyframedmover( 1 );
    }
    
    spawnplayerpositionparentent( var2, var2.staticc130 );
    
    if ( var1 == "script_model" )
    {
        var2.playerslot1 = spawn( "script_model", var2.staticc130.origin );
        var2.playerslot1 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.playerslot2 = spawn( "script_model", var2.staticc130.origin );
        var2.playerslot2 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.playerslot3 = spawn( "script_model", var2.staticc130.origin );
        var2.playerslot3 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.playerslot4 = spawn( "script_model", var2.staticc130.origin );
        var2.playerslot4 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.playerslot1 linkto( var2.playerpositionents[ "parent" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerslot2 linkto( var2.playerpositionents[ "parent" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerslot3 linkto( var2.playerpositionents[ "parent" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerslot4 linkto( var2.playerpositionents[ "parent" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.infil_anim_type = "script_model";
    }
    else
    {
        var3 = [ "j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4" ];
        
        foreach ( var5 in var3 )
        {
            spawnplayerpositionent( var2, var5 );
        }
        
        var2.infil_anim_type = "player";
    }
    
    var2.aidoorchief = spawn( "script_model", var2.staticc130.origin );
    var2.aidoorchief setmodel( "fullbody_usmc_ar_br_infil" );
    
    if ( isdefined( var0 ) && isdefined( var2.movingc130.innards ) )
    {
        var2.movingc130.innards linkto( var2.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    var2.aidoorchief linkto( var2.playerpositionents[ "parent" ], "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.cameraent linkto( var2.staticc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.helicountdownendcallback = spawnfx( level._effect[ "vfx_br_infil_cloud_anim" ], var2.staticc130.origin );
    return var2;
}

// Params 2
// Size: 0x9de
function firesaleforplayers( var0, var1 )
{
    var2 = spawnstruct();
    
    if ( isdefined( var0 ) )
    {
        var0.animstruct = var2;
        var2.ref_11dbf = var0;
    }
    
    var3 = scripts\engine\utility::getstruct( "infil_plane_ch2", "script_noteworthy" );
    var2.origin = var3.origin;
    var2.angles = ( 0, 0, 0 );
    
    if ( isdefined( var3.angles ) )
    {
        var2.angles = var3.angles;
    }
    
    var2.chopper = spawn( "script_model", var2.origin );
    var2.chopper.angles = var2.angles;
    var2.chopper setmodel( "tag_origin" );
    var2.chopper.cleanme = 1;
    var2.goalradiustarget = spawn( "script_model", var2.origin );
    var2.goalradiustarget setmodel( "veh8_mil_air_mindia8_interior_infil_netting" );
    var2.goalradiustarget linkto( var2.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.givestandardtableloadout = spawn( "script_model", var2.origin );
    var2.givestandardtableloadout setmodel( "veh8_mil_air_mindia8_interior_infil_cabin_door" );
    var2.givestandardtableloadout linkto( var2.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.gas_trigger_think = spawn( "script_model", var2.origin );
    var2.gas_trigger_think setmodel( "generic_prop_x3" );
    var2.gas_trigger_think linkto( var2.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.gas_tryplaycoughaudio = spawn( "script_model", var2.origin );
    var2.gas_tryplaycoughaudio setmodel( "generic_prop_x3" );
    var2.gas_tryplaycoughaudio linkto( var2.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( var0 ) )
    {
        var0 unmarkkeyframedmover( 1 );
        var2.gas_triggers_init = spawn( "script_model", var0.origin );
        var2.gas_triggers_init setmodel( "generic_prop_x3" );
        var2.gas_triggers_init linkto( var0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.gas_triggers_init unmarkkeyframedmover( 1 );
        var2.gas_vfx_and_triggers = spawn( "script_model", var0.origin );
        var2.gas_vfx_and_triggers setmodel( "generic_prop_x3" );
        var2.gas_vfx_and_triggers linkto( var0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.gas_vfx_and_triggers unmarkkeyframedmover( 1 );
    }
    
    var2.playerpositionents[ "parent_solo" ] = spawn( "script_model", var2.origin );
    var2.playerpositionents[ "parent_solo" ] setmodel( "generic_prop_x3" );
    var2.playerpositionents[ "parent_solo" ] linkto( var2.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.playerpositionents[ "parent_squad" ] = spawn( "script_model", var2.origin );
    var2.playerpositionents[ "parent_squad" ] setmodel( "generic_prop_x5" );
    var2.playerpositionents[ "parent_squad" ] linkto( var2.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( var1 == "script_model" )
    {
        var2.ref_1269e = spawn( "script_model", var2.origin );
        var2.ref_1269e setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_1269e linkto( var2.playerpositionents[ "parent_solo" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_1269f = spawn( "script_model", var2.origin );
        var2.ref_1269f setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_1269f linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_126a0 = spawn( "script_model", var2.origin );
        var2.ref_126a0 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_126a0 linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_126a1 = spawn( "script_model", var2.origin );
        var2.ref_126a1 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_126a1 linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_126a2 = spawn( "script_model", var2.origin );
        var2.ref_126a2 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_126a2 linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.infil_anim_type = "script_model";
    }
    else
    {
        var2.playerpositionents[ "child_solo" ] = spawn( "script_model", var2.playerpositionents[ "parent_solo" ] gettagorigin( "j_prop_1" ) );
        var2.playerpositionents[ "child_solo" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_solo" ] linkto( var2.playerpositionents[ "parent_solo" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_1" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_1" ) );
        var2.playerpositionents[ "child_squad_1" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_1" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_2" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_2" ) );
        var2.playerpositionents[ "child_squad_2" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_2" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_3" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_3" ) );
        var2.playerpositionents[ "child_squad_3" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_3" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_4" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_4" ) );
        var2.playerpositionents[ "child_squad_4" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_4" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.infil_anim_type = "player";
    }
    
    var2.bot_gametype_attacker_defender_ai_director_update = spawn( "script_model", var2.origin );
    var2.bot_gametype_attacker_defender_ai_director_update setmodel( "fullbody_mp_eastern_bale_3_1" );
    var2.bot_gametype_attacker_defender_ai_director_update linkto( var2.playerpositionents[ "parent_solo" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.bot_clear_hq_zone = spawn( "script_model", var2.origin );
    var2.bot_clear_hq_zone setmodel( "fullbody_usmc_ar_br_infil" );
    var2.bot_clear_hq_zone linkto( var2.playerpositionents[ "parent_solo" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.calloutmarkerpingvo_handleraddnewelement = spawn( "script_model", var2.origin );
    var2.calloutmarkerpingvo_handleraddnewelement setmodel( "generic_prop_x10" );
    var2.calloutmarkerpingvo_handleraddnewelement linkto( var2.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.calloutmarkerpingvo_handleraddnewelement unmarkkeyframedmover( 1 );
    var4 = 9;
    var2.calloutmarkerpingvo_getmaxsoundaliaslength = [];
    
    for ( var5 = 0; var5 < var4 ; var5++ )
    {
        var6 = spawn( "script_model", var2.origin );
        var6 setmodel( "veh8_mil_air_mindia8_infil_flight" );
        var6 linkto( var2.calloutmarkerpingvo_handleraddnewelement, "j_prop_" + var5 + 2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var6 unmarkkeyframedmover( 1 );
        var6 playloopsound( "br_heli_infil_fleet_lp" );
        var2.calloutmarkerpingvo_getmaxsoundaliaslength[ var2.calloutmarkerpingvo_getmaxsoundaliaslength.size ] = var6;
    }
    
    return var2;
}

// Params 2
// Size: 0x9e1
function fix_collision( var0, var1 )
{
    var2 = spawnstruct();
    
    if ( isdefined( var0 ) )
    {
        var0.animstruct = var2;
        var2.ref_11dc3 = var0;
    }
    
    var2.ref_13886 = getent( "infil_plane_ch3", "script_noteworthy" );
    
    if ( isdefined( var2.ref_13886 ) )
    {
        var2.ref_13886 show();
    }
    else
    {
        var2.ref_13886 = spawn( "script_model", getdvarvector( "br_infil_anim_pos", ( 0, 0, 0 ) ) );
        var2.ref_13886 setmodel( "veh8_mil_air_acharlie130_magma_animated" );
    }
    
    var2.ref_13886.cleanme = 1;
    var2.chopper_kill = spawn( "script_model", var2.ref_13886.origin );
    var2.chopper_kill setmodel( "veh8_mil_air_skilo_interior_infil_int_bags_back_left_up" );
    var2.chopper_kill linkto( var2.ref_13886, "tag_bags_back_left_up", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.chopper_kill_vehicle = spawn( "script_model", var2.ref_13886.origin );
    var2.chopper_kill_vehicle setmodel( "veh8_mil_air_skilo_interior_infil_int_bags_back_right_up" );
    var2.chopper_kill_vehicle linkto( var2.ref_13886, "tag_bags_back_right_up", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.chopper_kill_person = spawn( "script_model", var2.ref_13886.origin );
    var2.chopper_kill_person setmodel( "veh8_mil_air_skilo_interior_infil_int_bags_back_right_low" );
    var2.chopper_kill_person linkto( var2.ref_13886, "tag_bags_back_right_low", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.ref_12915 = [ var2.chopper_kill, var2.chopper_kill_vehicle, var2.chopper_kill_person ];
    var2.ref_12d98 = spawn( "script_model", var2.ref_13886.origin );
    var2.ref_12d98 setmodel( "veh8_mil_air_skilo_interior_infil_ropes" );
    var2.ref_12d98 linkto( var2.ref_13886, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.ref_13887 = getent( "infil_skilo_door", "script_noteworthy" );
    var2.½d“»Í¸6›7¼ð˜sÂËX’› = getent( "static_skilo_interior", "script_noteworthy" );
    var2.§›fÃÊ1ø³˜ðÇ1aÃ/^ã = getent( "static_skilo_exterior", "script_noteworthy" );
    var2.‘ª&ƒŠq¸óGØ0Ã+¡b/ÀÌ = getent( "static_skilo_bottom_light", "script_noteworthy" );
    var2.©ƒPé[Â^¤+Ä:ûçº‰¤±Á = getent( "static_skilo_top_light", "script_noteworthy" );
    var2.gas_trigger_think = spawn( "script_model", var2.ref_13886.origin );
    var2.gas_trigger_think setmodel( "generic_prop_x3" );
    var2.gas_trigger_think linkto( var2.ref_13886, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.gas_tryplaycoughaudio = spawn( "script_model", var2.ref_13886.origin );
    var2.gas_tryplaycoughaudio setmodel( "generic_prop_x3" );
    var2.gas_tryplaycoughaudio linkto( var2.ref_13886, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( var0 ) )
    {
        var0 unmarkkeyframedmover( 1 );
        var2.gas_triggers_init = spawn( "script_model", var0.origin );
        var2.gas_triggers_init setmodel( "generic_prop_x3" );
        var2.gas_triggers_init linkto( var0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.gas_triggers_init unmarkkeyframedmover( 1 );
        var2.gas_vfx_and_triggers = spawn( "script_model", var0.origin );
        var2.gas_vfx_and_triggers setmodel( "generic_prop_x3" );
        var2.gas_vfx_and_triggers linkto( var0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.gas_vfx_and_triggers unmarkkeyframedmover( 1 );
    }
    
    var2.playerpositionents[ "parent_solo" ] = spawn( "script_model", var2.ref_13886.origin );
    var2.playerpositionents[ "parent_solo" ] setmodel( "generic_prop_x3" );
    var2.playerpositionents[ "parent_solo" ] linkto( var2.ref_13886, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.playerpositionents[ "parent_squad" ] = spawn( "script_model", var2.ref_13886.origin );
    var2.playerpositionents[ "parent_squad" ] setmodel( "generic_prop_x5" );
    var2.playerpositionents[ "parent_squad" ] linkto( var2.ref_13886, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( var1 == "script_model" )
    {
        var2.ref_1269e = spawn( "script_model", var2.ref_13886.origin );
        var2.ref_1269e setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_1269e linkto( var2.playerpositionents[ "parent_solo" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_1269f = spawn( "script_model", var2.ref_13886.origin );
        var2.ref_1269f setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_1269f linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_126a0 = spawn( "script_model", var2.ref_13886.origin );
        var2.ref_126a0 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_126a0 linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_126a1 = spawn( "script_model", var2.ref_13886.origin );
        var2.ref_126a1 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_126a1 linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_126a2 = spawn( "script_model", var2.ref_13886.origin );
        var2.ref_126a2 setmodel( "fullbody_usmc_ar_br_infil" );
        var2.ref_126a2 linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.infil_anim_type = "script_model";
    }
    else
    {
        var2.playerpositionents[ "child_solo" ] = spawn( "script_model", var2.playerpositionents[ "parent_solo" ] gettagorigin( "j_prop_1" ) );
        var2.playerpositionents[ "child_solo" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_solo" ] linkto( var2.playerpositionents[ "parent_solo" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_1" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_1" ) );
        var2.playerpositionents[ "child_squad_1" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_1" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_2" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_2" ) );
        var2.playerpositionents[ "child_squad_2" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_2" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_3" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_3" ) );
        var2.playerpositionents[ "child_squad_3" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_3" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "child_squad_4" ] = spawn( "script_model", var2.playerpositionents[ "parent_squad" ] gettagorigin( "j_prop_4" ) );
        var2.playerpositionents[ "child_squad_4" ] setmodel( "tag_player" );
        var2.playerpositionents[ "child_squad_4" ] linkto( var2.playerpositionents[ "parent_squad" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.infil_anim_type = "player";
    }
    
    if ( isdefined( var0 ) && isdefined( var2.ref_11dc3.innards ) )
    {
        var2.ref_11dc3.innards linkto( var2.ref_11dc3, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    return var2;
}

// Params 1
// Size: 0x235
function handlefriendlyvisibility( var0 )
{
    if ( isdefined( var0.calloutmarkerpingvo_getmaxsoundaliaslength ) )
    {
        foreach ( var2 in var0.calloutmarkerpingvo_getmaxsoundaliaslength )
        {
            var2 delete();
        }
    }
    
    if ( isdefined( var0.calloutmarkerpingvo_handleraddnewelement ) )
    {
        var0.calloutmarkerpingvo_handleraddnewelement delete();
    }
    
    if ( isdefined( var0.bot_clear_hq_zone ) )
    {
        var0.bot_clear_hq_zone delete();
    }
    
    if ( isdefined( var0.bot_gametype_attacker_defender_ai_director_update ) )
    {
        var0.bot_gametype_attacker_defender_ai_director_update delete();
    }
    
    if ( isdefined( var0.playerpositionents ) )
    {
        foreach ( var5 in var0.playerpositionents )
        {
            var5 delete();
        }
    }
    
    if ( isdefined( var0.ref_1269e ) )
    {
        var0.ref_1269e delete();
    }
    
    if ( isdefined( var0.ref_1269f ) )
    {
        var0.ref_1269f delete();
    }
    
    if ( isdefined( var0.ref_126a0 ) )
    {
        var0.ref_126a0 delete();
    }
    
    if ( isdefined( var0.ref_126a1 ) )
    {
        var0.ref_126a1 delete();
    }
    
    if ( isdefined( var0.ref_126a2 ) )
    {
        var0.ref_126a2 delete();
    }
    
    if ( isdefined( var0.gas_trigger_think ) )
    {
        var0.gas_trigger_think delete();
    }
    
    if ( isdefined( var0.gas_tryplaycoughaudio ) )
    {
        var0.gas_tryplaycoughaudio delete();
    }
    
    if ( isdefined( var0.gas_triggers_init ) )
    {
        var0.gas_triggers_init delete();
    }
    
    if ( isdefined( var0.gas_vfx_and_triggers ) )
    {
        var0.gas_vfx_and_triggers delete();
    }
    
    if ( isdefined( var0.givestandardtableloadout ) )
    {
        var0.givestandardtableloadout delete();
    }
    
    if ( isdefined( var0.goalradiustarget ) )
    {
        var0.goalradiustarget delete();
    }
    
    if ( isdefined( var0.chopper ) && istrue( var0.chopper.cleanme ) )
    {
        var0.chopper delete();
    }
    
    if ( isdefined( var0.ref_11dbf ) && istrue( var0.ref_11dbf.cleanme ) )
    {
        if ( isdefined( var0.ref_11dbf.innards ) && istrue( var0.ref_11dbf.innards.cleanme ) )
        {
            var0.ref_11dbf.innards delete();
        }
        
        var0.ref_11dbf delete();
        return;
    }
}

// Params 1
// Size: 0x2c2
function handleimpact( var0 )
{
    scripts\mp\utility\sound::ref_12c2a( "br_infil_skilo" );
    
    if ( isdefined( var0.playerpositionents ) )
    {
        foreach ( var2 in var0.playerpositionents )
        {
            var2 delete();
        }
    }
    
    if ( isdefined( var0.ref_1269e ) )
    {
        var0.ref_1269e delete();
    }
    
    if ( isdefined( var0.ref_1269f ) )
    {
        var0.ref_1269f delete();
    }
    
    if ( isdefined( var0.ref_126a0 ) )
    {
        var0.ref_126a0 delete();
    }
    
    if ( isdefined( var0.ref_126a1 ) )
    {
        var0.ref_126a1 delete();
    }
    
    if ( isdefined( var0.ref_126a2 ) )
    {
        var0.ref_126a2 delete();
    }
    
    if ( isdefined( var0.gas_trigger_think ) )
    {
        var0.gas_trigger_think delete();
    }
    
    if ( isdefined( var0.gas_tryplaycoughaudio ) )
    {
        var0.gas_tryplaycoughaudio delete();
    }
    
    if ( isdefined( var0.gas_triggers_init ) )
    {
        var0.gas_triggers_init delete();
    }
    
    if ( isdefined( var0.gas_vfx_and_triggers ) )
    {
        var0.gas_vfx_and_triggers delete();
    }
    
    if ( isdefined( var0.ref_12d98 ) )
    {
        var0.ref_12d98 delete();
    }
    
    foreach ( var5 in var0.ref_12915 )
    {
        if ( isdefined( var5 ) )
        {
            var5 delete();
        }
    }
    
    if ( isdefined( var0.ref_13886 ) && istrue( var0.ref_13886.cleanme ) )
    {
        var0.ref_13886 delete();
    }
    
    if ( isdefined( var0.ref_13887 ) )
    {
        var0.ref_13887 delete();
    }
    
    if ( isdefined( var0.½d“»Í¸6›7¼ð˜sÂËX’› ) )
    {
        var0.½d“»Í¸6›7¼ð˜sÂËX’› delete();
    }
    
    if ( isdefined( var0.§›fÃÊ1ø³˜ðÇ1aÃ/^ã ) )
    {
        var0.§›fÃÊ1ø³˜ðÇ1aÃ/^ã delete();
    }
    
    if ( isdefined( var0.‘ª&ƒŠq¸óGØ0Ã+¡b/ÀÌ ) )
    {
        var0.‘ª&ƒŠq¸óGØ0Ã+¡b/ÀÌ delete();
    }
    
    if ( isdefined( var0.©ƒPé[Â^¤+Ä:ûçº‰¤±Á ) )
    {
        var0.©ƒPé[Â^¤+Ä:ûçº‰¤±Á delete();
    }
    
    if ( isdefined( var0.ref_11dc3 ) && istrue( var0.ref_11dc3.cleanme ) )
    {
        if ( isdefined( var0.ref_11dc3.innards ) && istrue( var0.ref_11dc3.innards.cleanme ) )
        {
            var0.ref_11dc3.innards delete();
        }
        
        if ( isdefined( var0.ref_11dc3.bunker_numberstation ) && istrue( var0.ref_11dc3.bunker_numberstation.cleanme ) )
        {
            var0.ref_11dc3.bunker_numberstation delete();
        }
        
        if ( isdefined( var0.ref_11dc3.door ) && istrue( var0.ref_11dc3.door.cleanme ) )
        {
            var0.ref_11dc3.door delete();
        }
        
        var0.ref_11dc3 delete();
        return;
    }
}

// Params 1
// Size: 0x2b
function handleheadshotkillrewardbullets( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        handlefriendlyvisibility( var0 );
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        handleimpact( var0 );
        return;
    }
    
    scripts\mp\gametypes\br_public::cleanac130struct( var0 );
}

// Params 2
// Size: 0x69
function laser_vfx_think( var0, var1 )
{
    level endon( "game_ended" );
    var2 = getentarray( "skilo_props", "script_noteworthy" );
    
    if ( istrue( var1 ) )
    {
        if ( isdefined( var0 ) )
        {
            var3 = remove_munitions_in_radius( var0 );
            var3 waittillmatch( "camera", "end" );
        }
    }
    
    foreach ( var5 in var2 )
    {
        if ( isdefined( var5 ) )
        {
            var5 delete();
        }
    }
}

// Params 2
// Size: 0x69
function spawnplayerpositionparentent( var0, var1 )
{
    var0.playerpositionents[ "parent" ] = spawn( "script_model", var1.origin );
    var0.playerpositionents[ "parent" ] setmodel( "generic_prop_x5" );
    var0.playerpositionents[ "parent" ] linkto( var1, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Params 2
// Size: 0x6f
function spawnplayerpositionent( var0, var1 )
{
    var0.playerpositionents[ var1 ] = spawn( "script_model", var0.playerpositionents[ "parent" ] gettagorigin( var1 ) );
    var0.playerpositionents[ var1 ] setmodel( "tag_player" );
    var0.playerpositionents[ var1 ] linkto( var0.playerpositionents[ "parent" ], var1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Params 1
// Size: 0x2b
function remove_veh_spawners_from_passive_wave_spawning( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        return remove_usability_crutch_on_death( var0 );
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        return removeaccesscard( var0 );
    }
    
    return remove_tank_class( var0 );
}

#using_animtree( "" );

// Params 1
// Size: 0xf4
function remove_usability_crutch_on_death( var0 )
{
    var1 = self getplayerangles( 1 );
    var2 = anglestoforward( var1 );
    var3 = anglestoforward( var0.ref_11dbf.angles );
    var4 = anglestoright( var0.ref_11dbf.angles );
    var5 = vectordot( var2, var3 );
    var6 = vectordot( var2, var4 );
    var7 = cos( 45 );
    
    if ( var5 < -1 * var7 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10", %wz_infil_mindia8_jump_genpropx10, "wz_infil_mindia8_jump01_pl01" ];
    }
    
    if ( var6 > var7 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_90_l", $wz_infil_mindia8_jump_genpropx10_90_l, "wz_infil_mindia8_jump01_pl01_90_l" ];
    }
    
    if ( var6 < -1 * var7 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_90_r", %wz_infil_mindia8_jump_genpropx10_90_r, "wz_infil_mindia8_jump01_pl01_90_r" ];
    }
    
    if ( var6 > 0 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_180_l", %wz_infil_mindia8_jump_genpropx10_180_l, "wz_infil_mindia8_jump01_pl01_180_l" ];
    }
    
    return [ "wz_infil_mindia8_jump_genpropx10_180_r", %wz_infil_mindia8_jump_genpropx10_180_r, "wz_infil_mindia8_jump01_pl01_180_r" ];
}

// Params 1
// Size: 0xf4
function remove_tank_class( var0 )
{
    var1 = self getplayerangles( 1 );
    var2 = anglestoforward( var1 );
    var3 = anglestoforward( var0.movingc130.angles );
    var4 = anglestoright( var0.movingc130.angles );
    var5 = vectordot( var2, var3 );
    var6 = vectordot( var2, var4 );
    var7 = cos( 45 );
    
    if ( var5 < -1 * var7 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10", %sdr_mp_infil_ac130_jump_genpropx10, "sdr_mp_infil_ac130_jump" ];
    }
    
    if ( var6 > var7 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_l", %sdr_mp_infil_ac130_jump_genpropx10_90_l, "sdr_mp_infil_ac130_jump_90_l" ];
    }
    
    if ( var6 < -1 * var7 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_r", %sdr_mp_infil_ac130_jump_genpropx10_90_r, "sdr_mp_infil_ac130_jump_90_r" ];
    }
    
    if ( var6 > 0 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_180_l", %sdr_mp_infil_ac130_jump_genpropx10_180_l, "sdr_mp_infil_ac130_jump_180_l" ];
    }
    
    return [ "sdr_mp_infil_ac130_jump_genpropx10_180_r", %sdr_mp_infil_ac130_jump_genpropx10_180_r, "sdr_mp_infil_ac130_jump_180_r" ];
}

// Params 1
// Size: 0xf4
function removeaccesscard( var0 )
{
    var1 = self getplayerangles( 1 );
    var2 = anglestoforward( var1 );
    var3 = anglestoforward( var0.ref_11dc3.angles );
    var4 = anglestoright( var0.ref_11dc3.angles );
    var5 = vectordot( var2, var3 );
    var6 = vectordot( var2, var4 );
    var7 = cos( 45 );
    
    if ( var5 < -1 * var7 )
    {
        return [ "wz_infil_skilo_jump_genpropx10", %wz_infil_skilo_jump_genpropx10, "wz_infil_skilo_jump01_pl01" ];
    }
    
    if ( var6 > var7 )
    {
        return [ "wz_infil_skilo_jump_genpropx10_90_l", %wz_infil_skilo_jump_genpropx10_90_l, "wz_infil_skilo_jump01_pl01_90_l" ];
    }
    
    if ( var6 < -1 * var7 )
    {
        return [ "wz_infil_skilo_jump_genpropx10_90_r", %wz_infil_skilo_jump_genpropx10_90_r, "wz_infil_skilo_jump01_pl01_90_r" ];
    }
    
    if ( var6 > 0 )
    {
        return [ "wz_infil_skilo_jump_genpropx10_180_l", %wz_infil_skilo_jump_genpropx10_180_l, "wz_infil_skilo_jump01_pl01_180_l" ];
    }
    
    return [ "wz_infil_skilo_jump_genpropx10_180_r", %wz_infil_skilo_jump_genpropx10_180_r, "wz_infil_skilo_jump01_pl01_180_r" ];
}

// Params 1
// Size: 0x35
function ref_1274b( var0 )
{
    var1 = "";
    
    if ( var0 scripts\mp\gametypes\br_public::updatedragonsbreath() )
    {
        var1 = "br_infil_squad_leader_jump";
    }
    else
    {
        var1 = "br_infil_squadmate_jump";
    }
    
    var0 scripts\mp\gametypes\br_public::ref_1276a( var1, var0.team, var0 );
}

// Params 1
// Size: 0x39a
function watchinfiljumpanim( var0 )
{
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( level.infiljumpentsspawned ) )
    {
        level.infiljumpentsspawned = 0;
    }
    
    self.shouldhumanspawntags = 0;
    self waittill( "br_jump" );
    var1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
    var2 = [];
    
    if ( self.jumptype == "leader" )
    {
        foreach ( var4 in var1 )
        {
            if ( isdefined( var4.infilanimindex ) )
            {
                var2 = var4;
            }
        }
    }
    else if ( self.jumptype == "solo" || self.jumptype == "outOfBounds" )
    {
        var2 = [ self ];
    }
    
    var6 = var2.size > 0;
    
    if ( var6 )
    {
        var7 = getdvarint( "br_infil_play_jump_anims", 1 ) != 0;
        
        if ( level.infiljumpentsspawned >= 100 )
        {
            var7 = 0;
        }
        
        var8 = undefined;
        
        if ( var7 )
        {
            var8 = 0;
            var9 = remove_veh_spawners_from_passive_wave_spawning( var0 );
            var10 = var9[ 0 ];
            var11 = var9[ 1 ];
            var12 = var9[ 2 ];
            var9 = undefined;
            var13 = remove_objective_on_flag( var0 );
            GscBinSkip1( 0x45, "parent", spawn( "script_model", var13.origin ) );
            // Unknown operator ( 0x45, iw8, PC )
        }
        
        var13 = 1;
        waittillframeend();
        
        foreach ( var4 in var10 )
        {
            var4.infilanimindex = undefined;
            var4 stopanimscriptsceneevent();
            var4 notify( "infil_jump_done" );
            var4 scripts\mp\gametypes\br::ref_1254e();
        }
        
        if ( var13 )
        {
            waitframe();
            var13 = remove_objective_on_flag( var8 );
            
            if ( isdefined( var13 ) )
            {
                if ( isdefined( var13.playeroffsets ) && isdefined( var13.currentplayeroffset ) )
                {
                    foreach ( var4 in var10 )
                    {
                        var28 = var13.playeroffsets[ var13.currentplayeroffset ];
                        var4 setorigin( var13.origin + var28, 1, 1 );
                        var13.currentplayeroffset++;
                        
                        if ( var13.currentplayeroffset == var13.playeroffsets.size )
                        {
                            var13.currentplayeroffset = 0;
                        }
                        
                        var4 playershow( 1 );
                        thread ref_1274b( level );
                    }
                    
                    return;
                }
                
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0xd4
function playinfilplayeranims( var0, var1 )
{
    var2 = ref_1256d( var0 );
    var3 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 thread [[ level.parachutetakeweaponscb ]]();
        var5 scripts\mp\gametypes\br::ref_1254d();
        scripts\mp\utility\game::ref_131a3( var5, 1 );
        var5.plotarmor = 1;
        var5 unlink();
        playerlinktopositionent( var5, var0 );
        var6 = ref_1256e( var5, var0 );
        var5 playanimscriptsceneevent( "scripted_scene", var6 );
    }
    
    wait var2;
    var3 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        thread playerplayinfilloopanim( var5 );
    }
}

// Params 1
// Size: 0x3d
function ref_1256d( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        return getanimlength( %wz_infil_mindia8_solo_player );
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        return getanimlength( %wz_infil_skilo_single_sdr01 );
    }
    
    return getanimlength( %sdr_mp_infil_ac130_redux_player1 );
}

// Params 1
// Size: 0x7a
function ref_1256e( var0 )
{
    var1 = "";
    var2 = self hasfemalecustomizationmodel();
    
    if ( var2 )
    {
        var1 = "_fem";
    }
    
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return ( "wz_infil_mindia8_solo_player" + var1 );
        }
        
        return ( "wz_infil_mindia8_squad_player" + self.infilanimindex + var1 );
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return ( "wz_infil_skilo_single_sdr01" + var1 );
        }
        
        return ( "wz_infil_skilo_squad_sdr0" + self.infilanimindex + var1 );
    }
    
    return "sdr_mp_infil_ac130_redux_player" + self.infilanimindex;
}

// Params 1
// Size: 0x60
function ref_1256f( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return "wz_infil_mindia8_loop_pl01";
        }
        
        return ( "wz_infil_mindia8_loop_pl0" + self.infilanimindex );
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return "wz_infil_skilo_squad_sdr01_loop";
        }
        
        return ( "wz_infil_skilo_squad_sdr0" + self.infilanimindex + "_loop" );
    }
    
    return "sdr_mp_infil_ac130_loop_pl0" + self.infilanimindex;
}

// Params 1
// Size: 0x82
function ref_12571( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return var0.playerpositionents[ "child_solo" ];
        }
        
        return var0.playerpositionents[ "child_squad_" + self.infilanimindex ];
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return var0.playerpositionents[ "child_solo" ];
        }
        
        return var0.playerpositionents[ "child_squad_" + self.infilanimindex ];
    }
    
    return var0.playerpositionents[ "j_prop_" + self.infilanimindex ];
}

// Params 1
// Size: 0x5a
function ref_12572( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return "j_prop_1";
        }
        
        return ( "j_prop_" + self.infilanimindex );
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        if ( self.stop_counter_beep_sfx_on_bomb_vests )
        {
            return "j_prop_1";
        }
        
        return ( "j_prop_" + self.infilanimindex );
    }
    
    return "j_prop_" + self.infilanimindex;
}

// Params 1
// Size: 0x39
function playerlinktopositionent( var0 )
{
    if ( isai( self ) && !istrue( self.hasspawned ) )
    {
        return;
    }
    
    if ( !isdefined( self.infilanimindex ) )
    {
        self.infilanimindex = 1;
    }
    
    var1 = ref_12571( var0 );
    self playerlinkto( var1, "tag_player" );
}

// Params 1
// Size: 0x54
function playerplayinfilloopanim( var0 )
{
    if ( !isdefined( self.infilanimindex ) )
    {
        self.infilanimindex = 1;
    }
    
    if ( !isdefined( self.stop_counter_beep_sfx_on_bomb_vests ) )
    {
        var1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
        self.stop_counter_beep_sfx_on_bomb_vests = var1.size == 1;
    }
    
    var2 = ref_1256f( var0 );
    self playanimscriptsceneevent( "scripted_scene", var2 );
    thread watchinfiljumpanim( var0 );
}

// Params 1
// Size: 0x61
function ref_12ab5( var0 )
{
    var0 endon( "stopScene" );
    var0.staticc130 waittillmatch( "plane", "gored" );
    var1 = getentitylessscriptablearrayinradius( "infil_blinking_light", "script_noteworthy" );
    
    foreach ( var3 in var1 )
    {
        var3 setscriptablepartstate( "light_blinking_slow", "light_on", 1 );
    }
}

// Params 1
// Size: 0x61
function serverroomrewardlocs( var0 )
{
    var0 endon( "stopScene" );
    var0.staticc130 waittillmatch( "plane", "gogreen" );
    var1 = getentitylessscriptablearrayinradius( "infil_blinking_light", "script_noteworthy" );
    
    foreach ( var3 in var1 )
    {
        var3 setscriptablepartstate( "light_blinking_slow", "light_jump", 1 );
    }
}

// Params 1
// Size: 0x1da
function ref_133b1( var0 )
{
    var0 endon( "stopScene" );
    var1 = getentitylessscriptablearrayinradius( "infil_green_light", "script_noteworthy" );
    var2 = getentitylessscriptablearrayinradius( "infil_green_light_spot", "script_noteworthy" );
    var3 = getentitylessscriptablearrayinradius( "infil_red_light", "script_noteworthy" );
    var4 = getentitylessscriptablearrayinradius( "infil_red_light_spot", "script_noteworthy" );
    
    foreach ( var6 in var1 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_green", "light_off_hold", 1 );
    }
    
    foreach ( var6 in var2 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_green_spot", "light_off_hold", 1 );
    }
    
    foreach ( var6 in var3 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_red", "light_on", 1 );
    }
    
    foreach ( var6 in var4 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_red_spot", "light_on", 1 );
    }
    
    wait 4.6;
    
    foreach ( var6 in var1 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_green", "light_jump", 1 );
    }
    
    foreach ( var6 in var2 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_green_spot", "light_jump", 1 );
    }
    
    foreach ( var6 in var3 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_red", "light_jump", 1 );
    }
    
    foreach ( var6 in var4 )
    {
        var6 setscriptablepartstate( "light_blinking_infil_wz_island_red_spot", "light_jump", 1 );
    }
}

// Params 1
// Size: 0x45
function ref_11fac( var0 )
{
    var1 = getentitylessscriptablearrayinradius( "infil_blinking_light", "script_noteworthy" );
    
    foreach ( var3 in var1 )
    {
        var3 setscriptablepartstate( "light_blinking_slow", "light_off_hold", 1 );
    }
}

// Params 2
// Size: 0x8b
function ref_126f4( var0, var1 )
{
    var0 endon( "stopScene" );
    var0.staticc130 scripts\engine\utility::waittill_match_or_timeout( "plane", "opendoor", 30 );
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) || isbot( var4 ) )
        {
            continue;
        }
        
        var4 scripts\mp\utility\player::ref_1328c( "100", 1 );
    }
    
    var0.aidoorchief scripts\mp\utility\player::ref_1328c( "100" );
}

// Params 2
// Size: 0x58
function headoffset( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4.manualoverridewindmaterial = undefined;
    }
    
    var0.aidoorchief scripts\mp\utility\player::ref_1328c( "0" );
}

// Params 2
// Size: 0x5d
function ref_126f5( var0, var1 )
{
    var0 endon( "stopScene" );
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) || isbot( var4 ) )
        {
            continue;
        }
        
        var4 scripts\mp\utility\player::ref_1328c( "80", 1 );
    }
}

// Params 2
// Size: 0x46
function headshot_distance( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4.manualoverridewindmaterial = undefined;
    }
}

// Params 2
// Size: 0x79
function ref_126f6( var0, var1 )
{
    var0 endon( "stopScene" );
    var0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout( "camera", "opendoor", 30 );
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) || isbot( var4 ) )
        {
            continue;
        }
        
        var4 scripts\mp\utility\player::ref_1328c( "80", 1 );
    }
}

// Params 2
// Size: 0x46
function healdamage( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4.manualoverridewindmaterial = undefined;
    }
}

// Params 1
// Size: 0x58
function healthpack_health( var0 )
{
    ref_14361( 7.7 );
    var1 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    foreach ( var3 in var1 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var3 clearsoundsubmix( "mp_br_infil_ac130", 30 );
    }
}

// Params 1
// Size: 0x58
function healthpool( var0 )
{
    ref_14361( 0.65 );
    var1 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    foreach ( var3 in var1 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var3 clearsoundsubmix( "mp_br_infil_anim", 3 );
    }
}

// Params 1
// Size: 0x58
function health_remaining_max( var0 )
{
    ref_14361( 0.5 );
    var1 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    foreach ( var3 in var1 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var3 clearsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb", 1 );
    }
}

// Params 1
// Size: 0x67
function ref_131bf( var0 )
{
    ref_14361( 2 );
    var1 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    foreach ( var3 in var1 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var3 clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
        var3 setsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb", 2 );
    }
}

// Params 1
// Size: 0x122
function ref_12c3e( var0 )
{
    var1 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    foreach ( var3 in var1 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var4 = var3 getlinkedchildren();
        
        if ( isdefined( var4 ) && var4.size )
        {
            var5 = var4.size;
            
            if ( var5 > 0 )
            {
                var6 = "Infil Player (" + var3.name + ") with (" + var5 + ") linked ents: ";
                
                foreach ( var8 in var4 )
                {
                    if ( isdefined( var8.equipmentref ) )
                    {
                        var6 += "equip:" + var8.equipmentref + ",";
                        continue;
                    }
                    
                    if ( isdefined( var8.weapon_name ) )
                    {
                        var6 += "weapon:" + var8.weapon_name + ",";
                        continue;
                    }
                    
                    if ( isdefined( var8.model ) )
                    {
                        var6 += "model:" + var8.model + ",";
                        continue;
                    }
                    
                    var6 += "?,";
                }
                
                scripts\mp\utility\script::laststand_dogtags( var6 );
            }
        }
    }
}

// Params 2
// Size: 0x36
function ref_1273c( var0, var1 )
{
    ref_12c3e( var1 );
    
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        ref_1245a( var0, var1 );
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        ref_12765( var0, var1 );
        return;
    }
    
    playac130infilanim( var0, var1 );
}

// Params 2
// Size: 0x24
function ref_1245a( var0, var1 )
{
    thread ref_131bf( var1 );
    ref_12459( var0, var1 );
    ref_13ce9( var0, var1 );
    mp_m_trench_patch_giveplayer_c4( var0, var1 );
}

// Params 2
// Size: 0x24
function playac130infilanim( var0, var1 )
{
    thread ref_131bf( var1 );
    ref_12442( var0, var1 );
    ref_13ce8( var0, var1 );
    mp_m_speed_patch( var0, var1 );
}

// Params 2
// Size: 0x24
function ref_12765( var0, var1 )
{
    thread ref_131bf( var1 );
    ref_12764( var0, var1 );
    ref_13cf1( var0, var1 );
    neverspectate( var0, var1 );
}

// Params 1
// Size: 0x2b
function helicopter_death_lockon_clear( var0 )
{
    var0 endon( "stopScene" );
    var0.staticc130 waittillmatch( "plane", "transitionstart" );
    triggerfx( var0.helicountdownendcallback );
}

// Params 1
// Size: 0x89
function ref_1324f( var0 )
{
    var0.x = 0;
    var0.y = 0;
    var0 setshader( "white", 640, 480 );
    var0.alignx = "left";
    var0.aligny = "top";
    var0.horzalign = "fullscreen";
    var0.vertalign = "fullscreen";
    var0.sort = -1;
    var0.color = ( 0.21, 0.21, 0.17 );
    var0.alpha = 0;
    var0 sendcollectedclientanticheatdata( 1 );
}

// Params 1
// Size: 0x89
function ref_13250( var0 )
{
    var0.x = 0;
    var0.y = 0;
    var0 setshader( "white", 640, 480 );
    var0.alignx = "left";
    var0.aligny = "top";
    var0.horzalign = "fullscreen";
    var0.vertalign = "fullscreen";
    var0.sort = -1;
    var0.color = ( 0.93, 0.95, 0.94 );
    var0.alpha = 0;
    var0 sendcollectedclientanticheatdata( 1 );
}

// Params 0
// Size: 0x4d
function remove_munitions_globally()
{
    var0 = undefined;
    var1 = undefined;
    
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        var0 = 0.15;
        var1 = 0.2;
    }
    else if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        var0 = 0.16;
        var1 = 0.5;
    }
    else
    {
        var0 = 0.16;
        var1 = 0.5;
    }
    
    return [ var0, var1 ];
}

// Params 2
// Size: 0x1f1
function patch_ent_fixes( var0, var1 )
{
    level endon( "game_ended" );
    var2 = remove_munitions_in_radius( var0 );
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var3 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    var4 = level.players.size == var3.size;
    
    if ( var4 )
    {
        level.stop_passedby_once = newhudelem();
        ref_1324f( level.stop_passedby_once );
    }
    else
    {
        foreach ( var6 in var3 )
        {
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var6.stop_passedby_once = newclienthudelem( var6 );
            ref_1324f( var6.stop_passedby_once );
        }
    }
    
    var8 = remove_munitions_globally();
    var9 = var8[ 0 ];
    var10 = var8[ 1 ];
    var8 = undefined;
    var2 waittillmatch( "camera", "fadeinstart" );
    
    if ( var4 )
    {
        level.stop_passedby_once fadeovertime( var9 );
        level.stop_passedby_once.alpha = 1;
    }
    else
    {
        foreach ( var6 in var3 )
        {
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var6.stop_passedby_once fadeovertime( var9 );
            var6.stop_passedby_once.alpha = 1;
        }
    }
    
    var2 waittillmatch( "camera", "fadeoutstart" );
    
    if ( var4 )
    {
        level.stop_passedby_once fadeovertime( var10 );
        level.stop_passedby_once.alpha = 0;
    }
    else
    {
        foreach ( var6 in var3 )
        {
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var6.stop_passedby_once fadeovertime( var10 );
            var6.stop_passedby_once.alpha = 0;
        }
    }
    
    ref_14361( var10 + 0.1 );
    
    if ( var4 )
    {
        level.stop_passedby_once destroy();
        level.stop_passedby_once = undefined;
        return;
    }
    
    foreach ( var6 in var3 )
    {
        if ( !isdefined( var6 ) )
        {
            continue;
        }
        
        var6.stop_passedby_once destroy();
    }
}

// Params 2
// Size: 0x1ff
function helicopter_firendly_dmg_text_display( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "stopScene" );
    var2 = remove_munitions_in_radius( var0 );
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var3 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    var4 = level.players.size == var3.size;
    
    if ( var4 )
    {
        level.stop_turbulence_just_before_the_end = newhudelem();
        ref_13250( level.stop_turbulence_just_before_the_end );
    }
    else
    {
        foreach ( var6 in var3 )
        {
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var6.stop_turbulence_just_before_the_end = newclienthudelem( var6 );
            ref_13250( var6.stop_turbulence_just_before_the_end );
        }
    }
    
    var8 = 0.2;
    var9 = 0.6;
    var2 waittillmatch( "camera", "coverstart" );
    wait 0.12;
    
    if ( var4 )
    {
        level.stop_turbulence_just_before_the_end fadeovertime( var8 );
        level.stop_turbulence_just_before_the_end.alpha = 1;
    }
    else
    {
        foreach ( var6 in var3 )
        {
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var6.stop_turbulence_just_before_the_end fadeovertime( var8 );
            var6.stop_turbulence_just_before_the_end.alpha = 1;
        }
    }
    
    var2 waittillmatch( "camera", "end" );
    wait 0.3;
    
    if ( var4 )
    {
        level.stop_turbulence_just_before_the_end fadeovertime( var9 );
        level.stop_turbulence_just_before_the_end.alpha = 0;
    }
    else
    {
        foreach ( var6 in var3 )
        {
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var6.stop_turbulence_just_before_the_end fadeovertime( var9 );
            var6.stop_turbulence_just_before_the_end.alpha = 0;
        }
    }
    
    ref_14361( var9 + 0.1 );
    
    if ( var4 )
    {
        level.stop_turbulence_just_before_the_end destroy();
        level.stop_turbulence_just_before_the_end = undefined;
        return;
    }
    
    foreach ( var6 in var3 )
    {
        if ( !isdefined( var6 ) )
        {
            continue;
        }
        
        var6.stop_turbulence_just_before_the_end destroy();
    }
}

// Params 1
// Size: 0x97
function stimmodelattached( var0 )
{
    var1 = getdvarfloat( "LKOLRONRNQ" );
    var2 = getdvarint( "LTQMSPKRKO" );
    var3 = getdvarint( "MROOOROPKL" );
    var4 = getdvarfloat( "NPONLLLSPL" );
    setdvar( "LKOLRONRNQ", 1000 );
    setdvar( "LTQMSPKRKO", 6 );
    setdvar( "MROOOROPKL", 8 );
    setdvar( "NPONLLLSPL", 0.25 );
    var0 scripts\engine\utility::waittill_either( "infil_reset_light_dvars", "stopScene" );
    setdvar( "LKOLRONRNQ", var1 );
    setdvar( "LTQMSPKRKO", var2 );
    setdvar( "MROOOROPKL", var3 );
    setdvar( "NPONLLLSPL", var4 );
}

// Params 1
// Size: 0x97
function stompeenemyprogressupdate( var0 )
{
    var1 = getdvarfloat( "LKOLRONRNQ" );
    var2 = getdvarint( "LTQMSPKRKO" );
    var3 = getdvarint( "MROOOROPKL" );
    var4 = getdvarfloat( "NPONLLLSPL" );
    setdvar( "LKOLRONRNQ", 1000 );
    setdvar( "LTQMSPKRKO", 8 );
    setdvar( "MROOOROPKL", 8 );
    setdvar( "NPONLLLSPL", 0.25 );
    var0 scripts\engine\utility::waittill_either( "infil_reset_light_dvars", "stopScene" );
    setdvar( "LKOLRONRNQ", var1 );
    setdvar( "LTQMSPKRKO", var2 );
    setdvar( "MROOOROPKL", var3 );
    setdvar( "NPONLLLSPL", var4 );
}

// Params 1
// Size: 0x4d
function givecustomloadout( var0 )
{
    if ( isdefined( var0.givestandardtableloadout ) )
    {
        var0.givestandardtableloadout hide();
    }
    
    var0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout( "camera", "showdoor", 30 );
    
    if ( isdefined( var0.givestandardtableloadout ) )
    {
        var0.givestandardtableloadout show();
        return;
    }
}

// Params 2
// Size: 0x18f
function cargo_truck_mg_initinteract( var0, var1 )
{
    var2 = undefined;
    
    if ( var0.infil_anim_type == "player" )
    {
        jumpiftrue(isdefined( var1 )) LOC_0000013f;
        
        foreach ( var4 in level.teamnamelist )
        {
            var5 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic( var4 );
            
            for ( var6 = 0; var6 < var5.size ; var6++ )
            {
                var7 = var5[ var6 ];
                var8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var4, var7 );
                var9 = var8.size == 1;
                var10 = fivecontracts( var8.size );
                
                foreach ( var12 in var8 )
                {
                    if ( var12 scripts\mp\gametypes\br_public::updatedragonsbreath() )
                    {
                        var12.infilanimindex = 1;
                    }
                    else
                    {
                        var13 = scripts\engine\utility::random( var10 );
                        var12.infilanimindex = var13;
                        var10 = scripts\engine\utility::array_remove( var10, var13 );
                    }
                    
                    var12.stop_counter_beep_sfx_on_bomb_vests = var9;
                }
            }
        }
        
        ref_12acc();
        
        foreach ( var12 in level.players )
        {
            if ( isdefined( var12 ) && !isdefined( var12.stop_counter_beep_sfx_on_bomb_vests ) )
            {
                var12.infilanimindex = 1;
                var12.stop_counter_beep_sfx_on_bomb_vests = 1;
            }
        }
        
        return;
    }
}

// Params 2
// Size: 0x32a
function ref_12442( var0, var1 )
{
    var0 endon( "stopScene" );
    cargo_truck_mg_initinteract( var0, var1 );
    var2 = 34;
    var3 = 5.6;
    var4 = 50.7;
    var5 = 2;
    var6 = 4;
    var0.cameraent scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_cam", "camera" );
    
    if ( isdefined( var0.gas_trigger ) )
    {
        var0.gas_trigger scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_cam", "camera" );
    }
    
    if ( isdefined( var0.movingc130 ) )
    {
        var0.movingc130 stoploopsound();
    }
    
    var7 = scripts\mp\gametypes\br_public::isusinginfilselection();
    var0.aidoorchief hide();
    var8 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var10 in var8 )
    {
        if ( !isdefined( var10 ) )
        {
            continue;
        }
        
        if ( !var7 )
        {
            var10 setsoundsubmix( "mp_br_infil_anim", 0 );
            var10 setsoundsubmix( "mp_br_infil_music", 0 );
            
            if ( !istrue( level.vehicle_collision_getleveldata ) && !isdefined( level.ref_12d05 ) )
            {
                var10 setsoundsubmix( "mp_br_infil_ac130", 0 );
            }
            
            var10 setclienttriggeraudiozone( "mp_donetsk_infil_int", 1 );
        }
        
        var0.gas_trap_weapon = "j_prop_" + var10.infilanimindex;
        var10 cameraunlink();
        var10 cameralinkto( var0.cameraent, var0.gas_trap_weapon, 1, 1 );
        var10 setclientdvar( "QTSPTNLOL", var2 );
        var10 enablephysicaldepthoffieldscripting();
        var10 setphysicaldepthoffield( var3, var4, var5, var6 );
        var10 scripts\mp\utility\player::_freezelookcontrols( 1 );
        var0.aidoorchief showtoplayer( var10 );
    }
    
    thread healthpool( var1 );
    thread getlightingvalues();
    playfxontag( level._effect[ "vfx_br_ac130_clouds" ], var0.staticc130, "tag_body" );
    var0.staticc130 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_ac130", "plane" );
    
    if ( isdefined( var0.movingc130 ) )
    {
        var0.movingc130 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_ac130", "plane" );
        var0.movingc130.innards scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_ac130", "planeInnards" );
    }
    
    var0.playerpositionents[ "parent" ] scriptmodelplayanim( "sdr_mp_infil_ac130_redux_character_link", "prop" );
    
    if ( var0.infil_anim_type == "script_model" )
    {
        var0.playerslot1 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player1", "p1" );
        var0.playerslot2 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player2", "p2" );
        var0.playerslot3 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player3", "p3" );
        var0.playerslot4 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player4", "p4" );
    }
    else if ( var0.infil_anim_type == "player" )
    {
        thread playinfilplayeranims( var0, var1 );
    }
    
    var0.aidoorchief scriptmodelplayanim( "sdr_mp_infil_ac130_redux_doorchief", "doorchief" );
    thread ref_11fac( level );
    thread ref_12ab5( level );
    thread serverroomrewardlocs( level );
    thread ref_126f4( level, var0 );
    thread helicopter_death_lockon_clear( level );
    thread patch_ent_fixes( level, var0 );
    thread stimmodelattached( level );
    thread ks_circleminimapradius( level, var0 );
    var0.cameraent scripts\engine\utility::waittill_match_or_timeout( "camera", "transition", 30 );
    var0 notify( "infil_reset_light_dvars" );
    headoffset( level, var0, var1 );
}

// Params 4
// Size: 0x49b
function ref_12459( var0, var1, var2, var3 )
{
    var0 endon( "stopScene" );
    cargo_truck_mg_initinteract( var0, var1 );
    var4 = 48;
    var5 = 5.6;
    var6 = 50.7;
    var7 = 2;
    var8 = 4;
    var0.gas_trigger_think scriptmodelplayanim( "wz_infil_mindia8_solo_cam", "camera" );
    
    if ( isdefined( var0.gas_triggers_init ) )
    {
        var0.gas_triggers_init scriptmodelplayanim( "wz_infil_mindia8_solo_cam", "camera" );
    }
    
    var0.gas_tryplaycoughaudio scriptmodelplayanim( "wz_infil_mindia8_squad_cam", "camera" );
    
    if ( isdefined( var0.gas_vfx_and_triggers ) )
    {
        var0.gas_vfx_and_triggers scriptmodelplayanim( "wz_infil_mindia8_squad_cam", "camera" );
    }
    
    if ( isdefined( var0.ref_11dbf ) )
    {
        var0.ref_11dbf stoploopsound();
    }
    
    var0.bot_gametype_attacker_defender_ai_director_update hide();
    var0.bot_clear_hq_zone hide();
    var9 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var11 in var9 )
    {
        if ( !isdefined( var11 ) )
        {
            continue;
        }
        
        var11 playlocalsound( "br_heli_infil_part2_lr" );
        var11 setsoundsubmix( "mp_br_infil_anim", 0 );
        var11 setsoundsubmix( "mp_br_infil_music", 0 );
        
        if ( !istrue( level.vehicle_collision_getleveldata ) && !isdefined( level.ref_12d05 ) )
        {
            var11 setsoundsubmix( "mp_br_infil_ac130", 0 );
        }
        
        var11 setclienttriggeraudiozone( "mp_donetsk_infil_int", 1 );
        var12 = scripts\engine\utility::ter_op( var11.stop_counter_beep_sfx_on_bomb_vests, var0.gas_trigger_think, var0.gas_tryplaycoughaudio );
        var13 = "j_prop_1";
        var11 cameraunlink();
        var11 cameralinkto( var12, var13, 1, 1 );
        var11 setclientdvar( "QTSPTNLOL", var4 );
        var11 setclientdvar( "LTMOQONPQ", 1 );
        var11 enablephysicaldepthoffieldscripting();
        var11 setphysicaldepthoffield( var5, var6, var7, var8 );
        var11 scripts\mp\utility\player::_freezelookcontrols( 1 );
        var0.bot_gametype_attacker_defender_ai_director_update showtoplayer( var11 );
        var0.bot_clear_hq_zone showtoplayer( var11 );
    }
    
    thread healthpool( var1 );
    
    if ( isdefined( var0.ref_11dbf ) )
    {
        var0.ref_11dbf setscriptablepartstate( "infil_fx_hero", "on" );
    }
    
    var0.playerpositionents[ "parent_solo" ] scriptmodelplayanim( "wz_infil_mindia8_solo_character_link", "prop" );
    var0.playerpositionents[ "parent_squad" ] scriptmodelplayanim( "wz_infil_mindia8_squad_character_link", "prop" );
    
    if ( var0.infil_anim_type == "script_model" )
    {
        if ( istrue( var2 ) )
        {
            var0.ref_1269e show();
            var0.ref_1269f hide();
            var0.ref_126a0 hide();
            var0.ref_126a1 hide();
            var0.ref_126a2 hide();
        }
        else
        {
            var0.ref_1269e hide();
            var0.ref_1269f show();
            var0.ref_126a0 show();
            var0.ref_126a1 show();
            var0.ref_126a2 show();
        }
        
        var15 = "";
        
        if ( istrue( var3 ) )
        {
            var15 = "_fem";
        }
        
        var0.ref_1269e scriptmodelplayanim( "wz_infil_mindia8_solo_player" + var15, "p1" );
        var0.ref_1269f scriptmodelplayanim( "wz_infil_mindia8_squad_player1" + var15, "p1" );
        var0.ref_126a0 scriptmodelplayanim( "wz_infil_mindia8_squad_player2" + var15, "p2" );
        var0.ref_126a1 scriptmodelplayanim( "wz_infil_mindia8_squad_player3" + var15, "p3" );
        var0.ref_126a2 scriptmodelplayanim( "wz_infil_mindia8_squad_player4" + var15, "p4" );
    }
    else if ( var0.infil_anim_type == "player" )
    {
        thread playinfilplayeranims( var0, var1 );
    }
    
    var0.bot_gametype_attacker_defender_ai_director_update scriptmodelplayanim( "wz_infil_mindia8_solo_pilot", "aiPilot" );
    var0.bot_clear_hq_zone scriptmodelplayanim( "wz_infil_mindia8_solo_copilot", "aiCopilot" );
    var0.calloutmarkerpingvo_handleraddnewelement scriptmodelplayanim( "wz_infil_mindia8_armada", "armadaRig" );
    
    foreach ( var17 in var0.calloutmarkerpingvo_getmaxsoundaliaslength )
    {
        var18 = getanimlength( %wz_infil_mindia8_loop_veh );
        var19 = randomfloatrange( 0.5, var18 - 0.5 );
        var17 scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopper", var19 );
        var17 setscriptablepartstate( "infil_fx_armada", "on" );
        
        if ( isdefined( var17.innards ) )
        {
            var17.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopperInnards", var19 );
        }
    }
    
    thread ref_126f5( level, var0 );
    thread givecustomloadout( level );
    thread patch_ent_fixes( level, var0 );
    thread stompeenemyprogressupdate( level );
    thread ks_circleminimapradius( level, var0 );
    var0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout( "camera", "transition", 30 );
    var0 notify( "infil_reset_light_dvars" );
    headshot_distance( level, var0, var1 );
}

// Params 4
// Size: 0x52b
function ref_12764( var0, var1, var2, var3 )
{
    var0 endon( "stopScene" );
    cargo_truck_mg_initinteract( var0, var1 );
    var4 = 42;
    var5 = 5.6;
    var6 = 50.7;
    var7 = 2;
    var8 = 4;
    var0.gas_trigger_think scriptmodelplayanim( "wz_infil_skilo_single_cam", "camera" );
    
    if ( isdefined( var0.gas_triggers_init ) )
    {
        var0.gas_triggers_init scriptmodelplayanim( "wz_infil_skilo_single_cam", "camera" );
    }
    
    var0.gas_tryplaycoughaudio scriptmodelplayanim( "wz_infil_skilo_squad_cam", "camera" );
    
    if ( isdefined( var0.gas_vfx_and_triggers ) )
    {
        var0.gas_vfx_and_triggers scriptmodelplayanim( "wz_infil_skilo_squad_cam", "camera" );
    }
    
    if ( isdefined( var0.ref_11dc3 ) )
    {
        var0.ref_11dc3 stoploopsound();
    }
    
    var0.ref_13886 setscriptablepartstate( "infil_fx_skilo", "static" );
    var9 = scripts\mp\gametypes\br_public::isusinginfilselection();
    var10 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var12 in var10 )
    {
        if ( !isdefined( var12 ) )
        {
            continue;
        }
        
        if ( !var9 )
        {
            if ( var12.stop_counter_beep_sfx_on_bomb_vests )
            {
                thread stop_strafe_minigun_manager( "br_skilo_solo_infil_part1_lr", 0.8, var12 );
                thread stop_strafe_minigun_manager( "br_skilo_solo_infil_part2_lr", 6.4, var12 );
            }
            else
            {
                thread stop_strafe_minigun_manager( "br_skilo_quad_infil_part1_lr", 0.8, var12 );
                thread stop_strafe_minigun_manager( "br_skilo_quad_infil_part2_lr", 6.4, var12 );
            }
            
            var12 setsoundsubmix( "mp_br_infil_anim", 0 );
            var12 setsoundsubmix( "mp_br_infil_music", 0 );
            
            if ( !istrue( level.vehicle_collision_getleveldata ) && !isdefined( level.ref_12d05 ) )
            {
                var12 setsoundsubmix( "mp_br_infil_ac130", 0 );
            }
            
            var12 setclienttriggeraudiozone( "mp_island_infil_int", 1 );
        }
        
        var13 = scripts\engine\utility::ter_op( var12.stop_counter_beep_sfx_on_bomb_vests, var0.gas_trigger_think, var0.gas_tryplaycoughaudio );
        var14 = "j_prop_1";
        var12 cameraunlink();
        var12 cameralinkto( var13, var14, 1, 1 );
        var12 setclientdvar( "QTSPTNLOL", var4 );
        var12 setclientdvar( "LTMOQONPQ", 1 );
        var12 enablephysicaldepthoffieldscripting();
        var12 setphysicaldepthoffield( var5, var6, var7, var8 );
        var12 scripts\mp\utility\player::_freezelookcontrols( 1 );
        var12 calloutmarkerping_getinventoryslot( 5000 );
        var12 scripts\mp\gametypes\br_public::ref_126b9( var0.ref_13886.origin );
    }
    
    thread healthpool( var1 );
    
    if ( isdefined( var0.ref_11dc3.bunker_numberstation ) )
    {
        var0.ref_11dc3.bunker_numberstation setscriptablepartstate( "infil_fx_clouds", "on" );
        var0.ref_11dc3.bunker_numberstation setscriptablepartstate( "infil_fx_skilo", "moving" );
    }
    
    thread getlightingvalues();
    var0.playerpositionents[ "parent_solo" ] scriptmodelplayanim( "wz_infil_skilo_single_sdr_link", "prop" );
    var0.playerpositionents[ "parent_squad" ] scriptmodelplayanim( "wz_infil_skilo_squad_sdr_link", "prop" );
    
    if ( var0.infil_anim_type == "script_model" )
    {
        if ( istrue( var2 ) )
        {
            var0.ref_1269e show();
            var0.ref_1269f hide();
            var0.ref_126a0 hide();
            var0.ref_126a1 hide();
            var0.ref_126a2 hide();
        }
        else
        {
            var0.ref_1269e hide();
            var0.ref_1269f show();
            var0.ref_126a0 show();
            var0.ref_126a1 show();
            var0.ref_126a2 show();
        }
        
        var16 = "";
        
        if ( istrue( var3 ) )
        {
            var16 = "_fem";
        }
        
        var0.ref_1269e scriptmodelplayanim( "wz_infil_skilo_single_sdr01" + var16, "p1" );
        var0.ref_1269f scriptmodelplayanim( "wz_infil_skilo_squad_sdr01" + var16, "p1" );
        var0.ref_126a0 scriptmodelplayanim( "wz_infil_skilo_squad_sdr02" + var16, "p2" );
        var0.ref_126a1 scriptmodelplayanim( "wz_infil_skilo_squad_sdr03" + var16, "p3" );
        var0.ref_126a2 scriptmodelplayanim( "wz_infil_skilo_squad_sdr04" + var16, "p4" );
    }
    else if ( var0.infil_anim_type == "player" )
    {
        thread playinfilplayeranims( var0, var1 );
    }
    
    if ( isdefined( var0.ref_13886 ) )
    {
        var0.ref_13886 scriptmodelplayanim( "wz_infil_skilo_single_veh", "plane", 0, 1 );
    }
    
    if ( isdefined( var0.ref_12d98 ) )
    {
        var0.ref_12d98 scriptmodelplayanim( "wz_infil_skilo_single_veh_ropes", "plane", 0, 1 );
    }
    
    foreach ( var18 in var0.ref_12915 )
    {
        if ( isdefined( var18 ) )
        {
            var18 scriptmodelplayanim( "wz_infil_skilo_single_veh", "plane", 0, 1 );
        }
    }
    
    if ( isdefined( var0.ref_13887 ) )
    {
        var0.ref_13887 scriptmodelplayanim( "wz_infil_skilo_single_door", "plane", 0, 1 );
    }
    
    thread ref_126f6( level, var0 );
    thread ref_133b1( level );
    thread patch_ent_fixes( level, var0 );
    thread helicopter_firendly_dmg_text_display( level, var0 );
    thread spawn_apache_chopper( level, var0 );
    thread laser_vfx_think( level, var0 );
    thread stimmodelattached( level );
    thread ks_circleminimapradius( level, var0 );
    thread ref_12e63( level, var0 );
    var0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout( "camera", "transition", 30 );
    var0 notify( "infil_reset_light_dvars" );
    thread healdamage( level, var0 );
}

// Params 2
// Size: 0x83
function ref_12e63( var0, var1 )
{
    if ( getdvarint( "scr_br_infil_skilo_safe_remove_black_border", 1 ) == 0 )
    {
        return;
    }
    
    var2 = remove_munitions_in_radius( var0 );
    var3 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    var2 scripts\engine\utility::waittill_match_or_timeout( "camera", "end", 30 );
    wait 0.25;
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 setclientomnvar( "ui_br_bink_overlay_state", 0 );
        var5 skydive_cutparachuteoff();
    }
}

// Params 2
// Size: 0xe0
function spawn_apache_chopper( var0, var1 )
{
    level endon( "game_ended" );
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) == 0 || !isdefined( level.br_circle ) || !isdefined( level.br_circle.dangercircleent ) || istrue( level.br_infils_disabled ) )
    {
        return;
    }
    
    var2 = remove_munitions_in_radius( var0 );
    var3 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        level.br_circle.dangercircleent hidefromplayer( var5 );
    }
    
    var2 scripts\engine\utility::waittill_match_or_timeout( "camera", "end", 30 );
    
    foreach ( var5 in var3 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        level.br_circle.dangercircleent showtoplayer( var5 );
    }
}

// Params 3
// Size: 0x15
function stop_strafe_minigun_manager( var0, var1, var2 )
{
    var2 endon( "death_or_disconnect" );
    wait var1;
    var2 playlocalsound( var0 );
}

// Params 2
// Size: 0xb2
function ks_circleminimapradius( var0, var1 )
{
    var2 = remove_objective_on_flag( var0 );
    
    if ( isdefined( var2 ) && getdvarint( "scr_br_streamToMovingPlane", 1 ) == 1 )
    {
        var3 = getdvarint( "scr_br_streamToMovingPlaneDelay", 8 );
        wait var3;
        var4 = var2.origin;
        var5 = getdvarint( "scr_br_streamToMovingPlaneForward", 0 );
        
        if ( var5 > 0 )
        {
            var6 = anglestoforward( var2.angles );
            var4 = var2.origin + var6 * var5;
        }
        
        var7 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
        
        foreach ( var9 in var7 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9 calloutmarkerping_getinventoryslot( 0 );
            var9 scripts\mp\gametypes\br_public::ref_126b9( var4 );
        }
        
        return;
    }
}

// Params 2
// Size: 0x72
function ref_138f3( var0, var1 )
{
    var2 = remove_objective_on_flag( var0 );
    
    if ( isdefined( var2 ) && getdvarint( "scr_br_streamToMovingPlane", 1 ) == 1 )
    {
        var3 = getdvarint( "scr_br_streamToMovingPlaneEndDelay", 5 );
        wait var3;
        var4 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
        
        foreach ( var6 in var4 )
        {
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var6 thread scripts\mp\gametypes\br_public::ref_1252b();
        }
        
        return;
    }
}

// Params 2
// Size: 0x49
function ref_13f06( var0, var1 )
{
    wait var0;
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 scripts\mp\utility\player::_freezelookcontrols( 0 );
    }
}

// Params 2
// Size: 0x300
function ref_13ce8( var0, var1 )
{
    var2 = 65;
    var3 = 14;
    var4 = 35;
    var5 = 2;
    var6 = 4;
    
    if ( isdefined( var0.gas_trigger ) )
    {
        var7 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
        
        foreach ( var9 in var7 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9 calloutmarkerping_getcreatedtime( 0 );
            
            if ( !isdefined( var9.infilanimindex ) )
            {
                var9.infilanimindex = 1;
            }
            
            var0.gas_trap_weapon = "j_prop_" + var9.infilanimindex;
            var9 cameraunlink();
            var9 cameralinkto( var0.gas_trigger, var0.gas_trap_weapon, 1, 1 );
            var9 setclientdvar( "QTSPTNLOL", var2 );
            var9 setphysicaldepthoffield( var3, var4, var5, var6 );
        }
        
        thread health_remaining_max( var1 );
    }
    else
    {
        var7 = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.players );
        
        foreach ( var9 in var7 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9 calloutmarkerping_getcreatedtime( 0 );
        }
    }
    
    if ( isdefined( var2.helicountdownendcallback ) )
    {
        if ( isdefined( var2.movingc130 ) )
        {
            var2.helicountdownendcallback.origin = var2.movingc130.origin;
        }
    }
    
    var2.staticc130 hide();
    var2.cameraent unlink();
    var2.playerpositionents[ "parent" ] unlink();
    
    if ( isdefined( var2.movingc130 ) )
    {
        var2.playerpositionents[ "parent" ] linkto( var2.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.cameraent linkto( var2.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.movingc130 notify( "start_moving" );
    }
    
    setomnvar( "ui_hide_player_icons", 0 );
    var7 = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.players );
    
    foreach ( var9 in var7 )
    {
        if ( !isdefined( var9 ) )
        {
            continue;
        }
        
        var9 setclienttriggeraudiozone( "mp_donetsk_infil_ext", 2 );
    }
    
    thread healthpack_health( var3 );
    
    if ( var2.infil_anim_type == "script_model" )
    {
        var2.playerslot1 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl01", "p1" );
        var2.playerslot2 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl02", "p2" );
        var2.playerslot3 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl03", "p3" );
        var2.playerslot4 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl04", "p4" );
    }
    
    var2.aidoorchief scriptmodelplayanim( "sdr_mp_infil_ac130_loop_doorchief", "doorchief" );
    thread playac130infilloopanims( level );
    
    if ( isdefined( var2.gas_trigger ) )
    {
        var2.gas_trigger waittillmatch( "camera", "end" );
    }
    
    thread ref_13f06( 1.2, var3 );
}

// Params 2
// Size: 0x361
function ref_13ce9( var0, var1 )
{
    var2 = 65;
    var3 = 14;
    var4 = 35;
    var5 = 2;
    var6 = 4;
    
    if ( isdefined( var0.gas_triggers_init ) && isdefined( var0.gas_vfx_and_triggers ) )
    {
        var7 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
        
        foreach ( var9 in var7 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9 calloutmarkerping_getcreatedtime( 0 );
            
            if ( !isdefined( var9.infilanimindex ) )
            {
                var9.infilanimindex = 1;
            }
            
            if ( !isdefined( var9.stop_counter_beep_sfx_on_bomb_vests ) )
            {
                var9.stop_counter_beep_sfx_on_bomb_vests = 1;
            }
            
            var10 = scripts\engine\utility::ter_op( var9.stop_counter_beep_sfx_on_bomb_vests, var0.gas_triggers_init, var0.gas_vfx_and_triggers );
            var11 = "j_prop_1";
            var9 cameraunlink();
            var9 cameralinkto( var10, var11, 1, 1 );
            var9 setclientdvar( "QTSPTNLOL", var2 );
            var9 setclientdvar( "LTMOQONPQ", 0 );
            var9 setphysicaldepthoffield( var3, var4, var5, var6 );
        }
        
        thread health_remaining_max( var1 );
    }
    else
    {
        var7 = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.players );
        
        foreach ( var9 in var7 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9 calloutmarkerping_getcreatedtime( 0 );
        }
    }
    
    var2.playerpositionents[ "parent_solo" ] unlink();
    var2.playerpositionents[ "parent_squad" ] unlink();
    
    if ( isdefined( var2.ref_11dbf ) )
    {
        var2.playerpositionents[ "parent_solo" ] linkto( var2.ref_11dbf, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "parent_squad" ] linkto( var2.ref_11dbf, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_11dbf notify( "start_moving" );
    }
    
    var2.calloutmarkerpingvo_handleraddnewelement unlink();
    
    if ( isdefined( var2.ref_11dbf ) )
    {
        var2.calloutmarkerpingvo_handleraddnewelement linkto( var2.ref_11dbf, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    setomnvar( "ui_hide_player_icons", 0 );
    var7 = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.players );
    
    foreach ( var9 in var7 )
    {
        if ( !isdefined( var9 ) )
        {
            continue;
        }
        
        var9 setclienttriggeraudiozone( "mp_donetsk_infil_ext", 2 );
    }
    
    thread healthpack_health( var3 );
    
    if ( var2.infil_anim_type == "script_model" )
    {
        var2.ref_1269e scriptmodelplayanim( "wz_infil_mindia8_loop_pl01", "p1" );
        var2.ref_1269f scriptmodelplayanim( "wz_infil_mindia8_loop_pl01", "p1" );
        var2.ref_126a0 scriptmodelplayanim( "wz_infil_mindia8_loop_pl02", "p2" );
        var2.ref_126a1 scriptmodelplayanim( "wz_infil_mindia8_loop_pl03", "p3" );
        var2.ref_126a2 scriptmodelplayanim( "wz_infil_mindia8_loop_pl04", "p4" );
    }
    
    var2.bot_gametype_attacker_defender_ai_director_update hide();
    var2.bot_clear_hq_zone hide();
    thread ref_12520( level );
    
    if ( isdefined( var2.gas_triggers_init ) )
    {
        var2.gas_triggers_init waittillmatch( "camera", "end" );
    }
    
    thread ref_13f06( 1.2, var3 );
}

// Params 2
// Size: 0x31e
function ref_13cf1( var0, var1 )
{
    var2 = 65;
    var3 = 14;
    var4 = 35;
    var5 = 2;
    var6 = 4;
    
    if ( isdefined( var0.gas_triggers_init ) && isdefined( var0.gas_vfx_and_triggers ) )
    {
        var7 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
        
        foreach ( var9 in var7 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9 calloutmarkerping_getcreatedtime( 0 );
            
            if ( !isdefined( var9.infilanimindex ) )
            {
                var9.infilanimindex = 1;
            }
            
            if ( !isdefined( var9.stop_counter_beep_sfx_on_bomb_vests ) )
            {
                var9.stop_counter_beep_sfx_on_bomb_vests = 1;
            }
            
            var10 = scripts\engine\utility::ter_op( var9.stop_counter_beep_sfx_on_bomb_vests, var0.gas_triggers_init, var0.gas_vfx_and_triggers );
            var11 = "j_prop_1";
            var9 cameraunlink();
            var9 cameralinkto( var10, var11, 1, 1 );
            var9 setclientdvar( "QTSPTNLOL", var2 );
            var9 setclientdvar( "LTMOQONPQ", 0 );
            var9 setphysicaldepthoffield( var3, var4, var5, var6 );
        }
        
        thread health_remaining_max( var1 );
    }
    else
    {
        var7 = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.players );
        
        foreach ( var9 in var7 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9 calloutmarkerping_getcreatedtime( 0 );
        }
    }
    
    var2.playerpositionents[ "parent_solo" ] unlink();
    var2.playerpositionents[ "parent_squad" ] unlink();
    
    if ( isdefined( var2.ref_11dc3 ) )
    {
        var2.playerpositionents[ "parent_solo" ] linkto( var2.ref_11dc3, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.playerpositionents[ "parent_squad" ] linkto( var2.ref_11dc3, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var2.ref_11dc3 notify( "start_moving" );
    }
    
    setomnvar( "ui_hide_player_icons", 0 );
    var7 = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.players );
    
    foreach ( var9 in var7 )
    {
        if ( !isdefined( var9 ) )
        {
            continue;
        }
        
        var9 setclienttriggeraudiozone( "mp_island_infil_ext", 2 );
    }
    
    thread healthpack_health( var3 );
    
    if ( var2.infil_anim_type == "script_model" )
    {
        var2.playerslot1 scriptmodelplayanim( "wz_infil_skilo_squad_sdr01_loop", "p1" );
        var2.playerslot2 scriptmodelplayanim( "wz_infil_skilo_squad_sdr02_loop", "p2" );
        var2.playerslot3 scriptmodelplayanim( "wz_infil_skilo_squad_sdr03_loop", "p3" );
        var2.playerslot4 scriptmodelplayanim( "wz_infil_skilo_squad_sdr04_loop", "p4" );
    }
    
    thread ref_12766( level );
    
    if ( isdefined( var2.ref_11dc3.door ) )
    {
        var2.ref_11dc3.door scriptmodelplayanim( "wz_infil_skilo_single_door_loop", "plane", 0, 1 );
    }
    
    if ( isdefined( var2.gas_triggers_init ) )
    {
        var2.gas_triggers_init waittillmatch( "camera", "end" );
    }
    
    thread ref_13f06( 1.2, var3 );
}

// Params 2
// Size: 0xb6
function mp_m_speed_patch( var0, var1 )
{
    thread wires_on_bombs();
    stopfxontag( level._effect[ "vfx_br_ac130_clouds" ], var0.staticc130, "tag_body" );
    var0.staticc130 stoploopsound();
    
    if ( isdefined( var0.movingc130 ) )
    {
        var0.movingc130 playloopsound( "br_ac130_lp" );
    }
    
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 calloutmarkerping_getcreatedtime( 0 );
        var4 cameraunlink();
        var4 setclientdvar( "QTSPTNLOL", 65 );
        var4 disablephysicaldepthoffieldscripting();
        var4 scripts\mp\utility\player::setdof_default();
    }
    
    thread ref_138f3( level, var0 );
}

// Params 2
// Size: 0xa0
function mp_m_trench_patch_giveplayer_c4( var0, var1 )
{
    var0.chopper stoploopsound();
    
    if ( isdefined( var0.ref_11dbf ) )
    {
        var0.ref_11dbf playloopsound( "br_heli_infil_hero_lp" );
    }
    
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 calloutmarkerping_getcreatedtime( 0 );
        var4 cameraunlink();
        var4 setclientdvar( "QTSPTNLOL", 65 );
        var4 setclientdvar( "LTMOQONPQ", 0 );
        var4 disablephysicaldepthoffieldscripting();
        var4 scripts\mp\utility\player::setdof_default();
    }
    
    thread ref_138f3( level, var0 );
}

// Params 2
// Size: 0x9b
function neverspectate( var0, var1 )
{
    thread wires_on_bombs();
    var0.ref_13886 stoploopsound();
    
    if ( isdefined( var0.ref_11dc3 ) )
    {
        var0.ref_11dc3 playloopsound( "br_infil_skilo_plane_lp" );
    }
    
    var2 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 calloutmarkerping_getcreatedtime( 0 );
        var4 cameraunlink();
        var4 setclientdvar( "QTSPTNLOL", 65 );
        var4 disablephysicaldepthoffieldscripting();
        var4 scripts\mp\utility\player::setdof_default();
    }
    
    thread ref_138f3( level, var0 );
}

// Params 1
// Size: 0x2b
function stop_hotjoining( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        stop_firing_minigun( var0 );
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        stop_module_on_delay( var0 );
        return;
    }
    
    stop_eye_barkov( var0 );
}

// Params 1
// Size: 0x59
function stop_eye_barkov( var0 )
{
    var1 = level._effect[ "vfx_br_ac130_clouds" ];
    var2 = level._effect[ "vfx_br_ac130_oneshot" ];
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        var1 = level._effect[ "vfx_snatch_ac130_clouds" ];
    }
    
    if ( isdefined( var1 ) )
    {
        stopfxontag( var1, var0, "tag_body" );
    }
    
    if ( isdefined( var2 ) )
    {
        stopfxontag( var2, var0, "tag_body" );
        return;
    }
}

// Params 1
// Size: 0x4
function stop_firing_minigun( var0 )
{
    
}

// Params 1
// Size: 0x4
function stop_module_on_delay( var0 )
{
    
}

// Params 1
// Size: 0x5a
function playac130infilloopanims( var0 )
{
    if ( isdefined( var0.movingc130 ) )
    {
        var0.movingc130 scriptmodelplayanim( "sdr_mp_infil_ac130_loop2_plane", "plane" );
        var0.movingc130.innards scriptmodelplayanim( "sdr_mp_infil_ac130_loop2_plane", "planeInnards" );
    }
    
    var0.playerpositionents[ "parent" ] scriptmodelplayanim( "sdr_mp_infil_ac130_loop_genpropx10", "prop" );
}

// Params 1
// Size: 0x90
function ref_12766( var0 )
{
    if ( isdefined( var0.ref_11dc3 ) )
    {
        var0.ref_11dc3 scriptmodelplayanim( "wz_infil_skilo_loop_veh", "plane" );
        var0.ref_11dc3.bunker_numberstation scriptmodelplayanim( "wz_infil_skilo_loop_veh", "plane" );
        var0.ref_11dc3.innards scriptmodelplayanim( "wz_infil_skilo_loop_veh", "planeInnards" );
    }
    
    var0.playerpositionents[ "parent_solo" ] scriptmodelplayanim( "wz_infil_skilo_loop_genpropx10", "prop" );
    var0.playerpositionents[ "parent_squad" ] scriptmodelplayanim( "wz_infil_skilo_loop_genpropx10", "prop" );
}

// Params 1
// Size: 0x75
function ref_12520( var0 )
{
    if ( isdefined( var0.ref_11dbf ) )
    {
        var0.ref_11dbf scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "plane" );
        var0.ref_11dbf.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "planeInnards" );
    }
    
    var0.playerpositionents[ "parent_solo" ] scriptmodelplayanim( "wz_infil_mindia8_loop_genpropx10", "prop" );
    var0.playerpositionents[ "parent_squad" ] scriptmodelplayanim( "wz_infil_mindia8_loop_genpropx10", "prop" );
}

// Params 1
// Size: 0x65
function infiloverridevisionset( var0 )
{
    foreach ( var2 in var0 )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        if ( var2.operatorcustomization.operatorref == "s4_palmer" || var2.operatorcustomization.operatorref == "s4_doggett" )
        {
            var2 visionsetnakedforplayer( "wz_tu345_te" );
        }
    }
}

// Params 1
// Size: 0x62
function infilhandleterminusoutlines( var0 )
{
    foreach ( var2 in var0 )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        if ( var2.operatorcustomization.operatorref == "s4_palmer" || var2.operatorcustomization.operatorref == "s4_doggett" )
        {
            thread infildoterminusoutlines();
        }
    }
}

// Params 0
// Size: 0xac
function infildoterminusoutlines()
{
    self endon( "disconnect" );
    var0 = scripts\mp\utility\player::getteamarray( self.team, 1 );
    var1 = undefined;
    
    foreach ( var3 in var0 )
    {
        if ( isdefined( var3.infilanimindex ) && var3.infilanimindex == 1 )
        {
            var1 = var3;
            break;
        }
    }
    
    if ( isdefined( var1 ) )
    {
        var1 hudoutlineenableforclient( self, "outline_terminus" );
    }
    
    wait 0.75;
    
    if ( isdefined( var1 ) )
    {
        var1 hudoutlinedisableforclient( self );
    }
    
    wait 8.25;
    var5 = scripts\engine\utility::random( var0 );
    
    if ( isdefined( var5 ) )
    {
        var5 hudoutlineenableforclient( self, "outline_terminus" );
    }
    
    wait 0.75;
    
    if ( isdefined( var5 ) )
    {
        var5 hudoutlinedisableforclient( self );
        return;
    }
}

// Params 2
// Size: 0x22
function infilsetupterminusbink( var0, var1 )
{
    wait var1;
    infilpreloadterminusbink( var0 );
    infilplayterminusbink( var0 );
    wait 1;
    infilhandleterminusoutlines( var0 );
}

// Params 1
// Size: 0x65
function infilpreloadterminusbink( var0 )
{
    foreach ( var2 in var0 )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        if ( var2.operatorcustomization.operatorref == "s4_palmer" || var2.operatorcustomization.operatorref == "s4_doggett" )
        {
            var2 skydive_cutparachuteon( "mp_terminus_vision" );
        }
    }
}

// Params 1
// Size: 0x65
function infilplayterminusbink( var0 )
{
    foreach ( var2 in var0 )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        if ( var2.operatorcustomization.operatorref == "s4_palmer" || var2.operatorcustomization.operatorref == "s4_doggett" )
        {
            var2 preloadcinematicforplayer( "mp_terminus_vision" );
        }
    }
}

// Params 3
// Size: 0x49
function stoparmorinsert( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    if ( !isdefined( var0 ) )
    {
        preloadcinematicforall( var1, 0, var2 );
        return;
    }
    
    foreach ( var4 in var0 )
    {
        if ( isdefined( var4 ) )
        {
            var4 skydive_cutparachuteon( var1, 0, var2 );
        }
    }
}

// Params 5
// Size: 0x36b
function stop_with_front_truck( var0, var1, var2, var3, var4 )
{
    var5 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    var6 = level.players.size == var5.size;
    
    if ( var6 )
    {
        setglobalsoundcontext( "lobby_fade", "", 2 );
    }
    
    foreach ( var8 in var5 )
    {
        if ( !isdefined( var8 ) )
        {
            continue;
        }
        
        if ( !var6 )
        {
            var8 setentitysoundcontext( "lobby_fade", "", 2 );
        }
        
        if ( !isdefined( var4 ) )
        {
            var4 = "";
        }
        
        switch ( var4 )
        {
            case "s2":
                var8 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                var8 clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
                break;
            case "infil_dov_part1":
                var8 playlocalsound( "br_infil_part1_lr" );
                var8 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                var8 clearsoundsubmix( "fade_to_black_all_except_music", 0.5 );
                var8 setsoundsubmix( "mp_br_event_dovp1_infil", 0.5 );
                break;
            case "chopper_infil":
                var8 playlocalsound( "br_heli_infil_part1_lr" );
                var8 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                var8 clearsoundsubmix( "fade_to_black_all_except_music", 0.5 );
                var8 setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
                break;
            case "skilo_infil":
                var8 playlocalsound( "br_infil_ch3_plane_intro_lr" );
                var8 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                var8 clearsoundsubmix( "fade_to_black_all_except_music", 0.5 );
                var8 setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
                break;
            case "skilo_infil_mxp":
                var8 playlocalsound( "br_infil_ch3_mxp_plane_intro_lr" );
                var8 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                var8 clearsoundsubmix( "fade_to_black_all_except_music", 0.5 );
                var8 setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
                break;
            case "terminus_infil":
                var8 playlocalsound( "br_infil_ch3_t2_plane_intro_lr" );
                var8 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                var8 clearsoundsubmix( "fade_to_black_all_except_music", 0.5 );
                var8 setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
                break;
            default:
                var8 playlocalsound( "br_infil_part1_lr" );
                var8 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                var8 clearsoundsubmix( "fade_to_black_all_except_music", 0.5 );
                var8 setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
                break;
        }
    }
    
    var2 = var2 || istrue( level.vehicle_collision_getleveldata );
    
    if ( var6 )
    {
        if ( istrue( level.vehicle_collision_getleveldata ) || var2 )
        {
            playcinematicforall( var1, 1, 1 );
        }
        else
        {
            playcinematicforall( var1 );
        }
    }
    else
    {
        foreach ( var8 in var5 )
        {
            if ( !isdefined( var8 ) )
            {
                continue;
            }
            
            if ( istrue( level.vehicle_collision_getleveldata ) || var2 )
            {
                var8 preloadcinematicforplayer( var1, 1, 1 );
                continue;
            }
            
            var8 preloadcinematicforplayer( var1 );
        }
    }
    
    var12 = 3;
    
    if ( getdvarint( "scr_br_c130_intro_s2", 0 ) == 1 )
    {
        var12 = 9;
    }
    else if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        var12 = 11;
    }
    else if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        if ( getdvarint( "scr_br_infil_skilo_use_skilo_infil_overlay", 1 ) == 0 )
        {
            var12 = 11;
        }
        else
        {
            var12 = 13;
        }
    }
    else if ( istrue( var3 ) )
    {
        var12 = 10;
    }
    
    foreach ( var8 in var5 )
    {
        if ( !isdefined( var8 ) )
        {
            continue;
        }
        
        if ( !istrue( var8.watch_for_usb_notetrack_switchoff ) )
        {
            var8 setclientomnvar( "ui_br_bink_overlay_state", var12 );
        }
    }
}

// Params 2
// Size: 0x4a
function getboltmodel( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 setclientomnvar( "ui_br_bink_overlay_state", var1 );
    }
}

// Params 2
// Size: 0x21
function stop_spawn_modules( var0, var1 )
{
    if ( var0 == "bink_complete" )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 5 );
        self skydive_cutparachuteoff();
        return;
    }
}

// Params 2
// Size: 0x26
function stop_vehicle_on_pilot_death( var0, var1 )
{
    if ( var0 == "bink_complete" )
    {
        wait 0.6;
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
        self skydive_cutparachuteoff();
        return;
    }
}

// Params 2
// Size: 0x20
function stop_wave_section( var0, var1 )
{
    if ( var0 == "bink_complete" )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
        self skydive_cutparachuteoff();
        return;
    }
}

// Params 1
// Size: 0x126
function stopchallengetimer( var0 )
{
    if ( getdvarint( "scr_br_c130_intro_s2", 0 ) == 1 )
    {
        scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &stop_spawn_modules );
    }
    else if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &stop_vehicle_on_pilot_death );
    }
    else
    {
        scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &stop_wave_section );
    }
    
    var1 = undefined;
    
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        var1 = 4.95;
    }
    else if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        var1 = 7.23;
    }
    else
    {
        var1 = 3.2;
    }
    
    if ( istrue( level.vehicle_collision_getleveldata ) )
    {
        var1 = 4.6;
    }
    else if ( getdvarint( "scr_br_c130_intro_s2", 0 ) == 1 )
    {
        var1 = 36;
    }
    
    wait var1;
    var2 = scripts\engine\utility::ter_op( isdefined( var0 ), var0, level.players );
    
    if ( isdefined( level.ref_133b4 ) )
    {
        level.ref_133b4 = undefined;
    }
    
    foreach ( var4 in var2 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 notify( "beginC130" );
    }
    
    if ( isdefined( level.throwingknives ) )
    {
        foreach ( var7 in level.throwingknives )
        {
            if ( isdefined( var7 ) )
            {
                var7 thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_deletepickup();
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x1c2
function setup_jugg_maze_kill_trigger()
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        self setmodel( "veh8_mil_air_mindia8_open_back_infil" );
        self notsolid();
        self.innards setmodel( "veh8_mil_air_mindia8_interior_vm_infil" );
        self.innards notsolid();
        self.playeroffsets = [ ( 32, 30, -500 ), ( -32, 30, -500 ), ( 0, 30, -500 ), ( 16, 30, -500 ), ( -16, 30, -500 ) ];
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        self setmodel( "veh8_mil_air_skilo_infil_flight" );
        self notsolid();
        self.innards setmodel( "veh8_mil_air_skilo_interior_vm_infil" );
        self.innards notsolid();
        self.playeroffsets = [ ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ) ];
        self.bunker_numberstation = spawn( "script_model", self.origin );
        self.bunker_numberstation setmodel( "veh8_mil_air_skilo_infil_flight_articulated" );
        self.bunker_numberstation linkto( self, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self.bunker_numberstation.cleanme = 1;
        self.door = spawn( "script_model", self.origin );
        self.door setmodel( "veh8_mil_air_skilo_interior_infil_cabin_door" );
        self.door linkto( self.bunker_numberstation, "TAG_DOOR", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self.door.cleanme = 1;
        return;
    }
    
    self notsolid();
    
    if ( isdefined( self.innards ) )
    {
        self.innards notsolid();
        return;
    }
}

// Params 2
// Size: 0x92
function setup_last_enemies_standing( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self hide();
    
    if ( isdefined( self.innards ) )
    {
        self.innards hide();
    }
    
    self waittill( "start_moving" );
    self show();
    
    if ( isdefined( self.innards ) )
    {
        self.innards show();
    }
    
    self moveto( var0, var1 );
    thread scripts\mp\gametypes\br_c130::killaftertime( var1, "c130" );
    
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        self playloopsound( "br_heli_infil_hero_lp" );
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        self playloopsound( "br_ac130_lp" );
        return;
    }
    
    thread scripts\mp\gametypes\br_public::gunship_spawnvfx();
    self playloopsound( "br_ac130_lp" );
}

// Params 1
// Size: 0x2e
function remove_outline( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        return var0.chopper;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        return var0.ref_13886;
    }
    
    return var0.staticc130;
}

// Params 1
// Size: 0x2e
function remove_objective_on_flag( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        return var0.ref_11dbf;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        return var0.ref_11dc3;
    }
    
    return var0.movingc130;
}

// Params 1
// Size: 0x2e
function remove_munitions_in_radius( var0 )
{
    if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
    {
        return var0.gas_triggers_init;
    }
    
    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        return var0.gas_triggers_init;
    }
    
    return var0.gas_trigger;
}

// Params 3
// Size: 0x574
function clear_tier_lights( var0, var1, var2 )
{
    level endon( "game_ended" );
    var3 = scripts\engine\utility::ter_op( isdefined( var2 ), var2, level.players );
    
    if ( !scripts\mp\gametypes\br_public::usefailcapacitymsg() )
    {
        foreach ( var5 in var3 )
        {
            if ( !isdefined( var5 ) )
            {
                continue;
            }
            
            var5 calloutmarkerping_getcreatedtime( -1 );
        }
    }
    
    level.infilstruct = spawnstruct();
    level.infilstruct.playersinc130 = 0;
    
    if ( !isdefined( var0 ) )
    {
        var0 = scripts\mp\gametypes\br_c130::createtestc130path();
    }
    
    level.infilstruct.c130pathstruct = var0;
    level.infilstruct.transporttime = scripts\mp\gametypes\br_c130::spawnc130( level.infilstruct.c130pathstruct, &setup_last_enemies_standing, &setup_jugg_maze_kill_trigger );
    level.infilstruct.firstc130endtime = level.infilstruct.transporttime + gettime();
    var7 = firespoutwatch( level.br_ac130, var1 );
    level.watch_for_total_counts_below_num = var7;
    
    if ( isdefined( level.ref_12852 ) )
    {
        [[ level.ref_12852 ]]( var7 );
    }
    
    level.stop_end_breach_fx = 1;
    level.allowprematchdamage = 0;
    thread gunship_updateplayercount();
    var8 = remove_outline( var7 );
    var9 = 0;
    var10 = 0;
    
    if ( getdvarint( "scr_br_c130_intro_s2", 0 ) == 1 )
    {
        var10 = 1;
        ref_13cf0( var3, "player", var8, 1 );
        stoparmorinsert( var3, "mp_donetsk_c130_intro_s2" );
        stop_with_front_truck( var3, "mp_donetsk_c130_intro_s2", var9, 0, "s2" );
        stopchallengetimer( var3 );
        var11 = game[ "music" ][ "br_infil_intro" ].size;
        var12 = randomint( var11 );
        var3 = scripts\engine\utility::ter_op( isdefined( var2 ), var2, level.players );
        
        foreach ( var5 in var3 )
        {
            var5 setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 0.5 );
            var5 setplayermusicstate( game[ "music" ][ "br_infil_intro" ][ var12 ] );
        }
    }
    else if ( scripts\mp\utility\game::round_vehicle_logic() == "reveal" )
    {
        ref_13cf0( var3, var1, var8, 0 );
        var15 = undefined;
        var16 = 0;
        
        if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
        {
            var15 = "mp_donetsk_mindia8_intro";
            var16 = 1;
        }
        else if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
        {
            var15 = "mp_wz_island_plane_intro";
        }
        else
        {
            var15 = "mp_donetsk_c130_intro";
        }
        
        stoparmorinsert( var3, var15 );
        stop_with_front_truck( var3, var15, var9, var16, "infil_dov_part1" );
        stopchallengetimer( var3 );
    }
    else if ( scripts\mp\utility\game::round_vehicle_logic() == "mendota" )
    {
        ref_13cf0( var8, var3, var10, 0 );
        var15 = "mendota_infil_intro";
        var16 = 0;
        var17 = "skilo_infil_mxp";
        var15 = 1;
        stoparmorinsert( var8, var15 );
        stop_with_front_truck( var8, var15, var15, var16, var17 );
        stopchallengetimer( var8 );
    }
    else if ( scripts\mp\utility\game::round_vehicle_logic() == "tdbd" )
    {
        ref_13cf0( var15, var9, var15, 0 );
        var15 = "mp_wz_tdbd_plane_intro";
        var16 = 0;
        var17 = "skilo_infil";
        var16 = 0;
        
        if ( getdvarint( "scr_terminus_infil_override", 0 ) == 1 )
        {
            infiloverridevisionset( var15 );
        }
        
        stoparmorinsert( var15, var15 );
        stop_with_front_truck( var15, var15, var16, var16, "terminus_infil" );
        stopchallengetimer( var15 );
    }
    else
    {
        ref_13cf0( var16, var16, var15, 0 );
        var15 = undefined;
        var16 = 0;
        var17 = undefined;
        
        if ( getdvarint( "scr_terminus_infil_override", 0 ) == 1 )
        {
            infiloverridevisionset( var16 );
        }
        
        if ( scripts\mp\gametypes\br_public::tv_station_intro_already_played() )
        {
            if ( scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent() )
            {
                var15 = "mp_escape_mindia8_intro";
            }
            else
            {
                var15 = "mp_donetsk_mindia8_intro";
            }
            
            var16 = 1;
            var17 = "chopper_infil";
        }
        else if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
        {
            var15 = "mp_wz_island_plane_intro";
            var17 = "skilo_infil";
        }
        else
        {
            var15 = "mp_donetsk_c130_intro";
        }
        
        var15 = getfixedinfilname( var15 );
        stoparmorinsert( var16, var15 );
        stop_with_front_truck( var16, var15, var16, var16, var17 );
        stopchallengetimer( var16 );
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() || scripts\mp\gametypes\br_public::uniquelootcallbacks() )
    {
        var16 = scripts\engine\utility::ter_op( isdefined( var15 ), var15, level.players );
        
        foreach ( var5 in var16 )
        {
            if ( isdefined( var5 ) && isplayer( var5 ) )
            {
                var5 notify( "play_intro" );
            }
        }
    }
    
    if ( var17 )
    {
        getboltmodel( var16, 0 );
    }
    
    var20 = remove_munition_on_use();
    var21 = var20[ 0 ];
    var22 = var20[ 1 ];
    var20 = undefined;
    thread infilallfadetoblack( level, 0, var21, var22, undefined );
    
    if ( getdvarint( "scr_terminus_infil_override", 0 ) == 1 )
    {
        thread infilsetupterminusbink( level, var16 );
    }
    
    ref_1273c( var17, var15 );
    var16 = scripts\engine\utility::ter_op( isdefined( var15 ), var15, level.players );
    ref_13cee( var16, var16 );
    level.stop_end_breach_fx = 0;
    level.infilstruct.infil_anim_type = var16;
    
    if ( isdefined( level.obit_activation ) )
    {
        level thread scripts\mp\gametypes\br_alt_mode_escape::obj_fob2( var15 );
    }
    else
    {
        thread scripts\mp\gametypes\br_gametypes::ref_12e05( "onInfilSequenceEnd", var15 );
        
        if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "match_start_VO" ) )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "match_start", 0, var15 );
        }
    }
    
    var23 = scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid();
    
    if ( !var23 )
    {
        var24 = getdvar( "scr_br_lateSpawnFallback" ) == "";
        var16 = scripts\engine\utility::ter_op( isdefined( var15 ), var15, level.players );
        
        foreach ( var5 in var16 )
        {
            thread playerjoininfil();
            
            if ( var5 calloutmarkerping_getent() )
            {
                ref_12b22( var5 );
            LOC_00000537:
            }
        LOC_00000537:
        }
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "addToC130Infil" ) )
        {
            level.br_ac130 scripts\mp\gametypes\br_gametypes::ref_12e05( "addToC130Infil" );
        }
    }
    
    if ( isdefined( level.showexfilstartsplash ) )
    {
        thread showextractionobjectivetoteam();
        return;
    }
}

// Params 1
// Size: 0x66
function getfixedinfilname( var0 )
{
    if ( istrue( level.vehicle_collision_getleveldata ) )
    {
        var0 = "mp_donetsk_c130_intro_x1";
    }
    else if ( scripts\cp_mp\utility\game_utility::turretlightsonstate() )
    {
        var0 = "ta_gov_inf";
    }
    else if ( level.mapname == "mp_kstenod" || scripts\mp\utility\game::round_vehicle_logic() == "zxp" )
    {
        var0 = "mp_donetsk_c130_intro_zxp";
    }
    else if ( level.mapname == "mp_don4_pm" )
    {
        var0 = "ta_gov_inf";
    }
    
    return var0;
}

// Params 1
// Size: 0x6b
function ref_1324e( var0 )
{
    var0.x = 0;
    var0.y = 0;
    var0 setshader( "black", 640, 480 );
    var0.alignx = "left";
    var0.aligny = "top";
    var0.horzalign = "fullscreen";
    var0.vertalign = "fullscreen";
    var0.sort = -1;
    var0 sendcollectedclientanticheatdata( 1 );
}

// Params 6
// Size: 0x3d8
function infilallfadetoblack( var0, var1, var2, var3, var4, var5 )
{
    if ( !isdefined( var5 ) )
    {
        var5 = 0;
    }
    
    var6 = scripts\engine\utility::ter_op( isdefined( var4 ), var4, level.players );
    var7 = level.players.size == var6.size;
    
    if ( var7 && !isdefined( level.infilblackoverlay ) )
    {
        level.infilblackoverlay = newhudelem();
        ref_1324e( level.infilblackoverlay );
    }
    else if ( !var7 )
    {
        foreach ( var9 in var6 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            var9.infilblackoverlay = newclienthudelem( var9 );
            ref_1324e( var9.infilblackoverlay );
        }
    }
    
    if ( isdefined( var0 ) && var0 > 0 )
    {
        var6 = scripts\engine\utility::ter_op( isdefined( var4 ), var4, level.players );
        
        foreach ( var9 in var6 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            if ( !var5 )
            {
                var9 setsoundsubmix( "iw8_br_infil_fadeout", 0 );
                
                if ( !istrue( level.vehicle_collision_getleveldata ) && !isdefined( level.ref_12d05 ) )
                {
                    var9 setsoundsubmix( "mp_br_infil_music", 0 );
                }
            }
            
            if ( !var7 )
            {
                var9.infilblackoverlay.alpha = 0;
                var9.infilblackoverlay fadeovertime( var0 );
                var9.infilblackoverlay.alpha = 1;
            }
        }
        
        if ( var7 )
        {
            level.infilblackoverlay.alpha = 0;
            level.infilblackoverlay fadeovertime( var2 );
            level.infilblackoverlay.alpha = 1;
        }
        
        wait var0;
    }
    
    if ( !scripts\mp\gametypes\br_public::isusinginfilselection() )
    {
        if ( var7 )
        {
            level.infilblackoverlay.alpha = 1;
        }
        
        var6 = scripts\engine\utility::ter_op( isdefined( var4 ), var4, level.players );
        
        foreach ( var9 in var6 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            if ( !var5 )
            {
                var9 setsoundsubmix( "mp_br_infil_anim", 0 );
                var9 setsoundsubmix( "mp_br_infil_ac130", 0 );
            }
            
            if ( !var7 )
            {
                var9.infilblackoverlay.alpha = 1;
            }
        }
    }
    
    if ( isdefined( var3 ) )
    {
        level waittill( var3 );
    }
    
    if ( isdefined( var1 ) && var1 > 0 )
    {
        wait var1;
    }
    
    if ( isdefined( var2 ) && var2 > 0 )
    {
        if ( var7 )
        {
            level.infilblackoverlay.alpha = 1;
            level.infilblackoverlay fadeovertime( var2 );
            level.infilblackoverlay.alpha = 0;
        }
        
        var6 = scripts\engine\utility::ter_op( isdefined( var4 ), var4, level.players );
        
        foreach ( var9 in var6 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            if ( !var5 )
            {
                if ( !scripts\mp\gametypes\br_public::isusinginfilselection() )
                {
                    if ( scripts\mp\gametypes\br_public::usefailcapacitymsg() )
                    {
                        var9 setclienttriggeraudiozone( "mp_island_infil_int", var2 );
                    }
                    else
                    {
                        var9 setclienttriggeraudiozone( "mp_donetsk_infil_int", var2 );
                    }
                }
                
                var9 clearsoundsubmix( "iw8_br_infil_fadeout", 2 );
                var9 clearsoundsubmix( "deaths_door_mp" );
            }
            
            if ( !var7 )
            {
                var9.infilblackoverlay.alpha = 1;
                var9.infilblackoverlay fadeovertime( var2 );
                var9.infilblackoverlay.alpha = 0;
            }
        }
        
        wait var2;
    }
    else if ( !var5 )
    {
        var6 = scripts\engine\utility::ter_op( isdefined( var4 ), var4, level.players );
        
        foreach ( var9 in var6 )
        {
            if ( !isdefined( var9 ) )
            {
                continue;
            }
            
            if ( !scripts\mp\gametypes\br_public::isusinginfilselection() )
            {
                var9 setclienttriggeraudiozone( "mp_donetsk_infil_int" );
            }
            
            var9 clearsoundsubmix( "iw8_br_infil_fadeout", 2 );
            var9 clearsoundsubmix( "deaths_door_mp" );
        }
    }
    
    if ( var7 )
    {
        level.infilblackoverlay.alpha = 0;
        return;
    }
    
    var6 = scripts\engine\utility::ter_op( isdefined( var4 ), var4, level.players );
    
    foreach ( var9 in var6 )
    {
        if ( !isdefined( var9 ) )
        {
            continue;
        }
        
        if ( isdefined( var9.infilblackoverlay ) )
        {
            var9.infilblackoverlay destroy();
        }
        
        var9.infilblackoverlay = undefined;
    }
}

// Params 1
// Size: 0xdf
function ref_12acc( var0 )
{
    var1 = 0;
    var2 = isdefined( var0 ) && var0.size != level.players.size;
    
    foreach ( var4 in level.teamnamelist )
    {
        var5 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic( var4 );
        
        for ( var6 = 0; var6 < var5.size ; var6++ )
        {
            var7 = var5[ var6 ];
            var8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var4, var7 );
            
            foreach ( var10 in var8 )
            {
                if ( var2 && !scripts\engine\utility::array_contains( var0, var10 ) )
                {
                    continue;
                }
                
                var10 playerhide();
                
                if ( !var1 )
                {
                    foreach ( var12 in var8 )
                    {
                        var10 showtoplayer( var12 );
                    }
                }
            }
        }
    }
}

// Params 4
// Size: 0x1b1
function ref_13cf0( var0, var1, var2, var3 )
{
    foreach ( var5 in var0 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        scripts\mp\utility\game::ref_131a3( var5, 1 );
        var5 scripts\mp\utility\player::hidehudenable();
        var5 scripts\mp\class::computerrebootsequence_init();
    }
    
    scripts\mp\deathicons::ref_12bfd();
    setomnvar( "ui_hide_player_icons", 1 );
    thread infilallfadetoblack( 1, 3.5, 1, "prematch_respawn_finished", var0, var3 );
    
    foreach ( var5 in var0 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 predictstreampos( var2.origin, 1 );
    }
    
    level.stop_visited_once = 1;
    ref_14361( 1 );
    waitframe();
    scripts\mp\gametypes\br_vehicles::emptyallvehicles();
    setomnvar( "ui_in_infil", 1 );
    scripts\mp\flags::gameflagset( "prematch_fade_done" );
    
    foreach ( var5 in var0 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 playerhide();
    }
    
    ref_1435f( var0, var2.origin, var2 );
    level notify( "prematch_respawn_finished" );
    ref_14361( 3.5 );
    
    foreach ( var5 in var0 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 clearpredictedstreampos();
        neurotoxin_damage_loop( var5 );
        var5.delay_explosion_fx = 1;
    }
    
    if ( var1 == "script_model" )
    {
        foreach ( var5 in var0 )
        {
            if ( !isdefined( var5 ) )
            {
                continue;
            }
            
            var5 playerhide();
        }
        
        return;
    }
    
    ref_12acc( var0 );
}

// Params 2
// Size: 0x8b
function ref_13cee( var0, var1 )
{
    var2 = var1 == "script_model";
    
    foreach ( var4 in var0 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var4 scripts\mp\class::ref_13f02();
        var4.instantclassswapallowed = 1;
        
        if ( scripts\mp\gametypes\br::get_int_or_0( var4.hidehudenabled ) > 0 )
        {
            var4 scripts\mp\utility\player::hidehuddisable();
        }
        
        var4 visionsetfadetoblackforplayer( "", 1 );
        
        if ( var2 )
        {
            var4 playershow();
        }
    }
    
    setomnvar( "ui_in_infil", -1 );
    level.stop_visited_once = undefined;
}

// Params 0
// Size: 0x3f
function gunship_updateplayercount()
{
    level endon( "game_ended" );
    self notify( "ac130_player_count" );
    self endon( "ac130_player_count" );
    
    for ( ;; )
    {
        setomnvar( "ui_br_players_left_in_plane", level.infilstruct.playersinc130 );
        
        if ( !isdefined( self ) )
        {
            break;
        }
        
        wait 0.5;
    }
}

// Params 0
// Size: 0x6b
function playerjoininfil()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "joining_Infil" );
    var0 = self;
    var0.br_infilstarted = 1;
    var0.health = var0.maxhealth;
    var0 scripts\mp\gametypes\br_c130::spawnplayertoc130();
    playersetupcontrolsforinfil( var0 );
    var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "isInInfilPlane", 1 );
    level.infilstruct.playersinc130++;
    var0 scripts\mp\gametypes\br_public::ref_1264d();
    thread ref_12525();
}

// Params 0
// Size: 0x5c
function ref_12525()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "cancel_c130" );
    self endon( "br_jump" );
    self waittill( "disconnect" );
    
    if ( isdefined( level.infilstruct ) && isdefined( level.infilstruct.playersinc130 ) && level.infilstruct.playersinc130 > 0 )
    {
        level.infilstruct.playersinc130--;
        return;
    }
}

// Params 1
// Size: 0x67
function playersetupcontrolsforinfil( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 0;
    }
    
    self setclientomnvar( "ui_br_infil_started", 1 );
    self setclientomnvar( "ui_br_infiled", 0 );
    
    if ( !var0 )
    {
        self notifyonplayercommand( "halo_jump_c130", "+gostand" );
    }
    else
    {
        self notifyonplayercommand( "halo_jump_solo_c130", "+gostand" );
    }
    
    self notifyonplayercommand( "br_pass_squad_leader", "+usereload" );
    self notifyonplayercommand( "br_pass_squad_leader", "+activate" );
}

// Params 0
// Size: 0x2
function getlightingvalues()
{
    
}

// Params 0
// Size: 0x2
function within_points()
{
    
}

// Params 0
// Size: 0x2
function wires_on_bombs()
{
    
}

// Params 0
// Size: 0x19
function initinfillocationselectionhandlers()
{
    registerinfillocationselectionhandler( "exclusion", &handleexclusionils, &spawnselectionbegin, &spawnselectionend );
}

// Params 1
// Size: 0x2f
function handleinfillocationselection( var0 )
{
    var1 = self;
    var2 = level.infilselectionmethod;
    var3 = getinfillocationselectionfunc( var2 );
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    return var1 [[ var3 ]]( var0.location, var0.angles );
}

// Params 4
// Size: 0x3f
function registerinfillocationselectionhandler( var0, var1, var2, var3 )
{
    if ( !isdefined( level.br_infillocationselectionhandlers ) )
    {
        level.br_infillocationselectionhandlers = [];
    }
    
    var4 = spawnstruct();
    var4.locationselectionfunc = var1;
    var4.spawnselectstartfunc = var2;
    var4.spawnselectendfunc = var3;
    level.br_infillocationselectionhandlers[ var0 ] = var4;
}

// Params 1
// Size: 0x27
function getinfillocationselectionfunc( var0 )
{
    if ( !isdefined( level.br_infillocationselectionhandlers ) )
    {
        return undefined;
    }
    
    var1 = level.br_infillocationselectionhandlers[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return undefined;
    }
    
    return var1.locationselectionfunc;
}

// Params 2
// Size: 0x140
function handleexclusionils( var0, var1 )
{
    var2 = self;
    
    if ( !istrue( level.get_bomb_interaction_ent_cut_hint ) && !istrue( var2.issquadleader ) )
    {
        return 0;
    }
    
    var3 = getspawnselectionpoi( var0 );
    var4 = var3[ 0 ];
    var5 = var3[ 1 ];
    var3 = undefined;
    var6 = getspawnselectionexclusionsize( var0, var4, var5 );
    
    if ( isdefined( var2.team ) )
    {
        var7 = scripts\mp\utility\player::getteamarray( var2.team );
        var6 *= var7.size;
    }
    
    if ( istrue( level.get_bomb_interaction_ent_cut_hint ) && !istrue( var2.issquadleader ) )
    {
        return setuplocalelocation( var2, var0, var1, var6 );
    }
    
    foreach ( var9 in level.br_spawns )
    {
        var10 = round_logic( var2 );
        
        if ( isdefined( var10 ) && var9 == var10 )
        {
            if ( level.get_bomb_interaction_ent_cut_hint )
            {
                if ( getquickdropplundercount( var2, var9, var6, var0, 1 ) )
                {
                    return 1;
                }
            }
            
            continue;
        }
        else if ( level.get_bomb_interaction_ent_cut_hint )
        {
            if ( !getquickdropplundercount( var2, var9, var6, var0, 0 ) )
            {
                return 0;
            }
        }
        
        if ( pow( var6 + var9.spawnexclusion2ddist, 2 ) > distance2dsquared( var9.locationorigin, var0 ) )
        {
            thread sendplayerstatusmessage( var2, 50 );
            var2 playlocalsound( "br_map_selection_error" );
            return 0;
        }
    }
    
    return registerspawnlocation( var2, var0, var1, var6 );
}

// Params 3
// Size: 0xd7
function setuplocalelocation( var0, var1, var2 )
{
    var3 = self;
    
    foreach ( var5 in level.br_spawns )
    {
        var6 = round_logic();
        var7 = 0;
        
        if ( isdefined( var6 ) && var5 == var6 )
        {
            var7 = 1;
        }
        
        if ( pow( var2 + var5.spawnexclusion2ddist, 2 ) > distance2dsquared( var5.locationorigin, var0 ) )
        {
            if ( var7 )
            {
                var8 = roof_spawners( var3 );
                lastlocationcallouttime( var8 );
                thread sendplayerstatusmessage( var3, 56 );
                var3 playlocalsound( "br_map_selection_placed" );
                return 1;
            }
            
            thread sendplayerstatusmessage( var4, 50 );
            var4 playlocalsound( "br_map_selection_error" );
            return 0;
        }
        
        if ( var9 && getquickdropplundercount( var4, var6, var3, var1, var9 ) )
        {
            return 1;
        }
    }
    
    var5 = undefined;
    var8 = undefined;
    return registerspawnlocation( var4, var1, var2, var3 );
}

// Params 4
// Size: 0x115
function getquickdropplundercount( var0, var1, var2, var3 )
{
    var4 = self;
    
    foreach ( var6 in var0.ref_134cc )
    {
        if ( !isdefined( var6 ) )
        {
            continue;
        }
        
        var7 = roof_spawners( var4 );
        
        if ( isdefined( var7 ) && var6 == var7 )
        {
            continue;
        }
        
        if ( pow( var1 + var6.spawnexclusion2ddist, 2 ) > distance2dsquared( var6.locationorigin, var2 ) )
        {
            if ( !var3 )
            {
                thread sendplayerstatusmessage( var4, 50 );
                var4 playlocalsound( "br_map_selection_error" );
                return 0;
            }
            
            var2 = var6.locationorigin;
            var8 = var6.locationangles;
            var1 = var6.spawnexclusion2ddist;
            
            if ( isdefined( var7 ) && isdefined( var7.circleent ) )
            {
                var7.circleent delete();
            }
            
            var9 = registerspawnlocation( var4, var2, var8, var1 );
            
            if ( !var9 )
            {
                return var9;
            }
            
            if ( !istrue( var4.issquadleader ) )
            {
                thread sendplayerstatusmessage( var4, 55 );
            }
            else
            {
                thread sendplayerstatusmessage( var4, 54 );
            }
            
            return var9;
        }
    }
    
    var7 = undefined;
    var9 = undefined;
    
    if ( !var5 )
    {
        return 1;
    }
    
    return 0;
}

// Params 2
// Size: 0x2f
function sendplayerstatusmessage( var0, var1 )
{
    var2 = self;
    var2 notify( "sendPlayerStatusMessage" );
    var2 endon( "sendPlayerStatusMessage" );
    var2 scripts\mp\utility\lower_message::setlowermessageomnvar( var0 );
    
    if ( isdefined( var1 ) )
    {
        wait var1;
        var2 scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
        return;
    }
}

// Params 3
// Size: 0x1c0, Type: bool
function registerspawnlocation( var0, var1, var2 )
{
    var3 = self;
    var4 = scripts\engine\trace::create_default_contents( 1 );
    
    if ( istrue( var3.issquadleader ) )
    {
        var5 = round_logic( var3 );
        
        if ( !isdefined( var5 ) )
        {
            var5 = totalhealth( var3 );
        }
    }
    else if ( istrue( level.get_bomb_interaction_ent_cut_hint ) )
    {
        var5 = roof_spawners( var4 );
        
        if ( !isdefined( var5 ) )
        {
            var5 = total_spawns( var4 );
        }
    }
    else
    {
        return false;
    }
    
    var6 = getdvarfloat( "scr_infil_plus_spawn_height", 5500 );
    var7 = ( 0, 0, var6 );
    var8 = ( 0, 0, 10000 );
    var9 = var1 + var8;
    var10 = var1 - var8;
    var11 = scripts\engine\trace::ray_trace( var9, var10, undefined, var5 );
    var12 = var1;
    
    if ( var11[ "hittype" ] != "hittype_none" )
    {
        var12 = var11[ "position" ];
    }
    
    var5.locationorigin = var12 + var7;
    
    if ( istrue( var4.issquadleader ) )
    {
        var5.groundorigin = var12;
    }
    
    var5.locationangles = var2;
    var5.spawnexclusion2ddist = var3;
    var13 = var5.locationorigin;
    var14 = var13[ 0 ];
    var15 = var13[ 1 ];
    var16 = var13[ 2 ];
    var13 = undefined;
    
    if ( isdefined( var5.circleent ) )
    {
        var5.circleent.origin = ( var14, var15, var3 );
    }
    else
    {
        var5.circleent = getmaxobjectivecount( var14, var15, var3, var4 );
        
        if ( istrue( var4.issquadleader ) )
        {
            var5.circleent setmapcircleiconindex( 1 );
        }
    }
    
    var17 = scripts\mp\utility\teams::getfriendlyplayers( var4.team, 0 );
    
    foreach ( var19 in var17 )
    {
        if ( !istrue( var4.issquadleader ) )
        {
            thread sendplayerstatusmessage( var19, 64 );
            var19 playlocalsound( "br_map_selection_placed" );
            continue;
        }
        
        thread sendplayerstatusmessage( var19, 57 );
        var19 playlocalsound( "br_map_selection_placed" );
    }
    
    return true;
}

// Params 0
// Size: 0xde, Type: bool
function assignrandomspawnselection()
{
    var0 = self;
    
    if ( !isdefined( var0.issquadleader ) )
    {
        var0.issquadleader = 1;
        var1 = scripts\mp\utility\teams::getfriendlyplayers( var0.team, 0 );
        
        foreach ( var3 in var1 )
        {
            if ( var3 != var0 )
            {
                var3.issquadleader = 0;
            }
        }
    }
    
    var5 = ( 0, 0, 0 );
    
    for ( var6 = 0; var6 < 3 ; var6++ )
    {
        var7 = randomfloatrange( level.mapsafecorners[ 1 ][ 0 ], level.mapsafecorners[ 0 ][ 0 ] );
        var8 = randomfloatrange( level.mapsafecorners[ 1 ][ 1 ], level.mapsafecorners[ 0 ][ 1 ] );
        var5 = ( var7, var8, 0 );
        var9 = handleexclusionils( var0, var5 );
        
        if ( var9 )
        {
            return true;
        }
    }
    
    registerspawnlocation( var0, var5, undefined, getdvarint( "scr_map_selection_dense_min", 2000 ) );
    return false;
}

// Params 1
// Size: 0x59
function notifyafkofselection( var0 )
{
    var1 = self;
    var2 = scripts\mp\utility\teams::getfriendlyplayers( var1.team, 0 );
    var3 = "";
    
    if ( var0 )
    {
        var3 = "Safe Spawn Selection Assigned";
    }
    else
    {
        var3 = "Unsafe Spawn Selection Assigned";
    }
    
    foreach ( var5 in var2 )
    {
        var5 iprintlnbold( var3 );
    }
}

// Params 0
// Size: 0x10c
function ref_13aec()
{
    var0 = self;
    var0 playershow( 1 );
    var0 unlink( 1 );
    var1 = round_logic( var0 );
    
    if ( isdefined( var1.locationorigin ) )
    {
        var2 = var1.locationorigin;
        var3 = roof_spawners( var0 );
        
        if ( isdefined( var3 ) )
        {
            var2 = var3.locationorigin;
        }
        
        var4 = 512;
        var5 = ( 0, 60 * var0.pers[ "squadMemberIndex" ] % 360, 0 );
        var6 = anglestoforward( var5 ) * var4;
        var2 = var2 + var6 + ( 0, 0, randomfloatrange( 0, 512 ) );
        
        if ( getdvarint( "scr_br_fallbackinfilspawn", 0 ) )
        {
            var0.forcespawnorigin = var2;
            var0.forcespawnangles = undefined;
            var0.alreadyaddedtoalivecount = 1;
            var0 scripts\mp\playerlogic::spawnplayer( 0, 0 );
        }
        else
        {
            var0 setorigin( var2, 1 );
            var0 setplayerangles( var5 );
        }
    }
    
    var0 stopanimscriptsceneevent();
    var0 clearpredictedstreampos();
    var0 playershow( 1 );
    var0.br_infilstarted = 1;
    var0 setclientomnvar( "ui_br_infil_started", 1 );
    var0 setclientomnvar( "ui_br_infiled", 1 );
    var0 scripts\cp_mp\parachute::startfreefall( 0, 0 );
    var0 scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( var0 );
}

// Params 0
// Size: 0x3e
function postspawnselectionstream()
{
    var0 = self;
    var1 = roof_spawners( var0 );
    var2 = round_logic( var0 );
    
    if ( isdefined( var1 ) )
    {
        var0 predictstreampos( var1.locationorigin, 1 );
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        var0 predictstreampos( var2.locationorigin, 1 );
        return;
    }
}

// Params 0
// Size: 0x77
function spawnselectionbegin()
{
    setomnvar( "ui_match_start_text", "prepare_for_infil" );
    scripts\mp\gamelogic::matchstarttimerperplayer_internal( 10 );
    scripts\mp\flags::gameflaginit( "end_spawn_selection", 0 );
    level notify( "begin_infil_map_selection" );
    
    if ( !isdefined( level.br_spawns ) )
    {
        level.br_spawns = [];
    }
    
    foreach ( var1 in level.players )
    {
        var1 thread scripts\mp\gametypes\br::playerselectspawnsequence();
        var1.isselectingspawn = 1;
    }
    
    wait 2;
}

// Params 0
// Size: 0xec
function spawnselectionend()
{
    scripts\mp\flags::gameflagset( "end_spawn_selection" );
    var0 = getdvarint( "scr_sendAfkToGulag", 0 );
    
    foreach ( var2 in level.players )
    {
        var2 notify( "cancel_location" );
        thread sendplayerstatusmessage( var2, 51 );
        var3 = round_logic( var2 );
        
        if ( !isdefined( var3 ) )
        {
            if ( var0 )
            {
                var2.brmapselectionafk = 1;
                continue;
            }
            else
            {
                var4 = assignrandomspawnselection( var2 );
                notifyafkofselection( var2, var4 );
            }
        }
        
        var2.brmapselectionafk = 0;
        var2.isselectingspawn = 0;
        postspawnselectionstream( var2 );
    }
    
    thread ref_12c24();
    wait 4;
    
    foreach ( var2 in level.players )
    {
        thread sendplayerstatusmessage( var2 );
        var2 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", 0 );
    }
    
    thread ref_14392();
}

// Params 0
// Size: 0x11
function ref_14392()
{
    level endon( "game_ended" );
    level waittill( "infils_ready" );
}

// Params 0
// Size: 0x8d
function roof_spawners()
{
    var0 = self;
    
    if ( !istrue( level.get_bomb_interaction_ent_cut_hint ) || istrue( var0.issquadleader ) )
    {
        return undefined;
    }
    
    var1 = round_logic( var0 );
    
    if ( isdefined( var0.pers[ "squadMemberIndex" ] ) && isdefined( var1 ) )
    {
        if ( isdefined( var1.ref_134cc[ var0.pers[ "squadMemberIndex" ] ] ) && isdefined( var1.ref_134cc[ var0.pers[ "squadMemberIndex" ] ].locationorigin ) )
        {
            return var1.ref_134cc[ var0.pers[ "squadMemberIndex" ] ];
        }
    }
    
    return undefined;
}

// Params 0
// Size: 0x52
function round_logic()
{
    var0 = self;
    
    if ( isdefined( level.br_spawns ) && isdefined( var0.team ) && isdefined( level.br_spawns[ var0.team ] ) && isdefined( level.br_spawns[ var0.team ].locationorigin ) )
    {
        return level.br_spawns[ var0.team ];
    }
    
    return undefined;
}

// Params 0
// Size: 0x88
function total_spawns()
{
    var0 = self;
    
    if ( !istrue( level.get_bomb_interaction_ent_cut_hint ) || istrue( var0.issquadleader ) )
    {
        return undefined;
    }
    
    var1 = round_logic( var0 );
    
    if ( isdefined( var1 ) && isdefined( var0.pers[ "squadMemberIndex" ] ) )
    {
        var1.ref_134cc[ var0.pers[ "squadMemberIndex" ] ] = spawnstruct();
        var1.ref_134cc[ var0.pers[ "squadMemberIndex" ] ].circleent = undefined;
        return var1.ref_134cc[ var0.pers[ "squadMemberIndex" ] ];
    }
    
    return undefined;
}

// Params 0
// Size: 0x70
function totalhealth()
{
    var0 = self;
    
    if ( !istrue( var0.issquadleader ) )
    {
        return undefined;
    }
    
    if ( isdefined( level.br_spawns ) && isdefined( var0.team ) )
    {
        level.br_spawns[ var0.team ] = spawnstruct();
        level.br_spawns[ var0.team ].circleent = undefined;
        level.br_spawns[ var0.team ].ref_134cc = [];
        return level.br_spawns[ var0.team ];
    }
    
    return undefined;
}

// Params 1
// Size: 0x1d
function lastlocationcallouttime( var0 )
{
    if ( isdefined( var0.circleent ) )
    {
        var0.circleent delete();
    }
    
    var1 = undefined;
}

// Params 1
// Size: 0x1c
function lastmovingplatform( var0 )
{
    if ( isdefined( var0.circleent ) )
    {
        var0.circleent delete();
    }
    
    var0 = undefined;
}

// Params 0
// Size: 0x3a
function classselectionbeginnonexclusion()
{
    scripts\mp\flags::gameflaginit( "end_spawn_selection", 0 );
    
    foreach ( var1 in level.players )
    {
        var1 thread scripts\mp\gametypes\br::playerstartselectspawnclassnonexclusion();
    }
}

// Params 0
// Size: 0xd
function classselectionendnonexclusion()
{
    scripts\mp\flags::gameflagset( "end_spawn_selection" );
}

// Params 0
// Size: 0x76
function ref_12c24()
{
    wait 25;
    
    if ( isdefined( level.br_spawns ) )
    {
        foreach ( var1 in level.br_spawns )
        {
            if ( isdefined( var1.ref_134cc ) )
            {
                foreach ( var3 in var1.ref_134cc )
                {
                    lastlocationcallouttime( var3 );
                }
            }
            
            lastmovingplatform( var1 );
        }
        
        return;
    }
}

// Params 0
// Size: 0x5
function getspawnselectionlockedtimer()
{
    return 5;
}

// Params 1
// Size: 0x5b
function spawnselectioninfil( var0 )
{
    foreach ( var2 in level.players )
    {
        var2.br_infilstarted = 1;
        var2 setclientomnvar( "ui_br_infil_started", 1 );
        var2 setclientomnvar( "ui_br_infiled", 1 );
    }
    
    var4 = buildac130infilanimstruct( undefined, var0 );
    playac130infilanim( var4 );
}

// Params 0
// Size: 0x435
function initspawnexclusionpois()
{
    setdvarifuninitialized( "scr_map_selection_sparse_min", 813 );
    setdvarifuninitialized( "scr_map_selection_sparse_max", 1000 );
    setdvarifuninitialized( "scr_map_selection_semidense_min", 625 );
    setdvarifuninitialized( "scr_map_selection_semidense_max", 813 );
    setdvarifuninitialized( "scr_map_selection_dense_min", 500 );
    setdvarifuninitialized( "scr_map_selection_dense_max", 625 );
    setdvarifuninitialized( "scr_map_selection_falloff_max_distance", 25000 );
    setdvarifuninitialized( "scr_map_selection_falloff_fxn", "continuous" );
    level.br_spawnsparsepois = [ "boneyard", "farm", "lumber", "dam", "smallAirport", "quarry" ];
    level.br_spawnsemidensepois = [ "transit", "hospital", "port", "stadium", "tvStation", "storagetown", "supermarket" ];
    level.br_spawndensepois = [ "gulag", "northDowntown", "southDowntown", "eastAirport", "westAirport" ];
    var0 = getdvarint( "scr_map_selection_sparse_min" );
    var1 = getdvarint( "scr_map_selection_sparse_max" );
    
    foreach ( var3 in level.br_spawnsparsepois )
    {
        level.br_spawnpois[ var3 ] = spawnstruct();
        level.br_spawnpois[ var3 ].exclusionmin = var0;
        level.br_spawnpois[ var3 ].exclusionmax = var1;
    }
    
    var5 = getdvarint( "scr_map_selection_semidense_min" );
    var6 = getdvarint( "scr_map_selection_semidense_max" );
    
    foreach ( var3 in level.br_spawnsemidensepois )
    {
        level.br_spawnpois[ var3 ] = spawnstruct();
        level.br_spawnpois[ var3 ].exclusionmin = var5;
        level.br_spawnpois[ var3 ].exclusionmax = var6;
    }
    
    var9 = getdvarint( "scr_map_selection_dense_min" );
    var10 = getdvarint( "scr_map_selection_dense_max" );
    
    foreach ( var3 in level.br_spawndensepois )
    {
        level.br_spawnpois[ var3 ] = spawnstruct();
        level.br_spawnpois[ var3 ].exclusionmin = var9;
        level.br_spawnpois[ var3 ].exclusionmax = var10;
    }
    
    level.br_spawnpois[ "transit" ].pos = ( -12420, -26792, 0 );
    level.br_spawnpois[ "boneyard" ].pos = ( -26542, -21776, 0 );
    level.br_spawnpois[ "hospital" ].pos = ( 7827, -22240, 0 );
    level.br_spawnpois[ "port" ].pos = ( 35008, -37117, 0 );
    level.br_spawnpois[ "farm" ].pos = ( 48757, -25620, 0 );
    level.br_spawnpois[ "gulag" ].pos = ( 51019, -52257, 0 );
    level.br_spawnpois[ "lumber" ].pos = ( 51048, -8557, 0 );
    level.br_spawnpois[ "stadium" ].pos = ( 28873, -9839, 0 );
    level.br_spawnpois[ "tvStation" ].pos = ( 14423, 4999, 0 );
    level.br_spawnpois[ "northDowntown" ].pos = ( 20311, -18724, 0 );
    level.br_spawnpois[ "southDowntown" ].pos = ( 22076, -29372, 0 );
    level.br_spawnpois[ "storagetown" ].pos = ( -24594, -3984, 0 );
    level.br_spawnpois[ "supermarket" ].pos = ( -12782, -3634, 0 );
    level.br_spawnpois[ "eastAirport" ].pos = ( -8280, 5837, 0 );
    level.br_spawnpois[ "westAirport" ].pos = ( -21055, 7124, 0 );
    level.br_spawnpois[ "dam" ].pos = ( -26873, 32208, 0 );
    level.br_spawnpois[ "smallAirport" ].pos = ( 5823, 38518, 0 );
    level.br_spawnpois[ "quarry" ].pos = ( 32653, 26929, 0 );
}

// Params 4
// Size: 0x43
function getspawnselectioncontexclusiongrowth( var0, var1, var2, var3 )
{
    var4 = getdvarint( "scr_map_selection_falloff_max_distance" );
    var5 = distance2d( var0, var1 );
    
    if ( var5 > var4 )
    {
        return getdvarint( "scr_map_selection_exclusion", 2800 );
    }
    
    var6 = log( var3 ) / log( var2 ) * var4;
    var7 = var2 * exp( var6 * var5 );
    return var7;
}

// Params 4
// Size: 0x42
function getspawnselectionconstexclusiongrowth( var0, var1, var2, var3 )
{
    var4 = var2 / var3;
    var5 = getdvarint( "scr_map_selection_falloff_max_distance" );
    var6 = distance2d( var0, var1 );
    
    if ( var6 > var5 )
    {
        return getdvarint( "scr_map_selection_exclusion", 2800 );
    }
    
    var7 = var6 / var5;
    var8 = var2 * pow( 1 + var4, var7 );
    return var8;
}

// Params 4
// Size: 0x3b
function getspawnselectionlerpexclusiongrowth( var0, var1, var2, var3 )
{
    var4 = getdvarint( "scr_map_selection_falloff_max_distance" );
    var5 = distance2d( var0, var1 );
    
    if ( var5 > var4 )
    {
        return getdvarint( "scr_map_selection_exclusion", 2800 );
    }
    
    var6 = var5 / var4;
    var7 = scripts\engine\math::lerp( var2, var3, var6 );
    return var7;
}

// Params 1
// Size: 0x54
function getspawnselectionpoi( var0 )
{
    var1 = 2147483647;
    var2 = undefined;
    
    foreach ( var4 in level.br_spawnpois )
    {
        var5 = distance2d( var0, var4.pos );
        
        if ( var5 < var1 )
        {
            var1 = var5;
            var2 = var6;
        }
    }
    
    return [ var1, var2 ];
}

// Params 3
// Size: 0xd6
function getspawnselectionexclusionsize( var0, var1, var2 )
{
    var3 = getdvar( "scr_map_selection_falloff_fxn", "continuous" );
    var4 = level.br_spawnpois[ var2 ];
    
    switch ( var3 )
    {
        case "continuous":
            var4.spawnexclusion2ddist = getspawnselectioncontexclusiongrowth( var4.pos, var0, var4.exclusionmin, var4.exclusionmax );
            break;
        case "constant":
            var4.spawnexclusion2ddist = getspawnselectionconstexclusiongrowth( var4.pos, var0, var4.exclusionmin, var4.exclusionmax );
            break;
        case "lerp":
            var4.spawnexclusion2ddist = getspawnselectionlerpexclusiongrowth( var4.pos, var0, var4.exclusionmin, var4.exclusionmax );
            break;
        default:
            var4.spawnexclusion2ddist = getdvarint( "scr_map_selection_exclusion", 2800 );
            break;
    }
    
    return var4.spawnexclusion2ddist;
}

// Params 1
// Size: 0x6
function ref_14361( var0 )
{
    wait var0;
}

// Params 4
// Size: 0x10
function ref_11dbb( var0, var1, var2, var3 )
{
    self moveto( var0, var1, var2, var3 );
}

// Params 4
// Size: 0x10
function ref_12d9f( var0, var1, var2, var3 )
{
    self rotateto( var0, var1, var2, var3 );
}

// Params 0
// Size: 0x62
function showextractionobjectivetoteam()
{
    var0 = distance( level.br_ac130.ref_12205.startpt, level.br_ac130.ref_12205.endpt );
    var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() / level.showexfilstartsplash.size;
    
    for ( var2 = 0; var2 < level.showexfilstartsplash.size ; var2++ )
    {
        wait var1;
        level.showexfilstartsplash[ var2 ] notify( "halo_jump_c130" );
    }
    
    level.showexfilstartsplash = undefined;
}

// Params 1
// Size: 0x21
function ref_12b22( var0 )
{
    if ( !isdefined( level.showexfilstartsplash ) )
    {
        level.showexfilstartsplash = [];
    }
    
    level.showexfilstartsplash[ level.showexfilstartsplash.size ] = var0;
}

