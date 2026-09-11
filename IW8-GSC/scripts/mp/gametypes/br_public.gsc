
// Params 1
// Size: 0xd, Type: bool
function iswaitingtoentergulag( var0 )
{
    return istrue( var0.entergulagwait );
}

// Params 1
// Size: 0xd, Type: bool
function update_current_solution( var0 )
{
    return istrue( var0.set_relic_steelballs_perks );
}

// Params 1
// Size: 0xd, Type: bool
function use_csm( var0 )
{
    return istrue( var0.respawningfromtoken );
}

// Params 0
// Size: 0x1f, Type: bool
function isplayeringulag()
{
    var0 = self;
    return isdefined( var0 ) && ( istrue( var0.jailed ) || istrue( var0.gulagarena ) );
}

// Params 0
// Size: 0x2a, Type: bool
function updateinstantclassswapallowedinternal()
{
    var0 = self;
    return isdefined( var0 ) && ( istrue( var0.jailed ) || istrue( var0.gulagarena ) || istrue( var0.gulag ) );
}

// Params 0
// Size: 0x14, Type: bool
function ref_1443c()
{
    var0 = self;
    return isdefined( var0 ) && istrue( var0.ref_14439 );
}

// Params 0
// Size: 0x1f, Type: bool
function isplayerwaitingrebirthrespawn()
{
    var0 = self;
    return isdefined( var0 ) && isdefined( var0.ref_12ca1 ) && var0.ref_12ca1 > 0;
}

// Params 0
// Size: 0x2b, Type: bool
function unlockscriptabledoors()
{
    var0 = self;
    return ( istrue( var0.delay_enter_combat_after_investigating_grenade ) && !isalive( var0 ) || ref_125f3( var0 ) ) && !istrue( var0.gulag );
}

// Params 0
// Size: 0x9, Type: bool
function ref_125f3()
{
    return istrue( self.iszombie );
}

// Params 0
// Size: 0x13, Type: bool
function ref_125ec()
{
    return istrue( self.unset_relic_gun_game ) || istrue( self.scn_infil_tango_npc_2_sfx );
}

// Params 0
// Size: 0x2a
function watchhealend()
{
    self endon( "heal_end" );
    self endon( "death_or_disconnect" );
    self endon( "br_armor_plate_done" );
    level endon( "game_ended" );
    GscBinSkip4( 0x35 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 0
// Size: 0x44
function heal_removeonplayernotifies()
{
    self notifyonplayercommand( "try_heal_cancel", "+weapnext" );
    self notifyonplayercommand( "try_heal_cancel", "+attack" );
    self notifyonplayercommand( "try_heal_cancel", "+breath_sprint" );
    scripts\engine\utility::ref_143a5( "death", "try_heal_cancel" );
    healend();
}

// Params 0
// Size: 0x61
function heal_removeondamage()
{
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
        
        if ( level.gametype == "br" && ( var4 == "MOD_TRIGGER_HURT" || var4 == "MOD_UNKNOWN" ) )
        {
            continue;
        }
        
        healend();
    }
}

// Params 0
// Size: 0x37
function healend()
{
    self notifyonplayercommandremove( "try_heal_cancel", "+weapnext" );
    self notifyonplayercommandremove( "try_heal_cancel", "+attack" );
    self notifyonplayercommandremove( "try_heal_cancel", "+breath_sprint" );
    self notify( "heal_end" );
}

// Params 1
// Size: 0xb
function removeitemfrominventory( var0 )
{
    self.br_inventory_slots[ var0 ] = undefined;
}

// Params 1
// Size: 0x36, Type: bool
function ishelmet( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "armor" && issubstr( var0, "helmet" );
}

// Params 1
// Size: 0xb, Type: bool
function isarmor( var0 )
{
    return ishelmet( var0 );
}

// Params 1
// Size: 0xc, Type: bool
function isarmorplate( var0 )
{
    return var0 == "brloot_armor_plate";
}

// Params 1
// Size: 0x20, Type: bool
function ishealitem( var0 )
{
    return var0 == "brloot_health_bandages" || var0 == "brloot_health_firstaid" || var0 == "brloot_health_adrenaline";
}

// Params 1
// Size: 0x51, Type: bool
function isequipment( var0 )
{
    return isarmorplate( var0 ) || ishealitem( var0 ) || isdefined( level.br_pickups.br_itemtype[ var0 ] ) && ( level.br_pickups.br_itemtype[ var0 ] == "lethal" || level.br_pickups.br_itemtype[ var0 ] == "tactical" );
}

// Params 1
// Size: 0x29, Type: bool
function isammo( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "ammo";
}

// Params 0
// Size: 0x5f, Type: bool
function ref_12518()
{
    if ( self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "isPlayerADS" ) ]]() || istrue( self.tracking_max_health ) )
    {
        return false;
    }
    
    var0 = self getcurrentweapon();
    
    if ( nullweapon( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x29
function ref_12616( var0, var1 )
{
    self endon( "death_or_disconnect" );
    var2 = getcompleteweaponname( var0 );
    self giveandfireoffhand( var2 );
    wait var1;
    
    if ( self hasweapon( var2 ) )
    {
        self takeweapon( var2 );
        return;
    }
}

// Params 0
// Size: 0xe, Type: bool
function hasrespawntoken()
{
    var0 = self;
    return istrue( var0.hasrespawntoken );
}

// Params 0
// Size: 0xe, Type: bool
function hasgulagtoken()
{
    var0 = self;
    return istrue( var0.ÜŸ4,Êv´∆¬ù:Ω÷≤õ );
}

// Params 0
// Size: 0xe, Type: bool
function shouldgetnewspawnpoint()
{
    var0 = self;
    return istrue( var0.shouldgetnewspawnpoint );
}

// Params 0
// Size: 0xe, Type: bool
function should_use_velo_forward()
{
    var0 = self;
    return istrue( var0.should_use_velo_forward );
}

// Params 0
// Size: 0xe, Type: bool
function shouldlink()
{
    var0 = self;
    return istrue( var0.should_enter_combat_after_checking_decoy_grenade );
}

// Params 1
// Size: 0x2e
function should_damage_pavelow_boss( var0 )
{
    var1 = self;
    
    if ( !isdefined( var0 ) || !isdefined( var1.armorylights ) )
    {
        return isdefined( var1.armorylights );
    }
    
    return var0 == var1.armorylights;
}

// Params 0
// Size: 0x2d, Type: bool
function isusinginfilselection()
{
    if ( istrue( level.infilcanusemap ) )
    {
        switch ( level.infilselectionmethod )
        {
            case "exclusion":
                return true;
            default:
                return false;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x1c
function handleinfilspawnselectstart()
{
    var0 = level.infilselectionmethod;
    var1 = getinfilspawnselectstartfunc( var0 );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    return level [[ var1 ]]();
}

// Params 0
// Size: 0x1c
function handleinfilspawnselectend()
{
    var0 = level.infilselectionmethod;
    var1 = getinfilspawnselectendfunc( var0 );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    return level [[ var1 ]]();
}

// Params 1
// Size: 0x27
function getinfilspawnselectstartfunc( var0 )
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
    
    return var1.spawnselectstartfunc;
}

// Params 1
// Size: 0x27
function getinfilspawnselectendfunc( var0 )
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
    
    return var1.spawnselectendfunc;
}

// Params 1
// Size: 0x1de
function cleanac130struct( var0 )
{
    if ( isdefined( var0.playerslot1 ) )
    {
        if ( isdefined( var0.playerslot1.head ) )
        {
            var0.playerslot1.head delete();
        }
        
        if ( isdefined( var0.playerslot1.helmet ) )
        {
            var0.playerslot1.helmet delete();
        }
        
        var0.playerslot1 delete();
    }
    
    if ( isdefined( var0.playerslot2 ) )
    {
        if ( isdefined( var0.playerslot2.head ) )
        {
            var0.playerslot2.head delete();
        }
        
        var0.playerslot2 delete();
    }
    
    if ( isdefined( var0.playerslot3 ) )
    {
        var0.playerslot3 delete();
    }
    
    if ( isdefined( var0.playerslot4 ) )
    {
        var0.playerslot4 delete();
    }
    
    if ( isdefined( var0.aidoorchief ) )
    {
        var0.aidoorchief delete();
    }
    
    if ( isdefined( var0.cameraent ) )
    {
        var0.cameraent delete();
    }
    
    if ( isdefined( var0.gas_trigger ) )
    {
        var0.gas_trigger delete();
    }
    
    if ( isdefined( var0.playerpositionents ) )
    {
        foreach ( var2 in var0.playerpositionents )
        {
            var2 delete();
        }
    }
    
    if ( isdefined( var0.helicratedelete ) )
    {
        var0.helicratedelete delete();
    }
    
    if ( isdefined( var0.staticc130 ) && istrue( var0.staticc130.cleanme ) )
    {
        var0.staticc130 delete();
    }
    
    if ( isdefined( var0.movingc130 ) && istrue( var0.movingc130.cleanme ) )
    {
        if ( isdefined( var0.movingc130.innards ) && istrue( var0.movingc130.innards.cleanme ) )
        {
            var0.movingc130.innards delete();
        }
        
        var0.movingc130 delete();
        return;
    }
}

// Params 0
// Size: 0xa, Type: bool
function turn_on_nearby_model_screen()
{
    return level.stop_wave == 0;
}

// Params 0
// Size: 0xb, Type: bool
function tv_station_intro_already_played()
{
    return level.stop_wave == 1;
}

// Params 0
// Size: 0xb, Type: bool
function usefailcapacitymsg()
{
    return level.stop_wave == 2;
}

// Params 1
// Size: 0x7a
function remove_old_wheelsons( var0 )
{
    var1 = 1;
    
    if ( isdefined( var0.infilanimindex ) )
    {
        var1 = var0.infilanimindex;
    }
    
    if ( tv_station_intro_already_played() )
    {
        if ( istrue( var0.stop_counter_beep_sfx_on_bomb_vests ) )
        {
            var2 = "cam_orbit_br_chopper_solo";
            return var2;
        }
        
        var2 = "cam_orbit_br_chopper_squad_player" + var2;
        return var2;
    }
    
    if ( usefailcapacitymsg() )
    {
        if ( istrue( var2.stop_counter_beep_sfx_on_bomb_vests ) )
        {
            var2 = "cam_orbit_br_skilo_solo";
            return var2;
        }
        
        var2 = "cam_orbit_br_skilo_squad_player" + var2;
        return var2;
    }
    
    var2 = "cam_orbit_br_ac130_player" + var2;
    return var2;
}

// Params 1
// Size: 0x7e
function orbitcam( var0 )
{
    self endon( "death" );
    
    if ( isdefined( level.infil_vignette_anim_type ) && level.infil_vignette_anim_type == "script_model" )
    {
        self.angles = var0.angles;
        self playerlinkto( var0, "" );
        self playerhide();
    }
    
    if ( isdefined( level.ref_142d1 ) )
    {
        scripts\mp\utility\player::_visionsetnaked( level.ref_142d1, 0 );
    }
    else
    {
        scripts\mp\utility\player::_visionsetnaked( "", 0 );
    }
    
    self setplayerangles( var0.angles );
    var1 = remove_old_wheelsons( self );
    self cameraset( var1 );
}

// Params 0
// Size: 0xa
function ref_1264d()
{
    var0 = self;
    var0 method_87a9();
}

// Params 2
// Size: 0x1e2
function updatebrscoreboardstat( var0, var1 )
{
    var2 = self;
    var3 = 0;
    var4 = 0;
    var5 = 0;
    
    switch ( var0 )
    {
        case "reviveCount":
            var6 = [ 0, 8, 0 ];
            var3 = var6[ 0 ];
            var4 = var6[ 1 ];
            var5 = var6[ 2 ];
            var6 = undefined;
            break;
        case "objTime":
            var7 = [ 0, 12, 0 ];
            var3 = var7[ 0 ];
            var4 = var7[ 1 ];
            var5 = var7[ 2 ];
            var7 = undefined;
            break;
        case "tomahDamage":
            var8 = [ 0, 16, 0 ];
            var3 = var8[ 0 ];
            var4 = var8[ 1 ];
            var5 = var8[ 2 ];
            var8 = undefined;
            break;
        case "respawnInSeconds":
            var9 = [ 0, 7, 1 ];
            var3 = var9[ 0 ];
            var4 = var9[ 1 ];
            var5 = var9[ 2 ];
            var9 = undefined;
            break;
        case "isInInfilPlane":
            var10 = [ 7, 1, 1 ];
            var3 = var10[ 0 ];
            var4 = var10[ 1 ];
            var5 = var10[ 2 ];
            var10 = undefined;
            break;
        case "armorHealthRatio":
            var11 = [ 0, 8, 2 ];
            var3 = var11[ 0 ];
            var4 = var11[ 1 ];
            var5 = var11[ 2 ];
            var11 = undefined;
            break;
        case "missionsCompleted":
            var12 = [ 8, 4, 2 ];
            var3 = var12[ 0 ];
            var4 = var12[ 1 ];
            var5 = var12[ 2 ];
            var12 = undefined;
            break;
        case "bunkerKeycardType":
            var13 = [ 12, 4, 2 ];
            var3 = var13[ 0 ];
            var4 = var13[ 1 ];
            var5 = var13[ 2 ];
            var13 = undefined;
            break;
        case "damageDealt":
            var14 = [ 0, 16, 3 ];
            var3 = var14[ 0 ];
            var4 = var14[ 1 ];
            var5 = var14[ 2 ];
            var14 = undefined;
            break;
        case "isBeingRevived":
        case "isDowned":
        case "activeSpectators":
        case "jumpMasterState":
        case "isRespawning":
        case "cleanups":
        case "playersDowned":
            return;
        default:
            return;
    }
    
    packstatintoextrainfo( var2, var1, var3, var4, var5 );
}

// Params 4
// Size: 0xc3
function packstatintoextrainfo( var0, var1, var2, var3 )
{
    var4 = self;
    var5 = [ var4.extrascore0, var4.extrascore1, var4.extrascore2, var4.extrascore3 ];
    var6 = int( pow( 2, var2 ) ) - 1;
    var7 = ( var0 & var6 ) << var1;
    var8 = ~( var6 << var1 );
    var9 = var5[ var3 ];
    var10 = var9 & var8;
    var11 = var10 + var7;
    
    switch ( var3 )
    {
        case 0:
            var4.extrascore0 = var11;
            break;
        case 1:
            var4.extrascore1 = var11;
            break;
        case 2:
            var4.extrascore2 = var11;
            break;
        case 3:
            var4.extrascore3 = var11;
            break;
        default:
            break;
    }
}

// Params 2
// Size: 0x6e
function updatebrextradata( var0, var1 )
{
    var2 = self;
    var3 = 0;
    var4 = 0;
    
    switch ( var0 )
    {
        case "selectedKillstreakId":
            var5 = [ 0, 4 ];
            var3 = var5[ 0 ];
            var4 = var5[ 1 ];
            var5 = undefined;
            break;
        case "armorPlateCount":
            var6 = [ 4, 4 ];
            var3 = var6[ 0 ];
            var4 = var6[ 1 ];
            var6 = undefined;
            break;
        default:
            return;
    }
    
    packdataintoextrainfo( var2, var1, var3, var4 );
}

// Params 3
// Size: 0x48
function packdataintoextrainfo( var0, var1, var2 )
{
    var1 = 20 + var1;
    
    if ( var1 + var2 > 31 )
    {
        return;
    }
    
    var3 = int( pow( 2, var2 ) ) - 1;
    var4 = ( var0 & var3 ) << var1;
    var5 = ~( var3 << var1 );
    var6 = self.game_extrainfo;
    var7 = var6 & var5;
    var8 = var7 + var4;
    self.game_extrainfo = var8;
}

// Params 1
// Size: 0x28
function ref_1319e( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 512;
        return;
    }
    
    self.game_extrainfo &= ~512;
}

// Params 1
// Size: 0x28
function ref_1319c( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 1024;
        return;
    }
    
    self.game_extrainfo &= ~1024;
}

// Params 1
// Size: 0x28
function ref_131a6( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 2048;
        return;
    }
    
    self.game_extrainfo &= ~2048;
}

// Params 1
// Size: 0x28
function ref_131a4( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 8192;
        return;
    }
    
    self.game_extrainfo &= ~8192;
}

// Params 1
// Size: 0x1c, Type: bool
function updatelootleadersonfixedinterval( var0 )
{
    return isdefined( var0.game_extrainfo ) && var0.game_extrainfo & 8192;
}

// Params 1
// Size: 0x28
function ref_1315c( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 16384;
        return;
    }
    
    self.game_extrainfo &= ~16384;
}

// Params 1
// Size: 0x28
function ref_1315b( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 32768;
        return;
    }
    
    self.game_extrainfo &= ~32768;
}

// Params 0
// Size: 0x43
function incrementplayersdownedstat()
{
    var0 = self;
    
    if ( !isdefined( var0.br_playersdowned ) )
    {
        var0.br_playersdowned = 0;
    }
    
    var0.br_playersdowned++;
    updatebrscoreboardstat( var0, "playersDowned", var0.br_playersdowned );
    var0 scripts\mp\utility\stats::incpersstat( "downs", 1 );
}

// Params 1
// Size: 0x7a
function sethasgasmaskextrainfo( var0 )
{
    if ( var0 == 1 )
    {
        self.game_extrainfo |= 65536;
        self.game_extrainfo &= ~131072;
        return;
    }
    
    if ( var0 == 2 )
    {
        self.game_extrainfo &= ~65536;
        self.game_extrainfo |= 131072;
        return;
    }
    
    self.game_extrainfo &= ~65536;
    self.game_extrainfo &= ~131072;
}

// Params 1
// Size: 0x2c
function sethasplatepouchextrainfo( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 262144;
        return;
    }
    
    self.game_extrainfo &= ~262144;
}

// Params 1
// Size: 0x2c
function setcanusegulagextrainfo( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 524288;
        return;
    }
    
    self.game_extrainfo &= ~524288;
}

// Params 0
// Size: 0x1c, Type: bool
function updatedragonsbreath()
{
    var0 = self;
    return istrue( var0.tutorial_usingparachute ) && var0.game_extrainfo & 64;
}

// Params 6
// Size: 0x53
function dmztutdropcash( var0, var1, var2, var3, var4, var5 )
{
    foreach ( var7 in level.teamdata[ var1 ][ "players" ] )
    {
        if ( !isdefined( var7 ) )
        {
            continue;
        }
        
        if ( var7 != var2 )
        {
            dmztut_endgamewithreward( var0, var7, var3, var4, var5 );
        }
    }
}

// Params 6
// Size: 0x21
function dmztut_luicallback( var0, var1, var2, var3, var4, var5 )
{
    brleaderdialog( var0, var2, level.teamdata[ var1 ][ "players" ], var5, var3, var4 );
}

// Params 7
// Size: 0x4e
function brleaderdialog( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( !isdefined( game[ "dialog" ][ var0 ] ) )
    {
        return;
    }
    
    var7 = level.players;
    
    if ( isdefined( var2 ) )
    {
        var7 = var2;
    }
    
    for ( var8 = 0; var8 < var7.size ; var8++ )
    {
        var9 = var7[ var8 ];
        thread dmztut_endgamewithreward( var0, var9, var1, var3, var4, var5, var6 );
    }
}

// Params 2
// Size: 0x97, Type: bool
function ref_11c7d( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 1;
    }
    
    if ( istrue( var1 ) && isplayeringulag() )
    {
        return true;
    }
    
    if ( istrue( self.ref_12742 ) )
    {
        return true;
    }
    
    if ( tutorial_playsound() )
    {
        if ( istrue( self.ref_12749 ) )
        {
            return true;
        }
        
        if ( var0 == "deploy_squad_leader" || var0 == "prematch_enter" )
        {
            return true;
        }
        
        if ( ( var0 == "circle_closing" || var0 == "first_circle" ) && !istrue( level.ref_126d5 ) )
        {
            return true;
        }
    }
    
    var2 = level.maxteamsize == 1;
    
    if ( var2 )
    {
        switch ( var0 )
        {
            case "deploy_squad_leader":
                return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x40
function disableannouncer( var0 )
{
    var1 = var0.defaultoperatorteam;
    
    if ( isai( var0 ) )
    {
        var1 = var0.botoperatorteam;
    }
    
    if ( validtousesticker() || tutorial_playsound() )
    {
        var1 = "allies";
    }
    
    if ( !isplayer( var0 ) )
    {
        var1 = "axis";
    }
    
    return var1;
}

// Params 7
// Size: 0x179
function dmztut_endgamewithreward( var0, var1, var2, var3, var4, var5, var6 )
{
    var1 endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    if ( !isalive( var1 ) && !istrue( var3 ) )
    {
        return;
    }
    
    if ( var1 issplitscreenplayer() && !var1 issplitscreenplayerprimary() )
    {
        return;
    }
    
    if ( ref_11c7d( var1, var0, var2 ) )
    {
        return;
    }
    
    if ( validtousesticker() || tutorial_playsound() )
    {
        if ( var0 == "mission_scav_accept" || var0 == "mission_obj_next_nptarget" )
        {
            return;
        }
    }
    
    if ( isdefined( var6 ) )
    {
        var7 = var6;
    }
    else
    {
        jumpiffalse(var2 scripts\cp_mp\utility\game_utility::ref_140a8()) LOC_00000091;
        var7 = "bchr";
        goto LOC_000000a8;
    }
    
LOC_000000a8:
    var9 = "dx_bra_" + var7 + "_" + game[ "dialog" ][ var2 ];
    
    if ( istrue( level.vehicle_collision_getleveldata ) )
    {
        var10 = "dx_brm_" + var7 + "_" + game[ "dialog" ][ var2 ];
        
        if ( soundexists( var10 ) )
        {
            var9 = var10;
        }
    }
    else if ( isdefined( level.¢∑Œ/Û%úä¯h¥?© ) )
    {
        var11 = "dx_bra_" + level.¢∑Œ/Û%úä¯h¥?© + "_" + game[ "dialog" ][ var2 ];
        
        if ( soundexists( var11 ) )
        {
            var9 = var11;
        }
    }
    
    if ( isdefined( game[ "dialogForAllTeams" ] ) && istrue( game[ "dialogForAllTeams" ][ var2 ] ) )
    {
        var9 = game[ "dialog" ][ var2 ];
    }
    
    if ( isdefined( var9 ) )
    {
        var9 = tolower( var9 );
        var12 = lookupsoundlength( var9, 1 ) / 1000;
        
        if ( isdefined( var6 ) )
        {
            wait var6;
        }
        
        var3 queuedialogforplayer( var9, var2, var12 );
        return;
    }
}

// Params 2
// Size: 0x30
function endgamevo( var0, var1 )
{
    game[ "dialog" ][ var0 ] = var1;
    
    if ( !isdefined( game[ "dialogForAllTeams" ] ) )
    {
        game[ "dialogForAllTeams" ] = [];
    }
    
    game[ "dialogForAllTeams" ][ var0 ] = 1;
}

// Params 0
// Size: 0x17, Type: bool
function uniquelootitemid()
{
    return isdefined( level.script ) && level.script == "mp_bm_tut";
}

// Params 0
// Size: 0x30, Type: bool
function validtousesticker()
{
    var0 = getdvar( "wz_tutorial_map", "mp_br_tut2" );
    return isdefined( level.script ) && ( level.script == var0 || level.script == "mp_lc_br_tut" );
}

// Params 0
// Size: 0x17, Type: bool
function tutorial_playsound()
{
    return isdefined( level.script ) && level.script == "mp_br_quarry";
}

// Params 0
// Size: 0x17, Type: bool
function uniquelootcallbacks()
{
    return isdefined( level.script ) && level.script == "mp_br_money";
}

// Params 0
// Size: 0x1d, Type: bool
function turret_headicon()
{
    return validtousesticker() || uniquelootitemid() || tutorial_playsound() || uniquelootcallbacks();
}

// Params 0
// Size: 0x7f
function ref_12570()
{
    var0 = self getweaponslistprimaries();
    
    foreach ( var2 in var0 )
    {
        var3 = var2.basename;
        
        if ( weaponclass( var2 ) == "pistol" && var3 != "iw8_fists_mp" && var3 != "iw8_me_riotshield_mp" && var3 != "iw8_knifestab_mp" && var3 != "iw8_throwingknife_fire_melee_mp" && var3 != "iw8_throwingknife_electric_melee_mp" && var3 != "iw8_throwingknife_drill_melee_mp" )
        {
            return var2;
        }
    }
}

// Params 0
// Size: 0x14
function ref_126ed()
{
    if ( istrue( self.ref_12875 ) )
    {
        self waittill( "playerPrestreamComplete" );
        return;
    }
}

// Params 0
// Size: 0x23
function getinfilspawnoffset()
{
    if ( istrue( level.infilcanusemap ) )
    {
        return getdvarfloat( "scr_map_selection_height_offset", 2000 );
    }
    
    return getdvarfloat( "scr_br_dropSpawnOffsetMinZ", 12000 );
}

// Params 2
// Size: 0x4c
function ref_126b8( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = getinfilspawnoffset();
    }
    
    var2 = getdvarint( "scr_br_streamDistFromGround", 4500 );
    
    if ( var2 >= 0 )
    {
        var3 = var1 - var2;
        var4 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
        var0 = scripts\engine\utility::drop_to_ground( var0, 0, -1 * var3, undefined, var4 );
    }
    
    return var0;
}

// Params 5
// Size: 0x13
function ref_126b9( var0, var1, var2, var3, var4 )
{
    thread ref_126ba( var0, var1, var2, var3, var4 );
}

// Params 5
// Size: 0x11d
function ref_126ba( var0, var1, var2, var3, var4 )
{
    self notify( "playerPrestreamLocationWait" );
    self endon( "playerPrestreamLocationWait" );
    self endon( "disconnect" );
    var5 = !self calloutmarkerping_getent();
    
    if ( !isdefined( var1 ) )
    {
        var1 = relic_nuketimer_gettimeformission();
    }
    
    var6 = gettime() + var1;
    self.ref_12875 = 1;
    
    if ( !self ispredictedstreamposready() )
    {
        self clearpredictedstreampos();
    }
    
    var7 = gettime();
    
    if ( var5 )
    {
        while ( !istrue( self.pers[ "streamSyncComplete" ] ) && gettime() < var6 )
        {
            waitframe();
        }
    }
    
    self predictstreampos( var0, 1 );
    
    if ( istrue( var2 ) )
    {
        self loadcustomizationplayerview( self );
    }
    
    if ( var5 )
    {
        waitframe();
        
        while ( ( !self ispredictedstreamposready() || istrue( var2 ) && !self hasloadedcustomizationplayerview( self ) ) && gettime() < var6 )
        {
            waitframe();
        }
        
        if ( istrue( var3 ) )
        {
            var9 = gettime() + getdvarint( "scr_br_stream_hint_extra_time", 5000 );
            
            while ( gettime() < var9 )
            {
                waitframe();
            }
        }
        
        if ( isdefined( var4 ) )
        {
            var10 = getdvarint( "keep_alive_update_time", 2000 );
            var6 = gettime() + var4;
            var11 = 0;
            
            while ( gettime() < var6 )
            {
                if ( gettime() > var11 )
                {
                    self predictstreampos( var0, 1 );
                    var11 = gettime() + var10;
                }
                
                waitframe();
            }
        }
    }
    
    self.ref_12875 = undefined;
    self notify( "playerPrestreamComplete" );
}

// Params 0
// Size: 0xe
function relic_nuketimer_gettimeformission()
{
    return getdvarint( "scr_br_stream_hint_timeout", 9000 );
}

// Params 0
// Size: 0xf
function ref_1252b()
{
    self notify( "playerPrestreamLocationWait" );
    self clearpredictedstreampos();
}

// Params 0
// Size: 0x105
function ref_1264c()
{
    self cancelmantle();
    
    if ( self isskydiving() )
    {
        self skydive_interrupt();
    }
    
    if ( istrue( self.inlaststand ) )
    {
        scripts\mp\laststand::playanim_aibegindismountturret( "self_revive_success", self );
    }
    
    if ( isdefined( self.burninginfo ) )
    {
        scripts\mp\equipment\molotov::molotov_clear_burning();
    }
    
    if ( istrue( self.usingascender ) )
    {
        scripts\cp_mp\auto_ascender::canseesafecircleui();
    }
    
    if ( scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) )
    {
        var0 = spawnstruct();
        var0.allowairexit = 1;
        var0.onprematchfadedone2 = "INVOLUNTARY";
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit( self.vehicle, undefined, self, var0, 1 );
    }
    
    if ( isdefined( self.remoteuav ) )
    {
        self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();
    }
    
    if ( isdefined( self.currentturret ) )
    {
        scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse( self.currentturret );
    }
    
    if ( isdefined( self.usingremote ) )
    {
        var1 = vehicle_getarray();
        
        foreach ( var3 in var1 )
        {
            if ( isdefined( var3.owner ) && var3.owner == self )
            {
                if ( isdefined( var3.helperdronetype ) )
                {
                    var3 scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode( 1 );
                }
            }
        }
    }
    
    scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
}

// Params 1
// Size: 0x10
function playerloadoutsaveselected( var0 )
{
    var1 = undefined;
    var1 = scripts\mp\class::preloadandqueueclass( var0 );
    return var1;
}

// Params 0
// Size: 0x17
function forcedisablelaststand()
{
    var0 = self.origin - anglestoforward( self.angles ) * 150;
    return var0;
}

// Params 0
// Size: 0x13, Type: bool
function hasarmor()
{
    return isdefined( self.br_armorhealth ) && self.br_armorhealth > 0;
}

// Params 0
// Size: 0x9, Type: bool
function hashelmet()
{
    return isdefined( self.br_helmetlevel );
}

// Params 2
// Size: 0xfb
function damagearmor( var0, var1 )
{
    if ( !hasarmor() )
    {
        return var0;
    }
    
    var2 = int( min( self.br_armorhealth, var0 ) );
    var3 = var0 - var2;
    var4 = self.br_armorhealth / self.br_maxarmorhealth;
    self.br_armorhealth -= var2;
    scripts\cp\vehicles\vehicle_compass_cp::ref_12000( var2 );
    self.br_armorhealth = max( 0, self.br_armorhealth );
    var5 = self.br_armorhealth / self.br_maxarmorhealth;
    
    if ( isplayer( self ) )
    {
        if ( !istrue( var1 ) )
        {
            if ( self.br_armorhealth == 0 && var2 > 0 )
            {
                self playsoundtoplayer( "hit_marker_3d_armor_break", self );
                
                if ( scripts\mp\utility\perk::_hasperk( "specialty_br_reinforced" ) )
                {
                    self setscriptablepartstate( "armor_break", "reinforced_armor_break", 0 );
                }
                else
                {
                    self setscriptablepartstate( "armor_break", "armor_break", 0 );
                }
            }
        }
        
        self setclientomnvar( "ui_br_armor_damage", var5 );
        scripts\mp\equipment\armor_plate::debug_state( self.br_armorhealth );
        var6 = spawnstruct();
        var6.is_spawner_position_valid = var2;
        var6.isaccesscard = var3;
        var6.stack_patch_waittill_stack = var1;
        runbrgametypefuncwrapper( "onPlayerArmorDamaged", var6 );
    }
    
    return var3;
}

// Params 0
// Size: 0x14, Type: bool
function ishelmetpopenabled()
{
    if ( getdvarint( "scr_br_helmet_pop", 1 ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x8
function breakhelmet()
{
    self.br_helmetlevel = undefined;
}

// Params 3
// Size: 0x83
function damagehelmet( var0, var1, var2 )
{
    if ( !isdefined( var1 ) || !ishelmetpopenabled() )
    {
        var1 = 0;
    }
    
    var3 = 1;
    
    switch ( self.br_helmetlevel )
    {
        case 1:
            var3 = 0.85;
            break;
        case 2:
            var3 = 0.7;
            break;
        case 3:
            var3 = 0.7;
            break;
        default:
            break;
    }
    
    if ( var1 )
    {
        breakhelmet();
        
        if ( isdefined( level.ref_1203e ) )
        {
            [[ level.ref_1203e ]]( self, var2 );
        }
    }
    
    return var3;
}

// Params 1
// Size: 0x14d
function ref_1285e( var0 )
{
    setglobalsoundcontext( "lobby_fade", "on", 3 );
    
    if ( !isdefined( level.ref_133b4 ) )
    {
        level.ref_133b4 = 1;
    }
    
    thread stop_priming_gesture();
    
    if ( level.matchcountdowntime > 13 )
    {
        var1 = level.matchcountdowntime - 13;
        wait var1;
        var2 = scripts\mp\utility\teams::getteamdata( var0, "players" );
        
        if ( istrue( level.vehicle_collision_getleveldata ) )
        {
            setmusicstate( "event01_lobby_outro" );
        }
        else
        {
            var3 = game[ "music" ][ "br_lobby_outro" ].size;
            
            foreach ( var5 in var2 )
            {
                if ( isdefined( var5 ) )
                {
                    var6 = randomint( var3 );
                    var5 setplayermusicstate( game[ "music" ][ "br_lobby_outro" ][ var6 ] );
                    var5 setsoundsubmix( "mp_br_lobby_fade", 8 );
                }
            }
        }
        
        wait level.matchcountdowntime;
        
        if ( !istrue( level.áÍ+0N¡J}•y3”ôëÒ€õ0b2 ) )
        {
            foreach ( var5 in var2 )
            {
                if ( isdefined( var5 ) )
                {
                    var5 setplayermusicstate( "" );
                }
            }
        }
        
        var10 = istrue( level.br_infils_disabled );
        
        if ( var10 )
        {
            foreach ( var5 in var2 )
            {
                if ( isdefined( var5 ) )
                {
                    var5 clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
                }
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x107
function stop_priming_gesture()
{
    if ( istrue( level.ãÍmq‘+§∞bYå¯Ocq˘PÀ ) )
    {
        return;
    }
    
    if ( getdvarint( "scr_br_c130_intro_s2", 0 ) == 1 )
    {
        return;
    }
    
    level.ãÍmq‘+§∞bYå¯Ocq˘PÀ = 1;
    
    if ( tv_station_intro_already_played() )
    {
        var0 = level.matchcountdowntime + 1 + 3.5 - 1;
        
        if ( scripts\cp_mp\utility\game_utility::unlink_on_ai_death() )
        {
            var0 = level.matchcountdowntime - 0.05;
        }
        
        wait var0;
    }
    else if ( usefailcapacitymsg() )
    {
        scripts\mp\utility\sound::besttime( "br_infil_skilo" );
        var0 = level.matchcountdowntime + 1 + 3.5;
        wait var0;
    }
    else
    {
        var0 = level.matchcountdowntime + 1 + 3.5;
        wait var0;
    }
    
    waittillframeend();
    level.áÍ+0N¡J}•y3”ôëÒ€õ0b2 = 1;
    
    foreach ( var2 in level.players )
    {
        var3 = game[ "music" ][ "br_infil_intro" ].size;
        var4 = randomint( var3 );
        var5 = game[ "music" ][ "br_infil_intro" ][ var4 ];
        var2 setplayermusicstate( var5 );
    }
    
    wait 24;
    level.áÍ+0N¡J}•y3”ôëÒ€õ0b2 = undefined;
    level.ãÍmq‘+§∞bYå¯Ocq˘PÀ = undefined;
}

// Params 1
// Size: 0x30
function ref_12854( var0 )
{
    if ( validtousesticker() )
    {
        return;
    }
    
    if ( level.matchcountdowntime > 3 )
    {
        var1 = level.matchcountdowntime - 3;
        wait var1;
        dmztut_luicallback( "prematch_end", var0 );
        return;
    }
}

// Params 1
// Size: 0xc2
function loadoutcustomfiresalediscount( var0 )
{
    if ( !getdvarint( "scr_prematch_disable_executions", 1 ) )
    {
        return;
    }
    
    if ( istrue( level.ref_12856 ) )
    {
        return;
    }
    
    level.ref_12856 = 1;
    var1 = getdvarint( "scr_prematch_disable_execution_buffer", 2 );
    var2 = level.players;
    var3 = [ "execution_attack", "execution_victim" ];
    
    foreach ( var5 in var2 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 scripts\common\utility::allow_array( var3, 0 );
    }
    
    wait var0 + var1;
    
    foreach ( var5 in var2 )
    {
        if ( !isdefined( var5 ) || var5 scripts\common\utility::can_execute() )
        {
            continue;
        }
        
        var5 scripts\common\utility::allow_array( var3, 1 );
    }
    
    level.ref_12856 = undefined;
}

// Params 0
// Size: 0x5e
function calculateeventstarttime()
{
    if ( getdvarint( "scr_bmo_use_spawn_fix", 1 ) == 0 )
    {
        return;
    }
    
    var0 = 5;
    var1 = level.matchcountdowntime - var0;
    
    if ( var1 > 0 )
    {
        wait var1;
    }
    
    foreach ( var3 in level.players )
    {
        var3.plotarmor = 1;
    }
    
    thread loadoutcustomfiresalediscount( level );
}

// Params 0
// Size: 0x10
function delay_then_run_wave_override()
{
    var0 = self;
    damagearmor( var0, 150, 1 );
}

// Params 0
// Size: 0x3c
function defend_wave_1()
{
    if ( !isfeatureenabledwrapper( "allowLateJoiners" ) )
    {
        level endon( "game_ended" );
        var0 = getdvarint( "scr_br_nojip_delay", 30 );
        wait var0;
        setnojipscore( 1, 1 );
        setnojiptime( 1, 1 );
        level.nojip = 1;
        return;
    }
}

// Params 7
// Size: 0x23
function ref_12a1c( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = scripts\engine\trace::ray_trace( var0 + ( var1, var2, var3 ), var0 + ( var1, var2, var4 ), var6, var5 );
    return var7;
}

// Params 2
// Size: 0x7b
function reset_button_init( var0, var1 )
{
    if ( !isdefined( level.cratedata ) || !isdefined( level.cratedata.crates ) )
    {
        return;
    }
    
    var2 = var1 * var1;
    var3 = [];
    
    foreach ( var5 in level.cratedata.crates )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var6 = distance2dsquared( var5.origin, var0 );
        
        if ( var6 < var2 )
        {
            var3 = var5;
        }
    }
    
    return var3;
}

// Params 0
// Size: 0x2e
function semtex_used()
{
    var0 = 4000;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.spawn_exfil_enemies ) )
    {
        var0 = level.br_level.spawn_exfil_enemies;
    }
    
    return var0;
}

// Params 0
// Size: 0x2e
function send_all_ai_to_players()
{
    var0 = -1200;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.ref_11a5b ) )
    {
        var0 = level.br_level.ref_11a5b;
    }
    
    return var0;
}

// Params 5
// Size: 0x1c
function modifyplayer_damage( var0, var1, var2, var3, var4 )
{
    var5 = modifyscenenode( var0, var1, var2, var3, var4 );
    return var5[ "position" ];
}

// Params 5
// Size: 0x16
function modifytriggerlocation( var0, var1, var2, var3, var4 )
{
    var5 = modifyscenenode( var0, var1, var2, var3, var4 );
    return var5;
}

// Params 5
// Size: 0x1e1
function modifyscenenode( var0, var1, var2, var3, var4 )
{
    var5 = send_all_ai_to_players();
    var6 = semtex_used();
    var7 = 2500;
    var8 = -19000 + var5;
    var9 = 15;
    
    if ( !isdefined( var1 ) )
    {
        var1 = getdvarint( "scr_br_trace_up", var7 );
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = getdvarint( "scr_br_trace_down", var8 );
    }
    
    var10 = getdvarint( "scr_br_trace_low", var5 );
    var11 = getdvarint( "scr_br_trace_high", var6 );
    var12 = undefined;
    
    if ( isdefined( var3 ) )
    {
        var12 = var3;
    }
    else
    {
        var12 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = [];
    }
    
    var13 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
    
    if ( isdefined( var13.instancesbyref[ "little_bird" ] ) )
    {
        var4 = scripts\engine\utility::array_combine( var4, var13.instancesbyref[ "little_bird" ] );
    }
    
    if ( isdefined( var13.instancesbyref[ "little_bird_mg" ] ) )
    {
        var4 = scripts\engine\utility::array_combine( var4, var13.instancesbyref[ "little_bird_mg" ] );
    }
    
    var14 = reset_button_init( var0, 100 );
    
    if ( isdefined( var14 ) && var14.size > 0 )
    {
        var4 = scripts\engine\utility::array_combine( var4, var14 );
    }
    
    if ( getdvarint( "scr_br_trace_ignore_balloons", 1 ) > 0 )
    {
        var15 = getnearbyskyhookballoons2d( var0, 100 );
        
        if ( var15.size > 0 )
        {
            var4 = scripts\engine\utility::array_combine( var4, var15 );
        }
    }
    
    var16 = ref_12a1c( var0, 0, 0, var1, var2, var12, var4 );
    
    if ( ref_13c32( var16, var10 ) )
    {
        return var16;
    }
    
    var16 = ref_12a1c( var0, var9, 0, var1, var2, var12, var4 );
    
    if ( ref_13c32( var16, var10 ) )
    {
        return var16;
    }
    
    var16 = ref_12a1c( var0, 0, var9, var1, var2, var12, var4 );
    
    if ( ref_13c32( var16, var10 ) )
    {
        return var16;
    }
    
    var16 = ref_12a1c( var0, -1 * var9, 0, var1, var2, var12, var4 );
    
    if ( ref_13c32( var16, var10 ) )
    {
        return var16;
    }
    
    var16 = ref_12a1c( var0, 0, -1 * var9, var1, var2, var12, var4 );
    
    if ( ref_13c32( var16, var10 ) )
    {
        return var16;
    }
    
    var16 = [];
    GscBinSkip0( 0x2e, "position", ( var0[ 0 ], var0[ 1 ], var11 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 2
// Size: 0x1f, Type: bool
function ref_13c32( var0, var1 )
{
    return var0[ "fraction" ] != 1 && var0[ "position" ][ 2 ] > var1;
}

// Params 2
// Size: 0x78
function getnearbyskyhookballoons2d( var0, var1 )
{
    var2 = [];
    
    if ( isdefined( level.ref_13400 ) )
    {
        var3 = var1 * var1;
        
        foreach ( var5 in level.ref_13400.areas_remaining )
        {
            if ( isdefined( var5.chopperexfil_sfx_before_sh070 ) )
            {
                var6 = distance2dsquared( var0, var5.chopperexfil_sfx_before_sh070.origin );
                
                if ( var6 < var3 )
                {
                    var2 = var5.chopperexfil_sfx_before_sh070;
                }
            }
        }
    }
    
    return var2;
}

// Params 0
// Size: 0x4e
function timeoutonabandonedcallback()
{
    if ( !getdvarint( "scr_br_lightweightGameObject", 1 ) )
    {
        return;
    }
    
    if ( self.triggertype == "proximity" && !self.usetime )
    {
        self.touchlist = [];
        self.touchlist[ "neutral" ] = [];
        self.touchlist[ "none" ] = [];
        self.assisttouchlist = undefined;
        return;
    }
}

// Params 2
// Size: 0x2e
function ref_1266c( var0, var1 )
{
    var2 = self calloutmarkerping_entityzoffset( "br_archived_flags" );
    
    if ( istrue( var1 ) )
    {
        var2 |= var0;
    }
    else
    {
        var2 &= ~var0;
    }
    
    self setclientomnvar( "br_archived_flags", var2 );
}

// Params 1
// Size: 0xd
function ref_125cf( var0 )
{
    ref_1266c( 1, var0 );
}

// Params 2
// Size: 0x3e
function round_enemy_stuck_logic( var0, var1 )
{
    if ( scripts\mp\menus::ref_13733() )
    {
        if ( !isdefined( var1 ) && scripts\mp\menus::brking_updateteamscore() )
        {
            return [];
        }
        
        return level.squaddata[ var0 ][ var1 ].players;
    }
    
    return level.teamdata[ var0 ][ "players" ];
}

// Params 2
// Size: 0x5d
function rotationrefsbyseatandweapon( var0, var1 )
{
    if ( scripts\mp\menus::ref_13733() )
    {
        var2 = [];
        
        foreach ( var4 in level.squaddata[ var0 ][ var1 ].players )
        {
            if ( isalive( var4 ) )
            {
                var2 = var4;
            }
        }
        
        return var2;
    }
    
    return level.teamdata[ var4 ][ "alivePlayers" ];
}

// Params 2
// Size: 0x5b
function rotationids( var0, var1 )
{
    if ( scripts\mp\menus::ref_13733() )
    {
        var2 = 0;
        
        foreach ( var4 in level.squaddata[ var0 ][ var1 ].players )
        {
            if ( isalive( var4 ) )
            {
                var2++;
            }
        }
        
        return var2;
    }
    
    return level.teamdata[ var4 ][ "aliveCount" ];
}

// Params 1
// Size: 0x1c
function round_enemies_fallback_logic( var0 )
{
    if ( scripts\mp\menus::ref_13733() )
    {
        return getarraykeys( level.squaddata[ var0 ] );
    }
    
    return [ 0 ];
}

// Params 0
// Size: 0x17
function replace_sat_piece_on_deathordisconnect()
{
    if ( scripts\mp\menus::ref_13733() )
    {
        return level.maxsquadsize;
    }
    
    return level.maxteamsize;
}

// Params 4
// Size: 0x52
function ref_131c3( var0, var1, var2, var3 )
{
    if ( scripts\mp\menus::ref_13733() )
    {
        if ( !isdefined( level.squaddata[ var0 ][ var1 ].difficultytabledata ) )
        {
            level.squaddata[ var0 ][ var1 ].difficultytabledata = [];
        }
        
        level.squaddata[ var0 ][ var1 ].difficultytabledata[ var2 ] = var3;
        return;
    }
    
    level.teamdata[ var0 ][ var2 ] = var3;
}

// Params 3
// Size: 0x56
function round_at_max( var0, var1, var2 )
{
    if ( scripts\mp\menus::ref_13733() )
    {
        if ( !isdefined( level.squaddata[ var0 ][ var1 ].difficultytabledata ) || !isdefined( level.squaddata[ var0 ][ var1 ].difficultytabledata[ var2 ] ) )
        {
            return;
        }
        
        return level.squaddata[ var0 ][ var1 ].difficultytabledata[ var2 ];
    }
    
    return level.teamdata[ var0 ][ var2 ];
}

// Params 5
// Size: 0x67
function ref_1276a( var0, var1, var2, var3, var4 )
{
    if ( scripts\mp\menus::ref_13733() )
    {
        var5 = round_enemy_stuck_logic( var2.team, var2.squadindex );
        
        foreach ( var7 in var5 )
        {
            if ( !isdefined( var3 ) || var7 != var3 )
            {
                self playsoundtoplayer( var0, var7, var4 );
            }
        }
        
        return;
    }
    
    self playsoundtoteam( var0, var1, var3, var4 );
}

// Params 3
// Size: 0x42, Type: bool
function updatesquadmemberlaststandreviveprogress( var0, var1, var2 )
{
    var3 = ( var0[ 0 ], var0[ 1 ], 0 );
    var4 = ( var1[ 0 ], var1[ 1 ], 0 );
    var5 = ( var2[ 0 ], var2[ 1 ], 0 );
    var6 = vectornormalize( var3 - var4 );
    var7 = vectornormalize( var5 - var4 );
    var8 = vectordot( var6, var7 );
    return var8 > 0;
}

// Params 4
// Size: 0xf6
function woods_two_death_func( var0, var1, var2, var3 )
{
    var4 = var0[ 0 ] - var2[ 0 ];
    var5 = var0[ 1 ] - var2[ 1 ];
    var6 = var1[ 0 ] - var2[ 0 ];
    var7 = var1[ 1 ] - var2[ 1 ];
    var8 = float( var3 );
    var9 = var6 - var4;
    var10 = var7 - var5;
    var11 = var9 * var9 + var10 * var10;
    var12 = var4 * var7 - var6 * var5;
    var13 = var8 * var8 * var11 - var12 * var12;
    
    if ( var13 < 0 )
    {
        return;
    }
    
    if ( var13 == 0 )
    {
        var14 = var12 * var10 / var11 + var2[ 0 ];
        var15 = -1 * var12 * var9 / var11 + var2[ 1 ];
        return ( var14, var15, 0 );
    }
    
    var16 = sqrt( var15 );
    var17 = var14 * var12;
    var18 = scripts\engine\utility::sign( var12 ) * var11 * var16;
    var19 = ( var17 + var18 ) / var13 + var4[ 0 ];
    var20 = ( var17 - var18 ) / var13 + var4[ 0 ];
    var21 = -1 * var14 * var11;
    var22 = abs( var12 ) * var16;
    var23 = ( var21 + var22 ) / var13 + var4[ 1 ];
    var24 = ( var21 - var22 ) / var13 + var4[ 1 ];
    return [ ( var19, var23, 0 ), ( var20, var24, 0 ) ];
}

// Params 3
// Size: 0xa6
function registersuperextraweapon( var0, var1, var2 )
{
    var3 = woods_two_death_func( var0, var1, var2.origin, var2.radius );
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    if ( !isarray( var3 ) )
    {
        if ( updatesquadmemberlaststandreviveprogress( var3, var0, var1 ) )
        {
            return var3;
        }
        
        return;
    }
    
    var4 = updatesquadmemberlaststandreviveprogress( var3[ 0 ], var0, var1 );
    var5 = updatesquadmemberlaststandreviveprogress( var3[ 1 ], var0, var1 );
    
    if ( !var4 && !var5 )
    {
        return;
    }
    
    if ( var4 && !var5 )
    {
        return var3[ 0 ];
    }
    
    if ( var5 && !var4 )
    {
        return var3[ 1 ];
    }
    
    var6 = distance2dsquared( var0, var3[ 0 ] );
    var7 = distance2dsquared( var0, var3[ 1 ] );
    
    if ( var6 < var7 )
    {
        return var3[ 0 ];
    }
    
    return var3[ 1 ];
}

// Params 3
// Size: 0x54
function safehouse_struct( var0, var1, var2 )
{
    var3 = var1[ 0 ] - var0[ 0 ];
    var4 = var1[ 1 ] - var0[ 1 ];
    var5 = var1[ 2 ] - var0[ 2 ];
    
    if ( var3 != 0 )
    {
        var6 = ( var2[ 0 ] - var0[ 0 ] ) / var3;
    }
    else
    {
        var6 = ( var3[ 1 ] - var1[ 1 ] ) / var5;
    }
    
    var7 = var1[ 2 ] + var6 * var6;
    return var7;
}

// Params 2
// Size: 0x2c, Type: bool
function updaterectangularzone( var0, var1 )
{
    var2 = var1.origin[ 2 ];
    var3 = var2 + var1.height;
    return var0[ 2 ] >= var2 && var0[ 2 ] <= var3;
}

// Params 3
// Size: 0x1a3
function registertabletinit( var0, var1, var2 )
{
    var3 = woods_two_death_func( var0, var1, var2.origin, var2.radius );
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    if ( !isarray( var3 ) )
    {
        if ( updatesquadmemberlaststandreviveprogress( var3, var0, var1 ) )
        {
            var4 = safehouse_struct( var0, var1, var3 );
            var3 = ( var3[ 0 ], var3[ 1 ], var4 );
            
            if ( updaterectangularzone( var3, var2 ) )
            {
                return var3;
            }
            
            return;
        }
        
        return;
    }
    
    var5 = updatesquadmemberlaststandreviveprogress( var4[ 0 ], var1, var2 );
    var6 = updatesquadmemberlaststandreviveprogress( var4[ 1 ], var1, var2 );
    
    if ( !var5 && !var6 )
    {
        return;
    }
    
    if ( var5 && !var6 )
    {
        var4 = safehouse_struct( var1, var2, var4[ 0 ] );
        var4 = ( var4[ 0 ][ 0 ], var4[ 0 ][ 1 ], var4 );
        
        if ( updaterectangularzone( var4[ 0 ], var3 ) )
        {
            return var4[ 0 ];
        }
        
        return;
    }
    
    if ( var4 && !var6 )
    {
        var4 = safehouse_struct( var2, var3, var5[ 1 ] );
        var5 = ( var5[ 1 ][ 0 ], var5[ 1 ][ 1 ], var4 );
        
        if ( updaterectangularzone( var5[ 1 ], var4 ) )
        {
            return var5[ 1 ];
        }
        
        return;
    }
    
    var4 = safehouse_struct( var3, var4, var6[ 0 ] );
    var6 = ( var6[ 0 ][ 0 ], var6[ 0 ][ 1 ], var4 );
    var7 = updaterectangularzone( var6[ 0 ], var5 );
    var4 = safehouse_struct( var3, var4, var6[ 1 ] );
    var6 = ( var6[ 1 ][ 0 ], var6[ 1 ][ 1 ], var4 );
    var8 = updaterectangularzone( var6[ 1 ], var5 );
    
    if ( !var7 && !var8 )
    {
        return;
    }
    
    if ( var7 && !var8 )
    {
        return var6[ 0 ];
    }
    
    if ( var8 && !var7 )
    {
        return var6[ 1 ];
    }
    
    var9 = distance2dsquared( var3, var6[ 0 ] );
    var10 = distance2dsquared( var3, var6[ 1 ] );
    
    if ( var9 < var10 )
    {
        return var6[ 0 ];
    }
    
    return var6[ 1 ];
}

// Params 3
// Size: 0x89
function ref_12a18( var0, var1, var2 )
{
    var3 = [];
    
    foreach ( var5 in var2 )
    {
        var6 = registersuperextraweapon( var0, var1, var5 );
        
        if ( isdefined( var6 ) )
        {
            var3 = var6;
        }
    }
    
    var8 = undefined;
    var9 = 0;
    
    foreach ( var6 in var3 )
    {
        var11 = distance2dsquared( var0, var6 );
        
        if ( !isdefined( var8 ) || var11 < var9 )
        {
            var8 = var6;
            var9 = var11;
        }
    }
    
    return var8;
}

// Params 3
// Size: 0x89
function ref_12a19( var0, var1, var2 )
{
    var3 = [];
    
    foreach ( var5 in var2 )
    {
        var6 = registertabletinit( var0, var1, var5 );
        
        if ( isdefined( var6 ) )
        {
            var3 = var6;
        }
    }
    
    var8 = undefined;
    var9 = 0;
    
    foreach ( var6 in var3 )
    {
        var11 = distancesquared( var0, var6 );
        
        if ( !isdefined( var8 ) || var11 < var9 )
        {
            var8 = var6;
            var9 = var11;
        }
    }
    
    return var8;
}

// Params 0
// Size: 0x25, Type: bool
function nuke_vault_suicidebombers()
{
    return isalive( self ) && ( scripts\common\vehicle::isvehicle() || isdefined( self.classname ) && self.classname == "script_vehicle" );
}

// Params 0
// Size: 0xe, Type: bool
function shouldusegoldbarassets()
{
    return getdvarint( "scr_br_plunder_use_gold_bar_assets", 0 ) != 0;
}

// Params 3
// Size: 0x31
function runbrgametypefuncwrapper( var0, var1, var2 )
{
    if ( isdefined( level.disable_super_in_turret ) && isdefined( level.disable_super_in_turret.ref_12e05 ) )
    {
        return [[ level.disable_super_in_turret.ref_12e05 ]]( var0, var1, var2 );
    }
}

// Params 1
// Size: 0x2e
function isbrgametypefuncdefinedwrapper( var0 )
{
    if ( isdefined( level.disable_super_in_turret ) && isdefined( level.disable_super_in_turret.tutorial_showtext ) )
    {
        return [[ level.disable_super_in_turret.tutorial_showtext ]]( var0 );
    }
    
    return 0;
}

// Params 1
// Size: 0x2e
function isfeatureenabledwrapper( var0 )
{
    if ( isdefined( level.disable_super_in_turret ) && isdefined( level.disable_super_in_turret.unset_relic_aggressive_melee_params ) )
    {
        return [[ level.disable_super_in_turret.unset_relic_aggressive_melee_params ]]( var0 );
    }
    
    return 0;
}

// Params 0
// Size: 0x65
function gunship_spawnvfx()
{
    level endon( "game_ended" );
    
    if ( level.gametype == "br" )
    {
        wait 0.1;
        
        if ( !isdefined( level.debugforcesre2 ) )
        {
            level.debugforcesre2 = "br_fx";
        }
        
        self setscriptablepartstate( level.debugforcesre2, "clouds" );
        return;
    }
    
    var0 = level._effect[ "vfx_snatch_ac130_clouds" ];
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    wait 0.1;
    playfxontag( var0, self, "tag_body" );
}

// Params 1
// Size: 0x9b
function makepathstruct( var0 )
{
    var1 = var0.r;
    var2 = var0.randomangle;
    var3 = var0.endangleoffset;
    var4 = var0.centerpt;
    var5 = ( var2 + var3 ) % 360;
    var6 = ( var1 * cos( var2 ), var1 * sin( var2 ), scripts\cp_mp\parachute::getc130height() ) + var4;
    var7 = ( var1 * cos( var5 ), var1 * sin( var5 ), scripts\cp_mp\parachute::getc130height() ) + var4;
    var8 = vectornormalize( var7 - var6 );
    var7 += var8 * var1;
    var6 -= var8 * var1 * 2;
    var9 = spawnstruct();
    var9.startpt = var6;
    var9.endpt = var7;
    var9.angle = vectortoangles( var8 );
    return var9;
}

// Params 0
// Size: 0x17
function calctrailpoint()
{
    var0 = self.origin - anglestoforward( self.angles ) * 150;
    return var0;
}

