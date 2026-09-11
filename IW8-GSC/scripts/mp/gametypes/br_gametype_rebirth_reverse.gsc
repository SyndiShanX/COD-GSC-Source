
// Params 0
// Size: 0x179
function init()
{
    thread enabledfeatures();
    thread enabledskipdeathshield();
    thread enable_traversals_for_bombers();
    thread enabledbasejumping();
    setdvarifuninitialized( "scr_br_rebirth_circle_setting", 0 );
    setdvar( "scr_br_project_kick", 1500 );
    var0 = getdvar( "scr_br_gametype" );
    
    if ( scripts\cp_mp\utility\game_utility::tutorialzoneenter() )
    {
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_ww2.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle2_ww2.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle3_ww2.csv" );
    }
    else if ( var0 == "rebirth_dbd_reverse" )
    {
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_dbd.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle2_dbd.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle3_dbd.csv" );
    }
    else
    {
        timeoutonabandoneddelay( "mp/classtable_br_rebirth.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle2.csv" );
        timeoutonabandoneddelay( "mp/classtable_br_rebirth_circle3.csv" );
    }
    
    level.disable_super_in_turret.ref_140a3 = getdvarint( "scr_br_use_tracked_teams", 1 );
    level.disable_super_in_turret.ref_140a5 = getdvarint( "scr_br_use_vengeance", 1 );
    level.disable_super_in_turret.ref_1428b = getdvarint( "scr_br_vengeance_use_any_kill", 0 );
    level.disable_super_in_turret.ref_140a6 = getdvarint( "scr_br_use_vengeance_decrease_respawn_timer", 1 );
    level.disable_super_in_turret.ref_14094 = getdvarint( "scr_br_use_respawn_waves", 0 );
    level.disable_super_in_turret.ref_1408d = getdvarint( "scr_br_use_points_to_reduce_respawn_time", 1 );
    level.ref_12ca7 = getdvarint( "scr_bmo_respawnHeightOverride", 7500 );
    level.disable_super_in_turret.ref_12c92 = getdvarint( "scr_br_rebirth_respawn_should_wait_prestreaming_end", 0 );
    level.disable_super_in_turret.ref_12c91 = getdvarint( "scr_br_rebirth_respawn_should_notify_started_spawn", 1 );
}

// Params 0
// Size: 0x62
function enabledfeatures()
{
    if ( getdvarint( "scr_br_rebirth_debug", 0 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "allowLateJoiners" );
    }
    
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "randomizeCircleCenter" );
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "planeSnapToOOB" );
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "planeUseCircleRadius" );
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "circleEarlyStart" );
        return;
    }
}

// Params 0
// Size: 0x170
function enabledskipdeathshield()
{
    scripts\mp\gametypes\br_gametypes::ref_12b11( "circleTimer", &circletimer );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "mayConsiderPlayerDead", &empty_function );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerKilledSpawn", &brrebirth_playerkilledspawn );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "markPlayerAsEliminatedOnKilled", &end_escape_silo );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "triggerRespawnOverlay", &end_silo_thrust );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerNakedDropLoadout", &end_intro_obj );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "getDefaultLoadout", &enable_spawner );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "kioskRevivePlayer", &enablejuggernautcrateobjective );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "assignLastStandAttacker", &empdrone_killstreaktargetthink );
    
    if ( !istrue( level.tryupdategenericprogress ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerKilled", &end_game_tutorial_func );
    }
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0 )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "createC130PathStruct", &enable_leaderboard );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "addToC130Infil", &emp_target_monitor );
        thread end_nuke_vault();
    }
    
    waittillframeend();
    
    if ( level.disable_super_in_turret.ref_1408d )
    {
        level.ref_12073 = &end_game_win;
    }
    
    level.ontimelimit = &end_gates;
    enable_keypad_interaction();
    level.ref_140d9 = [];
    level.ref_140d9[ 0 ] = "assassination";
    level.ref_140d9[ 1 ] = "domination";
    level.ref_140d9[ 2 ] = "scavenger";
    scripts\mp\gametypes\br_skydive_protection::init();
    tomastrike_findoptimallaunchpos();
    thread end_paratroopers_group();
    thread end_reach_exhaust_waste();
    thread end_reach_icbm_launch();
    thread end_origin_final();
    thread end_pipe_room();
    thread enabledminimapdisable();
    scripts\mp\rank::ref_12189( "kill", 100 );
    scripts\mp\rank::ref_12189( "br_cacheOpen", 200 );
}

// Params 0
// Size: 0x70
function enable_traversals_for_bombers()
{
    level endon( "game_ended" );
    level waittill( "br_dialog_initialized" );
    game[ "dialog" ][ "match_start" ] = "gametype_resurgence";
    game[ "dialog" ][ "match_desc" ] = "gametype_desc_resurgence_solo";
    game[ "dialog" ][ "rebirth_redeploy" ] = "rebirth_redeploy";
    game[ "dialog" ][ "rebirth_disabled" ] = "rebirth_reinforcement_disabled";
    game[ "dialog" ][ "rebirth_ending" ] = "rebirth_reinforcement_ending";
}

// Params 0
// Size: 0x40
function enabledminimapdisable()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) )
        {
            var1.ref_12ca1 = 0;
        }
    }
}

// Params 0
// Size: 0x39
function enable_keypad_interaction()
{
    scripts\cp_mp\utility\game_utility::ref_12c10( "delete_on_load", "targetname" );
    scripts\cp_mp\utility\game_utility::ref_12c11( "door_prison_cell_metal_mp", 1 );
    scripts\cp_mp\utility\game_utility::ref_12c11( "door_wooden_panel_mp_01", 1 );
    scripts\cp_mp\utility\game_utility::ref_12c11( "me_electrical_box_street_01", 1 );
}

// Params 0
// Size: 0x2
function enabledbasejumping()
{
    
}

// Params 0
// Size: 0x22
function end_paratroopers_group()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.disable_super_in_turret.ref_12ca4 = 1;
}

// Params 0
// Size: 0xb7
function end_reach_exhaust_waste()
{
    waittillframeend();
    var0 = level.allteamnamelist;
    
    foreach ( var2 in var0 )
    {
        level.teamdata[ var2 ][ "index" ] = var3;
    }
    
    var4 = getdvarint( "scr_br_tracked_teams_for_entire_team", 0 );
    
    if ( istrue( var4 ) )
    {
        foreach ( var2 in level.teamdata )
        {
            level.teamdata[ var6 ][ "trackedTeams" ] = [];
        }
        
        return;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( var8 in level.players )
    {
        var8.ref_13c4b = [];
    }
}

// Params 0
// Size: 0x3a
function end_reach_icbm_launch()
{
    foreach ( var1 in level.players )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        var1.ref_1443b = [];
    }
}

// Params 0
// Size: 0x1a
function end_gates()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread scripts\mp\gametypes\br::startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Params 1
// Size: 0x65, Type: bool
function empty_function( var0 )
{
    if ( scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        if ( istrue( level.disable_super_in_turret.ref_12ca4 ) )
        {
            if ( !isdefined( var0.ref_12ca1 ) )
            {
                var0.ref_12ca1 = 0;
            }
            
            if ( var0.ref_12ca1 <= 0 )
            {
                var0.¯Ò"5‹Ø'ƒ˜w%B¸ð·E = 1;
                return false;
            }
        }
        
        scripts\mp\gametypes\br::ref_11b15( var0 );
        brrebirth_hiderebirthrespawntimer( var0 );
        var0 notify( "squad_wiped" );
    }
    
    return true;
}

// Params 0
// Size: 0x6c, Type: bool
function end_escape_silo()
{
    var0 = int( min( level.br_circle.circleindex, level.disable_super_in_turret.ref_12ca1.size - 1 ) );
    var1 = isdefined( self.ref_12ca1 ) && self.ref_12ca1 > 0 && self.ref_12ca1 < level.disable_super_in_turret.ref_12ca1[ var0 ];
    return scripts\mp\flags::gameflag( "prematch_done" ) && ( var1 || !istrue( level.disable_super_in_turret.ref_12ca4 ) );
}

// Params 1
// Size: 0x64
function end_freight_lift( var0 )
{
    foreach ( var2 in scripts\mp\utility\teams::getteamdata( var0.team, "players" ) )
    {
        if ( !istrue( var2.shouldgamelobbyremainintact ) && isalive( var2 ) && var0 != var2 )
        {
            var2.shouldgamelobbyremainintact = 1;
            var2 thread scripts\mp\hud_message::showsplash( "br_rebirth_first_dead" );
        }
    }
}

// Params 0
// Size: 0x37
function end_health()
{
    if ( !isdefined( self.endgame_finitewaves_music ) )
    {
        self.endgame_finitewaves_music = 0;
    }
    
    var0 = self.endgame_finitewaves_music;
    
    if ( var0 > 255 )
    {
        var0 = 255;
    }
    
    self.extrascore0 = var0;
    self.pers[ "extrascore0" ] = var0;
    return var0;
}

// Params 2
// Size: 0xb3
function end_trans_1_obj( var0, var1 )
{
    var2 = !istrue( level.teamdata[ self.team ][ "teamHadFirstRevive" ] );
    
    if ( var2 )
    {
        level.teamdata[ self.team ][ "teamHadFirstRevive" ] = 1;
    }
    
    foreach ( var4 in var0 )
    {
        if ( !isdefined( var4.endgame_finitewaves_music ) )
        {
            var4.endgame_finitewaves_music = 0;
        }
        
        var4.endgame_finitewaves_music++;
        var4 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "reviveCount", var4.endgame_finitewaves_music );
        end_health( var4 );
        var5 = !isdefined( var1 ) || var4 != var1;
        var6 = var2 && var5;
        
        if ( var6 )
        {
            var4 thread scripts\mp\hud_message::showsplash( "br_rebirth_first_revive" );
        }
    }
}

// Params 2
// Size: 0x2d
function enablejuggernautcrateobjective( var0, var1 )
{
    var2 = self;
    var2 thread scripts\mp\gametypes\br_gulag::playergulagautowin( var0, var1 );
    end_trans_1_obj( var2, level.teamdata[ var2.team ][ "alivePlayers" ], var0 );
}

// Params 1
// Size: 0xf6
function end_game_tutorial_func( var0 )
{
    if ( !istrue( level.br_prematchstarted ) )
    {
        return;
    }
    
    ref_121e7( var0 );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( var0.victim ) )
    {
        return;
    }
    
    thread end_freight_lift( var0.victim );
    
    if ( !isdefined( var0.victim.ref_1443b ) )
    {
        var0.victim.ref_1443b = [];
    }
    
    if ( !scripts\engine\utility::array_contains( var0.victim.ref_1443b, var0.attacker ) )
    {
        scripts\engine\utility::array_add( var0.victim.ref_1443b, var0.attacker );
    }
    
    if ( !isdefined( var0.attacker ) || !isplayer( var0.attacker ) || var0.attacker == var0.victim )
    {
        return;
    }
    
    thread endcameradebug_think( var0.attacker );
    thread endcameraorigins( var0.attacker );
    thread endcameraangles( var0.attacker );
}

// Params 1
// Size: 0x31
function endcameraangles( var0 )
{
    level endon( "game_ended" );
    
    if ( !level.disable_super_in_turret.ref_140a5 )
    {
        return;
    }
    
    if ( !istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        return;
    }
    
    empendearly( var0 );
}

// Params 1
// Size: 0x81
function empendearly( var0 )
{
    if ( self.ref_12ca1 <= 0 )
    {
        return;
    }
    
    if ( !isdefined( self.ref_1443b ) )
    {
        self.ref_1443b = [];
    }
    
    if ( isdefined( self.ref_1443b ) && scripts\engine\utility::array_contains( self.ref_1443b, var0 ) )
    {
        if ( istrue( level.disable_super_in_turret.ref_140a6 ) )
        {
            self.ref_12ca1 -= getdvarint( "scr_br_vengeance_decrease_respawn_delay", 5 );
            brrebirth_setrebirthrespawntimervengeanceflag();
            wait 1;
            brrebirth_resetrebirthrespawntimervengeanceflag();
        }
        
        scripts\engine\utility::array_remove( self.ref_1443b, var0 );
        thread scripts\mp\events::killeventtextpopup( "br_rebirth_vengeance", 0, 0 );
        return;
    }
}

// Params 1
// Size: 0x4f
function endcameraorigins( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var0 endon( "disconnect" );
    var0 endon( "squad_wiped" );
    
    if ( !level.disable_super_in_turret.ref_140a3 )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 waittill( "respawn_done" );
    end_silo_jump( self.team, var0.team );
}

// Params 1
// Size: 0x3b
function endcameradebug_think( var0 )
{
    var1 = self;
    
    if ( istrue( var0.delay_enter_combat_after_investigating_grenade ) )
    {
        var1 thread scripts\mp\events::killeventtextpopup( "enemy_wiped", 0 );
        var1 thread scripts\mp\utility\points::giveunifiedpoints( "enemy_wiped", var1.ref_145d0 );
        thread endac130infilanimsinternal( var1 );
        return;
    }
}

// Params 1
// Size: 0x3a
function endac130infilanimsinternal( var0 )
{
    var1 = scripts\mp\gametypes\br::brchooselaststandweapon();
    scripts\mp\gametypes\br::ref_13ad0( var0, self, var1 );
    var2 = [];
    
    if ( !isdefined( var2[ self.team ] ) )
    {
        GscBinSkip0( 0x2e, self.team, 1 );
        // Unknown operator ( 0x2e, iw8, PC )
    }
}

// Params 1
// Size: 0x49
function play_track_damage_screen_vfx( var0 )
{
    var1 = -1;
    var2 = 2147483647;
    
    foreach ( var4 in var0 )
    {
        if ( var4[ "startTime" ] < var2 )
        {
            var1 = var5;
            var2 = var4[ "startTime" ];
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x12
function getteamindex( var0 )
{
    return level.teamdata[ var0 ][ "index" ];
}

// Params 2
// Size: 0x3f
function start_reach_pipe_room( var0, var1 )
{
    var2 = -1;
    
    foreach ( var4 in var0 )
    {
        if ( var4[ "name" ] == var1 )
        {
            var2 = var5;
            break;
        }
    }
    
    return var2;
}

// Params 3
// Size: 0x3a
function ref_14023( var0, var1, var2 )
{
    var3 = int( pow( 2, 8 ) );
    var4 = 8 * var2;
    var5 = var3 - 1;
    var5 <<= var4;
    var6 = ~var5;
    var0 &= var6;
    var7 = var1 << var4;
    var0 |= var7;
    return var0;
}

// Params 3
// Size: 0x56
function ref_14029( var0, var1, var2 )
{
    var3 = -1;
    
    foreach ( var5 in var0 )
    {
        if ( isdefined( var5 ) )
        {
            if ( var3 < 0 )
            {
                var3 = var5 calloutmarkerping_entityzoffset( "rebirth_tracked_teams" );
                var3 = ref_14023( var3, var1, var2 );
            }
            
            var5 setclientomnvar( "rebirth_tracked_teams", var3 );
        }
    }
}

// Params 0
// Size: 0x41
function run_lbravo_spawner()
{
    var0 = getdvarint( "scr_br_tracked_teams_for_entire_team", 0 );
    var1 = [];
    
    if ( istrue( var0 ) )
    {
        var1 = scripts\mp\utility\teams::getteamdata( self.team, "trackedTeams" );
    }
    else
    {
        if ( !isdefined( self.ref_13c4b ) )
        {
            self.ref_13c4b = [];
        }
        
        var1 = self.ref_13c4b;
    }
    
    return var1;
}

// Params 2
// Size: 0x4e
function end_silo_jump( var0, var1 )
{
    var2 = -1;
    var3 = run_lbravo_spawner();
    var2 = start_reach_pipe_room( var3, var1 );
    
    if ( var2 < 0 )
    {
        if ( var3.size == 4 )
        {
            var2 = play_track_damage_screen_vfx( var3 );
        }
        else
        {
            var2 = var3.size;
        }
    }
    
    if ( var2 < 0 || var2 >= 4 )
    {
        return;
    }
    
    thread end_silo_elevator( var0, var1, var2 );
}

// Params 3
// Size: 0xbc
function end_silo_elevator( var0, var1, var2 )
{
    if ( var2 < 0 || var2 >= 4 )
    {
        return;
    }
    
    var3 = "trackTeam" + var0 + var2;
    var4 = [];
    var5 = [];
    GscBinSkip0( 0x2e, "name", var1 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x11b
function end_origin_final()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) == 0 )
    {
        level waittill( "infils_ready" );
    }
    
    var0 = rocket_attack_min_cooldown();
    var1 = 0;
    
    if ( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) )
    {
        var1 = 1;
    }
    
    for ( var2 = 0; var2 < var0 ; var2++ )
    {
        var1 += level.br_level.br_circleclosetimes[ var2 ] + level.br_level.br_circledelaytimes[ var2 ];
    }
    
    var3 = int( var1 * 1000 );
    var4 = gettime();
    var5 = var4 + var3;
    setomnvarforallclients( "ui_br_plunder_extract_end_time", var5 );
    level.ally_movement_defend_0 = var1;
    var6 = var3;
    var7 = getdvarint( "scr_br_rebirth_show_respawn_closed_timer_max_time", 90000 );
    thread end_mine_caves( var6 / 1000 );
    
    while ( var6 > var7 )
    {
        wait ( var6 - var7 ) / 1000;
        var8 = gettime() - var4;
        var6 = var3 - var8;
    }
    
    setomnvarforallclients( "ui_br_plunder_extract_end_time", int( gettime() + var6 ) );
    
    foreach ( var10 in level.players )
    {
        if ( !isdefined( var10 ) )
        {
            continue;
        }
        
        var10 thread scripts\mp\hud_message::showsplash( "br_rebirth_reinforcement_closing" );
    }
}

// Params 1
// Size: 0x14
function end_mine_caves( var0 )
{
    wait var0 - 90;
    scripts\mp\gametypes\br_public::brleaderdialog( "rebirth_ending" );
}

// Params 0
// Size: 0x93
function end_pipe_room()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.disable_super_in_turret.ref_12ca1 = [];
    level.disable_super_in_turret.ref_14093 = getdvarint( "scr_br_use_respawn_delay_per_circle", 1 );
    
    if ( level.disable_super_in_turret.ref_14093 )
    {
        var0 = rocket_attack_min_cooldown();
        
        for ( var1 = 0; var1 < var0 ; var1++ )
        {
            level.disable_super_in_turret.ref_12ca1[ var1 ] = getdvarint( "scr_br_rebirth_respawn_delay_circle" + var1 + 1, 30 );
        }
        
        return;
    }
    
    level.disable_super_in_turret.ref_12ca1[ 0 ] = getdvarint( "scr_br_rebirth_respawn_delay", 30 );
}

// Params 0
// Size: 0x20
function brrebirth_hiderebirthrespawntimer()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer_solo" );
    var1 = var0 & ~16384;
    self setclientomnvar( "ui_rebirthRespawnTimer_solo", var1 );
}

// Params 0
// Size: 0x1f
function brrebirth_showrebirthrespawntimer()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer_solo" );
    var1 = var0 | 16384;
    self setclientomnvar( "ui_rebirthRespawnTimer_solo", var1 );
}

// Params 0
// Size: 0x1f
function brrebirth_setrebirthrespawntimervengeanceflag()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer_solo" );
    var1 = var0 | 32768;
    self setclientomnvar( "ui_rebirthRespawnTimer_solo", var1 );
}

// Params 0
// Size: 0x20
function brrebirth_resetrebirthrespawntimervengeanceflag()
{
    var0 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer_solo" );
    var1 = var0 & ~32768;
    self setclientomnvar( "ui_rebirthRespawnTimer_solo", var1 );
}

// Params 1
// Size: 0x27
function brrebirth_setrebirthrespawntimervalue( var0 )
{
    var1 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer_solo" );
    var2 = var1 & ~16383;
    var3 = var2 | var0;
    self setclientomnvar( "ui_rebirthRespawnTimer_solo", var3 );
}

// Params 1
// Size: 0x4a
function brrebirth_setrebirthrespawntimerdeltavalue( var0 )
{
    var1 = self calloutmarkerping_entityzoffset( "ui_rebirthRespawnTimer_solo" );
    var2 = var1 & ~2147418112;
    var3 = var1 & 1073741824;
    
    if ( var3 != 0 )
    {
        var3 = 0;
    }
    else
    {
        var3 = 1073741824;
    }
    
    var4 = var2 | var0 << 16 | var3;
    self setclientomnvar( "ui_rebirthRespawnTimer_solo", var4 );
}

// Params 1
// Size: 0x6b, Type: bool
function carriable_init( var0 )
{
    var1 = scripts\mp\utility\teams::getteamdata( var0.team, "players" );
    
    foreach ( var3 in var1 )
    {
        var4 = var3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
        var5 = isalive( var3 ) && !istrue( var3.inlaststand );
        
        if ( var3 != var0 && var5 && !var4 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x5a
function end_ml_p3_exfil()
{
    var0 = self;
    
    if ( !isdefined( var0.gulaguses ) || var0.gulaguses == 0 )
    {
        end_trans_1_obj( var0, level.teamdata[ var0.team ][ "alivePlayers" ] );
        var0 scripts\mp\playerlogic::addtoalivecount();
        scripts\mp\gametypes\br::ref_13f21( var0 );
        scripts\mp\gametypes\br::dynamic_door( var0 );
        scripts\mp\gametypes\br_gulag::entergulag( var0 );
        self.waitingtospawn = 0;
        return;
    }
}

// Params 1
// Size: 0x70
function ref_121e7( var0 )
{
    if ( !isdefined( var0.victim ) || !isdefined( var0.attacker ) )
    {
        return;
    }
    
    if ( var0.victim == var0.attacker || !isplayer( var0.attacker ) )
    {
        return;
    }
    
    var1 = scripts\mp\utility\teams::getteamdata( var0.victim.team, "aliveCount" );
    
    if ( var1 == 0 )
    {
        var0.attacker scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "t_wipe" );
        return;
    }
}

// Params 4
// Size: 0x164
function end_game_win( var0, var1, var2, var3 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( !isalive( var0 ) )
    {
        return;
    }
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( isdefined( var2 ) && isdefined( var3 ) && var2 == "br_kioskBuy" && var3 == "br_team_revive" )
    {
        var4 = scripts\mp\utility\teams::getteamdata( var0.team, "aliveCount" );
        var5 = scripts\mp\utility\teams::getteamdata( var0.team, "teamCount" );
        var6 = var5 - var4;
        
        if ( var6 == 1 )
        {
            return;
        }
    }
    
    var7 = getdvarfloat( "scr_br_rebirth_points_to_second_ratio", 0.02 );
    var8 = getdvarint( "scr_br_rebirth_points_to_first_second_offset", 50 );
    var9 = int( floor( ( var1 + var8 ) * var7 ) );
    
    if ( isdefined( var2 ) )
    {
        if ( var2 == "br_kioskBuy" )
        {
            var10 = getdvarfloat( "scr_br_rebirth_points_to_second_kiosk_buy_ratio", 0.3 );
            var9 = int( ceil( var9 * var10 ) );
        }
        else if ( var2 == "kill" )
        {
            var9 = int( floor( ( 250 + var8 ) * var7 ) );
        }
        else if ( var2 == "br_cacheOpen" )
        {
            var9 = int( floor( ( 100 + var8 ) * var7 ) );
        }
    }
    
    if ( var9 <= 0 )
    {
        return;
    }
    
    if ( isdefined( var0.ref_12ca1 ) && var0.ref_12ca1 > 0 )
    {
        var0.ref_12ca1 = int( max( 0, var0.ref_12ca1 - var9 ) );
        
        if ( !isdefined( var0.ref_12ca3 ) )
        {
            var0.ref_12ca3 = 0;
        }
        
        var0.ref_12ca3 += var9;
        return;
    }
}

// Params 0
// Size: 0xd9
function endgame_camera()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var0 endon( "squad_wiped" );
    var0 endon( "respawn_disabled" );
    
    while ( var0.ref_12ca1 > 0 )
    {
        if ( var0.ref_12ca1 <= 5 )
        {
            var0 playsoundtoplayer( "ui_mp_resurgence_timer_quarter_sec", var0 );
        }
        else if ( var0.ref_12ca1 <= 10 )
        {
            var0 playsoundtoplayer( "ui_mp_resurgence_timer_half_sec", var0 );
        }
        else if ( var0.ref_12ca1 % 4 == 2 )
        {
            var0 playsoundtoplayer( "ui_mp_resurgence_timer", var0 );
        }
        else
        {
            var0 playsoundtoplayer( "ui_mp_resurgence_timer_tick", var0 );
        }
        
        brrebirth_setrebirthrespawntimervalue( var0, var0.ref_12ca1 );
        brrebirth_setrebirthrespawntimerdeltavalue( var0, var0.ref_12ca3 );
        var0.ref_12ca3 = 0;
        wait 1;
        var0.ref_12ca1--;
    }
    
    brrebirth_hiderebirthrespawntimer( var0 );
    var0 thread scripts\mp\hud_message::showsplash( "br_rebirth_respawn_active" );
}

// Params 0
// Size: 0xbf
function end_wave_spawn_ahead_of_completion()
{
    if ( !istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        return;
    }
    
    var0 = self;
    var0 endon( "squad_wiped" );
    var0 endon( "respawn_disabled" );
    var0 endon( "disconnect" );
    
    if ( getdvarint( "scr_br_rebirthDelayOverride", 0 ) != 0 )
    {
        var0.ref_12ca1 = getdvarint( "scr_br_rebirthDelayOverride", 0 );
    }
    else
    {
        var1 = int( min( level.br_circle.circleindex, level.disable_super_in_turret.ref_12ca1.size - 1 ) );
        var0.ref_12ca1 = level.disable_super_in_turret.ref_12ca1[ var1 ];
    }
    
    self waittill( "respawn_done" );
    brrebirth_setrebirthrespawntimervalue( var0, var0.ref_12ca1 );
    brrebirth_showrebirthrespawntimer( var0 );
    var0.ref_12ca3 = 0;
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    thread endgame_camera();
}

// Params 2
// Size: 0x54
function brrebirth_playerkilledspawn( var0, var1 )
{
    if ( !istrue( level.br_prematchstarted ) )
    {
        return undefined;
    }
    
    var2 = self;
    
    if ( istrue( var2.¯Ò"5‹Ø'ƒ˜w%B¸ð·E ) )
    {
        var2.alreadyaddedtoalivecount = 1;
        thread enable_oob_immunity_on_riders();
        thread end_wave_spawn_ahead_of_completion();
    }
    else
    {
        var0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator( var0, var1 );
    }
    
    var2.¯Ò"5‹Ø'ƒ˜w%B¸ð·E = undefined;
    return 1;
}

// Params 0
// Size: 0x223
function enable_oob_immunity_on_riders()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var0 notify( "doingRespawn" );
    
    if ( istrue( level.disable_super_in_turret.ref_12c91 ) )
    {
        var0 notify( "started_spawnPlayer" );
    }
    
    var1 = 0;
    
    if ( istrue( level.disable_super_in_turret.ref_12c92 ) )
    {
        var1 = var0 scripts\mp\gametypes\br_gulag::ref_126e8();
    }
    
    var2 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
    var3 = scripts\mp\gametypes\br_gulag::ref_125be( 0, var2 );
    
    if ( level.br_circle.circleindex < 2 )
    {
        var4 = getclosestpointonnavmesh( var3.origin );
        var5 = getdvarint( "scr_br_rebirth_respawn_distance", 2500 );
        
        if ( distance2d( var4, var3.origin ) > var5 )
        {
            var6 = getrandomnavpoint( var4, randomfloat( var5 ) );
            var3.origin = ( var6[ 0 ], var6[ 1 ], var3.origin[ 2 ] );
        }
    }
    
    if ( isdefined( self.lastdeathpos ) )
    {
        var5 = getdvarint( "scr_br_rebirth_respawn_distance", 2500 );
        var7 = var5 * var5;
        
        if ( distance2dsquared( self.lastdeathpos, var3.origin ) > var7 )
        {
            var8 = var3.origin - self.lastdeathpos;
            var8 = vectornormalize( var8 );
            var8 = ( var8[ 0 ] * var5, var8[ 1 ] * var5, var8[ 2 ] );
            var6 = ( self.lastdeathpos[ 0 ] + var8[ 0 ], self.lastdeathpos[ 1 ] + var8[ 1 ], var8[ 2 ] );
            var6 = getclosestpointonnavmesh( var6 );
            var3.origin = ( var6[ 0 ], var6[ 1 ], var3.origin[ 2 ] );
        }
    }
    
    if ( !scripts\mp\gametypes\br_gulag::set_relic_rocket_kill_ammo( var3.origin, var2 ) )
    {
        var9 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        var10 = scripts\mp\gametypes\br_circle::getsafecircleradius();
        var8 = var3.origin - var9;
        var8 = vectornormalize( var8 );
        var8 = ( var8[ 0 ] * var10, var8[ 1 ] * var10, var8[ 2 ] );
        var6 = var9 + var8;
        var3.origin = ( var6[ 0 ], var6[ 1 ], var3.origin[ 2 ] );
    }
    
    var11 = scripts\mp\gametypes\br_gulag::ref_1263e( var3 );
    self.forcespawnorigin = var11;
    
    if ( var1 )
    {
        var0 scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    }
    
    var12 = 1;
    var0 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    wait var12;
    brrebirth_showrebirthrespawntimer( var0 );
    var0 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
    var0 scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    var0 scripts\cp_mp\execution::_clearexecution();
    var0 scripts\mp\gametypes\br_pickups::initplayer();
    var0 scripts\mp\gametypes\br_spectate::ref_1252a();
    var0.respawningfromtoken = undefined;
    var0 thread scripts\mp\gametypes\br_gulag::ref_13dcb( 20 );
    end_loop_emp_spark_vfx( var0, var3, var11 );
}

// Params 0
// Size: 0xb, Type: bool
function end_silo_thrust()
{
    wait 0.5;
    return true;
}

// Params 2
// Size: 0x229
function end_loop_emp_spark_vfx( var0, var1 )
{
    level notify( "update_circle_hide" );
    
    if ( isdefined( self.oobimmunity ) )
    {
        scripts\mp\outofbounds::disableoobimmunity( self );
    }
    
    scripts\mp\gametypes\br::scriptednode( self );
    ref_12a7d();
    
    if ( !isdefined( var0 ) )
    {
        var0 = scripts\mp\gametypes\br_gulag::ref_125be();
    }
    
    var2 = var0.origin;
    var3 = var0.angles;
    var4 = var2;
    
    if ( isdefined( var1 ) )
    {
        var4 = var1;
    }
    
    scripts\mp\gametypes\br_gulag::set_scriptable_states();
    self setorigin( var4, 1 );
    self setplayerangles( var3 );
    var5 = spawn( "script_model", var4 );
    var5 setmodel( "tag_origin" );
    var5.angles = var3;
    var5 hide();
    var5 showtoplayer( self );
    self playerlinktoabsolute( var5, "tag_origin" );
    self playerhide();
    thread scripts\mp\gametypes\br_gulag::ref_12524( var5 );
    waitframe();
    ref_1264e();
    
    if ( getdvarint( "scr_skip_respawn_gate", 1 ) == 0 )
    {
        scripts\mp\gametypes\br_public::ref_126ed();
    }
    
    scripts\mp\gametypes\br_public::ref_1252b();
    
    if ( isdefined( var1 ) )
    {
        var5.origin = var2;
    }
    
    var5 playsoundtoplayer( "br_ac130_flyby", self );
    wait 1.5;
    self unlink();
    self clearsoundsubmix( "deaths_door_mp" );
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        self clearsoundsubmix( "iw8_br_gulag_tutorial", 2 );
    }
    else
    {
        self clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 2 );
    }
    
    self clearclienttriggeraudiozone( 1 );
    self playershow();
    ref_12677( 1 );
    var6 = 0;
    
    if ( isdefined( level.ref_121cc ) )
    {
        var6 = level.ref_121cc;
    }
    
    if ( !scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        thread scripts\cp_mp\parachute::startfreefall( var6, 0, undefined, undefined, 1 );
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        self setclientomnvar( "ui_show_spectateHud", -1 );
    }
    
    scripts\mp\gametypes\br_gulag::ref_12c7a();
    scripts\mp\gametypes\br_armor::searchcirclesize();
    scripts\mp\gametypes\br_quest_util::ref_12072();
    scripts\mp\gametypes\br_rewards::ref_12072();
    wait 0.5;
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        thread scripts\mp\gametypes\br_gulag::ref_12523();
    }
    
    waitframe();
    var5 delete();
    
    if ( istrue( level.ref_133ef ) )
    {
        scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused( 1 );
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        self notify( "respawn_from_gulag" );
    }
    
    self notify( "can_show_splashes" );
    
    if ( istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        if ( !istrue( level.stage ) )
        {
            thread scripts\mp\hud_message::showsplash( "br_rebirth_redeploy", 20 );
        }
        
        if ( !istrue( self.player_deposited_heli ) )
        {
            thread scripts\mp\hud_message::showsplash( "br_rebirth_survive_countdown" );
            self.player_deposited_heli = 1;
        }
    }
    else
    {
        scripts\mp\gametypes\br_killstreaks::isbrsquadleader( self, "respawn_disabled", undefined, 2 );
    }
    
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "rebirth_redeploy", self );
    self notify( "respawn_done" );
}

// Params 0
// Size: 0x2f
function ref_1264e()
{
    self notify( "rebirthRespawn" );
    self.health = self.maxhealth;
    scripts\mp\healthoverlay::onexitdeathsdoor( 1 );
    scripts\mp\utility\player::enableplayerforspawnlogic( 0 );
    scripts\mp\gametypes\br_public::updatebrscoreboardstat( "isRespawning", 0 );
}

// Params 0
// Size: 0x22
function ref_12a7d()
{
    if ( isdefined( level.deletescriptableinstanceaftertime ) || getdvarint( "scr_br_fc_loadouts", 1 ) != 0 )
    {
        self.set_shouldrespawn = 1;
        return;
    }
}

// Params 1
// Size: 0x1e
function ref_12677( var0 )
{
    if ( var0 )
    {
        self enableoffhandweapons();
        self enableusability();
        return;
    }
    
    self disableoffhandweapons();
    self disableusability();
}

// Params 0
// Size: 0x68
function enable_spawner()
{
    var0 = level.deletescriptableinstanceaftertime;
    
    if ( isdefined( level.ref_12a7d ) )
    {
        var1 = 0;
        
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            var1 = min( level.br_circle.circleindex, level.ref_12a7d.size );
            var1 = int( var1 );
        }
        
        if ( isdefined( level.±¬{@NÃ»@Kw9è›C#*n0[ var1 ] ) )
        {
            var0 = level.ref_12a7d[ var1 ][ level.±¬{@NÃ»@Kw9è›C#*n0[ var1 ] ];
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x44
function enable_spawner_after_vehicle_death()
{
    var0 = 0;
    
    if ( isdefined( level.ref_12a7d ) )
    {
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            if ( level.br_circle.circleindex == level.ref_12a7d.size - 1 )
            {
                var0 = 1;
            }
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x80, Type: bool
function end_intro_obj()
{
    level.deletescriptableinstanceaftertime = enable_spawner();
    var0 = enable_spawner_after_vehicle_death();
    scripts\mp\gametypes\br::searchcircleorigin( 0, 1, var0 );
    
    if ( isdefined( level.obit_activation ) && level.obit_activation.ref_129da == 1 )
    {
        scripts\mp\gametypes\br::disablearmorykiosk();
    }
    
    if ( !isdefined( self.player_enable_invulnerability ) )
    {
        self.player_enable_invulnerability = 1;
        var1 = getdvarint( "scr_br_give_self_revive_on_spawn", 1 );
        
        if ( var1 )
        {
            scripts\mp\gametypes\br_pickups::bdroppingshield( 1 );
        }
    }
    else
    {
        var1 = getdvarint( "scr_br_give_self_revive_on_respawn", 0 );
        
        if ( var1 )
        {
            scripts\mp\gametypes\br_pickups::bdroppingshield( 1 );
        }
    }
    
    return false;
}

// Params 1
// Size: 0x44
function empdrone_killstreaktargetthink( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1.ref_12ca1 ) )
    {
        var1.ref_12ca1 = 0;
    }
    
    if ( var1.ref_12ca1 > 0 || !istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        var0 = var1.watch_for_attack;
        return;
    }
}

// Params 0
// Size: 0xd
function rocket_attack_min_cooldown()
{
    return getdvarint( "scr_br_rebirth_stop_respawn_circle_index", 3 );
}

// Params 1
// Size: 0x26
function circletimer( var0 )
{
    if ( istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        var1 = rocket_attack_min_cooldown();
        
        if ( var0 >= var1 )
        {
            loadoutcustomperkdiscount();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x6b
function loadoutcustomperkdiscount()
{
    level.disable_super_in_turret.ref_12ca4 = 0;
    
    foreach ( var1 in level.players )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        scripts\mp\gametypes\br_killstreaks::isbrsquadleader( var1, "respawn_disabled", undefined, 2 );
        var1 setclientomnvar( "ui_br_plunder_extract_end_time", 0 );
        var1 notify( "respawn_disabled" );
    }
    
    scripts\mp\gametypes\br_public::brleaderdialog( "rebirth_disabled" );
}

// Params 1
// Size: 0xaa
function timeoutonabandoneddelay( var0 )
{
    if ( !isdefined( level.ref_12a7d ) )
    {
        level.ref_12a7d = [];
    }
    
    var1 = level.ref_12a7d.size;
    var2 = tablelookupgetnumcols( var0 ) - 1;
    level.ref_12a7d[ var1 ] = [];
    
    for ( var3 = 0; var3 < var2 ; var3++ )
    {
        level.ref_12a7d[ var1 ][ level.ref_12a7d[ var1 ].size ] = init_structs_mp_don3( var3, var0 );
    }
    
    level.±¬{@NÃ»@Kw9è›C#*n0 = [];
    
    foreach ( var6, var5 in level.ref_12a7d )
    {
        if ( isdefined( level.ref_12a7d[ var6 ] ) && level.ref_12a7d[ var6 ].size > 0 )
        {
            level.±¬{@NÃ»@Kw9è›C#*n0[ var6 ] = randomintrange( 0, level.ref_12a7d[ var6 ].size );
        }
    }
}

// Params 2
// Size: 0x24c
function init_structs_mp_don3( var0, var1 )
{
    GscBinSkip1( 0x45, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 0
// Size: 0x3a
function tomastrike_findoptimallaunchpos()
{
    if ( !istrue( level.disable_super_in_turret.ref_14094 ) )
    {
        return;
    }
    
    if ( !isdefined( level.disable_super_in_turret.ref_1452e ) )
    {
        level.disable_super_in_turret.ref_1452e = [ 60, 30 ];
    }
    
    thread ref_14013();
}

// Params 0
// Size: 0xa2
function ref_14013()
{
    level endon( "game_ended" );
    var0 = 0;
    level.disable_super_in_turret.ref_1452f = level.disable_super_in_turret.ref_1452e[ var0 ];
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level waittill( "infils_ready" );
    
    while ( level.disable_super_in_turret.ref_12ca4 )
    {
        while ( level.disable_super_in_turret.ref_1452f > 0 )
        {
            wait 1;
            level.disable_super_in_turret.ref_1452f--;
        }
        
        wait 1;
        var0 = int( min( var0 + 1, level.disable_super_in_turret.ref_1452e.size - 1 ) );
        level.disable_super_in_turret.ref_1452f = level.disable_super_in_turret.ref_1452e[ var0 ];
    }
}

// Params 0
// Size: 0x42
function enable_leaderboard()
{
    var0 = ( level.br_level.default_class_chosen[ 1 ][ 0 ], level.br_level.default_class_chosen[ 1 ][ 1 ], 0 );
    var1 = level.br_level.br_circleradii[ 1 ];
    var2 = scripts\mp\gametypes\br_c130::createtestc130path( var0, var1 );
    return var2;
}

// Params 0
// Size: 0x8
function emp_target_monitor()
{
    thread enablefeature();
}

// Params 0
// Size: 0x9e
function enablefeature()
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

// Params 0
// Size: 0x2f
function end_nuke_vault()
{
    var0 = -15;
    var1 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player( 1 );
    var2 = max( 0, var1 + var0 );
    var3 = getdvarfloat( "scr_br_dropbag_delay", var2 );
    scripts\mp\gametypes\br_gametypes::ref_12b10( "dropBagDelay", var3 );
}

