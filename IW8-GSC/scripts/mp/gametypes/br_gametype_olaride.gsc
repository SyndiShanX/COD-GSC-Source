
// Params 0
// Size: 0x2
function brolaride_initanims()
{
    
}

// Params 0
// Size: 0x3e
function brolaride_loadfx()
{
    level._effect[ "bomb_explosion" ] = loadfx( "vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx" );
    level._effect[ "olarideInfil_bomb" ] = loadfx( "vfx/iw8_br/island/cin/exfil_s5/vfx_br3_infil_bomb_sml_runner.vfx" );
    level._effect[ "vfx_br3_olaride_ashes_visionset" ] = loadfx( "vfx/iw8_br/island/gameplay/vfx_br3_olaride_ashes_visionset.vfx" );
}

// Params 0
// Size: 0xcc
function init()
{
    level.decoyassists = &groundz;
    level.ref_13364 = 1;
    thread brolaride_initfeatures();
    thread brolaride_initpostmain();
    thread brolaride_initdialog();
    thread brolaride_initexternalfeatures();
    level.disable_super_in_turret.„|(óg˜ãÊ?«®"3c—GèÀ+ÿĞ­cd½ = getdvarint( "scr_br_olaride_bomb_site_min_distance_to_bomb_site", 2300 );
    var0 = getdvarint( "scr_br_resurgence_never_ending", 1 );
    level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand( var0 );
    level thread scripts\mp\gametypes\br_gametype_rebirth::enable_traversals_for_bombers();
    thread brolaride_initanims();
    thread brolaride_updateflagonleadersquads();
    brolaride_initbombsites( level );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "dangerCircleTick", &brolaride_dangercircletick );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "mapCenterFinalCircle", &getfinalcircle );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "getFinalCircleCenter", &getfinalcircle );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "game", "onPing", &brolaride_onping );
    level.stage = 1;
    level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË = getdvarint( "scr_br_olaride_objective_item_reward", 1 );
}

// Params 0
// Size: 0xbc
function groundz()
{
    ref_12fdc();
    thread bindingpc();
    level.br_level.br_circledelaytimes = [ 80, 420, 300, 60, 0 ];
    level.br_level.br_circleclosetimes = [ 180, 60, 60, 30, 10 ];
    level.br_level.br_circleradii = [ 75000, 45000, 30000, 20000, 7000, 0 ];
    level.br_level.br_circleminimapradii = [ 9000, 9000, 6500, 4000, 2000 ];
    level.br_level.default_player_connect_black_screen = [ 45, 0, 0, 0, 0 ];
    level.br_level.default_suicidebomber_combat = [ 0, 0, 0, 0, 0 ];
}

// Params 0
// Size: 0x51
function ref_12fdc()
{
    if ( level.mapname == "mp_br_mechanics" )
    {
        level.grouptorewards = ( 626, -2400, 20 );
        return;
    }
    
    level.grouptorewards = scripts\mp\gametypes\br_circle::getrandompointincircle( getdvarvector( "scr_br_olaride_volcano_origin", ( 8387, 15066, 8191 ) ), 13000, 0, 1, 0, 0 );
}

// Params 0
// Size: 0x8
function getfinalcircle()
{
    return level.grouptorewards;
}

// Params 0
// Size: 0x4d
function bindingpc()
{
    level endon( "game_ended" );
    level waittill( "calc_circle_centers" );
    var0 = level.grouptorewards;
    
    for ( var1 = 0; var1 < level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective ; var1++ )
    {
        level.br_level.default_class_chosen[ var1 ] = var0;
    }
}

// Params 0
// Size: 0x24
function brolaride_initfeatures()
{
    level endon( "game_ended" );
    
    if ( getdvarint( "scr_br_olaride_debug", 0 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "allowLateJoiners" );
        return;
    }
}

// Params 0
// Size: 0x33b
function brolaride_initpostmain()
{
    level endon( "game_ended" );
    brolaride_loadfx();
    brolaride_initaudio();
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "drogBagLoadout" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "dropBagLoop" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "firstCircleVo" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "playerCountLandmarks" );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerWelcomeSplashes", &brolaride_playerintrodialogs );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "canTakePickupLoot", &brolaride_cantakepickuploot );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "skipPickupFeedback", &brolaride_skippickupfeedback );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "lootUsedGiveFeedback", &brolaride_lootusedgivefeedback );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onUseCompleted", &brolaride_onusecompleted );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "endGame", &brolaride_endgame );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "preOnPlayerKilled", &brolaride_onplayerkilled );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "createC130PathStruct", &brolaride_createc130pathstruct );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onInfilSequenceEnd", &brolaride_infilsequenceend );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerConnect", &brolaride_onplayerconnect );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "giveStartingPlunder", &brolaride_givestartingplunder );
    waittillframeend();
    brolaride_cleanupents();
    level.ref_140d9 = [];
    level.ref_140d9[ 0 ] = "assassination";
    level.ref_140d9[ 1 ] = "domination";
    level.ref_140d9[ 2 ] = "scavenger";
    scripts\mp\rank::ref_12189( "kill", 100 );
    scripts\mp\rank::ref_12189( "br_cacheOpen", 200 );
    level.disable_super_in_turret.onspawn_slowspeed = getdvarint( "scr_br_olaride_win_xp", 1500 );
    thread brolaride_processlastcalltimer();
    thread bombsite_activatebombsites();
    thread brolaride_initmeter();
    level thread scripts\mp\gametypes\br_publicevent_fafir::postinitfunc();
    thread brolaride_initvisionsetprogression();
    thread brolaride_initcallbacks();
    level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹ = [];
    level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò = [];
    level.disable_super_in_turret.ref_13ab8 = [];
    level.disable_super_in_turret.‘FßƒŠ5{pÚ¹GÃÇKõñİˆÉ! = getdvarint( "scr_br_rebirth_starting_loadout_index", 2 );
    level.disable_super_in_turret.´‹J˜âË3]ç³±å²,c = getdvarint( "scr_br_olaride_starting_plunder", 10 );
    level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã = getdvarint( "scr_br_olaride_victory_points", 8 );
    var0 = getdvarfloat( "scr_br_olaride_last_call_ratio", 0.8 );
    level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿ = int( floor( var0 * level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã ) );
    level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿ = int( clamp( level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿, 1, level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã ) );
    level.disable_super_in_turret.£ëWx§öÁh{BhË®{qö³İ/‚ë<·˜2êè = getdvarint( "scr_br_olaride_bomb_site_max_leader_distance", 750 );
    level.disable_super_in_turret.¾ı‡êØ!SùÓ?µÂ'YgòË(IêÃIåû˜ = getdvarint( "scr_br_olaride_team_death_close_bomb_site_distance", 3200 );
    level.disable_super_in_turret.‹ÜSá@%ûã‹Å¥;pøM™`âjUƒïï = getdvarint( "scr_br_olaride_team_death_respawn_radius", 20500 );
    level.disable_super_in_turret.ŒZ±Âä9^-YÖ;{“²Í²ÑZµ¬ = getdvarint( "scr_br_olaride_carry_item_vo_reset_time", 30 );
    level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½ = [];
    level.Œ¸öL¦Yl£¥Yc+Â#²9n[…ä­nKôV = getdvarint( "scr_br_olaride_bombsite_leader_mark_size", 5000 );
    var1 = getdvarfloat( "scr_br_olaride_bomb_site_leader_point_ratio", 0.6 );
    level.disable_super_in_turret.Šã‹ •+PHŸñRŞs = int( floor( var1 * level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã ) );
    level.disable_super_in_turret.‚ƒà*£µã‘#ŒÀ'ƒû‹²çöxı~ = 0;
    level.disable_super_in_turret.—IÒ+qÏ’ğŸ© = 0;
    level.disable_super_in_turret.§í×—YzÀ1UÈ0]®ç_;óòÏøÙ = 0;
    level.disable_super_in_turret.ß…H?ƒİûêR!®´¼5 Â—p± = getdvarint( "scr_br_olaride_freeze_timer_when_defusing", 1 ) > 0;
    level.disable_super_in_turret.²á“VkÂ-ÍÒ¹ÎÑ´¶V£öÍÑ,É®Í,:–æ = getdvarint( "scr_br_olaride_bomb_timer_start_pulsating", 10 );
}

// Params 0
// Size: 0x12
function brolaride_cleanupents()
{
    scripts\cp_mp\utility\game_utility::ref_12c10( "delete_on_load", "targetname" );
}

// Params 0
// Size: 0x1a1
function brolaride_initdialog()
{
    level endon( "game_ended" );
    level waittill( "br_dialog_initialized" );
    waitframe();
    game[ "dialog" ][ "match_start" ] = "gametype_desc_endgame";
    game[ "dialog" ][ "desc_air1" ] = "end_infil_taunt";
    game[ "dialog" ][ "desc_ground" ] = "gametype_desc_endgame_kits";
    game[ "dialog" ][ "team_victory" ] = "end_match_win";
    game[ "dialog" ][ "volcano_anticipation" ] = "public_event_volcano_announce";
    game[ "dialog" ][ "bomb_disarmed" ] = "end_bomb_disarm";
    game[ "dialog" ][ "bomb_warning" ] = "end_bomb_warning";
    game[ "dialog" ][ "bomb_negative" ] = "end_generic_negative";
    game[ "dialog" ][ "bomb_exploded" ] = "end_bomb_explosion";
    game[ "dialog" ][ "volcano_meter_1" ] = "end_volcano_meter1";
    game[ "dialog" ][ "volcano_meter_2" ] = "end_volcano_meter2";
    game[ "dialog" ][ "volcano_meter_3_hero" ] = "end_volcano_heroes";
    game[ "dialog" ][ "volcano_meter_3_villain" ] = "end_volcano_villains";
    game[ "dialog" ][ "last_call_leading_team_dialog" ] = "end_overtime_winning";
    game[ "dialog" ][ "last_call_other_team_dialog" ] = "end_overtime_enemy";
    game[ "dialog" ][ "hero_contribution_dialog" ] = "end_generic_positive";
    game[ "dialog" ][ "villain_contribution_dialog" ] = "end_generic_positive";
    game[ "dialog" ][ "hero_token_pickup_dialog" ] = "end_generic_positive";
    game[ "dialog" ][ "villain_token_pickup_dialog" ] = "end_generic_positive";
    game[ "dialog" ][ "defuse_kit_pickup_dialog" ] = "gametype_desc_endgame_obj";
    game[ "dialog" ][ "bomb_pickup_dialog" ] = "end_infil_objective";
}

// Params 0
// Size: 0x9
function brolaride_initexternalfeatures()
{
    level endon( "game_ended" );
}

// Params 0
// Size: 0x19
function brolaride_initcallbacks()
{
    while ( !isdefined( level.onplayerspawncallbacks ) )
    {
        waitframe();
    }
    
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &brolaride_onplayerspawned );
}

// Params 0
// Size: 0x68
function brolaride_playerintrodialogs()
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    wait 1;
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        self waittill( "br_jump" );
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "desc_air1", self, 1, 0, undefined, undefined, "mndz" );
        
        while ( !self isonground() )
        {
            waitframe();
        }
        
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "desc_ground", self );
    }
    else
    {
        level waittill( "prematch_done" );
    }
    
    scripts\mp\gametypes\br_analytics::detachriotshield( self );
}

// Params 0
// Size: 0x30
function brolaride_infilsequenceend()
{
    level endon( "game_ended" );
    waitframe();
    thread bombsite_infil_explode();
    level waittill( "olaride_infil_explosion" );
    thread brolaride_introbanner();
    thread brolaride_showscorewidget();
    wait 2;
    thread brolaride_volcanicactivity();
}

// Params 1
// Size: 0x1a
function brolaride_onplayerconnect( var0 )
{
    var0 endon( "disconnect" );
    var0 waittill( "spawned_player" );
    brolaride_givestartingplunder( var0 );
}

// Params 0
// Size: 0x19
function brolaride_givestartingplunder()
{
    scripts\mp\gametypes\br_plunder::playersetplundercount( self.plundercount + level.disable_super_in_turret.´‹J˜âË3]ç³±å²,c );
}

// Params 0
// Size: 0x1a
function brolaride_introbanner()
{
    level endon( "game_ended" );
    wait 4.5;
    ref_13371( "br_olaride_introduction" );
}

// Params 0
// Size: 0x50
function brolaride_showscorewidget()
{
    level endon( "game_ended" );
    wait getdvarfloat( "scr_br_olaride_score_delay", 15 );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) )
        {
            var1 _calloutmarkerping_handleluinotify_added::ref_1313e( "ui_br_olaride_points", 30, 1, 1 );
        }
    }
}

// Params 0
// Size: 0x23
function brolaride_createc130pathstruct()
{
    var0 = scripts\mp\gametypes\br_circle::getrandompointincircle( ( 8387, 15066, 8191 ), 4000 );
    var1 = scripts\mp\gametypes\br_c130::createtestc130path( var0 );
    return var1;
}

// Params 0
// Size: 0x15
function brolaride_getplayersaverageposition()
{
    var0 = scripts\engine\utility::array_removeundefined( level.players );
    return scripts\mp\gametypes\br_ending::get_center_of_array( var0 );
}

// Params 3
// Size: 0x52
function brolaride_playteamdialog( var0, var1, var2 )
{
    foreach ( var4 in level.teamnamelist )
    {
        if ( var4 == var0 )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_luicallback( var1, var4, undefined, undefined, undefined, 1 );
            continue;
        }
        
        level thread scripts\mp\gametypes\br_public::dmztut_luicallback( var2, var4, undefined, undefined, undefined, 1 );
    }
}

// Params 1
// Size: 0xa1
function brolaride_cantakepickuploot( var0 )
{
    if ( var0.scriptablename == "br_bombsite" )
    {
        var1 = var0.tracknonoobplayerlocation getscriptablepartstate( "br_bombsite" );
        
        if ( var1 == "active" )
        {
            if ( istrue( self.½
»g›¸j’ ) )
            {
                return 2;
            }
            else
            {
                return 30;
            }
        }
        else
        {
            return 2;
        }
    }
    else if ( var0.scriptablename == "br_bomb" )
    {
        if ( istrue( self.½
»g›¸j’ ) )
        {
            return 29;
        }
        else
        {
            return 1;
        }
    }
    else if ( var0.scriptablename == "br_defusekit" )
    {
        if ( istrue( self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ) )
        {
            return 31;
        }
        else
        {
            return 1;
        }
    }
    
    return undefined;
}

// Params 4
// Size: 0x2d
function brolaride_skippickupfeedback( var0, var1, var2, var3 )
{
    if ( var0.scriptablename == "br_bombsite" && bombsite_instanceandplayermatch( var0.tracknonoobplayerlocation, var3 ) )
    {
        return 1;
    }
    
    return undefined;
}

// Params 3
// Size: 0x53
function brolaride_lootusedgivefeedback( var0, var1, var2 )
{
    switch ( var2 )
    {
        case 29:
            var1 scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME_TU_WZ350/BR_ALREADY_HAVE_BOMB" );
            return 1;
        case 30:
            var1 scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME_TU_WZ350/BR_NO_BOMB" );
            return 1;
        case 31:
            var1 scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME_TU_WZ350/BR_ALREADY_HAVE_DEFUSEKIT" );
            return 1;
    }
    
    return undefined;
}

// Params 0
// Size: 0x16e
function brolaride_initbombsites()
{
    var0 = getentitylessscriptablearrayinradius( "scriptable_br_bombsite", "classname" );
    var1 = brolaride_createscriptbombsites();
    level.disable_super_in_turret.¸ívÂRsjäıë = scripts\engine\utility::array_combine( var0, var1 );
    level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› = [];
    level.disable_super_in_turret.…ÚhG«?AÕ“±õiw = [];
    level.disable_super_in_turret.‚{1NõÒæÎÍ1Ûµ&Í–Ñ²› = [];
    level.disable_super_in_turret.ª¨øûQYˆ;3'Ë‘°KxGD(ëKˆë°Éf©ÿ = [ 200, 300, 400, 500 ];
    level.disable_super_in_turret.ƒUÄ½k&n-G•}Ø¹:ÒkY = getdvarfloat( "scr_br_olaride_bomb_plant_time", 5 );
    level.disable_super_in_turret.™.µÏ¢Fàé›!~‡Í€ûO+¿J = getdvarfloat( "scr_br_olaride_bomb_defuse_time", 12 );
    level.disable_super_in_turret.lv’…SQã+Ù‹uÉÛ‡z³Û[Ø = getdvarfloat( "scr_br_olaride_bomb_defusekit_time", 6 );
    level.disable_super_in_turret.™‚Â(0JC(Ò‰xÇÉAuµ» = getdvarfloat( "scr_br_olaride_bomb_timer", 70 );
    level.disable_super_in_turret.²©n÷Ó…g“ËápèÅ)ÀÒÄÃ‚kws = getdvarfloat( "scr_br_olaride_bomb_timer_initial", 120 );
    level.disable_super_in_turret.–p3À¢óõ	Ñ3Ë|y(ƒóğHÚE = getdvarfloat( "scr_br_olaride_bomb_last_call_timer", 70 );
    level.disable_super_in_turret.Š
ĞÈë‚‹ğ± Ñ~ÇÀK‡ö‘;Ìkğ = getdvarint( "scr_br_olaride_bomb_site_start_spawning_radius", 40000 );
    level.disable_super_in_turret.¯ñzÊ&ãª[Ø§KÏ(Í‰ÁQ0í€ = getdvarint( "scr_br_olaride_bomb_site_start_count", 15 );
    scripts\engine\scriptable::ref_12f5b( "br_bombsite", &bombsite_used );
    scripts\engine\scriptable::ref_12f5b( "br_bomb", &bomb_used );
    scripts\engine\scriptable::ref_12f5b( "br_defusekit", &defusekit_used );
    level.disable_super_in_turret.º–	-v)"õÈx = [];
    level.disable_super_in_turret.©!Kßñ³3ŞíŒÚ©[ = [];
}

// Params 1
// Size: 0x63
function brolaride_updatebombsitespawningradius( var0 )
{
    var1 = getdvarint( "scr_br_olaride_bomb_site_start_spawning_radius", 40000 );
    var2 = getdvarint( "scr_br_olaride_bomb_site_end_spawning_radius", 20500 );
    var3 = 0;
    
    if ( level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã > 1 )
    {
        var3 = min( var0 / ( level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã - 1 ), 1 );
    }
    
    level.disable_super_in_turret.Š
ĞÈë‚‹ğ± Ñ~ÇÀK‡ö‘;Ìkğ = scripts\engine\math::lerp( var1, var2, var3 );
}

// Params 1
// Size: 0x64
function brolaride_updatebombsiteswantedcount( var0 )
{
    var1 = getdvarint( "scr_br_olaride_bomb_site_start_count", 15 );
    var2 = getdvarint( "scr_br_olaride_bomb_site_end_count", 7 );
    var3 = 0;
    
    if ( level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã > 1 )
    {
        var3 = min( var0 / ( level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã - 1 ), 1 );
    }
    
    level.disable_super_in_turret.¯ñzÊ&ãª[Ø§KÏ(Í‰ÁQ0í€ = int( scripts\engine\math::lerp( var1, var2, var3 ) );
}

// Params 2
// Size: 0xa4
function brolaride_dangercircletick( var0, var1 )
{
    if ( !isdefined( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› ) )
    {
        return;
    }
    
    var2 = level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›;
    
    foreach ( var4 in var2 )
    {
        var5 = var4 getscriptablepartstate( "br_bombsite" );
        
        if ( var5 == "planted" || scripts\engine\utility::array_contains( level.disable_super_in_turret.‚{1NõÒæÎÍ1Ûµ&Í–Ñ²›, var4 ) )
        {
            continue;
        }
        
        if ( !scripts\mp\gametypes\br_circle::updateprestreamrespawn( var4.origin ) )
        {
            level.disable_super_in_turret.‚{1NõÒæÎÍ1Ûµ&Í–Ñ²›[ level.disable_super_in_turret.‚{1NõÒæÎÍ1Ûµ&Í–Ñ²›.size ] = var4;
            thread bombsite_removefromgas();
        }
    }
}

// Params 0
// Size: 0x8f
function brolaride_createscriptbombsites()
{
    var0 = [];
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        var0 = [ bombsite_spawnbombsite( ( 676, -2550, 0 ), ( 0, 90, 0 ) ), bombsite_spawnbombsite( ( 676, -3550, 0 ), ( 0, 90, 0 ) ), bombsite_spawnbombsite( ( 676, -4550, 0 ), ( 0, 90, 0 ) ) ];
    }
    else if ( level.mapname == "mp_wz_island" )
    {
        var0 = brolaride_createislandbombsites();
    }
    
    return var0;
}

// Params 0
// Size: 0x690
function brolaride_createislandbombsites()
{
    var0 = [ [ ( 41134, -42352, 378 ), ( 0, 111, 0 ) ], [ ( 11323, 20305, 6730 ), ( 0, 35, 0 ) ], [ ( 21195, 10991, 4717 ), ( 0, 35, 0 ) ], [ ( -11827, 4094, 650 ), ( 0, 336, 0 ) ], [ ( 26012, 8919, 2578 ), ( 0, 34, 0 ) ], [ ( 14633, 2385, 4677 ), ( 0, 191, 0 ) ], [ ( 12990, 8182, 6066 ), ( 0, 189, 0 ) ], [ ( 12131, 17276, 9312 ), ( 0, 292, 0 ) ], [ ( 11387, 13218, 8664 ), ( 0, 224, 0 ) ], [ ( 14883, 16474, 7345 ), ( 0, 48, 0 ) ], [ ( 28474, 20436, 2336 ), ( 0, 25, 0 ) ], [ ( 1997, 2816, 3353 ), ( 0, 356, 0 ) ], [ ( 18373, 12711, 6298 ), ( 0, 259, 0 ) ], [ ( 7562, 22065, 6298 ), ( 0, 9, 0 ) ], [ ( 20965, 10263, 4747 ), ( 0, 184, 0 ) ], [ ( 7119, -1167, 3819 ), ( 0, 95, 0 ) ], [ ( 21710, 6928, 3365 ), ( 0, 95, 0 ) ], [ ( -4899, 4136, 1939 ), ( 0, 242, 0 ) ], [ ( 17286, 137, 4150 ), ( 0, 109, 0 ) ], [ ( 23197, 18391, 3729 ), ( 0, 87, 0 ) ], [ ( 2939, 27350, 2673 ), ( 0, 297, 0 ) ], [ ( -10862, 36050, 1655 ), ( 0, 239, 0 ) ], [ ( 2112, 19559, 4290 ), ( 0, 295, 0 ) ], [ ( 18367, 21476, 4662 ), ( 0, 66, 0 ) ], [ ( 32779, 26680, 1612 ), ( 0, 345, 0 ) ], [ ( 27917, -3259, 3109 ), ( 0, 323, 0 ) ], [ ( 33609, 32246, 2936 ), ( 0, 181, 0 ) ], [ ( -6478, 31695, 907 ), ( 0, 277, 0 ) ], [ ( -1122, -2420, 2464 ), ( 0, 260, 0 ) ], [ ( 4716, 9291, 5465 ), ( 0, 159, 0 ) ], [ ( 5116, -1495, 3860 ), ( 0, 249, 0 ) ], [ ( 28612, 4652, 1344 ), ( 0, 27, 0 ) ], [ ( 4703, 35221, 1153 ), ( 0, 45, 0 ) ], [ ( 2256, 38714, 674 ), ( 0, 234, 0 ) ], [ ( 3180.5, 39797, 1199.25 ), ( 0, 45, 0 ) ], [ ( -6212, 23907, 890 ), ( 357, 90, 0 ) ], [ ( -2515.25, 9780.75, 3778.5 ), ( 0, 325, 0 ) ], [ ( -10177.3, 18180.5, 2015.25 ), ( 0, 217, 0 ) ], [ ( -28173.5, 4750.25, 3330 ), ( 0, 343, 0 ) ], [ ( -27278, 10795, 2500 ), ( 0, 276, 0 ) ], [ ( 14780.3, 9528.89, 6795 ), ( 0, 39, 0 ) ], [ ( 3359.97, 11608, 5737 ), ( 0, 175.394, 0 ) ], [ ( 12474, 16238, 8679.5 ), ( 0, 271, 0 ) ], [ ( 9648.75, 12613.8, 7108 ), ( 0, 325, 0 ) ], [ ( 15496, -16547, 2873 ), ( 0, 292, 0 ) ], [ ( 2368, -8882, 1799 ), ( 0, 261, 0 ) ], [ ( 25799.5, -19550, 5257.5 ), ( 0, 2.5, 0 ) ], [ ( 15980.4, -5323.74, 3103.46 ), ( 0, 325, 0 ) ], [ ( -5352, -9466.53, 1672.75 ), ( 0, 270, 0 ) ], [ ( -2546.75, -17361.3, 2123.5 ), ( 0, 0, 0 ) ], [ ( -22291.8, -5906.75, 744.25 ), ( 0, 260, 0 ) ], [ ( 29571.3, 15480.4, 2447.5 ), ( 0, 140, 0 ) ], [ ( 19902.3, 24705.8, 4506.75 ), ( 0, 51, 0 ) ], [ ( 28773, 36971, 2642 ), ( 0, 16, 0 ) ] ];
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        var1 = bombsite_spawnbombsite( var3[ 0 ], var3[ 1 ] );
    }
    
    return var1;
}

// Params 2
// Size: 0x13
function bombsite_spawnbombsite( var0, var1 )
{
    var2 = easepower( "br_bombsite", var0, var1 );
    return var2;
}

// Params 0
// Size: 0x7a
function bombsite_activatebombsites()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        bomb_spawnbomb( ( 626, -2300, 20 ) );
        bomb_spawnbomb( ( 626, -2400, 20 ) );
        defusekit_spawndefusekit( ( 550, -2300, 20 ) );
        defusekit_spawndefusekit( ( 550, -2400, 20 ) );
    }
    
    thread bombsite_processbombsiteactivationrequests();
    thread bombsite_spawnmanager();
}

// Params 0
// Size: 0xca
function bombsite_setinitialbombsites()
{
    var0 = level.disable_super_in_turret.¸ívÂRsjäıë;
    var1 = [];
    var2 = level.grouptorewards;
    var3 = level.disable_super_in_turret.Š
ĞÈë‚‹ğ± Ñ~ÇÀK‡ö‘;Ìkğ;
    
    foreach ( var5 in level.disable_super_in_turret.¸ívÂRsjäıë )
    {
        if ( distance2d( var2, var5.origin ) > var3 )
        {
            var0 = scripts\engine\utility::array_remove( var0, var5 );
        }
    }
    
    var7 = getdvarint( "scr_br_olaride_bomb_site_start_count", 15 );
    var7 = min( var7, var0.size );
    var8 = 0;
    var9 = 0;
    var0 = scripts\engine\utility::array_randomize( var0 );
    
    while ( var8 < var7 && var9 < var0.size )
    {
        var5 = var0[ var9 ];
        
        if ( canactivate( var5 ) )
        {
            bombsite_activate( var5 );
            var5.ƒu
Z›ÒsÒèÒÂ = 1;
            var8++;
        }
        
        var9++;
    }
    
    bombsite_autoplantinitialbombsites();
}

// Params 0
// Size: 0xca
function bombsite_spawnmanager()
{
    level endon( "game_ended" );
    bombsite_setinitialbombsites();
    
    for ( ;; )
    {
        var0 = level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›.size;
        var1 = level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£ + level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã;
        var2 = level.disable_super_in_turret.¯ñzÊ&ãª[Ø§KÏ(Í‰ÁQ0í€;
        
        for ( var3 = var2 - var0 + var1; var3 < 0 && level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£ > 0 ; var3++ )
        {
            level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£--;
        }
        
        while ( var3 < 0 && level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã > 0 )
        {
            level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã--;
            var3++;
        }
        
        while ( var3 > 0 )
        {
            if ( bombsite_shouldarmanotherneutralsite() )
            {
                bombsite_requestnewarmedsite();
            }
            else
            {
                bombsite_requestnewsite();
            }
            
            var3--;
        }
        
        wait 3;
    }
}

// Params 0
// Size: 0xa6
function bombsite_processbombsiteactivationrequests()
{
    level endon( "game_ended" );
    level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£ = 0;
    level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã = 0;
    
    for ( ;; )
    {
        if ( level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£ == 0 && level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã == 0 )
        {
            level waittill( "site_requested" );
        }
        
        wait 10;
        
        while ( level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£ > 0 && isdefined( bombsite_tryactivatesite() ) )
        {
            level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£--;
        }
        
        while ( level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã > 0 && isdefined( bombsite_tryactivateandarmsite() ) )
        {
            level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã--;
        }
    }
}

// Params 0
// Size: 0x23
function bombsite_requestnewsite()
{
    var0 = bombsite_tryactivatesite();
    
    if ( isdefined( var0 ) )
    {
        return;
    }
    
    level.disable_super_in_turret.­¶=OËeÈ›óYqÚy¸•ÿ»½£++;
    level notify( "site_requested" );
}

// Params 0
// Size: 0x23
function bombsite_requestnewarmedsite()
{
    var0 = bombsite_tryactivateandarmsite();
    
    if ( isdefined( var0 ) )
    {
        return;
    }
    
    level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã++;
    level notify( "site_requested" );
}

// Params 0
// Size: 0x2b
function bombsite_tryactivatesite()
{
    var0 = bombsite_getpossiblesites( 0 );
    
    if ( var0.size == 0 )
    {
        return undefined;
    }
    
    var1 = bombsite_choosesitetoactivate( var0 );
    
    if ( !isdefined( var1 ) )
    {
        return undefined;
    }
    
    bombsite_activate( var1 );
    return var1;
}

// Params 0
// Size: 0x22
function bombsite_tryactivateandarmsite()
{
    var0 = bombsite_tryactivatesite();
    
    if ( !isdefined( var0 ) )
    {
        return undefined;
    }
    
    bombsite_setupplantedbombsite( var0, undefined, undefined );
    bombsite_setobjectiveasplanted( var0, undefined );
    return var0;
}

// Params 0
// Size: 0x60
function bombsite_shouldarmanotherneutralsite()
{
    if ( !istrue( level.disable_super_in_turret.Œìª`{{‘˜Jo.(â§¹,pxµwšè`â ) )
    {
        return 0;
    }
    
    var0 = getdvarint( "scr_br_olaride_max_neutral_armed_site_count", 1 );
    var1 = brolaride_getneutralbombsitecount() + level.disable_super_in_turret.£ƒá‹UR_¿8[
ã­}VÃ"¦°µ&Ã;
    
    if ( var1 >= var0 )
    {
        return 0;
    }
    
    var2 = getdvarfloat( "scr_br_olaride_chance_spawned_site_is_armed", 1 );
    var3 = var2 >= 1 || randomfloat( 1 ) < var2;
    return var3;
}

// Params 0
// Size: 0x41
function brolaride_getneutralbombsitecount()
{
    var0 = 0;
    
    foreach ( var2 in level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› )
    {
        if ( istrue( var2.–
y¶ÀŸ[éhâ* ) )
        {
            var0++;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x2d
function bombsite_removesitefromactivelist()
{
    var0 = getdvarint( "scr_br_olaride_bomb_site_deactivation_delay", 1 );
    wait var0;
    level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› = scripts\engine\utility::array_remove( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›, self );
}

// Params 0
// Size: 0x86
function bombsite_autoplantinitialbombsites()
{
    var0 = getdvarint( "scr_br_olaride_bomb_site_auto_arm_delay", 24 );
    wait var0;
    var1 = level.disable_super_in_turret.²©n÷Ó…g“ËápèÅ)ÀÒÄÃ‚kws;
    
    if ( var1 > 0 && isdefined( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› ) )
    {
        var2 = getdvarint( "scr_br_olaride_bomb_site_armed_count", 3 );
        
        if ( var2 > 0 )
        {
            var3 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 1, 1 );
            level.disable_super_in_turret.—³Ã½Crğxv=pÀ­Z•sCg = var3;
        }
        
        bombsite_autoplantbomb( var2, 1, var1, level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› );
        return;
    }
}

// Params 4
// Size: 0x7a
function bombsite_autoplantbomb( var0, var1, var2, var3 )
{
    if ( isdefined( var3 ) )
    {
        var4 = var3;
    }
    else
    {
        var4 = bombsite_getpossiblesites( var2 );
    }
    
    var1 = min( var1, var4.size );
    var5 = 0;
    var4 = scripts\engine\utility::array_randomize( var4 );
    
    for ( var6 = 0; var5 < var1 && var6 < var4.size ; var6++ )
    {
        var7 = var4[ var6 ];
        
        if ( !istrue( var2 ) && canactivate( var7 ) )
        {
            bombsite_activate( var7 );
        }
        
        bombsite_setupplantedbombsite( var7, undefined, var3 );
        bombsite_setobjectiveasplanted( var7, undefined );
        var5++;
    }
}

// Params 0
// Size: 0x9a
function bombsite_autoexploderandombomb()
{
    if ( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›.size == 0 )
    {
        return;
    }
    
    var0 = randomint( level.players.size );
    var1 = level.players[ var0 ];
    var2 = scripts\engine\utility::array_randomize( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› );
    
    if ( isdefined( var1 ) )
    {
        foreach ( var4 in var2 )
        {
            var5 = var4 getscriptablepartstate( "br_bombsite" );
            
            if ( var5 == "active" )
            {
                var6 = scripts\mp\utility\teams::getteamdata( var1.team, "players" );
                bombsite_explode( var4, var6 );
                break;
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x85
function bombsite_autodefuserandombomb()
{
    if ( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›.size == 0 )
    {
        return;
    }
    
    var0 = randomint( level.players.size );
    var1 = level.players[ var0 ];
    var2 = scripts\engine\utility::array_randomize( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› );
    
    if ( isdefined( var1 ) )
    {
        foreach ( var4 in var2 )
        {
            var5 = var4 getscriptablepartstate( "br_bombsite" );
            
            if ( var5 == "active" )
            {
                bombsite_defusebomb( var1, var4 );
                break;
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x17a
function bombsite_getpossiblesites( var0 )
{
    var1 = undefined;
    
    if ( var0 )
    {
        var1 = level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›;
    }
    else
    {
        var1 = scripts\engine\utility::array_remove_array( level.disable_super_in_turret.¸ívÂRsjäıë, level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› );
    }
    
    var2 = var1;
    
    foreach ( var4 in var1 )
    {
        var5 = var4 getscriptablepartstate( "br_bombsite" );
        
        if ( var0 && var5 == "planted" )
        {
            var2 = scripts\engine\utility::array_remove( var2, var4 );
            continue;
        }
        
        if ( !( level.mapname == "mp_br_mechanics" ) && !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( var4.origin ) )
        {
            var2 = scripts\engine\utility::array_remove( var2, var4 );
            continue;
        }
        
        var6 = getdvarint( "scr_br_olaride_bomb_site_distance_min", 785 );
        
        foreach ( var8 in level.players )
        {
            if ( isdefined( var8 ) && distance2d( var4.origin, var8.origin ) < var6 )
            {
                var2 = scripts\engine\utility::array_remove( var2, var4 );
                break;
            }
        }
    }
    
    if ( getdvarint( "scr_br_olaride_bomb_site_limit_reuse", 1 ) == 1 )
    {
        var11 = var2;
        
        foreach ( var13 in var11 )
        {
            if ( scripts\engine\utility::array_contains( level.disable_super_in_turret.…ÚhG«?AÕ“±õiw, var13 ) )
            {
                var11 = scripts\engine\utility::array_remove( var11, var13 );
            }
        }
        
        if ( var11.size > 0 )
        {
            return var11;
        }
        else
        {
            bombsite_resetunusablesites();
        }
    }
    
    return var2;
}

// Params 0
// Size: 0xf
function bombsite_resetunusablesites()
{
    level.disable_super_in_turret.…ÚhG«?AÕ“±õiw = [];
}

// Params 2
// Size: 0xdd
function bombsite_choosensitestoactivate( var0, var1 )
{
    var2 = [];
    
    if ( var0.size == 0 )
    {
        return var2;
    }
    
    var3 = level.grouptorewards;
    var4 = level.disable_super_in_turret.Š
ĞÈë‚‹ğ± Ñ~ÇÀK‡ö‘;Ìkğ;
    var0 = scripts\engine\utility::array_randomize( var0 );
    
    foreach ( var6 in var0 )
    {
        var7 = distance2d( var3, var6.origin ) <= var4;
        
        if ( var7 && canactivate( var6 ) )
        {
            var2 = var6;
            
            if ( var2.size >= var1 )
            {
                break;
            }
        }
    }
    
    if ( var2.size < var1 )
    {
        var0 = scripts\engine\utility::get_array_of_closest( var3, var0 );
        
        foreach ( var6 in var0 )
        {
            if ( canactivate( var6 ) )
            {
                var2 = var6;
                
                if ( var2.size >= var1 )
                {
                    break;
                }
            }
        }
        
        bombsite_resetunusablesites();
    }
    
    return var2;
}

// Params 1
// Size: 0x12
function bombsite_choosesitetoactivate( var0 )
{
    var1 = bombsite_choosensitestoactivate( var0, 1 );
    return var1[ 0 ];
}

// Params 1
// Size: 0xc8
function bombsite_activate( var0 )
{
    var1 = var0 getscriptablepartstate( "br_bombsite" );
    
    if ( var1 == "defused" && isdefined( var0.plantedbomb ) )
    {
        var0.plantedbomb setscriptablepartstate( "br_bomb", "hidden" );
    }
    
    var0 setscriptablepartstate( "br_bombsite", "active" );
    var0 setasgametypeobjective();
    var0.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    bombsite_setupobjectiveicon( var0.objidnum, var0.origin );
    bombsite_setobjectiveasactivated( var0 );
    thread bombsite_markclosetopplayers();
    level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›[ level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›.size ] = var0;
    
    if ( !scripts\engine\utility::array_contains( level.disable_super_in_turret.…ÚhG«?AÕ“±õiw, var0 ) )
    {
        level.disable_super_in_turret.…ÚhG«?AÕ“±õiw[ level.disable_super_in_turret.…ÚhG«?AÕ“±õiw.size ] = var0;
        return;
    }
}

// Params 0
// Size: 0x96
function bombsite_removefromgas()
{
    level endon( "game_ended" );
    var0 = getdvarint( "scr_br_olaride_bomb_site_remove_from_gas_delay", 1 );
    wait var0;
    var1 = self getscriptablepartstate( "br_bombsite" );
    
    if ( var1 == "planted" || !scripts\engine\utility::array_contains( level.disable_super_in_turret.‚{1NõÒæÎÍ1Ûµ&Í–Ñ²›, self ) )
    {
        return;
    }
    
    level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› = scripts\engine\utility::array_remove( level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3›, self );
    level.disable_super_in_turret.‚{1NõÒæÎÍ1Ûµ&Í–Ñ²› = scripts\engine\utility::array_remove( level.disable_super_in_turret.‚{1NõÒæÎÍ1Ûµ&Í–Ñ²›, self );
    bombsite_deleteobjectiveicon();
    self setscriptablepartstate( "br_bombsite", "hidden" );
    thread bombsite_removesitefromactivelist();
}

// Params 2
// Size: 0x4f
function showobjectivetoallexcept( var0, var1 )
{
    objective_addalltomask( var0 );
    objective_hidefromplayersinmask( var0 );
    objective_removeallfrommask( var0 );
    
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3 ) && var3 != var1 )
        {
            objective_addclienttomask( var0, var3 );
        }
    }
    
    objective_showtoplayersinmask( var0 );
}

// Params 2
// Size: 0x6d
function bombsite_setupobjectiveicon( var0, var1 )
{
    scripts\mp\objidpoolmanager::objective_add( var0, "current", var1 + ( 0, 0, 90 ), "ui_mp_br_mapmenu_distance_icon_bombsite", "icon_regular" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( var0, 1 );
    scripts\mp\objidpoolmanager::update_objective_ownerteam( var0, undefined );
    scripts\mp\objidpoolmanager::objective_set_play_intro( var0, 1 );
    objective_setshowdistance( var0, 1 );
    playencryptedcinematicforall( var0, 1 );
    getbnetigrbattlepassxpmultiplier( var0, 13000, 15000 );
    scripts\mp\objidpoolmanager::objective_show_on_compass( var0, 1 );
    scripts\mp\objidpoolmanager::objective_playermask_showtoall( var0 );
}

// Params 0
// Size: 0x5d
function bombsite_setobjectiveasactivated()
{
    scripts\mp\objidpoolmanager::update_objective_icon( self.objidnum, "ui_mp_br_mapmenu_distance_icon_bombsite" );
    scripts\mp\objidpoolmanager::update_objective_ownerteam( self.objidnum, undefined );
    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 0 );
    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    scripts\mp\objidpoolmanager::update_objective_setlabel( self.objidnum, "MP_BR_INGAME_TU_WZ350/BR_BOMBSITE_CAPS" );
    scripts\mp\objidpoolmanager::objective_set_play_intro( self.objidnum, 0 );
    scripts\mp\objidpoolmanager::objective_playermask_showtoall( self.objidnum );
}

// Params 2
// Size: 0x47
function bombsite_setobjectiveasplanting( var0, var1 )
{
    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 1 );
    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var0 );
    showobjectivetoallexcept( self.objidnum, var1 );
    scripts\mp\objidpoolmanager::update_objective_setlabel( self.objidnum, "MP_INGAME_ONLY/OBJ_PLANTING_CAPS" );
}

// Params 1
// Size: 0x76
function bombsite_setobjectiveasplanted( var0 )
{
    scripts\mp\objidpoolmanager::update_objective_icon( self.objidnum, "ui_mp_br_mapmenu_distance_icon_bombplant" );
    scripts\mp\objidpoolmanager::update_objective_ownerteam( self.objidnum, var0 );
    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 0 );
    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var0 );
    scripts\mp\objidpoolmanager::update_objective_setlabel( self.objidnum, "MP_BR_INGAME_TU_WZ350/BR_ARMED" );
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS" );
    scripts\mp\objidpoolmanager::objective_playermask_showtoall( self.objidnum );
    self.¶g-n‰²-æv#V™ê›+F = 0;
}

// Params 2
// Size: 0x73
function bombsite_setobjectiveasdisarming( var0, var1 )
{
    scripts\mp\objidpoolmanager::update_objective_icon( self.objidnum, "ui_mp_br_mapmenu_distance_icon_bombdefuse" );
    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 1 );
    scripts\mp\objidpoolmanager::update_objective_ownerteam( self.objidnum, var0 );
    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var0 );
    scripts\mp\objidpoolmanager::update_objective_setlabel( self.objidnum, "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS" );
    scripts\mp\objidpoolmanager::update_objective_setenemylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS" );
    showobjectivetoallexcept( self.objidnum, var1 );
}

// Params 1
// Size: 0x51
function bombsite_updateobjectiveonfailuse( var0 )
{
    if ( var0 == "active" )
    {
        scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, 0 );
        bombsite_setobjectiveasactivated();
        return;
    }
    
    if ( var0 == "planted" )
    {
        self.¶g-n‰²-æv#V™ê›+F = 0;
        
        if ( bombsite_canshowdefuse() )
        {
            scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, 0 );
            bombsite_setobjectiveasplanted( self.‘Æ˜í¶L+NèY°¶ );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0xe, Type: bool
function bombsite_canshowdefuse()
{
    return getdvarint( "scr_br_olaride_bomb_hide_defuse", 0 ) == 0;
}

// Params 2
// Size: 0x118
function bombsite_manageprogressobjectivecountdown( var0, var1 )
{
    self endon( "bombDefused" );
    self endon( "bombExploded" );
    level endon( "game_ended" );
    var2 = gettime();
    var3 = gettime() + var0 * 1000;
    var4 = var3 - var2;
    var5 = 0;
    var6 = 0;
    
    while ( gettime() < var3 || var6 )
    {
        var7 = gettime() - var2;
        var8 = clamp( var7 / var4, 0, 1 );
        var9 = self getscriptablepartstate( "br_bombsite", 1 );
        var10 = ( 1 - var8 ) * var0;
        
        if ( var10 < level.disable_super_in_turret.²á“VkÂ-ÍÒ¹ÎÑ´¶V£öÍÑ,É®Í,:–æ && !istrue( self.
›yË#ã7ôX‰ ) )
        {
            scripts\mp\objidpoolmanager::objective_set_pulsate( self.objidnum, 1 );
            self.
›yË#ã7ôX‰ = 1;
        }
        
        if ( level.disable_super_in_turret.ß…H?ƒİûêR!®´¼5 Â—p± )
        {
            if ( istrue( self.¶g-n‰²-æv#V™ê›+F ) && var5 == 0 )
            {
                var5 = gettime();
            }
            else if ( !istrue( self.¶g-n‰²-æv#V™ê›+F ) && var5 > 0 )
            {
                var11 = gettime() - var5;
                var2 += var11;
                var3 += var11;
                var5 = 0;
            }
            
            var6 = istrue( self.¶g-n‰²-æv#V™ê›+F ) || var5 > 0;
        }
        
        if ( !istrue( self.¶g-n‰²-æv#V™ê›+F ) )
        {
            scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, var8 );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x19
function bombsite_deleteobjectiveicon()
{
    scripts\mp\objidpoolmanager::returnobjectiveid( self.objidnum );
    bombsite_unpingbombsiteforplayers( self, level.players );
}

// Params 1
// Size: 0x2c
function bombsite_unpingbombsite( var0 )
{
    var1 = self calloutmarkerping_getsavedzoffset( 11 );
    
    if ( isdefined( var1 ) && var1.index == var0.index )
    {
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 11 );
        return;
    }
}

// Params 2
// Size: 0x38
function bombsite_unpingbombsiteforplayers( var0, var1 )
{
    foreach ( var3 in var1 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        bombsite_unpingbombsite( var3, var0 );
    }
}

// Params 1
// Size: 0x8e
function brolaride_onping( var0 )
{
    if ( var0 != 7 )
    {
        return;
    }
    
    var1 = self getnodeoffset_code( var0 );
    var2 = undefined;
    
    foreach ( var4 in level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› )
    {
        if ( !isdefined( var4 ) || !isdefined( var4.objidnum ) )
        {
            continue;
        }
        
        if ( var4.objidnum == var1 )
        {
            var2 = var4;
            break;
        }
    }
    
    if ( isdefined( var2 ) )
    {
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( var0 );
        self calloutmarkerping_create( 11, var2.origin, var2.index );
        return;
    }
}

// Params 5
// Size: 0x1f
function bombsite_used( var0, var1, var2, var3, var4 )
{
    if ( !bombsite_canstartusing( var0, var3, var2 ) )
    {
        return;
    }
    
    thread bombsite_usedinternal( var0, var1, var2, var3, var4 );
}

// Params 5
// Size: 0xa1
function bombsite_usedinternal( var0, var1, var2, var3, var4 )
{
    if ( istrue( var3.tracking_max_health ) )
    {
        var3 notify( "br_try_armor_cancel" );
    }
    
    bombsite_initusehold( var3, var2 );
    bombsite_startusing( var3, var0, var2 );
    var5 = bombsite_watchuseinternal( var3, var0, var2 );
    
    if ( isdefined( var3 ) )
    {
        bombsite_stopusing( var3, var0, var5 );
    }
    
    if ( istrue( var5 ) )
    {
        if ( var2 == "active" )
        {
            thread bombsite_plantbomb( var3 );
            brolaride_updatesquaddata( var3, 0 );
        }
        else if ( var2 == "planted" )
        {
            thread bombsite_defusebomb( var3 );
            
            if ( istrue( var3.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ) )
            {
                brolaride_updatesquaddata( var3, 0 );
            }
        }
    }
    else
    {
        bombsite_updateobjectiveonfailuse( var0, var2 );
    }
    
    bombsite_destroyusehold( var3 );
}

// Params 3
// Size: 0xbe, Type: bool
function bombsite_canstartusing( var0, var1, var2 )
{
    if ( istrue( level.gameended ) )
    {
        return false;
    }
    
    if ( !var1 scripts\cp_mp\utility\player_utility::_isalive() || istrue( var1.inlaststand ) )
    {
        return false;
    }
    
    if ( var1 scripts\cp_mp\utility\player_utility::isusingremote() )
    {
        return false;
    }
    
    if ( var1 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( !var1 isonground() )
    {
        return false;
    }
    
    if ( var2 == "defused" )
    {
        var1 scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME_TU_WZ350/BOMBSITE_DEFUSED" );
        return false;
    }
    
    if ( istrue( var1 scripts\mp\gametypes\br_gametypes::ref_12e05( "playerSkipKioskUse", var0 ) ) )
    {
        return false;
    }
    
    if ( istrue( var1.iscarrying ) && !isdefined( var1.get_search_turret_target_player ) )
    {
        var1 scripts\mp\hud_message::showerrormessage( "MP/FIELD_UPGRADE_CANNOT_USE" );
        return false;
    }
    
    if ( !bombsite_instanceandplayermatch( var0, var1 ) )
    {
        return false;
    }
    
    if ( isdefined( var0.isbeingused ) && var0.isbeingused )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x62
function bombsite_instanceandplayermatch( var0, var1 )
{
    var2 = var0 getscriptablepartstate( "br_bombsite" );
    
    if ( var2 == "active" )
    {
        if ( istrue( var1.½
»g›¸j’ ) )
        {
            return 1;
        }
        
        return 0;
    }
    else if ( var2 == "planted" )
    {
        if ( isdefined( var0.‘Æ˜í¶L+NèY°¶ ) )
        {
            var3 = var0.‘Æ˜í¶L+NèY°¶ != var1.team;
        }
        else
        {
            var3 = 1;
        }
        
        return var3;
    }
    
    return 0;
}

// Params 3
// Size: 0x18a, Type: bool
function bombsite_watchuseinternal( var0, var1, var2 )
{
    var0 endon( "disconnect" );
    level endon( "game_ended" );
    var1.id = var0.ƒqáW¨°G–?‰2¸³3ğ.id;
    var1.userate = scripts\engine\utility::ter_op( isdefined( var0.objectivescaler ), var0.objectivescaler, 1 );
    var3 = bombsite_canshowdefuse();
    var4 = !var3 && var2 == "planted";
    var1.“rc³Í³àOğ’ZÃ¦;l|“kòxOhc = var4;
    
    if ( isdefined( var0.ƒqáW¨°G–?‰2¸³3ğ.ref_14099 ) )
    {
        bombsite_playusesound( var0, var0.ƒqáW¨°G–?‰2¸³3ğ.ref_14099 );
    }
    
    while ( isdefined( var0 ) && var0 scripts\cp_mp\utility\player_utility::_isalive() && bombsite_cankeepusing( var0, var1, var2 ) && var0 usebuttonpressed() )
    {
        var0.ƒqáW¨°G–?‰2¸³3ğ.curprogress += level.framedurationseconds * var1.userate;
        
        if ( var0.ƒqáW¨°G–?‰2¸³3ğ.curprogress >= var0.ƒqáW¨°G–?‰2¸³3ğ.usetime )
        {
            var0.ƒqáW¨°G–?‰2¸³3ğ.curprogress = 0;
            return true;
        }
        
        var0 scripts\mp\gameobjects::updateuiprogress( var1, 1, var0.ƒqáW¨°G–?‰2¸³3ğ );
        
        if ( !var4 )
        {
            var5 = clamp( var0.ƒqáW¨°G–?‰2¸³3ğ.curprogress / var0.ƒqáW¨°G–?‰2¸³3ğ.usetime, 0, 1 );
            scripts\mp\objidpoolmanager::objective_set_progress( var1.objidnum, var5 );
        }
        
        waitframe();
    }
    
    if ( isdefined( var0 ) && isdefined( var0.ƒqáW¨°G–?‰2¸³3ğ ) && isdefined( var0.ƒqáW¨°G–?‰2¸³3ğ.curprogress ) )
    {
        var0.ƒqáW¨°G–?‰2¸³3ğ.curprogress = 0;
    }
    
    return false;
}

// Params 3
// Size: 0x96, Type: bool
function bombsite_cankeepusing( var0, var1, var2 )
{
    if ( !scripts\common\utility::is_crate_use_allowed() )
    {
        return false;
    }
    
    if ( !var0 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( var0 meleebuttonpressed() )
    {
        return false;
    }
    
    if ( var0 isinexecutionvictim() )
    {
        return false;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.ƒqáW¨°G–?‰2¸³3ğ ) )
    {
        return false;
    }
    
    var3 = var1 getscriptablepartstate( "br_bombsite", 1 );
    
    if ( var2 != var3 )
    {
        return false;
    }
    
    if ( !bombsite_instanceandplayermatch( var1, var0 ) )
    {
        return false;
    }
    
    var4 = getdvarfloat( "MLLSRQSRT", 128 ) + 16;
    var5 = var4 * var4;
    
    if ( distancesquared( var0.origin, var1.origin ) > var5 )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0xaa
function bombsite_initusehold( var0, var1 )
{
    var0.ƒqáW¨°G–?‰2¸³3ğ = spawnstruct();
    var0.ƒqáW¨°G–?‰2¸³3ğ.curprogress = 0;
    
    if ( var1 == "active" )
    {
        var0.ƒqáW¨°G–?‰2¸³3ğ.id = "planting_explosive";
        var0.ƒqáW¨°G–?‰2¸³3ğ.usetime = level.disable_super_in_turret.ƒUÄ½k&n-G•}Ø¹:ÒkY;
        return;
    }
    
    if ( var1 == "planted" )
    {
        var0.ƒqáW¨°G–?‰2¸³3ğ.id = "breach_defuse";
        var0.ƒqáW¨°G–?‰2¸³3ğ.usetime = scripts\engine\utility::ter_op( istrue( var0.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ), level.disable_super_in_turret.lv’…SQã+Ù‹uÉÛ‡z³Û[Ø, level.disable_super_in_turret.™.µÏ¢Fàé›!~‡Í€ûO+¿J );
        return;
    }
}

// Params 1
// Size: 0xb
function bombsite_destroyusehold( var0 )
{
    var0.ƒqáW¨°G–?‰2¸³3ğ = undefined;
}

// Params 3
// Size: 0x9e
function bombsite_startusing( var0, var1, var2 )
{
    var1.isbeingused = 1;
    var0.‚à’Ã¸CãßÿƒVZÀYÀnØ•¶˜3ëˆ = 1;
    thread bombsite_playusinganimation( var0 );
    thread allowedwhileusingbombsite( var0 );
    var0 scripts\mp\playeractions::allowactionset( "crateUse", 0 );
    
    if ( var2 == "planted" )
    {
        var1.¶g-n‰²-æv#V™ê›+F = 1;
        
        if ( bombsite_canshowdefuse() )
        {
            var0 scripts\mp\gameobjects::updateuiprogress( var1, 0, var0.ƒqáW¨°G–?‰2¸³3ğ );
            bombsite_setobjectiveasdisarming( var1, var0.team, var0 );
            return;
        }
        
        return;
    }
    
    if ( var2 == "active" )
    {
        var0 scripts\mp\gameobjects::updateuiprogress( var1, 0, var0.ƒqáW¨°G–?‰2¸³3ğ );
        bombsite_setobjectiveasplanting( var1, var0.team, var0 );
        return;
    }
}

// Params 3
// Size: 0x7c
function bombsite_stopusing( var0, var1, var2 )
{
    var1.isbeingused = undefined;
    
    if ( !level.gameended )
    {
        var0 scripts\mp\playeractions::allowactionset( "crateUse", 1 );
    }
    
    if ( isdefined( var0.ƒqáW¨°G–?‰2¸³3ğ ) )
    {
        var0 scripts\mp\gameobjects::updateuiprogress( var1, 0, var0.ƒqáW¨°G–?‰2¸³3ğ );
        
        if ( isdefined( var0.ƒqáW¨°G–?‰2¸³3ğ.ref_14099 ) )
        {
            bombsite_stopusesound( var0, var0.ƒqáW¨°G–?‰2¸³3ğ.ref_14099 );
        }
    }
    
    thread allowedwhileusingbombsite( var0 );
    var0 notify( "bomb_site_use_end", var2 );
    var0.‚à’Ã¸CãßÿƒVZÀYÀnØ•¶˜3ëˆ = undefined;
}

// Params 2
// Size: 0xb
function bombsite_playusesound( var0, var1 )
{
    var0 playlocalsound( var1 );
}

// Params 2
// Size: 0xb
function bombsite_stopusesound( var0, var1 )
{
    var0 stoplocalsound( var1 );
}

// Params 0
// Size: 0x14
function disableinputongameended()
{
    wait 0.5;
    scripts\mp\playeractions::allowactionset( "crateUse", 0 );
}

// Params 1
// Size: 0xa8
function bombsite_playusinganimation( var0 )
{
    self endon( "disconnect" );
    self notify( "olaride_bombsite_play_using_animation" );
    self endon( "olaride_bombsite_play_using_animation" );
    scripts\cp_mp\utility\weapon_utility::ref_12eb2();
    var1 = scripts\engine\utility::ter_op( var0 == "active", "briefcase_bomb_mp_vilain", "briefcase_bomb_defuse_mp_vilain" );
    var2 = getcompleteweaponname( var1 );
    
    while ( scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        waitframe();
    }
    
    if ( !scripts\cp_mp\utility\inventory_utility::iscurrentweapon( var2 ) )
    {
        scripts\cp_mp\utility\inventory_utility::_giveweapon( var2 );
        scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var2, 0, 1 );
    }
    
    if ( istrue( self.‚à’Ã¸CãßÿƒVZÀYÀnØ•¶˜3ëˆ ) && !level.gameended )
    {
        scripts\engine\utility::waittill_any_ents( level, "game_ended", self, "bomb_site_use_end" );
    }
    
    if ( level.gameended )
    {
        scripts\mp\playeractions::allowactionset( "crateUse", 1 );
        thread disableinputongameended();
    }
    
    scripts\cp_mp\utility\inventory_utility::getridofweapon( var2 );
}

// Params 3
// Size: 0xd3
function bombsite_setupplantedbombsite( var0, var1, var2 )
{
    var0 setscriptablepartstate( "br_bombsite", "planted" );
    
    if ( !isdefined( var0.plantedbomb ) )
    {
        var3 = var0.angles;
        var4 = anglestoforward( var0.angles ) * 8;
        var4 += ( 0, 0, 38 );
        var3 = ( var3[ 0 ], 180 + var3[ 1 ], var3[ 2 ] );
        var5 = easepower( "br_bomb", var0.origin + var4, var3 );
        var5 setscriptablepartstate( "br_bomb", "planted" );
        var0.plantedbomb = var5;
    }
    else
    {
        var0.plantedbomb setscriptablepartstate( "br_bomb", "planted" );
    }
    
    var0.–
y¶ÀŸ[éhâ* = scripts\engine\utility::ter_op( isdefined( var1 ), undefined, 1 );
    thread bombsite_bombcountdown( var0, var1, var2 );
    bombsite_showsplashtoenemies( var0, var1, "br_bombPlantedInArea", "bomb_warning" );
}

// Params 1
// Size: 0x92
function bombsite_plantbomb( var0 )
{
    var1 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    self.½
»g›¸j’ = undefined;
    var0.¥cçN­Ú = self;
    bombsite_setupplantedbombsite( var0, var1, undefined );
    
    foreach ( var3 in var1 )
    {
        if ( isdefined( var3 ) )
        {
            var3 thread scripts\mp\utility\points::giveunifiedpoints( "br_plant" );
            var3 scripts\mp\hud_message::showsplash( "br_defendTheBomb" );
            var0 disablescriptableplayeruse( var3 );
        }
    }
    
    var0.‘Æ˜í¶L+NèY°¶ = self.team;
    bombsite_setobjectiveasplanted( var0, self.team );
    bombsite_unpingbombsiteforplayers( var0, var1 );
}

// Params 1
// Size: 0x13b
function bombsite_defusebomb( var0 )
{
    getentitylessscriptablearray( "dlog_event_hvv_bombsite_interacted", [ "status", "Bombsite_Defused" ] );
    var0 notify( "bombDefused" );
    var0 setscriptablepartstate( "br_bombsite", "defused" );
    var1 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    
    foreach ( var3 in var1 )
    {
        if ( isdefined( var3 ) )
        {
            var3 thread scripts\mp\utility\points::giveunifiedpoints( "br_defuse" );
            var3 scripts\mp\hud_message::showsplash( "br_youDefusedBomb" );
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "bomb_disarmed", var3, 1, 0 );
        }
    }
    
    if ( isdefined( var0.‘Æ˜í¶L+NèY°¶ ) )
    {
        var5 = scripts\mp\utility\teams::getteamdata( var0.‘Æ˜í¶L+NèY°¶, "players" );
        
        foreach ( var3 in var5 )
        {
            if ( isdefined( var3 ) )
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "bomb_negative", var3, 1, 0 );
            }
        }
        
        showsplashtoteam( var0, var0.‘Æ˜í¶L+NèY°¶, "br_bombDefusedEnemy" );
    }
    
    brolaride_givematchpoint( 1, var1 );
    bombsite_givereward( var0, 1, var1 );
    bombsite_deleteobjectiveicon( var0 );
    
    if ( istrue( var0.§ôCi[‰O6³šÄ ~ ) )
    {
        bombsite_deleteleadericon( var0 );
    }
    
    thread bombsite_removesitefromactivelist();
    
    if ( istrue( self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ) )
    {
        self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë = undefined;
        return;
    }
}

// Params 1
// Size: 0x19d
function bombsite_explode( var0 )
{
    self notify( "bombExploded" );
    self setscriptablepartstate( "br_bombsite", "explode" );
    
    if ( isdefined( self.plantedbomb ) )
    {
        self.plantedbomb setscriptablepartstate( "br_bomb", "hidden" );
    }
    
    var1 = "bomb_explosion";
    var2 = self.origin;
    var3 = var2 + ( 0, 0, 0 );
    var4 = spawnfx( level._effect[ var1 ], var3 );
    triggerfx( var4 );
    physicsexplosionsphere( var3, 200, 100, 3 );
    
    if ( isdefined( self.¥cçN­Ú ) )
    {
        self.¥cçN­Ú radiusdamage( var2, 512, 200, 20, self.¥cçN­Ú, "MOD_EXPLOSIVE", "bomb_site_mp" );
    }
    else
    {
        radiusdamage( var2, 512, 200, 20, level.disable_super_in_turret.—³Ã½Crğxv=pÀ­Z•sCg, "MOD_EXPLOSIVE", "bomb_site_mp" );
    }
    
    playrumbleonposition( "grenade_rumble", var2 );
    earthquake( 0.75, 2, var2, 2000 );
    playsoundatpos( var3, "exp_bombsite_lr" );
    
    if ( isdefined( var0 ) )
    {
        if ( isdefined( self.¥cçN­Ú ) )
        {
            self.¥cçN­Ú dlog_recordplayerevent( "dlog_event_hvv_bombsite_interacted", [ "status", "Bombsite_Exploded" ] );
        }
        
        foreach ( var6 in var0 )
        {
            if ( isdefined( var6 ) )
            {
                var6 thread scripts\mp\utility\points::giveunifiedpoints( "br_detonate" );
                var6 scripts\mp\hud_message::showsplash( "br_youDestroyedBombsite" );
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "bomb_exploded", var6, 1, 0, undefined, undefined, "mndz" );
            }
        }
        
        brolaride_givematchpoint( 0, var0 );
        bombsite_givereward( 0, var0 );
    }
    
    bombsite_deleteobjectiveicon();
    
    if ( istrue( self.§ôCi[‰O6³šÄ ~ ) )
    {
        bombsite_deleteleadericon();
    }
    
    thread bombsite_removesitefromactivelist();
    level notify( "olaride_meter_boost" );
}

// Params 4
// Size: 0x90
function bombsite_showsplashtoenemies( var0, var1, var2, var3 )
{
    var4 = level.players;
    
    if ( isdefined( var0 ) )
    {
        var4 = scripts\engine\utility::array_remove_array( var4, var0 );
    }
    
    if ( isdefined( var3 ) )
    {
        var4 = scripts\engine\utility::array_remove_array( var4, var3 );
    }
    
    var5 = getdvarint( "scr_br_olaride_dist_for_splash", 6000 );
    
    foreach ( var7 in var4 )
    {
        if ( isdefined( var7 ) )
        {
            var8 = distance2d( var7.origin, self.origin );
            
            if ( var8 <= var5 )
            {
                var7 scripts\mp\hud_message::showsplash( var1 );
                
                if ( isdefined( var2 ) )
                {
                    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var2, var7, 1, 0 );
                }
            }
        }
    }
}

// Params 2
// Size: 0xa9
function bombsite_givereward( var0, var1 )
{
    level endon( "game_ended" );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = undefined;
    
    foreach ( var4 in var1 )
    {
        if ( isdefined( var4 ) )
        {
            var2 = var4.team;
            break;
        }
    }
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var6 = 0;
    
    if ( var0 )
    {
        var6 = level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var2 ];
    }
    else
    {
        var6 = level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var2 ];
    }
    
    var6 = floor( var6 / level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã * 5 );
    var6 = int( max( var6, 1 ) );
    bombsite_givelootreward( var0, var6 );
    bombsite_givepointsreward( var0, var6, var1 );
}

// Params 2
// Size: 0x13e
function bombsite_givelootreward( var0, var1 )
{
    self.itemsdropped = 0;
    var2 = bombsite_getlootreward( var0, var1 );
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var3 = spawnstruct();
    var3.origin = self.origin;
    var3.angles = self.angles;
    var3.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var3.dropstruct.ml_p3_to_safehouse_transition = 14;
    var3.dropstruct.silencer_pick_up_monitor = 50;
    
    if ( !var0 )
    {
        var3.dropstruct.ml_p3_to_safehouse_transition = 14;
        var3.dropstruct.silencer_pick_up_monitor = 100;
    }
    
    var4 = self.angles + ( 0, 45, 0 );
    
    foreach ( var6 in var2 )
    {
        var7 = var6[ 0 ];
        var8 = var6[ 1 ];
        
        if ( scripts\mp\gametypes\br_lootcache::get_bonus_targets( var7 ) )
        {
            for ( var9 = 0; var9 < var8 ; var9++ )
            {
                var10 = scripts\mp\gametypes\br_lootcache::ref_11a41( var7, var3.dropstruct, self.origin + ( 0, 0, var3.dropstruct.silencer_pick_up_monitor ), var4, 0, 0 );
                
                if ( !var0 )
                {
                    var3.dropstruct.silencer_pick_up_monitor += 3;
                }
                
                self.itemsdropped++;
                waitframe();
            }
        }
    }
}

// Params 3
// Size: 0x5e
function bombsite_givepointsreward( var0, var1, var2 )
{
    var3 = level.disable_super_in_turret.ª¨øûQYˆ;3'Ë‘°KxGD(ëKˆë°Éf©ÿ[ var1 - 1 ];
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    foreach ( var5 in var2 )
    {
        if ( isdefined( var5 ) )
        {
            if ( var0 )
            {
                giveheropoints( var5, var3 );
                continue;
            }
            
            givevillainpoints( var5, var3 );
        }
    }
}

// Params 2
// Size: 0x5b5
function bombsite_getlootreward( var0, var1 )
{
    if ( var0 )
    {
        switch ( var1 )
        {
            case 1:
                return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "br_defusekit", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
            case 2:
                return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "br_defusekit", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
            case 3:
                return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "br_defusekit", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
            case 4:
                return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_specialist_bonus", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_specialist_bonus", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_specialist_bonus", 1 ], [ "brloot_offhand_smoke", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_specialist_bonus", 1 ], [ "br_defusekit", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
            default:
                return;
        }
        
        return;
    }
    
    switch ( var1 )
    {
        case 1:
            return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "br_bomb", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
        case 2:
            return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "br_bomb", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
        case 3:
            return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "br_bomb", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
        case 4:
            return [ [ "brloot_super_munitionsbox", 1 ], [ "brloot_specialist_bonus", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_specialist_bonus", 1 ], [ "brloot_super_armorbox", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_specialist_bonus", 1 ], [ "brloot_offhand_c4", 1 ], [ "brloot_plunder_cash_uncommon_2", 1 ], [ "brloot_offhand_slinger", 1 ], [ "brloot_specialist_bonus", 1 ], [ "br_bomb", level.ä¢h1RØqÅ÷o¨\Gncjk±›“k?ùİHeË ] ];
        default:
            return;
    }
}

// Params 3
// Size: 0x3e
function bombsite_bombcountdown( var0, var1, var2 )
{
    level endon( "game_ended" );
    self endon( "bombDefused" );
    var3 = undefined;
    
    if ( isdefined( var1 ) )
    {
        var3 = var1;
    }
    else
    {
        var3 = level.disable_super_in_turret.™‚Â(0JC(Ò‰xÇÉAuµ»;
    }
    
    bombsite_manageprogressobjectivecountdown( var3, var2 );
    bombsite_explode( var0 );
}

// Params 0
// Size: 0x5d
function bombsite_infil_explode()
{
    var0 = ( 8387, 15066, 8191 );
    var1 = var0 + ( 0, 0, 50 );
    var2 = playfx( level._effect[ "olarideInfil_bomb" ], var1 );
    var2 unmarkkeyframedmover( 1 );
    earthquake( 0.75, 2, var0, 0 );
    playsoundatpos( var1, "exp_bombsite_lr" );
    waitframe();
    level notify( "olaride_infil_explosion" );
}

// Params 0
// Size: 0x84
function bombsite_markclosetopplayers()
{
    self endon( "bombExploded" );
    self endon( "bombDefused" );
    level endon( "game_ended" );
    var0 = self getscriptablepartstate( "br_bombsite" );
    
    for ( var1 = []; var0 == "active" ; var1 = var2 )
    {
        wait 0.5;
        var2 = bombsite_updatenearleaders();
        
        if ( var2.size == 1 && var1.size > 0 )
        {
            bombsite_updatenewsolojoinleader( var1, var2 );
        }
        
        if ( var2.size > 0 )
        {
            bombsite_showleadericon( var2 );
            continue;
        }
        
        if ( istrue( self.§ôCi[‰O6³šÄ ~ ) && istrue( self.‡wÍĞŞîÊ‘YÉ´Ø·› ) )
        {
            bombsite_hideleadericon();
        }
    }
}

// Params 0
// Size: 0xa9
function bombsite_updatenearleaders()
{
    var0 = [];
    var1 = level.disable_super_in_turret.£ëWx§öÁh{BhË®{qö³İ/‚ë<·˜2êè * level.disable_super_in_turret.£ëWx§öÁh{BhË®{qö³İ/‚ë<·˜2êè;
    
    foreach ( var3 in level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½ )
    {
        var4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var3 );
        
        foreach ( var6 in var4 )
        {
            if ( isalive( var6 ) && distance2dsquared( self.origin, var6.origin ) < var1 )
            {
                var0 = scripts\engine\utility::array_add( var0, var3 );
                break;
            }
        }
    }
    
    return var0;
}

// Params 2
// Size: 0x49
function bombsite_updatenewsolojoinleader( var0, var1 )
{
    if ( !scripts\engine\utility::array_contains( var0, var1[ 0 ] ) )
    {
        var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var1[ 0 ] );
        
        foreach ( var4 in var2 )
        {
            if ( isdefined( var4 ) )
            {
                scripts\mp\gametypes\br_quest_util::spawn_dogtags( var4 );
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x30
function bombsite_createleadericon()
{
    var0 = 1;
    var1 = 20;
    scripts\mp\gametypes\br_quest_util::init_tactical_boxes( var0, var1, 0, self.origin );
    scripts\mp\gametypes\br_quest_util::ref_1316f( level.Œ¸öL¦Yl£¥Yc+Â#²9n[…ä­nKôV );
    self.§ôCi[‰O6³šÄ ~ = 1;
    self.‡wÍĞŞîÊ‘YÉ´Ø·› = 0;
}

// Params 0
// Size: 0xd
function bombsite_deleteleadericon()
{
    scripts\mp\gametypes\br_quest_util::lastdirtyscore();
    self.§ôCi[‰O6³šÄ ~ = 0;
}

// Params 1
// Size: 0x60
function bombsite_showleadericon( var0 )
{
    if ( var0.size > 1 )
    {
        var1 = level.players;
    }
    else
    {
        var1 = scripts\mp\utility\teams::getenemyplayers( var1[ 0 ], 0 );
    }
    
    if ( !istrue( self.§ôCi[‰O6³šÄ ~ ) )
    {
        bombsite_createleadericon();
    }
    
    foreach ( var3 in var1 )
    {
        scripts\mp\gametypes\br_quest_util::ref_1336a( var3 );
    }
    
    self.‡wÍĞŞîÊ‘YÉ´Ø·› = 1;
}

// Params 0
// Size: 0xd
function bombsite_hideleadericon()
{
    scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    self.‡wÍĞŞîÊ‘YÉ´Ø·› = 0;
}

// Params 1
// Size: 0x30
function bomb_spawnbomb( var0 )
{
    var1 = easepower( "br_bomb", var0 );
    scripts\mp\gametypes\br_pickups::ref_12b3a( var1 );
    level.disable_super_in_turret.º–	-v)"õÈx[ level.disable_super_in_turret.º–	-v)"õÈx.size ] = var1;
}

// Params 5
// Size: 0xf
function bomb_used( var0, var1, var2, var3, var4 )
{
    brolaride_onpickupbomb( var3 );
}

// Params 1
// Size: 0x30
function defusekit_spawndefusekit( var0 )
{
    var1 = easepower( "br_defusekit", var0 );
    scripts\mp\gametypes\br_pickups::ref_12b3a( var1 );
    level.disable_super_in_turret.©!Kßñ³3ŞíŒÚ©[[ level.disable_super_in_turret.©!Kßñ³3ŞíŒÚ©[.size ] = var1;
}

// Params 5
// Size: 0xf
function defusekit_used( var0, var1, var2, var3, var4 )
{
    brolaride_onpickupdefusekit( var3 );
}

// Params 0
// Size: 0x11a
function brolaride_updateflagonleadersquads()
{
    level endon( "game_ended" );
    
    for ( var0 = [];  ; var0 = level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½ )
    {
        wait 0.5;
        
        foreach ( var2 in level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½ )
        {
            var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var2 );
            
            foreach ( var5 in var3 )
            {
                if ( isdefined( var5 ) )
                {
                    if ( brolaride_shoulddisplayflagonplayer( var5 ) )
                    {
                        var5 scripts\mp\gametypes\br_gametype_kingslayer::carriabletype();
                        continue;
                    }
                    
                    var5 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
                }
            }
        }
        
        foreach ( var2 in var0 )
        {
            if ( !scripts\engine\utility::array_contains( level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½, var2 ) )
            {
                var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var2 );
                
                foreach ( var5 in var3 )
                {
                    if ( isdefined( var5 ) )
                    {
                        var5 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
                    }
                }
            }
        }
    }
}

// Params 1
// Size: 0x6c, Type: bool
function brolaride_shoulddisplayflagonplayer( var0 )
{
    if ( !isalive( var0 ) )
    {
        return false;
    }
    
    var1 = level.disable_super_in_turret.£ëWx§öÁh{BhË®{qö³İ/‚ë<·˜2êè * level.disable_super_in_turret.£ëWx§öÁh{BhË®{qö³İ/‚ë<·˜2êè;
    
    foreach ( var3 in level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› )
    {
        if ( distance2dsquared( var3.origin, var0.origin ) < var1 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x33
function brolaride_detachallflag()
{
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) )
        {
            var1 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
        }
    }
}

// Params 0
// Size: 0x4c
function brolaride_onpickupbomb()
{
    if ( istrue( self.½
»g›¸j’ ) )
    {
        return;
    }
    
    if ( !isdefined( self.¡õc…—•FlX99åö¶&ö ) )
    {
        self.¡õc…—•FlX99åö¶&ö = 1;
        scripts\mp\gametypes\br_public::brleaderdialog( "bomb_pickup_dialog", 1, [ self ], 1, 0, undefined, "mndz" );
        thread brolaride_monitorplayedcarryitemvo( 1 );
    }
    
    self.½
»g›¸j’ = 1;
    brolaride_updatesquaddata( 1 );
}

// Params 0
// Size: 0x4b
function brolaride_onpickupdefusekit()
{
    if ( istrue( self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ) )
    {
        return;
    }
    
    if ( !isdefined( self.“·Q¢¤á›B‘ĞMjÏÏóçÊU0÷ ) )
    {
        self.“·Q¢¤á›B‘ĞMjÏÏóçÊU0÷ = 1;
        scripts\mp\gametypes\br_public::brleaderdialog( "defuse_kit_pickup_dialog", 1, [ self ], 1, 0, undefined, "bchr" );
        thread brolaride_monitorplayedcarryitemvo( 0 );
    }
    
    self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë = 1;
    brolaride_updatesquaddata( 2 );
}

// Params 1
// Size: 0x30
function brolaride_monitorplayedcarryitemvo( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    wait level.disable_super_in_turret.ŒZ±Âä9^-YÖ;{“²Í²ÑZµ¬;
    
    if ( var0 )
    {
        self.¡õc…—•FlX99åö¶&ö = undefined;
        return;
    }
    
    self.“·Q¢¤á›B‘ĞMjÏÏóçÊU0÷ = undefined;
}

// Params 1
// Size: 0x68
function brolaride_onusecompleted( var0 )
{
    if ( !isdefined( var0.tracknonoobplayerlocation ) )
    {
        return 0;
    }
    
    if ( var0.scriptablename == "br_defusekit" )
    {
        if ( istrue( self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ) )
        {
            return undefined;
        }
        
        return brolaride_switchtodefusekit( var0.origin );
    }
    else if ( var0.scriptablename == "br_bomb" )
    {
        if ( istrue( self.½
»g›¸j’ ) )
        {
            return undefined;
        }
        
        return brolaride_switchtobomb( var0.origin );
    }
    
    return undefined;
}

// Params 1
// Size: 0x14, Type: bool
function brolaride_switchtobomb( var0 )
{
    brolaride_spawncurrentitemfromplayer( var0 );
    self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë = undefined;
    return true;
}

// Params 1
// Size: 0x14, Type: bool
function brolaride_switchtodefusekit( var0 )
{
    brolaride_spawncurrentitemfromplayer( var0 );
    self.½
»g›¸j’ = undefined;
    return true;
}

// Params 1
// Size: 0x27
function brolaride_spawncurrentitemfromplayer( var0 )
{
    if ( istrue( self.½
»g›¸j’ ) )
    {
        brolaride_spawnbombfromplayer( var0 );
        return;
    }
    
    if ( istrue( self.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ) )
    {
        brolaride_spawndefusekitfromplayer( var0 );
        return;
    }
}

// Params 1
// Size: 0x25
function brolaride_spawnbombfromplayer( var0 )
{
    if ( isdefined( var0 ) )
    {
        bomb_spawnbomb( var0 );
        return;
    }
    
    scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( self, "br_bomb", 1, undefined, 1, 1 );
}

// Params 1
// Size: 0x25
function brolaride_spawndefusekitfromplayer( var0 )
{
    if ( isdefined( var0 ) )
    {
        defusekit_spawndefusekit( var0 );
        return;
    }
    
    scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( self, "br_defusekit", 1, undefined, 1, 1 );
}

// Params 1
// Size: 0xc2
function brolaride_updatesquaddata( var0 )
{
    var1 = scripts\mp\gametypes\br_public::round_at_max( self.team, self.squadindex, "ui_br_olaride_points" );
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var2 = scripts\engine\utility::ter_op( isdefined( self.pers[ "squadMemberIndex" ] ), self.pers[ "squadMemberIndex" ] - 1, 0 );
    var3 = var2 * 2;
    var4 = _calloutmarkerping_handleluinotify_added::repackomnvar( var3, 2, var1, var0 );
    scripts\mp\gametypes\br_public::ref_131c3( self.team, self.squadindex, "ui_br_olaride_points", var4 );
    
    if ( var4 != var1 )
    {
        var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
        var3 = 22;
        
        foreach ( var7 in var5 )
        {
            if ( !isdefined( var7 ) )
            {
                continue;
            }
            
            var7 _calloutmarkerping_handleluinotify_added::ref_1313e( "ui_br_olaride_points", var3, 8, var4 );
        }
        
        return;
    }
}

// Params 1
// Size: 0xae
function brolaride_onplayerkilled( var0 )
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
    var1 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var3 = isdefined( var2 ) && ( var2.classname == "trigger_hurt" || var2.classname == "worldspawn" );
    var4 = undefined;
    
    if ( istrue( var1.½
»g›¸j’ ) )
    {
        var1.½
»g›¸j’ = undefined;
        var4 = &bomb_spawnbomb;
    }
    else if ( istrue( var1.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë ) )
    {
        var1.¢L¯Ÿ–b9ÏÙ;ÿ¤›ë = undefined;
        var4 = &defusekit_spawndefusekit;
    }
    
    if ( !var3 && isdefined( var4 ) )
    {
        [[ var4 ]]( var1.origin );
    }
    
    brolaride_updatesquaddata( var1, 0 );
}

// Params 1
// Size: 0x54, Type: bool
function canactivate( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.£eEò©pÆ£ú«ñr÷‰ úqá3› )
    {
        if ( distance2d( var2.origin, var0.origin ) < level.disable_super_in_turret.„|(óg˜ãÊ?«®"3c—GèÀ+ÿĞ­cd½ )
        {
            return false;
        }
    }
    
    return true;
}

// Params 1
// Size: 0x43
function allowedwhileusingbombsite( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    scripts\common\utility::allow_jump( var0 );
    scripts\mp\utility\player::allow_gesture( var0 );
    scripts\common\utility::allow_melee( var0 );
    scripts\common\utility::allow_mantle( var0 );
    scripts\common\utility::allow_movement( var0 );
    scripts\common\utility::allow_offhand_weapons( var0 );
}

// Params 0
// Size: 0x34
function brolaride_initvisionsetprogression()
{
    level waittill( "prematch_fade_done" );
    level.…É¼áG O«ˆƒ£[w = 0;
    level.—#®y‡+Ê¶×ƒ’3éÿ(Ch> = [ "_s05_ltm_00", "_s05_ltm_00", "_s05_ltm_01", "_s05_ltm_02", "_s05_ltm_03" ];
}

// Params 2
// Size: 0x2c
function brolaride_setvisionsetstate( var0, var1 )
{
    if ( var0 < 0 || var0 >= level.—#®y‡+Ê¶×ƒ’3éÿ(Ch>.size )
    {
        return;
    }
    
    level.…É¼áG O«ˆƒ£[w = var0;
    
    if ( !isdefined( var1 ) )
    {
        var1 = 60;
    }
    
    thread overridevisionset( var1 );
}

// Params 1
// Size: 0x14
function overridevisionset( var0 )
{
    function_0444( var0, level.—#®y‡+Ê¶×ƒ’3éÿ(Ch>[ level.…É¼áG O«ˆƒ£[w ] );
}

// Params 1
// Size: 0xa3
function brolaride_updatevisionsets( var0 )
{
    var1 = level.…É¼áG O«ˆƒ£[w;
    
    if ( level.disable_super_in_turret.—IÒ+qÏ’ğŸ© )
    {
        var1 = level.—#®y‡+Ê¶×ƒ’3éÿ(Ch>.size - 1;
    }
    else
    {
        var2 = var0 / level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿;
        var1 = var2 * ( level.—#®y‡+Ê¶×ƒ’3éÿ(Ch>.size - 1 );
        var1 = int( floor( var1 ) );
    }
    
    if ( var1 > level.…É¼áG O«ˆƒ£[w )
    {
        brolaride_setvisionsetstate( var1 );
        
        if ( var1 == level.—#®y‡+Ê¶×ƒ’3éÿ(Ch>.size - 1 )
        {
            foreach ( var4 in level.players )
            {
                if ( isdefined( var4 ) )
                {
                    thread setplayerashvfxactive( var4 );
                }
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x14d
function brolaride_initmeter()
{
    level endon( "game_ended" );
    
    if ( getdvarint( "scr_br_olaride_meter_enabled", 1 ) == 0 )
    {
        return;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    level.™lÈú¾ª°©¨ãĞñc = spawnstruct();
    level.™lÈú¾ª°©¨ãĞñc.progress = 0;
    level.™lÈú¾ª°©¨ãĞñc.–ñ¯ıSñk=ë¸€’ = 0;
    level.™lÈú¾ª°©¨ãĞñc.get_closest_enemy_near_turret = getdvarint( "scr_br_olaride_meter_capacity", 10000 );
    var0 = spawnstruct();
    var0.A†Êœ{´ÂØ·Î = "volcano_meter_1";
    var1 = spawnstruct();
    var1.A†Êœ{´ÂØ·Î = "volcano_meter_2";
    var2 = spawnstruct();
    var2.A†Êœ{´ÂØ·Î = "volcano_meter_3_hero";
    var2.¥{RaLJ¡Æ&õÇ = "volcano_meter_3_villain";
    var2.¦ßÇJ¯_ûäñcƒ = "volcano_meter";
    var3 = brolaride_createmeterstate( 100, 40, 6, 7, undefined );
    var4 = brolaride_createmeterstate( 80, 40, 5, 7, var2 );
    var5 = brolaride_createmeterstate( 60, 40, 4, 6, var1 );
    var6 = brolaride_createmeterstate( 40, 60, 3, 5, undefined );
    var7 = brolaride_createmeterstate( 20, 60, 2, 4, var0 );
    var8 = brolaride_createmeterstate( 0, 60, 1, 3, undefined );
    level.™lÈú¾ª°©¨ãĞñc.states = [ var3, var4, var5, var6, var7, var8 ];
    level.™lÈú¾ª°©¨ãĞñc.™qCR°•Êãß©Ïí Ÿ9ª = level.™lÈú¾ª°©¨ãĞñc.states.size - 1;
    thread brolaride_increasemeter();
    thread brolaride_trackmeterboost();
}

// Params 5
// Size: 0x3c
function brolaride_createmeterstate( var0, var1, var2, var3, var4 )
{
    var5 = spawnstruct();
    var5.–ñ¯ıSñk=ë¸€’ = var0;
    var5.delay = var1;
    var5.ºjsHÁt§i¨ur¶'}1 = var2;
    var5.‡sx›õOËB.@•¶»/#¸] = var3;
    var5.sfx = var4;
    return var5;
}

// Params 0
// Size: 0x3c
function brolaride_increasemeter()
{
    level endon( "game_ended" );
    var0 = getdvarint( "scr_br_olaride_meter_unit_per_second", 3 );
    
    while ( level.™lÈú¾ª°©¨ãĞñc.progress < level.™lÈú¾ª°©¨ãĞñc.get_closest_enemy_near_turret )
    {
        wait 1;
        brolaride_setmeterprogress( var0 );
    }
}

// Params 0
// Size: 0x41
function brolaride_trackmeterboost()
{
    level endon( "game_ended" );
    var0 = getdvarint( "scr_br_olaride_meter_boost", 218 );
    
    while ( level.™lÈú¾ª°©¨ãĞñc.progress < level.™lÈú¾ª°©¨ãĞñc.get_closest_enemy_near_turret )
    {
        level waittill( "olaride_meter_boost" );
        brolaride_setmeterprogress( var0 );
    }
}

// Params 1
// Size: 0x74
function brolaride_setmeterprogress( var0 )
{
    level.™lÈú¾ª°©¨ãĞñc.progress = int( clamp( level.™lÈú¾ª°©¨ãĞñc.progress + var0, 0, level.™lÈú¾ª°©¨ãĞñc.get_closest_enemy_near_turret ) );
    var1 = level.™lÈú¾ª°©¨ãĞñc.get_closest_enemy_near_turret / 100;
    level.™lÈú¾ª°©¨ãĞñc.–ñ¯ıSñk=ë¸€’ = int( level.™lÈú¾ª°©¨ãĞñc.progress / var1 );
    setomnvar( "ui_br_pe_meter_data", level.™lÈú¾ª°©¨ãĞñc.–ñ¯ıSñk=ë¸€’ );
    brolaride_setmetercurrentstate();
}

// Params 0
// Size: 0xda
function brolaride_setmetercurrentstate()
{
    for ( var0 = 0; var0 < level.™lÈú¾ª°©¨ãĞñc.states.size ; var0++ )
    {
        var1 = level.™lÈú¾ª°©¨ãĞñc.states[ var0 ];
        var2 = var0 == level.™lÈú¾ª°©¨ãĞñc.™qCR°•Êãß©Ïí Ÿ9ª;
        var3 = level.™lÈú¾ª°©¨ãĞñc.–ñ¯ıSñk=ë¸€’ >= level.™lÈú¾ª°©¨ãĞñc.states[ level.™lÈú¾ª°©¨ãĞñc.™qCR°•Êãß©Ïí Ÿ9ª ].–ñ¯ıSñk=ë¸€’;
        
        if ( var2 && var3 )
        {
            break;
        }
        
        if ( var1.–ñ¯ıSñk=ë¸€’ > level.™lÈú¾ª°©¨ãĞñc.–ñ¯ıSñk=ë¸€’ )
        {
            continue;
        }
        
        level.™lÈú¾ª°©¨ãĞñc.™qCR°•Êãß©Ïí Ÿ9ª = var0;
        
        foreach ( var5 in level.players )
        {
            if ( isdefined( var5 ) )
            {
                brolaride_playvolcanometersfx( var5, var1 );
            }
        }
        
        break;
    }
}

// Params 1
// Size: 0xa3
function brolaride_playvolcanometersfx( var0 )
{
    if ( !isdefined( var0.sfx ) )
    {
        return;
    }
    
    if ( isdefined( var0.sfx.¦ßÇJ¯_ûäñcƒ ) )
    {
        self playsoundtoplayer( var0.sfx.¦ßÇJ¯_ûäñcƒ, self );
    }
    
    if ( isdefined( var0.sfx.A†Êœ{´ÂØ·Î ) )
    {
        var1 = !isdefined( var0.sfx.¥{RaLJ¡Æ&õÇ ) || brolaride_isplayerteamhero();
        var2 = scripts\engine\utility::ter_op( var1, var0.sfx.A†Êœ{´ÂØ·Î, var0.sfx.¥{RaLJ¡Æ&õÇ );
        var3 = 1;
        var4 = scripts\engine\utility::ter_op( var1, "bchr", "mndz" );
        brolaride_brleaderdialog( var2, var3, var4 );
        return;
    }
}

// Params 3
// Size: 0x15
function brolaride_brleaderdialog( var0, var1, var2 )
{
    thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var0, self, 1, 1, var1, undefined, var2 );
}

// Params 0
// Size: 0x5c, Type: bool
function brolaride_isplayerteamhero()
{
    var0 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ self.team ] ), level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ self.team ], 0 );
    var1 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ self.team ] ), level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ self.team ], 0 );
    return var0 >= var1;
}

// Params 0
// Size: 0x45
function brolaride_getinfosforexplosion()
{
    foreach ( var1 in level.™lÈú¾ª°©¨ãĞñc.states )
    {
        if ( level.™lÈú¾ª°©¨ãĞñc.–ñ¯ıSñk=ë¸€’ >= var1.–ñ¯ıSñk=ë¸€’ )
        {
            return var1;
        }
    }
}

// Params 0
// Size: 0x83
function brolaride_volcanicactivity()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    var0 = 0;
    level.•4ìŞXs-l±è´;-èò7Â9Ñ¬È = 0;
    
    for ( ;; )
    {
        var1 = brolaride_getinfosforexplosion();
        
        if ( var1.delay > 0 )
        {
            if ( level.•4ìŞXs-l±è´;-èò7Â9Ñ¬È == 0 )
            {
                scripts\mp\gametypes\br_publicevent_fafir::volcanoexplode( 0, 7 );
                level.•4ìŞXs-l±è´;-èò7Â9Ñ¬È = 1;
            }
            else if ( var0 >= var1.delay )
            {
                scripts\mp\gametypes\br_publicevent_fafir::volcanoexplode( var1.ºjsHÁt§i¨ur¶'}1, var1.‡sx›õOËB.@•¶»/#¸] );
                var0 = 0;
            }
            else
            {
                var0 += 1;
            }
        }
        
        wait 1;
    }
}

// Params 1
// Size: 0x1f
function branalytics_doomstationstate( var0 )
{
    var1 = [];
    GscBinSkip0( 0x2e, var1.size, "state" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x50c
function initdoomstation()
{
    if ( !isdefined( level.P	xuÓ`Ëy³I ) )
    {
        level.P	xuÓ`Ëy³I = spawnstruct();
    }
    
    level.‹w¹íWP†Ï¹‹ßŠÃğöE = spawnstruct();
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.± Ê/ÛkN+PÿŸà 6r•FÖÀ = [ ( 15151.3, 9648.25, 7284.75 ), ( 30728.4, 15641.3, 2475.4 ), ( 13458.5, 5504.68, 6313.83 ), ( 3233.25, 10919.5, 5737.25 ), ( 2385.75, 3470.75, 3352.75 ), ( 17519, 15425, 6295.75 ), ( 20405, 24465.3, 4507.5 ) ];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.–‹³]À¿Œ#øbÃ§
 = [ ( 0, 311.017, 0 ), ( 0, 90, 0 ), ( 0, 185.806, 0 ), ( 0, 49.8552, 0 ), ( 0, 176.498, 0 ), ( 0, 22.0244, 0 ), ( 0, 323.693, 0 ) ];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.Šß€ ©G/ «0ïó2İk· = [ ( 26360, 2550, 20500 ), ( 26360, 2550, 20500 ), ( 3341, 4673, 20500 ), ( 3341, 4673, 20500 ), ( -4149, 4135, 20500 ), ( 28634, 20711.6, 20500 ), ( 28634, 20711.6, 20500 ) ];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.price = getdvarint( "scr_br_doomstation_price", 10000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.timer = getdvarint( "scr_br_doomstation_timer", 60 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.›'ƒr<`àß³@ûéZS = getdvarint( "scr_br_doomstation_deactivate_timer", 30 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.–n{(P§ãv
BW9j}{ = getdvarint( "scr_br_doomstation_progress_radius", 1000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¾À°¿ãqG = getdvarint( "scr_br_doomstation_show_radius", 3000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.•@Ü…“GÊ#Ü†Ûî9ÂÈKºÍ = getdvarint( "scr_br_doomstation_started_show_radius", 7000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.triggerheight = getdvarint( "scr_br_doomstation_trigger_height", 3000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¡æcXÜ¡N…Œ´«¹ = getdvarint( "scr_br_doomstation_splash_dist", 7000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.@¡zŠhd±k© = getdvarint( "scr_br_doomstation_fade_distance", 500 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.progress = 0;
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆs,ƒ@–ƒã“r+ÙGCM˜U¥£ = 0;
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.Œà“Ş³ÉÊ¹Í2²Ø^ = getdvarint( "scr_br_doomstation_progress_delay", 3 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¥C–È+ÁÉ{ì'+ÍÜÑ´Ú+N = getdvarint( "scr_br_doomstation_hide_progress_timer", 5 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¢÷é‡‚U‰N" = getdvarfloat( "scr_br_doomstation_shake_delay", 6.5 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.Šâ›H³Ohµh-Ÿ°ã[ = getdvarfloat( "scr_br_doomstation_shake_intensity", 0.2 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.„/óSˆÀ…-º¼à‡" = getdvarfloat( "scr_br_doomstation_shake_duration", 5 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.±™Hs± ãæ…û« = getdvarint( "scr_br_doomstation_shake_radius", 20000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.–'¯Ğº„˜3Q¥¾—Ë‚=ƒ = getdvarfloat( "scr_br_doomstation_shake_wave1_start", 13.27 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.‹¬s›¾ò³úm{—øzS = getdvarfloat( "scr_br_doomstation_shake_wave2_start", 9.27 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.ŠSIÏ·X+Õß£Mƒ} = getdvarfloat( "scr_br_doomstation_shake_wave_delay", 10 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.§U²0×¢EÓ*Cªáäö› = getdvarfloat( "scr_br_doomstation_shake_wave_delay", 1 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¥Ğ;L9[íï³'j­ˆŞbàS° = getdvarfloat( "scr_br_doomstation_shake_wave_intensity", 0.1 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.ƒ·ë˜G#w¶İSÖi8’² = getdvarfloat( "scr_br_doomstation_shake_wave_duration", 1 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.“ãâƒò-£Xƒ÷øYäs = getdvarint( "scr_br_doomstation_shake_wave_radius", 3000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.´K*“à«Uá"º©3 = getdvarint( "scr_br_doomstation_reward_delay", 4 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.started = 0;
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.ref_13606 = ( 0, 0, 0 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.spawnpos = ( 0, 0, 15000 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.endpoint = ( 0, 0, 850 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆ½ùYJePã²¡±?¦ = 8;
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.new_rider_combat_logic = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.§ÚGZÌ(­ş€˜ á²]‰ = getdvarint( "scr_br_doomstation_AI_max_health", 200 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¬w—&»È¶ = getdvarint( "scr_br_doomstation_AI_armor_value", 300 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.§šoŠ[£OØ gÚ±W = getdvarfloat( "scr_br_doomstation_AI_accuracy_value", 0.7 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¸Ğ-E<Ö"‹#	­2¢ = getdvarfloat( "scr_br_doomstation_AI_ammo_drop_chance", 0.9 );
    level._effect[ "vfx_br3_doom_shockwave" ] = loadfx( "vfx/iw8_br/island/gameplay/doom/vfx_br3_doom_shockwave.vfx" );
    game[ "dialog" ][ "doomstation_ownTeam" ] = "trials_doomstation_begin_friendly";
    game[ "dialog" ][ "doomstation_enemyTeam" ] = "trials_doomstation_begin_enemy";
    game[ "dialog" ][ "doomstation_failure" ] = "trials_doomstation_failure";
    game[ "dialog" ][ "doomstation_proximity" ] = "trials_doomstation_proximity";
    game[ "dialog" ][ "doomstation_success" ] = "trials_doomstation_success";
    spawndoomstation();
    thread activatedoomstation();
}

// Params 0
// Size: 0x2f
function spawndoomstation()
{
    var0 = createdoomstation();
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.endpoint = var0.origin + ( 0, 0, 850 );
    level.$ÛŞkæ:GK½¹ = var0;
}

// Params 0
// Size: 0x11d
function createdoomstation()
{
    if ( level.mapname == "mp_br_mechanics" )
    {
        return easepower( "br_doomstation", ( 2500, -2600, 0 ) );
    }
    
    if ( level.mapname == "mp_wz_island" )
    {
        var0 = 1;
        var1 = getdvarint( "scr_br_doomstation_spawn_pos_force", -1 );
        var2 = strtok( getdvar( "scr_br_doomstation_spawn_pos_list", "" ), "," );
        
        if ( var1 != -1 )
        {
            var3 = var1;
            var0 = 0;
        }
        else if ( var3.size > 0 )
        {
            var3 = int( var3[ randomint( var3.size ) ] );
        }
        else
        {
            var3 = randomint( level.‹w¹íWP†Ï¹‹ßŠÃğöE.± Ê/ÛkN+PÿŸà 6r•FÖÀ.size );
        }
        
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.spawnpos = level.‹w¹íWP†Ï¹‹ßŠÃğöE.Šß€ ©G/ «0ïó2İk·[ var3 ];
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.¥Ùö˜ÜõZ# = createnavobstaclebybounds( level.‹w¹íWP†Ï¹‹ßŠÃğöE.± Ê/ÛkN+PÿŸà 6r•FÖÀ[ var3 ], ( 20, 80, 32 ), level.‹w¹íWP†Ï¹‹ßŠÃğöE.–‹³]À¿Œ#øbÃ§
[ var3 ] );
        return easepower( "br_doomstation", level.‹w¹íWP†Ï¹‹ßŠÃğöE.± Ê/ÛkN+PÿŸà 6r•FÖÀ[ var3 ], level.‹w¹íWP†Ï¹‹ßŠÃğöE.–‹³]À¿Œ#øbÃ§
[ var3 ] );
    }
    
    var4 = getentitylessscriptablearrayinradius( "scriptable_br_doomstation", "classname" );
    return undefined;
}

// Params 0
// Size: 0xb7
function doomstation_reset()
{
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.progress = 0;
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆs,ƒ@–ƒã“r+ÙGCM˜U¥£ = 0;
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.new_rider_combat_logic = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli = [];
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.started = 0;
    level.$ÛŞkæ:GK½¹.useprompt.´

9°à«0[»£ delete();
    level.$ÛŞkæ:GK½¹.useprompt delete();
    
    if ( isdefined( level.$ÛŞkæ:GK½¹.objid ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( level.$ÛŞkæ:GK½¹.objid );
        scripts\mp\objidpoolmanager::returnobjectiveid( level.$ÛŞkæ:GK½¹.objid );
    }
    
    activatedoomstation();
}

// Params 0
// Size: 0x25c
function activatedoomstation()
{
    level endon( "game_ended" );
    waitframe();
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    var0 = level.$ÛŞkæ:GK½¹;
    var1 = var0.origin + ( 0, 0, 50 );
    var0 setscriptablepartstate( "br_doomstation", "active" );
    var0.useprompt = scripts\mp\gameobjects::createhintobject( var1, "HINT_BUTTON", undefined, &"MP_BR_INGAME_TU_WZ350/PURCHASE_BR_DOOMSTATION_ENABLED", undefined, undefined, undefined, 0, 0, 100, -1 );
    var0.useprompt.´

9°à«0[»£ = scripts\mp\gameobjects::createhintobject( var1, "HINT_BUTTON", undefined, &"MP_BR_INGAME_TU_WZ350/PURCHASE_BR_DOOMSTATION_DISABLED", undefined, undefined, undefined, 0, 0, 100, -1 );
    var0.useprompt sethintstringparams( level.‹w¹íWP†Ï¹‹ßŠÃğöE.price );
    var0.useprompt.´

9°à«0[»£ sethintstringparams( level.‹w¹íWP†Ï¹‹ßŠÃğöE.price );
    thread doomstation_managepromptinteraction( var0 );
    thread doomstation_manageredpromptinteraction( var0 );
    var0.‹ümÀW%ÓR‹˜oM = var0.origin - ( 0, 0, level.‹w¹íWP†Ï¹‹ßŠÃğöE.triggerheight / 2 );
    var0.trigger = spawn( "trigger_radius", var0.‹ümÀW%ÓR‹˜oM, 0, int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.¾À°¿ãqG ), int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.triggerheight ) );
    scripts\mp\utility\trigger::makeenterexittrigger( var0.trigger, &doomstation_triggerenter );
    var0.objid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    scripts\mp\objidpoolmanager::objective_add_objective( var0.objid, "current" );
    objective_setbackground( var0.objid, 1 );
    objective_icon( var0.objid, "ui_mp_br_doom_activate" );
    objective_setminimapiconsize( var0.objid, "icon_regular" );
    function_0421( var0.objid, 1 );
    getbnetigrbattlepassxpmultiplier( var0.objid, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¾À°¿ãqG, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¾À°¿ãqG + level.‹w¹íWP†Ï¹‹ßŠÃğöE.@¡zŠhd±k© );
    objective_removeallfrommask( var0.objid );
    objective_position( var0.objid, var0.origin + ( 0, 0, 70 ) );
    objective_setlabel( var0.objid, &"MP_BR_INGAME_TU_WZ350/BR_DOOMSTATION_UNKNOWN_OBJECTIVE_LABEL" );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.¾
bMïzXË·@[ = [ [ "brloot_killstreak_auav", 1 ], [ "brloot_killstreak_circle_peek", 1 ], [ "brloot_specialist_bonus", scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect() ] ];
    scripts\mp\gametypes\br_plunder::registerpostplundercallback( &doomstationpostplunder );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "game", "shouldPingDisableObjectiveIntro", &brdoomstationmode_shouldpingdisableobjectiveintro );
    doomstation_playersupdatestructure();
}

// Params 1
// Size: 0x65
function doomstation_playerupdateaffordablestate( var0 )
{
    var1 = int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.price / 100 );
    
    if ( isdefined( self.plundercount ) && self.plundercount >= var1 )
    {
        var0 enableplayeruse( self );
        var0.´

9°à«0[»£ disableplayeruse( self );
        return;
    }
    
    if ( !isdefined( self.plundercount ) || self.plundercount < var1 )
    {
        var0 disableplayeruse( self );
        var0.´

9°à«0[»£ enableplayeruse( self );
        return;
    }
}

// Params 0
// Size: 0x39
function doomstation_playersupdatestructure()
{
    foreach ( var1 in level.players )
    {
        thread doomstation_playerupdateaffordablestate( var1 );
    }
}

// Params 1
// Size: 0x296
function doomstation_managepromptinteraction( var0 )
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        
        if ( doomstation_canstartusing( var1 ) )
        {
            var2 = int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.price / 100 );
            var1 scripts\mp\gametypes\br_plunder::playersetplundercount( var1.plundercount - var2 );
            level.‹w¹íWP†Ï¹‹ßŠÃğöE.§<_y?«ü¨3k7I0 = var1.team;
            level.‹w¹íWP†Ï¹‹ßŠÃğöE.started = 1;
            level.$ÛŞkæ:GK½¹ setscriptablepartstate( "br_doomstation", "earthquake" );
            doomstation_disablepromptuse( var0 );
            getbnetigrbattlepassxpmultiplier( level.$ÛŞkæ:GK½¹.objid, level.‹w¹íWP†Ï¹‹ßŠÃğöE.•@Ü…“GÊ#Ü†Ûî9ÂÈKºÍ, level.‹w¹íWP†Ï¹‹ßŠÃğöE.•@Ü…“GÊ#Ü†Ûî9ÂÈKºÍ + level.‹w¹íWP†Ï¹‹ßŠÃğöE.@¡zŠhd±k© );
            objective_setlabel( level.$ÛŞkæ:GK½¹.objid, &"MP_BR_INGAME_TU_WZ350/BR_DOOMSTATION_OBJECTIVE_LABEL" );
            level.$ÛŞkæ:GK½¹.trigger delete();
            level.$ÛŞkæ:GK½¹.trigger = spawn( "trigger_radius", level.$ÛŞkæ:GK½¹.‹ümÀW%ÓR‹˜oM, 0, int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.•@Ü…“GÊ#Ü†Ûî9ÂÈKºÍ ), int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.triggerheight ) );
            scripts\mp\utility\trigger::makeenterexittrigger( level.$ÛŞkæ:GK½¹.trigger, &doomstation_triggerenter );
            level.$ÛŞkæ:GK½¹.¶ÃRv"*ñø§£è¨÷êc = spawn( "trigger_radius", level.$ÛŞkæ:GK½¹.‹ümÀW%ÓR‹˜oM, 0, int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.–n{(P§ãv
BW9j}{ ), int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.triggerheight ) );
            scripts\mp\utility\trigger::makeenterexittrigger( level.$ÛŞkæ:GK½¹.¶ÃRv"*ñø§£è¨÷êc, &doomstation_progresstriggerenter, &doomstation_progresstriggerexit );
            thread startshake( level.‹w¹íWP†Ï¹‹ßŠÃğöE.Šâ›H³Ohµh-Ÿ°ã[, level.‹w¹íWP†Ï¹‹ßŠÃğöE.„/óSˆÀ…-º¼à‡", level.‹w¹íWP†Ï¹‹ßŠÃğöE.¢÷é‡‚U‰N", level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.±™Hs± ãæ…û« );
            thread startshakewave( level.‹w¹íWP†Ï¹‹ßŠÃğöE.–'¯Ğº„˜3Q¥¾—Ë‚=ƒ, level.‹w¹íWP†Ï¹‹ßŠÃğöE.ŠSIÏ·X+Õß£Mƒ}, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¥Ğ;L9[íï³'j­ˆŞbàS°, level.‹w¹íWP†Ï¹‹ßŠÃğöE.ƒ·ë˜G#w¶İSÖi8’², level.‹w¹íWP†Ï¹‹ßŠÃğöE.§U²0×¢EÓ*Cªáäö›, level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.“ãâƒò-£Xƒ÷øYäs );
            thread startshakewave( level.‹w¹íWP†Ï¹‹ßŠÃğöE.‹¬s›¾ò³úm{—øzS, level.‹w¹íWP†Ï¹‹ßŠÃğöE.ŠSIÏ·X+Õß£Mƒ}, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¥Ğ;L9[íï³'j­ˆŞbàS°, level.‹w¹íWP†Ï¹‹ßŠÃğöE.ƒ·ë˜G#w¶İSÖi8’², level.‹w¹íWP†Ï¹‹ßŠÃğöE.§U²0×¢EÓ*Cªáäö›, level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.“ãâƒò-£Xƒ÷øYäs );
            doomstation_displayactivationbanners( var1 );
            thread doomstation_watchprogress();
            scripts\mp\gametypes\br_quest_util::ref_140b1( level.$ÛŞkæ:GK½¹.origin, "doomstation" );
            thread doomstation_chopperstart( level );
            branalytics_doomstationstate( "activated" );
        }
    }
}

// Params 1
// Size: 0xed
function doomstation_displayactivationbanners( var0 )
{
    var1 = scripts\mp\utility\teams::getteamdata( var0.team, "players" );
    
    foreach ( var0 in var1 )
    {
        if ( isdefined( var0 ) )
        {
            var0 thread scripts\mp\utility\points::giveunifiedpoints( "br_doomstation_activation" );
            var0 scripts\mp\hud_message::showsplash( "br_doomstation_friendly_activation" );
            scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "doomstation_ownTeam", var0, 1 );
        }
    }
    
    var4 = level.players;
    
    if ( isdefined( var1 ) )
    {
        var4 = scripts\engine\utility::array_remove_array( var4, var1 );
    }
    
    var5 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.¡æcXÜ¡N…Œ´«¹;
    
    foreach ( var7 in var4 )
    {
        if ( isdefined( var7 ) )
        {
            var8 = distance2d( var7.origin, self.origin );
            
            if ( var8 <= var5 )
            {
                scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.$ÛŞkæ:GK½¹.objid, var7 );
                var7 scripts\mp\hud_message::showsplash( "br_doomstation_enemy_activation" );
                scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "doomstation_enemyTeam", var7, 1 );
            }
        }
    }
}

// Params 1
// Size: 0x25
function doomstation_manageredpromptinteraction( var0 )
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        var0 playsoundtoplayer( "ui_screen_edge_deny", var1 );
    }
}

// Params 1
// Size: 0x40
function doomstation_disablepromptuse( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) )
        {
            var0 disableplayeruse( var2 );
            var0.´

9°à«0[»£ disableplayeruse( var2 );
        }
    }
}

// Params 2
// Size: 0x87, Type: bool
function doomstation_canstartusing( var0, var1 )
{
    if ( istrue( level.gameended ) )
    {
        return false;
    }
    
    if ( !var0 scripts\cp_mp\utility\player_utility::_isalive() || istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    if ( var0 scripts\cp_mp\utility\player_utility::isusingremote() )
    {
        return false;
    }
    
    if ( var0 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( istrue( var0.iscarrying ) && !isdefined( var0.get_search_turret_target_player ) )
    {
        var0 scripts\mp\hud_message::showerrormessage( "MP/FIELD_UPGRADE_CANNOT_USE" );
        return false;
    }
    
    var2 = int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.price / 100 );
    
    if ( var0.plundercount < var2 )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x45
function doomstation_triggerenter( var0, var1 )
{
    if ( isplayer( var0 ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.$ÛŞkæ:GK½¹.objid, var0 );
        var2 = level.$ÛŞkæ:GK½¹ getscriptablepartstate( "br_doomstation" );
        
        if ( var2 != "active" )
        {
            return;
        }
        
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "doomstation_proximity", var0 );
        return;
    }
}

// Params 2
// Size: 0x49
function doomstation_progresstriggerenter( var0, var1 )
{
    var0 notify( "progress_trigger_entered" );
    
    if ( isplayer( var0 ) )
    {
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó[ level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó.size ] = var0;
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş[ level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş.size ] = var0;
        return;
    }
}

// Params 2
// Size: 0x75
function doomstation_progresstriggerexit( var0, var1 )
{
    if ( isplayer( var0 ) )
    {
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó = scripts\engine\utility::array_remove( level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó, var0 );
        var2 = var0 scripts\engine\utility::ref_143b9( level.‹w¹íWP†Ï¹‹ßŠÃğöE.¥C–È+ÁÉ{ì'+ÍÜÑ´Ú+N, "progress_trigger_entered" );
        
        if ( var2 == "timeout" )
        {
            level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş = scripts\engine\utility::array_remove( level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş, var0 );
            var0 setclientomnvar( "ui_securing", 0 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x5e, Type: bool
function doomstation_isprogressing()
{
    foreach ( var1 in level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó )
    {
        if ( !isdefined( var1 ) )
        {
            level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó = scripts\engine\utility::array_remove( level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó, var1 );
        }
    }
    
    return level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó.size > 0;
}

// Params 0
// Size: 0x2ba
function doomstation_watchprogress()
{
    level endon( "game_ended" );
    wait level.‹w¹íWP†Ï¹‹ßŠÃğöE.Œà“Ş³ÉÊ¹Í2²Ø^;
    
    for ( var0 = 1; var0 ; var0 = 0 )
    {
        waitframe();
        
        if ( doomstation_isprogressing() )
        {
            level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆs,ƒ@–ƒã“r+ÙGCM˜U¥£ = 0;
            level.‹w¹íWP†Ï¹‹ßŠÃğöE.progress += level.framedurationseconds;
            var1 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.progress / level.‹w¹íWP†Ï¹‹ßŠÃğöE.timer;
            var1 = scripts\engine\utility::ter_op( var1 < 1, var1, 1 );
            objective_setprogress( level.$ÛŞkæ:GK½¹.objid, var1 );
            
            foreach ( var3 in level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş )
            {
                if ( isdefined( var3 ) && isplayer( var3 ) && isalive( var3 ) && !istrue( var3.usedprops ) && !istrue( var3.beingrevived ) && !istrue( var3.isreviving ) )
                {
                    if ( scripts\engine\utility::array_contains( level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó, var3 ) )
                    {
                        var3 setclientomnvar( "ui_securing", 25 );
                    }
                    else
                    {
                        var3 setclientomnvar( "ui_securing", 26 );
                    }
                    
                    var3 setclientomnvar( "ui_securing_progress", var1 );
                }
            }
        }
        else
        {
            level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆs,ƒ@–ƒã“r+ÙGCM˜U¥£ += level.framedurationseconds;
            
            foreach ( var3 in level.‹w¹íWP†Ï¹‹ßŠÃğöE.­œh[‰Ê+û
tw£‚y°ş )
            {
                if ( isdefined( var3 ) && isplayer( var3 ) && isalive( var3 ) && !istrue( var3.usedprops ) && !istrue( var3.beingrevived ) && !istrue( var3.isreviving ) )
                {
                    var3 setclientomnvar( "ui_securing", 27 );
                }
            }
        }
        
        if ( level.‹w¹íWP†Ï¹‹ßŠÃğöE.progress >= level.‹w¹íWP†Ï¹‹ßŠÃğöE.timer )
        {
            doomstation_openstation();
            var0 = 0;
        }
        
        if ( level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆs,ƒ@–ƒã“r+ÙGCM˜U¥£ >= level.‹w¹íWP†Ï¹‹ßŠÃğöE.›'ƒr<`àß³@ûéZS )
        {
            doomstation_failprogress();
        }
    }
    
    level notify( "stop_shake_waves" );
    level.$ÛŞkæ:GK½¹.trigger delete();
    level.$ÛŞkæ:GK½¹.¶ÃRv"*ñø§£è¨÷êc delete();
    wait 1;
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( level.$ÛŞkæ:GK½¹.objid );
    
    foreach ( var3 in level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó )
    {
        if ( isdefined( var3 ) && !istrue( var3.usedprops ) && !istrue( var3.beingrevived ) && !istrue( var3.isreviving ) )
        {
            var3 setclientomnvar( "ui_securing", 0 );
            var3 setclientomnvar( "ui_securing_progress", 0 );
        }
    }
    
    scripts\mp\objidpoolmanager::returnobjectiveid( level.$ÛŞkæ:GK½¹.objid );
    level.$ÛŞkæ:GK½¹.objid = undefined;
}

// Params 0
// Size: 0xae
function doomstation_openstation()
{
    doomstation_playvoinradius( "doomstation_success", level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¡æcXÜ¡N…Œ´«¹ );
    scripts\mp\gametypes\br_quest_util::look_at_heli( "br_doomstation_secured", level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¡æcXÜ¡N…Œ´«¹ );
    thread startshake( level.‹w¹íWP†Ï¹‹ßŠÃğöE.Šâ›H³Ohµh-Ÿ°ã[, level.‹w¹íWP†Ï¹‹ßŠÃğöE.„/óSˆÀ…-º¼à‡", level.‹w¹íWP†Ï¹‹ßŠÃğöE.¢÷é‡‚U‰N", level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.±™Hs± ãæ…û« );
    level.$ÛŞkæ:GK½¹ setscriptablepartstate( "br_doomstation", "opening" );
    thread doomstation_chopperflee( level );
    thread doomstation_givereward();
    branalytics_doomstationstate( "complete" );
}

// Params 0
// Size: 0x1b3
function doomstation_givereward()
{
    level endon( "game_ended" );
    wait level.‹w¹íWP†Ï¹‹ßŠÃğöE.´K*“à«Uá"º©3;
    var0 = scripts\mp\utility\player::getplayersinradius( level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.–n{(P§ãv
BW9j}{ );
    
    foreach ( var2 in var0 )
    {
        if ( isdefined( var2 ) )
        {
            var2 thread scripts\mp\utility\points::giveunifiedpoints( "br_doomstation_success" );
            
            if ( var2.team == level.‹w¹íWP†Ï¹‹ßŠÃğöE.§<_y?«ü¨3k7I0 )
            {
                var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "doom_watch" );
                level.$ÛŞkæ:GK½¹.useprompt playsoundtoplayer( "doom_station_unique_reward", var2, var2 );
            }
        }
    }
    
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.itemsdropped = 0;
    var4 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.¾
bMïzXË·@[;
    var5 = spawnstruct();
    var5.origin = level.$ÛŞkæ:GK½¹.origin;
    var5.angles = level.$ÛŞkæ:GK½¹.angles;
    var5.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var5.dropstruct.ml_p3_to_safehouse_transition = 20;
    var5.dropstruct.silencer_pick_up_monitor = 40;
    var6 = level.$ÛŞkæ:GK½¹.angles + ( 0, 135, 0 );
    
    foreach ( var8 in var4 )
    {
        var9 = var8[ 0 ];
        var10 = var8[ 1 ];
        
        if ( scripts\mp\gametypes\br_lootcache::get_bonus_targets( var9 ) )
        {
            for ( var11 = 0; var11 < var10 ; var11++ )
            {
                var12 = scripts\mp\gametypes\br_lootcache::ref_11a41( var9, var5.dropstruct, var5.origin + ( 0, 0, var5.dropstruct.silencer_pick_up_monitor ), var6, 0, 0 );
                level.‹w¹íWP†Ï¹‹ßŠÃğöE.itemsdropped++;
                waitframe();
            }
        }
        
        wait 0.5;
    }
}

// Params 0
// Size: 0x60
function doomstation_failprogress()
{
    doomstation_playvoinradius( "doomstation_failure", level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¡æcXÜ¡N…Œ´«¹ );
    scripts\mp\gametypes\br_quest_util::look_at_heli( "br_doomstation_failure", level.$ÛŞkæ:GK½¹.origin, level.‹w¹íWP†Ï¹‹ßŠÃğöE.¡æcXÜ¡N…Œ´«¹ );
    level.$ÛŞkæ:GK½¹ setscriptablepartstate( "br_doomstation", "deactivated" );
    thread doomstation_chopperflee( level );
}

// Params 3
// Size: 0x3b
function doomstation_playvoinradius( var0, var1, var2 )
{
    var3 = scripts\mp\utility\player::getplayersinradius( var1, var2 );
    
    foreach ( var5 in var3 )
    {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var0, var5, 1 );
    }
}

// Params 1
// Size: 0x24, Type: bool
function brdoomstationmode_shouldpingdisableobjectiveintro( var0 )
{
    if ( isdefined( level.$ÛŞkæ:GK½¹.objid ) )
    {
        return ( var0 != level.$ÛŞkæ:GK½¹.objid );
    }
    
    return true;
}

// Params 1
// Size: 0x1ec
function doomstation_chopperstart( var0 )
{
    level endon( "game_ended" );
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        return;
    }
    
    var1 = [ ( 0, 800, 450 ), ( 800, 0, 0 ), ( -800, 0, 0 ) ];
    
    for ( var2 = 0; var2 < 3 ; var2++ )
    {
        var3 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.spawnpos + var1[ var2 ];
        var4 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.endpoint + var1[ var2 ];
        var5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter( var0, var3, level.‹w¹íWP†Ï¹‹ßŠÃğöE.ref_13606, "veh_apache_doomsday_station_mp", "veh8_mil_air_mindia8_mercenary_extraction_s5" );
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli = scripts\engine\utility::array_add( level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli, var5 );
        var5 setmaxpitchroll( 10, 25 );
        var5 vehicle_setspeed( 90, 275 );
        var5 sethoverparams( 10, 100, 40 );
        var5 setturningability( 0.05 );
        var5 setyawspeed( 45, 25, 25, 0.5 );
        var5 setvehgoalpos( var4, 1 );
        var5 unmarkkeyframedmover( 1 );
    }
    
    var6 = 360 / level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆ½ùYJePã²¡±?¦;
    var7 = anglestoforward( level.‹w¹íWP†Ï¹‹ßŠÃğöE.ref_13606 );
    var8 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.ˆ½ùYJePã²¡±?¦ + level.‹w¹íWP†Ï¹‹ßŠÃğöE.§3 k7y¢'>ÅA##Ó.size;
    
    for ( var2 = 0; var2 < var8 ; var2++ )
    {
        wait 2;
        var9 = var6 * var2;
        var10 = var6 * ( var2 + 1 );
        var11 = randomfloatrange( var9, var10 );
        var12 = 350;
        var13 = 450;
        var14 = randomfloatrange( var12, var13 );
        var15 = vectornormalize( rotatevector( var7, ( 0, var11, 0 ) ) );
        var16 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.endpoint + var15 * var14;
        var16 = getclosestpointonnavmesh( var16 );
        var17 = doomstation_spawnagent( var16, ( 0, 0, 180 ), 1, "actor_enemy_lw_br" );
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.new_rider_combat_logic = scripts\engine\utility::array_add( level.‹w¹íWP†Ï¹‹ßŠÃğöE.new_rider_combat_logic, var17 );
    }
}

// Params 4
// Size: 0xce
function doomstation_spawnagent( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.„ù¸?¯ã+Ã†fû›û{NëKpĞã-{ = 1;
    var5 = _testing_ending::spawnnewparachuteagent( var0, var1, 1, var3 );
    
    if ( !isdefined( var5 ) )
    {
        return;
    }
    
    var5.move_closest_chopper_boss_vandalize_node_down = 1;
    var6 = spawn( "trigger_radius", level.$ÛŞkæ:GK½¹.origin + ( 0, 0, -30 ), 0, 500, 500 );
    var5 setgoalvolumeauto( var6 );
    var5 _testing_ending::ammobox_getbufferedattachmentsourceweapon();
    var5 _testing_ending::ref_13122( level.‹w¹íWP†Ï¹‹ßŠÃğöE.§šoŠ[£OØ gÚ±W );
    var5 _testing_ending::setagentmaxhealth( level.‹w¹íWP†Ï¹‹ßŠÃğöE.§ÚGZÌ(­ş€˜ á²]‰ );
    var5 thread _testing_ending::alwaysdoskyspawnontacinsert();
    var5 thread _testing_ending::activeparachutersfactionvo();
    var5 thread _testing_ending::activestate();
    thread doomstation_agentondeath();
    var5.maxsightdistsqrd = 16000000;
    
    if ( var2 )
    {
        var5 _testing_ending::scriptable_token_scriptable_touched_callback( level.‹w¹íWP†Ï¹‹ßŠÃğöE.¬w—&»È¶ );
    }
    
    return var5;
}

// Params 0
// Size: 0xa3
function doomstation_agentondeath()
{
    self endon( "game_ended" );
    self waittill( "death", var0 );
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.new_rider_combat_logic = scripts\engine\utility::array_remove( level.‹w¹íWP†Ï¹‹ßŠÃğöE.new_rider_combat_logic, self );
    
    if ( level.‹w¹íWP†Ï¹‹ßŠÃğöE.new_rider_combat_logic.size == 0 )
    {
        thread doomstation_chopperflee( level );
    }
    
    if ( randomfloat( 1 ) > level.‹w¹íWP†Ï¹‹ßŠÃğöE.¸Ğ-E<Ö"‹#	­2¢ )
    {
        return;
    }
    
    var1 = spawnstruct();
    var1.origin = self.origin;
    var1.angles = self.angles;
    var1.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var1.itemsdropped = 0;
    var1 scripts\mp\gametypes\br_lootcache::chooseandspawnitems( 0, 1, "ammo" );
}

// Params 1
// Size: 0x158
function doomstation_chopperflee( var0 )
{
    level endon( "game_ended" );
    
    if ( level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli.size == 0 )
    {
        return;
    }
    
    var1 = level.$ÛŞkæ:GK½¹ getscriptablepartstate( "br_doomstation" );
    var2 = 0;
    
    if ( !var0 && var1 != "opening" && var1 != "open" )
    {
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli[ 0 ] setvehgoalpos( level.‹w¹íWP†Ï¹‹ßŠÃğöE.endpoint + ( 0, 0, 450 ), 1 );
        var2 = 1;
    }
    
    var3 = [];
    
    for ( var4 = var2; var4 < level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli.size ; var4++ )
    {
        var5 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli[ var4 ];
        var3 = var5;
        var5 vehicle_setspeed( 45, 137.5 );
        var5 setvehgoalpos( ( 0, 0, 40000 ), 1 );
        wait 2;
    }
    
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli[ var2 ] waittill( "goal" );
    
    if ( level.$ÛŞkæ:GK½¹ getscriptablepartstate( "br_doomstation" ) == "open" )
    {
        var2 = 0;
    }
    
    for ( var4 = level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli.size - 1; var4 >= var2 ; var4-- )
    {
        doomstation_chopperdelete( level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli[ var4 ] );
        level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli[ var4 ] = undefined;
    }
    
    level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli = scripts\engine\utility::array_removeundefined( level.‹w¹íWP†Ï¹‹ßŠÃğöE.heli );
}

// Params 1
// Size: 0x11
function doomstation_chopperdelete( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle( var0 );
}

// Params 1
// Size: 0x1f
function doomstationpostplunder( var0 )
{
    if ( playerplunderupdatedoomstation( var0 ) )
    {
        thread doomstation_playerupdateaffordablestate( level.$ÛŞkæ:GK½¹.useprompt );
        return;
    }
}

// Params 1
// Size: 0xa2
function playerplunderupdatedoomstation( var0 )
{
    if ( istrue( level.‹w¹íWP†Ï¹‹ßŠÃğöE.started ) )
    {
        return 0;
    }
    
    var1 = int( level.‹w¹íWP†Ï¹‹ßŠÃğöE.price / 100 );
    
    if ( !isdefined( var0 ) || !isdefined( var0.player ) )
    {
        return 1;
    }
    
    if ( var0.player.plundercount >= var1 && var0.player.plundercount - var0.ref_127b4 >= var1 )
    {
        return 0;
    }
    
    if ( var0.player.plundercount < var1 && var0.player.plundercount - var0.ref_127b4 < var1 )
    {
        return 0;
    }
    
    return 1;
}

// Params 4
// Size: 0x115
function spawnherovillaintoken( var0, var1, var2, var3 )
{
    var4 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var5 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var4, var0, var1, var2, undefined, 0, 0 );
    var6 = var5.origin + ( 0, 0, 25 );
    var7 = anglestoforward( var1 );
    
    if ( !isdefined( var3 ) )
    {
        var3 = var0;
    }
    
    var5.origin = var6 + 20 * var7;
    var8 = vectortoangles( var5.origin - var3 );
    var5.angles = ( 0, var8[ 1 ], 0 );
    var5.ref_12223 = getscriptablereservedremaining( var3 - ( 0, 0, 20 ), var5.origin );
    var9 = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_hvv_hero_token", var5, 1, 1, undefined, 1 );
    var5.origin = var6 - 20 * var7;
    var8 = vectortoangles( var5.origin - var3 );
    var5.angles = ( 0, var8[ 1 ], 0 );
    var5.ref_12223 = getscriptablereservedremaining( var3 - ( 0, 0, 20 ), var5.origin );
    var10 = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_hvv_villain_token", var5, 1, 1, undefined, 1 );
    var9.±µíbÍ¼˜˜ÅC = var10;
    var10.±µíbÍ¼˜˜ÅC = var9;
}

// Params 1
// Size: 0x10d
function takeherovillaintokenpickup( var0 )
{
    if ( issubstr( var0.scriptablename, "hvv_hero_token" ) )
    {
        thread scripts\mp\utility\points::giveunifiedpoints( "br_heroContribution" );
        giveheropoints( getdvarint( "scr_br_hvv_token_points_pickup", 100 ) );
        
        if ( getdvarint( "scr_br_enable_hvv_discounts", 0 ) > 0 )
        {
            selectdiscountonhbundle( 1 );
        }
        
        self.ˆÆÆ°›£Cè{¶•Í = 1;
        scripts\mp\gametypes\br_public::brleaderdialog( "hero_token_pickup_dialog", 1, [ self ], 1, 0, undefined, "bchr" );
    }
    else if ( issubstr( var0.scriptablename, "hvv_villain_token" ) )
    {
        thread scripts\mp\utility\points::giveunifiedpoints( "br_villainContribution" );
        givevillainpoints( getdvarint( "scr_br_hvv_token_points_pickup", 100 ) );
        
        if ( getdvarint( "scr_br_enable_hvv_discounts", 0 ) > 0 )
        {
            selectdiscountonvbundle( 1 );
        }
        
        self.ˆÆÆ°›£Cè{¶•Í = 2;
        scripts\mp\gametypes\br_public::brleaderdialog( "villain_token_pickup_dialog", 1, [ self ], 1, 0, undefined, "mndz" );
    }
    
    if ( isdefined( var0.tracknonoobplayerlocation ) && isdefined( var0.tracknonoobplayerlocation.±µíbÍ¼˜˜ÅC ) )
    {
        var0.tracknonoobplayerlocation.±µíbÍ¼˜˜ÅC scripts\mp\gametypes\br_pickups::lastgoodjobplayer();
        var0.tracknonoobplayerlocation.±µíbÍ¼˜˜ÅC = undefined;
        return;
    }
}

// Params 0
// Size: 0xe, Type: bool
function arefactionpointsenabled()
{
    return getdvarint( "scr_br_enable_hvv_points", 0 ) > 0;
}

// Params 0
// Size: 0xb7
function loadplayerhvveventpoints()
{
    if ( isdefined( self.¢›Õ3\ 
GŠŒú ) )
    {
        return;
    }
    
    self.¢›Õ3\ 
GŠŒú = spawnstruct();
    self.¢›Õ3\ 
GŠŒú.²]8Û:âÎëûÊÖçÃÀ¬» = 0;
    self.¢›Õ3\ 
GŠŒú.„“}çˆ÷ë°Ëè–eËÊ¹G = 0;
    self.¢›Õ3\ 
GŠŒú.„÷SøÏ;-ëZ³PskÃp = 0;
    self.¢›Õ3\ 
GŠŒú.›ñ/¸İÛñÕk5óo hû÷ = 0;
    self.¢›Õ3\ 
GŠŒú.ƒÔí·ñ9üº`€ÕËèã3 = self.¢›Õ3\ 
GŠŒú.²]8Û:âÎëûÊÖçÃÀ¬» + self.¢›Õ3\ 
GŠŒú.„÷SøÏ;-ëZ³PskÃp;
    self.¢›Õ3\ 
GŠŒú.—öÑ·cìKØc…´›ÛZæ:Ü = self.¢›Õ3\ 
GŠŒú.„“}çˆ÷ë°Ëè–eËÊ¹G + self.¢›Õ3\ 
GŠŒú.›ñ/¸İÛñÕk5óo hû÷;
    self waittill( "joined_squad" );
    self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe = getplayerhvvallegiance();
    updatehvvallegiancesquaddataomnvar( self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe );
}

// Params 0
// Size: 0x42
function getplayerhvvallegiance()
{
    if ( self.¢›Õ3\ 
GŠŒú.ƒÔí·ñ9üº`€ÕËèã3 > self.¢›Õ3\ 
GŠŒú.—öÑ·cìKØc…´›ÛZæ:Ü )
    {
        return 1;
    }
    
    if ( self.¢›Õ3\ 
GŠŒú.ƒÔí·ñ9üº`€ÕËèã3 < self.¢›Õ3\ 
GŠŒú.—öÑ·cìKØc…´›ÛZæ:Ü )
    {
        return 2;
    }
    
    return 0;
}

// Params 0
// Size: 0x18
function updateplayerpointsomnvar()
{
    updatehvvplayerpointsdataomnvar();
    updatehvvallegiancesquaddataomnvar( self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe );
}

// Params 1
// Size: 0xc5, Type: bool
function giveheropoints( var0 )
{
    var1 = arefactionpointsenabled();
    
    if ( !var1 )
    {
        return false;
    }
    
    if ( var0 <= 0 )
    {
        return false;
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_1301e( "hvv_h", var0 );
    var2 = self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe;
    self.¢›Õ3\ 
GŠŒú.„÷SøÏ;-ëZ³PskÃp += var0;
    self.¢›Õ3\ 
GŠŒú.ƒÔí·ñ9üº`€ÕËèã3 += var0;
    self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe = getplayerhvvallegiance();
    updateplayerpointsomnvar();
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var3 = self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe == 0;
    var4 = var2 != self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe;
    
    if ( var4 && !var3 )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "welcome_faction", self, 1, 0 );
    }
    
    branalytics_hvvpoints( var0, "hero" );
    return true;
}

// Params 1
// Size: 0xc4, Type: bool
function givevillainpoints( var0 )
{
    var1 = arefactionpointsenabled();
    
    if ( !var1 )
    {
        return false;
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_1301e( "hvv_v", var0 );
    var2 = self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe;
    self.¢›Õ3\ 
GŠŒú.›ñ/¸İÛñÕk5óo hû÷ += var0;
    self.¢›Õ3\ 
GŠŒú.—öÑ·cìKØc…´›ÛZæ:Ü += var0;
    self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe = getplayerhvvallegiance();
    updateplayerpointsomnvar();
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var3 = self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe == 0;
    var4 = var2 != self.¢›Õ3\ 
GŠŒú.†%«KçGúh`™IINe;
    
    if ( var4 && !var3 )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "welcome_faction", self, 1, 0, undefined, undefined, "mndz" );
    }
    
    branalytics_hvvpoints( var0, "villain" );
    return true;
}

// Params 2
// Size: 0x2f
function branalytics_hvvpoints( var0, var1 )
{
    var2 = [];
    GscBinSkip0( 0x2e, var2.size, "type" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x55
function updatehvvplayerpointsdataomnvar()
{
    var0 = int( self.¢›Õ3\ 
GŠŒú.„÷SøÏ;-ëZ³PskÃp / 100 );
    var1 = int( self.¢›Õ3\ 
GŠŒú.›ñ/¸İÛñÕk5óo hû÷ / 100 );
    var2 = self calloutmarkerping_entityzoffset( "ui_br_hvv_points" );
    var2 = _calloutmarkerping_handleluinotify_added::repackomnvar( 0, 12, var2, var0 );
    var2 = _calloutmarkerping_handleluinotify_added::repackomnvar( 12, 12, var2, var1 );
    self setclientomnvar( "ui_br_hvv_points", var2 );
}

// Params 1
// Size: 0xc2
function updatehvvallegiancesquaddataomnvar( var0 )
{
    var1 = scripts\mp\gametypes\br_public::round_at_max( self.team, self.squadindex, "ui_br_hvv_points" );
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var2 = scripts\engine\utility::ter_op( isdefined( self.pers[ "squadMemberIndex" ] ), self.pers[ "squadMemberIndex" ] - 1, 0 );
    var3 = var2 * 2;
    var4 = _calloutmarkerping_handleluinotify_added::repackomnvar( var3, 2, var1, var0 );
    scripts\mp\gametypes\br_public::ref_131c3( self.team, self.squadindex, "ui_br_hvv_points", var4 );
    
    if ( var4 != var1 )
    {
        var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
        var3 = 24;
        
        foreach ( var7 in var5 )
        {
            if ( !isdefined( var7 ) )
            {
                continue;
            }
            
            var7 _calloutmarkerping_handleluinotify_added::ref_1313e( "ui_br_hvv_points", var3, 8, var4 );
        }
        
        return;
    }
}

// Params 2
// Size: 0x1f2
function brolaride_givematchpoint( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = undefined;
    
    foreach ( var4 in var1 )
    {
        if ( isdefined( var4 ) )
        {
            var4 playlocalsound( "hud_points_count" );
            var2 = var4.team;
        }
    }
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var6 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var2 ] ), level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var2 ], 0 );
    var7 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var2 ] ), level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var2 ], 0 );
    
    if ( var0 )
    {
        var7 += 1;
        level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var2 ] = var7;
    }
    else
    {
        var6 += 1;
        level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var2 ] = var6;
    }
    
    if ( !isdefined( level.disable_super_in_turret.‹é	GÂå?cY¦e¨ºƒ¡¿Ë*¶Ø ) || var7 > level.disable_super_in_turret.‹é	GÂå?cY¦e¨ºƒ¡¿Ë*¶Ø )
    {
        level.disable_super_in_turret.‹é	GÂå?cY¦e¨ºƒ¡¿Ë*¶Ø = var7;
    }
    
    if ( !isdefined( level.disable_super_in_turret.²…ZÇ×Ë£ße+³Û‘×x[£Ã»> ) || var6 > level.disable_super_in_turret.²…ZÇ×Ë£ße+³Û‘×x[£Ã»> )
    {
        level.disable_super_in_turret.²…ZÇ×Ë£ße+³Û‘×x[£Ã»> = var6;
    }
    
    var8 = int( max( level.disable_super_in_turret.‹é	GÂå?cY¦e¨ºƒ¡¿Ë*¶Ø, level.disable_super_in_turret.²…ZÇ×Ë£ße+³Û‘×x[£Ã»> ) );
    var9 = var8 == level.disable_super_in_turret.²…ZÇ×Ë£ße+³Û‘×x[£Ã»>;
    var10 = var8 == level.disable_super_in_turret.‹é	GÂå?cY¦e¨ºƒ¡¿Ë*¶Ø;
    level.disable_super_in_turret.Œìª`{{‘˜Jo.(â§¹,pxµwšè`â = scripts\engine\utility::ter_op( var9 && !var10, 1, undefined );
    
    if ( var8 >= level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿ && !istrue( level.disable_super_in_turret.—IÒ+qÏ’ğŸ© ) )
    {
        brolaride_triggerlastcall( var10, var2 );
    }
    
    br_olaride_updateleaders( var2, var0, var1 );
    brolaride_updatevisionsets( var8 );
    brolaride_updatebombsitespawningradius( var8 );
    brolaride_updatebombsiteswantedcount( var8 );
    brolaride_updatemusicandambience( var8 );
    
    foreach ( var2 in level.teamnamelist )
    {
        brolaride_updateteamscore( var2 );
    }
}

// Params 3
// Size: 0x81
function br_olaride_updateleaders( var0, var1, var2 )
{
    if ( br_olaride_isnewleader( var0, var1 ) )
    {
        level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½ = [ var0 ];
        level.disable_super_in_turret.Šã‹ •+PHŸñRŞs = brolaride_getteamscore( var0, var1 );
    }
    else if ( brolaride_getteamscore( var0, var1 ) == level.disable_super_in_turret.Šã‹ •+PHŸñRŞs )
    {
        level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½ = scripts\engine\utility::array_add( level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½, var0 );
    }
    
    if ( istrue( level.disable_super_in_turret.‚ƒà*£µã‘#ŒÀ'ƒû‹²çöxı~ ) )
    {
        thread br_olaride_showleadersplash( var0 );
        return;
    }
}

// Params 2
// Size: 0x5d, Type: bool
function br_olaride_isnewleader( var0, var1 )
{
    if ( brolaride_getteamscore( var0, var1 ) > level.disable_super_in_turret.Šã‹ •+PHŸñRŞs )
    {
        return true;
    }
    else if ( level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½.size == 0 && brolaride_getteamscore( var0, var1 ) >= level.disable_super_in_turret.Šã‹ •+PHŸñRŞs )
    {
        level.disable_super_in_turret.‚ƒà*£µã‘#ŒÀ'ƒû‹²çöxı~ = 1;
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x31
function br_olaride_showleadersplash( var0 )
{
    level endon( "game_ended" );
    wait 1;
    level.disable_super_in_turret.‚ƒà*£µã‘#ŒÀ'ƒû‹²çöxı~ = undefined;
    ref_13372( var0, "bm_vips_marked" );
    showsplashtoteam( var0, "bm_player_marked" );
}

// Params 1
// Size: 0x140
function brolaride_updateteamscore( var0 )
{
    var1 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var0 ] ), level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var0 ], 0 );
    var2 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var0 ] ), level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var0 ], 0 );
    var3 = max( var1, var2 );
    var4 = scripts\mp\utility\teams::getenemyteams( var0 );
    var5 = 0;
    var6 = 0;
    var7 = getteamscore( var0 );
    var8 = 1;
    
    foreach ( var10 in var4 )
    {
        var11 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var10 ] ), level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var10 ], 0 );
        var12 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var10 ] ), level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var10 ], 0 );
        var13 = max( var11, var12 );
        
        if ( var11 > var5 )
        {
            var5 = var11;
        }
        
        if ( var12 > var6 )
        {
            var6 = var12;
        }
        
        if ( var13 > var3 || var13 == var3 && getteamscore( var10 ) > var7 )
        {
            var8++;
        }
    }
    
    level.disable_super_in_turret.ref_13ab8[ var0 ] = var8;
    updateolaridedataomnvar( var0, var1, var2, var5, var6, var8 );
    brolaride_checkvictory( var0, var1 > var2, var3 );
}

// Params 2
// Size: 0x4f
function brolaride_getteamscore( var0, var1 )
{
    if ( var1 )
    {
        return scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var0 ] ), level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var0 ], 0 );
    }
    
    return scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var0 ] ), level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var0 ], 0 );
}

// Params 1
// Size: 0x7f
function brolaride_getteamplacement( var0 )
{
    var1 = max( brolaride_getteamscore( var0, 1 ), brolaride_getteamscore( var0, 0 ) );
    var2 = getteamscore( var0 );
    var3 = scripts\mp\utility\teams::getenemyteams( var0 );
    var4 = 1;
    
    foreach ( var6 in var3 )
    {
        var7 = max( brolaride_getteamscore( var6, 1 ), brolaride_getteamscore( var6, 0 ) );
        
        if ( var7 > var1 || var7 == var1 && getteamscore( var6 ) > var2 )
        {
            var4++;
        }
    }
    
    return var4;
}

// Params 6
// Size: 0xcc
function updateolaridedataomnvar( var0, var1, var2, var3, var4, var5 )
{
    var6 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    if ( !isdefined( var6 ) || var6.size == 0 )
    {
        return;
    }
    
    var7 = 0;
    var1 = int( var1 ) & 15;
    var7 += var1 << 0;
    var2 = int( var2 ) & 15;
    var7 += var2 << 4;
    var3 = int( var3 ) & 15;
    var7 += var3 << 8;
    var4 = int( var4 ) & 15;
    var7 += var4 << 12;
    var5 = int( var5 ) & 31;
    var7 += var5 << 16;
    var8 = scripts\engine\utility::ter_op( istrue( level.disable_super_in_turret.—IÒ+qÏ’ğŸ© ), 1, 0 );
    var7 += var8 << 21;
    
    foreach ( var10 in var6 )
    {
        if ( isdefined( var10 ) )
        {
            var10 _calloutmarkerping_handleluinotify_added::ref_1313e( "ui_br_olaride_points", 0, 22, var7 );
        }
    }
}

// Params 3
// Size: 0x1f
function brolaride_checkvictory( var0, var1, var2 )
{
    if ( var2 < level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã )
    {
        return;
    }
    
    brolaride_endgame( var0, var1 );
}

// Params 2
// Size: 0x328
function brolaride_endgame( var0, var1 )
{
    if ( isdefined( level.—?g1)Ë¤1Øšò°Ÿ!-ô ) )
    {
        return;
    }
    
    level.—?g1)Ë¤1Øšò°Ÿ!-ô = 1;
    
    if ( !isdefined( var1 ) )
    {
        var2 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var0 ] ), level.disable_super_in_turret.’É¡¬9{µ°£8Ş–7G¹[ var0 ], 0 );
        var3 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var0 ] ), level.disable_super_in_turret.¥ë[Ìôø/2k{úã`Ÿ¤À“ò[ var0 ], 0 );
        
        if ( var2 > 0 || var3 > 0 )
        {
            var1 = var2 > var3;
        }
        else
        {
            var4 = 0;
            var5 = 0;
            var6 = scripts\mp\utility\teams::getteamdata( var0, "players" );
            
            foreach ( var8 in var6 )
            {
                if ( !isdefined( var8 ) || !isdefined( var8.¢›Õ3\ 
GŠŒú ) )
                {
                    continue;
                }
                
                var4 += var8.¢›Õ3\ 
GŠŒú.„÷SøÏ;-ëZ³PskÃp;
                var5 += var8.¢›Õ3\ 
GŠŒú.›ñ/¸İÛñÕk5óo hû÷;
            }
            
            if ( var4 > 0 || var5 > 0 )
            {
                var1 = var4 > var5;
            }
            else
            {
                var1 = 1;
            }
        }
    }
    
    foreach ( var8 in level.players )
    {
        if ( isdefined( var8 ) )
        {
            setplayerashvfxactive( var8, 0 );
            var8 _calloutmarkerping_handleluinotify_added::ref_1313e( "ui_br_olaride_points", 31, 1, var1 );
        }
    }
    
    var6 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    foreach ( var8 in var6 )
    {
        if ( !isdefined( var8 ) )
        {
            continue;
        }
        
        if ( var1 )
        {
            var8 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "hvv_ltm_w_h" );
            continue;
        }
        
        var8 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "hvv_ltm_w_v" );
    }
    
    var14 = "";
    
    if ( var1 )
    {
        var14 = "Hero";
        scripts\mp\infilexfil\mp_br_ex_olaride::heroesexfil_init();
    }
    else
    {
        var14 = "Villain";
        scripts\mp\infilexfil\mp_br_ex_olaride::villainsexfil_init();
        level.šä˜K«ÿ;H=³¦271¦ø¸ï£“c²£Í¿ = "mndz";
    }
    
    getentitylessscriptablearray( "dlog_event_hvv_victorious_faction", [ "faction", var14 ] );
    setteamscore( var0, getteamscore( var0 ) + level.disable_super_in_turret.onspawn_slowspeed );
    
    foreach ( var21, var16 in level.teamdata )
    {
        if ( !scripts\mp\utility\teams::isgameplayteam( var21 ) )
        {
            continue;
        }
        
        var17 = scripts\engine\utility::ter_op( isdefined( level.disable_super_in_turret.ref_13ab8[ var21 ] ), level.disable_super_in_turret.ref_13ab8[ var21 ], brolaride_getteamplacement( var21 ) );
        thread scripts\mp\gametypes\br::ref_1209b( var21, var17, 0, 1, undefined, var21 == var0 );
        
        if ( var21 == var0 )
        {
            continue;
        }
        
        var18 = scripts\mp\utility\teams::getteamdata( var21, "alivePlayers" );
        
        if ( var18.size > 0 )
        {
            foreach ( var8 in var18 )
            {
                if ( isdefined( var8 ) )
                {
                    var8.plotarmor = 1;
                    var8 freezecontrols( 1 );
                    var8 playerhide();
                    
                    if ( isdefined( var8.flare_thread ) && var8.flare_thread.size > 0 )
                    {
                        var8 scripts\mp\weapons::disableburnfx();
                    }
                    
                    if ( !var8 isonground() && !var8 isparachuting() )
                    {
                        var8 skydive_deployparachute();
                    }
                }
            }
        }
    }
    
    thread brolaride_postexfil();
    thread scripts\mp\gamelogic::endgame( var0, game[ "end_reason" ][ "objective_completed" ], game[ "end_reason" ][ "objective_failed" ], undefined, undefined, 1 );
}

// Params 0
// Size: 0x90
function brolaride_processlastcalltimer()
{
    level endon( "game_ended" );
    level waittill( "infils_ready" );
    wait brolaride_getlastcalltimer();
    
    if ( istrue( level.disable_super_in_turret.—IÒ+qÏ’ğŸ© ) )
    {
        return;
    }
    
    brolaride_updatemusicandambience( level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿ );
    brolaride_triggerlastcall( undefined, undefined );
    var0 = scripts\engine\utility::ter_op( istrue( level.disable_super_in_turret.—IÒ+qÏ’ğŸ© ), 1, 0 );
    
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) )
        {
            var2 _calloutmarkerping_handleluinotify_added::ref_1313e( "ui_br_olaride_points", 21, 1, var0 );
        }
    }
}

// Params 0
// Size: 0x6a
function brolaride_getlastcalltimer()
{
    var0 = 0;
    var1 = getdvarint( "scr_br_last_call_trigger_circle", 3 );
    
    for ( var2 = 0; var2 < var1 ; var2++ )
    {
        var3 = level.br_level.br_circledelaytimes[ var2 ];
        
        if ( isdefined( var3 ) )
        {
            var0 += var3;
        }
        
        var3 = level.br_level.br_circleclosetimes[ var2 ];
        
        if ( isdefined( var3 ) )
        {
            var0 += var3;
        }
    }
    
    var4 = getdvarint( "scr_br_last_call_trigger_time_before_circle_end", 120 );
    var0 = max( 0, var0 - var4 );
    return var0;
}

// Params 2
// Size: 0x38
function brolaride_triggerlastcall( var0, var1 )
{
    if ( istrue( level.disable_super_in_turret.—IÒ+qÏ’ğŸ© ) )
    {
        return;
    }
    
    level.disable_super_in_turret.—IÒ+qÏ’ğŸ© = 1;
    brolaride_createlastcallbombsites( var0 );
    brolaride_triggerlastcalldialog( var1 );
    brolaride_triggerlastcallsplash( var1 );
}

// Params 1
// Size: 0x3a
function brolaride_applylastcalldiscount( var0 )
{
    if ( getdvarint( "scr_br_enable_hvv_discounts", 0 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = scripts\engine\utility::ter_op( var0, "br_bomb", "br_defusekit" );
    var2 = _getidfromrefinpurchasetable( var1 );
    _sethvvlastcalldiscountid( var2 );
}

// Params 1
// Size: 0x89
function brolaride_createlastcallbombsites( var0 )
{
    var1 = bombsite_getpossiblesites( 0 );
    
    if ( var1.size == 0 )
    {
        return 0;
    }
    
    var2 = getdvarint( "scr_br_olaride_last_call_bomb_count", 3 );
    
    if ( !isdefined( var0 ) && ( var2 & 1 ) == 1 )
    {
        var2++;
    }
    
    var3 = bombsite_choosensitestoactivate( var1, var2 );
    
    for ( var4 = 0; var4 < var3.size ; var4++ )
    {
        var5 = var3[ var4 ];
        
        if ( !isdefined( var0 ) )
        {
            brolaride_activatelastcallbombsite( var5, ( var4 & 1 ) == 1 );
            continue;
        }
        
        if ( var0 )
        {
            brolaride_activatelastcallbombsite( var5, 0 );
            continue;
        }
        
        brolaride_activatelastcallbombsite( var5, 1 );
    }
    
    return var3.size;
}

// Params 1
// Size: 0x2e
function brolaride_activatelastcallbombsite( var0 )
{
    bombsite_activate( self );
    
    if ( !istrue( var0 ) )
    {
        return;
    }
    
    var1 = level.disable_super_in_turret.–p3À¢óõ	Ñ3Ë|y(ƒóğHÚE;
    bombsite_setupplantedbombsite( self, undefined, var1 );
    bombsite_setobjectiveasplanted( undefined );
}

// Params 1
// Size: 0x49
function brolaride_triggerlastcalldialog( var0 )
{
    var1 = [];
    
    if ( isdefined( var0 ) )
    {
        var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    }
    
    var2 = scripts\engine\utility::array_remove_array( level.players, var1 );
    scripts\mp\gametypes\br_public::brleaderdialog( "last_call_leading_team_dialog", 1, var1, 1, 1 );
    scripts\mp\gametypes\br_public::brleaderdialog( "last_call_other_team_dialog", 1, var2, 1, 1 );
}

// Params 1
// Size: 0x2e
function brolaride_triggerlastcallsplash( var0 )
{
    if ( isdefined( var0 ) )
    {
        ref_13372( var0, "br_olaride_overtime_them" );
        showsplashtoteam( var0, "br_olaride_overtime_us" );
        return;
    }
    
    ref_13371( "br_olaride_overtime_neutral" );
}

// Params 2
// Size: 0x31, Type: bool
function ammorestock_disableusefortime( var0, var1 )
{
    var2 = max( brolaride_getteamscore( var0, 1 ), brolaride_getteamscore( var0, 0 ) );
    var3 = max( brolaride_getteamscore( var1, 1 ), brolaride_getteamscore( var1, 0 ) );
    return var2 >= var3;
}

// Params 2
// Size: 0x41
function kiosk_getscripteddiscount( var0, var1 )
{
    switch ( var0 )
    {
        case 0:
            return _gethvvitemdiscount( var1 );
        case 1:
            return _gethvvbundlediscount( var1 );
        case 2:
            return _gethvvlastcalldiscount( var1 );
        default:
            return 0;
    }
}

// Params 1
// Size: 0x2f
function _gethvvitemdiscount( var0 )
{
    var1 = getdvar( "br_kiosk_discounts_filename", "mp/br_hvv_kiosk_discounts.csv" );
    
    if ( var1 == "" )
    {
        return 0;
    }
    
    return int( _vlookup( var1, 1, 3, var0, 0 ) );
}

// Params 1
// Size: 0x7
function _gethvvbundlediscount( var0 )
{
    return 50;
}

// Params 1
// Size: 0x7
function _gethvvlastcalldiscount( var0 )
{
    return 75;
}

// Params 0
// Size: 0x15
function _getcurrenthbundleid()
{
    return _getcurrentbundleid( [ "br_defusekit", "contribute_heroes" ] );
}

// Params 0
// Size: 0x15
function _getcurrentvbundleid()
{
    return _getcurrentbundleid( [ "br_bomb", "contribute_villains" ] );
}

// Params 1
// Size: 0x3b
function _getcurrentbundleid( var0 )
{
    foreach ( var2 in var0 )
    {
        var3 = _getidfromrefinpurchasetable( var2 );
        
        if ( var3 != -1 )
        {
            return var3;
        }
    }
    
    return -1;
}

// Params 0
// Size: 0x4c
function kiosk_initializecallbacks()
{
    if ( getdvarint( "scr_br_enable_hvv_discounts", 0 ) > 0 )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "kiosk_onPlayerKilled", &kiosk_onplayerkilled );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "getScriptedDiscount", &kiosk_getscripteddiscount );
    }
    
    if ( getdvarint( "scr_br_enable_hvv_kiosk_items", 0 ) > 0 )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "kiosk_onPurchase", &kiosk_onpurchase );
        return;
    }
}

// Params 2
// Size: 0xd1
function kiosk_onpurchase( var0, var1 )
{
    if ( var1 == "contribute_heroes" )
    {
        kiosk_onherocontribution( var0, getdvarint( "scr_br_hvv_kiosk_contribution_bundle", 200 ) );
    }
    else if ( var1 == "br_defusekit" )
    {
        kiosk_onherocontribution( var0, getdvarint( "scr_br_hvv_kiosk_contribution_item", 100 ) );
    }
    else if ( var1 == "contribute_villains" )
    {
        kiosk_onvillaincontribution( var0, getdvarint( "scr_br_hvv_kiosk_contribution_bundle", 200 ) );
    }
    else if ( var1 == "br_bomb" )
    {
        kiosk_onvillaincontribution( var0, getdvarint( "scr_br_hvv_kiosk_contribution_item", 100 ) );
    }
    
    var2 = [];
    GscBinSkip0( 0x2e, var2.size, "type" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0xb
function kiosk_onplayerkilled( var0 )
{
    removediscountonbundle( var0 );
}

// Params 1
// Size: 0x44
function kiosk_onherocontribution( var0 )
{
    giveheropoints( var0 );
    
    if ( getdvarint( "scr_br_enable_hvv_discounts", 0 ) > 0 )
    {
        selectdiscountonhbundle( 0 );
        selectrandomscripteddiscountonkiosk( self.delay_kick_inactive_player );
    }
    
    scripts\mp\gametypes\br_public::brleaderdialog( "hero_contribution_dialog", 1, [ self ], 1, 0, undefined, "bchr" );
}

// Params 1
// Size: 0x44
function kiosk_onvillaincontribution( var0 )
{
    givevillainpoints( var0 );
    
    if ( getdvarint( "scr_br_enable_hvv_discounts", 0 ) > 0 )
    {
        selectdiscountonvbundle( 0 );
        selectrandomscripteddiscountonkiosk( self.delay_kick_inactive_player );
    }
    
    scripts\mp\gametypes\br_public::brleaderdialog( "villain_contribution_dialog", 1, [ self ], 1, 0, undefined, "mndz" );
}

// Params 1
// Size: 0x12
function selectdiscountonhbundle( var0 )
{
    var1 = _getcurrenthbundleid();
    _selectdiscountonbundle( var0, var1 );
}

// Params 1
// Size: 0x12
function selectdiscountonvbundle( var0 )
{
    var1 = _getcurrentvbundleid();
    _selectdiscountonbundle( var0, var1 );
}

// Params 2
// Size: 0x24
function _selectdiscountonbundle( var0, var1 )
{
    if ( var0 )
    {
        _sethvvbundlediscountid( var1 );
        return;
    }
    
    var2 = _gethvvbundlediscountid();
    
    if ( var1 == var2 )
    {
        removediscountonbundle();
        return;
    }
}

// Params 0
// Size: 0xa
function removediscountonbundle()
{
    _sethvvbundlediscountid( -1 );
}

// Params 1
// Size: 0x2c
function selectrandomscripteddiscountonkiosk( var0 )
{
    var1 = _selectrandomref();
    
    if ( var1 == "" )
    {
        return;
    }
    
    var2 = _getidfromrefinpurchasetable( var1 );
    
    if ( var2 == -1 )
    {
        return;
    }
    
    _sethvvitemdiscountid( var2 );
}

// Params 0
// Size: 0x6a
function _selectrandomref()
{
    var0 = getdvar( "br_kiosk_discounts_filename", "mp/br_hvv_kiosk_discounts.csv" );
    
    if ( var0 == "" )
    {
        return "";
    }
    
    var1 = _isfullsquadalive();
    var2 = scripts\engine\utility::ter_op( var1, "teamrevive", "" );
    var3 = "";
    
    for ( ;; )
    {
        var4 = randomint( 100 );
        var3 = scripts\engine\utility::string( _weightlookup( var0, 2, 1, var4, "" ) );
        
        if ( var3 != var2 )
        {
            return var3;
        }
    }
}

// Params 0
// Size: 0x4f, Type: bool
function _isfullsquadalive()
{
    var0 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    
    foreach ( var2 in var0 )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        if ( isalive( var2 ) )
        {
            continue;
        }
        
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x20
function _getidfromrefinpurchasetable( var0 )
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "getIdFromRefInPurchaseTable" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "getIdFromRefInPurchaseTable", var0 );
    }
    
    return -1;
}

// Params 0
// Size: 0x20
function _gethvvbundlediscountid()
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "getScriptedDiscountId" ) )
    {
        return scripts\mp\gametypes\br_gametypes::ref_12e05( "getScriptedDiscountId", self, 1 );
    }
    
    return -1;
}

// Params 1
// Size: 0xd
function _sethvvitemdiscountid( var0 )
{
    _setscripteddiscountid( self, 0, var0 );
}

// Params 1
// Size: 0xe
function _sethvvbundlediscountid( var0 )
{
    _setscripteddiscountid( self, 1, var0 );
}

// Params 1
// Size: 0xe
function _sethvvlastcalldiscountid( var0 )
{
    _setscripteddiscountid( undefined, 2, var0 );
}

// Params 3
// Size: 0x22
function _setscripteddiscountid( var0, var1, var2 )
{
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "setScriptedDiscountId" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e06( "setScriptedDiscountId", var0, var1, var2 );
        return;
    }
}

// Params 5
// Size: 0x46
function _vlookup( var0, var1, var2, var3, var4 )
{
    var5 = tablelookupgetnumrows( var0 );
    var6 = 0;
    
    while ( var6 < var5 )
    {
        var7 = tablelookupbyrow( var0, var6, var1 );
        
        if ( var7 != scripts\engine\utility::string( var3 ) )
        {
        }
        else
        {
            var8 = tablelookupbyrow( var0, var6, var2 );
            return var8;
        }
        
        var7++;
    }
    
    return var5;
}

// Params 5
// Size: 0x50
function _weightlookup( var0, var1, var2, var3, var4 )
{
    var5 = 0;
    var6 = tablelookupgetnumrows( var0 );
    var7 = 0;
    
    while ( var7 < var6 )
    {
        var8 = int( tablelookupbyrow( var0, var7, var1 ) );
        var5 += var8;
        
        if ( var5 <= int( var3 ) )
        {
        }
        else
        {
            var9 = tablelookupbyrow( var0, var7, var2 );
            return var9;
        }
        
        var8++;
    }
    
    return var5;
}

// Params 7
// Size: 0x30, Type: bool
function ref_1458b( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( isdefined( var0 ) && isdefined( var0.targetname ) && var0.targetname == "trigger_multiple_lava" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0xdf
function setuplavatriggers()
{
    level endon( "game_ended" );
    wait 5;
    scripts\cp_mp\utility\script_utility::registersharedfunc( "damage", "weaponIgnoresBRArmor", &ref_1458b );
    var0 = getentarray( "trigger_multiple_lava", "targetname" );
    var1 = [];
    var2 = getallvehiclesinstances();
    level.©Ø,;°İ:C•‘ÊæÑ-£Ò¬¹ = [];
    
    foreach ( var4 in var0 )
    {
        var4.…ëçX`èÇOÀ ‘«k = [];
        thread watchlavatrigger( var4 );
        thread watchentitycollisionwithlavatriggers( var4, var5 * 0.1 );
        
        if ( var4.dmg >= 9999 && getdvarint( "scr_br_lava_triggers_affect_vehicles", 1 ) > 0 )
        {
            thread watchvehiclecollisionwithlavatriggers( var4, var2, var5 * 0.1 );
        }
    }
    
    level waittill( "prematch_fade_done" );
    
    foreach ( var7 in level.players )
    {
        thread watchthrownentities();
    }
}

// Params 1
// Size: 0x2b
function watchlavatrigger( var0 )
{
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        
        if ( !scripts\engine\utility::array_contains( var0.…ëçX`èÇOÀ ‘«k, var1 ) )
        {
            thread handleentitytouchinglava( var1, var0 );
        }
    }
}

// Params 2
// Size: 0x104
function handleentitytouchinglava( var0, var1 )
{
    level endon( "game_ended" );
    var1.…ëçX`èÇOÀ ‘«k = scripts\engine\utility::array_add( var1.…ëçX`èÇOÀ ‘«k, var0 );
    var2 = undefined;
    
    while ( isdefined( var0 ) && isalive( var0 ) && var0 istouching( var1 ) )
    {
        var3 = var1.dmg;
        
        if ( var0 scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            var3 *= 5;
        }
        
        if ( var3 >= 9999 && isplayer( var0 ) && var0 scripts\mp\utility\perk::_hasperk( "specialty_blastshield" ) )
        {
            var0 scripts\mp\utility\perk::removeperk( "specialty_blastshield" );
        }
        
        var0 dodamage( var3, var0.origin, var1, var1, "MOD_FIRE" );
        
        if ( isplayer( var0 ) && !isdefined( var2 ) )
        {
            var2 = spawn( "script_origin", var0.origin );
            var2 linkto( var0 );
            var2 playloopsound( "player_lava_burn_damage_loop" );
        }
        
        if ( isplayer( var0 ) )
        {
            var0 playlocalsound( "trigger_hurt_impact_plr" );
        }
        
        wait 1;
    }
    
    if ( isdefined( var2 ) )
    {
        var0 playlocalsound( "player_lava_burn_damage_end" );
        thread entitystoploopingsound( var2, 0.15 );
    }
    
    var1.…ëçX`èÇOÀ ‘«k = scripts\engine\utility::array_remove( var1.…ëçX`èÇOÀ ‘«k, var0 );
}

// Params 2
// Size: 0x24
function entitystoploopingsound( var0, var1 )
{
    level endon( "game_ended" );
    wait var1;
    
    if ( isdefined( var0 ) )
    {
        var0 stoploopsound();
        wait 0.1;
        var0 delete();
        return;
    }
}

// Params 3
// Size: 0x71
function watchvehiclecollisionwithlavatriggers( var0, var1, var2 )
{
    level endon( "game_ended" );
    wait var2;
    
    while ( var1.size >= 1 )
    {
        foreach ( var4 in var1 )
        {
            if ( isdefined( var4 ) && var4 istouching( var0 ) )
            {
                var4 dodamage( var0.dmg, var4.origin, var0, var0, "MOD_FIRE" );
            }
        }
        
        wait 1;
        var1 = scripts\engine\utility::array_removeundefined( var1 );
    }
}

// Params 2
// Size: 0xef
function watchentitycollisionwithlavatriggers( var0, var1 )
{
    level endon( "game_ended" );
    wait var1;
    
    for ( ;; )
    {
        foreach ( var3 in level.©Ø,;°İ:C•‘ÊæÑ-£Ò¬¹ )
        {
            if ( isdefined( var3 ) && var3 istouching( var0 ) )
            {
                if ( isdefined( var3.deletefunc ) )
                {
                    var3 [[ var3.deletefunc ]]();
                    var3 notify( "deleted_equipment" );
                    continue;
                }
                
                if ( isdefined( var3.animname ) && var3.animname == "slinger" )
                {
                    if ( isdefined( var3.scenenode ) && var3.scenenode istouching( var0 ) && isdefined( var3.laststandplayers ) )
                    {
                        var3 notify( "slinger_destroyed" );
                    }
                    
                    continue;
                }
                
                var3 scripts\mp\weapons::cleanupequipment( var3 getentitynumber(), var3.killcament, var3.trigger );
                var3 notify( "deleted_equipment" );
                var3 delete();
            }
        }
        
        wait 1;
        level.©Ø,;°İ:C•‘ÊæÑ-£Ò¬¹ = scripts\engine\utility::array_removeundefined( level.©Ø,;°İ:C•‘ÊæÑ-£Ò¬¹ );
    }
}

// Params 0
// Size: 0x90
function watchthrownentities()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    for ( ;; )
    {
        var0 = _utilflare_isvalidflaretype::waittill_grenade_throw();
        
        if ( isdefined( var0 ) )
        {
            if ( isdefined( var0.equipmentref ) && var0.equipmentref == "equip_slinger" )
            {
                var0 waittill( "missile_stuck" );
                waitframe();
                
                if ( isdefined( self.¥=	óHssø=“ ) && self.¥=	óHssø=“.size > 0 )
                {
                    var0 = self.¥=	óHssø=“[ self.¥=	óHssø=“.size - 1 ];
                }
                else
                {
                    var0 = undefined;
                }
            }
            
            if ( isdefined( var0 ) && !scripts\engine\utility::array_contains( level.©Ø,;°İ:C•‘ÊæÑ-£Ò¬¹, var0 ) )
            {
                level.©Ø,;°İ:C•‘ÊæÑ-£Ò¬¹[ level.©Ø,;°İ:C•‘ÊæÑ-£Ò¬¹.size ] = var0;
            }
        }
    }
}

// Params 0
// Size: 0x7a
function getallvehiclesinstances()
{
    var0 = [];
    
    if ( !isdefined( level.vehicle.instances ) )
    {
        return var0;
    }
    
    foreach ( var2 in level.vehicle.instances )
    {
        foreach ( var4 in var2 )
        {
            if ( isdefined( var4 ) )
            {
                var0 = scripts\engine\utility::array_add( var0, var4 );
            }
        }
    }
    
    return var0;
}

// Params 1
// Size: 0x31
function ref_13371( var0 )
{
    foreach ( var2 in level.players )
    {
        var2 scripts\mp\hud_message::showsplash( var0 );
    }
}

// Params 2
// Size: 0x3a
function showsplashtoteam( var0, var1 )
{
    foreach ( var3 in level.teamdata[ var0 ][ "players" ] )
    {
        var3 scripts\mp\hud_message::showsplash( var1 );
    }
}

// Params 2
// Size: 0x43
function ref_13372( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3 ) && var3.team != var0 )
        {
            var3 scripts\mp\hud_message::showsplash( var1 );
        }
    }
}

// Params 0
// Size: 0x21
function brolaride_initaudio()
{
    scripts\mp\utility\sound::besttime( "br_mode_olaride" );
    level.ref_11e96 = 1;
    level.nosuspensemusic = 1;
    level.« ­ûg¸BìSaå = 0;
}

// Params 0
// Size: 0xc1
function brolaride_updateendingmusicstate()
{
    setmusicstate( "" );
    var0 = level.players;
    
    foreach ( var2 in level.disable_super_in_turret.²2Ÿ5 ¯wÅ(kB•·'`½ )
    {
        var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var2 );
        
        foreach ( var5 in var3 )
        {
            if ( !isdefined( var5 ) )
            {
                continue;
            }
            
            var5 setplayermusicstate( "br3_olaride_victory" );
            var0 = scripts\engine\utility::array_remove( var0, var5 );
        }
    }
    
    foreach ( var5 in var0 )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 setplayermusicstate( "br3_olaride_defeat" );
    }
}

// Params 1
// Size: 0x10c
function brolaride_updatemusicandambience( var0 )
{
    if ( var0 == level.disable_super_in_turret.’¦ƒñÈ©Š‚ƒã )
    {
        brolaride_updateendingmusicstate();
        level notify( "matchCompleted" );
        return;
    }
    
    if ( var0 <= level.« ­ûg¸BìSaå )
    {
        return;
    }
    else
    {
        level.« ­ûg¸BìSaå = var0;
    }
    
    if ( istrue( level.disable_super_in_turret.§í×—YzÀ1UÈ0]®ç_;óòÏøÙ ) )
    {
        return;
    }
    
    if ( var0 >= level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿ )
    {
        setmusicstate( "br3_olaride_last_stage_1" );
        level notify( "lastCall" );
        brolaride_playloopingsound( "amb_olaride_lastcall_storm_lr", "matchCompleted" );
        level.disable_super_in_turret.§í×—YzÀ1UÈ0]®ç_;óòÏøÙ = 1;
        return;
    }
    
    if ( var0 >= level.disable_super_in_turret.›3‘w+Ifóˆ“P	¸“¿ - 1 )
    {
        setmusicstate( "br3_olaride_pre_last_stage_1" );
        brolaride_playloopingsound( "amb_olaride_stage3_storm_lr", "lastCall" );
        return;
    }
    
    if ( var0 >= 3 )
    {
        var1 = [ "br3_olaride_middle_stage_1", "br3_olaride_middle_stage_2", "br3_olaride_middle_stage_3", "br3_olaride_middle_stage_3" ];
        setmusicstate( scripts\engine\utility::random( var1 ) );
        return;
    }
    
    if ( var0 >= 2 )
    {
        setmusicstate( "br3_olaride_second_stage_1" );
        return;
    }
    
    if ( var0 >= 1 )
    {
        setmusicstate( "br3_olaride_first_stage_1" );
        return;
    }
}

// Params 2
// Size: 0x7a
function brolaride_playloopingsound( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        if ( !isdefined( var3 ) || !isdefined( var0 ) )
        {
            continue;
        }
        
        var4 = spawn( "script_origin", var3.origin + ( 0, 0, 50 ) );
        var4 linkto( var3 );
        var4 playloopsound( var0 );
        
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        thread brolaride_stoploopingsound( var1, var4 );
    }
}

// Params 2
// Size: 0x20
function brolaride_stoploopingsound( var0, var1 )
{
    level endon( "game_ended" );
    level waittill( var0 );
    var1 stoploopsound();
    wait 0.1;
    var1 delete();
}

// Params 1
// Size: 0x54
function setplayerashvfxactive( var0 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( self.…ü_2jW+†; ) )
    {
        stopfxontagforclients( scripts\engine\utility::getfx( "vfx_br3_olaride_ashes_visionset" ), self, "j_head", self );
        self.…ü_2jW+†; = undefined;
    }
    
    if ( var0 )
    {
        self.…ü_2jW+†; = scripts\engine\utility::getfx( "vfx_br3_olaride_ashes_visionset" );
        playfxontagforclients( self.…ü_2jW+†;, self, "j_head", self );
        return;
    }
}

// Params 5
// Size: 0xd2
function startshake( var0, var1, var2, var3, var4 )
{
    level endon( "game_ended" );
    wait var2;
    earthquake( var0, var1, var3, var4 );
    radiusdamage( var3, var4, 0.1, 0.05, undefined, "MOD_EXPLOSIVE", undefined, 1 );
    var5 = scripts\mp\utility\player::getplayersinradius( var3, var4 );
    
    if ( scripts\mp\flags::gameflag( "br_ready_to_jump" ) )
    {
        foreach ( var7 in var5 )
        {
            if ( isdefined( var7 ) )
            {
                var8 = 1 - clamp( distance2d( var3, var7.origin ) / var4, 0, 1 );
                var7 playsoundtoplayer( "fafir_anticipation_earthquake_lr", var7 );
                var7 setclientomnvar( "ui_br_hvv_shake", var8 );
            }
        }
        
        wait var1;
        
        foreach ( var7 in var5 )
        {
            if ( isdefined( var7 ) )
            {
                var7 setclientomnvar( "ui_br_hvv_shake", 0 );
            }
        }
        
        return;
    }
}

// Params 7
// Size: 0x2b
function startshakewave( var0, var1, var2, var3, var4, var5, var6 )
{
    level endon( "game_ended" );
    level endon( "stop_shake_waves" );
    wait var0;
    
    for ( ;; )
    {
        thread startshake( var2, var3, var4, var5, var6 );
        wait var1;
    }
}

// Params 0
// Size: 0x2a
function brolaride_onplayerspawned()
{
    if ( istrue( level.gameended ) || !istrue( self.br_infilstarted ) || !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    thread brolaride_playmatchvowhengrounded();
}

// Params 0
// Size: 0x21
function brolaride_playmatchvowhengrounded()
{
    self endon( "death_or_disconnect" );
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "match_start", self );
}

// Params 0
// Size: 0x5e
function brolaride_postexfil()
{
    level waittill( "br_ending_start" );
    scripts\engine\utility::waittill_any_ents( level.defendkill, "all_scenes_end" );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) && isalive( var1 ) )
        {
            var1 setorigin( ( 0, 0, 2900 ) );
        }
    }
}

