
// Params 0
// Size: 0x69
function define_as_level_infil_driver()
{
    if ( !ref_11c64( getdvar( "scr_br_gametype" ) ) )
    {
        return;
    }
    
    br_ending_override_init();
    setdvarifuninitialized( "scr_br_ending_enabled", 1 );
    setdvarifuninitialized( "scr_br_exfil_5_chance", 0 );
    
    if ( _getdeathstatecode::vehicle_damage_loadtable() )
    {
        setdvarifuninitialized( "scr_br_ending_6_enabled", 1 );
    }
    else
    {
        setdvarifuninitialized( "scr_br_ending_6_enabled", 0 );
    }
    
    if ( getdvarint( "scr_br_ending_6_enabled", 0 ) == 1 )
    {
        _getdeathstatecode::vehicle_damage_mp_init();
        return;
    }
    
    go_to_combat();
}

// Params 0
// Size: 0x70
function br_ending_override_init()
{
    level.‡¿âe¨;XêRcR! = getdvar( "scr_br_ending_override", "" );
    var0 = 0;
    
    switch ( level.‡¿âe¨;XêRcR! )
    {
        case "victory_screen":
            var0 = scripts\mp\infilexfil\mp_br_ex_victory_screen::victoryscreenexfil_should_enable();
            break;
        default:
            break;
    }
    
    if ( var0 )
    {
        switch ( level.‡¿âe¨;XêRcR! )
        {
            case "victory_screen":
                scripts\mp\infilexfil\mp_br_ex_victory_screen::victoryscreenexfil_init();
                break;
            default:
                break;
        }
        
        return;
    }
}

// Params 0
// Size: 0x2f, Type: bool
function gates_combat()
{
    if ( !getdvarint( "scr_br_ending_enabled" ) )
    {
        return false;
    }
    
    if ( !ref_11c64( getdvar( "scr_br_gametype" ) ) )
    {
        return false;
    }
    
    if ( istrue( level.deletequestobjicon ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0xad
function ref_11c64( var0 )
{
    var1 = 0;
    
    switch ( var0 )
    {
        case "bodycount":
        case "brdov":
        case "truckwar":
        case "zxp":
        case "gxp":
        case "mmp":
        case "respect":
        case "vov":
        case "mendota":
        case "tdbd":
        case "dbd":
        case "brz":
        case "olaride":
        case "rebirth_dbd_reverse":
        case "rebirth_dbd":
        case "rebirth_reverse":
        case "rebirth":
        case "mini":
        case "jugg":
        case "rat_race":
        case "":
            var1 = 1;
            break;
    }
    
    return var1;
}

// Params 0
// Size: 0x43, Type: bool
function should_preload_ending_location()
{
    if ( _getdeathstatecode::vehicle_damage_loadtable() || getdvarint( "scr_br_ending_6_enabled", 0 ) )
    {
        return true;
    }
    
    if ( getdvarint( "scr_br_zxp_exfil", 0 ) == 1 )
    {
        return true;
    }
    
    if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) )
    {
        return istrue( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.š¦ÉYö,‘+¹Œ–ÜÙ );
    }
    
    return false;
}

// Params 2
// Size: 0x81
function ref_13e00( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( should_preload_ending_location() )
    {
        var2 = propminigamefinish( var0, var1, 1 );
        
        if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.™Z+sF–ÜìZ+İ¥ÍìÁ±ÂòYœí9´³–7 ) )
        {
            var3 = level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.™Z+sF–ÜìZ+İ¥ÍìÁ±ÂòYœí9´³–7;
        }
        else
        {
            var3 = var3[ 0 ].origin;
        }
        
        foreach ( var5 in level.players )
        {
            var5 scripts\mp\gametypes\br_public::ref_126b9( var3 );
        }
        
        return;
    }
}

// Params 2
// Size: 0x1bc
function ref_123de( var0, var1 )
{
    if ( !gates_combat() )
    {
        return;
    }
    
    level notify( "stop_suspense_music" );
    var0 = scripts\engine\utility::array_removeundefined( var0 );
    var0 = scripts\engine\utility::array_sort_with_func( var0, &hideleaderhashuntilpercent );
    ref_13fbc( var0 );
    level notify( "br_ending_start" );
    level.disable_back_light = 1;
    
    if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.«ÿ­Jx¡Ã8xn¢Ş?Sou& ) )
    {
        var0 = [[ level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.«ÿ­Jx¡Ã8xn¢Ş?Sou& ]]( var0 );
    }
    
    var2 = randomfloat( 1 ) < getdvarfloat( "scr_br_exfil_5_chance" );
    var3 = propmoveunlock();
    var4 = init_door_ent_flags( var3, var0, var1 );
    
    if ( var2 )
    {
        setomnvarforallclients( "ui_br_bink_overlay_state", 0 );
        thread onjoinedteamcb( level, 15 );
        var3 = "exfil5";
    }
    
    var0 = undefined;
    level.defendkill = var4;
    var4.onping = var3;
    ref_13082( var4, var3, var1 );
    nagstilflag( var4 );
    var5 = name_fx( var4 );
    headicon_image( var4.origin, 1000 );
    hasscrapassist();
    clear_skydivevfx();
    var4 scripts\common\anim::anim_first_frame_solo( var4.gameending, var4.ref_121b8[ 0 ].anime );
    
    foreach ( var7 in level.players )
    {
        var7 cameradefault();
        var7 cameralinkto( var4.gameending, "tag_player", 1, 1 );
        thread nakeddrophandleloadout( var7 );
        
        if ( isdefined( var4.ref_142d0 ) )
        {
            var7 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer( var4.ref_142d0, 0 );
        }
    }
    
    bush_onplayerconnect( var4, 1 );
    
    if ( var2 )
    {
        var9 = 5;
        playcinematicforall( "ch2_s5_exfil_teaser_polina_bink", 1, 1 );
        setomnvarforallclients( "ui_br_bink_overlay_state", 10 );
        wait var9;
        ongrenadeused( var4 );
        setomnvarforallclients( "ui_br_bink_overlay_state", 0 );
    }
    
    wait 1;
    bush_concealment_monitor( var4 );
}

// Params 2
// Size: 0x2a5
function bush_onplayerconnect( var0, var1 )
{
    foreach ( var3 in var0.ref_121b8 )
    {
        if ( isdefined( var3.startfunc ) )
        {
            [[ var3.startfunc ]]( var3.ref_121d4 );
        }
        
        if ( istrue( var1 ) && isdefined( var3.fx ) )
        {
            if ( isdefined( var3.fxtag ) )
            {
                playfxontag( scripts\engine\utility::getfx( var3.fx ), var3.playerzombiejumpcleanup, var3.fxtag );
            }
            else
            {
                playfx( scripts\engine\utility::getfx( var3.fx ), var3.playerzombiemonitorinput, anglestoforward( var3.playerzombiehud ), anglestoup( var3.playerzombiehud ) );
            }
        }
        
        if ( var3.players.size > 0 )
        {
            var3.players = scripts\engine\utility::array_removeundefined( var3.players );
            
            foreach ( var5 in var3.players )
            {
                var5 dontinterpolate();
                
                if ( isdefined( var5.x1fin_playerdisconnect ) )
                {
                    if ( !isplayer( var5 ) )
                    {
                        var5.x1fin_playerdisconnect thread scripts\common\anim::anim_single_solo( var5.player_rig, var3.anime, var5.x1fin_removequestinstance );
                    }
                    else
                    {
                        var5.x1fin_playerdisconnect thread scripts\mp\anim::anim_player_solo( var5, var5.player_rig, var3.anime, var5.x1fin_removequestinstance );
                    }
                    
                    continue;
                }
                
                if ( !isplayer( var5 ) )
                {
                    var0 thread scripts\common\anim::anim_single_solo( var5.player_rig, var3.anime );
                    continue;
                }
                
                var0 thread scripts\mp\anim::anim_player_solo( var5, var5.player_rig, var3.anime );
            }
            
            if ( isdefined( var0.ref_124ea ) )
            {
                foreach ( var8 in var0.ref_124ea )
                {
                    if ( isdefined( var8.player ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( var8.x1fin_playerdisconnect ) )
                    {
                        var8.x1fin_playerdisconnect thread scripts\common\anim::anim_single_solo( var8, var3.anime, var8.x1fin_removequestinstance );
                        continue;
                    }
                    
                    var0 thread scripts\common\anim::anim_single_solo( var8, var3.anime );
                }
            }
        }
        
        if ( var3.ents.size > 0 )
        {
            foreach ( var11 in var3.ents )
            {
                var11 dontinterpolate();
            }
            
            var0 thread scripts\common\anim::anim_single( var3.ents, var3.anime );
        }
        
        var0.gameending dontinterpolate();
        var0 scripts\common\anim::anim_single_solo( var0.gameending, var3.anime );
        waitframe();
        level.defendkill notify( "scene_end" );
    }
    
    level.defendkill notify( "all_scenes_end" );
}

// Params 1
// Size: 0x116
function bush_concealment_monitor( var0 )
{
    foreach ( var2 in var0.ref_121b8 )
    {
        foreach ( var4 in var2.ents )
        {
            if ( isdefined( var4 ) )
            {
                if ( isdefined( var4.linkedents ) )
                {
                    scripts\engine\utility::array_delete( var4.linkedents );
                }
                
                var4 delete();
            }
        }
    }
    
    brking_onplayerconnect();
    
    foreach ( var8 in level.players )
    {
        if ( isdefined( var8 ) && isdefined( var8.player_rig ) )
        {
            if ( isdefined( var8.sessionstate ) && var8.sessionstate == "spectator" )
            {
                var8 setspectatedefaults( var0.origin, var0.angles );
            }
            else
            {
                var8 setorigin( var0.origin );
            }
            
            var8.player_rig delete();
        }
    }
    
    if ( isdefined( var0.gameending ) )
    {
        var0.gameending delete();
        return;
    }
}

// Params 2
// Size: 0x21, Type: bool
function hideleaderhashuntilpercent( var0, var1 )
{
    return var0.pers[ "score" ] >= var1.pers[ "score" ];
}

// Params 0
// Size: 0x34
function ref_13aee()
{
    wait 25;
    
    foreach ( var1 in level.players )
    {
        var1 setplayermusicstate( "" );
    }
}

// Params 1
// Size: 0x1ab
function nagstilflag( var0 )
{
    level.endmatchcameratransitions = 1;
    level notify( "brSpawnPlayersEnding" );
    
    foreach ( var2 in level.players )
    {
        if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.ˆİè{¤eÂ3-K]™ë@ğ¿jk;››— ) )
        {
            var2 thread [[ level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.ˆİè{¤eÂ3-K]™ë@ğ¿jk;››— ]]();
        }
        
        var2 predictstreampos( var0.origin );
        var2 scripts\mp\utility\player::hidehudenable();
        var2 setcinematicmotionoverride( "disabled" );
        var2 setclientomnvar( "ui_br_squad_eliminated_active", 0 );
        
        if ( isdefined( var2.sessionstate ) )
        {
            if ( var2.sessionstate == "dead" )
            {
                var2 thread scripts\mp\playerlogic::spawnintermission( var0.gameending );
            }
            
            if ( var2.sessionstate == "intermission" )
            {
                var2 scripts\mp\utility\player::updatesessionstate( "spectator" );
            }
            
            if ( var2.sessionstate == "spectator" )
            {
                if ( getdvarint( "scr_br_ending_disable_spectating", 0 ) )
                {
                    var2 scripts\mp\gametypes\br_spectate::ref_1252a();
                    var2 scripts\mp\spectating::setdisabled();
                }
                
                var2 setspectatedefaults( var0.gameending.origin, var0.gameending.angles );
                var2 spawn( var0.gameending.origin, var0.gameending.angles );
                continue;
            }
            
            if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.™Z+sF–ÜìZ+İ¥ÍìÁ±ÂòYœí9´³–7 ) )
            {
                var2 setorigin( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.™Z+sF–ÜìZ+İ¥ÍìÁ±ÂòYœí9´³–7 );
            }
            else
            {
                var2 setorigin( var0.origin + ( 0, 0, 100 ) );
            }
            
            if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.¯‘;÷ Ğ»øa³˜˜Šä»›=Ú8(—2q« ) )
            {
                var2 setplayerangles( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.¯‘;÷ Ğ»øa³˜˜Šä»›=Ú8(—2q« );
            }
        }
    }
}

// Params 1
// Size: 0x162
function name_fx( var0 )
{
    var1 = var0.winners;
    var2 = undefined;
    
    foreach ( var4 in var1 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        if ( isdefined( var4.sessionstate ) && var4.sessionstate == "playing" )
        {
            var2 = var4.origin;
            break;
        }
    }
    
    var6 = [];
    var7 = 0;
    
    foreach ( var4 in var1 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        if ( !isplayer( var4 ) )
        {
            continue;
        }
        
        if ( isdefined( var4.sessionstate ) && var4.sessionstate != "playing" )
        {
            var4.forcespawnorigin = var2;
            var4 scripts\mp\playerlogic::spawnplayer( 0 );
        }
        
        namehud( var4 );
        var9 = var4 scripts\mp\teams::lookupcurrentoperator( var4.team );
        var10 = scripts\mp\teams::getoperatorgender( var9 );
        var4.ref_145ca = var7;
        var7++;
        
        if ( !isdefined( var4.animname ) || var4.animname != var4.disable_stealth_reinforcement_icon )
        {
            var4.animname = var4.disable_stealth_reinforcement_icon;
        }
        
        thread ref_124f0();
        create_player_rig( var4, var4.animname, "viewhands_base_iw8", var0 );
        thread nag_radius( level );
        var6 = var4.player_rig;
    }
    
    return var6;
}

// Params 0
// Size: 0x2d
function namehud()
{
    self playershow( 1 );
    ref_1248e();
    ref_12467();
    self.plotarmor = 1;
    scripts\mp\outofbounds::enableoobimmunity( self );
    self.x1fin_playerdisconnect = undefined;
    self.x1fin_removequestinstance = undefined;
}

// Params 1
// Size: 0xfa
function nearby_ai_combat_via_grenade( var0 )
{
    var1 = var0.winners;
    var2 = undefined;
    
    foreach ( var4 in var1 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        if ( isdefined( var4.sessionstate ) && var4.sessionstate == "playing" )
        {
            var2 = var4.origin;
            break;
        }
    }
    
    var6 = 0;
    
    foreach ( var8 in var1 )
    {
        if ( !isdefined( var8 ) )
        {
            continue;
        }
        
        if ( !isplayer( var8 ) )
        {
            continue;
        }
        
        if ( isdefined( var8.player_rig ) )
        {
            var8.player_rig delete();
        }
        
        if ( isdefined( var8.sessionstate ) && var8.sessionstate != "playing" )
        {
            var8.forcespawnorigin = var2;
            var8 scripts\mp\playerlogic::spawnplayer( 0 );
        }
        
        namelocations( var8 );
        var8.ref_145ca = undefined;
        thread ref_124f0();
    }
    
    brking_onplayerconnect();
}

// Params 0
// Size: 0x2c
function namelocations()
{
    self playershow( 1 );
    ref_1248e();
    ref_12468();
    self.plotarmor = 0;
    scripts\mp\outofbounds::disableoobimmunity( self );
    self.x1fin_playerdisconnect = undefined;
    self.x1fin_removequestinstance = undefined;
}

// Params 1
// Size: 0x76
function ref_13fbc( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 = scripts\engine\utility::array_removeundefined( var0 );
    var0 = scripts\engine\utility::array_sort_with_func( var0, &hideleaderhashuntilpercent );
    var1 = -1;
    var2 = 0;
    
    foreach ( var4 in var0 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var5 = 8 * var2;
        var1 &= ~( 255 << var5 );
        var1 |= var4 getentitynumber() << var5;
        var2++;
    }
    
    setomnvarforallclients( "ui_br_winners", var1 );
}

// Params 1
// Size: 0xa6
function init_death_animations( var0 )
{
    var1 = spawn( "script_model", self.origin );
    var1 setmodel( "tag_origin" );
    var1.uniform_suicide_truck_speed_manager = 1;
    var1.disable_stealth_reinforcement_icon = "player0";
    var1.origin = var0.origin;
    var1.angles = var0.angles;
    create_player_rig( var1, var1.disable_stealth_reinforcement_icon, "viewhands_base_iw8", var0 );
    var1 linkto( var1.player_rig, "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread nag_radius( level, var1 );
    var0.winners[ 0 ] = var1;
}

// Params 0
// Size: 0xb2
function ref_1248e()
{
    if ( scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) )
    {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( self.vehicle );
    }
    
    if ( istrue( self.usingascender ) && isdefined( self.cansticktoent ) )
    {
        scripts\cp_mp\auto_ascender::canseesafecircleui();
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
        var0 = vehicle_getarray();
        
        foreach ( var2 in var0 )
        {
            if ( isdefined( var2.owner ) && var2.owner == self )
            {
                if ( isdefined( var2.helperdronetype ) )
                {
                    var2 scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode( 1 );
                }
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x3e
function ref_12467()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self allowmovement( 0 );
    self allowjump( 0 );
    self disableoffhandweapons();
    self allowmelee( 0 );
    self allowads( 0 );
    self allowfire( 0 );
    self disableweaponswitch();
    scripts\common\utility::allow_vehicle_use( 0 );
    self skydive_interrupt();
}

// Params 0
// Size: 0x37
function ref_12468()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self allowmovement( 1 );
    self allowjump( 1 );
    self enableoffhandweapons();
    self allowmelee( 1 );
    self allowads( 1 );
    self allowfire( 1 );
    self enableweaponswitch();
}

// Params 2
// Size: 0x46
function nag_radius( var0, var1 )
{
    var2 = var0.player_rig;
    var3 = isplayer( var0 );
    
    if ( !isdefined( var1 ) )
    {
        var0 waittill( "disconnect" );
    }
    else
    {
        wait 0.1;
    }
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    playfxontag( scripts\engine\utility::getfx( "player_disconnect" ), var2, "tag_player" );
}

// Params 0
// Size: 0x1ad
function ref_124f0()
{
    if ( istrue( self.isjuggernaut ) )
    {
        return;
    }
    
    var0 = undefined;
    var1 = self getweaponslistprimaries();
    
    foreach ( var3 in var1 )
    {
        if ( var3.classname != "rifle" && var3.classname != "spread" && var3.classname != "mg" && var3.classname != "sniper" )
        {
            continue;
        }
        
        var0 = var3;
        
        if ( isdefined( var0 ) )
        {
            break;
        }
    }
    
    if ( !nullweapon( self.currentweapon ) )
    {
        self clearaccessory();
        self takeallweapons();
    }
    else
    {
        waitframe();
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = scripts\mp\class::fixcollision( "s4_ar_stango44", "none", "none", 0 );
    }
    
    if ( getdvarint( "scr_br_zxp_exfil", 0 ) == 1 )
    {
        var5 = [];
        GscBinSkip0( 0x2e, var5.size, "s4_ar_stango44" );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && istrue( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.šß›Öûeğº-è(åXÀïRw“ë ) )
    {
        var6 = 33;
        
        if ( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.¡^…@£™[ÛĞp‚6£) == "villains" )
        {
            var6 = 34;
        }
        
        var1 = scripts\mp\class::fixcollision( "s4_sm_mpapa40", "none", "none", var6 );
    }
    
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var1, undefined, undefined, 1 );
    self.pers[ "primaryWeapon" ] = createheadicon( var1 );
    self.primaryweapon = createheadicon( var1 );
    self.primaryweaponobj = var1;
    self.secondaryweapon = undefined;
    self.secondaryweaponobj = undefined;
    
    if ( self getweaponammoclip( var1 ) < 5 )
    {
        self setweaponammoclip( var1, 5 );
    }
    
    var7 = self switchtoweapon( var1 );
}

// Params 0
// Size: 0x73
function propmoveunlock()
{
    var0 = "chopper";
    
    if ( getdvarint( "scr_br_zxp_exfil", 0 ) == 1 )
    {
        var0 = "chopper_zxp";
    }
    
    if ( getdvarint( "scr_br_ending_6_enabled", 0 ) == 1 )
    {
        var0 = "jeep";
    }
    
    var1 = getdvarint( "scr_br_hvv_exfil", 0 );
    
    if ( var1 == 1 )
    {
        scripts\mp\infilexfil\mp_br_ex_olaride::heroesexfil_init();
    }
    else if ( var1 == 2 )
    {
        scripts\mp\infilexfil\mp_br_ex_olaride::villainsexfil_init();
    }
    
    if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) )
    {
        var0 = level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.¡^…@£™[ÛĞp‚6£);
    }
    
    return var0;
}

// Params 2
// Size: 0xbe
function ref_13082( var0, var1 )
{
    if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.•“U:s8'ëW¾¯ãåEPŒ b€@M ) )
    {
        self [[ level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.•“U:s8'ëW¾¯ãåEPŒ b€@M ]]( var1 );
        return;
    }
    
    switch ( var0 )
    {
        case "chopper":
            givewincondition( var1 );
            break;
        case "jeep":
            _getdeathstatecode::vehicle_damage_getpristinestateminhealth( var1 );
            break;
        case "exfil5":
            oninteractionstarted( var1 );
            break;
        case "chopper_zxp":
            chopperzombieexfil_pack( var1 );
            break;
        case "heroes":
            scripts\mp\infilexfil\mp_br_ex_olaride::heroesexfil_pack( var1 );
            break;
        case "villains":
            scripts\mp\infilexfil\mp_br_ex_olaride::villainsexfil_pack( var1 );
            break;
        default:
            givewincondition( var1 );
            break;
    }
}

// Params 3
// Size: 0x63
function init_door_ent_flags( var0, var1, var2 )
{
    var3 = propmatchslope( var1, var2 );
    var4 = undefined;
    
    switch ( var0 )
    {
        case "chopper":
            var4 = init_carepackages( var3 );
            break;
        case "jeep":
            var4 = init_carepackages( var3 );
            break;
        default:
            var4 = init_carepackages( var3 );
            break;
    }
    
    var3.winners = var1;
    var3.gameending = var4;
    return var3;
}

// Params 2
// Size: 0x38
function propmatchslope( var0, var1 )
{
    var2 = propminigamefinish( var0, var1, 1 );
    
    if ( !isdefined( var2[ 0 ].angles ) )
    {
        var2[ 0 ].angles = ( 0, 0, 0 );
    }
    
    return var2[ 0 ];
}

// Params 3
// Size: 0xe0
function propminigamefinish( var0, var1, var2 )
{
    if ( level.script == "mp_br_mechanics" )
    {
        var3 = scripts\engine\utility::getstructarray( "br_ending_spot", "targetname" );
    }
    else if ( level.script == "mp_br_quarry" )
    {
        var3 = ref_11dc9();
    }
    else if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
    {
        var3 = ref_11dc7();
    }
    else if ( level.script == "mp_don4" )
    {
        var3 = ref_11dcd();
    }
    else if ( level.script == "mp_wz_island" )
    {
        var3 = ref_11df2();
    }
    else if ( level.script == "mp_sm_island_1" )
    {
        var3 = ref_11df3();
    }
    else
    {
        var3 = ref_11dce();
    }
    
    if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) && isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.‘FóëÚ¢|Óë…sƒÿôıå8HƒÒu– ) )
    {
        var3 = [[ level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.‘FóëÚ¢|Óë…sƒÿôıå8HƒÒu– ]]( var3 );
    }
    
    if ( istrue( var3 ) )
    {
        return ref_134d2( var3, var3, var3 );
    }
    
    return var3;
}

// Params 3
// Size: 0x2e
function ref_134d2( var0, var1, var2 )
{
    var1 = scripts\engine\utility::array_removeundefined( var1 );
    
    if ( var1.size > 0 )
    {
        var3 = get_center_of_array( var1 );
    }
    else
    {
        var3 = var3;
    }
    
    var1 = sortbydistance( var1, var3 );
    return var1;
}

// Params 2
// Size: 0x37
function headicon_image( var0, var1 )
{
    var2 = tablesort( var0, var1, 20000 );
    
    foreach ( var4 in var2 )
    {
        scripts\cp_mp\vehicles\vehicle::ref_14197( var4 );
    }
}

// Params 0
// Size: 0x4d
function hasscrapassist()
{
    foreach ( var1 in level.defendkill.winners )
    {
        if ( isdefined( var1.watch_for_molotov_ambush_and_spawners ) )
        {
            scripts\mp\utility\outline::outlinedisable( var1.watch_for_molotov_ambush_and_spawners, var1 );
            var1.watch_for_molotov_ambush_and_spawners = undefined;
        }
    }
}

// Params 0
// Size: 0x42
function clear_skydivevfx()
{
    foreach ( var1 in level.defendkill.winners )
    {
        if ( isdefined( var1 ) )
        {
            var1 setscriptablepartstate( "skydiveVfx", "default", 0 );
        }
    }
}

// Params 0
// Size: 0x18a2
function ref_11dce()
{
    var0 = [];
    GscBinSkip0( 0x2e, 0, init_level_drop_structs( ( -35516, -26964, -290.492 ), ( 0, -37.2493, 0 ), 1 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x187c
function ref_11dcd()
{
    var0 = [];
    GscBinSkip0( 0x2e, 0, init_level_drop_structs( ( -35516, -26964, -290.492 ), ( 0, -37.2493, 0 ), 1 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x29
function ref_11df2()
{
    var0 = [];
    GscBinSkip0( 0x2e, 0, init_level_drop_structs( ( -20150, -19994, 888 ), ( 0, 90, 0 ) ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x93
function ref_11dc9()
{
    var0 = [];
    GscBinSkip0( 0x2e, var0.size, init_level_drop_structs( ( 29786.7, 41132.6, 749.673 ), ( 0, -132.937, 0 ) ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x410
function ref_11dc7()
{
    var0 = [];
    
    if ( getdvarint( "scr_br_zxp_exfil", 0 ) == 1 )
    {
        GscBinSkip0( 0x2e, 0, init_level_drop_structs( ( -1161, 9916, 653 ), ( 0, 60, 0 ) ) );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    GscBinSkip0( 0x2e, 0, init_level_drop_structs( ( -3899, 2190, 693 ), ( 0, 159, 0 ) ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x1aa
function ref_11df3()
{
    var0 = [];
    GscBinSkip0( 0x2e, 0, init_level_drop_structs( ( -10348, -252, 337 ), ( 0, 270, 0 ) ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 3
// Size: 0x1f
function init_level_drop_structs( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.origin = var0;
    var3.angles = var1;
    return var3;
}

#using_animtree( "script_model" );

// Params 0
// Size: 0x31
function init_carepackages()
{
    var0 = spawn( "script_model", self.origin );
    var0 setmodel( "tag_origin" );
    var0 useanimtree( #animtree );
    var0.animname = "endingCam";
    return var0;
}

// Params 1
// Size: 0x5f
function musictriggerthink( var0 )
{
    self notify( "ending_fade_in" );
    self endon( "ending_fade_in" );
    self endon( "disconnect" );
    var1 = var0 * 20;
    var2 = 1;
    var3 = 1 / var1;
    self setclientomnvar( "ui_world_fade", var2 );
    
    for ( var4 = 0; var4 < var1 ; var4++ )
    {
        waitframe();
        var2 -= var3;
        var2 = max( var2, 0 );
        self setclientomnvar( "ui_world_fade", var2 );
    }
}

// Params 1
// Size: 0x5f
function nag_get_in_heli( var0 )
{
    self notify( "ending_fade_out" );
    self endon( "ending_fade_out" );
    self endon( "disconnect" );
    var1 = var0 * 20;
    var2 = 0;
    var3 = 1 / var1;
    self setclientomnvar( "ui_world_fade", var2 );
    
    for ( var4 = 0; var4 < var1 ; var4++ )
    {
        waitframe();
        var2 += var3;
        var2 = min( var2, 1 );
        self setclientomnvar( "ui_world_fade", var2 );
    }
}

// Params 1
// Size: 0x4f
function nakeddrophandleloadout( var0 )
{
    self endon( "disconnect" );
    level.defendkill endon( "scene_end" );
    
    for ( ;; )
    {
        if ( !self isspectatingplayer() )
        {
            waitframe();
            continue;
        }
        
        var1 = self getspectatingplayer();
        
        if ( isdefined( var1 ) )
        {
            var1 waittill( "disconnect" );
            self cameradefault();
            self cameralinkto( var0, "tag_player", 1, 1 );
        }
        
        waitframe();
    }
}

#using_animtree( "" );

// Params 4
// Size: 0x105
function create_player_rig( var0, var1, var2, var3 )
{
    self.animname = var0;
    var4 = var2.origin;
    
    if ( !isdefined( var4 ) )
    {
        var4 = ( 0, 0, 0 );
    }
    
    var5 = spawn( "script_model", var4 );
    var5.player = self;
    self.player_rig = var5;
    self.player_rig setmodel( var1 );
    self.player_rig hide();
    self.player_rig.animname = var0;
    self.player_rig useanimtree( #animtree );
    self.player_rig.ref_145ca = self.ref_145ca;
    self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
    self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;
    
    if ( !isdefined( var2.ref_124ea ) )
    {
        var2.ref_124ea = [];
    }
    
    if ( isplayer( self ) )
    {
        self playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        var2.ref_124ea[ var2.ref_124ea.size ] = self.player_rig;
    }
    else
    {
        self.player_rig.ref_145ca = 0;
    }
    
    self notify( "rig_created" );
}

// Params 0
// Size: 0x1f
function remove_player_rig()
{
    if ( isdefined( self ) )
    {
        self unlink();
    }
    
    if ( isdefined( self.player_rig ) )
    {
        self.player_rig delete();
        return;
    }
}

// Params 1
// Size: 0x76
function get_center_of_array( var0 )
{
    var1 = ( 0, 0, 0 );
    
    for ( var2 = 0; var2 < var0.size ; var2++ )
    {
        var1 = ( var1[ 0 ] + var0[ var2 ].origin[ 0 ], var1[ 1 ] + var0[ var2 ].origin[ 1 ], var1[ 2 ] + var0[ var2 ].origin[ 2 ] );
    }
    
    if ( var0.size != 0 )
    {
        return ( var1[ 0 ] / var0.size, var1[ 1 ] / var0.size, var1[ 2 ] / var0.size );
    }
    
    return undefined;
}

// Params 1
// Size: 0xab0
function givewincondition( var0 )
{
    thread givestartingarmor( 5, var0 );
    
    if ( !getdvarint( "scr_br_ending_placement" ) )
    {
        self.ref_13ce3 = processvoqueue();
        unloadinfiltransient( self.ref_13ce3 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        var1 = getdvarfloat( "scr_br_end_transient_wait", 6 );
        wait var1;
    }
    
    var2 = ref_135ca( "veh8_mil_air_blima_scriptmodel" );
    var2 hidepart( "tag_main_rotor_blade_01" );
    var2 hidepart( "tag_main_rotor_blade_02" );
    var2 hidepart( "tag_main_rotor_blade_03" );
    var2 hidepart( "tag_main_rotor_blade_04" );
    var2 hidepart( "tag_tail_rotor_blade_01" );
    var2 hidepart( "tag_tail_rotor_blade_02" );
    var2 hidepart( "tag_tail_rotor_blade_03" );
    var2 hidepart( "tag_tail_rotor_blade_04" );
    self.onkillingblow = var2;
    givexpwithtext();
    var3 = [ "head_mp_helicopter_crew", "j_spine4" ];
    var4 = [ var3 ];
    var5 = "body_pilot_helicopter_british";
    var6 = ref_135ca( var5, undefined, var4 );
    self.ref_12d97 = var6;
    self.winners = scripts\engine\utility::array_removeundefined( self.winners );
    
    if ( self.winners.size == 0 )
    {
        init_death_animations( self );
    }
    
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "exfilStart", self.winners );
    var7 = ref_135ca( "equipment_fast_rope_wm_01_infil_heli_l" );
    self.rope = var7;
    self.gameending = init_carepackages();
    var8 = [];
    GscBinSkip0( 0x2e, 0, ref_135ca( "misc_wm_ascender", "misc_wm_ascender0" ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0xfaf
function chopperzombieexfil_pack( var0 )
{
    thread givestartingarmor( 5, var0 );
    
    if ( !getdvarint( "scr_br_ending_placement" ) )
    {
        self.ref_13ce3 = processvoqueue();
        unloadinfiltransient( self.ref_13ce3 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        var1 = getdvarfloat( "scr_br_end_transient_wait", 6 );
        wait var1;
    }
    
    self.ref_142d0 = "mp_escape4_exfil_pm_zombie";
    var2 = ref_135ca( "veh8_mil_air_blima_scriptmodel" );
    var2 hidepart( "tag_main_rotor_blade_01" );
    var2 hidepart( "tag_main_rotor_blade_02" );
    var2 hidepart( "tag_main_rotor_blade_03" );
    var2 hidepart( "tag_main_rotor_blade_04" );
    var2 hidepart( "tag_tail_rotor_blade_01" );
    var2 hidepart( "tag_tail_rotor_blade_02" );
    var2 hidepart( "tag_tail_rotor_blade_03" );
    var2 hidepart( "tag_tail_rotor_blade_04" );
    self.onkillingblow = var2;
    givexpwithtext();
    var3 = [ "head_mp_helicopter_crew", "j_spine4" ];
    var4 = [ var3 ];
    var5 = "body_pilot_helicopter_british";
    var6 = ref_135ca( var5, undefined, var4 );
    self.ref_12d97 = var6;
    self.winners = scripts\engine\utility::array_removeundefined( self.winners );
    
    if ( self.winners.size == 0 )
    {
        init_death_animations( self );
    }
    
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "exfilStart", self.winners );
    var7 = ref_135ca( "equipment_fast_rope_wm_01_infil_heli_l" );
    self.rope = var7;
    self.gameending = init_carepackages();
    var8 = [];
    GscBinSkip0( 0x2e, 0, ref_135ca( "misc_wm_ascender", "misc_wm_ascender0" ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x83b
function oninteractionstarted( var0 )
{
    thread givestartingarmor( 5, var0 );
    
    if ( !getdvarint( "scr_br_ending_placement" ) )
    {
        self.ref_13ce3 = processvoqueue();
        unloadinfiltransient( self.ref_13ce3 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        var1 = getdvarfloat( "scr_br_end_transient_wait", 6 );
        wait var1;
    }
    
    var2 = ref_135ca( "veh8_mil_air_blima_scriptmodel" );
    var2 hidepart( "tag_main_rotor_blade_01" );
    var2 hidepart( "tag_main_rotor_blade_02" );
    var2 hidepart( "tag_main_rotor_blade_03" );
    var2 hidepart( "tag_main_rotor_blade_04" );
    var2 hidepart( "tag_tail_rotor_blade_01" );
    var2 hidepart( "tag_tail_rotor_blade_02" );
    var2 hidepart( "tag_tail_rotor_blade_03" );
    var2 hidepart( "tag_tail_rotor_blade_04" );
    self.onkillingblow = var2;
    givexpwithtext();
    var3 = [ "head_mp_helicopter_crew", "j_spine4" ];
    var4 = [ var3 ];
    var5 = "body_pilot_helicopter_british";
    var6 = ref_135ca( var5, undefined, var4 );
    self.ref_12d97 = var6;
    var7 = ref_135ca( "body_mp_rus_s4polina_02" );
    self.ref_127e3 = var7;
    var8 = [ "lm_rus_s4_sandbag_lrg_01_vm", "J_prop_2" ];
    var9 = [ "me_fabric_canopy_01", "J_prop_3" ];
    var10 = [ var8, var9 ];
    var11 = ref_135ca( "generic_prop_x5", undefined, var10 );
    self.ref_12909 = var11;
    var3 = ref_135ca( "head_mp_rus_s4polina_01" );
    var7.head = var3;
    var12 = ref_135ca( "vm_moscar32_01_comp" );
    var7.rifle = var12;
    var7.head hide();
    var7.rifle hide();
    var7 hide();
    var11.linkedents[ 0 ] hide();
    var11.linkedents[ 1 ] hide();
    var11 hide();
    self.winners = scripts\engine\utility::array_removeundefined( self.winners );
    
    if ( self.winners.size == 0 )
    {
        init_death_animations( self );
    }
    
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "exfilStart", self.winners );
    var13 = ref_135ca( "equipment_fast_rope_wm_01_infil_heli_l" );
    self.rope = var13;
    self.gameending = init_carepackages();
    var14 = [];
    GscBinSkip0( 0x2e, 0, ref_135ca( "misc_wm_ascender", "misc_wm_ascender0" ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x11
function onhelmetsniped( var0 )
{
    var0.player scripts\mp\utility\infilexfil::givegunless();
}

// Params 1
// Size: 0x17
function onhotfootplayerkilled( var0 )
{
    setslowmotion( 1, 0.25, 0.1 );
}

// Params 1
// Size: 0x17
function oninstanceremoved( var0 )
{
    setslowmotion( 0.25, 1, 0.1 );
}

// Params 1
// Size: 0x1b
function ongulagendmatch( var0 )
{
    level.defendkill.gameending notify( "single anim", "end" );
}

// Params 1
// Size: 0x26
function ongrenadeused( var0 )
{
    setomnvarforallclients( "ui_world_fade", 1 );
    level.defendkill.gameending notify( "single anim", "end" );
}

// Params 1
// Size: 0x15
function onhack( var0 )
{
    brking_ontimelimit( 4.8, 130, 4, 8 );
}

// Params 0
// Size: 0xe5
function processvoqueue()
{
    switch ( level.script )
    {
        case "mp_donetsk":
            return "mp_infil_br_donetsk_ending_chopper_tr";
        case "mp_donetsk2":
            return "mp_infil_br_donetsk2_ending_chopper_tr";
        case "mp_don3":
            return "mp_infil_br_don3_ending_chopper_tr";
        case "mp_br_quarry":
            return "mp_infil_br_quarry_ending_chopper_tr";
        case "mp_br_mechanics":
            return "mp_infil_br_mechanics_ending_chopper_tr";
        case "mp_kstenod":
            return "mp_infil_br_kstenod_ending_chopper_tr";
        case "mp_escape2":
            return "mp_infil_br_escape2_ending_chopper_tr";
        case "mp_escape2_pm":
            return "mp_infil_br_escape2_pm_ending_chopper_tr";
        case "mp_escape3":
            return "mp_infil_br_escape3_ending_chopper_tr";
        case "mp_escape4":
            return "mp_infil_br_escape4_ending_chopper_tr";
        case "mp_escape4_s5":
            return "mp_infil_br_escape4_ending_chopper_tr";
        case "mp_don4":
            return "mp_infil_br_don4_ending_chopper_tr";
        case "mp_don4_pm":
            return "mp_infil_br_don4_ending_chopper_tr";
        case "mp_wz_island":
            return "mp_infil_br_don4_ending_chopper_tr";
        case "mp_br_tut2":
            return "mp_infil_br_quarry_ending_chopper_tr";
        case "mp_sm_island_1":
            return "mp_infil_br_don4_ending_chopper_tr";
    }
    
    return "";
}

// Params 2
// Size: 0x4e
function givestartingarmor( var0, var1 )
{
    var2 = self.origin + ( 0, 0, 1000 );
    var3 = vectornormalize( var2 - var1 );
    var4 = var2 + var3 * 3000;
    var5 = spawn( "script_model", var4 );
    var5 playsound( "br_exfil_incoming_heli_lr" );
    var5 moveto( var2, var0 );
    wait var0;
    var5 delete();
}

// Params 0
// Size: 0x26b
function givesuperpointsonprematchdone()
{
    if ( level.defendkill.winners.size == 0 )
    {
        return;
    }
    
    var0 = "mus_br3_exfil_intro_3player_intro";
    var1 = "br_exfil_part1_3person_lr";
    
    if ( level.defendkill.onping == "exfil5" )
    {
        var0 = "mus_br_exfil_intro_3player_pm_intro";
        var1 = "br_exfil_part1_3person_lr";
        
        switch ( level.defendkill.winners.size )
        {
            case 1:
                var0 = "mus_br_exfil_intro_1player_polina_intro";
                var1 = "br_exfil_part1_1person_polina_lr";
                break;
            case 2:
                var0 = "mus_br_exfil_intro_2player_polina_intro";
                var1 = "br_exfil_part1_2person_polina_lr";
                break;
            case 3:
                var0 = "mus_br_exfil_intro_3player_polina_intro";
                var1 = "br_exfil_part1_3person_polina_lr";
                break;
            case 4:
                var0 = "mus_br_exfil_intro_4player_polina_intro";
                var1 = "br_exfil_part1_4person_polina_lr";
                break;
        }
        
        soundsettimescalefactor( "br_exfil_fx_unres_2d", 0 );
        soundsettimescalefactor( "br_exfil_lfe_unres_2d", 0 );
        soundsettimescalefactor( "music_lr", 0 );
    }
    else if ( level.defendkill.onping == "chopper_zxp" )
    {
        var0 = "mus_zxp3_zmb_exfil_3player_intro";
        var1 = "br_exfil_part1_3person_lr";
        
        switch ( level.defendkill.winners.size )
        {
            case 1:
                var0 = "mus_zxp3_zmb_exfil_1player_intro";
                var1 = "br_exfil_zmb_part1_1person_lr";
                break;
            case 2:
                var0 = "mus_zxp3_zmb_exfil_2player_intro";
                var1 = "br_exfil_zmb_part1_2person_lr";
                break;
            case 3:
                var0 = "mus_zxp3_zmb_exfil_3player_intro";
                var1 = "br_exfil_zmb_part1_3person_lr";
                break;
            case 4:
                var0 = "mus_zxp3_zmb_exfil_4player_intro";
                var1 = "br_exfil_zmb_part1_4person_lr";
                break;
        }
    }
    else
    {
        var0 = "mus_br3_exfil_intro_3player_intro";
        var1 = "br_exfil_part1_3person_lr";
        
        switch ( level.defendkill.winners.size )
        {
            case 1:
                var0 = "mus_br3_exfil_intro_1player_intro";
                var1 = "br_exfil_part1_1person_lr";
                break;
            case 2:
                var0 = "mus_br3_exfil_intro_2player_intro";
                var1 = "br_exfil_part1_2person_lr";
                break;
            case 3:
                var0 = "mus_br3_exfil_intro_3player_intro";
                var1 = "br_exfil_part1_3person_lr";
                break;
            case 4:
                var0 = "mus_br3_exfil_intro_4player_intro";
                var1 = "br_exfil_part1_4person_lr";
                break;
        }
    }
    
    foreach ( var3 in level.players )
    {
        var3 playlocalsound( var1 );
        var3 playlocalsound( var0 );
    }
    
    waitframe();
    setmusicstate( "" );
    
    foreach ( var3 in level.players )
    {
        var3 setsoundsubmix( "mp_br_exfil_fade", 4 );
    }
}

// Params 0
// Size: 0x7c
function giveteampoints()
{
    if ( level.defendkill.winners.size == 0 )
    {
        return;
    }
    
    var0 = "br_exfil_main_3player_pm";
    
    switch ( level.defendkill.winners.size )
    {
        case 1:
            var0 = "br3_exfil_intro_1player";
            break;
        case 2:
            var0 = "br3_exfil_intro_2player";
            break;
        case 3:
            var0 = "br3_exfil_intro_3player";
            break;
        case 4:
            var0 = "br3_exfil_intro_4player";
            break;
    }
    
    setmusicstate( var0 );
}

// Params 1
// Size: 0x5e
function glgrenade( var0 )
{
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    if ( isdefined( level.defendkill.onping ) && level.defendkill.onping != "exfil5" )
    {
        foreach ( var2 in level.players )
        {
            var2 playlocalsound( "br_exfil_end_part_lr" );
        }
        
        return;
    }
}

// Params 1
// Size: 0x84
function glgrenadeparent( var0 )
{
    thread givequestrewardref();
    thread givesuperpointsonprematchdone();
    
    if ( !scripts\mp\gametypes\br_public::turret_headicon() )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    if ( isdefined( level.defense_wave_send_support ) )
    {
        level.defendkill.ref_12d97 show();
        
        foreach ( var2 in level.players )
        {
            var2.player_rig unlink();
        }
    }
    
    brking_ontimelimit( 2.8, 200 );
}

// Params 1
// Size: 0x91
function glint( var0 )
{
    brking_ontimelimit( 2.8, 250 );
    thread givequestrewardref();
    
    if ( isdefined( level.defense_wave_send_support ) )
    {
        foreach ( var2 in level.defendkill.canspawnontacinsert )
        {
            var2 show();
        }
    }
    
    foreach ( var5 in var0 )
    {
        if ( isdefined( var5 ) )
        {
            var5 scripts\mp\utility\player::ref_1328c( "60", 1 );
        }
    }
}

// Params 1
// Size: 0x252
function glintfx( var0 )
{
    brking_ontimelimit( 2.8, 250 );
    
    if ( getdvarint( "scr_br_zxp_exfil", 0 ) == 1 )
    {
        var1 = 1;
        allplayers_setforcefov( 80, var1 );
    }
    
    if ( !isdefined( level.defense_wave_send_support ) )
    {
        if ( level.defendkill.winners.size < 4 )
        {
            if ( isdefined( level.defendkill.rope ) )
            {
                level.defendkill.rope delete();
            }
        }
    }
    
    thread givequestrewardref();
    jumpiffalse(isdefined( level.defense_wave_send_support )) LOC_000000b8;
    
    foreach ( var3 in level.defendkill.canspawnontacinsert )
    {
        var3 hide();
    }
    
    goto LOC_000000ea;
}

// Params 1
// Size: 0x14a
function onjoinspectators( var0 )
{
    brking_ontimelimit( 4.8, 92, 100, 100 );
    brking_onplayerkilled( 13 );
    level.defendkill.ref_127e3 show();
    level.defendkill.ref_127e3 hidepart( "j_helmet" );
    level.defendkill.ref_127e3 hidepart( "j_head" );
    level.defendkill.ref_127e3.head show();
    level.defendkill.ref_127e3.rifle show();
    level.defendkill.ref_12909 show();
    level.defendkill.ref_12909.linkedents[ 0 ] show();
    
    if ( !isdefined( level.defense_wave_send_support ) )
    {
        if ( level.defendkill.winners.size < 4 )
        {
            if ( isdefined( level.defendkill.rope ) )
            {
                level.defendkill.rope delete();
            }
        }
    }
    
    jumpiffalse(isdefined( level.defense_wave_send_support )) LOC_00000118;
    
    foreach ( var2 in level.defendkill.canspawnontacinsert )
    {
        var2 hide();
    }
    
    return;
}

// Params 1
// Size: 0x84
function global_relic_amped_func( var0 )
{
    foreach ( var2 in level.players )
    {
        var2 setclienttriggeraudiozone( "br_exfil_heli_int", 0.05 );
    }
    
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
    brking_onplayerkilled( 45 );
    brking_ontimelimit( 10, 18 );
    thread givequestrewardref();
    
    if ( level.defendkill.winners.size == 1 )
    {
        thread glgrenade( 1.266 );
        return;
    }
}

// Params 1
// Size: 0x8d
function global_relic_landlocked_func( var0 )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
    brking_onplayerkilled( 50 );
    brking_ontimelimit( 11, 30 );
    thread givequestrewardref();
    
    if ( isdefined( level.defense_wave_send_support ) )
    {
        foreach ( var2 in var0 )
        {
            var2 hide();
        }
    }
    else
    {
        large_transport_initomnvars( var0 );
    }
    
    if ( level.defendkill.winners.size == 2 )
    {
        thread glgrenade( 2.033 );
        return;
    }
}

// Params 1
// Size: 0x53
function global_relic_squadlink_func( var0 )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
    brking_onplayerkilled( 50 );
    brking_ontimelimit( 8, 14.5 );
    thread givequestrewardref();
    
    if ( level.defendkill.winners.size == 3 )
    {
        thread glgrenade( 2 );
        return;
    }
}

// Params 1
// Size: 0x50
function global_relic_team_prox_func( var0 )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
    brking_onplayerkilled( 55 );
    brking_ontimelimit( 3, 29 );
    thread givequestrewardref();
    
    if ( level.defendkill.winners.size == 4 )
    {
        thread glgrenade( 2.5 );
        return;
    }
}

// Params 1
// Size: 0x5a
function global_stealth_broken_func( var0 )
{
    foreach ( var2 in level.players )
    {
        var2 clearclienttriggeraudiozone( 0.1 );
    }
    
    brking_onplayerkilled( 65 );
    brking_ontimelimit( 2.8, 500 );
    thread givequestrewardref();
}

// Params 1
// Size: 0x38
function global_variables( var0 )
{
    foreach ( var2 in var0 )
    {
        if ( isdefined( var2 ) )
        {
            var2 scripts\mp\utility\player::ref_1328c( "30", 1 );
        }
    }
}

// Params 1
// Size: 0x1c
function globalrelicsfunc( var0 )
{
    if ( level.defendkill.winners.size == 1 )
    {
        ref_138b4();
        return;
    }
}

// Params 1
// Size: 0x1c
function globalstruct( var0 )
{
    if ( level.defendkill.winners.size == 2 )
    {
        ref_138b4();
        return;
    }
}

// Params 1
// Size: 0x1c
function go_investigate_loc( var0 )
{
    if ( level.defendkill.winners.size == 3 )
    {
        ref_138b4();
        return;
    }
}

// Params 1
// Size: 0x19
function go_patrol_the_maze( var0 )
{
    if ( !isdefined( level.defense_wave_send_support ) )
    {
        setomnvarforallclients( "ui_world_fade", 1 );
        return;
    }
}

// Params 0
// Size: 0x19
function ref_138b4()
{
    level.defendkill.gameending notify( "single anim", "end" );
}

// Params 0
// Size: 0x42
function givexpwithtext()
{
    if ( !isdefined( level.br_circle ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_circle.dangercircleent ) )
    {
        return;
    }
    
    level.br_circle.dangercircleent brcirclemoveto( self.origin[ 0 ], self.origin[ 1 ], 9000, 0.05 );
}

// Params 1
// Size: 0x42
function large_transport_initomnvars( var0 )
{
    foreach ( var2 in var0 )
    {
        if ( isdefined( var2.linkedents ) )
        {
            scripts\engine\utility::array_delete( var2.linkedents );
        }
        
        var2 delete();
    }
}

// Params 0
// Size: 0x23
function givequestrewardref()
{
    self endon( "death" );
    wait 0.1;
    playfxontag( scripts\engine\utility::getfx( "chopperExfil_rotorwash" ), self, "tag_origin" );
}

// Params 0
// Size: 0x22
function chopper_zombie_playfx()
{
    self endon( "death" );
    wait 0.1;
    playfx( scripts\engine\utility::getfx( "chopperExfil_gas" ), self.origin );
}

// Params 0
// Size: 0x8b
function go_to_combat()
{
    level._effect[ "player_disconnect" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx" );
    
    if ( getdvarint( "scr_br_zxp_exfil", 0 ) == 1 )
    {
        level._effect[ "chopperExfil_rotorwash" ] = loadfx( "vfx/iw8_br/gameplay/vfx_esc4_zmb_blima_rotor_infil.vfx" );
        level._effect[ "chopperExfil_gas" ] = loadfx( "vfx/iw8_br/gameplay/circle/vfx_esc4_zmb_circle_gas_exfil_01.vfx" );
        level._effect[ "vfx_tracer_front_straight" ] = loadfx( "vfx/iw8_br/gameplay/zombie/vfx_zmb_exfil_tracer_front_straight" );
        return;
    }
    
    level._effect[ "chopperExfil_rotorwash" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx" );
    level._effect[ "chopperExfil_gas" ] = loadfx( "vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_exfil_01.vfx" );
}

// Params 2
// Size: 0xf
function onjoinedteamcb( var0, var1 )
{
    wait var0;
    preloadcinematicforall( var1, 1, 0 );
}

// Params 1
// Size: 0x84
function chopperexfilzombie_sh005_start( var0 )
{
    thread givequestrewardref();
    thread chopper_zombie_playfx();
    thread givesuperpointsonprematchdone();
    setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    
    if ( isdefined( level.defense_wave_send_support ) )
    {
        level.defendkill.ref_12d97 show();
        
        foreach ( var2 in level.players )
        {
            var2.player_rig unlink();
        }
    }
    
    brking_ontimelimit( 2.8, 200 );
}

// Params 1
// Size: 0x2f
function chopperexfilzombie_sh010_start( var0 )
{
    brking_ontimelimit( 2.8, 150 );
    allplayers_setforcefov( 49 );
    var0 show();
    thread givequestrewardref();
}

// Params 1
// Size: 0xdf
function chopperexfilzombie_sh020_start( var0 )
{
    var1 = var0[ "winners" ];
    var2 = var0[ "gunner" ];
    var3 = var0[ "zombiesToHide" ];
    var2 hide();
    
    foreach ( var5 in var3 )
    {
        var5 hide();
    }
    
    brking_ontimelimit( 2.8, 250 );
    allplayers_setforcefov( 80 );
    thread givequestrewardref();
    
    if ( isdefined( level.defense_wave_send_support ) )
    {
        foreach ( var8 in level.defendkill.canspawnontacinsert )
        {
            var8 show();
        }
    }
    
    foreach ( var11 in var1 )
    {
        if ( isdefined( var11 ) )
        {
            var11 scripts\mp\utility\player::ref_1328c( "60", 1 );
        }
    }
}

// Params 1
// Size: 0x75
function shoot_gun_from_notetrack( var0 )
{
    if ( isdefined( self.player ) && self.player tagexists( "tag_flash" ) )
    {
        var1 = self.player gettagorigin( "tag_flash" );
        var2 = var1 + anglestoforward( self.player gettagangles( "tag_flash" ) ) * 100;
        magicbullet( self.player.primaryweaponobj.basename, var1, var2 );
        playfxontag( level._effect[ "vfx_tracer_front_straight" ], self.player, "tag_flash" );
        return;
    }
}

// Params 1
// Size: 0x69
function shoot_gun_pistol_from_notetrack( var0 )
{
    if ( isdefined( self.player ) && self.player tagexists( "tag_flash" ) )
    {
        var1 = self.player gettagorigin( "tag_flash" );
        var2 = var1 + anglestoforward( self.player gettagangles( "tag_flash" ) ) * 100;
        magicbullet( "iw8_pi_papa320_mp", var1, var2 );
        playfxontag( level._effect[ "vfx_tracer_front_straight" ], self.player, "tag_flash" );
        return;
    }
}

// Params 1
// Size: 0x2d
function shoot_sfx_from_notetrack( var0 )
{
    var1 = self gettagorigin( "tag_origin" );
    var2 = var1 + anglestoforward( self gettagangles( "tag_origin" ) ) * 100;
    magicbullet( "iw8_ar_mike4_mp", var1, var2 );
}

// Params 5
// Size: 0xa1
function brking_ontimelimit( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = 100;
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = 100;
    }
    
    foreach ( var6 in level.players )
    {
        if ( !isdefined( var6.ref_12f8a ) )
        {
            var6.ref_12f8a = 1;
            var6 enablephysicaldepthoffieldscripting();
        }
        
        if ( isdefined( var4 ) )
        {
            var6 setphysicaldepthoffield( var0, var1, var2, var3, var4 );
            continue;
        }
        
        if ( isdefined( var3 ) )
        {
            var6 setphysicaldepthoffield( var0, var1, var2, var3 );
            continue;
        }
        
        if ( isdefined( var2 ) )
        {
            var6 setphysicaldepthoffield( var0, var1, var2 );
            continue;
        }
        
        var6 setphysicaldepthoffield( var0, var1 );
    }
}

// Params 1
// Size: 0x34
function brking_onplayerkilled( var0 )
{
    foreach ( var2 in level.players )
    {
        var2 setclientdvar( "QTSPTNLOL", var0 );
    }
}

// Params 2
// Size: 0x57
function allplayers_setforcefov( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var3 setclientdvar( "QTSPTNLOL", var0 );
        var3 setclientdvar( "LTMOQONPQ", 1 );
        
        if ( istrue( var1 ) )
        {
            thread resetfov();
        }
    }
}

// Params 0
// Size: 0x3a
function resetfov()
{
    self endon( "disconnect" );
    scripts\engine\utility::waittill_any_ents( level.defendkill, "all_scenes_end", level.defendkill, "scene_end" );
    self setclientdvar( "QTSPTNLOL", 65 );
    self setclientdvar( "LTMOQONPQ", 0 );
}

// Params 0
// Size: 0x3e
function brking_onplayerconnect()
{
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1.ref_12f8a ) )
        {
            var1.ref_12f8a = undefined;
            var1 disablephysicaldepthoffieldscripting();
        }
    }
}

// Params 0
// Size: 0x2
function ref_12f84()
{
    
}

// Params 1
// Size: 0x36
function init_bomb_objective( var0 )
{
    var1 = spawnstruct();
    var1.ents = [];
    var1.players = [];
    var1.gameending = undefined;
    var1.anime = var0;
    var1.ref_121b8 = [];
    return var1;
}

// Params 2
// Size: 0x40
function back_struct( var0, var1 )
{
    level.scr_anim[ var0.animname ][ self.anime ] = var1;
    level.scr_animname[ var0.animname ][ self.anime ] = getanimname( var1 );
    self.ents[ self.ents.size ] = var0;
}

// Params 2
// Size: 0x11
function backendevent( var0, var1 )
{
    self.startfunc = var1;
    self.ref_121d4 = var0;
}

// Params 4
// Size: 0xc2
function back_vector( var0, var1, var2, var3 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var4 = undefined;
    
    if ( !isdefined( var0.disable_stealth_reinforcement_icon ) )
    {
        var4 = "player" + var0 getentitynumber();
        var0.animname = var4;
        var0.disable_stealth_reinforcement_icon = var4;
    }
    else
    {
        var4 = var0.disable_stealth_reinforcement_icon;
    }
    
    self.players[ self.players.size ] = var0;
    var5 = var1;
    
    if ( isdefined( var2 ) )
    {
        if ( isdefined( var0.operatorcustomization ) && isdefined( var0.operatorcustomization.gender ) && var0.operatorcustomization.gender == "female" )
        {
            var5 = var2;
        }
    }
    
    if ( isdefined( var3 ) )
    {
        if ( isdefined( var0.isjuggernaut ) )
        {
            var5 = var3;
        }
    }
    
    level.scr_anim[ var4 ][ self.anime ] = var5;
    level.scr_eventanim[ var4 ][ self.anime ] = getanimname( var5 );
}

// Params 1
// Size: 0x1e
function awardstadiumblueprint( var0 )
{
    self.gameending = 1;
    level.scr_anim[ "endingCam" ][ self.anime ] = var0;
}

// Params 3
// Size: 0x18
function back_field_clip( var0, var1, var2 )
{
    self.fx = var0;
    self.playerzombiemonitorinput = var1;
    self.playerzombiehud = var2;
}

// Params 3
// Size: 0xb5
function ref_135ca( var0, var1, var2 )
{
    var3 = spawn( "script_model", self.origin );
    var3 setmodel( var0 );
    
    if ( !isdefined( var1 ) )
    {
        var1 = var0;
    }
    
    var3.animname = var1;
    var3 useanimtree( #animtree );
    
    if ( isdefined( var2 ) )
    {
        var3.linkedents = [];
        
        foreach ( var5 in var2 )
        {
            var6 = spawn( "script_model", self.origin );
            var6 setmodel( var5[ 0 ] );
            var6 linkto( var3, var5[ 1 ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
            var3.linkedents[ var3.linkedents.size ] = var6;
        }
    }
    
    return var3;
}

// Params 5
// Size: 0x108
function back_door_enemy_watcher( var0, var1, var2, var3, var4 )
{
    var5 = spawn( "script_model", self.origin );
    var5 setmodel( var0 );
    var5 useanimtree( #animtree );
    
    if ( isdefined( var4 ) )
    {
        var6 = var4;
    }
    else
    {
        var6 = var1;
    }
    
    var6.animname = var6;
    level.scr_anim[ var6.animname ][ "br_ending" ] = var3;
    
    if ( isdefined( var4 ) )
    {
        level.scr_animname[ var6.animname ][ "br_ending" ] = var4;
    }
    
    if ( isdefined( var2 ) )
    {
        var6.linkedents = [];
        
        foreach ( var8 in var2 )
        {
            var9 = spawn( "script_model", self.origin );
            var9 setmodel( var8[ 0 ] );
            var9 linkto( var6, var8[ 1 ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
            var6.linkedents[ var6.linkedents.size ] = var9;
        }
    }
    
    self.pack.models[ self.pack.models.size ] = var6;
    return var6;
}

